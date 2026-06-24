export class ZenFileSystem {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }
  
   zenNativeFILECall(node, globalScope, funcName, returnType, paramCount = 0, params, name) {
    
    const args = node.args;
    
    if (!args) {
  this.IRB.emitError(
    "SyntaxError",
    `'${funcName}' must be called as a function — did you forget '()'?`,
    node
  );
}
    
    if (args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `Function ${name} accept exactly ${paramCount} argument(s)`, node
      );
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
      
      if (funcName !== "_fs_writeFileBytes" && expectedType !== "byte") {
        this.IRB.emitError(
          "TypeError",
          `Function ${name} expects ${expectedType} at arg ${i + 1}, got ${displayType}`, node.args[i]
        );
      }
      
      }
    });
    
    // Arg type mapper

    const getArgType = (e) => {
      switch (e) {
        case "int":
          return "i32";
        case "double":
          return "double";
        case 'bool':
          return "i1";
        case "string":
          return "ptr";
        case "byte": // special case
          return "ptr";
        default:
          this.IRB.emitError("TypeError", `Unsupported arg type: ${e}`, node);
      }
    };
    
    // Emit inner code first

    exprs.forEach(e => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });
    

    const callArgs = exprs.map(e => {
  let ptr = e.ptr;

  if (e.needsLoad) {
    const tmp = this.IRB.newTemp();
    this.IRB.emit(`${tmp} = load ptr, ptr ${ptr}`);
    ptr = tmp;
  }

  const t = getArgType(e.type);
  return `${t} ${ptr}`;
}).join(", ");
    
    const llvmRet = this.IRB.getLLVMType(returnType);


    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${exprs.map(e => getArgType(e.type)).join(", ")})`
    );
    
    const isVoidFn = llvmRet === "void";
    const t = this.IRB.newTemp();
    
    if (isVoidFn) {
      this.IRB.emit(`call ${llvmRet} @${funcName}(${callArgs})`);
    } else {
      
      this.IRB.emit(`${t} = call ${llvmRet} @${funcName}(${callArgs})`);
    }
    
    const listRetFn = ["_fs_readFileBytes"]; // only list return fn in fs namespace
    const generic = { generic: "byte" }
    return {
      ptr: isVoidFn ? null : t,
      type: isVoidFn ? "void" : returnType,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
      isList: listRetFn.includes(funcName),
      generic: listRetFn.includes(funcName) ? generic : null
    };
   }
}