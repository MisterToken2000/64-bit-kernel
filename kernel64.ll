; ModuleID = 'kernel.c'
source_filename = "kernel.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@vidptr = dso_local global i8* inttoptr (i64 753664 to i8*), align 8
@i = dso_local global i32 0, align 4
@current_loc = dso_local global i32 0, align 4
@.str = private unnamed_addr constant [13 x i8] c"(BIOS mode)\0A\00", align 1

; Function Attrs: noinline nounwind optnone
define dso_local void @scroll_screen() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 0, i32* %1, align 4
  br label %2

2:                                                ; preds = %16, %0
  %3 = load i32, i32* %1, align 4
  %4 = icmp ult i32 %3, 3840
  br i1 %4, label %5, label %19

5:                                                ; preds = %2
  %6 = load i8*, i8** @vidptr, align 8
  %7 = load i32, i32* %1, align 4
  %8 = add i32 %7, 160
  %9 = zext i32 %8 to i64
  %10 = getelementptr inbounds i8, i8* %6, i64 %9
  %11 = load i8, i8* %10, align 1
  %12 = load i8*, i8** @vidptr, align 8
  %13 = load i32, i32* %1, align 4
  %14 = zext i32 %13 to i64
  %15 = getelementptr inbounds i8, i8* %12, i64 %14
  store i8 %11, i8* %15, align 1
  br label %16

16:                                               ; preds = %5
  %17 = load i32, i32* %1, align 4
  %18 = add i32 %17, 1
  store i32 %18, i32* %1, align 4
  br label %2, !llvm.loop !3

19:                                               ; preds = %2
  store i32 3840, i32* %1, align 4
  br label %20

20:                                               ; preds = %33, %19
  %21 = load i32, i32* %1, align 4
  %22 = icmp ult i32 %21, 4000
  br i1 %22, label %23, label %36

23:                                               ; preds = %20
  %24 = load i8*, i8** @vidptr, align 8
  %25 = load i32, i32* %1, align 4
  %26 = zext i32 %25 to i64
  %27 = getelementptr inbounds i8, i8* %24, i64 %26
  store i8 32, i8* %27, align 1
  %28 = load i8*, i8** @vidptr, align 8
  %29 = load i32, i32* %1, align 4
  %30 = add i32 %29, 1
  %31 = zext i32 %30 to i64
  %32 = getelementptr inbounds i8, i8* %28, i64 %31
  store i8 7, i8* %32, align 1
  br label %33

33:                                               ; preds = %23
  %34 = load i32, i32* %1, align 4
  %35 = add i32 %34, 2
  store i32 %35, i32* %1, align 4
  br label %20, !llvm.loop !5

36:                                               ; preds = %20
  store i32 3840, i32* @current_loc, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @newline() #0 {
  %1 = alloca i32, align 4
  store i32 160, i32* %1, align 4
  %2 = load i32, i32* @current_loc, align 4
  %3 = load i32, i32* %1, align 4
  %4 = load i32, i32* @current_loc, align 4
  %5 = load i32, i32* %1, align 4
  %6 = urem i32 %4, %5
  %7 = sub i32 %3, %6
  %8 = add i32 %2, %7
  store i32 %8, i32* @current_loc, align 4
  %9 = load i32, i32* @current_loc, align 4
  %10 = icmp uge i32 %9, 2000
  br i1 %10, label %11, label %12

11:                                               ; preds = %0
  call void @scroll_screen() #1
  br label %12

12:                                               ; preds = %11, %0
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @clear_screen() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  br label %2

2:                                                ; preds = %5, %0
  %3 = load i32, i32* %1, align 4
  %4 = icmp ult i32 %3, 2000
  br i1 %4, label %5, label %16

