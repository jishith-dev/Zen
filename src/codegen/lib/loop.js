import { SCALAR_TYPES } from "../../config/config.js";

export class Loop {
  constructor(IRB, expr, variable, block) {
    this.IRB = IRB;
    this.variable = variable;
    this.block = block;
    this.expr = expr;
  }

  loop(node) {
    this.IRB.guardStackOp("LOOP", node);

    const { init, condition, update } = node;

    this.IRB.enterScope();

    if (init !== null) {
      if (SCALAR_TYPES.includes(init.dataType)) {
        this.variable.scalarVariable(init, false);
      } else {
        this.variable.stringVariable(init, false);
      }
    }

    const condLabel = this.IRB.newLabel("loopCond");
    const bodyLabel = this.IRB.newLabel("loopBody");
    const endLabel = this.IRB.newLabel("loopEnd");
    const updateLabel = this.IRB.newLabel("loopUpdate");

    this.IRB.loopStack.push({
      breakLabel: endLabel,
      continueLabel: updateLabel,
    });

    this.IRB.emit(`br label %${condLabel}`);

    this.IRB.emit(`${condLabel}:`);

    const expr = this.expr.handleExpression(condition, false);

    this.IRB.emitExpr(expr);

    const condPtr =
      expr.llvmType === "i1"
        ? expr.ptr
        : this.IRB.toI1(expr.ptr, expr.llvmType);

    this.IRB.emit(`br i1 ${condPtr}, label %${bodyLabel}, label %${endLabel}`);

    this.IRB.emit(`${bodyLabel}:`);

    this.block.block(node.body);

    this.IRB.emit(`br label %${updateLabel}`);

    this.IRB.emit(`${updateLabel}:`);

    const normalisedNode = this.IRB.normalizeUpdateToExpr(update, update.name);

    let updateExpr = this.expr.handleExpression(normalisedNode.value, false);

    this.IRB.emitExpr(updateExpr);

    const varPtr = this.IRB.getVar(normalisedNode.name).ptr;

    this.IRB.emit(
      `store ${updateExpr.llvmType} ${updateExpr.ptr}, ptr ${varPtr}`,
    );

    // loop back
    this.IRB.emit(`br label %${condLabel}`);

    this.IRB.emit(`${endLabel}:`);

    this.IRB.loopStack.pop();
    this.IRB.exitScope();
  }

  handleBreak(node) {
    const loop = this.IRB.loopStack[this.IRB.loopStack.length - 1];

    if (!loop) {
      this.IRB.emitError("SyntaxError", "break used outside loop", node);
    }

    this.IRB.loopBlockTerminated = true;
    this.IRB.emit(`br label %${loop.breakLabel}`);
  }

  handleContinue(node) {
    const loop = this.IRB.loopStack[this.IRB.loopStack.length - 1];

    if (!loop) {
      this.IRB.emitError("SyntaxError", "continue used outside loop", node);
    }

    this.IRB.loopIterationSkipped = true;
    this.IRB.emit(`br label %${loop.continueLabel}`);
  }

  whileLoop(node) {
    this.IRB.guardStackOp("WHILE_LOOP", node);

    const condition = node.condition;
    const body = node.body;

    this.IRB.enterScope();

    const condLabel = this.IRB.newLabel("whileCond");
    const bodyLabel = this.IRB.newLabel("whileBody");
    const endLabel = this.IRB.newLabel("whileEnd");

    this.IRB.loopStack.push({
      breakLabel: endLabel,
      continueLabel: condLabel,
    });

    this.IRB.emit(`br label %${condLabel}`);

    // condition
    this.IRB.emit(`${condLabel}:`);

    const expr = this.expr.handleExpression(condition, false);

    this.IRB.emitExpr(expr);

    const condPtr =
      expr.llvmType === "i1"
        ? expr.ptr
        : this.IRB.toI1(expr.ptr, expr.llvmType);

    this.IRB.emit(`br i1 ${condPtr}, label %${bodyLabel}, label %${endLabel}`);

    // body
    this.IRB.emit(`${bodyLabel}:`);

    this.block.block(body);

    // loop back to condition
    this.IRB.emit(`br label %${condLabel}`);

    this.IRB.emit(`${endLabel}:`);

    this.IRB.loopStack.pop();
    this.IRB.exitScope();
  }

  doWhileLoop(node) {
    this.IRB.guardStackOp("DO_WHILE_LOOP", node);

    const body = node.body;
    const condition = node.condition;

    this.IRB.enterScope();

    const bodyLabel = this.IRB.newLabel("doWhileBody");
    const condLabel = this.IRB.newLabel("doWhileCond");
    const endLabel = this.IRB.newLabel("doWhileEnd");

    this.IRB.loopStack.push({
      breakLabel: endLabel,
      continueLabel: condLabel,
    });

    // ENTRY BODY

    this.IRB.emit(`br label %${bodyLabel}`);

    this.IRB.emit(`${bodyLabel}:`);

    this.block.block(body);

    this.IRB.emit(`br label %${condLabel}`);

    // CONDITION

    this.IRB.emit(`${condLabel}:`);

    const expr = this.expr.handleExpression(condition, false);

    this.IRB.emitExpr(expr);

    const condPtr =
      expr.llvmType === "i1"
        ? expr.ptr
        : this.IRB.toI1(expr.ptr, expr.llvmType);

    this.IRB.emit(`br i1 ${condPtr}, label %${bodyLabel}, label %${endLabel}`);

    this.IRB.emit(`${endLabel}:`);

    this.IRB.loopStack.pop();
    this.IRB.exitScope();
  }

