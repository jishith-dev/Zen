@INF = external local_unnamed_addr constant double
@I32_MAX = external local_unnamed_addr constant i32
@SEED = external local_unnamed_addr global i64
@TAU = external local_unnamed_addr constant double
@PI = external local_unnamed_addr constant double
@.str_stdlib_stdlib_0 = private unnamed_addr constant [1 x i8] zeroinitializer
@.str_stdlib_stdlib_1 = private unnamed_addr constant [2 x i8] c"a\00"
@.str_stdlib_stdlib_2 = private unnamed_addr constant [2 x i8] c"z\00"
@.str_stdlib_stdlib_3 = private unnamed_addr constant [2 x i8] c"A\00"
@.str_stdlib_stdlib_4 = private unnamed_addr constant [2 x i8] c"Z\00"
@.str_stdlib_stdlib_5 = private unnamed_addr constant [2 x i8] c" \00"
@.str_stdlib_stdlib_6 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str_stdlib_stdlib_7 = private unnamed_addr constant [2 x i8] c"\09\00"
@.str_stdlib_stdlib_8 = private unnamed_addr constant [2 x i8] c".\00"
@.str_stdlib_stdlib_9 = private unnamed_addr constant [2 x i8] c"|\00"
@.str_stdlib_stdlib_10 = private unnamed_addr constant [2 x i8] c"?\00"
@.str_stdlib_stdlib_11 = private unnamed_addr constant [2 x i8] c"*\00"
@.str_stdlib_stdlib_12 = private unnamed_addr constant [2 x i8] c"#\00"
@.str_stdlib_stdlib_13 = private unnamed_addr constant [2 x i8] c"d\00"
@.str_stdlib_stdlib_14 = private unnamed_addr constant [2 x i8] c"0\00"
@.str_stdlib_stdlib_15 = private unnamed_addr constant [2 x i8] c"9\00"
@.str_stdlib_stdlib_16 = private unnamed_addr constant [53 x i8] c"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\00"
@.str_stdlib_stdlib_17 = private unnamed_addr constant [2 x i8] c"x\00"
@.str_stdlib_stdlib_18 = private unnamed_addr constant [63 x i8] c"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\00"
@.str_stdlib_stdlib_19 = private unnamed_addr constant [2 x i8] c"s\00"
@.str_stdlib_stdlib_20 = private unnamed_addr constant [2 x i8] c":\00"
@.str_stdlib_stdlib_21 = private unnamed_addr constant [5 x i8] c":int\00"
@.str_stdlib_stdlib_22 = private unnamed_addr constant [2 x i8] c"-\00"
@.str_stdlib_stdlib_23 = private unnamed_addr constant [4 x i8] c":id\00"
@.str_stdlib_stdlib_24 = private unnamed_addr constant [2 x i8] c"_\00"
@.str_stdlib_stdlib_25 = private unnamed_addr constant [8 x i8] c":string\00"
@.str_stdlib_stdlib_26 = private unnamed_addr constant [2 x i8] c"[\00"
@.str_stdlib_stdlib_27 = private unnamed_addr constant [2 x i8] c"]\00"
@.str_stdlib_stdlib_28 = private unnamed_addr constant [2 x i8] c",\00"
@.str_stdlib_stdlib_29 = private unnamed_addr constant [2 x i8] c"\0D\00"
@.str_stdlib_stdlib_30 = private unnamed_addr constant [2 x i8] c"\22\00"
@.str_stdlib_stdlib_31 = private unnamed_addr constant [2 x i8] c"{\00"
@.str_stdlib_stdlib_32 = private unnamed_addr constant [2 x i8] c"}\00"
@.str_stdlib_stdlib_33 = private unnamed_addr constant [5 x i8] c"null\00"

declare void @_zen_list_set_meta(ptr, i32, i32) local_unnamed_addr

declare void @_zen_list_push(ptr, ptr) local_unnamed_addr

declare ptr @_zen_list_new(i64) local_unnamed_addr

declare ptr @_int_to_string_ascii(i32) local_unnamed_addr

declare void @_zen_string_free(ptr) local_unnamed_addr

declare i32 @_string_to_int_ascii(ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: read)
declare i32 @strcmp(ptr captures(none), ptr captures(none)) local_unnamed_addr #0

declare ptr @_str_concat(ptr, ptr) local_unnamed_addr

declare ptr @_zen_char_to_string(i8) local_unnamed_addr

declare ptr @_str_dup(ptr) local_unnamed_addr

declare i32 @strlen(ptr) local_unnamed_addr

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @_zen_std_isEven(i32 %t0) local_unnamed_addr #1 {
entry:
  %0 = and i32 %t0, 1
  %t3 = icmp eq i32 %0, 0
  ret i1 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @_zen_std_isOdd(i32 %t0) local_unnamed_addr #1 {
entry:
  %0 = and i32 %t0, 1
  %t3 = icmp ne i32 %0, 0
  ret i1 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @_zen_std_isPositive(i32 %t0) local_unnamed_addr #1 {
entry:
  %t2 = icmp sgt i32 %t0, 0
  ret i1 %t2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @_zen_std_isNegative(i32 %t0) local_unnamed_addr #1 {
entry:
  %t2 = icmp slt i32 %t0, 0
  ret i1 %t2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @_zen_std_isNaN(double %t0) local_unnamed_addr #1 {
entry:
  %t3 = fcmp uno double %t0, 0.000000e+00
  ret i1 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define range(i32 0, -2147483647) i32 @_zen_std_abs(i32 %t0) local_unnamed_addr #1 {
entry:
  %common.ret.op = tail call i32 @llvm.abs.i32(i32 %t0, i1 false)
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_max(i32 %t0, i32 %t1) local_unnamed_addr #1 {
entry:
  %common.ret.op = tail call i32 @llvm.smax.i32(i32 %t0, i32 %t1)
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_min(i32 %t0, i32 %t1) local_unnamed_addr #1 {
entry:
  %common.ret.op = tail call i32 @llvm.smin.i32(i32 %t0, i32 %t1)
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_clamp(i32 %t0, i32 %t1, i32 %t2) local_unnamed_addr #1 {
entry:
  %t5 = icmp slt i32 %t0, %t1
  %t2.t0 = tail call i32 @llvm.smin.i32(i32 %t0, i32 %t2)
  %common.ret.op = select i1 %t5, i32 %t1, i32 %t2.t0
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define range(i32 -1, 2) i32 @_zen_std_sign(i32 %t0) local_unnamed_addr #1 {
entry:
  %t0.lobit = ashr i32 %t0, 31
  %t2.inv = icmp slt i32 %t0, 1
  %common.ret.op = select i1 %t2.inv, i32 %t0.lobit, i32 1
  ret i32 %common.ret.op
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_pow(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t3 = icmp eq i32 %t1, 0
  br i1 %t3, label %common.ret, label %end14

common.ret:                                       ; preds = %whileBody29, %whileEnd30, %end14, %if17, %if23, %entry, %if34
  %common.ret.op = phi double [ %t42, %if34 ], [ 1.000000e+00, %entry ], [ %., %if23 ], [ %spec.select, %if17 ], [ 1.000000e+00, %end14 ], [ %t23.0.lcssa, %whileEnd30 ], [ %t34, %whileBody29 ]
  ret double %common.ret.op

end14:                                            ; preds = %entry
  switch i32 %t0, label %end22 [
    i32 0, label %if17
    i32 1, label %common.ret
    i32 -1, label %if23
  ]

if17:                                             ; preds = %end14
  %t7 = icmp sgt i32 %t1, 0
  %t8 = load double, ptr @INF, align 8
  %spec.select = select i1 %t7, double 0.000000e+00, double %t8
  br label %common.ret

if23:                                             ; preds = %end14
  %0 = and i32 %t1, 1
  %t15 = icmp eq i32 %0, 0
  %. = select i1 %t15, double 1.000000e+00, double -1.000000e+00
  br label %common.ret

end22:                                            ; preds = %end14
  %t18 = icmp slt i32 %t1, 0
  %spec.select10 = tail call i32 @llvm.abs.i32(i32 %t1, i1 false)
  %t2712 = icmp sgt i32 %spec.select10, 0
  br i1 %t2712, label %whileBody29.lr.ph, label %whileEnd30

whileBody29.lr.ph:                                ; preds = %end22
  %t30 = sitofp i32 %t0 to double
  %t34 = load double, ptr @INF, align 8
  br label %whileBody29

whileCond28:                                      ; preds = %whileBody29
  %t38 = add nuw nsw i32 %t24.014, 1
  %t27 = icmp slt i32 %t38, %spec.select10
  br i1 %t27, label %whileBody29, label %whileEnd30

whileBody29:                                      ; preds = %whileBody29.lr.ph, %whileCond28
  %t24.014 = phi i32 [ 0, %whileBody29.lr.ph ], [ %t38, %whileCond28 ]
  %t23.013 = phi double [ 1.000000e+00, %whileBody29.lr.ph ], [ %t31, %whileCond28 ]
  %t31 = fmul double %t23.013, %t30
  %t35 = fcmp oeq double %t31, %t34
  br i1 %t35, label %common.ret, label %whileCond28

whileEnd30:                                       ; preds = %whileCond28, %end22
  %t23.0.lcssa = phi double [ 1.000000e+00, %end22 ], [ %t31, %whileCond28 ]
  br i1 %t18, label %if34, label %common.ret

if34:                                             ; preds = %whileEnd30
  %t42 = fdiv double 1.000000e+00, %t23.0.lcssa
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_sqrt(double %t0) local_unnamed_addr #2 {
entry:
  %t2 = fcmp olt double %t0, 0.000000e+00
  br i1 %t2, label %common.ret, label %end35

common.ret:                                       ; preds = %loopBody40, %end35, %entry
  %common.ret.op = phi double [ -1.000000e+00, %entry ], [ 0.000000e+00, %end35 ], [ %t18, %loopBody40 ]
  ret double %common.ret.op

end35:                                            ; preds = %entry
  %t5 = fcmp oeq double %t0, 0.000000e+00
  br i1 %t5, label %common.ret, label %loopBody40

loopBody40:                                       ; preds = %end35, %loopBody40
  %t7.03 = phi double [ %t18, %loopBody40 ], [ %t0, %end35 ]
  %t10.02 = phi i32 [ %t27, %loopBody40 ], [ 0, %end35 ]
  %t16 = fdiv double %t0, %t7.03
  %t17 = fadd double %t7.03, %t16
  %t18 = fmul double %t17, 5.000000e-01
  %t22 = fcmp une double %t18, %t7.03
  %t27 = add nuw nsw i32 %t10.02, 1
  %t12 = icmp samesign ult i32 %t10.02, 49
  %or.cond = select i1 %t22, i1 %t12, i1 false
  br i1 %or.cond, label %loopBody40, label %common.ret
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_square(i32 %t0) local_unnamed_addr #1 {
entry:
  %t3 = mul i32 %t0, %t0
  ret i32 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_cube(i32 %t0) local_unnamed_addr #1 {
entry:
  %t3 = mul i32 %t0, %t0
  %t5 = mul i32 %t3, %t0
  ret i32 %t5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_floor(double %t0) local_unnamed_addr #1 {
entry:
  %t2 = fptosi double %t0 to i32
  %t6 = fcmp olt double %t0, 0.000000e+00
  %t11 = sitofp i32 %t2 to double
  %t10 = fcmp une double %t0, %t11
  %t4 = select i1 %t6, i1 %t10, i1 false
  %t13 = sext i1 %t4 to i32
  %common.ret.op = add i32 %t13, %t2
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_ceil(double %t0) local_unnamed_addr #1 {
entry:
  %t2 = fptosi double %t0 to i32
  %t7 = sitofp i32 %t2 to double
  %t6 = fcmp une double %t0, %t7
  %t10 = fcmp ogt double %t0, 0.000000e+00
  %or.cond = and i1 %t10, %t6
  %t13 = zext i1 %or.cond to i32
  %spec.select = add i32 %t13, %t2
  ret i32 %spec.select
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_round(double %t0) local_unnamed_addr #1 {
entry:
  %t2 = fptosi double %t0 to i32
  %t7 = sitofp i32 %t2 to double
  %t8 = fsub double %t0, %t7
  %t10 = fcmp ult double %t0, 0.000000e+00
  br i1 %t10, label %end54, label %if55

if55:                                             ; preds = %entry
  %t13 = fcmp ult double %t8, 5.000000e-01
  br i1 %t13, label %common.ret, label %if57

common.ret:                                       ; preds = %end54, %if55, %if59, %if57
  %common.ret.op = phi i32 [ %t15, %if57 ], [ %t20, %if59 ], [ %t2, %if55 ], [ %t2, %end54 ]
  ret i32 %common.ret.op

if57:                                             ; preds = %if55
  %t15 = add i32 %t2, 1
  br label %common.ret

end54:                                            ; preds = %entry
  %t18 = fcmp ugt double %t8, -5.000000e-01
  br i1 %t18, label %common.ret, label %if59

if59:                                             ; preds = %end54
  %t20 = add i32 %t2, -1
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_toFixed(double %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t3 = icmp slt i32 %t1, 0
  br i1 %t3, label %common.ret, label %end60

common.ret:                                       ; preds = %entry, %_zen_std_round.exit
  %common.ret.op = phi double [ %t18, %_zen_std_round.exit ], [ %t0, %entry ]
  ret double %common.ret.op

end60:                                            ; preds = %entry
  %t3.i = icmp eq i32 %t1, 0
  br i1 %t3.i, label %_zen_std_pow.exit, label %whileBody29.lr.ph.i

whileBody29.lr.ph.i:                              ; preds = %end60
  %t34.i = load double, ptr @INF, align 8
  br label %whileBody29.i

whileCond28.i:                                    ; preds = %whileBody29.i
  %t38.i = add nuw nsw i32 %t24.014.i, 1
  %t27.i = icmp slt i32 %t38.i, %t1
  br i1 %t27.i, label %whileBody29.i, label %_zen_std_pow.exit

whileBody29.i:                                    ; preds = %whileCond28.i, %whileBody29.lr.ph.i
  %t24.014.i = phi i32 [ 0, %whileBody29.lr.ph.i ], [ %t38.i, %whileCond28.i ]
  %t23.013.i = phi double [ 1.000000e+00, %whileBody29.lr.ph.i ], [ %t31.i, %whileCond28.i ]
  %t31.i = fmul double %t23.013.i, 1.000000e+01
  %t35.i = fcmp oeq double %t31.i, %t34.i
  br i1 %t35.i, label %_zen_std_pow.exit, label %whileCond28.i

_zen_std_pow.exit:                                ; preds = %whileCond28.i, %whileBody29.i, %end60
  %common.ret.op.i = phi double [ 1.000000e+00, %end60 ], [ %t31.i, %whileCond28.i ], [ %t34.i, %whileBody29.i ]
  %t11 = fmul double %t0, %common.ret.op.i
  %t2.i = fptosi double %t11 to i32
  %t7.i = sitofp i32 %t2.i to double
  %t8.i = fsub double %t11, %t7.i
  %t10.i = fcmp ult double %t11, 0.000000e+00
  br i1 %t10.i, label %end54.i, label %if55.i

if55.i:                                           ; preds = %_zen_std_pow.exit
  %t13.i = fcmp ult double %t8.i, 5.000000e-01
  br i1 %t13.i, label %_zen_std_round.exit, label %if57.i

if57.i:                                           ; preds = %if55.i
  %t15.i = add i32 %t2.i, 1
  br label %_zen_std_round.exit

end54.i:                                          ; preds = %_zen_std_pow.exit
  %t18.i3 = fcmp ugt double %t8.i, -5.000000e-01
  br i1 %t18.i3, label %_zen_std_round.exit, label %if59.i

if59.i:                                           ; preds = %end54.i
  %t20.i = add i32 %t2.i, -1
  br label %_zen_std_round.exit

_zen_std_round.exit:                              ; preds = %if55.i, %if57.i, %end54.i, %if59.i
  %common.ret.op.i2 = phi i32 [ %t15.i, %if57.i ], [ %t20.i, %if59.i ], [ %t2.i, %if55.i ], [ %t2.i, %end54.i ]
  %t17 = sitofp i32 %common.ret.op.i2 to double
  %t18 = fdiv double %t17, %common.ret.op.i
  br label %common.ret
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @_zen_std_mod(i32 %t0, i32 %t1) local_unnamed_addr #1 {
entry:
  %spec.select = tail call i32 @llvm.abs.i32(i32 %t1, i1 false)
  %t10 = srem i32 %t0, %spec.select
  %t12 = icmp slt i32 %t10, 0
  %t15 = select i1 %t12, i32 %spec.select, i32 0
  %common.ret.op = add i32 %t15, %t10
  ret i32 %common.ret.op
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define i32 @_zen_std_gcd(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %common.ret.op.i = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t0, i1 false)
  %t7.not7 = icmp eq i32 %t1, 0
  br i1 %t7.not7, label %whileEnd68, label %whileBody67.preheader

whileBody67.preheader:                            ; preds = %entry
  %common.ret.op.i6 = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t1, i1 false)
  br label %whileBody67

whileBody67:                                      ; preds = %whileBody67.preheader, %whileBody67
  %b.addr.09 = phi i32 [ %t12, %whileBody67 ], [ %common.ret.op.i6, %whileBody67.preheader ]
  %a.addr.08 = phi i32 [ %b.addr.09, %whileBody67 ], [ %common.ret.op.i, %whileBody67.preheader ]
  %t12 = srem i32 %a.addr.08, %b.addr.09
  %t7.not = icmp eq i32 %t12, 0
  br i1 %t7.not, label %whileEnd68, label %whileBody67

whileEnd68:                                       ; preds = %whileBody67, %entry
  %a.addr.0.lcssa = phi i32 [ %common.ret.op.i, %entry ], [ %b.addr.09, %whileBody67 ]
  ret i32 %a.addr.0.lcssa
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define range(i32 0, -2147483647) i32 @_zen_std_lcm(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t4 = icmp eq i32 %t0, 0
  %t6 = icmp eq i32 %t1, 0
  %t2 = select i1 %t4, i1 true, i1 %t6
  br i1 %t2, label %common.ret, label %whileBody67.preheader.i

common.ret:                                       ; preds = %entry, %_zen_std_gcd.exit
  %common.ret.op = phi i32 [ %common.ret.op.i, %_zen_std_gcd.exit ], [ 0, %entry ]
  ret i32 %common.ret.op

whileBody67.preheader.i:                          ; preds = %entry
  %common.ret.op.i.i = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t0, i1 false)
  %common.ret.op.i6.i = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t1, i1 false)
  br label %whileBody67.i

whileBody67.i:                                    ; preds = %whileBody67.i, %whileBody67.preheader.i
  %b.addr.09.i = phi i32 [ %t12.i, %whileBody67.i ], [ %common.ret.op.i6.i, %whileBody67.preheader.i ]
  %a.addr.08.i = phi i32 [ %b.addr.09.i, %whileBody67.i ], [ %common.ret.op.i.i, %whileBody67.preheader.i ]
  %t12.i = srem i32 %a.addr.08.i, %b.addr.09.i
  %t7.not.i = icmp eq i32 %t12.i, 0
  br i1 %t7.not.i, label %_zen_std_gcd.exit, label %whileBody67.i

_zen_std_gcd.exit:                                ; preds = %whileBody67.i
  %t11 = sdiv i32 %t0, %b.addr.09.i
  %t13 = mul i32 %t11, %t1
  %common.ret.op.i = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t13, i1 false)
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_factorial(i32 %t0) local_unnamed_addr #2 {
entry:
  %t2 = icmp slt i32 %t0, 0
  br i1 %t2, label %common.ret, label %end74

common.ret:                                       ; preds = %whileBody79, %end74, %entry
  %common.ret.op = phi double [ -1.000000e+00, %entry ], [ 1.000000e+00, %end74 ], [ %t13, %whileBody79 ]
  ret double %common.ret.op

end74:                                            ; preds = %entry
  %t9.not5 = icmp eq i32 %t0, 0
  br i1 %t9.not5, label %common.ret, label %whileBody79

whileBody79:                                      ; preds = %end74, %whileBody79
  %t5.07 = phi double [ %t13, %whileBody79 ], [ 1.000000e+00, %end74 ]
  %t6.06 = phi i32 [ %t16, %whileBody79 ], [ 1, %end74 ]
  %t12 = sitofp i32 %t6.06 to double
  %t13 = fmul double %t5.07, %t12
  %t16 = add i32 %t6.06, 1
  %t9.not = icmp sgt i32 %t16, %t0
  br i1 %t9.not, label %common.ret, label %whileBody79
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define noundef i1 @_zen_std_isPrime(i32 %t0) local_unnamed_addr #2 {
entry:
  %t2 = icmp slt i32 %t0, 2
  br i1 %t2, label %common.ret, label %end81

common.ret:                                       ; preds = %_zen_std_sqrt.exit, %whileBody88, %end83, %end81, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %end81 ], [ false, %end83 ], [ %t12, %whileBody88 ], [ %t12, %_zen_std_sqrt.exit ]
  ret i1 %common.ret.op

end81:                                            ; preds = %entry
  %t4 = icmp eq i32 %t0, 2
  br i1 %t4, label %common.ret, label %end83

end83:                                            ; preds = %end81
  %0 = and i32 %t0, 1
  %t3.i = icmp eq i32 %0, 0
  br i1 %t3.i, label %common.ret, label %whileCond87.preheader

whileCond87.preheader:                            ; preds = %end83
  %t10 = uitofp nneg i32 %t0 to double
  br label %whileCond87

whileCond87:                                      ; preds = %whileBody88, %whileCond87.preheader
  %t7.0 = phi i32 [ %t19, %whileBody88 ], [ 3, %whileCond87.preheader ]
  br label %loopBody40.i

loopBody40.i:                                     ; preds = %whileCond87, %loopBody40.i
  %t7.03.i = phi double [ %t10, %whileCond87 ], [ %t18.i, %loopBody40.i ]
  %t10.02.i = phi i32 [ 0, %whileCond87 ], [ %t27.i, %loopBody40.i ]
  %t16.i = fdiv double %t10, %t7.03.i
  %t17.i = fadd double %t7.03.i, %t16.i
  %t18.i = fmul double %t17.i, 5.000000e-01
  %t22.i = fcmp une double %t18.i, %t7.03.i
  %t27.i = add nuw nsw i32 %t10.02.i, 1
  %t12.i = icmp samesign ult i32 %t10.02.i, 49
  %or.cond.i = select i1 %t22.i, i1 %t12.i, i1 false
  br i1 %or.cond.i, label %loopBody40.i, label %_zen_std_sqrt.exit

_zen_std_sqrt.exit:                               ; preds = %loopBody40.i
  %t13 = sitofp i32 %t7.0 to double
  %t12 = fcmp ult double %t18.i, %t13
  br i1 %t12, label %common.ret, label %whileBody88

whileBody88:                                      ; preds = %_zen_std_sqrt.exit
  %t16 = srem i32 %t0, %t7.0
  %t17 = icmp eq i32 %t16, 0
  %t19 = add i32 %t7.0, 2
  br i1 %t17, label %common.ret, label %whileCond87
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @_zen_std_lerp(double %t0, double %t1, double %t2) local_unnamed_addr #1 {
entry:
  %t6 = fsub double %t1, %t0
  %t8 = fmul double %t6, %t2
  %t9 = fadd double %t0, %t8
  ret double %t9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @_zen_std_normalize(double %t0, double %t1, double %t2) local_unnamed_addr #1 {
entry:
  %t5 = fcmp oeq double %t1, %t2
  br i1 %t5, label %common.ret, label %end92

common.ret:                                       ; preds = %entry, %end92
  %common.ret.op = phi double [ %t12, %end92 ], [ 0.000000e+00, %entry ]
  ret double %common.ret.op

end92:                                            ; preds = %entry
  %t8 = fsub double %t0, %t1
  %t11 = fsub double %t2, %t1
  %t12 = fdiv double %t8, %t11
  br label %common.ret
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @_zen_std_between(i32 %t0, i32 %t1, i32 %t2) local_unnamed_addr #1 {
entry:
  %t6 = icmp sge i32 %t0, %t1
  %t9 = icmp sle i32 %t0, %t2
  %t3 = select i1 %t6, i1 %t9, i1 false
  ret i1 %t3
}

define ptr @_zen_std_reverse(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t7.03 = add i32 %t2, -1
  %t114 = icmp sgt i32 %t7.03, -1
  br i1 %t114, label %whileBody98, label %whileEnd99

whileBody98:                                      ; preds = %entry, %whileBody98
  %t7.06 = phi i32 [ %t7.0, %whileBody98 ], [ %t7.03, %entry ]
  %t4.05 = phi ptr [ %t19, %whileBody98 ], [ %t6, %entry ]
  %0 = zext nneg i32 %t7.06 to i64
  %t15 = getelementptr i8, ptr %t0, i64 %0
  %t16 = load i8, ptr %t15, align 1
  %t17 = tail call ptr @_zen_char_to_string(i8 %t16)
  %t19 = tail call ptr @_str_concat(ptr %t4.05, ptr %t17)
  %t7.0 = add nsw i32 %t7.06, -1
  %t11.not = icmp eq i32 %t7.06, 0
  br i1 %t11.not, label %whileEnd99, label %whileBody98

whileEnd99:                                       ; preds = %whileBody98, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t19, %whileBody98 ]
  ret ptr %t4.0.lcssa
}

define i32 @_zen_std_indexOf(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %whileCond102.preheader

whileCond102.preheader:                           ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t15.not12 = icmp slt i32 %t14, 0
  br i1 %t15.not12, label %common.ret, label %whileCond105.preheader.lr.ph

whileCond105.preheader.lr.ph:                     ; preds = %whileCond102.preheader
  %t209 = icmp sgt i32 %t6, 0
  br label %whileCond105.preheader

common.ret:                                       ; preds = %whileCond105.preheader, %end110, %whileEnd107, %whileCond102.preheader, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ -1, %whileCond102.preheader ], [ -1, %end110 ], [ %t10.013, %whileEnd107 ], [ 0, %whileCond105.preheader ]
  ret i32 %common.ret.op

whileCond105.preheader:                           ; preds = %whileCond105.preheader.lr.ph, %end110
  %t10.013 = phi i32 [ 0, %whileCond105.preheader.lr.ph ], [ %t44, %end110 ]
  br i1 %t209, label %whileBody106, label %common.ret

whileBody106:                                     ; preds = %whileCond105.preheader, %whileBody106
  %t16.011 = phi i1 [ %spec.select, %whileBody106 ], [ true, %whileCond105.preheader ]
  %t17.010 = phi i32 [ %t39, %whileBody106 ], [ 0, %whileCond105.preheader ]
  %t24 = add i32 %t17.010, %t10.013
  %0 = sext i32 %t24 to i64
  %t25 = getelementptr i8, ptr %t0, i64 %0
  %t26 = load i8, ptr %t25, align 1
  %t27 = tail call ptr @_zen_char_to_string(i8 %t26)
  %1 = zext nneg i32 %t17.010 to i64
  %t31 = getelementptr i8, ptr %t1, i64 %1
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t35 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t27, ptr noundef nonnull dereferenceable(1) %t33)
  %t36.not = icmp eq i32 %t35, 0
  %spec.select = select i1 %t36.not, i1 %t16.011, i1 false
  %t39 = add nuw nsw i32 %t17.010, 1
  %t20 = icmp slt i32 %t39, %t6
  br i1 %t20, label %whileBody106, label %whileEnd107

whileEnd107:                                      ; preds = %whileBody106
  br i1 %spec.select, label %common.ret, label %end110

end110:                                           ; preds = %whileEnd107
  %t44 = add i32 %t10.013, 1
  %t15.not = icmp sgt i32 %t44, %t14
  br i1 %t15.not, label %common.ret, label %whileCond105.preheader
}

