# Zen Architecture

Zen is a statically-typed, ahead-of-time compiled programming language. The compiler is written in Node.js and emits LLVM IR. The runtime is written in C and linked into every compiled program.

**Current stable version:** 3.0.0
**Supported platforms:** Linux and macOS. Windows support is in progress.

## About this document

This document explains how the compiler is structured, so you know where a change belongs before you open the code. It covers the compilation pipeline, where each feature lives, how types and values are represented, and how to add a builtin or debug the generated IR.

It is not a language tutorial. For the language itself, see the README, or run `zen info global <Name>` for the API of any builtin type.

## Sections

1. Compilation pipeline
2. Repository layout
3. Type inference
4. Value model
6. Adding to the language
7. Testing and debugging
8. Internal toggles
9. Summary

## Compilation pipeline

The compiler is a Node.js program that turns Zen source into LLVM IR, then uses the standard LLVM/clang toolchain to produce a native executable.

```
.zen source
   │  Lexer       src/lexer/lexer.js
   ▼
tokens
   │  Parser      src/parser/parser.js
   ▼
AST
   │  CodeGen     src/codegen/codegen.js (+ helper/, infer/, lib/)
   ▼
LLVM IR           build/<name>.ll
   │  opt         optimization pass
   ▼
build/<name>_opt.ll
   │  llc         -filetype=obj -relocation-model=pic
   ▼
build/<name>.o
   │  clang       links everything listed below
   ▼
build/<name>      native executable
```

### Entry point

`bin/zen.js` calls `cli/cli.js`, which parses the command and runs `Compiler.compile()` in `tooling/tooling.js`. Every command (`run`, `build`, `ir`, `ast`, `tokens`, `lint`, `fmt`, `clean`) goes through this function and stops at the stage it needs.

### Input

The compiler accepts a single `.zen` file, a project directory with a `zen.json` (its `main` field names the entry file) or zen package

### What gets linked

| Part | Source |
| --- | --- |
| Your program | `build/<name>.o` |
| Imported modules | each module's `.ll`, compiled with `llc` |
| Standard library | `src/zen_stdlib/constants` and `zen_stdlib_opt` |
| C runtime | `src/codegen/runtime/`: `runtime`, `listRuntime`, `mapRuntime`, `curlRuntime`, `httpRuntime`, `jsonRuntime`, `tcp` |
| Native code | `.c` or `.o` files from `zen.json` `native`, plus `--link` |
| Libraries | `-lm`, `-lcurl`, `-lcrypto`, plus extra `--flags` |

Runtime and stdlib parts use a prebuilt `.o` if one exists next to the source, and are compiled from `.c` or `.ll` otherwise. Native `.c` files are compiled with `clang` into `build/`.

### Requirements

LLVM tools (`opt`, `llc`), `clang`, and libcurl and OpenSSL development libraries must be installed. On Termux the linker adds an rpath from `$PREFIX/lib`.

## Repository layout

```
zen/
├── bin/
│   ├── zen.js              CLI entry point
│   └── lsp.js              language server
├── cli/cli.js              command parsing and dispatch
├── pkg/package.js          package manager (install, publish, login, search, ...)
├── src/
│   ├── lexer/              source text → tokens
│   ├── parser/             tokens → AST
│   ├── config/
│   │   ├── config.js       type maps, builtin registries, std function schemas
│   │   └── info_config.js  docs shown by `zen info`
│   ├── codegen/
│   │   ├── codegen.js      walks the AST and dispatches by node type
│   │   ├── helper/         IRBuilder: temps, scopes, structs, errors, builtin calls
│   │   ├── infer/          type inference
│   │   ├── lib/            one file per language feature (see below)
│   │   │   └── builtins/   builtin namespaces: io, string, time, os, http, ...
│   │   └── runtime/        C runtime linked into every program
│   └── zen_stdlib/         standard library (stdlib.zen + precompiled IR)
├── tooling/
│   ├── tooling.js          Compiler class: the whole compile and link pipeline
│   ├── fmt/                formatter
│   ├── lint/               linter
│   ├── info/               `zen info`
│   └── tests/              example programs and test runner
├── errors.md               error reference
└── changelog.md
```

