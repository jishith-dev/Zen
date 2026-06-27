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
