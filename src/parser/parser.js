import {
  ParserTypes,
  BUILTIN_FUNCTIONS,
  TYPES,
  BUILTIN_STRUCTS,
} from "../config/config.js";
import { Lexer } from "../lexer/lexer.js";

export class Parser {
  constructor(tokens, IRB, options = { preserveComments: false}) {
    this.tokens = tokens;
    this.pos = 0;
    this.IRB = IRB;
    this.options = options;
  }

  // HELPERS

  lineAndColumn() {
    return {
      line: this.current()?.line,
      column: this.current()?.column,
    };
  }

  current() {
    return this.tokens[this.pos];
  }

  advance() {
    const token = this.tokens[this.pos++];

    this.lastToken = token;

    return token;
  }

  node(node) {
    node.line = this.lastToken?.line;
    node.column = this.lastToken?.column;
    return node;
  }

  match(type) {
    return this.current()?.type === type;
  }

  expect(type) {
    if (!this.match(type)) {
      this.IRB.emitError(
        "SyntaxError",
        `Expected '${type}', got '${this.current()?.type ?? "EOF"}'`,
        this.lineAndColumn(),
      );
    }
    return this.advance();
  }

  skipNewlines() {
    while (this.match("NEWLINE")) {
      this.advance();
    }
  }

  matchKeyword(value) {
    return (
      this.current()?.type === "KEYWORD" && this.current()?.value === value
    );
  }

  expectKeyword(value) {
    if (!this.matchKeyword(value)) {
      this.IRB.emitError(
        "SyntaxError",
        `Expected keyword '${value}', got '${this.current()?.value ?? "EOF"}'`,
        this.lineAndColumn(),
      );
    }
    return this.advance();
  }

  peek(type) {
    return this.tokens[this.pos + 1]?.type === type;
  }

  // ENTRY

  parse() {
    const body = [];

    while (this.current() && !this.match("EOF")) {
      //  SKIP EMPTY LINES
      if (this.match("NEWLINE")) {
        this.advance();
        continue;
      }

      const stmt = this.parseStatement();
      if (stmt) body.push(stmt);

      //  consume statement parator
      if (this.match("NEWLINE")) {
        this.advance();
      }
    }

    return body;
  }
  
  isGenericStart(pos) {
  return this.tokens[pos]?.value === "<" && this.tokens[pos + 1]?.value === "List";
}

  // STATEMENTS

  parseStatement() {
    
    if (this.matchKeyword("const") &&
    this.tokens[this.pos + 1]?.type === "IDENTIFIER" &&
    this.tokens[this.pos + 2]?.type === "IDENTIFIER") {
    this.advance(); // const
    return this.node(this.parseStructVariableDeclaration(true));
}

if (this.match("IDENTIFIER") && this.peek("IDENTIFIER")) {
    return this.node(this.parseStructVariableDeclaration(false));
}
    
    if (
      this.match("TYPE") ||
      this.matchKeyword("auto") ||
      this.matchKeyword("reactive") || 
      this.matchKeyword("const")
    ) {
      return this.node(this.parseVariableDeclaration());
    }
    
    if (this.options.preserveComments) {
    if (this.match("COMMENT")) {
      return this.parseComment();
    }
    }

    if (this.matchKeyword("switch")) {
      return this.node(this.parseSwitch());
    }

    if (this.matchKeyword("do")) {
      return this.node(this.parseDoWhile());
    }

    if (this.matchKeyword("List")) {
      return this.node(this.parseList());
    }

    if (this.matchKeyword("import")) {
      return this.node(this.parseImport());
    }

    if (this.matchKeyword("struct")) {
      return this.node(this.parseStruct());
    }

    if (this.matchKeyword("enum")) {
      return this.node(this.parseEnum());
    }

    if (this.matchKeyword("export")) {
      return this.node(this.parseExport());
    }

    if (this.match("BLOCK_END")) return null;

    if (this.matchKeyword("return")) {
      this.advance();
      let value;
      if (
        this.match("NEWLINE") ||
        this.match("BLOCK_END") ||
        this.match("EOF")
      ) {
        value = [];
      } else {
        value = this.parseExpression();
      }

      return this.node({
        type: ParserTypes.RETURN,
        value,
      });
    }

    if (
      this.matchKeyword("fn") ||
      this.matchKeyword("async") ||
      this.matchKeyword("thread") ||
      this.matchKeyword("extern")
    ) {
      let isAsync = false; // default mode
      let isThread = false;
      const insideMethod = false;
      let isExtern = false;

      if (this.matchKeyword("async")) {
        isAsync = true;
      } else if (this.matchKeyword("thread")) {
        isThread = true;
      } else if (this.matchKeyword("extern")) {
        isExtern = true;
      }

      return this.node(
        this.parseFunction(insideMethod, isAsync, isThread, isExtern),
      );
    }

    if (this.matchKeyword("while")) {
      return this.node(this.parseWhileLoop());
    }

    if (this.matchKeyword("break")) {
      this.expectKeyword("break");
      return this.node({ type: ParserTypes.BREAK });
    }

    if (
  this.matchKeyword("await") &&
  this.tokens[this.pos + 1]?.type === "IDENTIFIER" &&
  (
    this.tokens[this.pos + 2]?.type === "LEFT_PARENTHESIS" ||
    this.isGenericStart(this.pos + 2)
  )
) {
  this.advance();

  const name = this.current().value;

  this.advance();

  return this.node(
    this.parseCall(
      name,
      true, // isAwait
    ),
  );
}

if (
  this.match("IDENTIFIER") &&
  (
    this.peek("LEFT_PARENTHESIS") ||
    this.isGenericStart(this.pos + 1)
  )
) {
  
  const name = this.current().value;
  
  this.advance();
  return this.node(this.parseCall(name, false));
}

    if (this.matchKeyword("continue")) {
      this.expectKeyword("continue");
      return this.node({ type: ParserTypes.CONTINUE });
    }

    if (this.matchKeyword("loop")) {
      return this.node(this.parseLoop());
    }

    if (this.match("BLOCK_START")) {
      return this.node(this.parseBlock());
    }

    if (this.matchKeyword("if")) {
      return this.node(this.parseConditional());
    }

    if (this.match("LBRACKET")) {
      return this.node(this.parseExpression());
    }

    if (this.match("IDENTIFIER")) {
      if (this.tokens[this.pos + 1].type === "NEWLINE") {
        this.IRB.emitError(
          "SyntaxError",
          `Unexpected token '${this.current().value}'`,
          this.lineAndColumn(),
        );
      }
      const expr = this.parseExpression();

      return this.node({
        type: ParserTypes.VARIABLE_REFERENCE,
        expression: expr,
      });
    }

    const expr = this.parseExpression();

    return this.node({
      type: ParserTypes.VARIABLE_REFERENCE,
      expression: expr,
    });
  }
  
