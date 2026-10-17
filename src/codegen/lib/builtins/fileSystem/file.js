export class ZenFileSystem {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  zenNativeFILECall(
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
      .map((e, i) => {
        let ptr = e.ptr;

        if (e.needsLoad) {
          const tmp = this.IRB.newTemp();
          this.IRB.emit(`${tmp} = load ptr, ptr ${ptr}`);
          ptr = tmp;
        }

        return `${argLLVMTypes[i]} ${ptr}`;
      })
      .join(", ");

    const isListRet = ["_fs_readFileBytes", "_fs_listDir"].includes(funcName);
    const llvmRet = this.IRB.getLLVMType(isListRet ? "List" : returnType);

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${argLLVMTypes.join(", ")})`,
    );

    const isVoidFn = llvmRet === "void";
    const t = this.IRB.newTemp();

    if (isVoidFn) {
      this.IRB.emit(`call ${llvmRet} @${funcName}(${callArgs})`);
    } else {
      this.IRB.emit(`${t} = call ${llvmRet} @${funcName}(${callArgs})`);
    }

    this.IRB.cleanupBuiltinStringTemps(exprs);

    const elemType = funcName === "_fs_listDir" ? "string" : "byte";

    return {
      ptr: isVoidFn ? null : t,
      type: isVoidFn ? "void" : isListRet ? elemType : returnType,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
      isList: isListRet,
      internalType: isListRet ? "List" : undefined,
      retGeneric: isListRet ? elemType : undefined,
      generic: isListRet ? { type: "List", generic: { type: elemType } } : null,
    };
  }
}