5:                                                ; preds = %2
  %6 = load i8*, i8** @vidptr, align 8
  %7 = load i32, i32* %1, align 4
  %8 = add i32 %7, 1
  store i32 %8, i32* %1, align 4
  %9 = zext i32 %7 to i64
  %10 = getelementptr inbounds i8, i8* %6, i64 %9
  store i8 32, i8* %10, align 1
  %11 = load i8*, i8** @vidptr, align 8
  %12 = load i32, i32* %1, align 4
  %13 = add i32 %12, 1
  store i32 %13, i32* %1, align 4
  %14 = zext i32 %12 to i64
  %15 = getelementptr inbounds i8, i8* %11, i64 %14
  store i8 7, i8* %15, align 1
  br label %2, !llvm.loop !6

16:                                               ; preds = %2
  store i32 0, i32* @current_loc, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @print(i8* noundef %0) #0 {
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  store i8* %0, i8** %2, align 8
  store i32 0, i32* %3, align 4
  br label %4

4:                                                ; preds = %43, %1
  %5 = load i8*, i8** %2, align 8
  %6 = load i32, i32* %3, align 4
  %7 = zext i32 %6 to i64
  %8 = getelementptr inbounds i8, i8* %5, i64 %7
  %9 = load i8, i8* %8, align 1
  %10 = sext i8 %9 to i32
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %44

12:                                               ; preds = %4
  %13 = load i8*, i8** %2, align 8
  %14 = load i32, i32* %3, align 4
  %15 = zext i32 %14 to i64
  %16 = getelementptr inbounds i8, i8* %13, i64 %15
  %17 = load i8, i8* %16, align 1
  %18 = sext i8 %17 to i32
  %19 = icmp eq i32 %18, 10
  br i1 %19, label %20, label %23

20:                                               ; preds = %12
  call void @newline() #1
  %21 = load i32, i32* %3, align 4
  %22 = add i32 %21, 1
  store i32 %22, i32* %3, align 4
  br label %23

23:                                               ; preds = %20, %12
  %24 = load i8*, i8** %2, align 8
  %25 = load i32, i32* %3, align 4
  %26 = add i32 %25, 1
  store i32 %26, i32* %3, align 4
  %27 = zext i32 %25 to i64
  %28 = getelementptr inbounds i8, i8* %24, i64 %27
  %29 = load i8, i8* %28, align 1
  %30 = load i8*, i8** @vidptr, align 8
  %31 = load i32, i32* @current_loc, align 4
  %32 = add i32 %31, 1
  store i32 %32, i32* @current_loc, align 4
  %33 = zext i32 %31 to i64
  %34 = getelementptr inbounds i8, i8* %30, i64 %33
  store i8 %29, i8* %34, align 1
  %35 = load i8*, i8** @vidptr, align 8
  %36 = load i32, i32* @current_loc, align 4
  %37 = add i32 %36, 1
  store i32 %37, i32* @current_loc, align 4
  %38 = zext i32 %36 to i64
  %39 = getelementptr inbounds i8, i8* %35, i64 %38
  store i8 7, i8* %39, align 1
  %40 = load i32, i32* @current_loc, align 4
  %41 = icmp uge i32 %40, 2000
  br i1 %41, label %42, label %43

42:                                               ; preds = %23
  call void @scroll_screen() #1
  br label %43

43:                                               ; preds = %42, %23
  br label %4, !llvm.loop !7

44:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @shutdown() #0 {
  call void asm sideeffect "movw $$0x2000, %ax; movw $$0x604, %dx; outw %ax, %dx", "~{ax},~{dx},~{dirflag},~{fpsr},~{flags}"() #2, !srcloc !8
  ret void
}

; Function Attrs: noinline nounwind optnone
define dso_local void @_start() #0 {
  call void @clear_screen() #1
  call void @print(i8* noundef getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0)) #1
  br label %1

1:                                                ; preds = %0, %1
  br label %1
}

attributes #0 = { noinline nounwind optnone "frame-pointer"="all" "min-legal-vector-width"="0" "no-builtins" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nobuiltin "no-builtins" }
attributes #2 = { nounwind }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"frame-pointer", i32 2}
!2 = !{!"Debian clang version 14.0.6"}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.mustprogress"}
!5 = distinct !{!5, !4}
!6 = distinct !{!6, !4}
!7 = distinct !{!7, !4}
!8 = !{i64 1217}