define i32 @_zen_std_lastIndexOf(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %end112

common.ret:                                       ; preds = %whileCond117.preheader, %end122, %whileEnd119, %end112, %entry
  %common.ret.op = phi i32 [ %t3, %entry ], [ -1, %end112 ], [ -1, %end122 ], [ %t11.014, %whileEnd119 ], [ %t14, %whileCond117.preheader ]
  ret i32 %common.ret.op

end112:                                           ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t1613 = icmp sgt i32 %t14, -1
  br i1 %t1613, label %whileCond117.preheader.lr.ph, label %common.ret

whileCond117.preheader.lr.ph:                     ; preds = %end112
  %t2110 = icmp sgt i32 %t6, 0
  br label %whileCond117.preheader

whileCond117.preheader:                           ; preds = %whileCond117.preheader.lr.ph, %end122
  %t11.014 = phi i32 [ %t14, %whileCond117.preheader.lr.ph ], [ %t45, %end122 ]
  br i1 %t2110, label %whileBody118, label %common.ret

whileBody118:                                     ; preds = %whileCond117.preheader, %whileBody118
  %t17.012 = phi i1 [ %spec.select, %whileBody118 ], [ true, %whileCond117.preheader ]
  %t18.011 = phi i32 [ %t40, %whileBody118 ], [ 0, %whileCond117.preheader ]
  %t25 = add nuw i32 %t18.011, %t11.014
  %0 = sext i32 %t25 to i64
  %t26 = getelementptr i8, ptr %t0, i64 %0
  %t27 = load i8, ptr %t26, align 1
  %t28 = tail call ptr @_zen_char_to_string(i8 %t27)
  %1 = zext nneg i32 %t18.011 to i64
  %t32 = getelementptr i8, ptr %t1, i64 %1
  %t33 = load i8, ptr %t32, align 1
  %t34 = tail call ptr @_zen_char_to_string(i8 %t33)
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t28, ptr noundef nonnull dereferenceable(1) %t34)
  %t37.not = icmp eq i32 %t36, 0
  %spec.select = select i1 %t37.not, i1 %t17.012, i1 false
  %t40 = add nuw nsw i32 %t18.011, 1
  %t21 = icmp slt i32 %t40, %t6
  br i1 %t21, label %whileBody118, label %whileEnd119

whileEnd119:                                      ; preds = %whileBody118
  br i1 %spec.select, label %common.ret, label %end122

end122:                                           ; preds = %whileEnd119
  %t45 = add nsw i32 %t11.014, -1
  %t16 = icmp sgt i32 %t11.014, 0
  br i1 %t16, label %whileCond117.preheader, label %common.ret
}

define ptr @_zen_std_slice(ptr %t0, i32 %t1, i32 %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %spec.store.select = tail call i32 @llvm.smax.i32(i32 %t1, i32 0)
  %spec.select = tail call i32 @llvm.smin.i32(i32 %t2, i32 %t4)
  %t16 = icmp sle i32 %spec.store.select, %spec.select
  %t18 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268 = icmp samesign ult i32 %spec.store.select, %spec.select
  %or.cond = select i1 %t16, i1 %t268, i1 false
  br i1 %or.cond, label %whileBody131, label %common.ret

common.ret:                                       ; preds = %whileBody131, %entry
  %common.ret.op = phi ptr [ %t18, %entry ], [ %t34, %whileBody131 ]
  ret ptr %common.ret.op

whileBody131:                                     ; preds = %entry, %whileBody131
  %t19.010 = phi ptr [ %t34, %whileBody131 ], [ %t18, %entry ]
  %t22.09 = phi i32 [ %t37, %whileBody131 ], [ %spec.store.select, %entry ]
  %0 = zext nneg i32 %t22.09 to i64
  %t30 = getelementptr i8, ptr %t0, i64 %0
  %t31 = load i8, ptr %t30, align 1
  %t32 = tail call ptr @_zen_char_to_string(i8 %t31)
  %t34 = tail call ptr @_str_concat(ptr %t19.010, ptr %t32)
  %t37 = add nuw nsw i32 %t22.09, 1
  %t26 = icmp slt i32 %t37, %spec.select
  br i1 %t26, label %whileBody131, label %common.ret
}

define ptr @_zen_std_charAt(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t7 = icmp slt i32 %t1, 0
  %t10 = icmp sge i32 %t1, %t3
  %t5 = select i1 %t7, i1 true, i1 %t10
  br i1 %t5, label %if137, label %end133

common.ret:                                       ; preds = %end133, %if137
  %common.ret.op = phi ptr [ %t12, %if137 ], [ %t17, %end133 ]
  ret ptr %common.ret.op

if137:                                            ; preds = %entry
  %t12 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

end133:                                           ; preds = %entry
  %0 = zext nneg i32 %t1 to i64
  %t15 = getelementptr i8, ptr %t0, i64 %0
  %t16 = load i8, ptr %t15, align 1
  %t17 = tail call ptr @_zen_char_to_string(i8 %t16)
  br label %common.ret
}

define ptr @_zen_std_replace(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  br i1 %t10, label %common.ret, label %whileCond140.preheader

whileCond140.preheader:                           ; preds = %entry
  %t16 = sub i32 %t4, %t7
  %t17.not22 = icmp slt i32 %t16, 0
  br i1 %t17.not22, label %common.ret, label %whileCond143.preheader.lr.ph

whileCond143.preheader.lr.ph:                     ; preds = %whileCond140.preheader
  %t2219 = icmp sgt i32 %t7, 0
  br label %whileCond143.preheader

common.ret:                                       ; preds = %end148, %whileBody154, %whileCond140.preheader, %whileEnd152, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t65, %whileEnd152 ], [ %t0, %whileCond140.preheader ], [ %t84, %whileBody154 ], [ %t0, %end148 ]
  ret ptr %common.ret.op

whileCond143.preheader:                           ; preds = %whileCond143.preheader.lr.ph, %end148
  %t12.023 = phi i32 [ 0, %whileCond143.preheader.lr.ph ], [ %t91, %end148 ]
  br i1 %t2219, label %whileBody144, label %if149.thread

if149.thread:                                     ; preds = %whileCond143.preheader
  %t4635 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %whileEnd152

whileBody144:                                     ; preds = %whileCond143.preheader, %whileBody144
  %t18.021 = phi i1 [ %spec.select, %whileBody144 ], [ true, %whileCond143.preheader ]
  %t19.020 = phi i32 [ %t41, %whileBody144 ], [ 0, %whileCond143.preheader ]
  %t26 = add i32 %t19.020, %t12.023
  %0 = sext i32 %t26 to i64
  %t27 = getelementptr i8, ptr %t0, i64 %0
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @_zen_char_to_string(i8 %t28)
  %1 = zext nneg i32 %t19.020 to i64
  %t33 = getelementptr i8, ptr %t1, i64 %1
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @_zen_char_to_string(i8 %t34)
  %t37 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t29, ptr noundef nonnull dereferenceable(1) %t35)
  %t38.not = icmp eq i32 %t37, 0
  %spec.select = select i1 %t38.not, i1 %t18.021, i1 false
  %t41 = add nuw nsw i32 %t19.020, 1
  %t22 = icmp slt i32 %t41, %t7
  br i1 %t22, label %whileBody144, label %whileEnd145

whileEnd145:                                      ; preds = %whileBody144
  br i1 %spec.select, label %if149, label %end148

if149:                                            ; preds = %whileEnd145
  %t46 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t5024 = icmp sgt i32 %t12.023, 0
  br i1 %t5024, label %whileBody151, label %whileEnd152

whileBody151:                                     ; preds = %if149, %whileBody151
  %t44.026 = phi ptr [ %t58, %whileBody151 ], [ %t46, %if149 ]
  %t47.025 = phi i32 [ %t61, %whileBody151 ], [ 0, %if149 ]
  %2 = zext nneg i32 %t47.025 to i64
  %t54 = getelementptr i8, ptr %t0, i64 %2
  %t55 = load i8, ptr %t54, align 1
  %t56 = tail call ptr @_zen_char_to_string(i8 %t55)
  %t58 = tail call ptr @_str_concat(ptr %t44.026, ptr %t56)
  %t61 = add nuw nsw i32 %t47.025, 1
  %t50 = icmp slt i32 %t61, %t12.023
  br i1 %t50, label %whileBody151, label %whileEnd152

whileEnd152:                                      ; preds = %whileBody151, %if149.thread, %if149
  %t12.023.lcssa37 = phi i32 [ %t12.023, %if149 ], [ 0, %if149.thread ], [ %t12.023, %whileBody151 ]
  %t44.0.lcssa = phi ptr [ %t46, %if149 ], [ %t4635, %if149.thread ], [ %t58, %whileBody151 ]
  %t65 = tail call ptr @_str_concat(ptr %t44.0.lcssa, ptr %t2)
  %t68 = tail call i32 @strlen(ptr %t2)
  %t72 = add i32 %t12.023.lcssa37, %t7
  %t7628 = icmp slt i32 %t72, %t4
  br i1 %t7628, label %whileBody154, label %common.ret

whileBody154:                                     ; preds = %whileEnd152, %whileBody154
  %t44.130 = phi ptr [ %t84, %whileBody154 ], [ %t65, %whileEnd152 ]
  %t47.129 = phi i32 [ %t87, %whileBody154 ], [ %t72, %whileEnd152 ]
  %3 = sext i32 %t47.129 to i64
  %t80 = getelementptr i8, ptr %t0, i64 %3
  %t81 = load i8, ptr %t80, align 1
  %t82 = tail call ptr @_zen_char_to_string(i8 %t81)
  %t84 = tail call ptr @_str_concat(ptr %t44.130, ptr %t82)
  %t87 = add nsw i32 %t47.129, 1
  %t76 = icmp slt i32 %t87, %t4
  br i1 %t76, label %whileBody154, label %common.ret

end148:                                           ; preds = %whileEnd145
  %t91 = add i32 %t12.023, 1
  %t17.not = icmp sgt i32 %t91, %t16
  br i1 %t17.not, label %common.ret, label %whileCond143.preheader
}

define ptr @_zen_std_replaceAll(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  br i1 %t10, label %common.ret, label %end156

common.ret:                                       ; preds = %end169, %end156, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t14, %end156 ], [ %t66, %end169 ]
  ret ptr %common.ret.op

end156:                                           ; preds = %entry
  %t14 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1816 = icmp sgt i32 %t4, 0
  br i1 %t1816, label %whileBody159.lr.ph, label %common.ret

whileBody159.lr.ph:                               ; preds = %end156
  %t24 = sub i32 %t4, %t7
  %t2813 = icmp sgt i32 %t7, 0
  br label %whileBody159

whileBody159:                                     ; preds = %whileBody159.lr.ph, %end169
  %t12.018 = phi ptr [ %t14, %whileBody159.lr.ph ], [ %t66, %end169 ]
  %t15.017 = phi i32 [ 0, %whileBody159.lr.ph ], [ %t15.1, %end169 ]
  %t25.not = icmp sgt i32 %t15.017, %t24
  br i1 %t25.not, label %else171, label %whileCond164.preheader

whileCond164.preheader:                           ; preds = %whileBody159
  br i1 %t2813, label %whileBody165, label %end169

whileBody165:                                     ; preds = %whileCond164.preheader, %whileBody165
  %t19.015 = phi i1 [ %spec.select, %whileBody165 ], [ true, %whileCond164.preheader ]
  %t20.014 = phi i32 [ %t47, %whileBody165 ], [ 0, %whileCond164.preheader ]
  %t32 = add i32 %t20.014, %t15.017
  %0 = sext i32 %t32 to i64
  %t33 = getelementptr i8, ptr %t0, i64 %0
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @_zen_char_to_string(i8 %t34)
  %1 = zext nneg i32 %t20.014 to i64
  %t39 = getelementptr i8, ptr %t1, i64 %1
  %t40 = load i8, ptr %t39, align 1
  %t41 = tail call ptr @_zen_char_to_string(i8 %t40)
  %t43 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t35, ptr noundef nonnull dereferenceable(1) %t41)
  %t44.not = icmp eq i32 %t43, 0
  %spec.select = select i1 %t44.not, i1 %t19.015, i1 false
  %t47 = add nuw nsw i32 %t20.014, 1
  %t28 = icmp slt i32 %t47, %t7
  br i1 %t28, label %whileBody165, label %end161

end161:                                           ; preds = %whileBody165
  br i1 %spec.select, label %end169, label %else171

else171:                                          ; preds = %whileBody159, %end161
  %2 = sext i32 %t15.017 to i64
  %t62 = getelementptr i8, ptr %t0, i64 %2
  %t63 = load i8, ptr %t62, align 1
  %t64 = tail call ptr @_zen_char_to_string(i8 %t63)
  br label %end169

end169:                                           ; preds = %end161, %whileCond164.preheader, %else171
  %t64.sink = phi ptr [ %t64, %else171 ], [ %t2, %whileCond164.preheader ], [ %t2, %end161 ]
  %t7.pn = phi i32 [ 1, %else171 ], [ %t7, %whileCond164.preheader ], [ %t7, %end161 ]
  %t66 = tail call ptr @_str_concat(ptr %t12.018, ptr %t64.sink)
  %t15.1 = add i32 %t7.pn, %t15.017
  %t18 = icmp slt i32 %t15.1, %t4
  br i1 %t18, label %whileBody159, label %common.ret
}

define noundef i1 @_zen_std_contains(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %whileCond174.preheader

whileCond174.preheader:                           ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t15.not11 = icmp slt i32 %t14, 0
  br i1 %t15.not11, label %common.ret, label %whileCond177.preheader.lr.ph

whileCond177.preheader.lr.ph:                     ; preds = %whileCond174.preheader
  %t208 = icmp sgt i32 %t6, 0
  br label %whileCond177.preheader

common.ret:                                       ; preds = %whileCond177.preheader, %whileEnd179, %whileCond174, %whileCond174.preheader, %entry
  %common.ret.op = phi i1 [ true, %entry ], [ false, %whileCond174.preheader ], [ true, %whileCond177.preheader ], [ true, %whileEnd179 ], [ false, %whileCond174 ]
  ret i1 %common.ret.op

whileCond174:                                     ; preds = %whileEnd179
  %t43 = add i32 %t10.012, 1
  %t15.not = icmp sgt i32 %t43, %t14
  br i1 %t15.not, label %common.ret, label %whileCond177.preheader

whileCond177.preheader:                           ; preds = %whileCond177.preheader.lr.ph, %whileCond174
  %t10.012 = phi i32 [ 0, %whileCond177.preheader.lr.ph ], [ %t43, %whileCond174 ]
  br i1 %t208, label %whileBody178, label %common.ret

whileBody178:                                     ; preds = %whileCond177.preheader, %whileBody178
  %t16.010 = phi i1 [ %spec.select, %whileBody178 ], [ true, %whileCond177.preheader ]
  %t17.09 = phi i32 [ %t39, %whileBody178 ], [ 0, %whileCond177.preheader ]
  %t24 = add i32 %t17.09, %t10.012
  %0 = sext i32 %t24 to i64
  %t25 = getelementptr i8, ptr %t0, i64 %0
  %t26 = load i8, ptr %t25, align 1
  %t27 = tail call ptr @_zen_char_to_string(i8 %t26)
  %1 = zext nneg i32 %t17.09 to i64
  %t31 = getelementptr i8, ptr %t1, i64 %1
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t35 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t27, ptr noundef nonnull dereferenceable(1) %t33)
  %t36.not = icmp eq i32 %t35, 0
  %spec.select = select i1 %t36.not, i1 %t16.010, i1 false
  %t39 = add nuw nsw i32 %t17.09, 1
  %t20 = icmp slt i32 %t39, %t6
  br i1 %t20, label %whileBody178, label %whileEnd179

whileEnd179:                                      ; preds = %whileBody178
  br i1 %spec.select, label %common.ret, label %whileCond174
}

define ptr @_zen_std_upperCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t105 = icmp sgt i32 %t2, 0
  br i1 %t105, label %whileBody185, label %whileEnd186

whileBody185:                                     ; preds = %entry, %end187
  %t4.07 = phi ptr [ %t4.1, %end187 ], [ %t6, %entry ]
  %t7.06 = phi i32 [ %t47, %end187 ], [ 0, %entry ]
  %0 = zext nneg i32 %t7.06 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @_string_to_int_ascii(ptr %t16)
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t25 = tail call i32 @_string_to_int_ascii(ptr %t24)
  tail call void @_zen_string_free(ptr %t24)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t30 = tail call i32 @_string_to_int_ascii(ptr %t29)
  tail call void @_zen_string_free(ptr %t29)
  %t26 = icmp sge i32 %t19, %t25
  %t31 = icmp sle i32 %t19, %t30
  %t21 = select i1 %t26, i1 %t31, i1 false
  br i1 %t21, label %if191, label %else192

if191:                                            ; preds = %whileBody185
  %t33 = add i32 %t19, -32
  %t34 = tail call ptr @_int_to_string_ascii(i32 %t33)
  %t38 = tail call ptr @_str_concat(ptr %t4.07, ptr %t34)
  tail call void @_zen_string_free(ptr %t34)
  br label %end187

else192:                                          ; preds = %whileBody185
  %t44 = tail call ptr @_str_concat(ptr %t4.07, ptr %t16)
  br label %end187

end187:                                           ; preds = %else192, %if191
  %t4.1 = phi ptr [ %t38, %if191 ], [ %t44, %else192 ]
  %t47 = add nuw nsw i32 %t7.06, 1
  tail call void @_zen_string_free(ptr %t16)
  %t10 = icmp slt i32 %t47, %t2
  br i1 %t10, label %whileBody185, label %whileEnd186

whileEnd186:                                      ; preds = %end187, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t4.1, %end187 ]
  ret ptr %t4.0.lcssa
}

define ptr @_zen_std_lowerCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t105 = icmp sgt i32 %t2, 0
  br i1 %t105, label %whileBody194, label %whileEnd195

whileBody194:                                     ; preds = %entry, %end196
  %t4.07 = phi ptr [ %t4.1, %end196 ], [ %t6, %entry ]
  %t7.06 = phi i32 [ %t47, %end196 ], [ 0, %entry ]
  %0 = zext nneg i32 %t7.06 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @_string_to_int_ascii(ptr %t16)
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t25 = tail call i32 @_string_to_int_ascii(ptr %t24)
  tail call void @_zen_string_free(ptr %t24)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t30 = tail call i32 @_string_to_int_ascii(ptr %t29)
  tail call void @_zen_string_free(ptr %t29)
  %t26 = icmp sge i32 %t19, %t25
  %t31 = icmp sle i32 %t19, %t30
  %t21 = select i1 %t26, i1 %t31, i1 false
  br i1 %t21, label %if200, label %else201

if200:                                            ; preds = %whileBody194
  %t33 = add i32 %t19, 32
  %t34 = tail call ptr @_int_to_string_ascii(i32 %t33)
  %t38 = tail call ptr @_str_concat(ptr %t4.07, ptr %t34)
  tail call void @_zen_string_free(ptr %t34)
  br label %end196

else201:                                          ; preds = %whileBody194
  %t44 = tail call ptr @_str_concat(ptr %t4.07, ptr %t16)
  br label %end196

end196:                                           ; preds = %else201, %if200
  %t4.1 = phi ptr [ %t38, %if200 ], [ %t44, %else201 ]
  %t47 = add nuw nsw i32 %t7.06, 1
  tail call void @_zen_string_free(ptr %t16)
  %t10 = icmp slt i32 %t47, %t2
  br i1 %t10, label %whileBody194, label %whileEnd195

whileEnd195:                                      ; preds = %end196, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t4.1, %end196 ]
  ret ptr %t4.0.lcssa
}

define noundef i1 @_zen_std_startsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp sgt i32 %t6, %t3
  br i1 %t10, label %common.ret, label %whileCond204.preheader

whileCond204.preheader:                           ; preds = %entry
  %t145 = icmp sgt i32 %t6, 0
  br i1 %t145, label %whileBody205, label %common.ret

common.ret:                                       ; preds = %whileBody205, %whileCond204.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond204.preheader ], [ %t28.not, %whileBody205 ]
  ret i1 %common.ret.op

whileBody205:                                     ; preds = %whileCond204.preheader, %whileBody205
  %t11.06 = phi i32 [ %t30, %whileBody205 ], [ 0, %whileCond204.preheader ]
  %0 = zext nneg i32 %t11.06 to i64
  %t17 = getelementptr i8, ptr %t0, i64 %0
  %t18 = load i8, ptr %t17, align 1
  %t19 = tail call ptr @_zen_char_to_string(i8 %t18)
  %t23 = getelementptr i8, ptr %t1, i64 %0
  %t24 = load i8, ptr %t23, align 1
  %t25 = tail call ptr @_zen_char_to_string(i8 %t24)
  %t27 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t19, ptr noundef nonnull dereferenceable(1) %t25)
  %t28.not = icmp eq i32 %t27, 0
  %t30 = add nuw nsw i32 %t11.06, 1
  %t14 = icmp slt i32 %t30, %t6
  %or.cond = select i1 %t28.not, i1 %t14, i1 false
  br i1 %or.cond, label %whileBody205, label %common.ret
}

define noundef i1 @_zen_std_endsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp sgt i32 %t6, %t3
  br i1 %t10, label %common.ret, label %whileCond211.preheader

whileCond211.preheader:                           ; preds = %entry
  %t18 = sub i32 %t3, %t6
  %t147 = icmp sgt i32 %t6, 0
  br i1 %t147, label %whileBody212, label %common.ret

common.ret:                                       ; preds = %whileBody212, %whileCond211.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond211.preheader ], [ %t32.not, %whileBody212 ]
  ret i1 %common.ret.op

whileBody212:                                     ; preds = %whileCond211.preheader, %whileBody212
  %t11.08 = phi i32 [ %t34, %whileBody212 ], [ 0, %whileCond211.preheader ]
  %t20 = add i32 %t18, %t11.08
  %0 = sext i32 %t20 to i64
  %t21 = getelementptr i8, ptr %t0, i64 %0
  %t22 = load i8, ptr %t21, align 1
  %t23 = tail call ptr @_zen_char_to_string(i8 %t22)
  %1 = zext nneg i32 %t11.08 to i64
  %t27 = getelementptr i8, ptr %t1, i64 %1
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @_zen_char_to_string(i8 %t28)
  %t31 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t23, ptr noundef nonnull dereferenceable(1) %t29)
  %t32.not = icmp eq i32 %t31, 0
  %t34 = add nuw nsw i32 %t11.08, 1
  %t14 = icmp slt i32 %t34, %t6
  %or.cond = select i1 %t32.not, i1 %t14, i1 false
  br i1 %or.cond, label %whileBody212, label %common.ret
}

define ptr @_zen_std_trim(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t1011 = icmp sgt i32 %t2, 0
  br i1 %t1011, label %whileBody217, label %whileEnd218

whileBody217:                                     ; preds = %entry, %if226
  %t4.012 = phi i32 [ %t36, %if226 ], [ 0, %entry ]
  %0 = zext nneg i32 %t4.012 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t22 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t27 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t23 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t22)
  %t24 = icmp eq i32 %t23, 0
  br i1 %t24, label %if226, label %rhs223

rhs223:                                           ; preds = %whileBody217
  %t28 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t27)
  %t29 = icmp eq i32 %t28, 0
  br i1 %t29, label %if226, label %rhs220

rhs220:                                           ; preds = %rhs223
  %t33 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t32)
  %t34 = icmp eq i32 %t33, 0
  br i1 %t34, label %if226, label %whileEnd218

if226:                                            ; preds = %whileBody217, %rhs223, %rhs220
  %t36 = add nuw nsw i32 %t4.012, 1
  %t10 = icmp slt i32 %t36, %t2
  br i1 %t10, label %whileBody217, label %whileEnd218

whileEnd218:                                      ; preds = %if226, %rhs220, %entry
  %t4.0.lcssa = phi i32 [ 0, %entry ], [ %t4.012, %rhs220 ], [ %t2, %if226 ]
  %t5.014 = add i32 %t2, -1
  %t40.not15 = icmp slt i32 %t5.014, %t4.0.lcssa
  br i1 %t40.not15, label %whileEnd230, label %whileBody229

whileBody229:                                     ; preds = %whileEnd218, %if238
  %t5.016 = phi i32 [ %t5.0, %if238 ], [ %t5.014, %whileEnd218 ]
  %1 = sext i32 %t5.016 to i64
  %t44 = getelementptr i8, ptr %t0, i64 %1
  %t45 = load i8, ptr %t44, align 1
  %t46 = tail call ptr @_zen_char_to_string(i8 %t45)
  %t52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t57 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t53 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t52)
  %t54 = icmp eq i32 %t53, 0
  br i1 %t54, label %if238, label %rhs235

rhs235:                                           ; preds = %whileBody229
  %t58 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t57)
  %t59 = icmp eq i32 %t58, 0
  br i1 %t59, label %if238, label %rhs232

rhs232:                                           ; preds = %rhs235
  %t63 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t62)
  %t64 = icmp eq i32 %t63, 0
  br i1 %t64, label %if238, label %whileEnd230

if238:                                            ; preds = %whileBody229, %rhs235, %rhs232
  %t5.0 = add i32 %t5.016, -1
  %t40.not = icmp slt i32 %t5.0, %t4.0.lcssa
  br i1 %t40.not, label %whileEnd230, label %whileBody229

whileEnd230:                                      ; preds = %if238, %rhs232, %whileEnd218
  %t5.0.lcssa = phi i32 [ %t5.014, %whileEnd218 ], [ %t5.016, %rhs232 ], [ %t5.0, %if238 ]
  %t70 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t75.not19 = icmp sgt i32 %t4.0.lcssa, %t5.0.lcssa
  br i1 %t75.not19, label %whileEnd242, label %whileBody241

whileBody241:                                     ; preds = %whileEnd230, %whileBody241
  %t71.021 = phi i32 [ %t86, %whileBody241 ], [ %t4.0.lcssa, %whileEnd230 ]
  %t68.020 = phi ptr [ %t83, %whileBody241 ], [ %t70, %whileEnd230 ]
  %2 = sext i32 %t71.021 to i64
  %t79 = getelementptr i8, ptr %t0, i64 %2
  %t80 = load i8, ptr %t79, align 1
  %t81 = tail call ptr @_zen_char_to_string(i8 %t80)
  %t83 = tail call ptr @_str_concat(ptr %t68.020, ptr %t81)
  %t86 = add i32 %t71.021, 1
  %t75.not = icmp sgt i32 %t86, %t5.0.lcssa
  br i1 %t75.not, label %whileEnd242, label %whileBody241

whileEnd242:                                      ; preds = %whileBody241, %whileEnd230
  %t68.0.lcssa = phi ptr [ %t70, %whileEnd230 ], [ %t83, %whileBody241 ]
  ret ptr %t68.0.lcssa
}

define ptr @_zen_std_splitAt(ptr %t0, ptr %t1, i32 %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  %t12 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br i1 %t10, label %common.ret, label %end243

common.ret:                                       ; preds = %if257, %entry, %whileEnd247, %end261
  %common.ret.op = phi ptr [ %t88, %end261 ], [ %t15.0.lcssa, %whileEnd247 ], [ %t12, %entry ], [ %t15.022, %if257 ]
  ret ptr %common.ret.op

end243:                                           ; preds = %entry
  %t2021 = icmp sgt i32 %t4, 0
  br i1 %t2021, label %whileBody246.lr.ph, label %whileEnd247

whileBody246.lr.ph:                               ; preds = %end243
  %t26 = sub i32 %t4, %t7
  %t3018 = icmp sgt i32 %t7, 0
  br label %whileBody246

whileBody246:                                     ; preds = %whileBody246.lr.ph, %end256
  %t13.024 = phi i32 [ 0, %whileBody246.lr.ph ], [ %t13.1, %end256 ]
  %t14.023 = phi i32 [ 0, %whileBody246.lr.ph ], [ %t14.1, %end256 ]
  %t15.022 = phi ptr [ %t12, %whileBody246.lr.ph ], [ %t15.1, %end256 ]
  %t27.not = icmp sgt i32 %t13.024, %t26
  br i1 %t27.not, label %else258, label %whileCond251.preheader

whileCond251.preheader:                           ; preds = %whileBody246
  br i1 %t3018, label %whileBody252, label %if257

whileBody252:                                     ; preds = %whileCond251.preheader, %whileBody252
  %t22.020 = phi i32 [ %t49, %whileBody252 ], [ 0, %whileCond251.preheader ]
  %t21.019 = phi i1 [ %spec.select, %whileBody252 ], [ true, %whileCond251.preheader ]
  %t34 = add i32 %t22.020, %t13.024
  %0 = sext i32 %t34 to i64
  %t35 = getelementptr i8, ptr %t0, i64 %0
  %t36 = load i8, ptr %t35, align 1
  %t37 = tail call ptr @_zen_char_to_string(i8 %t36)
  %1 = zext nneg i32 %t22.020 to i64
  %t41 = getelementptr i8, ptr %t1, i64 %1
  %t42 = load i8, ptr %t41, align 1
  %t43 = tail call ptr @_zen_char_to_string(i8 %t42)
  %t45 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t37, ptr noundef nonnull dereferenceable(1) %t43)
  %t46.not = icmp eq i32 %t45, 0
  %spec.select = select i1 %t46.not, i1 %t21.019, i1 false
  %t49 = add nuw nsw i32 %t22.020, 1
  %t30 = icmp slt i32 %t49, %t7
  br i1 %t30, label %whileBody252, label %end248

