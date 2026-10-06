import { Package } from "../pkg/package.js";
import { Compiler } from "../tooling/tooling.js";
import { Info } from "../tooling/info/info.js";
import { Tests } from "../tooling/tests/tests.js";
import os from "os";
import path from "path";
import fs from "fs";

const VALID_COMMANDS = new Set([
  "run",
  "build",
  "ir",
  "ast",
  "tokens",
  "clean",
  "init",
  "list",
  "whoami",
  "publish",
  "install",
  "recovery",
  "mine",
  "search",
  "kind",
  "uninstall",
  "signup",
  "login",
  "logout",
  "unpublish",
  "--help",
  "-h",
  "help",
  "--version",
  "--v",
  "version",
  "update",
  "fmt",
  "lint",
  "deps",
  "installed",
  "read",
  "info",
  "test",
  "upgrade",
  "lsp"
]);

const OPT_FLAGS = ["-O0", "-O1", "-O2", "-O3"];

const PACKAGE_COMMANDS = {
  init: "init",
  signup: "signup",
  login: "login",
  logout: "logout",
  whoami: "whoami",
  list: "list",
  update: "update",
  recovery: "recovery",
  uninstall: "uninstall",
  unpublish: "unpublish",
  publish: "publish",
  search: "search",
  kind: "kind",
  mine: "mine",
  install: "install",
  deps: "deps",
  installed: "installed",
  read: "read",
  upgrade: "upgrade"
};

const COMPILE_COMMANDS = new Set([
  "run",
  "build",
  "ir",
  "ast",
  "tokens",
  "clean",

  "fmt", // format
  "lint", // linter
]);

const INFO_COMMANDS = new Set([
  "info",
]);

const TEST_COMMANDS = new Set([
  "test"
]);

function help() {
  console.log(`
Zen Programming Language v3.0.0

Usage:
  zen <command> [arguments] [options]

Run & Build:
  zen run <file> [-O0|-O1|-O2|-O3]
  zen build <file> [-O0|-O1|-O2|-O3]
  zen ir <file>
  zen ast <file>
  zen tokens <file>
  zen clean

Project:
  zen init <project-name> [--bin]

Tooling:
  zen fmt <path...> [-r|--recursive] [--no-comments]
  zen lint <file>
  zen lsp
  zen test <package-name>
  zen test (official test runner)

Packages:
  zen install <package>
  zen uninstall <package>
  zen upgrade <package>
  zen search <package>
  zen kind <package>
  zen mine
  zen list
  zen publish
  zen unpublish
  zen deps
  zen installed
  zen read <package>

Account:
  zen signup
  zen login
  zen logout
  zen whoami
  zen recovery

Information:
  zen info
  zen info namespace <name>
  zen info namespace <name> --<methodName>
  zen info global <name>
  zen info global <struct> --<methodName>

Update:
  zen update
  zen update --dev

Version:
  zen --version
  zen --v
  zen version
  zen version <package>

Other:
  zen --help
  zen --h
  zen help

Optimization Levels:
  -O0    No optimization
  -O1    Basic optimization
  -O2    Recommended (default)
  -O3    Maximum optimization

Zen REPL: 
   zen
`);
}

export class CLI {
  constructor(argv) {
    this.args = argv;
    this.command = this.args[0];

    const optFlagFromCommand = this.args[2]?.slice(1);

    const isValidOptFlag = OPT_FLAGS.includes(optFlagFromCommand);
    this.optFlag = isValidOptFlag ? optFlagFromCommand : "-O2";
  }

  async main() {
    const command = this.command;

    if (!command) {
      const compiler = new Compiler(this.args, this.optFlag);
      await compiler.repl();
      return;
    }

    if (command === "--help" || command === "--h" || command === "help") {
      help();
      process.exit(0);
    }

    if (command === "--version" || command === "--v" || command === "version") {

  // pkg version
  if (this.args[1] !== undefined) {
    const pkgName = this.args[1];
    const pkgDir = path.join(os.homedir(), ".zen_packages", pkgName);
    const zenJsonPath = path.join(pkgDir, "zen.json");

    if (!fs.existsSync(pkgDir)) {
      console.log(`Package '${pkgName}' not installed!`);
      process.exit(1);
    }

    if (!fs.existsSync(zenJsonPath)) {
      console.log(`Package '${pkgName}' has no zen.json!`);
      process.exit(1);
    }

    const zenJson = JSON.parse(fs.readFileSync(zenJsonPath, "utf8"));

    if (zenJson.version === undefined) {
      console.log(`Package '${pkgName}' has no version in zen.json!`);
      process.exit(1);
    }

    console.log(`${pkgName}@${zenJson.version}`);
    process.exit(0);
  }

  console.log("Zen v3.0.0 (latest)");
  process.exit(0);
    }
    
    if (!VALID_COMMANDS.has(command)) {
      console.error(`error: unknown command '${command}'`);
      help();
      process.exit(1);
    }

    if (command === "lsp") {
      // stdio language server, the editor launches this
      await import("../bin/lsp.js");
      return;
    }

    if (command in PACKAGE_COMMANDS) {
      const pkg = new Package(this.args);
      await pkg[PACKAGE_COMMANDS[command]]();
      return;
    }

    if (INFO_COMMANDS.has(command)) {
     const info = new Info(this.args);
     await info.run();
     return;
    }

    if (TEST_COMMANDS.has(command)) {
     const tests = new Tests(this.args);
     await tests.run();
     return;
    }

    if (COMPILE_COMMANDS.has(command)) {
      const compiler = new Compiler(this.args, this.optFlag);
      await compiler.compile(command);
      return;
    }
  }
}
