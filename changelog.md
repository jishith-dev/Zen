# Changelog

## v1.0.0 — Initial Release

First stable release of Zen.

- Compiler core stabilized (LLVM backend)
- Language design finalized
- Standard library introduced
- Basic tooling and documentation added

---

### Notes
This marks the first public version of Zen. Future updates will be incremental improvements and new features.

## v1.0.1

- Disabled map dynamic key access (compile-time safety)
- Disabled `loop in` mutation during iteration (undefined behavior prevention)
- Added `sys.performance()` to stdlib
- Added `sys.argv` to stdlib
- Various bug fixes


## v1.1.1

### Language

- Added support for `List<Struct>`
- Added limited struct literal support
- Struct variables can now be initialized using literals:
  ```zen
  Person p = { name: "Jishith", age: 21 }
  ```
- Functions can now return structs
- Structs can now be exported and imported across modules
- Empty initialized global struct instances can be exported and imported
- Added `byte` generic support through `List<byte>`
- Added limited empty List type inference when type context is available
- Disabled automatic function type inference for structs
- Disabled dynamic map access and dynamic map assignment
- Disabled maps as function parameters

### Standard Library

- Added `matchRegex()` with POSIX ERE regex support
- Added `ffi.fn`
- Added `List.join()`
- Added `List.indexOf()`
- Added `Map.keys()` returning `List<string>`
- Added `fs.readFileBytes()`
- Added `fs.writeFileBytes()`
- Added binary file support through `List<byte>`

### Compiler & Runtime

- Added function name mangling
- Migrated compiler and runtime to LLVM opaque pointers (`ptr`)
- Added 32-bit and 64-bit aware size and alignment calculations
- Standardized internal LLVM helper functions with `_`-prefixed names
- Improved global string handling after opaque pointer migration
- Improved struct passing and struct return behavior

### Tooling

- Added `zen init <project-name>` for project scaffolding

Creates a new project directory containing:

```text
<project-name>/
├── main.zen
└── zen.json
```

Generated `zen.json`:

```json
{
  "name": "<project-name>",
  "version": "1.0.0",
  "main": "main.zen"
}
```

- Added official **Zen Package Registry** for package management
- Added `zen signup` and `zen login` for authentication
- Added `zen logout` and `zen whoami` for account management
- Added `zen install <package>` to install packages from registry
- Added `zen publish` to publish packages to registry
- Added `zen unpublish` to remove packages from registry
- Added `zen list` with pagination to browse all packages (50 per page)
- Registry supports both runnable applications (`main`) and library packages (`bin`)
- Library packages install to `~/.zen/packages/`
- Runnable applications install to current directory
- Secure JWT-based authentication
- GitHub-hosted package source code

### Fixes

- `contains()` no longer performs struct literal comparisons
- Various compiler, runtime, and standard library bug fixes


## v1.2.1

### Language

- Introduced `enum` with constant integer values
- Added support for importing and exporting within the same module
- Added circular import detection and resolution
- Added installed package imports (`import(...) from "package"`)
- Exported modules can now import other modules and packages
- Added built-in `HttpServer`, `HttpRequest`, and `HttpResponse` structs

### Standard Library

- Added `httpServer` namespace
- Added `httpServer.create(port)`
- Added `HttpServer.listen()`
- Added `HttpServer.next()`
- Added `HttpServer.close()`
- Added `HttpRequest.method`
- Added `HttpRequest.path`
- Added `HttpRequest.json()`
- Added `HttpRequest.html()`
- Added `HttpRequest.css()`
- Added `HttpRequest.send()`
- Added `HttpRequest.setHeader()`
- Added `HttpRequest.redirect()`
- Added `HttpRequest.status()`
- Added `sys.setEnv()`
- Added `sys.hasEnv()`
- Added `sys.timestamp()`
- Added `sys.execOutput()`
- Added `os.exit()`
- Added `os.pid()`
- Added `os.parentPid()`
- Added `os.platform()`
- Added `os.isWindows()`
- Added `os.isLinux()`
- Added `os.isMac()`
- Added `os.isAndroid()`
- Added `os.homeDir()`

### Tooling

- Added `zen recovery` for account recovery
- Added `zen uninstall <package>`
- Added `zen search <package>`
- Added `zen kind <package>`
- Added `zen mine`
- `zen install` now automatically detects the repository's default Git branch
- Increased package description limit from 50 to 400 characters
- Migrated the package registry backend from JSON storage to PostgreSQL

### Compiler & Runtime

- Improved module dependency resolution
- Improved import/export compilation
- Improved HTTP runtime support

### Fixes

- Various compiler, runtime, CLI, package registry, and standard library bug fixes

---

## v1.3.0

### Language

- Added built-in `Json`, `JsonObject`, and `JsonArray` structs
- Added JSON parsing and traversal API
- Added `HttpRequest.body`
- Added bitwise XOR (`^`) operator for integer operands
- Added `time.now()`
- Added `time.format()`
- Added `sys.clipboard.get()`
- Added `sys.clipboard.set()`
- Added `sys.clipboard.clear()`
- Added `sys.clipboard.hasText()`

### Standard Library