end248:                                           ; preds = %whileBody252
  br i1 %spec.select, label %if257, label %else258

if257:                                            ; preds = %whileCond251.preheader, %end248
  %t55 = icmp eq i32 %t14.023, %t2
  br i1 %t55, label %common.ret, label %end259

end259:                                           ; preds = %if257
  %t58 = add i32 %t14.023, 1
  tail call void @_zen_string_free(ptr %t15.022)
  %t63 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end256

else258:                                          ; preds = %whileBody246, %end248
  %2 = sext i32 %t13.024 to i64
  %t72 = getelementptr i8, ptr %t0, i64 %2
  %t73 = load i8, ptr %t72, align 1
  %t74 = tail call ptr @_zen_char_to_string(i8 %t73)
  %t76 = tail call ptr @_str_concat(ptr %t15.022, ptr %t74)
  br label %end256

end256:                                           ; preds = %else258, %end259
  %t15.1 = phi ptr [ %t63, %end259 ], [ %t76, %else258 ]
  %t14.1 = phi i32 [ %t58, %end259 ], [ %t14.023, %else258 ]
  %t7.pn = phi i32 [ %t7, %end259 ], [ 1, %else258 ]
  %t13.1 = add i32 %t7.pn, %t13.024
  %t20 = icmp slt i32 %t13.1, %t4
  br i1 %t20, label %whileBody246, label %whileEnd247

whileEnd247:                                      ; preds = %end256, %end243
  %t15.0.lcssa = phi ptr [ %t12, %end243 ], [ %t15.1, %end256 ]
  %t14.0.lcssa = phi i32 [ 0, %end243 ], [ %t14.1, %end256 ]
  %t83 = icmp eq i32 %t14.0.lcssa, %t2
  br i1 %t83, label %common.ret, label %end261

end261:                                           ; preds = %whileEnd247
  tail call void @_zen_string_free(ptr %t15.0.lcssa)
  %t88 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret
}

define ptr @_zen_std_repeat(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = icmp slt i32 %t1, 1
  br i1 %t3, label %common.ret.sink.split, label %end263

common.ret.sink.split:                            ; preds = %end263, %entry
  %t10 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

common.ret:                                       ; preds = %whileBody268, %common.ret.sink.split
  %common.ret.op = phi ptr [ %t10, %common.ret.sink.split ], [ %t18, %whileBody268 ]
  ret ptr %common.ret.op

end263:                                           ; preds = %entry
  %t7 = tail call i32 @strlen(ptr %t0)
  %t8 = icmp eq i32 %t7, 0
  br i1 %t8, label %common.ret.sink.split, label %whileBody268.preheader

whileBody268.preheader:                           ; preds = %end263
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %whileBody268

whileBody268:                                     ; preds = %whileBody268.preheader, %whileBody268
  %count.addr.05 = phi i32 [ %t21, %whileBody268 ], [ %t1, %whileBody268.preheader ]
  %t11.04 = phi ptr [ %t18, %whileBody268 ], [ %t13, %whileBody268.preheader ]
  %t18 = tail call ptr @_str_concat(ptr %t11.04, ptr %t0)
  %t21 = add nsw i32 %count.addr.05, -1
  %t15 = icmp samesign ugt i32 %count.addr.05, 1
  br i1 %t15, label %whileBody268, label %common.ret
}

define i32 @_zen_std_count(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t4 = icmp eq i32 %t3, 0
  br i1 %t4, label %common.ret, label %end270

common.ret:                                       ; preds = %_zen_std_charAt.exit, %whileCond274.preheader, %end270, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ 0, %end270 ], [ 0, %whileCond274.preheader ], [ %spec.select, %_zen_std_charAt.exit ]
  ret i32 %common.ret.op

end270:                                           ; preds = %entry
  %t6 = tail call i32 @strlen(ptr %t1)
  %t7 = icmp eq i32 %t6, 0
  br i1 %t7, label %common.ret, label %whileCond274.preheader

whileCond274.preheader:                           ; preds = %end270
  %t124 = tail call i32 @strlen(ptr %t0)
  %t135 = icmp sgt i32 %t124, 0
  br i1 %t135, label %whileBody275, label %common.ret

whileBody275:                                     ; preds = %whileCond274.preheader, %_zen_std_charAt.exit
  %t8.07 = phi i32 [ %spec.select, %_zen_std_charAt.exit ], [ 0, %whileCond274.preheader ]
  %t9.06 = phi i32 [ %t23, %_zen_std_charAt.exit ], [ 0, %whileCond274.preheader ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i.not = icmp slt i32 %t9.06, %t3.i
  br i1 %t10.i.not, label %end133.i, label %if137.i

if137.i:                                          ; preds = %whileBody275
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %whileBody275
  %0 = zext nneg i32 %t9.06 to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i, %if137.i ], [ %t17.i, %end133.i ]
  %t18 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t1)
  %t19 = icmp eq i32 %t18, 0
  %t21 = zext i1 %t19 to i32
  %spec.select = add i32 %t8.07, %t21
  %t23 = add nuw nsw i32 %t9.06, 1
  %t12 = tail call i32 @strlen(ptr %t0)
  %t13 = icmp slt i32 %t23, %t12
  br i1 %t13, label %whileBody275, label %common.ret
}

define ptr @_zen_std_padStart(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end279, label %common.ret

common.ret:                                       ; preds = %end279, %entry, %whileEnd285
  %common.ret.op = phi ptr [ %t30, %whileEnd285 ], [ %t0, %entry ], [ %t0, %end279 ]
  ret ptr %common.ret.op

end279:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end281

end281:                                           ; preds = %end279
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t19 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t213 = icmp sgt i32 %t16, 0
  br i1 %t213, label %whileBody284, label %whileEnd285

whileBody284:                                     ; preds = %end281, %whileBody284
  %t12.05 = phi i32 [ %t27, %whileBody284 ], [ %t16, %end281 ]
  %t17.04 = phi ptr [ %t24, %whileBody284 ], [ %t19, %end281 ]
  %t24 = tail call ptr @_str_concat(ptr %t17.04, ptr %t2)
  %t27 = add nsw i32 %t12.05, -1
  %t21 = icmp samesign ugt i32 %t12.05, 1
  br i1 %t21, label %whileBody284, label %whileEnd285

whileEnd285:                                      ; preds = %whileBody284, %end281
  %t17.0.lcssa = phi ptr [ %t19, %end281 ], [ %t24, %whileBody284 ]
  %t30 = tail call ptr @_str_concat(ptr %t17.0.lcssa, ptr %t0)
  br label %common.ret
}

define ptr @_zen_std_padEnd(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end286, label %common.ret

common.ret:                                       ; preds = %whileBody291, %end288, %end286, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t0, %end286 ], [ %t0, %end288 ], [ %t23, %whileBody291 ]
  ret ptr %common.ret.op

end286:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end288

end288:                                           ; preds = %end286
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t203 = icmp sgt i32 %t16, 0
  br i1 %t203, label %whileBody291, label %common.ret

whileBody291:                                     ; preds = %end288, %whileBody291
  %t12.05 = phi i32 [ %t26, %whileBody291 ], [ %t16, %end288 ]
  %t17.04 = phi ptr [ %t23, %whileBody291 ], [ %t0, %end288 ]
  %t23 = tail call ptr @_str_concat(ptr %t17.04, ptr %t2)
  %t26 = add nsw i32 %t12.05, -1
  %t20 = icmp samesign ugt i32 %t12.05, 1
  br i1 %t20, label %whileBody291, label %common.ret
}

define ptr @_zen_std_padCenter(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end293, label %common.ret

common.ret:                                       ; preds = %end293, %entry, %whileEnd302
  %common.ret.op = phi ptr [ %t50, %whileEnd302 ], [ %t0, %entry ], [ %t0, %end293 ]
  ret ptr %common.ret.op

end293:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end295

end295:                                           ; preds = %end293
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t19 = sdiv i32 %t16, 2
  %t23 = sub i32 %t16, %t19
  %t26 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t316 = icmp sgt i32 %t16, 1
  br i1 %t316, label %whileBody298, label %whileCond300.preheader

whileCond300.preheader:                           ; preds = %whileBody298, %end295
  %t24.0.lcssa = phi ptr [ %t26, %end295 ], [ %t34, %whileBody298 ]
  %t399 = icmp sgt i32 %t23, 0
  br i1 %t399, label %whileBody301, label %whileEnd302

whileBody298:                                     ; preds = %end295, %whileBody298
  %t17.08 = phi i32 [ %t37, %whileBody298 ], [ %t19, %end295 ]
  %t24.07 = phi ptr [ %t34, %whileBody298 ], [ %t26, %end295 ]
  %t34 = tail call ptr @_str_concat(ptr %t24.07, ptr %t2)
  %t37 = add nsw i32 %t17.08, -1
  %t31 = icmp sgt i32 %t17.08, 1
  br i1 %t31, label %whileBody298, label %whileCond300.preheader

whileBody301:                                     ; preds = %whileCond300.preheader, %whileBody301
  %t20.011 = phi i32 [ %t45, %whileBody301 ], [ %t23, %whileCond300.preheader ]
  %t27.010 = phi ptr [ %t42, %whileBody301 ], [ %t29, %whileCond300.preheader ]
  %t42 = tail call ptr @_str_concat(ptr %t27.010, ptr %t2)
  %t45 = add nsw i32 %t20.011, -1
  %t39 = icmp samesign ugt i32 %t20.011, 1
  br i1 %t39, label %whileBody301, label %whileEnd302

whileEnd302:                                      ; preds = %whileBody301, %whileCond300.preheader
  %t27.0.lcssa = phi ptr [ %t29, %whileCond300.preheader ], [ %t42, %whileBody301 ]
  %t48 = tail call ptr @_str_concat(ptr %t24.0.lcssa, ptr %t0)
  %t50 = tail call ptr @_str_concat(ptr %t48, ptr %t27.0.lcssa)
  tail call void @_zen_string_free(ptr %t48)
  br label %common.ret
}

define ptr @_zen_std_capitalize(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t3 = icmp eq i32 %t2, 0
  br i1 %t3, label %if304, label %end303

common.ret:                                       ; preds = %whileBody312, %end305, %if304
  %common.ret.op = phi ptr [ %t5, %if304 ], [ %t37, %end305 ], [ %t53, %whileBody312 ]
  ret ptr %common.ret.op

if304:                                            ; preds = %entry
  %t5 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

end303:                                           ; preds = %entry
  %t9 = load i8, ptr %t0, align 1
  %t10 = tail call ptr @_zen_char_to_string(i8 %t9)
  %t13 = tail call i32 @_string_to_int_ascii(ptr %t10)
  %t17 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t21 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t22 = tail call i32 @_string_to_int_ascii(ptr %t21)
  tail call void @_zen_string_free(ptr %t21)
  %t26 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t27 = tail call i32 @_string_to_int_ascii(ptr %t26)
  tail call void @_zen_string_free(ptr %t26)
  %t23 = icmp sge i32 %t13, %t22
  %t28 = icmp sle i32 %t13, %t27
  %t18 = select i1 %t23, i1 %t28, i1 false
  br i1 %t18, label %if309, label %end305

if309:                                            ; preds = %end303
  %t31 = add i32 %t13, -32
  %t32 = tail call ptr @_int_to_string_ascii(i32 %t31)
  br label %end305

end305:                                           ; preds = %end303, %if309
  %t10.sink = phi ptr [ %t32, %if309 ], [ %t10, %end303 ]
  %t37 = tail call ptr @_str_concat(ptr %t17, ptr %t10.sink)
  %t41 = tail call i32 @strlen(ptr nonnull %t0)
  %t455 = icmp sgt i32 %t41, 1
  br i1 %t455, label %whileBody312, label %common.ret

whileBody312:                                     ; preds = %end305, %whileBody312
  %t15.17 = phi ptr [ %t53, %whileBody312 ], [ %t37, %end305 ]
  %t39.06 = phi i32 [ %t56, %whileBody312 ], [ 1, %end305 ]
  %0 = zext nneg i32 %t39.06 to i64
  %t49 = getelementptr i8, ptr %t0, i64 %0
  %t50 = load i8, ptr %t49, align 1
  %t51 = tail call ptr @_zen_char_to_string(i8 %t50)
  %t53 = tail call ptr @_str_concat(ptr %t15.17, ptr %t51)
  %t56 = add nuw nsw i32 %t39.06, 1
  %t45 = icmp slt i32 %t56, %t41
  br i1 %t45, label %whileBody312, label %common.ret
}

define ptr @_zen_std_extName(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  br label %whileCond314

whileCond314:                                     ; preds = %whileBody315, %entry
  %t4.0.in = phi i32 [ %t2, %entry ], [ %t4.0, %whileBody315 ]
  %t4.0 = add i32 %t4.0.in, -1
  %t8 = icmp sgt i32 %t4.0, -1
  br i1 %t8, label %whileBody315, label %whileEnd316

whileBody315:                                     ; preds = %whileCond314
  %t16 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %0 = zext nneg i32 %t4.0 to i64
  %t11 = getelementptr i8, ptr %t0, i64 %0
  %t12 = load i8, ptr %t11, align 1
  %t13 = tail call ptr @_zen_char_to_string(i8 %t12)
  %t17 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t13, ptr noundef nonnull dereferenceable(1) %t16)
  %t18 = icmp eq i32 %t17, 0
  br i1 %t18, label %if318, label %whileCond314

if318:                                            ; preds = %whileBody315
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t278 = icmp slt i32 %t4.0.in, %t2
  br i1 %t278, label %whileBody320, label %common.ret

whileBody320:                                     ; preds = %if318, %whileBody320
  %t22.010 = phi ptr [ %t35, %whileBody320 ], [ %t24, %if318 ]
  %t19.09 = phi i32 [ %t38, %whileBody320 ], [ %t4.0.in, %if318 ]
  %1 = sext i32 %t19.09 to i64
  %t31 = getelementptr i8, ptr %t0, i64 %1
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t35 = tail call ptr @_str_concat(ptr %t22.010, ptr %t33)
  %t38 = add nsw i32 %t19.09, 1
  %t27 = icmp slt i32 %t38, %t2
  br i1 %t27, label %whileBody320, label %common.ret

common.ret:                                       ; preds = %whileBody320, %if318, %whileEnd316
  %common.ret.op = phi ptr [ %t45, %whileEnd316 ], [ %t24, %if318 ], [ %t35, %whileBody320 ]
  ret ptr %common.ret.op

whileEnd316:                                      ; preds = %whileCond314
  %t45 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_sin(double %t0) local_unnamed_addr #2 {
entry:
  %t2 = load double, ptr @PI, align 8
  %t31 = fcmp ogt double %t0, %t2
  br i1 %t31, label %whileBody323.lr.ph, label %whileCond325.preheader

whileBody323.lr.ph:                               ; preds = %entry
  %t5 = load double, ptr @TAU, align 8
  br label %whileBody323

whileCond325.preheader:                           ; preds = %whileBody323, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t6, %whileBody323 ]
  %t10 = fsub double 0.000000e+00, %t2
  %t114 = fcmp olt double %x.addr.0.lcssa, %t10
  br i1 %t114, label %whileBody326.lr.ph, label %whileEnd327

whileBody326.lr.ph:                               ; preds = %whileCond325.preheader
  %t13 = load double, ptr @TAU, align 8
  br label %whileBody326

whileBody323:                                     ; preds = %whileBody323.lr.ph, %whileBody323
  %x.addr.02 = phi double [ %t0, %whileBody323.lr.ph ], [ %t6, %whileBody323 ]
  %t6 = fsub double %x.addr.02, %t5
  %t3 = fcmp ogt double %t6, %t2
  br i1 %t3, label %whileBody323, label %whileCond325.preheader

whileBody326:                                     ; preds = %whileBody326.lr.ph, %whileBody326
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody326.lr.ph ], [ %t14, %whileBody326 ]
  %t14 = fadd double %x.addr.15, %t13
  %t11 = fcmp olt double %t14, %t10
  br i1 %t11, label %whileBody326, label %whileEnd327

whileEnd327:                                      ; preds = %whileBody326, %whileCond325.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond325.preheader ], [ %t14, %whileBody326 ]
  %t19 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t21 = fmul double %x.addr.1.lcssa, %t19
  %t22 = fdiv double %t21, 6.000000e+00
  %t23 = fsub double %x.addr.1.lcssa, %t22
  ret double %t23
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_cos(double %t0) local_unnamed_addr #2 {
entry:
  %t2 = load double, ptr @PI, align 8
  %t31 = fcmp ogt double %t0, %t2
  br i1 %t31, label %whileBody329.lr.ph, label %whileCond331.preheader

whileBody329.lr.ph:                               ; preds = %entry
  %t5 = load double, ptr @TAU, align 8
  br label %whileBody329

whileCond331.preheader:                           ; preds = %whileBody329, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t6, %whileBody329 ]
  %t10 = fsub double 0.000000e+00, %t2
  %t114 = fcmp olt double %x.addr.0.lcssa, %t10
  br i1 %t114, label %whileBody332.lr.ph, label %whileEnd333

whileBody332.lr.ph:                               ; preds = %whileCond331.preheader
  %t13 = load double, ptr @TAU, align 8
  br label %whileBody332

whileBody329:                                     ; preds = %whileBody329.lr.ph, %whileBody329
  %x.addr.02 = phi double [ %t0, %whileBody329.lr.ph ], [ %t6, %whileBody329 ]
  %t6 = fsub double %x.addr.02, %t5
  %t3 = fcmp ogt double %t6, %t2
  br i1 %t3, label %whileBody329, label %whileCond331.preheader

whileBody332:                                     ; preds = %whileBody332.lr.ph, %whileBody332
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody332.lr.ph ], [ %t14, %whileBody332 ]
  %t14 = fadd double %x.addr.15, %t13
  %t11 = fcmp olt double %t14, %t10
  br i1 %t11, label %whileBody332, label %whileEnd333

whileEnd333:                                      ; preds = %whileBody332, %whileCond331.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond331.preheader ], [ %t14, %whileBody332 ]
  %t18 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t19 = fmul double %t18, 5.000000e-01
  %t20 = fsub double 1.000000e+00, %t19
  ret double %t20
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_tan(double %t0) local_unnamed_addr #2 {
entry:
  %t2.i = load double, ptr @PI, align 8
  %t31.i = fcmp ogt double %t0, %t2.i
  br i1 %t31.i, label %whileBody323.lr.ph.i, label %whileCond325.preheader.i

whileBody323.lr.ph.i:                             ; preds = %entry
  %t5.i = load double, ptr @TAU, align 8
  br label %whileBody323.i

whileCond325.preheader.i:                         ; preds = %whileBody323.i, %entry
  %x.addr.0.lcssa.i = phi double [ %t0, %entry ], [ %t6.i, %whileBody323.i ]
  %t10.i = fsub double 0.000000e+00, %t2.i
  %t114.i = fcmp olt double %x.addr.0.lcssa.i, %t10.i
  br i1 %t114.i, label %whileBody326.lr.ph.i, label %_zen_std_sin.exit

whileBody326.lr.ph.i:                             ; preds = %whileCond325.preheader.i
  %t13.i = load double, ptr @TAU, align 8
  br label %whileBody326.i

whileBody323.i:                                   ; preds = %whileBody323.i, %whileBody323.lr.ph.i
  %x.addr.02.i = phi double [ %t0, %whileBody323.lr.ph.i ], [ %t6.i, %whileBody323.i ]
  %t6.i = fsub double %x.addr.02.i, %t5.i
  %t3.i = fcmp ogt double %t6.i, %t2.i
  br i1 %t3.i, label %whileBody323.i, label %whileCond325.preheader.i

whileBody326.i:                                   ; preds = %whileBody326.i, %whileBody326.lr.ph.i
  %x.addr.15.i = phi double [ %x.addr.0.lcssa.i, %whileBody326.lr.ph.i ], [ %t14.i, %whileBody326.i ]
  %t14.i = fadd double %t13.i, %x.addr.15.i
  %t11.i = fcmp olt double %t14.i, %t10.i
  br i1 %t11.i, label %whileBody326.i, label %_zen_std_sin.exit

_zen_std_sin.exit:                                ; preds = %whileBody326.i, %whileCond325.preheader.i
  %x.addr.1.lcssa.i = phi double [ %x.addr.0.lcssa.i, %whileCond325.preheader.i ], [ %t14.i, %whileBody326.i ]
  br i1 %t31.i, label %whileBody329.lr.ph.i, label %whileCond331.preheader.i

whileBody329.lr.ph.i:                             ; preds = %_zen_std_sin.exit
  %t5.i12 = load double, ptr @TAU, align 8
  br label %whileBody329.i

whileCond331.preheader.i:                         ; preds = %whileBody329.i, %_zen_std_sin.exit
  %x.addr.0.lcssa.i3 = phi double [ %t0, %_zen_std_sin.exit ], [ %t6.i14, %whileBody329.i ]
  %t114.i5 = fcmp olt double %x.addr.0.lcssa.i3, %t10.i
  br i1 %t114.i5, label %whileBody332.lr.ph.i, label %_zen_std_cos.exit

whileBody332.lr.ph.i:                             ; preds = %whileCond331.preheader.i
  %t13.i8 = load double, ptr @TAU, align 8
  br label %whileBody332.i

whileBody329.i:                                   ; preds = %whileBody329.i, %whileBody329.lr.ph.i
  %x.addr.02.i13 = phi double [ %t0, %whileBody329.lr.ph.i ], [ %t6.i14, %whileBody329.i ]
  %t6.i14 = fsub double %x.addr.02.i13, %t5.i12
  %t3.i15 = fcmp ogt double %t6.i14, %t2.i
  br i1 %t3.i15, label %whileBody329.i, label %whileCond331.preheader.i

whileBody332.i:                                   ; preds = %whileBody332.i, %whileBody332.lr.ph.i
  %x.addr.15.i9 = phi double [ %x.addr.0.lcssa.i3, %whileBody332.lr.ph.i ], [ %t14.i10, %whileBody332.i ]
  %t14.i10 = fadd double %t13.i8, %x.addr.15.i9
  %t11.i11 = fcmp olt double %t14.i10, %t10.i
  br i1 %t11.i11, label %whileBody332.i, label %_zen_std_cos.exit

_zen_std_cos.exit:                                ; preds = %whileBody332.i, %whileCond331.preheader.i
  %x.addr.1.lcssa.i6 = phi double [ %x.addr.0.lcssa.i3, %whileCond331.preheader.i ], [ %t14.i10, %whileBody332.i ]
  %t19.i = fmul double %x.addr.1.lcssa.i, %x.addr.1.lcssa.i
  %t21.i = fmul double %x.addr.1.lcssa.i, %t19.i
  %t22.i = fdiv double %t21.i, 6.000000e+00
  %t23.i = fsub double %x.addr.1.lcssa.i, %t22.i
  %t18.i = fmul double %x.addr.1.lcssa.i6, %x.addr.1.lcssa.i6
  %t19.i7 = fmul double %t18.i, 5.000000e-01
  %t20.i = fsub double 1.000000e+00, %t19.i7
  %t9 = fdiv double %t23.i, %t20.i
  ret double %t9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @_zen_std_log(double %t0) local_unnamed_addr #1 {
entry:
  %t7 = fadd double %t0, -1.000000e+00
  %t10 = fdiv double %t0, %t0
  %t11 = fadd double %t7, %t10
  %t7.1 = fadd double %t11, -1.000000e+00
  %t10.1 = fdiv double %t0, %t11
  %t11.1 = fadd double %t7.1, %t10.1
  %t7.2 = fadd double %t11.1, -1.000000e+00
  %t10.2 = fdiv double %t0, %t11.1
  %t11.2 = fadd double %t7.2, %t10.2
  %t7.3 = fadd double %t11.2, -1.000000e+00
  %t10.3 = fdiv double %t0, %t11.2
  %t11.3 = fadd double %t7.3, %t10.3
  %t7.4 = fadd double %t11.3, -1.000000e+00
  %t10.4 = fdiv double %t0, %t11.3
  %t11.4 = fadd double %t7.4, %t10.4
  %t7.5 = fadd double %t11.4, -1.000000e+00
  %t10.5 = fdiv double %t0, %t11.4
  %t11.5 = fadd double %t7.5, %t10.5
  %t7.6 = fadd double %t11.5, -1.000000e+00
  %t10.6 = fdiv double %t0, %t11.5
  %t11.6 = fadd double %t7.6, %t10.6
  %t7.7 = fadd double %t11.6, -1.000000e+00
  %t10.7 = fdiv double %t0, %t11.6
  %t11.7 = fadd double %t7.7, %t10.7
  %t7.8 = fadd double %t11.7, -1.000000e+00
  %t10.8 = fdiv double %t0, %t11.7
  %t11.8 = fadd double %t7.8, %t10.8
  %t7.9 = fadd double %t11.8, -1.000000e+00
  %t10.9 = fdiv double %t0, %t11.8
  %t11.9 = fadd double %t7.9, %t10.9
  ret double %t11.9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @_zen_std_exp(double %t0) local_unnamed_addr #1 {
entry:
  %t15 = fadd double %t0, 1.000000e+00
  %t8.1 = fmul double %t0, %t0
  %t11.1 = fmul double %t8.1, 5.000000e-01
  %t15.1 = fadd double %t15, %t11.1
  %t8.2 = fmul double %t0, %t11.1
  %t11.2 = fdiv double %t8.2, 3.000000e+00
  %t15.2 = fadd double %t15.1, %t11.2
  %t8.3 = fmul double %t0, %t11.2
  %t11.3 = fmul double %t8.3, 2.500000e-01
  %t15.3 = fadd double %t15.2, %t11.3
  %t8.4 = fmul double %t0, %t11.3
  %t11.4 = fdiv double %t8.4, 5.000000e+00
  %t15.4 = fadd double %t15.3, %t11.4
  %t8.5 = fmul double %t0, %t11.4
  %t11.5 = fdiv double %t8.5, 6.000000e+00
  %t15.5 = fadd double %t15.4, %t11.5
  %t8.6 = fmul double %t0, %t11.5
  %t11.6 = fdiv double %t8.6, 7.000000e+00
  %t15.6 = fadd double %t15.5, %t11.6
  %t8.7 = fmul double %t0, %t11.6
  %t11.7 = fmul double %t8.7, 1.250000e-01
  %t15.7 = fadd double %t15.6, %t11.7
  %t8.8 = fmul double %t0, %t11.7
  %t11.8 = fdiv double %t8.8, 9.000000e+00
  %t15.8 = fadd double %t15.7, %t11.8
  ret double %t15.8
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none)
define i32 @_zen_std_randomInt(i32 %t0, i32 %t1) local_unnamed_addr #3 {
entry:
  %t0.i = load i64, ptr @SEED, align 4
  %t5.i = load i32, ptr @I32_MAX, align 4
  %t2.i = mul i64 %t0.i, 1103515245
  %t4.i = add i64 %t2.i, 12345
  %t6.i = sext i32 %t5.i to i64
  %t7.i = srem i64 %t4.i, %t6.i
  %t10.i = icmp slt i64 %t7.i, 0
  %t15.i = select i1 %t10.i, i64 %t6.i, i64 0
  %spec.select.i = add nsw i64 %t15.i, %t7.i
  store i64 %spec.select.i, ptr @SEED, align 4
  %t18.i = sitofp i64 %spec.select.i to double
  %t19.i = fdiv double %t18.i, 0x41DFFFFFFFC00000
  %reass.sub = sub i32 %t1, %t0
  %t9 = add i32 %reass.sub, 1
  %t10 = sitofp i32 %t9 to double
  %t11 = fmul double %t19.i, %t10
  %t12 = fptosi double %t11 to i32
  %t13 = add i32 %t0, %t12
  ret i32 %t13
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none)
define double @_zen_std_random() local_unnamed_addr #3 {
entry:
  %t0 = load i64, ptr @SEED, align 4
  %t5 = load i32, ptr @I32_MAX, align 4
  %t2 = mul i64 %t0, 1103515245
  %t4 = add i64 %t2, 12345
  %t6 = sext i32 %t5 to i64
  %t7 = srem i64 %t4, %t6
  %t10 = icmp slt i64 %t7, 0
  %t15 = select i1 %t10, i64 %t6, i64 0
  %spec.select = add nsw i64 %t7, %t15
  store i64 %spec.select, ptr @SEED, align 4
  %t18 = sitofp i64 %spec.select to double
  %t19 = fdiv double %t18, 0x41DFFFFFFFC00000
  ret double %t19
}

