import { ParserTypes } from "../../src/config/config.js";
import { BUILTIN_INFO } from "../../src/config/info_config.js";

// Zen linter
//
// Walks the AST produced by the Zen parser and reports errors and warnings.
// Usage:  const { errors, warnings } = new Lint(ast, { builtins: [] }).run();
//   function  { name, params[{name,type,isConstant,isRest,default}], returnType:{type},
//               body:BLOCK|null, isExtern, isDeclaration, isMethod }
//   return    { value }          value is [] for a bare `return`
//   call      { name, args, isInbuilt }  or  { callee, args }  (method calls)
//   var decl  { name, dataType, struct_ref, generic, dimensions, isConstant, value }

// Field on function/method nodes that holds the return type. The parser stores
// it as { type: "void" | "int" | "auto" | ..., dimensions: [] } and fills in
// void when none is written, so an omitted type is void.
const RETURN_TYPE_FIELD = "returnType";

const PRIMITIVE_TYPES = new Set([
  "int",
  "long",
  "byte",
  "bool",
  "double",
  "string",
  "void",
  "auto",
  "Map",
  "List",
  "Function",
]);


const NEVER_RETURNS = new Set(["os.exit", "sys.panic"]);


const ENTRY_POINTS = new Set(["main"]);

const NORMAL = "normal";
const RETURN = "return";
const BREAK = "break";
const CONTINUE = "continue";

const returnTypeName = (t) =>
  t == null ? "void" : typeof t === "string" ? t : t.type;

const isBareReturn = (v) => v == null || (Array.isArray(v) && v.length === 0);

const byPosition = (a, b) =>
  (a.line ?? Infinity) - (b.line ?? Infinity) ||
  (a.column ?? Infinity) - (b.column ?? Infinity);

export class Lint {
  constructor(ast, { builtins = [] } = {}) {
    this.ast = Array.isArray(ast) ? ast : Array.isArray(ast?.body) ? ast.body : [];

  
    this.builtinNames = new Set([
      ...Object.keys(BUILTIN_INFO.global_fn || {}),
      ...Object.keys(BUILTIN_INFO.namespaces || {}),
      ...Object.keys(BUILTIN_INFO.structs || {}),
      ...Object.keys(BUILTIN_INFO.constants || {}),
      ...builtins,
    ]);

    this.scopes = [];
    this.errors = [];
    this.warnings = [];
    this.seen = new Set(); // de-duplicates identical diagnostics

    this.hoisted = new Set(); // top-level declarations visible before their line
    this.globalVars = new Set(); // top-level variable names
    this.lateUsed = new Set(); // globals used before they were declared

    this.breakStack = []; // innermost-last: "loop" | "switch"
    this.functionDepth = 0;
    this.methodDepth = 0;
    this.currentFunction = null;

    this.flowCache = new WeakMap();
    this.lastPos = { line: undefined, column: undefined };
  }

  run() {
    this.enterScope();

    for (const node of this.ast) {
      if (!node) continue;
      this.hoist(node);
      if (
        node.type === ParserTypes.VARIABLE_DECLARATION ||
        node.type === ParserTypes.MAP_DECLARATION
      ) {
        if (node.name) this.globalVars.add(node.name);
      }
    }

    for (const node of this.ast) {
      this.visit(node);
    }

    this.exitScope();

    this.errors.sort(byPosition);
    this.warnings.sort(byPosition);

    return {
      errors: this.errors,
      warnings: this.warnings,
    };
  }

