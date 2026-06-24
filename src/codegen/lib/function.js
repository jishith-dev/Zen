export class HandleFunction {
  constructor(IRB, expr, block, infer) {
    this.IRB = IRB;
    this.block = block;
    this.expr = expr;
    this.infer = infer;
    this.haveBareRet = false;
  }
  
  collectReturns(node) {
    if (!node) return;
    
    switch (node.type) {
      
      case "RETURN": {
        if (!node.value) {
          this.IRB.currentFunction.returnTypes.push("void");
          
        } else {
          const type = this.infer.infer(node.value);
        
          this.IRB.currentFunction.returnTypes.push(type);
        }
        return;
      }
      
      case "BLOCK":
        for (const stmt of node.body) {
          this.collectReturns(stmt);
        }
        return;
        
      case "CONDITIONAL":
        this.collectReturns(node.if?.body);
        
        for (const elif of node.elseIf || []) {
          this.collectReturns(elif.body);
        }
        
        if (node.else) {
          this.collectReturns(node.else.body);
        }
        return;
        
      default:
        // fallback deep scan (safe for nested expressions/statements)
        for (const key in node) {
          const child = node[key];
          if (typeof child === "object") {
            this.collectReturns(child);
          }
        }
    }
  }
  
  hasGuaranteedReturn(node) {
    if (!node) return false;
    
    switch (node.type) {
      
      case "RETURN":
        return true;
        
      case "BLOCK":
        for (const stmt of node.body) {
          if (this.hasGuaranteedReturn(stmt)) {
            return true;
          }
        }
        return false;
        
      case "CONDITIONAL": {
        
        if (!node.else) return false;
        
        const ifRet =
          this.hasGuaranteedReturn(node.if.body);
        
        const elifRet =
          (node.elseIf || []).every(
            e => this.hasGuaranteedReturn(e.body)
          );
        
        const elseRet =
          this.hasGuaranteedReturn(node.else.body);
        
        return ifRet && elifRet && elseRet;
      }
      
      default:
        return false;
    }
  }
  
  
  handleReturn(node) {
    
    if (this.IRB.currentFunction === null) {
      this.IRB.emitError("SemanticError", "return outside function", node);
    }
    
    // bare return without 'return'
    if (node.value.length === 0) {
      this.haveBareRet = true;
      this.IRB.emit(`ret void`);
      return;
    }
    
    const currentFunction = this.IRB.currentFunction;
    const name = currentFunction.name;
    const first = this.IRB.currentFunction.returnTypes[0];
    
    // infer block
    if (this.IRB.currentFunction.returnType === "auto") {
      
      this.collectReturns(this.IRB.currentFunction.bodyAst);
    
      const totalReturns = currentFunction.returnTypes.length;
      
      const isSameType = currentFunction.returnTypes.every(type => type === first)
      
      if (!isSameType) {
        
        const bad = currentFunction.returnTypes.find(t => t !== first);
        
        this.IRB.emitError(
          "TypeError",
          `deduced conflicting return types for 'auto': '${first}' vs '${bad}'`,
          node
        );
      }
      
      const retType = first;
      
      const fn = this.IRB.getFunction(name);
      
      // update return type
      
      fn.returnType = retType;
      
      this.IRB.currentFunction.returnType = retType;
      
      if (node.value.type === "CALL") {
        const fn = this.IRB.getFunction(node.value.name);
        
        fn.returnType.type = retType;
      }
      const llvmReturnType = this.IRB.getLLVMType(retType);
      
      this.IRB.currentFunction.body.unshift(this.IRB.currentFunction.local.join("\n"));
      this.IRB.currentFunction.body.unshift(`define ${llvmReturnType} @${this.IRB.currentFunction.mangledName} ${this.IRB.currentFunction.paramsIr} { \n entry:`);
    }
    
    
    
    const funcType = this.IRB.currentFunction.returnType;
    
    this.IRB.currentFunction.hasReturn = true;
    
    if (funcType === "void") {
      this.IRB.emit("ret void");
      return;
    }
    
    // STRUCT RETURN
    if (this.IRB.hasStruct(funcType)) {
  const params = this.IRB.currentFunction.params;
  const struct = this.IRB.getStruct(funcType);
  
  let expr = null;
  
  if (node.value.type === "MAP_LITERAL") {
    expr = {
      isStruct: true,
      type: funcType
    }
    
    const ptr = this.IRB.emitStructLiteral(funcType, node.value)
    
    expr.ptr = ptr;
    
  } else {
  expr = this.expr.handleExpression(node.value);
  this.IRB.emitExpr(expr);
  }
  
  if (expr?.isStruct && this.IRB.hasStruct(expr.type)) {
    
    this.IRB.declareOneTime(
      "llvm.memcpy.p0.p0.i64",
      "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)"
    );
    this.IRB.emit(
      `call void @llvm.memcpy.p0.p0.i64(ptr %sret, ptr ${expr.ptr}, i64 ${struct.byteSize}, i1 false)`
    );
  }
  
  
  if (params) {
    
    const returnedVarName = node.value.name; 
    
    // Find parameter matching the returned variable name
    let srcPtr = null;
    if (this.IRB.hasVar(returnedVarName)) {
      srcPtr = this.IRB.getVar(returnedVarName).ptr;
    }
    
    if (srcPtr) {
      const size = struct.byteSize;
      
      this.IRB.declareOneTime(
        "llvm.memcpy.p0.p0.i64",
        "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)"
      );
      
      this.IRB.emit(
        `call void @llvm.memcpy.p0.p0.i64(` +
        `ptr %sret, ptr ${srcPtr}, i64 ${size}, i1 false)`
      );
      this.IRB.emit("ret void");
      return;
    }
  }
  
  // Just emit ret (sret already populated by prior stores)
  this.IRB.emit("ret void");
  return;
}
    
    const expr = this.expr.handleExpression(node.value, false);
    
    this.IRB.emitExpr(expr);
    
    if (expr.llvmType?.startsWith("[")) {
      this.IRB.emitError(
        "TypeError",
        `function ${name} cannot return array`, node)
    }
    
    if (expr?.isList) {
      if (!this.IRB.currentFunction.isList) {
        this.IRB.emitError("TypeError", `function ${name} expected ${funcType} but got ${expr.type}`, node);
      }
      
      if (expr?.fromParam || expr?.isListLiteral) {
        // param already holds list pointer
        this.IRB.emit(`ret ptr ${expr.ptr}`);
      }
      else {
        // local variable (stack slot) needs load
        const t = this.IRB.newTemp();
        this.IRB.emit(`${t} = load ptr, ptr ${expr.ptr}`);
        this.IRB.emit(`ret ptr ${t}`);
      }
      
      return;
    }
    
    if (expr.isMap) {
      if (node.value.type !== "variable") {
        this.IRB.emitError("SemanticError", "only Map reference can return", node);
      }
      let loaded;
      
      if (expr.needsLoad) {
        loaded = this.IRB.newTemp();
        
        this.IRB.emit(
          `${loaded} = load ptr, ptr ${expr.ptr}`
        );
        
      } else {
        loaded = expr.ptr;
      }
      this.IRB.emit(`ret ptr ${loaded}`);
      
      const layout = expr.layout;
      
      this.IRB.functions.get(name).layout = layout;
      return;
    }
    
    
    // type check 
    if (expr.type !== funcType) {
      this.IRB.emitError("TypeError", `function ${name} expected ${funcType} but got ${expr.type}`, node);
    }
    
    this.IRB.emit(`ret ${expr.llvmType} ${expr.ptr}`);
    
  }
  
  handleFunction(node) {
    
    if (node.name === "main") {
      this.IRB.emitError(
        "ReservedFunctionError",
        "'main' is a reserved function name", node
      );
    }
    
    this.haveBareRet = false; 
    
    this.IRB.funcTempCounter = 0; // reset counter per function 
    
    if (this.IRB.currentFunction !== null) {
      this.IRB.emitError("SemanticError", "Nested functions are not supported", node);
    }
    
    const isMethod = node?.isMethod;
    
    const prevFunction = this.IRB.currentFunction;
    
    let local = []
    
    let name;
    let mangledName;
    if (isMethod) {
      name = `${node.structName}_${node.name}`;
      mangledName = name;
    } else {
      name = node.name;
      if (this.IRB.stdlibMode) {
      mangledName = name;
      } else {
        mangledName = `zen_${name}`;
      }
    }
    
    
    
    let returnType = node.returnType === "void" ?
      "void" :
      node.returnType.type; // exclude auto infer for now
    
    if (
      returnType !== "void" &&
      !this.hasGuaranteedReturn(node.body)
    ) {
      this.IRB.emitError(
        "SemanticError",
        `not all code paths return a value`,
        node
      );
    }
    
    let llvmReturnType = returnType === "void" ?
      "void" : this.IRB.getLLVMType(returnType); // exclude auto for now
      
    const isSret = this.IRB.hasStruct(returnType);
    
    if (isSret) {
      llvmReturnType = "void";
    }
    
    const params = node.params;
  
   this.IRB.currentFunction = true; // make currentFunction true for getting sequential temp count for params
    
    const { ir, params: paramData } = this.IRB.buildParams(params, isMethod, returnType);
    
    this.IRB.currentFunction = {
      name,
      mangledName,
      body: [],
      bodyAst: node.body,
      isList: returnType === "List",
      returnType, // temporarily store return type even its auto
      params: paramData,
      hasReturn: false,
      isAsync: node.isAsync,
      returnTypes: [],
      paramsIr: ir,
      local
    };
    
    this.IRB.enterScope();
    
    // do not make function signature if it's auto
    if (returnType !== "auto") {
      
      this.IRB.emit(`define ${llvmReturnType} @${mangledName} ${ir} {`);
      this.IRB.emit("entry:");
    }
    
    for (const p of paramData) {
      
      if (p.isList) {
        
        this.IRB.declareOneTime(
          "zen_list_new",
          "declare ptr @_zen_list_new(i64)"
        );
        
        this.IRB.declareOneTime(
          "zen_list_get",
          "declare ptr @_zen_list_get(ptr, i32)"
        );
        
        this.IRB.declareOneTime(
          "ZenList",
          `%ZenList = type { ptr, i32, i32, i64 }`
        );
        
        const deepestType =
          this.IRB.getDeepestType(p.generic);
        
        this.IRB.setVar(p.name, this.IRB.createData({
          ptr: p.ptr,
          llvmType: p.llvmType,
          generic: p.generic,
          type: deepestType,
          isConstant: false,
          isGlobal: false,
          isList: true,
          fromParam: true,
          needsLoad: false
        }));
      } else if (p?.isMethod) {
        
        
        this.IRB.setVar(p.name, this.IRB.createData({
          ptr: p.ptr,
          llvmType: p.llvmType,
          type: p.type,
          isConstant: false,
          isGlobal: false,
          fromParam: true,
          isStruct: true
        }));
      } else if (p?.isStruct) {

  const struct = this.IRB.getStruct(p.type);

  const localPtr = `%${p.name}.addr`;

  local.push(`${localPtr} = alloca %${p.type}`);

  this.IRB.declareOneTime(
    "llvm.memcpy.p0.p0.i64",
    "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)"
  );

  local.push(
    `call void @llvm.memcpy.p0.p0.i64(` +
    `ptr ${localPtr}, ptr ${p.ptr}, i64 ${struct.byteSize}, i1 false)`
  );

  this.IRB.setVar(p.name, this.IRB.createData({
    ptr: localPtr,
    llvmType: p.llvmType,
    type: p.type,
    isConstant: false,
    isGlobal: false,
    fromParam: true,
    isStruct: true
  }));
}
      else if (p.isRest) {
        
        this.IRB.declareOneTime(
          "ZenList",
          "%ZenList = type { ptr, i32, i32, i64 }"
        );
        // update symbol table
        this.IRB.setVar(p.name, this.IRB.createData({
          ptr: p.ptr,
          llvmType: "ptr",
          type: p.type,
          generic: { generic: { type: p.type } },
          isConstant: false,
          isGlobal: false,
          isList: true,
          needsLoad: false,
          fromParam: true
        }));
        
      }
      // Map as fn param is disabled in v1
      /* else if (p.isMap) {
        this.IRB.setVar(p.name, this.IRB.createData({
          ptr: p.ptr,
          llvmType: "ptr",
          type: "ptr",
          isConstant: false,
          isGlobal: false,
          isMap: true,
          fromParam: true,
          needsLoad: false
        }));
      } */
      else {
        let ptr = `%${p.name}.addr`;
        
        // alloca
        local.push(`${ptr} = alloca ${p.llvmType}`); // always push to local for infering
        
        // store incoming param (p.temp)
        local.push(`store ${p.llvmType} ${p.temp}, ptr ${ptr}`);
        
       // const t = this.IRB.newTemp()
       // local.push(`${t} = load ${p.llvmType}, ptr ${ptr}`);
        
        
        // update symbol table
        this.IRB.setVar(p.name, this.IRB.createData({
          ptr, 
          llvmType: p.llvmType,
          type: p.type,
          isConstant: false,
          isGlobal: false,
          needsLoad: true,
          fromParam: true
        }));
      }
    }
    
    if (returnType !== "auto") {
      this.IRB.emit(local.join("\n"))
    }
    
    this.block.block(node.body, false);
    
    
    if (!this.hasGuaranteedReturn(node.body)) {
      if (returnType === "int") {
        this.IRB.emit("ret i32 0");
      } else if (returnType === "bool") {
        this.IRB.emit("ret i1 0");
      } else if (returnType === "double") {
        this.IRB.emit("ret double 0.0");
      } else if (returnType === "string") {
        this.IRB.emit("ret ptr null");
      } else {
        this.IRB.emit("ret void");
      }
    }
    
    this.IRB.emit("}");
    
    this.IRB.exitScope();
    
    this.IRB.functionBuff.push(this.IRB.currentFunction.body.join("\n"));
    
    this.IRB.currentFunction = prevFunction;
    
  }
}