define i1 @_zen_std_match(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t4316 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t5317 = tail call i1 @_zen_std_contains(ptr %t1, ptr %t4316)
  br i1 %t5317, label %if343, label %whileCond352.preheader

tailrecurse.loopexit:                             ; preds = %end347, %if343
  %t6.0.lcssa = phi ptr [ %t8, %if343 ], [ %t6.1, %end347 ]
  %t4 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t5 = tail call i1 @_zen_std_contains(ptr %t6.0.lcssa, ptr %t4)
  br i1 %t5, label %if343, label %whileCond352.preheader

whileCond352.preheader:                           ; preds = %tailrecurse.loopexit, %entry
  %t1.tr.lcssa = phi ptr [ %t1, %entry ], [ %t6.0.lcssa, %tailrecurse.loopexit ]
  %t43335 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t44336 = icmp sgt i32 %t43335, 0
  br i1 %t44336, label %whileBody353, label %whileEnd354

if343:                                            ; preds = %entry, %tailrecurse.loopexit
  %t1.tr318 = phi ptr [ %t6.0.lcssa, %tailrecurse.loopexit ], [ %t1, %entry ]
  %t8 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t12312 = tail call i32 @strlen(ptr %t1.tr318)
  %t13313 = icmp sgt i32 %t12312, 0
  br i1 %t13313, label %whileBody345, label %tailrecurse.loopexit

whileBody345:                                     ; preds = %if343, %end347
  %t6.0315 = phi ptr [ %t6.1, %end347 ], [ %t8, %if343 ]
  %t9.0314 = phi i32 [ %t34, %end347 ], [ 0, %if343 ]
  %t3.i = tail call i32 @strlen(ptr %t1.tr318)
  %t10.i.not = icmp slt i32 %t9.0314, %t3.i
  br i1 %t10.i.not, label %end133.i, label %if137.i

if137.i:                                          ; preds = %whileBody345
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %whileBody345
  %0 = zext nneg i32 %t9.0314 to i64
  %t15.i = getelementptr i8, ptr %t1.tr318, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i, %if137.i ], [ %t17.i, %end133.i ]
  %t20 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t21 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t20)
  %t22 = icmp eq i32 %t21, 0
  br i1 %t22, label %if348, label %else349

if348:                                            ; preds = %_zen_std_charAt.exit
  %t25 = tail call i1 @_zen_std_match(ptr %t0, ptr %t6.0315)
  br i1 %t25, label %common.ret, label %end350

common.ret:                                       ; preds = %if348, %_zen_std_charAt.exit270, %_zen_std_charAt.exit123, %_zen_std_charAt.exit294, %end472, %rhs488, %_zen_std_slice.exit225, %rhs396, %if392, %_zen_std_charAt.exit147, %if386, %_zen_std_charAt.exit135, %if380, %rhs375, %if371, %if356, %else486, %whileCond492.backedge, %_zen_std_slice.exit99, %whileCond363, %whileCond419.preheader, %whileCond363.preheader, %rhs434, %if430, %whileEnd421, %end412, %if360, %whileEnd354, %if471, %whileEnd449, %end427
  %common.ret.op = phi i1 [ %t309, %end427 ], [ %t412, %whileEnd449 ], [ %t421, %if471 ], [ %t537, %whileEnd354 ], [ true, %if360 ], [ false, %end412 ], [ false, %whileEnd421 ], [ false, %if430 ], [ false, %rhs434 ], [ false, %whileCond363.preheader ], [ false, %whileCond419.preheader ], [ %t95, %whileCond363 ], [ %t95, %_zen_std_slice.exit99 ], [ false, %whileCond492.backedge ], [ false, %else486 ], [ false, %if356 ], [ false, %if371 ], [ false, %rhs375 ], [ false, %if380 ], [ false, %_zen_std_charAt.exit135 ], [ false, %if386 ], [ false, %_zen_std_charAt.exit147 ], [ false, %if392 ], [ false, %rhs396 ], [ false, %_zen_std_slice.exit225 ], [ false, %rhs488 ], [ false, %end472 ], [ false, %_zen_std_charAt.exit294 ], [ false, %_zen_std_charAt.exit123 ], [ false, %_zen_std_charAt.exit270 ], [ true, %if348 ]
  ret i1 %common.ret.op

end350:                                           ; preds = %if348
  %t27 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end347

else349:                                          ; preds = %_zen_std_charAt.exit
  %t31 = tail call ptr @_str_concat(ptr %t6.0315, ptr nonnull %common.ret.op.i)
  br label %end347

end347:                                           ; preds = %else349, %end350
  %t6.1 = phi ptr [ %t27, %end350 ], [ %t31, %else349 ]
  %t34 = add nuw nsw i32 %t9.0314, 1
  %t12 = tail call i32 @strlen(ptr %t1.tr318)
  %t13 = icmp slt i32 %t34, %t12
  br i1 %t13, label %whileBody345, label %tailrecurse.loopexit

whileBody353:                                     ; preds = %whileCond352.preheader, %whileCond352.backedge
  %t39.0339 = phi i32 [ %t39.0.be, %whileCond352.backedge ], [ 0, %whileCond352.preheader ]
  %t40.0337 = phi i32 [ %t40.0.be, %whileCond352.backedge ], [ 0, %whileCond352.preheader ]
  %t3.i68 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i69 = icmp slt i32 %t40.0337, 0
  %t10.i70 = icmp sge i32 %t40.0337, %t3.i68
  %t5.i71 = select i1 %t7.i69, i1 true, i1 %t10.i70
  br i1 %t5.i71, label %if137.i77, label %end133.i72

if137.i77:                                        ; preds = %whileBody353
  %t12.i78 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit79

end133.i72:                                       ; preds = %whileBody353
  %1 = zext nneg i32 %t40.0337 to i64
  %t15.i73 = getelementptr i8, ptr %t1.tr.lcssa, i64 %1
  %t16.i74 = load i8, ptr %t15.i73, align 1
  %t17.i75 = tail call ptr @_zen_char_to_string(i8 %t16.i74)
  br label %_zen_std_charAt.exit79

_zen_std_charAt.exit79:                           ; preds = %if137.i77, %end133.i72
  %common.ret.op.i76 = phi ptr [ %t12.i78, %if137.i77 ], [ %t17.i75, %end133.i72 ]
  %t51 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_10)
  %t52 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t51)
  %t53 = icmp eq i32 %t52, 0
  br i1 %t53, label %if356, label %end355

if356:                                            ; preds = %_zen_std_charAt.exit79
  %t56 = tail call i32 @strlen(ptr %t0)
  %t57.not = icmp slt i32 %t39.0339, %t56
  br i1 %t57.not, label %end357, label %common.ret

end357:                                           ; preds = %if356
  %t62 = add nsw i32 %t40.0337, 1
  br label %whileCond352.backedge

whileCond352.backedge:                            ; preds = %end357, %end374, %end383, %end389, %end395, %end499, %end503
  %t40.0.be = phi i32 [ %t62, %end357 ], [ %t137, %end374 ], [ %t161, %end383 ], [ %t185, %end389 ], [ %t215, %end395 ], [ %t516, %end499 ], [ %t532, %end503 ]
  %t39.0.be = add i32 %t39.0339, 1
  %t43 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t44 = icmp slt i32 %t40.0.be, %t43
  br i1 %t44, label %whileBody353, label %whileEnd354

end355:                                           ; preds = %_zen_std_charAt.exit79
  %t66 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_11)
  %t67 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t66)
  %t68 = icmp eq i32 %t67, 0
  br i1 %t68, label %if360, label %end359

if360:                                            ; preds = %end355
  %t72 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t70 = add nsw i32 %t40.0337, 1
  %t73.not = icmp slt i32 %t70, %t72
  br i1 %t73.not, label %whileCond363.preheader, label %common.ret

whileCond363.preheader:                           ; preds = %if360
  %t78354 = tail call i32 @strlen(ptr %t0)
  %t79.not355 = icmp sgt i32 %t39.0339, %t78354
  br i1 %t79.not355, label %common.ret, label %whileBody364.lr.ph

whileBody364.lr.ph:                               ; preds = %whileCond363.preheader
  %spec.store.select.i83 = tail call i32 @llvm.smax.i32(i32 %t70, i32 0)
  br label %whileBody364

whileCond363:                                     ; preds = %_zen_std_slice.exit99
  %t97 = add i32 %t74.0356, 1
  %t78 = tail call i32 @strlen(ptr %t0)
  %t79.not = icmp sgt i32 %t97, %t78
  br i1 %t79.not, label %common.ret, label %whileBody364

whileBody364:                                     ; preds = %whileBody364.lr.ph, %whileCond363
  %t74.0356 = phi i32 [ %t39.0339, %whileBody364.lr.ph ], [ %t97, %whileCond363 ]
  %t83 = tail call i32 @strlen(ptr %t0)
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t74.0356, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t83, i32 %t4.i)
  %t16.i80 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i80, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody131.i, label %_zen_std_slice.exit

whileBody131.i:                                   ; preds = %whileBody364, %whileBody131.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody131.i ], [ %t18.i, %whileBody364 ]
  %t22.09.i = phi i32 [ %t37.i, %whileBody131.i ], [ %spec.store.select.i, %whileBody364 ]
  %2 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t0, i64 %2
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %t37.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t37.i, %spec.select.i
  br i1 %t26.i, label %whileBody131.i, label %_zen_std_slice.exit

_zen_std_slice.exit:                              ; preds = %whileBody131.i, %whileBody364
  %common.ret.op.i81 = phi ptr [ %t18.i, %whileBody364 ], [ %t34.i, %whileBody131.i ]
  %t90 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t4.i82 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %spec.select.i84 = tail call i32 @llvm.smin.i32(i32 %t90, i32 %t4.i82)
  %t16.i85 = icmp sle i32 %spec.store.select.i83, %spec.select.i84
  %t18.i86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i87 = icmp samesign ult i32 %spec.store.select.i83, %spec.select.i84
  %or.cond.i88 = select i1 %t16.i85, i1 %t268.i87, i1 false
  br i1 %or.cond.i88, label %whileBody131.i90, label %_zen_std_slice.exit99

whileBody131.i90:                                 ; preds = %_zen_std_slice.exit, %whileBody131.i90
  %t19.010.i91 = phi ptr [ %t34.i96, %whileBody131.i90 ], [ %t18.i86, %_zen_std_slice.exit ]
  %t22.09.i92 = phi i32 [ %t37.i97, %whileBody131.i90 ], [ %spec.store.select.i83, %_zen_std_slice.exit ]
  %3 = zext nneg i32 %t22.09.i92 to i64
  %t30.i93 = getelementptr i8, ptr %t1.tr.lcssa, i64 %3
  %t31.i94 = load i8, ptr %t30.i93, align 1
  %t32.i95 = tail call ptr @_zen_char_to_string(i8 %t31.i94)
  %t34.i96 = tail call ptr @_str_concat(ptr %t19.010.i91, ptr %t32.i95)
  %t37.i97 = add nuw nsw i32 %t22.09.i92, 1
  %t26.i98 = icmp slt i32 %t37.i97, %spec.select.i84
  br i1 %t26.i98, label %whileBody131.i90, label %_zen_std_slice.exit99

_zen_std_slice.exit99:                            ; preds = %whileBody131.i90, %_zen_std_slice.exit
  %common.ret.op.i89 = phi ptr [ %t18.i86, %_zen_std_slice.exit ], [ %t34.i96, %whileBody131.i90 ]
  %t95 = tail call i1 @_zen_std_match(ptr %common.ret.op.i81, ptr %common.ret.op.i89)
  br i1 %t95, label %common.ret, label %whileCond363

end359:                                           ; preds = %end355
  %t101 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_12)
  %t102 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t101)
  %t103 = icmp eq i32 %t102, 0
  br i1 %t103, label %if369, label %end368

if369:                                            ; preds = %end359
  %t106 = add nsw i32 %t40.0337, 1
  %t3.i100 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i101 = icmp slt i32 %t40.0337, -1
  %t10.i102 = icmp sge i32 %t106, %t3.i100
  %t5.i103 = select i1 %t7.i101, i1 true, i1 %t10.i102
  br i1 %t5.i103, label %if137.i109, label %end133.i104

if137.i109:                                       ; preds = %if369
  %t12.i110 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit111

end133.i104:                                      ; preds = %if369
  %4 = zext nneg i32 %t106 to i64
  %t15.i105 = getelementptr i8, ptr %t1.tr.lcssa, i64 %4
  %t16.i106 = load i8, ptr %t15.i105, align 1
  %t17.i107 = tail call ptr @_zen_char_to_string(i8 %t16.i106)
  br label %_zen_std_charAt.exit111

_zen_std_charAt.exit111:                          ; preds = %if137.i109, %end133.i104
  %common.ret.op.i108 = phi ptr [ %t12.i110, %if137.i109 ], [ %t17.i107, %end133.i104 ]
  %t111 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_13)
  %t112 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t111)
  %t113 = icmp eq i32 %t112, 0
  br i1 %t113, label %if371, label %end370

if371:                                            ; preds = %_zen_std_charAt.exit111
  %t116 = tail call i32 @strlen(ptr %t0)
  %t117.not = icmp slt i32 %t39.0339, %t116
  br i1 %t117.not, label %end372, label %common.ret

end372:                                           ; preds = %if371
  %t3.i112 = tail call i32 @strlen(ptr %t0)
  %t7.i113 = icmp slt i32 %t39.0339, 0
  %t10.i114 = icmp sge i32 %t39.0339, %t3.i112
  %t5.i115 = select i1 %t7.i113, i1 true, i1 %t10.i114
  br i1 %t5.i115, label %if137.i121, label %end133.i116

if137.i121:                                       ; preds = %end372
  %t12.i122 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit123

end133.i116:                                      ; preds = %end372
  %5 = zext nneg i32 %t39.0339 to i64
  %t15.i117 = getelementptr i8, ptr %t0, i64 %5
  %t16.i118 = load i8, ptr %t15.i117, align 1
  %t17.i119 = tail call ptr @_zen_char_to_string(i8 %t16.i118)
  br label %_zen_std_charAt.exit123

_zen_std_charAt.exit123:                          ; preds = %if137.i121, %end133.i116
  %common.ret.op.i120 = phi ptr [ %t12.i122, %if137.i121 ], [ %t17.i119, %end133.i116 ]
  %t125 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t130 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t126 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i120, ptr noundef nonnull dereferenceable(1) %t125)
  %t127 = icmp slt i32 %t126, 0
  br i1 %t127, label %common.ret, label %rhs375

rhs375:                                           ; preds = %_zen_std_charAt.exit123
  %t131 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i120, ptr noundef nonnull dereferenceable(1) %t130)
  %t132 = icmp sgt i32 %t131, 0
  br i1 %t132, label %common.ret, label %end374

end374:                                           ; preds = %rhs375
  %t137 = add i32 %t40.0337, 2
  br label %whileCond352.backedge

end370:                                           ; preds = %_zen_std_charAt.exit111
  %t141 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t142 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t141)
  %t143 = icmp eq i32 %t142, 0
  br i1 %t143, label %if380, label %end379

if380:                                            ; preds = %end370
  %t146 = tail call i32 @strlen(ptr %t0)
  %t147.not = icmp slt i32 %t39.0339, %t146
  br i1 %t147.not, label %end381, label %common.ret

end381:                                           ; preds = %if380
  %t3.i124 = tail call i32 @strlen(ptr %t0)
  %t7.i125 = icmp slt i32 %t39.0339, 0
  %t10.i126 = icmp sge i32 %t39.0339, %t3.i124
  %t5.i127 = select i1 %t7.i125, i1 true, i1 %t10.i126
  br i1 %t5.i127, label %if137.i133, label %end133.i128

if137.i133:                                       ; preds = %end381
  %t12.i134 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit135

end133.i128:                                      ; preds = %end381
  %6 = zext nneg i32 %t39.0339 to i64
  %t15.i129 = getelementptr i8, ptr %t0, i64 %6
  %t16.i130 = load i8, ptr %t15.i129, align 1
  %t17.i131 = tail call ptr @_zen_char_to_string(i8 %t16.i130)
  br label %_zen_std_charAt.exit135

_zen_std_charAt.exit135:                          ; preds = %if137.i133, %end133.i128
  %common.ret.op.i132 = phi ptr [ %t12.i134, %if137.i133 ], [ %t17.i131, %end133.i128 ]
  %t153 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_16)
  %t155 = tail call i1 @_zen_std_contains(ptr %t153, ptr %common.ret.op.i132)
  br i1 %t155, label %end383, label %common.ret

end383:                                           ; preds = %_zen_std_charAt.exit135
  %t161 = add i32 %t40.0337, 2
  br label %whileCond352.backedge

end379:                                           ; preds = %end370
  %t165 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_17)
  %t166 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t165)
  %t167 = icmp eq i32 %t166, 0
  br i1 %t167, label %if386, label %end385

if386:                                            ; preds = %end379
  %t170 = tail call i32 @strlen(ptr %t0)
  %t171.not = icmp slt i32 %t39.0339, %t170
  br i1 %t171.not, label %end387, label %common.ret

end387:                                           ; preds = %if386
  %t3.i136 = tail call i32 @strlen(ptr %t0)
  %t7.i137 = icmp slt i32 %t39.0339, 0
  %t10.i138 = icmp sge i32 %t39.0339, %t3.i136
  %t5.i139 = select i1 %t7.i137, i1 true, i1 %t10.i138
  br i1 %t5.i139, label %if137.i145, label %end133.i140

if137.i145:                                       ; preds = %end387
  %t12.i146 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit147

end133.i140:                                      ; preds = %end387
  %7 = zext nneg i32 %t39.0339 to i64
  %t15.i141 = getelementptr i8, ptr %t0, i64 %7
  %t16.i142 = load i8, ptr %t15.i141, align 1
  %t17.i143 = tail call ptr @_zen_char_to_string(i8 %t16.i142)
  br label %_zen_std_charAt.exit147

_zen_std_charAt.exit147:                          ; preds = %if137.i145, %end133.i140
  %common.ret.op.i144 = phi ptr [ %t12.i146, %if137.i145 ], [ %t17.i143, %end133.i140 ]
  %t177 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_18)
  %t179 = tail call i1 @_zen_std_contains(ptr %t177, ptr %common.ret.op.i144)
  br i1 %t179, label %end389, label %common.ret

end389:                                           ; preds = %_zen_std_charAt.exit147
  %t185 = add i32 %t40.0337, 2
  br label %whileCond352.backedge

end385:                                           ; preds = %end379
  %t189 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_19)
  %t190 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t189)
  %t191 = icmp eq i32 %t190, 0
  br i1 %t191, label %if392, label %end368

if392:                                            ; preds = %end385
  %t194 = tail call i32 @strlen(ptr %t0)
  %t195.not = icmp slt i32 %t39.0339, %t194
  br i1 %t195.not, label %end393, label %common.ret

end393:                                           ; preds = %if392
  %t3.i148 = tail call i32 @strlen(ptr %t0)
  %t7.i149 = icmp slt i32 %t39.0339, 0
  %t10.i150 = icmp sge i32 %t39.0339, %t3.i148
  %t5.i151 = select i1 %t7.i149, i1 true, i1 %t10.i150
  br i1 %t5.i151, label %if137.i157, label %end133.i152

if137.i157:                                       ; preds = %end393
  %t12.i158 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit159

end133.i152:                                      ; preds = %end393
  %8 = zext nneg i32 %t39.0339 to i64
  %t15.i153 = getelementptr i8, ptr %t0, i64 %8
  %t16.i154 = load i8, ptr %t15.i153, align 1
  %t17.i155 = tail call ptr @_zen_char_to_string(i8 %t16.i154)
  br label %_zen_std_charAt.exit159

_zen_std_charAt.exit159:                          ; preds = %if137.i157, %end133.i152
  %common.ret.op.i156 = phi ptr [ %t12.i158, %if137.i157 ], [ %t17.i155, %end133.i152 ]
  %t203 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t208 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t204 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i156, ptr noundef nonnull dereferenceable(1) %t203)
  %t205.not = icmp eq i32 %t204, 0
  br i1 %t205.not, label %end395, label %rhs396

rhs396:                                           ; preds = %_zen_std_charAt.exit159
  %t209 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i156, ptr noundef nonnull dereferenceable(1) %t208)
  %t210.not = icmp eq i32 %t209, 0
  br i1 %t210.not, label %end395, label %common.ret

end395:                                           ; preds = %_zen_std_charAt.exit159, %rhs396
  %t215 = add i32 %t40.0337, 2
  br label %whileCond352.backedge

end368:                                           ; preds = %end385, %end359
  %t219 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_20)
  %t220 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t219)
  %t221 = icmp eq i32 %t220, 0
  br i1 %t221, label %if401, label %end400

if401:                                            ; preds = %end368
  %t224 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t229320 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t230321 = icmp slt i32 %t40.0337, %t229320
  br i1 %t230321, label %whileBody403, label %whileEnd404

whileBody403:                                     ; preds = %if401, %end405
  %t222.0323 = phi ptr [ %t248, %end405 ], [ %t224, %if401 ]
  %t225.0322 = phi i32 [ %t251, %end405 ], [ %t40.0337, %if401 ]
  %t3.i160 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i161 = icmp slt i32 %t225.0322, 0
  %t10.i162 = icmp sge i32 %t225.0322, %t3.i160
  %t5.i163 = select i1 %t7.i161, i1 true, i1 %t10.i162
  br i1 %t5.i163, label %if137.i169, label %end133.i164

if137.i169:                                       ; preds = %whileBody403
  %t12.i170 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit171

end133.i164:                                      ; preds = %whileBody403
  %9 = zext nneg i32 %t225.0322 to i64
  %t15.i165 = getelementptr i8, ptr %t1.tr.lcssa, i64 %9
  %t16.i166 = load i8, ptr %t15.i165, align 1
  %t17.i167 = tail call ptr @_zen_char_to_string(i8 %t16.i166)
  br label %_zen_std_charAt.exit171

_zen_std_charAt.exit171:                          ; preds = %if137.i169, %end133.i164
  %common.ret.op.i168 = phi ptr [ %t12.i170, %if137.i169 ], [ %t17.i167, %end133.i164 ]
  %t238 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t243 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t239 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i168, ptr noundef nonnull dereferenceable(1) %t238)
  %t240 = icmp eq i32 %t239, 0
  br i1 %t240, label %whileEnd404, label %rhs406

rhs406:                                           ; preds = %_zen_std_charAt.exit171
  %t244 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i168, ptr noundef nonnull dereferenceable(1) %t243)
  %t245 = icmp eq i32 %t244, 0
  br i1 %t245, label %whileEnd404, label %end405

end405:                                           ; preds = %rhs406
  %t248 = tail call ptr @_str_concat(ptr %t222.0323, ptr nonnull %common.ret.op.i168)
  %t251 = add nsw i32 %t225.0322, 1
  %t229 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t230 = icmp slt i32 %t251, %t229
  br i1 %t230, label %whileBody403, label %whileEnd404

whileEnd404:                                      ; preds = %end405, %rhs406, %_zen_std_charAt.exit171, %if401
  %t222.0.lcssa = phi ptr [ %t224, %if401 ], [ %t222.0323, %_zen_std_charAt.exit171 ], [ %t222.0323, %rhs406 ], [ %t248, %end405 ]
  %t255 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_21)
  %t256 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t222.0.lcssa, ptr noundef nonnull dereferenceable(1) %t255)
  %t257 = icmp eq i32 %t256, 0
  br i1 %t257, label %if411, label %end410

if411:                                            ; preds = %whileEnd404
  %t263 = tail call i32 @strlen(ptr %t0)
  %t269 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_22)
  %t264 = icmp slt i32 %t39.0339, %t263
  br i1 %t264, label %rhs413, label %end412

rhs413:                                           ; preds = %if411
  %t267 = tail call ptr @_zen_std_charAt(ptr %t0, i32 %t39.0339)
  %t270 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t267, ptr noundef nonnull dereferenceable(1) %t269)
  %t271 = icmp eq i32 %t270, 0
  %t273 = zext i1 %t271 to i32
  %spec.select = add nsw i32 %t39.0339, %t273
  br label %end412

end412:                                           ; preds = %rhs413, %if411
  %t39.1 = phi i32 [ %t39.0339, %if411 ], [ %spec.select, %rhs413 ]
  %t277 = tail call i32 @strlen(ptr %t0)
  %t278.not = icmp slt i32 %t39.1, %t277
  br i1 %t278.not, label %whileCond419.preheader, label %common.ret

whileCond419.preheader:                           ; preds = %end412
  %t283348 = tail call i32 @strlen(ptr %t0)
  %t284349 = icmp slt i32 %t39.1, %t283348
  br i1 %t284349, label %whileBody420, label %common.ret

whileBody420:                                     ; preds = %whileCond419.preheader, %end422
  %t39.2350 = phi i32 [ %t301, %end422 ], [ %t39.1, %whileCond419.preheader ]
  %t3.i172 = tail call i32 @strlen(ptr %t0)
  %t7.i173 = icmp slt i32 %t39.2350, 0
  %t10.i174 = icmp sge i32 %t39.2350, %t3.i172
  %t5.i175 = select i1 %t7.i173, i1 true, i1 %t10.i174
  br i1 %t5.i175, label %if137.i181, label %end133.i176

if137.i181:                                       ; preds = %whileBody420
  %t12.i182 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit183

end133.i176:                                      ; preds = %whileBody420
  %10 = zext nneg i32 %t39.2350 to i64
  %t15.i177 = getelementptr i8, ptr %t0, i64 %10
  %t16.i178 = load i8, ptr %t15.i177, align 1
  %t17.i179 = tail call ptr @_zen_char_to_string(i8 %t16.i178)
  br label %_zen_std_charAt.exit183

_zen_std_charAt.exit183:                          ; preds = %if137.i181, %end133.i176
  %common.ret.op.i180 = phi ptr [ %t12.i182, %if137.i181 ], [ %t17.i179, %end133.i176 ]
  %t292 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t297 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t293 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i180, ptr noundef nonnull dereferenceable(1) %t292)
  %t294 = icmp slt i32 %t293, 0
  br i1 %t294, label %whileEnd421, label %rhs423

rhs423:                                           ; preds = %_zen_std_charAt.exit183
  %t298 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i180, ptr noundef nonnull dereferenceable(1) %t297)
  %t299 = icmp sgt i32 %t298, 0
  br i1 %t299, label %whileEnd421, label %end422

end422:                                           ; preds = %rhs423
  %t301 = add nsw i32 %t39.2350, 1
  %t283 = tail call i32 @strlen(ptr %t0)
  %t284 = icmp slt i32 %t301, %t283
  br i1 %t284, label %whileBody420, label %whileEnd421

whileEnd421:                                      ; preds = %end422, %rhs423, %_zen_std_charAt.exit183
  %t39.2.lcssa = phi i32 [ %t301, %end422 ], [ %t39.2350, %rhs423 ], [ %t39.2350, %_zen_std_charAt.exit183 ]
  %t305.not = icmp sgt i32 %t39.2.lcssa, %t39.1
  br i1 %t305.not, label %end427, label %common.ret

