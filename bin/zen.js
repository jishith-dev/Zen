#!/usr/bin/env node

import fs from "fs";
import path from "path";
import { execSync } from "child_process";
import { fileURLToPath, pathToFileURL } from "url";

// ROOT

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// CLI install root
const COMPILER_ROOT = path.resolve(__dirname, "..");

const IRBuilder = (await import(
  pathToFileURL(path.join(COMPILER_ROOT, "src/codegen/helper/helper.js")).href
)).IRBuilder;

// HELP

const args = process.argv.slice(2);
const command = args[0];
const optFlagFromCommand = args[2]; 
const isValidOptFlag = ["-O0", "-O1", "-O2", "-O3"].includes(optFlagFromCommand);
const optFlag = isValidOptFlag ? optFlagFromCommand : "-O2"; // default -02


const validCommands = new Set([
  "run",
  "build",
  "ir",
  "ast",
  "tokens",
  "clean",
  "--help",
  "-h",
  "help",
  "--version",
  "version",
  "-v",
  "init"
]);

if (!validCommands.has(command)) {
  console.error(`error: unknown command '${command}'`);
  help();
  process.exit(1);
}

function checkDeps() {
  try {
    execSync("clang --version", { stdio: "ignore" });
    execSync("llc --version", { stdio: "ignore" });
    execSync("opt --version", { stdio: "ignore" });
  } catch {
    console.error(`error: LLVM not found. Install it with:
     Ubuntu/Debian:  sudo apt install llvm clang
     Mac:            brew install llvm
     Termux:         pkg install llvm clang`);
    process.exit(1);
  }
}

checkDeps();

function help() {
  console.log(`
Zen Programming Language

Usage:
  zen run <file>
  zen build <file>
  zen ir <file>
  zen ast <file>
  zen tokens <file>
  zen --help
  zen --version
  zen clean <file>
  zen init <project-name>
`);
}

function run(cmd) {
  try {
    execSync(cmd, { stdio: "inherit" });
  } catch (e) {
    process.exit(1);
  }
}

// HELP / VERSION

if (!command || command === "help" || command === "--help" || command === "-h") {
  help();
  process.exit(0);
}

if (command === "version" || command === "--version" || command === "-v") {
  console.log("Zen v1.1.1");
  process.exit(0);
}

if (command === "init") {

  console.log("Creating Project structure...");

  const projectName = args[1];

  if (!projectName) {
    console.error("Usage: zen init <project-name>");
    process.exit(1);
  }

  const projDir = path.resolve(projectName);

  if (fs.existsSync(projDir)) {
    console.error("Project already exists!");
    process.exit(1);
  }

  // create folders
  fs.mkdirSync(projDir, { recursive: true });

  // main.zen
  fs.writeFileSync(
    path.join(projDir, "main.zen"),
    `screen("Hello Zen")\n`
  );

  // zen.json
  const config = {
    name: projectName,
    version: "1.0.0",
    main: "main.zen"
  };

  fs.writeFileSync(
    path.join(projDir, "zen.json"),
    JSON.stringify(config, null, 2)
  );

  console.log(`Project '${projectName}' created successfully.`);
  process.exit(0);
}

// INPUT FILE

const file = args[1];

if (!file) {
  console.error("error: missing input file");
  process.exit(1);
}

const moduleName = path.basename(file, path.extname(file));
const inputFile = path.resolve(file);
const PROJECT_ROOT = path.dirname(inputFile);

const IRB = new IRBuilder(moduleName);

if (!fs.existsSync(inputFile)) {
  console.error(`error: file not found '${inputFile}'`);
  process.exit(1);
}

const source = IRB.safeReadFile(inputFile);

const Lexer = (await import(
  pathToFileURL(path.join(COMPILER_ROOT, "src/lexer/lexer.js")).href
)).Lexer;

