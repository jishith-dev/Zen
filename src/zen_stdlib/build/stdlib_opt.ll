; ModuleID = '/storage/emulated/0/zen/src/zen_stdlib/build/stdlib.ll'
source_filename = "/storage/emulated/0/zen/src/zen_stdlib/build/stdlib.ll"

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
@.str_stdlib_stdlib_32 = private unnamed_addr constant [5 x i8] c"null\00"

declare void @zen_list_push(ptr, ptr) local_unnamed_addr

declare ptr @zen_list_new(i64) local_unnamed_addr

declare ptr @int_to_string_ascii(i32) local_unnamed_addr

declare i32 @string_to_int_ascii(ptr) local_unnamed_addr

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: read)
declare i32 @strcmp(ptr captures(none), ptr captures(none)) local_unnamed_addr #0

declare ptr @str_concat(ptr, ptr) local_unnamed_addr

declare ptr @zen_char_to_string(i8) local_unnamed_addr

declare i32 @strlen(ptr) local_unnamed_addr

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isEven(i32 %t0) local_unnamed_addr #1 {
entry:
  %0 = and i32 %t0, 1
  %t4 = icmp eq i32 %0, 0
  ret i1 %t4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isOdd(i32 %t0) local_unnamed_addr #1 {
entry:
  %0 = and i32 %t0, 1
  %t4 = icmp ne i32 %0, 0
  ret i1 %t4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isPositive(i32 %t0) local_unnamed_addr #1 {
entry:
  %t3 = icmp sgt i32 %t0, 0
  ret i1 %t3
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @isNegative(i32 %t0) local_unnamed_addr #1 {
entry:
  %t3 = icmp slt i32 %t0, 0
  ret i1 %t3
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
  %t8 = icmp slt i32 %t0, %t1
  %t2.t0 = tail call i32 @llvm.smin.i32(i32 %t0, i32 %t2)
  %common.ret.op = select i1 %t8, i32 %t1, i32 %t2.t0
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define range(i32 -1, 2) i32 @sign(i32 %t0) local_unnamed_addr #1 {
entry:
  %t0.lobit = ashr i32 %t0, 31
  %t3.inv = icmp slt i32 %t0, 1
  %common.ret.op = select i1 %t3.inv, i32 %t0.lobit, i32 1
  ret i32 %common.ret.op
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @pow(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t5 = icmp eq i32 %t1, 0
  br i1 %t5, label %common.ret, label %end14

common.ret:                                       ; preds = %whileBody29, %whileEnd30, %end14, %if17, %if23, %entry, %if34
  %common.ret.op = phi double [ %t41, %if34 ], [ 1.000000e+00, %entry ], [ %., %if23 ], [ %spec.select, %if17 ], [ 1.000000e+00, %end14 ], [ %t32, %whileEnd30 ], [ %t34, %whileBody29 ]
  ret double %common.ret.op

end14:                                            ; preds = %entry
  switch i32 %t0, label %end22 [
    i32 0, label %if17
    i32 1, label %common.ret
    i32 -1, label %if23
  ]

if17:                                             ; preds = %end14
  %t9 = icmp sgt i32 %t1, 0
  %t10 = load double, ptr @INF, align 8
  %spec.select = select i1 %t9, double 0.000000e+00, double %t10
  br label %common.ret

if23:                                             ; preds = %end14
  %0 = and i32 %t1, 1
  %t17 = icmp eq i32 %0, 0
  %. = select i1 %t17, double 1.000000e+00, double -1.000000e+00
  br label %common.ret

end22:                                            ; preds = %end14
  %t20 = icmp slt i32 %t1, 0
  br i1 %t20, label %end26, label %whileBody29.lr.ph

end26:                                            ; preds = %end22
  %t23 = sub i32 0, %t1
  %t2812 = icmp sgt i32 %t23, 0
  br i1 %t2812, label %whileBody29.lr.ph, label %if34

whileBody29.lr.ph:                                ; preds = %end22, %end26
  %exp.addr.019 = phi i32 [ %t23, %end26 ], [ %t1, %end22 ]
  %t31 = sitofp i32 %t0 to double
  %t34 = load double, ptr @INF, align 8
  br label %whileBody29

whileCond28:                                      ; preds = %whileBody29
  %t38 = add nuw nsw i32 %storemerge14, 1
  %t28 = icmp samesign ult i32 %t38, %exp.addr.019
  br i1 %t28, label %whileBody29, label %whileEnd30

whileBody29:                                      ; preds = %whileBody29.lr.ph, %whileCond28
  %storemerge14 = phi i32 [ 0, %whileBody29.lr.ph ], [ %t38, %whileCond28 ]
  %t321113 = phi double [ 1.000000e+00, %whileBody29.lr.ph ], [ %t32, %whileCond28 ]
  %t32 = fmul double %t321113, %t31
  %t35 = fcmp oeq double %t32, %t34
  br i1 %t35, label %common.ret, label %whileCond28

whileEnd30:                                       ; preds = %whileCond28
  br i1 %t20, label %if34, label %common.ret

if34:                                             ; preds = %end26, %whileEnd30
  %t4021 = phi double [ %t32, %whileEnd30 ], [ 1.000000e+00, %end26 ]
  %t41 = fdiv double 1.000000e+00, %t4021
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define i32 @sqrt(i32 %t0) local_unnamed_addr #2 {
entry:
  %t3 = icmp slt i32 %t0, 0
  br i1 %t3, label %common.ret, label %whileCond37

common.ret:                                       ; preds = %entry, %whileEnd39
  %common.ret.op = phi i32 [ %t13, %whileEnd39 ], [ -1, %entry ]
  ret i32 %common.ret.op

whileCond37:                                      ; preds = %entry, %whileCond37
  %storemerge = phi i32 [ %t11, %whileCond37 ], [ 1, %entry ]
  %t7 = mul i32 %storemerge, %storemerge
  %t9.not = icmp sgt i32 %t7, %t0
  %t11 = add i32 %storemerge, 1
  br i1 %t9.not, label %whileEnd39, label %whileCond37

whileEnd39:                                       ; preds = %whileCond37
  %t13 = add i32 %storemerge, -1
  br label %common.ret
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @square(i32 %t0) local_unnamed_addr #1 {
entry:
  %t4 = mul i32 %t0, %t0
  ret i32 %t4
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @cube(i32 %t0) local_unnamed_addr #1 {
entry:
  %t4 = mul i32 %t0, %t0
  %t6 = mul i32 %t4, %t0
  ret i32 %t6
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @floor(double %t0) local_unnamed_addr #1 {
entry:
  %t3 = fptosi double %t0 to i32
  %t7 = fcmp olt double %t0, 0.000000e+00
  %t12 = sitofp i32 %t3 to double
  %t11 = fcmp one double %t0, %t12
  %t5 = select i1 %t7, i1 %t11, i1 false
  %t14 = sext i1 %t5 to i32
  %common.ret.op = add i32 %t14, %t3
  ret i32 %common.ret.op
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @ceil(double %t0) local_unnamed_addr #1 {
entry:
  %t3 = fptosi double %t0 to i32
  %t8 = sitofp i32 %t3 to double
  %t7 = fcmp une double %t0, %t8
  %t11 = fcmp ogt double %t0, 0.000000e+00
  %or.cond = and i1 %t11, %t7
  %t14 = zext i1 %or.cond to i32
  %spec.select = add i32 %t14, %t3
  ret i32 %spec.select
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @round(double %t0) local_unnamed_addr #1 {
entry:
  %t3 = fptosi double %t0 to i32
  %t8 = sitofp i32 %t3 to double
  %t9 = fsub double %t0, %t8
  %t11 = fcmp ult double %t0, 0.000000e+00
  br i1 %t11, label %end49, label %if50

if50:                                             ; preds = %entry
  %t14 = fcmp ult double %t9, 5.000000e-01
  br i1 %t14, label %common.ret, label %if52

common.ret:                                       ; preds = %end49, %if50, %if54, %if52
  %common.ret.op = phi i32 [ %t16, %if52 ], [ %t21, %if54 ], [ %t3, %if50 ], [ %t3, %end49 ]
  ret i32 %common.ret.op

if52:                                             ; preds = %if50
  %t16 = add i32 %t3, 1
  br label %common.ret

end49:                                            ; preds = %entry
  %t19 = fcmp ugt double %t9, -5.000000e-01
  br i1 %t19, label %common.ret, label %if54

if54:                                             ; preds = %end49
  %t21 = add i32 %t3, -1
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @toFixed(double %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t5 = icmp slt i32 %t1, 0
  br i1 %t5, label %common.ret, label %end55

common.ret:                                       ; preds = %entry, %round.exit
  %common.ret.op = phi double [ %t20, %round.exit ], [ %t0, %entry ]
  ret double %common.ret.op

end55:                                            ; preds = %entry
  %t5.i = icmp eq i32 %t1, 0
  br i1 %t5.i, label %pow.exit, label %whileBody29.lr.ph.i

whileBody29.lr.ph.i:                              ; preds = %end55
  %t34.i = load double, ptr @INF, align 8
  br label %whileBody29.i

whileCond28.i:                                    ; preds = %whileBody29.i
  %t38.i = add nuw nsw i32 %storemerge14.i, 1
  %t28.i = icmp samesign ult i32 %t38.i, %t1
  br i1 %t28.i, label %whileBody29.i, label %pow.exit

whileBody29.i:                                    ; preds = %whileCond28.i, %whileBody29.lr.ph.i
  %storemerge14.i = phi i32 [ 0, %whileBody29.lr.ph.i ], [ %t38.i, %whileCond28.i ]
  %t321113.i = phi double [ 1.000000e+00, %whileBody29.lr.ph.i ], [ %t32.i, %whileCond28.i ]
  %t32.i = fmul double %t321113.i, 1.000000e+01
  %t35.i = fcmp oeq double %t32.i, %t34.i
  br i1 %t35.i, label %pow.exit, label %whileCond28.i

pow.exit:                                         ; preds = %whileCond28.i, %whileBody29.i, %end55
  %common.ret.op.i = phi double [ 1.000000e+00, %end55 ], [ %t32.i, %whileCond28.i ], [ %t34.i, %whileBody29.i ]
  %t13 = fmul double %t0, %common.ret.op.i
  %t3.i = fptosi double %t13 to i32
  %t8.i = sitofp i32 %t3.i to double
  %t9.i = fsub double %t13, %t8.i
  %t11.i = fcmp ult double %t13, 0.000000e+00
  br i1 %t11.i, label %end49.i, label %if50.i

if50.i:                                           ; preds = %pow.exit
  %t14.i = fcmp ult double %t9.i, 5.000000e-01
  br i1 %t14.i, label %round.exit, label %if52.i

if52.i:                                           ; preds = %if50.i
  %t16.i = add i32 %t3.i, 1
  br label %round.exit

end49.i:                                          ; preds = %pow.exit
  %t19.i = fcmp ugt double %t9.i, -5.000000e-01
  br i1 %t19.i, label %round.exit, label %if54.i

if54.i:                                           ; preds = %end49.i
  %t21.i = add i32 %t3.i, -1
  br label %round.exit

round.exit:                                       ; preds = %if50.i, %if52.i, %end49.i, %if54.i
  %common.ret.op.i3 = phi i32 [ %t16.i, %if52.i ], [ %t21.i, %if54.i ], [ %t3.i, %if50.i ], [ %t3.i, %end49.i ]
  %t19 = sitofp i32 %common.ret.op.i3 to double
  %t20 = fdiv double %t19, %common.ret.op.i
  br label %common.ret
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i32 @mod(i32 %t0, i32 %t1) local_unnamed_addr #1 {
entry:
  %spec.select = tail call i32 @llvm.abs.i32(i32 %t1, i1 false)
  %t11 = srem i32 %t0, %spec.select
  %t13 = icmp slt i32 %t11, 0
  %t16 = select i1 %t13, i32 %spec.select, i32 0
  %common.ret.op = add i32 %t16, %t11
  ret i32 %common.ret.op
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define range(i32 0, -2147483648) i32 @gcd(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t5 = tail call i32 @llvm.abs.i32(i32 %t0, i1 true)
  %t9.not8 = icmp eq i32 %t1, 0
  br i1 %t9.not8, label %whileEnd63, label %whileBody62.preheader

whileBody62.preheader:                            ; preds = %entry
  %t7 = tail call i32 @llvm.abs.i32(i32 %t1, i1 true)
  br label %whileBody62

whileBody62:                                      ; preds = %whileBody62.preheader, %whileBody62
  %b.addr.010 = phi i32 [ %t14, %whileBody62 ], [ %t7, %whileBody62.preheader ]
  %a.addr.09 = phi i32 [ %b.addr.010, %whileBody62 ], [ %t5, %whileBody62.preheader ]
  %t14 = urem i32 %a.addr.09, %b.addr.010
  %t9.not = icmp eq i32 %t14, 0
  br i1 %t9.not, label %whileEnd63, label %whileBody62

whileEnd63:                                       ; preds = %whileBody62, %entry
  %a.addr.0.lcssa = phi i32 [ %t5, %entry ], [ %b.addr.010, %whileBody62 ]
  ret i32 %a.addr.0.lcssa
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define range(i32 0, -2147483648) i32 @lcm(i32 %t0, i32 %t1) local_unnamed_addr #2 {
entry:
  %t6 = icmp eq i32 %t0, 0
  %t8 = icmp eq i32 %t1, 0
  %t4 = select i1 %t6, i1 true, i1 %t8
  br i1 %t4, label %common.ret, label %whileBody62.preheader.i

common.ret:                                       ; preds = %entry, %gcd.exit
  %common.ret.op = phi i32 [ %t16, %gcd.exit ], [ 0, %entry ]
  ret i32 %common.ret.op

whileBody62.preheader.i:                          ; preds = %entry
  %t5.i = tail call i32 @llvm.abs.i32(i32 %t0, i1 true)
  %t7.i = tail call i32 @llvm.abs.i32(i32 %t1, i1 true)
  br label %whileBody62.i

whileBody62.i:                                    ; preds = %whileBody62.i, %whileBody62.preheader.i
  %b.addr.010.i = phi i32 [ %t14.i, %whileBody62.i ], [ %t7.i, %whileBody62.preheader.i ]
  %a.addr.09.i = phi i32 [ %b.addr.010.i, %whileBody62.i ], [ %t5.i, %whileBody62.preheader.i ]
  %t14.i = urem i32 %a.addr.09.i, %b.addr.010.i
  %t9.not.i = icmp eq i32 %t14.i, 0
  br i1 %t9.not.i, label %gcd.exit, label %whileBody62.i

gcd.exit:                                         ; preds = %whileBody62.i
  %t13 = sdiv i32 %t0, %b.addr.010.i
  %t15 = mul i32 %t13, %t1
  %t16 = tail call i32 @llvm.abs.i32(i32 %t15, i1 true)
  br label %common.ret
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @factorial(i32 %t0) local_unnamed_addr #2 {
entry:
  %t3 = icmp slt i32 %t0, 0
  br i1 %t3, label %common.ret, label %end69

common.ret:                                       ; preds = %whileBody74, %end69, %entry
  %common.ret.op = phi double [ -1.000000e+00, %entry ], [ 1.000000e+00, %end69 ], [ %t14, %whileBody74 ]
  ret double %common.ret.op

end69:                                            ; preds = %entry
  %t5 = icmp eq i32 %t0, 0
  br i1 %t5, label %common.ret, label %whileBody74

whileBody74:                                      ; preds = %end69, %whileBody74
  %storemerge7 = phi i32 [ %t16, %whileBody74 ], [ 1, %end69 ]
  %t1446 = phi double [ %t14, %whileBody74 ], [ 1.000000e+00, %end69 ]
  %t13 = sitofp i32 %storemerge7 to double
  %t14 = fmul double %t1446, %t13
  %t16 = add i32 %storemerge7, 1
  %t10.not = icmp sgt i32 %t16, %t0
  br i1 %t10.not, label %common.ret, label %whileBody74
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define noundef i1 @isPrime(i32 %t0) local_unnamed_addr #2 {
entry:
  %t3 = icmp slt i32 %t0, 2
  br i1 %t3, label %common.ret, label %end76

common.ret:                                       ; preds = %whileEnd39.i, %whileBody83, %end78, %end76, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %end76 ], [ false, %end78 ], [ %t12.not, %whileBody83 ], [ %t12.not, %whileEnd39.i ]
  ret i1 %common.ret.op

end76:                                            ; preds = %entry
  %t5 = icmp eq i32 %t0, 2
  br i1 %t5, label %common.ret, label %end78

end78:                                            ; preds = %end76
  %0 = and i32 %t0, 1
  %t4.i = icmp eq i32 %0, 0
  br i1 %t4.i, label %common.ret, label %whileCond82

whileCond82:                                      ; preds = %end78, %whileBody83
  %storemerge = phi i32 [ %t18, %whileBody83 ], [ 3, %end78 ]
  br label %whileCond37.i

whileCond37.i:                                    ; preds = %whileCond82, %whileCond37.i
  %storemerge.i = phi i32 [ %t11.i, %whileCond37.i ], [ 1, %whileCond82 ]
  %t7.i = mul i32 %storemerge.i, %storemerge.i
  %t9.not.i = icmp sgt i32 %t7.i, %t0
  %t11.i = add i32 %storemerge.i, 1
  br i1 %t9.not.i, label %whileEnd39.i, label %whileCond37.i

whileEnd39.i:                                     ; preds = %whileCond37.i
  %t13.i = add i32 %storemerge.i, -1
  %t12.not = icmp sgt i32 %storemerge, %t13.i
  br i1 %t12.not, label %common.ret, label %whileBody83

whileBody83:                                      ; preds = %whileEnd39.i
  %t15 = srem i32 %t0, %storemerge
  %t16 = icmp eq i32 %t15, 0
  %t18 = add i32 %storemerge, 2
  br i1 %t16, label %common.ret, label %whileCond82
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @lerp(double %t0, double %t1, double %t2) local_unnamed_addr #1 {
entry:
  %t9 = fsub double %t1, %t0
  %t11 = fmul double %t9, %t2
  %t12 = fadd double %t0, %t11
  ret double %t12
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @normalize(double %t0, double %t1, double %t2) local_unnamed_addr #1 {
entry:
  %t8 = fcmp oeq double %t1, %t2
  br i1 %t8, label %common.ret, label %end87

common.ret:                                       ; preds = %entry, %end87
  %common.ret.op = phi double [ %t15, %end87 ], [ 0.000000e+00, %entry ]
  ret double %common.ret.op

end87:                                            ; preds = %entry
  %t11 = fsub double %t0, %t1
  %t14 = fsub double %t2, %t1
  %t15 = fdiv double %t11, %t14
  br label %common.ret
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define i1 @between(i32 %t0, i32 %t1, i32 %t2) local_unnamed_addr #1 {
entry:
  %t9 = icmp sge i32 %t0, %t1
  %t12 = icmp sle i32 %t0, %t2
  %t6 = select i1 %t9, i1 %t12, i1 false
  ret i1 %t6
}

define ptr @reverse(ptr %t0) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t7.03 = add i32 %t3, -1
  %t114 = icmp sgt i32 %t7.03, -1
  br i1 %t114, label %whileBody93, label %whileEnd94

whileBody93:                                      ; preds = %entry, %whileBody93
  %t7.06 = phi i32 [ %t7.0, %whileBody93 ], [ %t7.03, %entry ]
  %t5.05 = phi ptr [ %t19, %whileBody93 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %t7.06 to i64
  %t15 = getelementptr i8, ptr %t0, i64 %0
  %t16 = load i8, ptr %t15, align 1
  %t17 = tail call ptr @zen_char_to_string(i8 %t16)
  %t19 = tail call ptr @str_concat(ptr %t5.05, ptr %t17)
  %t7.0 = add nsw i32 %t7.06, -1
  %t11.not = icmp eq i32 %t7.06, 0
  br i1 %t11.not, label %whileEnd94, label %whileBody93

whileEnd94:                                       ; preds = %whileBody93, %entry
  %t5.0.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t19, %whileBody93 ]
  ret ptr %t5.0.lcssa
}

define i32 @indexOf(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t8 = tail call i32 @strlen(ptr %t1)
  %t11 = icmp eq i32 %t8, 0
  br i1 %t11, label %common.ret, label %whileCond97.preheader

whileCond97.preheader:                            ; preds = %entry
  %t16 = sub i32 %t5, %t8
  %t17.not6 = icmp slt i32 %t16, 0
  br i1 %t17.not6, label %common.ret, label %whileBody98.lr.ph

whileBody98.lr.ph:                                ; preds = %whileCond97.preheader
  %t224 = icmp sgt i32 %t8, 0
  br label %whileBody98

common.ret:                                       ; preds = %whileBody98, %end105, %whileEnd102, %whileCond97.preheader, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ -1, %whileCond97.preheader ], [ %storemerge7, %whileBody98 ], [ -1, %end105 ], [ %storemerge7, %whileEnd102 ]
  ret i32 %common.ret.op

whileBody98:                                      ; preds = %whileBody98.lr.ph, %end105
  %storemerge7 = phi i32 [ 0, %whileBody98.lr.ph ], [ %t45, %end105 ]
  br i1 %t224, label %whileBody101, label %common.ret

whileBody101:                                     ; preds = %whileBody98, %whileBody101
  %storemerge35 = phi i32 [ %t41, %whileBody101 ], [ 0, %whileBody98 ]
  %0 = phi i1 [ %spec.select, %whileBody101 ], [ true, %whileBody98 ]
  %t26 = add i32 %storemerge35, %storemerge7
  %1 = sext i32 %t26 to i64
  %t27 = getelementptr i8, ptr %t0, i64 %1
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @zen_char_to_string(i8 %t28)
  %2 = zext nneg i32 %storemerge35 to i64
  %t33 = getelementptr i8, ptr %t1, i64 %2
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @zen_char_to_string(i8 %t34)
  %t38 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t29, ptr noundef nonnull dereferenceable(1) %t35)
  %t39.not = icmp eq i32 %t38, 0
  %spec.select = select i1 %t39.not, i1 %0, i1 false
  %t41 = add nuw nsw i32 %storemerge35, 1
  %t22 = icmp slt i32 %t41, %t8
  br i1 %t22, label %whileBody101, label %whileEnd102

whileEnd102:                                      ; preds = %whileBody101
  br i1 %spec.select, label %common.ret, label %end105

end105:                                           ; preds = %whileEnd102
  %t45 = add i32 %storemerge7, 1
  %t17.not = icmp sgt i32 %t45, %t16
  br i1 %t17.not, label %common.ret, label %whileBody98
}

define ptr @slice(ptr %t0, i32 %t1, i32 %t2) local_unnamed_addr {
entry:
  %t7 = tail call i32 @strlen(ptr %t0)
  %spec.store.select = tail call i32 @llvm.smax.i32(i32 %t1, i32 0)
  %spec.select = tail call i32 @llvm.smin.i32(i32 %t2, i32 %t7)
  %t17 = icmp sle i32 %spec.store.select, %spec.select
  %t259 = icmp samesign ult i32 %spec.store.select, %spec.select
  %or.cond = select i1 %t17, i1 %t259, i1 false
  br i1 %or.cond, label %whileBody114, label %common.ret

common.ret:                                       ; preds = %whileBody114, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t33, %whileBody114 ]
  ret ptr %common.ret.op

whileBody114:                                     ; preds = %entry, %whileBody114
  %storemerge11 = phi i32 [ %t35, %whileBody114 ], [ %spec.store.select, %entry ]
  %t33810 = phi ptr [ %t33, %whileBody114 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %storemerge11 to i64
  %t29 = getelementptr i8, ptr %t0, i64 %0
  %t30 = load i8, ptr %t29, align 1
  %t31 = tail call ptr @zen_char_to_string(i8 %t30)
  %t33 = tail call ptr @str_concat(ptr %t33810, ptr %t31)
  %t35 = add nuw nsw i32 %storemerge11, 1
  %t25 = icmp slt i32 %t35, %spec.select
  br i1 %t25, label %whileBody114, label %common.ret
}

define ptr @charAt(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t9 = icmp slt i32 %t1, 0
  %t12 = icmp sge i32 %t1, %t5
  %t7 = select i1 %t9, i1 true, i1 %t12
  br i1 %t7, label %common.ret, label %end116

common.ret:                                       ; preds = %entry, %end116
  %common.ret.op = phi ptr [ %t18, %end116 ], [ @.str_stdlib_stdlib_0, %entry ]
  ret ptr %common.ret.op

end116:                                           ; preds = %entry
  %0 = zext nneg i32 %t1 to i64
  %t16 = getelementptr i8, ptr %t0, i64 %0
  %t17 = load i8, ptr %t16, align 1
  %t18 = tail call ptr @zen_char_to_string(i8 %t17)
  br label %common.ret
}

define ptr @replace(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t7 = tail call i32 @strlen(ptr %t0)
  %t10 = tail call i32 @strlen(ptr %t1)
  %t13 = icmp eq i32 %t10, 0
  br i1 %t13, label %common.ret, label %whileCond123.preheader

whileCond123.preheader:                           ; preds = %entry
  %t19 = sub i32 %t7, %t10
  %t20.not11 = icmp slt i32 %t19, 0
  br i1 %t20.not11, label %common.ret, label %whileBody124.lr.ph

whileBody124.lr.ph:                               ; preds = %whileCond123.preheader
  %t259 = icmp sgt i32 %t10, 0
  br label %whileBody124

common.ret:                                       ; preds = %end131, %whileBody137, %whileEnd135, %whileCond123.preheader, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t0, %whileCond123.preheader ], [ %t64, %whileEnd135 ], [ %t81, %whileBody137 ], [ %t0, %end131 ]
  ret ptr %common.ret.op

whileBody124:                                     ; preds = %whileBody124.lr.ph, %end131
  %storemerge12 = phi i32 [ 0, %whileBody124.lr.ph ], [ %t86, %end131 ]
  br i1 %t259, label %whileBody127, label %if132

whileBody127:                                     ; preds = %whileBody124, %whileBody127
  %storemerge510 = phi i32 [ %t44, %whileBody127 ], [ 0, %whileBody124 ]
  %0 = phi i1 [ %spec.select, %whileBody127 ], [ true, %whileBody124 ]
  %t29 = add i32 %storemerge510, %storemerge12
  %1 = sext i32 %t29 to i64
  %t30 = getelementptr i8, ptr %t0, i64 %1
  %t31 = load i8, ptr %t30, align 1
  %t32 = tail call ptr @zen_char_to_string(i8 %t31)
  %2 = zext nneg i32 %storemerge510 to i64
  %t36 = getelementptr i8, ptr %t1, i64 %2
  %t37 = load i8, ptr %t36, align 1
  %t38 = tail call ptr @zen_char_to_string(i8 %t37)
  %t41 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t32, ptr noundef nonnull dereferenceable(1) %t38)
  %t42.not = icmp eq i32 %t41, 0
  %spec.select = select i1 %t42.not, i1 %0, i1 false
  %t44 = add nuw nsw i32 %storemerge510, 1
  %t25 = icmp slt i32 %t44, %t10
  br i1 %t25, label %whileBody127, label %whileEnd128

whileEnd128:                                      ; preds = %whileBody127
  br i1 %spec.select, label %if132, label %end131

if132:                                            ; preds = %whileBody124, %whileEnd128
  %t5114 = icmp sgt i32 %storemerge12, 0
  br i1 %t5114, label %whileBody134, label %whileEnd135

whileBody134:                                     ; preds = %if132, %whileBody134
  %storemerge616 = phi i32 [ %t61, %whileBody134 ], [ 0, %if132 ]
  %t591315 = phi ptr [ %t59, %whileBody134 ], [ @.str_stdlib_stdlib_0, %if132 ]
  %3 = zext nneg i32 %storemerge616 to i64
  %t55 = getelementptr i8, ptr %t0, i64 %3
  %t56 = load i8, ptr %t55, align 1
  %t57 = tail call ptr @zen_char_to_string(i8 %t56)
  %t59 = tail call ptr @str_concat(ptr %t591315, ptr %t57)
  %t61 = add nuw nsw i32 %storemerge616, 1
  %t51 = icmp slt i32 %t61, %storemerge12
  br i1 %t51, label %whileBody134, label %whileEnd135

whileEnd135:                                      ; preds = %whileBody134, %if132
  %t5913.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %if132 ], [ %t59, %whileBody134 ]
  %t64 = tail call ptr @str_concat(ptr %t5913.lcssa, ptr %t2)
  %t66 = tail call i32 @strlen(ptr %t2)
  %t70 = add i32 %storemerge12, %t10
  %t7320 = icmp slt i32 %t70, %t7
  br i1 %t7320, label %whileBody137, label %common.ret

whileBody137:                                     ; preds = %whileEnd135, %whileBody137
  %storemerge722 = phi i32 [ %t83, %whileBody137 ], [ %t70, %whileEnd135 ]
  %t811921 = phi ptr [ %t81, %whileBody137 ], [ %t64, %whileEnd135 ]
  %4 = sext i32 %storemerge722 to i64
  %t77 = getelementptr i8, ptr %t0, i64 %4
  %t78 = load i8, ptr %t77, align 1
  %t79 = tail call ptr @zen_char_to_string(i8 %t78)
  %t81 = tail call ptr @str_concat(ptr %t811921, ptr %t79)
  %t83 = add nsw i32 %storemerge722, 1
  %t73 = icmp slt i32 %t83, %t7
  br i1 %t73, label %whileBody137, label %common.ret

end131:                                           ; preds = %whileEnd128
  %t86 = add i32 %storemerge12, 1
  %t20.not = icmp sgt i32 %t86, %t19
  br i1 %t20.not, label %common.ret, label %whileBody124
}

define ptr @replaceAll(ptr %t0, ptr %t1, ptr %t2) local_unnamed_addr {
entry:
  %t7 = tail call i32 @strlen(ptr %t0)
  %t10 = tail call i32 @strlen(ptr %t1)
  %t13 = icmp eq i32 %t10, 0
  br i1 %t13, label %common.ret, label %end139

common.ret:                                       ; preds = %end152, %end139, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ @.str_stdlib_stdlib_0, %end139 ], [ %t64, %end152 ]
  ret ptr %common.ret.op

end139:                                           ; preds = %entry
  %t2013 = icmp sgt i32 %t7, 0
  br i1 %t2013, label %whileBody142.lr.ph, label %common.ret

whileBody142.lr.ph:                               ; preds = %end139
  %t26 = sub i32 %t7, %t10
  %t308 = icmp sgt i32 %t10, 0
  br label %whileBody142

whileBody142:                                     ; preds = %whileBody142.lr.ph, %end152
  %storemerge515 = phi i32 [ 0, %whileBody142.lr.ph ], [ %t66, %end152 ]
  %t641114 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody142.lr.ph ], [ %t64, %end152 ]
  %t27.not = icmp sgt i32 %storemerge515, %t26
  br i1 %t27.not, label %else154, label %whileCond147.preheader

whileCond147.preheader:                           ; preds = %whileBody142
  br i1 %t308, label %whileBody148, label %end152

whileBody148:                                     ; preds = %whileCond147.preheader, %whileBody148
  %t4979 = phi i32 [ %t49, %whileBody148 ], [ 0, %whileCond147.preheader ]
  %0 = phi i1 [ %spec.select, %whileBody148 ], [ true, %whileCond147.preheader ]
  %t34 = add i32 %t4979, %storemerge515
  %1 = sext i32 %t34 to i64
  %t35 = getelementptr i8, ptr %t0, i64 %1
  %t36 = load i8, ptr %t35, align 1
  %t37 = tail call ptr @zen_char_to_string(i8 %t36)
  %2 = zext nneg i32 %t4979 to i64
  %t41 = getelementptr i8, ptr %t1, i64 %2
  %t42 = load i8, ptr %t41, align 1
  %t43 = tail call ptr @zen_char_to_string(i8 %t42)
  %t46 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t37, ptr noundef nonnull dereferenceable(1) %t43)
  %t47.not = icmp eq i32 %t46, 0
  %spec.select = select i1 %t47.not, i1 %0, i1 false
  %t49 = add nuw nsw i32 %t4979, 1
  %t30 = icmp slt i32 %t49, %t10
  br i1 %t30, label %whileBody148, label %end144

