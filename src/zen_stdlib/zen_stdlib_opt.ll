; ModuleID = '/sdcard/zen/src/zen_stdlib/build/stdlib.ll'
source_filename = "/sdcard/zen/src/zen_stdlib/build/stdlib.ll"

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
@.str_stdlib_stdlib_8 = private unnamed_addr constant [2 x i8] c".\00"
@.str_stdlib_stdlib_9 = private unnamed_addr constant [2 x i8] c"|\00"
@.str_stdlib_stdlib_14 = private unnamed_addr constant [2 x i8] c"0\00"
@.str_stdlib_stdlib_15 = private unnamed_addr constant [2 x i8] c"9\00"
@.str_stdlib_stdlib_16 = private unnamed_addr constant [53 x i8] c"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ\00"
@.str_stdlib_stdlib_18 = private unnamed_addr constant [63 x i8] c"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\00"
@.str_stdlib_stdlib_21 = private unnamed_addr constant [5 x i8] c":int\00"
@.str_stdlib_stdlib_23 = private unnamed_addr constant [4 x i8] c":id\00"
@.str_stdlib_stdlib_25 = private unnamed_addr constant [8 x i8] c":string\00"
@t_stdlib_78 = local_unnamed_addr global i32 0
@.str_stdlib_stdlib_33 = private unnamed_addr constant [5 x i8] c"null\00"

declare void @_zen_list_push(ptr, ptr) local_unnamed_addr

declare ptr @_zen_list_new(i64) local_unnamed_addr

declare ptr @_int_to_string_ascii(i32) local_unnamed_addr

declare i32 @_string_to_int_ascii(ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: read)
declare i32 @strcmp(ptr captures(none), ptr captures(none)) local_unnamed_addr #0

declare ptr @_str_concat(ptr, ptr) local_unnamed_addr

declare ptr @_zen_char_to_string(i8) local_unnamed_addr

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
  %common.ret.op = phi double [ %t39, %if34 ], [ 1.000000e+00, %entry ], [ %., %if23 ], [ %spec.select, %if17 ], [ 1.000000e+00, %end14 ], [ %t30, %whileEnd30 ], [ %t32, %whileBody29 ]
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
  br i1 %t18, label %end26, label %whileBody29.lr.ph

end26:                                            ; preds = %end22
  %t21 = sub i32 0, %t1
  %t2610 = icmp sgt i32 %t21, 0
  br i1 %t2610, label %whileBody29.lr.ph, label %if34

whileBody29.lr.ph:                                ; preds = %end22, %end26
  %exp.addr.017 = phi i32 [ %t21, %end26 ], [ %t1, %end22 ]
  %t29 = sitofp i32 %t0 to double
  %t32 = load double, ptr @INF, align 8
  br label %whileBody29

whileCond28:                                      ; preds = %whileBody29
  %t36 = add nuw nsw i32 %storemerge12, 1
  %t26 = icmp samesign ult i32 %t36, %exp.addr.017
  br i1 %t26, label %whileBody29, label %whileEnd30

whileBody29:                                      ; preds = %whileBody29.lr.ph, %whileCond28
  %storemerge12 = phi i32 [ 0, %whileBody29.lr.ph ], [ %t36, %whileCond28 ]
  %t30911 = phi double [ 1.000000e+00, %whileBody29.lr.ph ], [ %t30, %whileCond28 ]
  %t30 = fmul double %t30911, %t29
  %t33 = fcmp oeq double %t30, %t32
  br i1 %t33, label %common.ret, label %whileCond28

whileEnd30:                                       ; preds = %whileCond28
  br i1 %t18, label %if34, label %common.ret

if34:                                             ; preds = %end26, %whileEnd30
  %t3819 = phi double [ %t30, %whileEnd30 ], [ 1.000000e+00, %end26 ]
  %t39 = fdiv double 1.000000e+00, %t3819
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define i32 @sqrt(i32 %t0) local_unnamed_addr #2 {
entry:
  %t2 = icmp slt i32 %t0, 0
  br i1 %t2, label %common.ret, label %whileCond37

common.ret:                                       ; preds = %entry, %whileEnd39
  %common.ret.op = phi i32 [ %t12, %whileEnd39 ], [ -1, %entry ]
  ret i32 %common.ret.op

whileCond37:                                      ; preds = %entry, %whileCond37
  %storemerge = phi i32 [ %t10, %whileCond37 ], [ 1, %entry ]
  %t6 = mul i32 %storemerge, %storemerge
  %t8.not = icmp sgt i32 %t6, %t0
  %t10 = add i32 %storemerge, 1
  br i1 %t8.not, label %whileEnd39, label %whileCond37

whileEnd39:                                       ; preds = %whileCond37
  %t12 = add i32 %storemerge, -1
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
  %t32.i = load double, ptr @INF, align 8
  br label %whileBody29.i

whileCond28.i:                                    ; preds = %whileBody29.i
  %t36.i = add nuw nsw i32 %storemerge12.i, 1
  %t26.i = icmp samesign ult i32 %t36.i, %t1
  br i1 %t26.i, label %whileBody29.i, label %pow.exit

whileBody29.i:                                    ; preds = %whileCond28.i, %whileBody29.lr.ph.i
  %storemerge12.i = phi i32 [ 0, %whileBody29.lr.ph.i ], [ %t36.i, %whileCond28.i ]
  %t30911.i = phi double [ 1.000000e+00, %whileBody29.lr.ph.i ], [ %t30.i, %whileCond28.i ]
  %t30.i = fmul double %t30911.i, 1.000000e+01
  %t33.i = fcmp oeq double %t30.i, %t32.i
  br i1 %t33.i, label %pow.exit, label %whileCond28.i

pow.exit:                                         ; preds = %whileCond28.i, %whileBody29.i, %end55
  %common.ret.op.i = phi double [ 1.000000e+00, %end55 ], [ %t30.i, %whileCond28.i ], [ %t32.i, %whileBody29.i ]
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
  %t9 = srem i32 %t0, %spec.select
  %t11 = icmp slt i32 %t9, 0
  %t14 = select i1 %t11, i32 %spec.select, i32 0
  %common.ret.op = add i32 %t14, %t9
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
  %t4 = icmp eq i32 %t0, 0
  br i1 %t4, label %common.ret, label %whileBody74

whileBody74:                                      ; preds = %end69, %whileBody74
  %storemerge6 = phi i32 [ %t15, %whileBody74 ], [ 1, %end69 ]
  %t1335 = phi double [ %t13, %whileBody74 ], [ 1.000000e+00, %end69 ]
  %t12 = sitofp i32 %storemerge6 to double
  %t13 = fmul double %t1335, %t12
  %t15 = add i32 %storemerge6, 1
  %t9.not = icmp sgt i32 %t15, %t0
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
  %storemerge = phi i32 [ %t17, %whileBody83 ], [ 3, %end78 ]
  br label %whileCond37.i

whileCond37.i:                                    ; preds = %whileCond82, %whileCond37.i
  %storemerge.i = phi i32 [ %t10.i, %whileCond37.i ], [ 1, %whileCond82 ]
  %t6.i = mul i32 %storemerge.i, %storemerge.i
  %t8.not.i = icmp sgt i32 %t6.i, %t0
  %t10.i = add i32 %storemerge.i, 1
  br i1 %t8.not.i, label %whileEnd39.i, label %whileCond37.i

whileEnd39.i:                                     ; preds = %whileCond37.i
  %t12.i = add i32 %storemerge.i, -1
  %t11.not = icmp sgt i32 %storemerge, %t12.i
  br i1 %t11.not, label %common.ret, label %whileBody83

whileBody83:                                      ; preds = %whileEnd39.i
  %t14 = srem i32 %t0, %storemerge
  %t15 = icmp eq i32 %t14, 0
  %t17 = add i32 %storemerge, 2
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
  %t6.03 = add i32 %t2, -1
  %t104 = icmp sgt i32 %t6.03, -1
  br i1 %t104, label %whileBody93, label %whileEnd94

whileBody93:                                      ; preds = %entry, %whileBody93
  %t6.06 = phi i32 [ %t6.0, %whileBody93 ], [ %t6.03, %entry ]
  %t4.05 = phi ptr [ %t18, %whileBody93 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %t6.06 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %t18 = tail call ptr @_str_concat(ptr %t4.05, ptr %t16)
  %t6.0 = add nsw i32 %t6.06, -1
  %t10.not = icmp eq i32 %t6.06, 0
  br i1 %t10.not, label %whileEnd94, label %whileBody93

whileEnd94:                                       ; preds = %whileBody93, %entry
  %t4.0.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t18, %whileBody93 ]
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
  %t15.not6 = icmp slt i32 %t14, 0
  br i1 %t15.not6, label %common.ret, label %whileBody98.lr.ph

whileBody98.lr.ph:                                ; preds = %whileCond97.preheader
  %t204 = icmp sgt i32 %t6, 0
  br label %whileBody98

common.ret:                                       ; preds = %whileBody98, %end105, %whileEnd102, %whileCond97.preheader, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ -1, %whileCond97.preheader ], [ %storemerge7, %whileBody98 ], [ -1, %end105 ], [ %storemerge7, %whileEnd102 ]
  ret i32 %common.ret.op

whileBody98:                                      ; preds = %whileBody98.lr.ph, %end105
  %storemerge7 = phi i32 [ 0, %whileBody98.lr.ph ], [ %t43, %end105 ]
  br i1 %t204, label %whileBody101, label %common.ret

whileBody101:                                     ; preds = %whileBody98, %whileBody101
  %storemerge35 = phi i32 [ %t39, %whileBody101 ], [ 0, %whileBody98 ]
  %0 = phi i1 [ %spec.select, %whileBody101 ], [ true, %whileBody98 ]
  %t24 = add i32 %storemerge35, %storemerge7
  %1 = sext i32 %t24 to i64
  %t25 = getelementptr i8, ptr %t0, i64 %1
  %t26 = load i8, ptr %t25, align 1
  %t27 = tail call ptr @_zen_char_to_string(i8 %t26)
  %2 = zext nneg i32 %storemerge35 to i64
  %t31 = getelementptr i8, ptr %t1, i64 %2
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t27, ptr noundef nonnull dereferenceable(1) %t33)
  %t37.not = icmp eq i32 %t36, 0
  %spec.select = select i1 %t37.not, i1 %0, i1 false
  %t39 = add nuw nsw i32 %storemerge35, 1
  %t20 = icmp slt i32 %t39, %t6
  br i1 %t20, label %whileBody101, label %whileEnd102

whileEnd102:                                      ; preds = %whileBody101
  br i1 %spec.select, label %common.ret, label %end105

end105:                                           ; preds = %whileEnd102
  %t43 = add i32 %storemerge7, 1
  %t15.not = icmp sgt i32 %t43, %t14
  br i1 %t15.not, label %common.ret, label %whileBody98
}

define ptr @slice(ptr %t0, i32 %t1, i32 %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %spec.store.select = tail call i32 @llvm.smax.i32(i32 %t1, i32 0)
  %spec.select = tail call i32 @llvm.smin.i32(i32 %t2, i32 %t4)
  %t14 = icmp sle i32 %spec.store.select, %spec.select
  %t227 = icmp samesign ult i32 %spec.store.select, %spec.select
  %or.cond = select i1 %t14, i1 %t227, i1 false
  br i1 %or.cond, label %whileBody114, label %common.ret

common.ret:                                       ; preds = %whileBody114, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t30, %whileBody114 ]
  ret ptr %common.ret.op

whileBody114:                                     ; preds = %entry, %whileBody114
  %storemerge9 = phi i32 [ %t32, %whileBody114 ], [ %spec.store.select, %entry ]
  %t3068 = phi ptr [ %t30, %whileBody114 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %storemerge9 to i64
  %t26 = getelementptr i8, ptr %t0, i64 %0
  %t27 = load i8, ptr %t26, align 1
  %t28 = tail call ptr @_zen_char_to_string(i8 %t27)
  %t30 = tail call ptr @_str_concat(ptr %t3068, ptr %t28)
  %t32 = add nuw nsw i32 %storemerge9, 1
  %t22 = icmp slt i32 %t32, %spec.select
  br i1 %t22, label %whileBody114, label %common.ret
}

define ptr @charAt(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t7 = icmp slt i32 %t1, 0
  %t10 = icmp sge i32 %t1, %t3
  %t5 = select i1 %t7, i1 true, i1 %t10
  br i1 %t5, label %common.ret, label %end116

common.ret:                                       ; preds = %entry, %end116
  %common.ret.op = phi ptr [ %t16, %end116 ], [ @.str_stdlib_stdlib_0, %entry ]
  ret ptr %common.ret.op

end116:                                           ; preds = %entry
  %0 = zext nneg i32 %t1 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
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
  %t17.not11 = icmp slt i32 %t16, 0
  br i1 %t17.not11, label %common.ret, label %whileBody124.lr.ph

whileBody124.lr.ph:                               ; preds = %whileCond123.preheader
  %t229 = icmp sgt i32 %t7, 0
  br label %whileBody124

common.ret:                                       ; preds = %end131, %whileBody137, %whileEnd135, %whileCond123.preheader, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t0, %whileCond123.preheader ], [ %t61, %whileEnd135 ], [ %t78, %whileBody137 ], [ %t0, %end131 ]
  ret ptr %common.ret.op

whileBody124:                                     ; preds = %whileBody124.lr.ph, %end131
  %storemerge12 = phi i32 [ 0, %whileBody124.lr.ph ], [ %t83, %end131 ]
  br i1 %t229, label %whileBody127, label %if132

whileBody127:                                     ; preds = %whileBody124, %whileBody127
  %storemerge510 = phi i32 [ %t41, %whileBody127 ], [ 0, %whileBody124 ]
  %0 = phi i1 [ %spec.select, %whileBody127 ], [ true, %whileBody124 ]
  %t26 = add i32 %storemerge510, %storemerge12
  %1 = sext i32 %t26 to i64
  %t27 = getelementptr i8, ptr %t0, i64 %1
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @_zen_char_to_string(i8 %t28)
  %2 = zext nneg i32 %storemerge510 to i64
  %t33 = getelementptr i8, ptr %t1, i64 %2
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @_zen_char_to_string(i8 %t34)
  %t38 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t29, ptr noundef nonnull dereferenceable(1) %t35)
  %t39.not = icmp eq i32 %t38, 0
  %spec.select = select i1 %t39.not, i1 %0, i1 false
  %t41 = add nuw nsw i32 %storemerge510, 1
  %t22 = icmp slt i32 %t41, %t7
  br i1 %t22, label %whileBody127, label %whileEnd128

whileEnd128:                                      ; preds = %whileBody127
  br i1 %spec.select, label %if132, label %end131

if132:                                            ; preds = %whileBody124, %whileEnd128
  %t4814 = icmp sgt i32 %storemerge12, 0
  br i1 %t4814, label %whileBody134, label %whileEnd135

whileBody134:                                     ; preds = %if132, %whileBody134
  %storemerge616 = phi i32 [ %t58, %whileBody134 ], [ 0, %if132 ]
  %t561315 = phi ptr [ %t56, %whileBody134 ], [ @.str_stdlib_stdlib_0, %if132 ]
  %3 = zext nneg i32 %storemerge616 to i64
  %t52 = getelementptr i8, ptr %t0, i64 %3
  %t53 = load i8, ptr %t52, align 1
  %t54 = tail call ptr @_zen_char_to_string(i8 %t53)
  %t56 = tail call ptr @_str_concat(ptr %t561315, ptr %t54)
  %t58 = add nuw nsw i32 %storemerge616, 1
  %t48 = icmp slt i32 %t58, %storemerge12
  br i1 %t48, label %whileBody134, label %whileEnd135

whileEnd135:                                      ; preds = %whileBody134, %if132
  %t5613.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %if132 ], [ %t56, %whileBody134 ]
  %t61 = tail call ptr @_str_concat(ptr %t5613.lcssa, ptr %t2)
  %t63 = tail call i32 @strlen(ptr %t2)
  %t67 = add i32 %storemerge12, %t7
  %t7020 = icmp slt i32 %t67, %t4
  br i1 %t7020, label %whileBody137, label %common.ret

whileBody137:                                     ; preds = %whileEnd135, %whileBody137
  %storemerge722 = phi i32 [ %t80, %whileBody137 ], [ %t67, %whileEnd135 ]
  %t781921 = phi ptr [ %t78, %whileBody137 ], [ %t61, %whileEnd135 ]
  %4 = sext i32 %storemerge722 to i64
  %t74 = getelementptr i8, ptr %t0, i64 %4
  %t75 = load i8, ptr %t74, align 1
  %t76 = tail call ptr @_zen_char_to_string(i8 %t75)
  %t78 = tail call ptr @_str_concat(ptr %t781921, ptr %t76)
  %t80 = add nsw i32 %storemerge722, 1
  %t70 = icmp slt i32 %t80, %t4
  br i1 %t70, label %whileBody137, label %common.ret

end131:                                           ; preds = %whileEnd128
  %t83 = add i32 %storemerge12, 1
  %t17.not = icmp sgt i32 %t83, %t16
  br i1 %t17.not, label %common.ret, label %whileBody124
}

define ptr @replaceAll(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  br i1 %t10, label %common.ret, label %end139

common.ret:                                       ; preds = %end152, %end139, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ @.str_stdlib_stdlib_0, %end139 ], [ %t61, %end152 ]
  ret ptr %common.ret.op

end139:                                           ; preds = %entry
  %t1713 = icmp sgt i32 %t4, 0
  br i1 %t1713, label %whileBody142.lr.ph, label %common.ret

whileBody142.lr.ph:                               ; preds = %end139
  %t23 = sub i32 %t4, %t7
  %t278 = icmp sgt i32 %t7, 0
  br label %whileBody142

whileBody142:                                     ; preds = %whileBody142.lr.ph, %end152
  %storemerge515 = phi i32 [ 0, %whileBody142.lr.ph ], [ %t63, %end152 ]
  %t611114 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody142.lr.ph ], [ %t61, %end152 ]
  %t24.not = icmp sgt i32 %storemerge515, %t23
  br i1 %t24.not, label %else154, label %whileCond147.preheader

whileCond147.preheader:                           ; preds = %whileBody142
  br i1 %t278, label %whileBody148, label %end152

whileBody148:                                     ; preds = %whileCond147.preheader, %whileBody148
  %t4679 = phi i32 [ %t46, %whileBody148 ], [ 0, %whileCond147.preheader ]
  %0 = phi i1 [ %spec.select, %whileBody148 ], [ true, %whileCond147.preheader ]
  %t31 = add i32 %t4679, %storemerge515
  %1 = sext i32 %t31 to i64
  %t32 = getelementptr i8, ptr %t0, i64 %1
  %t33 = load i8, ptr %t32, align 1
  %t34 = tail call ptr @_zen_char_to_string(i8 %t33)
  %2 = zext nneg i32 %t4679 to i64
  %t38 = getelementptr i8, ptr %t1, i64 %2
  %t39 = load i8, ptr %t38, align 1
  %t40 = tail call ptr @_zen_char_to_string(i8 %t39)
  %t43 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t34, ptr noundef nonnull dereferenceable(1) %t40)
  %t44.not = icmp eq i32 %t43, 0
  %spec.select = select i1 %t44.not, i1 %0, i1 false
  %t46 = add nuw nsw i32 %t4679, 1
  %t27 = icmp slt i32 %t46, %t7
  br i1 %t27, label %whileBody148, label %end144

end144:                                           ; preds = %whileBody148
  br i1 %spec.select, label %end152, label %else154

else154:                                          ; preds = %whileBody142, %end144
  %3 = sext i32 %storemerge515 to i64
  %t57 = getelementptr i8, ptr %t0, i64 %3
  %t58 = load i8, ptr %t57, align 1
  %t59 = tail call ptr @_zen_char_to_string(i8 %t58)
  br label %end152

end152:                                           ; preds = %end144, %whileCond147.preheader, %else154
  %t59.sink = phi ptr [ %t59, %else154 ], [ %t2, %whileCond147.preheader ], [ %t2, %end144 ]
  %.sink = phi i32 [ 1, %else154 ], [ %t7, %whileCond147.preheader ], [ %t7, %end144 ]
  %t61 = tail call ptr @_str_concat(ptr %t611114, ptr %t59.sink)
  %t63 = add i32 %storemerge515, %.sink
  %t17 = icmp slt i32 %t63, %t4
  br i1 %t17, label %whileBody142, label %common.ret
}

define noundef i1 @contains(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t6, 0
  br i1 %t9, label %common.ret, label %whileCond157.preheader

whileCond157.preheader:                           ; preds = %entry
  %t14 = sub i32 %t3, %t6
  %t15.not6 = icmp slt i32 %t14, 0
  br i1 %t15.not6, label %common.ret, label %whileBody158.lr.ph

whileBody158.lr.ph:                               ; preds = %whileCond157.preheader
  %t204 = icmp sgt i32 %t6, 0
  br label %whileBody158

common.ret:                                       ; preds = %whileBody158, %whileEnd162, %whileCond157, %whileCond157.preheader, %entry
  %common.ret.op = phi i1 [ true, %entry ], [ false, %whileCond157.preheader ], [ true, %whileBody158 ], [ true, %whileEnd162 ], [ false, %whileCond157 ]
  ret i1 %common.ret.op

whileCond157:                                     ; preds = %whileEnd162
  %t42 = add i32 %storemerge7, 1
  %t15.not = icmp sgt i32 %t42, %t14
  br i1 %t15.not, label %common.ret, label %whileBody158

whileBody158:                                     ; preds = %whileBody158.lr.ph, %whileCond157
  %storemerge7 = phi i32 [ 0, %whileBody158.lr.ph ], [ %t42, %whileCond157 ]
  br i1 %t204, label %whileBody161, label %common.ret

whileBody161:                                     ; preds = %whileBody158, %whileBody161
  %storemerge35 = phi i32 [ %t39, %whileBody161 ], [ 0, %whileBody158 ]
  %0 = phi i1 [ %spec.select, %whileBody161 ], [ true, %whileBody158 ]
  %t24 = add i32 %storemerge35, %storemerge7
  %1 = sext i32 %t24 to i64
  %t25 = getelementptr i8, ptr %t0, i64 %1
  %t26 = load i8, ptr %t25, align 1
  %t27 = tail call ptr @_zen_char_to_string(i8 %t26)
  %2 = zext nneg i32 %storemerge35 to i64
  %t31 = getelementptr i8, ptr %t1, i64 %2
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @_zen_char_to_string(i8 %t32)
  %t36 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t27, ptr noundef nonnull dereferenceable(1) %t33)
  %t37.not = icmp eq i32 %t36, 0
  %spec.select = select i1 %t37.not, i1 %0, i1 false
  %t39 = add nuw nsw i32 %storemerge35, 1
  %t20 = icmp slt i32 %t39, %t6
  br i1 %t20, label %whileBody161, label %whileEnd162

whileEnd162:                                      ; preds = %whileBody161
  br i1 %spec.select, label %common.ret, label %whileCond157
}

define ptr @upperCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t93 = icmp sgt i32 %t2, 0
  br i1 %t93, label %whileBody168, label %whileEnd169

whileBody168:                                     ; preds = %entry, %end170
  %t6.05 = phi i32 [ %t38, %end170 ], [ 0, %entry ]
  %t4.04 = phi ptr [ %t36, %end170 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %t6.05 to i64
  %t13 = getelementptr i8, ptr %t0, i64 %0
  %t14 = load i8, ptr %t13, align 1
  %t15 = tail call ptr @_zen_char_to_string(i8 %t14)
  %t18 = tail call i32 @_string_to_int_ascii(ptr %t15)
  %t23 = tail call i32 @_string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_1)
  %t27 = tail call i32 @_string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_2)
  %t24 = icmp sge i32 %t18, %t23
  %t28 = icmp sle i32 %t18, %t27
  %t20 = select i1 %t24, i1 %t28, i1 false
  br i1 %t20, label %if174, label %end170

if174:                                            ; preds = %whileBody168
  %t31 = add i32 %t18, -32
  %t32 = tail call ptr @_int_to_string_ascii(i32 %t31)
  br label %end170

end170:                                           ; preds = %whileBody168, %if174
  %t15.sink = phi ptr [ %t32, %if174 ], [ %t15, %whileBody168 ]
  %t36 = tail call ptr @_str_concat(ptr %t4.04, ptr %t15.sink)
  %t38 = add nuw nsw i32 %t6.05, 1
  %t9 = icmp slt i32 %t38, %t2
  br i1 %t9, label %whileBody168, label %whileEnd169

whileEnd169:                                      ; preds = %end170, %entry
  %t4.0.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t36, %end170 ]
  ret ptr %t4.0.lcssa
}

define ptr @lowerCase(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t93 = icmp sgt i32 %t2, 0
  br i1 %t93, label %whileBody177, label %whileEnd178

whileBody177:                                     ; preds = %entry, %end179
  %t6.05 = phi i32 [ %t38, %end179 ], [ 0, %entry ]
  %t4.04 = phi ptr [ %t36, %end179 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %t6.05 to i64
  %t13 = getelementptr i8, ptr %t0, i64 %0
  %t14 = load i8, ptr %t13, align 1
  %t15 = tail call ptr @_zen_char_to_string(i8 %t14)
  %t18 = tail call i32 @_string_to_int_ascii(ptr %t15)
  %t23 = tail call i32 @_string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_3)
  %t27 = tail call i32 @_string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_4)
  %t24 = icmp sge i32 %t18, %t23
  %t28 = icmp sle i32 %t18, %t27
  %t20 = select i1 %t24, i1 %t28, i1 false
  br i1 %t20, label %if183, label %end179

