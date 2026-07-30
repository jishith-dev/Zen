#!/usr/bin/env node
import path from "path";
import { fileURLToPath, pathToFileURL } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const COMPILER_ROOT = path.resolve(__dirname, "..");

let IRBuilder, Lexer, Parser, Lint;
let KEYWORDS,
  TYPES,
  BUILTIN_FUNCTIONS,
  BUILTIN_STRUCTS,
  STD_FUNCTIONS_SCHEMA,
  GLOBAL_EXTERNAL,
  ParserTypes;

const namespaces = new Map();
let globalBuiltins = [];

function parseNamespacedName(name) {
  const m = /^_([A-Za-z][A-Za-z0-9]*)_(.+)$/.exec(name);
  if (!m) return null;
  return { ns: m[1], method: m[2] };
}

function buildNamespaces() {
  namespaces.clear();
  globalBuiltins = [];

  for (const fn of BUILTIN_FUNCTIONS) {
    const parsed = parseNamespacedName(fn);
    if (!parsed) {
      globalBuiltins.push(fn);
      continue;
    }
    if (!namespaces.has(parsed.ns)) namespaces.set(parsed.ns, new Map());
    namespaces.get(parsed.ns).set(parsed.method, fn);
  }
}

async function loadDeps() {
  IRBuilder = (
    await import(
      pathToFileURL(path.join(COMPILER_ROOT, "src/codegen/helper/helper.js"))
        .href
    )
  ).IRBuilder;

  Lexer = (
    await import(
      pathToFileURL(path.join(COMPILER_ROOT, "src/lexer/lexer.js")).href
    )
  ).Lexer;

  Parser = (
    await import(
      pathToFileURL(path.join(COMPILER_ROOT, "src/parser/parser.js")).href
    )
  ).Parser;

  Lint = (
    await import(
      pathToFileURL(path.join(COMPILER_ROOT, "/tooling/lint/lint.js")).href
    )
  ).Lint;

  const config = await import(
    pathToFileURL(path.join(COMPILER_ROOT, "src/config/config.js")).href
  );

  KEYWORDS = config.KEYWORDS;
  TYPES = config.TYPES;
  BUILTIN_FUNCTIONS = config.BUILTIN_FUNCTIONS;
  BUILTIN_STRUCTS = config.BUILTIN_STRUCTS;
  STD_FUNCTIONS_SCHEMA = config.STD_FUNCTIONS_SCHEMA;
  GLOBAL_EXTERNAL = config.GLOBAL_EXTERNAL;
  ParserTypes = config.ParserTypes;

  buildNamespaces();
}

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
      } catch {
        // ignore malformed message
      }
    }
  });
}

function send(msg) {
  const json = JSON.stringify(msg);
  const header = `Content-Length: ${Buffer.byteLength(json, "utf8")}\r\n\r\n`;
  process.stdout.write(header + json);
}

const documents = new Map();
const docState = new Map();

function getLine(text, lineNumber) {
  const lines = text.split("\n");
  return lines[lineNumber] ?? "";
}

function wordAt(lineText, character) {
  const isWordChar = (c) => /[A-Za-z0-9_]/.test(c);

  let start = character;
  let end = character;

  while (start > 0 && isWordChar(lineText[start - 1])) start--;
  while (end < lineText.length && isWordChar(lineText[end])) end++;

  if (start === end) return null;
  return { word: lineText.slice(start, end), start, end };
}

function namespaceBefore(lineText, index) {
  const before = lineText.slice(0, index);
  const m = /([A-Za-z_][A-Za-z0-9_]*)\.\s*$/.exec(before);
  return m ? m[1] : null;
}

