export class Switch {
  constructor(IRB, expr, block) {
    this.IRB = IRB;
    this.expr = expr;
    this.block = block;
  }

  handleSwitch(node) {
    const expr = this.expr.handleExpression(node.discriminant);
    const caseSeen = new Set();

    this.IRB.emitExpr(expr);

    if (expr.type !== "int") {
      this.IRB.emitError(
        "TypeError",
        `Invalid switch expression type '${expr.type}'. Expected 'int'`,
        node,
      );
    }

    const endLabel = this.IRB.newLabel("switch_end");
    let endUsed = false;
    const defaultLabel = this.IRB.newLabel("switch_default");

    const caseLabels = node.cases.map(() => this.IRB.newLabel("switch_case"));

    let switchIR = `switch ${expr.llvmType} ${expr.ptr}, label %${defaultLabel} [\n`;

    for (let i = 0; i < node.cases.length; i++) {
      const caseNode = node.cases[i].value;

      const caseConst = this.IRB.constEval(caseNode, "Switch Case");

      if (typeof caseConst !== "number") {
        this.IRB.emitError(
          "TypeError",
          "Invalid switch case. Expected constant integer literal",
          node,
        );
      }

      if (caseSeen.has(caseConst)) {
        this.IRB.emitError(
          "TypeError",
          `Duplicate case value '${caseConst}' in switch`,
          node,
        );
      }

      caseSeen.add(caseConst);

      switchIR += `  ${expr.llvmType} ${caseConst}, label %${caseLabels[i]}\n`;
    }

    switchIR += "]";

    this.IRB.emit(switchIR);

    // CASE BLOCKS

    for (let i = 0; i < node.cases.length; i++) {
      const c = node.cases[i];

      this.IRB.emit(`${caseLabels[i]}:`);

      const blockNode = {
        type: "BLOCK",
        body: c.statements,
      };

      this.block.block(blockNode);

      if (!this.IRB.hasTerminator()) {
        this.IRB.emit(`br label %${endLabel}`);
        endUsed = true;
      }
    }

    // DEFAULT BLOCK

    this.IRB.emit(`${defaultLabel}:`);

    if (node.defaultCase) {
      for (const stmt of node.defaultCase.statements) {
        this.block.block(stmt);
      }
    }

    if (!this.IRB.hasTerminator()) {
      this.IRB.emit(`br label %${endLabel}`);
      endUsed = true;
    }

    if (endUsed) {
      this.IRB.emit(`${endLabel}:`);
    }
  }
}