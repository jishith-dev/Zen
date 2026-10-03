#!/usr/bin/env node
// Zen language server.
//
// Features: diagnostics, completion, hover, signature help, go to definition
// (incl. imported files), find references, document highlight, rename,
// document symbols, workspace symbols, folding ranges.
//
// Builtin docs come from src/config/info_config.js (same source as `zen info`).
// Debug: ZEN_LSP_DEBUG=1 prints trace lines to stderr.

import fs from "fs";
import path from "path";
import { fileURLToPath, pathToFileURL } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const COMPILER_ROOT = path.resolve(__dirname, "..");

const DEBUG = !!process.env.ZEN_LSP_DEBUG;
const trace = (...a) => DEBUG && process.stderr.write(`[zen-lsp] ${a.join(" ")}\n`);

let IRBuilder, Lexer, Parser, Lint;
let KEYWORDS, TYPES, ParserTypes, HINTS;
let INFO, formatSignature;
let KEYWORD_WORDS = new Set();

const has = (obj, key) => Object.prototype.hasOwnProperty.call(obj, key);

const load = (rel) => import(pathToFileURL(path.join(COMPILER_ROOT, rel)).href);

async function loadDeps() {
  ({ IRBuilder } = await load("src/codegen/helper/helper.js"));
  ({ Lexer } = await load("src/lexer/lexer.js"));
  ({ Parser } = await load("src/parser/parser.js"));
  ({ Lint } = await load("tooling/lint/lint.js"));

  const config = await load("src/config/config.js");
  const info = await load("src/config/info_config.js");

  KEYWORDS = config.KEYWORDS;
  TYPES = config.TYPES;
  ParserTypes = config.ParserTypes;
  HINTS = config.hints ?? {};

  INFO = info.BUILTIN_INFO;
  formatSignature = info.formatSignature;

  KEYWORD_WORDS = new Set(KEYWORDS.flatMap((k) => k.split(/\s+/)));
}

// JSON-RPC transport

function readMessages(onMessage) {
  let buffer = Buffer.alloc(0);

  process.stdin.on("data", (chunk) => {
    buffer = Buffer.concat([buffer, chunk]);

    while (true) {
      const headerEnd = buffer.indexOf("\r\n\r\n");
      if (headerEnd === -1) break;

      const header = buffer.slice(0, headerEnd).toString("utf8");
      const match = /Content-Length:\s*(\d+)/i.exec(header);

      if (!match) {
        buffer = buffer.slice(headerEnd + 4);
        continue;
      }

      const length = parseInt(match[1], 10);
      const bodyStart = headerEnd + 4;

      if (buffer.length < bodyStart + length) break;

      const body = buffer.slice(bodyStart, bodyStart + length).toString("utf8");
      buffer = buffer.slice(bodyStart + length);

      try {
        onMessage(JSON.parse(body));
      } catch (err) {
        trace("bad message:", err?.message);
      }
    }
  });

  process.stdin.on("end", () => process.exit(shuttingDown ? 0 : 1));
}

function send(msg) {
  const json = JSON.stringify(msg);
  process.stdout.write(
    `Content-Length: ${Buffer.byteLength(json, "utf8")}\r\n\r\n${json}`
  );
}

const reply = (id, result) => send({ jsonrpc: "2.0", id, result: result ?? null });
const replyError = (id, code, message) =>
  send({ jsonrpc: "2.0", id, error: { code, message } });
const notify = (method, params) => send({ jsonrpc: "2.0", method, params });

// Documents

const docs = new Map(); // uri -> doc
const docState = new Map(); // uri - { local, symbols }
const extCache = new Map(); // file path - { mtime, doc, symbols }
const workspaceRoots = [];

// Blank out comments and string contents (same length, newlines kept), so
// scans never match inside them.
function maskSource(text) {
  const out = text.split("");
  const n = text.length;
  const blank = (from, to) => {
    for (let k = from; k < to; k++) {
      if (out[k] !== "\n" && out[k] !== "\r") out[k] = " ";
    }
  };

  let i = 0;

  while (i < n) {
    const ch = text[i];
    const nx = text[i + 1];

    if (ch === "/" && nx === "/") {
      let j = i;
      while (j < n && text[j] !== "\n") j++;
      blank(i, j);
      i = j;
      continue;
    }

    if (ch === "/" && nx === "*") {
      let j = text.indexOf("*/", i + 2);
      j = j === -1 ? n : j + 2;
      blank(i, j);
      i = j;
      continue;
    }

    if (ch === '"' || ch === "`") {
      let j = i + 1;

      while (j < n && text[j] !== ch) {
        if (text[j] === "\\") j++;
        if (ch === '"' && text[j] === "\n") break;
        j++;
      }

      blank(i + 1, Math.min(j, n));
      i = j + 1;
      continue;
    }

    i++;
  }

  return out.join("");
}

function makeDoc(uri, text) {
  const lineStarts = [0];

  for (let i = 0; i < text.length; i++) {
    if (text.charCodeAt(i) === 10) lineStarts.push(i + 1);
  }

  return {
    uri,
    text,
    masked: maskSource(text),
    lineStarts,
    _idents: null,
    _structs: null,
    _enums: null,
  };
}

function lineEnd(doc, line) {
  const next = doc.lineStarts[line + 1];
  let end = next === undefined ? doc.text.length : next - 1;
  if (end > 0 && doc.text[end - 1] === "\r") end--;
  return end;
}

function offsetAt(doc, pos) {
  const line = Math.max(0, Math.min(pos.line, doc.lineStarts.length - 1));
  const start = doc.lineStarts[line];
  return Math.min(start + Math.max(0, pos.character), lineEnd(doc, line));
}

function positionAt(doc, offset) {
  let lo = 0;
  let hi = doc.lineStarts.length - 1;

  while (lo < hi) {
    const mid = (lo + hi + 1) >> 1;
    if (doc.lineStarts[mid] <= offset) lo = mid;
    else hi = mid - 1;
  }

  return { line: lo, character: offset - doc.lineStarts[lo] };
}

const rangeOf = (doc, start, end) => ({
  start: positionAt(doc, start),
  end: positionAt(doc, end),
});

const identRange = (doc, id) => rangeOf(doc, id.start, id.end);

function lineText(doc, line) {
  if (line < 0 || line >= doc.lineStarts.length) return "";
  return doc.text.slice(doc.lineStarts[line], lineEnd(doc, line));
}

