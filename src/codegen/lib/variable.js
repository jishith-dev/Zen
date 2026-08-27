
export class Variable {
  constructor(IRB, expr, call, infer, struct) {
    this.IRB = IRB;
    this.expr = expr;
    this.call = call;
    this.infer = infer;
    this.struct = struct;
  }

  // scalar variable handling
  scalarVariable(node, globalScope) {
    const name = node.name;
    this.IRB.guardGlobal(name, node);
    const gName = this.IRB.newGlobalTemp();
    const lName = this.IRB.newTemp();
    let declaredType = node.dataType;
    const isReactive = node?.isReactive;
    if (declaredType === "auto") declaredType = this.infer.infer(node);

    const llvmType = this.IRB.getLLVMType(declaredType);

    const isConstant = node.isConstant;
    let ptr;

    this.IRB.bindLineColumn(node);

    if (isReactive) {
      
      const varRefs = this.IRB.collectVarRefs(node.value);
      this.IRB.reactiveMap.set(name, {
        deps: varRefs,
        expr: node.value,
      });

      for (const dep of varRefs) {
        if (this.IRB.hasPath(name, dep)) {
          this.IRB.emitError(
            "DeclarationError",
            `Circular reactive dependency detected between '${name}' and '${dep}'`,
            node,
          );
        }

        if (!this.IRB.dependents.has(dep)) {
          this.IRB.dependents.set(dep, []);
        }

        this.IRB.dependents.get(dep).push(name);
      }
    }

    const expr = this.expr.handleExpression(node.value, globalScope);

    if (this.IRB.isDeclaredInCurrentScope(name)) {
      this.IRB.emitError(
        "DeclarationError",
        `Variable '${name}' is already defined`,
        node,
      );
    }

    const actual = expr?.isList ? `List` : expr.type;

    const expected = declaredType;

    if (expr?.isList || declaredType !== expr.type) {
  this.IRB.emitError(
    "TypeError",
    `Cannot assign '${actual}' to variable '${name}' of type '${expected}'`,
    node,
  );
    }

    if (globalScope) {
      // global
      ptr = gName;

      const initialValue = this.IRB.initialValue(declaredType);

      if (expr?.kind === "literal") {
        this.IRB.globals.push(`${gName} = global ${llvmType} ${expr.ptr}`);
      } else {
        this.IRB.guardStackOp(`NON-CONSTANT VARIABLE ${name}`, node);
        this.IRB.globals.push(`${gName} = global ${llvmType} ${initialValue}`);
      }

      this.IRB.emitExpr(expr);

      if (expr?.kind !== "literal") {
        this.IRB.emit(`store ${llvmType} ${expr.ptr}, ptr ${gName}`);
      }
    } else {
      // local

      this.IRB.guardStackOp(`LOCAL_VARIABLE ${name}`, node);

      ptr = lName;

      this.IRB.emitAlloca(lName, `${llvmType}`);

      this.IRB.emitExpr(expr);

      this.IRB.emit(`store ${llvmType} ${expr.ptr}, ptr ${lName}`);
    }

    this.IRB.setVar(
      name,
      this.IRB.createData({
        ptr,
        llvmType,
        type: declaredType,
        isConstant,
        isReactive,
        isGlobal: globalScope,
        needsLoad: true,
      }),
    );
  }

  // string variable handling