end427:                                           ; preds = %whileEnd421
  %t308 = tail call i32 @strlen(ptr %t0)
  %t309 = icmp eq i32 %t39.2.lcssa, %t308
  br label %common.ret

end410:                                           ; preds = %whileEnd404
  %t312 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_23)
  %t313 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t222.0.lcssa, ptr noundef nonnull dereferenceable(1) %t312)
  %t314 = icmp eq i32 %t313, 0
  br i1 %t314, label %if430, label %end429

if430:                                            ; preds = %end410
  %t317 = tail call i32 @strlen(ptr %t0)
  %t318.not = icmp slt i32 %t39.0339, %t317
  br i1 %t318.not, label %end431, label %common.ret

end431:                                           ; preds = %if430
  %t321 = tail call ptr @_zen_std_charAt(ptr %t0, i32 %t39.0339)
  %t328 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t333 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t339 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t344 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t349 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_24)
  %t329 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t328)
  %t330 = icmp sgt i32 %t329, -1
  br i1 %t330, label %rhs440, label %rhs437

rhs440:                                           ; preds = %end431
  %t334 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t333)
  %t335 = icmp slt i32 %t334, 1
  br i1 %t335, label %end433, label %rhs437

rhs437:                                           ; preds = %end431, %rhs440
  %t340 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t339)
  %t341 = icmp sgt i32 %t340, -1
  br i1 %t341, label %rhs443, label %rhs434

rhs443:                                           ; preds = %rhs437
  %t345 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t344)
  %t346 = icmp slt i32 %t345, 1
  br i1 %t346, label %end433, label %rhs434

rhs434:                                           ; preds = %rhs437, %rhs443
  %t350 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t349)
  %t351.not = icmp eq i32 %t350, 0
  br i1 %t351.not, label %end433, label %common.ret

end433:                                           ; preds = %rhs440, %rhs443, %rhs434
  %t39.3341 = add nsw i32 %t39.0339, 1
  %t358342 = tail call i32 @strlen(ptr %t0)
  %t359343 = icmp slt i32 %t39.3341, %t358342
  br i1 %t359343, label %whileBody448, label %whileEnd449

whileBody448:                                     ; preds = %end433, %end450
  %t39.3345 = phi i32 [ %t39.3, %end450 ], [ %t39.3341, %end433 ]
  %t39.3.in344 = phi i32 [ %t39.3345, %end450 ], [ %t39.0339, %end433 ]
  %t3.i184 = tail call i32 @strlen(ptr %t0)
  %t7.i185 = icmp slt i32 %t39.3.in344, -1
  %t10.i186 = icmp sge i32 %t39.3345, %t3.i184
  %t5.i187 = select i1 %t7.i185, i1 true, i1 %t10.i186
  br i1 %t5.i187, label %if137.i193, label %end133.i188

if137.i193:                                       ; preds = %whileBody448
  %t12.i194 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit195

end133.i188:                                      ; preds = %whileBody448
  %11 = zext nneg i32 %t39.3345 to i64
  %t15.i189 = getelementptr i8, ptr %t0, i64 %11
  %t16.i190 = load i8, ptr %t15.i189, align 1
  %t17.i191 = tail call ptr @_zen_char_to_string(i8 %t16.i190)
  br label %_zen_std_charAt.exit195

_zen_std_charAt.exit195:                          ; preds = %if137.i193, %end133.i188
  %common.ret.op.i192 = phi ptr [ %t12.i194, %if137.i193 ], [ %t17.i191, %end133.i188 ]
  %t370 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t375 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t381 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t386 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t392 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t397 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t402 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_24)
  %t371 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t370)
  %t372 = icmp sgt i32 %t371, -1
  br i1 %t372, label %rhs460, label %rhs457

rhs460:                                           ; preds = %_zen_std_charAt.exit195
  %t376 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t375)
  %t377 = icmp slt i32 %t376, 1
  br i1 %t377, label %end450, label %rhs457

rhs457:                                           ; preds = %_zen_std_charAt.exit195, %rhs460
  %t382 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t381)
  %t383 = icmp sgt i32 %t382, -1
  br i1 %t383, label %rhs463, label %rhs454

rhs463:                                           ; preds = %rhs457
  %t387 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t386)
  %t388 = icmp slt i32 %t387, 1
  br i1 %t388, label %end450, label %rhs454

rhs454:                                           ; preds = %rhs457, %rhs463
  %t393 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t392)
  %t394 = icmp sgt i32 %t393, -1
  br i1 %t394, label %rhs466, label %rhs451

rhs466:                                           ; preds = %rhs454
  %t398 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t397)
  %t399 = icmp slt i32 %t398, 1
  br i1 %t399, label %end450, label %rhs451

rhs451:                                           ; preds = %rhs454, %rhs466
  %t403 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t402)
  %t404.not = icmp eq i32 %t403, 0
  br i1 %t404.not, label %end450, label %whileEnd449

end450:                                           ; preds = %rhs460, %rhs463, %rhs466, %rhs451
  %t39.3 = add nsw i32 %t39.3345, 1
  %t358 = tail call i32 @strlen(ptr %t0)
  %t359 = icmp slt i32 %t39.3, %t358
  br i1 %t359, label %whileBody448, label %whileEnd449

whileEnd449:                                      ; preds = %end450, %rhs451, %end433
  %t39.3.lcssa = phi i32 [ %t39.3341, %end433 ], [ %t39.3345, %rhs451 ], [ %t39.3, %end450 ]
  %t411 = tail call i32 @strlen(ptr %t0)
  %t412 = icmp eq i32 %t39.3.lcssa, %t411
  br label %common.ret

end429:                                           ; preds = %end410
  %t415 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_25)
  %t416 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t222.0.lcssa, ptr noundef nonnull dereferenceable(1) %t415)
  %t417 = icmp eq i32 %t416, 0
  br i1 %t417, label %if471, label %end400

if471:                                            ; preds = %end429
  %t420 = tail call i32 @strlen(ptr %t0)
  %t421 = icmp slt i32 %t39.0339, %t420
  br label %common.ret

end400:                                           ; preds = %end429, %end368
  %t424 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t425 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t424)
  %t426 = icmp eq i32 %t425, 0
  br i1 %t426, label %if473, label %end472

if473:                                            ; preds = %end400
  %t429 = add i32 %t40.0337, 1
  %t432327 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t433328 = icmp slt i32 %t429, %t432327
  br i1 %t433328, label %whileBody475, label %whileEnd476

whileBody475:                                     ; preds = %if473, %end477
  %t427.0329 = phi i32 [ %t442, %end477 ], [ %t429, %if473 ]
  %t438 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i196 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i197 = icmp slt i32 %t427.0329, 0
  %t10.i198 = icmp sge i32 %t427.0329, %t3.i196
  %t5.i199 = select i1 %t7.i197, i1 true, i1 %t10.i198
  br i1 %t5.i199, label %if137.i205, label %end133.i200

if137.i205:                                       ; preds = %whileBody475
  %t12.i206 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit207

end133.i200:                                      ; preds = %whileBody475
  %12 = zext nneg i32 %t427.0329 to i64
  %t15.i201 = getelementptr i8, ptr %t1.tr.lcssa, i64 %12
  %t16.i202 = load i8, ptr %t15.i201, align 1
  %t17.i203 = tail call ptr @_zen_char_to_string(i8 %t16.i202)
  br label %_zen_std_charAt.exit207

_zen_std_charAt.exit207:                          ; preds = %if137.i205, %end133.i200
  %common.ret.op.i204 = phi ptr [ %t12.i206, %if137.i205 ], [ %t17.i203, %end133.i200 ]
  %t439 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i204, ptr noundef nonnull dereferenceable(1) %t438)
  %t440 = icmp eq i32 %t439, 0
  br i1 %t440, label %whileEnd476, label %end477

end477:                                           ; preds = %_zen_std_charAt.exit207
  %t442 = add nsw i32 %t427.0329, 1
  %t432 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t433 = icmp slt i32 %t442, %t432
  br i1 %t433, label %whileBody475, label %whileEnd476

whileEnd476:                                      ; preds = %end477, %_zen_std_charAt.exit207, %if473
  %t427.0.lcssa = phi i32 [ %t429, %if473 ], [ %t427.0329, %_zen_std_charAt.exit207 ], [ %t442, %end477 ]
  %t4.i208 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %spec.store.select.i209 = tail call i32 @llvm.smax.i32(i32 %t429, i32 0)
  %spec.select.i210 = tail call i32 @llvm.smin.i32(i32 %t427.0.lcssa, i32 %t4.i208)
  %t16.i211 = icmp sle i32 %spec.store.select.i209, %spec.select.i210
  %t18.i212 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i213 = icmp samesign ult i32 %spec.store.select.i209, %spec.select.i210
  %or.cond.i214 = select i1 %t16.i211, i1 %t268.i213, i1 false
  br i1 %or.cond.i214, label %whileBody131.i216, label %_zen_std_slice.exit225

whileBody131.i216:                                ; preds = %whileEnd476, %whileBody131.i216
  %t19.010.i217 = phi ptr [ %t34.i222, %whileBody131.i216 ], [ %t18.i212, %whileEnd476 ]
  %t22.09.i218 = phi i32 [ %t37.i223, %whileBody131.i216 ], [ %spec.store.select.i209, %whileEnd476 ]
  %13 = zext nneg i32 %t22.09.i218 to i64
  %t30.i219 = getelementptr i8, ptr %t1.tr.lcssa, i64 %13
  %t31.i220 = load i8, ptr %t30.i219, align 1
  %t32.i221 = tail call ptr @_zen_char_to_string(i8 %t31.i220)
  %t34.i222 = tail call ptr @_str_concat(ptr %t19.010.i217, ptr %t32.i221)
  %t37.i223 = add nuw nsw i32 %t22.09.i218, 1
  %t26.i224 = icmp slt i32 %t37.i223, %spec.select.i210
  br i1 %t26.i224, label %whileBody131.i216, label %_zen_std_slice.exit225

_zen_std_slice.exit225:                           ; preds = %whileBody131.i216, %whileEnd476
  %common.ret.op.i215 = phi ptr [ %t18.i212, %whileEnd476 ], [ %t34.i222, %whileBody131.i216 ]
  %t452 = tail call i32 @strlen(ptr %t0)
  %t453.not = icmp slt i32 %t39.0339, %t452
  br i1 %t453.not, label %end479, label %common.ret

end479:                                           ; preds = %_zen_std_slice.exit225
  %t3.i226 = tail call i32 @strlen(ptr %t0)
  %t7.i227 = icmp slt i32 %t39.0339, 0
  %t10.i228 = icmp sge i32 %t39.0339, %t3.i226
  %t5.i229 = select i1 %t7.i227, i1 true, i1 %t10.i228
  br i1 %t5.i229, label %if137.i235, label %end133.i230

if137.i235:                                       ; preds = %end479
  %t12.i236 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit237

end133.i230:                                      ; preds = %end479
  %14 = zext nneg i32 %t39.0339 to i64
  %t15.i231 = getelementptr i8, ptr %t0, i64 %14
  %t16.i232 = load i8, ptr %t15.i231, align 1
  %t17.i233 = tail call ptr @_zen_char_to_string(i8 %t16.i232)
  br label %_zen_std_charAt.exit237

_zen_std_charAt.exit237:                          ; preds = %if137.i235, %end133.i230
  %common.ret.op.i234 = phi ptr [ %t12.i236, %if137.i235 ], [ %t17.i233, %end133.i230 ]
  %t461 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t466 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_22)
  %t462 = icmp eq i32 %t461, 3
  br i1 %t462, label %rhs482, label %else486

rhs482:                                           ; preds = %_zen_std_charAt.exit237
  %t3.i238 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i239 = icmp slt i32 %t3.i238, 2
  br i1 %t10.i239, label %if137.i246, label %end133.i241

if137.i246:                                       ; preds = %rhs482
  %t12.i247 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit248

end133.i241:                                      ; preds = %rhs482
  %t15.i242 = getelementptr i8, ptr %common.ret.op.i215, i64 1
  %t16.i243 = load i8, ptr %t15.i242, align 1
  %t17.i244 = tail call ptr @_zen_char_to_string(i8 %t16.i243)
  br label %_zen_std_charAt.exit248

_zen_std_charAt.exit248:                          ; preds = %if137.i246, %end133.i241
  %common.ret.op.i245 = phi ptr [ %t12.i247, %if137.i246 ], [ %t17.i244, %end133.i241 ]
  %t467 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i245, ptr noundef nonnull dereferenceable(1) %t466)
  %t468 = icmp eq i32 %t467, 0
  br i1 %t468, label %if485, label %else486

if485:                                            ; preds = %_zen_std_charAt.exit248
  %t3.i249 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i250 = icmp slt i32 %t3.i249, 1
  br i1 %t10.i250, label %if137.i257, label %end133.i252

if137.i257:                                       ; preds = %if485
  %t12.i258 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit259

end133.i252:                                      ; preds = %if485
  %t16.i254 = load i8, ptr %common.ret.op.i215, align 1
  %t17.i255 = tail call ptr @_zen_char_to_string(i8 %t16.i254)
  br label %_zen_std_charAt.exit259

_zen_std_charAt.exit259:                          ; preds = %if137.i257, %end133.i252
  %common.ret.op.i256 = phi ptr [ %t12.i258, %if137.i257 ], [ %t17.i255, %end133.i252 ]
  %t3.i260 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i261 = icmp slt i32 %t3.i260, 3
  br i1 %t10.i261, label %if137.i268, label %end133.i263

if137.i268:                                       ; preds = %_zen_std_charAt.exit259
  %t12.i269 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit270

end133.i263:                                      ; preds = %_zen_std_charAt.exit259
  %t15.i264 = getelementptr i8, ptr %common.ret.op.i215, i64 2
  %t16.i265 = load i8, ptr %t15.i264, align 1
  %t17.i266 = tail call ptr @_zen_char_to_string(i8 %t16.i265)
  br label %_zen_std_charAt.exit270

_zen_std_charAt.exit270:                          ; preds = %if137.i268, %end133.i263
  %common.ret.op.i267 = phi ptr [ %t12.i269, %if137.i268 ], [ %t17.i266, %end133.i263 ]
  %t478 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i234, ptr noundef nonnull dereferenceable(1) %common.ret.op.i256)
  %t479 = icmp sgt i32 %t478, -1
  br i1 %t479, label %rhs488, label %common.ret

rhs488:                                           ; preds = %_zen_std_charAt.exit270
  %t482 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i234, ptr noundef nonnull dereferenceable(1) %common.ret.op.i267)
  %t483 = icmp sgt i32 %t482, 0
  br i1 %t483, label %common.ret, label %end499

else486:                                          ; preds = %_zen_std_charAt.exit237, %_zen_std_charAt.exit248
  %t488332 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t489333 = icmp sgt i32 %t488332, 0
  br i1 %t489333, label %whileBody493, label %common.ret

whileBody493:                                     ; preds = %else486, %whileCond492.backedge
  %t485.0334 = phi i32 [ %t485.0.be, %whileCond492.backedge ], [ 0, %else486 ]
  %t3.i271 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i273.not = icmp slt i32 %t485.0334, %t3.i271
  br i1 %t10.i273.not, label %end133.i275, label %if137.i280

if137.i280:                                       ; preds = %whileBody493
  %t12.i281 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit282

end133.i275:                                      ; preds = %whileBody493
  %15 = zext nneg i32 %t485.0334 to i64
  %t15.i276 = getelementptr i8, ptr %common.ret.op.i215, i64 %15
  %t16.i277 = load i8, ptr %t15.i276, align 1
  %t17.i278 = tail call ptr @_zen_char_to_string(i8 %t16.i277)
  br label %_zen_std_charAt.exit282

_zen_std_charAt.exit282:                          ; preds = %if137.i280, %end133.i275
  %common.ret.op.i279 = phi ptr [ %t12.i281, %if137.i280 ], [ %t17.i278, %end133.i275 ]
  %t496 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t497 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i279, ptr noundef nonnull dereferenceable(1) %t496)
  %t498 = icmp eq i32 %t497, 0
  br i1 %t498, label %whileCond492.backedge, label %end495

whileCond492.backedge:                            ; preds = %end495, %_zen_std_charAt.exit282
  %t485.0.be = add nuw nsw i32 %t485.0334, 1
  %t488 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t489 = icmp slt i32 %t485.0.be, %t488
  br i1 %t489, label %whileBody493, label %common.ret

end495:                                           ; preds = %_zen_std_charAt.exit282
  %t504 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i279, ptr noundef nonnull dereferenceable(1) %common.ret.op.i234)
  %t505 = icmp eq i32 %t504, 0
  br i1 %t505, label %end499, label %whileCond492.backedge

end499:                                           ; preds = %end495, %rhs488
  %t516 = add i32 %t427.0.lcssa, 1
  br label %whileCond352.backedge

end472:                                           ; preds = %end400
  %t520 = tail call i32 @strlen(ptr %t0)
  %t521.not = icmp slt i32 %t39.0339, %t520
  br i1 %t521.not, label %end501, label %common.ret

end501:                                           ; preds = %end472
  %t3.i283 = tail call i32 @strlen(ptr %t0)
  %t7.i284 = icmp slt i32 %t39.0339, 0
  %t10.i285 = icmp sge i32 %t39.0339, %t3.i283
  %t5.i286 = select i1 %t7.i284, i1 true, i1 %t10.i285
  br i1 %t5.i286, label %if137.i292, label %end133.i287

if137.i292:                                       ; preds = %end501
  %t12.i293 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit294

end133.i287:                                      ; preds = %end501
  %16 = zext nneg i32 %t39.0339 to i64
  %t15.i288 = getelementptr i8, ptr %t0, i64 %16
  %t16.i289 = load i8, ptr %t15.i288, align 1
  %t17.i290 = tail call ptr @_zen_char_to_string(i8 %t16.i289)
  br label %_zen_std_charAt.exit294

_zen_std_charAt.exit294:                          ; preds = %if137.i292, %end133.i287
  %common.ret.op.i291 = phi ptr [ %t12.i293, %if137.i292 ], [ %t17.i290, %end133.i287 ]
  %t526 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i291, ptr noundef nonnull dereferenceable(1) %common.ret.op.i76)
  %t527.not = icmp eq i32 %t526, 0
  br i1 %t527.not, label %end503, label %common.ret

end503:                                           ; preds = %_zen_std_charAt.exit294
  %t532 = add i32 %t40.0337, 1
  br label %whileCond352.backedge

whileEnd354:                                      ; preds = %whileCond352.backedge, %whileCond352.preheader
  %t39.0.lcssa = phi i32 [ 0, %whileCond352.preheader ], [ %t39.0.be, %whileCond352.backedge ]
  %t536 = tail call i32 @strlen(ptr %t0)
  %t537 = icmp eq i32 %t39.0.lcssa, %t536
  br label %common.ret
}

define i32 @_zen_std__json_skipWS(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond505

whileCond505:                                     ; preds = %whileBody506, %entry
  %i.addr.0 = phi i32 [ %t1, %entry ], [ %t12, %whileBody506 ]
  %t5 = tail call i32 @strlen(ptr %t0)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t7.i = icmp slt i32 %i.addr.0, 0
  %t10.i = icmp sge i32 %i.addr.0, %t3.i
  %t5.i = select i1 %t7.i, i1 true, i1 %t10.i
  br i1 %t5.i, label %if137.i, label %end133.i

if137.i:                                          ; preds = %whileCond505
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %whileCond505
  %0 = zext nneg i32 %i.addr.0 to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i, %if137.i ], [ %t17.i, %end133.i ]
  %t6 = icmp slt i32 %i.addr.0, %t5
  br i1 %t6, label %rhs508, label %whileEnd507

rhs508:                                           ; preds = %_zen_std_charAt.exit
  %t10 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i)
  br i1 %t10, label %whileBody506, label %whileEnd507

whileBody506:                                     ; preds = %rhs508
  %t12 = add nsw i32 %i.addr.0, 1
  br label %whileCond505

whileEnd507:                                      ; preds = %_zen_std_charAt.exit, %rhs508
  ret i32 %i.addr.0
}

define i1 @_zen_std_isWhitespace(ptr readonly captures(none) %t0) local_unnamed_addr {
entry:
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t11 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t16 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t21 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_29)
  %t7 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t6)
  %t8 = icmp eq i32 %t7, 0
  br i1 %t8, label %end513, label %rhs517

rhs517:                                           ; preds = %entry
  %t12 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t11)
  %t13 = icmp eq i32 %t12, 0
  br i1 %t13, label %end513, label %rhs514

rhs514:                                           ; preds = %rhs517
  %t17 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t16)
  %t18 = icmp eq i32 %t17, 0
  br i1 %t18, label %end513, label %rhs511

rhs511:                                           ; preds = %rhs514
  %t22 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t21)
  %t23 = icmp eq i32 %t22, 0
  br label %end513

end513:                                           ; preds = %rhs514, %rhs517, %entry, %rhs511
  %t1 = phi i1 [ %t23, %rhs511 ], [ true, %entry ], [ true, %rhs517 ], [ true, %rhs514 ]
  ret i1 %t1
}

define ptr @_zen_std__json_extractValue(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond505.i

whileCond505.i:                                   ; preds = %whileBody506.i, %entry
  %i.addr.0.i = phi i32 [ %t1, %entry ], [ %t12.i, %whileBody506.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i, 0
  %t10.i.i = icmp sge i32 %i.addr.0.i, %t3.i.i
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i
  br i1 %t5.i.i, label %if137.i.i, label %end133.i.i

if137.i.i:                                        ; preds = %whileCond505.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end133.i.i:                                       ; preds = %whileCond505.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end133.i.i, %if137.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if137.i.i ], [ %t17.i.i, %end133.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs508.i, label %_zen_std__json_skipWS.exit

rhs508.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody506.i, label %_zen_std__json_skipWS.exit

whileBody506.i:                                   ; preds = %rhs508.i
  %t12.i = add nsw i32 %i.addr.0.i, 1
  br label %whileCond505.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs508.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i33 = icmp sge i32 %i.addr.0.i, %t3.i
  %t5.i34 = select i1 %t7.i.i, i1 true, i1 %t10.i33
  br i1 %t5.i34, label %if137.i, label %end133.i

if137.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i35, %if137.i ], [ %t17.i, %end133.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11 = icmp eq i32 %t10, 0
  br i1 %t11, label %if521, label %end520

if521:                                            ; preds = %_zen_std_charAt.exit
  %t14 = add i32 %i.addr.0.i, 1
  %t17233 = tail call i32 @strlen(ptr %t0)
  %t18234 = icmp slt i32 %t14, %t17233
  br i1 %t18234, label %whileBody523, label %whileEnd524

whileBody523:                                     ; preds = %if521, %end525
  %t12.0235 = phi i32 [ %t27, %end525 ], [ %t14, %if521 ]
  %t23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i36 = tail call i32 @strlen(ptr %t0)
  %t7.i37 = icmp slt i32 %t12.0235, 0
  %t10.i38 = icmp sge i32 %t12.0235, %t3.i36
  %t5.i39 = select i1 %t7.i37, i1 true, i1 %t10.i38
  br i1 %t5.i39, label %if137.i45, label %end133.i40

if137.i45:                                        ; preds = %whileBody523
  %t12.i46 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit47

end133.i40:                                       ; preds = %whileBody523
  %2 = zext nneg i32 %t12.0235 to i64
  %t15.i41 = getelementptr i8, ptr %t0, i64 %2
  %t16.i42 = load i8, ptr %t15.i41, align 1
  %t17.i43 = tail call ptr @_zen_char_to_string(i8 %t16.i42)
  br label %_zen_std_charAt.exit47

_zen_std_charAt.exit47:                           ; preds = %if137.i45, %end133.i40
  %common.ret.op.i44 = phi ptr [ %t12.i46, %if137.i45 ], [ %t17.i43, %end133.i40 ]
  %t24 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i44, ptr noundef nonnull dereferenceable(1) %t23)
  %t25 = icmp eq i32 %t24, 0
  br i1 %t25, label %whileEnd524, label %end525

end525:                                           ; preds = %_zen_std_charAt.exit47
  %t27 = add nsw i32 %t12.0235, 1
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %t27, %t17
  br i1 %t18, label %whileBody523, label %whileEnd524

common.ret:                                       ; preds = %whileBody131.i202, %whileBody131.i148, %whileBody131.i94, %whileBody131.i, %whileEnd551, %whileEnd542, %whileEnd531, %whileEnd524
  %common.ret.op = phi ptr [ %t18.i, %whileEnd524 ], [ %t18.i90, %whileEnd531 ], [ %t18.i144, %whileEnd542 ], [ %t18.i198, %whileEnd551 ], [ %t34.i, %whileBody131.i ], [ %t34.i100, %whileBody131.i94 ], [ %t34.i154, %whileBody131.i148 ], [ %t34.i208, %whileBody131.i202 ]
  ret ptr %common.ret.op

whileEnd524:                                      ; preds = %end525, %_zen_std_charAt.exit47, %if521
  %t12.0.lcssa = phi i32 [ %t14, %if521 ], [ %t12.0235, %_zen_std_charAt.exit47 ], [ %t27, %end525 ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t14, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t12.0.lcssa, i32 %t4.i)
  %t16.i48 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i48, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody131.i, label %common.ret

whileBody131.i:                                   ; preds = %whileEnd524, %whileBody131.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody131.i ], [ %t18.i, %whileEnd524 ]
  %t22.09.i = phi i32 [ %t37.i, %whileBody131.i ], [ %spec.store.select.i, %whileEnd524 ]
  %3 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t0, i64 %3
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %t37.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t37.i, %spec.select.i
  br i1 %t26.i, label %whileBody131.i, label %common.ret

end520:                                           ; preds = %_zen_std_charAt.exit
  %t38 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i50 = tail call i32 @strlen(ptr %t0)
  %t10.i52 = icmp sge i32 %i.addr.0.i, %t3.i50
  %t5.i53 = select i1 %t7.i.i, i1 true, i1 %t10.i52
  br i1 %t5.i53, label %if137.i59, label %end133.i54

if137.i59:                                        ; preds = %end520
  %t12.i60 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit61

end133.i54:                                       ; preds = %end520
  %4 = zext nneg i32 %i.addr.0.i to i64
  %t15.i55 = getelementptr i8, ptr %t0, i64 %4
  %t16.i56 = load i8, ptr %t15.i55, align 1
  %t17.i57 = tail call ptr @_zen_char_to_string(i8 %t16.i56)
  br label %_zen_std_charAt.exit61

_zen_std_charAt.exit61:                           ; preds = %if137.i59, %end133.i54
  %common.ret.op.i58 = phi ptr [ %t12.i60, %if137.i59 ], [ %t17.i57, %end133.i54 ]
  %t39 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i58, ptr noundef nonnull dereferenceable(1) %t38)
  %t40 = icmp eq i32 %t39, 0
  br i1 %t40, label %whileCond529.preheader, label %end527

whileCond529.preheader:                           ; preds = %_zen_std_charAt.exit61
  %t46227 = tail call i32 @strlen(ptr %t0)
  %t47228 = icmp slt i32 %i.addr.0.i, %t46227
  br i1 %t47228, label %whileBody530, label %whileEnd531

whileBody530:                                     ; preds = %whileCond529.preheader, %end536
  %t43.0230 = phi i32 [ %t43.2, %end536 ], [ 0, %whileCond529.preheader ]
  %t41.0229 = phi i32 [ %t71, %end536 ], [ %i.addr.0.i, %whileCond529.preheader ]
  %t52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i62 = tail call i32 @strlen(ptr %t0)
  %t7.i63 = icmp slt i32 %t41.0229, 0
  %t10.i64 = icmp sge i32 %t41.0229, %t3.i62
  %t5.i65 = select i1 %t7.i63, i1 true, i1 %t10.i64
  br i1 %t5.i65, label %if137.i71, label %end133.i66

if137.i71:                                        ; preds = %whileBody530
  %t12.i72 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit73

end133.i66:                                       ; preds = %whileBody530
  %5 = zext nneg i32 %t41.0229 to i64
  %t15.i67 = getelementptr i8, ptr %t0, i64 %5
  %t16.i68 = load i8, ptr %t15.i67, align 1
  %t17.i69 = tail call ptr @_zen_char_to_string(i8 %t16.i68)
  br label %_zen_std_charAt.exit73

