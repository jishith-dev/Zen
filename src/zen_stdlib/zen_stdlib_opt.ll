
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
define noundef i1 @_zen_std_isNaN(double %t0) local_unnamed_addr #1 {
entry:
  ret i1 false
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
  %exitcond.not = icmp eq i32 %t38, %spec.select10
  br i1 %exitcond.not, label %whileEnd30, label %whileBody29

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
define i32 @_zen_std_sqrt(i32 %t0) local_unnamed_addr #2 {
entry:
  %t2 = icmp slt i32 %t0, 0
  br i1 %t2, label %common.ret, label %whileCond37

common.ret:                                       ; preds = %entry, %whileEnd39
  %common.ret.op = phi i32 [ %t13, %whileEnd39 ], [ -1, %entry ]
  ret i32 %common.ret.op

whileCond37:                                      ; preds = %entry, %whileCond37
  %t3.0 = phi i32 [ %t10, %whileCond37 ], [ 1, %entry ]
  %t6 = mul i32 %t3.0, %t3.0
  %t8.not = icmp sgt i32 %t6, %t0
  %t10 = add i32 %t3.0, 1
  br i1 %t8.not, label %whileEnd39, label %whileCond37

whileEnd39:                                       ; preds = %whileCond37
  %t13 = add i32 %t3.0, -1
  br label %common.ret
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
  %t10 = fcmp one double %t0, %t11
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
  br i1 %t10, label %end49, label %if50

if50:                                             ; preds = %entry
  %t13 = fcmp ult double %t8, 5.000000e-01
  br i1 %t13, label %common.ret, label %if52

common.ret:                                       ; preds = %end49, %if50, %if54, %if52
  %common.ret.op = phi i32 [ %t15, %if52 ], [ %t20, %if54 ], [ %t2, %if50 ], [ %t2, %end49 ]
  ret i32 %common.ret.op

if52:                                             ; preds = %if50
  %t15 = add i32 %t2, 1
  br label %common.ret

end49:                                            ; preds = %entry
  %t18 = fcmp ugt double %t8, -5.000000e-01
  br i1 %t18, label %common.ret, label %if54

if54:                                             ; preds = %end49
  %t20 = add i32 %t2, -1
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_toFixed(double %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t3 = icmp slt i32 %t1, 0
  br i1 %t3, label %common.ret, label %end55

common.ret:                                       ; preds = %entry, %_zen_std_round.exit
  %common.ret.op = phi double [ %t18, %_zen_std_round.exit ], [ %t0, %entry ]
  ret double %common.ret.op

end55:                                            ; preds = %entry
  %t3.i = icmp eq i32 %t1, 0
  br i1 %t3.i, label %_zen_std_pow.exit, label %whileBody29.lr.ph.i

whileBody29.lr.ph.i:                              ; preds = %end55
  %t34.i = load double, ptr @INF, align 8
  br label %whileBody29.i

whileCond28.i:                                    ; preds = %whileBody29.i
  %t38.i = add nuw nsw i32 %t24.014.i, 1
  %exitcond.not.i = icmp eq i32 %t38.i, %t1
  br i1 %exitcond.not.i, label %_zen_std_pow.exit, label %whileBody29.i

whileBody29.i:                                    ; preds = %whileCond28.i, %whileBody29.lr.ph.i
  %t24.014.i = phi i32 [ 0, %whileBody29.lr.ph.i ], [ %t38.i, %whileCond28.i ]
  %t23.013.i = phi double [ 1.000000e+00, %whileBody29.lr.ph.i ], [ %t31.i, %whileCond28.i ]
  %t31.i = fmul double %t23.013.i, 1.000000e+01
  %t35.i = fcmp oeq double %t31.i, %t34.i
  br i1 %t35.i, label %_zen_std_pow.exit, label %whileCond28.i

_zen_std_pow.exit:                                ; preds = %whileCond28.i, %whileBody29.i, %end55
  %common.ret.op.i = phi double [ 1.000000e+00, %end55 ], [ %t31.i, %whileCond28.i ], [ %t34.i, %whileBody29.i ]
  %t11 = fmul double %t0, %common.ret.op.i
  %t2.i = fptosi double %t11 to i32
  %t7.i = sitofp i32 %t2.i to double
  %t8.i = fsub double %t11, %t7.i
  %t10.i = fcmp ult double %t11, 0.000000e+00
  br i1 %t10.i, label %end49.i, label %if50.i

if50.i:                                           ; preds = %_zen_std_pow.exit
  %t13.i = fcmp ult double %t8.i, 5.000000e-01
  br i1 %t13.i, label %_zen_std_round.exit, label %if52.i

if52.i:                                           ; preds = %if50.i
  %t15.i = add i32 %t2.i, 1
  br label %_zen_std_round.exit

end49.i:                                          ; preds = %_zen_std_pow.exit
  %t18.i3 = fcmp ugt double %t8.i, -5.000000e-01
  br i1 %t18.i3, label %_zen_std_round.exit, label %if54.i

if54.i:                                           ; preds = %end49.i
  %t20.i = add i32 %t2.i, -1
  br label %_zen_std_round.exit

_zen_std_round.exit:                              ; preds = %if50.i, %if52.i, %end49.i, %if54.i
  %common.ret.op.i2 = phi i32 [ %t15.i, %if52.i ], [ %t20.i, %if54.i ], [ %t2.i, %if50.i ], [ %t2.i, %end49.i ]
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
  br i1 %t7.not7, label %whileEnd63, label %whileBody62.preheader

whileBody62.preheader:                            ; preds = %entry
  %common.ret.op.i6 = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t1, i1 false)
  br label %whileBody62

whileBody62:                                      ; preds = %whileBody62.preheader, %whileBody62
  %b.addr.09 = phi i32 [ %t12, %whileBody62 ], [ %common.ret.op.i6, %whileBody62.preheader ]
  %a.addr.08 = phi i32 [ %b.addr.09, %whileBody62 ], [ %common.ret.op.i, %whileBody62.preheader ]
  %t12 = srem i32 %a.addr.08, %b.addr.09
  %t7.not = icmp eq i32 %t12, 0
  br i1 %t7.not, label %whileEnd63, label %whileBody62

whileEnd63:                                       ; preds = %whileBody62, %entry
  %a.addr.0.lcssa = phi i32 [ %common.ret.op.i, %entry ], [ %b.addr.09, %whileBody62 ]
  ret i32 %a.addr.0.lcssa
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define range(i32 0, -2147483647) i32 @_zen_std_lcm(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t4 = icmp eq i32 %t0, 0
  %t6 = icmp eq i32 %t1, 0
  %t2 = select i1 %t4, i1 true, i1 %t6
  br i1 %t2, label %common.ret, label %whileBody62.preheader.i

common.ret:                                       ; preds = %entry, %_zen_std_gcd.exit
  %common.ret.op = phi i32 [ %common.ret.op.i, %_zen_std_gcd.exit ], [ 0, %entry ]
  ret i32 %common.ret.op

whileBody62.preheader.i:                          ; preds = %entry
  %common.ret.op.i.i = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t0, i1 false)
  %common.ret.op.i6.i = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t1, i1 false)
  br label %whileBody62.i

whileBody62.i:                                    ; preds = %whileBody62.i, %whileBody62.preheader.i
  %b.addr.09.i = phi i32 [ %t12.i, %whileBody62.i ], [ %common.ret.op.i6.i, %whileBody62.preheader.i ]
  %a.addr.08.i = phi i32 [ %b.addr.09.i, %whileBody62.i ], [ %common.ret.op.i.i, %whileBody62.preheader.i ]
  %t12.i = srem i32 %a.addr.08.i, %b.addr.09.i
  %t7.not.i = icmp eq i32 %t12.i, 0
  br i1 %t7.not.i, label %_zen_std_gcd.exit, label %whileBody62.i

_zen_std_gcd.exit:                                ; preds = %whileBody62.i
  %t11 = sdiv i32 %t0, %b.addr.09.i
  %t13 = mul i32 %t11, %t1
  %common.ret.op.i = tail call range(i32 0, -2147483647) i32 @llvm.abs.i32(i32 %t13, i1 false)
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_factorial(i32 %t0) local_unnamed_addr #2 {
entry:
  %t2 = icmp slt i32 %t0, 0
  br i1 %t2, label %common.ret, label %end69

common.ret:                                       ; preds = %whileBody74, %end69, %entry
  %common.ret.op = phi double [ -1.000000e+00, %entry ], [ 1.000000e+00, %end69 ], [ %t13, %whileBody74 ]
  ret double %common.ret.op

end69:                                            ; preds = %entry
  %t9.not5 = icmp eq i32 %t0, 0
  br i1 %t9.not5, label %common.ret, label %whileBody74

whileBody74:                                      ; preds = %end69, %whileBody74
  %t5.07 = phi double [ %t13, %whileBody74 ], [ 1.000000e+00, %end69 ]
  %t6.06 = phi i32 [ %t16, %whileBody74 ], [ 1, %end69 ]
  %t12 = sitofp i32 %t6.06 to double
  %t13 = fmul double %t5.07, %t12
  %t16 = add i32 %t6.06, 1
  %t9.not = icmp sgt i32 %t16, %t0
  br i1 %t9.not, label %common.ret, label %whileBody74
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define noundef i1 @_zen_std_isPrime(i32 %t0) local_unnamed_addr #2 {
entry:
  %t2 = icmp slt i32 %t0, 2
  br i1 %t2, label %common.ret, label %end76

common.ret:                                       ; preds = %whileEnd39.i, %whileBody83, %end78, %end76, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %end76 ], [ false, %end78 ], [ %t11.not, %whileBody83 ], [ %t11.not, %whileEnd39.i ]
  ret i1 %common.ret.op

end76:                                            ; preds = %entry
  %t4 = icmp eq i32 %t0, 2
  br i1 %t4, label %common.ret, label %end78

end78:                                            ; preds = %end76
  %0 = and i32 %t0, 1
  %t3.i = icmp eq i32 %0, 0
  br i1 %t3.i, label %common.ret, label %whileCond82

whileCond82:                                      ; preds = %end78, %whileBody83
  %t7.0 = phi i32 [ %t17, %whileBody83 ], [ 3, %end78 ]
  br label %whileCond37.i

whileCond37.i:                                    ; preds = %whileCond82, %whileCond37.i
  %t3.0.i = phi i32 [ %t10.i, %whileCond37.i ], [ 1, %whileCond82 ]
  %t6.i = mul i32 %t3.0.i, %t3.0.i
  %t8.not.i = icmp sgt i32 %t6.i, %t0
  %t10.i = add i32 %t3.0.i, 1
  br i1 %t8.not.i, label %whileEnd39.i, label %whileCond37.i

whileEnd39.i:                                     ; preds = %whileCond37.i
  %t13.i = add i32 %t3.0.i, -1
  %t11.not = icmp sgt i32 %t7.0, %t13.i
  br i1 %t11.not, label %common.ret, label %whileBody83

whileBody83:                                      ; preds = %whileEnd39.i
  %t14 = srem i32 %t0, %t7.0
  %t15 = icmp eq i32 %t14, 0
  %t17 = add i32 %t7.0, 2
  br i1 %t15, label %common.ret, label %whileCond82
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
  br i1 %t5, label %common.ret, label %end87

common.ret:                                       ; preds = %entry, %end87
  %common.ret.op = phi double [ %t12, %end87 ], [ 0.000000e+00, %entry ]
  ret double %common.ret.op

end87:                                            ; preds = %entry
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
  br i1 %t114, label %whileBody93.preheader, label %whileEnd94

whileBody93.preheader:                            ; preds = %entry
  %0 = zext nneg i32 %t7.03 to i64
  br label %whileBody93

whileBody93:                                      ; preds = %whileBody93.preheader, %whileBody93
  %indvars.iv = phi i64 [ %0, %whileBody93.preheader ], [ %indvars.iv.next, %whileBody93 ]
  %t4.05 = phi ptr [ %t6, %whileBody93.preheader ], [ %t19, %whileBody93 ]
  %t15 = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t16 = load i8, ptr %t15, align 1
  %t17 = tail call ptr @_zen_char_to_string(i8 %t16)
  %t19 = tail call ptr @_str_concat(ptr %t4.05, ptr %t17)
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  %t11.not = icmp eq i64 %indvars.iv, 0
  br i1 %t11.not, label %whileEnd94, label %whileBody93

whileEnd94:                                       ; preds = %whileBody93, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t19, %whileBody93 ]
  ret ptr %t4.0.lcssa
}

define i32 @_zen_std_indexOf(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %whileCond97.preheader

whileCond97.preheader:                            ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t15.not12 = icmp slt i32 %t14, 0
  br i1 %t15.not12, label %common.ret, label %whileCond100.preheader.lr.ph

whileCond100.preheader.lr.ph:                     ; preds = %whileCond97.preheader
  %t209 = icmp sgt i32 %t6, 0
  %wide.trip.count = zext nneg i32 %t6 to i64
  br label %whileCond100.preheader

common.ret:                                       ; preds = %whileCond100.preheader, %end105, %whileEnd102, %whileCond97.preheader, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ -1, %whileCond97.preheader ], [ -1, %end105 ], [ %t10.013, %whileEnd102 ], [ 0, %whileCond100.preheader ]
  ret i32 %common.ret.op

whileCond100.preheader:                           ; preds = %whileCond100.preheader.lr.ph, %end105
  %t10.013 = phi i32 [ 0, %whileCond100.preheader.lr.ph ], [ %t44, %end105 ]
  br i1 %t209, label %whileBody101, label %common.ret

whileBody101:                                     ; preds = %whileCond100.preheader, %whileBody101
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody101 ], [ 0, %whileCond100.preheader ]
  %t16.011 = phi i1 [ %spec.select, %whileBody101 ], [ true, %whileCond100.preheader ]
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  %t24 = add i32 %t10.013, %0
  %1 = sext i32 %t24 to i64
  %t25 = getelementptr i8, ptr %t0, i64 %1
  %t26 = load i8, ptr %t25, align 1
  %t27 = tail call ptr @_zen_char_to_string(i8 %t26)
  %t31 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t35 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t27, ptr noundef nonnull dereferenceable(1) %t33)
  %t36.not = icmp eq i32 %t35, 0
  %spec.select = select i1 %t36.not, i1 %t16.011, i1 false
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %whileEnd102, label %whileBody101

whileEnd102:                                      ; preds = %whileBody101
  br i1 %spec.select, label %common.ret, label %end105

end105:                                           ; preds = %whileEnd102
  %t44 = add i32 %t10.013, 1
  %t15.not = icmp sgt i32 %t44, %t14
  br i1 %t15.not, label %common.ret, label %whileCond100.preheader
}

define i32 @_zen_std_lastIndexOf(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %end107

common.ret.loopexit.split.loop.exit:              ; preds = %whileEnd114
  %0 = trunc nuw nsw i64 %indvars.iv18 to i32
  br label %common.ret

common.ret.loopexit.split.loop.exit23:            ; preds = %whileCond112.preheader
  %1 = trunc nuw nsw i64 %indvars.iv18 to i32
  br label %common.ret

common.ret:                                       ; preds = %end117, %common.ret.loopexit.split.loop.exit, %common.ret.loopexit.split.loop.exit23, %end107, %entry
  %common.ret.op = phi i32 [ %t3, %entry ], [ -1, %end107 ], [ %0, %common.ret.loopexit.split.loop.exit ], [ %1, %common.ret.loopexit.split.loop.exit23 ], [ -1, %end117 ]
  ret i32 %common.ret.op

end107:                                           ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t1613 = icmp sgt i32 %t14, -1
  br i1 %t1613, label %whileCond112.preheader.lr.ph, label %common.ret

whileCond112.preheader.lr.ph:                     ; preds = %end107
  %t2110 = icmp sgt i32 %t6, 0
  %2 = zext nneg i32 %t14 to i64
  %wide.trip.count = zext nneg i32 %t6 to i64
  br label %whileCond112.preheader

whileCond112.preheader:                           ; preds = %whileCond112.preheader.lr.ph, %end117
  %indvars.iv18 = phi i64 [ %2, %whileCond112.preheader.lr.ph ], [ %indvars.iv.next19, %end117 ]
  br i1 %t2110, label %whileBody113, label %common.ret.loopexit.split.loop.exit23

whileBody113:                                     ; preds = %whileCond112.preheader, %whileBody113
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody113 ], [ 0, %whileCond112.preheader ]
  %t17.012 = phi i1 [ %spec.select, %whileBody113 ], [ true, %whileCond112.preheader ]
  %3 = add nuw nsw i64 %indvars.iv, %indvars.iv18
  %sext = shl i64 %3, 32
  %4 = ashr exact i64 %sext, 32
  %t26 = getelementptr i8, ptr %t0, i64 %4
  %t27 = load i8, ptr %t26, align 1
  %t28 = tail call ptr @_zen_char_to_string(i8 %t27)
  %t32 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t33 = load i8, ptr %t32, align 1
  %t34 = tail call ptr @_zen_char_to_string(i8 %t33)
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t28, ptr noundef nonnull dereferenceable(1) %t34)
  %t37.not = icmp eq i32 %t36, 0
  %spec.select = select i1 %t37.not, i1 %t17.012, i1 false
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %whileEnd114, label %whileBody113

whileEnd114:                                      ; preds = %whileBody113
  br i1 %spec.select, label %common.ret.loopexit.split.loop.exit, label %end117

end117:                                           ; preds = %whileEnd114
  %indvars.iv.next19 = add nsw i64 %indvars.iv18, -1
  %t16 = icmp sgt i64 %indvars.iv18, 0
  br i1 %t16, label %whileCond112.preheader, label %common.ret
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
  br i1 %or.cond, label %whileBody126.preheader, label %common.ret

common.ret:                                       ; preds = %whileBody126, %entry
  %common.ret.op = phi ptr [ %t18, %entry ], [ %t34, %whileBody126 ]
  ret ptr %common.ret.op

whileBody126.preheader:                           ; preds = %entry
  %0 = zext nneg i32 %spec.store.select to i64
  %wide.trip.count = zext nneg i32 %spec.select to i64
  br label %whileBody126

whileBody126:                                     ; preds = %whileBody126.preheader, %whileBody126
  %indvars.iv = phi i64 [ %0, %whileBody126.preheader ], [ %indvars.iv.next, %whileBody126 ]
  %t19.010 = phi ptr [ %t18, %whileBody126.preheader ], [ %t34, %whileBody126 ]
  %t30 = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t31 = load i8, ptr %t30, align 1
  %t32 = tail call ptr @_zen_char_to_string(i8 %t31)
  %t34 = tail call ptr @_str_concat(ptr %t19.010, ptr %t32)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %common.ret, label %whileBody126
}

define ptr @_zen_std_charAt(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t7 = icmp slt i32 %t1, 0
  %t10 = icmp sge i32 %t1, %t3
  %t5 = select i1 %t7, i1 true, i1 %t10
  br i1 %t5, label %if132, label %end128

common.ret:                                       ; preds = %end128, %if132
  %common.ret.op = phi ptr [ %t12, %if132 ], [ %t17, %end128 ]
  ret ptr %common.ret.op

if132:                                            ; preds = %entry
  %t12 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

end128:                                           ; preds = %entry
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
  br i1 %t10, label %common.ret, label %whileCond135.preheader

whileCond135.preheader:                           ; preds = %entry
  %t16 = sub i32 %t4, %t7
  %t17.not22 = icmp slt i32 %t16, 0
  br i1 %t17.not22, label %common.ret, label %whileCond138.preheader.lr.ph

whileCond138.preheader.lr.ph:                     ; preds = %whileCond135.preheader
  %t2219 = icmp sgt i32 %t7, 0
  %wide.trip.count = zext nneg i32 %t7 to i64
  br label %whileCond138.preheader

common.ret:                                       ; preds = %end143, %whileBody149, %whileCond135.preheader, %whileEnd147, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t65, %whileEnd147 ], [ %t0, %whileCond135.preheader ], [ %t84, %whileBody149 ], [ %t0, %end143 ]
  ret ptr %common.ret.op

whileCond138.preheader:                           ; preds = %whileCond138.preheader.lr.ph, %end143
  %t12.023 = phi i32 [ 0, %whileCond138.preheader.lr.ph ], [ %t91, %end143 ]
  br i1 %t2219, label %whileBody139, label %if144.thread

if144.thread:                                     ; preds = %whileCond138.preheader
  %t4643 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %whileEnd147

whileBody139:                                     ; preds = %whileCond138.preheader, %whileBody139
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody139 ], [ 0, %whileCond138.preheader ]
  %t18.021 = phi i1 [ %spec.select, %whileBody139 ], [ true, %whileCond138.preheader ]
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  %t26 = add i32 %t12.023, %0
  %1 = sext i32 %t26 to i64
  %t27 = getelementptr i8, ptr %t0, i64 %1
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @_zen_char_to_string(i8 %t28)
  %t33 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @_zen_char_to_string(i8 %t34)
  %t37 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t29, ptr noundef nonnull dereferenceable(1) %t35)
  %t38.not = icmp eq i32 %t37, 0
  %spec.select = select i1 %t38.not, i1 %t18.021, i1 false
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %whileEnd140, label %whileBody139

whileEnd140:                                      ; preds = %whileBody139
  br i1 %spec.select, label %if144, label %end143

if144:                                            ; preds = %whileEnd140
  %t46 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t5024 = icmp sgt i32 %t12.023, 0
  br i1 %t5024, label %whileBody146.preheader, label %whileEnd147

whileBody146.preheader:                           ; preds = %if144
  %wide.trip.count37 = zext nneg i32 %t12.023 to i64
  br label %whileBody146

whileBody146:                                     ; preds = %whileBody146.preheader, %whileBody146
  %indvars.iv34 = phi i64 [ 0, %whileBody146.preheader ], [ %indvars.iv.next35, %whileBody146 ]
  %t44.026 = phi ptr [ %t46, %whileBody146.preheader ], [ %t58, %whileBody146 ]
  %t54 = getelementptr i8, ptr %t0, i64 %indvars.iv34
  %t55 = load i8, ptr %t54, align 1
  %t56 = tail call ptr @_zen_char_to_string(i8 %t55)
  %t58 = tail call ptr @_str_concat(ptr %t44.026, ptr %t56)
  %indvars.iv.next35 = add nuw nsw i64 %indvars.iv34, 1
  %exitcond38.not = icmp eq i64 %indvars.iv.next35, %wide.trip.count37
  br i1 %exitcond38.not, label %whileEnd147, label %whileBody146

whileEnd147:                                      ; preds = %whileBody146, %if144.thread, %if144
  %t12.023.lcssa45 = phi i32 [ %t12.023, %if144 ], [ 0, %if144.thread ], [ %t12.023, %whileBody146 ]
  %t44.0.lcssa = phi ptr [ %t46, %if144 ], [ %t4643, %if144.thread ], [ %t58, %whileBody146 ]
  %t65 = tail call ptr @_str_concat(ptr %t44.0.lcssa, ptr %t2)
  %t68 = tail call i32 @strlen(ptr %t2)
  %t72 = add i32 %t12.023.lcssa45, %t7
  %t7628 = icmp slt i32 %t72, %t4
  br i1 %t7628, label %whileBody149.preheader, label %common.ret

whileBody149.preheader:                           ; preds = %whileEnd147
  %2 = sext i32 %t72 to i64
  %3 = sext i32 %t4 to i64
  br label %whileBody149

whileBody149:                                     ; preds = %whileBody149.preheader, %whileBody149
  %indvars.iv39 = phi i64 [ %2, %whileBody149.preheader ], [ %indvars.iv.next40, %whileBody149 ]
  %t44.130 = phi ptr [ %t65, %whileBody149.preheader ], [ %t84, %whileBody149 ]
  %t80 = getelementptr i8, ptr %t0, i64 %indvars.iv39
  %t81 = load i8, ptr %t80, align 1
  %t82 = tail call ptr @_zen_char_to_string(i8 %t81)
  %t84 = tail call ptr @_str_concat(ptr %t44.130, ptr %t82)
  %indvars.iv.next40 = add nsw i64 %indvars.iv39, 1
  %t76 = icmp slt i64 %indvars.iv.next40, %3
  br i1 %t76, label %whileBody149, label %common.ret

end143:                                           ; preds = %whileEnd140
  %t91 = add i32 %t12.023, 1
  %t17.not = icmp sgt i32 %t91, %t16
  br i1 %t17.not, label %common.ret, label %whileCond138.preheader
}

define ptr @_zen_std_replaceAll(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  br i1 %t10, label %common.ret, label %end151

common.ret:                                       ; preds = %end164, %end151, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t14, %end151 ], [ %t66, %end164 ]
  ret ptr %common.ret.op

end151:                                           ; preds = %entry
  %t14 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1816 = icmp sgt i32 %t4, 0
  br i1 %t1816, label %whileBody154.lr.ph, label %common.ret

whileBody154.lr.ph:                               ; preds = %end151
  %t24 = sub i32 %t4, %t7
  %t2813 = icmp sgt i32 %t7, 0
  %wide.trip.count = zext nneg i32 %t7 to i64
  br label %whileBody154

whileBody154:                                     ; preds = %whileBody154.lr.ph, %end164
  %t12.018 = phi ptr [ %t14, %whileBody154.lr.ph ], [ %t66, %end164 ]
  %t15.017 = phi i32 [ 0, %whileBody154.lr.ph ], [ %t15.1, %end164 ]
  %t25.not = icmp sgt i32 %t15.017, %t24
  br i1 %t25.not, label %else166, label %whileCond159.preheader

whileCond159.preheader:                           ; preds = %whileBody154
  br i1 %t2813, label %whileBody160, label %end164

whileBody160:                                     ; preds = %whileCond159.preheader, %whileBody160
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody160 ], [ 0, %whileCond159.preheader ]
  %t19.015 = phi i1 [ %spec.select, %whileBody160 ], [ true, %whileCond159.preheader ]
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  %t32 = add i32 %t15.017, %0
  %1 = sext i32 %t32 to i64
  %t33 = getelementptr i8, ptr %t0, i64 %1
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @_zen_char_to_string(i8 %t34)
  %t39 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t40 = load i8, ptr %t39, align 1
  %t41 = tail call ptr @_zen_char_to_string(i8 %t40)
  %t43 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t35, ptr noundef nonnull dereferenceable(1) %t41)
  %t44.not = icmp eq i32 %t43, 0
  %spec.select = select i1 %t44.not, i1 %t19.015, i1 false
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %end156, label %whileBody160

end156:                                           ; preds = %whileBody160
  br i1 %spec.select, label %end164, label %else166

