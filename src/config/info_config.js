// info_config.js
// Single source of truth for built-in documentation: used by `zen info`, the LSP
// (hover / completion / signature help) and any other compiler tooling.
//
// Types use Zen names (int, long, byte, bool, double, string, List<T>, Map, ...).
// "any" means any value. "optional: true" marks an optional trailing parameter.
// "variadic: true" means extra arguments are accepted after the listed ones.
// origin: "compiler" = implemented by the compiler itself, "stdlib" = std function.

const BUILTIN_INFO = {
  namespaces: {
    os: {
      description: "Operating system, hardware and process information.",
      functions: {
        cpuCount: { description: "Number of logical CPU cores.", parameters: [], returnType: "int" },
        cpuArch: { description: "CPU architecture name.", parameters: [], returnType: "string" },
        cpuModel: { description: "CPU model name.", parameters: [], returnType: "string" },
        cpuSpeed: { description: "CPU clock speed.", parameters: [], returnType: "double" },
        totalMemory: { description: "Total system memory in bytes.", parameters: [], returnType: "long" },
        freeMemory: { description: "Free system memory in bytes.", parameters: [], returnType: "long" },
        usedMemory: { description: "Used system memory in bytes.", parameters: [], returnType: "long" },
        processMemory: { description: "Memory used by the current process in bytes.", parameters: [], returnType: "long" },
        osName: { description: "Operating system name.", parameters: [], returnType: "string" },
        osVersion: { description: "Operating system version.", parameters: [], returnType: "string" },
        username: { description: "Name of the current user.", parameters: [], returnType: "string" },
        hostname: { description: "Host name of the machine.", parameters: [], returnType: "string" },
        uptime: { description: "System uptime in seconds.", parameters: [], returnType: "double" },
        battery: { description: "Battery status as a string.", parameters: [], returnType: "string" },
        exit: { description: "Terminates the program with the given exit code.", parameters: [{ name: "code", type: "int" }], returnType: "void" },
        pid: { description: "ID of the current process.", parameters: [], returnType: "long" },
        parentPid: { description: "ID of the parent process.", parameters: [], returnType: "long" },
        platform: { description: "Platform identifier string.", parameters: [], returnType: "string" },
        isWindows: { description: "Returns true when running on Windows.", parameters: [], returnType: "bool" },
        isLinux: { description: "Returns true when running on Linux.", parameters: [], returnType: "bool" },
        isMac: { description: "Returns true when running on macOS.", parameters: [], returnType: "bool" },
        isAndroid: { description: "Returns true when running on Android.", parameters: [], returnType: "bool" },
        homeDir: { description: "Home directory path of the current user.", parameters: [], returnType: "string" },
      },
    },

    httpServer: {
      description: "HTTP server creation.",
      functions: {
        create: { description: "Creates an HTTP server for the given port. Use listen() and next() on the result.", parameters: [{ name: "port", type: "int" }], returnType: "HttpServer" },
      },
    },

    threads: {
      description: "Thread control and inspection.",
      functions: {
        waitAll: { description: "Blocks until all threads have finished.", parameters: [], returnType: "void" },
        count: { description: "Number of running threads.", parameters: [], returnType: "long" },
        currentId: { description: "ID of the calling thread.", parameters: [], returnType: "long" },
      },
    },

    debug: {
      description: "Debugging helpers.",
      functions: {
        pretty: { description: "Formats a List, Map or struct as readable text.", parameters: [{ name: "value", type: "any" }], returnType: "string" },
      },
    },

    crypto: {
      description: "Hashing, HMAC, random bytes and base64 encoding.",
      functions: {
        sha256: { description: "Computes the SHA-256 hash of a string as bytes.", parameters: [{ name: "text", type: "string" }], returnType: "List<byte>" },
        sha512: { description: "Computes the SHA-512 hash of a string as bytes.", parameters: [{ name: "text", type: "string" }], returnType: "List<byte>" },
        hmacSha256: { description: "Computes an HMAC-SHA256 from a key and a message, as bytes.", parameters: [{ name: "key", type: "string" }, { name: "message", type: "string" }], returnType: "List<byte>" },
        hmacSha512: { description: "Computes an HMAC-SHA512 from a key and a message, as bytes.", parameters: [{ name: "key", type: "string" }, { name: "message", type: "string" }], returnType: "List<byte>" },
        randomBytes: { description: "Generates count cryptographically secure random bytes.", parameters: [{ name: "count", type: "int" }], returnType: "List<byte>" },
        randomInt: { description: "Returns a cryptographically secure random int between min and max.", parameters: [{ name: "min", type: "int" }, { name: "max", type: "int" }], returnType: "int" },
        base64Encode: { description: "Encodes bytes as a base64 string.", parameters: [{ name: "bytes", type: "List<byte>" }], returnType: "string" },
        base64Decode: { description: "Decodes a base64 string into bytes.", parameters: [{ name: "text", type: "string" }], returnType: "List<byte>" },
        base64UrlEncode: { description: "Encodes bytes as a URL-safe base64 string.", parameters: [{ name: "bytes", type: "List<byte>" }], returnType: "string" },
        base64UrlDecode: { description: "Decodes a URL-safe base64 string into bytes.", parameters: [{ name: "text", type: "string" }], returnType: "List<byte>" },
      },
    },

    fs: {
      description: "File and directory operations.",
      functions: {
        cwd: { description: "Returns the current working directory.", parameters: [], returnType: "string" },
        readFile: { description: "Reads a whole file as a string.", parameters: [{ name: "path", type: "string" }], returnType: "string" },
        writeFile: { description: "Writes a string to a file, replacing its content. Returns an int status.", parameters: [{ name: "path", type: "string" }, { name: "content", type: "string" }], returnType: "int" },
        readFileBytes: { description: "Reads a whole file as bytes.", parameters: [{ name: "path", type: "string" }], returnType: "List<byte>" },
        writeFileBytes: { description: "Writes bytes to a file, replacing its content.", parameters: [{ name: "path", type: "string" }, { name: "bytes", type: "List<byte>" }], returnType: "int" },
        exists: { description: "Returns true if the path exists.", parameters: [{ name: "path", type: "string" }], returnType: "bool" },
        deleteFile: { description: "Deletes a file. Returns an int status.", parameters: [{ name: "path", type: "string" }], returnType: "int" },
        makeDir: { description: "Creates a directory. Returns an int status.", parameters: [{ name: "path", type: "string" }], returnType: "int" },
        appendFile: { description: "Appends a string to the end of a file. Returns an int status.", parameters: [{ name: "path", type: "string" }, { name: "content", type: "string" }], returnType: "int" },
        changeDir: { description: "Changes the current working directory. Returns an int status.", parameters: [{ name: "path", type: "string" }], returnType: "int" },
        renameFile: { description: "Renames or moves a file. Returns an int status.", parameters: [{ name: "oldPath", type: "string" }, { name: "newPath", type: "string" }], returnType: "int" },
        listDir: { description: "Lists the entries of a directory as a List of names.", parameters: [{ name: "path", type: "string" }], returnType: "List<string>" },
        isDir: { description: "Returns true if the path is a directory.", parameters: [{ name: "path", type: "string" }], returnType: "bool" },
        isFile: { description: "Returns true if the path is a regular file.", parameters: [{ name: "path", type: "string" }], returnType: "bool" },
      },
    },

    sys: {
      description: "Shell commands, environment, terminal and clipboard access.",
      functions: {
        spawn: { description: "Starts a shell command in the background. Returns its process ID.", parameters: [{ name: "command", type: "string" }], returnType: "long" },
        kill: { description: "Sends a signal to a process. Returns an int status.", parameters: [{ name: "pid", type: "long" }, { name: "signal", type: "int" }], returnType: "int" },
        wait: { description: "Waits for a process to finish. Returns an int status.", parameters: [{ name: "pid", type: "long" }], returnType: "int" },
        isRunning: { description: "Returns true if the process is still running.", parameters: [{ name: "pid", type: "long" }], returnType: "bool" },
        exec: { description: "Runs a shell command. Returns an int status.", parameters: [{ name: "command", type: "string" }], returnType: "int" },
        panic: { description: "Prints an error message and terminates the program.", parameters: [{ name: "message", type: "string" }], returnType: "void" },
        getEnv: { description: "Returns the value of an environment variable.", parameters: [{ name: "name", type: "string" }], returnType: "string" },
        color: { description: "Sets the terminal text color.", parameters: [{ name: "color", type: "string" }], returnType: "void" },
        performance: { description: "Returns a high-resolution timer value for benchmarking.", parameters: [], returnType: "double" },
        argv: { description: "Returns the command-line arguments as a List.", parameters: [], returnType: "List<string>" },
        setEnv: { description: "Sets an environment variable.", parameters: [{ name: "name", type: "string" }, { name: "value", type: "string" }], returnType: "void" },
        hasEnv: { description: "Returns true if the environment variable exists.", parameters: [{ name: "name", type: "string" }], returnType: "bool" },
        execOutput: { description: "Runs a shell command and returns its output.", parameters: [{ name: "command", type: "string" }], returnType: "string" },
        key: { description: "Reads a single key press from the terminal.", parameters: [], returnType: "string" },
        clipboard_get: { description: "Returns the text in the clipboard.", parameters: [], returnType: "string" },
        clipboard_set: { description: "Copies text to the clipboard.", parameters: [{ name: "text", type: "string" }], returnType: "void" },
        clipboard_clear: { description: "Clears the clipboard.", parameters: [], returnType: "void" },
        clipboard_hasText: { description: "Returns true if the clipboard contains text.", parameters: [], returnType: "bool" },
      },
    },

    time: {
      description: "Time, date, sleeping and formatting.",
      functions: {
        sleep: { description: "Pauses execution for the given number of milliseconds.", parameters: [{ name: "ms", type: "long" }], returnType: "void" },
        time: { description: "Returns the current time as a string.", parameters: [], returnType: "string" },
        millis: { description: "Returns the current time in milliseconds.", parameters: [], returnType: "long" },
        date: { description: "Returns the current day of the month.", parameters: [], returnType: "int" },
        month: { description: "Returns the current month.", parameters: [], returnType: "int" },
        day: { description: "Returns the current day of the week.", parameters: [], returnType: "int" },
        year: { description: "Returns the current year.", parameters: [], returnType: "int" },
        now: { description: "Returns the current timestamp.", parameters: [], returnType: "long" },
        format: { description: "Formats a timestamp as a readable string.", parameters: [{ name: "timestamp", type: "long" }], returnType: "string" },
      },
    },

    net: {
      description: "Networking: connectivity check and raw TCP.",
      functions: {
        online: { description: "Returns true if an internet connection is available.", parameters: [], returnType: "bool" },
        connect: { description: "Opens a TCP connection to host:port.", parameters: [{ name: "host", type: "string" }, { name: "port", type: "int" }], returnType: "Tcp" },
        listen: { description: "Starts a TCP server on the given port.", parameters: [{ name: "port", type: "int" }], returnType: "TcpServer" },
      },
    },

    http: {
      description: "HTTP client requests and URL encoding.",
      functions: {
        get: { description: "Sends a GET request and returns the response body.", parameters: [{ name: "url", type: "string" }], returnType: "string" },
        post: { description: "Sends a POST request and returns the response body.", parameters: [{ name: "url", type: "string" }, { name: "body", type: "string" }], returnType: "string" },
        put: { description: "Sends a PUT request and returns the response body.", parameters: [{ name: "url", type: "string" }, { name: "body", type: "string" }], returnType: "string" },
        patch: { description: "Sends a PATCH request and returns the response body.", parameters: [{ name: "url", type: "string" }, { name: "body", type: "string" }], returnType: "string" },
        delete: { description: "Sends a DELETE request and returns the response body.", parameters: [{ name: "url", type: "string" }], returnType: "string" },
        urlEncode: { description: "Percent-encodes a string for use in a URL.", parameters: [{ name: "text", type: "string" }], returnType: "string" },
        urlDecode: { description: "Decodes a percent-encoded string.", parameters: [{ name: "text", type: "string" }], returnType: "string" },
        setHeader: { description: "Sets a header sent with following requests.", parameters: [{ name: "name", type: "string" }, { name: "value", type: "string" }], returnType: "void" },
        clearHeaders: { description: "Removes all headers set with setHeader.", parameters: [], returnType: "void" },
        lastStatus: { description: "Returns the status code of the last request.", parameters: [], returnType: "int" },
        getProgress: { description: "Downloads a URL while reporting downloaded and total bytes through a callback.", parameters: [{ name: "url", type: "string" }, { name: "callback", type: "fn cb(long downloaded, long total) void" }], returnType: "List<byte>" },
      },
    },

    ffi: {
      description: "Direct bindings to C standard library functions.",
      functions: {
        printf: { description: "C printf. Prints formatted output to stdout.", parameters: [{ name: "format", type: "string" }], returnType: "int", variadic: true },
        puts: { description: "Writes a string and a newline to stdout.", parameters: [{ name: "text", type: "string" }], returnType: "int" },
        putchar: { description: "Writes one character (by code) to stdout.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        getchar: { description: "Reads one character from stdin as an int.", parameters: [], returnType: "int" },
        strlen: { description: "Returns the length of a string.", parameters: [{ name: "text", type: "string" }], returnType: "int" },
        strcmp: { description: "Compares two strings. Returns <0, 0 or >0.", parameters: [{ name: "a", type: "string" }, { name: "b", type: "string" }], returnType: "int" },
        strncmp: { description: "Compares at most n characters of two strings.", parameters: [{ name: "a", type: "string" }, { name: "b", type: "string" }, { name: "n", type: "int" }], returnType: "int" },
        pow: { description: "Returns base raised to the power exp.", parameters: [{ name: "base", type: "double" }, { name: "exp", type: "double" }], returnType: "double" },
        sqrt: { description: "Returns the square root of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        fabs: { description: "Returns the absolute value of a double.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        floor: { description: "Rounds x down to a whole number.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        ceil: { description: "Rounds x up to a whole number.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        round: { description: "Rounds x to the nearest whole number.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        sin: { description: "Sine of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        cos: { description: "Cosine of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        tan: { description: "Tangent of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        log: { description: "Natural logarithm of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        exp: { description: "Returns e raised to the power x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        system: { description: "Runs a shell command. Returns its status.", parameters: [{ name: "command", type: "string" }], returnType: "int" },
        abort: { description: "Terminates the program abnormally.", parameters: [], returnType: "void" },
        clock: { description: "Returns the processor time used by the program.", parameters: [], returnType: "int" },
        rand: { description: "Returns a pseudo-random int.", parameters: [], returnType: "int" },
        srand: { description: "Seeds the rand() generator.", parameters: [{ name: "seed", type: "int" }], returnType: "void" },
        fmod: { description: "Floating-point remainder of x divided by y.", parameters: [{ name: "x", type: "double" }, { name: "y", type: "double" }], returnType: "double" },
        log10: { description: "Base-10 logarithm of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        log2: { description: "Base-2 logarithm of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        atan: { description: "Arc tangent of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        asin: { description: "Arc sine of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        acos: { description: "Arc cosine of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        atan2: { description: "Arc tangent of y / x using the signs to pick the quadrant.", parameters: [{ name: "y", type: "double" }, { name: "x", type: "double" }], returnType: "double" },
        sinh: { description: "Hyperbolic sine of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        cosh: { description: "Hyperbolic cosine of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        tanh: { description: "Hyperbolic tangent of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        trunc: { description: "Rounds x toward zero.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        cbrt: { description: "Cube root of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
        abs: { description: "Returns the absolute value of an int.", parameters: [{ name: "n", type: "int" }], returnType: "int" },
        atoi: { description: "Parses an int from a string.", parameters: [{ name: "text", type: "string" }], returnType: "int" },
        atof: { description: "Parses a double from a string.", parameters: [{ name: "text", type: "string" }], returnType: "double" },
        toupper: { description: "Converts a character code to upper case.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        tolower: { description: "Converts a character code to lower case.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        isalpha: { description: "Non-zero if the character is a letter.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        isdigit: { description: "Non-zero if the character is a digit.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        isspace: { description: "Non-zero if the character is whitespace.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        isupper: { description: "Non-zero if the character is upper case.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        islower: { description: "Non-zero if the character is lower case.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        isalnum: { description: "Non-zero if the character is a letter or digit.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        ispunct: { description: "Non-zero if the character is punctuation.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
        isxdigit: { description: "Non-zero if the character is a hex digit.", parameters: [{ name: "ch", type: "int" }], returnType: "int" },
      },
    },

    path: {
      description: "File path manipulation.",
      functions: {
        basename: { description: "Returns the last component of a path.", parameters: [{ name: "path", type: "string" }], returnType: "string" },
        dirname: { description: "Returns the directory part of a path.", parameters: [{ name: "path", type: "string" }], returnType: "string" },
        extname: { description: "Returns the file extension of a path.", parameters: [{ name: "path", type: "string" }], returnType: "string" },
        join: { description: "Joins two path segments.", parameters: [{ name: "a", type: "string" }, { name: "b", type: "string" }], returnType: "string" },
        normalize: { description: "Resolves '.', '..' and duplicate separators in a path.", parameters: [{ name: "path", type: "string" }], returnType: "string" },
      },
    },

  },

  global_fn: {
    isEven: { origin: "stdlib", description: "Returns true if n is even.", parameters: [{ name: "n", type: "int" }], returnType: "bool" },
    isOdd: { origin: "stdlib", description: "Returns true if n is odd.", parameters: [{ name: "n", type: "int" }], returnType: "bool" },
    isPositive: { origin: "stdlib", description: "Returns true if n is greater than zero.", parameters: [{ name: "n", type: "int" }], returnType: "bool" },
    isNegative: { origin: "stdlib", description: "Returns true if n is less than zero.", parameters: [{ name: "n", type: "int" }], returnType: "bool" },
    abs: { origin: "stdlib", description: "Returns the absolute value of n.", parameters: [{ name: "n", type: "int" }], returnType: "int" },
    max: { origin: "stdlib", description: "Returns the larger of a and b.", parameters: [{ name: "a", type: "int" }, { name: "b", type: "int" }], returnType: "int" },
    min: { origin: "stdlib", description: "Returns the smaller of a and b.", parameters: [{ name: "a", type: "int" }, { name: "b", type: "int" }], returnType: "int" },
    clamp: { origin: "stdlib", description: "Limits value to the range min..max.", parameters: [{ name: "value", type: "int" }, { name: "min", type: "int" }, { name: "max", type: "int" }], returnType: "int" },
    sign: { origin: "stdlib", description: "Returns -1, 0 or 1 depending on the sign of n.", parameters: [{ name: "n", type: "int" }], returnType: "int" },
    pow: { origin: "stdlib", description: "Returns base raised to the power exp.", parameters: [{ name: "base", type: "int" }, { name: "exp", type: "int" }], returnType: "double" },
    sqrt: { origin: "stdlib", description: "Returns the square root of n as an int.", parameters: [{ name: "n", type: "double" }], returnType: "double"},
    square: { origin: "stdlib", description: "Returns n multiplied by itself.", parameters: [{ name: "n", type: "int" }], returnType: "int" },
    cube: { origin: "stdlib", description: "Returns n multiplied by itself twice.", parameters: [{ name: "n", type: "int" }], returnType: "int" },
    floor: { origin: "stdlib", description: "Rounds x down to an int.", parameters: [{ name: "x", type: "double" }], returnType: "int" },
    ceil: { origin: "stdlib", description: "Rounds x up to an int.", parameters: [{ name: "x", type: "double" }], returnType: "int" },
    round: { origin: "stdlib", description: "Rounds x to the nearest int.", parameters: [{ name: "x", type: "double" }], returnType: "int" },
    toFixed: { origin: "stdlib", description: "Rounds value to the given number of decimal places.", parameters: [{ name: "value", type: "double" }, { name: "places", type: "int" }], returnType: "double" },
    mod: { origin: "stdlib", description: "Returns the remainder of a divided by b.", parameters: [{ name: "a", type: "int" }, { name: "b", type: "int" }], returnType: "int" },
    gcd: { origin: "stdlib", description: "Returns the greatest common divisor of a and b.", parameters: [{ name: "a", type: "int" }, { name: "b", type: "int" }], returnType: "int" },
    lcm: { origin: "stdlib", description: "Returns the least common multiple of a and b.", parameters: [{ name: "a", type: "int" }, { name: "b", type: "int" }], returnType: "int" },
    factorial: { origin: "stdlib", description: "Returns n! as a double.", parameters: [{ name: "n", type: "int" }], returnType: "double" },
    isPrime: { origin: "stdlib", description: "Returns true if n is a prime number.", parameters: [{ name: "n", type: "int" }], returnType: "bool" },
    lerp: { origin: "stdlib", description: "Linear interpolation from a to b by factor t.", parameters: [{ name: "a", type: "double" }, { name: "b", type: "double" }, { name: "t", type: "double" }], returnType: "double" },
    normalize: { origin: "stdlib", description: "Scales value from the range min..max into 0..1.", parameters: [{ name: "value", type: "double" }, { name: "min", type: "double" }, { name: "max", type: "double" }], returnType: "double" },
    between: { origin: "stdlib", description: "Returns true if value lies within min..max.", parameters: [{ name: "value", type: "int" }, { name: "min", type: "int" }, { name: "max", type: "int" }], returnType: "bool" },
    reverse: { origin: "stdlib", description: "Returns text reversed.", parameters: [{ name: "text", type: "string" }], returnType: "string" },
    indexOf: { origin: "stdlib", description: "Returns the index of the first occurrence of search in text.", parameters: [{ name: "text", type: "string" }, { name: "search", type: "string" }], returnType: "int" },
    lastIndexOf: { origin: "stdlib", description: "Returns the index of the last occurrence of search in text.", parameters: [{ name: "text", type: "string" }, { name: "search", type: "string" }], returnType: "int" },
    slice: { origin: "stdlib", description: "Returns the part of text from start to end.", parameters: [{ name: "text", type: "string" }, { name: "start", type: "int" }, { name: "end", type: "int" }], returnType: "string" },
    charAt: { origin: "stdlib", description: "Returns the character at index.", parameters: [{ name: "text", type: "string" }, { name: "index", type: "int" }], returnType: "string" },
    replace: { origin: "stdlib", description: "Replaces the first occurrence of search in text.", parameters: [{ name: "text", type: "string" }, { name: "search", type: "string" }, { name: "replacement", type: "string" }], returnType: "string" },
    replaceAll: { origin: "stdlib", description: "Replaces every occurrence of search in text.", parameters: [{ name: "text", type: "string" }, { name: "search", type: "string" }, { name: "replacement", type: "string" }], returnType: "string" },
    contains: { origin: "stdlib", description: "Returns true if text contains search.", parameters: [{ name: "text", type: "string" }, { name: "search", type: "string" }], returnType: "bool" },
    upperCase: { origin: "stdlib", description: "Converts text to upper case.", parameters: [{ name: "text", type: "string" }], returnType: "string" },
    lowerCase: { origin: "stdlib", description: "Converts text to lower case.", parameters: [{ name: "text", type: "string" }], returnType: "string" },
    startsWith: { origin: "stdlib", description: "Returns true if text starts with prefix.", parameters: [{ name: "text", type: "string" }, { name: "prefix", type: "string" }], returnType: "bool" },
    endsWith: { origin: "stdlib", description: "Returns true if text ends with suffix.", parameters: [{ name: "text", type: "string" }, { name: "suffix", type: "string" }], returnType: "bool" },
    trim: { origin: "stdlib", description: "Removes whitespace from both ends of text.", parameters: [{ name: "text", type: "string" }], returnType: "string" },
    splitAt: { origin: "stdlib", description: "Splits text by sep and returns the part at index.", parameters: [{ name: "text", type: "string" }, { name: "sep", type: "string" }, { name: "index", type: "int" }], returnType: "string" },
    split: { origin: "stdlib", description: "Splits text by sep.", parameters: [{ name: "text", type: "string" }, { name: "sep", type: "string" }], returnType: "List<string>" },
    repeat: { origin: "stdlib", description: "Repeats text count times.", parameters: [{ name: "text", type: "string" }, { name: "count", type: "int" }], returnType: "string" },
    count: { origin: "stdlib", description: "Counts the occurrences of search in text.", parameters: [{ name: "text", type: "string" }, { name: "search", type: "string" }], returnType: "int" },
    padStart: { origin: "stdlib", description: "Pads the start of text with fill up to width.", parameters: [{ name: "text", type: "string" }, { name: "width", type: "int" }, { name: "fill", type: "string" }], returnType: "string" },
    padEnd: { origin: "stdlib", description: "Pads the end of text with fill up to width.", parameters: [{ name: "text", type: "string" }, { name: "width", type: "int" }, { name: "fill", type: "string" }], returnType: "string" },
    padCenter: { origin: "stdlib", description: "Pads both sides of text with fill up to width.", parameters: [{ name: "text", type: "string" }, { name: "width", type: "int" }, { name: "fill", type: "string" }], returnType: "string" },
    capitalize: { origin: "stdlib", description: "Upper-cases the first character of text.", parameters: [{ name: "text", type: "string" }], returnType: "string" },
    extName: { origin: "stdlib", description: "Returns the file extension of a path.", parameters: [{ name: "path", type: "string" }], returnType: "string" },
    sin: { origin: "stdlib", description: "Sine of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
    cos: { origin: "stdlib", description: "Cosine of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
    tan: { origin: "stdlib", description: "Tangent of x in radians.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
    log: { origin: "stdlib", description: "Natural logarithm of x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
    exp: { origin: "stdlib", description: "Returns e raised to the power x.", parameters: [{ name: "x", type: "double" }], returnType: "double" },
    randomInt: { origin: "stdlib", description: "Returns a random int between min and max.", parameters: [{ name: "min", type: "int" }, { name: "max", type: "int" }], returnType: "int" },
    random: { origin: "stdlib", description: "Returns a random double.", parameters: [], returnType: "double" },
    match: { origin: "stdlib", description: "Returns true if text matches pattern.", parameters: [{ name: "text", type: "string" }, { name: "pattern", type: "string" }], returnType: "bool" },
    json: { origin: "stdlib", description: "JSON string helper. Takes two strings and returns a string.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "string" }], returnType: "string" },
    screen: { origin: "compiler", description: "Prints a value to the screen. The optional format string controls how the value is formatted.", parameters: [{ name: "value", type: "any" }, { name: "format", type: "string", optional: true }], returnType: "void" },
    input: { origin: "compiler", description: "Reads a line from standard input.", parameters: [], returnType: "string" },
    type: { origin: "compiler", description: "Returns the type name of a value.", parameters: [{ name: "value", type: "any" }], returnType: "string" },
    Int: { origin: "compiler", description: "Converts a value to int.", parameters: [{ name: "value", type: "any" }], returnType: "int" },
    Long: { origin: "compiler", description: "Converts a value to long.", parameters: [{ name: "value", type: "any" }], returnType: "long" },
    Double: { origin: "compiler", description: "Converts a value to double.", parameters: [{ name: "value", type: "any" }], returnType: "double" },
    Bool: { origin: "compiler", description: "Converts a value to bool.", parameters: [{ name: "value", type: "any" }], returnType: "bool" },
    String: { origin: "compiler", description: "Converts a value to string.", parameters: [{ name: "value", type: "any" }], returnType: "string" },
    intToAscii: { origin: "compiler", description: "Converts an integer to an ASCII character string.", parameters: [{ name: "value", type: "any" }], returnType: "string" },
    asciiToInt: { origin: "compiler", description: "Converts a string of ASCII characters to their summed integer value.", parameters: [{ name: "value", type: "any" }], returnType: "int" },
    length: { origin: "compiler", description: "Returns the length of a string or List.", parameters: [{ name: "value", type: "any" }], returnType: "int" },
    sizeOf: { origin: "compiler", description: "Returns the size in bytes of a value or type.", parameters: [{ name: "value", type: "any" }], returnType: "int" },
    Byte: { origin: "compiler", description: "Converts a value to byte.", parameters: [{ name: "value", type: "any" }], returnType: "byte" },
    stringToBytes: { origin: "compiler", description: "Converts a string to List<byte>.", parameters: [{ name: "text", type: "string" }], returnType: "List<byte>" },
    bytesToString: { origin: "compiler", description: "Converts List<byte> to a string.", parameters: [{ name: "bytes", type: "List<byte>" }], returnType: "string" },
    matchRegex: { origin: "compiler", description: "Returns true if text matches the regular expression pattern.", parameters: [{ name: "text", type: "string" }, { name: "pattern", type: "string" }], returnType: "bool" },
  },

  structs: {
    Tcp: {
      description: "TCP connection. Comes from net.connect() or TcpServer.accept().",
      methods: {
        send: { description: "Sends bytes. Returns the number of bytes sent.", parameters: [{ name: "data", type: "List<byte>" }], returnType: "long" },
        receive: { description: "Receives up to size bytes.", parameters: [{ name: "size", type: "int" }], returnType: "List<byte>" },
        close: { description: "Closes the connection.", parameters: [], returnType: "void" },
        isOpen: { description: "Returns true while the connection is open.", parameters: [], returnType: "bool" },
      },
    },

    TcpServer: {
      description: "TCP server. Created with net.listen().",
      methods: {
        accept: { description: "Waits for a client and returns its Tcp connection.", parameters: [], returnType: "Tcp" },
        close: { description: "Stops the server.", parameters: [], returnType: "void" },
        isOpen: { description: "Returns true while the server is open.", parameters: [], returnType: "bool" },
      },
    },

    Json: {
      description: "Parsed JSON document. Call Json.parse() before using any other method.",
      methods: {
        getInt: { description: "Reads the int value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "int" },
        map: { description: "Converts the JSON object into a Map.", parameters: [], returnType: "Map" },
        getLong: { description: "Reads the long value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "long" },
        getByte: { description: "Reads the byte value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "byte" },
        getDouble: { description: "Reads the double value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "double" },
        getString: { description: "Reads the string value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "string" },
        getBool: { description: "Reads the bool value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "bool" },
        getArray: { description: "Reads the array stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "JsonArray" },
        getObject: { description: "Reads the object stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "JsonObject" },
        has: { description: "Returns true if key exists.", parameters: [{ name: "key", type: "string" }], returnType: "bool" },
        isNull: { description: "Returns true if the value is null.", parameters: [], returnType: "bool" },
        arrayLength: { description: "Returns the number of elements in the array.", parameters: [], returnType: "int" },
        arrayGetInt: { description: "Reads the int element at index.", parameters: [{ name: "index", type: "int" }], returnType: "int" },
        arrayGetDouble: { description: "Reads the double element at index.", parameters: [{ name: "index", type: "int" }], returnType: "double" },
        arrayGetBool: { description: "Reads the bool element at index.", parameters: [{ name: "index", type: "int" }], returnType: "bool" },
        arrayGetString: { description: "Reads the string element at index.", parameters: [{ name: "index", type: "int" }], returnType: "string" },
        arrayGetObject: { description: "Reads the object element at index.", parameters: [{ name: "index", type: "int" }], returnType: "JsonObject" },
        arrayGetArray: { description: "Reads the array element at index.", parameters: [{ name: "index", type: "int" }], returnType: "JsonArray" },
        parse: { description: "Parses a JSON string. Must be called before other Json methods.", parameters: [{ name: "text", type: "string" }], returnType: "void", static: true },
        free: { description: "Releases the parsed JSON.", parameters: [], returnType: "void" },
        getRootArray: { description: "Returns the root value as a JsonArray.", parameters: [], returnType: "JsonArray" },
        getRootObject: { description: "Returns the root value as a JsonObject.", parameters: [], returnType: "JsonObject" },
      },
    },

    JsonObject: {
      description: "JSON object. Comes from Json.getObject() or Json.getRootObject().",
      methods: {
        getInt: { description: "Reads the int value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "int" },
        getLong: { description: "Reads the long value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "long" },
        getByte: { description: "Reads the byte value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "byte" },
        getDouble: { description: "Reads the double value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "double" },
        getString: { description: "Reads the string value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "string" },
        getBool: { description: "Reads the bool value stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "bool" },
        getArray: { description: "Reads the array stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "JsonArray" },
        getObject: { description: "Reads the object stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "JsonObject" },
        has: { description: "Returns true if key exists.", parameters: [{ name: "key", type: "string" }], returnType: "bool" },
        isNull: { description: "Returns true if the value is null.", parameters: [], returnType: "bool" },
      },
    },

    JsonArray: {
      description: "JSON array. Comes from Json.getArray() or Json.getRootArray().",
      methods: {
        arrayLength: { description: "Returns the number of elements in the array.", parameters: [], returnType: "int" },
        arrayGetInt: { description: "Reads the int element at index.", parameters: [{ name: "index", type: "int" }], returnType: "int" },
        arrayGetLong: { description: "Reads the long element at index.", parameters: [{ name: "index", type: "int" }], returnType: "long" },
        arrayGetByte: { description: "Reads the byte element at index.", parameters: [{ name: "index", type: "int" }], returnType: "byte" },
        arrayGetDouble: { description: "Reads the double element at index.", parameters: [{ name: "index", type: "int" }], returnType: "double" },
        arrayGetBool: { description: "Reads the bool element at index.", parameters: [{ name: "index", type: "int" }], returnType: "bool" },
        arrayGetString: { description: "Reads the string element at index.", parameters: [{ name: "index", type: "int" }], returnType: "string" },
        arrayGetObject: { description: "Reads the object element at index.", parameters: [{ name: "index", type: "int" }], returnType: "JsonObject" },
        arrayGetArray: { description: "Reads the array element at index.", parameters: [{ name: "index", type: "int" }], returnType: "JsonArray" },
      },
    },

    HttpServer: {
      description: "HTTP server. Created with httpServer.create().",
      methods: {
        listen: { description: "Starts listening for connections. Returns an int status.", parameters: [], returnType: "int" },
        next: { description: "Waits for the next request and returns it.", parameters: [], returnType: "HttpRequest" },
        close: { description: "Stops the server.", parameters: [], returnType: "void" },
      },
    },

    HttpRequest: {
      description: "Incoming HTTP request with helpers to send the response.",
      methods: {
        sendFile: { description: "Sends a file as the response with the given content type.", parameters: [{ name: "path", type: "string" }, { name: "contentType", type: "string" }], returnType: "void" },
        send: { description: "Sends a text response.", parameters: [{ name: "body", type: "string" }], returnType: "void" },
        status: { description: "Sets the response status code.", parameters: [{ name: "code", type: "int" }], returnType: "void" },
        json: { description: "Sends a JSON response.", parameters: [{ name: "data", type: "string" }], returnType: "void" },
        css: { description: "Sends a CSS response.", parameters: [{ name: "data", type: "string" }], returnType: "void" },
        html: { description: "Sends an HTML response.", parameters: [{ name: "data", type: "string" }], returnType: "void" },
        redirect: { description: "Redirects the client to url.", parameters: [{ name: "url", type: "string" }], returnType: "void" },
        setHeader: { description: "Sets a response header.", parameters: [{ name: "name", type: "string" }, { name: "value", type: "string" }], returnType: "void" },
        getHeader: { description: "Returns the value of a request header.", parameters: [{ name: "name", type: "string" }], returnType: "string" },
      },
      properties: {
        method: { description: "HTTP method of the request.", type: "string" },
        path: { description: "Path of the request.", type: "string" },
        body: { description: "Body of the request.", type: "string" },
        method: { description: "HTTP method of the request.", parameters: [], returnType: "string" },
        path: { description: "Path of the request.", parameters: [], returnType: "string" },
        body: { description: "Body of the request.", parameters: [], returnType: "string" },
      },
    },

    HttpResponse: {},

    Ptr: {
      description: "Raw memory pointer for low-level access.",
      methods: {
        storeInt: { description: "Writes an int at the pointer.", parameters: [{ name: "value", type: "int" }], returnType: "void" },
        loadInt: { description: "Reads an int at the pointer.", parameters: [], returnType: "int" },
        storeDouble: { description: "Writes a double at the pointer.", parameters: [{ name: "value", type: "double" }], returnType: "void" },
        loadDouble: { description: "Reads a double at the pointer.", parameters: [], returnType: "double" },
        storeBool: { description: "Writes a bool at the pointer.", parameters: [{ name: "value", type: "bool" }], returnType: "void" },
        loadBool: { description: "Reads a bool at the pointer.", parameters: [], returnType: "bool" },
        loadLong: { description: "Reads a long at the pointer.", parameters: [], returnType: "long" },
        loadByte: { description: "Reads a byte at the pointer.", parameters: [], returnType: "byte" },
        storeLong: { description: "Writes a long at the pointer.", parameters: [{ name: "value", type: "long" }], returnType: "void" },
        storeByte: { description: "Writes a byte at the pointer.", parameters: [{ name: "value", type: "byte" }], returnType: "void" },
        storeString: { description: "Writes a string pointer at the pointer.", parameters: [{ name: "value", type: "string" }], returnType: "void" },
        loadString: { description: "Reads a string pointer at the pointer.", parameters: [], returnType: "string" },
        storePtr: { description: "Writes a Ptr at the pointer.", parameters: [{ name: "value", type: "Ptr" }], returnType: "void" },
        loadPtr: { description: "Reads a Ptr at the pointer.", parameters: [], returnType: "Ptr" },
        isNull: { description: "Returns true if the pointer is null.", parameters: [], returnType: "bool" },
        offset: { description: "Returns a new pointer moved forward by bytes.", parameters: [{ name: "bytes", type: "int" }], returnType: "Ptr" },
        copyFrom: { description: "Copies size bytes from source into this pointer.", parameters: [{ name: "source", type: "Ptr" }, { name: "size", type: "int" }], returnType: "void" },
        copyTo: { description: "Copies size bytes from this pointer into target.", parameters: [{ name: "target", type: "Ptr" }, { name: "size", type: "int" }], returnType: "void" },
        fill: { description: "Fills size bytes with value.", parameters: [{ name: "value", type: "int" }, { name: "size", type: "int" }], returnType: "void" },
        free: { description: "Frees the memory.", parameters: [], returnType: "void" },
      },
    },

    Map: {
      description: "Key/value map with typed getters and setters.",
      methods: {
        keys: { description: "Returns all keys.", parameters: [], returnType: "List<string>" },
        entries: { description: "Returns all key/value pairs as string pairs.", parameters: [], returnType: "List<List<string>>" },
        getInt: { description: "Reads the int stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "int" },
        getLong: { description: "Reads the long stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "long" },
        getByte: { description: "Reads the byte stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "byte" },
        getBool: { description: "Reads the bool stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "bool" },
        getDouble: { description: "Reads the double stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "double" },
        getString: { description: "Reads the string stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "string" },
        getMap: { description: "Reads the Map stored under key.", parameters: [{ name: "key", type: "string" }], returnType: "Map" },
        json: { description: "Serializes the map as a JSON string.", parameters: [], returnType: "string" },
        getList: { description: "Reads the List stored under key. Requires a compile-time type argument, e.g. map.getList<List<int>>(key).", parameters: [{ name: "key", type: "string" }], returnType: "List<T>" },
        setInt: { description: "Stores an int under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "int" }], returnType: "void" },
        setBool: { description: "Stores a bool under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "bool" }], returnType: "void" },
        setLong: { description: "Stores a long under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "long" }], returnType: "void" },
        setByte: { description: "Stores a byte under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "byte" }], returnType: "void" },
        setDouble: { description: "Stores a double under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "double" }], returnType: "void" },
        setString: { description: "Stores a string under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "string" }], returnType: "void" },
        setMap: { description: "Stores a Map under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "Map" }], returnType: "void" },
        setList: { description: "Stores a List under key.", parameters: [{ name: "key", type: "string" }, { name: "value", type: "List<T>" }], returnType: "void" },
        has: { description: "Returns true if key exists.", parameters: [{ name: "key", type: "string" }], returnType: "bool" },
        remove: { description: "Removes key and its value.", parameters: [{ name: "key", type: "string" }], returnType: "void" },
        free: { description: "Frees the map.", parameters: [], returnType: "void" },
      },
    },

  },

  constants: {
  PI: { description: "Ratio of a circle's circumference to its diameter (3.14159265358979).", type: "double", mutable: false },
  TAU: { description: "Full circle in radians, 2 * PI (6.28318530717959).", type: "double", mutable: false },
  E: { description: "Euler's number (2.71828182845905).", type: "double", mutable: false },
  PHI: { description: "The golden ratio (1.61803398874989).", type: "double", mutable: false },
  SQRT2: { description: "Square root of 2 (1.4142135623731).", type: "double", mutable: false },
  SQRT1_2: { description: "Square root of 1/2 (0.707106781186548).", type: "double", mutable: false },
  SQRT3: { description: "Square root of 3 (1.73205080756888).", type: "double", mutable: false },

  LN2: { description: "Natural logarithm of 2 (0.693147180559945).", type: "double", mutable: false },
  LN10: { description: "Natural logarithm of 10 (2.30258509299405).", type: "double", mutable: false },
  LOG2E: { description: "Base-2 logarithm of e (1.44269504088896).", type: "double", mutable: false },
  LOG10E: { description: "Base-10 logarithm of e (0.434294481903252).", type: "double", mutable: false },

  SEED: { description: "Global seed for random number generation. Can be changed.", type: "long", mutable: true },

  BYTE_MAX: { description: "Largest byte value (127).", type: "byte", mutable: false },
  BYTE_MIN: { description: "Smallest byte value (-128).", type: "byte", mutable: false },

  I32_MAX: { description: "Largest int value (2147483647).", type: "int", mutable: false },
  I32_MIN: { description: "Smallest int value (-2147483648).", type: "int", mutable: false },

  I64_MAX: { description: "Largest long value (9223372036854775807).", type: "long", mutable: false },
  I64_MIN: { description: "Smallest long value (-9223372036854775808).", type: "long", mutable: false },

  F64_MAX: { description: "Largest finite double value.", type: "double", mutable: false },
  F64_MIN: { description: "Minimum positive double value.", type: "double", mutable: false },
  F64_EPS: { description: "Smallest difference between 1.0 and the next double.", type: "double", mutable: false },

  INF: { description: "Positive infinity.", type: "double", mutable: false },
  NEG_INF: { description: "Negative infinity.", type: "double", mutable: false },
  NAN: { description: "Not a number.", type: "double", mutable: false },
},
};

// helpers (handy for info.js and the LSP)

const has = (obj, k) => Object.prototype.hasOwnProperty.call(obj, k);

function getNamespace(name) {
  return has(BUILTIN_INFO.namespaces, name) ? BUILTIN_INFO.namespaces[name] : null;
}

function getNamespaceFn(ns, name) {
  return getNamespace(ns)?.functions[name] ?? null;
}

function getGlobalFn(name) {
  return has(BUILTIN_INFO.global_fn, name) ? BUILTIN_INFO.global_fn[name] : null;
}

function getStruct(name) {
  return has(BUILTIN_INFO.structs, name) ? BUILTIN_INFO.structs[name] : null;
}

function getConstant(name) {
  return has(BUILTIN_INFO.constants, name) ? BUILTIN_INFO.constants[name] : null;
}

// "screen(any value, string format?) -> void"
function formatSignature(name, fn, prefix = "") {
  const params = fn.parameters.map(
    (p) => `${p.type} ${p.name}${p.optional ? "?" : ""}`
  );
  if (fn.variadic) params.push("...");
  return `${prefix}${name}(${params.join(", ")}) -> ${fn.returnType}`;
}

export {
  BUILTIN_INFO,
  getNamespace,
  getNamespaceFn,
  getGlobalFn,
  getStruct,
  getConstant,
  formatSignature,
};
