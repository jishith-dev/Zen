
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
declare void @_zen_list_set_meta(ptr, i32, i32)
%ZenList = type { ptr, i32, i32, i64 }
declare void @_zen_list_push(ptr, ptr)
declare ptr @_zen_list_new(i64)
declare ptr @_int_to_string_ascii(i32)
declare i32 @_string_to_int_ascii(ptr)
declare i32 @strcmp(ptr, ptr)
declare void @_zen_string_free(ptr)
declare ptr @_str_concat(ptr, ptr)
declare ptr @_zen_char_to_string(i8)
declare ptr @_str_dup(ptr)
declare i32 @strlen(ptr)
%HttpServer = type opaque
%HttpRequest = type opaque
%HttpResponse = type opaque
%Json = type opaque
%JsonArray = type opaque
%JsonObject = type opaque
%Ptr = type { ptr }
%Map = type opaque
%Byte = type opaque






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





@.str_stdlib_stdlib_28 = private unnamed_addr constant [2 x i8] c",\00"

@.str_stdlib_stdlib_29 = private unnamed_addr constant [2 x i8] c"\0D\00"

@.str_stdlib_stdlib_30 = private unnamed_addr constant [2 x i8] c"\22\00"

@.str_stdlib_stdlib_31 = private unnamed_addr constant [2 x i8] c"{\00"
@.str_stdlib_stdlib_32 = private unnamed_addr constant [2 x i8] c"}\00"





@.str_stdlib_stdlib_33 = private unnamed_addr constant [5 x i8] c"null\00"




















