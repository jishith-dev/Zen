export class OS {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  zenNativeOSCall(
    node,
    globalScope,
    funcName,
    returnType,
    paramCount = 0,
    params,
    name,
  ) {
    const displayName = this.IRB.displayFnName(name);
    const isVoid = returnType === "void";
    const args = node.args;

    if (!args) {
      this.IRB.emitError(
        "SyntaxError",
        `'${displayName}' must be called as a function. Did you forget '()'?`,
        node,
      );
    }

    if (args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `${displayName} takes exactly ${paramCount} argument(s), but ${args.length} were given`,
        node,
      );
    }

    const exprs = args.map((arg) => this.expr.handleExpression(arg));

    this.IRB.checkArgTypes(displayName, params, exprs, args);

    exprs.forEach((e) => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });

    const argLLVMTypes = exprs.map((e) => this.IRB.getLLVMType(e.type));
    const callArgs = exprs
      .map((e, i) => `${argLLVMTypes[i]} ${e.ptr}`)
      .join(", ");
    const llvmRet = isVoid ? "void" : this.IRB.getLLVMType(returnType);

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${argLLVMTypes.join(", ")})`,
    );

    if (isVoid) {
      this.IRB.emit(`call void @${funcName}(${callArgs})`);
      return;
    }

    const t = this.IRB.newTemp();
    this.IRB.emit(`${t} = call ${llvmRet} @${funcName}(${callArgs})`);

    this.IRB.cleanupBuiltinStringTemps(exprs);

    return {
      ptr: t,
      type: returnType,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
    };
  }
}