  loopOf(node) {
    this.IRB.guardStackOp("LOOP_OF", node);

    const { varName, iterable, body } = node;

    this.IRB.enterScope();

    const startLabel = this.IRB.newLabel("arr_start");
    const bodyLabel = this.IRB.newLabel("arr_body");
    const endLabel = this.IRB.newLabel("arr_end");
    const incLabel = this.IRB.newLabel("arr_inc");

    this.IRB.loopStack.push({
      breakLabel: endLabel,
      continueLabel: incLabel,
    });

    // index = 0

    const indexPtr = this.IRB.newTemp();
    this.IRB.emitAlloca(indexPtr, `i32`);

    this.IRB.emit(`store i32 0, ptr ${indexPtr}`);

    const expr = this.expr.handleExpression(iterable, false);

    this.IRB.emitExpr(expr);

    let varType = null;
    let llvmVarType = null;

    if (!expr.isArray && !expr.isList) {
      this.IRB.emitError(
        "TypeError",
        "loop of supports only array or list",
        node,
      );
    }

    let len;
    if (expr.isArray) {
      len = expr.length;
      varType = expr.type;
      llvmVarType = this.IRB.getLLVMType(varType);
    } else if (expr.isList) {
      this.IRB.declareOneTime(
        "zen_list_get",
        "declare ptr @_zen_list_get(ptr, i32)",
      );
      varType = expr.type;
      llvmVarType = this.IRB.getLLVMType(varType);
      const gep = this.IRB.newTemp();
      let tm = this.IRB.newTemp();
      if (expr.needsLoad) {
        this.IRB.emit(`${tm} = load ptr, ptr ${expr.ptr}`);
      } else {
        tm = expr.ptr;
      }

      this.IRB.emit(
        `${gep} = getelementptr inbounds %ZenList, ptr ${tm}, i32 0, i32 1`,
      );

      const val = this.IRB.newTemp();

      this.IRB.emit(`${val} = load i32, ptr ${gep}`);
      len = val;
    }

    this.IRB.emit(`br label %${startLabel}`);

    // CONDITION

    this.IRB.emit(`${startLabel}:`);

    const idxTmp = this.IRB.newTemp();
    this.IRB.emit(`${idxTmp} = load i32, ptr ${indexPtr}`);

    const cmpTmp = this.IRB.newTemp();
    this.IRB.emit(`${cmpTmp} = icmp slt i32 ${idxTmp}, ${len}`);

    this.IRB.emit(`br i1 ${cmpTmp}, label %${bodyLabel}, label %${endLabel}`);

    this.IRB.emit(`${bodyLabel}:`);

    let elemTmp = this.IRB.newTemp();

    if (expr.isArray) {
      this.IRB.emit(
        `${elemTmp} = getelementptr ${expr.llvmType}, ptr ${expr.ptr}, i32 0, i32 ${idxTmp}`,
      );

      const nextDims = expr.dimData?.slice(1);

      const isNested = nextDims && nextDims.length > 0;

      if (isNested) {
        const nextDims = expr.dimData?.slice(1);

        const nestedLLVM = nextDims.reduceRight(
          (inner, dim) => `[${dim} x ${inner}]`,
          llvmVarType,
        );

        this.IRB.setVar(varName, {
          ptr: elemTmp,
          type: varType,
          llvmType: nestedLLVM,
          needsLoad: false,
          isArray: true,
          length: nextDims?.[0],
          dimensionsData: nextDims,
        });
      } else {
        const valTmp = this.IRB.newTemp();
        this.IRB.emit(`${valTmp} = load ${llvmVarType}, ptr ${elemTmp}`);

        const ptr = this.IRB.newTemp();
        this.IRB.emitAlloca(ptr, `${llvmVarType}`);
        this.IRB.emit(`store ${llvmVarType} ${valTmp}, ptr ${ptr}`);

        this.IRB.setVar(varName, {
          ptr,
          type: varType,
          llvmType: llvmVarType,
          needsLoad: true,
          isArray: false,
        });
      }
    } else if (expr.isList) {
      let tm = this.IRB.newTemp();

      if (expr.needsLoad) {
        this.IRB.emit(`${tm} = load ptr, ptr ${expr.ptr}`);
      } else {
        tm = expr.ptr;
      }

      const valTmp = this.IRB.newTemp();
      this.IRB.emit(
        `${valTmp} = call ptr @_zen_list_get(ptr ${tm}, i32 ${idxTmp})`,
      );

      const nextGeneric = expr.generic?.generic ?? expr.generic;

      const isNested = nextGeneric?.type === "List";
      const isStruct = this.IRB.hasStruct(varType);
      const structDef = isStruct ? this.IRB.getStruct(varType) : null;
      const isOpaque = !!(structDef?.isBuiltin && structDef?.isOpaque);

      this.IRB.setVar(varName, {
        ptr: valTmp,
        type: varType,
        llvmType: isStruct ? "ptr" : llvmVarType,
        isList: isNested,
        isStruct,
        isFromList: true,
        isListAccess: true,
        generic: nextGeneric,
        fromLoopOf: true,
        needsLoad: !isStruct || isOpaque,
      });
    }

    this.block.block(body);

    this.IRB.emit(`br label %${incLabel}`);

    // INCREMENT

    this.IRB.emit(`${incLabel}:`);

    const incTmp = this.IRB.newTemp();
    this.IRB.emit(`${incTmp} = add i32 ${idxTmp}, 1`);

    this.IRB.emit(`store i32 ${incTmp}, ptr ${indexPtr}`);

    this.IRB.emit(`br label %${startLabel}`);

    this.IRB.emit(`${endLabel}:`);

    this.IRB.loopStack.pop();
    this.IRB.exitScope();
  }
}
