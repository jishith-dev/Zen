import { Lexer } from "../../lexer/lexer.js";
import { Parser } from "../../parser/parser.js";
import { CodeGen } from "../codegen.js";
import fs from "fs";
import path from "path";
import os from "os";

export class Module {
  constructor(IRB, moduleFiles) {
    this.IRB = IRB;
    this.modules = new Map();
    this.moduleImports = new Map();
    this.generatedModules = new Map();
    this.moduleFiles = moduleFiles;
    this.curruntModuleName = "";
    this.loadingStack = new Set();
  }

  moduleAnalyser(node) {
    const source = node.source;
    const imports = node.names || [];

    // reset used namespace set
    this.IRB.usedNameSpaces = new Set();

    if (!source) {
      this.IRB.emitError("ImportError", "import requires source", node);
    }

    if (this.loadingStack.has(source) || this.moduleFiles.isCompiling(source)) {
      this.IRB.emitError(
        "ImportError",
        `Circular import detected '${source}'`,
        node,
      );
    }

    if (this.modules.has(source)) {
      this.resolveImports(imports, source);
      return;
    }

    this.loadingStack.add(source);
    this.moduleFiles.startCompiling(source);

    const file = this.IRB.loadFile(source, node);

const moduleDir = this.IRB.getModuleNativeDir(source);

const configPath = path.join(moduleDir, "zen.json");

if (fs.existsSync(configPath)) {
  const config = JSON.parse(fs.readFileSync(configPath, "utf8"));

  if (Array.isArray(config.flags)) {
    for (const flag of config.flags) {
      this.moduleFiles.addFlag(flag);
    }
  }

  if (Array.isArray(config.native)) {
  for (const nativeFile of config.native) {
    this.moduleFiles.nativeFiles.add(path.join(moduleDir, nativeFile));
  }
  }
}

    const moduleName = this.getModuleName(source);
    
    this.curruntModuleName = moduleName;

    const prevModule = this.IRB.moduleName;

    this.IRB.reset();
    this.IRB.moduleName = moduleName;

    const lexer = new Lexer(file, this.IRB);
    const tokens = lexer.tokenize();

    const parser = new Parser(tokens, this.IRB, {}, file);
    const ast = parser.parse();

    const codegen = new CodeGen(ast, moduleName, this.moduleFiles, file);

    const { ir, symbolTable, functionTable, structTable, structInitializers, exportNames } =
      codegen.generateLLVM();

    this.IRB.moduleName = prevModule;

    const tables = {
      symbolTable: symbolTable[0],
      functionTable,
      structTable,
      structInitializers,
      exportNames
    };

    const exportNode = ast.find((n) => n.type === "EXPORT");
    const exports = exportNode ? exportNode.names : [];

    this.moduleFiles.IRB = this.IRB;

    this.collectExports(exports, moduleName, tables, node);

    this.modules.set(source, {
      functions: this.extract(functionTable),
      variables: this.extract(symbolTable[0]),
      structs: this.extract(structTable),
    });

    this.resolveImports(imports, source, tables, node);

    this.generatedModules.set(source, ir);
    const llPath = this.writeLLFile(source, ir);
    this.moduleFiles.add(llPath);

    this.loadingStack.delete(source);
    this.moduleFiles.finishCompiling(source);
  }

  collectExports(exports, moduleName, tables, node) {
    if (!exports || exports.length === 0) return;

    const seen = new Set();

    for (const name of exports) {
      
      if (seen.has(name)) {
        this.IRB.emitError("ExportError", `Duplicate export '${name}'`, node);
      }
      seen.add(name);

      const ok =
        tables.functionTable.has(name) ||
        tables.symbolTable.has(name) ||
        tables.structTable.has(name);

      if (!ok) {
        this.IRB.emitError(
          "ExportError",
          `'${name}' not defined in ${moduleName}`,
          node,
        );
      }
    }
  }

