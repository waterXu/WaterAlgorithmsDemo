	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 10, 14	sdk_version 10, 14
	.globl	_add_a_and_b            ## -- Begin function add_a_and_b
	.p2align	4, 0x90
_add_a_and_b:                           ## @add_a_and_b
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %esi
	addl	-8(%rbp), %esi
	movl	%esi, %eax
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	_test                   ## -- Begin function test
	.p2align	4, 0x90
_test:                                  ## @test
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$2, %edi
	movl	$3, %esi
	callq	_add_a_and_b
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function

.subsections_via_symbols




_add_a_and_b:
push   %ebx
mov    %eax, [%esp+8]
mov    %ebx, [%esp+12]
add    %eax, %ebx
pop    %ebx
ret

_main:
push   3
push   2
call   _add_a_and_b
add    %esp, 8
ret