if183:                                            ; preds = %whileBody177
  %t31 = add i32 %t18, 32
  %t32 = tail call ptr @_int_to_string_ascii(i32 %t31)
  br label %end179

end179:                                           ; preds = %whileBody177, %if183
  %t15.sink = phi ptr [ %t32, %if183 ], [ %t15, %whileBody177 ]
  %t36 = tail call ptr @_str_concat(ptr %t4.04, ptr %t15.sink)
  %t38 = add nuw nsw i32 %t6.05, 1
  %t9 = icmp slt i32 %t38, %t2
  br i1 %t9, label %whileBody177, label %whileEnd178

whileEnd178:                                      ; preds = %end179, %entry
  %t4.0.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t36, %end179 ]
  ret ptr %t4.0.lcssa
}

define noundef i1 @startsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t6 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp sgt i32 %t6, %t3
  br i1 %t10, label %common.ret, label %whileCond187.preheader

whileCond187.preheader:                           ; preds = %entry
  %t142 = icmp sgt i32 %t6, 0
  br i1 %t142, label %whileBody188, label %common.ret

common.ret:                                       ; preds = %whileBody188, %whileCond187.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond187.preheader ], [ %t29.not, %whileBody188 ]
  ret i1 %common.ret.op

whileBody188:                                     ; preds = %whileCond187.preheader, %whileBody188
  %storemerge3 = phi i32 [ %t31, %whileBody188 ], [ 0, %whileCond187.preheader ]
  %0 = zext nneg i32 %storemerge3 to i64
  %t17 = getelementptr i8, ptr %t0, i64 %0
  %t18 = load i8, ptr %t17, align 1
  %t19 = tail call ptr @_zen_char_to_string(i8 %t18)
  %t23 = getelementptr i8, ptr %t1, i64 %0
  %t24 = load i8, ptr %t23, align 1
  %t25 = tail call ptr @_zen_char_to_string(i8 %t24)
  %t28 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t19, ptr noundef nonnull dereferenceable(1) %t25)
  %t29.not = icmp eq i32 %t28, 0
  %t31 = add nuw nsw i32 %storemerge3, 1
  %t14 = icmp slt i32 %t31, %t6
  %or.cond = select i1 %t29.not, i1 %t14, i1 false
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
  %t144 = icmp sgt i32 %t6, 0
  br i1 %t144, label %whileBody195, label %common.ret

common.ret:                                       ; preds = %whileBody195, %whileCond194.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond194.preheader ], [ %t33.not, %whileBody195 ]
  ret i1 %common.ret.op

whileBody195:                                     ; preds = %whileCond194.preheader, %whileBody195
  %storemerge5 = phi i32 [ %t35, %whileBody195 ], [ 0, %whileCond194.preheader ]
  %t20 = add i32 %t18, %storemerge5
  %0 = sext i32 %t20 to i64
  %t21 = getelementptr i8, ptr %t0, i64 %0
  %t22 = load i8, ptr %t21, align 1
  %t23 = tail call ptr @_zen_char_to_string(i8 %t22)
  %1 = zext nneg i32 %storemerge5 to i64
  %t27 = getelementptr i8, ptr %t1, i64 %1
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @_zen_char_to_string(i8 %t28)
  %t32 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t23, ptr noundef nonnull dereferenceable(1) %t29)
  %t33.not = icmp eq i32 %t32, 0
  %t35 = add nuw nsw i32 %storemerge5, 1
  %t14 = icmp slt i32 %t35, %t6
  %or.cond = select i1 %t33.not, i1 %t14, i1 false
  br i1 %or.cond, label %whileBody195, label %common.ret
}

define ptr @trim(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t1024 = icmp sgt i32 %t2, 0
  br i1 %t1024, label %whileBody200, label %whileEnd201

whileBody200:                                     ; preds = %entry, %if209
  %t4.025 = phi i32 [ %t36, %if209 ], [ 0, %entry ]
  %0 = zext nneg i32 %t4.025 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @_zen_char_to_string(i8 %t15)
  %1 = load i8, ptr %t16, align 1
  switch i8 %1, label %whileEnd201 [
    i8 32, label %whileBody200.tail
    i8 10, label %rhs206.tail
    i8 9, label %rhs203.tail
  ]

whileBody200.tail:                                ; preds = %whileBody200
  %2 = getelementptr inbounds nuw i8, ptr %t16, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %if209, label %whileEnd201

rhs206.tail:                                      ; preds = %whileBody200
  %5 = getelementptr inbounds nuw i8, ptr %t16, i64 1
  %6 = load i8, ptr %5, align 1
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %if209, label %whileEnd201

rhs203.tail:                                      ; preds = %whileBody200
  %8 = getelementptr inbounds nuw i8, ptr %t16, i64 1
  %9 = load i8, ptr %8, align 1
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %if209, label %whileEnd201

if209:                                            ; preds = %whileBody200.tail, %rhs206.tail, %rhs203.tail
  %t36 = add nuw nsw i32 %t4.025, 1
  %t10 = icmp slt i32 %t36, %t2
  br i1 %t10, label %whileBody200, label %whileEnd201

whileEnd201:                                      ; preds = %rhs206.tail, %whileBody200.tail, %if209, %rhs203.tail, %whileBody200, %entry
  %t4.0.lcssa = phi i32 [ 0, %entry ], [ %t4.025, %rhs206.tail ], [ %t4.025, %whileBody200.tail ], [ %t4.025, %rhs203.tail ], [ %t2, %if209 ], [ %t4.025, %whileBody200 ]
  %t5.027 = add i32 %t2, -1
  %t39.not28 = icmp slt i32 %t5.027, %t4.0.lcssa
  br i1 %t39.not28, label %whileEnd213, label %whileBody212

whileBody212:                                     ; preds = %whileEnd201, %if221
  %t5.029 = phi i32 [ %t5.0, %if221 ], [ %t5.027, %whileEnd201 ]
  %11 = sext i32 %t5.029 to i64
  %t43 = getelementptr i8, ptr %t0, i64 %11
  %t44 = load i8, ptr %t43, align 1
  %t45 = tail call ptr @_zen_char_to_string(i8 %t44)
  %12 = load i8, ptr %t45, align 1
  switch i8 %12, label %whileEnd213 [
    i8 32, label %whileBody212.tail
    i8 10, label %rhs218.tail
    i8 9, label %rhs215.tail
  ]

whileBody212.tail:                                ; preds = %whileBody212
  %13 = getelementptr inbounds nuw i8, ptr %t45, i64 1
  %14 = load i8, ptr %13, align 1
  %15 = icmp eq i8 %14, 0
  br i1 %15, label %if221, label %whileEnd213

rhs218.tail:                                      ; preds = %whileBody212
  %16 = getelementptr inbounds nuw i8, ptr %t45, i64 1
  %17 = load i8, ptr %16, align 1
  %18 = icmp eq i8 %17, 0
  br i1 %18, label %if221, label %whileEnd213

rhs215.tail:                                      ; preds = %whileBody212
  %19 = getelementptr inbounds nuw i8, ptr %t45, i64 1
  %20 = load i8, ptr %19, align 1
  %21 = icmp eq i8 %20, 0
  br i1 %21, label %if221, label %whileEnd213

if221:                                            ; preds = %whileBody212.tail, %rhs218.tail, %rhs215.tail
  %t5.0 = add i32 %t5.029, -1
  %t39.not = icmp slt i32 %t5.0, %t4.0.lcssa
  br i1 %t39.not, label %whileEnd213, label %whileBody212

whileEnd213:                                      ; preds = %rhs218.tail, %whileBody212.tail, %if221, %rhs215.tail, %whileBody212, %whileEnd201
  %t5.0.lcssa = phi i32 [ %t5.027, %whileEnd201 ], [ %t5.029, %rhs218.tail ], [ %t5.029, %whileBody212.tail ], [ %t5.029, %rhs215.tail ], [ %t5.0, %if221 ], [ %t5.029, %whileBody212 ]
  %t72.not33 = icmp sgt i32 %t4.0.lcssa, %t5.0.lcssa
  br i1 %t72.not33, label %whileEnd225, label %whileBody224

whileBody224:                                     ; preds = %whileEnd213, %whileBody224
  %storemerge35 = phi i32 [ %t82, %whileBody224 ], [ %t4.0.lcssa, %whileEnd213 ]
  %t803234 = phi ptr [ %t80, %whileBody224 ], [ @.str_stdlib_stdlib_0, %whileEnd213 ]
  %22 = sext i32 %storemerge35 to i64
  %t76 = getelementptr i8, ptr %t0, i64 %22
  %t77 = load i8, ptr %t76, align 1
  %t78 = tail call ptr @_zen_char_to_string(i8 %t77)
  %t80 = tail call ptr @_str_concat(ptr %t803234, ptr %t78)
  %t82 = add i32 %storemerge35, 1
  %t72.not = icmp sgt i32 %t82, %t5.0.lcssa
  br i1 %t72.not, label %whileEnd225, label %whileBody224

whileEnd225:                                      ; preds = %whileBody224, %whileEnd213
  %t8032.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd213 ], [ %t80, %whileBody224 ]
  ret ptr %t8032.lcssa
}

define ptr @splitAt(ptr %t0, ptr %t1, i32 %t2) local_unnamed_addr {
entry:
  %t4 = tail call i32 @strlen(ptr %t0)
  %t7 = tail call i32 @strlen(ptr %t1)
  %t10 = icmp eq i32 %t7, 0
  br i1 %t10, label %common.ret, label %end226

common.ret:                                       ; preds = %if240, %whileEnd230, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %spec.select, %whileEnd230 ], [ %t661620, %if240 ]
  ret ptr %common.ret.op

end226:                                           ; preds = %entry
  %t1819 = icmp sgt i32 %t4, 0
  br i1 %t1819, label %whileBody229.lr.ph, label %whileEnd230

whileBody229.lr.ph:                               ; preds = %end226
  %t24 = sub i32 %t4, %t7
  %t288 = icmp sgt i32 %t7, 0
  br label %whileBody229

whileBody229:                                     ; preds = %whileBody229.lr.ph, %end239
  %storemerge1122 = phi i32 [ 0, %whileBody229.lr.ph ], [ %t68, %end239 ]
  %t541421 = phi i32 [ 0, %whileBody229.lr.ph ], [ %t5413, %end239 ]
  %t661620 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody229.lr.ph ], [ %t6617, %end239 ]
  %t25.not = icmp sgt i32 %storemerge1122, %t24
  br i1 %t25.not, label %else241, label %whileCond234.preheader

whileCond234.preheader:                           ; preds = %whileBody229
  br i1 %t288, label %whileBody235, label %if240

whileBody235:                                     ; preds = %whileCond234.preheader, %whileBody235
  %t4779 = phi i32 [ %t47, %whileBody235 ], [ 0, %whileCond234.preheader ]
  %0 = phi i1 [ %spec.select26, %whileBody235 ], [ true, %whileCond234.preheader ]
  %t32 = add i32 %t4779, %storemerge1122
  %1 = sext i32 %t32 to i64
  %t33 = getelementptr i8, ptr %t0, i64 %1
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @_zen_char_to_string(i8 %t34)
  %2 = zext nneg i32 %t4779 to i64
  %t39 = getelementptr i8, ptr %t1, i64 %2
  %t40 = load i8, ptr %t39, align 1
  %t41 = tail call ptr @_zen_char_to_string(i8 %t40)
  %t44 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t35, ptr noundef nonnull dereferenceable(1) %t41)
  %t45.not = icmp eq i32 %t44, 0
  %spec.select26 = select i1 %t45.not, i1 %0, i1 false
  %t47 = add nuw nsw i32 %t4779, 1
  %t28 = icmp slt i32 %t47, %t7
  br i1 %t28, label %whileBody235, label %end231

end231:                                           ; preds = %whileBody235
  br i1 %spec.select26, label %if240, label %else241

if240:                                            ; preds = %whileCond234.preheader, %end231
  %t51 = icmp eq i32 %t541421, %t2
  br i1 %t51, label %common.ret, label %end242

end242:                                           ; preds = %if240
  %t54 = add i32 %t541421, 1
  br label %end239

else241:                                          ; preds = %whileBody229, %end231
  %3 = sext i32 %storemerge1122 to i64
  %t62 = getelementptr i8, ptr %t0, i64 %3
  %t63 = load i8, ptr %t62, align 1
  %t64 = tail call ptr @_zen_char_to_string(i8 %t63)
  %t66 = tail call ptr @_str_concat(ptr %t661620, ptr %t64)
  br label %end239

end239:                                           ; preds = %else241, %end242
  %.sink = phi i32 [ 1, %else241 ], [ %t7, %end242 ]
  %t6617 = phi ptr [ %t66, %else241 ], [ @.str_stdlib_stdlib_0, %end242 ]
  %t5413 = phi i32 [ %t541421, %else241 ], [ %t54, %end242 ]
  %t68 = add i32 %storemerge1122, %.sink
  %t18 = icmp slt i32 %t68, %t4
  br i1 %t18, label %whileBody229, label %whileEnd230

whileEnd230:                                      ; preds = %end239, %end226
  %t6616.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %end226 ], [ %t6617, %end239 ]
  %t5414.lcssa = phi i32 [ 0, %end226 ], [ %t5413, %end239 ]
  %t71 = icmp eq i32 %t5414.lcssa, %t2
  %spec.select = select i1 %t71, ptr %t6616.lcssa, ptr @.str_stdlib_stdlib_0
  br label %common.ret
}

define ptr @repeat(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = icmp slt i32 %t1, 1
  br i1 %t3, label %common.ret, label %end246

common.ret:                                       ; preds = %whileBody251, %end246, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ @.str_stdlib_stdlib_0, %end246 ], [ %t15, %whileBody251 ]
  ret ptr %common.ret.op

end246:                                           ; preds = %entry
  %t6 = tail call i32 @strlen(ptr %t0)
  %t7 = icmp eq i32 %t6, 0
  br i1 %t7, label %common.ret, label %whileBody251

whileBody251:                                     ; preds = %end246, %whileBody251
  %count.addr.06 = phi i32 [ %t17, %whileBody251 ], [ %t1, %end246 ]
  %t1535 = phi ptr [ %t15, %whileBody251 ], [ @.str_stdlib_stdlib_0, %end246 ]
  %t15 = tail call ptr @_str_concat(ptr %t1535, ptr %t0)
  %t17 = add nsw i32 %count.addr.06, -1
  %t12 = icmp samesign ugt i32 %count.addr.06, 1
  br i1 %t12, label %whileBody251, label %common.ret
}

define i32 @count(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t4 = icmp eq i32 %t3, 0
  br i1 %t4, label %common.ret, label %end253

common.ret:                                       ; preds = %charAt.exit, %end255, %end253, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ 0, %end253 ], [ 0, %end255 ], [ %spec.select, %charAt.exit ]
  ret i32 %common.ret.op

end253:                                           ; preds = %entry
  %t6 = tail call i32 @strlen(ptr %t1)
  %t7 = icmp eq i32 %t6, 0
  br i1 %t7, label %common.ret, label %end255

end255:                                           ; preds = %end253
  %t123 = tail call i32 @strlen(ptr %t0)
  %t134 = icmp sgt i32 %t123, 0
  br i1 %t134, label %whileBody258, label %common.ret

whileBody258:                                     ; preds = %end255, %charAt.exit
  %storemerge6 = phi i32 [ %t24, %charAt.exit ], [ 0, %end255 ]
  %t2225 = phi i32 [ %spec.select, %charAt.exit ], [ 0, %end255 ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i.not = icmp slt i32 %storemerge6, %t3.i
  br i1 %t10.i.not, label %end116.i, label %charAt.exit

end116.i:                                         ; preds = %whileBody258
  %0 = zext nneg i32 %storemerge6 to i64
  %t14.i = getelementptr i8, ptr %t0, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %whileBody258, %end116.i
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody258 ]
  %t19 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t1)
  %t20 = icmp eq i32 %t19, 0
  %t22 = zext i1 %t20 to i32
  %spec.select = add i32 %t2225, %t22
  %t24 = add nuw nsw i32 %storemerge6, 1
  %t12 = tail call i32 @strlen(ptr %t0)
  %t13 = icmp slt i32 %t24, %t12
  br i1 %t13, label %whileBody258, label %common.ret
}

define ptr @padStart(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end262, label %common.ret

common.ret:                                       ; preds = %end262, %entry, %whileEnd268
  %common.ret.op = phi ptr [ %t28, %whileEnd268 ], [ %t0, %entry ], [ %t0, %end262 ]
  ret ptr %common.ret.op

end262:                                           ; preds = %entry
  %t9 = tail call i32 @strlen(ptr %t2)
  %t10 = icmp eq i32 %t9, 0
  br i1 %t10, label %common.ret, label %end264

end264:                                           ; preds = %end262
  %t15 = tail call i32 @strlen(ptr %t0)
  %t16 = sub i32 %t1, %t15
  %t203 = icmp sgt i32 %t16, 0
  br i1 %t203, label %whileBody267, label %whileEnd268

whileBody267:                                     ; preds = %end264, %whileBody267
  %t195 = phi i32 [ %t25, %whileBody267 ], [ %t16, %end264 ]
  %t2324 = phi ptr [ %t23, %whileBody267 ], [ @.str_stdlib_stdlib_0, %end264 ]
  %t23 = tail call ptr @_str_concat(ptr %t2324, ptr %t2)
  %t25 = add nsw i32 %t195, -1
  %t20 = icmp samesign ugt i32 %t195, 1
  br i1 %t20, label %whileBody267, label %whileEnd268

whileEnd268:                                      ; preds = %whileBody267, %end264
  %t232.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %end264 ], [ %t23, %whileBody267 ]
  %t28 = tail call ptr @_str_concat(ptr %t232.lcssa, ptr %t0)
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
  %t195 = phi i32 [ %t25, %whileBody274 ], [ %t16, %end271 ]
  %t2324 = phi ptr [ %t23, %whileBody274 ], [ %t0, %end271 ]
  %t23 = tail call ptr @_str_concat(ptr %t2324, ptr %t2)
  %t25 = add nsw i32 %t195, -1
  %t20 = icmp samesign ugt i32 %t195, 1
  br i1 %t20, label %whileBody274, label %common.ret
}

define ptr @padCenter(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6.not = icmp sgt i32 %t1, %t5
  br i1 %t6.not, label %end276, label %common.ret

common.ret:                                       ; preds = %end276, %entry, %whileEnd285
  %common.ret.op = phi ptr [ %t46, %whileEnd285 ], [ %t0, %entry ], [ %t0, %end276 ]
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
  %t294 = icmp sgt i32 %t16, 1
  br i1 %t294, label %whileBody281, label %whileCond283thread-pre-split

whileBody281:                                     ; preds = %end278, %whileBody281
  %t286 = phi i32 [ %t34, %whileBody281 ], [ %t19, %end278 ]
  %t3225 = phi ptr [ %t32, %whileBody281 ], [ @.str_stdlib_stdlib_0, %end278 ]
  %t32 = tail call ptr @_str_concat(ptr %t3225, ptr %t2)
  %t34 = add nsw i32 %t286, -1
  %t29 = icmp sgt i32 %t286, 1
  br i1 %t29, label %whileBody281, label %whileCond283thread-pre-split

whileCond283thread-pre-split:                     ; preds = %whileBody281, %end278
  %t42 = phi ptr [ @.str_stdlib_stdlib_0, %end278 ], [ %t32, %whileBody281 ]
  %t3610 = icmp sgt i32 %t23, 0
  br i1 %t3610, label %whileBody284, label %whileEnd285

whileBody284:                                     ; preds = %whileCond283thread-pre-split, %whileBody284
  %t3512 = phi i32 [ %t41, %whileBody284 ], [ %t23, %whileCond283thread-pre-split ]
  %t39811 = phi ptr [ %t39, %whileBody284 ], [ @.str_stdlib_stdlib_0, %whileCond283thread-pre-split ]
  %t39 = tail call ptr @_str_concat(ptr %t39811, ptr %t2)
  %t41 = add nsw i32 %t3512, -1
  %t36 = icmp samesign ugt i32 %t3512, 1
  br i1 %t36, label %whileBody284, label %whileEnd285

whileEnd285:                                      ; preds = %whileBody284, %whileCond283thread-pre-split
  %t398.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %whileCond283thread-pre-split ], [ %t39, %whileBody284 ]
  %t44 = tail call ptr @_str_concat(ptr %t42, ptr %t0)
  %t46 = tail call ptr @_str_concat(ptr %t44, ptr %t398.lcssa)
  br label %common.ret
}

define ptr @capitalize(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t3 = icmp eq i32 %t2, 0
  br i1 %t3, label %common.ret, label %end286

common.ret:                                       ; preds = %whileBody295, %end288, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t32, %end288 ], [ %t47, %whileBody295 ]
  ret ptr %common.ret.op

end286:                                           ; preds = %entry
  %t8 = load i8, ptr %t0, align 1
  %t9 = tail call ptr @_zen_char_to_string(i8 %t8)
  %t12 = tail call i32 @_string_to_int_ascii(ptr %t9)
  %t19 = tail call i32 @_string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_1)
  %t23 = tail call i32 @_string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_2)
  %t20 = icmp sge i32 %t12, %t19
  %t24 = icmp sle i32 %t12, %t23
  %t16 = select i1 %t20, i1 %t24, i1 false
  br i1 %t16, label %if292, label %end288

if292:                                            ; preds = %end286
  %t27 = add i32 %t12, -32
  %t28 = tail call ptr @_int_to_string_ascii(i32 %t27)
  br label %end288

end288:                                           ; preds = %end286, %if292
  %t9.sink = phi ptr [ %t28, %if292 ], [ %t9, %end286 ]
  %t32 = tail call ptr @_str_concat(ptr nonnull @.str_stdlib_stdlib_0, ptr %t9.sink)
  %t35 = tail call i32 @strlen(ptr nonnull %t0)
  %t393 = icmp sgt i32 %t35, 1
  br i1 %t393, label %whileBody295, label %common.ret

whileBody295:                                     ; preds = %end288, %whileBody295
  %t4915 = phi i32 [ %t49, %whileBody295 ], [ 1, %end288 ]
  %t4724 = phi ptr [ %t47, %whileBody295 ], [ %t32, %end288 ]
  %0 = zext nneg i32 %t4915 to i64
  %t43 = getelementptr i8, ptr %t0, i64 %0
  %t44 = load i8, ptr %t43, align 1
  %t45 = tail call ptr @_zen_char_to_string(i8 %t44)
  %t47 = tail call ptr @_str_concat(ptr %t4724, ptr %t45)
  %t49 = add nuw nsw i32 %t4915, 1
  %t39 = icmp slt i32 %t49, %t35
  br i1 %t39, label %whileBody295, label %common.ret
}