### `src/codegen/lib/`

Each language feature has its own file: `variable`, `function`, `call`, `expression`, `list`, `loop`, `conditional`, `switch`, `ternary`, `struct`, `enum`, and the module system (`moduleAnalyser`, `moduleFiles`). `codegen.js` looks at the AST node type and hands it to the matching file.

### Where does a change go?

| I want to... | Edit |
| --- | --- |
| Add a CLI command | `cli/cli.js` (and `tooling/tooling.js` if it needs the compiler) |
| Add syntax | `lexer.js`, `parser.js`, then the matching file in `codegen/lib/` |
| Change type inference | `codegen/infer/infer.js` |
| Add a method to a builtin type (`Map`, `Json`, `Tcp`, ...) | the builtin struct method registry in `config.js`, plus a C function in `codegen/runtime/` |
| Add a builtin function or namespace | `codegen/lib/builtins/<name>/`, registered in `config.js` |
| Change how a builtin appears in `zen info` | `config/info_config.js` |
| Change an error message | the `emitError` call site; the function itself is in `helper/helper.js` |
| Change the C runtime | `codegen/runtime/*.c` (and the list of runtime files in `tooling.js` if you add one) |
| Change the standard library | `zen_stdlib/stdlib.zen` |
| Work on the formatter, linter or language server | `tooling/fmt`, `tooling/lint`, `bin/lsp.js` |
| Work on the package manager | `pkg/package.js` |

## Type inference

Zen is statically typed, but you can leave the type out with `auto`. `src/codegen/infer/infer.js` works out the type from the expression.

```
auto name = m.getString("a")      // string

fn twice(int x) auto {           // return type inferred from the return
  return x * 2                    // int
}
```

### Where inference runs

- `auto` variable declarations
- `auto` function return types
- Elements of list literals, and expressions inside them, so `[m.getString("a")]` and `[x + 1]` are checked against the declared `List<T>`
- Operands of binary, unary and ternary expressions

The entry point is `InferType.infer(node, context)`. It returns the type name as a string (`"int"`, `"string"`, a struct name) and caches it on `node.inferredType`.

### Context

| Context | Meaning |
| --- | --- |
| `normal` | The type is only being checked. Any type is allowed. |
| `auto` | Inferring for an `auto` variable. |
| `fnret` | Inferring for an `auto` function return. |

In `auto` and `fnret`, only `int`, `long`, `byte`, `double`, `bool` and `string` can be inferred. Lists, structs and fixed arrays need an explicit type, and the compiler says so. For `fnret`, the type comes from the function's top-level `return` statement. A function with no return is `void`.

### Type rules

- **Literals:** the type of the literal.
- **Variables and array access:** the declared type of the variable.
- **Binary arithmetic:** a `string` on either side gives `string`. Otherwise numeric types are promoted to the wider one (`byte` < `int` < `long` < `double`).
- **Comparison and logical operators:** `bool`.
- **Bitwise operators:** `int` or `long` only.
- **Ternary:** both branches must have the same type, and the condition must be `bool`.
- **List literals:** all elements must have the same type.

### Resolving calls

A `CALL` node is resolved in one of three ways:

1. **Namespace function** (`time.now()`, `io.screen()`): looked up in the namespace registry.
2. **Method call** (`obj.method()`):
   - If `obj` is a builtin struct, the method is looked up in the builtin struct method registry in `config.js`.
   - Otherwise it is a user struct, and the compiler finds the function named `<Struct>_<method>`.
3. **Plain function** (`foo()`): standard library functions and builtins first, then user functions.

Member access without parentheses (`req.method`, `point.x`) goes through `inferMemberAccess`. User structs are resolved from their field layout. Builtin properties are resolved from the builtin struct property registry.

### Why builtin types take a separate path

