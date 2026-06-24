export class ZenString {
  constructor(IRB, expr) {
    this.IRB = IRB;
    this.expr = expr;
  }
  
  length(node) {
    
    const args = node.args;
    
    if (!args) {
  this.IRB.emitError(
    "SyntaxError",
    `'length()' must be called as a function — did you forget '()'?`,
    node
  );
}
    
    if (args[0].length > 1) {
      this.IRB.emitError("ArgumentError", "Function type() accept exactly 1 argument", node);
    }
    
    const expr = this.expr.handleExpression(args[0]);
    
    const isArray = expr.llvmType.startsWith("[");
    const isString = expr.type === "string";
    const isList = expr?.isList;
    
    if ((!isString && !isArray) || (isList || expr?.isStruct)) {
      this.IRB.emitError(
        "TypeError",
        "The length() function expects a string or array argument.", node
      );
    }
    
    
    this.IRB.emitExpr(expr)
    
    this.IRB.declareOneTime("strlen", "declare i32 @strlen(ptr)");
    
    let finalPtr = null;
    
      if (!isArray) {
        const t = this.IRB.newTemp();
        this.IRB.emit(`${t} = call i32 @strlen(ptr ${expr.ptr})`);
        
        finalPtr = t;
        
      } else {
        finalPtr = expr.length;
      }
    
    return {
      ptr: finalPtr,
      type: "int",
      llvmType: "i32",
      local: [],
      global: [],
      isConstant: true,
      postOrPrefix: false
    }
    
  }
  
  matchRegex(node) {
  
  const args = node.args;
  
  if (!args) {
    this.IRB.emitError(
      "SyntaxError",
      `'matchRegex()' must be called as a function — did you forget '()'?`,
      node
    );
  }
  
  if (args.length !== 2) {
    this.IRB.emitError(
      "ArgumentError",
      `Function 'matchRegex()' expects exactly 2 arguments, got ${args.length}`,
      node
    );
  }
  
  const params = ["string", "string"]; 
  
  const exprs = args.map(arg => this.expr.handleExpression(arg));
  
  exprs.forEach((expr, i) => {
    const actualType = expr.type;
    const expectedType = params[i];
    
    if (actualType !== expectedType) {
      this.IRB.emitError(
        "TypeError",
        `Function 'matchRegex()' expects ${expectedType} at arg ${i + 1}, got ${actualType}`, 
        node.args[i]
      );
    }
    
    this.IRB.emitExpr(expr);
  });
  
  this.IRB.declareOneTime(
    "zen_regex_match",
    "declare i32 @_zen_regex_match(ptr, ptr)"
  );
  
  const resultTemp = this.IRB.newTemp();
  
  this.IRB.emit(
    `${resultTemp} = call i32 @_zen_regex_match(ptr ${exprs[0].ptr}, ptr ${exprs[1].ptr})`
  );
  
  const finalPtr = this.IRB.newTemp();
  
  this.IRB.emit(
    `${finalPtr} = icmp eq i32 ${resultTemp}, 1`
  );
  
  return {
    ptr: finalPtr,
    type: "bool",
    llvmType: "i1",
    local: [],
    global: [],
    isVarRef: false
  };
}
}