define i1 @isEven (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = srem i32 %t1, 2
%t3 = icmp eq i32 %t2, 0
ret i1 %t3
}
define i1 @isOdd (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = srem i32 %t1, 2
%t3 = icmp ne i32 %t2, 0
ret i1 %t3
}
define i1 @isPositive (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = icmp sgt i32 %t1, 0
ret i1 %t2
}
define i1 @isNegative (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = icmp slt i32 %t1, 0
ret i1 %t2
}
define i1 @isNaN (double %t0) {
entry:

%x.addr = alloca double
store double %t0, ptr %x.addr
%t1 = load double, ptr %x.addr
%t2 = load double, ptr %x.addr
%t3 = fcmp one double %t1, %t2
ret i1 %t3
}
define i32 @abs (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = icmp slt i32 %t1, 0
br i1 %t2, label %if1, label %end0
if1:
%t3 = load i32, ptr %x.addr
%t4 = sub i32 0, %t3
ret i32 %t4
end0:
%t5 = load i32, ptr %x.addr
ret i32 %t5
}
define i32 @max (i32 %t0, i32 %t1) {
entry:

%a.addr = alloca i32
store i32 %t0, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, ptr %b.addr
%t2 = load i32, ptr %a.addr
%t3 = load i32, ptr %b.addr
%t4 = icmp sgt i32 %t2, %t3
br i1 %t4, label %if3, label %end2
if3:
%t5 = load i32, ptr %a.addr
ret i32 %t5
end2:
%t6 = load i32, ptr %b.addr
ret i32 %t6
}
define i32 @min (i32 %t0, i32 %t1) {
entry:

%a.addr = alloca i32
store i32 %t0, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, ptr %b.addr
%t2 = load i32, ptr %a.addr
%t3 = load i32, ptr %b.addr
%t4 = icmp slt i32 %t2, %t3
br i1 %t4, label %if5, label %end4
if5:
%t5 = load i32, ptr %a.addr
ret i32 %t5
end4:
%t6 = load i32, ptr %b.addr
ret i32 %t6
}
define i32 @clamp (i32 %t0, i32 %t1, i32 %t2) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%low.addr = alloca i32
store i32 %t1, ptr %low.addr
%high.addr = alloca i32
store i32 %t2, ptr %high.addr
%t3 = load i32, ptr %x.addr
%t4 = load i32, ptr %low.addr
%t5 = icmp slt i32 %t3, %t4
br i1 %t5, label %if7, label %end6
if7:
%t6 = load i32, ptr %low.addr
ret i32 %t6
end6:
%t7 = load i32, ptr %x.addr
%t8 = load i32, ptr %high.addr
%t9 = icmp sgt i32 %t7, %t8
br i1 %t9, label %if9, label %end8
if9:
%t10 = load i32, ptr %high.addr
ret i32 %t10
end8:
%t11 = load i32, ptr %x.addr
ret i32 %t11
}
define i32 @sign (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = icmp sgt i32 %t1, 0
br i1 %t2, label %if11, label %end10
if11:
ret i32 1
end10:
%t3 = load i32, ptr %x.addr
%t4 = icmp slt i32 %t3, 0
br i1 %t4, label %if13, label %end12
if13:
ret i32 -1
end12:
ret i32 0
}
define double @pow (i32 %t0, i32 %t1) {
entry:
%t16 = alloca i1
%t23 = alloca double
%t24 = alloca i32
%base.addr = alloca i32
store i32 %t0, ptr %base.addr
%exp.addr = alloca i32
store i32 %t1, ptr %exp.addr
%t2 = load i32, ptr %exp.addr
%t3 = icmp eq i32 %t2, 0
br i1 %t3, label %if15, label %end14
if15:
ret double 1.0
end14:
%t4 = load i32, ptr %base.addr
%t5 = icmp eq i32 %t4, 0
br i1 %t5, label %if17, label %end16
if17:
%t6 = load i32, ptr %exp.addr
%t7 = icmp sgt i32 %t6, 0
br i1 %t7, label %if19, label %end18
if19:
ret double 0.0
end18:
%t8 = load double, ptr @INF
ret double %t8
end16:
%t9 = load i32, ptr %base.addr
%t10 = icmp eq i32 %t9, 1
br i1 %t10, label %if21, label %end20
if21:
ret double 1.0
end20:
%t11 = load i32, ptr %base.addr
%t12 = icmp eq i32 %t11, -1
br i1 %t12, label %if23, label %end22
if23:
%t13 = load i32, ptr %exp.addr
%t14 = srem i32 %t13, 2
%t15 = icmp eq i32 %t14, 0
br i1 %t15, label %if25, label %end24
if25:
ret double 1.0
end24:
ret double -1.0
end22:
store i1 0, ptr %t16
%t17 = load i32, ptr %exp.addr
%t18 = icmp slt i32 %t17, 0
br i1 %t18, label %if27, label %end26
if27:
store i1 1, ptr %t16
%t20 = load i32, ptr %exp.addr
%t21 = sub i32 0, %t20
store i32 %t21, ptr %exp.addr
br label %end26
end26:
store double 1.0, ptr %t23
store i32 0, ptr %t24
br label %whileCond28
whileCond28:
%t25 = load i32, ptr %t24
%t26 = load i32, ptr %exp.addr
%t27 = icmp slt i32 %t25, %t26
br i1 %t27, label %whileBody29, label %whileEnd30
whileBody29:
%t28 = load double, ptr %t23
%t29 = load i32, ptr %base.addr
%t30 = sitofp i32 %t29 to double
%t31 = fmul double %t28, %t30
store double %t31, ptr %t23
%t33 = load double, ptr %t23
%t34 = load double, ptr @INF
%t35 = fcmp oeq double %t33, %t34
br i1 %t35, label %if32, label %end31
if32:
%t36 = load double, ptr @INF
ret double %t36
end31:
%t37 = load i32, ptr %t24
%t38 = add i32 %t37, 1
store i32 %t38, ptr %t24
br label %whileCond28
whileEnd30:
%t40 = load i1, ptr %t16
br i1 %t40, label %if34, label %end33
if34:
%t41 = load double, ptr %t23
%t42 = fdiv double 1.0, %t41
ret double %t42
end33:
%t43 = load double, ptr %t23
ret double %t43
}
define i32 @sqrt (i32 %t0) {
entry:
%t3 = alloca i32
%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = icmp slt i32 %t1, 0
br i1 %t2, label %if36, label %end35
if36:
ret i32 -1
end35:
store i32 1, ptr %t3
br label %whileCond37
whileCond37:
%t4 = load i32, ptr %t3
%t5 = load i32, ptr %t3
%t7 = load i32, ptr %x.addr
%t6 = mul i32 %t4, %t5
%t8 = icmp sle i32 %t6, %t7
br i1 %t8, label %whileBody38, label %whileEnd39
whileBody38:
%t9 = load i32, ptr %t3
%t10 = add i32 %t9, 1
store i32 %t10, ptr %t3
br label %whileCond37
whileEnd39:
%t12 = load i32, ptr %t3
%t13 = sub i32 %t12, 1
ret i32 %t13
}
define i32 @square (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t3 = mul i32 %t1, %t2
ret i32 %t3
}
define i32 @cube (i32 %t0) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%t1 = load i32, ptr %x.addr
%t2 = load i32, ptr %x.addr
%t4 = load i32, ptr %x.addr
%t3 = mul i32 %t1, %t2
%t5 = mul i32 %t3, %t4
ret i32 %t5
}
define i32 @floor (double %t0) {
entry:
%t3 = alloca i32
%x.addr = alloca double
store double %t0, ptr %x.addr
%t1 = load double, ptr %x.addr
%t2 = fptosi double %t1 to i32
store i32 %t2, ptr %t3
%t5 = load double, ptr %x.addr
%t8 = load double, ptr %x.addr
%t9 = load i32, ptr %t3
%t7 = sitofp i32 0 to double
%t6 = fcmp olt double %t5, %t7
br i1 %t6, label %rhs41, label %skip42
rhs41:
%t11 = sitofp i32 %t9 to double
%t10 = fcmp one double %t8, %t11
br label %end43
skip42:
br label %end43
end43:
%t4 = phi i1 [ false, %skip42 ], [ %t10, %rhs41 ]
br i1 %t4, label %if44, label %end40
if44:
%t12 = load i32, ptr %t3
%t13 = sub i32 %t12, 1
ret i32 %t13
end40:
%t14 = load i32, ptr %t3
ret i32 %t14
}
define i32 @ceil (double %t0) {
entry:
%t3 = alloca i32
%x.addr = alloca double
store double %t0, ptr %x.addr
%t1 = load double, ptr %x.addr
%t2 = fptosi double %t1 to i32
store i32 %t2, ptr %t3
%t4 = load double, ptr %x.addr
%t5 = load i32, ptr %t3
%t7 = sitofp i32 %t5 to double
%t6 = fcmp oeq double %t4, %t7
br i1 %t6, label %if46, label %end45
if46:
%t8 = load i32, ptr %t3
ret i32 %t8
end45:
%t9 = load double, ptr %x.addr
%t11 = sitofp i32 0 to double
%t10 = fcmp ogt double %t9, %t11
br i1 %t10, label %if48, label %end47
if48:
%t12 = load i32, ptr %t3
%t13 = add i32 %t12, 1
ret i32 %t13
end47:
%t14 = load i32, ptr %t3
ret i32 %t14
}
define i32 @round (double %t0) {
entry:
%t3 = alloca i32
%t4 = alloca double
%x.addr = alloca double
store double %t0, ptr %x.addr
%t1 = load double, ptr %x.addr
%t2 = fptosi double %t1 to i32
store i32 %t2, ptr %t3
%t5 = load double, ptr %x.addr
%t6 = load i32, ptr %t3
%t7 = sitofp i32 %t6 to double
%t8 = fsub double %t5, %t7
store double %t8, ptr %t4
%t9 = load double, ptr %x.addr
%t11 = sitofp i32 0 to double
%t10 = fcmp oge double %t9, %t11
br i1 %t10, label %if50, label %end49
if50:
%t12 = load double, ptr %t4
%t13 = fcmp oge double %t12, 0.5
br i1 %t13, label %if52, label %end51
if52:
%t14 = load i32, ptr %t3
%t15 = add i32 %t14, 1
ret i32 %t15
end51:
%t16 = load i32, ptr %t3
ret i32 %t16
end49:
%t17 = load double, ptr %t4
%t18 = fcmp ole double %t17, -0.5
br i1 %t18, label %if54, label %end53
if54:
%t19 = load i32, ptr %t3
%t20 = sub i32 %t19, 1
ret i32 %t20
end53:
%t21 = load i32, ptr %t3
ret i32 %t21
}
define double @toFixed (double %t0, i32 %t1) {
entry:
%t7 = alloca double
%t8 = alloca double
%t14 = alloca i32
%x.addr = alloca double
store double %t0, ptr %x.addr
%precision.addr = alloca i32
store i32 %t1, ptr %precision.addr
%t2 = load i32, ptr %precision.addr
%t3 = icmp slt i32 %t2, 0
br i1 %t3, label %if56, label %end55
if56:
%t4 = load double, ptr %x.addr
ret double %t4
end55:
%t5 = load i32, ptr %precision.addr
%t6 = call double @pow(i32 10, i32 %t5)
store double %t6, ptr %t7
%t9 = load double, ptr %x.addr
%t10 = load double, ptr %t7
%t11 = fmul double %t9, %t10
store double %t11, ptr %t8
%t12 = load double, ptr %t8
%t13 = call i32 @round(double %t12)
store i32 %t13, ptr %t14
%t15 = load i32, ptr %t14
%t16 = load double, ptr %t7
%t17 = sitofp i32 %t15 to double
%t18 = fdiv double %t17, %t16
ret double %t18
}
define i32 @mod (i32 %t0, i32 %t1) {
entry:
%t7 = alloca i32
%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%m.addr = alloca i32
store i32 %t1, ptr %m.addr
%t2 = load i32, ptr %m.addr
%t3 = icmp slt i32 %t2, 0
br i1 %t3, label %if58, label %end57
if58:
%t4 = load i32, ptr %m.addr
%t5 = sub i32 0, %t4
store i32 %t5, ptr %m.addr
br label %end57
end57:
%t8 = load i32, ptr %x.addr
%t9 = load i32, ptr %m.addr
%t10 = srem i32 %t8, %t9
store i32 %t10, ptr %t7
%t11 = load i32, ptr %t7
%t12 = icmp slt i32 %t11, 0
br i1 %t12, label %if60, label %end59
if60:
%t13 = load i32, ptr %t7
%t14 = load i32, ptr %m.addr
%t15 = add i32 %t13, %t14
ret i32 %t15
end59:
%t16 = load i32, ptr %t7
ret i32 %t16
}
define i32 @gcd (i32 %t0, i32 %t1) {
entry:
%t8 = alloca i32
%a.addr = alloca i32
store i32 %t0, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, ptr %b.addr
%t2 = load i32, ptr %a.addr
%t3 = call i32 @abs(i32 %t2)
store i32 %t3, ptr %a.addr
%t4 = load i32, ptr %b.addr
%t5 = call i32 @abs(i32 %t4)
store i32 %t5, ptr %b.addr
br label %whileCond61
whileCond61:
%t6 = load i32, ptr %b.addr
%t7 = icmp ne i32 %t6, 0
br i1 %t7, label %whileBody62, label %whileEnd63
whileBody62:
%t9 = load i32, ptr %b.addr
store i32 %t9, ptr %t8
%t10 = load i32, ptr %a.addr
%t11 = load i32, ptr %b.addr
%t12 = srem i32 %t10, %t11
store i32 %t12, ptr %b.addr
%t14 = load i32, ptr %t8
store i32 %t14, ptr %a.addr
br label %whileCond61
whileEnd63:
%t16 = load i32, ptr %a.addr
ret i32 %t16
}
define i32 @lcm (i32 %t0, i32 %t1) {
entry:

%a.addr = alloca i32
store i32 %t0, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, ptr %b.addr
%t3 = load i32, ptr %a.addr
%t5 = load i32, ptr %b.addr
%t4 = icmp eq i32 %t3, 0
br i1 %t4, label %skip66, label %rhs65
rhs65:
%t6 = icmp eq i32 %t5, 0
br label %end67
skip66:
br label %end67
end67:
%t2 = phi i1 [ true, %skip66 ], [ %t6, %rhs65 ]
br i1 %t2, label %if68, label %end64
if68:
ret i32 0
end64:
%t7 = load i32, ptr %a.addr
%t8 = load i32, ptr %a.addr
%t9 = load i32, ptr %b.addr
%t12 = load i32, ptr %b.addr
%t10 = call i32 @gcd(i32 %t8, i32 %t9)
%t11 = sdiv i32 %t7, %t10
%t13 = mul i32 %t11, %t12
%t14 = call i32 @abs(i32 %t13)
ret i32 %t14
}
define double @factorial (i32 %t0) {
entry:
%t5 = alloca double
%t6 = alloca i32
%n.addr = alloca i32
store i32 %t0, ptr %n.addr
%t1 = load i32, ptr %n.addr
%t2 = icmp slt i32 %t1, 0
br i1 %t2, label %if70, label %end69
if70:
ret double -1.0
end69:
%t3 = load i32, ptr %n.addr
%t4 = icmp eq i32 %t3, 0
br i1 %t4, label %if72, label %end71
if72:
ret double 1.0
end71:
store double 1.0, ptr %t5
store i32 1, ptr %t6
br label %whileCond73
whileCond73:
%t7 = load i32, ptr %t6
%t8 = load i32, ptr %n.addr
%t9 = icmp sle i32 %t7, %t8
br i1 %t9, label %whileBody74, label %whileEnd75
whileBody74:
%t10 = load double, ptr %t5
%t11 = load i32, ptr %t6
%t12 = sitofp i32 %t11 to double
%t13 = fmul double %t10, %t12
store double %t13, ptr %t5
%t15 = load i32, ptr %t6
%t16 = add i32 %t15, 1
store i32 %t16, ptr %t6
br label %whileCond73
whileEnd75:
%t18 = load double, ptr %t5
ret double %t18
}
define i1 @isPrime (i32 %t0) {
entry:
%t7 = alloca i32
%n.addr = alloca i32
store i32 %t0, ptr %n.addr
%t1 = load i32, ptr %n.addr
%t2 = icmp slt i32 %t1, 2
br i1 %t2, label %if77, label %end76
if77:
ret i1 0
end76:
%t3 = load i32, ptr %n.addr
%t4 = icmp eq i32 %t3, 2
br i1 %t4, label %if79, label %end78
if79:
ret i1 1
end78:
%t5 = load i32, ptr %n.addr
%t6 = call i1 @isEven(i32 %t5)
br i1 %t6, label %if81, label %end80
if81:
ret i1 0
end80:
store i32 3, ptr %t7
br label %whileCond82
whileCond82:
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %n.addr
%t10 = call i32 @sqrt(i32 %t9)
%t11 = icmp sle i32 %t8, %t10
br i1 %t11, label %whileBody83, label %whileEnd84
whileBody83:
%t12 = load i32, ptr %n.addr
%t13 = load i32, ptr %t7
%t14 = srem i32 %t12, %t13
%t15 = icmp eq i32 %t14, 0
br i1 %t15, label %if86, label %end85
if86:
ret i1 0
end85:
%t16 = load i32, ptr %t7
%t17 = add i32 %t16, 2
store i32 %t17, ptr %t7
br label %whileCond82
whileEnd84:
ret i1 1
}
define double @lerp (double %t0, double %t1, double %t2) {
entry:

%a.addr = alloca double
store double %t0, ptr %a.addr
%b.addr = alloca double
store double %t1, ptr %b.addr
%t.addr = alloca double
store double %t2, ptr %t.addr
%t3 = load double, ptr %a.addr
%t4 = load double, ptr %b.addr
%t5 = load double, ptr %a.addr
%t7 = load double, ptr %t.addr
%t6 = fsub double %t4, %t5
%t8 = fmul double %t6, %t7
%t9 = fadd double %t3, %t8
ret double %t9
}
define double @normalize (double %t0, double %t1, double %t2) {
entry:

%x.addr = alloca double
store double %t0, ptr %x.addr
%a.addr = alloca double
store double %t1, ptr %a.addr
%b.addr = alloca double
store double %t2, ptr %b.addr
%t3 = load double, ptr %a.addr
%t4 = load double, ptr %b.addr
%t5 = fcmp oeq double %t3, %t4
br i1 %t5, label %if88, label %end87
if88:
ret double 0.0
end87:
%t6 = load double, ptr %x.addr
%t7 = load double, ptr %a.addr
%t9 = load double, ptr %b.addr
%t10 = load double, ptr %a.addr
%t8 = fsub double %t6, %t7
%t11 = fsub double %t9, %t10
%t12 = fdiv double %t8, %t11
ret double %t12
}
define i1 @between (i32 %t0, i32 %t1, i32 %t2) {
entry:

%x.addr = alloca i32
store i32 %t0, ptr %x.addr
%a.addr = alloca i32
store i32 %t1, ptr %a.addr
%b.addr = alloca i32
store i32 %t2, ptr %b.addr
%t4 = load i32, ptr %x.addr
%t5 = load i32, ptr %a.addr
%t7 = load i32, ptr %x.addr
%t8 = load i32, ptr %b.addr
%t6 = icmp sge i32 %t4, %t5
br i1 %t6, label %rhs89, label %skip90
rhs89:
%t9 = icmp sle i32 %t7, %t8
br label %end91
skip90:
br label %end91
end91:
%t3 = phi i1 [ false, %skip90 ], [ %t9, %rhs89 ]
ret i1 %t3
}
define ptr @reverse (ptr %t0) {
entry:
%t3 = alloca i32
%t4 = alloca ptr
%t7 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%t1 = load ptr, ptr %s.addr
%t2 = call i32 @strlen(ptr %t1)
store i32 %t2, ptr %t3
%t5 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t6 = call ptr @_str_dup(ptr %t5)
store ptr %t6, ptr %t4
%t8 = load i32, ptr %t3
%t9 = sub i32 %t8, 1
store i32 %t9, ptr %t7
br label %whileCond92
whileCond92:
%t10 = load i32, ptr %t7
%t11 = icmp sge i32 %t10, 0
br i1 %t11, label %whileBody93, label %whileEnd94
whileBody93:
%t12 = load ptr, ptr %t4
%t13 = load ptr, ptr %s.addr
%t14 = load i32, ptr %t7
%t15 = getelementptr i8, ptr %t13, i32 %t14
%t16 = load i8, ptr %t15
%t17 = call ptr @_zen_char_to_string(i8 %t16)
%t19 = call ptr @_str_concat(ptr %t12, ptr %t17)
%t21 = load ptr, ptr %t4
call void @_zen_string_free(ptr %t21)
store ptr %t19, ptr %t4
%t22 = load i32, ptr %t7
%t23 = sub i32 %t22, 1
store i32 %t23, ptr %t7
br label %whileCond92
whileEnd94:
%t25 = load ptr, ptr %t4
ret ptr %t25
}
define i32 @indexOf (ptr %t0, ptr %t1) {
entry:
%t4 = alloca i32
%t7 = alloca i32
%t10 = alloca i32
%t16 = alloca i1
%t17 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%target.addr = alloca ptr
store ptr %t1, ptr %target.addr
%t2 = load ptr, ptr %s.addr
%t3 = call i32 @strlen(ptr %t2)
store i32 %t3, ptr %t4
%t5 = load ptr, ptr %target.addr
%t6 = call i32 @strlen(ptr %t5)
store i32 %t6, ptr %t7
%t8 = load i32, ptr %t7
%t9 = icmp eq i32 %t8, 0
br i1 %t9, label %if96, label %end95
if96:
ret i32 0
end95:
store i32 0, ptr %t10
br label %whileCond97
whileCond97:
%t11 = load i32, ptr %t10
%t12 = load i32, ptr %t4
%t13 = load i32, ptr %t7
%t14 = sub i32 %t12, %t13
%t15 = icmp sle i32 %t11, %t14
br i1 %t15, label %whileBody98, label %whileEnd99
whileBody98:
store i1 1, ptr %t16
store i32 0, ptr %t17
br label %whileCond100
whileCond100:
%t18 = load i32, ptr %t17
%t19 = load i32, ptr %t7
%t20 = icmp slt i32 %t18, %t19
br i1 %t20, label %whileBody101, label %whileEnd102
whileBody101:
%t21 = load ptr, ptr %s.addr
%t22 = load i32, ptr %t10
%t23 = load i32, ptr %t17
%t24 = add i32 %t22, %t23
%t29 = load ptr, ptr %target.addr
%t30 = load i32, ptr %t17
%t25 = getelementptr i8, ptr %t21, i32 %t24
%t26 = load i8, ptr %t25
%t27 = call ptr @_zen_char_to_string(i8 %t26)
%t31 = getelementptr i8, ptr %t29, i32 %t30
%t32 = load i8, ptr %t31
%t33 = call ptr @_zen_char_to_string(i8 %t32)
%t35 = call i32 @strcmp(ptr %t27, ptr %t33)
%t36 = icmp ne i32 %t35, 0
br i1 %t36, label %if104, label %end103
if104:
store i1 0, ptr %t16
br label %end103
end103:
%t38 = load i32, ptr %t17
%t39 = add i32 %t38, 1
store i32 %t39, ptr %t17
br label %whileCond100
whileEnd102:
%t41 = load i1, ptr %t16
br i1 %t41, label %if106, label %end105
if106:
%t42 = load i32, ptr %t10
ret i32 %t42
end105:
%t43 = load i32, ptr %t10
%t44 = add i32 %t43, 1
store i32 %t44, ptr %t10
br label %whileCond97
whileEnd99:
ret i32 -1
}
define ptr @slice (ptr %t0, i32 %t1, i32 %t2) {
entry:
%t5 = alloca i32
%t19 = alloca ptr
%t22 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%start.addr = alloca i32
store i32 %t1, ptr %start.addr
%end.addr = alloca i32
store i32 %t2, ptr %end.addr
%t3 = load ptr, ptr %s.addr
%t4 = call i32 @strlen(ptr %t3)
store i32 %t4, ptr %t5
%t6 = load i32, ptr %start.addr
%t7 = icmp slt i32 %t6, 0
br i1 %t7, label %if108, label %end107
if108:
store i32 0, ptr %start.addr
br label %end107
end107:
%t9 = load i32, ptr %end.addr
%t10 = load i32, ptr %t5
%t11 = icmp sgt i32 %t9, %t10
br i1 %t11, label %if110, label %end109
if110:
%t12 = load i32, ptr %t5
store i32 %t12, ptr %end.addr
br label %end109
end109:
%t14 = load i32, ptr %start.addr
%t15 = load i32, ptr %end.addr
%t16 = icmp sgt i32 %t14, %t15
br i1 %t16, label %if112, label %end111
if112:
%t17 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t18 = call ptr @_str_dup(ptr %t17)
ret ptr %t18
end111:
%t20 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t21 = call ptr @_str_dup(ptr %t20)
store ptr %t21, ptr %t19
%t23 = load i32, ptr %start.addr
store i32 %t23, ptr %t22
br label %whileCond113
whileCond113:
%t24 = load i32, ptr %t22
%t25 = load i32, ptr %end.addr
%t26 = icmp slt i32 %t24, %t25
br i1 %t26, label %whileBody114, label %whileEnd115
whileBody114:
%t27 = load ptr, ptr %t19
%t28 = load ptr, ptr %s.addr
%t29 = load i32, ptr %t22
%t30 = getelementptr i8, ptr %t28, i32 %t29
%t31 = load i8, ptr %t30
%t32 = call ptr @_zen_char_to_string(i8 %t31)
%t34 = call ptr @_str_concat(ptr %t27, ptr %t32)
%t36 = load ptr, ptr %t19
call void @_zen_string_free(ptr %t36)
store ptr %t34, ptr %t19
%t37 = load i32, ptr %t22
%t38 = add i32 %t37, 1
store i32 %t38, ptr %t22
br label %whileCond113
whileEnd115:
%t40 = load ptr, ptr %t19
ret ptr %t40
}
define ptr @charAt (ptr %t0, i32 %t1) {
entry:
%t4 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%index.addr = alloca i32
store i32 %t1, ptr %index.addr
%t2 = load ptr, ptr %s.addr
%t3 = call i32 @strlen(ptr %t2)
store i32 %t3, ptr %t4
%t6 = load i32, ptr %index.addr
%t8 = load i32, ptr %index.addr
%t9 = load i32, ptr %t4
%t7 = icmp slt i32 %t6, 0
br i1 %t7, label %skip118, label %rhs117
rhs117:
%t10 = icmp sge i32 %t8, %t9
br label %end119
skip118:
br label %end119
end119:
%t5 = phi i1 [ true, %skip118 ], [ %t10, %rhs117 ]
br i1 %t5, label %if120, label %end116
if120:
%t11 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t12 = call ptr @_str_dup(ptr %t11)
ret ptr %t12
end116:
%t13 = load ptr, ptr %s.addr
%t14 = load i32, ptr %index.addr
%t15 = getelementptr i8, ptr %t13, i32 %t14
%t16 = load i8, ptr %t15
%t17 = call ptr @_zen_char_to_string(i8 %t16)
ret ptr %t17
}
define ptr @replace (ptr %t0, ptr %t1, ptr %t2) {
entry:
%t5 = alloca i32
%t8 = alloca i32
%t12 = alloca i32
%t18 = alloca i1
%t19 = alloca i32
%t44 = alloca ptr
%t47 = alloca i32
%t71 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%target.addr = alloca ptr
store ptr %t1, ptr %target.addr
%repl.addr = alloca ptr
store ptr %t2, ptr %repl.addr
%t3 = load ptr, ptr %s.addr
%t4 = call i32 @strlen(ptr %t3)
store i32 %t4, ptr %t5
%t6 = load ptr, ptr %target.addr
%t7 = call i32 @strlen(ptr %t6)
store i32 %t7, ptr %t8
%t9 = load i32, ptr %t8
%t10 = icmp eq i32 %t9, 0
br i1 %t10, label %if122, label %end121
if122:
%t11 = load ptr, ptr %s.addr
ret ptr %t11
end121:
store i32 0, ptr %t12
br label %whileCond123
whileCond123:
%t13 = load i32, ptr %t12
%t14 = load i32, ptr %t5
%t15 = load i32, ptr %t8
%t16 = sub i32 %t14, %t15
%t17 = icmp sle i32 %t13, %t16
br i1 %t17, label %whileBody124, label %whileEnd125
whileBody124:
store i1 1, ptr %t18
store i32 0, ptr %t19
br label %whileCond126
whileCond126:
%t20 = load i32, ptr %t19
%t21 = load i32, ptr %t8
%t22 = icmp slt i32 %t20, %t21
br i1 %t22, label %whileBody127, label %whileEnd128
whileBody127:
%t23 = load ptr, ptr %s.addr
%t24 = load i32, ptr %t12
%t25 = load i32, ptr %t19
%t26 = add i32 %t24, %t25
%t31 = load ptr, ptr %target.addr
%t32 = load i32, ptr %t19
%t27 = getelementptr i8, ptr %t23, i32 %t26
%t28 = load i8, ptr %t27
%t29 = call ptr @_zen_char_to_string(i8 %t28)
%t33 = getelementptr i8, ptr %t31, i32 %t32
%t34 = load i8, ptr %t33
%t35 = call ptr @_zen_char_to_string(i8 %t34)
%t37 = call i32 @strcmp(ptr %t29, ptr %t35)
%t38 = icmp ne i32 %t37, 0
br i1 %t38, label %if130, label %end129
if130:
store i1 0, ptr %t18
br label %end129
end129:
%t40 = load i32, ptr %t19
%t41 = add i32 %t40, 1
store i32 %t41, ptr %t19
br label %whileCond126
whileEnd128:
%t43 = load i1, ptr %t18
br i1 %t43, label %if132, label %end131
if132:
%t45 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t46 = call ptr @_str_dup(ptr %t45)
store ptr %t46, ptr %t44
store i32 0, ptr %t47
br label %whileCond133
whileCond133:
%t48 = load i32, ptr %t47
%t49 = load i32, ptr %t12
%t50 = icmp slt i32 %t48, %t49
br i1 %t50, label %whileBody134, label %whileEnd135
whileBody134:
%t51 = load ptr, ptr %t44
%t52 = load ptr, ptr %s.addr
%t53 = load i32, ptr %t47
%t54 = getelementptr i8, ptr %t52, i32 %t53
%t55 = load i8, ptr %t54
%t56 = call ptr @_zen_char_to_string(i8 %t55)
%t58 = call ptr @_str_concat(ptr %t51, ptr %t56)
%t60 = load ptr, ptr %t44
call void @_zen_string_free(ptr %t60)
store ptr %t58, ptr %t44
%t61 = load i32, ptr %t47
%t62 = add i32 %t61, 1
store i32 %t62, ptr %t47
br label %whileCond133
whileEnd135:
%t64 = load ptr, ptr %t44
%t65 = load ptr, ptr %repl.addr
%t66 = call ptr @_str_concat(ptr %t64, ptr %t65)
%t68 = load ptr, ptr %t44
call void @_zen_string_free(ptr %t68)
store ptr %t66, ptr %t44
%t69 = load ptr, ptr %repl.addr
%t70 = call i32 @strlen(ptr %t69)
store i32 %t70, ptr %t71
%t72 = load i32, ptr %t12
%t73 = load i32, ptr %t8
%t74 = add i32 %t72, %t73
store i32 %t74, ptr %t47
br label %whileCond136
whileCond136:
%t76 = load i32, ptr %t47
%t77 = load i32, ptr %t5
%t78 = icmp slt i32 %t76, %t77
br i1 %t78, label %whileBody137, label %whileEnd138
whileBody137:
%t79 = load ptr, ptr %t44
%t80 = load ptr, ptr %s.addr
%t81 = load i32, ptr %t47
%t82 = getelementptr i8, ptr %t80, i32 %t81
%t83 = load i8, ptr %t82
%t84 = call ptr @_zen_char_to_string(i8 %t83)
%t86 = call ptr @_str_concat(ptr %t79, ptr %t84)
%t88 = load ptr, ptr %t44
call void @_zen_string_free(ptr %t88)
store ptr %t86, ptr %t44
%t89 = load i32, ptr %t47
%t90 = add i32 %t89, 1
store i32 %t90, ptr %t47
br label %whileCond136
whileEnd138:
%t92 = load ptr, ptr %t44
ret ptr %t92
end131:
%t93 = load i32, ptr %t12
%t94 = add i32 %t93, 1
store i32 %t94, ptr %t12
br label %whileCond123
whileEnd125:
%t96 = load ptr, ptr %s.addr
ret ptr %t96
}
define ptr @replaceAll (ptr %t0, ptr %t1, ptr %t2) {
entry:
%t5 = alloca i32
%t8 = alloca i32
%t12 = alloca ptr
%t15 = alloca i32
%t19 = alloca i1
%t20 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%target.addr = alloca ptr
store ptr %t1, ptr %target.addr
%repl.addr = alloca ptr
store ptr %t2, ptr %repl.addr
%t3 = load ptr, ptr %s.addr
%t4 = call i32 @strlen(ptr %t3)
store i32 %t4, ptr %t5
%t6 = load ptr, ptr %target.addr
%t7 = call i32 @strlen(ptr %t6)
store i32 %t7, ptr %t8
%t9 = load i32, ptr %t8
%t10 = icmp eq i32 %t9, 0
br i1 %t10, label %if140, label %end139
if140:
%t11 = load ptr, ptr %s.addr
ret ptr %t11
end139:
%t13 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t14 = call ptr @_str_dup(ptr %t13)
store ptr %t14, ptr %t12
store i32 0, ptr %t15
br label %whileCond141
whileCond141:
%t16 = load i32, ptr %t15
%t17 = load i32, ptr %t5
%t18 = icmp slt i32 %t16, %t17
br i1 %t18, label %whileBody142, label %whileEnd143
whileBody142:
store i1 1, ptr %t19
store i32 0, ptr %t20
%t21 = load i32, ptr %t15
%t22 = load i32, ptr %t5
%t23 = load i32, ptr %t8
%t24 = sub i32 %t22, %t23
%t25 = icmp sle i32 %t21, %t24
br i1 %t25, label %if145, label %else146
if145:
br label %whileCond147
whileCond147:
%t26 = load i32, ptr %t20
%t27 = load i32, ptr %t8
%t28 = icmp slt i32 %t26, %t27
br i1 %t28, label %whileBody148, label %whileEnd149
whileBody148:
%t29 = load ptr, ptr %s.addr
%t30 = load i32, ptr %t15
%t31 = load i32, ptr %t20
%t32 = add i32 %t30, %t31
%t37 = load ptr, ptr %target.addr
%t38 = load i32, ptr %t20
%t33 = getelementptr i8, ptr %t29, i32 %t32
%t34 = load i8, ptr %t33
%t35 = call ptr @_zen_char_to_string(i8 %t34)
%t39 = getelementptr i8, ptr %t37, i32 %t38
%t40 = load i8, ptr %t39
%t41 = call ptr @_zen_char_to_string(i8 %t40)
%t43 = call i32 @strcmp(ptr %t35, ptr %t41)
%t44 = icmp ne i32 %t43, 0
br i1 %t44, label %if151, label %end150
if151:
store i1 0, ptr %t19
br label %end150
end150:
%t46 = load i32, ptr %t20
%t47 = add i32 %t46, 1
store i32 %t47, ptr %t20
br label %whileCond147
whileEnd149:
br label %end144
else146:
store i1 0, ptr %t19
br label %end144
end144:
%t50 = load i1, ptr %t19
br i1 %t50, label %if153, label %else154
if153:
%t51 = load ptr, ptr %t12
%t52 = load ptr, ptr %repl.addr
%t53 = call ptr @_str_concat(ptr %t51, ptr %t52)
%t55 = load ptr, ptr %t12
call void @_zen_string_free(ptr %t55)
store ptr %t53, ptr %t12
%t56 = load i32, ptr %t15
%t57 = load i32, ptr %t8
%t58 = add i32 %t56, %t57
store i32 %t58, ptr %t15
br label %end152
else154:
%t60 = load ptr, ptr %t12
%t61 = load ptr, ptr %s.addr
%t62 = load i32, ptr %t15
%t63 = getelementptr i8, ptr %t61, i32 %t62
%t64 = load i8, ptr %t63
%t65 = call ptr @_zen_char_to_string(i8 %t64)
%t67 = call ptr @_str_concat(ptr %t60, ptr %t65)
%t69 = load ptr, ptr %t12
call void @_zen_string_free(ptr %t69)
store ptr %t67, ptr %t12
%t70 = load i32, ptr %t15
%t71 = add i32 %t70, 1
store i32 %t71, ptr %t15
br label %end152
end152:
br label %whileCond141
whileEnd143:
%t73 = load ptr, ptr %t12
ret ptr %t73
}
define i1 @contains (ptr %t0, ptr %t1) {
entry:
%t4 = alloca i32
%t7 = alloca i32
%t10 = alloca i32
%t16 = alloca i1
%t17 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%target.addr = alloca ptr
store ptr %t1, ptr %target.addr
%t2 = load ptr, ptr %s.addr
%t3 = call i32 @strlen(ptr %t2)
store i32 %t3, ptr %t4
%t5 = load ptr, ptr %target.addr
%t6 = call i32 @strlen(ptr %t5)
store i32 %t6, ptr %t7
%t8 = load i32, ptr %t7
%t9 = icmp eq i32 %t8, 0
br i1 %t9, label %if156, label %end155
if156:
ret i1 1
end155:
store i32 0, ptr %t10
br label %whileCond157
whileCond157:
%t11 = load i32, ptr %t10
%t12 = load i32, ptr %t4
%t13 = load i32, ptr %t7
%t14 = sub i32 %t12, %t13
%t15 = icmp sle i32 %t11, %t14
br i1 %t15, label %whileBody158, label %whileEnd159
whileBody158:
store i1 1, ptr %t16
store i32 0, ptr %t17
br label %whileCond160
whileCond160:
%t18 = load i32, ptr %t17
%t19 = load i32, ptr %t7
%t20 = icmp slt i32 %t18, %t19
br i1 %t20, label %whileBody161, label %whileEnd162
whileBody161:
%t21 = load ptr, ptr %s.addr
%t22 = load i32, ptr %t10
%t23 = load i32, ptr %t17
%t24 = add i32 %t22, %t23
%t29 = load ptr, ptr %target.addr
%t30 = load i32, ptr %t17
%t25 = getelementptr i8, ptr %t21, i32 %t24
%t26 = load i8, ptr %t25
%t27 = call ptr @_zen_char_to_string(i8 %t26)
%t31 = getelementptr i8, ptr %t29, i32 %t30
%t32 = load i8, ptr %t31
%t33 = call ptr @_zen_char_to_string(i8 %t32)
%t35 = call i32 @strcmp(ptr %t27, ptr %t33)
%t36 = icmp ne i32 %t35, 0
br i1 %t36, label %if164, label %end163
if164:
store i1 0, ptr %t16
br label %end163
end163:
%t38 = load i32, ptr %t17
%t39 = add i32 %t38, 1
store i32 %t39, ptr %t17
br label %whileCond160
whileEnd162:
%t41 = load i1, ptr %t16
br i1 %t41, label %if166, label %end165
if166:
ret i1 1
end165:
%t42 = load i32, ptr %t10
%t43 = add i32 %t42, 1
store i32 %t43, ptr %t10
br label %whileCond157
whileEnd159:
ret i1 0
}
define ptr @upperCase (ptr %t0) {
entry:
%t3 = alloca i32
%t4 = alloca ptr
%t7 = alloca i32
%t11 = alloca ptr
%t20 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%t1 = load ptr, ptr %s.addr
%t2 = call i32 @strlen(ptr %t1)
store i32 %t2, ptr %t3
%t5 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t6 = call ptr @_str_dup(ptr %t5)
store ptr %t6, ptr %t4
store i32 0, ptr %t7
br label %whileCond167
whileCond167:
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %t3
%t10 = icmp slt i32 %t8, %t9
br i1 %t10, label %whileBody168, label %whileEnd169
whileBody168:
%t12 = load ptr, ptr %s.addr
%t13 = load i32, ptr %t7
%t14 = getelementptr i8, ptr %t12, i32 %t13
%t15 = load i8, ptr %t14
%t16 = call ptr @_zen_char_to_string(i8 %t15)
store ptr %t16, ptr %t11
%t18 = load ptr, ptr %t11
%t19 = call i32 @_string_to_int_ascii(ptr %t18)
store i32 %t19, ptr %t20
%t22 = load i32, ptr %t20
%t23 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_1, i64 0, i64 0
%t24 = call ptr @_str_dup(ptr %t23)
%t25 = call i32 @_string_to_int_ascii(ptr %t24)
%t27 = load i32, ptr %t20
%t28 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_2, i64 0, i64 0
%t29 = call ptr @_str_dup(ptr %t28)
%t30 = call i32 @_string_to_int_ascii(ptr %t29)
%t26 = icmp sge i32 %t22, %t25
br i1 %t26, label %rhs171, label %skip172
rhs171:
%t31 = icmp sle i32 %t27, %t30
br label %end173
skip172:
br label %end173
end173:
%t21 = phi i1 [ false, %skip172 ], [ %t31, %rhs171 ]
br i1 %t21, label %if174, label %else175
if174:
%t32 = load ptr, ptr %t4
%t33 = load i32, ptr %t20
%t34 = sub i32 %t33, 32
%t35 = call ptr @_int_to_string_ascii(i32 %t34)
%t36 = call ptr @_str_concat(ptr %t32, ptr %t35)
%t38 = load ptr, ptr %t4
call void @_zen_string_free(ptr %t38)
store ptr %t36, ptr %t4
br label %end170
else175:
%t39 = load ptr, ptr %t4
%t40 = load ptr, ptr %t11
%t41 = call ptr @_str_concat(ptr %t39, ptr %t40)
%t43 = load ptr, ptr %t4
call void @_zen_string_free(ptr %t43)
store ptr %t41, ptr %t4
br label %end170
end170:
%t44 = load i32, ptr %t7
%t45 = add i32 %t44, 1
store i32 %t45, ptr %t7
br label %whileCond167
whileEnd169:
%t47 = load ptr, ptr %t4
ret ptr %t47
}
define ptr @lowerCase (ptr %t0) {
entry:
%t3 = alloca i32
%t4 = alloca ptr
%t7 = alloca i32
%t11 = alloca ptr
%t20 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%t1 = load ptr, ptr %s.addr
%t2 = call i32 @strlen(ptr %t1)
store i32 %t2, ptr %t3
%t5 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t6 = call ptr @_str_dup(ptr %t5)
store ptr %t6, ptr %t4
store i32 0, ptr %t7
br label %whileCond176
whileCond176:
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %t3
%t10 = icmp slt i32 %t8, %t9
br i1 %t10, label %whileBody177, label %whileEnd178
whileBody177:
%t12 = load ptr, ptr %s.addr
%t13 = load i32, ptr %t7
%t14 = getelementptr i8, ptr %t12, i32 %t13
%t15 = load i8, ptr %t14
%t16 = call ptr @_zen_char_to_string(i8 %t15)
store ptr %t16, ptr %t11
%t18 = load ptr, ptr %t11
%t19 = call i32 @_string_to_int_ascii(ptr %t18)
store i32 %t19, ptr %t20
%t22 = load i32, ptr %t20
%t23 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_3, i64 0, i64 0
%t24 = call ptr @_str_dup(ptr %t23)
%t25 = call i32 @_string_to_int_ascii(ptr %t24)
%t27 = load i32, ptr %t20
%t28 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_4, i64 0, i64 0
%t29 = call ptr @_str_dup(ptr %t28)
%t30 = call i32 @_string_to_int_ascii(ptr %t29)
%t26 = icmp sge i32 %t22, %t25
br i1 %t26, label %rhs180, label %skip181
rhs180:
%t31 = icmp sle i32 %t27, %t30
br label %end182
skip181:
br label %end182
end182:
%t21 = phi i1 [ false, %skip181 ], [ %t31, %rhs180 ]
br i1 %t21, label %if183, label %else184
if183:
%t32 = load ptr, ptr %t4
%t33 = load i32, ptr %t20
%t34 = add i32 %t33, 32
%t35 = call ptr @_int_to_string_ascii(i32 %t34)
%t36 = call ptr @_str_concat(ptr %t32, ptr %t35)
%t38 = load ptr, ptr %t4
call void @_zen_string_free(ptr %t38)
store ptr %t36, ptr %t4
br label %end179
else184:
%t39 = load ptr, ptr %t4
%t40 = load ptr, ptr %t11
%t41 = call ptr @_str_concat(ptr %t39, ptr %t40)
%t43 = load ptr, ptr %t4
call void @_zen_string_free(ptr %t43)
store ptr %t41, ptr %t4
br label %end179
end179:
%t44 = load i32, ptr %t7
%t45 = add i32 %t44, 1
store i32 %t45, ptr %t7
br label %whileCond176
whileEnd178:
%t47 = load ptr, ptr %t4
ret ptr %t47
}
define i1 @startsWith (ptr %t0, ptr %t1) {
entry:
%t4 = alloca i32
%t7 = alloca i32
%t11 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%prefix.addr = alloca ptr
store ptr %t1, ptr %prefix.addr
%t2 = load ptr, ptr %s.addr
%t3 = call i32 @strlen(ptr %t2)
store i32 %t3, ptr %t4
%t5 = load ptr, ptr %prefix.addr
%t6 = call i32 @strlen(ptr %t5)
store i32 %t6, ptr %t7
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %t4
%t10 = icmp sgt i32 %t8, %t9
br i1 %t10, label %if186, label %end185
if186:
ret i1 0
end185:
store i32 0, ptr %t11
br label %whileCond187
whileCond187:
%t12 = load i32, ptr %t11
%t13 = load i32, ptr %t7
%t14 = icmp slt i32 %t12, %t13
br i1 %t14, label %whileBody188, label %whileEnd189
whileBody188:
%t15 = load ptr, ptr %s.addr
%t16 = load i32, ptr %t11
%t21 = load ptr, ptr %prefix.addr
%t22 = load i32, ptr %t11
%t17 = getelementptr i8, ptr %t15, i32 %t16
%t18 = load i8, ptr %t17
%t19 = call ptr @_zen_char_to_string(i8 %t18)
%t23 = getelementptr i8, ptr %t21, i32 %t22
%t24 = load i8, ptr %t23
%t25 = call ptr @_zen_char_to_string(i8 %t24)
%t27 = call i32 @strcmp(ptr %t19, ptr %t25)
%t28 = icmp ne i32 %t27, 0
br i1 %t28, label %if191, label %end190
if191:
ret i1 0
end190:
%t29 = load i32, ptr %t11
%t30 = add i32 %t29, 1
store i32 %t30, ptr %t11
br label %whileCond187
whileEnd189:
ret i1 1
}
define i1 @endsWith (ptr %t0, ptr %t1) {
entry:
%t4 = alloca i32
%t7 = alloca i32
%t11 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%suffix.addr = alloca ptr
store ptr %t1, ptr %suffix.addr
%t2 = load ptr, ptr %s.addr
%t3 = call i32 @strlen(ptr %t2)
store i32 %t3, ptr %t4
%t5 = load ptr, ptr %suffix.addr
%t6 = call i32 @strlen(ptr %t5)
store i32 %t6, ptr %t7
%t8 = load i32, ptr %t7
%t9 = load i32, ptr %t4
%t10 = icmp sgt i32 %t8, %t9
br i1 %t10, label %if193, label %end192
if193:
ret i1 0
end192:
store i32 0, ptr %t11
br label %whileCond194
whileCond194:
%t12 = load i32, ptr %t11
%t13 = load i32, ptr %t7
%t14 = icmp slt i32 %t12, %t13
br i1 %t14, label %whileBody195, label %whileEnd196
whileBody195:
%t15 = load ptr, ptr %s.addr
%t16 = load i32, ptr %t4
%t17 = load i32, ptr %t7
%t19 = load i32, ptr %t11
%t18 = sub i32 %t16, %t17
%t20 = add i32 %t18, %t19
%t25 = load ptr, ptr %suffix.addr
%t26 = load i32, ptr %t11
%t21 = getelementptr i8, ptr %t15, i32 %t20
%t22 = load i8, ptr %t21
%t23 = call ptr @_zen_char_to_string(i8 %t22)
%t27 = getelementptr i8, ptr %t25, i32 %t26
%t28 = load i8, ptr %t27
%t29 = call ptr @_zen_char_to_string(i8 %t28)
%t31 = call i32 @strcmp(ptr %t23, ptr %t29)
%t32 = icmp ne i32 %t31, 0
br i1 %t32, label %if198, label %end197
if198:
ret i1 0
end197:
%t33 = load i32, ptr %t11
%t34 = add i32 %t33, 1
store i32 %t34, ptr %t11
br label %whileCond194
whileEnd196:
ret i1 1
}
define ptr @trim (ptr %t0) {
entry:
%t3 = alloca i32
%t4 = alloca i32
%t5 = alloca i32
%t11 = alloca ptr
%t41 = alloca ptr
%t68 = alloca ptr
%t71 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%t1 = load ptr, ptr %s.addr
%t2 = call i32 @strlen(ptr %t1)
store i32 %t2, ptr %t3
store i32 0, ptr %t4
%t6 = load i32, ptr %t3
%t7 = sub i32 %t6, 1
store i32 %t7, ptr %t5
br label %whileCond199
whileCond199:
%t8 = load i32, ptr %t4
%t9 = load i32, ptr %t3
%t10 = icmp slt i32 %t8, %t9
br i1 %t10, label %whileBody200, label %whileEnd201
whileBody200:
%t12 = load ptr, ptr %s.addr
%t13 = load i32, ptr %t4
%t14 = getelementptr i8, ptr %t12, i32 %t13
%t15 = load i8, ptr %t14
%t16 = call ptr @_zen_char_to_string(i8 %t15)
store ptr %t16, ptr %t11
%t20 = load ptr, ptr %t11
%t21 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_5, i64 0, i64 0
%t22 = call ptr @_str_dup(ptr %t21)
%t25 = load ptr, ptr %t11
%t26 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_6, i64 0, i64 0
%t27 = call ptr @_str_dup(ptr %t26)
%t30 = load ptr, ptr %t11
%t31 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_7, i64 0, i64 0
%t32 = call ptr @_str_dup(ptr %t31)
%t23 = call i32 @strcmp(ptr %t20, ptr %t22)
%t24 = icmp eq i32 %t23, 0
br i1 %t24, label %skip207, label %rhs206
rhs206:
%t28 = call i32 @strcmp(ptr %t25, ptr %t27)
%t29 = icmp eq i32 %t28, 0
br label %end208
skip207:
br label %end208
end208:
%t19 = phi i1 [ true, %skip207 ], [ %t29, %rhs206 ]
br i1 %t19, label %skip204, label %rhs203
rhs203:
%t33 = call i32 @strcmp(ptr %t30, ptr %t32)
%t34 = icmp eq i32 %t33, 0
br label %end205
skip204:
br label %end205
end205:
%t18 = phi i1 [ true, %skip204 ], [ %t34, %rhs203 ]
br i1 %t18, label %if209, label %else210
if209:
%t35 = load i32, ptr %t4
%t36 = add i32 %t35, 1
store i32 %t36, ptr %t4
br label %end202
else210:
br label %whileEnd201
end202:
br label %whileCond199
whileEnd201:
br label %whileCond211
whileCond211:
%t38 = load i32, ptr %t5
%t39 = load i32, ptr %t4
%t40 = icmp sge i32 %t38, %t39
br i1 %t40, label %whileBody212, label %whileEnd213
whileBody212:
%t42 = load ptr, ptr %s.addr
%t43 = load i32, ptr %t5
%t44 = getelementptr i8, ptr %t42, i32 %t43
%t45 = load i8, ptr %t44
%t46 = call ptr @_zen_char_to_string(i8 %t45)
store ptr %t46, ptr %t41
%t50 = load ptr, ptr %t41
%t51 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_5, i64 0, i64 0
%t52 = call ptr @_str_dup(ptr %t51)
%t55 = load ptr, ptr %t41
%t56 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_6, i64 0, i64 0
%t57 = call ptr @_str_dup(ptr %t56)
%t60 = load ptr, ptr %t41
%t61 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_7, i64 0, i64 0
%t62 = call ptr @_str_dup(ptr %t61)
%t53 = call i32 @strcmp(ptr %t50, ptr %t52)
%t54 = icmp eq i32 %t53, 0
br i1 %t54, label %skip219, label %rhs218
rhs218:
%t58 = call i32 @strcmp(ptr %t55, ptr %t57)
%t59 = icmp eq i32 %t58, 0
br label %end220
skip219:
br label %end220
end220:
%t49 = phi i1 [ true, %skip219 ], [ %t59, %rhs218 ]
br i1 %t49, label %skip216, label %rhs215
rhs215:
%t63 = call i32 @strcmp(ptr %t60, ptr %t62)
%t64 = icmp eq i32 %t63, 0
br label %end217
skip216:
br label %end217
end217:
%t48 = phi i1 [ true, %skip216 ], [ %t64, %rhs215 ]
br i1 %t48, label %if221, label %else222
if221:
%t65 = load i32, ptr %t5
%t66 = sub i32 %t65, 1
store i32 %t66, ptr %t5
br label %end214
else222:
br label %whileEnd213
end214:
br label %whileCond211
whileEnd213:
%t69 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t70 = call ptr @_str_dup(ptr %t69)
store ptr %t70, ptr %t68
%t72 = load i32, ptr %t4
store i32 %t72, ptr %t71
br label %whileCond223
whileCond223:
%t73 = load i32, ptr %t71
%t74 = load i32, ptr %t5
%t75 = icmp sle i32 %t73, %t74
br i1 %t75, label %whileBody224, label %whileEnd225
whileBody224:
%t76 = load ptr, ptr %t68
%t77 = load ptr, ptr %s.addr
%t78 = load i32, ptr %t71
%t79 = getelementptr i8, ptr %t77, i32 %t78
%t80 = load i8, ptr %t79
%t81 = call ptr @_zen_char_to_string(i8 %t80)
%t83 = call ptr @_str_concat(ptr %t76, ptr %t81)
%t85 = load ptr, ptr %t68
call void @_zen_string_free(ptr %t85)
store ptr %t83, ptr %t68
%t86 = load i32, ptr %t71
%t87 = add i32 %t86, 1
store i32 %t87, ptr %t71
br label %whileCond223
whileEnd225:
%t89 = load ptr, ptr %t68
ret ptr %t89
}
define ptr @splitAt (ptr %t0, ptr %t1, i32 %t2) {
entry:
%t5 = alloca i32
%t8 = alloca i32
%t13 = alloca i32
%t14 = alloca i32
%t15 = alloca ptr
%t21 = alloca i1
%t22 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%delim.addr = alloca ptr
store ptr %t1, ptr %delim.addr
%target.addr = alloca i32
store i32 %t2, ptr %target.addr
%t3 = load ptr, ptr %s.addr
%t4 = call i32 @strlen(ptr %t3)
store i32 %t4, ptr %t5
%t6 = load ptr, ptr %delim.addr
%t7 = call i32 @strlen(ptr %t6)
store i32 %t7, ptr %t8
%t9 = load i32, ptr %t8
%t10 = icmp eq i32 %t9, 0
br i1 %t10, label %if227, label %end226
if227:
%t11 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t12 = call ptr @_str_dup(ptr %t11)
ret ptr %t12
end226:
store i32 0, ptr %t13
store i32 0, ptr %t14
%t16 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t17 = call ptr @_str_dup(ptr %t16)
store ptr %t17, ptr %t15
br label %whileCond228
whileCond228:
%t18 = load i32, ptr %t13
%t19 = load i32, ptr %t5
%t20 = icmp slt i32 %t18, %t19
br i1 %t20, label %whileBody229, label %whileEnd230
whileBody229:
store i1 1, ptr %t21
store i32 0, ptr %t22
%t23 = load i32, ptr %t13
%t24 = load i32, ptr %t5
%t25 = load i32, ptr %t8
%t26 = sub i32 %t24, %t25
%t27 = icmp sle i32 %t23, %t26
br i1 %t27, label %if232, label %else233
if232:
br label %whileCond234
whileCond234:
%t28 = load i32, ptr %t22
%t29 = load i32, ptr %t8
%t30 = icmp slt i32 %t28, %t29
br i1 %t30, label %whileBody235, label %whileEnd236
whileBody235:
%t31 = load ptr, ptr %s.addr
%t32 = load i32, ptr %t13
%t33 = load i32, ptr %t22
%t34 = add i32 %t32, %t33
%t39 = load ptr, ptr %delim.addr
%t40 = load i32, ptr %t22
%t35 = getelementptr i8, ptr %t31, i32 %t34
%t36 = load i8, ptr %t35
%t37 = call ptr @_zen_char_to_string(i8 %t36)
%t41 = getelementptr i8, ptr %t39, i32 %t40
%t42 = load i8, ptr %t41
%t43 = call ptr @_zen_char_to_string(i8 %t42)
%t45 = call i32 @strcmp(ptr %t37, ptr %t43)
%t46 = icmp ne i32 %t45, 0
br i1 %t46, label %if238, label %end237
if238:
store i1 0, ptr %t21
br label %end237
end237:
%t48 = load i32, ptr %t22
%t49 = add i32 %t48, 1
store i32 %t49, ptr %t22
br label %whileCond234
whileEnd236:
br label %end231
else233:
store i1 0, ptr %t21
br label %end231
end231:
%t52 = load i1, ptr %t21
br i1 %t52, label %if240, label %else241
if240:
%t53 = load i32, ptr %t14
%t54 = load i32, ptr %target.addr
%t55 = icmp eq i32 %t53, %t54
br i1 %t55, label %if243, label %end242
if243:
%t56 = load ptr, ptr %t15
ret ptr %t56
end242:
%t57 = load i32, ptr %t14
%t58 = add i32 %t57, 1
store i32 %t58, ptr %t14
%t60 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t61 = call ptr @_str_dup(ptr %t60)
%t63 = load ptr, ptr %t15
call void @_zen_string_free(ptr %t63)
store ptr %t61, ptr %t15
%t64 = load i32, ptr %t13
%t65 = load i32, ptr %t8
%t66 = add i32 %t64, %t65
store i32 %t66, ptr %t13
br label %end239
else241:
%t68 = load ptr, ptr %t15
%t69 = load ptr, ptr %s.addr
%t70 = load i32, ptr %t13
%t71 = getelementptr i8, ptr %t69, i32 %t70
%t72 = load i8, ptr %t71
%t73 = call ptr @_zen_char_to_string(i8 %t72)
%t75 = call ptr @_str_concat(ptr %t68, ptr %t73)
%t77 = load ptr, ptr %t15
call void @_zen_string_free(ptr %t77)
store ptr %t75, ptr %t15
%t78 = load i32, ptr %t13
%t79 = add i32 %t78, 1
store i32 %t79, ptr %t13
br label %end239
end239:
br label %whileCond228
whileEnd230:
%t81 = load i32, ptr %t14
%t82 = load i32, ptr %target.addr
%t83 = icmp eq i32 %t81, %t82
br i1 %t83, label %if245, label %end244
if245:
%t84 = load ptr, ptr %t15
ret ptr %t84
end244:
%t85 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t86 = call ptr @_str_dup(ptr %t85)
ret ptr %t86
}
define ptr @repeat (ptr %t0, i32 %t1) {
entry:
%t11 = alloca ptr
%a.addr = alloca ptr
store ptr %t0, ptr %a.addr
%count.addr = alloca i32
store i32 %t1, ptr %count.addr
%t2 = load i32, ptr %count.addr
%t3 = icmp sle i32 %t2, 0
br i1 %t3, label %if247, label %end246
if247:
%t4 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t5 = call ptr @_str_dup(ptr %t4)
ret ptr %t5
end246:
%t6 = load ptr, ptr %a.addr
%t7 = call i32 @strlen(ptr %t6)
%t8 = icmp eq i32 %t7, 0
br i1 %t8, label %if249, label %end248
if249:
%t9 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t10 = call ptr @_str_dup(ptr %t9)
ret ptr %t10
end248:
%t12 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t13 = call ptr @_str_dup(ptr %t12)
store ptr %t13, ptr %t11
br label %whileCond250
whileCond250:
%t14 = load i32, ptr %count.addr
%t15 = icmp slt i32 0, %t14
br i1 %t15, label %whileBody251, label %whileEnd252
whileBody251:
%t16 = load ptr, ptr %t11
%t17 = load ptr, ptr %a.addr
%t18 = call ptr @_str_concat(ptr %t16, ptr %t17)
%t20 = load ptr, ptr %t11
call void @_zen_string_free(ptr %t20)
store ptr %t18, ptr %t11
%t21 = load i32, ptr %count.addr
%t22 = sub i32 %t21, 1
store i32 %t22, ptr %count.addr
br label %whileCond250
whileEnd252:
%t23 = load ptr, ptr %t11
ret ptr %t23
}
define i32 @count (ptr %t0, ptr %t1) {
entry:
%t8 = alloca i32
%t9 = alloca i32
%text.addr = alloca ptr
store ptr %t0, ptr %text.addr
%search.addr = alloca ptr
store ptr %t1, ptr %search.addr
%t2 = load ptr, ptr %text.addr
%t3 = call i32 @strlen(ptr %t2)
%t4 = icmp eq i32 %t3, 0
br i1 %t4, label %if254, label %end253
if254:
ret i32 0
end253:
%t5 = load ptr, ptr %search.addr
%t6 = call i32 @strlen(ptr %t5)
%t7 = icmp eq i32 %t6, 0
br i1 %t7, label %if256, label %end255
if256:
ret i32 0
end255:
store i32 0, ptr %t8
store i32 0, ptr %t9
br label %whileCond257
whileCond257:
%t10 = load i32, ptr %t9
%t11 = load ptr, ptr %text.addr
%t12 = call i32 @strlen(ptr %t11)
%t13 = icmp slt i32 %t10, %t12
br i1 %t13, label %whileBody258, label %whileEnd259
whileBody258:
%t14 = load ptr, ptr %text.addr
%t15 = load i32, ptr %t9
%t17 = load ptr, ptr %search.addr
%t16 = call ptr @charAt(ptr %t14, i32 %t15)
%t18 = call i32 @strcmp(ptr %t16, ptr %t17)
%t19 = icmp eq i32 %t18, 0
br i1 %t19, label %if261, label %end260
if261:
%t20 = load i32, ptr %t8
%t21 = add i32 %t20, 1
store i32 %t21, ptr %t8
br label %end260
end260:
%t22 = load i32, ptr %t9
%t23 = add i32 %t22, 1
store i32 %t23, ptr %t9
br label %whileCond257
whileEnd259:
%t24 = load i32, ptr %t8
ret i32 %t24
}
define ptr @padStart (ptr %t0, i32 %t1, ptr %t2) {
entry:
%t12 = alloca i32
%t17 = alloca ptr
%text.addr = alloca ptr
store ptr %t0, ptr %text.addr
%targetLength.addr = alloca i32
store i32 %t1, ptr %targetLength.addr
%pad.addr = alloca ptr
store ptr %t2, ptr %pad.addr
%t3 = load i32, ptr %targetLength.addr
%t4 = load ptr, ptr %text.addr
%t5 = call i32 @strlen(ptr %t4)
%t6 = icmp sle i32 %t3, %t5
br i1 %t6, label %if263, label %end262
if263:
%t7 = load ptr, ptr %text.addr
ret ptr %t7
end262:
%t8 = load ptr, ptr %pad.addr
%t9 = call i32 @strlen(ptr %t8)
%t10 = icmp eq i32 %t9, 0
br i1 %t10, label %if265, label %end264
if265:
%t11 = load ptr, ptr %text.addr
ret ptr %t11
end264:
%t13 = load i32, ptr %targetLength.addr
%t14 = load ptr, ptr %text.addr
%t15 = call i32 @strlen(ptr %t14)
%t16 = sub i32 %t13, %t15
store i32 %t16, ptr %t12
%t18 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t19 = call ptr @_str_dup(ptr %t18)
store ptr %t19, ptr %t17
br label %whileCond266
whileCond266:
%t20 = load i32, ptr %t12
%t21 = icmp slt i32 0, %t20
br i1 %t21, label %whileBody267, label %whileEnd268
whileBody267:
%t22 = load ptr, ptr %t17
%t23 = load ptr, ptr %pad.addr
%t24 = call ptr @_str_concat(ptr %t22, ptr %t23)
%t26 = load ptr, ptr %t17
call void @_zen_string_free(ptr %t26)
store ptr %t24, ptr %t17
%t27 = load i32, ptr %t12
%t28 = sub i32 %t27, 1
store i32 %t28, ptr %t12
br label %whileCond266
whileEnd268:
%t29 = load ptr, ptr %t17
%t30 = load ptr, ptr %text.addr
%t31 = call ptr @_str_concat(ptr %t29, ptr %t30)
ret ptr %t31
}
define ptr @padEnd (ptr %t0, i32 %t1, ptr %t2) {
entry:
%t12 = alloca i32
%t17 = alloca ptr
%text.addr = alloca ptr
store ptr %t0, ptr %text.addr
%targetLength.addr = alloca i32
store i32 %t1, ptr %targetLength.addr
%pad.addr = alloca ptr
store ptr %t2, ptr %pad.addr
%t3 = load i32, ptr %targetLength.addr
%t4 = load ptr, ptr %text.addr
%t5 = call i32 @strlen(ptr %t4)
%t6 = icmp sle i32 %t3, %t5
br i1 %t6, label %if270, label %end269
if270:
%t7 = load ptr, ptr %text.addr
ret ptr %t7
end269:
%t8 = load ptr, ptr %pad.addr
%t9 = call i32 @strlen(ptr %t8)
%t10 = icmp eq i32 %t9, 0
br i1 %t10, label %if272, label %end271
if272:
%t11 = load ptr, ptr %text.addr
ret ptr %t11
end271:
%t13 = load i32, ptr %targetLength.addr
%t14 = load ptr, ptr %text.addr
%t15 = call i32 @strlen(ptr %t14)
%t16 = sub i32 %t13, %t15
store i32 %t16, ptr %t12
%t18 = load ptr, ptr %text.addr
store ptr %t18, ptr %t17
br label %whileCond273
whileCond273:
%t19 = load i32, ptr %t12
%t20 = icmp slt i32 0, %t19
br i1 %t20, label %whileBody274, label %whileEnd275
whileBody274:
%t21 = load ptr, ptr %t17
%t22 = load ptr, ptr %pad.addr
%t23 = call ptr @_str_concat(ptr %t21, ptr %t22)
%t25 = load ptr, ptr %t17
call void @_zen_string_free(ptr %t25)
store ptr %t23, ptr %t17
%t26 = load i32, ptr %t12
%t27 = sub i32 %t26, 1
store i32 %t27, ptr %t12
br label %whileCond273
whileEnd275:
%t28 = load ptr, ptr %t17
ret ptr %t28
}
define ptr @padCenter (ptr %t0, i32 %t1, ptr %t2) {
entry:
%t12 = alloca i32
%t17 = alloca i32
%t20 = alloca i32
%t24 = alloca ptr
%t27 = alloca ptr
%text.addr = alloca ptr
store ptr %t0, ptr %text.addr
%targetLength.addr = alloca i32
store i32 %t1, ptr %targetLength.addr
%pad.addr = alloca ptr
store ptr %t2, ptr %pad.addr
%t3 = load i32, ptr %targetLength.addr
%t4 = load ptr, ptr %text.addr
%t5 = call i32 @strlen(ptr %t4)
%t6 = icmp sle i32 %t3, %t5
br i1 %t6, label %if277, label %end276
if277:
%t7 = load ptr, ptr %text.addr
ret ptr %t7
end276:
%t8 = load ptr, ptr %pad.addr
%t9 = call i32 @strlen(ptr %t8)
%t10 = icmp eq i32 %t9, 0
br i1 %t10, label %if279, label %end278
if279:
%t11 = load ptr, ptr %text.addr
ret ptr %t11
end278:
%t13 = load i32, ptr %targetLength.addr
%t14 = load ptr, ptr %text.addr
%t15 = call i32 @strlen(ptr %t14)
%t16 = sub i32 %t13, %t15
store i32 %t16, ptr %t12
%t18 = load i32, ptr %t12
%t19 = sdiv i32 %t18, 2
store i32 %t19, ptr %t17
%t21 = load i32, ptr %t12
%t22 = load i32, ptr %t17
%t23 = sub i32 %t21, %t22
store i32 %t23, ptr %t20
%t25 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t26 = call ptr @_str_dup(ptr %t25)
store ptr %t26, ptr %t24
%t28 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t29 = call ptr @_str_dup(ptr %t28)
store ptr %t29, ptr %t27
br label %whileCond280
whileCond280:
%t30 = load i32, ptr %t17
%t31 = icmp slt i32 0, %t30
br i1 %t31, label %whileBody281, label %whileEnd282
whileBody281:
%t32 = load ptr, ptr %t24
%t33 = load ptr, ptr %pad.addr
%t34 = call ptr @_str_concat(ptr %t32, ptr %t33)
%t36 = load ptr, ptr %t24
call void @_zen_string_free(ptr %t36)
store ptr %t34, ptr %t24
%t37 = load i32, ptr %t17
%t38 = sub i32 %t37, 1
store i32 %t38, ptr %t17
br label %whileCond280
whileEnd282:
br label %whileCond283
whileCond283:
%t39 = load i32, ptr %t20
%t40 = icmp slt i32 0, %t39
br i1 %t40, label %whileBody284, label %whileEnd285
whileBody284:
%t41 = load ptr, ptr %t27
%t42 = load ptr, ptr %pad.addr
%t43 = call ptr @_str_concat(ptr %t41, ptr %t42)
%t45 = load ptr, ptr %t27
call void @_zen_string_free(ptr %t45)
store ptr %t43, ptr %t27
%t46 = load i32, ptr %t20
%t47 = sub i32 %t46, 1
store i32 %t47, ptr %t20
br label %whileCond283
whileEnd285:
%t48 = load ptr, ptr %t24
%t49 = load ptr, ptr %text.addr
%t51 = load ptr, ptr %t27
%t50 = call ptr @_str_concat(ptr %t48, ptr %t49)
%t52 = call ptr @_str_concat(ptr %t50, ptr %t51)
call void @_zen_string_free(ptr %t50)
ret ptr %t52
}
define ptr @capitalize (ptr %t0) {
entry:
%t6 = alloca ptr
%t14 = alloca i32
%t15 = alloca ptr
%t41 = alloca i32
%t44 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%t1 = load ptr, ptr %s.addr
%t2 = call i32 @strlen(ptr %t1)
%t3 = icmp eq i32 %t2, 0
br i1 %t3, label %if287, label %end286
if287:
%t4 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t5 = call ptr @_str_dup(ptr %t4)
ret ptr %t5
end286:
%t7 = load ptr, ptr %s.addr
%t8 = getelementptr i8, ptr %t7, i32 0
%t9 = load i8, ptr %t8
%t10 = call ptr @_zen_char_to_string(i8 %t9)
store ptr %t10, ptr %t6
%t12 = load ptr, ptr %t6
%t13 = call i32 @_string_to_int_ascii(ptr %t12)
store i32 %t13, ptr %t14
%t16 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t17 = call ptr @_str_dup(ptr %t16)
store ptr %t17, ptr %t15
%t19 = load i32, ptr %t14
%t20 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_1, i64 0, i64 0
%t21 = call ptr @_str_dup(ptr %t20)
%t22 = call i32 @_string_to_int_ascii(ptr %t21)
%t24 = load i32, ptr %t14
%t25 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_2, i64 0, i64 0
%t26 = call ptr @_str_dup(ptr %t25)
%t27 = call i32 @_string_to_int_ascii(ptr %t26)
%t23 = icmp sge i32 %t19, %t22
br i1 %t23, label %rhs289, label %skip290
rhs289:
%t28 = icmp sle i32 %t24, %t27
br label %end291
skip290:
br label %end291
end291:
%t18 = phi i1 [ false, %skip290 ], [ %t28, %rhs289 ]
br i1 %t18, label %if292, label %else293
if292:
%t29 = load ptr, ptr %t15
%t30 = load i32, ptr %t14
%t31 = sub i32 %t30, 32
%t32 = call ptr @_int_to_string_ascii(i32 %t31)
%t33 = call ptr @_str_concat(ptr %t29, ptr %t32)
%t35 = load ptr, ptr %t15
call void @_zen_string_free(ptr %t35)
store ptr %t33, ptr %t15
br label %end288
else293:
%t36 = load ptr, ptr %t15
%t37 = load ptr, ptr %t6
%t38 = call ptr @_str_concat(ptr %t36, ptr %t37)
%t40 = load ptr, ptr %t15
call void @_zen_string_free(ptr %t40)
store ptr %t38, ptr %t15
br label %end288
end288:
store i32 1, ptr %t41
%t42 = load ptr, ptr %s.addr
%t43 = call i32 @strlen(ptr %t42)
store i32 %t43, ptr %t44
br label %whileCond294
whileCond294:
%t45 = load i32, ptr %t41
%t46 = load i32, ptr %t44
%t47 = icmp slt i32 %t45, %t46
br i1 %t47, label %whileBody295, label %whileEnd296
whileBody295:
%t48 = load ptr, ptr %t15
%t49 = load ptr, ptr %s.addr
%t50 = load i32, ptr %t41
%t51 = getelementptr i8, ptr %t49, i32 %t50
%t52 = load i8, ptr %t51
%t53 = call ptr @_zen_char_to_string(i8 %t52)
%t55 = call ptr @_str_concat(ptr %t48, ptr %t53)
%t57 = load ptr, ptr %t15
call void @_zen_string_free(ptr %t57)
store ptr %t55, ptr %t15
%t58 = load i32, ptr %t41
%t59 = add i32 %t58, 1
store i32 %t59, ptr %t41
br label %whileCond294
whileEnd296:
%t61 = load ptr, ptr %t15
ret ptr %t61
}
define ptr @extName (ptr %t0) {
entry:
%t3 = alloca i32
%t4 = alloca i32
%t19 = alloca i32
%t22 = alloca ptr
%path.addr = alloca ptr
store ptr %t0, ptr %path.addr
%t1 = load ptr, ptr %path.addr
%t2 = call i32 @strlen(ptr %t1)
store i32 %t2, ptr %t3
%t5 = load i32, ptr %t3
%t6 = sub i32 %t5, 1
store i32 %t6, ptr %t4
br label %whileCond297
whileCond297:
%t7 = load i32, ptr %t4
%t8 = icmp sge i32 %t7, 0
br i1 %t8, label %whileBody298, label %whileEnd299
whileBody298:
%t9 = load ptr, ptr %path.addr
%t10 = load i32, ptr %t4
%t15 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_8, i64 0, i64 0
%t16 = call ptr @_str_dup(ptr %t15)
%t11 = getelementptr i8, ptr %t9, i32 %t10
%t12 = load i8, ptr %t11
%t13 = call ptr @_zen_char_to_string(i8 %t12)
%t17 = call i32 @strcmp(ptr %t13, ptr %t16)
%t18 = icmp eq i32 %t17, 0
br i1 %t18, label %if301, label %end300
if301:
%t20 = load i32, ptr %t4
%t21 = add i32 %t20, 1
store i32 %t21, ptr %t19
%t23 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t24 = call ptr @_str_dup(ptr %t23)
store ptr %t24, ptr %t22
br label %whileCond302
whileCond302:
%t25 = load i32, ptr %t19
%t26 = load i32, ptr %t3
%t27 = icmp slt i32 %t25, %t26
br i1 %t27, label %whileBody303, label %whileEnd304
whileBody303:
%t28 = load ptr, ptr %t22
%t29 = load ptr, ptr %path.addr
%t30 = load i32, ptr %t19
%t31 = getelementptr i8, ptr %t29, i32 %t30
%t32 = load i8, ptr %t31
%t33 = call ptr @_zen_char_to_string(i8 %t32)
%t35 = call ptr @_str_concat(ptr %t28, ptr %t33)
%t37 = load ptr, ptr %t22
call void @_zen_string_free(ptr %t37)
store ptr %t35, ptr %t22
%t38 = load i32, ptr %t19
%t39 = add i32 %t38, 1
store i32 %t39, ptr %t19
br label %whileCond302
whileEnd304:
%t41 = load ptr, ptr %t22
ret ptr %t41
end300:
%t42 = load i32, ptr %t4
%t43 = sub i32 %t42, 1
store i32 %t43, ptr %t4
br label %whileCond297
whileEnd299:
%t45 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t46 = call ptr @_str_dup(ptr %t45)
ret ptr %t46
}
define double @sin (double %t0) {
entry:

%x.addr = alloca double
store double %t0, ptr %x.addr
br label %whileCond305
whileCond305:
%t1 = load double, ptr %x.addr
%t2 = load double, ptr @PI
%t3 = fcmp ogt double %t1, %t2
br i1 %t3, label %whileBody306, label %whileEnd307
whileBody306:
%t4 = load double, ptr %x.addr
%t5 = load double, ptr @TAU
%t6 = fsub double %t4, %t5
store double %t6, ptr %x.addr
br label %whileCond305
whileEnd307:
br label %whileCond308
whileCond308:
%t8 = load double, ptr %x.addr
%t9 = load double, ptr @PI
%t10 = fsub double 0.0, %t9
%t11 = fcmp olt double %t8, %t10
br i1 %t11, label %whileBody309, label %whileEnd310
whileBody309:
%t12 = load double, ptr %x.addr
%t13 = load double, ptr @TAU
%t14 = fadd double %t12, %t13
store double %t14, ptr %x.addr
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
store double %t0, ptr %x.addr
br label %whileCond311
whileCond311:
%t1 = load double, ptr %x.addr
%t2 = load double, ptr @PI
%t3 = fcmp ogt double %t1, %t2
br i1 %t3, label %whileBody312, label %whileEnd313
whileBody312:
%t4 = load double, ptr %x.addr
%t5 = load double, ptr @TAU
%t6 = fsub double %t4, %t5
store double %t6, ptr %x.addr
br label %whileCond311
whileEnd313:
br label %whileCond314
whileCond314:
%t8 = load double, ptr %x.addr
%t9 = load double, ptr @PI
%t10 = fsub double 0.0, %t9
%t11 = fcmp olt double %t8, %t10
br i1 %t11, label %whileBody315, label %whileEnd316
whileBody315:
%t12 = load double, ptr %x.addr
%t13 = load double, ptr @TAU
%t14 = fadd double %t12, %t13
store double %t14, ptr %x.addr
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
%t3 = alloca double
%t6 = alloca double
%x.addr = alloca double
store double %t0, ptr %x.addr
%t1 = load double, ptr %x.addr
%t2 = call double @sin(double %t1)
store double %t2, ptr %t3
%t4 = load double, ptr %x.addr
%t5 = call double @cos(double %t4)
store double %t5, ptr %t6
%t7 = load double, ptr %t3
%t8 = load double, ptr %t6
%t9 = fdiv double %t7, %t8
ret double %t9
}
define double @log (double %t0) {
entry:
%t1 = alloca double
%t3 = alloca i32
%x.addr = alloca double
store double %t0, ptr %x.addr
%t2 = load double, ptr %x.addr
store double %t2, ptr %t1
store i32 0, ptr %t3
br label %whileCond317
whileCond317:
%t4 = load i32, ptr %t3
%t5 = icmp slt i32 %t4, 10
br i1 %t5, label %whileBody318, label %whileEnd319
whileBody318:
%t6 = load double, ptr %t1
%t8 = load double, ptr %x.addr
%t9 = load double, ptr %t1
%t7 = fsub double %t6, 1.0
%t10 = fdiv double %t8, %t9
%t11 = fadd double %t7, %t10
store double %t11, ptr %t1
%t13 = load i32, ptr %t3
%t14 = add i32 %t13, 1
store i32 %t14, ptr %t3
br label %whileCond317
whileEnd319:
%t16 = load double, ptr %t1
ret double %t16
}
define double @exp (double %t0) {
entry:
%t1 = alloca double
%t2 = alloca double
%t3 = alloca i32
%x.addr = alloca double
store double %t0, ptr %x.addr
store double 1.0, ptr %t1
store double 1.0, ptr %t2
store i32 1, ptr %t3
br label %whileCond320
whileCond320:
%t4 = load i32, ptr %t3
%t5 = icmp slt i32 %t4, 10
br i1 %t5, label %whileBody321, label %whileEnd322
whileBody321:
%t6 = load double, ptr %t2
%t7 = load double, ptr %x.addr
%t9 = load i32, ptr %t3
%t8 = fmul double %t6, %t7
%t10 = sitofp i32 %t9 to double
%t11 = fdiv double %t8, %t10
store double %t11, ptr %t2
%t13 = load double, ptr %t1
%t14 = load double, ptr %t2
%t15 = fadd double %t13, %t14
store double %t15, ptr %t1
%t17 = load i32, ptr %t3
%t18 = add i32 %t17, 1
store i32 %t18, ptr %t3
br label %whileCond320
whileEnd322:
%t20 = load double, ptr %t1
ret double %t20
}
define i32 @randomInt (i32 %t0, i32 %t1) {
entry:
%t3 = alloca double
%a.addr = alloca i32
store i32 %t0, ptr %a.addr
%b.addr = alloca i32
store i32 %t1, ptr %b.addr
%t2 = call double @random()
store double %t2, ptr %t3
%t4 = load i32, ptr %a.addr
%t5 = load double, ptr %t3
%t6 = load i32, ptr %b.addr
%t7 = load i32, ptr %a.addr
%t8 = sub i32 %t6, %t7
%t9 = add i32 %t8, 1
%t10 = sitofp i32 %t9 to double
%t11 = fmul double %t5, %t10
%t12 = fptosi double %t11 to i32
%t13 = add i32 %t4, %t12
ret i32 %t13
}
define double @random () {
entry:


%t0 = load i32, ptr @SEED
%t3 = load i32, ptr @I32_MAX
%t1 = mul i32 %t0, 1103515245
%t2 = add i32 %t1, 12345
%t4 = srem i32 %t2, %t3
store i32 %t4, ptr @SEED
%t6 = load i32, ptr @SEED
%t7 = icmp slt i32 %t6, 0
br i1 %t7, label %if324, label %end323
if324:
%t8 = load i32, ptr @SEED
%t9 = load i32, ptr @I32_MAX
%t10 = add i32 %t8, %t9
store i32 %t10, ptr @SEED
br label %end323
end323:
%t12 = load i32, ptr @SEED
%t13 = sitofp i32 %t12 to double
%t14 = fdiv double %t13, 2147483647.0
ret double %t14
}
define i1 @match (ptr %t0, ptr %t1) {
entry:
%t6 = alloca ptr
%t9 = alloca i32
%t17 = alloca ptr
%t41 = alloca i32
%t42 = alloca i32
%t50 = alloca ptr
%t76 = alloca i32
%t87 = alloca ptr
%t94 = alloca ptr
%t110 = alloca ptr
%t123 = alloca ptr
%t153 = alloca ptr
%t177 = alloca ptr
%t201 = alloca ptr
%t224 = alloca ptr
%t227 = alloca i32
%t236 = alloca ptr
%t261 = alloca i32
%t282 = alloca i32
%t291 = alloca ptr
%t325 = alloca ptr
%t366 = alloca ptr
%t430 = alloca i32
%t452 = alloca ptr
%t460 = alloca ptr
%t461 = alloca i1
%t474 = alloca ptr
%t477 = alloca ptr
%t488 = alloca i32
%t496 = alloca ptr
%text.addr = alloca ptr
store ptr %t0, ptr %text.addr
%pattern.addr = alloca ptr
store ptr %t1, ptr %pattern.addr
%t2 = load ptr, ptr %pattern.addr
%t3 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_9, i64 0, i64 0
%t4 = call ptr @_str_dup(ptr %t3)
%t5 = call i1 @contains(ptr %t2, ptr %t4)
br i1 %t5, label %if326, label %end325
if326:
%t7 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t8 = call ptr @_str_dup(ptr %t7)
store ptr %t8, ptr %t6
store i32 0, ptr %t9
br label %whileCond327
whileCond327:
%t10 = load i32, ptr %t9
%t11 = load ptr, ptr %pattern.addr
%t12 = call i32 @strlen(ptr %t11)
%t13 = icmp slt i32 %t10, %t12
br i1 %t13, label %whileBody328, label %whileEnd329
whileBody328:
%t14 = load ptr, ptr %pattern.addr
%t15 = load i32, ptr %t9
%t16 = call ptr @charAt(ptr %t14, i32 %t15)
store ptr %t16, ptr %t17
%t18 = load ptr, ptr %t17
%t19 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_9, i64 0, i64 0
%t20 = call ptr @_str_dup(ptr %t19)
%t21 = call i32 @strcmp(ptr %t18, ptr %t20)
%t22 = icmp eq i32 %t21, 0
br i1 %t22, label %if331, label %else332
if331:
%t23 = load ptr, ptr %text.addr
%t24 = load ptr, ptr %t6
%t25 = call i1 @match(ptr %t23, ptr %t24)
br i1 %t25, label %if334, label %end333
if334:
ret i1 1
end333:
%t26 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t27 = call ptr @_str_dup(ptr %t26)
%t29 = load ptr, ptr %t6
call void @_zen_string_free(ptr %t29)
store ptr %t27, ptr %t6
br label %end330
else332:
%t30 = load ptr, ptr %t6
%t31 = load ptr, ptr %t17
%t32 = call ptr @_str_concat(ptr %t30, ptr %t31)
%t34 = load ptr, ptr %t6
call void @_zen_string_free(ptr %t34)
store ptr %t32, ptr %t6
br label %end330
end330:
%t35 = load i32, ptr %t9
%t36 = add i32 %t35, 1
store i32 %t36, ptr %t9
br label %whileCond327
whileEnd329:
%t38 = load ptr, ptr %text.addr
%t39 = load ptr, ptr %t6
%t40 = call i1 @match(ptr %t38, ptr %t39)
ret i1 %t40
end325:
store i32 0, ptr %t41
store i32 0, ptr %t42
br label %whileCond335
whileCond335:
%t43 = load i32, ptr %t42
%t44 = load ptr, ptr %pattern.addr
%t45 = call i32 @strlen(ptr %t44)
%t46 = icmp slt i32 %t43, %t45
br i1 %t46, label %whileBody336, label %whileEnd337
whileBody336:
%t47 = load ptr, ptr %pattern.addr
%t48 = load i32, ptr %t42
%t49 = call ptr @charAt(ptr %t47, i32 %t48)
store ptr %t49, ptr %t50
%t51 = load ptr, ptr %t50
%t52 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_10, i64 0, i64 0
%t53 = call ptr @_str_dup(ptr %t52)
%t54 = call i32 @strcmp(ptr %t51, ptr %t53)
%t55 = icmp eq i32 %t54, 0
br i1 %t55, label %if339, label %end338
if339:
%t56 = load i32, ptr %t41
%t57 = load ptr, ptr %text.addr
%t58 = call i32 @strlen(ptr %t57)
%t59 = icmp sge i32 %t56, %t58
br i1 %t59, label %if341, label %end340
if341:
ret i1 0
end340:
%t60 = load i32, ptr %t41
%t61 = add i32 %t60, 1
store i32 %t61, ptr %t41
%t63 = load i32, ptr %t42
%t64 = add i32 %t63, 1
store i32 %t64, ptr %t42
br label %whileCond335
end338:
%t66 = load ptr, ptr %t50
%t67 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_11, i64 0, i64 0
%t68 = call ptr @_str_dup(ptr %t67)
%t69 = call i32 @strcmp(ptr %t66, ptr %t68)
%t70 = icmp eq i32 %t69, 0
br i1 %t70, label %if343, label %end342
if343:
%t71 = load i32, ptr %t42
%t73 = load ptr, ptr %pattern.addr
%t74 = call i32 @strlen(ptr %t73)
%t72 = add i32 %t71, 1
%t75 = icmp sge i32 %t72, %t74
br i1 %t75, label %if345, label %end344
if345:
ret i1 1
end344:
%t77 = load i32, ptr %t41
store i32 %t77, ptr %t76
br label %whileCond346
whileCond346:
%t78 = load i32, ptr %t76
%t79 = load ptr, ptr %text.addr
%t80 = call i32 @strlen(ptr %t79)
%t81 = icmp sle i32 %t78, %t80
br i1 %t81, label %whileBody347, label %whileEnd348
whileBody347:
%t82 = load ptr, ptr %text.addr
%t83 = load i32, ptr %t76
%t84 = load ptr, ptr %text.addr
%t85 = call i32 @strlen(ptr %t84)
%t86 = call ptr @slice(ptr %t82, i32 %t83, i32 %t85)
store ptr %t86, ptr %t87
%t88 = load ptr, ptr %pattern.addr
%t89 = load i32, ptr %t42
%t90 = add i32 %t89, 1
%t91 = load ptr, ptr %pattern.addr
%t92 = call i32 @strlen(ptr %t91)
%t93 = call ptr @slice(ptr %t88, i32 %t90, i32 %t92)
store ptr %t93, ptr %t94
%t95 = load ptr, ptr %t87
%t96 = load ptr, ptr %t94
%t97 = call i1 @match(ptr %t95, ptr %t96)
br i1 %t97, label %if350, label %end349
if350:
ret i1 1
end349:
%t98 = load i32, ptr %t76
%t99 = add i32 %t98, 1
store i32 %t99, ptr %t76
br label %whileCond346
whileEnd348:
ret i1 0
end342:
%t101 = load ptr, ptr %t50
%t102 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_12, i64 0, i64 0
%t103 = call ptr @_str_dup(ptr %t102)
%t104 = call i32 @strcmp(ptr %t101, ptr %t103)
%t105 = icmp eq i32 %t104, 0
br i1 %t105, label %if352, label %end351
if352:
%t106 = load ptr, ptr %pattern.addr
%t107 = load i32, ptr %t42
%t108 = add i32 %t107, 1
%t109 = call ptr @charAt(ptr %t106, i32 %t108)
store ptr %t109, ptr %t110
%t111 = load ptr, ptr %t110
%t112 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_13, i64 0, i64 0
%t113 = call ptr @_str_dup(ptr %t112)
%t114 = call i32 @strcmp(ptr %t111, ptr %t113)
%t115 = icmp eq i32 %t114, 0
br i1 %t115, label %if354, label %end353
if354:
%t116 = load i32, ptr %t41
%t117 = load ptr, ptr %text.addr
%t118 = call i32 @strlen(ptr %t117)
%t119 = icmp sge i32 %t116, %t118
br i1 %t119, label %if356, label %end355
if356:
ret i1 0
end355:
%t120 = load ptr, ptr %text.addr
%t121 = load i32, ptr %t41
%t122 = call ptr @charAt(ptr %t120, i32 %t121)
store ptr %t122, ptr %t123
%t125 = load ptr, ptr %t123
%t126 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_14, i64 0, i64 0
%t127 = call ptr @_str_dup(ptr %t126)
%t130 = load ptr, ptr %t123
%t131 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_15, i64 0, i64 0
%t132 = call ptr @_str_dup(ptr %t131)
%t128 = call i32 @strcmp(ptr %t125, ptr %t127)
%t129 = icmp slt i32 %t128, 0
br i1 %t129, label %skip359, label %rhs358
rhs358:
%t133 = call i32 @strcmp(ptr %t130, ptr %t132)
%t134 = icmp sgt i32 %t133, 0
br label %end360
skip359:
br label %end360
end360:
%t124 = phi i1 [ true, %skip359 ], [ %t134, %rhs358 ]
br i1 %t124, label %if361, label %end357
if361:
ret i1 0
end357:
%t135 = load i32, ptr %t41
%t136 = add i32 %t135, 1
store i32 %t136, ptr %t41
%t138 = load i32, ptr %t42
%t139 = add i32 %t138, 2
store i32 %t139, ptr %t42
br label %whileCond335
end353:
%t141 = load ptr, ptr %t110
%t142 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_1, i64 0, i64 0
%t143 = call ptr @_str_dup(ptr %t142)
%t144 = call i32 @strcmp(ptr %t141, ptr %t143)
%t145 = icmp eq i32 %t144, 0
br i1 %t145, label %if363, label %end362
if363:
%t146 = load i32, ptr %t41
%t147 = load ptr, ptr %text.addr
%t148 = call i32 @strlen(ptr %t147)
%t149 = icmp sge i32 %t146, %t148
br i1 %t149, label %if365, label %end364
if365:
ret i1 0
end364:
%t150 = load ptr, ptr %text.addr
%t151 = load i32, ptr %t41
%t152 = call ptr @charAt(ptr %t150, i32 %t151)
store ptr %t152, ptr %t153
%t154 = getelementptr inbounds [53 x i8], ptr @.str_stdlib_stdlib_16, i64 0, i64 0
%t155 = call ptr @_str_dup(ptr %t154)
%t156 = load ptr, ptr %t153
%t157 = call i1 @contains(ptr %t155, ptr %t156)
%t158 = xor i1 %t157, true
br i1 %t158, label %if367, label %end366
if367:
ret i1 0
end366:
%t159 = load i32, ptr %t41
%t160 = add i32 %t159, 1
store i32 %t160, ptr %t41
%t162 = load i32, ptr %t42
%t163 = add i32 %t162, 2
store i32 %t163, ptr %t42
br label %whileCond335
end362:
%t165 = load ptr, ptr %t110
%t166 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_17, i64 0, i64 0
%t167 = call ptr @_str_dup(ptr %t166)
%t168 = call i32 @strcmp(ptr %t165, ptr %t167)
%t169 = icmp eq i32 %t168, 0
br i1 %t169, label %if369, label %end368
if369:
%t170 = load i32, ptr %t41
%t171 = load ptr, ptr %text.addr
%t172 = call i32 @strlen(ptr %t171)
%t173 = icmp sge i32 %t170, %t172
br i1 %t173, label %if371, label %end370
if371:
ret i1 0
end370:
%t174 = load ptr, ptr %text.addr
%t175 = load i32, ptr %t41
%t176 = call ptr @charAt(ptr %t174, i32 %t175)
store ptr %t176, ptr %t177
%t178 = getelementptr inbounds [63 x i8], ptr @.str_stdlib_stdlib_18, i64 0, i64 0
%t179 = call ptr @_str_dup(ptr %t178)
%t180 = load ptr, ptr %t177
%t181 = call i1 @contains(ptr %t179, ptr %t180)
%t182 = xor i1 %t181, true
br i1 %t182, label %if373, label %end372
if373:
ret i1 0
end372:
%t183 = load i32, ptr %t41
%t184 = add i32 %t183, 1
store i32 %t184, ptr %t41
%t186 = load i32, ptr %t42
%t187 = add i32 %t186, 2
store i32 %t187, ptr %t42
br label %whileCond335
end368:
%t189 = load ptr, ptr %t110
%t190 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_19, i64 0, i64 0
%t191 = call ptr @_str_dup(ptr %t190)
%t192 = call i32 @strcmp(ptr %t189, ptr %t191)
%t193 = icmp eq i32 %t192, 0
br i1 %t193, label %if375, label %end374
if375:
%t194 = load i32, ptr %t41
%t195 = load ptr, ptr %text.addr
%t196 = call i32 @strlen(ptr %t195)
%t197 = icmp sge i32 %t194, %t196
br i1 %t197, label %if377, label %end376
if377:
ret i1 0
end376:
%t198 = load ptr, ptr %text.addr
%t199 = load i32, ptr %t41
%t200 = call ptr @charAt(ptr %t198, i32 %t199)
store ptr %t200, ptr %t201
%t203 = load ptr, ptr %t201
%t204 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_5, i64 0, i64 0
%t205 = call ptr @_str_dup(ptr %t204)
%t208 = load ptr, ptr %t201
%t209 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_7, i64 0, i64 0
%t210 = call ptr @_str_dup(ptr %t209)
%t206 = call i32 @strcmp(ptr %t203, ptr %t205)
%t207 = icmp ne i32 %t206, 0
br i1 %t207, label %rhs379, label %skip380
rhs379:
%t211 = call i32 @strcmp(ptr %t208, ptr %t210)
%t212 = icmp ne i32 %t211, 0
br label %end381
skip380:
br label %end381
end381:
%t202 = phi i1 [ false, %skip380 ], [ %t212, %rhs379 ]
br i1 %t202, label %if382, label %end378
if382:
ret i1 0
end378:
%t213 = load i32, ptr %t41
%t214 = add i32 %t213, 1
store i32 %t214, ptr %t41
%t216 = load i32, ptr %t42
%t217 = add i32 %t216, 2
store i32 %t217, ptr %t42
br label %whileCond335
end374:
br label %end351
end351:
%t219 = load ptr, ptr %t50
%t220 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_20, i64 0, i64 0
%t221 = call ptr @_str_dup(ptr %t220)
%t222 = call i32 @strcmp(ptr %t219, ptr %t221)
%t223 = icmp eq i32 %t222, 0
br i1 %t223, label %if384, label %end383
if384:
%t225 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t226 = call ptr @_str_dup(ptr %t225)
store ptr %t226, ptr %t224
%t228 = load i32, ptr %t42
store i32 %t228, ptr %t227
br label %whileCond385
whileCond385:
%t229 = load i32, ptr %t227
%t230 = load ptr, ptr %pattern.addr
%t231 = call i32 @strlen(ptr %t230)
%t232 = icmp slt i32 %t229, %t231
br i1 %t232, label %whileBody386, label %whileEnd387
whileBody386:
%t233 = load ptr, ptr %pattern.addr
%t234 = load i32, ptr %t227
%t235 = call ptr @charAt(ptr %t233, i32 %t234)
store ptr %t235, ptr %t236
%t238 = load ptr, ptr %t236
%t239 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_5, i64 0, i64 0
%t240 = call ptr @_str_dup(ptr %t239)
%t243 = load ptr, ptr %t236
%t244 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_9, i64 0, i64 0
%t245 = call ptr @_str_dup(ptr %t244)
%t241 = call i32 @strcmp(ptr %t238, ptr %t240)
%t242 = icmp eq i32 %t241, 0
br i1 %t242, label %skip390, label %rhs389
rhs389:
%t246 = call i32 @strcmp(ptr %t243, ptr %t245)
%t247 = icmp eq i32 %t246, 0
br label %end391
skip390:
br label %end391
end391:
%t237 = phi i1 [ true, %skip390 ], [ %t247, %rhs389 ]
br i1 %t237, label %if392, label %end388
if392:
br label %whileEnd387
end388:
%t248 = load ptr, ptr %t224
%t249 = load ptr, ptr %t236
%t250 = call ptr @_str_concat(ptr %t248, ptr %t249)
%t252 = load ptr, ptr %t224
call void @_zen_string_free(ptr %t252)
store ptr %t250, ptr %t224
%t253 = load i32, ptr %t227
%t254 = add i32 %t253, 1
store i32 %t254, ptr %t227
br label %whileCond385
whileEnd387:
%t256 = load ptr, ptr %t224
%t257 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_21, i64 0, i64 0
%t258 = call ptr @_str_dup(ptr %t257)
%t259 = call i32 @strcmp(ptr %t256, ptr %t258)
%t260 = icmp eq i32 %t259, 0
br i1 %t260, label %if394, label %end393
if394:
%t262 = load i32, ptr %t41
store i32 %t262, ptr %t261
%t264 = load i32, ptr %t41
%t265 = load ptr, ptr %text.addr
%t266 = call i32 @strlen(ptr %t265)
%t268 = load ptr, ptr %text.addr
%t269 = load i32, ptr %t41
%t271 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_22, i64 0, i64 0
%t272 = call ptr @_str_dup(ptr %t271)
%t267 = icmp slt i32 %t264, %t266
br i1 %t267, label %rhs396, label %skip397
rhs396:
%t270 = call ptr @charAt(ptr %t268, i32 %t269)
%t273 = call i32 @strcmp(ptr %t270, ptr %t272)
%t274 = icmp eq i32 %t273, 0
br label %end398
skip397:
br label %end398
end398:
%t263 = phi i1 [ false, %skip397 ], [ %t274, %rhs396 ]
br i1 %t263, label %if399, label %end395
if399:
%t275 = load i32, ptr %t41
%t276 = add i32 %t275, 1
store i32 %t276, ptr %t41
br label %end395
end395:
%t278 = load i32, ptr %t41
%t279 = load ptr, ptr %text.addr
%t280 = call i32 @strlen(ptr %t279)
%t281 = icmp sge i32 %t278, %t280
br i1 %t281, label %if401, label %end400
if401:
ret i1 0
end400:
%t283 = load i32, ptr %t41
store i32 %t283, ptr %t282
br label %whileCond402
whileCond402:
%t284 = load i32, ptr %t41
%t285 = load ptr, ptr %text.addr
%t286 = call i32 @strlen(ptr %t285)
%t287 = icmp slt i32 %t284, %t286
br i1 %t287, label %whileBody403, label %whileEnd404
whileBody403:
%t288 = load ptr, ptr %text.addr
%t289 = load i32, ptr %t41
%t290 = call ptr @charAt(ptr %t288, i32 %t289)
store ptr %t290, ptr %t291
%t293 = load ptr, ptr %t291
%t294 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_14, i64 0, i64 0
%t295 = call ptr @_str_dup(ptr %t294)
%t298 = load ptr, ptr %t291
%t299 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_15, i64 0, i64 0
%t300 = call ptr @_str_dup(ptr %t299)
%t296 = call i32 @strcmp(ptr %t293, ptr %t295)
%t297 = icmp slt i32 %t296, 0
br i1 %t297, label %skip407, label %rhs406
rhs406:
%t301 = call i32 @strcmp(ptr %t298, ptr %t300)
%t302 = icmp sgt i32 %t301, 0
br label %end408
skip407:
br label %end408
end408:
%t292 = phi i1 [ true, %skip407 ], [ %t302, %rhs406 ]
br i1 %t292, label %if409, label %end405
if409:
br label %whileEnd404
end405:
%t303 = load i32, ptr %t41
%t304 = add i32 %t303, 1
store i32 %t304, ptr %t41
br label %whileCond402
whileEnd404:
%t306 = load i32, ptr %t41
%t307 = load i32, ptr %t282
%t308 = icmp sle i32 %t306, %t307
br i1 %t308, label %if411, label %end410
if411:
ret i1 0
end410:
%t309 = load i32, ptr %t41
%t310 = load ptr, ptr %text.addr
%t311 = call i32 @strlen(ptr %t310)
%t312 = icmp eq i32 %t309, %t311
ret i1 %t312
end393:
%t313 = load ptr, ptr %t224
%t314 = getelementptr inbounds [4 x i8], ptr @.str_stdlib_stdlib_23, i64 0, i64 0
%t315 = call ptr @_str_dup(ptr %t314)
%t316 = call i32 @strcmp(ptr %t313, ptr %t315)
%t317 = icmp eq i32 %t316, 0
br i1 %t317, label %if413, label %end412
if413:
%t318 = load i32, ptr %t41
%t319 = load ptr, ptr %text.addr
%t320 = call i32 @strlen(ptr %t319)
%t321 = icmp sge i32 %t318, %t320
br i1 %t321, label %if415, label %end414
if415:
ret i1 0
end414:
%t322 = load ptr, ptr %text.addr
%t323 = load i32, ptr %t41
%t324 = call ptr @charAt(ptr %t322, i32 %t323)
store ptr %t324, ptr %t325
%t329 = load ptr, ptr %t325
%t330 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_1, i64 0, i64 0
%t331 = call ptr @_str_dup(ptr %t330)
%t334 = load ptr, ptr %t325
%t335 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_2, i64 0, i64 0
%t336 = call ptr @_str_dup(ptr %t335)
%t340 = load ptr, ptr %t325
%t341 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_3, i64 0, i64 0
%t342 = call ptr @_str_dup(ptr %t341)
%t345 = load ptr, ptr %t325
%t346 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_4, i64 0, i64 0
%t347 = call ptr @_str_dup(ptr %t346)
%t350 = load ptr, ptr %t325
%t351 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_24, i64 0, i64 0
%t352 = call ptr @_str_dup(ptr %t351)
%t332 = call i32 @strcmp(ptr %t329, ptr %t331)
%t333 = icmp sge i32 %t332, 0
br i1 %t333, label %rhs423, label %skip424
rhs423:
%t337 = call i32 @strcmp(ptr %t334, ptr %t336)
%t338 = icmp sle i32 %t337, 0
br label %end425
skip424:
br label %end425
end425:
%t328 = phi i1 [ false, %skip424 ], [ %t338, %rhs423 ]
br i1 %t328, label %skip421, label %rhs420
rhs420:
%t343 = call i32 @strcmp(ptr %t340, ptr %t342)
%t344 = icmp sge i32 %t343, 0
br i1 %t344, label %rhs426, label %skip427
rhs426:
%t348 = call i32 @strcmp(ptr %t345, ptr %t347)
%t349 = icmp sle i32 %t348, 0
br label %end428
skip427:
br label %end428
end428:
%t339 = phi i1 [ false, %skip427 ], [ %t349, %rhs426 ]
br label %end422
skip421:
br label %end422
end422:
%t327 = phi i1 [ true, %skip421 ], [ %t339, %end428 ]
br i1 %t327, label %skip418, label %rhs417
rhs417:
%t353 = call i32 @strcmp(ptr %t350, ptr %t352)
%t354 = icmp eq i32 %t353, 0
br label %end419
skip418:
br label %end419
end419:
%t326 = phi i1 [ true, %skip418 ], [ %t354, %rhs417 ]
%t355 = xor i1 %t326, true
br i1 %t355, label %if429, label %end416
if429:
ret i1 0
end416:
%t356 = load i32, ptr %t41
%t357 = add i32 %t356, 1
store i32 %t357, ptr %t41
br label %whileCond430
whileCond430:
%t359 = load i32, ptr %t41
%t360 = load ptr, ptr %text.addr
%t361 = call i32 @strlen(ptr %t360)
%t362 = icmp slt i32 %t359, %t361
br i1 %t362, label %whileBody431, label %whileEnd432
whileBody431:
%t363 = load ptr, ptr %text.addr
%t364 = load i32, ptr %t41
%t365 = call ptr @charAt(ptr %t363, i32 %t364)
store ptr %t365, ptr %t366
%t371 = load ptr, ptr %t366
%t372 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_1, i64 0, i64 0
%t373 = call ptr @_str_dup(ptr %t372)
%t376 = load ptr, ptr %t366
%t377 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_2, i64 0, i64 0
%t378 = call ptr @_str_dup(ptr %t377)
%t382 = load ptr, ptr %t366
%t383 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_3, i64 0, i64 0
%t384 = call ptr @_str_dup(ptr %t383)
%t387 = load ptr, ptr %t366
%t388 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_4, i64 0, i64 0
%t389 = call ptr @_str_dup(ptr %t388)
%t393 = load ptr, ptr %t366
%t394 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_14, i64 0, i64 0
%t395 = call ptr @_str_dup(ptr %t394)
%t398 = load ptr, ptr %t366
%t399 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_15, i64 0, i64 0
%t400 = call ptr @_str_dup(ptr %t399)
%t403 = load ptr, ptr %t366
%t404 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_24, i64 0, i64 0
%t405 = call ptr @_str_dup(ptr %t404)
%t374 = call i32 @strcmp(ptr %t371, ptr %t373)
%t375 = icmp sge i32 %t374, 0
br i1 %t375, label %rhs443, label %skip444
rhs443:
%t379 = call i32 @strcmp(ptr %t376, ptr %t378)
%t380 = icmp sle i32 %t379, 0
br label %end445
skip444:
br label %end445
end445:
%t370 = phi i1 [ false, %skip444 ], [ %t380, %rhs443 ]
br i1 %t370, label %skip441, label %rhs440
rhs440:
%t385 = call i32 @strcmp(ptr %t382, ptr %t384)
%t386 = icmp sge i32 %t385, 0
br i1 %t386, label %rhs446, label %skip447
rhs446:
%t390 = call i32 @strcmp(ptr %t387, ptr %t389)
%t391 = icmp sle i32 %t390, 0
br label %end448
skip447:
br label %end448
end448:
%t381 = phi i1 [ false, %skip447 ], [ %t391, %rhs446 ]
br label %end442
skip441:
br label %end442
end442:
%t369 = phi i1 [ true, %skip441 ], [ %t381, %end448 ]
br i1 %t369, label %skip438, label %rhs437
rhs437:
%t396 = call i32 @strcmp(ptr %t393, ptr %t395)
%t397 = icmp sge i32 %t396, 0
br i1 %t397, label %rhs449, label %skip450
rhs449:
%t401 = call i32 @strcmp(ptr %t398, ptr %t400)
%t402 = icmp sle i32 %t401, 0
br label %end451
skip450:
br label %end451
end451:
%t392 = phi i1 [ false, %skip450 ], [ %t402, %rhs449 ]
br label %end439
skip438:
br label %end439
end439:
%t368 = phi i1 [ true, %skip438 ], [ %t392, %end451 ]
br i1 %t368, label %skip435, label %rhs434
rhs434:
%t406 = call i32 @strcmp(ptr %t403, ptr %t405)
%t407 = icmp eq i32 %t406, 0
br label %end436
skip435:
br label %end436
end436:
%t367 = phi i1 [ true, %skip435 ], [ %t407, %rhs434 ]
%t408 = xor i1 %t367, true
br i1 %t408, label %if452, label %end433
if452:
br label %whileEnd432
end433:
%t409 = load i32, ptr %t41
%t410 = add i32 %t409, 1
store i32 %t410, ptr %t41
br label %whileCond430
whileEnd432:
%t412 = load i32, ptr %t41
%t413 = load ptr, ptr %text.addr
%t414 = call i32 @strlen(ptr %t413)
%t415 = icmp eq i32 %t412, %t414
ret i1 %t415
end412:
%t416 = load ptr, ptr %t224
%t417 = getelementptr inbounds [8 x i8], ptr @.str_stdlib_stdlib_25, i64 0, i64 0
%t418 = call ptr @_str_dup(ptr %t417)
%t419 = call i32 @strcmp(ptr %t416, ptr %t418)
%t420 = icmp eq i32 %t419, 0
br i1 %t420, label %if454, label %end453
if454:
%t421 = load i32, ptr %t41
%t422 = load ptr, ptr %text.addr
%t423 = call i32 @strlen(ptr %t422)
%t424 = icmp slt i32 %t421, %t423
ret i1 %t424
end453:
br label %end383
end383:
%t425 = load ptr, ptr %t50
%t426 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t427 = call ptr @_str_dup(ptr %t426)
%t428 = call i32 @strcmp(ptr %t425, ptr %t427)
%t429 = icmp eq i32 %t428, 0
br i1 %t429, label %if456, label %end455
if456:
%t431 = load i32, ptr %t42
%t432 = add i32 %t431, 1
store i32 %t432, ptr %t430
br label %whileCond457
whileCond457:
%t433 = load i32, ptr %t430
%t434 = load ptr, ptr %pattern.addr
%t435 = call i32 @strlen(ptr %t434)
%t436 = icmp slt i32 %t433, %t435
br i1 %t436, label %whileBody458, label %whileEnd459
whileBody458:
%t437 = load ptr, ptr %pattern.addr
%t438 = load i32, ptr %t430
%t440 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_27, i64 0, i64 0
%t441 = call ptr @_str_dup(ptr %t440)
%t439 = call ptr @charAt(ptr %t437, i32 %t438)
%t442 = call i32 @strcmp(ptr %t439, ptr %t441)
%t443 = icmp eq i32 %t442, 0
br i1 %t443, label %if461, label %end460
if461:
br label %whileEnd459
end460:
%t444 = load i32, ptr %t430
%t445 = add i32 %t444, 1
store i32 %t445, ptr %t430
br label %whileCond457
whileEnd459:
%t447 = load ptr, ptr %pattern.addr
%t448 = load i32, ptr %t42
%t449 = add i32 %t448, 1
%t450 = load i32, ptr %t430
%t451 = call ptr @slice(ptr %t447, i32 %t449, i32 %t450)
store ptr %t451, ptr %t452
%t453 = load i32, ptr %t41
%t454 = load ptr, ptr %text.addr
%t455 = call i32 @strlen(ptr %t454)
%t456 = icmp sge i32 %t453, %t455
br i1 %t456, label %if463, label %end462
if463:
ret i1 0
end462:
%t457 = load ptr, ptr %text.addr
%t458 = load i32, ptr %t41
%t459 = call ptr @charAt(ptr %t457, i32 %t458)
store ptr %t459, ptr %t460
store i1 0, ptr %t461
%t463 = load ptr, ptr %t452
%t464 = call i32 @strlen(ptr %t463)
%t466 = load ptr, ptr %t452
%t468 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_22, i64 0, i64 0
%t469 = call ptr @_str_dup(ptr %t468)
%t465 = icmp eq i32 %t464, 3
br i1 %t465, label %rhs465, label %skip466
rhs465:
%t467 = call ptr @charAt(ptr %t466, i32 1)
%t470 = call i32 @strcmp(ptr %t467, ptr %t469)
%t471 = icmp eq i32 %t470, 0
br label %end467
skip466:
br label %end467
end467:
%t462 = phi i1 [ false, %skip466 ], [ %t471, %rhs465 ]
br i1 %t462, label %if468, label %else469
if468:
%t472 = load ptr, ptr %t452
%t473 = call ptr @charAt(ptr %t472, i32 0)
store ptr %t473, ptr %t474
%t475 = load ptr, ptr %t452
%t476 = call ptr @charAt(ptr %t475, i32 2)
store ptr %t476, ptr %t477
%t479 = load ptr, ptr %t460
%t480 = load ptr, ptr %t474
%t483 = load ptr, ptr %t460
%t484 = load ptr, ptr %t477
%t481 = call i32 @strcmp(ptr %t479, ptr %t480)
%t482 = icmp sge i32 %t481, 0
br i1 %t482, label %rhs471, label %skip472
rhs471:
%t485 = call i32 @strcmp(ptr %t483, ptr %t484)
%t486 = icmp sle i32 %t485, 0
br label %end473
skip472:
br label %end473
end473:
%t478 = phi i1 [ false, %skip472 ], [ %t486, %rhs471 ]
br i1 %t478, label %if474, label %end470
if474:
store i1 1, ptr %t461
br label %end470
end470:
br label %end464
else469:
store i32 0, ptr %t488
br label %whileCond475
whileCond475:
%t489 = load i32, ptr %t488
%t490 = load ptr, ptr %t452
%t491 = call i32 @strlen(ptr %t490)
%t492 = icmp slt i32 %t489, %t491
br i1 %t492, label %whileBody476, label %whileEnd477
whileBody476:
%t493 = load ptr, ptr %t452
%t494 = load i32, ptr %t488
%t495 = call ptr @charAt(ptr %t493, i32 %t494)
store ptr %t495, ptr %t496
%t497 = load ptr, ptr %t496
%t498 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_28, i64 0, i64 0
%t499 = call ptr @_str_dup(ptr %t498)
%t500 = call i32 @strcmp(ptr %t497, ptr %t499)
%t501 = icmp eq i32 %t500, 0
br i1 %t501, label %if479, label %end478
if479:
%t502 = load i32, ptr %t488
%t503 = add i32 %t502, 1
store i32 %t503, ptr %t488
br label %whileCond475
end478:
%t505 = load ptr, ptr %t496
%t506 = load ptr, ptr %t460
%t507 = call i32 @strcmp(ptr %t505, ptr %t506)
%t508 = icmp eq i32 %t507, 0
br i1 %t508, label %if481, label %end480
if481:
store i1 1, ptr %t461
br label %whileEnd477
end480:
%t510 = load i32, ptr %t488
%t511 = add i32 %t510, 1
store i32 %t511, ptr %t488
br label %whileCond475
whileEnd477:
br label %end464
end464:
%t513 = load i1, ptr %t461
%t514 = xor i1 %t513, true
br i1 %t514, label %if483, label %end482
if483:
ret i1 0
end482:
%t515 = load i32, ptr %t41
%t516 = add i32 %t515, 1
store i32 %t516, ptr %t41
%t518 = load i32, ptr %t430
%t519 = add i32 %t518, 1
store i32 %t519, ptr %t42
br label %whileCond335
end455:
%t521 = load i32, ptr %t41
%t522 = load ptr, ptr %text.addr
%t523 = call i32 @strlen(ptr %t522)
%t524 = icmp sge i32 %t521, %t523
br i1 %t524, label %if485, label %end484
if485:
ret i1 0
end484:
%t525 = load ptr, ptr %text.addr
%t526 = load i32, ptr %t41
%t528 = load ptr, ptr %t50
%t527 = call ptr @charAt(ptr %t525, i32 %t526)
%t529 = call i32 @strcmp(ptr %t527, ptr %t528)
%t530 = icmp ne i32 %t529, 0
br i1 %t530, label %if487, label %end486
if487:
ret i1 0
end486:
%t531 = load i32, ptr %t41
%t532 = add i32 %t531, 1
store i32 %t532, ptr %t41
%t534 = load i32, ptr %t42
%t535 = add i32 %t534, 1
store i32 %t535, ptr %t42
br label %whileCond335
whileEnd337:
%t537 = load i32, ptr %t41
%t538 = load ptr, ptr %text.addr
%t539 = call i32 @strlen(ptr %t538)
%t540 = icmp eq i32 %t537, %t539
ret i1 %t540
}
define i32 @_json_skipWS (ptr %t0, i32 %t1) {
entry:

%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%i.addr = alloca i32
store i32 %t1, ptr %i.addr
br label %whileCond488
whileCond488:
%t3 = load i32, ptr %i.addr
%t4 = load ptr, ptr %s.addr
%t5 = call i32 @strlen(ptr %t4)
%t7 = load ptr, ptr %s.addr
%t8 = load i32, ptr %i.addr
%t9 = call ptr @charAt(ptr %t7, i32 %t8)
%t6 = icmp slt i32 %t3, %t5
br i1 %t6, label %rhs491, label %skip492
rhs491:
%t10 = call i1 @isWhitespace(ptr %t9)
br label %end493
skip492:
br label %end493
end493:
%t2 = phi i1 [ false, %skip492 ], [ %t10, %rhs491 ]
br i1 %t2, label %whileBody489, label %whileEnd490
whileBody489:
%t11 = load i32, ptr %i.addr
%t12 = add i32 %t11, 1
store i32 %t12, ptr %i.addr
br label %whileCond488
whileEnd490:
%t14 = load i32, ptr %i.addr
ret i32 %t14
}
define i1 @isWhitespace (ptr %t0) {
entry:

%c.addr = alloca ptr
store ptr %t0, ptr %c.addr
%t4 = load ptr, ptr %c.addr
%t5 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_5, i64 0, i64 0
%t6 = call ptr @_str_dup(ptr %t5)
%t9 = load ptr, ptr %c.addr
%t10 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_6, i64 0, i64 0
%t11 = call ptr @_str_dup(ptr %t10)
%t14 = load ptr, ptr %c.addr
%t15 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_7, i64 0, i64 0
%t16 = call ptr @_str_dup(ptr %t15)
%t19 = load ptr, ptr %c.addr
%t20 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_29, i64 0, i64 0
%t21 = call ptr @_str_dup(ptr %t20)
%t7 = call i32 @strcmp(ptr %t4, ptr %t6)
%t8 = icmp eq i32 %t7, 0
br i1 %t8, label %skip501, label %rhs500
rhs500:
%t12 = call i32 @strcmp(ptr %t9, ptr %t11)
%t13 = icmp eq i32 %t12, 0
br label %end502
skip501:
br label %end502
end502:
%t3 = phi i1 [ true, %skip501 ], [ %t13, %rhs500 ]
br i1 %t3, label %skip498, label %rhs497
rhs497:
%t17 = call i32 @strcmp(ptr %t14, ptr %t16)
%t18 = icmp eq i32 %t17, 0
br label %end499
skip498:
br label %end499
end499:
%t2 = phi i1 [ true, %skip498 ], [ %t18, %rhs497 ]
br i1 %t2, label %skip495, label %rhs494
rhs494:
%t22 = call i32 @strcmp(ptr %t19, ptr %t21)
%t23 = icmp eq i32 %t22, 0
br label %end496
skip495:
br label %end496
end496:
%t1 = phi i1 [ true, %skip495 ], [ %t23, %rhs494 ]
ret i1 %t1
}
define ptr @_json_extractValue (ptr %t0, i32 %t1) {
entry:
%t12 = alloca i32
%t41 = alloca i32
%t43 = alloca i32
%t85 = alloca i32
%t87 = alloca i32
%t122 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%start.addr = alloca i32
store i32 %t1, ptr %start.addr
%t2 = load ptr, ptr %s.addr
%t3 = load i32, ptr %start.addr
%t4 = call i32 @_json_skipWS(ptr %t2, i32 %t3)
store i32 %t4, ptr %start.addr
%t5 = load ptr, ptr %s.addr
%t6 = load i32, ptr %start.addr
%t8 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_30, i64 0, i64 0
%t9 = call ptr @_str_dup(ptr %t8)
%t7 = call ptr @charAt(ptr %t5, i32 %t6)
%t10 = call i32 @strcmp(ptr %t7, ptr %t9)
%t11 = icmp eq i32 %t10, 0
br i1 %t11, label %if504, label %end503
if504:
%t13 = load i32, ptr %start.addr
%t14 = add i32 %t13, 1
store i32 %t14, ptr %t12
br label %whileCond505
whileCond505:
%t15 = load i32, ptr %t12
%t16 = load ptr, ptr %s.addr
%t17 = call i32 @strlen(ptr %t16)
%t18 = icmp slt i32 %t15, %t17
br i1 %t18, label %whileBody506, label %whileEnd507
whileBody506:
%t19 = load ptr, ptr %s.addr
%t20 = load i32, ptr %t12
%t22 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_30, i64 0, i64 0
%t23 = call ptr @_str_dup(ptr %t22)
%t21 = call ptr @charAt(ptr %t19, i32 %t20)
%t24 = call i32 @strcmp(ptr %t21, ptr %t23)
%t25 = icmp eq i32 %t24, 0
br i1 %t25, label %if509, label %end508
if509:
br label %whileEnd507
end508:
%t26 = load i32, ptr %t12
%t27 = add i32 %t26, 1
store i32 %t27, ptr %t12
br label %whileCond505
whileEnd507:
%t29 = load ptr, ptr %s.addr
%t30 = load i32, ptr %start.addr
%t31 = add i32 %t30, 1
%t32 = load i32, ptr %t12
%t33 = call ptr @slice(ptr %t29, i32 %t31, i32 %t32)
ret ptr %t33
end503:
%t34 = load ptr, ptr %s.addr
%t35 = load i32, ptr %start.addr
%t37 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_31, i64 0, i64 0
%t38 = call ptr @_str_dup(ptr %t37)
%t36 = call ptr @charAt(ptr %t34, i32 %t35)
%t39 = call i32 @strcmp(ptr %t36, ptr %t38)
%t40 = icmp eq i32 %t39, 0
br i1 %t40, label %if511, label %end510
if511:
%t42 = load i32, ptr %start.addr
store i32 %t42, ptr %t41
store i32 0, ptr %t43
br label %whileCond512
whileCond512:
%t44 = load i32, ptr %t41
%t45 = load ptr, ptr %s.addr
%t46 = call i32 @strlen(ptr %t45)
%t47 = icmp slt i32 %t44, %t46
br i1 %t47, label %whileBody513, label %whileEnd514
whileBody513:
%t48 = load ptr, ptr %s.addr
%t49 = load i32, ptr %t41
%t51 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_31, i64 0, i64 0
%t52 = call ptr @_str_dup(ptr %t51)
%t50 = call ptr @charAt(ptr %t48, i32 %t49)
%t53 = call i32 @strcmp(ptr %t50, ptr %t52)
%t54 = icmp eq i32 %t53, 0
br i1 %t54, label %if516, label %end515
if516:
%t55 = load i32, ptr %t43
%t56 = add i32 %t55, 1
store i32 %t56, ptr %t43
br label %end515
end515:
%t58 = load ptr, ptr %s.addr
%t59 = load i32, ptr %t41
%t61 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_32, i64 0, i64 0
%t62 = call ptr @_str_dup(ptr %t61)
%t60 = call ptr @charAt(ptr %t58, i32 %t59)
%t63 = call i32 @strcmp(ptr %t60, ptr %t62)
%t64 = icmp eq i32 %t63, 0
br i1 %t64, label %if518, label %end517
if518:
%t65 = load i32, ptr %t43
%t66 = sub i32 %t65, 1
store i32 %t66, ptr %t43
br label %end517
end517:
%t68 = load i32, ptr %t43
%t69 = icmp eq i32 %t68, 0
br i1 %t69, label %if520, label %end519
if520:
br label %whileEnd514
end519:
%t70 = load i32, ptr %t41
%t71 = add i32 %t70, 1
store i32 %t71, ptr %t41
br label %whileCond512
whileEnd514:
%t73 = load ptr, ptr %s.addr
%t74 = load i32, ptr %start.addr
%t75 = load i32, ptr %t41
%t76 = add i32 %t75, 1
%t77 = call ptr @slice(ptr %t73, i32 %t74, i32 %t76)
ret ptr %t77
end510:
%t78 = load ptr, ptr %s.addr
%t79 = load i32, ptr %start.addr
%t81 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t82 = call ptr @_str_dup(ptr %t81)
%t80 = call ptr @charAt(ptr %t78, i32 %t79)
%t83 = call i32 @strcmp(ptr %t80, ptr %t82)
%t84 = icmp eq i32 %t83, 0
br i1 %t84, label %if522, label %end521
if522:
%t86 = load i32, ptr %start.addr
store i32 %t86, ptr %t85
store i32 0, ptr %t87
br label %whileCond523
whileCond523:
%t88 = load i32, ptr %t85
%t89 = load ptr, ptr %s.addr
%t90 = call i32 @strlen(ptr %t89)
%t91 = icmp slt i32 %t88, %t90
br i1 %t91, label %whileBody524, label %whileEnd525
whileBody524:
%t92 = load ptr, ptr %s.addr
%t93 = load i32, ptr %t85
%t95 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t96 = call ptr @_str_dup(ptr %t95)
%t94 = call ptr @charAt(ptr %t92, i32 %t93)
%t97 = call i32 @strcmp(ptr %t94, ptr %t96)
%t98 = icmp eq i32 %t97, 0
br i1 %t98, label %if527, label %end526
if527:
%t99 = load i32, ptr %t87
%t100 = add i32 %t99, 1
store i32 %t100, ptr %t87
br label %end526
end526:
%t102 = load ptr, ptr %s.addr
%t103 = load i32, ptr %t85
%t105 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_27, i64 0, i64 0
%t106 = call ptr @_str_dup(ptr %t105)
%t104 = call ptr @charAt(ptr %t102, i32 %t103)
%t107 = call i32 @strcmp(ptr %t104, ptr %t106)
%t108 = icmp eq i32 %t107, 0
br i1 %t108, label %if529, label %end528
if529:
%t109 = load i32, ptr %t87
%t110 = sub i32 %t109, 1
store i32 %t110, ptr %t87
br label %end528
end528:
%t112 = load i32, ptr %t87
%t113 = icmp eq i32 %t112, 0
br i1 %t113, label %if531, label %end530
if531:
br label %whileEnd525
end530:
%t114 = load i32, ptr %t85
%t115 = add i32 %t114, 1
store i32 %t115, ptr %t85
br label %whileCond523
whileEnd525:
%t117 = load ptr, ptr %s.addr
%t118 = load i32, ptr %start.addr
%t119 = load i32, ptr %t85
%t120 = add i32 %t119, 1
%t121 = call ptr @slice(ptr %t117, i32 %t118, i32 %t120)
ret ptr %t121
end521:
%t123 = load i32, ptr %start.addr
store i32 %t123, ptr %t122
br label %whileCond532
whileCond532:
%t124 = load i32, ptr %t122
%t125 = load ptr, ptr %s.addr
%t126 = call i32 @strlen(ptr %t125)
%t127 = icmp slt i32 %t124, %t126
br i1 %t127, label %whileBody533, label %whileEnd534
whileBody533:
%t130 = load ptr, ptr %s.addr
%t131 = load i32, ptr %t122
%t133 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_28, i64 0, i64 0
%t134 = call ptr @_str_dup(ptr %t133)
%t137 = load ptr, ptr %s.addr
%t138 = load i32, ptr %t122
%t140 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_32, i64 0, i64 0
%t141 = call ptr @_str_dup(ptr %t140)
%t144 = load ptr, ptr %s.addr
%t145 = load i32, ptr %t122
%t147 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_27, i64 0, i64 0
%t148 = call ptr @_str_dup(ptr %t147)
%t132 = call ptr @charAt(ptr %t130, i32 %t131)
%t135 = call i32 @strcmp(ptr %t132, ptr %t134)
%t136 = icmp eq i32 %t135, 0
br i1 %t136, label %skip540, label %rhs539
rhs539:
%t139 = call ptr @charAt(ptr %t137, i32 %t138)
%t142 = call i32 @strcmp(ptr %t139, ptr %t141)
%t143 = icmp eq i32 %t142, 0
br label %end541
skip540:
br label %end541
end541:
%t129 = phi i1 [ true, %skip540 ], [ %t143, %rhs539 ]
br i1 %t129, label %skip537, label %rhs536
rhs536:
%t146 = call ptr @charAt(ptr %t144, i32 %t145)
%t149 = call i32 @strcmp(ptr %t146, ptr %t148)
%t150 = icmp eq i32 %t149, 0
br label %end538
skip537:
br label %end538
end538:
%t128 = phi i1 [ true, %skip537 ], [ %t150, %rhs536 ]
br i1 %t128, label %if542, label %end535
if542:
br label %whileEnd534
end535:
%t151 = load i32, ptr %t122
%t152 = add i32 %t151, 1
store i32 %t152, ptr %t122
br label %whileCond532
whileEnd534:
%t154 = load ptr, ptr %s.addr
%t155 = load i32, ptr %start.addr
%t156 = load i32, ptr %t122
%t157 = call ptr @slice(ptr %t154, i32 %t155, i32 %t156)
ret ptr %t157
}
define i32 @_json_skipElement (ptr %t0, i32 %t1) {
entry:
%t38 = alloca i32
%t77 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%i.addr = alloca i32
store i32 %t1, ptr %i.addr
%t2 = load ptr, ptr %s.addr
%t3 = load i32, ptr %i.addr
%t4 = call i32 @_json_skipWS(ptr %t2, i32 %t3)
store i32 %t4, ptr %i.addr
%t5 = load ptr, ptr %s.addr
%t6 = load i32, ptr %i.addr
%t8 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_30, i64 0, i64 0
%t9 = call ptr @_str_dup(ptr %t8)
%t7 = call ptr @charAt(ptr %t5, i32 %t6)
%t10 = call i32 @strcmp(ptr %t7, ptr %t9)
%t11 = icmp eq i32 %t10, 0
br i1 %t11, label %if544, label %end543
if544:
%t12 = load i32, ptr %i.addr
%t13 = add i32 %t12, 1
store i32 %t13, ptr %i.addr
br label %whileCond545
whileCond545:
%t15 = load i32, ptr %i.addr
%t16 = load ptr, ptr %s.addr
%t17 = call i32 @strlen(ptr %t16)
%t18 = icmp slt i32 %t15, %t17
br i1 %t18, label %whileBody546, label %whileEnd547
whileBody546:
%t19 = load ptr, ptr %s.addr
%t20 = load i32, ptr %i.addr
%t22 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_30, i64 0, i64 0
%t23 = call ptr @_str_dup(ptr %t22)
%t21 = call ptr @charAt(ptr %t19, i32 %t20)
%t24 = call i32 @strcmp(ptr %t21, ptr %t23)
%t25 = icmp eq i32 %t24, 0
br i1 %t25, label %if549, label %end548
if549:
br label %whileEnd547
end548:
%t26 = load i32, ptr %i.addr
%t27 = add i32 %t26, 1
store i32 %t27, ptr %i.addr
br label %whileCond545
whileEnd547:
%t29 = load i32, ptr %i.addr
%t30 = add i32 %t29, 1
ret i32 %t30
end543:
%t31 = load ptr, ptr %s.addr
%t32 = load i32, ptr %i.addr
%t34 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_31, i64 0, i64 0
%t35 = call ptr @_str_dup(ptr %t34)
%t33 = call ptr @charAt(ptr %t31, i32 %t32)
%t36 = call i32 @strcmp(ptr %t33, ptr %t35)
%t37 = icmp eq i32 %t36, 0
br i1 %t37, label %if551, label %end550
if551:
store i32 0, ptr %t38
br label %whileCond552
whileCond552:
%t39 = load i32, ptr %i.addr
%t40 = load ptr, ptr %s.addr
%t41 = call i32 @strlen(ptr %t40)
%t42 = icmp slt i32 %t39, %t41
br i1 %t42, label %whileBody553, label %whileEnd554
whileBody553:
%t43 = load ptr, ptr %s.addr
%t44 = load i32, ptr %i.addr
%t46 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_31, i64 0, i64 0
%t47 = call ptr @_str_dup(ptr %t46)
%t45 = call ptr @charAt(ptr %t43, i32 %t44)
%t48 = call i32 @strcmp(ptr %t45, ptr %t47)
%t49 = icmp eq i32 %t48, 0
br i1 %t49, label %if556, label %end555
if556:
%t50 = load i32, ptr %t38
%t51 = add i32 %t50, 1
store i32 %t51, ptr %t38
br label %end555
end555:
%t53 = load ptr, ptr %s.addr
%t54 = load i32, ptr %i.addr
%t56 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_32, i64 0, i64 0
%t57 = call ptr @_str_dup(ptr %t56)
%t55 = call ptr @charAt(ptr %t53, i32 %t54)
%t58 = call i32 @strcmp(ptr %t55, ptr %t57)
%t59 = icmp eq i32 %t58, 0
br i1 %t59, label %if558, label %end557
if558:
%t60 = load i32, ptr %t38
%t61 = sub i32 %t60, 1
store i32 %t61, ptr %t38
br label %end557
end557:
%t63 = load i32, ptr %t38
%t64 = icmp eq i32 %t63, 0
br i1 %t64, label %if560, label %end559
if560:
br label %whileEnd554
end559:
%t65 = load i32, ptr %i.addr
%t66 = add i32 %t65, 1
store i32 %t66, ptr %i.addr
br label %whileCond552
whileEnd554:
%t68 = load i32, ptr %i.addr
%t69 = add i32 %t68, 1
ret i32 %t69
end550:
%t70 = load ptr, ptr %s.addr
%t71 = load i32, ptr %i.addr
%t73 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t74 = call ptr @_str_dup(ptr %t73)
%t72 = call ptr @charAt(ptr %t70, i32 %t71)
%t75 = call i32 @strcmp(ptr %t72, ptr %t74)
%t76 = icmp eq i32 %t75, 0
br i1 %t76, label %if562, label %end561
if562:
store i32 0, ptr %t77
br label %whileCond563
whileCond563:
%t78 = load i32, ptr %i.addr
%t79 = load ptr, ptr %s.addr
%t80 = call i32 @strlen(ptr %t79)
%t81 = icmp slt i32 %t78, %t80
br i1 %t81, label %whileBody564, label %whileEnd565
whileBody564:
%t82 = load ptr, ptr %s.addr
%t83 = load i32, ptr %i.addr
%t85 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t86 = call ptr @_str_dup(ptr %t85)
%t84 = call ptr @charAt(ptr %t82, i32 %t83)
%t87 = call i32 @strcmp(ptr %t84, ptr %t86)
%t88 = icmp eq i32 %t87, 0
br i1 %t88, label %if567, label %end566
if567:
%t89 = load i32, ptr %t77
%t90 = add i32 %t89, 1
store i32 %t90, ptr %t77
br label %end566
end566:
%t92 = load ptr, ptr %s.addr
%t93 = load i32, ptr %i.addr
%t95 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_27, i64 0, i64 0
%t96 = call ptr @_str_dup(ptr %t95)
%t94 = call ptr @charAt(ptr %t92, i32 %t93)
%t97 = call i32 @strcmp(ptr %t94, ptr %t96)
%t98 = icmp eq i32 %t97, 0
br i1 %t98, label %if569, label %end568
if569:
%t99 = load i32, ptr %t77
%t100 = sub i32 %t99, 1
store i32 %t100, ptr %t77
br label %end568
end568:
%t102 = load i32, ptr %t77
%t103 = icmp eq i32 %t102, 0
br i1 %t103, label %if571, label %end570
if571:
br label %whileEnd565
end570:
%t104 = load i32, ptr %i.addr
%t105 = add i32 %t104, 1
store i32 %t105, ptr %i.addr
br label %whileCond563
whileEnd565:
%t107 = load i32, ptr %i.addr
%t108 = add i32 %t107, 1
ret i32 %t108
end561:
br label %whileCond572
whileCond572:
%t109 = load i32, ptr %i.addr
%t110 = load ptr, ptr %s.addr
%t111 = call i32 @strlen(ptr %t110)
%t112 = icmp slt i32 %t109, %t111
br i1 %t112, label %whileBody573, label %whileEnd574
whileBody573:
%t115 = load ptr, ptr %s.addr
%t116 = load i32, ptr %i.addr
%t118 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_28, i64 0, i64 0
%t119 = call ptr @_str_dup(ptr %t118)
%t122 = load ptr, ptr %s.addr
%t123 = load i32, ptr %i.addr
%t125 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_27, i64 0, i64 0
%t126 = call ptr @_str_dup(ptr %t125)
%t129 = load ptr, ptr %s.addr
%t130 = load i32, ptr %i.addr
%t132 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_32, i64 0, i64 0
%t133 = call ptr @_str_dup(ptr %t132)
%t117 = call ptr @charAt(ptr %t115, i32 %t116)
%t120 = call i32 @strcmp(ptr %t117, ptr %t119)
%t121 = icmp eq i32 %t120, 0
br i1 %t121, label %skip580, label %rhs579
rhs579:
%t124 = call ptr @charAt(ptr %t122, i32 %t123)
%t127 = call i32 @strcmp(ptr %t124, ptr %t126)
%t128 = icmp eq i32 %t127, 0
br label %end581
skip580:
br label %end581
end581:
%t114 = phi i1 [ true, %skip580 ], [ %t128, %rhs579 ]
br i1 %t114, label %skip577, label %rhs576
rhs576:
%t131 = call ptr @charAt(ptr %t129, i32 %t130)
%t134 = call i32 @strcmp(ptr %t131, ptr %t133)
%t135 = icmp eq i32 %t134, 0
br label %end578
skip577:
br label %end578
end578:
%t113 = phi i1 [ true, %skip577 ], [ %t135, %rhs576 ]
br i1 %t113, label %if582, label %end575
if582:
br label %whileEnd574
end575:
%t136 = load i32, ptr %i.addr
%t137 = add i32 %t136, 1
store i32 %t137, ptr %i.addr
br label %whileCond572
whileEnd574:
%t139 = load i32, ptr %i.addr
ret i32 %t139
}
define ptr @_json_getArrayIndex (ptr %t0, i32 %t1) {
entry:
%t4 = alloca i32
%t17 = alloca i32
%arr.addr = alloca ptr
store ptr %t0, ptr %arr.addr
%index.addr = alloca i32
store i32 %t1, ptr %index.addr
%t2 = load ptr, ptr %arr.addr
%t3 = call i32 @_json_skipWS(ptr %t2, i32 0)
store i32 %t3, ptr %t4
%t5 = load ptr, ptr %arr.addr
%t6 = load i32, ptr %t4
%t8 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t9 = call ptr @_str_dup(ptr %t8)
%t7 = call ptr @charAt(ptr %t5, i32 %t6)
%t10 = call i32 @strcmp(ptr %t7, ptr %t9)
%t11 = icmp ne i32 %t10, 0
br i1 %t11, label %if584, label %end583
if584:
%t12 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t13 = call ptr @_str_dup(ptr %t12)
ret ptr %t13
end583:
%t14 = load i32, ptr %t4
%t15 = add i32 %t14, 1
store i32 %t15, ptr %t4
store i32 0, ptr %t17
br label %whileCond585
whileCond585:
%t18 = load i32, ptr %t4
%t19 = load ptr, ptr %arr.addr
%t20 = call i32 @strlen(ptr %t19)
%t21 = icmp slt i32 %t18, %t20
br i1 %t21, label %whileBody586, label %whileEnd587
whileBody586:
%t22 = load ptr, ptr %arr.addr
%t23 = load i32, ptr %t4
%t24 = call i32 @_json_skipWS(ptr %t22, i32 %t23)
store i32 %t24, ptr %t4
%t25 = load ptr, ptr %arr.addr
%t26 = load i32, ptr %t4
%t28 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_28, i64 0, i64 0
%t29 = call ptr @_str_dup(ptr %t28)
%t27 = call ptr @charAt(ptr %t25, i32 %t26)
%t30 = call i32 @strcmp(ptr %t27, ptr %t29)
%t31 = icmp eq i32 %t30, 0
br i1 %t31, label %if589, label %end588
if589:
%t32 = load i32, ptr %t4
%t33 = add i32 %t32, 1
store i32 %t33, ptr %t4
%t35 = load ptr, ptr %arr.addr
%t36 = load i32, ptr %t4
%t37 = call i32 @_json_skipWS(ptr %t35, i32 %t36)
store i32 %t37, ptr %t4
br label %end588
end588:
%t38 = load ptr, ptr %arr.addr
%t39 = load i32, ptr %t4
%t41 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_27, i64 0, i64 0
%t42 = call ptr @_str_dup(ptr %t41)
%t40 = call ptr @charAt(ptr %t38, i32 %t39)
%t43 = call i32 @strcmp(ptr %t40, ptr %t42)
%t44 = icmp eq i32 %t43, 0
br i1 %t44, label %if591, label %end590
if591:
br label %whileEnd587
end590:
%t45 = load i32, ptr %t4
%t46 = load ptr, ptr %arr.addr
%t47 = call i32 @strlen(ptr %t46)
%t48 = icmp sge i32 %t45, %t47
br i1 %t48, label %if593, label %end592
if593:
br label %whileEnd587
end592:
%t49 = load i32, ptr %t17
%t50 = load i32, ptr %index.addr
%t51 = icmp eq i32 %t49, %t50
br i1 %t51, label %if595, label %end594
if595:
%t52 = load ptr, ptr %arr.addr
%t53 = load i32, ptr %t4
%t54 = call ptr @_json_extractValue(ptr %t52, i32 %t53)
ret ptr %t54
end594:
%t55 = load ptr, ptr %arr.addr
%t56 = load i32, ptr %t4
%t57 = call i32 @_json_skipElement(ptr %t55, i32 %t56)
store i32 %t57, ptr %t4
%t58 = load i32, ptr %t17
%t59 = add i32 %t58, 1
store i32 %t59, ptr %t17
br label %whileCond585
whileEnd587:
%t61 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t62 = call ptr @_str_dup(ptr %t61)
ret ptr %t62
}
define ptr @_json_getKey (ptr %t0, ptr %t1) {
entry:
%t4 = alloca i32
%t51 = alloca i32
%t54 = alloca i32
%t75 = alloca ptr
%obj.addr = alloca ptr
store ptr %t0, ptr %obj.addr
%key.addr = alloca ptr
store ptr %t1, ptr %key.addr
%t2 = load ptr, ptr %obj.addr
%t3 = call i32 @_json_skipWS(ptr %t2, i32 0)
store i32 %t3, ptr %t4
%t5 = load ptr, ptr %obj.addr
%t6 = load i32, ptr %t4
%t8 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_31, i64 0, i64 0
%t9 = call ptr @_str_dup(ptr %t8)
%t7 = call ptr @charAt(ptr %t5, i32 %t6)
%t10 = call i32 @strcmp(ptr %t7, ptr %t9)
%t11 = icmp ne i32 %t10, 0
br i1 %t11, label %if597, label %end596
if597:
%t12 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t13 = call ptr @_str_dup(ptr %t12)
ret ptr %t13
end596:
%t14 = load i32, ptr %t4
%t15 = add i32 %t14, 1
store i32 %t15, ptr %t4
br label %whileCond598
whileCond598:
%t17 = load i32, ptr %t4
%t18 = load ptr, ptr %obj.addr
%t19 = call i32 @strlen(ptr %t18)
%t20 = icmp slt i32 %t17, %t19
br i1 %t20, label %whileBody599, label %whileEnd600
whileBody599:
%t21 = load ptr, ptr %obj.addr
%t22 = load i32, ptr %t4
%t23 = call i32 @_json_skipWS(ptr %t21, i32 %t22)
store i32 %t23, ptr %t4
%t24 = load ptr, ptr %obj.addr
%t25 = load i32, ptr %t4
%t27 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_32, i64 0, i64 0
%t28 = call ptr @_str_dup(ptr %t27)
%t26 = call ptr @charAt(ptr %t24, i32 %t25)
%t29 = call i32 @strcmp(ptr %t26, ptr %t28)
%t30 = icmp eq i32 %t29, 0
br i1 %t30, label %if602, label %end601
if602:
br label %whileEnd600
end601:
%t31 = load ptr, ptr %obj.addr
%t32 = load i32, ptr %t4
%t34 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_28, i64 0, i64 0
%t35 = call ptr @_str_dup(ptr %t34)
%t33 = call ptr @charAt(ptr %t31, i32 %t32)
%t36 = call i32 @strcmp(ptr %t33, ptr %t35)
%t37 = icmp eq i32 %t36, 0
br i1 %t37, label %if604, label %end603
if604:
%t38 = load i32, ptr %t4
%t39 = add i32 %t38, 1
store i32 %t39, ptr %t4
%t41 = load ptr, ptr %obj.addr
%t42 = load i32, ptr %t4
%t43 = call i32 @_json_skipWS(ptr %t41, i32 %t42)
store i32 %t43, ptr %t4
br label %end603
end603:
%t44 = load ptr, ptr %obj.addr
%t45 = load i32, ptr %t4
%t47 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_30, i64 0, i64 0
%t48 = call ptr @_str_dup(ptr %t47)
%t46 = call ptr @charAt(ptr %t44, i32 %t45)
%t49 = call i32 @strcmp(ptr %t46, ptr %t48)
%t50 = icmp ne i32 %t49, 0
br i1 %t50, label %if606, label %end605
if606:
br label %whileEnd600
end605:
%t52 = load i32, ptr %t4
%t53 = add i32 %t52, 1
store i32 %t53, ptr %t51
%t55 = load i32, ptr %t51
store i32 %t55, ptr %t54
br label %whileCond607
whileCond607:
%t57 = load i32, ptr %t54
%t58 = load ptr, ptr %obj.addr
%t59 = call i32 @strlen(ptr %t58)
%t61 = load ptr, ptr %obj.addr
%t62 = load i32, ptr %t54
%t64 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_30, i64 0, i64 0
%t65 = call ptr @_str_dup(ptr %t64)
%t60 = icmp slt i32 %t57, %t59
br i1 %t60, label %rhs610, label %skip611
rhs610:
%t63 = call ptr @charAt(ptr %t61, i32 %t62)
%t66 = call i32 @strcmp(ptr %t63, ptr %t65)
%t67 = icmp ne i32 %t66, 0
br label %end612
skip611:
br label %end612
end612:
%t56 = phi i1 [ false, %skip611 ], [ %t67, %rhs610 ]
br i1 %t56, label %whileBody608, label %whileEnd609
whileBody608:
%t68 = load i32, ptr %t54
%t69 = add i32 %t68, 1
store i32 %t69, ptr %t54
br label %whileCond607
whileEnd609:
%t71 = load ptr, ptr %obj.addr
%t72 = load i32, ptr %t51
%t73 = load i32, ptr %t54
%t74 = call ptr @slice(ptr %t71, i32 %t72, i32 %t73)
store ptr %t74, ptr %t75
%t76 = load i32, ptr %t54
%t77 = add i32 %t76, 1
store i32 %t77, ptr %t4
%t79 = load ptr, ptr %obj.addr
%t80 = load i32, ptr %t4
%t81 = call i32 @_json_skipWS(ptr %t79, i32 %t80)
store i32 %t81, ptr %t4
%t82 = load ptr, ptr %obj.addr
%t83 = load i32, ptr %t4
%t85 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_20, i64 0, i64 0
%t86 = call ptr @_str_dup(ptr %t85)
%t84 = call ptr @charAt(ptr %t82, i32 %t83)
%t87 = call i32 @strcmp(ptr %t84, ptr %t86)
%t88 = icmp ne i32 %t87, 0
br i1 %t88, label %if614, label %end613
if614:
br label %whileEnd600
end613:
%t89 = load i32, ptr %t4
%t90 = add i32 %t89, 1
store i32 %t90, ptr %t4
%t92 = load ptr, ptr %obj.addr
%t93 = load i32, ptr %t4
%t94 = call i32 @_json_skipWS(ptr %t92, i32 %t93)
store i32 %t94, ptr %t4
%t95 = load ptr, ptr %t75
%t96 = load ptr, ptr %key.addr
%t97 = call i32 @strcmp(ptr %t95, ptr %t96)
%t98 = icmp eq i32 %t97, 0
br i1 %t98, label %if616, label %end615
if616:
%t99 = load ptr, ptr %obj.addr
%t100 = load i32, ptr %t4
%t101 = call ptr @_json_extractValue(ptr %t99, i32 %t100)
ret ptr %t101
end615:
%t102 = load ptr, ptr %obj.addr
%t103 = load i32, ptr %t4
%t104 = call i32 @_json_skipElement(ptr %t102, i32 %t103)
store i32 %t104, ptr %t4
br label %whileCond598
whileEnd600:
%t105 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t106 = call ptr @_str_dup(ptr %t105)
ret ptr %t106
}
define i32 @_json_parseInt (ptr %t0) {
entry:
%t1 = alloca i32
%t2 = alloca i32
%t7 = alloca i32
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
store i32 0, ptr %t1
store i32 0, ptr %t2
br label %whileCond617
whileCond617:
%t3 = load i32, ptr %t2
%t4 = load ptr, ptr %s.addr
%t5 = call i32 @strlen(ptr %t4)
%t6 = icmp slt i32 %t3, %t5
br i1 %t6, label %whileBody618, label %whileEnd619
whileBody618:
%t8 = load ptr, ptr %s.addr
%t9 = load i32, ptr %t2
%t10 = call ptr @charAt(ptr %t8, i32 %t9)
%t11 = call i32 @_string_to_int_ascii(ptr %t10)
%t12 = sub i32 %t11, 48
store i32 %t12, ptr %t7
%t13 = load i32, ptr %t1
%t15 = load i32, ptr %t7
%t14 = mul i32 %t13, 10
%t16 = add i32 %t14, %t15
store i32 %t16, ptr %t1
%t18 = load i32, ptr %t2
%t19 = add i32 %t18, 1
store i32 %t19, ptr %t2
br label %whileCond617
whileEnd619:
%t21 = load i32, ptr %t1
ret i32 %t21
}
define ptr @json (ptr %t0, ptr %t1) {
entry:
%t2 = alloca ptr
%t4 = alloca i32
%t10 = alloca ptr
%t16 = alloca i32
%t34 = alloca ptr
%t40 = alloca ptr
%t56 = alloca i32
%t68 = alloca i32
%t90 = alloca ptr
%t93 = alloca i32
%data.addr = alloca ptr
store ptr %t0, ptr %data.addr
%path.addr = alloca ptr
store ptr %t1, ptr %path.addr
%t3 = load ptr, ptr %data.addr
store ptr %t3, ptr %t2
store i32 0, ptr %t4
br label %whileCond620
whileCond620:
br i1 1, label %whileBody621, label %whileEnd622
whileBody621:
%t5 = load ptr, ptr %path.addr
%t6 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_8, i64 0, i64 0
%t7 = call ptr @_str_dup(ptr %t6)
%t8 = load i32, ptr %t4
%t9 = call ptr @splitAt(ptr %t5, ptr %t7, i32 %t8)
store ptr %t9, ptr %t10
%t11 = load ptr, ptr %t10
%t12 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t13 = call ptr @_str_dup(ptr %t12)
%t14 = call i32 @strcmp(ptr %t11, ptr %t13)
%t15 = icmp eq i32 %t14, 0
br i1 %t15, label %if624, label %end623
if624:
br label %whileEnd622
end623:
store i32 0, ptr %t16
br label %whileCond625
whileCond625:
%t17 = load i32, ptr %t16
%t18 = load ptr, ptr %t10
%t19 = call i32 @strlen(ptr %t18)
%t20 = icmp slt i32 %t17, %t19
br i1 %t20, label %whileBody626, label %whileEnd627
whileBody626:
%t21 = load ptr, ptr %t10
%t22 = load i32, ptr %t16
%t24 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t25 = call ptr @_str_dup(ptr %t24)
%t23 = call ptr @charAt(ptr %t21, i32 %t22)
%t26 = call i32 @strcmp(ptr %t23, ptr %t25)
%t27 = icmp eq i32 %t26, 0
br i1 %t27, label %if629, label %end628
if629:
br label %whileEnd627
end628:
%t28 = load i32, ptr %t16
%t29 = add i32 %t28, 1
store i32 %t29, ptr %t16
br label %whileCond625
whileEnd627:
%t31 = load ptr, ptr %t10
%t32 = load i32, ptr %t16
%t33 = call ptr @slice(ptr %t31, i32 0, i32 %t32)
store ptr %t33, ptr %t34
%t35 = load ptr, ptr %t10
%t36 = load i32, ptr %t16
%t37 = load ptr, ptr %t10
%t38 = call i32 @strlen(ptr %t37)
%t39 = call ptr @slice(ptr %t35, i32 %t36, i32 %t38)
store ptr %t39, ptr %t40
%t41 = load ptr, ptr %t34
%t42 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t43 = call ptr @_str_dup(ptr %t42)
%t44 = call i32 @strcmp(ptr %t41, ptr %t43)
%t45 = icmp ne i32 %t44, 0
br i1 %t45, label %if631, label %end630
if631:
%t46 = load ptr, ptr %t2
%t47 = load ptr, ptr %t34
%t48 = call ptr @_json_getKey(ptr %t46, ptr %t47)
store ptr %t48, ptr %t2
%t49 = load ptr, ptr %t2
%t50 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t51 = call ptr @_str_dup(ptr %t50)
%t52 = call i32 @strcmp(ptr %t49, ptr %t51)
%t53 = icmp eq i32 %t52, 0
br i1 %t53, label %if633, label %end632
if633:
%t54 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t55 = call ptr @_str_dup(ptr %t54)
ret ptr %t55
end632:
br label %end630
end630:
store i32 0, ptr %t56
br label %whileCond634
whileCond634:
%t57 = load i32, ptr %t56
%t58 = load ptr, ptr %t40
%t59 = call i32 @strlen(ptr %t58)
%t60 = icmp slt i32 %t57, %t59
br i1 %t60, label %whileBody635, label %whileEnd636
whileBody635:
%t61 = load ptr, ptr %t40
%t62 = load i32, ptr %t56
%t64 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_26, i64 0, i64 0
%t65 = call ptr @_str_dup(ptr %t64)
%t63 = call ptr @charAt(ptr %t61, i32 %t62)
%t66 = call i32 @strcmp(ptr %t63, ptr %t65)
%t67 = icmp ne i32 %t66, 0
br i1 %t67, label %if638, label %end637
if638:
br label %whileEnd636
end637:
%t69 = load i32, ptr %t56
%t70 = add i32 %t69, 1
store i32 %t70, ptr %t68
br label %whileCond639
whileCond639:
%t71 = load i32, ptr %t68
%t72 = load ptr, ptr %t40
%t73 = call i32 @strlen(ptr %t72)
%t74 = icmp slt i32 %t71, %t73
br i1 %t74, label %whileBody640, label %whileEnd641
whileBody640:
%t75 = load ptr, ptr %t40
%t76 = load i32, ptr %t68
%t78 = getelementptr inbounds [2 x i8], ptr @.str_stdlib_stdlib_27, i64 0, i64 0
%t79 = call ptr @_str_dup(ptr %t78)
%t77 = call ptr @charAt(ptr %t75, i32 %t76)
%t80 = call i32 @strcmp(ptr %t77, ptr %t79)
%t81 = icmp eq i32 %t80, 0
br i1 %t81, label %if643, label %end642
if643:
br label %whileEnd641
end642:
%t82 = load i32, ptr %t68
%t83 = add i32 %t82, 1
store i32 %t83, ptr %t68
br label %whileCond639
whileEnd641:
%t85 = load ptr, ptr %t40
%t86 = load i32, ptr %t56
%t87 = add i32 %t86, 1
%t88 = load i32, ptr %t68
%t89 = call ptr @slice(ptr %t85, i32 %t87, i32 %t88)
store ptr %t89, ptr %t90
%t91 = load ptr, ptr %t90
%t92 = call i32 @_json_parseInt(ptr %t91)
store i32 %t92, ptr %t93
%t94 = load ptr, ptr %t2
%t95 = load i32, ptr %t93
%t96 = call ptr @_json_getArrayIndex(ptr %t94, i32 %t95)
store ptr %t96, ptr %t2
%t97 = load ptr, ptr %t2
%t98 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t99 = call ptr @_str_dup(ptr %t98)
%t100 = call i32 @strcmp(ptr %t97, ptr %t99)
%t101 = icmp eq i32 %t100, 0
br i1 %t101, label %if645, label %end644
if645:
%t102 = getelementptr inbounds [5 x i8], ptr @.str_stdlib_stdlib_33, i64 0, i64 0
%t103 = call ptr @_str_dup(ptr %t102)
ret ptr %t103
end644:
%t104 = load i32, ptr %t68
%t105 = add i32 %t104, 1
store i32 %t105, ptr %t56
br label %whileCond634
whileEnd636:
%t107 = load i32, ptr %t4
%t108 = add i32 %t107, 1
store i32 %t108, ptr %t4
br label %whileCond620
whileEnd622:
%t110 = load ptr, ptr %t2
ret ptr %t110
}
define ptr @split (ptr %t0, ptr %t1) {
entry:
%t2 = alloca ptr
%t6 = alloca i32
%t9 = alloca i32
%t13 = alloca ptr
%t16 = alloca i32
%t20 = alloca i1
%t21 = alloca i32
%t54 = alloca ptr
%t78 = alloca ptr
%s.addr = alloca ptr
store ptr %t0, ptr %s.addr
%delim.addr = alloca ptr
store ptr %t1, ptr %delim.addr
%t3 = call ptr @_zen_list_new(i64 8)
call void @_zen_list_set_meta(ptr %t3, i32 1, i32 4)
store ptr %t3, ptr %t2
%t4 = load ptr, ptr %s.addr
%t5 = call i32 @strlen(ptr %t4)
store i32 %t5, ptr %t6
%t7 = load ptr, ptr %delim.addr
%t8 = call i32 @strlen(ptr %t7)
store i32 %t8, ptr %t9
%t10 = load i32, ptr %t9
%t11 = icmp eq i32 %t10, 0
br i1 %t11, label %if647, label %end646
if647:
%t12 = load ptr, ptr %t2
ret ptr %t12
end646:
%t14 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t15 = call ptr @_str_dup(ptr %t14)
store ptr %t15, ptr %t13
store i32 0, ptr %t16
br label %whileCond648
whileCond648:
%t17 = load i32, ptr %t16
%t18 = load i32, ptr %t6
%t19 = icmp slt i32 %t17, %t18
br i1 %t19, label %whileBody649, label %whileEnd650
whileBody649:
store i1 1, ptr %t20
store i32 0, ptr %t21
%t22 = load i32, ptr %t16
%t23 = load i32, ptr %t6
%t24 = load i32, ptr %t9
%t25 = sub i32 %t23, %t24
%t26 = icmp sle i32 %t22, %t25
br i1 %t26, label %if652, label %else653
if652:
br label %whileCond654
whileCond654:
%t27 = load i32, ptr %t21
%t28 = load i32, ptr %t9
%t29 = icmp slt i32 %t27, %t28
br i1 %t29, label %whileBody655, label %whileEnd656
whileBody655:
%t30 = load ptr, ptr %s.addr
%t31 = load i32, ptr %t16
%t32 = load i32, ptr %t21
%t33 = add i32 %t31, %t32
%t38 = load ptr, ptr %delim.addr
%t39 = load i32, ptr %t21
%t34 = getelementptr i8, ptr %t30, i32 %t33
%t35 = load i8, ptr %t34
%t36 = call ptr @_zen_char_to_string(i8 %t35)
%t40 = getelementptr i8, ptr %t38, i32 %t39
%t41 = load i8, ptr %t40
%t42 = call ptr @_zen_char_to_string(i8 %t41)
%t44 = call i32 @strcmp(ptr %t36, ptr %t42)
%t45 = icmp ne i32 %t44, 0
br i1 %t45, label %if658, label %end657
if658:
store i1 0, ptr %t20
br label %end657
end657:
%t47 = load i32, ptr %t21
%t48 = add i32 %t47, 1
store i32 %t48, ptr %t21
br label %whileCond654
whileEnd656:
br label %end651
else653:
store i1 0, ptr %t20
br label %end651
end651:
%t51 = load i1, ptr %t20
br i1 %t51, label %if660, label %else661
if660:
%t52 = load ptr, ptr %t2
%t53 = load ptr, ptr %t13
store ptr %t53, ptr %t54
call void @_zen_list_push(ptr %t52, ptr %t54)
%t55 = getelementptr inbounds [1 x i8], ptr @.str_stdlib_stdlib_0, i64 0, i64 0
%t56 = call ptr @_str_dup(ptr %t55)
%t58 = load ptr, ptr %t13
call void @_zen_string_free(ptr %t58)
store ptr %t56, ptr %t13
%t59 = load i32, ptr %t16
%t60 = load i32, ptr %t9
%t61 = add i32 %t59, %t60
store i32 %t61, ptr %t16
br label %end659
else661:
%t63 = load ptr, ptr %t13
%t64 = load ptr, ptr %s.addr
%t65 = load i32, ptr %t16
%t66 = getelementptr i8, ptr %t64, i32 %t65
%t67 = load i8, ptr %t66
%t68 = call ptr @_zen_char_to_string(i8 %t67)
%t70 = call ptr @_str_concat(ptr %t63, ptr %t68)
%t72 = load ptr, ptr %t13
call void @_zen_string_free(ptr %t72)
store ptr %t70, ptr %t13
%t73 = load i32, ptr %t16
%t74 = add i32 %t73, 1
store i32 %t74, ptr %t16
br label %end659
end659:
br label %whileCond648
whileEnd650:
%t76 = load ptr, ptr %t2
%t77 = load ptr, ptr %t13
store ptr %t77, ptr %t78
call void @_zen_list_push(ptr %t76, ptr %t78)
%t79 = load ptr, ptr %t2
ret ptr %t79
}
