export class Type {
  constructor(IRB, expr, infer) {
    this.IRB = IRB;
    this.expr = expr;
    this.infer = infer;
  }

  type(node) {
    const args = node.args;

    if (!args) {
      this.IRB.emitError(
        "SyntaxError",
        `'type()' must be called as a function — did you forget '()'?`,
        node,
      );
    }

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function type() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);

    let type;
    if (expr.llvmType.startsWith("[")) {
      type = `array<${expr.type}>`;
    } else if (expr.isList) {
      type = this.IRB.generateScreenString(expr?.generic);
    } else {
      type = expr.type;
    }

    const str = this.IRB.newGlobalString(type);

    this.IRB.emitExpr(expr);

    this.IRB.cleanupBuiltinStringTemps([expr]);

    return {
      ptr: str.name,
      llvmType: "ptr",
      type: "string",
      isConstant: true,
      local: [],
      global: [],
    };
  }

  Int(node) {
    const args = node.args;

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function Int() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);

    this.IRB.emitExpr(expr);

    if (expr?.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `Int() cannot cast array or Map or List to int`,
        node,
      );
    }
    const cast = this.IRB.castExpression(expr, "int", "Int", node);
    this.IRB.emit(cast?.local.join("\n"));

    this.IRB.cleanupBuiltinStringTemps([expr]);

    return {
      ptr: cast.ptr,
      type: "int",
      llvmType: "i32",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  Long(node) {
    const args = node.args;

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function Long() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);

    this.IRB.emitExpr(expr);

    if (expr?.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `Long() cannot cast array or Map or List to long`,
        node,
      );
    }
    const cast = this.IRB.castExpression(expr, "long", "Long", node);
    this.IRB.emit(cast?.local.join("\n"));

    this.IRB.cleanupBuiltinStringTemps([expr]);

    return {
      ptr: cast.ptr,
      type: "long",
      llvmType: "i64",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  asciiToInt(node) {
    const args = node.args;

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function asciiToInt() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);

    this.IRB.emitExpr(expr);

    if (expr.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `asciiToInt() cannot cast array or Map or List to int`,
        node,
      );
    }
    const cast = this.IRB.castExpression(expr, "int", "asciiToInt", node);

    this.IRB.cleanupBuiltinStringTemps([expr]);

    this.IRB.emit(cast?.local.join("\n"));
    return {
      ptr: cast.ptr,
      type: "int",
      llvmType: "i32",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  Double(node) {
    const args = node.args;

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function Double() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);
    if (expr.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `Double() cannot cast array or Map or List to double`,
        node,
      );
    }
    this.IRB.emitExpr(expr);

    const cast = this.IRB.castExpression(expr, "double", "Double", node);
    this.IRB.emit(cast?.local.join("\n"));

    this.IRB.cleanupBuiltinStringTemps([expr]);

    return {
      ptr: cast.ptr,
      type: "double",
      llvmType: "double",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  Bool(node) {
    const args = node.args;

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function Bool() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);
    if (expr.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `Bool() cannot cast array or Map or List to bool`,
        node,
      );
    }
    this.IRB.emitExpr(expr);

    const cast = this.IRB.castExpression(expr, "bool", "Bool", node);
    this.IRB.emit(cast?.local.join("\n"));

    this.IRB.cleanupBuiltinStringTemps([expr]);

    return {
      ptr: cast.ptr,
      type: "bool",
      llvmType: "i1",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  StringCast(node) {
    const args = node.args;

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function Bool() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);
    if (expr.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `String() cannot cast array or Map or List to string`,
        node,
      );
    }
    this.IRB.emitExpr(expr);

    const cast = this.IRB.castExpression(expr, "string", "String", node);
    this.IRB.emit(cast?.local.join("\n"));

    this.IRB.cleanupBuiltinStringTemps([expr]);

    return {
      ptr: cast.ptr,
      type: "string",
      llvmType: "ptr",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  intToAscii(node) {
    const args = node.args;

    if (args[0].length > 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function intToAscii() accept exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);
    if (expr.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        `intToAscii() cannot cast array or Map or List to string`,
        node,
      );
    }
    this.IRB.emitExpr(expr);

    const cast = this.IRB.castExpression(expr, "string", "intToAscii", node);
    this.IRB.emit(cast?.local.join("\n"));

    this.IRB.cleanupBuiltinStringTemps([expr]);

    return {
      ptr: cast.ptr,
      type: "string",
      llvmType: "ptr",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  sizeOf(node) {
    if (node.args.length !== 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function sizeOf() accepts exactly 1 argument",
        node,
      );
    }

    const type = this.infer.infer(node.args[0]);
    const size = this.IRB.sizeOf(type);

    return {
      ptr: `${size}`,
      type: "int",
      llvmType: "i32",
      local: [],
      global: [],
      isConstant: true,
      needsLoad: false,
    };
  }

  Byte(node) {
    const args = node.args;

    if (args.length !== 1) {
      this.IRB.emitError(
        "ArgumentError",
        "Function Byte() accepts exactly 1 argument",
        node,
      );
    }

    const expr = this.expr.handleExpression(args[0]);

    if (expr.llvmType.startsWith("[") || expr?.isList || expr?.isStruct) {
      this.IRB.emitError(
        "TypeError",
        "Byte() cannot cast array, Map, List or struct to byte",
        node,
      );
    }

    this.IRB.emitExpr(expr);

    const cast = this.IRB.castExpression(expr, "byte", "Byte", node);

    this.IRB.emit(cast?.local.join("\n"));

    return {
      ptr: cast.ptr,
      type: "byte",
      llvmType: "i8",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false,
    };
  }

  strToBytes(node) {
  const args = node.args;

  if (!args || args.length !== 1) {
    this.IRB.emitError(
      "ArgumentError",
      "Function stringToBytes() accepts exactly 1 argument",
      node,
    );
  }

  const expr = this.expr.handleExpression(args[0]);

  if (expr.type !== "string" || expr.isList || expr.isStruct) {
    this.IRB.emitError("TypeError", "stringToBytes() expects a string", node);
  }

  this.IRB.emitExpr(expr);

  const callArgs = expr.needsLoad
    ? (() => {
        const tmp = this.IRB.newTemp();
        this.IRB.emit(`${tmp} = load ptr, ptr ${expr.ptr}`);
        return `ptr ${tmp}`;
      })()
    : `ptr ${expr.ptr}`;

  this.IRB.declareOneTime(
    "_zen_strToBytes",
    "declare ptr @_zen_strToBytes(ptr)",
  );

  const result = this.IRB.newTemp();

  this.IRB.emit(`${result} = call ptr @_zen_strToBytes(${callArgs})`);

  this.IRB.cleanupBuiltinStringTemps([expr]);

  return {
    ptr: result,
    type: "byte",
    llvmType: "ptr",
    isList: true,
    internalType: "List",
    retGeneric: "byte",
    generic: { type: "List", generic: { type: "byte" } },
    local: [],
    global: [],
    postOrPrefix: false,
  };
}

bytesToStr(node) {
  const args = node.args;

  if (!args || args.length !== 1) {
    this.IRB.emitError(
      "ArgumentError",
      "Function bytesToString() accepts exactly 1 argument",
      node,
    );
  }

  const expr = this.expr.handleExpression(args[0]);

  const elem = expr.generic?.generic;
  const elemType = typeof elem === "string" ? elem : elem?.type;

  if (!expr.isList || elemType !== "byte") {
    this.IRB.emitError(
      "TypeError",
      "bytesToString() expects List<byte>",
      node,
    );
  }

  this.IRB.emitExpr(expr);

  const callArgs = expr.needsLoad
    ? (() => {
        const tmp = this.IRB.newTemp();
        this.IRB.emit(`${tmp} = load ptr, ptr ${expr.ptr}`);
        return `ptr ${tmp}`;
      })()
    : `ptr ${expr.ptr}`;

  this.IRB.declareOneTime(
    "_zen_bytesToStr",
    "declare ptr @_zen_bytesToStr(ptr)",
  );

  const result = this.IRB.newTemp();

  this.IRB.emit(`${result} = call ptr @_zen_bytesToStr(${callArgs})`);

  this.IRB.cleanupBuiltinStringTemps([expr]);

  return {
    ptr: result,
    type: "string",
    llvmType: "ptr",
    isConstant: false,
    local: [],
    global: [],
    postOrPrefix: false,
  };
}
}