define ptr @extName(ptr %t0) local_unnamed_addr {
entry:
  %t2 = tail call i32 @strlen(ptr %t0)
  %t4.017 = add i32 %t2, -1
  %t818 = icmp sgt i32 %t4.017, -1
  br i1 %t818, label %whileBody298, label %common.ret

whileBody298:                                     ; preds = %entry, %whileCond297.backedge
  %t4.020 = phi i32 [ %t4.0, %whileCond297.backedge ], [ %t4.017, %entry ]
  %t4.0.in19 = phi i32 [ %t4.020, %whileCond297.backedge ], [ %t2, %entry ]
  %0 = zext nneg i32 %t4.020 to i64
  %t11 = getelementptr i8, ptr %t0, i64 %0
  %t12 = load i8, ptr %t11, align 1
  %t13 = tail call ptr @_zen_char_to_string(i8 %t12)
  %1 = load i8, ptr %t13, align 1
  %.not = icmp eq i8 %1, 46
  br i1 %.not, label %sub_1, label %whileCond297.backedge

sub_1:                                            ; preds = %whileBody298
  %2 = getelementptr inbounds nuw i8, ptr %t13, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %if301, label %whileCond297.backedge

whileCond297.backedge:                            ; preds = %whileBody298, %sub_1
  %t4.0 = add nsw i32 %t4.020, -1
  %t8 = icmp sgt i32 %t4.020, 0
  br i1 %t8, label %whileBody298, label %common.ret

if301:                                            ; preds = %sub_1
  %t268 = icmp slt i32 %t4.0.in19, %t2
  br i1 %t268, label %whileBody303, label %common.ret

whileBody303:                                     ; preds = %if301, %whileBody303
  %t36610 = phi i32 [ %t36, %whileBody303 ], [ %t4.0.in19, %if301 ]
  %t3479 = phi ptr [ %t34, %whileBody303 ], [ @.str_stdlib_stdlib_0, %if301 ]
  %5 = sext i32 %t36610 to i64
  %t30 = getelementptr i8, ptr %t0, i64 %5
  %t31 = load i8, ptr %t30, align 1
  %t32 = tail call ptr @_zen_char_to_string(i8 %t31)
  %t34 = tail call ptr @_str_concat(ptr %t3479, ptr %t32)
  %t36 = add nsw i32 %t36610, 1
  %t26 = icmp slt i32 %t36, %t2
  br i1 %t26, label %whileBody303, label %common.ret

common.ret:                                       ; preds = %whileCond297.backedge, %whileBody303, %entry, %if301
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %if301 ], [ @.str_stdlib_stdlib_0, %entry ], [ %t34, %whileBody303 ], [ @.str_stdlib_stdlib_0, %whileCond297.backedge ]
  ret ptr %common.ret.op
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
  %t18 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t20 = fmul double %x.addr.1.lcssa, %t18
  %t21 = fdiv double %t20, 6.000000e+00
  %t22 = fsub double %x.addr.1.lcssa, %t21
  ret double %t22
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
  %t17 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t18 = fmul double %t17, 5.000000e-01
  %t19 = fsub double 1.000000e+00, %t18
  ret double %t19
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
  %t18.i = fmul double %x.addr.1.lcssa.i, %x.addr.1.lcssa.i
  %t20.i = fmul double %x.addr.1.lcssa.i, %t18.i
  %t21.i = fdiv double %t20.i, 6.000000e+00
  %t22.i = fsub double %x.addr.1.lcssa.i, %t21.i
  %t17.i = fmul double %x.addr.1.lcssa.i6, %x.addr.1.lcssa.i6
  %t18.i7 = fmul double %t17.i, 5.000000e-01
  %t19.i = fsub double 1.000000e+00, %t18.i7
  %t9 = fdiv double %t22.i, %t19.i
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
  %t14 = fadd double %t0, 1.000000e+00
  %t8.1 = fmul double %t0, %t0
  %t11.1 = fmul double %t8.1, 5.000000e-01
  %t14.1 = fadd double %t14, %t11.1
  %t8.2 = fmul double %t0, %t11.1
  %t11.2 = fdiv double %t8.2, 3.000000e+00
  %t14.2 = fadd double %t14.1, %t11.2
  %t8.3 = fmul double %t0, %t11.2
  %t11.3 = fmul double %t8.3, 2.500000e-01
  %t14.3 = fadd double %t14.2, %t11.3
  %t8.4 = fmul double %t0, %t11.3
  %t11.4 = fdiv double %t8.4, 5.000000e+00
  %t14.4 = fadd double %t14.3, %t11.4
  %t8.5 = fmul double %t0, %t11.4
  %t11.5 = fdiv double %t8.5, 6.000000e+00
  %t14.5 = fadd double %t14.4, %t11.5
  %t8.6 = fmul double %t0, %t11.5
  %t11.6 = fdiv double %t8.6, 7.000000e+00
  %t14.6 = fadd double %t14.5, %t11.6
  %t8.7 = fmul double %t0, %t11.6
  %t11.7 = fmul double %t8.7, 1.250000e-01
  %t14.7 = fadd double %t14.6, %t11.7
  %t8.8 = fmul double %t0, %t11.7
  %t11.8 = fdiv double %t8.8, 9.000000e+00
  %t14.8 = fadd double %t14.7, %t11.8
  ret double %t14.8
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none)
define i32 @randomInt(i32 %t0, i32 %t1) local_unnamed_addr #3 {
entry:
  %t0.i = load i32, ptr @SEED, align 4
  %t3.i = load i32, ptr @I32_MAX, align 4
  %t1.i = mul i32 %t0.i, 1103515245
  %t2.i = add i32 %t1.i, 12345
  %t4.i = srem i32 %t2.i, %t3.i
  %t6.i = icmp slt i32 %t4.i, 0
  %t9.i = select i1 %t6.i, i32 %t3.i, i32 0
  %spec.select.i = add i32 %t9.i, %t4.i
  store i32 %spec.select.i, ptr @SEED, align 4
  %t11.i = sitofp i32 %spec.select.i to double
  %t12.i = fdiv double %t11.i, 0x41DFFFFFFFC00000
  %reass.sub = sub i32 %t1, %t0
  %t9 = add i32 %reass.sub, 1
  %t10 = sitofp i32 %t9 to double
  %t11 = fmul double %t12.i, %t10
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
  %t6 = icmp slt i32 %t4, 0
  %t9 = select i1 %t6, i32 %t3, i32 0
  %spec.select = add i32 %t4, %t9
  store i32 %spec.select, ptr @SEED, align 4
  %t11 = sitofp i32 %spec.select to double
  %t12 = fdiv double %t11, 0x41DFFFFFFFC00000
  ret double %t12
}

define i1 @match(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  br label %tailrecurse

tailrecurse:                                      ; preds = %whileEnd329, %entry
  %t1.tr = phi ptr [ %t1, %entry ], [ %storemerge5321.lcssa, %whileEnd329 ]
  %t4 = tail call i1 @contains(ptr %t1.tr, ptr nonnull @.str_stdlib_stdlib_9)
  %t10323 = tail call i32 @strlen(ptr %t1.tr)
  %t11324 = icmp sgt i32 %t10323, 0
  br i1 %t4, label %if326, label %end325

if326:                                            ; preds = %tailrecurse
  br i1 %t11324, label %whileBody328, label %whileEnd329

whileBody328:                                     ; preds = %if326, %end330
  %storemerge4326 = phi i32 [ %t29, %end330 ], [ 0, %if326 ]
  %storemerge5321325 = phi ptr [ %storemerge5, %end330 ], [ @.str_stdlib_stdlib_0, %if326 ]
  %t3.i = tail call i32 @strlen(ptr %t1.tr)
  %t10.i.not = icmp slt i32 %storemerge4326, %t3.i
  br i1 %t10.i.not, label %end116.i, label %sub_0

end116.i:                                         ; preds = %whileBody328
  %0 = zext nneg i32 %storemerge4326 to i64
  %t14.i = getelementptr i8, ptr %t1.tr, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %whileBody328
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody328 ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not350 = icmp eq i8 %1, 124
  br i1 %.not350, label %charAt.exit.tail, label %else332

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %if331, label %else332

if331:                                            ; preds = %charAt.exit.tail
  %t23 = tail call i1 @match(ptr %t0, ptr %storemerge5321325)
  br i1 %t23, label %common.ret, label %end330

common.ret:                                       ; preds = %sub_0227, %charAt.exit84.tail, %charAt.exit178, %rhs471, %else469, %charAt.exit54.tail, %charAt.exit198, %end455, %slice.exit141, %rhs379.tail, %if375, %charAt.exit74, %if369, %charAt.exit64, %if363, %rhs358.tail, %if354, %if339, %whileCond475.backedge, %slice.exit34, %whileCond346, %if331, %sub_0251, %whileCond402.preheader, %end344, %rhs417.tail, %if413, %whileEnd404, %end395, %if343, %whileEnd337, %if454, %whileEnd432, %end410
  %common.ret.op = phi i1 [ %t285, %end410 ], [ %t386, %whileEnd432 ], [ %t395, %if454 ], [ %t506, %whileEnd337 ], [ true, %if343 ], [ false, %end395 ], [ false, %whileEnd404 ], [ false, %if413 ], [ false, %rhs417.tail ], [ false, %end344 ], [ false, %whileCond402.preheader ], [ false, %sub_0251 ], [ true, %if331 ], [ %t87, %whileCond346 ], [ %t87, %slice.exit34 ], [ false, %whileCond475.backedge ], [ false, %if339 ], [ false, %if354 ], [ false, %rhs358.tail ], [ false, %if363 ], [ false, %charAt.exit64 ], [ false, %if369 ], [ false, %charAt.exit74 ], [ false, %if375 ], [ false, %rhs379.tail ], [ false, %slice.exit141 ], [ false, %end455 ], [ false, %charAt.exit198 ], [ false, %charAt.exit54.tail ], [ false, %else469 ], [ false, %rhs471 ], [ false, %charAt.exit178 ], [ false, %charAt.exit84.tail ], [ false, %sub_0227 ]
  ret i1 %common.ret.op

else332:                                          ; preds = %sub_0, %charAt.exit.tail
  %t27 = tail call ptr @_str_concat(ptr %storemerge5321325, ptr nonnull %common.ret.op.i)
  br label %end330

end330:                                           ; preds = %if331, %else332
  %storemerge5 = phi ptr [ %t27, %else332 ], [ @.str_stdlib_stdlib_0, %if331 ]
  %t29 = add nuw nsw i32 %storemerge4326, 1
  %t10 = tail call i32 @strlen(ptr %t1.tr)
  %t11 = icmp slt i32 %t29, %t10
  br i1 %t11, label %whileBody328, label %whileEnd329

whileEnd329:                                      ; preds = %end330, %if326
  %storemerge5321.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %if326 ], [ %storemerge5, %end330 ]
  br label %tailrecurse

end325:                                           ; preds = %tailrecurse
  br i1 %t11324, label %whileBody336, label %whileEnd337

whileBody336:                                     ; preds = %end325, %whileCond335.backedge
  %storemerge1.in.peel = phi i32 [ %t502287, %whileCond335.backedge ], [ 0, %end325 ]
  %t67 = phi i32 [ %t500289, %whileCond335.backedge ], [ 0, %end325 ]
  %t3.i6 = tail call i32 @strlen(ptr %t1.tr)
  %t7.i7 = icmp slt i32 %storemerge1.in.peel, 0
  %t10.i8 = icmp sge i32 %storemerge1.in.peel, %t3.i6
  %t5.i9 = select i1 %t7.i7, i1 true, i1 %t10.i8
  br i1 %t5.i9, label %sub_0200, label %end116.i10

end116.i10:                                       ; preds = %whileBody336
  %5 = zext nneg i32 %storemerge1.in.peel to i64
  %t14.i11 = getelementptr i8, ptr %t1.tr, i64 %5
  %t15.i12 = load i8, ptr %t14.i11, align 1
  %t16.i13 = tail call ptr @_zen_char_to_string(i8 %t15.i12)
  br label %sub_0200

sub_0200:                                         ; preds = %end116.i10, %whileBody336
  %common.ret.op.i14 = phi ptr [ %t16.i13, %end116.i10 ], [ @.str_stdlib_stdlib_0, %whileBody336 ]
  %6 = load i8, ptr %common.ret.op.i14, align 1
  switch i8 %6, label %sub_0233 [
    i8 63, label %charAt.exit15.tail
    i8 42, label %end338.tail
    i8 35, label %end342.tail
  ]

charAt.exit15.tail:                               ; preds = %sub_0200
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %if339, label %end455

if339:                                            ; preds = %charAt.exit15.tail
  %t50 = tail call i32 @strlen(ptr %t0)
  %t51.not = icmp slt i32 %t67, %t50
  br i1 %t51.not, label %end340, label %common.ret

end340:                                           ; preds = %if339
  %t55 = add nsw i32 %storemerge1.in.peel, 1
  br label %whileCond335.backedge

whileCond335.backedge:                            ; preds = %end340, %end357, %end366, %end372, %end378, %end482, %end486
  %t502287 = phi i32 [ %t55, %end340 ], [ %t127, %end357 ], [ %t148, %end366 ], [ %t169, %end372 ], [ %t197, %end378 ], [ %t487, %end482 ], [ %t502, %end486 ]
  %t500289 = add i32 %t67, 1
  %t37 = tail call i32 @strlen(ptr %t1.tr)
  %t38 = icmp slt i32 %t502287, %t37
  br i1 %t38, label %whileBody336, label %whileEnd337

end338.tail:                                      ; preds = %sub_0200
  %10 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %11 = load i8, ptr %10, align 1
  %12 = icmp eq i8 %11, 0
  br i1 %12, label %if343, label %end455

if343:                                            ; preds = %end338.tail
  %t64 = tail call i32 @strlen(ptr %t1.tr)
  %t62 = add nsw i32 %storemerge1.in.peel, 1
  %t65.not = icmp slt i32 %t62, %t64
  br i1 %t65.not, label %end344, label %common.ret

end344:                                           ; preds = %if343
  %t70316 = tail call i32 @strlen(ptr %t0)
  %t71.not317 = icmp sgt i32 %t67, %t70316
  br i1 %t71.not317, label %common.ret, label %whileBody347.lr.ph

whileBody347.lr.ph:                               ; preds = %end344
  %spec.store.select.i19 = tail call i32 @llvm.smax.i32(i32 %t62, i32 0)
  br label %whileBody347

whileCond346:                                     ; preds = %slice.exit34
  %t89 = add i32 %storemerge3318, 1
  %t70 = tail call i32 @strlen(ptr %t0)
  %t71.not = icmp sgt i32 %t89, %t70
  br i1 %t71.not, label %common.ret, label %whileBody347

whileBody347:                                     ; preds = %whileBody347.lr.ph, %whileCond346
  %storemerge3318 = phi i32 [ %t67, %whileBody347.lr.ph ], [ %t89, %whileCond346 ]
  %t75 = tail call i32 @strlen(ptr %t0)
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %storemerge3318, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t75, i32 %t4.i)
  %t14.i16 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t227.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t14.i16, i1 %t227.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileBody347, %whileBody114.i
  %storemerge9.i = phi i32 [ %t32.i, %whileBody114.i ], [ %spec.store.select.i, %whileBody347 ]
  %t3068.i = phi ptr [ %t30.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileBody347 ]
  %13 = zext nneg i32 %storemerge9.i to i64
  %t26.i = getelementptr i8, ptr %t0, i64 %13
  %t27.i = load i8, ptr %t26.i, align 1
  %t28.i = tail call ptr @_zen_char_to_string(i8 %t27.i)
  %t30.i = tail call ptr @_str_concat(ptr %t3068.i, ptr %t28.i)
  %t32.i = add nuw nsw i32 %storemerge9.i, 1
  %t22.i = icmp slt i32 %t32.i, %spec.select.i
  br i1 %t22.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileBody347
  %common.ret.op.i17 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody347 ], [ %t30.i, %whileBody114.i ]
  %t82 = tail call i32 @strlen(ptr %t1.tr)
  %t4.i18 = tail call i32 @strlen(ptr %t1.tr)
  %spec.select.i20 = tail call i32 @llvm.smin.i32(i32 %t82, i32 %t4.i18)
  %t14.i21 = icmp sle i32 %spec.store.select.i19, %spec.select.i20
  %t227.i22 = icmp samesign ult i32 %spec.store.select.i19, %spec.select.i20
  %or.cond.i23 = select i1 %t14.i21, i1 %t227.i22, i1 false
  br i1 %or.cond.i23, label %whileBody114.i25, label %slice.exit34

whileBody114.i25:                                 ; preds = %slice.exit, %whileBody114.i25
  %storemerge9.i26 = phi i32 [ %t32.i32, %whileBody114.i25 ], [ %spec.store.select.i19, %slice.exit ]
  %t3068.i27 = phi ptr [ %t30.i31, %whileBody114.i25 ], [ @.str_stdlib_stdlib_0, %slice.exit ]
  %14 = zext nneg i32 %storemerge9.i26 to i64
  %t26.i28 = getelementptr i8, ptr %t1.tr, i64 %14
  %t27.i29 = load i8, ptr %t26.i28, align 1
  %t28.i30 = tail call ptr @_zen_char_to_string(i8 %t27.i29)
  %t30.i31 = tail call ptr @_str_concat(ptr %t3068.i27, ptr %t28.i30)
  %t32.i32 = add nuw nsw i32 %storemerge9.i26, 1
  %t22.i33 = icmp slt i32 %t32.i32, %spec.select.i20
  br i1 %t22.i33, label %whileBody114.i25, label %slice.exit34

slice.exit34:                                     ; preds = %whileBody114.i25, %slice.exit
  %common.ret.op.i24 = phi ptr [ @.str_stdlib_stdlib_0, %slice.exit ], [ %t30.i31, %whileBody114.i25 ]
  %t87 = tail call i1 @match(ptr %common.ret.op.i17, ptr %common.ret.op.i24)
  br i1 %t87, label %common.ret, label %whileCond346

end342.tail:                                      ; preds = %sub_0200
  %15 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %16 = load i8, ptr %15, align 1
  %17 = icmp eq i8 %16, 0
  br i1 %17, label %if352, label %end455

if352:                                            ; preds = %end342.tail
  %t97 = add nsw i32 %storemerge1.in.peel, 1
  %t3.i35 = tail call i32 @strlen(ptr %t1.tr)
  %t7.i36 = icmp slt i32 %storemerge1.in.peel, -1
  %t10.i37 = icmp sge i32 %t97, %t3.i35
  %t5.i38 = select i1 %t7.i36, i1 true, i1 %t10.i37
  br i1 %t5.i38, label %sub_0209, label %end116.i39

end116.i39:                                       ; preds = %if352
  %18 = zext nneg i32 %t97 to i64
  %t14.i40 = getelementptr i8, ptr %t1.tr, i64 %18
  %t15.i41 = load i8, ptr %t14.i40, align 1
  %t16.i42 = tail call ptr @_zen_char_to_string(i8 %t15.i41)
  br label %sub_0209

sub_0209:                                         ; preds = %end116.i39, %if352
  %common.ret.op.i43 = phi ptr [ %t16.i42, %end116.i39 ], [ @.str_stdlib_stdlib_0, %if352 ]
  %19 = load i8, ptr %common.ret.op.i43, align 1
  switch i8 %19, label %end368.tail.sub_0233_crit_edge [
    i8 100, label %charAt.exit44.tail
    i8 97, label %end353.tail
    i8 120, label %end362.tail
    i8 115, label %end368.tail
  ]

charAt.exit44.tail:                               ; preds = %sub_0209
  %20 = getelementptr inbounds nuw i8, ptr %common.ret.op.i43, i64 1
  %21 = load i8, ptr %20, align 1
  %22 = icmp eq i8 %21, 0
  br i1 %22, label %if354, label %end368.tail.sub_0233_crit_edge

if354:                                            ; preds = %charAt.exit44.tail
  %t107 = tail call i32 @strlen(ptr %t0)
  %t108.not = icmp slt i32 %t67, %t107
  br i1 %t108.not, label %end355, label %common.ret

end355:                                           ; preds = %if354
  %t3.i45 = tail call i32 @strlen(ptr %t0)
  %t7.i46 = icmp slt i32 %t67, 0
  %t10.i47 = icmp sge i32 %t67, %t3.i45
  %t5.i48 = select i1 %t7.i46, i1 true, i1 %t10.i47
  br i1 %t5.i48, label %sub_0212, label %end116.i49

end116.i49:                                       ; preds = %end355
  %23 = zext nneg i32 %t67 to i64
  %t14.i50 = getelementptr i8, ptr %t0, i64 %23
  %t15.i51 = load i8, ptr %t14.i50, align 1
  %t16.i52 = tail call ptr @_zen_char_to_string(i8 %t15.i51)
  br label %sub_0212

sub_0212:                                         ; preds = %end116.i49, %end355
  %common.ret.op.i53 = phi ptr [ %t16.i52, %end116.i49 ], [ @.str_stdlib_stdlib_0, %end355 ]
  %24 = load i8, ptr %common.ret.op.i53, align 1
  %25 = zext i8 %24 to i32
  %.not348 = icmp eq i8 %24, 48
  br i1 %.not348, label %end357, label %charAt.exit54.tail

charAt.exit54.tail:                               ; preds = %sub_0212
  %t118 = icmp ult i8 %24, 48
  br i1 %t118, label %common.ret, label %sub_0215

sub_0215:                                         ; preds = %charAt.exit54.tail
  %26 = add nsw i32 %25, -57
  %.not349 = icmp eq i32 %26, 0
  br i1 %.not349, label %sub_1216, label %rhs358.tail

sub_1216:                                         ; preds = %sub_0215
  %27 = getelementptr inbounds nuw i8, ptr %common.ret.op.i53, i64 1
  %28 = load i8, ptr %27, align 1
  %29 = zext i8 %28 to i32
  br label %rhs358.tail

rhs358.tail:                                      ; preds = %sub_0215, %sub_1216
  %30 = phi i32 [ %26, %sub_0215 ], [ %29, %sub_1216 ]
  %t123 = icmp sgt i32 %30, 0
  br i1 %t123, label %common.ret, label %end357

end357:                                           ; preds = %sub_0212, %rhs358.tail
  %t127 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

end353.tail:                                      ; preds = %sub_0209
  %31 = getelementptr inbounds nuw i8, ptr %common.ret.op.i43, i64 1
  %32 = load i8, ptr %31, align 1
  %33 = icmp eq i8 %32, 0
  br i1 %33, label %if363, label %end368.tail.sub_0233_crit_edge

if363:                                            ; preds = %end353.tail
  %t135 = tail call i32 @strlen(ptr %t0)
  %t136.not = icmp slt i32 %t67, %t135
  br i1 %t136.not, label %end364, label %common.ret

end364:                                           ; preds = %if363
  %t3.i55 = tail call i32 @strlen(ptr %t0)
  %t7.i56 = icmp slt i32 %t67, 0
  %t10.i57 = icmp sge i32 %t67, %t3.i55
  %t5.i58 = select i1 %t7.i56, i1 true, i1 %t10.i57
  br i1 %t5.i58, label %charAt.exit64, label %end116.i59

end116.i59:                                       ; preds = %end364
  %34 = zext nneg i32 %t67 to i64
  %t14.i60 = getelementptr i8, ptr %t0, i64 %34
  %t15.i61 = load i8, ptr %t14.i60, align 1
  %t16.i62 = tail call ptr @_zen_char_to_string(i8 %t15.i61)
  br label %charAt.exit64

charAt.exit64:                                    ; preds = %end364, %end116.i59
  %common.ret.op.i63 = phi ptr [ %t16.i62, %end116.i59 ], [ @.str_stdlib_stdlib_0, %end364 ]
  %t143 = tail call i1 @contains(ptr nonnull @.str_stdlib_stdlib_16, ptr %common.ret.op.i63)
  br i1 %t143, label %end366, label %common.ret

end366:                                           ; preds = %charAt.exit64
  %t148 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

end362.tail:                                      ; preds = %sub_0209
  %35 = getelementptr inbounds nuw i8, ptr %common.ret.op.i43, i64 1
  %36 = load i8, ptr %35, align 1
  %37 = icmp eq i8 %36, 0
  br i1 %37, label %if369, label %end368.tail.sub_0233_crit_edge

if369:                                            ; preds = %end362.tail
  %t156 = tail call i32 @strlen(ptr %t0)
  %t157.not = icmp slt i32 %t67, %t156
  br i1 %t157.not, label %end370, label %common.ret

end370:                                           ; preds = %if369
  %t3.i65 = tail call i32 @strlen(ptr %t0)
  %t7.i66 = icmp slt i32 %t67, 0
  %t10.i67 = icmp sge i32 %t67, %t3.i65
  %t5.i68 = select i1 %t7.i66, i1 true, i1 %t10.i67
  br i1 %t5.i68, label %charAt.exit74, label %end116.i69

end116.i69:                                       ; preds = %end370
  %38 = zext nneg i32 %t67 to i64
  %t14.i70 = getelementptr i8, ptr %t0, i64 %38
  %t15.i71 = load i8, ptr %t14.i70, align 1
  %t16.i72 = tail call ptr @_zen_char_to_string(i8 %t15.i71)
  br label %charAt.exit74

charAt.exit74:                                    ; preds = %end370, %end116.i69
  %common.ret.op.i73 = phi ptr [ %t16.i72, %end116.i69 ], [ @.str_stdlib_stdlib_0, %end370 ]
  %t164 = tail call i1 @contains(ptr nonnull @.str_stdlib_stdlib_18, ptr %common.ret.op.i73)
  br i1 %t164, label %end372, label %common.ret

end372:                                           ; preds = %charAt.exit74
  %t169 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

end368.tail:                                      ; preds = %sub_0209
  %39 = getelementptr inbounds nuw i8, ptr %common.ret.op.i43, i64 1
  %40 = load i8, ptr %39, align 1
  %41 = icmp eq i8 %40, 0
  br i1 %41, label %if375, label %end368.tail.sub_0233_crit_edge

end368.tail.sub_0233_crit_edge:                   ; preds = %sub_0209, %end353.tail, %charAt.exit44.tail, %end362.tail, %end368.tail
  %.pre = load i8, ptr %common.ret.op.i14, align 1
  br label %sub_0233

if375:                                            ; preds = %end368.tail
  %t177 = tail call i32 @strlen(ptr %t0)
  %t178.not = icmp slt i32 %t67, %t177
  br i1 %t178.not, label %end376, label %common.ret

end376:                                           ; preds = %if375
  %t3.i75 = tail call i32 @strlen(ptr %t0)
  %t7.i76 = icmp slt i32 %t67, 0
  %t10.i77 = icmp sge i32 %t67, %t3.i75
  %t5.i78 = select i1 %t7.i76, i1 true, i1 %t10.i77
  br i1 %t5.i78, label %sub_0227, label %end116.i79

end116.i79:                                       ; preds = %end376
  %42 = zext nneg i32 %t67 to i64
  %t14.i80 = getelementptr i8, ptr %t0, i64 %42
  %t15.i81 = load i8, ptr %t14.i80, align 1
  %t16.i82 = tail call ptr @_zen_char_to_string(i8 %t15.i81)
  br label %sub_0227

sub_0227:                                         ; preds = %end116.i79, %end376
  %common.ret.op.i83 = phi ptr [ %t16.i82, %end116.i79 ], [ @.str_stdlib_stdlib_0, %end376 ]
  %43 = load i8, ptr %common.ret.op.i83, align 1
  switch i8 %43, label %common.ret [
    i8 32, label %charAt.exit84.tail
    i8 9, label %rhs379.tail
  ]

charAt.exit84.tail:                               ; preds = %sub_0227
  %44 = getelementptr inbounds nuw i8, ptr %common.ret.op.i83, i64 1
  %45 = load i8, ptr %44, align 1
  %46 = icmp eq i8 %45, 0
  br i1 %46, label %end378, label %common.ret