  stringVariable(node, globalScope) {
    const name = node.name;
    this.IRB.guardGlobal(name, node);
    const gName = this.IRB.newGlobalTemp();
    const lName = this.IRB.newTemp();
    let declaredType = node.dataType;
    const isReactive = node?.isReactive;

    if (declaredType === "auto") {
      declaredType = this.infer.infer(node);
    }
    const llvmType = this.IRB.getLLVMType(declaredType);
    const isConstant = node.isConstant;
    let ptr;

    this.IRB.bindLineColumn(node);

    if (isReactive) {
      const varRefs = this.IRB.collectVarRefs(node.value);
      this.IRB.reactiveMap.set(name, {
        deps: varRefs,
        expr: node.value,
      });

      for (const dep of varRefs) {
        if (this.IRB.hasPath(name, dep)) {
          this.IRB.emitError(
            "DeclarationError",
            `Circular reactive dependency detected between '${name}' and '${dep}'`,
            node,
          );
        }

        if (!this.IRB.dependents.has(dep)) {
          this.IRB.dependents.set(dep, []);
        }

        this.IRB.dependents.get(dep).push(name);
      }
    }

    const expr = this.expr.handleExpression(node.value, globalScope);

    this.IRB.emitExpr(expr);

    const actual = expr?.isList ? `List` : expr.type;

    const expected = declaredType;

    if (expr?.isList || declaredType !== expr.type) {
      this.IRB.emitError(
        "TypeError",
        `Cannot assign '${actual}' to variable '${name}' of type '${expected}'`,
        node,
      );
    }

    if (globalScope) {
      // global scope
      ptr = gName;

      const isExported = this.IRB.exported;

      if (isExported) {
        this.IRB.globals.push(`${gName} = global ptr ${expr?.symbol}`);
      } else {
        this.IRB.globals.push(`${gName} = global ptr null`);
      }

      this.IRB.emit(`store ptr ${expr.ptr}, ptr ${gName}`);
    } else {
      // local scope

      this.IRB.guardStackOp(`LOCAL_VARIABLE ${name}`, node);
      ptr = lName;

      this.IRB.emitAlloca(lName, `ptr`);

      this.IRB.emit(`store ptr ${expr.ptr}, ptr ${lName}`);
    }

    this.IRB.setVar(
      name,
      this.IRB.createData({
        ptr,
        length: expr?.length,
        llvmType,
        type: declaredType,
        isConstant,
        isReactive,
        isGlobal: globalScope,
        rawStr: expr?.rawStr,
        needsLoad: true,
        ownerId: expr?.ownerId ? expr.ownerId : this.IRB.genOwnerId()
      }),
    );
  }

  // variable refference

