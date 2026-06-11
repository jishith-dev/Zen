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
@.str.e_m_0 = private unnamed_addr constant [6 x i8] c"Hello\00"
@.str.e_m_1 = private unnamed_addr constant [4 x i8] c"Zen\00"
define %ZenList* @getList () {
entry:

%t1 = call ptr @zen_list_new(i64 8)
%t2 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.e_m_0, i32 0, i32 0
%t3 = alloca i8*
store i8* %t2, ptr %t3
call void @zen_list_push(ptr %t1, ptr %t3)
%t4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.e_m_1, i32 0, i32 0
%t5 = alloca i8*
store i8* %t4, ptr %t5
call void @zen_list_push(ptr %t1, ptr %t5)
%t0 = alloca ptr
store ptr %t1, ptr %t0
%t6 = load ptr, ptr %t0
ret ptr %t6
}