- Added `Json.parse()`
- Added `Json.free()`
- Added `Json.getRootObject()`
- Added `Json.getRootArray()`
- Added `JsonObject.getString()`
- Added `JsonObject.getInt()`
- Added `JsonObject.getDouble()`
- Added `JsonObject.getBool()`
- Added `JsonObject.getObject()`
- Added `JsonObject.getArray()`
- Added `JsonArray.getString()`
- Added `JsonArray.getInt()`
- Added `JsonArray.getDouble()`
- Added `JsonArray.getBool()`
- Added `JsonArray.getObject()`
- Added `JsonArray.getArray()`
- Added `HttpRequest.sendFile(path, contentType)`

### Compiler & Runtime

- Added compile-time distinction between built-in struct properties and methods
- Added compile-time validation for built-in struct property access
- Added runtime `JsonError`
- Added use-after-free detection for JSON objects
- Improved HTTP server runtime
- Improved JSON runtime
- Improved bitwise operator validation

### Documentation

- Expanded language specification
- Added JSON API documentation
- Added HTTP server documentation
- Added semantics documentation
- Added runtime error reference

### Removed

> **`sys.timestamp()` has been removed.**  
> Use `time.now()` instead.

### Fixes

- Various compiler, runtime, CLI, package registry, and standard library bug fixes

---

# v2.0.0 — Major Release

> ⚠️ **Breaking Release**
>
> **ZEN v2** introduces the largest language update since the initial release. Several language constructs have been refined for improved consistency, readability, and long-term stability.
>
> From **v2 onwards, the language syntax is considered frozen for backward compatibility.** Future releases will focus on new features and APIs while preserving existing syntax whenever possible.

---

## Language

### Syntax Changes

> ⚠️ **Breaking Change**
>
> Struct field declarations now use **`type name`** order.
>
> **Old**
> ```zen
> name string
> age int
> ```
>
> **New**
> ```zen
> string name
> int age
> ```

> ⚠️ **Breaking Change**
>
> `const` now appears **before** the type.
>
> **Old**
> ```zen
> int const age = 10
> ```
>
> **New**
> ```zen
> const int age = 10
> ```

> ⚠️ **Breaking Change**
>
> `byte` has been replaced by the built-in `Byte` struct.
>
> Binary APIs now use `List<Byte>`, and byte values are created using `toByte()`.

- Added callback function parameters (`fn cb(...)`)
- Added `thread fn` for lightweight concurrent execution
- Added `extern fn` for foreign function declarations without name mangling
- Added generic function call syntax (`function<Type>()`) for type-safe generic returns
- Added built-in `Ptr` struct for native pointer manipulation
- Added built-in `Byte` struct for binary data
- Added global `toByte()` conversion function
- `Map` is now implemented as a built-in struct instead of a language data type
- Added struct-style `Map` literals
- Introduced ownership semantics for runtime-managed objects
- Improved compile-time type safety for generic APIs

---

## Standard Library

### HTTP

- Added `http.urlEncode()`
- Added `http.urlDecode()`
- Added `http.setHeader()`
- Added `http.clearHeaders()`
- Added `http.lastStatus()`
- Added configurable request timeout support

### Threads

- Added `threads` namespace
- Added `threads.waitAll()`

### Debug

- Added `debug` namespace
- Added `debug.pretty()` for formatted printing of Lists, Maps, and structs

---

## Compiler & Runtime

- Added runtime support for thread execution
- Added callback code generation support
- Added external function declarations
- Added native pointer runtime (`Ptr`)
- Migrated `Map` to an opaque built-in runtime struct
- Migrated binary APIs to `List<Byte>`
- Added compile-time ownership validation where possible
- Added runtime detection for invalid ownership operations
- Added runtime detection for use-after-free errors
- Improved generic type resolution for nested `List` types
- Improved built-in struct handling
- Improved `Byte` runtime integration
- Improved HTTP runtime
- Improved parser consistency
- Improved formatter support

---

## Tooling

- Added official source formatter (`zen fmt`)
- Added built-in linter (`zen lint`)
- Added Language Server Protocol (LSP) implementation
- Added editor auto-completion support
- Added hover information support
- Added signature help support
- Improved diagnostics
- Improved code formatting workflow
- Improved developer tooling integration

---

## Documentation

- Completely rewritten language specification
- Updated all syntax examples to v2
- Added thread documentation
- Added callback documentation
- Added `extern` documentation
- Added `Ptr` documentation
- Added `Byte` documentation
- Added `toByte()` documentation
- Added ownership semantics documentation
- Added `Map` runtime documentation
- Expanded built-in struct documentation
- Updated binary API documentation to `List<Byte>`
- Improved API reference
- Improved appendix and language reference

---

## Fixes

- Fixed numerous parser bugs
- Fixed formatter inconsistencies
- Fixed built-in struct handling
- Fixed HTTP runtime issues
- Fixed generic type resolution
- Fixed module and compiler edge cases
- Fixed known compiler, runtime, tooling, and standard library bugs

---

## Notes

This release marks the beginning of the **ZEN v2** series. The language syntax is now considered stable, with future releases focusing on new capabilities, performance improvements, tooling, and standard library expansion while maintaining backward compatibility.