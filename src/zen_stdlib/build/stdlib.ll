@NAN = external constant double
@NEG_INF = external constant double
@INF = external constant double
@F64_EPS = external constant double
@F64_MIN = external constant double
@F64_MAX = external constant double
@I32_MIN = external constant i32
@I32_MAX = external constant i32
@SEED = external global i32
@LN10 = external constant double
@LN2 = external constant double
@SQRT2 = external constant double
@PHI = external constant double
@E = external constant double
@TAU = external constant double
@PI = external constant double
%ZenList = type { ptr, i32, i32, i64 }
declare void @zen_list_push(ptr, ptr)
declare ptr @zen_list_new(i64)
declare i8* @int_to_string_ascii(i32)
declare i32 @string_to_int_ascii(i8*)
declare i32 @strcmp(i8*, i8*)
declare i8* @str_concat(i8*, i8*)
declare i8* @zen_char_to_string(i8)
declare i32 @strlen(i8*)






@.str_stdlib_stdlib_0 = private unnamed_addr constant [1 x i8] c"\00"
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




@t_stdlib_78 = global i32 0

@.str_stdlib_stdlib_28 = private unnamed_addr constant [2 x i8] c",\00"

@.str_stdlib_stdlib_29 = private unnamed_addr constant [2 x i8] c"\22\00"

@.str_stdlib_stdlib_30 = private unnamed_addr constant [2 x i8] c"{\00"
@.str_stdlib_stdlib_31 = private unnamed_addr constant [2 x i8] c"}\00"





@.str_stdlib_stdlib_32 = private unnamed_addr constant [5 x i8] c"null\00"




