rhs379.tail:                                      ; preds = %sub_0227
  %47 = getelementptr inbounds nuw i8, ptr %common.ret.op.i83, i64 1
  %48 = load i8, ptr %47, align 1
  %49 = icmp eq i8 %48, 0
  br i1 %49, label %end378, label %common.ret

end378:                                           ; preds = %charAt.exit84.tail, %rhs379.tail
  %t197 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

sub_0233:                                         ; preds = %sub_0200, %end368.tail.sub_0233_crit_edge
  %50 = phi i8 [ %.pre, %end368.tail.sub_0233_crit_edge ], [ %6, %sub_0200 ]
  %.not334 = icmp eq i8 %50, 58
  br i1 %.not334, label %end351.tail, label %sub_0257

end351.tail:                                      ; preds = %sub_0233
  %51 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %52 = load i8, ptr %51, align 1
  %53 = icmp eq i8 %52, 0
  br i1 %53, label %if384, label %end455

if384:                                            ; preds = %end351.tail
  %t209277 = tail call i32 @strlen(ptr %t1.tr)
  %t210278 = icmp slt i32 %storemerge1.in.peel, %t209277
  br i1 %t210278, label %whileBody386, label %whileEnd387

whileBody386:                                     ; preds = %if384, %end388
  %storemerge280 = phi i32 [ %t230, %end388 ], [ %storemerge1.in.peel, %if384 ]
  %t228276279 = phi ptr [ %t228, %end388 ], [ @.str_stdlib_stdlib_0, %if384 ]
  %t3.i85 = tail call i32 @strlen(ptr %t1.tr)
  %t7.i86 = icmp slt i32 %storemerge280, 0
  %t10.i87 = icmp sge i32 %storemerge280, %t3.i85
  %t5.i88 = select i1 %t7.i86, i1 true, i1 %t10.i87
  br i1 %t5.i88, label %sub_0236, label %end116.i89

end116.i89:                                       ; preds = %whileBody386
  %54 = zext nneg i32 %storemerge280 to i64
  %t14.i90 = getelementptr i8, ptr %t1.tr, i64 %54
  %t15.i91 = load i8, ptr %t14.i90, align 1
  %t16.i92 = tail call ptr @_zen_char_to_string(i8 %t15.i91)
  br label %sub_0236

sub_0236:                                         ; preds = %end116.i89, %whileBody386
  %common.ret.op.i93 = phi ptr [ %t16.i92, %end116.i89 ], [ @.str_stdlib_stdlib_0, %whileBody386 ]
  %55 = load i8, ptr %common.ret.op.i93, align 1
  switch i8 %55, label %end388 [
    i8 32, label %charAt.exit94.tail
    i8 124, label %rhs389.tail
  ]

charAt.exit94.tail:                               ; preds = %sub_0236
  %56 = getelementptr inbounds nuw i8, ptr %common.ret.op.i93, i64 1
  %57 = load i8, ptr %56, align 1
  %58 = icmp eq i8 %57, 0
  br i1 %58, label %whileEnd387, label %end388

rhs389.tail:                                      ; preds = %sub_0236
  %59 = getelementptr inbounds nuw i8, ptr %common.ret.op.i93, i64 1
  %60 = load i8, ptr %59, align 1
  %61 = icmp eq i8 %60, 0
  br i1 %61, label %whileEnd387, label %end388

end388:                                           ; preds = %sub_0236, %charAt.exit94.tail, %rhs389.tail
  %t228 = tail call ptr @_str_concat(ptr %t228276279, ptr nonnull %common.ret.op.i93)
  %t230 = add nsw i32 %storemerge280, 1
  %t209 = tail call i32 @strlen(ptr %t1.tr)
  %t210 = icmp slt i32 %t230, %t209
  br i1 %t210, label %whileBody386, label %whileEnd387

whileEnd387:                                      ; preds = %end388, %rhs389.tail, %charAt.exit94.tail, %if384
  %t228276.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %if384 ], [ %t228276279, %charAt.exit94.tail ], [ %t228276279, %rhs389.tail ], [ %t228, %end388 ]
  %t234 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t228276.lcssa, ptr noundef nonnull dereferenceable(5) @.str_stdlib_stdlib_21)
  %t235 = icmp eq i32 %t234, 0
  br i1 %t235, label %if394, label %end393

if394:                                            ; preds = %whileEnd387
  %t241 = tail call i32 @strlen(ptr %t0)
  %t242 = icmp slt i32 %t67, %t241
  br i1 %t242, label %rhs396, label %end395

rhs396:                                           ; preds = %if394
  %t245 = tail call ptr @charAt(ptr %t0, i32 %t67)
  %62 = load i8, ptr %t245, align 1
  %.not343 = icmp eq i8 %62, 45
  br i1 %.not343, label %rhs396.tail, label %end395

rhs396.tail:                                      ; preds = %rhs396
  %63 = getelementptr inbounds nuw i8, ptr %t245, i64 1
  %64 = load i8, ptr %63, align 1
  %65 = icmp eq i8 %64, 0
  %t251 = zext i1 %65 to i32
  %spec.select = add nsw i32 %t67, %t251
  br label %end395

end395:                                           ; preds = %rhs396.tail, %rhs396, %if394
  %t33.promoted305 = phi i32 [ %t67, %if394 ], [ %t67, %rhs396 ], [ %spec.select, %rhs396.tail ]
  %t254 = tail call i32 @strlen(ptr %t0)
  %t255.not = icmp slt i32 %t33.promoted305, %t254
  br i1 %t255.not, label %whileCond402.preheader, label %common.ret

whileCond402.preheader:                           ; preds = %end395
  %t260307 = tail call i32 @strlen(ptr %t0)
  %t261308 = icmp slt i32 %t33.promoted305, %t260307
  br i1 %t261308, label %whileBody403, label %common.ret

whileBody403:                                     ; preds = %whileCond402.preheader, %end405
  %t278306309 = phi i32 [ %t278, %end405 ], [ %t33.promoted305, %whileCond402.preheader ]
  %t3.i95 = tail call i32 @strlen(ptr %t0)
  %t7.i96 = icmp slt i32 %t278306309, 0
  %t10.i97 = icmp sge i32 %t278306309, %t3.i95
  %t5.i98 = select i1 %t7.i96, i1 true, i1 %t10.i97
  br i1 %t5.i98, label %sub_0245, label %end116.i99

end116.i99:                                       ; preds = %whileBody403
  %66 = zext nneg i32 %t278306309 to i64
  %t14.i100 = getelementptr i8, ptr %t0, i64 %66
  %t15.i101 = load i8, ptr %t14.i100, align 1
  %t16.i102 = tail call ptr @_zen_char_to_string(i8 %t15.i101)
  br label %sub_0245

sub_0245:                                         ; preds = %end116.i99, %whileBody403
  %common.ret.op.i103 = phi ptr [ %t16.i102, %end116.i99 ], [ @.str_stdlib_stdlib_0, %whileBody403 ]
  %67 = load i8, ptr %common.ret.op.i103, align 1
  %68 = zext i8 %67 to i32
  %.not344 = icmp eq i8 %67, 48
  br i1 %.not344, label %end405, label %charAt.exit104.tail

charAt.exit104.tail:                              ; preds = %sub_0245
  %t271 = icmp ult i8 %67, 48
  br i1 %t271, label %whileEnd404, label %sub_0248

sub_0248:                                         ; preds = %charAt.exit104.tail
  %69 = add nsw i32 %68, -57
  %.not345 = icmp eq i32 %69, 0
  br i1 %.not345, label %sub_1249, label %rhs406.tail

sub_1249:                                         ; preds = %sub_0248
  %70 = getelementptr inbounds nuw i8, ptr %common.ret.op.i103, i64 1
  %71 = load i8, ptr %70, align 1
  %72 = zext i8 %71 to i32
  br label %rhs406.tail

rhs406.tail:                                      ; preds = %sub_0248, %sub_1249
  %73 = phi i32 [ %69, %sub_0248 ], [ %72, %sub_1249 ]
  %t276 = icmp sgt i32 %73, 0
  br i1 %t276, label %whileEnd404, label %end405

end405:                                           ; preds = %sub_0245, %rhs406.tail
  %t278 = add nsw i32 %t278306309, 1
  %t260 = tail call i32 @strlen(ptr %t0)
  %t261 = icmp slt i32 %t278, %t260
  br i1 %t261, label %whileBody403, label %whileEnd404

whileEnd404:                                      ; preds = %end405, %rhs406.tail, %charAt.exit104.tail
  %t278306.lcssa = phi i32 [ %t278, %end405 ], [ %t278306309, %rhs406.tail ], [ %t278306309, %charAt.exit104.tail ]
  %t281.not = icmp sgt i32 %t278306.lcssa, %t33.promoted305
  br i1 %t281.not, label %end410, label %common.ret

end410:                                           ; preds = %whileEnd404
  %t284 = tail call i32 @strlen(ptr %t0)
  %t285 = icmp eq i32 %t278306.lcssa, %t284
  br label %common.ret

end393:                                           ; preds = %whileEnd387
  %t289 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t228276.lcssa, ptr noundef nonnull dereferenceable(4) @.str_stdlib_stdlib_23)
  %t290 = icmp eq i32 %t289, 0
  br i1 %t290, label %if413, label %end412

if413:                                            ; preds = %end393
  %t293 = tail call i32 @strlen(ptr %t0)
  %t294.not = icmp slt i32 %t67, %t293
  br i1 %t294.not, label %end414, label %common.ret

end414:                                           ; preds = %if413
  %t297 = tail call ptr @charAt(ptr %t0, i32 %t67)
  %t305 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t297, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_1)
  %t306 = icmp sgt i32 %t305, -1
  br i1 %t306, label %rhs423, label %rhs420

rhs423:                                           ; preds = %end414
  %t310 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t297, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_2)
  %t311 = icmp slt i32 %t310, 1
  br i1 %t311, label %end416, label %rhs420

rhs420:                                           ; preds = %end414, %rhs423
  %t316 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t297, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_3)
  %t317 = icmp sgt i32 %t316, -1
  br i1 %t317, label %rhs426, label %sub_0251

rhs426:                                           ; preds = %rhs420
  %t321 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t297, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_4)
  %t322 = icmp slt i32 %t321, 1
  br i1 %t322, label %end416, label %sub_0251

sub_0251:                                         ; preds = %rhs426, %rhs420
  %74 = load i8, ptr %t297, align 1
  %.not341 = icmp eq i8 %74, 95
  br i1 %.not341, label %rhs417.tail, label %common.ret

rhs417.tail:                                      ; preds = %sub_0251
  %75 = getelementptr inbounds nuw i8, ptr %t297, i64 1
  %76 = load i8, ptr %75, align 1
  %77 = icmp eq i8 %76, 0
  br i1 %77, label %end416, label %common.ret

end416:                                           ; preds = %rhs423, %rhs426, %rhs417.tail
  %storemerge2297 = add nsw i32 %t67, 1
  %t333298 = tail call i32 @strlen(ptr %t0)
  %t334299 = icmp slt i32 %storemerge2297, %t333298
  br i1 %t334299, label %whileBody431, label %whileEnd432

whileBody431:                                     ; preds = %end416, %end433
  %storemerge2300 = phi i32 [ %storemerge2, %end433 ], [ %storemerge2297, %end416 ]
  %t3.i105 = tail call i32 @strlen(ptr %t0)
  %t7.i106 = icmp slt i32 %storemerge2300, 0
  %t10.i107 = icmp sge i32 %storemerge2300, %t3.i105
  %t5.i108 = select i1 %t7.i106, i1 true, i1 %t10.i107
  br i1 %t5.i108, label %charAt.exit114, label %end116.i109

end116.i109:                                      ; preds = %whileBody431
  %78 = zext nneg i32 %storemerge2300 to i64
  %t14.i110 = getelementptr i8, ptr %t0, i64 %78
  %t15.i111 = load i8, ptr %t14.i110, align 1
  %t16.i112 = tail call ptr @_zen_char_to_string(i8 %t15.i111)
  br label %charAt.exit114

charAt.exit114:                                   ; preds = %whileBody431, %end116.i109
  %common.ret.op.i113 = phi ptr [ %t16.i112, %end116.i109 ], [ @.str_stdlib_stdlib_0, %whileBody431 ]
  %t346 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_1)
  %t347 = icmp sgt i32 %t346, -1
  br i1 %t347, label %rhs443, label %rhs440

rhs443:                                           ; preds = %charAt.exit114
  %t351 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_2)
  %t352 = icmp slt i32 %t351, 1
  br i1 %t352, label %end433, label %rhs440

rhs440:                                           ; preds = %charAt.exit114, %rhs443
  %t357 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_3)
  %t358 = icmp sgt i32 %t357, -1
  br i1 %t358, label %rhs446, label %rhs437

rhs446:                                           ; preds = %rhs440
  %t362 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_4)
  %t363 = icmp slt i32 %t362, 1
  br i1 %t363, label %end433, label %rhs437

rhs437:                                           ; preds = %rhs440, %rhs446
  %t368 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_14)
  %t369 = icmp sgt i32 %t368, -1
  br i1 %t369, label %rhs449, label %sub_0254

rhs449:                                           ; preds = %rhs437
  %t373 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i113, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_15)
  %t374 = icmp slt i32 %t373, 1
  br i1 %t374, label %end433, label %sub_0254

sub_0254:                                         ; preds = %rhs449, %rhs437
  %79 = load i8, ptr %common.ret.op.i113, align 1
  %.not342 = icmp eq i8 %79, 95
  br i1 %.not342, label %rhs434.tail, label %whileEnd432

rhs434.tail:                                      ; preds = %sub_0254
  %80 = getelementptr inbounds nuw i8, ptr %common.ret.op.i113, i64 1
  %81 = load i8, ptr %80, align 1
  %82 = icmp eq i8 %81, 0
  br i1 %82, label %end433, label %whileEnd432

end433:                                           ; preds = %rhs443, %rhs446, %rhs449, %rhs434.tail
  %storemerge2 = add nsw i32 %storemerge2300, 1
  %t333 = tail call i32 @strlen(ptr %t0)
  %t334 = icmp slt i32 %storemerge2, %t333
  br i1 %t334, label %whileBody431, label %whileEnd432

whileEnd432:                                      ; preds = %sub_0254, %end433, %rhs434.tail, %end416
  %storemerge2.lcssa296 = phi i32 [ %storemerge2297, %end416 ], [ %storemerge2300, %sub_0254 ], [ %storemerge2300, %rhs434.tail ], [ %storemerge2, %end433 ]
  %t385 = tail call i32 @strlen(ptr %t0)
  %t386 = icmp eq i32 %storemerge2.lcssa296, %t385
  br label %common.ret

end412:                                           ; preds = %end393
  %t390 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t228276.lcssa, ptr noundef nonnull dereferenceable(8) @.str_stdlib_stdlib_25)
  %t391 = icmp eq i32 %t390, 0
  br i1 %t391, label %if454, label %end412.sub_0257_crit_edge

end412.sub_0257_crit_edge:                        ; preds = %end412
  %.pre359 = load i8, ptr %common.ret.op.i14, align 1
  br label %sub_0257

if454:                                            ; preds = %end412
  %t394 = tail call i32 @strlen(ptr %t0)
  %t395 = icmp slt i32 %t67, %t394
  br label %common.ret

sub_0257:                                         ; preds = %sub_0233, %end412.sub_0257_crit_edge
  %83 = phi i8 [ %.pre359, %end412.sub_0257_crit_edge ], [ %50, %sub_0233 ]
  %.not337 = icmp eq i8 %83, 91
  br i1 %.not337, label %end383.tail, label %end455

end383.tail:                                      ; preds = %sub_0257
  %84 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %85 = load i8, ptr %84, align 1
  %86 = icmp eq i8 %85, 0
  br i1 %86, label %if456, label %end455

if456:                                            ; preds = %end383.tail
  %storemerge1.peel = add i32 %storemerge1.in.peel, 1
  %t406.peel = tail call i32 @strlen(ptr %t1.tr)
  %t407.peel = icmp slt i32 %storemerge1.peel, %t406.peel
  br i1 %t407.peel, label %whileBody458.peel, label %whileEnd459

whileBody458.peel:                                ; preds = %if456
  %t3.i115.peel = tail call i32 @strlen(ptr %t1.tr)
  %t7.i116.peel = icmp slt i32 %storemerge1.peel, 0
  %t10.i117.peel = icmp sge i32 %storemerge1.peel, %t3.i115.peel
  %t5.i118.peel = select i1 %t7.i116.peel, i1 true, i1 %t10.i117.peel
  br i1 %t5.i118.peel, label %sub_0260.peel, label %end116.i119.peel

end116.i119.peel:                                 ; preds = %whileBody458.peel
  %87 = zext nneg i32 %storemerge1.peel to i64
  %t14.i120.peel = getelementptr i8, ptr %t1.tr, i64 %87
  %t15.i121.peel = load i8, ptr %t14.i120.peel, align 1
  %t16.i122.peel = tail call ptr @_zen_char_to_string(i8 %t15.i121.peel)
  br label %sub_0260.peel

sub_0260.peel:                                    ; preds = %end116.i119.peel, %whileBody458.peel
  %common.ret.op.i123.peel = phi ptr [ %t16.i122.peel, %end116.i119.peel ], [ @.str_stdlib_stdlib_0, %whileBody458.peel ]
  %88 = load i8, ptr %common.ret.op.i123.peel, align 1
  %.not338.peel = icmp eq i8 %88, 93
  br i1 %.not338.peel, label %charAt.exit124.tail.peel, label %whileCond457.peel.next

charAt.exit124.tail.peel:                         ; preds = %sub_0260.peel
  %89 = getelementptr inbounds nuw i8, ptr %common.ret.op.i123.peel, i64 1
  %90 = load i8, ptr %89, align 1
  %91 = icmp eq i8 %90, 0
  br i1 %91, label %whileEnd459, label %whileCond457.peel.next

whileCond457.peel.next:                           ; preds = %sub_0260.peel, %charAt.exit124.tail.peel
  %storemerge1444 = add i32 %storemerge1.in.peel, 2
  %t406445 = tail call i32 @strlen(ptr %t1.tr)
  %t407446 = icmp slt i32 %storemerge1444, %t406445
  br i1 %t407446, label %whileBody458, label %whileEnd459

whileBody458:                                     ; preds = %whileCond457.peel.next, %whileCond457.backedge
  %storemerge1448 = phi i32 [ %storemerge1, %whileCond457.backedge ], [ %storemerge1444, %whileCond457.peel.next ]
  %storemerge1.in447 = phi i32 [ %storemerge1448, %whileCond457.backedge ], [ %storemerge1.peel, %whileCond457.peel.next ]
  %t3.i115 = tail call i32 @strlen(ptr %t1.tr)
  %t7.i116 = icmp slt i32 %storemerge1.in447, -1
  %t10.i117 = icmp sge i32 %storemerge1448, %t3.i115
  %t5.i118 = select i1 %t7.i116, i1 true, i1 %t10.i117
  br i1 %t5.i118, label %sub_0260, label %end116.i119

end116.i119:                                      ; preds = %whileBody458
  %92 = zext nneg i32 %storemerge1448 to i64
  %t14.i120 = getelementptr i8, ptr %t1.tr, i64 %92
  %t15.i121 = load i8, ptr %t14.i120, align 1
  %t16.i122 = tail call ptr @_zen_char_to_string(i8 %t15.i121)
  br label %sub_0260

sub_0260:                                         ; preds = %end116.i119, %whileBody458
  %common.ret.op.i123 = phi ptr [ %t16.i122, %end116.i119 ], [ @.str_stdlib_stdlib_0, %whileBody458 ]
  %93 = load i8, ptr %common.ret.op.i123, align 1
  %.not338 = icmp eq i8 %93, 93
  br i1 %.not338, label %sub_1261, label %whileCond457.backedge

sub_1261:                                         ; preds = %sub_0260
  %94 = getelementptr inbounds nuw i8, ptr %common.ret.op.i123, i64 1
  %95 = load i8, ptr %94, align 1
  %96 = icmp eq i8 %95, 0
  br i1 %96, label %whileEnd459, label %whileCond457.backedge

whileCond457.backedge:                            ; preds = %sub_0260, %sub_1261
  %storemerge1 = add nsw i32 %storemerge1448, 1
  %t406 = tail call i32 @strlen(ptr %t1.tr)
  %t407 = icmp slt i32 %storemerge1, %t406
  br i1 %t407, label %whileBody458, label %whileEnd459, !llvm.loop !0

whileEnd459:                                      ; preds = %sub_1261, %whileCond457.backedge, %whileCond457.peel.next, %charAt.exit124.tail.peel, %if456
  %storemerge1.in.lcssa = phi i32 [ %storemerge1.in.peel, %if456 ], [ %storemerge1.in.peel, %charAt.exit124.tail.peel ], [ %storemerge1.peel, %whileCond457.peel.next ], [ %storemerge1448, %whileCond457.backedge ], [ %storemerge1.in447, %sub_1261 ]
  %storemerge1.lcssa = phi i32 [ %storemerge1.peel, %if456 ], [ %storemerge1.peel, %charAt.exit124.tail.peel ], [ %storemerge1444, %whileCond457.peel.next ], [ %storemerge1, %whileCond457.backedge ], [ %storemerge1448, %sub_1261 ]
  %t4.i125 = tail call i32 @strlen(ptr %t1.tr)
  %spec.store.select.i126 = tail call i32 @llvm.smax.i32(i32 %storemerge1.peel, i32 0)
  %spec.select.i127 = tail call i32 @llvm.smin.i32(i32 %storemerge1.lcssa, i32 %t4.i125)
  %t14.i128 = icmp sle i32 %spec.store.select.i126, %spec.select.i127
  %t227.i129 = icmp samesign ult i32 %spec.store.select.i126, %spec.select.i127
  %or.cond.i130 = select i1 %t14.i128, i1 %t227.i129, i1 false
  br i1 %or.cond.i130, label %whileBody114.i132, label %slice.exit141

whileBody114.i132:                                ; preds = %whileEnd459, %whileBody114.i132
  %storemerge9.i133 = phi i32 [ %t32.i139, %whileBody114.i132 ], [ %spec.store.select.i126, %whileEnd459 ]
  %t3068.i134 = phi ptr [ %t30.i138, %whileBody114.i132 ], [ @.str_stdlib_stdlib_0, %whileEnd459 ]
  %97 = zext nneg i32 %storemerge9.i133 to i64
  %t26.i135 = getelementptr i8, ptr %t1.tr, i64 %97
  %t27.i136 = load i8, ptr %t26.i135, align 1
  %t28.i137 = tail call ptr @_zen_char_to_string(i8 %t27.i136)
  %t30.i138 = tail call ptr @_str_concat(ptr %t3068.i134, ptr %t28.i137)
  %t32.i139 = add nuw nsw i32 %storemerge9.i133, 1
  %t22.i140 = icmp slt i32 %t32.i139, %spec.select.i127
  br i1 %t22.i140, label %whileBody114.i132, label %slice.exit141

slice.exit141:                                    ; preds = %whileBody114.i132, %whileEnd459
  %common.ret.op.i131 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd459 ], [ %t30.i138, %whileBody114.i132 ]
  %t425 = tail call i32 @strlen(ptr %t0)
  %t426.not = icmp slt i32 %t67, %t425
  br i1 %t426.not, label %end462, label %common.ret

end462:                                           ; preds = %slice.exit141
  %t3.i142 = tail call i32 @strlen(ptr %t0)
  %t7.i143 = icmp slt i32 %t67, 0
  %t10.i144 = icmp sge i32 %t67, %t3.i142
  %t5.i145 = select i1 %t7.i143, i1 true, i1 %t10.i144
  br i1 %t5.i145, label %charAt.exit151, label %end116.i146

end116.i146:                                      ; preds = %end462
  %98 = zext nneg i32 %t67 to i64
  %t14.i147 = getelementptr i8, ptr %t0, i64 %98
  %t15.i148 = load i8, ptr %t14.i147, align 1
  %t16.i149 = tail call ptr @_zen_char_to_string(i8 %t15.i148)
  br label %charAt.exit151

charAt.exit151:                                   ; preds = %end462, %end116.i146
  %common.ret.op.i150 = phi ptr [ %t16.i149, %end116.i146 ], [ @.str_stdlib_stdlib_0, %end462 ]
  %t434 = tail call i32 @strlen(ptr %common.ret.op.i131)
  %t435 = icmp eq i32 %t434, 3
  br i1 %t435, label %rhs465, label %else469

rhs465:                                           ; preds = %charAt.exit151
  %t3.i152 = tail call i32 @strlen(ptr %common.ret.op.i131)
  %t10.i153 = icmp slt i32 %t3.i152, 2
  br i1 %t10.i153, label %sub_0263, label %end116.i155

end116.i155:                                      ; preds = %rhs465
  %t14.i156 = getelementptr i8, ptr %common.ret.op.i131, i64 1
  %t15.i157 = load i8, ptr %t14.i156, align 1
  %t16.i158 = tail call ptr @_zen_char_to_string(i8 %t15.i157)
  br label %sub_0263

sub_0263:                                         ; preds = %end116.i155, %rhs465
  %common.ret.op.i159 = phi ptr [ %t16.i158, %end116.i155 ], [ @.str_stdlib_stdlib_0, %rhs465 ]
  %99 = load i8, ptr %common.ret.op.i159, align 1
  %.not339 = icmp eq i8 %99, 45
  br i1 %.not339, label %charAt.exit160.tail, label %else469

