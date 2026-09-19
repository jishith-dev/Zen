import {
  GLOBAL_EXTERNAL,
  STD_FUNCTIONS_SCHEMA,
  NAMESPACE_REG,
  BUILTIN_STRUCT_METHODS,
  BUILTIN_STRUCT_PROPS,
  BUILTIN_MAP,
  ZEN_TYPES_MAP
} from "../../src/config/config.js";


const LINE = "─".repeat(50);

const has = (obj, key) => Object.prototype.hasOwnProperty.call(obj, key);


// Core builtins are not typed in config.js, so their params live here.
// A trailing "?" marks an optional parameter.
const CORE_PARAMS = {
  screen: ["any", "string?"],
  input: [],
  type: ["any"],
  Int: ["any"],
  Long: ["any"],
  Double: ["any"],
  Bool: ["any"],
  String: ["any"],
  toString: ["any"],
  toInt: ["any"],
  length: ["any"],
  sizeOf: ["any"],
  Byte: ["any"],
  stringToBytes: ["string"],
  bytesToString: ["List<byte>"]
};

const RETURN_ALIAS = {
  "httpServer.create": "HttpServer"
};


// ─────────────────────────────────────────────
// Descriptions
// Entry: "description"  or  ["param names", "description"]
// ─────────────────────────────────────────────

const JSON_GET = {
  getInt: ["key", "Reads the int value stored under key."],
  getLong: ["key", "Reads the long value stored under key."],
  getByte: ["key", "Reads the byte value stored under key."],
  getDouble: ["key", "Reads the double value stored under key."],
  getString: ["key", "Reads the string value stored under key."],
  getBool: ["key", "Reads the bool value stored under key."],
  getArray: ["key", "Reads the array stored under key."],
  getObject: ["key", "Reads the object stored under key."],
  has: ["key", "Returns true if key exists."],
  isNull: "Returns true if the value is null."
};

const JSON_ARRAY = {
  arrayLength: "Returns the number of elements in the array.",
  arrayGetInt: ["index", "Reads the int element at index."],
  arrayGetLong: ["index", "Reads the long element at index."],
  arrayGetByte: ["index", "Reads the byte element at index."],
  arrayGetDouble: ["index", "Reads the double element at index."],
  arrayGetBool: ["index", "Reads the bool element at index."],
  arrayGetString: ["index", "Reads the string element at index."],
  arrayGetObject: ["index", "Reads the object element at index."],
  arrayGetArray: ["index", "Reads the array element at index."]
};