end144:                                           ; preds = %whileBody148
  br i1 %spec.select, label %end152, label %else154

else154:                                          ; preds = %whileBody142, %end144
  %3 = sext i32 %storemerge515 to i64
  %t60 = getelementptr i8, ptr %t0, i64 %3
  %t61 = load i8, ptr %t60, align 1
  %t62 = tail call ptr @zen_char_to_string(i8 %t61)
  br label %end152

end152:                                           ; preds = %end144, %whileCond147.preheader, %else154
  %t62.sink = phi ptr [ %t62, %else154 ], [ %t2, %whileCond147.preheader ], [ %t2, %end144 ]
  %.sink = phi i32 [ 1, %else154 ], [ %t10, %whileCond147.preheader ], [ %t10, %end144 ]
  %t64 = tail call ptr @str_concat(ptr %t641114, ptr %t62.sink)
  %t66 = add i32 %storemerge515, %.sink
  %t20 = icmp slt i32 %t66, %t7
  br i1 %t20, label %whileBody142, label %common.ret
}

define noundef i1 @contains(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t8 = tail call i32 @strlen(ptr %t1)
  %t11 = icmp eq i32 %t8, 0
  br i1 %t11, label %common.ret, label %whileCond157.preheader

whileCond157.preheader:                           ; preds = %entry
  %t16 = sub i32 %t5, %t8
  %t17.not6 = icmp slt i32 %t16, 0
  br i1 %t17.not6, label %common.ret, label %whileBody158.lr.ph

whileBody158.lr.ph:                               ; preds = %whileCond157.preheader
  %t224 = icmp sgt i32 %t8, 0
  br label %whileBody158

common.ret:                                       ; preds = %whileBody158, %whileEnd162, %whileCond157, %whileCond157.preheader, %entry
  %common.ret.op = phi i1 [ true, %entry ], [ false, %whileCond157.preheader ], [ true, %whileBody158 ], [ true, %whileEnd162 ], [ false, %whileCond157 ]
  ret i1 %common.ret.op

whileCond157:                                     ; preds = %whileEnd162
  %t44 = add i32 %storemerge7, 1
  %t17.not = icmp sgt i32 %t44, %t16
  br i1 %t17.not, label %common.ret, label %whileBody158

whileBody158:                                     ; preds = %whileBody158.lr.ph, %whileCond157
  %storemerge7 = phi i32 [ 0, %whileBody158.lr.ph ], [ %t44, %whileCond157 ]
  br i1 %t224, label %whileBody161, label %common.ret

whileBody161:                                     ; preds = %whileBody158, %whileBody161
  %storemerge35 = phi i32 [ %t41, %whileBody161 ], [ 0, %whileBody158 ]
  %0 = phi i1 [ %spec.select, %whileBody161 ], [ true, %whileBody158 ]
  %t26 = add i32 %storemerge35, %storemerge7
  %1 = sext i32 %t26 to i64
  %t27 = getelementptr i8, ptr %t0, i64 %1
  %t28 = load i8, ptr %t27, align 1
  %t29 = tail call ptr @zen_char_to_string(i8 %t28)
  %2 = zext nneg i32 %storemerge35 to i64
  %t33 = getelementptr i8, ptr %t1, i64 %2
  %t34 = load i8, ptr %t33, align 1
  %t35 = tail call ptr @zen_char_to_string(i8 %t34)
  %t38 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t29, ptr noundef nonnull dereferenceable(1) %t35)
  %t39.not = icmp eq i32 %t38, 0
  %spec.select = select i1 %t39.not, i1 %0, i1 false
  %t41 = add nuw nsw i32 %storemerge35, 1
  %t22 = icmp slt i32 %t41, %t8
  br i1 %t22, label %whileBody161, label %whileEnd162

whileEnd162:                                      ; preds = %whileBody161
  br i1 %spec.select, label %common.ret, label %whileCond157
}

define ptr @upperCase(ptr %t0) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t103 = icmp sgt i32 %t3, 0
  br i1 %t103, label %whileBody168, label %whileEnd169

whileBody168:                                     ; preds = %entry, %end170
  %t7.05 = phi i32 [ %t39, %end170 ], [ 0, %entry ]
  %t5.04 = phi ptr [ %t37, %end170 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %t7.05 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @string_to_int_ascii(ptr %t16)
  %t24 = tail call i32 @string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_1)
  %t28 = tail call i32 @string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_2)
  %t25 = icmp sge i32 %t19, %t24
  %t29 = icmp sle i32 %t19, %t28
  %t21 = select i1 %t25, i1 %t29, i1 false
  br i1 %t21, label %if174, label %end170

if174:                                            ; preds = %whileBody168
  %t32 = add i32 %t19, -32
  %t33 = tail call ptr @int_to_string_ascii(i32 %t32)
  br label %end170

end170:                                           ; preds = %whileBody168, %if174
  %t16.sink = phi ptr [ %t33, %if174 ], [ %t16, %whileBody168 ]
  %t37 = tail call ptr @str_concat(ptr %t5.04, ptr %t16.sink)
  %t39 = add nuw nsw i32 %t7.05, 1
  %t10 = icmp slt i32 %t39, %t3
  br i1 %t10, label %whileBody168, label %whileEnd169

whileEnd169:                                      ; preds = %end170, %entry
  %t5.0.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t37, %end170 ]
  ret ptr %t5.0.lcssa
}

define ptr @lowerCase(ptr %t0) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t103 = icmp sgt i32 %t3, 0
  br i1 %t103, label %whileBody177, label %whileEnd178

whileBody177:                                     ; preds = %entry, %end179
  %t7.05 = phi i32 [ %t39, %end179 ], [ 0, %entry ]
  %t5.04 = phi ptr [ %t37, %end179 ], [ @.str_stdlib_stdlib_0, %entry ]
  %0 = zext nneg i32 %t7.05 to i64
  %t14 = getelementptr i8, ptr %t0, i64 %0
  %t15 = load i8, ptr %t14, align 1
  %t16 = tail call ptr @zen_char_to_string(i8 %t15)
  %t19 = tail call i32 @string_to_int_ascii(ptr %t16)
  %t24 = tail call i32 @string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_3)
  %t28 = tail call i32 @string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_4)
  %t25 = icmp sge i32 %t19, %t24
  %t29 = icmp sle i32 %t19, %t28
  %t21 = select i1 %t25, i1 %t29, i1 false
  br i1 %t21, label %if183, label %end179

if183:                                            ; preds = %whileBody177
  %t32 = add i32 %t19, 32
  %t33 = tail call ptr @int_to_string_ascii(i32 %t32)
  br label %end179

end179:                                           ; preds = %whileBody177, %if183
  %t16.sink = phi ptr [ %t33, %if183 ], [ %t16, %whileBody177 ]
  %t37 = tail call ptr @str_concat(ptr %t5.04, ptr %t16.sink)
  %t39 = add nuw nsw i32 %t7.05, 1
  %t10 = icmp slt i32 %t39, %t3
  br i1 %t10, label %whileBody177, label %whileEnd178

whileEnd178:                                      ; preds = %end179, %entry
  %t5.0.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t37, %end179 ]
  ret ptr %t5.0.lcssa
}

define noundef i1 @startsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t8 = tail call i32 @strlen(ptr %t1)
  %t12 = icmp sgt i32 %t8, %t5
  br i1 %t12, label %common.ret, label %whileCond187.preheader

whileCond187.preheader:                           ; preds = %entry
  %t162 = icmp sgt i32 %t8, 0
  br i1 %t162, label %whileBody188, label %common.ret

common.ret:                                       ; preds = %whileBody188, %whileCond187.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond187.preheader ], [ %t31.not, %whileBody188 ]
  ret i1 %common.ret.op

whileBody188:                                     ; preds = %whileCond187.preheader, %whileBody188
  %storemerge3 = phi i32 [ %t33, %whileBody188 ], [ 0, %whileCond187.preheader ]
  %0 = zext nneg i32 %storemerge3 to i64
  %t19 = getelementptr i8, ptr %t0, i64 %0
  %t20 = load i8, ptr %t19, align 1
  %t21 = tail call ptr @zen_char_to_string(i8 %t20)
  %t25 = getelementptr i8, ptr %t1, i64 %0
  %t26 = load i8, ptr %t25, align 1
  %t27 = tail call ptr @zen_char_to_string(i8 %t26)
  %t30 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t21, ptr noundef nonnull dereferenceable(1) %t27)
  %t31.not = icmp eq i32 %t30, 0
  %t33 = add nuw nsw i32 %storemerge3, 1
  %t16 = icmp slt i32 %t33, %t8
  %or.cond = select i1 %t31.not, i1 %t16, i1 false
  br i1 %or.cond, label %whileBody188, label %common.ret
}

define noundef i1 @endsWith(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t8 = tail call i32 @strlen(ptr %t1)
  %t12 = icmp sgt i32 %t8, %t5
  br i1 %t12, label %common.ret, label %whileCond194.preheader

whileCond194.preheader:                           ; preds = %entry
  %t20 = sub i32 %t5, %t8
  %t164 = icmp sgt i32 %t8, 0
  br i1 %t164, label %whileBody195, label %common.ret

common.ret:                                       ; preds = %whileBody195, %whileCond194.preheader, %entry
  %common.ret.op = phi i1 [ false, %entry ], [ true, %whileCond194.preheader ], [ %t35.not, %whileBody195 ]
  ret i1 %common.ret.op

whileBody195:                                     ; preds = %whileCond194.preheader, %whileBody195
  %storemerge5 = phi i32 [ %t37, %whileBody195 ], [ 0, %whileCond194.preheader ]
  %t22 = add i32 %t20, %storemerge5
  %0 = sext i32 %t22 to i64
  %t23 = getelementptr i8, ptr %t0, i64 %0
  %t24 = load i8, ptr %t23, align 1
  %t25 = tail call ptr @zen_char_to_string(i8 %t24)
  %1 = zext nneg i32 %storemerge5 to i64
  %t29 = getelementptr i8, ptr %t1, i64 %1
  %t30 = load i8, ptr %t29, align 1
  %t31 = tail call ptr @zen_char_to_string(i8 %t30)
  %t34 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t25, ptr noundef nonnull dereferenceable(1) %t31)
  %t35.not = icmp eq i32 %t34, 0
  %t37 = add nuw nsw i32 %storemerge5, 1
  %t16 = icmp slt i32 %t37, %t8
  %or.cond = select i1 %t35.not, i1 %t16, i1 false
  br i1 %or.cond, label %whileBody195, label %common.ret
}

define ptr @trim(ptr %t0) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t1124 = icmp sgt i32 %t3, 0
  br i1 %t1124, label %whileBody200, label %whileEnd201

whileBody200:                                     ; preds = %entry, %if209
  %t5.025 = phi i32 [ %t37, %if209 ], [ 0, %entry ]
  %0 = zext nneg i32 %t5.025 to i64
  %t15 = getelementptr i8, ptr %t0, i64 %0
  %t16 = load i8, ptr %t15, align 1
  %t17 = tail call ptr @zen_char_to_string(i8 %t16)
  %1 = load i8, ptr %t17, align 1
  switch i8 %1, label %whileEnd201 [
    i8 32, label %whileBody200.tail
    i8 10, label %rhs206.tail
    i8 9, label %rhs203.tail
  ]

whileBody200.tail:                                ; preds = %whileBody200
  %2 = getelementptr inbounds nuw i8, ptr %t17, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %if209, label %whileEnd201

rhs206.tail:                                      ; preds = %whileBody200
  %5 = getelementptr inbounds nuw i8, ptr %t17, i64 1
  %6 = load i8, ptr %5, align 1
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %if209, label %whileEnd201

rhs203.tail:                                      ; preds = %whileBody200
  %8 = getelementptr inbounds nuw i8, ptr %t17, i64 1
  %9 = load i8, ptr %8, align 1
  %10 = icmp eq i8 %9, 0
  br i1 %10, label %if209, label %whileEnd201

if209:                                            ; preds = %whileBody200.tail, %rhs206.tail, %rhs203.tail
  %t37 = add nuw nsw i32 %t5.025, 1
  %t11 = icmp slt i32 %t37, %t3
  br i1 %t11, label %whileBody200, label %whileEnd201

whileEnd201:                                      ; preds = %rhs206.tail, %whileBody200.tail, %if209, %rhs203.tail, %whileBody200, %entry
  %t5.0.lcssa = phi i32 [ 0, %entry ], [ %t5.025, %rhs206.tail ], [ %t5.025, %whileBody200.tail ], [ %t5.025, %rhs203.tail ], [ %t3, %if209 ], [ %t5.025, %whileBody200 ]
  %t6.027 = add i32 %t3, -1
  %t40.not28 = icmp slt i32 %t6.027, %t5.0.lcssa
  br i1 %t40.not28, label %whileEnd213, label %whileBody212

whileBody212:                                     ; preds = %whileEnd201, %if221
  %t6.029 = phi i32 [ %t6.0, %if221 ], [ %t6.027, %whileEnd201 ]
  %11 = sext i32 %t6.029 to i64
  %t44 = getelementptr i8, ptr %t0, i64 %11
  %t45 = load i8, ptr %t44, align 1
  %t46 = tail call ptr @zen_char_to_string(i8 %t45)
  %12 = load i8, ptr %t46, align 1
  switch i8 %12, label %whileEnd213 [
    i8 32, label %whileBody212.tail
    i8 10, label %rhs218.tail
    i8 9, label %rhs215.tail
  ]

whileBody212.tail:                                ; preds = %whileBody212
  %13 = getelementptr inbounds nuw i8, ptr %t46, i64 1
  %14 = load i8, ptr %13, align 1
  %15 = icmp eq i8 %14, 0
  br i1 %15, label %if221, label %whileEnd213

rhs218.tail:                                      ; preds = %whileBody212
  %16 = getelementptr inbounds nuw i8, ptr %t46, i64 1
  %17 = load i8, ptr %16, align 1
  %18 = icmp eq i8 %17, 0
  br i1 %18, label %if221, label %whileEnd213

rhs215.tail:                                      ; preds = %whileBody212
  %19 = getelementptr inbounds nuw i8, ptr %t46, i64 1
  %20 = load i8, ptr %19, align 1
  %21 = icmp eq i8 %20, 0
  br i1 %21, label %if221, label %whileEnd213

if221:                                            ; preds = %whileBody212.tail, %rhs218.tail, %rhs215.tail
  %t6.0 = add i32 %t6.029, -1
  %t40.not = icmp slt i32 %t6.0, %t5.0.lcssa
  br i1 %t40.not, label %whileEnd213, label %whileBody212

whileEnd213:                                      ; preds = %rhs218.tail, %whileBody212.tail, %if221, %rhs215.tail, %whileBody212, %whileEnd201
  %t6.0.lcssa = phi i32 [ %t6.027, %whileEnd201 ], [ %t6.029, %rhs218.tail ], [ %t6.029, %whileBody212.tail ], [ %t6.029, %rhs215.tail ], [ %t6.0, %if221 ], [ %t6.029, %whileBody212 ]
  %t73.not33 = icmp sgt i32 %t5.0.lcssa, %t6.0.lcssa
  br i1 %t73.not33, label %whileEnd225, label %whileBody224

whileBody224:                                     ; preds = %whileEnd213, %whileBody224
  %storemerge35 = phi i32 [ %t83, %whileBody224 ], [ %t5.0.lcssa, %whileEnd213 ]
  %t813234 = phi ptr [ %t81, %whileBody224 ], [ @.str_stdlib_stdlib_0, %whileEnd213 ]
  %22 = sext i32 %storemerge35 to i64
  %t77 = getelementptr i8, ptr %t0, i64 %22
  %t78 = load i8, ptr %t77, align 1
  %t79 = tail call ptr @zen_char_to_string(i8 %t78)
  %t81 = tail call ptr @str_concat(ptr %t813234, ptr %t79)
  %t83 = add i32 %storemerge35, 1
  %t73.not = icmp sgt i32 %t83, %t6.0.lcssa
  br i1 %t73.not, label %whileEnd225, label %whileBody224

whileEnd225:                                      ; preds = %whileBody224, %whileEnd213
  %t8132.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd213 ], [ %t81, %whileBody224 ]
  ret ptr %t8132.lcssa
}

define ptr @splitAt(ptr %t0, ptr %t1, i32 %t2) local_unnamed_addr {
entry:
  %t7 = tail call i32 @strlen(ptr %t0)
  %t10 = tail call i32 @strlen(ptr %t1)
  %t13 = icmp eq i32 %t10, 0
  br i1 %t13, label %common.ret, label %end226

common.ret:                                       ; preds = %if240, %whileEnd230, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %spec.select, %whileEnd230 ], [ %t691721, %if240 ]
  ret ptr %common.ret.op

end226:                                           ; preds = %entry
  %t2120 = icmp sgt i32 %t7, 0
  br i1 %t2120, label %whileBody229.lr.ph, label %whileEnd230

whileBody229.lr.ph:                               ; preds = %end226
  %t27 = sub i32 %t7, %t10
  %t319 = icmp sgt i32 %t10, 0
  br label %whileBody229

whileBody229:                                     ; preds = %whileBody229.lr.ph, %end239
  %storemerge1223 = phi i32 [ 0, %whileBody229.lr.ph ], [ %t71, %end239 ]
  %t571522 = phi i32 [ 0, %whileBody229.lr.ph ], [ %t5714, %end239 ]
  %t691721 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody229.lr.ph ], [ %t6918, %end239 ]
  %t28.not = icmp sgt i32 %storemerge1223, %t27
  br i1 %t28.not, label %else241, label %whileCond234.preheader

whileCond234.preheader:                           ; preds = %whileBody229
  br i1 %t319, label %whileBody235, label %if240

whileBody235:                                     ; preds = %whileCond234.preheader, %whileBody235
  %t50810 = phi i32 [ %t50, %whileBody235 ], [ 0, %whileCond234.preheader ]
  %0 = phi i1 [ %spec.select27, %whileBody235 ], [ true, %whileCond234.preheader ]
  %t35 = add i32 %t50810, %storemerge1223
  %1 = sext i32 %t35 to i64
  %t36 = getelementptr i8, ptr %t0, i64 %1
  %t37 = load i8, ptr %t36, align 1
  %t38 = tail call ptr @zen_char_to_string(i8 %t37)
  %2 = zext nneg i32 %t50810 to i64
  %t42 = getelementptr i8, ptr %t1, i64 %2
  %t43 = load i8, ptr %t42, align 1
  %t44 = tail call ptr @zen_char_to_string(i8 %t43)
  %t47 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t38, ptr noundef nonnull dereferenceable(1) %t44)
  %t48.not = icmp eq i32 %t47, 0
  %spec.select27 = select i1 %t48.not, i1 %0, i1 false
  %t50 = add nuw nsw i32 %t50810, 1
  %t31 = icmp slt i32 %t50, %t10
  br i1 %t31, label %whileBody235, label %end231

end231:                                           ; preds = %whileBody235
  br i1 %spec.select27, label %if240, label %else241

if240:                                            ; preds = %whileCond234.preheader, %end231
  %t54 = icmp eq i32 %t571522, %t2
  br i1 %t54, label %common.ret, label %end242

end242:                                           ; preds = %if240
  %t57 = add i32 %t571522, 1
  br label %end239

else241:                                          ; preds = %whileBody229, %end231
  %3 = sext i32 %storemerge1223 to i64
  %t65 = getelementptr i8, ptr %t0, i64 %3
  %t66 = load i8, ptr %t65, align 1
  %t67 = tail call ptr @zen_char_to_string(i8 %t66)
  %t69 = tail call ptr @str_concat(ptr %t691721, ptr %t67)
  br label %end239

end239:                                           ; preds = %else241, %end242
  %.sink = phi i32 [ 1, %else241 ], [ %t10, %end242 ]
  %t6918 = phi ptr [ %t69, %else241 ], [ @.str_stdlib_stdlib_0, %end242 ]
  %t5714 = phi i32 [ %t571522, %else241 ], [ %t57, %end242 ]
  %t71 = add i32 %storemerge1223, %.sink
  %t21 = icmp slt i32 %t71, %t7
  br i1 %t21, label %whileBody229, label %whileEnd230

whileEnd230:                                      ; preds = %end239, %end226
  %t6917.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %end226 ], [ %t6918, %end239 ]
  %t5715.lcssa = phi i32 [ 0, %end226 ], [ %t5714, %end239 ]
  %t74 = icmp eq i32 %t5715.lcssa, %t2
  %spec.select = select i1 %t74, ptr %t6917.lcssa, ptr @.str_stdlib_stdlib_0
  br label %common.ret
}

define ptr @repeat(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t5 = icmp slt i32 %t1, 1
  br i1 %t5, label %common.ret, label %end246

common.ret:                                       ; preds = %whileBody251, %end246, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ @.str_stdlib_stdlib_0, %end246 ], [ %t17, %whileBody251 ]
  ret ptr %common.ret.op

end246:                                           ; preds = %entry
  %t8 = tail call i32 @strlen(ptr %t0)
  %t9 = icmp eq i32 %t8, 0
  br i1 %t9, label %common.ret, label %whileBody251

whileBody251:                                     ; preds = %end246, %whileBody251
  %count.addr.07 = phi i32 [ %t19, %whileBody251 ], [ %t1, %end246 ]
  %t1746 = phi ptr [ %t17, %whileBody251 ], [ @.str_stdlib_stdlib_0, %end246 ]
  %t17 = tail call ptr @str_concat(ptr %t1746, ptr %t0)
  %t19 = add nsw i32 %count.addr.07, -1
  %t14 = icmp samesign ugt i32 %count.addr.07, 1
  br i1 %t14, label %whileBody251, label %common.ret
}

define i32 @count(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t5 = tail call i32 @strlen(ptr %t0)
  %t6 = icmp eq i32 %t5, 0
  br i1 %t6, label %common.ret, label %end253

common.ret:                                       ; preds = %charAt.exit, %end255, %end253, %entry
  %common.ret.op = phi i32 [ 0, %entry ], [ 0, %end253 ], [ 0, %end255 ], [ %spec.select, %charAt.exit ]
  ret i32 %common.ret.op

end253:                                           ; preds = %entry
  %t8 = tail call i32 @strlen(ptr %t1)
  %t9 = icmp eq i32 %t8, 0
  br i1 %t9, label %common.ret, label %end255

end255:                                           ; preds = %end253
  %t143 = tail call i32 @strlen(ptr %t0)
  %t154 = icmp sgt i32 %t143, 0
  br i1 %t154, label %whileBody258, label %common.ret

whileBody258:                                     ; preds = %end255, %charAt.exit
  %storemerge6 = phi i32 [ %t26, %charAt.exit ], [ 0, %end255 ]
  %t2425 = phi i32 [ %spec.select, %charAt.exit ], [ 0, %end255 ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t12.i.not = icmp slt i32 %storemerge6, %t5.i
  br i1 %t12.i.not, label %end116.i, label %charAt.exit

end116.i:                                         ; preds = %whileBody258
  %0 = zext nneg i32 %storemerge6 to i64
  %t16.i = getelementptr i8, ptr %t0, i64 %0
  %t17.i = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %whileBody258, %end116.i
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody258 ]
  %t21 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i, ptr noundef nonnull dereferenceable(1) %t1)
  %t22 = icmp eq i32 %t21, 0
  %t24 = zext i1 %t22 to i32
  %spec.select = add i32 %t2425, %t24
  %t26 = add nuw nsw i32 %storemerge6, 1
  %t14 = tail call i32 @strlen(ptr %t0)
  %t15 = icmp slt i32 %t26, %t14
  br i1 %t15, label %whileBody258, label %common.ret
}

define ptr @padStart(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t8 = tail call i32 @strlen(ptr %t0)
  %t9.not = icmp sgt i32 %t1, %t8
  br i1 %t9.not, label %end262, label %common.ret

common.ret:                                       ; preds = %end262, %entry, %whileEnd268
  %common.ret.op = phi ptr [ %t31, %whileEnd268 ], [ %t0, %entry ], [ %t0, %end262 ]
  ret ptr %common.ret.op

end262:                                           ; preds = %entry
  %t12 = tail call i32 @strlen(ptr %t2)
  %t13 = icmp eq i32 %t12, 0
  br i1 %t13, label %common.ret, label %end264

end264:                                           ; preds = %end262
  %t18 = tail call i32 @strlen(ptr %t0)
  %t19 = sub i32 %t1, %t18
  %t234 = icmp sgt i32 %t19, 0
  br i1 %t234, label %whileBody267, label %whileEnd268

whileBody267:                                     ; preds = %end264, %whileBody267
  %t226 = phi i32 [ %t28, %whileBody267 ], [ %t19, %end264 ]
  %t2635 = phi ptr [ %t26, %whileBody267 ], [ @.str_stdlib_stdlib_0, %end264 ]
  %t26 = tail call ptr @str_concat(ptr %t2635, ptr %t2)
  %t28 = add nsw i32 %t226, -1
  %t23 = icmp samesign ugt i32 %t226, 1
  br i1 %t23, label %whileBody267, label %whileEnd268

whileEnd268:                                      ; preds = %whileBody267, %end264
  %t263.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %end264 ], [ %t26, %whileBody267 ]
  %t31 = tail call ptr @str_concat(ptr %t263.lcssa, ptr %t0)
  br label %common.ret
}

define ptr @padEnd(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t8 = tail call i32 @strlen(ptr %t0)
  %t9.not = icmp sgt i32 %t1, %t8
  br i1 %t9.not, label %end269, label %common.ret

common.ret:                                       ; preds = %whileBody274, %end271, %end269, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ %t0, %end269 ], [ %t0, %end271 ], [ %t26, %whileBody274 ]
  ret ptr %common.ret.op

end269:                                           ; preds = %entry
  %t12 = tail call i32 @strlen(ptr %t2)
  %t13 = icmp eq i32 %t12, 0
  br i1 %t13, label %common.ret, label %end271

end271:                                           ; preds = %end269
  %t18 = tail call i32 @strlen(ptr %t0)
  %t19 = sub i32 %t1, %t18
  %t234 = icmp sgt i32 %t19, 0
  br i1 %t234, label %whileBody274, label %common.ret

whileBody274:                                     ; preds = %end271, %whileBody274
  %t226 = phi i32 [ %t28, %whileBody274 ], [ %t19, %end271 ]
  %t2635 = phi ptr [ %t26, %whileBody274 ], [ %t0, %end271 ]
  %t26 = tail call ptr @str_concat(ptr %t2635, ptr %t2)
  %t28 = add nsw i32 %t226, -1
  %t23 = icmp samesign ugt i32 %t226, 1
  br i1 %t23, label %whileBody274, label %common.ret
}

define ptr @padCenter(ptr %t0, i32 %t1, ptr %t2) local_unnamed_addr {
entry:
  %t8 = tail call i32 @strlen(ptr %t0)
  %t9.not = icmp sgt i32 %t1, %t8
  br i1 %t9.not, label %end276, label %common.ret

common.ret:                                       ; preds = %end276, %entry, %whileEnd285
  %common.ret.op = phi ptr [ %t49, %whileEnd285 ], [ %t0, %entry ], [ %t0, %end276 ]
  ret ptr %common.ret.op

end276:                                           ; preds = %entry
  %t12 = tail call i32 @strlen(ptr %t2)
  %t13 = icmp eq i32 %t12, 0
  br i1 %t13, label %common.ret, label %end278

end278:                                           ; preds = %end276
  %t18 = tail call i32 @strlen(ptr %t0)
  %t19 = sub i32 %t1, %t18
  %t22 = sdiv i32 %t19, 2
  %t26 = sub i32 %t19, %t22
  %t325 = icmp sgt i32 %t19, 1
  br i1 %t325, label %whileBody281, label %whileCond283thread-pre-split

whileBody281:                                     ; preds = %end278, %whileBody281
  %t317 = phi i32 [ %t37, %whileBody281 ], [ %t22, %end278 ]
  %t3536 = phi ptr [ %t35, %whileBody281 ], [ @.str_stdlib_stdlib_0, %end278 ]
  %t35 = tail call ptr @str_concat(ptr %t3536, ptr %t2)
  %t37 = add nsw i32 %t317, -1
  %t32 = icmp sgt i32 %t317, 1
  br i1 %t32, label %whileBody281, label %whileCond283thread-pre-split

whileCond283thread-pre-split:                     ; preds = %whileBody281, %end278
  %t45 = phi ptr [ @.str_stdlib_stdlib_0, %end278 ], [ %t35, %whileBody281 ]
  %t3911 = icmp sgt i32 %t26, 0
  br i1 %t3911, label %whileBody284, label %whileEnd285

whileBody284:                                     ; preds = %whileCond283thread-pre-split, %whileBody284
  %t3813 = phi i32 [ %t44, %whileBody284 ], [ %t26, %whileCond283thread-pre-split ]
  %t42912 = phi ptr [ %t42, %whileBody284 ], [ @.str_stdlib_stdlib_0, %whileCond283thread-pre-split ]
  %t42 = tail call ptr @str_concat(ptr %t42912, ptr %t2)
  %t44 = add nsw i32 %t3813, -1
  %t39 = icmp samesign ugt i32 %t3813, 1
  br i1 %t39, label %whileBody284, label %whileEnd285

whileEnd285:                                      ; preds = %whileBody284, %whileCond283thread-pre-split
  %t429.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %whileCond283thread-pre-split ], [ %t42, %whileBody284 ]
  %t47 = tail call ptr @str_concat(ptr %t45, ptr %t0)
  %t49 = tail call ptr @str_concat(ptr %t47, ptr %t429.lcssa)
  br label %common.ret
}

define ptr @capitalize(ptr %t0) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t4 = icmp eq i32 %t3, 0
  br i1 %t4, label %common.ret, label %end286

common.ret:                                       ; preds = %whileBody295, %end288, %entry
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %entry ], [ %t33, %end288 ], [ %t48, %whileBody295 ]
  ret ptr %common.ret.op

end286:                                           ; preds = %entry
  %t9 = load i8, ptr %t0, align 1
  %t10 = tail call ptr @zen_char_to_string(i8 %t9)
  %t13 = tail call i32 @string_to_int_ascii(ptr %t10)
  %t20 = tail call i32 @string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_1)
  %t24 = tail call i32 @string_to_int_ascii(ptr nonnull @.str_stdlib_stdlib_2)
  %t21 = icmp sge i32 %t13, %t20
  %t25 = icmp sle i32 %t13, %t24
  %t17 = select i1 %t21, i1 %t25, i1 false
  br i1 %t17, label %if292, label %end288

if292:                                            ; preds = %end286
  %t28 = add i32 %t13, -32
  %t29 = tail call ptr @int_to_string_ascii(i32 %t28)
  br label %end288

end288:                                           ; preds = %end286, %if292
  %t10.sink = phi ptr [ %t29, %if292 ], [ %t10, %end286 ]
  %t33 = tail call ptr @str_concat(ptr nonnull @.str_stdlib_stdlib_0, ptr %t10.sink)
  %t36 = tail call i32 @strlen(ptr nonnull %t0)
  %t403 = icmp sgt i32 %t36, 1
  br i1 %t403, label %whileBody295, label %common.ret

whileBody295:                                     ; preds = %end288, %whileBody295
  %t5015 = phi i32 [ %t50, %whileBody295 ], [ 1, %end288 ]
  %t4824 = phi ptr [ %t48, %whileBody295 ], [ %t33, %end288 ]
  %0 = zext nneg i32 %t5015 to i64
  %t44 = getelementptr i8, ptr %t0, i64 %0
  %t45 = load i8, ptr %t44, align 1
  %t46 = tail call ptr @zen_char_to_string(i8 %t45)
  %t48 = tail call ptr @str_concat(ptr %t4824, ptr %t46)
  %t50 = add nuw nsw i32 %t5015, 1
  %t40 = icmp slt i32 %t50, %t36
  br i1 %t40, label %whileBody295, label %common.ret
}

