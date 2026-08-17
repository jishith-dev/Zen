@INF = external local_unnamed_addr constant double
@I32_MAX = external local_unnamed_addr constant i32
@SEED = external local_unnamed_addr global i32
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

declare i32 @_string_to_int_ascii(ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: read)
declare i32 @strcmp(ptr captures(none), ptr captures(none)) local_unnamed_addr #0

declare void @_zen_string_free(ptr) local_unnamed_addr

declare ptr @_str_concat(ptr, ptr) local_unnamed_addr

declare ptr @_zen_char_to_string(i8) local_unnamed_addr

declare ptr @_str_dup(ptr) local_unnamed_addr

declare i32 @strlen(ptr) local_unnamed_addr

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isEven(i32 %t0) local_unnamed_addr #1 {
entry:
  %0 = and i32 %t0, 1
  %t3 = icmp eq i32 %0, 0
  ret i1 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isOdd(i32 %t0) local_unnamed_addr #1 {
entry:
  %0 = and i32 %t0, 1
  %t3 = icmp ne i32 %0, 0
  ret i1 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isPositive(i32 %t0) local_unnamed_addr #1 {
entry:
  %t2 = icmp sgt i32 %t0, 0
  ret i1 %t2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isNegative(i32 %t0) local_unnamed_addr #1 {
entry:
  %t2 = icmp slt i32 %t0, 0
  ret i1 %t2
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define noundef i1 @isNaN(double %t0) local_unnamed_addr #1 {
entry:
  ret i1 false
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define range(i32 0, -2147483647) i32 @abs(i32 %t0) local_unnamed_addr #1 {
entry:
  %common.ret.op = tail call i32 @llvm.abs.i32(i32 %t0, i1 false)
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @max(i32 %t0, i32 %t1) local_unnamed_addr #1 {
entry:
  %common.ret.op = tail call i32 @llvm.smax.i32(i32 %t0, i32 %t1)
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @min(i32 %t0, i32 %t1) local_unnamed_addr #1 {
entry:
  %common.ret.op = tail call i32 @llvm.smin.i32(i32 %t0, i32 %t1)
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @clamp(i32 %t0, i32 %t1, i32 %t2) local_unnamed_addr #1 {
entry:
  %t5 = icmp slt i32 %t0, %t1
  %t2.t0 = tail call i32 @llvm.smin.i32(i32 %t0, i32 %t2)
  %common.ret.op = select i1 %t5, i32 %t1, i32 %t2.t0
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define range(i32 -1, 2) i32 @sign(i32 %t0) local_unnamed_addr #1 {
entry:
  %t0.lobit = ashr i32 %t0, 31
  %t2.inv = icmp slt i32 %t0, 1
  %common.ret.op = select i1 %t2.inv, i32 %t0.lobit, i32 1
  ret i32 %common.ret.op
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @pow(i32 %t0, i32 %t1) local_unnamed_addr #2 {
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
define i32 @sqrt(i32 %t0) local_unnamed_addr #2 {
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
define i32 @square(i32 %t0) local_unnamed_addr #1 {
entry:
  %t3 = mul i32 %t0, %t0
  ret i32 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @cube(i32 %t0) local_unnamed_addr #1 {
entry:
  %t3 = mul i32 %t0, %t0
  %t5 = mul i32 %t3, %t0
  ret i32 %t5
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @floor(double %t0) local_unnamed_addr #1 {
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
define i32 @ceil(double %t0) local_unnamed_addr #1 {
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
define i32 @round(double %t0) local_unnamed_addr #1 {
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
define double @toFixed(double %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t3 = icmp slt i32 %t1, 0
  br i1 %t3, label %common.ret, label %end55

common.ret:                                       ; preds = %entry, %round.exit
  %common.ret.op = phi double [ %t18, %round.exit ], [ %t0, %entry ]
  ret double %common.ret.op

end55:                                            ; preds = %entry
  %t3.i = icmp eq i32 %t1, 0
  br i1 %t3.i, label %pow.exit, label %whileBody29.lr.ph.i

whileBody29.lr.ph.i:                              ; preds = %end55
  %t34.i = load double, ptr @INF, align 8
  br label %whileBody29.i

whileCond28.i:                                    ; preds = %whileBody29.i
  %t38.i = add nuw nsw i32 %t24.014.i, 1
  %t27.i = icmp slt i32 %t38.i, %t1
  br i1 %t27.i, label %whileBody29.i, label %pow.exit

whileBody29.i:                                    ; preds = %whileCond28.i, %whileBody29.lr.ph.i
  %t24.014.i = phi i32 [ 0, %whileBody29.lr.ph.i ], [ %t38.i, %whileCond28.i ]
  %t23.013.i = phi double [ 1.000000e+00, %whileBody29.lr.ph.i ], [ %t31.i, %whileCond28.i ]
  %t31.i = fmul double %t23.013.i, 1.000000e+01
  %t35.i = fcmp oeq double %t31.i, %t34.i
  br i1 %t35.i, label %pow.exit, label %whileCond28.i

pow.exit:                                         ; preds = %whileCond28.i, %whileBody29.i, %end55
  %common.ret.op.i = phi double [ 1.000000e+00, %end55 ], [ %t31.i, %whileCond28.i ], [ %t34.i, %whileBody29.i ]
  %t11 = fmul double %t0, %common.ret.op.i
  %t2.i = fptosi double %t11 to i32
  %t7.i = sitofp i32 %t2.i to double
  %t8.i = fsub double %t11, %t7.i
  %t10.i = fcmp ult double %t11, 0.000000e+00
  br i1 %t10.i, label %end49.i, label %if50.i

if50.i:                                           ; preds = %pow.exit
  %t13.i = fcmp ult double %t8.i, 5.000000e-01
  br i1 %t13.i, label %round.exit, label %if52.i

if52.i:                                           ; preds = %if50.i
  %t15.i = add i32 %t2.i, 1
  br label %round.exit

end49.i:                                          ; preds = %pow.exit
  %t18.i3 = fcmp ugt double %t8.i, -5.000000e-01
  br i1 %t18.i3, label %round.exit, label %if54.i

if54.i:                                           ; preds = %end49.i
  %t20.i = add i32 %t2.i, -1
  br label %round.exit

round.exit:                                       ; preds = %if50.i, %if52.i, %end49.i, %if54.i
  %common.ret.op.i2 = phi i32 [ %t15.i, %if52.i ], [ %t20.i, %if54.i ], [ %t2.i, %if50.i ], [ %t2.i, %end49.i ]
  %t17 = sitofp i32 %common.ret.op.i2 to double
  %t18 = fdiv double %t17, %common.ret.op.i
  br label %common.ret
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @mod(i32 %t0, i32 %t1) local_unnamed_addr #1 {
entry:
  %spec.select = tail call i32 @llvm.abs.i32(i32 %t1, i1 false)
  %t10 = srem i32 %t0, %spec.select
  %t12 = icmp slt i32 %t10, 0
  %t15 = select i1 %t12, i32 %spec.select, i32 0
  %common.ret.op = add i32 %t15, %t10
  ret i32 %common.ret.op
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define range(i32 0, -2147483648) i32 @gcd(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t3 = tail call i32 @llvm.abs.i32(i32 %t0, i1 true)
  %t7.not6 = icmp eq i32 %t1, 0
  br i1 %t7.not6, label %whileEnd63, label %whileBody62.preheader

whileBody62.preheader:                            ; preds = %entry
  %t5 = tail call i32 @llvm.abs.i32(i32 %t1, i1 true)
  br label %whileBody62

whileBody62:                                      ; preds = %whileBody62.preheader, %whileBody62
  %b.addr.08 = phi i32 [ %t12, %whileBody62 ], [ %t5, %whileBody62.preheader ]
  %a.addr.07 = phi i32 [ %b.addr.08, %whileBody62 ], [ %t3, %whileBody62.preheader ]
  %t12 = urem i32 %a.addr.07, %b.addr.08
  %t7.not = icmp eq i32 %t12, 0
  br i1 %t7.not, label %whileEnd63, label %whileBody62

whileEnd63:                                       ; preds = %whileBody62, %entry
  %a.addr.0.lcssa = phi i32 [ %t3, %entry ], [ %b.addr.08, %whileBody62 ]
  ret i32 %a.addr.0.lcssa
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define range(i32 0, -2147483648) i32 @lcm(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t4 = icmp eq i32 %t0, 0
  %t6 = icmp eq i32 %t1, 0
  %t2 = select i1 %t4, i1 true, i1 %t6
  br i1 %t2, label %common.ret, label %whileBody62.preheader.i

common.ret:                                       ; preds = %entry, %gcd.exit
  %common.ret.op = phi i32 [ %t14, %gcd.exit ], [ 0, %entry ]
  ret i32 %common.ret.op

whileBody62.preheader.i:                          ; preds = %entry
  %t3.i = tail call i32 @llvm.abs.i32(i32 %t0, i1 true)
  %t5.i = tail call i32 @llvm.abs.i32(i32 %t1, i1 true)
  br label %whileBody62.i

whileBody62.i:                                    ; preds = %whileBody62.i, %whileBody62.preheader.i
  %b.addr.08.i = phi i32 [ %t12.i, %whileBody62.i ], [ %t5.i, %whileBody62.preheader.i ]
  %a.addr.07.i = phi i32 [ %b.addr.08.i, %whileBody62.i ], [ %t3.i, %whileBody62.preheader.i ]
  %t12.i = urem i32 %a.addr.07.i, %b.addr.08.i
  %t7.not.i = icmp eq i32 %t12.i, 0
  br i1 %t7.not.i, label %gcd.exit, label %whileBody62.i

gcd.exit:                                         ; preds = %whileBody62.i
  %t11 = sdiv i32 %t0, %b.addr.08.i
  %t13 = mul i32 %t11, %t1
  %t14 = tail call i32 @llvm.abs.i32(i32 %t13, i1 true)
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @factorial(i32 %t0) local_unnamed_addr #2 {
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
define noundef i1 @isPrime(i32 %t0) local_unnamed_addr #2 {
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
define double @lerp(double %t0, double %t1, double %t2) local_unnamed_addr #1 {
entry:
  %t6 = fsub double %t1, %t0
  %t8 = fmul double %t6, %t2
  %t9 = fadd double %t0, %t8
  ret double %t9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @normalize(double %t0, double %t1, double %t2) local_unnamed_addr #1 {
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
define i1 @between(i32 %t0, i32 %t1, i32 %t2) local_unnamed_addr #1 {
entry:
  %t6 = icmp sge i32 %t0, %t1
  %t9 = icmp sle i32 %t0, %t2
  %t3 = select i1 %t6, i1 %t9, i1 false
  ret i1 %t3
}

define ptr @reverse(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t7.03 = add i32 %t2, -1
  %t114 = icmp sgt i32 %t7.03, -1
  br i1 %t114, label %whileBody93, label %whileEnd94

whileBody93:                                      ; preds = %entry, %whileBody93
  %t7.06 = phi i32 [ %t7.0, %whileBody93 ], [ %t7.03, %entry ]
  %t4.05 = phi ptr [ %t19, %whileBody93 ], [ %t6, %entry ]
  %0 = zext nneg i32 %t7.06 to i64
  %t15 = getelementptr i8, ptr %t0, i64 %0
  %t16 = load i8, ptr %t15, align 1
  %t17 = tail call ptr @_zen_char_to_string(i8 %t16)
  %t19 = tail call ptr @_str_concat(ptr %t4.05, ptr %t17)
  tail call void @_zen_string_free(ptr %t4.05)
  %t7.0 = add nsw i32 %t7.06, -1
  %t11.not = icmp eq i32 %t7.06, 0
  br i1 %t11.not, label %whileEnd94, label %whileBody93

whileEnd94:                                       ; preds = %whileBody93, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t19, %whileBody93 ]
  ret ptr %t4.0.lcssa
}

define i32 @indexOf(ptr %t0, ptr %t1) local_unnamed_addr {
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
  br label %whileCond100.preheader

common.ret:                                       ; preds = %whileCond100.preheader, %end105, %whileEnd102, %whileCond97.preheader, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ -1, %whileCond97.preheader ], [ -1, %end105 ], [ %t10.013, %whileEnd102 ], [ 0, %whileCond100.preheader ]
  ret i32 %common.ret.op

whileCond100.preheader:                           ; preds = %whileCond100.preheader.lr.ph, %end105
  %t10.013 = phi i32 [ 0, %whileCond100.preheader.lr.ph ], [ %t44, %end105 ]
  br i1 %t209, label %whileBody101, label %common.ret

whileBody101:                                     ; preds = %whileCond100.preheader, %whileBody101
  %t16.011 = phi i1 [ %spec.select, %whileBody101 ], [ true, %whileCond100.preheader ]
  %t17.010 = phi i32 [ %t39, %whileBody101 ], [ 0, %whileCond100.preheader ]
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
  br i1 %t20, label %whileBody101, label %whileEnd102

whileEnd102:                                      ; preds = %whileBody101
  br i1 %spec.select, label %common.ret, label %end105

end105:                                           ; preds = %whileEnd102
  %t44 = add i32 %t10.013, 1
  %t15.not = icmp sgt i32 %t44, %t14
  br i1 %t15.not, label %common.ret, label %whileCond100.preheader
}

define ptr @slice(ptr %t0, i32 %t1, i32 %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %spec.store.select = tail call i32 @llvm.smax.i32(i32 %t1, i32 0)
  %spec.select = tail call i32 @llvm.smin.i32(i32 %t2, i32 %t4)
  %t16 = icmp sle i32 %spec.store.select, %spec.select
  %t18 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268 = icmp samesign ult i32 %spec.store.select, %spec.select
  %or.cond = select i1 %t16, i1 %t268, i1 false
  br i1 %or.cond, label %whileBody114, label %common.ret

common.ret:                                       ; preds = %whileBody114, %entry
  %common.ret.op = phi ptr [ %t18, %entry ], [ %t34, %whileBody114 ]
  ret ptr %common.ret.op

whileBody114:                                     ; preds = %entry, %whileBody114
  %t19.010 = phi ptr [ %t34, %whileBody114 ], [ %t18, %entry ]
  %t22.09 = phi i32 [ %t38, %whileBody114 ], [ %spec.store.select, %entry ]
  %0 = zext nneg i32 %t22.09 to i64
  %t30 = getelementptr i8, ptr %t0, i64 %0
  %t31 = load i8, ptr %t30, align 1
  %t32 = tail call ptr @_zen_char_to_string(i8 %t31)
  %t34 = tail call ptr @_str_concat(ptr %t19.010, ptr %t32)
  tail call void @_zen_string_free(ptr %t19.010)
  %t38 = add nuw nsw i32 %t22.09, 1
  %t26 = icmp slt i32 %t38, %spec.select
  br i1 %t26, label %whileBody114, label %common.ret
}

define ptr @charAt(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t7 = icmp slt i32 %t1, 0
  %t10 = icmp sge i32 %t1, %t3
  %t5 = select i1 %t7, i1 true, i1 %t10
  br i1 %t5, label %if120, label %end116

common.ret:                                       ; preds = %end116, %if120
  %common.ret.op = phi ptr [ %t12, %if120 ], [ %t17, %end116 ]
  ret ptr %common.ret.op

if120:                                            ; preds = %entry
  %t12 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

end116:                                           ; preds = %entry
  %0 = zext nneg i32 %t1 to i64
  %t15 = getelementptr i8, ptr %t0, i64 %0
  %t16 = load i8, ptr %t15, align 1
  %t17 = tail call ptr @_zen_char_to_string(i8 %t16)
  br label %common.ret
}

define ptr @replace(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  br i1 %t10, label %common.ret, label %whileCond123.preheader

whileCond123.preheader:                           ; preds = %entry
  %t16 = sub i32 %t4, %t7
  %t17.not22 = icmp slt i32 %t16, 0
  br i1 %t17.not22, label %common.ret, label %whileCond126.preheader.lr.ph

whileCond126.preheader.lr.ph:                     ; preds = %whileCond123.preheader
  %t2219 = icmp sgt i32 %t7, 0
  br label %whileCond126.preheader

common.ret:                                       ; preds = %end131, %whileBody137, %whileCond123.preheader, %whileEnd135, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t66, %whileEnd135 ], [ %t0, %whileCond123.preheader ], [ %t86, %whileBody137 ], [ %t0, %end131 ]
  ret ptr %common.ret.op

whileCond126.preheader:                           ; preds = %whileCond126.preheader.lr.ph, %end131
  %t12.023 = phi i32 [ 0, %whileCond126.preheader.lr.ph ], [ %t94, %end131 ]
  br i1 %t2219, label %whileBody127, label %if132.thread

if132.thread:                                     ; preds = %whileCond126.preheader
  %t4635 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %whileEnd135

whileBody127:                                     ; preds = %whileCond126.preheader, %whileBody127
  %t18.021 = phi i1 [ %spec.select, %whileBody127 ], [ true, %whileCond126.preheader ]
  %t19.020 = phi i32 [ %t41, %whileBody127 ], [ 0, %whileCond126.preheader ]
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
  br i1 %t22, label %whileBody127, label %whileEnd128

whileEnd128:                                      ; preds = %whileBody127
  br i1 %spec.select, label %if132, label %end131

if132:                                            ; preds = %whileEnd128
  %t46 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t5024 = icmp sgt i32 %t12.023, 0
  br i1 %t5024, label %whileBody134, label %whileEnd135

whileBody134:                                     ; preds = %if132, %whileBody134
  %t44.026 = phi ptr [ %t58, %whileBody134 ], [ %t46, %if132 ]
  %t47.025 = phi i32 [ %t62, %whileBody134 ], [ 0, %if132 ]
  %2 = zext nneg i32 %t47.025 to i64
  %t54 = getelementptr i8, ptr %t0, i64 %2
  %t55 = load i8, ptr %t54, align 1
  %t56 = tail call ptr @_zen_char_to_string(i8 %t55)
  %t58 = tail call ptr @_str_concat(ptr %t44.026, ptr %t56)
  tail call void @_zen_string_free(ptr %t44.026)
  %t62 = add nuw nsw i32 %t47.025, 1
  %t50 = icmp slt i32 %t62, %t12.023
  br i1 %t50, label %whileBody134, label %whileEnd135

whileEnd135:                                      ; preds = %whileBody134, %if132.thread, %if132
  %t12.023.lcssa37 = phi i32 [ %t12.023, %if132 ], [ 0, %if132.thread ], [ %t12.023, %whileBody134 ]
  %t44.0.lcssa = phi ptr [ %t46, %if132 ], [ %t4635, %if132.thread ], [ %t58, %whileBody134 ]
  %t66 = tail call ptr @_str_concat(ptr %t44.0.lcssa, ptr %t2)
  tail call void @_zen_string_free(ptr %t44.0.lcssa)
  %t70 = tail call i32 @strlen(ptr %t2)
  %t74 = add i32 %t12.023.lcssa37, %t7
  %t7828 = icmp slt i32 %t74, %t4
  br i1 %t7828, label %whileBody137, label %common.ret

whileBody137:                                     ; preds = %whileEnd135, %whileBody137
  %t44.130 = phi ptr [ %t86, %whileBody137 ], [ %t66, %whileEnd135 ]
  %t47.129 = phi i32 [ %t90, %whileBody137 ], [ %t74, %whileEnd135 ]
  %3 = sext i32 %t47.129 to i64
  %t82 = getelementptr i8, ptr %t0, i64 %3
  %t83 = load i8, ptr %t82, align 1
  %t84 = tail call ptr @_zen_char_to_string(i8 %t83)
  %t86 = tail call ptr @_str_concat(ptr %t44.130, ptr %t84)
  tail call void @_zen_string_free(ptr %t44.130)
  %t90 = add nsw i32 %t47.129, 1
  %t78 = icmp slt i32 %t90, %t4
  br i1 %t78, label %whileBody137, label %common.ret

end131:                                           ; preds = %whileEnd128
  %t94 = add i32 %t12.023, 1
  %t17.not = icmp sgt i32 %t94, %t16
  br i1 %t17.not, label %common.ret, label %whileCond126.preheader
}

define ptr @replaceAll(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  br i1 %t10, label %common.ret, label %end139

common.ret:                                       ; preds = %end152, %end139, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t14, %end139 ], [ %t67, %end152 ]
  ret ptr %common.ret.op

end139:                                           ; preds = %entry
  %t14 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1816 = icmp sgt i32 %t4, 0
  br i1 %t1816, label %whileBody142.lr.ph, label %common.ret

whileBody142.lr.ph:                               ; preds = %end139
  %t24 = sub i32 %t4, %t7
  %t2813 = icmp sgt i32 %t7, 0
  br label %whileBody142

whileBody142:                                     ; preds = %whileBody142.lr.ph, %end152
  %t12.018 = phi ptr [ %t14, %whileBody142.lr.ph ], [ %t67, %end152 ]
  %t15.017 = phi i32 [ 0, %whileBody142.lr.ph ], [ %t15.1, %end152 ]
  %t25.not = icmp sgt i32 %t15.017, %t24
  br i1 %t25.not, label %else154, label %whileCond147.preheader

whileCond147.preheader:                           ; preds = %whileBody142
  br i1 %t2813, label %whileBody148, label %end152

whileBody148:                                     ; preds = %whileCond147.preheader, %whileBody148
  %t19.015 = phi i1 [ %spec.select, %whileBody148 ], [ true, %whileCond147.preheader ]
  %t20.014 = phi i32 [ %t47, %whileBody148 ], [ 0, %whileCond147.preheader ]
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
  br i1 %t28, label %whileBody148, label %end144

end144:                                           ; preds = %whileBody148
  br i1 %spec.select, label %end152, label %else154

else154:                                          ; preds = %whileBody142, %end144
  %2 = sext i32 %t15.017 to i64
  %t63 = getelementptr i8, ptr %t0, i64 %2
  %t64 = load i8, ptr %t63, align 1
  %t65 = tail call ptr @_zen_char_to_string(i8 %t64)
  br label %end152

end152:                                           ; preds = %end144, %whileCond147.preheader, %else154
  %t65.sink = phi ptr [ %t65, %else154 ], [ %t2, %whileCond147.preheader ], [ %t2, %end144 ]
  %t7.pn = phi i32 [ 1, %else154 ], [ %t7, %whileCond147.preheader ], [ %t7, %end144 ]
  %t67 = tail call ptr @_str_concat(ptr %t12.018, ptr %t65.sink)
  tail call void @_zen_string_free(ptr %t12.018)
  %t15.1 = add i32 %t7.pn, %t15.017
  %t18 = icmp slt i32 %t15.1, %t4
  br i1 %t18, label %whileBody142, label %common.ret
}

define noundef i1 @contains(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %whileCond157.preheader

whileCond157.preheader:                           ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t15.not11 = icmp slt i32 %t14, 0
  br i1 %t15.not11, label %common.ret, label %whileCond160.preheader.lr.ph

whileCond160.preheader.lr.ph:                     ; preds = %whileCond157.preheader
  %t208 = icmp sgt i32 %t6, 0
  br label %whileCond160.preheader

common.ret:                                       ; preds = %whileCond160.preheader, %whileEnd162, %whileCond157, %whileCond157.preheader, %entry
  %common.ret.op = phi i1 [ true, %entry ], [ false, %whileCond157.preheader ], [ true, %whileCond160.preheader ], [ true, %whileEnd162 ], [ false, %whileCond157 ]
  ret i1 %common.ret.op

whileCond157:                                     ; preds = %whileEnd162
  %t43 = add i32 %t10.012, 1
  %t15.not = icmp sgt i32 %t43, %t14
  br i1 %t15.not, label %common.ret, label %whileCond160.preheader

whileCond160.preheader:                           ; preds = %whileCond160.preheader.lr.ph, %whileCond157
  %t10.012 = phi i32 [ 0, %whileCond160.preheader.lr.ph ], [ %t43, %whileCond157 ]
  br i1 %t208, label %whileBody161, label %common.ret

whileBody161:                                     ; preds = %whileCond160.preheader, %whileBody161
  %t16.010 = phi i1 [ %spec.select, %whileBody161 ], [ true, %whileCond160.preheader ]
  %t17.09 = phi i32 [ %t39, %whileBody161 ], [ 0, %whileCond160.preheader ]
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
  br i1 %t20, label %whileBody161, label %whileEnd162

whileEnd162:                                      ; preds = %whileBody161
  br i1 %spec.select, label %common.ret, label %whileCond157
}

define ptr @upperCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t105 = icmp sgt i32 %t2, 0
  br i1 %t105, label %whileBody168, label %whileEnd169