  parseStructVariableDeclaration(isConst = false) {
    const struct_ref = this.advance().value;
    const name = this.advance().value;

    let value = null;
    if (this.current().value === "=") {
        this.advance();
        value = this.node(this.parseExpression());
    }

    return this.node({
        type: ParserTypes.VARIABLE_DECLARATION,
        struct_ref,
        name,
        value,
        isConstant: isConst,
    });
}
  
  parseComment() {
    const token = this.advance();

    return {
      type: ParserTypes.COMMENT,
      value: token.value
    };
}

  parseStructLiteral() {
    this.skipNewlines();
    this.expect("BLOCK_START");

    this.skipNewlines();

    const properties = [];

    while (!this.match("BLOCK_END") && !this.match("EOF")) {
      this.skipNewlines();
      let key;

      if (this.match("IDENTIFIER")) {
        key = this.expect("IDENTIFIER").value;
      } else if (this.match("string")) {
        key = this.expect("string").value;
      } else {
        this.IRB.emitError(
          "SyntaxError",
          "Expected identifier or string as object key",
        );
      }

      let index = null;

      // a[10]
      if (this.match("LBRACKET")) {
        this.advance();

        index = this.parseExpression();

        this.expect("RBRACKET");
      }

      this.expect("COLON");

      let value;

      // nested map
      if (this.match("BLOCK_START")) {
        value = this.parseStructLiteral();
      } else {
        value = this.parseExpression();
      }

      properties.push({
        type: ParserTypes.MAP_PROPERTY,
        key,
        index,
        value,
      });

      if (this.match("COMMA")) {
        this.advance();
      }

      this.skipNewlines();
    }

    this.expect("BLOCK_END");

    return this.node({
      type: ParserTypes.STRUCT_LITERAL,
      properties,
    });
  }

  parseSwitch() {
    this.expectKeyword("switch");

    this.expect("LEFT_PARENTHESIS");

    const discriminant = this.parseExpression();

    this.expect("RIGHT_PARENTHESIS");

    this.expect("BLOCK_START");

    const cases = [];
    let defaultCase = null;

    this.skipNewlines();

    while (!this.match("BLOCK_END")) {
      this.skipNewlines();

      // CASE

      if (this.matchKeyword("case")) {
        this.advance(); // consume 'case'

        const value = this.node(this.parseExpression());
        this.expect("COLON");

        this.skipNewlines();

        const statements = [];

        while (
          !this.matchKeyword("case") &&
          !this.matchKeyword("default") &&
          !this.match("BLOCK_END")
        ) {
          statements.push(this.parseStatement());

          this.skipNewlines();
        }

        cases.push({
          value,
          statements,
        });

        continue;
      }

      // DEFAULT

      if (this.matchKeyword("default")) {
        this.advance(); // consume 'default'
        this.expect("COLON");

        this.skipNewlines();

        const statements = [];

        while (!this.match("BLOCK_END")) {
          statements.push(this.parseStatement());

          this.skipNewlines();
        }

        defaultCase = {
          statements,
        };

        continue;
      }

      this.IRB.emitError(
        "SyntaxError",
        `Unexpected token '${this.current.value}' in switch`,
        this.lineAndColumn(),
      );
    }

    this.expect("BLOCK_END");

    return {
      type: ParserTypes.SWITCH,
      discriminant,
      cases,
      defaultCase,
    };
  }

