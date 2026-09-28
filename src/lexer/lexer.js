import {
  TYPES,
  TokenTypes,
  KEYWORDS,
  OPERATORS,
  ASSIGNMENT_OPS,
  ARITHMETIC_OPS,
  UNARY_OPS,
  COMPARISON_OPS,
  LOGICAL_OPS,
  BITWISE_OPS,
} from "../config/config.js";

const SORTED_OPERATORS = [...OPERATORS].sort((a, b) => b.length - a.length);

export class Lexer {
  constructor(
    source,
    IRB,
    offsetLine = 1,
    offsetColumn = 1,
    options = { preserveComments: false },
  ) {
    this.source = source;
    this.pos = 0;
    this.currentChar = this.source[this.pos] || null;
    this.tokens = [];
    this.line = offsetLine;
    this.column = offsetColumn;
    this.IRB = IRB;
    this.IRB.source = source;
    this.options = options;
    this.angleDepth = 0;
  }

  lineAndColumn() {
    return {
      line: this.line,
      column: this.column,
    };
  }

  addToken(type, value) {
    this.tokens.push({
      type,
      value,
      line: this.line,
      column: this.column,
    });
  }

  addTokenAt(type, value, line, column) {
    this.tokens.push({
      type,
      value,
      line,
      column,
    });
  }

  readEscape() {
  const c = this.currentChar;
  switch (c) {
    case "n": return "\n";
    case "t": return "\t";
    case "r": return "\r";
    case "e": return "\x1b";
    case "x": {
      const hex = this.source.substr(this.pos + 1, 2);
      if (!/^[0-9a-fA-F]{2}$/.test(hex)) return "x";
      this.advance();
      this.advance();
      return String.fromCharCode(parseInt(hex, 16));
    }
    default: return c;
  }
  }