define ptr @extName(ptr %t0) local_unnamed_addr {
entry:
  %t3 = tail call i32 @strlen(ptr %t0)
  %t5.017 = add i32 %t3, -1
  %t918 = icmp sgt i32 %t5.017, -1
  br i1 %t918, label %whileBody298, label %common.ret

whileBody298:                                     ; preds = %entry, %whileCond297.backedge
  %t5.020 = phi i32 [ %t5.0, %whileCond297.backedge ], [ %t5.017, %entry ]
  %t5.0.in19 = phi i32 [ %t5.020, %whileCond297.backedge ], [ %t3, %entry ]
  %0 = zext nneg i32 %t5.020 to i64
  %t12 = getelementptr i8, ptr %t0, i64 %0
  %t13 = load i8, ptr %t12, align 1
  %t14 = tail call ptr @zen_char_to_string(i8 %t13)
  %1 = load i8, ptr %t14, align 1
  %.not = icmp eq i8 %1, 46
  br i1 %.not, label %sub_1, label %whileCond297.backedge

sub_1:                                            ; preds = %whileBody298
  %2 = getelementptr inbounds nuw i8, ptr %t14, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %if301, label %whileCond297.backedge

whileCond297.backedge:                            ; preds = %whileBody298, %sub_1
  %t5.0 = add nsw i32 %t5.020, -1
  %t9 = icmp sgt i32 %t5.020, 0
  br i1 %t9, label %whileBody298, label %common.ret

if301:                                            ; preds = %sub_1
  %t278 = icmp slt i32 %t5.0.in19, %t3
  br i1 %t278, label %whileBody303, label %common.ret

whileBody303:                                     ; preds = %if301, %whileBody303
  %t37610 = phi i32 [ %t37, %whileBody303 ], [ %t5.0.in19, %if301 ]
  %t3579 = phi ptr [ %t35, %whileBody303 ], [ @.str_stdlib_stdlib_0, %if301 ]
  %5 = sext i32 %t37610 to i64
  %t31 = getelementptr i8, ptr %t0, i64 %5
  %t32 = load i8, ptr %t31, align 1
  %t33 = tail call ptr @zen_char_to_string(i8 %t32)
  %t35 = tail call ptr @str_concat(ptr %t3579, ptr %t33)
  %t37 = add nsw i32 %t37610, 1
  %t27 = icmp slt i32 %t37, %t3
  br i1 %t27, label %whileBody303, label %common.ret

common.ret:                                       ; preds = %whileCond297.backedge, %whileBody303, %entry, %if301
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %if301 ], [ @.str_stdlib_stdlib_0, %entry ], [ %t35, %whileBody303 ], [ @.str_stdlib_stdlib_0, %whileCond297.backedge ]
  ret ptr %common.ret.op
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @sin(double %t0) local_unnamed_addr #2 {
entry:
  %t3 = load double, ptr @PI, align 8
  %t41 = fcmp ogt double %t0, %t3
  br i1 %t41, label %whileBody306.lr.ph, label %whileCond308.preheader

whileBody306.lr.ph:                               ; preds = %entry
  %t6 = load double, ptr @TAU, align 8
  br label %whileBody306

whileCond308.preheader:                           ; preds = %whileBody306, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t7, %whileBody306 ]
  %t11 = fsub double 0.000000e+00, %t3
  %t124 = fcmp olt double %x.addr.0.lcssa, %t11
  br i1 %t124, label %whileBody309.lr.ph, label %whileEnd310

whileBody309.lr.ph:                               ; preds = %whileCond308.preheader
  %t14 = load double, ptr @TAU, align 8
  br label %whileBody309

whileBody306:                                     ; preds = %whileBody306.lr.ph, %whileBody306
  %x.addr.02 = phi double [ %t0, %whileBody306.lr.ph ], [ %t7, %whileBody306 ]
  %t7 = fsub double %x.addr.02, %t6
  %t4 = fcmp ogt double %t7, %t3
  br i1 %t4, label %whileBody306, label %whileCond308.preheader

whileBody309:                                     ; preds = %whileBody309.lr.ph, %whileBody309
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody309.lr.ph ], [ %t15, %whileBody309 ]
  %t15 = fadd double %x.addr.15, %t14
  %t12 = fcmp olt double %t15, %t11
  br i1 %t12, label %whileBody309, label %whileEnd310

whileEnd310:                                      ; preds = %whileBody309, %whileCond308.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond308.preheader ], [ %t15, %whileBody309 ]
  %t19 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t21 = fmul double %x.addr.1.lcssa, %t19
  %t22 = fdiv double %t21, 6.000000e+00
  %t23 = fsub double %x.addr.1.lcssa, %t22
  ret double %t23
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @cos(double %t0) local_unnamed_addr #2 {
entry:
  %t3 = load double, ptr @PI, align 8
  %t41 = fcmp ogt double %t0, %t3
  br i1 %t41, label %whileBody312.lr.ph, label %whileCond314.preheader

whileBody312.lr.ph:                               ; preds = %entry
  %t6 = load double, ptr @TAU, align 8
  br label %whileBody312

whileCond314.preheader:                           ; preds = %whileBody312, %entry
  %x.addr.0.lcssa = phi double [ %t0, %entry ], [ %t7, %whileBody312 ]
  %t11 = fsub double 0.000000e+00, %t3
  %t124 = fcmp olt double %x.addr.0.lcssa, %t11
  br i1 %t124, label %whileBody315.lr.ph, label %whileEnd316

whileBody315.lr.ph:                               ; preds = %whileCond314.preheader
  %t14 = load double, ptr @TAU, align 8
  br label %whileBody315

whileBody312:                                     ; preds = %whileBody312.lr.ph, %whileBody312
  %x.addr.02 = phi double [ %t0, %whileBody312.lr.ph ], [ %t7, %whileBody312 ]
  %t7 = fsub double %x.addr.02, %t6
  %t4 = fcmp ogt double %t7, %t3
  br i1 %t4, label %whileBody312, label %whileCond314.preheader

whileBody315:                                     ; preds = %whileBody315.lr.ph, %whileBody315
  %x.addr.15 = phi double [ %x.addr.0.lcssa, %whileBody315.lr.ph ], [ %t15, %whileBody315 ]
  %t15 = fadd double %x.addr.15, %t14
  %t12 = fcmp olt double %t15, %t11
  br i1 %t12, label %whileBody315, label %whileEnd316

whileEnd316:                                      ; preds = %whileBody315, %whileCond314.preheader
  %x.addr.1.lcssa = phi double [ %x.addr.0.lcssa, %whileCond314.preheader ], [ %t15, %whileBody315 ]
  %t18 = fmul double %x.addr.1.lcssa, %x.addr.1.lcssa
  %t19 = fmul double %t18, 5.000000e-01
  %t20 = fsub double 1.000000e+00, %t19
  ret double %t20
}

; Function Attrs: nofree norecurse nosync nounwind memory(none)
define double @tan(double %t0) local_unnamed_addr #2 {
entry:
  %t3.i = load double, ptr @PI, align 8
  %t41.i = fcmp ogt double %t0, %t3.i
  br i1 %t41.i, label %whileBody306.lr.ph.i, label %whileCond308.preheader.i

whileBody306.lr.ph.i:                             ; preds = %entry
  %t6.i = load double, ptr @TAU, align 8
  br label %whileBody306.i

whileCond308.preheader.i:                         ; preds = %whileBody306.i, %entry
  %x.addr.0.lcssa.i = phi double [ %t0, %entry ], [ %t7.i, %whileBody306.i ]
  %t11.i = fsub double 0.000000e+00, %t3.i
  %t124.i = fcmp olt double %x.addr.0.lcssa.i, %t11.i
  br i1 %t124.i, label %whileBody309.lr.ph.i, label %sin.exit

whileBody309.lr.ph.i:                             ; preds = %whileCond308.preheader.i
  %t14.i = load double, ptr @TAU, align 8
  br label %whileBody309.i

whileBody306.i:                                   ; preds = %whileBody306.i, %whileBody306.lr.ph.i
  %x.addr.02.i = phi double [ %t0, %whileBody306.lr.ph.i ], [ %t7.i, %whileBody306.i ]
  %t7.i = fsub double %x.addr.02.i, %t6.i
  %t4.i = fcmp ogt double %t7.i, %t3.i
  br i1 %t4.i, label %whileBody306.i, label %whileCond308.preheader.i

whileBody309.i:                                   ; preds = %whileBody309.i, %whileBody309.lr.ph.i
  %x.addr.15.i = phi double [ %x.addr.0.lcssa.i, %whileBody309.lr.ph.i ], [ %t15.i, %whileBody309.i ]
  %t15.i = fadd double %t14.i, %x.addr.15.i
  %t12.i = fcmp olt double %t15.i, %t11.i
  br i1 %t12.i, label %whileBody309.i, label %sin.exit

sin.exit:                                         ; preds = %whileBody309.i, %whileCond308.preheader.i
  %x.addr.1.lcssa.i = phi double [ %x.addr.0.lcssa.i, %whileCond308.preheader.i ], [ %t15.i, %whileBody309.i ]
  br i1 %t41.i, label %whileBody312.lr.ph.i, label %whileCond314.preheader.i

whileBody312.lr.ph.i:                             ; preds = %sin.exit
  %t6.i12 = load double, ptr @TAU, align 8
  br label %whileBody312.i

whileCond314.preheader.i:                         ; preds = %whileBody312.i, %sin.exit
  %x.addr.0.lcssa.i3 = phi double [ %t0, %sin.exit ], [ %t7.i14, %whileBody312.i ]
  %t124.i5 = fcmp olt double %x.addr.0.lcssa.i3, %t11.i
  br i1 %t124.i5, label %whileBody315.lr.ph.i, label %cos.exit

whileBody315.lr.ph.i:                             ; preds = %whileCond314.preheader.i
  %t14.i8 = load double, ptr @TAU, align 8
  br label %whileBody315.i

whileBody312.i:                                   ; preds = %whileBody312.i, %whileBody312.lr.ph.i
  %x.addr.02.i13 = phi double [ %t0, %whileBody312.lr.ph.i ], [ %t7.i14, %whileBody312.i ]
  %t7.i14 = fsub double %x.addr.02.i13, %t6.i12
  %t4.i15 = fcmp ogt double %t7.i14, %t3.i
  br i1 %t4.i15, label %whileBody312.i, label %whileCond314.preheader.i

whileBody315.i:                                   ; preds = %whileBody315.i, %whileBody315.lr.ph.i
  %x.addr.15.i9 = phi double [ %x.addr.0.lcssa.i3, %whileBody315.lr.ph.i ], [ %t15.i10, %whileBody315.i ]
  %t15.i10 = fadd double %t14.i8, %x.addr.15.i9
  %t12.i11 = fcmp olt double %t15.i10, %t11.i
  br i1 %t12.i11, label %whileBody315.i, label %cos.exit

cos.exit:                                         ; preds = %whileBody315.i, %whileCond314.preheader.i
  %x.addr.1.lcssa.i6 = phi double [ %x.addr.0.lcssa.i3, %whileCond314.preheader.i ], [ %t15.i10, %whileBody315.i ]
  %t19.i = fmul double %x.addr.1.lcssa.i, %x.addr.1.lcssa.i
  %t21.i = fmul double %x.addr.1.lcssa.i, %t19.i
  %t22.i = fdiv double %t21.i, 6.000000e+00
  %t23.i = fsub double %x.addr.1.lcssa.i, %t22.i
  %t18.i = fmul double %x.addr.1.lcssa.i6, %x.addr.1.lcssa.i6
  %t19.i7 = fmul double %t18.i, 5.000000e-01
  %t20.i = fsub double 1.000000e+00, %t19.i7
  %t10 = fdiv double %t23.i, %t20.i
  ret double %t10
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @log(double %t0) local_unnamed_addr #1 {
entry:
  %t8 = fadd double %t0, -1.000000e+00
  %t11 = fdiv double %t0, %t0
  %t12 = fadd double %t8, %t11
  %t8.1 = fadd double %t12, -1.000000e+00
  %t11.1 = fdiv double %t0, %t12
  %t12.1 = fadd double %t8.1, %t11.1
  %t8.2 = fadd double %t12.1, -1.000000e+00
  %t11.2 = fdiv double %t0, %t12.1
  %t12.2 = fadd double %t8.2, %t11.2
  %t8.3 = fadd double %t12.2, -1.000000e+00
  %t11.3 = fdiv double %t0, %t12.2
  %t12.3 = fadd double %t8.3, %t11.3
  %t8.4 = fadd double %t12.3, -1.000000e+00
  %t11.4 = fdiv double %t0, %t12.3
  %t12.4 = fadd double %t8.4, %t11.4
  %t8.5 = fadd double %t12.4, -1.000000e+00
  %t11.5 = fdiv double %t0, %t12.4
  %t12.5 = fadd double %t8.5, %t11.5
  %t8.6 = fadd double %t12.5, -1.000000e+00
  %t11.6 = fdiv double %t0, %t12.5
  %t12.6 = fadd double %t8.6, %t11.6
  %t8.7 = fadd double %t12.6, -1.000000e+00
  %t11.7 = fdiv double %t0, %t12.6
  %t12.7 = fadd double %t8.7, %t11.7
  %t8.8 = fadd double %t12.7, -1.000000e+00
  %t11.8 = fdiv double %t0, %t12.7
  %t12.8 = fadd double %t8.8, %t11.8
  %t8.9 = fadd double %t12.8, -1.000000e+00
  %t11.9 = fdiv double %t0, %t12.8
  %t12.9 = fadd double %t8.9, %t11.9
  ret double %t12.9
}

; Function Attrs: mustprogress nofree norecurse nosync nounwind willreturn memory(none)
define double @exp(double %t0) local_unnamed_addr #1 {
entry:
  %t15 = fadd double %t0, 1.000000e+00
  %t9.1 = fmul double %t0, %t0
  %t12.1 = fmul double %t9.1, 5.000000e-01
  %t15.1 = fadd double %t15, %t12.1
  %t9.2 = fmul double %t0, %t12.1
  %t12.2 = fdiv double %t9.2, 3.000000e+00
  %t15.2 = fadd double %t15.1, %t12.2
  %t9.3 = fmul double %t0, %t12.2
  %t12.3 = fmul double %t9.3, 2.500000e-01
  %t15.3 = fadd double %t15.2, %t12.3
  %t9.4 = fmul double %t0, %t12.3
  %t12.4 = fdiv double %t9.4, 5.000000e+00
  %t15.4 = fadd double %t15.3, %t12.4
  %t9.5 = fmul double %t0, %t12.4
  %t12.5 = fdiv double %t9.5, 6.000000e+00
  %t15.5 = fadd double %t15.4, %t12.5
  %t9.6 = fmul double %t0, %t12.5
  %t12.6 = fdiv double %t9.6, 7.000000e+00
  %t15.6 = fadd double %t15.5, %t12.6
  %t9.7 = fmul double %t0, %t12.6
  %t12.7 = fmul double %t9.7, 1.250000e-01
  %t15.7 = fadd double %t15.6, %t12.7
  %t9.8 = fmul double %t0, %t12.7
  %t12.8 = fdiv double %t9.8, 9.000000e+00
  %t15.8 = fadd double %t15.7, %t12.8
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
  %t6.i = icmp slt i32 %t4.i, 0
  %t9.i = select i1 %t6.i, i32 %t3.i, i32 0
  %spec.select.i = add i32 %t9.i, %t4.i
  store i32 %spec.select.i, ptr @SEED, align 4
  %t11.i = sitofp i32 %spec.select.i to double
  %t12.i = fdiv double %t11.i, 0x41DFFFFFFFC00000
  %reass.sub = sub i32 %t1, %t0
  %t11 = add i32 %reass.sub, 1
  %t12 = sitofp i32 %t11 to double
  %t13 = fmul double %t12.i, %t12
  %t14 = fptosi double %t13 to i32
  %t15 = add i32 %t0, %t14
  ret i32 %t15
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
  %t1.tr = phi ptr [ %t1, %entry ], [ %storemerge5322.lcssa, %whileEnd329 ]
  %t6 = tail call i1 @contains(ptr %t1.tr, ptr nonnull @.str_stdlib_stdlib_9)
  %t12324 = tail call i32 @strlen(ptr %t1.tr)
  %t13325 = icmp sgt i32 %t12324, 0
  br i1 %t6, label %if326, label %end325

if326:                                            ; preds = %tailrecurse
  br i1 %t13325, label %whileBody328, label %whileEnd329

whileBody328:                                     ; preds = %if326, %end330
  %storemerge4327 = phi i32 [ %t31, %end330 ], [ 0, %if326 ]
  %storemerge5322326 = phi ptr [ %storemerge5, %end330 ], [ @.str_stdlib_stdlib_0, %if326 ]
  %t5.i = tail call i32 @strlen(ptr %t1.tr)
  %t12.i.not = icmp slt i32 %storemerge4327, %t5.i
  br i1 %t12.i.not, label %end116.i, label %sub_0

end116.i:                                         ; preds = %whileBody328
  %0 = zext nneg i32 %storemerge4327 to i64
  %t16.i = getelementptr i8, ptr %t1.tr, i64 %0
  %t17.i = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %whileBody328
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody328 ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not351 = icmp eq i8 %1, 124
  br i1 %.not351, label %charAt.exit.tail, label %else332

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %if331, label %else332

if331:                                            ; preds = %charAt.exit.tail
  %t25 = tail call i1 @match(ptr %t0, ptr %storemerge5322326)
  br i1 %t25, label %common.ret, label %end330

common.ret:                                       ; preds = %sub_0228, %charAt.exit85.tail, %charAt.exit179, %rhs471, %else469, %charAt.exit55.tail, %charAt.exit199, %end455, %slice.exit142, %rhs379.tail, %if375, %charAt.exit75, %if369, %charAt.exit65, %if363, %rhs358.tail, %if354, %if339, %whileCond475.backedge, %slice.exit35, %whileCond346, %if331, %sub_0252, %whileCond402.preheader, %end344, %rhs417.tail, %if413, %whileEnd404, %end395, %if343, %whileEnd337, %if454, %whileEnd432, %end410
  %common.ret.op = phi i1 [ %t287, %end410 ], [ %t388, %whileEnd432 ], [ %t397, %if454 ], [ %t508, %whileEnd337 ], [ true, %if343 ], [ false, %end395 ], [ false, %whileEnd404 ], [ false, %if413 ], [ false, %rhs417.tail ], [ false, %end344 ], [ false, %whileCond402.preheader ], [ false, %sub_0252 ], [ true, %if331 ], [ %t89, %whileCond346 ], [ %t89, %slice.exit35 ], [ false, %whileCond475.backedge ], [ false, %if339 ], [ false, %if354 ], [ false, %rhs358.tail ], [ false, %if363 ], [ false, %charAt.exit65 ], [ false, %if369 ], [ false, %charAt.exit75 ], [ false, %if375 ], [ false, %rhs379.tail ], [ false, %slice.exit142 ], [ false, %end455 ], [ false, %charAt.exit199 ], [ false, %charAt.exit55.tail ], [ false, %else469 ], [ false, %rhs471 ], [ false, %charAt.exit179 ], [ false, %charAt.exit85.tail ], [ false, %sub_0228 ]
  ret i1 %common.ret.op

else332:                                          ; preds = %sub_0, %charAt.exit.tail
  %t29 = tail call ptr @str_concat(ptr %storemerge5322326, ptr nonnull %common.ret.op.i)
  br label %end330

end330:                                           ; preds = %if331, %else332
  %storemerge5 = phi ptr [ %t29, %else332 ], [ @.str_stdlib_stdlib_0, %if331 ]
  %t31 = add nuw nsw i32 %storemerge4327, 1
  %t12 = tail call i32 @strlen(ptr %t1.tr)
  %t13 = icmp slt i32 %t31, %t12
  br i1 %t13, label %whileBody328, label %whileEnd329

whileEnd329:                                      ; preds = %end330, %if326
  %storemerge5322.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %if326 ], [ %storemerge5, %end330 ]
  br label %tailrecurse

end325:                                           ; preds = %tailrecurse
  br i1 %t13325, label %whileBody336, label %whileEnd337

whileBody336:                                     ; preds = %end325, %whileCond335.backedge
  %storemerge1.in.peel = phi i32 [ %t504288, %whileCond335.backedge ], [ 0, %end325 ]
  %t69 = phi i32 [ %t502290, %whileCond335.backedge ], [ 0, %end325 ]
  %t5.i6 = tail call i32 @strlen(ptr %t1.tr)
  %t9.i7 = icmp slt i32 %storemerge1.in.peel, 0
  %t12.i8 = icmp sge i32 %storemerge1.in.peel, %t5.i6
  %t7.i9 = select i1 %t9.i7, i1 true, i1 %t12.i8
  br i1 %t7.i9, label %sub_0201, label %end116.i10

end116.i10:                                       ; preds = %whileBody336
  %5 = zext nneg i32 %storemerge1.in.peel to i64
  %t16.i11 = getelementptr i8, ptr %t1.tr, i64 %5
  %t17.i12 = load i8, ptr %t16.i11, align 1
  %t18.i13 = tail call ptr @zen_char_to_string(i8 %t17.i12)
  br label %sub_0201

sub_0201:                                         ; preds = %end116.i10, %whileBody336
  %common.ret.op.i14 = phi ptr [ %t18.i13, %end116.i10 ], [ @.str_stdlib_stdlib_0, %whileBody336 ]
  %6 = load i8, ptr %common.ret.op.i14, align 1
  switch i8 %6, label %sub_0234 [
    i8 63, label %charAt.exit15.tail
    i8 42, label %end338.tail
    i8 35, label %end342.tail
  ]

charAt.exit15.tail:                               ; preds = %sub_0201
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %if339, label %end455

if339:                                            ; preds = %charAt.exit15.tail
  %t52 = tail call i32 @strlen(ptr %t0)
  %t53.not = icmp slt i32 %t69, %t52
  br i1 %t53.not, label %end340, label %common.ret

end340:                                           ; preds = %if339
  %t57 = add nsw i32 %storemerge1.in.peel, 1
  br label %whileCond335.backedge

whileCond335.backedge:                            ; preds = %end340, %end357, %end366, %end372, %end378, %end482, %end486
  %t504288 = phi i32 [ %t57, %end340 ], [ %t129, %end357 ], [ %t150, %end366 ], [ %t171, %end372 ], [ %t199, %end378 ], [ %t489, %end482 ], [ %t504, %end486 ]
  %t502290 = add i32 %t69, 1
  %t39 = tail call i32 @strlen(ptr %t1.tr)
  %t40 = icmp slt i32 %t504288, %t39
  br i1 %t40, label %whileBody336, label %whileEnd337

end338.tail:                                      ; preds = %sub_0201
  %10 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %11 = load i8, ptr %10, align 1
  %12 = icmp eq i8 %11, 0
  br i1 %12, label %if343, label %end455

if343:                                            ; preds = %end338.tail
  %t66 = tail call i32 @strlen(ptr %t1.tr)
  %t64 = add nsw i32 %storemerge1.in.peel, 1
  %t67.not = icmp slt i32 %t64, %t66
  br i1 %t67.not, label %end344, label %common.ret

end344:                                           ; preds = %if343
  %t72317 = tail call i32 @strlen(ptr %t0)
  %t73.not318 = icmp sgt i32 %t69, %t72317
  br i1 %t73.not318, label %common.ret, label %whileBody347.lr.ph

whileBody347.lr.ph:                               ; preds = %end344
  %spec.store.select.i20 = tail call i32 @llvm.smax.i32(i32 %t64, i32 0)
  br label %whileBody347

whileCond346:                                     ; preds = %slice.exit35
  %t91 = add i32 %storemerge3319, 1
  %t72 = tail call i32 @strlen(ptr %t0)
  %t73.not = icmp sgt i32 %t91, %t72
  br i1 %t73.not, label %common.ret, label %whileBody347

whileBody347:                                     ; preds = %whileBody347.lr.ph, %whileCond346
  %storemerge3319 = phi i32 [ %t69, %whileBody347.lr.ph ], [ %t91, %whileCond346 ]
  %t77 = tail call i32 @strlen(ptr %t0)
  %t7.i16 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %storemerge3319, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %t77, i32 %t7.i16)
  %t17.i17 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t259.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t17.i17, i1 %t259.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileBody347, %whileBody114.i
  %storemerge11.i = phi i32 [ %t35.i, %whileBody114.i ], [ %spec.store.select.i, %whileBody347 ]
  %t33810.i = phi ptr [ %t33.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileBody347 ]
  %13 = zext nneg i32 %storemerge11.i to i64
  %t29.i = getelementptr i8, ptr %t0, i64 %13
  %t30.i = load i8, ptr %t29.i, align 1
  %t31.i = tail call ptr @zen_char_to_string(i8 %t30.i)
  %t33.i = tail call ptr @str_concat(ptr %t33810.i, ptr %t31.i)
  %t35.i = add nuw nsw i32 %storemerge11.i, 1
  %t25.i = icmp slt i32 %t35.i, %spec.select.i
  br i1 %t25.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileBody347
  %common.ret.op.i18 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody347 ], [ %t33.i, %whileBody114.i ]
  %t84 = tail call i32 @strlen(ptr %t1.tr)
  %t7.i19 = tail call i32 @strlen(ptr %t1.tr)
  %spec.select.i21 = tail call i32 @llvm.smin.i32(i32 %t84, i32 %t7.i19)
  %t17.i22 = icmp sle i32 %spec.store.select.i20, %spec.select.i21
  %t259.i23 = icmp samesign ult i32 %spec.store.select.i20, %spec.select.i21
  %or.cond.i24 = select i1 %t17.i22, i1 %t259.i23, i1 false
  br i1 %or.cond.i24, label %whileBody114.i26, label %slice.exit35

whileBody114.i26:                                 ; preds = %slice.exit, %whileBody114.i26
  %storemerge11.i27 = phi i32 [ %t35.i33, %whileBody114.i26 ], [ %spec.store.select.i20, %slice.exit ]
  %t33810.i28 = phi ptr [ %t33.i32, %whileBody114.i26 ], [ @.str_stdlib_stdlib_0, %slice.exit ]
  %14 = zext nneg i32 %storemerge11.i27 to i64
  %t29.i29 = getelementptr i8, ptr %t1.tr, i64 %14
  %t30.i30 = load i8, ptr %t29.i29, align 1
  %t31.i31 = tail call ptr @zen_char_to_string(i8 %t30.i30)
  %t33.i32 = tail call ptr @str_concat(ptr %t33810.i28, ptr %t31.i31)
  %t35.i33 = add nuw nsw i32 %storemerge11.i27, 1
  %t25.i34 = icmp slt i32 %t35.i33, %spec.select.i21
  br i1 %t25.i34, label %whileBody114.i26, label %slice.exit35

slice.exit35:                                     ; preds = %whileBody114.i26, %slice.exit
  %common.ret.op.i25 = phi ptr [ @.str_stdlib_stdlib_0, %slice.exit ], [ %t33.i32, %whileBody114.i26 ]
  %t89 = tail call i1 @match(ptr %common.ret.op.i18, ptr %common.ret.op.i25)
  br i1 %t89, label %common.ret, label %whileCond346

end342.tail:                                      ; preds = %sub_0201
  %15 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %16 = load i8, ptr %15, align 1
  %17 = icmp eq i8 %16, 0
  br i1 %17, label %if352, label %end455

if352:                                            ; preds = %end342.tail
  %t99 = add nsw i32 %storemerge1.in.peel, 1
  %t5.i36 = tail call i32 @strlen(ptr %t1.tr)
  %t9.i37 = icmp slt i32 %storemerge1.in.peel, -1
  %t12.i38 = icmp sge i32 %t99, %t5.i36
  %t7.i39 = select i1 %t9.i37, i1 true, i1 %t12.i38
  br i1 %t7.i39, label %sub_0210, label %end116.i40

end116.i40:                                       ; preds = %if352
  %18 = zext nneg i32 %t99 to i64
  %t16.i41 = getelementptr i8, ptr %t1.tr, i64 %18
  %t17.i42 = load i8, ptr %t16.i41, align 1
  %t18.i43 = tail call ptr @zen_char_to_string(i8 %t17.i42)
  br label %sub_0210

sub_0210:                                         ; preds = %end116.i40, %if352
  %common.ret.op.i44 = phi ptr [ %t18.i43, %end116.i40 ], [ @.str_stdlib_stdlib_0, %if352 ]
  %19 = load i8, ptr %common.ret.op.i44, align 1
  switch i8 %19, label %end368.tail.sub_0234_crit_edge [
    i8 100, label %charAt.exit45.tail
    i8 97, label %end353.tail
    i8 120, label %end362.tail
    i8 115, label %end368.tail
  ]

charAt.exit45.tail:                               ; preds = %sub_0210
  %20 = getelementptr inbounds nuw i8, ptr %common.ret.op.i44, i64 1
  %21 = load i8, ptr %20, align 1
  %22 = icmp eq i8 %21, 0
  br i1 %22, label %if354, label %end368.tail.sub_0234_crit_edge

if354:                                            ; preds = %charAt.exit45.tail
  %t109 = tail call i32 @strlen(ptr %t0)
  %t110.not = icmp slt i32 %t69, %t109
  br i1 %t110.not, label %end355, label %common.ret

end355:                                           ; preds = %if354
  %t5.i46 = tail call i32 @strlen(ptr %t0)
  %t9.i47 = icmp slt i32 %t69, 0
  %t12.i48 = icmp sge i32 %t69, %t5.i46
  %t7.i49 = select i1 %t9.i47, i1 true, i1 %t12.i48
  br i1 %t7.i49, label %sub_0213, label %end116.i50

end116.i50:                                       ; preds = %end355
  %23 = zext nneg i32 %t69 to i64
  %t16.i51 = getelementptr i8, ptr %t0, i64 %23
  %t17.i52 = load i8, ptr %t16.i51, align 1
  %t18.i53 = tail call ptr @zen_char_to_string(i8 %t17.i52)
  br label %sub_0213

sub_0213:                                         ; preds = %end116.i50, %end355
  %common.ret.op.i54 = phi ptr [ %t18.i53, %end116.i50 ], [ @.str_stdlib_stdlib_0, %end355 ]
  %24 = load i8, ptr %common.ret.op.i54, align 1
  %25 = zext i8 %24 to i32
  %.not349 = icmp eq i8 %24, 48
  br i1 %.not349, label %end357, label %charAt.exit55.tail

charAt.exit55.tail:                               ; preds = %sub_0213
  %t120 = icmp ult i8 %24, 48
  br i1 %t120, label %common.ret, label %sub_0216

sub_0216:                                         ; preds = %charAt.exit55.tail
  %26 = add nsw i32 %25, -57
  %.not350 = icmp eq i32 %26, 0
  br i1 %.not350, label %sub_1217, label %rhs358.tail

sub_1217:                                         ; preds = %sub_0216
  %27 = getelementptr inbounds nuw i8, ptr %common.ret.op.i54, i64 1
  %28 = load i8, ptr %27, align 1
  %29 = zext i8 %28 to i32
  br label %rhs358.tail

rhs358.tail:                                      ; preds = %sub_0216, %sub_1217
  %30 = phi i32 [ %26, %sub_0216 ], [ %29, %sub_1217 ]
  %t125 = icmp sgt i32 %30, 0
  br i1 %t125, label %common.ret, label %end357

end357:                                           ; preds = %sub_0213, %rhs358.tail
  %t129 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

end353.tail:                                      ; preds = %sub_0210
  %31 = getelementptr inbounds nuw i8, ptr %common.ret.op.i44, i64 1
  %32 = load i8, ptr %31, align 1
  %33 = icmp eq i8 %32, 0
  br i1 %33, label %if363, label %end368.tail.sub_0234_crit_edge