  parseStruct() {
  
    this.expectKeyword("struct");

    const name = this.expect("IDENTIFIER").value;

    if (BUILTIN_STRUCTS.includes(name)) {
      this.IRB.emitError(
        "TypeError",
        `'${name}' is a reserved struct type and cannot be used as a struct name`,
        this.lineAndColumn(),
      );
    }

    this.expect("BLOCK_START");

    const fields = [];
    const methods = [];

    while (!this.match("BLOCK_END")) {
      if (this.match("NEWLINE")) {
        this.advance();
        continue;
      }

      let isAsyncMethod = false;
      let isThreadfn = false;

      if (this.matchKeyword("async")) {
        isAsyncMethod = true;
        this.advance();
      } else if (this.matchKeyword("thread")) {
        isThreadfn = true;
        this.advance();
      } else if (this.matchKeyword("fn")) {
        this.IRB.emitError("SyntaxError", "method should be declared without 'fn' keyword", this.lineAndColumn());
      }

      // METHOD
      if (this.match("IDENTIFIER") && this.peek("LEFT_PARENTHESIS")) {
        const nameToken = this.advance();

        const method = this.parseFunction(true, isAsyncMethod, isThreadfn);

        method.name = nameToken.value;
        method.isMethod = true;

        methods.push(method);
        continue;
      }

      // FIELD
      const typeNode = this.parseType();
      const nameToken = this.expect("IDENTIFIER");

      fields.push(
        this.node({
          name: nameToken.value,
          ...typeNode,
        }),
      );

      if (this.match("NEWLINE")) this.advance();
      if (this.match("COMMA")) this.advance();
    }

    this.expect("BLOCK_END");

    return this.node({
      type: ParserTypes.STRUCT,
      name,
      fields,
      methods,
    });
  }

  parseEnum() {
    this.expectKeyword("enum");

    const name = this.expect("IDENTIFIER").value;

    this.expect("BLOCK_START");

    const members = [];

    while (!this.match("BLOCK_END")) {
      if (this.match("NEWLINE")) {
        this.advance();
        continue;
      }

      const memberName = this.expect("IDENTIFIER").value;

      let value = null;

      if (this.match("ASSIGNMENT")) {
        this.advance();
        value = this.parseExpression();
      }

      members.push(
        this.node({
          name: memberName,
          value,
        }),
      );

      if (this.match("COMMA")) this.advance();
      if (this.match("NEWLINE")) this.advance();
    }

    this.expect("BLOCK_END");

    return this.node({
      type: ParserTypes.ENUM,
      name,
      members,
    });
  }

  expectLessThan() {
    const t = this.current();

    if (t.type !== "COMPARISON" || t.value !== "<") {
      this.IRB.emitError(
        "SyntaxError",
        `Expected LESS_THAN '<', got ${t.value}`,
        this.lineAndColumn(),
      );
    }

    return this.advance();
  }

  expectGreaterThan() {
    const t = this.current();

    if (t.type !== "COMPARISON" || t.value !== ">") {
      this.IRB.emitError(
        "SyntaxError",
        `Expected GREATER_THAN '>', got ${t.value}`,
        this.lineAndColumn(),
      );
    }

    return this.advance();
  }

  parseListGeneric() {
    // consume List
    this.expectKeyword("List");

    // <
    this.expectLessThan();

    let innerType;

    // nested list
    if (this.matchKeyword("List")) {
      innerType = this.parseListGeneric();
    }

    // primitive / struct 
    else if (this.match("TYPE") || this.match("IDENTIFIER")) {
      innerType = {
        type: this.advance().value,
      };
    } else {
      this.IRB.emitError(
        "SyntaxError",
        `Invalid List generic type`,
        this.lineAndColumn(),
      );
    }

    // >
    this.expectGreaterThan();

    return this.node({
      type: "List",
      generic: innerType,
    });
  }

  parseList(isConstant = false) {
    
    const generic = this.parseListGeneric();
    
    const name = this.expect("IDENTIFIER").value;

    let value;

    if (this.match("ASSIGNMENT")) {
      this.advance();

      value = this.parseExpression();
    } else {
      const depth = this.IRB.getListDepth(generic);

      let result = this.node({
        type: ParserTypes.ARRAY,
        elements: [],
      });

      for (let i = 1; i < depth; i++) {
        result = this.node({
          type: ParserTypes.ARRAY,
          elements: [result],
        });
      }

      value = result;
    }

    return this.node({
      type: ParserTypes.VARIABLE_DECLARATION,
      dataType: "List",
      isConstant,
      generic,
      name,
      value,
      isList: true,
    });
  }

  parseImport() {
    this.expectKeyword("import");
    this.expect("LEFT_PARENTHESIS");

    const names = [];

    while (!this.match("RIGHT_PARENTHESIS")) {
      this.skipNewlines();

      names.push(this.expect("IDENTIFIER").value);

      this.skipNewlines();

      if (this.match("COMMA")) {
        this.advance();
      }
    }

    this.expect("RIGHT_PARENTHESIS");
    this.expectKeyword("from");

    const source = this.expect("string").value;

    return this.node({
      type: ParserTypes.IMPORT,
      names,
      source,
    });
  }

