export class ZenCrypto {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  ZENCRYPTO(
    node,
    globalScope,
    funcName,
    returnType,
    paramCount = 0,
    params = [],
    name,
  ) {
    const displayName = this.IRB.displayFnName(name);
    const args = node.args;

    this.IRB.usedNameSpaces.add("crypto");

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

    // Any List<T> is passed as a plain "List" pointer
    const argLLVMTypes = params.map((p) =>
      this.IRB.getLLVMType(p.startsWith("List<") ? "List" : p),
    );

    const callArgs = exprs.map((e, i) => {
      let value = e.ptr;

      if (e.needsLoad) {
        value = this.IRB.newTemp();
        this.IRB.emit(`${value} = load ptr, ptr ${e.ptr}`);
      }

      return `${argLLVMTypes[i]} ${value}`;
    });

    const isList = returnType.startsWith("List<");
    const type = isList ? returnType.slice(5, -1) : returnType;
    const llvmRet = this.IRB.getLLVMType(isList ? "List" : returnType);

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${argLLVMTypes.join(", ")})`,
    );

    let t = null;

    if (llvmRet === "void") {
      this.IRB.emit(`call ${llvmRet} @${funcName}(${callArgs.join(", ")})`);
    } else {
      t = this.IRB.newTemp();
      this.IRB.emit(
        `${t} = call ${llvmRet} @${funcName}(${callArgs.join(", ")})`,
      );
    }

    this.IRB.cleanupBuiltinStringTemps(exprs);

    return {
      ptr: t,
      type,
      isList,
      internalType: isList ? "List" : undefined,
      retGeneric: isList ? type : undefined,
      generic: isList ? { type: "List", generic: { type } } : null,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
    };
  }
}