User structs have a field layout, and their methods are real compiled functions named `<Struct>_<method>`, so inference finds them like any other function. Builtin structs (`Map`, `Json`, `Tcp`, `HttpRequest`, ...) have no field layout and no compiled function of that name. They exist only as entries in the registry in `config.js`, and the generated code calls a C runtime function directly.

Any inference code that looks up a method must therefore check the builtin registry first. If it only calls `getFunction("Map_getString")`, it fails with `Function 'Map_getString' is not defined`. When adding a builtin type, make sure its methods and properties are in the registry, or inference will not see them.

## Value model

Zen values are stored in one of two ways.

### Primitives and user structs: by value

`int`, `long`, `byte`, `double`, `bool` are plain LLVM values. User-defined structs have value semantics.

### Opaque builtins: by pointer

Builtin types such as `Map`, `Json`, `JsonArray`, `JsonObject`, `Tcp`, `TcpServer`, `HttpServer`, `HttpRequest` and `HttpResponse` are declared as opaque LLVM types (`%Map = type opaque`). The object itself lives in the C runtime. A Zen variable, struct field, or list slot holds only a **pointer** to it.

```
variable m  ──►  [ ptr ] ──►  Map object (C runtime)
list slot 0 ──►  [ ptr ] ──►  Map object (C runtime)
```

Strings and nested lists are stored the same way: the slot holds a pointer.

### Lists return element addresses

`_zen_list_get(list, i)` returns the **address of the slot** inside the list, not the stored value. To get the element you read through that address, as the runtime does with `*(char **)_zen_list_get(list, i)`.

For an opaque element such as a `Map`, that means one `load ptr` is needed to get the real object pointer. Passing the slot address to a map function directly makes the keys look missing.

### Compiler flags

Codegen tracks this with flags on the value it returns:

| Flag | Meaning |
| --- | --- |
| `isStruct` | The type is a struct (user-defined or builtin). |
| `isOpaque` | The struct is a builtin with no field layout. It is declared with `isBuiltin` and `isOpaque`. |
| `needsLoad` | `ptr` is an address that must be loaded before use. |

For an opaque element read from a list, `isStruct` is true and `needsLoad` is true. Code that handles member access (`l[0].has("a")`) checks for this and emits the `load`.

## Adding to the language

There are four ways to extend Zen. Check `src/config/config.js` carefully each time, since each addition needs entries in the right objects and arrays.

### 1. A standard library function (written in Zen)

1. Register it in `config.js`, in the appropriate objects and arrays.
2. Write the function in `src/zen_stdlib/stdlib.zen`:

```
fn isEven(int n) bool {
  return n % 2 == 0
}
```

Write the plain name. The compiler mangles it automatically with a stdlib-style prefix.
Make sure the stdlibMode in helper (IRB) should be true before compile the stdlib.zen.

### 2. A compiler-generated builtin function

This works like a stdlib function, except the compiler emits the IR itself, so some paths in `config.js` differ.

1. Register it in `config.js`.
2. Add a `case` for it in the builtin registration method in `src/codegen/lib/call.js`.
3. Implement its behavior in JavaScript, emitting IR.

### 3. A namespace function (implemented in C)

Namespaces (`fs`, `time`, ...) follow the naming scheme `_<namespace>_<function>`, for example `_fs_readFile`.

1. Register it in `config.js`.
2. Implement a C function with that exact name in the runtime:
   - functions that return a list go in `codegen/runtime/listRuntime.c`
   - everything else goes in `codegen/runtime/runtime.c`

The runtime may be split into more files in the future.

### 4. A builtin struct (`Map`, `Json`, `Tcp`, ...)

1. In `src/codegen/helper/helper.js`, add the struct in `registerBuiltins` on `IRBuilder`, and say whether it is opaque. `initBuiltinStructs` calls it.
2. Add its methods and properties to the builtin struct method and property registries in `config.js`. Each entry has a return type, argument types and the C function name (`llvmName`).
3. Implement the C functions in the runtime. If you add a new `.c` file, also add it to the runtime file list in `tooling/tooling.js` so it gets linked.

