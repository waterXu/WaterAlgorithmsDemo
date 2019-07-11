	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.p2align	4, 0x90         ## -- Begin function +[TestClang testBlcok]
"+[TestClang testBlcok]":               ## @"\01+[TestClang testBlcok]"
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___objc_personality_v0
	.cfi_lsda 16, Lexception0
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$288, %rsp              ## imm = 0x120
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	L_OBJC_CLASSLIST_REFERENCES_$_(%rip), %rdi
	movq	L_OBJC_SELECTOR_REFERENCES_(%rip), %rsi
	movq	_objc_msgSend@GOTPCREL(%rip), %rax
	movq	%rax, -280(%rbp)        ## 8-byte Spill
	callq	*%rax
	movq	L_OBJC_SELECTOR_REFERENCES_.2(%rip), %rsi
	movq	%rax, %rdi
	movq	-280(%rbp), %rax        ## 8-byte Reload
	callq	*%rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdi
	movq	L_OBJC_SELECTOR_REFERENCES_.4(%rip), %rsi
	movl	$10, %ecx
	movl	%ecx, %edx
	movq	-280(%rbp), %rax        ## 8-byte Reload
	callq	*%rax
	movq	__NSConcreteStackBlock@GOTPCREL(%rip), %rax
	movq	%rax, -72(%rbp)
	movl	$-1040187392, -64(%rbp) ## imm = 0xC2000000
	movl	$0, -60(%rbp)
	leaq	"___22+[TestClang testBlcok]_block_invoke"(%rip), %rdx
	movq	%rdx, -56(%rbp)
	leaq	"___block_descriptor_40_e8_32o_e5_v8@?0l"(%rip), %rdx
	movq	%rdx, -48(%rbp)
	movq	-24(%rbp), %rdx
	movq	%rdx, -40(%rbp)
	leaq	-72(%rbp), %rdx
	movq	%rdx, -32(%rbp)
	movq	-32(%rbp), %rsi
	leaq	L__unnamed_cfstring_.9(%rip), %rdi
	xorl	%ecx, %ecx
	movb	%cl, %r8b
	movq	%rax, -288(%rbp)        ## 8-byte Spill
	movb	%r8b, %al
	callq	_NSLog
	movq	-32(%rbp), %rdx
	movq	16(%rdx), %rsi
	movq	%rdx, %rdi
	callq	*%rsi
	movl	$10, -76(%rbp)
	movq	$0, -112(%rbp)
	leaq	-112(%rbp), %rdx
	movq	%rdx, -104(%rbp)
	movl	$536870912, -96(%rbp)   ## imm = 0x20000000
	movl	$32, -92(%rbp)
	movl	$19, -88(%rbp)
	movq	$0, -144(%rbp)
	leaq	-144(%rbp), %rsi
	movq	%rsi, -136(%rbp)
	movl	$536870912, -128(%rbp)  ## imm = 0x20000000
	movl	$32, -124(%rbp)
	movl	$30, -120(%rbp)
	movq	$0, -176(%rbp)
	leaq	-176(%rbp), %rdi
	movq	%rdi, -168(%rbp)
	movl	$536870912, -160(%rbp)  ## imm = 0x20000000
	movl	$32, -156(%rbp)
	movl	$30, -152(%rbp)
	movq	-288(%rbp), %r9         ## 8-byte Reload
	movq	%r9, -256(%rbp)
	movl	$-1040187392, -248(%rbp) ## imm = 0xC2000000
	movl	$0, -244(%rbp)
	leaq	"___22+[TestClang testBlcok]_block_invoke.10"(%rip), %r10
	movq	%r10, -240(%rbp)
	leaq	"___block_descriptor_68_e8_32o40r48r56r_e5_v8@?0l"(%rip), %r10
	movq	%r10, -232(%rbp)
	movl	-76(%rbp), %ecx
	movl	%ecx, -192(%rbp)
	movq	%rdx, -216(%rbp)
	movq	%rsi, -208(%rbp)
	movq	%rdi, -200(%rbp)
	movq	-24(%rbp), %rdx
	movq	%rdx, -224(%rbp)
	leaq	-256(%rbp), %rdx
	movq	%rdx, -184(%rbp)
	movl	$33, -76(%rbp)
	movl	$121, _testBlcok.numStatic(%rip)
	movl	$129, _numGlobel(%rip)
	movq	-104(%rbp), %rdx
	movl	$22222, 24(%rdx)        ## imm = 0x56CE
	movq	-184(%rbp), %rdx
	movq	16(%rdx), %rsi