else166:                                          ; preds = %whileBody154, %end156
  %2 = sext i32 %t15.017 to i64
  %t62 = getelementptr i8, ptr %t0, i64 %2
  %t63 = load i8, ptr %t62, align 1
  %t64 = tail call ptr @_zen_char_to_string(i8 %t63)
  br label %end164

end164:                                           ; preds = %end156, %whileCond159.preheader, %else166
  %t64.sink = phi ptr [ %t64, %else166 ], [ %t2, %whileCond159.preheader ], [ %t2, %end156 ]
  %t7.pn = phi i32 [ 1, %else166 ], [ %t7, %whileCond159.preheader ], [ %t7, %end156 ]
  %t66 = tail call ptr @_str_concat(ptr %t12.018, ptr %t64.sink)
  %t15.1 = add i32 %t7.pn, %t15.017
  %t18 = icmp slt i32 %t15.1, %t4
  br i1 %t18, label %whileBody154, label %common.ret
}

define noundef i1 @_zen_std_contains(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %whileCond169.preheader

whileCond169.preheader:                           ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t15.not11 = icmp slt i32 %t14, 0
  br i1 %t15.not11, label %common.ret, label %whileCond172.preheader.lr.ph

whileCond172.preheader.lr.ph:                     ; preds = %whileCond169.preheader
  %t208 = icmp sgt i32 %t6, 0
  %wide.trip.count = zext nneg i32 %t6 to i64
  br label %whileCond172.preheader

common.ret:                                       ; preds = %whileCond172.preheader, %whileEnd174, %whileCond169, %whileCond169.preheader, %entry
  %common.ret.op = phi i1 [ true, %entry ], [ false, %whileCond169.preheader ], [ true, %whileCond172.preheader ], [ true, %whileEnd174 ], [ false, %whileCond169 ]
  ret i1 %common.ret.op

whileCond169:                                     ; preds = %whileEnd174
  %t43 = add i32 %t10.012, 1
  %t15.not = icmp sgt i32 %t43, %t14
  br i1 %t15.not, label %common.ret, label %whileCond172.preheader

whileCond172.preheader:                           ; preds = %whileCond172.preheader.lr.ph, %whileCond169
  %t10.012 = phi i32 [ 0, %whileCond172.preheader.lr.ph ], [ %t43, %whileCond169 ]
  br i1 %t208, label %whileBody173, label %common.ret

whileBody173:                                     ; preds = %whileCond172.preheader, %whileBody173
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody173 ], [ 0, %whileCond172.preheader ]
  %t16.010 = phi i1 [ %spec.select, %whileBody173 ], [ true, %whileCond172.preheader ]
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  %t24 = add i32 %t10.012, %0
  %1 = sext i32 %t24 to i64
  %t25 = getelementptr i8, ptr %t0, i64 %1
  %t26 = load i8, ptr %t25, align 1
  %t27 = tail call ptr @_zen_char_to_string(i8 %t26)
  %t31 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t35 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t27, ptr noundef nonnull dereferenceable(1) %t33)
  %t36.not = icmp eq i32 %t35, 0
  %spec.select = select i1 %t36.not, i1 %t16.010, i1 false
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %whileEnd174, label %whileBody173

whileEnd174:                                      ; preds = %whileBody173
  br i1 %spec.select, label %common.ret, label %whileCond169
}

define ptr @_zen_std_upperCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t105 = icmp sgt i32 %t2, 0
  br i1 %t105, label %whileBody180.preheader, label %whileEnd181

whileBody180.preheader:                           ; preds = %entry
  %wide.trip.count = zext nneg i32 %t2 to i64
  br label %whileBody180

whileBody180:                                     ; preds = %whileBody180.preheader, %end182
  %indvars.iv = phi i64 [ 0, %whileBody180.preheader ], [ %indvars.iv.next, %end182 ]
  %t4.07 = phi ptr [ %t6, %whileBody180.preheader ], [ %t4.1, %end182 ]
  %t14 = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @_string_to_int_ascii(ptr %t16)
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  tail call void @_zen_string_free(ptr %t24)
  %t25 = tail call i32 @_string_to_int_ascii(ptr %t24)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  tail call void @_zen_string_free(ptr %t29)
  %t30 = tail call i32 @_string_to_int_ascii(ptr %t29)
  %t26 = icmp sge i32 %t19, %t25
  %t31 = icmp sle i32 %t19, %t30
  %t21 = select i1 %t26, i1 %t31, i1 false
  br i1 %t21, label %if186, label %else187

if186:                                            ; preds = %whileBody180
  %t33 = add i32 %t19, -32
  %t34 = tail call ptr @_int_to_string_ascii(i32 %t33)
  %t38 = tail call ptr @_str_concat(ptr %t4.07, ptr %t34)
  tail call void @_zen_string_free(ptr %t34)
  br label %end182

else187:                                          ; preds = %whileBody180
  %t44 = tail call ptr @_str_concat(ptr %t4.07, ptr %t16)
  br label %end182

end182:                                           ; preds = %else187, %if186
  %t4.1 = phi ptr [ %t38, %if186 ], [ %t44, %else187 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  tail call void @_zen_string_free(ptr %t16)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %whileEnd181, label %whileBody180

whileEnd181:                                      ; preds = %end182, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t4.1, %end182 ]
  ret ptr %t4.0.lcssa
}

define ptr @_zen_std_lowerCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t105 = icmp sgt i32 %t2, 0
  br i1 %t105, label %whileBody189.preheader, label %whileEnd190

whileBody189.preheader:                           ; preds = %entry
  %wide.trip.count = zext nneg i32 %t2 to i64
  br label %whileBody189

whileBody189:                                     ; preds = %whileBody189.preheader, %end191
  %indvars.iv = phi i64 [ 0, %whileBody189.preheader ], [ %indvars.iv.next, %end191 ]
  %t4.07 = phi ptr [ %t6, %whileBody189.preheader ], [ %t4.1, %end191 ]
  %t14 = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @_string_to_int_ascii(ptr %t16)
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  tail call void @_zen_string_free(ptr %t24)
  %t25 = tail call i32 @_string_to_int_ascii(ptr %t24)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  tail call void @_zen_string_free(ptr %t29)
  %t30 = tail call i32 @_string_to_int_ascii(ptr %t29)
  %t26 = icmp sge i32 %t19, %t25
  %t31 = icmp sle i32 %t19, %t30
  %t21 = select i1 %t26, i1 %t31, i1 false
  br i1 %t21, label %if195, label %else196

if195:                                            ; preds = %whileBody189
  %t33 = add i32 %t19, 32
  %t34 = tail call ptr @_int_to_string_ascii(i32 %t33)
  %t38 = tail call ptr @_str_concat(ptr %t4.07, ptr %t34)
  tail call void @_zen_string_free(ptr %t34)
  br label %end191

else196:                                          ; preds = %whileBody189
  %t44 = tail call ptr @_str_concat(ptr %t4.07, ptr %t16)
  br label %end191

end191:                                           ; preds = %else196, %if195
  %t4.1 = phi ptr [ %t38, %if195 ], [ %t44, %else196 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  tail call void @_zen_string_free(ptr %t16)
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %whileEnd190, label %whileBody189

whileEnd190:                                      ; preds = %end191, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t4.1, %end191 ]
  ret ptr %t4.0.lcssa
}

define noundef i1 @_zen_std_startsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp sgt i32 %t6, %t3
  br i1 %t10, label %common.ret, label %whileCond199.preheader

whileCond199.preheader:                           ; preds = %entry
  %t145 = icmp sgt i32 %t6, 0
  br i1 %t145, label %whileBody200.preheader, label %common.ret

whileBody200.preheader:                           ; preds = %whileCond199.preheader
  %wide.trip.count = zext nneg i32 %t6 to i64
  br label %whileBody200

common.ret:                                       ; preds = %whileBody200, %whileCond199.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond199.preheader ], [ %t28.not, %whileBody200 ]
  ret i1 %common.ret.op

whileBody200:                                     ; preds = %whileBody200, %whileBody200.preheader
  %indvars.iv = phi i64 [ 0, %whileBody200.preheader ], [ %indvars.iv.next, %whileBody200 ]
  %t17 = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t18 = load i8, ptr %t17, align 1
  %t19 = tail call ptr @_zen_char_to_string(i8 %t18)
  %t23 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t24 = load i8, ptr %t23, align 1
  %t25 = tail call ptr @_zen_char_to_string(i8 %t24)
  %t27 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t19, ptr noundef nonnull dereferenceable(1) %t25)
  %t28.not = icmp eq i32 %t27, 0
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp ne i64 %indvars.iv.next, %wide.trip.count
  %or.cond.not = select i1 %t28.not, i1 %exitcond.not, i1 false
  br i1 %or.cond.not, label %whileBody200, label %common.ret
}

define noundef i1 @_zen_std_endsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp sgt i32 %t6, %t3
  br i1 %t10, label %common.ret, label %whileCond206.preheader

whileCond206.preheader:                           ; preds = %entry
  %t18 = sub i32 %t3, %t6
  %t147 = icmp sgt i32 %t6, 0
  br i1 %t147, label %whileBody207.preheader, label %common.ret

whileBody207.preheader:                           ; preds = %whileCond206.preheader
  %wide.trip.count = zext nneg i32 %t6 to i64
  br label %whileBody207

common.ret:                                       ; preds = %whileBody207, %whileCond206.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond206.preheader ], [ %t32.not, %whileBody207 ]
  ret i1 %common.ret.op

whileBody207:                                     ; preds = %whileBody207, %whileBody207.preheader
  %indvars.iv = phi i64 [ 0, %whileBody207.preheader ], [ %indvars.iv.next, %whileBody207 ]
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  %t20 = add i32 %t18, %0
  %1 = sext i32 %t20 to i64
  %t21 = getelementptr i8, ptr %t0, i64 %1
  %t22 = load i8, ptr %t21, align 1
  %t23 = tail call ptr @_zen_char_to_string(i8 %t22)
  %t27 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @_zen_char_to_string(i8 %t28)
  %t31 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t23, ptr noundef nonnull dereferenceable(1) %t29)
  %t32.not = icmp eq i32 %t31, 0
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp ne i64 %indvars.iv.next, %wide.trip.count
  %or.cond.not = select i1 %t32.not, i1 %exitcond.not, i1 false
  br i1 %or.cond.not, label %whileBody207, label %common.ret
}

define ptr @_zen_std_trim(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t1011 = icmp sgt i32 %t2, 0
  br i1 %t1011, label %whileBody212.preheader, label %whileEnd213

whileBody212.preheader:                           ; preds = %entry
  %wide.trip.count = zext nneg i32 %t2 to i64
  br label %whileBody212

whileBody212:                                     ; preds = %whileBody212.preheader, %if221
  %indvars.iv = phi i64 [ 0, %whileBody212.preheader ], [ %indvars.iv.next, %if221 ]
  %t14 = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t22 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t27 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t23 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t22)
  %t24 = icmp eq i32 %t23, 0
  br i1 %t24, label %if221, label %rhs218

rhs218:                                           ; preds = %whileBody212
  %t28 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t27)
  %t29 = icmp eq i32 %t28, 0
  br i1 %t29, label %if221, label %rhs215

rhs215:                                           ; preds = %rhs218
  %t33 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t32)
  %t34 = icmp eq i32 %t33, 0
  br i1 %t34, label %if221, label %whileEnd213.loopexit.split.loop.exit

if221:                                            ; preds = %whileBody212, %rhs218, %rhs215
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %whileEnd213, label %whileBody212

whileEnd213.loopexit.split.loop.exit:             ; preds = %rhs215
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  br label %whileEnd213

whileEnd213:                                      ; preds = %if221, %whileEnd213.loopexit.split.loop.exit, %entry
  %t4.0.lcssa = phi i32 [ 0, %entry ], [ %0, %whileEnd213.loopexit.split.loop.exit ], [ %t2, %if221 ]
  %t5.014 = add i32 %t2, -1
  %t40.not15 = icmp slt i32 %t5.014, %t4.0.lcssa
  br i1 %t40.not15, label %whileEnd225, label %whileBody224

whileBody224:                                     ; preds = %whileEnd213, %if233
  %t5.016 = phi i32 [ %t5.0, %if233 ], [ %t5.014, %whileEnd213 ]
  %1 = sext i32 %t5.016 to i64
  %t44 = getelementptr i8, ptr %t0, i64 %1
  %t45 = load i8, ptr %t44, align 1
  %t46 = tail call ptr @_zen_char_to_string(i8 %t45)
  %t52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t57 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t53 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t52)
  %t54 = icmp eq i32 %t53, 0
  br i1 %t54, label %if233, label %rhs230

rhs230:                                           ; preds = %whileBody224
  %t58 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t57)
  %t59 = icmp eq i32 %t58, 0
  br i1 %t59, label %if233, label %rhs227

rhs227:                                           ; preds = %rhs230
  %t63 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t62)
  %t64 = icmp eq i32 %t63, 0
  br i1 %t64, label %if233, label %whileEnd225

if233:                                            ; preds = %whileBody224, %rhs230, %rhs227
  %t5.0 = add i32 %t5.016, -1
  %t40.not = icmp slt i32 %t5.0, %t4.0.lcssa
  br i1 %t40.not, label %whileEnd225, label %whileBody224

whileEnd225:                                      ; preds = %if233, %rhs227, %whileEnd213
  %t5.0.lcssa = phi i32 [ %t5.014, %whileEnd213 ], [ %t5.016, %rhs227 ], [ %t5.0, %if233 ]
  %t70 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t75.not19 = icmp sgt i32 %t4.0.lcssa, %t5.0.lcssa
  br i1 %t75.not19, label %whileEnd237, label %whileBody236

whileBody236:                                     ; preds = %whileEnd225, %whileBody236
  %t71.021 = phi i32 [ %t86, %whileBody236 ], [ %t4.0.lcssa, %whileEnd225 ]
  %t68.020 = phi ptr [ %t83, %whileBody236 ], [ %t70, %whileEnd225 ]
  %2 = sext i32 %t71.021 to i64
  %t79 = getelementptr i8, ptr %t0, i64 %2
  %t80 = load i8, ptr %t79, align 1
  %t81 = tail call ptr @_zen_char_to_string(i8 %t80)
  %t83 = tail call ptr @_str_concat(ptr %t68.020, ptr %t81)
  %t86 = add i32 %t71.021, 1
  %t75.not = icmp sgt i32 %t86, %t5.0.lcssa
  br i1 %t75.not, label %whileEnd237, label %whileBody236

whileEnd237:                                      ; preds = %whileBody236, %whileEnd225
  %t68.0.lcssa = phi ptr [ %t70, %whileEnd225 ], [ %t83, %whileBody236 ]
  ret ptr %t68.0.lcssa
}

define ptr @_zen_std_splitAt(ptr %t0, ptr %t1, i32 %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  %t12 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br i1 %t10, label %common.ret, label %end238

common.ret:                                       ; preds = %if252, %entry, %whileEnd242, %end256
  %common.ret.op = phi ptr [ %t88, %end256 ], [ %t15.0.lcssa, %whileEnd242 ], [ %t12, %entry ], [ %t15.022, %if252 ]
  ret ptr %common.ret.op

end238:                                           ; preds = %entry
  %t2021 = icmp sgt i32 %t4, 0
  br i1 %t2021, label %whileBody241.lr.ph, label %whileEnd242

whileBody241.lr.ph:                               ; preds = %end238
  %t26 = sub i32 %t4, %t7
  %t3018 = icmp sgt i32 %t7, 0
  %wide.trip.count = zext nneg i32 %t7 to i64
  br label %whileBody241

whileBody241:                                     ; preds = %whileBody241.lr.ph, %end251
  %t13.024 = phi i32 [ 0, %whileBody241.lr.ph ], [ %t13.1, %end251 ]
  %t14.023 = phi i32 [ 0, %whileBody241.lr.ph ], [ %t14.1, %end251 ]
  %t15.022 = phi ptr [ %t12, %whileBody241.lr.ph ], [ %t15.1, %end251 ]
  %t27.not = icmp sgt i32 %t13.024, %t26
  br i1 %t27.not, label %else253, label %whileCond246.preheader

whileCond246.preheader:                           ; preds = %whileBody241
  br i1 %t3018, label %whileBody247, label %if252

whileBody247:                                     ; preds = %whileCond246.preheader, %whileBody247
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody247 ], [ 0, %whileCond246.preheader ]
  %t21.019 = phi i1 [ %spec.select, %whileBody247 ], [ true, %whileCond246.preheader ]
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  %t34 = add i32 %t13.024, %0
  %1 = sext i32 %t34 to i64
  %t35 = getelementptr i8, ptr %t0, i64 %1
  %t36 = load i8, ptr %t35, align 1
  %t37 = tail call ptr @_zen_char_to_string(i8 %t36)
  %t41 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t42 = load i8, ptr %t41, align 1
  %t43 = tail call ptr @_zen_char_to_string(i8 %t42)
  %t45 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t37, ptr noundef nonnull dereferenceable(1) %t43)
  %t46.not = icmp eq i32 %t45, 0
  %spec.select = select i1 %t46.not, i1 %t21.019, i1 false
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %end243, label %whileBody247

end243:                                           ; preds = %whileBody247
  br i1 %spec.select, label %if252, label %else253

if252:                                            ; preds = %whileCond246.preheader, %end243
  %t55 = icmp eq i32 %t14.023, %t2
  br i1 %t55, label %common.ret, label %end254

end254:                                           ; preds = %if252
  %t58 = add i32 %t14.023, 1
  tail call void @_zen_string_free(ptr %t15.022)
  %t63 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end251

else253:                                          ; preds = %whileBody241, %end243
  %2 = sext i32 %t13.024 to i64
  %t72 = getelementptr i8, ptr %t0, i64 %2
  %t73 = load i8, ptr %t72, align 1
  %t74 = tail call ptr @_zen_char_to_string(i8 %t73)
  %t76 = tail call ptr @_str_concat(ptr %t15.022, ptr %t74)
  br label %end251

end251:                                           ; preds = %else253, %end254
  %t15.1 = phi ptr [ %t63, %end254 ], [ %t76, %else253 ]
  %t14.1 = phi i32 [ %t58, %end254 ], [ %t14.023, %else253 ]
  %t7.pn = phi i32 [ %t7, %end254 ], [ 1, %else253 ]
  %t13.1 = add i32 %t7.pn, %t13.024
  %t20 = icmp slt i32 %t13.1, %t4
  br i1 %t20, label %whileBody241, label %whileEnd242

whileEnd242:                                      ; preds = %end251, %end238
  %t15.0.lcssa = phi ptr [ %t12, %end238 ], [ %t15.1, %end251 ]
  %t14.0.lcssa = phi i32 [ 0, %end238 ], [ %t14.1, %end251 ]
  %t83 = icmp eq i32 %t14.0.lcssa, %t2
  br i1 %t83, label %common.ret, label %end256

end256:                                           ; preds = %whileEnd242
  tail call void @_zen_string_free(ptr %t15.0.lcssa)
  %t88 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret
}

define ptr @_zen_std_repeat(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = icmp slt i32 %t1, 1
  br i1 %t3, label %common.ret.sink.split, label %end258

common.ret.sink.split:                            ; preds = %end258, %entry
  %t10 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

common.ret:                                       ; preds = %whileBody263, %common.ret.sink.split
  %common.ret.op = phi ptr [ %t10, %common.ret.sink.split ], [ %t18, %whileBody263 ]
  ret ptr %common.ret.op

end258:                                           ; preds = %entry
  %t7 = tail call i32 @strlen(ptr %t0)
  %t8 = icmp eq i32 %t7, 0
  br i1 %t8, label %common.ret.sink.split, label %whileBody263.preheader

whileBody263.preheader:                           ; preds = %end258
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %whileBody263

whileBody263:                                     ; preds = %whileBody263.preheader, %whileBody263
  %count.addr.05 = phi i32 [ %t21, %whileBody263 ], [ %t1, %whileBody263.preheader ]
  %t11.04 = phi ptr [ %t18, %whileBody263 ], [ %t13, %whileBody263.preheader ]
  %t18 = tail call ptr @_str_concat(ptr %t11.04, ptr %t0)
  %t21 = add nsw i32 %count.addr.05, -1
  %t15 = icmp samesign ugt i32 %count.addr.05, 1
  br i1 %t15, label %whileBody263, label %common.ret
}

define i32 @_zen_std_count(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t4 = icmp eq i32 %t3, 0
  br i1 %t4, label %common.ret, label %end265

common.ret:                                       ; preds = %_zen_std_charAt.exit, %whileCond269.preheader, %end265, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ 0, %end265 ], [ 0, %whileCond269.preheader ], [ %spec.select, %_zen_std_charAt.exit ]
  ret i32 %common.ret.op

end265:                                           ; preds = %entry
  %t6 = tail call i32 @strlen(ptr %t1)
  %t7 = icmp eq i32 %t6, 0
  br i1 %t7, label %common.ret, label %whileCond269.preheader

whileCond269.preheader:                           ; preds = %end265
  %t124 = tail call i32 @strlen(ptr %t0)
  %t135 = icmp sgt i32 %t124, 0
  br i1 %t135, label %whileBody270, label %common.ret

whileBody270:                                     ; preds = %whileCond269.preheader, %_zen_std_charAt.exit
  %indvars.iv = phi i64 [ %indvars.iv.next, %_zen_std_charAt.exit ], [ 0, %whileCond269.preheader ]
  %t8.07 = phi i32 [ %spec.select, %_zen_std_charAt.exit ], [ 0, %whileCond269.preheader ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %0 = sext i32 %t3.i to i64
  %t10.i.not = icmp slt i64 %indvars.iv, %0
  br i1 %t10.i.not, label %end128.i, label %if132.i

if132.i:                                          ; preds = %whileBody270
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %whileBody270
  %t15.i = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i, %if132.i ], [ %t17.i, %end128.i ]
  %t18 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t1)
  %t19 = icmp eq i32 %t18, 0
  %t21 = zext i1 %t19 to i32
  %spec.select = add i32 %t8.07, %t21
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %t12 = tail call i32 @strlen(ptr %t0)
  %1 = sext i32 %t12 to i64
  %t13 = icmp slt i64 %indvars.iv.next, %1
  br i1 %t13, label %whileBody270, label %common.ret
}

define ptr @_zen_std_padStart(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end274, label %common.ret

common.ret:                                       ; preds = %end274, %entry, %whileEnd280
  %common.ret.op = phi ptr [ %t30, %whileEnd280 ], [ %t0, %entry ], [ %t0, %end274 ]
  ret ptr %common.ret.op

end274:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end276

end276:                                           ; preds = %end274
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t19 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t213 = icmp sgt i32 %t16, 0
  br i1 %t213, label %whileBody279, label %whileEnd280

whileBody279:                                     ; preds = %end276, %whileBody279
  %t12.05 = phi i32 [ %t27, %whileBody279 ], [ %t16, %end276 ]
  %t17.04 = phi ptr [ %t24, %whileBody279 ], [ %t19, %end276 ]
  %t24 = tail call ptr @_str_concat(ptr %t17.04, ptr %t2)
  %t27 = add nsw i32 %t12.05, -1
  %t21 = icmp samesign ugt i32 %t12.05, 1
  br i1 %t21, label %whileBody279, label %whileEnd280

whileEnd280:                                      ; preds = %whileBody279, %end276
  %t17.0.lcssa = phi ptr [ %t19, %end276 ], [ %t24, %whileBody279 ]
  %t30 = tail call ptr @_str_concat(ptr %t17.0.lcssa, ptr %t0)
  br label %common.ret
}

define ptr @_zen_std_padEnd(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end281, label %common.ret

common.ret:                                       ; preds = %whileBody286, %end283, %end281, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t0, %end281 ], [ %t0, %end283 ], [ %t23, %whileBody286 ]
  ret ptr %common.ret.op

end281:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end283

end283:                                           ; preds = %end281
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t203 = icmp sgt i32 %t16, 0
  br i1 %t203, label %whileBody286, label %common.ret

whileBody286:                                     ; preds = %end283, %whileBody286
  %t12.05 = phi i32 [ %t26, %whileBody286 ], [ %t16, %end283 ]
  %t17.04 = phi ptr [ %t23, %whileBody286 ], [ %t0, %end283 ]
  %t23 = tail call ptr @_str_concat(ptr %t17.04, ptr %t2)
  %t26 = add nsw i32 %t12.05, -1
  %t20 = icmp samesign ugt i32 %t12.05, 1
  br i1 %t20, label %whileBody286, label %common.ret
}

define ptr @_zen_std_padCenter(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end288, label %common.ret

common.ret:                                       ; preds = %end288, %entry, %whileEnd297
  %common.ret.op = phi ptr [ %t50, %whileEnd297 ], [ %t0, %entry ], [ %t0, %end288 ]
  ret ptr %common.ret.op

end288:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end290

end290:                                           ; preds = %end288
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t19 = sdiv i32 %t16, 2
  %t23 = sub i32 %t16, %t19
  %t26 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t316 = icmp sgt i32 %t16, 1
  br i1 %t316, label %whileBody293, label %whileCond295.preheader

whileCond295.preheader:                           ; preds = %whileBody293, %end290
  %t24.0.lcssa = phi ptr [ %t26, %end290 ], [ %t34, %whileBody293 ]
  %t399 = icmp sgt i32 %t23, 0
  br i1 %t399, label %whileBody296, label %whileEnd297

whileBody293:                                     ; preds = %end290, %whileBody293
  %t17.08 = phi i32 [ %t37, %whileBody293 ], [ %t19, %end290 ]
  %t24.07 = phi ptr [ %t34, %whileBody293 ], [ %t26, %end290 ]
  %t34 = tail call ptr @_str_concat(ptr %t24.07, ptr %t2)
  %t37 = add nsw i32 %t17.08, -1
  %t31 = icmp sgt i32 %t17.08, 1
  br i1 %t31, label %whileBody293, label %whileCond295.preheader

whileBody296:                                     ; preds = %whileCond295.preheader, %whileBody296
  %t20.011 = phi i32 [ %t45, %whileBody296 ], [ %t23, %whileCond295.preheader ]
  %t27.010 = phi ptr [ %t42, %whileBody296 ], [ %t29, %whileCond295.preheader ]
  %t42 = tail call ptr @_str_concat(ptr %t27.010, ptr %t2)
  %t45 = add nsw i32 %t20.011, -1
  %t39 = icmp samesign ugt i32 %t20.011, 1
  br i1 %t39, label %whileBody296, label %whileEnd297

whileEnd297:                                      ; preds = %whileBody296, %whileCond295.preheader
  %t27.0.lcssa = phi ptr [ %t29, %whileCond295.preheader ], [ %t42, %whileBody296 ]
  %t48 = tail call ptr @_str_concat(ptr %t24.0.lcssa, ptr %t0)
  %t50 = tail call ptr @_str_concat(ptr %t48, ptr %t27.0.lcssa)
  tail call void @_zen_string_free(ptr %t48)
  br label %common.ret
}

