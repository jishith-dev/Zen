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
