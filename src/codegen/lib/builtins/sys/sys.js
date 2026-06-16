export class ZenSys {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }
  zenNativeSYSCall(node, globalScope, funcName, returnType, paramCount = 0, params, name) {
    
    const args = node.args;
    
    if (args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `Function ${name} accept exactly ${paramCount} argument(s)`, node
      );
    }
    
    // sys.argv is superately handled
    
    if (funcName === "_sys_argv") {
      this.IRB.declareOneTime(
        "ZenList",
        "%ZenList = type { ptr, i32, i32, i64 }"
      );
      this.IRB.declareOneTime("_sys_argv", "declare ptr @_sys_argv(i32, ptr)");
      const tmp = this.IRB.newTemp();
      this.IRB.emit(`${tmp} = call ptr @_sys_argv(i32 %argc, ptr %argv)`);
      
    return {
      ptr: tmp,
      type: "string", // generic is string
      llvmType: "ptr",
      local: [],
      global: [],
      isList: true,
      generic: {
        generic: {
        type: "string",
        llvmType: "ptr",
        isList: false
        }
      },
      postOrPrefix: false
    };
    }
    
    const exprs = args.map(arg => this.expr.handleExpression(arg));
    
    exprs.forEach((expr, i) => {
      const actualType = expr.type;
      const expectedType = params[i];
      const isList = expr?.isList;
      const displayType = isList ?
        `List` :
        actualType;
      
      if (isList || (expectedType !== actualType)) {
        this.IRB.emitError(
          "TypeError",
          `Function ${name} expects ${expectedType} at arg ${i + 1}, got ${displayType}`,
          node.args[i]
        );
      }
    });
    
    const getArgType = (e) => {
      switch (e) {
        case "int":
          return "i32";
        case "double":
          return "double";
        case 'bool':
          return "i1";
        case "string":
          return "i8*";
        case "List":
          return "ptr";
        case "Map":
          return "ptr";
        default:
          this.IRB.emitError("TypeError", `Unsupported arg type: ${e}`, node);
      }
    };
  
    
    exprs.forEach(e => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });
    
    const callArgs = exprs.map(e => {
      const t = getArgType(e.type);
      return `${t} ${e.ptr}`;
    }).join(", ");
    
    const llvmRet = this.IRB.getLLVMType(returnType);
    
  
    
    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${exprs.map(e => getArgType(e.type)).join(", ")})`
    );
    
    
    let t = null;
    if (llvmRet === "void") {
      this.IRB.emit(`call ${llvmRet} @${funcName}(${callArgs})`);
    } else {
      t = this.IRB.newTemp();
      this.IRB.emit(`${t} = call ${llvmRet} @${funcName}(${callArgs})`);
    }
    
    return {
      ptr: t,
      type: returnType,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false
    };
  }
}