const DOCS = {
  namespace: {
    os: {
      _: "Operating system, hardware and process information.",
      cpuCount: "Number of logical CPU cores.",
      cpuArch: "CPU architecture name.",
      cpuModel: "CPU model name.",
      cpuSpeed: "CPU clock speed.",
      totalMemory: "Total system memory in bytes.",
      freeMemory: "Free system memory in bytes.",
      usedMemory: "Used system memory in bytes.",
      processMemory: "Memory used by the current process in bytes.",
      osName: "Operating system name.",
      osVersion: "Operating system version.",
      username: "Name of the current user.",
      hostname: "Host name of the machine.",
      uptime: "System uptime in seconds.",
      battery: "Battery status as a string.",
      exit: ["code", "Terminates the program with the given exit code."],
      pid: "ID of the current process.",
      parentPid: "ID of the parent process.",
      platform: "Platform identifier string.",
      isWindows: "Returns true when running on Windows.",
      isLinux: "Returns true when running on Linux.",
      isMac: "Returns true when running on macOS.",
      isAndroid: "Returns true when running on Android.",
      homeDir: "Home directory path of the current user."
    },

    httpServer: {
      _: "HTTP server creation.",
      create: ["port", "Creates an HTTP server for the given port. Use listen() and next() on the result."]
    },

    threads: {
      _: "Thread control and inspection.",
      waitAll: "Blocks until all threads have finished.",
      count: "Number of running threads.",
      currentId: "ID of the calling thread."
    },

    debug: {
      _: "Debugging helpers.",
      pretty: ["value", "Formats a List, Map or struct as readable text."]
    },

    crypto: {
      _: "Hashing, HMAC, random bytes and base64 encoding.",
      sha256: ["text", "Computes the SHA-256 hash of a string as bytes."],
      sha512: ["text", "Computes the SHA-512 hash of a string as bytes."],
      hmacSha256: "Computes an HMAC-SHA256 from a key and a message, as bytes.",
      hmacSha512: "Computes an HMAC-SHA512 from a key and a message, as bytes.",
      randomBytes: ["count", "Generates count cryptographically secure random bytes."],
      randomInt: ["min max", "Returns a cryptographically secure random int between min and max."],
      base64Encode: ["bytes", "Encodes bytes as a base64 string."],
      base64Decode: ["text", "Decodes a base64 string into bytes."],
      base64UrlEncode: ["bytes", "Encodes bytes as a URL-safe base64 string."],
      base64UrlDecode: ["text", "Decodes a URL-safe base64 string into bytes."]
    },

    fs: {
      _: "File and directory operations.",
      cwd: "Returns the current working directory.",
      readFile: ["path", "Reads a whole file as a string."],
      writeFile: ["path content", "Writes a string to a file, replacing its content. Returns an int status."],
      readFileBytes: ["path", "Reads a whole file as bytes."],
      writeFileBytes: ["path bytes", "Writes bytes to a file, replacing its content."],
      exists: ["path", "Returns true if the path exists."],
      deleteFile: ["path", "Deletes a file. Returns an int status."],
      makeDir: ["path", "Creates a directory. Returns an int status."],
      appendFile: ["path content", "Appends a string to the end of a file. Returns an int status."],
      changeDir: ["path", "Changes the current working directory. Returns an int status."],
      renameFile: ["oldPath newPath", "Renames or moves a file. Returns an int status."]
    },

    sys: {
      _: "Shell commands, environment, terminal and clipboard access.",
      exec: ["command", "Runs a shell command. Returns an int status."],
      panic: ["message", "Prints an error message and terminates the program."],
      getEnv: ["name", "Returns the value of an environment variable."],
      color: ["color", "Sets the terminal text color."],
      performance: "Returns a high-resolution timer value for benchmarking.",
      argv: "Returns the command-line arguments as a List.",
      setEnv: ["name value", "Sets an environment variable."],
      hasEnv: ["name", "Returns true if the environment variable exists."],
      execOutput: ["command", "Runs a shell command and returns its output."],
      key: "Reads a single key press from the terminal.",
      clipboard_get: "Returns the text in the clipboard.",
      clipboard_set: ["text", "Copies text to the clipboard."],
      clipboard_clear: "Clears the clipboard.",
      clipboard_hasText: "Returns true if the clipboard contains text."
    },

    time: {
      _: "Time, date, sleeping and formatting.",
      sleep: ["ms", "Pauses execution for the given number of milliseconds."],
      time: "Returns the current time as a string.",
      millis: "Returns the current time in milliseconds.",
      date: "Returns the current day of the month.",
      month: "Returns the current month.",
      day: "Returns the current day of the week.",
      year: "Returns the current year.",
      now: "Returns the current timestamp.",
      format: ["timestamp", "Formats a timestamp as a readable string."]
    },

    net: {
      _: "Networking: connectivity check and raw TCP.",
      online: "Returns true if an internet connection is available.",
      connect: ["host port", "Opens a TCP connection to host:port."],
      listen: ["port", "Starts a TCP server on the given port."]
    },

    http: {
      _: "HTTP client requests and URL encoding.",
      get: ["url", "Sends a GET request and returns the response body."],
      post: ["url body", "Sends a POST request and returns the response body."],
      put: ["url body", "Sends a PUT request and returns the response body."],
      patch: ["url body", "Sends a PATCH request and returns the response body."],
      delete: ["url", "Sends a DELETE request and returns the response body."],
      urlEncode: ["text", "Percent-encodes a string for use in a URL."],
      urlDecode: ["text", "Decodes a percent-encoded string."],
      setHeader: ["name value", "Sets a header sent with following requests."],
      clearHeaders: "Removes all headers set with setHeader.",
      lastStatus: "Returns the status code of the last request."
    },

    ffi: {
      _: "Direct bindings to C standard library functions.",
      printf: ["format", "C printf. Prints formatted output to stdout."],
      puts: ["text", "Writes a string and a newline to stdout."],
      putchar: ["ch", "Writes one character (by code) to stdout."],
      getchar: "Reads one character from stdin as an int.",
      strlen: ["text", "Returns the length of a string."],
      strcmp: ["a b", "Compares two strings. Returns <0, 0 or >0."],
      strncmp: ["a b n", "Compares at most n characters of two strings."],
      pow: ["base exp", "Returns base raised to the power exp."],
      sqrt: ["x", "Returns the square root of x."],
      fabs: ["x", "Returns the absolute value of a double."],
      floor: ["x", "Rounds x down to a whole number."],
      ceil: ["x", "Rounds x up to a whole number."],
      round: ["x", "Rounds x to the nearest whole number."],
      sin: ["x", "Sine of x in radians."],
      cos: ["x", "Cosine of x in radians."],
      tan: ["x", "Tangent of x in radians."],
      log: ["x", "Natural logarithm of x."],
      exp: ["x", "Returns e raised to the power x."],
      system: ["command", "Runs a shell command. Returns its status."],
      abort: "Terminates the program abnormally.",
      clock: "Returns the processor time used by the program.",
      rand: "Returns a pseudo-random int.",
      srand: ["seed", "Seeds the rand() generator."],
      abs: ["n", "Returns the absolute value of an int."],
      atoi: ["text", "Parses an int from a string."],
      atof: ["text", "Parses a double from a string."],
      toupper: ["ch", "Converts a character code to upper case."],
      tolower: ["ch", "Converts a character code to lower case."],
      isalpha: ["ch", "Non-zero if the character is a letter."],
      isdigit: ["ch", "Non-zero if the character is a digit."],
      isspace: ["ch", "Non-zero if the character is whitespace."],
      fmod: ["x y", "Floating-point remainder of x divided by y."],
      log10: ["x", "Base-10 logarithm of x."],
      log2: ["x", "Base-2 logarithm of x."],
      atan: ["x", "Arc tangent of x in radians."],
      asin: ["x", "Arc sine of x in radians."],
      acos: ["x", "Arc cosine of x in radians."],
      atan2: ["y x", "Arc tangent of y / x using the signs to pick the quadrant."],
      sinh: ["x", "Hyperbolic sine of x."],
      cosh: ["x", "Hyperbolic cosine of x."],
      tanh: ["x", "Hyperbolic tangent of x."],
      trunc: ["x", "Rounds x toward zero."],
      cbrt: ["x", "Cube root of x."],
      isupper: ["ch", "Non-zero if the character is upper case."],
      islower: ["ch", "Non-zero if the character is lower case."],
      isalnum: ["ch", "Non-zero if the character is a letter or digit."],
      ispunct: ["ch", "Non-zero if the character is punctuation."],
      isxdigit: ["ch", "Non-zero if the character is a hex digit."]
    },

    path: {
      _: "File path manipulation.",
      basename: ["path", "Returns the last component of a path."],
      dirname: ["path", "Returns the directory part of a path."],
      extname: ["path", "Returns the file extension of a path."],
      join: ["a b", "Joins two path segments."],
      normalize: ["path", "Resolves '.', '..' and duplicate separators in a path."]
    }
  },

  struct: {
    Tcp: {
      _: "TCP connection. Comes from net.connect() or TcpServer.accept().",
      send: ["data", "Sends bytes. Returns the number of bytes sent."],
      receive: ["size", "Receives up to size bytes."],
      close: "Closes the connection.",
      isOpen: "Returns true while the connection is open."
    },

    TcpServer: {
      _: "TCP server. Created with net.listen().",
      accept: "Waits for a client and returns its Tcp connection.",
      close: "Stops the server.",
      isOpen: "Returns true while the server is open."
    },

    Json: {
      _: "Parsed JSON document. Call Json.parse() before using any other method.",
      ...JSON_GET,
      ...JSON_ARRAY,
      map: "Converts the JSON object into a Map.",
      parse: ["text", "Parses a JSON string. Must be called before other Json methods."],
      free: "Releases the parsed JSON.",
      getRootArray: "Returns the root value as a JsonArray.",
      getRootObject: "Returns the root value as a JsonObject."
    },

    JsonObject: {
      _: "JSON object. Comes from Json.getObject() or Json.getRootObject().",
      ...JSON_GET
    },

    JsonArray: {
      _: "JSON array. Comes from Json.getArray() or Json.getRootArray().",
      ...JSON_ARRAY
    },

    HttpServer: {
      _: "HTTP server. Created with httpServer.create().",
      listen: "Starts listening for connections. Returns an int status.",
      next: "Waits for the next request and returns it.",
      close: "Stops the server."
    },

    HttpRequest: {
      _: "Incoming HTTP request with helpers to send the response.",
      sendFile: ["path contentType", "Sends a file as the response with the given content type."],
      send: ["body", "Sends a text response."],
      status: ["code", "Sets the response status code."],
      method: "HTTP method of the request.",
      path: "Path of the request.",
      body: "Body of the request.",
      json: ["data", "Sends a JSON response."],
      css: ["data", "Sends a CSS response."],
      html: ["data", "Sends an HTML response."],
      redirect: ["url", "Redirects the client to url."],
      setHeader: ["name value", "Sets a response header."],
      getHeader: ["name", "Returns the value of a request header."]
    },

    Ptr: {
      _: "Raw memory pointer for low-level access.",
      storeInt: ["value", "Writes an int at the pointer."],
      loadInt: "Reads an int at the pointer.",
      storeDouble: ["value", "Writes a double at the pointer."],
      loadDouble: "Reads a double at the pointer.",
      storeBool: ["value", "Writes a bool at the pointer."],
      loadBool: "Reads a bool at the pointer.",
      loadLong: "Reads a long at the pointer.",
      loadByte: "Reads a byte at the pointer.",
      storeLong: ["value", "Writes a long at the pointer."],
      storeByte: ["value", "Writes a byte at the pointer."],
      storeString: ["value", "Writes a string pointer at the pointer."],
      loadString: "Reads a string pointer at the pointer.",
      storePtr: ["value", "Writes a Ptr at the pointer."],
      loadPtr: "Reads a Ptr at the pointer.",
      isNull: "Returns true if the pointer is null.",
      offset: ["bytes", "Returns a new pointer moved forward by bytes."],
      copyFrom: ["source size", "Copies size bytes from source into this pointer."],
      copyTo: ["target size", "Copies size bytes from this pointer into target."],
      fill: ["value size", "Fills size bytes with value."],
      free: "Frees the memory."
    },

    Map: {
      _: "Key/value map with typed getters and setters.",
      keys: "Returns all keys.",
      entries: "Returns all key/value pairs as string pairs.",
      getInt: ["key", "Reads the int stored under key."],
      getLong: ["key", "Reads the long stored under key."],
      getByte: ["key", "Reads the byte stored under key."],
      getBool: ["key", "Reads the bool stored under key."],
      getDouble: ["key", "Reads the double stored under key."],
      getString: ["key", "Reads the string stored under key."],
      getMap: ["key", "Reads the Map stored under key."],
      json: "Serializes the map as a JSON string.",
      getList: ["key", "Reads the List stored under key."],
      setInt: ["key value", "Stores an int under key."],
      setBool: ["key value", "Stores a bool under key."],
      setLong: ["key value", "Stores a long under key."],
      setByte: ["key value", "Stores a byte under key."],
      setDouble: ["key value", "Stores a double under key."],
      setString: ["key value", "Stores a string under key."],
      setMap: ["key value", "Stores a Map under key."],
      setList: ["key value", "Stores a List under key."],
      has: ["key", "Returns true if key exists."],
      remove: ["key", "Removes key and its value."],
      free: "Frees the map."
    }
  },

  global: {
    // core builtins
    screen: ["value format", "Prints a value to the screen. The optional format string controls how the value is formatted."],
    input: "Reads a line from standard input.",
    type: ["value", "Returns the type name of a value."],
    Int: ["value", "Converts a value to int."],
    Long: ["value", "Converts a value to long."],
    Double: ["value", "Converts a value to double."],
    Bool: ["value", "Converts a value to bool."],
    String: ["value", "Converts a value to string."],
    toString: ["value", "Converts a value to its string form."],
    toInt: ["value", "Converts a value to int."],
    length: ["value", "Returns the length of a string or List."],
    sizeOf: ["value", "Returns the size in bytes of a value or type."],
    Byte: ["value", "Converts a value to byte."],
    stringToBytes: ["text", "Converts a string to List<byte>."],
    bytesToString: ["bytes", "Converts List<byte> to a string."],

    // basic
    isEven: ["n", "Returns true if n is even."],
    isOdd: ["n", "Returns true if n is odd."],
    isPositive: ["n", "Returns true if n is greater than zero."],
    isNegative: ["n", "Returns true if n is less than zero."],
    abs: ["n", "Returns the absolute value of n."],
    max: ["a b", "Returns the larger of a and b."],
    min: ["a b", "Returns the smaller of a and b."],
    clamp: ["value min max", "Limits value to the range min..max."],
    sign: ["n", "Returns -1, 0 or 1 depending on the sign of n."],

    // math
    pow: ["base exp", "Returns base raised to the power exp."],
    sqrt: ["n", "Returns the square root of n as an int."],
    square: ["n", "Returns n multiplied by itself."],
    cube: ["n", "Returns n multiplied by itself twice."],

    // rounding
    floor: ["x", "Rounds x down to an int."],
    ceil: ["x", "Rounds x up to an int."],
    round: ["x", "Rounds x to the nearest int."],
    toFixed: ["value places", "Rounds value to the given number of decimal places."],
    mod: ["a b", "Returns the remainder of a divided by b."],

    // number theory
    gcd: ["a b", "Returns the greatest common divisor of a and b."],
    lcm: ["a b", "Returns the least common multiple of a and b."],
    factorial: ["n", "Returns n! as a double."],
    isPrime: ["n", "Returns true if n is a prime number."],

    // interpolation
    lerp: ["a b t", "Linear interpolation from a to b by factor t."],
    normalize: ["value min max", "Scales value from the range min..max into 0..1."],

    // utility
    between: ["value min max", "Returns true if value lies within min..max."],

    // string
    reverse: ["text", "Returns text reversed."],
    indexOf: ["text search", "Returns the index of the first occurrence of search in text."],
    slice: ["text start end", "Returns the part of text from start to end."],
    charAt: ["text index", "Returns the character at index."],
    replace: ["text search replacement", "Replaces the first occurrence of search in text."],
    replaceAll: ["text search replacement", "Replaces every occurrence of search in text."],
    contains: ["text search", "Returns true if text contains search."],
    upperCase: ["text", "Converts text to upper case."],
    lowerCase: ["text", "Converts text to lower case."],
    startsWith: ["text prefix", "Returns true if text starts with prefix."],
    endsWith: ["text suffix", "Returns true if text ends with suffix."],
    trim: ["text", "Removes whitespace from both ends of text."],
    splitAt: ["text sep index", "Splits text by sep and returns the part at index."],
    split: ["text sep", "Splits text by sep."],
    repeat: ["text count", "Repeats text count times."],
    count: ["text search", "Counts the occurrences of search in text."],
    padStart: ["text width fill", "Pads the start of text with fill up to width."],
    padEnd: ["text width fill", "Pads the end of text with fill up to width."],
    padCenter: ["text width fill", "Pads both sides of text with fill up to width."],
    capitalize: ["text", "Upper-cases the first character of text."],
    extName: ["path", "Returns the file extension of a path."],

    // trig / exp
    sin: ["x", "Sine of x in radians."],
    cos: ["x", "Cosine of x in radians."],
    tan: ["x", "Tangent of x in radians."],
    log: ["x", "Natural logarithm of x."],
    exp: ["x", "Returns e raised to the power x."],

    // random / misc
    randomInt: ["min max", "Returns a random int between min and max."],
    random: "Returns a random double.",
    match: ["text pattern", "Returns true if text matches pattern."],
    json: "JSON string helper. Takes two strings and returns a string."
  },

  constant: {
    PI: "Ratio of a circle's circumference to its diameter (3.14159265358979).",
    TAU: "Full circle in radians, 2 * PI (6.28318530717959).",
    E: "Euler's number (2.71828182845905).",
    PHI: "The golden ratio (1.61803398874989).",
    SQRT2: "Square root of 2 (1.4142135623731).",
    LN2: "Natural logarithm of 2 (0.693147180559945).",
    LN10: "Natural logarithm of 10 (2.30258509299405).",
    SEED: "Global seed for random number generation. Can be changed.",
    I32_MAX: "Largest int value (2147483647).",
    I32_MIN: "Smallest int value (-2147483648).",
    F64_MAX: "Largest finite double value.",
    F64_MIN: "Minimum double limit.",
    F64_EPS: "Smallest difference between 1.0 and the next double.",
    INF: "Positive infinity.",
    NEG_INF: "Negative infinity.",
    NAN: "Not a number."
  }
};


