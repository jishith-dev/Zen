import {
  BUILTIN_INFO,
  getNamespace,
  getGlobalFn,
  getStruct,
  getConstant,
  formatSignature,
} from "../../src/config/info_config.js";

const useColor =
  !process.env.NO_COLOR && (process.stdout.isTTY || process.env.FORCE_COLOR);

const paint = (code) => (text) =>
  useColor ? `\x1b[${code}m${text}\x1b[0m` : String(text);

const c = {
  bold: paint("1"),
  dim: paint("2"),
  red: paint("31"),
  green: paint("32"),
  yellow: paint("33"),
  blue: paint("34"),
  magenta: paint("35"),
  cyan: paint("36"),
  white: paint("97"),
};

const LINE = c.dim("─".repeat(50));

const { namespaces, global_fn, structs, constants } = BUILTIN_INFO;

const has = (obj, key) => Object.prototype.hasOwnProperty.call(obj, key);

// exact match first, then case-insensitive
function lookup(obj, name) {
  if (has(obj, name)) return name;
  const lower = name.toLowerCase();
  return Object.keys(obj).find((key) => key.toLowerCase() === lower) ?? null;
}

function colorSig(sig) {
  const m = sig.match(/^([^(]*)\((.*)\) -> (.*)$/);

  if (!m) return sig;

  return `${c.green(m[1])}(${c.yellow(m[2])}) -> ${c.magenta(m[3])}`;
}

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
    }
  }

  // namespace 

  showNamespace() {
    const name = this.args[2];
    const available = Object.keys(namespaces).join(", ");

    if (!name || name.startsWith("--")) {
      return this.error(`Missing namespace name. Available: ${available}`);
    }

    const ns = getNamespace(name);

    if (!ns) {
      return this.error(`Unknown namespace: ${name}. Available: ${available}`);
    }

    const member = this.member();

    if (member) {
      const key = lookup(ns.functions, member);

      if (!key) {
        return this.error(`Unknown method '${member}' in namespace '${name}'.`);
      }

      return this.detail(
        [`Namespace: ${name}`, `Method: ${key}`],
        key,
        ns.functions[key],
        `${name}.`
      );
    }

    this.head([`Namespace: ${name}`]);

    if (ns.description) console.log(this.wrap(ns.description));
    console.log("");

    for (const [key, fn] of Object.entries(ns.functions)) {
      this.listItem(key, fn);
    }

    console.log("");
  }

  // global

  showGlobal() {
    const name = this.args[2];

    if (!name || name.startsWith("--")) {
      return this.error("Missing global name.");
    }

    const member = this.member();
    const struct = getStruct(name);

    if (struct) {
      return member
        ? this.showStructMember(name, struct, member)
        : this.showStruct(name, struct);
    }

    if (member) return this.error(`Unknown struct: ${name}`);

    const constant = getConstant(name);
    if (constant) return this.showConstant(name, constant);

    const fn = getGlobalFn(name);
    if (fn) {
      const label = fn.origin === "stdlib" ? "Standard function" : "Built-in function";
      return this.showFunction(label, name, fn);
    }

    this.error(`Unknown global: ${name}`, this.suggest(name));
  }

  showFunction(label, name, fn) {
    const extra = [];
    const others = this.namespaceMatches(name);

    if (others.length > 0) {
      extra.push(`${c.dim("Also in:")} ${c.blue(others.join(", "))}`);
    }

    this.detail([`${label}: ${name}`], name, fn, "", extra);
  }

  showConstant(name, constant) {
    this.head([`Global constant: ${name}`]);

    if (constant.description) {
      console.log(this.wrap(constant.description));
      console.log("");
    }

    console.log(`${c.white("Type:")} ${c.yellow(constant.type)}`);
    console.log(`${c.white("Mutable:")} ${c.magenta(constant.mutable)}`);
    console.log("");
  }

  // struct

  showStruct(name, struct) {
    this.head([`Struct: ${name}`]);

    if (struct.description) console.log(this.wrap(struct.description));

    const methods = Object.entries(struct.methods ?? {});
    const props = Object.entries(struct.properties ?? {});

    if (methods.length > 0) {
      console.log("");
      console.log(c.bold("Methods:"));
      for (const [key, fn] of methods) this.listItem(key, fn);
    }

    if (props.length > 0) {
      console.log("");
      console.log(c.bold("Properties:"));

      for (const [key, prop] of props) {
        console.log(`  ${c.green(key)} -> ${c.yellow(prop.type)}`);
        if (prop.description) console.log(this.wrap(prop.description, 6));
      }
    }

    console.log("");
  }

  showStructMember(structName, struct, memberName) {
    const methodKey = lookup(struct.methods ?? {}, memberName);

    if (methodKey) {
      const fn = struct.methods[methodKey];
      const extra = fn.static
        ? [c.blue("Static: yes (called without an instance)")]
        : [];

      return this.detail(
        [`Struct: ${structName}`, `Method: ${methodKey}`],
        methodKey,
        fn,
        `${structName}.`,
        extra
      );
    }

    const propKey = lookup(struct.properties ?? {}, memberName);

    if (propKey) {
      const prop = struct.properties[propKey];

      this.head([`Struct: ${structName}`, `Property: ${propKey}`]);

      if (prop.description) {
        console.log(this.wrap(prop.description));
        console.log("");
      }

      console.log(`${c.white("Type:")} ${c.yellow(prop.type)}`);
      console.log("");
      return;
    }

    this.error(`Unknown method '${memberName}' in struct '${structName}'.`);
  }

  // lookups 

  namespaceMatches(name) {
    return Object.entries(namespaces)
      .filter(([, ns]) => has(ns.functions, name))
      .map(([nsName]) => `${nsName}.${name}`);
  }

  suggest(name) {
    const lower = name.toLowerCase();
    const hits = [];

    for (const group of [constants, structs, global_fn]) {
      for (const key of Object.keys(group)) {
        if (key.toLowerCase() === lower) hits.push(`zen info global ${key}`);
      }
    }

    for (const [nsName, ns] of Object.entries(namespaces)) {
      for (const key of Object.keys(ns.functions)) {
        if (key.toLowerCase() === lower) {
          hits.push(`zen info namespace ${nsName} --${key}`);
        }
      }
    }

    return hits;
  }

  // printing helpers 

  member() {
    const option = this.args.find((arg, i) => i > 1 && arg.startsWith("--"));
    const raw = option ?? this.args[3];

    return raw ? raw.replace(/^--/, "") : null;
  }

  head(lines) {
    console.log("");
    for (const line of lines) console.log(c.bold(line));
    console.log(LINE);
  }

  listItem(name, fn) {
    console.log(`  ${colorSig(formatSignature(name, fn))}`);

    if (fn.description) console.log(this.wrap(fn.description, 6));
  }

  detail(header, name, fn, prefix = "", extra = []) {
    this.head(header);

    if (fn.description) {
      console.log(this.wrap(fn.description));
      console.log("");
    }

    console.log(
      `${c.white("Signature:")} ${colorSig(formatSignature(name, fn, prefix))}`
    );
    console.log(`${c.white("Return type:")} ${c.magenta(fn.returnType)}`);

    if (fn.parameters.length === 0 && !fn.variadic) {
      console.log(`${c.white("Parameters:")} None`);
    } else {
      console.log(c.white("Parameters:"));

      for (const p of fn.parameters) {
        const optional = p.optional ? c.dim(" (optional)") : "";

        console.log(`  ${c.green(p.name)}: ${c.yellow(p.type)}${optional}`);
      }

      if (fn.variadic) {
        console.log(`  ${c.green("...")}: ${c.white("any number of extra arguments")}`);
      }
    }

    for (const line of extra) console.log(line);

    console.log("");
  }

  wrap(text, indent = 0, color = c.cyan) {
    const width = Math.max(20, Math.min(process.stdout.columns || 60, 80) - indent);
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

    if (line) lines.push(line);

    const pad = " ".repeat(indent);

    return lines.map((item) => pad + color(item)).join("\n");
  }

  help() {
    const cmd = (text) => console.log(`  ${c.green(text)}`);

    console.log("");
    console.log(c.bold("Zen Info"));
    console.log(LINE);
    console.log(c.bold("Usage:"));
    cmd("zen info namespace <n>");
    cmd("zen info namespace <n> --<method>");
    cmd("zen info global <n>");
    cmd("zen info global <struct> --<method>");
    console.log("");
    console.log(c.bold("Examples:"));
    cmd("zen info namespace os");
    cmd("zen info namespace os --cpuCount");
    cmd("zen info global screen");
    cmd("zen info global Tcp");
    cmd("zen info global Tcp --send");
    console.log("");
    console.log(`${c.bold("Namespaces:")} ${c.cyan(Object.keys(namespaces).join(", "))}`);
    console.log(`${c.bold("Structs:")} ${c.cyan(Object.keys(structs).join(", "))}`);
    console.log("");
  }

  error(message, hints = []) {
    console.error(`${c.red("[Zen Info Error]")} ${message}`);

    if (hints.length > 0) {
      console.log("");
      console.log(c.yellow("Did you mean:"));
      for (const hint of hints) console.log(`  ${c.green(hint)}`);
    }

    console.log("");
    console.log(c.dim("Run 'zen info' to see usage."));
  }
}