_zen_std_charAt.exit73:                           ; preds = %if137.i71, %end133.i66
  %common.ret.op.i70 = phi ptr [ %t12.i72, %if137.i71 ], [ %t17.i69, %end133.i66 ]
  %t53 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i70, ptr noundef nonnull dereferenceable(1) %t52)
  %t54 = icmp eq i32 %t53, 0
  %t56 = zext i1 %t54 to i32
  %spec.select = add i32 %t43.0230, %t56
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i74 = tail call i32 @strlen(ptr %t0)
  %t10.i76 = icmp sge i32 %t41.0229, %t3.i74
  %t5.i77 = select i1 %t7.i63, i1 true, i1 %t10.i76
  br i1 %t5.i77, label %if137.i83, label %end133.i78

if137.i83:                                        ; preds = %_zen_std_charAt.exit73
  %t12.i84 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit85

end133.i78:                                       ; preds = %_zen_std_charAt.exit73
  %6 = zext nneg i32 %t41.0229 to i64
  %t15.i79 = getelementptr i8, ptr %t0, i64 %6
  %t16.i80 = load i8, ptr %t15.i79, align 1
  %t17.i81 = tail call ptr @_zen_char_to_string(i8 %t16.i80)
  br label %_zen_std_charAt.exit85

_zen_std_charAt.exit85:                           ; preds = %if137.i83, %end133.i78
  %common.ret.op.i82 = phi ptr [ %t12.i84, %if137.i83 ], [ %t17.i81, %end133.i78 ]
  %t63 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i82, ptr noundef nonnull dereferenceable(1) %t62)
  %t64 = icmp eq i32 %t63, 0
  %t66 = sext i1 %t64 to i32
  %t43.2 = add i32 %spec.select, %t66
  %t69 = icmp eq i32 %t43.2, 0
  br i1 %t69, label %whileEnd531, label %end536

end536:                                           ; preds = %_zen_std_charAt.exit85
  %t71 = add nsw i32 %t41.0229, 1
  %t46 = tail call i32 @strlen(ptr %t0)
  %t47 = icmp slt i32 %t71, %t46
  br i1 %t47, label %whileBody530, label %whileEnd531

whileEnd531:                                      ; preds = %end536, %_zen_std_charAt.exit85, %whileCond529.preheader
  %t41.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond529.preheader ], [ %t41.0229, %_zen_std_charAt.exit85 ], [ %t71, %end536 ]
  %t76 = add i32 %t41.0.lcssa, 1
  %t4.i86 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i87 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i88 = tail call i32 @llvm.smin.i32(i32 %t76, i32 %t4.i86)
  %t16.i89 = icmp sle i32 %spec.store.select.i87, %spec.select.i88
  %t18.i90 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i91 = icmp samesign ult i32 %spec.store.select.i87, %spec.select.i88
  %or.cond.i92 = select i1 %t16.i89, i1 %t268.i91, i1 false
  br i1 %or.cond.i92, label %whileBody131.i94, label %common.ret

whileBody131.i94:                                 ; preds = %whileEnd531, %whileBody131.i94
  %t19.010.i95 = phi ptr [ %t34.i100, %whileBody131.i94 ], [ %t18.i90, %whileEnd531 ]
  %t22.09.i96 = phi i32 [ %t37.i101, %whileBody131.i94 ], [ %spec.store.select.i87, %whileEnd531 ]
  %7 = zext nneg i32 %t22.09.i96 to i64
  %t30.i97 = getelementptr i8, ptr %t0, i64 %7
  %t31.i98 = load i8, ptr %t30.i97, align 1
  %t32.i99 = tail call ptr @_zen_char_to_string(i8 %t31.i98)
  %t34.i100 = tail call ptr @_str_concat(ptr %t19.010.i95, ptr %t32.i99)
  %t37.i101 = add nuw nsw i32 %t22.09.i96, 1
  %t26.i102 = icmp slt i32 %t37.i101, %spec.select.i88
  br i1 %t26.i102, label %whileBody131.i94, label %common.ret

end527:                                           ; preds = %_zen_std_charAt.exit61
  %t82 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i104 = tail call i32 @strlen(ptr %t0)
  %t10.i106 = icmp sge i32 %i.addr.0.i, %t3.i104
  %t5.i107 = select i1 %t7.i.i, i1 true, i1 %t10.i106
  br i1 %t5.i107, label %if137.i113, label %end133.i108

if137.i113:                                       ; preds = %end527
  %t12.i114 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit115

end133.i108:                                      ; preds = %end527
  %8 = zext nneg i32 %i.addr.0.i to i64
  %t15.i109 = getelementptr i8, ptr %t0, i64 %8
  %t16.i110 = load i8, ptr %t15.i109, align 1
  %t17.i111 = tail call ptr @_zen_char_to_string(i8 %t16.i110)
  br label %_zen_std_charAt.exit115

_zen_std_charAt.exit115:                          ; preds = %if137.i113, %end133.i108
  %common.ret.op.i112 = phi ptr [ %t12.i114, %if137.i113 ], [ %t17.i111, %end133.i108 ]
  %t83 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i112, ptr noundef nonnull dereferenceable(1) %t82)
  %t84 = icmp eq i32 %t83, 0
  %t90221 = tail call i32 @strlen(ptr %t0)
  %t91222 = icmp slt i32 %i.addr.0.i, %t90221
  br i1 %t84, label %whileCond540.preheader, label %whileCond549.preheader

whileCond549.preheader:                           ; preds = %_zen_std_charAt.exit115
  br i1 %t91222, label %whileBody550, label %whileEnd551

whileCond540.preheader:                           ; preds = %_zen_std_charAt.exit115
  br i1 %t91222, label %whileBody541, label %whileEnd542

whileBody541:                                     ; preds = %whileCond540.preheader, %end547
  %t87.0224 = phi i32 [ %t87.2, %end547 ], [ 0, %whileCond540.preheader ]
  %t85.0223 = phi i32 [ %t115, %end547 ], [ %i.addr.0.i, %whileCond540.preheader ]
  %t96 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i116 = tail call i32 @strlen(ptr %t0)
  %t7.i117 = icmp slt i32 %t85.0223, 0
  %t10.i118 = icmp sge i32 %t85.0223, %t3.i116
  %t5.i119 = select i1 %t7.i117, i1 true, i1 %t10.i118
  br i1 %t5.i119, label %if137.i125, label %end133.i120

if137.i125:                                       ; preds = %whileBody541
  %t12.i126 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit127

end133.i120:                                      ; preds = %whileBody541
  %9 = zext nneg i32 %t85.0223 to i64
  %t15.i121 = getelementptr i8, ptr %t0, i64 %9
  %t16.i122 = load i8, ptr %t15.i121, align 1
  %t17.i123 = tail call ptr @_zen_char_to_string(i8 %t16.i122)
  br label %_zen_std_charAt.exit127

_zen_std_charAt.exit127:                          ; preds = %if137.i125, %end133.i120
  %common.ret.op.i124 = phi ptr [ %t12.i126, %if137.i125 ], [ %t17.i123, %end133.i120 ]
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i124, ptr noundef nonnull dereferenceable(1) %t96)
  %t98 = icmp eq i32 %t97, 0
  %t100 = zext i1 %t98 to i32
  %spec.select32 = add i32 %t87.0224, %t100
  %t106 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i128 = tail call i32 @strlen(ptr %t0)
  %t10.i130 = icmp sge i32 %t85.0223, %t3.i128
  %t5.i131 = select i1 %t7.i117, i1 true, i1 %t10.i130
  br i1 %t5.i131, label %if137.i137, label %end133.i132

if137.i137:                                       ; preds = %_zen_std_charAt.exit127
  %t12.i138 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit139

end133.i132:                                      ; preds = %_zen_std_charAt.exit127
  %10 = zext nneg i32 %t85.0223 to i64
  %t15.i133 = getelementptr i8, ptr %t0, i64 %10
  %t16.i134 = load i8, ptr %t15.i133, align 1
  %t17.i135 = tail call ptr @_zen_char_to_string(i8 %t16.i134)
  br label %_zen_std_charAt.exit139

_zen_std_charAt.exit139:                          ; preds = %if137.i137, %end133.i132
  %common.ret.op.i136 = phi ptr [ %t12.i138, %if137.i137 ], [ %t17.i135, %end133.i132 ]
  %t107 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i136, ptr noundef nonnull dereferenceable(1) %t106)
  %t108 = icmp eq i32 %t107, 0
  %t110 = sext i1 %t108 to i32
  %t87.2 = add i32 %spec.select32, %t110
  %t113 = icmp eq i32 %t87.2, 0
  br i1 %t113, label %whileEnd542, label %end547

end547:                                           ; preds = %_zen_std_charAt.exit139
  %t115 = add nsw i32 %t85.0223, 1
  %t90 = tail call i32 @strlen(ptr %t0)
  %t91 = icmp slt i32 %t115, %t90
  br i1 %t91, label %whileBody541, label %whileEnd542

whileEnd542:                                      ; preds = %end547, %_zen_std_charAt.exit139, %whileCond540.preheader
  %t85.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond540.preheader ], [ %t85.0223, %_zen_std_charAt.exit139 ], [ %t115, %end547 ]
  %t120 = add i32 %t85.0.lcssa, 1
  %t4.i140 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i141 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i142 = tail call i32 @llvm.smin.i32(i32 %t120, i32 %t4.i140)
  %t16.i143 = icmp sle i32 %spec.store.select.i141, %spec.select.i142
  %t18.i144 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i145 = icmp samesign ult i32 %spec.store.select.i141, %spec.select.i142
  %or.cond.i146 = select i1 %t16.i143, i1 %t268.i145, i1 false
  br i1 %or.cond.i146, label %whileBody131.i148, label %common.ret

whileBody131.i148:                                ; preds = %whileEnd542, %whileBody131.i148
  %t19.010.i149 = phi ptr [ %t34.i154, %whileBody131.i148 ], [ %t18.i144, %whileEnd542 ]
  %t22.09.i150 = phi i32 [ %t37.i155, %whileBody131.i148 ], [ %spec.store.select.i141, %whileEnd542 ]
  %11 = zext nneg i32 %t22.09.i150 to i64
  %t30.i151 = getelementptr i8, ptr %t0, i64 %11
  %t31.i152 = load i8, ptr %t30.i151, align 1
  %t32.i153 = tail call ptr @_zen_char_to_string(i8 %t31.i152)
  %t34.i154 = tail call ptr @_str_concat(ptr %t19.010.i149, ptr %t32.i153)
  %t37.i155 = add nuw nsw i32 %t22.09.i150, 1
  %t26.i156 = icmp slt i32 %t37.i155, %spec.select.i142
  br i1 %t26.i156, label %whileBody131.i148, label %common.ret

whileBody550:                                     ; preds = %whileCond549.preheader, %end552
  %t122.0217 = phi i32 [ %t152, %end552 ], [ %i.addr.0.i, %whileCond549.preheader ]
  %t134 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t141 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t148 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i158 = tail call i32 @strlen(ptr %t0)
  %t7.i159 = icmp slt i32 %t122.0217, 0
  %t10.i160 = icmp sge i32 %t122.0217, %t3.i158
  %t5.i161 = select i1 %t7.i159, i1 true, i1 %t10.i160
  br i1 %t5.i161, label %if137.i167, label %end133.i162

if137.i167:                                       ; preds = %whileBody550
  %t12.i168 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit169

end133.i162:                                      ; preds = %whileBody550
  %12 = zext nneg i32 %t122.0217 to i64
  %t15.i163 = getelementptr i8, ptr %t0, i64 %12
  %t16.i164 = load i8, ptr %t15.i163, align 1
  %t17.i165 = tail call ptr @_zen_char_to_string(i8 %t16.i164)
  br label %_zen_std_charAt.exit169

_zen_std_charAt.exit169:                          ; preds = %if137.i167, %end133.i162
  %common.ret.op.i166 = phi ptr [ %t12.i168, %if137.i167 ], [ %t17.i165, %end133.i162 ]
  %t135 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i166, ptr noundef nonnull dereferenceable(1) %t134)
  %t136 = icmp eq i32 %t135, 0
  br i1 %t136, label %whileEnd551, label %rhs556

rhs556:                                           ; preds = %_zen_std_charAt.exit169
  %t3.i170 = tail call i32 @strlen(ptr %t0)
  %t10.i172 = icmp sge i32 %t122.0217, %t3.i170
  %t5.i173 = select i1 %t7.i159, i1 true, i1 %t10.i172
  br i1 %t5.i173, label %if137.i179, label %end133.i174

if137.i179:                                       ; preds = %rhs556
  %t12.i180 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit181

end133.i174:                                      ; preds = %rhs556
  %13 = zext nneg i32 %t122.0217 to i64
  %t15.i175 = getelementptr i8, ptr %t0, i64 %13
  %t16.i176 = load i8, ptr %t15.i175, align 1
  %t17.i177 = tail call ptr @_zen_char_to_string(i8 %t16.i176)
  br label %_zen_std_charAt.exit181

_zen_std_charAt.exit181:                          ; preds = %if137.i179, %end133.i174
  %common.ret.op.i178 = phi ptr [ %t12.i180, %if137.i179 ], [ %t17.i177, %end133.i174 ]
  %t142 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i178, ptr noundef nonnull dereferenceable(1) %t141)
  %t143 = icmp eq i32 %t142, 0
  br i1 %t143, label %whileEnd551, label %rhs553

rhs553:                                           ; preds = %_zen_std_charAt.exit181
  %t3.i182 = tail call i32 @strlen(ptr %t0)
  %t10.i184 = icmp sge i32 %t122.0217, %t3.i182
  %t5.i185 = select i1 %t7.i159, i1 true, i1 %t10.i184
  br i1 %t5.i185, label %if137.i191, label %end133.i186

if137.i191:                                       ; preds = %rhs553
  %t12.i192 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit193

end133.i186:                                      ; preds = %rhs553
  %14 = zext nneg i32 %t122.0217 to i64
  %t15.i187 = getelementptr i8, ptr %t0, i64 %14
  %t16.i188 = load i8, ptr %t15.i187, align 1
  %t17.i189 = tail call ptr @_zen_char_to_string(i8 %t16.i188)
  br label %_zen_std_charAt.exit193

_zen_std_charAt.exit193:                          ; preds = %if137.i191, %end133.i186
  %common.ret.op.i190 = phi ptr [ %t12.i192, %if137.i191 ], [ %t17.i189, %end133.i186 ]
  %t149 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i190, ptr noundef nonnull dereferenceable(1) %t148)
  %t150 = icmp eq i32 %t149, 0
  br i1 %t150, label %whileEnd551, label %end552

end552:                                           ; preds = %_zen_std_charAt.exit193
  %t152 = add nsw i32 %t122.0217, 1
  %t126 = tail call i32 @strlen(ptr %t0)
  %t127 = icmp slt i32 %t152, %t126
  br i1 %t127, label %whileBody550, label %whileEnd551

whileEnd551:                                      ; preds = %end552, %_zen_std_charAt.exit193, %_zen_std_charAt.exit181, %_zen_std_charAt.exit169, %whileCond549.preheader
  %t122.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond549.preheader ], [ %t122.0217, %_zen_std_charAt.exit169 ], [ %t122.0217, %_zen_std_charAt.exit181 ], [ %t122.0217, %_zen_std_charAt.exit193 ], [ %t152, %end552 ]
  %t4.i194 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i195 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i196 = tail call i32 @llvm.smin.i32(i32 %t122.0.lcssa, i32 %t4.i194)
  %t16.i197 = icmp sle i32 %spec.store.select.i195, %spec.select.i196
  %t18.i198 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i199 = icmp samesign ult i32 %spec.store.select.i195, %spec.select.i196
  %or.cond.i200 = select i1 %t16.i197, i1 %t268.i199, i1 false
  br i1 %or.cond.i200, label %whileBody131.i202, label %common.ret

whileBody131.i202:                                ; preds = %whileEnd551, %whileBody131.i202
  %t19.010.i203 = phi ptr [ %t34.i208, %whileBody131.i202 ], [ %t18.i198, %whileEnd551 ]
  %t22.09.i204 = phi i32 [ %t37.i209, %whileBody131.i202 ], [ %spec.store.select.i195, %whileEnd551 ]
  %15 = zext nneg i32 %t22.09.i204 to i64
  %t30.i205 = getelementptr i8, ptr %t0, i64 %15
  %t31.i206 = load i8, ptr %t30.i205, align 1
  %t32.i207 = tail call ptr @_zen_char_to_string(i8 %t31.i206)
  %t34.i208 = tail call ptr @_str_concat(ptr %t19.010.i203, ptr %t32.i207)
  %t37.i209 = add nuw nsw i32 %t22.09.i204, 1
  %t26.i210 = icmp slt i32 %t37.i209, %spec.select.i196
  br i1 %t26.i210, label %whileBody131.i202, label %common.ret
}

define i32 @_zen_std__json_skipElement(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond505.i

whileCond505.i:                                   ; preds = %whileBody506.i, %entry
  %i.addr.0.i = phi i32 [ %t1, %entry ], [ %t12.i, %whileBody506.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i, 0
  %t10.i.i = icmp sge i32 %i.addr.0.i, %t3.i.i
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i
  br i1 %t5.i.i, label %if137.i.i, label %end133.i.i

if137.i.i:                                        ; preds = %whileCond505.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end133.i.i:                                       ; preds = %whileCond505.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end133.i.i, %if137.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if137.i.i ], [ %t17.i.i, %end133.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs508.i, label %_zen_std__json_skipWS.exit

rhs508.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody506.i, label %_zen_std__json_skipWS.exit

whileBody506.i:                                   ; preds = %rhs508.i
  %t12.i = add nsw i32 %i.addr.0.i, 1
  br label %whileCond505.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs508.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i30 = icmp sge i32 %i.addr.0.i, %t3.i
  %t5.i31 = select i1 %t7.i.i, i1 true, i1 %t10.i30
  br i1 %t5.i31, label %if137.i, label %end133.i

if137.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i32, %if137.i ], [ %t17.i, %end133.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11 = icmp eq i32 %t10, 0
  br i1 %t11, label %whileCond562, label %end560

whileCond562:                                     ; preds = %_zen_std_charAt.exit, %_zen_std_charAt.exit44
  %i.addr.0.in = phi i32 [ %i.addr.0, %_zen_std_charAt.exit44 ], [ %i.addr.0.i, %_zen_std_charAt.exit ]
  %i.addr.0 = add i32 %i.addr.0.in, 1
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %i.addr.0, %t17
  br i1 %t18, label %whileBody563, label %whileEnd564

whileBody563:                                     ; preds = %whileCond562
  %t23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i33 = tail call i32 @strlen(ptr %t0)
  %t7.i34 = icmp slt i32 %i.addr.0, 0
  %t10.i35 = icmp sge i32 %i.addr.0, %t3.i33
  %t5.i36 = select i1 %t7.i34, i1 true, i1 %t10.i35
  br i1 %t5.i36, label %if137.i42, label %end133.i37

if137.i42:                                        ; preds = %whileBody563
  %t12.i43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit44

end133.i37:                                       ; preds = %whileBody563
  %2 = zext nneg i32 %i.addr.0 to i64
  %t15.i38 = getelementptr i8, ptr %t0, i64 %2
  %t16.i39 = load i8, ptr %t15.i38, align 1
  %t17.i40 = tail call ptr @_zen_char_to_string(i8 %t16.i39)
  br label %_zen_std_charAt.exit44

_zen_std_charAt.exit44:                           ; preds = %if137.i42, %end133.i37
  %common.ret.op.i41 = phi ptr [ %t12.i43, %if137.i42 ], [ %t17.i40, %end133.i37 ]
  %t24 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i41, ptr noundef nonnull dereferenceable(1) %t23)
  %t25 = icmp eq i32 %t24, 0
  br i1 %t25, label %whileEnd564, label %whileCond562

common.ret:                                       ; preds = %_zen_std_charAt.exit128, %_zen_std_charAt.exit140, %_zen_std_charAt.exit152, %end592, %whileCond589.preheader, %whileEnd582, %whileEnd571, %whileEnd564
  %common.ret.op = phi i32 [ %t30, %whileEnd564 ], [ %t69, %whileEnd571 ], [ %t108, %whileEnd582 ], [ %i.addr.0.i, %whileCond589.preheader ], [ %i.addr.3155, %_zen_std_charAt.exit128 ], [ %i.addr.3155, %_zen_std_charAt.exit140 ], [ %i.addr.3155, %_zen_std_charAt.exit152 ], [ %t137, %end592 ]
  ret i32 %common.ret.op

whileEnd564:                                      ; preds = %_zen_std_charAt.exit44, %whileCond562
  %t30 = add i32 %i.addr.0.in, 2
  br label %common.ret

end560:                                           ; preds = %_zen_std_charAt.exit
  %t35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i45 = tail call i32 @strlen(ptr %t0)
  %t10.i47 = icmp sge i32 %i.addr.0.i, %t3.i45
  %t5.i48 = select i1 %t7.i.i, i1 true, i1 %t10.i47
  br i1 %t5.i48, label %if137.i54, label %end133.i49

if137.i54:                                        ; preds = %end560
  %t12.i55 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit56

end133.i49:                                       ; preds = %end560
  %3 = zext nneg i32 %i.addr.0.i to i64
  %t15.i50 = getelementptr i8, ptr %t0, i64 %3
  %t16.i51 = load i8, ptr %t15.i50, align 1
  %t17.i52 = tail call ptr @_zen_char_to_string(i8 %t16.i51)
  br label %_zen_std_charAt.exit56

_zen_std_charAt.exit56:                           ; preds = %if137.i54, %end133.i49
  %common.ret.op.i53 = phi ptr [ %t12.i55, %if137.i54 ], [ %t17.i52, %end133.i49 ]
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i53, ptr noundef nonnull dereferenceable(1) %t35)
  %t37 = icmp eq i32 %t36, 0
  br i1 %t37, label %whileCond569.preheader, label %end567

whileCond569.preheader:                           ; preds = %_zen_std_charAt.exit56
  %t41165 = tail call i32 @strlen(ptr %t0)
  %t42166 = icmp slt i32 %i.addr.0.i, %t41165
  br i1 %t42166, label %whileBody570, label %whileEnd571

whileBody570:                                     ; preds = %whileCond569.preheader, %end576
  %i.addr.1168 = phi i32 [ %t66, %end576 ], [ %i.addr.0.i, %whileCond569.preheader ]
  %t38.0167 = phi i32 [ %t38.2, %end576 ], [ 0, %whileCond569.preheader ]
  %t47 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i57 = tail call i32 @strlen(ptr %t0)
  %t7.i58 = icmp slt i32 %i.addr.1168, 0
  %t10.i59 = icmp sge i32 %i.addr.1168, %t3.i57
  %t5.i60 = select i1 %t7.i58, i1 true, i1 %t10.i59
  br i1 %t5.i60, label %if137.i66, label %end133.i61

if137.i66:                                        ; preds = %whileBody570
  %t12.i67 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit68

end133.i61:                                       ; preds = %whileBody570
  %4 = zext nneg i32 %i.addr.1168 to i64
  %t15.i62 = getelementptr i8, ptr %t0, i64 %4
  %t16.i63 = load i8, ptr %t15.i62, align 1
  %t17.i64 = tail call ptr @_zen_char_to_string(i8 %t16.i63)
  br label %_zen_std_charAt.exit68

_zen_std_charAt.exit68:                           ; preds = %if137.i66, %end133.i61
  %common.ret.op.i65 = phi ptr [ %t12.i67, %if137.i66 ], [ %t17.i64, %end133.i61 ]
  %t48 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i65, ptr noundef nonnull dereferenceable(1) %t47)
  %t49 = icmp eq i32 %t48, 0
  %t51 = zext i1 %t49 to i32
  %spec.select = add i32 %t38.0167, %t51
  %t57 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i69 = tail call i32 @strlen(ptr %t0)
  %t10.i71 = icmp sge i32 %i.addr.1168, %t3.i69
  %t5.i72 = select i1 %t7.i58, i1 true, i1 %t10.i71
  br i1 %t5.i72, label %if137.i78, label %end133.i73

if137.i78:                                        ; preds = %_zen_std_charAt.exit68
  %t12.i79 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit80

end133.i73:                                       ; preds = %_zen_std_charAt.exit68
  %5 = zext nneg i32 %i.addr.1168 to i64
  %t15.i74 = getelementptr i8, ptr %t0, i64 %5
  %t16.i75 = load i8, ptr %t15.i74, align 1
  %t17.i76 = tail call ptr @_zen_char_to_string(i8 %t16.i75)
  br label %_zen_std_charAt.exit80

_zen_std_charAt.exit80:                           ; preds = %if137.i78, %end133.i73
  %common.ret.op.i77 = phi ptr [ %t12.i79, %if137.i78 ], [ %t17.i76, %end133.i73 ]
  %t58 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i77, ptr noundef nonnull dereferenceable(1) %t57)
  %t59 = icmp eq i32 %t58, 0
  %t61 = sext i1 %t59 to i32
  %t38.2 = add i32 %spec.select, %t61
  %t64 = icmp eq i32 %t38.2, 0
  br i1 %t64, label %whileEnd571, label %end576

end576:                                           ; preds = %_zen_std_charAt.exit80
  %t66 = add nsw i32 %i.addr.1168, 1
  %t41 = tail call i32 @strlen(ptr %t0)
  %t42 = icmp slt i32 %t66, %t41
  br i1 %t42, label %whileBody570, label %whileEnd571

whileEnd571:                                      ; preds = %end576, %_zen_std_charAt.exit80, %whileCond569.preheader
  %i.addr.1.lcssa = phi i32 [ %i.addr.0.i, %whileCond569.preheader ], [ %i.addr.1168, %_zen_std_charAt.exit80 ], [ %t66, %end576 ]
  %t69 = add i32 %i.addr.1.lcssa, 1
  br label %common.ret

end567:                                           ; preds = %_zen_std_charAt.exit56
  %t74 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i81 = tail call i32 @strlen(ptr %t0)
  %t10.i83 = icmp sge i32 %i.addr.0.i, %t3.i81
  %t5.i84 = select i1 %t7.i.i, i1 true, i1 %t10.i83
  br i1 %t5.i84, label %if137.i90, label %end133.i85

if137.i90:                                        ; preds = %end567
  %t12.i91 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit92

end133.i85:                                       ; preds = %end567
  %6 = zext nneg i32 %i.addr.0.i to i64
  %t15.i86 = getelementptr i8, ptr %t0, i64 %6
  %t16.i87 = load i8, ptr %t15.i86, align 1
  %t17.i88 = tail call ptr @_zen_char_to_string(i8 %t16.i87)
  br label %_zen_std_charAt.exit92

_zen_std_charAt.exit92:                           ; preds = %if137.i90, %end133.i85
  %common.ret.op.i89 = phi ptr [ %t12.i91, %if137.i90 ], [ %t17.i88, %end133.i85 ]
  %t75 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i89, ptr noundef nonnull dereferenceable(1) %t74)
  %t76 = icmp eq i32 %t75, 0
  %t80159 = tail call i32 @strlen(ptr %t0)
  %t81160 = icmp slt i32 %i.addr.0.i, %t80159
  br i1 %t76, label %whileCond580.preheader, label %whileCond589.preheader

whileCond589.preheader:                           ; preds = %_zen_std_charAt.exit92
  br i1 %t81160, label %whileBody590, label %common.ret

whileCond580.preheader:                           ; preds = %_zen_std_charAt.exit92
  br i1 %t81160, label %whileBody581, label %whileEnd582

whileBody581:                                     ; preds = %whileCond580.preheader, %end587
  %i.addr.2162 = phi i32 [ %t105, %end587 ], [ %i.addr.0.i, %whileCond580.preheader ]
  %t77.0161 = phi i32 [ %t77.2, %end587 ], [ 0, %whileCond580.preheader ]
  %t86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i93 = tail call i32 @strlen(ptr %t0)
  %t7.i94 = icmp slt i32 %i.addr.2162, 0
  %t10.i95 = icmp sge i32 %i.addr.2162, %t3.i93
  %t5.i96 = select i1 %t7.i94, i1 true, i1 %t10.i95
  br i1 %t5.i96, label %if137.i102, label %end133.i97