if363:                                            ; preds = %end353.tail
  %t137 = tail call i32 @strlen(ptr %t0)
  %t138.not = icmp slt i32 %t69, %t137
  br i1 %t138.not, label %end364, label %common.ret

end364:                                           ; preds = %if363
  %t5.i56 = tail call i32 @strlen(ptr %t0)
  %t9.i57 = icmp slt i32 %t69, 0
  %t12.i58 = icmp sge i32 %t69, %t5.i56
  %t7.i59 = select i1 %t9.i57, i1 true, i1 %t12.i58
  br i1 %t7.i59, label %charAt.exit65, label %end116.i60

end116.i60:                                       ; preds = %end364
  %34 = zext nneg i32 %t69 to i64
  %t16.i61 = getelementptr i8, ptr %t0, i64 %34
  %t17.i62 = load i8, ptr %t16.i61, align 1
  %t18.i63 = tail call ptr @zen_char_to_string(i8 %t17.i62)
  br label %charAt.exit65

charAt.exit65:                                    ; preds = %end364, %end116.i60
  %common.ret.op.i64 = phi ptr [ %t18.i63, %end116.i60 ], [ @.str_stdlib_stdlib_0, %end364 ]
  %t145 = tail call i1 @contains(ptr nonnull @.str_stdlib_stdlib_16, ptr %common.ret.op.i64)
  br i1 %t145, label %end366, label %common.ret

end366:                                           ; preds = %charAt.exit65
  %t150 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

end362.tail:                                      ; preds = %sub_0210
  %35 = getelementptr inbounds nuw i8, ptr %common.ret.op.i44, i64 1
  %36 = load i8, ptr %35, align 1
  %37 = icmp eq i8 %36, 0
  br i1 %37, label %if369, label %end368.tail.sub_0234_crit_edge

if369:                                            ; preds = %end362.tail
  %t158 = tail call i32 @strlen(ptr %t0)
  %t159.not = icmp slt i32 %t69, %t158
  br i1 %t159.not, label %end370, label %common.ret

end370:                                           ; preds = %if369
  %t5.i66 = tail call i32 @strlen(ptr %t0)
  %t9.i67 = icmp slt i32 %t69, 0
  %t12.i68 = icmp sge i32 %t69, %t5.i66
  %t7.i69 = select i1 %t9.i67, i1 true, i1 %t12.i68
  br i1 %t7.i69, label %charAt.exit75, label %end116.i70

end116.i70:                                       ; preds = %end370
  %38 = zext nneg i32 %t69 to i64
  %t16.i71 = getelementptr i8, ptr %t0, i64 %38
  %t17.i72 = load i8, ptr %t16.i71, align 1
  %t18.i73 = tail call ptr @zen_char_to_string(i8 %t17.i72)
  br label %charAt.exit75

charAt.exit75:                                    ; preds = %end370, %end116.i70
  %common.ret.op.i74 = phi ptr [ %t18.i73, %end116.i70 ], [ @.str_stdlib_stdlib_0, %end370 ]
  %t166 = tail call i1 @contains(ptr nonnull @.str_stdlib_stdlib_18, ptr %common.ret.op.i74)
  br i1 %t166, label %end372, label %common.ret

end372:                                           ; preds = %charAt.exit75
  %t171 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

end368.tail:                                      ; preds = %sub_0210
  %39 = getelementptr inbounds nuw i8, ptr %common.ret.op.i44, i64 1
  %40 = load i8, ptr %39, align 1
  %41 = icmp eq i8 %40, 0
  br i1 %41, label %if375, label %end368.tail.sub_0234_crit_edge

end368.tail.sub_0234_crit_edge:                   ; preds = %sub_0210, %end353.tail, %charAt.exit45.tail, %end362.tail, %end368.tail
  %.pre = load i8, ptr %common.ret.op.i14, align 1
  br label %sub_0234

if375:                                            ; preds = %end368.tail
  %t179 = tail call i32 @strlen(ptr %t0)
  %t180.not = icmp slt i32 %t69, %t179
  br i1 %t180.not, label %end376, label %common.ret

end376:                                           ; preds = %if375
  %t5.i76 = tail call i32 @strlen(ptr %t0)
  %t9.i77 = icmp slt i32 %t69, 0
  %t12.i78 = icmp sge i32 %t69, %t5.i76
  %t7.i79 = select i1 %t9.i77, i1 true, i1 %t12.i78
  br i1 %t7.i79, label %sub_0228, label %end116.i80

end116.i80:                                       ; preds = %end376
  %42 = zext nneg i32 %t69 to i64
  %t16.i81 = getelementptr i8, ptr %t0, i64 %42
  %t17.i82 = load i8, ptr %t16.i81, align 1
  %t18.i83 = tail call ptr @zen_char_to_string(i8 %t17.i82)
  br label %sub_0228

sub_0228:                                         ; preds = %end116.i80, %end376
  %common.ret.op.i84 = phi ptr [ %t18.i83, %end116.i80 ], [ @.str_stdlib_stdlib_0, %end376 ]
  %43 = load i8, ptr %common.ret.op.i84, align 1
  switch i8 %43, label %common.ret [
    i8 32, label %charAt.exit85.tail
    i8 9, label %rhs379.tail
  ]

charAt.exit85.tail:                               ; preds = %sub_0228
  %44 = getelementptr inbounds nuw i8, ptr %common.ret.op.i84, i64 1
  %45 = load i8, ptr %44, align 1
  %46 = icmp eq i8 %45, 0
  br i1 %46, label %end378, label %common.ret

rhs379.tail:                                      ; preds = %sub_0228
  %47 = getelementptr inbounds nuw i8, ptr %common.ret.op.i84, i64 1
  %48 = load i8, ptr %47, align 1
  %49 = icmp eq i8 %48, 0
  br i1 %49, label %end378, label %common.ret

end378:                                           ; preds = %charAt.exit85.tail, %rhs379.tail
  %t199 = add i32 %storemerge1.in.peel, 2
  br label %whileCond335.backedge

sub_0234:                                         ; preds = %sub_0201, %end368.tail.sub_0234_crit_edge
  %50 = phi i8 [ %.pre, %end368.tail.sub_0234_crit_edge ], [ %6, %sub_0201 ]
  %.not335 = icmp eq i8 %50, 58
  br i1 %.not335, label %end351.tail, label %sub_0258

end351.tail:                                      ; preds = %sub_0234
  %51 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %52 = load i8, ptr %51, align 1
  %53 = icmp eq i8 %52, 0
  br i1 %53, label %if384, label %end455

if384:                                            ; preds = %end351.tail
  %t211278 = tail call i32 @strlen(ptr %t1.tr)
  %t212279 = icmp slt i32 %storemerge1.in.peel, %t211278
  br i1 %t212279, label %whileBody386, label %whileEnd387

whileBody386:                                     ; preds = %if384, %end388
  %storemerge281 = phi i32 [ %t232, %end388 ], [ %storemerge1.in.peel, %if384 ]
  %t230277280 = phi ptr [ %t230, %end388 ], [ @.str_stdlib_stdlib_0, %if384 ]
  %t5.i86 = tail call i32 @strlen(ptr %t1.tr)
  %t9.i87 = icmp slt i32 %storemerge281, 0
  %t12.i88 = icmp sge i32 %storemerge281, %t5.i86
  %t7.i89 = select i1 %t9.i87, i1 true, i1 %t12.i88
  br i1 %t7.i89, label %sub_0237, label %end116.i90

end116.i90:                                       ; preds = %whileBody386
  %54 = zext nneg i32 %storemerge281 to i64
  %t16.i91 = getelementptr i8, ptr %t1.tr, i64 %54
  %t17.i92 = load i8, ptr %t16.i91, align 1
  %t18.i93 = tail call ptr @zen_char_to_string(i8 %t17.i92)
  br label %sub_0237

sub_0237:                                         ; preds = %end116.i90, %whileBody386
  %common.ret.op.i94 = phi ptr [ %t18.i93, %end116.i90 ], [ @.str_stdlib_stdlib_0, %whileBody386 ]
  %55 = load i8, ptr %common.ret.op.i94, align 1
  switch i8 %55, label %end388 [
    i8 32, label %charAt.exit95.tail
    i8 124, label %rhs389.tail
  ]

charAt.exit95.tail:                               ; preds = %sub_0237
  %56 = getelementptr inbounds nuw i8, ptr %common.ret.op.i94, i64 1
  %57 = load i8, ptr %56, align 1
  %58 = icmp eq i8 %57, 0
  br i1 %58, label %whileEnd387, label %end388

rhs389.tail:                                      ; preds = %sub_0237
  %59 = getelementptr inbounds nuw i8, ptr %common.ret.op.i94, i64 1
  %60 = load i8, ptr %59, align 1
  %61 = icmp eq i8 %60, 0
  br i1 %61, label %whileEnd387, label %end388

end388:                                           ; preds = %sub_0237, %charAt.exit95.tail, %rhs389.tail
  %t230 = tail call ptr @str_concat(ptr %t230277280, ptr nonnull %common.ret.op.i94)
  %t232 = add nsw i32 %storemerge281, 1
  %t211 = tail call i32 @strlen(ptr %t1.tr)
  %t212 = icmp slt i32 %t232, %t211
  br i1 %t212, label %whileBody386, label %whileEnd387

whileEnd387:                                      ; preds = %end388, %rhs389.tail, %charAt.exit95.tail, %if384
  %t230277.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %if384 ], [ %t230277280, %charAt.exit95.tail ], [ %t230277280, %rhs389.tail ], [ %t230, %end388 ]
  %t236 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t230277.lcssa, ptr noundef nonnull dereferenceable(5) @.str_stdlib_stdlib_21)
  %t237 = icmp eq i32 %t236, 0
  br i1 %t237, label %if394, label %end393

if394:                                            ; preds = %whileEnd387
  %t243 = tail call i32 @strlen(ptr %t0)
  %t244 = icmp slt i32 %t69, %t243
  br i1 %t244, label %rhs396, label %end395

rhs396:                                           ; preds = %if394
  %t247 = tail call ptr @charAt(ptr %t0, i32 %t69)
  %62 = load i8, ptr %t247, align 1
  %.not344 = icmp eq i8 %62, 45
  br i1 %.not344, label %rhs396.tail, label %end395

rhs396.tail:                                      ; preds = %rhs396
  %63 = getelementptr inbounds nuw i8, ptr %t247, i64 1
  %64 = load i8, ptr %63, align 1
  %65 = icmp eq i8 %64, 0
  %t253 = zext i1 %65 to i32
  %spec.select = add nsw i32 %t69, %t253
  br label %end395

end395:                                           ; preds = %rhs396.tail, %rhs396, %if394
  %t35.promoted306 = phi i32 [ %t69, %if394 ], [ %t69, %rhs396 ], [ %spec.select, %rhs396.tail ]
  %t256 = tail call i32 @strlen(ptr %t0)
  %t257.not = icmp slt i32 %t35.promoted306, %t256
  br i1 %t257.not, label %whileCond402.preheader, label %common.ret

whileCond402.preheader:                           ; preds = %end395
  %t262308 = tail call i32 @strlen(ptr %t0)
  %t263309 = icmp slt i32 %t35.promoted306, %t262308
  br i1 %t263309, label %whileBody403, label %common.ret

whileBody403:                                     ; preds = %whileCond402.preheader, %end405
  %t280307310 = phi i32 [ %t280, %end405 ], [ %t35.promoted306, %whileCond402.preheader ]
  %t5.i96 = tail call i32 @strlen(ptr %t0)
  %t9.i97 = icmp slt i32 %t280307310, 0
  %t12.i98 = icmp sge i32 %t280307310, %t5.i96
  %t7.i99 = select i1 %t9.i97, i1 true, i1 %t12.i98
  br i1 %t7.i99, label %sub_0246, label %end116.i100

end116.i100:                                      ; preds = %whileBody403
  %66 = zext nneg i32 %t280307310 to i64
  %t16.i101 = getelementptr i8, ptr %t0, i64 %66
  %t17.i102 = load i8, ptr %t16.i101, align 1
  %t18.i103 = tail call ptr @zen_char_to_string(i8 %t17.i102)
  br label %sub_0246

sub_0246:                                         ; preds = %end116.i100, %whileBody403
  %common.ret.op.i104 = phi ptr [ %t18.i103, %end116.i100 ], [ @.str_stdlib_stdlib_0, %whileBody403 ]
  %67 = load i8, ptr %common.ret.op.i104, align 1
  %68 = zext i8 %67 to i32
  %.not345 = icmp eq i8 %67, 48
  br i1 %.not345, label %end405, label %charAt.exit105.tail

charAt.exit105.tail:                              ; preds = %sub_0246
  %t273 = icmp ult i8 %67, 48
  br i1 %t273, label %whileEnd404, label %sub_0249

sub_0249:                                         ; preds = %charAt.exit105.tail
  %69 = add nsw i32 %68, -57
  %.not346 = icmp eq i32 %69, 0
  br i1 %.not346, label %sub_1250, label %rhs406.tail

sub_1250:                                         ; preds = %sub_0249
  %70 = getelementptr inbounds nuw i8, ptr %common.ret.op.i104, i64 1
  %71 = load i8, ptr %70, align 1
  %72 = zext i8 %71 to i32
  br label %rhs406.tail

rhs406.tail:                                      ; preds = %sub_0249, %sub_1250
  %73 = phi i32 [ %69, %sub_0249 ], [ %72, %sub_1250 ]
  %t278 = icmp sgt i32 %73, 0
  br i1 %t278, label %whileEnd404, label %end405

end405:                                           ; preds = %sub_0246, %rhs406.tail
  %t280 = add nsw i32 %t280307310, 1
  %t262 = tail call i32 @strlen(ptr %t0)
  %t263 = icmp slt i32 %t280, %t262
  br i1 %t263, label %whileBody403, label %whileEnd404

whileEnd404:                                      ; preds = %end405, %rhs406.tail, %charAt.exit105.tail
  %t280307.lcssa = phi i32 [ %t280, %end405 ], [ %t280307310, %rhs406.tail ], [ %t280307310, %charAt.exit105.tail ]
  %t283.not = icmp sgt i32 %t280307.lcssa, %t35.promoted306
  br i1 %t283.not, label %end410, label %common.ret

end410:                                           ; preds = %whileEnd404
  %t286 = tail call i32 @strlen(ptr %t0)
  %t287 = icmp eq i32 %t280307.lcssa, %t286
  br label %common.ret

end393:                                           ; preds = %whileEnd387
  %t291 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t230277.lcssa, ptr noundef nonnull dereferenceable(4) @.str_stdlib_stdlib_23)
  %t292 = icmp eq i32 %t291, 0
  br i1 %t292, label %if413, label %end412

if413:                                            ; preds = %end393
  %t295 = tail call i32 @strlen(ptr %t0)
  %t296.not = icmp slt i32 %t69, %t295
  br i1 %t296.not, label %end414, label %common.ret

end414:                                           ; preds = %if413
  %t299 = tail call ptr @charAt(ptr %t0, i32 %t69)
  %t307 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t299, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_1)
  %t308 = icmp sgt i32 %t307, -1
  br i1 %t308, label %rhs423, label %rhs420

rhs423:                                           ; preds = %end414
  %t312 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t299, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_2)
  %t313 = icmp slt i32 %t312, 1
  br i1 %t313, label %end416, label %rhs420

rhs420:                                           ; preds = %end414, %rhs423
  %t318 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t299, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_3)
  %t319 = icmp sgt i32 %t318, -1
  br i1 %t319, label %rhs426, label %sub_0252

rhs426:                                           ; preds = %rhs420
  %t323 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t299, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_4)
  %t324 = icmp slt i32 %t323, 1
  br i1 %t324, label %end416, label %sub_0252

sub_0252:                                         ; preds = %rhs426, %rhs420
  %74 = load i8, ptr %t299, align 1
  %.not342 = icmp eq i8 %74, 95
  br i1 %.not342, label %rhs417.tail, label %common.ret

rhs417.tail:                                      ; preds = %sub_0252
  %75 = getelementptr inbounds nuw i8, ptr %t299, i64 1
  %76 = load i8, ptr %75, align 1
  %77 = icmp eq i8 %76, 0
  br i1 %77, label %end416, label %common.ret

end416:                                           ; preds = %rhs423, %rhs426, %rhs417.tail
  %storemerge2298 = add nsw i32 %t69, 1
  %t335299 = tail call i32 @strlen(ptr %t0)
  %t336300 = icmp slt i32 %storemerge2298, %t335299
  br i1 %t336300, label %whileBody431, label %whileEnd432

whileBody431:                                     ; preds = %end416, %end433
  %storemerge2301 = phi i32 [ %storemerge2, %end433 ], [ %storemerge2298, %end416 ]
  %t5.i106 = tail call i32 @strlen(ptr %t0)
  %t9.i107 = icmp slt i32 %storemerge2301, 0
  %t12.i108 = icmp sge i32 %storemerge2301, %t5.i106
  %t7.i109 = select i1 %t9.i107, i1 true, i1 %t12.i108
  br i1 %t7.i109, label %charAt.exit115, label %end116.i110

end116.i110:                                      ; preds = %whileBody431
  %78 = zext nneg i32 %storemerge2301 to i64
  %t16.i111 = getelementptr i8, ptr %t0, i64 %78
  %t17.i112 = load i8, ptr %t16.i111, align 1
  %t18.i113 = tail call ptr @zen_char_to_string(i8 %t17.i112)
  br label %charAt.exit115

charAt.exit115:                                   ; preds = %whileBody431, %end116.i110
  %common.ret.op.i114 = phi ptr [ %t18.i113, %end116.i110 ], [ @.str_stdlib_stdlib_0, %whileBody431 ]
  %t348 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i114, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_1)
  %t349 = icmp sgt i32 %t348, -1
  br i1 %t349, label %rhs443, label %rhs440

rhs443:                                           ; preds = %charAt.exit115
  %t353 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i114, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_2)
  %t354 = icmp slt i32 %t353, 1
  br i1 %t354, label %end433, label %rhs440

rhs440:                                           ; preds = %charAt.exit115, %rhs443
  %t359 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i114, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_3)
  %t360 = icmp sgt i32 %t359, -1
  br i1 %t360, label %rhs446, label %rhs437

rhs446:                                           ; preds = %rhs440
  %t364 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i114, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_4)
  %t365 = icmp slt i32 %t364, 1
  br i1 %t365, label %end433, label %rhs437

rhs437:                                           ; preds = %rhs440, %rhs446
  %t370 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i114, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_14)
  %t371 = icmp sgt i32 %t370, -1
  br i1 %t371, label %rhs449, label %sub_0255

rhs449:                                           ; preds = %rhs437
  %t375 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i114, ptr noundef nonnull dereferenceable(2) @.str_stdlib_stdlib_15)
  %t376 = icmp slt i32 %t375, 1
  br i1 %t376, label %end433, label %sub_0255

sub_0255:                                         ; preds = %rhs449, %rhs437
  %79 = load i8, ptr %common.ret.op.i114, align 1
  %.not343 = icmp eq i8 %79, 95
  br i1 %.not343, label %rhs434.tail, label %whileEnd432

rhs434.tail:                                      ; preds = %sub_0255
  %80 = getelementptr inbounds nuw i8, ptr %common.ret.op.i114, i64 1
  %81 = load i8, ptr %80, align 1
  %82 = icmp eq i8 %81, 0
  br i1 %82, label %end433, label %whileEnd432

end433:                                           ; preds = %rhs443, %rhs446, %rhs449, %rhs434.tail
  %storemerge2 = add nsw i32 %storemerge2301, 1
  %t335 = tail call i32 @strlen(ptr %t0)
  %t336 = icmp slt i32 %storemerge2, %t335
  br i1 %t336, label %whileBody431, label %whileEnd432

whileEnd432:                                      ; preds = %sub_0255, %end433, %rhs434.tail, %end416
  %storemerge2.lcssa297 = phi i32 [ %storemerge2298, %end416 ], [ %storemerge2301, %sub_0255 ], [ %storemerge2301, %rhs434.tail ], [ %storemerge2, %end433 ]
  %t387 = tail call i32 @strlen(ptr %t0)
  %t388 = icmp eq i32 %storemerge2.lcssa297, %t387
  br label %common.ret

end412:                                           ; preds = %end393
  %t392 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t230277.lcssa, ptr noundef nonnull dereferenceable(8) @.str_stdlib_stdlib_25)
  %t393 = icmp eq i32 %t392, 0
  br i1 %t393, label %if454, label %end412.sub_0258_crit_edge

end412.sub_0258_crit_edge:                        ; preds = %end412
  %.pre360 = load i8, ptr %common.ret.op.i14, align 1
  br label %sub_0258

if454:                                            ; preds = %end412
  %t396 = tail call i32 @strlen(ptr %t0)
  %t397 = icmp slt i32 %t69, %t396
  br label %common.ret

sub_0258:                                         ; preds = %sub_0234, %end412.sub_0258_crit_edge
  %83 = phi i8 [ %.pre360, %end412.sub_0258_crit_edge ], [ %50, %sub_0234 ]
  %.not338 = icmp eq i8 %83, 91
  br i1 %.not338, label %end383.tail, label %end455

end383.tail:                                      ; preds = %sub_0258
  %84 = getelementptr inbounds nuw i8, ptr %common.ret.op.i14, i64 1
  %85 = load i8, ptr %84, align 1
  %86 = icmp eq i8 %85, 0
  br i1 %86, label %if456, label %end455

if456:                                            ; preds = %end383.tail
  %storemerge1.peel = add i32 %storemerge1.in.peel, 1
  %t408.peel = tail call i32 @strlen(ptr %t1.tr)
  %t409.peel = icmp slt i32 %storemerge1.peel, %t408.peel
  br i1 %t409.peel, label %whileBody458.peel, label %whileEnd459

whileBody458.peel:                                ; preds = %if456
  %t5.i116.peel = tail call i32 @strlen(ptr %t1.tr)
  %t9.i117.peel = icmp slt i32 %storemerge1.peel, 0
  %t12.i118.peel = icmp sge i32 %storemerge1.peel, %t5.i116.peel
  %t7.i119.peel = select i1 %t9.i117.peel, i1 true, i1 %t12.i118.peel
  br i1 %t7.i119.peel, label %sub_0261.peel, label %end116.i120.peel

end116.i120.peel:                                 ; preds = %whileBody458.peel
  %87 = zext nneg i32 %storemerge1.peel to i64
  %t16.i121.peel = getelementptr i8, ptr %t1.tr, i64 %87
  %t17.i122.peel = load i8, ptr %t16.i121.peel, align 1
  %t18.i123.peel = tail call ptr @zen_char_to_string(i8 %t17.i122.peel)
  br label %sub_0261.peel

sub_0261.peel:                                    ; preds = %end116.i120.peel, %whileBody458.peel
  %common.ret.op.i124.peel = phi ptr [ %t18.i123.peel, %end116.i120.peel ], [ @.str_stdlib_stdlib_0, %whileBody458.peel ]
  %88 = load i8, ptr %common.ret.op.i124.peel, align 1
  %.not339.peel = icmp eq i8 %88, 93
  br i1 %.not339.peel, label %charAt.exit125.tail.peel, label %whileCond457.peel.next

charAt.exit125.tail.peel:                         ; preds = %sub_0261.peel
  %89 = getelementptr inbounds nuw i8, ptr %common.ret.op.i124.peel, i64 1
  %90 = load i8, ptr %89, align 1
  %91 = icmp eq i8 %90, 0
  br i1 %91, label %whileEnd459, label %whileCond457.peel.next

whileCond457.peel.next:                           ; preds = %sub_0261.peel, %charAt.exit125.tail.peel
  %storemerge1445 = add i32 %storemerge1.in.peel, 2
  %t408446 = tail call i32 @strlen(ptr %t1.tr)
  %t409447 = icmp slt i32 %storemerge1445, %t408446
  br i1 %t409447, label %whileBody458, label %whileEnd459

whileBody458:                                     ; preds = %whileCond457.peel.next, %whileCond457.backedge
  %storemerge1449 = phi i32 [ %storemerge1, %whileCond457.backedge ], [ %storemerge1445, %whileCond457.peel.next ]
  %storemerge1.in448 = phi i32 [ %storemerge1449, %whileCond457.backedge ], [ %storemerge1.peel, %whileCond457.peel.next ]
  %t5.i116 = tail call i32 @strlen(ptr %t1.tr)
  %t9.i117 = icmp slt i32 %storemerge1.in448, -1
  %t12.i118 = icmp sge i32 %storemerge1449, %t5.i116
  %t7.i119 = select i1 %t9.i117, i1 true, i1 %t12.i118
  br i1 %t7.i119, label %sub_0261, label %end116.i120

end116.i120:                                      ; preds = %whileBody458
  %92 = zext nneg i32 %storemerge1449 to i64
  %t16.i121 = getelementptr i8, ptr %t1.tr, i64 %92
  %t17.i122 = load i8, ptr %t16.i121, align 1
  %t18.i123 = tail call ptr @zen_char_to_string(i8 %t17.i122)
  br label %sub_0261

sub_0261:                                         ; preds = %end116.i120, %whileBody458
  %common.ret.op.i124 = phi ptr [ %t18.i123, %end116.i120 ], [ @.str_stdlib_stdlib_0, %whileBody458 ]
  %93 = load i8, ptr %common.ret.op.i124, align 1
  %.not339 = icmp eq i8 %93, 93
  br i1 %.not339, label %sub_1262, label %whileCond457.backedge

sub_1262:                                         ; preds = %sub_0261
  %94 = getelementptr inbounds nuw i8, ptr %common.ret.op.i124, i64 1
  %95 = load i8, ptr %94, align 1
  %96 = icmp eq i8 %95, 0
  br i1 %96, label %whileEnd459, label %whileCond457.backedge

whileCond457.backedge:                            ; preds = %sub_0261, %sub_1262
  %storemerge1 = add nsw i32 %storemerge1449, 1
  %t408 = tail call i32 @strlen(ptr %t1.tr)
  %t409 = icmp slt i32 %storemerge1, %t408
  br i1 %t409, label %whileBody458, label %whileEnd459, !llvm.loop !0

whileEnd459:                                      ; preds = %sub_1262, %whileCond457.backedge, %whileCond457.peel.next, %charAt.exit125.tail.peel, %if456
  %storemerge1.in.lcssa = phi i32 [ %storemerge1.in.peel, %if456 ], [ %storemerge1.in.peel, %charAt.exit125.tail.peel ], [ %storemerge1.peel, %whileCond457.peel.next ], [ %storemerge1449, %whileCond457.backedge ], [ %storemerge1.in448, %sub_1262 ]
  %storemerge1.lcssa = phi i32 [ %storemerge1.peel, %if456 ], [ %storemerge1.peel, %charAt.exit125.tail.peel ], [ %storemerge1445, %whileCond457.peel.next ], [ %storemerge1, %whileCond457.backedge ], [ %storemerge1449, %sub_1262 ]
  %t7.i126 = tail call i32 @strlen(ptr %t1.tr)
  %spec.store.select.i127 = tail call i32 @llvm.smax.i32(i32 %storemerge1.peel, i32 0)
  %spec.select.i128 = tail call i32 @llvm.smin.i32(i32 %storemerge1.lcssa, i32 %t7.i126)
  %t17.i129 = icmp sle i32 %spec.store.select.i127, %spec.select.i128
  %t259.i130 = icmp samesign ult i32 %spec.store.select.i127, %spec.select.i128
  %or.cond.i131 = select i1 %t17.i129, i1 %t259.i130, i1 false
  br i1 %or.cond.i131, label %whileBody114.i133, label %slice.exit142

whileBody114.i133:                                ; preds = %whileEnd459, %whileBody114.i133
  %storemerge11.i134 = phi i32 [ %t35.i140, %whileBody114.i133 ], [ %spec.store.select.i127, %whileEnd459 ]
  %t33810.i135 = phi ptr [ %t33.i139, %whileBody114.i133 ], [ @.str_stdlib_stdlib_0, %whileEnd459 ]
  %97 = zext nneg i32 %storemerge11.i134 to i64
  %t29.i136 = getelementptr i8, ptr %t1.tr, i64 %97
  %t30.i137 = load i8, ptr %t29.i136, align 1
  %t31.i138 = tail call ptr @zen_char_to_string(i8 %t30.i137)
  %t33.i139 = tail call ptr @str_concat(ptr %t33810.i135, ptr %t31.i138)
  %t35.i140 = add nuw nsw i32 %storemerge11.i134, 1
  %t25.i141 = icmp slt i32 %t35.i140, %spec.select.i128
  br i1 %t25.i141, label %whileBody114.i133, label %slice.exit142

slice.exit142:                                    ; preds = %whileBody114.i133, %whileEnd459
  %common.ret.op.i132 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd459 ], [ %t33.i139, %whileBody114.i133 ]
  %t427 = tail call i32 @strlen(ptr %t0)
  %t428.not = icmp slt i32 %t69, %t427
  br i1 %t428.not, label %end462, label %common.ret

end462:                                           ; preds = %slice.exit142
  %t5.i143 = tail call i32 @strlen(ptr %t0)
  %t9.i144 = icmp slt i32 %t69, 0
  %t12.i145 = icmp sge i32 %t69, %t5.i143
  %t7.i146 = select i1 %t9.i144, i1 true, i1 %t12.i145
  br i1 %t7.i146, label %charAt.exit152, label %end116.i147

end116.i147:                                      ; preds = %end462
  %98 = zext nneg i32 %t69 to i64
  %t16.i148 = getelementptr i8, ptr %t0, i64 %98
  %t17.i149 = load i8, ptr %t16.i148, align 1
  %t18.i150 = tail call ptr @zen_char_to_string(i8 %t17.i149)
  br label %charAt.exit152

charAt.exit152:                                   ; preds = %end462, %end116.i147
  %common.ret.op.i151 = phi ptr [ %t18.i150, %end116.i147 ], [ @.str_stdlib_stdlib_0, %end462 ]
  %t436 = tail call i32 @strlen(ptr %common.ret.op.i132)
  %t437 = icmp eq i32 %t436, 3
  br i1 %t437, label %rhs465, label %else469

rhs465:                                           ; preds = %charAt.exit152
  %t5.i153 = tail call i32 @strlen(ptr %common.ret.op.i132)
  %t12.i154 = icmp slt i32 %t5.i153, 2
  br i1 %t12.i154, label %sub_0264, label %end116.i156

end116.i156:                                      ; preds = %rhs465
  %t16.i157 = getelementptr i8, ptr %common.ret.op.i132, i64 1
  %t17.i158 = load i8, ptr %t16.i157, align 1
  %t18.i159 = tail call ptr @zen_char_to_string(i8 %t17.i158)
  br label %sub_0264

sub_0264:                                         ; preds = %end116.i156, %rhs465
  %common.ret.op.i160 = phi ptr [ %t18.i159, %end116.i156 ], [ @.str_stdlib_stdlib_0, %rhs465 ]
  %99 = load i8, ptr %common.ret.op.i160, align 1
  %.not340 = icmp eq i8 %99, 45
  br i1 %.not340, label %charAt.exit161.tail, label %else469

charAt.exit161.tail:                              ; preds = %sub_0264
  %100 = getelementptr inbounds nuw i8, ptr %common.ret.op.i160, i64 1
  %101 = load i8, ptr %100, align 1
  %102 = icmp eq i8 %101, 0
  br i1 %102, label %if468, label %else469

if468:                                            ; preds = %charAt.exit161.tail
  %t5.i162 = tail call i32 @strlen(ptr %common.ret.op.i132)
  %t12.i163 = icmp slt i32 %t5.i162, 1
  br i1 %t12.i163, label %charAt.exit170, label %end116.i165

end116.i165:                                      ; preds = %if468
  %t17.i167 = load i8, ptr %common.ret.op.i132, align 1
  %t18.i168 = tail call ptr @zen_char_to_string(i8 %t17.i167)
  br label %charAt.exit170