Opaque structs are held by pointer, so read the value model section before adding one.

### Finishing up

- Add documentation so it shows up in `zen info` (`src/config/info_config.js`).
- Add an example program to `tooling/tests/examples/`.

## Testing and debugging

### Stopping at each stage

Each command runs the pipeline up to a point and stops there:

| Command | Stops after |
| --- | --- |
| `zen tokens file.zen` | the lexer (prints tokens) |
| `zen ast file.zen` | the parser (prints the AST) |
| `zen lint file.zen` | the linter |
| `zen ir file.zen` | code generation (prints the LLVM IR; nothing is built or run) |
| `zen build file.zen` | linking (produces the executable, does not run it) |
| `zen run file.zen` | runs the executable after building it |

### The build directory

Everything the pipeline produces is kept in `build/` next to your source:

| File | What it is |
| --- | --- |
| `<name>.ll` | generated LLVM IR |
| `<name>_opt.ll` | IR after `opt` |
| `<name>.o` | object file from `llc` |
| `<name>` | the final executable |

`zen clean` deletes the directory.

### Running the tests

- `zen test` runs the official Zen test suite.
- `zen test <pkgName>` finds the installed package and runs its `test.zen`.

### Compiler stack traces

By default the compiler reports Zen errors in a readable format. To see the underlying Node.js stack trace of the compiler itself, set `diagnosticMode` to `true` in the `IRBuilder` constructor in `src/codegen/helper/helper.js`. This is useful when debugging the compiler, but leave it off for normal use.

### Debugging workflow

1. Shrink the failing program to the smallest repro, a few lines.
2. Read the stack trace. The frame names show which stage failed (`InferType.infer`, `Expression.handleExpression`, `ZenList.list`, ...).
3. If the compiler produced wrong behavior instead of an error, read `build/<name>.ll` and compare it with what the source should do. A missing `load`, or a wrong pointer passed to a runtime function, shows up directly in the IR.
4. Check the value model flags (`isStruct`, `isOpaque`, `needsLoad`) at the point where the value is produced.
5. Keep the repro as a test.

## Internal toggles

Two flags in the `IRBuilder` constructor (`src/codegen/helper/helper.js`) are for compiler development only. They are not CLI flags, and users should never need to change them.

```js
this.diagnosticMode = false; // compiler debugging
this.stdlibMode = false;     // compiling stdlib.zen
```

| Flag | Default | Purpose |
| --- | --- | --- |
| `diagnosticMode` | `false` | Controls how compiler errors are reported |
| `stdlibMode` | `false` | Marks that `stdlib.zen` is being compiled |

### `diagnosticMode`

- `false`: errors are shown as readable Zen errors (`[Zen Error] ImportError: ...` with the line and a hint).
- `true`: the raw Node.js stack trace of the compiler is shown. Use it to find which compiler stage and function failed (`InferType.infer`, `Parser.expect`, ...).

It must be `false` in any release build, otherwise users see compiler internals instead of Zen errors.

### `stdlibMode`

- Set it to `true` only while compiling `src/zen_stdlib/stdlib.zen`. In this mode function names get the stdlib mangling prefix, so you write plain names such as `isEven` in `stdlib.zen`.
- It must be `false` for every other compile, including user programs and modules.

If you change either flag while working, set it back before you commit or release.

## Summary

Zen compiles in three stages inside one Node.js program (lexer, parser, code generation) and finishes with the LLVM toolchain and a C runtime. Most changes touch one of three places: a feature file in `src/codegen/lib/`, a registry in `src/config/config.js`, or a function in the C runtime.

Two ideas explain most compiler bugs:

- **Builtin types have no compiled functions.** They exist as registry entries, so any code that looks up methods must check the registry.
- **Opaque builtins are held by pointer.** A list element or variable holds the pointer, and the address you get back may need a `load` before use.

When something goes wrong, shrink it to a few lines, read the stack trace, and check `build/<name>.ll`. Keep the repro as a test in `tooling/tests/examples/`, and record user-visible changes in `changelog.md`.