define ptr @_zen_std_capitalize(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t3 = icmp eq i32 %t2, 0
  br i1 %t3, label %if299, label %end298

common.ret:                                       ; preds = %whileBody307, %end300, %if299
  %common.ret.op = phi ptr [ %t5, %if299 ], [ %t37, %end300 ], [ %t53, %whileBody307 ]
  ret ptr %common.ret.op

if299:                                            ; preds = %entry
  %t5 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

end298:                                           ; preds = %entry
  %t9 = load i8, ptr %t0, align 1
  %t10 = tail call ptr @_zen_char_to_string(i8 %t9)
  %t13 = tail call i32 @_string_to_int_ascii(ptr %t10)
  %t17 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t21 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  tail call void @_zen_string_free(ptr %t21)
  %t22 = tail call i32 @_string_to_int_ascii(ptr %t21)
  %t26 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  tail call void @_zen_string_free(ptr %t26)
  %t27 = tail call i32 @_string_to_int_ascii(ptr %t26)
  %t23 = icmp sge i32 %t13, %t22
  %t28 = icmp sle i32 %t13, %t27
  %t18 = select i1 %t23, i1 %t28, i1 false
  br i1 %t18, label %if304, label %end300

if304:                                            ; preds = %end298
  %t31 = add i32 %t13, -32
  %t32 = tail call ptr @_int_to_string_ascii(i32 %t31)
  br label %end300

end300:                                           ; preds = %end298, %if304
  %t10.sink = phi ptr [ %t32, %if304 ], [ %t10, %end298 ]
  %t37 = tail call ptr @_str_concat(ptr %t17, ptr %t10.sink)
  %t41 = tail call i32 @strlen(ptr nonnull %t0)
  %t455 = icmp sgt i32 %t41, 1
  br i1 %t455, label %whileBody307.preheader, label %common.ret

whileBody307.preheader:                           ; preds = %end300
  %wide.trip.count = zext nneg i32 %t41 to i64
  br label %whileBody307

whileBody307:                                     ; preds = %whileBody307.preheader, %whileBody307
  %indvars.iv = phi i64 [ 1, %whileBody307.preheader ], [ %indvars.iv.next, %whileBody307 ]
  %t15.17 = phi ptr [ %t37, %whileBody307.preheader ], [ %t53, %whileBody307 ]
  %t49 = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t50 = load i8, ptr %t49, align 1
  %t51 = tail call ptr @_zen_char_to_string(i8 %t50)
  %t53 = tail call ptr @_str_concat(ptr %t15.17, ptr %t51)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %common.ret, label %whileBody307
}

define ptr @_zen_std_extName(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %0 = zext i32 %t2 to i64
  br label %whileCond309

whileCond309:                                     ; preds = %whileBody310, %entry
  %indvars.iv13 = phi i32 [ %indvars.iv.next14, %whileBody310 ], [ %t2, %entry ]
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody310 ], [ %0, %entry ]
  %indvars.iv.next = add nsw i64 %indvars.iv, -1
  %1 = and i64 %indvars.iv.next, 2147483648
  %t8 = icmp eq i64 %1, 0
  br i1 %t8, label %whileBody310, label %whileEnd311

whileBody310:                                     ; preds = %whileCond309
  %t16 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %2 = and i64 %indvars.iv.next, 2147483647
  %t11 = getelementptr i8, ptr %t0, i64 %2
  %t12 = load i8, ptr %t11, align 1
  %t13 = tail call ptr @_zen_char_to_string(i8 %t12)
  %t17 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t13, ptr noundef nonnull dereferenceable(1) %t16)
  %t18 = icmp eq i32 %t17, 0
  %indvars.iv.next14 = add i32 %indvars.iv13, -1
  br i1 %t18, label %if313, label %whileCond309

if313:                                            ; preds = %whileBody310
  %3 = trunc nuw i64 %indvars.iv to i32
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t278 = icmp sgt i32 %t2, %3
  br i1 %t278, label %whileBody315.preheader, label %common.ret

whileBody315.preheader:                           ; preds = %if313
  %4 = sext i32 %indvars.iv13 to i64
  br label %whileBody315

whileBody315:                                     ; preds = %whileBody315.preheader, %whileBody315
  %indvars.iv16 = phi i64 [ %4, %whileBody315.preheader ], [ %indvars.iv.next17, %whileBody315 ]
  %t22.010 = phi ptr [ %t24, %whileBody315.preheader ], [ %t35, %whileBody315 ]
  %t31 = getelementptr i8, ptr %t0, i64 %indvars.iv16
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t35 = tail call ptr @_str_concat(ptr %t22.010, ptr %t33)
  %indvars.iv.next17 = add nsw i64 %indvars.iv16, 1
  %lftr.wideiv = trunc i64 %indvars.iv.next17 to i32
  %exitcond.not = icmp eq i32 %t2, %lftr.wideiv
  br i1 %exitcond.not, label %common.ret, label %whileBody315

common.ret:                                       ; preds = %whileBody315, %if313, %whileEnd311
  %common.ret.op = phi ptr [ %t45, %whileEnd311 ], [ %t24, %if313 ], [ %t35, %whileBody315 ]
  ret ptr %common.ret.op

whileEnd311:                                      ; preds = %whileCond309
  %t45 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @_zen_std_sin(double %t0) local_unnamed_addr #2 {
entry:
  %t2 = load double, ptr @PI, align 8
  %t31 = fcmp ogt double %t0, %t2
  br i1 %t31, label %whileBody318.lr.ph, label %whileCond320.preheader

whileBody318.lr.ph:                               ; preds = %entry
  %t5 = load double, ptr @TAU, align 8
  br label %whileBody318

whileCond320.preheader:                           ; preds = %whileBody318, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t6, %whileBody318 ]
  %t10 = fsub double 0.000000e+00, %t2
  %t114 = fcmp olt double %x.addr.0.lcssa, %t10
  br i1 %t114, label %whileBody321.lr.ph, label %whileEnd322

whileBody321.lr.ph:                               ; preds = %whileCond320.preheader
  %t13 = load double, ptr @TAU, align 8
  br label %whileBody321

whileBody318:                                     ; preds = %whileBody318.lr.ph, %whileBody318
  %x.addr.02 = phi double [ %t0, %whileBody318.lr.ph ], [ %t6, %whileBody318 ]
  %t6 = fsub double %x.addr.02, %t5
  %t3 = fcmp ogt double %t6, %t2
  br i1 %t3, label %whileBody318, label %whileCond320.preheader

whileBody321:                                     ; preds = %whileBody321.lr.ph, %whileBody321
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody321.lr.ph ], [ %t14, %whileBody321 ]
  %t14 = fadd double %x.addr.15, %t13
  %t11 = fcmp olt double %t14, %t10
  br i1 %t11, label %whileBody321, label %whileEnd322

whileEnd322:                                      ; preds = %whileBody321, %whileCond320.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond320.preheader ], [ %t14, %whileBody321 ]
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
  br i1 %t31, label %whileBody324.lr.ph, label %whileCond326.preheader

whileBody324.lr.ph:                               ; preds = %entry
  %t5 = load double, ptr @TAU, align 8
  br label %whileBody324

whileCond326.preheader:                           ; preds = %whileBody324, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t6, %whileBody324 ]
  %t10 = fsub double 0.000000e+00, %t2
  %t114 = fcmp olt double %x.addr.0.lcssa, %t10
  br i1 %t114, label %whileBody327.lr.ph, label %whileEnd328

whileBody327.lr.ph:                               ; preds = %whileCond326.preheader
  %t13 = load double, ptr @TAU, align 8
  br label %whileBody327

whileBody324:                                     ; preds = %whileBody324.lr.ph, %whileBody324
  %x.addr.02 = phi double [ %t0, %whileBody324.lr.ph ], [ %t6, %whileBody324 ]
  %t6 = fsub double %x.addr.02, %t5
  %t3 = fcmp ogt double %t6, %t2
  br i1 %t3, label %whileBody324, label %whileCond326.preheader

whileBody327:                                     ; preds = %whileBody327.lr.ph, %whileBody327
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody327.lr.ph ], [ %t14, %whileBody327 ]
  %t14 = fadd double %x.addr.15, %t13
  %t11 = fcmp olt double %t14, %t10
  br i1 %t11, label %whileBody327, label %whileEnd328

whileEnd328:                                      ; preds = %whileBody327, %whileCond326.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond326.preheader ], [ %t14, %whileBody327 ]
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
  br i1 %t31.i, label %whileBody318.lr.ph.i, label %whileCond320.preheader.i

whileBody318.lr.ph.i:                             ; preds = %entry
  %t5.i = load double, ptr @TAU, align 8
  br label %whileBody318.i

whileCond320.preheader.i:                         ; preds = %whileBody318.i, %entry
  %x.addr.0.lcssa.i = phi double [ %t0, %entry ], [ %t6.i, %whileBody318.i ]
  %t10.i = fsub double 0.000000e+00, %t2.i
  %t114.i = fcmp olt double %x.addr.0.lcssa.i, %t10.i
  br i1 %t114.i, label %whileBody321.lr.ph.i, label %_zen_std_sin.exit

whileBody321.lr.ph.i:                             ; preds = %whileCond320.preheader.i
  %t13.i = load double, ptr @TAU, align 8
  br label %whileBody321.i

whileBody318.i:                                   ; preds = %whileBody318.i, %whileBody318.lr.ph.i
  %x.addr.02.i = phi double [ %t0, %whileBody318.lr.ph.i ], [ %t6.i, %whileBody318.i ]
  %t6.i = fsub double %x.addr.02.i, %t5.i
  %t3.i = fcmp ogt double %t6.i, %t2.i
  br i1 %t3.i, label %whileBody318.i, label %whileCond320.preheader.i

whileBody321.i:                                   ; preds = %whileBody321.i, %whileBody321.lr.ph.i
  %x.addr.15.i = phi double [ %x.addr.0.lcssa.i, %whileBody321.lr.ph.i ], [ %t14.i, %whileBody321.i ]
  %t14.i = fadd double %t13.i, %x.addr.15.i
  %t11.i = fcmp olt double %t14.i, %t10.i
  br i1 %t11.i, label %whileBody321.i, label %_zen_std_sin.exit

_zen_std_sin.exit:                                ; preds = %whileBody321.i, %whileCond320.preheader.i
  %x.addr.1.lcssa.i = phi double [ %x.addr.0.lcssa.i, %whileCond320.preheader.i ], [ %t14.i, %whileBody321.i ]
  br i1 %t31.i, label %whileBody324.lr.ph.i, label %whileCond326.preheader.i

whileBody324.lr.ph.i:                             ; preds = %_zen_std_sin.exit
  %t5.i12 = load double, ptr @TAU, align 8
  br label %whileBody324.i

whileCond326.preheader.i:                         ; preds = %whileBody324.i, %_zen_std_sin.exit
  %x.addr.0.lcssa.i3 = phi double [ %t0, %_zen_std_sin.exit ], [ %t6.i14, %whileBody324.i ]
  %t114.i5 = fcmp olt double %x.addr.0.lcssa.i3, %t10.i
  br i1 %t114.i5, label %whileBody327.lr.ph.i, label %_zen_std_cos.exit

whileBody327.lr.ph.i:                             ; preds = %whileCond326.preheader.i
  %t13.i8 = load double, ptr @TAU, align 8
  br label %whileBody327.i

whileBody324.i:                                   ; preds = %whileBody324.i, %whileBody324.lr.ph.i
  %x.addr.02.i13 = phi double [ %t0, %whileBody324.lr.ph.i ], [ %t6.i14, %whileBody324.i ]
  %t6.i14 = fsub double %x.addr.02.i13, %t5.i12
  %t3.i15 = fcmp ogt double %t6.i14, %t2.i
  br i1 %t3.i15, label %whileBody324.i, label %whileCond326.preheader.i

whileBody327.i:                                   ; preds = %whileBody327.i, %whileBody327.lr.ph.i
  %x.addr.15.i9 = phi double [ %x.addr.0.lcssa.i3, %whileBody327.lr.ph.i ], [ %t14.i10, %whileBody327.i ]
  %t14.i10 = fadd double %t13.i8, %x.addr.15.i9
  %t11.i11 = fcmp olt double %t14.i10, %t10.i
  br i1 %t11.i11, label %whileBody327.i, label %_zen_std_cos.exit

_zen_std_cos.exit:                                ; preds = %whileBody327.i, %whileCond326.preheader.i
  %x.addr.1.lcssa.i6 = phi double [ %x.addr.0.lcssa.i3, %whileCond326.preheader.i ], [ %t14.i10, %whileBody327.i ]
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
  %t0.i = load i32, ptr @SEED, align 8
  %t3.i = load i32, ptr @I32_MAX, align 4
  %t1.i = mul i32 %t0.i, 1103515245
  %t2.i = add i32 %t1.i, 12345
  %t4.i = srem i32 %t2.i, %t3.i
  %t7.i = icmp slt i32 %t4.i, 0
  %t10.i = select i1 %t7.i, i32 %t3.i, i32 0
  %spec.select.i = add i32 %t10.i, %t4.i
  store i32 %spec.select.i, ptr @SEED, align 8
  %t13.i = sitofp i32 %spec.select.i to double
  %t14.i = fdiv double %t13.i, 0x41DFFFFFFFC00000
  %reass.sub = sub i32 %t1, %t0
  %t9 = add i32 %reass.sub, 1
  %t10 = sitofp i32 %t9 to double
  %t11 = fmul double %t14.i, %t10
  %t12 = fptosi double %t11 to i32
  %t13 = add i32 %t0, %t12
  ret i32 %t13
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none)
define double @_zen_std_random() local_unnamed_addr #3 {
entry:
  %t0 = load i32, ptr @SEED, align 8
  %t3 = load i32, ptr @I32_MAX, align 4
  %t1 = mul i32 %t0, 1103515245
  %t2 = add i32 %t1, 12345
  %t4 = srem i32 %t2, %t3
  %t7 = icmp slt i32 %t4, 0
  %t10 = select i1 %t7, i32 %t3, i32 0
  %spec.select = add i32 %t4, %t10
  store i32 %spec.select, ptr @SEED, align 8
  %t13 = sitofp i32 %spec.select to double
  %t14 = fdiv double %t13, 0x41DFFFFFFFC00000
  ret double %t14
}

define i1 @_zen_std_match(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t4320 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t5321 = tail call i1 @_zen_std_contains(ptr %t1, ptr %t4320)
  br i1 %t5321, label %if338, label %whileCond347.preheader

tailrecurse.loopexit:                             ; preds = %end342, %if338
  %t6.0.lcssa = phi ptr [ %t8, %if338 ], [ %t6.1, %end342 ]
  %t4 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t5 = tail call i1 @_zen_std_contains(ptr %t6.0.lcssa, ptr %t4)
  br i1 %t5, label %if338, label %whileCond347.preheader

whileCond347.preheader:                           ; preds = %tailrecurse.loopexit, %entry
  %t1.tr.lcssa = phi ptr [ %t1, %entry ], [ %t6.0.lcssa, %tailrecurse.loopexit ]
  %t43339 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t44340 = icmp sgt i32 %t43339, 0
  br i1 %t44340, label %whileBody348, label %whileEnd349

if338:                                            ; preds = %entry, %tailrecurse.loopexit
  %t1.tr322 = phi ptr [ %t6.0.lcssa, %tailrecurse.loopexit ], [ %t1, %entry ]
  %t8 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t12316 = tail call i32 @strlen(ptr %t1.tr322)
  %t13317 = icmp sgt i32 %t12316, 0
  br i1 %t13317, label %whileBody340, label %tailrecurse.loopexit

whileBody340:                                     ; preds = %if338, %end342
  %indvars.iv = phi i64 [ %indvars.iv.next, %end342 ], [ 0, %if338 ]
  %t6.0319 = phi ptr [ %t6.1, %end342 ], [ %t8, %if338 ]
  %t3.i = tail call i32 @strlen(ptr %t1.tr322)
  %0 = sext i32 %t3.i to i64
  %t10.i.not = icmp slt i64 %indvars.iv, %0
  br i1 %t10.i.not, label %end128.i, label %if132.i

if132.i:                                          ; preds = %whileBody340
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %whileBody340
  %t15.i = getelementptr i8, ptr %t1.tr322, i64 %indvars.iv
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i, %if132.i ], [ %t17.i, %end128.i ]
  %t20 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t21 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t20)
  %t22 = icmp eq i32 %t21, 0
  br i1 %t22, label %if343, label %else344

if343:                                            ; preds = %_zen_std_charAt.exit
  %t25 = tail call i1 @_zen_std_match(ptr %t0, ptr %t6.0319)
  br i1 %t25, label %common.ret, label %end345

common.ret:                                       ; preds = %if343, %_zen_std_charAt.exit274, %_zen_std_charAt.exit125, %_zen_std_charAt.exit298, %end467, %rhs483, %_zen_std_slice.exit229, %rhs391, %if387, %_zen_std_charAt.exit149, %if381, %_zen_std_charAt.exit137, %if375, %rhs370, %if366, %if351, %else481, %whileCond487.backedge, %_zen_std_slice.exit101, %whileCond358, %whileCond414.preheader, %whileCond358.preheader, %rhs429, %if425, %whileEnd416, %end407, %if355, %whileEnd349, %if466, %whileEnd444, %end422
  %common.ret.op = phi i1 [ %t309, %end422 ], [ %t412, %whileEnd444 ], [ %t421, %if466 ], [ %t537, %whileEnd349 ], [ true, %if355 ], [ false, %end407 ], [ false, %whileEnd416 ], [ false, %if425 ], [ false, %rhs429 ], [ false, %whileCond358.preheader ], [ false, %whileCond414.preheader ], [ %t95, %whileCond358 ], [ %t95, %_zen_std_slice.exit101 ], [ false, %whileCond487.backedge ], [ false, %else481 ], [ false, %if351 ], [ false, %if366 ], [ false, %rhs370 ], [ false, %if375 ], [ false, %_zen_std_charAt.exit137 ], [ false, %if381 ], [ false, %_zen_std_charAt.exit149 ], [ false, %if387 ], [ false, %rhs391 ], [ false, %_zen_std_slice.exit229 ], [ false, %rhs483 ], [ false, %end467 ], [ false, %_zen_std_charAt.exit298 ], [ false, %_zen_std_charAt.exit125 ], [ false, %_zen_std_charAt.exit274 ], [ true, %if343 ]
  ret i1 %common.ret.op

end345:                                           ; preds = %if343
  %t27 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end342

else344:                                          ; preds = %_zen_std_charAt.exit
  %t31 = tail call ptr @_str_concat(ptr %t6.0319, ptr nonnull %common.ret.op.i)
  br label %end342

end342:                                           ; preds = %else344, %end345
  %t6.1 = phi ptr [ %t27, %end345 ], [ %t31, %else344 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %t12 = tail call i32 @strlen(ptr %t1.tr322)
  %1 = sext i32 %t12 to i64
  %t13 = icmp slt i64 %indvars.iv.next, %1
  br i1 %t13, label %whileBody340, label %tailrecurse.loopexit

whileBody348:                                     ; preds = %whileCond347.preheader, %whileCond347.backedge
  %t39.0343 = phi i32 [ %t39.0.be, %whileCond347.backedge ], [ 0, %whileCond347.preheader ]
  %t40.0341 = phi i32 [ %t40.0.be, %whileCond347.backedge ], [ 0, %whileCond347.preheader ]
  %t3.i68 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i69 = icmp slt i32 %t40.0341, 0
  %t10.i70 = icmp sge i32 %t40.0341, %t3.i68
  %t5.i71 = select i1 %t7.i69, i1 true, i1 %t10.i70
  br i1 %t5.i71, label %if132.i77, label %end128.i72

if132.i77:                                        ; preds = %whileBody348
  %t12.i78 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit79

end128.i72:                                       ; preds = %whileBody348
  %2 = zext nneg i32 %t40.0341 to i64
  %t15.i73 = getelementptr i8, ptr %t1.tr.lcssa, i64 %2
  %t16.i74 = load i8, ptr %t15.i73, align 1
  %t17.i75 = tail call ptr @_zen_char_to_string(i8 %t16.i74)
  br label %_zen_std_charAt.exit79

_zen_std_charAt.exit79:                           ; preds = %if132.i77, %end128.i72
  %common.ret.op.i76 = phi ptr [ %t12.i78, %if132.i77 ], [ %t17.i75, %end128.i72 ]
  %t51 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_10)
  %t52 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t51)
  %t53 = icmp eq i32 %t52, 0
  br i1 %t53, label %if351, label %end350

if351:                                            ; preds = %_zen_std_charAt.exit79
  %t56 = tail call i32 @strlen(ptr %t0)
  %t57.not = icmp slt i32 %t39.0343, %t56
  br i1 %t57.not, label %end352, label %common.ret

end352:                                           ; preds = %if351
  %t62 = add nsw i32 %t40.0341, 1
  br label %whileCond347.backedge

whileCond347.backedge:                            ; preds = %end352, %end369, %end378, %end384, %end390, %end494, %end498
  %t40.0.be = phi i32 [ %t62, %end352 ], [ %t137, %end369 ], [ %t161, %end378 ], [ %t185, %end384 ], [ %t215, %end390 ], [ %t516, %end494 ], [ %t532, %end498 ]
  %t39.0.be = add i32 %t39.0343, 1
  %t43 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t44 = icmp slt i32 %t40.0.be, %t43
  br i1 %t44, label %whileBody348, label %whileEnd349

end350:                                           ; preds = %_zen_std_charAt.exit79
  %t66 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_11)
  %t67 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t66)
  %t68 = icmp eq i32 %t67, 0
  br i1 %t68, label %if355, label %end354

if355:                                            ; preds = %end350
  %t72 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t70 = add nsw i32 %t40.0341, 1
  %t73.not = icmp slt i32 %t70, %t72
  br i1 %t73.not, label %whileCond358.preheader, label %common.ret

whileCond358.preheader:                           ; preds = %if355
  %t78358 = tail call i32 @strlen(ptr %t0)
  %t79.not359 = icmp sgt i32 %t39.0343, %t78358
  br i1 %t79.not359, label %common.ret, label %whileBody359.lr.ph

whileBody359.lr.ph:                               ; preds = %whileCond358.preheader
  %spec.store.select.i83 = tail call i32 @llvm.smax.i32(i32 %t70, i32 0)
  %3 = zext nneg i32 %spec.store.select.i83 to i64
  br label %whileBody359

whileCond358:                                     ; preds = %_zen_std_slice.exit101
  %t97 = add i32 %t74.0360, 1
  %t78 = tail call i32 @strlen(ptr %t0)
  %t79.not = icmp sgt i32 %t97, %t78
  br i1 %t79.not, label %common.ret, label %whileBody359

whileBody359:                                     ; preds = %whileBody359.lr.ph, %whileCond358
  %t74.0360 = phi i32 [ %t39.0343, %whileBody359.lr.ph ], [ %t97, %whileCond358 ]
  %t83 = tail call i32 @strlen(ptr %t0)
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t74.0360, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t83, i32 %t4.i)
  %t16.i80 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i80, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody126.preheader.i, label %_zen_std_slice.exit

whileBody126.preheader.i:                         ; preds = %whileBody359
  %4 = zext nneg i32 %spec.store.select.i to i64
  %wide.trip.count.i = zext nneg i32 %spec.select.i to i64
  br label %whileBody126.i

whileBody126.i:                                   ; preds = %whileBody126.i, %whileBody126.preheader.i
  %indvars.iv.i = phi i64 [ %4, %whileBody126.preheader.i ], [ %indvars.iv.next.i, %whileBody126.i ]
  %t19.010.i = phi ptr [ %t18.i, %whileBody126.preheader.i ], [ %t34.i, %whileBody126.i ]
  %t30.i = getelementptr i8, ptr %t0, i64 %indvars.iv.i
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %_zen_std_slice.exit, label %whileBody126.i

_zen_std_slice.exit:                              ; preds = %whileBody126.i, %whileBody359
  %common.ret.op.i81 = phi ptr [ %t18.i, %whileBody359 ], [ %t34.i, %whileBody126.i ]
  %t90 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t4.i82 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %spec.select.i84 = tail call i32 @llvm.smin.i32(i32 %t90, i32 %t4.i82)
  %t16.i85 = icmp sle i32 %spec.store.select.i83, %spec.select.i84
  %t18.i86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i87 = icmp samesign ult i32 %spec.store.select.i83, %spec.select.i84
  %or.cond.i88 = select i1 %t16.i85, i1 %t268.i87, i1 false
  br i1 %or.cond.i88, label %whileBody126.preheader.i90, label %_zen_std_slice.exit101

whileBody126.preheader.i90:                       ; preds = %_zen_std_slice.exit
  %wide.trip.count.i91 = zext nneg i32 %spec.select.i84 to i64
  br label %whileBody126.i92

whileBody126.i92:                                 ; preds = %whileBody126.i92, %whileBody126.preheader.i90
  %indvars.iv.i93 = phi i64 [ %3, %whileBody126.preheader.i90 ], [ %indvars.iv.next.i99, %whileBody126.i92 ]
  %t19.010.i94 = phi ptr [ %t18.i86, %whileBody126.preheader.i90 ], [ %t34.i98, %whileBody126.i92 ]
  %t30.i95 = getelementptr i8, ptr %t1.tr.lcssa, i64 %indvars.iv.i93
  %t31.i96 = load i8, ptr %t30.i95, align 1
  %t32.i97 = tail call ptr @_zen_char_to_string(i8 %t31.i96)
  %t34.i98 = tail call ptr @_str_concat(ptr %t19.010.i94, ptr %t32.i97)
  %indvars.iv.next.i99 = add nuw nsw i64 %indvars.iv.i93, 1
  %exitcond.not.i100 = icmp eq i64 %indvars.iv.next.i99, %wide.trip.count.i91
  br i1 %exitcond.not.i100, label %_zen_std_slice.exit101, label %whileBody126.i92

_zen_std_slice.exit101:                           ; preds = %whileBody126.i92, %_zen_std_slice.exit
  %common.ret.op.i89 = phi ptr [ %t18.i86, %_zen_std_slice.exit ], [ %t34.i98, %whileBody126.i92 ]
  %t95 = tail call i1 @_zen_std_match(ptr %common.ret.op.i81, ptr %common.ret.op.i89)
  br i1 %t95, label %common.ret, label %whileCond358

