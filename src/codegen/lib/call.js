import {
  OS_MAP,
  FILE_MAP,
  TIME_MAP,
  NETWORK_MAP,
  SYS_MAP,
  HTTP_MAP,
  STD_FUNCTIONS,
  FFI_MAP,
  PATH_MAP,
  HTTPSERVER_MAP,
  THREAD_MAP,
  DEBUG_MAP,
  CRYPTO_MAP,
  BUILTIN_STRUCT_ABI,
  BUILTIN_STRUCTS
} from "../../config/config.js";

export class Call {
  constructor(
    IRB,
    expr,
    moduleName,
    io,
    type,
    string,
    file,
    os,
    time,
    network,
    http,
    sys,
    ffi,
    path,
    httpServer,
    thread,
    debug,
    crypto
  ) {
    this.IRB = IRB;
    this.moduleName = moduleName;
    this.io = io;
    this.type = type;
    this.string = string;
    this.file = file;
    this.os = os;
    this.time = time;
    this.network = network;
    this.http = http;
    this.sys = sys;
    this.ffi = ffi;
    this.path = path;
    this.HTTPSERVER = httpServer;
    this.THREAD = thread;
    this.DEBUG = debug;
    this.crypto = crypto;
  }

  setExpression(expr) {
    this.expr = expr;
  }

  isPtrReturn(typeName) {
    const struct = this.IRB.hasStruct(typeName)
      ? this.IRB.getStruct(typeName)
      : false;
    return !!struct?.isOpaque || BUILTIN_STRUCT_ABI.includes(typeName);
  }

