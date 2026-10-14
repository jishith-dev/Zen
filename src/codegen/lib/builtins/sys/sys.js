export class ZenSys {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  zenNativeSYSCall(
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

    if (args.length !== paramCount) {
      this.IRB.emitError(
        "ArgumentError",
        `${displayName} takes exactly ${paramCount} argument(s), but ${args.length} were given`,
        node,
      );
    }

    // sys.argv is handled separately
    if (funcName === "_sys_argv") {
      this.IRB.declareOneTime(
        "ZenList",
        "%ZenList = type { ptr, i32, i32, i64, i32, i32 }",
      );
      this.IRB.declareOneTime("_sys_argv", "declare ptr @_sys_argv(i32, ptr)");
      const tmp = this.IRB.newTemp();
      const loadedC = this.IRB.newTemp();
      const loadedPtr = this.IRB.newTemp();
      this.IRB.emit(`${loadedC} = load i32, ptr @argc`);
      this.IRB.emit(`${loadedPtr} = load ptr, ptr @argv`);
      this.IRB.emit(
        `${tmp} = call ptr @_sys_argv(i32 ${loadedC}, ptr ${loadedPtr})`,
      );

      return {
        ptr: tmp,
        type: "string", // element type
        llvmType: "ptr",
        local: [],
        global: [],
        isList: true,
        generic: {
          generic: {
            type: "string",
            llvmType: "ptr",
            isList: false,
          },
        },
        postOrPrefix: false,
      };
    }

    const exprs = args.map((arg) => this.expr.handleExpression(arg));

    this.IRB.checkArgTypes(displayName, params, exprs, args);

    exprs.forEach((e) => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });

    const argLLVMTypes = exprs.map((e) =>
      this.IRB.getLLVMType(e.isList ? "List" : e.type),
    );
    const callArgs = exprs
      .map((e, i) => `${argLLVMTypes[i]} ${e.ptr}`)
      .join(", ");
    const llvmRet = this.IRB.getLLVMType(returnType);

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${argLLVMTypes.join(", ")})`,
    );

    let t = null;
    if (llvmRet === "void") {
      this.IRB.emit(`call ${llvmRet} @${funcName}(${callArgs})`);
    } else {
      t = this.IRB.newTemp();
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
}