  variableReference(node) {
    
    const expression = node?.expression;
    let name = expression.name;

    const isUnary = expression.value?.type === "UNARY_EXPRESSION";

    const isCall = expression.value?.type === "CALL";
    
    const isListLiteral = expression.value?.type === "ARRAY";

    const isMethodCall = !!node.expression?.callee;

    const isArrayReassignment = expression?.array; // fixed/List

    if (isMethodCall) {
      
      const fakeNode = {
        type: "MEMBER_ACCESS",
        field: expression.callee.field,
        object: expression.callee.object,
        args: expression.args,
        isAwait: expression.isAwait
      };

      const valExpr = this.expr.handleExpression(fakeNode);

      this.IRB.emitExpr(valExpr);
      return;
    }

    if (isArrayReassignment) {
      const { b } = this.IRB.getArrayChain(expression);

      if (b.type === "MEMBER_ACCESS") {
        return this.handleMemberArrayReassign(expression);
      }

      const base = this.IRB.getBaseArray(expression.array);

      const varInfo = this.IRB.getVar(base.name, node);

      if (base) {
        const isArrayType = varInfo.llvmType?.startsWith("[");
        const isZenList = varInfo?.isList;

        const isStringReassignment =
          varInfo.type === "string" && !isArrayType && !isZenList;

        if (isStringReassignment) {
          this.IRB.emitError(
            "ConstError",
            `Cannot reassign '${base.name}' — strings are immutable`,
            node,
          );
        }
      }

      this.IRB.bindLineColumn(node);

      const expr = this.expr.handleExpression(expression);

      this.IRB.emitExpr(expr);

      const valExpr = this.expr.handleExpression(expression.value);

      this.IRB.emitExpr(valExpr);

      if (varInfo.isList) {
        const generic = this.IRB.getDeepestGeneric(varInfo.generic);
        if (generic !== valExpr.type) {
          this.IRB.emitError(
            "TypeError",
            `List '${base.name}' expects element of type '${generic}', got '${valExpr.type}'`,
            node,
          );
        }
      }

      if (varInfo.isArray) {
        const type = varInfo.type;
        if (type !== valExpr.type) {
          this.IRB.emitError(
            "TypeError",
            `Array '${base.name}' expects element of type '${type}', got '${valExpr.type}'`,
            node,
          );
        }
      }

      if (this.IRB.hasStruct(valExpr.type)) {
    const struct = this.IRB.getStruct(valExpr.type);

    if (struct.isBuiltin && struct.isOpaque) {
        this.IRB.emit(`store ptr ${valExpr.ptr}, ptr ${expr.raw}`);
    } else {
        this.IRB.declareOneTime(
            "llvm.memcpy.p0.p0.i64",
            "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
        );

        this.IRB.emit(
            `call void @llvm.memcpy.p0.p0.i64(ptr ${expr.raw}, ptr ${valExpr.ptr}, i64 ${struct.byteSize}, i1 false)`
        );
    }
} else {
    this.IRB.emit(
        `store ${valExpr.llvmType} ${valExpr.ptr}, ptr ${expr.raw}`
    );
}
      return;
    }

    if (
      isUnary &&
      (expression.operator === "++" || expression.operator === "--")
    ) {
      return this.handleUnary(expression.value, true);
    }

    const getBaseName = (node) => {
      while (node?.type === "MEMBER_ACCESS") {
        node = node.object;
      }
      return node?.name;
    };

    if (expression.type === "MEMBER_ACCESS") {
      name = getBaseName(expression);
    }

    const orgData = this.IRB.getVar(name, node);
    

    if (isCall) {
      const isGlobal = orgData.isGlobal;
      return this.callVariable(this.IRB.normalizeNode(node), isGlobal);
    }

    if (orgData?.isStruct) {
     
      if (orgData.isConstant) {
      this.IRB.emitError(
        "ConstError",
        `Cannot reassign constant '${name}'`,
        node,
      );
    }
      
      this.IRB.bindLineColumn(node);

      let srcPtr;
      
      if (!expression?.value) {
        this.IRB.emitError("SyntaxError", `struct '${orgData.type}' property '${expression.field}' should have Right hand Assignment`, node)
      }

      if (expression.value.type === "STRUCT_LITERAL") {
      
      let t = this.IRB.emitStructLiteral(orgData.type, expression.value);

      srcPtr = t.ptr;

      } else {
        const rhs = this.expr.handleExpression(expression.value);
        
        if (!this.IRB.hasStruct(rhs.type)) {
  this.IRB.emitError(
    "TypeError",
    `right-hand side must be a struct, got '${rhs.type}'`,
    node
  );
}

        srcPtr = rhs.ptr;
      }

      const struct = this.IRB.getStruct(orgData.type);

      // BUILTIN POINTER STRUCT
      // Json, JsonArray, JsonObject, etc.
      if (struct?.isBuiltin && struct.isOpaque) {
        let t = this.IRB.newTemp();
        if (orgData.needsLoad) {
          this.IRB.emit(`${t} = load ptr, ptr ${srcPtr}`);
        } else {
          t = srcPtr;
        }

        this.IRB.emit(`store ptr ${t}, ptr ${orgData.ptr}`);

        return;
      }

      this.IRB.declareOneTime(
        "llvm.memcpy.p0.p0.i64",
        "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
      );

      this.IRB.emit(
        `call void @llvm.memcpy.p0.p0.i64(ptr ${orgData.ptr}, ptr ${srcPtr}, i64 ${struct.byteSize}, i1 false)`,
      );

      return;
    }

    const orgPtr = orgData.ptr;
    const orgType = orgData.type;
    const llvmType = orgData.llvmType;
    const isConstant = orgData.isConstant;

    if (isConstant) {
      this.IRB.emitError(
        "ConstError",
        `Cannot reassign constant '${name}'`,
        node,
      );
    }

    this.IRB.bindLineColumn(node);
    
    if (isListLiteral) {
  const wrapped = orgData.generic; 

  const listContext = {
    generic: wrapped.generic,                     
    type: this.IRB.getDeepestGeneric(wrapped),
    depth: this.IRB.getListDepth(wrapped),
  };

  const expr = this.expr.handleExpression(expression.value, false, listContext);

  this.IRB.emitExpr(expr);
  this.IRB.emit(`store ptr ${expr.ptr}, ptr ${orgPtr}`);
  
  // New ownership
orgData.ownerId = this.IRB.genOwnerId();
orgData.isFreed = false;
  return;
}

if (!expression.value) {
  this.IRB.emitError(
    "SemanticError",
    `'${expression.field}' is a method and must be called with '()'`,
    expression
  );
}

    const expr = this.expr.handleExpression(expression.value);

    if (orgData.type !== expr.type) {
      this.IRB.emitError(
        "TypeError",
        `Cannot assign '${expr.type}' to variable '${name}' of type '${orgType}'`,
        node,
      );
    }

    if (orgData.isList) {
      if (orgData.isList !== expr.isList) {
        this.IRB.emitError(
          "TypeError",
          `Cannot assign '${expr.isList ? "List" : expr.type}' to variable '${name}' of type '${orgData.isList ? "List" : "non-List"}'`,
          node,
        );
      }
    }

    this.IRB.emitExpr(expr);
  
  let v = this.IRB.newTemp();
  if (expr.needsLoad) {
    this.IRB.emit(`${v} = load ${llvmType}, ptr ${expr.ptr}`);
  } else {
    v = expr.ptr;
  }
  
  // new ownership
  orgData.ownerId = this.IRB.genOwnerId();
  orgData.isFreed = false;
  
  if (orgType === "string") {
  this.IRB.declareOneTime(
    "_zen_string_free",
    "declare void @_zen_string_free(ptr)"
  );

  const value = this.IRB.newTemp();

  this.IRB.emit(`${value} = load ptr, ptr ${orgPtr}`);
  this.IRB.emit(`call void @_zen_string_free(ptr ${value})`);
  }
  
    this.IRB.emit(`store ${llvmType} ${v}, ptr ${orgPtr}`);

    this.IRB.updateReactive(expression.name);
  }

