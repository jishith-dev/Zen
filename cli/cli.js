import { Package } from "../pkg/package.js";
import { Compiler } from "../tooling/tooling.js";
import { Info } from "../tooling/info/info.js";
import { Tests } from "../tooling/tests/tests.js";

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
  "-v",
  "version",
  "update",
  "fmt",
  "lint",
  "deps",
  "installed",
  "read",
  "info",
  "tests",
  "upgrade"
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
  "tests"
]);

function help() {
  console.log(`
Zen Programming Language v2.1.1

hint: ? (optional)

Usage:
  zen run <file> [-O0|-O1|-O2|-O3]?
  zen build <file> [-O0|-O1|-O2|-O3]?
  zen ir <file>
  zen ast <file>
  zen tokens <file>
  zen clean <file>
  zen update

Project:
  zen init <project-name>
  
Tooling:
  zen fmt <file> *? or **?
  zen lint <file>

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

Account:
  zen signup
  zen login
  zen logout
  zen whoami
  zen recovery

Other:
  zen --help
  zen --version
  zen info
  zen info namespace <name>
  zen info namespace <name> --<methodName>
  zen info global <name> 
  zen info global <struct> --<methodName>
  zen tests

Optimization Levels:
  -O0    No optimization
  -O1    Basic optimization
  -O2    Recommended (default)
  -O3    Maximum optimization    
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

    if (command === "--help" || command === "-h" || command === "help") {
      help();
      process.exit(0);
    }

    if (command === "--version" || command === "-v" || command === "version") {
      console.log("Zen v2.1.1 (latest)");
      process.exit(0);
    }

    if (!VALID_COMMANDS.has(command)) {
      console.error(`error: unknown command '${command}'`);
      help();
      process.exit(1);
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
