export class ZenList {
  constructor(IRB, expr, infer) {
    this.IRB = IRB;
    this.expr = expr;
    this.infer = infer;
  }

  list(node, globalScope) {
    this.IRB.guardStackOp("LIST", node);

    this.IRB.declareOneTime("zen_list_new", "declare ptr @_zen_list_new(i64)");

    this.IRB.declareOneTime(
      "zen_list_push",
      "declare void @_zen_list_push(ptr, ptr)",
    );

    this.IRB.declareOneTime(
      "ZenList",
      `%ZenList = type { ptr, i32, i32, i64 }`,
    );

    const name = node.name;
    let ownerId;

    this.IRB.guardGlobal(name, node);

    // TYPES

    const listLLVM = "ptr";

    const deepestType = this.IRB.getDeepestGeneric(node.generic);

    const depth = this.IRB.getListDepth(node.generic);

    const type = deepestType;

    const elementSize = this.IRB.sizeOf(deepestType);

    const validateDepth = (el, generic) => {
      const expectsList = generic.type === "List";
      let isActualList = el.type === "ARRAY" || el.type === "LIST_LITERAL";

      if (el.type !== "ARRAY" && el.type !== "STRUCT_LITERAL") {
        isActualList = this.expr.handleExpression(el)?.isList;
      }

      // expected list but got primitive
      if (expectsList && !isActualList) {
        this.IRB.emitError(
          "TypeError",
          `List ${name} expects nested list elements`,
          el,
        );
      }

      // expected primitive but got list
      if (!expectsList && isActualList) {
        this.IRB.emitError(
          "TypeError",
          `List ${name} expects '${generic.type}' but got List`,
          el,
        );
      }

      if (isActualList && el.type !== "variable") {
        for (const child of el.elements) {
          validateDepth(child, generic.generic);
        }
      }
    };

    // PTR

    const ptr = globalScope ? this.IRB.newGlobalTemp() : this.IRB.newTemp();

    // RECURSIVE PUSH

    const pushRecursive = (listPtr, element, generic) => {
      // STRUCT

      if (element.type === "STRUCT_LITERAL") {
        const structName = this.IRB.getDeepestGeneric(generic);
        const structPtr = this.IRB.emitStructLiteral(structName, element);

        const struct = this.IRB.getStruct(structName);
        const isOpaqueElement = struct?.isBuiltin && struct?.isOpaque;

        if (!isOpaqueElement && structPtr.needsLoad) {
          const t = this.IRB.newTemp();
          this.IRB.emit(`${t} = load ptr, ptr ${structPtr.ptr}`);
          structPtr.ptr = t;
        }

        this.IRB.emit(
          `call void @_zen_list_push(ptr ${listPtr}, ptr ${structPtr.ptr})`,
        );
        return;
      }

      // NESTED LIST

      if (element.type === "ARRAY" || element.type === "LIST_LITERAL") {
        if (generic.type !== "List") {
          this.IRB.emitError(
            "TypeError",
            "nested list inside non-list generic",
            node,
          );
        }

        const innerGeneric = generic.generic;

        const innerDepth = this.IRB.getListDepth(innerGeneric);

        const innerDeepest = this.IRB.getDeepestGeneric(innerGeneric);

        const innerSize = innerDepth > 1 ? 8 : this.IRB.sizeOf(innerDeepest);

        // CREATE CHILD LIST

        const childList = this.IRB.newTemp();

        this.IRB.emit(
          `${childList} = call ptr @_zen_list_new(i64 ${innerSize})`,
        );

        this.IRB.emit(
          `call void @_zen_list_set_meta(ptr ${childList}, i32 ${innerDepth}, i32 ${this.IRB.getListTypeCode(innerDeepest)})`,
        );

        // PUSH CHILD ELEMENTS

        for (const child of element.elements) {
          pushRecursive(childList, child, innerGeneric);
        }

        // STORE CHILD PTR

        const tmp = this.IRB.newTemp();

        this.IRB.emitAlloca(tmp, `ptr`);

        this.IRB.emit(`store ptr ${childList}, ptr ${tmp}`);

        // PUSH CHILD LIST

        this.IRB.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);

        return;
      }

      // NORMAL VALUE
      const expr = this.expr.handleExpression(element);
      this.IRB.emitExpr(expr);

      if (expr.isStruct) {
        const struct = this.IRB.getStruct(expr.type);

        if (struct.isBuiltin && struct.isOpaque) {
          let p = expr.ptr;

          if (!expr.needsLoad) {
            const tmp = this.IRB.newTemp();
            this.IRB.emitAlloca(tmp, `ptr`);
            this.IRB.emit(`store ptr ${expr.ptr}, ptr ${tmp}`);
            p = tmp;
          }

          // if needsLoad==true, expr.ptr is already the address of the pointer
          this.IRB.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${p})`);
          return;
        }

        const structSize = this.IRB.sizeOf(expr.type);

        this.IRB.declareOneTime(
          "llvm.memcpy.p0.p0.i64",
          "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
        );

        const tmp = this.IRB.newTemp();
        this.IRB.emitAlloca(tmp, `%${expr.type}`);
        this.IRB.emit(
          `call void @llvm.memcpy.p0.p0.i64(ptr ${tmp}, ptr ${expr.ptr}, i64 ${structSize}, i1 false)`,
        );
        this.IRB.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);
        return;
      }

      const actualGeneric = generic.type === "List" ? generic.generic : generic;
      const elementLLVM = this.IRB.getListElementLLVM(generic);
      const tmp = this.IRB.newTemp();
      this.IRB.emitAlloca(tmp, `${elementLLVM}`);
      let valueToStore = expr.ptr;

      if (elementLLVM === "ptr" && expr.type === "string") {
        this.IRB.declareOneTime("strdup", "declare ptr @strdup(ptr)");
        const dup = this.IRB.newTemp();
        this.IRB.emit(`${dup} = call ptr @strdup(ptr ${expr.ptr})`);
        valueToStore = dup;
      }

      this.IRB.emit(`store ${elementLLVM} ${valueToStore}, ptr ${tmp}`);
      this.IRB.emit(`call void @_zen_list_push(ptr ${listPtr}, ptr ${tmp})`);
    };

    // DETECT LIST LITERAL

    const isLiteralList = node.value && node.value.type === "ARRAY";

    let rootList = null;

    // NORMAL EXPRESSION
    // List<int> a = other
    // List<int> a = fn()
    // List<int> a = b.pop()

    if (!isLiteralList && node.value) {
      const expr = this.expr.handleExpression(node.value);

      ownerId = expr?.ownerId;

      if (expr?.isFreed) {
        this.IRB.emitError(
          "MemoryError",
          `use-after-free: '${node.name}' is no longer valid`,
          node,
        );
      }

      const isValidList = expr.isList;

      if (!isValidList) {
        const got = expr.isStruct ? "Struct" : expr.type;

        this.IRB.emitError(
          "TypeError",
          `${node.name} expect List but got ${got}`,
          node,
        );
      }

      if (isValidList && type !== expr.type) {
        this.IRB.emitError(
          "TypeError",
          `List ${name} expected ${type} but got ${expr.type}`,
          node,
        );
      }

      this.IRB.emitExpr(expr);

      let t;
      if (expr.isVarRef) {
        t = this.IRB.newTemp();
        this.IRB.emit(`${t} = load ptr, ptr ${expr.ptr}`);
      }

      rootList = t ? t : expr.ptr;
    }

    // REAL LIST LITERAL
    else {
      ownerId = this.IRB.genOwnerId();
      const listTemp = this.IRB.newTemp();

      this.IRB.emit(
        `${listTemp} = call ptr @_zen_list_new(i64 ${elementSize})`,
      );

      this.IRB.declareOneTime(
        "zen_list_set_meta",
        "declare void @_zen_list_set_meta(ptr, i32, i32)",
      );
      this.IRB.emit(
        `call void @_zen_list_set_meta(ptr ${listTemp}, i32 ${depth}, i32 ${this.IRB.getListTypeCode(deepestType)})`,
      );

      rootList = listTemp;

      const validate = (el, expectedType) => {
        if (el.type === "STRUCT_LITERAL") {
          const structDef = this.IRB.getStruct(expectedType);

          if (!structDef) {
            this.IRB.emitError(
              "TypeError",
              `List ${name} expected struct instance but got ${expectedType}`,
              el,
            );
          }

          return;
        }

        //  If its a nested array/list go deeper
        if (el.type === "ARRAY" || el.type === "LIST") {
          for (const sub of el.elements) {
            validate(sub, expectedType);
          }
          return;
        }

        let actualType = el.type;
        if (el.type === "UNARY_EXPRESSION" && el.operator === "-") {
          actualType = el.argument.type;
        }

        if (el.type === "variable") {
          const data = this.IRB.getVar(el.name);
          actualType = data.type;
        }

        if (el.type === "BINARY_EXPRESSION") {
          actualType = this.infer.infer(el);
        }

        // Leaf check using the resolved actual type
        if (actualType !== expectedType) {
          this.IRB.emitError(
            "TypeError",
            `List ${name} expected ${expectedType} but got ${actualType}`,
            node,
          );
        }
      };

      if (node.value && node.value.elements && node.value.elements.length > 0) {
        for (const el of node.value.elements) {
          validateDepth(el, node.generic.generic);
          validate(el, type);

          pushRecursive(rootList, el, node.generic);
        }
      }
    }

    // STORE VARIABLE PTR

    if (globalScope) {
      this.IRB.globals.push(`${ptr} = global ptr null`);

      this.IRB.emit(`store ptr ${rootList}, ptr ${ptr}`);
    } else {
      this.IRB.emitAlloca(ptr, `ptr`);

      this.IRB.emit(`store ptr ${rootList}, ptr ${ptr}`);
    }

    // SYMBOL TABLE

    this.IRB.setVar(
      name,
      this.IRB.createData({
        ptr,
        llvmType: listLLVM,
        type,
        generic: node.generic,
        internalType: "List",
        isList: true,
        isGlobal: globalScope,
        isConstant: node.isConstant,
        needsLoad: true,
        ownerId,
      }),
    );
  }
}
