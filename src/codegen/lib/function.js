export class HandleFunction {
    constructor(IRB, expr, block, infer, g, moduleName, abi, S) {
        this.IRB = IRB;
        this.block = block;
        this.expr = expr;
        this.infer = infer;
        this.globalState = g;
        this.haveBareRet = false;
        this.hasRet = false;
        this.moduleName = moduleName;
        this.BUILTIN_STRUCT_ABI = abi;
        this.BUILTIN_STRUCTS = S;
    }

    // A struct returns/passes as a raw `ptr` (no sret, no alloca-by-value)

    isPtrReturn(typeName) {
        const struct = this.IRB.hasStruct(typeName)
            ? this.IRB.getStruct(typeName)
            : false;
        return !!struct?.isOpaque || this.BUILTIN_STRUCT_ABI.includes(typeName);
    }

    collectReturns(node) {
        if (!node) return;

        switch (node.type) {
            case "RETURN": {
                if (!node.value) {
                    this.IRB.currentFunction.returnTypes.push("void");
                } else {
                    const type = this.infer.infer(node.value, "fnret");

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

                const ifRet = this.hasGuaranteedReturn(node.if.body);

                const elifRet = (node.elseIf || []).every(e =>
                    this.hasGuaranteedReturn(e.body)
                );

                const elseRet = this.hasGuaranteedReturn(node.else.body);

                return ifRet && elifRet && elseRet;
            }

            default:
                return false;
        }
    }

    handleReturn(node) {
        if (this.IRB.currentFunction === null) {
            this.IRB.emitError(
                "SemanticError",
                "return outside function",
                node
            );
        }

        // bare return without 'return'
        if (node.value.length === 0) {
            this.haveBareRet = true;
            this.IRB.emit(`ret void`);
            this.hasRet = false;
            return;
        } else {
            this.hasRet = true;
        }

        const currentFunction = this.IRB.currentFunction;
        const name = currentFunction.name;

        // infer block
        if (this.IRB.currentFunction.returnType === "auto") {
            this.collectReturns(this.IRB.currentFunction.bodyAst);

            const first = this.IRB.currentFunction.returnTypes[0];

            const isSameType = currentFunction.returnTypes.every(
                type => type === first
            );

            if (!isSameType) {
                const bad = currentFunction.returnTypes.find(t => t !== first);

                this.IRB.emitError(
                    "TypeError",
                    `deduced conflicting return types for 'auto': '${first}' vs '${bad}'`,
                    node
                );
            }

            const retType = first;

            const fn = this.IRB.resolveFunction(name);

            // update return type

            fn.returnType = retType;

            this.IRB.currentFunction.returnType = retType;

            if (node.value.type === "CALL") {
                const fn = this.IRB.resolveFunction(node.value.name);

                if (fn) {
                    fn.returnType = retType;
                }
            }
            const llvmReturnType = this.IRB.getLLVMType(retType);

            this.IRB.currentFunction.body.unshift(
                this.IRB.currentFunction.local.join("\n")
            );
            this.IRB.currentFunction.body.unshift(
                `define ${llvmReturnType} @${this.IRB.currentFunction.mangledName} ${this.IRB.currentFunction.paramsIr} { \n entry:`
            );
        }

        const funcType = this.IRB.currentFunction.returnType;

        this.IRB.currentFunction.hasReturn = true;

        if (funcType === "void") {
            this.IRB.emit("ret void");
            return;
        }

        const isStruct = this.IRB.hasStruct(funcType);
        
        const isNativeABI = this.isPtrReturn(funcType);

        if (isStruct && !isNativeABI) {
            // STRUCT RETURN (sret, value semantics)
            const params = this.IRB.currentFunction.params;
            const struct = this.IRB.getStruct(funcType);

            let expr = null;

            if (node.value.type === "STRUCT_LITERAL") {
                expr = {
                    isStruct: true,
                    type: funcType
                };

                const ptr = this.IRB.emitStructLiteral(funcType, node.value);

                if (ptr.needsLoad) {
                    const t = this.IRB.newTemp();
                    this.IRB.emit(`${t} = load ptr, ptr ${ptr.ptr}`);
                    ptr.ptr = t;
                }

                expr.ptr = ptr.ptr;
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
                this.IRB.emit("ret void");
                return;
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

        if (isStruct && isNativeABI && node.value.type === "STRUCT_LITERAL") {
            const ptr = this.IRB.emitStructLiteral(funcType, node.value);

            let value = ptr.ptr;

            if (ptr.needsLoad) {
                const t = this.IRB.newTemp();
                this.IRB.emit(`${t} = load ptr, ptr ${ptr.ptr}`);
                value = t;
            }

            this.IRB.emit(`ret ptr ${value}`);
            return;
        }

        let listGeneric = this.IRB.currentFunction.listGeneric; // list return have type context. so pass it to handleExpression

        const expr = this.expr.handleExpression(node.value, false, listGeneric);


        this.IRB.emitExpr(expr);

        if (expr.llvmType?.startsWith("[")) {
            this.IRB.emitError(
                "TypeError",
                `function ${name} cannot return array`,
                node
            );
        }

        if (expr?.isList) {
            if (!this.IRB.currentFunction.isList) {
                this.IRB.emitError(
                    "TypeError",
                    `function ${name} expected ${funcType} but got ${expr.type}`,
                    node
                );
            }

            if (expr?.fromParam || expr?.isListLiteral) {
                // param already holds list pointer
                this.IRB.emit(`ret ptr ${expr.ptr}`);
            } else {
                // local variable (stack slot) needs load
                const t = this.IRB.newTemp();
                this.IRB.emit(`${t} = load ptr, ptr ${expr.ptr}`);
                this.IRB.emit(`ret ptr ${t}`);
            }

            return;
        }

        // type check
        if (expr.type !== funcType) {
            this.IRB.emitError(
                "TypeError",
                `function ${name} expected ${funcType} but got ${expr.type}`,
                node
            );
        }

        if (isNativeABI) {
            let value = expr.ptr;

            if (expr.needsLoad) {
                const tmp = this.IRB.newTemp();
                this.IRB.emit(`${tmp} = load ptr, ptr ${expr.ptr}`);
                value = tmp;
            }

            this.IRB.emit(`ret ptr ${value}`);
            return;
        }

        this.IRB.emit(`ret ${expr.llvmType} ${expr.ptr}`);
    }

    handleFunction(node) {
        if (node.name === "main") {
            this.IRB.emitError(
                "ReservedFunctionError",
                "'main' is a reserved function name",
                node
            );
        }

        this.haveBareRet = false;

        this.IRB.funcTempCounter = 0; // reset counter per function
        const savedAllocaBuff = this.IRB.allocaBuff;
        this.IRB.allocaBuff = [];

        const isDecl = node.isDeclaration;
        const isExtern = node.isExtern;

        if (node.body !== null)
            this.globalState.defFunctions.set(node.name, true);
        if (isDecl && !isExtern)
            this.globalState.declFunctions.set(node.name, true);

        if (this.IRB.currentFunction !== null) {
            this.IRB.emitError(
                "SemanticError",
                "Nested functions are not supported",
                node
            );
        }

        const isMethod = node?.isMethod;

        const prevFunction = this.IRB.currentFunction;

        let local = [];

        let name;
        let mangledName;
        if (isMethod) {
            name = `${node.structName}_${node.name}`;
            mangledName = name;
        } else {
            name = node.name;
            if (isExtern) {
                mangledName = name;
            } else if (this.IRB.stdlibMode) {
                mangledName = name;
            } else {
                mangledName = `zen_${this.moduleName}_${name}`;
            }
        }

        let returnType =
            node.returnType === "void" ? "void" : node.returnType.type; // exclude auto infer for now

        const listGeneric = {};

        if (returnType === "List") {
            const generic = node.returnType.generic;
            listGeneric.generic = generic;
            listGeneric.type = this.IRB.getDeepestGeneric(generic);
            listGeneric.depth = this.IRB.getListDepth(generic);
        }

        if (!isDecl) {
            if (returnType !== "void" && !this.hasGuaranteedReturn(node.body)) {
                this.IRB.emitError(
                    "SemanticError",
                    `not all code paths return a value`,
                    node
                );
            }
        }

        let llvmReturnType =
            returnType === "void" ? "void" : this.IRB.getLLVMType(returnType); // exclude auto for now

        const isSret = this.IRB.hasStruct(returnType);

        if (isSret && this.isPtrReturn(returnType)) {
            llvmReturnType = "ptr";
        } else if (isSret) {
            llvmReturnType = "void";
        }

        const params = node.params;

        this.IRB.currentFunction = true; // make currentFunction true for getting sequential temp count for params

        const {
            ir,
            params: paramData,
            types
        } = this.IRB.buildParams(params, isMethod, returnType, isExtern);

        if (isDecl && isExtern) {
            this.IRB.currentFunction = prevFunction;
            this.IRB.declareOneTime(
                name,
                `declare ${llvmReturnType} @${name} ${types}`
            );
            return;
        }

        if (isDecl) {
            this.IRB.currentFunction = prevFunction;

            const fn = this.IRB.functions.get(name);

            // A definition exists in this module, so don't emit a declare.
            if (!fn.isDeclaration) {
                return;
            }

            this.IRB.declareOneTime(
                mangledName,
                `declare ${llvmReturnType} @${mangledName} ${types}`
            );
            return;
        }

        this.IRB.currentFunction = {
            name,
            mangledName,
            body: [],
            bodyAst: node.body,
            isList: returnType === "List",
            listGeneric,
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

                const deepestType = this.IRB.getDeepestGeneric(p.generic);

                this.IRB.setVar(
                    p.name,
                    this.IRB.createData({
                        ptr: p.ptr,
                        llvmType: p.llvmType,
                        generic: p.generic,
                        type: deepestType,
                        isConstant: p.isConstant,
                        isGlobal: false,
                        isList: true,
                        fromParam: true,
                        needsLoad: false,
                        pIndex: p.pIndex,
                        ownerId: this.IRB.genOwnerId()
                    })
                );
            } else if (p?.isMethod) {
                this.IRB.setVar(
                    p.name,
                    this.IRB.createData({
                        ptr: p.ptr,
                        llvmType: p.llvmType,
                        type: p.type,
                        isConstant: p.isConstant,
                        isGlobal: false,
                        fromParam: true,
                        isStruct: true
                    })
                );
            } else if (
                p?.isStruct &&
                this.BUILTIN_STRUCT_ABI.includes(p.type)
            ) {
                // sized-but-ptr-ABI structs (e.g. Ptr) — always a raw ptr, no load needed
                this.IRB.setVar(
                    p.name,
                    this.IRB.createData({
                        ptr: p.ptr,
                        llvmType: "ptr",
                        type: p.type,
                        isConstant: p.isConstant,
                        isGlobal: false,
                        fromParam: true,
                        isStruct: true,
                        needsLoad: false
                    })
                );
            } else if (p?.isStruct) {
                const struct = this.IRB.getStruct(p.type);

                const localPtr = `%${p.name}.addr`;

                if (struct?.isBuiltin && struct.isOpaque) {
                    // reference semantics — param value is already a ptr, just store it
                    local.push(`${localPtr} = alloca ptr`);
                    local.push(`store ptr ${p.ptr}, ptr ${localPtr}`);

                    this.IRB.setVar(
                        p.name,
                        this.IRB.createData({
                            ptr: localPtr,
                            llvmType: "ptr",
                            type: p.type,
                            isConstant: p.isConstant,
                            isGlobal: false,
                            fromParam: true,
                            isStruct: true,
                            needsLoad: true
                        })
                    );

                    continue;
                }

                // existing value-struct path (unchanged)
                local.push(`${localPtr} = alloca %${p.type}`);

                this.IRB.declareOneTime(
                    "llvm.memcpy.p0.p0.i64",
                    "declare void @llvm.memcpy.p0.p0.i64(ptr, ptr, i64, i1)"
                );

                local.push(
                    `call void @llvm.memcpy.p0.p0.i64(` +
                        `ptr ${localPtr}, ptr ${p.ptr}, i64 ${struct.byteSize}, i1 false)`
                );

                this.IRB.setVar(
                    p.name,
                    this.IRB.createData({
                        ptr: localPtr,
                        llvmType: p.llvmType,
                        type: p.type,
                        isConstant: p.isConstant,
                        isGlobal: false,
                        fromParam: true,
                        isStruct: true
                    })
                );
            } else if (p.isRest) {
                this.IRB.declareOneTime(
                    "ZenList",
                    "%ZenList = type { ptr, i32, i32, i64 }"
                );
                // update symbol table
                this.IRB.setVar(
                    p.name,
                    this.IRB.createData({
                        ptr: p.ptr,
                        llvmType: "ptr",
                        type: p.type,
                        generic: { generic: { type: p.type } },
                        isConstant: p.isConstant,
                        isGlobal: false,
                        isList: true,
                        needsLoad: false,
                        fromParam: true
                    })
                );
            } else if (p?.isFunction) {
                const returnType = p.returnType.type;

                const retGeneric =
                    returnType === "List"
                        ? this.IRB.getDeepestGeneric(p.returnType.generic)
                        : returnType;

                const generic = returnType === "List" ? p.returnType : null;

                this.IRB.functionParamTable.set(p.name, {
                    name: p.name,
                    returnType,
                    params: p.params,
                    retGeneric,
                    generic,
                    type: "Function",
                    isFunction: true,
                    ptr: p.temp,
                    llvmType: "ptr",
                    isFunctionParam: true,
                    isThread: false
                });
            } else {
                let ptr = `%${p.name}.addr`;

                // alloca
                local.push(`${ptr} = alloca ${p.llvmType}`); // always push to local for infering

                // store incoming param (p.temp)
                local.push(`store ${p.llvmType} ${p.temp}, ptr ${ptr}`);

                // update symbol table
                this.IRB.setVar(
                    p.name,
                    this.IRB.createData({
                        ptr,
                        llvmType: p.llvmType,
                        type: p.type,
                        isConstant: p.isConstant,
                        isGlobal: false,
                        needsLoad: true,
                        fromParam: true
                    })
                );
            }
        }

        if (returnType !== "auto") {
            this.IRB.emit(local.join("\n"));
        }

        this.block.block(node.body);

        this.IRB.currentFunction.body.splice(
            2,
            0,
            this.IRB.allocaBuff.join("\n")
        );

        if (returnType === "void" && this.hasRet) {
            this.IRB.emitError(
                "TypeError",
                `Function '${name}' has a void return type and cannot return a value`,
                node
            );
        }

        if (!this.hasGuaranteedReturn(node.body)) {
            if (returnType === "int") {
                this.IRB.emit("ret i32 0");
            } else if (returnType === "bool") {
                this.IRB.emit("ret i1 0");
            } else if (returnType === "double") {
                this.IRB.emit("ret double 0.0");
            } else if (returnType === "string") {
                this.IRB.emit("ret ptr null");
            }  else if (returnType === "long") {
    this.IRB.emit("ret i64 0");
            }  else if (this.isPtrReturn(returnType)) {
                this.IRB.emit("ret ptr null");
            } else {
                this.IRB.emit("ret void");
            }
        }

        this.IRB.emit("}");

        this.IRB.exitScope();

        this.IRB.functionBuff.push(this.IRB.currentFunction.body.join("\n"));

        this.IRB.currentFunction = prevFunction;
        this.hasRet = false; // reset state
        this.IRB.allocaBuff = savedAllocaBuff;
    }
}