charAt.exit170:                                   ; preds = %if468, %end116.i165
  %common.ret.op.i169 = phi ptr [ %t18.i168, %end116.i165 ], [ @.str_stdlib_stdlib_0, %if468 ]
  %t5.i171 = tail call i32 @strlen(ptr %common.ret.op.i132)
  %t12.i172 = icmp slt i32 %t5.i171, 3
  br i1 %t12.i172, label %charAt.exit179, label %end116.i174

end116.i174:                                      ; preds = %charAt.exit170
  %t16.i175 = getelementptr i8, ptr %common.ret.op.i132, i64 2
  %t17.i176 = load i8, ptr %t16.i175, align 1
  %t18.i177 = tail call ptr @zen_char_to_string(i8 %t17.i176)
  br label %charAt.exit179

charAt.exit179:                                   ; preds = %charAt.exit170, %end116.i174
  %common.ret.op.i178 = phi ptr [ %t18.i177, %end116.i174 ], [ @.str_stdlib_stdlib_0, %charAt.exit170 ]
  %t454 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i151, ptr noundef nonnull dereferenceable(1) %common.ret.op.i169)
  %t455 = icmp sgt i32 %t454, -1
  br i1 %t455, label %rhs471, label %common.ret

rhs471:                                           ; preds = %charAt.exit179
  %t459 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i151, ptr noundef nonnull dereferenceable(1) %common.ret.op.i178)
  %t460 = icmp slt i32 %t459, 1
  br i1 %t460, label %end482, label %common.ret

else469:                                          ; preds = %sub_0264, %charAt.exit152, %charAt.exit161.tail
  %t462284 = load i32, ptr @t_stdlib_78, align 4
  %t464285 = tail call i32 @strlen(ptr %common.ret.op.i132)
  %t465286 = icmp slt i32 %t462284, %t464285
  br i1 %t465286, label %whileBody476, label %common.ret

whileBody476:                                     ; preds = %else469, %whileCond475.backedge
  %t467 = load i32, ptr @t_stdlib_78, align 4
  %t5.i180 = tail call i32 @strlen(ptr %common.ret.op.i132)
  %t9.i181 = icmp slt i32 %t467, 0
  %t12.i182 = icmp sge i32 %t467, %t5.i180
  %t7.i183 = select i1 %t9.i181, i1 true, i1 %t12.i182
  br i1 %t7.i183, label %sub_0267, label %end116.i184

end116.i184:                                      ; preds = %whileBody476
  %103 = zext nneg i32 %t467 to i64
  %t16.i185 = getelementptr i8, ptr %common.ret.op.i132, i64 %103
  %t17.i186 = load i8, ptr %t16.i185, align 1
  %t18.i187 = tail call ptr @zen_char_to_string(i8 %t17.i186)
  br label %sub_0267

sub_0267:                                         ; preds = %end116.i184, %whileBody476
  %common.ret.op.i188 = phi ptr [ %t18.i187, %end116.i184 ], [ @.str_stdlib_stdlib_0, %whileBody476 ]
  %104 = load i8, ptr %common.ret.op.i188, align 1
  %.not341 = icmp eq i8 %104, 44
  br i1 %.not341, label %charAt.exit189.tail, label %end478

charAt.exit189.tail:                              ; preds = %sub_0267
  %105 = getelementptr inbounds nuw i8, ptr %common.ret.op.i188, i64 1
  %106 = load i8, ptr %105, align 1
  %107 = icmp eq i8 %106, 0
  br i1 %107, label %whileCond475.backedge, label %end478

whileCond475.backedge:                            ; preds = %end478, %charAt.exit189.tail
  %storemerge.in = load i32, ptr @t_stdlib_78, align 4
  %storemerge = add i32 %storemerge.in, 1
  store i32 %storemerge, ptr @t_stdlib_78, align 4
  %t464 = tail call i32 @strlen(ptr %common.ret.op.i132)
  %t465 = icmp slt i32 %storemerge, %t464
  br i1 %t465, label %whileBody476, label %common.ret

end478:                                           ; preds = %sub_0267, %charAt.exit189.tail
  %t480 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i188, ptr noundef nonnull dereferenceable(1) %common.ret.op.i151)
  %t481 = icmp eq i32 %t480, 0
  br i1 %t481, label %end482, label %whileCond475.backedge

end482:                                           ; preds = %end478, %rhs471
  %t489 = add i32 %storemerge1.in.lcssa, 2
  br label %whileCond335.backedge

end455:                                           ; preds = %end338.tail, %charAt.exit15.tail, %end342.tail, %end351.tail, %sub_0258, %end383.tail
  %t492 = tail call i32 @strlen(ptr %t0)
  %t493.not = icmp slt i32 %t69, %t492
  br i1 %t493.not, label %end484, label %common.ret

end484:                                           ; preds = %end455
  %t5.i190 = tail call i32 @strlen(ptr %t0)
  %t9.i191 = icmp slt i32 %t69, 0
  %t12.i192 = icmp sge i32 %t69, %t5.i190
  %t7.i193 = select i1 %t9.i191, i1 true, i1 %t12.i192
  br i1 %t7.i193, label %charAt.exit199, label %end116.i194

end116.i194:                                      ; preds = %end484
  %108 = zext nneg i32 %t69 to i64
  %t16.i195 = getelementptr i8, ptr %t0, i64 %108
  %t17.i196 = load i8, ptr %t16.i195, align 1
  %t18.i197 = tail call ptr @zen_char_to_string(i8 %t17.i196)
  br label %charAt.exit199

charAt.exit199:                                   ; preds = %end484, %end116.i194
  %common.ret.op.i198 = phi ptr [ %t18.i197, %end116.i194 ], [ @.str_stdlib_stdlib_0, %end484 ]
  %t499 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i198, ptr noundef nonnull dereferenceable(1) %common.ret.op.i14)
  %t500.not = icmp eq i32 %t499, 0
  br i1 %t500.not, label %end486, label %common.ret

end486:                                           ; preds = %charAt.exit199
  %t504 = add i32 %storemerge1.in.peel, 1
  br label %whileCond335.backedge

whileEnd337:                                      ; preds = %whileCond335.backedge, %end325
  %t505 = phi i32 [ 0, %end325 ], [ %t502290, %whileCond335.backedge ]
  %t507 = tail call i32 @strlen(ptr %t0)
  %t508 = icmp eq i32 %t505, %t507
  br label %common.ret
}

define i32 @_json_skipWS(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t75 = tail call i32 @strlen(ptr %t0)
  %t86 = icmp slt i32 %t1, %t75
  br i1 %t86, label %rhs491, label %whileEnd490

rhs491:                                           ; preds = %entry, %whileBody489
  %i.addr.07 = phi i32 [ %t17, %whileBody489 ], [ %t1, %entry ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t9.i = icmp slt i32 %i.addr.07, 0
  %t12.i = icmp sge i32 %i.addr.07, %t5.i
  %t7.i = select i1 %t9.i, i1 true, i1 %t12.i
  br i1 %t7.i, label %sub_0, label %end116.i

end116.i:                                         ; preds = %rhs491
  %0 = zext nneg i32 %i.addr.07 to i64
  %t16.i = getelementptr i8, ptr %t0, i64 %0
  %t17.i = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %rhs491
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %rhs491 ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %1, 32
  br i1 %.not, label %charAt.exit.tail, label %whileEnd490

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileBody489, label %whileEnd490

whileBody489:                                     ; preds = %charAt.exit.tail
  %t17 = add nsw i32 %i.addr.07, 1
  %t7 = tail call i32 @strlen(ptr %t0)
  %t8 = icmp slt i32 %t17, %t7
  br i1 %t8, label %rhs491, label %whileEnd490

whileEnd490:                                      ; preds = %sub_0, %charAt.exit.tail, %whileBody489, %entry
  %i.addr.0.lcssa = phi i32 [ %t1, %entry ], [ %i.addr.07, %sub_0 ], [ %t17, %whileBody489 ], [ %i.addr.07, %charAt.exit.tail ]
  ret i32 %i.addr.0.lcssa
}

define ptr @_json_extractValue(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t75.i = tail call i32 @strlen(ptr %t0)
  %t86.i = icmp slt i32 %t1, %t75.i
  br i1 %t86.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %entry, %whileBody489.i
  %i.addr.07.i = phi i32 [ %t17.i, %whileBody489.i ], [ %t1, %entry ]
  %t5.i.i = tail call i32 @strlen(ptr %t0)
  %t9.i.i = icmp slt i32 %i.addr.07.i, 0
  %t12.i.i = icmp sge i32 %i.addr.07.i, %t5.i.i
  %t7.i.i = select i1 %t9.i.i, i1 true, i1 %t12.i.i
  br i1 %t7.i.i, label %sub_0.i, label %end116.i.i

end116.i.i:                                       ; preds = %rhs491.i
  %0 = zext nneg i32 %i.addr.07.i to i64
  %t16.i.i = getelementptr i8, ptr %t0, i64 %0
  %t17.i.i = load i8, ptr %t16.i.i, align 1
  %t18.i.i = tail call ptr @zen_char_to_string(i8 %t17.i.i)
  br label %sub_0.i

sub_0.i:                                          ; preds = %end116.i.i, %rhs491.i
  %common.ret.op.i.i = phi ptr [ %t18.i.i, %end116.i.i ], [ @.str_stdlib_stdlib_0, %rhs491.i ]
  %1 = load i8, ptr %common.ret.op.i.i, align 1
  %.not.i = icmp eq i8 %1, 32
  br i1 %.not.i, label %charAt.exit.tail.i, label %_json_skipWS.exit

charAt.exit.tail.i:                               ; preds = %sub_0.i
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %charAt.exit.tail.i
  %t17.i = add nsw i32 %i.addr.07.i, 1
  %t7.i = tail call i32 @strlen(ptr %t0)
  %t8.i = icmp slt i32 %t17.i, %t7.i
  br i1 %t8.i, label %rhs491.i, label %_json_skipWS.exit

_json_skipWS.exit:                                ; preds = %sub_0.i, %charAt.exit.tail.i, %whileBody489.i, %entry
  %i.addr.0.lcssa.i = phi i32 [ %t1, %entry ], [ %i.addr.07.i, %charAt.exit.tail.i ], [ %t17.i, %whileBody489.i ], [ %i.addr.07.i, %sub_0.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t9.i = icmp slt i32 %i.addr.0.lcssa.i, 0
  %t12.i = icmp sge i32 %i.addr.0.lcssa.i, %t5.i
  %t7.i14 = select i1 %t9.i, i1 true, i1 %t12.i
  br i1 %t7.i14, label %sub_0, label %end116.i

end116.i:                                         ; preds = %_json_skipWS.exit
  %5 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i = getelementptr i8, ptr %t0, i64 %5
  %t17.i15 = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i15)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %_json_skipWS.exit
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %_json_skipWS.exit ]
  %6 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %6, 34
  br i1 %.not, label %charAt.exit.tail, label %end494

charAt.exit.tail:                                 ; preds = %sub_0
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %if495, label %end494

if495:                                            ; preds = %charAt.exit.tail
  %t16 = add i32 %i.addr.0.lcssa.i, 1
  %t19239 = tail call i32 @strlen(ptr %t0)
  %t20240 = icmp slt i32 %t16, %t19239
  br i1 %t20240, label %whileBody497, label %whileEnd498

whileBody497:                                     ; preds = %if495, %end499
  %storemerge13241 = phi i32 [ %t29, %end499 ], [ %t16, %if495 ]
  %t5.i16 = tail call i32 @strlen(ptr %t0)
  %t9.i17 = icmp slt i32 %storemerge13241, 0
  %t12.i18 = icmp sge i32 %storemerge13241, %t5.i16
  %t7.i19 = select i1 %t9.i17, i1 true, i1 %t12.i18
  br i1 %t7.i19, label %sub_0170, label %end116.i20

end116.i20:                                       ; preds = %whileBody497
  %10 = zext nneg i32 %storemerge13241 to i64
  %t16.i21 = getelementptr i8, ptr %t0, i64 %10
  %t17.i22 = load i8, ptr %t16.i21, align 1
  %t18.i23 = tail call ptr @zen_char_to_string(i8 %t17.i22)
  br label %sub_0170

sub_0170:                                         ; preds = %end116.i20, %whileBody497
  %common.ret.op.i24 = phi ptr [ %t18.i23, %end116.i20 ], [ @.str_stdlib_stdlib_0, %whileBody497 ]
  %11 = load i8, ptr %common.ret.op.i24, align 1
  %.not254 = icmp eq i8 %11, 34
  br i1 %.not254, label %charAt.exit25.tail, label %end499

charAt.exit25.tail:                               ; preds = %sub_0170
  %12 = getelementptr inbounds nuw i8, ptr %common.ret.op.i24, i64 1
  %13 = load i8, ptr %12, align 1
  %14 = icmp eq i8 %13, 0
  br i1 %14, label %whileEnd498, label %end499

end499:                                           ; preds = %sub_0170, %charAt.exit25.tail
  %t29 = add nsw i32 %storemerge13241, 1
  %t19 = tail call i32 @strlen(ptr %t0)
  %t20 = icmp slt i32 %t29, %t19
  br i1 %t20, label %whileBody497, label %whileEnd498

common.ret:                                       ; preds = %whileBody114.i160, %whileBody114.i113, %whileBody114.i66, %whileBody114.i, %whileEnd525, %whileEnd516, %whileEnd505, %whileEnd498
  %common.ret.op = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd498 ], [ @.str_stdlib_stdlib_0, %whileEnd505 ], [ @.str_stdlib_stdlib_0, %whileEnd516 ], [ @.str_stdlib_stdlib_0, %whileEnd525 ], [ %t33.i, %whileBody114.i ], [ %t33.i72, %whileBody114.i66 ], [ %t33.i119, %whileBody114.i113 ], [ %t33.i166, %whileBody114.i160 ]
  ret ptr %common.ret.op

whileEnd498:                                      ; preds = %end499, %charAt.exit25.tail, %if495
  %storemerge13.lcssa = phi i32 [ %t16, %if495 ], [ %storemerge13241, %charAt.exit25.tail ], [ %t29, %end499 ]
  %t7.i26 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t16, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %storemerge13.lcssa, i32 %t7.i26)
  %t17.i27 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t259.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t17.i27, i1 %t259.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %common.ret

whileBody114.i:                                   ; preds = %whileEnd498, %whileBody114.i
  %storemerge11.i = phi i32 [ %t35.i, %whileBody114.i ], [ %spec.store.select.i, %whileEnd498 ]
  %t33810.i = phi ptr [ %t33.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileEnd498 ]
  %15 = zext nneg i32 %storemerge11.i to i64
  %t29.i = getelementptr i8, ptr %t0, i64 %15
  %t30.i = load i8, ptr %t29.i, align 1
  %t31.i = tail call ptr @zen_char_to_string(i8 %t30.i)
  %t33.i = tail call ptr @str_concat(ptr %t33810.i, ptr %t31.i)
  %t35.i = add nuw nsw i32 %storemerge11.i, 1
  %t25.i = icmp slt i32 %t35.i, %spec.select.i
  br i1 %t25.i, label %whileBody114.i, label %common.ret

end494:                                           ; preds = %sub_0, %charAt.exit.tail
  %t5.i29 = tail call i32 @strlen(ptr %t0)
  %t12.i31 = icmp sge i32 %i.addr.0.lcssa.i, %t5.i29
  %t7.i32 = select i1 %t9.i, i1 true, i1 %t12.i31
  br i1 %t7.i32, label %sub_0173, label %end116.i33

end116.i33:                                       ; preds = %end494
  %16 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i34 = getelementptr i8, ptr %t0, i64 %16
  %t17.i35 = load i8, ptr %t16.i34, align 1
  %t18.i36 = tail call ptr @zen_char_to_string(i8 %t17.i35)
  br label %sub_0173

sub_0173:                                         ; preds = %end116.i33, %end494
  %common.ret.op.i37 = phi ptr [ %t18.i36, %end116.i33 ], [ @.str_stdlib_stdlib_0, %end494 ]
  %17 = load i8, ptr %common.ret.op.i37, align 1
  %.not245 = icmp eq i8 %17, 123
  br i1 %.not245, label %charAt.exit38.tail, label %end501

charAt.exit38.tail:                               ; preds = %sub_0173
  %18 = getelementptr inbounds nuw i8, ptr %common.ret.op.i37, i64 1
  %19 = load i8, ptr %18, align 1
  %20 = icmp eq i8 %19, 0
  br i1 %20, label %if502, label %end501

if502:                                            ; preds = %charAt.exit38.tail
  %t47229 = tail call i32 @strlen(ptr %t0)
  %t48230 = icmp slt i32 %i.addr.0.lcssa.i, %t47229
  br i1 %t48230, label %whileBody504, label %whileEnd505

whileBody504:                                     ; preds = %if502, %end510
  %t70224232 = phi i32 [ %t70, %end510 ], [ %i.addr.0.lcssa.i, %if502 ]
  %t67.pr225231 = phi i32 [ %t67.pr226, %end510 ], [ 0, %if502 ]
  %t5.i39 = tail call i32 @strlen(ptr %t0)
  %t9.i40 = icmp slt i32 %t70224232, 0
  %t12.i41 = icmp sge i32 %t70224232, %t5.i39
  %t7.i42 = select i1 %t9.i40, i1 true, i1 %t12.i41
  br i1 %t7.i42, label %sub_0176, label %end116.i43

end116.i43:                                       ; preds = %whileBody504
  %21 = zext nneg i32 %t70224232 to i64
  %t16.i44 = getelementptr i8, ptr %t0, i64 %21
  %t17.i45 = load i8, ptr %t16.i44, align 1
  %t18.i46 = tail call ptr @zen_char_to_string(i8 %t17.i45)
  br label %sub_0176

sub_0176:                                         ; preds = %end116.i43, %whileBody504
  %common.ret.op.i47 = phi ptr [ %t18.i46, %end116.i43 ], [ @.str_stdlib_stdlib_0, %whileBody504 ]
  %22 = load i8, ptr %common.ret.op.i47, align 1
  %.not252 = icmp eq i8 %22, 123
  br i1 %.not252, label %sub_1177, label %charAt.exit48.tail

sub_1177:                                         ; preds = %sub_0176
  %23 = getelementptr inbounds nuw i8, ptr %common.ret.op.i47, i64 1
  %24 = load i8, ptr %23, align 1
  %25 = icmp eq i8 %24, 0
  br label %charAt.exit48.tail

charAt.exit48.tail:                               ; preds = %sub_0176, %sub_1177
  %t55 = phi i1 [ false, %sub_0176 ], [ %25, %sub_1177 ]
  %t57 = zext i1 %t55 to i32
  %spec.select = add i32 %t67.pr225231, %t57
  %t5.i49 = tail call i32 @strlen(ptr %t0)
  %t12.i51 = icmp sge i32 %t70224232, %t5.i49
  %t7.i52 = select i1 %t9.i40, i1 true, i1 %t12.i51
  br i1 %t7.i52, label %sub_0179, label %end116.i53

end116.i53:                                       ; preds = %charAt.exit48.tail
  %26 = zext nneg i32 %t70224232 to i64
  %t16.i54 = getelementptr i8, ptr %t0, i64 %26
  %t17.i55 = load i8, ptr %t16.i54, align 1
  %t18.i56 = tail call ptr @zen_char_to_string(i8 %t17.i55)
  br label %sub_0179

sub_0179:                                         ; preds = %end116.i53, %charAt.exit48.tail
  %common.ret.op.i57 = phi ptr [ %t18.i56, %end116.i53 ], [ @.str_stdlib_stdlib_0, %charAt.exit48.tail ]
  %27 = load i8, ptr %common.ret.op.i57, align 1
  %.not253 = icmp eq i8 %27, 125
  br i1 %.not253, label %sub_1180, label %charAt.exit58.tail

sub_1180:                                         ; preds = %sub_0179
  %28 = getelementptr inbounds nuw i8, ptr %common.ret.op.i57, i64 1
  %29 = load i8, ptr %28, align 1
  %30 = icmp eq i8 %29, 0
  br label %charAt.exit58.tail

charAt.exit58.tail:                               ; preds = %sub_0179, %sub_1180
  %t64 = phi i1 [ false, %sub_0179 ], [ %30, %sub_1180 ]
  %t66 = sext i1 %t64 to i32
  %t67.pr226 = add i32 %spec.select, %t66
  %t68 = icmp eq i32 %t67.pr226, 0
  br i1 %t68, label %whileEnd505, label %end510

end510:                                           ; preds = %charAt.exit58.tail
  %t70 = add nsw i32 %t70224232, 1
  %t47 = tail call i32 @strlen(ptr %t0)
  %t48 = icmp slt i32 %t70, %t47
  br i1 %t48, label %whileBody504, label %whileEnd505

whileEnd505:                                      ; preds = %end510, %charAt.exit58.tail, %if502
  %t70224.lcssa = phi i32 [ %i.addr.0.lcssa.i, %if502 ], [ %t70224232, %charAt.exit58.tail ], [ %t70, %end510 ]
  %t74 = add i32 %t70224.lcssa, 1
  %t7.i59 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i60 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.lcssa.i, i32 0)
  %spec.select.i61 = tail call i32 @llvm.smin.i32(i32 %t74, i32 %t7.i59)
  %t17.i62 = icmp sle i32 %spec.store.select.i60, %spec.select.i61
  %t259.i63 = icmp samesign ult i32 %spec.store.select.i60, %spec.select.i61
  %or.cond.i64 = select i1 %t17.i62, i1 %t259.i63, i1 false
  br i1 %or.cond.i64, label %whileBody114.i66, label %common.ret

whileBody114.i66:                                 ; preds = %whileEnd505, %whileBody114.i66
  %storemerge11.i67 = phi i32 [ %t35.i73, %whileBody114.i66 ], [ %spec.store.select.i60, %whileEnd505 ]
  %t33810.i68 = phi ptr [ %t33.i72, %whileBody114.i66 ], [ @.str_stdlib_stdlib_0, %whileEnd505 ]
  %31 = zext nneg i32 %storemerge11.i67 to i64
  %t29.i69 = getelementptr i8, ptr %t0, i64 %31
  %t30.i70 = load i8, ptr %t29.i69, align 1
  %t31.i71 = tail call ptr @zen_char_to_string(i8 %t30.i70)
  %t33.i72 = tail call ptr @str_concat(ptr %t33810.i68, ptr %t31.i71)
  %t35.i73 = add nuw nsw i32 %storemerge11.i67, 1
  %t25.i74 = icmp slt i32 %t35.i73, %spec.select.i61
  br i1 %t25.i74, label %whileBody114.i66, label %common.ret

end501:                                           ; preds = %sub_0173, %charAt.exit38.tail
  %t5.i76 = tail call i32 @strlen(ptr %t0)
  %t12.i78 = icmp sge i32 %i.addr.0.lcssa.i, %t5.i76
  %t7.i79 = select i1 %t9.i, i1 true, i1 %t12.i78
  br i1 %t7.i79, label %sub_0182, label %end116.i80

end116.i80:                                       ; preds = %end501
  %32 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i81 = getelementptr i8, ptr %t0, i64 %32
  %t17.i82 = load i8, ptr %t16.i81, align 1
  %t18.i83 = tail call ptr @zen_char_to_string(i8 %t17.i82)
  br label %sub_0182

sub_0182:                                         ; preds = %end116.i80, %end501
  %common.ret.op.i84 = phi ptr [ %t18.i83, %end116.i80 ], [ @.str_stdlib_stdlib_0, %end501 ]
  %33 = load i8, ptr %common.ret.op.i84, align 1
  %.not246 = icmp eq i8 %33, 91
  br i1 %.not246, label %charAt.exit85.tail, label %whileCond523.preheader

charAt.exit85.tail:                               ; preds = %sub_0182
  %34 = getelementptr inbounds nuw i8, ptr %common.ret.op.i84, i64 1
  %35 = load i8, ptr %34, align 1
  %36 = icmp eq i8 %35, 0
  br i1 %36, label %if513, label %whileCond523.preheader

whileCond523.preheader:                           ; preds = %sub_0182, %charAt.exit85.tail
  %t121203 = tail call i32 @strlen(ptr %t0)
  %t122204 = icmp slt i32 %i.addr.0.lcssa.i, %t121203
  br i1 %t122204, label %whileBody524, label %whileEnd525

if513:                                            ; preds = %charAt.exit85.tail
  %t88214 = tail call i32 @strlen(ptr %t0)
  %t89215 = icmp slt i32 %i.addr.0.lcssa.i, %t88214
  br i1 %t89215, label %whileBody515, label %whileEnd516

whileBody515:                                     ; preds = %if513, %end521
  %t111209217 = phi i32 [ %t111, %end521 ], [ %i.addr.0.lcssa.i, %if513 ]
  %t108.pr210216 = phi i32 [ %t108.pr211, %end521 ], [ 0, %if513 ]
  %t5.i86 = tail call i32 @strlen(ptr %t0)
  %t9.i87 = icmp slt i32 %t111209217, 0
  %t12.i88 = icmp sge i32 %t111209217, %t5.i86
  %t7.i89 = select i1 %t9.i87, i1 true, i1 %t12.i88
  br i1 %t7.i89, label %sub_0185, label %end116.i90

end116.i90:                                       ; preds = %whileBody515
  %37 = zext nneg i32 %t111209217 to i64
  %t16.i91 = getelementptr i8, ptr %t0, i64 %37
  %t17.i92 = load i8, ptr %t16.i91, align 1
  %t18.i93 = tail call ptr @zen_char_to_string(i8 %t17.i92)
  br label %sub_0185

sub_0185:                                         ; preds = %end116.i90, %whileBody515
  %common.ret.op.i94 = phi ptr [ %t18.i93, %end116.i90 ], [ @.str_stdlib_stdlib_0, %whileBody515 ]
  %38 = load i8, ptr %common.ret.op.i94, align 1
  %.not250 = icmp eq i8 %38, 91
  br i1 %.not250, label %sub_1186, label %charAt.exit95.tail

sub_1186:                                         ; preds = %sub_0185
  %39 = getelementptr inbounds nuw i8, ptr %common.ret.op.i94, i64 1
  %40 = load i8, ptr %39, align 1
  %41 = icmp eq i8 %40, 0
  br label %charAt.exit95.tail

charAt.exit95.tail:                               ; preds = %sub_0185, %sub_1186
  %t96 = phi i1 [ false, %sub_0185 ], [ %41, %sub_1186 ]
  %t98 = zext i1 %t96 to i32
  %spec.select244 = add i32 %t108.pr210216, %t98
  %t5.i96 = tail call i32 @strlen(ptr %t0)
  %t12.i98 = icmp sge i32 %t111209217, %t5.i96
  %t7.i99 = select i1 %t9.i87, i1 true, i1 %t12.i98
  br i1 %t7.i99, label %sub_0188, label %end116.i100

end116.i100:                                      ; preds = %charAt.exit95.tail
  %42 = zext nneg i32 %t111209217 to i64
  %t16.i101 = getelementptr i8, ptr %t0, i64 %42
  %t17.i102 = load i8, ptr %t16.i101, align 1
  %t18.i103 = tail call ptr @zen_char_to_string(i8 %t17.i102)
  br label %sub_0188

sub_0188:                                         ; preds = %end116.i100, %charAt.exit95.tail
  %common.ret.op.i104 = phi ptr [ %t18.i103, %end116.i100 ], [ @.str_stdlib_stdlib_0, %charAt.exit95.tail ]
  %43 = load i8, ptr %common.ret.op.i104, align 1
  %.not251 = icmp eq i8 %43, 93
  br i1 %.not251, label %sub_1189, label %charAt.exit105.tail

sub_1189:                                         ; preds = %sub_0188
  %44 = getelementptr inbounds nuw i8, ptr %common.ret.op.i104, i64 1
  %45 = load i8, ptr %44, align 1
  %46 = icmp eq i8 %45, 0
  br label %charAt.exit105.tail

charAt.exit105.tail:                              ; preds = %sub_0188, %sub_1189
  %t105 = phi i1 [ false, %sub_0188 ], [ %46, %sub_1189 ]
  %t107 = sext i1 %t105 to i32
  %t108.pr211 = add i32 %spec.select244, %t107
  %t109 = icmp eq i32 %t108.pr211, 0
  br i1 %t109, label %whileEnd516, label %end521

end521:                                           ; preds = %charAt.exit105.tail
  %t111 = add nsw i32 %t111209217, 1
  %t88 = tail call i32 @strlen(ptr %t0)
  %t89 = icmp slt i32 %t111, %t88
  br i1 %t89, label %whileBody515, label %whileEnd516

whileEnd516:                                      ; preds = %end521, %charAt.exit105.tail, %if513
  %t111209.lcssa = phi i32 [ %i.addr.0.lcssa.i, %if513 ], [ %t111209217, %charAt.exit105.tail ], [ %t111, %end521 ]
  %t115 = add i32 %t111209.lcssa, 1
  %t7.i106 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i107 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.lcssa.i, i32 0)
  %spec.select.i108 = tail call i32 @llvm.smin.i32(i32 %t115, i32 %t7.i106)
  %t17.i109 = icmp sle i32 %spec.store.select.i107, %spec.select.i108
  %t259.i110 = icmp samesign ult i32 %spec.store.select.i107, %spec.select.i108
  %or.cond.i111 = select i1 %t17.i109, i1 %t259.i110, i1 false
  br i1 %or.cond.i111, label %whileBody114.i113, label %common.ret

whileBody114.i113:                                ; preds = %whileEnd516, %whileBody114.i113
  %storemerge11.i114 = phi i32 [ %t35.i120, %whileBody114.i113 ], [ %spec.store.select.i107, %whileEnd516 ]
  %t33810.i115 = phi ptr [ %t33.i119, %whileBody114.i113 ], [ @.str_stdlib_stdlib_0, %whileEnd516 ]
  %47 = zext nneg i32 %storemerge11.i114 to i64
  %t29.i116 = getelementptr i8, ptr %t0, i64 %47
  %t30.i117 = load i8, ptr %t29.i116, align 1
  %t31.i118 = tail call ptr @zen_char_to_string(i8 %t30.i117)
  %t33.i119 = tail call ptr @str_concat(ptr %t33810.i115, ptr %t31.i118)
  %t35.i120 = add nuw nsw i32 %storemerge11.i114, 1
  %t25.i121 = icmp slt i32 %t35.i120, %spec.select.i108
  br i1 %t25.i121, label %whileBody114.i113, label %common.ret

whileBody524:                                     ; preds = %whileCond523.preheader, %end526
  %storemerge205 = phi i32 [ %t147, %end526 ], [ %i.addr.0.lcssa.i, %whileCond523.preheader ]
  %t5.i123 = tail call i32 @strlen(ptr %t0)
  %t9.i124 = icmp slt i32 %storemerge205, 0
  %t12.i125 = icmp sge i32 %storemerge205, %t5.i123
  %t7.i126 = select i1 %t9.i124, i1 true, i1 %t12.i125
  br i1 %t7.i126, label %sub_0191, label %end116.i127

end116.i127:                                      ; preds = %whileBody524
  %48 = zext nneg i32 %storemerge205 to i64
  %t16.i128 = getelementptr i8, ptr %t0, i64 %48
  %t17.i129 = load i8, ptr %t16.i128, align 1
  %t18.i130 = tail call ptr @zen_char_to_string(i8 %t17.i129)
  br label %sub_0191

sub_0191:                                         ; preds = %end116.i127, %whileBody524
  %common.ret.op.i131 = phi ptr [ %t18.i130, %end116.i127 ], [ @.str_stdlib_stdlib_0, %whileBody524 ]
  %49 = load i8, ptr %common.ret.op.i131, align 1
  %.not247 = icmp eq i8 %49, 44
  br i1 %.not247, label %charAt.exit132.tail, label %rhs530