  parseExport() {
    this.expectKeyword("export");
    this.expect("LEFT_PARENTHESIS");

    const names = [];
    this.skipNewlines();
    while (!this.match("RIGHT_PARENTHESIS")) {
      this.skipNewlines();
      names.push(this.expect("IDENTIFIER").value);

      this.skipNewlines();

      if (this.match("COMMA")) {
        this.advance();
      }
    }

    this.expect("RIGHT_PARENTHESIS");

    return this.node({
      type: ParserTypes.EXPORT,
      names,
    });
  }

  parseDoWhile() {
    this.expectKeyword("do");

    let body;

    // BODY

    if (this.match("BLOCK_START")) {
      body = this.parseBlock();
    } else {
      body = this.parseStatement();
    }

    // EXPECT WHILE

    this.expectKeyword("while");

    this.expect("LEFT_PARENTHESIS");
    const condition = this.parseExpression();
    this.expect("RIGHT_PARENTHESIS");

    return this.node({
      type: ParserTypes.DO_WHILE,
      body,
      condition,
    });
  }

  parseWhileLoop() {
    this.expectKeyword("while");

    this.expect("LEFT_PARENTHESIS");
    const condition = this.parseExpression();
    this.expect("RIGHT_PARENTHESIS");

    let body;
    if (this.match("BLOCK_START")) {
      body = this.parseBlock();
    } else {
      body = this.parseStatement();
    }

    return this.node({
      type: ParserTypes.WHILE,
      condition,
      body,
    });
  }

  parseType() {
    if (this.matchKeyword("List")) {
      return this.parseListGeneric();
    }

    if (this.matchKeyword("fn")) {
      return this.parseFnParam();
    }

    if (this.matchKeyword("Map")) {
      this.advance();

      return {
        type: "Map",
        dimensions: [],
      };
    }

    if (this.match("IDENTIFIER")) {
      const type = this.current().value;
      this.advance();

      return {
        type,
        dimensions: [],
      };
    }

    let baseType;

    if (this.match("TYPE")) {
      baseType = this.expect("TYPE").value;
    } else if (this.matchKeyword("List")) {
      baseType = this.expectKeyword("List").value;
    } else if (this.matchKeyword("Map")) {
      baseType = this.expectKeyword("Map").value;
    } else {
      this.IRB.emitError(
        "SyntaxError",
        `Unknown type '${this.current().value}'`,
        this.lineAndColumn(),
      );
    }

    const dimensions = [];

    while (this.match("LBRACKET")) {
      this.advance();

      let size = null;

      if (!this.match("RBRACKET")) {
        size = this.parseExpression();
      }

      this.expect("RBRACKET");

      dimensions.push(size);
    }

    return this.node({
      type: baseType,
      dimensions,
    });
  }

  parseFnParam() {
    this.expectKeyword("fn");

    const name = this.expect("IDENTIFIER").value;

    this.expect("LEFT_PARENTHESIS");

    const params = [];

    while (!this.match("RIGHT_PARENTHESIS")) {
      this.skipNewlines();

      const type = this.parseType();

      if (this.match("IDENTIFIER")) {
        this.IRB.emitError(
          "SyntaxError",
          "Callback type parameters cannot have names. Use 'fn cb(int, int) int'",
          this.lineAndColumn(),
        );
      }

      let isRest = false;
      if (this.match("ELLIPSIS")) {
        this.advance();
        isRest = true;
      }

      params.push({
        type,
        isRest,
        dimensions: type.dimensions,
      });

      this.skipNewlines();

      if (this.match("COMMA")) {
        this.advance();
      }
    }

    this.expect("RIGHT_PARENTHESIS");

    let returnType = {
  type: "void",
  dimensions: [],
};

if (!this.match("COMMA") && !this.match("RIGHT_PARENTHESIS")) {
  if (this.matchKeyword("void")) {
    returnType = {
      type: this.expectKeyword("void").value,
      dimensions: [],
    };
  } else {
    returnType = this.parseType(true);
  }
}

    return {
      type: "Function",
      name,
      params,
      returnType,
      dimensions: [],
    };
  }