end354:                                           ; preds = %end350
  %t101 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_12)
  %t102 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t101)
  %t103 = icmp eq i32 %t102, 0
  br i1 %t103, label %if364, label %end363

if364:                                            ; preds = %end354
  %t106 = add nsw i32 %t40.0341, 1
  %t3.i102 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i103 = icmp slt i32 %t40.0341, -1
  %t10.i104 = icmp sge i32 %t106, %t3.i102
  %t5.i105 = select i1 %t7.i103, i1 true, i1 %t10.i104
  br i1 %t5.i105, label %if132.i111, label %end128.i106

if132.i111:                                       ; preds = %if364
  %t12.i112 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit113

end128.i106:                                      ; preds = %if364
  %5 = zext nneg i32 %t106 to i64
  %t15.i107 = getelementptr i8, ptr %t1.tr.lcssa, i64 %5
  %t16.i108 = load i8, ptr %t15.i107, align 1
  %t17.i109 = tail call ptr @_zen_char_to_string(i8 %t16.i108)
  br label %_zen_std_charAt.exit113

_zen_std_charAt.exit113:                          ; preds = %if132.i111, %end128.i106
  %common.ret.op.i110 = phi ptr [ %t12.i112, %if132.i111 ], [ %t17.i109, %end128.i106 ]
  %t111 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_13)
  %t112 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i110, ptr noundef nonnull dereferenceable(1) %t111)
  %t113 = icmp eq i32 %t112, 0
  br i1 %t113, label %if366, label %end365

if366:                                            ; preds = %_zen_std_charAt.exit113
  %t116 = tail call i32 @strlen(ptr %t0)
  %t117.not = icmp slt i32 %t39.0343, %t116
  br i1 %t117.not, label %end367, label %common.ret

end367:                                           ; preds = %if366
  %t3.i114 = tail call i32 @strlen(ptr %t0)
  %t7.i115 = icmp slt i32 %t39.0343, 0
  %t10.i116 = icmp sge i32 %t39.0343, %t3.i114
  %t5.i117 = select i1 %t7.i115, i1 true, i1 %t10.i116
  br i1 %t5.i117, label %if132.i123, label %end128.i118

if132.i123:                                       ; preds = %end367
  %t12.i124 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit125

end128.i118:                                      ; preds = %end367
  %6 = zext nneg i32 %t39.0343 to i64
  %t15.i119 = getelementptr i8, ptr %t0, i64 %6
  %t16.i120 = load i8, ptr %t15.i119, align 1
  %t17.i121 = tail call ptr @_zen_char_to_string(i8 %t16.i120)
  br label %_zen_std_charAt.exit125

_zen_std_charAt.exit125:                          ; preds = %if132.i123, %end128.i118
  %common.ret.op.i122 = phi ptr [ %t12.i124, %if132.i123 ], [ %t17.i121, %end128.i118 ]
  %t125 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t130 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t126 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i122, ptr noundef nonnull dereferenceable(1) %t125)
  %t127 = icmp slt i32 %t126, 0
  br i1 %t127, label %common.ret, label %rhs370

rhs370:                                           ; preds = %_zen_std_charAt.exit125
  %t131 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i122, ptr noundef nonnull dereferenceable(1) %t130)
  %t132 = icmp sgt i32 %t131, 0
  br i1 %t132, label %common.ret, label %end369

end369:                                           ; preds = %rhs370
  %t137 = add i32 %t40.0341, 2
  br label %whileCond347.backedge

end365:                                           ; preds = %_zen_std_charAt.exit113
  %t141 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t142 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i110, ptr noundef nonnull dereferenceable(1) %t141)
  %t143 = icmp eq i32 %t142, 0
  br i1 %t143, label %if375, label %end374

if375:                                            ; preds = %end365
  %t146 = tail call i32 @strlen(ptr %t0)
  %t147.not = icmp slt i32 %t39.0343, %t146
  br i1 %t147.not, label %end376, label %common.ret

end376:                                           ; preds = %if375
  %t3.i126 = tail call i32 @strlen(ptr %t0)
  %t7.i127 = icmp slt i32 %t39.0343, 0
  %t10.i128 = icmp sge i32 %t39.0343, %t3.i126
  %t5.i129 = select i1 %t7.i127, i1 true, i1 %t10.i128
  br i1 %t5.i129, label %if132.i135, label %end128.i130

if132.i135:                                       ; preds = %end376
  %t12.i136 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit137

end128.i130:                                      ; preds = %end376
  %7 = zext nneg i32 %t39.0343 to i64
  %t15.i131 = getelementptr i8, ptr %t0, i64 %7
  %t16.i132 = load i8, ptr %t15.i131, align 1
  %t17.i133 = tail call ptr @_zen_char_to_string(i8 %t16.i132)
  br label %_zen_std_charAt.exit137

_zen_std_charAt.exit137:                          ; preds = %if132.i135, %end128.i130
  %common.ret.op.i134 = phi ptr [ %t12.i136, %if132.i135 ], [ %t17.i133, %end128.i130 ]
  %t153 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_16)
  %t155 = tail call i1 @_zen_std_contains(ptr %t153, ptr %common.ret.op.i134)
  br i1 %t155, label %end378, label %common.ret

end378:                                           ; preds = %_zen_std_charAt.exit137
  %t161 = add i32 %t40.0341, 2
  br label %whileCond347.backedge

end374:                                           ; preds = %end365
  %t165 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_17)
  %t166 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i110, ptr noundef nonnull dereferenceable(1) %t165)
  %t167 = icmp eq i32 %t166, 0
  br i1 %t167, label %if381, label %end380

if381:                                            ; preds = %end374
  %t170 = tail call i32 @strlen(ptr %t0)
  %t171.not = icmp slt i32 %t39.0343, %t170
  br i1 %t171.not, label %end382, label %common.ret

end382:                                           ; preds = %if381
  %t3.i138 = tail call i32 @strlen(ptr %t0)
  %t7.i139 = icmp slt i32 %t39.0343, 0
  %t10.i140 = icmp sge i32 %t39.0343, %t3.i138
  %t5.i141 = select i1 %t7.i139, i1 true, i1 %t10.i140
  br i1 %t5.i141, label %if132.i147, label %end128.i142

if132.i147:                                       ; preds = %end382
  %t12.i148 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit149

end128.i142:                                      ; preds = %end382
  %8 = zext nneg i32 %t39.0343 to i64
  %t15.i143 = getelementptr i8, ptr %t0, i64 %8
  %t16.i144 = load i8, ptr %t15.i143, align 1
  %t17.i145 = tail call ptr @_zen_char_to_string(i8 %t16.i144)
  br label %_zen_std_charAt.exit149

_zen_std_charAt.exit149:                          ; preds = %if132.i147, %end128.i142
  %common.ret.op.i146 = phi ptr [ %t12.i148, %if132.i147 ], [ %t17.i145, %end128.i142 ]
  %t177 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_18)
  %t179 = tail call i1 @_zen_std_contains(ptr %t177, ptr %common.ret.op.i146)
  br i1 %t179, label %end384, label %common.ret

end384:                                           ; preds = %_zen_std_charAt.exit149
  %t185 = add i32 %t40.0341, 2
  br label %whileCond347.backedge

end380:                                           ; preds = %end374
  %t189 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_19)
  %t190 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i110, ptr noundef nonnull dereferenceable(1) %t189)
  %t191 = icmp eq i32 %t190, 0
  br i1 %t191, label %if387, label %end363

if387:                                            ; preds = %end380
  %t194 = tail call i32 @strlen(ptr %t0)
  %t195.not = icmp slt i32 %t39.0343, %t194
  br i1 %t195.not, label %end388, label %common.ret

end388:                                           ; preds = %if387
  %t3.i150 = tail call i32 @strlen(ptr %t0)
  %t7.i151 = icmp slt i32 %t39.0343, 0
  %t10.i152 = icmp sge i32 %t39.0343, %t3.i150
  %t5.i153 = select i1 %t7.i151, i1 true, i1 %t10.i152
  br i1 %t5.i153, label %if132.i159, label %end128.i154

if132.i159:                                       ; preds = %end388
  %t12.i160 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit161

end128.i154:                                      ; preds = %end388
  %9 = zext nneg i32 %t39.0343 to i64
  %t15.i155 = getelementptr i8, ptr %t0, i64 %9
  %t16.i156 = load i8, ptr %t15.i155, align 1
  %t17.i157 = tail call ptr @_zen_char_to_string(i8 %t16.i156)
  br label %_zen_std_charAt.exit161

_zen_std_charAt.exit161:                          ; preds = %if132.i159, %end128.i154
  %common.ret.op.i158 = phi ptr [ %t12.i160, %if132.i159 ], [ %t17.i157, %end128.i154 ]
  %t203 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t208 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t204 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i158, ptr noundef nonnull dereferenceable(1) %t203)
  %t205.not = icmp eq i32 %t204, 0
  br i1 %t205.not, label %end390, label %rhs391

rhs391:                                           ; preds = %_zen_std_charAt.exit161
  %t209 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i158, ptr noundef nonnull dereferenceable(1) %t208)
  %t210.not = icmp eq i32 %t209, 0
  br i1 %t210.not, label %end390, label %common.ret

end390:                                           ; preds = %_zen_std_charAt.exit161, %rhs391
  %t215 = add i32 %t40.0341, 2
  br label %whileCond347.backedge

end363:                                           ; preds = %end380, %end354
  %t219 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_20)
  %t220 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t219)
  %t221 = icmp eq i32 %t220, 0
  br i1 %t221, label %if396, label %end395

if396:                                            ; preds = %end363
  %t224 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t229324 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t230325 = icmp slt i32 %t40.0341, %t229324
  br i1 %t230325, label %whileBody398, label %whileEnd399

whileBody398:                                     ; preds = %if396, %end400
  %t222.0327 = phi ptr [ %t248, %end400 ], [ %t224, %if396 ]
  %t225.0326 = phi i32 [ %t251, %end400 ], [ %t40.0341, %if396 ]
  %t3.i162 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i163 = icmp slt i32 %t225.0326, 0
  %t10.i164 = icmp sge i32 %t225.0326, %t3.i162
  %t5.i165 = select i1 %t7.i163, i1 true, i1 %t10.i164
  br i1 %t5.i165, label %if132.i171, label %end128.i166

if132.i171:                                       ; preds = %whileBody398
  %t12.i172 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit173

end128.i166:                                      ; preds = %whileBody398
  %10 = zext nneg i32 %t225.0326 to i64
  %t15.i167 = getelementptr i8, ptr %t1.tr.lcssa, i64 %10
  %t16.i168 = load i8, ptr %t15.i167, align 1
  %t17.i169 = tail call ptr @_zen_char_to_string(i8 %t16.i168)
  br label %_zen_std_charAt.exit173

_zen_std_charAt.exit173:                          ; preds = %if132.i171, %end128.i166
  %common.ret.op.i170 = phi ptr [ %t12.i172, %if132.i171 ], [ %t17.i169, %end128.i166 ]
  %t238 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t243 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t239 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i170, ptr noundef nonnull dereferenceable(1) %t238)
  %t240 = icmp eq i32 %t239, 0
  br i1 %t240, label %whileEnd399, label %rhs401

rhs401:                                           ; preds = %_zen_std_charAt.exit173
  %t244 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i170, ptr noundef nonnull dereferenceable(1) %t243)
  %t245 = icmp eq i32 %t244, 0
  br i1 %t245, label %whileEnd399, label %end400

end400:                                           ; preds = %rhs401
  %t248 = tail call ptr @_str_concat(ptr %t222.0327, ptr nonnull %common.ret.op.i170)
  %t251 = add nsw i32 %t225.0326, 1
  %t229 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t230 = icmp slt i32 %t251, %t229
  br i1 %t230, label %whileBody398, label %whileEnd399

whileEnd399:                                      ; preds = %end400, %rhs401, %_zen_std_charAt.exit173, %if396
  %t222.0.lcssa = phi ptr [ %t224, %if396 ], [ %t222.0327, %_zen_std_charAt.exit173 ], [ %t222.0327, %rhs401 ], [ %t248, %end400 ]
  %t255 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_21)
  %t256 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t222.0.lcssa, ptr noundef nonnull dereferenceable(1) %t255)
  %t257 = icmp eq i32 %t256, 0
  br i1 %t257, label %if406, label %end405

if406:                                            ; preds = %whileEnd399
  %t263 = tail call i32 @strlen(ptr %t0)
  %t269 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_22)
  %t264 = icmp slt i32 %t39.0343, %t263
  br i1 %t264, label %rhs408, label %end407

rhs408:                                           ; preds = %if406
  %t267 = tail call ptr @_zen_std_charAt(ptr %t0, i32 %t39.0343)
  %t270 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t267, ptr noundef nonnull dereferenceable(1) %t269)
  %t271 = icmp eq i32 %t270, 0
  %t273 = zext i1 %t271 to i32
  %spec.select = add nsw i32 %t39.0343, %t273
  br label %end407

end407:                                           ; preds = %rhs408, %if406
  %t39.1 = phi i32 [ %t39.0343, %if406 ], [ %spec.select, %rhs408 ]
  %t277 = tail call i32 @strlen(ptr %t0)
  %t278.not = icmp slt i32 %t39.1, %t277
  br i1 %t278.not, label %whileCond414.preheader, label %common.ret

whileCond414.preheader:                           ; preds = %end407
  %t283352 = tail call i32 @strlen(ptr %t0)
  %t284353 = icmp slt i32 %t39.1, %t283352
  br i1 %t284353, label %whileBody415, label %common.ret

whileBody415:                                     ; preds = %whileCond414.preheader, %end417
  %t39.2354 = phi i32 [ %t301, %end417 ], [ %t39.1, %whileCond414.preheader ]
  %t3.i174 = tail call i32 @strlen(ptr %t0)
  %t7.i175 = icmp slt i32 %t39.2354, 0
  %t10.i176 = icmp sge i32 %t39.2354, %t3.i174
  %t5.i177 = select i1 %t7.i175, i1 true, i1 %t10.i176
  br i1 %t5.i177, label %if132.i183, label %end128.i178

if132.i183:                                       ; preds = %whileBody415
  %t12.i184 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit185

end128.i178:                                      ; preds = %whileBody415
  %11 = zext nneg i32 %t39.2354 to i64
  %t15.i179 = getelementptr i8, ptr %t0, i64 %11
  %t16.i180 = load i8, ptr %t15.i179, align 1
  %t17.i181 = tail call ptr @_zen_char_to_string(i8 %t16.i180)
  br label %_zen_std_charAt.exit185

_zen_std_charAt.exit185:                          ; preds = %if132.i183, %end128.i178
  %common.ret.op.i182 = phi ptr [ %t12.i184, %if132.i183 ], [ %t17.i181, %end128.i178 ]
  %t292 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t297 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t293 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i182, ptr noundef nonnull dereferenceable(1) %t292)
  %t294 = icmp slt i32 %t293, 0
  br i1 %t294, label %whileEnd416, label %rhs418

rhs418:                                           ; preds = %_zen_std_charAt.exit185
  %t298 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i182, ptr noundef nonnull dereferenceable(1) %t297)
  %t299 = icmp sgt i32 %t298, 0
  br i1 %t299, label %whileEnd416, label %end417

end417:                                           ; preds = %rhs418
  %t301 = add nsw i32 %t39.2354, 1
  %t283 = tail call i32 @strlen(ptr %t0)
  %t284 = icmp slt i32 %t301, %t283
  br i1 %t284, label %whileBody415, label %whileEnd416

whileEnd416:                                      ; preds = %end417, %rhs418, %_zen_std_charAt.exit185
  %t39.2.lcssa = phi i32 [ %t301, %end417 ], [ %t39.2354, %rhs418 ], [ %t39.2354, %_zen_std_charAt.exit185 ]
  %t305.not = icmp sgt i32 %t39.2.lcssa, %t39.1
  br i1 %t305.not, label %end422, label %common.ret

end422:                                           ; preds = %whileEnd416
  %t308 = tail call i32 @strlen(ptr %t0)
  %t309 = icmp eq i32 %t39.2.lcssa, %t308
  br label %common.ret

end405:                                           ; preds = %whileEnd399
  %t312 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_23)
  %t313 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t222.0.lcssa, ptr noundef nonnull dereferenceable(1) %t312)
  %t314 = icmp eq i32 %t313, 0
  br i1 %t314, label %if425, label %end424

if425:                                            ; preds = %end405
  %t317 = tail call i32 @strlen(ptr %t0)
  %t318.not = icmp slt i32 %t39.0343, %t317
  br i1 %t318.not, label %end426, label %common.ret

end426:                                           ; preds = %if425
  %t321 = tail call ptr @_zen_std_charAt(ptr %t0, i32 %t39.0343)
  %t328 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t333 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t339 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t344 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t349 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_24)
  %t329 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t328)
  %t330 = icmp sgt i32 %t329, -1
  br i1 %t330, label %rhs435, label %rhs432

rhs435:                                           ; preds = %end426
  %t334 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t333)
  %t335 = icmp slt i32 %t334, 1
  br i1 %t335, label %end428, label %rhs432

rhs432:                                           ; preds = %end426, %rhs435
  %t340 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t339)
  %t341 = icmp sgt i32 %t340, -1
  br i1 %t341, label %rhs438, label %rhs429

rhs438:                                           ; preds = %rhs432
  %t345 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t344)
  %t346 = icmp slt i32 %t345, 1
  br i1 %t346, label %end428, label %rhs429

rhs429:                                           ; preds = %rhs432, %rhs438
  %t350 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t321, ptr noundef nonnull dereferenceable(1) %t349)
  %t351.not = icmp eq i32 %t350, 0
  br i1 %t351.not, label %end428, label %common.ret

end428:                                           ; preds = %rhs435, %rhs438, %rhs429
  %t39.3345 = add nsw i32 %t39.0343, 1
  %t358346 = tail call i32 @strlen(ptr %t0)
  %t359347 = icmp slt i32 %t39.3345, %t358346
  br i1 %t359347, label %whileBody443, label %whileEnd444

whileBody443:                                     ; preds = %end428, %end445
  %t39.3349 = phi i32 [ %t39.3, %end445 ], [ %t39.3345, %end428 ]
  %t39.3.in348 = phi i32 [ %t39.3349, %end445 ], [ %t39.0343, %end428 ]
  %t3.i186 = tail call i32 @strlen(ptr %t0)
  %t7.i187 = icmp slt i32 %t39.3.in348, -1
  %t10.i188 = icmp sge i32 %t39.3349, %t3.i186
  %t5.i189 = select i1 %t7.i187, i1 true, i1 %t10.i188
  br i1 %t5.i189, label %if132.i195, label %end128.i190

if132.i195:                                       ; preds = %whileBody443
  %t12.i196 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit197

end128.i190:                                      ; preds = %whileBody443
  %12 = zext nneg i32 %t39.3349 to i64
  %t15.i191 = getelementptr i8, ptr %t0, i64 %12
  %t16.i192 = load i8, ptr %t15.i191, align 1
  %t17.i193 = tail call ptr @_zen_char_to_string(i8 %t16.i192)
  br label %_zen_std_charAt.exit197

_zen_std_charAt.exit197:                          ; preds = %if132.i195, %end128.i190
  %common.ret.op.i194 = phi ptr [ %t12.i196, %if132.i195 ], [ %t17.i193, %end128.i190 ]
  %t370 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t375 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t381 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t386 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t392 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t397 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t402 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_24)
  %t371 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t370)
  %t372 = icmp sgt i32 %t371, -1
  br i1 %t372, label %rhs455, label %rhs452

rhs455:                                           ; preds = %_zen_std_charAt.exit197
  %t376 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t375)
  %t377 = icmp slt i32 %t376, 1
  br i1 %t377, label %end445, label %rhs452

rhs452:                                           ; preds = %_zen_std_charAt.exit197, %rhs455
  %t382 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t381)
  %t383 = icmp sgt i32 %t382, -1
  br i1 %t383, label %rhs458, label %rhs449

rhs458:                                           ; preds = %rhs452
  %t387 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t386)
  %t388 = icmp slt i32 %t387, 1
  br i1 %t388, label %end445, label %rhs449

rhs449:                                           ; preds = %rhs452, %rhs458
  %t393 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t392)
  %t394 = icmp sgt i32 %t393, -1
  br i1 %t394, label %rhs461, label %rhs446

rhs461:                                           ; preds = %rhs449
  %t398 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t397)
  %t399 = icmp slt i32 %t398, 1
  br i1 %t399, label %end445, label %rhs446

rhs446:                                           ; preds = %rhs449, %rhs461
  %t403 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t402)
  %t404.not = icmp eq i32 %t403, 0
  br i1 %t404.not, label %end445, label %whileEnd444

end445:                                           ; preds = %rhs455, %rhs458, %rhs461, %rhs446
  %t39.3 = add nsw i32 %t39.3349, 1
  %t358 = tail call i32 @strlen(ptr %t0)
  %t359 = icmp slt i32 %t39.3, %t358
  br i1 %t359, label %whileBody443, label %whileEnd444

whileEnd444:                                      ; preds = %end445, %rhs446, %end428
  %t39.3.lcssa = phi i32 [ %t39.3345, %end428 ], [ %t39.3349, %rhs446 ], [ %t39.3, %end445 ]
  %t411 = tail call i32 @strlen(ptr %t0)
  %t412 = icmp eq i32 %t39.3.lcssa, %t411
  br label %common.ret

end424:                                           ; preds = %end405
  %t415 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_25)
  %t416 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t222.0.lcssa, ptr noundef nonnull dereferenceable(1) %t415)
  %t417 = icmp eq i32 %t416, 0
  br i1 %t417, label %if466, label %end395

if466:                                            ; preds = %end424
  %t420 = tail call i32 @strlen(ptr %t0)
  %t421 = icmp slt i32 %t39.0343, %t420
  br label %common.ret

end395:                                           ; preds = %end424, %end363
  %t424 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t425 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t424)
  %t426 = icmp eq i32 %t425, 0
  br i1 %t426, label %if468, label %end467

if468:                                            ; preds = %end395
  %t429 = add i32 %t40.0341, 1
  %t432331 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t433332 = icmp slt i32 %t429, %t432331
  br i1 %t433332, label %whileBody470, label %whileEnd471

whileBody470:                                     ; preds = %if468, %end472
  %t427.0333 = phi i32 [ %t442, %end472 ], [ %t429, %if468 ]
  %t438 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i198 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i199 = icmp slt i32 %t427.0333, 0
  %t10.i200 = icmp sge i32 %t427.0333, %t3.i198
  %t5.i201 = select i1 %t7.i199, i1 true, i1 %t10.i200
  br i1 %t5.i201, label %if132.i207, label %end128.i202

if132.i207:                                       ; preds = %whileBody470
  %t12.i208 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit209

end128.i202:                                      ; preds = %whileBody470
  %13 = zext nneg i32 %t427.0333 to i64
  %t15.i203 = getelementptr i8, ptr %t1.tr.lcssa, i64 %13
  %t16.i204 = load i8, ptr %t15.i203, align 1
  %t17.i205 = tail call ptr @_zen_char_to_string(i8 %t16.i204)
  br label %_zen_std_charAt.exit209

_zen_std_charAt.exit209:                          ; preds = %if132.i207, %end128.i202
  %common.ret.op.i206 = phi ptr [ %t12.i208, %if132.i207 ], [ %t17.i205, %end128.i202 ]
  %t439 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i206, ptr noundef nonnull dereferenceable(1) %t438)
  %t440 = icmp eq i32 %t439, 0
  br i1 %t440, label %whileEnd471, label %end472

end472:                                           ; preds = %_zen_std_charAt.exit209
  %t442 = add nsw i32 %t427.0333, 1
  %t432 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t433 = icmp slt i32 %t442, %t432
  br i1 %t433, label %whileBody470, label %whileEnd471

whileEnd471:                                      ; preds = %end472, %_zen_std_charAt.exit209, %if468
  %t427.0.lcssa = phi i32 [ %t429, %if468 ], [ %t427.0333, %_zen_std_charAt.exit209 ], [ %t442, %end472 ]
  %t4.i210 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %spec.store.select.i211 = tail call i32 @llvm.smax.i32(i32 %t429, i32 0)
  %spec.select.i212 = tail call i32 @llvm.smin.i32(i32 %t427.0.lcssa, i32 %t4.i210)
  %t16.i213 = icmp sle i32 %spec.store.select.i211, %spec.select.i212
  %t18.i214 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i215 = icmp samesign ult i32 %spec.store.select.i211, %spec.select.i212
  %or.cond.i216 = select i1 %t16.i213, i1 %t268.i215, i1 false
  br i1 %or.cond.i216, label %whileBody126.preheader.i218, label %_zen_std_slice.exit229

whileBody126.preheader.i218:                      ; preds = %whileEnd471
  %14 = zext nneg i32 %spec.store.select.i211 to i64
  %wide.trip.count.i219 = zext nneg i32 %spec.select.i212 to i64
  br label %whileBody126.i220

whileBody126.i220:                                ; preds = %whileBody126.i220, %whileBody126.preheader.i218
  %indvars.iv.i221 = phi i64 [ %14, %whileBody126.preheader.i218 ], [ %indvars.iv.next.i227, %whileBody126.i220 ]
  %t19.010.i222 = phi ptr [ %t18.i214, %whileBody126.preheader.i218 ], [ %t34.i226, %whileBody126.i220 ]
  %t30.i223 = getelementptr i8, ptr %t1.tr.lcssa, i64 %indvars.iv.i221
  %t31.i224 = load i8, ptr %t30.i223, align 1
  %t32.i225 = tail call ptr @_zen_char_to_string(i8 %t31.i224)
  %t34.i226 = tail call ptr @_str_concat(ptr %t19.010.i222, ptr %t32.i225)
  %indvars.iv.next.i227 = add nuw nsw i64 %indvars.iv.i221, 1
  %exitcond.not.i228 = icmp eq i64 %indvars.iv.next.i227, %wide.trip.count.i219
  br i1 %exitcond.not.i228, label %_zen_std_slice.exit229, label %whileBody126.i220

_zen_std_slice.exit229:                           ; preds = %whileBody126.i220, %whileEnd471
  %common.ret.op.i217 = phi ptr [ %t18.i214, %whileEnd471 ], [ %t34.i226, %whileBody126.i220 ]
  %t452 = tail call i32 @strlen(ptr %t0)
  %t453.not = icmp slt i32 %t39.0343, %t452
  br i1 %t453.not, label %end474, label %common.ret

