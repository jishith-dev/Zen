import { ParserTypes } from "../../src/config/config.js";

export class Lint {
  constructor(ast) {
    this.ast = ast;

    this.scopes = [];
    this.errors = [];
    this.warnings = [];

    this.loopDepth = 0;
    this.functionDepth = 0;
    this.switchDepth = 0;

    this.currentFunction = null;
    this.unreachable = false;
  }

  run() {
    this.enterScope();

    for (const node of this.ast) {
      this.visit(node);
    }

    this.exitScope();

    return {
      errors: this.errors,
      warnings: this.warnings,
    };
  }

  enterScope() {
    this.scopes.push(new Map());
  }

  exitScope() {
    this.checkUnused();
    this.scopes.pop();
  }

  currentScope() {
    return this.scopes[this.scopes.length - 1];
  }

  checkUnused() {
    const scope = this.currentScope();
    if (!scope) return;

    for (const [name, entry] of scope) {
      if (entry.used) continue;

      if (entry.kind === "param") {
        this.warning(entry.node, `Unused parameter '${name}'`);
      } else if (entry.kind === "variable") {
        this.warning(entry.node, `Unused variable '${name}'`);
      }
    }
  }

  declare(name, node, kind = "variable") {
    const scope = this.currentScope();

    if (scope.has(name)) {
      const label =
        kind === "function"
          ? "function"
          : kind === "param"
          ? "parameter"
          : kind === "struct"
          ? "struct"
          : kind === "enum"
          ? "enum"
          : "variable";

      this.error(node, `Duplicate ${label} declaration '${name}'`);
      return;
    }

    // shadowing check (only applies to plain variables/params)
    if (kind === "variable" || kind === "param") {
      for (let i = this.scopes.length - 2; i >= 0; i--) {
        if (this.scopes[i].has(name)) {
          this.warning(node, `'${name}' shadows an outer declaration`);
          break;
        }
      }
    }

    scope.set(name, {
      node,
      used: kind === "import", // imports don't need to be flagged unused
      kind,
    });
  }

  resolve(name, node) {
    for (let i = this.scopes.length - 1; i >= 0; i--) {
      const scope = this.scopes[i];

      if (scope.has(name)) {
        scope.get(name).used = true;
        return;
      }
    }

    this.error(node, `Undefined variable '${name}'`);
  }


  error(node, message) {
    this.errors.push({
      message,
      line: node?.line,
      column: node?.column,
      node,
    });
  }

  warning(node, message) {
    this.warnings.push({
      message,
      line: node?.line,
      column: node?.column,
      node,
    });
  }

  isEmptyBlock(node) {
    return node?.type === ParserTypes.BLOCK && node.body.length === 0;
  }

  isConstantCondition(node) {
    return node?.type === ParserTypes.BOOLEAN;
  }

  canonical(node) {
    if (!node) return null;

    switch (node.type) {
      case ParserTypes.VARIABLE:
        return `var:${node.name}`;
      case ParserTypes.INT:
      case ParserTypes.DOUBLE:
      case ParserTypes.BOOLEAN:
        return `lit:${node.value}`;
      case ParserTypes.STRING:
        return `str:${node.value}`;
      case ParserTypes.MEMBER_ACCESS: {
        const obj = this.canonical(node.object);
        if (obj === null) return null;
        return `member:${obj}.${node.field}`;
      }
      case ParserTypes.ARRAY_ACCESS: {
        const arr = this.canonical(node.array);
        const idx = this.canonical(node.index);
        if (arr === null || idx === null) return null;
        return `access:${arr}[${idx}]`;
      }
      default:
        return null;
    }
  }


  visitStatementList(statements) {
    let terminated = false;
    let warnedUnreachable = false;

    for (const stmt of statements) {
      if (!stmt) continue;

      if (terminated && !warnedUnreachable) {
        this.warning(stmt, "Unreachable code");
        warnedUnreachable = true;
      }

      this.visit(stmt);

      if (
        stmt.type === ParserTypes.RETURN ||
        stmt.type === ParserTypes.BREAK ||
        stmt.type === ParserTypes.CONTINUE
      ) {
        terminated = true;
      }
    }
  }

