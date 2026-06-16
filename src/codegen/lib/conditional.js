export class Conditional {
  constructor(IRB, expr, block) {
    this.IRB = IRB;
    this.expr = expr;
    this.block = block;
  }
  
  conditional(node, meta) {
    
    this.IRB.guardStackOp("IF", node);
    
    const endLabel = this.IRB.newLabel("end");
    
    const chain = [
      { condition: node.if.condition, body: node.if.body },
      ...(node.elseIf || [])
    ];
    
    let falseLabel = null;
    let endLabelUsed = false;
    
    for (let i = 0; i < chain.length; i++) {
      const { condition, body } = chain[i];
      
      if (i !== 0) {
        this.IRB.emit(`${falseLabel}:`);
      }
      
      const expr = this.expr.handleExpression(condition, false);
      
      this.IRB.emitExpr(expr);
      
      const cond =
        expr.llvmType === "i1" ?
        expr.ptr :
        this.IRB.toI1(expr.ptr, expr.llvmType);
      
      const trueLabel = this.IRB.newLabel("if");
      
      falseLabel =
        i === chain.length - 1 ?
        (node.else ? this.IRB.newLabel("else") : endLabel) :
        this.IRB.newLabel("elseif");
      
      this.IRB.emit(`br i1 ${cond}, label %${trueLabel}, label %${falseLabel}`);
      
      this.IRB.emit(`${trueLabel}:`);
      
      this.block.block(body, false, meta);
      
      if (!this.IRB.hasTerminator()) {
      this.IRB.emit(`br label %${endLabel}`);
      endLabelUsed = true;
      }
    }
    
    if (node.else) {
      
      this.IRB.emit(`${falseLabel}:`);
      
      this.block.block(node.else?.body);
      
      if (!this.IRB.hasTerminator()) {
      this.IRB.emit(`br label %${endLabel}`);
      endLabelUsed = true;
      }
    } else {
      
      if (chain.length > 0) {
        
        this.IRB.emit(`${falseLabel}:`);
      }
    }
    
    const last = this.IRB.currentFunction ? this.IRB.currentFunction.body[this.IRB.currentFunction.body.length - 1] : this.IRB.locals[this.IRB.locals.length - 1];
    
    if (last !== `${endLabel}:`) {
      
      if (endLabelUsed) {
      this.IRB.emit(`${endLabel}:`);
      }
    }
    
  }
}