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
    const args = node.args;

    // mark in used namespace

    this.IRB.usedNameSpaces.add("crypto");

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

    const exprs = args.map((arg) =>
      this.expr.handleExpression(arg),
    );

    // ARGUMENT VALIDATION

    exprs.forEach((expr, i) => {
      const expectedType = params[i];

      const expectedIsList = expectedType.startsWith("List<");

      const expectedElementType = expectedIsList
        ? expectedType.slice(5, -1)
        : null;

      const actualIsList = expr?.isList === true;
      const actualType = expr.type;

      const displayType = actualIsList
        ? `List<${actualType}>`
        : actualType;

      let valid;

      if (expectedIsList) {
        valid =
          actualIsList &&
          actualType === expectedElementType;
      } else {
        valid =
          !actualIsList &&
          actualType === expectedType;
      }

      if (!valid) {
        this.IRB.emitError(
          "TypeError",
          `Function ${name} expects ${expectedType} at arg ${
            i + 1
          }, got ${displayType}`,
          node.args[i],
        );
      }
    });

    // EMIT EXPRESSION LOCALS / GLOBALS

    exprs.forEach((e) => {
      if (e.local?.length) {
        this.IRB.emit(e.local.join("\n"));
      }

      if (e.global?.length) {
        this.IRB.emit(e.global.join("\n"));
      }
    });

    // ARGUMENT LLVM TYPES

    const getArgType = (type) => {
      if (type.startsWith("List<")) {
        return "ptr";
      }

      switch (type) {
        case "int":
          return "i32";

        case "long":
          return "i64";

        case "double":
          return "double";

        case "bool":
          return "i1";

        case "byte":
          return "i8";

        case "string":
          return "ptr";

        case "List":
          return "ptr";

        case "Map":
          return "ptr";

        default:
          this.IRB.emitError(
            "TypeError",
            `Unsupported arg type: ${type}`,
            node,
          );
      }
    };

    // BUILD CALL ARGUMENTS

    const callArgs = [];
    const declarationArgs = [];

    exprs.forEach((expr, i) => {
      const expectedType = params[i];

      const llvmType = getArgType(expectedType);

      let value = expr.ptr;

      if (expr.needsLoad) {
        const tmp = this.IRB.newTemp();

        this.IRB.emit(
          `${tmp} = load ptr, ptr ${expr.ptr}`,
        );

        value = tmp;
      }

      callArgs.push(`${llvmType} ${value}`);
      declarationArgs.push(llvmType);
    });

    const isList = returnType.startsWith("List<");

    const type = isList
      ? returnType.slice(5, -1)
      : returnType;

    const baseReturnType = isList
      ? "List"
      : returnType;

    const llvmRet = this.IRB.getLLVMType(
      baseReturnType,
    );


    this.IRB.declareOneTime(
      funcName,
      `declare ${llvmRet} @${funcName}(${declarationArgs.join(", ")})`,
    );

    // FUNCTION CALL

    let t = null;

    if (llvmRet === "void") {
      this.IRB.emit(
        `call ${llvmRet} @${funcName}(${callArgs.join(", ")})`,
      );
    } else {
      t = this.IRB.newTemp();

      this.IRB.emit(
        `${t} = call ${llvmRet} @${funcName}(${callArgs.join(", ")})`,
      );
    }

    this.IRB.cleanupBuiltinStringTemps(exprs);

    // RESULT

    return {
      ptr: t,
      type,
      isList,
      llvmType: llvmRet,
      local: [],
      global: [],
      postOrPrefix: false,
    };
  }
}