whileBody168:                                     ; preds = %entry, %end170
  %t4.07 = phi ptr [ %t41, %end170 ], [ %t6, %entry ]
  %t7.06 = phi i32 [ %t45, %end170 ], [ 0, %entry ]
  %0 = zext nneg i32 %t7.06 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @_string_to_int_ascii(ptr %t16)
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t25 = tail call i32 @_string_to_int_ascii(ptr %t24)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t30 = tail call i32 @_string_to_int_ascii(ptr %t29)
  %t26 = icmp sge i32 %t19, %t25
  %t31 = icmp sle i32 %t19, %t30
  %t21 = select i1 %t26, i1 %t31, i1 false
  br i1 %t21, label %if174, label %end170

if174:                                            ; preds = %whileBody168
  %t34 = add i32 %t19, -32
  %t35 = tail call ptr @_int_to_string_ascii(i32 %t34)
  br label %end170

end170:                                           ; preds = %whileBody168, %if174
  %t16.sink = phi ptr [ %t35, %if174 ], [ %t16, %whileBody168 ]
  %t41 = tail call ptr @_str_concat(ptr %t4.07, ptr %t16.sink)
  tail call void @_zen_string_free(ptr %t4.07)
  %t45 = add nuw nsw i32 %t7.06, 1
  %t10 = icmp slt i32 %t45, %t2
  br i1 %t10, label %whileBody168, label %whileEnd169

whileEnd169:                                      ; preds = %end170, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t41, %end170 ]
  ret ptr %t4.0.lcssa
}

define ptr @lowerCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t105 = icmp sgt i32 %t2, 0
  br i1 %t105, label %whileBody177, label %whileEnd178

whileBody177:                                     ; preds = %entry, %end179
  %t4.07 = phi ptr [ %t41, %end179 ], [ %t6, %entry ]
  %t7.06 = phi i32 [ %t45, %end179 ], [ 0, %entry ]
  %0 = zext nneg i32 %t7.06 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @_string_to_int_ascii(ptr %t16)
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t25 = tail call i32 @_string_to_int_ascii(ptr %t24)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t30 = tail call i32 @_string_to_int_ascii(ptr %t29)
  %t26 = icmp sge i32 %t19, %t25
  %t31 = icmp sle i32 %t19, %t30
  %t21 = select i1 %t26, i1 %t31, i1 false
  br i1 %t21, label %if183, label %end179

if183:                                            ; preds = %whileBody177
  %t34 = add i32 %t19, 32
  %t35 = tail call ptr @_int_to_string_ascii(i32 %t34)
  br label %end179

end179:                                           ; preds = %whileBody177, %if183
  %t16.sink = phi ptr [ %t35, %if183 ], [ %t16, %whileBody177 ]
  %t41 = tail call ptr @_str_concat(ptr %t4.07, ptr %t16.sink)
  tail call void @_zen_string_free(ptr %t4.07)
  %t45 = add nuw nsw i32 %t7.06, 1
  %t10 = icmp slt i32 %t45, %t2
  br i1 %t10, label %whileBody177, label %whileEnd178

whileEnd178:                                      ; preds = %end179, %entry
  %t4.0.lcssa = phi ptr [ %t6, %entry ], [ %t41, %end179 ]
  ret ptr %t4.0.lcssa
}

define noundef i1 @startsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp sgt i32 %t6, %t3
  br i1 %t10, label %common.ret, label %whileCond187.preheader

whileCond187.preheader:                           ; preds = %entry
  %t145 = icmp sgt i32 %t6, 0
  br i1 %t145, label %whileBody188, label %common.ret

common.ret:                                       ; preds = %whileBody188, %whileCond187.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond187.preheader ], [ %t28.not, %whileBody188 ]
  ret i1 %common.ret.op

whileBody188:                                     ; preds = %whileCond187.preheader, %whileBody188
  %t11.06 = phi i32 [ %t30, %whileBody188 ], [ 0, %whileCond187.preheader ]
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
  br i1 %or.cond, label %whileBody188, label %common.ret
}

define noundef i1 @endsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp sgt i32 %t6, %t3
  br i1 %t10, label %common.ret, label %whileCond194.preheader

whileCond194.preheader:                           ; preds = %entry
  %t18 = sub i32 %t3, %t6
  %t147 = icmp sgt i32 %t6, 0
  br i1 %t147, label %whileBody195, label %common.ret

common.ret:                                       ; preds = %whileBody195, %whileCond194.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond194.preheader ], [ %t32.not, %whileBody195 ]
  ret i1 %common.ret.op

whileBody195:                                     ; preds = %whileCond194.preheader, %whileBody195
  %t11.08 = phi i32 [ %t34, %whileBody195 ], [ 0, %whileCond194.preheader ]
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
  br i1 %or.cond, label %whileBody195, label %common.ret
}

define ptr @trim(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t1011 = icmp sgt i32 %t2, 0
  br i1 %t1011, label %whileBody200, label %whileEnd201

whileBody200:                                     ; preds = %entry, %if209
  %t4.012 = phi i32 [ %t36, %if209 ], [ 0, %entry ]
  %0 = zext nneg i32 %t4.012 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t22 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t27 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t23 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t22)
  %t24 = icmp eq i32 %t23, 0
  br i1 %t24, label %if209, label %rhs206

rhs206:                                           ; preds = %whileBody200
  %t28 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t27)
  %t29 = icmp eq i32 %t28, 0
  br i1 %t29, label %if209, label %rhs203

rhs203:                                           ; preds = %rhs206
  %t33 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t16, ptr noundef nonnull dereferenceable(1) %t32)
  %t34 = icmp eq i32 %t33, 0
  br i1 %t34, label %if209, label %whileEnd201

if209:                                            ; preds = %whileBody200, %rhs206, %rhs203
  %t36 = add nuw nsw i32 %t4.012, 1
  %t10 = icmp slt i32 %t36, %t2
  br i1 %t10, label %whileBody200, label %whileEnd201

whileEnd201:                                      ; preds = %if209, %rhs203, %entry
  %t4.0.lcssa = phi i32 [ 0, %entry ], [ %t4.012, %rhs203 ], [ %t2, %if209 ]
  %t5.014 = add i32 %t2, -1
  %t40.not15 = icmp slt i32 %t5.014, %t4.0.lcssa
  br i1 %t40.not15, label %whileEnd213, label %whileBody212

whileBody212:                                     ; preds = %whileEnd201, %if221
  %t5.016 = phi i32 [ %t5.0, %if221 ], [ %t5.014, %whileEnd201 ]
  %1 = sext i32 %t5.016 to i64
  %t44 = getelementptr i8, ptr %t0, i64 %1
  %t45 = load i8, ptr %t44, align 1
  %t46 = tail call ptr @_zen_char_to_string(i8 %t45)
  %t52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t57 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t53 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t52)
  %t54 = icmp eq i32 %t53, 0
  br i1 %t54, label %if221, label %rhs218

rhs218:                                           ; preds = %whileBody212
  %t58 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t57)
  %t59 = icmp eq i32 %t58, 0
  br i1 %t59, label %if221, label %rhs215

rhs215:                                           ; preds = %rhs218
  %t63 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(1) %t62)
  %t64 = icmp eq i32 %t63, 0
  br i1 %t64, label %if221, label %whileEnd213

if221:                                            ; preds = %whileBody212, %rhs218, %rhs215
  %t5.0 = add i32 %t5.016, -1
  %t40.not = icmp slt i32 %t5.0, %t4.0.lcssa
  br i1 %t40.not, label %whileEnd213, label %whileBody212

whileEnd213:                                      ; preds = %if221, %rhs215, %whileEnd201
  %t5.0.lcssa = phi i32 [ %t5.014, %whileEnd201 ], [ %t5.016, %rhs215 ], [ %t5.0, %if221 ]
  %t70 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t75.not19 = icmp sgt i32 %t4.0.lcssa, %t5.0.lcssa
  br i1 %t75.not19, label %whileEnd225, label %whileBody224

whileBody224:                                     ; preds = %whileEnd213, %whileBody224
  %t71.021 = phi i32 [ %t87, %whileBody224 ], [ %t4.0.lcssa, %whileEnd213 ]
  %t68.020 = phi ptr [ %t83, %whileBody224 ], [ %t70, %whileEnd213 ]
  %2 = sext i32 %t71.021 to i64
  %t79 = getelementptr i8, ptr %t0, i64 %2
  %t80 = load i8, ptr %t79, align 1
  %t81 = tail call ptr @_zen_char_to_string(i8 %t80)
  %t83 = tail call ptr @_str_concat(ptr %t68.020, ptr %t81)
  tail call void @_zen_string_free(ptr %t68.020)
  %t87 = add i32 %t71.021, 1
  %t75.not = icmp sgt i32 %t87, %t5.0.lcssa
  br i1 %t75.not, label %whileEnd225, label %whileBody224

whileEnd225:                                      ; preds = %whileBody224, %whileEnd213
  %t68.0.lcssa = phi ptr [ %t70, %whileEnd213 ], [ %t83, %whileBody224 ]
  ret ptr %t68.0.lcssa
}

define ptr @splitAt(ptr %t0, ptr %t1, i32 %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  %t12 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br i1 %t10, label %common.ret, label %end226

common.ret:                                       ; preds = %if240, %entry, %whileEnd230, %end244
  %common.ret.op = phi ptr [ %t86, %end244 ], [ %t15.0.lcssa, %whileEnd230 ], [ %t12, %entry ], [ %t15.022, %if240 ]
  ret ptr %common.ret.op

end226:                                           ; preds = %entry
  %t2021 = icmp sgt i32 %t4, 0
  br i1 %t2021, label %whileBody229.lr.ph, label %whileEnd230

whileBody229.lr.ph:                               ; preds = %end226
  %t26 = sub i32 %t4, %t7
  %t3018 = icmp sgt i32 %t7, 0
  br label %whileBody229

whileBody229:                                     ; preds = %whileBody229.lr.ph, %end239
  %t13.024 = phi i32 [ 0, %whileBody229.lr.ph ], [ %t13.1, %end239 ]
  %t14.023 = phi i32 [ 0, %whileBody229.lr.ph ], [ %t14.1, %end239 ]
  %t15.022 = phi ptr [ %t12, %whileBody229.lr.ph ], [ %t15.1, %end239 ]
  %t27.not = icmp sgt i32 %t13.024, %t26
  br i1 %t27.not, label %else241, label %whileCond234.preheader

whileCond234.preheader:                           ; preds = %whileBody229
  br i1 %t3018, label %whileBody235, label %if240

whileBody235:                                     ; preds = %whileCond234.preheader, %whileBody235
  %t22.020 = phi i32 [ %t49, %whileBody235 ], [ 0, %whileCond234.preheader ]
  %t21.019 = phi i1 [ %spec.select, %whileBody235 ], [ true, %whileCond234.preheader ]
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
  br i1 %t30, label %whileBody235, label %end231

end231:                                           ; preds = %whileBody235
  br i1 %spec.select, label %if240, label %else241

if240:                                            ; preds = %whileCond234.preheader, %end231
  %t55 = icmp eq i32 %t14.023, %t2
  br i1 %t55, label %common.ret, label %end242

end242:                                           ; preds = %if240
  %t58 = add i32 %t14.023, 1
  %t61 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end239

else241:                                          ; preds = %whileBody229, %end231
  %2 = sext i32 %t13.024 to i64
  %t71 = getelementptr i8, ptr %t0, i64 %2
  %t72 = load i8, ptr %t71, align 1
  %t73 = tail call ptr @_zen_char_to_string(i8 %t72)
  %t75 = tail call ptr @_str_concat(ptr %t15.022, ptr %t73)
  br label %end239

end239:                                           ; preds = %else241, %end242
  %t15.1 = phi ptr [ %t61, %end242 ], [ %t75, %else241 ]
  %t14.1 = phi i32 [ %t58, %end242 ], [ %t14.023, %else241 ]
  %t7.pn = phi i32 [ %t7, %end242 ], [ 1, %else241 ]
  tail call void @_zen_string_free(ptr %t15.022)
  %t13.1 = add i32 %t7.pn, %t13.024
  %t20 = icmp slt i32 %t13.1, %t4
  br i1 %t20, label %whileBody229, label %whileEnd230

whileEnd230:                                      ; preds = %end239, %end226
  %t15.0.lcssa = phi ptr [ %t12, %end226 ], [ %t15.1, %end239 ]
  %t14.0.lcssa = phi i32 [ 0, %end226 ], [ %t14.1, %end239 ]
  %t83 = icmp eq i32 %t14.0.lcssa, %t2
  br i1 %t83, label %common.ret, label %end244

end244:                                           ; preds = %whileEnd230
  %t86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret
}

define ptr @repeat(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = icmp slt i32 %t1, 1
  br i1 %t3, label %common.ret.sink.split, label %end246

common.ret.sink.split:                            ; preds = %end246, %entry
  %t10 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

common.ret:                                       ; preds = %whileBody251, %common.ret.sink.split
  %common.ret.op = phi ptr [ %t10, %common.ret.sink.split ], [ %t18, %whileBody251 ]
  ret ptr %common.ret.op

end246:                                           ; preds = %entry
  %t7 = tail call i32 @strlen(ptr %t0)
  %t8 = icmp eq i32 %t7, 0
  br i1 %t8, label %common.ret.sink.split, label %whileBody251.preheader

whileBody251.preheader:                           ; preds = %end246
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %whileBody251

whileBody251:                                     ; preds = %whileBody251.preheader, %whileBody251
  %count.addr.05 = phi i32 [ %t22, %whileBody251 ], [ %t1, %whileBody251.preheader ]
  %t11.04 = phi ptr [ %t18, %whileBody251 ], [ %t13, %whileBody251.preheader ]
  %t18 = tail call ptr @_str_concat(ptr %t11.04, ptr %t0)
  tail call void @_zen_string_free(ptr %t11.04)
  %t22 = add nsw i32 %count.addr.05, -1
  %t15 = icmp samesign ugt i32 %count.addr.05, 1
  br i1 %t15, label %whileBody251, label %common.ret
}

define i32 @count(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t4 = icmp eq i32 %t3, 0
  br i1 %t4, label %common.ret, label %end253

common.ret:                                       ; preds = %charAt.exit, %whileCond257.preheader, %end253, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ 0, %end253 ], [ 0, %whileCond257.preheader ], [ %spec.select, %charAt.exit ]
  ret i32 %common.ret.op

end253:                                           ; preds = %entry
  %t6 = tail call i32 @strlen(ptr %t1)
  %t7 = icmp eq i32 %t6, 0
  br i1 %t7, label %common.ret, label %whileCond257.preheader

whileCond257.preheader:                           ; preds = %end253
  %t124 = tail call i32 @strlen(ptr %t0)
  %t135 = icmp sgt i32 %t124, 0
  br i1 %t135, label %whileBody258, label %common.ret

whileBody258:                                     ; preds = %whileCond257.preheader, %charAt.exit
  %t8.07 = phi i32 [ %spec.select, %charAt.exit ], [ 0, %whileCond257.preheader ]
  %t9.06 = phi i32 [ %t23, %charAt.exit ], [ 0, %whileCond257.preheader ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i.not = icmp slt i32 %t9.06, %t3.i
  br i1 %t10.i.not, label %end116.i, label %if120.i

if120.i:                                          ; preds = %whileBody258
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %whileBody258
  %0 = zext nneg i32 %t9.06 to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i, %if120.i ], [ %t17.i, %end116.i ]
  %t18 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t1)
  %t19 = icmp eq i32 %t18, 0
  %t21 = zext i1 %t19 to i32
  %spec.select = add i32 %t8.07, %t21
  %t23 = add nuw nsw i32 %t9.06, 1
  %t12 = tail call i32 @strlen(ptr %t0)
  %t13 = icmp slt i32 %t23, %t12
  br i1 %t13, label %whileBody258, label %common.ret
}

define ptr @padStart(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end262, label %common.ret

common.ret:                                       ; preds = %end262, %entry, %whileEnd268
  %common.ret.op = phi ptr [ %t31, %whileEnd268 ], [ %t0, %entry ], [ %t0, %end262 ]
  ret ptr %common.ret.op

end262:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end264

end264:                                           ; preds = %end262
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t19 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t213 = icmp sgt i32 %t16, 0
  br i1 %t213, label %whileBody267, label %whileEnd268

whileBody267:                                     ; preds = %end264, %whileBody267
  %t12.05 = phi i32 [ %t28, %whileBody267 ], [ %t16, %end264 ]
  %t17.04 = phi ptr [ %t24, %whileBody267 ], [ %t19, %end264 ]
  %t24 = tail call ptr @_str_concat(ptr %t17.04, ptr %t2)
  tail call void @_zen_string_free(ptr %t17.04)
  %t28 = add nsw i32 %t12.05, -1
  %t21 = icmp samesign ugt i32 %t12.05, 1
  br i1 %t21, label %whileBody267, label %whileEnd268

whileEnd268:                                      ; preds = %whileBody267, %end264
  %t17.0.lcssa = phi ptr [ %t19, %end264 ], [ %t24, %whileBody267 ]
  %t31 = tail call ptr @_str_concat(ptr %t17.0.lcssa, ptr %t0)
  br label %common.ret
}

define ptr @padEnd(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end269, label %common.ret

common.ret:                                       ; preds = %whileBody274, %end271, %end269, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t0, %end269 ], [ %t0, %end271 ], [ %t23, %whileBody274 ]
  ret ptr %common.ret.op

end269:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end271

end271:                                           ; preds = %end269
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t203 = icmp sgt i32 %t16, 0
  br i1 %t203, label %whileBody274, label %common.ret

whileBody274:                                     ; preds = %end271, %whileBody274
  %t12.05 = phi i32 [ %t27, %whileBody274 ], [ %t16, %end271 ]
  %t17.04 = phi ptr [ %t23, %whileBody274 ], [ %t0, %end271 ]
  %t23 = tail call ptr @_str_concat(ptr %t17.04, ptr %t2)
  tail call void @_zen_string_free(ptr %t17.04)
  %t27 = add nsw i32 %t12.05, -1
  %t20 = icmp samesign ugt i32 %t12.05, 1
  br i1 %t20, label %whileBody274, label %common.ret
}

define ptr @padCenter(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end276, label %common.ret

common.ret:                                       ; preds = %end276, %entry, %whileEnd285
  %common.ret.op = phi ptr [ %t52, %whileEnd285 ], [ %t0, %entry ], [ %t0, %end276 ]
  ret ptr %common.ret.op

end276:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end278

end278:                                           ; preds = %end276
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t19 = sdiv i32 %t16, 2
  %t23 = sub i32 %t16, %t19
  %t26 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t316 = icmp sgt i32 %t16, 1
  br i1 %t316, label %whileBody281, label %whileCond283.preheader

whileCond283.preheader:                           ; preds = %whileBody281, %end278
  %t24.0.lcssa = phi ptr [ %t26, %end278 ], [ %t34, %whileBody281 ]
  %t409 = icmp sgt i32 %t23, 0
  br i1 %t409, label %whileBody284, label %whileEnd285

whileBody281:                                     ; preds = %end278, %whileBody281
  %t17.08 = phi i32 [ %t38, %whileBody281 ], [ %t19, %end278 ]
  %t24.07 = phi ptr [ %t34, %whileBody281 ], [ %t26, %end278 ]
  %t34 = tail call ptr @_str_concat(ptr %t24.07, ptr %t2)
  tail call void @_zen_string_free(ptr %t24.07)
  %t38 = add nsw i32 %t17.08, -1
  %t31 = icmp sgt i32 %t17.08, 1
  br i1 %t31, label %whileBody281, label %whileCond283.preheader

whileBody284:                                     ; preds = %whileCond283.preheader, %whileBody284
  %t20.011 = phi i32 [ %t47, %whileBody284 ], [ %t23, %whileCond283.preheader ]
  %t27.010 = phi ptr [ %t43, %whileBody284 ], [ %t29, %whileCond283.preheader ]
  %t43 = tail call ptr @_str_concat(ptr %t27.010, ptr %t2)
  tail call void @_zen_string_free(ptr %t27.010)
  %t47 = add nsw i32 %t20.011, -1
  %t40 = icmp samesign ugt i32 %t20.011, 1
  br i1 %t40, label %whileBody284, label %whileEnd285

whileEnd285:                                      ; preds = %whileBody284, %whileCond283.preheader
  %t27.0.lcssa = phi ptr [ %t29, %whileCond283.preheader ], [ %t43, %whileBody284 ]
  %t50 = tail call ptr @_str_concat(ptr %t24.0.lcssa, ptr %t0)
  %t52 = tail call ptr @_str_concat(ptr %t50, ptr %t27.0.lcssa)
  tail call void @_zen_string_free(ptr %t50)
  br label %common.ret
}

define ptr @capitalize(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t3 = icmp eq i32 %t2, 0
  br i1 %t3, label %if287, label %end286

common.ret:                                       ; preds = %whileBody295, %end288, %if287
  %common.ret.op = phi ptr [ %t5, %if287 ], [ %t38, %end288 ], [ %t55, %whileBody295 ]
  ret ptr %common.ret.op

if287:                                            ; preds = %entry
  %t5 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret

end286:                                           ; preds = %entry
  %t9 = load i8, ptr %t0, align 1
  %t10 = tail call ptr @_zen_char_to_string(i8 %t9)
  %t13 = tail call i32 @_string_to_int_ascii(ptr %t10)
  %t17 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t21 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t22 = tail call i32 @_string_to_int_ascii(ptr %t21)
  %t26 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t27 = tail call i32 @_string_to_int_ascii(ptr %t26)
  %t23 = icmp sge i32 %t13, %t22
  %t28 = icmp sle i32 %t13, %t27
  %t18 = select i1 %t23, i1 %t28, i1 false
  br i1 %t18, label %if292, label %end288

if292:                                            ; preds = %end286
  %t31 = add i32 %t13, -32
  %t32 = tail call ptr @_int_to_string_ascii(i32 %t31)
  br label %end288

end288:                                           ; preds = %end286, %if292
  %t10.sink = phi ptr [ %t32, %if292 ], [ %t10, %end286 ]
  %t38 = tail call ptr @_str_concat(ptr %t17, ptr %t10.sink)
  tail call void @_zen_string_free(ptr %t17)
  %t43 = tail call i32 @strlen(ptr nonnull %t0)
  %t475 = icmp sgt i32 %t43, 1
  br i1 %t475, label %whileBody295, label %common.ret

whileBody295:                                     ; preds = %end288, %whileBody295
  %t15.17 = phi ptr [ %t55, %whileBody295 ], [ %t38, %end288 ]
  %t41.06 = phi i32 [ %t59, %whileBody295 ], [ 1, %end288 ]
  %0 = zext nneg i32 %t41.06 to i64
  %t51 = getelementptr i8, ptr %t0, i64 %0
  %t52 = load i8, ptr %t51, align 1
  %t53 = tail call ptr @_zen_char_to_string(i8 %t52)
  %t55 = tail call ptr @_str_concat(ptr %t15.17, ptr %t53)
  tail call void @_zen_string_free(ptr %t15.17)
  %t59 = add nuw nsw i32 %t41.06, 1
  %t47 = icmp slt i32 %t59, %t43
  br i1 %t47, label %whileBody295, label %common.ret
}

define ptr @extName(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  br label %whileCond297

whileCond297:                                     ; preds = %whileBody298, %entry
  %t4.0.in = phi i32 [ %t2, %entry ], [ %t4.0, %whileBody298 ]
  %t4.0 = add i32 %t4.0.in, -1
  %t8 = icmp sgt i32 %t4.0, -1
  br i1 %t8, label %whileBody298, label %whileEnd299

whileBody298:                                     ; preds = %whileCond297
  %t16 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %0 = zext nneg i32 %t4.0 to i64
  %t11 = getelementptr i8, ptr %t0, i64 %0
  %t12 = load i8, ptr %t11, align 1
  %t13 = tail call ptr @_zen_char_to_string(i8 %t12)
  %t17 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t13, ptr noundef nonnull dereferenceable(1) %t16)
  %t18 = icmp eq i32 %t17, 0
  br i1 %t18, label %if301, label %whileCond297

if301:                                            ; preds = %whileBody298
  %t24 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t278 = icmp slt i32 %t4.0.in, %t2
  br i1 %t278, label %whileBody303, label %common.ret

whileBody303:                                     ; preds = %if301, %whileBody303
  %t22.010 = phi ptr [ %t35, %whileBody303 ], [ %t24, %if301 ]
  %t19.09 = phi i32 [ %t39, %whileBody303 ], [ %t4.0.in, %if301 ]
  %1 = sext i32 %t19.09 to i64
  %t31 = getelementptr i8, ptr %t0, i64 %1
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t35 = tail call ptr @_str_concat(ptr %t22.010, ptr %t33)
  tail call void @_zen_string_free(ptr %t22.010)
  %t39 = add nsw i32 %t19.09, 1
  %t27 = icmp slt i32 %t39, %t2
  br i1 %t27, label %whileBody303, label %common.ret

