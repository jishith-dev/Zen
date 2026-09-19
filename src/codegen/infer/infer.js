import {
  NAMESPACE_REG,
  BUILTIN_MAP,
  STD_FUNCTIONS,
  STD_FUNCTIONS_SCHEMA,
  ZEN_TYPES_MAP,
  LOOKUP,
} from "../../config/config.js";

export class InferType {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;

    this.numericTypes = ["byte", "int", "long", "double"];

    this.inferableTypes = new Set([
      "string",
      "double",
      "bool",
      "long",
      "byte",
      "int",
    ]);
  }

  infer(node, context = "normal") {
    if (!node) {
      this.IRB.emitError("InternalError", "Invalid AST node", node);
    }

    switch (node.type) {
      case "int":
        return this.setInferredType(node, "int", context);

      case "double":
        return this.setInferredType(node, "double", context);

      case "bool":
        return this.setInferredType(node, "bool", context);

      case "string":
        return this.setInferredType(node, "string", context);

      case "byte":
        return this.setInferredType(node, "byte", context);

      case "long":
        return this.setInferredType(node, "long", context);

      case "variable": {
        const data = this.IRB.getVar(node.name, node);

        if (!data || !data.type) {
          this.IRB.emitError(
            "ReferenceError",
            `Undefined variable '${node.name}'`,
            node,
          );
        }

        const type = this.extractVariableType(data);

        if (context === "fnret" || context === "auto") {
          this.ensureInferable(type, data, node);
        }

        node.inferredType = type;
        return type;
      }

      case "FUNCTION_DECLARATION": {
        const returnStmt = node.body.body.find(
          (stmt) => stmt.type === "RETURN",
        );

        if (!returnStmt) {
          node.returnType = {
            type: "void",
            dimensions: [],
          };

          return {
            type: "void",
          };
        }

        if (node.returnType.type === "auto") {
          const inferred = this.infer(returnStmt.value, "fnret");

          node.returnType = {
            type: inferred,
            dimensions: [],
          };

          return {
            type: inferred,
          };
        }

        return {
          type: node.returnType.type,
        };
      }

      case "ARRAY_ACCESS": {
        const data = this.IRB.getVar(node.array.name, node);

        if (!data || !data.type) {
          this.IRB.emitError(
            "ReferenceError",
            `Undefined variable '${node.array.name}'`,
            node,
          );
        }

        const type = this.extractVariableType(data);

        if (context === "fnret" || context === "auto") {
          this.ensureInferable(type, data, node);
        }

        node.inferredType = type;
        return type;
      }

      case "MEMBER_ACCESS":
        return this.inferMemberAccess(node, context);

      case "CALL": {
        if (node.callee && node.callee.type === "MEMBER_ACCESS") {
          const member = node.callee;

          const { base, fields } = this.IRB.resolveMemberChain(member);

          if (base && base.type === "variable") {
            const namespace = this.IRB.getVar(base.name, member);

            if (namespace && namespace.type === "namespace") {
              const entry = this.resolveNamespaceFunction(
                namespace,
                fields,
                member,
              );

              const returnType = this.normalizeReturnType(entry[1]);

              this.checkFnRetType(returnType, context, node);

              node.inferredType = returnType;

              return returnType;
            }
          }

          const objectType = this.infer(member.object);

          const methodName = member.field;

          const fullMethodName = `${objectType}_${methodName}`;

          const fn = this.IRB.getFunction(fullMethodName);

          if (!fn) {
            this.IRB.emitError(
              "ReferenceError",
              `Unknown method '${methodName}' for type '${objectType}'`,
              node,
            );
          }

          const returnType = this.normalizeReturnType(fn.returnType);

          this.checkFnRetType(returnType, context, node);

          node.inferredType = returnType;

          return returnType;
        }

        if (node.name) {
          let fn;

          if (STD_FUNCTIONS.includes(node.name)) {
            const schema = STD_FUNCTIONS_SCHEMA[node.name];

            if (!schema) {
              this.IRB.emitError(
                "InternalError",
                `Missing schema for standard function '${node.name}'`,
                node,
              );
            }

            fn = {
              returnType: ZEN_TYPES_MAP[schema.ret],
            };
          } else if (BUILTIN_MAP[node.name]) {
            fn = BUILTIN_MAP[node.name];
          } else {
            fn = this.IRB.resolveFunction(node.name);
          }

          if (!fn) {
            this.IRB.emitError(
              "ReferenceError",
              `Unknown function '${node.name}'`,
              node,
            );
          }

          const returnType = this.normalizeReturnType(fn.returnType);

          this.checkFnRetType(returnType, context, node);

          node.inferredType = returnType;

          return returnType;
        }

        this.IRB.emitError(
          "InferError",
          "Cannot determine function being called",
          node,
        );
      }

      case "ARRAY": {
        if (!node.elements || node.elements.length === 0) {
          this.IRB.emitError(
            "TypeError",
            "cannot infer 'auto' return type for empty List literal. specify an explicit return type",
            node,
          );
        }

        const firstType = this.infer(node.elements[0]);

        for (const element of node.elements) {
          const currentType = this.infer(element);

          if (currentType !== firstType) {
            this.IRB.emitError(
              "TypeError",
              `Array element type mismatch — expected '${firstType}', got '${currentType}'`,
              node,
            );
          }
        }

        if (context === "fnret" || context === "auto") {
          this.IRB.emitError(
            "TypeError",
            "cannot infer 'auto' type for 'List<T>'. specify an explicit type",
            node,
          );
        }

        node.inferredType = firstType;
        return firstType;
      }

      case "STRUCT_LITERAL":
        this.IRB.emitError(
          "TypeError",
          "cannot infer 'auto' type from a struct literal. specify an explicit type",
          node,
        );

      case "BINARY_EXPRESSION": {
        const leftType = this.infer(node.left);

        const rightType = this.infer(node.right);

        const op = node.operator;

        if (["+", "-", "*", "/", "%"].includes(op)) {
          if (leftType === "string" || rightType === "string") {
            node.inferredType = "string";
            return "string";
          }

          const lType = leftType === "bool" ? "int" : leftType;

          const rType = rightType === "bool" ? "int" : rightType;

          if (
            !this.numericTypes.includes(lType) ||
            !this.numericTypes.includes(rType)
          ) {
            this.IRB.emitError(
              "TypeError",
              `Cannot apply '${op}' to '${leftType}' and '${rightType}'`,
              node,
            );
          }

          const result = LOOKUP[lType] >= LOOKUP[rType] ? lType : rType;

          node.inferredType = result;
          return result;
        }

        if (["&", "|", "^", "<<", ">>"].includes(op)) {
          let lType = leftType;
          let rType = rightType;

          if (lType === "bool" || lType === "byte") {
            lType = "int";
          }

          if (rType === "bool" || rType === "byte") {
            rType = "int";
          }

          if (
            !["int", "long"].includes(lType) ||
            !["int", "long"].includes(rType)
          ) {
            this.IRB.emitError(
              "TypeError",
              `Cannot apply bitwise operator '${op}' to '${leftType}' and '${rightType}'`,
              node,
            );
          }

          const result = LOOKUP[lType] >= LOOKUP[rType] ? lType : rType;

          node.inferredType = result;
          return result;
        }

        if (["==", "!=", ">", "<", ">=", "<="].includes(op)) {
          node.inferredType = "bool";
          return "bool";
        }

        if (["&&", "||"].includes(op)) {
          const valid = (type) =>
            type === "bool" ||
            type === "byte" ||
            type === "int" ||
            type === "long" ||
            type === "double";

          if (!valid(leftType)) {
            this.IRB.emitError(
              "TypeError",
              `Logical operator '${op}' cannot be applied to '${leftType}'`,
              node,
            );
          }

          if (!valid(rightType)) {
            this.IRB.emitError(
              "TypeError",
              `Logical operator '${op}' cannot be applied to '${rightType}'`,
              node,
            );
          }

          node.inferredType = "bool";
          return "bool";
        }

        this.IRB.emitError("SyntaxError", `Unknown operator '${op}'`, node);
      }

      case "UNARY_EXPRESSION": {
        const valueType = this.infer(node.argument);

        if (node.operator === "!") {
          node.inferredType = "bool";
          return "bool";
        }

        if (node.operator === "+" || node.operator === "-") {
          this.ensureNumeric(valueType, node.operator, node);

          const result = valueType === "byte" ? "int" : valueType;

          node.inferredType = result;
          return result;
        }

        if (node.operator === "~") {
          if (!["byte", "int", "long"].includes(valueType)) {
            this.IRB.emitError(
              "TypeError",
              `Bitwise NOT '~' requires integer types. Got '${valueType}'`,
              node,
            );
          }

          const result = valueType === "byte" ? "int" : valueType;

          node.inferredType = result;
          return result;
        }

        if (node.operator === "++" || node.operator === "--") {
          this.ensureNumeric(valueType, node.operator, node);

          node.inferredType = valueType;
          return valueType;
        }

        this.IRB.emitError(
          "SyntaxError",
          `Unknown unary operator '${node.operator}'`,
          node,
        );
      }

      case "TERNARY": {
        const conditionType = this.infer(node.condition);

        if (conditionType !== "bool") {
          this.IRB.emitError(
            "TypeError",
            "Ternary condition must be bool",
            node,
          );
        }

        const leftType = this.infer(node.trueExpr);

        const rightType = this.infer(node.falseExpr);

        if (leftType !== rightType) {
          this.IRB.emitError(
            "TypeError",
            `Ternary type mismatch '${leftType}' != '${rightType}'`,
            node,
          );
        }

        node.inferredType = leftType;
        return leftType;
      }

      case "VARIABLE_DECLARATION": {
        let finalType;

        if (node.dataType === "auto") {
          finalType = this.infer(node.value, "auto");
        } else {
          finalType = node.dataType;

          const valueType = this.infer(node.value);

          if (valueType !== finalType) {
            this.IRB.emitError(
              "TypeError",
              `Cannot assign '${valueType}' to '${finalType}'`,
              node,
            );
          }
        }

        node.inferredType = finalType;
        return finalType;
      }

      default:
        this.IRB.emitError(
          "InferError",
          `Cannot infer node type '${node.type}'`,
          node,
        );
    }
  }

  inferMemberAccess(node, context) {
    const { base, fields } = this.IRB.resolveMemberChain(node);

    if (!base) {
      this.IRB.emitError("ReferenceError", "Cannot resolve member base", node);
    }

    if (base.type === "variable") {
      const namespace = this.IRB.getVar(base.name, node);

      if (namespace && namespace.type === "namespace") {
        const entry = this.resolveNamespaceFunction(namespace, fields, node);

        const returnType = this.normalizeReturnType(entry[1]);

        this.checkFnRetType(returnType, context, node);

        node.inferredType = returnType;
        return returnType;
      }
    }

    const objectType = this.infer(node.object);

    const methodName = node.field;

    const fullMethodName = `${objectType}_${methodName}`;

    const fn = this.IRB.getFunction(fullMethodName);

    if (!fn) {
      this.IRB.emitError(
        "ReferenceError",
        `Unknown member '${methodName}' for type '${objectType}'`,
        node,
      );
    }

    const returnType = this.normalizeReturnType(fn.returnType);

    this.checkFnRetType(returnType, context, node);

    node.inferredType = returnType;

    return returnType;
  }

  resolveNamespaceFunction(namespace, fields, node) {
    const namespaceName = namespace.name;

    const map = namespace.members || NAMESPACE_REG[namespaceName];

    if (!map) {
      this.IRB.emitError(
        "InternalError",
        `Namespace '${namespaceName}' has no member registry`,
        node,
      );
    }

    const functionName = fields.join("_");

    const entry = this.findNamespaceFunction(map, functionName);

    if (!entry) {
      this.IRB.emitError(
        "ReferenceError",
        `Unknown function '${namespaceName}.${functionName}'`,
        node,
      );
    }

    return entry;
  }

  findNamespaceFunction(map, name) {
    if (!map) {
      return null;
    }

    for (const key of Object.keys(map)) {
      const entry = map[key];

      if (!entry) {
        continue;
      }

      const generatedName = entry[0];

      if (
        key === name ||
        generatedName === name ||
        generatedName === `_${name}` ||
        generatedName.endsWith(`_${name}`)
      ) {
        return entry;
      }
    }

    return null;
  }

  extractVariableType(data) {
    if (!data) {
      return null;
    }

    return data.type;
  }

  ensureInferable(type, data, node) {
    if (this.inferableTypes.has(type)) {
      return;
    }

    if (
      data?.isList ||
      data?.generic?.generic?.type === "List" ||
      type === "List"
    ) {
      this.IRB.emitError(
        "TypeError",
        "cannot infer 'auto' type for 'List<T>'. specify an explicit type",
        node,
      );
    }

    if (data?.isStruct || this.IRB.hasStruct(type)) {
      this.IRB.emitError(
        "TypeError",
        "cannot infer 'auto' type for 'struct'. specify an explicit type",
        node,
      );
    }

    if (
      data?.isArray ||
      data?.array ||
      data?.isFixedArray ||
      data?.fixedArray ||
      data?.dimensions?.length > 0
    ) {
      this.IRB.emitError(
        "TypeError",
        "cannot infer 'auto' type for fixed-size arrays. specify an explicit type",
        node,
      );
    }

    this.IRB.emitError(
      "TypeError",
      `cannot infer 'auto' type '${type}'. specify an explicit type`,
      node,
    );
  }

  normalizeReturnType(type) {
    if (!type) {
      return "void";
    }

    if (ZEN_TYPES_MAP[type]) {
      return ZEN_TYPES_MAP[type];
    }

    return type;
  }

  checkFnRetType(type, context, node) {
    if (context !== "fnret" && context !== "auto") {
      return;
    }

    if (this.inferableTypes.has(type)) {
      return;
    }

    if (type === "List") {
      this.IRB.emitError(
        "TypeError",
        "cannot infer 'auto' type for 'List<T>'. specify an explicit type",
        node,
      );
    }

    if (this.IRB.hasStruct(type)) {
      this.IRB.emitError(
        "TypeError",
        "cannot infer 'auto' type for 'struct'. specify an explicit type",
        node,
      );
    }

    this.IRB.emitError(
      "TypeError",
      `cannot infer 'auto' type '${type}'. specify an explicit type`,
      node,
    );
  }

  setInferredType(node, type, context) {
    if (context === "fnret" || context === "auto") {
      this.ensureInferable(type, null, node);
    }

    node.inferredType = type;
    return type;
  }

  ensureNumeric(type, op, node) {
    if (!this.numericTypes.includes(type)) {
      this.IRB.emitError(
        "TypeError",
        `Operator '${op}' requires numeric types. Got '${type}'`,
        node,
      );
    }

    return type;
  }
}
