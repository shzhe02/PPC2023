	.file	"cp.cc"
	.text
	.p2align 4
	.globl	_Z9correlateiiPKfPf
	.type	_Z9correlateiiPKfPf, @function
_Z9correlateiiPKfPf:
.LFB967:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	leal	(%rdi,%rdi), %eax
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	cltq
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	leaq	0(,%rax,8), %rax
	subq	$120, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rcx, -96(%rbp)
	subq	%rax, %rsp
	testl	%edi, %edi
	jle	.L2
	movslq	%edi, %rax
	movq	%rsp, %r14
	movl	%esi, %r13d
	movq	%rdx, %r15
	leaq	0(,%rax,8), %rcx
	movl	%edi, %r8d
	vxorps	%xmm3, %xmm3, %xmm3
	movq	%r14, %rdx
	leaq	(%r14,%rcx), %rsi
	movq	%rax, -88(%rbp)
	xorl	%r9d, %r9d
	movslq	%r13d, %r11
	movq	%rsi, %r10
	.p2align 4
	.p2align 3
.L4:
	movq	$0x000000000, (%rdx)
	movq	$0x000000000, (%rsi)
	testl	%r13d, %r13d
	jle	.L7
	movslq	%r9d, %rdi
	leaq	(%r15,%rdi,4), %rax
	addq	%r11, %rdi
	leaq	(%r15,%rdi,4), %rdi
	.p2align 4
	.p2align 3
.L6:
	vcvtss2sd	(%rax), %xmm3, %xmm0
	vaddsd	(%rdx), %xmm0, %xmm1
	addq	$4, %rax
	vmovsd	%xmm1, (%rdx)
	vfmadd213sd	(%rsi), %xmm0, %xmm0
	vmovsd	%xmm0, (%rsi)
	cmpq	%rax, %rdi
	jne	.L6
.L7:
	addq	$8, %rdx
	addq	$8, %rsi
	addl	%r13d, %r9d
	cmpq	%rdx, %r10
	jne	.L4
#APP
# 13 "cp.cc" 1
	# Main Loop
# 0 "" 2
#NO_APP
	xorl	%esi, %esi
	xorl	%eax, %eax
	movslq	%r13d, %rbx
	xorl	%edi, %edi
	xorl	%edx, %edx
	movq	%rbx, -56(%rbp)
	movq	%rax, -64(%rbp)
	movq	%rsi, -72(%rbp)
	movq	%rcx, -80(%rbp)
	vcvtsi2sdl	%r13d, %xmm3, %xmm1
	.p2align 4
	.p2align 3
.L9:
	movq	-64(%rbp), %rbx
	movslq	%edx, %r9
	movl	%edi, %r12d
	vmovsd	%xmm1, %xmm1, %xmm6
	movq	-80(%rbp), %rax
	movq	-96(%rbp), %rcx
	vmovsd	(%r14,%rbx,8), %xmm5
	leaq	(%rcx,%r9,4), %r10
	movq	-72(%rbp), %rcx
	leaq	(%rcx,%rax), %r9
	vmulsd	%xmm5, %xmm5, %xmm4
	vfmsub231sd	(%r14,%rax), %xmm1, %xmm4
	.p2align 4
	.p2align 3
.L17:
	vxorpd	%xmm2, %xmm2, %xmm2
	testl	%r13d, %r13d
	jle	.L16
	movq	-56(%rbp), %rsi
	movslq	%r12d, %r11
	vxorpd	%xmm2, %xmm2, %xmm2
	leaq	(%r15,%r11,4), %rax
	leaq	(%rsi,%r11), %rcx
	leaq	(%r15,%rcx,4), %rsi
	movslq	%edi, %rcx
	subq	%r11, %rcx
	.p2align 4
	.p2align 3
.L10:
	vcvtss2sd	(%rax,%rcx,4), %xmm3, %xmm0
	addq	$4, %rax
	vcvtss2sd	-4(%rax), %xmm3, %xmm1
	vmulsd	%xmm1, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm2, %xmm2
	cmpq	%rax, %rsi
	jne	.L10
.L16:
	vmovsd	(%r14,%rbx,8), %xmm0
	leaq	(%r14,%r9), %rax
	vmulsd	%xmm5, %xmm0, %xmm1
	vmulsd	%xmm0, %xmm0, %xmm0
	vfmsub231sd	(%rax,%rbx,8), %xmm6, %xmm0
	vfmsub132sd	%xmm6, %xmm1, %xmm2
	vxorpd	%xmm1, %xmm1, %xmm1
	vmulsd	%xmm4, %xmm0, %xmm0
	vucomisd	%xmm0, %xmm1
	ja	.L23
	vsqrtsd	%xmm0, %xmm0, %xmm0
	vdivsd	%xmm0, %xmm2, %xmm2
	addl	%r13d, %r12d
	vcvtsd2ss	%xmm2, %xmm2, %xmm2
	vmovss	%xmm2, (%r10,%rbx,4)
	incq	%rbx
	cmpl	%ebx, %r8d
	jg	.L17
.L24:
	incq	-64(%rbp)
	addq	$8, -80(%rbp)
	vmovsd	%xmm6, %xmm6, %xmm1
	addl	%r8d, %edx
	subq	$8, -72(%rbp)
	movq	-64(%rbp), %rax
	addl	%r13d, %edi
	cmpq	%rax, -88(%rbp)
	jne	.L9
.L8:
#APP
# 25 "cp.cc" 1
	# Main Loop Done
# 0 "" 2
#NO_APP
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L2:
	.cfi_restore_state
#APP
# 13 "cp.cc" 1
	# Main Loop
# 0 "" 2
#NO_APP
	jmp	.L8
.L23:
	vmovsd	%xmm6, -160(%rbp)
	movq	%r9, -152(%rbp)
	movl	%r8d, -140(%rbp)
	addl	%r13d, %r12d
	movl	%edx, -136(%rbp)
	movl	%edi, -132(%rbp)
	movq	%r10, -128(%rbp)
	vmovsd	%xmm4, -120(%rbp)
	vmovsd	%xmm5, -112(%rbp)
	vmovsd	%xmm2, -104(%rbp)
	call	sqrt
	vmovsd	-104(%rbp), %xmm2
	vxorps	%xmm3, %xmm3, %xmm3
	movq	-128(%rbp), %r10
	movl	-140(%rbp), %r8d
	vmovsd	-112(%rbp), %xmm5
	vmovsd	-120(%rbp), %xmm4
	vmovsd	-160(%rbp), %xmm6
	movl	-132(%rbp), %edi
	movl	-136(%rbp), %edx
	movq	-152(%rbp), %r9
	vdivsd	%xmm0, %xmm2, %xmm2
	vcvtsd2ss	%xmm2, %xmm2, %xmm2
	vmovss	%xmm2, (%r10,%rbx,4)
	incq	%rbx
	cmpl	%ebx, %r8d
	jg	.L17
	jmp	.L24
	.cfi_endproc
.LFE967:
	.size	_Z9correlateiiPKfPf, .-_Z9correlateiiPKfPf
	.ident	"GCC: (GNU) 12.2.1 20221121 (Red Hat 12.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