common.ret:                                       ; preds = %whileBody303, %if301, %whileEnd299
  %common.ret.op = phi ptr [ %t46, %whileEnd299 ], [ %t24, %if301 ], [ %t35, %whileBody303 ]
  ret ptr %common.ret.op

whileEnd299:                                      ; preds = %whileCond297
  %t46 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @sin(double %t0) local_unnamed_addr #2 {
entry:
  %t2 = load double, ptr @PI, align 8
  %t31 = fcmp ogt double %t0, %t2
  br i1 %t31, label %whileBody306.lr.ph, label %whileCond308.preheader

whileBody306.lr.ph:                               ; preds = %entry
  %t5 = load double, ptr @TAU, align 8
  br label %whileBody306

whileCond308.preheader:                           ; preds = %whileBody306, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t6, %whileBody306 ]
  %t10 = fsub double 0.000000e+00, %t2
  %t114 = fcmp olt double %x.addr.0.lcssa, %t10
  br i1 %t114, label %whileBody309.lr.ph, label %whileEnd310

whileBody309.lr.ph:                               ; preds = %whileCond308.preheader
  %t13 = load double, ptr @TAU, align 8
  br label %whileBody309

whileBody306:                                     ; preds = %whileBody306.lr.ph, %whileBody306
  %x.addr.02 = phi double [ %t0, %whileBody306.lr.ph ], [ %t6, %whileBody306 ]
  %t6 = fsub double %x.addr.02, %t5
  %t3 = fcmp ogt double %t6, %t2
  br i1 %t3, label %whileBody306, label %whileCond308.preheader

whileBody309:                                     ; preds = %whileBody309.lr.ph, %whileBody309
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody309.lr.ph ], [ %t14, %whileBody309 ]
  %t14 = fadd double %x.addr.15, %t13
  %t11 = fcmp olt double %t14, %t10
  br i1 %t11, label %whileBody309, label %whileEnd310

whileEnd310:                                      ; preds = %whileBody309, %whileCond308.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond308.preheader ], [ %t14, %whileBody309 ]
  %t19 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t21 = fmul double %x.addr.1.lcssa, %t19
  %t22 = fdiv double %t21, 6.000000e+00
  %t23 = fsub double %x.addr.1.lcssa, %t22
  ret double %t23
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @cos(double %t0) local_unnamed_addr #2 {
entry:
  %t2 = load double, ptr @PI, align 8
  %t31 = fcmp ogt double %t0, %t2
  br i1 %t31, label %whileBody312.lr.ph, label %whileCond314.preheader

whileBody312.lr.ph:                               ; preds = %entry
  %t5 = load double, ptr @TAU, align 8
  br label %whileBody312

whileCond314.preheader:                           ; preds = %whileBody312, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t6, %whileBody312 ]
  %t10 = fsub double 0.000000e+00, %t2
  %t114 = fcmp olt double %x.addr.0.lcssa, %t10
  br i1 %t114, label %whileBody315.lr.ph, label %whileEnd316

whileBody315.lr.ph:                               ; preds = %whileCond314.preheader
  %t13 = load double, ptr @TAU, align 8
  br label %whileBody315

whileBody312:                                     ; preds = %whileBody312.lr.ph, %whileBody312
  %x.addr.02 = phi double [ %t0, %whileBody312.lr.ph ], [ %t6, %whileBody312 ]
  %t6 = fsub double %x.addr.02, %t5
  %t3 = fcmp ogt double %t6, %t2
  br i1 %t3, label %whileBody312, label %whileCond314.preheader

whileBody315:                                     ; preds = %whileBody315.lr.ph, %whileBody315
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody315.lr.ph ], [ %t14, %whileBody315 ]
  %t14 = fadd double %x.addr.15, %t13
  %t11 = fcmp olt double %t14, %t10
  br i1 %t11, label %whileBody315, label %whileEnd316

whileEnd316:                                      ; preds = %whileBody315, %whileCond314.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond314.preheader ], [ %t14, %whileBody315 ]
  %t18 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t19 = fmul double %t18, 5.000000e-01
  %t20 = fsub double 1.000000e+00, %t19
  ret double %t20
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @tan(double %t0) local_unnamed_addr #2 {
entry:
  %t2.i = load double, ptr @PI, align 8
  %t31.i = fcmp ogt double %t0, %t2.i
  br i1 %t31.i, label %whileBody306.lr.ph.i, label %whileCond308.preheader.i

whileBody306.lr.ph.i:                             ; preds = %entry
  %t5.i = load double, ptr @TAU, align 8
  br label %whileBody306.i

whileCond308.preheader.i:                         ; preds = %whileBody306.i, %entry
  %x.addr.0.lcssa.i = phi double [ %t0, %entry ], [ %t6.i, %whileBody306.i ]
  %t10.i = fsub double 0.000000e+00, %t2.i
  %t114.i = fcmp olt double %x.addr.0.lcssa.i, %t10.i
  br i1 %t114.i, label %whileBody309.lr.ph.i, label %sin.exit

whileBody309.lr.ph.i:                             ; preds = %whileCond308.preheader.i
  %t13.i = load double, ptr @TAU, align 8
  br label %whileBody309.i

whileBody306.i:                                   ; preds = %whileBody306.i, %whileBody306.lr.ph.i
  %x.addr.02.i = phi double [ %t0, %whileBody306.lr.ph.i ], [ %t6.i, %whileBody306.i ]
  %t6.i = fsub double %x.addr.02.i, %t5.i
  %t3.i = fcmp ogt double %t6.i, %t2.i
  br i1 %t3.i, label %whileBody306.i, label %whileCond308.preheader.i

whileBody309.i:                                   ; preds = %whileBody309.i, %whileBody309.lr.ph.i
  %x.addr.15.i = phi double [ %x.addr.0.lcssa.i, %whileBody309.lr.ph.i ], [ %t14.i, %whileBody309.i ]
  %t14.i = fadd double %t13.i, %x.addr.15.i
  %t11.i = fcmp olt double %t14.i, %t10.i
  br i1 %t11.i, label %whileBody309.i, label %sin.exit

sin.exit:                                         ; preds = %whileBody309.i, %whileCond308.preheader.i
  %x.addr.1.lcssa.i = phi double [ %x.addr.0.lcssa.i, %whileCond308.preheader.i ], [ %t14.i, %whileBody309.i ]
  br i1 %t31.i, label %whileBody312.lr.ph.i, label %whileCond314.preheader.i

whileBody312.lr.ph.i:                             ; preds = %sin.exit
  %t5.i12 = load double, ptr @TAU, align 8
  br label %whileBody312.i

whileCond314.preheader.i:                         ; preds = %whileBody312.i, %sin.exit
  %x.addr.0.lcssa.i3 = phi double [ %t0, %sin.exit ], [ %t6.i14, %whileBody312.i ]
  %t114.i5 = fcmp olt double %x.addr.0.lcssa.i3, %t10.i
  br i1 %t114.i5, label %whileBody315.lr.ph.i, label %cos.exit

whileBody315.lr.ph.i:                             ; preds = %whileCond314.preheader.i
  %t13.i8 = load double, ptr @TAU, align 8
  br label %whileBody315.i

whileBody312.i:                                   ; preds = %whileBody312.i, %whileBody312.lr.ph.i
  %x.addr.02.i13 = phi double [ %t0, %whileBody312.lr.ph.i ], [ %t6.i14, %whileBody312.i ]
  %t6.i14 = fsub double %x.addr.02.i13, %t5.i12
  %t3.i15 = fcmp ogt double %t6.i14, %t2.i
  br i1 %t3.i15, label %whileBody312.i, label %whileCond314.preheader.i

whileBody315.i:                                   ; preds = %whileBody315.i, %whileBody315.lr.ph.i
  %x.addr.15.i9 = phi double [ %x.addr.0.lcssa.i3, %whileBody315.lr.ph.i ], [ %t14.i10, %whileBody315.i ]
  %t14.i10 = fadd double %t13.i8, %x.addr.15.i9
  %t11.i11 = fcmp olt double %t14.i10, %t10.i
  br i1 %t11.i11, label %whileBody315.i, label %cos.exit

cos.exit:                                         ; preds = %whileBody315.i, %whileCond314.preheader.i
  %x.addr.1.lcssa.i6 = phi double [ %x.addr.0.lcssa.i3, %whileCond314.preheader.i ], [ %t14.i10, %whileBody315.i ]
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
define double @log(double %t0) local_unnamed_addr #1 {
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
define double @exp(double %t0) local_unnamed_addr #1 {
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
define i32 @randomInt(i32 %t0, i32 %t1) local_unnamed_addr #3 {
entry:
  %t0.i = load i32, ptr @SEED, align 4
  %t3.i = load i32, ptr @I32_MAX, align 4
  %t1.i = mul i32 %t0.i, 1103515245
  %t2.i = add i32 %t1.i, 12345
  %t4.i = srem i32 %t2.i, %t3.i
  %t7.i = icmp slt i32 %t4.i, 0
  %t10.i = select i1 %t7.i, i32 %t3.i, i32 0
  %spec.select.i = add i32 %t10.i, %t4.i
  store i32 %spec.select.i, ptr @SEED, align 4
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
define double @random() local_unnamed_addr #3 {
entry:
  %t0 = load i32, ptr @SEED, align 4
  %t3 = load i32, ptr @I32_MAX, align 4
  %t1 = mul i32 %t0, 1103515245
  %t2 = add i32 %t1, 12345
  %t4 = srem i32 %t2, %t3
  %t7 = icmp slt i32 %t4, 0
  %t10 = select i1 %t7, i32 %t3, i32 0
  %spec.select = add i32 %t4, %t10
  store i32 %spec.select, ptr @SEED, align 4
  %t13 = sitofp i32 %spec.select to double
  %t14 = fdiv double %t13, 0x41DFFFFFFFC00000
  ret double %t14
}

define i1 @match(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t4316 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t5317 = tail call i1 @contains(ptr %t1, ptr %t4316)
  br i1 %t5317, label %if326, label %whileCond335.preheader

tailrecurse.loopexit:                             ; preds = %end330, %if326
  %t6.0.lcssa = phi ptr [ %t8, %if326 ], [ %t6.1, %end330 ]
  %t4 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t5 = tail call i1 @contains(ptr %t6.0.lcssa, ptr %t4)
  br i1 %t5, label %if326, label %whileCond335.preheader

whileCond335.preheader:                           ; preds = %tailrecurse.loopexit, %entry
  %t1.tr.lcssa = phi ptr [ %t1, %entry ], [ %t6.0.lcssa, %tailrecurse.loopexit ]
  %t45335 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t46336 = icmp sgt i32 %t45335, 0
  br i1 %t46336, label %whileBody336, label %whileEnd337

if326:                                            ; preds = %entry, %tailrecurse.loopexit
  %t1.tr318 = phi ptr [ %t6.0.lcssa, %tailrecurse.loopexit ], [ %t1, %entry ]
  %t8 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t12312 = tail call i32 @strlen(ptr %t1.tr318)
  %t13313 = icmp sgt i32 %t12312, 0
  br i1 %t13313, label %whileBody328, label %tailrecurse.loopexit

whileBody328:                                     ; preds = %if326, %end330
  %t6.0315 = phi ptr [ %t6.1, %end330 ], [ %t8, %if326 ]
  %t9.0314 = phi i32 [ %t36, %end330 ], [ 0, %if326 ]
  %t3.i = tail call i32 @strlen(ptr %t1.tr318)
  %t10.i.not = icmp slt i32 %t9.0314, %t3.i
  br i1 %t10.i.not, label %end116.i, label %if120.i

if120.i:                                          ; preds = %whileBody328
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %whileBody328
  %0 = zext nneg i32 %t9.0314 to i64
  %t15.i = getelementptr i8, ptr %t1.tr318, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i, %if120.i ], [ %t17.i, %end116.i ]
  %t20 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t21 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t20)
  %t22 = icmp eq i32 %t21, 0
  br i1 %t22, label %if331, label %else332

if331:                                            ; preds = %charAt.exit
  %t25 = tail call i1 @match(ptr %t0, ptr %t6.0315)
  br i1 %t25, label %common.ret, label %end333

common.ret:                                       ; preds = %if331, %charAt.exit270, %charAt.exit123, %charAt.exit294, %end455, %rhs471, %slice.exit225, %rhs379, %if375, %charAt.exit147, %if369, %charAt.exit135, %if363, %rhs358, %if354, %if339, %else469, %whileCond475.backedge, %slice.exit99, %whileCond346, %whileCond402.preheader, %whileCond346.preheader, %rhs417, %if413, %whileEnd404, %end395, %if343, %whileEnd337, %if454, %whileEnd432, %end410
  %common.ret.op = phi i1 [ %t312, %end410 ], [ %t415, %whileEnd432 ], [ %t424, %if454 ], [ %t540, %whileEnd337 ], [ true, %if343 ], [ false, %end395 ], [ false, %whileEnd404 ], [ false, %if413 ], [ false, %rhs417 ], [ false, %whileCond346.preheader ], [ false, %whileCond402.preheader ], [ %t97, %whileCond346 ], [ %t97, %slice.exit99 ], [ false, %whileCond475.backedge ], [ false, %else469 ], [ false, %if339 ], [ false, %if354 ], [ false, %rhs358 ], [ false, %if363 ], [ false, %charAt.exit135 ], [ false, %if369 ], [ false, %charAt.exit147 ], [ false, %if375 ], [ false, %rhs379 ], [ false, %slice.exit225 ], [ false, %rhs471 ], [ false, %end455 ], [ false, %charAt.exit294 ], [ false, %charAt.exit123 ], [ false, %charAt.exit270 ], [ true, %if331 ]
  ret i1 %common.ret.op

end333:                                           ; preds = %if331
  %t27 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end330

else332:                                          ; preds = %charAt.exit
  %t32 = tail call ptr @_str_concat(ptr %t6.0315, ptr nonnull %common.ret.op.i)
  br label %end330

end330:                                           ; preds = %else332, %end333
  %t6.1 = phi ptr [ %t27, %end333 ], [ %t32, %else332 ]
  tail call void @_zen_string_free(ptr %t6.0315)
  %t36 = add nuw nsw i32 %t9.0314, 1
  %t12 = tail call i32 @strlen(ptr %t1.tr318)
  %t13 = icmp slt i32 %t36, %t12
  br i1 %t13, label %whileBody328, label %tailrecurse.loopexit

whileBody336:                                     ; preds = %whileCond335.preheader, %whileCond335.backedge
  %t41.0339 = phi i32 [ %t41.0.be, %whileCond335.backedge ], [ 0, %whileCond335.preheader ]
  %t42.0337 = phi i32 [ %t42.0.be, %whileCond335.backedge ], [ 0, %whileCond335.preheader ]
  %t3.i68 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i69 = icmp slt i32 %t42.0337, 0
  %t10.i70 = icmp sge i32 %t42.0337, %t3.i68
  %t5.i71 = select i1 %t7.i69, i1 true, i1 %t10.i70
  br i1 %t5.i71, label %if120.i77, label %end116.i72

if120.i77:                                        ; preds = %whileBody336
  %t12.i78 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit79

end116.i72:                                       ; preds = %whileBody336
  %1 = zext nneg i32 %t42.0337 to i64
  %t15.i73 = getelementptr i8, ptr %t1.tr.lcssa, i64 %1
  %t16.i74 = load i8, ptr %t15.i73, align 1
  %t17.i75 = tail call ptr @_zen_char_to_string(i8 %t16.i74)
  br label %charAt.exit79

charAt.exit79:                                    ; preds = %if120.i77, %end116.i72
  %common.ret.op.i76 = phi ptr [ %t12.i78, %if120.i77 ], [ %t17.i75, %end116.i72 ]
  %t53 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_10)
  %t54 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t53)
  %t55 = icmp eq i32 %t54, 0
  br i1 %t55, label %if339, label %end338

if339:                                            ; preds = %charAt.exit79
  %t58 = tail call i32 @strlen(ptr %t0)
  %t59.not = icmp slt i32 %t41.0339, %t58
  br i1 %t59.not, label %end340, label %common.ret

end340:                                           ; preds = %if339
  %t64 = add nsw i32 %t42.0337, 1
  br label %whileCond335.backedge

whileCond335.backedge:                            ; preds = %end340, %end357, %end366, %end372, %end378, %end482, %end486
  %t42.0.be = phi i32 [ %t64, %end340 ], [ %t139, %end357 ], [ %t163, %end366 ], [ %t187, %end372 ], [ %t217, %end378 ], [ %t519, %end482 ], [ %t535, %end486 ]
  %t41.0.be = add i32 %t41.0339, 1
  %t45 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t46 = icmp slt i32 %t42.0.be, %t45
  br i1 %t46, label %whileBody336, label %whileEnd337

end338:                                           ; preds = %charAt.exit79
  %t68 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_11)
  %t69 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t68)
  %t70 = icmp eq i32 %t69, 0
  br i1 %t70, label %if343, label %end342

if343:                                            ; preds = %end338
  %t74 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t72 = add nsw i32 %t42.0337, 1
  %t75.not = icmp slt i32 %t72, %t74
  br i1 %t75.not, label %whileCond346.preheader, label %common.ret

whileCond346.preheader:                           ; preds = %if343
  %t80354 = tail call i32 @strlen(ptr %t0)
  %t81.not355 = icmp sgt i32 %t41.0339, %t80354
  br i1 %t81.not355, label %common.ret, label %whileBody347.lr.ph

whileBody347.lr.ph:                               ; preds = %whileCond346.preheader
  %spec.store.select.i83 = tail call i32 @llvm.smax.i32(i32 %t72, i32 0)
  br label %whileBody347

whileCond346:                                     ; preds = %slice.exit99
  %t99 = add i32 %t76.0356, 1
  %t80 = tail call i32 @strlen(ptr %t0)
  %t81.not = icmp sgt i32 %t99, %t80
  br i1 %t81.not, label %common.ret, label %whileBody347

whileBody347:                                     ; preds = %whileBody347.lr.ph, %whileCond346
  %t76.0356 = phi i32 [ %t41.0339, %whileBody347.lr.ph ], [ %t99, %whileCond346 ]
  %t85 = tail call i32 @strlen(ptr %t0)
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t76.0356, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t85, i32 %t4.i)
  %t16.i80 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i80, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileBody347, %whileBody114.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody114.i ], [ %t18.i, %whileBody347 ]
  %t22.09.i = phi i32 [ %t38.i, %whileBody114.i ], [ %spec.store.select.i, %whileBody347 ]
  %2 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t0, i64 %2
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  tail call void @_zen_string_free(ptr %t19.010.i)
  %t38.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t38.i, %spec.select.i
  br i1 %t26.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileBody347
  %common.ret.op.i81 = phi ptr [ %t18.i, %whileBody347 ], [ %t34.i, %whileBody114.i ]
  %t92 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t4.i82 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %spec.select.i84 = tail call i32 @llvm.smin.i32(i32 %t92, i32 %t4.i82)
  %t16.i85 = icmp sle i32 %spec.store.select.i83, %spec.select.i84
  %t18.i86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i87 = icmp samesign ult i32 %spec.store.select.i83, %spec.select.i84
  %or.cond.i88 = select i1 %t16.i85, i1 %t268.i87, i1 false
  br i1 %or.cond.i88, label %whileBody114.i90, label %slice.exit99

whileBody114.i90:                                 ; preds = %slice.exit, %whileBody114.i90
  %t19.010.i91 = phi ptr [ %t34.i96, %whileBody114.i90 ], [ %t18.i86, %slice.exit ]
  %t22.09.i92 = phi i32 [ %t38.i97, %whileBody114.i90 ], [ %spec.store.select.i83, %slice.exit ]
  %3 = zext nneg i32 %t22.09.i92 to i64
  %t30.i93 = getelementptr i8, ptr %t1.tr.lcssa, i64 %3
  %t31.i94 = load i8, ptr %t30.i93, align 1
  %t32.i95 = tail call ptr @_zen_char_to_string(i8 %t31.i94)
  %t34.i96 = tail call ptr @_str_concat(ptr %t19.010.i91, ptr %t32.i95)
  tail call void @_zen_string_free(ptr %t19.010.i91)
  %t38.i97 = add nuw nsw i32 %t22.09.i92, 1
  %t26.i98 = icmp slt i32 %t38.i97, %spec.select.i84
  br i1 %t26.i98, label %whileBody114.i90, label %slice.exit99

slice.exit99:                                     ; preds = %whileBody114.i90, %slice.exit
  %common.ret.op.i89 = phi ptr [ %t18.i86, %slice.exit ], [ %t34.i96, %whileBody114.i90 ]
  %t97 = tail call i1 @match(ptr %common.ret.op.i81, ptr %common.ret.op.i89)
  br i1 %t97, label %common.ret, label %whileCond346

end342:                                           ; preds = %end338
  %t103 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_12)
  %t104 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t103)
  %t105 = icmp eq i32 %t104, 0
  br i1 %t105, label %if352, label %end351

if352:                                            ; preds = %end342
  %t108 = add nsw i32 %t42.0337, 1
  %t3.i100 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i101 = icmp slt i32 %t42.0337, -1
  %t10.i102 = icmp sge i32 %t108, %t3.i100
  %t5.i103 = select i1 %t7.i101, i1 true, i1 %t10.i102
  br i1 %t5.i103, label %if120.i109, label %end116.i104

if120.i109:                                       ; preds = %if352
  %t12.i110 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit111

end116.i104:                                      ; preds = %if352
  %4 = zext nneg i32 %t108 to i64
  %t15.i105 = getelementptr i8, ptr %t1.tr.lcssa, i64 %4
  %t16.i106 = load i8, ptr %t15.i105, align 1
  %t17.i107 = tail call ptr @_zen_char_to_string(i8 %t16.i106)
  br label %charAt.exit111

charAt.exit111:                                   ; preds = %if120.i109, %end116.i104
  %common.ret.op.i108 = phi ptr [ %t12.i110, %if120.i109 ], [ %t17.i107, %end116.i104 ]
  %t113 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_13)
  %t114 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t113)
  %t115 = icmp eq i32 %t114, 0
  br i1 %t115, label %if354, label %end353

if354:                                            ; preds = %charAt.exit111
  %t118 = tail call i32 @strlen(ptr %t0)
  %t119.not = icmp slt i32 %t41.0339, %t118
  br i1 %t119.not, label %end355, label %common.ret

end355:                                           ; preds = %if354
  %t3.i112 = tail call i32 @strlen(ptr %t0)
  %t7.i113 = icmp slt i32 %t41.0339, 0
  %t10.i114 = icmp sge i32 %t41.0339, %t3.i112
  %t5.i115 = select i1 %t7.i113, i1 true, i1 %t10.i114
  br i1 %t5.i115, label %if120.i121, label %end116.i116

if120.i121:                                       ; preds = %end355
  %t12.i122 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit123

end116.i116:                                      ; preds = %end355
  %5 = zext nneg i32 %t41.0339 to i64
  %t15.i117 = getelementptr i8, ptr %t0, i64 %5
  %t16.i118 = load i8, ptr %t15.i117, align 1
  %t17.i119 = tail call ptr @_zen_char_to_string(i8 %t16.i118)
  br label %charAt.exit123

charAt.exit123:                                   ; preds = %if120.i121, %end116.i116
  %common.ret.op.i120 = phi ptr [ %t12.i122, %if120.i121 ], [ %t17.i119, %end116.i116 ]
  %t127 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t132 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t128 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i120, ptr noundef nonnull dereferenceable(1) %t127)
  %t129 = icmp slt i32 %t128, 0
  br i1 %t129, label %common.ret, label %rhs358

rhs358:                                           ; preds = %charAt.exit123
  %t133 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i120, ptr noundef nonnull dereferenceable(1) %t132)
  %t134 = icmp sgt i32 %t133, 0
  br i1 %t134, label %common.ret, label %end357

end357:                                           ; preds = %rhs358
  %t139 = add i32 %t42.0337, 2
  br label %whileCond335.backedge

end353:                                           ; preds = %charAt.exit111
  %t143 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t144 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t143)
  %t145 = icmp eq i32 %t144, 0
  br i1 %t145, label %if363, label %end362

if363:                                            ; preds = %end353
  %t148 = tail call i32 @strlen(ptr %t0)
  %t149.not = icmp slt i32 %t41.0339, %t148
  br i1 %t149.not, label %end364, label %common.ret

end364:                                           ; preds = %if363
  %t3.i124 = tail call i32 @strlen(ptr %t0)
  %t7.i125 = icmp slt i32 %t41.0339, 0
  %t10.i126 = icmp sge i32 %t41.0339, %t3.i124
  %t5.i127 = select i1 %t7.i125, i1 true, i1 %t10.i126
  br i1 %t5.i127, label %if120.i133, label %end116.i128