  tokenize() {
    while (this.currentChar !== null) {
      // newline

      if (this.currentChar === "\n") {
        this.addToken(TokenTypes.NEWLINE, "\n");
        this.advance();
        continue;
      }

      if (
        this.currentChar === " " ||
        this.currentChar === "\t" ||
        this.currentChar === "\r"
      ) {
        this.advance();
        continue;
      }

      // comments

      if (this.currentChar === "/" && this.peek() === "/") {
        this.skipComment();
        continue;
      }

      if (this.currentChar === "#") {
        this.skipComment();
        continue;
      }

      if (this.currentChar === "/" && this.peek() === "*") {
        this.skipMultiLineComment();
        continue;
      }

      // IDENTIFIER

      if (/[a-zA-Z_]/.test(this.currentChar)) {
        const line = this.line;
        const column = this.column;

        const word = this.identifier();

        if (word === "true" || word === "false") {
          this.addTokenAt(TokenTypes.BOOLEAN, word === "true", line, column);
        } else if (TYPES.includes(word)) {
          this.addTokenAt(TokenTypes.TYPE, word, line, column);
        } else if (KEYWORDS.includes(word)) {
          this.addTokenAt(TokenTypes.KEYWORD, word, line, column);
        } else if (word === "reactive") {
          this.addTokenAt(TokenTypes.REACTIVE, word, line, column);
        } else {
          this.addTokenAt(TokenTypes.IDENTIFIER, word, line, column);
        }

        continue;
      }

      // synmbols

      if (this.currentChar === ":") {
        this.addToken(TokenTypes.COLON, ":");
        this.advance();
        continue;
      }

      if (this.source.startsWith("...", this.pos)) {
        this.addToken(TokenTypes.ELLIPSIS, "...");

        this.pos += 3;
        this.column += 3;
        this.currentChar = this.source[this.pos] || null;

        continue;
      }

      if (this.currentChar === ".") {
        this.addToken(TokenTypes.DOT, ".");
        this.advance();
        continue;
      }

      if (this.currentChar === "[") {
        this.addToken(TokenTypes.LBRACKET, "[");
        this.advance();
        continue;
      }

      if (this.currentChar === "]") {
        this.addToken(TokenTypes.RBRACKET, "]");
        this.advance();
        continue;
      }

      // NUMBER

      if (/\d/.test(this.currentChar)) {
        const line = this.line;
        const column = this.column;

        const num = this.number();

        this.addTokenAt(
          num.type === "double"
            ? TokenTypes.DOUBLE
            : num.type === "long"
              ? TokenTypes.LONG
              : num.type === "byte"
                ? TokenTypes.BYTE
                : TokenTypes.INT,
          num.value,
          line,
          column,
        );

        continue;
      }

      // STRING

      if (this.currentChar === '"' || this.currentChar === "'") {
        const line = this.line;
        const column = this.column;

        const value = this.string();

        this.addTokenAt(TokenTypes.STRING, value, line, column);

        continue;
      }

      if (this.currentChar === "`") {
        const parts = this.templateString();

        this.addTokenAt(TokenTypes.TEMPLATE_STRING, parts);

        continue;
      }

      // ?

      if (this.currentChar === "?") {
        this.addToken(TokenTypes.QUESTION, "?");
        this.advance();
        continue;
      }

      if (this.currentChar === "$") {
        this.addToken(TokenTypes.DOLLAR, "$");
        this.advance();
        continue;
      }

      // OPERATORS

      // track possible generic '<' opens: only counts if it follows a type-like token
      if (this.currentChar === "<") {
        const prev = this.tokens[this.tokens.length - 1];
        if (
          prev &&
          (prev.type === TokenTypes.TYPE || prev.type === TokenTypes.KEYWORD)
        ) {
          this.angleDepth++;
        }
        
      }

      // force '>' to close one generic level at a time instead of greedily
      // matching '>>' / '>>=' as a single operator
      if (this.currentChar === ">" && this.angleDepth > 0) {
        this.addToken("COMPARISON", ">");
        this.angleDepth--;
        this.advance();
        continue;
      }

      let matched = false;

      for (const op of SORTED_OPERATORS) {
        if (this.source.startsWith(op, this.pos)) {
          let type;

          if (ASSIGNMENT_OPS.includes(op)) {
            type = "ASSIGNMENT";
          } else if (ARITHMETIC_OPS.includes(op)) {
            if (op === "+") type = "PLUS";
            else if (op === "-") type = "MINUS";
            else if (op === "*") type = "STAR";
            else if (op === "/") type = "SLASH";
            else if (op === "%") type = "MODULO";
          } else if (COMPARISON_OPS.includes(op)) {
            type = "COMPARISON";
          } else if (BITWISE_OPS.includes(op)) {
            type = "BITWISE";
          } else if (LOGICAL_OPS.includes(op)) {
            type = "LOGICAL";
          } else if (UNARY_OPS.includes(op)) {
            type =
              op === "!" ? "BANG" : op === "++" ? "PLUS_PLUS" : "MINUS_MINUS";
          }

          this.addToken(type, op);

          this.pos += op.length;
          this.column += op.length;
          this.currentChar = this.source[this.pos] || null;

          matched = true;
          break;
        }
      }

      if (matched) continue;

      // (

      if (this.currentChar === "(") {
        this.addToken(TokenTypes.LEFT_PARENTHESIS, "(");
        this.advance();
        continue;
      }

      // )

      if (this.currentChar === ")") {
        this.addToken(TokenTypes.RIGHT_PARENTHESIS, ")");
        this.advance();
        continue;
      }

      // {

      if (this.currentChar === "{") {
        this.addToken(TokenTypes.BLOCK_START, "{");
        this.advance();
        continue;
      }

      // }

      if (this.currentChar === "}") {
        this.addToken(TokenTypes.BLOCK_END, "}");
        this.advance();
        continue;
      }

      // ,

      if (this.currentChar === ",") {
        this.addToken(TokenTypes.COMMA, ",");
        this.advance();
        continue;
      }

      this.IRB.emitError(
        "SyntaxError",
        `Unexpected character: '${this.currentChar}' at line ${this.line}, column ${this.column}`,
        this.lineAndColumn(),
      );
    }

    // EOF
    this.addToken(TokenTypes.EOF, null);

    return this.tokens;
  }