const Parser = (await import(
  pathToFileURL(path.join(COMPILER_ROOT, "src/parser/parser.js")).href
)).Parser;

const CodeGen = (await import(
  pathToFileURL(path.join(COMPILER_ROOT, "src/codegen/codegen.js")).href
)).CodeGen;

const lexer = new Lexer(source, IRB);
const tokens = lexer.tokenize();

if (command === "tokens") {
  console.log(JSON.stringify(tokens, null, 2));
  process.exit(0);
}

const parser = new Parser(tokens, IRB);
const ast = parser.parse();

if (command === "ast") {
  console.log(JSON.stringify(ast, null, 2));
  process.exit(0);
}

// IR GENERATION

const codegen = new CodeGen(ast, moduleName); 
const llvm = codegen.generateLLVM();

if (command === "ir") {
  console.log(llvm.ir);
  process.exit(0);
}

if (!llvm) {
  process.exit(1);
}

const moduleFiles = llvm.modules ? [...llvm.modules] : [];

// BUILD DIR

const buildDir = path.join(PROJECT_ROOT, "build");
fs.mkdirSync(buildDir, { recursive: true });


 const exeName = path.basename(inputFile).replace(/\.zen$/, "");

const outLL = path.join(buildDir, `${exeName}.ll`);
const outOptLL = path.join(buildDir, `${exeName}_opt.ll`);
const outO = path.join(buildDir, `${exeName}.o`);

fs.writeFileSync(outLL, llvm.ir);

if (command === "clean") {
  fs.rmSync(path.join(PROJECT_ROOT, "build"), { recursive: true, force: true });
  console.log("Cleaned build directory");
  process.exit(0);
}

// PIPELINE

run(`opt -O2 ${outLL} -S -o ${outOptLL}`);
run(`llc -filetype=obj -relocation-model=pic ${outOptLL} -o ${outO}`);


// MODULE OBJECTS

const moduleObjs = [];

for (const ll of moduleFiles) {
  const absLL = path.resolve(PROJECT_ROOT, ll);
  const obj = absLL.replace(".ll", ".o");

  run(`llc -filetype=obj -relocation-model=pic ${absLL} -o ${obj}`);
  moduleObjs.push(obj);
}

// STD LIB + RUNTIME

const isDev = process.argv[0].endsWith("node")

const stdlibObjs = isDev ? [
  path.join(COMPILER_ROOT, "dev/constants.o"),
  path.join(COMPILER_ROOT, "dev/zen_stdlib_opt.o"),
] : [
  path.join(COMPILER_ROOT, "src/zen_stdlib/constants.o"),
  path.join(COMPILER_ROOT, "src/zen_stdlib/zen_stdlib_opt.o"),
];

const runtimeObjs = isDev ? [
  path.join(COMPILER_ROOT, "dev/runtime.o"),
  path.join(COMPILER_ROOT, "dev/listRuntime.o"),
  path.join(COMPILER_ROOT, "dev/mapRuntime.o"),
  path.join(COMPILER_ROOT, "dev/curlRuntime.o"),
] : [
  path.join(COMPILER_ROOT, "src/codegen/runtime/runtime.o"),
  path.join(COMPILER_ROOT, "src/codegen/runtime/listRuntime.o"),
  path.join(COMPILER_ROOT, "src/codegen/runtime/mapRuntime.o"),
  path.join(COMPILER_ROOT, "src/codegen/runtime/curlRuntime.o"),
];

// LINK ALL

const outputExe = path.join(buildDir, exeName);

run([
  "clang",
  outO,
  ...moduleObjs,
  ...stdlibObjs,
  ...runtimeObjs,
  optFlag,
  "-lcurl",
  "-lm",
  "-o",
  outputExe,
].join(" "));


if (command === "build") {
  console.log(`Build successful: ${outputExe}`);
  process.exit(0);
}

const userArgs = args.slice(2).join(" ");
run(`${outputExe} ${userArgs}`);