// every identifier outside comments/strings
function identsOf(doc) {
  if (doc._idents) return doc._idents;

  const re = /(?<![A-Za-z0-9_])[A-Za-z_][A-Za-z0-9_]*/g;
  const list = [];
  const m = doc.masked;
  let r;

  while ((r = re.exec(m))) {
    const start = r.index;
    const end = start + r[0].length;
    const pos = positionAt(doc, start);

    let p = start - 1;
    while (p >= 0 && /\s/.test(m[p])) p--;

    list.push({
      name: r[0],
      start,
      end,
      line: pos.line,
      col: pos.character,
      afterDot: p >= 0 && m[p] === "." && m[p - 1] !== ".",
    });
  }

  return (doc._idents = list);
}

function identAt(doc, offset) {
  const list = identsOf(doc);
  return list.find((i) => i.start <= offset && offset <= i.end) ?? null;
}

function nextNonSpace(masked, from) {
  let i = from;
  while (i < masked.length && /\s/.test(masked[i])) i++;
  return masked[i] ?? "";
}

function precededBy(doc, id, keyword) {
  const before = doc.masked.slice(Math.max(0, id.start - 40), id.start);
  return new RegExp(`(?<![A-Za-z0-9_])${keyword}\\s+$`).test(before);
}

function matchBrace(masked, open) {
  let depth = 0;

  for (let i = open; i < masked.length; i++) {
    if (masked[i] === "{") depth++;
    else if (masked[i] === "}") {
      depth--;
      if (depth === 0) return i;
    }
  }

  return masked.length;
}

// struct / enum bodies: [{ name, open, close, startLine, endLine }]
function blockRanges(doc, keyword) {
  const cacheKey = keyword === "struct" ? "_structs" : "_enums";
  if (doc[cacheKey]) return doc[cacheKey];

  const re = new RegExp(
    `(?<![A-Za-z0-9_])${keyword}\\s+([A-Za-z_][A-Za-z0-9_]*)`,
    "g"
  );
  const ranges = [];
  let m;

  while ((m = re.exec(doc.masked))) {
    const after = m.index + m[0].length;
    const open = doc.masked.indexOf("{", after);
    if (open === -1) continue;
    if (/[;()]/.test(doc.masked.slice(after, open))) continue;

    const close = matchBrace(doc.masked, open);

    ranges.push({
      name: m[1],
      open,
      close,
      startLine: positionAt(doc, m.index).line,
      endLine: positionAt(doc, close).line,
    });
  }

  return (doc[cacheKey] = ranges);
}

const structRangeByName = (doc, name) =>
  blockRanges(doc, "struct").find((r) => r.name === name) ?? null;

const enclosingStruct = (doc, offset) =>
  blockRanges(doc, "struct").find((r) => offset > r.open && offset < r.close) ??
  null;

// code position check: false inside comments and strings
function inNonCode(doc, offset) {
  if (offset <= 0) return false;
  const a = doc.text[offset - 1];
  return doc.masked[offset - 1] !== a && !/\s/.test(a);
}

// Symbols (from the compiler AST)

const typeStr = (t) => {
  if (t == null) return "auto";
  if (typeof t === "string") return t;
  return String(t.name ?? t.value ?? t.type ?? "auto");
};

const stripGenerics = (t) => typeStr(t).replace(/<.*$/, "").trim();

function emptySymbols() {
  return {
    functions: new Map(),
    variables: new Map(),
    structs: new Map(),
    enums: new Map(),
    topVars: new Set(),
  };
}

function collectSymbols(ast) {
  const sym = emptySymbols();
  const { functions, variables, structs, enums } = sym;

  const paramsOf = (node) =>
    (node.params || []).map((p) => ({
      name: p.name,
      dataType: typeStr(p.dataType || p.type),
    }));

  function visitFn(node, ofStruct) {
    const info = {
      params: paramsOf(node),
      returnType: typeStr(node.returnType || "void"),
      line: node.line,
    };

    if (ofStruct) ofStruct.methods.set(node.name, info);
    else functions.set(node.name, info);

    for (const p of node.params || []) {
      variables.set(p.name, {
        dataType: typeStr(p.dataType || p.type),
        line: node.line,
        isParam: true,
      });
    }

    if (node.body) walk(node.body);
  }

  function walk(node) {
    if (!node) return;

    if (Array.isArray(node)) {
      for (const n of node) walk(n);
      return;
    }

    switch (node.type) {
      case ParserTypes.VARIABLE_DECLARATION:
      case ParserTypes.MAP_DECLARATION:
        variables.set(node.name, {
          dataType: typeStr(node.dataType || node.struct_ref),
          line: node.line,
        });
        walk(node.value);
        return;

      case ParserTypes.FUNCTION_DECLARATION:
        visitFn(node, null);
        return;

      case ParserTypes.STRUCT: {
        const entry = {
          fields: (node.fields || []).map((f) => ({
            name: f.name,
            dataType: typeStr(f.dataType || f.type),
            line: f.line,
          })),
          methods: new Map(),
          line: node.line,
        };

        structs.set(node.name, entry);

        for (const method of node.methods || []) visitFn(method, entry);
        return;
      }

      case ParserTypes.ENUM:
        enums.set(node.name, {
          members: (node.members || []).map((m) => m.name),
          line: node.line,
        });
        return;

      case ParserTypes.EXPORT:
        for (const value of Object.values(node)) {
          if (value && typeof value === "object") walk(value);
        }
        return;

      case ParserTypes.BLOCK:
        walk(node.body);
        return;

      case ParserTypes.CONDITIONAL:
        walk(node.if?.body);
        for (const b of node.elseIf || []) walk(b.body);
        if (node.else) walk(node.else.body);
        return;

      case ParserTypes.WHILE:
      case ParserTypes.DO_WHILE:
      case ParserTypes.LOOP:
      case ParserTypes.LOOP_IN:
      case ParserTypes.LOOP_OF:
        walk(node.body);
        return;

      case ParserTypes.SWITCH:
        for (const c of node.cases || []) walk(c.statements);
        if (node.defaultCase) walk(node.defaultCase.statements);
        return;

      default:
        return;
    }
  }

  const top = Array.isArray(ast) ? ast : ast?.body ?? [ast];

  for (const item of top) {
    if (
      item?.type === ParserTypes.VARIABLE_DECLARATION ||
      item?.type === ParserTypes.MAP_DECLARATION
    ) {
      sym.topVars.add(item.name);
    }
  }

  walk(top);

  return sym;
}

