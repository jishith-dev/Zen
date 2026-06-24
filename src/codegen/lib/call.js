import {
  NON_STANDALONE_BUILTINS,
  OS_MAP,
  FILE_MAP,
  TIME_MAP,
  NETWORK_MAP,
  SYS_MAP,
  HTTP_MAP,
  STD_FUNCTIONS,
  FFI_MAP,
  PATH_MAP
} from "../../config/config.js";

export class Call {
  constructor(IRB, expr, io, type, string, file, os, time, network, http, sys, ffi, path) {
    this.IRB = IRB;
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
  }
  
  setExpression(expr) {
    this.expr = expr;
  }
  
  handleCall(node, asStatement = false, globalScope) {
    
    this.IRB.guardStackOp("CALL", node);
    this.IRB.enterFunction(node.name);
    const isMethodCall = !!node?.callee;
    
    if (isMethodCall) {
      const fakeNode = {
        type: "MEMBER_ACCESS",
        field: node.callee.field,
        object: node.callee.object,
        args: node.args
      }
      
      const valExpr = this.expr.handleExpression(fakeNode);
      
      this.IRB.emitExpr(valExpr);
      
      return {
        ptr: valExpr.ptr,
        type: valExpr.type,
        llvmType: valExpr.llvmType,
        local: valExpr.local,
        global: valExpr.global,
        endLabel: null,
        isVarRef: false,
        postOrPrefix: false,
        isList: valExpr?.isList,
        generic: valExpr?.generic
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
    
    let mangledName = isStdFn ? name : `zen_${name}`;
    if (this.IRB.stdlibMode) {
      mangledName = name;
      } 
    
    if (node.isInbuilt && !STD_FUNCTIONS.includes(name)) {
      
      this.IRB.leaveFunction();
      
      return this.handleBuiltInCall(node, globalScope);
    }
    
    if (node.isAwait && !this.IRB.currentFunction.isAsync) {
      this.IRB.emitError(
        "SyntaxError",
        "await can only be used inside async functions", node
      );
    }
    
    const fn = this.IRB.getFunction(name, node);
    const isStruct = this.IRB.hasStruct(fn.returnType);
    
    
const llvmRetType = isStruct ? "void" : this.IRB.getLLVMType(fn.returnType);

    const hasRest = fn.params.some(p => p.isRest);
    
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
  
  if (arg.type === "MAP_LITERAL") {
    
    // Determine the expected struct type from the param's declared type
    const paramType = param?.type?.type || param?.type;
    
    if (!paramType || !this.IRB.hasStruct(paramType)) {
      this.IRB.emitError(
        "TypeError",
        `Cannot infer struct type for literal argument in call to '${node.name}'`,
        node
      );
    }
    
    const ptr = this.IRB.emitStructLiteral(paramType, arg);
    
    val = {
      ptr,
      type: paramType,
      llvmType: `%${paramType}`,
      isStruct: true,
      local: [],
      global: [],
      isVarRef: false
    };
    
  } else {
    
    val = this.expr.handleExpression(arg, false);
    
    if (val.type === "void") {
      this.IRB.emitError("TypeError", "void value used in expression", node);
    }
    
    this.IRB.emitExpr(val);
  }
  
  args.push(val);
}
    
  
    
    let restIndex = -1;
    
    if (hasRest) {
      restIndex = fn.params.findIndex(p => p.isRest);
    }
    
    this.IRB.validateCallArgs(fn, args, hasRest, restIndex, node);
    
    let layout = null;
    if (fn.returnType === "Map") {
      
      layout = fn.layout;
    }
    
    let argStr = [];
    
    // Map as param in functions are disabled in v1
    /*for (let i = 0; i < args.length; i++) {
      const a = args[i];
      const param = fn.params[i];
      
    
      if (param?.isMap || param?.type.type === "Map") {
        const argNode = finalArgs[i];
        const argName = argNode?.name; 
        const layoutt = this.IRB.maps.get(argName);
        layout = layoutt;
        if (layout) {
          
          this.IRB.maps.set(param.name, layoutt); 
        }
      }
    }
    */
    
    if (hasRest) {
      
      this.IRB.declareOneTime(
        "zen_list_new",
        "declare ptr @_zen_list_new(i64)"
      );
      
      this.IRB.declareOneTime(
        "zen_list_push",
        "declare void @_zen_list_push(ptr, ptr)"
      );
      
      this.IRB.declareOneTime(
        "ZenList",
        `%ZenList = type { ptr, i32, i32, i64 }`
      );
      
      const fixedArgs = args.slice(0, restIndex);
      const restArgs = args.slice(restIndex);
      
      let argStr = [];
      let global = [];
      let local = [];
      
    
      
      for (const a of fixedArgs) {
        
        if (a.global?.length) global.push(...a.global);
        if (a.local?.length) local.push(...a.local);
        
        if (a.isList) {
          const tmp = this.IRB.newTemp();
          local.push(`${tmp} = load ptr, ptr ${a.ptr}`);
          argStr.push(`ptr ${tmp}`);
        } else {
          argStr.push(`${a.llvmType} ${a.ptr}`);
        }
      }
      
      // REST TYPE VALIDATION
      
      const first = restArgs[0];
      // declared rest param type
      const restParam = fn.params[restIndex];
      
      // expected type from function signature
      const expectedType = restParam?.type?.type || restParam?.type;
      
      const inferredType = first?.type;
      
      if (!first) {
        this.IRB.emitError(
          "TypeError",
          `Rest parameter expects at least 1 argument`, node
        );
      }
      
      // declared type vs inferred type check
      if (expectedType && inferredType && expectedType !== inferredType) {
        this.IRB.emitError(
          "TypeError",
          `Rest parameter expects ${expectedType} but got ${inferredType}`, node
        );
      }
      
      for (const a of restArgs) {
        const t = a.type;
        
        if (expectedType && t !== expectedType) {
          this.IRB.emitError(
            "TypeError",
            `Rest parameter expects ${expectedType} but got ${t}`, node
          );
        }
      }
      
      const elementSize = this.IRB.sizeOf(inferredType);
      const llvmType = this.IRB.getLLVMType(inferredType);
      const listPtr = this.IRB.newTemp();
      
      local.push(
        `${listPtr} = call ptr @_zen_list_new(i64 ${elementSize})`
      );
      
      const count = restArgs.length;
      
      for (let i = 0; i < count; i++) {
        
        const a = restArgs[i];
        
        const tmp =
          this.IRB.newTemp();
        
        local.push(`${tmp} = alloca ${llvmType}`);
        
        local.push(`store ${llvmType} ${a.ptr}, ptr ${tmp}`);
        
        local.push(
          `call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`
        );
      }
      
      argStr.push(`ptr ${listPtr}`);
      
      
      let callTmp = null;
      
      if (fn.returnType === "void" || isStruct) {
        
        const tmp = this.IRB.newTemp();
        if (isStruct) {
          local.push(`${tmp} = alloca %${fn.returnType}`);
        }
        
        local.push(
          `call void @${mangledName}(${argStr.join(", ")})`
        );
        
      } else {
        
        callTmp = this.IRB.newTemp();
        
        local.push(
          `${callTmp} = call ${llvmRetType} @${name}(${argStr.join(", ")})`
        );
      }
      
      if (asStatement) {
        this.IRB.emit(local.join("\n"));
        this.IRB.globals.push(global.join("\n"));
      }
      const isList = fn.returnType === "List";
      
      const isMap = fn.returnType === "Map";
      
      if (isList) {
      this.IRB.declareOneTime("ZenList", "%ZenList = type { ptr, i32, i32, i64 }")
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
        layout,
        needsLoad: false,
        isList,
        isMap,
        isStruct,
        isDirectCall: true
      };
    }
    
    
    
    // NORMAL CALL 
    
    for (const a of args) {
      
      if (a?.isStruct) {
        argStr.push(`ptr ${a.ptr}`);
      } else if (a.needsLoad) {
        const tmp = this.IRB.newTemp();
        local.push(`${tmp} = load ptr, ptr ${a.ptr}`);
        argStr.push(`ptr ${tmp}`);
      } else {
          argStr.push(`${a.llvmType} ${a.ptr}`);
        }
    }
    
    if (fn.returnType === "void" || isStruct) {
      
      const tmp = this.IRB.newTemp();
        if (isStruct) {
          
          local.push(`${tmp} = alloca %${fn.returnType}`);

const args = [
  `ptr sret(%${fn.returnType}) ${tmp}`,
  ...argStr
];

local.push(
  `call void @${mangledName}(${args.join(", ")})`
);
        } else {
      
      local.push(`call void @${mangledName}(${argStr.join(", ")})`);
        }
      
      if (asStatement) {
        this.IRB.emit(local.join("\n"));
        this.IRB.globals.push(global.join("\n"));
      }
      
      return {
        ptr: isStruct ? tmp : null,
        type: isStruct ? fn.returnType : "void",
        llvmType: isStruct ? "ptr" : "void",
        local: asStatement ? [] : local,
        global: asStatement ? [] : global,
        endLabel: null,
        isVarRef: false,
        postOrPrefix: false,
        layout,
        isStruct
      };
    }
    
    const tmp = this.IRB.newTemp();
    
    local.push(
      `${tmp} = call ${llvmRetType} @${mangledName}(${argStr.join(", ")})`
    );
    
    if (asStatement) {
      this.IRB.emit(local.join("\n"));
      this.IRB.globals.push(global.join("\n"));
    }
    
    const isList = fn.returnType === "List";
    
    const isMap = fn.returnType === "Map";
    
    if (isList) {
      this.IRB.declareOneTime("ZenList", "%ZenList = type { ptr, i32, i32, i64 }")
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
      layout,
      needsLoad: false, // call not need load
      isList,
      isMap,
      isStruct,
      isDirectCall: true
    };
  }
  
  
  // built in function routing
  
  handleBuiltInCall(node, globalScope) {
    
    this.IRB.guardStackOp("CALL", node);
    
    const type = node?.type;
    
    let name = node.name;
    
    switch (name) {
      case 'screen':
        this.io.screen(node);
        break;
        
      case 'input':
       return this.io.input(node, globalScope);
        
      case 'type':
        return this.type.type(node, globalScope);
        
      case 'Int':
        return this.type.Int(node, globalScope);
        
      case 'Double':
        return this.type.Double(node, globalScope);
        
      case 'Bool':
        return this.type.Bool(node, globalScope);
        
      case 'String':
        return this.type.StringCast(node, globalScope);
        
      case 'toString':
        return this.type.toString(node, globalScope);
        
      case 'toInt':
        return this.type.toInt(node, globalScope);
        
      case 'length':
        return this.string.length(node, globalScope);
        
      case 'matchRegex':
        return this.string.matchRegex(node);
        
        // these are same pattern functions 
        // unified
      case name: {
        const os = OS_MAP[name];
        const file = FILE_MAP[name];
        const time = TIME_MAP[name];
        const NW = NETWORK_MAP[name];
        const HTTP = HTTP_MAP[name];
        const SYS = SYS_MAP[name];
        const FFI = FFI_MAP[name];
        const PATH = PATH_MAP[name];
        
        if (os) {
          return this.os.zenNativeOSCall(
            node,
            globalScope,
            os[0],
            os[1],
            os[2],
            os[3],
            name
          );
        } else if (file) {
          return this.file.zenNativeFILECall(
            node,
            globalScope,
            file[0],
            file[1],
            file[2],
            file[3],
            name
          );
        } else if (time) {
          
          return this.time.zenNativeTIMECall(
            node,
            globalScope,
            time[0],
            time[1],
            time[2],
            time[3],
            name
          );
        } else if (NW) {
          return this.network.zenNativeNWCall(
            node,
            globalScope,
            NW[0],
            NW[1],
            NW[2],
            NW[3],
            name
          );
        } else if (HTTP) {
          return this.
          http.zenNativeHTTPCall(
            node,
            globalScope,
            HTTP[0],
            HTTP[1],
            HTTP[2],
            HTTP[3],
            name
          );
        } else if (SYS) {
          return this.sys.zenNativeSYSCall(
            node,
            globalScope,
            SYS[0],
            SYS[1],
            SYS[2],
            SYS[3],
            name
          );
        } else if (FFI) {
          return this.ffi.zenFFI(
            node,
            globalScope,
            FFI[0],
            FFI[1],
            FFI[2],
            FFI[3],
            name
          );
        } else if (PATH) {
          return this.path.zenPATH(
            node,
            globalScope,
            PATH[0],
            PATH[1],
            PATH[2],
            PATH[3],
            name
          );
        }
        
      }
      
      default:
        this.IRB.emitError("InternalError", `unknown builtin function ${name}`, node);
    }
  }
}