
export class PATH {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  zenPATH(
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
    const isVariadic = paramCount === Infinity;

    if (!args) {
      this.IRB.emitError(
        "SyntaxError",
        `'${displayName}' must be called as a function. Did you forget '()'?`,
        node,
      );
      return;
    }

    if (isVariadic) {
      if (args.length < 2) {
        this.IRB.emitError(
          "ArgumentError",
          `${displayName} takes at least 2 arguments, but ${args.length} were given`,
          node,
        );
        return;
      }
    } else if (args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `${displayName} takes exactly ${paramCount} argument(s), but ${args.length} were given`,
        node,
      );
      return;
    }

    const exprs = args.map((arg) =>
      this.expr.handleExpression(arg),
    );

    if (isVariadic) {
      let invalid = false;

      exprs.forEach((e, i) => {
        if (e.type !== "string") {
          invalid = true;
          this.IRB.emitError(
            "TypeError",
            `Argument ${i + 1} of '${displayName}' must be a string, got '${e.type}'`,
            args[i],
          );
        }
      });

      if (invalid) return;
    } else {
      this.IRB.checkArgTypes(displayName, params, exprs, args);
    }

    exprs.forEach((e) => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });

    const argLLVMTypes = exprs.map((e) =>
      this.IRB.getLLVMType(e.type),
    );
    const llvmRet = isVoid ? "void" : this.IRB.getLLVMType(returnType);

    const callArgs = isVariadic
      ? [
          `i32 ${args.length}`,
          ...exprs.map((e, i) => `${argLLVMTypes[i]} ${e.ptr}`),
        ].join(", ")
      : exprs
          .map((e, i) => `${argLLVMTypes[i]} ${e.ptr}`)
          .join(", ");

    const llvmParams = isVariadic
      ? "i32, ..."
      : argLLVMTypes.join(", ");

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${llvmParams})`,
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
