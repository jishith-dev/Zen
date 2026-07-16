import { FORMAT_MAP } from "../../../../config/config.js";

export class IO {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }

  screen(node) {
    const args = node.args;

    if (!args) {
      this.IRB.emitError(
        "SyntaxError",
        "'screen()' must be called as a function",
        node,
      );
    }

    this.IRB.declareOneTime("printf", "declare i32 @printf(ptr, ...)");
    this.IRB.declareOneTime("fflush", "declare i32 @fflush(ptr)");

    if (args.length > 2) {
      this.IRB.emitError(
        "ArgumentError",
        "screen() takes at most 2 arguments",
        node,
      );
    }

    let format = null;
    let arg = args[0];

    // format override
    if (args.length === 2) {
      if (args[1].type !== "string") {
        this.IRB.emitError(
          "ArgumentError",
          "screen() second parameter must be string",
          node,
        );
      }

      format = args[1].value;
    }

    let expr = null;
    let type = null;
    let valuePtr = null;

    // function special case
    const isFunction =
      arg?.type === "variable" && this.IRB.functions.has(arg.name);

    if (isFunction) {
      expr = null;
      type = "string";
      valuePtr = this.IRB.newGlobalString(`Function<${arg.name}>`).name;
    } else {
      arg.line = node?.line;
      arg.column = node?.column;

      expr = this.expr.handleExpression(arg, false);
      this.IRB.emitExpr(expr);

      type = expr.type;
      valuePtr = expr.ptr;
    }

    // derived types (safe guards)
    if (expr) {
      if (expr.isMap) {
        valuePtr = this.IRB.newGlobalString("Map").name;
        type = "string";
      }

      if (expr.isArray) {
        valuePtr = this.IRB.newGlobalString("<array>").name;
        type = "string";
      }

      if (expr.isStruct) {
        valuePtr = this.IRB.newGlobalString(`struct<${expr.type}>`).name;
        type = "string";
      }

      if (expr.isList && typeof expr.generic === "object") {
        valuePtr = this.IRB.newGlobalString(
          this.IRB.generateScreenString(expr.generic),
        ).name;
        type = "string";
      }
    }

    switch (type) {
      case "int":
        this.IRB.emitScreenInt(valuePtr, format || "%d\n");
        break;

      case "double":
        this.IRB.emitScreenDouble(valuePtr, format || "%lf\n");
        break;

      case "bool":
        if (format !== null) {
          this.IRB.emitError(
            "ArgumentError",
            "screen() format string is not supported for bool",
            node,
          );
        }
        this.IRB.emitScreenBool(valuePtr);
        break;

      case "string":
        let strFormat = format || "%s\n";
        if (!strFormat.includes("%s")) {
          strFormat = strFormat + "%s";
        }
        this.IRB.emitScreenString(valuePtr, strFormat);
        break;

      default:
        this.IRB.emitError(
          "TypeError",
          `screen() unsupported type: ${type}`,
          node,
        );
    }
  }

  input(node, globalScope) {
    this.IRB.declareOneTime("sys_input", "declare ptr @_sys_input(ptr)");

    const args = node?.value?.args || node?.args;

    const ptr = this.IRB.newTemp();

    let promptPtr = "null";

    if (args.length !== 0) {
      if (args.length > 1) {
        this.IRB.emitError(
          "ArgumentError",
          `input() expects 0 or 1 argument, but got ${args.length}`,
          node,
        );
      }

      const expr = this.expr.handleExpression(args[0]);
      const displayType = expr?.isList ? "List" : expr.type;

      if (expr.type !== "string" && expr.isList) {
        this.IRB.emitError(
          "TypeError",
          `input() prompt must be string, got ${displayType}`,
          args[0],
        );
      }
      this.IRB.emitExpr(expr);

      promptPtr = expr.ptr;
    }

    this.IRB.emit(`${ptr} = call ptr @_sys_input(ptr ${promptPtr})`);

    return {
      ptr,
      type: "string",
      llvmType: "ptr",
      needsLoad: false,
      local: [],
      global: [],
    };
  }
}