  resolveImports(imports, source, tables, node) {
    for (const [structName, layout] of tables.structInitializers) {
  this.IRB.structInitializers.set(structName, layout);
    }
    const imported = this.moduleImports.get(source) || new Set();
    this.moduleImports.set(source, imported);

    const seen = new Set();

    // register all struct first so avoid dependency bug

    for (const name of imports) {
  if (tables.structTable.has(name)) {
    const s = tables.structTable.get(name);

    this.IRB.setStruct(name, s);

    this.IRB.globals.push(`declare void @_zen_init_${name}(ptr)`);
    const fields = (s.layout || []).map((f) => f.llvmType).join(", ");
    this.IRB.globals.push(`%${name} = type { ${fields} }`);
  }
    }

    for (const name of imports) {

      if (!tables.exportNames.has(name)) {
  this.IRB.emitError(
    "ImportError",
    `'${name}' not exported from ${source}`,
    node,
  );
      }
      
      if (seen.has(name)) {
        this.IRB.emitError("ImportError", `Duplicate import '${name}'`, node);
      }
      seen.add(name);

      if (imported.has(name)) {
        this.IRB.emitError(
          "ImportError",
          `'${name}' already imported from ${source}`,
          node,
        );
      }

      imported.add(name);

      if (tables.functionTable.has(name)) {
        const fn = tables.functionTable.get(name);
      

        // add imported fn flag
        fn.isImported = true;

        fn.importedModuleName = this.curruntModuleName;

        const { types } = this.IRB.buildParams(fn.params, false, fn.returnType?.type ?? fn.returnType);

        const retType = tables.structTable.has(fn.returnType?.type ?? fn.returnType)
          ? "void"
          : this.IRB.getLLVMType(fn.returnType?.type ?? fn.returnType);

        if (tables.structTable.has(fn.returnType?.type ?? fn.returnType)) {
          fn.isStructReturn = true;
        }

        if (fn?.isExtern) {
          this.IRB.globals.push(
          `declare ${retType} @${fn.name}${types}`);
        } else {
        this.IRB.globals.push(
          `declare ${retType} @zen_${this.curruntModuleName}_${fn.name}${types}`);
        }

        this.IRB.setFunction(name, fn);
        continue;
      }

      if (tables.structTable.has(name)) {
        const s = tables.structTable.get(name);
        
        // methods
        for (const [fnName, fn] of tables.functionTable) {
          if (fnName === name) continue;
          if (!fnName.startsWith(`${name}_`)) continue;

          fn.isImported = true;
          fn.importedModuleName = this.curruntModuleName;

          
          const { types } = this.IRB.buildParams(
            fn.params,
            true,
            fn.returnType.type ?? fn.returnType
          );

          const retType = tables.structTable.has(fn.returnType.type)
            ? "void"
            : this.IRB.getLLVMType(fn.returnType?.type ?? fn.returnType);
          

          if (tables.structTable.has(fn.returnType.type)) {
            fn.isStructReturn = true;
          }

          
          this.IRB.globals.push(`declare ${retType} @${fn.name}${types}`);

          this.IRB.setFunction(fnName, fn);
        }

        continue;
      }

      if (tables.symbolTable.has(name)) {
        const v = tables.symbolTable.get(name);

        this.IRB.globals.push(`${v.ptr} = external global ${v.llvmType}`);

        this.IRB.setVar(name, v);
        continue;
      }

      this.IRB.emitError(
        "ImportError",
        `'${name}' not exported from ${source}`,
        node,
      );
    }
  }

  extract(table) {
    const map = new Map();
    if (!table) return map;

    for (const [k, v] of table.entries()) {
      map.set(k, v);
    }

    return map;
  }

  writeLLFile(source, ir) {
    const dir = path.join(path.dirname(source), "build");
    fs.mkdirSync(dir, { recursive: true });

    const out = path.resolve(dir, path.basename(source, ".zen") + ".ll");
    fs.writeFileSync(out, ir);

    return out;
  }

  getModuleName(source) {
  if (source.endsWith(".zen")) {
    return path.basename(source, ".zen");
  }

  const configPath = path.join(os.homedir(), ".zen/packages", source, "zen.json");
  const config = JSON.parse(fs.readFileSync(configPath, "utf8"));
  const entry = config?.bin || config?.main;

  return path.basename(entry, ".zen");
  }
}
