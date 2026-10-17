export class ZenHttp {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }
  zenNativeHTTPCall(
    node,
    globalScope,
    funcName,
    returnType,
    paramCount = 0,
    params,
    name,
    caller,
  ) {
    this.IRB.usedNameSpaces.add("http");

    const displayName = this.IRB.displayFnName(name);
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

    const specs = params.map((p) =>
      typeof p === "string" && p.startsWith("fn ")
        ? this.parseCallbackSpec(p)
        : null,
    );

    const exprs = args.map((arg, i) => {
      if (!specs[i]) return this.expr.handleExpression(arg);

      let callback = arg;

      if (arg.type === "variable") {
        if (!this.IRB.functions.has(arg.name)) {
          this.IRB.emitError(
            "TypeError",
            `${displayName}: argument ${i + 1} must be a callback function`,
            arg,
          );
        }

        callback = this.IRB.functions.get(arg.name);
      } else if (arg.type !== "FUNCTION_DECLARATION") {
        this.IRB.emitError(
          "TypeError",
          `${displayName}: argument ${i + 1} must be a callback function`,
          arg,
        );
      }

      this.validateCallback(callback, specs[i], displayName, i);

      if (arg.type === "FUNCTION_DECLARATION") {
        return caller.lowerInlineCallback(arg);
      }

      return this.expr.handleExpression(arg);
    });

    this.IRB.checkArgTypes(displayName, params, exprs, args, (i) => specs[i]);

    exprs.forEach((e) => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });

    const argLLVMTypes = exprs.map((e, i) =>
      specs[i] ? "ptr" : this.IRB.getLLVMType(e.type),
    );
    const callArgs = exprs
      .map((e, i) => `${argLLVMTypes[i]} ${e.ptr}`)
      .join(", ");

    const isListRet = ["_http_getProgress"].includes(funcName);
    const llvmRet = this.IRB.getLLVMType(isListRet ? "List" : returnType);

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${argLLVMTypes.join(", ")})`,
    );

    let t = this.IRB.newTemp();

    if (returnType === "void") {
      this.IRB.emit(`call void @${funcName}(${callArgs})`);
      t = null;
    } else {
      this.IRB.emit(`${t} = call ${llvmRet} @${funcName}(${callArgs})`);
    }

    this.IRB.cleanupBuiltinStringTemps(exprs);

    return {
      ptr: t,
      type: isListRet ? "byte" : returnType,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
      isList: isListRet,
      internalType: isListRet ? "List" : undefined,
      retGeneric: isListRet ? "byte" : undefined,
      generic: isListRet ? { type: "List", generic: { type: "byte" } } : null,
    };
  }

  parseCallbackSpec(spec) {
    const m = /^fn\s+\w+\s*\((.*)\)\s*(\w+)?$/.exec(spec.trim());
    const inner = m[1].trim();
    return {
      params: inner
        ? inner.split(",").map((s) => s.trim().split(/\s+/)[0])
        : [],
      returnType: m[2] ?? "void",
    };
  }

  validateCallback(arg, spec, name, i) {
    const at = `argument ${i + 1} of '${name}'`;
    const cb = arg.name ?? "<inline>";

    if (arg.params.length !== spec.params.length) {
      this.IRB.emitError(
        "TypeError",
        `Callback '${cb}' does not match ${at}: expected ${spec.params.length} parameter(s), got ${arg.params.length}`,
        arg,
      );
    }

    spec.params.forEach((expected, j) => {
      const t = arg.params[j].type;
      const got = typeof t === "string" ? t : t.type;
      if (got !== expected) {
        this.IRB.emitError(
          "TypeError",
          `Callback '${cb}' does not match ${at}: parameter ${j + 1} expects '${expected}', got '${got}'`,
          arg,
        );
      }
    });

    const rt = arg.returnType;
    const actualReturn = typeof rt === "string" ? rt : rt.type;
    if (actualReturn !== spec.returnType) {
      this.IRB.emitError(
        "TypeError",
        `Callback '${cb}' does not match ${at}: expected return type '${spec.returnType}', got '${actualReturn}'`,
        arg,
      );
    }
  }
}
