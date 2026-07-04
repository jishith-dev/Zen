#!/usr/bin/env node

import fs from "fs";
import path from "path";
import readline from "readline";
import os from "os";
import { execSync } from "child_process";
import { fileURLToPath, pathToFileURL } from "url";
import { ModuleFiles } from "../src/codegen/lib/moduleFiles.js";

class ZEN {
  constructor() {
    this.source = null;
    this.moduleName = null;
    this.args = process.argv.slice(2);
    this.command = this.args[0];
    this.optFlagFromCommand = this.args[2];
this.isValidOptFlag = ["-O0", "-O1", "-O2", "-O3"].includes(this.optFlagFromCommand);

if (this.optFlagFromCommand && !this.isValidOptFlag) {
  console.error(`error: Unknown optimization level '${this.optFlagFromCommand}'`);
  process.exit(1);
}

this.optFlag = this.isValidOptFlag ? this.optFlagFromCommand : "-O2";
    this.PROJECT_ROOT = null;
    this.moduleFiles = new ModuleFiles();
    this.COMPILER_ROOT = null;
    this.validCommands = new Set([
  "run", "build", "ir", "ast", "tokens", "clean", "init", "list", "whoami",
  "publish", "install", "recovery", "mine", "search", "kind", "uninstall", 
  "signup", "login", "logout", "unpublish",
  "--help", "-h", "help", "--version", "-v", "version", "update"
]);
  }

  setCompilerRoot() {
    const __filename = fileURLToPath(import.meta.url);
    const __dirname = path.dirname(__filename);
    this.COMPILER_ROOT = path.resolve(__dirname, "..");
  }

  isURL(input) {
    return /^https?:\/\//.test(input);
  }

  pathType(input) {
    if (this.isURL(input)) return "remote";
    if (input.endsWith(".zen") && fs.existsSync(input)) return "local";
    if (fs.existsSync(path.join(input, "zen.json"))) return "project";
    return "unknown";
  }

  setProjectRoot(input) {
    const type = this.pathType(input);

    if (type === "local") {
      this.PROJECT_ROOT = path.dirname(path.resolve(input));
    } else if (type === "project") {
      this.PROJECT_ROOT = path.resolve(input);
    } else {
      this.PROJECT_ROOT = process.cwd();
    }
  }

  async fetchRemote(url) {
    try {
      const res = await fetch(url);
      if (!res.ok) {
        throw new Error(`HTTP ${res.status}`);
      }
      return await res.text();
    } catch (err) {
      console.error(`error: Failed to fetch remote: ${err.message}`);
      process.exit(1);
    }
  }

  async setSource(input, IRB) {
    const type = this.pathType(input);

    if (type === "local") {
      try {
        this.source = IRB.safeReadFile(input);
      } catch (err) {
        console.error(`error: Failed to read file: ${err.message}`);
        process.exit(1);
      }
    } else if (type === "project") {
      const configPath = path.join(input, "zen.json");

      try {
        const configText = fs.readFileSync(configPath, "utf8");
        const config = JSON.parse(configText);

        if (!config.main) {
          console.error("error: zen.json missing 'main' entry point");
          process.exit(1);
        }

        const entryPath = path.join(input, config.main);
        if (!fs.existsSync(entryPath)) {
          console.error(`error: Entry point not found: ${config.main}`);
          process.exit(1);
        }

        this.source = IRB.safeReadFile(entryPath);
      } catch (err) {
        if (err instanceof SyntaxError) {
          console.error("error: Invalid zen.json format");
        } else {
          console.error(`error: Failed to read project: ${err.message}`);
        }
        process.exit(1);
      }
    } else if (type === "remote") {
      this.source = await this.fetchRemote(input);
    } else {
      console.error("error: Invalid input - expected .zen file, project dir, or URL");
      process.exit(1);
    }
  }

  extractModuleName(input) {
    if (this.isURL(input)) {
      const urlPath = new URL(input).pathname;
      const base = path.basename(urlPath);
      this.moduleName = base.replace(/\.zen$/, "") || "remote_module";
    } else {
      this.moduleName = path.basename(input, path.extname(input));
    }
  }

  buildDir() {
    try {
      const buildDir = path.join(this.PROJECT_ROOT, "build");
      fs.mkdirSync(buildDir, { recursive: true });
      return buildDir;
    } catch (err) {
      console.error(`error: Failed to create build directory: ${err.message}`);
      process.exit(1);
    }
  }