  parseFunction(
    isInsideMethod = false,
    isAsyncFn = false,
    isThread = false,
    isExtern = false,
  ) {
    
    if (!isInsideMethod) {
      if (this.matchKeyword("async")) {
        this.advance();
      } else if (this.matchKeyword("thread")) {
        this.advance();
      } else if (this.matchKeyword("extern")) this.advance();

      this.expectKeyword("fn");
    } 

    let name;

    if (!isInsideMethod) {
      name = this.expect("IDENTIFIER").value;
      if (!this.IRB.stdlibMode) {
        if (name.startsWith("_") && !isExtern) {
          this.IRB.emitError(
            "NamingError",
            `Illegal identifier '${name}'. '_' prefix is reserved for Zen internal symbols`,
            this.lineAndColumn(),
          );
        }
      }
    }

    this.expect("LEFT_PARENTHESIS");

    const params = [];

    while (!this.match("RIGHT_PARENTHESIS")) {
      this.skipNewlines();
      
      let isConstant = false;

    if (this.matchKeyword("const")) {
        isConstant = true;
        this.advance();
    }

      const t = this.parseType();
      
      if (isConstant && t.type === "Function") {
  this.IRB.emitError(
    "TypeError",
    "function callback parameters cannot be declared as 'const'",
    this.lineAndColumn(),
  );
}

      let name;

      if (t.type === "Function") {
        name = t.name;
      } else {
        name = this.expect("IDENTIFIER").value;
      }

      this.skipNewlines();
      let isRest = false;

      if (this.match("ELLIPSIS")) {
        this.advance();
        isRest = true;
      }

      let param = {
        type: t,
        name,
        isConstant,
        dimensions: t.dimensions,
        isRest,
      };
      this.skipNewlines();
      if (isRest && !this.match("RIGHT_PARENTHESIS")) {
        this.IRB.emitError(
          "SyntaxError",
          `rest ${name} parameter must be last`,
          this.lineAndColumn(),
        );
      }
      if (this.match("ASSIGNMENT")) {
        this.advance();
        param.default = this.node(this.parseExpression());
      }

      params.push(param);

      if (this.match("COMMA")) {
        this.skipNewlines();
        this.advance();
      }
    }

    this.expect("RIGHT_PARENTHESIS");

    let returnType;

    // IMPLICIT VOID

    if (this.match("BLOCK_START")) {
      this.skipNewlines();
      returnType = {
        type: "void",
        dimensions: [],
      };
    }

    // EXPLICIT VOID
    else if (this.matchKeyword("void")) {
      this.skipNewlines();
      returnType = {
        type: this.expectKeyword("void").value,
        dimensions: [],
      };
    }

    // AUTO RETURN INFERENCE
    else if (this.match("KEYWORD") && this.current().value === "auto") {
      this.advance();

      returnType = {
        type: "auto",
        dimensions: [],
      };
    }

    // NORMAL TYPE
    else {
      returnType = this.parseType(true);
    }

    let body;
    let isDeclaration;
    if (this.match("NEWLINE")) {
      if (isInsideMethod)
        this.IRB.emitError(
          "SemanticError",
          `method '${name}' doesn't support declaration`,
          this.lineAndColumn(),
        );
      body = null;
      isDeclaration = true;
    } else {
      if (isExtern)
        this.IRB.emitError(
          "SemanticError",
          `Function '${name}' doesn't support a body. extern requires declaration only`,
          this.lineAndColumn(),
        );
      body = this.parseBlock();
      isDeclaration = false;
    }

    return this.node({
      type: ParserTypes.FUNCTION_DECLARATION,
      name,
      isAsync: isAsyncFn,
      isThread,
      isDeclaration,
      isExtern,
      params,
      returnType,
      body,
    });
  }

  parseLoop() {
    this.expectKeyword("loop");
    this.expect("LEFT_PARENTHESIS");

    // LOOP OF / LOOP IN DETECTION

    const next1 = this.tokens[this.pos];
    const next2 = this.tokens[this.pos + 1];
    
    const isLoopOf =
      next1?.type === "IDENTIFIER" &&
      next2?.type === "KEYWORD" &&
      next2.value === "of";

    const isLoopIn =
      next1?.type === "IDENTIFIER" &&
      next2?.type === "KEYWORD" &&
      next2.value === "in";

    if (isLoopIn) {
      this.IRB.emitError(
        "SemanticError",
        "loop (v in map) is not supported. Use explicit field access or supported iteration APIs.",
        this.lineAndColumn(),
      );
    }

    if (isLoopOf) {
      const varName = this.expect("IDENTIFIER").value;

      this.expectKeyword("of");

      const iterable = this.parseExpression();
      this.expect("RIGHT_PARENTHESIS");

      const body = this.match("BLOCK_START")
        ? this.parseBlock()
        : this.parseStatement();

      return this.node({
        type: ParserTypes.LOOP_OF,
        varName,
        iterable,
        body,
      });
    }

    // loop (init, condition, update)

    let first;

    if (this.match("TYPE") || this.matchKeyword("auto")) {
      first = this.node(this.parseVariableDeclaration());
    } else {
      first = this.node(this.parseExpression());
    }

    this.expect("COMMA");

    let second = this.parseExpression();

    let init = null;
    let condition;
    let update;

    if (this.match("COMMA")) {
      this.advance();

      let third = this.parseExpression();

      init = first;
      condition = second;
      update = third;
    } else {
      condition = first;
      update = second;
    }

    this.expect("RIGHT_PARENTHESIS");

    const body = this.match("BLOCK_START")
      ? this.parseBlock()
      : this.parseStatement();

    return this.node({
      type: ParserTypes.LOOP,
      init,
      condition,
      update,
      body,
    });
  }

  parseConditional() {
    this.expectKeyword("if");

    this.expect("LEFT_PARENTHESIS");
    const ifCondition = this.parseExpression();
    this.expect("RIGHT_PARENTHESIS");

    const ifBody = this.match("BLOCK_START")
      ? this.parseBlock()
      : this.parseStatement();

    const elseIf = [];
    let elseBody = null;

    this.skipNewlines();

    while (this.matchKeyword("else")) {
      this.expectKeyword("else");

      this.skipNewlines();

      if (this.matchKeyword("if")) {
        this.expectKeyword("if");

        this.expect("LEFT_PARENTHESIS");
        const condition = this.parseExpression();
        this.expect("RIGHT_PARENTHESIS");

        const body = this.match("BLOCK_START")
          ? this.parseBlock()
          : this.parseStatement();

        elseIf.push({
          condition,
          body,
        });
      } else {
        // final else
        elseBody = this.match("BLOCK_START")
          ? this.parseBlock()
          : this.parseStatement();
        break;
      }

      this.skipNewlines();
    }

    return this.node({
      type: ParserTypes.CONDITIONAL,
      if: {
        condition: ifCondition,
        body: ifBody,
      },
      elseIf,
      else: elseBody ? { body: elseBody } : null,
    });
  }

