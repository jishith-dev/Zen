import {
  BUILTIN_MAP,
  KEYWORDS,
  LLVM_TYPES_MAP
} from "../src/config/config.js";

const RESET = "\x1b[0m";

// Zen / VS Code-inspired palette
const KEYWORD = "\x1b[38;5;204m";     // Pink
const BUILTIN = "\x1b[38;5;117m";     // Light blue
const TYPE = "\x1b[38;5;81m";         // Cyan
const STRING = "\x1b[38;5;114m";      // Soft green
const NUMBER = "\x1b[38;5;215m";      // Orange
const INTERPOLATION = "\x1b[38;5;214m";
const COMMENT = "\x1b[38;5;245m";     // Gray
const IDENTIFIER = "\x1b[38;5;252m";  // White

const PAREN = "\x1b[38;5;208m";    // orange
const BRACKET = "\x1b[38;5;75m";   // blue
const BRACE = "\x1b[38;5;141m";    // purple

const BUILTINS = new Set(Object.keys(BUILTIN_MAP));
const TYPES = new Set(Object.keys(LLVM_TYPES_MAP));

function isIdentifierStart(ch) {
  return /[A-Za-z_@]/.test(ch);
}

function isIdentifierPart(ch) {
  return /[A-Za-z0-9_@]/.test(ch);
}

export function highlightCode(source) {
  let output = "";
  let i = 0;

  while (i < source.length) {
    const ch = source[i];

    // // comments
    if (ch === "/" && source[i + 1] === "/") {
      let comment = "//";
      i += 2;

      while (i < source.length && source[i] !== "\n") {
        comment += source[i];
        i++;
      }

      output += COMMENT + comment + RESET;
      continue;
    }

    // # comments
    if (ch === "#") {
      let comment = "#";
      i++;

      while (i < source.length && source[i] !== "\n") {
        comment += source[i];
        i++;
      }

      output += COMMENT + comment + RESET;
      continue;
    }

    // /* */ comments
    if (ch === "/" && source[i + 1] === "*") {
      let comment = "/*";
      i += 2;

      while (
        i < source.length &&
        !(source[i] === "*" && source[i + 1] === "/")
      ) {
        comment += source[i];
        i++;
      }

      if (i < source.length) {
        comment += "*/";
        i += 2;
      }

      output += COMMENT + comment + RESET;
      continue;
    }

    // Strings
    if (ch === '"' || ch === "'" || ch === "`") {
      const quote = ch;
      let value = quote;
      i++;

      while (i < source.length) {
        const current = source[i];

        // Escaped character
        if (current === "\\") {
          value += current;

          if (i + 1 < source.length) {
            value += source[i + 1];
            i += 2;
            continue;
          }
        }

        // ${...}
        if (
          quote === "`" &&
          current === "$" &&
          source[i + 1] === "{"
        ) {
          output += STRING + value + RESET;

          output += INTERPOLATION + "${" + RESET;
          i += 2;

          let depth = 1;
          let expression = "";

          while (i < source.length && depth > 0) {
            const currentChar = source[i];

            if (currentChar === "{") {
              depth++;
            } else if (currentChar === "}") {
              depth--;

              if (depth === 0) {
                break;
              }
            }

            expression += currentChar;
            i++;
          }

          output += highlightCode(expression);

          if (source[i] === "}") {
            output += INTERPOLATION + "}" + RESET;
            i++;
          }

          value = "";
          continue;
        }

        value += current;
        i++;

        if (current === quote) {
          break;
        }
      }

      output += STRING + value + RESET;
      continue;
    }

    // Parentheses
    if (ch === "(" || ch === ")") {
      output += PAREN + ch + RESET;
      i++;
      continue;
    }

    // Square brackets
    if (ch === "[" || ch === "]") {
      output += BRACKET + ch + RESET;
      i++;
      continue;
    }

    // Curly braces
    if (ch === "{" || ch === "}") {
      output += BRACE + ch + RESET;
      i++;
      continue;
    }

    // Integer literals
    if (/[0-9]/.test(ch)) {
      let number = ch;
      i++;

      while (
        i < source.length &&
        /[0-9]/.test(source[i])
      ) {
        number += source[i];
        i++;
      }

      output += NUMBER + number + RESET;
      continue;
    }

    // Identifiers / keywords / builtins / types
    if (isIdentifierStart(ch)) {
      let word = ch;
      i++;

      while (
        i < source.length &&
        isIdentifierPart(source[i])
      ) {
        word += source[i];
        i++;
      }

      if (KEYWORDS.includes(word)) {
        output += KEYWORD + word + RESET;
      } else if (TYPES.has(word)) {
        output += TYPE + word + RESET;
      } else if (BUILTINS.has(word)) {
        output += BUILTIN + word + RESET;
      } else {
        output += IDENTIFIER + word + RESET;
      }

      continue;
    }

    output += ch;
    i++;
  }

  return output;
}

export default highlightCode;