charAt.exit160.tail:                              ; preds = %sub_0263
  %100 = getelementptr inbounds nuw i8, ptr %common.ret.op.i159, i64 1
  %101 = load i8, ptr %100, align 1
  %102 = icmp eq i8 %101, 0
  br i1 %102, label %if468, label %else469

if468:                                            ; preds = %charAt.exit160.tail
  %t3.i161 = tail call i32 @strlen(ptr %common.ret.op.i131)
  %t10.i162 = icmp slt i32 %t3.i161, 1
  br i1 %t10.i162, label %charAt.exit169, label %end116.i164

end116.i164:                                      ; preds = %if468
  %t15.i166 = load i8, ptr %common.ret.op.i131, align 1
  %t16.i167 = tail call ptr @_zen_char_to_string(i8 %t15.i166)
  br label %charAt.exit169

charAt.exit169:                                   ; preds = %if468, %end116.i164
  %common.ret.op.i168 = phi ptr [ %t16.i167, %end116.i164 ], [ @.str_stdlib_stdlib_0, %if468 ]
  %t3.i170 = tail call i32 @strlen(ptr %common.ret.op.i131)
  %t10.i171 = icmp slt i32 %t3.i170, 3
  br i1 %t10.i171, label %charAt.exit178, label %end116.i173

end116.i173:                                      ; preds = %charAt.exit169
  %t14.i174 = getelementptr i8, ptr %common.ret.op.i131, i64 2
  %t15.i175 = load i8, ptr %t14.i174, align 1
  %t16.i176 = tail call ptr @_zen_char_to_string(i8 %t15.i175)
  br label %charAt.exit178

charAt.exit178:                                   ; preds = %charAt.exit169, %end116.i173
  %common.ret.op.i177 = phi ptr [ %t16.i176, %end116.i173 ], [ @.str_stdlib_stdlib_0, %charAt.exit169 ]
  %t452 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i150, ptr noundef nonnull dereferenceable(1) %common.ret.op.i168)
  %t453 = icmp sgt i32 %t452, -1
  br i1 %t453, label %rhs471, label %common.ret

rhs471:                                           ; preds = %charAt.exit178
  %t457 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i150, ptr noundef nonnull dereferenceable(1) %common.ret.op.i177)
  %t458 = icmp slt i32 %t457, 1
  br i1 %t458, label %end482, label %common.ret

else469:                                          ; preds = %sub_0263, %charAt.exit151, %charAt.exit160.tail
  %t460283 = load i32, ptr @t_stdlib_78, align 4
  %t462284 = tail call i32 @strlen(ptr %common.ret.op.i131)
  %t463285 = icmp slt i32 %t460283, %t462284
  br i1 %t463285, label %whileBody476, label %common.ret

whileBody476:                                     ; preds = %else469, %whileCond475.backedge
  %t465 = load i32, ptr @t_stdlib_78, align 4
  %t3.i179 = tail call i32 @strlen(ptr %common.ret.op.i131)
  %t7.i180 = icmp slt i32 %t465, 0
  %t10.i181 = icmp sge i32 %t465, %t3.i179
  %t5.i182 = select i1 %t7.i180, i1 true, i1 %t10.i181
  br i1 %t5.i182, label %sub_0266, label %end116.i183

end116.i183:                                      ; preds = %whileBody476
  %103 = zext nneg i32 %t465 to i64
  %t14.i184 = getelementptr i8, ptr %common.ret.op.i131, i64 %103
  %t15.i185 = load i8, ptr %t14.i184, align 1
  %t16.i186 = tail call ptr @_zen_char_to_string(i8 %t15.i185)
  br label %sub_0266

sub_0266:                                         ; preds = %end116.i183, %whileBody476
  %common.ret.op.i187 = phi ptr [ %t16.i186, %end116.i183 ], [ @.str_stdlib_stdlib_0, %whileBody476 ]
  %104 = load i8, ptr %common.ret.op.i187, align 1
  %.not340 = icmp eq i8 %104, 44
  br i1 %.not340, label %charAt.exit188.tail, label %end478

charAt.exit188.tail:                              ; preds = %sub_0266
  %105 = getelementptr inbounds nuw i8, ptr %common.ret.op.i187, i64 1
  %106 = load i8, ptr %105, align 1
  %107 = icmp eq i8 %106, 0
  br i1 %107, label %whileCond475.backedge, label %end478

whileCond475.backedge:                            ; preds = %end478, %charAt.exit188.tail
  %storemerge.in = load i32, ptr @t_stdlib_78, align 4
  %storemerge = add i32 %storemerge.in, 1
  store i32 %storemerge, ptr @t_stdlib_78, align 4
  %t462 = tail call i32 @strlen(ptr %common.ret.op.i131)
  %t463 = icmp slt i32 %storemerge, %t462
  br i1 %t463, label %whileBody476, label %common.ret

end478:                                           ; preds = %sub_0266, %charAt.exit188.tail
  %t478 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i187, ptr noundef nonnull dereferenceable(1) %common.ret.op.i150)
  %t479 = icmp eq i32 %t478, 0
  br i1 %t479, label %end482, label %whileCond475.backedge

end482:                                           ; preds = %end478, %rhs471
  %t487 = add i32 %storemerge1.in.lcssa, 2
  br label %whileCond335.backedge

end455:                                           ; preds = %end338.tail, %charAt.exit15.tail, %end342.tail, %end351.tail, %sub_0257, %end383.tail
  %t490 = tail call i32 @strlen(ptr %t0)
  %t491.not = icmp slt i32 %t67, %t490
  br i1 %t491.not, label %end484, label %common.ret

end484:                                           ; preds = %end455
  %t3.i189 = tail call i32 @strlen(ptr %t0)
  %t7.i190 = icmp slt i32 %t67, 0
  %t10.i191 = icmp sge i32 %t67, %t3.i189
  %t5.i192 = select i1 %t7.i190, i1 true, i1 %t10.i191
  br i1 %t5.i192, label %charAt.exit198, label %end116.i193

end116.i193:                                      ; preds = %end484
  %108 = zext nneg i32 %t67 to i64
  %t14.i194 = getelementptr i8, ptr %t0, i64 %108
  %t15.i195 = load i8, ptr %t14.i194, align 1
  %t16.i196 = tail call ptr @_zen_char_to_string(i8 %t15.i195)
  br label %charAt.exit198

charAt.exit198:                                   ; preds = %end484, %end116.i193
  %common.ret.op.i197 = phi ptr [ %t16.i196, %end116.i193 ], [ @.str_stdlib_stdlib_0, %end484 ]
  %t497 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i197, ptr noundef nonnull dereferenceable(1) %common.ret.op.i14)
  %t498.not = icmp eq i32 %t497, 0
  br i1 %t498.not, label %end486, label %common.ret

end486:                                           ; preds = %charAt.exit198
  %t502 = add i32 %storemerge1.in.peel, 1
  br label %whileCond335.backedge

whileEnd337:                                      ; preds = %whileCond335.backedge, %end325
  %t503 = phi i32 [ 0, %end325 ], [ %t500289, %whileCond335.backedge ]
  %t505 = tail call i32 @strlen(ptr %t0)
  %t506 = icmp eq i32 %t503, %t505
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
  br i1 %t5.i, label %charAt.exit, label %end116.i

end116.i:                                         ; preds = %whileCond488
  %0 = zext nneg i32 %i.addr.0 to i64
  %t14.i = getelementptr i8, ptr %t0, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %whileCond488, %end116.i
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileCond488 ]
  %t6 = icmp slt i32 %i.addr.0, %t5
  br i1 %t6, label %rhs491, label %whileEnd490

rhs491:                                           ; preds = %charAt.exit
  %1 = load i8, ptr %common.ret.op.i, align 1
  switch i8 %1, label %whileEnd490 [
    i8 32, label %entry.tail.i
    i8 10, label %rhs500.tail.i
    i8 9, label %isWhitespace.exit
    i8 13, label %sub_18.i
  ]

entry.tail.i:                                     ; preds = %rhs491
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileBody489, label %whileEnd490

rhs500.tail.i:                                    ; preds = %rhs491
  %5 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %6 = load i8, ptr %5, align 1
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %whileBody489, label %whileEnd490

sub_18.i:                                         ; preds = %rhs491
  %8 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %9 = load i8, ptr %8, align 1
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %whileBody489, label %whileEnd490

isWhitespace.exit:                                ; preds = %rhs491
  %11 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %12 = load i8, ptr %11, align 1
  %13 = icmp eq i8 %12, 0
  br i1 %13, label %whileBody489, label %whileEnd490

whileBody489:                                     ; preds = %rhs500.tail.i, %entry.tail.i, %sub_18.i, %isWhitespace.exit
  %t12 = add nsw i32 %i.addr.0, 1
  br label %whileCond488

whileEnd490:                                      ; preds = %entry.tail.i, %rhs500.tail.i, %rhs491, %sub_18.i, %charAt.exit, %isWhitespace.exit
  ret i32 %i.addr.0
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read)
define i1 @isWhitespace(ptr readonly captures(none) %t0) local_unnamed_addr #4 {
entry:
  %0 = load i8, ptr %t0, align 1
  switch i8 %0, label %end496 [
    i8 32, label %entry.tail
    i8 10, label %rhs500.tail
    i8 9, label %rhs497.tail
    i8 13, label %sub_18
  ]

entry.tail:                                       ; preds = %entry
  %1 = getelementptr inbounds nuw i8, ptr %t0, i64 1
  %2 = load i8, ptr %1, align 1
  %3 = icmp eq i8 %2, 0
  br i1 %3, label %end496, label %sub_07.thread21

rhs500.tail:                                      ; preds = %entry
  %4 = getelementptr inbounds nuw i8, ptr %t0, i64 1
  %5 = load i8, ptr %4, align 1
  %6 = icmp eq i8 %5, 0
  br i1 %6, label %end496, label %sub_07.thread21

rhs497.tail:                                      ; preds = %entry
  %7 = getelementptr inbounds nuw i8, ptr %t0, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br label %end496

sub_07.thread21:                                  ; preds = %entry.tail, %rhs500.tail
  br label %end496

sub_18:                                           ; preds = %entry
  %10 = getelementptr inbounds nuw i8, ptr %t0, i64 1
  %11 = load i8, ptr %10, align 1
  %12 = icmp eq i8 %11, 0
  br label %end496

end496:                                           ; preds = %rhs497.tail, %entry, %sub_18, %sub_07.thread21, %rhs500.tail, %entry.tail
  %t1 = phi i1 [ true, %entry.tail ], [ true, %rhs500.tail ], [ %12, %sub_18 ], [ false, %sub_07.thread21 ], [ %9, %rhs497.tail ], [ false, %entry ]
  ret i1 %t1
}

define ptr @_json_extractValue(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t4 = tail call i32 @_json_skipWS(ptr %t0, i32 %t1)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t7.i = icmp slt i32 %t4, 0
  %t10.i = icmp sge i32 %t4, %t3.i
  %t5.i = select i1 %t7.i, i1 true, i1 %t10.i
  br i1 %t5.i, label %sub_0, label %end116.i

end116.i:                                         ; preds = %entry
  %0 = zext nneg i32 %t4 to i64
  %t14.i = getelementptr i8, ptr %t0, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %entry
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %entry ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %1, 34
  br i1 %.not, label %charAt.exit.tail, label %end503

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %if504, label %end503

if504:                                            ; preds = %charAt.exit.tail
  %t14 = add i32 %t4, 1
  %t17235 = tail call i32 @strlen(ptr %t0)
  %t18236 = icmp slt i32 %t14, %t17235
  br i1 %t18236, label %whileBody506, label %whileEnd507

whileBody506:                                     ; preds = %if504, %end508
  %storemerge12237 = phi i32 [ %t27, %end508 ], [ %t14, %if504 ]
  %t3.i13 = tail call i32 @strlen(ptr %t0)
  %t7.i14 = icmp slt i32 %storemerge12237, 0
  %t10.i15 = icmp sge i32 %storemerge12237, %t3.i13
  %t5.i16 = select i1 %t7.i14, i1 true, i1 %t10.i15
  br i1 %t5.i16, label %sub_0166, label %end116.i17

end116.i17:                                       ; preds = %whileBody506
  %5 = zext nneg i32 %storemerge12237 to i64
  %t14.i18 = getelementptr i8, ptr %t0, i64 %5
  %t15.i19 = load i8, ptr %t14.i18, align 1
  %t16.i20 = tail call ptr @_zen_char_to_string(i8 %t15.i19)
  br label %sub_0166

sub_0166:                                         ; preds = %end116.i17, %whileBody506
  %common.ret.op.i21 = phi ptr [ %t16.i20, %end116.i17 ], [ @.str_stdlib_stdlib_0, %whileBody506 ]
  %6 = load i8, ptr %common.ret.op.i21, align 1
  %.not250 = icmp eq i8 %6, 34
  br i1 %.not250, label %charAt.exit22.tail, label %end508

charAt.exit22.tail:                               ; preds = %sub_0166
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i21, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %whileEnd507, label %end508

end508:                                           ; preds = %sub_0166, %charAt.exit22.tail
  %t27 = add nsw i32 %storemerge12237, 1
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %t27, %t17
  br i1 %t18, label %whileBody506, label %whileEnd507

common.ret:                                       ; preds = %whileBody114.i156, %whileBody114.i109, %whileBody114.i62, %whileBody114.i, %whileEnd534, %whileEnd525, %whileEnd514, %whileEnd507
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd507 ], [ @.str_stdlib_stdlib_0, %whileEnd514 ], [ @.str_stdlib_stdlib_0, %whileEnd525 ], [ @.str_stdlib_stdlib_0, %whileEnd534 ], [ %t30.i, %whileBody114.i ], [ %t30.i68, %whileBody114.i62 ], [ %t30.i115, %whileBody114.i109 ], [ %t30.i162, %whileBody114.i156 ]
  ret ptr %common.ret.op

whileEnd507:                                      ; preds = %end508, %charAt.exit22.tail, %if504
  %storemerge12.lcssa = phi i32 [ %t14, %if504 ], [ %storemerge12237, %charAt.exit22.tail ], [ %t27, %end508 ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t14, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %storemerge12.lcssa, i32 %t4.i)
  %t14.i23 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t227.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t14.i23, i1 %t227.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %common.ret

whileBody114.i:                                   ; preds = %whileEnd507, %whileBody114.i
  %storemerge9.i = phi i32 [ %t32.i, %whileBody114.i ], [ %spec.store.select.i, %whileEnd507 ]
  %t3068.i = phi ptr [ %t30.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileEnd507 ]
  %10 = zext nneg i32 %storemerge9.i to i64
  %t26.i = getelementptr i8, ptr %t0, i64 %10
  %t27.i = load i8, ptr %t26.i, align 1
  %t28.i = tail call ptr @_zen_char_to_string(i8 %t27.i)
  %t30.i = tail call ptr @_str_concat(ptr %t3068.i, ptr %t28.i)
  %t32.i = add nuw nsw i32 %storemerge9.i, 1
  %t22.i = icmp slt i32 %t32.i, %spec.select.i
  br i1 %t22.i, label %whileBody114.i, label %common.ret

end503:                                           ; preds = %sub_0, %charAt.exit.tail
  %t3.i25 = tail call i32 @strlen(ptr %t0)
  %t10.i27 = icmp sge i32 %t4, %t3.i25
  %t5.i28 = select i1 %t7.i, i1 true, i1 %t10.i27
  br i1 %t5.i28, label %sub_0169, label %end116.i29

end116.i29:                                       ; preds = %end503
  %11 = zext nneg i32 %t4 to i64
  %t14.i30 = getelementptr i8, ptr %t0, i64 %11
  %t15.i31 = load i8, ptr %t14.i30, align 1
  %t16.i32 = tail call ptr @_zen_char_to_string(i8 %t15.i31)
  br label %sub_0169

sub_0169:                                         ; preds = %end116.i29, %end503
  %common.ret.op.i33 = phi ptr [ %t16.i32, %end116.i29 ], [ @.str_stdlib_stdlib_0, %end503 ]
  %12 = load i8, ptr %common.ret.op.i33, align 1
  %.not241 = icmp eq i8 %12, 123
  br i1 %.not241, label %charAt.exit34.tail, label %end510

charAt.exit34.tail:                               ; preds = %sub_0169
  %13 = getelementptr inbounds nuw i8, ptr %common.ret.op.i33, i64 1
  %14 = load i8, ptr %13, align 1
  %15 = icmp eq i8 %14, 0
  br i1 %15, label %if511, label %end510

if511:                                            ; preds = %charAt.exit34.tail
  %t45225 = tail call i32 @strlen(ptr %t0)
  %t46226 = icmp slt i32 %t4, %t45225
  br i1 %t46226, label %whileBody513, label %whileEnd514

whileBody513:                                     ; preds = %if511, %end519
  %t68220228 = phi i32 [ %t68, %end519 ], [ %t4, %if511 ]
  %t65.pr221227 = phi i32 [ %t65.pr222, %end519 ], [ 0, %if511 ]
  %t3.i35 = tail call i32 @strlen(ptr %t0)
  %t7.i36 = icmp slt i32 %t68220228, 0
  %t10.i37 = icmp sge i32 %t68220228, %t3.i35
  %t5.i38 = select i1 %t7.i36, i1 true, i1 %t10.i37
  br i1 %t5.i38, label %sub_0172, label %end116.i39

end116.i39:                                       ; preds = %whileBody513
  %16 = zext nneg i32 %t68220228 to i64
  %t14.i40 = getelementptr i8, ptr %t0, i64 %16
  %t15.i41 = load i8, ptr %t14.i40, align 1
  %t16.i42 = tail call ptr @_zen_char_to_string(i8 %t15.i41)
  br label %sub_0172

sub_0172:                                         ; preds = %end116.i39, %whileBody513
  %common.ret.op.i43 = phi ptr [ %t16.i42, %end116.i39 ], [ @.str_stdlib_stdlib_0, %whileBody513 ]
  %17 = load i8, ptr %common.ret.op.i43, align 1
  %.not248 = icmp eq i8 %17, 123
  br i1 %.not248, label %sub_1173, label %charAt.exit44.tail

sub_1173:                                         ; preds = %sub_0172
  %18 = getelementptr inbounds nuw i8, ptr %common.ret.op.i43, i64 1
  %19 = load i8, ptr %18, align 1
  %20 = icmp eq i8 %19, 0
  br label %charAt.exit44.tail

charAt.exit44.tail:                               ; preds = %sub_0172, %sub_1173
  %t53 = phi i1 [ false, %sub_0172 ], [ %20, %sub_1173 ]
  %t55 = zext i1 %t53 to i32
  %spec.select = add i32 %t65.pr221227, %t55
  %t3.i45 = tail call i32 @strlen(ptr %t0)
  %t10.i47 = icmp sge i32 %t68220228, %t3.i45
  %t5.i48 = select i1 %t7.i36, i1 true, i1 %t10.i47
  br i1 %t5.i48, label %sub_0175, label %end116.i49

end116.i49:                                       ; preds = %charAt.exit44.tail
  %21 = zext nneg i32 %t68220228 to i64
  %t14.i50 = getelementptr i8, ptr %t0, i64 %21
  %t15.i51 = load i8, ptr %t14.i50, align 1
  %t16.i52 = tail call ptr @_zen_char_to_string(i8 %t15.i51)
  br label %sub_0175

sub_0175:                                         ; preds = %end116.i49, %charAt.exit44.tail
  %common.ret.op.i53 = phi ptr [ %t16.i52, %end116.i49 ], [ @.str_stdlib_stdlib_0, %charAt.exit44.tail ]
  %22 = load i8, ptr %common.ret.op.i53, align 1
  %.not249 = icmp eq i8 %22, 125
  br i1 %.not249, label %sub_1176, label %charAt.exit54.tail

sub_1176:                                         ; preds = %sub_0175
  %23 = getelementptr inbounds nuw i8, ptr %common.ret.op.i53, i64 1
  %24 = load i8, ptr %23, align 1
  %25 = icmp eq i8 %24, 0
  br label %charAt.exit54.tail

charAt.exit54.tail:                               ; preds = %sub_0175, %sub_1176
  %t62 = phi i1 [ false, %sub_0175 ], [ %25, %sub_1176 ]
  %t64 = sext i1 %t62 to i32
  %t65.pr222 = add i32 %spec.select, %t64
  %t66 = icmp eq i32 %t65.pr222, 0
  br i1 %t66, label %whileEnd514, label %end519

end519:                                           ; preds = %charAt.exit54.tail
  %t68 = add nsw i32 %t68220228, 1
  %t45 = tail call i32 @strlen(ptr %t0)
  %t46 = icmp slt i32 %t68, %t45
  br i1 %t46, label %whileBody513, label %whileEnd514

whileEnd514:                                      ; preds = %end519, %charAt.exit54.tail, %if511
  %t68220.lcssa = phi i32 [ %t4, %if511 ], [ %t68220228, %charAt.exit54.tail ], [ %t68, %end519 ]
  %t72 = add i32 %t68220.lcssa, 1
  %t4.i55 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i56 = tail call i32 @llvm.smax.i32(i32 %t4, i32 0)
  %spec.select.i57 = tail call i32 @llvm.smin.i32(i32 %t72, i32 %t4.i55)
  %t14.i58 = icmp sle i32 %spec.store.select.i56, %spec.select.i57
  %t227.i59 = icmp samesign ult i32 %spec.store.select.i56, %spec.select.i57
  %or.cond.i60 = select i1 %t14.i58, i1 %t227.i59, i1 false
  br i1 %or.cond.i60, label %whileBody114.i62, label %common.ret

whileBody114.i62:                                 ; preds = %whileEnd514, %whileBody114.i62
  %storemerge9.i63 = phi i32 [ %t32.i69, %whileBody114.i62 ], [ %spec.store.select.i56, %whileEnd514 ]
  %t3068.i64 = phi ptr [ %t30.i68, %whileBody114.i62 ], [ @.str_stdlib_stdlib_0, %whileEnd514 ]
  %26 = zext nneg i32 %storemerge9.i63 to i64
  %t26.i65 = getelementptr i8, ptr %t0, i64 %26
  %t27.i66 = load i8, ptr %t26.i65, align 1
  %t28.i67 = tail call ptr @_zen_char_to_string(i8 %t27.i66)
  %t30.i68 = tail call ptr @_str_concat(ptr %t3068.i64, ptr %t28.i67)
  %t32.i69 = add nuw nsw i32 %storemerge9.i63, 1
  %t22.i70 = icmp slt i32 %t32.i69, %spec.select.i57
  br i1 %t22.i70, label %whileBody114.i62, label %common.ret

end510:                                           ; preds = %sub_0169, %charAt.exit34.tail
  %t3.i72 = tail call i32 @strlen(ptr %t0)
  %t10.i74 = icmp sge i32 %t4, %t3.i72
  %t5.i75 = select i1 %t7.i, i1 true, i1 %t10.i74
  br i1 %t5.i75, label %sub_0178, label %end116.i76

end116.i76:                                       ; preds = %end510
  %27 = zext nneg i32 %t4 to i64
  %t14.i77 = getelementptr i8, ptr %t0, i64 %27
  %t15.i78 = load i8, ptr %t14.i77, align 1
  %t16.i79 = tail call ptr @_zen_char_to_string(i8 %t15.i78)
  br label %sub_0178

sub_0178:                                         ; preds = %end116.i76, %end510
  %common.ret.op.i80 = phi ptr [ %t16.i79, %end116.i76 ], [ @.str_stdlib_stdlib_0, %end510 ]
  %28 = load i8, ptr %common.ret.op.i80, align 1
  %.not242 = icmp eq i8 %28, 91
  br i1 %.not242, label %charAt.exit81.tail, label %whileCond532.preheader

charAt.exit81.tail:                               ; preds = %sub_0178
  %29 = getelementptr inbounds nuw i8, ptr %common.ret.op.i80, i64 1
  %30 = load i8, ptr %29, align 1
  %31 = icmp eq i8 %30, 0
  br i1 %31, label %if522, label %whileCond532.preheader

whileCond532.preheader:                           ; preds = %sub_0178, %charAt.exit81.tail
  %t119199 = tail call i32 @strlen(ptr %t0)
  %t120200 = icmp slt i32 %t4, %t119199
  br i1 %t120200, label %whileBody533, label %whileEnd534

if522:                                            ; preds = %charAt.exit81.tail
  %t86210 = tail call i32 @strlen(ptr %t0)
  %t87211 = icmp slt i32 %t4, %t86210
  br i1 %t87211, label %whileBody524, label %whileEnd525

whileBody524:                                     ; preds = %if522, %end530
  %t109205213 = phi i32 [ %t109, %end530 ], [ %t4, %if522 ]
  %t106.pr206212 = phi i32 [ %t106.pr207, %end530 ], [ 0, %if522 ]
  %t3.i82 = tail call i32 @strlen(ptr %t0)
  %t7.i83 = icmp slt i32 %t109205213, 0
  %t10.i84 = icmp sge i32 %t109205213, %t3.i82
  %t5.i85 = select i1 %t7.i83, i1 true, i1 %t10.i84
  br i1 %t5.i85, label %sub_0181, label %end116.i86

end116.i86:                                       ; preds = %whileBody524
  %32 = zext nneg i32 %t109205213 to i64
  %t14.i87 = getelementptr i8, ptr %t0, i64 %32
  %t15.i88 = load i8, ptr %t14.i87, align 1
  %t16.i89 = tail call ptr @_zen_char_to_string(i8 %t15.i88)
  br label %sub_0181