function guardExit(fn) {
  const originalExit = process.exit;

  process.exit = (code) => {
    throw { __lspGuardExit: true, code };
  };

  try {
    return fn();
  } finally {
    process.exit = originalExit;
  }
}

function parseSource(text) {
  const irb = new IRBuilder("lsp_doc");
  const tokens = new Lexer(text, irb).tokenize();
  const ast = new Parser(tokens, irb).parse();

  return { irb, ast };
}

// symbols only, used for imported files and workspace indexing
function parseSymbolsOnly(text) {
  try {
    return guardExit(() => {
      const { irb, ast } = parseSource(text);

      if (Array.isArray(irb.errors) && irb.errors.length > 0) return null;
      return ast ? collectSymbols(ast) : null;
    });
  } catch {
    return null;
  }
}

// Imports

function parseImports(doc) {
  const out = [];
  const re = /import\s*\(([^)]*)\)\s*from\s*"([^"]+)"/g;
  let m;

  while ((m = re.exec(doc.text))) {
    if (doc.masked.slice(m.index, m.index + 6) !== "import") continue;

    const names = m[1]
      .split(",")
      .map((s) => s.trim())
      .filter(Boolean)
      .map((s) => {
        const [orig, alias] = s.split(/\s+as\s+/);
        return { name: orig.trim(), local: (alias || orig).trim() };
      });

    out.push({ spec: m[2], names });
  }

  return out;
}

function resolveImportFile(uri, spec) {
  let base;

  try {
    base = path.dirname(fileURLToPath(uri));
  } catch {
    return null;
  }

  const candidates = [path.resolve(base, spec), path.resolve(base, `${spec}.zen`)];

  return candidates.find((f) => fs.existsSync(f) && fs.statSync(f).isFile()) ?? null;
}

function externalFor(file) {
  const uri = pathToFileURL(file).href;

  if (docs.has(uri) && docState.has(uri)) {
    return { doc: docs.get(uri), symbols: docState.get(uri).local };
  }

  let st;

  try {
    st = fs.statSync(file);
  } catch {
    return null;
  }

  const cached = extCache.get(file);
  if (cached && cached.mtime === st.mtimeMs) return cached;

  const text = fs.readFileSync(file, "utf8");
  const symbols = parseSymbolsOnly(text);
  const entry = { mtime: st.mtimeMs, doc: makeDoc(uri, text), symbols: symbols ?? emptySymbols() };

  extCache.set(file, entry);
  return entry;
}

function mergeImports(doc, local) {
  const merged = {
    functions: new Map(local.functions),
    variables: new Map(local.variables),
    structs: new Map(local.structs),
    enums: new Map(local.enums),
    topVars: local.topVars,
  };

  for (const imp of parseImports(doc)) {
    const file = resolveImportFile(doc.uri, imp.spec);
    const ext = file && externalFor(file);
    if (!ext) continue;

    const origin = { uri: ext.doc.uri, doc: ext.doc };

    for (const { name, local: localName } of imp.names) {
      const s = ext.symbols;

      if (s.functions.has(name)) {
        merged.functions.set(localName, { ...s.functions.get(name), origin, originalName: name });
      }
      if (s.structs.has(name)) {
        merged.structs.set(localName, { ...s.structs.get(name), origin, originalName: name });
      }
      if (s.enums.has(name)) {
        merged.enums.set(localName, { ...s.enums.get(name), origin, originalName: name });
      }
    }
  }

  return merged;
}

const getSymbols = (uri) => docState.get(uri)?.symbols ?? emptySymbols();

// Diagnostics

function withHint(message) {
  for (const list of Object.values(HINTS)) {
    for (const { match, hint } of list) {
      if (match.test(message)) return `${message}\nHint: ${hint}`;
    }
  }

  return message;
}

function toDiagnostic(doc, message, line, column, severity) {
  const l = Math.max((line || 1) - 1, 0);
  const c = Math.max((column || 1) - 1, 0);

  const text = lineText(doc, l);
  const ident = identsOf(doc).find((i) => i.line === l && i.col <= c && c <= i.col + i.name.length);
  const end = ident ? ident.col + ident.name.length : Math.min(c + 1, Math.max(text.length, c + 1));

  return {
    range: { start: { line: l, character: c }, end: { line: l, character: Math.max(end, c + 1) } },
    severity,
    source: "zen",
    message: withHint(String(message)),
  };
}

function analyze(doc) {
  const diagnostics = [];
  let ast = null;

  try {
    guardExit(() => {
      const parsed = parseSource(doc.text);
      const { irb } = parsed;

      if (Array.isArray(irb.errors) && irb.errors.length > 0) {
        for (const e of irb.errors) {
          diagnostics.push(toDiagnostic(doc, e.message, e.line, e.column, 1));
        }
        return;
      }

      ast = parsed.ast;

      const { errors, warnings } = new Lint(ast).run();

      for (const e of errors) diagnostics.push(toDiagnostic(doc, e.message, e.line, e.column, 1));
      for (const w of warnings) diagnostics.push(toDiagnostic(doc, w.message, w.line, w.column, 2));
    });
  } catch (err) {
    if (err && err.__lspGuardExit) {
      diagnostics.push(toDiagnostic(doc, "Syntax error (parsing aborted)", 1, 1, 1));
    } else {
      diagnostics.push(toDiagnostic(doc, `Internal error: ${err?.message || err}`, 1, 1, 1));
    }
  }

  // keep the last good symbols while the file is temporarily broken
  if (ast) {
    try {
      const local = collectSymbols(ast);
      docState.set(doc.uri, { local, symbols: mergeImports(doc, local) });
    } catch (err) {
      trace("symbol error:", err?.stack || err);
    }
  }

  return diagnostics;
}

function publishDiagnostics(uri) {
  const doc = docs.get(uri);
  if (!doc) return;

  notify("textDocument/publishDiagnostics", { uri, diagnostics: analyze(doc) });
}

const timers = new Map();

function scheduleDiagnostics(uri, delay = 200) {
  clearTimeout(timers.get(uri));

  timers.set(
    uri,
    setTimeout(() => {
      timers.delete(uri);
      publishDiagnostics(uri);
    }, delay)
  );
}