  handleUnary(node, fromVarRef) {
    this.IRB.bindLineColumn(node);

    const expr = this.expr.handleExpression(node);

    this.IRB.emitExpr(expr);

    if (fromVarRef) {
      const ptr = this.IRB.getVar(node.argument.name, node).ptr;
      this.IRB.emit(`store ${expr.llvmType} ${expr.ptr}, ptr ${ptr}`);
    }
  }

  callVariable(node, globalScope) {
    
    const isVarDecl = node.type === "VARIABLE_DECLARATION";
    const isMethodCall = !!node.value?.callee;
    const name = node.name || node?.expression.name;
    let declaredType = node.dataType;
    if (declaredType === "auto") declaredType = this.infer.infer(node);

    if (isMethodCall) {
      const fakeNode = {
        type: "MEMBER_ACCESS",
        field: node.value.callee.field,
        object: node.value.callee.object,
        args: node.value.args,
        generic: node.value.generic
      };

      const valExpr = this.expr.handleExpression(fakeNode);

      const actual = valExpr?.isList ? `List` : valExpr.type;
      const expected = declaredType;

      if (valExpr?.isList || declaredType !== valExpr.type) {
        this.IRB.emitError(
          "TypeError",
          `Cannot assign '${actual}' to variable '${name}' of type '${expected}'`,
          node,
        );
      }

      this.IRB.emitExpr(valExpr);

      let ptr;
      if (globalScope) {
        if (isVarDecl) {
          ptr = this.IRB.newGlobalTemp();
          this.IRB.globals.push(
            `${ptr} = global ${valExpr.llvmType}  ${this.IRB.initialValue(valExpr.type)}`,
          );
        } else {
          const data = this.IRB.getVar(name, node);
          ptr = data.ptr;
        }
      } else {
        // local scope
        if (isVarDecl) {
          ptr = this.IRB.newTemp();
          this.IRB.emitAlloca(ptr, `${valExpr.llvmType}`);
        } else {
          const data = this.IRB.getVar(name, node);
          ptr = data.ptr;
        }
      }

      if (this.IRB.hasStruct(valExpr.type)) {
        const structInfo = this.IRB.getStruct(valExpr.type);
        if (structInfo.isBuiltin && structInfo.isOpaque) {
          this.IRB.emit(`store ptr ${valExpr.ptr}, ptr ${ptr}`);
        } else {
          const size = structInfo.byteSize;
          this.IRB.declareOneTime(
            "llvm.memcpy",
            "declare void @llvm.memcpy(ptr, ptr, i64, i1)",
          );
          this.IRB.emit(
            `call void @llvm.memcpy(ptr ${ptr}, ptr ${valExpr.ptr}, i64 ${size}, i1 false)`,
          );
        }
      } else {
        
        this.IRB.emit(`store ${valExpr.llvmType} ${valExpr.ptr}, ptr ${ptr}`);
      }

      const isConstant = isVarDecl
        ? node.isConstant
        : this.IRB.getVar(name, node).isConstant;

      if (!isVarDecl) return;

      this.IRB.setVar(
        node.name,
        this.IRB.createData({
          ptr,
          llvmType: valExpr.llvmType,
          type: valExpr.type,
          isConstant,
          isGlobal: globalScope,
          needsLoad: true,
        }),
      );
      return;
    }

    this.IRB.guardGlobal(name, node);
    let dataType = node.dataType;
    if (dataType === "auto") {
      dataType = this.infer.infer(node);
    }

    const llvmType = this.IRB.getLLVMType(dataType);

    this.IRB.bindLineColumn(node);

    const val = this.expr.handleExpression(node.value, globalScope);
    
    this.IRB.emitExpr(val)

    // void check
    if (val?.returnType === "void") {
      this.IRB.emitError(
        "TypeError",
        `Cannot assign result of '${node.value.name}' — function returns void`,
        node,
      );
    }

    if (val.type !== dataType) {
      this.IRB.emitError(
        "TypeError",
        `Cannot assign '${val.type}' to variable '${name}' of type '${dataType}'`,
        node,
      );
    }

    let ptr;
    let value = this.IRB.initialValue(dataType);

    if (globalScope) {
      if (isVarDecl) {
        
        ptr = this.IRB.newGlobalTemp();
        this.IRB.globals.push(`${ptr} = global ${llvmType} ${value}`);
      } else {
        const data = this.IRB.getVar(name, node);
        ptr = data.ptr;
        
      }
    } else {
      if (isVarDecl) {
        ptr = this.IRB.newTemp();
        this.IRB.emitAlloca(ptr, `${llvmType}`);
      } else {
        const data = this.IRB.getVar(name, node);
        ptr = data.ptr;
      }
    }

    const isList = val?.isList;
    
    const isStruct = val?.isStruct;

    if (isList) {
      this.IRB.emit(`store ptr ${val.ptr}, ptr ${ptr}`);
    } else if (this.IRB.hasStruct(val.type)) {
      if (val?.fromParam) {
        this.IRB.emit(`store ptr ${val.ptr}, ptr ${ptr}`);
      } else {
        const structInfo = this.IRB.getStruct(val.type);
        if (structInfo.isBuiltin && structInfo.isOpaque) {
          // opaque handle (HttpServer, HttpRequest, ...)
         
         
    if (isVarDecl) {
        let tmp;

        if (globalScope) {
            tmp = this.IRB.newGlobalTemp();
            this.IRB.globals.push(`${tmp} = global ptr null`);
        } else {
            tmp = this.IRB.newTemp();
            this.IRB.emitAlloca(tmp, `ptr`);
        }

        this.IRB.emit(`store ptr ${val.ptr}, ptr ${tmp}`);
        ptr = tmp;
    } else {
        // Assignment reuse existing storage
        this.IRB.emit(`store ptr ${val.ptr}, ptr ${ptr}`);
    }
         
         
        } else {
          const size = this.IRB.getStruct(val.type).byteSize;

          this.IRB.declareOneTime(
            "llvm.memcpy",
            "declare void @llvm.memcpy(ptr, ptr, i64, i1)",
          );

          this.IRB.emit(
            `call void @llvm.memcpy(ptr ${ptr}, ptr ${val.ptr}, i64 ${size}, i1 false)`,
          );
        }
      }
    } else {
      this.IRB.emit(`store ${llvmType} ${val.ptr}, ptr ${ptr}`);
    }

    if (!isVarDecl) return;

    this.IRB.setVar(
      name,
      this.IRB.createData({
        ptr,
        llvmType: isList || isStruct ? "ptr" : llvmType,
        type: dataType,
        isConstant: false,
        isGlobal: globalScope,
        needsLoad: true,
        isList,
        isStruct,
      }),
    );
  }