if120.i133:                                       ; preds = %end364
  %t12.i134 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit135

end116.i128:                                      ; preds = %end364
  %6 = zext nneg i32 %t41.0339 to i64
  %t15.i129 = getelementptr i8, ptr %t0, i64 %6
  %t16.i130 = load i8, ptr %t15.i129, align 1
  %t17.i131 = tail call ptr @_zen_char_to_string(i8 %t16.i130)
  br label %charAt.exit135

charAt.exit135:                                   ; preds = %if120.i133, %end116.i128
  %common.ret.op.i132 = phi ptr [ %t12.i134, %if120.i133 ], [ %t17.i131, %end116.i128 ]
  %t155 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_16)
  %t157 = tail call i1 @contains(ptr %t155, ptr %common.ret.op.i132)
  br i1 %t157, label %end366, label %common.ret

end366:                                           ; preds = %charAt.exit135
  %t163 = add i32 %t42.0337, 2
  br label %whileCond335.backedge

end362:                                           ; preds = %end353
  %t167 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_17)
  %t168 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t167)
  %t169 = icmp eq i32 %t168, 0
  br i1 %t169, label %if369, label %end368

if369:                                            ; preds = %end362
  %t172 = tail call i32 @strlen(ptr %t0)
  %t173.not = icmp slt i32 %t41.0339, %t172
  br i1 %t173.not, label %end370, label %common.ret

end370:                                           ; preds = %if369
  %t3.i136 = tail call i32 @strlen(ptr %t0)
  %t7.i137 = icmp slt i32 %t41.0339, 0
  %t10.i138 = icmp sge i32 %t41.0339, %t3.i136
  %t5.i139 = select i1 %t7.i137, i1 true, i1 %t10.i138
  br i1 %t5.i139, label %if120.i145, label %end116.i140

if120.i145:                                       ; preds = %end370
  %t12.i146 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit147

end116.i140:                                      ; preds = %end370
  %7 = zext nneg i32 %t41.0339 to i64
  %t15.i141 = getelementptr i8, ptr %t0, i64 %7
  %t16.i142 = load i8, ptr %t15.i141, align 1
  %t17.i143 = tail call ptr @_zen_char_to_string(i8 %t16.i142)
  br label %charAt.exit147

charAt.exit147:                                   ; preds = %if120.i145, %end116.i140
  %common.ret.op.i144 = phi ptr [ %t12.i146, %if120.i145 ], [ %t17.i143, %end116.i140 ]
  %t179 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_18)
  %t181 = tail call i1 @contains(ptr %t179, ptr %common.ret.op.i144)
  br i1 %t181, label %end372, label %common.ret

end372:                                           ; preds = %charAt.exit147
  %t187 = add i32 %t42.0337, 2
  br label %whileCond335.backedge

end368:                                           ; preds = %end362
  %t191 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_19)
  %t192 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i108, ptr noundef nonnull dereferenceable(1) %t191)
  %t193 = icmp eq i32 %t192, 0
  br i1 %t193, label %if375, label %end351

if375:                                            ; preds = %end368
  %t196 = tail call i32 @strlen(ptr %t0)
  %t197.not = icmp slt i32 %t41.0339, %t196
  br i1 %t197.not, label %end376, label %common.ret

end376:                                           ; preds = %if375
  %t3.i148 = tail call i32 @strlen(ptr %t0)
  %t7.i149 = icmp slt i32 %t41.0339, 0
  %t10.i150 = icmp sge i32 %t41.0339, %t3.i148
  %t5.i151 = select i1 %t7.i149, i1 true, i1 %t10.i150
  br i1 %t5.i151, label %if120.i157, label %end116.i152

if120.i157:                                       ; preds = %end376
  %t12.i158 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit159

end116.i152:                                      ; preds = %end376
  %8 = zext nneg i32 %t41.0339 to i64
  %t15.i153 = getelementptr i8, ptr %t0, i64 %8
  %t16.i154 = load i8, ptr %t15.i153, align 1
  %t17.i155 = tail call ptr @_zen_char_to_string(i8 %t16.i154)
  br label %charAt.exit159

charAt.exit159:                                   ; preds = %if120.i157, %end116.i152
  %common.ret.op.i156 = phi ptr [ %t12.i158, %if120.i157 ], [ %t17.i155, %end116.i152 ]
  %t205 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t210 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t206 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i156, ptr noundef nonnull dereferenceable(1) %t205)
  %t207.not = icmp eq i32 %t206, 0
  br i1 %t207.not, label %end378, label %rhs379

rhs379:                                           ; preds = %charAt.exit159
  %t211 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i156, ptr noundef nonnull dereferenceable(1) %t210)
  %t212.not = icmp eq i32 %t211, 0
  br i1 %t212.not, label %end378, label %common.ret

end378:                                           ; preds = %charAt.exit159, %rhs379
  %t217 = add i32 %t42.0337, 2
  br label %whileCond335.backedge

end351:                                           ; preds = %end368, %end342
  %t221 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_20)
  %t222 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t221)
  %t223 = icmp eq i32 %t222, 0
  br i1 %t223, label %if384, label %end383

if384:                                            ; preds = %end351
  %t226 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t231320 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t232321 = icmp slt i32 %t42.0337, %t231320
  br i1 %t232321, label %whileBody386, label %whileEnd387

whileBody386:                                     ; preds = %if384, %end388
  %t224.0323 = phi ptr [ %t250, %end388 ], [ %t226, %if384 ]
  %t227.0322 = phi i32 [ %t254, %end388 ], [ %t42.0337, %if384 ]
  %t3.i160 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i161 = icmp slt i32 %t227.0322, 0
  %t10.i162 = icmp sge i32 %t227.0322, %t3.i160
  %t5.i163 = select i1 %t7.i161, i1 true, i1 %t10.i162
  br i1 %t5.i163, label %if120.i169, label %end116.i164

if120.i169:                                       ; preds = %whileBody386
  %t12.i170 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit171

end116.i164:                                      ; preds = %whileBody386
  %9 = zext nneg i32 %t227.0322 to i64
  %t15.i165 = getelementptr i8, ptr %t1.tr.lcssa, i64 %9
  %t16.i166 = load i8, ptr %t15.i165, align 1
  %t17.i167 = tail call ptr @_zen_char_to_string(i8 %t16.i166)
  br label %charAt.exit171

charAt.exit171:                                   ; preds = %if120.i169, %end116.i164
  %common.ret.op.i168 = phi ptr [ %t12.i170, %if120.i169 ], [ %t17.i167, %end116.i164 ]
  %t240 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t245 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_9)
  %t241 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i168, ptr noundef nonnull dereferenceable(1) %t240)
  %t242 = icmp eq i32 %t241, 0
  br i1 %t242, label %whileEnd387, label %rhs389

rhs389:                                           ; preds = %charAt.exit171
  %t246 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i168, ptr noundef nonnull dereferenceable(1) %t245)
  %t247 = icmp eq i32 %t246, 0
  br i1 %t247, label %whileEnd387, label %end388

end388:                                           ; preds = %rhs389
  %t250 = tail call ptr @_str_concat(ptr %t224.0323, ptr nonnull %common.ret.op.i168)
  tail call void @_zen_string_free(ptr %t224.0323)
  %t254 = add nsw i32 %t227.0322, 1
  %t231 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t232 = icmp slt i32 %t254, %t231
  br i1 %t232, label %whileBody386, label %whileEnd387

whileEnd387:                                      ; preds = %end388, %rhs389, %charAt.exit171, %if384
  %t224.0.lcssa = phi ptr [ %t226, %if384 ], [ %t224.0323, %charAt.exit171 ], [ %t224.0323, %rhs389 ], [ %t250, %end388 ]
  %t258 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_21)
  %t259 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t224.0.lcssa, ptr noundef nonnull dereferenceable(1) %t258)
  %t260 = icmp eq i32 %t259, 0
  br i1 %t260, label %if394, label %end393

if394:                                            ; preds = %whileEnd387
  %t266 = tail call i32 @strlen(ptr %t0)
  %t272 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_22)
  %t267 = icmp slt i32 %t41.0339, %t266
  br i1 %t267, label %rhs396, label %end395

rhs396:                                           ; preds = %if394
  %t270 = tail call ptr @charAt(ptr %t0, i32 %t41.0339)
  %t273 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t270, ptr noundef nonnull dereferenceable(1) %t272)
  %t274 = icmp eq i32 %t273, 0
  %t276 = zext i1 %t274 to i32
  %spec.select = add nsw i32 %t41.0339, %t276
  br label %end395

end395:                                           ; preds = %rhs396, %if394
  %t41.1 = phi i32 [ %t41.0339, %if394 ], [ %spec.select, %rhs396 ]
  %t280 = tail call i32 @strlen(ptr %t0)
  %t281.not = icmp slt i32 %t41.1, %t280
  br i1 %t281.not, label %whileCond402.preheader, label %common.ret

whileCond402.preheader:                           ; preds = %end395
  %t286348 = tail call i32 @strlen(ptr %t0)
  %t287349 = icmp slt i32 %t41.1, %t286348
  br i1 %t287349, label %whileBody403, label %common.ret

whileBody403:                                     ; preds = %whileCond402.preheader, %end405
  %t41.2350 = phi i32 [ %t304, %end405 ], [ %t41.1, %whileCond402.preheader ]
  %t3.i172 = tail call i32 @strlen(ptr %t0)
  %t7.i173 = icmp slt i32 %t41.2350, 0
  %t10.i174 = icmp sge i32 %t41.2350, %t3.i172
  %t5.i175 = select i1 %t7.i173, i1 true, i1 %t10.i174
  br i1 %t5.i175, label %if120.i181, label %end116.i176

if120.i181:                                       ; preds = %whileBody403
  %t12.i182 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit183

end116.i176:                                      ; preds = %whileBody403
  %10 = zext nneg i32 %t41.2350 to i64
  %t15.i177 = getelementptr i8, ptr %t0, i64 %10
  %t16.i178 = load i8, ptr %t15.i177, align 1
  %t17.i179 = tail call ptr @_zen_char_to_string(i8 %t16.i178)
  br label %charAt.exit183

charAt.exit183:                                   ; preds = %if120.i181, %end116.i176
  %common.ret.op.i180 = phi ptr [ %t12.i182, %if120.i181 ], [ %t17.i179, %end116.i176 ]
  %t295 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t300 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t296 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i180, ptr noundef nonnull dereferenceable(1) %t295)
  %t297 = icmp slt i32 %t296, 0
  br i1 %t297, label %whileEnd404, label %rhs406

rhs406:                                           ; preds = %charAt.exit183
  %t301 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i180, ptr noundef nonnull dereferenceable(1) %t300)
  %t302 = icmp sgt i32 %t301, 0
  br i1 %t302, label %whileEnd404, label %end405

end405:                                           ; preds = %rhs406
  %t304 = add nsw i32 %t41.2350, 1
  %t286 = tail call i32 @strlen(ptr %t0)
  %t287 = icmp slt i32 %t304, %t286
  br i1 %t287, label %whileBody403, label %whileEnd404

whileEnd404:                                      ; preds = %end405, %rhs406, %charAt.exit183
  %t41.2.lcssa = phi i32 [ %t304, %end405 ], [ %t41.2350, %rhs406 ], [ %t41.2350, %charAt.exit183 ]
  %t308.not = icmp sgt i32 %t41.2.lcssa, %t41.1
  br i1 %t308.not, label %end410, label %common.ret

end410:                                           ; preds = %whileEnd404
  %t311 = tail call i32 @strlen(ptr %t0)
  %t312 = icmp eq i32 %t41.2.lcssa, %t311
  br label %common.ret

end393:                                           ; preds = %whileEnd387
  %t315 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_23)
  %t316 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t224.0.lcssa, ptr noundef nonnull dereferenceable(1) %t315)
  %t317 = icmp eq i32 %t316, 0
  br i1 %t317, label %if413, label %end412

if413:                                            ; preds = %end393
  %t320 = tail call i32 @strlen(ptr %t0)
  %t321.not = icmp slt i32 %t41.0339, %t320
  br i1 %t321.not, label %end414, label %common.ret

end414:                                           ; preds = %if413
  %t324 = tail call ptr @charAt(ptr %t0, i32 %t41.0339)
  %t331 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t336 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t342 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t347 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t352 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_24)
  %t332 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t324, ptr noundef nonnull dereferenceable(1) %t331)
  %t333 = icmp sgt i32 %t332, -1
  br i1 %t333, label %rhs423, label %rhs420

rhs423:                                           ; preds = %end414
  %t337 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t324, ptr noundef nonnull dereferenceable(1) %t336)
  %t338 = icmp slt i32 %t337, 1
  br i1 %t338, label %end416, label %rhs420

rhs420:                                           ; preds = %end414, %rhs423
  %t343 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t324, ptr noundef nonnull dereferenceable(1) %t342)
  %t344 = icmp sgt i32 %t343, -1
  br i1 %t344, label %rhs426, label %rhs417

rhs426:                                           ; preds = %rhs420
  %t348 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t324, ptr noundef nonnull dereferenceable(1) %t347)
  %t349 = icmp slt i32 %t348, 1
  br i1 %t349, label %end416, label %rhs417

rhs417:                                           ; preds = %rhs420, %rhs426
  %t353 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t324, ptr noundef nonnull dereferenceable(1) %t352)
  %t354.not = icmp eq i32 %t353, 0
  br i1 %t354.not, label %end416, label %common.ret

end416:                                           ; preds = %rhs423, %rhs426, %rhs417
  %t41.3341 = add nsw i32 %t41.0339, 1
  %t361342 = tail call i32 @strlen(ptr %t0)
  %t362343 = icmp slt i32 %t41.3341, %t361342
  br i1 %t362343, label %whileBody431, label %whileEnd432

whileBody431:                                     ; preds = %end416, %end433
  %t41.3345 = phi i32 [ %t41.3, %end433 ], [ %t41.3341, %end416 ]
  %t41.3.in344 = phi i32 [ %t41.3345, %end433 ], [ %t41.0339, %end416 ]
  %t3.i184 = tail call i32 @strlen(ptr %t0)
  %t7.i185 = icmp slt i32 %t41.3.in344, -1
  %t10.i186 = icmp sge i32 %t41.3345, %t3.i184
  %t5.i187 = select i1 %t7.i185, i1 true, i1 %t10.i186
  br i1 %t5.i187, label %if120.i193, label %end116.i188

if120.i193:                                       ; preds = %whileBody431
  %t12.i194 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit195

end116.i188:                                      ; preds = %whileBody431
  %11 = zext nneg i32 %t41.3345 to i64
  %t15.i189 = getelementptr i8, ptr %t0, i64 %11
  %t16.i190 = load i8, ptr %t15.i189, align 1
  %t17.i191 = tail call ptr @_zen_char_to_string(i8 %t16.i190)
  br label %charAt.exit195

charAt.exit195:                                   ; preds = %if120.i193, %end116.i188
  %common.ret.op.i192 = phi ptr [ %t12.i194, %if120.i193 ], [ %t17.i191, %end116.i188 ]
  %t373 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_1)
  %t378 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_2)
  %t384 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_3)
  %t389 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_4)
  %t395 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_14)
  %t400 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_15)
  %t405 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_24)
  %t374 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t373)
  %t375 = icmp sgt i32 %t374, -1
  br i1 %t375, label %rhs443, label %rhs440

rhs443:                                           ; preds = %charAt.exit195
  %t379 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t378)
  %t380 = icmp slt i32 %t379, 1
  br i1 %t380, label %end433, label %rhs440

rhs440:                                           ; preds = %charAt.exit195, %rhs443
  %t385 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t384)
  %t386 = icmp sgt i32 %t385, -1
  br i1 %t386, label %rhs446, label %rhs437

rhs446:                                           ; preds = %rhs440
  %t390 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t389)
  %t391 = icmp slt i32 %t390, 1
  br i1 %t391, label %end433, label %rhs437

rhs437:                                           ; preds = %rhs440, %rhs446
  %t396 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t395)
  %t397 = icmp sgt i32 %t396, -1
  br i1 %t397, label %rhs449, label %rhs434

rhs449:                                           ; preds = %rhs437
  %t401 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t400)
  %t402 = icmp slt i32 %t401, 1
  br i1 %t402, label %end433, label %rhs434

rhs434:                                           ; preds = %rhs437, %rhs449
  %t406 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i192, ptr noundef nonnull dereferenceable(1) %t405)
  %t407.not = icmp eq i32 %t406, 0
  br i1 %t407.not, label %end433, label %whileEnd432

end433:                                           ; preds = %rhs443, %rhs446, %rhs449, %rhs434
  %t41.3 = add nsw i32 %t41.3345, 1
  %t361 = tail call i32 @strlen(ptr %t0)
  %t362 = icmp slt i32 %t41.3, %t361
  br i1 %t362, label %whileBody431, label %whileEnd432

whileEnd432:                                      ; preds = %end433, %rhs434, %end416
  %t41.3.lcssa = phi i32 [ %t41.3341, %end416 ], [ %t41.3345, %rhs434 ], [ %t41.3, %end433 ]
  %t414 = tail call i32 @strlen(ptr %t0)
  %t415 = icmp eq i32 %t41.3.lcssa, %t414
  br label %common.ret

end412:                                           ; preds = %end393
  %t418 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_25)
  %t419 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t224.0.lcssa, ptr noundef nonnull dereferenceable(1) %t418)
  %t420 = icmp eq i32 %t419, 0
  br i1 %t420, label %if454, label %end383

if454:                                            ; preds = %end412
  %t423 = tail call i32 @strlen(ptr %t0)
  %t424 = icmp slt i32 %t41.0339, %t423
  br label %common.ret

end383:                                           ; preds = %end412, %end351
  %t427 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t428 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i76, ptr noundef nonnull dereferenceable(1) %t427)
  %t429 = icmp eq i32 %t428, 0
  br i1 %t429, label %if456, label %end455

if456:                                            ; preds = %end383
  %t432 = add i32 %t42.0337, 1
  %t435327 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t436328 = icmp slt i32 %t432, %t435327
  br i1 %t436328, label %whileBody458, label %whileEnd459

whileBody458:                                     ; preds = %if456, %end460
  %t430.0329 = phi i32 [ %t445, %end460 ], [ %t432, %if456 ]
  %t441 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i196 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t7.i197 = icmp slt i32 %t430.0329, 0
  %t10.i198 = icmp sge i32 %t430.0329, %t3.i196
  %t5.i199 = select i1 %t7.i197, i1 true, i1 %t10.i198
  br i1 %t5.i199, label %if120.i205, label %end116.i200

if120.i205:                                       ; preds = %whileBody458
  %t12.i206 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit207

end116.i200:                                      ; preds = %whileBody458
  %12 = zext nneg i32 %t430.0329 to i64
  %t15.i201 = getelementptr i8, ptr %t1.tr.lcssa, i64 %12
  %t16.i202 = load i8, ptr %t15.i201, align 1
  %t17.i203 = tail call ptr @_zen_char_to_string(i8 %t16.i202)
  br label %charAt.exit207

charAt.exit207:                                   ; preds = %if120.i205, %end116.i200
  %common.ret.op.i204 = phi ptr [ %t12.i206, %if120.i205 ], [ %t17.i203, %end116.i200 ]
  %t442 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i204, ptr noundef nonnull dereferenceable(1) %t441)
  %t443 = icmp eq i32 %t442, 0
  br i1 %t443, label %whileEnd459, label %end460

end460:                                           ; preds = %charAt.exit207
  %t445 = add nsw i32 %t430.0329, 1
  %t435 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %t436 = icmp slt i32 %t445, %t435
  br i1 %t436, label %whileBody458, label %whileEnd459

whileEnd459:                                      ; preds = %end460, %charAt.exit207, %if456
  %t430.0.lcssa = phi i32 [ %t432, %if456 ], [ %t430.0329, %charAt.exit207 ], [ %t445, %end460 ]
  %t4.i208 = tail call i32 @strlen(ptr %t1.tr.lcssa)
  %spec.store.select.i209 = tail call i32 @llvm.smax.i32(i32 %t432, i32 0)
  %spec.select.i210 = tail call i32 @llvm.smin.i32(i32 %t430.0.lcssa, i32 %t4.i208)
  %t16.i211 = icmp sle i32 %spec.store.select.i209, %spec.select.i210
  %t18.i212 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i213 = icmp samesign ult i32 %spec.store.select.i209, %spec.select.i210
  %or.cond.i214 = select i1 %t16.i211, i1 %t268.i213, i1 false
  br i1 %or.cond.i214, label %whileBody114.i216, label %slice.exit225

whileBody114.i216:                                ; preds = %whileEnd459, %whileBody114.i216
  %t19.010.i217 = phi ptr [ %t34.i222, %whileBody114.i216 ], [ %t18.i212, %whileEnd459 ]
  %t22.09.i218 = phi i32 [ %t38.i223, %whileBody114.i216 ], [ %spec.store.select.i209, %whileEnd459 ]
  %13 = zext nneg i32 %t22.09.i218 to i64
  %t30.i219 = getelementptr i8, ptr %t1.tr.lcssa, i64 %13
  %t31.i220 = load i8, ptr %t30.i219, align 1
  %t32.i221 = tail call ptr @_zen_char_to_string(i8 %t31.i220)
  %t34.i222 = tail call ptr @_str_concat(ptr %t19.010.i217, ptr %t32.i221)
  tail call void @_zen_string_free(ptr %t19.010.i217)
  %t38.i223 = add nuw nsw i32 %t22.09.i218, 1
  %t26.i224 = icmp slt i32 %t38.i223, %spec.select.i210
  br i1 %t26.i224, label %whileBody114.i216, label %slice.exit225

slice.exit225:                                    ; preds = %whileBody114.i216, %whileEnd459
  %common.ret.op.i215 = phi ptr [ %t18.i212, %whileEnd459 ], [ %t34.i222, %whileBody114.i216 ]
  %t455 = tail call i32 @strlen(ptr %t0)
  %t456.not = icmp slt i32 %t41.0339, %t455
  br i1 %t456.not, label %end462, label %common.ret

end462:                                           ; preds = %slice.exit225
  %t3.i226 = tail call i32 @strlen(ptr %t0)
  %t7.i227 = icmp slt i32 %t41.0339, 0
  %t10.i228 = icmp sge i32 %t41.0339, %t3.i226
  %t5.i229 = select i1 %t7.i227, i1 true, i1 %t10.i228
  br i1 %t5.i229, label %if120.i235, label %end116.i230

if120.i235:                                       ; preds = %end462
  %t12.i236 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit237

end116.i230:                                      ; preds = %end462
  %14 = zext nneg i32 %t41.0339 to i64
  %t15.i231 = getelementptr i8, ptr %t0, i64 %14
  %t16.i232 = load i8, ptr %t15.i231, align 1
  %t17.i233 = tail call ptr @_zen_char_to_string(i8 %t16.i232)
  br label %charAt.exit237

charAt.exit237:                                   ; preds = %if120.i235, %end116.i230
  %common.ret.op.i234 = phi ptr [ %t12.i236, %if120.i235 ], [ %t17.i233, %end116.i230 ]
  %t464 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t469 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_22)
  %t465 = icmp eq i32 %t464, 3
  br i1 %t465, label %rhs465, label %else469

rhs465:                                           ; preds = %charAt.exit237
  %t3.i238 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i239 = icmp slt i32 %t3.i238, 2
  br i1 %t10.i239, label %if120.i246, label %end116.i241

if120.i246:                                       ; preds = %rhs465
  %t12.i247 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit248

end116.i241:                                      ; preds = %rhs465
  %t15.i242 = getelementptr i8, ptr %common.ret.op.i215, i64 1
  %t16.i243 = load i8, ptr %t15.i242, align 1
  %t17.i244 = tail call ptr @_zen_char_to_string(i8 %t16.i243)
  br label %charAt.exit248

charAt.exit248:                                   ; preds = %if120.i246, %end116.i241
  %common.ret.op.i245 = phi ptr [ %t12.i247, %if120.i246 ], [ %t17.i244, %end116.i241 ]
  %t470 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i245, ptr noundef nonnull dereferenceable(1) %t469)
  %t471 = icmp eq i32 %t470, 0
  br i1 %t471, label %if468, label %else469

if468:                                            ; preds = %charAt.exit248
  %t3.i249 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i250 = icmp slt i32 %t3.i249, 1
  br i1 %t10.i250, label %if120.i257, label %end116.i252

if120.i257:                                       ; preds = %if468
  %t12.i258 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit259

end116.i252:                                      ; preds = %if468
  %t16.i254 = load i8, ptr %common.ret.op.i215, align 1
  %t17.i255 = tail call ptr @_zen_char_to_string(i8 %t16.i254)
  br label %charAt.exit259

