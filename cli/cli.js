import { Package } from "../pkg/package.js";
import { Compiler } from "../tooling/tooling.js";

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
};

const COMPILE_COMMANDS = new Set([
  "run",
  "build",
  "ir",
  "ast",
  "tokens",
  "clean",

  "fmt", // format
]);

function help() {
  console.log(`
Zen Programming Language v1.3.0

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

Packages:
  zen install <package>
  zen uninstall <package>
  zen search <package>
  zen kind <package>
  zen mine
  zen list
  zen publish
  zen unpublish 

Account:
  zen signup
  zen login
  zen logout
  zen whoami
  zen recovery

Other:
  zen --help
  zen --version

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

    const optFlagFromCommand = this.args[2];
    const isValidOptFlag = OPT_FLAGS.includes(optFlagFromCommand);
    this.optFlag = isValidOptFlag ? optFlagFromCommand : "-O2";
  }

  async main() {
    const command = this.command;

    if (
      !command ||
      command === "--help" ||
      command === "-h" ||
      command === "help"
    ) {
      help();
      process.exit(0);
    }

    if (command === "--version" || command === "-v" || command === "version") {
      console.log("Zen v1.3.0 (latest)");
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

    if (COMPILE_COMMANDS.has(command)) {
      const compiler = new Compiler(this.args, this.optFlag);
      await compiler.compile(command);
      return;
    }
  }
}
