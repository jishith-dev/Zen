import fs from "fs";
import path from "path";
import os from "os";
import { renderMarkdown } from "../tooling/markdown_renderer.js";
import readline from "readline";
import { execSync } from "child_process";

const BACKEND_URL = "https://zen-registry.onrender.com";
const AUTH_PATH = path.join(os.homedir(), ".zen", "auth.json");
import { fileURLToPath } from "url";

function ask(rl, q) {
  return new Promise((resolve) => rl.question(q, resolve));
}

function readAuth() {
  if (!fs.existsSync(AUTH_PATH)) {
    console.error("error: Not logged in");
    process.exit(1);
  }
  return JSON.parse(fs.readFileSync(AUTH_PATH, "utf8"));
}

export class Package {
  constructor(args) {
    this.args = args;
  }

  async signup() {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });

    try {
      const username = (await ask(rl, "Username: ")).trim();
      const password = await ask(rl, "Password: ");
      const confirm = await ask(rl, "Confirm Password: ");

      rl.close();

      if (!username || !password) {
        console.error("error: username and password required");
        process.exit(1);
      }

      if (password !== confirm) {
        console.error("error: passwords do not match");
        process.exit(1);
      }

      const res = await fetch(`${BACKEND_URL}/api/signup`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });

      const data = await res.json();

      if (!res.ok) {
        console.error(`error: ${data.error}`);
        process.exit(1);
      }

      console.log("ZEN RECOVERY CODES");
      data.codes.forEach((c, i) => console.log(`${i + 1}. ${c}`));
      console.log("\nSave these codes. They will not be shown again.\n");
      console.log(data.message);
    } catch (err) {
      rl.close();
      console.error(`error: ${err.message}`);
      process.exit(1);
    }
  }

  async installed() {
    try {
      const packagesDir = path.join(
        process.env.HOME || process.env.USERPROFILE,
        ".zen_packages",
      );

      if (!fs.existsSync(packagesDir)) {
        console.log("No packages installed.");
        return;
      }

      const entries = fs.readdirSync(packagesDir, {
        withFileTypes: true,
      });

      const packages = [];

      for (const entry of entries) {
        if (!entry.isDirectory()) {
          continue;
        }

        const packageDir = path.join(packagesDir, entry.name);
        const configPath = path.join(packageDir, "zen.json");

        if (!fs.existsSync(configPath)) {
          continue;
        }

        try {
          const config = JSON.parse(fs.readFileSync(configPath, "utf8"));

          if (!config.name || !config.version) {
            continue;
          }

          packages.push({
            name: config.name,
            version: config.version,
          });
        } catch {
          // Ignore invalid package metadata
        }
      }

      packages.sort((a, b) => a.name.localeCompare(b.name));

      if (packages.length === 0) {
        console.log("No packages installed.");
        return;
      }

      console.log("Installed packages:\n");

      for (const pkg of packages) {
        console.log(`  ${pkg.name}@${pkg.version}`);
      }

      console.log(
        `\n${packages.length} package${packages.length === 1 ? "" : "s"} installed.`,
      );
    } catch (err) {
      console.error(`error: Failed to read installed packages: ${err.message}`);
      process.exit(1);
    }
  }

  async login() {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });

    try {
      const username = (await ask(rl, "Username: ")).trim();
      const password = await ask(rl, "Password: ");

      rl.close();

      const res = await fetch(`${BACKEND_URL}/api/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password }),
      });

      const data = await res.json();

      if (!res.ok) {
        console.error(`error: ${data.error}`);
        process.exit(1);
      }

      const authDir = path.join(os.homedir(), ".zen");
      fs.mkdirSync(authDir, { recursive: true });
      fs.writeFileSync(
        AUTH_PATH,
        JSON.stringify({ username, token: data.token }, null, 2),
      );

      console.log("Logged in successfully.");
    } catch (err) {
      rl.close();
      console.error(`error: ${err.message}`);
      process.exit(1);
    }
  }

  async logout() {
    try {
      if (!fs.existsSync(AUTH_PATH)) {
        console.error("error: Not logged in");
        process.exit(1);
      }

      fs.rmSync(AUTH_PATH, { force: true });
      console.log("Logged out successfully.");
    } catch (err) {
      console.error(`error: ${err.message}`);
      process.exit(1);
    }
  }

  async whoami() {
    try {
      const auth = readAuth();
      console.log(`Logged in as: ${auth.username}`);
    } catch (err) {
      console.error(`error: ${err.message}`);
      process.exit(1);
    }
  }

  async recovery() {
    const rl = readline.createInterface({
      input: process.stdin,
      output: process.stdout,
    });

    try {
      const username = (await ask(rl, "Username: ")).trim();
      const recoveryCode = (await ask(rl, "Recovery code: ")).trim();
      const newPassword = await ask(rl, "New password: ");
      const confirm = await ask(rl, "Confirm password: ");

      rl.close();

      if (!username || !recoveryCode || !newPassword) {
        console.error("error: All fields required");
        process.exit(1);
      }

      if (newPassword !== confirm) {
        console.error("error: Passwords do not match");
        process.exit(1);
      }

      const res = await fetch(`${BACKEND_URL}/api/recovery`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, recoveryCode, newPassword }),
      });

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

  async list() {
    const listPackages = async (page = 1) => {
      try {
        const res = await fetch(`${BACKEND_URL}/api/list?page=${page}`);

        if (!res.ok) {
          console.error("error: Failed to fetch packages");
          process.exit(1);
        }

        const data = await res.json();
        const { page: currentPage, total, hasMore, count, packages } = data;

        console.log(
          `\nPage ${currentPage} (showing ${count} of ${total} packages):\n`,
        );

        packages.forEach((pkg) => {
          console.log(`  ${pkg.name}@${pkg.latest}`);
          if (pkg.description) console.log(`    ${pkg.description}`);
          console.log(`    by ${pkg.author}\n`);
        });

        if (hasMore) {
          const rl = readline.createInterface({
            input: process.stdin,
            output: process.stdout,
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

  async search() {
    const name = this.args[1];

    if (!name) {
      console.error("error: Usage zen search <package>");
      process.exit(1);
    }

    try {
      const res = await fetch(
        `${BACKEND_URL}/api/search?name=${encodeURIComponent(name)}`,
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

  async kind() {
    const name = this.args[1];

    if (!name) {
      console.error("error: Usage zen kind <package>");
      process.exit(1);
    }

    try {
      const res = await fetch(
        `${BACKEND_URL}/api/kind?name=${encodeURIComponent(name)}`,
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

  async mine() {
    try {
      const auth = readAuth();

      const res = await fetch(`${BACKEND_URL}/api/mine`, {
        headers: { Authorization: `Bearer ${auth.token}` },
      });

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

  async publish() {
    try {
      const projectDir = process.cwd();
      const configPath = path.join(projectDir, "zen.json");

      if (!fs.existsSync(configPath)) {
        console.error("error: zen.json not found");
        process.exit(1);
      }

      const auth = readAuth();
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

      const res = await fetch(`${BACKEND_URL}/api/publish`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${auth.token}`,
        },
        body: JSON.stringify(config),
      });

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

  async unpublish() {
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

      const auth = readAuth();

      console.log(`Unpublishing ${packageName}...`);

      const res = await fetch(`${BACKEND_URL}/api/unpublish`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${auth.token}`,
        },
        body: JSON.stringify({ name: packageName }),
      });

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

  async install() {
    const inputs = this.args.slice(1);

    if (inputs.length === 0) {
      console.error("error: Usage zen install <package>[@version] ...");
      process.exit(1);
    }

    for (const input of inputs) {
      await this.installPackage(input);
    }
  }

  async installPackage(input, options = {}) {
  const atIndex = input.lastIndexOf("@");

  let packageName = input;
  let requestedVersion = null;

  if (atIndex > 0) {
    packageName = input.slice(0, atIndex);
    requestedVersion = input.slice(atIndex + 1);

    if (!/^\d+\.\d+\.\d+$/.test(requestedVersion)) {
      console.error(
        `error: Invalid version '${requestedVersion}'. Expected x.y.z`,
      );
      process.exit(1);
    }
  }

  try {
    const displayName = requestedVersion
      ? `${packageName}@${requestedVersion}`
      : packageName;

    console.log(`Installing ${displayName}...`);

    let pkg;
    let installVersion;
    let repoUrl;

    if (options.repo && options.version) {
      repoUrl = new URL(options.repo);
      installVersion = options.version;
    } else {
      
     //  * Normal install uses the registry.
       
      const registryUrl =
  `${BACKEND_URL}/api/packages.json?name=${encodeURIComponent(packageName)}`;

      const registryRes = await fetch(registryUrl);

      if (!registryRes.ok) {
        const error = await registryRes.json();
        console.error(`error: ${error.error}`);
        process.exit(1);
      }

      pkg = await registryRes.json();

      if (!pkg?.repo) {
        console.error(`error: Package '${displayName}' not found`);
        process.exit(1);
      }

      repoUrl = new URL(pkg.repo);

if (requestedVersion) {
  installVersion = requestedVersion;
} else {
  const [owner, repo] = repoUrl.pathname
    .replace(/\.git$/, "")
    .slice(1)
    .split("/");

  if (!owner || !repo) {
    console.error("error: Invalid repository URL");
    process.exit(1);
  }

  console.log(`Checking ${packageName} for latest version...`);

  const output = execSync(
    `git ls-remote --tags --refs https://github.com/${owner}/${repo}.git`,
    {
      encoding: "utf8",
    },
  );

  const versions = output
    .split("\n")
    .map((line) => line.trim().split(/\s+/)[1])
    .filter((tag) => /^refs\/tags\/v\d+\.\d+\.\d+$/.test(tag))
    .map((tag) => tag.replace("refs/tags/v", ""));

  if (versions.length === 0) {
    console.error(`error: No version tags found for ${packageName}`);
    process.exit(1);
  }

  const compareVersions = (a, b) => {
    const pa = a.split(".").map(Number);
    const pb = b.split(".").map(Number);

    for (let i = 0; i < 3; i++) {
      if (pa[i] !== pb[i]) {
        return pa[i] - pb[i];
      }
    }

    return 0;
  };

  versions.sort(compareVersions);
  installVersion = versions[versions.length - 1];
}
    }

    const [owner, repo] = repoUrl.pathname
      .replace(/\.git$/, "")
      .slice(1)
      .split("/");

    if (!owner || !repo) {
      console.error("error: Invalid repository URL");
      process.exit(1);
    }

    
   //  * Get zen.json from exact Git tag.
    
    const configRes = await fetch(
      `https://raw.githubusercontent.com/${owner}/${repo}/v${installVersion}/zen.json`,
    );

    if (!configRes.ok) {
      console.error(
        `error: Failed to fetch zen.json for v${installVersion}`,
      );
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
        ".zen_packages",
        packageName,
      );
    } else {
      console.error("error: invalid package type");
      process.exit(1);
    }

    
    if (fs.existsSync(installDir)) {
      const localConfigPath = path.join(installDir, "zen.json");

      if (fs.existsSync(localConfigPath)) {
        const localConfig = JSON.parse(
          fs.readFileSync(localConfigPath, "utf8"),
        );

        if (localConfig.version === installVersion) {
          console.log(
            `Already installed ${packageName} v${installVersion}`,
          );
          return;
        }

        console.log(
          `Updating ${packageName} from v${localConfig.version} to v${installVersion}...`,
        );
      }
    }

    const parentDir = path.dirname(installDir);
    const tempDir = path.join(
      parentDir,
      `.zen-${packageName}-${installVersion}-tmp`,
    );

    fs.rmSync(tempDir, {
      recursive: true,
      force: true,
    });

    fs.mkdirSync(parentDir, {
      recursive: true,
    });

    console.log(`Cloning ${owner}/${repo}@v${installVersion}...`);

    execSync(
      `git clone --branch v${installVersion} --single-branch https://github.com/${owner}/${repo}.git ${tempDir}`,
      {
        stdio: "ignore",
      },
    );

    
 //    * Install dependencies before replacing the current version.
     
    if (
      config.dependencies &&
      Object.keys(config.dependencies).length > 0
    ) {
      for (const [name, version] of Object.entries(config.dependencies)) {
        console.log(`Installing dependency ${name}@${version}...`);

        execSync(`zen install ${name}@${version}`, {
          stdio: "inherit",
        });
      }
    }

  
    fs.rmSync(installDir, {
      recursive: true,
      force: true,
    });

    fs.renameSync(tempDir, installDir);

    console.log(
      `Installed ${packageName} v${installVersion}`,
    );

    console.log(`Location: ${installDir}`);
  } catch (err) {
    console.error(`error: Install failed: ${err.message}`);
    process.exit(1);
  }
  }

  async uninstall() {
    const inputs = this.args.slice(1);

    if (inputs.length === 0) {
      console.error("error: Usage zen uninstall <package>...");
      process.exit(1);
    }

    for (const input of inputs) {
      await this.unInstallPackage(input);
    }
  }

  async unInstallPackage(packageName) {
    try {
      let installDir = path.join(process.cwd(), packageName);

      if (!fs.existsSync(installDir)) {
        installDir = path.join(
          process.env.HOME || process.env.USERPROFILE,
          ".zen_packages",
          packageName,
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

  async upgrade() {
  const packageName = this.args[1];

  if (!packageName) {
    console.error("error: Usage zen upgrade <package>");
    process.exit(1);
  }

  try {
    const packagesDir = path.join(
      process.env.HOME || process.env.USERPROFILE,
      ".zen_packages",
    );

    const installDir = path.join(packagesDir, packageName);

    if (!fs.existsSync(installDir)) {
      console.error(`error: Package '${packageName}' is not installed`);
      process.exit(1);
    }

    const localConfigPath = path.join(installDir, "zen.json");

    if (!fs.existsSync(localConfigPath)) {
      console.error(`error: Package '${packageName}' has no zen.json`);
      process.exit(1);
    }

    const localConfig = JSON.parse(
      fs.readFileSync(localConfigPath, "utf8"),
    );

    const currentVersion = localConfig.version;

    if (!localConfig.repo) {
      console.error(`error: Package '${packageName}' has no repository`);
      process.exit(1);
    }

    const repoUrl = new URL(localConfig.repo);

    const [owner, repo] = repoUrl.pathname
      .replace(/\.git$/, "")
      .slice(1)
      .split("/");

    if (!owner || !repo) {
      console.error("error: Invalid repository URL");
      process.exit(1);
    }

    console.log(`Checking ${packageName} for updates...`);

    const output = execSync(
      `git ls-remote --tags --refs https://github.com/${owner}/${repo}.git`,
      {
        encoding: "utf8",
      },
    );

    const versions = output
      .split("\n")
      .map((line) => line.trim().split(/\s+/)[1])
      .filter((tag) => /^refs\/tags\/v\d+\.\d+\.\d+$/.test(tag))
      .map((tag) => tag.replace("refs/tags/v", ""));

    if (versions.length === 0) {
      console.error(`error: No version tags found for ${packageName}`);
      process.exit(1);
    }

    const compareVersions = (a, b) => {
      const pa = a.split(".").map(Number);
      const pb = b.split(".").map(Number);

      for (let i = 0; i < 3; i++) {
        if (pa[i] !== pb[i]) {
          return pa[i] - pb[i];
        }
      }

      return 0;
    };

    versions.sort(compareVersions);

    const latestVersion = versions[versions.length - 1];

    if (compareVersions(latestVersion, currentVersion) <= 0) {
      console.log(
        `Already installed ${packageName} v${currentVersion}`,
      );
      return;
    }

    console.log(
      `Updating ${packageName} from v${currentVersion} to v${latestVersion}...`,
    );

    await this.installPackage(packageName, {
      repo: localConfig.repo,
      version: latestVersion,
    });
  } catch (err) {
    console.error(`error: Upgrade failed: ${err.message}`);
    process.exit(1);
  }
  }

  async read() {
    const packageName = this.args[1];
    const isRaw = this.args.includes("--raw");

    if (!packageName || packageName.startsWith("-")) {
      console.error("error: Usage zen read <package> [--raw]");
      process.exit(1);
    }

    // Prevent path traversal
    if (
      packageName.includes("/") ||
      packageName.includes("\\") ||
      packageName.includes("..")
    ) {
      console.error("error: Invalid package name");
      process.exit(1);
    }

    const packagesDir = path.join(os.homedir(), ".zen_packages");

    const packageDir = path.join(packagesDir, packageName);

    const readmePath = path.join(packageDir, "README.md");

    if (!fs.existsSync(packageDir)) {
      console.error(`error: Package '${packageName}' is not installed`);
      process.exit(1);
    }

    if (!fs.existsSync(readmePath)) {
      console.error(`error: Package '${packageName}' has no README.md`);
      process.exit(1);
    }

    const markdown = fs.readFileSync(readmePath, "utf8");

    if (isRaw) {
      process.stdout.write(markdown);
      return;
    }

    renderMarkdown(markdown);
  }

  async init() {
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
      fs.writeFileSync(path.join(projDir, mainFile), `screen("Hello Zen")\n`);

      const config = {
        name: projectName,
        version: "1.0.0",
        author: "your-github-username",
        repo: `https://github.com/your-username/zen-${projectName}`,
        description: "",
        ...(isLibrary ? { bin: mainFile } : { main: mainFile }),
        dependencies: {},
      };

      fs.writeFileSync(
        path.join(projDir, "zen.json"),
        JSON.stringify(config, null, 2),
      );

      console.log(`Project '${projectName}' created successfully`);
      console.log(`  - ${mainFile}`);
      console.log(`  - zen.json`);
    } catch (err) {
      console.error(`error: Failed to initialize project: ${err.message}`);
      process.exit(1);
    }
  }

  update() {
  const dev = this.args.includes("--dev");
  const branch = dev ? "dev" : "main";
  const script = dev ? "install-dev.sh" : "install.sh";
  const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
  const stampFile = path.join(root, ".commit");

  let latest;
  try {
    latest = execSync(
      `curl -fsSL -H "Accept: application/vnd.github.sha" https://api.github.com/repos/Jishith-dev/Zen/commits/${branch}`,
      { encoding: "utf8" },
    ).trim();
  } catch {
    console.error("error: Could not check latest version.");
    process.exit(1);
  }

  const stamp = `${branch}:${latest}`;
  const installed = fs.existsSync(stampFile)
    ? fs.readFileSync(stampFile, "utf8").trim()
    : "";

  if (installed === stamp) {
    console.log(`Zen is already up to date${dev ? " (dev)" : ""}.`);
    return;
  }

  try {
    console.log(`Updating Zen${dev ? " (dev)" : ""}...`);

    execSync(
      `curl -fsSL https://raw.githubusercontent.com/Jishith-dev/Zen/${branch}/${script} | bash`,
      { stdio: "inherit", shell: true },
    );

    fs.writeFileSync(stampFile, stamp);
    console.log("Zen updated successfully.");
  } catch {
    console.error("error: Update failed.");
    process.exit(1);
  }
  }
  
  async deps() {
    try {
      const projectDir = process.cwd();
      const configPath = path.join(projectDir, "zen.json");

      if (!fs.existsSync(configPath)) {
        console.error("error: zen.json not found");
        process.exit(1);
      }

      const config = JSON.parse(fs.readFileSync(configPath, "utf8"));

      const dependencies = {};
      const visited = new Set();

      function scanNative() {
        const native = [];
        const nativeDir = path.join(projectDir, "native");

        if (!fs.existsSync(nativeDir)) {
          return;
        }

        for (const entry of fs.readdirSync(nativeDir, {
          withFileTypes: true,
        })) {
          if (!entry.isFile()) {
            continue;
          }

          if (entry.name.endsWith(".o") || entry.name.endsWith(".c")) {
            native.push(path.join("native", entry.name));
          }
        }
        return native;
      }

      function scanFile(filePath) {
        filePath = path.resolve(filePath);

        if (visited.has(filePath)) {
          return;
        }

        visited.add(filePath);

        if (!fs.existsSync(filePath)) {
          console.error(`error: File not found: ${filePath}`);
          process.exit(1);
        }

        const source = fs.readFileSync(filePath, "utf8");

        // Remove Zen comments before scanning imports
        const sourceWithoutComments = source
          .replace(/\/\*[\s\S]*?\*\//g, "")
          .replace(/\/\/.*$/gm, "")
          .replace(/#.*$/gm, "");

        const importRegex = /import\s*\([^)]*\)\s*from\s*"([^"]+)"/g;

        let match;

        while ((match = importRegex.exec(sourceWithoutComments)) !== null) {
          const importPath = match[1];

          /*
           * Local Zen file
           *
           * Examples:
           * from "utils.zen"
           * from "./utils.zen"
           * from "../utils.zen"
           */
          if (
            importPath.endsWith(".zen") ||
            importPath.startsWith("./") ||
            importPath.startsWith("../")
          ) {
            const localPath = path.resolve(path.dirname(filePath), importPath);

            scanFile(localPath);
            continue;
          }

          /*
           * Package dependency
           *
           * Example:
           * from "drift"
           */

          if (!/^[a-zA-Z0-9_-]+$/.test(importPath)) {
            continue;
          }

          const packageDir = path.join(
            process.env.HOME || process.env.USERPROFILE,
            ".zen_packages",
            importPath,
          );

          const packageConfigPath = path.join(packageDir, "zen.json");

          if (!fs.existsSync(packageConfigPath)) {
            console.error(`error: Dependency '${importPath}' is not installed`);
            process.exit(1);
          }

          const packageConfig = JSON.parse(
            fs.readFileSync(packageConfigPath, "utf8"),
          );

          if (!packageConfig.version) {
            console.error(`error: Dependency '${importPath}' has no version`);
            process.exit(1);
          }

          dependencies[importPath] = packageConfig.version;
        }
      }

      // Start with main/bin entry
      const entry = config.main || config.bin;

      if (!entry) {
        console.error("error: zen.json must contain 'main' or 'bin'");
        process.exit(1);
      }

      scanFile(path.join(projectDir, entry));

      // Update zen.json
      config.dependencies = dependencies;
      config.native = scanNative();

      fs.writeFileSync(configPath, JSON.stringify(config, null, 2) + "\n");

      console.log("Dependencies updated.");

      if (Object.keys(dependencies).length === 0) {
        console.log("No Zen package dependencies found.");
      } else {
        for (const [name, version] of Object.entries(dependencies)) {
          console.log(`  ${name}@${version}`);
        }
      }

      if (config.native && config.native.length > 0) {
        console.log("Native dependencies:");

        for (const file of config.native) {
          console.log(`  ${file}`);
        }
      }
    } catch (err) {
      console.error(`error: Failed to update dependencies: ${err.message}`);
      process.exit(1);
    }
  }
}