sub_0181:                                         ; preds = %end116.i86, %whileBody524
  %common.ret.op.i90 = phi ptr [ %t16.i89, %end116.i86 ], [ @.str_stdlib_stdlib_0, %whileBody524 ]
  %33 = load i8, ptr %common.ret.op.i90, align 1
  %.not246 = icmp eq i8 %33, 91
  br i1 %.not246, label %sub_1182, label %charAt.exit91.tail

sub_1182:                                         ; preds = %sub_0181
  %34 = getelementptr inbounds nuw i8, ptr %common.ret.op.i90, i64 1
  %35 = load i8, ptr %34, align 1
  %36 = icmp eq i8 %35, 0
  br label %charAt.exit91.tail

charAt.exit91.tail:                               ; preds = %sub_0181, %sub_1182
  %t94 = phi i1 [ false, %sub_0181 ], [ %36, %sub_1182 ]
  %t96 = zext i1 %t94 to i32
  %spec.select240 = add i32 %t106.pr206212, %t96
  %t3.i92 = tail call i32 @strlen(ptr %t0)
  %t10.i94 = icmp sge i32 %t109205213, %t3.i92
  %t5.i95 = select i1 %t7.i83, i1 true, i1 %t10.i94
  br i1 %t5.i95, label %sub_0184, label %end116.i96

end116.i96:                                       ; preds = %charAt.exit91.tail
  %37 = zext nneg i32 %t109205213 to i64
  %t14.i97 = getelementptr i8, ptr %t0, i64 %37
  %t15.i98 = load i8, ptr %t14.i97, align 1
  %t16.i99 = tail call ptr @_zen_char_to_string(i8 %t15.i98)
  br label %sub_0184

sub_0184:                                         ; preds = %end116.i96, %charAt.exit91.tail
  %common.ret.op.i100 = phi ptr [ %t16.i99, %end116.i96 ], [ @.str_stdlib_stdlib_0, %charAt.exit91.tail ]
  %38 = load i8, ptr %common.ret.op.i100, align 1
  %.not247 = icmp eq i8 %38, 93
  br i1 %.not247, label %sub_1185, label %charAt.exit101.tail

sub_1185:                                         ; preds = %sub_0184
  %39 = getelementptr inbounds nuw i8, ptr %common.ret.op.i100, i64 1
  %40 = load i8, ptr %39, align 1
  %41 = icmp eq i8 %40, 0
  br label %charAt.exit101.tail

charAt.exit101.tail:                              ; preds = %sub_0184, %sub_1185
  %t103 = phi i1 [ false, %sub_0184 ], [ %41, %sub_1185 ]
  %t105 = sext i1 %t103 to i32
  %t106.pr207 = add i32 %spec.select240, %t105
  %t107 = icmp eq i32 %t106.pr207, 0
  br i1 %t107, label %whileEnd525, label %end530

end530:                                           ; preds = %charAt.exit101.tail
  %t109 = add nsw i32 %t109205213, 1
  %t86 = tail call i32 @strlen(ptr %t0)
  %t87 = icmp slt i32 %t109, %t86
  br i1 %t87, label %whileBody524, label %whileEnd525

whileEnd525:                                      ; preds = %end530, %charAt.exit101.tail, %if522
  %t109205.lcssa = phi i32 [ %t4, %if522 ], [ %t109205213, %charAt.exit101.tail ], [ %t109, %end530 ]
  %t113 = add i32 %t109205.lcssa, 1
  %t4.i102 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i103 = tail call i32 @llvm.smax.i32(i32 %t4, i32 0)
  %spec.select.i104 = tail call i32 @llvm.smin.i32(i32 %t113, i32 %t4.i102)
  %t14.i105 = icmp sle i32 %spec.store.select.i103, %spec.select.i104
  %t227.i106 = icmp samesign ult i32 %spec.store.select.i103, %spec.select.i104
  %or.cond.i107 = select i1 %t14.i105, i1 %t227.i106, i1 false
  br i1 %or.cond.i107, label %whileBody114.i109, label %common.ret

whileBody114.i109:                                ; preds = %whileEnd525, %whileBody114.i109
  %storemerge9.i110 = phi i32 [ %t32.i116, %whileBody114.i109 ], [ %spec.store.select.i103, %whileEnd525 ]
  %t3068.i111 = phi ptr [ %t30.i115, %whileBody114.i109 ], [ @.str_stdlib_stdlib_0, %whileEnd525 ]
  %42 = zext nneg i32 %storemerge9.i110 to i64
  %t26.i112 = getelementptr i8, ptr %t0, i64 %42
  %t27.i113 = load i8, ptr %t26.i112, align 1
  %t28.i114 = tail call ptr @_zen_char_to_string(i8 %t27.i113)
  %t30.i115 = tail call ptr @_str_concat(ptr %t3068.i111, ptr %t28.i114)
  %t32.i116 = add nuw nsw i32 %storemerge9.i110, 1
  %t22.i117 = icmp slt i32 %t32.i116, %spec.select.i104
  br i1 %t22.i117, label %whileBody114.i109, label %common.ret

whileBody533:                                     ; preds = %whileCond532.preheader, %end535
  %storemerge201 = phi i32 [ %t145, %end535 ], [ %t4, %whileCond532.preheader ]
  %t3.i119 = tail call i32 @strlen(ptr %t0)
  %t7.i120 = icmp slt i32 %storemerge201, 0
  %t10.i121 = icmp sge i32 %storemerge201, %t3.i119
  %t5.i122 = select i1 %t7.i120, i1 true, i1 %t10.i121
  br i1 %t5.i122, label %sub_0187, label %end116.i123

end116.i123:                                      ; preds = %whileBody533
  %43 = zext nneg i32 %storemerge201 to i64
  %t14.i124 = getelementptr i8, ptr %t0, i64 %43
  %t15.i125 = load i8, ptr %t14.i124, align 1
  %t16.i126 = tail call ptr @_zen_char_to_string(i8 %t15.i125)
  br label %sub_0187

sub_0187:                                         ; preds = %end116.i123, %whileBody533
  %common.ret.op.i127 = phi ptr [ %t16.i126, %end116.i123 ], [ @.str_stdlib_stdlib_0, %whileBody533 ]
  %44 = load i8, ptr %common.ret.op.i127, align 1
  %.not243 = icmp eq i8 %44, 44
  br i1 %.not243, label %charAt.exit128.tail, label %rhs539

charAt.exit128.tail:                              ; preds = %sub_0187
  %45 = getelementptr inbounds nuw i8, ptr %common.ret.op.i127, i64 1
  %46 = load i8, ptr %45, align 1
  %47 = icmp eq i8 %46, 0
  br i1 %47, label %whileEnd534, label %rhs539

rhs539:                                           ; preds = %sub_0187, %charAt.exit128.tail
  %t3.i129 = tail call i32 @strlen(ptr %t0)
  %t10.i131 = icmp sge i32 %storemerge201, %t3.i129
  %t5.i132 = select i1 %t7.i120, i1 true, i1 %t10.i131
  br i1 %t5.i132, label %sub_0190, label %end116.i133

end116.i133:                                      ; preds = %rhs539
  %48 = zext nneg i32 %storemerge201 to i64
  %t14.i134 = getelementptr i8, ptr %t0, i64 %48
  %t15.i135 = load i8, ptr %t14.i134, align 1
  %t16.i136 = tail call ptr @_zen_char_to_string(i8 %t15.i135)
  br label %sub_0190

sub_0190:                                         ; preds = %end116.i133, %rhs539
  %common.ret.op.i137 = phi ptr [ %t16.i136, %end116.i133 ], [ @.str_stdlib_stdlib_0, %rhs539 ]
  %49 = load i8, ptr %common.ret.op.i137, align 1
  %.not244 = icmp eq i8 %49, 125
  br i1 %.not244, label %charAt.exit138.tail, label %rhs536

charAt.exit138.tail:                              ; preds = %sub_0190
  %50 = getelementptr inbounds nuw i8, ptr %common.ret.op.i137, i64 1
  %51 = load i8, ptr %50, align 1
  %52 = icmp eq i8 %51, 0
  br i1 %52, label %whileEnd534, label %rhs536

rhs536:                                           ; preds = %sub_0190, %charAt.exit138.tail
  %t3.i139 = tail call i32 @strlen(ptr %t0)
  %t10.i141 = icmp sge i32 %storemerge201, %t3.i139
  %t5.i142 = select i1 %t7.i120, i1 true, i1 %t10.i141
  br i1 %t5.i142, label %sub_0193, label %end116.i143

end116.i143:                                      ; preds = %rhs536
  %53 = zext nneg i32 %storemerge201 to i64
  %t14.i144 = getelementptr i8, ptr %t0, i64 %53
  %t15.i145 = load i8, ptr %t14.i144, align 1
  %t16.i146 = tail call ptr @_zen_char_to_string(i8 %t15.i145)
  br label %sub_0193

sub_0193:                                         ; preds = %end116.i143, %rhs536
  %common.ret.op.i147 = phi ptr [ %t16.i146, %end116.i143 ], [ @.str_stdlib_stdlib_0, %rhs536 ]
  %54 = load i8, ptr %common.ret.op.i147, align 1
  %.not245 = icmp eq i8 %54, 93
  br i1 %.not245, label %charAt.exit148.tail, label %end535

charAt.exit148.tail:                              ; preds = %sub_0193
  %55 = getelementptr inbounds nuw i8, ptr %common.ret.op.i147, i64 1
  %56 = load i8, ptr %55, align 1
  %57 = icmp eq i8 %56, 0
  br i1 %57, label %whileEnd534, label %end535

end535:                                           ; preds = %sub_0193, %charAt.exit148.tail
  %t145 = add nsw i32 %storemerge201, 1
  %t119 = tail call i32 @strlen(ptr %t0)
  %t120 = icmp slt i32 %t145, %t119
  br i1 %t120, label %whileBody533, label %whileEnd534

whileEnd534:                                      ; preds = %end535, %charAt.exit148.tail, %charAt.exit138.tail, %charAt.exit128.tail, %whileCond532.preheader
  %storemerge.lcssa = phi i32 [ %t4, %whileCond532.preheader ], [ %storemerge201, %charAt.exit128.tail ], [ %storemerge201, %charAt.exit138.tail ], [ %storemerge201, %charAt.exit148.tail ], [ %t145, %end535 ]
  %t4.i149 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i150 = tail call i32 @llvm.smax.i32(i32 %t4, i32 0)
  %spec.select.i151 = tail call i32 @llvm.smin.i32(i32 %storemerge.lcssa, i32 %t4.i149)
  %t14.i152 = icmp sle i32 %spec.store.select.i150, %spec.select.i151
  %t227.i153 = icmp samesign ult i32 %spec.store.select.i150, %spec.select.i151
  %or.cond.i154 = select i1 %t14.i152, i1 %t227.i153, i1 false
  br i1 %or.cond.i154, label %whileBody114.i156, label %common.ret

whileBody114.i156:                                ; preds = %whileEnd534, %whileBody114.i156
  %storemerge9.i157 = phi i32 [ %t32.i163, %whileBody114.i156 ], [ %spec.store.select.i150, %whileEnd534 ]
  %t3068.i158 = phi ptr [ %t30.i162, %whileBody114.i156 ], [ @.str_stdlib_stdlib_0, %whileEnd534 ]
  %58 = zext nneg i32 %storemerge9.i157 to i64
  %t26.i159 = getelementptr i8, ptr %t0, i64 %58
  %t27.i160 = load i8, ptr %t26.i159, align 1
  %t28.i161 = tail call ptr @_zen_char_to_string(i8 %t27.i160)
  %t30.i162 = tail call ptr @_str_concat(ptr %t3068.i158, ptr %t28.i161)
  %t32.i163 = add nuw nsw i32 %storemerge9.i157, 1
  %t22.i164 = icmp slt i32 %t32.i163, %spec.select.i151
  br i1 %t22.i164, label %whileBody114.i156, label %common.ret
}

define i32 @_json_skipElement(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t4 = tail call i32 @_json_skipWS(ptr %t0, i32 %t1)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t7.i = icmp slt i32 %t4, 0
  %t10.i = icmp sge i32 %t4, %t3.i
  %t5.i = select i1 %t7.i, i1 true, i1 %t10.i
  br i1 %t5.i, label %sub_0, label %end116.i

end116.i:                                         ; preds = %entry
  %0 = zext nneg i32 %t4 to i64
  %t14.i = getelementptr i8, ptr %t0, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %entry
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %entry ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %1, 34
  br i1 %.not, label %charAt.exit.tail, label %end543

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileCond545.preheader, label %end543

whileCond545.preheader:                           ; preds = %charAt.exit.tail
  %i.addr.0202 = add i32 %t4, 1
  %t16203 = tail call i32 @strlen(ptr %t0)
  %t17204 = icmp slt i32 %i.addr.0202, %t16203
  br i1 %t17204, label %whileBody546, label %whileEnd547

whileBody546:                                     ; preds = %whileCond545.preheader, %whileCond545.backedge
  %i.addr.0206 = phi i32 [ %i.addr.0, %whileCond545.backedge ], [ %i.addr.0202, %whileCond545.preheader ]
  %i.addr.0.in205 = phi i32 [ %i.addr.0206, %whileCond545.backedge ], [ %t4, %whileCond545.preheader ]
  %t3.i25 = tail call i32 @strlen(ptr %t0)
  %t7.i26 = icmp slt i32 %i.addr.0206, 0
  %t10.i27 = icmp sge i32 %i.addr.0206, %t3.i25
  %t5.i28 = select i1 %t7.i26, i1 true, i1 %t10.i27
  br i1 %t5.i28, label %sub_0125, label %end116.i29

end116.i29:                                       ; preds = %whileBody546
  %5 = zext nneg i32 %i.addr.0206 to i64
  %t14.i30 = getelementptr i8, ptr %t0, i64 %5
  %t15.i31 = load i8, ptr %t14.i30, align 1
  %t16.i32 = tail call ptr @_zen_char_to_string(i8 %t15.i31)
  br label %sub_0125

sub_0125:                                         ; preds = %end116.i29, %whileBody546
  %common.ret.op.i33 = phi ptr [ %t16.i32, %end116.i29 ], [ @.str_stdlib_stdlib_0, %whileBody546 ]
  %6 = load i8, ptr %common.ret.op.i33, align 1
  %.not195 = icmp eq i8 %6, 34
  br i1 %.not195, label %sub_1126, label %whileCond545.backedge

sub_1126:                                         ; preds = %sub_0125
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i33, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %whileEnd547, label %whileCond545.backedge

whileCond545.backedge:                            ; preds = %sub_0125, %sub_1126
  %i.addr.0 = add i32 %i.addr.0206, 1
  %t16 = tail call i32 @strlen(ptr %t0)
  %t17 = icmp slt i32 %i.addr.0, %t16
  br i1 %t17, label %whileBody546, label %whileEnd547

common.ret:                                       ; preds = %charAt.exit104.tail, %charAt.exit114.tail, %charAt.exit124.tail, %end575, %whileCond572.preheader, %whileEnd565, %whileEnd554, %whileEnd547
  %common.ret.op = phi i32 [ %t28, %whileEnd547 ], [ %t64, %whileEnd554 ], [ %t100, %whileEnd565 ], [ %t4, %whileCond572.preheader ], [ %i.addr.3157, %charAt.exit104.tail ], [ %i.addr.3157, %charAt.exit114.tail ], [ %i.addr.3157, %charAt.exit124.tail ], [ %t129, %end575 ]
  ret i32 %common.ret.op

whileEnd547:                                      ; preds = %whileCond545.backedge, %sub_1126, %whileCond545.preheader
  %i.addr.0.in.lcssa = phi i32 [ %t4, %whileCond545.preheader ], [ %i.addr.0206, %whileCond545.backedge ], [ %i.addr.0.in205, %sub_1126 ]
  %t28 = add i32 %i.addr.0.in.lcssa, 2
  br label %common.ret

end543:                                           ; preds = %sub_0, %charAt.exit.tail
  %t3.i35 = tail call i32 @strlen(ptr %t0)
  %t10.i37 = icmp sge i32 %t4, %t3.i35
  %t5.i38 = select i1 %t7.i, i1 true, i1 %t10.i37
  br i1 %t5.i38, label %sub_0128, label %end116.i39

end116.i39:                                       ; preds = %end543
  %10 = zext nneg i32 %t4 to i64
  %t14.i40 = getelementptr i8, ptr %t0, i64 %10
  %t15.i41 = load i8, ptr %t14.i40, align 1
  %t16.i42 = tail call ptr @_zen_char_to_string(i8 %t15.i41)
  br label %sub_0128

sub_0128:                                         ; preds = %end116.i39, %end543
  %common.ret.op.i43 = phi ptr [ %t16.i42, %end116.i39 ], [ @.str_stdlib_stdlib_0, %end543 ]
  %11 = load i8, ptr %common.ret.op.i43, align 1
  %.not186 = icmp eq i8 %11, 123
  br i1 %.not186, label %charAt.exit44.tail, label %end550

charAt.exit44.tail:                               ; preds = %sub_0128
  %12 = getelementptr inbounds nuw i8, ptr %common.ret.op.i43, i64 1
  %13 = load i8, ptr %12, align 1
  %14 = icmp eq i8 %13, 0
  br i1 %14, label %if551, label %end550

if551:                                            ; preds = %charAt.exit44.tail
  %t39177 = tail call i32 @strlen(ptr %t0)
  %t40178 = icmp slt i32 %t4, %t39177
  br i1 %t40178, label %whileBody553, label %whileEnd554

whileBody553:                                     ; preds = %if551, %end559
  %i.addr.1180 = phi i32 [ %t62, %end559 ], [ %t4, %if551 ]
  %t59.pr173179 = phi i32 [ %t59.pr174, %end559 ], [ 0, %if551 ]
  %t3.i45 = tail call i32 @strlen(ptr %t0)
  %t7.i46 = icmp slt i32 %i.addr.1180, 0
  %t10.i47 = icmp sge i32 %i.addr.1180, %t3.i45
  %t5.i48 = select i1 %t7.i46, i1 true, i1 %t10.i47
  br i1 %t5.i48, label %sub_0131, label %end116.i49

end116.i49:                                       ; preds = %whileBody553
  %15 = zext nneg i32 %i.addr.1180 to i64
  %t14.i50 = getelementptr i8, ptr %t0, i64 %15
  %t15.i51 = load i8, ptr %t14.i50, align 1
  %t16.i52 = tail call ptr @_zen_char_to_string(i8 %t15.i51)
  br label %sub_0131

sub_0131:                                         ; preds = %end116.i49, %whileBody553
  %common.ret.op.i53 = phi ptr [ %t16.i52, %end116.i49 ], [ @.str_stdlib_stdlib_0, %whileBody553 ]
  %16 = load i8, ptr %common.ret.op.i53, align 1
  %.not193 = icmp eq i8 %16, 123
  br i1 %.not193, label %sub_1132, label %charAt.exit54.tail

sub_1132:                                         ; preds = %sub_0131
  %17 = getelementptr inbounds nuw i8, ptr %common.ret.op.i53, i64 1
  %18 = load i8, ptr %17, align 1
  %19 = icmp eq i8 %18, 0
  br label %charAt.exit54.tail

charAt.exit54.tail:                               ; preds = %sub_0131, %sub_1132
  %t47 = phi i1 [ false, %sub_0131 ], [ %19, %sub_1132 ]
  %t49 = zext i1 %t47 to i32
  %spec.select = add i32 %t59.pr173179, %t49
  %t3.i55 = tail call i32 @strlen(ptr %t0)
  %t10.i57 = icmp sge i32 %i.addr.1180, %t3.i55
  %t5.i58 = select i1 %t7.i46, i1 true, i1 %t10.i57
  br i1 %t5.i58, label %sub_0134, label %end116.i59

end116.i59:                                       ; preds = %charAt.exit54.tail
  %20 = zext nneg i32 %i.addr.1180 to i64
  %t14.i60 = getelementptr i8, ptr %t0, i64 %20
  %t15.i61 = load i8, ptr %t14.i60, align 1
  %t16.i62 = tail call ptr @_zen_char_to_string(i8 %t15.i61)
  br label %sub_0134

sub_0134:                                         ; preds = %end116.i59, %charAt.exit54.tail
  %common.ret.op.i63 = phi ptr [ %t16.i62, %end116.i59 ], [ @.str_stdlib_stdlib_0, %charAt.exit54.tail ]
  %21 = load i8, ptr %common.ret.op.i63, align 1
  %.not194 = icmp eq i8 %21, 125
  br i1 %.not194, label %sub_1135, label %charAt.exit64.tail

sub_1135:                                         ; preds = %sub_0134
  %22 = getelementptr inbounds nuw i8, ptr %common.ret.op.i63, i64 1
  %23 = load i8, ptr %22, align 1
  %24 = icmp eq i8 %23, 0
  br label %charAt.exit64.tail

charAt.exit64.tail:                               ; preds = %sub_0134, %sub_1135
  %t56 = phi i1 [ false, %sub_0134 ], [ %24, %sub_1135 ]
  %t58 = sext i1 %t56 to i32
  %t59.pr174 = add i32 %spec.select, %t58
  %t60 = icmp eq i32 %t59.pr174, 0
  br i1 %t60, label %whileEnd554, label %end559

end559:                                           ; preds = %charAt.exit64.tail
  %t62 = add nsw i32 %i.addr.1180, 1
  %t39 = tail call i32 @strlen(ptr %t0)
  %t40 = icmp slt i32 %t62, %t39
  br i1 %t40, label %whileBody553, label %whileEnd554

whileEnd554:                                      ; preds = %end559, %charAt.exit64.tail, %if551
  %i.addr.1.lcssa = phi i32 [ %t4, %if551 ], [ %i.addr.1180, %charAt.exit64.tail ], [ %t62, %end559 ]
  %t64 = add i32 %i.addr.1.lcssa, 1
  br label %common.ret

end550:                                           ; preds = %sub_0128, %charAt.exit44.tail
  %t3.i65 = tail call i32 @strlen(ptr %t0)
  %t10.i67 = icmp sge i32 %t4, %t3.i65
  %t5.i68 = select i1 %t7.i, i1 true, i1 %t10.i67
  br i1 %t5.i68, label %sub_0137, label %end116.i69

end116.i69:                                       ; preds = %end550
  %25 = zext nneg i32 %t4 to i64
  %t14.i70 = getelementptr i8, ptr %t0, i64 %25
  %t15.i71 = load i8, ptr %t14.i70, align 1
  %t16.i72 = tail call ptr @_zen_char_to_string(i8 %t15.i71)
  br label %sub_0137

sub_0137:                                         ; preds = %end116.i69, %end550
  %common.ret.op.i73 = phi ptr [ %t16.i72, %end116.i69 ], [ @.str_stdlib_stdlib_0, %end550 ]
  %26 = load i8, ptr %common.ret.op.i73, align 1
  %.not187 = icmp eq i8 %26, 91
  br i1 %.not187, label %charAt.exit74.tail, label %whileCond572.preheader

charAt.exit74.tail:                               ; preds = %sub_0137
  %27 = getelementptr inbounds nuw i8, ptr %common.ret.op.i73, i64 1
  %28 = load i8, ptr %27, align 1
  %29 = icmp eq i8 %28, 0
  br i1 %29, label %if562, label %whileCond572.preheader

whileCond572.preheader:                           ; preds = %sub_0137, %charAt.exit74.tail
  %t103155 = tail call i32 @strlen(ptr %t0)
  %t104156 = icmp slt i32 %t4, %t103155
  br i1 %t104156, label %whileBody573, label %common.ret

if562:                                            ; preds = %charAt.exit74.tail
  %t75165 = tail call i32 @strlen(ptr %t0)
  %t76166 = icmp slt i32 %t4, %t75165
  br i1 %t76166, label %whileBody564, label %whileEnd565

whileBody564:                                     ; preds = %if562, %end570
  %i.addr.2168 = phi i32 [ %t98, %end570 ], [ %t4, %if562 ]
  %t95.pr161167 = phi i32 [ %t95.pr162, %end570 ], [ 0, %if562 ]
  %t3.i75 = tail call i32 @strlen(ptr %t0)
  %t7.i76 = icmp slt i32 %i.addr.2168, 0
  %t10.i77 = icmp sge i32 %i.addr.2168, %t3.i75
  %t5.i78 = select i1 %t7.i76, i1 true, i1 %t10.i77
  br i1 %t5.i78, label %sub_0140, label %end116.i79

end116.i79:                                       ; preds = %whileBody564
  %30 = zext nneg i32 %i.addr.2168 to i64
  %t14.i80 = getelementptr i8, ptr %t0, i64 %30
  %t15.i81 = load i8, ptr %t14.i80, align 1
  %t16.i82 = tail call ptr @_zen_char_to_string(i8 %t15.i81)
  br label %sub_0140

sub_0140:                                         ; preds = %end116.i79, %whileBody564
  %common.ret.op.i83 = phi ptr [ %t16.i82, %end116.i79 ], [ @.str_stdlib_stdlib_0, %whileBody564 ]
  %31 = load i8, ptr %common.ret.op.i83, align 1
  %.not191 = icmp eq i8 %31, 91
  br i1 %.not191, label %sub_1141, label %charAt.exit84.tail

sub_1141:                                         ; preds = %sub_0140
  %32 = getelementptr inbounds nuw i8, ptr %common.ret.op.i83, i64 1
  %33 = load i8, ptr %32, align 1
  %34 = icmp eq i8 %33, 0
  br label %charAt.exit84.tail

charAt.exit84.tail:                               ; preds = %sub_0140, %sub_1141
  %t83 = phi i1 [ false, %sub_0140 ], [ %34, %sub_1141 ]
  %t85 = zext i1 %t83 to i32
  %spec.select185 = add i32 %t95.pr161167, %t85
  %t3.i85 = tail call i32 @strlen(ptr %t0)
  %t10.i87 = icmp sge i32 %i.addr.2168, %t3.i85
  %t5.i88 = select i1 %t7.i76, i1 true, i1 %t10.i87
  br i1 %t5.i88, label %sub_0143, label %end116.i89

end116.i89:                                       ; preds = %charAt.exit84.tail
  %35 = zext nneg i32 %i.addr.2168 to i64
  %t14.i90 = getelementptr i8, ptr %t0, i64 %35
  %t15.i91 = load i8, ptr %t14.i90, align 1
  %t16.i92 = tail call ptr @_zen_char_to_string(i8 %t15.i91)
  br label %sub_0143

sub_0143:                                         ; preds = %end116.i89, %charAt.exit84.tail
  %common.ret.op.i93 = phi ptr [ %t16.i92, %end116.i89 ], [ @.str_stdlib_stdlib_0, %charAt.exit84.tail ]
  %36 = load i8, ptr %common.ret.op.i93, align 1
  %.not192 = icmp eq i8 %36, 93
  br i1 %.not192, label %sub_1144, label %charAt.exit94.tail

sub_1144:                                         ; preds = %sub_0143
  %37 = getelementptr inbounds nuw i8, ptr %common.ret.op.i93, i64 1
  %38 = load i8, ptr %37, align 1
  %39 = icmp eq i8 %38, 0
  br label %charAt.exit94.tail

charAt.exit94.tail:                               ; preds = %sub_0143, %sub_1144
  %t92 = phi i1 [ false, %sub_0143 ], [ %39, %sub_1144 ]
  %t94 = sext i1 %t92 to i32
  %t95.pr162 = add i32 %spec.select185, %t94
  %t96 = icmp eq i32 %t95.pr162, 0
  br i1 %t96, label %whileEnd565, label %end570

end570:                                           ; preds = %charAt.exit94.tail
  %t98 = add nsw i32 %i.addr.2168, 1
  %t75 = tail call i32 @strlen(ptr %t0)
  %t76 = icmp slt i32 %t98, %t75
  br i1 %t76, label %whileBody564, label %whileEnd565

whileEnd565:                                      ; preds = %end570, %charAt.exit94.tail, %if562
  %i.addr.2.lcssa = phi i32 [ %t4, %if562 ], [ %i.addr.2168, %charAt.exit94.tail ], [ %t98, %end570 ]
  %t100 = add i32 %i.addr.2.lcssa, 1
  br label %common.ret

whileBody573:                                     ; preds = %whileCond572.preheader, %end575
  %i.addr.3157 = phi i32 [ %t129, %end575 ], [ %t4, %whileCond572.preheader ]
  %t3.i95 = tail call i32 @strlen(ptr %t0)
  %t7.i96 = icmp slt i32 %i.addr.3157, 0
  %t10.i97 = icmp sge i32 %i.addr.3157, %t3.i95
  %t5.i98 = select i1 %t7.i96, i1 true, i1 %t10.i97
  br i1 %t5.i98, label %sub_0146, label %end116.i99

end116.i99:                                       ; preds = %whileBody573
  %40 = zext nneg i32 %i.addr.3157 to i64
  %t14.i100 = getelementptr i8, ptr %t0, i64 %40
  %t15.i101 = load i8, ptr %t14.i100, align 1
  %t16.i102 = tail call ptr @_zen_char_to_string(i8 %t15.i101)
  br label %sub_0146

sub_0146:                                         ; preds = %end116.i99, %whileBody573
  %common.ret.op.i103 = phi ptr [ %t16.i102, %end116.i99 ], [ @.str_stdlib_stdlib_0, %whileBody573 ]
  %41 = load i8, ptr %common.ret.op.i103, align 1
  %.not188 = icmp eq i8 %41, 44
  br i1 %.not188, label %charAt.exit104.tail, label %rhs579

charAt.exit104.tail:                              ; preds = %sub_0146
  %42 = getelementptr inbounds nuw i8, ptr %common.ret.op.i103, i64 1
  %43 = load i8, ptr %42, align 1
  %44 = icmp eq i8 %43, 0
  br i1 %44, label %common.ret, label %rhs579

rhs579:                                           ; preds = %sub_0146, %charAt.exit104.tail
  %t3.i105 = tail call i32 @strlen(ptr %t0)
  %t10.i107 = icmp sge i32 %i.addr.3157, %t3.i105
  %t5.i108 = select i1 %t7.i96, i1 true, i1 %t10.i107
  br i1 %t5.i108, label %sub_0149, label %end116.i109

end116.i109:                                      ; preds = %rhs579
  %45 = zext nneg i32 %i.addr.3157 to i64
  %t14.i110 = getelementptr i8, ptr %t0, i64 %45
  %t15.i111 = load i8, ptr %t14.i110, align 1
  %t16.i112 = tail call ptr @_zen_char_to_string(i8 %t15.i111)
  br label %sub_0149

sub_0149:                                         ; preds = %end116.i109, %rhs579
  %common.ret.op.i113 = phi ptr [ %t16.i112, %end116.i109 ], [ @.str_stdlib_stdlib_0, %rhs579 ]
  %46 = load i8, ptr %common.ret.op.i113, align 1
  %.not189 = icmp eq i8 %46, 93
  br i1 %.not189, label %charAt.exit114.tail, label %rhs576

charAt.exit114.tail:                              ; preds = %sub_0149
  %47 = getelementptr inbounds nuw i8, ptr %common.ret.op.i113, i64 1
  %48 = load i8, ptr %47, align 1
  %49 = icmp eq i8 %48, 0
  br i1 %49, label %common.ret, label %rhs576

rhs576:                                           ; preds = %sub_0149, %charAt.exit114.tail
  %t3.i115 = tail call i32 @strlen(ptr %t0)
  %t10.i117 = icmp sge i32 %i.addr.3157, %t3.i115
  %t5.i118 = select i1 %t7.i96, i1 true, i1 %t10.i117
  br i1 %t5.i118, label %sub_0152, label %end116.i119

end116.i119:                                      ; preds = %rhs576
  %50 = zext nneg i32 %i.addr.3157 to i64
  %t14.i120 = getelementptr i8, ptr %t0, i64 %50
  %t15.i121 = load i8, ptr %t14.i120, align 1
  %t16.i122 = tail call ptr @_zen_char_to_string(i8 %t15.i121)
  br label %sub_0152

sub_0152:                                         ; preds = %end116.i119, %rhs576
  %common.ret.op.i123 = phi ptr [ %t16.i122, %end116.i119 ], [ @.str_stdlib_stdlib_0, %rhs576 ]
  %51 = load i8, ptr %common.ret.op.i123, align 1
  %.not190 = icmp eq i8 %51, 125
  br i1 %.not190, label %charAt.exit124.tail, label %end575

charAt.exit124.tail:                              ; preds = %sub_0152
  %52 = getelementptr inbounds nuw i8, ptr %common.ret.op.i123, i64 1
  %53 = load i8, ptr %52, align 1
  %54 = icmp eq i8 %53, 0
  br i1 %54, label %common.ret, label %end575

end575:                                           ; preds = %sub_0152, %charAt.exit124.tail
  %t129 = add nsw i32 %i.addr.3157, 1
  %t103 = tail call i32 @strlen(ptr %t0)
  %t104 = icmp slt i32 %t129, %t103
  br i1 %t104, label %whileBody573, label %common.ret
}

