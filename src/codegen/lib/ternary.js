export class Ternary {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }
  
  ternary(node) {
    
    const cond = this.expr.handleExpression(node.condition);
    
    this.IRB.emitExpr(cond);
    
    const trueLabel = this.IRB.newLabel("ternary_true");
    const falseLabel = this.IRB.newLabel("ternary_false");
    const mergeLabel = this.IRB.newLabel("ternary_merge");
    
    const t = this.expr.handleExpression(node.trueExpr);
    const f = this.expr.handleExpression(node.falseExpr);
    const tType = t.type;
    const fType = f.type;
    
    if (tType !== fType) {
      this.IRB.emitError(
        "TypeError",
        `ternary expression requires matching types, got '${tType}' and '${fType}'`,
        node
      );
    }
    
    if (t.isList !== f.isList) {
      this.IRB.emitError(
        "TypeError",
        `ternary expression requires matching types, got '${t.isList ? "List" : tType}' and '${f.isList ? "List" : fType}'`,
        node
      );
    }
    
    this.IRB.emitExpr(t);
    this.IRB.emitExpr(f);
    
    let resultType = t.llvmType;
    let isStruct = this.IRB.hasStruct(t.type)
    if (isStruct) {
      resultType = "ptr";
    }
    
    const boolPtr = this.IRB.toBool(cond.ptr, cond.type);
    
    this.IRB.emit(
      `br i1 ${boolPtr}, label %${trueLabel}, label %${falseLabel}`
    );
    
    // TRUE BLOCK
    
    this.IRB.emit(`${trueLabel}:`);
    this.IRB.emit(`br label %${mergeLabel}`);
    
    // FALSE BLOCK
    
    this.IRB.emit(`${falseLabel}:`);
    this.IRB.emit(`br label %${mergeLabel}`);
    
    // PHI
    
    this.IRB.emit(`${mergeLabel}:`);
    
    const result = this.IRB.newTemp();
    
    this.IRB.emit(
      `${result} = phi ${resultType} ` +
      `[ ${t.ptr}, %${trueLabel} ], ` +
      `[ ${f.ptr}, %${falseLabel} ]`
    );
    
    return {
      ptr: result,
      type: t.type || f.type,
      llvmType: resultType,
      local: [],
      global: [],
      isVarRef: false,
      isStruct,
      isList: t.isList || f.isList
    };
  }
}