export class Info {
  constructor(args = []) {
    this.args = args;
  }

  async run() {
    switch (this.args[1]) {
      case "namespace":
        this.showNamespace();
        break;

      case "global":
        this.showGlobal();
        break;

      default:
        this.help();
        break;
    }
  }


  // namespace

  showNamespace() {
    const name = this.args[2];

    if (!name || name.startsWith("--")) {
      this.error(
        `Missing namespace name. Available: ${Object.keys(NAMESPACE_REG).join(", ")}`
      );
      return;
    }

    if (!has(NAMESPACE_REG, name)) {
      this.error(
        `Unknown namespace: ${name}. Available: ${Object.keys(NAMESPACE_REG).join(", ")}`
      );
      return;
    }

    const registry = NAMESPACE_REG[name];
    const member = this.member();

    if (member) {
      this.showNamespaceMember(name, registry, member);
      return;
    }

    console.log("");
    console.log(`Namespace: ${name}`);
    console.log(LINE);

    const description = DOCS.namespace[name]?._;

    if (description) {
      console.log(this.wrap(description));
    }

    console.log("");

    for (const [key, value] of Object.entries(registry)) {
      this.printListItem(this.namespaceCallable(name, key, value));
    }

    console.log("");
  }


  showNamespaceMember(namespaceName, registry, memberName) {
    const key = this.findKey(namespaceName, registry, memberName);

    if (!key) {
      this.error(
        `Unknown method '${memberName}' in namespace '${namespaceName}'.`
      );
      return;
    }

    const callable = this.namespaceCallable(
      namespaceName,
      key,
      registry[key]
    );

    this.detail(
      [`Namespace: ${namespaceName}`, `Method: ${callable.name}`],
      callable,
      `${namespaceName}.`
    );
  }