charAt.exit259:                                   ; preds = %if120.i257, %end116.i252
  %common.ret.op.i256 = phi ptr [ %t12.i258, %if120.i257 ], [ %t17.i255, %end116.i252 ]
  %t3.i260 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i261 = icmp slt i32 %t3.i260, 3
  br i1 %t10.i261, label %if120.i268, label %end116.i263

if120.i268:                                       ; preds = %charAt.exit259
  %t12.i269 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit270

end116.i263:                                      ; preds = %charAt.exit259
  %t15.i264 = getelementptr i8, ptr %common.ret.op.i215, i64 2
  %t16.i265 = load i8, ptr %t15.i264, align 1
  %t17.i266 = tail call ptr @_zen_char_to_string(i8 %t16.i265)
  br label %charAt.exit270

charAt.exit270:                                   ; preds = %if120.i268, %end116.i263
  %common.ret.op.i267 = phi ptr [ %t12.i269, %if120.i268 ], [ %t17.i266, %end116.i263 ]
  %t481 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i234, ptr noundef nonnull dereferenceable(1) %common.ret.op.i256)
  %t482 = icmp sgt i32 %t481, -1
  br i1 %t482, label %rhs471, label %common.ret

rhs471:                                           ; preds = %charAt.exit270
  %t485 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i234, ptr noundef nonnull dereferenceable(1) %common.ret.op.i267)
  %t486 = icmp sgt i32 %t485, 0
  br i1 %t486, label %common.ret, label %end482

else469:                                          ; preds = %charAt.exit237, %charAt.exit248
  %t491332 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t492333 = icmp sgt i32 %t491332, 0
  br i1 %t492333, label %whileBody476, label %common.ret

whileBody476:                                     ; preds = %else469, %whileCond475.backedge
  %t488.0334 = phi i32 [ %t488.0.be, %whileCond475.backedge ], [ 0, %else469 ]
  %t3.i271 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t10.i273.not = icmp slt i32 %t488.0334, %t3.i271
  br i1 %t10.i273.not, label %end116.i275, label %if120.i280

if120.i280:                                       ; preds = %whileBody476
  %t12.i281 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit282

end116.i275:                                      ; preds = %whileBody476
  %15 = zext nneg i32 %t488.0334 to i64
  %t15.i276 = getelementptr i8, ptr %common.ret.op.i215, i64 %15
  %t16.i277 = load i8, ptr %t15.i276, align 1
  %t17.i278 = tail call ptr @_zen_char_to_string(i8 %t16.i277)
  br label %charAt.exit282

charAt.exit282:                                   ; preds = %if120.i280, %end116.i275
  %common.ret.op.i279 = phi ptr [ %t12.i281, %if120.i280 ], [ %t17.i278, %end116.i275 ]
  %t499 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t500 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i279, ptr noundef nonnull dereferenceable(1) %t499)
  %t501 = icmp eq i32 %t500, 0
  br i1 %t501, label %whileCond475.backedge, label %end478

whileCond475.backedge:                            ; preds = %end478, %charAt.exit282
  %t488.0.be = add nuw nsw i32 %t488.0334, 1
  %t491 = tail call i32 @strlen(ptr %common.ret.op.i215)
  %t492 = icmp slt i32 %t488.0.be, %t491
  br i1 %t492, label %whileBody476, label %common.ret

end478:                                           ; preds = %charAt.exit282
  %t507 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i279, ptr noundef nonnull dereferenceable(1) %common.ret.op.i234)
  %t508 = icmp eq i32 %t507, 0
  br i1 %t508, label %end482, label %whileCond475.backedge

end482:                                           ; preds = %end478, %rhs471
  %t519 = add i32 %t430.0.lcssa, 1
  br label %whileCond335.backedge

end455:                                           ; preds = %end383
  %t523 = tail call i32 @strlen(ptr %t0)
  %t524.not = icmp slt i32 %t41.0339, %t523
  br i1 %t524.not, label %end484, label %common.ret

end484:                                           ; preds = %end455
  %t3.i283 = tail call i32 @strlen(ptr %t0)
  %t7.i284 = icmp slt i32 %t41.0339, 0
  %t10.i285 = icmp sge i32 %t41.0339, %t3.i283
  %t5.i286 = select i1 %t7.i284, i1 true, i1 %t10.i285
  br i1 %t5.i286, label %if120.i292, label %end116.i287

if120.i292:                                       ; preds = %end484
  %t12.i293 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit294

end116.i287:                                      ; preds = %end484
  %16 = zext nneg i32 %t41.0339 to i64
  %t15.i288 = getelementptr i8, ptr %t0, i64 %16
  %t16.i289 = load i8, ptr %t15.i288, align 1
  %t17.i290 = tail call ptr @_zen_char_to_string(i8 %t16.i289)
  br label %charAt.exit294

charAt.exit294:                                   ; preds = %if120.i292, %end116.i287
  %common.ret.op.i291 = phi ptr [ %t12.i293, %if120.i292 ], [ %t17.i290, %end116.i287 ]
  %t529 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i291, ptr noundef nonnull dereferenceable(1) %common.ret.op.i76)
  %t530.not = icmp eq i32 %t529, 0
  br i1 %t530.not, label %end486, label %common.ret

end486:                                           ; preds = %charAt.exit294
  %t535 = add i32 %t42.0337, 1
  br label %whileCond335.backedge

whileEnd337:                                      ; preds = %whileCond335.backedge, %whileCond335.preheader
  %t41.0.lcssa = phi i32 [ 0, %whileCond335.preheader ], [ %t41.0.be, %whileCond335.backedge ]
  %t539 = tail call i32 @strlen(ptr %t0)
  %t540 = icmp eq i32 %t41.0.lcssa, %t539
  br label %common.ret
}

define i32 @_json_skipWS(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond488

whileCond488:                                     ; preds = %whileBody489, %entry
  %i.addr.0 = phi i32 [ %t1, %entry ], [ %t12, %whileBody489 ]
  %t5 = tail call i32 @strlen(ptr %t0)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t7.i = icmp slt i32 %i.addr.0, 0
  %t10.i = icmp sge i32 %i.addr.0, %t3.i
  %t5.i = select i1 %t7.i, i1 true, i1 %t10.i
  br i1 %t5.i, label %if120.i, label %end116.i

if120.i:                                          ; preds = %whileCond488
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %whileCond488
  %0 = zext nneg i32 %i.addr.0 to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i, %if120.i ], [ %t17.i, %end116.i ]
  %t6 = icmp slt i32 %i.addr.0, %t5
  br i1 %t6, label %rhs491, label %whileEnd490

rhs491:                                           ; preds = %charAt.exit
  %t10 = tail call i1 @isWhitespace(ptr %common.ret.op.i)
  br i1 %t10, label %whileBody489, label %whileEnd490

whileBody489:                                     ; preds = %rhs491
  %t12 = add nsw i32 %i.addr.0, 1
  br label %whileCond488

whileEnd490:                                      ; preds = %charAt.exit, %rhs491
  ret i32 %i.addr.0
}

define i1 @isWhitespace(ptr readonly captures(none) %t0) local_unnamed_addr {
entry:
  %t6 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_5)
  %t11 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_6)
  %t16 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_7)
  %t21 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_29)
  %t7 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t6)
  %t8 = icmp eq i32 %t7, 0
  br i1 %t8, label %end496, label %rhs500

rhs500:                                           ; preds = %entry
  %t12 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t11)
  %t13 = icmp eq i32 %t12, 0
  br i1 %t13, label %end496, label %rhs497

rhs497:                                           ; preds = %rhs500
  %t17 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t16)
  %t18 = icmp eq i32 %t17, 0
  br i1 %t18, label %end496, label %rhs494

rhs494:                                           ; preds = %rhs497
  %t22 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t0, ptr noundef nonnull dereferenceable(1) %t21)
  %t23 = icmp eq i32 %t22, 0
  br label %end496

end496:                                           ; preds = %rhs497, %rhs500, %entry, %rhs494
  %t1 = phi i1 [ %t23, %rhs494 ], [ true, %entry ], [ true, %rhs500 ], [ true, %rhs497 ]
  ret i1 %t1
}

define ptr @_json_extractValue(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond488.i

whileCond488.i:                                   ; preds = %whileBody489.i, %entry
  %i.addr.0.i = phi i32 [ %t1, %entry ], [ %t12.i, %whileBody489.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i, 0
  %t10.i.i = icmp sge i32 %i.addr.0.i, %t3.i.i
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i
  br i1 %t5.i.i, label %if120.i.i, label %end116.i.i

if120.i.i:                                        ; preds = %whileCond488.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i

end116.i.i:                                       ; preds = %whileCond488.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %charAt.exit.i

charAt.exit.i:                                    ; preds = %end116.i.i, %if120.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if120.i.i ], [ %t17.i.i, %end116.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %charAt.exit.i
  %t10.i = tail call i1 @isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %rhs491.i
  %t12.i = add nsw i32 %i.addr.0.i, 1
  br label %whileCond488.i

_json_skipWS.exit:                                ; preds = %charAt.exit.i, %rhs491.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i33 = icmp sge i32 %i.addr.0.i, %t3.i
  %t5.i34 = select i1 %t7.i.i, i1 true, i1 %t10.i33
  br i1 %t5.i34, label %if120.i, label %end116.i

if120.i:                                          ; preds = %_json_skipWS.exit
  %t12.i35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %_json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i35, %if120.i ], [ %t17.i, %end116.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11 = icmp eq i32 %t10, 0
  br i1 %t11, label %if504, label %end503

if504:                                            ; preds = %charAt.exit
  %t14 = add i32 %i.addr.0.i, 1
  %t17233 = tail call i32 @strlen(ptr %t0)
  %t18234 = icmp slt i32 %t14, %t17233
  br i1 %t18234, label %whileBody506, label %whileEnd507

whileBody506:                                     ; preds = %if504, %end508
  %t12.0235 = phi i32 [ %t27, %end508 ], [ %t14, %if504 ]
  %t23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i36 = tail call i32 @strlen(ptr %t0)
  %t7.i37 = icmp slt i32 %t12.0235, 0
  %t10.i38 = icmp sge i32 %t12.0235, %t3.i36
  %t5.i39 = select i1 %t7.i37, i1 true, i1 %t10.i38
  br i1 %t5.i39, label %if120.i45, label %end116.i40

if120.i45:                                        ; preds = %whileBody506
  %t12.i46 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit47

end116.i40:                                       ; preds = %whileBody506
  %2 = zext nneg i32 %t12.0235 to i64
  %t15.i41 = getelementptr i8, ptr %t0, i64 %2
  %t16.i42 = load i8, ptr %t15.i41, align 1
  %t17.i43 = tail call ptr @_zen_char_to_string(i8 %t16.i42)
  br label %charAt.exit47

charAt.exit47:                                    ; preds = %if120.i45, %end116.i40
  %common.ret.op.i44 = phi ptr [ %t12.i46, %if120.i45 ], [ %t17.i43, %end116.i40 ]
  %t24 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i44, ptr noundef nonnull dereferenceable(1) %t23)
  %t25 = icmp eq i32 %t24, 0
  br i1 %t25, label %whileEnd507, label %end508

end508:                                           ; preds = %charAt.exit47
  %t27 = add nsw i32 %t12.0235, 1
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %t27, %t17
  br i1 %t18, label %whileBody506, label %whileEnd507

common.ret:                                       ; preds = %whileBody114.i202, %whileBody114.i148, %whileBody114.i94, %whileBody114.i, %whileEnd534, %whileEnd525, %whileEnd514, %whileEnd507
  %common.ret.op = phi ptr [ %t18.i, %whileEnd507 ], [ %t18.i90, %whileEnd514 ], [ %t18.i144, %whileEnd525 ], [ %t18.i198, %whileEnd534 ], [ %t34.i, %whileBody114.i ], [ %t34.i100, %whileBody114.i94 ], [ %t34.i154, %whileBody114.i148 ], [ %t34.i208, %whileBody114.i202 ]
  ret ptr %common.ret.op

whileEnd507:                                      ; preds = %end508, %charAt.exit47, %if504
  %t12.0.lcssa = phi i32 [ %t14, %if504 ], [ %t12.0235, %charAt.exit47 ], [ %t27, %end508 ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t14, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t12.0.lcssa, i32 %t4.i)
  %t16.i48 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i48, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %common.ret

whileBody114.i:                                   ; preds = %whileEnd507, %whileBody114.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody114.i ], [ %t18.i, %whileEnd507 ]
  %t22.09.i = phi i32 [ %t38.i, %whileBody114.i ], [ %spec.store.select.i, %whileEnd507 ]
  %3 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t0, i64 %3
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  tail call void @_zen_string_free(ptr %t19.010.i)
  %t38.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t38.i, %spec.select.i
  br i1 %t26.i, label %whileBody114.i, label %common.ret

end503:                                           ; preds = %charAt.exit
  %t38 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i50 = tail call i32 @strlen(ptr %t0)
  %t10.i52 = icmp sge i32 %i.addr.0.i, %t3.i50
  %t5.i53 = select i1 %t7.i.i, i1 true, i1 %t10.i52
  br i1 %t5.i53, label %if120.i59, label %end116.i54

if120.i59:                                        ; preds = %end503
  %t12.i60 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit61

end116.i54:                                       ; preds = %end503
  %4 = zext nneg i32 %i.addr.0.i to i64
  %t15.i55 = getelementptr i8, ptr %t0, i64 %4
  %t16.i56 = load i8, ptr %t15.i55, align 1
  %t17.i57 = tail call ptr @_zen_char_to_string(i8 %t16.i56)
  br label %charAt.exit61

charAt.exit61:                                    ; preds = %if120.i59, %end116.i54
  %common.ret.op.i58 = phi ptr [ %t12.i60, %if120.i59 ], [ %t17.i57, %end116.i54 ]
  %t39 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i58, ptr noundef nonnull dereferenceable(1) %t38)
  %t40 = icmp eq i32 %t39, 0
  br i1 %t40, label %whileCond512.preheader, label %end510

whileCond512.preheader:                           ; preds = %charAt.exit61
  %t46227 = tail call i32 @strlen(ptr %t0)
  %t47228 = icmp slt i32 %i.addr.0.i, %t46227
  br i1 %t47228, label %whileBody513, label %whileEnd514

whileBody513:                                     ; preds = %whileCond512.preheader, %end519
  %t43.0230 = phi i32 [ %t43.2, %end519 ], [ 0, %whileCond512.preheader ]
  %t41.0229 = phi i32 [ %t71, %end519 ], [ %i.addr.0.i, %whileCond512.preheader ]
  %t52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i62 = tail call i32 @strlen(ptr %t0)
  %t7.i63 = icmp slt i32 %t41.0229, 0
  %t10.i64 = icmp sge i32 %t41.0229, %t3.i62
  %t5.i65 = select i1 %t7.i63, i1 true, i1 %t10.i64
  br i1 %t5.i65, label %if120.i71, label %end116.i66

if120.i71:                                        ; preds = %whileBody513
  %t12.i72 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit73

end116.i66:                                       ; preds = %whileBody513
  %5 = zext nneg i32 %t41.0229 to i64
  %t15.i67 = getelementptr i8, ptr %t0, i64 %5
  %t16.i68 = load i8, ptr %t15.i67, align 1
  %t17.i69 = tail call ptr @_zen_char_to_string(i8 %t16.i68)
  br label %charAt.exit73

charAt.exit73:                                    ; preds = %if120.i71, %end116.i66
  %common.ret.op.i70 = phi ptr [ %t12.i72, %if120.i71 ], [ %t17.i69, %end116.i66 ]
  %t53 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i70, ptr noundef nonnull dereferenceable(1) %t52)
  %t54 = icmp eq i32 %t53, 0
  %t56 = zext i1 %t54 to i32
  %spec.select = add i32 %t43.0230, %t56
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i74 = tail call i32 @strlen(ptr %t0)
  %t10.i76 = icmp sge i32 %t41.0229, %t3.i74
  %t5.i77 = select i1 %t7.i63, i1 true, i1 %t10.i76
  br i1 %t5.i77, label %if120.i83, label %end116.i78

if120.i83:                                        ; preds = %charAt.exit73
  %t12.i84 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit85

end116.i78:                                       ; preds = %charAt.exit73
  %6 = zext nneg i32 %t41.0229 to i64
  %t15.i79 = getelementptr i8, ptr %t0, i64 %6
  %t16.i80 = load i8, ptr %t15.i79, align 1
  %t17.i81 = tail call ptr @_zen_char_to_string(i8 %t16.i80)
  br label %charAt.exit85

charAt.exit85:                                    ; preds = %if120.i83, %end116.i78
  %common.ret.op.i82 = phi ptr [ %t12.i84, %if120.i83 ], [ %t17.i81, %end116.i78 ]
  %t63 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i82, ptr noundef nonnull dereferenceable(1) %t62)
  %t64 = icmp eq i32 %t63, 0
  %t66 = sext i1 %t64 to i32
  %t43.2 = add i32 %spec.select, %t66
  %t69 = icmp eq i32 %t43.2, 0
  br i1 %t69, label %whileEnd514, label %end519

end519:                                           ; preds = %charAt.exit85
  %t71 = add nsw i32 %t41.0229, 1
  %t46 = tail call i32 @strlen(ptr %t0)
  %t47 = icmp slt i32 %t71, %t46
  br i1 %t47, label %whileBody513, label %whileEnd514

whileEnd514:                                      ; preds = %end519, %charAt.exit85, %whileCond512.preheader
  %t41.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond512.preheader ], [ %t41.0229, %charAt.exit85 ], [ %t71, %end519 ]
  %t76 = add i32 %t41.0.lcssa, 1
  %t4.i86 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i87 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i88 = tail call i32 @llvm.smin.i32(i32 %t76, i32 %t4.i86)
  %t16.i89 = icmp sle i32 %spec.store.select.i87, %spec.select.i88
  %t18.i90 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i91 = icmp samesign ult i32 %spec.store.select.i87, %spec.select.i88
  %or.cond.i92 = select i1 %t16.i89, i1 %t268.i91, i1 false
  br i1 %or.cond.i92, label %whileBody114.i94, label %common.ret

whileBody114.i94:                                 ; preds = %whileEnd514, %whileBody114.i94
  %t19.010.i95 = phi ptr [ %t34.i100, %whileBody114.i94 ], [ %t18.i90, %whileEnd514 ]
  %t22.09.i96 = phi i32 [ %t38.i101, %whileBody114.i94 ], [ %spec.store.select.i87, %whileEnd514 ]
  %7 = zext nneg i32 %t22.09.i96 to i64
  %t30.i97 = getelementptr i8, ptr %t0, i64 %7
  %t31.i98 = load i8, ptr %t30.i97, align 1
  %t32.i99 = tail call ptr @_zen_char_to_string(i8 %t31.i98)
  %t34.i100 = tail call ptr @_str_concat(ptr %t19.010.i95, ptr %t32.i99)
  tail call void @_zen_string_free(ptr %t19.010.i95)
  %t38.i101 = add nuw nsw i32 %t22.09.i96, 1
  %t26.i102 = icmp slt i32 %t38.i101, %spec.select.i88
  br i1 %t26.i102, label %whileBody114.i94, label %common.ret

end510:                                           ; preds = %charAt.exit61
  %t82 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i104 = tail call i32 @strlen(ptr %t0)
  %t10.i106 = icmp sge i32 %i.addr.0.i, %t3.i104
  %t5.i107 = select i1 %t7.i.i, i1 true, i1 %t10.i106
  br i1 %t5.i107, label %if120.i113, label %end116.i108

if120.i113:                                       ; preds = %end510
  %t12.i114 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit115

end116.i108:                                      ; preds = %end510
  %8 = zext nneg i32 %i.addr.0.i to i64
  %t15.i109 = getelementptr i8, ptr %t0, i64 %8
  %t16.i110 = load i8, ptr %t15.i109, align 1
  %t17.i111 = tail call ptr @_zen_char_to_string(i8 %t16.i110)
  br label %charAt.exit115

charAt.exit115:                                   ; preds = %if120.i113, %end116.i108
  %common.ret.op.i112 = phi ptr [ %t12.i114, %if120.i113 ], [ %t17.i111, %end116.i108 ]
  %t83 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i112, ptr noundef nonnull dereferenceable(1) %t82)
  %t84 = icmp eq i32 %t83, 0
  %t90221 = tail call i32 @strlen(ptr %t0)
  %t91222 = icmp slt i32 %i.addr.0.i, %t90221
  br i1 %t84, label %whileCond523.preheader, label %whileCond532.preheader

whileCond532.preheader:                           ; preds = %charAt.exit115
  br i1 %t91222, label %whileBody533, label %whileEnd534

whileCond523.preheader:                           ; preds = %charAt.exit115
  br i1 %t91222, label %whileBody524, label %whileEnd525

whileBody524:                                     ; preds = %whileCond523.preheader, %end530
  %t87.0224 = phi i32 [ %t87.2, %end530 ], [ 0, %whileCond523.preheader ]
  %t85.0223 = phi i32 [ %t115, %end530 ], [ %i.addr.0.i, %whileCond523.preheader ]
  %t96 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i116 = tail call i32 @strlen(ptr %t0)
  %t7.i117 = icmp slt i32 %t85.0223, 0
  %t10.i118 = icmp sge i32 %t85.0223, %t3.i116
  %t5.i119 = select i1 %t7.i117, i1 true, i1 %t10.i118
  br i1 %t5.i119, label %if120.i125, label %end116.i120

if120.i125:                                       ; preds = %whileBody524
  %t12.i126 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit127

end116.i120:                                      ; preds = %whileBody524
  %9 = zext nneg i32 %t85.0223 to i64
  %t15.i121 = getelementptr i8, ptr %t0, i64 %9
  %t16.i122 = load i8, ptr %t15.i121, align 1
  %t17.i123 = tail call ptr @_zen_char_to_string(i8 %t16.i122)
  br label %charAt.exit127

charAt.exit127:                                   ; preds = %if120.i125, %end116.i120
  %common.ret.op.i124 = phi ptr [ %t12.i126, %if120.i125 ], [ %t17.i123, %end116.i120 ]
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i124, ptr noundef nonnull dereferenceable(1) %t96)
  %t98 = icmp eq i32 %t97, 0
  %t100 = zext i1 %t98 to i32
  %spec.select32 = add i32 %t87.0224, %t100
  %t106 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i128 = tail call i32 @strlen(ptr %t0)
  %t10.i130 = icmp sge i32 %t85.0223, %t3.i128
  %t5.i131 = select i1 %t7.i117, i1 true, i1 %t10.i130
  br i1 %t5.i131, label %if120.i137, label %end116.i132

if120.i137:                                       ; preds = %charAt.exit127
  %t12.i138 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit139

end116.i132:                                      ; preds = %charAt.exit127
  %10 = zext nneg i32 %t85.0223 to i64
  %t15.i133 = getelementptr i8, ptr %t0, i64 %10
  %t16.i134 = load i8, ptr %t15.i133, align 1
  %t17.i135 = tail call ptr @_zen_char_to_string(i8 %t16.i134)
  br label %charAt.exit139

charAt.exit139:                                   ; preds = %if120.i137, %end116.i132
  %common.ret.op.i136 = phi ptr [ %t12.i138, %if120.i137 ], [ %t17.i135, %end116.i132 ]
  %t107 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i136, ptr noundef nonnull dereferenceable(1) %t106)
  %t108 = icmp eq i32 %t107, 0
  %t110 = sext i1 %t108 to i32
  %t87.2 = add i32 %spec.select32, %t110
  %t113 = icmp eq i32 %t87.2, 0
  br i1 %t113, label %whileEnd525, label %end530

end530:                                           ; preds = %charAt.exit139
  %t115 = add nsw i32 %t85.0223, 1
  %t90 = tail call i32 @strlen(ptr %t0)
  %t91 = icmp slt i32 %t115, %t90
  br i1 %t91, label %whileBody524, label %whileEnd525

whileEnd525:                                      ; preds = %end530, %charAt.exit139, %whileCond523.preheader
  %t85.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond523.preheader ], [ %t85.0223, %charAt.exit139 ], [ %t115, %end530 ]
  %t120 = add i32 %t85.0.lcssa, 1
  %t4.i140 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i141 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i142 = tail call i32 @llvm.smin.i32(i32 %t120, i32 %t4.i140)
  %t16.i143 = icmp sle i32 %spec.store.select.i141, %spec.select.i142
  %t18.i144 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i145 = icmp samesign ult i32 %spec.store.select.i141, %spec.select.i142
  %or.cond.i146 = select i1 %t16.i143, i1 %t268.i145, i1 false
  br i1 %or.cond.i146, label %whileBody114.i148, label %common.ret