charAt.exit132.tail:                              ; preds = %sub_0191
  %50 = getelementptr inbounds nuw i8, ptr %common.ret.op.i131, i64 1
  %51 = load i8, ptr %50, align 1
  %52 = icmp eq i8 %51, 0
  br i1 %52, label %whileEnd525, label %rhs530

rhs530:                                           ; preds = %sub_0191, %charAt.exit132.tail
  %t5.i133 = tail call i32 @strlen(ptr %t0)
  %t12.i135 = icmp sge i32 %storemerge205, %t5.i133
  %t7.i136 = select i1 %t9.i124, i1 true, i1 %t12.i135
  br i1 %t7.i136, label %sub_0194, label %end116.i137

end116.i137:                                      ; preds = %rhs530
  %53 = zext nneg i32 %storemerge205 to i64
  %t16.i138 = getelementptr i8, ptr %t0, i64 %53
  %t17.i139 = load i8, ptr %t16.i138, align 1
  %t18.i140 = tail call ptr @zen_char_to_string(i8 %t17.i139)
  br label %sub_0194

sub_0194:                                         ; preds = %end116.i137, %rhs530
  %common.ret.op.i141 = phi ptr [ %t18.i140, %end116.i137 ], [ @.str_stdlib_stdlib_0, %rhs530 ]
  %54 = load i8, ptr %common.ret.op.i141, align 1
  %.not248 = icmp eq i8 %54, 125
  br i1 %.not248, label %charAt.exit142.tail, label %rhs527

charAt.exit142.tail:                              ; preds = %sub_0194
  %55 = getelementptr inbounds nuw i8, ptr %common.ret.op.i141, i64 1
  %56 = load i8, ptr %55, align 1
  %57 = icmp eq i8 %56, 0
  br i1 %57, label %whileEnd525, label %rhs527

rhs527:                                           ; preds = %sub_0194, %charAt.exit142.tail
  %t5.i143 = tail call i32 @strlen(ptr %t0)
  %t12.i145 = icmp sge i32 %storemerge205, %t5.i143
  %t7.i146 = select i1 %t9.i124, i1 true, i1 %t12.i145
  br i1 %t7.i146, label %sub_0197, label %end116.i147

end116.i147:                                      ; preds = %rhs527
  %58 = zext nneg i32 %storemerge205 to i64
  %t16.i148 = getelementptr i8, ptr %t0, i64 %58
  %t17.i149 = load i8, ptr %t16.i148, align 1
  %t18.i150 = tail call ptr @zen_char_to_string(i8 %t17.i149)
  br label %sub_0197

sub_0197:                                         ; preds = %end116.i147, %rhs527
  %common.ret.op.i151 = phi ptr [ %t18.i150, %end116.i147 ], [ @.str_stdlib_stdlib_0, %rhs527 ]
  %59 = load i8, ptr %common.ret.op.i151, align 1
  %.not249 = icmp eq i8 %59, 93
  br i1 %.not249, label %charAt.exit152.tail, label %end526

charAt.exit152.tail:                              ; preds = %sub_0197
  %60 = getelementptr inbounds nuw i8, ptr %common.ret.op.i151, i64 1
  %61 = load i8, ptr %60, align 1
  %62 = icmp eq i8 %61, 0
  br i1 %62, label %whileEnd525, label %end526

end526:                                           ; preds = %sub_0197, %charAt.exit152.tail
  %t147 = add nsw i32 %storemerge205, 1
  %t121 = tail call i32 @strlen(ptr %t0)
  %t122 = icmp slt i32 %t147, %t121
  br i1 %t122, label %whileBody524, label %whileEnd525

whileEnd525:                                      ; preds = %end526, %charAt.exit152.tail, %charAt.exit142.tail, %charAt.exit132.tail, %whileCond523.preheader
  %storemerge.lcssa = phi i32 [ %i.addr.0.lcssa.i, %whileCond523.preheader ], [ %storemerge205, %charAt.exit132.tail ], [ %storemerge205, %charAt.exit142.tail ], [ %storemerge205, %charAt.exit152.tail ], [ %t147, %end526 ]
  %t7.i153 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i154 = tail call i32 @llvm.smax.i32(i32 %i.addr.0.lcssa.i, i32 0)
  %spec.select.i155 = tail call i32 @llvm.smin.i32(i32 %storemerge.lcssa, i32 %t7.i153)
  %t17.i156 = icmp sle i32 %spec.store.select.i154, %spec.select.i155
  %t259.i157 = icmp samesign ult i32 %spec.store.select.i154, %spec.select.i155
  %or.cond.i158 = select i1 %t17.i156, i1 %t259.i157, i1 false
  br i1 %or.cond.i158, label %whileBody114.i160, label %common.ret

whileBody114.i160:                                ; preds = %whileEnd525, %whileBody114.i160
  %storemerge11.i161 = phi i32 [ %t35.i167, %whileBody114.i160 ], [ %spec.store.select.i154, %whileEnd525 ]
  %t33810.i162 = phi ptr [ %t33.i166, %whileBody114.i160 ], [ @.str_stdlib_stdlib_0, %whileEnd525 ]
  %63 = zext nneg i32 %storemerge11.i161 to i64
  %t29.i163 = getelementptr i8, ptr %t0, i64 %63
  %t30.i164 = load i8, ptr %t29.i163, align 1
  %t31.i165 = tail call ptr @zen_char_to_string(i8 %t30.i164)
  %t33.i166 = tail call ptr @str_concat(ptr %t33810.i162, ptr %t31.i165)
  %t35.i167 = add nuw nsw i32 %storemerge11.i161, 1
  %t25.i168 = icmp slt i32 %t35.i167, %spec.select.i155
  br i1 %t25.i168, label %whileBody114.i160, label %common.ret
}

define i32 @_json_skipElement(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t75.i = tail call i32 @strlen(ptr %t0)
  %t86.i = icmp slt i32 %t1, %t75.i
  br i1 %t86.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %entry, %whileBody489.i
  %i.addr.07.i = phi i32 [ %t17.i, %whileBody489.i ], [ %t1, %entry ]
  %t5.i.i = tail call i32 @strlen(ptr %t0)
  %t9.i.i = icmp slt i32 %i.addr.07.i, 0
  %t12.i.i = icmp sge i32 %i.addr.07.i, %t5.i.i
  %t7.i.i = select i1 %t9.i.i, i1 true, i1 %t12.i.i
  br i1 %t7.i.i, label %sub_0.i, label %end116.i.i

end116.i.i:                                       ; preds = %rhs491.i
  %0 = zext nneg i32 %i.addr.07.i to i64
  %t16.i.i = getelementptr i8, ptr %t0, i64 %0
  %t17.i.i = load i8, ptr %t16.i.i, align 1
  %t18.i.i = tail call ptr @zen_char_to_string(i8 %t17.i.i)
  br label %sub_0.i

sub_0.i:                                          ; preds = %end116.i.i, %rhs491.i
  %common.ret.op.i.i = phi ptr [ %t18.i.i, %end116.i.i ], [ @.str_stdlib_stdlib_0, %rhs491.i ]
  %1 = load i8, ptr %common.ret.op.i.i, align 1
  %.not.i = icmp eq i8 %1, 32
  br i1 %.not.i, label %charAt.exit.tail.i, label %_json_skipWS.exit

charAt.exit.tail.i:                               ; preds = %sub_0.i
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %charAt.exit.tail.i
  %t17.i = add nsw i32 %i.addr.07.i, 1
  %t7.i = tail call i32 @strlen(ptr %t0)
  %t8.i = icmp slt i32 %t17.i, %t7.i
  br i1 %t8.i, label %rhs491.i, label %_json_skipWS.exit

_json_skipWS.exit:                                ; preds = %sub_0.i, %charAt.exit.tail.i, %whileBody489.i, %entry
  %i.addr.0.lcssa.i = phi i32 [ %t1, %entry ], [ %i.addr.07.i, %charAt.exit.tail.i ], [ %t17.i, %whileBody489.i ], [ %i.addr.07.i, %sub_0.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t9.i = icmp slt i32 %i.addr.0.lcssa.i, 0
  %t12.i = icmp sge i32 %i.addr.0.lcssa.i, %t5.i
  %t7.i26 = select i1 %t9.i, i1 true, i1 %t12.i
  br i1 %t7.i26, label %sub_0, label %end116.i

end116.i:                                         ; preds = %_json_skipWS.exit
  %5 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i = getelementptr i8, ptr %t0, i64 %5
  %t17.i27 = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i27)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %_json_skipWS.exit
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %_json_skipWS.exit ]
  %6 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %6, 34
  br i1 %.not, label %charAt.exit.tail, label %end534

charAt.exit.tail:                                 ; preds = %sub_0
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %whileCond536.preheader, label %end534

whileCond536.preheader:                           ; preds = %charAt.exit.tail
  %i.addr.0205 = add i32 %i.addr.0.lcssa.i, 1
  %t18206 = tail call i32 @strlen(ptr %t0)
  %t19207 = icmp slt i32 %i.addr.0205, %t18206
  br i1 %t19207, label %whileBody537, label %whileEnd538

whileBody537:                                     ; preds = %whileCond536.preheader, %whileCond536.backedge
  %i.addr.0209 = phi i32 [ %i.addr.0, %whileCond536.backedge ], [ %i.addr.0205, %whileCond536.preheader ]
  %i.addr.0.in208 = phi i32 [ %i.addr.0209, %whileCond536.backedge ], [ %i.addr.0.lcssa.i, %whileCond536.preheader ]
  %t5.i28 = tail call i32 @strlen(ptr %t0)
  %t9.i29 = icmp slt i32 %i.addr.0209, 0
  %t12.i30 = icmp sge i32 %i.addr.0209, %t5.i28
  %t7.i31 = select i1 %t9.i29, i1 true, i1 %t12.i30
  br i1 %t7.i31, label %sub_0128, label %end116.i32

end116.i32:                                       ; preds = %whileBody537
  %10 = zext nneg i32 %i.addr.0209 to i64
  %t16.i33 = getelementptr i8, ptr %t0, i64 %10
  %t17.i34 = load i8, ptr %t16.i33, align 1
  %t18.i35 = tail call ptr @zen_char_to_string(i8 %t17.i34)
  br label %sub_0128

sub_0128:                                         ; preds = %end116.i32, %whileBody537
  %common.ret.op.i36 = phi ptr [ %t18.i35, %end116.i32 ], [ @.str_stdlib_stdlib_0, %whileBody537 ]
  %11 = load i8, ptr %common.ret.op.i36, align 1
  %.not198 = icmp eq i8 %11, 34
  br i1 %.not198, label %sub_1129, label %whileCond536.backedge

sub_1129:                                         ; preds = %sub_0128
  %12 = getelementptr inbounds nuw i8, ptr %common.ret.op.i36, i64 1
  %13 = load i8, ptr %12, align 1
  %14 = icmp eq i8 %13, 0
  br i1 %14, label %whileEnd538, label %whileCond536.backedge

whileCond536.backedge:                            ; preds = %sub_0128, %sub_1129
  %i.addr.0 = add i32 %i.addr.0209, 1
  %t18 = tail call i32 @strlen(ptr %t0)
  %t19 = icmp slt i32 %i.addr.0, %t18
  br i1 %t19, label %whileBody537, label %whileEnd538

common.ret:                                       ; preds = %charAt.exit107.tail, %charAt.exit117.tail, %charAt.exit127.tail, %end566, %whileCond563.preheader, %whileEnd556, %whileEnd545, %whileEnd538
  %common.ret.op = phi i32 [ %t30, %whileEnd538 ], [ %t66, %whileEnd545 ], [ %t102, %whileEnd556 ], [ %i.addr.0.lcssa.i, %whileCond563.preheader ], [ %i.addr.3160, %charAt.exit107.tail ], [ %i.addr.3160, %charAt.exit117.tail ], [ %i.addr.3160, %charAt.exit127.tail ], [ %t131, %end566 ]
  ret i32 %common.ret.op

whileEnd538:                                      ; preds = %whileCond536.backedge, %sub_1129, %whileCond536.preheader
  %i.addr.0.in.lcssa = phi i32 [ %i.addr.0.lcssa.i, %whileCond536.preheader ], [ %i.addr.0209, %whileCond536.backedge ], [ %i.addr.0.in208, %sub_1129 ]
  %t30 = add i32 %i.addr.0.in.lcssa, 2
  br label %common.ret

end534:                                           ; preds = %sub_0, %charAt.exit.tail
  %t5.i38 = tail call i32 @strlen(ptr %t0)
  %t12.i40 = icmp sge i32 %i.addr.0.lcssa.i, %t5.i38
  %t7.i41 = select i1 %t9.i, i1 true, i1 %t12.i40
  br i1 %t7.i41, label %sub_0131, label %end116.i42

end116.i42:                                       ; preds = %end534
  %15 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i43 = getelementptr i8, ptr %t0, i64 %15
  %t17.i44 = load i8, ptr %t16.i43, align 1
  %t18.i45 = tail call ptr @zen_char_to_string(i8 %t17.i44)
  br label %sub_0131

sub_0131:                                         ; preds = %end116.i42, %end534
  %common.ret.op.i46 = phi ptr [ %t18.i45, %end116.i42 ], [ @.str_stdlib_stdlib_0, %end534 ]
  %16 = load i8, ptr %common.ret.op.i46, align 1
  %.not189 = icmp eq i8 %16, 123
  br i1 %.not189, label %charAt.exit47.tail, label %end541

charAt.exit47.tail:                               ; preds = %sub_0131
  %17 = getelementptr inbounds nuw i8, ptr %common.ret.op.i46, i64 1
  %18 = load i8, ptr %17, align 1
  %19 = icmp eq i8 %18, 0
  br i1 %19, label %if542, label %end541

if542:                                            ; preds = %charAt.exit47.tail
  %t41180 = tail call i32 @strlen(ptr %t0)
  %t42181 = icmp slt i32 %i.addr.0.lcssa.i, %t41180
  br i1 %t42181, label %whileBody544, label %whileEnd545

whileBody544:                                     ; preds = %if542, %end550
  %i.addr.1183 = phi i32 [ %t64, %end550 ], [ %i.addr.0.lcssa.i, %if542 ]
  %t61.pr176182 = phi i32 [ %t61.pr177, %end550 ], [ 0, %if542 ]
  %t5.i48 = tail call i32 @strlen(ptr %t0)
  %t9.i49 = icmp slt i32 %i.addr.1183, 0
  %t12.i50 = icmp sge i32 %i.addr.1183, %t5.i48
  %t7.i51 = select i1 %t9.i49, i1 true, i1 %t12.i50
  br i1 %t7.i51, label %sub_0134, label %end116.i52

end116.i52:                                       ; preds = %whileBody544
  %20 = zext nneg i32 %i.addr.1183 to i64
  %t16.i53 = getelementptr i8, ptr %t0, i64 %20
  %t17.i54 = load i8, ptr %t16.i53, align 1
  %t18.i55 = tail call ptr @zen_char_to_string(i8 %t17.i54)
  br label %sub_0134

sub_0134:                                         ; preds = %end116.i52, %whileBody544
  %common.ret.op.i56 = phi ptr [ %t18.i55, %end116.i52 ], [ @.str_stdlib_stdlib_0, %whileBody544 ]
  %21 = load i8, ptr %common.ret.op.i56, align 1
  %.not196 = icmp eq i8 %21, 123
  br i1 %.not196, label %sub_1135, label %charAt.exit57.tail

sub_1135:                                         ; preds = %sub_0134
  %22 = getelementptr inbounds nuw i8, ptr %common.ret.op.i56, i64 1
  %23 = load i8, ptr %22, align 1
  %24 = icmp eq i8 %23, 0
  br label %charAt.exit57.tail

charAt.exit57.tail:                               ; preds = %sub_0134, %sub_1135
  %t49 = phi i1 [ false, %sub_0134 ], [ %24, %sub_1135 ]
  %t51 = zext i1 %t49 to i32
  %spec.select = add i32 %t61.pr176182, %t51
  %t5.i58 = tail call i32 @strlen(ptr %t0)
  %t12.i60 = icmp sge i32 %i.addr.1183, %t5.i58
  %t7.i61 = select i1 %t9.i49, i1 true, i1 %t12.i60
  br i1 %t7.i61, label %sub_0137, label %end116.i62

end116.i62:                                       ; preds = %charAt.exit57.tail
  %25 = zext nneg i32 %i.addr.1183 to i64
  %t16.i63 = getelementptr i8, ptr %t0, i64 %25
  %t17.i64 = load i8, ptr %t16.i63, align 1
  %t18.i65 = tail call ptr @zen_char_to_string(i8 %t17.i64)
  br label %sub_0137

sub_0137:                                         ; preds = %end116.i62, %charAt.exit57.tail
  %common.ret.op.i66 = phi ptr [ %t18.i65, %end116.i62 ], [ @.str_stdlib_stdlib_0, %charAt.exit57.tail ]
  %26 = load i8, ptr %common.ret.op.i66, align 1
  %.not197 = icmp eq i8 %26, 125
  br i1 %.not197, label %sub_1138, label %charAt.exit67.tail

sub_1138:                                         ; preds = %sub_0137
  %27 = getelementptr inbounds nuw i8, ptr %common.ret.op.i66, i64 1
  %28 = load i8, ptr %27, align 1
  %29 = icmp eq i8 %28, 0
  br label %charAt.exit67.tail

charAt.exit67.tail:                               ; preds = %sub_0137, %sub_1138
  %t58 = phi i1 [ false, %sub_0137 ], [ %29, %sub_1138 ]
  %t60 = sext i1 %t58 to i32
  %t61.pr177 = add i32 %spec.select, %t60
  %t62 = icmp eq i32 %t61.pr177, 0
  br i1 %t62, label %whileEnd545, label %end550

end550:                                           ; preds = %charAt.exit67.tail
  %t64 = add nsw i32 %i.addr.1183, 1
  %t41 = tail call i32 @strlen(ptr %t0)
  %t42 = icmp slt i32 %t64, %t41
  br i1 %t42, label %whileBody544, label %whileEnd545

whileEnd545:                                      ; preds = %end550, %charAt.exit67.tail, %if542
  %i.addr.1.lcssa = phi i32 [ %i.addr.0.lcssa.i, %if542 ], [ %i.addr.1183, %charAt.exit67.tail ], [ %t64, %end550 ]
  %t66 = add i32 %i.addr.1.lcssa, 1
  br label %common.ret

end541:                                           ; preds = %sub_0131, %charAt.exit47.tail
  %t5.i68 = tail call i32 @strlen(ptr %t0)
  %t12.i70 = icmp sge i32 %i.addr.0.lcssa.i, %t5.i68
  %t7.i71 = select i1 %t9.i, i1 true, i1 %t12.i70
  br i1 %t7.i71, label %sub_0140, label %end116.i72

end116.i72:                                       ; preds = %end541
  %30 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i73 = getelementptr i8, ptr %t0, i64 %30
  %t17.i74 = load i8, ptr %t16.i73, align 1
  %t18.i75 = tail call ptr @zen_char_to_string(i8 %t17.i74)
  br label %sub_0140

sub_0140:                                         ; preds = %end116.i72, %end541
  %common.ret.op.i76 = phi ptr [ %t18.i75, %end116.i72 ], [ @.str_stdlib_stdlib_0, %end541 ]
  %31 = load i8, ptr %common.ret.op.i76, align 1
  %.not190 = icmp eq i8 %31, 91
  br i1 %.not190, label %charAt.exit77.tail, label %whileCond563.preheader

charAt.exit77.tail:                               ; preds = %sub_0140
  %32 = getelementptr inbounds nuw i8, ptr %common.ret.op.i76, i64 1
  %33 = load i8, ptr %32, align 1
  %34 = icmp eq i8 %33, 0
  br i1 %34, label %if553, label %whileCond563.preheader

whileCond563.preheader:                           ; preds = %sub_0140, %charAt.exit77.tail
  %t105158 = tail call i32 @strlen(ptr %t0)
  %t106159 = icmp slt i32 %i.addr.0.lcssa.i, %t105158
  br i1 %t106159, label %whileBody564, label %common.ret

if553:                                            ; preds = %charAt.exit77.tail
  %t77168 = tail call i32 @strlen(ptr %t0)
  %t78169 = icmp slt i32 %i.addr.0.lcssa.i, %t77168
  br i1 %t78169, label %whileBody555, label %whileEnd556

whileBody555:                                     ; preds = %if553, %end561
  %i.addr.2171 = phi i32 [ %t100, %end561 ], [ %i.addr.0.lcssa.i, %if553 ]
  %t97.pr164170 = phi i32 [ %t97.pr165, %end561 ], [ 0, %if553 ]
  %t5.i78 = tail call i32 @strlen(ptr %t0)
  %t9.i79 = icmp slt i32 %i.addr.2171, 0
  %t12.i80 = icmp sge i32 %i.addr.2171, %t5.i78
  %t7.i81 = select i1 %t9.i79, i1 true, i1 %t12.i80
  br i1 %t7.i81, label %sub_0143, label %end116.i82

end116.i82:                                       ; preds = %whileBody555
  %35 = zext nneg i32 %i.addr.2171 to i64
  %t16.i83 = getelementptr i8, ptr %t0, i64 %35
  %t17.i84 = load i8, ptr %t16.i83, align 1
  %t18.i85 = tail call ptr @zen_char_to_string(i8 %t17.i84)
  br label %sub_0143

sub_0143:                                         ; preds = %end116.i82, %whileBody555
  %common.ret.op.i86 = phi ptr [ %t18.i85, %end116.i82 ], [ @.str_stdlib_stdlib_0, %whileBody555 ]
  %36 = load i8, ptr %common.ret.op.i86, align 1
  %.not194 = icmp eq i8 %36, 91
  br i1 %.not194, label %sub_1144, label %charAt.exit87.tail

sub_1144:                                         ; preds = %sub_0143
  %37 = getelementptr inbounds nuw i8, ptr %common.ret.op.i86, i64 1
  %38 = load i8, ptr %37, align 1
  %39 = icmp eq i8 %38, 0
  br label %charAt.exit87.tail

charAt.exit87.tail:                               ; preds = %sub_0143, %sub_1144
  %t85 = phi i1 [ false, %sub_0143 ], [ %39, %sub_1144 ]
  %t87 = zext i1 %t85 to i32
  %spec.select188 = add i32 %t97.pr164170, %t87
  %t5.i88 = tail call i32 @strlen(ptr %t0)
  %t12.i90 = icmp sge i32 %i.addr.2171, %t5.i88
  %t7.i91 = select i1 %t9.i79, i1 true, i1 %t12.i90
  br i1 %t7.i91, label %sub_0146, label %end116.i92

end116.i92:                                       ; preds = %charAt.exit87.tail
  %40 = zext nneg i32 %i.addr.2171 to i64
  %t16.i93 = getelementptr i8, ptr %t0, i64 %40
  %t17.i94 = load i8, ptr %t16.i93, align 1
  %t18.i95 = tail call ptr @zen_char_to_string(i8 %t17.i94)
  br label %sub_0146

sub_0146:                                         ; preds = %end116.i92, %charAt.exit87.tail
  %common.ret.op.i96 = phi ptr [ %t18.i95, %end116.i92 ], [ @.str_stdlib_stdlib_0, %charAt.exit87.tail ]
  %41 = load i8, ptr %common.ret.op.i96, align 1
  %.not195 = icmp eq i8 %41, 93
  br i1 %.not195, label %sub_1147, label %charAt.exit97.tail

sub_1147:                                         ; preds = %sub_0146
  %42 = getelementptr inbounds nuw i8, ptr %common.ret.op.i96, i64 1
  %43 = load i8, ptr %42, align 1
  %44 = icmp eq i8 %43, 0
  br label %charAt.exit97.tail

charAt.exit97.tail:                               ; preds = %sub_0146, %sub_1147
  %t94 = phi i1 [ false, %sub_0146 ], [ %44, %sub_1147 ]
  %t96 = sext i1 %t94 to i32
  %t97.pr165 = add i32 %spec.select188, %t96
  %t98 = icmp eq i32 %t97.pr165, 0
  br i1 %t98, label %whileEnd556, label %end561

end561:                                           ; preds = %charAt.exit97.tail
  %t100 = add nsw i32 %i.addr.2171, 1
  %t77 = tail call i32 @strlen(ptr %t0)
  %t78 = icmp slt i32 %t100, %t77
  br i1 %t78, label %whileBody555, label %whileEnd556

whileEnd556:                                      ; preds = %end561, %charAt.exit97.tail, %if553
  %i.addr.2.lcssa = phi i32 [ %i.addr.0.lcssa.i, %if553 ], [ %i.addr.2171, %charAt.exit97.tail ], [ %t100, %end561 ]
  %t102 = add i32 %i.addr.2.lcssa, 1
  br label %common.ret

whileBody564:                                     ; preds = %whileCond563.preheader, %end566
  %i.addr.3160 = phi i32 [ %t131, %end566 ], [ %i.addr.0.lcssa.i, %whileCond563.preheader ]
  %t5.i98 = tail call i32 @strlen(ptr %t0)
  %t9.i99 = icmp slt i32 %i.addr.3160, 0
  %t12.i100 = icmp sge i32 %i.addr.3160, %t5.i98
  %t7.i101 = select i1 %t9.i99, i1 true, i1 %t12.i100
  br i1 %t7.i101, label %sub_0149, label %end116.i102

end116.i102:                                      ; preds = %whileBody564
  %45 = zext nneg i32 %i.addr.3160 to i64
  %t16.i103 = getelementptr i8, ptr %t0, i64 %45
  %t17.i104 = load i8, ptr %t16.i103, align 1
  %t18.i105 = tail call ptr @zen_char_to_string(i8 %t17.i104)
  br label %sub_0149

sub_0149:                                         ; preds = %end116.i102, %whileBody564
  %common.ret.op.i106 = phi ptr [ %t18.i105, %end116.i102 ], [ @.str_stdlib_stdlib_0, %whileBody564 ]
  %46 = load i8, ptr %common.ret.op.i106, align 1
  %.not191 = icmp eq i8 %46, 44
  br i1 %.not191, label %charAt.exit107.tail, label %rhs570

charAt.exit107.tail:                              ; preds = %sub_0149
  %47 = getelementptr inbounds nuw i8, ptr %common.ret.op.i106, i64 1
  %48 = load i8, ptr %47, align 1
  %49 = icmp eq i8 %48, 0
  br i1 %49, label %common.ret, label %rhs570

rhs570:                                           ; preds = %sub_0149, %charAt.exit107.tail
  %t5.i108 = tail call i32 @strlen(ptr %t0)
  %t12.i110 = icmp sge i32 %i.addr.3160, %t5.i108
  %t7.i111 = select i1 %t9.i99, i1 true, i1 %t12.i110
  br i1 %t7.i111, label %sub_0152, label %end116.i112

end116.i112:                                      ; preds = %rhs570
  %50 = zext nneg i32 %i.addr.3160 to i64
  %t16.i113 = getelementptr i8, ptr %t0, i64 %50
  %t17.i114 = load i8, ptr %t16.i113, align 1
  %t18.i115 = tail call ptr @zen_char_to_string(i8 %t17.i114)
  br label %sub_0152

sub_0152:                                         ; preds = %end116.i112, %rhs570
  %common.ret.op.i116 = phi ptr [ %t18.i115, %end116.i112 ], [ @.str_stdlib_stdlib_0, %rhs570 ]
  %51 = load i8, ptr %common.ret.op.i116, align 1
  %.not192 = icmp eq i8 %51, 93
  br i1 %.not192, label %charAt.exit117.tail, label %rhs567

charAt.exit117.tail:                              ; preds = %sub_0152
  %52 = getelementptr inbounds nuw i8, ptr %common.ret.op.i116, i64 1
  %53 = load i8, ptr %52, align 1
  %54 = icmp eq i8 %53, 0
  br i1 %54, label %common.ret, label %rhs567

rhs567:                                           ; preds = %sub_0152, %charAt.exit117.tail
  %t5.i118 = tail call i32 @strlen(ptr %t0)
  %t12.i120 = icmp sge i32 %i.addr.3160, %t5.i118
  %t7.i121 = select i1 %t9.i99, i1 true, i1 %t12.i120
  br i1 %t7.i121, label %sub_0155, label %end116.i122

end116.i122:                                      ; preds = %rhs567
  %55 = zext nneg i32 %i.addr.3160 to i64
  %t16.i123 = getelementptr i8, ptr %t0, i64 %55
  %t17.i124 = load i8, ptr %t16.i123, align 1
  %t18.i125 = tail call ptr @zen_char_to_string(i8 %t17.i124)
  br label %sub_0155

sub_0155:                                         ; preds = %end116.i122, %rhs567
  %common.ret.op.i126 = phi ptr [ %t18.i125, %end116.i122 ], [ @.str_stdlib_stdlib_0, %rhs567 ]
  %56 = load i8, ptr %common.ret.op.i126, align 1
  %.not193 = icmp eq i8 %56, 125
  br i1 %.not193, label %charAt.exit127.tail, label %end566

charAt.exit127.tail:                              ; preds = %sub_0155
  %57 = getelementptr inbounds nuw i8, ptr %common.ret.op.i126, i64 1
  %58 = load i8, ptr %57, align 1
  %59 = icmp eq i8 %58, 0
  br i1 %59, label %common.ret, label %end566

end566:                                           ; preds = %sub_0155, %charAt.exit127.tail
  %t131 = add nsw i32 %i.addr.3160, 1
  %t105 = tail call i32 @strlen(ptr %t0)
  %t106 = icmp slt i32 %t131, %t105
  br i1 %t106, label %whileBody564, label %common.ret
}

define ptr @_json_getArrayIndex(ptr %t0, i32 %t1) local_unnamed_addr {
entry:
  %t75.i = tail call i32 @strlen(ptr %t0)
  %t86.i = icmp sgt i32 %t75.i, 0
  br i1 %t86.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %entry, %whileBody489.i
  %i.addr.07.i = phi i32 [ %t17.i, %whileBody489.i ], [ 0, %entry ]
  %t5.i.i = tail call i32 @strlen(ptr %t0)
  %t12.i.i.not = icmp slt i32 %i.addr.07.i, %t5.i.i
  br i1 %t12.i.i.not, label %end116.i.i, label %sub_0.i

end116.i.i:                                       ; preds = %rhs491.i
  %0 = zext nneg i32 %i.addr.07.i to i64
  %t16.i.i = getelementptr i8, ptr %t0, i64 %0
  %t17.i.i = load i8, ptr %t16.i.i, align 1
  %t18.i.i = tail call ptr @zen_char_to_string(i8 %t17.i.i)
  br label %sub_0.i

sub_0.i:                                          ; preds = %end116.i.i, %rhs491.i
  %common.ret.op.i.i = phi ptr [ %t18.i.i, %end116.i.i ], [ @.str_stdlib_stdlib_0, %rhs491.i ]
  %1 = load i8, ptr %common.ret.op.i.i, align 1
  %.not.i = icmp eq i8 %1, 32
  br i1 %.not.i, label %charAt.exit.tail.i, label %_json_skipWS.exit

charAt.exit.tail.i:                               ; preds = %sub_0.i
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %charAt.exit.tail.i
  %t17.i = add nuw nsw i32 %i.addr.07.i, 1
  %t7.i = tail call i32 @strlen(ptr %t0)
  %t8.i = icmp slt i32 %t17.i, %t7.i
  br i1 %t8.i, label %rhs491.i, label %_json_skipWS.exit

_json_skipWS.exit:                                ; preds = %sub_0.i, %charAt.exit.tail.i, %whileBody489.i, %entry
  %i.addr.0.lcssa.i = phi i32 [ 0, %entry ], [ %i.addr.07.i, %charAt.exit.tail.i ], [ %t17.i, %whileBody489.i ], [ %i.addr.07.i, %sub_0.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t12.i.not = icmp slt i32 %i.addr.0.lcssa.i, %t5.i
  br i1 %t12.i.not, label %end116.i, label %sub_0

end116.i:                                         ; preds = %_json_skipWS.exit
  %5 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i = getelementptr i8, ptr %t0, i64 %5
  %t17.i13 = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i13)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %_json_skipWS.exit
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %_json_skipWS.exit ]
  %6 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %6, 91
  br i1 %.not, label %charAt.exit.tail, label %common.ret

