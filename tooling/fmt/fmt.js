import { ParserTypes } from "../../src/config/config.js";

export class Fmt {
  constructor(ast) {
    this.ast = ast;
    this.output = "";
    this.indentLevel = 0;
    this.indentSize = 4;
  }

  format() {
    this.visitTopLevel(this.ast);
    return this.output.trimEnd() + "\n";
  }

  visitTopLevel(list) {
    let first = true;
    for (const stmt of list) {
      if (!stmt) continue;
      if (!first) {
        this.newline();
        this.newline();
      }
      first = false;
      this.visit(stmt);
    }
  }

  write(text) {
    this.output += text;
  }

  space() {
    this.output += " ";
  }

  newline() {
    this.output += "\n";
    this.output += " ".repeat(this.indentLevel * this.indentSize);
  }

  indent() {
    this.indentLevel++;
  }

  dedent() {
    this.indentLevel--;
  }

  capture(fn) {
    const saved = this.output;
    this.output = "";
    fn();
    const result = this.output;
    this.output = saved;
    return result;
  }

  visitStatements(list) {
    let first = true;
    let prevBlockLike = false;
    for (const stmt of list) {
      if (!stmt) continue;
      const blockLike = this.isBlockLike(stmt);
      if (!first) {
        this.newline();
        if (blockLike || prevBlockLike) this.newline();
      }
      first = false;
      prevBlockLike = blockLike;
      this.visit(stmt);
    }
  }

  isBlockLike(node) {
    if (!node) return false;
    switch (node.type) {
      case ParserTypes.CONDITIONAL:
      case ParserTypes.LOOP:
      case ParserTypes.LOOP_OF:
      case ParserTypes.WHILE:
      case ParserTypes.DO_WHILE:
      case ParserTypes.SWITCH:
      case ParserTypes.BLOCK:
        return true;
      default:
        return false;
    }
  }