  parseBlock() {
    this.expect("BLOCK_START");

    const body = [];

    while (!this.match("BLOCK_END") && this.current()) {
      if (this.match("NEWLINE")) {
        this.advance();
        continue;
      }

      const stmt = this.parseStatement();
      if (stmt) body.push(stmt);

      if (this.match("NEWLINE")) {
        this.advance();
      }
    }

    this.expect("BLOCK_END");

    return this.node({
      type: ParserTypes.BLOCK,
      body,
    });
  }

  parseVariableDeclaration() {
    let isConst = false;
    
    if (this.match("KEYWORD")) {
      const keyVal = this.current().value;
      this.advance();
      if (keyVal === "const") {
        isConst = true;
      }
    }
    
    let haveReactive = false;
    if (this.matchKeyword("reactive")) {
      haveReactive = true;
      this.advance();
    }
    
    if (haveReactive && isConst) {
    this.IRB.emitError(
        "SyntaxError",
        "variable cannot be both 'const' and 'reactive'",
        this.lineAndColumn(),
    );
}

    // redirect to List or Map so const works there too.
    if (this.current().value === "List") {
    return this.parseList(isConst);
}
    
    const dataType = this.advance().value;

    const name = this.expect("IDENTIFIER").value;

    // ARRAY DIMENSIONS

    const dimensions = [];

    while (this.match("LBRACKET")) {
      this.advance();

      const dim = this.parseExpression();

      if (
        dim.type !== ParserTypes.INT &&
        dim.type !== ParserTypes.BINARY_EXPRESSION
      ) {
        this.IRB.emitError(
          "TypeError",
          "array dimension must be int or constant expression",
          this.lineAndColumn(),
        );
      }

      dimensions.push(dim);

      this.expect("RBRACKET");
    }

    let value = null;
    let inferredType = null;

    // EXPLICIT INITIALIZER

    if (this.match("ASSIGNMENT")) {
      this.advance();

      value = this.parseExpression();

      if (TYPES.includes(value.type)) {
        inferredType = value.type;
      }
    }

    // DEFAULT INITIALIZATION
    else {
      // AUTO INVALID

      if (dataType === "auto") {
        this.IRB.emitError(
          "TypeError",
          "auto variable requires initializer",
          this.lineAndColumn(),
        );
      }

      // ARRAY DEFAULT INIT

      if (dimensions.length > 0) {
        value = this.node({
          type: ParserTypes.ARRAY,
          elements: [],
        });
      }

      // PRIMITIVE DEFAULT INIT
      else {
        // int
        if (dataType === "int") {
          value = this.node({
            type: ParserTypes.INT,
            value: 0,
          });
        }

        // double
        else if (dataType === "double") {
          value = this.node({
            type: ParserTypes.DOUBLE,
            value: 0.0,
          });
        }

        // string
        else if (dataType === "string") {
          value = this.node({
            type: ParserTypes.STRING,
            value: "",
          });
        }

        // bool
        else if (dataType === "bool") {
          value = this.node({
            type: ParserTypes.BOOLEAN,
            value: 0,
          });
        }

        else if (dataType === "byte") {
          value = this.node({
            type: ParserTypes.BYTE,
            value: 0,
          });
        }

        else if (dataType === "long") {
          value = this.node({
            type: ParserTypes.LONG,
            value: 0,
          });
        }
      }
    }

    return this.node({
      type: ParserTypes.VARIABLE_DECLARATION,
      dataType,
      inferredType,
      isReactive: haveReactive,
      isArray: dimensions.length > 0,
      isConstant: isConst,
      name,
      dimensions,
      value,
    });
  }

  // EXPRESSIONS

  parseExpression() {
    this.skipNewlines();
    this.unaryDepth = 0;
    return this.parseAssignment();
  }

  // ASSIGNMENT (=, +=, etc)

  parseAssignment() {
    let expr = this.parseTernary();

    if (this.match("ASSIGNMENT")) {
      const op = this.advance().value;
      const value = this.parseAssignment();

      if (expr.type === ParserTypes.ARRAY_ACCESS) {
        return this.node({
          type: ParserTypes.ARRAY_ACCESS,
          array: expr.array,
          index: expr.index,
          operator: op,
          value,
        });
      }

      if (expr.type === ParserTypes.VARIABLE) {
        return this.node({
          type: ParserTypes.ASSIGNMENT,
          name: expr.name,
          operator: op,
          value,
        });
      }

      if (expr.type === ParserTypes.MEMBER_ACCESS) {
        return this.node({
          type: ParserTypes.MEMBER_ASSIGNMENT,
          object: expr.object,
          field: expr.field,
          operator: op,
          value,
        });
      }
    }

    return expr;
  }