charAt.exit.tail:                                 ; preds = %sub_0
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %end574, label %common.ret

common.ret:                                       ; preds = %end581, %charAt.exit74.tail, %end585, %sub_0, %end574, %charAt.exit.tail, %if586
  %common.ret.op = phi ptr [ %t53, %if586 ], [ @.str_stdlib_stdlib_32, %charAt.exit.tail ], [ @.str_stdlib_stdlib_32, %end574 ], [ @.str_stdlib_stdlib_32, %sub_0 ], [ @.str_stdlib_stdlib_32, %end585 ], [ @.str_stdlib_stdlib_32, %charAt.exit74.tail ], [ @.str_stdlib_stdlib_32, %end581 ]
  ret ptr %common.ret.op

end574:                                           ; preds = %charAt.exit.tail
  %t16 = add i32 %i.addr.0.lcssa.i, 1
  %t2081 = tail call i32 @strlen(ptr %t0)
  %t2182 = icmp slt i32 %t16, %t2081
  br i1 %t2182, label %whileBody577, label %common.ret

whileBody577:                                     ; preds = %end574, %end585
  %t6.084 = phi i32 [ %t56, %end585 ], [ %t16, %end574 ]
  %storemerge83 = phi i32 [ %t58, %end585 ], [ 0, %end574 ]
  %t75.i14 = tail call i32 @strlen(ptr %t0)
  %t86.i15 = icmp slt i32 %t6.084, %t75.i14
  br i1 %t86.i15, label %rhs491.i17, label %_json_skipWS.exit33

rhs491.i17:                                       ; preds = %whileBody577, %whileBody489.i29
  %i.addr.07.i18 = phi i32 [ %t17.i30, %whileBody489.i29 ], [ %t6.084, %whileBody577 ]
  %t5.i.i19 = tail call i32 @strlen(ptr %t0)
  %t9.i.i = icmp slt i32 %i.addr.07.i18, 0
  %t12.i.i20 = icmp sge i32 %i.addr.07.i18, %t5.i.i19
  %t7.i.i = select i1 %t9.i.i, i1 true, i1 %t12.i.i20
  br i1 %t7.i.i, label %sub_0.i25, label %end116.i.i21

end116.i.i21:                                     ; preds = %rhs491.i17
  %10 = zext nneg i32 %i.addr.07.i18 to i64
  %t16.i.i22 = getelementptr i8, ptr %t0, i64 %10
  %t17.i.i23 = load i8, ptr %t16.i.i22, align 1
  %t18.i.i24 = tail call ptr @zen_char_to_string(i8 %t17.i.i23)
  br label %sub_0.i25

sub_0.i25:                                        ; preds = %end116.i.i21, %rhs491.i17
  %common.ret.op.i.i26 = phi ptr [ %t18.i.i24, %end116.i.i21 ], [ @.str_stdlib_stdlib_0, %rhs491.i17 ]
  %11 = load i8, ptr %common.ret.op.i.i26, align 1
  %.not.i27 = icmp eq i8 %11, 32
  br i1 %.not.i27, label %charAt.exit.tail.i28, label %_json_skipWS.exit33

charAt.exit.tail.i28:                             ; preds = %sub_0.i25
  %12 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i26, i64 1
  %13 = load i8, ptr %12, align 1
  %14 = icmp eq i8 %13, 0
  br i1 %14, label %whileBody489.i29, label %_json_skipWS.exit33

whileBody489.i29:                                 ; preds = %charAt.exit.tail.i28
  %t17.i30 = add nsw i32 %i.addr.07.i18, 1
  %t7.i31 = tail call i32 @strlen(ptr %t0)
  %t8.i32 = icmp slt i32 %t17.i30, %t7.i31
  br i1 %t8.i32, label %rhs491.i17, label %_json_skipWS.exit33

_json_skipWS.exit33:                              ; preds = %sub_0.i25, %charAt.exit.tail.i28, %whileBody489.i29, %whileBody577
  %i.addr.0.lcssa.i16 = phi i32 [ %t6.084, %whileBody577 ], [ %i.addr.07.i18, %charAt.exit.tail.i28 ], [ %t17.i30, %whileBody489.i29 ], [ %i.addr.07.i18, %sub_0.i25 ]
  %t5.i34 = tail call i32 @strlen(ptr %t0)
  %t9.i = icmp slt i32 %i.addr.0.lcssa.i16, 0
  %t12.i35 = icmp sge i32 %i.addr.0.lcssa.i16, %t5.i34
  %t7.i36 = select i1 %t9.i, i1 true, i1 %t12.i35
  br i1 %t7.i36, label %sub_075, label %end116.i37

end116.i37:                                       ; preds = %_json_skipWS.exit33
  %15 = zext nneg i32 %i.addr.0.lcssa.i16 to i64
  %t16.i38 = getelementptr i8, ptr %t0, i64 %15
  %t17.i39 = load i8, ptr %t16.i38, align 1
  %t18.i40 = tail call ptr @zen_char_to_string(i8 %t17.i39)
  br label %sub_075

sub_075:                                          ; preds = %end116.i37, %_json_skipWS.exit33
  %common.ret.op.i41 = phi ptr [ %t18.i40, %end116.i37 ], [ @.str_stdlib_stdlib_0, %_json_skipWS.exit33 ]
  %16 = load i8, ptr %common.ret.op.i41, align 1
  %.not85 = icmp eq i8 %16, 44
  br i1 %.not85, label %charAt.exit42.tail, label %end579

charAt.exit42.tail:                               ; preds = %sub_075
  %17 = getelementptr inbounds nuw i8, ptr %common.ret.op.i41, i64 1
  %18 = load i8, ptr %17, align 1
  %19 = icmp eq i8 %18, 0
  br i1 %19, label %if580, label %end579

if580:                                            ; preds = %charAt.exit42.tail
  %t33 = add i32 %i.addr.0.lcssa.i16, 1
  %t75.i43 = tail call i32 @strlen(ptr %t0)
  %t86.i44 = icmp slt i32 %t33, %t75.i43
  br i1 %t86.i44, label %rhs491.i46, label %end579

rhs491.i46:                                       ; preds = %if580, %whileBody489.i60
  %i.addr.07.i47 = phi i32 [ %t17.i61, %whileBody489.i60 ], [ %t33, %if580 ]
  %t5.i.i48 = tail call i32 @strlen(ptr %t0)
  %t9.i.i49 = icmp slt i32 %i.addr.07.i47, 0
  %t12.i.i50 = icmp sge i32 %i.addr.07.i47, %t5.i.i48
  %t7.i.i51 = select i1 %t9.i.i49, i1 true, i1 %t12.i.i50
  br i1 %t7.i.i51, label %sub_0.i56, label %end116.i.i52

end116.i.i52:                                     ; preds = %rhs491.i46
  %20 = zext nneg i32 %i.addr.07.i47 to i64
  %t16.i.i53 = getelementptr i8, ptr %t0, i64 %20
  %t17.i.i54 = load i8, ptr %t16.i.i53, align 1
  %t18.i.i55 = tail call ptr @zen_char_to_string(i8 %t17.i.i54)
  br label %sub_0.i56

sub_0.i56:                                        ; preds = %end116.i.i52, %rhs491.i46
  %common.ret.op.i.i57 = phi ptr [ %t18.i.i55, %end116.i.i52 ], [ @.str_stdlib_stdlib_0, %rhs491.i46 ]
  %21 = load i8, ptr %common.ret.op.i.i57, align 1
  %.not.i58 = icmp eq i8 %21, 32
  br i1 %.not.i58, label %charAt.exit.tail.i59, label %end579

charAt.exit.tail.i59:                             ; preds = %sub_0.i56
  %22 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i57, i64 1
  %23 = load i8, ptr %22, align 1
  %24 = icmp eq i8 %23, 0
  br i1 %24, label %whileBody489.i60, label %end579

whileBody489.i60:                                 ; preds = %charAt.exit.tail.i59
  %t17.i61 = add nsw i32 %i.addr.07.i47, 1
  %t7.i62 = tail call i32 @strlen(ptr %t0)
  %t8.i63 = icmp slt i32 %t17.i61, %t7.i62
  br i1 %t8.i63, label %rhs491.i46, label %end579

end579:                                           ; preds = %whileBody489.i60, %charAt.exit.tail.i59, %sub_0.i56, %sub_075, %if580, %charAt.exit42.tail
  %t6.1 = phi i32 [ %i.addr.0.lcssa.i16, %charAt.exit42.tail ], [ %t33, %if580 ], [ %i.addr.0.lcssa.i16, %sub_075 ], [ %i.addr.07.i47, %charAt.exit.tail.i59 ], [ %t17.i61, %whileBody489.i60 ], [ %i.addr.07.i47, %sub_0.i56 ]
  %t5.i65 = tail call i32 @strlen(ptr %t0)
  %t9.i66 = icmp slt i32 %t6.1, 0
  %t12.i67 = icmp sge i32 %t6.1, %t5.i65
  %t7.i68 = select i1 %t9.i66, i1 true, i1 %t12.i67
  br i1 %t7.i68, label %sub_078, label %end116.i69

end116.i69:                                       ; preds = %end579
  %25 = zext nneg i32 %t6.1 to i64
  %t16.i70 = getelementptr i8, ptr %t0, i64 %25
  %t17.i71 = load i8, ptr %t16.i70, align 1
  %t18.i72 = tail call ptr @zen_char_to_string(i8 %t17.i71)
  br label %sub_078

sub_078:                                          ; preds = %end116.i69, %end579
  %common.ret.op.i73 = phi ptr [ %t18.i72, %end116.i69 ], [ @.str_stdlib_stdlib_0, %end579 ]
  %26 = load i8, ptr %common.ret.op.i73, align 1
  %.not86 = icmp eq i8 %26, 93
  br i1 %.not86, label %charAt.exit74.tail, label %end581

charAt.exit74.tail:                               ; preds = %sub_078
  %27 = getelementptr inbounds nuw i8, ptr %common.ret.op.i73, i64 1
  %28 = load i8, ptr %27, align 1
  %29 = icmp eq i8 %28, 0
  br i1 %29, label %common.ret, label %end581

end581:                                           ; preds = %sub_078, %charAt.exit74.tail
  %t46 = tail call i32 @strlen(ptr %t0)
  %t47.not = icmp slt i32 %t6.1, %t46
  br i1 %t47.not, label %end583, label %common.ret

end583:                                           ; preds = %end581
  %t50 = icmp eq i32 %storemerge83, %t1
  br i1 %t50, label %if586, label %end585

if586:                                            ; preds = %end583
  %t53 = tail call ptr @_json_extractValue(ptr %t0, i32 %t6.1)
  br label %common.ret

end585:                                           ; preds = %end583
  %t56 = tail call i32 @_json_skipElement(ptr %t0, i32 %t6.1)
  %t58 = add i32 %storemerge83, 1
  %t20 = tail call i32 @strlen(ptr %t0)
  %t21 = icmp slt i32 %t56, %t20
  br i1 %t21, label %whileBody577, label %common.ret
}

define ptr @_json_getKey(ptr %t0, ptr readonly captures(none) %t1) local_unnamed_addr {
entry:
  %t75.i = tail call i32 @strlen(ptr %t0)
  %t86.i = icmp sgt i32 %t75.i, 0
  br i1 %t86.i, label %rhs491.i, label %_json_skipWS.exit

rhs491.i:                                         ; preds = %entry, %whileBody489.i
  %i.addr.07.i = phi i32 [ %t17.i, %whileBody489.i ], [ 0, %entry ]
  %t5.i.i = tail call i32 @strlen(ptr %t0)
  %t12.i.i.not = icmp slt i32 %i.addr.07.i, %t5.i.i
  br i1 %t12.i.i.not, label %end116.i.i, label %sub_0.i

end116.i.i:                                       ; preds = %rhs491.i
  %0 = zext nneg i32 %i.addr.07.i to i64
  %t16.i.i = getelementptr i8, ptr %t0, i64 %0
  %t17.i.i = load i8, ptr %t16.i.i, align 1
  %t18.i.i = tail call ptr @zen_char_to_string(i8 %t17.i.i)
  br label %sub_0.i

sub_0.i:                                          ; preds = %end116.i.i, %rhs491.i
  %common.ret.op.i.i = phi ptr [ %t18.i.i, %end116.i.i ], [ @.str_stdlib_stdlib_0, %rhs491.i ]
  %1 = load i8, ptr %common.ret.op.i.i, align 1
  %.not.i = icmp eq i8 %1, 32
  br i1 %.not.i, label %charAt.exit.tail.i, label %_json_skipWS.exit

charAt.exit.tail.i:                               ; preds = %sub_0.i
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileBody489.i, label %_json_skipWS.exit

whileBody489.i:                                   ; preds = %charAt.exit.tail.i
  %t17.i = add nuw nsw i32 %i.addr.07.i, 1
  %t7.i = tail call i32 @strlen(ptr %t0)
  %t8.i = icmp slt i32 %t17.i, %t7.i
  br i1 %t8.i, label %rhs491.i, label %_json_skipWS.exit

_json_skipWS.exit:                                ; preds = %sub_0.i, %charAt.exit.tail.i, %whileBody489.i, %entry
  %i.addr.0.lcssa.i = phi i32 [ 0, %entry ], [ %i.addr.07.i, %charAt.exit.tail.i ], [ %t17.i, %whileBody489.i ], [ %i.addr.07.i, %sub_0.i ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t12.i.not = icmp slt i32 %i.addr.0.lcssa.i, %t5.i
  br i1 %t12.i.not, label %end116.i, label %sub_0

end116.i:                                         ; preds = %_json_skipWS.exit
  %5 = zext nneg i32 %i.addr.0.lcssa.i to i64
  %t16.i = getelementptr i8, ptr %t0, i64 %5
  %t17.i17 = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i17)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %_json_skipWS.exit
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %_json_skipWS.exit ]
  %6 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %6, 123
  br i1 %.not, label %charAt.exit.tail, label %common.ret

charAt.exit.tail:                                 ; preds = %sub_0
  %7 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %8 = load i8, ptr %7, align 1
  %9 = icmp eq i8 %8, 0
  br i1 %9, label %end587, label %common.ret

common.ret:                                       ; preds = %sub_0168, %sub_0162, %charAt.exit133.tail, %charAt.exit88.tail, %charAt.exit46.tail, %end606, %sub_0, %end587, %charAt.exit.tail, %if607
  %common.ret.op = phi ptr [ %t98, %if607 ], [ @.str_stdlib_stdlib_32, %charAt.exit.tail ], [ @.str_stdlib_stdlib_32, %end587 ], [ @.str_stdlib_stdlib_32, %sub_0 ], [ @.str_stdlib_stdlib_32, %end606 ], [ @.str_stdlib_stdlib_32, %charAt.exit46.tail ], [ @.str_stdlib_stdlib_32, %charAt.exit88.tail ], [ @.str_stdlib_stdlib_32, %charAt.exit133.tail ], [ @.str_stdlib_stdlib_32, %sub_0162 ], [ @.str_stdlib_stdlib_32, %sub_0168 ]
  ret ptr %common.ret.op

end587:                                           ; preds = %charAt.exit.tail
  %t16 = add i32 %i.addr.0.lcssa.i, 1
  %t19175 = tail call i32 @strlen(ptr %t0)
  %t20176 = icmp slt i32 %t16, %t19175
  br i1 %t20176, label %whileBody590, label %common.ret

whileBody590:                                     ; preds = %end587, %end606
  %t6.0177 = phi i32 [ %t101, %end606 ], [ %t16, %end587 ]
  %t75.i18 = tail call i32 @strlen(ptr %t0)
  %t86.i19 = icmp slt i32 %t6.0177, %t75.i18
  br i1 %t86.i19, label %rhs491.i21, label %_json_skipWS.exit37

rhs491.i21:                                       ; preds = %whileBody590, %whileBody489.i33
  %i.addr.07.i22 = phi i32 [ %t17.i34, %whileBody489.i33 ], [ %t6.0177, %whileBody590 ]
  %t5.i.i23 = tail call i32 @strlen(ptr %t0)
  %t9.i.i = icmp slt i32 %i.addr.07.i22, 0
  %t12.i.i24 = icmp sge i32 %i.addr.07.i22, %t5.i.i23
  %t7.i.i = select i1 %t9.i.i, i1 true, i1 %t12.i.i24
  br i1 %t7.i.i, label %sub_0.i29, label %end116.i.i25

end116.i.i25:                                     ; preds = %rhs491.i21
  %10 = zext nneg i32 %i.addr.07.i22 to i64
  %t16.i.i26 = getelementptr i8, ptr %t0, i64 %10
  %t17.i.i27 = load i8, ptr %t16.i.i26, align 1
  %t18.i.i28 = tail call ptr @zen_char_to_string(i8 %t17.i.i27)
  br label %sub_0.i29

sub_0.i29:                                        ; preds = %end116.i.i25, %rhs491.i21
  %common.ret.op.i.i30 = phi ptr [ %t18.i.i28, %end116.i.i25 ], [ @.str_stdlib_stdlib_0, %rhs491.i21 ]
  %11 = load i8, ptr %common.ret.op.i.i30, align 1
  %.not.i31 = icmp eq i8 %11, 32
  br i1 %.not.i31, label %charAt.exit.tail.i32, label %_json_skipWS.exit37

charAt.exit.tail.i32:                             ; preds = %sub_0.i29
  %12 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i30, i64 1
  %13 = load i8, ptr %12, align 1
  %14 = icmp eq i8 %13, 0
  br i1 %14, label %whileBody489.i33, label %_json_skipWS.exit37

whileBody489.i33:                                 ; preds = %charAt.exit.tail.i32
  %t17.i34 = add nsw i32 %i.addr.07.i22, 1
  %t7.i35 = tail call i32 @strlen(ptr %t0)
  %t8.i36 = icmp slt i32 %t17.i34, %t7.i35
  br i1 %t8.i36, label %rhs491.i21, label %_json_skipWS.exit37

_json_skipWS.exit37:                              ; preds = %sub_0.i29, %charAt.exit.tail.i32, %whileBody489.i33, %whileBody590
  %i.addr.0.lcssa.i20 = phi i32 [ %t6.0177, %whileBody590 ], [ %i.addr.07.i22, %charAt.exit.tail.i32 ], [ %t17.i34, %whileBody489.i33 ], [ %i.addr.07.i22, %sub_0.i29 ]
  %t5.i38 = tail call i32 @strlen(ptr %t0)
  %t9.i = icmp slt i32 %i.addr.0.lcssa.i20, 0
  %t12.i39 = icmp sge i32 %i.addr.0.lcssa.i20, %t5.i38
  %t7.i40 = select i1 %t9.i, i1 true, i1 %t12.i39
  br i1 %t7.i40, label %sub_0156, label %end116.i41

end116.i41:                                       ; preds = %_json_skipWS.exit37
  %15 = zext nneg i32 %i.addr.0.lcssa.i20 to i64
  %t16.i42 = getelementptr i8, ptr %t0, i64 %15
  %t17.i43 = load i8, ptr %t16.i42, align 1
  %t18.i44 = tail call ptr @zen_char_to_string(i8 %t17.i43)
  br label %sub_0156

sub_0156:                                         ; preds = %end116.i41, %_json_skipWS.exit37
  %common.ret.op.i45 = phi ptr [ %t18.i44, %end116.i41 ], [ @.str_stdlib_stdlib_0, %_json_skipWS.exit37 ]
  %16 = load i8, ptr %common.ret.op.i45, align 1
  %.not178 = icmp eq i8 %16, 125
  br i1 %.not178, label %charAt.exit46.tail, label %end592

charAt.exit46.tail:                               ; preds = %sub_0156
  %17 = getelementptr inbounds nuw i8, ptr %common.ret.op.i45, i64 1
  %18 = load i8, ptr %17, align 1
  %19 = icmp eq i8 %18, 0
  br i1 %19, label %common.ret, label %end592

end592:                                           ; preds = %sub_0156, %charAt.exit46.tail
  %t5.i47 = tail call i32 @strlen(ptr %t0)
  %t12.i49 = icmp sge i32 %i.addr.0.lcssa.i20, %t5.i47
  %t7.i50 = select i1 %t9.i, i1 true, i1 %t12.i49
  br i1 %t7.i50, label %sub_0159, label %end116.i51

end116.i51:                                       ; preds = %end592
  %20 = zext nneg i32 %i.addr.0.lcssa.i20 to i64
  %t16.i52 = getelementptr i8, ptr %t0, i64 %20
  %t17.i53 = load i8, ptr %t16.i52, align 1
  %t18.i54 = tail call ptr @zen_char_to_string(i8 %t17.i53)
  br label %sub_0159

sub_0159:                                         ; preds = %end116.i51, %end592
  %common.ret.op.i55 = phi ptr [ %t18.i54, %end116.i51 ], [ @.str_stdlib_stdlib_0, %end592 ]
  %21 = load i8, ptr %common.ret.op.i55, align 1
  %.not179 = icmp eq i8 %21, 44
  br i1 %.not179, label %charAt.exit56.tail, label %end594

charAt.exit56.tail:                               ; preds = %sub_0159
  %22 = getelementptr inbounds nuw i8, ptr %common.ret.op.i55, i64 1
  %23 = load i8, ptr %22, align 1
  %24 = icmp eq i8 %23, 0
  br i1 %24, label %if595, label %end594

if595:                                            ; preds = %charAt.exit56.tail
  %t39 = add i32 %i.addr.0.lcssa.i20, 1
  %t75.i57 = tail call i32 @strlen(ptr %t0)
  %t86.i58 = icmp slt i32 %t39, %t75.i57
  br i1 %t86.i58, label %rhs491.i60, label %end594

rhs491.i60:                                       ; preds = %if595, %whileBody489.i74
  %i.addr.07.i61 = phi i32 [ %t17.i75, %whileBody489.i74 ], [ %t39, %if595 ]
  %t5.i.i62 = tail call i32 @strlen(ptr %t0)
  %t9.i.i63 = icmp slt i32 %i.addr.07.i61, 0
  %t12.i.i64 = icmp sge i32 %i.addr.07.i61, %t5.i.i62
  %t7.i.i65 = select i1 %t9.i.i63, i1 true, i1 %t12.i.i64
  br i1 %t7.i.i65, label %sub_0.i70, label %end116.i.i66

end116.i.i66:                                     ; preds = %rhs491.i60
  %25 = zext nneg i32 %i.addr.07.i61 to i64
  %t16.i.i67 = getelementptr i8, ptr %t0, i64 %25
  %t17.i.i68 = load i8, ptr %t16.i.i67, align 1
  %t18.i.i69 = tail call ptr @zen_char_to_string(i8 %t17.i.i68)
  br label %sub_0.i70

sub_0.i70:                                        ; preds = %end116.i.i66, %rhs491.i60
  %common.ret.op.i.i71 = phi ptr [ %t18.i.i69, %end116.i.i66 ], [ @.str_stdlib_stdlib_0, %rhs491.i60 ]
  %26 = load i8, ptr %common.ret.op.i.i71, align 1
  %.not.i72 = icmp eq i8 %26, 32
  br i1 %.not.i72, label %charAt.exit.tail.i73, label %end594

charAt.exit.tail.i73:                             ; preds = %sub_0.i70
  %27 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i71, i64 1
  %28 = load i8, ptr %27, align 1
  %29 = icmp eq i8 %28, 0
  br i1 %29, label %whileBody489.i74, label %end594

whileBody489.i74:                                 ; preds = %charAt.exit.tail.i73
  %t17.i75 = add nsw i32 %i.addr.07.i61, 1
  %t7.i76 = tail call i32 @strlen(ptr %t0)
  %t8.i77 = icmp slt i32 %t17.i75, %t7.i76
  br i1 %t8.i77, label %rhs491.i60, label %end594

end594:                                           ; preds = %whileBody489.i74, %charAt.exit.tail.i73, %sub_0.i70, %sub_0159, %if595, %charAt.exit56.tail
  %t6.1 = phi i32 [ %i.addr.0.lcssa.i20, %charAt.exit56.tail ], [ %t39, %if595 ], [ %i.addr.0.lcssa.i20, %sub_0159 ], [ %i.addr.07.i61, %charAt.exit.tail.i73 ], [ %t17.i75, %whileBody489.i74 ], [ %i.addr.07.i61, %sub_0.i70 ]
  %t5.i79 = tail call i32 @strlen(ptr %t0)
  %t9.i80 = icmp slt i32 %t6.1, 0
  %t12.i81 = icmp sge i32 %t6.1, %t5.i79
  %t7.i82 = select i1 %t9.i80, i1 true, i1 %t12.i81
  br i1 %t7.i82, label %sub_0162, label %end116.i83

end116.i83:                                       ; preds = %end594
  %30 = zext nneg i32 %t6.1 to i64
  %t16.i84 = getelementptr i8, ptr %t0, i64 %30
  %t17.i85 = load i8, ptr %t16.i84, align 1
  %t18.i86 = tail call ptr @zen_char_to_string(i8 %t17.i85)
  br label %sub_0162

sub_0162:                                         ; preds = %end116.i83, %end594
  %common.ret.op.i87 = phi ptr [ %t18.i86, %end116.i83 ], [ @.str_stdlib_stdlib_0, %end594 ]
  %31 = load i8, ptr %common.ret.op.i87, align 1
  %.not180 = icmp eq i8 %31, 34
  br i1 %.not180, label %charAt.exit88.tail, label %common.ret

charAt.exit88.tail:                               ; preds = %sub_0162
  %32 = getelementptr inbounds nuw i8, ptr %common.ret.op.i87, i64 1
  %33 = load i8, ptr %32, align 1
  %34 = icmp eq i8 %33, 0
  br i1 %34, label %end596, label %common.ret

end596:                                           ; preds = %charAt.exit88.tail
  %t52 = add i32 %t6.1, 1
  %t58171 = tail call i32 @strlen(ptr %t0)
  %t59172 = icmp slt i32 %t52, %t58171
  br i1 %t59172, label %rhs601, label %whileEnd600

rhs601:                                           ; preds = %end596, %whileBody599
  %storemerge173 = phi i32 [ %t68, %whileBody599 ], [ %t52, %end596 ]
  %t5.i89 = tail call i32 @strlen(ptr %t0)
  %t9.i90 = icmp slt i32 %storemerge173, 0
  %t12.i91 = icmp sge i32 %storemerge173, %t5.i89
  %t7.i92 = select i1 %t9.i90, i1 true, i1 %t12.i91
  br i1 %t7.i92, label %sub_0165, label %end116.i93

end116.i93:                                       ; preds = %rhs601
  %35 = zext nneg i32 %storemerge173 to i64
  %t16.i94 = getelementptr i8, ptr %t0, i64 %35
  %t17.i95 = load i8, ptr %t16.i94, align 1
  %t18.i96 = tail call ptr @zen_char_to_string(i8 %t17.i95)
  br label %sub_0165

sub_0165:                                         ; preds = %end116.i93, %rhs601
  %common.ret.op.i97 = phi ptr [ %t18.i96, %end116.i93 ], [ @.str_stdlib_stdlib_0, %rhs601 ]
  %36 = load i8, ptr %common.ret.op.i97, align 1
  %.not181 = icmp eq i8 %36, 34
  br i1 %.not181, label %charAt.exit98.tail, label %whileBody599

charAt.exit98.tail:                               ; preds = %sub_0165
  %37 = getelementptr inbounds nuw i8, ptr %common.ret.op.i97, i64 1
  %38 = load i8, ptr %37, align 1
  %39 = icmp eq i8 %38, 0
  br i1 %39, label %whileEnd600, label %whileBody599

whileBody599:                                     ; preds = %sub_0165, %charAt.exit98.tail
  %t68 = add nsw i32 %storemerge173, 1
  %t58 = tail call i32 @strlen(ptr %t0)
  %t59 = icmp slt i32 %t68, %t58
  br i1 %t59, label %rhs601, label %whileEnd600

whileEnd600:                                      ; preds = %charAt.exit98.tail, %whileBody599, %end596
  %storemerge.lcssa = phi i32 [ %t52, %end596 ], [ %t68, %whileBody599 ], [ %storemerge173, %charAt.exit98.tail ]
  %t7.i99 = tail call i32 @strlen(ptr %t0)
  %spec.store.select.i = tail call i32 @llvm.smax.i32(i32 %t52, i32 0)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %storemerge.lcssa, i32 %t7.i99)
  %t17.i100 = icmp sle i32 %spec.store.select.i, %spec.select.i
  %t259.i = icmp samesign ult i32 %spec.store.select.i, %spec.select.i
  %or.cond.i = select i1 %t17.i100, i1 %t259.i, i1 false
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileEnd600, %whileBody114.i
  %storemerge11.i = phi i32 [ %t35.i, %whileBody114.i ], [ %spec.store.select.i, %whileEnd600 ]
  %t33810.i = phi ptr [ %t33.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileEnd600 ]
  %40 = zext nneg i32 %storemerge11.i to i64
  %t29.i = getelementptr i8, ptr %t0, i64 %40
  %t30.i = load i8, ptr %t29.i, align 1
  %t31.i = tail call ptr @zen_char_to_string(i8 %t30.i)
  %t33.i = tail call ptr @str_concat(ptr %t33810.i, ptr %t31.i)
  %t35.i = add nuw nsw i32 %storemerge11.i, 1
  %t25.i = icmp slt i32 %t35.i, %spec.select.i
  br i1 %t25.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileEnd600
  %common.ret.op.i101 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd600 ], [ %t33.i, %whileBody114.i ]
  %t75 = add i32 %storemerge.lcssa, 1
  %t75.i102 = tail call i32 @strlen(ptr %t0)
  %t86.i103 = icmp slt i32 %t75, %t75.i102
  br i1 %t86.i103, label %rhs491.i105, label %_json_skipWS.exit123

rhs491.i105:                                      ; preds = %slice.exit, %whileBody489.i119
  %i.addr.07.i106 = phi i32 [ %t17.i120, %whileBody489.i119 ], [ %t75, %slice.exit ]
  %t5.i.i107 = tail call i32 @strlen(ptr %t0)
  %t9.i.i108 = icmp slt i32 %i.addr.07.i106, 0
  %t12.i.i109 = icmp sge i32 %i.addr.07.i106, %t5.i.i107
  %t7.i.i110 = select i1 %t9.i.i108, i1 true, i1 %t12.i.i109
  br i1 %t7.i.i110, label %sub_0.i115, label %end116.i.i111

end116.i.i111:                                    ; preds = %rhs491.i105
  %41 = zext nneg i32 %i.addr.07.i106 to i64
  %t16.i.i112 = getelementptr i8, ptr %t0, i64 %41
  %t17.i.i113 = load i8, ptr %t16.i.i112, align 1
  %t18.i.i114 = tail call ptr @zen_char_to_string(i8 %t17.i.i113)
  br label %sub_0.i115

sub_0.i115:                                       ; preds = %end116.i.i111, %rhs491.i105
  %common.ret.op.i.i116 = phi ptr [ %t18.i.i114, %end116.i.i111 ], [ @.str_stdlib_stdlib_0, %rhs491.i105 ]
  %42 = load i8, ptr %common.ret.op.i.i116, align 1
  %.not.i117 = icmp eq i8 %42, 32
  br i1 %.not.i117, label %charAt.exit.tail.i118, label %_json_skipWS.exit123

charAt.exit.tail.i118:                            ; preds = %sub_0.i115
  %43 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i116, i64 1
  %44 = load i8, ptr %43, align 1
  %45 = icmp eq i8 %44, 0
  br i1 %45, label %whileBody489.i119, label %_json_skipWS.exit123