// Resolution: chains, members, free names

const displayType = (t) => (t === "ptr" ? "string" : typeStr(t));

function userCallable(info) {
  return {
    description: "",
    parameters: info.params.map((p) => ({ name: p.name, type: displayType(p.dataType) })),
    returnType: displayType(info.returnType),
  };
}

function structInfo(typeName, symbols) {
  if (!typeName) return null;

  const user = symbols.structs.get(typeName);

  if (user) {
    const methods = new Map();

    for (const [n, m] of user.methods) {
      methods.set(n, { ...userCallable(m), line: m.line, user: true });
    }

    const fields = new Map(
      user.fields.map((f) => [f.name, { type: displayType(f.dataType), line: f.line, user: true }])
    );

    return { name: typeName, builtin: false, description: "", methods, fields, user };
  }

  if (has(INFO.structs, typeName)) {
    const s = INFO.structs[typeName];

    return {
      name: typeName,
      builtin: true,
      description: s.description,
      methods: new Map(Object.entries(s.methods ?? {})),
      fields: new Map(
        Object.entries(s.properties ?? {}).map(([n, p]) => [n, { type: p.type, description: p.description }])
      ),
    };
  }

  return null;
}

// Resolve a dotted chain of names (a.b.c). Returns one of:
//   { kind: "namespace", name }
//   { kind: "type", struct }          (static access, e.g. Json.parse)
//   { kind: "enum", name, info }
//   { kind: "value", type }           (instance; type may be null)
function resolveChain(segments, doc, offset) {
  const symbols = getSymbols(doc.uri);
  const first = segments[0];
  let cur = null;

  if (first === "this") {
    const range = enclosingStruct(doc, offset);
    cur = range ? { kind: "value", type: range.name } : null;
  } else if (symbols.variables.has(first)) {
    const t = stripGenerics(symbols.variables.get(first).dataType);
    cur = { kind: "value", type: t === "auto" ? null : t };
  } else if (has(INFO.namespaces, first)) {
    cur = { kind: "namespace", name: first };
  } else if (structInfo(first, symbols)) {
    cur = { kind: "type", struct: structInfo(first, symbols) };
  } else if (symbols.enums.has(first)) {
    cur = { kind: "enum", name: first, info: symbols.enums.get(first) };
  }

  for (let i = 1; i < segments.length && cur; i++) {
    const name = segments[i];

    if (cur.kind !== "value" && cur.kind !== "type") return null;

    const s = cur.kind === "type" ? cur.struct : structInfo(cur.type, symbols);
    const field = s?.fields.get(name);

    if (!field) return null;

    const t = stripGenerics(field.type);
    cur = { kind: "value", type: t === "auto" ? null : t };
  }

  return cur;
}

function chainBefore(doc, identStart) {
  const slice = doc.masked.slice(Math.max(0, identStart - 300), identStart);
  const m = /([A-Za-z_]\w*(?:\s*\.\s*[A-Za-z_]\w*)*)\s*\.\s*$/.exec(slice);

  return m ? m[1].split(".").map((s) => s.trim()) : null;
}

// what `name` is on a resolved receiver
function memberOf(res, name, symbols) {
  if (!res) return null;

  if (res.kind === "namespace") {
    const fn = INFO.namespaces[res.name].functions[name];
    return has(INFO.namespaces[res.name].functions, name)
      ? { type: "callable", name, callable: fn, prefix: `${res.name}.` }
      : null;
  }

  if (res.kind === "enum") {
    return res.info.members.includes(name)
      ? { type: "enumMember", name, enumName: res.name }
      : null;
  }

  const s = res.kind === "type" ? res.struct : structInfo(res.type, symbols);
  if (!s) return null;

  if (s.methods.has(name)) {
    return { type: "callable", name, callable: s.methods.get(name), prefix: `${s.name}.`, struct: s };
  }

  if (s.fields.has(name)) {
    return { type: "field", name, field: s.fields.get(name), struct: s };
  }

  return null;
}

function resolveFree(name, symbols) {
  if (symbols.variables.has(name)) return { kind: "variable", info: symbols.variables.get(name) };
  if (symbols.functions.has(name)) return { kind: "function", info: symbols.functions.get(name) };
  if (symbols.structs.has(name)) return { kind: "struct", info: symbols.structs.get(name) };
  if (symbols.enums.has(name)) return { kind: "enum", info: symbols.enums.get(name) };
  if (has(INFO.namespaces, name)) return { kind: "namespace", info: INFO.namespaces[name] };
  if (has(INFO.structs, name)) return { kind: "builtinStruct", info: INFO.structs[name] };
  if (has(INFO.global_fn, name)) return { kind: "globalFn", info: INFO.global_fn[name] };
  if (has(INFO.constants, name)) return { kind: "constant", info: INFO.constants[name] };
  if (TYPES.includes(name) || name === "List") return { kind: "type" };
  if (KEYWORD_WORDS.has(name)) return { kind: "keyword" };
  return null;
}

// Hover

const fence = (code) => "```zen\n" + code + "\n```";

function callableMarkdown(name, callable, prefix = "") {
  let md = fence(formatSignature(name, callable, prefix));

  if (callable.description) md += `\n${callable.description}`;
  if (callable.static) md += "\n\n_static_";

  return md;
}

function structMarkdown(name, s) {
  const lines = [];

  for (const [n, f] of s.fields) lines.push(`  ${f.type} ${n}`);
  for (const [n, m] of s.methods) lines.push(`  ${formatSignature(n, m)}`);

  let md = fence(`struct ${name} {\n${lines.join("\n")}\n}`);
  if (s.description) md += `\n${s.description}`;

  return md;
}

function originNote(info) {
  return info.origin ? `\nImported from \`${path.basename(info.origin.uri)}\`` : "";
}

