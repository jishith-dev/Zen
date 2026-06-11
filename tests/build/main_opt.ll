; ModuleID = '/storage/emulated/0/zen/tests/build/main.ll'
source_filename = "/storage/emulated/0/zen/tests/build/main.ll"

; Function Attrs: nofree nounwind
define void @screen_string_main_0(ptr readonly captures(none) %x) local_unnamed_addr #0 {
entry:
  %puts = tail call i32 @puts(ptr nonnull dereferenceable(1) %x)
  %0 = tail call i32 @fflush(ptr null)
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @fflush(ptr noundef captures(none)) local_unnamed_addr #0

declare ptr @zen_list_get(ptr, i32) local_unnamed_addr

declare ptr @getList() local_unnamed_addr

define noundef i32 @main() local_unnamed_addr {
entry:
  %t1 = tail call ptr @getList()
  %t2 = getelementptr inbounds nuw i8, ptr %t1, i64 8
  %t4 = load i32, ptr %t2, align 4
  %t61 = icmp sgt i32 %t4, 0
  br i1 %t61, label %arr_body1, label %arr_end2

arr_body1:                                        ; preds = %entry, %arr_body1
  %t0.02 = phi i32 [ %t11, %arr_body1 ], [ 0, %entry ]
  %t9 = tail call ptr @zen_list_get(ptr nonnull %t1, i32 %t0.02)
  %t10 = load ptr, ptr %t9, align 8
  %puts.i = tail call i32 @puts(ptr nonnull readonly dereferenceable(1) %t10)
  %0 = tail call i32 @fflush(ptr null)
  %t11 = add nuw nsw i32 %t0.02, 1
  %t6 = icmp slt i32 %t11, %t4
  br i1 %t6, label %arr_body1, label %arr_end2

arr_end2:                                         ; preds = %arr_body1, %entry
  ret i32 0
}

; Function Attrs: nofree nounwind
declare noundef i32 @puts(ptr noundef readonly captures(none)) local_unnamed_addr #0

attributes #0 = { nofree nounwind }