end474:                                           ; preds = %_zen_std_slice.exit229
  %t3.i230 = tail call i32 @strlen(ptr %t0)
  %t7.i231 = icmp slt i32 %t39.0343, 0
  %t10.i232 = icmp sge i32 %t39.0343, %t3.i230
  %t5.i233 = select i1 %t7.i231, i1 true, i1 %t10.i232
  br i1 %t5.i233, label %if132.i239, label %end128.i234

if132.i239:                                       ; preds = %end474
  %t12.i240 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit241

end128.i234:                                      ; preds = %end474
  %15 = zext nneg i32 %t39.0343 to i64
  %t15.i235 = getelementptr i8, ptr %t0, i64 %15
  %t16.i236 = load i8, ptr %t15.i235, align 1
  %t17.i237 = tail call ptr @_zen_char_to_string(i8 %t16.i236)
  br label %_zen_std_charAt.exit241

_zen_std_charAt.exit241:                          ; preds = %if132.i239, %end128.i234
  %common.ret.op.i238 = phi ptr [ %t12.i240, %if132.i239 ], [ %t17.i237, %end128.i234 ]
  %t461 = tail call i32 @strlen(ptr %common.ret.op.i217)
  %t466 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_22)
  %t462 = icmp eq i32 %t461, 3
  br i1 %t462, label %rhs477, label %else481

rhs477:                                           ; preds = %_zen_std_charAt.exit241
  %t3.i242 = tail call i32 @strlen(ptr %common.ret.op.i217)
  %t10.i243 = icmp slt i32 %t3.i242, 2
  br i1 %t10.i243, label %if132.i250, label %end128.i245

if132.i250:                                       ; preds = %rhs477
  %t12.i251 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit252

end128.i245:                                      ; preds = %rhs477
  %t15.i246 = getelementptr i8, ptr %common.ret.op.i217, i64 1
  %t16.i247 = load i8, ptr %t15.i246, align 1
  %t17.i248 = tail call ptr @_zen_char_to_string(i8 %t16.i247)
  br label %_zen_std_charAt.exit252

_zen_std_charAt.exit252:                          ; preds = %if132.i250, %end128.i245
  %common.ret.op.i249 = phi ptr [ %t12.i251, %if132.i250 ], [ %t17.i248, %end128.i245 ]
  %t467 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i249, ptr noundef nonnull dereferenceable(1) %t466)
  %t468 = icmp eq i32 %t467, 0
  br i1 %t468, label %if480, label %else481

if480:                                            ; preds = %_zen_std_charAt.exit252
  %t3.i253 = tail call i32 @strlen(ptr %common.ret.op.i217)
  %t10.i254 = icmp slt i32 %t3.i253, 1
  br i1 %t10.i254, label %if132.i261, label %end128.i256

if132.i261:                                       ; preds = %if480
  %t12.i262 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit263

end128.i256:                                      ; preds = %if480
  %t16.i258 = load i8, ptr %common.ret.op.i217, align 1
  %t17.i259 = tail call ptr @_zen_char_to_string(i8 %t16.i258)
  br label %_zen_std_charAt.exit263

_zen_std_charAt.exit263:                          ; preds = %if132.i261, %end128.i256
  %common.ret.op.i260 = phi ptr [ %t12.i262, %if132.i261 ], [ %t17.i259, %end128.i256 ]
  %t3.i264 = tail call i32 @strlen(ptr %common.ret.op.i217)
  %t10.i265 = icmp slt i32 %t3.i264, 3
  br i1 %t10.i265, label %if132.i272, label %end128.i267

if132.i272:                                       ; preds = %_zen_std_charAt.exit263
  %t12.i273 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit274

end128.i267:                                      ; preds = %_zen_std_charAt.exit263
  %t15.i268 = getelementptr i8, ptr %common.ret.op.i217, i64 2
  %t16.i269 = load i8, ptr %t15.i268, align 1
  %t17.i270 = tail call ptr @_zen_char_to_string(i8 %t16.i269)
  br label %_zen_std_charAt.exit274

_zen_std_charAt.exit274:                          ; preds = %if132.i272, %end128.i267
  %common.ret.op.i271 = phi ptr [ %t12.i273, %if132.i272 ], [ %t17.i270, %end128.i267 ]
  %t478 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i238, ptr noundef nonnull dereferenceable(1) %common.ret.op.i260)
  %t479 = icmp sgt i32 %t478, -1
  br i1 %t479, label %rhs483, label %common.ret

rhs483:                                           ; preds = %_zen_std_charAt.exit274
  %t482 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i238, ptr noundef nonnull dereferenceable(1) %common.ret.op.i271)
  %t483 = icmp sgt i32 %t482, 0
  br i1 %t483, label %common.ret, label %end494

else481:                                          ; preds = %_zen_std_charAt.exit241, %_zen_std_charAt.exit252
  %t488336 = tail call i32 @strlen(ptr %common.ret.op.i217)
  %t489337 = icmp sgt i32 %t488336, 0
  br i1 %t489337, label %whileBody488, label %common.ret

whileBody488:                                     ; preds = %else481, %whileCond487.backedge
  %indvars.iv379 = phi i64 [ %indvars.iv.next380, %whileCond487.backedge ], [ 0, %else481 ]
  %t3.i275 = tail call i32 @strlen(ptr %common.ret.op.i217)
  %16 = sext i32 %t3.i275 to i64
  %t10.i277.not = icmp slt i64 %indvars.iv379, %16
  br i1 %t10.i277.not, label %end128.i279, label %if132.i284

if132.i284:                                       ; preds = %whileBody488
  %t12.i285 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit286

end128.i279:                                      ; preds = %whileBody488
  %t15.i280 = getelementptr i8, ptr %common.ret.op.i217, i64 %indvars.iv379
  %t16.i281 = load i8, ptr %t15.i280, align 1
  %t17.i282 = tail call ptr @_zen_char_to_string(i8 %t16.i281)
  br label %_zen_std_charAt.exit286

_zen_std_charAt.exit286:                          ; preds = %if132.i284, %end128.i279
  %common.ret.op.i283 = phi ptr [ %t12.i285, %if132.i284 ], [ %t17.i282, %end128.i279 ]
  %t496 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t497 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i283, ptr noundef nonnull dereferenceable(1) %t496)
  %t498 = icmp eq i32 %t497, 0
  br i1 %t498, label %whileCond487.backedge, label %end490

whileCond487.backedge:                            ; preds = %end490, %_zen_std_charAt.exit286
  %indvars.iv.next380 = add nuw nsw i64 %indvars.iv379, 1
  %t488 = tail call i32 @strlen(ptr %common.ret.op.i217)
  %17 = sext i32 %t488 to i64
  %t489 = icmp slt i64 %indvars.iv.next380, %17
  br i1 %t489, label %whileBody488, label %common.ret

end490:                                           ; preds = %_zen_std_charAt.exit286
  %t504 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i283, ptr noundef nonnull dereferenceable(1) %common.ret.op.i238)
  %t505 = icmp eq i32 %t504, 0
  br i1 %t505, label %end494, label %whileCond487.backedge

end494:                                           ; preds = %end490, %rhs483
  %t516 = add i32 %t427.0.lcssa, 1
  br label %whileCond347.backedge

end467:                                           ; preds = %end395
  %t520 = tail call i32 @strlen(ptr %t0)
  %t521.not = icmp slt i32 %t39.0343, %t520
  br i1 %t521.not, label %end496, label %common.ret

end496:                                           ; preds = %end467
  %t3.i287 = tail call i32 @strlen(ptr %t0)
  %t7.i288 = icmp slt i32 %t39.0343, 0
  %t10.i289 = icmp sge i32 %t39.0343, %t3.i287
  %t5.i290 = select i1 %t7.i288, i1 true, i1 %t10.i289
  br i1 %t5.i290, label %if132.i296, label %end128.i291

if132.i296:                                       ; preds = %end496
  %t12.i297 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit298

end128.i291:                                      ; preds = %end496
  %18 = zext nneg i32 %t39.0343 to i64
  %t15.i292 = getelementptr i8, ptr %t0, i64 %18
  %t16.i293 = load i8, ptr %t15.i292, align 1
  %t17.i294 = tail call ptr @_zen_char_to_string(i8 %t16.i293)
  br label %_zen_std_charAt.exit298

_zen_std_charAt.exit298:                          ; preds = %if132.i296, %end128.i291
  %common.ret.op.i295 = phi ptr [ %t12.i297, %if132.i296 ], [ %t17.i294, %end128.i291 ]
  %t526 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i295, ptr noundef nonnull dereferenceable(1) %common.ret.op.i76)
  %t527.not = icmp eq i32 %t526, 0
  br i1 %t527.not, label %end498, label %common.ret

end498:                                           ; preds = %_zen_std_charAt.exit298
  %t532 = add i32 %t40.0341, 1
  br label %whileCond347.backedge

whileEnd349:                                      ; preds = %whileCond347.backedge, %whileCond347.preheader
  %t39.0.lcssa = phi i32 [ 0, %whileCond347.preheader ], [ %t39.0.be, %whileCond347.backedge ]
  %t536 = tail call i32 @strlen(ptr %t0)
  %t537 = icmp eq i32 %t39.0.lcssa, %t536
  br label %common.ret
}

define i32 @_zen_std__json_skipWS(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond500

whileCond500:                                     ; preds = %whileBody501, %entry
  %i.addr.0 = phi i32 [ %t1, %entry ], [ %t12, %whileBody501 ]
  %t5 = tail call i32 @strlen(ptr %t0)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t7.i = icmp slt i32 %i.addr.0, 0
  %t10.i = icmp sge i32 %i.addr.0, %t3.i
  %t5.i = select i1 %t7.i, i1 true, i1 %t10.i
  br i1 %t5.i, label %if132.i, label %end128.i

if132.i:                                          ; preds = %whileCond500
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %whileCond500
  %0 = zext nneg i32 %i.addr.0 to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i, %if132.i ], [ %t17.i, %end128.i ]
  %t6 = icmp slt i32 %i.addr.0, %t5
  br i1 %t6, label %rhs503, label %whileEnd502

rhs503:                                           ; preds = %_zen_std_charAt.exit
  %t10 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i)
  br i1 %t10, label %whileBody501, label %whileEnd502

whileBody501:                                     ; preds = %rhs503
  %t12 = add nsw i32 %i.addr.0, 1
  br label %whileCond500

whileEnd502:                                      ; preds = %_zen_std_charAt.exit, %rhs503
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
  br i1 %t8, label %end508, label %rhs512

rhs512:                                           ; preds = %entry
  %t12 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t11)
  %t13 = icmp eq i32 %t12, 0
  br i1 %t13, label %end508, label %rhs509

rhs509:                                           ; preds = %rhs512
  %t17 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t16)
  %t18 = icmp eq i32 %t17, 0
  br i1 %t18, label %end508, label %rhs506

rhs506:                                           ; preds = %rhs509
  %t22 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t21)
  %t23 = icmp eq i32 %t22, 0
  br label %end508

end508:                                           ; preds = %rhs509, %rhs512, %entry, %rhs506
  %t1 = phi i1 [ %t23, %rhs506 ], [ true, %entry ], [ true, %rhs512 ], [ true, %rhs509 ]
  ret i1 %t1
}

define ptr @_zen_std__json_extractValue(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond500.i

whileCond500.i:                                   ; preds = %whileBody501.i, %entry
  %i.addr.0.i = phi i32 [ %t1, %entry ], [ %t12.i, %whileBody501.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i, 0
  %t10.i.i = icmp sge i32 %i.addr.0.i, %t3.i.i
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i
  br i1 %t5.i.i, label %if132.i.i, label %end128.i.i

if132.i.i:                                        ; preds = %whileCond500.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end128.i.i:                                       ; preds = %whileCond500.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end128.i.i, %if132.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if132.i.i ], [ %t17.i.i, %end128.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs503.i, label %_zen_std__json_skipWS.exit

rhs503.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody501.i, label %_zen_std__json_skipWS.exit

whileBody501.i:                                   ; preds = %rhs503.i
  %t12.i = add nsw i32 %i.addr.0.i, 1
  br label %whileCond500.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs503.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i33 = icmp sge i32 %i.addr.0.i, %t3.i
  %t5.i34 = select i1 %t7.i.i, i1 true, i1 %t10.i33
  br i1 %t5.i34, label %if132.i, label %end128.i

if132.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i35, %if132.i ], [ %t17.i, %end128.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11 = icmp eq i32 %t10, 0
  br i1 %t11, label %if516, label %end515

if516:                                            ; preds = %_zen_std_charAt.exit
  %t14 = add i32 %i.addr.0.i, 1
  %t17239 = tail call i32 @strlen(ptr %t0)
  %t18240 = icmp slt i32 %t14, %t17239
  br i1 %t18240, label %whileBody518, label %whileEnd519

whileBody518:                                     ; preds = %if516, %end520
  %t12.0241 = phi i32 [ %t27, %end520 ], [ %t14, %if516 ]
  %t23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i36 = tail call i32 @strlen(ptr %t0)
  %t7.i37 = icmp slt i32 %t12.0241, 0
  %t10.i38 = icmp sge i32 %t12.0241, %t3.i36
  %t5.i39 = select i1 %t7.i37, i1 true, i1 %t10.i38
  br i1 %t5.i39, label %if132.i45, label %end128.i40

if132.i45:                                        ; preds = %whileBody518
  %t12.i46 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit47

end128.i40:                                       ; preds = %whileBody518
  %2 = zext nneg i32 %t12.0241 to i64
  %t15.i41 = getelementptr i8, ptr %t0, i64 %2
  %t16.i42 = load i8, ptr %t15.i41, align 1
  %t17.i43 = tail call ptr @_zen_char_to_string(i8 %t16.i42)
  br label %_zen_std_charAt.exit47

_zen_std_charAt.exit47:                           ; preds = %if132.i45, %end128.i40
  %common.ret.op.i44 = phi ptr [ %t12.i46, %if132.i45 ], [ %t17.i43, %end128.i40 ]
  %t24 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i44, ptr noundef nonnull dereferenceable(1) %t23)
  %t25 = icmp eq i32 %t24, 0
  br i1 %t25, label %whileEnd519, label %end520

end520:                                           ; preds = %_zen_std_charAt.exit47
  %t27 = add nsw i32 %t12.0241, 1
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %t27, %t17
  br i1 %t18, label %whileBody518, label %whileEnd519

common.ret:                                       ; preds = %whileBody126.i208, %whileBody126.i152, %whileBody126.i96, %whileBody126.i, %whileEnd546, %whileEnd537, %whileEnd526, %whileEnd519
  %common.ret.op = phi ptr [ %t18.i, %whileEnd519 ], [ %t18.i90, %whileEnd526 ], [ %t18.i146, %whileEnd537 ], [ %t18.i202, %whileEnd546 ], [ %t34.i, %whileBody126.i ], [ %t34.i102, %whileBody126.i96 ], [ %t34.i158, %whileBody126.i152 ], [ %t34.i214, %whileBody126.i208 ]
  ret ptr %common.ret.op

whileEnd519:                                      ; preds = %end520, %_zen_std_charAt.exit47, %if516
  %t12.0.lcssa = phi i32 [ %t14, %if516 ], [ %t12.0241, %_zen_std_charAt.exit47 ], [ %t27, %end520 ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t14, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t12.0.lcssa, i32 %t4.i)
  %t16.i48 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i48, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody126.preheader.i, label %common.ret

whileBody126.preheader.i:                         ; preds = %whileEnd519
  %3 = zext nneg i32 %spec.store.select.i to i64
  %wide.trip.count.i = zext nneg i32 %spec.select.i to i64
  br label %whileBody126.i

whileBody126.i:                                   ; preds = %whileBody126.i, %whileBody126.preheader.i
  %indvars.iv.i = phi i64 [ %3, %whileBody126.preheader.i ], [ %indvars.iv.next.i, %whileBody126.i ]
  %t19.010.i = phi ptr [ %t18.i, %whileBody126.preheader.i ], [ %t34.i, %whileBody126.i ]
  %t30.i = getelementptr i8, ptr %t0, i64 %indvars.iv.i
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %common.ret, label %whileBody126.i

end515:                                           ; preds = %_zen_std_charAt.exit
  %t38 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i50 = tail call i32 @strlen(ptr %t0)
  %t10.i52 = icmp sge i32 %i.addr.0.i, %t3.i50
  %t5.i53 = select i1 %t7.i.i, i1 true, i1 %t10.i52
  br i1 %t5.i53, label %if132.i59, label %end128.i54

if132.i59:                                        ; preds = %end515
  %t12.i60 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit61

end128.i54:                                       ; preds = %end515
  %4 = zext nneg i32 %i.addr.0.i to i64
  %t15.i55 = getelementptr i8, ptr %t0, i64 %4
  %t16.i56 = load i8, ptr %t15.i55, align 1
  %t17.i57 = tail call ptr @_zen_char_to_string(i8 %t16.i56)
  br label %_zen_std_charAt.exit61

_zen_std_charAt.exit61:                           ; preds = %if132.i59, %end128.i54
  %common.ret.op.i58 = phi ptr [ %t12.i60, %if132.i59 ], [ %t17.i57, %end128.i54 ]
  %t39 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i58, ptr noundef nonnull dereferenceable(1) %t38)
  %t40 = icmp eq i32 %t39, 0
  br i1 %t40, label %whileCond524.preheader, label %end522

whileCond524.preheader:                           ; preds = %_zen_std_charAt.exit61
  %t46233 = tail call i32 @strlen(ptr %t0)
  %t47234 = icmp slt i32 %i.addr.0.i, %t46233
  br i1 %t47234, label %whileBody525, label %whileEnd526

whileBody525:                                     ; preds = %whileCond524.preheader, %end531
  %t43.0236 = phi i32 [ %t43.2, %end531 ], [ 0, %whileCond524.preheader ]
  %t41.0235 = phi i32 [ %t71, %end531 ], [ %i.addr.0.i, %whileCond524.preheader ]
  %t52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i62 = tail call i32 @strlen(ptr %t0)
  %t7.i63 = icmp slt i32 %t41.0235, 0
  %t10.i64 = icmp sge i32 %t41.0235, %t3.i62
  %t5.i65 = select i1 %t7.i63, i1 true, i1 %t10.i64
  br i1 %t5.i65, label %if132.i71, label %end128.i66

if132.i71:                                        ; preds = %whileBody525
  %t12.i72 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit73

end128.i66:                                       ; preds = %whileBody525
  %5 = zext nneg i32 %t41.0235 to i64
  %t15.i67 = getelementptr i8, ptr %t0, i64 %5
  %t16.i68 = load i8, ptr %t15.i67, align 1
  %t17.i69 = tail call ptr @_zen_char_to_string(i8 %t16.i68)
  br label %_zen_std_charAt.exit73

_zen_std_charAt.exit73:                           ; preds = %if132.i71, %end128.i66
  %common.ret.op.i70 = phi ptr [ %t12.i72, %if132.i71 ], [ %t17.i69, %end128.i66 ]
  %t53 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i70, ptr noundef nonnull dereferenceable(1) %t52)
  %t54 = icmp eq i32 %t53, 0
  %t56 = zext i1 %t54 to i32
  %spec.select = add i32 %t43.0236, %t56
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i74 = tail call i32 @strlen(ptr %t0)
  %t10.i76 = icmp sge i32 %t41.0235, %t3.i74
  %t5.i77 = select i1 %t7.i63, i1 true, i1 %t10.i76
  br i1 %t5.i77, label %if132.i83, label %end128.i78

if132.i83:                                        ; preds = %_zen_std_charAt.exit73
  %t12.i84 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit85

end128.i78:                                       ; preds = %_zen_std_charAt.exit73
  %6 = zext nneg i32 %t41.0235 to i64
  %t15.i79 = getelementptr i8, ptr %t0, i64 %6
  %t16.i80 = load i8, ptr %t15.i79, align 1
  %t17.i81 = tail call ptr @_zen_char_to_string(i8 %t16.i80)
  br label %_zen_std_charAt.exit85

_zen_std_charAt.exit85:                           ; preds = %if132.i83, %end128.i78
  %common.ret.op.i82 = phi ptr [ %t12.i84, %if132.i83 ], [ %t17.i81, %end128.i78 ]
  %t63 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i82, ptr noundef nonnull dereferenceable(1) %t62)
  %t64 = icmp eq i32 %t63, 0
  %t66 = sext i1 %t64 to i32
  %t43.2 = add i32 %spec.select, %t66
  %t69 = icmp eq i32 %t43.2, 0
  br i1 %t69, label %whileEnd526, label %end531

end531:                                           ; preds = %_zen_std_charAt.exit85
  %t71 = add nsw i32 %t41.0235, 1
  %t46 = tail call i32 @strlen(ptr %t0)
  %t47 = icmp slt i32 %t71, %t46
  br i1 %t47, label %whileBody525, label %whileEnd526

whileEnd526:                                      ; preds = %end531, %_zen_std_charAt.exit85, %whileCond524.preheader
  %t41.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond524.preheader ], [ %t41.0235, %_zen_std_charAt.exit85 ], [ %t71, %end531 ]
  %t76 = add i32 %t41.0.lcssa, 1
  %t4.i86 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i87 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i88 = tail call i32 @llvm.smin.i32(i32 %t76, i32 %t4.i86)
  %t16.i89 = icmp sle i32 %spec.store.select.i87, %spec.select.i88
  %t18.i90 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i91 = icmp samesign ult i32 %spec.store.select.i87, %spec.select.i88
  %or.cond.i92 = select i1 %t16.i89, i1 %t268.i91, i1 false
  br i1 %or.cond.i92, label %whileBody126.preheader.i94, label %common.ret

whileBody126.preheader.i94:                       ; preds = %whileEnd526
  %7 = zext nneg i32 %spec.store.select.i87 to i64
  %wide.trip.count.i95 = zext nneg i32 %spec.select.i88 to i64
  br label %whileBody126.i96

whileBody126.i96:                                 ; preds = %whileBody126.i96, %whileBody126.preheader.i94
  %indvars.iv.i97 = phi i64 [ %7, %whileBody126.preheader.i94 ], [ %indvars.iv.next.i103, %whileBody126.i96 ]
  %t19.010.i98 = phi ptr [ %t18.i90, %whileBody126.preheader.i94 ], [ %t34.i102, %whileBody126.i96 ]
  %t30.i99 = getelementptr i8, ptr %t0, i64 %indvars.iv.i97
  %t31.i100 = load i8, ptr %t30.i99, align 1
  %t32.i101 = tail call ptr @_zen_char_to_string(i8 %t31.i100)
  %t34.i102 = tail call ptr @_str_concat(ptr %t19.010.i98, ptr %t32.i101)
  %indvars.iv.next.i103 = add nuw nsw i64 %indvars.iv.i97, 1
  %exitcond.not.i104 = icmp eq i64 %indvars.iv.next.i103, %wide.trip.count.i95
  br i1 %exitcond.not.i104, label %common.ret, label %whileBody126.i96

end522:                                           ; preds = %_zen_std_charAt.exit61
  %t82 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i106 = tail call i32 @strlen(ptr %t0)
  %t10.i108 = icmp sge i32 %i.addr.0.i, %t3.i106
  %t5.i109 = select i1 %t7.i.i, i1 true, i1 %t10.i108
  br i1 %t5.i109, label %if132.i115, label %end128.i110

if132.i115:                                       ; preds = %end522
  %t12.i116 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit117

end128.i110:                                      ; preds = %end522
  %8 = zext nneg i32 %i.addr.0.i to i64
  %t15.i111 = getelementptr i8, ptr %t0, i64 %8
  %t16.i112 = load i8, ptr %t15.i111, align 1
  %t17.i113 = tail call ptr @_zen_char_to_string(i8 %t16.i112)
  br label %_zen_std_charAt.exit117

_zen_std_charAt.exit117:                          ; preds = %if132.i115, %end128.i110
  %common.ret.op.i114 = phi ptr [ %t12.i116, %if132.i115 ], [ %t17.i113, %end128.i110 ]
  %t83 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i114, ptr noundef nonnull dereferenceable(1) %t82)
  %t84 = icmp eq i32 %t83, 0
  %t90227 = tail call i32 @strlen(ptr %t0)
  %t91228 = icmp slt i32 %i.addr.0.i, %t90227
  br i1 %t84, label %whileCond535.preheader, label %whileCond544.preheader

whileCond544.preheader:                           ; preds = %_zen_std_charAt.exit117
  br i1 %t91228, label %whileBody545, label %whileEnd546

whileCond535.preheader:                           ; preds = %_zen_std_charAt.exit117
  br i1 %t91228, label %whileBody536, label %whileEnd537

whileBody536:                                     ; preds = %whileCond535.preheader, %end542
  %t87.0230 = phi i32 [ %t87.2, %end542 ], [ 0, %whileCond535.preheader ]
  %t85.0229 = phi i32 [ %t115, %end542 ], [ %i.addr.0.i, %whileCond535.preheader ]
  %t96 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i118 = tail call i32 @strlen(ptr %t0)
  %t7.i119 = icmp slt i32 %t85.0229, 0
  %t10.i120 = icmp sge i32 %t85.0229, %t3.i118
  %t5.i121 = select i1 %t7.i119, i1 true, i1 %t10.i120
  br i1 %t5.i121, label %if132.i127, label %end128.i122

if132.i127:                                       ; preds = %whileBody536
  %t12.i128 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit129

end128.i122:                                      ; preds = %whileBody536
  %9 = zext nneg i32 %t85.0229 to i64
  %t15.i123 = getelementptr i8, ptr %t0, i64 %9
  %t16.i124 = load i8, ptr %t15.i123, align 1
  %t17.i125 = tail call ptr @_zen_char_to_string(i8 %t16.i124)
  br label %_zen_std_charAt.exit129

_zen_std_charAt.exit129:                          ; preds = %if132.i127, %end128.i122
  %common.ret.op.i126 = phi ptr [ %t12.i128, %if132.i127 ], [ %t17.i125, %end128.i122 ]
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i126, ptr noundef nonnull dereferenceable(1) %t96)
  %t98 = icmp eq i32 %t97, 0
  %t100 = zext i1 %t98 to i32
  %spec.select32 = add i32 %t87.0230, %t100
  %t106 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i130 = tail call i32 @strlen(ptr %t0)
  %t10.i132 = icmp sge i32 %t85.0229, %t3.i130
  %t5.i133 = select i1 %t7.i119, i1 true, i1 %t10.i132
  br i1 %t5.i133, label %if132.i139, label %end128.i134

if132.i139:                                       ; preds = %_zen_std_charAt.exit129
  %t12.i140 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit141