function hoverMarkdown(doc, offset) {
  const id = identAt(doc, offset);
  if (!id) return null;

  const symbols = getSymbols(doc.uri);

  if (id.afterDot) {
    const chain = chainBefore(doc, id.start);
    if (!chain) return null;

    const m = memberOf(resolveChain(chain, doc, id.start), id.name, symbols);
    if (!m) return null;

    if (m.type === "callable") {
      return callableMarkdown(m.name, m.callable, m.prefix) + (m.callable.user ? `\nMethod of \`${m.struct.name}\`` : "");
    }

    if (m.type === "field") {
      let md = fence(`${m.field.type} ${m.struct.name}.${m.name}`);
      if (m.field.description) md += `\n${m.field.description}`;
      return md;
    }

    return fence(`${m.enumName}.${m.name}`) + "\nEnum member";
  }

  const r = resolveFree(id.name, symbols);
  if (!r) return null;

  switch (r.kind) {
    case "variable":
      return fence(`${displayType(r.info.dataType)} ${id.name}`) + (r.info.isParam ? "\nParameter" : "\nVariable");

    case "function":
      return callableMarkdown(id.name, userCallable(r.info)) + `\nUser-defined function${originNote(r.info)}`;

    case "struct":
      return structMarkdown(id.name, structInfo(id.name, symbols)) + originNote(r.info);

    case "enum":
      return fence(`enum ${id.name} {\n  ${r.info.members.join(",\n  ")}\n}`) + originNote(r.info);

    case "namespace": {
      const list = Object.entries(r.info.functions)
        .map(([n, f]) => `- \`${formatSignature(n, f, `${id.name}.`)}\``)
        .join("\n");
      return `${fence(`namespace ${id.name}`)}\n${r.info.description}\n\n${list}`;
    }

    case "builtinStruct":
      return structMarkdown(id.name, structInfo(id.name, symbols));

    case "globalFn":
      return callableMarkdown(id.name, r.info) + (r.info.origin === "compiler" ? "\nCompiler built-in" : "\nStandard function");

    case "constant":
      return fence(`${r.info.type} ${id.name}`) + `\n${r.info.description}\n\n${r.info.mutable ? "Global variable" : "Global constant"}`;

    case "type":
      return fence(id.name) + "\nBuilt-in type";

    case "keyword":
      return fence(id.name) + "\nZen keyword";

    default:
      return null;
  }
}

// Completion

const Kind = {
  Method: 2,
  Function: 3,
  Field: 5,
  Variable: 6,
  Class: 7,
  Module: 9,
  Keyword: 14,
  EnumMember: 20,
  Constant: 21,
  Struct: 22,
};

function snippet(name, callable) {
  const params = callable.parameters ?? [];
  if (params.length === 0) return `${name}()`;

  return `${name}(${params.map((p, i) => `\${${i + 1}:${p.name}}`).join(", ")})`;
}

function callableItem(name, callable, prefix, kind, sortPrefix) {
  return {
    label: name,
    kind,
    detail: formatSignature(name, callable, prefix),
    documentation: callable.description ? { kind: "markdown", value: callable.description } : undefined,
    insertText: snippet(name, callable),
    insertTextFormat: 2,
    sortText: `${sortPrefix}${name}`,
  };
}

function memberItems(res, symbols) {
  const items = [];

  if (res.kind === "namespace") {
    for (const [n, f] of Object.entries(INFO.namespaces[res.name].functions)) {
      items.push(callableItem(n, f, `${res.name}.`, Kind.Function, "0"));
    }
    return items;
  }

  if (res.kind === "enum") {
    for (const m of res.info.members) {
      items.push({ label: m, kind: Kind.EnumMember, detail: `${res.name}.${m}` });
    }
    return items;
  }

  const s = res.kind === "type" ? res.struct : structInfo(res.type, symbols);
  if (!s) return items;

  for (const [n, f] of s.fields) {
    items.push({
      label: n,
      kind: Kind.Field,
      detail: `${s.name}.${n}: ${f.type}`,
      documentation: f.description ? { kind: "markdown", value: f.description } : undefined,
      sortText: `0${n}`,
    });
  }

  for (const [n, m] of s.methods) {
    items.push(callableItem(n, m, `${s.name}.`, Kind.Method, "1"));
  }

  return items;
}

function completionItems(doc, offset) {
  if (inNonCode(doc, offset)) return [];

  const symbols = getSymbols(doc.uri);
  const before = doc.masked.slice(Math.max(0, offset - 300), offset);
  const dot = /((?:[A-Za-z_]\w*\s*\.\s*)*[A-Za-z_]\w*)\s*\.\s*(?:[A-Za-z_]\w*)?$/.exec(before);

  if (dot) {
    const res = resolveChain(dot[1].split(".").map((s) => s.trim()), doc, offset);
    return res ? memberItems(res, symbols) : [];
  }

  const items = [];

  // user symbols first
  for (const [n, info] of symbols.functions) {
    items.push(callableItem(n, userCallable(info), "", Kind.Function, "0"));
  }
  for (const [n, info] of symbols.variables) {
    items.push({ label: n, kind: Kind.Variable, detail: displayType(info.dataType), sortText: `0${n}` });
  }
  for (const n of symbols.structs.keys()) {
    items.push({ label: n, kind: Kind.Struct, detail: "struct", sortText: `0${n}` });
  }
  for (const n of symbols.enums.keys()) {
    items.push({ label: n, kind: Kind.Class, detail: "enum", sortText: `0${n}` });
  }

  for (const [n, f] of Object.entries(INFO.global_fn)) {
    items.push(callableItem(n, f, "", Kind.Function, "1"));
  }
  for (const [n, c] of Object.entries(INFO.constants)) {
    items.push({
      label: n,
      kind: Kind.Constant,
      detail: `${c.type} ${c.mutable ? "variable" : "constant (readonly)"}`,
      documentation: { kind: "markdown", value: c.description },
      sortText: `1${n}`,
    });
  }
  for (const [n, ns] of Object.entries(INFO.namespaces)) {
    items.push({
      label: n,
      kind: Kind.Module,
      detail: "namespace",
      documentation: { kind: "markdown", value: ns.description },
      sortText: `1${n}`,
    });
  }
  for (const [n, s] of Object.entries(INFO.structs)) {
    items.push({
      label: n,
      kind: Kind.Struct,
      detail: "built-in struct",
      documentation: { kind: "markdown", value: s.description },
      sortText: `1${n}`,
    });
  }
  for (const t of TYPES) {
    items.push({ label: t, kind: Kind.Class, detail: "type", sortText: `2${t}` });
  }
  for (const k of KEYWORDS) {
    items.push({ label: k, kind: Kind.Keyword, detail: "keyword", sortText: `3${k}` });
  }

  return items;
}

// Signature help