define i1 @isEven (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = srem i32 %t2, 2
%t4 = icmp eq i32 %t3, 0
ret i1 %t4
}
define i1 @isOdd (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = srem i32 %t2, 2
%t4 = icmp ne i32 %t3, 0
ret i1 %t4
}
define i1 @isPositive (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = icmp sgt i32 %t2, 0
ret i1 %t3
}
define i1 @isNegative (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = icmp slt i32 %t2, 0
ret i1 %t3
}
define i1 @isNaN (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
%t2 = load double, ptr %x.addr
%t3 = load double, ptr %x.addr
%t4 = fcmp one double %t2, %t3
ret i1 %t4
}
define i32 @abs (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = icmp slt i32 %t2, 0
br i1 %t3, label %if1, label %end0
if1:
%t4 = load i32, ptr %x.addr
%t5 = sub i32 0, %t4
ret i32 %t5
br label %end0
end0:
%t6 = load i32, ptr %x.addr
ret i32 %t6
}
define i32 @max (i32 %t0, i32 %t1) {
entry:
%a.addr = alloca i32
store i32 %t0, i32* %a.addr
%t2 = load i32, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, i32* %b.addr
%t3 = load i32, ptr %b.addr
%t4 = load i32, ptr %a.addr
%t5 = load i32, ptr %b.addr
%t6 = icmp sgt i32 %t4, %t5
br i1 %t6, label %if3, label %end2
if3:
%t7 = load i32, ptr %a.addr
ret i32 %t7
br label %end2
end2:
%t8 = load i32, ptr %b.addr
ret i32 %t8
}
define i32 @min (i32 %t0, i32 %t1) {
entry:
%a.addr = alloca i32
store i32 %t0, i32* %a.addr
%t2 = load i32, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, i32* %b.addr
%t3 = load i32, ptr %b.addr
%t4 = load i32, ptr %a.addr
%t5 = load i32, ptr %b.addr
%t6 = icmp slt i32 %t4, %t5
br i1 %t6, label %if5, label %end4
if5:
%t7 = load i32, ptr %a.addr
ret i32 %t7
br label %end4
end4:
%t8 = load i32, ptr %b.addr
ret i32 %t8
}
define i32 @clamp (i32 %t0, i32 %t1, i32 %t2) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t3 = load i32, ptr %x.addr
%low.addr = alloca i32
store i32 %t1, i32* %low.addr
%t4 = load i32, ptr %low.addr
%high.addr = alloca i32
store i32 %t2, i32* %high.addr
%t5 = load i32, ptr %high.addr
%t6 = load i32, ptr %x.addr
%t7 = load i32, ptr %low.addr
%t8 = icmp slt i32 %t6, %t7
br i1 %t8, label %if7, label %end6
if7:
%t9 = load i32, ptr %low.addr
ret i32 %t9
br label %end6
end6:
%t10 = load i32, ptr %x.addr
%t11 = load i32, ptr %high.addr
%t12 = icmp sgt i32 %t10, %t11
br i1 %t12, label %if9, label %end8
if9:
%t13 = load i32, ptr %high.addr
ret i32 %t13
br label %end8
end8:
%t14 = load i32, ptr %x.addr
ret i32 %t14
}
define i32 @sign (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = icmp sgt i32 %t2, 0
br i1 %t3, label %if11, label %end10
if11:
ret i32 1
br label %end10
end10:
%t4 = load i32, ptr %x.addr
%t5 = icmp slt i32 %t4, 0
br i1 %t5, label %if13, label %end12
if13:
ret i32 -1
br label %end12
end12:
ret i32 0
}
define double @pow (i32 %t0, i32 %t1) {
entry:
%base.addr = alloca i32
store i32 %t0, i32* %base.addr
%t2 = load i32, ptr %base.addr
%exp.addr = alloca i32
store i32 %t1, i32* %exp.addr
%t3 = load i32, ptr %exp.addr
%t4 = load i32, ptr %exp.addr
%t5 = icmp eq i32 %t4, 0
br i1 %t5, label %if15, label %end14
if15:
ret double 1.0
br label %end14
end14:
%t6 = load i32, ptr %base.addr
%t7 = icmp eq i32 %t6, 0
br i1 %t7, label %if17, label %end16
if17:
%t8 = load i32, ptr %exp.addr
%t9 = icmp sgt i32 %t8, 0
br i1 %t9, label %if19, label %end18
if19:
ret double 0.0
br label %end18
end18:
%t10 = load double, ptr @INF
ret double %t10
br label %end16
end16:
%t11 = load i32, ptr %base.addr
%t12 = icmp eq i32 %t11, 1
br i1 %t12, label %if21, label %end20
if21:
ret double 1.0
br label %end20
end20:
%t13 = load i32, ptr %base.addr
%t14 = icmp eq i32 %t13, -1
br i1 %t14, label %if23, label %end22
if23:
%t15 = load i32, ptr %exp.addr
%t16 = srem i32 %t15, 2
%t17 = icmp eq i32 %t16, 0
br i1 %t17, label %if25, label %end24
if25:
ret double 1.0
br label %end24
end24:
ret double -1.0
br label %end22
end22:
%t18 = alloca i1
store i1 0, ptr %t18
%t19 = load i32, ptr %exp.addr
%t20 = icmp slt i32 %t19, 0
br i1 %t20, label %if27, label %end26
if27:
store i1 1, ptr %t18
%t21 = load i32, ptr %exp.addr
%t23 = sub i32 0, %t21
store i32 %t23, ptr %exp.addr
br label %end26
end26:
%t24 = alloca double
store double 1.0, ptr %t24
%t25 = alloca i32
store i32 0, ptr %t25
br label %whileCond28
whileCond28:
%t26 = load i32, ptr %t25
%t27 = load i32, ptr %exp.addr
%t28 = icmp slt i32 %t26, %t27
br i1 %t28, label %whileBody29, label %whileEnd30
whileBody29:
%t29 = load double, ptr %t24
%t30 = load i32, ptr %base.addr
%t31 = sitofp i32 %t30 to double
%t32 = fmul double %t29, %t31
store double %t32, ptr %t24
%t33 = load double, ptr %t24
%t34 = load double, ptr @INF
%t35 = fcmp oeq double %t33, %t34
br i1 %t35, label %if32, label %end31
if32:
%t36 = load double, ptr @INF
ret double %t36
br label %end31
end31:
%t37 = load i32, ptr %t25
%t38 = add i32 %t37, 1
store i32 %t38, ptr %t25
br label %whileCond28
whileEnd30:
%t39 = load i1, ptr %t18
br i1 %t39, label %if34, label %end33
if34:
%t40 = load double, ptr %t24
%t41 = fdiv double 1.0, %t40
ret double %t41
br label %end33
end33:
%t42 = load double, ptr %t24
ret double %t42
}
define i32 @sqrt (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = icmp slt i32 %t2, 0
br i1 %t3, label %if36, label %end35
if36:
ret i32 -1
br label %end35
end35:
%t4 = alloca i32
store i32 1, ptr %t4
br label %whileCond37
whileCond37:
%t5 = load i32, ptr %t4
%t6 = load i32, ptr %t4
%t8 = load i32, ptr %x.addr
%t7 = mul i32 %t5, %t6
%t9 = icmp sle i32 %t7, %t8
br i1 %t9, label %whileBody38, label %whileEnd39
whileBody38:
%t10 = load i32, ptr %t4
%t11 = add i32 %t10, 1
store i32 %t11, ptr %t4
br label %whileCond37
whileEnd39:
%t12 = load i32, ptr %t4
%t13 = sub i32 %t12, 1
ret i32 %t13
}
define i32 @square (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = load i32, ptr %x.addr
%t4 = mul i32 %t2, %t3
ret i32 %t4
}
define i32 @cube (i32 %t0) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = load i32, ptr %x.addr
%t5 = load i32, ptr %x.addr
%t4 = mul i32 %t2, %t3
%t6 = mul i32 %t4, %t5
ret i32 %t6
}
define i32 @floor (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
%t2 = load double, ptr %x.addr
%t3 = fptosi double %t2 to i32
%t4 = alloca i32
store i32 %t3, ptr %t4
%t6 = load double, ptr %x.addr
%t9 = load double, ptr %x.addr
%t10 = load i32, ptr %t4
%t8 = sitofp i32 0 to double
%t7 = fcmp olt double %t6, %t8
br i1 %t7, label %rhs41, label %skip42
rhs41:
%t12 = sitofp i32 %t10 to double
%t11 = fcmp one double %t9, %t12
br label %end43
skip42:
br label %end43
end43:
%t5 = phi i1 [ false, %skip42 ], [ %t11, %rhs41 ]
br i1 %t5, label %if44, label %end40
if44:
%t13 = load i32, ptr %t4
%t14 = sub i32 %t13, 1
ret i32 %t14
br label %end40
end40:
%t15 = load i32, ptr %t4
ret i32 %t15
}
define i32 @ceil (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
%t2 = load double, ptr %x.addr
%t3 = fptosi double %t2 to i32
%t4 = alloca i32
store i32 %t3, ptr %t4
%t5 = load double, ptr %x.addr
%t6 = load i32, ptr %t4
%t8 = sitofp i32 %t6 to double
%t7 = fcmp oeq double %t5, %t8
br i1 %t7, label %if46, label %end45
if46:
%t9 = load i32, ptr %t4
ret i32 %t9
br label %end45
end45:
%t10 = load double, ptr %x.addr
%t12 = sitofp i32 0 to double
%t11 = fcmp ogt double %t10, %t12
br i1 %t11, label %if48, label %end47
if48:
%t13 = load i32, ptr %t4
%t14 = add i32 %t13, 1
ret i32 %t14
br label %end47
end47:
%t15 = load i32, ptr %t4
ret i32 %t15
}
define i32 @round (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
%t2 = load double, ptr %x.addr
%t3 = fptosi double %t2 to i32
%t4 = alloca i32
store i32 %t3, ptr %t4
%t6 = load double, ptr %x.addr
%t7 = load i32, ptr %t4
%t5 = alloca double
%t8 = sitofp i32 %t7 to double
%t9 = fsub double %t6, %t8
store double %t9, ptr %t5
%t10 = load double, ptr %x.addr
%t12 = sitofp i32 0 to double
%t11 = fcmp oge double %t10, %t12
br i1 %t11, label %if50, label %end49
if50:
%t13 = load double, ptr %t5
%t14 = fcmp oge double %t13, 0.5
br i1 %t14, label %if52, label %end51
if52:
%t15 = load i32, ptr %t4
%t16 = add i32 %t15, 1
ret i32 %t16
br label %end51
end51:
%t17 = load i32, ptr %t4
ret i32 %t17
br label %end49
end49:
%t18 = load double, ptr %t5
%t19 = fcmp ole double %t18, -0.5
br i1 %t19, label %if54, label %end53
if54:
%t20 = load i32, ptr %t4
%t21 = sub i32 %t20, 1
ret i32 %t21
br label %end53
end53:
%t22 = load i32, ptr %t4
ret i32 %t22
}
define double @toFixed (double %t0, i32 %t1) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t2 = load double, ptr %x.addr
%precision.addr = alloca i32
store i32 %t1, i32* %precision.addr
%t3 = load i32, ptr %precision.addr
%t4 = load i32, ptr %precision.addr
%t5 = icmp slt i32 %t4, 0
br i1 %t5, label %if56, label %end55
if56:
%t6 = load double, ptr %x.addr
ret double %t6
br label %end55
end55:
%t7 = load i32, ptr %precision.addr
%t8 = call double @pow(i32 10, i32 %t7)
%t9 = alloca double
store double %t8, ptr %t9
%t11 = load double, ptr %x.addr
%t12 = load double, ptr %t9
%t10 = alloca double
%t13 = fmul double %t11, %t12
store double %t13, ptr %t10
%t14 = load double, ptr %t10
%t15 = call i32 @round(double %t14)
%t16 = alloca i32
store i32 %t15, ptr %t16
%t17 = load i32, ptr %t16
%t18 = load double, ptr %t9
%t19 = sitofp i32 %t17 to double
%t20 = fdiv double %t19, %t18
ret double %t20
}
define i32 @mod (i32 %t0, i32 %t1) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t2 = load i32, ptr %x.addr
%m.addr = alloca i32
store i32 %t1, i32* %m.addr
%t3 = load i32, ptr %m.addr
%t4 = load i32, ptr %m.addr
%t5 = icmp slt i32 %t4, 0
br i1 %t5, label %if58, label %end57
if58:
%t6 = load i32, ptr %m.addr
%t7 = sub i32 0, %t6
store i32 %t7, ptr %m.addr
br label %end57
end57:
%t9 = load i32, ptr %x.addr
%t10 = load i32, ptr %m.addr
%t8 = alloca i32
%t11 = srem i32 %t9, %t10
store i32 %t11, ptr %t8
%t12 = load i32, ptr %t8
%t13 = icmp slt i32 %t12, 0
br i1 %t13, label %if60, label %end59
if60:
%t14 = load i32, ptr %t8
%t15 = load i32, ptr %m.addr
%t16 = add i32 %t14, %t15
ret i32 %t16
br label %end59
end59:
%t17 = load i32, ptr %t8
ret i32 %t17
}
define i32 @gcd (i32 %t0, i32 %t1) {
entry:
%a.addr = alloca i32
store i32 %t0, i32* %a.addr
%t2 = load i32, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, i32* %b.addr
%t3 = load i32, ptr %b.addr
%t4 = load i32, ptr %a.addr
%t5 = call i32 @abs(i32 %t4)
store i32 %t5, ptr %a.addr
%t6 = load i32, ptr %b.addr
%t7 = call i32 @abs(i32 %t6)
store i32 %t7, ptr %b.addr
br label %whileCond61
whileCond61:
%t8 = load i32, ptr %b.addr
%t9 = icmp ne i32 %t8, 0
br i1 %t9, label %whileBody62, label %whileEnd63
whileBody62:
%t11 = load i32, ptr %b.addr
%t10 = alloca i32
store i32 %t11, ptr %t10
%t12 = load i32, ptr %a.addr
%t13 = load i32, ptr %b.addr
%t14 = srem i32 %t12, %t13
store i32 %t14, ptr %b.addr
%t15 = load i32, ptr %t10
store i32 %t15, ptr %a.addr
br label %whileCond61
whileEnd63:
%t16 = load i32, ptr %a.addr
ret i32 %t16
}
define i32 @lcm (i32 %t0, i32 %t1) {
entry:
%a.addr = alloca i32
store i32 %t0, i32* %a.addr
%t2 = load i32, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, i32* %b.addr
%t3 = load i32, ptr %b.addr
%t5 = load i32, ptr %a.addr
%t7 = load i32, ptr %b.addr
%t6 = icmp eq i32 %t5, 0
br i1 %t6, label %skip66, label %rhs65
rhs65:
%t8 = icmp eq i32 %t7, 0
br label %end67
skip66:
br label %end67
end67:
%t4 = phi i1 [ true, %skip66 ], [ %t8, %rhs65 ]
br i1 %t4, label %if68, label %end64
if68:
ret i32 0
br label %end64
end64:
%t9 = load i32, ptr %a.addr
%t10 = load i32, ptr %a.addr
%t11 = load i32, ptr %b.addr
%t14 = load i32, ptr %b.addr
%t12 = call i32 @gcd(i32 %t10, i32 %t11)
%t13 = sdiv i32 %t9, %t12
%t15 = mul i32 %t13, %t14
%t16 = call i32 @abs(i32 %t15)
ret i32 %t16
}
define double @factorial (i32 %t0) {
entry:
%n.addr = alloca i32
store i32 %t0, i32* %n.addr
%t1 = load i32, ptr %n.addr
%t2 = load i32, ptr %n.addr
%t3 = icmp slt i32 %t2, 0
br i1 %t3, label %if70, label %end69
if70:
ret double -1.0
br label %end69
end69:
%t4 = load i32, ptr %n.addr
%t5 = icmp eq i32 %t4, 0
br i1 %t5, label %if72, label %end71
if72:
ret double 1.0
br label %end71
end71:
%t6 = alloca double
store double 1.0, ptr %t6
%t7 = alloca i32
store i32 1, ptr %t7
br label %whileCond73
whileCond73:
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %n.addr
%t10 = icmp sle i32 %t8, %t9
br i1 %t10, label %whileBody74, label %whileEnd75
whileBody74:
%t11 = load double, ptr %t6
%t12 = load i32, ptr %t7
%t13 = sitofp i32 %t12 to double
%t14 = fmul double %t11, %t13
store double %t14, ptr %t6
%t15 = load i32, ptr %t7
%t16 = add i32 %t15, 1
store i32 %t16, ptr %t7
br label %whileCond73
whileEnd75:
%t17 = load double, ptr %t6
ret double %t17
}
define i1 @isPrime (i32 %t0) {
entry:
%n.addr = alloca i32
store i32 %t0, i32* %n.addr
%t1 = load i32, ptr %n.addr
%t2 = load i32, ptr %n.addr
%t3 = icmp slt i32 %t2, 2
br i1 %t3, label %if77, label %end76
if77:
ret i1 0
br label %end76
end76:
%t4 = load i32, ptr %n.addr
%t5 = icmp eq i32 %t4, 2
br i1 %t5, label %if79, label %end78
if79:
ret i1 1
br label %end78
end78:
%t6 = load i32, ptr %n.addr
%t7 = call i1 @isEven(i32 %t6)
br i1 %t7, label %if81, label %end80
if81:
ret i1 0
br label %end80
end80:
%t8 = alloca i32
store i32 3, ptr %t8
br label %whileCond82
whileCond82:
%t9 = load i32, ptr %t8
%t10 = load i32, ptr %n.addr
%t11 = call i32 @sqrt(i32 %t10)
%t12 = icmp sle i32 %t9, %t11
br i1 %t12, label %whileBody83, label %whileEnd84
whileBody83:
%t13 = load i32, ptr %n.addr
%t14 = load i32, ptr %t8
%t15 = srem i32 %t13, %t14
%t16 = icmp eq i32 %t15, 0
br i1 %t16, label %if86, label %end85
if86:
ret i1 0
br label %end85
end85:
%t17 = load i32, ptr %t8
%t18 = add i32 %t17, 2
store i32 %t18, ptr %t8
br label %whileCond82
whileEnd84:
ret i1 1
}
define double @lerp (double %t0, double %t1, double %t2) {
entry:
%a.addr = alloca double
store double %t0, double* %a.addr
%t3 = load double, ptr %a.addr
%b.addr = alloca double
store double %t1, double* %b.addr
%t4 = load double, ptr %b.addr
%t.addr = alloca double
store double %t2, double* %t.addr
%t5 = load double, ptr %t.addr
%t6 = load double, ptr %a.addr
%t7 = load double, ptr %b.addr
%t8 = load double, ptr %a.addr
%t10 = load double, ptr %t.addr
%t9 = fsub double %t7, %t8
%t11 = fmul double %t9, %t10
%t12 = fadd double %t6, %t11
ret double %t12
}
define double @normalize (double %t0, double %t1, double %t2) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t3 = load double, ptr %x.addr
%a.addr = alloca double
store double %t1, double* %a.addr
%t4 = load double, ptr %a.addr
%b.addr = alloca double
store double %t2, double* %b.addr
%t5 = load double, ptr %b.addr
%t6 = load double, ptr %a.addr
%t7 = load double, ptr %b.addr
%t8 = fcmp oeq double %t6, %t7
br i1 %t8, label %if88, label %end87
if88:
ret double 0.0
br label %end87
end87:
%t9 = load double, ptr %x.addr
%t10 = load double, ptr %a.addr
%t12 = load double, ptr %b.addr
%t13 = load double, ptr %a.addr
%t11 = fsub double %t9, %t10
%t14 = fsub double %t12, %t13
%t15 = fdiv double %t11, %t14
ret double %t15
}
define i1 @between (i32 %t0, i32 %t1, i32 %t2) {
entry:
%x.addr = alloca i32
store i32 %t0, i32* %x.addr
%t3 = load i32, ptr %x.addr
%a.addr = alloca i32
store i32 %t1, i32* %a.addr
%t4 = load i32, ptr %a.addr
%b.addr = alloca i32
store i32 %t2, i32* %b.addr
%t5 = load i32, ptr %b.addr
%t7 = load i32, ptr %x.addr
%t8 = load i32, ptr %a.addr
%t10 = load i32, ptr %x.addr
%t11 = load i32, ptr %b.addr
%t9 = icmp sge i32 %t7, %t8
br i1 %t9, label %rhs89, label %skip90
rhs89:
%t12 = icmp sle i32 %t10, %t11
br label %end91
skip90:
br label %end91
end91:
%t6 = phi i1 [ false, %skip90 ], [ %t12, %rhs89 ]
ret i1 %t6
}
define i8* @reverse (i8* %t0) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t1 = load i8*, ptr %s.addr
%t2 = load i8*, ptr %s.addr
%t3 = call i32 @strlen(i8* %t2)
%t4 = alloca i32
store i32 %t3, ptr %t4
%t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t5 = alloca i8*
store i8* %t6, i8** %t5
%t8 = load i32, ptr %t4
%t7 = alloca i32
%t9 = sub i32 %t8, 1
store i32 %t9, ptr %t7
br label %whileCond92
whileCond92:
%t10 = load i32, ptr %t7
%t11 = icmp sge i32 %t10, 0
br i1 %t11, label %whileBody93, label %whileEnd94
whileBody93:
%t12 = load i8*, ptr %t5
%t13 = load i8*, ptr %s.addr
%t14 = load i32, ptr %t7
%t15 = getelementptr i8, i8* %t13, i32 %t14
%t16 = load i8, i8* %t15
%t17 = call i8* @zen_char_to_string(i8 %t16)
%t19 = call i8* @str_concat(i8* %t12, i8* %t17)
store i8* %t19, ptr %t5
%t20 = load i32, ptr %t7
%t21 = sub i32 %t20, 1
store i32 %t21, ptr %t7
br label %whileCond92
whileEnd94:
%t22 = load i8*, ptr %t5
ret i8* %t22
}
define i32 @indexOf (i8* %t0, i8* %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%target.addr = alloca i8*
store i8* %t1, i8** %target.addr
%t3 = load i8*, ptr %target.addr
%t4 = load i8*, ptr %s.addr
%t5 = call i32 @strlen(i8* %t4)
%t6 = alloca i32
store i32 %t5, ptr %t6
%t7 = load i8*, ptr %target.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = alloca i32
store i32 %t8, ptr %t9
%t10 = load i32, ptr %t9
%t11 = icmp eq i32 %t10, 0
br i1 %t11, label %if96, label %end95
if96:
ret i32 0
br label %end95
end95:
%t12 = alloca i32
store i32 0, ptr %t12
br label %whileCond97
whileCond97:
%t13 = load i32, ptr %t12
%t14 = load i32, ptr %t6
%t15 = load i32, ptr %t9
%t16 = sub i32 %t14, %t15
%t17 = icmp sle i32 %t13, %t16
br i1 %t17, label %whileBody98, label %whileEnd99
whileBody98:
%t18 = alloca i1
store i1 1, ptr %t18
%t19 = alloca i32
store i32 0, ptr %t19
br label %whileCond100
whileCond100:
%t20 = load i32, ptr %t19
%t21 = load i32, ptr %t9
%t22 = icmp slt i32 %t20, %t21
br i1 %t22, label %whileBody101, label %whileEnd102
whileBody101:
%t23 = load i8*, ptr %s.addr
%t24 = load i32, ptr %t12
%t25 = load i32, ptr %t19
%t26 = add i32 %t24, %t25
%t31 = load i8*, ptr %target.addr
%t32 = load i32, ptr %t19
%t27 = getelementptr i8, i8* %t23, i32 %t26
%t28 = load i8, i8* %t27
%t29 = call i8* @zen_char_to_string(i8 %t28)
%t33 = getelementptr i8, i8* %t31, i32 %t32
%t34 = load i8, i8* %t33
%t35 = call i8* @zen_char_to_string(i8 %t34)
%t38 = call i32 @strcmp(i8* %t29, i8* %t35)
%t39 = icmp ne i32 %t38, 0
br i1 %t39, label %if104, label %end103
if104:
store i1 0, ptr %t18
br label %end103
end103:
%t40 = load i32, ptr %t19
%t41 = add i32 %t40, 1
store i32 %t41, ptr %t19
br label %whileCond100
whileEnd102:
%t42 = load i1, ptr %t18
br i1 %t42, label %if106, label %end105
if106:
%t43 = load i32, ptr %t12
ret i32 %t43
br label %end105
end105:
%t44 = load i32, ptr %t12
%t45 = add i32 %t44, 1
store i32 %t45, ptr %t12
br label %whileCond97
whileEnd99:
ret i32 -1
}
define i8* @slice (i8* %t0, i32 %t1, i32 %t2) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t3 = load i8*, ptr %s.addr
%start.addr = alloca i32
store i32 %t1, i32* %start.addr
%t4 = load i32, ptr %start.addr
%end.addr = alloca i32
store i32 %t2, i32* %end.addr
%t5 = load i32, ptr %end.addr
%t6 = load i8*, ptr %s.addr
%t7 = call i32 @strlen(i8* %t6)
%t8 = alloca i32
store i32 %t7, ptr %t8
%t9 = load i32, ptr %start.addr
%t10 = icmp slt i32 %t9, 0
br i1 %t10, label %if108, label %end107
if108:
store i32 0, ptr %start.addr
br label %end107
end107:
%t11 = load i32, ptr %end.addr
%t12 = load i32, ptr %t8
%t13 = icmp sgt i32 %t11, %t12
br i1 %t13, label %if110, label %end109
if110:
%t14 = load i32, ptr %t8
store i32 %t14, ptr %end.addr
br label %end109
end109:
%t15 = load i32, ptr %start.addr
%t16 = load i32, ptr %end.addr
%t17 = icmp sgt i32 %t15, %t16
br i1 %t17, label %if112, label %end111
if112:
%t18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t18
br label %end111
end111:
%t20 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t19 = alloca i8*
store i8* %t20, i8** %t19
%t22 = load i32, ptr %start.addr
%t21 = alloca i32
store i32 %t22, ptr %t21
br label %whileCond113
whileCond113:
%t23 = load i32, ptr %t21
%t24 = load i32, ptr %end.addr
%t25 = icmp slt i32 %t23, %t24
br i1 %t25, label %whileBody114, label %whileEnd115
whileBody114:
%t26 = load i8*, ptr %t19
%t27 = load i8*, ptr %s.addr
%t28 = load i32, ptr %t21
%t29 = getelementptr i8, i8* %t27, i32 %t28
%t30 = load i8, i8* %t29
%t31 = call i8* @zen_char_to_string(i8 %t30)
%t33 = call i8* @str_concat(i8* %t26, i8* %t31)
store i8* %t33, ptr %t19
%t34 = load i32, ptr %t21
%t35 = add i32 %t34, 1
store i32 %t35, ptr %t21
br label %whileCond113
whileEnd115:
%t36 = load i8*, ptr %t19
ret i8* %t36
}
define i8* @charAt (i8* %t0, i32 %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%index.addr = alloca i32
store i32 %t1, i32* %index.addr
%t3 = load i32, ptr %index.addr
%t4 = load i8*, ptr %s.addr
%t5 = call i32 @strlen(i8* %t4)
%t6 = alloca i32
store i32 %t5, ptr %t6
%t8 = load i32, ptr %index.addr
%t10 = load i32, ptr %index.addr
%t11 = load i32, ptr %t6
%t9 = icmp slt i32 %t8, 0
br i1 %t9, label %skip118, label %rhs117
rhs117:
%t12 = icmp sge i32 %t10, %t11
br label %end119
skip118:
br label %end119
end119:
%t7 = phi i1 [ true, %skip118 ], [ %t12, %rhs117 ]
br i1 %t7, label %if120, label %end116
if120:
%t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t13
br label %end116
end116:
%t14 = load i8*, ptr %s.addr
%t15 = load i32, ptr %index.addr
%t16 = getelementptr i8, i8* %t14, i32 %t15
%t17 = load i8, i8* %t16
%t18 = call i8* @zen_char_to_string(i8 %t17)
ret i8* %t18
}
define i8* @replace (i8* %t0, i8* %t1, i8* %t2) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t3 = load i8*, ptr %s.addr
%target.addr = alloca i8*
store i8* %t1, i8** %target.addr
%t4 = load i8*, ptr %target.addr
%repl.addr = alloca i8*
store i8* %t2, i8** %repl.addr
%t5 = load i8*, ptr %repl.addr
%t6 = load i8*, ptr %s.addr
%t7 = call i32 @strlen(i8* %t6)
%t8 = alloca i32
store i32 %t7, ptr %t8
%t9 = load i8*, ptr %target.addr
%t10 = call i32 @strlen(i8* %t9)
%t11 = alloca i32
store i32 %t10, ptr %t11
%t12 = load i32, ptr %t11
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if122, label %end121
if122:
%t14 = load i8*, ptr %s.addr
ret i8* %t14
br label %end121
end121:
%t15 = alloca i32
store i32 0, ptr %t15
br label %whileCond123
whileCond123:
%t16 = load i32, ptr %t15
%t17 = load i32, ptr %t8
%t18 = load i32, ptr %t11
%t19 = sub i32 %t17, %t18
%t20 = icmp sle i32 %t16, %t19
br i1 %t20, label %whileBody124, label %whileEnd125
whileBody124:
%t21 = alloca i1
store i1 1, ptr %t21
%t22 = alloca i32
store i32 0, ptr %t22
br label %whileCond126
whileCond126:
%t23 = load i32, ptr %t22
%t24 = load i32, ptr %t11
%t25 = icmp slt i32 %t23, %t24
br i1 %t25, label %whileBody127, label %whileEnd128
whileBody127:
%t26 = load i8*, ptr %s.addr
%t27 = load i32, ptr %t15
%t28 = load i32, ptr %t22
%t29 = add i32 %t27, %t28
%t34 = load i8*, ptr %target.addr
%t35 = load i32, ptr %t22
%t30 = getelementptr i8, i8* %t26, i32 %t29
%t31 = load i8, i8* %t30
%t32 = call i8* @zen_char_to_string(i8 %t31)
%t36 = getelementptr i8, i8* %t34, i32 %t35
%t37 = load i8, i8* %t36
%t38 = call i8* @zen_char_to_string(i8 %t37)
%t41 = call i32 @strcmp(i8* %t32, i8* %t38)
%t42 = icmp ne i32 %t41, 0
br i1 %t42, label %if130, label %end129
if130:
store i1 0, ptr %t21
br label %end129
end129:
%t43 = load i32, ptr %t22
%t44 = add i32 %t43, 1
store i32 %t44, ptr %t22
br label %whileCond126
whileEnd128:
%t45 = load i1, ptr %t21
br i1 %t45, label %if132, label %end131
if132:
%t47 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t46 = alloca i8*
store i8* %t47, i8** %t46
%t48 = alloca i32
store i32 0, ptr %t48
br label %whileCond133
whileCond133:
%t49 = load i32, ptr %t48
%t50 = load i32, ptr %t15
%t51 = icmp slt i32 %t49, %t50
br i1 %t51, label %whileBody134, label %whileEnd135
whileBody134:
%t52 = load i8*, ptr %t46
%t53 = load i8*, ptr %s.addr
%t54 = load i32, ptr %t48
%t55 = getelementptr i8, i8* %t53, i32 %t54
%t56 = load i8, i8* %t55
%t57 = call i8* @zen_char_to_string(i8 %t56)
%t59 = call i8* @str_concat(i8* %t52, i8* %t57)
store i8* %t59, ptr %t46
%t60 = load i32, ptr %t48
%t61 = add i32 %t60, 1
store i32 %t61, ptr %t48
br label %whileCond133
whileEnd135:
%t62 = load i8*, ptr %t46
%t63 = load i8*, ptr %repl.addr
%t64 = call i8* @str_concat(i8* %t62, i8* %t63)
store i8* %t64, ptr %t46
%t65 = load i8*, ptr %repl.addr
%t66 = call i32 @strlen(i8* %t65)
%t67 = alloca i32
store i32 %t66, ptr %t67
%t68 = load i32, ptr %t15
%t69 = load i32, ptr %t11
%t70 = add i32 %t68, %t69
store i32 %t70, ptr %t48
br label %whileCond136
whileCond136:
%t71 = load i32, ptr %t48
%t72 = load i32, ptr %t8
%t73 = icmp slt i32 %t71, %t72
br i1 %t73, label %whileBody137, label %whileEnd138
whileBody137:
%t74 = load i8*, ptr %t46
%t75 = load i8*, ptr %s.addr
%t76 = load i32, ptr %t48
%t77 = getelementptr i8, i8* %t75, i32 %t76
%t78 = load i8, i8* %t77
%t79 = call i8* @zen_char_to_string(i8 %t78)
%t81 = call i8* @str_concat(i8* %t74, i8* %t79)
store i8* %t81, ptr %t46
%t82 = load i32, ptr %t48
%t83 = add i32 %t82, 1
store i32 %t83, ptr %t48
br label %whileCond136
whileEnd138:
%t84 = load i8*, ptr %t46
ret i8* %t84
br label %end131
end131:
%t85 = load i32, ptr %t15
%t86 = add i32 %t85, 1
store i32 %t86, ptr %t15
br label %whileCond123
whileEnd125:
%t87 = load i8*, ptr %s.addr
ret i8* %t87
}
define i8* @replaceAll (i8* %t0, i8* %t1, i8* %t2) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t3 = load i8*, ptr %s.addr
%target.addr = alloca i8*
store i8* %t1, i8** %target.addr
%t4 = load i8*, ptr %target.addr
%repl.addr = alloca i8*
store i8* %t2, i8** %repl.addr
%t5 = load i8*, ptr %repl.addr
%t6 = load i8*, ptr %s.addr
%t7 = call i32 @strlen(i8* %t6)
%t8 = alloca i32
store i32 %t7, ptr %t8
%t9 = load i8*, ptr %target.addr
%t10 = call i32 @strlen(i8* %t9)
%t11 = alloca i32
store i32 %t10, ptr %t11
%t12 = load i32, ptr %t11
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if140, label %end139
if140:
%t14 = load i8*, ptr %s.addr
ret i8* %t14
br label %end139
end139:
%t16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t15 = alloca i8*
store i8* %t16, i8** %t15
%t17 = alloca i32
store i32 0, ptr %t17
br label %whileCond141
whileCond141:
%t18 = load i32, ptr %t17
%t19 = load i32, ptr %t8
%t20 = icmp slt i32 %t18, %t19
br i1 %t20, label %whileBody142, label %whileEnd143
whileBody142:
%t21 = alloca i1
store i1 1, ptr %t21
%t22 = alloca i32
store i32 0, ptr %t22
%t23 = load i32, ptr %t17
%t24 = load i32, ptr %t8
%t25 = load i32, ptr %t11
%t26 = sub i32 %t24, %t25
%t27 = icmp sle i32 %t23, %t26
br i1 %t27, label %if145, label %else146
if145:
br label %whileCond147
whileCond147:
%t28 = load i32, ptr %t22
%t29 = load i32, ptr %t11
%t30 = icmp slt i32 %t28, %t29
br i1 %t30, label %whileBody148, label %whileEnd149
whileBody148:
%t31 = load i8*, ptr %s.addr
%t32 = load i32, ptr %t17
%t33 = load i32, ptr %t22
%t34 = add i32 %t32, %t33
%t39 = load i8*, ptr %target.addr
%t40 = load i32, ptr %t22
%t35 = getelementptr i8, i8* %t31, i32 %t34
%t36 = load i8, i8* %t35
%t37 = call i8* @zen_char_to_string(i8 %t36)
%t41 = getelementptr i8, i8* %t39, i32 %t40
%t42 = load i8, i8* %t41
%t43 = call i8* @zen_char_to_string(i8 %t42)
%t46 = call i32 @strcmp(i8* %t37, i8* %t43)
%t47 = icmp ne i32 %t46, 0
br i1 %t47, label %if151, label %end150
if151:
store i1 0, ptr %t21
br label %end150
end150:
%t48 = load i32, ptr %t22
%t49 = add i32 %t48, 1
store i32 %t49, ptr %t22
br label %whileCond147
whileEnd149:
br label %end144
else146:
store i1 0, ptr %t21
br label %end144
end144:
%t50 = load i1, ptr %t21
br i1 %t50, label %if153, label %else154
if153:
%t51 = load i8*, ptr %t15
%t52 = load i8*, ptr %repl.addr
%t53 = call i8* @str_concat(i8* %t51, i8* %t52)
store i8* %t53, ptr %t15
%t54 = load i32, ptr %t17
%t55 = load i32, ptr %t11
%t56 = add i32 %t54, %t55
store i32 %t56, ptr %t17
br label %end152
else154:
%t57 = load i8*, ptr %t15
%t58 = load i8*, ptr %s.addr
%t59 = load i32, ptr %t17
%t60 = getelementptr i8, i8* %t58, i32 %t59
%t61 = load i8, i8* %t60
%t62 = call i8* @zen_char_to_string(i8 %t61)
%t64 = call i8* @str_concat(i8* %t57, i8* %t62)
store i8* %t64, ptr %t15
%t65 = load i32, ptr %t17
%t66 = add i32 %t65, 1
store i32 %t66, ptr %t17
br label %end152
end152:
br label %whileCond141
whileEnd143:
%t67 = load i8*, ptr %t15
ret i8* %t67
}
define i1 @contains (i8* %t0, i8* %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%target.addr = alloca i8*
store i8* %t1, i8** %target.addr
%t3 = load i8*, ptr %target.addr
%t4 = load i8*, ptr %s.addr
%t5 = call i32 @strlen(i8* %t4)
%t6 = alloca i32
store i32 %t5, ptr %t6
%t7 = load i8*, ptr %target.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = alloca i32
store i32 %t8, ptr %t9
%t10 = load i32, ptr %t9
%t11 = icmp eq i32 %t10, 0
br i1 %t11, label %if156, label %end155
if156:
ret i1 1
br label %end155
end155:
%t12 = alloca i32
store i32 0, ptr %t12
br label %whileCond157
whileCond157:
%t13 = load i32, ptr %t12
%t14 = load i32, ptr %t6
%t15 = load i32, ptr %t9
%t16 = sub i32 %t14, %t15
%t17 = icmp sle i32 %t13, %t16
br i1 %t17, label %whileBody158, label %whileEnd159
whileBody158:
%t18 = alloca i1
store i1 1, ptr %t18
%t19 = alloca i32
store i32 0, ptr %t19
br label %whileCond160
whileCond160:
%t20 = load i32, ptr %t19
%t21 = load i32, ptr %t9
%t22 = icmp slt i32 %t20, %t21
br i1 %t22, label %whileBody161, label %whileEnd162
whileBody161:
%t23 = load i8*, ptr %s.addr
%t24 = load i32, ptr %t12
%t25 = load i32, ptr %t19
%t26 = add i32 %t24, %t25
%t31 = load i8*, ptr %target.addr
%t32 = load i32, ptr %t19
%t27 = getelementptr i8, i8* %t23, i32 %t26
%t28 = load i8, i8* %t27
%t29 = call i8* @zen_char_to_string(i8 %t28)
%t33 = getelementptr i8, i8* %t31, i32 %t32
%t34 = load i8, i8* %t33
%t35 = call i8* @zen_char_to_string(i8 %t34)
%t38 = call i32 @strcmp(i8* %t29, i8* %t35)
%t39 = icmp ne i32 %t38, 0
br i1 %t39, label %if164, label %end163
if164:
store i1 0, ptr %t18
br label %end163
end163:
%t40 = load i32, ptr %t19
%t41 = add i32 %t40, 1
store i32 %t41, ptr %t19
br label %whileCond160
whileEnd162:
%t42 = load i1, ptr %t18
br i1 %t42, label %if166, label %end165
if166:
ret i1 1
br label %end165
end165:
%t43 = load i32, ptr %t12
%t44 = add i32 %t43, 1
store i32 %t44, ptr %t12
br label %whileCond157
whileEnd159:
ret i1 0
}
define i8* @upperCase (i8* %t0) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t1 = load i8*, ptr %s.addr
%t2 = load i8*, ptr %s.addr
%t3 = call i32 @strlen(i8* %t2)
%t4 = alloca i32
store i32 %t3, ptr %t4
%t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t5 = alloca i8*
store i8* %t6, i8** %t5
%t7 = alloca i32
store i32 0, ptr %t7
br label %whileCond167
whileCond167:
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %t4
%t10 = icmp slt i32 %t8, %t9
br i1 %t10, label %whileBody168, label %whileEnd169
whileBody168:
%t12 = load i8*, ptr %s.addr
%t13 = load i32, ptr %t7
%t11 = alloca i8*
%t14 = getelementptr i8, i8* %t12, i32 %t13
%t15 = load i8, i8* %t14
%t16 = call i8* @zen_char_to_string(i8 %t15)
store i8* %t16, ptr %t11
%t18 = load i8*, ptr %t11
%t19 = call i32 @string_to_int_ascii(i8* %t18)
%t20 = alloca i32
store i32 %t19, ptr %t20
%t22 = load i32, ptr %t20
%t23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_1, i32 0, i32 0
%t24 = call i32 @string_to_int_ascii(i8* %t23)
%t26 = load i32, ptr %t20
%t27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_2, i32 0, i32 0
%t28 = call i32 @string_to_int_ascii(i8* %t27)
%t25 = icmp sge i32 %t22, %t24
br i1 %t25, label %rhs171, label %skip172
rhs171:
%t29 = icmp sle i32 %t26, %t28
br label %end173
skip172:
br label %end173
end173:
%t21 = phi i1 [ false, %skip172 ], [ %t29, %rhs171 ]
br i1 %t21, label %if174, label %else175
if174:
%t30 = load i8*, ptr %t5
%t31 = load i32, ptr %t20
%t32 = sub i32 %t31, 32
%t33 = call i8* @int_to_string_ascii(i32 %t32)
%t34 = call i8* @str_concat(i8* %t30, i8* %t33)
store i8* %t34, ptr %t5
br label %end170
else175:
%t35 = load i8*, ptr %t5
%t36 = load i8*, ptr %t11
%t37 = call i8* @str_concat(i8* %t35, i8* %t36)
store i8* %t37, ptr %t5
br label %end170
end170:
%t38 = load i32, ptr %t7
%t39 = add i32 %t38, 1
store i32 %t39, ptr %t7
br label %whileCond167
whileEnd169:
%t40 = load i8*, ptr %t5
ret i8* %t40
}
define i8* @lowerCase (i8* %t0) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t1 = load i8*, ptr %s.addr
%t2 = load i8*, ptr %s.addr
%t3 = call i32 @strlen(i8* %t2)
%t4 = alloca i32
store i32 %t3, ptr %t4
%t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t5 = alloca i8*
store i8* %t6, i8** %t5
%t7 = alloca i32
store i32 0, ptr %t7
br label %whileCond176
whileCond176:
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %t4
%t10 = icmp slt i32 %t8, %t9
br i1 %t10, label %whileBody177, label %whileEnd178
whileBody177:
%t12 = load i8*, ptr %s.addr
%t13 = load i32, ptr %t7
%t11 = alloca i8*
%t14 = getelementptr i8, i8* %t12, i32 %t13
%t15 = load i8, i8* %t14
%t16 = call i8* @zen_char_to_string(i8 %t15)
store i8* %t16, ptr %t11
%t18 = load i8*, ptr %t11
%t19 = call i32 @string_to_int_ascii(i8* %t18)
%t20 = alloca i32
store i32 %t19, ptr %t20
%t22 = load i32, ptr %t20
%t23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_3, i32 0, i32 0
%t24 = call i32 @string_to_int_ascii(i8* %t23)
%t26 = load i32, ptr %t20
%t27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_4, i32 0, i32 0
%t28 = call i32 @string_to_int_ascii(i8* %t27)
%t25 = icmp sge i32 %t22, %t24
br i1 %t25, label %rhs180, label %skip181
rhs180:
%t29 = icmp sle i32 %t26, %t28
br label %end182
skip181:
br label %end182
end182:
%t21 = phi i1 [ false, %skip181 ], [ %t29, %rhs180 ]
br i1 %t21, label %if183, label %else184
if183:
%t30 = load i8*, ptr %t5
%t31 = load i32, ptr %t20
%t32 = add i32 %t31, 32
%t33 = call i8* @int_to_string_ascii(i32 %t32)
%t34 = call i8* @str_concat(i8* %t30, i8* %t33)
store i8* %t34, ptr %t5
br label %end179
else184:
%t35 = load i8*, ptr %t5
%t36 = load i8*, ptr %t11
%t37 = call i8* @str_concat(i8* %t35, i8* %t36)
store i8* %t37, ptr %t5
br label %end179
end179:
%t38 = load i32, ptr %t7
%t39 = add i32 %t38, 1
store i32 %t39, ptr %t7
br label %whileCond176
whileEnd178:
%t40 = load i8*, ptr %t5
ret i8* %t40
}
define i1 @startsWith (i8* %t0, i8* %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%prefix.addr = alloca i8*
store i8* %t1, i8** %prefix.addr
%t3 = load i8*, ptr %prefix.addr
%t4 = load i8*, ptr %s.addr
%t5 = call i32 @strlen(i8* %t4)
%t6 = alloca i32
store i32 %t5, ptr %t6
%t7 = load i8*, ptr %prefix.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = alloca i32
store i32 %t8, ptr %t9
%t10 = load i32, ptr %t9
%t11 = load i32, ptr %t6
%t12 = icmp sgt i32 %t10, %t11
br i1 %t12, label %if186, label %end185
if186:
ret i1 0
br label %end185
end185:
%t13 = alloca i32
store i32 0, ptr %t13
br label %whileCond187
whileCond187:
%t14 = load i32, ptr %t13
%t15 = load i32, ptr %t9
%t16 = icmp slt i32 %t14, %t15
br i1 %t16, label %whileBody188, label %whileEnd189
whileBody188:
%t17 = load i8*, ptr %s.addr
%t18 = load i32, ptr %t13
%t23 = load i8*, ptr %prefix.addr
%t24 = load i32, ptr %t13
%t19 = getelementptr i8, i8* %t17, i32 %t18
%t20 = load i8, i8* %t19
%t21 = call i8* @zen_char_to_string(i8 %t20)
%t25 = getelementptr i8, i8* %t23, i32 %t24
%t26 = load i8, i8* %t25
%t27 = call i8* @zen_char_to_string(i8 %t26)
%t30 = call i32 @strcmp(i8* %t21, i8* %t27)
%t31 = icmp ne i32 %t30, 0
br i1 %t31, label %if191, label %end190
if191:
ret i1 0
br label %end190
end190:
%t32 = load i32, ptr %t13
%t33 = add i32 %t32, 1
store i32 %t33, ptr %t13
br label %whileCond187
whileEnd189:
ret i1 1
}
define i1 @endsWith (i8* %t0, i8* %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%suffix.addr = alloca i8*
store i8* %t1, i8** %suffix.addr
%t3 = load i8*, ptr %suffix.addr
%t4 = load i8*, ptr %s.addr
%t5 = call i32 @strlen(i8* %t4)
%t6 = alloca i32
store i32 %t5, ptr %t6
%t7 = load i8*, ptr %suffix.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = alloca i32
store i32 %t8, ptr %t9
%t10 = load i32, ptr %t9
%t11 = load i32, ptr %t6
%t12 = icmp sgt i32 %t10, %t11
br i1 %t12, label %if193, label %end192
if193:
ret i1 0
br label %end192
end192:
%t13 = alloca i32
store i32 0, ptr %t13
br label %whileCond194
whileCond194:
%t14 = load i32, ptr %t13
%t15 = load i32, ptr %t9
%t16 = icmp slt i32 %t14, %t15
br i1 %t16, label %whileBody195, label %whileEnd196
whileBody195:
%t17 = load i8*, ptr %s.addr
%t18 = load i32, ptr %t6
%t19 = load i32, ptr %t9
%t21 = load i32, ptr %t13
%t20 = sub i32 %t18, %t19
%t22 = add i32 %t20, %t21
%t27 = load i8*, ptr %suffix.addr
%t28 = load i32, ptr %t13
%t23 = getelementptr i8, i8* %t17, i32 %t22
%t24 = load i8, i8* %t23
%t25 = call i8* @zen_char_to_string(i8 %t24)
%t29 = getelementptr i8, i8* %t27, i32 %t28
%t30 = load i8, i8* %t29
%t31 = call i8* @zen_char_to_string(i8 %t30)
%t34 = call i32 @strcmp(i8* %t25, i8* %t31)
%t35 = icmp ne i32 %t34, 0
br i1 %t35, label %if198, label %end197
if198:
ret i1 0
br label %end197
end197:
%t36 = load i32, ptr %t13
%t37 = add i32 %t36, 1
store i32 %t37, ptr %t13
br label %whileCond194
whileEnd196:
ret i1 1
}
define i8* @trim (i8* %t0) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t1 = load i8*, ptr %s.addr
%t2 = load i8*, ptr %s.addr
%t3 = call i32 @strlen(i8* %t2)
%t4 = alloca i32
store i32 %t3, ptr %t4
%t5 = alloca i32
store i32 0, ptr %t5
%t7 = load i32, ptr %t4
%t6 = alloca i32
%t8 = sub i32 %t7, 1
store i32 %t8, ptr %t6
br label %whileCond199
whileCond199:
%t9 = load i32, ptr %t5
%t10 = load i32, ptr %t4
%t11 = icmp slt i32 %t9, %t10
br i1 %t11, label %whileBody200, label %whileEnd201
whileBody200:
%t13 = load i8*, ptr %s.addr
%t14 = load i32, ptr %t5
%t12 = alloca i8*
%t15 = getelementptr i8, i8* %t13, i32 %t14
%t16 = load i8, i8* %t15
%t17 = call i8* @zen_char_to_string(i8 %t16)
store i8* %t17, ptr %t12
%t21 = load i8*, ptr %t12
%t22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_5, i32 0, i32 0
%t26 = load i8*, ptr %t12
%t27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_6, i32 0, i32 0
%t31 = load i8*, ptr %t12
%t32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_7, i32 0, i32 0
%t24 = call i32 @strcmp(i8* %t21, i8* %t22)
%t25 = icmp eq i32 %t24, 0
br i1 %t25, label %skip207, label %rhs206
rhs206:
%t29 = call i32 @strcmp(i8* %t26, i8* %t27)
%t30 = icmp eq i32 %t29, 0
br label %end208
skip207:
br label %end208
end208:
%t20 = phi i1 [ true, %skip207 ], [ %t30, %rhs206 ]
br i1 %t20, label %skip204, label %rhs203
rhs203:
%t34 = call i32 @strcmp(i8* %t31, i8* %t32)
%t35 = icmp eq i32 %t34, 0
br label %end205
skip204:
br label %end205
end205:
%t19 = phi i1 [ true, %skip204 ], [ %t35, %rhs203 ]
br i1 %t19, label %if209, label %else210
if209:
%t36 = load i32, ptr %t5
%t37 = add i32 %t36, 1
store i32 %t37, ptr %t5
br label %end202
else210:
br label %whileEnd201
br label %end202
end202:
br label %whileCond199
whileEnd201:
br label %whileCond211
whileCond211:
%t38 = load i32, ptr %t6
%t39 = load i32, ptr %t5
%t40 = icmp sge i32 %t38, %t39
br i1 %t40, label %whileBody212, label %whileEnd213
whileBody212:
%t42 = load i8*, ptr %s.addr
%t43 = load i32, ptr %t6
%t41 = alloca i8*
%t44 = getelementptr i8, i8* %t42, i32 %t43
%t45 = load i8, i8* %t44
%t46 = call i8* @zen_char_to_string(i8 %t45)
store i8* %t46, ptr %t41
%t50 = load i8*, ptr %t41
%t51 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_5, i32 0, i32 0
%t55 = load i8*, ptr %t41
%t56 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_6, i32 0, i32 0
%t60 = load i8*, ptr %t41
%t61 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_7, i32 0, i32 0
%t53 = call i32 @strcmp(i8* %t50, i8* %t51)
%t54 = icmp eq i32 %t53, 0
br i1 %t54, label %skip219, label %rhs218
rhs218:
%t58 = call i32 @strcmp(i8* %t55, i8* %t56)
%t59 = icmp eq i32 %t58, 0
br label %end220
skip219:
br label %end220
end220:
%t49 = phi i1 [ true, %skip219 ], [ %t59, %rhs218 ]
br i1 %t49, label %skip216, label %rhs215
rhs215:
%t63 = call i32 @strcmp(i8* %t60, i8* %t61)
%t64 = icmp eq i32 %t63, 0
br label %end217
skip216:
br label %end217
end217:
%t48 = phi i1 [ true, %skip216 ], [ %t64, %rhs215 ]
br i1 %t48, label %if221, label %else222
if221:
%t65 = load i32, ptr %t6
%t66 = sub i32 %t65, 1
store i32 %t66, ptr %t6
br label %end214
else222:
br label %whileEnd213
br label %end214
end214:
br label %whileCond211
whileEnd213:
%t68 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t67 = alloca i8*
store i8* %t68, i8** %t67
%t70 = load i32, ptr %t5
%t69 = alloca i32
store i32 %t70, ptr %t69
br label %whileCond223
whileCond223:
%t71 = load i32, ptr %t69
%t72 = load i32, ptr %t6
%t73 = icmp sle i32 %t71, %t72
br i1 %t73, label %whileBody224, label %whileEnd225
whileBody224:
%t74 = load i8*, ptr %t67
%t75 = load i8*, ptr %s.addr
%t76 = load i32, ptr %t69
%t77 = getelementptr i8, i8* %t75, i32 %t76
%t78 = load i8, i8* %t77
%t79 = call i8* @zen_char_to_string(i8 %t78)
%t81 = call i8* @str_concat(i8* %t74, i8* %t79)
store i8* %t81, ptr %t67
%t82 = load i32, ptr %t69
%t83 = add i32 %t82, 1
store i32 %t83, ptr %t69
br label %whileCond223
whileEnd225:
%t84 = load i8*, ptr %t67
ret i8* %t84
}
define i8* @splitAt (i8* %t0, i8* %t1, i32 %t2) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t3 = load i8*, ptr %s.addr
%delim.addr = alloca i8*
store i8* %t1, i8** %delim.addr
%t4 = load i8*, ptr %delim.addr
%target.addr = alloca i32
store i32 %t2, i32* %target.addr
%t5 = load i32, ptr %target.addr
%t6 = load i8*, ptr %s.addr
%t7 = call i32 @strlen(i8* %t6)
%t8 = alloca i32
store i32 %t7, ptr %t8
%t9 = load i8*, ptr %delim.addr
%t10 = call i32 @strlen(i8* %t9)
%t11 = alloca i32
store i32 %t10, ptr %t11
%t12 = load i32, ptr %t11
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if227, label %end226
if227:
%t14 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t14
br label %end226
end226:
%t15 = alloca i32
store i32 0, ptr %t15
%t16 = alloca i32
store i32 0, ptr %t16
%t18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t17 = alloca i8*
store i8* %t18, i8** %t17
br label %whileCond228
whileCond228:
%t19 = load i32, ptr %t15
%t20 = load i32, ptr %t8
%t21 = icmp slt i32 %t19, %t20
br i1 %t21, label %whileBody229, label %whileEnd230
whileBody229:
%t22 = alloca i1
store i1 1, ptr %t22
%t23 = alloca i32
store i32 0, ptr %t23
%t24 = load i32, ptr %t15
%t25 = load i32, ptr %t8
%t26 = load i32, ptr %t11
%t27 = sub i32 %t25, %t26
%t28 = icmp sle i32 %t24, %t27
br i1 %t28, label %if232, label %else233
if232:
br label %whileCond234
whileCond234:
%t29 = load i32, ptr %t23
%t30 = load i32, ptr %t11
%t31 = icmp slt i32 %t29, %t30
br i1 %t31, label %whileBody235, label %whileEnd236
whileBody235:
%t32 = load i8*, ptr %s.addr
%t33 = load i32, ptr %t15
%t34 = load i32, ptr %t23
%t35 = add i32 %t33, %t34
%t40 = load i8*, ptr %delim.addr
%t41 = load i32, ptr %t23
%t36 = getelementptr i8, i8* %t32, i32 %t35
%t37 = load i8, i8* %t36
%t38 = call i8* @zen_char_to_string(i8 %t37)
%t42 = getelementptr i8, i8* %t40, i32 %t41
%t43 = load i8, i8* %t42
%t44 = call i8* @zen_char_to_string(i8 %t43)
%t47 = call i32 @strcmp(i8* %t38, i8* %t44)
%t48 = icmp ne i32 %t47, 0
br i1 %t48, label %if238, label %end237
if238:
store i1 0, ptr %t22
br label %end237
end237:
%t49 = load i32, ptr %t23
%t50 = add i32 %t49, 1
store i32 %t50, ptr %t23
br label %whileCond234
whileEnd236:
br label %end231
else233:
store i1 0, ptr %t22
br label %end231
end231:
%t51 = load i1, ptr %t22
br i1 %t51, label %if240, label %else241
if240:
%t52 = load i32, ptr %t16
%t53 = load i32, ptr %target.addr
%t54 = icmp eq i32 %t52, %t53
br i1 %t54, label %if243, label %end242
if243:
%t55 = load i8*, ptr %t17
ret i8* %t55
br label %end242
end242:
%t56 = load i32, ptr %t16
%t57 = add i32 %t56, 1
store i32 %t57, ptr %t16
%t58 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
store i8* %t58, ptr %t17
%t59 = load i32, ptr %t15
%t60 = load i32, ptr %t11
%t61 = add i32 %t59, %t60
store i32 %t61, ptr %t15
br label %end239
else241:
%t62 = load i8*, ptr %t17
%t63 = load i8*, ptr %s.addr
%t64 = load i32, ptr %t15
%t65 = getelementptr i8, i8* %t63, i32 %t64
%t66 = load i8, i8* %t65
%t67 = call i8* @zen_char_to_string(i8 %t66)
%t69 = call i8* @str_concat(i8* %t62, i8* %t67)
store i8* %t69, ptr %t17
%t70 = load i32, ptr %t15
%t71 = add i32 %t70, 1
store i32 %t71, ptr %t15
br label %end239
end239:
br label %whileCond228
whileEnd230:
%t72 = load i32, ptr %t16
%t73 = load i32, ptr %target.addr
%t74 = icmp eq i32 %t72, %t73
br i1 %t74, label %if245, label %end244
if245:
%t75 = load i8*, ptr %t17
ret i8* %t75
br label %end244
end244:
%t76 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t76
}
define i8* @repeat (i8* %t0, i32 %t1) {
entry:
%a.addr = alloca i8*
store i8* %t0, i8** %a.addr
%t2 = load i8*, ptr %a.addr
%count.addr = alloca i32
store i32 %t1, i32* %count.addr
%t3 = load i32, ptr %count.addr
%t4 = load i32, ptr %count.addr
%t5 = icmp sle i32 %t4, 0
br i1 %t5, label %if247, label %end246
if247:
%t6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t6
br label %end246
end246:
%t7 = load i8*, ptr %a.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = icmp eq i32 %t8, 0
br i1 %t9, label %if249, label %end248
if249:
%t10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t10
br label %end248
end248:
%t12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t11 = alloca i8*
store i8* %t12, i8** %t11
br label %whileCond250
whileCond250:
%t13 = load i32, ptr %count.addr
%t14 = icmp slt i32 0, %t13
br i1 %t14, label %whileBody251, label %whileEnd252
whileBody251:
%t15 = load i8*, ptr %t11
%t16 = load i8*, ptr %a.addr
%t17 = call i8* @str_concat(i8* %t15, i8* %t16)
store i8* %t17, ptr %t11
%t18 = load i32, ptr %count.addr
%t19 = sub i32 %t18, 1
store i32 %t19, i32* %count.addr
br label %whileCond250
whileEnd252:
%t20 = load i8*, ptr %t11
ret i8* %t20
}
define i32 @count (i8* %t0, i8* %t1) {
entry:
%text.addr = alloca i8*
store i8* %t0, i8** %text.addr
%t2 = load i8*, ptr %text.addr
%search.addr = alloca i8*
store i8* %t1, i8** %search.addr
%t3 = load i8*, ptr %search.addr
%t4 = load i8*, ptr %text.addr
%t5 = call i32 @strlen(i8* %t4)
%t6 = icmp eq i32 %t5, 0
br i1 %t6, label %if254, label %end253
if254:
ret i32 0
br label %end253
end253:
%t7 = load i8*, ptr %search.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = icmp eq i32 %t8, 0
br i1 %t9, label %if256, label %end255
if256:
ret i32 0
br label %end255
end255:
%t10 = alloca i32
store i32 0, ptr %t10
%t11 = alloca i32
store i32 0, ptr %t11
br label %whileCond257
whileCond257:
%t12 = load i32, ptr %t11
%t13 = load i8*, ptr %text.addr
%t14 = call i32 @strlen(i8* %t13)
%t15 = icmp slt i32 %t12, %t14
br i1 %t15, label %whileBody258, label %whileEnd259
whileBody258:
%t16 = load i8*, ptr %text.addr
%t17 = load i32, ptr %t11
%t19 = load i8*, ptr %search.addr
%t18 = call i8* @charAt(i8* %t16, i32 %t17)
%t21 = call i32 @strcmp(i8* %t18, i8* %t19)
%t22 = icmp eq i32 %t21, 0
br i1 %t22, label %if261, label %end260
if261:
%t23 = load i32, ptr %t10
%t24 = add i32 %t23, 1
store i32 %t24, i32* %t10
br label %end260
end260:
%t25 = load i32, ptr %t11
%t26 = add i32 %t25, 1
store i32 %t26, i32* %t11
br label %whileCond257
whileEnd259:
%t27 = load i32, ptr %t10
ret i32 %t27
}
define i8* @padStart (i8* %t0, i32 %t1, i8* %t2) {
entry:
%text.addr = alloca i8*
store i8* %t0, i8** %text.addr
%t3 = load i8*, ptr %text.addr
%targetLength.addr = alloca i32
store i32 %t1, i32* %targetLength.addr
%t4 = load i32, ptr %targetLength.addr
%pad.addr = alloca i8*
store i8* %t2, i8** %pad.addr
%t5 = load i8*, ptr %pad.addr
%t6 = load i32, ptr %targetLength.addr
%t7 = load i8*, ptr %text.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = icmp sle i32 %t6, %t8
br i1 %t9, label %if263, label %end262
if263:
%t10 = load i8*, ptr %text.addr
ret i8* %t10
br label %end262
end262:
%t11 = load i8*, ptr %pad.addr
%t12 = call i32 @strlen(i8* %t11)
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if265, label %end264
if265:
%t14 = load i8*, ptr %text.addr
ret i8* %t14
br label %end264
end264:
%t16 = load i32, ptr %targetLength.addr
%t17 = load i8*, ptr %text.addr
%t18 = call i32 @strlen(i8* %t17)
%t15 = alloca i32
%t19 = sub i32 %t16, %t18
store i32 %t19, ptr %t15
%t21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t20 = alloca i8*
store i8* %t21, i8** %t20
br label %whileCond266
whileCond266:
%t22 = load i32, ptr %t15
%t23 = icmp slt i32 0, %t22
br i1 %t23, label %whileBody267, label %whileEnd268
whileBody267:
%t24 = load i8*, ptr %t20
%t25 = load i8*, ptr %pad.addr
%t26 = call i8* @str_concat(i8* %t24, i8* %t25)
store i8* %t26, ptr %t20
%t27 = load i32, ptr %t15
%t28 = sub i32 %t27, 1
store i32 %t28, i32* %t15
br label %whileCond266
whileEnd268:
%t29 = load i8*, ptr %t20
%t30 = load i8*, ptr %text.addr
%t31 = call i8* @str_concat(i8* %t29, i8* %t30)
ret i8* %t31
}
define i8* @padEnd (i8* %t0, i32 %t1, i8* %t2) {
entry:
%text.addr = alloca i8*
store i8* %t0, i8** %text.addr
%t3 = load i8*, ptr %text.addr
%targetLength.addr = alloca i32
store i32 %t1, i32* %targetLength.addr
%t4 = load i32, ptr %targetLength.addr
%pad.addr = alloca i8*
store i8* %t2, i8** %pad.addr
%t5 = load i8*, ptr %pad.addr
%t6 = load i32, ptr %targetLength.addr
%t7 = load i8*, ptr %text.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = icmp sle i32 %t6, %t8
br i1 %t9, label %if270, label %end269
if270:
%t10 = load i8*, ptr %text.addr
ret i8* %t10
br label %end269
end269:
%t11 = load i8*, ptr %pad.addr
%t12 = call i32 @strlen(i8* %t11)
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if272, label %end271
if272:
%t14 = load i8*, ptr %text.addr
ret i8* %t14
br label %end271
end271:
%t16 = load i32, ptr %targetLength.addr
%t17 = load i8*, ptr %text.addr
%t18 = call i32 @strlen(i8* %t17)
%t15 = alloca i32
%t19 = sub i32 %t16, %t18
store i32 %t19, ptr %t15
%t21 = load i8*, ptr %text.addr
%t20 = alloca i8*
store i8* %t21, i8** %t20
br label %whileCond273
whileCond273:
%t22 = load i32, ptr %t15
%t23 = icmp slt i32 0, %t22
br i1 %t23, label %whileBody274, label %whileEnd275
whileBody274:
%t24 = load i8*, ptr %t20
%t25 = load i8*, ptr %pad.addr
%t26 = call i8* @str_concat(i8* %t24, i8* %t25)
store i8* %t26, ptr %t20
%t27 = load i32, ptr %t15
%t28 = sub i32 %t27, 1
store i32 %t28, i32* %t15
br label %whileCond273
whileEnd275:
%t29 = load i8*, ptr %t20
ret i8* %t29
}
define i8* @padCenter (i8* %t0, i32 %t1, i8* %t2) {
entry:
%text.addr = alloca i8*
store i8* %t0, i8** %text.addr
%t3 = load i8*, ptr %text.addr
%targetLength.addr = alloca i32
store i32 %t1, i32* %targetLength.addr
%t4 = load i32, ptr %targetLength.addr
%pad.addr = alloca i8*
store i8* %t2, i8** %pad.addr
%t5 = load i8*, ptr %pad.addr
%t6 = load i32, ptr %targetLength.addr
%t7 = load i8*, ptr %text.addr
%t8 = call i32 @strlen(i8* %t7)
%t9 = icmp sle i32 %t6, %t8
br i1 %t9, label %if277, label %end276
if277:
%t10 = load i8*, ptr %text.addr
ret i8* %t10
br label %end276
end276:
%t11 = load i8*, ptr %pad.addr
%t12 = call i32 @strlen(i8* %t11)
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if279, label %end278
if279:
%t14 = load i8*, ptr %text.addr
ret i8* %t14
br label %end278
end278:
%t16 = load i32, ptr %targetLength.addr
%t17 = load i8*, ptr %text.addr
%t18 = call i32 @strlen(i8* %t17)
%t15 = alloca i32
%t19 = sub i32 %t16, %t18
store i32 %t19, ptr %t15
%t21 = load i32, ptr %t15
%t20 = alloca i32
%t22 = sdiv i32 %t21, 2
store i32 %t22, ptr %t20
%t24 = load i32, ptr %t15
%t25 = load i32, ptr %t20
%t23 = alloca i32
%t26 = sub i32 %t24, %t25
store i32 %t26, ptr %t23
%t28 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t27 = alloca i8*
store i8* %t28, i8** %t27
%t30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t29 = alloca i8*
store i8* %t30, i8** %t29
br label %whileCond280
whileCond280:
%t31 = load i32, ptr %t20
%t32 = icmp slt i32 0, %t31
br i1 %t32, label %whileBody281, label %whileEnd282
whileBody281:
%t33 = load i8*, ptr %t27
%t34 = load i8*, ptr %pad.addr
%t35 = call i8* @str_concat(i8* %t33, i8* %t34)
store i8* %t35, ptr %t27
%t36 = load i32, ptr %t20
%t37 = sub i32 %t36, 1
store i32 %t37, i32* %t20
br label %whileCond280
whileEnd282:
br label %whileCond283
whileCond283:
%t38 = load i32, ptr %t23
%t39 = icmp slt i32 0, %t38
br i1 %t39, label %whileBody284, label %whileEnd285
whileBody284:
%t40 = load i8*, ptr %t29
%t41 = load i8*, ptr %pad.addr
%t42 = call i8* @str_concat(i8* %t40, i8* %t41)
store i8* %t42, ptr %t29
%t43 = load i32, ptr %t23
%t44 = sub i32 %t43, 1
store i32 %t44, i32* %t23
br label %whileCond283
whileEnd285:
%t45 = load i8*, ptr %t27
%t46 = load i8*, ptr %text.addr
%t48 = load i8*, ptr %t29
%t47 = call i8* @str_concat(i8* %t45, i8* %t46)
%t49 = call i8* @str_concat(i8* %t47, i8* %t48)
ret i8* %t49
}
define i8* @capitalize (i8* %t0) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t1 = load i8*, ptr %s.addr
%t2 = load i8*, ptr %s.addr
%t3 = call i32 @strlen(i8* %t2)
%t4 = icmp eq i32 %t3, 0
br i1 %t4, label %if287, label %end286
if287:
%t5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t5
br label %end286
end286:
%t7 = load i8*, ptr %s.addr
%t6 = alloca i8*
%t8 = getelementptr i8, i8* %t7, i32 0
%t9 = load i8, i8* %t8
%t10 = call i8* @zen_char_to_string(i8 %t9)
store i8* %t10, ptr %t6
%t12 = load i8*, ptr %t6
%t13 = call i32 @string_to_int_ascii(i8* %t12)
%t14 = alloca i32
store i32 %t13, ptr %t14
%t16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t15 = alloca i8*
store i8* %t16, i8** %t15
%t18 = load i32, ptr %t14
%t19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_1, i32 0, i32 0
%t20 = call i32 @string_to_int_ascii(i8* %t19)
%t22 = load i32, ptr %t14
%t23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_2, i32 0, i32 0
%t24 = call i32 @string_to_int_ascii(i8* %t23)
%t21 = icmp sge i32 %t18, %t20
br i1 %t21, label %rhs289, label %skip290
rhs289:
%t25 = icmp sle i32 %t22, %t24
br label %end291
skip290:
br label %end291
end291:
%t17 = phi i1 [ false, %skip290 ], [ %t25, %rhs289 ]
br i1 %t17, label %if292, label %else293
if292:
%t26 = load i8*, ptr %t15
%t27 = load i32, ptr %t14
%t28 = sub i32 %t27, 32
%t29 = call i8* @int_to_string_ascii(i32 %t28)
%t30 = call i8* @str_concat(i8* %t26, i8* %t29)
store i8* %t30, ptr %t15
br label %end288
else293:
%t31 = load i8*, ptr %t15
%t32 = load i8*, ptr %t6
%t33 = call i8* @str_concat(i8* %t31, i8* %t32)
store i8* %t33, ptr %t15
br label %end288
end288:
%t34 = alloca i32
store i32 1, ptr %t34
%t35 = load i8*, ptr %s.addr
%t36 = call i32 @strlen(i8* %t35)
%t37 = alloca i32
store i32 %t36, ptr %t37
br label %whileCond294
whileCond294:
%t38 = load i32, ptr %t34
%t39 = load i32, ptr %t37
%t40 = icmp slt i32 %t38, %t39
br i1 %t40, label %whileBody295, label %whileEnd296
whileBody295:
%t41 = load i8*, ptr %t15
%t42 = load i8*, ptr %s.addr
%t43 = load i32, ptr %t34
%t44 = getelementptr i8, i8* %t42, i32 %t43
%t45 = load i8, i8* %t44
%t46 = call i8* @zen_char_to_string(i8 %t45)
%t48 = call i8* @str_concat(i8* %t41, i8* %t46)
store i8* %t48, ptr %t15
%t49 = load i32, ptr %t34
%t50 = add i32 %t49, 1
store i32 %t50, ptr %t34
br label %whileCond294
whileEnd296:
%t51 = load i8*, ptr %t15
ret i8* %t51
}
define i8* @extName (i8* %t0) {
entry:
%path.addr = alloca i8*
store i8* %t0, i8** %path.addr
%t1 = load i8*, ptr %path.addr
%t2 = load i8*, ptr %path.addr
%t3 = call i32 @strlen(i8* %t2)
%t4 = alloca i32
store i32 %t3, ptr %t4
%t6 = load i32, ptr %t4
%t5 = alloca i32
%t7 = sub i32 %t6, 1
store i32 %t7, ptr %t5
br label %whileCond297
whileCond297:
%t8 = load i32, ptr %t5
%t9 = icmp sge i32 %t8, 0
br i1 %t9, label %whileBody298, label %whileEnd299
whileBody298:
%t10 = load i8*, ptr %path.addr
%t11 = load i32, ptr %t5
%t16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_8, i32 0, i32 0
%t12 = getelementptr i8, i8* %t10, i32 %t11
%t13 = load i8, i8* %t12
%t14 = call i8* @zen_char_to_string(i8 %t13)
%t18 = call i32 @strcmp(i8* %t14, i8* %t16)
%t19 = icmp eq i32 %t18, 0
br i1 %t19, label %if301, label %end300
if301:
%t21 = load i32, ptr %t5
%t20 = alloca i32
%t22 = add i32 %t21, 1
store i32 %t22, ptr %t20
%t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t23 = alloca i8*
store i8* %t24, i8** %t23
br label %whileCond302
whileCond302:
%t25 = load i32, ptr %t20
%t26 = load i32, ptr %t4
%t27 = icmp slt i32 %t25, %t26
br i1 %t27, label %whileBody303, label %whileEnd304
whileBody303:
%t28 = load i8*, ptr %t23
%t29 = load i8*, ptr %path.addr
%t30 = load i32, ptr %t20
%t31 = getelementptr i8, i8* %t29, i32 %t30
%t32 = load i8, i8* %t31
%t33 = call i8* @zen_char_to_string(i8 %t32)
%t35 = call i8* @str_concat(i8* %t28, i8* %t33)
store i8* %t35, ptr %t23
%t36 = load i32, ptr %t20
%t37 = add i32 %t36, 1
store i32 %t37, ptr %t20
br label %whileCond302
whileEnd304:
%t38 = load i8*, ptr %t23
ret i8* %t38
br label %end300
end300:
%t39 = load i32, ptr %t5
%t40 = sub i32 %t39, 1
store i32 %t40, ptr %t5
br label %whileCond297
whileEnd299:
%t41 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
ret i8* %t41
}
define double @sin (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
br label %whileCond305
whileCond305:
%t2 = load double, ptr %x.addr
%t3 = load double, ptr @PI
%t4 = fcmp ogt double %t2, %t3
br i1 %t4, label %whileBody306, label %whileEnd307
whileBody306:
%t5 = load double, ptr %x.addr
%t6 = load double, ptr @TAU
%t7 = fsub double %t5, %t6
store double %t7, ptr %x.addr
br label %whileCond305
whileEnd307:
br label %whileCond308
whileCond308:
%t8 = load double, ptr %x.addr
%t9 = load double, ptr @PI
%t11 = fsub double 0.0, %t9
%t12 = fcmp olt double %t8, %t11
br i1 %t12, label %whileBody309, label %whileEnd310
whileBody309:
%t13 = load double, ptr %x.addr
%t14 = load double, ptr @TAU
%t15 = fadd double %t13, %t14
store double %t15, ptr %x.addr
br label %whileCond308
whileEnd310:
%t16 = load double, ptr %x.addr
%t17 = load double, ptr %x.addr
%t18 = load double, ptr %x.addr
%t20 = load double, ptr %x.addr
%t19 = fmul double %t17, %t18
%t21 = fmul double %t19, %t20
%t22 = fdiv double %t21, 6.0
%t23 = fsub double %t16, %t22
ret double %t23
}
define double @cos (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
br label %whileCond311
whileCond311:
%t2 = load double, ptr %x.addr
%t3 = load double, ptr @PI
%t4 = fcmp ogt double %t2, %t3
br i1 %t4, label %whileBody312, label %whileEnd313
whileBody312:
%t5 = load double, ptr %x.addr
%t6 = load double, ptr @TAU
%t7 = fsub double %t5, %t6
store double %t7, ptr %x.addr
br label %whileCond311
whileEnd313:
br label %whileCond314
whileCond314:
%t8 = load double, ptr %x.addr
%t9 = load double, ptr @PI
%t11 = fsub double 0.0, %t9
%t12 = fcmp olt double %t8, %t11
br i1 %t12, label %whileBody315, label %whileEnd316
whileBody315:
%t13 = load double, ptr %x.addr
%t14 = load double, ptr @TAU
%t15 = fadd double %t13, %t14
store double %t15, ptr %x.addr
br label %whileCond314
whileEnd316:
%t16 = load double, ptr %x.addr
%t17 = load double, ptr %x.addr
%t18 = fmul double %t16, %t17
%t19 = fdiv double %t18, 2.0
%t20 = fsub double 1.0, %t19
ret double %t20
}
define double @tan (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
%t2 = load double, ptr %x.addr
%t3 = call double @sin(double %t2)
%t4 = alloca double
store double %t3, ptr %t4
%t5 = load double, ptr %x.addr
%t6 = call double @cos(double %t5)
%t7 = alloca double
store double %t6, ptr %t7
%t8 = load double, ptr %t4
%t9 = load double, ptr %t7
%t10 = fdiv double %t8, %t9
ret double %t10
}
define double @log (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
%t3 = load double, ptr %x.addr
%t2 = alloca double
store double %t3, ptr %t2
%t4 = alloca i32
store i32 0, ptr %t4
br label %whileCond317
whileCond317:
%t5 = load i32, ptr %t4
%t6 = icmp slt i32 %t5, 10
br i1 %t6, label %whileBody318, label %whileEnd319
whileBody318:
%t7 = load double, ptr %t2
%t9 = load double, ptr %x.addr
%t10 = load double, ptr %t2
%t8 = fsub double %t7, 1.0
%t11 = fdiv double %t9, %t10
%t12 = fadd double %t8, %t11
store double %t12, ptr %t2
%t13 = load i32, ptr %t4
%t14 = add i32 %t13, 1
store i32 %t14, ptr %t4
br label %whileCond317
whileEnd319:
%t15 = load double, ptr %t2
ret double %t15
}
define double @exp (double %t0) {
entry:
%x.addr = alloca double
store double %t0, double* %x.addr
%t1 = load double, ptr %x.addr
%t2 = alloca double
store double 1.0, ptr %t2
%t3 = alloca double
store double 1.0, ptr %t3
%t4 = alloca i32
store i32 1, ptr %t4
br label %whileCond320
whileCond320:
%t5 = load i32, ptr %t4
%t6 = icmp slt i32 %t5, 10
br i1 %t6, label %whileBody321, label %whileEnd322
whileBody321:
%t7 = load double, ptr %t3
%t8 = load double, ptr %x.addr
%t10 = load i32, ptr %t4
%t9 = fmul double %t7, %t8
%t11 = sitofp i32 %t10 to double
%t12 = fdiv double %t9, %t11
store double %t12, ptr %t3
%t13 = load double, ptr %t2
%t14 = load double, ptr %t3
%t15 = fadd double %t13, %t14
store double %t15, ptr %t2
%t16 = load i32, ptr %t4
%t17 = add i32 %t16, 1
store i32 %t17, ptr %t4
br label %whileCond320
whileEnd322:
%t18 = load double, ptr %t2
ret double %t18
}
define i32 @randomInt (i32 %t0, i32 %t1) {
entry:
%a.addr = alloca i32
store i32 %t0, i32* %a.addr
%t2 = load i32, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, i32* %b.addr
%t3 = load i32, ptr %b.addr
%t4 = call double @random()
%t5 = alloca double
store double %t4, ptr %t5
%t6 = load i32, ptr %a.addr
%t7 = load double, ptr %t5
%t8 = load i32, ptr %b.addr
%t9 = load i32, ptr %a.addr
%t10 = sub i32 %t8, %t9
%t11 = add i32 %t10, 1
%t12 = sitofp i32 %t11 to double
%t13 = fmul double %t7, %t12
%t14 = fptosi double %t13 to i32
%t15 = add i32 %t6, %t14
ret i32 %t15
}
define double @random () {
entry:

%t0 = load i32, ptr @SEED
%t3 = load i32, ptr @I32_MAX
%t1 = mul i32 %t0, 1103515245
%t2 = add i32 %t1, 12345
%t4 = srem i32 %t2, %t3
store i32 %t4, ptr @SEED
%t5 = load i32, ptr @SEED
%t6 = icmp slt i32 %t5, 0
br i1 %t6, label %if324, label %end323
if324:
%t7 = load i32, ptr @SEED
%t8 = load i32, ptr @I32_MAX
%t9 = add i32 %t7, %t8
store i32 %t9, ptr @SEED
br label %end323
end323:
%t10 = load i32, ptr @SEED
%t11 = sitofp i32 %t10 to double
%t12 = fdiv double %t11, 2147483647.0
ret double %t12
}
define i1 @match (i8* %t0, i8* %t1) {
entry:
%text.addr = alloca i8*
store i8* %t0, i8** %text.addr
%t2 = load i8*, ptr %text.addr
%pattern.addr = alloca i8*
store i8* %t1, i8** %pattern.addr
%t3 = load i8*, ptr %pattern.addr
%t4 = load i8*, ptr %pattern.addr
%t5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_9, i32 0, i32 0
%t6 = call i1 @contains(i8* %t4, i8* %t5)
br i1 %t6, label %if326, label %end325
if326:
%t8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t7 = alloca i8*
store i8* %t8, i8** %t7
%t9 = alloca i32
store i32 0, ptr %t9
br label %whileCond327
whileCond327:
%t10 = load i32, ptr %t9
%t11 = load i8*, ptr %pattern.addr
%t12 = call i32 @strlen(i8* %t11)
%t13 = icmp slt i32 %t10, %t12
br i1 %t13, label %whileBody328, label %whileEnd329
whileBody328:
%t14 = load i8*, ptr %pattern.addr
%t15 = load i32, ptr %t9
%t16 = call i8* @charAt(i8* %t14, i32 %t15)
%t17 = alloca i8*
store i8* %t16, ptr %t17
%t18 = load i8*, ptr %t17
%t19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_9, i32 0, i32 0
%t21 = call i32 @strcmp(i8* %t18, i8* %t19)
%t22 = icmp eq i32 %t21, 0
br i1 %t22, label %if331, label %else332
if331:
%t23 = load i8*, ptr %text.addr
%t24 = load i8*, ptr %t7
%t25 = call i1 @match(i8* %t23, i8* %t24)
br i1 %t25, label %if334, label %end333
if334:
ret i1 1
br label %end333
end333:
%t26 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
store i8* %t26, ptr %t7
br label %end330
else332:
%t27 = load i8*, ptr %t7
%t28 = load i8*, ptr %t17
%t29 = call i8* @str_concat(i8* %t27, i8* %t28)
store i8* %t29, ptr %t7
br label %end330
end330:
%t30 = load i32, ptr %t9
%t31 = add i32 %t30, 1
store i32 %t31, ptr %t9
br label %whileCond327
whileEnd329:
%t32 = load i8*, ptr %text.addr
%t33 = load i8*, ptr %t7
%t34 = call i1 @match(i8* %t32, i8* %t33)
ret i1 %t34
br label %end325
end325:
%t35 = alloca i32
store i32 0, ptr %t35
%t36 = alloca i32
store i32 0, ptr %t36
br label %whileCond335
whileCond335:
%t37 = load i32, ptr %t36
%t38 = load i8*, ptr %pattern.addr
%t39 = call i32 @strlen(i8* %t38)
%t40 = icmp slt i32 %t37, %t39
br i1 %t40, label %whileBody336, label %whileEnd337
whileBody336:
%t41 = load i8*, ptr %pattern.addr
%t42 = load i32, ptr %t36
%t43 = call i8* @charAt(i8* %t41, i32 %t42)
%t44 = alloca i8*
store i8* %t43, ptr %t44
%t45 = load i8*, ptr %t44
%t46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_10, i32 0, i32 0
%t48 = call i32 @strcmp(i8* %t45, i8* %t46)
%t49 = icmp eq i32 %t48, 0
br i1 %t49, label %if339, label %end338
if339:
%t50 = load i32, ptr %t35
%t51 = load i8*, ptr %text.addr
%t52 = call i32 @strlen(i8* %t51)
%t53 = icmp sge i32 %t50, %t52
br i1 %t53, label %if341, label %end340
if341:
ret i1 0
br label %end340
end340:
%t54 = load i32, ptr %t35
%t55 = add i32 %t54, 1
store i32 %t55, ptr %t35
%t56 = load i32, ptr %t36
%t57 = add i32 %t56, 1
store i32 %t57, ptr %t36
br label %whileCond335
br label %end338
end338:
%t58 = load i8*, ptr %t44
%t59 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_11, i32 0, i32 0
%t61 = call i32 @strcmp(i8* %t58, i8* %t59)
%t62 = icmp eq i32 %t61, 0
br i1 %t62, label %if343, label %end342
if343:
%t63 = load i32, ptr %t36
%t65 = load i8*, ptr %pattern.addr
%t66 = call i32 @strlen(i8* %t65)
%t64 = add i32 %t63, 1
%t67 = icmp sge i32 %t64, %t66
br i1 %t67, label %if345, label %end344
if345:
ret i1 1
br label %end344
end344:
%t69 = load i32, ptr %t35
%t68 = alloca i32
store i32 %t69, ptr %t68
br label %whileCond346
whileCond346:
%t70 = load i32, ptr %t68
%t71 = load i8*, ptr %text.addr
%t72 = call i32 @strlen(i8* %t71)
%t73 = icmp sle i32 %t70, %t72
br i1 %t73, label %whileBody347, label %whileEnd348
whileBody347:
%t74 = load i8*, ptr %text.addr
%t75 = load i32, ptr %t68
%t76 = load i8*, ptr %text.addr
%t77 = call i32 @strlen(i8* %t76)
%t78 = call i8* @slice(i8* %t74, i32 %t75, i32 %t77)
%t79 = alloca i8*
store i8* %t78, ptr %t79
%t80 = load i8*, ptr %pattern.addr
%t81 = load i32, ptr %t36
%t82 = add i32 %t81, 1
%t83 = load i8*, ptr %pattern.addr
%t84 = call i32 @strlen(i8* %t83)
%t85 = call i8* @slice(i8* %t80, i32 %t82, i32 %t84)
%t86 = alloca i8*
store i8* %t85, ptr %t86
%t87 = load i8*, ptr %t79
%t88 = load i8*, ptr %t86
%t89 = call i1 @match(i8* %t87, i8* %t88)
br i1 %t89, label %if350, label %end349
if350:
ret i1 1
br label %end349
end349:
%t90 = load i32, ptr %t68
%t91 = add i32 %t90, 1
store i32 %t91, ptr %t68
br label %whileCond346
whileEnd348:
ret i1 0
br label %end342
end342:
%t92 = load i8*, ptr %t44
%t93 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_12, i32 0, i32 0
%t95 = call i32 @strcmp(i8* %t92, i8* %t93)
%t96 = icmp eq i32 %t95, 0
br i1 %t96, label %if352, label %end351
if352:
%t97 = load i8*, ptr %pattern.addr
%t98 = load i32, ptr %t36
%t99 = add i32 %t98, 1
%t100 = call i8* @charAt(i8* %t97, i32 %t99)
%t101 = alloca i8*
store i8* %t100, ptr %t101
%t102 = load i8*, ptr %t101
%t103 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_13, i32 0, i32 0
%t105 = call i32 @strcmp(i8* %t102, i8* %t103)
%t106 = icmp eq i32 %t105, 0
br i1 %t106, label %if354, label %end353
if354:
%t107 = load i32, ptr %t35
%t108 = load i8*, ptr %text.addr
%t109 = call i32 @strlen(i8* %t108)
%t110 = icmp sge i32 %t107, %t109
br i1 %t110, label %if356, label %end355
if356:
ret i1 0
br label %end355
end355:
%t111 = load i8*, ptr %text.addr
%t112 = load i32, ptr %t35
%t113 = call i8* @charAt(i8* %t111, i32 %t112)
%t114 = alloca i8*
store i8* %t113, ptr %t114
%t116 = load i8*, ptr %t114
%t117 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_14, i32 0, i32 0
%t121 = load i8*, ptr %t114
%t122 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_15, i32 0, i32 0
%t119 = call i32 @strcmp(i8* %t116, i8* %t117)
%t120 = icmp slt i32 %t119, 0
br i1 %t120, label %skip359, label %rhs358
rhs358:
%t124 = call i32 @strcmp(i8* %t121, i8* %t122)
%t125 = icmp sgt i32 %t124, 0
br label %end360
skip359:
br label %end360
end360:
%t115 = phi i1 [ true, %skip359 ], [ %t125, %rhs358 ]
br i1 %t115, label %if361, label %end357
if361:
ret i1 0
br label %end357
end357:
%t126 = load i32, ptr %t35
%t127 = add i32 %t126, 1
store i32 %t127, ptr %t35
%t128 = load i32, ptr %t36
%t129 = add i32 %t128, 2
store i32 %t129, ptr %t36
br label %whileCond335
br label %end353
end353:
%t130 = load i8*, ptr %t101
%t131 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_1, i32 0, i32 0
%t133 = call i32 @strcmp(i8* %t130, i8* %t131)
%t134 = icmp eq i32 %t133, 0
br i1 %t134, label %if363, label %end362
if363:
%t135 = load i32, ptr %t35
%t136 = load i8*, ptr %text.addr
%t137 = call i32 @strlen(i8* %t136)
%t138 = icmp sge i32 %t135, %t137
br i1 %t138, label %if365, label %end364
if365:
ret i1 0
br label %end364
end364:
%t139 = load i8*, ptr %text.addr
%t140 = load i32, ptr %t35
%t141 = call i8* @charAt(i8* %t139, i32 %t140)
%t142 = alloca i8*
store i8* %t141, ptr %t142
%t143 = getelementptr inbounds [53 x i8], [53 x i8]* @.str_stdlib_stdlib_16, i32 0, i32 0
%t144 = load i8*, ptr %t142
%t145 = call i1 @contains(i8* %t143, i8* %t144)
%t146 = xor i1 %t145, true
br i1 %t146, label %if367, label %end366
if367:
ret i1 0
br label %end366
end366:
%t147 = load i32, ptr %t35
%t148 = add i32 %t147, 1
store i32 %t148, ptr %t35
%t149 = load i32, ptr %t36
%t150 = add i32 %t149, 2
store i32 %t150, ptr %t36
br label %whileCond335
br label %end362
end362:
%t151 = load i8*, ptr %t101
%t152 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_17, i32 0, i32 0
%t154 = call i32 @strcmp(i8* %t151, i8* %t152)
%t155 = icmp eq i32 %t154, 0
br i1 %t155, label %if369, label %end368
if369:
%t156 = load i32, ptr %t35
%t157 = load i8*, ptr %text.addr
%t158 = call i32 @strlen(i8* %t157)
%t159 = icmp sge i32 %t156, %t158
br i1 %t159, label %if371, label %end370
if371:
ret i1 0
br label %end370
end370:
%t160 = load i8*, ptr %text.addr
%t161 = load i32, ptr %t35
%t162 = call i8* @charAt(i8* %t160, i32 %t161)
%t163 = alloca i8*
store i8* %t162, ptr %t163
%t164 = getelementptr inbounds [63 x i8], [63 x i8]* @.str_stdlib_stdlib_18, i32 0, i32 0
%t165 = load i8*, ptr %t163
%t166 = call i1 @contains(i8* %t164, i8* %t165)
%t167 = xor i1 %t166, true
br i1 %t167, label %if373, label %end372
if373:
ret i1 0
br label %end372
end372:
%t168 = load i32, ptr %t35
%t169 = add i32 %t168, 1
store i32 %t169, ptr %t35
%t170 = load i32, ptr %t36
%t171 = add i32 %t170, 2
store i32 %t171, ptr %t36
br label %whileCond335
br label %end368
end368:
%t172 = load i8*, ptr %t101
%t173 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_19, i32 0, i32 0
%t175 = call i32 @strcmp(i8* %t172, i8* %t173)
%t176 = icmp eq i32 %t175, 0
br i1 %t176, label %if375, label %end374
if375:
%t177 = load i32, ptr %t35
%t178 = load i8*, ptr %text.addr
%t179 = call i32 @strlen(i8* %t178)
%t180 = icmp sge i32 %t177, %t179
br i1 %t180, label %if377, label %end376
if377:
ret i1 0
br label %end376
end376:
%t181 = load i8*, ptr %text.addr
%t182 = load i32, ptr %t35
%t183 = call i8* @charAt(i8* %t181, i32 %t182)
%t184 = alloca i8*
store i8* %t183, ptr %t184
%t186 = load i8*, ptr %t184
%t187 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_5, i32 0, i32 0
%t191 = load i8*, ptr %t184
%t192 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_7, i32 0, i32 0
%t189 = call i32 @strcmp(i8* %t186, i8* %t187)
%t190 = icmp ne i32 %t189, 0
br i1 %t190, label %rhs379, label %skip380
rhs379:
%t194 = call i32 @strcmp(i8* %t191, i8* %t192)
%t195 = icmp ne i32 %t194, 0
br label %end381
skip380:
br label %end381
end381:
%t185 = phi i1 [ false, %skip380 ], [ %t195, %rhs379 ]
br i1 %t185, label %if382, label %end378
if382:
ret i1 0
br label %end378
end378:
%t196 = load i32, ptr %t35
%t197 = add i32 %t196, 1
store i32 %t197, ptr %t35
%t198 = load i32, ptr %t36
%t199 = add i32 %t198, 2
store i32 %t199, ptr %t36
br label %whileCond335
br label %end374
end374:
br label %end351
end351:
%t200 = load i8*, ptr %t44
%t201 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_20, i32 0, i32 0
%t203 = call i32 @strcmp(i8* %t200, i8* %t201)
%t204 = icmp eq i32 %t203, 0
br i1 %t204, label %if384, label %end383
if384:
%t206 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t205 = alloca i8*
store i8* %t206, i8** %t205
%t208 = load i32, ptr %t36
%t207 = alloca i32
store i32 %t208, ptr %t207
br label %whileCond385
whileCond385:
%t209 = load i32, ptr %t207
%t210 = load i8*, ptr %pattern.addr
%t211 = call i32 @strlen(i8* %t210)
%t212 = icmp slt i32 %t209, %t211
br i1 %t212, label %whileBody386, label %whileEnd387
whileBody386:
%t213 = load i8*, ptr %pattern.addr
%t214 = load i32, ptr %t207
%t215 = call i8* @charAt(i8* %t213, i32 %t214)
%t216 = alloca i8*
store i8* %t215, ptr %t216
%t218 = load i8*, ptr %t216
%t219 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_5, i32 0, i32 0
%t223 = load i8*, ptr %t216
%t224 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_9, i32 0, i32 0
%t221 = call i32 @strcmp(i8* %t218, i8* %t219)
%t222 = icmp eq i32 %t221, 0
br i1 %t222, label %skip390, label %rhs389
rhs389:
%t226 = call i32 @strcmp(i8* %t223, i8* %t224)
%t227 = icmp eq i32 %t226, 0
br label %end391
skip390:
br label %end391
end391:
%t217 = phi i1 [ true, %skip390 ], [ %t227, %rhs389 ]
br i1 %t217, label %if392, label %end388
if392:
br label %whileEnd387
br label %end388
end388:
%t228 = load i8*, ptr %t205
%t229 = load i8*, ptr %t216
%t230 = call i8* @str_concat(i8* %t228, i8* %t229)
store i8* %t230, ptr %t205
%t231 = load i32, ptr %t207
%t232 = add i32 %t231, 1
store i32 %t232, ptr %t207
br label %whileCond385
whileEnd387:
%t233 = load i8*, ptr %t205
%t234 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_21, i32 0, i32 0
%t236 = call i32 @strcmp(i8* %t233, i8* %t234)
%t237 = icmp eq i32 %t236, 0
br i1 %t237, label %if394, label %end393
if394:
%t239 = load i32, ptr %t35
%t238 = alloca i32
store i32 %t239, ptr %t238
%t241 = load i32, ptr %t35
%t242 = load i8*, ptr %text.addr
%t243 = call i32 @strlen(i8* %t242)
%t245 = load i8*, ptr %text.addr
%t246 = load i32, ptr %t35
%t248 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_22, i32 0, i32 0
%t244 = icmp slt i32 %t241, %t243
br i1 %t244, label %rhs396, label %skip397
rhs396:
%t247 = call i8* @charAt(i8* %t245, i32 %t246)
%t250 = call i32 @strcmp(i8* %t247, i8* %t248)
%t251 = icmp eq i32 %t250, 0
br label %end398
skip397:
br label %end398
end398:
%t240 = phi i1 [ false, %skip397 ], [ %t251, %rhs396 ]
br i1 %t240, label %if399, label %end395
if399:
%t252 = load i32, ptr %t35
%t253 = add i32 %t252, 1
store i32 %t253, ptr %t35
br label %end395
end395:
%t254 = load i32, ptr %t35
%t255 = load i8*, ptr %text.addr
%t256 = call i32 @strlen(i8* %t255)
%t257 = icmp sge i32 %t254, %t256
br i1 %t257, label %if401, label %end400
if401:
ret i1 0
br label %end400
end400:
%t259 = load i32, ptr %t35
%t258 = alloca i32
store i32 %t259, ptr %t258
br label %whileCond402
whileCond402:
%t260 = load i32, ptr %t35
%t261 = load i8*, ptr %text.addr
%t262 = call i32 @strlen(i8* %t261)
%t263 = icmp slt i32 %t260, %t262
br i1 %t263, label %whileBody403, label %whileEnd404
whileBody403:
%t264 = load i8*, ptr %text.addr
%t265 = load i32, ptr %t35
%t266 = call i8* @charAt(i8* %t264, i32 %t265)
%t267 = alloca i8*
store i8* %t266, ptr %t267
%t269 = load i8*, ptr %t267
%t270 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_14, i32 0, i32 0
%t274 = load i8*, ptr %t267
%t275 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_15, i32 0, i32 0
%t272 = call i32 @strcmp(i8* %t269, i8* %t270)
%t273 = icmp slt i32 %t272, 0
br i1 %t273, label %skip407, label %rhs406
rhs406:
%t277 = call i32 @strcmp(i8* %t274, i8* %t275)
%t278 = icmp sgt i32 %t277, 0
br label %end408
skip407:
br label %end408
end408:
%t268 = phi i1 [ true, %skip407 ], [ %t278, %rhs406 ]
br i1 %t268, label %if409, label %end405
if409:
br label %whileEnd404
br label %end405
end405:
%t279 = load i32, ptr %t35
%t280 = add i32 %t279, 1
store i32 %t280, ptr %t35
br label %whileCond402
whileEnd404:
%t281 = load i32, ptr %t35
%t282 = load i32, ptr %t258
%t283 = icmp sle i32 %t281, %t282
br i1 %t283, label %if411, label %end410
if411:
ret i1 0
br label %end410
end410:
%t284 = load i32, ptr %t35
%t285 = load i8*, ptr %text.addr
%t286 = call i32 @strlen(i8* %t285)
%t287 = icmp eq i32 %t284, %t286
ret i1 %t287
br label %end393
end393:
%t288 = load i8*, ptr %t205
%t289 = getelementptr inbounds [4 x i8], [4 x i8]* @.str_stdlib_stdlib_23, i32 0, i32 0
%t291 = call i32 @strcmp(i8* %t288, i8* %t289)
%t292 = icmp eq i32 %t291, 0
br i1 %t292, label %if413, label %end412
if413:
%t293 = load i32, ptr %t35
%t294 = load i8*, ptr %text.addr
%t295 = call i32 @strlen(i8* %t294)
%t296 = icmp sge i32 %t293, %t295
br i1 %t296, label %if415, label %end414
if415:
ret i1 0
br label %end414
end414:
%t297 = load i8*, ptr %text.addr
%t298 = load i32, ptr %t35
%t299 = call i8* @charAt(i8* %t297, i32 %t298)
%t300 = alloca i8*
store i8* %t299, ptr %t300
%t304 = load i8*, ptr %t300
%t305 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_1, i32 0, i32 0
%t309 = load i8*, ptr %t300
%t310 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_2, i32 0, i32 0
%t315 = load i8*, ptr %t300
%t316 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_3, i32 0, i32 0
%t320 = load i8*, ptr %t300
%t321 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_4, i32 0, i32 0
%t325 = load i8*, ptr %t300
%t326 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_24, i32 0, i32 0
%t307 = call i32 @strcmp(i8* %t304, i8* %t305)
%t308 = icmp sge i32 %t307, 0
br i1 %t308, label %rhs423, label %skip424
rhs423:
%t312 = call i32 @strcmp(i8* %t309, i8* %t310)
%t313 = icmp sle i32 %t312, 0
br label %end425
skip424:
br label %end425
end425:
%t303 = phi i1 [ false, %skip424 ], [ %t313, %rhs423 ]
br i1 %t303, label %skip421, label %rhs420
rhs420:
%t318 = call i32 @strcmp(i8* %t315, i8* %t316)
%t319 = icmp sge i32 %t318, 0
br i1 %t319, label %rhs426, label %skip427
rhs426:
%t323 = call i32 @strcmp(i8* %t320, i8* %t321)
%t324 = icmp sle i32 %t323, 0
br label %end428
skip427:
br label %end428
end428:
%t314 = phi i1 [ false, %skip427 ], [ %t324, %rhs426 ]
br label %end422
skip421:
br label %end422
end422:
%t302 = phi i1 [ true, %skip421 ], [ %t314, %end428 ]
br i1 %t302, label %skip418, label %rhs417
rhs417:
%t328 = call i32 @strcmp(i8* %t325, i8* %t326)
%t329 = icmp eq i32 %t328, 0
br label %end419
skip418:
br label %end419
end419:
%t301 = phi i1 [ true, %skip418 ], [ %t329, %rhs417 ]
%t330 = xor i1 %t301, true
br i1 %t330, label %if429, label %end416
if429:
ret i1 0
br label %end416
end416:
%t331 = load i32, ptr %t35
%t332 = add i32 %t331, 1
store i32 %t332, ptr %t35
br label %whileCond430
whileCond430:
%t333 = load i32, ptr %t35
%t334 = load i8*, ptr %text.addr
%t335 = call i32 @strlen(i8* %t334)
%t336 = icmp slt i32 %t333, %t335
br i1 %t336, label %whileBody431, label %whileEnd432
whileBody431:
%t337 = load i8*, ptr %text.addr
%t338 = load i32, ptr %t35
%t339 = call i8* @charAt(i8* %t337, i32 %t338)
%t340 = alloca i8*
store i8* %t339, ptr %t340
%t345 = load i8*, ptr %t340
%t346 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_1, i32 0, i32 0
%t350 = load i8*, ptr %t340
%t351 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_2, i32 0, i32 0
%t356 = load i8*, ptr %t340
%t357 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_3, i32 0, i32 0
%t361 = load i8*, ptr %t340
%t362 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_4, i32 0, i32 0
%t367 = load i8*, ptr %t340
%t368 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_14, i32 0, i32 0
%t372 = load i8*, ptr %t340
%t373 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_15, i32 0, i32 0
%t377 = load i8*, ptr %t340
%t378 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_24, i32 0, i32 0
%t348 = call i32 @strcmp(i8* %t345, i8* %t346)
%t349 = icmp sge i32 %t348, 0
br i1 %t349, label %rhs443, label %skip444
rhs443:
%t353 = call i32 @strcmp(i8* %t350, i8* %t351)
%t354 = icmp sle i32 %t353, 0
br label %end445
skip444:
br label %end445
end445:
%t344 = phi i1 [ false, %skip444 ], [ %t354, %rhs443 ]
br i1 %t344, label %skip441, label %rhs440
rhs440:
%t359 = call i32 @strcmp(i8* %t356, i8* %t357)
%t360 = icmp sge i32 %t359, 0
br i1 %t360, label %rhs446, label %skip447
rhs446:
%t364 = call i32 @strcmp(i8* %t361, i8* %t362)
%t365 = icmp sle i32 %t364, 0
br label %end448
skip447:
br label %end448
end448:
%t355 = phi i1 [ false, %skip447 ], [ %t365, %rhs446 ]
br label %end442
skip441:
br label %end442
end442:
%t343 = phi i1 [ true, %skip441 ], [ %t355, %end448 ]
br i1 %t343, label %skip438, label %rhs437
rhs437:
%t370 = call i32 @strcmp(i8* %t367, i8* %t368)
%t371 = icmp sge i32 %t370, 0
br i1 %t371, label %rhs449, label %skip450
rhs449:
%t375 = call i32 @strcmp(i8* %t372, i8* %t373)
%t376 = icmp sle i32 %t375, 0
br label %end451
skip450:
br label %end451
end451:
%t366 = phi i1 [ false, %skip450 ], [ %t376, %rhs449 ]
br label %end439
skip438:
br label %end439
end439:
%t342 = phi i1 [ true, %skip438 ], [ %t366, %end451 ]
br i1 %t342, label %skip435, label %rhs434
rhs434:
%t380 = call i32 @strcmp(i8* %t377, i8* %t378)
%t381 = icmp eq i32 %t380, 0
br label %end436
skip435:
br label %end436
end436:
%t341 = phi i1 [ true, %skip435 ], [ %t381, %rhs434 ]
%t382 = xor i1 %t341, true
br i1 %t382, label %if452, label %end433
if452:
br label %whileEnd432
br label %end433
end433:
%t383 = load i32, ptr %t35
%t384 = add i32 %t383, 1
store i32 %t384, ptr %t35
br label %whileCond430
whileEnd432:
%t385 = load i32, ptr %t35
%t386 = load i8*, ptr %text.addr
%t387 = call i32 @strlen(i8* %t386)
%t388 = icmp eq i32 %t385, %t387
ret i1 %t388
br label %end412
end412:
%t389 = load i8*, ptr %t205
%t390 = getelementptr inbounds [8 x i8], [8 x i8]* @.str_stdlib_stdlib_25, i32 0, i32 0
%t392 = call i32 @strcmp(i8* %t389, i8* %t390)
%t393 = icmp eq i32 %t392, 0
br i1 %t393, label %if454, label %end453
if454:
%t394 = load i32, ptr %t35
%t395 = load i8*, ptr %text.addr
%t396 = call i32 @strlen(i8* %t395)
%t397 = icmp slt i32 %t394, %t396
ret i1 %t397
br label %end453
end453:
br label %end383
end383:
%t398 = load i8*, ptr %t44
%t399 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t401 = call i32 @strcmp(i8* %t398, i8* %t399)
%t402 = icmp eq i32 %t401, 0
br i1 %t402, label %if456, label %end455
if456:
%t404 = load i32, ptr %t36
%t403 = alloca i32
%t405 = add i32 %t404, 1
store i32 %t405, ptr %t403
br label %whileCond457
whileCond457:
%t406 = load i32, ptr %t403
%t407 = load i8*, ptr %pattern.addr
%t408 = call i32 @strlen(i8* %t407)
%t409 = icmp slt i32 %t406, %t408
br i1 %t409, label %whileBody458, label %whileEnd459
whileBody458:
%t410 = load i8*, ptr %pattern.addr
%t411 = load i32, ptr %t403
%t413 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_27, i32 0, i32 0
%t412 = call i8* @charAt(i8* %t410, i32 %t411)
%t415 = call i32 @strcmp(i8* %t412, i8* %t413)
%t416 = icmp eq i32 %t415, 0
br i1 %t416, label %if461, label %end460
if461:
br label %whileEnd459
br label %end460
end460:
%t417 = load i32, ptr %t403
%t418 = add i32 %t417, 1
store i32 %t418, ptr %t403
br label %whileCond457
whileEnd459:
%t419 = load i8*, ptr %pattern.addr
%t420 = load i32, ptr %t36
%t421 = add i32 %t420, 1
%t422 = load i32, ptr %t403
%t423 = call i8* @slice(i8* %t419, i32 %t421, i32 %t422)
%t424 = alloca i8*
store i8* %t423, ptr %t424
%t425 = load i32, ptr %t35
%t426 = load i8*, ptr %text.addr
%t427 = call i32 @strlen(i8* %t426)
%t428 = icmp sge i32 %t425, %t427
br i1 %t428, label %if463, label %end462
if463:
ret i1 0
br label %end462
end462:
%t429 = load i8*, ptr %text.addr
%t430 = load i32, ptr %t35
%t431 = call i8* @charAt(i8* %t429, i32 %t430)
%t432 = alloca i8*
store i8* %t431, ptr %t432
%t433 = alloca i1
store i1 0, ptr %t433
%t435 = load i8*, ptr %t424
%t436 = call i32 @strlen(i8* %t435)
%t438 = load i8*, ptr %t424
%t440 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_22, i32 0, i32 0
%t437 = icmp eq i32 %t436, 3
br i1 %t437, label %rhs465, label %skip466
rhs465:
%t439 = call i8* @charAt(i8* %t438, i32 1)
%t442 = call i32 @strcmp(i8* %t439, i8* %t440)
%t443 = icmp eq i32 %t442, 0
br label %end467
skip466:
br label %end467
end467:
%t434 = phi i1 [ false, %skip466 ], [ %t443, %rhs465 ]
br i1 %t434, label %if468, label %else469
if468:
%t444 = load i8*, ptr %t424
%t445 = call i8* @charAt(i8* %t444, i32 0)
%t446 = alloca i8*
store i8* %t445, ptr %t446
%t447 = load i8*, ptr %t424
%t448 = call i8* @charAt(i8* %t447, i32 2)
%t449 = alloca i8*
store i8* %t448, ptr %t449
%t451 = load i8*, ptr %t432
%t452 = load i8*, ptr %t446
%t456 = load i8*, ptr %t432
%t457 = load i8*, ptr %t449
%t454 = call i32 @strcmp(i8* %t451, i8* %t452)
%t455 = icmp sge i32 %t454, 0
br i1 %t455, label %rhs471, label %skip472
rhs471:
%t459 = call i32 @strcmp(i8* %t456, i8* %t457)
%t460 = icmp sle i32 %t459, 0
br label %end473
skip472:
br label %end473
end473:
%t450 = phi i1 [ false, %skip472 ], [ %t460, %rhs471 ]
br i1 %t450, label %if474, label %end470
if474:
store i1 1, ptr %t433
br label %end470
end470:
br label %end464
else469:
br label %whileCond475
whileCond475:
%t462 = load i32, ptr @t_stdlib_78
%t463 = load i8*, ptr %t424
%t464 = call i32 @strlen(i8* %t463)
%t465 = icmp slt i32 %t462, %t464
br i1 %t465, label %whileBody476, label %whileEnd477
whileBody476:
%t466 = load i8*, ptr %t424
%t467 = load i32, ptr @t_stdlib_78
%t468 = call i8* @charAt(i8* %t466, i32 %t467)
%t469 = alloca i8*
store i8* %t468, ptr %t469
%t470 = load i8*, ptr %t469
%t471 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_28, i32 0, i32 0
%t473 = call i32 @strcmp(i8* %t470, i8* %t471)
%t474 = icmp eq i32 %t473, 0
br i1 %t474, label %if479, label %end478
if479:
%t475 = load i32, ptr @t_stdlib_78
%t476 = add i32 %t475, 1
store i32 %t476, ptr @t_stdlib_78
br label %whileCond475
br label %end478
end478:
%t477 = load i8*, ptr %t469
%t478 = load i8*, ptr %t432
%t480 = call i32 @strcmp(i8* %t477, i8* %t478)
%t481 = icmp eq i32 %t480, 0
br i1 %t481, label %if481, label %end480
if481:
store i1 1, ptr %t433
br label %whileEnd477
br label %end480
end480:
%t482 = load i32, ptr @t_stdlib_78
%t483 = add i32 %t482, 1
store i32 %t483, ptr @t_stdlib_78
br label %whileCond475
whileEnd477:
br label %end464
end464:
%t484 = load i1, ptr %t433
%t485 = xor i1 %t484, true
br i1 %t485, label %if483, label %end482
if483:
ret i1 0
br label %end482
end482:
%t486 = load i32, ptr %t35
%t487 = add i32 %t486, 1
store i32 %t487, ptr %t35
%t488 = load i32, ptr %t403
%t489 = add i32 %t488, 1
store i32 %t489, ptr %t36
br label %whileCond335
br label %end455
end455:
%t490 = load i32, ptr %t35
%t491 = load i8*, ptr %text.addr
%t492 = call i32 @strlen(i8* %t491)
%t493 = icmp sge i32 %t490, %t492
br i1 %t493, label %if485, label %end484
if485:
ret i1 0
br label %end484
end484:
%t494 = load i8*, ptr %text.addr
%t495 = load i32, ptr %t35
%t497 = load i8*, ptr %t44
%t496 = call i8* @charAt(i8* %t494, i32 %t495)
%t499 = call i32 @strcmp(i8* %t496, i8* %t497)
%t500 = icmp ne i32 %t499, 0
br i1 %t500, label %if487, label %end486
if487:
ret i1 0
br label %end486
end486:
%t501 = load i32, ptr %t35
%t502 = add i32 %t501, 1
store i32 %t502, ptr %t35
%t503 = load i32, ptr %t36
%t504 = add i32 %t503, 1
store i32 %t504, ptr %t36
br label %whileCond335
whileEnd337:
%t505 = load i32, ptr %t35
%t506 = load i8*, ptr %text.addr
%t507 = call i32 @strlen(i8* %t506)
%t508 = icmp eq i32 %t505, %t507
ret i1 %t508
}
define i32 @_json_skipWS (i8* %t0, i32 %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%i.addr = alloca i32
store i32 %t1, i32* %i.addr
%t3 = load i32, ptr %i.addr
br label %whileCond488
whileCond488:
%t5 = load i32, ptr %i.addr
%t6 = load i8*, ptr %s.addr
%t7 = call i32 @strlen(i8* %t6)
%t9 = load i8*, ptr %s.addr
%t10 = load i32, ptr %i.addr
%t12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_5, i32 0, i32 0
%t8 = icmp slt i32 %t5, %t7
br i1 %t8, label %rhs491, label %skip492
rhs491:
%t11 = call i8* @charAt(i8* %t9, i32 %t10)
%t14 = call i32 @strcmp(i8* %t11, i8* %t12)
%t15 = icmp eq i32 %t14, 0
br label %end493
skip492:
br label %end493
end493:
%t4 = phi i1 [ false, %skip492 ], [ %t15, %rhs491 ]
br i1 %t4, label %whileBody489, label %whileEnd490
whileBody489:
%t16 = load i32, ptr %i.addr
%t17 = add i32 %t16, 1
store i32 %t17, ptr %i.addr
br label %whileCond488
whileEnd490:
%t18 = load i32, ptr %i.addr
ret i32 %t18
}
define i8* @_json_extractValue (i8* %t0, i32 %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%start.addr = alloca i32
store i32 %t1, i32* %start.addr
%t3 = load i32, ptr %start.addr
%t4 = load i8*, ptr %s.addr
%t5 = load i32, ptr %start.addr
%t6 = call i32 @_json_skipWS(i8* %t4, i32 %t5)
store i32 %t6, ptr %start.addr
%t7 = load i8*, ptr %s.addr
%t8 = load i32, ptr %start.addr
%t10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_29, i32 0, i32 0
%t9 = call i8* @charAt(i8* %t7, i32 %t8)
%t12 = call i32 @strcmp(i8* %t9, i8* %t10)
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if495, label %end494
if495:
%t15 = load i32, ptr %start.addr
%t14 = alloca i32
%t16 = add i32 %t15, 1
store i32 %t16, ptr %t14
br label %whileCond496
whileCond496:
%t17 = load i32, ptr %t14
%t18 = load i8*, ptr %s.addr
%t19 = call i32 @strlen(i8* %t18)
%t20 = icmp slt i32 %t17, %t19
br i1 %t20, label %whileBody497, label %whileEnd498
whileBody497:
%t21 = load i8*, ptr %s.addr
%t22 = load i32, ptr %t14
%t24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_29, i32 0, i32 0
%t23 = call i8* @charAt(i8* %t21, i32 %t22)
%t26 = call i32 @strcmp(i8* %t23, i8* %t24)
%t27 = icmp eq i32 %t26, 0
br i1 %t27, label %if500, label %end499
if500:
br label %whileEnd498
br label %end499
end499:
%t28 = load i32, ptr %t14
%t29 = add i32 %t28, 1
store i32 %t29, ptr %t14
br label %whileCond496
whileEnd498:
%t30 = load i8*, ptr %s.addr
%t31 = load i32, ptr %start.addr
%t32 = add i32 %t31, 1
%t33 = load i32, ptr %t14
%t34 = call i8* @slice(i8* %t30, i32 %t32, i32 %t33)
ret i8* %t34
br label %end494
end494:
%t35 = load i8*, ptr %s.addr
%t36 = load i32, ptr %start.addr
%t38 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_30, i32 0, i32 0
%t37 = call i8* @charAt(i8* %t35, i32 %t36)
%t40 = call i32 @strcmp(i8* %t37, i8* %t38)
%t41 = icmp eq i32 %t40, 0
br i1 %t41, label %if502, label %end501
if502:
%t43 = load i32, ptr %start.addr
%t42 = alloca i32
store i32 %t43, ptr %t42
%t44 = alloca i32
store i32 0, ptr %t44
br label %whileCond503
whileCond503:
%t45 = load i32, ptr %t42
%t46 = load i8*, ptr %s.addr
%t47 = call i32 @strlen(i8* %t46)
%t48 = icmp slt i32 %t45, %t47
br i1 %t48, label %whileBody504, label %whileEnd505
whileBody504:
%t49 = load i8*, ptr %s.addr
%t50 = load i32, ptr %t42
%t52 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_30, i32 0, i32 0
%t51 = call i8* @charAt(i8* %t49, i32 %t50)
%t54 = call i32 @strcmp(i8* %t51, i8* %t52)
%t55 = icmp eq i32 %t54, 0
br i1 %t55, label %if507, label %end506
if507:
%t56 = load i32, ptr %t44
%t57 = add i32 %t56, 1
store i32 %t57, ptr %t44
br label %end506
end506:
%t58 = load i8*, ptr %s.addr
%t59 = load i32, ptr %t42
%t61 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_31, i32 0, i32 0
%t60 = call i8* @charAt(i8* %t58, i32 %t59)
%t63 = call i32 @strcmp(i8* %t60, i8* %t61)
%t64 = icmp eq i32 %t63, 0
br i1 %t64, label %if509, label %end508
if509:
%t65 = load i32, ptr %t44
%t66 = sub i32 %t65, 1
store i32 %t66, ptr %t44
br label %end508
end508:
%t67 = load i32, ptr %t44
%t68 = icmp eq i32 %t67, 0
br i1 %t68, label %if511, label %end510
if511:
br label %whileEnd505
br label %end510
end510:
%t69 = load i32, ptr %t42
%t70 = add i32 %t69, 1
store i32 %t70, ptr %t42
br label %whileCond503
whileEnd505:
%t71 = load i8*, ptr %s.addr
%t72 = load i32, ptr %start.addr
%t73 = load i32, ptr %t42
%t74 = add i32 %t73, 1
%t75 = call i8* @slice(i8* %t71, i32 %t72, i32 %t74)
ret i8* %t75
br label %end501
end501:
%t76 = load i8*, ptr %s.addr
%t77 = load i32, ptr %start.addr
%t79 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t78 = call i8* @charAt(i8* %t76, i32 %t77)
%t81 = call i32 @strcmp(i8* %t78, i8* %t79)
%t82 = icmp eq i32 %t81, 0
br i1 %t82, label %if513, label %end512
if513:
%t84 = load i32, ptr %start.addr
%t83 = alloca i32
store i32 %t84, ptr %t83
%t85 = alloca i32
store i32 0, ptr %t85
br label %whileCond514
whileCond514:
%t86 = load i32, ptr %t83
%t87 = load i8*, ptr %s.addr
%t88 = call i32 @strlen(i8* %t87)
%t89 = icmp slt i32 %t86, %t88
br i1 %t89, label %whileBody515, label %whileEnd516
whileBody515:
%t90 = load i8*, ptr %s.addr
%t91 = load i32, ptr %t83
%t93 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t92 = call i8* @charAt(i8* %t90, i32 %t91)
%t95 = call i32 @strcmp(i8* %t92, i8* %t93)
%t96 = icmp eq i32 %t95, 0
br i1 %t96, label %if518, label %end517
if518:
%t97 = load i32, ptr %t85
%t98 = add i32 %t97, 1
store i32 %t98, ptr %t85
br label %end517
end517:
%t99 = load i8*, ptr %s.addr
%t100 = load i32, ptr %t83
%t102 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_27, i32 0, i32 0
%t101 = call i8* @charAt(i8* %t99, i32 %t100)
%t104 = call i32 @strcmp(i8* %t101, i8* %t102)
%t105 = icmp eq i32 %t104, 0
br i1 %t105, label %if520, label %end519
if520:
%t106 = load i32, ptr %t85
%t107 = sub i32 %t106, 1
store i32 %t107, ptr %t85
br label %end519
end519:
%t108 = load i32, ptr %t85
%t109 = icmp eq i32 %t108, 0
br i1 %t109, label %if522, label %end521
if522:
br label %whileEnd516
br label %end521
end521:
%t110 = load i32, ptr %t83
%t111 = add i32 %t110, 1
store i32 %t111, ptr %t83
br label %whileCond514
whileEnd516:
%t112 = load i8*, ptr %s.addr
%t113 = load i32, ptr %start.addr
%t114 = load i32, ptr %t83
%t115 = add i32 %t114, 1
%t116 = call i8* @slice(i8* %t112, i32 %t113, i32 %t115)
ret i8* %t116
br label %end512
end512:
%t118 = load i32, ptr %start.addr
%t117 = alloca i32
store i32 %t118, ptr %t117
br label %whileCond523
whileCond523:
%t119 = load i32, ptr %t117
%t120 = load i8*, ptr %s.addr
%t121 = call i32 @strlen(i8* %t120)
%t122 = icmp slt i32 %t119, %t121
br i1 %t122, label %whileBody524, label %whileEnd525
whileBody524:
%t125 = load i8*, ptr %s.addr
%t126 = load i32, ptr %t117
%t128 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_28, i32 0, i32 0
%t132 = load i8*, ptr %s.addr
%t133 = load i32, ptr %t117
%t135 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_31, i32 0, i32 0
%t139 = load i8*, ptr %s.addr
%t140 = load i32, ptr %t117
%t142 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_27, i32 0, i32 0
%t127 = call i8* @charAt(i8* %t125, i32 %t126)
%t130 = call i32 @strcmp(i8* %t127, i8* %t128)
%t131 = icmp eq i32 %t130, 0
br i1 %t131, label %skip531, label %rhs530
rhs530:
%t134 = call i8* @charAt(i8* %t132, i32 %t133)
%t137 = call i32 @strcmp(i8* %t134, i8* %t135)
%t138 = icmp eq i32 %t137, 0
br label %end532
skip531:
br label %end532
end532:
%t124 = phi i1 [ true, %skip531 ], [ %t138, %rhs530 ]
br i1 %t124, label %skip528, label %rhs527
rhs527:
%t141 = call i8* @charAt(i8* %t139, i32 %t140)
%t144 = call i32 @strcmp(i8* %t141, i8* %t142)
%t145 = icmp eq i32 %t144, 0
br label %end529
skip528:
br label %end529
end529:
%t123 = phi i1 [ true, %skip528 ], [ %t145, %rhs527 ]
br i1 %t123, label %if533, label %end526
if533:
br label %whileEnd525
br label %end526
end526:
%t146 = load i32, ptr %t117
%t147 = add i32 %t146, 1
store i32 %t147, ptr %t117
br label %whileCond523
whileEnd525:
%t148 = load i8*, ptr %s.addr
%t149 = load i32, ptr %start.addr
%t150 = load i32, ptr %t117
%t151 = call i8* @slice(i8* %t148, i32 %t149, i32 %t150)
ret i8* %t151
}
define i32 @_json_skipElement (i8* %t0, i32 %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%i.addr = alloca i32
store i32 %t1, i32* %i.addr
%t3 = load i32, ptr %i.addr
%t4 = load i8*, ptr %s.addr
%t5 = load i32, ptr %i.addr
%t6 = call i32 @_json_skipWS(i8* %t4, i32 %t5)
store i32 %t6, ptr %i.addr
%t7 = load i8*, ptr %s.addr
%t8 = load i32, ptr %i.addr
%t10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_29, i32 0, i32 0
%t9 = call i8* @charAt(i8* %t7, i32 %t8)
%t12 = call i32 @strcmp(i8* %t9, i8* %t10)
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if535, label %end534
if535:
%t14 = load i32, ptr %i.addr
%t15 = add i32 %t14, 1
store i32 %t15, ptr %i.addr
br label %whileCond536
whileCond536:
%t16 = load i32, ptr %i.addr
%t17 = load i8*, ptr %s.addr
%t18 = call i32 @strlen(i8* %t17)
%t19 = icmp slt i32 %t16, %t18
br i1 %t19, label %whileBody537, label %whileEnd538
whileBody537:
%t20 = load i8*, ptr %s.addr
%t21 = load i32, ptr %i.addr
%t23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_29, i32 0, i32 0
%t22 = call i8* @charAt(i8* %t20, i32 %t21)
%t25 = call i32 @strcmp(i8* %t22, i8* %t23)
%t26 = icmp eq i32 %t25, 0
br i1 %t26, label %if540, label %end539
if540:
br label %whileEnd538
br label %end539
end539:
%t27 = load i32, ptr %i.addr
%t28 = add i32 %t27, 1
store i32 %t28, ptr %i.addr
br label %whileCond536
whileEnd538:
%t29 = load i32, ptr %i.addr
%t30 = add i32 %t29, 1
ret i32 %t30
br label %end534
end534:
%t31 = load i8*, ptr %s.addr
%t32 = load i32, ptr %i.addr
%t34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_30, i32 0, i32 0
%t33 = call i8* @charAt(i8* %t31, i32 %t32)
%t36 = call i32 @strcmp(i8* %t33, i8* %t34)
%t37 = icmp eq i32 %t36, 0
br i1 %t37, label %if542, label %end541
if542:
%t38 = alloca i32
store i32 0, ptr %t38
br label %whileCond543
whileCond543:
%t39 = load i32, ptr %i.addr
%t40 = load i8*, ptr %s.addr
%t41 = call i32 @strlen(i8* %t40)
%t42 = icmp slt i32 %t39, %t41
br i1 %t42, label %whileBody544, label %whileEnd545
whileBody544:
%t43 = load i8*, ptr %s.addr
%t44 = load i32, ptr %i.addr
%t46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_30, i32 0, i32 0
%t45 = call i8* @charAt(i8* %t43, i32 %t44)
%t48 = call i32 @strcmp(i8* %t45, i8* %t46)
%t49 = icmp eq i32 %t48, 0
br i1 %t49, label %if547, label %end546
if547:
%t50 = load i32, ptr %t38
%t51 = add i32 %t50, 1
store i32 %t51, ptr %t38
br label %end546
end546:
%t52 = load i8*, ptr %s.addr
%t53 = load i32, ptr %i.addr
%t55 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_31, i32 0, i32 0
%t54 = call i8* @charAt(i8* %t52, i32 %t53)
%t57 = call i32 @strcmp(i8* %t54, i8* %t55)
%t58 = icmp eq i32 %t57, 0
br i1 %t58, label %if549, label %end548
if549:
%t59 = load i32, ptr %t38
%t60 = sub i32 %t59, 1
store i32 %t60, ptr %t38
br label %end548
end548:
%t61 = load i32, ptr %t38
%t62 = icmp eq i32 %t61, 0
br i1 %t62, label %if551, label %end550
if551:
br label %whileEnd545
br label %end550
end550:
%t63 = load i32, ptr %i.addr
%t64 = add i32 %t63, 1
store i32 %t64, ptr %i.addr
br label %whileCond543
whileEnd545:
%t65 = load i32, ptr %i.addr
%t66 = add i32 %t65, 1
ret i32 %t66
br label %end541
end541:
%t67 = load i8*, ptr %s.addr
%t68 = load i32, ptr %i.addr
%t70 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t69 = call i8* @charAt(i8* %t67, i32 %t68)
%t72 = call i32 @strcmp(i8* %t69, i8* %t70)
%t73 = icmp eq i32 %t72, 0
br i1 %t73, label %if553, label %end552
if553:
%t74 = alloca i32
store i32 0, ptr %t74
br label %whileCond554
whileCond554:
%t75 = load i32, ptr %i.addr
%t76 = load i8*, ptr %s.addr
%t77 = call i32 @strlen(i8* %t76)
%t78 = icmp slt i32 %t75, %t77
br i1 %t78, label %whileBody555, label %whileEnd556
whileBody555:
%t79 = load i8*, ptr %s.addr
%t80 = load i32, ptr %i.addr
%t82 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t81 = call i8* @charAt(i8* %t79, i32 %t80)
%t84 = call i32 @strcmp(i8* %t81, i8* %t82)
%t85 = icmp eq i32 %t84, 0
br i1 %t85, label %if558, label %end557
if558:
%t86 = load i32, ptr %t74
%t87 = add i32 %t86, 1
store i32 %t87, ptr %t74
br label %end557
end557:
%t88 = load i8*, ptr %s.addr
%t89 = load i32, ptr %i.addr
%t91 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_27, i32 0, i32 0
%t90 = call i8* @charAt(i8* %t88, i32 %t89)
%t93 = call i32 @strcmp(i8* %t90, i8* %t91)
%t94 = icmp eq i32 %t93, 0
br i1 %t94, label %if560, label %end559
if560:
%t95 = load i32, ptr %t74
%t96 = sub i32 %t95, 1
store i32 %t96, ptr %t74
br label %end559
end559:
%t97 = load i32, ptr %t74
%t98 = icmp eq i32 %t97, 0
br i1 %t98, label %if562, label %end561
if562:
br label %whileEnd556
br label %end561
end561:
%t99 = load i32, ptr %i.addr
%t100 = add i32 %t99, 1
store i32 %t100, ptr %i.addr
br label %whileCond554
whileEnd556:
%t101 = load i32, ptr %i.addr
%t102 = add i32 %t101, 1
ret i32 %t102
br label %end552
end552:
br label %whileCond563
whileCond563:
%t103 = load i32, ptr %i.addr
%t104 = load i8*, ptr %s.addr
%t105 = call i32 @strlen(i8* %t104)
%t106 = icmp slt i32 %t103, %t105
br i1 %t106, label %whileBody564, label %whileEnd565
whileBody564:
%t109 = load i8*, ptr %s.addr
%t110 = load i32, ptr %i.addr
%t112 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_28, i32 0, i32 0
%t116 = load i8*, ptr %s.addr
%t117 = load i32, ptr %i.addr
%t119 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_27, i32 0, i32 0
%t123 = load i8*, ptr %s.addr
%t124 = load i32, ptr %i.addr
%t126 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_31, i32 0, i32 0
%t111 = call i8* @charAt(i8* %t109, i32 %t110)
%t114 = call i32 @strcmp(i8* %t111, i8* %t112)
%t115 = icmp eq i32 %t114, 0
br i1 %t115, label %skip571, label %rhs570
rhs570:
%t118 = call i8* @charAt(i8* %t116, i32 %t117)
%t121 = call i32 @strcmp(i8* %t118, i8* %t119)
%t122 = icmp eq i32 %t121, 0
br label %end572
skip571:
br label %end572
end572:
%t108 = phi i1 [ true, %skip571 ], [ %t122, %rhs570 ]
br i1 %t108, label %skip568, label %rhs567
rhs567:
%t125 = call i8* @charAt(i8* %t123, i32 %t124)
%t128 = call i32 @strcmp(i8* %t125, i8* %t126)
%t129 = icmp eq i32 %t128, 0
br label %end569
skip568:
br label %end569
end569:
%t107 = phi i1 [ true, %skip568 ], [ %t129, %rhs567 ]
br i1 %t107, label %if573, label %end566
if573:
br label %whileEnd565
br label %end566
end566:
%t130 = load i32, ptr %i.addr
%t131 = add i32 %t130, 1
store i32 %t131, ptr %i.addr
br label %whileCond563
whileEnd565:
%t132 = load i32, ptr %i.addr
ret i32 %t132
}
define i8* @_json_getArrayIndex (i8* %t0, i32 %t1) {
entry:
%arr.addr = alloca i8*
store i8* %t0, i8** %arr.addr
%t2 = load i8*, ptr %arr.addr
%index.addr = alloca i32
store i32 %t1, i32* %index.addr
%t3 = load i32, ptr %index.addr
%t4 = load i8*, ptr %arr.addr
%t5 = call i32 @_json_skipWS(i8* %t4, i32 0)
%t6 = alloca i32
store i32 %t5, ptr %t6
%t7 = load i8*, ptr %arr.addr
%t8 = load i32, ptr %t6
%t10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t9 = call i8* @charAt(i8* %t7, i32 %t8)
%t12 = call i32 @strcmp(i8* %t9, i8* %t10)
%t13 = icmp ne i32 %t12, 0
br i1 %t13, label %if575, label %end574
if575:
%t14 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
ret i8* %t14
br label %end574
end574:
%t15 = load i32, ptr %t6
%t16 = add i32 %t15, 1
store i32 %t16, ptr %t6
%t17 = alloca i32
store i32 0, ptr %t17
br label %whileCond576
whileCond576:
%t18 = load i32, ptr %t6
%t19 = load i8*, ptr %arr.addr
%t20 = call i32 @strlen(i8* %t19)
%t21 = icmp slt i32 %t18, %t20
br i1 %t21, label %whileBody577, label %whileEnd578
whileBody577:
%t22 = load i8*, ptr %arr.addr
%t23 = load i32, ptr %t6
%t24 = call i32 @_json_skipWS(i8* %t22, i32 %t23)
store i32 %t24, ptr %t6
%t25 = load i8*, ptr %arr.addr
%t26 = load i32, ptr %t6
%t28 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_28, i32 0, i32 0
%t27 = call i8* @charAt(i8* %t25, i32 %t26)
%t30 = call i32 @strcmp(i8* %t27, i8* %t28)
%t31 = icmp eq i32 %t30, 0
br i1 %t31, label %if580, label %end579
if580:
%t32 = load i32, ptr %t6
%t33 = add i32 %t32, 1
store i32 %t33, ptr %t6
%t34 = load i8*, ptr %arr.addr
%t35 = load i32, ptr %t6
%t36 = call i32 @_json_skipWS(i8* %t34, i32 %t35)
store i32 %t36, ptr %t6
br label %end579
end579:
%t37 = load i8*, ptr %arr.addr
%t38 = load i32, ptr %t6
%t40 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_27, i32 0, i32 0
%t39 = call i8* @charAt(i8* %t37, i32 %t38)
%t42 = call i32 @strcmp(i8* %t39, i8* %t40)
%t43 = icmp eq i32 %t42, 0
br i1 %t43, label %if582, label %end581
if582:
br label %whileEnd578
br label %end581
end581:
%t44 = load i32, ptr %t6
%t45 = load i8*, ptr %arr.addr
%t46 = call i32 @strlen(i8* %t45)
%t47 = icmp sge i32 %t44, %t46
br i1 %t47, label %if584, label %end583
if584:
br label %whileEnd578
br label %end583
end583:
%t48 = load i32, ptr %t17
%t49 = load i32, ptr %index.addr
%t50 = icmp eq i32 %t48, %t49
br i1 %t50, label %if586, label %end585
if586:
%t51 = load i8*, ptr %arr.addr
%t52 = load i32, ptr %t6
%t53 = call i8* @_json_extractValue(i8* %t51, i32 %t52)
ret i8* %t53
br label %end585
end585:
%t54 = load i8*, ptr %arr.addr
%t55 = load i32, ptr %t6
%t56 = call i32 @_json_skipElement(i8* %t54, i32 %t55)
store i32 %t56, ptr %t6
%t57 = load i32, ptr %t17
%t58 = add i32 %t57, 1
store i32 %t58, ptr %t17
br label %whileCond576
whileEnd578:
%t59 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
ret i8* %t59
}
define i8* @_json_getKey (i8* %t0, i8* %t1) {
entry:
%obj.addr = alloca i8*
store i8* %t0, i8** %obj.addr
%t2 = load i8*, ptr %obj.addr
%key.addr = alloca i8*
store i8* %t1, i8** %key.addr
%t3 = load i8*, ptr %key.addr
%t4 = load i8*, ptr %obj.addr
%t5 = call i32 @_json_skipWS(i8* %t4, i32 0)
%t6 = alloca i32
store i32 %t5, ptr %t6
%t7 = load i8*, ptr %obj.addr
%t8 = load i32, ptr %t6
%t10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_30, i32 0, i32 0
%t9 = call i8* @charAt(i8* %t7, i32 %t8)
%t12 = call i32 @strcmp(i8* %t9, i8* %t10)
%t13 = icmp ne i32 %t12, 0
br i1 %t13, label %if588, label %end587
if588:
%t14 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
ret i8* %t14
br label %end587
end587:
%t15 = load i32, ptr %t6
%t16 = add i32 %t15, 1
store i32 %t16, ptr %t6
br label %whileCond589
whileCond589:
%t17 = load i32, ptr %t6
%t18 = load i8*, ptr %obj.addr
%t19 = call i32 @strlen(i8* %t18)
%t20 = icmp slt i32 %t17, %t19
br i1 %t20, label %whileBody590, label %whileEnd591
whileBody590:
%t21 = load i8*, ptr %obj.addr
%t22 = load i32, ptr %t6
%t23 = call i32 @_json_skipWS(i8* %t21, i32 %t22)
store i32 %t23, ptr %t6
%t24 = load i8*, ptr %obj.addr
%t25 = load i32, ptr %t6
%t27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_31, i32 0, i32 0
%t26 = call i8* @charAt(i8* %t24, i32 %t25)
%t29 = call i32 @strcmp(i8* %t26, i8* %t27)
%t30 = icmp eq i32 %t29, 0
br i1 %t30, label %if593, label %end592
if593:
br label %whileEnd591
br label %end592
end592:
%t31 = load i8*, ptr %obj.addr
%t32 = load i32, ptr %t6
%t34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_28, i32 0, i32 0
%t33 = call i8* @charAt(i8* %t31, i32 %t32)
%t36 = call i32 @strcmp(i8* %t33, i8* %t34)
%t37 = icmp eq i32 %t36, 0
br i1 %t37, label %if595, label %end594
if595:
%t38 = load i32, ptr %t6
%t39 = add i32 %t38, 1
store i32 %t39, ptr %t6
%t40 = load i8*, ptr %obj.addr
%t41 = load i32, ptr %t6
%t42 = call i32 @_json_skipWS(i8* %t40, i32 %t41)
store i32 %t42, ptr %t6
br label %end594
end594:
%t43 = load i8*, ptr %obj.addr
%t44 = load i32, ptr %t6
%t46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_29, i32 0, i32 0
%t45 = call i8* @charAt(i8* %t43, i32 %t44)
%t48 = call i32 @strcmp(i8* %t45, i8* %t46)
%t49 = icmp ne i32 %t48, 0
br i1 %t49, label %if597, label %end596
if597:
br label %whileEnd591
br label %end596
end596:
%t51 = load i32, ptr %t6
%t50 = alloca i32
%t52 = add i32 %t51, 1
store i32 %t52, ptr %t50
%t54 = load i32, ptr %t50
%t53 = alloca i32
store i32 %t54, ptr %t53
br label %whileCond598
whileCond598:
%t56 = load i32, ptr %t53
%t57 = load i8*, ptr %obj.addr
%t58 = call i32 @strlen(i8* %t57)
%t60 = load i8*, ptr %obj.addr
%t61 = load i32, ptr %t53
%t63 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_29, i32 0, i32 0
%t59 = icmp slt i32 %t56, %t58
br i1 %t59, label %rhs601, label %skip602
rhs601:
%t62 = call i8* @charAt(i8* %t60, i32 %t61)
%t65 = call i32 @strcmp(i8* %t62, i8* %t63)
%t66 = icmp ne i32 %t65, 0
br label %end603
skip602:
br label %end603
end603:
%t55 = phi i1 [ false, %skip602 ], [ %t66, %rhs601 ]
br i1 %t55, label %whileBody599, label %whileEnd600
whileBody599:
%t67 = load i32, ptr %t53
%t68 = add i32 %t67, 1
store i32 %t68, ptr %t53
br label %whileCond598
whileEnd600:
%t69 = load i8*, ptr %obj.addr
%t70 = load i32, ptr %t50
%t71 = load i32, ptr %t53
%t72 = call i8* @slice(i8* %t69, i32 %t70, i32 %t71)
%t73 = alloca i8*
store i8* %t72, ptr %t73
%t74 = load i32, ptr %t53
%t75 = add i32 %t74, 1
store i32 %t75, ptr %t6
%t76 = load i8*, ptr %obj.addr
%t77 = load i32, ptr %t6
%t78 = call i32 @_json_skipWS(i8* %t76, i32 %t77)
store i32 %t78, ptr %t6
%t79 = load i8*, ptr %obj.addr
%t80 = load i32, ptr %t6
%t82 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_20, i32 0, i32 0
%t81 = call i8* @charAt(i8* %t79, i32 %t80)
%t84 = call i32 @strcmp(i8* %t81, i8* %t82)
%t85 = icmp ne i32 %t84, 0
br i1 %t85, label %if605, label %end604
if605:
br label %whileEnd591
br label %end604
end604:
%t86 = load i32, ptr %t6
%t87 = add i32 %t86, 1
store i32 %t87, ptr %t6
%t88 = load i8*, ptr %obj.addr
%t89 = load i32, ptr %t6
%t90 = call i32 @_json_skipWS(i8* %t88, i32 %t89)
store i32 %t90, ptr %t6
%t91 = load i8*, ptr %t73
%t92 = load i8*, ptr %key.addr
%t94 = call i32 @strcmp(i8* %t91, i8* %t92)
%t95 = icmp eq i32 %t94, 0
br i1 %t95, label %if607, label %end606
if607:
%t96 = load i8*, ptr %obj.addr
%t97 = load i32, ptr %t6
%t98 = call i8* @_json_extractValue(i8* %t96, i32 %t97)
ret i8* %t98
br label %end606
end606:
%t99 = load i8*, ptr %obj.addr
%t100 = load i32, ptr %t6
%t101 = call i32 @_json_skipElement(i8* %t99, i32 %t100)
store i32 %t101, ptr %t6
br label %whileCond589
whileEnd591:
%t102 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
ret i8* %t102
}
define i32 @_json_parseInt (i8* %t0) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t1 = load i8*, ptr %s.addr
%t2 = alloca i32
store i32 0, ptr %t2
%t3 = alloca i32
store i32 0, ptr %t3
br label %whileCond608
whileCond608:
%t4 = load i32, ptr %t3
%t5 = load i8*, ptr %s.addr
%t6 = call i32 @strlen(i8* %t5)
%t7 = icmp slt i32 %t4, %t6
br i1 %t7, label %whileBody609, label %whileEnd610
whileBody609:
%t9 = load i8*, ptr %s.addr
%t10 = load i32, ptr %t3
%t11 = call i8* @charAt(i8* %t9, i32 %t10)
%t12 = call i32 @string_to_int_ascii(i8* %t11)
%t8 = alloca i32
%t13 = sub i32 %t12, 48
store i32 %t13, ptr %t8
%t14 = load i32, ptr %t2
%t16 = load i32, ptr %t8
%t15 = mul i32 %t14, 10
%t17 = add i32 %t15, %t16
store i32 %t17, ptr %t2
%t18 = load i32, ptr %t3
%t19 = add i32 %t18, 1
store i32 %t19, ptr %t3
br label %whileCond608
whileEnd610:
%t20 = load i32, ptr %t2
ret i32 %t20
}
define i8* @json (i8* %t0, i8* %t1) {
entry:
%data.addr = alloca i8*
store i8* %t0, i8** %data.addr
%t2 = load i8*, ptr %data.addr
%path.addr = alloca i8*
store i8* %t1, i8** %path.addr
%t3 = load i8*, ptr %path.addr
%t5 = load i8*, ptr %data.addr
%t4 = alloca i8*
store i8* %t5, i8** %t4
%t6 = alloca i32
store i32 0, ptr %t6
br label %whileCond611
whileCond611:
br i1 1, label %whileBody612, label %whileEnd613
whileBody612:
%t7 = load i8*, ptr %path.addr
%t8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_8, i32 0, i32 0
%t9 = load i32, ptr %t6
%t10 = call i8* @splitAt(i8* %t7, i8* %t8, i32 %t9)
%t11 = alloca i8*
store i8* %t10, ptr %t11
%t12 = load i8*, ptr %t11
%t13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t15 = call i32 @strcmp(i8* %t12, i8* %t13)
%t16 = icmp eq i32 %t15, 0
br i1 %t16, label %if615, label %end614
if615:
br label %whileEnd613
br label %end614
end614:
%t17 = alloca i32
store i32 0, ptr %t17
br label %whileCond616
whileCond616:
%t18 = load i32, ptr %t17
%t19 = load i8*, ptr %t11
%t20 = call i32 @strlen(i8* %t19)
%t21 = icmp slt i32 %t18, %t20
br i1 %t21, label %whileBody617, label %whileEnd618
whileBody617:
%t22 = load i8*, ptr %t11
%t23 = load i32, ptr %t17
%t25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t24 = call i8* @charAt(i8* %t22, i32 %t23)
%t27 = call i32 @strcmp(i8* %t24, i8* %t25)
%t28 = icmp eq i32 %t27, 0
br i1 %t28, label %if620, label %end619
if620:
br label %whileEnd618
br label %end619
end619:
%t29 = load i32, ptr %t17
%t30 = add i32 %t29, 1
store i32 %t30, ptr %t17
br label %whileCond616
whileEnd618:
%t31 = load i8*, ptr %t11
%t32 = load i32, ptr %t17
%t33 = call i8* @slice(i8* %t31, i32 0, i32 %t32)
%t34 = alloca i8*
store i8* %t33, ptr %t34
%t35 = load i8*, ptr %t11
%t36 = load i32, ptr %t17
%t37 = load i8*, ptr %t11
%t38 = call i32 @strlen(i8* %t37)
%t39 = call i8* @slice(i8* %t35, i32 %t36, i32 %t38)
%t40 = alloca i8*
store i8* %t39, ptr %t40
%t41 = load i8*, ptr %t34
%t42 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t44 = call i32 @strcmp(i8* %t41, i8* %t42)
%t45 = icmp ne i32 %t44, 0
br i1 %t45, label %if622, label %end621
if622:
%t46 = load i8*, ptr %t4
%t47 = load i8*, ptr %t34
%t48 = call i8* @_json_getKey(i8* %t46, i8* %t47)
store i8* %t48, ptr %t4
%t49 = load i8*, ptr %t4
%t50 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
%t52 = call i32 @strcmp(i8* %t49, i8* %t50)
%t53 = icmp eq i32 %t52, 0
br i1 %t53, label %if624, label %end623
if624:
%t54 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
ret i8* %t54
br label %end623
end623:
br label %end621
end621:
%t55 = alloca i32
store i32 0, ptr %t55
br label %whileCond625
whileCond625:
%t56 = load i32, ptr %t55
%t57 = load i8*, ptr %t40
%t58 = call i32 @strlen(i8* %t57)
%t59 = icmp slt i32 %t56, %t58
br i1 %t59, label %whileBody626, label %whileEnd627
whileBody626:
%t60 = load i8*, ptr %t40
%t61 = load i32, ptr %t55
%t63 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_26, i32 0, i32 0
%t62 = call i8* @charAt(i8* %t60, i32 %t61)
%t65 = call i32 @strcmp(i8* %t62, i8* %t63)
%t66 = icmp ne i32 %t65, 0
br i1 %t66, label %if629, label %end628
if629:
br label %whileEnd627
br label %end628
end628:
%t68 = load i32, ptr %t55
%t67 = alloca i32
%t69 = add i32 %t68, 1
store i32 %t69, ptr %t67
br label %whileCond630
whileCond630:
%t70 = load i32, ptr %t67
%t71 = load i8*, ptr %t40
%t72 = call i32 @strlen(i8* %t71)
%t73 = icmp slt i32 %t70, %t72
br i1 %t73, label %whileBody631, label %whileEnd632
whileBody631:
%t74 = load i8*, ptr %t40
%t75 = load i32, ptr %t67
%t77 = getelementptr inbounds [2 x i8], [2 x i8]* @.str_stdlib_stdlib_27, i32 0, i32 0
%t76 = call i8* @charAt(i8* %t74, i32 %t75)
%t79 = call i32 @strcmp(i8* %t76, i8* %t77)
%t80 = icmp eq i32 %t79, 0
br i1 %t80, label %if634, label %end633
if634:
br label %whileEnd632
br label %end633
end633:
%t81 = load i32, ptr %t67
%t82 = add i32 %t81, 1
store i32 %t82, ptr %t67
br label %whileCond630
whileEnd632:
%t83 = load i8*, ptr %t40
%t84 = load i32, ptr %t55
%t85 = add i32 %t84, 1
%t86 = load i32, ptr %t67
%t87 = call i8* @slice(i8* %t83, i32 %t85, i32 %t86)
%t88 = alloca i8*
store i8* %t87, ptr %t88
%t89 = load i8*, ptr %t88
%t90 = call i32 @_json_parseInt(i8* %t89)
%t91 = alloca i32
store i32 %t90, ptr %t91
%t92 = load i8*, ptr %t4
%t93 = load i32, ptr %t91
%t94 = call i8* @_json_getArrayIndex(i8* %t92, i32 %t93)
store i8* %t94, ptr %t4
%t95 = load i8*, ptr %t4
%t96 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
%t98 = call i32 @strcmp(i8* %t95, i8* %t96)
%t99 = icmp eq i32 %t98, 0
br i1 %t99, label %if636, label %end635
if636:
%t100 = getelementptr inbounds [5 x i8], [5 x i8]* @.str_stdlib_stdlib_32, i32 0, i32 0
ret i8* %t100
br label %end635
end635:
%t101 = load i32, ptr %t67
%t102 = add i32 %t101, 1
store i32 %t102, ptr %t55
br label %whileCond625
whileEnd627:
%t103 = load i32, ptr %t6
%t104 = add i32 %t103, 1
store i32 %t104, ptr %t6
br label %whileCond611
whileEnd613:
%t105 = load i8*, ptr %t4
ret i8* %t105
}
define %ZenList* @split (i8* %t0, i8* %t1) {
entry:
%s.addr = alloca i8*
store i8* %t0, i8** %s.addr
%t2 = load i8*, ptr %s.addr
%delim.addr = alloca i8*
store i8* %t1, i8** %delim.addr
%t3 = load i8*, ptr %delim.addr
%t5 = call ptr @zen_list_new(i64 8)
%t4 = alloca ptr
store ptr %t5, ptr %t4
%t6 = load i8*, ptr %s.addr
%t7 = call i32 @strlen(i8* %t6)
%t8 = alloca i32
store i32 %t7, ptr %t8
%t9 = load i8*, ptr %delim.addr
%t10 = call i32 @strlen(i8* %t9)
%t11 = alloca i32
store i32 %t10, ptr %t11
%t12 = load i32, ptr %t11
%t13 = icmp eq i32 %t12, 0
br i1 %t13, label %if638, label %end637
if638:
%t14 = load ptr, ptr %t4
ret ptr %t14
br label %end637
end637:
%t16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
%t15 = alloca i8*
store i8* %t16, i8** %t15
%t17 = alloca i32
store i32 0, ptr %t17
br label %whileCond639
whileCond639:
%t18 = load i32, ptr %t17
%t19 = load i32, ptr %t8
%t20 = icmp slt i32 %t18, %t19
br i1 %t20, label %whileBody640, label %whileEnd641
whileBody640:
%t21 = alloca i1
store i1 1, ptr %t21
%t22 = alloca i32
store i32 0, ptr %t22
%t23 = load i32, ptr %t17
%t24 = load i32, ptr %t8
%t25 = load i32, ptr %t11
%t26 = sub i32 %t24, %t25
%t27 = icmp sle i32 %t23, %t26
br i1 %t27, label %if643, label %else644
if643:
br label %whileCond645
whileCond645:
%t28 = load i32, ptr %t22
%t29 = load i32, ptr %t11
%t30 = icmp slt i32 %t28, %t29
br i1 %t30, label %whileBody646, label %whileEnd647
whileBody646:
%t31 = load i8*, ptr %s.addr
%t32 = load i32, ptr %t17
%t33 = load i32, ptr %t22
%t34 = add i32 %t32, %t33
%t39 = load i8*, ptr %delim.addr
%t40 = load i32, ptr %t22
%t35 = getelementptr i8, i8* %t31, i32 %t34
%t36 = load i8, i8* %t35
%t37 = call i8* @zen_char_to_string(i8 %t36)
%t41 = getelementptr i8, i8* %t39, i32 %t40
%t42 = load i8, i8* %t41
%t43 = call i8* @zen_char_to_string(i8 %t42)
%t46 = call i32 @strcmp(i8* %t37, i8* %t43)
%t47 = icmp ne i32 %t46, 0
br i1 %t47, label %if649, label %end648
if649:
store i1 0, ptr %t21
br label %end648
end648:
%t48 = load i32, ptr %t22
%t49 = add i32 %t48, 1
store i32 %t49, ptr %t22
br label %whileCond645
whileEnd647:
br label %end642
else644:
store i1 0, ptr %t21
br label %end642
end642:
%t50 = load i1, ptr %t21
br i1 %t50, label %if651, label %else652
if651:
%t51 = load ptr, ptr %t4
%t52 = load i8*, ptr %t15
%t53 = alloca i8*
store i8* %t52, ptr %t53
call void @zen_list_push(ptr %t51, ptr %t53)
%t54 = getelementptr inbounds [1 x i8], [1 x i8]* @.str_stdlib_stdlib_0, i32 0, i32 0
store i8* %t54, ptr %t15
%t55 = load i32, ptr %t17
%t56 = load i32, ptr %t11
%t57 = add i32 %t55, %t56
store i32 %t57, ptr %t17
br label %end650
else652:
%t58 = load i8*, ptr %t15
%t59 = load i8*, ptr %s.addr
%t60 = load i32, ptr %t17
%t61 = getelementptr i8, i8* %t59, i32 %t60
%t62 = load i8, i8* %t61
%t63 = call i8* @zen_char_to_string(i8 %t62)
%t65 = call i8* @str_concat(i8* %t58, i8* %t63)
store i8* %t65, ptr %t15
%t66 = load i32, ptr %t17
%t67 = add i32 %t66, 1
store i32 %t67, ptr %t17
br label %end650
end650:
br label %whileCond639
whileEnd641:
%t68 = load ptr, ptr %t4
%t69 = load i8*, ptr %t15
%t70 = alloca i8*
store i8* %t69, ptr %t70
call void @zen_list_push(ptr %t68, ptr %t70)
%t71 = load ptr, ptr %t4
ret ptr %t71
}