Ltmp0:
	movq	%rdx, %rdi
	callq	*%rsi
Ltmp1:
	jmp	LBB0_1
LBB0_1:
	movq	-184(%rbp), %rsi
Ltmp2:
	leaq	L__unnamed_cfstring_.14(%rip), %rdi
	xorl	%eax, %eax
	movb	%al, %cl
	movb	%cl, %al
	callq	_NSLog
Ltmp3:
	jmp	LBB0_2
LBB0_2:
	leaq	-176(%rbp), %rax
	movq	%rax, %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	leaq	-144(%rbp), %rax
	movq	%rax, %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	addq	$288, %rsp              ## imm = 0x120
	popq	%rbp
	retq
LBB0_3:
Ltmp4:
	movl	%edx, %ecx
	movq	%rax, -264(%rbp)
	movl	%ecx, -268(%rbp)
	leaq	-176(%rbp), %rax
	movq	%rax, %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	leaq	-144(%rbp), %rax
	movq	%rax, %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	leaq	-112(%rbp), %rax
	movq	%rax, %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
## %bb.4:
	movq	-264(%rbp), %rdi
	callq	__Unwind_Resume
	ud2
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2
GCC_except_table0:
Lexception0:
	.byte	255                     ## @LPStart Encoding = omit
	.byte	255                     ## @TType Encoding = omit
	.byte	1                       ## Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0 ## >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0     ##   Call between Lfunc_begin0 and Ltmp0
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0     ## >> Call Site 2 <<
	.uleb128 Ltmp3-Ltmp0            ##   Call between Ltmp0 and Ltmp3
	.uleb128 Ltmp4-Lfunc_begin0     ##     jumps to Ltmp4
	.byte	0                       ##   On action: cleanup
	.uleb128 Ltmp3-Lfunc_begin0     ## >> Call Site 3 <<
	.uleb128 Lfunc_end0-Ltmp3       ##   Call between Ltmp3 and Lfunc_end0
	.byte	0                       ##     has no landing pad
	.byte	0                       ##   On action: cleanup
Lcst_end0:
	.p2align	2
                                        ## -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90         ## -- Begin function __22+[TestClang testBlcok]_block_invoke
"___22+[TestClang testBlcok]_block_invoke": ## @"__22+[TestClang testBlcok]_block_invoke"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rdi, %rax
	movq	%rax, -16(%rbp)
	movq	32(%rdi), %rax
	movq	L_OBJC_SELECTOR_REFERENCES_.6(%rip), %rsi
	movq	%rax, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	leaq	L__unnamed_cfstring_(%rip), %rsi
	movq	%rsi, %rdi
	movq	%rax, %rsi
	movb	$0, %al
	callq	_NSLog
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.private_extern	___copy_helper_block_e8_32o ## -- Begin function __copy_helper_block_e8_32o
	.globl	___copy_helper_block_e8_32o
	.weak_def_can_be_hidden	___copy_helper_block_e8_32o
	.p2align	4, 0x90
___copy_helper_block_e8_32o:            ## @__copy_helper_block_e8_32o
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	addq	$32, %rdi
	movq	32(%rsi), %rsi
	movl	$3, %edx
	callq	__Block_object_assign
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.private_extern	___destroy_helper_block_e8_32o ## -- Begin function __destroy_helper_block_e8_32o
	.globl	___destroy_helper_block_e8_32o
	.weak_def_can_be_hidden	___destroy_helper_block_e8_32o
	.p2align	4, 0x90
