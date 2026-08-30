import {
  LLVM_TYPES_MAP,
  ZEN_TYPES_MAP,
  STD_FUNCTIONS_SCHEMA,
  GLOBAL_EXTERNAL,
  COMPOUND_OPERATORS,
  BUILTIN_STRUCT_METHODS,
  BUILTIN_STRUCT_PROPS,
  TYPE_MAP,
  BUILTIN_STRUCT_ABI,
} from "../../config/config.js";

import { InferType } from "../infer/infer.js";
import fs from "fs";
import path from "path";
import os from "os";
import { execSync } from "child_process";

export class IRBuilder {
  constructor(moduleName) {
    this.globals = [];
    this.locals = [];
    this.functionBuff = [];
    this.meta = [];
    this.allocaBuff = [];

    this.currentFunction = null;
    this.functions = new Map();

    this.moduleName = moduleName;

    this.returnCount = 0;
    this.returnTypes = [];
    
    this.nextOwnerId = 1;
    this.freedOwners = new Set();

    this.reactiveMap = new Map();
    this.dependents = new Map();

    this.freedMap = new Map();

    this.errors = [];
    this.hadError = false;

    this.runtimeStack = [];
    this.aliasFreedSet = new Set();

    this.JsonParseMap = new Map();

    this.freedVars = [new Set()];
    this.freedFields = new Map();

    this.cachedStrings = new Map();

    this.currentStruct = null;
    this.usedStdFunctions = new Set();
    this.usedNameSpaces = new Set();
    this.structInitializers = new Map();
    this.exportNames = new Set();

    this.is64 = [
      "x64",
      "arm64",
      "mips64",
      "mips64el",
      "ppc64",
      "ppc64le",
      "s390x",
      "loong64",
      "riscv64",
    ];

    this.target = {
      arch: process.arch,
      platform: process.platform,
      ptrSize: this.is64.includes(process.arch) ? 8 : 4,
    };

    this.loopStack = [];
    this.loopBlockTerminated = false;
    this.loopIterationSkipped = false;

    this.diagnosticMode = false;
    this.DEBUG_IR = false; // debug mode
    this.exported = false; // exported module flag
    this.haveExport = false;
    this.stdlibMode = false; // stdlib mode toggler

    this.formatMap = this.formatMap || new Map(); // format for screen()

    this.tempCount = 0; // main counter
    this.funcTempCounter = 0;
    this.globalTempCount = 0; // global counter
    this.labelCount = 0;
    this.strCount = 0;

    this.builtins = new Map();
    this.symbolTable = [new Map()];
    this.structTable = new Map();
    this.usedStdlib = new Map();
    this.enums = new Map();
    this.functionParamTable = new Map();
  }

  reset(moduleName) {
    this.formatMap = new Map();
    this.tempCount = 0;
    this.funcTempCounter = 0;
    this.globalTempCount = 0;
    this.labelCount = 0;
    this.strCount = 0;
    this.moduleName = moduleName;
    this.returnCount = 0;
    this.returnTypes = [];
    this.haveExport = false;
    this.allocaBuff = [];
  }
  
  genOwnerId() {
    return this.nextOwnerId++;
  }

  hasPath(from, target, visited = new Set()) {
    if (from === target) {
      return true;
    }

    if (visited.has(from)) {
      return false;
    }

    visited.add(from);

    const deps = this.dependents.get(from) || [];

    for (const dep of deps) {
      if (this.hasPath(dep, target, visited)) {
        return true;
      }
    }

    return false;
  }

  updateReactive(name, visited = new Set()) {
    
    if (visited.has(name)) return;
    
    visited.add(name);

    const dependents = this.dependents.get(name) || [];
    

    for (const d of dependents) {
      const reactive = this.reactiveMap.get(d);
      const ptr = this.getVar(d).ptr;

      const expr = this.expr.handleExpression(reactive.expr);

      this.emitExpr(expr);

      this.emit(`store ${expr.llvmType} ${expr.ptr}, ptr ${ptr}`);

      this.updateReactive(d, visited);
    }
  }

  collectVarRefs(node, refs = new Set()) {
    if (!node || typeof node !== "object") {
      return [...refs];
    }

    if (node.type === "variable") {
      refs.add(node.name);
    }

    for (const value of Object.values(node)) {
      if (Array.isArray(value)) {
        for (const item of value) {
          this.collectVarRefs(item, refs);
        }
      } else if (value && typeof value === "object") {
        this.collectVarRefs(value, refs);
      }
    }

    return [...refs];
  }

  emitExpr(expr) {
    if (expr?.local?.length) this.emit(expr.local.join("\n").trim());
    if (expr?.global?.length) this.globals.push(expr.global.join("\n").trim());
  }

  enterFunction(name) {
    this.runtimeStack.push(name);
  }

  leaveFunction() {
    this.runtimeStack.pop();
  }

  setCall(expr) {
    this.expr = expr;
    this.infer = new InferType(this, this.expr);
  }
  

  setFunction(name, data, node) {
    const old = this.functions.get(name);

    if (!old) {
      this.functions.set(name, data);
      return;
    }

    if (old.isExtern) {
      this.emitError(
        "DeclarationError",
        `Cannot redefine extern function '${name}'`,
        node,
      );
    }

    if (old.isDeclaration && !data.isDeclaration) {
      this.functions.set(name, data);
      return;
    }

    this.emitError(
      "DeclarationError",
      `Function '${name}' is already defined`,
      node,
    );
  }

  guardGlobal(name, node) {
    const globalConstantsSet = new Set(Object.keys(GLOBAL_EXTERNAL));

    if (globalConstantsSet.has(name)) {
      this.emitError(
        "DeclarationError",
        `'${name}' is a reserved super global and cannot be redeclared`,
        node,
      );
    }
  }

  registerBuiltins(BUILTIN_MAP, node) {
    for (const [name, info] of Object.entries(BUILTIN_MAP)) {
      // only register used builtins
      if (!this.usedStdFunctions?.has(name)) continue;

      const finalName = info.llvmName || name;

      // guard against duplicate definition
      if (this.functions.has(finalName)) continue;

      this.setFunction(
        finalName,
        {
          name: finalName,
          returnType: info.returnType,
          isBuiltin: true,
        },
        node,
      );
    }
  }

  alignOf(type) {
    if (type === "int") return 4;
    if (type === "double") return 8;
    if (type === "long") return 8;
    if (type === "bool") return 1;
    if (type === "byte") return 1;

    // pointer backed
    if (
      type === "string" ||
      type === "Ptr" ||
      type === "List" ||
      type === "Map"
    ) {
      return this.target.ptrSize;
    }

    const structInfo = this.getStruct(type);

if (structInfo) {
  if (structInfo.isBuiltin) {
    if (structInfo.align != null) return structInfo.align;
    if (structInfo.isOpaque) return this.target.ptrSize;
  }

  let maxAlign = 1;

  for (const field of structInfo.layout) {
    const a = field.isList ? this.target.ptrSize : this.alignOf(field.type);
    maxAlign = Math.max(maxAlign, a);
  }

  return maxAlign;
}

    return this.target.ptrSize;
  }

  sizeOf(type) {
    if (type === "int") return 4;
    if (type === "long") return 8;
    if (type === "double") return 8;
    if (type === "bool") return 1;
    if (type === "byte") return 1;

    // pointer backed
    if (
      type === "string" ||
      type === "Ptr" ||
      type === "List" ||
      type === "Map"
    ) {
      return this.target.ptrSize;
    }

    const structInfo = this.getStruct(type);

    if (structInfo) {
      
      if (structInfo.isBuiltin) {
        if (structInfo?.byteSize != null) return structInfo.byteSize;
        if (structInfo.isOpaque) return this.target.ptrSize;
      }
      
      let offset = 0;
      let maxAlign = 1;

      for (const field of structInfo.layout) {
        const align = field.isList
          ? this.target.ptrSize
          : this.alignOf(field.type);

        const size = field.isList
          ? this.target.ptrSize
          : this.sizeOf(field.type);

        offset = Math.ceil(offset / align) * align;
        offset += size;

        maxAlign = Math.max(maxAlign, align);
      }

      offset = Math.ceil(offset / maxAlign) * maxAlign;

      return offset;
    }

    return this.target.ptrSize;
  }

  bindLineColumn(node) {
    const targets = [node?.value, node?.expression];

    for (const target of targets) {
      if (target) {
        target.line = node.line;
        target.column = node.column;
      }
    }
  }

  setStruct(name, data, node) {
    if (this.structTable.has(name)) {
      this.emitError(
        "DeclarationError",
        `Struct '${name}' is already defined`,
        node,
      );
    }
    this.structTable.set(name, data);
  }

  resolveMemberChain(node) {
    const chain = [];

    let current = node;

    while (current.type === "MEMBER_ACCESS") {
      chain.unshift(current.field);
      current = current.object;
    }

    return {
      base: current,
      fields: chain,
    };
  }

  getArrayChain(node) {
    const indices = [];

    let current = node;

    while (current.type === "ARRAY_ACCESS") {
      indices.push(current.index);
      current = current.array;
    }

    return {
      b: current,
      indices: indices.reverse(),
    };
  }

  getBaseArray(node) {
    if (node.type === "variable") {
      return node;
    }

    if (node.type === "ARRAY_ACCESS") {
      return this.getBaseArray(node.array);
    }

    return null;
  }

  resolveMemberChainAssign(node) {
    const chain = [];
    let current = node;

    while (current.type === "MEMBER_ACCESS") {
      chain.unshift(current.field);
      current = current.object;
    }

    let base;

    if (current.type === "variable") {
      base = current.name;
    } else if (current.type === "THIS") {
      base = "this";
    } else if (current.type === "ARRAY_ACCESS") {
      base = current;
    } else {
      this.emitError(
        "TypeError",
        `Cannot access member on non-struct type '${current.type}'`,
        node,
      );
    }

    return {
      base,
      fields: chain,
    };
  }

  getFunction(name, node) {
    if (this.functions.has(name)) {
      return this.functions.get(name);
    }

    this.emitError("ReferenceError", `Function '${name}' is not defined`, node);
  }

  getParamFunction(name, node) {
    if (this.functionParamTable.has(name)) {
      return this.functionParamTable.get(name);
    }
    
    this.emitError("ReferenceError", `callback function '${name}' not defined`, node);
  }

  typeMatches(expr, expectedType, expectedIsList = false) {
    return expr.type === expectedType && expr.isList === expectedIsList;
  }

  getStruct(name, node) {
    
    if (this.structTable.has(name)) {
      return this.structTable.get(name);
    }

    this.emitError("ReferenceError", `Struct '${name}' is not defined`, node);
  }

  utf8LenWithNull(str) {
    let bytes = 0;

    for (const ch of str) {
      const code = ch.codePointAt(0);

      if (code <= 0x7f) {
        bytes += 1;
      } else if (code <= 0x7ff) {
        bytes += 2;
      } else if (code <= 0xffff) {
        bytes += 3;
      } else {
        bytes += 4;
      }
    }

    return bytes + 1;
  }

  logSymbolTable() {
    console.log(this.symbolTable);
  }

  getSymbolTable() {
    return this.symbolTable;
  }

  declareOneTime(name, fn) {
    if (this.builtins.has(name)) {
      return;
    }

    this.builtins.set(name, fn);

    this.globals.unshift(fn);
  }

  getListElementLLVM(generic) {
    if (!generic) {
      return "ptr";
    }

    const inner = generic.generic;

    // nested list
    if (inner.type === "List") {
      return "ptr";
    }

    // struct
    if (this.hasStruct(inner.type)) {
      //return `%${inner.type}`;
      return "ptr";
    }

    // primitive
    return this.getLLVMType(inner.type);
  }

  guardStackOp(opName, node) {
    if (this.exported && !this.currentFunction) {
      this.emitError(
        "ExportError",
        `Stack operation '${opName}' is not allowed in exported module`,
        node,
      );
    }
  }

  emit(line) {
    const target = this.currentFunction
      ? this.currentFunction.body
      : this.exported
        ? null
        : this.locals;

    // if its exported module should not emit
    if (!target) return;

    // debug flag
    if (this.DEBUG_IR) {
      if (target[target.length - 1] === line) {
        this.emitError("InternalError", `Duplicate IR detected: ${line}`);
      }
    }

    target.push(line);
  }

  getLLVMType(type) {
    
    // struct ref
if (this.structTable.has(type)) {
  const s = this.getStruct(type);

  if (s.isBuiltin && s.isOpaque) {
    return "ptr";
  }

  return `%${type}`;
}

    if (type === "struct") return "ptr";

    if (type === "Map" || type === "List" || type === "ptr") {
      return "ptr";
    }

    if (type === "void") return "void";
    return LLVM_TYPES_MAP[type];
  }

  revertType(type) {
    return ZEN_TYPES_MAP[type];
  }

  getIR() {
    return [...this.meta, ...this.globals, ...this.functionBuff, ...this.locals].join("\n");
  }
  
  emitAlloca(reg, type) {
    this.allocaBuff.push(`${reg} = alloca ${type}`);
  }

  newTemp() {
    return `%t${this.currentFunction ? this.funcTempCounter++ : this.tempCount++}`;
  }

  newGlobalTemp() {
    return `@t${this.exported ? ".e" : ""}_${this.moduleName}_${this.globalTempCount++}`;
  }

  strTemp() {
    return `@.str${this.exported ? ".e" : ""}${this.stdlibMode ? "_stdlib" : ""}_${this.moduleName}_${this.strCount++}`;
  }

  newLabel(name = "label") {
    return `${name}${this.labelCount++}`;
  }

  formatDouble(value) {
    const num = Number(value);

    // ensure decimal format
    return Number.isInteger(num) ? num.toFixed(1) : num.toString();
  }

