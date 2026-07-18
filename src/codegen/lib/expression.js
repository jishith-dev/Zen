import {
  LOGICAL_OPS,
  COMPARISON_OPS,
  OP_CODES,
  LOOKUP,
  cmpMap,
  fcmpMap,
  NAMESPACE_MAP,
  SCALAR_TYPES,
  BUILTIN_FUNCTIONS,
  BUILTIN_STRUCTS,
  PRIMITIVE_TYPES,
  TYPE_MAP,
} from "../../config/config.js";

export class Expression {
  constructor(IRB) {
    this.IRB = IRB;
    this.count = 0;
  }

  setCall(call) {
    this.call = call;
  }

  setTernary(t) {
    this.ternary = t;
  }

  handleExpression(node, globalScope = true, ContextType = "Unknown") {
    // default globalScope true

    const op = node?.operator;
    let local = [];
    let global = [];

    // scalar types

    if (SCALAR_TYPES.includes(node.type)) {
      let value = node.value;

      if (node.type === "double") {
        value = this.IRB.formatDouble(value);
      }

      if (node.type === "bool") {
        value = node.value ? 1 : 0;
      }

      return {
        ptr: value,
        type: node.type,
        llvmType: this.IRB.getLLVMType(node.type),
        local: [],
        global: [],
        kind: "literal",
        endLabel: null,
        postOrPrefix: false,
        isVarRef: false,
      };
    }

    // non scalar type

    if (node.type === "string") {
      const str = node.value;
      const data = this.IRB.newGlobalString(str);

      return {
        ptr: data.name,
        ir: data.ir,
        symbol: data?.symbol,
        type: "string",
        llvmType: "ptr",
        length: data.length,
        local: data.local,
        global: data.global,
        kind: "literal",
        endLabel: null,
        postOrPrefix: false,
        isVarRef: false,
        rawStr: data.rawStr,
      };
    }

    // variable reference

    if (node.type === "variable") {
      const currentFreed = this.IRB.freedVars[this.IRB.freedVars.length - 1];

      // check for freed memory
      if (currentFreed.has(node.name)) {
        this.IRB.emitError(
          "MemoryError",
          `use-after-free: '${node.name}' is no longer valid`,
          node,
        );
      }

      const data = this.IRB.getVar(node.name, node);

      // check if its array so no need to load. we can load in array access
      const isArray = data?.isArray;
      const isStruct = data?.isStruct;
      const isList = data?.isList;
      const isVarArg = data?.isVarArg;
      let needsLoad = data?.needsLoad ?? false; // default false
      const fromLoopOf = data?.fromLoopOf;

      let t;
      if (!isArray && !isStruct && !isList && !isVarArg && needsLoad) {
        t = this.IRB.newTemp();
        this.IRB.emit(`${t} = load ${data.llvmType}, ptr ${data.ptr}`);
        needsLoad = false; // update
      } else {
        t = data.ptr;
      }

      return {
        ptr: t,
        addr: data.ptr, // only for unary
        type: data.type,
        stringGep: data?.ir,
        llvmType: data.llvmType,
        isStruct: data?.isStruct,
        local: [],
        global: [],
        length: data?.length,
        endLabel: null,
        isVarRef: true,
        postOrPrefix: data.postOrPrefix,
        dimData: isArray ? data.dimensionsData : null, // only for array access bound checking
        isList,
        generic: data?.generic,
        fromParam: data?.fromParam,
        isVarArg,
        isArray: isArray ? true : false,
        needsLoad,
        name: data?.name,
        fromLoopOf,
        rawStr: data?.rawStr,
        isReactive: data?.isReactive,
        isStruct: data?.isStruct,
        isListAccess: data?.isListAccess,
        isRet: data?.isRet,
        isFunction: data?.isFunction,
        params: data?.params,
        returnType: data?.returnType,
      };
    }

    if (node.type === "TEMPLATE_LITERAL") {
      const normalize = (part) => {
        if (typeof part === "string") {
          return {
            type: "string",
            value: part,
          };
        }

        if (Array.isArray(part)) {
          part = part[0];
        }

        if (part.type === "VARIABLE_REFERENCE") {
          return part.expression;
        }

        return part;
      };

      let result = null;

      for (const part of node.parts) {
        const exprNode = normalize(part);

        if (!result) {
          result = exprNode;
          continue;
        }

        result = {
          type: "BINARY_EXPRESSION",
          left: result,
          operator: "+",
          right: exprNode,
        };
      }

      const expr = this.handleExpression(result);

      return expr;
    }

    if (node.type === "STRUCT_LITERAL") {
      this.IRB.emitError(
        "SemanticError",
        "struct litetals are not supported in standalone context",
        node,
      );
    }

    if (node.type === "ARRAY") {
      this.IRB.declareOneTime(
        "zen_list_new",
        "declare ptr @_zen_list_new(i64)",
      );

      this.IRB.declareOneTime(
        "zen_list_push",
        "declare void @_zen_list_push(ptr, ptr)",
      );

      this.IRB.declareOneTime(
        "ZenList",
        "%ZenList = type { ptr, i32, i32, i64 }",
      );

      // infer element type from first element
      const first = node.elements[0];

      if (!first) {
        // Caller knows the expected type
        // List<T> field or variable) — use it instead of inferring from elements
        if (ContextType) {
          this.IRB.declareOneTime(
            "zen_list_new",
            "declare ptr @_zen_list_new(i64)",
          );

          const elemSize = this.IRB.sizeOf(ContextType);

          const list = this.IRB.newTemp();

          this.IRB.emit(`${list} = call ptr @_zen_list_new(i64 ${elemSize})`);

          return {
            ptr: list,
            addr: list,
            type: ContextType,
            llvmType: "ptr",
            local: [],
            global: [],
            isListLiteral: true,
            isList: true,
            generic: {
              generic: { type: ContextType },
            },
          };
        }

        this.IRB.emitError(
          "TypeError",
          "cannot infer empty array literal type",
          node,
        );
      }

      if (first.type === "STRUCT_LITERAL") {
  const structName = ContextType;

  if (!structName) {
    this.IRB.emitError(
      "TypeError",
      "Cannot infer struct type for struct list literal",
      node,
    );
  }

  const structDef = this.IRB.getStruct(structName);

  const isOpaque =
    structDef?.isBuiltin && structDef?.isOpaque;

  const elemSize = isOpaque
    ? 8
    : this.IRB.sizeOf(structName);

  const list = this.IRB.newTemp();

  const local = [];
  const global = [];

  local.push(
    `${list} = call ptr @_zen_list_new(i64 ${elemSize})`,
  );

  for (const el of node.elements) {
    const structPtr = this.IRB.emitStructLiteral(
      structName,
      el,
    );
    

    let p = structPtr.ptr;

    if (structPtr.needsLoad) {
      const t = this.IRB.newTemp();
      this.IRB.emit(
        `${t} = load ptr, ptr ${structPtr.ptr}`,
      );
      p = t;
    }

    if (isOpaque) {
      const tmp = this.IRB.newTemp();

      local.push(
        `${tmp} = alloca ptr`,
      );

      local.push(
        `store ptr ${p}, ptr ${tmp}`,
      );

      p = tmp;
    }

    local.push(
      `call void @_zen_list_push(ptr ${list}, ptr ${p})`,
    );
  }

  return {
    ptr: list,
    addr: list,
    type: structName,
    llvmType: "ptr",
    local,
    global,
    isListLiteral: true,
    isList: true,
    generic: {
      type: "List",
      generic: {
        type: ContextType,
      },
    },
  };
}

      const elemExpr = this.handleExpression(first, false, ContextType);

      this.IRB.emitExpr(elemExpr);

      if (elemExpr.isStruct) {
        const structName = elemExpr.type;
        const elemSize = this.IRB.sizeOf(structName);

        const list = this.IRB.newTemp();
        const local = [];
        const global = [];

        local.push(`${list} = call ptr @_zen_list_new(i64 ${elemSize})`);

        // first element already evaluated above
        const firstTmp = this.IRB.newTemp();
        this.IRB.declareOneTime(
          "llvm.memcpy.p0.p0.i64",
          "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)",
        );
        local.push(`${firstTmp} = alloca %${structName}`);
        local.push(
          `call void @llvm.memcpy.p0.p0.i64(ptr ${firstTmp}, ptr ${elemExpr.ptr}, i64 ${elemSize}, i1 false)`,
        );
        local.push(`call void @_zen_list_push(ptr ${list}, ptr ${firstTmp})`);

        // remaining elements
        for (let i = 1; i < node.elements.length; i++) {
          const el = node.elements[i];

          let elPtr;
          if (el.type === "STRUCT_LITERAL") {
            let t = this.IRB.emitStructLiteral(structName, el);

            if (elPtr.needsLoad) {
              const t = this.IRB.newTemp();
              this.IRB.emit(`${t} = load ptr, ptr ${elPtr.ptr}`);
              elPtr = t;
            } else {
              elPtr = elPtr.ptr;
            }
          } else {
            const expr = this.handleExpression(el);
            this.IRB.emitExpr(expr);

            const tmp = this.IRB.newTemp();
            local.push(`${tmp} = alloca %${structName}`);
            local.push(
              `call void @llvm.memcpy.p0.p0.i64(ptr ${tmp}, ptr ${expr.ptr}, i64 ${elemSize}, i1 false)`,
            );
            elPtr = tmp;
          }

          local.push(`call void @_zen_list_push(ptr ${list}, ptr ${elPtr})`);
        }

        return {
          ptr: list,
          addr: list,
          type: structName,
          llvmType: "ptr",
          local,
          global,
          isListLiteral: true,
          isList: true,
          generic: { type: "List", generic: { type: structName } },
        };
      }

      const elemLLVM = elemExpr.isList ? "ptr" : elemExpr.llvmType;

      const elemSize = elemLLVM === "ptr" ? 8 : this.IRB.sizeOf(elemExpr.type);

      const list = this.IRB.newTemp();

      const local = [];
      const global = [];

      local.push(`${list} = call ptr @_zen_list_new(i64 ${elemSize})`);

      for (const el of node.elements) {
        const expr = this.handleExpression(el);

        this.IRB.emitExpr(expr);

        const tmp = this.IRB.newTemp();

        local.push(`${tmp} = alloca ${elemLLVM}`);

        local.push(`store ${elemLLVM} ${expr.ptr}, ptr ${tmp}`);

        local.push(`call void @_zen_list_push(ptr ${list}, ptr ${tmp})`);
      }

      return {
        ptr: list,
        addr: list,
        type: elemExpr.type,
        llvmType: "ptr",
        local,
        global,
        isListLiteral: true,
        isList: true,
        generic: {
          type: "List",
          generic: elemExpr.isList ? elemExpr.generic : { type: elemExpr.type },
        },
      };
    }

    if (node.type === "TERNARY") {
      const res = this.ternary.ternary(node);

      return res;
    }

    if (node.type === "MEMBER_ACCESS") {
      const { base, fields } = this.IRB.resolveMemberChain(node);

      // namespace resolve

      if (base.type === "variable" && NAMESPACE_MAP[base.name]) {
        const namespace = base.name;
        const path = this.IRB.getMemberPath(node);

        const members = path.split("_").slice(1);
        const memberPath = members.join("_");

        if (!NAMESPACE_MAP[namespace].includes(memberPath)) {
          this.IRB.emitError(
            "ReferenceError",
            `${namespace}.${members.join(".")} does not exist`,
            node.object,
          );
        }

        const callNode = {
          isInbuilt: true,
          type: "CALL",
          name: `_${path}`,
          args: node.args,
          isAwait: node.isAwait,
        };

        return this.call.handleCall(callNode, true);
      }

      // enum

      if (base.type === "variable" && this.IRB.enums?.has(base.name)) {
        const enumInfo = this.IRB.enums.get(base.name);

        if (!enumInfo.members.has(node.field)) {
          this.IRB.emitError(
            "ReferenceError",
            `Enum '${base.name}' has no member '${node.field}'`,
            node,
          );
        }

        const value = enumInfo.members.get(node.field);

        return {
          ptr: value,
          type: "int",
          llvmType: "i32",
          local: [],
          global: [],
          isVarRef: false,
          isConstant: true,
        };
      }

      let object;

      if (base.type === "THIS") {
        object = {
          ptr: "%this",
          type: this.IRB.currentStruct,
          llvmType: `%${this.IRB.currentStruct}`,
          local: [],
          global: [],
          isStruct: true,
          isVarRef: false,
        };
      } else {
        object = this.handleExpression(base);
      }

      this.IRB.emitExpr(object);

      if (
        PRIMITIVE_TYPES.includes(object.type) &&
        !object.isList &&
        !object.isStruct
      ) {
        this.IRB.emitError(
          "TypeError",
          `'${object.type}' has no property or method '${fields[0]}'`,
          node,
        );
      }

      // struct chain
      if (object.isStruct) {
        let structName = object.type;
        let basePtr = object.ptr;

        let fieldInfo = null;

        // WALK CHAIN

        for (let i = 0; i < fields.length; i++) {
          const LIST_PROPS = [
            "push",
            "pop",
            "contains",
            "removeAt",
            "clear",
            "free",
            "length",
            "capacity",
            "join",
            "indexOf",
          ];

          if (fieldInfo?.isList && LIST_PROPS.includes(fields[i])) {
            let t = this.IRB.newTemp();

            this.IRB.emit(`${t} = load ptr, ptr ${basePtr}`);

            this.IRB.declareOneTime(
              "ZenList",
              "%ZenList = type { ptr, i32, i32, i64 }",
            );

            const fakeObject = {
              ptr: t,
              type: fieldInfo?.type,
              llvmType: fieldInfo?.llvmType,
              local: [],
              global: [],
              isList: true,
              isVarRef: true,
              generic: fieldInfo?.generic,
            };

            return this.IRB.handleListProperty(
              t,
              fakeObject,
              node.field,
              node,
              false,
              fields[fields.length - 1],
            );
          }

          if (!this.IRB.hasStruct(structName)) {
            if (node?.args && i === fields.length - 1) {
              this.IRB.emitError(
                "TypeError",
                `field '${fields[i]}' is not callable`,
                node,
              );
            }
            this.IRB.emitError(
              "ReferenceError",
              `Cannot access field '${fields[i]}' on non-struct type '${structName}'`,
              node,
            );
          }

          const structInfo = this.IRB.getStruct(structName);

          if (!structInfo) {
            this.IRB.emitError(
              "InternalError",
              `Unknown struct '${structName}'`,
              node,
            );
          }

          if (structInfo.isBuiltin && structInfo.isOpaque && object.needsLoad) {
            const t = this.IRB.newTemp();
            this.IRB.emit(`${t} = load ptr, ptr ${basePtr}`);
            basePtr = t;
          }

          const currentField = fields[i];

          if (BUILTIN_STRUCTS.includes(structName)) {
            // diff prop and method call

            const isCall = Array.isArray(node?.args);

            if (isCall) {
              const builtin = this.IRB.handleBuiltinStructMethod(
                structName,
                currentField,
                base,
                basePtr,
                node,
                object,
                globalScope,
              );

              if (builtin) return builtin;
            } else {
              const builtin = this.IRB.handleBuiltinStructProp(
                structName,
                currentField,
                base,
                basePtr,
                node,
                object,
              );

              if (builtin) return builtin;
            }
          }

          const possibleMethod = `${structName}_${currentField}`;

          const isMethod = this.IRB.functions.has(possibleMethod);

          if (isMethod) {
            if (!Array.isArray(node?.args)) {
              this.IRB.emitError(
                "TypeError",
                `method '${currentField}' must be called with '()'`,
                node,
              );
            }

            const fn = this.IRB.getFunction(possibleMethod);

            const args = [];

            // implicit this
            args.push(`ptr ${basePtr}`);

            // method args
            for (const argNode of node.args || []) {
              const arg = this.handleExpression(argNode);
              this.IRB.emitExpr(arg);

              if (arg?.isStruct) {
                args.push(`ptr ${arg.ptr}`);
              } else if (arg.needsLoad) {
                const tmp = this.IRB.newTemp();
                this.IRB.emit(`${tmp} = load ptr, ptr ${arg.ptr}`);
                args.push(`ptr ${tmp}`);
              } else {
                args.push(`${arg.llvmType} ${arg.ptr}`);
              }
            }

            // void method
            if (fn.returnType.type === "void") {
              this.IRB.emit(`call void @${possibleMethod}(${args.join(", ")})`);
              return {
                ptr: null,
                type: "void",
                llvmType: "void",
                local,
                global: [],
                isVarRef: false,
              };
            }

            const retType = this.IRB.getLLVMType(fn.returnType.type);
            const isStruct = this.IRB.hasStruct(fn.returnType.type);

            // struct-returning method — use sret convention
            if (isStruct) {
              const tmp = this.IRB.newTemp();
              this.IRB.emit(`${tmp} = alloca ${retType}`);

              const sretArgs = [`ptr sret(${retType}) ${tmp}`, ...args];

              this.IRB.emit(
                `call void @${possibleMethod}(${sretArgs.join(", ")})`,
              );

              return {
                ptr: tmp,
                type: fn.returnType.type,
                llvmType: retType,
                isStruct: true,
                isVarRef: false,
                local,
                global: [],
              };
            }

            // primitive / list-returning method
            const tmp = this.IRB.newTemp();
            this.IRB.emit(
              `${tmp} = call ${retType} @${possibleMethod}(${args.join(", ")})`,
            );

            const isList = fn.returnType.type === "List";

            return {
              ptr: tmp,
              type: isList ? fn.retGeneric : fn.returnType.type,
              llvmType: retType,
              local,
              retGeneric: fn.retGeneric,
              generic: fn.generic,
              isList,
              isStruct: false,
              global: [],
              isVarRef: false,
            };
          }

          // FIELD USED AS METHOD CHECK
          const isLastField = i === fields.length - 1;

          if (isLastField && node?.args) {
            const fieldIndex = structInfo.fieldMap[currentField];

            if (fieldIndex !== undefined) {
              this.IRB.emitError(
                "TypeError",
                `field '${currentField}' is not callable`,
                node,
              );
            }
          }

          // FIELD LOOKUP

          const fieldIndex = structInfo.fieldMap[currentField];

          if (fieldIndex === undefined) {
            this.IRB.emitError(
              "ReferenceError",
              `Unknown field '${currentField}' in struct '${structName}'`,
              node,
            );
          }

          fieldInfo = structInfo.layout[fieldIndex];
          const isList = fieldInfo.isList;
          const ptr = this.IRB.newTemp();
          if (isList) {
            this.IRB.emit(
              `${ptr} = getelementptr %${structName}, %${structName}* ${basePtr}, i32 0, i32 ${fieldIndex}`,
            );
          }
          basePtr = ptr;
          structName = fieldInfo.type;
        }

        // STRUCT FIELD TYPES

        const isList = fieldInfo.isList;

        // LIST RETURN

        if (isList) {
          this.IRB.declareOneTime(
            "ZenList",
            "%ZenList = type { ptr, i32, i32, i64 }",
          );

          return {
            ptr: basePtr,
            type: fieldInfo.type,
            llvmType: "ptr",
            local: [],
            global: [],
            isList: true,
            isVarRef: true,
            generic: fieldInfo.generic,
            needsLoad: true,
          };
        }
      }

      // list  / struct

      let structName = object.type;
      let basePtr = object.ptr;
      const isList = object?.isList;
      const methodName = `${object.type}_${node.field}`;

      if (isList) {
        const o = object;

        this.IRB.emitExpr(o);

        let listPtr = this.IRB.newTemp();

        if (!o.fromParam && o.needsLoad) {
          this.IRB.emit(`${listPtr} = load ptr, ptr ${o.ptr}`);
        } else {
          listPtr = o.ptr;
        }

        const field = node.field;

        o.name = base?.array?.o?.name;

        return this.IRB.handleListProperty(
          listPtr,
          o,
          field,
          node,
          false,
          base?.array?.field,
        );
      }

      let fieldInfo;

      // walk struct
      for (let i = 0; i < fields.length; i++) {
        const structInfo = this.IRB.getStruct(structName, node);

        const currentField = fields[i];

        const fieldIndex = structInfo.fieldMap[fields[i]];

        fieldInfo = structInfo.layout[fieldIndex];

        const ptr = this.IRB.newTemp();

        const useOpaquePtr = object?.isRet || object?.fromParam;

        this.IRB.emit(
          useOpaquePtr
            ? `${ptr} = getelementptr inbounds %${structName}, ptr ${basePtr}, i32 0, i32 ${fieldIndex}`
            : `${ptr} = getelementptr %${structName}, %${structName}* ${basePtr}, i32 0, i32 ${fieldIndex}`,
        );

        basePtr = ptr;

        structName = fieldInfo.type;
      }

      const finalType = fieldInfo.llvmType;

      const isArray = finalType?.startsWith("[") || finalType?.isArray;
      const isStruct = this.IRB.hasStruct(structName);

      if (isArray || isStruct) {
        //  return pointer (so ARRAY_ACCESS can use it)
        return {
          ptr: basePtr,
          addr: basePtr,
          type: structName,
          llvmType: finalType,
          local,
          isStruct: isStruct,
          global: [],
          isVarRef: false,
        };
      }

      //  normal scalar  load
      const val = this.IRB.newTemp();

      local.push(`${val} = load ${finalType}, ptr ${basePtr}`);

      return {
        ptr: val,
        type: structName,
        llvmType: finalType,
        local,
        global: [],
        isVarRef: false,
      };
    }

    if (node.type === "ARRAY_ACCESS") {
      const buildAccess = (n) => {
        if (n.type !== "ARRAY_ACCESS") {
          return this.handleExpression(n);
        }

        const base = buildAccess(n.array);

        if (base.local?.length) {
          local.push(...base.local);
        }

        if (base.global?.length) global.push(...base.global);

        if (n.index.type === "UNARY_EXPRESSION" && n.index.operator === "-") {
          this.IRB.emitError(
            "ArrayError",
            `Array index must be a non-negative integer`,
            n.index,
          );
        }
        const index = this.handleExpression(n.index);

        this.IRB.emitExpr(index);

        const ptr = this.IRB.newTemp();

        if (base.isVarArg) {
          local.push(
            `${ptr} = getelementptr ptr, ptr %varargs, i32 ${index.ptr}`,
          );
          return {
            ptr,
            type: base.type,
            addr: ptr,
            isList: false,
            llvmType: this.IRB.getLLVMType(base.type),
            endLabel: null,
            postOrPrefix: false,
            isArray: false,
            isVarArg: true,
          };
        }

        if (base.isList) {
          let listTemp = this.IRB.newTemp();

          if (base.isMapValue || base.fromParam || base?.isDirectCall) {
            listTemp = base.ptr;
          } else {
            listTemp = this.IRB.newTemp();

            local.push(`${listTemp} = load ptr, ptr ${base.ptr}`);
          }

          this.IRB.declareOneTime(
            "zen_list_get",
            "declare ptr @_zen_list_get(ptr, i32)",
          );

          const elemPtr = this.IRB.newTemp();

          local.push(
            `${elemPtr} = call ptr @_zen_list_get(ptr ${listTemp}, i32 ${index.ptr})`,
          );

          const isListValue = !!base.generic;

          const nextGeneric = base.generic?.generic;

          const normalizedGeneric = this.IRB.normalizeGeneric(nextGeneric);

          const isNested = normalizedGeneric?.type === "List";

          const isStruct = this.IRB.hasStruct(base.type);

          return {
            ptr: elemPtr,
            type: base.type,
            addr: elemPtr,
            isList: isNested,
            isListAccess: true,
            generic: normalizedGeneric,
            llvmType: isNested ? "ptr" : this.IRB.getLLVMType(base.type),
            endLabel: null,
            postOrPrefix: false,
            isArray: false,
            isStruct,
            needsLoad: !isNested,
          };
        }

        // string index access
        if (base.type === "string") {
          local.push(
            `${ptr} = getelementptr i8, ptr ${base.ptr ?? base.addr}, i32 ${index.ptr}`,
          );

          const t = this.IRB.newTemp();
          local.push(`${t} = load i8, ptr ${ptr}`);
          this.IRB.declareOneTime(
            "zen_char_to_string",
            "declare ptr @_zen_char_to_string(i8)",
          );
          const tem = this.IRB.newTemp();
          local.push(`${tem} = call ptr @_zen_char_to_string(i8 ${t})`);

          return {
            addr: tem,
            ptr: tem,
            llvmType: "ptr",
            type: "string",
            internalType: "char", // only for internal use,
            needsLoad: false,
            local: base.local || [],
            global: [],
          };
        }

        // fixed size array
        const basePtr = base.addr ?? base.ptr;

        const elemPtr = this.IRB.newTemp();

        local.push(
          `${elemPtr} = getelementptr ${base.llvmType}, ptr ${basePtr}, i32 0, i32 ${index.ptr}`,
        );

        const elemType = this.IRB.getElementType(base.llvmType);

        return {
          ptr: elemPtr,
          addr: elemPtr,
          llvmType: elemType,
          type: base.type,
          local: base.local || [],
          global: [],
          needsLoad: true,
          isArrayAccess: true,
        };
      };

      const final = buildAccess(node);

      const val = this.IRB.newTemp();

      const isListAccess = final.isList;
      const isStruct = final?.isStruct;

      let resultPtr = final.ptr;
      let resultAddr = final?.addr;
      const needsLoad = final?.needsLoad;

      if (!isStruct && needsLoad) {
        local.push(`${val} = load ${final.llvmType}, ptr ${final.addr}`);
        final.needsLoad = false;

        resultPtr = val;
      }

      return {
        ptr: resultPtr,
        raw: resultAddr,
        addr: resultAddr,
        type: final.type,
        llvmType: final.llvmType,
        local,
        isList: final.isList,
        global: [],
        endLabel: null,
        postOrPrefix: false,
        isArray: final.isArray,
        isStruct,
        generic: final?.generic,
        needsLoad: final.needsLoad,
        isListAccess: final?.isListAccess,
      };
    }

    if (node.type === "CALL") {
      return this.call.handleCall(node, true, globalScope);
    }

    if (node.type === "UNARY_EXPRESSION") {
      const val = this.handleExpression(node.argument, globalScope);

      const local = [...(val.local || [])];
      const global = [...(val.global || [])];

      const v = val.ptr;

      if (node.argument.type === "string") {
        this.IRB.emitError(
          "TypeError",
          "unary operators cannot be applied to type 'string'",
          node,
        );
      }

      //  LOGICAL NOT (!)

      if (node.operator === "!") {
        let isValue;
        let boolVal;

        if (val.type === "int") {
          const t = this.IRB.newTemp();
          local.push(`${t} = icmp ne i32 ${v}, 0`);
          boolVal = t;
        } else if (val.type === "double") {
          const t = this.IRB.newTemp();
          local.push(`${t} = fcmp one double ${v}, 0.0`);
          boolVal = t;
        } else if (val.type === "bool") {
          boolVal = v;
        } else {
          this.IRB.emitError(
            "TypeError",
            `Cannot apply ! to ${val.type}`,
            node,
          );
        }

        const res = this.IRB.newTemp();
        local.push(`${res} = xor i1 ${boolVal}, true`);

        return {
          ptr: res,
          type: "bool",
          llvmType: "i1",
          local,
          global,
          endLabel: null,
          postOrPrefix: false,
          isVarRef: false,
        };
      }

      //   NEGATION (-)

      if (node.operator === "-") {
        if (val.kind === "literal") {
          if (val.type === "int") {
            return {
              ptr: `-${v}`,
              type: "int",
              llvmType: "i32",
              local,
              global,
              postOrPrefix: false,
              endLabel: null,
              isVarRef: false,
            };
          }

          if (val.type === "double") {
            return {
              ptr: `-${v}`,
              type: "double",
              llvmType: "double",
              local,
              global,
              postOrPrefix: false,
              endLabel: null,
              isVarRef: false,
            };
          }
        }

        const tmp = this.IRB.newTemp();

        if (val.type === "int") {
          const tm = this.IRB.newTemp();
          this.IRB.emit(`${tm} = sub i32 0, ${v}`);

          return {
            ptr: tm,
            type: "int",
            llvmType: "i32",
            local,
            global,
            postOrPrefix: false,
            endLabel: null,
          };
        }

        if (val.type === "double") {
          const tm = this.IRB.newTemp();
          this.IRB.emit(`${tm} = fsub double 0.0, ${v}`);

          return {
            ptr: tm,
            type: "double",
            llvmType: "double",
            local,
            global,
            postOrPrefix: false,
            endLabel: null,
          };
        }

        this.IRB.emitError("TypeError", `Cannot apply - to ${val.type}`, node);
      }

      // +

      if (node.operator === "+") {
        return {
          ptr: v,
          type: val.type,
          llvmType: val.llvmType,
          local: [],
          global: [],
          endLabel: null,
          postOrPrefix: false,
          isVarRef: false,
        };
      }

      //  Increment or Decrement postfix
      //  or prefix unary

      if (node.operator === "++" || node.operator === "--") {
        const isInt = val.type === "int";
        const isDouble = val.type === "double";

        if (!isInt && !isDouble) {
          this.IRB.emitError(
            "TypeError",
            `Expected numeric type 'int' or 'float', got '${val.type}'`,
            node,
          );
        }

        if (!val.isVarRef) {
          this.IRB.emitError(
            "SemanticError",
            `Invalid assignment target — expected a variable reference`,
            node,
          );
        }

        const llvmType = isDouble ? "double" : "i32";
        const op = node.operator === "++" ? "add" : "sub";
        const one = isDouble ? "1.0" : "1";

        //  get variable address
        const old = val.ptr;

        //  compute new value
        const newVal = this.IRB.newTemp();
        local.push(
          `${newVal} = ${isDouble ? "f" : ""}${op} ${llvmType} ${old}, ${one}`,
        );

        local.push(`store ${val.llvmType} ${newVal}, ptr ${val.addr}`);

        //  return based on prefix/postfix
        return {
          ptr: node.isPostfix ? old : newVal,
          newVal: newVal, // for reference
          type: val.type,
          llvmType,
          local,
          global,
          isVarRef: false,
          endLabel: null,
          isPostfix: node.isPostfix,
          postOrPrefix: true,
        };
      }

      this.IRB.emitError(
        "TypeError",
        `Unsupported unary operator ${node.operator}`,
        node,
      );
    }

    //   RECURSIVE RESOLVE

    const resolve = (n) => {
      if (!n) this.IRB.emitError("InternalError", "resolve node is empty");

      if (n.type === "BINARY_EXPRESSION" || n.type === "UNARY_EXPRESSION") {
        this.IRB.containsUnary(n);
      }

      if (n.type === "CALL") {
        return this.call.handleCall(n, false, globalScope);
      }

      return this.handleExpression(n, globalScope);
    };

    let lPtr = null;
    let rPtr = null;

    let lType = null;
    let rType = null;

    let lLLVMtype = null;
    let rLLVMtype = null;
    let lKind = null;
    let rKind = null;

    if (node.type === "ASSIGNMENT") {
      this.IRB.emitError(
        "SemanticError",
        `'${node.name}' cannot be used in an expression context`,
        node,
      );
    }

    if (!LOGICAL_OPS.includes(op)) {
      let LNode = resolve(node.left);
      let RNode = resolve(node.right);

      if (LNode?.isList) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on lists are not supported",
          node?.left,
        );
      }