___destroy_helper_block_e8_32o:         ## @__destroy_helper_block_e8_32o
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	movq	32(%rdi), %rdi
	movl	$3, %esi
	callq	__Block_object_dispose
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function __22+[TestClang testBlcok]_block_invoke.10
"___22+[TestClang testBlcok]_block_invoke.10": ## @"__22+[TestClang testBlcok]_block_invoke.10"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	leaq	L__unnamed_cfstring_.12(%rip), %rax
	movq	%rdi, -8(%rbp)
	movq	%rdi, %rcx
	movq	%rcx, -16(%rbp)
	movl	64(%rdi), %esi
	movl	_testBlcok.numStatic(%rip), %edx
	movl	_numGlobel(%rip), %ecx
	movq	40(%rdi), %r8
	movq	8(%r8), %r8
	movl	24(%r8), %r8d
	movq	48(%rdi), %r9
	movq	8(%r9), %r9
	movl	24(%r9), %r9d
	movq	56(%rdi), %r10
	movq	8(%r10), %r10
	movl	24(%r10), %r11d
	movq	%rdi, -24(%rbp)         ## 8-byte Spill
	movq	%rax, %rdi
	movl	%r11d, (%rsp)
	movb	$0, %al
	callq	_NSLog
	movq	-24(%rbp), %rdi         ## 8-byte Reload
	movq	32(%rdi), %r10
	movq	L_OBJC_SELECTOR_REFERENCES_.6(%rip), %rsi
	movq	%r10, %rdi
	callq	*_objc_msgSend@GOTPCREL(%rip)
	leaq	L__unnamed_cfstring_(%rip), %rsi
	movq	%rsi, %rdi
	movq	%rax, %rsi
	movb	$0, %al
	callq	_NSLog
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.private_extern	___copy_helper_block_e8_32o40r48r56r ## -- Begin function __copy_helper_block_e8_32o40r48r56r
	.globl	___copy_helper_block_e8_32o40r48r56r
	.weak_def_can_be_hidden	___copy_helper_block_e8_32o40r48r56r
	.p2align	4, 0x90
___copy_helper_block_e8_32o40r48r56r:   ## @__copy_helper_block_e8_32o40r48r56r
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rdi
	movq	%rdi, %rax
	addq	$32, %rax
	movq	32(%rsi), %rcx
	movq	%rdi, -24(%rbp)         ## 8-byte Spill
	movq	%rax, %rdi
	movq	%rsi, -32(%rbp)         ## 8-byte Spill
	movq	%rcx, %rsi
	movl	$3, %edx
	callq	__Block_object_assign
	movq	-24(%rbp), %rax         ## 8-byte Reload
	addq	$40, %rax
	movq	-32(%rbp), %rcx         ## 8-byte Reload
	movq	40(%rcx), %rsi
	movq	%rax, %rdi
	movl	$8, %edx
	callq	__Block_object_assign
	movq	-24(%rbp), %rax         ## 8-byte Reload
	addq	$48, %rax
	movq	-32(%rbp), %rcx         ## 8-byte Reload
	movq	48(%rcx), %rsi
	movq	%rax, %rdi
	movl	$8, %edx
	callq	__Block_object_assign
	movq	-24(%rbp), %rax         ## 8-byte Reload
	addq	$56, %rax
	movq	-32(%rbp), %rcx         ## 8-byte Reload
	movq	56(%rcx), %rsi
	movq	%rax, %rdi
	movl	$8, %edx
	callq	__Block_object_assign
	addq	$32, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.private_extern	___destroy_helper_block_e8_32o40r48r56r ## -- Begin function __destroy_helper_block_e8_32o40r48r56r
	.globl	___destroy_helper_block_e8_32o40r48r56r
	.weak_def_can_be_hidden	___destroy_helper_block_e8_32o40r48r56r
	.p2align	4, 0x90
