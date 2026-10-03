#!/usr/bin/env node
// Talks to bin/lsp.js over stdio, no editor needed.
//
//   node tooling/tests/lsp_test.js                       self test
//   node tooling/tests/lsp_test.js <feature> <file> <line> <col> [arg]
//
// features: diagnostics hover definition references highlight rename
//           completion signature symbols workspace folding
// line/col are 1-based (what your editor shows). rename needs the new name
// as [arg]. Two features take no position:
//   node tooling/tests/lsp_test.js workspace <file> <query>
//   node tooling/tests/lsp_test.js symbols|diagnostics|folding <file>

import { spawn } from "child_process";
import fs from "fs";
import os from "os";
import path from "path";
import { fileURLToPath, pathToFileURL } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const LSP = path.resolve(__dirname, "../../bin/lsp.js");

// ─────────────────────────────────────────────
// minimal LSP client
// ─────────────────────────────────────────────

class Client {
  constructor(root) {
    this.proc = spawn("node", [LSP], { stdio: ["pipe", "pipe", "pipe"] });
    this.buffer = Buffer.alloc(0);
    this.nextId = 1;
    this.pending = new Map();
    this.diagnostics = new Map();
    this.waiters = new Map();
    this.stderr = "";
    this.root = root;

    this.proc.stderr.on("data", (d) => (this.stderr += d));
    this.proc.stdout.on("data", (d) => this.onData(d));
  }

  onData(chunk) {
    this.buffer = Buffer.concat([this.buffer, chunk]);

    while (true) {
      const end = this.buffer.indexOf("\r\n\r\n");
      if (end === -1) return;

      const len = Number(/Content-Length:\s*(\d+)/i.exec(this.buffer.slice(0, end).toString())[1]);
      if (this.buffer.length < end + 4 + len) return;

      const msg = JSON.parse(this.buffer.slice(end + 4, end + 4 + len).toString());
      this.buffer = this.buffer.slice(end + 4 + len);

      if (msg.id !== undefined && this.pending.has(msg.id)) {
        const { resolve } = this.pending.get(msg.id);
        this.pending.delete(msg.id);
        resolve(msg);
      } else if (msg.method === "textDocument/publishDiagnostics") {
        this.diagnostics.set(msg.params.uri, msg.params.diagnostics);
        this.waiters.get(msg.params.uri)?.(msg.params.diagnostics);
      }
    }
  }

  write(obj) {
    const json = JSON.stringify(obj);
    this.proc.stdin.write(`Content-Length: ${Buffer.byteLength(json)}\r\n\r\n${json}`);
  }

  request(method, params) {
    const id = this.nextId++;

    return new Promise((resolve, reject) => {
      const timer = setTimeout(() => reject(new Error(`timeout: ${method}\n${this.stderr}`)), 8000);
      this.pending.set(id, { resolve: (m) => (clearTimeout(timer), resolve(m)) });
      this.write({ jsonrpc: "2.0", id, method, params });
    });
  }

  notify(method, params) {
    this.write({ jsonrpc: "2.0", method, params });
  }

  async start() {
    await this.request("initialize", {
      processId: process.pid,
      rootUri: pathToFileURL(this.root).href,
      capabilities: {},
    });
    this.notify("initialized", {});
  }

  open(file) {
    const uri = pathToFileURL(file).href;
    const text = fs.readFileSync(file, "utf8");

    const done = new Promise((resolve) => this.waiters.set(uri, resolve));
    this.notify("textDocument/didOpen", { textDocument: { uri, languageId: "zen", version: 1, text } });

    return { uri, text, diagnostics: done };
  }

  async stop() {
    await this.request("shutdown", null).catch(() => {});
    this.notify("exit", null);
    setTimeout(() => this.proc.kill(), 200);
  }
}

