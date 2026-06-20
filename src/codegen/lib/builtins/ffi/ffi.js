export class FFI {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  zenFFI(node, globalScope, funcName, returnType, paramCount = 0, params, name) {

    const args = node.args;

    if (!args) {
      this.IRB.emitError(
        "SyntaxError",
        `'${name}' must be called as a function — did you forget '()'?`,
        node
      );
    }

    const isVariadic = paramCount === "INF";

    if (!isVariadic && args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `Function ${name} accepts exactly ${paramCount} argument(s)`, node
      );
    }

    if (isVariadic && args.length < params.length) {
      this.IRB.emitError(
        "ArgumentError",
        `Function ${name} requires at least ${params.length} argument(s)`, node
      );
    }

    const exprs = args.map(arg => this.expr.handleExpression(arg));

    // type check only the FIXED params; variadic extras are unchecked
    exprs.forEach((expr, i) => {
      if (i >= params.length) return; // variadic extras — skip strict check

      const actualType = expr.type;
      const expectedType = params[i];

      if (expectedType !== actualType) {
        this.IRB.emitError(
          "TypeError",
          `Function ${name} expects ${expectedType} at arg ${i + 1}, got ${actualType}`, node.args[i]
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
        default:
          this.IRB.emitError("TypeError", `Unsupported arg type: ${e}`, node);
      }
    };

    // C varargs promotion: bool -> i32, (float would -> double, but Zen has no float type)
    const promoteForVariadic = (expr, isExtra) => {
      if (!isExtra) return { llvmType: getArgType(expr.type), ptr: expr.ptr };

      if (expr.type === "bool") {
        const widened = this.IRB.newTemp();
        this.IRB.emit(`${widened} = zext i1 ${expr.ptr} to i32`);
        return { llvmType: "i32", ptr: widened };
      }

      return { llvmType: getArgType(expr.type), ptr: expr.ptr };
    };

    // flush all pending instructions for each arg expression
    exprs.forEach(e => this.IRB.emitExpr(e));

    const resolvedArgs = exprs.map((e, i) =>
      promoteForVariadic(e, isVariadic && i >= params.length)
    );

    const callArgs = resolvedArgs
      .map(r => `${r.llvmType} ${r.ptr}`)
      .join(", ");

    const llvmRet = this.IRB.getLLVMType(returnType);
    const cSymbol = funcName.split("_")[2];

    if (isVariadic) {

      const fixedTypes = params.map(getArgType).join(", ");

      this.IRB.declareOneTime(
        cSymbol,
        `declare ${llvmRet} @${cSymbol}(${fixedTypes}, ...)`
      );

      const t = this.IRB.newTemp();
      this.IRB.emit(
        `${t} = call ${llvmRet} (${fixedTypes}, ...) @${cSymbol}(${callArgs})`
      );

      return {
        ptr: t,
        type: returnType,
        llvmType: llvmRet,
        local: [],
        global: [],
        postOrPrefix: false
      };
    }

    // non-variadic — fixed arity, safe to declare from params directly
    this.IRB.declareOneTime(
      cSymbol,
      `declare ${llvmRet} @${cSymbol}(${params.map(getArgType).join(", ")})`
    );

    if (returnType === "void") {
      this.IRB.emit(`call void @${cSymbol}(${callArgs})`);

      return {
        ptr: null,
        type: "void",
        llvmType: "void",
        local: [],
        global: [],
        isVarRef: false
      };
    }

    const t = this.IRB.newTemp();
    this.IRB.emit(`${t} = call ${llvmRet} @${cSymbol}(${callArgs})`);

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