whileBody114.i148:                                ; preds = %whileEnd525, %whileBody114.i148
  %t19.010.i149 = phi ptr [ %t34.i154, %whileBody114.i148 ], [ %t18.i144, %whileEnd525 ]
  %t22.09.i150 = phi i32 [ %t38.i155, %whileBody114.i148 ], [ %spec.store.select.i141, %whileEnd525 ]
  %11 = zext nneg i32 %t22.09.i150 to i64
  %t30.i151 = getelementptr i8, ptr %t0, i64 %11
  %t31.i152 = load i8, ptr %t30.i151, align 1
  %t32.i153 = tail call ptr @_zen_char_to_string(i8 %t31.i152)
  %t34.i154 = tail call ptr @_str_concat(ptr %t19.010.i149, ptr %t32.i153)
  tail call void @_zen_string_free(ptr %t19.010.i149)
  %t38.i155 = add nuw nsw i32 %t22.09.i150, 1
  %t26.i156 = icmp slt i32 %t38.i155, %spec.select.i142
  br i1 %t26.i156, label %whileBody114.i148, label %common.ret

whileBody533:                                     ; preds = %whileCond532.preheader, %end535
  %t122.0217 = phi i32 [ %t152, %end535 ], [ %i.addr.0.i, %whileCond532.preheader ]
  %t134 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t141 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t148 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i158 = tail call i32 @strlen(ptr %t0)
  %t7.i159 = icmp slt i32 %t122.0217, 0
  %t10.i160 = icmp sge i32 %t122.0217, %t3.i158
  %t5.i161 = select i1 %t7.i159, i1 true, i1 %t10.i160
  br i1 %t5.i161, label %if120.i167, label %end116.i162

if120.i167:                                       ; preds = %whileBody533
  %t12.i168 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit169

end116.i162:                                      ; preds = %whileBody533
  %12 = zext nneg i32 %t122.0217 to i64
  %t15.i163 = getelementptr i8, ptr %t0, i64 %12
  %t16.i164 = load i8, ptr %t15.i163, align 1
  %t17.i165 = tail call ptr @_zen_char_to_string(i8 %t16.i164)
  br label %charAt.exit169

charAt.exit169:                                   ; preds = %if120.i167, %end116.i162
  %common.ret.op.i166 = phi ptr [ %t12.i168, %if120.i167 ], [ %t17.i165, %end116.i162 ]
  %t135 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i166, ptr noundef nonnull dereferenceable(1) %t134)
  %t136 = icmp eq i32 %t135, 0
  br i1 %t136, label %whileEnd534, label %rhs539

rhs539:                                           ; preds = %charAt.exit169
  %t3.i170 = tail call i32 @strlen(ptr %t0)
  %t10.i172 = icmp sge i32 %t122.0217, %t3.i170
  %t5.i173 = select i1 %t7.i159, i1 true, i1 %t10.i172
  br i1 %t5.i173, label %if120.i179, label %end116.i174

if120.i179:                                       ; preds = %rhs539
  %t12.i180 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit181

end116.i174:                                      ; preds = %rhs539
  %13 = zext nneg i32 %t122.0217 to i64
  %t15.i175 = getelementptr i8, ptr %t0, i64 %13
  %t16.i176 = load i8, ptr %t15.i175, align 1
  %t17.i177 = tail call ptr @_zen_char_to_string(i8 %t16.i176)
  br label %charAt.exit181

charAt.exit181:                                   ; preds = %if120.i179, %end116.i174
  %common.ret.op.i178 = phi ptr [ %t12.i180, %if120.i179 ], [ %t17.i177, %end116.i174 ]
  %t142 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i178, ptr noundef nonnull dereferenceable(1) %t141)
  %t143 = icmp eq i32 %t142, 0
  br i1 %t143, label %whileEnd534, label %rhs536

rhs536:                                           ; preds = %charAt.exit181
  %t3.i182 = tail call i32 @strlen(ptr %t0)
  %t10.i184 = icmp sge i32 %t122.0217, %t3.i182
  %t5.i185 = select i1 %t7.i159, i1 true, i1 %t10.i184
  br i1 %t5.i185, label %if120.i191, label %end116.i186

if120.i191:                                       ; preds = %rhs536
  %t12.i192 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit193

end116.i186:                                      ; preds = %rhs536
  %14 = zext nneg i32 %t122.0217 to i64
  %t15.i187 = getelementptr i8, ptr %t0, i64 %14
  %t16.i188 = load i8, ptr %t15.i187, align 1
  %t17.i189 = tail call ptr @_zen_char_to_string(i8 %t16.i188)
  br label %charAt.exit193

charAt.exit193:                                   ; preds = %if120.i191, %end116.i186
  %common.ret.op.i190 = phi ptr [ %t12.i192, %if120.i191 ], [ %t17.i189, %end116.i186 ]
  %t149 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i190, ptr noundef nonnull dereferenceable(1) %t148)
  %t150 = icmp eq i32 %t149, 0
  br i1 %t150, label %whileEnd534, label %end535

end535:                                           ; preds = %charAt.exit193
  %t152 = add nsw i32 %t122.0217, 1
  %t126 = tail call i32 @strlen(ptr %t0)
  %t127 = icmp slt i32 %t152, %t126
  br i1 %t127, label %whileBody533, label %whileEnd534

whileEnd534:                                      ; preds = %end535, %charAt.exit193, %charAt.exit181, %charAt.exit169, %whileCond532.preheader
  %t122.0.lcssa = phi i32 [ %i.addr.0.i, %whileCond532.preheader ], [ %t122.0217, %charAt.exit169 ], [ %t122.0217, %charAt.exit181 ], [ %t122.0217, %charAt.exit193 ], [ %t152, %end535 ]
  %t4.i194 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i195 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.i, i32 0)
  %spec.select.i196 = tail call i32 @llvm.smin.i32(i32 %t122.0.lcssa, i32 %t4.i194)
  %t16.i197 = icmp sle i32 %spec.store.select.i195, %spec.select.i196
  %t18.i198 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i199 = icmp samesign ult i32 %spec.store.select.i195, %spec.select.i196
  %or.cond.i200 = select i1 %t16.i197, i1 %t268.i199, i1 false
  br i1 %or.cond.i200, label %whileBody114.i202, label %common.ret

whileBody114.i202:                                ; preds = %whileEnd534, %whileBody114.i202
  %t19.010.i203 = phi ptr [ %t34.i208, %whileBody114.i202 ], [ %t18.i198, %whileEnd534 ]
  %t22.09.i204 = phi i32 [ %t38.i209, %whileBody114.i202 ], [ %spec.store.select.i195, %whileEnd534 ]
  %15 = zext nneg i32 %t22.09.i204 to i64
  %t30.i205 = getelementptr i8, ptr %t0, i64 %15
  %t31.i206 = load i8, ptr %t30.i205, align 1
  %t32.i207 = tail call ptr @_zen_char_to_string(i8 %t31.i206)
  %t34.i208 = tail call ptr @_str_concat(ptr %t19.010.i203, ptr %t32.i207)
  tail call void @_zen_string_free(ptr %t19.010.i203)
  %t38.i209 = add nuw nsw i32 %t22.09.i204, 1
  %t26.i210 = icmp slt i32 %t38.i209, %spec.select.i196
  br i1 %t26.i210, label %whileBody114.i202, label %common.ret
}

define i32 @_json_skipElement(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond488.i

whileCond488.i:                                   ; preds = %whileBody489.i, %entry
  %i.addr.0.i = phi i32 [ %t1, %entry ], [ %t12.i, %whileBody489.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i, 0
  %t10.i.i = icmp sge i32 %i.addr.0.i, %t3.i.i
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i
  br i1 %t5.i.i, label %if120.i.i, label %end116.i.i

if120.i.i:                                        ; preds = %whileCond488.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i

end116.i.i:                                       ; preds = %whileCond488.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %charAt.exit.i

charAt.exit.i:                                    ; preds = %end116.i.i, %if120.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if120.i.i ], [ %t17.i.i, %end116.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %charAt.exit.i
  %t10.i = tail call i1 @isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %rhs491.i
  %t12.i = add nsw i32 %i.addr.0.i, 1
  br label %whileCond488.i

_json_skipWS.exit:                                ; preds = %charAt.exit.i, %rhs491.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i30 = icmp sge i32 %i.addr.0.i, %t3.i
  %t5.i31 = select i1 %t7.i.i, i1 true, i1 %t10.i30
  br i1 %t5.i31, label %if120.i, label %end116.i

if120.i:                                          ; preds = %_json_skipWS.exit
  %t12.i32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %_json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i32, %if120.i ], [ %t17.i, %end116.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11 = icmp eq i32 %t10, 0
  br i1 %t11, label %whileCond545, label %end543

whileCond545:                                     ; preds = %charAt.exit, %charAt.exit44
  %i.addr.0.in = phi i32 [ %i.addr.0, %charAt.exit44 ], [ %i.addr.0.i, %charAt.exit ]
  %i.addr.0 = add i32 %i.addr.0.in, 1
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %i.addr.0, %t17
  br i1 %t18, label %whileBody546, label %whileEnd547

whileBody546:                                     ; preds = %whileCond545
  %t23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i33 = tail call i32 @strlen(ptr %t0)
  %t7.i34 = icmp slt i32 %i.addr.0, 0
  %t10.i35 = icmp sge i32 %i.addr.0, %t3.i33
  %t5.i36 = select i1 %t7.i34, i1 true, i1 %t10.i35
  br i1 %t5.i36, label %if120.i42, label %end116.i37

if120.i42:                                        ; preds = %whileBody546
  %t12.i43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit44

end116.i37:                                       ; preds = %whileBody546
  %2 = zext nneg i32 %i.addr.0 to i64
  %t15.i38 = getelementptr i8, ptr %t0, i64 %2
  %t16.i39 = load i8, ptr %t15.i38, align 1
  %t17.i40 = tail call ptr @_zen_char_to_string(i8 %t16.i39)
  br label %charAt.exit44

charAt.exit44:                                    ; preds = %if120.i42, %end116.i37
  %common.ret.op.i41 = phi ptr [ %t12.i43, %if120.i42 ], [ %t17.i40, %end116.i37 ]
  %t24 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i41, ptr noundef nonnull dereferenceable(1) %t23)
  %t25 = icmp eq i32 %t24, 0
  br i1 %t25, label %whileEnd547, label %whileCond545

common.ret:                                       ; preds = %charAt.exit128, %charAt.exit140, %charAt.exit152, %end575, %whileCond572.preheader, %whileEnd565, %whileEnd554, %whileEnd547
  %common.ret.op = phi i32 [ %t30, %whileEnd547 ], [ %t69, %whileEnd554 ], [ %t108, %whileEnd565 ], [ %i.addr.0.i, %whileCond572.preheader ], [ %i.addr.3155, %charAt.exit128 ], [ %i.addr.3155, %charAt.exit140 ], [ %i.addr.3155, %charAt.exit152 ], [ %t137, %end575 ]
  ret i32 %common.ret.op

whileEnd547:                                      ; preds = %charAt.exit44, %whileCond545
  %t30 = add i32 %i.addr.0.in, 2
  br label %common.ret

end543:                                           ; preds = %charAt.exit
  %t35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i45 = tail call i32 @strlen(ptr %t0)
  %t10.i47 = icmp sge i32 %i.addr.0.i, %t3.i45
  %t5.i48 = select i1 %t7.i.i, i1 true, i1 %t10.i47
  br i1 %t5.i48, label %if120.i54, label %end116.i49

if120.i54:                                        ; preds = %end543
  %t12.i55 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit56

end116.i49:                                       ; preds = %end543
  %3 = zext nneg i32 %i.addr.0.i to i64
  %t15.i50 = getelementptr i8, ptr %t0, i64 %3
  %t16.i51 = load i8, ptr %t15.i50, align 1
  %t17.i52 = tail call ptr @_zen_char_to_string(i8 %t16.i51)
  br label %charAt.exit56

charAt.exit56:                                    ; preds = %if120.i54, %end116.i49
  %common.ret.op.i53 = phi ptr [ %t12.i55, %if120.i54 ], [ %t17.i52, %end116.i49 ]
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i53, ptr noundef nonnull dereferenceable(1) %t35)
  %t37 = icmp eq i32 %t36, 0
  br i1 %t37, label %whileCond552.preheader, label %end550

whileCond552.preheader:                           ; preds = %charAt.exit56
  %t41165 = tail call i32 @strlen(ptr %t0)
  %t42166 = icmp slt i32 %i.addr.0.i, %t41165
  br i1 %t42166, label %whileBody553, label %whileEnd554

whileBody553:                                     ; preds = %whileCond552.preheader, %end559
  %i.addr.1168 = phi i32 [ %t66, %end559 ], [ %i.addr.0.i, %whileCond552.preheader ]
  %t38.0167 = phi i32 [ %t38.2, %end559 ], [ 0, %whileCond552.preheader ]
  %t47 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i57 = tail call i32 @strlen(ptr %t0)
  %t7.i58 = icmp slt i32 %i.addr.1168, 0
  %t10.i59 = icmp sge i32 %i.addr.1168, %t3.i57
  %t5.i60 = select i1 %t7.i58, i1 true, i1 %t10.i59
  br i1 %t5.i60, label %if120.i66, label %end116.i61

if120.i66:                                        ; preds = %whileBody553
  %t12.i67 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit68

end116.i61:                                       ; preds = %whileBody553
  %4 = zext nneg i32 %i.addr.1168 to i64
  %t15.i62 = getelementptr i8, ptr %t0, i64 %4
  %t16.i63 = load i8, ptr %t15.i62, align 1
  %t17.i64 = tail call ptr @_zen_char_to_string(i8 %t16.i63)
  br label %charAt.exit68

charAt.exit68:                                    ; preds = %if120.i66, %end116.i61
  %common.ret.op.i65 = phi ptr [ %t12.i67, %if120.i66 ], [ %t17.i64, %end116.i61 ]
  %t48 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i65, ptr noundef nonnull dereferenceable(1) %t47)
  %t49 = icmp eq i32 %t48, 0
  %t51 = zext i1 %t49 to i32
  %spec.select = add i32 %t38.0167, %t51
  %t57 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i69 = tail call i32 @strlen(ptr %t0)
  %t10.i71 = icmp sge i32 %i.addr.1168, %t3.i69
  %t5.i72 = select i1 %t7.i58, i1 true, i1 %t10.i71
  br i1 %t5.i72, label %if120.i78, label %end116.i73

if120.i78:                                        ; preds = %charAt.exit68
  %t12.i79 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit80

end116.i73:                                       ; preds = %charAt.exit68
  %5 = zext nneg i32 %i.addr.1168 to i64
  %t15.i74 = getelementptr i8, ptr %t0, i64 %5
  %t16.i75 = load i8, ptr %t15.i74, align 1
  %t17.i76 = tail call ptr @_zen_char_to_string(i8 %t16.i75)
  br label %charAt.exit80

charAt.exit80:                                    ; preds = %if120.i78, %end116.i73
  %common.ret.op.i77 = phi ptr [ %t12.i79, %if120.i78 ], [ %t17.i76, %end116.i73 ]
  %t58 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i77, ptr noundef nonnull dereferenceable(1) %t57)
  %t59 = icmp eq i32 %t58, 0
  %t61 = sext i1 %t59 to i32
  %t38.2 = add i32 %spec.select, %t61
  %t64 = icmp eq i32 %t38.2, 0
  br i1 %t64, label %whileEnd554, label %end559

end559:                                           ; preds = %charAt.exit80
  %t66 = add nsw i32 %i.addr.1168, 1
  %t41 = tail call i32 @strlen(ptr %t0)
  %t42 = icmp slt i32 %t66, %t41
  br i1 %t42, label %whileBody553, label %whileEnd554

whileEnd554:                                      ; preds = %end559, %charAt.exit80, %whileCond552.preheader
  %i.addr.1.lcssa = phi i32 [ %i.addr.0.i, %whileCond552.preheader ], [ %i.addr.1168, %charAt.exit80 ], [ %t66, %end559 ]
  %t69 = add i32 %i.addr.1.lcssa, 1
  br label %common.ret

end550:                                           ; preds = %charAt.exit56
  %t74 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i81 = tail call i32 @strlen(ptr %t0)
  %t10.i83 = icmp sge i32 %i.addr.0.i, %t3.i81
  %t5.i84 = select i1 %t7.i.i, i1 true, i1 %t10.i83
  br i1 %t5.i84, label %if120.i90, label %end116.i85

if120.i90:                                        ; preds = %end550
  %t12.i91 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit92

end116.i85:                                       ; preds = %end550
  %6 = zext nneg i32 %i.addr.0.i to i64
  %t15.i86 = getelementptr i8, ptr %t0, i64 %6
  %t16.i87 = load i8, ptr %t15.i86, align 1
  %t17.i88 = tail call ptr @_zen_char_to_string(i8 %t16.i87)
  br label %charAt.exit92

charAt.exit92:                                    ; preds = %if120.i90, %end116.i85
  %common.ret.op.i89 = phi ptr [ %t12.i91, %if120.i90 ], [ %t17.i88, %end116.i85 ]
  %t75 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i89, ptr noundef nonnull dereferenceable(1) %t74)
  %t76 = icmp eq i32 %t75, 0
  %t80159 = tail call i32 @strlen(ptr %t0)
  %t81160 = icmp slt i32 %i.addr.0.i, %t80159
  br i1 %t76, label %whileCond563.preheader, label %whileCond572.preheader

whileCond572.preheader:                           ; preds = %charAt.exit92
  br i1 %t81160, label %whileBody573, label %common.ret

whileCond563.preheader:                           ; preds = %charAt.exit92
  br i1 %t81160, label %whileBody564, label %whileEnd565

whileBody564:                                     ; preds = %whileCond563.preheader, %end570
  %i.addr.2162 = phi i32 [ %t105, %end570 ], [ %i.addr.0.i, %whileCond563.preheader ]
  %t77.0161 = phi i32 [ %t77.2, %end570 ], [ 0, %whileCond563.preheader ]
  %t86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i93 = tail call i32 @strlen(ptr %t0)
  %t7.i94 = icmp slt i32 %i.addr.2162, 0
  %t10.i95 = icmp sge i32 %i.addr.2162, %t3.i93
  %t5.i96 = select i1 %t7.i94, i1 true, i1 %t10.i95
  br i1 %t5.i96, label %if120.i102, label %end116.i97

if120.i102:                                       ; preds = %whileBody564
  %t12.i103 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit104

end116.i97:                                       ; preds = %whileBody564
  %7 = zext nneg i32 %i.addr.2162 to i64
  %t15.i98 = getelementptr i8, ptr %t0, i64 %7
  %t16.i99 = load i8, ptr %t15.i98, align 1
  %t17.i100 = tail call ptr @_zen_char_to_string(i8 %t16.i99)
  br label %charAt.exit104

charAt.exit104:                                   ; preds = %if120.i102, %end116.i97
  %common.ret.op.i101 = phi ptr [ %t12.i103, %if120.i102 ], [ %t17.i100, %end116.i97 ]
  %t87 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i101, ptr noundef nonnull dereferenceable(1) %t86)
  %t88 = icmp eq i32 %t87, 0
  %t90 = zext i1 %t88 to i32
  %spec.select29 = add i32 %t77.0161, %t90
  %t96 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i105 = tail call i32 @strlen(ptr %t0)
  %t10.i107 = icmp sge i32 %i.addr.2162, %t3.i105
  %t5.i108 = select i1 %t7.i94, i1 true, i1 %t10.i107
  br i1 %t5.i108, label %if120.i114, label %end116.i109

if120.i114:                                       ; preds = %charAt.exit104
  %t12.i115 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit116

end116.i109:                                      ; preds = %charAt.exit104
  %8 = zext nneg i32 %i.addr.2162 to i64
  %t15.i110 = getelementptr i8, ptr %t0, i64 %8
  %t16.i111 = load i8, ptr %t15.i110, align 1
  %t17.i112 = tail call ptr @_zen_char_to_string(i8 %t16.i111)
  br label %charAt.exit116

charAt.exit116:                                   ; preds = %if120.i114, %end116.i109
  %common.ret.op.i113 = phi ptr [ %t12.i115, %if120.i114 ], [ %t17.i112, %end116.i109 ]
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(1) %t96)
  %t98 = icmp eq i32 %t97, 0
  %t100 = sext i1 %t98 to i32
  %t77.2 = add i32 %spec.select29, %t100
  %t103 = icmp eq i32 %t77.2, 0
  br i1 %t103, label %whileEnd565, label %end570

end570:                                           ; preds = %charAt.exit116
  %t105 = add nsw i32 %i.addr.2162, 1
  %t80 = tail call i32 @strlen(ptr %t0)
  %t81 = icmp slt i32 %t105, %t80
  br i1 %t81, label %whileBody564, label %whileEnd565

whileEnd565:                                      ; preds = %end570, %charAt.exit116, %whileCond563.preheader
  %i.addr.2.lcssa = phi i32 [ %i.addr.0.i, %whileCond563.preheader ], [ %i.addr.2162, %charAt.exit116 ], [ %t105, %end570 ]
  %t108 = add i32 %i.addr.2.lcssa, 1
  br label %common.ret

whileBody573:                                     ; preds = %whileCond572.preheader, %end575
  %i.addr.3155 = phi i32 [ %t137, %end575 ], [ %i.addr.0.i, %whileCond572.preheader ]
  %t119 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t126 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t133 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i117 = tail call i32 @strlen(ptr %t0)
  %t7.i118 = icmp slt i32 %i.addr.3155, 0
  %t10.i119 = icmp sge i32 %i.addr.3155, %t3.i117
  %t5.i120 = select i1 %t7.i118, i1 true, i1 %t10.i119
  br i1 %t5.i120, label %if120.i126, label %end116.i121

if120.i126:                                       ; preds = %whileBody573
  %t12.i127 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit128

end116.i121:                                      ; preds = %whileBody573
  %9 = zext nneg i32 %i.addr.3155 to i64
  %t15.i122 = getelementptr i8, ptr %t0, i64 %9
  %t16.i123 = load i8, ptr %t15.i122, align 1
  %t17.i124 = tail call ptr @_zen_char_to_string(i8 %t16.i123)
  br label %charAt.exit128

charAt.exit128:                                   ; preds = %if120.i126, %end116.i121
  %common.ret.op.i125 = phi ptr [ %t12.i127, %if120.i126 ], [ %t17.i124, %end116.i121 ]
  %t120 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i125, ptr noundef nonnull dereferenceable(1) %t119)
  %t121 = icmp eq i32 %t120, 0
  br i1 %t121, label %common.ret, label %rhs579

rhs579:                                           ; preds = %charAt.exit128
  %t3.i129 = tail call i32 @strlen(ptr %t0)
  %t10.i131 = icmp sge i32 %i.addr.3155, %t3.i129
  %t5.i132 = select i1 %t7.i118, i1 true, i1 %t10.i131
  br i1 %t5.i132, label %if120.i138, label %end116.i133

if120.i138:                                       ; preds = %rhs579
  %t12.i139 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit140

end116.i133:                                      ; preds = %rhs579
  %10 = zext nneg i32 %i.addr.3155 to i64
  %t15.i134 = getelementptr i8, ptr %t0, i64 %10
  %t16.i135 = load i8, ptr %t15.i134, align 1
  %t17.i136 = tail call ptr @_zen_char_to_string(i8 %t16.i135)
  br label %charAt.exit140

charAt.exit140:                                   ; preds = %if120.i138, %end116.i133
  %common.ret.op.i137 = phi ptr [ %t12.i139, %if120.i138 ], [ %t17.i136, %end116.i133 ]
  %t127 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i137, ptr noundef nonnull dereferenceable(1) %t126)
  %t128 = icmp eq i32 %t127, 0
  br i1 %t128, label %common.ret, label %rhs576

rhs576:                                           ; preds = %charAt.exit140
  %t3.i141 = tail call i32 @strlen(ptr %t0)
  %t10.i143 = icmp sge i32 %i.addr.3155, %t3.i141
  %t5.i144 = select i1 %t7.i118, i1 true, i1 %t10.i143
  br i1 %t5.i144, label %if120.i150, label %end116.i145

if120.i150:                                       ; preds = %rhs576
  %t12.i151 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit152

end116.i145:                                      ; preds = %rhs576
  %11 = zext nneg i32 %i.addr.3155 to i64
  %t15.i146 = getelementptr i8, ptr %t0, i64 %11
  %t16.i147 = load i8, ptr %t15.i146, align 1
  %t17.i148 = tail call ptr @_zen_char_to_string(i8 %t16.i147)
  br label %charAt.exit152

charAt.exit152:                                   ; preds = %if120.i150, %end116.i145
  %common.ret.op.i149 = phi ptr [ %t12.i151, %if120.i150 ], [ %t17.i148, %end116.i145 ]
  %t134 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i149, ptr noundef nonnull dereferenceable(1) %t133)
  %t135 = icmp eq i32 %t134, 0
  br i1 %t135, label %common.ret, label %end575