function findCall(doc, offset) {
  const m = doc.masked;
  let depth = 0;
  let commas = 0;

  for (let i = offset - 1; i >= 0 && offset - i < 3000; i--) {
    const ch = m[i];

    if (ch === ")" || ch === "]" || ch === "}") depth++;
    else if (ch === "(" || ch === "[" || ch === "{") {
      if (depth === 0) {
        if (ch !== "(") return null;
        return { open: i, activeParam: commas };
      }
      depth--;
    } else if (ch === "," && depth === 0) commas++;
    else if (ch === ";" && depth === 0) return null;
  }

  return null;
}

function calleeAt(doc, open) {
  const before = doc.masked.slice(Math.max(0, open - 300), open);
  const m = /([A-Za-z_]\w*(?:\s*\.\s*[A-Za-z_]\w*)*)\s*(?:<[A-Za-z0-9_<>,\s]*>)?\s*$/.exec(before);

  return m ? m[1].split(".").map((s) => s.trim()) : null;
}

function resolveCallable(doc, segments, open) {
  const symbols = getSymbols(doc.uri);

  if (segments.length === 1) {
    const name = segments[0];

    if (symbols.functions.has(name)) {
      return { name, callable: userCallable(symbols.functions.get(name)), prefix: "" };
    }

    if (has(INFO.global_fn, name)) {
      return { name, callable: INFO.global_fn[name], prefix: "" };
    }

    return null;
  }

  const name = segments[segments.length - 1];
  const res = resolveChain(segments.slice(0, -1), doc, open);
  const m = memberOf(res, name, symbols);

  return m && m.type === "callable" ? { name, callable: m.callable, prefix: m.prefix } : null;
}

function signatureHelp(doc, offset) {
  if (inNonCode(doc, offset)) return null;

  const call = findCall(doc, offset);
  if (!call) return null;

  const segments = calleeAt(doc, call.open);
  if (!segments) return null;

  const found = resolveCallable(doc, segments, call.open);
  if (!found) return null;

  const { name, callable, prefix } = found;
  const labels = callable.parameters.map((p) => `${p.type} ${p.name}${p.optional ? "?" : ""}`);
  if (callable.variadic) labels.push("...");

  return {
    signatures: [
      {
        label: formatSignature(name, callable, prefix),
        documentation: callable.description ? { kind: "markdown", value: callable.description } : undefined,
        parameters: labels.map((label) => ({ label })),
      },
    ],
    activeSignature: 0,
    activeParameter: Math.max(0, Math.min(call.activeParam, labels.length - 1)),
  };
}

// Locating declarations

function locateDecl(doc, name, lineHint, opts = {}) {
  let cands = identsOf(doc).filter((i) => i.name === name && !i.afterDot);

  if (opts.range) {
    cands = cands.filter((i) => i.line >= opts.range.startLine && i.line <= opts.range.endLine);
  }

  const prefer = (pred) => {
    const narrowed = cands.filter(pred);
    if (narrowed.length) cands = narrowed;
  };

  if (opts.keyword) prefer((i) => precededBy(doc, i, opts.keyword));
  if (opts.paren) prefer((i) => nextNonSpace(doc.masked, i.end) === "(");

  if (!cands.length) return null;

  if (lineHint != null) {
    const hit = cands.find((i) => i.line === lineHint - 1) ?? cands.find((i) => i.line === lineHint);
    if (hit) return hit;
  }

  return cands[0];
}

const locationOf = (doc, id) => ({ uri: doc.uri, range: identRange(doc, id) });

// where a free name is declared: { doc, id } | null
function declarationOfFree(doc, name, r) {
  const origin = r.info.origin;
  const d = origin ? origin.doc : doc;
  const declName = r.info.originalName ?? name;

  const id =
    r.kind === "function"
      ? locateDecl(d, declName, r.info.line, { keyword: "fn" }) ?? locateDecl(d, declName, r.info.line, { paren: true })
      : r.kind === "struct"
      ? locateDecl(d, declName, r.info.line, { keyword: "struct" })
      : r.kind === "enum"
      ? locateDecl(d, declName, r.info.line, { keyword: "enum" })
      : r.kind === "variable"
      ? locateDecl(d, declName, r.info.line)
      : null;

  return id ? { doc: d, id } : null;
}

// where a struct member is declared
function declarationOfMember(doc, m) {
  if (!m.struct || m.struct.builtin) return null;

  const origin = m.struct.user.origin;
  const d = origin ? origin.doc : doc;
  const range = structRangeByName(d, m.struct.user.originalName ?? m.struct.name);
  const hint = m.type === "callable" ? m.callable.line : m.field.line;

  const id = locateDecl(d, m.name, hint, { range, paren: m.type === "callable" });

  return id ? { doc: d, id } : null;
}

function definitionAt(doc, offset) {
  const id = identAt(doc, offset);
  if (!id) return null;

  const symbols = getSymbols(doc.uri);

  if (id.afterDot) {
    const chain = chainBefore(doc, id.start);
    if (!chain) return null;

    const m = memberOf(resolveChain(chain, doc, id.start), id.name, symbols);
    const decl = m && declarationOfMember(doc, m);

    return decl ? locationOf(decl.doc, decl.id) : null;
  }

  const r = resolveFree(id.name, symbols);
  if (!r) return null;

  const decl = declarationOfFree(doc, id.name, r);
  return decl ? locationOf(decl.doc, decl.id) : null;
}

// References, highlight, rename

// What the cursor is on, for references/rename:
//   { kind: "free", name, imported } | { kind: "member", name } | null
function targetAt(doc, offset) {
  const id = identAt(doc, offset);
  if (!id) return null;

  const symbols = getSymbols(doc.uri);

  if (id.afterDot) return { id, kind: "member", name: id.name };

  // declaration of a struct field/method
  const struct = enclosingStruct(doc, offset);

  if (struct) {
    const s = symbols.structs.get(struct.name);
    const isMember = s && (s.methods.has(id.name) || s.fields.some((f) => f.name === id.name));
    const decl = isMember && locateDecl(doc, id.name, null, { range: struct, paren: s.methods.has(id.name) });

    if (isMember && decl && decl.start === id.start) return { id, kind: "member", name: id.name };
  }

  const r = resolveFree(id.name, symbols);
  if (!r || !["variable", "function", "struct", "enum"].includes(r.kind)) return null;

  return { id, kind: "free", name: id.name, imported: !!r.info.origin, resolved: r };
}