whileBody489.i119:                                ; preds = %charAt.exit.tail.i118
  %t17.i120 = add nsw i32 %i.addr.07.i106, 1
  %t7.i121 = tail call i32 @strlen(ptr %t0)
  %t8.i122 = icmp slt i32 %t17.i120, %t7.i121
  br i1 %t8.i122, label %rhs491.i105, label %_json_skipWS.exit123

_json_skipWS.exit123:                             ; preds = %sub_0.i115, %charAt.exit.tail.i118, %whileBody489.i119, %slice.exit
  %i.addr.0.lcssa.i104 = phi i32 [ %t75, %slice.exit ], [ %i.addr.07.i106, %charAt.exit.tail.i118 ], [ %t17.i120, %whileBody489.i119 ], [ %i.addr.07.i106, %sub_0.i115 ]
  %t5.i124 = tail call i32 @strlen(ptr %t0)
  %t9.i125 = icmp slt i32 %i.addr.0.lcssa.i104, 0
  %t12.i126 = icmp sge i32 %i.addr.0.lcssa.i104, %t5.i124
  %t7.i127 = select i1 %t9.i125, i1 true, i1 %t12.i126
  br i1 %t7.i127, label %sub_0168, label %end116.i128

end116.i128:                                      ; preds = %_json_skipWS.exit123
  %46 = zext nneg i32 %i.addr.0.lcssa.i104 to i64
  %t16.i129 = getelementptr i8, ptr %t0, i64 %46
  %t17.i130 = load i8, ptr %t16.i129, align 1
  %t18.i131 = tail call ptr @zen_char_to_string(i8 %t17.i130)
  br label %sub_0168

sub_0168:                                         ; preds = %end116.i128, %_json_skipWS.exit123
  %common.ret.op.i132 = phi ptr [ %t18.i131, %end116.i128 ], [ @.str_stdlib_stdlib_0, %_json_skipWS.exit123 ]
  %47 = load i8, ptr %common.ret.op.i132, align 1
  %.not182 = icmp eq i8 %47, 58
  br i1 %.not182, label %charAt.exit133.tail, label %common.ret

charAt.exit133.tail:                              ; preds = %sub_0168
  %48 = getelementptr inbounds nuw i8, ptr %common.ret.op.i132, i64 1
  %49 = load i8, ptr %48, align 1
  %50 = icmp eq i8 %49, 0
  br i1 %50, label %end604, label %common.ret

end604:                                           ; preds = %charAt.exit133.tail
  %t87 = add i32 %i.addr.0.lcssa.i104, 1
  %t75.i134 = tail call i32 @strlen(ptr %t0)
  %t86.i135 = icmp slt i32 %t87, %t75.i134
  br i1 %t86.i135, label %rhs491.i137, label %_json_skipWS.exit155

rhs491.i137:                                      ; preds = %end604, %whileBody489.i151
  %i.addr.07.i138 = phi i32 [ %t17.i152, %whileBody489.i151 ], [ %t87, %end604 ]
  %t5.i.i139 = tail call i32 @strlen(ptr %t0)
  %t9.i.i140 = icmp slt i32 %i.addr.07.i138, 0
  %t12.i.i141 = icmp sge i32 %i.addr.07.i138, %t5.i.i139
  %t7.i.i142 = select i1 %t9.i.i140, i1 true, i1 %t12.i.i141
  br i1 %t7.i.i142, label %sub_0.i147, label %end116.i.i143

end116.i.i143:                                    ; preds = %rhs491.i137
  %51 = zext nneg i32 %i.addr.07.i138 to i64
  %t16.i.i144 = getelementptr i8, ptr %t0, i64 %51
  %t17.i.i145 = load i8, ptr %t16.i.i144, align 1
  %t18.i.i146 = tail call ptr @zen_char_to_string(i8 %t17.i.i145)
  br label %sub_0.i147

sub_0.i147:                                       ; preds = %end116.i.i143, %rhs491.i137
  %common.ret.op.i.i148 = phi ptr [ %t18.i.i146, %end116.i.i143 ], [ @.str_stdlib_stdlib_0, %rhs491.i137 ]
  %52 = load i8, ptr %common.ret.op.i.i148, align 1
  %.not.i149 = icmp eq i8 %52, 32
  br i1 %.not.i149, label %charAt.exit.tail.i150, label %_json_skipWS.exit155

charAt.exit.tail.i150:                            ; preds = %sub_0.i147
  %53 = getelementptr inbounds nuw i8, ptr %common.ret.op.i.i148, i64 1
  %54 = load i8, ptr %53, align 1
  %55 = icmp eq i8 %54, 0
  br i1 %55, label %whileBody489.i151, label %_json_skipWS.exit155

whileBody489.i151:                                ; preds = %charAt.exit.tail.i150
  %t17.i152 = add nsw i32 %i.addr.07.i138, 1
  %t7.i153 = tail call i32 @strlen(ptr %t0)
  %t8.i154 = icmp slt i32 %t17.i152, %t7.i153
  br i1 %t8.i154, label %rhs491.i137, label %_json_skipWS.exit155

_json_skipWS.exit155:                             ; preds = %sub_0.i147, %charAt.exit.tail.i150, %whileBody489.i151, %end604
  %i.addr.0.lcssa.i136 = phi i32 [ %t87, %end604 ], [ %i.addr.07.i138, %charAt.exit.tail.i150 ], [ %t17.i152, %whileBody489.i151 ], [ %i.addr.07.i138, %sub_0.i147 ]
  %t94 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %common.ret.op.i101, ptr noundef nonnull dereferenceable(1) %t1)
  %t95 = icmp eq i32 %t94, 0
  br i1 %t95, label %if607, label %end606

if607:                                            ; preds = %_json_skipWS.exit155
  %t98 = tail call ptr @_json_extractValue(ptr %t0, i32 %i.addr.0.lcssa.i136)
  br label %common.ret

end606:                                           ; preds = %_json_skipWS.exit155
  %t101 = tail call i32 @_json_skipElement(ptr %t0, i32 %i.addr.0.lcssa.i136)
  %t19 = tail call i32 @strlen(ptr %t0)
  %t20 = icmp slt i32 %t101, %t19
  br i1 %t20, label %whileBody590, label %common.ret
}

define i32 @_json_parseInt(ptr %t0) local_unnamed_addr {
entry:
  %t64 = tail call i32 @strlen(ptr %t0)
  %t75 = icmp sgt i32 %t64, 0
  br i1 %t75, label %whileBody609, label %whileEnd610

whileBody609:                                     ; preds = %entry, %charAt.exit
  %t3.07 = phi i32 [ %t19, %charAt.exit ], [ 0, %entry ]
  %t2.06 = phi i32 [ %t17, %charAt.exit ], [ 0, %entry ]
  %t5.i = tail call i32 @strlen(ptr %t0)
  %t12.i.not = icmp slt i32 %t3.07, %t5.i
  br i1 %t12.i.not, label %end116.i, label %charAt.exit

end116.i:                                         ; preds = %whileBody609
  %0 = zext nneg i32 %t3.07 to i64
  %t16.i = getelementptr i8, ptr %t0, i64 %0
  %t17.i = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i)
  br label %charAt.exit

charAt.exit:                                      ; preds = %whileBody609, %end116.i
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody609 ]
  %t12 = tail call i32 @string_to_int_ascii(ptr %common.ret.op.i)
  %t15 = mul i32 %t2.06, 10
  %t13 = add i32 %t15, -48
  %t17 = add i32 %t13, %t12
  %t19 = add nuw nsw i32 %t3.07, 1
  %t6 = tail call i32 @strlen(ptr %t0)
  %t7 = icmp slt i32 %t19, %t6
  br i1 %t7, label %whileBody609, label %whileEnd610

whileEnd610:                                      ; preds = %charAt.exit, %entry
  %t2.0.lcssa = phi i32 [ 0, %entry ], [ %t17, %charAt.exit ]
  ret i32 %t2.0.lcssa
}

define ptr @json(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t1082 = tail call ptr @splitAt(ptr %t1, ptr nonnull @.str_stdlib_stdlib_8, i32 0)
  %strcmpload83 = load i8, ptr %t1082, align 1
  %t1684 = icmp eq i8 %strcmpload83, 0
  br i1 %t1684, label %common.ret, label %whileCond616.preheader

whileCond616.preheader:                           ; preds = %entry, %whileEnd627
  %t1087 = phi ptr [ %t10, %whileEnd627 ], [ %t1082, %entry ]
  %t6.086 = phi i32 [ %t104, %whileEnd627 ], [ 0, %entry ]
  %t4.085 = phi ptr [ %t4.2.lcssa, %whileEnd627 ], [ %t0, %entry ]
  %t2072 = tail call i32 @strlen(ptr nonnull %t1087)
  %t2173 = icmp sgt i32 %t2072, 0
  br i1 %t2173, label %whileBody617, label %whileEnd618

whileBody617:                                     ; preds = %whileCond616.preheader, %end619
  %storemerge74 = phi i32 [ %t30, %end619 ], [ 0, %whileCond616.preheader ]
  %t5.i = tail call i32 @strlen(ptr nonnull %t1087)
  %t12.i.not = icmp slt i32 %storemerge74, %t5.i
  br i1 %t12.i.not, label %end116.i, label %sub_0

end116.i:                                         ; preds = %whileBody617
  %0 = zext nneg i32 %storemerge74 to i64
  %t16.i = getelementptr i8, ptr %t1087, i64 %0
  %t17.i = load i8, ptr %t16.i, align 1
  %t18.i = tail call ptr @zen_char_to_string(i8 %t17.i)
  br label %sub_0

sub_0:                                            ; preds = %end116.i, %whileBody617
  %common.ret.op.i = phi ptr [ %t18.i, %end116.i ], [ @.str_stdlib_stdlib_0, %whileBody617 ]
  %1 = load i8, ptr %common.ret.op.i, align 1
  %.not = icmp eq i8 %1, 91
  br i1 %.not, label %charAt.exit.tail, label %end619

charAt.exit.tail:                                 ; preds = %sub_0
  %2 = getelementptr inbounds nuw i8, ptr %common.ret.op.i, i64 1
  %3 = load i8, ptr %2, align 1
  %4 = icmp eq i8 %3, 0
  br i1 %4, label %whileEnd618, label %end619

end619:                                           ; preds = %sub_0, %charAt.exit.tail
  %t30 = add nuw nsw i32 %storemerge74, 1
  %t20 = tail call i32 @strlen(ptr nonnull %t1087)
  %t21 = icmp slt i32 %t30, %t20
  br i1 %t21, label %whileBody617, label %whileEnd618

whileEnd618:                                      ; preds = %end619, %charAt.exit.tail, %whileCond616.preheader
  %storemerge.lcssa = phi i32 [ 0, %whileCond616.preheader ], [ %storemerge74, %charAt.exit.tail ], [ %t30, %end619 ]
  %t7.i5 = tail call i32 @strlen(ptr nonnull %t1087)
  %spec.select.i = tail call i32 @llvm.smin.i32(i32 %storemerge.lcssa, i32 %t7.i5)
  %or.cond.i = icmp sgt i32 %spec.select.i, 0
  br i1 %or.cond.i, label %whileBody114.i, label %slice.exit

whileBody114.i:                                   ; preds = %whileEnd618, %whileBody114.i
  %storemerge11.i = phi i32 [ %t35.i, %whileBody114.i ], [ 0, %whileEnd618 ]
  %t33810.i = phi ptr [ %t33.i, %whileBody114.i ], [ @.str_stdlib_stdlib_0, %whileEnd618 ]
  %5 = zext nneg i32 %storemerge11.i to i64
  %t29.i = getelementptr i8, ptr %t1087, i64 %5
  %t30.i = load i8, ptr %t29.i, align 1
  %t31.i = tail call ptr @zen_char_to_string(i8 %t30.i)
  %t33.i = tail call ptr @str_concat(ptr %t33810.i, ptr %t31.i)
  %t35.i = add nuw nsw i32 %storemerge11.i, 1
  %t25.i = icmp slt i32 %t35.i, %spec.select.i
  br i1 %t25.i, label %whileBody114.i, label %slice.exit

slice.exit:                                       ; preds = %whileBody114.i, %whileEnd618
  %common.ret.op.i7 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd618 ], [ %t33.i, %whileBody114.i ]
  %t38 = tail call i32 @strlen(ptr nonnull %t1087)
  %t7.i8 = tail call i32 @strlen(ptr nonnull %t1087)
  %spec.select.i9 = tail call i32 @llvm.smin.i32(i32 %t38, i32 %t7.i8)
  %t17.i10 = icmp sle i32 %storemerge.lcssa, %spec.select.i9
  %t259.i11 = icmp samesign ult i32 %storemerge.lcssa, %spec.select.i9
  %or.cond.i12 = select i1 %t17.i10, i1 %t259.i11, i1 false
  br i1 %or.cond.i12, label %whileBody114.i14, label %slice.exit23

whileBody114.i14:                                 ; preds = %slice.exit, %whileBody114.i14
  %storemerge11.i15 = phi i32 [ %t35.i21, %whileBody114.i14 ], [ %storemerge.lcssa, %slice.exit ]
  %t33810.i16 = phi ptr [ %t33.i20, %whileBody114.i14 ], [ @.str_stdlib_stdlib_0, %slice.exit ]
  %6 = zext nneg i32 %storemerge11.i15 to i64
  %t29.i17 = getelementptr i8, ptr %t1087, i64 %6
  %t30.i18 = load i8, ptr %t29.i17, align 1
  %t31.i19 = tail call ptr @zen_char_to_string(i8 %t30.i18)
  %t33.i20 = tail call ptr @str_concat(ptr %t33810.i16, ptr %t31.i19)
  %t35.i21 = add nuw nsw i32 %storemerge11.i15, 1
  %t25.i22 = icmp slt i32 %t35.i21, %spec.select.i9
  br i1 %t25.i22, label %whileBody114.i14, label %slice.exit23

slice.exit23:                                     ; preds = %whileBody114.i14, %slice.exit
  %t57 = phi ptr [ @.str_stdlib_stdlib_0, %slice.exit ], [ %t33.i20, %whileBody114.i14 ]
  %strcmpload2 = load i8, ptr %common.ret.op.i7, align 1
  %t45.not = icmp eq i8 %strcmpload2, 0
  br i1 %t45.not, label %end621, label %if622

if622:                                            ; preds = %slice.exit23
  %t48 = tail call ptr @_json_getKey(ptr %t4.085, ptr nonnull %common.ret.op.i7)
  %t52 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t48, ptr noundef nonnull dereferenceable(5) @.str_stdlib_stdlib_32)
  %t53 = icmp eq i32 %t52, 0
  br i1 %t53, label %common.ret, label %end621

common.ret:                                       ; preds = %if622, %whileEnd627, %_json_parseInt.exit, %entry
  %common.ret.op = phi ptr [ %t0, %entry ], [ @.str_stdlib_stdlib_32, %_json_parseInt.exit ], [ @.str_stdlib_stdlib_32, %if622 ], [ %t4.2.lcssa, %whileEnd627 ]
  ret ptr %common.ret.op

end621:                                           ; preds = %if622, %slice.exit23
  %t4.1 = phi ptr [ %t48, %if622 ], [ %t4.085, %slice.exit23 ]
  %t5876 = tail call i32 @strlen(ptr %t57)
  %t5977 = icmp sgt i32 %t5876, 0
  br i1 %t5977, label %whileBody626, label %whileEnd627

whileBody626:                                     ; preds = %end621, %end635
  %t4.279 = phi ptr [ %t94, %end635 ], [ %t4.1, %end621 ]
  %storemerge4.in.peel = phi i32 [ %t102, %end635 ], [ 0, %end621 ]
  %t5.i24 = tail call i32 @strlen(ptr %t57)
  %t9.i25 = icmp slt i32 %storemerge4.in.peel, 0
  %t12.i26 = icmp sge i32 %storemerge4.in.peel, %t5.i24
  %t7.i27 = select i1 %t9.i25, i1 true, i1 %t12.i26
  br i1 %t7.i27, label %sub_064, label %end116.i28

end116.i28:                                       ; preds = %whileBody626
  %7 = zext nneg i32 %storemerge4.in.peel to i64
  %t16.i29 = getelementptr i8, ptr %t57, i64 %7
  %t17.i30 = load i8, ptr %t16.i29, align 1
  %t18.i31 = tail call ptr @zen_char_to_string(i8 %t17.i30)
  br label %sub_064

sub_064:                                          ; preds = %end116.i28, %whileBody626
  %common.ret.op.i32 = phi ptr [ %t18.i31, %end116.i28 ], [ @.str_stdlib_stdlib_0, %whileBody626 ]
  %8 = load i8, ptr %common.ret.op.i32, align 1
  %.not90 = icmp eq i8 %8, 91
  br i1 %.not90, label %charAt.exit33.tail, label %whileEnd627

charAt.exit33.tail:                               ; preds = %sub_064
  %9 = getelementptr inbounds nuw i8, ptr %common.ret.op.i32, i64 1
  %10 = load i8, ptr %9, align 1
  %11 = icmp eq i8 %10, 0
  br i1 %11, label %end628, label %whileEnd627

end628:                                           ; preds = %charAt.exit33.tail
  %storemerge4.peel = add nsw i32 %storemerge4.in.peel, 1
  %t72.peel = tail call i32 @strlen(ptr %t57)
  %t73.peel = icmp slt i32 %storemerge4.peel, %t72.peel
  br i1 %t73.peel, label %whileBody631.peel, label %whileEnd632

whileBody631.peel:                                ; preds = %end628
  %t5.i34.peel = tail call i32 @strlen(ptr %t57)
  %t9.i35.peel = icmp slt i32 %storemerge4.in.peel, -1
  %t12.i36.peel = icmp sge i32 %storemerge4.peel, %t5.i34.peel
  %t7.i37.peel = select i1 %t9.i35.peel, i1 true, i1 %t12.i36.peel
  br i1 %t7.i37.peel, label %sub_067.peel, label %end116.i38.peel

end116.i38.peel:                                  ; preds = %whileBody631.peel
  %12 = zext nneg i32 %storemerge4.peel to i64
  %t16.i39.peel = getelementptr i8, ptr %t57, i64 %12
  %t17.i40.peel = load i8, ptr %t16.i39.peel, align 1
  %t18.i41.peel = tail call ptr @zen_char_to_string(i8 %t17.i40.peel)
  br label %sub_067.peel

sub_067.peel:                                     ; preds = %end116.i38.peel, %whileBody631.peel
  %common.ret.op.i42.peel = phi ptr [ %t18.i41.peel, %end116.i38.peel ], [ @.str_stdlib_stdlib_0, %whileBody631.peel ]
  %13 = load i8, ptr %common.ret.op.i42.peel, align 1
  %.not91.peel = icmp eq i8 %13, 93
  br i1 %.not91.peel, label %charAt.exit43.tail.peel, label %whileCond630.peel.next

charAt.exit43.tail.peel:                          ; preds = %sub_067.peel
  %14 = getelementptr inbounds nuw i8, ptr %common.ret.op.i42.peel, i64 1
  %15 = load i8, ptr %14, align 1
  %16 = icmp eq i8 %15, 0
  br i1 %16, label %whileEnd632, label %whileCond630.peel.next

whileCond630.peel.next:                           ; preds = %sub_067.peel, %charAt.exit43.tail.peel
  %storemerge4100 = add nsw i32 %storemerge4.in.peel, 2
  %t72101 = tail call i32 @strlen(ptr %t57)
  %t73102 = icmp slt i32 %storemerge4100, %t72101
  br i1 %t73102, label %whileBody631, label %whileEnd632

whileBody631:                                     ; preds = %whileCond630.peel.next, %whileCond630.backedge
  %storemerge4104 = phi i32 [ %storemerge4, %whileCond630.backedge ], [ %storemerge4100, %whileCond630.peel.next ]
  %storemerge4.in103 = phi i32 [ %storemerge4104, %whileCond630.backedge ], [ %storemerge4.peel, %whileCond630.peel.next ]
  %t5.i34 = tail call i32 @strlen(ptr %t57)
  %t9.i35 = icmp slt i32 %storemerge4.in103, -1
  %t12.i36 = icmp sge i32 %storemerge4104, %t5.i34
  %t7.i37 = select i1 %t9.i35, i1 true, i1 %t12.i36
  br i1 %t7.i37, label %sub_067, label %end116.i38

end116.i38:                                       ; preds = %whileBody631
  %17 = zext nneg i32 %storemerge4104 to i64
  %t16.i39 = getelementptr i8, ptr %t57, i64 %17
  %t17.i40 = load i8, ptr %t16.i39, align 1
  %t18.i41 = tail call ptr @zen_char_to_string(i8 %t17.i40)
  br label %sub_067

sub_067:                                          ; preds = %end116.i38, %whileBody631
  %common.ret.op.i42 = phi ptr [ %t18.i41, %end116.i38 ], [ @.str_stdlib_stdlib_0, %whileBody631 ]
  %18 = load i8, ptr %common.ret.op.i42, align 1
  %.not91 = icmp eq i8 %18, 93
  br i1 %.not91, label %sub_168, label %whileCond630.backedge

sub_168:                                          ; preds = %sub_067
  %19 = getelementptr inbounds nuw i8, ptr %common.ret.op.i42, i64 1
  %20 = load i8, ptr %19, align 1
  %21 = icmp eq i8 %20, 0
  br i1 %21, label %whileEnd632, label %whileCond630.backedge

whileCond630.backedge:                            ; preds = %sub_067, %sub_168
  %storemerge4 = add nsw i32 %storemerge4104, 1
  %t72 = tail call i32 @strlen(ptr %t57)
  %t73 = icmp slt i32 %storemerge4, %t72
  br i1 %t73, label %whileBody631, label %whileEnd632, !llvm.loop !2

whileEnd632:                                      ; preds = %sub_168, %whileCond630.backedge, %whileCond630.peel.next, %charAt.exit43.tail.peel, %end628
  %t101 = phi i32 [ %storemerge4.peel, %end628 ], [ %storemerge4.peel, %charAt.exit43.tail.peel ], [ %storemerge4100, %whileCond630.peel.next ], [ %storemerge4, %whileCond630.backedge ], [ %storemerge4104, %sub_168 ]
  %t7.i44 = tail call i32 @strlen(ptr %t57)
  %spec.store.select.i45 = tail call i32 @llvm.smax.i32(i32 %storemerge4.peel, i32 0)
  %spec.select.i46 = tail call i32 @llvm.smin.i32(i32 %t101, i32 %t7.i44)
  %t17.i47 = icmp sle i32 %spec.store.select.i45, %spec.select.i46
  %t259.i48 = icmp samesign ult i32 %spec.store.select.i45, %spec.select.i46
  %or.cond.i49 = select i1 %t17.i47, i1 %t259.i48, i1 false
  br i1 %or.cond.i49, label %whileBody114.i51, label %slice.exit60

whileBody114.i51:                                 ; preds = %whileEnd632, %whileBody114.i51
  %storemerge11.i52 = phi i32 [ %t35.i58, %whileBody114.i51 ], [ %spec.store.select.i45, %whileEnd632 ]
  %t33810.i53 = phi ptr [ %t33.i57, %whileBody114.i51 ], [ @.str_stdlib_stdlib_0, %whileEnd632 ]
  %22 = zext nneg i32 %storemerge11.i52 to i64
  %t29.i54 = getelementptr i8, ptr %t57, i64 %22
  %t30.i55 = load i8, ptr %t29.i54, align 1
  %t31.i56 = tail call ptr @zen_char_to_string(i8 %t30.i55)
  %t33.i57 = tail call ptr @str_concat(ptr %t33810.i53, ptr %t31.i56)
  %t35.i58 = add nuw nsw i32 %storemerge11.i52, 1
  %t25.i59 = icmp slt i32 %t35.i58, %spec.select.i46
  br i1 %t25.i59, label %whileBody114.i51, label %slice.exit60

slice.exit60:                                     ; preds = %whileBody114.i51, %whileEnd632
  %common.ret.op.i50 = phi ptr [ @.str_stdlib_stdlib_0, %whileEnd632 ], [ %t33.i57, %whileBody114.i51 ]
  %t64.i = tail call i32 @strlen(ptr %common.ret.op.i50)
  %t75.i = icmp sgt i32 %t64.i, 0
  br i1 %t75.i, label %whileBody609.i, label %_json_parseInt.exit

whileBody609.i:                                   ; preds = %slice.exit60, %charAt.exit.i
  %t3.07.i = phi i32 [ %t19.i, %charAt.exit.i ], [ 0, %slice.exit60 ]
  %t2.06.i = phi i32 [ %t17.i62, %charAt.exit.i ], [ 0, %slice.exit60 ]
  %t5.i.i = tail call i32 @strlen(ptr %common.ret.op.i50)
  %t12.i.not.i = icmp slt i32 %t3.07.i, %t5.i.i
  br i1 %t12.i.not.i, label %end116.i.i, label %charAt.exit.i

end116.i.i:                                       ; preds = %whileBody609.i
  %23 = zext nneg i32 %t3.07.i to i64
  %t16.i.i = getelementptr i8, ptr %common.ret.op.i50, i64 %23
  %t17.i.i = load i8, ptr %t16.i.i, align 1
  %t18.i.i = tail call ptr @zen_char_to_string(i8 %t17.i.i)
  br label %charAt.exit.i

charAt.exit.i:                                    ; preds = %end116.i.i, %whileBody609.i
  %common.ret.op.i.i = phi ptr [ %t18.i.i, %end116.i.i ], [ @.str_stdlib_stdlib_0, %whileBody609.i ]
  %t12.i61 = tail call i32 @string_to_int_ascii(ptr %common.ret.op.i.i)
  %t15.i = mul i32 %t2.06.i, 10
  %t13.i = add i32 %t15.i, -48
  %t17.i62 = add i32 %t13.i, %t12.i61
  %t19.i = add nuw nsw i32 %t3.07.i, 1
  %t6.i = tail call i32 @strlen(ptr %common.ret.op.i50)
  %t7.i63 = icmp slt i32 %t19.i, %t6.i
  br i1 %t7.i63, label %whileBody609.i, label %_json_parseInt.exit

_json_parseInt.exit:                              ; preds = %charAt.exit.i, %slice.exit60
  %t2.0.lcssa.i = phi i32 [ 0, %slice.exit60 ], [ %t17.i62, %charAt.exit.i ]
  %t94 = tail call ptr @_json_getArrayIndex(ptr %t4.279, i32 %t2.0.lcssa.i)
  %t98 = tail call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t94, ptr noundef nonnull dereferenceable(5) @.str_stdlib_stdlib_32)
  %t99 = icmp eq i32 %t98, 0
  br i1 %t99, label %common.ret, label %end635

end635:                                           ; preds = %_json_parseInt.exit
  %t102 = add i32 %t101, 1
  %t58 = tail call i32 @strlen(ptr %t57)
  %t59 = icmp slt i32 %t102, %t58
  br i1 %t59, label %whileBody626, label %whileEnd627

whileEnd627:                                      ; preds = %sub_064, %end635, %charAt.exit33.tail, %end621
  %t4.2.lcssa = phi ptr [ %t4.1, %end621 ], [ %t4.279, %sub_064 ], [ %t4.279, %charAt.exit33.tail ], [ %t94, %end635 ]
  %t104 = add i32 %t6.086, 1
  %t10 = tail call ptr @splitAt(ptr %t1, ptr nonnull @.str_stdlib_stdlib_8, i32 %t104)
  %strcmpload = load i8, ptr %t10, align 1
  %t16 = icmp eq i8 %strcmpload, 0
  br i1 %t16, label %common.ret, label %whileCond616.preheader
}

define ptr @split(ptr %t0, ptr %t1) local_unnamed_addr {
entry:
  %t5 = tail call ptr @zen_list_new(i64 8)
  %t7 = tail call i32 @strlen(ptr %t0)
  %t10 = tail call i32 @strlen(ptr %t1)
  %t13 = icmp eq i32 %t10, 0
  br i1 %t13, label %common.ret, label %end637

common.ret:                                       ; preds = %entry, %whileEnd641
  ret ptr %t5

end637:                                           ; preds = %entry
  %t2013 = icmp sgt i32 %t7, 0
  br i1 %t2013, label %whileBody640.lr.ph, label %whileEnd641

whileBody640.lr.ph:                               ; preds = %end637
  %t26 = sub i32 %t7, %t10
  %t308 = icmp sgt i32 %t10, 0
  br label %whileBody640

whileBody640:                                     ; preds = %whileBody640.lr.ph, %end650
  %storemerge515 = phi i32 [ 0, %whileBody640.lr.ph ], [ %t67, %end650 ]
  %t651114 = phi ptr [ @.str_stdlib_stdlib_0, %whileBody640.lr.ph ], [ %t6512, %end650 ]
  %t27.not = icmp sgt i32 %storemerge515, %t26
  br i1 %t27.not, label %else652, label %whileCond645.preheader

whileCond645.preheader:                           ; preds = %whileBody640
  br i1 %t308, label %whileBody646, label %if651

whileBody646:                                     ; preds = %whileCond645.preheader, %whileBody646
  %t4979 = phi i32 [ %t49, %whileBody646 ], [ 0, %whileCond645.preheader ]
  %0 = phi i1 [ %spec.select, %whileBody646 ], [ true, %whileCond645.preheader ]
  %t34 = add i32 %t4979, %storemerge515
  %1 = sext i32 %t34 to i64
  %t35 = getelementptr i8, ptr %t0, i64 %1
  %t36 = load i8, ptr %t35, align 1
  %t37 = call ptr @zen_char_to_string(i8 %t36)
  %2 = zext nneg i32 %t4979 to i64
  %t41 = getelementptr i8, ptr %t1, i64 %2
  %t42 = load i8, ptr %t41, align 1
  %t43 = call ptr @zen_char_to_string(i8 %t42)
  %t46 = call i32 @strcmp(ptr noundef nonnull dereferenceable(1) %t37, ptr noundef nonnull dereferenceable(1) %t43)
  %t47.not = icmp eq i32 %t46, 0
  %spec.select = select i1 %t47.not, i1 %0, i1 false
  %t49 = add nuw nsw i32 %t4979, 1
  %t30 = icmp slt i32 %t49, %t10
  br i1 %t30, label %whileBody646, label %end642

end642:                                           ; preds = %whileBody646
  br i1 %spec.select, label %if651, label %else652

if651:                                            ; preds = %whileCond645.preheader, %end642
  %t53 = alloca ptr, align 8
  store ptr %t651114, ptr %t53, align 8
  call void @zen_list_push(ptr %t5, ptr nonnull %t53)
  br label %end650

else652:                                          ; preds = %whileBody640, %end642
  %3 = sext i32 %storemerge515 to i64
  %t61 = getelementptr i8, ptr %t0, i64 %3
  %t62 = load i8, ptr %t61, align 1
  %t63 = call ptr @zen_char_to_string(i8 %t62)
  %t65 = call ptr @str_concat(ptr %t651114, ptr %t63)
  br label %end650

end650:                                           ; preds = %else652, %if651
  %.sink = phi i32 [ 1, %else652 ], [ %t10, %if651 ]
  %t6512 = phi ptr [ %t65, %else652 ], [ @.str_stdlib_stdlib_0, %if651 ]
  %t67 = add i32 %storemerge515, %.sink
  %t20 = icmp slt i32 %t67, %t7
  br i1 %t20, label %whileBody640, label %whileEnd641

whileEnd641:                                      ; preds = %end650, %end637
  %t6511.lcssa = phi ptr [ @.str_stdlib_stdlib_0, %end637 ], [ %t6512, %end650 ]
  %t70 = alloca ptr, align 8
  store ptr %t6511.lcssa, ptr %t70, align 8
  call void @zen_list_push(ptr %t5, ptr nonnull %t70)
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

!0 = distinct !{!0, !1}
!1 = !{!"llvm.loop.peeled.count", i32 1}
!2 = distinct !{!2, !1}