  findKey(namespaceName, registry, memberName) {
    const lower = memberName.toLowerCase();
    let fallback = null;

    for (const key of Object.keys(registry)) {
      const name = this.memberName(namespaceName, key);

      if (name === memberName) {
        return key;
      }

      if (!fallback && name.toLowerCase() === lower) {
        fallback = key;
      }
    }

    return fallback;
  }


  memberName(namespaceName, key) {
    const prefix = `_${namespaceName}_`;

    return key.startsWith(prefix)
      ? key.slice(prefix.length)
      : key.replace(/^_/, "");
  }


  namespaceCallable(namespaceName, key, value) {
    const name = this.memberName(namespaceName, key);
    const [, returnType, paramCount, types] = value;
    const doc = this.doc(DOCS.namespace[namespaceName]?.[name]);

    return this.callable({
      name,
      ret: RETURN_ALIAS[`${namespaceName}.${name}`] ?? returnType,
      types: (types ?? []).map(type =>
        String(type).includes(",") ? "any" : type
      ),
      names: doc.names,
      desc: doc.text,
      variadic: paramCount === "INF"
    });
  }


  // Global

  showGlobal() {
    const name = this.args[2];

    if (!name || name.startsWith("--")) {
      this.error("Missing global name.");
      return;
    }

    const member = this.member();

    if (has(BUILTIN_STRUCT_METHODS, name) || has(BUILTIN_STRUCT_PROPS, name)) {
      if (member) {
        this.showStructMember(name, member);
      } else {
        this.showStruct(name);
      }
      return;
    }

    if (member) {
      this.error(`Unknown struct: ${name}`);
      return;
    }

    if (has(GLOBAL_EXTERNAL, name)) {
      this.showConstant(name);
      return;
    }

    if (has(STD_FUNCTIONS_SCHEMA, name)) {
      this.showFunction("Standard function", this.stdCallable(name));
      return;
    }

    if (has(CORE_PARAMS, name) && has(BUILTIN_MAP, name)) {
      this.showFunction("Built-in function", this.coreCallable(name));
      return;
    }

    this.error(`Unknown global: ${name}`, this.suggest(name));
  }