function referencesOf(doc, target) {
  const list = identsOf(doc).filter((i) => i.name === target.name);

  if (target.kind === "member") {
    const structs = blockRanges(doc, "struct");

    return list.filter((i) => {
      if (i.afterDot) return true;
      return structs.some((s) => i.start > s.open && i.start < s.close);
    });
  }

  return list.filter((i) => !i.afterDot);
}

function renameEdits(doc, offset, newName) {
  const target = targetAt(doc, offset);
  if (!target) return { error: "Nothing renameable here." };

  if (target.imported) return { error: "This symbol is defined in another file; rename it there." };

  if (!/^[A-Za-z_][A-Za-z0-9_]*$/.test(newName)) {
    return { error: `'${newName}' is not a valid identifier.` };
  }

  if (KEYWORD_WORDS.has(newName) || TYPES.includes(newName)) {
    return { error: `'${newName}' is a reserved word.` };
  }

  const edits = referencesOf(doc, target).map((i) => ({ range: identRange(doc, i), newText: newName }));

  return { edits };
}

// Symbols: outline + workspace

const SymbolKind = { Enum: 10, Function: 12, Variable: 13, Method: 6, Field: 8, Struct: 23, EnumMember: 22 };

function blockEnd(doc, from) {
  const m = doc.masked;
  const open = m.indexOf("{", from);
  if (open === -1) return null;

  const between = m.slice(from, open);
  if (/[;]/.test(between) || (between.match(/\n/g) || []).length > 3) return null;

  return matchBrace(m, open) + 1;
}

function outline(doc, local) {
  const out = [];

  const make = (name, kind, id, detail) => {
    const lineStart = doc.lineStarts[id.line];
    const end = blockEnd(doc, id.end) ?? lineEnd(doc, id.line);

    return {
      name,
      kind,
      detail,
      range: rangeOf(doc, lineStart, Math.max(end, id.end)),
      selectionRange: identRange(doc, id),
      children: [],
    };
  };

  for (const [name, info] of local.functions) {
    if (info.origin) continue;
    const id = locateDecl(doc, name, info.line, { keyword: "fn" }) ?? locateDecl(doc, name, info.line, { paren: true });
    if (id) out.push(make(name, SymbolKind.Function, id, formatSignature(name, userCallable(info)).slice(name.length)));
  }

  for (const [name, info] of local.structs) {
    if (info.origin) continue;
    const id = locateDecl(doc, name, info.line, { keyword: "struct" });
    if (!id) continue;

    const sym = make(name, SymbolKind.Struct, id);
    const range = structRangeByName(doc, name);

    for (const f of info.fields) {
      const fid = locateDecl(doc, f.name, f.line, { range });
      if (fid) sym.children.push(make(f.name, SymbolKind.Field, fid, f.dataType));
    }

    for (const [mName, m] of info.methods) {
      const mid = locateDecl(doc, mName, m.line, { range, paren: true });
      if (mid) sym.children.push(make(mName, SymbolKind.Method, mid, formatSignature(mName, userCallable(m)).slice(mName.length)));
    }

    out.push(sym);
  }

  for (const [name, info] of local.enums) {
    if (info.origin) continue;
    const id = locateDecl(doc, name, info.line, { keyword: "enum" });
    if (!id) continue;

    const sym = make(name, SymbolKind.Enum, id);
    const range = blockRanges(doc, "enum").find((r) => r.name === name);

    for (const member of info.members) {
      const mid = locateDecl(doc, member, null, { range });
      if (mid) sym.children.push(make(member, SymbolKind.EnumMember, mid));
    }

    out.push(sym);
  }

  for (const name of local.topVars) {
    const info = local.variables.get(name);
    const id = info && locateDecl(doc, name, info.line);
    if (id) out.push(make(name, SymbolKind.Variable, id, info.dataType));
  }

  out.sort((a, b) => positionCompare(a.selectionRange.start, b.selectionRange.start));

  return out;
}

const positionCompare = (a, b) => a.line - b.line || a.character - b.character;

function flatten(doc, symbols, container, out = []) {
  for (const s of symbols) {
    out.push({ name: s.name, kind: s.kind, containerName: container, location: { uri: doc.uri, range: s.selectionRange } });
    flatten(doc, s.children, s.name, out);
  }
  return out;
}

const IGNORED_DIRS = new Set(["node_modules", ".git", "logs", "zen_modules", ".zen"]);

function workspaceFiles() {
  const files = [];

  const walk = (dir, depth) => {
    if (depth > 8 || files.length >= 400) return;

    let entries;

    try {
      entries = fs.readdirSync(dir, { withFileTypes: true });
    } catch {
      return;
    }

    for (const e of entries) {
      if (files.length >= 400) return;
      if (e.isDirectory()) {
        if (!IGNORED_DIRS.has(e.name) && !e.name.startsWith(".")) walk(path.join(dir, e.name), depth + 1);
      } else if (e.name.endsWith(".zen")) {
        files.push(path.join(dir, e.name));
      }
    }
  };

  for (const root of workspaceRoots) walk(root, 0);

  return files;
}

function workspaceSymbols(query) {
  const q = query.toLowerCase();
  const out = [];
  const seen = new Set();

  const add = (doc, local) => {
    for (const s of flatten(doc, outline(doc, local), undefined)) {
      if (!q || s.name.toLowerCase().includes(q)) out.push(s);
    }
  };

  for (const [uri, doc] of docs) {
    seen.add(uri);
    const st = docState.get(uri);
    if (st) add(doc, st.local);
  }

  for (const file of workspaceFiles()) {
    if (out.length >= 300) break;

    const uri = pathToFileURL(file).href;
    if (seen.has(uri)) continue;

    const ext = externalFor(file);
    if (ext) add(ext.doc, ext.symbols);
  }

  return out.slice(0, 300);
}

// Folding

