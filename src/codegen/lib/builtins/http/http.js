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
    caller
  ) {
    this.IRB.usedNameSpaces.add("http");

    const isAwait = node.isAwait;

    const args = node.args;

    if (!args) {
      this.IRB.emitError(
        "SyntaxError",
        `'${funcName}' must be called as a function — did you forget '()'?`,
        node,
      );
    }

    if (args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `Function ${name} accept exactly ${paramCount} argument(s)`,
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
        `Function ${name} expects a callback at arg ${i + 1}`,
        arg,
      );
    }

    callback = this.IRB.functions.get(arg.name);
  } else if (arg.type !== "FUNCTION_DECLARATION") {
    this.IRB.emitError(
      "TypeError",
      `Function ${name} expects a callback at arg ${i + 1}`,
      arg,
    );
  }

  this.validateCallback(callback, specs[i], name, i);

  if (arg.type === "FUNCTION_DECLARATION") {
    return caller.lowerInlineCallback(arg);
  }

  return this.expr.handleExpression(arg);
});

    exprs.forEach((expr, i) => {
      if (specs[i]) return;

      const actualType = expr.type;
      const expectedType = params[i];
      const isList = expr?.isList;
      const displayType = isList ? `List` : actualType;

      if (isList || expectedType !== actualType) {
        this.IRB.emitError(
          "TypeError",
          `Function ${name} expects ${expectedType} at arg ${i + 1}, got ${displayType}`,
          node.args[i],
        );
      }
    });

    // Arg type mapper

    const getArgType = (e) => {
      switch (e) {
        case "int":
          return "i32";
        case "double":
          return "double";
        case "bool":
          return "i1";
        case "string":
          return "ptr";
        case "long":
          return "i64";
        case "byte":
          return "i8";
        default:
          this.IRB.emitError("TypeError", `Unsupported arg type: ${e}`, node);
      }
    };

    exprs.forEach((e) => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });

    const argTypes = exprs.map((e, i) =>
      specs[i] ? "ptr" : getArgType(e.type),
    );

    const callArgs = exprs.map((e, i) => `${argTypes[i]} ${e.ptr}`).join(", ");

    const llvmRet = this.IRB.getLLVMType(returnType);

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${argTypes.join(", ")})`,
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
      type: returnType,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
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

    if (arg.params.length !== spec.params.length) {
      this.IRB.emitError(
        "TypeError",
        `Callback '${arg.name}' does not match ${at}: expected ${spec.params.length} parameter(s), got ${arg.params.length}`,
        arg,
      );
    }

    spec.params.forEach((expected, j) => {
      const t = arg.params[j].type;
      const got = typeof t === "string" ? t : t.type;
      if (got !== expected) {
        this.IRB.emitError(
          "TypeError",
          `Callback '${arg.name}' does not match ${at}: parameter ${j + 1} expects '${expected}', got '${got}'`,
          arg,
        );
      }
    });

    const rt = arg.returnType;
    const actualReturn = typeof rt === "string" ? rt : rt.type;
    if (actualReturn !== spec.returnType) {
      this.IRB.emitError(
        "TypeError",
        `Callback '${arg.name}' does not match ${at}: expected return type '${spec.returnType}', got '${actualReturn}'`,
        arg,
      );
    }
  }
}