if137.i102:                                       ; preds = %whileBody581
  %t12.i103 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit104

end133.i97:                                       ; preds = %whileBody581
  %7 = zext nneg i32 %i.addr.2162 to i64
  %t15.i98 = getelementptr i8, ptr %t0, i64 %7
  %t16.i99 = load i8, ptr %t15.i98, align 1
  %t17.i100 = tail call ptr @_zen_char_to_string(i8 %t16.i99)
  br label %_zen_std_charAt.exit104

_zen_std_charAt.exit104:                          ; preds = %if137.i102, %end133.i97
  %common.ret.op.i101 = phi ptr [ %t12.i103, %if137.i102 ], [ %t17.i100, %end133.i97 ]
  %t87 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i101, ptr noundef nonnull dereferenceable(1) %t86)
  %t88 = icmp eq i32 %t87, 0
  %t90 = zext i1 %t88 to i32
  %spec.select29 = add i32 %t77.0161, %t90
  %t96 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i105 = tail call i32 @strlen(ptr %t0)
  %t10.i107 = icmp sge i32 %i.addr.2162, %t3.i105
  %t5.i108 = select i1 %t7.i94, i1 true, i1 %t10.i107
  br i1 %t5.i108, label %if137.i114, label %end133.i109

if137.i114:                                       ; preds = %_zen_std_charAt.exit104
  %t12.i115 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit116

end133.i109:                                      ; preds = %_zen_std_charAt.exit104
  %8 = zext nneg i32 %i.addr.2162 to i64
  %t15.i110 = getelementptr i8, ptr %t0, i64 %8
  %t16.i111 = load i8, ptr %t15.i110, align 1
  %t17.i112 = tail call ptr @_zen_char_to_string(i8 %t16.i111)
  br label %_zen_std_charAt.exit116

_zen_std_charAt.exit116:                          ; preds = %if137.i114, %end133.i109
  %common.ret.op.i113 = phi ptr [ %t12.i115, %if137.i114 ], [ %t17.i112, %end133.i109 ]
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(1) %t96)
  %t98 = icmp eq i32 %t97, 0
  %t100 = sext i1 %t98 to i32
  %t77.2 = add i32 %spec.select29, %t100
  %t103 = icmp eq i32 %t77.2, 0
  br i1 %t103, label %whileEnd582, label %end587

end587:                                           ; preds = %_zen_std_charAt.exit116
  %t105 = add nsw i32 %i.addr.2162, 1
  %t80 = tail call i32 @strlen(ptr %t0)
  %t81 = icmp slt i32 %t105, %t80
  br i1 %t81, label %whileBody581, label %whileEnd582

whileEnd582:                                      ; preds = %end587, %_zen_std_charAt.exit116, %whileCond580.preheader
  %i.addr.2.lcssa = phi i32 [ %i.addr.0.i, %whileCond580.preheader ], [ %i.addr.2162, %_zen_std_charAt.exit116 ], [ %t105, %end587 ]
  %t108 = add i32 %i.addr.2.lcssa, 1
  br label %common.ret

whileBody590:                                     ; preds = %whileCond589.preheader, %end592
  %i.addr.3155 = phi i32 [ %t137, %end592 ], [ %i.addr.0.i, %whileCond589.preheader ]
  %t119 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t126 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t133 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i117 = tail call i32 @strlen(ptr %t0)
  %t7.i118 = icmp slt i32 %i.addr.3155, 0
  %t10.i119 = icmp sge i32 %i.addr.3155, %t3.i117
  %t5.i120 = select i1 %t7.i118, i1 true, i1 %t10.i119
  br i1 %t5.i120, label %if137.i126, label %end133.i121

if137.i126:                                       ; preds = %whileBody590
  %t12.i127 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit128

end133.i121:                                      ; preds = %whileBody590
  %9 = zext nneg i32 %i.addr.3155 to i64
  %t15.i122 = getelementptr i8, ptr %t0, i64 %9
  %t16.i123 = load i8, ptr %t15.i122, align 1
  %t17.i124 = tail call ptr @_zen_char_to_string(i8 %t16.i123)
  br label %_zen_std_charAt.exit128

_zen_std_charAt.exit128:                          ; preds = %if137.i126, %end133.i121
  %common.ret.op.i125 = phi ptr [ %t12.i127, %if137.i126 ], [ %t17.i124, %end133.i121 ]
  %t120 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i125, ptr noundef nonnull dereferenceable(1) %t119)
  %t121 = icmp eq i32 %t120, 0
  br i1 %t121, label %common.ret, label %rhs596

rhs596:                                           ; preds = %_zen_std_charAt.exit128
  %t3.i129 = tail call i32 @strlen(ptr %t0)
  %t10.i131 = icmp sge i32 %i.addr.3155, %t3.i129
  %t5.i132 = select i1 %t7.i118, i1 true, i1 %t10.i131
  br i1 %t5.i132, label %if137.i138, label %end133.i133

if137.i138:                                       ; preds = %rhs596
  %t12.i139 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit140

end133.i133:                                      ; preds = %rhs596
  %10 = zext nneg i32 %i.addr.3155 to i64
  %t15.i134 = getelementptr i8, ptr %t0, i64 %10
  %t16.i135 = load i8, ptr %t15.i134, align 1
  %t17.i136 = tail call ptr @_zen_char_to_string(i8 %t16.i135)
  br label %_zen_std_charAt.exit140

_zen_std_charAt.exit140:                          ; preds = %if137.i138, %end133.i133
  %common.ret.op.i137 = phi ptr [ %t12.i139, %if137.i138 ], [ %t17.i136, %end133.i133 ]
  %t127 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i137, ptr noundef nonnull dereferenceable(1) %t126)
  %t128 = icmp eq i32 %t127, 0
  br i1 %t128, label %common.ret, label %rhs593

rhs593:                                           ; preds = %_zen_std_charAt.exit140
  %t3.i141 = tail call i32 @strlen(ptr %t0)
  %t10.i143 = icmp sge i32 %i.addr.3155, %t3.i141
  %t5.i144 = select i1 %t7.i118, i1 true, i1 %t10.i143
  br i1 %t5.i144, label %if137.i150, label %end133.i145

if137.i150:                                       ; preds = %rhs593
  %t12.i151 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit152

end133.i145:                                      ; preds = %rhs593
  %11 = zext nneg i32 %i.addr.3155 to i64
  %t15.i146 = getelementptr i8, ptr %t0, i64 %11
  %t16.i147 = load i8, ptr %t15.i146, align 1
  %t17.i148 = tail call ptr @_zen_char_to_string(i8 %t16.i147)
  br label %_zen_std_charAt.exit152

_zen_std_charAt.exit152:                          ; preds = %if137.i150, %end133.i145
  %common.ret.op.i149 = phi ptr [ %t12.i151, %if137.i150 ], [ %t17.i148, %end133.i145 ]
  %t134 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i149, ptr noundef nonnull dereferenceable(1) %t133)
  %t135 = icmp eq i32 %t134, 0
  br i1 %t135, label %common.ret, label %end592

end592:                                           ; preds = %_zen_std_charAt.exit152
  %t137 = add nsw i32 %i.addr.3155, 1
  %t111 = tail call i32 @strlen(ptr %t0)
  %t112 = icmp slt i32 %t137, %t111
  br i1 %t112, label %whileBody590, label %common.ret
}

define ptr @_zen_std__json_getArrayIndex(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond505.i

whileCond505.i:                                   ; preds = %whileBody506.i, %entry
  %i.addr.0.i = phi i32 [ 0, %entry ], [ %t12.i, %whileBody506.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t10.i.i.not = icmp slt i32 %i.addr.0.i, %t3.i.i
  br i1 %t10.i.i.not, label %end133.i.i, label %if137.i.i

if137.i.i:                                        ; preds = %whileCond505.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end133.i.i:                                       ; preds = %whileCond505.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end133.i.i, %if137.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if137.i.i ], [ %t17.i.i, %end133.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs508.i, label %_zen_std__json_skipWS.exit

rhs508.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody506.i, label %_zen_std__json_skipWS.exit

whileBody506.i:                                   ; preds = %rhs508.i
  %t12.i = add nuw nsw i32 %i.addr.0.i, 1
  br label %whileCond505.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs508.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i12.not = icmp slt i32 %i.addr.0.i, %t3.i
  br i1 %t10.i12.not, label %end133.i, label %if137.i

if137.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i14 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i14, %if137.i ], [ %t17.i, %end133.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11.not = icmp eq i32 %t10, 0
  br i1 %t11.not, label %end600, label %if601

common.ret:                                       ; preds = %whileEnd604, %if612, %if601
  %common.ret.op = phi ptr [ %t13, %if601 ], [ %t54, %if612 ], [ %t62, %whileEnd604 ]
  ret ptr %common.ret.op

if601:                                            ; preds = %_zen_std_charAt.exit
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

end600:                                           ; preds = %_zen_std_charAt.exit
  %t15 = add nuw i32 %i.addr.0.i, 1
  %t2078 = tail call i32 @strlen(ptr %t0)
  %t2179 = icmp slt i32 %t15, %t2078
  br i1 %t2179, label %whileCond505.i15.preheader, label %whileEnd604

whileCond505.i15.preheader:                       ; preds = %end600, %end611
  %t4.081 = phi i32 [ %t57, %end611 ], [ %t15, %end600 ]
  %t17.080 = phi i32 [ %t59, %end611 ], [ 0, %end600 ]
  br label %whileCond505.i15

whileCond505.i15:                                 ; preds = %whileCond505.i15.preheader, %whileBody506.i29
  %i.addr.0.i16 = phi i32 [ %t12.i30, %whileBody506.i29 ], [ %t4.081, %whileCond505.i15.preheader ]
  %t5.i17 = tail call i32 @strlen(ptr %t0)
  %t3.i.i18 = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i16, 0
  %t10.i.i19 = icmp sge i32 %i.addr.0.i16, %t3.i.i18
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i19
  br i1 %t5.i.i, label %if137.i.i31, label %end133.i.i20

if137.i.i31:                                      ; preds = %whileCond505.i15
  %t12.i.i32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i24

end133.i.i20:                                     ; preds = %whileCond505.i15
  %2 = zext nneg i32 %i.addr.0.i16 to i64
  %t15.i.i21 = getelementptr i8, ptr %t0, i64 %2
  %t16.i.i22 = load i8, ptr %t15.i.i21, align 1
  %t17.i.i23 = tail call ptr @_zen_char_to_string(i8 %t16.i.i22)
  br label %_zen_std_charAt.exit.i24

_zen_std_charAt.exit.i24:                         ; preds = %end133.i.i20, %if137.i.i31
  %common.ret.op.i.i25 = phi ptr [ %t12.i.i32, %if137.i.i31 ], [ %t17.i.i23, %end133.i.i20 ]
  %t6.i26 = icmp slt i32 %i.addr.0.i16, %t5.i17
  br i1 %t6.i26, label %rhs508.i27, label %_zen_std__json_skipWS.exit33

rhs508.i27:                                       ; preds = %_zen_std_charAt.exit.i24
  %t10.i28 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i25)
  br i1 %t10.i28, label %whileBody506.i29, label %_zen_std__json_skipWS.exit33

whileBody506.i29:                                 ; preds = %rhs508.i27
  %t12.i30 = add nsw i32 %i.addr.0.i16, 1
  br label %whileCond505.i15

_zen_std__json_skipWS.exit33:                     ; preds = %_zen_std_charAt.exit.i24, %rhs508.i27
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t3.i34 = tail call i32 @strlen(ptr %t0)
  %t10.i35 = icmp sge i32 %i.addr.0.i16, %t3.i34
  %t5.i36 = select i1 %t7.i.i, i1 true, i1 %t10.i35
  br i1 %t5.i36, label %if137.i42, label %end133.i37

if137.i42:                                        ; preds = %_zen_std__json_skipWS.exit33
  %t12.i43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit44

end133.i37:                                       ; preds = %_zen_std__json_skipWS.exit33
  %3 = zext nneg i32 %i.addr.0.i16 to i64
  %t15.i38 = getelementptr i8, ptr %t0, i64 %3
  %t16.i39 = load i8, ptr %t15.i38, align 1
  %t17.i40 = tail call ptr @_zen_char_to_string(i8 %t16.i39)
  br label %_zen_std_charAt.exit44

_zen_std_charAt.exit44:                           ; preds = %if137.i42, %end133.i37
  %common.ret.op.i41 = phi ptr [ %t12.i43, %if137.i42 ], [ %t17.i40, %end133.i37 ]
  %t30 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i41, ptr noundef nonnull dereferenceable(1) %t29)
  %t31 = icmp eq i32 %t30, 0
  br i1 %t31, label %whileCond505.i45, label %end605

whileCond505.i45:                                 ; preds = %_zen_std_charAt.exit44, %rhs508.i59
  %i.addr.0.i46.in = phi i32 [ %i.addr.0.i46, %rhs508.i59 ], [ %i.addr.0.i16, %_zen_std_charAt.exit44 ]
  %i.addr.0.i46 = add i32 %i.addr.0.i46.in, 1
  %t5.i47 = tail call i32 @strlen(ptr %t0)
  %t3.i.i48 = tail call i32 @strlen(ptr %t0)
  %t7.i.i49 = icmp slt i32 %i.addr.0.i46, 0
  %t10.i.i50 = icmp sge i32 %i.addr.0.i46, %t3.i.i48
  %t5.i.i51 = select i1 %t7.i.i49, i1 true, i1 %t10.i.i50
  br i1 %t5.i.i51, label %if137.i.i63, label %end133.i.i52

if137.i.i63:                                      ; preds = %whileCond505.i45
  %t12.i.i64 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i56

end133.i.i52:                                     ; preds = %whileCond505.i45
  %4 = zext nneg i32 %i.addr.0.i46 to i64
  %t15.i.i53 = getelementptr i8, ptr %t0, i64 %4
  %t16.i.i54 = load i8, ptr %t15.i.i53, align 1
  %t17.i.i55 = tail call ptr @_zen_char_to_string(i8 %t16.i.i54)
  br label %_zen_std_charAt.exit.i56

_zen_std_charAt.exit.i56:                         ; preds = %end133.i.i52, %if137.i.i63
  %common.ret.op.i.i57 = phi ptr [ %t12.i.i64, %if137.i.i63 ], [ %t17.i.i55, %end133.i.i52 ]
  %t6.i58 = icmp slt i32 %i.addr.0.i46, %t5.i47
  br i1 %t6.i58, label %rhs508.i59, label %end605

rhs508.i59:                                       ; preds = %_zen_std_charAt.exit.i56
  %t10.i60 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i57)
  br i1 %t10.i60, label %whileCond505.i45, label %end605

end605:                                           ; preds = %rhs508.i59, %_zen_std_charAt.exit.i56, %_zen_std_charAt.exit44
  %t4.1 = phi i32 [ %i.addr.0.i16, %_zen_std_charAt.exit44 ], [ %i.addr.0.i46, %_zen_std_charAt.exit.i56 ], [ %i.addr.0.i46, %rhs508.i59 ]
  %t42 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i66 = tail call i32 @strlen(ptr %t0)
  %t7.i67 = icmp slt i32 %t4.1, 0
  %t10.i68 = icmp sge i32 %t4.1, %t3.i66
  %t5.i69 = select i1 %t7.i67, i1 true, i1 %t10.i68
  br i1 %t5.i69, label %if137.i75, label %end133.i70

if137.i75:                                        ; preds = %end605
  %t12.i76 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit77

end133.i70:                                       ; preds = %end605
  %5 = zext nneg i32 %t4.1 to i64
  %t15.i71 = getelementptr i8, ptr %t0, i64 %5
  %t16.i72 = load i8, ptr %t15.i71, align 1
  %t17.i73 = tail call ptr @_zen_char_to_string(i8 %t16.i72)
  br label %_zen_std_charAt.exit77

_zen_std_charAt.exit77:                           ; preds = %if137.i75, %end133.i70
  %common.ret.op.i74 = phi ptr [ %t12.i76, %if137.i75 ], [ %t17.i73, %end133.i70 ]
  %t43 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i74, ptr noundef nonnull dereferenceable(1) %t42)
  %t44 = icmp eq i32 %t43, 0
  br i1 %t44, label %whileEnd604, label %end607

end607:                                           ; preds = %_zen_std_charAt.exit77
  %t47 = tail call i32 @strlen(ptr %t0)
  %t48.not = icmp slt i32 %t4.1, %t47
  br i1 %t48.not, label %end609, label %whileEnd604

end609:                                           ; preds = %end607
  %t51 = icmp eq i32 %t17.080, %t1
  br i1 %t51, label %if612, label %end611

if612:                                            ; preds = %end609
  %t54 = tail call ptr @_zen_std__json_extractValue(ptr %t0, i32 %t4.1)
  br label %common.ret

end611:                                           ; preds = %end609
  %t57 = tail call i32 @_zen_std__json_skipElement(ptr %t0, i32 %t4.1)
  %t59 = add i32 %t17.080, 1
  %t20 = tail call i32 @strlen(ptr %t0)
  %t21 = icmp slt i32 %t57, %t20
  br i1 %t21, label %whileCond505.i15.preheader, label %whileEnd604

whileEnd604:                                      ; preds = %end611, %_zen_std_charAt.exit77, %end607, %end600
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret
}

define ptr @_zen_std__json_getKey(ptr %t0, ptr readonly captures(none) %t1) local_unnamed_addr {
entry:
  br label %whileCond505.i

whileCond505.i:                                   ; preds = %whileBody506.i, %entry
  %i.addr.0.i = phi i32 [ 0, %entry ], [ %t12.i, %whileBody506.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t10.i.i.not = icmp slt i32 %i.addr.0.i, %t3.i.i
  br i1 %t10.i.i.not, label %end133.i.i, label %if137.i.i

if137.i.i:                                        ; preds = %whileCond505.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end133.i.i:                                       ; preds = %whileCond505.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end133.i.i, %if137.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if137.i.i ], [ %t17.i.i, %end133.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs508.i, label %_zen_std__json_skipWS.exit

rhs508.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody506.i, label %_zen_std__json_skipWS.exit

whileBody506.i:                                   ; preds = %rhs508.i
  %t12.i = add nuw nsw i32 %i.addr.0.i, 1
  br label %whileCond505.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs508.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i21.not = icmp slt i32 %i.addr.0.i, %t3.i
  br i1 %t10.i21.not, label %end133.i, label %if137.i

if137.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i23, %if137.i ], [ %t17.i, %end133.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11.not = icmp eq i32 %t10, 0
  br i1 %t11.not, label %end613, label %if614

common.ret:                                       ; preds = %whileEnd617, %if633, %if614
  %common.ret.op = phi ptr [ %t13, %if614 ], [ %t101, %if633 ], [ %t106, %whileEnd617 ]
  ret ptr %common.ret.op

if614:                                            ; preds = %_zen_std_charAt.exit
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

end613:                                           ; preds = %_zen_std_charAt.exit
  %t15 = add nuw i32 %i.addr.0.i, 1
  %t19173 = tail call i32 @strlen(ptr %t0)
  %t20174 = icmp slt i32 %t15, %t19173
  br i1 %t20174, label %whileCond505.i24, label %whileEnd617

whileCond505.i24:                                 ; preds = %end613, %whileCond505.i24.backedge
  %i.addr.0.i25 = phi i32 [ %i.addr.0.i25.be, %whileCond505.i24.backedge ], [ %t15, %end613 ]
  %t5.i26 = tail call i32 @strlen(ptr %t0)
  %t3.i.i27 = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i25, 0
  %t10.i.i28 = icmp sge i32 %i.addr.0.i25, %t3.i.i27
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i28
  br i1 %t5.i.i, label %if137.i.i40, label %end133.i.i29

if137.i.i40:                                      ; preds = %whileCond505.i24
  %t12.i.i41 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i33

end133.i.i29:                                     ; preds = %whileCond505.i24
  %2 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i.i30 = getelementptr i8, ptr %t0, i64 %2
  %t16.i.i31 = load i8, ptr %t15.i.i30, align 1
  %t17.i.i32 = tail call ptr @_zen_char_to_string(i8 %t16.i.i31)
  br label %_zen_std_charAt.exit.i33

_zen_std_charAt.exit.i33:                         ; preds = %end133.i.i29, %if137.i.i40
  %common.ret.op.i.i34 = phi ptr [ %t12.i.i41, %if137.i.i40 ], [ %t17.i.i32, %end133.i.i29 ]
  %t6.i35 = icmp slt i32 %i.addr.0.i25, %t5.i26
  br i1 %t6.i35, label %rhs508.i36, label %_zen_std__json_skipWS.exit42

rhs508.i36:                                       ; preds = %_zen_std_charAt.exit.i33
  %t10.i37 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i34)
  br i1 %t10.i37, label %whileBody506.i38, label %_zen_std__json_skipWS.exit42

whileBody506.i38:                                 ; preds = %rhs508.i36
  %t12.i39 = add nsw i32 %i.addr.0.i25, 1
  br label %whileCond505.i24.backedge

whileCond505.i24.backedge:                        ; preds = %whileBody506.i38, %end632
  %i.addr.0.i25.be = phi i32 [ %t12.i39, %whileBody506.i38 ], [ %t104, %end632 ]
  br label %whileCond505.i24

_zen_std__json_skipWS.exit42:                     ; preds = %_zen_std_charAt.exit.i33, %rhs508.i36
  %t28 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i43 = tail call i32 @strlen(ptr %t0)
  %t10.i44 = icmp sge i32 %i.addr.0.i25, %t3.i43
  %t5.i45 = select i1 %t7.i.i, i1 true, i1 %t10.i44
  br i1 %t5.i45, label %if137.i51, label %end133.i46

if137.i51:                                        ; preds = %_zen_std__json_skipWS.exit42
  %t12.i52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit53

end133.i46:                                       ; preds = %_zen_std__json_skipWS.exit42
  %3 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i47 = getelementptr i8, ptr %t0, i64 %3
  %t16.i48 = load i8, ptr %t15.i47, align 1
  %t17.i49 = tail call ptr @_zen_char_to_string(i8 %t16.i48)
  br label %_zen_std_charAt.exit53

_zen_std_charAt.exit53:                           ; preds = %if137.i51, %end133.i46
  %common.ret.op.i50 = phi ptr [ %t12.i52, %if137.i51 ], [ %t17.i49, %end133.i46 ]
  %t29 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i50, ptr noundef nonnull dereferenceable(1) %t28)
  %t30 = icmp eq i32 %t29, 0
  br i1 %t30, label %whileEnd617, label %end618

end618:                                           ; preds = %_zen_std_charAt.exit53
  %t35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t3.i54 = tail call i32 @strlen(ptr %t0)
  %t10.i56 = icmp sge i32 %i.addr.0.i25, %t3.i54
  %t5.i57 = select i1 %t7.i.i, i1 true, i1 %t10.i56
  br i1 %t5.i57, label %if137.i63, label %end133.i58

if137.i63:                                        ; preds = %end618
  %t12.i64 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit65

end133.i58:                                       ; preds = %end618
  %4 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i59 = getelementptr i8, ptr %t0, i64 %4
  %t16.i60 = load i8, ptr %t15.i59, align 1
  %t17.i61 = tail call ptr @_zen_char_to_string(i8 %t16.i60)
  br label %_zen_std_charAt.exit65

_zen_std_charAt.exit65:                           ; preds = %if137.i63, %end133.i58
  %common.ret.op.i62 = phi ptr [ %t12.i64, %if137.i63 ], [ %t17.i61, %end133.i58 ]
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i62, ptr noundef nonnull dereferenceable(1) %t35)
  %t37 = icmp eq i32 %t36, 0
  br i1 %t37, label %whileCond505.i66, label %end620

whileCond505.i66:                                 ; preds = %_zen_std_charAt.exit65, %rhs508.i80
  %i.addr.0.i67.in = phi i32 [ %i.addr.0.i67, %rhs508.i80 ], [ %i.addr.0.i25, %_zen_std_charAt.exit65 ]
  %i.addr.0.i67 = add i32 %i.addr.0.i67.in, 1
  %t5.i68 = tail call i32 @strlen(ptr %t0)
  %t3.i.i69 = tail call i32 @strlen(ptr %t0)
  %t7.i.i70 = icmp slt i32 %i.addr.0.i67, 0
  %t10.i.i71 = icmp sge i32 %i.addr.0.i67, %t3.i.i69
  %t5.i.i72 = select i1 %t7.i.i70, i1 true, i1 %t10.i.i71
  br i1 %t5.i.i72, label %if137.i.i84, label %end133.i.i73

if137.i.i84:                                      ; preds = %whileCond505.i66
  %t12.i.i85 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i77

end133.i.i73:                                     ; preds = %whileCond505.i66
  %5 = zext nneg i32 %i.addr.0.i67 to i64
  %t15.i.i74 = getelementptr i8, ptr %t0, i64 %5
  %t16.i.i75 = load i8, ptr %t15.i.i74, align 1
  %t17.i.i76 = tail call ptr @_zen_char_to_string(i8 %t16.i.i75)
  br label %_zen_std_charAt.exit.i77

_zen_std_charAt.exit.i77:                         ; preds = %end133.i.i73, %if137.i.i84
  %common.ret.op.i.i78 = phi ptr [ %t12.i.i85, %if137.i.i84 ], [ %t17.i.i76, %end133.i.i73 ]
  %t6.i79 = icmp slt i32 %i.addr.0.i67, %t5.i68
  br i1 %t6.i79, label %rhs508.i80, label %end620

rhs508.i80:                                       ; preds = %_zen_std_charAt.exit.i77
  %t10.i81 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i78)
  br i1 %t10.i81, label %whileCond505.i66, label %end620

end620:                                           ; preds = %rhs508.i80, %_zen_std_charAt.exit.i77, %_zen_std_charAt.exit65
  %t4.1 = phi i32 [ %i.addr.0.i25, %_zen_std_charAt.exit65 ], [ %i.addr.0.i67, %_zen_std_charAt.exit.i77 ], [ %i.addr.0.i67, %rhs508.i80 ]
  %t48 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i87 = tail call i32 @strlen(ptr %t0)
  %t7.i88 = icmp slt i32 %t4.1, 0
  %t10.i89 = icmp sge i32 %t4.1, %t3.i87
  %t5.i90 = select i1 %t7.i88, i1 true, i1 %t10.i89
  br i1 %t5.i90, label %if137.i96, label %end133.i91

if137.i96:                                        ; preds = %end620
  %t12.i97 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit98

end133.i91:                                       ; preds = %end620
  %6 = zext nneg i32 %t4.1 to i64
  %t15.i92 = getelementptr i8, ptr %t0, i64 %6
  %t16.i93 = load i8, ptr %t15.i92, align 1
  %t17.i94 = tail call ptr @_zen_char_to_string(i8 %t16.i93)
  br label %_zen_std_charAt.exit98

_zen_std_charAt.exit98:                           ; preds = %if137.i96, %end133.i91
  %common.ret.op.i95 = phi ptr [ %t12.i97, %if137.i96 ], [ %t17.i94, %end133.i91 ]
  %t49 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i95, ptr noundef nonnull dereferenceable(1) %t48)
  %t50.not = icmp eq i32 %t49, 0
  br i1 %t50.not, label %end622, label %whileEnd617

end622:                                           ; preds = %_zen_std_charAt.exit98
  %t53 = add i32 %t4.1, 1
  %t59167 = tail call i32 @strlen(ptr %t0)
  %t65168 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t60169 = icmp slt i32 %t53, %t59167
  br i1 %t60169, label %rhs627, label %whileEnd626

rhs627:                                           ; preds = %end622, %whileBody625
  %t65171 = phi ptr [ %t65, %whileBody625 ], [ %t65168, %end622 ]
  %t54.0170 = phi i32 [ %t69, %whileBody625 ], [ %t53, %end622 ]
  %t3.i99 = tail call i32 @strlen(ptr %t0)
  %t7.i100 = icmp slt i32 %t54.0170, 0
  %t10.i101 = icmp sge i32 %t54.0170, %t3.i99
  %t5.i102 = select i1 %t7.i100, i1 true, i1 %t10.i101
  br i1 %t5.i102, label %if137.i108, label %end133.i103