  arrayVariable(node, globalScope) {
    const { name, isConstant, dimensions, value } = node;

    let dataType = node.dataType;
    if (dataType === "auto") {
      dataType = this.infer.infer(node);
    }
    this.IRB.guardGlobal(name, node);
    const llvmType = this.IRB.getLLVMType(dataType);
    const dimSizes = dimensions.map((d) => d.value);

    const init = this.IRB.arrayInit(
      name,
      dimensions,
      value,
      globalScope,
      llvmType,
      dataType,
      isConstant,
    );

    const ir = init.ir.length ? init.ir.join("\n") : null;
    if (ir) globalScope ? this.IRB.globals.push(ir) : this.IRB.emit(ir);

    this.IRB.setVar(
      name,
      this.IRB.createData({
        ptr: init.ptr,
        llvmType: init.llvmType,
        type: dataType,
        internalType: `array<${dataType}>`,
        length: init.length,
        isConstant,
        isGlobal: globalScope,
        postOrPrefix: false,
        isArray: true,
        dimensions: dimensions.length,
        dimensionsData: dimSizes,
      }),
    );
  }

  arrayAccessVariable(node, globalScope) {
    const { name, isConstant, value } = node;
    
    let dataType = node.dataType;
    if (dataType === "auto") {
      dataType = this.infer.infer(node);
    }
    this.IRB.guardGlobal(name, node);
    const llvmType = this.IRB.getLLVMType(dataType);
    const ptr = globalScope ? this.IRB.newGlobalTemp() : this.IRB.newTemp();

    this.IRB.bindLineColumn(node);
    const expr = this.expr.handleExpression(value);

    if (globalScope) {
      // global
      const initialValue = this.IRB.initialValue(dataType);

      this.IRB.globals.push(`${ptr} = global ${llvmType} ${initialValue}`);
    } else {
      this.IRB.emitAlloca(ptr, `${llvmType}`);
    }

    this.IRB.emitExpr(expr);

    if (this.IRB.hasStruct(expr.type)) {
    const structInfo = this.IRB.getStruct(expr.type);

    if (structInfo.isBuiltin && structInfo.isOpaque) {
        this.IRB.emit(`store ptr ${expr.ptr}, ptr ${ptr}`);
    } else {
        const size = structInfo.byteSize;

        this.IRB.declareOneTime(
            "llvm.memcpy",
            "declare void @llvm.memcpy(ptr, ptr, i64, i1)",
        );

        this.IRB.emit(
            `call void @llvm.memcpy(ptr ${ptr}, ptr ${expr.ptr}, i64 ${size}, i1 false)`
        );
    }
} else {
    this.IRB.emit(`store ${expr.llvmType} ${expr.ptr}, ptr ${ptr}`);
}

    this.IRB.setVar(
      name,
      this.IRB.createData({
        ptr,
        llvmType,
        type: dataType,
        isConstant,
        isGlobal: globalScope,
        postOrPrefix: false,
        isArray: false,
        needsLoad: true,
      }),
    );
  }