end128.i134:                                      ; preds = %_zen_std_charAt.exit129
  %10 = zext nneg i32 %t85.0229 to i64
  %t15.i135 = getelementptr i8, ptr %t0, i64 %10
  %t16.i136 = load i8, ptr %t15.i135, align 1
  %t17.i137 = tail call ptr @_zen_char_to_string(i8 %t16.i136)
  br label %_zen_std_charAt.exit141

_zen_std_charAt.exit141:                          ; preds = %if132.i139, %end128.i134
  %common.ret.op.i138 = phi ptr [ %t12.i140, %if132.i139 ], [ %t17.i137, %end128.i134 ]
  %t107 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i138, ptr noundef nonnull dereferenceable(1) %t106)
  %t108 = icmp eq i32 %t107, 0
  %t110 = sext i1 %t108 to i32
  %t87.2 = add i32 %spec.select32, %t110
  %t113 = icmp eq i32 %t87.2, 0
  br i1 %t113, label %whileEnd537, label %end542

end542:                                           ; preds = %_zen_std_charAt.exit141
  %t115 = add nsw i32 %t85.0229, 1
  %t90 = tail call i32 @strlen(ptr %t0)
  %t91 = icmp slt i32 %t115, %t90
  br i1 %t91, label %whileBody536, label %whileEnd537

whileEnd537:                                      ; preds = %end542, %_zen_std_charAt.exit141, %whileCond535.preheader
  %t85.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond535.preheader ], [ %t85.0229, %_zen_std_charAt.exit141 ], [ %t115, %end542 ]
  %t120 = add i32 %t85.0.lcssa, 1
  %t4.i142 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i143 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i144 = tail call i32 @llvm.smin.i32(i32 %t120, i32 %t4.i142)
  %t16.i145 = icmp sle i32 %spec.store.select.i143, %spec.select.i144
  %t18.i146 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i147 = icmp samesign ult i32 %spec.store.select.i143, %spec.select.i144
  %or.cond.i148 = select i1 %t16.i145, i1 %t268.i147, i1 false
  br i1 %or.cond.i148, label %whileBody126.preheader.i150, label %common.ret

whileBody126.preheader.i150:                      ; preds = %whileEnd537
  %11 = zext nneg i32 %spec.store.select.i143 to i64
  %wide.trip.count.i151 = zext nneg i32 %spec.select.i144 to i64
  br label %whileBody126.i152

whileBody126.i152:                                ; preds = %whileBody126.i152, %whileBody126.preheader.i150
  %indvars.iv.i153 = phi i64 [ %11, %whileBody126.preheader.i150 ], [ %indvars.iv.next.i159, %whileBody126.i152 ]
  %t19.010.i154 = phi ptr [ %t18.i146, %whileBody126.preheader.i150 ], [ %t34.i158, %whileBody126.i152 ]
  %t30.i155 = getelementptr i8, ptr %t0, i64 %indvars.iv.i153
  %t31.i156 = load i8, ptr %t30.i155, align 1
  %t32.i157 = tail call ptr @_zen_char_to_string(i8 %t31.i156)
  %t34.i158 = tail call ptr @_str_concat(ptr %t19.010.i154, ptr %t32.i157)
  %indvars.iv.next.i159 = add nuw nsw i64 %indvars.iv.i153, 1
  %exitcond.not.i160 = icmp eq i64 %indvars.iv.next.i159, %wide.trip.count.i151
  br i1 %exitcond.not.i160, label %common.ret, label %whileBody126.i152

whileBody545:                                     ; preds = %whileCond544.preheader, %end547
  %t122.0223 = phi i32 [ %t152, %end547 ], [ %i.addr.0.i, %whileCond544.preheader ]
  %t134 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t141 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t148 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i162 = tail call i32 @strlen(ptr %t0)
  %t7.i163 = icmp slt i32 %t122.0223, 0
  %t10.i164 = icmp sge i32 %t122.0223, %t3.i162
  %t5.i165 = select i1 %t7.i163, i1 true, i1 %t10.i164
  br i1 %t5.i165, label %if132.i171, label %end128.i166

if132.i171:                                       ; preds = %whileBody545
  %t12.i172 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit173

end128.i166:                                      ; preds = %whileBody545
  %12 = zext nneg i32 %t122.0223 to i64
  %t15.i167 = getelementptr i8, ptr %t0, i64 %12
  %t16.i168 = load i8, ptr %t15.i167, align 1
  %t17.i169 = tail call ptr @_zen_char_to_string(i8 %t16.i168)
  br label %_zen_std_charAt.exit173

_zen_std_charAt.exit173:                          ; preds = %if132.i171, %end128.i166
  %common.ret.op.i170 = phi ptr [ %t12.i172, %if132.i171 ], [ %t17.i169, %end128.i166 ]
  %t135 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i170, ptr noundef nonnull dereferenceable(1) %t134)
  %t136 = icmp eq i32 %t135, 0
  br i1 %t136, label %whileEnd546, label %rhs551

rhs551:                                           ; preds = %_zen_std_charAt.exit173
  %t3.i174 = tail call i32 @strlen(ptr %t0)
  %t10.i176 = icmp sge i32 %t122.0223, %t3.i174
  %t5.i177 = select i1 %t7.i163, i1 true, i1 %t10.i176
  br i1 %t5.i177, label %if132.i183, label %end128.i178

if132.i183:                                       ; preds = %rhs551
  %t12.i184 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit185

end128.i178:                                      ; preds = %rhs551
  %13 = zext nneg i32 %t122.0223 to i64
  %t15.i179 = getelementptr i8, ptr %t0, i64 %13
  %t16.i180 = load i8, ptr %t15.i179, align 1
  %t17.i181 = tail call ptr @_zen_char_to_string(i8 %t16.i180)
  br label %_zen_std_charAt.exit185

_zen_std_charAt.exit185:                          ; preds = %if132.i183, %end128.i178
  %common.ret.op.i182 = phi ptr [ %t12.i184, %if132.i183 ], [ %t17.i181, %end128.i178 ]
  %t142 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i182, ptr noundef nonnull dereferenceable(1) %t141)
  %t143 = icmp eq i32 %t142, 0
  br i1 %t143, label %whileEnd546, label %rhs548

rhs548:                                           ; preds = %_zen_std_charAt.exit185
  %t3.i186 = tail call i32 @strlen(ptr %t0)
  %t10.i188 = icmp sge i32 %t122.0223, %t3.i186
  %t5.i189 = select i1 %t7.i163, i1 true, i1 %t10.i188
  br i1 %t5.i189, label %if132.i195, label %end128.i190

if132.i195:                                       ; preds = %rhs548
  %t12.i196 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit197

end128.i190:                                      ; preds = %rhs548
  %14 = zext nneg i32 %t122.0223 to i64
  %t15.i191 = getelementptr i8, ptr %t0, i64 %14
  %t16.i192 = load i8, ptr %t15.i191, align 1
  %t17.i193 = tail call ptr @_zen_char_to_string(i8 %t16.i192)
  br label %_zen_std_charAt.exit197

_zen_std_charAt.exit197:                          ; preds = %if132.i195, %end128.i190
  %common.ret.op.i194 = phi ptr [ %t12.i196, %if132.i195 ], [ %t17.i193, %end128.i190 ]
  %t149 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i194, ptr noundef nonnull dereferenceable(1) %t148)
  %t150 = icmp eq i32 %t149, 0
  br i1 %t150, label %whileEnd546, label %end547

end547:                                           ; preds = %_zen_std_charAt.exit197
  %t152 = add nsw i32 %t122.0223, 1
  %t126 = tail call i32 @strlen(ptr %t0)
  %t127 = icmp slt i32 %t152, %t126
  br i1 %t127, label %whileBody545, label %whileEnd546

whileEnd546:                                      ; preds = %end547, %_zen_std_charAt.exit197, %_zen_std_charAt.exit185, %_zen_std_charAt.exit173, %whileCond544.preheader
  %t122.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond544.preheader ], [ %t122.0223, %_zen_std_charAt.exit173 ], [ %t122.0223, %_zen_std_charAt.exit185 ], [ %t122.0223, %_zen_std_charAt.exit197 ], [ %t152, %end547 ]
  %t4.i198 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i199 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i200 = tail call i32 @llvm.smin.i32(i32 %t122.0.lcssa, i32 %t4.i198)
  %t16.i201 = icmp sle i32 %spec.store.select.i199, %spec.select.i200
  %t18.i202 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i203 = icmp samesign ult i32 %spec.store.select.i199, %spec.select.i200
  %or.cond.i204 = select i1 %t16.i201, i1 %t268.i203, i1 false
  br i1 %or.cond.i204, label %whileBody126.preheader.i206, label %common.ret

whileBody126.preheader.i206:                      ; preds = %whileEnd546
  %15 = zext nneg i32 %spec.store.select.i199 to i64
  %wide.trip.count.i207 = zext nneg i32 %spec.select.i200 to i64
  br label %whileBody126.i208

whileBody126.i208:                                ; preds = %whileBody126.i208, %whileBody126.preheader.i206
  %indvars.iv.i209 = phi i64 [ %15, %whileBody126.preheader.i206 ], [ %indvars.iv.next.i215, %whileBody126.i208 ]
  %t19.010.i210 = phi ptr [ %t18.i202, %whileBody126.preheader.i206 ], [ %t34.i214, %whileBody126.i208 ]
  %t30.i211 = getelementptr i8, ptr %t0, i64 %indvars.iv.i209
  %t31.i212 = load i8, ptr %t30.i211, align 1
  %t32.i213 = tail call ptr @_zen_char_to_string(i8 %t31.i212)
  %t34.i214 = tail call ptr @_str_concat(ptr %t19.010.i210, ptr %t32.i213)
  %indvars.iv.next.i215 = add nuw nsw i64 %indvars.iv.i209, 1
  %exitcond.not.i216 = icmp eq i64 %indvars.iv.next.i215, %wide.trip.count.i207
  br i1 %exitcond.not.i216, label %common.ret, label %whileBody126.i208
}

define i32 @_zen_std__json_skipElement(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond500.i

whileCond500.i:                                   ; preds = %whileBody501.i, %entry
  %i.addr.0.i = phi i32 [ %t1, %entry ], [ %t12.i, %whileBody501.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i, 0
  %t10.i.i = icmp sge i32 %i.addr.0.i, %t3.i.i
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i
  br i1 %t5.i.i, label %if132.i.i, label %end128.i.i

if132.i.i:                                        ; preds = %whileCond500.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end128.i.i:                                       ; preds = %whileCond500.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end128.i.i, %if132.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if132.i.i ], [ %t17.i.i, %end128.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs503.i, label %_zen_std__json_skipWS.exit

rhs503.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody501.i, label %_zen_std__json_skipWS.exit

whileBody501.i:                                   ; preds = %rhs503.i
  %t12.i = add nsw i32 %i.addr.0.i, 1
  br label %whileCond500.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs503.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i30 = icmp sge i32 %i.addr.0.i, %t3.i
  %t5.i31 = select i1 %t7.i.i, i1 true, i1 %t10.i30
  br i1 %t5.i31, label %if132.i, label %end128.i

if132.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i32, %if132.i ], [ %t17.i, %end128.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11 = icmp eq i32 %t10, 0
  br i1 %t11, label %whileCond557, label %end555

whileCond557:                                     ; preds = %_zen_std_charAt.exit, %_zen_std_charAt.exit44
  %i.addr.0.in = phi i32 [ %i.addr.0, %_zen_std_charAt.exit44 ], [ %i.addr.0.i, %_zen_std_charAt.exit ]
  %i.addr.0 = add i32 %i.addr.0.in, 1
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %i.addr.0, %t17
  br i1 %t18, label %whileBody558, label %whileEnd559

whileBody558:                                     ; preds = %whileCond557
  %t23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i33 = tail call i32 @strlen(ptr %t0)
  %t7.i34 = icmp slt i32 %i.addr.0, 0
  %t10.i35 = icmp sge i32 %i.addr.0, %t3.i33
  %t5.i36 = select i1 %t7.i34, i1 true, i1 %t10.i35
  br i1 %t5.i36, label %if132.i42, label %end128.i37

if132.i42:                                        ; preds = %whileBody558
  %t12.i43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit44

end128.i37:                                       ; preds = %whileBody558
  %2 = zext nneg i32 %i.addr.0 to i64
  %t15.i38 = getelementptr i8, ptr %t0, i64 %2
  %t16.i39 = load i8, ptr %t15.i38, align 1
  %t17.i40 = tail call ptr @_zen_char_to_string(i8 %t16.i39)
  br label %_zen_std_charAt.exit44

_zen_std_charAt.exit44:                           ; preds = %if132.i42, %end128.i37
  %common.ret.op.i41 = phi ptr [ %t12.i43, %if132.i42 ], [ %t17.i40, %end128.i37 ]
  %t24 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i41, ptr noundef nonnull dereferenceable(1) %t23)
  %t25 = icmp eq i32 %t24, 0
  br i1 %t25, label %whileEnd559, label %whileCond557

common.ret:                                       ; preds = %_zen_std_charAt.exit128, %_zen_std_charAt.exit140, %_zen_std_charAt.exit152, %end587, %whileCond584.preheader, %whileEnd577, %whileEnd566, %whileEnd559
  %common.ret.op = phi i32 [ %t30, %whileEnd559 ], [ %t69, %whileEnd566 ], [ %t108, %whileEnd577 ], [ %i.addr.0.i, %whileCond584.preheader ], [ %i.addr.3155, %_zen_std_charAt.exit128 ], [ %i.addr.3155, %_zen_std_charAt.exit140 ], [ %i.addr.3155, %_zen_std_charAt.exit152 ], [ %t137, %end587 ]
  ret i32 %common.ret.op

whileEnd559:                                      ; preds = %_zen_std_charAt.exit44, %whileCond557
  %t30 = add i32 %i.addr.0.in, 2
  br label %common.ret

end555:                                           ; preds = %_zen_std_charAt.exit
  %t35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i45 = tail call i32 @strlen(ptr %t0)
  %t10.i47 = icmp sge i32 %i.addr.0.i, %t3.i45
  %t5.i48 = select i1 %t7.i.i, i1 true, i1 %t10.i47
  br i1 %t5.i48, label %if132.i54, label %end128.i49

if132.i54:                                        ; preds = %end555
  %t12.i55 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit56

end128.i49:                                       ; preds = %end555
  %3 = zext nneg i32 %i.addr.0.i to i64
  %t15.i50 = getelementptr i8, ptr %t0, i64 %3
  %t16.i51 = load i8, ptr %t15.i50, align 1
  %t17.i52 = tail call ptr @_zen_char_to_string(i8 %t16.i51)
  br label %_zen_std_charAt.exit56

_zen_std_charAt.exit56:                           ; preds = %if132.i54, %end128.i49
  %common.ret.op.i53 = phi ptr [ %t12.i55, %if132.i54 ], [ %t17.i52, %end128.i49 ]
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i53, ptr noundef nonnull dereferenceable(1) %t35)
  %t37 = icmp eq i32 %t36, 0
  br i1 %t37, label %whileCond564.preheader, label %end562

whileCond564.preheader:                           ; preds = %_zen_std_charAt.exit56
  %t41165 = tail call i32 @strlen(ptr %t0)
  %t42166 = icmp slt i32 %i.addr.0.i, %t41165
  br i1 %t42166, label %whileBody565, label %whileEnd566

whileBody565:                                     ; preds = %whileCond564.preheader, %end571
  %i.addr.1168 = phi i32 [ %t66, %end571 ], [ %i.addr.0.i, %whileCond564.preheader ]
  %t38.0167 = phi i32 [ %t38.2, %end571 ], [ 0, %whileCond564.preheader ]
  %t47 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i57 = tail call i32 @strlen(ptr %t0)
  %t7.i58 = icmp slt i32 %i.addr.1168, 0
  %t10.i59 = icmp sge i32 %i.addr.1168, %t3.i57
  %t5.i60 = select i1 %t7.i58, i1 true, i1 %t10.i59
  br i1 %t5.i60, label %if132.i66, label %end128.i61

if132.i66:                                        ; preds = %whileBody565
  %t12.i67 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit68

end128.i61:                                       ; preds = %whileBody565
  %4 = zext nneg i32 %i.addr.1168 to i64
  %t15.i62 = getelementptr i8, ptr %t0, i64 %4
  %t16.i63 = load i8, ptr %t15.i62, align 1
  %t17.i64 = tail call ptr @_zen_char_to_string(i8 %t16.i63)
  br label %_zen_std_charAt.exit68

_zen_std_charAt.exit68:                           ; preds = %if132.i66, %end128.i61
  %common.ret.op.i65 = phi ptr [ %t12.i67, %if132.i66 ], [ %t17.i64, %end128.i61 ]
  %t48 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i65, ptr noundef nonnull dereferenceable(1) %t47)
  %t49 = icmp eq i32 %t48, 0
  %t51 = zext i1 %t49 to i32
  %spec.select = add i32 %t38.0167, %t51
  %t57 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i69 = tail call i32 @strlen(ptr %t0)
  %t10.i71 = icmp sge i32 %i.addr.1168, %t3.i69
  %t5.i72 = select i1 %t7.i58, i1 true, i1 %t10.i71
  br i1 %t5.i72, label %if132.i78, label %end128.i73

if132.i78:                                        ; preds = %_zen_std_charAt.exit68
  %t12.i79 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit80

end128.i73:                                       ; preds = %_zen_std_charAt.exit68
  %5 = zext nneg i32 %i.addr.1168 to i64
  %t15.i74 = getelementptr i8, ptr %t0, i64 %5
  %t16.i75 = load i8, ptr %t15.i74, align 1
  %t17.i76 = tail call ptr @_zen_char_to_string(i8 %t16.i75)
  br label %_zen_std_charAt.exit80

_zen_std_charAt.exit80:                           ; preds = %if132.i78, %end128.i73
  %common.ret.op.i77 = phi ptr [ %t12.i79, %if132.i78 ], [ %t17.i76, %end128.i73 ]
  %t58 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i77, ptr noundef nonnull dereferenceable(1) %t57)
  %t59 = icmp eq i32 %t58, 0
  %t61 = sext i1 %t59 to i32
  %t38.2 = add i32 %spec.select, %t61
  %t64 = icmp eq i32 %t38.2, 0
  br i1 %t64, label %whileEnd566, label %end571

end571:                                           ; preds = %_zen_std_charAt.exit80
  %t66 = add nsw i32 %i.addr.1168, 1
  %t41 = tail call i32 @strlen(ptr %t0)
  %t42 = icmp slt i32 %t66, %t41
  br i1 %t42, label %whileBody565, label %whileEnd566

whileEnd566:                                      ; preds = %end571, %_zen_std_charAt.exit80, %whileCond564.preheader
  %i.addr.1.lcssa = phi i32 [ %i.addr.0.i, %whileCond564.preheader ], [ %i.addr.1168, %_zen_std_charAt.exit80 ], [ %t66, %end571 ]
  %t69 = add i32 %i.addr.1.lcssa, 1
  br label %common.ret

end562:                                           ; preds = %_zen_std_charAt.exit56
  %t74 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i81 = tail call i32 @strlen(ptr %t0)
  %t10.i83 = icmp sge i32 %i.addr.0.i, %t3.i81
  %t5.i84 = select i1 %t7.i.i, i1 true, i1 %t10.i83
  br i1 %t5.i84, label %if132.i90, label %end128.i85

if132.i90:                                        ; preds = %end562
  %t12.i91 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit92

end128.i85:                                       ; preds = %end562
  %6 = zext nneg i32 %i.addr.0.i to i64
  %t15.i86 = getelementptr i8, ptr %t0, i64 %6
  %t16.i87 = load i8, ptr %t15.i86, align 1
  %t17.i88 = tail call ptr @_zen_char_to_string(i8 %t16.i87)
  br label %_zen_std_charAt.exit92

_zen_std_charAt.exit92:                           ; preds = %if132.i90, %end128.i85
  %common.ret.op.i89 = phi ptr [ %t12.i91, %if132.i90 ], [ %t17.i88, %end128.i85 ]
  %t75 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i89, ptr noundef nonnull dereferenceable(1) %t74)
  %t76 = icmp eq i32 %t75, 0
  %t80159 = tail call i32 @strlen(ptr %t0)
  %t81160 = icmp slt i32 %i.addr.0.i, %t80159
  br i1 %t76, label %whileCond575.preheader, label %whileCond584.preheader

whileCond584.preheader:                           ; preds = %_zen_std_charAt.exit92
  br i1 %t81160, label %whileBody585, label %common.ret

whileCond575.preheader:                           ; preds = %_zen_std_charAt.exit92
  br i1 %t81160, label %whileBody576, label %whileEnd577

whileBody576:                                     ; preds = %whileCond575.preheader, %end582
  %i.addr.2162 = phi i32 [ %t105, %end582 ], [ %i.addr.0.i, %whileCond575.preheader ]
  %t77.0161 = phi i32 [ %t77.2, %end582 ], [ 0, %whileCond575.preheader ]
  %t86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i93 = tail call i32 @strlen(ptr %t0)
  %t7.i94 = icmp slt i32 %i.addr.2162, 0
  %t10.i95 = icmp sge i32 %i.addr.2162, %t3.i93
  %t5.i96 = select i1 %t7.i94, i1 true, i1 %t10.i95
  br i1 %t5.i96, label %if132.i102, label %end128.i97

if132.i102:                                       ; preds = %whileBody576
  %t12.i103 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit104

end128.i97:                                       ; preds = %whileBody576
  %7 = zext nneg i32 %i.addr.2162 to i64
  %t15.i98 = getelementptr i8, ptr %t0, i64 %7
  %t16.i99 = load i8, ptr %t15.i98, align 1
  %t17.i100 = tail call ptr @_zen_char_to_string(i8 %t16.i99)
  br label %_zen_std_charAt.exit104

_zen_std_charAt.exit104:                          ; preds = %if132.i102, %end128.i97
  %common.ret.op.i101 = phi ptr [ %t12.i103, %if132.i102 ], [ %t17.i100, %end128.i97 ]
  %t87 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i101, ptr noundef nonnull dereferenceable(1) %t86)
  %t88 = icmp eq i32 %t87, 0
  %t90 = zext i1 %t88 to i32
  %spec.select29 = add i32 %t77.0161, %t90
  %t96 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i105 = tail call i32 @strlen(ptr %t0)
  %t10.i107 = icmp sge i32 %i.addr.2162, %t3.i105
  %t5.i108 = select i1 %t7.i94, i1 true, i1 %t10.i107
  br i1 %t5.i108, label %if132.i114, label %end128.i109

if132.i114:                                       ; preds = %_zen_std_charAt.exit104
  %t12.i115 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit116

end128.i109:                                      ; preds = %_zen_std_charAt.exit104
  %8 = zext nneg i32 %i.addr.2162 to i64
  %t15.i110 = getelementptr i8, ptr %t0, i64 %8
  %t16.i111 = load i8, ptr %t15.i110, align 1
  %t17.i112 = tail call ptr @_zen_char_to_string(i8 %t16.i111)
  br label %_zen_std_charAt.exit116

_zen_std_charAt.exit116:                          ; preds = %if132.i114, %end128.i109
  %common.ret.op.i113 = phi ptr [ %t12.i115, %if132.i114 ], [ %t17.i112, %end128.i109 ]
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(1) %t96)
  %t98 = icmp eq i32 %t97, 0
  %t100 = sext i1 %t98 to i32
  %t77.2 = add i32 %spec.select29, %t100
  %t103 = icmp eq i32 %t77.2, 0
  br i1 %t103, label %whileEnd577, label %end582

end582:                                           ; preds = %_zen_std_charAt.exit116
  %t105 = add nsw i32 %i.addr.2162, 1
  %t80 = tail call i32 @strlen(ptr %t0)
  %t81 = icmp slt i32 %t105, %t80
  br i1 %t81, label %whileBody576, label %whileEnd577

whileEnd577:                                      ; preds = %end582, %_zen_std_charAt.exit116, %whileCond575.preheader
  %i.addr.2.lcssa = phi i32 [ %i.addr.0.i, %whileCond575.preheader ], [ %i.addr.2162, %_zen_std_charAt.exit116 ], [ %t105, %end582 ]
  %t108 = add i32 %i.addr.2.lcssa, 1
  br label %common.ret

whileBody585:                                     ; preds = %whileCond584.preheader, %end587
  %i.addr.3155 = phi i32 [ %t137, %end587 ], [ %i.addr.0.i, %whileCond584.preheader ]
  %t119 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t126 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t133 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i117 = tail call i32 @strlen(ptr %t0)
  %t7.i118 = icmp slt i32 %i.addr.3155, 0
  %t10.i119 = icmp sge i32 %i.addr.3155, %t3.i117
  %t5.i120 = select i1 %t7.i118, i1 true, i1 %t10.i119
  br i1 %t5.i120, label %if132.i126, label %end128.i121

if132.i126:                                       ; preds = %whileBody585
  %t12.i127 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit128

end128.i121:                                      ; preds = %whileBody585
  %9 = zext nneg i32 %i.addr.3155 to i64
  %t15.i122 = getelementptr i8, ptr %t0, i64 %9
  %t16.i123 = load i8, ptr %t15.i122, align 1
  %t17.i124 = tail call ptr @_zen_char_to_string(i8 %t16.i123)
  br label %_zen_std_charAt.exit128

_zen_std_charAt.exit128:                          ; preds = %if132.i126, %end128.i121
  %common.ret.op.i125 = phi ptr [ %t12.i127, %if132.i126 ], [ %t17.i124, %end128.i121 ]
  %t120 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i125, ptr noundef nonnull dereferenceable(1) %t119)
  %t121 = icmp eq i32 %t120, 0
  br i1 %t121, label %common.ret, label %rhs591

rhs591:                                           ; preds = %_zen_std_charAt.exit128
  %t3.i129 = tail call i32 @strlen(ptr %t0)
  %t10.i131 = icmp sge i32 %i.addr.3155, %t3.i129
  %t5.i132 = select i1 %t7.i118, i1 true, i1 %t10.i131
  br i1 %t5.i132, label %if132.i138, label %end128.i133

if132.i138:                                       ; preds = %rhs591
  %t12.i139 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit140

end128.i133:                                      ; preds = %rhs591
  %10 = zext nneg i32 %i.addr.3155 to i64
  %t15.i134 = getelementptr i8, ptr %t0, i64 %10
  %t16.i135 = load i8, ptr %t15.i134, align 1
  %t17.i136 = tail call ptr @_zen_char_to_string(i8 %t16.i135)
  br label %_zen_std_charAt.exit140

_zen_std_charAt.exit140:                          ; preds = %if132.i138, %end128.i133
  %common.ret.op.i137 = phi ptr [ %t12.i139, %if132.i138 ], [ %t17.i136, %end128.i133 ]
  %t127 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i137, ptr noundef nonnull dereferenceable(1) %t126)
  %t128 = icmp eq i32 %t127, 0
  br i1 %t128, label %common.ret, label %rhs588