  stdCallable(name) {
    const fn = STD_FUNCTIONS_SCHEMA[name];
    const doc = this.doc(DOCS.global[name]);

    return this.callable({
      name,
      ret: fn.ret ?? "unknown",
      types: fn.params ?? [],
      names: doc.names,
      desc: doc.text
    });
  }


  coreCallable(name) {
    const doc = this.doc(DOCS.global[name]);

    return this.callable({
      name,
      ret: BUILTIN_MAP[name].returnType ?? "unknown",
      types: CORE_PARAMS[name],
      names: doc.names,
      desc: doc.text
    });
  }


  showFunction(label, callable) {
    const extra = [];
    const others = this.namespaceMatches(callable.name);

    if (others.length > 0) {
      extra.push(`Also in: ${others.join(", ")}`);
    }

    this.detail([`${label}: ${callable.name}`], callable, "", extra);
  }


  namespaceMatches(name) {
    const matches = [];

    for (const [namespaceName, registry] of Object.entries(NAMESPACE_REG)) {
      for (const key of Object.keys(registry)) {
        if (this.memberName(namespaceName, key) === name) {
          matches.push(`${namespaceName}.${name}`);
        }
      }
    }

    return matches;
  }


  showConstant(name) {
    const constant = GLOBAL_EXTERNAL[name];

    console.log("");
    console.log(`Global constant: ${name}`);
    console.log(LINE);

    if (DOCS.constant[name]) {
      console.log(this.wrap(DOCS.constant[name]));
      console.log("");
    }

    console.log(`Type: ${this.zen(constant.type ?? "unknown")}`);
    console.log(`Mutable: ${constant.mutable ?? false}`);
    console.log("");
  }


