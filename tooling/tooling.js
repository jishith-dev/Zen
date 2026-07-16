import fs from "fs";
import path from "path";
import { execSync } from "child_process";
import { fileURLToPath, pathToFileURL } from "url";
import { performance } from "node:perf_hooks";
import { ModuleFiles } from "../src/codegen/lib/moduleFiles.js";

export class Compiler {
  constructor(args, optFlag) {
    this.args = args;
    this.optFlag = optFlag;
    this.source = null;
    this.moduleName = null;
    this.PROJECT_ROOT = null;
    this.COMPILER_ROOT = null;
    this.moduleFiles = new ModuleFiles();
  }

  setCompilerRoot() {
    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);
    this.COMPILER_ROOT = path.resolve(__dirname, "..");
  }

  isURL(input) {
    return /^https?:\/\//.test(input);
  }

  getSourceFiles(input) {
    const type = this.pathType(input);

    if (type === "local") {
      return [path.resolve(input)];
    }

    if (type === "project") {
      const config = JSON.parse(
        fs.readFileSync(path.join(input, "zen.json"), "utf8"),
      );

      return [path.join(input, config.main)];
    }

    if (type === "non-recurse") {
      const dir = input.slice(0, -2) || ".";

      return fs
        .readdirSync(dir, { withFileTypes: true })
        .filter(
          (e) =>
            e.isFile() &&
            e.name.endsWith(".zen") &&
            !e.name.includes(".formatted."),
        )
        .map((e) => path.join(dir, e.name));
    }

    if (type === "recurse") {
      const files = [];

      const walk = (dir) => {
        for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
          const full = path.join(dir, entry.name);

          if (entry.isDirectory()) {
            walk(full);
          } else if (
            full.endsWith(".zen") &&
            !path.basename(full).includes(".formatted.")
          ) {
            files.push(full);
          }
        }
      };

      walk(input.slice(0, -3) || ".");

      return files;
    }

    return [];
  }

  pathType(input) {
    if (this.isURL(input)) return "remote";

    if (input.endsWith("/*")) {
      return "non-recurse";
    } else if (input.endsWith("/**")) {
      return "recurse";
    }

    if (input.endsWith(".zen") && fs.existsSync(input)) return "local";
    if (fs.existsSync(path.join(input, "zen.json"))) return "project";

    return "unknown";
  }

  setProjectRoot(input) {
    const type = this.pathType(input);

    if (type === "local") {
      this.PROJECT_ROOT = path.dirname(path.resolve(input));
    } else if (type === "project") {
      this.PROJECT_ROOT = path.resolve(input);
    } else {
      this.PROJECT_ROOT = process.cwd();
    }
  }

  async fetchRemote(url) {
    try {
      const res = await fetch(url);
      if (!res.ok) {
        throw new Error(`HTTP ${res.status}`);
      }
      return await res.text();
    } catch (err) {
      console.error(`error: Failed to fetch remote: ${err.message}`);
      process.exit(1);
    }
  }

  async setSource(input, IRB) {
    const type = this.pathType(input);

    if (type === "local") {
      try {
        this.source = IRB.safeReadFile(input);
      } catch (err) {
        console.error(`error: Failed to read file: ${err.message}`);
        process.exit(1);
      }
    } else if (type === "project") {
      const configPath = path.join(input, "zen.json");

      try {
        const configText = fs.readFileSync(configPath, "utf8");
        const config = JSON.parse(configText);

        if (!config.main) {
          console.error("error: zen.json missing 'main' entry point");
          process.exit(1);
        }

        const entryPath = path.join(input, config.main);
        if (!fs.existsSync(entryPath)) {
          console.error(`error: Entry point not found: ${config.main}`);
          process.exit(1);
        }

        this.source = IRB.safeReadFile(entryPath);
      } catch (err) {
        if (err instanceof SyntaxError) {
          console.error("error: Invalid zen.json format");
        } else {
          console.error(`error: Failed to read project: ${err.message}`);
        }
        process.exit(1);
      }
    } else if (type === "remote") {
      this.source = await this.fetchRemote(input);
    } else {
      console.error(
        "error: Invalid input - expected .zen file, project dir, or URL",
      );
      process.exit(1);
    }
  }

  extractModuleName(input) {
    if (this.isURL(input)) {
      const urlPath = new URL(input).pathname;
      const base = path.basename(urlPath);
      this.moduleName = base.replace(/\.zen$/, "") || "remote_module";
    } else {
      this.moduleName = path.basename(input, path.extname(input));
    }
  }

  buildDir() {
    try {
      const buildDir = path.join(this.PROJECT_ROOT, "build");
      fs.mkdirSync(buildDir, { recursive: true });
      return buildDir;
    } catch (err) {
      console.error(`error: Failed to create build directory: ${err.message}`);
      process.exit(1);
    }
  }

  run(cmd) {
    try {
      execSync(cmd, { stdio: "inherit" });
    } catch {
      process.exit(1);
    }
  }

  async clean() {
    try {
      const buildDir = path.join(this.PROJECT_ROOT, "build");

      if (!fs.existsSync(buildDir)) {
        console.log("Build directory not found");
        process.exit(0);
      }

      fs.rmSync(buildDir, { recursive: true, force: true });
      console.log("Cleaned build directory");
    } catch (err) {
      console.error(`error: Failed to clean: ${err.message}`);
      process.exit(1);
    }
  }

  async compile(command) {
    this.setCompilerRoot();

    const file = this.args[1];

    if (!file) {
      console.error("error: missing input file");
      process.exit(1);
    }

    this.extractModuleName(file);
    this.setProjectRoot(file);

    let IRBuilder;
    try {
      IRBuilder = (
        await import(
          pathToFileURL(
            path.join(this.COMPILER_ROOT, "src/codegen/helper/helper.js"),
          ).href
        )
      ).IRBuilder;
    } catch (err) {
      console.error("error: Failed to load IRBuilder" + err);
      process.exit(1);
    }

    const IRB = new IRBuilder(this.moduleName);

    let Lexer;
    try {
      Lexer = (
        await import(
          pathToFileURL(path.join(this.COMPILER_ROOT, "src/lexer/lexer.js"))
            .href
        )
      ).Lexer;
    } catch (err) {
      console.error("error: Failed to load Lexer");
      process.exit(1);
    }

    let Parser;
    try {
      Parser = (
        await import(
          pathToFileURL(path.join(this.COMPILER_ROOT, "src/parser/parser.js"))
            .href
        )
      ).Parser;
    } catch (err) {
      console.error("error: Failed to load Parser");
      process.exit(1);
    }

    if (command === "fmt") {
      let Fmt;

      try {
        Fmt = (
          await import(
            pathToFileURL(path.join(this.COMPILER_ROOT, "tooling/fmt/fmt.js"))
              .href
          )
        ).Fmt;
      } catch (e) {
        console.error("error: Failed to load formatter");
        console.log(e);
        process.exit(1);
      }

      const formatFile = (filePath) => {
        const start = performance.now();

        const fmtIRB = new IRBuilder(path.basename(filePath, ".zen"));

        const source = fmtIRB.safeReadFile(filePath);

        const preserveComments = !process.argv.includes("--no-comments");

        const lexer = new Lexer(source, fmtIRB, 1, 1, { preserveComments });
        const tokens = lexer.tokenize();

        const parser = new Parser(tokens, fmtIRB, { preserveComments });
        const ast = parser.parse();

        const fmt = new Fmt(ast);
        const formatted = fmt.format();

        if (!formatted.trim()) {
          console.error(`error: failed to format '${filePath}'`);
          process.exit(1);
        }

        const ext = path.extname(filePath);
        const outPath = filePath.slice(0, -ext.length) + ".formatted" + ext;

        fs.writeFileSync(outPath, formatted);

        const end = performance.now();

        console.log(
          `Formatted ${filePath} -> ${outPath} (${(end - start).toFixed(2)} ms)`,
        );
      };

      const files = this.getSourceFiles(file);

      if (files.length === 0) {
        console.error("error: No .zen files found");
        process.exit(1);
      }

      for (const filePath of files) {
        formatFile(filePath);
      }

      process.exit(0);
    }

    await this.setSource(file, IRB);

    const lexer = new Lexer(this.source, IRB);
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

    let CodeGen;
    try {
      CodeGen = (
        await import(
          pathToFileURL(path.join(this.COMPILER_ROOT, "src/codegen/codegen.js"))
            .href
        )
      ).CodeGen;
    } catch (err) {
      console.error("error: Failed to load CodeGen");
      console.log(err);
      process.exit(1);
    }

    this.moduleFiles.startCompiling(file);

    const codegen = new CodeGen(ast, this.moduleName, this.moduleFiles);
    const llvm = codegen.generateLLVM();

    for (const [name, node] of this.moduleFiles.declFunctions) {
      if (!this.moduleFiles.defFunctions.has(name)) {
        IRB.emitError(
          "DeclarationError",
          `function '${name}' was declared but never defined`,
        );
      }
    }

    this.moduleFiles.finishCompiling(file);

    if (!llvm) {
      console.error("error: Code generation failed");
      process.exit(1);
    }

    if (command === "ir") {
      console.log(llvm.ir);
      process.exit(0);
    }

    const moduleFiles = this.moduleFiles.moduleFiles;
    const buildDir = this.buildDir();

    if (command === "clean") {
      await this.clean();
      return;
    }

    const outLL = path.join(buildDir, `${this.moduleName}.ll`);
    const outOptLL = path.join(buildDir, `${this.moduleName}_opt.ll`);
    const outO = path.join(buildDir, `${this.moduleName}.o`);

    try {
      fs.writeFileSync(outLL, llvm.ir);
    } catch (err) {
      console.error(`error: Failed to write IR: ${err.message}`);
      process.exit(1);
    }

    this.run(`opt ${this.optFlag} ${outLL} -S -o ${outOptLL}`);
    this.run(`llc -filetype=obj -relocation-model=pic ${outOptLL} -o ${outO}`);

    const moduleObjs = [];

    for (const ll of moduleFiles) {
      try {
        const absLL = path.resolve(this.PROJECT_ROOT, ll);
        const obj = absLL.replace(".ll", ".o");
        this.run(`llc -filetype=obj -relocation-model=pic ${absLL} -o ${obj}`);
        moduleObjs.push(obj);
      } catch (err) {
        console.error(`error: Failed to compile module: ${err.message}`);
        process.exit(1);
      }
    }

    const runtimeDir = path.join(this.COMPILER_ROOT, "src/codegen/runtime");

    const runtimeFiles = [
      "runtime",
      "listRuntime",
      "mapRuntime",
      "curlRuntime",
      "httpRuntime",
      "jsonRuntime",
    ];

    const runtimeObjs = runtimeFiles.map((name) => {
      const obj = path.join(runtimeDir, `${name}.o`);
      const src = path.join(runtimeDir, `${name}.c`);
      return fs.existsSync(obj) ? obj : src;
    });

    const stdlibDir = path.join(this.COMPILER_ROOT, "src/zen_stdlib");

    const stdlibObjs = [
      fs.existsSync(path.join(stdlibDir, "constants.o"))
        ? path.join(stdlibDir, "constants.o")
        : path.join(stdlibDir, "constants.ll"),

      fs.existsSync(path.join(stdlibDir, "zen_stdlib_opt.o"))
        ? path.join(stdlibDir, "zen_stdlib_opt.o")
        : path.join(stdlibDir, "zen_stdlib_opt.ll"),
    ];

    const outputExe = path.join(buildDir, this.moduleName);

    this.run(
      [
        "clang",
        outO,
        ...moduleObjs,
        ...stdlibObjs,
        ...runtimeObjs,
        this.optFlag,
        "-Wno-override-module",
        "-lcurl",
        "-lm",
        "-o",
        outputExe,
      ].join(" "),
    );

    if (command === "build") {
      console.log(`Build successful: ${outputExe}`);
      process.exit(0);
    }

    const userArgs = this.args.slice(3).join(" ");
    this.run(`${outputExe} ${userArgs}`);
  }
}