  parseTernary() {
    this.skipNewlines();
    let condition = this.parseLogical();
    this.skipNewlines();
    if (this.match("QUESTION")) {
      this.advance(); // ?
      this.skipNewlines();
      const trueExpr = this.parseExpression(); // full expression allowed
      this.expect("COLON");
      this.skipNewlines();
      const falseExpr = this.parseExpression();
      this.skipNewlines();
      return this.node({
        type: ParserTypes.TERNARY,
        condition,
        trueExpr,
        falseExpr,
      });
    }

    return condition;
  }

  parseLogical() {
    this.skipNewlines();
    let expr = this.parseEquality();

    while (this.match("LOGICAL")) {
      const op = this.advance().value;
      const right = this.node(this.parseEquality());

      expr = this.node({
        type: ParserTypes.BINARY_EXPRESSION,
        left: expr,
        operator: op,
        right,
      });
    }

    return expr;
  }

  // COMPARISON

  parseEquality() {
    this.skipNewlines();
    let expr = this.node(this.parseComparison());

    while (this.match("EQUALITY")) {
      const op = this.advance().value;
      const right = this.node(this.parseComparison());

      expr = {
        type: ParserTypes.BINARY_EXPRESSION,
        left: expr,
        operator: op,
        right,
      };
    }

    return expr;
  }

  parseComparison() {
    this.skipNewlines();
    let expr = this.node(this.parseBitwise());

    while (this.match("COMPARISON")) {
      const op = this.advance().value;
      const right = this.node(this.parseTerm());

      expr = this.node({
        type: ParserTypes.BINARY_EXPRESSION,
        left: expr,
        operator: op,
        right,
      });
    }

    return expr;
  }

  // + -

  parseTerm() {
    this.skipNewlines();
    let expr = this.node(this.parseFactor());

    while (this.match("PLUS") || this.match("MINUS")) {
      const op = this.advance().value;
      const right = this.node(this.parseFactor());

      expr = this.node({
        type: ParserTypes.BINARY_EXPRESSION,
        left: expr,
        operator: op,
        right,
      });
    }

    return expr;
  }

  parseBitwise() {
    this.skipNewlines();

    let expr = this.node(this.parseTerm());

    while (this.match("BITWISE")) {
      const op = this.advance().value;
      const right = this.node(this.parseTerm());

      expr = this.node({
        type: ParserTypes.BINARY_EXPRESSION,
        left: expr,
        operator: op,
        right,
      });
    }

    return expr;
  }

  // * / %

  parseFactor() {
    this.skipNewlines();
    let expr = this.node(this.parseUnary());

    while (this.match("STAR") || this.match("SLASH") || this.match("MODULO")) {
      const op = this.advance().value;
      const right = this.node(this.parseUnary());

      expr = this.node({
        type: ParserTypes.BINARY_EXPRESSION,
        left: expr,
        operator: op,
        right,
      });
    }

    return expr;
  }

  parseUnary() {
    if (
      this.match("MINUS") ||
      this.match("BANG") ||
      this.match("PLUS_PLUS") ||
      this.match("MINUS_MINUS")
    ) {
      const op = this.advance().value;
      const argument = this.node(this.parseUnary());

      return this.node({
        type: ParserTypes.UNARY_EXPRESSION,
        operator: op,
        argument,
        isPostfix: false,
      });
    }

    return this.node(this.parsePostfix());
  }

  parsePostfix(isAwait = false) {
    this.skipNewlines();
    let expr = this.node(this.parsePrimary());

    while (true) {
      this.skipNewlines();
      if (this.match("DOT")) {
        this.skipNewlines();
        this.advance();
        this.skipNewlines();
        const field = this.expect("IDENTIFIER").value;
        this.skipNewlines();
        expr = this.node({
          type: ParserTypes.MEMBER_ACCESS,
          object: expr,
          field,
        });

        continue;
      }

      // ARRAY ACCESS
      if (this.match("LBRACKET")) {
        this.advance();

        const index = this.node(this.parseExpression());

        this.expect("RBRACKET");

        expr = {
          type: ParserTypes.ARRAY_ACCESS,
          array: expr,
          index,
        };

        continue;
      }
      
      if (this.isGenericStart(this.pos)) {
        this.advance(); // <
    expr.generic = this.parseListGeneric();
    this.advance(); // >
}

      if (this.match("LEFT_PARENTHESIS")) {
        this.advance();
        

        const args = [];

        while (true) {
          this.skipNewlines();

          if (this.match("RIGHT_PARENTHESIS")) {
            this.skipNewlines();
            break;
          }

          args.push(this.node(this.parseExpression()));

          this.skipNewlines();

          if (this.match("COMMA")) {
            this.advance();
          } else {
            break;
          }
        }

        this.skipNewlines();

        this.expect("RIGHT_PARENTHESIS");

        expr = {
          type: ParserTypes.CALL,
          generic: expr.generic,
          callee: expr,
          isAwait,
          args,
        };

        continue;
      }

      // existing postfix ++ --

      if (this.match("PLUS_PLUS") || this.match("MINUS_MINUS")) {
        const op = this.advance().value;

        expr = this.node({
          type: ParserTypes.UNARY_EXPRESSION,
          operator: op,
          argument: expr,
          isPostfix: true,
        });

        continue;
      }

      break;
    }

    return expr;
  }