  suggest(name) {
    const lower = name.toLowerCase();
    const hits = [];

    const globals = [
      ...Object.keys(GLOBAL_EXTERNAL),
      ...Object.keys(BUILTIN_STRUCT_METHODS),
      ...Object.keys(STD_FUNCTIONS_SCHEMA),
      ...Object.keys(CORE_PARAMS)
    ];

    for (const global of globals) {
      if (global.toLowerCase() === lower) {
        hits.push(`zen info global ${global}`);
      }
    }

    for (const [namespaceName, registry] of Object.entries(NAMESPACE_REG)) {
      for (const key of Object.keys(registry)) {
        const member = this.memberName(namespaceName, key);

        if (member.toLowerCase() === lower) {
          hits.push(`zen info namespace ${namespaceName} --${member}`);
        }
      }
    }

    return hits;
  }

  // Struct

  showStruct(structName) {
    const methods = BUILTIN_STRUCT_METHODS[structName] ?? {};
    const properties = BUILTIN_STRUCT_PROPS[structName] ?? {};
    const description = DOCS.struct[structName]?._;

    console.log("");
    console.log(`Struct: ${structName}`);
    console.log(LINE);

    if (description) {
      console.log(this.wrap(description));
    }

    const methodEntries = Object.entries(methods);

    if (methodEntries.length > 0) {
      console.log("");
      console.log("Methods:");

      for (const [name, method] of methodEntries) {
        this.printListItem(this.structCallable(structName, name, method));
      }
    }

    const propertyEntries = Object.entries(properties);

    if (propertyEntries.length > 0) {
      console.log("");
      console.log("Properties:");

      for (const [name, property] of propertyEntries) {
        console.log(`  ${name} -> ${property.returnType ?? "unknown"}`);

        const doc = this.doc(DOCS.struct[structName]?.[name]);

        if (doc.text) {
          console.log(this.wrap(doc.text, 6));
        }
      }
    }

    console.log("");
  }