___destroy_helper_block_e8_32o40r48r56r: ## @__destroy_helper_block_e8_32o40r48r56r
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	movq	56(%rdi), %rax
	movq	%rdi, -16(%rbp)         ## 8-byte Spill
	movq	%rax, %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	movq	-16(%rbp), %rax         ## 8-byte Reload
	movq	48(%rax), %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	movq	-16(%rbp), %rax         ## 8-byte Reload
	movq	40(%rax), %rdi
	movl	$8, %esi
	callq	__Block_object_dispose
	movq	-16(%rbp), %rax         ## 8-byte Reload
	movq	32(%rax), %rdi
	movl	$3, %esi
	callq	__Block_object_dispose
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[TestClang value]
"-[TestClang value]":                   ## @"\01-[TestClang value]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rsi
	movq	_OBJC_IVAR_$_TestClang._value(%rip), %rdi
	movq	(%rsi,%rdi), %rax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.p2align	4, 0x90         ## -- Begin function -[TestClang setValue:]
"-[TestClang setValue:]":               ## @"\01-[TestClang setValue:]"
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rsi
	movq	_OBJC_IVAR_$_TestClang._value(%rip), %rdi
	movq	%rdx, (%rsi,%rdi)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.section	__DATA,__objc_data
	.globl	_OBJC_CLASS_$_TestClang ## @"OBJC_CLASS_$_TestClang"
	.p2align	3
_OBJC_CLASS_$_TestClang:
	.quad	_OBJC_METACLASS_$_TestClang
	.quad	_OBJC_CLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	l_OBJC_CLASS_RO_$_TestClang

	.section	__DATA,__objc_classrefs,regular,no_dead_strip
	.p2align	3               ## @"OBJC_CLASSLIST_REFERENCES_$_"
L_OBJC_CLASSLIST_REFERENCES_$_:
	.quad	_OBJC_CLASS_$_TestClang

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_:                  ## @OBJC_METH_VAR_NAME_
	.asciz	"alloc"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_
L_OBJC_SELECTOR_REFERENCES_:
	.quad	L_OBJC_METH_VAR_NAME_

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.1:                ## @OBJC_METH_VAR_NAME_.1
	.asciz	"init"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.2
L_OBJC_SELECTOR_REFERENCES_.2:
	.quad	L_OBJC_METH_VAR_NAME_.1

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.3:                ## @OBJC_METH_VAR_NAME_.3
	.asciz	"setValue:"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.4
L_OBJC_SELECTOR_REFERENCES_.4:
	.quad	L_OBJC_METH_VAR_NAME_.3

	.section	__TEXT,__ustring
	.p2align	1               ## @.str
l_.str:
	.short	21704                   ## 0x54c8
	.short	21704                   ## 0x54c8
	.short	21704                   ## 0x54c8
	.short	32                      ## 0x20
	.short	37                      ## 0x25
	.short	108                     ## 0x6c
	.short	100                     ## 0x64
	.short	0                       ## 0x0

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_
L__unnamed_cfstring_:
	.quad	___CFConstantStringClassReference
	.long	2000                    ## 0x7d0
	.space	4
	.quad	l_.str
	.quad	7                       ## 0x7

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.5:                ## @OBJC_METH_VAR_NAME_.5
	.asciz	"value"

	.section	__DATA,__objc_selrefs,literal_pointers,no_dead_strip
	.p2align	3               ## @OBJC_SELECTOR_REFERENCES_.6
L_OBJC_SELECTOR_REFERENCES_.6:
	.quad	L_OBJC_METH_VAR_NAME_.5

	.section	__TEXT,__cstring,cstring_literals
L_.str.7:                               ## @.str.7
	.asciz	"v8@?0"

	.private_extern	"___block_descriptor_40_e8_32o_e5_v8@?0l" ## @"__block_descriptor_40_e8_32o_e5_v8@?0l"
	.section	__DATA,__const
	.globl	"___block_descriptor_40_e8_32o_e5_v8@?0l"
	.weak_def_can_be_hidden	"___block_descriptor_40_e8_32o_e5_v8@?0l"
	.p2align	3