  // Top-level functions, structs, enums and imports can be used before the
  // line that declares them.
  hoist(node) {
    switch (node.type) {
      case ParserTypes.FUNCTION_DECLARATION:
        if (!node.name) return;
        this.declare(node.name, node, "function", {
          exempt:
            node.isExtern || node.isDeclaration || ENTRY_POINTS.has(node.name),
        });
        this.hoisted.add(node);
        return;

      case ParserTypes.STRUCT:
        this.declare(node.name, node, "struct");
        this.hoisted.add(node);
        return;

      case ParserTypes.ENUM:
        this.declare(node.name, node, "enum");
        this.hoisted.add(node);
        return;

      case ParserTypes.IMPORT:
        this.declareImports(node);
        this.hoisted.add(node);
        return;

      default:
        return;
    }
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

      switch (entry.kind) {
        case "param":
          this.warning(entry.node, `Unused parameter '${name}'`);
          break;
        case "variable":
          this.warning(entry.node, `Unused variable '${name}'`);
          break;
        case "function":
          this.warning(entry.node, `Unused function '${name}'`);
          break;
        case "struct":
          this.warning(entry.node, `Unused struct '${name}'`);
          break;
        case "enum":
          this.warning(entry.node, `Unused enum '${name}'`);
          break;
        case "import":
          this.warning(entry.node, `Unused import '${name}'`);
          break;
        default:
          break;
      }
    }
  }

  declare(name, node, kind = "variable", extra = {}) {
    const scope = this.currentScope();

    if (scope.has(name)) {
      const labels = {
        function: "function",
        param: "parameter",
        struct: "struct",
        enum: "enum",
        import: "import",
      };
      this.error(
        node,
        `Duplicate ${labels[kind] ?? "variable"} declaration '${name}'`,
      );
      return;
    }

    // shadowing check (only applies to plain variables or params)
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
      kind,
      isConstant: Boolean(extra.isConstant),
      used:
        Boolean(extra.exempt) ||
        (this.scopes.length === 1 && this.lateUsed.has(name)),
    });
  }

  declareImports(node) {
    for (const name of node.names || []) {
      const alias =
        node.aliases && Object.prototype.hasOwnProperty.call(node.aliases, name)
          ? node.aliases[name]
          : name;
      this.declare(alias, node, "import");
    }
  }

  lookup(name) {
    for (let i = this.scopes.length - 1; i >= 0; i--) {
      if (this.scopes[i].has(name)) return this.scopes[i].get(name);
    }
    return null;
  }


  resolve(name, node) {
    const entry = this.lookup(name);
    if (entry) {
      entry.used = true;
      return entry;
    }
    if (this.builtinNames.has(name)) return null;

    
    if (this.functionDepth > 0 && this.globalVars.has(name)) {
      this.lateUsed.add(name);
      return null;
    }

    this.error(node, `Undefined variable '${name}'`);
    return null;
  }

  
  markTypeName(name, node, strict = false) {
    if (typeof name !== "string" || name === "") return;

    const entry = this.lookup(name);
    if (entry) {
      entry.used = true;
      return;
    }
    if (PRIMITIVE_TYPES.has(name) || this.builtinNames.has(name)) return;

    if (strict || /^[A-Z]/.test(name)) {
      this.error(node, `Undefined type '${name}'`);
    }
  }

  markType(t, node) {
    if (!t) return;

    if (typeof t === "string") {
      this.markTypeName(t, node);
      return;
    }

    this.markTypeName(t.type, node);
    if (t.generic) this.markType(t.generic, node);

    if (t.type === "Function") {
      for (const p of t.params || []) this.markType(p?.type, node);
      if (t.returnType) this.markType(t.returnType, node);
    }
  }

  visitDims(dims) {
    for (const d of dims || []) {
      if (d && typeof d === "object") this.visit(d);
    }
  }

  
  report(list, node, message) {
    const line = node?.line ?? this.lastPos.line;
    const column = node?.column ?? this.lastPos.column;

    const key = `${message}@${line}:${column}`;
    if (this.seen.has(key)) return;
    this.seen.add(key);

    list.push({ message, line, column, node });
  }

  error(node, message) {
    this.report(this.errors, node, message);
  }

  warning(node, message) {
    this.report(this.warnings, node, message);
  }

  isEmptyBlock(node) {
    return node?.type === ParserTypes.BLOCK && node.body.length === 0;
  }

  isNumericLiteral(node) {
    return [
      ParserTypes.BOOLEAN,
      ParserTypes.INT,
      ParserTypes.DOUBLE,
      ParserTypes.LONG,
      ParserTypes.BYTE,
    ].includes(node?.type);
  }

  isConstantCondition(node) {
    return this.isNumericLiteral(node);
  }

  // true / false for a literal condition, null when it is not a literal.
  constantTruth(node) {
    if (!this.isNumericLiteral(node)) return null;
    return Number(node.value) !== 0;
  }

  isZeroLiteral(node) {
    return (
      [ParserTypes.INT, ParserTypes.LONG, ParserTypes.BYTE].includes(
        node?.type,
      ) && Number(node.value) === 0
    );
  }

  canonical(node) {
    if (!node) return null;

    switch (node.type) {
      case ParserTypes.VARIABLE:
        return `var:${node.name}`;
      case "THIS":
        return "this";
      case ParserTypes.INT:
      case ParserTypes.DOUBLE:
      case ParserTypes.BOOLEAN:
      case ParserTypes.LONG:
      case ParserTypes.BYTE:
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

  neverReturns(node) {
    const expr =
      node?.type === ParserTypes.VARIABLE_REFERENCE ? node.expression : node;

    if (expr?.type !== ParserTypes.CALL) return false;

    const callee = expr.callee;
    if (
      callee?.type === ParserTypes.MEMBER_ACCESS &&
      callee.object?.type === ParserTypes.VARIABLE
    ) {
      return NEVER_RETURNS.has(`${callee.object.name}.${callee.field}`);
    }
    return false;
  }

  flowOfList(statements) {
    const out = new Set();

    for (const stmt of statements || []) {
      if (!stmt) continue;

      const f = this.flowOf(stmt);
      for (const kind of f) {
        if (kind !== NORMAL) out.add(kind);
      }
      if (!f.has(NORMAL)) return out; // the rest is unreachable
    }

    out.add(NORMAL);
    return out;
  }

  flowOf(node) {
    if (!node) return new Set([NORMAL]);
    if (Array.isArray(node)) return this.flowOfList(node);

    const cached = this.flowCache.get(node);
    if (cached) return cached;

    const result = this.computeFlow(node);
    this.flowCache.set(node, result);
    return result;
  }

  computeFlow(node) {
    switch (node.type) {
      case ParserTypes.RETURN:
        return new Set([RETURN]);

      case ParserTypes.BREAK:
        return new Set([BREAK]);

      case ParserTypes.CONTINUE:
        return new Set([CONTINUE]);

      case ParserTypes.BLOCK:
        return this.flowOfList(node.body);

      case ParserTypes.CONDITIONAL: {
        const out = new Set();
        const bodies = [
          node.if?.body,
          ...(node.elseIf || []).map((b) => b.body),
        ];
        if (node.else) bodies.push(node.else.body);
        else out.add(NORMAL); // no else: the condition may be false

        for (const body of bodies) {
          for (const kind of this.flowOf(body)) out.add(kind);
        }
        return out;
      }

      case ParserTypes.WHILE:
      case ParserTypes.LOOP:
      case ParserTypes.LOOP_OF:
      case ParserTypes.DO_WHILE: {
        const body = this.flowOf(node.body);
        const out = new Set();

        if (body.has(RETURN)) out.add(RETURN);
        if (body.has(BREAK)) out.add(NORMAL);

        const infinite =
          node.type !== ParserTypes.LOOP_OF &&
          this.constantTruth(node.condition) === true &&
          !body.has(BREAK);

        if (!infinite) {
          if (node.type === ParserTypes.DO_WHILE) {
            
            if (body.has(NORMAL) || body.has(CONTINUE)) out.add(NORMAL);
          } else {
            out.add(NORMAL);
          }
        }
        return out;
      }

      case ParserTypes.SWITCH: {
        const out = new Set();

        const addCase = (statements) => {
          const f = this.flowOfList(statements);
          for (const kind of f) {
            if (kind !== NORMAL && kind !== BREAK) out.add(kind);
          }
          
          if (f.has(NORMAL) || f.has(BREAK)) out.add(NORMAL);
        };

        for (const c of node.cases || []) addCase(c.statements);
        if (node.defaultCase) addCase(node.defaultCase.statements);
        else out.add(NORMAL); // no case may match

        return out;
      }

      case ParserTypes.VARIABLE_REFERENCE:
      case ParserTypes.CALL:
        return new Set([this.neverReturns(node) ? RETURN : NORMAL]);

      default:
        return new Set([NORMAL]);
    }
  }

  
  isDeclarationOnly(stmt) {
    return (
      stmt.type === ParserTypes.COMMENT ||
      stmt.type === ParserTypes.FUNCTION_DECLARATION ||
      stmt.type === ParserTypes.STRUCT ||
      stmt.type === ParserTypes.ENUM
    );
  }

  visitStatementList(statements) {
    let terminated = false;
    let warnedUnreachable = false;

    for (const stmt of statements || []) {
      if (!stmt) continue;

      if (terminated && !warnedUnreachable && !this.isDeclarationOnly(stmt)) {
        this.warning(stmt, "Unreachable code");
        warnedUnreachable = true;
      }

      this.visit(stmt);

      if (!terminated && !this.flowOf(stmt).has(NORMAL)) {
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
    if (typeof node !== "object" || node.type == null) return;

    if (node.line != null) {
      this.lastPos = { line: node.line, column: node.column };
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
        return this.visitReturn(node);

      case ParserTypes.BREAK: {
        const ctx = this.breakStack[this.breakStack.length - 1];
        if (!ctx) {
          this.error(node, "Break outside loop");
        } else if (ctx === "switch") {
          this.error(node, "Break not allowed in switch");
        }
        return;
      }

      case ParserTypes.CONTINUE:
        if (!this.breakStack.includes("loop")) {
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
        return this.visitArrayAccess(node);

      case ParserTypes.MEMBER_ACCESS:
        return this.visit(node.object);

      case ParserTypes.VARIABLE:
        this.resolve(node.name, node);
        return;

      case ParserTypes.CALL:
        return this.visitCall(node);

      case ParserTypes.BINARY_EXPRESSION:
        if (
          (node.operator === "/" || node.operator === "%") &&
          this.isZeroLiteral(node.right)
        ) {
          this.error(node, "Division by zero");
        }
        this.visit(node.left);
        this.visit(node.right);
        return;

      case ParserTypes.UNARY_EXPRESSION:
        return this.visitUnary(node);

      case ParserTypes.TERNARY:
        if (this.isConstantCondition(node.condition)) {
          this.warning(node.condition, "Constant condition in ternary");
        }
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
          this.visitTemplatePart(part);
        }
        return;

      case ParserTypes.IMPORT:
        if (!this.hoisted.has(node)) this.declareImports(node);
        return;

      case ParserTypes.EXPORT:
        return this.visitExport(node);

      case "THIS":
        if (this.methodDepth === 0) {
          this.error(node, "'this' used outside of a method");
        }
        return;

      case ParserTypes.COMMENT:
      case ParserTypes.INT:
      case ParserTypes.DOUBLE:
      case ParserTypes.STRING:
      case ParserTypes.BOOLEAN:
      case ParserTypes.LONG:
      case ParserTypes.BYTE:
        return;

      default:
        return;
    }
  }

  visitTemplatePart(part) {
    const list = Array.isArray(part)
      ? part
      : Array.isArray(part?.body)
        ? part.body
        : [part];

    for (const n of list) {
      if (n?.type === ParserTypes.VARIABLE_REFERENCE) {
        this.visit(n.expression);
      } else {
        this.visit(n);
      }
    }
  }

  visitExport(node) {
    for (const name of node.names || []) {
      const entry = this.lookup(name);
      if (entry) {
        entry.used = true;
      } else if (this.globalVars.has(name)) {
        this.lateUsed.add(name);
      } else if (!this.builtinNames.has(name)) {
        this.error(node, `Cannot export undefined name '${name}'`);
      }
    }
  }

  visitReturn(node) {
    if (this.functionDepth === 0) {
      this.error(node, "Return outside function");
    } else if (this.currentFunction) {
      const typeName = returnTypeName(this.currentFunction[RETURN_TYPE_FIELD]);
      const voidFn = typeName === "void";
      const hasValue = !isBareReturn(node.value);

      if (typeName === "auto") {
        // return type is inferred, so either form is fine
      } else if (voidFn && hasValue) {
        this.error(
          node,
          `Void function '${this.currentFunction.name}' cannot return a value`,
        );
      } else if (!voidFn && !hasValue) {
        this.error(
          node,
          `Function '${this.currentFunction.name}' must return a value`,
        );
      }
    }
    this.visit(node.value);
  }

  visitUnary(node) {
    if (
      (node.operator === "++" || node.operator === "--") &&
      node.argument?.type === ParserTypes.VARIABLE
    ) {
      const entry = this.lookup(node.argument.name);
      if (entry?.isConstant) {
        this.error(node, `Cannot modify constant '${node.argument.name}'`);
      }
    }
    this.visit(node.argument);
  }

  visitArrayAccess(node) {
    this.visit(node.array);
    this.visit(node.index);
    this.visit(node.value);

    if (node.operator === "=" && node.value) {
      const target = this.canonical({
        type: ParserTypes.ARRAY_ACCESS,
        array: node.array,
        index: node.index,
      });
      const source = this.canonical(node.value);

      if (target !== null && target === source) {
        this.warning(node, "Self assignment");
      }
    }
  }

  visitCall(node) {
    const callee = node.callee;
    let plainName = typeof node.name === "string" ? node.name : null;

    if (!plainName && callee) {
      if (typeof callee === "string") {
        plainName = callee;
      } else if (callee.type === ParserTypes.VARIABLE) {
        plainName = callee.name;
      } else {
        // method call (obj.method), indexed call, call result... visiting the
        // callee marks the receiver as used
        this.visit(callee);
      }
    }

    if (plainName) {
      const entry = this.lookup(plainName);
      if (entry) {
        entry.used = true;
        if (entry.kind === "function") this.checkArity(plainName, entry, node);
      } else if (!node.isInbuilt && !this.builtinNames.has(plainName)) {
        this.warning(node, `Undefined function '${plainName}'`);
      }
    }

    this.markType(node.generic, node);

    for (const arg of node.args || []) {
      if (arg?.type === ParserTypes.FUNCTION_DECLARATION) {
        // inline callback: its name is not declared in the enclosing scope
        this.visitFunctionDeclaration(arg, { isInline: true });
      } else {
        this.visit(arg);
      }
    }
  }

  checkArity(name, entry, node) {
    const params = entry.node?.params;
    if (!Array.isArray(params)) return;

    const hasRest = params.some((p) => p.isRest);
    const required = params.filter((p) => !p.isRest && !p.default).length;
    const max = hasRest ? Infinity : params.length;
    const got = (node.args || []).length;

    if (got < required || got > max) {
      const expected =
        required === max
          ? `${required}`
          : max === Infinity
            ? `at least ${required}`
            : `${required} to ${max}`;
      this.error(
        node,
        `Function '${name}' expects ${expected} argument${expected === "1" ? "" : "s"}, got ${got}`,
      );
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
    if (node.struct_ref) this.markTypeName(node.struct_ref, node, true);
    if (node.generic) this.markType(node.generic, node);
    this.visitDims(node.dimensions);

    this.declare(node.name, node, "variable", { isConstant: node.isConstant });
    this.visit(node.value);
  }

  visitMapDeclaration(node) {
    this.declare(node.name, node, "variable", { isConstant: node.isConstant });
    this.visit(node.value);
  }

  visitStructLiteral(node) {
    const seen = new Set();

    for (const prop of node.properties || []) {
      if (seen.has(prop.key)) {
        this.error(
          prop?.line != null ? prop : node,
          `Duplicate map key '${prop.key}'`,
        );
      } else {
        seen.add(prop.key);
      }

      this.visit(prop.index);
      this.visit(prop.value);
    }
  }

  visitFunctionDeclaration(
    node,
    { isMethod = false, nameSet = null, isInline = false } = {},
  ) {
    if (isMethod && nameSet) {
      if (nameSet.has(node.name)) {
        this.error(node, `Duplicate method declaration '${node.name}'`);
      } else {
        nameSet.add(node.name);
      }
    } else if (!isMethod && !isInline && !this.hoisted.has(node)) {
      this.declare(node.name, node, "function", {
        exempt:
          node.isExtern || node.isDeclaration || ENTRY_POINTS.has(node.name),
      });
    }

    this.markType(node[RETURN_TYPE_FIELD], node);
    for (const param of node.params || []) {
      this.markType(param.type, node);
      this.visitDims(param.dimensions);
    }

    if (!node.body) return; // extern / forward declaration

    // A function body is a fresh break/continue context.
    const savedFunction = this.currentFunction;
    const savedStack = this.breakStack;
    this.currentFunction = node;
    this.breakStack = [];

    this.enterScope();
    this.functionDepth++;
    if (isMethod) this.methodDepth++;

    for (const param of node.params || []) {
      this.declare(param.name, param.line != null ? param : node, "param", {
        isConstant: param.isConstant,
      });
      this.visit(param.default);
    }

    const returnType = returnTypeName(node[RETURN_TYPE_FIELD]);
    if (returnType !== "void" && returnType !== "auto") {
      if (this.flowOfList(node.body.body).has(NORMAL)) {
        this.error(
          node,
          `Function '${node.name}' does not return a value on all paths`,
        );
      }
    }

    if (this.isEmptyBlock(node.body)) {
      this.warning(node, `Empty function '${node.name}'`);
    } else {
      this.visitStatementList(node.body.body);
    }

    if (isMethod) this.methodDepth--;
    this.functionDepth--;
    this.exitScope();

    this.currentFunction = savedFunction;
    this.breakStack = savedStack;
  }

  visitStruct(node) {
    if (!this.hoisted.has(node)) this.declare(node.name, node, "struct");

    const fieldNames = new Set();
    for (const field of node.fields || []) {
      if (fieldNames.has(field.name)) {
        this.error(field, `Duplicate struct field '${field.name}'`);
      } else {
        fieldNames.add(field.name);
      }

      this.markTypeName(field.type, field);
      if (field.generic) this.markType(field.generic, field);
      this.visitDims(field.dimensions);
      this.visit(field.value);
    }

    const methodNames = new Set();
    for (const method of node.methods || []) {
      if (fieldNames.has(method.name)) {
        this.error(
          method,
          `Method '${method.name}' conflicts with a field of the same name`,
        );
      }
      this.visitFunctionDeclaration(method, {
        isMethod: true,
        nameSet: methodNames,
      });
    }
  }

  visitEnum(node) {
    if (!this.hoisted.has(node)) this.declare(node.name, node, "enum");

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
    const entry = this.resolve(node.name, node);

    if (entry?.isConstant) {
      this.error(node, `Cannot assign to constant '${node.name}'`);
    } else if (
      !entry &&
      BUILTIN_INFO.constants?.[node.name] &&
      BUILTIN_INFO.constants[node.name].mutable === false
    ) {
      this.error(node, `Cannot assign to constant '${node.name}'`);
    }

    this.visit(node.value);

    if (
      (node.operator === "/=" || node.operator === "%=") &&
      this.isZeroLiteral(node.value)
    ) {
      this.error(node, "Division by zero");
    }

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

  warnConstantLoopCondition(node, label) {
    if (!this.isConstantCondition(node.condition)) return;

    if (this.constantTruth(node.condition) === true) {
      const body = this.flowOf(node.body);
      if (body.has(BREAK) || body.has(RETURN)) return;
    }
    this.warning(node.condition, `Constant condition in ${label}`);
  }

  visitWhile(node) {
    this.warnConstantLoopCondition(node, "while");
    this.visit(node.condition);
    this.visitLoopBody(node.body);
  }

  visitDoWhile(node) {
    this.warnConstantLoopCondition(node, "do-while");
    this.visitLoopBody(node.body);
    this.visit(node.condition);
  }

  visitLoop(node) {
    this.enterScope();

    this.visit(node.init);

    this.warnConstantLoopCondition(node, "loop");
    this.visit(node.condition);
    this.visit(node.update);

    this.pushLoop();
    this.visitLoopBodyNoScope(node.body);
    this.popLoop();

    this.exitScope();
  }

  visitLoopOf(node) {
    this.enterScope();

    this.visit(node.iterable);
    this.declare(node.varName, node, "variable");

    this.pushLoop();
    this.visitLoopBodyNoScope(node.body);
    this.popLoop();

    this.exitScope();
  }

  pushLoop() {
    this.breakStack.push("loop");
  }

  popLoop() {
    this.breakStack.pop();
  }

  visitLoopBody(body) {
    this.pushLoop();
    this.visitLoopBodyNoScope(body);
    this.popLoop();
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
    this.breakStack.push("switch");

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

    this.breakStack.pop();
    this.exitScope();
  }
}
