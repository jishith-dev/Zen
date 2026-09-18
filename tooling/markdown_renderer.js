
const ANSI = {
  reset: "\x1b[0m",
  bold: "\x1b[1m",
  dim: "\x1b[2m",
  italic: "\x1b[3m",
  underline: "\x1b[4m",

  red: "\x1b[31m",
  green: "\x1b[32m",
  yellow: "\x1b[33m",
  blue: "\x1b[34m",
  magenta: "\x1b[35m",
  cyan: "\x1b[36m",
  white: "\x1b[37m",
  gray: "\x1b[90m",
};

const c = (color, text) =>
  `${ANSI[color]}${text}${ANSI.reset}`;

function renderInline(text) {
  // Escape ANSI control sequences from README content.
  text = text.replace(/\x1b\[[0-9;]*m/g, "");

  // Inline code: `code`
  const codeParts = [];
  text = text.replace(/`([^`]+)`/g, (_, code) => {
    codeParts.push(code);
    return `\x00CODE${codeParts.length - 1}\x00`;
  });

  // Markdown links: [text](url)
  text = text.replace(
    /\[([^\]]+)\]\(([^)]+)\)/g,
    (_, label, url) =>
      `${ANSI.cyan}${label}${ANSI.reset} ${ANSI.dim}(${url})${ANSI.reset}`
  );

  // Images: ![alt](url)
  text = text.replace(
    /!\[([^\]]*)\]\(([^)]+)\)/g,
    (_, alt, url) => `[Image: ${alt || url}]`
  );

  // Bold + italic
  text = text.replace(
    /\*\*\*(.+?)\*\*\*/g,
    `${ANSI.bold}${ANSI.italic}$1${ANSI.reset}`
  );

  // Bold
  text = text.replace(
    /\*\*(.+?)\*\*/g,
    `${ANSI.bold}$1${ANSI.reset}`
  );

  text = text.replace(
    /__(.+?)__/g,
    `${ANSI.bold}$1${ANSI.reset}`
  );

  // Italic
  text = text.replace(
    /(?<!\*)\*([^*\n]+)\*(?!\*)/g,
    `${ANSI.italic}$1${ANSI.reset}`
  );

  text = text.replace(
    /(?<!_)_([^_\n]+)_(?!_)/g,
    `${ANSI.italic}$1${ANSI.reset}`
  );

  // Strikethrough
  text = text.replace(
    /~~(.+?)~~/g,
    `${ANSI.dim}${ANSI.strikethrough || "\x1b[9m"}$1${ANSI.reset}`
  );

  // Restore inline code
  text = text.replace(
    /\x00CODE(\d+)\x00/g,
    (_, index) =>
      `${ANSI.cyan}${codeParts[Number(index)]}${ANSI.reset}`
  );

  return text;
}

function renderTable(lines, start) {
  const rows = [];
  let i = start;

  while (
    i < lines.length &&
    lines[i].trim().startsWith("|")
  ) {
    const row = lines[i]
      .trim()
      .replace(/^\|/, "")
      .replace(/\|$/, "")
      .split("|")
      .map((cell) => cell.trim());

    // Skip Markdown separator row.
    if (!row.every((cell) => /^:?-{3,}:?$/.test(cell))) {
      rows.push(row);
    }

    i++;
  }

  if (rows.length === 0) {
    return { output: [], next: i };
  }

  const width = Math.max(...rows.map((row) => row.length));
  const sizes = Array(width).fill(0);

  for (const row of rows) {
    for (let j = 0; j < width; j++) {
      sizes[j] = Math.max(
        sizes[j],
        (row[j] || "").length
      );
    }
  }

  const output = [];

  for (let rowIndex = 0; rowIndex < rows.length; rowIndex++) {
    const row = rows[rowIndex];

    const formatted = row
      .map((cell, j) =>
        ` ${cell.padEnd(sizes[j] || 0)} `
      )
      .join("|");

    output.push(
      `${ANSI.cyan}|${formatted}|${ANSI.reset}`
    );

    if (rowIndex === 0 && rows.length > 1) {
      output.push(
        "|" +
        sizes.map((size) => "-".repeat(size + 2)).join("|") +
        "|"
      );
    }
  }

  return { output, next: i };
}

export function renderMarkdown(markdown, options = {}) {
  const lines = markdown.replace(/\r\n/g, "\n").split("\n");
  const output = [];

  let inCode = false;
  let codeLanguage = "";
  let codeLines = [];

  const print = (line = "") => {
    output.push(line);
  };

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    // Fenced code blocks
    if (line.trim().startsWith("```")) {
      if (!inCode) {
        inCode = true;
        codeLanguage = line.trim().slice(3).trim();
        codeLines = [];

        print(
          c("gray", `┌─ Code${codeLanguage ? ` (${codeLanguage})` : ""}`)
        );
      } else {
        inCode = false;

        for (const codeLine of codeLines) {
          print(
            `${ANSI.gray}│${ANSI.reset} ${ANSI.cyan}${codeLine}${ANSI.reset}`
          );
        }

        print(c("gray", "└─"));
        codeLanguage = "";
        codeLines = [];
      }

      continue;
    }

    if (inCode) {
      codeLines.push(line);
      continue;
    }

    // Empty line
    if (line.trim() === "") {
      print();
      continue;
    }

    // Horizontal rules
    if (/^\s*((\*\s*){3,}|(-\s*){3,}|(_\s*){3,})$/.test(line)) {
      print(c("gray", "────────────────────────────"));
      continue;
    }

    // Headings: # through ######
    const heading = line.match(/^(#{1,6})\s+(.+)$/);

    if (heading) {
      const level = heading[1].length;
      const title = renderInline(heading[2].trim());

      const colors = [
        "yellow",
        "cyan",
        "green",
        "magenta",
        "blue",
        "white",
      ];

      const color = colors[level - 1];

      print();
      print(
        `${ANSI.bold}${ANSI[color]}${title}${ANSI.reset}`
      );
      print(c("gray", "─".repeat(Math.max(8, title.replace(/\x1b\[[0-9;]*m/g, "").length))));
      continue;
    }

    // Blockquotes
    const quote = line.match(/^\s*>\s?(.*)$/);

    if (quote) {
      print(
        `${ANSI.gray}│${ANSI.reset} ${ANSI.italic}${renderInline(quote[1])}${ANSI.reset}`
      );
      continue;
    }

    // Unordered lists
    const unordered = line.match(/^\s*[-*+]\s+(.+)$/);

    if (unordered) {
      print(`  ${ANSI.cyan}•${ANSI.reset} ${renderInline(unordered[1])}`);
      continue;
    }

    // Ordered lists
    const ordered = line.match(/^\s*(\d+)[.)]\s+(.+)$/);

    if (ordered) {
      print(
        `  ${ANSI.cyan}${ordered[1]}.${ANSI.reset} ${renderInline(ordered[2])}`
      );
      continue;
    }

    // Task list
    const task = line.match(
      /^\s*[-*+]\s+\[([ xX])\]\s+(.+)$/
    );

    if (task) {
      const checked = task[1].toLowerCase() === "x";
      const mark = checked ? "✓" : " ";
      print(
        `  ${ANSI.green}[${mark}]${ANSI.reset} ${renderInline(task[2])}`
      );
      continue;
    }

    // Markdown table
    if (
      line.trim().startsWith("|") &&
      i + 1 < lines.length &&
      /^\s*\|?(\s*:?-{3,}:?\s*\|)+\s*$/.test(lines[i + 1])
    ) {
      const table = renderTable(lines, i);

      for (const tableLine of table.output) {
        print(tableLine);
      }

      i = table.next - 1;
      continue;
    }

    // Normal paragraph
    print(renderInline(line));
  }

  if (inCode) {
    for (const codeLine of codeLines) {
      print(
        `${ANSI.gray}│${ANSI.reset} ${ANSI.cyan}${codeLine}${ANSI.reset}`
      );
    }

    print(c("gray", "└─"));
  }

  const result = output.join("\n");

  if (options.print !== false) {
    console.log(result);
  }

  return result;
}

export { ANSI };