  handleCall(node, asStatement = false, globalScope) {
    this.IRB.guardStackOp("CALL", node);

    const isMethodCall = !!node?.callee;

    if (isMethodCall) {
      const fakeNode = {
        type: "MEMBER_ACCESS",
        field: node.callee.field,
        object: node.callee.object,
        args: node.args,
        generic: node.generic,
      };

      const valExpr = this.expr.handleExpression(fakeNode);

      return {
        ptr: valExpr.ptr,
        type: valExpr.type,
        llvmType: valExpr.llvmType,
        local: valExpr.local,
        global: valExpr.global,
        endLabel: null,
        isVarRef: false,
        postOrPrefix: false,
        isDirectCall: valExpr?.isDirectCall,
        isList: valExpr?.isList,
        generic: valExpr?.generic,
        isStruct: valExpr?.isStruct,
        needsLoad: valExpr?.needsLoad,
        ownerId: valExpr?.ownerId,
      };
    }

    const name = node.name;
    let isStdFn = false;

    if (STD_FUNCTIONS.includes(name)) {
      isStdFn = true;
      this.IRB.usedStdFunctions.add(name);
      if (!this.IRB.functions.has(name)) {
        this.IRB.setStdlibFunctions(node);
      }
    }

    if (node.isInbuilt && !STD_FUNCTIONS.includes(name)) {
      return this.handleBuiltInCall(node, globalScope);
    }

    if (node.isAwait && !this.IRB.currentFunction.isAsync) {
      this.IRB.emitError(
        "SyntaxError",
        "await can only be used inside async functions",
        node,
      );
    }

    const fn = this.IRB.resolveFunction(name, node);

    const isImportedFn = !!fn.isImported;
    const importedModuleName = fn?.importedModuleName;

    const isFunctionParam = !!fn.isFunctionParam;

    const isExternVariadic = fn.isExtern && fn.hasVarArgs;

    const isExternDecl = fn.isExtern;

    let mangledName;

    switch (true) {
      case isFunctionParam:
        mangledName = null;
        break;
      case isExternDecl:
        mangledName = name;
        break;
      case this.IRB.stdlibMode:
        mangledName = name;
        break;
      case isStdFn:
        mangledName = name;
        break;
      case isImportedFn:
        mangledName = `zen_${importedModuleName}_${name}`;
        break;
      default:
        mangledName = `zen_${this.moduleName}_${name}`;
    }

    const isStruct = fn.isStructReturn || this.IRB.hasStruct(fn.returnType);

    const isNativeABI = isStruct && this.isPtrReturn(fn.returnType);

    const llvmRetType = isStruct ? "void" : this.IRB.getLLVMType(fn.returnType);

    const hasRest = fn.params.some((p) => p.isRest);

    const finalArgs = [...node.args];

    for (let i = finalArgs.length; i < fn.params.length; i++) {
      const param = fn.params[i];

      if (param.default) {
        finalArgs.push(param.default);
      }
    }

    const args = [];
    let global = [];
    let local = [];

    for (let i = 0; i < finalArgs.length; i++) {
      const arg = finalArgs[i];
      const param = fn.params[i];

      let val;

      if (arg.type === "STRUCT_LITERAL") {
        // Determine the expected struct type from the param's declared type
        const paramType = param?.type?.type || param?.type;

        if (!paramType || !this.IRB.hasStruct(paramType)) {
          this.IRB.emitError(
            "TypeError",
            `Cannot infer struct type for literal argument in call to '${node.name}'`,
            node,
          );
        }

        const s = this.IRB.emitStructLiteral(paramType, arg);
        const isOpaqueArg = this.isPtrReturn(paramType);

        val = {
          ptr: s.ptr,
          type: paramType,
          llvmType: isOpaqueArg ? "ptr" : `%${paramType}`,
          isStruct: true,
          needsLoad: s.needsLoad,
          local: [],
          global: [],
          isVarRef: false,
        };
      } else if (arg.type === "ARRAY") {
        const wrapped = param.type;

        const listGeneric = {
          generic: wrapped.generic,
          type: this.IRB.getDeepestGeneric(wrapped),
          depth: this.IRB.getListDepth(wrapped),
        };

        val = this.expr.handleExpression(arg, false, listGeneric);
        this.IRB.emitExpr(val);
      } else {
        val = this.expr.handleExpression(arg, false);

        if (val.type === "void") {
          this.IRB.emitError(
            "TypeError",
            "void value used in expression",
            node,
          );
        }

        this.IRB.emitExpr(val);
      }

      args.push(val);
    }

    for (const i of (fn.freedPindex ?? new Set())) {
      const arg = node.args[i];
      if (!arg) continue;

      const sym = this.IRB.hasVar(arg?.name) ? this.IRB.getVar(arg.name) : null;
      if (!sym) continue;

      sym.isFreed = true;
    }

    let restIndex = -1;

    if (hasRest) {
      restIndex = fn.params.findIndex((p) => p.isRest);
    }

    this.IRB.validateCallArgs(fn, args, hasRest, restIndex, node);

    let argStr = [];

    if (hasRest && isExternVariadic) {
      for (const a of args) {
        if (a.needsLoad) {
          const tmp = this.IRB.newTemp();
          local.push(`${tmp} = load ${a.llvmType}, ptr ${a.ptr}`);
          argStr.push(`${a.llvmType} ${tmp}`);
        } else {
          argStr.push(`${a.llvmType} ${a.ptr}`);
        }
      }

      // LLVM vararg call
      const tmp = fn.returnType === "void" ? null : this.IRB.newTemp();

      if (tmp) {
        local.push(
          `${tmp} = call ${llvmRetType} @${mangledName}(${argStr.join(", ")})`,
        );
      } else {
        local.push(`call void @${mangledName}(${argStr.join(", ")})`);
      }

      if (asStatement) {
        this.IRB.emit(local.join("\n"));
        this.IRB.globals.push(global.join("\n"));
      }

      return {
        ptr: tmp,
        type: fn.returnType,
        llvmType: llvmRetType,
        local: asStatement ? [] : local,
        global: asStatement ? [] : local,
      };
    }

    if (hasRest) {
      this.IRB.declareOneTime(
        "zen_list_new",
        "declare ptr @_zen_list_new(i64)",
      );

      this.IRB.declareOneTime(
        "zen_list_push",
        "declare void @_zen_list_push(ptr, ptr)",
      );

      this.IRB.declareOneTime(
        "ZenList",
        `%ZenList = type { ptr, i32, i32, i64 }`,
      );

      const fixedArgs = args.slice(0, restIndex);
      const restArgs = args.slice(restIndex);

      let argStr = [];
      let global = [];
      let local = [];

      for (let i = 0; i < fixedArgs.length; i++) {
  const a = fixedArgs[i];
  const expectedType = fn.params[i]?.type?.type || fn.params?.type;
      
        if (a.global?.length) global.push(...a.global);
        if (a.local?.length) local.push(...a.local);

        if (a?.isStruct && BUILTIN_STRUCT_ABI.includes(a.type)) {
          let value = a.ptr;

          if (a.needsLoad) {
            const tmp = this.IRB.newTemp();
            local.push(`${tmp} = load ptr, ptr ${a.ptr}`);
            value = tmp;
          }

          argStr.push(`ptr ${value}`);
        } 
        else if (a?.isStruct && BUILTIN_STRUCTS.includes(a?.type)) {
        let value = a.ptr;

        if (a.needsLoad) {
          const tmp = this.IRB.newTemp();
          local.push(`${tmp} = load ptr, ptr ${a.ptr}`);
          value = tmp;
        }
        argStr.push(`ptr ${value}`);
      }
        else if (a?.isStruct) {
          argStr.push(`ptr ${a.ptr}`);
        } else if (a.needsLoad) {
          const tmp = this.IRB.newTemp();
          local.push(`${tmp} = load ${a.llvmType}, ptr ${a.ptr}`);
          argStr.push(`ptr ${tmp}`);
        } else {
  let llvmType = a.llvmType;

  argStr.push(`${llvmType} ${a.ptr}`);
        }
      }

      // REST TYPE VALIDATION

      const first = restArgs[0];
      // declared rest param type
      const restParam = fn.params[restIndex];

      // expected type from function signature
      const expectedType = restParam?.type?.type || restParam?.type;

      let inferredType = first?.type;


      if (!first) {
        this.IRB.emitError(
          "TypeError",
          `Rest parameter expects at least 1 argument`,
          node,
        );
      }

      // declared type vs inferred type check
      if (expectedType && inferredType && expectedType !== inferredType) {
        this.IRB.emitError(
          "TypeError",
          `Rest parameter expects ${expectedType} but got ${inferredType}`,
          node,
        );
      }

      for (const a of restArgs) {
        const t = a.type;

        if (expectedType && t !== expectedType) {
          this.IRB.emitError(
            "TypeError",
            `Rest parameter expects ${expectedType} but got ${t}`,
            node,
          );
        }
      }

      const elementSize = this.IRB.sizeOf(inferredType);
      
      const llvmType = this.IRB.getLLVMType(inferredType);
      const listPtr = this.IRB.newTemp();

      local.push(`${listPtr} = call ptr @_zen_list_new(i64 ${elementSize})`);

      const count = restArgs.length;

      for (let i = 0; i < count; i++) {
        const a = restArgs[i];
        if (a.isList) {
          argStr.push(`ptr ${a.ptr}`);
          continue;
        }
        const tmp = this.IRB.newTemp();

        this.IRB.emitAlloca(tmp, llvmType);

        local.push(`store ${llvmType} ${a.ptr}, ptr ${tmp}`);

        local.push(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);
      }

      argStr.push(`ptr ${listPtr}`);

      let callTmp = null;

      if (fn.returnType === "void" || isStruct) {
        if (isNativeABI) {
          const tmp = this.IRB.newTemp();

          local.push(
            `${tmp} = call ptr ${isFunctionParam ? fn.ptr : `@${mangledName}`}(${argStr.join(", ")})`,
          );
          
          for (const a of args) {
  if (a.type === "string" && a.isTemp) {
    this.IRB.declareOneTime(
      "_zen_string_free",
      "declare void @_zen_string_free(ptr)",
    );
    local.push(`call void @_zen_string_free(ptr ${a.ptr})`);
  }
}
          
          return {
            ptr: tmp,
            type: fn.returnType,
            llvmType: "ptr",
            isStruct: true,
            needsLoad: false,
            local: local,
            global: global,
          };
        } else if (isStruct) {
          const tmp = this.IRB.newTemp();

          this.IRB.emitAlloca(tmp, `%${fn.returnType}`);

          local.push(
            `call void @${mangledName}(ptr sret(%${fn.returnType}) ${tmp}, ${argStr.join(", ")})`,
          );
          
          for (const a of args) {
  if (a.type === "string" && (a.isTemp || a.isLiteral)) {
    this.IRB.declareOneTime(
      "_zen_string_free",
      "declare void @_zen_string_free(ptr)",
    );
    local.push(`call void @_zen_string_free(ptr ${a.ptr})`);
  }
}
        } else {
          const target = isFunctionParam ? fn.ptr : `@${mangledName}`;

          local.push(`call void ${target}(${argStr.join(", ")})`);
          
          for (const a of args) {
  if (a.type === "string" && (a.isTemp || a.isLiteral)) {
    
    this.IRB.declareOneTime(
      "_zen_string_free",
      "declare void @_zen_string_free(ptr)",
    );
    local.push(`call void @_zen_string_free(ptr ${a.ptr})`);
  }
}
        }
      } else {
        callTmp = this.IRB.newTemp();

        const target = isFunctionParam ? fn.ptr : `@${mangledName}`;

        local.push(
          `${callTmp} = call ${llvmRetType} ${target}(${argStr.join(", ")})`,
        );
        
        for (const a of args) {
  if (a.type === "string" && (a.isTemp || a.isLiteral)) {
    
    this.IRB.declareOneTime(
      "_zen_string_free",
      "declare void @_zen_string_free(ptr)",
    );
    local.push(`call void @_zen_string_free(ptr ${a.ptr})`);
  }
}
      }

      if (asStatement) {
        this.IRB.emit(local.join("\n"));
        this.IRB.globals.push(global.join("\n"));
      }
      const isList = fn.returnType === "List";

      if (isList) {
        this.IRB.declareOneTime(
          "ZenList",
          "%ZenList = type { ptr, i32, i32, i64 }",
        );
      }

      return {
        ptr: callTmp,
        type: isList ? fn.retGeneric : fn.returnType,
        llvmType: this.IRB.getLLVMType(fn.returnType),
        generic: isList ? fn.generic : null,
        local: asStatement ? [] : local,
        global: asStatement ? [] : global,
        endLabel: null,
        isVarRef: false,
        postOrPrefix: false,
        needsLoad: false,
        isList,
        isStruct,
        isDirectCall: true,
      };
    }

    // NORMAL CALL

    for (let i = 0; i < args.length; i++) {
  const a = args[i];
  const expectedType = fn.params[i]?.type?.type || fn.params?.type;
      
      if (a?.isStruct && BUILTIN_STRUCT_ABI.includes(a.type)) {
        let value = a.ptr;

        if (a.needsLoad) {
          const tmp = this.IRB.newTemp();
          local.push(`${tmp} = load ptr, ptr ${a.ptr}`);
          value = tmp;
        }

        argStr.push(`ptr ${value}`);
      } else if (a?.isStruct && BUILTIN_STRUCTS.includes(a?.type)) {
        let value = a.ptr;

        if (a.needsLoad) {
          const tmp = this.IRB.newTemp();
          local.push(`${tmp} = load ptr, ptr ${a.ptr}`);
          value = tmp;
        }
        argStr.push(`ptr ${value}`);
      }
      else if (a?.isStruct) {
        argStr.push(`ptr ${a.ptr}`);
      } else if (a.needsLoad) {
        const tmp = this.IRB.newTemp();
        local.push(`${tmp} = load ${a.llvmType}, ptr ${a.ptr}`);
        argStr.push(`ptr ${tmp}`);
      } else {
  let llvmType = a.llvmType;

  argStr.push(`${llvmType} ${a.ptr}`);
    }
    }

    if (fn.returnType === "void" || isStruct) {
      // STRUCT RETURN

      if (isNativeABI) {
        const tmp = this.IRB.newTemp();

        local.push(
          `${tmp} = call ptr ${isFunctionParam ? fn.ptr : `@${mangledName}`}(${argStr.join(", ")})`,
        );

        if (asStatement) {
          this.IRB.emit(local.join("\n"));
          this.IRB.globals.push(global.join("\n"));
        }

        return {
          ptr: tmp,
          type: fn.returnType,
          llvmType: "ptr",
          isStruct: true,
          needsLoad: false,
          local: asStatement ? [] : local,
          global: asStatement ? [] : global,
        };
      } else if (isStruct) {
        const tmp = this.IRB.newTemp();

        this.IRB.emitAlloca(tmp, `%${fn.returnType}`);

        const callArgs = [`ptr sret(%${fn.returnType}) ${tmp}`, ...argStr];

        local.push(
          `call void ${isFunctionParam ? fn.ptr : `@${mangledName}`}(${callArgs.join(", ")})`,
        );

        return {
          ptr: tmp,
          type: fn.returnType,
          llvmType: "ptr",
          isStruct: true,
          local: local,
          global: global,
        };
      }

      // VOID RETURN
      if (fn.isThread) {
        this.IRB.declareOneTime(
          "_zen_thread",
          "declare void @_zen_thread(ptr)",
        );

        local.push(`call void @_zen_thread(ptr @${mangledName})`);
      } else {
        const target = isFunctionParam ? fn.ptr : `@${mangledName}`;

        local.push(`call void ${target}(${argStr.join(", ")})`);
      }
      
      for (const a of args) {
        
  if (a.type === "string" && (a.isTemp || a?.isLiteral)) {
    
    this.IRB.declareOneTime(
      "_zen_string_free",
      "declare void @_zen_string_free(ptr)",
    );
    local.push(`call void @_zen_string_free(ptr ${a.ptr})`);
  }
}

      if (asStatement) {
        this.IRB.emit(local.join("\n"));
        this.IRB.globals.push(global.join("\n"));
      }

      return {
        ptr: null,
        type: "void",
        llvmType: "void",
        local: asStatement ? [] : local,
        global: asStatement ? [] : global,
        endLabel: null,
        isVarRef: false,
        postOrPrefix: false,
        isStruct: false,
      };
    }

    const tmp = this.IRB.newTemp();

    const target = isFunctionParam ? fn.ptr : `@${mangledName}`;

    local.push(`${tmp} = call ${llvmRetType} ${target}(${argStr.join(", ")})`);
    
    for (const a of args) {
      
  if (a.type === "string" && (a.isTemp || a?.isLiteral)) {
    this.IRB.declareOneTime(
      "_zen_string_free",
      "declare void @_zen_string_free(ptr)",
    );
    local.push(`call void @_zen_string_free(ptr ${a.ptr})`);
  }
}

    if (asStatement) {
      this.IRB.emit(local.join("\n"));
      this.IRB.globals.push(global.join("\n"));
    }

    const isList = fn.returnType === "List";

    if (isList) {
      this.IRB.declareOneTime(
        "ZenList",
        "%ZenList = type { ptr, i32, i32, i64 }",
      );
    }

    return {
      ptr: tmp,
      type: isList ? fn.retGeneric : fn.returnType,
      llvmType: this.IRB.getLLVMType(fn.returnType),
      local: asStatement ? [] : local,
      global: asStatement ? [] : global,
      endLabel: null,
      isVarRef: false,
      generic: fn.returnType === "List" ? fn.generic : null,
      postOrPrefix: false,
      needsLoad: false, // call not need load
      isList,
      isStruct,
      isDirectCall: true,
    };
  }