if137.i108:                                       ; preds = %rhs627
  %t12.i109 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit110

end133.i103:                                      ; preds = %rhs627
  %7 = zext nneg i32 %t54.0170 to i64
  %t15.i104 = getelementptr i8, ptr %t0, i64 %7
  %t16.i105 = load i8, ptr %t15.i104, align 1
  %t17.i106 = tail call ptr @_zen_char_to_string(i8 %t16.i105)
  br label %_zen_std_charAt.exit110

_zen_std_charAt.exit110:                          ; preds = %if137.i108, %end133.i103
  %common.ret.op.i107 = phi ptr [ %t12.i109, %if137.i108 ], [ %t17.i106, %end133.i103 ]
  %t66 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i107, ptr noundef nonnull dereferenceable(1) %t65171)
  %t67.not = icmp eq i32 %t66, 0
  br i1 %t67.not, label %whileEnd626, label %whileBody625

whileBody625:                                     ; preds = %_zen_std_charAt.exit110
  %t69 = add nsw i32 %t54.0170, 1
  %t59 = tail call i32 @strlen(ptr %t0)
  %t65 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t60 = icmp slt i32 %t69, %t59
  br i1 %t60, label %rhs627, label %whileEnd626

whileEnd626:                                      ; preds = %_zen_std_charAt.exit110, %whileBody625, %end622
  %t54.0.lcssa = phi i32 [ %t53, %end622 ], [ %t69, %whileBody625 ], [ %t54.0170, %_zen_std_charAt.exit110 ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t53, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t54.0.lcssa, i32 %t4.i)
  %t16.i111 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i111, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody131.i, label %_zen_std_slice.exit

whileBody131.i:                                   ; preds = %whileEnd626, %whileBody131.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody131.i ], [ %t18.i, %whileEnd626 ]
  %t22.09.i = phi i32 [ %t37.i, %whileBody131.i ], [ %spec.store.select.i, %whileEnd626 ]
  %8 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t0, i64 %8
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %t37.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t37.i, %spec.select.i
  br i1 %t26.i, label %whileBody131.i, label %_zen_std_slice.exit

_zen_std_slice.exit:                              ; preds = %whileBody131.i, %whileEnd626
  %common.ret.op.i112 = phi ptr [ %t18.i, %whileEnd626 ], [ %t34.i, %whileBody131.i ]
  br label %whileCond505.i113

whileCond505.i113:                                ; preds = %rhs508.i127, %_zen_std_slice.exit
  %i.addr.0.i114.in = phi i32 [ %t54.0.lcssa, %_zen_std_slice.exit ], [ %i.addr.0.i114, %rhs508.i127 ]
  %i.addr.0.i114 = add i32 %i.addr.0.i114.in, 1
  %t5.i115 = tail call i32 @strlen(ptr %t0)
  %t3.i.i116 = tail call i32 @strlen(ptr %t0)
  %t7.i.i117 = icmp slt i32 %i.addr.0.i114, 0
  %t10.i.i118 = icmp sge i32 %i.addr.0.i114, %t3.i.i116
  %t5.i.i119 = select i1 %t7.i.i117, i1 true, i1 %t10.i.i118
  br i1 %t5.i.i119, label %if137.i.i131, label %end133.i.i120

if137.i.i131:                                     ; preds = %whileCond505.i113
  %t12.i.i132 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i124

end133.i.i120:                                    ; preds = %whileCond505.i113
  %9 = zext nneg i32 %i.addr.0.i114 to i64
  %t15.i.i121 = getelementptr i8, ptr %t0, i64 %9
  %t16.i.i122 = load i8, ptr %t15.i.i121, align 1
  %t17.i.i123 = tail call ptr @_zen_char_to_string(i8 %t16.i.i122)
  br label %_zen_std_charAt.exit.i124

_zen_std_charAt.exit.i124:                        ; preds = %end133.i.i120, %if137.i.i131
  %common.ret.op.i.i125 = phi ptr [ %t12.i.i132, %if137.i.i131 ], [ %t17.i.i123, %end133.i.i120 ]
  %t6.i126 = icmp slt i32 %i.addr.0.i114, %t5.i115
  br i1 %t6.i126, label %rhs508.i127, label %_zen_std__json_skipWS.exit133

rhs508.i127:                                      ; preds = %_zen_std_charAt.exit.i124
  %t10.i128 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i125)
  br i1 %t10.i128, label %whileCond505.i113, label %_zen_std__json_skipWS.exit133

_zen_std__json_skipWS.exit133:                    ; preds = %_zen_std_charAt.exit.i124, %rhs508.i127
  %t86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_20)
  %t3.i134 = tail call i32 @strlen(ptr %t0)
  %t10.i136 = icmp sge i32 %i.addr.0.i114, %t3.i134
  %t5.i137 = select i1 %t7.i.i117, i1 true, i1 %t10.i136
  br i1 %t5.i137, label %if137.i143, label %end133.i138

if137.i143:                                       ; preds = %_zen_std__json_skipWS.exit133
  %t12.i144 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit145

end133.i138:                                      ; preds = %_zen_std__json_skipWS.exit133
  %10 = zext nneg i32 %i.addr.0.i114 to i64
  %t15.i139 = getelementptr i8, ptr %t0, i64 %10
  %t16.i140 = load i8, ptr %t15.i139, align 1
  %t17.i141 = tail call ptr @_zen_char_to_string(i8 %t16.i140)
  br label %_zen_std_charAt.exit145

_zen_std_charAt.exit145:                          ; preds = %if137.i143, %end133.i138
  %common.ret.op.i142 = phi ptr [ %t12.i144, %if137.i143 ], [ %t17.i141, %end133.i138 ]
  %t87 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i142, ptr noundef nonnull dereferenceable(1) %t86)
  %t88.not = icmp eq i32 %t87, 0
  br i1 %t88.not, label %end630, label %whileEnd617

end630:                                           ; preds = %_zen_std_charAt.exit145
  %t90 = add i32 %i.addr.0.i114.in, 2
  br label %whileCond505.i146

whileCond505.i146:                                ; preds = %whileBody506.i162, %end630
  %i.addr.0.i147 = phi i32 [ %t90, %end630 ], [ %t12.i163, %whileBody506.i162 ]
  %t5.i148 = tail call i32 @strlen(ptr %t0)
  %t3.i.i149 = tail call i32 @strlen(ptr %t0)
  %t7.i.i150 = icmp slt i32 %i.addr.0.i147, 0
  %t10.i.i151 = icmp sge i32 %i.addr.0.i147, %t3.i.i149
  %t5.i.i152 = select i1 %t7.i.i150, i1 true, i1 %t10.i.i151
  br i1 %t5.i.i152, label %if137.i.i164, label %end133.i.i153

if137.i.i164:                                     ; preds = %whileCond505.i146
  %t12.i.i165 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i157

end133.i.i153:                                    ; preds = %whileCond505.i146
  %11 = zext nneg i32 %i.addr.0.i147 to i64
  %t15.i.i154 = getelementptr i8, ptr %t0, i64 %11
  %t16.i.i155 = load i8, ptr %t15.i.i154, align 1
  %t17.i.i156 = tail call ptr @_zen_char_to_string(i8 %t16.i.i155)
  br label %_zen_std_charAt.exit.i157

_zen_std_charAt.exit.i157:                        ; preds = %end133.i.i153, %if137.i.i164
  %common.ret.op.i.i158 = phi ptr [ %t12.i.i165, %if137.i.i164 ], [ %t17.i.i156, %end133.i.i153 ]
  %t6.i159 = icmp slt i32 %i.addr.0.i147, %t5.i148
  br i1 %t6.i159, label %rhs508.i160, label %_zen_std__json_skipWS.exit166

rhs508.i160:                                      ; preds = %_zen_std_charAt.exit.i157
  %t10.i161 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i158)
  br i1 %t10.i161, label %whileBody506.i162, label %_zen_std__json_skipWS.exit166

whileBody506.i162:                                ; preds = %rhs508.i160
  %t12.i163 = add nsw i32 %i.addr.0.i147, 1
  br label %whileCond505.i146

_zen_std__json_skipWS.exit166:                    ; preds = %_zen_std_charAt.exit.i157, %rhs508.i160
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i112, ptr noundef nonnull dereferenceable(1) %t1)
  %t98 = icmp eq i32 %t97, 0
  br i1 %t98, label %if633, label %end632

if633:                                            ; preds = %_zen_std__json_skipWS.exit166
  %t101 = tail call ptr @_zen_std__json_extractValue(ptr %t0, i32 %i.addr.0.i147)
  br label %common.ret

end632:                                           ; preds = %_zen_std__json_skipWS.exit166
  %t104 = tail call i32 @_zen_std__json_skipElement(ptr %t0, i32 %i.addr.0.i147)
  %t19 = tail call i32 @strlen(ptr %t0)
  %t20 = icmp slt i32 %t104, %t19
  br i1 %t20, label %whileCond505.i24.backedge, label %whileEnd617

whileEnd617:                                      ; preds = %end632, %_zen_std_charAt.exit53, %_zen_std_charAt.exit98, %_zen_std_charAt.exit145, %end613
  %t106 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret
}

define i32 @_zen_std__json_parseInt(ptr %t0) local_unnamed_addr {
entry:
  %t54 = tail call i32 @strlen(ptr %t0)
  %t65 = icmp sgt i32 %t54, 0
  br i1 %t65, label %whileBody635, label %whileEnd636

whileBody635:                                     ; preds = %entry, %_zen_std_charAt.exit
  %t1.07 = phi i32 [ %t16, %_zen_std_charAt.exit ], [ 0, %entry ]
  %t2.06 = phi i32 [ %t19, %_zen_std_charAt.exit ], [ 0, %entry ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i.not = icmp slt i32 %t2.06, %t3.i
  br i1 %t10.i.not, label %end133.i, label %if137.i

if137.i:                                          ; preds = %whileBody635
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %whileBody635
  %0 = zext nneg i32 %t2.06 to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i, %if137.i ], [ %t17.i, %end133.i ]
  %t11 = tail call i32 @_string_to_int_ascii(ptr %common.ret.op.i)
  %t14 = mul i32 %t1.07, 10
  %t12 = add i32 %t14, -48
  %t16 = add i32 %t12, %t11
  %t19 = add nuw nsw i32 %t2.06, 1
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6 = icmp slt i32 %t19, %t5
  br i1 %t6, label %whileBody635, label %whileEnd636

whileEnd636:                                      ; preds = %_zen_std_charAt.exit, %entry
  %t1.0.lcssa = phi i32 [ 0, %entry ], [ %t16, %_zen_std_charAt.exit ]
  ret i32 %t1.0.lcssa
}

define ptr @_zen_std_json(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t792 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %t993 = tail call ptr @_zen_std_splitAt(ptr %t1, ptr %t792, i32 0)
  %t1394 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1495 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t993, ptr noundef nonnull dereferenceable(1) %t1394)
  %t1596 = icmp eq i32 %t1495, 0
  br i1 %t1596, label %common.ret, label %whileCond642.preheader

whileCond642.preheader:                           ; preds = %entry, %whileEnd653
  %t999 = phi ptr [ %t9, %whileEnd653 ], [ %t993, %entry ]
  %t2.098 = phi ptr [ %t2.2.lcssa, %whileEnd653 ], [ %t0, %entry ]
  %t4.097 = phi i32 [ %t108, %whileEnd653 ], [ 0, %entry ]
  %t1977 = tail call i32 @strlen(ptr nonnull %t999)
  %t2078 = icmp sgt i32 %t1977, 0
  br i1 %t2078, label %whileBody643, label %whileEnd644

whileBody643:                                     ; preds = %whileCond642.preheader, %end645
  %t16.079 = phi i32 [ %t29, %end645 ], [ 0, %whileCond642.preheader ]
  %t25 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i = tail call i32 @strlen(ptr nonnull %t999)
  %t10.i.not = icmp slt i32 %t16.079, %t3.i
  br i1 %t10.i.not, label %end133.i, label %if137.i

if137.i:                                          ; preds = %whileBody643
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end133.i:                                         ; preds = %whileBody643
  %0 = zext nneg i32 %t16.079 to i64
  %t15.i = getelementptr i8, ptr %t999, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if137.i, %end133.i
  %common.ret.op.i = phi ptr [ %t12.i, %if137.i ], [ %t17.i, %end133.i ]
  %t26 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t25)
  %t27 = icmp eq i32 %t26, 0
  br i1 %t27, label %whileEnd644, label %end645

end645:                                           ; preds = %_zen_std_charAt.exit
  %t29 = add nuw nsw i32 %t16.079, 1
  %t19 = tail call i32 @strlen(ptr nonnull %t999)
  %t20 = icmp slt i32 %t29, %t19
  br i1 %t20, label %whileBody643, label %whileEnd644

whileEnd644:                                      ; preds = %end645, %_zen_std_charAt.exit, %whileCond642.preheader
  %t16.0.lcssa = phi i32 [ 0, %whileCond642.preheader ], [ %t16.079, %_zen_std_charAt.exit ], [ %t29, %end645 ]
  %t4.i = tail call i32 @strlen(ptr nonnull %t999)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t16.0.lcssa, i32 %t4.i)
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %or.cond.i = icmp sgt i32 %spec.select.i, 0
  br i1 %or.cond.i, label %whileBody131.i, label %_zen_std_slice.exit

whileBody131.i:                                   ; preds = %whileEnd644, %whileBody131.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody131.i ], [ %t18.i, %whileEnd644 ]
  %t22.09.i = phi i32 [ %t37.i, %whileBody131.i ], [ 0, %whileEnd644 ]
  %1 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t999, i64 %1
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %t37.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t37.i, %spec.select.i
  br i1 %t26.i, label %whileBody131.i, label %_zen_std_slice.exit

_zen_std_slice.exit:                              ; preds = %whileBody131.i, %whileEnd644
  %common.ret.op.i14 = phi ptr [ %t18.i, %whileEnd644 ], [ %t34.i, %whileBody131.i ]
  %t38 = tail call i32 @strlen(ptr nonnull %t999)
  %t4.i15 = tail call i32 @strlen(ptr nonnull %t999)
  %spec.select.i16 = tail call i32 @llvm.smin.i32(i32 %t38, i32 %t4.i15)
  %t16.i17 = icmp sle i32 %t16.0.lcssa, %spec.select.i16
  %t18.i18 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i19 = icmp samesign ult i32 %t16.0.lcssa, %spec.select.i16
  %or.cond.i20 = select i1 %t16.i17, i1 %t268.i19, i1 false
  br i1 %or.cond.i20, label %whileBody131.i22, label %_zen_std_slice.exit31

whileBody131.i22:                                 ; preds = %_zen_std_slice.exit, %whileBody131.i22
  %t19.010.i23 = phi ptr [ %t34.i28, %whileBody131.i22 ], [ %t18.i18, %_zen_std_slice.exit ]
  %t22.09.i24 = phi i32 [ %t37.i29, %whileBody131.i22 ], [ %t16.0.lcssa, %_zen_std_slice.exit ]
  %2 = zext nneg i32 %t22.09.i24 to i64
  %t30.i25 = getelementptr i8, ptr %t999, i64 %2
  %t31.i26 = load i8, ptr %t30.i25, align 1
  %t32.i27 = tail call ptr @_zen_char_to_string(i8 %t31.i26)
  %t34.i28 = tail call ptr @_str_concat(ptr %t19.010.i23, ptr %t32.i27)
  %t37.i29 = add nuw nsw i32 %t22.09.i24, 1
  %t26.i30 = icmp slt i32 %t37.i29, %spec.select.i16
  br i1 %t26.i30, label %whileBody131.i22, label %_zen_std_slice.exit31

_zen_std_slice.exit31:                            ; preds = %whileBody131.i22, %_zen_std_slice.exit
  %common.ret.op.i21 = phi ptr [ %t18.i18, %_zen_std_slice.exit ], [ %t34.i28, %whileBody131.i22 ]
  %t43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t44 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i14, ptr noundef nonnull dereferenceable(1) %t43)
  %t45.not = icmp eq i32 %t44, 0
  br i1 %t45.not, label %end647, label %if648

if648:                                            ; preds = %_zen_std_slice.exit31
  %t48 = tail call ptr @_zen_std__json_getKey(ptr %t2.098, ptr nonnull %common.ret.op.i14)
  %t51 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  %t52 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t48, ptr noundef nonnull dereferenceable(1) %t51)
  %t53 = icmp eq i32 %t52, 0
  br i1 %t53, label %common.ret.sink.split, label %end647

common.ret.sink.split:                            ; preds = %if648, %_zen_std_slice.exit73
  %t103 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

common.ret:                                       ; preds = %whileEnd653, %common.ret.sink.split, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t103, %common.ret.sink.split ], [ %t2.2.lcssa, %whileEnd653 ]
  ret ptr %common.ret.op

end647:                                           ; preds = %if648, %_zen_std_slice.exit31
  %t2.1 = phi ptr [ %t48, %if648 ], [ %t2.098, %_zen_std_slice.exit31 ]
  %t5986 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t6087 = icmp sgt i32 %t5986, 0
  br i1 %t6087, label %whileBody652, label %whileEnd653

whileCond651:                                     ; preds = %_zen_std_slice.exit73
  %t105 = add i32 %t68.0.lcssa, 1
  %t59 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t60 = icmp slt i32 %t105, %t59
  br i1 %t60, label %whileBody652, label %whileEnd653

whileBody652:                                     ; preds = %end647, %whileCond651
  %t2.289 = phi ptr [ %t96, %whileCond651 ], [ %t2.1, %end647 ]
  %t56.088 = phi i32 [ %t105, %whileCond651 ], [ 0, %end647 ]
  %t65 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i32 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7.i33 = icmp slt i32 %t56.088, 0
  %t10.i34 = icmp sge i32 %t56.088, %t3.i32
  %t5.i35 = select i1 %t7.i33, i1 true, i1 %t10.i34
  br i1 %t5.i35, label %if137.i41, label %end133.i36

if137.i41:                                        ; preds = %whileBody652
  %t12.i42 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit43

end133.i36:                                       ; preds = %whileBody652
  %3 = zext nneg i32 %t56.088 to i64
  %t15.i37 = getelementptr i8, ptr %common.ret.op.i21, i64 %3
  %t16.i38 = load i8, ptr %t15.i37, align 1
  %t17.i39 = tail call ptr @_zen_char_to_string(i8 %t16.i38)
  br label %_zen_std_charAt.exit43

_zen_std_charAt.exit43:                           ; preds = %if137.i41, %end133.i36
  %common.ret.op.i40 = phi ptr [ %t12.i42, %if137.i41 ], [ %t17.i39, %end133.i36 ]
  %t66 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i40, ptr noundef nonnull dereferenceable(1) %t65)
  %t67.not = icmp eq i32 %t66, 0
  br i1 %t67.not, label %end654, label %whileEnd653

end654:                                           ; preds = %_zen_std_charAt.exit43
  %t70 = add nsw i32 %t56.088, 1
  %t7381 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7482 = icmp slt i32 %t70, %t7381
  br i1 %t7482, label %whileBody657, label %whileEnd658

whileBody657:                                     ; preds = %end654, %end659
  %t68.083 = phi i32 [ %t83, %end659 ], [ %t70, %end654 ]
  %t79 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i44 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7.i45 = icmp slt i32 %t68.083, 0
  %t10.i46 = icmp sge i32 %t68.083, %t3.i44
  %t5.i47 = select i1 %t7.i45, i1 true, i1 %t10.i46
  br i1 %t5.i47, label %if137.i53, label %end133.i48

if137.i53:                                        ; preds = %whileBody657
  %t12.i54 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit55

end133.i48:                                       ; preds = %whileBody657
  %4 = zext nneg i32 %t68.083 to i64
  %t15.i49 = getelementptr i8, ptr %common.ret.op.i21, i64 %4
  %t16.i50 = load i8, ptr %t15.i49, align 1
  %t17.i51 = tail call ptr @_zen_char_to_string(i8 %t16.i50)
  br label %_zen_std_charAt.exit55

_zen_std_charAt.exit55:                           ; preds = %if137.i53, %end133.i48
  %common.ret.op.i52 = phi ptr [ %t12.i54, %if137.i53 ], [ %t17.i51, %end133.i48 ]
  %t80 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i52, ptr noundef nonnull dereferenceable(1) %t79)
  %t81 = icmp eq i32 %t80, 0
  br i1 %t81, label %whileEnd658, label %end659

end659:                                           ; preds = %_zen_std_charAt.exit55
  %t83 = add nsw i32 %t68.083, 1
  %t73 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t74 = icmp slt i32 %t83, %t73
  br i1 %t74, label %whileBody657, label %whileEnd658

whileEnd658:                                      ; preds = %end659, %_zen_std_charAt.exit55, %end654
  %t68.0.lcssa = phi i32 [ %t70, %end654 ], [ %t68.083, %_zen_std_charAt.exit55 ], [ %t83, %end659 ]
  %t4.i56 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %spec.store.select.i57 = tail call i32 @llvm.smax.i32(i32 %t70, i32 0)
  %spec.select.i58 = tail call i32 @llvm.smin.i32(i32 %t68.0.lcssa, i32 %t4.i56)
  %t16.i59 = icmp sle i32 %spec.store.select.i57, %spec.select.i58
  %t18.i60 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i61 = icmp samesign ult i32 %spec.store.select.i57, %spec.select.i58
  %or.cond.i62 = select i1 %t16.i59, i1 %t268.i61, i1 false
  br i1 %or.cond.i62, label %whileBody131.i64, label %_zen_std_slice.exit73

whileBody131.i64:                                 ; preds = %whileEnd658, %whileBody131.i64
  %t19.010.i65 = phi ptr [ %t34.i70, %whileBody131.i64 ], [ %t18.i60, %whileEnd658 ]
  %t22.09.i66 = phi i32 [ %t37.i71, %whileBody131.i64 ], [ %spec.store.select.i57, %whileEnd658 ]
  %5 = zext nneg i32 %t22.09.i66 to i64
  %t30.i67 = getelementptr i8, ptr %common.ret.op.i21, i64 %5
  %t31.i68 = load i8, ptr %t30.i67, align 1
  %t32.i69 = tail call ptr @_zen_char_to_string(i8 %t31.i68)
  %t34.i70 = tail call ptr @_str_concat(ptr %t19.010.i65, ptr %t32.i69)
  %t37.i71 = add nuw nsw i32 %t22.09.i66, 1
  %t26.i72 = icmp slt i32 %t37.i71, %spec.select.i58
  br i1 %t26.i72, label %whileBody131.i64, label %_zen_std_slice.exit73

_zen_std_slice.exit73:                            ; preds = %whileBody131.i64, %whileEnd658
  %common.ret.op.i63 = phi ptr [ %t18.i60, %whileEnd658 ], [ %t34.i70, %whileBody131.i64 ]
  %t92 = tail call i32 @_zen_std__json_parseInt(ptr %common.ret.op.i63)
  %t96 = tail call ptr @_zen_std__json_getArrayIndex(ptr %t2.289, i32 %t92)
  %t99 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  %t100 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t96, ptr noundef nonnull dereferenceable(1) %t99)
  %t101 = icmp eq i32 %t100, 0
  br i1 %t101, label %common.ret.sink.split, label %whileCond651

whileEnd653:                                      ; preds = %whileCond651, %_zen_std_charAt.exit43, %end647
  %t2.2.lcssa = phi ptr [ %t2.1, %end647 ], [ %t2.289, %_zen_std_charAt.exit43 ], [ %t96, %whileCond651 ]
  %t108 = add i32 %t4.097, 1
  %t7 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %t9 = tail call ptr @_zen_std_splitAt(ptr %t1, ptr %t7, i32 %t108)
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t14 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t9, ptr noundef nonnull dereferenceable(1) %t13)
  %t15 = icmp eq i32 %t14, 0
  br i1 %t15, label %common.ret, label %whileCond642.preheader
}

define ptr @_zen_std_split(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t54 = alloca ptr, align 8
  %t76 = alloca ptr, align 8
  %t3 = tail call ptr @_zen_list_new(i64 8)
  tail call void @_zen_list_set_meta(ptr %t3, i32 1, i32 4)
  %t5 = tail call i32 @strlen(ptr %t0)
  %t8 = tail call i32 @strlen(ptr %t1)
  %t11 = icmp eq i32 %t8, 0
  br i1 %t11, label %common.ret, label %end663

common.ret:                                       ; preds = %entry, %whileEnd667
  ret ptr %t3

end663:                                           ; preds = %entry
  %t15 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1916 = icmp sgt i32 %t5, 0
  br i1 %t1916, label %whileBody666.lr.ph, label %whileEnd667

whileBody666.lr.ph:                               ; preds = %end663
  %t25 = sub i32 %t5, %t8
  %t2913 = icmp sgt i32 %t8, 0
  br label %whileBody666

whileBody666:                                     ; preds = %whileBody666.lr.ph, %end676
  %t13.018 = phi ptr [ %t15, %whileBody666.lr.ph ], [ %t13.1, %end676 ]
  %t16.017 = phi i32 [ 0, %whileBody666.lr.ph ], [ %t16.1, %end676 ]
  %t26.not = icmp sgt i32 %t16.017, %t25
  br i1 %t26.not, label %else678, label %whileCond671.preheader

whileCond671.preheader:                           ; preds = %whileBody666
  br i1 %t2913, label %whileBody672, label %if677

whileBody672:                                     ; preds = %whileCond671.preheader, %whileBody672
  %t21.015 = phi i32 [ %t48, %whileBody672 ], [ 0, %whileCond671.preheader ]
  %t20.014 = phi i1 [ %spec.select, %whileBody672 ], [ true, %whileCond671.preheader ]
  %t33 = add i32 %t21.015, %t16.017
  %0 = sext i32 %t33 to i64
  %t34 = getelementptr i8, ptr %t0, i64 %0
  %t35 = load i8, ptr %t34, align 1
  %t36 = call ptr @_zen_char_to_string(i8 %t35)
  %1 = zext nneg i32 %t21.015 to i64
  %t40 = getelementptr i8, ptr %t1, i64 %1
  %t41 = load i8, ptr %t40, align 1
  %t42 = call ptr @_zen_char_to_string(i8 %t41)
  %t44 = call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t36, ptr noundef nonnull dereferenceable(1) %t42)
  %t45.not = icmp eq i32 %t44, 0
  %spec.select = select i1 %t45.not, i1 %t20.014, i1 false
  %t48 = add nuw nsw i32 %t21.015, 1
  %t29 = icmp slt i32 %t48, %t8
  br i1 %t29, label %whileBody672, label %end668

end668:                                           ; preds = %whileBody672
  br i1 %spec.select, label %if677, label %else678

if677:                                            ; preds = %whileCond671.preheader, %end668
  store ptr %t13.018, ptr %t54, align 8
  call void @_zen_list_push(ptr %t3, ptr nonnull %t54)
  %t56 = call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end676

else678:                                          ; preds = %whileBody666, %end668
  %2 = sext i32 %t16.017 to i64
  %t65 = getelementptr i8, ptr %t0, i64 %2
  %t66 = load i8, ptr %t65, align 1
  %t67 = call ptr @_zen_char_to_string(i8 %t66)
  %t69 = call ptr @_str_concat(ptr %t13.018, ptr %t67)
  br label %end676

end676:                                           ; preds = %else678, %if677
  %t8.pn = phi i32 [ %t8, %if677 ], [ 1, %else678 ]
  %t13.1 = phi ptr [ %t56, %if677 ], [ %t69, %else678 ]
  %t16.1 = add i32 %t8.pn, %t16.017
  %t19 = icmp slt i32 %t16.1, %t5
  br i1 %t19, label %whileBody666, label %whileEnd667

whileEnd667:                                      ; preds = %end676, %end663
  %t13.0.lcssa = phi ptr [ %t15, %end663 ], [ %t13.1, %end676 ]
  store ptr %t13.0.lcssa, ptr %t76, align 8
  call void @_zen_list_push(ptr %t3, ptr nonnull %t76)
  br label %common.ret
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #4

attributes #0 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: read) }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
attributes #2 = { nofree norecurse nosync nounwind memory(none) }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none) }
attributes #4 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