  createData({
    ptr,
    llvmType,
    type,
    isVarArg,
    isMethod,
    generic,
    isList,
    isStruct,
    length,
    isConstant,
    isGlobal,
    isValue,
    kind,
    postOrPrefix,
    isArray,
    dimensionsData,
    dimensions,
    fromParam,
    needsLoad,
    name,
    fromLoopOf,
    rawStr,
    isReactive,
    isListAccess,
    isRet,
    ownerId,
    pIndex
  }) {
    return {
      ptr,
      llvmType,
      type,
      generic,
      isList,
      isMethod,
      isStruct,
      length,
      isConstant,
      isGlobal,
      isValue,
      kind,
      postOrPrefix,
      isArray,
      isVarArg,
      dimensionsData,
      dimensions,
      fromParam,
      needsLoad,
      name,
      fromLoopOf,
      rawStr,
      isReactive,
      isListAccess,
      isRet,
      ownerId,
      pIndex
    };
  }

  initialValue(type) {
    return type === "int" || type === "bool"
    || type === "long" || type === "byte"  ? "0"
      : type === "double"
        ? "0.0" 
        : type === "string"
          ? "null"
          : "";
  }

  setVar(name, data) {
    const current = this.symbolTable[this.symbolTable.length - 1];
    if (current.has(name)) {
      this.emitError(
        "DeclarationError",
        `Variable '${name}' is already defined`,
      );
    }
    current.set(name, data);
  }

  getVar(name, node) {
    for (let i = this.symbolTable.length - 1; i >= 0; i--) {
      if (this.symbolTable[i].has(name)) {
        return this.symbolTable[i].get(name);
      }
    }

    // Function parameter?
    const paramFn = this.functionParamTable.get(name);
    if (paramFn) {
      return {
        ...paramFn,
        isFunction: true,
        needsLoad: false,
      };
    }

    // Global function?
    const fn = this.functions.get(name);
    if (fn) {
      return {
        ...fn,
        ptr: this.stdlibMode ? `@${name}` : `@zen_${this.moduleName}_${name}`,
        llvmType: "ptr",
        type: "Function",
        isFunction: true,
        needsLoad: false,
      };
    }

    this.emitError("ReferenceError", `variable ${name} is not defined`, node);
  }

  enterScope() {
    this.symbolTable.push(new Map());
    this.freedVars.push(new Set());
  }

  exitScope() {
  this.symbolTable.pop();
  this.freedVars.pop();
} 

  hasVar(name) {
    for (let i = this.symbolTable.length - 1; i >= 0; i--) {
      if (this.symbolTable[i].has(name)) {
        return true;
      }
    }
    return false;
  }

  isDeclaredInCurrentScope(name) {
    return this.symbolTable[this.symbolTable.length - 1].has(name);
  }

  loadVar(name) {
    const v = this.getVar(name);
    const tmp = this.newTemp();

    this.emit(`${tmp} = load ${v.llvmType}, ptr ${v.ptr}`);

    return tmp;
  }

  getListDepth(g) {
    if (g.type !== "List") {
      return 0;
    }

    return 1 + this.getListDepth(g.generic);
  }

  toBool(val, type, node) {
    if (type === "bool") {
      return val;
    }

    const t = this.newTemp();

    if (type === "int") {
      this.emit(`${t} = icmp ne i32 ${val}, 0`);
    } else if (type === "long") {
  this.emit(`${t} = icmp ne i64 ${val}, 0`);
    }
    else if (type === "double") {
      this.emit(`${t} = fcmp one double ${val}, 0.0`);
    } else if (type === "string") {
      const t0 = this.newTemp();
      this.emit(`${t0} = load i8, ptr ${val}`);
      this.emit(`${t} = icmp ne i8 ${t0}, 0`);
    } else {
      this.emitError("InternalError", `Cannot convert ${type} to bool`, node);
    }

    return t;
  }

  toBoolString(ptr) {
    const len = this.newTemp();
    const cmp = this.newTemp();

    this.declareOneTime("strlen", "declare i64 @strlen(ptr)");

    this.emit(`${len} = call i64 @strlen(ptr ${ptr})`);
    this.emit(`${cmp} = icmp ne i64 ${len}, 0`);

    return cmp;
  }

  toI1(ptr, type) {
    if (type === "i1") return ptr;

    const tmp = this.newTemp();

    switch (type) {
      case "i32":
      case "int":
        this.emit(`${tmp} = icmp ne i32 ${ptr}, 0`);
        return tmp;

      case "i64":
case "long":
  this.emit(`${tmp} = icmp ne i64 ${ptr}, 0`);
  return tmp;

      case "double":
        this.emit(`${tmp} = fcmp une double ${ptr}, 0.0`);
        return tmp;

      case "ptr":
      case "string":
        return this.toBoolString(ptr);

      default:
        this.emit(`${tmp} = icmp ne i32 ${ptr}, 0`);
        return tmp;
    }
  }

  getMemberPath(node) {
    let parts = [];

    while (node.type === "MEMBER_ACCESS") {
      parts.unshift(node.field);
      node = node.object;
    }

    if (node.type === "variable") {
      parts.unshift(node.name);
    }

    return parts.join("_");
  }

  getNodeLocation(node) {
    if (!node) return { line: "?", column: "?" };

    if (node.line !== undefined && node.column !== undefined) {
      return {
        line: node.line,
        column: node.column,
      };
    }

    for (const key of Object.keys(node)) {
      const value = node[key];

      if (value && typeof value === "object") {
        const loc = Array.isArray(value)
          ? this.getNodeLocation(value[0])
          : this.getNodeLocation(value);

        if (loc.line !== "?") return loc;
      }
    }

    return { line: "?", column: "?" };
  }

  emitError(type, message, node = null) {
    const isInternal = type === "InternalError";

    const finalMessage = isInternal
      ? `${message}\n\n[Compiler Bug] This should not happen. Please report this issue.`
      : message;

    if (!this.diagnosticMode) {
      this.errors.push({ type, message: finalMessage, node });
      this.hadError = true;
      this.printError(this.errors);
    } else {
      const loc = this.getNodeLocation(node);

      throw new Error(
        `[Zen Error] ${type}: ${finalMessage} at ${this.moduleName}.zen:line ${loc.line}:${loc.column}`,
      );
    }
  }

  printError() {
    const err = this.errors?.[0];
    if (!err) return;

    const RESET = "\x1b[0m";
    const RED = "\x1b[31m";
    const YELLOW = "\x1b[33m";
    const CYAN = "\x1b[36m";
    const BOLD = "\x1b[1m";

    const loc = this.getNodeLocation(err.node);

    const location =
      loc.line !== "?"
        ? `${this.moduleName}.zen:${loc.line}:${loc.column}`
        : `${this.moduleName}.zen`;

    console.error(
      `${BOLD}${RED}[Zen ${err.type}]${RESET}
  ├── ${YELLOW}${err.message}${RESET}
  └── at: ${CYAN}${location}${RESET}`,
    );
    process.exit(1);
  }

  safeReadFile(filePath) {
    try {
      return fs.readFileSync(filePath, "utf8");
    } catch (err) {
      if (err.code === "ENOENT") {
        this.emitError("FileNotFound", `Cannot find file: ${filePath}`);
      }

      throw err; // unexpected errors still crash
    }
  }

  formatValue(value, type) {
    if (type === "double") {
      return value === 0 ? "0.0" : String(value);
    }

    return String(value);
  }

  buildParams(params, isMethod = false, returnType, isExtern = false) {
    const paramStr = [];
    const paramData = [];
    const types = [];

    for (const [i, p] of params.entries()) {
      const temp = this.newTemp();

      // fn param

      if (p.type.type === "Function") {
        const llvmType = `ptr`;

        types.push(llvmType);
        paramStr.push(`${llvmType} ${temp}`);

        paramData.push({
          name: p.name,
          temp,
          ptr: temp,
          llvmType: "ptr",
          type: "Function",
          isFunction: true,
          params: p.type.params,
          returnType: p.type.returnType,
          isStructReturn: this.hasStruct(p.type.returnType.type),
        });

        continue;
      }

      // REST PARAM

      if (p.isRest) {
        if (isExtern) {
          types.push("...");
          paramStr.push(`...`);
        } else {
          types.push("ptr");
          paramStr.push(`ptr ${temp}`);
        }

        paramData.push({
          ptr: temp,
          name: p.name,
          type: p.type.type,
          llvmType: "ptr",
          isRest: true,
          isConstant: p.isConstant,
        });

        continue;
      }

      if (p.type.type === "List") {
        types.push("ptr");
        paramStr.push(`ptr ${temp}`);

        paramData.push({
          ptr: temp,
          name: p.name,
          type: p.type.generic.type,
          generic: { generic: p.type.generic },
          llvmType: "%ZenList*",
          isList: true,
          isConstant: p.isConstant,
          pIndex: i
        });

        continue;
      }

      if (this.hasStruct(p.type.type)) {
        
        
        types.push("ptr");
        paramStr.push(`ptr ${temp}`);

        paramData.push({
          ptr: temp,
          name: p.name,
          type: p.type.type,
          llvmType: "ptr",
          isStruct: true,
          isConstant: p.isConstant,
        });

        continue;
      }

      // ARRAY CHECK

      const isArray = p.type?.dimensions?.length > 0;

      if (isArray) {
        this.emitError(
          "SemanticError",
          `Fixed-size arrays cannot be passed as function parameters`
        );
      }

      // FLATTEN TYPE to LLVM TYPE

      const llvmType = this.getLLVMType(p.type.type);

      types.push(llvmType);
      paramStr.push(`${llvmType} ${temp}`);

      paramData.push({
        name: p.name,
        temp,
        llvmType,
        type: p.type.type,
        ptr: null,
        isConstant: p.isConstant,
      });
    }

    if (isMethod) {
      types.unshift("ptr");
      paramStr.unshift(`ptr %this`);
      paramData.push({
        name: "this",
        ptr: `%this`,
        type: `${this.currentStruct}`,
        llvmType: `%${this.currentStruct}*`,
        isMethod: true,
        isStruct: true,
      });
    }

    const retStruct = this.hasStruct(returnType) ? this.getStruct(returnType) : false;
    
const isOpaqueReturn = retStruct?.isBuiltin && retStruct?.isOpaque;

if (this.hasStruct(returnType) && !isOpaqueReturn) {
  paramStr.unshift(`ptr sret(%${returnType}) %sret`);
}

    return {
      ir: `(${paramStr.join(", ")})`,
      params: paramData,
      types: `(${types.join(", ")})`,
    };
  }

  getGlobalStringPtr(str) {
    const name = this.strTemp();
    const len = this.utf8LenWithNull(str);

    this.globals.push(
      `${name} = private unnamed_addr constant [${len} x i8] c"${str}\\00"`,
    );

    return `getelementptr inbounds ([${len} x i8], [${len} x i8]* ${name}, i32 0, i32 0)`;
  }