end575:                                           ; preds = %charAt.exit152
  %t137 = add nsw i32 %i.addr.3155, 1
  %t111 = tail call i32 @strlen(ptr %t0)
  %t112 = icmp slt i32 %t137, %t111
  br i1 %t112, label %whileBody573, label %common.ret
}

define ptr @_json_getArrayIndex(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  br label %whileCond488.i

whileCond488.i:                                   ; preds = %whileBody489.i, %entry
  %i.addr.0.i = phi i32 [ 0, %entry ], [ %t12.i, %whileBody489.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t10.i.i.not = icmp slt i32 %i.addr.0.i, %t3.i.i
  br i1 %t10.i.i.not, label %end116.i.i, label %if120.i.i

if120.i.i:                                        ; preds = %whileCond488.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i

end116.i.i:                                       ; preds = %whileCond488.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %charAt.exit.i

charAt.exit.i:                                    ; preds = %end116.i.i, %if120.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if120.i.i ], [ %t17.i.i, %end116.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %charAt.exit.i
  %t10.i = tail call i1 @isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %rhs491.i
  %t12.i = add nuw nsw i32 %i.addr.0.i, 1
  br label %whileCond488.i

_json_skipWS.exit:                                ; preds = %charAt.exit.i, %rhs491.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i12.not = icmp slt i32 %i.addr.0.i, %t3.i
  br i1 %t10.i12.not, label %end116.i, label %if120.i

if120.i:                                          ; preds = %_json_skipWS.exit
  %t12.i14 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %_json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i14, %if120.i ], [ %t17.i, %end116.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11.not = icmp eq i32 %t10, 0
  br i1 %t11.not, label %end583, label %if584

common.ret:                                       ; preds = %whileEnd587, %if595, %if584
  %common.ret.op = phi ptr [ %t13, %if584 ], [ %t54, %if595 ], [ %t62, %whileEnd587 ]
  ret ptr %common.ret.op

if584:                                            ; preds = %charAt.exit
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

end583:                                           ; preds = %charAt.exit
  %t15 = add nuw i32 %i.addr.0.i, 1
  %t2078 = tail call i32 @strlen(ptr %t0)
  %t2179 = icmp slt i32 %t15, %t2078
  br i1 %t2179, label %whileCond488.i15.preheader, label %whileEnd587

whileCond488.i15.preheader:                       ; preds = %end583, %end594
  %t4.081 = phi i32 [ %t57, %end594 ], [ %t15, %end583 ]
  %t17.080 = phi i32 [ %t59, %end594 ], [ 0, %end583 ]
  br label %whileCond488.i15

whileCond488.i15:                                 ; preds = %whileCond488.i15.preheader, %whileBody489.i29
  %i.addr.0.i16 = phi i32 [ %t12.i30, %whileBody489.i29 ], [ %t4.081, %whileCond488.i15.preheader ]
  %t5.i17 = tail call i32 @strlen(ptr %t0)
  %t3.i.i18 = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i16, 0
  %t10.i.i19 = icmp sge i32 %i.addr.0.i16, %t3.i.i18
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i19
  br i1 %t5.i.i, label %if120.i.i31, label %end116.i.i20

if120.i.i31:                                      ; preds = %whileCond488.i15
  %t12.i.i32 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i24

end116.i.i20:                                     ; preds = %whileCond488.i15
  %2 = zext nneg i32 %i.addr.0.i16 to i64
  %t15.i.i21 = getelementptr i8, ptr %t0, i64 %2
  %t16.i.i22 = load i8, ptr %t15.i.i21, align 1
  %t17.i.i23 = tail call ptr @_zen_char_to_string(i8 %t16.i.i22)
  br label %charAt.exit.i24

charAt.exit.i24:                                  ; preds = %end116.i.i20, %if120.i.i31
  %common.ret.op.i.i25 = phi ptr [ %t12.i.i32, %if120.i.i31 ], [ %t17.i.i23, %end116.i.i20 ]
  %t6.i26 = icmp slt i32 %i.addr.0.i16, %t5.i17
  br i1 %t6.i26, label %rhs491.i27, label %_json_skipWS.exit33

rhs491.i27:                                       ; preds = %charAt.exit.i24
  %t10.i28 = tail call i1 @isWhitespace(ptr %common.ret.op.i.i25)
  br i1 %t10.i28, label %whileBody489.i29, label %_json_skipWS.exit33

whileBody489.i29:                                 ; preds = %rhs491.i27
  %t12.i30 = add nsw i32 %i.addr.0.i16, 1
  br label %whileCond488.i15

_json_skipWS.exit33:                              ; preds = %charAt.exit.i24, %rhs491.i27
  %t29 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t3.i34 = tail call i32 @strlen(ptr %t0)
  %t10.i35 = icmp sge i32 %i.addr.0.i16, %t3.i34
  %t5.i36 = select i1 %t7.i.i, i1 true, i1 %t10.i35
  br i1 %t5.i36, label %if120.i42, label %end116.i37

if120.i42:                                        ; preds = %_json_skipWS.exit33
  %t12.i43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit44

end116.i37:                                       ; preds = %_json_skipWS.exit33
  %3 = zext nneg i32 %i.addr.0.i16 to i64
  %t15.i38 = getelementptr i8, ptr %t0, i64 %3
  %t16.i39 = load i8, ptr %t15.i38, align 1
  %t17.i40 = tail call ptr @_zen_char_to_string(i8 %t16.i39)
  br label %charAt.exit44

charAt.exit44:                                    ; preds = %if120.i42, %end116.i37
  %common.ret.op.i41 = phi ptr [ %t12.i43, %if120.i42 ], [ %t17.i40, %end116.i37 ]
  %t30 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i41, ptr noundef nonnull dereferenceable(1) %t29)
  %t31 = icmp eq i32 %t30, 0
  br i1 %t31, label %whileCond488.i45, label %end588

whileCond488.i45:                                 ; preds = %charAt.exit44, %rhs491.i59
  %i.addr.0.i46.in = phi i32 [ %i.addr.0.i46, %rhs491.i59 ], [ %i.addr.0.i16, %charAt.exit44 ]
  %i.addr.0.i46 = add i32 %i.addr.0.i46.in, 1
  %t5.i47 = tail call i32 @strlen(ptr %t0)
  %t3.i.i48 = tail call i32 @strlen(ptr %t0)
  %t7.i.i49 = icmp slt i32 %i.addr.0.i46, 0
  %t10.i.i50 = icmp sge i32 %i.addr.0.i46, %t3.i.i48
  %t5.i.i51 = select i1 %t7.i.i49, i1 true, i1 %t10.i.i50
  br i1 %t5.i.i51, label %if120.i.i63, label %end116.i.i52

if120.i.i63:                                      ; preds = %whileCond488.i45
  %t12.i.i64 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i56

end116.i.i52:                                     ; preds = %whileCond488.i45
  %4 = zext nneg i32 %i.addr.0.i46 to i64
  %t15.i.i53 = getelementptr i8, ptr %t0, i64 %4
  %t16.i.i54 = load i8, ptr %t15.i.i53, align 1
  %t17.i.i55 = tail call ptr @_zen_char_to_string(i8 %t16.i.i54)
  br label %charAt.exit.i56

charAt.exit.i56:                                  ; preds = %end116.i.i52, %if120.i.i63
  %common.ret.op.i.i57 = phi ptr [ %t12.i.i64, %if120.i.i63 ], [ %t17.i.i55, %end116.i.i52 ]
  %t6.i58 = icmp slt i32 %i.addr.0.i46, %t5.i47
  br i1 %t6.i58, label %rhs491.i59, label %end588

rhs491.i59:                                       ; preds = %charAt.exit.i56
  %t10.i60 = tail call i1 @isWhitespace(ptr %common.ret.op.i.i57)
  br i1 %t10.i60, label %whileCond488.i45, label %end588

end588:                                           ; preds = %rhs491.i59, %charAt.exit.i56, %charAt.exit44
  %t4.1 = phi i32 [ %i.addr.0.i16, %charAt.exit44 ], [ %i.addr.0.i46, %charAt.exit.i56 ], [ %i.addr.0.i46, %rhs491.i59 ]
  %t42 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i66 = tail call i32 @strlen(ptr %t0)
  %t7.i67 = icmp slt i32 %t4.1, 0
  %t10.i68 = icmp sge i32 %t4.1, %t3.i66
  %t5.i69 = select i1 %t7.i67, i1 true, i1 %t10.i68
  br i1 %t5.i69, label %if120.i75, label %end116.i70

if120.i75:                                        ; preds = %end588
  %t12.i76 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit77

end116.i70:                                       ; preds = %end588
  %5 = zext nneg i32 %t4.1 to i64
  %t15.i71 = getelementptr i8, ptr %t0, i64 %5
  %t16.i72 = load i8, ptr %t15.i71, align 1
  %t17.i73 = tail call ptr @_zen_char_to_string(i8 %t16.i72)
  br label %charAt.exit77

charAt.exit77:                                    ; preds = %if120.i75, %end116.i70
  %common.ret.op.i74 = phi ptr [ %t12.i76, %if120.i75 ], [ %t17.i73, %end116.i70 ]
  %t43 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i74, ptr noundef nonnull dereferenceable(1) %t42)
  %t44 = icmp eq i32 %t43, 0
  br i1 %t44, label %whileEnd587, label %end590

end590:                                           ; preds = %charAt.exit77
  %t47 = tail call i32 @strlen(ptr %t0)
  %t48.not = icmp slt i32 %t4.1, %t47
  br i1 %t48.not, label %end592, label %whileEnd587

end592:                                           ; preds = %end590
  %t51 = icmp eq i32 %t17.080, %t1
  br i1 %t51, label %if595, label %end594

if595:                                            ; preds = %end592
  %t54 = tail call ptr @_json_extractValue(ptr %t0, i32 %t4.1)
  br label %common.ret

end594:                                           ; preds = %end592
  %t57 = tail call i32 @_json_skipElement(ptr %t0, i32 %t4.1)
  %t59 = add i32 %t17.080, 1
  %t20 = tail call i32 @strlen(ptr %t0)
  %t21 = icmp slt i32 %t57, %t20
  br i1 %t21, label %whileCond488.i15.preheader, label %whileEnd587

whileEnd587:                                      ; preds = %end594, %charAt.exit77, %end590, %end583
  %t62 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret
}

define ptr @_json_getKey(ptr %t0, ptr readonly captures(none) %t1) local_unnamed_addr {
entry:
  br label %whileCond488.i

whileCond488.i:                                   ; preds = %whileBody489.i, %entry
  %i.addr.0.i = phi i32 [ 0, %entry ], [ %t12.i, %whileBody489.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t3.i.i = tail call i32 @strlen(ptr %t0)
  %t10.i.i.not = icmp slt i32 %i.addr.0.i, %t3.i.i
  br i1 %t10.i.i.not, label %end116.i.i, label %if120.i.i

if120.i.i:                                        ; preds = %whileCond488.i
  %t12.i.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i

end116.i.i:                                       ; preds = %whileCond488.i
  %0 = zext nneg i32 %i.addr.0.i to i64
  %t15.i.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i.i = load i8, ptr %t15.i.i, align 1
  %t17.i.i = tail call ptr @_zen_char_to_string(i8 %t16.i.i)
  br label %charAt.exit.i

charAt.exit.i:                                    ; preds = %end116.i.i, %if120.i.i
  %common.ret.op.i.i = phi ptr [ %t12.i.i, %if120.i.i ], [ %t17.i.i, %end116.i.i ]
  %t6.i = icmp slt i32 %i.addr.0.i, %t5.i
  br i1 %t6.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %charAt.exit.i
  %t10.i = tail call i1 @isWhitespace(ptr %common.ret.op.i.i)
  br i1 %t10.i, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %rhs491.i
  %t12.i = add nuw nsw i32 %i.addr.0.i, 1
  br label %whileCond488.i

_json_skipWS.exit:                                ; preds = %charAt.exit.i, %rhs491.i
  %t9 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_31)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i21.not = icmp slt i32 %i.addr.0.i, %t3.i
  br i1 %t10.i21.not, label %end116.i, label %if120.i

if120.i:                                          ; preds = %_json_skipWS.exit
  %t12.i23 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %_json_skipWS.exit
  %1 = zext nneg i32 %i.addr.0.i to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %1
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i23, %if120.i ], [ %t17.i, %end116.i ]
  %t10 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t9)
  %t11.not = icmp eq i32 %t10, 0
  br i1 %t11.not, label %end596, label %if597

common.ret:                                       ; preds = %whileEnd600, %if616, %if597
  %common.ret.op = phi ptr [ %t13, %if597 ], [ %t101, %if616 ], [ %t106, %whileEnd600 ]
  ret ptr %common.ret.op

if597:                                            ; preds = %charAt.exit
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

end596:                                           ; preds = %charAt.exit
  %t15 = add nuw i32 %i.addr.0.i, 1
  %t19173 = tail call i32 @strlen(ptr %t0)
  %t20174 = icmp slt i32 %t15, %t19173
  br i1 %t20174, label %whileCond488.i24, label %whileEnd600

whileCond488.i24:                                 ; preds = %end596, %whileCond488.i24.backedge
  %i.addr.0.i25 = phi i32 [ %i.addr.0.i25.be, %whileCond488.i24.backedge ], [ %t15, %end596 ]
  %t5.i26 = tail call i32 @strlen(ptr %t0)
  %t3.i.i27 = tail call i32 @strlen(ptr %t0)
  %t7.i.i = icmp slt i32 %i.addr.0.i25, 0
  %t10.i.i28 = icmp sge i32 %i.addr.0.i25, %t3.i.i27
  %t5.i.i = select i1 %t7.i.i, i1 true, i1 %t10.i.i28
  br i1 %t5.i.i, label %if120.i.i40, label %end116.i.i29

if120.i.i40:                                      ; preds = %whileCond488.i24
  %t12.i.i41 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i33

end116.i.i29:                                     ; preds = %whileCond488.i24
  %2 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i.i30 = getelementptr i8, ptr %t0, i64 %2
  %t16.i.i31 = load i8, ptr %t15.i.i30, align 1
  %t17.i.i32 = tail call ptr @_zen_char_to_string(i8 %t16.i.i31)
  br label %charAt.exit.i33

charAt.exit.i33:                                  ; preds = %end116.i.i29, %if120.i.i40
  %common.ret.op.i.i34 = phi ptr [ %t12.i.i41, %if120.i.i40 ], [ %t17.i.i32, %end116.i.i29 ]
  %t6.i35 = icmp slt i32 %i.addr.0.i25, %t5.i26
  br i1 %t6.i35, label %rhs491.i36, label %_json_skipWS.exit42

rhs491.i36:                                       ; preds = %charAt.exit.i33
  %t10.i37 = tail call i1 @isWhitespace(ptr %common.ret.op.i.i34)
  br i1 %t10.i37, label %whileBody489.i38, label %_json_skipWS.exit42

whileBody489.i38:                                 ; preds = %rhs491.i36
  %t12.i39 = add nsw i32 %i.addr.0.i25, 1
  br label %whileCond488.i24.backedge

whileCond488.i24.backedge:                        ; preds = %whileBody489.i38, %end615
  %i.addr.0.i25.be = phi i32 [ %t12.i39, %whileBody489.i38 ], [ %t104, %end615 ]
  br label %whileCond488.i24

_json_skipWS.exit42:                              ; preds = %charAt.exit.i33, %rhs491.i36
  %t28 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_32)
  %t3.i43 = tail call i32 @strlen(ptr %t0)
  %t10.i44 = icmp sge i32 %i.addr.0.i25, %t3.i43
  %t5.i45 = select i1 %t7.i.i, i1 true, i1 %t10.i44
  br i1 %t5.i45, label %if120.i51, label %end116.i46

if120.i51:                                        ; preds = %_json_skipWS.exit42
  %t12.i52 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit53

end116.i46:                                       ; preds = %_json_skipWS.exit42
  %3 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i47 = getelementptr i8, ptr %t0, i64 %3
  %t16.i48 = load i8, ptr %t15.i47, align 1
  %t17.i49 = tail call ptr @_zen_char_to_string(i8 %t16.i48)
  br label %charAt.exit53

charAt.exit53:                                    ; preds = %if120.i51, %end116.i46
  %common.ret.op.i50 = phi ptr [ %t12.i52, %if120.i51 ], [ %t17.i49, %end116.i46 ]
  %t29 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i50, ptr noundef nonnull dereferenceable(1) %t28)
  %t30 = icmp eq i32 %t29, 0
  br i1 %t30, label %whileEnd600, label %end601

end601:                                           ; preds = %charAt.exit53
  %t35 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_28)
  %t3.i54 = tail call i32 @strlen(ptr %t0)
  %t10.i56 = icmp sge i32 %i.addr.0.i25, %t3.i54
  %t5.i57 = select i1 %t7.i.i, i1 true, i1 %t10.i56
  br i1 %t5.i57, label %if120.i63, label %end116.i58

if120.i63:                                        ; preds = %end601
  %t12.i64 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit65

end116.i58:                                       ; preds = %end601
  %4 = zext nneg i32 %i.addr.0.i25 to i64
  %t15.i59 = getelementptr i8, ptr %t0, i64 %4
  %t16.i60 = load i8, ptr %t15.i59, align 1
  %t17.i61 = tail call ptr @_zen_char_to_string(i8 %t16.i60)
  br label %charAt.exit65

charAt.exit65:                                    ; preds = %if120.i63, %end116.i58
  %common.ret.op.i62 = phi ptr [ %t12.i64, %if120.i63 ], [ %t17.i61, %end116.i58 ]
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i62, ptr noundef nonnull dereferenceable(1) %t35)
  %t37 = icmp eq i32 %t36, 0
  br i1 %t37, label %whileCond488.i66, label %end603

whileCond488.i66:                                 ; preds = %charAt.exit65, %rhs491.i80
  %i.addr.0.i67.in = phi i32 [ %i.addr.0.i67, %rhs491.i80 ], [ %i.addr.0.i25, %charAt.exit65 ]
  %i.addr.0.i67 = add i32 %i.addr.0.i67.in, 1
  %t5.i68 = tail call i32 @strlen(ptr %t0)
  %t3.i.i69 = tail call i32 @strlen(ptr %t0)
  %t7.i.i70 = icmp slt i32 %i.addr.0.i67, 0
  %t10.i.i71 = icmp sge i32 %i.addr.0.i67, %t3.i.i69
  %t5.i.i72 = select i1 %t7.i.i70, i1 true, i1 %t10.i.i71
  br i1 %t5.i.i72, label %if120.i.i84, label %end116.i.i73

if120.i.i84:                                      ; preds = %whileCond488.i66
  %t12.i.i85 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i77

end116.i.i73:                                     ; preds = %whileCond488.i66
  %5 = zext nneg i32 %i.addr.0.i67 to i64
  %t15.i.i74 = getelementptr i8, ptr %t0, i64 %5
  %t16.i.i75 = load i8, ptr %t15.i.i74, align 1
  %t17.i.i76 = tail call ptr @_zen_char_to_string(i8 %t16.i.i75)
  br label %charAt.exit.i77

charAt.exit.i77:                                  ; preds = %end116.i.i73, %if120.i.i84
  %common.ret.op.i.i78 = phi ptr [ %t12.i.i85, %if120.i.i84 ], [ %t17.i.i76, %end116.i.i73 ]
  %t6.i79 = icmp slt i32 %i.addr.0.i67, %t5.i68
  br i1 %t6.i79, label %rhs491.i80, label %end603

rhs491.i80:                                       ; preds = %charAt.exit.i77
  %t10.i81 = tail call i1 @isWhitespace(ptr %common.ret.op.i.i78)
  br i1 %t10.i81, label %whileCond488.i66, label %end603

end603:                                           ; preds = %rhs491.i80, %charAt.exit.i77, %charAt.exit65
  %t4.1 = phi i32 [ %i.addr.0.i25, %charAt.exit65 ], [ %i.addr.0.i67, %charAt.exit.i77 ], [ %i.addr.0.i67, %rhs491.i80 ]
  %t48 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t3.i87 = tail call i32 @strlen(ptr %t0)
  %t7.i88 = icmp slt i32 %t4.1, 0
  %t10.i89 = icmp sge i32 %t4.1, %t3.i87
  %t5.i90 = select i1 %t7.i88, i1 true, i1 %t10.i89
  br i1 %t5.i90, label %if120.i96, label %end116.i91

if120.i96:                                        ; preds = %end603
  %t12.i97 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit98

end116.i91:                                       ; preds = %end603
  %6 = zext nneg i32 %t4.1 to i64
  %t15.i92 = getelementptr i8, ptr %t0, i64 %6
  %t16.i93 = load i8, ptr %t15.i92, align 1
  %t17.i94 = tail call ptr @_zen_char_to_string(i8 %t16.i93)
  br label %charAt.exit98

charAt.exit98:                                    ; preds = %if120.i96, %end116.i91
  %common.ret.op.i95 = phi ptr [ %t12.i97, %if120.i96 ], [ %t17.i94, %end116.i91 ]
  %t49 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i95, ptr noundef nonnull dereferenceable(1) %t48)
  %t50.not = icmp eq i32 %t49, 0
  br i1 %t50.not, label %end605, label %whileEnd600

end605:                                           ; preds = %charAt.exit98
  %t53 = add i32 %t4.1, 1
  %t59167 = tail call i32 @strlen(ptr %t0)
  %t65168 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t60169 = icmp slt i32 %t53, %t59167
  br i1 %t60169, label %rhs610, label %whileEnd609

rhs610:                                           ; preds = %end605, %whileBody608
  %t65171 = phi ptr [ %t65, %whileBody608 ], [ %t65168, %end605 ]
  %t54.0170 = phi i32 [ %t69, %whileBody608 ], [ %t53, %end605 ]
  %t3.i99 = tail call i32 @strlen(ptr %t0)
  %t7.i100 = icmp slt i32 %t54.0170, 0
  %t10.i101 = icmp sge i32 %t54.0170, %t3.i99
  %t5.i102 = select i1 %t7.i100, i1 true, i1 %t10.i101
  br i1 %t5.i102, label %if120.i108, label %end116.i103

if120.i108:                                       ; preds = %rhs610
  %t12.i109 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit110

end116.i103:                                      ; preds = %rhs610
  %7 = zext nneg i32 %t54.0170 to i64
  %t15.i104 = getelementptr i8, ptr %t0, i64 %7
  %t16.i105 = load i8, ptr %t15.i104, align 1
  %t17.i106 = tail call ptr @_zen_char_to_string(i8 %t16.i105)
  br label %charAt.exit110

charAt.exit110:                                   ; preds = %if120.i108, %end116.i103
  %common.ret.op.i107 = phi ptr [ %t12.i109, %if120.i108 ], [ %t17.i106, %end116.i103 ]
  %t66 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i107, ptr noundef nonnull dereferenceable(1) %t65171)
  %t67.not = icmp eq i32 %t66, 0
  br i1 %t67.not, label %whileEnd609, label %whileBody608

whileBody608:                                     ; preds = %charAt.exit110
  %t69 = add nsw i32 %t54.0170, 1
  %t59 = tail call i32 @strlen(ptr %t0)
  %t65 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_30)
  %t60 = icmp slt i32 %t69, %t59
  br i1 %t60, label %rhs610, label %whileEnd609

whileEnd609:                                      ; preds = %charAt.exit110, %whileBody608, %end605
  %t54.0.lcssa = phi i32 [ %t53, %end605 ], [ %t69, %whileBody608 ], [ %t54.0170, %charAt.exit110 ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t53, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t54.0.lcssa, i32 %t4.i)
  %t16.i111 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t16.i111, i1 %t268.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileEnd609, %whileBody114.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody114.i ], [ %t18.i, %whileEnd609 ]
  %t22.09.i = phi i32 [ %t38.i, %whileBody114.i ], [ %spec.store.select.i, %whileEnd609 ]
  %8 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t0, i64 %8
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  tail call void @_zen_string_free(ptr %t19.010.i)
  %t38.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t38.i, %spec.select.i
  br i1 %t26.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileEnd609
  %common.ret.op.i112 = phi ptr [ %t18.i, %whileEnd609 ], [ %t34.i, %whileBody114.i ]
  br label %whileCond488.i113