  advance() {
    if (this.currentChar === "\n") {
      this.line++;
      this.column = 0;
    } else {
      this.column++;
    }
    this.pos++;
    this.currentChar = this.source[this.pos] || null;
  }

  peek() {
    return this.source[this.pos + 1] || null;
  }

  skipComment() {
    let value = "";

    while (this.currentChar !== null && this.currentChar !== "\n") {
      if (this.options.preserveComments) {
        value += this.currentChar;
      }
      this.advance();
    }

    if (this.options.preserveComments) {
      this.addToken(TokenTypes.COMMENT, value);
    }

    this.advance();
  }

  skipMultiLineComment() {
    let value = "";

    if (this.options.preserveComments) value += this.currentChar; // "/"
    this.advance();
    if (this.options.preserveComments) value += this.currentChar; // "*"
    this.advance();

    while (this.currentChar !== null) {
      if (this.currentChar === "*" && this.peek() === "/") {
        if (this.options.preserveComments) value += "*/";
        this.advance();
        this.advance();

        if (this.options.preserveComments) {
          this.addTokenAt(TokenTypes.COMMENT, value);
        }

        return;
      }

      if (this.options.preserveComments) value += this.currentChar;
      this.advance();
    }

    this.IRB.emitError(
      "SyntaxError",
      "Unterminated multi-line comment",
      this.lineAndColumn(),
    );
  }

  identifier() {
    let result = "";
    while (this.currentChar !== null && /[a-zA-Z_0-9]/.test(this.currentChar)) {
      result += this.currentChar;
      this.advance();
    }
    return result;
  }

number() {
    let result = "";
    let hasDot = false;

    // HEX
    if (this.currentChar === "0" && this.peek() === "x") {
      this.advance(); // 0
      this.advance(); // x

      let hex = "";

      while (
        this.currentChar !== null &&
        /[0-9a-fA-F]/.test(this.currentChar)
      ) {
        hex += this.currentChar;
        this.advance();
      }

      if (hex.length === 0) {
        this.IRB.emitError(
          "SyntaxError",
          "Invalid hex literal",
          this.lineAndColumn(),
        );
      }

      let type = "int";

      if (this.currentChar === "_") {
        this.advance(); // consume '_'

        if (this.currentChar === "L") {
          type = "long";
          this.advance();
        } else if (this.currentChar === "B") {
          type = "byte";
          this.advance();
        } else {
          this.IRB.emitError(
            "SyntaxError",
            `Invalid hex literal suffix after '_'`,
            this.lineAndColumn(),
          );
        }
      }

      // Anything alphabetic (or another underscore) left over is invalid
      if (
        this.currentChar !== null &&
        /[a-zA-Z_]/.test(this.currentChar)
      ) {
        this.IRB.emitError(
          "SyntaxError",
          `Invalid numeric literal`,
          this.lineAndColumn(),
        );
      }

      return {
        value: parseInt(hex, 16),
        type,
      };
    }

    // DOUBLE
    while (
      this.currentChar !== null &&
      (/\d/.test(this.currentChar) || this.currentChar === ".")
    ) {
      if (this.currentChar === ".") {
        if (hasDot) {
          break;
        }

        hasDot = true;
      }

      result += this.currentChar;
      this.advance();
    }

    if (result.startsWith(".")) {
      result = "0" + result;
    }

    // SCIENTIFIC NOTATION: 1e300, 1.5e-10, 2E+5, 6.022e23
    if (this.currentChar === "e" || this.currentChar === "E") {
      const savedPos = this.pos;
      const savedLine = this.line;
      const savedColumn = this.column;
      const savedChar = this.currentChar;

      let expStr = this.currentChar;
      this.advance(); // consume 'e' / 'E'

      if (this.currentChar === "+" || this.currentChar === "-") {
        expStr += this.currentChar;
        this.advance();
      }

      if (this.currentChar !== null && /\d/.test(this.currentChar)) {
        while (this.currentChar !== null && /\d/.test(this.currentChar)) {
          expStr += this.currentChar;
          this.advance();
        }

        result += expStr;
        hasDot = true;
      } else {
        // not a real exponent (e.g. 'e' starts an identifier) — back out
        this.pos = savedPos;
        this.line = savedLine;
        this.column = savedColumn;
        this.currentChar = savedChar;
      }
    }

    // DOUBLE
    if (hasDot) {
      if (
        this.currentChar === "L" ||
        this.currentChar === "B" ||
        /[a-zA-Z_]/.test(this.currentChar || "")
      ) {
        this.IRB.emitError(
          "SyntaxError",
          `Invalid floating-point literal: '${result}${this.currentChar}'`,
          this.lineAndColumn(),
        );
      }

      return {
        value: result,
        type: "double",
      };
    }

    // INTEGER SUFFIX
    let type = "int";

    if (this.currentChar === "L") {
      type = "long";
      this.advance();
    } else if (this.currentChar === "B") {
      type = "byte";
      this.advance();
    }

    if (this.currentChar !== null && /[a-zA-Z_]/.test(this.currentChar)) {
      this.IRB.emitError(
        "SyntaxError",
        `Invalid numeric literal: '${result}${this.currentChar}'`,
        this.lineAndColumn(),
      );
    }

    return {
      value: result,
      type,
    };
}
  