rhs588:                                           ; preds = %_zen_std_charAt.exit140
  %t3.i141 = tail call i32 @strlen(ptr %t0)
  %t10.i143 = icmp sge i32 %i.addr.3155, %t3.i141
  %t5.i144 = select i1 %t7.i118, i1 true, i1 %t10.i143
  br i1 %t5.i144, label %if132.i150, label %end128.i145

if132.i150:                                       ; preds = %rhs588
  %t12.i151 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit152

end128.i145:                                      ; preds = %rhs588
  %11 = zext nneg i32 %i.addr.3155 to i64
  %t15.i146 = getelementptr i8, ptr %t0, i64 %11
  %t16.i147 = load i8, ptr %t15.i146, align 1
  %t17.i148 = tail call ptr @_zen_char_to_string(i8 %t16.i147)
  br label %_zen_std_charAt.exit152

_zen_std_charAt.exit152:                          ; preds = %if132.i150, %end128.i145
  %common.ret.op.i149 = phi ptr [ %t12.i151, %if132.i150 ], [ %t17.i148, %end128.i145 ]
  %t134 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i149, ptr noundef nonnull dereferenceable(1) %t133)
  %t135 = icmp eq i32 %t134, 0
  br i1 %t135, label %common.ret, label %end587

end587:                                           ; preds = %_zen_std_charAt.exit152
  %t137 = add nsw i32 %i.addr.3155, 1
  %t111 = tail call i32 @strlen(ptr %t0)
  %t112 = icmp slt i32 %t137, %t111
  br i1 %t112, label %whileBody585, label %common.ret
}

define ptr @_zen_std__json_getArrayIndex(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond500.i

whileCond500.i:                                   ; preds = %whileBody501.i, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody501.i ], [ 0, %entry ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %0 = sext i32 %t3.i.i to i64
  %t10.i.i.not = icmp slt i64 %indvars.iv, %0
  br i1 %t10.i.i.not, label %end128.i.i, label %if132.i.i

if132.i.i:                                        ; preds = %whileCond500.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end128.i.i:                                       ; preds = %whileCond500.i
  %t15.i.i = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end128.i.i, %if132.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if132.i.i ], [ %t17.i.i, %end128.i.i ]
  %1 = sext i32 %t5.i to i64
  %t6.i = icmp slt i64 %indvars.iv, %1
  br i1 %t6.i, label %rhs503.i, label %_zen_std__json_skipWS.exit

rhs503.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody501.i, label %_zen_std__json_skipWS.exit

whileBody501.i:                                   ; preds = %rhs503.i
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  br label %whileCond500.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs503.i
  %2 = trunc nuw nsw i64 %indvars.iv to i32
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i12.not = icmp sgt i32 %t3.i, %2
  br i1 %t10.i12.not, label %end128.i, label %if132.i

if132.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i14 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %3 = and i64 %indvars.iv, 4294967295
  %t15.i = getelementptr i8, ptr %t0, i64 %3
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i14, %if132.i ], [ %t17.i, %end128.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11.not = icmp eq i32 %t10, 0
  br i1 %t11.not, label %end595, label %if596

common.ret:                                       ; preds = %whileEnd599, %if607, %if596
  %common.ret.op = phi ptr [ %t13, %if596 ], [ %t54, %if607 ], [ %t62, %whileEnd599 ]
  ret ptr %common.ret.op

if596:                                            ; preds = %_zen_std_charAt.exit
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

end595:                                           ; preds = %_zen_std_charAt.exit
  %t15 = add nuw i32 %2, 1
  %t2078 = tail call i32 @strlen(ptr %t0)
  %t2179 = icmp slt i32 %t15, %t2078
  br i1 %t2179, label %whileCond500.i15.preheader, label %whileEnd599

whileCond500.i15.preheader:                       ; preds = %end595, %end606
  %t4.081 = phi i32 [ %t57, %end606 ], [ %t15, %end595 ]
  %t17.080 = phi i32 [ %t59, %end606 ], [ 0, %end595 ]
  br label %whileCond500.i15

whileCond500.i15:                                 ; preds = %whileCond500.i15.preheader, %whileBody501.i29
  %i.addr.0.i16 = phi i32 [ %t12.i30, %whileBody501.i29 ], [ %t4.081, %whileCond500.i15.preheader ]
  %t5.i17 = tail call i32 @strlen(ptr %t0)
  %t3.i.i18 = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i16, 0
  %t10.i.i19 = icmp sge i32 %i.addr.0.i16, %t3.i.i18
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i19
  br i1 %t5.i.i, label %if132.i.i31, label %end128.i.i20

if132.i.i31:                                      ; preds = %whileCond500.i15
  %t12.i.i32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i24

end128.i.i20:                                     ; preds = %whileCond500.i15
  %4 = zext nneg i32 %i.addr.0.i16 to i64
  %t15.i.i21 = getelementptr i8, ptr %t0, i64 %4
  %t16.i.i22 = load i8, ptr %t15.i.i21, align 1
  %t17.i.i23 = tail call ptr @_zen_char_to_string(i8 %t16.i.i22)
  br label %_zen_std_charAt.exit.i24

_zen_std_charAt.exit.i24:                         ; preds = %end128.i.i20, %if132.i.i31
  %common.ret.op.i.i25 = phi ptr [ %t12.i.i32, %if132.i.i31 ], [ %t17.i.i23, %end128.i.i20 ]
  %t6.i26 = icmp slt i32 %i.addr.0.i16, %t5.i17
  br i1 %t6.i26, label %rhs503.i27, label %_zen_std__json_skipWS.exit33

rhs503.i27:                                       ; preds = %_zen_std_charAt.exit.i24
  %t10.i28 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i25)
  br i1 %t10.i28, label %whileBody501.i29, label %_zen_std__json_skipWS.exit33

whileBody501.i29:                                 ; preds = %rhs503.i27
  %t12.i30 = add nsw i32 %i.addr.0.i16, 1
  br label %whileCond500.i15

_zen_std__json_skipWS.exit33:                     ; preds = %_zen_std_charAt.exit.i24, %rhs503.i27
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t3.i34 = tail call i32 @strlen(ptr %t0)
  %t10.i35 = icmp sge i32 %i.addr.0.i16, %t3.i34
  %t5.i36 = select i1 %t7.i.i, i1 true, i1 %t10.i35
  br i1 %t5.i36, label %if132.i42, label %end128.i37

if132.i42:                                        ; preds = %_zen_std__json_skipWS.exit33
  %t12.i43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit44

end128.i37:                                       ; preds = %_zen_std__json_skipWS.exit33
  %5 = zext nneg i32 %i.addr.0.i16 to i64
  %t15.i38 = getelementptr i8, ptr %t0, i64 %5
  %t16.i39 = load i8, ptr %t15.i38, align 1
  %t17.i40 = tail call ptr @_zen_char_to_string(i8 %t16.i39)
  br label %_zen_std_charAt.exit44

_zen_std_charAt.exit44:                           ; preds = %if132.i42, %end128.i37
  %common.ret.op.i41 = phi ptr [ %t12.i43, %if132.i42 ], [ %t17.i40, %end128.i37 ]
  %t30 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i41, ptr noundef nonnull dereferenceable(1) %t29)
  %t31 = icmp eq i32 %t30, 0
  br i1 %t31, label %whileCond500.i45, label %end600

whileCond500.i45:                                 ; preds = %_zen_std_charAt.exit44, %rhs503.i59
  %i.addr.0.i46.in = phi i32 [ %i.addr.0.i46, %rhs503.i59 ], [ %i.addr.0.i16, %_zen_std_charAt.exit44 ]
  %i.addr.0.i46 = add i32 %i.addr.0.i46.in, 1
  %t5.i47 = tail call i32 @strlen(ptr %t0)
  %t3.i.i48 = tail call i32 @strlen(ptr %t0)
  %t7.i.i49 = icmp slt i32 %i.addr.0.i46, 0
  %t10.i.i50 = icmp sge i32 %i.addr.0.i46, %t3.i.i48
  %t5.i.i51 = select i1 %t7.i.i49, i1 true, i1 %t10.i.i50
  br i1 %t5.i.i51, label %if132.i.i63, label %end128.i.i52

if132.i.i63:                                      ; preds = %whileCond500.i45
  %t12.i.i64 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i56

end128.i.i52:                                     ; preds = %whileCond500.i45
  %6 = zext nneg i32 %i.addr.0.i46 to i64
  %t15.i.i53 = getelementptr i8, ptr %t0, i64 %6
  %t16.i.i54 = load i8, ptr %t15.i.i53, align 1
  %t17.i.i55 = tail call ptr @_zen_char_to_string(i8 %t16.i.i54)
  br label %_zen_std_charAt.exit.i56

_zen_std_charAt.exit.i56:                         ; preds = %end128.i.i52, %if132.i.i63
  %common.ret.op.i.i57 = phi ptr [ %t12.i.i64, %if132.i.i63 ], [ %t17.i.i55, %end128.i.i52 ]
  %t6.i58 = icmp slt i32 %i.addr.0.i46, %t5.i47
  br i1 %t6.i58, label %rhs503.i59, label %end600

rhs503.i59:                                       ; preds = %_zen_std_charAt.exit.i56
  %t10.i60 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i57)
  br i1 %t10.i60, label %whileCond500.i45, label %end600

end600:                                           ; preds = %rhs503.i59, %_zen_std_charAt.exit.i56, %_zen_std_charAt.exit44
  %t4.1 = phi i32 [ %i.addr.0.i16, %_zen_std_charAt.exit44 ], [ %i.addr.0.i46, %_zen_std_charAt.exit.i56 ], [ %i.addr.0.i46, %rhs503.i59 ]
  %t42 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i66 = tail call i32 @strlen(ptr %t0)
  %t7.i67 = icmp slt i32 %t4.1, 0
  %t10.i68 = icmp sge i32 %t4.1, %t3.i66
  %t5.i69 = select i1 %t7.i67, i1 true, i1 %t10.i68
  br i1 %t5.i69, label %if132.i75, label %end128.i70

if132.i75:                                        ; preds = %end600
  %t12.i76 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit77

end128.i70:                                       ; preds = %end600
  %7 = zext nneg i32 %t4.1 to i64
  %t15.i71 = getelementptr i8, ptr %t0, i64 %7
  %t16.i72 = load i8, ptr %t15.i71, align 1
  %t17.i73 = tail call ptr @_zen_char_to_string(i8 %t16.i72)
  br label %_zen_std_charAt.exit77

_zen_std_charAt.exit77:                           ; preds = %if132.i75, %end128.i70
  %common.ret.op.i74 = phi ptr [ %t12.i76, %if132.i75 ], [ %t17.i73, %end128.i70 ]
  %t43 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i74, ptr noundef nonnull dereferenceable(1) %t42)
  %t44 = icmp eq i32 %t43, 0
  br i1 %t44, label %whileEnd599, label %end602

end602:                                           ; preds = %_zen_std_charAt.exit77
  %t47 = tail call i32 @strlen(ptr %t0)
  %t48.not = icmp slt i32 %t4.1, %t47
  br i1 %t48.not, label %end604, label %whileEnd599

end604:                                           ; preds = %end602
  %t51 = icmp eq i32 %t17.080, %t1
  br i1 %t51, label %if607, label %end606

if607:                                            ; preds = %end604
  %t54 = tail call ptr @_zen_std__json_extractValue(ptr %t0, i32 %t4.1)
  br label %common.ret

end606:                                           ; preds = %end604
  %t57 = tail call i32 @_zen_std__json_skipElement(ptr %t0, i32 %t4.1)
  %t59 = add i32 %t17.080, 1
  %t20 = tail call i32 @strlen(ptr %t0)
  %t21 = icmp slt i32 %t57, %t20
  br i1 %t21, label %whileCond500.i15.preheader, label %whileEnd599

whileEnd599:                                      ; preds = %end606, %_zen_std_charAt.exit77, %end602, %end595
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret
}

define ptr @_zen_std__json_getKey(ptr %t0, ptr readonly captures(none) %t1) local_unnamed_addr {
entry:
  br label %whileCond500.i

whileCond500.i:                                   ; preds = %whileBody501.i, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody501.i ], [ 0, %entry ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %0 = sext i32 %t3.i.i to i64
  %t10.i.i.not = icmp slt i64 %indvars.iv, %0
  br i1 %t10.i.i.not, label %end128.i.i, label %if132.i.i

if132.i.i:                                        ; preds = %whileCond500.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i

end128.i.i:                                       ; preds = %whileCond500.i
  %t15.i.i = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %_zen_std_charAt.exit.i

_zen_std_charAt.exit.i:                           ; preds = %end128.i.i, %if132.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if132.i.i ], [ %t17.i.i, %end128.i.i ]
  %1 = sext i32 %t5.i to i64
  %t6.i = icmp slt i64 %indvars.iv, %1
  br i1 %t6.i, label %rhs503.i, label %_zen_std__json_skipWS.exit

rhs503.i:                                         ; preds = %_zen_std_charAt.exit.i
  %t10.i = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody501.i, label %_zen_std__json_skipWS.exit

whileBody501.i:                                   ; preds = %rhs503.i
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  br label %whileCond500.i

_zen_std__json_skipWS.exit:                       ; preds = %_zen_std_charAt.exit.i, %rhs503.i
  %2 = trunc nuw nsw i64 %indvars.iv to i32
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i21.not = icmp sgt i32 %t3.i, %2
  br i1 %t10.i21.not, label %end128.i, label %if132.i

if132.i:                                          ; preds = %_zen_std__json_skipWS.exit
  %t12.i23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %_zen_std__json_skipWS.exit
  %3 = and i64 %indvars.iv, 4294967295
  %t15.i = getelementptr i8, ptr %t0, i64 %3
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i23, %if132.i ], [ %t17.i, %end128.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11.not = icmp eq i32 %t10, 0
  br i1 %t11.not, label %end608, label %if609

common.ret:                                       ; preds = %whileEnd612, %if628, %if609
  %common.ret.op = phi ptr [ %t13, %if609 ], [ %t101, %if628 ], [ %t106, %whileEnd612 ]
  ret ptr %common.ret.op

if609:                                            ; preds = %_zen_std_charAt.exit
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

end608:                                           ; preds = %_zen_std_charAt.exit
  %t15 = add nuw i32 %2, 1
  %t19173 = tail call i32 @strlen(ptr %t0)
  %t20174 = icmp slt i32 %t15, %t19173
  br i1 %t20174, label %whileCond500.i24, label %whileEnd612

whileCond500.i24:                                 ; preds = %end608, %whileCond500.i24.backedge
  %i.addr.0.i25 = phi i32 [ %i.addr.0.i25.be, %whileCond500.i24.backedge ], [ %t15, %end608 ]
  %t5.i26 = tail call i32 @strlen(ptr %t0)
  %t3.i.i27 = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i25, 0
  %t10.i.i28 = icmp sge i32 %i.addr.0.i25, %t3.i.i27
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i28
  br i1 %t5.i.i, label %if132.i.i40, label %end128.i.i29

if132.i.i40:                                      ; preds = %whileCond500.i24
  %t12.i.i41 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i33

end128.i.i29:                                     ; preds = %whileCond500.i24
  %4 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i.i30 = getelementptr i8, ptr %t0, i64 %4
  %t16.i.i31 = load i8, ptr %t15.i.i30, align 1
  %t17.i.i32 = tail call ptr @_zen_char_to_string(i8 %t16.i.i31)
  br label %_zen_std_charAt.exit.i33

_zen_std_charAt.exit.i33:                         ; preds = %end128.i.i29, %if132.i.i40
  %common.ret.op.i.i34 = phi ptr [ %t12.i.i41, %if132.i.i40 ], [ %t17.i.i32, %end128.i.i29 ]
  %t6.i35 = icmp slt i32 %i.addr.0.i25, %t5.i26
  br i1 %t6.i35, label %rhs503.i36, label %_zen_std__json_skipWS.exit42

rhs503.i36:                                       ; preds = %_zen_std_charAt.exit.i33
  %t10.i37 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i34)
  br i1 %t10.i37, label %whileBody501.i38, label %_zen_std__json_skipWS.exit42

whileBody501.i38:                                 ; preds = %rhs503.i36
  %t12.i39 = add nsw i32 %i.addr.0.i25, 1
  br label %whileCond500.i24.backedge

whileCond500.i24.backedge:                        ; preds = %whileBody501.i38, %end627
  %i.addr.0.i25.be = phi i32 [ %t12.i39, %whileBody501.i38 ], [ %t104, %end627 ]
  br label %whileCond500.i24

_zen_std__json_skipWS.exit42:                     ; preds = %_zen_std_charAt.exit.i33, %rhs503.i36
  %t28 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i43 = tail call i32 @strlen(ptr %t0)
  %t10.i44 = icmp sge i32 %i.addr.0.i25, %t3.i43
  %t5.i45 = select i1 %t7.i.i, i1 true, i1 %t10.i44
  br i1 %t5.i45, label %if132.i51, label %end128.i46

if132.i51:                                        ; preds = %_zen_std__json_skipWS.exit42
  %t12.i52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit53

end128.i46:                                       ; preds = %_zen_std__json_skipWS.exit42
  %5 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i47 = getelementptr i8, ptr %t0, i64 %5
  %t16.i48 = load i8, ptr %t15.i47, align 1
  %t17.i49 = tail call ptr @_zen_char_to_string(i8 %t16.i48)
  br label %_zen_std_charAt.exit53

_zen_std_charAt.exit53:                           ; preds = %if132.i51, %end128.i46
  %common.ret.op.i50 = phi ptr [ %t12.i52, %if132.i51 ], [ %t17.i49, %end128.i46 ]
  %t29 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i50, ptr noundef nonnull dereferenceable(1) %t28)
  %t30 = icmp eq i32 %t29, 0
  br i1 %t30, label %whileEnd612, label %end613

end613:                                           ; preds = %_zen_std_charAt.exit53
  %t35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t3.i54 = tail call i32 @strlen(ptr %t0)
  %t10.i56 = icmp sge i32 %i.addr.0.i25, %t3.i54
  %t5.i57 = select i1 %t7.i.i, i1 true, i1 %t10.i56
  br i1 %t5.i57, label %if132.i63, label %end128.i58

if132.i63:                                        ; preds = %end613
  %t12.i64 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit65

end128.i58:                                       ; preds = %end613
  %6 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i59 = getelementptr i8, ptr %t0, i64 %6
  %t16.i60 = load i8, ptr %t15.i59, align 1
  %t17.i61 = tail call ptr @_zen_char_to_string(i8 %t16.i60)
  br label %_zen_std_charAt.exit65

_zen_std_charAt.exit65:                           ; preds = %if132.i63, %end128.i58
  %common.ret.op.i62 = phi ptr [ %t12.i64, %if132.i63 ], [ %t17.i61, %end128.i58 ]
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i62, ptr noundef nonnull dereferenceable(1) %t35)
  %t37 = icmp eq i32 %t36, 0
  br i1 %t37, label %whileCond500.i66, label %end615

whileCond500.i66:                                 ; preds = %_zen_std_charAt.exit65, %rhs503.i80
  %i.addr.0.i67.in = phi i32 [ %i.addr.0.i67, %rhs503.i80 ], [ %i.addr.0.i25, %_zen_std_charAt.exit65 ]
  %i.addr.0.i67 = add i32 %i.addr.0.i67.in, 1
  %t5.i68 = tail call i32 @strlen(ptr %t0)
  %t3.i.i69 = tail call i32 @strlen(ptr %t0)
  %t7.i.i70 = icmp slt i32 %i.addr.0.i67, 0
  %t10.i.i71 = icmp sge i32 %i.addr.0.i67, %t3.i.i69
  %t5.i.i72 = select i1 %t7.i.i70, i1 true, i1 %t10.i.i71
  br i1 %t5.i.i72, label %if132.i.i84, label %end128.i.i73

if132.i.i84:                                      ; preds = %whileCond500.i66
  %t12.i.i85 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i77

end128.i.i73:                                     ; preds = %whileCond500.i66
  %7 = zext nneg i32 %i.addr.0.i67 to i64
  %t15.i.i74 = getelementptr i8, ptr %t0, i64 %7
  %t16.i.i75 = load i8, ptr %t15.i.i74, align 1
  %t17.i.i76 = tail call ptr @_zen_char_to_string(i8 %t16.i.i75)
  br label %_zen_std_charAt.exit.i77

_zen_std_charAt.exit.i77:                         ; preds = %end128.i.i73, %if132.i.i84
  %common.ret.op.i.i78 = phi ptr [ %t12.i.i85, %if132.i.i84 ], [ %t17.i.i76, %end128.i.i73 ]
  %t6.i79 = icmp slt i32 %i.addr.0.i67, %t5.i68
  br i1 %t6.i79, label %rhs503.i80, label %end615

rhs503.i80:                                       ; preds = %_zen_std_charAt.exit.i77
  %t10.i81 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i78)
  br i1 %t10.i81, label %whileCond500.i66, label %end615

end615:                                           ; preds = %rhs503.i80, %_zen_std_charAt.exit.i77, %_zen_std_charAt.exit65
  %t4.1 = phi i32 [ %i.addr.0.i25, %_zen_std_charAt.exit65 ], [ %i.addr.0.i67, %_zen_std_charAt.exit.i77 ], [ %i.addr.0.i67, %rhs503.i80 ]
  %t48 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i87 = tail call i32 @strlen(ptr %t0)
  %t7.i88 = icmp slt i32 %t4.1, 0
  %t10.i89 = icmp sge i32 %t4.1, %t3.i87
  %t5.i90 = select i1 %t7.i88, i1 true, i1 %t10.i89
  br i1 %t5.i90, label %if132.i96, label %end128.i91

if132.i96:                                        ; preds = %end615
  %t12.i97 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit98

end128.i91:                                       ; preds = %end615
  %8 = zext nneg i32 %t4.1 to i64
  %t15.i92 = getelementptr i8, ptr %t0, i64 %8
  %t16.i93 = load i8, ptr %t15.i92, align 1
  %t17.i94 = tail call ptr @_zen_char_to_string(i8 %t16.i93)
  br label %_zen_std_charAt.exit98

_zen_std_charAt.exit98:                           ; preds = %if132.i96, %end128.i91
  %common.ret.op.i95 = phi ptr [ %t12.i97, %if132.i96 ], [ %t17.i94, %end128.i91 ]
  %t49 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i95, ptr noundef nonnull dereferenceable(1) %t48)
  %t50.not = icmp eq i32 %t49, 0
  br i1 %t50.not, label %end617, label %whileEnd612

end617:                                           ; preds = %_zen_std_charAt.exit98
  %t53 = add i32 %t4.1, 1
  %t59167 = tail call i32 @strlen(ptr %t0)
  %t65168 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t60169 = icmp slt i32 %t53, %t59167
  br i1 %t60169, label %rhs622, label %whileEnd621

rhs622:                                           ; preds = %end617, %whileBody620
  %t65171 = phi ptr [ %t65, %whileBody620 ], [ %t65168, %end617 ]
  %t54.0170 = phi i32 [ %t69, %whileBody620 ], [ %t53, %end617 ]
  %t3.i99 = tail call i32 @strlen(ptr %t0)
  %t7.i100 = icmp slt i32 %t54.0170, 0
  %t10.i101 = icmp sge i32 %t54.0170, %t3.i99
  %t5.i102 = select i1 %t7.i100, i1 true, i1 %t10.i101
  br i1 %t5.i102, label %if132.i108, label %end128.i103

if132.i108:                                       ; preds = %rhs622
  %t12.i109 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit110

end128.i103:                                      ; preds = %rhs622
  %9 = zext nneg i32 %t54.0170 to i64
  %t15.i104 = getelementptr i8, ptr %t0, i64 %9
  %t16.i105 = load i8, ptr %t15.i104, align 1
  %t17.i106 = tail call ptr @_zen_char_to_string(i8 %t16.i105)
  br label %_zen_std_charAt.exit110

_zen_std_charAt.exit110:                          ; preds = %if132.i108, %end128.i103
  %common.ret.op.i107 = phi ptr [ %t12.i109, %if132.i108 ], [ %t17.i106, %end128.i103 ]
  %t66 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i107, ptr noundef nonnull dereferenceable(1) %t65171)
  %t67.not = icmp eq i32 %t66, 0
  br i1 %t67.not, label %whileEnd621, label %whileBody620

whileBody620:                                     ; preds = %_zen_std_charAt.exit110
  %t69 = add nsw i32 %t54.0170, 1
  %t59 = tail call i32 @strlen(ptr %t0)
  %t65 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t60 = icmp slt i32 %t69, %t59
  br i1 %t60, label %rhs622, label %whileEnd621

whileEnd621:                                      ; preds = %_zen_std_charAt.exit110, %whileBody620, %end617
  %t54.0.lcssa = phi i32 [ %t53, %end617 ], [ %t69, %whileBody620 ], [ %t54.0170, %_zen_std_charAt.exit110 ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t53, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t54.0.lcssa, i32 %t4.i)
  %t16.i111 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i111, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody126.preheader.i, label %_zen_std_slice.exit

whileBody126.preheader.i:                         ; preds = %whileEnd621
  %10 = zext nneg i32 %spec.store.select.i to i64
  %wide.trip.count.i = zext nneg i32 %spec.select.i to i64
  br label %whileBody126.i

whileBody126.i:                                   ; preds = %whileBody126.i, %whileBody126.preheader.i
  %indvars.iv.i = phi i64 [ %10, %whileBody126.preheader.i ], [ %indvars.iv.next.i, %whileBody126.i ]
  %t19.010.i = phi ptr [ %t18.i, %whileBody126.preheader.i ], [ %t34.i, %whileBody126.i ]
  %t30.i = getelementptr i8, ptr %t0, i64 %indvars.iv.i
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %_zen_std_slice.exit, label %whileBody126.i

_zen_std_slice.exit:                              ; preds = %whileBody126.i, %whileEnd621
  %common.ret.op.i112 = phi ptr [ %t18.i, %whileEnd621 ], [ %t34.i, %whileBody126.i ]
  br label %whileCond500.i113

