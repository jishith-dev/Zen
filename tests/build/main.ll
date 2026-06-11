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
define void @screen_string_main_0(i8* %x) {
entry:
  call i32 (i8*, ...) @printf(i8* getelementptr ([4 x i8], [4 x i8]* @.fmt_string_main_0, i32 0, i32 0),
    i8* %x)
  call i32 @fflush(i8* null)
  ret void
}
@.fmt_string_main_0 = private constant [4 x i8] c"%s\0A\00"
declare i32 @fflush(i8*)
declare i32 @printf(i8*, ...)
declare ptr @zen_list_get(ptr, i32)
%ZenList = type { ptr, i32, i32, i64 }
declare ptr @getList()

define i32 @main() { 
entry:

%t0 = alloca i32
store i32 0, ptr %t0
%t1 = call ptr @getList()
%t2 = getelementptr inbounds %ZenList, ptr %t1, i32 0, i32 1
%t4 = load i32, ptr %t2
br label %arr_start0
arr_start0:
%t5 = load i32, ptr %t0
%t6 = icmp slt i32 %t5, %t4
br i1 %t6, label %arr_body1, label %arr_end2
arr_body1:
%t9 = call ptr @zen_list_get(ptr %t1, i32 %t5)
%t10 = load i8*, ptr %t9
call void @screen_string_main_0(i8* %t10)
br label %arr_inc3
arr_inc3:
%t11 = add i32 %t5, 1
store i32 %t11, ptr %t0
br label %arr_start0
arr_end2:
ret i32 0 
}