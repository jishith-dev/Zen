import fs from "fs";
import path from "path";
import readline from "readline";
import { fileURLToPath } from "url";
import { spawn } from "child_process";
import highlightCode from "../highlight.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const TEST_DIR = path.join(__dirname, "examples");

const TESTS = [
  {
    name: "Hello World",
    file: "hello_world.zen"
  },

  {
    name: "Variables and access",
    file: "variables.zen"
  },

  {
    name: "Functions and builtins",
    file: "functions.zen"
  }
];

export class Tests {
  constructor(args = []) {
    this.args = args;
  }

  async run() {
    console.log("");
    console.log("Zen Tests");
    console.log("─".repeat(50));
    console.log("");

    if (TESTS.length === 0) {
      console.log("No tests available.");
      return;
    }

    const selected = await this.selectTest();

    if (selected === null) {
      return;
    }

    await this.showTest(selected);
  }

  async selectTest() {
    console.log("Available tests:");
    console.log("");

    for (let i = 0; i < TESTS.length; i++) {
      console.log(`  ${i + 1}. ${TESTS[i].name}`);
    }

    console.log("");
    console.log("Enter test number, or q to quit.");

    const answer = await this.question("> ");

    if (answer.toLowerCase() === "q") {
      return null;
    }

    const index = Number(answer) - 1;

    if (
      !Number.isInteger(index) ||
      index < 0 ||
      index >= TESTS.length
    ) {
      console.log("");
      console.log("Invalid test selection.");
      return null;
    }

    return TESTS[index];
  }

  async showTest(test) {
    const filePath = path.join(TEST_DIR, test.file);

    if (!fs.existsSync(filePath)) {
      console.log("");
      console.log(`[Zen Tests Error] Test file not found: ${test.file}`);
      return;
    }

    const source = fs.readFileSync(filePath, "utf8");

    console.log("");
    console.log(`Zen Test: ${test.name}`);
    console.log("─".repeat(50));
    console.log("");
    console.log(highlightCode(source));
    console.log("─".repeat(50));
    console.log("");

    const answer = await this.question("Run this test? [y/N] ");

    if (answer.toLowerCase() !== "y") {
      console.log("Test not run.");
      return;
    }

    await this.runTest(filePath);
  }

  async runTest(filePath) {
  console.log("");
  console.log("Running test...");
  console.log("─".repeat(50));
  console.log("");

  const tempDir = path.join(
    process.env.HOME,
    ".zen_test"
  );

  fs.mkdirSync(tempDir, { recursive: true });

  const tempFile = path.join(
    tempDir,
    path.basename(filePath)
  );

  fs.copyFileSync(filePath, tempFile);

  const child = spawn(
    "zen",
    ["run", tempFile],
    {
      stdio: "inherit"
    }
  );

  await new Promise((resolve) => {
    child.on("close", (code) => {
      console.log("");
      console.log("─".repeat(50));

      if (code === 0) {
        console.log("✓ Test completed successfully.");
      } else {
        console.log(`✗ Test failed with exit code ${code}.`);
      }

      resolve();
    });
  });

  fs.rmSync(tempFile, { force: true });
  }

  question(prompt) {
    return new Promise((resolve) => {
      const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
      });

      rl.question(prompt, (answer) => {
        rl.close();
        resolve(answer.trim());
      });
    });
  }
}