whileCond500.i113:                                ; preds = %rhs503.i127, %_zen_std_slice.exit
  %i.addr.0.i114.in = phi i32 [ %t54.0.lcssa, %_zen_std_slice.exit ], [ %i.addr.0.i114, %rhs503.i127 ]
  %i.addr.0.i114 = add i32 %i.addr.0.i114.in, 1
  %t5.i115 = tail call i32 @strlen(ptr %t0)
  %t3.i.i116 = tail call i32 @strlen(ptr %t0)
  %t7.i.i117 = icmp slt i32 %i.addr.0.i114, 0
  %t10.i.i118 = icmp sge i32 %i.addr.0.i114, %t3.i.i116
  %t5.i.i119 = select i1 %t7.i.i117, i1 true, i1 %t10.i.i118
  br i1 %t5.i.i119, label %if132.i.i131, label %end128.i.i120

if132.i.i131:                                     ; preds = %whileCond500.i113
  %t12.i.i132 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i124

end128.i.i120:                                    ; preds = %whileCond500.i113
  %11 = zext nneg i32 %i.addr.0.i114 to i64
  %t15.i.i121 = getelementptr i8, ptr %t0, i64 %11
  %t16.i.i122 = load i8, ptr %t15.i.i121, align 1
  %t17.i.i123 = tail call ptr @_zen_char_to_string(i8 %t16.i.i122)
  br label %_zen_std_charAt.exit.i124

_zen_std_charAt.exit.i124:                        ; preds = %end128.i.i120, %if132.i.i131
  %common.ret.op.i.i125 = phi ptr [ %t12.i.i132, %if132.i.i131 ], [ %t17.i.i123, %end128.i.i120 ]
  %t6.i126 = icmp slt i32 %i.addr.0.i114, %t5.i115
  br i1 %t6.i126, label %rhs503.i127, label %_zen_std__json_skipWS.exit133

rhs503.i127:                                      ; preds = %_zen_std_charAt.exit.i124
  %t10.i128 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i125)
  br i1 %t10.i128, label %whileCond500.i113, label %_zen_std__json_skipWS.exit133

_zen_std__json_skipWS.exit133:                    ; preds = %_zen_std_charAt.exit.i124, %rhs503.i127
  %t86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_20)
  %t3.i134 = tail call i32 @strlen(ptr %t0)
  %t10.i136 = icmp sge i32 %i.addr.0.i114, %t3.i134
  %t5.i137 = select i1 %t7.i.i117, i1 true, i1 %t10.i136
  br i1 %t5.i137, label %if132.i143, label %end128.i138

if132.i143:                                       ; preds = %_zen_std__json_skipWS.exit133
  %t12.i144 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit145

end128.i138:                                      ; preds = %_zen_std__json_skipWS.exit133
  %12 = zext nneg i32 %i.addr.0.i114 to i64
  %t15.i139 = getelementptr i8, ptr %t0, i64 %12
  %t16.i140 = load i8, ptr %t15.i139, align 1
  %t17.i141 = tail call ptr @_zen_char_to_string(i8 %t16.i140)
  br label %_zen_std_charAt.exit145

_zen_std_charAt.exit145:                          ; preds = %if132.i143, %end128.i138
  %common.ret.op.i142 = phi ptr [ %t12.i144, %if132.i143 ], [ %t17.i141, %end128.i138 ]
  %t87 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i142, ptr noundef nonnull dereferenceable(1) %t86)
  %t88.not = icmp eq i32 %t87, 0
  br i1 %t88.not, label %end625, label %whileEnd612

end625:                                           ; preds = %_zen_std_charAt.exit145
  %t90 = add i32 %i.addr.0.i114.in, 2
  br label %whileCond500.i146

whileCond500.i146:                                ; preds = %whileBody501.i162, %end625
  %i.addr.0.i147 = phi i32 [ %t90, %end625 ], [ %t12.i163, %whileBody501.i162 ]
  %t5.i148 = tail call i32 @strlen(ptr %t0)
  %t3.i.i149 = tail call i32 @strlen(ptr %t0)
  %t7.i.i150 = icmp slt i32 %i.addr.0.i147, 0
  %t10.i.i151 = icmp sge i32 %i.addr.0.i147, %t3.i.i149
  %t5.i.i152 = select i1 %t7.i.i150, i1 true, i1 %t10.i.i151
  br i1 %t5.i.i152, label %if132.i.i164, label %end128.i.i153

if132.i.i164:                                     ; preds = %whileCond500.i146
  %t12.i.i165 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit.i157

end128.i.i153:                                    ; preds = %whileCond500.i146
  %13 = zext nneg i32 %i.addr.0.i147 to i64
  %t15.i.i154 = getelementptr i8, ptr %t0, i64 %13
  %t16.i.i155 = load i8, ptr %t15.i.i154, align 1
  %t17.i.i156 = tail call ptr @_zen_char_to_string(i8 %t16.i.i155)
  br label %_zen_std_charAt.exit.i157

_zen_std_charAt.exit.i157:                        ; preds = %end128.i.i153, %if132.i.i164
  %common.ret.op.i.i158 = phi ptr [ %t12.i.i165, %if132.i.i164 ], [ %t17.i.i156, %end128.i.i153 ]
  %t6.i159 = icmp slt i32 %i.addr.0.i147, %t5.i148
  br i1 %t6.i159, label %rhs503.i160, label %_zen_std__json_skipWS.exit166

rhs503.i160:                                      ; preds = %_zen_std_charAt.exit.i157
  %t10.i161 = tail call i1 @_zen_std_isWhitespace(ptr %common.ret.op.i.i158)
  br i1 %t10.i161, label %whileBody501.i162, label %_zen_std__json_skipWS.exit166

whileBody501.i162:                                ; preds = %rhs503.i160
  %t12.i163 = add nsw i32 %i.addr.0.i147, 1
  br label %whileCond500.i146

_zen_std__json_skipWS.exit166:                    ; preds = %_zen_std_charAt.exit.i157, %rhs503.i160
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i112, ptr noundef nonnull dereferenceable(1) %t1)
  %t98 = icmp eq i32 %t97, 0
  br i1 %t98, label %if628, label %end627

if628:                                            ; preds = %_zen_std__json_skipWS.exit166
  %t101 = tail call ptr @_zen_std__json_extractValue(ptr %t0, i32 %i.addr.0.i147)
  br label %common.ret

end627:                                           ; preds = %_zen_std__json_skipWS.exit166
  %t104 = tail call i32 @_zen_std__json_skipElement(ptr %t0, i32 %i.addr.0.i147)
  %t19 = tail call i32 @strlen(ptr %t0)
  %t20 = icmp slt i32 %t104, %t19
  br i1 %t20, label %whileCond500.i24.backedge, label %whileEnd612

whileEnd612:                                      ; preds = %end627, %_zen_std_charAt.exit53, %_zen_std_charAt.exit98, %_zen_std_charAt.exit145, %end608
  %t106 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret
}

define i32 @_zen_std__json_parseInt(ptr %t0) local_unnamed_addr {
entry:
  %t54 = tail call i32 @strlen(ptr %t0)
  %t65 = icmp sgt i32 %t54, 0
  br i1 %t65, label %whileBody630, label %whileEnd631

whileBody630:                                     ; preds = %entry, %_zen_std_charAt.exit
  %indvars.iv = phi i64 [ %indvars.iv.next, %_zen_std_charAt.exit ], [ 0, %entry ]
  %t1.07 = phi i32 [ %t16, %_zen_std_charAt.exit ], [ 0, %entry ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %0 = sext i32 %t3.i to i64
  %t10.i.not = icmp slt i64 %indvars.iv, %0
  br i1 %t10.i.not, label %end128.i, label %if132.i

if132.i:                                          ; preds = %whileBody630
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %whileBody630
  %t15.i = getelementptr i8, ptr %t0, i64 %indvars.iv
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i, %if132.i ], [ %t17.i, %end128.i ]
  %t11 = tail call i32 @_string_to_int_ascii(ptr %common.ret.op.i)
  %t14 = mul i32 %t1.07, 10
  %t12 = add i32 %t14, -48
  %t16 = add i32 %t12, %t11
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %t5 = tail call i32 @strlen(ptr %t0)
  %1 = sext i32 %t5 to i64
  %t6 = icmp slt i64 %indvars.iv.next, %1
  br i1 %t6, label %whileBody630, label %whileEnd631

whileEnd631:                                      ; preds = %_zen_std_charAt.exit, %entry
  %t1.0.lcssa = phi i32 [ 0, %entry ], [ %t16, %_zen_std_charAt.exit ]
  ret i32 %t1.0.lcssa
}

define ptr @_zen_std_json(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t796 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %t997 = tail call ptr @_zen_std_splitAt(ptr %t1, ptr %t796, i32 0)
  %t1398 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1499 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t997, ptr noundef nonnull dereferenceable(1) %t1398)
  %t15100 = icmp eq i32 %t1499, 0
  br i1 %t15100, label %common.ret, label %whileCond637.preheader

whileCond637.preheader:                           ; preds = %entry, %whileEnd648
  %t9103 = phi ptr [ %t9, %whileEnd648 ], [ %t997, %entry ]
  %t2.0102 = phi ptr [ %t2.2.lcssa, %whileEnd648 ], [ %t0, %entry ]
  %t4.0101 = phi i32 [ %t108, %whileEnd648 ], [ 0, %entry ]
  %t1981 = tail call i32 @strlen(ptr nonnull %t9103)
  %t2082 = icmp sgt i32 %t1981, 0
  br i1 %t2082, label %whileBody638, label %whileEnd639

whileBody638:                                     ; preds = %whileCond637.preheader, %end640
  %indvars.iv = phi i64 [ %indvars.iv.next, %end640 ], [ 0, %whileCond637.preheader ]
  %t25 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i = tail call i32 @strlen(ptr nonnull %t9103)
  %0 = sext i32 %t3.i to i64
  %t10.i.not = icmp slt i64 %indvars.iv, %0
  br i1 %t10.i.not, label %end128.i, label %if132.i

if132.i:                                          ; preds = %whileBody638
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit

end128.i:                                         ; preds = %whileBody638
  %t15.i = getelementptr i8, ptr %t9103, i64 %indvars.iv
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %_zen_std_charAt.exit

_zen_std_charAt.exit:                             ; preds = %if132.i, %end128.i
  %common.ret.op.i = phi ptr [ %t12.i, %if132.i ], [ %t17.i, %end128.i ]
  %t26 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t25)
  %t27 = icmp eq i32 %t26, 0
  br i1 %t27, label %whileEnd639.loopexit, label %end640

end640:                                           ; preds = %_zen_std_charAt.exit
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %t19 = tail call i32 @strlen(ptr nonnull %t9103)
  %1 = sext i32 %t19 to i64
  %t20 = icmp slt i64 %indvars.iv.next, %1
  br i1 %t20, label %whileBody638, label %whileEnd639.loopexit

whileEnd639.loopexit:                             ; preds = %_zen_std_charAt.exit, %end640
  %t16.0.lcssa.ph.in = phi i64 [ %indvars.iv.next, %end640 ], [ %indvars.iv, %_zen_std_charAt.exit ]
  %t16.0.lcssa.ph = trunc i64 %t16.0.lcssa.ph.in to i32
  br label %whileEnd639

whileEnd639:                                      ; preds = %whileEnd639.loopexit, %whileCond637.preheader
  %t16.0.lcssa = phi i32 [ 0, %whileCond637.preheader ], [ %t16.0.lcssa.ph, %whileEnd639.loopexit ]
  %t4.i = tail call i32 @strlen(ptr nonnull %t9103)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t16.0.lcssa, i32 %t4.i)
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %or.cond.i = icmp sgt i32 %spec.select.i, 0
  br i1 %or.cond.i, label %whileBody126.preheader.i, label %_zen_std_slice.exit

whileBody126.preheader.i:                         ; preds = %whileEnd639
  %wide.trip.count.i = zext nneg i32 %spec.select.i to i64
  br label %whileBody126.i

whileBody126.i:                                   ; preds = %whileBody126.i, %whileBody126.preheader.i
  %indvars.iv.i = phi i64 [ 0, %whileBody126.preheader.i ], [ %indvars.iv.next.i, %whileBody126.i ]
  %t19.010.i = phi ptr [ %t18.i, %whileBody126.preheader.i ], [ %t34.i, %whileBody126.i ]
  %t30.i = getelementptr i8, ptr %t9103, i64 %indvars.iv.i
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  %indvars.iv.next.i = add nuw nsw i64 %indvars.iv.i, 1
  %exitcond.not.i = icmp eq i64 %indvars.iv.next.i, %wide.trip.count.i
  br i1 %exitcond.not.i, label %_zen_std_slice.exit, label %whileBody126.i

_zen_std_slice.exit:                              ; preds = %whileBody126.i, %whileEnd639
  %common.ret.op.i14 = phi ptr [ %t18.i, %whileEnd639 ], [ %t34.i, %whileBody126.i ]
  %t38 = tail call i32 @strlen(ptr nonnull %t9103)
  %t4.i15 = tail call i32 @strlen(ptr nonnull %t9103)
  %spec.select.i16 = tail call i32 @llvm.smin.i32(i32 %t38, i32 %t4.i15)
  %t16.i17 = icmp sle i32 %t16.0.lcssa, %spec.select.i16
  %t18.i18 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i19 = icmp samesign ult i32 %t16.0.lcssa, %spec.select.i16
  %or.cond.i20 = select i1 %t16.i17, i1 %t268.i19, i1 false
  br i1 %or.cond.i20, label %whileBody126.preheader.i22, label %_zen_std_slice.exit33

whileBody126.preheader.i22:                       ; preds = %_zen_std_slice.exit
  %2 = zext nneg i32 %t16.0.lcssa to i64
  %wide.trip.count.i23 = zext nneg i32 %spec.select.i16 to i64
  br label %whileBody126.i24

whileBody126.i24:                                 ; preds = %whileBody126.i24, %whileBody126.preheader.i22
  %indvars.iv.i25 = phi i64 [ %2, %whileBody126.preheader.i22 ], [ %indvars.iv.next.i31, %whileBody126.i24 ]
  %t19.010.i26 = phi ptr [ %t18.i18, %whileBody126.preheader.i22 ], [ %t34.i30, %whileBody126.i24 ]
  %t30.i27 = getelementptr i8, ptr %t9103, i64 %indvars.iv.i25
  %t31.i28 = load i8, ptr %t30.i27, align 1
  %t32.i29 = tail call ptr @_zen_char_to_string(i8 %t31.i28)
  %t34.i30 = tail call ptr @_str_concat(ptr %t19.010.i26, ptr %t32.i29)
  %indvars.iv.next.i31 = add nuw nsw i64 %indvars.iv.i25, 1
  %exitcond.not.i32 = icmp eq i64 %indvars.iv.next.i31, %wide.trip.count.i23
  br i1 %exitcond.not.i32, label %_zen_std_slice.exit33, label %whileBody126.i24

_zen_std_slice.exit33:                            ; preds = %whileBody126.i24, %_zen_std_slice.exit
  %common.ret.op.i21 = phi ptr [ %t18.i18, %_zen_std_slice.exit ], [ %t34.i30, %whileBody126.i24 ]
  %t43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t44 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i14, ptr noundef nonnull dereferenceable(1) %t43)
  %t45.not = icmp eq i32 %t44, 0
  br i1 %t45.not, label %end642, label %if643

if643:                                            ; preds = %_zen_std_slice.exit33
  %t48 = tail call ptr @_zen_std__json_getKey(ptr %t2.0102, ptr nonnull %common.ret.op.i14)
  %t51 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  %t52 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t48, ptr noundef nonnull dereferenceable(1) %t51)
  %t53 = icmp eq i32 %t52, 0
  br i1 %t53, label %common.ret.sink.split, label %end642

common.ret.sink.split:                            ; preds = %if643, %_zen_std_slice.exit77
  %t103 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

common.ret:                                       ; preds = %whileEnd648, %common.ret.sink.split, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t103, %common.ret.sink.split ], [ %t2.2.lcssa, %whileEnd648 ]
  ret ptr %common.ret.op

end642:                                           ; preds = %if643, %_zen_std_slice.exit33
  %t2.1 = phi ptr [ %t48, %if643 ], [ %t2.0102, %_zen_std_slice.exit33 ]
  %t5990 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t6091 = icmp sgt i32 %t5990, 0
  br i1 %t6091, label %whileBody647, label %whileEnd648

whileCond646:                                     ; preds = %_zen_std_slice.exit77
  %t105 = add i32 %t68.0.lcssa, 1
  %t59 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t60 = icmp slt i32 %t105, %t59
  br i1 %t60, label %whileBody647, label %whileEnd648

whileBody647:                                     ; preds = %end642, %whileCond646
  %t2.293 = phi ptr [ %t96, %whileCond646 ], [ %t2.1, %end642 ]
  %t56.092 = phi i32 [ %t105, %whileCond646 ], [ 0, %end642 ]
  %t65 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i34 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7.i35 = icmp slt i32 %t56.092, 0
  %t10.i36 = icmp sge i32 %t56.092, %t3.i34
  %t5.i37 = select i1 %t7.i35, i1 true, i1 %t10.i36
  br i1 %t5.i37, label %if132.i43, label %end128.i38

if132.i43:                                        ; preds = %whileBody647
  %t12.i44 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit45

end128.i38:                                       ; preds = %whileBody647
  %3 = zext nneg i32 %t56.092 to i64
  %t15.i39 = getelementptr i8, ptr %common.ret.op.i21, i64 %3
  %t16.i40 = load i8, ptr %t15.i39, align 1
  %t17.i41 = tail call ptr @_zen_char_to_string(i8 %t16.i40)
  br label %_zen_std_charAt.exit45

_zen_std_charAt.exit45:                           ; preds = %if132.i43, %end128.i38
  %common.ret.op.i42 = phi ptr [ %t12.i44, %if132.i43 ], [ %t17.i41, %end128.i38 ]
  %t66 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i42, ptr noundef nonnull dereferenceable(1) %t65)
  %t67.not = icmp eq i32 %t66, 0
  br i1 %t67.not, label %end649, label %whileEnd648

end649:                                           ; preds = %_zen_std_charAt.exit45
  %t70 = add nsw i32 %t56.092, 1
  %t7385 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7486 = icmp slt i32 %t70, %t7385
  br i1 %t7486, label %whileBody652, label %whileEnd653

whileBody652:                                     ; preds = %end649, %end654
  %t68.087 = phi i32 [ %t83, %end654 ], [ %t70, %end649 ]
  %t79 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i46 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7.i47 = icmp slt i32 %t68.087, 0
  %t10.i48 = icmp sge i32 %t68.087, %t3.i46
  %t5.i49 = select i1 %t7.i47, i1 true, i1 %t10.i48
  br i1 %t5.i49, label %if132.i55, label %end128.i50

if132.i55:                                        ; preds = %whileBody652
  %t12.i56 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %_zen_std_charAt.exit57

end128.i50:                                       ; preds = %whileBody652
  %4 = zext nneg i32 %t68.087 to i64
  %t15.i51 = getelementptr i8, ptr %common.ret.op.i21, i64 %4
  %t16.i52 = load i8, ptr %t15.i51, align 1
  %t17.i53 = tail call ptr @_zen_char_to_string(i8 %t16.i52)
  br label %_zen_std_charAt.exit57

_zen_std_charAt.exit57:                           ; preds = %if132.i55, %end128.i50
  %common.ret.op.i54 = phi ptr [ %t12.i56, %if132.i55 ], [ %t17.i53, %end128.i50 ]
  %t80 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i54, ptr noundef nonnull dereferenceable(1) %t79)
  %t81 = icmp eq i32 %t80, 0
  br i1 %t81, label %whileEnd653, label %end654

end654:                                           ; preds = %_zen_std_charAt.exit57
  %t83 = add nsw i32 %t68.087, 1
  %t73 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t74 = icmp slt i32 %t83, %t73
  br i1 %t74, label %whileBody652, label %whileEnd653

whileEnd653:                                      ; preds = %end654, %_zen_std_charAt.exit57, %end649
  %t68.0.lcssa = phi i32 [ %t70, %end649 ], [ %t68.087, %_zen_std_charAt.exit57 ], [ %t83, %end654 ]
  %t4.i58 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %spec.store.select.i59 = tail call i32 @llvm.smax.i32(i32 %t70, i32 0)
  %spec.select.i60 = tail call i32 @llvm.smin.i32(i32 %t68.0.lcssa, i32 %t4.i58)
  %t16.i61 = icmp sle i32 %spec.store.select.i59, %spec.select.i60
  %t18.i62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i63 = icmp samesign ult i32 %spec.store.select.i59, %spec.select.i60
  %or.cond.i64 = select i1 %t16.i61, i1 %t268.i63, i1 false
  br i1 %or.cond.i64, label %whileBody126.preheader.i66, label %_zen_std_slice.exit77

whileBody126.preheader.i66:                       ; preds = %whileEnd653
  %5 = zext nneg i32 %spec.store.select.i59 to i64
  %wide.trip.count.i67 = zext nneg i32 %spec.select.i60 to i64
  br label %whileBody126.i68

whileBody126.i68:                                 ; preds = %whileBody126.i68, %whileBody126.preheader.i66
  %indvars.iv.i69 = phi i64 [ %5, %whileBody126.preheader.i66 ], [ %indvars.iv.next.i75, %whileBody126.i68 ]
  %t19.010.i70 = phi ptr [ %t18.i62, %whileBody126.preheader.i66 ], [ %t34.i74, %whileBody126.i68 ]
  %t30.i71 = getelementptr i8, ptr %common.ret.op.i21, i64 %indvars.iv.i69
  %t31.i72 = load i8, ptr %t30.i71, align 1
  %t32.i73 = tail call ptr @_zen_char_to_string(i8 %t31.i72)
  %t34.i74 = tail call ptr @_str_concat(ptr %t19.010.i70, ptr %t32.i73)
  %indvars.iv.next.i75 = add nuw nsw i64 %indvars.iv.i69, 1
  %exitcond.not.i76 = icmp eq i64 %indvars.iv.next.i75, %wide.trip.count.i67
  br i1 %exitcond.not.i76, label %_zen_std_slice.exit77, label %whileBody126.i68

_zen_std_slice.exit77:                            ; preds = %whileBody126.i68, %whileEnd653
  %common.ret.op.i65 = phi ptr [ %t18.i62, %whileEnd653 ], [ %t34.i74, %whileBody126.i68 ]
  %t92 = tail call i32 @_zen_std__json_parseInt(ptr %common.ret.op.i65)
  %t96 = tail call ptr @_zen_std__json_getArrayIndex(ptr %t2.293, i32 %t92)
  %t99 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  %t100 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t96, ptr noundef nonnull dereferenceable(1) %t99)
  %t101 = icmp eq i32 %t100, 0
  br i1 %t101, label %common.ret.sink.split, label %whileCond646

whileEnd648:                                      ; preds = %whileCond646, %_zen_std_charAt.exit45, %end642
  %t2.2.lcssa = phi ptr [ %t2.1, %end642 ], [ %t2.293, %_zen_std_charAt.exit45 ], [ %t96, %whileCond646 ]
  %t108 = add i32 %t4.0101, 1
  %t7 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %t9 = tail call ptr @_zen_std_splitAt(ptr %t1, ptr %t7, i32 %t108)
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t14 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t9, ptr noundef nonnull dereferenceable(1) %t13)
  %t15 = icmp eq i32 %t14, 0
  br i1 %t15, label %common.ret, label %whileCond637.preheader
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
  br i1 %t11, label %common.ret, label %end658

common.ret:                                       ; preds = %entry, %whileEnd662
  ret ptr %t3

end658:                                           ; preds = %entry
  %t15 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1916 = icmp sgt i32 %t5, 0
  br i1 %t1916, label %whileBody661.lr.ph, label %whileEnd662

whileBody661.lr.ph:                               ; preds = %end658
  %t25 = sub i32 %t5, %t8
  %t2913 = icmp sgt i32 %t8, 0
  %wide.trip.count = zext nneg i32 %t8 to i64
  br label %whileBody661

whileBody661:                                     ; preds = %whileBody661.lr.ph, %end671
  %t13.018 = phi ptr [ %t15, %whileBody661.lr.ph ], [ %t13.1, %end671 ]
  %t16.017 = phi i32 [ 0, %whileBody661.lr.ph ], [ %t16.1, %end671 ]
  %t26.not = icmp sgt i32 %t16.017, %t25
  br i1 %t26.not, label %else673, label %whileCond666.preheader

whileCond666.preheader:                           ; preds = %whileBody661
  br i1 %t2913, label %whileBody667, label %if672

whileBody667:                                     ; preds = %whileCond666.preheader, %whileBody667
  %indvars.iv = phi i64 [ %indvars.iv.next, %whileBody667 ], [ 0, %whileCond666.preheader ]
  %t20.014 = phi i1 [ %spec.select, %whileBody667 ], [ true, %whileCond666.preheader ]
  %0 = trunc nuw nsw i64 %indvars.iv to i32
  %t33 = add i32 %t16.017, %0
  %1 = sext i32 %t33 to i64
  %t34 = getelementptr i8, ptr %t0, i64 %1
  %t35 = load i8, ptr %t34, align 1
  %t36 = call ptr @_zen_char_to_string(i8 %t35)
  %t40 = getelementptr i8, ptr %t1, i64 %indvars.iv
  %t41 = load i8, ptr %t40, align 1
  %t42 = call ptr @_zen_char_to_string(i8 %t41)
  %t44 = call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t36, ptr noundef nonnull dereferenceable(1) %t42)
  %t45.not = icmp eq i32 %t44, 0
  %spec.select = select i1 %t45.not, i1 %t20.014, i1 false
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond.not, label %end663, label %whileBody667

end663:                                           ; preds = %whileBody667
  br i1 %spec.select, label %if672, label %else673

if672:                                            ; preds = %whileCond666.preheader, %end663
  store ptr %t13.018, ptr %t54, align 8
  call void @_zen_list_push(ptr %t3, ptr nonnull %t54)
  %t56 = call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end671

else673:                                          ; preds = %whileBody661, %end663
  %2 = sext i32 %t16.017 to i64
  %t65 = getelementptr i8, ptr %t0, i64 %2
  %t66 = load i8, ptr %t65, align 1
  %t67 = call ptr @_zen_char_to_string(i8 %t66)
  %t69 = call ptr @_str_concat(ptr %t13.018, ptr %t67)
  br label %end671

end671:                                           ; preds = %else673, %if672
  %t8.pn = phi i32 [ %t8, %if672 ], [ 1, %else673 ]
  %t13.1 = phi ptr [ %t56, %if672 ], [ %t69, %else673 ]
  %t16.1 = add i32 %t8.pn, %t16.017
  %t19 = icmp slt i32 %t16.1, %t5
  br i1 %t19, label %whileBody661, label %whileEnd662

whileEnd662:                                      ; preds = %end671, %end658
  %t13.0.lcssa = phi ptr [ %t15, %end658 ], [ %t13.1, %end671 ]
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