  parseArrayLiteral() {
    this.expect("LBRACKET");

    const elements = [];

    this.skipNewlines();

    while (!this.match("RBRACKET")) {
      elements.push(this.parseExpression());

      this.skipNewlines();

      if (this.match("COMMA")) {
        this.advance();

        this.skipNewlines();
      } else {
        break;
      }
    }

    this.expect("RBRACKET");

    return this.node({
      type: ParserTypes.ARRAY,
      elements,
    });
  }

  // PRIMARY

  parsePrimary() {
    this.skipNewlines();

    const token = this.current();

    // NUMBER
    if (token.type === "int") {
      this.advance();
      return this.node({
        type: ParserTypes.INT,
        value: token.value,
      });
    }

    // DOUBLE
    if (token.type === "double") {
      this.advance();
      return this.node({
        type: ParserTypes.DOUBLE,
        value: token.value,
      });
    }

    // STRING
    if (token.type === "string") {
      this.advance();
      return this.node({
        type: ParserTypes.STRING,
        value: token.value,
      });
    }

    // BOOLEAN
    if (token.type === "bool") {
      this.advance();
      return this.node({
        type: ParserTypes.BOOLEAN,
        value: token.value === true ? 1 : 0,
      });
    }

    // BYTE
    if (token.type === "byte") {
      this.advance();
      return this.node({
        type: ParserTypes.BYTE,
        value: token.value,
      });
    }

    // LONG
    if (token.type === "long") {
      this.advance();
      return this.node({
        type: ParserTypes.LONG,
        value: token.value,
      });
    }

    if (token.type === "TEMPLATE_STRING") {
      this.advance();

      return this.node({
        type: "TEMPLATE_LITERAL",
        parts: this.parseTemplateParts(token.value),
      });
    }

    if (this.matchKeyword("this")) {
      this.advance();

      return this.node({
        type: "THIS",
        value: "this",
      });
    }

    // VARIABLE
    if (token.type === "IDENTIFIER") {
      this.advance();
      
      if (
  this.matchKeyword("await") &&
  this.isGenericStart(this.pos + 2) &&
  (
    this.tokens[this.pos + 2]?.type === "LEFT_PARENTHESIS" ||
    this.tokens[this.pos + 2]?.value === "<"
  )
) {
  this.advance();

  const name = this.current().value;

  this.advance();

  return this.node(
    this.parseCall(
      name,
      true, // isAwait
    ),
  );
}

if (
  this.match("LEFT_PARENTHESIS") ||
  this.isGenericStart(this.pos)
) {
  return this.node(this.parseCall(token.value, false));
}
      

      return this.node({
        type: ParserTypes.VARIABLE,
        name: token.value,
      });
    }

    if (this.match("BLOCK_START")) {
      return this.parseStructLiteral();
    }

    if (token.type === "KEYWORD" && token.value === "await") {
      this.advance();

      const expr = this.parsePostfix();

      if (expr.type === ParserTypes.CALL) {
        expr.isAwait = true;
        return expr;
      }

      this.IRB.emitError(
        "SyntaxError",
        "await must be followed by an async function call",
        this.lineAndColumn(),
      );
    }

    if (
      this.match("LBRACKET") &&
      this.tokens[this.pos - 1]?.type !== "IDENTIFIER"
    ) {
      return this.parseArrayLiteral();
    }

    // GROUPING ( )
    if (this.match("LEFT_PARENTHESIS")) {
      this.advance();
      this.skipNewlines();
      const expr = this.parseExpression();
      this.skipNewlines();
      this.expect("RIGHT_PARENTHESIS");
      return expr;
    }

    this.IRB.emitError(
      "SyntaxError",
      `Unexpected token '${token.value}'`,
      this.lineAndColumn(),
    );
  }

  parseTemplateParts(parts) {
    return parts.map((part) => {
      if (typeof part === "string") {
        return part;
      }

      const lexer = new Lexer(part.value, this.IRB, part.line, part.column);

      const tokens = lexer.tokenize();

      const parser = new Parser(tokens, this.IRB);

      return parser.parse();
    });
  }

  // FUNCTION CALL

  parseCall(name, isAwait = false) {
    
    let generic = null;

if (this.current().value === "<") {
  this.advance();

  generic = this.parseListGeneric();

  if (this.current().value === ">") {
    this.advance();
  } else {
    this.IRB.emitError(
      "SyntaxError",
      "Expected '>' after generic type",
      this.lineAndColumn(),
    );
  }
}
    
    this.expect("LEFT_PARENTHESIS");
    this.skipNewlines();
    const args = [];

    while (!this.match("RIGHT_PARENTHESIS")) {
      this.skipNewlines();
      args.push(this.node(this.parseExpression()));
      this.skipNewlines();
      if (this.match("COMMA")) {
        this.advance();
        this.skipNewlines();
      } else {
        break;
      }
    }

    this.skipNewlines();
    this.expect("RIGHT_PARENTHESIS");

    return this.node({
      isInbuilt: BUILTIN_FUNCTIONS.includes(name),
      type: ParserTypes.CALL,
      name,
      generic,
      isAwait,
      args,
    });
  }
}