  escapeLLVMString(str) {
    return str
      .replace(/\\/g, "\\5C")
      .replace(/\n/g, "\\0A")
      .replace(/\r/g, "\\0D")
      .replace(/\t/g, "\\09")
      .replace(/"/g, "\\22");
  }

  newGlobalString(str) {
    
    this.declareOneTime("_str_dup", "declare ptr @_str_dup(ptr)");
    
    if (this.cachedStrings.has(str)) {
      const cached = this.cachedStrings.get(str);

      const tmp = this.newTemp();
      const value = this.newTemp();

      const ir = `getelementptr inbounds [${cached.len} x i8], ptr ${cached.globalName}, i64 0, i64 0`;

      this.emit(`${tmp} = ${ir}`);
      
      this.emit(`${value} = call ptr @_str_dup(ptr ${tmp})`);

      return {
        name: value,
        ir,
        local: [],
        global: [],
        rawStr: str,
        symbol: cached.globalName,
      };
    }

    const escaped = this.escapeLLVMString(str);

    const globalName = this.strTemp();

    const len = this.utf8LenWithNull(str);

    this.globals.push(
      `${globalName} = private unnamed_addr constant ` +
        `[${len} x i8] c"${escaped}\\00"`,
    );

    const tmp = this.newTemp();
    const value = this.newTemp();

    const ir = `getelementptr inbounds [${len} x i8], ptr ${globalName}, i64 0, i64 0`;

    this.emit(`${tmp} = ${ir}`);
    
    this.emit(`${value} = call ptr @_str_dup(ptr ${tmp})`);

    // cache ONLY global data
    this.cachedStrings.set(str, {
      globalName,
      len,
    });

    return {
      name: value,
      ir,
      local: [],
      global: [],
      rawStr: str,
      symbol: globalName,
    };
  }

  validateCallArgs(fn, args, isRest, restIndex = null, node) {
    const params = fn.params;

    // NORMAL CALL

    if (!isRest) {
      if (params.length !== args.length) {
        this.emitError(
          "ArgumentError",
          `'${fn.name}' accepts exactly ${params.length} argument(s), got ${args.length}`,
          node,
        );
      }

      for (let i = 0; i < params.length; i++) {
        const expected = params[i].type;
        const actual = args[i];

        // CALLBACK VALIDATION
        if (expected.type === "Function") {
          if (!actual?.isFunction) {
            this.emitError(
              "TypeError",
              `Argument ${i + 1} of '${fn.name}' expects a callback`,
              node,
            );
          }

          if (expected.params.length !== actual.params.length) {
            this.emitError(
              "TypeError",
              `Callback '${actual.name}' does not match parameter '${params[i].name}': expected ${expected.params.length} parameter(s), got ${actual.params.length}`,
              node,
            );
          }

          for (let j = 0; j < expected.params.length; j++) {
            const expectedType = expected.params[j].type.type;
            const actualType = actual.params[j].type.type;

            if (expectedType !== actualType) {
              this.emitError(
                "TypeError",
                `Callback '${actual.name}' does not match parameter '${params[i].name}': parameter ${j + 1} expects '${expectedType}', got '${actualType}'`,
                node,
              );
            }
          }

          const expectedReturn = expected.returnType.type;
          const actualReturn = actual.returnType;

          if (expectedReturn !== actualReturn) {
            this.emitError(
              "TypeError",
              `Callback '${actual.name}' does not match parameter '${params[i].name}': expected return type '${expectedReturn}', got '${actualReturn}'`,
              node,
            );
          }

          continue;
        }

        // NORMAL TYPE CHECK
        const expectedType = expected.type === "List" ? "List" : expected.type;

        const actualType = actual?.isList ? "List" : actual?.type;

        if (expectedType !== actualType) {
          this.emitError(
            "TypeError",
            `Argument type mismatch in '${fn.name}' — expected (${expectedType}), got (${actualType})`,
            node,
          );
        }
      }

      return;
    }

    // REST CALL (INDEX BASED)

    if (restIndex === null || restIndex < 0) {
      this.emitError("InternalError", "invalid restIndex", node);
    }

    for (let i = 0; i < restIndex; i++) {
      const expected =
        params[i].type.type === "List"
          ? params[i].type.generic.type
          : params[i].type.type;

      const actual = args[i]?.type;

      if (actual && expected !== actual) {
        this.emitError(
          "TypeError",
          `'${fn.name}' expects type '${expected}', got '${actual}'`,
          node,
        );
      }
    }

    // REST VALIDATION

    const restType = args[restIndex]?.type;

    for (let i = restIndex; i < args.length; i++) {
      const actual = args[i]?.type;

      if (actual !== restType) {
        this.emitError(
          "TypeError",
          `'${fn.name}' rest parameter expects type '${restType}', got '${actual}'`,
          node,
        );
      }
    }
  }

  emitScreenDouble(val, format = "%lf\n") {
    this.formatMapDouble = this.formatMapDouble || new Map();

    let id;

    if (this.formatMapDouble.has(format)) {
      id = this.formatMapDouble.get(format);
    } else {
      id = this.formatMapDouble.size;
      this.formatMapDouble.set(format, id);

      const { llvmStr, length } = this.toLLVMString(format);

      const fmtName = `fmt_double_${this.moduleName}_${id}`;
      const fnName = `_screen_double_${this.moduleName}_${id}`;

      this.declareOneTime(
        fmtName,
        `@.${fmtName} = private constant [${length} x i8] c"${llvmStr}"`,
      );

      this.declareOneTime(
        fnName,
        `define void @${fnName}(double %x) {
entry:
  call i32 (ptr, ...) @printf(ptr getelementptr ([${length} x i8], [${length} x i8]* @.${fmtName}, i32 0, i32 0),
    double %x)
  call i32 @fflush(ptr null)
  ret void
}`,
      );
    }

    const fnName = `_screen_double_${this.moduleName}_${id}`;

    this.emit(`call void @${fnName}(double ${val})`);
  }

  emitScreenInt(val, format = "%d\n") {
    this.formatMapInt = this.formatMapInt || new Map();

    let id;

    if (this.formatMapInt.has(format)) {
      id = this.formatMapInt.get(format);
    } else {
      id = this.formatMapInt.size;
      this.formatMapInt.set(format, id);

      const { llvmStr, length } = this.toLLVMString(format);

      const fmtName = `fmt_int_${this.moduleName}_${id}`;
      const fnName = `_screen_int_${this.moduleName}_${id}`;

      this.declareOneTime(
        fmtName,
        `@.${fmtName} = private constant [${length} x i8] c"${llvmStr}"`,
      );

      this.declareOneTime(
        fnName,
        `define void @${fnName}(i32 %x) {
entry:
  call i32 (ptr, ...) @printf(ptr getelementptr ([${length} x i8], [${length} x i8]* @.${fmtName}, i32 0, i32 0),
    i32 %x)
  call i32 @fflush(ptr null)
  ret void
}`,
      );
    }

    const fnName = `_screen_int_${this.moduleName}_${id}`;

    this.emit(`call void @${fnName}(i32 ${val})`);
  }

  emitScreenByte(val, format = "%d\n") {
  this.formatMapByte = this.formatMapByte || new Map();

  let id;

  if (this.formatMapByte.has(format)) {
    id = this.formatMapByte.get(format);
  } else {
    id = this.formatMapByte.size;
    this.formatMapByte.set(format, id);

    const { llvmStr, length } = this.toLLVMString(format);

    const fmtName = `fmt_byte_${this.moduleName}_${id}`;
    const fnName = `_screen_byte_${this.moduleName}_${id}`;

    this.declareOneTime(
      fmtName,
      `@.${fmtName} = private constant [${length} x i8] c"${llvmStr}"`,
    );

    this.declareOneTime(
      fnName,
      `define void @${fnName}(i8 %x) {
entry:
  %extended = sext i8 %x to i32
  call i32 (ptr, ...) @printf(ptr getelementptr ([${length} x i8], [${length} x i8]* @.${fmtName}, i32 0, i32 0),
    i32 %extended)
  call i32 @fflush(ptr null)
  ret void
}`,
    );
  }

  const fnName = `_screen_byte_${this.moduleName}_${id}`;

  this.emit(`call void @${fnName}(i8 ${val})`);
  }

  emitScreenLong(val, format = "%lld\n") {
  this.formatMapLong = this.formatMapLong || new Map();

  let id;

  if (this.formatMapLong.has(format)) {
    id = this.formatMapLong.get(format);
  } else {
    id = this.formatMapLong.size;
    this.formatMapLong.set(format, id);

    const { llvmStr, length } = this.toLLVMString(format);

    const fmtName = `fmt_long_${this.moduleName}_${id}`;
    const fnName = `_screen_long_${this.moduleName}_${id}`;

    this.declareOneTime(
      fmtName,
      `@.${fmtName} = private constant [${length} x i8] c"${llvmStr}"`,
    );

    this.declareOneTime(
      fnName,
      `define void @${fnName}(i64 %x) {
entry:
  call i32 (ptr, ...) @printf(ptr getelementptr ([${length} x i8], [${length} x i8]* @.${fmtName}, i32 0, i32 0),
    i64 %x)
  call i32 @fflush(ptr null)
  ret void
}`,
    );
  }

  const fnName = `_screen_long_${this.moduleName}_${id}`;

  this.emit(`call void @${fnName}(i64 ${val})`);
  }
  
  toLLVMString(str) {
  let result = "";
  let len = 0;

  for (let i = 0; i < str.length; i++) {
    const c = str[i];

    switch (c) {
      case "\0":
        result += "\\00";
        break;

      case "\x07":
        result += "\\07";
        break;

      case "\b":
        result += "\\08";
        break;

      case "\t":
        result += "\\09";
        break;

      case "\n":
        result += "\\0A";
        break;

      case "\v":
        result += "\\0B";
        break;

      case "\f":
        result += "\\0C";
        break;

      case "\r":
        result += "\\0D";
        break;

      case '"':
        result += "\\22";
        break;

      case "\\":
        result += "\\5C";
        break;

      default:
        result += c;
    }

    len++;
  }

  result += "\\00";
  len++;

  return {
    llvmStr: result,
    length: len,
  };
}

  emitScreenString(val, format) {
    this.formatMap = this.formatMap || new Map();

    let id;

    if (this.formatMap.has(format)) {
      id = this.formatMap.get(format);
    } else {
      id = this.formatMap.size;
      this.formatMap.set(format, id);

      const { llvmStr, length } = this.toLLVMString(format);

      const fmtName = `fmt_string_${this.moduleName}_${id}`;
      const fnName = `_screen_string_${this.moduleName}_${id}`;

      this.declareOneTime(
        fmtName,
        `@.${fmtName} = private constant [${length} x i8] c"${llvmStr}"`,
      );

      this.declareOneTime(
        fnName,
        `define void @${fnName}(ptr %x) {
entry:
  call i32 (ptr, ...) @printf(ptr getelementptr ([${length} x i8], [${length} x i8]* @.${fmtName}, i32 0, i32 0),
    ptr %x)
  call i32 @fflush(ptr null)
  ret void
}`,
      );
    }

    const fnName = `_screen_string_${this.moduleName}_${id}`;

    this.emit(`call void @${fnName}(ptr ${val})`);
  }

  emitScreenBool(val) {
    this.declareOneTime(
      "fmt_bool_t",
      '@.fmt_bool_t = private constant [6 x i8] c"true\\0A\\00"',
    );
    this.declareOneTime(
      "fmt_bool_f",
      '@.fmt_bool_f = private constant [7 x i8] c"false\\0A\\00"',
    );

    this.declareOneTime(
      "screen_bool",
      `define void @_screen_bool(i1 %b) {
entry:
  br i1 %b, label %true, label %false
true:
  call i32 (ptr, ...) @printf(ptr getelementptr ([6 x i8], [6 x i8]* @.fmt_bool_t, i32 0, i32 0))
  call i32 @fflush(ptr null)
  br label %end
false:
  call i32 (ptr, ...) @printf(ptr getelementptr ([7 x i8], [7 x i8]* @.fmt_bool_f, i32 0, i32 0))
  call i32 @fflush(ptr null)
  br label %end
end:
  ret void
}`,
    );

    this.emit(`call void @_screen_bool(i1 ${val})`);
  }

  containsUnary(node) {
    if (!node) return false;

    if (
      node.type === "UNARY_EXPRESSION" &&
      (node.operator === "++" || node.operator === "--")
    ) {
      this.emitError(
        "SyntaxError",
        `'++' and '--' are only valid as standalone statements or assignment targets`,
        node,
      );
    }

    return (
      this.containsUnary(node.left) ||
      this.containsUnary(node.right) ||
      this.containsUnary(node.argument)
    );
  }

  normalizeNode(node) {
    if (node.type === "VARIABLE_DECLARATION") return node;

    if (node.type === "VARIABLE_REFERENCE") {
      const expr = node.expression;
      const data = this.getVar(expr.name);

      return {
        type: "VARIABLE_REFERENCE",
        dataType: data.type,
        isConstant: data.isConstant,
        name: expr.name,
        value: expr.value,
      };
    }

    return node;
  }

  // array helpers

  validateArrayType(type, node, expectedZenType, name) {
    // leaf
    if (node.type !== "ARRAY") {
      const res = this.expr.handleExpression(node);
      const actualType = res.type;

      if (actualType !== expectedZenType) {
        this.emitError(
          "TypeError",
          `Cannot assign '${actualType}' to variable '${name}' of type '${expectedZenType}'`,
          node,
        );
      }

      return;
    }

    const match = type.match(/^\[(\d+) x (.*)\]$/);
    if (!match)
      this.emitError("SyntaxError", `Invalid array type declaration`, node);

    const size = parseInt(match[1]);
    const innerType = match[2];

    if (node.elements.length !== size) {
      this.emitError(
        "ArrayError",
        `Array '${name}' declared with size ${size} but got ${node.elements.length} element(s)`,
        node,
      );
    }

    node.elements.forEach((el) =>
      this.validateArrayType(innerType, el, expectedZenType, name),
    );
  }

  buildArrayType(baseType, dims) {
    let type = baseType;

    for (let i = dims.length - 1; i >= 0; i--) {
      type = `[${dims[i]} x ${type}]`;
    }

    return {
      full: type,
      base: baseType,
    };
  }

  buildGlobalInit(type, node, baseType, zenType, isTop = false) {
    // leaf
    if (node.type !== "ARRAY") {
      if (node.type !== zenType) {
        this.emitError(
          "DeclarationError",
          `Global array '${node.name}' initializer must be a compile-time constant`,
          node,
        );
      }

      if (zenType === "bool") {
        return `${baseType} ${node.value ? 1 : 0}`;
      }

      if (zenType === "double") {
        return `${baseType} ${this.formatDouble(node.value)}`;
      }

      if (zenType === "string") {
        const gep = this.getGlobalStringPtr(node.value);
        return `ptr ${gep}`;
      }

      return `${baseType} ${node.value}`;
    }

    const match = type.match(/^\[(\d+) x (.*)\]$/);
    const innerType = match[2];

    const elements = node.elements.map((el) =>
      this.buildGlobalInit(innerType, el, baseType, zenType, false),
    );

    const body = `[${elements.join(", ")}]`;

    return isTop ? body : `${type} ${body}`;
  }

  validateArray(dimensions, node, depth = 0) {
    if (depth >= dimensions.length) return;

    if (node.type !== "ARRAY") {
      this.emitError(
        "SyntaxError",
        `Invalid array structure — expected a valid array literal`,
        node,
      );
    }

    const expected = Number(
      dimensions[depth].type === "int"
        ? dimensions[depth].value
        : this.constEval(dimensions[depth], "Array dimension"),
    );

    if (node.elements.length !== expected) {
      this.emitError(
        "ArrayError",
        `Array size mismatch at dimension ${depth} — expected ${expected} element(s), got ${node.elements.length}`,
        node,
      );
    }

    node.elements.forEach((el) =>
      this.validateArray(dimensions, el, depth + 1),
    );
  }

  flattenArray(node, indices = [], out = []) {
    if (node.type !== "ARRAY") {
      out.push({ indices, node });
      return out;
    }

    node.elements.forEach((el, i) => {
      this.flattenArray(el, [...indices, i], out);
    });

    return out;
  }

  arrayInit(
    name,
    dimensions,
    value,
    isGlobal,
    baseType = "i32",
    zenType = "int",
    isConstant,
    node,
  ) {
    // dimensions validation

    const dims = dimensions.map((d) => {
      if (d.type === "int") {
        return d.value;
      }

      if (d.type === "BINARY_EXPRESSION") {
        const val = this.constEval(d, "Array dimension");

        if (typeof val !== "number") {
          this.emitError(
            "ArrayError",
            `Array dimension must be a compile-time constant integer`,
            node,
          );
        }

        return val;
      }

      this.emitError(
        "ArrayError",
        `Array dimension must be a positive integer greater than 0`,
        node,
      );
    });

    if (dims[0] === 0) {
      this.emitError(
        "ArrayError",
        `Array size must be a positive integer greater than 0`,
        node,
      );
    }

    const { full: arrayType } = this.buildArrayType(
      baseType,
      dims,
    );
    const elementSize = this.sizeOf(zenType);
    const length = value.elements.length;
    if (value && value.elements.length > 0) {
      this.validateArrayType(arrayType, value, zenType, name);
      this.validateArray(dimensions, value);
    }

    if (isGlobal) {
      const ptr = this.newGlobalTemp();

      if (!value || value.elements.length === 0) {
        return {
          ir: [
            `${ptr} = ${isConstant ? "constant" : "global"} ${arrayType} zeroinitializer`,
          ],
          ptr,
          llvmType: arrayType,
          length,
        };
      }

      const init = this.buildGlobalInit(
        arrayType,
        value,
        baseType,
        zenType,
        true,
      );
      return {
        ir: [
          `${ptr} = ${isConstant ? "constant" : "global"} ${arrayType} ${init}`,
        ],
        ptr,
        llvmType: arrayType,
        length,
      };
    }

    let ir = [];
    const ptr = this.newTemp();

    this.emitAlloca(ptr, arrayType);

    // zero init
    if (!value || value.elements.length === 0) {
      const totalSize = dims.reduce((a, b) => a * b, 1) * elementSize;

      const cast = this.newTemp();

      ir.push(`${cast} = bitcast ${arrayType}* ${ptr} to ptr`);

      ir.push(
        `call void @llvm.memset.p0i8.i64(ptr ${cast}, i8 0, i64 ${totalSize}, i1 false)`,
      );

      return { ir, ptr, llvmType: arrayType, length };
    }

    const flat = this.flattenArray(value);

    flat.forEach((item) => {
      const gep = this.newTemp();

      const indices = ["i32 0", ...item.indices.map((i) => `i32 ${i}`)].join(
        ", ",
      );

      ir.push(
        `${gep} = getelementptr ${arrayType}, ${arrayType}* ${ptr}, ${indices}`,
      );

      const res = this.expr.handleExpression(item.node);

      if (res.local.length) ir.push(...res.local);
      if (res.global.length) ir.push(...res.global);

      ir.push(`store ${res.llvmType} ${res.ptr}, ptr ${gep}`);
    });

    return { ir, ptr, llvmType: arrayType, length };
  }

  getElementType(typeStr) {
    // remove pointer layer
    if (typeStr?.endsWith("*")) {
      return typeStr.slice(0, -1);
    }

    // array layer
    const match = typeStr.match(/^\[(\d+)\s+x\s+(.+)\]$/);
    if (match) {
      return match[2].trim();
    }

    return typeStr;
  }

  hasStruct(name) {
    return this.structTable && this.structTable.has(name);
  }

  getArrayElementType(type) {
    // [2 x [2 x i32]] to [2 x i32]
    const match = type.match(/^\[\d+ x (.+)\]$/);
    return match ? match[1] : type;
  }

  castExpression(expr, targetType, fnName, node, fromTemporary = false) {
    
    if (expr.type === targetType) {
      return expr;
    }
    let local = [];

    const t = this.newTemp();

    // INT -> BYTE

if (expr.type === "int" && targetType === "byte") {
  local.push(`${t} = trunc i32 ${expr.ptr} to i8`);

  return {
    ptr: t,
    llvmType: "i8",
    type: "byte",
    local,
    isTemp: fromTemporary
  };
}

// LONG -> BYTE

if (expr.type === "long" && targetType === "byte") {
  local.push(`${t} = trunc i64 ${expr.ptr} to i8`);

  return {
    ptr: t,
    llvmType: "i8",
    type: "byte",
    local,
    isTemp: fromTemporary
  };
}

// BOOL -> BYTE

if (expr.type === "bool" && targetType === "byte") {
  local.push(`${t} = zext i1 ${expr.ptr} to i8`);

  return {
    ptr: t,
    llvmType: "i8",
    type: "byte",
    local,
    isTemp: fromTemporary
  };
}

// DOUBLE -> BYTE

if (expr.type === "double" && targetType === "byte") {
  const intTemp = this.newTemp();

  local.push(`${intTemp} = fptosi double ${expr.ptr} to i32`);
  local.push(`${t} = trunc i32 ${intTemp} to i8`);

  return {
    ptr: t,
    llvmType: "i8",
    type: "byte",
    local,
    isTemp: fromTemporary
  };
}

// STRING -> BYTE

if (expr.type === "string" && targetType === "byte") {
  this.declareOneTime(
    "string_to_byte",
    "declare i8 @_string_to_byte(ptr)",
  );

  local.push(
    `${t} = call i8 @_string_to_byte(ptr ${expr.ptr})`
  );

  return {
    ptr: t,
    llvmType: "i8",
    type: "byte",
    local,
    isTemp: fromTemporary
  };
}

// BYTE -> STRING

if (expr.type === "byte" && targetType === "string") {
  this.declareOneTime(
    "byte_to_string",
    "declare ptr @_byte_to_string(i8)",
  );

  local.push(
    `${t} = call ptr @_byte_to_string(i8 ${expr.ptr})`
  );

  return {
    ptr: t,
    llvmType: "ptr",
    type: "string",
    local,
    isTemp: fromTemporary,
  };
}

    if (fnName === "toInt") {
      if (expr.type === "string" && targetType === "int") {
        this.declareOneTime(
          "string_to_int_ascii",
          "declare i32 @_string_to_int_ascii(ptr)",
        );

        local.push(`${t} = call i32 @_string_to_int_ascii(ptr ${expr.ptr})`);

        return {
          ptr: t,
          llvmType: "i32",
          type: "int",
          local,
          isTemp: fromTemporary
        };
      }
    }
    if (fnName === "toString")
      if (expr.type === "int" && targetType === "string") {
        this.declareOneTime(
          "int_to_string_ascii",
          "declare ptr @_int_to_string_ascii(i32)",
        );

        local.push(`${t} = call ptr @_int_to_string_ascii(i32 ${expr.ptr})`);

        return {
          ptr: t,
          llvmType: "ptr",
          type: "string",
          local,
          isTemp: fromTemporary
        };
      }

    // INT  BOOL

    if (expr.type === "int" && targetType === "bool") {
      local.push(`${t} = icmp ne i32 ${expr.ptr}, 0`);

      return {
        ptr: t,
        llvmType: "i1",
        type: "bool",
        local,
      };
    }

    // BOOL  INT

    if (expr.type === "bool" && targetType === "int") {
      local.push(`${t} = zext i1 ${expr.ptr} to i32`);

      return {
        ptr: t,
        llvmType: "i32",
        type: "int",
        local,
      };
    }

    // LONG STRING

if (expr.type === "long" && targetType === "string") {
  this.declareOneTime(
    "long_to_string",
    "declare ptr @_long_to_string(i64)",
  );

  local.push(`${t} = call ptr @_long_to_string(i64 ${expr.ptr})`);

  return {
    ptr: t,
    llvmType: "ptr",
    type: "string",
    local,
    isTemp: fromTemporary
  };
}

    // LONG -> INT

if (expr.type === "long" && targetType === "int") {
  local.push(`${t} = trunc i64 ${expr.ptr} to i32`);

  return {
    ptr: t,
    llvmType: "i32",
    type: "int",
    local,
  };
}

// INT -> LONG

if (expr.type === "int" && targetType === "long") {
  local.push(`${t} = sext i32 ${expr.ptr} to i64`);

  return {
    ptr: t,
    llvmType: "i64",
    type: "long",
    local,
  };
}

// LONG -> BOOL

if (expr.type === "long" && targetType === "bool") {
  local.push(`${t} = icmp ne i64 ${expr.ptr}, 0`);

  return {
    ptr: t,
    llvmType: "i1",
    type: "bool",
    local,
  };
}

// BOOL -> LONG

if (expr.type === "bool" && targetType === "long") {
  local.push(`${t} = zext i1 ${expr.ptr} to i64`);

  return {
    ptr: t,
    llvmType: "i64",
    type: "long",
    local,
  };
}

// LONG -> DOUBLE

if (expr.type === "long" && targetType === "double") {
  local.push(`${t} = sitofp i64 ${expr.ptr} to double`);

  return {
    ptr: t,
    llvmType: "double",
    type: "double",
    local,
  };
}

// DOUBLE -> LONG

if (expr.type === "double" && targetType === "long") {
  local.push(`${t} = fptosi double ${expr.ptr} to i64`);

  return {
    ptr: t,
    llvmType: "i64",
    type: "long",
    local,
  };
}

    // INT  DOUBLE

    if (expr.type === "int" && targetType === "double") {
      local.push(`${t} = sitofp i32 ${expr.ptr} to double`);

      return {
        ptr: t,
        llvmType: "double",
        type: "double",
        local,
      };
    }

    // DOUBLE  INT

    if (expr.type === "double" && targetType === "int") {
      local.push(`${t} = fptosi double ${expr.ptr} to i32`);

      return {
        ptr: t,
        llvmType: "i32",
        type: "int",
        local,
      };
    }

    // BOOL  DOUBLE

    if (expr.type === "bool" && targetType === "double") {
      const intTemp = this.newTemp();

      local.push(`${intTemp} = zext i1 ${expr.ptr} to i32`);

      local.push(`${t} = sitofp i32 ${intTemp} to double`);

      return {
        ptr: t,
        llvmType: "double",
        type: "double",
        local,
      };
    }

    // DOUBLE  BOOL

    if (expr.type === "double" && targetType === "bool") {
      const t = this.newTemp();

      local.push(`${t} = fcmp une double ${expr.ptr}, 0.0`);

      return {
        ptr: t,
        llvmType: "i1",
        type: "bool",
        local,
      };
    }

    // INT STRING

    if (expr.type === "int" && targetType === "string") {
      this.declareOneTime("int_to_string", "declare ptr @_int_to_string(i32)");

      local.push(`${t} = call ptr @_int_to_string(i32 ${expr.ptr})`);

      return {
        ptr: t,
        llvmType: "ptr",
        type: "string",
        local,
        isTemp: fromTemporary
      };
    }

    // DOUBLE  STRING

    if (expr.type === "double" && targetType === "string") {
      this.declareOneTime(
        "double_to_string",
        "declare ptr @_double_to_string(double)",
      );

      local.push(`${t} = call ptr @_double_to_string(double ${expr.ptr})`);

      return {
        ptr: t,
        llvmType: "ptr",
        type: "string",
        local,
        isTemp: fromTemporary
      };
    }

    // BOOL  STRING

    if (expr.type === "bool" && targetType === "string") {
      this.declareOneTime("bool_to_string", "declare ptr @_bool_to_string(i1)");
      local.push(`${t} = call ptr @_bool_to_string(i1 ${expr.ptr})`);

      return {
        ptr: t,
        llvmType: "ptr",
        type: "string",
        local,
        isTemp: fromTemporary
      };
    }

    // STRING INT

    if (expr.type === "string" && targetType === "int") {
      this.declareOneTime("string_to_int", "declare i32 @_string_to_int(ptr)");

      local.push(`${t} = call i32 @_string_to_int(ptr ${expr.ptr})`);

      return {
        ptr: t,
        llvmType: "i32",
        type: "int",
        local,
      };
    }

    // STRING  DOUBLE

    if (expr.type === "string" && targetType === "double") {
      this.declareOneTime(
        "string_to_double",
        "declare double @_string_to_double(ptr)",
      );

      local.push(`${t} = call double @_string_to_double(ptr ${expr.ptr})`);

      return {
        ptr: t,
        llvmType: "double",
        type: "double",
        local,
      };
    }
  
    // STRING  BOOL

    if (expr.type === "string" && targetType === "bool") {
      const len = this.newTemp();
      const res = this.newTemp();
      this.declareOneTime("strlen", "declare i64 @strlen(ptr)");

      local.push(`${len} = call i64 @strlen(ptr ${expr.ptr})`);
      local.push(`${res} = icmp ne i64 ${len}, 0`);

      return {
        ptr: res,
        llvmType: "i1",
        type: "bool",
        local,
      };
    }

    this.emitError(
      "TypeError",
      `Cannot cast '${expr.type}' to '${targetType}'`,
      node,
    );
  }

  loadGlobalConstants() {
    const g = this.symbolTable[0]; // global scope

    g.set(
      "PI",
      this.createData({
        ptr: "@PI",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "SEED",
      this.createData({
        ptr: "@SEED",
        llvmType: "i32",
        type: "int",
        isConstant: false,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "TAU",
      this.createData({
        ptr: "@TAU",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "E",
      this.createData({
        ptr: "@E",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "PHI",
      this.createData({
        ptr: "@PHI",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "SQRT2",
      this.createData({
        ptr: "@SQRT2",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "LN2",
      this.createData({
        ptr: "@LN2",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "LN10",
      this.createData({
        ptr: "@LN10",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "I32_MAX",
      this.createData({
        ptr: "@I32_MAX",
        llvmType: "i32",
        type: "int",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "I32_MIN",
      this.createData({
        ptr: "@I32_MIN",
        llvmType: "i32",
        type: "int",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "F64_MAX",
      this.createData({
        ptr: "@F64_MAX",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "F64_MIN",
      this.createData({
        ptr: "@F64_MIN",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "F64_EPS",
      this.createData({
        ptr: "@F64_EPS",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "INF",
      this.createData({
        ptr: "@INF",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "NEG_INF",
      this.createData({
        ptr: "@NEG_INF",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );

    g.set(
      "NAN",
      this.createData({
        ptr: "@NAN",
        llvmType: "double",
        type: "double",
        isConstant: true,
        isGlobal: true,
        kind: "external",
        needsLoad: true,
      }),
    );
  }

  setStdlibFunctions(node) {
    for (const name of this.usedStdFunctions) {
      if (this.functions.has(name)) continue;

      const fn = STD_FUNCTIONS_SCHEMA[name];

      if (!fn) {
        this.emitError("InternalError", `Missing stdlib: ${name}`);
        continue;
      }

      const params = fn.params.map((type, i) => ({
        type: { type: this.revertType(type) },
        name: `p${i}`,
      }));

      const isListReturn = ["split"].includes(name);

      this.setFunction(
        `${name}`,
        {
          name,
          returnType: isListReturn ? "List" : this.revertType(fn.ret),
          params,
          retGeneric: isListReturn ? "string" : this.revertType(fn.ret), // temp for minimal check now. coz 'split' is the only list return. can be extend later
        },
        node,
      );
    }
  }

  normalizeGeneric(meta) {
    if (!meta) {
      return null;
    }

    // already normalized
    if (typeof meta === "object" && meta.type) {
      return meta;
    }

    // primitive string
    return {
      type: meta,
      llvmType: this.getLLVMType(meta),
      isList: false,
      elementType: null,
    };
  }

  buildMapRecursive(parentMapPtr, mapLiteral) {
    this.declareOneTime(
      "zen_map_set_int",
      "declare void @zen_map_set_int(ptr, ptr, i32)",
    );
    this.declareOneTime(
      "zen_map_set_bool",
      "declare void @zen_map_set_bool(ptr, ptr, i1)",
    );
    this.declareOneTime(
      "zen_map_set_double",
      "declare void @zen_map_set_double(ptr, ptr, double)",
    );
    this.declareOneTime(
      "zen_map_set_string",
      "declare void @zen_map_set_string(ptr, ptr, ptr)",
    );
    this.declareOneTime(
      "zen_map_set_list",
      "declare void @zen_map_set_list(ptr, ptr, ptr, i32, i32)",
    );
    this.declareOneTime(
      "zen_map_set_map",
      "declare void @zen_map_set_map(ptr, ptr, ptr)",
    );
    this.declareOneTime("zen_map_new", "declare ptr @_zen_map_new()");

    for (const prop of mapLiteral.properties) {
      const keyPtr = this.newGlobalString(prop.key);

      // NESTED MAP
      if (prop.value.type === "STRUCT_LITERAL") {
        const nestedMapPtr = this.newTemp();
        this.emit(`${nestedMapPtr} = call ptr @_zen_map_new()`);
        this.buildMapRecursive(nestedMapPtr, prop.value);

        this.emit(
          `call void @zen_map_set_map(ptr ${parentMapPtr}, ptr ${keyPtr.name}, ptr ${nestedMapPtr})`,
        );
        continue;
      }

      const value = this.expr.handleExpression(prop.value);
      this.emitExpr(value);

      let raw;
      if (value?.needsLoad) {
        const t = this.newTemp();
        this.emit(`${t} = load ${value.llvmType ?? "ptr"}, ptr ${value.ptr}`);
        raw = t;
      } else {
        raw = value.ptr ?? value.result ?? value.value;
      }

      // LIST
      if (value?.isList) {
        const depth = this.getListDepth(value.generic);
        const deepest = this.getDeepestGeneric(value.generic);
        const deepestType = TYPE_MAP[deepest];

        this.emit(
          `call void @zen_map_set_list(ptr ${parentMapPtr}, ptr ${keyPtr.name}, ptr ${this.castToPtr(value)}, i32 ${depth}, i32 ${deepestType})`,
        );
        continue;
      }

      if (value?.isStruct && value.type === "Map") {
        this.emit(
          `call void @zen_map_set_map(ptr ${parentMapPtr}, ptr ${keyPtr.name}, ptr ${this.castToPtr(value)})`,
        );
        continue;
      }

      // SCALARS
      switch (value.type) {
        case "int":
          this.emit(
            `call void @zen_map_set_int(ptr ${parentMapPtr}, ptr ${keyPtr.name}, i32 ${raw})`,
          );
          break;

        case "bool":
          this.emit(
            `call void @zen_map_set_bool(ptr ${parentMapPtr}, ptr ${keyPtr.name}, i1 ${raw})`,
          );
          break;

        case "double":
          this.emit(
            `call void @zen_map_set_double(ptr ${parentMapPtr}, ptr ${keyPtr.name}, double ${raw})`,
          );
          break;

        case "string":
          this.emit(
            `call void @zen_map_set_string(ptr ${parentMapPtr}, ptr ${keyPtr.name}, ptr ${raw})`,
          );
          break;

        default:
          this.emitError(
            "TypeError",
            `Unsupported Map type ${value.type}`,
            prop,
          );
      }
    }
  }

  castToPtr(value, node) {
    const type = value.type;
    const isList = value.isList;
    const isListAccess = value.isListAccess;
    const vptr = value.ptr;

    // already ptr-like
    if (
      type === "ptr" ||
      type === "string" ||
      type === "Map" ||
      type === "List" ||
      isList
    ) {
      return isListAccess ? value.addr : vptr;
    }

    // INT

    if (type === "int") {
      if (isListAccess) return value.addr;

      const box = this.newTemp();

      this.emitAlloca(box, "i32");

      this.emit(`store i32 ${vptr}, ptr ${box}`);

      return box;
    }

    // LONG

if (type === "long") {
  if (isListAccess) return value.addr;

  const box = this.newTemp();

  this.emitAlloca(box, "i64");
  this.emit(`store i64 ${vptr}, ptr ${box}`);

  return box;
}

    // BOOL

    if (type === "bool") {
      if (isListAccess) return value.addr;

      const box = this.newTemp();

      this.emitAlloca(box, "i1");

      this.emit(`store i1 ${vptr}, ptr ${box}`);

      return box;
    }

    // DOUBLE

    if (type === "double") {
      if (isListAccess) return value.addr;

      const box = this.newTemp();

      this.emitAlloca(box, "double");

      this.emit(`store double ${vptr}, ptr ${box}`);

      return box;
    }

    this.emitError("TypeError", `Cannot cast '${type}' to ptr`, node);
  }

  handleListProperty(
    listPtr,
    object,
    field,
    node,
    fromMap = false,
    freeField = null,
  ) {
    switch (field) {
      case "length": {
        if (Array.isArray(node?.args)) {
          this.emitError(
            "TypeError",
            `'length' is a property, not a method — use '.length' without '()'`,
            node,
          );
        }

        const gep = this.newTemp();
        this.emit(
          `${gep} = getelementptr inbounds %ZenList, ptr ${listPtr}, i32 0, i32 1`,
        );

        const val = this.newTemp();
        this.emit(`${val} = load i32, ptr ${gep}`);

        return {
          ptr: val,
          type: "int",
          llvmType: "i32",
          local: [],
          global: [],
        };
      }

      case "capacity": {
        if (Array.isArray(node?.args)) {
          this.emitError(
            "TypeError",
            `'capacity' is a property, not a method — use '.capacity' without '()'`,
            node,
          );
        }
        const gep = this.newTemp();
        this.emit(
          `${gep} = getelementptr inbounds %ZenList, ptr ${listPtr}, i32 0, i32 2`,
        );

        const val = this.newTemp();
        this.emit(`${val} = load i32, ptr ${gep}`);

        return {
          ptr: val,
          type: "int",
          llvmType: "i32",
          local: [],
          global: [],
        };
      }

      case "push": {
        this.declareOneTime(
          "zen_list_push",
          "declare void @_zen_list_push(ptr, ptr)",
        );

        const deepestType = this.getDeepestGeneric(object.generic);
        const isStructElement = this.hasStruct(deepestType);

        // STRUCT LITERAL push({...})
        if (node.args[0]?.type === "STRUCT_LITERAL" && isStructElement) {
  const structPtr = this.emitStructLiteral(deepestType, node.args[0]);

  const elementStruct = this.getStruct(deepestType);
  const isOpaqueElement =
    elementStruct?.isOpaque || BUILTIN_STRUCT_ABI.includes(deepestType);

  if (!isOpaqueElement && structPtr.needsLoad) {
    const t = this.newTemp();
    this.emit(`${t} = load ptr, ptr ${structPtr.ptr}`);
    structPtr.ptr = t;
  }

  this.emit(
    `call void @_zen_list_push(ptr ${listPtr}, ptr ${structPtr.ptr})`,
  );
  return {
    ptr: null,
    type: "void",
    llvmType: "void",
    local: [],
    global: [],
  };
}

        const arg = this.expr.handleExpression(node.args[0], false);

        if (this.hasStruct(arg.type)) {
  const struct = this.getStruct(arg.type);

  if (struct?.isBuiltin && struct?.isOpaque) {
    let p = arg.ptr;

    if (!arg.needsLoad) {
      const tmp = this.newTemp();
      this.emitAlloca(tmp, "ptr");
      this.emit(`store ptr ${arg.ptr}, ptr ${tmp}`);
      p = tmp;
    }

    this.emit(
      `call void @_zen_list_push(ptr ${listPtr}, ptr ${p})`,
    );

  } else {
    this.emit(
      `call void @_zen_list_push(ptr ${listPtr}, ptr ${arg.ptr})`,
    );
  }

  return {
    ptr: null,
    type: "void",
    llvmType: "void",
    local: [],
    global: [],
  };
}

        let expType = object?.generic?.generic?.type;

        

        if (expType === "List") {
          const expArgType = arg?.isList === true ? "List" : arg?.type;
          if (expArgType !== "List") {
            this.emitError(
              "TypeError",
              `'${node.object.name}.push' expects a List element, got '${expArgType}'`,
              node.args[0],
            );
          }
        } else {
          const expArgType = arg?.isList === true ? "List" : arg?.type;
          if (expArgType !== expType) {
            this.emitError(
              "TypeError",
              `'${node.object.name}.push' expects type '${expType}', got '${expArgType}'`,
              node.args[0],
            );
          }
        }

        this.emitExpr(arg);

        const llvmType = this.getListElementLLVM(object.generic);
        const tmp = this.newTemp();
        this.emitAlloca(tmp, llvmType);

        let t;
        if (arg.needsLoad) {
          t = this.newTemp();
          this.emit(`${t} = load ${llvmType}, ptr ${arg.ptr}`);
        } else {
          t = arg.ptr;
        }

        this.emit(`store ${llvmType} ${t}, ptr ${tmp}`);
        this.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);

        return {
          ptr: null,
          type: "void",
          llvmType: "void",
          local: [],
          global: [],
        };
      }

      case "pop": {
        this.declareOneTime(
          "zen_list_pop",
          "declare void @_zen_list_pop(ptr, ptr)",
        );

        const type = this.getDeepestGeneric(object.generic);

        const isStruct = this.hasStruct(type);

        const unwrapGeneric = (g) => {
          if (!g || g.type !== "List") return null;
          return g.generic;
        };

        const nextGeneric = unwrapGeneric(object.generic);
        const isNestedList = nextGeneric?.type === "List";

        // STRUCT — out ptr IS the struct ptr (heap/caller-allocated, no extra alloca needed)
        if (isStruct) {
          this.declareOneTime("malloc", "declare ptr @malloc(i64)");
          const size = this.sizeOf(type);
          const out = this.newTemp();
          this.emit(`${out} = call ptr @malloc(i64 ${size})`);

          this.emit(`call void @_zen_list_pop(ptr ${listPtr}, ptr ${out})`);

          return {
            ptr: out,
            type,
            llvmType: "ptr",
            local: [],
            global: [],
            isStruct: true,
            isListAccess: true,
            needsLoad: false,
          };
        }

        // LIST (nested list popped out) — out is a ptr slot holding the inner list ptr
        if (isNestedList) {
          const out = this.newTemp();
          this.emitAlloca(out, "ptr");

          this.emit(`call void @_zen_list_pop(ptr ${listPtr}, ptr ${out})`);

          const val = this.newTemp();
          this.emit(`${val} = load ptr, ptr ${out}`);

          return {
            ptr: val,
            type,
            llvmType: "ptr",
            local: [],
            global: [],
            isList: true,
            generic: nextGeneric,
            needsLoad: false,
          };
        }

        // PRIMITIVE
        const llvmType = this.getListElementLLVM(object.generic);

        const out = this.newTemp();
        this.emitAlloca(out, llvmType);

        this.emit(`call void @_zen_list_pop(ptr ${listPtr}, ptr ${out})`);

        const val = this.newTemp();
        this.emit(`${val} = load ${llvmType}, ptr ${out}`);

        return {
          ptr: val,
          type,
          llvmType,
          local: [],
          global: [],
          isList: false,
          generic: null,
        };
      }

      case "removeAt": {
        this.declareOneTime(
          "zen_list_remove",
          "declare void @_zen_list_remove(ptr, i32)",
        );

        const index = this.expr.handleExpression(node.args[0]);

        const invalidIndex = index.type !== "int" || index.isList;

        if (invalidIndex) {
          this.emitError(
            "TypeError",
            `List '${node.object.name}' index must be of type 'int'`,
            node.args[0],
          );
        }

        this.emitExpr(index);

        this.emit(
          `call void @_zen_list_remove(ptr ${listPtr}, i32 ${index.ptr})`,
        );

        return {
          ptr: null,
          type: "void",
          llvmType: "void",
          local: [],
          global: [],
        };
      }

      case "clear": {
        this.declareOneTime(
          "zen_list_clear",
          "declare void @_zen_list_clear(ptr)",
        );

        this.emit(`call void @_zen_list_clear(ptr ${listPtr})`);
        return {
          ptr: null,
          type: "void",
          llvmType: "void",
          local: [],
          global: [],
        };
      }

      case "contains": {
        const expType = object?.generic?.generic?.type;

        const allowed =
          expType === "int" ||
          expType === "double" ||
          expType === "bool" ||
          expType === "string";

        if (!allowed) {
          this.emitError(
            "TypeError",
            `'contains' is currently only supported for List<int>, List<double>, List<bool>, and List<string>. Got List<${expType}>`,
            node.args[0],
          );
        }

        const isStringElement = expType === "string";
        const fnName = isStringElement
          ? "_zen_list_contains_string"
          : "_zen_list_contains_primitive";

        this.declareOneTime(fnName, `declare i1 @${fnName}(ptr, ptr)`);

        const arg = this.expr.handleExpression(node.args[0]);

        const expArgType = arg?.isList === true ? "List" : arg?.type;
        if (expArgType !== expType) {
          this.emitError(
            "TypeError",
            `'${node.object.name}.contains' expects type '${expType}', got '${expArgType}'`,
            node.args[0],
          );
        }

        this.emitExpr(arg);

        const llvmType = this.getListElementLLVM(object.generic);

        const tmp = this.newTemp();
        this.emitAlloca(tmp, llvmType);

        let ptr;
        if (arg.needsLoad) {
          const t = this.newTemp();
          this.emit(`${t} = load ${llvmType}, ptr ${arg.ptr}`);
          ptr = t;
        } else {
          ptr = arg.ptr;
        }

        this.emit(`store ${llvmType} ${ptr}, ptr ${tmp}`);

        const val = this.newTemp();
        this.emit(`${val} = call i1 @${fnName}(ptr ${listPtr}, ptr ${tmp})`);

        return {
          ptr: val,
          type: "bool",
          llvmType: "i1",
          local: [],
          global: [],
        };
      }

      case "indexOf": {
        const expType = object.generic.generic.type;

        const allowed =
          expType === "int" ||
          expType === "double" ||
          expType === "bool" ||
          expType === "string";

        if (!allowed) {
          this.emitError(
            "TypeError",
            `'indexOf' is currently only supported for List<int>, List<double>, List<bool>, and List<string>. Got List<${expType}>`,
            node.args[0],
          );
        }

        const isStringElement = expType === "string";
        const fnName = isStringElement
          ? "_zen_list_indexOf_string"
          : "_zen_list_indexOf_primitive";

        this.declareOneTime(fnName, `declare i32 @${fnName}(ptr, ptr)`);

        const arg = this.expr.handleExpression(node.args[0]);

        const expArgType = arg?.isList === true ? "List" : arg?.type;
        if (expArgType !== expType) {
          this.emitError(
            "TypeError",
            `'${node.object.name}.indexOf' expects type '${expType}', got '${expArgType}'`,
            node.args[0],
          );
        }

        this.emitExpr(arg);

        const llvmType = this.getListElementLLVM(object.generic);

        const tmp = this.newTemp();
        this.emitAlloca(tmp, llvmType);

        let ptr;
        if (arg.needsLoad) {
          const t = this.newTemp();
          this.emit(`${t} = load ${llvmType}, ptr ${arg.ptr}`);
          ptr = t;
        } else {
          ptr = arg.ptr;
        }

        this.emit(`store ${llvmType} ${ptr}, ptr ${tmp}`);

        const val = this.newTemp();
        this.emit(`${val} = call i32 @${fnName}(ptr ${listPtr}, ptr ${tmp})`);

        return {
          ptr: val,
          type: "int",
          llvmType: "i32",
          local: [],
          global: [],
        };
      }

      case "join": {
        const immediateType = object.generic?.generic?.type;

        if (immediateType !== "string") {
          this.emitError(
            "TypeError",
            `'join' is only supported for flat List<string>, got List<${immediateType}>`,
            node.args[0],
          );
        }

        const elemType = this.getDeepestGeneric(object.generic);

        // already correctly blocks non-string (which also covers structs implicitly)
        if (elemType !== "string") {
          this.emitError(
            "TypeError",
            `'join' is only supported for List<string>`,
            node,
          );
        }

        this.declareOneTime(
          "zen_list_join",
          "declare ptr @_zen_list_join(ptr, ptr)",
        );

        const sep = this.expr.handleExpression(node.args[0]);

        if (sep.type !== "string") {
          this.emitError(
            "TypeError",
            `'join' separator must be string`,
            node.args[0],
          );
        }

        this.emitExpr(sep);

        const val = this.newTemp();

        this.emit(
          `${val} = call ptr @_zen_list_join(ptr ${listPtr}, ptr ${sep.ptr})`,
        );

        return {
          ptr: val,
          type: "string",
          llvmType: "ptr",
          local: [],
          global: [],
        };
      }

      case "free": {
      
        this.declareOneTime(
          "zen_list_free",
          "declare void @_zen_list_free(ptr)",
        );

        if (!fromMap) {
          this.emit(`call void @_zen_list_free(ptr ${listPtr})`);
          this.emit(`store ptr null, ptr ${object.ptr}`);

          this.freedVars[this.freedVars.length - 1].add(node.object.name);
          
          
        } else {
          // map inside list

          this.declareOneTime(
            "zen_map_remove",
            "declare void @_zen_map_remove(ptr, ptr)",
          );

          let key;
          if (freeField) {
            key = this.newGlobalString(freeField);
          }
          const t = this.newTemp();
          this.emit(`${t} = load ptr, ptr ${object.basePtr}`);
          this.emit(`call void @_zen_map_remove(ptr ${t}, ptr ${key.name})`);

          if (!this.freedFields.has(object.name)) {
            this.freedFields.set(object.name, new Set());
            this.freedFields.get(object.name).add(freeField);
          }

          const meta = this.maps.get(object.name);
          meta[freeField].freed = true;
          meta[freeField].freedAt = freeField;
          
        }
        
        if (node.object.type !== "variable") {
  this.emitError(
    "MemoryError",
    "free() can only be called on an owning variable",
    node,
  );
}

const sym = this.getVar(node.object.name);


if (sym.ownerId !== undefined) {
    this.freedOwners.add(sym.ownerId);
}
sym.isFreed = true;

if (sym.fromParam && sym.pIndex !== undefined) {
  this.functions
    .get(this.currentFunction.name)
    .freedPindex.add(sym.pIndex);
}

        return {
          ptr: null,
          type: "void",
          llvmType: "void",
          local: [],
          global: [],
          isFreed: true
        };
      }

      default:
        this.emitError("TypeError", `List has no property .${field}`, node);
    }
  }

  isNestedList(generic) {
    return generic?.type === "List" && generic?.generic?.type === "List";
  }

  normalizeCompound(node) {
    if (!node || typeof node !== "object") return node;

    for (const key in node) {
      if (node[key] && typeof node[key] === "object") {
        node[key] = this.normalizeCompound(node[key]);
      }
    }

    if (node.type === "ASSIGNMENT") {
      const op = node.operator;
      if (op !== "=") {
        const binaryOp = op[0];
        node.value = {
          type: "BINARY_EXPRESSION",
          operator: binaryOp,
          left: { type: "variable", name: node.name },
          right: node.value,
        };
        node.operator = "=";
      }
    } else if (node.type === "MEMBER_ASSIGNMENT") {
      const op = node.operator;
      if (op !== "=") {
        const binaryOp = op[0];
        node.value = {
          type: "BINARY_EXPRESSION",
          operator: binaryOp,
          left: {
            type: "MEMBER_ACCESS",
            object: node.object,
            field: node.field,
            line: node.object.line,
            column: node.object.column,
          },
          right: node.value,
        };
        node.operator = "=";
      }
    }

    return node;
  }

  normalizeUpdateToExpr(update) {
    if (update.type === "UNARY_EXPRESSION") {
      const op = update.operator === "++" ? "+" : "-";
      return {
        type: "ASSIGNMENT",
        name: update.argument.name,
        operator: "=",
        value: {
          type: "BINARY_EXPRESSION",
          left: {
            type: "variable",
            name: update.argument.name,
          },
          operator: op,
          right: {
            type: "int",
            value: 1,
          },
        },
      };
    }

    if (update.type === "ASSIGNMENT" && update.operator) {
      if (COMPOUND_OPERATORS.includes(update.operator)) {
        return this.normalizeCompound(update);
      }
      // plain i = expr is already an assignment, so pass through
      return update;
    }

    this.emitError("SyntaxError", `Invalid update expression in loop`, update);
  }

  getDeepestGeneric(generic) {
    let cur = generic;

    while (cur?.generic) {
      cur = cur.generic;
    }

    return cur?.type || null;
  }

  constEval(node, context) {
  
    if (node.type === "int") return Number(node.value);
    
    if (this.enums.has(node.object.name)) {
      const field = node.field;
      const e = this.enums.get(node.object.name).members.has(field);
      if (e) {
        return Number(this.enums.get(node.object.name).members.get(field));
      } else {
        this.emitError("ReferenceError", `enum '${node.object.name}' does't have member '${field}'`, node);
      }
    }

    if (node.type === "BINARY_EXPRESSION") {
      const l = this.constEval(node.left, context);
      const r = this.constEval(node.right, context);

      if (typeof l === "number" && typeof r === "number") {
        switch (node.operator) {
          case "+":
            return l + r;
          case "-":
            return l - r;
          case "*":
            return l * r;
          case "/":
            return Math.floor(l / r);
        }
      }
    }

    this.emitError(
      "ConstError",
      `Cannot use a non-constant expression in '${context}'`,
      node,
    );
  }

  generateScreenString(typeInfo) {
    if (!typeInfo) {
      return "unknown";
    }

    if (typeInfo.type !== "List") {
      return typeInfo.type;
    }

    const inner = this.generateScreenString(typeInfo.generic);

    return `List<${inner}>`;
  }

  lastEmit() {
    const body = this.currentFunction?.body;
    if (!body) return "";
    const last = body[body.length - 1];
    return last?.trim() ?? "";
  }

  hasTerminator() {
    const last = this.lastEmit();
    return (
      last.startsWith("ret ") ||
      last.startsWith("br ") ||
      last === "unreachable"
    );
  }

  emitStructLiteral(structName, mapLiteralNode, globalScope = false) {
    if (structName === "Map") {
      return this.emitMapLiteral(mapLiteralNode, globalScope);
    }

    const llvmType = `%${structName}`;
    let structPtr = this.newTemp();

    this.declareOneTime("ZenList", "%ZenList = type { ptr, i32, i32, i64 }");
    this.declareOneTime("zen_list_new", "declare ptr @_zen_list_new(i64)");
    this.declareOneTime(
      "zen_list_push",
      "declare ptr @_zen_list_push(ptr, ptr)",
    );

    if (globalScope) {
    structPtr = this.newGlobalTemp();
    this.globals.push(`${structPtr} = global ${llvmType} zeroinitializer`);
  } else {
    structPtr = this.newTemp();
    this.emitAlloca(structPtr, llvmType);
  }

    const structInfo = this.getStruct(structName);

    for (const prop of mapLiteralNode.properties) {
      const field = structInfo.layout.find((f) => f.name === prop.key);

      if (!field) {
        this.emitError(
          "ReferenceError",
          `Unknown field '${prop.key}' in struct '${structName}'`,
          mapLiteralNode,
        );
      }

      const fieldPtr = this.newTemp();

      this.emit(
        `${fieldPtr} = getelementptr inbounds ${llvmType}, ptr ${structPtr}, i32 0, i32 ${field.index}`,
      );

      // NESTED LIST FIELD
      if (prop.value.type === "ARRAY") {
        const isNestedList = field.generic?.generic?.type === "List";

        const elementSize = isNestedList
          ? 8
          : this.sizeOf(this.getDeepestGeneric(field.generic));

        const listPtr = this.newTemp();
        this.emit(`${listPtr} = call ptr @_zen_list_new(i64 ${elementSize})`);

        for (const el of prop.value.elements) {
          if (el.type === "ARRAY") {
            const innerListPtr = this.emitNestedListLiteral(
              el,
              field.generic.generic,
            );
            const tmp = this.newTemp();
            this.emitAlloca(tmp, "ptr");
            this.emit(`store ptr ${innerListPtr}, ptr ${tmp}`);
            this.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);
          } else if (el.type === "STRUCT_LITERAL") {
            const innerStructName = this.getDeepestGeneric(field.generic);
            const innerPtr = this.emitStructLiteral(innerStructName, el);

            if (innerPtr.needsLoad) {
              const t = this.newTemp();
              this.emit(`${t} = load ptr, ptr ${innerPtr.ptr}`);
              innerPtr.ptr = t;
            }
            this.emit(
              `call void @_zen_list_push(ptr ${listPtr}, ptr ${innerPtr.ptr})`,
            );
          } else {
            const expr = this.expr.handleExpression(el);
            this.emitExpr(expr);
            const tmp = this.newTemp();
            this.emitAlloca(tmp, expr.llvmType);
            this.emit(`store ${expr.llvmType} ${expr.ptr}, ptr ${tmp}`);
            this.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);
          }
        }

        this.emit(`store ptr ${listPtr}, ptr ${fieldPtr}`);
        continue;
      }

      // NESTED STRUCT FIELD (literal)
      if (prop.value.type === "STRUCT_LITERAL") {
        const nestedPtr = this.emitStructLiteral(
          field.type,
          prop.value,
          globalScope,
        );

        if (nestedPtr.needsLoad) {
          const t = this.newTemp();
          this.emit(`${t} = load ptr, ptr ${nestedPtr.ptr}`);
          nestedPtr.ptr = t;
        }
        this.declareOneTime(
          "memcpy",
          "declare void @llvm.memcpy(ptr, ptr, i64, i1)",
        );
        this.emit(
          `call void @llvm.memcpy(ptr ${fieldPtr}, ptr ${nestedPtr.ptr}, i64 ${this.sizeOf(field.type)}, i1 false)`,
        );
        continue;
      }

      if (!field.isList && this.hasStruct(field.type)) {
        const expr = this.expr.handleExpression(prop.value, false, structName);
        this.emitExpr(expr);
        this.declareOneTime(
          "llvm.memcpy.p0.p0.i64",
          "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
        );
        const size = this.sizeOf(field.type);
        this.emit(
          `call void @llvm.memcpy.p0.p0.i64(ptr ${fieldPtr}, ptr ${expr.ptr}, i64 ${size}, i1 false)`,
        );
        continue;
      }

      // NORMAL FIELD
      const expr = this.expr.handleExpression(prop.value, false, structName);
      this.emitExpr(expr);
      this.emit(`store ${field.llvmType} ${expr.ptr}, ptr ${fieldPtr}`);
    }

    return {
      ptr: structPtr,
      needsLoad: false,
    };
  }

  emitNestedListLiteral(arrayNode, elementGeneric) {
    const isNestedList = elementGeneric?.type === "List";

    const elementSize = isNestedList
      ? 8 // pointer to inner list
      : this.sizeOf(
          elementGeneric?.type ??
            this.getDeepestGeneric({ generic: elementGeneric }),
        );

    const listPtr = this.newTemp();
    this.emit(`${listPtr} = call ptr @_zen_list_new(i64 ${elementSize})`);

    for (const el of arrayNode.elements) {
      if (el.type === "ARRAY") {
        // recurse another level deeper
        const innerListPtr = this.emitNestedListLiteral(
          el,
          elementGeneric.generic,
        );
        const tmp = this.newTemp();
        this.emitAlloca(tmp, "ptr");
        this.emit(`store ptr ${innerListPtr}, ptr ${tmp}`);
        this.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);
      } else if (el.type === "STRUCT_LITERAL") {
        const structName = elementGeneric?.type;
        const innerPtr = this.emitStructLiteral(structName, el);

        if (innerPtr.needsLoad) {
          const t = this.newTemp();
          this.emit(`${t} = load ptr, ptr ${innerPtr.ptr}`);
          innerPtr.ptr = t;
        }
        this.emit(
          `call void @_zen_list_push(ptr ${listPtr}, ptr ${innerPtr.ptr})`,
        );
      } else {
        const expr = this.expr.handleExpression(el);
        this.emitExpr(expr);
        const tmp = this.newTemp();
        this.emitAlloca(tmp, expr.llvmType);
        this.emit(`store ${expr.llvmType} ${expr.ptr}, ptr ${tmp}`);
        this.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);
      }
    }

    return listPtr;
  }

  loadFile(source, node) {
    if (!source) {
      this.emitError("ModuleError", "Missing module source", node);
    }

    if (source.endsWith(".zen")) {
      return this.safeReadFile(source);
    }

    const packageDir = path.join(os.homedir(), ".zen", "packages", source);

    if (!fs.existsSync(packageDir)) {
      this.emitError("ModuleError", `Package '${source}' not found`, node);
    }

    const manifestPath = path.join(packageDir, "zen.json");

    if (!fs.existsSync(manifestPath)) {
      this.emitError(
        "ModuleError",
        `Package '${source}' missing zen.json`,
        node,
      );
    }

    let manifest;
    try {
      manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
    } catch {
      this.emitError("ModuleError", `Invalid zen.json in '${source}'`, node);
    }

    if (!manifest.bin) {
      this.emitError(
        "ModuleError",
        `Package '${source}' missing bin entry`,
        node,
      );
    }

    const entryFile = path.join(packageDir, manifest.bin);
    

    if (!fs.existsSync(entryFile)) {
      this.emitError(
        "ModuleError",
        `Entry file not found in '${source}'`,
        node,
      );
    }

    return this.safeReadFile(entryFile);
  }

  registerBuiltInStructs(name, fields = [], methods = {}, needSize = false,  builtinSize = null, builtinAlign = null) {
    const layout = [];
    const fieldMap = {};
    const llvmFields = [];

    for (let i = 0; i < fields.length; i++) {
      const f = fields[i];

      const llvmType = this.getLLVMType(f.type);

      layout.push({
        name: f.name,
        type: f.type,
        llvmType,
        index: i,
        isList: false,
        generic: null,
        dimensions: [],
      });

      fieldMap[f.name] = i;
      llvmFields.push(llvmType);
    }

    if (needSize) {
      this.globals.push(`%${name} = type { ptr }`);
    } else if (methods.opaque) {
      this.globals.push(`%${name} = type opaque`);
    } else {
      this.globals.push(`%${name} = type { ${llvmFields.join(", ")} }`);
    }

    this.setStruct(name, {
      isBuiltin: true,
      isGlobal: true,
      isOpaque: methods.opaque,
      layout,
      fieldMap,
      size: fields.length,
      byteSize: builtinSize,
      align: builtinAlign,
      methods,
    });

    if (builtinSize === null) {
  this.getStruct(name).byteSize = this.sizeOf(name);
}
    if (builtinAlign === null) {
  this.getStruct(name).align = this.alignOf(name);
}
  }

  initBuiltInStructs() {
    this.registerBuiltInStructs("HttpServer", [], { opaque: true });

    this.registerBuiltInStructs("HttpRequest", [], { opaque: true });

    this.registerBuiltInStructs("HttpResponse", [], { opaque: true });

    this.registerBuiltInStructs("Json", [], { opaque: true });

    this.registerBuiltInStructs("JsonArray", [], { opaque: true });

    this.registerBuiltInStructs("JsonObject", [], { opaque: true });

    this.registerBuiltInStructs("Ptr", [], { opaque: true }, true);

    this.registerBuiltInStructs("Map", [], { opaque: true });
    
  }

  allocStructStorage(structInfo, structName, globalScope, allocate = true) {
    // speacial case for Map

    if (structName === "Map") {
      this.declareOneTime("zen_map_new", "declare ptr @_zen_map_new()");

      if (globalScope) {
        const ptr = this.newGlobalTemp();
        this.globals.push(`${ptr} = global ptr null`);

        const map = this.newTemp();
        this.emit(`${map} = call ptr @_zen_map_new()`);
        this.emit(`store ptr ${map}, ptr ${ptr}`);

        return ptr;
      }

      const ptr = this.newTemp();
      this.emitAlloca(ptr, "ptr");
      
    if (allocate) {
      const map = this.newTemp();
      this.emit(`${map} = call ptr @_zen_map_new()`);
      this.emit(`store ptr ${map}, ptr ${ptr}`);
    }

      return ptr;
    }

    const isOpaque = structInfo.isBuiltin && structInfo.isOpaque;
    const llvmType = isOpaque ? "ptr" : `%${structName}`;
    const initVal = isOpaque ? "null" : "zeroinitializer";

    if (globalScope) {
      const ptr = this.newGlobalTemp();
      this.globals.push(`${ptr} = global ${llvmType} ${initVal}`);
      return ptr;
    }

    this.guardStackOp(`STRUCT_INSTANCE - ${structName}`);
    const ptr = this.newTemp();
    this.emitAlloca(ptr, llvmType);
    if (isOpaque) {
      this.emit(`store ptr null, ptr ${ptr}`);
    }
    return ptr;
  }

  handleBuiltinStructMethod(
  structName,
  methodName,
  object,
  basePtr,
  node,
  obj,
) {
  const method = BUILTIN_STRUCT_METHODS?.[structName]?.[methodName];

  if (!method) {
    this.emitError(
      "ReferenceError",
      `'${structName}' has no method '${methodName}()'`,
      node,
    );
  }

  // Use-after-free
  const currentFreed = this.freedVars[this.freedVars.length - 1];

  if (currentFreed.has(object.name)) {
    this.emitError(
      "MemoryError",
      `'${object.name}' has already been freed and cannot be used`,
      node,
    );
  }

  // Json.parse() validation
  if (
    structName === "Json" &&
    methodName !== "parse" &&
    !this.JsonParseMap.has(object.name)
  ) {
    this.emitError(
      "SemanticError",
      `'Json.${methodName}()' can only be used after 'Json.parse()'`,
      node,
    );
  }

  const args = node.args ?? [];

  if (args.length !== method.args.length) {
    this.emitError(
      "ArgumentError",
      `'${structName}.${methodName}()' expects ${method.args.length} argument(s), got ${args.length}`,
      node,
    );
  }

  const llvmArgs = [];
  const llvmArgTypes = [];

  // Deferred instructions
  const local = [];
  const global = [];

  for (let i = 0; i < args.length; i++) {
    if (args[i].type === "STRUCT_LITERAL") {
      const ptr = this.emitStructLiteral(structName, args[i]);

      if (ptr.needsLoad) {
        const t = this.newTemp();
        local.push(`${t} = load ptr, ptr ${ptr.ptr}`);
        ptr.ptr = t;
      }

      llvmArgs.push(`ptr ${ptr.ptr}`);
      llvmArgTypes.push("ptr");

      continue;
    }

    const expr = this.expr.handleExpression(args[i]);

    if (expr.isList) {
      if (method.args[i] !== "List") {
        this.emitError(
          "TypeError",
          `'${structName}.${methodName}()' argument ${i + 1} expects '${method.args[i]}', got 'List'`,
          node,
        );
      }
    } else if (expr.type !== method.args[i]) {
      this.emitError(
        "TypeError",
        `'${structName}.${methodName}()' argument ${i + 1} expects '${method.args[i]}', got '${expr.type}'`,
        node,
      );
    }

    if (expr.global?.length) {
      global.push(...expr.global);
    }

    if (expr.local?.length) {
      local.push(...expr.local);
    }

    let t = this.newTemp();

    if (expr?.needsLoad) {
      local.push(`${t} = load ptr, ptr ${expr.ptr}`);
    } else {
      t = expr.ptr;
    }

    if (this.hasStruct(expr.type)) {
      llvmArgs.push(`ptr ${t}`);
      llvmArgTypes.push("ptr");
    } else {
      llvmArgs.push(`${expr.llvmType} ${t}`);
      llvmArgTypes.push(expr.llvmType);
    }
  }

  // Semantic state

  let ownerId;

  if (this.hasVar(object?.name)) {
    const receiverVar = this.getVar(object.name);

    if (receiverVar.ownerId === undefined) {
      receiverVar.ownerId = this.genOwnerId();
    }

    ownerId = receiverVar.ownerId;

  } else {
    ownerId = object?.ownerId ?? this.genOwnerId();
  }

  if (currentFreed.has(object.name)) {
    this.emitError(
      "MemoryError",
      `'${object.name}' has already been freed and cannot be used`,
      node,
    );
  }

  // Ownership chain check
  if (this.hasVar(object?.name)) {
    const receiverVar = this.getVar(object.name);

    if (
      (receiverVar.ownerId !== undefined &&
        this.freedOwners.has(receiverVar.ownerId)) ||
      receiverVar.isFreed
    ) {
      this.emitError(
        "MemoryError",
        `use-after-free: '${object.name}' is no longer valid`,
        node,
      );
    }
  }

  if (methodName === "parse") {
    this.JsonParseMap.set(object.name, true);
    currentFreed.delete(object.name);
  }

  if (methodName === "free") {
    currentFreed.add(object.name);
    this.freedOwners.add(ownerId);
  }

  const isStruct = this.hasStruct(method.returnType);

  const llvmReturn = method.storeResult
    ? "ptr"
    : isStruct
      ? "ptr"
      : this.getLLVMType(method.returnType);

  const fnName =
    method.llvmName ?? `_zen_${structName}_${methodName}`;

  const callArgs = [];

  if (method.hasReceiver !== false) {
    callArgs.push(`ptr ${basePtr}`);
  }

  callArgs.push(...llvmArgs);

  this.declareOneTime(
    fnName,
    `declare ${llvmReturn} @${fnName}(${
      callArgs.length
        ? callArgs.map((a) => a.split(" ")[0]).join(", ")
        : ""
    })`,
  );

  // Methods that return a pointer to be stored into the object
  if (method.storeResult) {
    const temp = this.newTemp();

    local.push(
      `${temp} = call ptr @${fnName}(${callArgs.join(", ")})`,
    );

    local.push(
      `store ptr ${temp}, ptr ${obj.ptr}`,
    );

    return {
      ptr: null,
      type: "void",
      llvmType: "void",
      local,
      global,
      isVarRef: false,
      needsLoad: false,
      ownerId,
    };
  }

  // Void methods
  if (method.returnType === "void") {
    local.push(
      `call void @${fnName}(${callArgs.join(", ")})`,
    );

    return {
      ptr: null,
      type: "void",
      llvmType: "void",
      local,
      global,
      isVarRef: false,
      needsLoad: false,
      ownerId,
    };
  }

  const temp = this.newTemp();

  local.push(
    `${temp} = call ${llvmReturn} @${fnName}(${callArgs.join(", ")})`,
  );

  // Special case: Map.getList<T>()
  if (structName === "Map" && methodName === "getList") {
    if (!node.generic) {
      this.emitError(
        "TypeError",
        `'map.getList' requires an explicit compile-time generic, e.g. map.getList<List<int>>("key")`,
        node,
      );
    }

    const normalizedGeneric =
      this.normalizeGeneric(node.generic);

    const deepestType =
      this.getDeepestGeneric(normalizedGeneric);

    return {
      ptr: temp,
      type: deepestType,
      llvmType: "ptr",
      local,
      global,
      isVarRef: false,
      needsLoad: false,
      isDirectCall: true,
      isList: true,
      generic: normalizedGeneric,
      ownerId,
    };
  }

  // Generic return
  return {
    ptr: temp,
    type: method.returnType,
    llvmType: llvmReturn,
    local,
    global,
    isVarRef: false,
    isStruct,
    ownerId,
  };
}

  handleBuiltinStructProp(structName, propName, object, basePtr, node) {
    const prop = BUILTIN_STRUCT_PROPS?.[structName]?.[propName];

    if (!prop) {
      this.emitError(
        "ReferenceError",
        `'${structName}' has no property '${propName}'`,
        node,
      );
    }

    const currentFreed = this.freedVars[this.freedVars.length - 1];

    // Use-after-free
    if (currentFreed.has(object.name)) {
      this.emitError(
        "MemoryError",
        `'${object.name}' has already been freed and cannot be used`,
        node,
      );
    }

    // Json state validation
    if (structName === "Json" && !this.JsonParseMap.has(object.name)) {
      this.emitError(
        "SemanticError",
        `'Json.${propName}' can only be used after 'Json.parse()'`,
        node,
      );
    }

    // Property should never have arguments
    if (node?.args && node.args.length > 0) {
      this.emitError(
        "ArgumentError",
        `'${structName}.${propName}' is a property and cannot receive arguments`,
        node,
      );
    }

    const isStruct = this.hasStruct(prop.returnType);

    const llvmReturn = isStruct ? "ptr" : this.getLLVMType(prop.returnType);

    const fnName = prop.llvmName ?? `_zen_${structName}_${propName}`;

    const callArgs = [];

    if (prop.hasReceiver !== false) {
      callArgs.push(`ptr ${basePtr}`);
    }

    this.declareOneTime(
      fnName,
      `declare ${llvmReturn} @${fnName}(${callArgs.length ? "ptr" : ""})`,
    );

    const temp = this.newTemp();

    this.emit(
      `${temp} = call ${llvmReturn} @${fnName}(${callArgs.join(", ")})`,
    );

    return {
      ptr: temp,
      type: prop.returnType,
      llvmType: llvmReturn,
      local: [],
      global: [],
      isVarRef: false,
      isStruct,
      needsLoad: !isStruct,
    };
  }

  resolveFunction(name, node) {
    if (this.functionParamTable.has(name)) {
      return this.functionParamTable.get(name);
    }

    return this.getFunction(name, node);
  }

  // debug.pretty() helper

  newGlobalStringInto(buffer, str) {
    
    this.declareOneTime("_str_dup", "declare ptr @_str_dup(ptr)");
    
    let globalName, len;

    if (this.cachedStrings.has(str)) {
      ({ globalName, len } = this.cachedStrings.get(str));
    } else {
      const escaped = this.escapeLLVMString(str);
      globalName = this.strTemp();
      len = this.utf8LenWithNull(str);
      this.globals.push(
        `${globalName} = private unnamed_addr constant [${len} x i8] c"${escaped}\\00"`,
      );
      this.cachedStrings.set(str, { globalName, len });
    }

    const tmp = this.newTemp();
    const value = this.newTemp();
    
    buffer.push(
      `${tmp} = getelementptr inbounds [${len} x i8], ptr ${globalName}, i64 0, i64 0`,
    );
    
    this.emit(`${value} = call ptr @_str_dup(ptr ${tmp})`);
    return value;
  }

  getOrBuildStructPrinter(structName) {
    this._structPrinters ??= {};
    if (this._structPrinters[structName]) {
      return this._structPrinters[structName];
    }

    const fnName = `_debug_pretty_struct_${structName}`;
    this._structPrinters[structName] = fnName;

    this.declareOneTime("printf", "declare i32 @printf(ptr, ...)");
    this.declareOneTime(
      "_debug_print_indent",
      "declare void @_debug_print_indent(i32)",
    );

    const { layout } = this.getStruct(structName);
    const fmtOf = { int: "%d", bool: "%s", double: "%g", string: '"%s"' };

    const buf = [];
    buf.push(`define void @${fnName}(ptr %s, i32 %indent) {`);
    buf.push(`entry:`);
    buf.push(`  %fieldIndent = add i32 %indent, 2`);

    const openStr = this.newGlobalStringInto(buf, "{\n");
    buf.push(`  call i32 (ptr, ...) @printf(ptr ${openStr})`);

    layout.forEach((field, i) => {
      const fieldPtr = `%f${i}`;
      buf.push(
        `  ${fieldPtr} = getelementptr inbounds %${structName}, ptr %s, i32 0, i32 ${field.index}`,
      );
      buf.push(`  call void @_debug_print_indent(i32 %fieldIndent)`);

      const labelStr = this.newGlobalStringInto(buf, `${field.name}: `);
      buf.push(`  call i32 (ptr, ...) @printf(ptr ${labelStr})`);

      let isNestedStruct = false;

      if (this.hasStruct(field.type)) {
        isNestedStruct = true;
        const nested = this.getOrBuildStructPrinter(field.type);
        buf.push(`  call void @${nested}(ptr ${fieldPtr}, i32 %fieldIndent)`);
      } else if (field.isList) {
        const depth = this.getListDepth(field.generic);
        const deepestType = this.getDeepestGeneric(field.generic);
        const loaded = `%l${i}`;
        buf.push(`  ${loaded} = load ptr, ptr ${fieldPtr}`);

        if (this.hasStruct(deepestType)) {
          const nested = this.getOrBuildStructPrinter(deepestType);
          this.declareOneTime(
            "_debug_pretty_list_struct_impl",
            "declare void @_debug_pretty_list_struct_impl(ptr, i32, ptr)",
          );
          buf.push(
            `  call void @_debug_pretty_list_struct_impl(ptr ${loaded}, i32 ${depth}, ptr @${nested})`,
          );
        } else {
          
          this.declareOneTime(
            "_debug_pretty_list_impl",
            "declare void @_debug_pretty_list_impl(ptr, i32, i32)",
          );
          buf.push(
            `  call void @_debug_pretty_list_impl(ptr ${loaded}, i32 ${depth}, i32 ${TYPE_MAP[deepestType]})`,
          );
        }
      } else {
        const loaded = `%v${i}`;
        buf.push(`  ${loaded} = load ${field.llvmType}, ptr ${fieldPtr}`);

        if (field.type === "string") {
          const fmtStr = this.newGlobalStringInto(buf, '"%s"');
          buf.push(
            `  call i32 (ptr, ...) @printf(ptr ${fmtStr}, ptr ${loaded})`,
          );
        } else if (field.type === "bool") {
          const trueStr = this.newGlobalStringInto(buf, "true");
          const falseStr = this.newGlobalStringInto(buf, "false");
          const sel = `%b${i}`;
          buf.push(
            `  ${sel} = select i1 ${loaded}, ptr ${trueStr}, ptr ${falseStr}`,
          );
          const fmtStr = this.newGlobalStringInto(buf, "%s");
          buf.push(`  call i32 (ptr, ...) @printf(ptr ${fmtStr}, ptr ${sel})`);
        } else {
          const fmtStr = this.newGlobalStringInto(buf, fmtOf[field.type]);
          buf.push(
            `  call i32 (ptr, ...) @printf(ptr ${fmtStr}, ${field.llvmType} ${loaded})`,
          );
        }
      }

      if (isNestedStruct) {
        if (i !== layout.length - 1) {
          const commaStr = this.newGlobalStringInto(buf, ",\n");
          buf.push(`  call i32 (ptr, ...) @printf(ptr ${commaStr})`);
        }
      } else {
        const suffix = i === layout.length - 1 ? "\n" : ",\n";
        const suffixStr = this.newGlobalStringInto(buf, suffix);
        buf.push(`  call i32 (ptr, ...) @printf(ptr ${suffixStr})`);
      }
    });

    buf.push(`  call void @_debug_print_indent(i32 %indent)`);
    const closeStr = this.newGlobalStringInto(buf, "}\n");
    buf.push(`  call i32 (ptr, ...) @printf(ptr ${closeStr})`);
    buf.push(`  ret void`);
    buf.push(`}`);

    this.functionBuff.push(buf.join("\n"));

    return fnName;
  }

  emitMapLiteral(mapLiteral, globalScope) {
    this.declareOneTime("zen_map_new", "declare ptr @_zen_map_new()");

    let varPtr;

    if (globalScope) {
      varPtr = this.newGlobalTemp();
      this.globals.push(`${varPtr} = global ptr null`);
    } else {
      varPtr = this.newTemp();
      this.emitAlloca(varPtr, "ptr");
    }

    const mapPtr = this.newTemp();
    this.emit(`${mapPtr} = call ptr @_zen_map_new()`);
    this.emit(`store ptr ${mapPtr}, ptr ${varPtr}`);

    if (
      mapLiteral &&
      mapLiteral.properties &&
      mapLiteral.properties.length > 0
    ) {
      this.buildMapRecursive(mapPtr, mapLiteral);
    }

    return {
      ptr: varPtr,
      needsLoad: true,
    };
  }
  
  getTargetInfo() {
  try {
    const ir = execSync("clang -emit-llvm -S -x c /dev/null -o -").toString();

    return {
      triple: ir.match(/target triple = "([^"]+)"/)?.[1] || false,
      dataLayout: ir.match(/target datalayout = "([^"]+)"/)?.[1] || false,
    };
  } catch {
    return false;
  }
}


getListTypeCode(type) {
  
  if (this.hasStruct(type)) return 0; // safe placeholder
  
  const code = TYPE_MAP[type];

  if (code === undefined) {
    this.emitError(
      "InternalError",
      `no type code mapping for '${type}'`,
    );
  }

  return code;
}


inferDepthAndTypeFromElement(el) {
  // nested list literal: recurse, since infer.infer() doesn't walk into these
  if (el.type === "ARRAY" || el.type === "LIST_LITERAL") {
    if (!el.elements || el.elements.length === 0) {
      this.emitError(
        "TypeError",
        "cannot infer the element type of an empty nested list literal without context",
        el,
      );
    }

    const results = el.elements.map((c) => this.inferDepthAndTypeFromElement(c));
    const first = results[0];

    for (const r of results) {
      if (r.deepestType !== first.deepestType || r.depth !== first.depth) {
        this.emitError("TypeError", "list literal has mixed element types", el);
      }
    }

    return { deepestType: first.deepestType, depth: first.depth + 1 };
  }

  if (el.type === "STRUCT_LITERAL") {
    this.emitError(
      "TypeError",
      "cannot infer struct type inside an untyped list literal — assign it to a typed variable first",
      el,
    );
  }

  return { deepestType: this.infer.infer(el), depth: 0 };
}

countGenericDepth(generic) {
  let depth = 0;
  let g = generic;
  while (g?.type === "List") {
    depth++;
    g = g.generic;
  }
  return depth;
}

inferListContextFromLiteral(node) {
  if (!node.elements || node.elements.length === 0) {
    this.emitError(
      "TypeError",
      "cannot infer the element type of an empty list literal — assign it to a typed variable first (e.g. List<int> a = [])",
      node,
    );
  }

  const results = node.elements.map((el) => this.inferDepthAndTypeFromElement(el));
  const first = results[0];

  for (const r of results) {
    if (r.deepestType !== first.deepestType || r.depth !== first.depth) {
      this.emitError("TypeError", "list literal elements have inconsistent types", node);
    }
  }

  let generic = { type: first.deepestType };
  for (let i = 0; i < first.depth; i++) {
    generic = { type: "List", generic };
  }

  return { generic, type: first.deepestType, depth: first.depth };
}

handleStringFree(object, node) {
  this.declareOneTime("_zen_string_free", "declare void @_zen_string_free(ptr)");
  
  if (node.object.type !== "variable") {
  this.emitError(
    "MemoryError",
    "free() can only be called on an owning variable",
    node,
  );
}

const sym = this.getVar(node.object.name);

 let v = this.newTemp();
 
 if (object.needsLoad) {
   this.emit(`${v} = load ptr, ptr ${object.ptr}`);
 } else {
   v = object.ptr;
 }

this.emit(`call void @_zen_string_free(ptr ${v})`);


if (sym.ownerId !== undefined) {
    this.freedOwners.add(sym.ownerId);
}
sym.isFreed = true;

if (sym.fromParam && sym.pIndex !== undefined) {
  this.functions
    .get(this.currentFunction.name)
    .freedPindex.add(sym.pIndex);
}

        return {
          ptr: null,
          type: "void",
          llvmType: "void",
          local: [],
          global: [],
          isFreed: true
        };
  
}

  cleanupBuiltinStringTemps(args) {
  for (const a of args || []) {
    
    if (a.type === "string" && (a.isTemp || a?.kind === "literal")) {
      this.declareOneTime(
        "_zen_string_free",
        "declare void @_zen_string_free(ptr)",
      );

      this.emit(`call void @_zen_string_free(ptr ${a.ptr})`);
    }
  }
  }

  generateStructInitializer(name, layout) {
    const lines = [];

    lines.push(`define void @_zen_init_${name}(ptr %this) {`);

    for (const field of layout) {
        if (!field.isList) continue;

        const deepest = this.getDeepestGeneric(field.generic);
        const depth = this.getListDepth(field.generic);

        const elementSize =
            depth > 1
                ? 8
                : this.sizeOf(deepest);

        const list = this.newTemp();

        lines.push(
            `${list} = call ptr @_zen_list_new(i64 ${elementSize})`
        );

        lines.push(
            `call void @_zen_list_set_meta(ptr ${list}, i32 ${depth}, i32 ${this.getListTypeCode(deepest)})`
        );

        const fieldPtr = this.newTemp();

        lines.push(
            `${fieldPtr} = getelementptr %${name}, ptr %this, i32 0, i32 ${field.index}`
        );

        lines.push(
            `store ptr ${list}, ptr ${fieldPtr}`
        );
    }

    lines.push("ret void");
    lines.push("}");

    this.declareOneTime("zen_list_new", "declare ptr @_zen_list_new(i64)");
this.declareOneTime("zen_list_set_meta","declare void @_zen_list_set_meta(ptr, i32, i32)");
    this.functionBuff.push(lines.join("\n"));
  }
}