  visit(node) {
    if (!node) return;
    if (Array.isArray(node)) {
      for (const n of node) this.visit(n);
      return;
    }

    switch (node.type) {
      case ParserTypes.VARIABLE_DECLARATION:
        return this.visitVariableDeclaration(node);

      case ParserTypes.MAP_DECLARATION:
        return this.visitMapDeclaration(node);

      case ParserTypes.FUNCTION_DECLARATION:
        return this.visitFunctionDeclaration(node);

      case ParserTypes.STRUCT:
        return this.visitStruct(node);

      case ParserTypes.ENUM:
        return this.visitEnum(node);

      case ParserTypes.STRUCT_LITERAL:
        return this.visitStructLiteral(node);

      case ParserTypes.MAP_PROPERTY:
        this.visit(node.index);
        return this.visit(node.value);

      case ParserTypes.SWITCH:
        return this.visitSwitch(node);

      case ParserTypes.BLOCK:
        this.enterScope();
        this.visitStatementList(node.body);
        this.exitScope();
        return;

      case ParserTypes.CONDITIONAL:
        return this.visitConditional(node);

      case ParserTypes.WHILE:
        return this.visitWhile(node);

      case ParserTypes.DO_WHILE:
        return this.visitDoWhile(node);

      case ParserTypes.LOOP:
        return this.visitLoop(node);

      case ParserTypes.LOOP_OF:
        return this.visitLoopOf(node);

      case ParserTypes.RETURN:
        if (this.functionDepth === 0) {
          this.error(node, "Return outside function");
        }
        this.visit(node.value);
        return;

      case ParserTypes.BREAK:
        if (this.loopDepth === 0 && this.switchDepth === 0) {
          this.error(node, "Break outside loop");
        }
        return;

      case ParserTypes.CONTINUE:
        if (this.loopDepth === 0) {
          this.error(node, "Continue outside loop");
        }
        return;

      case ParserTypes.VARIABLE_REFERENCE:
        return this.visitVariableReferenceStatement(node);

      case ParserTypes.ASSIGNMENT:
        return this.visitAssignment(node);

      case ParserTypes.MEMBER_ASSIGNMENT:
        return this.visitMemberAssignment(node);

      case ParserTypes.ARRAY_ACCESS:
        this.visit(node.array);
        this.visit(node.index);
        this.visit(node.value);
        return;

      case ParserTypes.MEMBER_ACCESS:
        return this.visit(node.object);

      case ParserTypes.VARIABLE:
        return this.resolve(node.name, node);

      case ParserTypes.CALL:
        for (const arg of node.args || []) this.visit(arg);
        return;

      case ParserTypes.BINARY_EXPRESSION:
        this.visit(node.left);
        this.visit(node.right);
        return;

      case ParserTypes.UNARY_EXPRESSION:
        return this.visit(node.argument);

      case ParserTypes.TERNARY:
        this.visit(node.condition);
        this.visit(node.trueExpr);
        this.visit(node.falseExpr);
        return;

      case ParserTypes.ARRAY:
        for (const el of node.elements || []) this.visit(el);
        return;

      case "TEMPLATE_LITERAL":
        for (const part of node.parts || []) {
          if (typeof part === "string") continue;
          this.visit(part);
        }
        return;

      case ParserTypes.IMPORT:
        for (const name of node.names || []) {
          this.declare(name, node, "import");
        }
        return;

      case ParserTypes.EXPORT:
        for (const name of node.names || []) {
          this.resolve(name, node);
        }
        return;

      case ParserTypes.COMMENT:
        return;

      case ParserTypes.INT:
      case ParserTypes.DOUBLE:
      case ParserTypes.STRING:
      case ParserTypes.BOOLEAN:
      case "THIS":
        return;

      default:
        return;
    }
  }

  visitVariableReferenceStatement(node) {
    const expr = node.expression;
    this.visit(expr);

    if (!expr) return;

    const hasEffect =
      expr.type === ParserTypes.CALL ||
      expr.type === ParserTypes.ASSIGNMENT ||
      expr.type === ParserTypes.MEMBER_ASSIGNMENT ||
      (expr.type === ParserTypes.ARRAY_ACCESS && expr.operator) ||
      (expr.type === ParserTypes.UNARY_EXPRESSION &&
        (expr.operator === "++" || expr.operator === "--"));

    if (!hasEffect) {
      this.warning(node, "Expression has no effect");
    }
  }

  visitVariableDeclaration(node) {
    this.declare(node.name, node, "variable");
    this.visit(node.value);
  }

  visitMapDeclaration(node) {
    this.declare(node.name, node, "variable");
    this.visit(node.value);
  }

  visitStructLiteral(node) {
    const seen = new Set();

    for (const prop of node.properties || []) {
      if (seen.has(prop.key)) {
        this.error(prop, `Duplicate map key '${prop.key}'`);
      } else {
        seen.add(prop.key);
      }

      this.visit(prop.index);
      this.visit(prop.value);
    }
  }

  visitFunctionDeclaration(node, { isMethod = false, nameSet = null } = {}) {
    if (isMethod && nameSet) {
      if (nameSet.has(node.name)) {
        this.error(node, `Duplicate method declaration '${node.name}'`);
      } else {
        nameSet.add(node.name);
      }
    } else if (!isMethod) {
      this.declare(node.name, node, "function");
    }

    if (!node.body) return; // extern / forward declaration

    this.enterScope();
    this.functionDepth++;

    for (const param of node.params || []) {
      this.declare(param.name, node, "param");
      this.visit(param.default);
    }

    if (this.isEmptyBlock(node.body)) {
      this.warning(node, `Empty function '${node.name}'`);
      this.enterScope(); // keep enter/exit balanced with visitStatementList below
      this.exitScope();
    } else {
      this.visitStatementList(node.body.body);
    }

    this.functionDepth--;
    this.exitScope();
  }