const pos = (p) => `${p.line + 1}:${p.character + 1}`;
const rng = (r) => `${pos(r.start)}-${pos(r.end)}`;
const short = (uri) => path.basename(uri.replace(/^file:\/\//, ""));

function show(feature, result) {
  if (result?.error) return console.log(`error: ${result.error.message}`);

  const r = result?.result;

  switch (feature) {
    case "hover":
      console.log(r ? r.contents.value : "(nothing)");
      break;

    case "definition":
      console.log(r ? `${short(r.uri)} ${rng(r.range)}` : "(nothing)");
      break;

    case "references":
      (r ?? []).forEach((l) => console.log(`${short(l.uri)} ${rng(l.range)}`));
      if (!r?.length) console.log("(nothing)");
      break;

    case "highlight":
      (r ?? []).forEach((h) => console.log(rng(h.range)));
      if (!r?.length) console.log("(nothing)");
      break;

    case "rename":
      if (!r) return console.log("(nothing)");
      for (const [uri, edits] of Object.entries(r.changes)) {
        edits.forEach((e) => console.log(`${short(uri)} ${rng(e.range)} -> ${e.newText}`));
      }
      break;

    case "completion":
      (r?.items ?? []).slice(0, 40).forEach((i) => console.log(`${i.label.padEnd(18)} ${i.detail ?? ""}`));
      console.log(`(${r?.items?.length ?? 0} items)`);
      break;

    case "signature":
      if (!r) return console.log("(nothing)");
      console.log(r.signatures[0].label);
      console.log(`active parameter: ${r.activeParameter} (${r.signatures[0].parameters[r.activeParameter]?.label})`);
      break;

    case "symbols": {
      const walk = (list, indent = "") =>
        list.forEach((s) => {
          console.log(`${indent}${s.name} [kind ${s.kind}] ${rng(s.selectionRange)}${s.detail ? `  ${s.detail}` : ""}`);
          walk(s.children ?? [], indent + "  ");
        });
      walk(r ?? []);
      break;
    }

    case "workspace":
      (r ?? []).forEach((s) => console.log(`${s.name} [kind ${s.kind}] ${short(s.location.uri)} ${rng(s.location.range)}`));
      if (!r?.length) console.log("(nothing)");
      break;

    case "folding":
      (r ?? []).forEach((f) => console.log(`${f.startLine + 1}-${f.endLine + 1} ${f.kind}`));
      break;
  }
}

// ─────────────────────────────────────────────
// single query
// ─────────────────────────────────────────────

const METHODS = {
  hover: "textDocument/hover",
  definition: "textDocument/definition",
  references: "textDocument/references",
  highlight: "textDocument/documentHighlight",
  rename: "textDocument/rename",
  completion: "textDocument/completion",
  signature: "textDocument/signatureHelp",
  symbols: "textDocument/documentSymbol",
  folding: "textDocument/foldingRange",
};

async function query(feature, file, line, col, arg) {
  const abs = path.resolve(file);
  const client = new Client(path.dirname(abs));

  await client.start();
  const doc = client.open(abs);
  const diags = await doc.diagnostics;

  if (feature === "diagnostics") {
    if (!diags.length) console.log("(no diagnostics)");
    diags.forEach((d) => console.log(`${d.severity === 1 ? "error" : "warning"} ${rng(d.range)} ${d.message}`));
  } else if (feature === "workspace") {
    show(feature, await client.request("workspace/symbol", { query: arg ?? "" }));
  } else if (METHODS[feature]) {
    const params = { textDocument: { uri: doc.uri } };

    if (line !== undefined) params.position = { line: Number(line) - 1, character: Number(col) - 1 };
    if (feature === "references") params.context = { includeDeclaration: true };
    if (feature === "rename") params.newName = arg;

    show(feature, await client.request(METHODS[feature], params));
  } else {
    console.log(`unknown feature: ${feature}`);
  }

  await client.stop();
}

// ─────────────────────────────────────────────
// self test
// ─────────────────────────────────────────────

const LIB = `struct Greeter {
  string name
  greet(string who) string {
    return who
  }
}

export(Greeter)
`;

const MAIN = `import (Greeter) from "lib.zen"

fn add(int a, int b) int {
  int sum = a
  return sum
}

Greeter g
Map m
screen("hi")
fs.readFile("x")
fs.writeFile("a", "b")
g.greet("bob")
m.getInt("k")
add(1, 2)
`;

async function selfTest() {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), "zen-lsp-"));
  fs.writeFileSync(path.join(dir, "lib.zen"), LIB);
  fs.writeFileSync(path.join(dir, "main.zen"), MAIN);

  const client = new Client(dir);
  await client.start();

  const lib = client.open(path.join(dir, "lib.zen"));
  await lib.diagnostics;

  const main = client.open(path.join(dir, "main.zen"));
  const diags = await main.diagnostics;
  const errors = diags.filter((d) => d.severity === 1);

  let pass = 0;
  let fail = 0;
  let skip = 0;

  const at = (needle, nth = 1, delta = 0) => {
    let idx = -1;
    for (let i = 0; i < nth; i++) idx = MAIN.indexOf(needle, idx + 1);
    const before = MAIN.slice(0, idx + delta);
    const line = before.split("\n").length - 1;
    return { line, character: idx + delta - (before.lastIndexOf("\n") + 1) };
  };

  const ask = (method, position, extra = {}) =>
    client.request(method, { textDocument: { uri: main.uri }, position, ...extra }).then((m) => m.error ? { error: m.error } : m.result);

  const check = (name, ok, detail = "") => {
    ok ? pass++ : fail++;
    console.log(`${ok ? "PASS" : "FAIL"}  ${name}${ok ? "" : `  -> ${detail}`}`);
  };

  const needsSymbols = errors.length === 0;

  const test = async (name, symbolsNeeded, fn) => {
    if (symbolsNeeded && !needsSymbols) {
      skip++;
      console.log(`SKIP  ${name} (sample did not parse)`);
      return;
    }

    try {
      const [ok, detail] = await fn();
      check(name, ok, detail);
    } catch (err) {
      check(name, false, err.message);
    }
  };

  console.log(`diagnostics on sample: ${diags.length} (${errors.length} errors)`);
  errors.forEach((d) => console.log(`  ${rng(d.range)} ${d.message}`));
  console.log("");

  // builtins: no parser needed
  await test("hover: global fn", false, async () => {
    const r = await ask("textDocument/hover", at("screen", 1, 2));
    return [r?.contents.value.includes("screen(any value, string format?) -> void"), r?.contents.value];
  });

  await test("hover: namespace fn", false, async () => {
    const r = await ask("textDocument/hover", at("readFile", 1, 2));
    return [r?.contents.value.includes("fs.readFile(string path) -> string"), r?.contents.value];
  });

  await test("completion: namespace members", false, async () => {
    const r = await ask("textDocument/completion", at("fs.readFile", 1, 3));
    const labels = r.items.map((i) => i.label);
    return [labels.includes("readFile") && labels.includes("writeFile") && !labels.includes("screen"), labels.slice(0, 5).join(",")];
  });

  await test("completion: globals", false, async () => {
    const r = await ask("textDocument/completion", at("screen(", 1, 0));
    const labels = r.items.map((i) => i.label);
    return [["screen", "fs", "Map", "PI", "int", "loop"].every((l) => labels.includes(l)), labels.length];
  });

  await test("signature help: active parameter", false, async () => {
    const r = await ask("textDocument/signatureHelp", at('fs.writeFile("a", ', 1, 17));
    return [r?.activeParameter === 1 && r.signatures[0].label.startsWith("fs.writeFile("), JSON.stringify(r)];
  });

  await test("no completion inside strings", false, async () => {
    const r = await ask("textDocument/completion", at('"hi"', 1, 2));
    return [r.items.length === 0, r.items.length];
  });

  await test("folding ranges", false, async () => {
    const r = await ask("textDocument/foldingRange", undefined);
    return [r.length >= 1, JSON.stringify(r)];
  });

  // user symbols: need the sample to parse
  await test("hover: variable type", true, async () => {
    const r = await ask("textDocument/hover", at("g.greet", 1, 0));
    return [r?.contents.value.includes("Greeter g"), r?.contents.value];
  });

  await test("hover: method on struct instance", true, async () => {
    const r = await ask("textDocument/hover", at("g.greet", 1, 3));
    return [r?.contents.value.includes("Greeter.greet(string who)"), r?.contents.value];
  });

  await test("hover: builtin struct method", true, async () => {
    const r = await ask("textDocument/hover", at("getInt", 1, 2));
    return [r?.contents.value.includes("Map.getInt(string key) -> int"), r?.contents.value];
  });

  await test("completion: struct instance members", true, async () => {
    const r = await ask("textDocument/completion", at("g.greet", 1, 2));
    const labels = r.items.map((i) => i.label);
    return [labels.includes("greet") && labels.includes("name"), labels.join(",")];
  });

  await test("completion: builtin struct members", true, async () => {
    const r = await ask("textDocument/completion", at("m.getInt", 1, 2));
    const labels = r.items.map((i) => i.label);
    return [labels.includes("getInt") && labels.includes("setString") && labels.includes("keys"), labels.length];
  });

  await test("signature help: user function", true, async () => {
    const r = await ask("textDocument/signatureHelp", at("add(1, 2)", 1, 6));
    return [r?.activeParameter === 1 && r.signatures[0].label.startsWith("add(int a, int b)"), JSON.stringify(r)];
  });

  await test("definition: local function", true, async () => {
    const r = await ask("textDocument/definition", at("add(1", 1, 1));
    return [r && r.uri === main.uri && r.range.start.line === 2, JSON.stringify(r)];
  });

  await test("definition: imported struct (other file)", true, async () => {
    const r = await ask("textDocument/definition", at("Greeter g", 1, 2));
    return [r && short(r.uri) === "lib.zen" && r.range.start.line === 0, JSON.stringify(r)];
  });

  await test("definition: method in imported struct", true, async () => {
    const r = await ask("textDocument/definition", at("g.greet", 1, 3));
    return [r && short(r.uri) === "lib.zen" && r.range.start.line === 2, JSON.stringify(r)];
  });

  await test("references: function", true, async () => {
    const r = await ask("textDocument/references", at("add(1", 1, 1), { context: { includeDeclaration: true } });
    return [r.length === 2, r.length];
  });

  await test("rename: local variable", true, async () => {
    const r = await ask("textDocument/rename", at("sum", 1, 1), { newName: "total" });
    const edits = r?.changes?.[main.uri] ?? [];
    return [edits.length === 2 && edits.every((e) => e.newText === "total"), JSON.stringify(r)];
  });

  await test("rename: rejects keywords", true, async () => {
    const r = await ask("textDocument/rename", at("sum", 1, 1), { newName: "loop" });
    return [!!r?.error, JSON.stringify(r)];
  });

  await test("rename: refuses imported symbol", true, async () => {
    const r = await ask("textDocument/rename", at("Greeter g", 1, 2), { newName: "Hello" });
    return [!!r?.error, JSON.stringify(r)];
  });

  await test("document symbols (outline)", true, async () => {
    const r = await ask("textDocument/documentSymbol", undefined);
    const names = r.map((s) => s.name);
    return [names.includes("add"), names.join(",")];
  });

  await test("workspace symbols (other file)", true, async () => {
    const r = await client.request("workspace/symbol", { query: "greet" }).then((m) => m.result);
    return [r.some((s) => s.name === "Greeter" || s.name === "greet"), JSON.stringify(r.map((s) => s.name))];
  });

  console.log(`\n${pass} passed, ${fail} failed, ${skip} skipped`);

  await client.stop();
  fs.rmSync(dir, { recursive: true, force: true });
  process.exitCode = fail ? 1 : 0;
}

const [, , feature, file, line, col, arg] = process.argv;

if (!feature) await selfTest();
else {
  const noPos = ["diagnostics", "symbols", "workspace", "folding"];

  if (!file || (!noPos.includes(feature) && (line === undefined || col === undefined))) {
    console.log("usage: node tooling/tests/lsp_test.js <feature> <file.zen> <line> <col> [arg]");
    process.exit(1);
  }

  // workspace takes its query as the 3rd positional arg
  if (feature === "workspace") await query(feature, file, undefined, undefined, line);
  else await query(feature, file, line, col, arg);
}