"___block_descriptor_40_e8_32o_e5_v8@?0l":
	.quad	0                       ## 0x0
	.quad	40                      ## 0x28
	.quad	___copy_helper_block_e8_32o
	.quad	___destroy_helper_block_e8_32o
	.quad	L_.str.7
	.quad	256                     ## 0x100

	.section	__TEXT,__cstring,cstring_literals
L_.str.8:                               ## @.str.8
	.asciz	" block1 = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.9
L__unnamed_cfstring_.9:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.8
	.quad	12                      ## 0xc

	.section	__DATA,__data
	.p2align	2               ## @testBlcok.numStatic
_testBlcok.numStatic:
	.long	12                      ## 0xc

	.section	__TEXT,__cstring,cstring_literals
L_.str.11:                              ## @.str.11
	.asciz	"just a block === %d, numStatic = %d numGlobel = %d  numBlock=%d numBlock2=%d numBlockTest = %d"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.12
L__unnamed_cfstring_.12:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.11
	.quad	94                      ## 0x5e

	.section	__DATA,__data
	.p2align	2               ## @numGlobel
_numGlobel:
	.long	29                      ## 0x1d

	.private_extern	"___block_descriptor_68_e8_32o40r48r56r_e5_v8@?0l" ## @"__block_descriptor_68_e8_32o40r48r56r_e5_v8@?0l"
	.section	__DATA,__const
	.globl	"___block_descriptor_68_e8_32o40r48r56r_e5_v8@?0l"
	.weak_def_can_be_hidden	"___block_descriptor_68_e8_32o40r48r56r_e5_v8@?0l"
	.p2align	3
"___block_descriptor_68_e8_32o40r48r56r_e5_v8@?0l":
	.quad	0                       ## 0x0
	.quad	68                      ## 0x44
	.quad	___copy_helper_block_e8_32o40r48r56r
	.quad	___destroy_helper_block_e8_32o40r48r56r
	.quad	L_.str.7
	.quad	304                     ## 0x130

	.section	__TEXT,__cstring,cstring_literals
L_.str.13:                              ## @.str.13
	.asciz	"block2 = %@"

	.section	__DATA,__cfstring
	.p2align	3               ## @_unnamed_cfstring_.14
L__unnamed_cfstring_.14:
	.quad	___CFConstantStringClassReference
	.long	1992                    ## 0x7c8
	.space	4
	.quad	L_.str.13
	.quad	11                      ## 0xb

	.private_extern	_OBJC_IVAR_$_TestClang._value ## @"OBJC_IVAR_$_TestClang._value"
	.section	__DATA,__objc_ivar
	.globl	_OBJC_IVAR_$_TestClang._value
	.p2align	3
_OBJC_IVAR_$_TestClang._value:
	.quad	8                       ## 0x8

	.section	__TEXT,__objc_classname,cstring_literals
L_OBJC_CLASS_NAME_:                     ## @OBJC_CLASS_NAME_
	.asciz	"TestClang"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.15:               ## @OBJC_METH_VAR_NAME_.15
	.asciz	"testBlcok"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_:                  ## @OBJC_METH_VAR_TYPE_
	.asciz	"v16@0:8"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_CLASS_METHODS_TestClang"
l_OBJC_$_CLASS_METHODS_TestClang:
	.long	24                      ## 0x18
	.long	1                       ## 0x1
	.quad	L_OBJC_METH_VAR_NAME_.15
	.quad	L_OBJC_METH_VAR_TYPE_
	.quad	"+[TestClang testBlcok]"

	.p2align	3               ## @"\01l_OBJC_METACLASS_RO_$_TestClang"