  showStructMember(structName, memberName) {
    const methods = BUILTIN_STRUCT_METHODS[structName] ?? {};
    const properties = BUILTIN_STRUCT_PROPS[structName] ?? {};

    if (has(methods, memberName)) {
      const callable = this.structCallable(
        structName,
        memberName,
        methods[memberName]
      );

      const extra = callable.static
        ? ["Static: yes (called without an instance)"]
        : [];

      this.detail(
        [`Struct: ${structName}`, `Method: ${memberName}`],
        callable,
        `${structName}.`,
        extra
      );
      return;
    }

    if (has(properties, memberName)) {
      const doc = this.doc(DOCS.struct[structName]?.[memberName]);

      console.log("");
      console.log(`Struct: ${structName}`);
      console.log(`Property: ${memberName}`);
      console.log(LINE);

      if (doc.text) {
        console.log(this.wrap(doc.text));
        console.log("");
      }

      console.log(`Type: ${properties[memberName].returnType ?? "unknown"}`);
      console.log("");
      return;
    }

    this.error(`Unknown method '${memberName}' in struct '${structName}'.`);
  }


  structCallable(structName, name, method) {
    const doc = this.doc(DOCS.struct[structName]?.[name]);
    let returnType = method.returnType ?? method.ret ?? "unknown";

    if (method.generic && returnType === "List") {
      returnType = "List<T>";
    }

    return this.callable({
      name,
      ret: returnType,
      types: method.args ?? method.params ?? [],
      names: doc.names,
      desc: doc.text,
      extra: { static: method.hasReceiver === false }
    });
  }