  quoteString(value) {
    const escaped = String(value)
      .replace(/\\/g, "\\\\")
      .replace(/"/g, '\\"')
      .replace(/\n/g, "\\n")
      .replace(/\t/g, "\\t");
    return `"${escaped}"`;
  }

  formatType(t) {
    if (!t) return "";

    if (t.type === "List") {
      return `List<${this.formatType(t.generic)}>`;
    }

    if (t.type === "Map") {
      return "Map";
    }

    if (t.type === "Function") {
      const params = (t.params || [])
        .map((p) => this.formatType(p.type) + (p.isRest ? "..." : ""))
        .join(", ");
      const ret =
        t.returnType && t.returnType.type !== "void"
          ? this.formatType(t.returnType)
          : "void";
      return `fn ${t.name || ""}(${params}) ${ret}`;
    }

    let out = t.type;
    for (const dim of t.dimensions || []) {
      out += "[";
      if (dim != null) out += this.capture(() => this.visit(dim));
      out += "]";
    }
    return out;
  }

  formatParam(p) {
    let s =
      p.type && p.type.type === "Function"
        ? this.formatType(p.type)
        : this.formatType(p.type) + " " + p.name;
    if (p.isRest) s += "...";
    if (p.default) s += " = " + this.capture(() => this.visit(p.default));
    return s;
  }

  visit(node) {
    if (!node) return;

    if (Array.isArray(node)) {
      this.visitStatements(node);
      return;
    }

    switch (node.type) {
      // statements
      case ParserTypes.VARIABLE_DECLARATION:
        this.visitVariable(node);
        break;

      case ParserTypes.VARIABLE_REFERENCE:
        this.visit(node.expression);
        break;

      case ParserTypes.COMMENT:
        this.write(node.value.trimEnd());
        break;

      case ParserTypes.CONDITIONAL:
        this.visitConditional(node);
        break;

      case ParserTypes.LOOP:
        this.visitLoop(node);
        break;

      case ParserTypes.LOOP_OF:
        this.visitLoopOf(node);
        break;

      case ParserTypes.STRUCT:
        this.visitStruct(node);
        break;

      case ParserTypes.WHILE:
        this.visitWhileLoop(node);
        break;

      case ParserTypes.DO_WHILE:
        this.visitDoWhileLoop(node);
        break;

      case ParserTypes.SWITCH:
        this.visitSwitch(node);
        break;

      case ParserTypes.IMPORT:
        this.visitImport(node);
        break;

      case ParserTypes.EXPORT:
        this.visitExport(node);
        break;

      case ParserTypes.RETURN:
        this.visitReturn(node);
        break;

      case ParserTypes.ENUM:
        this.visitEnum(node);
        break;

      case ParserTypes.MAP_DECLARATION:
        this.visitMap(node);
        break;

      case ParserTypes.MAP_LITERAL:
        this.visitMapLiteral(node);
        break;

      case ParserTypes.MAP_PROPERTY:
        this.visitMapProperty(node);
        break;

      case ParserTypes.BREAK:
        this.write("break");
        break;

      case ParserTypes.CONTINUE:
        this.write("continue");
        break;

      case ParserTypes.FUNCTION_DECLARATION:
        this.visitFunction(node);
        break;

      case ParserTypes.BLOCK:
        this.visitBlock(node);
        break;

      case ParserTypes.CALL:
        this.visitCall(node);
        break;

      // literals
      case ParserTypes.INT:
      case ParserTypes.DOUBLE:
        this.write(String(node.value));
        break;

      case ParserTypes.STRING:
        this.write(this.quoteString(node.value));
        break;

      case ParserTypes.BOOLEAN:
        this.write(node.value ? "true" : "false");
        break;

      case "TEMPLATE_LITERAL":
        this.visitTemplateLiteral(node);
        break;

      case "THIS":
        this.write("this");
        break;

      // expressions
      case ParserTypes.BINARY_EXPRESSION:
        this.visitBinary(node);
        break;

      case ParserTypes.UNARY_EXPRESSION:
        this.visitUnary(node);
        break;

      case ParserTypes.VARIABLE:
        this.write(node.name);
        break;

      case ParserTypes.MEMBER_ACCESS:
        this.visitMemberAccess(node);
        break;

      case ParserTypes.ARRAY_ACCESS:
        this.visitArrayAccess(node);
        break;

      case ParserTypes.ARRAY:
        this.visitArray(node);
        break;

      case ParserTypes.TERNARY:
        this.visitTernary(node);
        break;

      case ParserTypes.ASSIGNMENT:
        this.visitAssignment(node);
        break;

      case ParserTypes.MEMBER_ASSIGNMENT:
        this.visitMemberAssignment(node);
        break;

      default:
        throw new Error(
          `Fmt: unhandled node type "${node.type}" (keys: ${Object.keys(node).join(", ")})`,
        );
    }
  }

  visitVariable(node) {
    if (node.isConstant) this.write("const");
    // `StructName instance = value` (IDENTIFIER IDENTIFIER declaration)
    if (node.struct_ref) {
      this.write(node.struct_ref);
      this.space();
      this.write(node.name);
      if (node.value) {
        this.write(" = ");
        this.visit(node.value);
      }
      return;
    }

    if (node.isReactive) this.write("reactive ");

    // `List<T> name = value`
    if (node.isList) {
      this.write(this.formatType(node.generic));
    } else {
      this.write(node.dataType);
    }

    this.space();
    this.write(node.name);

    if (!node.isList) {
      for (const dim of node.dimensions || []) {
        this.write("[");
        if (dim != null) this.visit(dim);
        this.write("]");
      }
    }

    if (node.value) {
      this.write(" = ");
      this.visit(node.value);
    }
  }

  visitConditional(node) {
    this.write("if (");
    this.visit(node.if.condition);
    this.write(") ");
    this.visit(node.if.body);

    for (const ei of node.elseIf || []) {
      this.write(" else if (");
      this.visit(ei.condition);
      this.write(") ");
      this.visit(ei.body);
    }

    if (node.else) {
      this.write(" else ");
      this.visit(node.else.body);
    }
  }

  visitLoop(node) {
    const clauses = [];
    if (node.init) clauses.push(this.capture(() => this.visit(node.init)));
    clauses.push(this.capture(() => this.visit(node.condition)));
    clauses.push(this.capture(() => this.visit(node.update)));

    this.write("loop (");
    this.write(clauses.join(", "));
    this.write(") ");
    this.visit(node.body);
  }

  visitLoopOf(node) {
    this.write("loop (");
    this.write(node.varName);
    this.write(" of ");
    this.visit(node.iterable);
    this.write(") ");
    this.visit(node.body);
  }

  visitWhileLoop(node) {
    this.write("while (");
    this.visit(node.condition);
    this.write(") ");
    this.visit(node.body);
  }

  visitDoWhileLoop(node) {
    this.write("do ");
    this.visit(node.body);
    this.write(" while (");
    this.visit(node.condition);
    this.write(")");
  }

  visitSwitch(node) {
    this.write("switch (");
    this.visit(node.discriminant);
    this.write(") {");
    this.indent();

    for (const c of node.cases) {
      this.newline();
      this.write("case ");
      this.visit(c.value);
      this.write(":");
      if (c.statements.length) {
        this.indent();
        this.newline();
        this.visitStatements(c.statements);
        this.dedent();
      }
    }

    if (node.defaultCase) {
      this.newline();
      this.write("default:");
      if (node.defaultCase.statements.length) {
        this.indent();
        this.newline();
        this.visitStatements(node.defaultCase.statements);
        this.dedent();
      }
    }

    this.dedent();
    this.newline();
    this.write("}");
  }

  visitImport(node) {
    this.write("import (");
    this.write(node.names.join(", "));
    this.write(") from ");
    this.write(this.quoteString(node.source));
  }

  visitExport(node) {
    this.write("export (");
    this.write(node.names.join(", "));
    this.write(")");
  }

  visitReturn(node) {
    this.write("return");
    const empty = Array.isArray(node.value) && node.value.length === 0;
    if (node.value && !empty) {
      this.space();
      this.visit(node.value);
    }
  }

  visitEnum(node) {
    this.write("enum ");
    this.write(node.name);
    this.space();

    if (!node.members.length) {
      this.write("{}");
      return;
    }

    this.write("{");
    this.indent();

    for (let i = 0; i < node.members.length; i++) {
      const m = node.members[i];
      this.newline();
      this.write(m.name);
      if (m.value) {
        this.write(" = ");
        this.visit(m.value);
      }
      if (i < node.members.length - 1) this.write(",");
    }

    this.dedent();
    this.newline();
    this.write("}");
  }

  visitMap(node) {
    this.write("Map ");
    this.write(node.name);
    this.write(" = ");
    this.visit(node.value);
  }

  visitMapLiteral(node) {
    if (!node.properties.length) {
      this.write("{}");
      return;
    }

    this.write("{");
    this.indent();

    for (let i = 0; i < node.properties.length; i++) {
      this.newline();
      this.visitMapProperty(node.properties[i]);
      if (i < node.properties.length - 1) this.write(",");
    }

    this.dedent();
    this.newline();
    this.write("}");
  }

  visitMapProperty(node) {
    this.write(node.key);
    if (node.index) {
      this.write("[");
      this.visit(node.index);
      this.write("]");
    }
    this.write(": ");
    this.visit(node.value);
  }

  visitFunction(node) {
    if (node.isAsync) this.write("async ");
    if (node.isThread) this.write("thread ");
    if (node.isExtern) this.write("extern ");
    if (!node.isMethod) this.write("fn ");

    this.write(node.name);
    this.write("(");
    this.write((node.params || []).map((p) => this.formatParam(p)).join(", "));
    this.write(")");
    this.space();
    this.write(this.formatType(node.returnType));

    if (node.body) {
      this.space();
      this.visit(node.body);
    }
  }

  visitStruct(node) {
    this.write("struct ");
    this.write(node.name);
    this.space();

    if (!node.fields.length && !node.methods.length) {
      this.write("{}");
      return;
    }

    this.write("{");
    this.indent();

    for (const field of node.fields) {
      this.newline();
      this.write(this.formatType(field));
      this.space();
      this.write(field.name);
    }

    for (const method of node.methods) {
      this.newline();
      this.visit(method);
    }

    this.dedent();
    this.newline();
    this.write("}");
  }

  visitBlock(node) {
    const body = node.body || [];

    if (!body.length) {
      this.write("{}");
      return;
    }

    this.write("{");
    this.indent();
    this.newline();
    this.visitStatements(body);
    this.dedent();
    this.newline();
    this.write("}");
  }

  static BINARY_PRECEDENCE = {
    "||": 1,
    "&&": 1,
    "==": 2,
    "!=": 2,
    "<": 3,
    ">": 3,
    "<=": 3,
    ">=": 3,
    "&": 4,
    "|": 4,
    "^": 4,
    "<<": 4,
    ">>": 4,
    "+": 5,
    "-": 5,
    "*": 6,
    "/": 6,
    "%": 6,
  };

  nodePrecedence(node) {
    if (!node) return Infinity;
    switch (node.type) {
      case ParserTypes.ASSIGNMENT:
      case ParserTypes.MEMBER_ASSIGNMENT:
        return -1;
      case ParserTypes.TERNARY:
        return 0;
      case ParserTypes.BINARY_EXPRESSION:
        return Fmt.BINARY_PRECEDENCE[node.operator] ?? 4;
      case ParserTypes.UNARY_EXPRESSION:
        return 7;
      default:
        return Infinity;
    }
  }

  writeOperand(node, minPrecedence, strict) {
    const prec = this.nodePrecedence(node);
    const needsParens = strict ? prec <= minPrecedence : prec < minPrecedence;
    if (needsParens) {
      this.write("(");
      this.visit(node);
      this.write(")");
    } else {
      this.visit(node);
    }
  }

  visitCall(node) {
    if (node.isAwait) this.write("await ");

    if (node.callee) {
      this.writeOperand(node.callee, Infinity, false);
    } else {
      this.write(node.name);
    }

    this.write("(");
    const args = node.args || [];
    for (let i = 0; i < args.length; i++) {
      this.visit(args[i]);
      if (i < args.length - 1) this.write(", ");
    }
    this.write(")");
  }

  visitBinary(node) {
    const prec = Fmt.BINARY_PRECEDENCE[node.operator] ?? 4;
    this.writeOperand(node.left, prec, false);
    this.space();
    this.write(node.operator);
    this.space();
    this.writeOperand(node.right, prec, true);
  }

  visitUnary(node) {
    if (node.isPostfix) {
      this.writeOperand(node.argument, 7, false);
      this.write(node.operator);
    } else {
      this.write(node.operator);
      this.writeOperand(node.argument, 7, false);
    }
  }

  visitMemberAccess(node) {
    this.writeOperand(node.object, Infinity, false);
    this.write(".");
    this.write(node.field);
  }

  visitArrayAccess(node) {
    this.writeOperand(node.array, Infinity, false);
    this.write("[");
    this.visit(node.index);
    this.write("]");

    // parseAssignment reuses ARRAY_ACCESS to represent `arr[i] = value`
    if (node.value !== undefined) {
      this.write(" ");
      this.write(node.operator);
      this.write(" ");
      this.visit(node.value);
    }
  }

  visitArray(node) {
    this.write("[");
    const elements = node.elements || [];
    for (let i = 0; i < elements.length; i++) {
      this.visit(elements[i]);
      if (i < elements.length - 1) this.write(", ");
    }
    this.write("]");
  }

  visitTernary(node) {
    this.visit(node.condition);
    this.write(" ? ");
    this.visit(node.trueExpr);
    this.write(" : ");
    this.visit(node.falseExpr);
  }

  visitAssignment(node) {
    this.write(node.name);
    this.write(" ");
    this.write(node.operator);
    this.write(" ");
    this.visit(node.value);
  }

  visitMemberAssignment(node) {
    this.visit(node.object);
    this.write(".");
    this.write(node.field);
    this.write(" ");
    this.write(node.operator);
    this.write(" ");
    this.visit(node.value);
  }

  escapeTemplateText(text) {
    return text
      .replace(/\\/g, "\\\\")
      .replace(/`/g, "\\`")
      .replace(/\$\{/g, "\\${")
      .replace(/\n/g, "\\n")
      .replace(/\t/g, "\\t")
      .replace(/\r/g, "\\r");
  }

  visitTemplateLiteral(node) {
    this.write("`");
    for (const part of node.parts) {
      if (typeof part === "string") {
        this.write(this.escapeTemplateText(part));
      } else {
        this.write("${");
        this.write(this.capture(() => this.visitStatements(part)));
        this.write("}");
      }
    }
    this.write("`");
  }
}
