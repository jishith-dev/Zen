export class Struct {
  constructor(IRB, expr, fn) {
    this.IRB = IRB;
    this.expr = expr;
    this.fn = fn;
  }

  registerStructMethods(structNode) {
    const structName = structNode.name;
    this.IRB.currentStruct = structName;
    for (const method of structNode.methods) {
      const fnName = `${structName}_${method.name}`;

      const returnType =
        method.returnType === "void" ? "void" : method.returnType.type;

      const isArrayRet =
        returnType === "void"
          ? false
          : returnType === "List"
            ? false
            : method.returnType?.dimensions.length > 0;
      const retGeneric =
        returnType === "List"
          ? this.IRB.getDeepestGeneric(method.returnType.generic)
          : returnType;
      const generic = returnType === "List" ? method.returnType : null;

      if (isArrayRet)
        this.IRB.emitError(
          "SemanticError",
          `function ${method.name} cannot return array`,
          method,
        );

      this.IRB.functions.set(fnName, {
        name: fnName,
        params: method.params,
        returnType: method.returnType,
        isMethod: true,
        retGeneric,
        generic: generic,
        struct: structName,
        isAsync: method.isAsync,
        isThread: method.isThread,
      });
    }
  }

  generateMethods(node) {
    const name = node.name;

    for (const method of node.methods) {
      method.structName = name;
      this.fn.handleFunction(method);
    }
  }

  struct(node, globalScope) {
    const name = node.name;
    const fields = node.fields;
    const isMethod = node?.methods?.length > 0;

    const layout = [];
    const fieldMap = {};
    const llvmFields = [];

    for (let i = 0; i < fields.length; i++) {
      const f = fields[i];

      this.IRB.validateStandaloneType(f.type, node);

      let llvmType;

      // ARRAY FIELD
      if (f.dimensions && f.dimensions.length > 0) {
        const dims = f.dimensions.map((d) => d.value ?? d);

        const { full } = this.IRB.buildArrayType(
          this.IRB.getLLVMType(f.type),
          dims,
        );

        llvmType = full;
      }

      // NORMAL FIELD
      else {
        llvmType = this.IRB.getLLVMType(f.type);
      }

      let type;
      if (f.type === "List") {
        type = this.IRB.getDeepestGeneric(f.generic);
      } else {
        type = f.type;
      }

      layout.push({
        name: f.name,
        type: type,
        isList: f.type === "List",
        generic: {
          type: "List",
          generic: f?.generic,
        },
        llvmType,
        index: i,
        dimensions: f.dimensions || [],
      });

      fieldMap[f.name] = i;
      llvmFields.push(llvmType);
    }

    this.IRB.globals.push(`%${name} = type { ${llvmFields.join(", ")} }`);

    this.IRB.setStruct(name, {
      isGlobal: globalScope,
      layout,
      isBuiltin: false,
      isOpaque: false,
      fieldMap,
      size: fields.length,
    });

    this.IRB.getStruct(name).byteSize = this.IRB.sizeOf(name);
    this.IRB.getStruct(name).align = this.IRB.alignOf(name);

    if (isMethod) {
      this.registerStructMethods(node);
      if (!this.IRB.hasVar("this")) {
        this.IRB.setVar(
          "this",
          this.IRB.createData({
            ptr: "%this",
            type: name,
            llvmType: `%${name}*`,
            isStruct: true,
          }),
        );
      }

      this.generateMethods(node);
    }

    return;
  }

  structRef(node, globalScope) {
    const structName = node.struct_ref;
    const varName = node.name;
    const value = node.value;

    this.IRB.validateStandaloneType(structName, node);

    const structInfo = this.IRB.getStruct(structName);
    const llvmType = `%${structName}`;
    const isOpaque = structInfo.isBuiltin && structInfo.isOpaque;

    let ptr;
    let isRet = false;
    let ownerId;

    if (value?.type === "STRUCT_LITERAL") {
      this.IRB.guardStackOp(`STRUCT_INSTANCE - ${structName}`);

      let t = this.IRB.emitStructLiteral(structName, value, globalScope);

      ptr = t.ptr;
    } else if (value === null) {
      ptr = this.IRB.allocStructStorage(structInfo, structName, globalScope);
    } else {
      this.IRB.guardStackOp(`STRUCT_INSTANCE - ${structName}`);
      const expr = this.expr.handleExpression(value);

      this.IRB.emitExpr(expr);

      ownerId = expr?.ownerId;

      const needAllocate = expr.type !== "Map";

      ptr = this.IRB.allocStructStorage(
        structInfo,
        structName,
        globalScope,
        needAllocate,
      );

      if (isOpaque) {
        let valuePtr = expr.ptr;

        if (expr.needsLoad) {
          const loaded = this.IRB.newTemp();
          this.IRB.emit(`${loaded} = load ptr, ptr ${expr.ptr}`);
          valuePtr = loaded;
        }

        this.IRB.emit(`store ptr ${valuePtr}, ptr ${ptr}`);
      } else {
        this.IRB.declareOneTime(
          "llvm.memcpy.p0.p0.i64",
          "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
        );
        this.IRB.emit(
          `call void @llvm.memcpy.p0.p0.i64(` +
            `ptr ${ptr}, ptr ${expr.ptr}, i64 ${structInfo.byteSize}, i1 false)`,
        );
      }
    }

    this.IRB.setVar(
      varName,
      this.IRB.createData({
        ptr,
        type: structName,
        llvmType,
        isConstant: node.isConstant,
        isStruct: true,
        isGlobal: globalScope,
        isVarRef: true,
        needsLoad: true,
        isRet,
        ownerId,
      }),
    );
  }

  assignStruct(node) {
    const { base, fields } = this.IRB.resolveMemberChainAssign(node.object);
    const lastField = node.field;

    let variable;
    if (base === "this") {
      variable = this.IRB.getVar("this");
    } else if (typeof base === "object") {
      variable = this.expr.handleExpression(base);
      this.IRB.emitExpr(variable);
    } else {
      variable = this.IRB.getVar(base);
    }

    // struct assign

    if (!variable || !variable.isStruct) {
      this.IRB.emitError("ReferenceError", `'${base}' is not a struct`, node);
    }

    let structName = variable.type;
    let basePtr = variable.ptr;

    // WALK THROUGH CHAIN

    for (let i = 0; i < fields.length; i++) {
      const structInfo = this.IRB.getStruct(structName);
      const fieldIndex = structInfo.fieldMap[fields[i]];

      if (fieldIndex === undefined) {
        this.IRB.emitError(
          "ReferenceError",
          `Unknown field '${fields[i]}' in struct '${structName}'`,
          node,
        );
      }

      const ptr = this.IRB.newTemp();

      this.IRB.emit(
        `${ptr} = getelementptr %${structName}, %${structName}* ${basePtr}, i32 0, i32 ${fieldIndex}`,
      );

      const fieldMeta = structInfo.layout[fieldIndex];

      basePtr = ptr;

      structName = fieldMeta.type;
    }

    // FINAL FIELD

    const structInfo = this.IRB.getStruct(structName);

    const fieldIndex = structInfo.fieldMap[lastField];
    const isList = structInfo.layout[fieldIndex]?.isList;
    const fieldMeta = structInfo.layout[fieldIndex];

    if (fieldIndex === undefined) {
      this.IRB.emitError(
        "ReferenceError",
        `Unknown field '${lastField}' in struct '${structName}'`,
        node,
      );
    }

    const value = this.expr.handleExpression(node.value, false, fieldMeta.type);

    const expected = fieldMeta?.type;
    const expectedIsList = fieldMeta?.isList;
    const fieldName = fieldMeta?.name;

    if (fieldMeta.llvmType?.startsWith("[")) {
      this.IRB.emitError(
        "SemanticError",
        `struct field '${structName}.${fieldName}' is a fixed-size array and cannot be assigned using an array literal; assign elements individually using index assignment`,
        node,
      );
    }

    // list mismatch
    if (expectedIsList !== !!value?.isList) {
      this.IRB.emitError(
        "TypeError",
        `cannot assign ${value?.isList ? "List" : value.type} to struct field '${structName}.${fieldName}' of type ${expectedIsList ? "List" : expected}`,
        node,
      );
    }

    // normal type mismatch
    if (!expectedIsList && expected !== value.type) {
      this.IRB.emitError(
        "TypeError",
        `cannot assign value of type '${value.type}' to struct field '${structName}.${fieldName}' of type '${expected}'`,
        node,
      );
    }

    this.IRB.emitExpr(value);

    const rhs = value;

    const finalPtr = this.IRB.newTemp();

    this.IRB.emit(
      `${finalPtr} = getelementptr %${structName}, %${structName}* ${basePtr}, i32 0, i32 ${fieldIndex}`,
    );

    // STRUCT COPY

    const isStructCopy =
      rhs.isVarRef &&
      rhs.isStruct &&
      this.IRB.getStruct(rhs.type) &&
      rhs.type === structInfo.layout[fieldIndex].type;

    if (isStructCopy) {
      const dstPtr = finalPtr;
      const srcPtr = rhs.ptr;

      const struct = this.IRB.getStruct(rhs.type);
      const size = struct.byteSize;

      this.IRB.declareOneTime(
        "llvm.memcpy.p0.p0.i64",
        "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
      );

      this.IRB.emit(
        `call void @llvm.memcpy.p0.p0.i64(` +
          `ptr ${dstPtr}, ptr ${srcPtr}, i64 ${size}, i1 false)`,
      );

      return;
    }

    // NORMAL VALUE STORE

    const llvmType = this.IRB.getLLVMType(structInfo.layout[fieldIndex].type);

    if (llvmType === "ptr" || isList) {
      let ptrValue = value.ptr;

      if (value.needsLoad) {
        ptrValue = this.IRB.newTemp();
        this.IRB.emit(`${ptrValue} = load ptr, ptr ${value.ptr}`);
      }

      this.IRB.emit(`store ptr ${ptrValue}, ptr ${finalPtr}`);
    } else {
      this.IRB.emit(`store ${llvmType} ${value.ptr}, ptr ${finalPtr}`);
    }
  }
}