  visitStruct(node) {
    this.declare(node.name, node, "struct");

    const fieldNames = new Set();
    for (const field of node.fields || []) {
      if (fieldNames.has(field.name)) {
        this.error(field, `Duplicate struct field '${field.name}'`);
      } else {
        fieldNames.add(field.name);
      }
    }

    const methodNames = new Set();
    for (const method of node.methods || []) {
      this.visitFunctionDeclaration(method, {
        isMethod: true,
        nameSet: methodNames,
      });
    }
  }

  visitEnum(node) {
    this.declare(node.name, node, "enum");

    const memberNames = new Set();
    for (const member of node.members || []) {
      if (memberNames.has(member.name)) {
        this.error(member, `Duplicate enum member '${member.name}'`);
      } else {
        memberNames.add(member.name);
      }

      this.visit(member.value);
    }
  }


  visitAssignment(node) {
    this.resolve(node.name, node);
    this.visit(node.value);

    if (
      node.operator === "=" &&
      node.value?.type === ParserTypes.VARIABLE &&
      node.value.name === node.name
    ) {
      this.warning(node, `Self assignment '${node.name} = ${node.name}'`);
    }
  }

  visitMemberAssignment(node) {
    this.visit(node.object);
    this.visit(node.value);

    if (node.operator === "=") {
      const target = this.canonical({
        type: ParserTypes.MEMBER_ACCESS,
        object: node.object,
        field: node.field,
      });
      const source = this.canonical(node.value);

      if (target !== null && target === source) {
        this.warning(node, "Self assignment");
      }
    }
  }


  visitConditional(node) {
    if (this.isConstantCondition(node.if.condition)) {
      this.warning(node.if.condition, "Constant condition in if");
    }
    this.visit(node.if.condition);
    this.visitBranchBody(node.if.body);

    for (const branch of node.elseIf || []) {
      if (this.isConstantCondition(branch.condition)) {
        this.warning(branch.condition, "Constant condition in if");
      }
      this.visit(branch.condition);
      this.visitBranchBody(branch.body);
    }

    if (node.else) {
      this.visitBranchBody(node.else.body);
    }
  }

  visitBranchBody(body) {
    if (!body) return;

    if (body.type === ParserTypes.BLOCK) {
      if (this.isEmptyBlock(body)) {
        this.warning(body, "Empty block");
        return;
      }
      this.enterScope();
      this.visitStatementList(body.body);
      this.exitScope();
      return;
    }

    this.visit(body);
  }

  visitWhile(node) {
    if (this.isConstantCondition(node.condition)) {
      this.warning(node.condition, "Constant condition in while");
    }
    this.visit(node.condition);
    this.visitLoopBody(node.body);
  }

  visitDoWhile(node) {
    if (this.isConstantCondition(node.condition)) {
      this.warning(node.condition, "Constant condition in while");
    }
    this.visitLoopBody(node.body);
    this.visit(node.condition);
  }

  visitLoop(node) {
    this.enterScope();

    this.visit(node.init);

    if (this.isConstantCondition(node.condition)) {
      this.warning(node.condition, "Constant condition in loop");
    }
    this.visit(node.condition);
    this.visit(node.update);

    this.loopDepth++;
    this.visitLoopBodyNoScope(node.body);
    this.loopDepth--;

    this.exitScope();
  }

  visitLoopOf(node) {
    this.enterScope();

    this.visit(node.iterable);
    this.declare(node.varName, node, "variable");

    this.loopDepth++;
    this.visitLoopBodyNoScope(node.body);
    this.loopDepth--;

    this.exitScope();
  }

  visitLoopBody(body) {
    this.loopDepth++;
    this.visitLoopBodyNoScope(body);
    this.loopDepth--;
  }

  visitLoopBodyNoScope(body) {
    if (!body) return;

    if (body.type === ParserTypes.BLOCK) {
      if (this.isEmptyBlock(body)) {
        this.warning(body, "Empty loop");
        return;
      }
      this.enterScope();
      this.visitStatementList(body.body);
      this.exitScope();
      return;
    }

    this.visit(body);
  }


  visitSwitch(node) {
    this.visit(node.discriminant);

    this.enterScope();
    this.switchDepth++;

    const seenCases = new Set();

    for (const c of node.cases || []) {
      const key = this.canonical(c.value);

      if (key !== null) {
        if (seenCases.has(key)) {
          this.warning(c.value, "Duplicate switch case");
        } else {
          seenCases.add(key);
        }
      }

      this.visit(c.value);
      this.visitStatementList(c.statements);
    }

    if (node.defaultCase) {
      this.visitStatementList(node.defaultCase.statements);
    }

    this.switchDepth--;
    this.exitScope();
  }
}