function toDiagnostic(message, line, column, severity) {
  const l = Math.max((line || 1) - 1, 0);
  const c = Math.max((column || 1) - 1, 0);

  return {
    range: {
      start: { line: l, character: c },
      end: { line: l, character: c + 1 },
    },
    severity,
    source: "zen",
    message,
  };
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

function analyze(uri, text) {
  const diagnostics = [];
  let ast = null;

  try {
    guardExit(() => {
      const irb = new IRBuilder("lsp_doc");

      const lexer = new Lexer(text, irb);
      const tokens = lexer.tokenize();

      const parser = new Parser(tokens, irb);
      const parsedAst = parser.parse();

      if (Array.isArray(irb.errors) && irb.errors.length > 0) {
        for (const e of irb.errors) {
          diagnostics.push(toDiagnostic(e.message, e.line, e.column, 1));
        }
        return;
      }

      ast = parsedAst;

      const lint = new Lint(ast);
      const { errors, warnings } = lint.run();

      for (const e of errors)
        diagnostics.push(toDiagnostic(e.message, e.line, e.column, 1));
      for (const w of warnings)
        diagnostics.push(toDiagnostic(w.message, w.line, w.column, 2));
    });
  } catch (err) {
    if (err && err.__lspGuardExit) {
      diagnostics.push(toDiagnostic("Syntax error (parsing aborted)", 1, 1, 1));
    } else {
      diagnostics.push(
        toDiagnostic(`Internal error: ${err?.message || err}`, 1, 1, 1),
      );
    }
  }

  if (ast) {
    docState.set(uri, { ast, symbols: collectSymbols(ast) });
  }

  return diagnostics;
}

function publishDiagnostics(uri) {
  const text = documents.get(uri);
  if (text === undefined) return;

  send({
    jsonrpc: "2.0",
    method: "textDocument/publishDiagnostics",
    params: { uri, diagnostics: analyze(uri, text) },
  });
}

function collectSymbols(ast) {
  const functions = new Map();
  const variables = new Map();
  const structs = new Map();
  const enums = new Map();

  function paramsOf(node) {
    return (node.params || []).map((p) => ({
      name: p.name,
      dataType: p.dataType || p.type || "auto",
    }));
  }

  function visitFn(node, ofStruct) {
    functions.set(node.name, {
      params: paramsOf(node),
      returnType: node.returnType || "void",
      line: node.line,
      isMethod: !!ofStruct,
      ofStruct,
    });

    for (const p of node.params || []) {
      variables.set(p.name, {
        dataType: p.dataType || p.type || "auto",
        line: node.line,
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
          dataType: node.dataType || node.struct_ref || "auto",
          line: node.line,
        });
        walk(node.value);
        return;

      case ParserTypes.FUNCTION_DECLARATION:
        visitFn(node, null);
        return;

      case ParserTypes.STRUCT:
        structs.set(node.name, {
          fields: (node.fields || []).map((f) => ({
            name: f.name,
            dataType: f.dataType || f.type,
          })),
          methods: (node.methods || []).map((m) => m.name),
          line: node.line,
        });

        for (const method of node.methods || []) {
          visitFn(method, node.name);
        }
        return;

      case ParserTypes.ENUM:
        enums.set(node.name, {
          members: (node.members || []).map((m) => m.name),
          line: node.line,
        });
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

  walk(ast);

  return { functions, variables, structs, enums };
}

const CompletionKind = {
  Function: 3,
  Variable: 6,
  Class: 7,
  Module: 9,
  Keyword: 14,
  Constant: 21,
  Struct: 22,
  EnumMember: 20,
  Field: 5,
};

const TYPE_DISPLAY_ALIASES = { ptr: "string" };

function displayType(t) {
  return TYPE_DISPLAY_ALIASES[t] ?? t;
}

function signatureLabel(name, schema) {
  if (!schema) return `${name}(...)`;
  return `${name}(${(schema.params ?? []).map(displayType).join(", ")}): ${displayType(schema.ret ?? "void")}`;
}

function buildCompletionItems(uri, line, character) {
  const items = [];
  const ns = namespaceBefore(line, character);

  if (ns && namespaces.has(ns)) {
    for (const [method, fullName] of namespaces.get(ns)) {
      const schema = STD_FUNCTIONS_SCHEMA[fullName];
      items.push({
        label: method,
        kind: CompletionKind.Function,
        detail: signatureLabel(`${ns}.${method}`, schema),
        insertText: `${method}(${(schema?.params ?? []).map((_, i) => `\${${i + 1}}`).join(", ")})`,
        insertTextFormat: 2,
      });
    }
    return items;
  }

  for (const kw of KEYWORDS) {
    items.push({ label: kw, kind: CompletionKind.Keyword, detail: "keyword" });
  }

  for (const t of TYPES) {
    items.push({ label: t, kind: CompletionKind.Class, detail: "type" });
  }

  for (const s of BUILTIN_STRUCTS) {
    items.push({
      label: s,
      kind: CompletionKind.Struct,
      detail: "built-in struct",
    });
  }

  for (const nsName of namespaces.keys()) {
    items.push({
      label: nsName,
      kind: CompletionKind.Module,
      detail: "namespace",
    });
  }

  for (const fn of globalBuiltins) {
    const schema = STD_FUNCTIONS_SCHEMA[fn];

    items.push({
      label: fn,
      kind: CompletionKind.Function,
      detail: signatureLabel(fn, schema),
      insertText: `${fn}(${(schema?.params ?? []).map((_, i) => `\${${i + 1}}`).join(", ")})`,
      insertTextFormat: 2,
    });
  }

  for (const [name, info] of Object.entries(GLOBAL_EXTERNAL)) {
    items.push({
      label: name,
      kind: CompletionKind.Constant,
      detail: `${displayType(info.type)} constant${info.mutable ? "" : " (readonly)"}`,
    });
  }

  const state = docState.get(uri);
  if (state) {
    for (const [name, info] of state.symbols.functions) {
      items.push({
        label: name,
        kind: CompletionKind.Function,
        detail: `${info.isMethod ? `${info.ofStruct}.` : ""}${name}(${info.params
          .map((p) => `${p.dataType} ${p.name}`)
          .join(", ")}): ${info.returnType}`,
      });
    }
    for (const [name, info] of state.symbols.variables) {
      items.push({
        label: name,
        kind: CompletionKind.Variable,
        detail: info.dataType,
      });
    }
    for (const [name, info] of state.symbols.structs) {
      items.push({
        label: name,
        kind: CompletionKind.Struct,
        detail: "struct",
      });
      for (const f of info.fields) {
        items.push({
          label: f.name,
          kind: CompletionKind.Field,
          detail: `${name}.${f.name}: ${f.dataType}`,
        });
      }
    }
    for (const [name, info] of state.symbols.enums) {
      items.push({ label: name, kind: CompletionKind.Class, detail: "enum" });
      for (const m of info.members) {
        items.push({
          label: m,
          kind: CompletionKind.EnumMember,
          detail: `${name}.${m}`,
        });
      }
    }
  }

  return items;
}

function handleCompletion(id, params) {
  const uri = params.textDocument.uri;
  const text = documents.get(uri) ?? "";
  const line = getLine(text, params.position.line);
  const items = buildCompletionItems(uri, line, params.position.character);
  send({ jsonrpc: "2.0", id, result: { isIncomplete: false, items } });
}

function handleHover(id, params) {
  const { uri } = params.textDocument;
  const text = documents.get(uri);

  if (text === undefined) {
    send({ jsonrpc: "2.0", id, result: null });
    return;
  }

  const line = getLine(text, params.position.line);
  const found = wordAt(line, params.position.character);

  if (!found) {
    send({ jsonrpc: "2.0", id, result: null });
    return;
  }

  const { word, start } = found;
  const ns = namespaceBefore(line, start);
  let contents = null;

  if (ns && namespaces.has(ns) && namespaces.get(ns).has(word)) {
    const fullName = namespaces.get(ns).get(word);
    const schema = STD_FUNCTIONS_SCHEMA[fullName];
    contents = schema
      ? `\`\`\`zen\nfn ${signatureLabel(`${ns}.${word}`, schema)}\n\`\`\`\nBuilt-in function of \`${ns}\``
      : `\`\`\`zen\nfn ${ns}.${word}(...)\n\`\`\`\nInternal built-in function`;
  } else if (namespaces.has(word)) {
    const members = [...namespaces.get(word).entries()]
      .map(
        ([method, fullName]) =>
          `- ${signatureLabel(`${word}.${method}`, STD_FUNCTIONS_SCHEMA[fullName])}`,
      )
      .join("\n");
    contents = `\`\`\`zen\nnamespace ${word}\n\`\`\`\n${members}`;
  } else if (KEYWORDS.includes(word)) {
    contents = `\`\`\`zen\n${word}\n\`\`\`\nZen keyword`;
  } else if (TYPES.includes(word)) {
    contents = `\`\`\`zen\n${word}\n\`\`\`\nBuilt-in type`;
  } else if (BUILTIN_STRUCTS.includes(word)) {
    contents = `\`\`\`zen\n${word}\n\`\`\`\nBuilt-in struct`;
  } else if (globalBuiltins.includes(word)) {
    const schema = STD_FUNCTIONS_SCHEMA[word];
    contents = schema
      ? `\`\`\`zen\nfn ${signatureLabel(word, schema)}\n\`\`\`\nBuilt-in function`
      : `\`\`\`zen\nfn ${word}(...)\n\`\`\`\nInternal built-in function`;
  } else if (GLOBAL_EXTERNAL[word]) {
    const info = GLOBAL_EXTERNAL[word];
    contents = `\`\`\`zen\n${displayType(info.type)} ${word}\n\`\`\`\n${info.mutable ? "Global variable" : "Global constant"}`;
  } else {
    const state = docState.get(uri);
    if (state) {
      if (state.symbols.functions.has(word)) {
        const f = state.symbols.functions.get(word);
        const paramsStr = f.params
          .map((p) => `${p.dataType} ${p.name}`)
          .join(", ");
        contents = `\`\`\`zen\nfn ${word}(${paramsStr}): ${f.returnType}\n\`\`\`${
          f.isMethod
            ? `\nMethod of \`${f.ofStruct}\``
            : "\nUser-defined function"
        }`;
      } else if (state.symbols.variables.has(word)) {
        const v = state.symbols.variables.get(word);
        contents = `\`\`\`zen\n${v.dataType} ${word}\n\`\`\`\nVariable`;
      } else if (state.symbols.structs.has(word)) {
        const s = state.symbols.structs.get(word);
        const fields = s.fields
          .map((f) => `  ${f.dataType} ${f.name}`)
          .join("\n");
        contents = `\`\`\`zen\nstruct ${word} {\n${fields}\n}\n\`\`\``;
      } else if (state.symbols.enums.has(word)) {
        const e = state.symbols.enums.get(word);
        contents = `\`\`\`zen\nenum ${word} {\n  ${e.members.join(",\n  ")}\n}\n\`\`\``;
      }
    }
  }

  if (!contents) {
    send({ jsonrpc: "2.0", id, result: null });
    return;
  }

  send({
    jsonrpc: "2.0",
    id,
    result: { contents: { kind: "markdown", value: contents } },
  });
}

function findEnclosingCall(line, character) {
  let depth = 0;

  for (let i = character - 1; i >= 0; i--) {
    const c = line[i];

    if (c === ")") depth++;
    else if (c === "(") {
      if (depth === 0) {
        const before = line.slice(0, i);
        const m =
          /([A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)?)\s*$/.exec(
            before,
          );
        if (!m) return null;

        const argsSoFar = line.slice(i + 1, character);
        const activeParam = (argsSoFar.match(/,/g) || []).length;

        return { name: m[1], activeParam };
      }
      depth--;
    }
  }

  return null;
}

function resolveCallSchema(uri, name) {
  const dot = name.indexOf(".");

  if (dot !== -1) {
    const ns = name.slice(0, dot);
    const method = name.slice(dot + 1);
    const fullName = namespaces.get(ns)?.get(method);
    const schema = fullName ? STD_FUNCTIONS_SCHEMA[fullName] : null;
    if (!schema) return null;
    return {
      label: name,
      params: (schema.params ?? []).map(displayType),
      returnType: displayType(schema.ret ?? "void"),
    };
  }

  const schema = STD_FUNCTIONS_SCHEMA[name];
  if (schema && globalBuiltins.includes(name)) {
    return {
      label: name,
      params: (schema.params ?? []).map(displayType),
      returnType: displayType(schema.ret ?? "void"),
    };
  }

  const state = docState.get(uri);
  const fn = state?.symbols.functions.get(name);
  if (fn) {
    return {
      label: name,
      params: fn.params.map((p) => `${p.dataType} ${p.name}`),
      returnType: fn.returnType,
    };
  }

  return null;
}

function handleSignatureHelp(id, params) {
  const { uri } = params.textDocument;
  const text = documents.get(uri);

  if (text === undefined) {
    send({ jsonrpc: "2.0", id, result: null });
    return;
  }

  const line = getLine(text, params.position.line);
  const call = findEnclosingCall(line, params.position.character);

  if (!call) {
    send({ jsonrpc: "2.0", id, result: null });
    return;
  }

  const resolved = resolveCallSchema(uri, call.name);

  if (!resolved) {
    send({ jsonrpc: "2.0", id, result: null });
    return;
  }

  send({
    jsonrpc: "2.0",
    id,
    result: {
      signatures: [
        {
          label: `${resolved.label}(${resolved.params.join(", ")}): ${resolved.returnType}`,
          parameters: resolved.params.map((p) => ({ label: p })),
        },
      ],
      activeSignature: 0,
      activeParameter: Math.min(call.activeParam, resolved.params.length - 1),
    },
  });
}

function handleMessage(msg) {
  const { id, method, params } = msg;

  switch (method) {
    case "initialize":
      send({
        jsonrpc: "2.0",
        id,
        result: {
          capabilities: {
            textDocumentSync: 1,
            completionProvider: { triggerCharacters: [".", "(", ","] },
            hoverProvider: true,
            signatureHelpProvider: { triggerCharacters: ["(", ","] },
          },
          serverInfo: { name: "zen-lsp", version: "0.3.0" },
        },
      });
      return;

    case "initialized":
      return;

    case "textDocument/didOpen": {
      const { uri, text } = params.textDocument;
      documents.set(uri, text);
      publishDiagnostics(uri);
      return;
    }

    case "textDocument/didChange": {
      const { uri } = params.textDocument;
      const change = params.contentChanges[params.contentChanges.length - 1];
      documents.set(uri, change.text);
      publishDiagnostics(uri);
      return;
    }

    case "textDocument/didClose": {
      const { uri } = params.textDocument;
      documents.delete(uri);
      docState.delete(uri);
      send({
        jsonrpc: "2.0",
        method: "textDocument/publishDiagnostics",
        params: { uri, diagnostics: [] },
      });
      return;
    }

    case "textDocument/completion":
      handleCompletion(id, params);
      return;

    case "textDocument/hover":
      handleHover(id, params);
      return;

    case "textDocument/signatureHelp":
      handleSignatureHelp(id, params);
      return;

    case "shutdown":
      send({ jsonrpc: "2.0", id, result: null });
      return;

    case "exit":
      process.exit(0);
      return;

    default:
      if (id !== undefined) {
        send({ jsonrpc: "2.0", id, result: null });
      }
      return;
  }
}

async function main() {
  await loadDeps();

  readMessages((msg) => {
    try {
      handleMessage(msg);
    } catch (err) {
      process.stderr.write(`zen-lsp error: ${err?.stack || err}\n`);
    }
  });
}

main();