define ptr @_json_getArrayIndex(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @_json_skipWS(ptr %t0, i32 0)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t7.i = icmp slt i32 %t3, 0
  %t10.i = icmp sge i32 %t3, %t3.i
  %t5.i = select i1 %t7.i, i1 true, i1 %t10.i
  br i1 %t5.i, label %sub_0, label %end116.i

end116.i:                                         ; preds = %entry
  %0 = zext nneg i32 %t3 to i64
  %t14.i = getelementptr i8, ptr %t0, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %entry
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %entry ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %1, 91
  br i1 %.not, label %charAt.exit.tail, label %common.ret

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %end583, label %common.ret

common.ret:                                       ; preds = %end590, %charAt.exit30.tail, %end594, %sub_0, %end583, %charAt.exit.tail, %if595
  %common.ret.op = phi ptr [ %t51, %if595 ], [ @.str_stdlib_stdlib_33, %charAt.exit.tail ], [ @.str_stdlib_stdlib_33, %end583 ], [ @.str_stdlib_stdlib_33, %sub_0 ], [ @.str_stdlib_stdlib_33, %end594 ], [ @.str_stdlib_stdlib_33, %charAt.exit30.tail ], [ @.str_stdlib_stdlib_33, %end590 ]
  ret ptr %common.ret.op

end583:                                           ; preds = %charAt.exit.tail
  %t14 = add i32 %t3, 1
  %t1837 = tail call i32 @strlen(ptr %t0)
  %t1938 = icmp slt i32 %t14, %t1837
  br i1 %t1938, label %whileBody586, label %common.ret

whileBody586:                                     ; preds = %end583, %end594
  %t4.040 = phi i32 [ %t54, %end594 ], [ %t14, %end583 ]
  %storemerge39 = phi i32 [ %t56, %end594 ], [ 0, %end583 ]
  %t22 = tail call i32 @_json_skipWS(ptr %t0, i32 %t4.040)
  %t3.i11 = tail call i32 @strlen(ptr %t0)
  %t7.i12 = icmp slt i32 %t22, 0
  %t10.i13 = icmp sge i32 %t22, %t3.i11
  %t5.i14 = select i1 %t7.i12, i1 true, i1 %t10.i13
  br i1 %t5.i14, label %sub_031, label %end116.i15

end116.i15:                                       ; preds = %whileBody586
  %5 = zext nneg i32 %t22 to i64
  %t14.i16 = getelementptr i8, ptr %t0, i64 %5
  %t15.i17 = load i8, ptr %t14.i16, align 1
  %t16.i18 = tail call ptr @_zen_char_to_string(i8 %t15.i17)
  br label %sub_031

sub_031:                                          ; preds = %end116.i15, %whileBody586
  %common.ret.op.i19 = phi ptr [ %t16.i18, %end116.i15 ], [ @.str_stdlib_stdlib_0, %whileBody586 ]
  %6 = load i8, ptr %common.ret.op.i19, align 1
  %.not41 = icmp eq i8 %6, 44
  br i1 %.not41, label %charAt.exit20.tail, label %end588

charAt.exit20.tail:                               ; preds = %sub_031
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i19, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %if589, label %end588

if589:                                            ; preds = %charAt.exit20.tail
  %t31 = add i32 %t22, 1
  %t34 = tail call i32 @_json_skipWS(ptr %t0, i32 %t31)
  br label %end588

end588:                                           ; preds = %sub_031, %if589, %charAt.exit20.tail
  %t4.1 = phi i32 [ %t34, %if589 ], [ %t22, %charAt.exit20.tail ], [ %t22, %sub_031 ]
  %t3.i21 = tail call i32 @strlen(ptr %t0)
  %t7.i22 = icmp slt i32 %t4.1, 0
  %t10.i23 = icmp sge i32 %t4.1, %t3.i21
  %t5.i24 = select i1 %t7.i22, i1 true, i1 %t10.i23
  br i1 %t5.i24, label %sub_034, label %end116.i25

end116.i25:                                       ; preds = %end588
  %10 = zext nneg i32 %t4.1 to i64
  %t14.i26 = getelementptr i8, ptr %t0, i64 %10
  %t15.i27 = load i8, ptr %t14.i26, align 1
  %t16.i28 = tail call ptr @_zen_char_to_string(i8 %t15.i27)
  br label %sub_034

sub_034:                                          ; preds = %end116.i25, %end588
  %common.ret.op.i29 = phi ptr [ %t16.i28, %end116.i25 ], [ @.str_stdlib_stdlib_0, %end588 ]
  %11 = load i8, ptr %common.ret.op.i29, align 1
  %.not42 = icmp eq i8 %11, 93
  br i1 %.not42, label %charAt.exit30.tail, label %end590

charAt.exit30.tail:                               ; preds = %sub_034
  %12 = getelementptr inbounds nuw i8, ptr %common.ret.op.i29, i64 1
  %13 = load i8, ptr %12, align 1
  %14 = icmp eq i8 %13, 0
  br i1 %14, label %common.ret, label %end590

end590:                                           ; preds = %sub_034, %charAt.exit30.tail
  %t44 = tail call i32 @strlen(ptr %t0)
  %t45.not = icmp slt i32 %t4.1, %t44
  br i1 %t45.not, label %end592, label %common.ret

end592:                                           ; preds = %end590
  %t48 = icmp eq i32 %storemerge39, %t1
  br i1 %t48, label %if595, label %end594

if595:                                            ; preds = %end592
  %t51 = tail call ptr @_json_extractValue(ptr %t0, i32 %t4.1)
  br label %common.ret

end594:                                           ; preds = %end592
  %t54 = tail call i32 @_json_skipElement(ptr %t0, i32 %t4.1)
  %t56 = add i32 %storemerge39, 1
  %t18 = tail call i32 @strlen(ptr %t0)
  %t19 = icmp slt i32 %t54, %t18
  br i1 %t19, label %whileBody586, label %common.ret
}

define ptr @_json_getKey(ptr %t0, ptr readonly captures(none) %t1) local_unnamed_addr {
entry:
  %t3 = tail call i32 @_json_skipWS(ptr %t0, i32 0)
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t7.i = icmp slt i32 %t3, 0
  %t10.i = icmp sge i32 %t3, %t3.i
  %t5.i = select i1 %t7.i, i1 true, i1 %t10.i
  br i1 %t5.i, label %sub_0, label %end116.i

end116.i:                                         ; preds = %entry
  %0 = zext nneg i32 %t3 to i64
  %t14.i = getelementptr i8, ptr %t0, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %entry
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %entry ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %1, 123
  br i1 %.not, label %charAt.exit.tail, label %common.ret

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %end596, label %common.ret

common.ret:                                       ; preds = %sub_080, %sub_074, %charAt.exit67.tail, %charAt.exit45.tail, %charAt.exit25.tail, %end615, %sub_0, %end596, %charAt.exit.tail, %if616
  %common.ret.op = phi ptr [ %t96, %if616 ], [ @.str_stdlib_stdlib_33, %charAt.exit.tail ], [ @.str_stdlib_stdlib_33, %end596 ], [ @.str_stdlib_stdlib_33, %sub_0 ], [ @.str_stdlib_stdlib_33, %end615 ], [ @.str_stdlib_stdlib_33, %charAt.exit25.tail ], [ @.str_stdlib_stdlib_33, %charAt.exit45.tail ], [ @.str_stdlib_stdlib_33, %charAt.exit67.tail ], [ @.str_stdlib_stdlib_33, %sub_074 ], [ @.str_stdlib_stdlib_33, %sub_080 ]
  ret ptr %common.ret.op

end596:                                           ; preds = %charAt.exit.tail
  %t14 = add i32 %t3, 1
  %t1787 = tail call i32 @strlen(ptr %t0)
  %t1888 = icmp slt i32 %t14, %t1787
  br i1 %t1888, label %whileBody599, label %common.ret

whileBody599:                                     ; preds = %end596, %end615
  %t4.089 = phi i32 [ %t99, %end615 ], [ %t14, %end596 ]
  %t21 = tail call i32 @_json_skipWS(ptr %t0, i32 %t4.089)
  %t3.i16 = tail call i32 @strlen(ptr %t0)
  %t7.i17 = icmp slt i32 %t21, 0
  %t10.i18 = icmp sge i32 %t21, %t3.i16
  %t5.i19 = select i1 %t7.i17, i1 true, i1 %t10.i18
  br i1 %t5.i19, label %sub_068, label %end116.i20

end116.i20:                                       ; preds = %whileBody599
  %5 = zext nneg i32 %t21 to i64
  %t14.i21 = getelementptr i8, ptr %t0, i64 %5
  %t15.i22 = load i8, ptr %t14.i21, align 1
  %t16.i23 = tail call ptr @_zen_char_to_string(i8 %t15.i22)
  br label %sub_068

sub_068:                                          ; preds = %end116.i20, %whileBody599
  %common.ret.op.i24 = phi ptr [ %t16.i23, %end116.i20 ], [ @.str_stdlib_stdlib_0, %whileBody599 ]
  %6 = load i8, ptr %common.ret.op.i24, align 1
  %.not90 = icmp eq i8 %6, 125
  br i1 %.not90, label %charAt.exit25.tail, label %end601

charAt.exit25.tail:                               ; preds = %sub_068
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i24, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %common.ret, label %end601

end601:                                           ; preds = %sub_068, %charAt.exit25.tail
  %t3.i26 = tail call i32 @strlen(ptr %t0)
  %t10.i28 = icmp sge i32 %t21, %t3.i26
  %t5.i29 = select i1 %t7.i17, i1 true, i1 %t10.i28
  br i1 %t5.i29, label %sub_071, label %end116.i30

end116.i30:                                       ; preds = %end601
  %10 = zext nneg i32 %t21 to i64
  %t14.i31 = getelementptr i8, ptr %t0, i64 %10
  %t15.i32 = load i8, ptr %t14.i31, align 1
  %t16.i33 = tail call ptr @_zen_char_to_string(i8 %t15.i32)
  br label %sub_071

sub_071:                                          ; preds = %end116.i30, %end601
  %common.ret.op.i34 = phi ptr [ %t16.i33, %end116.i30 ], [ @.str_stdlib_stdlib_0, %end601 ]
  %11 = load i8, ptr %common.ret.op.i34, align 1
  %.not91 = icmp eq i8 %11, 44
  br i1 %.not91, label %charAt.exit35.tail, label %end603

charAt.exit35.tail:                               ; preds = %sub_071
  %12 = getelementptr inbounds nuw i8, ptr %common.ret.op.i34, i64 1
  %13 = load i8, ptr %12, align 1
  %14 = icmp eq i8 %13, 0
  br i1 %14, label %if604, label %end603

if604:                                            ; preds = %charAt.exit35.tail
  %t37 = add i32 %t21, 1
  %t40 = tail call i32 @_json_skipWS(ptr %t0, i32 %t37)
  br label %end603

end603:                                           ; preds = %sub_071, %if604, %charAt.exit35.tail
  %t4.1 = phi i32 [ %t40, %if604 ], [ %t21, %charAt.exit35.tail ], [ %t21, %sub_071 ]
  %t3.i36 = tail call i32 @strlen(ptr %t0)
  %t7.i37 = icmp slt i32 %t4.1, 0
  %t10.i38 = icmp sge i32 %t4.1, %t3.i36
  %t5.i39 = select i1 %t7.i37, i1 true, i1 %t10.i38
  br i1 %t5.i39, label %sub_074, label %end116.i40

end116.i40:                                       ; preds = %end603
  %15 = zext nneg i32 %t4.1 to i64
  %t14.i41 = getelementptr i8, ptr %t0, i64 %15
  %t15.i42 = load i8, ptr %t14.i41, align 1
  %t16.i43 = tail call ptr @_zen_char_to_string(i8 %t15.i42)
  br label %sub_074

sub_074:                                          ; preds = %end116.i40, %end603
  %common.ret.op.i44 = phi ptr [ %t16.i43, %end116.i40 ], [ @.str_stdlib_stdlib_0, %end603 ]
  %16 = load i8, ptr %common.ret.op.i44, align 1
  %.not92 = icmp eq i8 %16, 34
  br i1 %.not92, label %charAt.exit45.tail, label %common.ret

charAt.exit45.tail:                               ; preds = %sub_074
  %17 = getelementptr inbounds nuw i8, ptr %common.ret.op.i44, i64 1
  %18 = load i8, ptr %17, align 1
  %19 = icmp eq i8 %18, 0
  br i1 %19, label %end605, label %common.ret

end605:                                           ; preds = %charAt.exit45.tail
  %t50 = add i32 %t4.1, 1
  %t5683 = tail call i32 @strlen(ptr %t0)
  %t5784 = icmp slt i32 %t50, %t5683
  br i1 %t5784, label %rhs610, label %whileEnd609

rhs610:                                           ; preds = %end605, %whileBody608
  %storemerge85 = phi i32 [ %t66, %whileBody608 ], [ %t50, %end605 ]
  %t3.i46 = tail call i32 @strlen(ptr %t0)
  %t7.i47 = icmp slt i32 %storemerge85, 0
  %t10.i48 = icmp sge i32 %storemerge85, %t3.i46
  %t5.i49 = select i1 %t7.i47, i1 true, i1 %t10.i48
  br i1 %t5.i49, label %sub_077, label %end116.i50

end116.i50:                                       ; preds = %rhs610
  %20 = zext nneg i32 %storemerge85 to i64
  %t14.i51 = getelementptr i8, ptr %t0, i64 %20
  %t15.i52 = load i8, ptr %t14.i51, align 1
  %t16.i53 = tail call ptr @_zen_char_to_string(i8 %t15.i52)
  br label %sub_077

sub_077:                                          ; preds = %end116.i50, %rhs610
  %common.ret.op.i54 = phi ptr [ %t16.i53, %end116.i50 ], [ @.str_stdlib_stdlib_0, %rhs610 ]
  %21 = load i8, ptr %common.ret.op.i54, align 1
  %.not93 = icmp eq i8 %21, 34
  br i1 %.not93, label %charAt.exit55.tail, label %whileBody608

charAt.exit55.tail:                               ; preds = %sub_077
  %22 = getelementptr inbounds nuw i8, ptr %common.ret.op.i54, i64 1
  %23 = load i8, ptr %22, align 1
  %24 = icmp eq i8 %23, 0
  br i1 %24, label %whileEnd609, label %whileBody608

whileBody608:                                     ; preds = %sub_077, %charAt.exit55.tail
  %t66 = add nsw i32 %storemerge85, 1
  %t56 = tail call i32 @strlen(ptr %t0)
  %t57 = icmp slt i32 %t66, %t56
  br i1 %t57, label %rhs610, label %whileEnd609

whileEnd609:                                      ; preds = %charAt.exit55.tail, %whileBody608, %end605
  %storemerge.lcssa = phi i32 [ %t50, %end605 ], [ %t66, %whileBody608 ], [ %storemerge85, %charAt.exit55.tail ]
  %t4.i = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t50, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %storemerge.lcssa, i32 %t4.i)
  %t14.i56 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t227.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t14.i56, i1 %t227.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileEnd609, %whileBody114.i
  %storemerge9.i = phi i32 [ %t32.i, %whileBody114.i ], [ %spec.store.select.i, %whileEnd609 ]
  %t3068.i = phi ptr [ %t30.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileEnd609 ]
  %25 = zext nneg i32 %storemerge9.i to i64
  %t26.i = getelementptr i8, ptr %t0, i64 %25
  %t27.i = load i8, ptr %t26.i, align 1
  %t28.i = tail call ptr @_zen_char_to_string(i8 %t27.i)
  %t30.i = tail call ptr @_str_concat(ptr %t3068.i, ptr %t28.i)
  %t32.i = add nuw nsw i32 %storemerge9.i, 1
  %t22.i = icmp slt i32 %t32.i, %spec.select.i
  br i1 %t22.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileEnd609
  %common.ret.op.i57 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd609 ], [ %t30.i, %whileBody114.i ]
  %t73 = add i32 %storemerge.lcssa, 1
  %t76 = tail call i32 @_json_skipWS(ptr %t0, i32 %t73)
  %t3.i58 = tail call i32 @strlen(ptr %t0)
  %t7.i59 = icmp slt i32 %t76, 0
  %t10.i60 = icmp sge i32 %t76, %t3.i58
  %t5.i61 = select i1 %t7.i59, i1 true, i1 %t10.i60
  br i1 %t5.i61, label %sub_080, label %end116.i62

end116.i62:                                       ; preds = %slice.exit
  %26 = zext nneg i32 %t76 to i64
  %t14.i63 = getelementptr i8, ptr %t0, i64 %26
  %t15.i64 = load i8, ptr %t14.i63, align 1
  %t16.i65 = tail call ptr @_zen_char_to_string(i8 %t15.i64)
  br label %sub_080

sub_080:                                          ; preds = %end116.i62, %slice.exit
  %common.ret.op.i66 = phi ptr [ %t16.i65, %end116.i62 ], [ @.str_stdlib_stdlib_0, %slice.exit ]
  %27 = load i8, ptr %common.ret.op.i66, align 1
  %.not94 = icmp eq i8 %27, 58
  br i1 %.not94, label %charAt.exit67.tail, label %common.ret

charAt.exit67.tail:                               ; preds = %sub_080
  %28 = getelementptr inbounds nuw i8, ptr %common.ret.op.i66, i64 1
  %29 = load i8, ptr %28, align 1
  %30 = icmp eq i8 %29, 0
  br i1 %30, label %end613, label %common.ret

end613:                                           ; preds = %charAt.exit67.tail
  %t85 = add i32 %t76, 1
  %t88 = tail call i32 @_json_skipWS(ptr %t0, i32 %t85)
  %t92 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i57, ptr noundef nonnull dereferenceable(1) %t1)
  %t93 = icmp eq i32 %t92, 0
  br i1 %t93, label %if616, label %end615