  string() {
    let result = "";
    const quoteType = this.currentChar;
    this.advance();

    while (this.currentChar !== null && this.currentChar !== quoteType) {
      if (this.currentChar === "\\") {
        this.advance();
        result += this.readEscape();
      } else {
        result += this.currentChar;
      }
      this.advance();
    }

    if (this.currentChar === quoteType) {
      this.advance();
    } else {
      this.IRB.emitError(
        "SyntaxError",
        "Unterminated string literal",
        this.lineAndColumn(),
      );
    }

    return result;
  }

  templateString() {
    const parts = [];
    let text = "";

    this.advance(); // skip `

    while (this.currentChar !== null) {
      // end template

      if (this.currentChar === "`") {
        if (text.length > 0) {
          parts.push(text);
        }

        this.advance();

        return parts;
      }

      // ${ ... }

      if (this.currentChar === "$" && this.peek() === "{") {
        if (text.length > 0) {
          parts.push(text);
          text = "";
        }

        this.advance(); // $
        this.advance(); // {

        const exprLine = this.line;
        const exprColumn = this.column;

        let expr = "";
        let depth = 1;

        while (this.currentChar !== null && depth > 0) {
          if (this.currentChar === "{") {
            depth++;
          } else if (this.currentChar === "}") {
            depth--;

            if (depth === 0) {
              break;
            }
          }

          expr += this.currentChar;
          this.advance();
        }

        if (depth !== 0) {
          this.IRB.emitError(
            "SyntaxError",
            "Unterminated template expression",
            this.lineAndColumn(),
          );
        }

        parts.push({
          type: "EXPR",
          value: expr.trim(),
          line: exprLine,
          column: exprColumn,
        });

        this.advance(); // skip closing }

        continue;
      }

      // escapes

      if (this.currentChar === "\\") {
        this.advance();

        if (this.currentChar === "n") {
          text += "\n";
        } else if (this.currentChar === "t") {
          text += "\t";
        } else if (this.currentChar === "r") {
          text += "\r";
        } else if (this.currentChar === "\\") {
          text += "\\";
        } else if (this.currentChar === "`") {
          text += "`";
        } else {
          text += this.currentChar;
        }

        this.advance();
        continue;
      }

      text += this.currentChar;
      this.advance();
    }

    this.IRB.emitError(
      "SyntaxError",
      "Unterminated template string",
      this.lineAndColumn(),
    );
  }
}
