<div align="center" markdown="1">

# ZEN Programming Language

**Statically typed · AOT compiled · LLVM backend**
<br>
**Version 3.0.0 · Stable · October 2026**

![Version](https://img.shields.io/badge/version-3.0.0-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/status-stable-brightgreen?style=for-the-badge)
![Released](https://img.shields.io/badge/released-October%202026-orange?style=for-the-badge)
![LLVM](https://img.shields.io/badge/LLVM-20%2B-purple?style=for-the-badge)

![Termux](https://img.shields.io/badge/Termux-Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-apt%20%7C%20pacman%20%7C%20dnf%20%7C%20zypper-FCC624?style=for-the-badge&logo=linux&logoColor=black)

[![GitHub](https://img.shields.io/badge/GitHub-Jishith--dev%2FZen-181717?style=for-the-badge&logo=github)](https://github.com/Jishith-dev/Zen)
[![Issues](https://img.shields.io/github/issues/Jishith-dev/Zen?style=for-the-badge&color=red)](https://github.com/Jishith-dev/Zen/issues)
[![Contact](https://img.shields.io/badge/Contact-jishithmp534%40gmail.com-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:jishithmp534@gmail.com)

</div>

---

## Installation

```bash
curl -fsSL https://raw.githubusercontent.com/Jishith-dev/Zen/main/install.sh | bash -s -- --branch dev -y
```

Installer options (pass after `bash -s --`):

| Option | What it does |
|---|---|
| `--tag <tag>` | Install a specific release tag (default: latest release) |
| `--branch <name>` | Install from a branch (latest commit, no VERSION check) |
| `--prefix <dir>` | Where to put the `zen` symlink (default: `~/.local/bin`) |
| `--force` | Reinstall even if the same ref is already installed |
| `-y`, `--yes` | Answer yes to all prompts and auto-install dependencies |
| `--no-rc-edit` | Don't edit shell rc files to add PATH |
| `--h`, `--help` | Show installer help |

Requires: `git`, `node`, `pkg-config`, LLVM 20+ (`clang`, `llc`, `opt`) and libcurl headers. The installer sets these up for you with `-y`. Windows is not supported yet (use WSL).

## Issues

Found a bug or have an idea? [Open a GitHub issue](https://github.com/Jishith-dev/Zen/issues).

---

## Introduction

ZEN is a statically compiled, LLVM-based programming language built around one principle: **every construct must have a deterministic representation in the compiler.** If it cannot be precisely defined, it does not exist in the language.

ZEN is an open-source programming language, and its development is open to everyone. Whether you are a compiler enthusiast, a language designer, or simply curious about how programming languages work at a fundamental level, you are welcome to explore, contribute, and build with ZEN. The source code, compiler implementation, and this specification are all publicly available. Contributions in any form — bug reports, suggestions, tooling, or improvements to the language itself — are valued and encouraged. ZEN is built in the open, and its future is shaped by everyone who chooses to be part of it.

---

## Origin

ZEN was designed and implemented by **Jishith** as an independent programming language project.

The language grew out of a practical need: a compiler-oriented system that behaves predictably from source to binary. Early work focused on LLVM IR generation and formal lexical rules; over time this evolved into a complete language definition — with a structured grammar, a well-specified type system, and a compilation pipeline designed for clarity over cleverness.

The name *ZEN* reflects the design philosophy directly. Not as metaphor, but as method: simplicity achieved through deliberate reduction, not accident.

---

## Philosophy

> *If it cannot be precisely defined, it does not exist in the language.*

This constraint drives every decision in ZEN's design:

- **No ambiguous behavior.** Every expression evaluates to exactly one outcome, defined at compile time.
- **No hidden transformations.** The compiler does not silently rewrite code. What you write is what executes.
- **No syntactic sugar beyond specification.** Convenience constructs are not added unless they can be fully and formally defined.

The language is designed from the compiler's perspective first. Ease of implementation and correctness of semantics take precedence over surface-level ergonomics. This makes ZEN well-suited for systems-level work, compiler tooling, and any domain where predictability matters more than brevity.

---

## Design Goals

| Goal | Description |
|---|---|
| **Minimal syntax surface** | The language avoids redundant keywords and constructs with overlapping semantics. |
| **Deterministic semantics** | Compile-time and runtime behavior are fully specified; no undefined behavior. |
| **Compiler-first design** | Language constructs are designed for implementation clarity and unambiguous parsing. |
| **LLVM intermediate target** | ZEN compiles to LLVM IR as its primary intermediate representation. |
| **Structural programming model** | Explicit logic construction with no hidden control flow. |

---

## Version

Current Version: v3.0.0

---

### v3.0.0

- Breaking: `toString()` / `toInt()` renamed to `intToAscii()` / `asciiToInt()`
- Breaking: `private` is now a reserved keyword; keyword `in` removed
- Breaking: classic loops must use `loop (init, cond, update)`
- Breaking: `zen tests` renamed to `zen test`, `zen -v` changed to `zen --v`
- Breaking: `fs.writeFileBytes()` now returns `int`; `sqrt()` takes and returns `double`
- Formalized numeric widening: `byte` → `int` → `long` → `double`
- `bool` works in arithmetic and bitwise operations
- Added bitwise operators `&`, `|`, `>>`, `<<`, `~` and unary `+`
- Added compile-time constants and `sizeOf()` for types and expressions
- Struct field default initializers; uninitialized structs get zero-value fields
- Added `private` fields and methods
- Added anonymous inline callbacks (no closures); named functions can use closures
- Thread functions accept parameters; added thread methods in structs
- Added multiple exports and imports per file, and import aliasing for functions and variables
- Struct dependency tracking with hidden dependency structs
- Added scientific notation for `double` literals
- Signed `byte` (-128 to 127), hex suffix rules (`0xFB_B`, `0xFF_L`)
- Added `\e` and `\xHH` string escapes
- Added `Json.map()` with runtime overflow checks for `getInt()`, `getByte()`, `getLong()`
- Added List methods: `remove()`, `reverse()`, `sort()`, `sum()`, `avg()`, `flat()`
- Added `Map.keys()` and `Map.entries()`
- Added `lastIndexOf()`, `stringToBytes()`, `bytesToString()`
- Added `fs.listDir()`, `fs.isFile()`, `fs.isDir()`
- Added `sys.spawn()`, `sys.kill()`, `sys.isRunning()`, `sys.wait()`
- Added `threads.count()` and `threads.currentId()`
- Added TCP networking: `Tcp`, `TcpServer`, `net.online()`, `net.connect()`, `net.listen()`
- Added `http.getProgress()` for downloads with progress reporting
- Added HTTP timeouts and `HttpRequest.getHeader()`
- Added `zen test`, `zen info`, `zen read`, `zen installed`, `zen upgrade`, `zen update --dev`
- `zen install` and `zen uninstall` accept multiple packages and `pkg@semver`
- `zen deps` detects native objects; `.c` files supported as native dependencies
- Added `zen.json` `flags` and `--link` for native linking
- Added interactive REPL (`zen` with no arguments)
- Enhanced LSP (`zen lsp`), formatter and linter
- Better compile-time diagnostics with hints and source text
- Installer: added `--tag` and `--branch` modes
- Windows support temporarily paused
- Several compiler, CLI, registry, and runtime bug fixes

---

## Host Language

Zen's compiler is implemented in **JavaScript** and runs on **Node.js**. The compiler emits LLVM IR, which is then compiled to native machine code using the LLVM toolchain.

### Dependencies

The installer (`install.sh`) installs all of these automatically when run with `-y`. Install them manually only if you are building by hand.

| Dependency | Purpose |
|------------|---------|
| `git` | Downloads Zen and registry packages |
| `node` | Runs the Zen compiler |
| `clang` | Compiles the runtime and links native binaries |
| `llvm` 20+ | Provides `llc` and `opt` (tested up to LLVM 30) |
| `pkg-config` | Locates libcurl |
| libcurl dev headers | Needed to build the HTTP and TCP runtime |

### Installing Dependencies

#### Termux (Android)
```bash
pkg install git nodejs clang llvm pkg-config libcurl
```

#### Ubuntu / Debian
```bash
sudo apt install git nodejs pkg-config libcurl4-openssl-dev wget gnupg
wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh
sudo ./llvm.sh 21 all
```
The default `llvm` package in apt is often older than 20, so install LLVM 21 from apt.llvm.org as shown.

#### Arch Linux
```bash
sudo pacman -S git nodejs clang llvm pkgconf curl
```

#### Fedora
```bash
sudo dnf install git nodejs clang llvm pkgconf-pkg-config libcurl-devel
```

#### openSUSE
```bash
sudo zypper install git nodejs clang llvm pkg-config libcurl-devel
```

#### macOS
```bash
brew install git node llvm curl pkg-config
```

---

#### Windows

Native Windows is not supported yet. Use WSL and follow the Ubuntu / Debian steps above.

---

## CLI Usage

Zen provides a comprehensive command-line interface for compiling, inspecting, running, testing, package management, and project scaffolding. Running `zen` with no arguments opens the interactive REPL (type `exit()` to quit).

### Compilation & Development

```bash
zen run <file>             # Compile and run program
zen build <file>           # Build executable binary
zen ir <file>              # Generate LLVM IR
zen ast <file>             # Print Abstract Syntax Tree
zen tokens <file>          # Print lexer tokens
zen clean                  # Remove build artifacts
zen fmt <file> [--r]       # Format code 
zen lint <file>            # Show errors and warnings
zen test                   # Run tests
zen test <package>         # Run an installed package's test.zen
zen lsp                    # Start the language server (used by editors)
```

---

## Zen formatter

Formats `.zen` files. Output goes next to the source as `name.formatted.zen`
(the original is never touched).

### Usage

    zen fmt <path...> [-r | --recursive] [--no-comments]

| Command                  | What it formats                                  |
|--------------------------|--------------------------------------------------|
| `zen fmt a.zen`          | one file                                         |
| `zen fmt a.zen b.zen`    | several files                                    |
| `zen fmt src`            | `.zen` files directly inside `src`               |
| `zen fmt src -r`         | everything under `src`, all subfolders           |
| `zen fmt . -r`           | the whole project                                |
| `zen fmt *.zen`          | shell glob, works as normal multiple paths       |

### Flags

- `-r`, `--recursive`  descend into subdirectories (flag position doesn't matter)
- `--no-comments`      drop comments from the output

### Rules

- Skipped always: `*.formatted.*` files (so re-running never formats its own output)
- Skipped when recursing: `node_modules`, `build`, `.git`, `.zen`
- Duplicate paths are formatted once
- Errors: `Path not found: <path>` if an input doesn't exist,
  `No .zen files found` if nothing matched

### Breaking change

The old `dir/*` and `dir/**` syntax is removed. The shell expanded them
before zen saw them. Use `dir` and `dir -r` instead.

---

### Built-in Reference

```bash
zen info global <name>                 # Docs for a global function
zen info namespace <name>              # Docs for a namespace
zen info namespace <name> --<method>   # Docs for one method (e.g. zen info namespace http --getProgress)
```

### Project Management

```bash
zen init <name>            # Create a new runnable Zen project
zen init <name> --bin      # Create a new library Zen package
```

### Package Registry

```bash
zen install <package> [more...]   # Install one or more packages
zen install <package>@<semver>    # Install a specific version
zen uninstall <package> [more...] # Remove one or more installed packages
zen upgrade <package>             # Upgrade an installed package
zen installed                     # Show installed package count
zen read <package> [--raw]        # Render a package README in the terminal
zen search <package>              # Search packages
zen kind <package>                # Show package kind (main/bin)
zen mine                          # List your published packages
zen publish                       # Publish/update your package
zen unpublish                     # Remove your package from registry
zen list                          # Browse all available packages
zen deps                          # Generate dependencies (also detects native/*.o)
```

### Updating Zen

```bash
zen update                 # Update to the latest release without the original install command
zen update --dev           # Update to the dev version
```

### Authentication

```bash
zen signup                 # Create a Zen Registry account
zen login                  # Login to your account
zen whoami                 # Show currently logged-in user
zen logout                 # Logout and remove credentials
zen recovery               # Recover forgotten password
```

### Help & Version

```bash
zen --help                 # Show help menu
zen --h                     # Show help menu (short form)
zen help                   # Show help menu (verbose)
zen --version              # Show Zen version
zen --v                    # Show Zen version (short form)
zen version                # Show Zen version (verbose)
zen --v <package>          # Show an installed package's version
zen --version <package>    # Same as above
zen version <package>      # Same as above
```

### Compilation Flags

Optimization level (for `run` and `build`):

```bash
zen run <file> -O0         # No optimization
zen run <file> -O1         # Basic optimization
zen run <file> -O2         # Standard optimization (default)
zen run <file> -O3         # Aggressive optimization

zen build <file> -O0       # No optimization
zen build <file> -O1       # Basic optimization
zen build <file> -O2       # Standard optimization (default)
zen build <file> -O3       # Aggressive optimization
```

Native linking:

```bash
zen run <file> --link a.o b.o      # Link extra object files
zen run <file> --flags -lmariadb   # Pass extra linker flags
```

### Examples

Compile and run a single file:

```bash
zen run hello.zen
```

Build a project into binary:

```bash
zen build myapp
# Creates: ./build/myapp
```

Create a new project:

```bash
zen init calculator
cd calculator
zen run main.zen (or entry file)
```

Create a library package:

```bash
zen init string-utils --bin
```

Install and use packages:

```bash
zen install banking calculator
zen install banking@1.2.0
zen read banking
```

Publish your package:

```bash
zen publish
# Publishes package defined in zen.json
```

Browse registry:

```bash
zen list
# Shows packages with pagination
```

---

## Notes

- All build artifacts are stored inside the `build/` directory.
- Zen compiles to native binaries using LLVM.
- `zen init <name>` creates a project directory containing a starter `main.zen` file and a `zen.json` project configuration.
- Each command is designed for development, debugging, and compilation workflows.

---

## Examples

### Hello World

```zen
screen("Hello World!")
```

### Simple Variables

```zen
string name = "Zen"
const int age = 21
const List<int> a
const Person p

screen(name)
screen(`Age: ${age}`)
```

### Loop Example

```zen
loop (int i = 0, i < 10, i++) {
  screen(i)
}
```

---

### Compilation Flow

```bash
zen tokens main.zen     # Lexical analysis
zen ast main.zen        # Parse into AST
zen ir main.zen         # Generate LLVM IR
zen build main.zen      # Build executable
zen run main.zen        # Compile and run directly
```

---

## Errors

See [errors.md](errors.md) for all error types.

---

## Reactive Variables

Zen introduces a first-class language feature called **reactive variables** — variables that automatically recompute their value whenever a referenced variable changes.

### Syntax

```zen
reactive <type> <identifier> = <expression>
```

```zen
int b = 20
reactive int a = b + 10   # a is 30

b = 50                     # a automatically becomes 60
```

---

### How It Works

A `reactive` variable holds a **live binding** to its defining expression. Rather than capturing the value at the time of declaration, it captures the expression itself. Any time a variable referenced in that expression is reassigned, the reactive variable recomputes.

```zen
int x = 5
int y = 10
reactive int sum = x + y   # sum is 15

x = 20                      # sum is now 30
y = 2                       # sum is now 22
```

---

### Rules and Constraints

**Only variable reassignment triggers recomputation.**
A reactive variable updates only when a referenced variable is reassigned via `=`. Mutations that do not go through reassignment do not trigger an update.

**`const` variables do not trigger updates.**
Since `const` variables cannot be reassigned, a reactive expression that references only `const` values behaves as a regular variable — it is computed once at declaration and never again.

```zen
const int base = 100
reactive int val = base + 50   # val is 150 — never updates, base is const
```

**Reactive variables work on variable references only.**
The expression must reference named variables. Expressions that reference only literals are legal but pointless — they will never recompute.

```zen
reactive int x = 5 + 3   # always 8 — no variable to trigger recomputation
```

**A reactive variable cannot be manually reassigned.**
Once declared as `reactive`, its value is exclusively owned by its expression. Direct reassignment is a compile-time error.

```zen
reactive int a = b + 10

a = 99   # compile-time error: cannot manually assign to a reactive variable
```

**Reactive variables can reference other reactive variables.**
A chain of reactive dependencies is fully supported. Updates propagate through the chain in declaration order.

```zen
int base = 10
reactive int doubled = base * 2     # 20
reactive int final   = doubled + 5  # 25

base = 20   # doubled → 40, final → 45
```

---

### Summary

| Property | Behavior |
|---|---|
| Trigger | Reassignment of a referenced variable |
| `const` references | No trigger — computed once |
| Manual reassignment | Compile-time error |
| Chained reactives | Supported — propagates in order |
| Expression type | Variable references only |

---

## Threads

Zen supports real concurrent threads: each thread runs in parallel with the rest of the program.

### Thread Functions

Thread functions are declared with the `thread` keyword and are started like a normal function call.

```zen
thread fn worker(string name, int count) {
    screen(`${name} running ${count} times`)
}

worker("A", 3)
worker("B", 5)

threads.waitAll()
```

#### Rules

- Thread functions can accept parameters.
- Thread functions cannot return a value (only `void` is allowed).
- Struct methods can also be threads: `thread run(int a) {}`.
- Thread functions and thread methods can be exported and imported.

> ⚠️ **Race Conditions:** Threads run truly concurrently. If multiple threads modify the same data at the same time, race conditions may occur. Use shared state carefully.

---

## Enumerations (enum)

Zen provides **enumerations (`enum`)** for defining a fixed set of named constant integer values.

### Syntax

```zen
enum <Name> {
    value1,
    value2,
    value3 = 10
}
```

### Example

```zen
enum Color {
    green,
    red,
    blue = 3
}

screen(Color.green)   # 0
screen(Color.red)     # 1
screen(Color.blue)    # 3
```

### Rules

- Enum values must be constant integers.
- Values without an explicit assignment are automatically incremented.
- Only single-value enum members are supported.

---

## Semantics

Zen distinguishes between **value semantics** and **reference semantics**.

### Value Semantics

User-defined structs use **value semantics**. Assigning a struct or passing it to a function creates a copy of the value.

```zen
Person a = ...
Person b = a   # b is an independent copy
```

Primitive types (`int`, `long`, `double`, `bool`, and `byte`) also behave as values.

### Reference Semantics

The following types use **reference semantics**:

- `string`
- `List`
- `Map`
- `Json`
- `JsonObject`
- `JsonArray`
- `HttpServer`
- `HttpRequest`
- `HttpResponse`
- `Tcp`
- `TcpServer`
- `Ptr`

Assigning or passing one of these values copies only a reference to the underlying object rather than duplicating the object itself. This is required because these types represent runtime-managed resources or dynamically allocated data.

### Memory Management

Primitive values (`int`, `long`, `double`, `bool`, and `byte`) require no manual memory management. They are stored in local or global storage managed by the compiler.

Strings and the reference-semantic built-in types allocate heap memory or runtime resources, and therefore provide a `free()` method. Where a built-in type requires explicit cleanup, it is documented alongside that type's API.

Using an object after it has been freed is caught at compile time. If the compiler cannot determine it statically, the runtime detects it and raises a `MemoryError`.

### Ownership

Reference-semantic types follow **ownership semantics**.

The object that creates or owns a runtime resource is responsible for releasing it by calling `free()`. Child objects, borrowed references, or values obtained from another object must **not** be freed directly.

```zen
Map parent
Map child = parent.getMap("child")

parent.free()   # Correct
child.free()    # Illegal
```

Whenever possible, the compiler diagnoses ownership violations at compile time. If a violation cannot be determined statically, the runtime detects the error and terminates execution.

After an object has been freed, it immediately becomes invalid. Any attempt to access it, modify it, or free it again is illegal.

In short, **the parent owns the lifetime of all of its children**. Only the owner of a runtime resource is permitted to destroy it.

---

### String Semantics

`string` is a reference-semantic type.

**All strings in Zen are heap-allocated** (created with `strdup`), including string literals. A string variable holds a reference to heap memory containing the string data. Assigning or passing a string copies the reference rather than duplicating the underlying data, so aliases refer to the same string.

Temporary strings, such as the intermediate results of concatenation, are freed automatically by the compiler. A string stored in a variable is owned by that variable and can be released with `free()` when it is no longer needed.

```zen
string name = "Jishith"
string alias = name   # alias refers to the same string

name.free()           # alias is now invalid too
```

---

### Heap Memory Release

Every heap-owned type in Zen provides a `.free()` method for explicitly releasing the memory it owns.

> **Any type that owns heap-allocated memory must expose `.free()` to release that memory.**

This provides a consistent and explicit ownership model across Zen's type system.

---

## Scope of This Specification

Version 3.0.0 defines the **stable core** of the language:

- Lexical structure and token definitions
- Grammar and core syntax rules
- Primitive and composite data types (including numeric widening and bitwise operators)
- Variable, reactive variable, enum, and struct declarations
- Function definitions, callbacks, and threads
- Module import/export system
- Control flow constructs
- Built-in HTTP client and HTTP server APIs
- Built-in TCP networking API
- Built-in JSON API
- Built-in time, system, and operating system APIs
- Built-in cryptographic API
- Built-in filesystem and path APIs
- Native interop (FFI and native object linking)
- Compilation and evaluation model

Future versions will continue expanding the standard library, language features, and compiler optimizations.

---

## Lexical Structure

The ZEN compiler reduces source text into a flat sequence of tokens before any parsing occurs. Each token carries four fields: a **type** and a **value** and **line** and **column**. All subsequent grammar rules operate on this token stream, never on raw source characters.

---

### 2.1 Source Encoding

ZEN source files are plain text. The language does not mandate a specific file encoding beyond ASCII compatibility for all reserved symbols and keywords. Identifiers and string contents may contain extended characters at the implementation's discretion.

---

### 2.2 Whitespace

Whitespace — spaces, tabs, and newlines — carries no syntactic meaning in ZEN and is fully discarded during tokenization. It serves only to separate adjacent tokens where ambiguity would otherwise arise.

```zen
int x = 10       # same token stream as:
int x=10
```

---

### 2.3 Comments

Comments are stripped during tokenization and produce no tokens. ZEN supports three comment forms:

| Form | Syntax | Scope |
|---|---|---|
| Hash line comment | `# comment` | From `#` to end of line |
| Slash line comment | `// comment` | From `//` to end of line |
| Block comment | `/* comment */` | Across any number of lines |

Both single-line forms are equivalent. Neither is preferred or deprecated — their coexistence is intentional, allowing users to adopt whichever convention suits their style.

Block comments do not nest. The first `*/` encountered closes the comment regardless of any `/*` inside it.

```zen
# this is a comment
// this is also a comment

/*
  this spans
  multiple lines
*/
```

---

### 2.4 Keywords

The following identifiers are reserved by the language and may not be used as user-defined names:

| Category | Keywords |
|---|---|
| **Types** | `int` `long` `double` `byte` `string` `bool` `void` `List` |
| **Control Flow** | `if` `else if` `else` `loop` `while` `do` `switch` `case` `default` |
| **Loop Control** | `break` `continue` |
| **Iteration** | `of` |
| **Functions** | `fn` `return` `extern` |
| **Concurrency** | `thread` `async` `await` |
| **Declarations** | `struct` `enum` `const` `reactive` `private` |
| **Inference** | `auto` |
| **Modules** | `import` `export` `from` `as` |
| **Object** | `this` |

Keywords are case-sensitive. `fn` is reserved; `Fn` and `FN` are valid identifiers.

`async` and `await` are reserved and the parser recognizes their syntax, but code generation for asynchronous concurrency is not yet implemented. Concurrency is currently provided by `thread` functions.

The `in` keyword was removed in v3.0.0 and is no longer reserved. `private` became reserved in v3.0.0, so any existing identifier named `private` must be renamed.

---

### 2.5 Identifiers

An identifier is a user-defined name for a variable, function, or other declared entity.

**Rules:**

- Must begin with a letter (`a–z`, `A–Z`) or an underscore (`_`)
- May contain letters, digits (`0–9`), and underscores in any position after the first character
- May end with a digit
- Are case-sensitive — `count`, `Count`, and `COUNT` are three distinct identifiers
- Must not match any reserved keyword

**Valid identifiers:**

```zen
x
myVariable
_internal
value1
snake_case_name
counter2
```

**Invalid identifiers:**

```zen
1value       # begins with a digit
fn           # reserved keyword
my-var       # hyphens are not allowed
```

---

### 2.6 Literals

A literal is a fixed value written directly in source. ZEN defines six literal types: integer, long, byte, double, string, and boolean.

#### 2.6.1 Integer Literals

A sequence of decimal digits with no prefix, suffix, or separator.

    0
    42
    1000

Integer literals are represented by the `int` type.

Hexadecimal literals are supported using the `0x` prefix. A hexadecimal literal with no suffix is always an `int`, even if its digits end in a letter such as `B` or `F`.

    0xFF
    0x1A3F
    0x00
    0xFB      # int 251, not a byte

Binary and octal representations are not supported.

---

#### 2.6.2 Long Literals

A decimal integer followed by the `L` suffix.

    0L
    42L
    100000L

The `L` suffix explicitly marks the literal as a `long`.

    long timestamp = 1787763985L
    long duration = 3600L

For hexadecimal literals, an underscore is required before the suffix.

    0xFF_L
    0xFFFFFFFF_L
    0x100000000_L

---

#### 2.6.3 Byte Literals

A decimal integer followed by the `B` suffix.

    0B
    1B
    42B
    127B

The `B` suffix explicitly marks the literal as a `byte`.

    byte value = 127B

`byte` is **signed**, with a range of -128 to 127. A suffixed value outside this range wraps using two's complement (for example, `255B` is -1).

For hexadecimal literals, an underscore is required before the suffix, because `B` is also a valid hexadecimal digit.

    0xFB_B
    0x00_B
    0x7F_B

Without the underscore there is no suffix and the literal is an `int`: `0xFB` is `int` 251, while `0xFB_B` is a `byte`.

    byte value = 0x7F_B

Decimal suffixes (`42L`, `42B`) need no underscore.

---

#### 2.6.4 Double Literals

A decimal integer part, a dot, and a decimal fractional part. Both parts are required.

    3.14
    0.5
    100.0

Scientific notation is supported.

    1e300
    1.5e-10
    2E+5

A bare integer such as `42` is not a valid `double` literal; `42.0` must be written explicitly.

    double value = 42.0

---

#### 2.6.5 String Literals

A sequence of characters enclosed in matching double or single quotes. Both forms are equivalent.

    "hello, world"
    'hello, world'

**Escape sequences**

Strings support `\e` (the ESC character) and `\xHH` (a byte given as two hex digits). They are useful for ANSI terminal colors.

    screen("\e[31mError\e[0m")
    screen("\x41")

---

**Backtick Strings**

ZEN also supports backtick-delimited strings — `` ` `` — which offer two additional capabilities over quoted strings.

**Multiline strings**

Backtick strings preserve newlines and indentation exactly as written in source. No escape sequences are needed.

    string msg = `hello
    hi
    how are you`

**Template literals**

Backtick strings support inline expression interpolation using `${}`. Any valid Zen expression can appear inside the braces.

    string name = "Zen"
    string msg = `Hello, ${name}!`

    int a = 10
    int b = 20
    string result = `Sum of ${a} and ${b} is ${a + b}`

Multiline and interpolation can be combined freely.

    string user = "Achu"
    string out = `Welcome, ${user}.
    Your session has started.`

---

| Form | Type | Multiline | Interpolation |
|---|---|---|---|
| `42`, `0xFB` | `int` | — | — |
| `42L`, `0xFF_L` | `long` | — | — |
| `42B`, `0xFB_B` | `byte` | — | — |
| `3.14`, `1e300` | `double` | — | — |
| `"..."` | `string` | No | No |
| `'...'` | `string` | No | No |
| `` `...` `` | `string` | Yes | Yes |

#### 2.6.6 Boolean Literals

Exactly two values, lowercase:

    true
    false

Any other casing (`True`, `TRUE`) is not a boolean literal and will be interpreted as an identifier.

`bool` can also be used in arithmetic and bitwise operations (`true` = 1, `false` = 0).

---

### 2.7 Operators

Operators are fixed-character sequences that form their own token type. ZEN defines six operator categories.

#### Assignment Operators

| Operator | Meaning |
|---|---|
| `=` | Assign |
| `+=` | Add and assign |
| `-=` | Subtract and assign |
| `*=` | Multiply and assign |
| `/=` | Divide and assign |
| `%=` | Modulo and assign |

#### Arithmetic Operators

| Operator | Meaning |
|---|---|
| `+` | Addition (or string concatenation) |
| `-` | Subtraction |
| `*` | Multiplication |
| `/` | Division |
| `%` | Modulo |

If either operand of `+` is a string, the other operand is converted to a string and the two are concatenated.

Arithmetic follows numeric widening: `byte` → `int` → `long` → `double`. `bool` can also be used in arithmetic (`true` = 1, `false` = 0).

#### Unary Operators

| Operator | Meaning |
|---|---|
| `+` | Unary plus |
| `++` | Increment |
| `--` | Decrement |
| `!` | Logical NOT |

#### Comparison Operators

| Operator | Meaning |
|---|---|
| `==` | Equal |
| `!=` | Not equal |
| `>=` | Greater than or equal |
| `<=` | Less than or equal |
| `>` | Greater than |
| `<` | Less than |

#### Logical Operators

| Operator | Meaning |
|---|---|
| `&&` | Logical AND |
| `\|\|` | Logical OR |

#### Bitwise Operators

| Operator | Meaning |
|---|---|
| `&` | Bitwise AND |
| `\|` | Bitwise OR |
| `^` | Bitwise XOR |
| `<<` | Shift left |
| `>>` | Shift right |
| `~` | Bitwise NOT |

Bitwise operators work on integer types (`byte`, `int`, `long`) and on `bool`.

---

### 2.8 Token Summary

Every unit of source text falls into one of the following token types:

| Token Type | Examples |
|---|---|
| `KEYWORD` | `fn`, `if`, `const`, `return` |
| `IDENTIFIER` | `x`, `myVar`, `_count` |
| `int` | `0`, `42`, `1000` |
| `long` | `0L`, `67L`, `2600000000L` |
| `byte` | `0B`, `120B`, `-4B` |
| `double` | `3.14`, `0.5`, `100.0` |
| `string` | `"hello"`, `'world'` |
| `bool` | `true`, `false` |
| `OPERATOR` | `+`, `==`, `&&`, `++` |

---

## 3. Types

ZEN is a statically typed language. Every value has a type known at compile time. This section defines the six primitive types that form the foundation of the type system.

Data structure types — `List`, `struct`, and fixed-size arrays — are defined separately in Section 5.

---

### 3.1 Primitive Types

ZEN defines six primitive types:

| Type | Description | Example Literals |
|---|---|---|
| `int` | Integer number | `0`, `42`, `1000` |
| `long` | 64-bit integer number | `0L`, `42L`, `100000L` |
| `byte` | 8-bit signed integer (-128 to 127) | `0B`, `42B`, `127B` |
| `double` | Floating-point number | `3.14`, `0.5`, `1e300` |
| `bool` | Boolean value | `true`, `false` |
| `string` | Text value | `"hello"`, `'world'` |

These are reserved keywords and cannot be used as identifiers.

---

#### 3.1.1 `int`

Represents a whole number. Decimal and hexadecimal notation are supported. Negative values are expressed using the unary `-` operator, and unary `+` is also valid.

    int x = 42
    int y = 0
    int z = -10
    int p = +10

    int hex = 0xFF

A hexadecimal literal with no suffix is always an `int`, even if it ends in `B` or `F` (`0xFB` is 251).

---

#### 3.1.2 `long`

Represents a 64-bit integer. Long literals use the `L` suffix.

    long x = 42L
    long timestamp = 1787763985L
    long duration = 3600L

Hexadecimal long literals need an underscore before the suffix.

    long value = 0xFFFFFFFF_L

---

#### 3.1.3 `byte`

Represents an 8-bit **signed** integer with a range of -128 to 127. Byte literals use the `B` suffix.

    byte x = 0B
    byte y = 42B
    byte max = 127B

A suffixed value outside the range wraps using two's complement (`255B` is -1).

Hexadecimal byte literals need an underscore before the `B` suffix, because `B` is also a hexadecimal digit.

    byte value = 0x7F_B
    byte zero = 0x00_B
    byte neg = 0xFF_B     # -1

Without the underscore the literal is an `int`: `0xFB` is `int` 251, while `0xFB_B` is a `byte`.

---

#### 3.1.4 `double`

Represents a floating-point number. Both the integer part and the fractional part must be written explicitly — a bare integer is not a valid `double` literal. Scientific notation is supported.

    double pi = 3.14
    double zero = 0.0
    double rate = 100.0
    double big = 1e300
    double tiny = 1.5e-10

---

#### 3.1.5 `bool`

Represents a boolean value. Only two values exist: `true` and `false`. Both are lowercase; any other casing is treated as an identifier, not a boolean.

    bool active = true
    bool done = false

`bool` can also be used in arithmetic and bitwise operations, where `true` is 1 and `false` is 0.

    int n = true + true      # 2

---

#### 3.1.6 `string`

Represents a sequence of characters. String literals may be enclosed in either double or single quotes; both forms produce identical values.

    string name = "ZEN"
    string greeting = 'hello'

Backtick strings are also supported for multiline strings and template interpolation.

    string name = "ZEN"
    string message = `Hello, ${name}!`

Strings are heap-allocated and reference-semantic. See Semantics for ownership and `free()`.

---

### 3.2 Type Behavior in Expressions

ZEN does not perform implicit type casting in general. Types must match at assignment and in most expression contexts. Two specific exceptions exist: numeric promotion and string coercion.

---

#### 3.2.1 Numeric Promotion

When operands of different numeric types are used in an arithmetic expression, ZEN automatically promotes the lower-ranked numeric type to the higher-ranked type for the duration of that expression.

The promotion hierarchy is:

`byte` → `int` → `long` → `double`

The result uses the highest-ranked numeric type present in the expression.

    double result = 3.14 + 2
    # 2 is promoted to double → result is 5.14

    long x = 10L + 20
    # 20 is promoted to long → result is 30L

    int y = 10 + 2B
    # 2B is promoted to int → result is 12

    double z = 10B + 0.5
    # 10B is promoted through int/long to double → result is 10.5

Promotion is expression-scoped. The original variable is not modified.

    int a = 5
    double b = 2.0

    double c = a + b
    # a is promoted to double within this expression only

    # a remains int outside of the expression

---

#### 3.2.2 String Coercion

When one operand of `+` is a `string`, the other operand is implicitly coerced to its string representation. The result is always `string`. This is the only form of cross-type coercion ZEN permits.

```zen
string s = "count: " + 10        # → "count: 10"
string t = "value: " + 3.14      # → "value: 3.14"
string u = "active: " + true     # → "active: true"
string i = "active: " + 10L      # → "active: 10"
string k = "active: " + 10B      # → "active: 10"
```

Coercion is one-directional: a non-string operand is converted to `string`, never the reverse.

```zen
int x = 5 + "3"                  # error: int context, no coercion applies
```

---

## 4. Grammar & Syntax

This section defines the syntactic rules of ZEN. Grammar rules are written in a simplified EBNF-style notation where:

- `=` defines a rule
- `|` means "or"
- `?` means optional (zero or one)
- `*` means zero or more
- `+` means one or more
- `"text"` is a literal token
- `UPPER_CASE` is a terminal token from the lexer
- `lower_case` is a non-terminal rule defined in this section

---

### 4.1 Program Structure

A ZEN program is a sequence of top-level declarations. Code may exist at the global level as variable declarations or function definitions.

```
program
  = top_level_decl*

top_level_decl
  = var_decl
  | const_decl
  | function_decl
  | struct_decl
```

---

### 4.2 Blocks

A block is a sequence of statements enclosed in braces. Blocks define scope boundaries.

```
block
  = "{" statement* "}"
```

---

### 4.3 Statements

```
statement
  = var_decl
  | const_decl
  | assignment
  | function_call ";"?
  | return_stmt
  | if_stmt
  | switch_stmt
  | loop_stmt
  | while_stmt
  | do_while_stmt
  | loop_in_stmt
  | loop_of_stmt
  | block
```

---

### 4.4 Variable Declarations

#### Full Declaration

```
var_decl
  = type IDENTIFIER "=" expression
  | "auto" IDENTIFIER "=" expression
```

```zen
int a = 10
double pi = 3.14
string name = "ZEN"
bool active = true
long time = 1000000000000000L
byte b = 36B
auto x = 42
```

#### Declaration Without Initializer

A variable may be declared without an explicit value. The compiler lowers it to the type's default value.

```
var_decl_default
  = type IDENTIFIER
```

| Type | Default Value |
|---|---|
| `int` | `0` |
| `double` | `0.0` |
| `long` | `0L` |
| `byte` | `0B` | 
| `string` | `""` |
| `bool` | `false` |
| `List<T>` | `[]` |

```zen
int a          # lowered to: int a = 0
long count     # lowered to: long count = 0L
byte value     # lowered to: byte value = 0B
double rate    # lowered to: double rate = 0.0
string label   # lowered to: string label = ""
bool flag      # lowered to: bool flag = false
``` 

#### Constant Declaration

Constants are declared with the `const` modifier before the type. They cannot be reassigned after declaration.

```
const_decl
  = "const" type IDENTIFIER "=" expression
```

```zen
const int MAX = 100
const string VERSION = "3.0.0"
```

### 4.5 Assignment & Reassignment

Variables may be reassigned using the `=` operator or any compound assignment operator. Constants may not be reassigned.

```
assignment
  = IDENTIFIER assign_op expression
  | index_access assign_op expression
  | field_access assign_op expression

assign_op
  = "=" | "+=" | "-=" | "*=" | "/=" | "%="
```

```zen
a = 10
a += 5
a -= 2
a *= 3
a /= 4
a %= 2
```

### 4.6 Expressions

```
expression
  = literal
  | IDENTIFIER
  | function_call
  | index_access
  | field_access
  | unary_expr
  | binary_expr
  | ternary_expr
  | "(" expression ")"

literal
  = INT_LITERAL
  | DOUBLE_LITERAL
  | STRING_LITERAL
  | BOOL_LITERAL
  | list_literal
  | struct literal
```

#### Binary Expressions

```
binary_expr
  = expression binary_op expression

binary_op
  = "+" | "-" | "*" | "/" | "%"
  | "==" | "!=" | ">=" | "<=" | ">" | "<"
  | "&&" | "||"
```

Standard operator precedence applies. Parentheses may be used to override precedence explicitly.

```zen
int a = 10 + 2 * 76        # multiplication first
int b = (10 + 2) * 76      # addition first
bool c = a > 10 && b < 500
```

#### Unary Expressions

```
unary_expr
  = ("+" | "-" | "!") expression
  | IDENTIFIER "++"
  | IDENTIFIER "--"
```

```zen
!active
-10
a++
b--
```

#### Ternary Expression

```
ternary_expr
  = expression "?" expression ":" expression
```

The condition must evaluate to `bool`. Both branches **must return the same type** — a type mismatch between the true and false branches is a compile-time error.

```zen
int max     = a > b ? a : b
string label = active ? "on" : "off"
int val     = a > 0 ? (a > 10 ? 2 : 1) : 0
```

Nesting is allowed. Each nested ternary must also satisfy the same-type constraint at every level.

---

**Type Mismatch — Compile-time Error**

```zen
# Error: branches return different types (int vs string)
auto x = a > b ? 42 : "hello"

# Error: branches return different types (bool vs int)
auto y = flag ? true : 0
```

Both the true branch and the false branch must resolve to the **same static type**. Zen performs this check at compile time — no implicit coercion is applied.


#### Access Expressions

```
index_access
  = IDENTIFIER "[" expression "]"

field_access
  = IDENTIFIER "." IDENTIFIER
  | IDENTIFIER "[" expression "]"     # runtime key access for Struct
```

```zen
arr[0]
matrix[1][2]
person.name
```

---

### 4.7 Function Declarations

```
function_decl
  = "fn" IDENTIFIER "(" param_list? ")" return_type? block

param_list
  = param ("," param)*

param
  = type IDENTIFIER
  | type IDENTIFIER "..."              # rest parameter

return_type
  = type
  | "auto"
  | (empty)                           # implicitly void
```

- Function identifiers follow the standard identifier rules, except that they must not start with _ (underscore), as names beginning with _ are reserved for ZEN internal use.
- Parameters are typed explicitly.
- If no return type is specified, the function is implicitly `void`.
- `auto` may be used as the return type; the compiler infers it from the `return` statement.
- A rest parameter (`type identifier...`) collects remaining arguments into a `List`. It must be the last parameter.
- Function declarations may not be nested inside another function.

#### Callback Parameters

Functions can accept other functions as parameters (callbacks).

```
callback_param
  = "fn" IDENTIFIER "(" type_list? ")" return_type

type_list
  = type ("," type)*
```

- Callback parameters declare only the function signature.
- They can accept zero or more typed parameters.
- They may return any valid type, including `void`.

```zen
fn run(fn cb(string, int) void) {
  cb("ZEN", 10)
}

fn printMessage(string name, int age) {
  screen(name)
  screen(age)
}

run(printMessage)
```

---

### Function Declarations

ZEN supports four kinds of function declarations:

- **Normal** (`fn`): has a body, can be exported and imported.
- **External** (`extern fn`): implemented outside of ZEN.
- **Private** (`private fn`): visible only in the current module.
- **Thread** (`thread fn`): runs in its own thread.

---

#### Normal Function Declaration

```
function_decl
  = "fn" IDENTIFIER "(" param_list? ")" return_type? block
```

```zen
fn add(int a, int b) int {
    return a + b
}

fn greet(string name) {
  # void: no return type specified
}

fn sum(int values...) List<int> {
  # A rest parameter needs an explicit return type like List<T>. No auto for List returns.
  # values is List<int> under the hood
  return values
}
```

- Contains a function body.
- May be called anywhere after declaration.
- `return_type` is omitted for `void` functions.
- Can be exported. A file can have multiple exports and imports.
- Exported functions can take or return structs that are not exported.

---

#### External Function Declaration

```
extern_function_decl
  = "extern" "fn" IDENTIFIER "(" param_list? ")" return_type?
```

- Used to call functions implemented outside of ZEN (for example, C libraries).
- Does not contain a function body.
- The compiler emits the function name exactly as written (no name mangling).
- Supports all valid parameter and return types.
- If an external function returns a native pointer, use the built-in `Ptr` struct as the return type.
- `zen deps` detects and records `native/*.o`, and native objects link automatically.
- `.c` files are supported as native dependencies.
- Extra linker flags go in `zen.json` (`flags: []`, for example `-lmariadb`) or via `--link a.o b.o`.

```zen
extern fn puts(string text) int
extern fn malloc(int size) Ptr
extern fn free(Ptr memory)
```

External functions are invoked exactly like normal functions.

```zen
Ptr memory = malloc(1024)
puts("Allocated successfully")
free(memory)
```

---

#### Private Function Declaration

```
private_function_decl
  = "private" "fn" IDENTIFIER "(" param_list? ")" return_type? block
```

- Visible only in the current module scope.
- Cannot be imported by other modules.
- `private` is a reserved keyword, so no identifier can be named `private`.
- Also applies to struct fields and methods.

```zen
private fn helper(int a) int {
    return a * 2
}
```

---

#### Thread Function Declaration

```
thread_function_decl
  = "thread" "fn" IDENTIFIER "(" param_list? ")" block
```

- Accepts parameters.
- Invalid captures are reported at compile time.
- Thread methods are also supported inside structs.
- String arguments are duplicated and freed per thread.

```zen
thread fn worker(int id) {
    # runs in its own thread
}
```

---

#### Return Statement

```
return_stmt
  = "return" expression?
```

`return` is valid only inside a function block. A bare `return` is valid in `void` functions.

```zen
return
return 42
return a + b
```

---

#### Function Call

```
function_call
  = IDENTIFIER "(" argument_list? ")"

argument_list
  = argument ("," argument)*

argument
  = expression
```

```zen
greet("ZEN")
add(10, 20)
add(5 + 5, a)
```

Calls can be chained on returned structs:

```zen
make().show()
```

---

#### Callbacks

- **Named functions** passed as callbacks can use closures (outer variables allowed).
- **Anonymous inline functions** are written like a normal function declaration, directly in the argument list. They compile as separate functions and cannot capture outer variables.

```zen
call(fn name(int a) void {
    # body
})
```

Example with a progress callback:

```zen
List<byte> data = http.getProgress(url, fn cb(long downloaded, long total) void {
    # report progress here
})
```

---

#### Import Aliasing

- Functions and variables can be aliased on import.
- Structs cannot be aliased (`ImportError`).

```zen
import (worker as w)
```

---

### 4.8 Scopes

ZEN defines three scope levels. Each inner scope has access to identifiers declared in any enclosing outer scope.

| Scope | Where | Lifetime |
|---|---|---|
| **Global** | Top level of the program, outside any block | Entire program execution |
| **Function** | Inside a function block | Duration of the function call |
| **Block** | Inside any `{}` block (if, loop, nested block) | Duration of that block |

An identifier declared in an inner scope shadows any identifier with the same name in an outer scope for the duration of that inner scope.

---

### 4.9 Control Flow

#### If Statement

```
if_stmt
  = "if" "(" expression ")" block
    ("else if" "(" expression ")" block)*
    ("else" block)?
```

```zen
if (a > 10) {
  # ...
} else if (a == 10) {
  # ...
} else {
  # ...
}
```

#### Switch Statement

```
switch_stmt
  = "switch" "(" expression ")" "{" case_clause* default_clause? "}"

case_clause
  = "case" int_expr ":" block

default_clause
  = "default" ":" block

int_expr
  = INT_LITERAL
  | int_literal_expr          # compile-time integer expression e.g. 10 + 10
```

- The switch expression must evaluate to `int`.
- Case values must be integer literals or compile-time integer expressions. Variable references are not permitted in case values.
- There is no fallthrough. Each case is implicitly terminated. No `break` is needed or allowed.
- `default` is optional and matches any value not covered by a case.

```zen
switch (status) {
  case 1: {
    # ...
  }
  case 10 + 10: {
    # matches 20
  }
  default: {
    # ...
  }
}
```

---

### 4.10 Loop Constructs

ZEN provides four loop forms.

#### General Loop

The general loop takes exactly three arguments separated by `,`

```
loop_stmt
  = "loop" "(" var_decl "," expression "," update_expr ")" block

update_expr
  = assignment
  | unary_expr
```

```zen
loop (int i = 0, i < 10, i++) {
  ...
}
```

#### While Loop

```
while_stmt
  = "while" "(" expression ")" block
```

```zen
while (active) {
  # ...
}
```

#### Do-While Loop

```
do_while_stmt
  = "do" block "while" "(" expression ")"
```

```zen
do {
  # executes at least once
} while (count < 10)
```

#### Loop Of — Array and List Iteration

Iterates over elements of a `List`, fixed-size array, or rest parameter (which is internally treated as a `List`).

```
loop_of_stmt
  = "loop" "(" IDENTIFIER "of" IDENTIFIER ")" block
```

```zen
loop (item of myList) {
  # item holds the current element
}

loop (val of arr) {
  # works for fixed-size arrays
}
```

Nested iteration:

```zen
loop (row of matrix) {
  loop (cell of row) {
    # nested loop of
  }
}
```

### Semantics

- The iteration count is **fixed at the start of the loop**
- The loop uses the **initial length of the collection**
- It does NOT observe runtime mutations during iteration

### Undefined / Unsafe Behavior

Mutating the underlying collection inside a `loop of` is **undefined behavior**, including:

- `push`, `pop`, `remove` on lists
- index assignment on fixed-size arrays
- structural modification of the list being iterated
- modification of rest-parameter lists

```zen
loop (x of list) {
  list.push(10)   # UB
}

loop (x of arr) {
  arr[0] = 99     # UB
}
```

### Why this is UB

- Iteration length is captured before execution begins
- Mutations do not affect the loop counter
- This can lead to:
  - skipped elements
  - repeated elements
  - out-of-bounds access
  - inconsistent runtime state

### Recommended Alternative

For cases requiring consistent mutation-safe iteration behavior, use:

- the **general loop construct (Section 4.10)**:
```zen
loop (init, condition, update) {
  # safe controlled iteration
}
```

- or a **while loop** when iteration depends on dynamic state:
```zen
while (condition) {
  # safe dynamic iteration
}
```

These constructs are designed for cases where the collection may change during iteration and a stable execution model is required.

---

### 4.11 Data Structure Declarations

Full behavior and semantics are defined in Section 5. Grammar rules are provided here for reference.

#### List

```
list_decl
  = "List" "<" type ">" IDENTIFIER "=" list_literal
  | "List" "<" type ">" IDENTIFIER              # lowered to = []

list_literal
  = "[" (expression ("," expression)*)? "]"
```

```zen
List<int> nums = [1, 2, 3]
const List<List<int>> matrix = [[1, 2], [3, 4]]
List<int> empty                              # lowered to: List<int> empty = []
```

#### Fixed-Size Array

```
array_decl
  = type IDENTIFIER dimension+ "=" array_literal

dimension
  = "[" INT_LITERAL "]"

array_literal
  = "[" (array_literal | expression) ("," (array_literal | expression))* "]"
```

```zen
int arr[3] = [1, 2, 3]
int matrix[2][2] = [[1, 2], [3, 4]]
```

#### Struct Declaration

```
struct_decl
  = "struct" IDENTIFIER "{" field_decl* method_decl* "}"

field_decl
  = type IDENTIFIER ","?

method_decl
  = IDENTIFIER "(" param_list? ")" return_type? block
```

```zen
struct Person {
  private string name, // private field
  int age,
  List<int> scores = [] // field init

  private greet() void { // private method
    # this is implicitly available
  }

  getName() string {
    return this.name
  }
}
```

#### Struct Instantiation and Access

```
struct_instance
  = IDENTIFIER IDENTIFIER       # TypeName aliasName

method_call
  = IDENTIFIER "." IDENTIFIER "(" argument_list? ")"
```

```zen
Person p
p.name = "Jishith"
p.age = 21
p.greet()
string n = p.getName()
```

---

#### Built-in Structs

Zen provides several built-in structs that are available without importing any library.

> **⚠️ Caution**
>
> Built-in structs use **reference semantics**, while user-defined structs use **value semantics**.
>
> Built-in structs (such as `HttpServer`, `HttpRequest`, `HttpResponse`, `Json`, `JsonObject`, `JsonArray`, `Map`, `Ptr`, `Tcp`, and `TcpServer`) represent runtime resources managed outside of Zen. Copying them would duplicate only the handle, not the underlying resource, so they are always passed and assigned by reference.
>
> User-defined structs, on the other hand, are ordinary data values and are copied on assignment or when passed to functions, providing predictable value semantics.

---

##### Ptr

Represents a native memory pointer.

`Ptr` is a built-in struct used for low-level memory access and interoperability with external libraries through `extern` functions. It can read and write primitive values, perform pointer arithmetic, copy memory, and manage manually allocated memory.

> **⚠️ Warning**
>
> `Ptr` provides direct access to raw memory. Incorrect usage (such as invalid offsets, reading uninitialized memory, accessing freed memory, or writing outside allocated memory) results in undefined behavior.

```zen
extern fn malloc(int size) Ptr

Ptr p = malloc(16)

p.storeInt(123)

screen(p.loadInt())

p.free()
```

**Methods**

```zen
p.storeInt(int value)
p.loadInt() int

p.storeDouble(double value)
p.loadDouble() double

p.storeBool(bool value)
p.loadBool() bool

p.storeString(string value)
p.loadString() string

p.storePtr(Ptr value)
p.loadPtr() Ptr

p.isNull() bool

p.offset(int bytes) Ptr

p.copyFrom(Ptr src, int bytes)
p.copyTo(Ptr dst, int bytes)

p.fill(int value, int bytes)

p.free()
```

`offset()` returns a new `Ptr` advanced by the specified number of bytes from the current pointer, allowing pointer arithmetic without modifying the original pointer.

---

##### Map

Represents a dynamic key-value collection.

Unlike user-defined structs, `Map` does not have a fixed set of fields. Keys can be added, updated, or removed at runtime, making it suitable for dynamic data such as JSON-like objects and configuration values.

Map supports struct-style literals:

```zen
Map user = {
    name: "Jishith",
    age: 25,
    skills: ["LLVM", "Compiler"]
}
```

Map literals can be passed directly to functions, returned from functions, stored in collections, and nested inside other maps.

Because `Map` is dynamic, different instances may contain different keys.

```zen
Map user = {
    name: "Alice",
    age: 20,
    country: "India"
}
```

> 💡 **Note:** `Map` is a built-in struct, not a language data type. Its internal representation is managed entirely by the Zen runtime.

**Methods**

```zen
map.setInt(string key, int value)
map.getInt(string key) int

map.setLong(string key, long value)
map.getLong(string key) long

map.setByte(string key, byte value)
map.getByte(string key) byte

map.setDouble(string key, double value)
map.getDouble(string key) double

map.setBool(string key, bool value)
map.getBool(string key) bool

map.setString(string key, string value)
map.getString(string key) string

map.setList(string key, List<T> value)
map.getList<List<T>>(string key) List<T>

map.setMap(string key, Map value)
map.getMap(string key) Map

map.remove(string key) void

map.has(string key) bool

map.keys()

map.entries()

map.json() string

map.free()
```

---

##### HttpServer

Represents an HTTP server instance.

```zen
HttpServer server = httpServer.create(8080)

while (server.listen() == 1) {
    HttpRequest req = server.next()

    req.send("Hello, World!")
}

server.close()
```

##### HttpRequest

Represents an HTTP request and provides request information and response helpers.

**Properties**

```zen
req.method
req.path
req.body
```

**Methods**

```zen
req.send(...)
req.json(...)
req.html(...)
req.css(...)
req.sendFile(...)
req.status(...)
req.setHeader(...)
req.getHeader(...)
req.redirect(...)
```

##### HttpResponse

Reserved for future releases.

##### Tcp

Represents a TCP connection.

```zen
Tcp conn = net.connect(host, port)
```

**Methods**

```zen
conn.send(...)
conn.receive(...)
conn.close()
conn.isOpen() bool
```

##### TcpServer

Represents a TCP server listening on a port.

```zen
TcpServer server = net.listen(port)
```

**Methods**

```zen
server.accept(...)
server.close()
server.isOpen() bool
```

##### Json

Represents a parsed JSON document.

```zen
Json json

json.parse("{\"name\":\"ZEN\",\"age\":1}")

screen(json.getString("name"))
screen(json.getInt("age"))

json.free()
```

**Methods**

```zen
json.parse(...)
json.getInt(...)
json.getLong(...)
json.getByte(...)
json.getDouble(...)
json.getString(...)
json.getBool(...)
json.getObject(...)
json.getArray(...)
json.has(...)
json.isNull(...)
json.arrayLength()
json.arrayGetInt(...)
json.arrayGetDouble(...)
json.arrayGetString(...)
json.arrayGetBool(...)
json.arrayGetObject(...)
json.arrayGetArray(...)
json.map() Map
json.free()
```

> [!CAUTION]
> ### JSON Integer Values After `.map()`
>
> JSON integer numbers converted with `.map()` can be read with `getInt()`, `getByte()` or `getLong()`.
>
> Overflow is checked at runtime for the getter you use (for example, `getByte()` fails if the value is outside -128 to 127).
>
> **Note:** Normal `Map` integer/long behavior remains unchanged.

----

##### JsonObject

Represents a JSON object returned from a `Json` or `JsonArray` instance.

The same object access methods as `Json` are available.

##### JsonArray

Represents a JSON array returned from a `Json` or `JsonObject` instance.

Supports array access methods such as:

```zen
array.arrayLength()
array.arrayGetInt(...)
array.arrayGetLong(...)
array.arrayGetByte(...)
array.arrayGetDouble(...)
array.arrayGetString(...)
array.arrayGetBool(...)
array.arrayGetObject(...)
array.arrayGetArray(...)
```

---

## 5. Data Structures

ZEN provides three built-in data structure types: `List`, fixed-size arrays, and `struct`. Each has distinct memory characteristics, mutability rules, and supported operations. `Map` is a built-in struct, covered under Built-in Structs.

| Type | Schema | Size | Memory | Heterogeneous |
|---|---|---|---|---|
| `List<T>` | Typed | Runtime | Heap | No |
| `array` | Fixed | Compile-time | Stack | No |
| `struct` | Fixed | Compile-time | Stack | No |

---

### 5.1 List

A `List` is a dynamically sized, heap-allocated array. `List` is homogeneous: all elements must be of the same declared type. Nesting is supported through `List<List<T>>`.

> **Note:** `byte` is a primitive type. `List<byte>` is used by binary APIs such as `http.getProgress`.

#### Declaration

```
list_decl
  = "List" "<" type ">" IDENTIFIER "=" list_literal
  | "List" "<" type ">" IDENTIFIER              # lowered to = []
```

A `List` declared without an initializer is lowered to an empty list.

```zen
List<int> nums                         # lowered to: List<int> nums = []
List<int> nums = [1, 2, 3]
List<string> names = ["zen", "lang"]
List<List<int>> matrix = [[1, 2], [3, 4]]
```

#### Allowed Element Types

List elements may be of the following types:

- `int`, `double`, `string`, `bool`, `long`, `byte`
- Struct types
- Nested `List<T>`

`auto` is not valid as a type parameter. `List<auto>` is a compile-time error.

#### Access

Elements are accessed by zero-based integer index.

```zen
nums[0]                                # first element
matrix[0][1]                           # nested access
people[0].name                         # struct field access inside List<Struct>
```

#### Properties

`length` and `capacity` are properties, not methods. Writing `nums.length()` is a compile-time `TypeError`.

```zen
nums.length                            # number of elements (int)
nums.capacity                          # allocated capacity (int)
length(nums)                           # same as nums.length, as a global function
```

#### Assignment

Individual elements may be reassigned by index.

```zen
nums[0] = 99
matrix[1][0] = 10
```

#### Built-in Methods

| Method | Signature | Description |
|---|---|---|
| `push` | `push(value)` | Appends a value to the end of the list |
| `pop` | `pop()` | Removes and returns the last element |
| `removeAt` | `removeAt(int index)` | Removes the element at the given index |
| `remove` | `remove(value)` | Removes the given value from the list |
| `contains` | `contains(value)` | Returns `bool`: checks if the value exists |
| `indexOf` | `indexOf(value)` | Returns the index of the first matching element, or `-1` if not found |
| `join` | `join(string separator)` | Joins all elements into a string using the separator |
| `reverse` | `reverse()` | Reverses the list in place |
| `sort` | `sort()` | Sorts the list in place |
| `sum` | `sum()` | Returns the sum of all elements |
| `avg` | `avg()` | Returns the average of all elements as `double` |
| `flat` | `flat()` | Flattens a nested list of any depth into a single-level list |
| `clear` | `clear()` | Removes all elements; list remains alive |
| `free` | `free()` | Releases the list from heap memory |

```zen
nums.push(30)
nums.push([10, 20])                     # valid for nested List<List<int>>
int last = nums.pop()
nums.removeAt(0)
nums.remove(30)                         # removes by value

bool found = nums.contains(30)
int idx = nums.indexOf(30)

List<string> names = ["Zen", "Lang", "LLVM"]
string joined = names.join(", ")

List<int> values = [3, 1, 2]
values.sort()                           # [1, 2, 3]
values.reverse()                        # [3, 2, 1]
int total = values.sum()                # 6
double mean = values.avg()              # 2.0

nums.clear()                            # list is now [] but still usable
nums.free()                             # list is released
```

#### Method Restrictions

Element types are checked at compile time. Using a method on an unsupported element type is a `TypeError`.

| Method | Supported element types |
|---|---|
| `push` | Any. The value must match the declared element type. For `List<List<int>>`, push a `List<int>`. |
| `contains`, `indexOf` | `int`, `double`, `bool`, `string` |
| `remove` | `byte`, `int`, `long`, `double`, `bool`, `string` |
| `sort` | `byte`, `int`, `long`, `double`, `string` |
| `sum` | `byte`, `int`, `long`, `double` (returns the element type) |
| `avg` | `byte`, `int`, `long`, `double` (returns `double`) |
| `join` | Flat `List<string>` only |

`removeAt` requires an `int` index.

#### Free and Nested Lists

After calling `free()`, the list must not be accessed. Any use after `free()` results in a runtime error.

```zen
nums.free()
nums.push(1)                            # runtime error: use after free
```

For nested lists, freeing an inner list directly is technically permitted but not recommended. ZEN cannot fully track inner list lifetimes after a partial free, and accessing a freed inner list will throw a runtime error.

> **Recommendation:** Do not call `free()` on individual inner lists of a nested `List<List<T>>`. Free the outer list instead.

---

### 5.2 Fixed-Size Arrays

A fixed-size array has a length determined at compile time and cannot be resized. It is stack-allocated. Dimensions are specified in the declaration and are part of the array's type.

#### Declaration

```
array_decl
  = type IDENTIFIER dimension+ "=" array_literal

dimension
  = "[" (INT_LITERAL | CONSTANT_IDENTIFIER) "]"
```

The dimension must be a positive integer literal or a compile-time constant. A size of `0` is not permitted.

```zen
int arr[3] = [1, 2, 3]
int matrix[2][2] = [[1, 2], [3, 4]]

int N = 10
int sized[N]
```

#### Zero Initialization

An array may be declared with an empty literal. All elements are zero-initialized according to their type.

```zen
int arr[3] = []                        # [0, 0, 0]
int matrix[2][2] = [[], []]            # [[0,0],[0,0]]
```

#### Full Initialization Required

If a non-empty literal is provided, it must exactly match the declared dimensions. Partial initialization is a compile-time error.

```zen
int arr[3] = [1, 2]                    # error: expected 3 elements, got 2
int arr[3] = [1, 2, 3]                 # valid
```

#### Access and Assignment

Elements are accessed and assigned by zero-based index.

```zen
arr[0]                                 # read
arr[0] = 99                            # write
matrix[1][1] = 5
```

#### Constraints

- Fixed-size arrays cannot be passed as function parameters.
- Fixed-size arrays cannot be returned from functions.
- Fixed-size arrays have no built-in methods.
- Resizing is not possible after declaration.

---

### 5.3 Struct

A `struct` defines a named, fixed-schema composite type. Its fields and methods are determined at compile time and cannot be changed at runtime. Struct instances are stack-allocated.

#### Declaration

```
struct_decl
  = "struct" IDENTIFIER "{" field_decl* method_decl* "}"

field_decl
  = "private"? type IDENTIFIER ("=" expression)? ","?

method_decl
  = ("private" | "thread")? IDENTIFIER "(" param_list? ")" return_type? block
```

By convention, struct names begin with an uppercase letter.

```zen
struct Person {
  string name,
  int age,
  List<int> scores

  greet() void {
    # this is implicitly available inside all methods
  }

  getName() string {
    return this.name
  }
}
```

---

#### Allowed Field Types

Struct fields may be of the following types:

- `int`, `double`, `string`, `bool`, `long`, `byte`
- `List<T>`
- Another `struct` type

#### Default Values

An uninitialized struct gets zero values for its fields: `0`, `""`, `false`, and an empty list. `List` fields are initialized automatically, so no manual setup is needed. This also applies to structs imported from packages.

```zen
struct User {
  List<string> names
  List<int> scores
}

User user

user.names.push("Alice")
user.scores.push(100)
```

Fields can have default initializers:

```zen
struct Config {
  string host = "localhost",
  int port = 8080
}
```

Struct literals only set the fields you give them. The rest keep their default or zero value.

#### Instantiation

A struct is instantiated by declaring a variable with the struct name as its type.

```zen
Person p
```

Fields may be assigned individually using dot notation.

```zen
p.name = "Jishith"
p.age = 21
```

Structs may also be initialized using struct literals.

```zen
Person p = {
  name: "Jishith",
  age: 21
}
```

An existing struct variable may be reassigned using a struct literal.

```zen
p = {
  name: "Zen",
  age: 1
}
```

Struct values can be copied from other struct variables or function returns.

```zen
Person p = getPerson()

Person other
other = getPerson()

p = other
```

#### Field Access

```zen
p.name                                 # "Jishith"
p.age                                  # 21
p.scores[0]                            # first element of the List field
```

#### Nested Structs

A struct field may hold another struct instance.

```zen
struct Address {
  string city,
  int zip
}

struct Person {
  string name,
  Address address
}

Person p = {
  name: "Jishith",
  address: {
    city: "Bangalore",
    zip: 560001
  }
}
```

Nested fields may also be assigned individually.

```zen
p.address.city = "Bangalore"
p.address.zip = 560001
```

#### Value Semantics

Structs in ZEN use **value semantics**, not reference semantics.

Assigning one struct to another creates a copy of the struct value.

```zen
Person p1 = {
  name: "Jishith",
  age: 21
}

Person p2 = p1

p2.name = "Zen"

screen(p1.name)   # Jishith
screen(p2.name)   # Zen
```

Likewise, returning a struct from a function or assigning a struct literal produces a new struct value.

```zen
Person p = getPerson()

p = {
  name: "New Name",
  age: 30
}
```

Changes made to one struct variable do not affect other struct variables that were copied from it.

#### Methods

Methods are declared inside the struct body without the `fn` keyword. The current instance is implicitly available as `this` inside every method.

```zen
struct Counter {
  int value,

  increment() void {
    this.value += 1
  }

  get() int {
    return this.value
  }
}
```

Methods may have any return type, including `List<T>`, a struct, or primitives. `auto` works only for `int`, `bool`, `double`, `string`, `long`, and `byte`. A `List<T>` return type must be written explicitly.

```zen
Counter c
c.value = 0
c.increment()
int v = c.get()                        # v = 1
```

#### Private Fields and Methods

`private` is a reserved keyword. A private field or method can be accessed only inside the struct's own methods, through `this`. Access from outside the struct is an error.

```zen
struct Counter {
  private int value,

  private reset() void {
    this.value = 0
  }

  clear() void {
    this.reset()
  }
}
```

> **Note:** `private fn` (a function declaration) is different. It is visible only in the current module. See Function Declarations.

#### Thread Methods

A method marked `thread` runs in its own thread. Thread methods are declared without `fn`, like other methods.

```zen
struct Worker {
  int id,

  thread run(int n) {
    # runs in its own thread
  }
}
```

- Thread methods accept parameters.
- Invalid captures are reported at compile time.
- String arguments are duplicated and freed per thread.

#### Structs in Functions

Structs can be passed as function parameters and returned from functions.

```zen
struct Person {
  string name,
  int age
}

fn greet(Person p) void {
  screen(p.name)
}

Person user = {
  name: "Jishith",
  age: 21
}

greet(user)
```

Functions may also return struct values.

```zen
fn createPerson() Person {
  return {
    name: "Jishith",
    age: 21
  }
}

Person p = createPerson()
```

Because structs use value semantics, passing a struct to a function passes a copy of the struct value. Changes made inside the function do not affect the original struct variable.

```zen
fn rename(Person p) void {
  p.name = "Zen"
}

Person user = {
  name: "Jishith",
  age: 21
}

rename(user)

screen(user.name)   # Jishith
```

Calls can be chained on a returned struct:

```zen
make().show()
```

Exported functions can take or return structs that are not exported. Importing a struct also registers its dependent structs as hidden: they are usable through the struct but cannot be named directly. Structs cannot be aliased on import.

--- 

## 6. Functions

A function is a named, reusable block of code that accepts parameters and optionally returns a value. Functions are the primary unit of logic encapsulation in ZEN.

### 6.1 Declaration

ZEN has four kinds of function declarations:

| Kind | Syntax | Description |
|---|---|---|
| Normal | `fn` | Has a body. Can be exported and imported. |
| External | `extern fn` | Implemented outside of ZEN. No body. |
| Private | `private fn` | Visible only in the current module. |
| Thread | `thread fn` | Runs in its own thread. |

The full syntax of a normal function is:

```
fn IDENTIFIER ( param_list? ) return_type? block
```

```zen
fn greet(string name) {
  # void: no value returned
}

fn add(int a, int b) int {
  return a + b
}

fn describe(string label, int value) string {
  return label + ": " + value
}
```

- If no return type is specified, the compiler infers it: `void` when the function returns no value, otherwise the type of the returned expression (see 6.3).
- `auto` may be used as the return type; the compiler infers it from the `return` statement.
- Function declarations may not be nested inside another function. The only exception is an anonymous inline function passed as a callback argument (see 6.4).
- `private` is a reserved keyword and cannot be used as a function name.

#### External Functions

```
extern_function_decl
  = "extern" "fn" IDENTIFIER "(" param_list? ")" return_type?
```

- Used to call functions implemented outside of ZEN (for example, C libraries).
- Does not contain a function body.
- The compiler emits the function name exactly as written (no name mangling).
- Supports all valid parameter and return types.
- If an external function returns a native pointer, use the built-in `Ptr` struct as the return type.
- `zen deps` detects and records `native/*.o`, and native objects link automatically.
- `.c` files are supported as native dependencies.
- Extra linker flags go in `zen.json` (`flags: []`, for example `-lmariadb`) or via `--link a.o b.o`.

```zen
extern fn puts(string text) int
extern fn malloc(int size) Ptr
extern fn free(Ptr memory)

Ptr memory = malloc(1024)
puts("Allocated successfully")
free(memory)
```

#### Private Functions

```
private_function_decl
  = "private" "fn" IDENTIFIER "(" param_list? ")" return_type? block
```

A private function is visible only in the current module scope and cannot be imported by other modules.

```zen
private fn helper(int a) int {
  return a * 2
}
```

> **Note:** `private` on a struct field or method has a different scope: it is accessible only inside the struct through `this`. See Struct.

#### Thread Functions

```
thread_function_decl
  = "thread" "fn" IDENTIFIER "(" param_list? ")" block
```

- Accepts parameters.
- Invalid captures are reported at compile time.
- String arguments are duplicated and freed per thread.
- Structs can also have thread methods. See Struct.

```zen
thread fn worker(int id) {
  # runs in its own thread
}
```

---

### 6.2 Parameters

Parameters are declared as **type-identifier pairs**, separated by commas. Zen is strictly typed: every parameter must carry an explicit type annotation.

#### Primitive Parameters

```zen
fn multiply(int a, int b) int {
  return a * b
}
```

Supported primitive parameter types are `int`, `double`, `bool`, `string`, `long`, and `byte`.

Fixed-size arrays cannot be used as parameters. Use `List<T>` instead.

---

#### List Parameters

List parameters use the generic syntax `List<T>` and support any level of nesting.

```zen
fn sum(List<int> nums) int { ... }

fn process(List<string> names) void { ... }

fn matrix(List<List<double>> grid) void { ... }

fn deep(List<List<List<int>>> cube) void { ... }
```

---

#### Struct Parameters

Structs can be used as function parameters.

```zen
struct Person {
  string name,
  int age
}

fn display(Person p) void {
  screen(p.name)
  screen(p.age)
}

Person user = {
  name: "Jishith",
  age: 21
}

display(user)
```

User-defined structs follow ZEN's value semantics. Passing a struct to a function passes a copy of the struct value.

```zen
fn rename(Person p) void {
  p.name = "Zen"
}

rename(user)

screen(user.name)  # Jishith
```

Built-in structs (such as `Map`, `Ptr`, `Json`, `Tcp`) use reference semantics and are passed by reference.

Functions may also return struct values.

```zen
fn createPerson() Person {
  return {
    name: "Jishith",
    age: 21
  }
}

Person user = createPerson()
```

Exported functions can take or return structs that are not exported.

---

#### Callback Parameters

A parameter can be a function, so callers can pass a named function or an anonymous inline function (see 6.4).

```zen
fn download(string url, fn cb(long downloaded, long total) void {
  ...
})
```

---

#### Default Parameters

Zen supports default values for primitive, `List`, and struct parameters. If a caller omits an argument, the default value is used.

```zen
fn greet(string name = "World") void {
  screen("Hello, " + name)
}

fn power(int base, int exp = 2) int {
  ...
}

fn process(List<int> nums = [10, 20]) void {
  ...
}

fn configure(List<string> flags = ["verbose", "safe"]) void {
  ...
}

fn show(Person p = {name: "John"}) void {
  ...
}
```

A struct literal default only sets the fields it names. The other fields keep their default or zero value.

---

#### Rest Parameters

A rest parameter collects all remaining arguments into a `List`. It must be the last parameter in the list and is declared with `...` after the identifier.

```zen
fn sum(int values...) int {
  int total = 0
  loop (item of values) {
    total += item
  }
  return total
}
```

Under the hood, `values` is a `List<int>`. When returning a rest parameter, the return type must be declared explicitly as the corresponding `List<T>` type. `auto` is not valid as a return type for `List`: the generic type parameter must be fully preserved.

```zen
fn collect(int values...) List<int> {
  return values                        # explicit List<int> return type required
}
```

```zen
fn collect(int values...) auto {       # compile-time error: auto invalid for List return
  return values
}
```

---

### 6.3 Return Statement

The `return` keyword exits the current function and optionally passes a value back to the caller.

```zen
return          # valid in void functions
return 42
return a + b
return "done"
```

- `return` is only valid inside a function block.
- A `void` function may use a bare `return` to exit early.
- The returned expression must match the declared return type.
- Fixed-size arrays cannot be returned.
- Functions may omit an explicit return type when it can be inferred from the returned expression.

```zen
fn add(int a, int b) {
  return a + b
}

int result = add(10, 20)
```

- Return type inference is supported for `int`, `bool`, `double`, `string`, `long`, and `byte`.
- Return type inference is **not supported** for `List<T>` or struct return values. These functions must declare their return type explicitly.

```zen
# Valid
fn add(int a, int b) {
  return a + b
}

# Invalid
fn getNames() {
  return ["Zen", "Lang"]
}

# Valid
fn getNames() List<string> {
  return ["Zen", "Lang"]
}

# Invalid
fn createPerson() {
  return {
    name: "Jishith",
    age: 21
  }
}

# Valid
fn createPerson() Person {
  return {
    name: "Jishith",
    age: 21
  }
}
```

---

**Exhaustive Return Required**

For non-`void` functions, Zen requires a **guaranteed return path**. Every possible execution path through the function must end in a `return` statement. This is enforced at compile time.

A `return` that only exists inside a conditional or loop does **not** satisfy this requirement: the compiler cannot guarantee it will be reached.

```zen
# Error: return is conditional, not all paths return a value
fn add(int a, int b) int {
  if (a > 20) {
    return 20
  }
  # missing return: compile-time error
}

# Error: return is inside a loop, not guaranteed to execute
fn find(List<int> nums) int {
  loop (n of nums) {
    return n
  }
  # missing return: compile-time error
}
```

```zen
# Valid: all paths return a value
fn add(int a, int b) int {
  if (a > 20) {
    return 20
  }
  return a + b
}

# Valid: unconditional return at end
fn clamp(int val) int {
  if (val < 0)   { return 0   }
  if (val > 100) { return 100 }
  return val
}
```

`void` functions are exempt: they may return early with a bare `return` or simply fall off the end of the block.

---

### 6.4 Function Calls

A function is called by its name followed by a parenthesised argument list.

```zen
greet("ZEN")
add(10, 20)
add(5 + 5, a)
int result = multiply(a, b)
string s = describe("score", 99)
```

Arguments may be literals, variables, or any valid expression.

Calls can be chained when a function returns a struct:

```zen
make().show()
```

> 💡 **Generic Function Calls**
>
> Functions may optionally specify generic type arguments using `function<Type>()`. This is primarily used by built-in APIs that return generic types, allowing the compiler to infer the complete return type safely.
>
> ```zen
> List<int> numbers = map.getList<List<int>>("numbers")
>
> List<List<string>> matrix =
>     map.getList<List<List<string>>>("matrix")
> ```
>
> This syntax is currently required only for APIs that return generic values (such as `Map.getList()`), especially when nested `List` types are involved, ensuring full compile-time type safety.

#### Callbacks

- **Named functions** passed as callbacks can use closures (outer variables allowed).
- **Anonymous inline functions** are written like a normal function declaration, directly in the argument list. They compile as separate functions and cannot capture outer variables.

```zen
call(fn name(int a) void {
  # body
})
```

---

### 6.5 Recursion

Functions may call themselves recursively. ZEN places no language-level restriction on recursion depth; stack overflow is a runtime concern.

```zen
fn factorial(int n) int {
  if (n <= 1) {
    return 1
  }
  return n * factorial(n - 1)
}
```

---

### 6.6 Hoisting

All function declarations are hoisted to the top of their scope at compile time. A function may be called before its declaration appears in the source file.

```zen
int result = add(3, 4)                 # valid: add is declared below

fn add(int a, int b) int {
  return a + b
}
```

---

### 6.7 Exports and Imports

- A file can have multiple exports and imports.
- Functions and variables can be aliased on import.
- Structs cannot be aliased on import (`ImportError`).
- Importing a struct also registers its dependent structs as hidden: usable through the struct, but not nameable.

```zen
import (worker as w)
```

```zen
export (add, Foo)
```

---

## 7. Conditionals

ZEN provides two conditional constructs: `if` and `switch`. Both control which block of code executes based on a condition.

---

### 7.1 If Statement

```
if_stmt
  = "if" "(" expression ")" block
    ("else if" "(" expression ")" block)*
    ("else" block)?
```

The condition must evaluate to `bool`. `else if` and `else` clauses are optional. Only the first matching branch executes.

```zen
if (score >= 90) {
  grade = "A"
} else if (score >= 75) {
  grade = "B"
} else if (score >= 60) {
  grade = "C"
} else {
  grade = "F"
}
```

`if` may be used without `else`:

```zen
if (active) {
  start()
}
```

---

### 7.2 Switch Statement

```
switch_stmt
  = "switch" "(" expression ")" "{" case_clause* default_clause? "}"

case_clause
  = "case" int_expr ":" block

default_clause
  = "default" ":" block
```

- The switch expression must evaluate to `int`.
- Case values must be integer literals, compile-time constants, or compile-time integer expressions. Regular variable references are not permitted in case values.
- There is no fallthrough. Each case block is implicitly terminated — no `break` is needed or permitted between cases.
- `default` is optional and executes when no case matches.

```zen
switch (status) {
  case 1: {
    # handle active
  }
  case 2: {
    # handle inactive
  }
  case 10 + 10: {
    # matches 20 — compile-time expression
  }
  default: {
    # handle unknown
  }
}
```

`break` and `continue` inside a case block refer to an enclosing loop, not the switch itself. Since switch has no fallthrough, there is no need for a switch-level `break`.

---

## 8. Ternary Expression

The ternary operator provides a compact conditional expression.

```
ternary_expr
  = expression "?" expression ":" expression
```

The condition must evaluate to `bool`. The two branches may be any expression.

```zen
int max = a > b ? a : b
string label = active ? "on" : "off"
double rate = flag ? 1.5 : 0.5
```

#### Nesting

Ternary expressions may be nested. Parentheses are recommended for clarity.

```zen
int tier = score >= 90 ? 3 : (score >= 60 ? 2 : 1)
```

#### As a Statement

A ternary may be used as a standalone statement. When used this way, the returned value is discarded.

```zen
active ? start() : stop()
```

This is valid but the return value of `start()` or `stop()` is not captured. If the value is needed, assign it:

```zen
int result = active ? start() : stop()
```

---

## 9. Loop Constructs

ZEN provides four loop forms. All loops support `break` and `continue`.

- `break` exits the innermost enclosing loop immediately.
- `continue` skips the remainder of the current iteration and proceeds to the next.

In nested loops, `break` and `continue` apply only to the loop they are directly inside.

```zen
loop (int i = 0, i < 3, i++) {
  loop (int j = 0, j < 3, j++) {
    if (j == 1) { break }              # breaks inner loop only
  }
  # outer loop continues normally
}
```

---

### 9.1 General Loop

The general loop is ZEN's primary counted iteration construct. It uses the `loop` keyword with three comma-separated clauses: initializer, condition, and update. All three are always required.

```
loop_stmt
  = "loop" "(" var_decl "," expression "," update_expr ")" block
```

```zen
loop (int i = 0, i < 10, i++) {
  # i is scoped to this loop
}

loop (int i = 0, i < 5, i++) {
  if (i == 3) { continue }
  if (i == 4) { break }
}
```

The loop variable declared in the initializer is scoped to the loop block.

> **Breaking change in v3.0.0:** the two-clause form `loop (cond, update)` was removed. Classic loops must always use `loop (init, cond, update)`.

---

### 9.2 While Loop

Executes a block repeatedly as long as the condition is `true`.

```
while_stmt
  = "while" "(" expression ")" block
```

```zen
while (active) {
  process()
}

int count = 0
while (count < 10) {
  count += 1
  if (count == 7) { break }
}
```

---

### 9.3 Do-While Loop

Executes the block at least once, then repeats as long as the condition is true.

```
do_while_stmt
  = "do" block "while" "(" expression ")"
```

```zen
do {
  fetch()
  count += 1
} while (count < 5)
```

The condition is evaluated after each iteration. `break` exits immediately; `continue` jumps to the condition check.

---

### 9.4 Loop Of: List and Array Iteration

Iterates over the elements of a `List`, fixed-size array, or rest parameter. On each iteration, the loop variable holds the current element.

```
loop_of_stmt
  = "loop" "(" IDENTIFIER "of" IDENTIFIER ")" block
```

```zen
List<int> nums = [10, 20, 30]

loop (item of nums) {
  # item is int
}

int arr[3] = [1, 2, 3]

loop (val of arr) {
  # val is int
}
```

#### Nested Iteration

For nested lists, `loop of` may be nested to iterate over inner elements.

```zen
List<List<int>> matrix = [[1, 2], [3, 4]]

loop (row of matrix) {
  loop (cell of row) {
    # cell is int
  }
}
```

`break` exits the innermost `loop of`. The outer loop continues normally.

```zen
loop (row of matrix) {
  loop (cell of row) {
    if (cell == 2) { break }           # exits inner loop only
  }
}
```

---

## 10. Modules

A module is a single `.zen` file. A file shares declarations with other files using `export` and brings them in using `import`.

---

### 10.1 Export

The `export` keyword makes global declarations available to other files.

```
export_stmt
  = "export" "(" identifier_list ")"
```

#### Rules

- A file can have multiple `export` statements.
- `export` statements must appear at the bottom of the file, after all declarations. For variables this is required; for functions it is strongly recommended.
- Global variables, functions, and struct declarations may be exported.
- Exported functions can take or return structs that are not exported.

#### Exportable Values

Only global symbols may be exported.

| Exportable | Example |
|---|---|
| Integer literal | `int a = 10` |
| Double literal | `double pi = 3.14` |
| String literal | `string name = "ZEN"` |
| Bool literal | `bool flag = true` |
| Byte literal | `byte a = 20B` |
| Long literal | `long b = 10000000000L` |
| Constant | `const int MAX = 100` |
| Global function | `fn add(int a, int b) int { ... }` |
| Struct declaration | `struct Person { ... }` |
| Global struct instance | `Person p` |
| Initialized global struct instance | `Person p = { name: "ZEN" }` |
| Static global array | `int arr[3] = [1, 2, 3]` |

#### Non-Exportable Values

| Not Exportable |
|---|
| Local variables |
| Block-scoped variables |
| Runtime-only values without a global symbol |

```zen
struct Person {
  string name,
  int age
}

Person user = {
  name: "Jishith",
  age: 21
}

fn createPerson() Person {
  return user
}

export(Person, user, createPerson)
```

---

#### Exported Files and Imports

Exported modules can also import other modules. Zen automatically resolves dependency chains and handles circular imports at compile time.

```zen
# utils.zen
import(add) from "math.zen"

fn sum(int a, int b) int {
  return add(a, b)
}

export(sum)
```

**Rules**

- Exported files may contain `import` statements.
- Circular imports are supported and resolved automatically by the compiler.
- Each module is compiled only once, even if imported multiple times.
- If a file exports identifiers, it cannot contain top-level executable code.
- Top-level expressions, loops, conditionals, function calls, and other executable statements are not permitted in exported modules.
- Global variables with literal initializers are allowed.
- Exported modules should only contain declarations such as `fn`, `struct`, global constants/variables, `import`, and `export`.
- Any executable logic should be placed inside functions and exported as needed.

---

### 10.2 Import

The `import` keyword brings exported identifiers from another file or an installed package into the current file's global scope.

```
import_stmt
  = "import" "(" import_item ("," import_item)* ")" "from" STRING_LITERAL

import_item
  = IDENTIFIER ("as" IDENTIFIER)?
```

#### Rules

- All `import` statements must appear at the top of the file, before any declarations or statements.
- Imported names must exactly match the names declared in the `export` statement of the target module.
- Local modules must reference a `.zen` file.
- Installed packages are imported by package name and **must not** include the `.zen` extension.
- Imported identifiers are used directly by name. No namespace prefix is required.
- A file can have multiple `import` statements.
- Importing a struct also registers its dependent structs as hidden: they are usable through the struct but cannot be named directly.

#### Importing a Local Module

```zen
import(a, add, MAX) from "utils.zen"

int result = add(10, 20)
int total = a + MAX
```

#### Importing an Installed Package

```zen
import(get, post) from "http"
import(format) from "colors"
```

#### Aliasing

Functions and variables can be renamed on import using `as`. Structs cannot be aliased (`ImportError`).

```zen
import(worker as w) from "utils.zen"

w()
```

#### Name Mismatch

If an imported name does not exist in the target module's export list, the compiler raises an error.

```zen
import(add, multiply) from "utils.zen"   # compile-time error if multiply is not exported
```

#### Multiple Imports

A file may import from multiple source files and installed packages using separate `import` statements.

```zen
import(add, subtract) from "math.zen"
import(greet) from "utils.zen"
import(format) from "colors"

int x = add(1, 2)
greet("ZEN")
```

---

### 10.3 Module Rules Summary

| Rule | Detail |
|---|---|
| Multiple `export` allowed | A file can have more than one `export` statement |
| Export at bottom | Required for variables; recommended for functions |
| Exported modules may import | Exporting files are allowed to import other modules and packages |
| No top-level executable code | Exported modules cannot contain expressions, loops, conditionals, function calls, or other executable statements outside functions |
| Import at top | All imports must precede any other declarations or statements |
| Direct name access | Imported identifiers are used directly, with no namespace prefix |
| Exact name match | Imported names must match the export list exactly |
| Aliasing | Functions and variables only; structs cannot be aliased |
| Local modules | Local file imports must reference `.zen` files |
| Installed packages | Installed packages are imported by package name without the `.zen` extension |
| Circular imports | Supported and automatically resolved by the compiler |

---

## 11. Standard Library

ZEN's standard library is divided into four parts:

- **Global Constants** — pre-defined immutable values available everywhere
- **Core Functions** — general-purpose built-ins compiled directly into the compiler
- **Namespaced Modules** — system-level built-ins accessed via `namespace.function()` syntax
- **Standard Functions** — utility functions written in ZEN itself (bootstrapped stdlib)

All standard library identifiers are reserved and cannot be redeclared by user code.

---

### 11.1 Global Constants

Global constants are pre-defined values available in every ZEN program without any import. They are used directly by name.

```zen
screen(PI)
double area = PI * r * r
```

#### Mathematical Constants

| Name | Type | Value | Description |
|---|---|---|---|
| `PI` | `double` | `3.14159265358979...` | Ratio of circumference to diameter |
| `TAU` | `double` | `6.28318530717958...` | `2 * PI` |
| `E` | `double` | `2.71828182845904...` | Euler's number |
| `PHI` | `double` | `1.61803398874989...` | Golden ratio |
| `SQRT2` | `double` | `1.41421356237309...` | Square root of 2 |
| `SQRT1_2` | `double` | `0.70710678118654...` | Square root of 1/2 |
| `SQRT3` | `double` | `1.73205080756887...` | Square root of 3 |
| `LN2` | `double` | `0.69314718055994...` | Natural log of 2 |
| `LN10` | `double` | `2.30258509299404...` | Natural log of 10 |
| `LOG2E` | `double` | `1.44269504088896...` | Base-2 log of `E` |
| `LOG10E` | `double` | `0.43429448190325...` | Base-10 log of `E` |

#### Numeric Bounds

| Name | Type | Description |
|---|---|---|
| `BYTE_MAX` | `byte` | Maximum value of a byte (127) |
| `BYTE_MIN` | `byte` | Minimum value of a byte (-128) |
| `I32_MAX` | `int` | Maximum value of a 32-bit integer |
| `I32_MIN` | `int` | Minimum value of a 32-bit integer |
| `I64_MAX` | `long` | Maximum value of a 64-bit integer |
| `I64_MIN` | `long` | Minimum value of a 64-bit integer |
| `F64_MAX` | `double` | Maximum finite 64-bit float |
| `F64_MIN` | `double` | Minimum positive 64-bit float |
| `F64_EPS` | `double` | Smallest difference between two doubles |

#### Special Float Values

| Name | Type | Description |
|---|---|---|
| `INF` | `double` | Positive infinity |
| `NEG_INF` | `double` | Negative infinity |
| `NAN` | `double` | Not a number |

#### Mutable Global

| Name | Type | Mutable | Description |
|---|---|---|---|
| `SEED` | `int` | Yes | Seed value for random number generation |

`SEED` is the only mutable global constant. Assigning to it affects subsequent `random()` and `randomInt()` calls.

```zen
SEED = 42
double r = random()
```

---

### 11.2 Core Functions

Core functions are built directly into the compiler and available globally without any namespace prefix.

---

#### `screen`

Prints a value to standard output.

```
screen(value, format?)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `value` | any | Yes | The value to print |
| `format` | `string` | No | C-style format string |

Returns `void`.

```zen
screen("hello")
screen(42)
screen(3.14)
screen(true)
screen(42, "%d items")
screen(3.14, "%.2f")
```

---

#### `input`

Reads a line from standard input and returns it as a `string`. The caller is responsible for converting it to the required type using Zen's type conversion functions.

```
input(prompt?) → string
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `prompt` | `string` | No | Text to display before reading input |

**Basic Usage**

```zen
string name = input("Enter name: ")
string raw  = input()
```

`input()` always returns a `string`, even if the user types a number.

```zen
string age = input("Enter age: ")   # user types 23 → age is "23"
```

**Type Conversion**

To work with the input as a specific type, use Zen's type conversion functions:

```zen
int age       = Int(input("Enter age: "))
double price  = Double(input("Enter price: "))
bool confirm  = Bool(input("Enter true/false: "))
long maxAge   = Long("10292929292982828")
byte b        = Byte(12)
```

**Flexible Usage**

Unlike many languages, `input()` in Zen is a first-class expression. It can be used anywhere a `string` value is valid: inline in expressions, as a function argument, or as a standalone statement.

```zen
# Standalone
input()

# Inline expression
screen("Hello, " + input("Name: "))

# As function argument
process(input("Enter value: "))

# In condition (after conversion)
if (Int(input("Enter number: ")) > 100) {
  screen("Large number")
}
```

---

#### `type`

Returns the type name of a value as a `string`.

```
type(value)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `value` | any | Yes | The value to inspect |

Returns `string`.

```zen
string t = type(42)          # "int"
string t = type(3.14)        # "double"
string t = type("hello")     # "string"
string t = type(true)        # "bool"
```

---

#### `length`

Returns the number of elements in a `List` or fixed-size array, or the number of characters in a `string`.

```
length(value)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `value` | `string`, `List<T>`, or array | Yes | The value to measure |

Returns `int`.

For a `List`, `length(nums)` is the same as the `nums.length` property.

```zen
int len = length("hello")           # 5
int len = length([1, 2, 3])         # 3
List<int> nums = [10, 20, 30]
int len = length(nums)              # 3
```

---

#### `stringToBytes`

Converts a `string` to a `List<byte>`.

```
stringToBytes(text)
```

Returns `List<byte>`.

```zen
List<byte> data = stringToBytes("hello")
```

---

#### `bytesToString`

Converts a `List<byte>` to a `string`.

```
bytesToString(bytes)
```

Returns `string`.

```zen
string text = bytesToString(data)
```

---

#### Type Conversion Functions

ZEN provides six explicit type conversion functions: `Int`, `Double`, `Bool`, `String`, `Byte`, and `Long`. These are the only supported forms of general explicit conversion.

---

#### `Int`

Converts a value to `int`.

```
Int(value)
```

Returns `int`.

```zen
int a = Int(3.99)        # 3, truncates
int b = Int("42")        # 42
int c = Int(true)        # 1
int d = Int(false)       # 0
```

---

#### `Double`

Converts a value to `double`.

```
Double(value)
```

Returns `double`.

```zen
double a = Double(10)          # 10.0
double b = Double("3.14")      # 3.14
double c = Double(true)        # 1.0
```

---

#### `Bool`

Converts a value to `bool`.

```
Bool(value)
```

Returns `bool`.

```zen
bool a = Bool(1)          # true
bool b = Bool(0)          # false
bool c = Bool("true")     # true
bool d = Bool("false")    # false
```

---

#### `String`

Converts a value to `string`.

```
String(value)
```

Returns `string`.

```zen
string a = String(42)        # "42"
string b = String(3.14)      # "3.14"
string c = String(true)      # "true"
```

---

#### `Byte`

Converts an `int` to `byte`. `byte` is signed (-128 to 127).

```
Byte(value)
```

Returns `byte`.

```zen
List<byte> bytes

bytes.push(Byte(65))
bytes.push(Byte(127))
```

---

#### `Long`

Converts a value to `long`.

```
Long(value)
```

Returns `long`.

```zen
long a = Long(42)
long b = Long(3.99)
long c = Long("42")
long d = Long(true)
long e = Long(false)
```

---

#### ASCII Conversion Functions

`intToAscii` and `asciiToInt` convert between ASCII codes and characters. They are not general type conversions. For general conversion, use `String()` and `Int()`.

> **Breaking change in v3.0.0:** `toString()` was renamed to `intToAscii()`, and `toInt()` was renamed to `asciiToInt()`.

---

#### `intToAscii`

Takes an integer ASCII code and returns the corresponding character as a `string`. For example, `intToAscii(65)` returns `"A"`, not `"65"`.

```
intToAscii(value)
```

Returns `string`.

```zen
string s = intToAscii(99)      # "c", the ASCII character for 99
```

---

#### `asciiToInt`

Takes a single-character `string` and returns its ASCII code as an `int`. For example, `asciiToInt("A")` returns `65`, not a parsed number. Passing multi-character strings or expecting it to parse numeric strings will produce unexpected results.

```
asciiToInt(value)
```

Returns `int`.

```zen
int n = asciiToInt("A")       # 65, the ASCII code of A
int m = asciiToInt("a")       # 97, the ASCII code of a
```

---

### 11.3 Namespaced Modules

Namespaced functions are accessed using dot notation: `namespace.function()`. The underlying compiler built-ins use internal `_namespace_name` identifiers, but ZEN source always uses the dot form.

```zen
string name = os.osName()
bool connected = net.online()
```

---

#### 11.3.1 `sys`

System-level process control.

---

##### `sys.panic`

Immediately terminates the program with an error message.

```
sys.panic(message)
```

| Parameter | Type | Description |
|---|---|---|
| `message` | `string` | Error message to display before exit |

Returns `void`.

```zen
if (x < 0) {
  sys.panic("negative value not allowed")
}
```

---

##### `sys.key`

Reads a single key press from the terminal.

```
sys.key()
```

Returns `string`.

```zen
string key = sys.key()
screen(key)
```

---

##### `sys.setEnv`

Sets an environment variable for the current process.

```
sys.setEnv(key, value)
```

| Parameter | Type | Description |
|---|---|---|
| `key` | `string` | Environment variable name |
| `value` | `string` | Value to assign |

Returns `void`.

```zen
sys.setEnv("API_KEY", "123456")
```

---

##### `sys.getEnv`

Reads an environment variable by name.

```
sys.getEnv(name)
```

| Parameter | Type | Description |
|---|---|---|
| `name` | `string` | Environment variable name |

Returns `string`.

```zen
string path = sys.getEnv("PATH")
string home = sys.getEnv("HOME")
```

---

##### `sys.hasEnv`

Checks whether an environment variable exists.

```
sys.hasEnv(key)
```

| Parameter | Type | Description |
|---|---|---|
| `key` | `string` | Environment variable name |

Returns `bool`.

```zen
if (sys.hasEnv("API_KEY")) {
  screen("Found")
}
```

---

##### `sys.execOutput`

Executes a system command and returns its standard output.

```
sys.execOutput(command)
```

| Parameter | Type | Description |
|---|---|---|
| `command` | `string` | Command to execute |

Returns `string`.

```zen
string out = sys.execOutput("pwd")
screen(out)
```

---

##### `sys.spawn`

Starts a command as a separate process without waiting for it to finish.

```
sys.spawn(command)
```

| Parameter | Type | Description |
|---|---|---|
| `command` | `string` | Command to run |

Returns `long`: the process ID.

```zen
long pid = sys.spawn("sleep 30")
```

---

##### `sys.isRunning`

Checks whether a spawned process is still running.

```
sys.isRunning(pid)
```

| Parameter | Type | Description |
|---|---|---|
| `pid` | `long` | Process ID returned by `sys.spawn` |

Returns `bool`.

```zen
if (sys.isRunning(pid)) {
  screen("still running")
}
```

---

##### `sys.exec`

Executes a shell command and returns its raw exit status.

```
sys.exec(command)
```

| Parameter | Type | Description |
|---|---|---|
| `command` | `string` | Shell command to execute |

Returns `int`: the raw status of the command. `0` means success. For a non-zero exit, the exit code is in the upper bits, so `exit 5` returns `1280` (`5 << 8`). Use `status >> 8` to get the exit code.

```zen
int status = sys.exec("exit 5")      # 1280
int code = status >> 8               # 5
```

---

##### `sys.wait`

Blocks until a spawned process finishes.

```
sys.wait(pid)
```

| Parameter | Type | Description |
|---|---|---|
| `pid` | `long` | Process ID returned by `sys.spawn` |

Returns `int`: the exit code of the process. If the process was stopped by a signal, the result is `128` plus the signal number (for example, `143` for signal `15`).

```zen
long pid = sys.spawn("false")
int code = sys.wait(pid)             # 1
```

---

##### `sys.kill`

Sends a signal to a process.

```
sys.kill(pid, signal)
```

| Parameter | Type | Description |
|---|---|---|
| `pid` | `long` | Process ID returned by `sys.spawn` |
| `signal` | `int` | Signal number to send (for example `15` to terminate, `9` to force kill) |

Returns `int`: `0` on success, `-1` on failure (for example, if the process does not exist).

```zen
int result = sys.kill(pid, 15)
```

---

##### `sys.argv`

Returns the command-line arguments passed to the program as a `List<string>`.

```
sys.argv()
```

Returns `List<string>`.

```zen
List<string> args = sys.argv()

loop (arg of args) {
  screen(arg)
}
```

> `args[0]` is always the path to the compiled binary.

---

##### `sys.performance`

Returns the current monotonic time in milliseconds as a `double`. Used for benchmarking and measuring execution time.

```
sys.performance()
```

Returns `double`.

```zen
double start = sys.performance()

# ... code to benchmark ...

double end = sys.performance()
screen(end - start)                    # elapsed time in ms
```

---

##### `sys.color`

Changes the terminal output color using ANSI formatting. Affects all subsequent `screen` output until changed again.

```
sys.color(name)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `name` | `string` | Yes | ANSI color name e.g. `"red"`, `"green"`, `"reset"` |

Returns `void`.

```zen
sys.color("red")
screen("error occurred")
sys.color("reset")
screen("back to normal")
```

---

##### Clipboard

> **Warning:** Clipboard support depends on the operating system and desktop environment. Some platforms (such as Android Termux or headless Linux systems) may not provide a system clipboard.

##### `sys.clipboard.get`

Returns the current clipboard text.

```
sys.clipboard.get()
```

Returns `string`.

```zen
string text = sys.clipboard.get()
screen(text)
```

---

##### `sys.clipboard.set`

Sets the system clipboard text.

```
sys.clipboard.set(text)
```

| Parameter | Type | Description |
|---|---|---|
| `text` | `string` | Text to copy to the clipboard |

Returns `void`.

```zen
sys.clipboard.set("Hello from ZEN")
```

---

##### `sys.clipboard.clear`

Clears the system clipboard.

```
sys.clipboard.clear()
```

Returns `void`.

```zen
sys.clipboard.clear()
```

---

##### `sys.clipboard.hasText`

Checks whether the system clipboard currently contains text.

```
sys.clipboard.hasText()
```

Returns `bool`.

```zen
if (sys.clipboard.hasText()) {
  screen(sys.clipboard.get())
}
```

---

#### 11.3.2 `crypto`

Cryptographic utilities for hashing, HMAC, secure random generation, and Base64 encoding/decoding.

---

##### `crypto.sha256`

Computes the SHA-256 cryptographic hash of the input data.

```
crypto.sha256(data)
```

| Parameter | Type | Description |
|---|---|---|
| `data` | `string` | Data to hash |

Returns `List<byte>`.

```zen
List<byte> hash = crypto.sha256("Hello Zen")
```

---

##### `crypto.sha512`

Computes the SHA-512 cryptographic hash of the input data.

```
crypto.sha512(data)
```

| Parameter | Type | Description |
|---|---|---|
| `data` | `string` | Data to hash |

Returns `List<byte>`.

```zen
List<byte> hash = crypto.sha512("Hello Zen")
```

---

##### `crypto.hmacSha256`

Computes an HMAC using SHA-256 with the specified key.

```
crypto.hmacSha256(key, data)
```

| Parameter | Type | Description |
|---|---|---|
| `key` | `string` | Secret key used for HMAC |
| `data` | `string` | Data to authenticate |

Returns `List<byte>`.

```zen
List<byte> mac = crypto.hmacSha256("secret", "Hello Zen")
```

---

##### `crypto.hmacSha512`

Computes an HMAC using SHA-512 with the specified key.

```
crypto.hmacSha512(key, data)
```

| Parameter | Type | Description |
|---|---|---|
| `key` | `string` | Secret key used for HMAC |
| `data` | `string` | Data to authenticate |

Returns `List<byte>`.

```zen
List<byte> mac = crypto.hmacSha512("secret", "Hello Zen")
```

---

##### `crypto.randomBytes`

Generates cryptographically secure random bytes.

```
crypto.randomBytes(length)
```

| Parameter | Type | Description |
|---|---|---|
| `length` | `int` | Number of random bytes to generate |

Returns `List<byte>`.

```zen
List<byte> bytes = crypto.randomBytes(32)
```

---

##### `crypto.randomInt`

Generates a cryptographically secure random integer within the specified range.

```
crypto.randomInt(min, max)
```

| Parameter | Type | Description |
|---|---|---|
| `min` | `int` | Minimum value |
| `max` | `int` | Maximum value |

Returns `int`.

```zen
int value = crypto.randomInt(1, 100)
screen(value)
```

---

##### `crypto.base64Encode`

Encodes byte data using standard Base64 encoding.

```
crypto.base64Encode(data)
```

| Parameter | Type | Description |
|---|---|---|
| `data` | `List<byte>` | Data to encode |

Returns `string`.

```zen
List<byte> data = crypto.randomBytes(16)
string encoded = crypto.base64Encode(data)

screen(encoded)
```

---

##### `crypto.base64Decode`

Decodes a standard Base64 string into bytes.

```
crypto.base64Decode(data)
```

| Parameter | Type | Description |
|---|---|---|
| `data` | `string` | Base64-encoded data |

Returns `List<byte>`.

```zen
List<byte> decoded = crypto.base64Decode(encoded)
```

---

##### `crypto.base64UrlEncode`

Encodes byte data using Base64URL encoding.

Base64URL is URL-safe and is commonly used by protocols such as JSON Web Tokens (JWT).

```
crypto.base64UrlEncode(data)
```

| Parameter | Type | Description |
|---|---|---|
| `data` | `List<byte>` | Data to encode |

Returns `string`.

```zen
List<byte> data = crypto.randomBytes(16)
string encoded = crypto.base64UrlEncode(data)

screen(encoded)
```

---

##### `crypto.base64UrlDecode`

Decodes a Base64URL-encoded string into bytes.

```
crypto.base64UrlDecode(data)
```

| Parameter | Type | Description |
|---|---|---|
| `data` | `string` | Base64URL-encoded data |

Returns `List<byte>`.

```zen
List<byte> decoded = crypto.base64UrlDecode(encoded)
```

---

#### 11.3.3 `fs`

File system operations.

---

##### `fs.readFile`

Reads the full contents of a file and returns it as a string.

```
fs.readFile(path)
```

Returns `string`.

```zen
string content = fs.readFile("data.txt")
```

---

##### `fs.writeFile`

Writes a string to a file, overwriting existing content.

```
fs.writeFile(path, content)
```

Returns `int`: `0` on success, non-zero on failure.

```zen
int result = fs.writeFile("out.txt", "hello ZEN")
```

---

##### `fs.readFileBytes`

Reads the full contents of a file and returns it as a `List<byte>`.

```
fs.readFileBytes(path)
```

Returns `List<byte>`.

```zen
List<byte> data = fs.readFileBytes("image.png")
```

---

##### `fs.writeFileBytes`

Writes a `List<byte>` to a file.

```
fs.writeFileBytes(path, data)
```

Returns `int`: `0` on success, non-zero on failure.

> **Breaking change in v3.0.0:** `fs.writeFileBytes()` now returns `int` (a success code) instead of `void`.

```zen
List<byte> data = fs.readFileBytes("image.png")

int result = fs.writeFileBytes("copy.png", data)
```

---

##### `fs.appendFile`

Appends a string to an existing file without overwriting.

```
fs.appendFile(path, content)
```

Returns `int`: `0` on success, non-zero on failure.

```zen
int result = fs.appendFile("log.txt", "new entry\n")
```

---

##### `fs.exists`

Checks whether a file or directory exists at the given path.

```
fs.exists(path)
```

Returns `bool`.

```zen
bool found = fs.exists("config.zen")
```

---

##### `fs.isFile`

Checks whether the given path is a file.

```
fs.isFile(path)
```

Returns `bool`.

```zen
bool file = fs.isFile("data.txt")
```

---

##### `fs.isDir`

Checks whether the given path is a directory.

```
fs.isDir(path)
```

Returns `bool`.

```zen
bool dir = fs.isDir("output")
```

---

##### `fs.listDir`

Lists the entries in a directory.

```
fs.listDir(path)
```

Returns `List<string>`.

```zen
List<string> entries = fs.listDir(".")

loop (entry of entries) {
  screen(entry)
}
```

---

##### `fs.deleteFile`

Deletes a file at the given path.

```
fs.deleteFile(path)
```

Returns `int`: `0` on success, non-zero on failure.

```zen
int result = fs.deleteFile("temp.txt")
```

---

##### `fs.renameFile`

Renames or moves a file.

```
fs.renameFile(oldPath, newPath)
```

Returns `int`: `0` on success, non-zero on failure.

```zen
int result = fs.renameFile("old.txt", "new.txt")
```

---

##### `fs.makeDir`

Creates a new directory at the given path.

```
fs.makeDir(path)
```

Returns `int`: `0` on success, non-zero on failure.

```zen
int result = fs.makeDir("output")
```

---

##### `fs.cwd`

Returns the current working directory as a string.

```
fs.cwd()
```

Returns `string`.

```zen
string dir = fs.cwd()
screen(dir)
```

---

##### `fs.changeDir`

Changes the current working directory.

```
fs.changeDir(path)
```

Returns `int`: `0` on success, non-zero on failure.

```zen
int result = fs.changeDir("../project")
```

---

#### 11.3.4 `os`

Operating system and hardware information.

| Function | Returns | Description |
|---|---|---|
| `os.cpuCount()` | `int` | Number of logical CPU cores |
| `os.cpuArch()` | `string` | CPU architecture e.g. `"x86_64"` |
| `os.cpuModel()` | `string` | CPU model name |
| `os.cpuSpeed()` | `double` | CPU clock speed in GHz |
| `os.totalMemory()` | `long` | Total system RAM in bytes |
| `os.freeMemory()` | `long` | Available RAM in bytes |
| `os.usedMemory()` | `long` | Used RAM in bytes |
| `os.processMemory()` | `long` | RAM used by the current Zen process in bytes |
| `os.osName()` | `string` | Operating system name e.g. `"Linux"` |
| `os.osVersion()` | `string` | OS version string |
| `os.hostname()` | `string` | Machine hostname |
| `os.username()` | `string` | Current logged-in username |
| `os.uptime()` | `int` | System uptime in seconds |
| `os.battery()` | `string` | Battery status string |
| `os.exit(code)` | `void` | Terminates the current process with the specified exit code |
| `os.pid()` | `long` | Returns the current process ID |
| `os.parentPid()` | `long` | Returns the parent process ID |
| `os.platform()` | `string` | Returns the current operating system platform |
| `os.isWindows()` | `bool` | Returns `true` if running on Windows |
| `os.isLinux()` | `bool` | Returns `true` if running on Linux |
| `os.isMac()` | `bool` | Returns `true` if running on macOS |
| `os.isAndroid()` | `bool` | Returns `true` if running on Android |
| `os.homeDir()` | `string` | Returns the current user's home directory |

```zen
screen(os.osName())
screen(os.cpuCount())
screen(os.platform())

if (os.isLinux()) {
  screen("Running on Linux")
}

long mem = os.freeMemory()
screen(os.pid())
screen(os.homeDir())
```

---

#### 11.3.5 `net`

Network functions.

| Function | Returns | Description |
|---|---|---|
| `net.online()` | `bool` | Checks whether the system has an active network connection |
| `net.connect(host, port)` | `Tcp` | Opens a TCP connection to `host` (`string`) on `port` (`int`) |
| `net.listen(port)` | `TcpServer` | Starts a TCP server on `port` (`int`) |

`Tcp` and `TcpServer` are built-in structs. Their methods are documented under Built-in Structs.

```zen
bool connected = net.online()
if (connected) {
  screen("network available")
}

Tcp conn = net.connect("example.com", 80)
TcpServer server = net.listen(9000)
```

---

#### 11.3.6 `time`

Time and date functions.

---

##### `time.sleep`

Pauses execution for a given number of milliseconds.

```
time.sleep(ms)
```

| Parameter | Type | Description |
|---|---|---|
| `ms` | `long` | Duration to sleep in milliseconds |

Returns `void`.

```zen
time.sleep(1000L)       # pause for 1 second
```

---

##### `time.now`

Returns the current Unix timestamp in milliseconds.

```
time.now()
```

Returns `long`.

```zen
long ts = time.now()
screen(ts)
```

---

##### `time.format`

Formats a Unix timestamp (milliseconds) into a human-readable local date and time string.

```
time.format(timestamp)
```

| Parameter | Type | Description |
|---|---|---|
| `timestamp` | `long` | Unix timestamp in milliseconds |

Returns `string`.

```zen
long ts = time.now()
screen(time.format(ts))
```

---

##### `time.time`

Returns the current local time as a formatted string.

```
time.time()
```

Returns `string`.

```zen
string now = time.time()
screen(now)            # e.g. "14:32:05"
```

---

##### `time.millis`

Returns the current Unix timestamp in milliseconds.

```
time.millis()
```

Returns `long`.

```zen
long start = time.millis()
# ... work ...
long elapsed = time.millis() - start
```

---

##### `time.date`

Returns the current day of the month.

```
time.date()
```

Returns `int`.

```zen
int d = time.date()    # e.g. 29
```

---

##### `time.day`

Returns the current day of the week as an integer (0 = Sunday, 6 = Saturday).

```
time.day()
```

Returns `int`.

```zen
int d = time.day()     # e.g. 5 for Friday
```

---

##### `time.month`

Returns the current month as an integer (1 = January, 12 = December).

```
time.month()
```

Returns `int`.

```zen
int m = time.month()   # e.g. 5 for May
```

---

##### `time.year`

Returns the current year.

```
time.year()
```

Returns `int`.

```zen
int y = time.year()    # e.g. 2026
```

---

#### 11.3.7 `http`

HTTP client functions. Request functions take a URL as the first parameter and return the response body as a `string`, except `http.getProgress`, which returns `List<byte>`.

> **Timeouts:**
> - The connect timeout is **10 seconds** for every request.
> - Requests without a progress callback have a **30 second** total limit.
> - Requests with a progress callback (`http.getProgress`) have no total limit. They abort only if the speed stays below 1 KB/s for 30 seconds.
> - On a network failure or timeout, a `NetworkError` is printed and the program exits.
> - Timeouts are not configurable, and there is no retry or resume.

---

##### `http.get`

Sends an HTTP GET request.

```
http.get(url)
```

Returns `string`: the response body.

```zen
string res = http.get("https://api.example.com/data")
```

---

##### `http.getProgress`

Downloads a URL and reports progress through a callback. Returns the data as `List<byte>` for low-level control.

```
http.getProgress(url, callback)
```

| Parameter | Type | Description |
|---|---|---|
| `url` | `string` | Request URL |
| `callback` | `fn cb(long downloaded, long total) void` | Called with the downloaded and total bytes |

Returns `List<byte>`.

```zen
List<byte> data = http.getProgress(url, fn cb(long downloaded, long total) void {
  screen(downloaded)
})
```

---

##### `http.post`

Sends an HTTP POST request with a body.

```
http.post(url, body)
```

| Parameter | Type | Description |
|---|---|---|
| `url` | `string` | Request URL |
| `body` | `string` | Request body |

Returns `string`.

```zen
string res = http.post("https://api.example.com/users", "{\"name\":\"ZEN\"}")
```

---

##### `http.put`

Sends an HTTP PUT request.

```
http.put(url, body)
```

Returns `string`.

```zen
string res = http.put("https://api.example.com/users/1", "{\"name\":\"updated\"}")
```

---

##### `http.patch`

Sends an HTTP PATCH request.

```
http.patch(url, body)
```

Returns `string`.

```zen
string res = http.patch("https://api.example.com/users/1", "{\"age\":22}")
```

---

##### `http.delete`

Sends an HTTP DELETE request.

```
http.delete(url)
```

Returns `string`.

```zen
string res = http.delete("https://api.example.com/users/1")
```

---

##### `http.urlEncode`

Encodes a string for safe use in a URL.

```
http.urlEncode(text)
```

Returns `string`: the URL-encoded string.

```zen
string encoded = http.urlEncode("Hello World!")
```

---

##### `http.urlDecode`

Decodes a URL-encoded string.

```
http.urlDecode(text)
```

Returns `string`: the decoded string.

```zen
string decoded = http.urlDecode("Hello%20World%21")
```

---

##### `http.setHeader`

Sets a default HTTP header used for subsequent requests.

```
http.setHeader(name, value)
```

Returns `void`.

```zen
http.setHeader("Authorization", "Bearer token")
http.setHeader("User-Agent", "Zen")
```

---

##### `http.clearHeaders`

Clears all previously set default HTTP headers.

```
http.clearHeaders()
```

Returns `void`.

---

##### `http.lastStatus`

Returns the HTTP status code of the last request.

```
http.lastStatus()
```

Returns `int`.

```zen
http.get("https://api.example.com/data")

int status = http.lastStatus()
screen(status)
```

---

#### 11.3.8 `ffi`

Foreign Function Interface (FFI) bindings to selected C standard library functions.

##### Available Functions

| Function | Description |
|---|---|
| `ffi.printf` | Prints formatted output |
| `ffi.puts` | Prints a string followed by a newline |
| `ffi.putchar` | Writes a single character |
| `ffi.getchar` | Reads a single character |
| `ffi.strlen` | Returns string length |
| `ffi.strcmp` | Compares two strings |
| `ffi.strncmp` | Compares the first `n` characters of two strings |
| `ffi.pow` | Raises a value to a power |
| `ffi.sqrt` | Returns square root |
| `ffi.fabs` | Returns absolute value of a floating-point number |
| `ffi.floor` | Rounds down |
| `ffi.ceil` | Rounds up |
| `ffi.round` | Rounds to nearest integer |
| `ffi.sin` | Sine |
| `ffi.cos` | Cosine |
| `ffi.tan` | Tangent |
| `ffi.log` | Natural logarithm |
| `ffi.exp` | Exponential function |
| `ffi.system` | Executes a system command |
| `ffi.abort` | Aborts program execution |
| `ffi.clock` | Returns processor time used |
| `ffi.rand` | Returns a pseudo-random integer |
| `ffi.srand` | Seeds the random number generator |
| `ffi.abs` | Returns absolute value of an integer |
| `ffi.atoi` | Converts string to integer |
| `ffi.atof` | Converts string to double |
| `ffi.toupper` | Converts character to uppercase |
| `ffi.tolower` | Converts character to lowercase |
| `ffi.isalpha` | Checks for alphabetic character |
| `ffi.isdigit` | Checks for numeric digit |
| `ffi.isspace` | Checks for whitespace character |
| `ffi.fmod` | Floating-point remainder |
| `ffi.log10` | Base-10 logarithm |
| `ffi.log2` | Base-2 logarithm |
| `ffi.atan` | Arc tangent |
| `ffi.asin` | Arc sine |
| `ffi.acos` | Arc cosine |
| `ffi.atan2` | Arc tangent of y/x |
| `ffi.sinh` | Hyperbolic sine |
| `ffi.cosh` | Hyperbolic cosine |
| `ffi.tanh` | Hyperbolic tangent |
| `ffi.trunc` | Truncates fractional part |
| `ffi.cbrt` | Cube root |
| `ffi.isupper` | Checks for uppercase character |
| `ffi.islower` | Checks for lowercase character |
| `ffi.isalnum` | Checks for alphanumeric character |
| `ffi.ispunct` | Checks for punctuation character |
| `ffi.isxdigit` | Checks for hexadecimal digit |

##### Examples

```zen
ffi.puts("Hello from FFI")

int len = ffi.strlen("ZEN")

double root = ffi.sqrt(144.0)

int value = ffi.atoi("123")
```

---

#### 11.3.9 `httpServer`

The `httpServer` namespace provides a built-in HTTP server for handling incoming HTTP requests.

##### `httpServer.create`

Creates a new HTTP server bound to the specified port.

```
httpServer.create(port)
```

| Parameter | Type | Description |
|---|---|---|
| `port` | `int` | Port number to listen on |

Returns `HttpServer`.

```zen
HttpServer server = httpServer.create(8080)
```

---

#### 11.3.10 `threads`

Utilities for working with threads.

---

##### `threads.waitAll`

Blocks execution until all running threads have finished.

```
threads.waitAll()
```

Returns `void`.

```zen
thread fn worker() {
  screen("Working...")
}

worker()

threads.waitAll()
screen("Done")
```

---

##### `threads.count`

Returns the number of running threads.

```
threads.count()
```

Returns `long`.

```zen
long running = threads.count()
```

---

##### `threads.currentId`

Returns the ID of the current thread.

```
threads.currentId()
```

Returns `long`.

```zen
long id = threads.currentId()
```

---

#### 11.3.11 `path`

File path manipulation utilities.

---

##### `path.basename`

Returns the final component of a file path.

```
path.basename(path)
```

| Parameter | Type | Description |
|---|---|---|
| `path` | `string` | File path |

Returns `string`.

```zen
string name = path.basename("/home/user/file.txt")   # "file.txt"
```

---

##### `path.dirname`

Returns the directory component of a file path.

```
path.dirname(path)
```

| Parameter | Type | Description |
|---|---|---|
| `path` | `string` | File path |

Returns `string`.

```zen
string dir = path.dirname("/home/user/file.txt")   # "/home/user"
```

---

##### `path.extname`

Returns the file extension of a path.

```
path.extname(path)
```

| Parameter | Type | Description |
|---|---|---|
| `path` | `string` | File path |

Returns `string`.

```zen
string ext = path.extname("/home/user/file.txt")   # ".txt"
```

---

##### `path.join`

Joins two path components into a single path.

```
path.join(path, other)
```

| Parameter | Type | Description |
|---|---|---|
| `path` | `string` | First path component |
| `other` | `string` | Second path component |

Returns `string`.

```zen
string full = path.join("/home/user", "file.txt")   # "/home/user/file.txt"
```

---

##### `path.normalize`

Normalizes a file path by resolving redundant path components.

```
path.normalize(path)
```

| Parameter | Type | Description |
|---|---|---|
| `path` | `string` | File path to normalize |

Returns `string`.

```zen
string normalized = path.normalize("/home/user/../user/file.txt")   # "/home/user/file.txt"
```

---

#### 11.3.12 `debug`

Debugging and value inspection utilities.

---

##### `debug.pretty`

Pretty-prints a `List`, `Map`, or struct as readable text.

```
debug.pretty(value)
```

| Parameter | Type | Description |
|---|---|---|
| `value` | `any` | List, Map, or struct to pretty-print |

Returns `string`.

```zen
List<int> numbers = [1, 2, 3]
string result = debug.pretty(numbers)
screen(result)
```

---

### 11.4 Standard Functions

Standard functions are written in ZEN itself as a bootstrapped standard library. They are available globally without any namespace prefix and cover math, string manipulation, and general utilities.

---

#### 11.4.1 Basic Numeric

---

##### `isEven`
```
isEven(n) → bool
```
Returns `true` if `n` is even.
```zen
bool r = isEven(4)      # true
```

---

##### `isOdd`
```
isOdd(n) → bool
```
Returns `true` if `n` is odd.
```zen
bool r = isOdd(3)       # true
```

---

##### `isPositive`
```
isPositive(n) → bool
```
Returns `true` if `n` is greater than zero.
```zen
bool r = isPositive(5)  # true
```

---

##### `isNegative`
```
isNegative(n) → bool
```
Returns `true` if `n` is less than zero.
```zen
bool r = isNegative(-3) # true
```

---

##### `abs`
```
abs(n) → int
```
Returns the absolute value of `n`.
```zen
int r = abs(-10)        # 10
```

---

##### `max`
```
max(a, b) → int
```
Returns the larger of two integers.
```zen
int r = max(3, 7)       # 7
```

---

##### `min`
```
min(a, b) → int
```
Returns the smaller of two integers.
```zen
int r = min(3, 7)       # 3
```

---

##### `clamp`
```
clamp(value, low, high) → int
```
Constrains `value` to the range `[low, high]`.
```zen
int r = clamp(15, 0, 10)   # 10
int r = clamp(-5, 0, 10)   # 0
int r = clamp(5, 0, 10)    # 5
```

---

##### `sign`
```
sign(n) → int
```
Returns `1` if `n` is positive, `-1` if negative, `0` if zero.
```zen
int r = sign(-99)       # -1
int r = sign(0)         # 0
```

---

#### 11.4.2 Math

---

##### `pow`
```
pow(base, exp) → double
```
Returns `base` raised to the power of `exp`.
```zen
double r = pow(2, 10)   # 1024.0
```

---

##### `sqrt`
```
sqrt(double n) → double
```
Returns the square root of `n`.
```zen
double r = sqrt(16.0)     # 4.0
```

---

##### `square`
```
square(n) → int
```
Returns `n * n`.
```zen
int r = square(5)       # 25
```

---

##### `cube`
```
cube(n) → int
```
Returns `n * n * n`.
```zen
int r = cube(3)         # 27
```

---

##### `sin`
```
sin(x) → double
```
Returns the sine of `x` in radians.
```zen
double r = sin(PI / 2)  # 1.0
```

---

##### `cos`
```
cos(x) → double
```
Returns the cosine of `x` in radians.
```zen
double r = cos(0.0)     # 1.0
```

---

##### `tan`
```
tan(x) → double
```
Returns the tangent of `x` in radians.
```zen
double r = tan(PI / 4)  # ~1.0
```

---

##### `log`
```
log(x) → double
```
Returns the natural logarithm of `x`.
```zen
double r = log(E)       # 1.0
```

---

##### `exp`
```
exp(x) → double
```
Returns `e` raised to the power of `x`.
```zen
double r = exp(1.0)     # ~2.718
```

---

#### 11.4.3 Rounding

---

##### `floor`
```
floor(x) → int
```
Rounds `x` down to the nearest integer.
```zen
int r = floor(3.9)      # 3
```

---

##### `ceil`
```
ceil(x) → int
```
Rounds `x` up to the nearest integer.
```zen
int r = ceil(3.1)       # 4
```

---

##### `round`
```
round(x) → int
```
Rounds `x` to the nearest integer.
```zen
int r = round(3.5)      # 4
int r = round(3.4)      # 3
```

---

##### `toFixed`
```
toFixed(x, digits) → double
```
Returns `x` rounded to `digits` decimal places.
```zen
double r = toFixed(3.14159, 2)   # 3.14
```

---

##### `mod`
```
mod(a, b) → int
```
Returns the remainder of `a` divided by `b`.
```zen
int r = mod(10, 3)      # 1
```

---

#### 11.4.4 Number Theory

---

##### `gcd`
```
gcd(a, b) → int
```
Returns the greatest common divisor of `a` and `b`.
```zen
int r = gcd(12, 8)      # 4
```

---

##### `lcm`
```
lcm(a, b) → int
```
Returns the least common multiple of `a` and `b`.
```zen
int r = lcm(4, 6)       # 12
```

---

##### `factorial`
```
factorial(n) → double
```
Returns the factorial of `n`. Returns `double` to accommodate large values.
```zen
double r = factorial(10)   # 3628800.0
```

---

##### `isPrime`
```
isPrime(n) → bool
```
Returns `true` if `n` is a prime number.
```zen
bool r = isPrime(7)     # true
bool r = isPrime(4)     # false
```

---

#### 11.4.5 Interpolation

---

##### `lerp`
```
lerp(a, b, t) → double
```
Linearly interpolates between `a` and `b` by factor `t`. `t` should be in the range `[0.0, 1.0]`.
```zen
double r = lerp(0.0, 10.0, 0.5)   # 5.0
```

---

##### `normalize`
```
normalize(value, min, max) → double
```
Maps `value` from the range `[min, max]` to `[0.0, 1.0]`.
```zen
double r = normalize(5.0, 0.0, 10.0)   # 0.5
```

---

#### 11.4.6 Utility

---

##### `between`
```
between(value, low, high) → bool
```
Returns `true` if `value` is within the range `[low, high]` inclusive.
```zen
bool r = between(5, 1, 10)    # true
bool r = between(11, 1, 10)   # false
```

---

##### `random`
```
random() → double
```
Returns a random `double` in the range `[0.0, 1.0)`. Affected by `SEED`.
```zen
double r = random()
```

---

##### `randomInt`
```
randomInt(min, max) → int
```
Returns a random integer in the range `[min, max]` inclusive. Affected by `SEED`.
```zen
int r = randomInt(1, 100)
```

---

#### 11.4.7 String

##### `reverse`
```
reverse(s) → string
```
Returns the string with characters in reverse order.
```zen
string r = reverse("ZEN")      # "NEZ"
```

---

##### `indexOf`
```
indexOf(s, sub) → int
```
Returns the index of the first occurrence of `sub` in `s`. Returns `-1` if not found.
```zen
int r = indexOf("hello", "ll")  # 2
int r = indexOf("hello", "x")   # -1
```

---

---

##### `lastIndexOf`
```
lastIndexOf(s, sub) → int
```
Returns the index of the last occurrence of `sub` in `s`. Returns `-1` if not found.
```zen
int r = lastIndexOf("hello", "l")   # 3
int r = lastIndexOf("hello", "x")   # -1
```

---

##### `stringToBytes`
```
stringToBytes(s) → List<byte>
```
Returns the bytes of `s`.
```zen
List<byte> b = stringToBytes("hi")
```

---

##### `bytesToString`
```
bytesToString(List<byte>) → string
```
Converts a list of bytes back to a string.
```zen
string s = bytesToString(b)   # "hi"
```

---

##### `slice`
```
slice(s, start, end) → string
```
Returns the substring of `s` from index `start` (inclusive) to `end` (exclusive).
```zen
string r = slice("hello", 1, 3)   # "el"
```

---

##### `charAt`
```
charAt(s, index) → string
```
Returns the character at the given index as a single-character string.
```zen
string r = charAt("hello", 1)     # "e"
```

---

##### `replace`
```
replace(s, target, replacement) → string
```
Replaces the first occurrence of `target` in `s` with `replacement`.
```zen
string r = replace("hello world", "world", "ZEN")   # "hello ZEN"
```

---

##### `contains`
```
contains(s, sub) → bool
```
Returns `true` if `s` contains the substring `sub`.
```zen
bool r = contains("hello", "ell")   # true
```

---

##### `upperCase`
```
upperCase(s) → string
```
Returns `s` converted to uppercase.
```zen
string r = upperCase("zen")   # "ZEN"
```

---

##### `lowerCase`
```
lowerCase(s) → string
```
Returns `s` converted to lowercase.
```zen
string r = lowerCase("ZEN")   # "zen"
```

---

##### `startsWith`
```
startsWith(s, prefix) → bool
```
Returns `true` if `s` begins with `prefix`.
```zen
bool r = startsWith("hello", "he")   # true
```

---

##### `endsWith`
```
endsWith(s, suffix) → bool
```
Returns `true` if `s` ends with `suffix`.
```zen
bool r = endsWith("hello", "lo")   # true
```

---

##### `trim`
```
trim(s) → string
```
Returns `s` with leading and trailing whitespace removed.
```zen
string r = trim("  hello  ")   # "hello"
```

---

##### `splitAt`
```
splitAt(s, delimiter, index) → string
```
Splits `s` by `delimiter` and returns the element at `index`.
```zen
string r = splitAt("a,b,c", ",", 1)   # "b"
string r = splitAt("a,b,c", ",", 0)   # "a"
```

---

##### `repeat`
```
repeat(s, n) → string
```
Returns `s` repeated `n` times.
```zen
string r = repeat("ab", 3)   # "ababab"
```

---

##### `split`
```
split(source, delimiter) → List<string>
```
Splits `source` by `delimiter` and returns all resulting elements as a list.
```zen
List<string> r = split("a,b,c", ",")   # ["a", "b", "c"]
List<string> r = split("hello world", " ")   # ["hello", "world"]
```

---

##### `replaceAll`
```
replaceAll(source, search, replacement) → string
```
Replaces all occurrences of `search` in `source` with `replacement`.
```zen
string r = replaceAll("hello world", "world", "Zen")   # "hello Zen"
string r = replaceAll("a-b-c", "-", "_")   # "a_b_c"
```

---

##### `count`
```
count(s, sub) → int
```
Returns the number of non-overlapping occurrences of `sub` in `s`.
```zen
int r = count("hello world hello", "hello")   # 2
```

---

##### `padStart`
```
padStart(s, length, pad) → string
```
Pads the start of `s` with `pad` until the total length reaches `length`.
```zen
string r = padStart("5", 3, "0")   # "005"
```

---

##### `padEnd`
```
padEnd(s, length, pad) → string
```
Pads the end of `s` with `pad` until the total length reaches `length`.
```zen
string r = padEnd("hi", 5, ".")   # "hi..."
```

---

##### `padCenter`
```
padCenter(s, length, pad) → string
```
Pads both sides of `s` with `pad` to center it within `length`.
```zen
string r = padCenter("hi", 6, "-")   # "--hi--"
```

---

##### `capitalize`
```
capitalize(s) → string
```
Returns `s` with the first character converted to uppercase.
```zen
string r = capitalize("zen")   # "Zen"
```

---

##### `extName`
```
extName(path) → string
```
Returns the file extension from a path string, not including the leading dot.
```zen
string r = extName("main.zen")   # "zen"
string r = extName("data.txt")   # "txt"
```

---

#### `matchRegex`

Matches a string against a POSIX Extended Regular Expression (ERE).

```
matchRegex(text, pattern)
```

| Parameter | Type | Required | Description |
|---|---|---|---|
| `text` | `string` | Yes | Input string to test |
| `pattern` | `string` | Yes | POSIX ERE pattern |

Returns `bool`.

```zen
matchRegex("hello123", "^[a-z]+[0-9]+$")
matchRegex("test@example.com", "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
matchRegex("12345", "^[0-9]+$")
matchRegex("abc", "^[0-9]+$")
```

```zen
bool ok = matchRegex(
  "user@example.com",
  "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
)

screen(ok)   # true
```

---

##### `match`

```
match(s, pattern) → bool
```
Returns `true` if `s` fully matches the given pattern string. The **entire string must match** — partial matches return `false`.

```zen
bool r = match("hello@zen.dev", "@")   # false — partial match
bool r = match("hello@zen.dev", "*@*") # true  — wildcard full match
```

---

**Pattern Reference**

Zen's `match()` uses its own lightweight pattern syntax — not traditional regex. Below is the complete reference.

| Pattern | Name | Description |
|---|---|---|
| `"text"` | Literal | Matches exact string content character by character |
| `?` | Any Char | Matches exactly one character of any kind |
| `*` | Wildcard | Matches zero or more characters of any kind |
| `#d` | Digit | Matches a single numeric character `0–9` |
| `#a` | Letter | Matches a single alphabet character `a–z`, `A–Z` |
| `#x` | Alphanumeric | Matches one letter or digit |
| `#s` | Space | Matches one whitespace character (space or tab) |
| `(pattern?)` | Optional Group | Makes the inner pattern match 0 or 1 time |
| `a(+)` | One or More | Repeats the previous token at least once |
| `a(*)` | Zero or More | Repeats the previous token zero or more times |
| `a\|b\|c` | OR | Matches any one of the pipe-separated alternatives |
| `[a,b,c]` | Character Set | Matches one character from the comma-separated list |
| `[a-z]` | Character Range | Matches one character within the defined range |
| `:int` | Integer Token | Matches a full signed or unsigned integer |
| `:id` | Identifier Token | Matches a valid variable/function name (letter or `_` start) |
| `:string` | String Token | Matches any non-empty sequence of characters |

---

**Examples**

```zen
# Literals and wildcards
bool a = match("hello", "hello")       # true
bool b = match("hello123", "h*3")      # true

# Special tokens
bool c = match("5", "#d")             # true  — digit
bool d = match("Z", "#a")             # true  — letter
bool e = match("A", "#x")             # true  — alphanumeric
bool f = match(" ", "#s")             # true  — space

# Optional group
bool g = match("color",  "colou?r")   # true
bool h = match("colour", "colou?r")   # true

# Repetition
bool i = match("aaa", "a(+)")         # true  — one or more
bool j = match("",    "a(*)")         # true  — zero or more

# OR
bool k = match("maybe", "yes|no|maybe")  # true
bool l = match("nope",  "yes|no|maybe")  # false

# Character set and range
bool m = match("c", "[a,b,c]")        # true
bool n = match("7", "[0-9]")          # true
bool o = match("M", "[a-z]")          # false

# Typed tokens
bool p = match("12345",   ":int")     # true
bool q = match("-99",     ":int")     # true
bool r = match("12345a",  ":int")     # false — trailing char
bool s = match("zen_var1", ":id")     # true
bool t = match("1abc",     ":id")     # false — starts with digit
bool u = match("hello world", ":string") # true
```

---

**Notes**

- `match()` always checks the **full string**. Partial matches return `false` — `"12345a"` does not match `":int"`.
- OR (`|`) is evaluated **left to right**. First match wins.
- Character range `[lo-hi]` requires exactly 3 characters inside brackets with a dash in the middle — e.g. `[a-z]`, `[0-9]`.
- `:id` must start with a **letter or underscore**. A leading digit or symbol returns `false`.
- `:int` allows a **leading minus sign**. The remainder must be digits only with no trailing characters.

---

##### `json`

```
json(jsonString, accessor) → string
```
Extracts a value from a JSON string using a dot-notation or bracket-notation accessor. Always returns the extracted value as a `string`.

| Parameter | Type | Description |
|---|---|---|
| `jsonString` | `string` | A valid JSON string |
| `accessor` | `string` | Access path e.g. `"name"`, `"a.b"`, `"items[0]"`, `"a.b[1].c"` |

Returns `string`.

```zen
string data = '{"name":"jishith","age":21}'
string name = json(data, "name")          # "jishith"
string age  = json(data, "age")           # "21"

string nested = '{"user":{"city":"Bangalore"}}'
string city = json(nested, "user.city")   # "Bangalore"

string arr = '{"scores":[10,20,30]}'
string s = json(arr, "scores[1]")         # "20"

string deep = '{"a":{"b":[{"c":"found"}]}}'
string val = json(deep, "a.b[0].c")       # "found"
```

## 12. Compilation Model

ZEN is compiled through a multi-stage pipeline implemented in JavaScript and driven by Node.js. The compiler emits LLVM IR, which is then passed through the Clang toolchain to produce a native binary.

---

### 12.1 Pipeline Overview

```
Source (.zen)
     │
     ▼
 Lexer
 Tokenizes source into TYPE:VALUE token stream
     │
     ▼
 Parser
 Builds an Abstract Syntax Tree (AST)
     │
     ▼
 Code Generator
 Walks the AST and emits LLVM IR
     │
     ▼
 LLVM IR (.ll file)
     │
     ▼
 Clang Pipeline (-O2)
     │
     ├── (.o file)
```

---

### 12.2 Stages

#### Stage 1 — Lexer

The lexer reads raw source text and produces a flat sequence of tokens. Each token carries a type and a value. Whitespace and comments are discarded at this stage.

Input: `.zen` source file
Output: Token stream (`TYPE:VALUE` pairs)

#### Stage 2 — Parser

The parser consumes the token stream and constructs an Abstract Syntax Tree (AST). The AST represents the full syntactic structure of the program — declarations, expressions, statements, and control flow — as a tree of nodes.

Input: Token stream
Output: AST

#### Stage 3 — Code Generation

The code generator walks the AST and emits LLVM IR. Each AST node maps to a defined IR construct. This stage also performs semantic checks — type validation, scope resolution, and constraint enforcement.

Input: AST
Output: `.ll` LLVM IR file

#### Stage 4 — Clang Pipeline

The emitted IR is passed to Clang with `-O2` aggressive optimization. Clang compiles and links the IR into a native binary.

Input: `.ll` file
Output: Native binary

---

### 12.3 Host Language

The ZEN compiler is implemented in **JavaScript** and runs on **Node.js**. This is the v2 host. Self-hosting — rewriting the compiler in ZEN itself — is a future goal and not part of the current specification.

---

### 12.4 Optimization

ZEN compiles with Clang's `-O2` optimization level by default, which enables standard optimizations including:

- Inlining of small functions
- Dead code elimination
- Constant folding and propagation
- Loop optimizations

The level can be changed per command with `-O0` (none), `-O1` (basic), `-O2` (standard, default) and `-O3` (aggressive):

```bash
zen build main.zen -O3
```

---

### 12.5 CLI

ZEN is invoked from the command line using the `zen` command.

```
zen run <filename>
```

`filename` must be a `.zen` source file or package name

```bash
zen run main.zen
```

This command runs the full pipeline — lexing, parsing, IR emission, Clang compilation — and executes the resulting binary. Both the `.ll` IR file and the final binary are produced as output.

---

### 12.6 Output Files

| File | Description |
|---|---|
| `.ll` | LLVM IR intermediate representation |
| Binary | `.o` object file|

---

## 13. Error Model

ZEN errors are either **compile-time errors**, caught before any code runs, or **runtime errors**, raised during execution. See [errors.md](errors.md) for all error types.

---

## 14. Built-in Structs

Built-in structs are provided by the runtime and are available without any import. They use reference semantics, and the ones with `free()` follow the ownership rules in Semantics: free only the object you own, never a child you got from it.

---

### 14.1 Tcp

A TCP connection, created by `net.connect()` or `TcpServer.accept()`.

| Method | Returns | Description |
|---|---|---|
| `send(List<byte> data)` | `long` | Sends bytes and returns the number of bytes sent |
| `receive(int size)` | `List<byte>` | Receives up to `size` bytes |
| `close()` | `void` | Closes the connection |
| `isOpen()` | `bool` | Returns `true` while the connection is open |

---

### 14.2 TcpServer

A TCP server, created by `net.listen()`.

| Method | Returns | Description |
|---|---|---|
| `accept()` | `Tcp` | Waits for the next client and returns its connection |
| `close()` | `void` | Stops the server |
| `isOpen()` | `bool` | Returns `true` while the server is listening |

---

### 14.3 Json

A parsed JSON document. Free it with `free()` when done.

| Method | Returns | Description |
|---|---|---|
| `parse(string text)` | `void` | Parses a JSON string into this value |
| `getRootObject()` | `JsonObject` | Returns the root as an object |
| `getRootArray()` | `JsonArray` | Returns the root as an array |
| `getInt(string key)` | `int` | Reads a number as `int` |
| `getLong(string key)` | `long` | Reads a number as `long` |
| `getByte(string key)` | `byte` | Reads a number as `byte` |
| `getDouble(string key)` | `double` | Reads a number as `double` |
| `getString(string key)` | `string` | Reads a string |
| `getBool(string key)` | `bool` | Reads a boolean |
| `getObject(string key)` | `JsonObject` | Reads a nested object |
| `getArray(string key)` | `JsonArray` | Reads a nested array |
| `has(string key)` | `bool` | Returns `true` if the key exists |
| `isNull()` | `bool` | Returns `true` if the value is JSON null |
| `arrayLength()` | `int` | Returns the length when the value is an array |
| `arrayGetInt(int i)` | `int` | Reads array element `i` as `int` |
| `arrayGetDouble(int i)` | `double` | Reads array element `i` as `double` |
| `arrayGetString(int i)` | `string` | Reads array element `i` as `string` |
| `arrayGetBool(int i)` | `bool` | Reads array element `i` as `bool` |
| `arrayGetObject(int i)` | `JsonObject` | Reads array element `i` as an object |
| `arrayGetArray(int i)` | `JsonArray` | Reads array element `i` as an array |
| `map()` | `Map` | Converts the JSON into a `Map` (the caller owns the new Map) |
| `free()` | `void` | Releases the document |

A missing key, a wrong type, or a number that does not fit the getter used (for example `getByte` on 300) raises a `JsonError`.

---

### 14.4 JsonObject

A JSON object obtained from a `Json` value. Do not free it; free the parent `Json`.

| Method | Returns | Description |
|---|---|---|
| `getInt(string key)` | `int` | Reads a number as `int` |
| `getLong(string key)` | `long` | Reads a number as `long` |
| `getByte(string key)` | `byte` | Reads a number as `byte` |
| `getDouble(string key)` | `double` | Reads a number as `double` |
| `getString(string key)` | `string` | Reads a string |
| `getBool(string key)` | `bool` | Reads a boolean |
| `getObject(string key)` | `JsonObject` | Reads a nested object |
| `getArray(string key)` | `JsonArray` | Reads a nested array |
| `has(string key)` | `bool` | Returns `true` if the key exists |
| `isNull()` | `bool` | Returns `true` if the value is JSON null |

---

### 14.5 JsonArray

A JSON array obtained from a `Json` value. Do not free it; free the parent `Json`.

| Method | Returns | Description |
|---|---|---|
| `arrayLength()` | `int` | Returns the number of elements |
| `arrayGetInt(int i)` | `int` | Reads element `i` as `int` |
| `arrayGetLong(int i)` | `long` | Reads element `i` as `long` |
| `arrayGetByte(int i)` | `byte` | Reads element `i` as `byte` |
| `arrayGetDouble(int i)` | `double` | Reads element `i` as `double` |
| `arrayGetString(int i)` | `string` | Reads element `i` as `string` |
| `arrayGetBool(int i)` | `bool` | Reads element `i` as `bool` |
| `arrayGetObject(int i)` | `JsonObject` | Reads element `i` as an object |
| `arrayGetArray(int i)` | `JsonArray` | Reads element `i` as an array |

---

### 14.6 HttpServer

An HTTP server, created by `httpServer.create(port)`.

| Method | Returns | Description |
|---|---|---|
| `listen()` | `int` | Starts listening for connections |
| `next()` | `HttpRequest` | Waits for and returns the next request |
| `close()` | `void` | Stops the server |

---

### 14.7 HttpRequest

An incoming request, which is also used to send the response.

**Properties**

| Property | Type | Description |
|---|---|---|
| `method` | `string` | HTTP method (`GET`, `POST`, ...) |
| `path` | `string` | Request path |
| `body` | `string` | Request body |

**Methods**

| Method | Returns | Description |
|---|---|---|
| `getHeader(string name)` | `string` | Reads a request header |
| `setHeader(string name, string value)` | `void` | Sets a response header |
| `status(int code)` | `void` | Sets the response status code |
| `send(string body)` | `void` | Sends a plain text response |
| `json(string body)` | `void` | Sends a JSON response |
| `html(string body)` | `void` | Sends an HTML response |
| `css(string body)` | `void` | Sends a CSS response |
| `sendFile(string path, string contentType)` | `void` | Sends a file with the given content type |
| `redirect(string url)` | `void` | Redirects the client to another URL |

---

### 14.8 Map

A string-keyed map. Free it with `free()` when done. Maps returned by `getMap()` belong to the parent; do not free them.

| Method | Returns | Description |
|---|---|---|
| `keys()` | `List<string>` | Returns all keys |
| `entries()` | `List<List<string>>` | Returns all key/value pairs |
| `has(string key)` | `bool` | Returns `true` if the key exists |
| `remove(string key)` | `void` | Removes a key |
| `json()` | `string` | Returns the map as a JSON string |
| `getInt(string key)` | `int` | Reads an `int` |
| `getLong(string key)` | `long` | Reads a `long` |
| `getByte(string key)` | `byte` | Reads a `byte` |
| `getDouble(string key)` | `double` | Reads a `double` |
| `getBool(string key)` | `bool` | Reads a `bool` |
| `getString(string key)` | `string` | Reads a `string` |
| `getMap(string key)` | `Map` | Reads a nested Map |
| `getList(string key)` | `List` | Reads a List (generic) |
| `setInt(string key, int v)` | `void` | Stores an `int` |
| `setLong(string key, long v)` | `void` | Stores a `long` |
| `setByte(string key, byte v)` | `void` | Stores a `byte` |
| `setDouble(string key, double v)` | `void` | Stores a `double` |
| `setBool(string key, bool v)` | `void` | Stores a `bool` |
| `setString(string key, string v)` | `void` | Stores a `string` |
| `setMap(string key, Map v)` | `void` | Stores a nested Map |
| `setList(string key, List v)` | `void` | Stores a List |
| `free()` | `void` | Releases the Map |

---

### 14.9 Ptr

A native pointer, mainly used with `extern fn` for C interop. Free it with `free()` when you own it.

| Method | Returns | Description |
|---|---|---|
| `isNull()` | `bool` | Returns `true` if the pointer is null |
| `offset(int n)` | `Ptr` | Returns a pointer advanced by `n` bytes |
| `storeInt(int v)` / `loadInt()` | `void` / `int` | Writes / reads an `int` |
| `storeLong(long v)` / `loadLong()` | `void` / `long` | Writes / reads a `long` |
| `storeByte(byte v)` / `loadByte()` | `void` / `byte` | Writes / reads a `byte` |
| `storeDouble(double v)` / `loadDouble()` | `void` / `double` | Writes / reads a `double` |
| `storeBool(bool v)` / `loadBool()` | `void` / `bool` | Writes / reads a `bool` |
| `storeString(string v)` / `loadString()` | `void` / `string` | Writes / reads a string |
| `storePtr(Ptr v)` / `loadPtr()` | `void` / `Ptr` | Writes / reads another pointer |
| `copyFrom(Ptr src, int n)` | `void` | Copies `n` bytes from `src` into this pointer |
| `copyTo(Ptr dst, int n)` | `void` | Copies `n` bytes from this pointer into `dst` |
| `fill(int value, int n)` | `void` | Sets `n` bytes to `value` |
| `free()` | `void` | Releases the memory |

---

## 15. Future Planned Features

The following features and improvements are planned or being considered for future versions of Zen. These are **not part of Zen v3**, and their final syntax, behavior, implementation, or priority may change.

### 15.1 Type System Improvements

- Add `uint` for unsigned integers.
- Add `ulong` for unsigned long integers.
- Add `ubyte` as an unsigned byte type, while the current `byte` type remains signed.

### 15.2 Current Limitations

Future versions are planned to address the following current limitations:

- Support importing structs with aliases.
- Extend `debug.pretty()` to support struct fields containing `List<Map>`.
- Make HTTP timeouts configurable.
- Add HTTP retry support.
- Add HTTP resume support where applicable.
- Improve or restore Windows support.

### 15.3 Built-in APIs and Namespaces

- Add more priority namespaces and built-in methods.
- Expand the standard library with additional useful built-in functions.
- Add more built-in structs and methods.
- Continue improving existing built-in APIs based on practical usage.

### 15.4 Function Parameter Improvements

- Reconsider `screen()` parameter handling.
- Potentially make `screen()` support variadic parameters.
- Alternatively, introduce a separate function specifically for accepting variadic parameters.

### 15.5 Syntax Improvements

- Improve parser-supported syntax while keeping Zen simple and predictable.
- Add useful syntax sugar where it does not introduce ambiguity or unnecessary complexity.
- Consider concise one-line conditional syntax, including forms such as:
  - `if (...) ...`
  - `if (...) ... else ...`
  - `if (...) ... else if (...) ... else ...`
- Continue identifying opportunities for cleaner syntax without compromising readability.

### 15.6 Runtime Error Handling

- Improve runtime error reporting.
- Propagate source-location information through runtime errors where practical.
- Include accurate line and column numbers in runtime errors where possible.
- Improve the clarity and usefulness of runtime diagnostics.

### 15.7 Parser and Lexer

- Improve parser performance and internal architecture.
- Optimize parser and lexer node structures.
- Reduce unnecessary parser and lexer overhead.
- Improve internal AST representation and processing efficiency.
- Continue optimizing parsing without making the language syntax unnecessarily complex.

### 15.8 Compiler Internals

- Improve the underlying Clang compilation pipeline.
- Improve code generation.
- Optimize compiler internal data flow.
- Reduce unnecessary compilation work.
- Improve generated LLVM IR efficiency.
- Investigate further opportunities for producing smaller and more efficient IR.
- Continue compiler optimizations while preserving correctness and debuggability.

### 15.9 Configuration System

- Improve the compiler configuration-file data structure.
- Make configuration data easier to maintain and extend.
- Improve configuration validation and accuracy.
- Reduce inconsistencies caused by configuration structure or data handling.

### 15.10 Platform Support

- Continue improving cross-platform support.
- Investigate and potentially restore full Windows support.
- Improve consistency between supported platforms.
- provide easy installation with zero dependencies

### 15.11 Experimental Compiler Features

- Explore a secure internal system for registering or adding built-in functionality through the terminal.
- This feature is currently only a prototype/experimental idea and is **not planned as a public Zen feature unless its security and design are proven suitable**.

---

## Appendix

### A. Reserved Keywords

See [2.4 Keywords](#24-keywords) for the full list.

---

### B. Reserved Identifiers

The following names are reserved as built-in functions, standard library functions, or global constants. They cannot be redeclared by user code.

#### Global Constants

`PI` `TAU` `E` `PHI` `SQRT2` `SQRT1_2` `SQRT3` `LN2` `LN10` `LOG2E` `LOG10E` `SEED` `I32_MAX` `I32_MIN` `I64_MAX` `I64_MIN` `BYTE_MAX` `BYTE_MIN` `F64_MAX` `F64_MIN` `F64_EPS` `INF` `NEG_INF` `NAN`

#### Core Functions

`screen` `input` `type` `Int` `Double` `Long` `Byte` `Bool` `String` `intToAscii` `asciiToInt` `length` `sizeOf` `stringToBytes` `bytesToString`

#### Standard Functions

`isEven` `isOdd` `isPositive` `isNegative` `abs` `max` `min` `clamp` `sign` `pow` `sqrt` `square` `cube` `floor` `ceil` `round` `toFixed` `mod` `gcd` `lcm` `factorial` `isPrime` `lerp` `normalize` `between` `sin` `cos` `tan` `log` `exp` `random` `randomInt` `reverse` `indexOf` `lastIndexOf` `slice` `charAt` `replace` `contains` `upperCase` `lowerCase` `startsWith` `endsWith` `trim` `splitAt` `repeat` `count` `padStart` `padEnd` `padCenter` `capitalize` `extName` `match` `matchRegex` `json`

#### Namespace Identifiers

`os` `fs` `sys` `time` `http` `net` `httpServer` `ffi` `path` `threads` `debug` `crypto`

---

### C. Operator Precedence

Operators are listed from highest to lowest precedence. Operators on the same row have equal precedence and are evaluated left to right.

| Level | Operators | Description |
|---|---|---|
| 1 (highest) | `()` | Parenthesised grouping |
| 2 | `++` `--` `!` `~` `+` `-` | Unary operators |
| 3 | `*` `/` `%` | Multiplicative |
| 4 | `+` `-` | Additive |
| 5 | `<<` `>>` | Bitwise shift |
| 6 | `&` | Bitwise AND |
| 7 | `^` | Bitwise XOR |
| 8 | `\|` | Bitwise OR |
| 9 | `<` `>` `<=` `>=` | Relational comparison |
| 10 | `==` `!=` | Equality |
| 11 | `&&` | Logical AND |
| 12 | `\|\|` | Logical OR |
| 13 | `? :` | Ternary |
| 14 (lowest) | `=` `+=` `-=` `*=` `/=` `%=` | Assignment |

---

### D. Type Default Values

When a variable is declared without an initializer, it is lowered to its type's default value.

| Type | Default |
|---|---|
| `int` | `0` |
| `double` | `0.0` |
| `string` | `""` |
| `bool` | `false` |
| `long` | `0L` |
| `byte` | `0B` |
| `List<T>` | `[]` |
| `struct` | Each field gets its default (`0`, `""`, `false`, empty list) or its declared initializer |

---

### E. Type Conversion Reference

| From | To | Function |
|---|---|---|
| `double` | `int` | `Int(x)` — truncates |
| `string` | `int` | `Int(x)` |
| `bool` | `int` | `Int(x)` — `true` → `1`, `false` → `0` |
| `long` | `int` | `Int(x)` |
| `byte` | `int` | `Int(x)` |
| `int` | `double` | `Double(x)` |
| `string` | `double` | `Double(x)` |
| `bool` | `double` | `Double(x)` — `true` → `1.0` |
| `long` | `double` | `Double(x)` |
| `byte` | `double` | `Double(x)` |
| `int` | `long` | `Long(x)` |
| `double` | `long` | `Long(x)` — truncates |
| `string` | `long` | `Long(x)` |
| `bool` | `long` | `Long(x)` — `true` → `1`, `false` → `0` |
| `byte` | `long` | `Long(x)` |
| `int` | `byte` | `Byte(x)` |
| `long` | `byte` | `Byte(x)` |
| `double` | `byte` | `Byte(x)` — truncates |
| `string` | `byte` | `Byte(x)` |
| `bool` | `byte` | `Byte(x)` — `true` → `1`, `false` → `0` |
| `int` | `string` | `String(x)` |
| `double` | `string` | `String(x)` |
| `long` | `string` | `String(x)` |
| `byte` | `string` | `String(x)` |
| `bool` | `string` | `String(x)` |
| `int` | `bool` | `Bool(x)` — `0` → `false`, non-zero → `true` |
| `long` | `bool` | `Bool(x)` — `0` → `false`, non-zero → `true` |
| `byte` | `bool` | `Bool(x)` — `0` → `false`, non-zero → `true` |
| `string` | `bool` | `Bool(x)` — `"true"` → `true`, `"false"` → `false` |

---

### F. Implicit Type Behavior

| Context | Behavior |
|---|---|
| `int` operand with `double` in expression | `int` promoted to `double`; result is `double` |
| `long` operand with `double` in expression | `long` promoted to `double`; result is `double` |
| `byte` operand with `int` in expression | `byte` promoted to `int`; result is `int` |
| `byte` operand with `long` in expression | `byte` promoted to `long`; result is `long` |
| `int` operand with `long` in expression | `int` promoted to `long`; result is `long` |
| `bool` in arithmetic or bitwise expression | `true` is `1`, `false` is `0` |
| `string` + any type via `+` | Other operand coerced to `string`; result is `string` |
| Any other cross-type expression | Compile-time `TypeError` |

---

### G. Data Structure Constraints Summary

| Type | Heap | Resizable | Typed | Nestable | Pass as Param |
|---|---|---|---|---|---|
| `List<T>` | Yes | Yes | Yes | Yes | Yes |
| Fixed Array | No | No | Yes | Yes | No |
| `struct` | No | No | Yes | Yes | No |

---

### H. Module Rules Summary

| Rule | Detail |
|---|---|
| Multiple exports per file | A file can have several `export` statements |
| Multiple imports per file | A file can have several `import` statements |
| Export at bottom | Required for variables; recommended for functions |
| Static values only | Expressions and runtime values cannot be exported |
| Import at top | All imports must precede any other statements |
| Direct name access | No namespace prefix on imported identifiers |
| Exact name match | Imported names must match the export list |
| Import aliasing | Functions and variables can be aliased on import; structs cannot |
| Struct dependencies | Importing a struct also brings its dependent structs as hidden structs (usable, not nameable) |
| `.zen` extension | Import paths must reference `.zen` files |

---

### I. Compilation Pipeline Summary

| Stage | Input | Output |
|---|---|---|
| Lexer | `.zen` source | Token stream |
| Parser | Token stream | AST |
| Code Generator | AST | `.ll` LLVM IR |
| Clang (`-O2` by default) | `.ll` LLVM IR + runtime + native objects | Native binary |

---

### J. Error Type Reference

See [errors.md](errors.md) for all error types.

---

### K. Installation

#### Linux, macOS, and Android (Termux)

```bash
curl -fsSL https://raw.githubusercontent.com/Jishith-dev/Zen/main/install.sh | bash -s -- --branch dev -y
```

#### Windows

Native Windows is not supported yet. Use WSL and run the command above.

---

### L. Links

- **GitHub**: https://github.com/Jishith-dev/Zen
- Documentation: https://jishith-dev.github.io/zen-doc/
- Issue Tracker: https://github.com/Jishith-dev/Zen/issues

---

### M. Open Source

Zen is an open-source project.

You are free to:
- Use Zen in personal or commercial projects
- Modify the compiler
- Contribute improvements and fixes

License: MIT

---

### N. Contact

For bugs, contributions, or discussions:

- Email: jishithmp534@gmail.com
- GitHub: https://github.com/Jishith-dev/Zen
- GitHub registry: https://github.com/Jishith-dev/zen-registry

---

### O. File Extensions

| Extension | Description |
|---|---|
| `.zen` | ZEN source file |
| `.ll` | Generated LLVM IR |
| `.c` / `.o` | Native dependency (detected by `zen deps`, linked automatically) |
| Native binary | Platform-specific executable generated by Clang |

---

### P. Naming Conventions

The ZEN style guide recommends:

| Item | Convention | Example |
|---|---|---|
| Variables | camelCase | `userName` |
| Functions | camelCase | `readFile()` |
| Structs | PascalCase | `HttpRequest` |
| Constants | UPPER_SNAKE_CASE | `I32_MAX` |
| Namespaces | lowerCamelCase | `httpServer` |

---

### Q. Version Information

| Item | Value |
|---|---|
| Documentation Version | 3.0.0 |
| Language Version | 3.0.0 |
| Released | October 2026 |
| Backend | LLVM |
| License | MIT |

---

## Disclaimer

This documentation targets **ZEN v3.0.0**.

v3.0.0 included several breaking changes from v2 (see [changelog.md](changelog.md)). Starting with **v3**, the language syntax is considered **frozen** for backward compatibility. Future releases will focus on adding new features and APIs while preserving existing syntax whenever possible.

As the documentation continues to evolve alongside the language, you may occasionally encounter:

- Outdated syntax examples
- References to removed or renamed features
- Missing documentation for newer features
- Documentation inaccuracies or omissions

If you notice anything that does not match the current behavior of ZEN, please report it by [opening an issue](https://github.com/Jishith-dev/Zen/issues). Community feedback helps improve the language, compiler, standard library, tooling, and documentation.