if616:                                            ; preds = %end613
  %t96 = tail call ptr @_json_extractValue(ptr %t0, i32 %t88)
  br label %common.ret

end615:                                           ; preds = %end613
  %t99 = tail call i32 @_json_skipElement(ptr %t0, i32 %t88)
  %t17 = tail call i32 @strlen(ptr %t0)
  %t18 = icmp slt i32 %t99, %t17
  br i1 %t18, label %whileBody599, label %common.ret
}

define i32 @_json_parseInt(ptr %t0) local_unnamed_addr {
entry:
  %t54 = tail call i32 @strlen(ptr %t0)
  %t65 = icmp sgt i32 %t54, 0
  br i1 %t65, label %whileBody618, label %whileEnd619

whileBody618:                                     ; preds = %entry, %charAt.exit
  %t2.07 = phi i32 [ %t18, %charAt.exit ], [ 0, %entry ]
  %t1.06 = phi i32 [ %t16, %charAt.exit ], [ 0, %entry ]
  %t3.i = tail call i32 @strlen(ptr %t0)
  %t10.i.not = icmp slt i32 %t2.07, %t3.i
  br i1 %t10.i.not, label %end116.i, label %charAt.exit

end116.i:                                         ; preds = %whileBody618
  %0 = zext nneg i32 %t2.07 to i64
  %t14.i = getelementptr i8, ptr %t0, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %whileBody618, %end116.i
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody618 ]
  %t11 = tail call i32 @_string_to_int_ascii(ptr %common.ret.op.i)
  %t14 = mul i32 %t1.06, 10
  %t12 = add i32 %t14, -48
  %t16 = add i32 %t12, %t11
  %t18 = add nuw nsw i32 %t2.07, 1
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6 = icmp slt i32 %t18, %t5
  br i1 %t6, label %whileBody618, label %whileEnd619

whileEnd619:                                      ; preds = %charAt.exit, %entry
  %t1.0.lcssa = phi i32 [ 0, %entry ], [ %t16, %charAt.exit ]
  ret i32 %t1.0.lcssa
}

define ptr @json(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t881 = tail call ptr @splitAt(ptr %t1, ptr nonnull @.str_stdlib_stdlib_8, i32 0)
  %strcmpload82 = load i8, ptr %t881, align 1
  %t1483 = icmp eq i8 %strcmpload82, 0
  br i1 %t1483, label %common.ret, label %whileCond625.preheader

whileCond625.preheader:                           ; preds = %entry, %whileEnd636
  %t886 = phi ptr [ %t8, %whileEnd636 ], [ %t881, %entry ]
  %t4.085 = phi i32 [ %t102, %whileEnd636 ], [ 0, %entry ]
  %t2.084 = phi ptr [ %t2.2.lcssa, %whileEnd636 ], [ %t0, %entry ]
  %t1871 = tail call i32 @strlen(ptr nonnull %t886)
  %t1972 = icmp sgt i32 %t1871, 0
  br i1 %t1972, label %whileBody626, label %whileEnd627

whileBody626:                                     ; preds = %whileCond625.preheader, %end628
  %storemerge73 = phi i32 [ %t28, %end628 ], [ 0, %whileCond625.preheader ]
  %t3.i = tail call i32 @strlen(ptr nonnull %t886)
  %t10.i.not = icmp slt i32 %storemerge73, %t3.i
  br i1 %t10.i.not, label %end116.i, label %sub_0

end116.i:                                         ; preds = %whileBody626
  %0 = zext nneg i32 %storemerge73 to i64
  %t14.i = getelementptr i8, ptr %t886, i64 %0
  %t15.i = load i8, ptr %t14.i, align 1
  %t16.i = tail call ptr @_zen_char_to_string(i8 %t15.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %whileBody626
  %common.ret.op.i = phi ptr [ %t16.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody626 ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %1, 91
  br i1 %.not, label %charAt.exit.tail, label %end628

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileEnd627, label %end628

end628:                                           ; preds = %sub_0, %charAt.exit.tail
  %t28 = add nuw nsw i32 %storemerge73, 1
  %t18 = tail call i32 @strlen(ptr nonnull %t886)
  %t19 = icmp slt i32 %t28, %t18
  br i1 %t19, label %whileBody626, label %whileEnd627

whileEnd627:                                      ; preds = %end628, %charAt.exit.tail, %whileCond625.preheader
  %storemerge.lcssa = phi i32 [ 0, %whileCond625.preheader ], [ %storemerge73, %charAt.exit.tail ], [ %t28, %end628 ]
  %t4.i = tail call i32 @strlen(ptr nonnull %t886)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %storemerge.lcssa, i32 %t4.i)
  %or.cond.i = icmp sgt i32 %spec.select.i, 0
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileEnd627, %whileBody114.i
  %storemerge9.i = phi i32 [ %t32.i, %whileBody114.i ], [ 0, %whileEnd627 ]
  %t3068.i = phi ptr [ %t30.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileEnd627 ]
  %5 = zext nneg i32 %storemerge9.i to i64
  %t26.i = getelementptr i8, ptr %t886, i64 %5
  %t27.i = load i8, ptr %t26.i, align 1
  %t28.i = tail call ptr @_zen_char_to_string(i8 %t27.i)
  %t30.i = tail call ptr @_str_concat(ptr %t3068.i, ptr %t28.i)
  %t32.i = add nuw nsw i32 %storemerge9.i, 1
  %t22.i = icmp slt i32 %t32.i, %spec.select.i
  br i1 %t22.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileEnd627
  %common.ret.op.i6 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd627 ], [ %t30.i, %whileBody114.i ]
  %t36 = tail call i32 @strlen(ptr nonnull %t886)
  %t4.i7 = tail call i32 @strlen(ptr nonnull %t886)
  %spec.select.i8 = tail call i32 @llvm.smin.i32(i32 %t36, i32 %t4.i7)
  %t14.i9 = icmp sle i32 %storemerge.lcssa, %spec.select.i8
  %t227.i10 = icmp samesign ult i32 %storemerge.lcssa, %spec.select.i8
  %or.cond.i11 = select i1 %t14.i9, i1 %t227.i10, i1 false
  br i1 %or.cond.i11, label %whileBody114.i13, label %slice.exit22

whileBody114.i13:                                 ; preds = %slice.exit, %whileBody114.i13
  %storemerge9.i14 = phi i32 [ %t32.i20, %whileBody114.i13 ], [ %storemerge.lcssa, %slice.exit ]
  %t3068.i15 = phi ptr [ %t30.i19, %whileBody114.i13 ], [ @.str_stdlib_stdlib_0, %slice.exit ]
  %6 = zext nneg i32 %storemerge9.i14 to i64
  %t26.i16 = getelementptr i8, ptr %t886, i64 %6
  %t27.i17 = load i8, ptr %t26.i16, align 1
  %t28.i18 = tail call ptr @_zen_char_to_string(i8 %t27.i17)
  %t30.i19 = tail call ptr @_str_concat(ptr %t3068.i15, ptr %t28.i18)
  %t32.i20 = add nuw nsw i32 %storemerge9.i14, 1
  %t22.i21 = icmp slt i32 %t32.i20, %spec.select.i8
  br i1 %t22.i21, label %whileBody114.i13, label %slice.exit22

slice.exit22:                                     ; preds = %whileBody114.i13, %slice.exit
  %t55 = phi ptr [ @.str_stdlib_stdlib_0, %slice.exit ], [ %t30.i19, %whileBody114.i13 ]
  %strcmpload2 = load i8, ptr %common.ret.op.i6, align 1
  %t43.not = icmp eq i8 %strcmpload2, 0
  br i1 %t43.not, label %end630, label %if631

if631:                                            ; preds = %slice.exit22
  %t46 = tail call ptr @_json_getKey(ptr %t2.084, ptr nonnull %common.ret.op.i6)
  %t50 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t46, ptr noundef nonnull dereferenceable(5) @.str_stdlib_stdlib_33)
  %t51 = icmp eq i32 %t50, 0
  br i1 %t51, label %common.ret, label %end630

common.ret:                                       ; preds = %if631, %whileEnd636, %_json_parseInt.exit, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ @.str_stdlib_stdlib_33, %_json_parseInt.exit ], [ @.str_stdlib_stdlib_33, %if631 ], [ %t2.2.lcssa, %whileEnd636 ]
  ret ptr %common.ret.op

end630:                                           ; preds = %if631, %slice.exit22
  %t2.1 = phi ptr [ %t46, %if631 ], [ %t2.084, %slice.exit22 ]
  %t5675 = tail call i32 @strlen(ptr %t55)
  %t5776 = icmp sgt i32 %t5675, 0
  br i1 %t5776, label %whileBody635, label %whileEnd636

whileBody635:                                     ; preds = %end630, %end644
  %t2.278 = phi ptr [ %t92, %end644 ], [ %t2.1, %end630 ]
  %storemerge4.in.peel = phi i32 [ %t100, %end644 ], [ 0, %end630 ]
  %t3.i23 = tail call i32 @strlen(ptr %t55)
  %t7.i24 = icmp slt i32 %storemerge4.in.peel, 0
  %t10.i25 = icmp sge i32 %storemerge4.in.peel, %t3.i23
  %t5.i26 = select i1 %t7.i24, i1 true, i1 %t10.i25
  br i1 %t5.i26, label %sub_063, label %end116.i27

end116.i27:                                       ; preds = %whileBody635
  %7 = zext nneg i32 %storemerge4.in.peel to i64
  %t14.i28 = getelementptr i8, ptr %t55, i64 %7
  %t15.i29 = load i8, ptr %t14.i28, align 1
  %t16.i30 = tail call ptr @_zen_char_to_string(i8 %t15.i29)
  br label %sub_063

sub_063:                                          ; preds = %end116.i27, %whileBody635
  %common.ret.op.i31 = phi ptr [ %t16.i30, %end116.i27 ], [ @.str_stdlib_stdlib_0, %whileBody635 ]
  %8 = load i8, ptr %common.ret.op.i31, align 1
  %.not89 = icmp eq i8 %8, 91
  br i1 %.not89, label %charAt.exit32.tail, label %whileEnd636

charAt.exit32.tail:                               ; preds = %sub_063
  %9 = getelementptr inbounds nuw i8, ptr %common.ret.op.i31, i64 1
  %10 = load i8, ptr %9, align 1
  %11 = icmp eq i8 %10, 0
  br i1 %11, label %end637, label %whileEnd636

end637:                                           ; preds = %charAt.exit32.tail
  %storemerge4.peel = add nsw i32 %storemerge4.in.peel, 1
  %t70.peel = tail call i32 @strlen(ptr %t55)
  %t71.peel = icmp slt i32 %storemerge4.peel, %t70.peel
  br i1 %t71.peel, label %whileBody640.peel, label %whileEnd641

whileBody640.peel:                                ; preds = %end637
  %t3.i33.peel = tail call i32 @strlen(ptr %t55)
  %t7.i34.peel = icmp slt i32 %storemerge4.in.peel, -1
  %t10.i35.peel = icmp sge i32 %storemerge4.peel, %t3.i33.peel
  %t5.i36.peel = select i1 %t7.i34.peel, i1 true, i1 %t10.i35.peel
  br i1 %t5.i36.peel, label %sub_066.peel, label %end116.i37.peel

end116.i37.peel:                                  ; preds = %whileBody640.peel
  %12 = zext nneg i32 %storemerge4.peel to i64
  %t14.i38.peel = getelementptr i8, ptr %t55, i64 %12
  %t15.i39.peel = load i8, ptr %t14.i38.peel, align 1
  %t16.i40.peel = tail call ptr @_zen_char_to_string(i8 %t15.i39.peel)
  br label %sub_066.peel

sub_066.peel:                                     ; preds = %end116.i37.peel, %whileBody640.peel
  %common.ret.op.i41.peel = phi ptr [ %t16.i40.peel, %end116.i37.peel ], [ @.str_stdlib_stdlib_0, %whileBody640.peel ]
  %13 = load i8, ptr %common.ret.op.i41.peel, align 1
  %.not90.peel = icmp eq i8 %13, 93
  br i1 %.not90.peel, label %charAt.exit42.tail.peel, label %whileCond639.peel.next

charAt.exit42.tail.peel:                          ; preds = %sub_066.peel
  %14 = getelementptr inbounds nuw i8, ptr %common.ret.op.i41.peel, i64 1
  %15 = load i8, ptr %14, align 1
  %16 = icmp eq i8 %15, 0
  br i1 %16, label %whileEnd641, label %whileCond639.peel.next

whileCond639.peel.next:                           ; preds = %sub_066.peel, %charAt.exit42.tail.peel
  %storemerge499 = add nsw i32 %storemerge4.in.peel, 2
  %t70100 = tail call i32 @strlen(ptr %t55)
  %t71101 = icmp slt i32 %storemerge499, %t70100
  br i1 %t71101, label %whileBody640, label %whileEnd641

whileBody640:                                     ; preds = %whileCond639.peel.next, %whileCond639.backedge
  %storemerge4103 = phi i32 [ %storemerge4, %whileCond639.backedge ], [ %storemerge499, %whileCond639.peel.next ]
  %storemerge4.in102 = phi i32 [ %storemerge4103, %whileCond639.backedge ], [ %storemerge4.peel, %whileCond639.peel.next ]
  %t3.i33 = tail call i32 @strlen(ptr %t55)
  %t7.i34 = icmp slt i32 %storemerge4.in102, -1
  %t10.i35 = icmp sge i32 %storemerge4103, %t3.i33
  %t5.i36 = select i1 %t7.i34, i1 true, i1 %t10.i35
  br i1 %t5.i36, label %sub_066, label %end116.i37

end116.i37:                                       ; preds = %whileBody640
  %17 = zext nneg i32 %storemerge4103 to i64
  %t14.i38 = getelementptr i8, ptr %t55, i64 %17
  %t15.i39 = load i8, ptr %t14.i38, align 1
  %t16.i40 = tail call ptr @_zen_char_to_string(i8 %t15.i39)
  br label %sub_066

sub_066:                                          ; preds = %end116.i37, %whileBody640
  %common.ret.op.i41 = phi ptr [ %t16.i40, %end116.i37 ], [ @.str_stdlib_stdlib_0, %whileBody640 ]
  %18 = load i8, ptr %common.ret.op.i41, align 1
  %.not90 = icmp eq i8 %18, 93
  br i1 %.not90, label %sub_167, label %whileCond639.backedge

sub_167:                                          ; preds = %sub_066
  %19 = getelementptr inbounds nuw i8, ptr %common.ret.op.i41, i64 1
  %20 = load i8, ptr %19, align 1
  %21 = icmp eq i8 %20, 0
  br i1 %21, label %whileEnd641, label %whileCond639.backedge

whileCond639.backedge:                            ; preds = %sub_066, %sub_167
  %storemerge4 = add nsw i32 %storemerge4103, 1
  %t70 = tail call i32 @strlen(ptr %t55)
  %t71 = icmp slt i32 %storemerge4, %t70
  br i1 %t71, label %whileBody640, label %whileEnd641, !llvm.loop !2

whileEnd641:                                      ; preds = %sub_167, %whileCond639.backedge, %whileCond639.peel.next, %charAt.exit42.tail.peel, %end637
  %t99 = phi i32 [ %storemerge4.peel, %end637 ], [ %storemerge4.peel, %charAt.exit42.tail.peel ], [ %storemerge499, %whileCond639.peel.next ], [ %storemerge4, %whileCond639.backedge ], [ %storemerge4103, %sub_167 ]
  %t4.i43 = tail call i32 @strlen(ptr %t55)
  %spec.store.select.i44 = tail call i32 @llvm.smax.i32(i32 %storemerge4.peel, i32 0)
  %spec.select.i45 = tail call i32 @llvm.smin.i32(i32 %t99, i32 %t4.i43)
  %t14.i46 = icmp sle i32 %spec.store.select.i44, %spec.select.i45
  %t227.i47 = icmp samesign ult i32 %spec.store.select.i44, %spec.select.i45
  %or.cond.i48 = select i1 %t14.i46, i1 %t227.i47, i1 false
  br i1 %or.cond.i48, label %whileBody114.i50, label %slice.exit59

whileBody114.i50:                                 ; preds = %whileEnd641, %whileBody114.i50
  %storemerge9.i51 = phi i32 [ %t32.i57, %whileBody114.i50 ], [ %spec.store.select.i44, %whileEnd641 ]
  %t3068.i52 = phi ptr [ %t30.i56, %whileBody114.i50 ], [ @.str_stdlib_stdlib_0, %whileEnd641 ]
  %22 = zext nneg i32 %storemerge9.i51 to i64
  %t26.i53 = getelementptr i8, ptr %t55, i64 %22
  %t27.i54 = load i8, ptr %t26.i53, align 1
  %t28.i55 = tail call ptr @_zen_char_to_string(i8 %t27.i54)
  %t30.i56 = tail call ptr @_str_concat(ptr %t3068.i52, ptr %t28.i55)
  %t32.i57 = add nuw nsw i32 %storemerge9.i51, 1
  %t22.i58 = icmp slt i32 %t32.i57, %spec.select.i45
  br i1 %t22.i58, label %whileBody114.i50, label %slice.exit59

slice.exit59:                                     ; preds = %whileBody114.i50, %whileEnd641
  %common.ret.op.i49 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd641 ], [ %t30.i56, %whileBody114.i50 ]
  %t54.i = tail call i32 @strlen(ptr %common.ret.op.i49)
  %t65.i = icmp sgt i32 %t54.i, 0
  br i1 %t65.i, label %whileBody618.i, label %_json_parseInt.exit

whileBody618.i:                                   ; preds = %slice.exit59, %charAt.exit.i
  %t2.07.i = phi i32 [ %t18.i, %charAt.exit.i ], [ 0, %slice.exit59 ]
  %t1.06.i = phi i32 [ %t16.i61, %charAt.exit.i ], [ 0, %slice.exit59 ]
  %t3.i.i = tail call i32 @strlen(ptr %common.ret.op.i49)
  %t10.i.not.i = icmp slt i32 %t2.07.i, %t3.i.i
  br i1 %t10.i.not.i, label %end116.i.i, label %charAt.exit.i

end116.i.i:                                       ; preds = %whileBody618.i
  %23 = zext nneg i32 %t2.07.i to i64
  %t14.i.i = getelementptr i8, ptr %common.ret.op.i49, i64 %23
  %t15.i.i = load i8, ptr %t14.i.i, align 1
  %t16.i.i = tail call ptr @_zen_char_to_string(i8 %t15.i.i)
  br label %charAt.exit.i

charAt.exit.i:                                    ; preds = %end116.i.i, %whileBody618.i
  %common.ret.op.i.i = phi ptr [ %t16.i.i, %end116.i.i ], [ @.str_stdlib_stdlib_0, %whileBody618.i ]
  %t11.i = tail call i32 @_string_to_int_ascii(ptr %common.ret.op.i.i)
  %t14.i60 = mul i32 %t1.06.i, 10
  %t12.i = add i32 %t14.i60, -48
  %t16.i61 = add i32 %t12.i, %t11.i
  %t18.i = add nuw nsw i32 %t2.07.i, 1
  %t5.i62 = tail call i32 @strlen(ptr %common.ret.op.i49)
  %t6.i = icmp slt i32 %t18.i, %t5.i62
  br i1 %t6.i, label %whileBody618.i, label %_json_parseInt.exit

_json_parseInt.exit:                              ; preds = %charAt.exit.i, %slice.exit59
  %t1.0.lcssa.i = phi i32 [ 0, %slice.exit59 ], [ %t16.i61, %charAt.exit.i ]
  %t92 = tail call ptr @_json_getArrayIndex(ptr %t2.278, i32 %t1.0.lcssa.i)
  %t96 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t92, ptr noundef nonnull dereferenceable(5) @.str_stdlib_stdlib_33)
  %t97 = icmp eq i32 %t96, 0
  br i1 %t97, label %common.ret, label %end644

end644:                                           ; preds = %_json_parseInt.exit
  %t100 = add i32 %t99, 1
  %t56 = tail call i32 @strlen(ptr %t55)
  %t57 = icmp slt i32 %t100, %t56
  br i1 %t57, label %whileBody635, label %whileEnd636

whileEnd636:                                      ; preds = %sub_063, %end644, %charAt.exit32.tail, %end630
  %t2.2.lcssa = phi ptr [ %t2.1, %end630 ], [ %t2.278, %sub_063 ], [ %t2.278, %charAt.exit32.tail ], [ %t92, %end644 ]
  %t102 = add i32 %t4.085, 1
  %t8 = tail call ptr @splitAt(ptr %t1, ptr nonnull @.str_stdlib_stdlib_8, i32 %t102)
  %strcmpload = load i8, ptr %t8, align 1
  %t14 = icmp eq i8 %strcmpload, 0
  br i1 %t14, label %common.ret, label %whileCond625.preheader
}

define ptr @split(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t3 = tail call ptr @_zen_list_new(i64 8)
  %t5 = tail call i32 @strlen(ptr %t0)
  %t8 = tail call i32 @strlen(ptr %t1)
  %t11 = icmp eq i32 %t8, 0
  br i1 %t11, label %common.ret, label %end646

common.ret:                                       ; preds = %entry, %whileEnd650
  ret ptr %t3

end646:                                           ; preds = %entry
  %t1813 = icmp sgt i32 %t5, 0
  br i1 %t1813, label %whileBody649.lr.ph, label %whileEnd650

whileBody649.lr.ph:                               ; preds = %end646
  %t24 = sub i32 %t5, %t8
  %t288 = icmp sgt i32 %t8, 0
  br label %whileBody649

whileBody649:                                     ; preds = %whileBody649.lr.ph, %end659
  %storemerge515 = phi i32 [ 0, %whileBody649.lr.ph ], [ %t65, %end659 ]
  %t631114 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody649.lr.ph ], [ %t6312, %end659 ]
  %t25.not = icmp sgt i32 %storemerge515, %t24
  br i1 %t25.not, label %else661, label %whileCond654.preheader

whileCond654.preheader:                           ; preds = %whileBody649
  br i1 %t288, label %whileBody655, label %if660

whileBody655:                                     ; preds = %whileCond654.preheader, %whileBody655
  %t4779 = phi i32 [ %t47, %whileBody655 ], [ 0, %whileCond654.preheader ]
  %0 = phi i1 [ %spec.select, %whileBody655 ], [ true, %whileCond654.preheader ]
  %t32 = add i32 %t4779, %storemerge515
  %1 = sext i32 %t32 to i64
  %t33 = getelementptr i8, ptr %t0, i64 %1
  %t34 = load i8, ptr %t33, align 1
  %t35 = call ptr @_zen_char_to_string(i8 %t34)
  %2 = zext nneg i32 %t4779 to i64
  %t39 = getelementptr i8, ptr %t1, i64 %2
  %t40 = load i8, ptr %t39, align 1
  %t41 = call ptr @_zen_char_to_string(i8 %t40)
  %t44 = call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t35, ptr noundef nonnull dereferenceable(1) %t41)
  %t45.not = icmp eq i32 %t44, 0
  %spec.select = select i1 %t45.not, i1 %0, i1 false
  %t47 = add nuw nsw i32 %t4779, 1
  %t28 = icmp slt i32 %t47, %t8
  br i1 %t28, label %whileBody655, label %end651

end651:                                           ; preds = %whileBody655
  br i1 %spec.select, label %if660, label %else661

if660:                                            ; preds = %whileCond654.preheader, %end651
  %t51 = alloca ptr, align 8
  store ptr %t631114, ptr %t51, align 8
  call void @_zen_list_push(ptr %t3, ptr nonnull %t51)
  br label %end659

else661:                                          ; preds = %whileBody649, %end651
  %3 = sext i32 %storemerge515 to i64
  %t59 = getelementptr i8, ptr %t0, i64 %3
  %t60 = load i8, ptr %t59, align 1
  %t61 = call ptr @_zen_char_to_string(i8 %t60)
  %t63 = call ptr @_str_concat(ptr %t631114, ptr %t61)
  br label %end659

end659:                                           ; preds = %else661, %if660
  %.sink = phi i32 [ 1, %else661 ], [ %t8, %if660 ]
  %t6312 = phi ptr [ %t63, %else661 ], [ @.str_stdlib_stdlib_0, %if660 ]
  %t65 = add i32 %storemerge515, %.sink
  %t18 = icmp slt i32 %t65, %t5
  br i1 %t18, label %whileBody649, label %whileEnd650

whileEnd650:                                      ; preds = %end659, %end646
  %t6311.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %end646 ], [ %t6312, %end659 ]
  %t68 = alloca ptr, align 8
  store ptr %t6311.lcssa, ptr %t68, align 8
  call void @_zen_list_push(ptr %t3, ptr nonnull %t68)
  br label %common.ret
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #5

attributes #0 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: read) }
attributes #1 = { mustprogress nofree norecurse nosync nounwind willreturn memory(none) }
attributes #2 = { nofree norecurse nosync nounwind memory(none) }
attributes #3 = { mustprogress nofree norecurse nosync nounwind willreturn memory(readwrite, argmem: none, inaccessiblemem: none) }
attributes #4 = { mustprogress nofree norecurse nosync nounwind willreturn memory(argmem: read) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.peeled.count", i32 1}
!2 = distinct !{!2, !1}