      if (LNode?.isStruct) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on structs are not supported",
          node?.left,
        );
      }

      if (RNode?.isList) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on lists are not supported",
          node?.right,
        );
      }

      if (RNode?.isStruct) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on structs are not supported",
          node?.right,
        );
      }

      if (!LNode || !RNode)
        this.IRB.emitError(
          "Invalid binary operation: left or right operand is missing or invalid",
          node?.left?.line || node?.right?.line,
        );

      lPtr = LNode.ptr;
      rPtr = RNode.ptr;
      lKind = LNode?.kind;
      rKind = RNode?.kind;
      lType = LNode.type;
      rType = RNode.type;

      lLLVMtype = LNode.llvmType;
      rLLVMtype = RNode.llvmType;
      // merge child IR first
      local.push(...(LNode.local || []), ...(RNode.local || []));
      global.push(...(LNode.global || []), ...(RNode.global || []));
    }

    if (lType === "string" || rType === "string") {
      const LNode = {
        ptr: lPtr,
        type: lType,
        llvmType: lLLVMtype,
      };

      const RNode = {
        ptr: rPtr,
        type: rType,
        llvmType: rLLVMtype,
      };

      let leftPtr = lPtr;
      let rightPtr = rPtr;

      if (lType !== "string") {
        switch (lType) {
          case "int":
          case "bool":
          case "double":
            const cExpr = this.IRB.castExpression(LNode, "string");
            local.push(cExpr?.local.join("\n"));
            leftPtr = cExpr.ptr;
            break;

          default:
            this.IRB.emitError(
              "TypeError",
              `Cannot cast ${lType} to string`,
              node,
            );
        }
      }

      if (rType !== "string") {
        switch (rType) {
          case "int":
          case "bool":
          case "double":
            const cExpr = this.IRB.castExpression(RNode, "string");
            local.push(cExpr?.local.join("\n"));
            rightPtr = cExpr.ptr;
            break;

          default:
            this.IRB.emitError(
              "TypeError",
              `Cannot cast ${rType} to string`,
              node,
            );
        }
      }

      if (["-", "/", "*", "%", "^"].includes(op)) {
        this.IRB.emitError(
          "TypeError",
          `invalid string operator '${op}', expected '+'`,
          node,
        );
      }

      if (op === "+") {
        this.IRB.declareOneTime(
          "str_concat",
          "declare ptr @_str_concat(ptr, ptr)",
        );

        const resultPtr = this.IRB.newTemp();

        // CONCAT
        local.push(
          `${resultPtr} = call ptr @_str_concat(ptr ${leftPtr}, ptr ${rightPtr})`,
        );

        return {
          ptr: resultPtr,
          type: "string",
          llvmType: "ptr",
          local: local,
          global: global,
          endLabel: null,
          postOrPrefix: false,
        };
      }

      if (COMPARISON_OPS.includes(op)) {
        this.IRB.declareOneTime("str_cmp", "declare i32 @strcmp(ptr, ptr)");

        const resultPtr = this.IRB.newTemp();

        const l = lPtr;
        const r = rPtr;

        const cmp = this.IRB.newTemp();
        local.push(`${cmp} = call i32 @strcmp(ptr ${l}, ptr ${r})`);

        // convert strcmp result boolean
        const boolPtr = this.IRB.newTemp();

        if (op === "==") {
          local.push(`${boolPtr} = icmp eq i32 ${cmp}, 0`);
        } else if (op === "!=") {
          local.push(`${boolPtr} = icmp ne i32 ${cmp}, 0`);
        } else if (op === ">") {
          local.push(`${boolPtr} = icmp sgt i32 ${cmp}, 0`);
        } else if (op === "<") {
          local.push(`${boolPtr} = icmp slt i32 ${cmp}, 0`);
        } else if (op === ">=") {
          local.push(`${boolPtr} = icmp sge i32 ${cmp}, 0`);
        } else if (op === "<=") {
          local.push(`${boolPtr} = icmp sle i32 ${cmp}, 0`);
        }

        return {
          ptr: boolPtr,
          type: "bool",
          llvmType: "i1",
          local,
          global,
          postOrPrefix: false,
          endLabel: null,
        };
      }
    } else if (
      (lType === "string" && rType !== "string") ||
      (rType === "string" && lType !== "string")
    ) {
      this.IRB.emitError(
        "TypeError",
        `cannot apply '${op}' to ${lType} and ${rType}`,
        node,
      );
    }

    const normalize = (type, val, k) => {
      if (type === "bool") {
        const t = this.IRB.newTemp();
        local.push(`${t} = zext i1 ${val} to i32`);
        return { type: "int", llvmType: "i32", value: t, kind: k };
      }

      if (type === "int") {
        return { type, llvmType: "i32", value: val, kind: k };
      }

      if (type === "double") {
        return { type, llvmType: "double", value: val, kind: k };
      }
    };

    const L = normalize(lType, lPtr, lKind);
    const R = normalize(rType, rPtr, rKind);

    if (LOGICAL_OPS.includes(op)) {
      const result = this.IRB.newTemp();

      const rhsLabel = this.IRB.newLabel("rhs");
      const skipLabel = this.IRB.newLabel("skip");
      const endLabel = this.IRB.newLabel("end");

      const LNode = resolve(node.left);

      if (LNode?.isList) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on lists are not supported",
          node?.left,
        );
      }

      if (LNode?.isStruct) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on structs are not supported",
          node?.left,
        );
      }

      local.push(...(LNode.local || []));
      global.push(...(LNode.global || []));

      const toBool = (val, type) => {
        if (type === "bool") return val;

        const t = this.IRB.newTemp();

        if (type === "int") {
          local.push(`${t} = icmp ne i32 ${val}, 0`);
        } else if (type === "double") {
          local.push(`${t} = fcmp one double ${val}, 0.0`);
        } else if (type === "string") {
          const t0 = this.IRB.newTemp();
          local.push(`${t0} = load i8, ptr ${val}`);
          local.push(`${t} = icmp ne i8 ${t0}, 0`);
        } else {
          this.IRB.emitError(
            "TypeError",
            `Cannot convert ${type} to bool`,
            node,
          );
        }

        return t;
      };

      const lBool = toBool(LNode.ptr, LNode.type);

      if (op === "&&") {
        local.push(`br i1 ${lBool}, label %${rhsLabel}, label %${skipLabel}`);
      } else {
        local.push(`br i1 ${lBool}, label %${skipLabel}, label %${rhsLabel}`);
      }

      local.push(`${rhsLabel}:`);

      const RNode = resolve(node.right);

      if (RNode?.isList) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on lists are not supported",
          node?.right,
        );
      }

      if (RNode?.isStruct) {
        this.IRB.emitError(
          "TypeError",
          "Binary operations on structs are not supported",
          node?.right,
        );
      }

      local.push(...(RNode.local || []));
      global.push(...(RNode.global || []));

      const rBool = toBool(RNode.ptr, RNode.type);

      const rIncomingBlock = RNode.endLabel || rhsLabel;

      local.push(`br label %${endLabel}`);

      local.push(`${skipLabel}:`);
      local.push(`br label %${endLabel}`);

      local.push(`${endLabel}:`);

      const skipValue = op === "&&" ? "false" : "true";

      local.push(
        `${result} = phi i1 [ ${skipValue}, %${skipLabel} ], [ ${rBool}, %${rIncomingBlock} ]`,
      );

      return {
        ptr: result,
        type: "bool",
        llvmType: "i1",
        local,
        global,
        postOrPrefix: false,
        endLabel: endLabel,
      };
    }

    if (COMPARISON_OPS.includes(op)) {
      const result = this.IRB.newTemp();

      const isDouble = L.type === "double" || R.type === "double";

      const llvmOp = isDouble ? `fcmp ${fcmpMap[op]}` : `icmp ${cmpMap[op]}`;

      const type = isDouble ? "double" : "int";

      if (type === "double") {
        if (L.type === "int") {
          const t = this.IRB.newTemp();
          local.push(`${t} = sitofp i32 ${L.value} to double`);
          L.value = t;
        }

        if (R.type === "int") {
          const t = this.IRB.newTemp();
          local.push(`${t} = sitofp i32 ${R.value} to double`);
          R.value = t;
        }
      }

      local.push(
        `${result} = ${llvmOp} ${this.IRB.getLLVMType(type)} ${L.value}, ${R.value}`,
      );

      return {
        ptr: result,
        type: "bool",
        llvmType: "i1",
        local: local,
        global: global,
        endLabel: null,
        postOrPrefix: false,
      };
    }

    const resultType = LOOKUP[L.type] > LOOKUP[R.type] ? L.type : R.type;
    const leftType = L.type;
    const rightType = R.type;

    if (resultType === "double") {
      if (L.type === "int") {
        const t = this.IRB.newTemp();
        local.push(`${t} = sitofp i32 ${L.value} to double`);
        L.value = t;
      }

      if (R.type === "int") {
        const t = this.IRB.newTemp();
        local.push(`${t} = sitofp i32 ${R.value} to double`);
        R.value = t;
      }
    }

    if (
      op === "^" &&
      ((leftType !== "int" && leftType !== "bool") ||
        (rightType !== "int" && rightType !== "bool"))
    ) {
      this.IRB.emitError(
        "TypeError",
        `cannot apply '${op}' to ${leftType} and ${rightType}`,
        node,
      );
    }

    const opcode = OP_CODES[resultType][op];

    if (!opcode) {
      this.IRB.emitError(
        "TypeError",
        `cannot apply '${op}' to ${leftType} and ${rightType}`,
        node,
      );
    }

    const result = this.IRB.newTemp();

    local.push(
      `${result} = ${opcode} ${this.IRB.getLLVMType(resultType)} ${L.value}, ${R.value}`,
    );

    return {
      ptr: result,
      type: resultType,
      llvmType: this.IRB.getLLVMType(resultType),
      local,
      global,
      endLabel: null,
      postOrPrefix: false,
    };
  }
}
