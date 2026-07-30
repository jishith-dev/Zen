export class DEBUG {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }
  zenDEBUG(
    node,
    globalScope,
    funcName,
    returnType,
    paramCount = 0,
    params,
    name,
  ) {
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

    if (funcName === "debug_pretty") {
      return this.pretty(node);
    }

    const exprs = args.map((arg) => this.expr.handleExpression(arg));

    exprs.forEach((expr, i) => {
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
        default:
          this.IRB.emitError("TypeError", `Unsupported arg type: ${e}`, node);
      }
    };

    exprs.forEach((e) => {
      if (e.local?.length) this.IRB.emit(e.local.join("\n"));
      if (e.global?.length) this.IRB.emit(e.global.join("\n"));
    });

    const callArgs = exprs
      .map((e) => {
        const t = getArgType(e.type);
        return `${t} ${e.ptr}`;
      })
      .join(", ");

    const llvmRet = this.IRB.getLLVMType(returnType);

    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${exprs.map((e) => getArgType(e.type)).join(", ")})`,
    );

    let t = this.IRB.newTemp();

    if (returnType === "void") {
      this.IRB.emit(`call void @${funcName}(${callArgs})`);
      t = null;
    } else {
      this.IRB.emit(`${t} = call ${llvmRet} @${funcName}(${callArgs})`);
    }

    return {
      ptr: t,
      type: returnType,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
    };
  }

  pretty(node) {
    const arg = node.args[0];
    const expr = this.expr.handleExpression(arg);

    if (!expr?.isList && !expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `Function debug.pretty() expects a List<T> or struct, but got ${expr.type}`,
        arg,
      );
    }

    this.IRB.emitExpr(expr);

    // Struct
    // Struct
    if (expr.isStruct) {
      const structInfo = this.IRB.getStruct(expr.type);

      // Builtin opaque structs (runtime handled)
      if (structInfo?.isBuiltin && structInfo?.isOpaque) {
        if (expr.type === "Map") {
          let t;

          if (expr.needsLoad) {
            t = this.IRB.newTemp();
            this.IRB.emit(`${t} = load ptr, ptr ${expr.ptr}`);
          } else {
            t = expr.ptr;
          }

          this.IRB.declareOneTime(
            "_debug_pretty_map",
            "declare void @_debug_pretty_map(ptr, i32)",
          );

          this.IRB.emit(`call void @_debug_pretty_map(ptr ${t}, i32 0)`);

          return;
        }
        this.IRB.emitError(
          "TypeError",
          `debug.pretty() does not support builtin type '${expr.type}'`,
          arg,
        );
      }

      // User-defined structs
      const printFn = this.IRB.getOrBuildStructPrinter(expr.type);
      this.IRB.emit(`call void @${printFn}(ptr ${expr.ptr}, i32 0)`);
      return;
    }

    let t;
    if (expr?.needsLoad) {
      t = this.IRB.newTemp();
      this.IRB.emit(`${t} = load ptr, ptr ${expr.ptr}`);
    } else {
      t = expr.ptr;
    }

    // List
    if (expr.isList) {
      const depth = this.IRB.getListDepth(expr.generic);
      const deepestType = this.IRB.getDeepestGeneric(expr.generic);

      // List of structs
      if (this.IRB.hasStruct(deepestType)) {
        let printFn;

        const structInfo = this.IRB.getStruct(deepestType);

        if (structInfo?.isBuiltin && structInfo?.isOpaque) {
          if (deepestType === "Map") {
            this.IRB.declareOneTime(
              "_debug_pretty_map",
              "declare void @_debug_pretty_map(ptr, i32)",
            );
            this.IRB.declareOneTime(
              "_debug_pretty_map_elem",
              "declare void @_debug_pretty_map_elem(ptr)",
            );

            printFn = "_debug_pretty_map_elem";
          } else {
            this.IRB.emitError(
              "TypeError",
              `debug.pretty() does not support builtin type '${deepestType}'`,
              arg,
            );
            return;
          }
        } else {
          printFn = this.IRB.getOrBuildStructPrinter(deepestType);
        }

        this.IRB.declareOneTime(
          "_debug_pretty_list_struct",
          "declare void @_debug_pretty_list_struct(ptr, i32, ptr)",
        );

        this.IRB.emit(
          `call void @_debug_pretty_list_struct(ptr ${t}, i32 ${depth}, ptr @${printFn})`,
        );

        return;
      }

      this.IRB.declareOneTime(
        "_debug_pretty_list",
        "declare void @_debug_pretty_list(ptr, i32, i32)",
      );

      const type_map = {
        int: 1,
        bool: 2,
        double: 3,
        string: 4,
      };

      const tv = type_map[deepestType];

      this.IRB.emit(
        `call void @_debug_pretty_list(ptr ${t}, i32 ${depth}, i32 ${tv})`,
      );

      return;
    }
  }
}