  handleMemberArrayReassign(exprNode) {
    const { b, indices } = this.IRB.getArrayChain(exprNode);

    // resolve base

    let basePtr;
    let llvmType;

    if (b.type === "MEMBER_ACCESS") {
      
      const { base: root, fields } = this.IRB.resolveMemberChainAssign(b);

      const varInfo = this.IRB.getVar(root, exprNode);

      basePtr = varInfo.ptr;
      let structName = varInfo.type;

      // walk struct chain
      for (let f of fields) {
        const structInfo = this.IRB.getStruct(structName);

        if (!structInfo) {
          this.IRB.emitError(
            "TypeError",
            `Cannot access field '${f}' on non-struct type '${structName}'`,
            exprNode,
          );
        }

        const idx = structInfo.fieldMap[f];

        const isList = structInfo.layout[idx]?.isList;

        if (isList) {
          const baseExpr = this.expr.handleExpression(b);

          this.IRB.emitExpr(baseExpr);

          const t = this.IRB.newTemp();
          this.IRB.emit(`${t} = load ptr, ptr ${baseExpr.ptr}`);

          let currentPtr = t;

          let tmp;
          for (let i = 0; i < indices.length; i++) {
            const v = indices[i];

            const indexExpr = this.expr.handleExpression(v);

            this.IRB.emitExpr(indexExpr);

            // LIST INDEX ACCESS

            this.IRB.declareOneTime(
              "zen_list_get",
              "declare ptr @_zen_list_get(ptr, i32)",
            );

            tmp = this.IRB.newTemp();

            this.IRB.emit(
              `${tmp} = call ptr @_zen_list_get(ptr ${currentPtr}, i32 ${indexExpr.ptr})`,
            );

            const isLast = i === indices.length - 1;

            if (!isLast) {
              const loaded = this.IRB.newTemp();

              this.IRB.emit(`${loaded} = load ptr, ptr ${tmp}`);

              currentPtr = loaded;
            }
          }

          const valueExpr = this.expr.handleExpression(exprNode.value);

          this.IRB.emitExpr(valueExpr);
          
          if (this.IRB.hasStruct(valueExpr.type)) {
  const struct = this.IRB.getStruct(valueExpr.type);

  if (struct.isBuiltin && struct.isOpaque) {
    this.IRB.emit(`store ptr ${valueExpr.ptr}, ptr ${tmp}`);
  } else {
    this.IRB.declareOneTime(
      "llvm.memcpy.p0.p0.i64",
      "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
    );

    this.IRB.emit(
      `call void @llvm.memcpy.p0.p0.i64(ptr ${tmp}, ptr ${valueExpr.ptr}, i64 ${struct.byteSize}, i1 false)`
    );
  }
} else {
  this.IRB.emit(
    `store ${valueExpr.llvmType} ${valueExpr.ptr}, ptr ${tmp}`
  );
}


          return;
        }

        if (idx === undefined) {
          this.IRB.emitError(
            "ReferenceError",
            `Field '${f}' does not exist in struct '${structName}'`,
            exprNode,
          );
        }

        const ptr = this.IRB.newTemp();

        this.IRB.emit(
          `${ptr} = getelementptr %${structName}, %${structName}* ${basePtr}, i32 0, i32 ${idx}`,
        );

        basePtr = ptr;

        const fieldInfo = structInfo.layout[idx];

        structName = fieldInfo.type;
        llvmType = fieldInfo.llvmType;
      }
    } else if (b.type === "variable") {
      const varInfo = this.IRB.getVar(b.name, exprNode);
      basePtr = varInfo.ptr;
      llvmType = varInfo.llvmType;
    } else {
      this.IRB.emitError(
        "TypeError",
        `Invalid assignment target — expected an array variable`,
        exprNode,
      );
    }

    let currentPtr = basePtr;
    let currentType = llvmType;

    for (let idxNode of indices) {
      const idxExpr = this.expr.handleExpression(idxNode);

      this.IRB.emitExpr(idxExpr);

      const elemPtr = this.IRB.newTemp();

      this.IRB.emit(
        `${elemPtr} = getelementptr ${currentType}, ${currentType}* ${currentPtr}, i32 0, i32 ${idxExpr.ptr}`,
      );

      // shrink type: eg [2 x [2 x i32]] [2 x i32] - i32
      currentType = this.IRB.getArrayElementType(currentType);

      currentPtr = elemPtr;
    }

    const valExpr = this.expr.handleExpression(exprNode.value);

    this.IRB.emitExpr(valExpr);

    this.IRB.emit(
      `store ${valExpr.llvmType} ${valExpr.ptr}, ptr ${currentPtr}`,
    );
  }
}
