export class FFI {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  zenFFI(
    node,
    globalScope,
    funcName,
    returnType,
    paramCount = 0,
    params,
    name,
  ) {
    const displayName = this.IRB.displayFnName(name);
    const args = node.args;

    if (!args) {
      this.IRB.emitError(
        "SyntaxError",
        `'${displayName}' must be called as a function. Did you forget '()'?`,
        node,
      );
    }

    const isVariadic = paramCount === "INF";

    if (!isVariadic && args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `${displayName} takes exactly ${paramCount} argument(s), but ${args.length} were given`,
        node,
      );
    }

    if (isVariadic && args.length < params.length) {
      this.IRB.emitError(
        "ArgumentError",
        `${displayName} takes at least ${params.length} argument(s), but ${args.length} were given`,
        node,
      );
    }

    const exprs = args.map((arg) => this.expr.handleExpression(arg));

    
    this.IRB.checkArgTypes(displayName, params, exprs, args);

    const llvm = (t) => this.IRB.getLLVMType(t);

    // C varargs promotion
    const promoteForVariadic = (e, isExtra) => {
      if (isExtra && e.type === "bool") {
        const widened = this.IRB.newTemp();
        this.IRB.emit(`${widened} = zext i1 ${e.ptr} to i32`);
        return { llvmType: "i32", ptr: widened };
      }

      return { llvmType: llvm(e.type), ptr: e.ptr };
    };

    exprs.forEach((e) => this.IRB.emitExpr(e));

    const resolvedArgs = exprs.map((e, i) =>
      promoteForVariadic(e, isVariadic && i >= params.length),
    );

    const callArgs = resolvedArgs
      .map((r) => `${r.llvmType} ${r.ptr}`)
      .join(", ");

    const llvmRet = llvm(returnType);
    const cSymbol = funcName.split("_").slice(2).join("_");
    const fixedTypes = params.map((p) => llvm(p)).join(", ");

    if (isVariadic) {
      this.IRB.declareOneTime(
        cSymbol,
        `declare ${llvmRet} @${cSymbol}(${fixedTypes}, ...)`,
      );

      const t = this.IRB.newTemp();
      this.IRB.emit(
        `${t} = call ${llvmRet} (${fixedTypes}, ...) @${cSymbol}(${callArgs})`,
      );

      return {
        ptr: t,
        type: returnType,
        llvmType: llvmRet,
        local: [],
        global: [],
        postOrPrefix: false,
      };
    }

    this.IRB.declareOneTime(
      cSymbol,
      `declare ${llvmRet} @${cSymbol}(${fixedTypes})`,
    );

    if (returnType === "void") {
      this.IRB.emit(`call void @${cSymbol}(${callArgs})`);

      return {
        ptr: null,
        type: "void",
        llvmType: "void",
        local: [],
        global: [],
        isVarRef: false,
      };
    }

    const t = this.IRB.newTemp();
    this.IRB.emit(`${t} = call ${llvmRet} @${cSymbol}(${callArgs})`);

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