# Error Reference

Version: Zen v3.0.0

Every error is reported as `[Zen  <ErrorType>]` followed by a message. Compile-time errors also include the source location (`file:line:col`). Runtime errors include only the message, because location is not available at runtime.

Messages can change between versions. The error type is the stable part.

## Compile-Time Errors

Caught before execution. The program does not run until they are fixed.

- **SyntaxError**: source text does not follow Zen's grammar.
- **TypeError**: a value is used where a different type is required.
- **ArgumentError**: a function or method is called with the wrong number of arguments.
- **DeclarationError**: a variable, function or type is declared in a way the language does not allow.
- **ConstError**: a constant is reassigned or modified.
- **SemanticError**: code is valid syntax but breaks a language rule, such as misplaced `return`/`break`/`continue` or a missing return path.
- **ArrayError**: a fixed-size array is declared or indexed incorrectly.
- **EnumError**: an enum is declared or used incorrectly.
- **InferError**: `auto` cannot infer the type of an expression.
- **NameError**: a name is defined twice or collides with an existing name.
- **NamingError**: an identifier is not allowed.
- **ReservedFunctionError**: a reserved function name is used for a user declaration.
- **ReferenceError**: a variable, function, struct, field or map key is referenced but not defined (also raised when naming a hidden struct).
- **ExportError**: an export rule is violated.
- **ImportError**: an import cannot be resolved or breaks an import rule (including aliasing a struct).
- **ModuleError**: the module system fails, for example a problem found while analysing imports.
- **FileNotFound**: a source or imported file does not exist.
- **ThreadError**: a thread function or thread method is used incorrectly.
- **PlatformError**: the host platform or CPU architecture is not supported by the compiler.
- **InternalError**: the compiler reached a state that should never happen. This is a compiler bug, not a user mistake.

## Runtime Errors

Raised while the program runs. They stop the program immediately.

- **IndexError**: a List or array is accessed outside its bounds.
- **MemoryError**: a heap object is used after it was freed.
- **LoopError**: a loop cannot iterate its target, such as a Map whose values cannot be resolved to one type.
- **JsonError**: a JSON operation fails: invalid JSON text, missing key, wrong getter type, number overflow for the getter used, or array index out of bounds.
- **PanicError**: the program called `sys.panic()` to stop on an invalid state.
- **NetworkError**: an HTTP request fails, including timeouts.