  // Helpers

  callable({ name, ret, types, names = [], desc = "", variadic = false, extra = {} }) {
    return {
      name,
      ret: this.zen(ret),
      desc,
      variadic,
      params: types.map((type, index) => {
        const optional = String(type).endsWith("?");
        const clean = optional ? String(type).slice(0, -1) : type;

        return {
          type: this.zen(clean),
          name: names[index],
          optional
        };
      }),
      ...extra
    };
  }


  doc(entry) {
    if (Array.isArray(entry)) {
      return {
        names: entry[0].split(/[\s,]+/).filter(Boolean),
        text: entry[1] ?? ""
      };
    }

    return { names: [], text: entry ?? "" };
  }


  zen(type) {
    return has(ZEN_TYPES_MAP, type) ? ZEN_TYPES_MAP[type] : type;
  }


  member() {
    const option = this.args.find(
      (arg, index) => index > 1 && arg.startsWith("--")
    );

    const raw = option ?? this.args[3];

    return raw ? raw.replace(/^--/, "") : null;
  }


  signature(callable, prefix = "") {
    const params = callable.params.map(param => {
      const name = param.name ? ` ${param.name}` : "";

      return param.optional
        ? `${param.type}${name}?`
        : `${param.type}${name}`;
    });

    if (callable.variadic) {
      params.push("...");
    }

    return `${prefix}${callable.name}(${params.join(", ")}) -> ${callable.ret}`;
  }


  printListItem(callable) {
    console.log(`  ${this.signature(callable)}`);

    if (callable.desc) {
      console.log(this.wrap(callable.desc, 6));
    }
  }


  detail(header, callable, prefix = "", extra = []) {
    console.log("");

    for (const line of header) {
      console.log(line);
    }

    console.log(LINE);

    if (callable.desc) {
      console.log(this.wrap(callable.desc));
      console.log("");
    }

    console.log(`Signature: ${this.signature(callable, prefix)}`);
    console.log(`Return type: ${callable.ret}`);

    if (callable.params.length === 0 && !callable.variadic) {
      console.log("Parameters: None");
    } else {
      console.log("Parameters:");

      callable.params.forEach((param, index) => {
        const name = param.name ?? `arg${index + 1}`;
        const optional = param.optional ? " (optional)" : "";

        console.log(`  ${name}: ${param.type}${optional}`);
      });

      if (callable.variadic) {
        console.log("  ...: any number of extra arguments");
      }
    }

    for (const line of extra) {
      console.log(line);
    }

    console.log("");
  }


  wrap(text, indent = 0) {
    const width = Math.max(
      20,
      Math.min(process.stdout.columns || 60, 80) - indent
    );

    const lines = [];
    let line = "";

    for (const word of text.split(" ")) {
      if (line && line.length + 1 + word.length > width) {
        lines.push(line);
        line = word;
      } else {
        line = line ? `${line} ${word}` : word;
      }
    }

    if (line) {
      lines.push(line);
    }

    const pad = " ".repeat(indent);

    return lines.map(item => pad + item).join("\n");
  }


  help() {
    console.log("");
    console.log("Zen Info");
    console.log(LINE);
    console.log("Usage:");
    console.log("  zen info namespace <name>");
    console.log("  zen info namespace <name> --<method>");
    console.log("  zen info global <name>");
    console.log("  zen info global <struct> --<method>");
    console.log("");
    console.log("Examples:");
    console.log("  zen info namespace os");
    console.log("  zen info namespace os --cpuCount");
    console.log("  zen info global screen");
    console.log("  zen info global Tcp");
    console.log("  zen info global Tcp --send");
    console.log("");
    console.log(`Namespaces: ${Object.keys(NAMESPACE_REG).join(", ")}`);
    console.log(`Structs: ${Object.keys(BUILTIN_STRUCT_METHODS).join(", ")}`);
    console.log("");
  }


  error(message, hints = []) {
    console.error(`[Zen Info Error] ${message}`);

    if (hints.length > 0) {
      console.log("");
      console.log("Did you mean:");

      for (const hint of hints) {
        console.log(`  ${hint}`);
      }
    }

    console.log("");
    console.log("Run 'zen info' to see usage.");
  }
}