whileCond488.i113:                                ; preds = %rhs491.i127, %slice.exit
  %i.addr.0.i114.in = phi i32 [ %t54.0.lcssa, %slice.exit ], [ %i.addr.0.i114, %rhs491.i127 ]
  %i.addr.0.i114 = add i32 %i.addr.0.i114.in, 1
  %t5.i115 = tail call i32 @strlen(ptr %t0)
  %t3.i.i116 = tail call i32 @strlen(ptr %t0)
  %t7.i.i117 = icmp slt i32 %i.addr.0.i114, 0
  %t10.i.i118 = icmp sge i32 %i.addr.0.i114, %t3.i.i116
  %t5.i.i119 = select i1 %t7.i.i117, i1 true, i1 %t10.i.i118
  br i1 %t5.i.i119, label %if120.i.i131, label %end116.i.i120

if120.i.i131:                                     ; preds = %whileCond488.i113
  %t12.i.i132 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i124

end116.i.i120:                                    ; preds = %whileCond488.i113
  %9 = zext nneg i32 %i.addr.0.i114 to i64
  %t15.i.i121 = getelementptr i8, ptr %t0, i64 %9
  %t16.i.i122 = load i8, ptr %t15.i.i121, align 1
  %t17.i.i123 = tail call ptr @_zen_char_to_string(i8 %t16.i.i122)
  br label %charAt.exit.i124

charAt.exit.i124:                                 ; preds = %end116.i.i120, %if120.i.i131
  %common.ret.op.i.i125 = phi ptr [ %t12.i.i132, %if120.i.i131 ], [ %t17.i.i123, %end116.i.i120 ]
  %t6.i126 = icmp slt i32 %i.addr.0.i114, %t5.i115
  br i1 %t6.i126, label %rhs491.i127, label %_json_skipWS.exit133

rhs491.i127:                                      ; preds = %charAt.exit.i124
  %t10.i128 = tail call i1 @isWhitespace(ptr %common.ret.op.i.i125)
  br i1 %t10.i128, label %whileCond488.i113, label %_json_skipWS.exit133

_json_skipWS.exit133:                             ; preds = %charAt.exit.i124, %rhs491.i127
  %t86 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_20)
  %t3.i134 = tail call i32 @strlen(ptr %t0)
  %t10.i136 = icmp sge i32 %i.addr.0.i114, %t3.i134
  %t5.i137 = select i1 %t7.i.i117, i1 true, i1 %t10.i136
  br i1 %t5.i137, label %if120.i143, label %end116.i138

if120.i143:                                       ; preds = %_json_skipWS.exit133
  %t12.i144 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit145

end116.i138:                                      ; preds = %_json_skipWS.exit133
  %10 = zext nneg i32 %i.addr.0.i114 to i64
  %t15.i139 = getelementptr i8, ptr %t0, i64 %10
  %t16.i140 = load i8, ptr %t15.i139, align 1
  %t17.i141 = tail call ptr @_zen_char_to_string(i8 %t16.i140)
  br label %charAt.exit145

charAt.exit145:                                   ; preds = %if120.i143, %end116.i138
  %common.ret.op.i142 = phi ptr [ %t12.i144, %if120.i143 ], [ %t17.i141, %end116.i138 ]
  %t87 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i142, ptr noundef nonnull dereferenceable(1) %t86)
  %t88.not = icmp eq i32 %t87, 0
  br i1 %t88.not, label %end613, label %whileEnd600

end613:                                           ; preds = %charAt.exit145
  %t90 = add i32 %i.addr.0.i114.in, 2
  br label %whileCond488.i146

whileCond488.i146:                                ; preds = %whileBody489.i162, %end613
  %i.addr.0.i147 = phi i32 [ %t90, %end613 ], [ %t12.i163, %whileBody489.i162 ]
  %t5.i148 = tail call i32 @strlen(ptr %t0)
  %t3.i.i149 = tail call i32 @strlen(ptr %t0)
  %t7.i.i150 = icmp slt i32 %i.addr.0.i147, 0
  %t10.i.i151 = icmp sge i32 %i.addr.0.i147, %t3.i.i149
  %t5.i.i152 = select i1 %t7.i.i150, i1 true, i1 %t10.i.i151
  br i1 %t5.i.i152, label %if120.i.i164, label %end116.i.i153

if120.i.i164:                                     ; preds = %whileCond488.i146
  %t12.i.i165 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit.i157

end116.i.i153:                                    ; preds = %whileCond488.i146
  %11 = zext nneg i32 %i.addr.0.i147 to i64
  %t15.i.i154 = getelementptr i8, ptr %t0, i64 %11
  %t16.i.i155 = load i8, ptr %t15.i.i154, align 1
  %t17.i.i156 = tail call ptr @_zen_char_to_string(i8 %t16.i.i155)
  br label %charAt.exit.i157

charAt.exit.i157:                                 ; preds = %end116.i.i153, %if120.i.i164
  %common.ret.op.i.i158 = phi ptr [ %t12.i.i165, %if120.i.i164 ], [ %t17.i.i156, %end116.i.i153 ]
  %t6.i159 = icmp slt i32 %i.addr.0.i147, %t5.i148
  br i1 %t6.i159, label %rhs491.i160, label %_json_skipWS.exit166

rhs491.i160:                                      ; preds = %charAt.exit.i157
  %t10.i161 = tail call i1 @isWhitespace(ptr %common.ret.op.i.i158)
  br i1 %t10.i161, label %whileBody489.i162, label %_json_skipWS.exit166

whileBody489.i162:                                ; preds = %rhs491.i160
  %t12.i163 = add nsw i32 %i.addr.0.i147, 1
  br label %whileCond488.i146

_json_skipWS.exit166:                             ; preds = %charAt.exit.i157, %rhs491.i160
  %t97 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i112, ptr noundef nonnull dereferenceable(1) %t1)
  %t98 = icmp eq i32 %t97, 0
  br i1 %t98, label %if616, label %end615

if616:                                            ; preds = %_json_skipWS.exit166
  %t101 = tail call ptr @_json_extractValue(ptr %t0, i32 %i.addr.0.i147)
  br label %common.ret

end615:                                           ; preds = %_json_skipWS.exit166
  %t104 = tail call i32 @_json_skipElement(ptr %t0, i32 %i.addr.0.i147)
  %t19 = tail call i32 @strlen(ptr %t0)
  %t20 = icmp slt i32 %t104, %t19
  br i1 %t20, label %whileCond488.i24.backedge, label %whileEnd600

whileEnd600:                                      ; preds = %end615, %charAt.exit53, %charAt.exit98, %charAt.exit145, %end596
  %t106 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret
}

define i32 @_json_parseInt(ptr %t0) local_unnamed_addr {
entry:
  %t54 = tail call i32 @strlen(ptr %t0)
  %t65 = icmp sgt i32 %t54, 0
  br i1 %t65, label %whileBody618, label %whileEnd619

whileBody618:                                     ; preds = %entry, %charAt.exit
  %t1.07 = phi i32 [ %t16, %charAt.exit ], [ 0, %entry ]
  %t2.06 = phi i32 [ %t19, %charAt.exit ], [ 0, %entry ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i.not = icmp slt i32 %t2.06, %t3.i
  br i1 %t10.i.not, label %end116.i, label %if120.i

if120.i:                                          ; preds = %whileBody618
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %whileBody618
  %0 = zext nneg i32 %t2.06 to i64
  %t15.i = getelementptr i8, ptr %t0, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i, %if120.i ], [ %t17.i, %end116.i ]
  %t11 = tail call i32 @_string_to_int_ascii(ptr %common.ret.op.i)
  %t14 = mul i32 %t1.07, 10
  %t12 = add i32 %t14, -48
  %t16 = add i32 %t12, %t11
  %t19 = add nuw nsw i32 %t2.06, 1
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6 = icmp slt i32 %t19, %t5
  br i1 %t6, label %whileBody618, label %whileEnd619

whileEnd619:                                      ; preds = %charAt.exit, %entry
  %t1.0.lcssa = phi i32 [ 0, %entry ], [ %t16, %charAt.exit ]
  ret i32 %t1.0.lcssa
}

define ptr @json(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t792 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %t993 = tail call ptr @splitAt(ptr %t1, ptr %t792, i32 0)
  %t1394 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1495 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t993, ptr noundef nonnull dereferenceable(1) %t1394)
  %t1596 = icmp eq i32 %t1495, 0
  br i1 %t1596, label %common.ret, label %whileCond625.preheader

whileCond625.preheader:                           ; preds = %entry, %whileEnd636
  %t999 = phi ptr [ %t9, %whileEnd636 ], [ %t993, %entry ]
  %t2.098 = phi ptr [ %t2.2.lcssa, %whileEnd636 ], [ %t0, %entry ]
  %t4.097 = phi i32 [ %t108, %whileEnd636 ], [ 0, %entry ]
  %t1977 = tail call i32 @strlen(ptr nonnull %t999)
  %t2078 = icmp sgt i32 %t1977, 0
  br i1 %t2078, label %whileBody626, label %whileEnd627

whileBody626:                                     ; preds = %whileCond625.preheader, %end628
  %t16.079 = phi i32 [ %t29, %end628 ], [ 0, %whileCond625.preheader ]
  %t25 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i = tail call i32 @strlen(ptr nonnull %t999)
  %t10.i.not = icmp slt i32 %t16.079, %t3.i
  br i1 %t10.i.not, label %end116.i, label %if120.i

if120.i:                                          ; preds = %whileBody626
  %t12.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit

end116.i:                                         ; preds = %whileBody626
  %0 = zext nneg i32 %t16.079 to i64
  %t15.i = getelementptr i8, ptr %t999, i64 %0
  %t16.i = load i8, ptr %t15.i, align 1
  %t17.i = tail call ptr @_zen_char_to_string(i8 %t16.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %if120.i, %end116.i
  %common.ret.op.i = phi ptr [ %t12.i, %if120.i ], [ %t17.i, %end116.i ]
  %t26 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t25)
  %t27 = icmp eq i32 %t26, 0
  br i1 %t27, label %whileEnd627, label %end628

end628:                                           ; preds = %charAt.exit
  %t29 = add nuw nsw i32 %t16.079, 1
  %t19 = tail call i32 @strlen(ptr nonnull %t999)
  %t20 = icmp slt i32 %t29, %t19
  br i1 %t20, label %whileBody626, label %whileEnd627

whileEnd627:                                      ; preds = %end628, %charAt.exit, %whileCond625.preheader
  %t16.0.lcssa = phi i32 [ 0, %whileCond625.preheader ], [ %t16.079, %charAt.exit ], [ %t29, %end628 ]
  %t4.i = tail call i32 @strlen(ptr nonnull %t999)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t16.0.lcssa, i32 %t4.i)
  %t18.i = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %or.cond.i = icmp sgt i32 %spec.select.i, 0
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileEnd627, %whileBody114.i
  %t19.010.i = phi ptr [ %t34.i, %whileBody114.i ], [ %t18.i, %whileEnd627 ]
  %t22.09.i = phi i32 [ %t38.i, %whileBody114.i ], [ 0, %whileEnd627 ]
  %1 = zext nneg i32 %t22.09.i to i64
  %t30.i = getelementptr i8, ptr %t999, i64 %1
  %t31.i = load i8, ptr %t30.i, align 1
  %t32.i = tail call ptr @_zen_char_to_string(i8 %t31.i)
  %t34.i = tail call ptr @_str_concat(ptr %t19.010.i, ptr %t32.i)
  tail call void @_zen_string_free(ptr %t19.010.i)
  %t38.i = add nuw nsw i32 %t22.09.i, 1
  %t26.i = icmp slt i32 %t38.i, %spec.select.i
  br i1 %t26.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileEnd627
  %common.ret.op.i14 = phi ptr [ %t18.i, %whileEnd627 ], [ %t34.i, %whileBody114.i ]
  %t38 = tail call i32 @strlen(ptr nonnull %t999)
  %t4.i15 = tail call i32 @strlen(ptr nonnull %t999)
  %spec.select.i16 = tail call i32 @llvm.smin.i32(i32 %t38, i32 %t4.i15)
  %t16.i17 = icmp sle i32 %t16.0.lcssa, %spec.select.i16
  %t18.i18 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i19 = icmp samesign ult i32 %t16.0.lcssa, %spec.select.i16
  %or.cond.i20 = select i1 %t16.i17, i1 %t268.i19, i1 false
  br i1 %or.cond.i20, label %whileBody114.i22, label %slice.exit31

whileBody114.i22:                                 ; preds = %slice.exit, %whileBody114.i22
  %t19.010.i23 = phi ptr [ %t34.i28, %whileBody114.i22 ], [ %t18.i18, %slice.exit ]
  %t22.09.i24 = phi i32 [ %t38.i29, %whileBody114.i22 ], [ %t16.0.lcssa, %slice.exit ]
  %2 = zext nneg i32 %t22.09.i24 to i64
  %t30.i25 = getelementptr i8, ptr %t999, i64 %2
  %t31.i26 = load i8, ptr %t30.i25, align 1
  %t32.i27 = tail call ptr @_zen_char_to_string(i8 %t31.i26)
  %t34.i28 = tail call ptr @_str_concat(ptr %t19.010.i23, ptr %t32.i27)
  tail call void @_zen_string_free(ptr %t19.010.i23)
  %t38.i29 = add nuw nsw i32 %t22.09.i24, 1
  %t26.i30 = icmp slt i32 %t38.i29, %spec.select.i16
  br i1 %t26.i30, label %whileBody114.i22, label %slice.exit31

slice.exit31:                                     ; preds = %whileBody114.i22, %slice.exit
  %common.ret.op.i21 = phi ptr [ %t18.i18, %slice.exit ], [ %t34.i28, %whileBody114.i22 ]
  %t43 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t44 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i14, ptr noundef nonnull dereferenceable(1) %t43)
  %t45.not = icmp eq i32 %t44, 0
  br i1 %t45.not, label %end630, label %if631

if631:                                            ; preds = %slice.exit31
  %t48 = tail call ptr @_json_getKey(ptr %t2.098, ptr nonnull %common.ret.op.i14)
  %t51 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  %t52 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t48, ptr noundef nonnull dereferenceable(1) %t51)
  %t53 = icmp eq i32 %t52, 0
  br i1 %t53, label %common.ret.sink.split, label %end630

common.ret.sink.split:                            ; preds = %if631, %slice.exit73
  %t103 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  br label %common.ret

common.ret:                                       ; preds = %whileEnd636, %common.ret.sink.split, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t103, %common.ret.sink.split ], [ %t2.2.lcssa, %whileEnd636 ]
  ret ptr %common.ret.op

end630:                                           ; preds = %if631, %slice.exit31
  %t2.1 = phi ptr [ %t48, %if631 ], [ %t2.098, %slice.exit31 ]
  %t5986 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t6087 = icmp sgt i32 %t5986, 0
  br i1 %t6087, label %whileBody635, label %whileEnd636

whileCond634:                                     ; preds = %slice.exit73
  %t105 = add i32 %t68.0.lcssa, 1
  %t59 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t60 = icmp slt i32 %t105, %t59
  br i1 %t60, label %whileBody635, label %whileEnd636

whileBody635:                                     ; preds = %end630, %whileCond634
  %t2.289 = phi ptr [ %t96, %whileCond634 ], [ %t2.1, %end630 ]
  %t56.088 = phi i32 [ %t105, %whileCond634 ], [ 0, %end630 ]
  %t65 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_26)
  %t3.i32 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7.i33 = icmp slt i32 %t56.088, 0
  %t10.i34 = icmp sge i32 %t56.088, %t3.i32
  %t5.i35 = select i1 %t7.i33, i1 true, i1 %t10.i34
  br i1 %t5.i35, label %if120.i41, label %end116.i36

if120.i41:                                        ; preds = %whileBody635
  %t12.i42 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit43

end116.i36:                                       ; preds = %whileBody635
  %3 = zext nneg i32 %t56.088 to i64
  %t15.i37 = getelementptr i8, ptr %common.ret.op.i21, i64 %3
  %t16.i38 = load i8, ptr %t15.i37, align 1
  %t17.i39 = tail call ptr @_zen_char_to_string(i8 %t16.i38)
  br label %charAt.exit43

charAt.exit43:                                    ; preds = %if120.i41, %end116.i36
  %common.ret.op.i40 = phi ptr [ %t12.i42, %if120.i41 ], [ %t17.i39, %end116.i36 ]
  %t66 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i40, ptr noundef nonnull dereferenceable(1) %t65)
  %t67.not = icmp eq i32 %t66, 0
  br i1 %t67.not, label %end637, label %whileEnd636

end637:                                           ; preds = %charAt.exit43
  %t70 = add nsw i32 %t56.088, 1
  %t7381 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7482 = icmp slt i32 %t70, %t7381
  br i1 %t7482, label %whileBody640, label %whileEnd641

whileBody640:                                     ; preds = %end637, %end642
  %t68.083 = phi i32 [ %t83, %end642 ], [ %t70, %end637 ]
  %t79 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_27)
  %t3.i44 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t7.i45 = icmp slt i32 %t68.083, 0
  %t10.i46 = icmp sge i32 %t68.083, %t3.i44
  %t5.i47 = select i1 %t7.i45, i1 true, i1 %t10.i46
  br i1 %t5.i47, label %if120.i53, label %end116.i48

if120.i53:                                        ; preds = %whileBody640
  %t12.i54 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %charAt.exit55

end116.i48:                                       ; preds = %whileBody640
  %4 = zext nneg i32 %t68.083 to i64
  %t15.i49 = getelementptr i8, ptr %common.ret.op.i21, i64 %4
  %t16.i50 = load i8, ptr %t15.i49, align 1
  %t17.i51 = tail call ptr @_zen_char_to_string(i8 %t16.i50)
  br label %charAt.exit55

charAt.exit55:                                    ; preds = %if120.i53, %end116.i48
  %common.ret.op.i52 = phi ptr [ %t12.i54, %if120.i53 ], [ %t17.i51, %end116.i48 ]
  %t80 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i52, ptr noundef nonnull dereferenceable(1) %t79)
  %t81 = icmp eq i32 %t80, 0
  br i1 %t81, label %whileEnd641, label %end642

end642:                                           ; preds = %charAt.exit55
  %t83 = add nsw i32 %t68.083, 1
  %t73 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %t74 = icmp slt i32 %t83, %t73
  br i1 %t74, label %whileBody640, label %whileEnd641

whileEnd641:                                      ; preds = %end642, %charAt.exit55, %end637
  %t68.0.lcssa = phi i32 [ %t70, %end637 ], [ %t68.083, %charAt.exit55 ], [ %t83, %end642 ]
  %t4.i56 = tail call i32 @strlen(ptr %common.ret.op.i21)
  %spec.store.select.i57 = tail call i32 @llvm.smax.i32(i32 %t70, i32 0)
  %spec.select.i58 = tail call i32 @llvm.smin.i32(i32 %t68.0.lcssa, i32 %t4.i56)
  %t16.i59 = icmp sle i32 %spec.store.select.i57, %spec.select.i58
  %t18.i60 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t268.i61 = icmp samesign ult i32 %spec.store.select.i57, %spec.select.i58
  %or.cond.i62 = select i1 %t16.i59, i1 %t268.i61, i1 false
  br i1 %or.cond.i62, label %whileBody114.i64, label %slice.exit73

whileBody114.i64:                                 ; preds = %whileEnd641, %whileBody114.i64
  %t19.010.i65 = phi ptr [ %t34.i70, %whileBody114.i64 ], [ %t18.i60, %whileEnd641 ]
  %t22.09.i66 = phi i32 [ %t38.i71, %whileBody114.i64 ], [ %spec.store.select.i57, %whileEnd641 ]
  %5 = zext nneg i32 %t22.09.i66 to i64
  %t30.i67 = getelementptr i8, ptr %common.ret.op.i21, i64 %5
  %t31.i68 = load i8, ptr %t30.i67, align 1
  %t32.i69 = tail call ptr @_zen_char_to_string(i8 %t31.i68)
  %t34.i70 = tail call ptr @_str_concat(ptr %t19.010.i65, ptr %t32.i69)
  tail call void @_zen_string_free(ptr %t19.010.i65)
  %t38.i71 = add nuw nsw i32 %t22.09.i66, 1
  %t26.i72 = icmp slt i32 %t38.i71, %spec.select.i58
  br i1 %t26.i72, label %whileBody114.i64, label %slice.exit73

slice.exit73:                                     ; preds = %whileBody114.i64, %whileEnd641
  %common.ret.op.i63 = phi ptr [ %t18.i60, %whileEnd641 ], [ %t34.i70, %whileBody114.i64 ]
  %t92 = tail call i32 @_json_parseInt(ptr %common.ret.op.i63)
  %t96 = tail call ptr @_json_getArrayIndex(ptr %t2.289, i32 %t92)
  %t99 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_33)
  %t100 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t96, ptr noundef nonnull dereferenceable(1) %t99)
  %t101 = icmp eq i32 %t100, 0
  br i1 %t101, label %common.ret.sink.split, label %whileCond634

whileEnd636:                                      ; preds = %whileCond634, %charAt.exit43, %end630
  %t2.2.lcssa = phi ptr [ %t2.1, %end630 ], [ %t2.289, %charAt.exit43 ], [ %t96, %whileCond634 ]
  %t108 = add i32 %t4.097, 1
  %t7 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_8)
  %t9 = tail call ptr @splitAt(ptr %t1, ptr %t7, i32 %t108)
  %t13 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t14 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t9, ptr noundef nonnull dereferenceable(1) %t13)
  %t15 = icmp eq i32 %t14, 0
  br i1 %t15, label %common.ret, label %whileCond625.preheader
}

define ptr @split(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t54 = alloca ptr, align 8
  %t78 = alloca ptr, align 8
  %t3 = tail call ptr @_zen_list_new(i64 8)
  tail call void @_zen_list_set_meta(ptr %t3, i32 1, i32 4)
  %t5 = tail call i32 @strlen(ptr %t0)
  %t8 = tail call i32 @strlen(ptr %t1)
  %t11 = icmp eq i32 %t8, 0
  br i1 %t11, label %common.ret, label %end646

common.ret:                                       ; preds = %entry, %whileEnd650
  ret ptr %t3

end646:                                           ; preds = %entry
  %t15 = tail call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  %t1916 = icmp sgt i32 %t5, 0
  br i1 %t1916, label %whileBody649.lr.ph, label %whileEnd650

whileBody649.lr.ph:                               ; preds = %end646
  %t25 = sub i32 %t5, %t8
  %t2913 = icmp sgt i32 %t8, 0
  br label %whileBody649

whileBody649:                                     ; preds = %whileBody649.lr.ph, %end659
  %t13.018 = phi ptr [ %t15, %whileBody649.lr.ph ], [ %t13.1, %end659 ]
  %t16.017 = phi i32 [ 0, %whileBody649.lr.ph ], [ %t16.1, %end659 ]
  %t26.not = icmp sgt i32 %t16.017, %t25
  br i1 %t26.not, label %else661, label %whileCond654.preheader

whileCond654.preheader:                           ; preds = %whileBody649
  br i1 %t2913, label %whileBody655, label %if660

whileBody655:                                     ; preds = %whileCond654.preheader, %whileBody655
  %t21.015 = phi i32 [ %t48, %whileBody655 ], [ 0, %whileCond654.preheader ]
  %t20.014 = phi i1 [ %spec.select, %whileBody655 ], [ true, %whileCond654.preheader ]
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
  br i1 %t29, label %whileBody655, label %end651

end651:                                           ; preds = %whileBody655
  br i1 %spec.select, label %if660, label %else661

if660:                                            ; preds = %whileCond654.preheader, %end651
  store ptr %t13.018, ptr %t54, align 8
  call void @_zen_list_push(ptr %t3, ptr nonnull %t54)
  %t56 = call ptr @_str_dup(ptr nonnull @.str_stdlib_stdlib_0)
  br label %end659

else661:                                          ; preds = %whileBody649, %end651
  %2 = sext i32 %t16.017 to i64
  %t66 = getelementptr i8, ptr %t0, i64 %2
  %t67 = load i8, ptr %t66, align 1
  %t68 = call ptr @_zen_char_to_string(i8 %t67)
  %t70 = call ptr @_str_concat(ptr %t13.018, ptr %t68)
  br label %end659

end659:                                           ; preds = %else661, %if660
  %t8.pn = phi i32 [ %t8, %if660 ], [ 1, %else661 ]
  %t13.1 = phi ptr [ %t56, %if660 ], [ %t70, %else661 ]
  call void @_zen_string_free(ptr %t13.018)
  %t16.1 = add i32 %t8.pn, %t16.017
  %t19 = icmp slt i32 %t16.1, %t5
  br i1 %t19, label %whileBody649, label %whileEnd650

whileEnd650:                                      ; preds = %end659, %end646
  %t13.0.lcssa = phi ptr [ %t15, %end646 ], [ %t13.1, %end659 ]
  store ptr %t13.0.lcssa, ptr %t78, align 8
  call void @_zen_list_push(ptr %t3, ptr nonnull %t78)
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