function foldingRanges(doc) {
  const out = [];
  const stack = [];
  const m = doc.masked;

  for (let i = 0; i < m.length; i++) {
    if (m[i] === "{") stack.push(i);
    else if (m[i] === "}" && stack.length) {
      const start = positionAt(doc, stack.pop()).line;
      const end = positionAt(doc, i).line - 1;
      if (end > start) out.push({ startLine: start, endLine: end, kind: "region" });
    }
  }

  const re = /\/\*[\s\S]*?\*\//g;
  let c;

  while ((c = re.exec(doc.text))) {
    if (m[c.index] !== " ") continue;
    const start = positionAt(doc, c.index).line;
    const end = positionAt(doc, c.index + c[0].length).line;
    if (end > start) out.push({ startLine: start, endLine: end, kind: "comment" });
  }

  return out;
}

// Request handling

let shuttingDown = false;

function withDoc(id, params, fn) {
  const doc = docs.get(params.textDocument.uri);

  if (!doc) {
    reply(id, null);
    return;
  }

  reply(id, fn(doc));
}

function handleMessage(msg) {
  const { id, method, params } = msg;

  switch (method) {
    case "initialize": {
      for (const f of params?.workspaceFolders ?? []) {
        try {
          workspaceRoots.push(fileURLToPath(f.uri));
        } catch {
          /* ignore */
        }
      }

      if (workspaceRoots.length === 0 && params?.rootUri) {
        try {
          workspaceRoots.push(fileURLToPath(params.rootUri));
        } catch {
          /* ignore */
        }
      }

      reply(id, {
        capabilities: {
          textDocumentSync: { openClose: true, change: 1 },
          completionProvider: { triggerCharacters: ["."] },
          hoverProvider: true,
          signatureHelpProvider: { triggerCharacters: ["(", ","], retriggerCharacters: [","] },
          definitionProvider: true,
          referencesProvider: true,
          documentHighlightProvider: true,
          renameProvider: { prepareProvider: true },
          documentSymbolProvider: true,
          workspaceSymbolProvider: true,
          foldingRangeProvider: true,
        },
        serverInfo: { name: "zen-lsp", version: "0.4.0" },
      });
      return;
    }

    case "initialized":
      return;

    case "textDocument/didOpen": {
      const { uri, text } = params.textDocument;
      docs.set(uri, makeDoc(uri, text));
      publishDiagnostics(uri);
      return;
    }

    case "textDocument/didChange": {
      const { uri } = params.textDocument;
      const change = params.contentChanges[params.contentChanges.length - 1];
      docs.set(uri, makeDoc(uri, change.text));
      scheduleDiagnostics(uri);
      return;
    }

    case "textDocument/didClose": {
      const { uri } = params.textDocument;
      clearTimeout(timers.get(uri));
      docs.delete(uri);
      docState.delete(uri);
      notify("textDocument/publishDiagnostics", { uri, diagnostics: [] });
      return;
    }

    case "textDocument/completion":
      withDoc(id, params, (doc) => ({
        isIncomplete: false,
        items: completionItems(doc, offsetAt(doc, params.position)),
      }));
      return;

    case "textDocument/hover":
      withDoc(id, params, (doc) => {
        const offset = offsetAt(doc, params.position);
        const md = hoverMarkdown(doc, offset);
        const ident = identAt(doc, offset);

        return md ? { contents: { kind: "markdown", value: md }, range: ident ? identRange(doc, ident) : undefined } : null;
      });
      return;

    case "textDocument/signatureHelp":
      withDoc(id, params, (doc) => signatureHelp(doc, offsetAt(doc, params.position)));
      return;

    case "textDocument/definition":
      withDoc(id, params, (doc) => definitionAt(doc, offsetAt(doc, params.position)));
      return;

    case "textDocument/references":
      withDoc(id, params, (doc) => {
        const target = targetAt(doc, offsetAt(doc, params.position));
        if (!target) return [];

        return referencesOf(doc, target)
          .filter((i) => params.context?.includeDeclaration !== false || i.start !== definitionStart(doc, target))
          .map((i) => locationOf(doc, i));
      });
      return;

    case "textDocument/documentHighlight":
      withDoc(id, params, (doc) => {
        const target = targetAt(doc, offsetAt(doc, params.position));
        if (!target) return [];

        return referencesOf(doc, target).map((i) => ({ range: identRange(doc, i), kind: 1 }));
      });
      return;

    case "textDocument/prepareRename": {
      const doc = docs.get(params.textDocument.uri);
      const target = doc && targetAt(doc, offsetAt(doc, params.position));

      if (!target || target.imported) {
        replyError(id, -32602, target?.imported ? "Defined in another file; rename it there." : "Nothing renameable here.");
        return;
      }

      reply(id, { range: identRange(doc, target.id), placeholder: target.name });
      return;
    }

    case "textDocument/rename": {
      const doc = docs.get(params.textDocument.uri);

      if (!doc) {
        reply(id, null);
        return;
      }

      const result = renameEdits(doc, offsetAt(doc, params.position), params.newName);

      if (result.error) replyError(id, -32602, result.error);
      else reply(id, { changes: { [doc.uri]: result.edits } });
      return;
    }

    case "textDocument/documentSymbol":
      withDoc(id, params, (doc) => {
        const st = docState.get(doc.uri);
        return st ? outline(doc, st.local) : [];
      });
      return;

    case "workspace/symbol":
      reply(id, workspaceSymbols(params?.query ?? ""));
      return;

    case "textDocument/foldingRange":
      withDoc(id, params, (doc) => foldingRanges(doc));
      return;

    case "shutdown":
      shuttingDown = true;
      reply(id, null);
      return;

    case "exit":
      process.exit(shuttingDown ? 0 : 1);
      return;

    default:
      // unknown request -> null result; unknown notifications ($/…) are ignored
      if (id !== undefined && method && !method.startsWith("$/")) reply(id, null);
      return;
  }
}

function definitionStart(doc, target) {
  const symbols = getSymbols(doc.uri);

  if (target.kind === "free") {
    const decl = declarationOfFree(doc, target.name, target.resolved);
    return decl && decl.doc === doc ? decl.id.start : -1;
  }

  const range = enclosingStruct(doc, target.id.start);
  const s = range && symbols.structs.get(range.name);
  const decl = s && locateDecl(doc, target.name, null, { range, paren: s.methods.has(target.name) });

  return decl ? decl.start : -1;
}

async function main() {
  await loadDeps();

  readMessages((msg) => {
    try {
      handleMessage(msg);
    } catch (err) {
      process.stderr.write(`zen-lsp error: ${err?.stack || err}\n`);
      if (msg.id !== undefined) reply(msg.id, null);
    }
  });
}

main();
