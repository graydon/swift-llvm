; RUN: llc < %s -filetype=obj | llvm-readobj - -codeview | FileCheck %s

; C++ source to regenerate:
; $ cat hello.cpp
; struct A {
;   struct Nested {};
; } a;
; $ clang hello.cpp -S -emit-llvm -g -gcodeview -o t.ll

; CHECK: CodeViewTypes [
; CHECK:   Section: .debug$T (5)
; CHECK:   Magic: 0x4
; CHECK:   Struct (0x1000) {
; CHECK:     TypeLeafKind: LF_STRUCTURE (0x1505)
; CHECK:     MemberCount: 0
; CHECK:     Properties [ (0x280)
; CHECK:       ForwardReference (0x80)
; CHECK:       HasUniqueName (0x200)
; CHECK:     ]
; CHECK:     FieldList: 0x0
; CHECK:     DerivedFrom: 0x0
; CHECK:     VShape: 0x0
; CHECK:     SizeOf: 0
; CHECK:     Name: A
; CHECK:     LinkageName: .?AUA@@
; CHECK:   }
; CHECK:   Struct (0x1001) {
; CHECK:     TypeLeafKind: LF_STRUCTURE (0x1505)
; CHECK:     MemberCount: 0
; CHECK:     Properties [ (0x288)
; CHECK:       ForwardReference (0x80)
; CHECK:       HasUniqueName (0x200)
; CHECK:     ]
; CHECK:     FieldList: 0x0
; CHECK:     DerivedFrom: 0x0
; CHECK:     VShape: 0x0
; CHECK:     SizeOf: 0
; CHECK:     Name: A::Nested
; CHECK:     LinkageName: .?AUNested@A@@
; CHECK:   }
; CHECK:   FieldList (0x1002) {
; CHECK:     TypeLeafKind: LF_FIELDLIST (0x1203)
; CHECK:     NestedType {
; CHECK:       Type: A::Nested (0x1001)
; CHECK:       Name: Nested
; CHECK:     }
; CHECK:   }
; CHECK:   Struct (0x1003) {
; CHECK:     TypeLeafKind: LF_STRUCTURE (0x1505)
; CHECK:     MemberCount: 1
; CHECK:     Properties [ (0x210)
; CHECK:       ContainsNestedClass (0x10)
; CHECK:       HasUniqueName (0x200)
; CHECK:     ]
; CHECK:     FieldList: <field list> (0x1002)
; CHECK:     DerivedFrom: 0x0
; CHECK:     VShape: 0x0
; CHECK:     SizeOf: 1
; CHECK:     Name: A
; CHECK:     LinkageName: .?AUA@@
; CHECK:   }
; CHECK:   StringId (0x1004) {
; CHECK:     TypeLeafKind: LF_STRING_ID (0x1605)
; CHECK:     Id: 0x0
; CHECK:     StringData: D:\src\hello\hello.cpp
; CHECK:   }
; CHECK:   UdtSourceLine (0x1005) {
; CHECK:     TypeLeafKind: LF_UDT_SRC_LINE (0x1606)
; CHECK:     UDT: A (0x1003)
; CHECK:     SourceFile: D:\src\hello\hello.cpp (0x1004)
; CHECK:     LineNumber: 1
; CHECK:   }
; CHECK: ]

; ModuleID = 'hello.cpp'
source_filename = "hello.cpp"
target datalayout = "e-m:x-p:32:32-i64:64-f80:32-n8:16:32-a:0:32-S32"
target triple = "i686-pc-windows-msvc19.0.23918"

%struct.A = type { i8 }

@"\01?a@@3UA@@A" = global %struct.A zeroinitializer, align 1, !dbg !4

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!8, !9}
!llvm.ident = !{!10}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus, file: !1, producer: "clang version 3.9.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, globals: !3)
!1 = !DIFile(filename: "hello.cpp", directory: "D:\5Csrc\5Chello")
!2 = !{}
!3 = !{!4}
!4 = distinct !DIGlobalVariable(name: "a", linkageName: "\01?a@@3UA@@A", scope: !0, file: !1, line: 3, type: !5, isLocal: false, isDefinition: true)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "A", file: !1, line: 1, size: 8, align: 8, elements: !6, identifier: ".?AUA@@")
!6 = !{!7}
!7 = !DICompositeType(tag: DW_TAG_structure_type, name: "Nested", scope: !5, file: !1, line: 2, size: 8, align: 8, flags: DIFlagFwdDecl, identifier: ".?AUNested@A@@")
!8 = !{i32 2, !"CodeView", i32 1}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{!"clang version 3.9.0 "}