l_OBJC_METACLASS_RO_$_TestClang:
	.long	1                       ## 0x1
	.long	40                      ## 0x28
	.long	40                      ## 0x28
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_
	.quad	l_OBJC_$_CLASS_METHODS_TestClang
	.quad	0
	.quad	0
	.quad	0
	.quad	0

	.section	__DATA,__objc_data
	.globl	_OBJC_METACLASS_$_TestClang ## @"OBJC_METACLASS_$_TestClang"
	.p2align	3
_OBJC_METACLASS_$_TestClang:
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	_OBJC_METACLASS_$_NSObject
	.quad	__objc_empty_cache
	.quad	0
	.quad	l_OBJC_METACLASS_RO_$_TestClang

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.16:               ## @OBJC_METH_VAR_TYPE_.16
	.asciz	"q16@0:8"

L_OBJC_METH_VAR_TYPE_.17:               ## @OBJC_METH_VAR_TYPE_.17
	.asciz	"v24@0:8q16"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_INSTANCE_METHODS_TestClang"
l_OBJC_$_INSTANCE_METHODS_TestClang:
	.long	24                      ## 0x18
	.long	2                       ## 0x2
	.quad	L_OBJC_METH_VAR_NAME_.5
	.quad	L_OBJC_METH_VAR_TYPE_.16
	.quad	"-[TestClang value]"
	.quad	L_OBJC_METH_VAR_NAME_.3
	.quad	L_OBJC_METH_VAR_TYPE_.17
	.quad	"-[TestClang setValue:]"

	.section	__TEXT,__objc_methname,cstring_literals
L_OBJC_METH_VAR_NAME_.18:               ## @OBJC_METH_VAR_NAME_.18
	.asciz	"_value"

	.section	__TEXT,__objc_methtype,cstring_literals
L_OBJC_METH_VAR_TYPE_.19:               ## @OBJC_METH_VAR_TYPE_.19
	.asciz	"q"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_INSTANCE_VARIABLES_TestClang"
l_OBJC_$_INSTANCE_VARIABLES_TestClang:
	.long	32                      ## 0x20
	.long	1                       ## 0x1
	.quad	_OBJC_IVAR_$_TestClang._value
	.quad	L_OBJC_METH_VAR_NAME_.18
	.quad	L_OBJC_METH_VAR_TYPE_.19
	.long	3                       ## 0x3
	.long	8                       ## 0x8

	.section	__TEXT,__cstring,cstring_literals
L_OBJC_PROP_NAME_ATTR_:                 ## @OBJC_PROP_NAME_ATTR_
	.asciz	"value"

L_OBJC_PROP_NAME_ATTR_.20:              ## @OBJC_PROP_NAME_ATTR_.20
	.asciz	"Tq,N,V_value"

	.section	__DATA,__objc_const
	.p2align	3               ## @"\01l_OBJC_$_PROP_LIST_TestClang"
l_OBJC_$_PROP_LIST_TestClang:
	.long	16                      ## 0x10
	.long	1                       ## 0x1
	.quad	L_OBJC_PROP_NAME_ATTR_
	.quad	L_OBJC_PROP_NAME_ATTR_.20

	.p2align	3               ## @"\01l_OBJC_CLASS_RO_$_TestClang"
l_OBJC_CLASS_RO_$_TestClang:
	.long	0                       ## 0x0
	.long	8                       ## 0x8
	.long	16                      ## 0x10
	.space	4
	.quad	0
	.quad	L_OBJC_CLASS_NAME_
	.quad	l_OBJC_$_INSTANCE_METHODS_TestClang
	.quad	0
	.quad	l_OBJC_$_INSTANCE_VARIABLES_TestClang
	.quad	0
	.quad	l_OBJC_$_PROP_LIST_TestClang

	.section	__DATA,__objc_classlist,regular,no_dead_strip
	.p2align	3               ## @"OBJC_LABEL_CLASS_$"
L_OBJC_LABEL_CLASS_$:
	.quad	_OBJC_CLASS_$_TestClang

	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	64


.subsections_via_symbols