  run(cmd) {
    try {
      execSync(cmd, { stdio: "inherit" });
    } catch {
      process.exit(1);
    }
  }

  help() {
    console.log(`
Zen Programming Language v1.1.1

Usage:
  zen run <file> [-O0|-O1|-O2|-O3]
  zen build <file> [-O0|-O1|-O2|-O3]
  zen ir <file>
  zen ast <file>
  zen tokens <file>
  zen clean <file>
  zen update

Project:
  zen init <project-name>

Packages:
  zen install <package>
  zen uninstall <package>
  zen search <package>
  zen kind <package>
  zen mine
  zen list
  zen publish
  zen unpublish <package>

Account:
  zen signup
  zen login
  zen logout
  zen whoami
  zen recovery

Other:
  zen --help
  zen --version

Optimization Levels:
  -O0    No optimization
  -O1    Basic optimization
  -O2    Recommended (default)
  -O3    Maximum optimization    
    `);
  }
  
  // auth

async handleSignup() {
  
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  const ask = (q) => new Promise(resolve => rl.question(q, resolve));

  try {
    const username = (await ask("Username: ")).trim();
    const password = await ask("Password: ");
    const confirm = await ask("Confirm Password: ");

    rl.close();

    if (!username || !password) {
      console.error("error: username and password required");
      process.exit(1);
    }

    if (password !== confirm) {
      console.error("error: passwords do not match");
      process.exit(1);
    }

    const res = await fetch(
      "https://zen-registry-production.up.railway.app/api/signup",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          username,
          password: password
        })
      }
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }
    
  console.log("ZEN RECOVERY CODES");

  data.codes.forEach((c, i) => {
    console.log(`${i + 1}. ${c}`);
  });

  console.log("\nSave these codes. They will not be shown again.\n");

   console.log(data.message);
  } catch (err) {
    rl.close();
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleLogin() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  const ask = (q) => new Promise(resolve => rl.question(q, resolve));

  try {
    const username = (await ask("Username: ")).trim();
    const password = await ask("Password: ");

    rl.close();

    const res = await fetch(
      "https://zen-registry-production.up.railway.app/api/login",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          username,
          password: password
        })
      }
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }

    const authDir = path.join(os.homedir(), ".zen");
    fs.mkdirSync(authDir, { recursive: true });

    fs.writeFileSync(
      path.join(authDir, "auth.json"),
      JSON.stringify({
        username,
        token: data.token
      }, null, 2)
    );

    console.log("Logged in successfully.");
  } catch (err) {
    rl.close();
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleList() {
  const listPackages = async (page = 1) => {
    try {
      const res = await fetch(
        `https://zen-registry-production.up.railway.app/api/list?page=${page}`
      );

      if (!res.ok) {
        console.error("error: Failed to fetch packages");
        process.exit(1);
      }

      const data = await res.json();
      const { page: currentPage, total, hasMore, count, packages } = data;

      console.log(`\nPage ${currentPage} (showing ${count} of ${total} packages):\n`);
      
      packages.forEach((pkg) => {
        console.log(`  ${pkg.name}@${pkg.latest}`);
        if (pkg.description) console.log(`    ${pkg.description}`);
        console.log(`    by ${pkg.author}\n`);
      });

      if (hasMore) {
        const rl = readline.createInterface({
          input: process.stdin,
          output: process.stdout
        });

        rl.question("Show next batch? (y/n) ", (answer) => {
          rl.close();
          if (answer.toLowerCase() === "y") {
            listPackages(currentPage + 1);
          }
        });
      } else {
        console.log("No more packages.");
      }
    } catch (err) {
      console.error(`error: ${err.message}`);
      process.exit(1);
    }
  };

  await listPackages();
}

  async handlePublish() {
  try {
    const projectDir = process.cwd();
    const configPath = path.join(projectDir, "zen.json");

    if (!fs.existsSync(configPath)) {
      console.error("error: zen.json not found");
      process.exit(1);
    }

    const authPath = path.join(os.homedir(), ".zen", "auth.json");

    if (!fs.existsSync(authPath)) {
      console.error("error: Not logged in");
      console.error("Run: zen login");
      process.exit(1);
    }

    const auth = JSON.parse(fs.readFileSync(authPath, "utf8"));
    const config = JSON.parse(fs.readFileSync(configPath, "utf8"));
    
    if (config.main) {
  config.kind = "main";
} else if (config.bin) {
  config.kind = "lib";
} else {
  console.error("error: zen.json must contain either 'main' or 'bin'");
  process.exit(1);
}

    console.log(`Publishing ${config.name} v${config.version}...`);

    const res = await fetch(
      "https://zen-registry-production.up.railway.app/api/publish",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${auth.token}`
        },
        body: JSON.stringify(config)
      }
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }

    console.log(data.message);
  } catch (err) {
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleUnpublish() {
  try {
    const projectDir = process.cwd();
    const configPath = path.join(projectDir, "zen.json");

    if (!fs.existsSync(configPath)) {
      console.error("error: zen.json not found");
      process.exit(1);
    }

    const config = JSON.parse(fs.readFileSync(configPath, "utf8"));
    const packageName = config.name;

    if (!packageName) {
      console.error("error: Package name not found in zen.json");
      process.exit(1);
    }

    const authPath = path.join(os.homedir(), ".zen", "auth.json");

    if (!fs.existsSync(authPath)) {
      console.error("error: Not logged in");
      console.error("Run: zen login");
      process.exit(1);
    }

    const auth = JSON.parse(fs.readFileSync(authPath, "utf8"));

    console.log(`Unpublishing ${packageName}...`);

    const res = await fetch(
      "https://zen-registry-production.up.railway.app/api/unpublish",
      {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${auth.token}`
        },
        body: JSON.stringify({ name: packageName })
      }
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }

    console.log(data.message);
  } catch (err) {
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleLogout() {
  try {
    const authPath = path.join(os.homedir(), ".zen", "auth.json");

    if (!fs.existsSync(authPath)) {
      console.error("error: Not logged in");
      process.exit(1);
    }

    fs.rmSync(authPath, { force: true });

    console.log("Logged out successfully.");
  } catch (err) {
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleUninstall() {
  const packageName = this.args[1];

  if (!packageName) {
    console.error("error: Usage zen uninstall <package-name>");
    process.exit(1);
  }

  try {
    // Check current directory
    let installDir = path.join(process.cwd(), packageName);
    
    // If not there, check ~/.zen/packages/
    if (!fs.existsSync(installDir)) {
      installDir = path.join(
        process.env.HOME || process.env.USERPROFILE,
        ".zen",
        "packages",
        packageName
      );
    }

    if (!fs.existsSync(installDir)) {
      console.error(`error: Package '${packageName}' not installed`);
      process.exit(1);
    }

    fs.rmSync(installDir, { recursive: true, force: true });
    console.log(`Uninstalled ${packageName}`);
  } catch (err) {
    console.error(`error: Uninstall failed: ${err.message}`);
    process.exit(1);
  }
}

  async handleInstall() {
  const packageName = this.args[1];

  if (!packageName) {
    console.error("error: Usage zen install <package-name>");
    process.exit(1);
  }

  try {
    console.log(`Installing ${packageName}...`);

    const registryRes = await fetch(
      `https://zen-registry-production.up.railway.app/api/packages.json?name=${packageName}`
    );

    if (!registryRes.ok) {
  const error = await registryRes.json();
  console.error(`error: ${error.error}`);
  process.exit(1);
}

    const pkg = await registryRes.json();

    if (!pkg?.repo) {
      console.error(`error: Package '${packageName}' not found`);
      process.exit(1);
    }

    const repoUrl = new URL(pkg.repo);
    const [owner, repo] = repoUrl.pathname.slice(1).split("/");

    const repoRes = await fetch(`https://api.github.com/repos/${owner}/${repo}`);
const repoData = await repoRes.json();

const branch = repoData.default_branch;

const configRes = await fetch(
  `https://raw.githubusercontent.com/${owner}/${repo}/${branch}/zen.json`
);

    if (!configRes.ok) {
      console.error("error: Failed to fetch zen.json");
      process.exit(1);
    }

    const config = await configRes.json();

    const isRunnable = !!config.main;
    const isLibrary = !!config.bin;

    let installDir;

    if (isRunnable) {
      installDir = path.join(process.cwd(), packageName);
    } else if (isLibrary) {
      installDir = path.join(
        process.env.HOME || process.env.USERPROFILE,
        ".zen",
        "packages",
        packageName
      );
    } else {
      console.error("error: invalid package type");
      process.exit(1);
    }

    if (fs.existsSync(installDir)) {
  // Check if update needed
  const localConfigPath = path.join(installDir, "zen.json");
  const localConfig = JSON.parse(fs.readFileSync(localConfigPath, "utf8"));
  
  if (localConfig.version === pkg.latest) {
    console.log(`Already installed at ${installDir} (latest)`);
    return;
  }

  console.log(`Updating ${packageName} from v${localConfig.version} to v${pkg.latest}...`);
  execSync(`cd ${installDir} && git pull`, { stdio: "inherit" });
  console.log(`Updated to v${pkg.latest}`);
  return;
}

fs.mkdirSync(installDir, { recursive: true });
console.log(`Cloning ${owner}/${repo}...`);
execSync(
  `git clone https://github.com/${owner}/${repo}.git ${installDir}`,
  { stdio: "inherit" }
);

console.log(`Installed ${packageName} v${pkg.latest}`);
console.log(`Location: ${installDir}`);

  } catch (err) {
    console.error(`error: Install failed: ${err.message}`);
    process.exit(1);
  }
}

async handleWhoami() {
  try {
    const authPath = path.join(os.homedir(), ".zen", "auth.json");

    if (!fs.existsSync(authPath)) {
      console.error("error: Not logged in");
      process.exit(1);
    }

    const auth = JSON.parse(fs.readFileSync(authPath, "utf8"));
    console.log(`Logged in as: ${auth.username}`);
  } catch (err) {
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

  async handleInit() {
    try {
      const projectName = this.args[1];
      const flag = this.args[2];

      if (!projectName) {
        console.error("error: Usage zen init <project-name>");
        process.exit(1);
      }

      const isLibrary = flag === "--bin";

      console.log(`Creating Project '${projectName}'...`);

      const projDir = path.resolve(projectName);

      if (fs.existsSync(projDir)) {
        console.error(`error: Directory '${projectName}' already exists`);
        process.exit(1);
      }

      fs.mkdirSync(projDir, { recursive: true });

      const mainFile = isLibrary ? "lib.zen" : "main.zen";
      fs.writeFileSync(
        path.join(projDir, mainFile),
        `screen("Hello Zen")\n`
      );

      const config = {
        name: projectName,
        version: "1.0.0",
        author: "your-github-username",
        repo: `https://github.com/your-username/zen-${projectName}`,
        description: "",
        ...(isLibrary ? { bin: mainFile } : { main: mainFile })
      };

      fs.writeFileSync(
        path.join(projDir, "zen.json"),
        JSON.stringify(config, null, 2)
      );

      console.log(`Project '${projectName}' created successfully`);
      console.log(`  - ${mainFile}`);
      console.log(`  - zen.json`);
    } catch (err) {
      console.error(`error: Failed to initialize project: ${err.message}`);
      process.exit(1);
    }
  }

  async handleClean() {
    try {
      const buildDir = path.join(this.PROJECT_ROOT, "build");

      if (!fs.existsSync(buildDir)) {
        console.log("Build directory not found");
        process.exit(0);
      }

      fs.rmSync(buildDir, { recursive: true, force: true });
      console.log("Cleaned build directory");
    } catch (err) {
      console.error(`error: Failed to clean: ${err.message}`);
      process.exit(1);
    }
  }
  
  async handleRecovery() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  const ask = (q) => new Promise(resolve => rl.question(q, resolve));

  try {
    const username = (await ask("Username: ")).trim();
    const recoveryCode = (await ask("Recovery code: ")).trim();
    const newPassword = await ask("New password: ");
    const confirm = await ask("Confirm password: ");

    rl.close();

    if (!username || !recoveryCode || !newPassword) {
      console.error("error: All fields required");
      process.exit(1);
    }

    if (newPassword !== confirm) {
      console.error("error: Passwords do not match");
      process.exit(1);
    }

    const res = await fetch(
      "https://zen-registry-production.up.railway.app/api/recovery",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          username,
          recoveryCode,
          newPassword
        })
      }
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }

    console.log(data.message);
  } catch (err) {
    rl.close();
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleSearch() {
  const name = this.args[1];

  if (!name) {
    console.error("error: Usage zen search <package>");
    process.exit(1);
  }

  try {
    const res = await fetch(
      `https://zen-registry-production.up.railway.app/api/search?name=${encodeURIComponent(name)}`
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }

    if (!data.length) {
      console.log("No packages found.");
      return;
    }

    for (const pkg of data) {
      console.log(`${pkg.name}@${pkg.latest}`);
      console.log(`  ${pkg.description || "No description"}`);
      console.log(`  by ${pkg.author}`);
      console.log("");
    }
  } catch (err) {
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleKind() {
  const name = this.args[1];

  if (!name) {
    console.error("error: Usage zen kind <package>");
    process.exit(1);
  }

  try {
    const res = await fetch(
      `https://zen-registry-production.up.railway.app/api/kind?name=${encodeURIComponent(name)}`
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }

    console.log(`${name}: ${data.kind}`);
  } catch (err) {
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

async handleMine() {
  try {
    const authPath = path.join(os.homedir(), ".zen", "auth.json");

    if (!fs.existsSync(authPath)) {
      console.error("error: Not logged in");
      process.exit(1);
    }

    const auth = JSON.parse(fs.readFileSync(authPath, "utf8"));

    const res = await fetch(
      "https://zen-registry-production.up.railway.app/api/mine",
      {
        headers: {
          Authorization: `Bearer ${auth.token}`
        }
      }
    );

    const data = await res.json();

    if (!res.ok) {
      console.error(`error: ${data.error}`);
      process.exit(1);
    }

    if (!data.length) {
      console.log("You haven't published any packages.");
      return;
    }

    for (const pkg of data) {
      console.log(`${pkg.name}@${pkg.latest}`);
      console.log(`  ${pkg.description || "No description"}`);
      console.log(`  ${pkg.kind}`);
      console.log("");
    }
  } catch (err) {
    console.error(`error: ${err.message}`);
    process.exit(1);
  }
}

handleUpdate() {
  try {
    console.log("Updating Zen...");

    execSync(
      'curl -fsSL https://raw.githubusercontent.com/jishith-dev/Zen/main/install.sh | bash',
      { stdio: "inherit", shell: true }
    );

    console.log("Zen updated successfully.");
  } catch (err) {
    console.error("error: Update failed.");
    process.exit(1);
  }
}

  async main() {
    const command = this.command;

    if (!command || command === "--help" || command === "-h" || command === "help") {
      this.help();
      process.exit(0);
    }

    if (command === "--version" || command === "-v" || command === "version") {
      console.log("Zen v1.1.1");
      process.exit(0);
    }

    if (!this.validCommands.has(command)) {
      console.error(`error: unknown command '${command}'`);
      this.help();
      process.exit(1);
    }

    if (command === "init") {
      await this.handleInit();
      return;
    }
    
    if (command === "signup") {
  await this.handleSignup();
  return;
}

if (command === "login") {
  await this.handleLogin();
  return;
}

if (command === "logout") {
  await this.handleLogout();
  return;
}

if (command === "whoami") {
  await this.handleWhoami();
  return;
}

if (command === "list") {
  await this.handleList();
  return;
}

if (command === "update") {
  await this.handleUpdate();
  return;
}

if (command === "recovery") {
  await this.handleRecovery();
  return;
}

if (command === "uninstall") {
  await this.handleUninstall();
  return;
}

if (command === "unpublish") {
  await this.handleUnpublish();
  return;
}

    if (command === "publish") {
      await this.handlePublish();
      return;
    }
    
    if (command === "search") {
  await this.handleSearch();
  return;
}

if (command === "kind") {
  await this.handleKind();
  return;
}

if (command === "mine") {
  await this.handleMine();
  return;
}

    if (command === "install") {
      await this.handleInstall();
      return;
    }

    this.setCompilerRoot();

    const file = this.args[1];

    if (!file) {
      console.error("error: missing input file");
      process.exit(1);
    }

    this.extractModuleName(file);
    this.setProjectRoot(file);

    let IRBuilder;
    try {
      IRBuilder = (await import(
        pathToFileURL(path.join(this.COMPILER_ROOT, "src/codegen/helper/helper.js")).href
      )).IRBuilder;
    } catch (err) {
      console.error("error: Failed to load IRBuilder" + err);
      process.exit(1);
    }

    const IRB = new IRBuilder(this.moduleName);
    
    await this.setSource(file, IRB);

    let Lexer;
    try {
      Lexer = (await import(
        pathToFileURL(path.join(this.COMPILER_ROOT, "src/lexer/lexer.js")).href
      )).Lexer;
    } catch (err) {
      console.error("error: Failed to load Lexer");
      process.exit(1);
    }

    const lexer = new Lexer(this.source, IRB);
    
    const tokens = lexer.tokenize();
    
    if (command === "tokens") {
      console.log(JSON.stringify(tokens, null, 2));
      process.exit(0);
    }

    let Parser;
    try {
      Parser = (await import(
        pathToFileURL(path.join(this.COMPILER_ROOT, "src/parser/parser.js")).href
      )).Parser;
    } catch (err) {
      console.error("error: Failed to load Parser");
      process.exit(1);
    }

    const parser = new Parser(tokens, IRB);
    const ast = parser.parse();

    if (command === "ast") {
      console.log(JSON.stringify(ast, null, 2));
      process.exit(0);
    }

    let CodeGen;
    try {
      CodeGen = (await import(
        pathToFileURL(path.join(this.COMPILER_ROOT, "src/codegen/codegen.js")).href
      )).CodeGen;
    } catch (err) {
      console.error("error: Failed to load CodeGen");
      process.exit(1);
    }
    
    this.moduleFiles.startCompiling(file);

    const codegen = new CodeGen(ast, this.moduleName, this.moduleFiles);
    const llvm = codegen.generateLLVM();
    
    this.moduleFiles.finishCompiling(file);

    if (!llvm) {
      console.error("error: Code generation failed");
      process.exit(1);
    }

    if (command === "ir") {
      console.log(llvm.ir);
      process.exit(0);
    }

    const moduleFiles = this.moduleFiles.moduleFiles;
    
    const buildDir = this.buildDir();

    if (command === "clean") {
      await this.handleClean();
      return;
    }

    const outLL = path.join(buildDir, `${this.moduleName}.ll`);
    const outOptLL = path.join(buildDir, `${this.moduleName}_opt.ll`);
    const outO = path.join(buildDir, `${this.moduleName}.o`);

    try {
      fs.writeFileSync(outLL, llvm.ir);
    } catch (err) {
      console.error(`error: Failed to write IR: ${err.message}`);
      process.exit(1);
    }

    this.run(`opt ${this.optFlag} ${outLL} -S -o ${outOptLL}`);
    this.run(`llc -filetype=obj -relocation-model=pic ${outOptLL} -o ${outO}`);

    const moduleObjs = [];

    for (const ll of moduleFiles) {
      try {
        const absLL = path.resolve(this.PROJECT_ROOT, ll);
        const obj = absLL.replace(".ll", ".o");
        this.run(`llc -filetype=obj -relocation-model=pic ${absLL} -o ${obj}`);
        moduleObjs.push(obj);
      } catch (err) {
        console.error(`error: Failed to compile module: ${err.message}`);
        process.exit(1);
      }
    }

    const stdlibObjs =  [
      path.join(this.COMPILER_ROOT, "src/zen_stdlib/constants.ll"),
      path.join(this.COMPILER_ROOT, "src/zen_stdlib/zen_stdlib_opt.ll"),
    ];

    const runtimeObjs =  [
      path.join(this.COMPILER_ROOT, "src/codegen/runtime/runtime.c"),
      path.join(this.COMPILER_ROOT, "src/codegen/runtime/listRuntime.c"),
      path.join(this.COMPILER_ROOT, "src/codegen/runtime/mapRuntime.c"),
      path.join(this.COMPILER_ROOT, "src/codegen/runtime/curlRuntime.c"),
      path.join(this.COMPILER_ROOT, "src/codegen/runtime/httpRuntime.c"),
    ];

    const outputExe = path.join(buildDir, this.moduleName);
    
    this.run([
      "clang",
      outO,
      ...moduleObjs,
      ...stdlibObjs,
      ...runtimeObjs,
      this.optFlag,
      "-Wno-override-module",
      "-lcurl",
      "-lm",
      "-o",
      outputExe,
    ].join(" "));

    if (command === "build") {
      console.log(`Build successful: ${outputExe}`);
      process.exit(0);
    }

    const userArgs = this.args.slice(3).join(" ");
    this.run(`${outputExe} ${userArgs}`);
  }
}

const zen = new ZEN();
await zen.main();