  // built in function routing

  handleBuiltInCall(node, globalScope) {
    this.IRB.guardStackOp("CALL", node);

    let name = node.name;

    switch (name) {
      case "screen":
        this.io.screen(node);
        break;

      case "input":
        return this.io.input(node, globalScope);

      case "type":
        return this.type.type(node, globalScope);

      case "Int":
        return this.type.Int(node, globalScope);

      case "Long":
        return this.type.Long(node, globalScope);

      case "Double":
        return this.type.Double(node, globalScope);

      case "Bool":
        return this.type.Bool(node, globalScope);

      case "String":
        return this.type.StringCast(node, globalScope);

      case "toString":
        return this.type.toString(node, globalScope);

      case "toInt":
        return this.type.toInt(node, globalScope);

      case "length":
        return this.string.length(node, globalScope);

      case "sizeOf":
        return this.type.sizeOf(node, globalScope);

      case "Byte":
        return this.type.Byte(node, globalScope);

      case "matchRegex":
        return this.string.matchRegex(node);

      // these are same pattern functions
      // for future modification and semantic understanding of compiler internal we keep this now.

      case name: {
        const os = OS_MAP[name];
        const file = FILE_MAP[name];
        const time = TIME_MAP[name];
        const NW = NETWORK_MAP[name];
        const HTTP = HTTP_MAP[name];
        const SYS = SYS_MAP[name];
        const FFI = FFI_MAP[name];
        const PATH = PATH_MAP[name];
        const HTTPSERVER = HTTPSERVER_MAP[name];
        const THREAD = THREAD_MAP[name];
        const DEBUG = DEBUG_MAP[name];
        const CRYPTO = CRYPTO_MAP[name];

        if (os) {
          return this.os.zenNativeOSCall(
            node,
            globalScope,
            os[0],
            os[1],
            os[2],
            os[3],
            name,
          );
        } else if (file) {
          return this.file.zenNativeFILECall(
            node,
            globalScope,
            file[0],
            file[1],
            file[2],
            file[3],
            name,
          );
        } else if (time) {
          return this.time.zenNativeTIMECall(
            node,
            globalScope,
            time[0],
            time[1],
            time[2],
            time[3],
            name,
          );
        } else if (NW) {
          return this.network.zenNativeNWCall(
            node,
            globalScope,
            NW[0],
            NW[1],
            NW[2],
            NW[3],
            name,
          );
        } else if (HTTP) {
          return this.http.zenNativeHTTPCall(
            node,
            globalScope,
            HTTP[0],
            HTTP[1],
            HTTP[2],
            HTTP[3],
            name,
          );
        } else if (SYS) {
          return this.sys.zenNativeSYSCall(
            node,
            globalScope,
            SYS[0],
            SYS[1],
            SYS[2],
            SYS[3],
            name,
          );
        } else if (FFI) {
          return this.ffi.zenFFI(
            node,
            globalScope,
            FFI[0],
            FFI[1],
            FFI[2],
            FFI[3],
            name,
          );
        } else if (PATH) {
          return this.path.zenPATH(
            node,
            globalScope,
            PATH[0],
            PATH[1],
            PATH[2],
            PATH[3],
            name,
          );
        } else if (HTTPSERVER) {
          return this.HTTPSERVER.zenHTTPSERVER(
            node,
            globalScope,
            HTTPSERVER[0],
            HTTPSERVER[1],
            HTTPSERVER[2],
            HTTPSERVER[3],
            name,
          );
        } else if (THREAD) {
          return this.THREAD.zenTHREAD(
            node,
            globalScope,
            THREAD[0],
            THREAD[1],
            THREAD[2],
            THREAD[3],
            name,
          );
        } else if (DEBUG) {
          return this.DEBUG.zenDEBUG(
            node,
            globalScope,
            DEBUG[0],
            DEBUG[1],
            DEBUG[2],
            DEBUG[3],
            name,
          );
        } else if (CRYPTO) {
          return this.crypto.ZENCRYPTO(
            node,
            globalScope,
            CRYPTO[0],
            CRYPTO[1],
            CRYPTO[2],
            CRYPTO[3],
            name,
          );
        }
      }

      default:
        this.IRB.emitError(
          "InternalError",
          `unknown builtin function ${name}`,
          node,
        );
    }
  }
}
