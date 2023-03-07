	.file	"cp_naive.cc"
	.text
.Ltext0:
	.file 0 "/home/rv/Documents/university/PPC/cp1" "cp_naive.cc"
	.p2align 4
	.globl	_Z9correlateiiPKfPf
	.type	_Z9correlateiiPKfPf, @function
_Z9correlateiiPKfPf:
.LVL0:
.LFB967:
	.file 1 "cp_naive.cc"
	.loc 1 2 66 view -0
	.cfi_startproc
	.loc 1 3 5 view .LVU1
	.loc 1 2 66 is_stmt 0 view .LVU2
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	.loc 1 3 17 view .LVU3
	leal	(%rdi,%rdi), %eax
	.loc 1 2 66 view .LVU4
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	.loc 1 3 12 view .LVU5
	cltq
	.loc 1 2 66 view .LVU6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	.loc 1 3 12 view .LVU7
	leaq	0(,%rax,8), %rax
	.loc 1 2 66 view .LVU8
	subq	$120, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	.loc 1 2 66 view .LVU9
	movq	%rcx, -96(%rbp)
	.loc 1 3 12 view .LVU10
	subq	%rax, %rsp
.LVL1:
	.loc 1 4 5 is_stmt 1 view .LVU11
.LBB2:
	.loc 1 4 23 view .LVU12
	testl	%edi, %edi
	jle	.L25
	movslq	%edi, %rax
	movq	%rsp, %r14
	movl	%esi, %r13d
	movq	%rdx, %r15
	leaq	0(,%rax,8), %rcx
.LVL2:
	.loc 1 4 23 is_stmt 0 view .LVU13
	movl	%edi, %r8d
	vxorps	%xmm3, %xmm3, %xmm3
	movq	%r14, %rdx
.LVL3:
	.loc 1 4 23 view .LVU14
	leaq	(%r14,%rcx), %rsi
.LVL4:
	.loc 1 4 23 view .LVU15
	movq	%rax, -88(%rbp)
	xorl	%r9d, %r9d
	movslq	%r13d, %r11
	movq	%rsi, %r10
.LVL5:
	.p2align 4
	.p2align 3
.L4:
.LBB3:
	.loc 1 5 9 is_stmt 1 view .LVU16
	.loc 1 5 16 is_stmt 0 view .LVU17
	movq	$0x000000000, (%rdx)
	.loc 1 6 9 is_stmt 1 view .LVU18
	.loc 1 6 21 is_stmt 0 view .LVU19
	movq	$0x000000000, (%rsi)
	.loc 1 7 9 is_stmt 1 view .LVU20
.LVL6:
.LBB4:
	.loc 1 7 27 view .LVU21
	testl	%r13d, %r13d
	jle	.L7
	movslq	%r9d, %rdi
	leaq	(%r15,%rdi,4), %rax
	addq	%r11, %rdi
	leaq	(%r15,%rdi,4), %rdi
.LVL7:
	.p2align 4
	.p2align 3
.L6:
	.loc 1 8 13 discriminator 3 view .LVU22
	.loc 1 8 23 is_stmt 0 discriminator 3 view .LVU23
	vcvtss2sd	(%rax), %xmm3, %xmm0
	.loc 1 8 20 discriminator 3 view .LVU24
	vaddsd	(%rdx), %xmm0, %xmm1
	.loc 1 7 27 discriminator 3 view .LVU25
	addq	$4, %rax
.LVL8:
	.loc 1 8 20 discriminator 3 view .LVU26
	vmovsd	%xmm1, (%rdx)
	.loc 1 9 13 is_stmt 1 discriminator 3 view .LVU27
	.loc 1 9 25 is_stmt 0 discriminator 3 view .LVU28
	vfmadd213sd	(%rsi), %xmm0, %xmm0
	vmovsd	%xmm0, (%rsi)
	.loc 1 7 9 is_stmt 1 discriminator 3 view .LVU29
.LVL9:
	.loc 1 7 27 discriminator 3 view .LVU30
	cmpq	%rax, %rdi
	jne	.L6
.LVL10:
.L7:
	.loc 1 7 27 is_stmt 0 discriminator 3 view .LVU31
.LBE4:
.LBE3:
	.loc 1 4 5 is_stmt 1 view .LVU32
	.loc 1 4 23 view .LVU33
	addq	$8, %rdx
.LVL11:
	.loc 1 4 23 is_stmt 0 view .LVU34
	addq	$8, %rsi
	addl	%r13d, %r9d
	cmpq	%rdx, %r10
	jne	.L4
	xorl	%esi, %esi
	xorl	%eax, %eax
	movslq	%r13d, %rbx
	xorl	%edi, %edi
	xorl	%edx, %edx
.LVL12:
	.loc 1 4 23 view .LVU35
	movq	%rbx, -56(%rbp)
	movq	%rax, -64(%rbp)
	movq	%rsi, -72(%rbp)
	movq	%rcx, -80(%rbp)
	vcvtsi2sdl	%r13d, %xmm3, %xmm1
.LVL13:
	.p2align 4
	.p2align 3
.L15:
	.loc 1 4 23 view .LVU36
.LBE2:
.LBB5:
.LBB6:
	.loc 1 13 27 is_stmt 1 view .LVU37
.LBB7:
	.loc 1 18 53 is_stmt 0 view .LVU38
	movq	-64(%rbp), %rbx
	movslq	%edx, %r9
	.loc 1 19 42 view .LVU39
	movl	%edi, %r12d
	vmovsd	%xmm1, %xmm1, %xmm6
	movq	-80(%rbp), %rax
	movq	-96(%rbp), %rcx
	.loc 1 18 53 view .LVU40
	vmovsd	(%r14,%rbx,8), %xmm5
	leaq	(%rcx,%r9,4), %r10
	movq	-72(%rbp), %rcx
	leaq	(%rcx,%rax), %r9
	.loc 1 18 55 view .LVU41
	vmulsd	%xmm5, %xmm5, %xmm4
	.loc 1 19 42 view .LVU42
	vfmsub231sd	(%r14,%rax), %xmm1, %xmm4
.LVL14:
	.p2align 4
	.p2align 3
.L16:
.LBB8:
	.loc 1 15 31 is_stmt 1 view .LVU43
.LBE8:
	.loc 1 14 20 is_stmt 0 view .LVU44
	vxorpd	%xmm2, %xmm2, %xmm2
.LBB9:
	.loc 1 15 31 view .LVU45
	testl	%r13d, %r13d
	jle	.L14
	movq	-56(%rbp), %rsi
	movslq	%r12d, %r11
.LBE9:
	.loc 1 14 20 view .LVU46
	vxorpd	%xmm2, %xmm2, %xmm2
	leaq	(%r15,%r11,4), %rax
	leaq	(%rsi,%r11), %rcx
	leaq	(%r15,%rcx,4), %rsi
	movslq	%edi, %rcx
.LBB10:
	.loc 1 16 71 view .LVU47
	subq	%r11, %rcx
.LVL15:
	.p2align 4
	.p2align 3
.L8:
	.loc 1 16 17 is_stmt 1 discriminator 3 view .LVU48
	.loc 1 16 71 is_stmt 0 discriminator 3 view .LVU49
	vcvtss2sd	(%rax,%rcx,4), %xmm3, %xmm0
	.loc 1 15 31 discriminator 3 view .LVU50
	addq	$4, %rax
.LVL16:
	.loc 1 16 26 discriminator 3 view .LVU51
	vcvtss2sd	-4(%rax), %xmm3, %xmm1
	.loc 1 16 54 discriminator 3 view .LVU52
	vmulsd	%xmm1, %xmm0, %xmm0
	.loc 1 16 23 discriminator 3 view .LVU53
	vaddsd	%xmm0, %xmm2, %xmm2
.LVL17:
	.loc 1 15 13 is_stmt 1 discriminator 3 view .LVU54
	.loc 1 15 31 discriminator 3 view .LVU55
	cmpq	%rax, %rsi
	jne	.L8
.LVL18:
.L14:
	.loc 1 15 31 is_stmt 0 discriminator 3 view .LVU56
.LBE10:
	.loc 1 18 13 is_stmt 1 discriminator 2 view .LVU57
	.loc 1 18 53 is_stmt 0 discriminator 2 view .LVU58
	vmovsd	(%r14,%rbx,8), %xmm0
	.loc 1 19 35 discriminator 2 view .LVU59
	leaq	(%r14,%r9), %rax
	.loc 1 18 55 discriminator 2 view .LVU60
	vmulsd	%xmm5, %xmm0, %xmm1
	.loc 1 19 51 discriminator 2 view .LVU61
	vmulsd	%xmm0, %xmm0, %xmm0
	.loc 1 19 42 discriminator 2 view .LVU62
	vfmsub231sd	(%rax,%rbx,8), %xmm6, %xmm0
	.loc 1 18 46 discriminator 2 view .LVU63
	vfmsub132sd	%xmm6, %xmm1, %xmm2
	vxorpd	%xmm1, %xmm1, %xmm1
	.loc 1 19 23 discriminator 2 view .LVU64
	vmulsd	%xmm4, %xmm0, %xmm0
	vucomisd	%xmm0, %xmm1
	ja	.L23
	.loc 1 19 23 view .LVU65
	vsqrtsd	%xmm0, %xmm0, %xmm0
	.loc 1 19 17 view .LVU66
	vdivsd	%xmm0, %xmm2, %xmm2
.LBE7:
	.loc 1 13 27 view .LVU67
	addl	%r13d, %r12d
.LBB11:
	.loc 1 19 17 view .LVU68
	vcvtsd2ss	%xmm2, %xmm2, %xmm2
	vmovss	%xmm2, (%r10,%rbx,4)
.LBE11:
	.loc 1 13 9 is_stmt 1 view .LVU69
.LVL19:
	.loc 1 13 27 view .LVU70
	incq	%rbx
.LVL20:
	.loc 1 13 27 is_stmt 0 view .LVU71
	cmpl	%ebx, %r8d
	jg	.L16
.LVL21:
.L24:
	.loc 1 13 27 view .LVU72
.LBE6:
	.loc 1 12 23 view .LVU73
	incq	-64(%rbp)
.LVL22:
	.loc 1 12 23 view .LVU74
	addq	$8, -80(%rbp)
	vmovsd	%xmm6, %xmm6, %xmm1
	.loc 1 12 5 is_stmt 1 view .LVU75
.LVL23:
	.loc 1 12 23 view .LVU76
	addl	%r8d, %edx
	subq	$8, -72(%rbp)
	movq	-64(%rbp), %rax
	addl	%r13d, %edi
	cmpq	%rax, -88(%rbp)
	jne	.L15
.LVL24:
.L25:
	.loc 1 12 23 is_stmt 0 view .LVU77
.LBE5:
	.loc 1 22 1 view .LVU78
	leaq	-40(%rbp), %rsp
.LVL25:
	.loc 1 22 1 view .LVU79
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
.LVL26:
	.loc 1 22 1 view .LVU80
	ret
.LVL27:
.L23:
	.cfi_restore_state
	.loc 1 22 1 view .LVU81
	vmovsd	%xmm6, -160(%rbp)
	movq	%r9, -152(%rbp)
	movl	%r8d, -140(%rbp)
.LBB16:
.LBB15:
	.loc 1 13 27 discriminator 2 view .LVU82
	addl	%r13d, %r12d
	movl	%edx, -136(%rbp)
	movl	%edi, -132(%rbp)
	movq	%r10, -128(%rbp)
	vmovsd	%xmm4, -120(%rbp)
	vmovsd	%xmm5, -112(%rbp)
	vmovsd	%xmm2, -104(%rbp)
.LBB12:
	.loc 1 19 23 discriminator 2 view .LVU83
	call	sqrt
.LVL28:
	.loc 1 19 17 discriminator 2 view .LVU84
	vmovsd	-104(%rbp), %xmm2
.LBE12:
	.loc 1 13 27 discriminator 2 view .LVU85
	vxorps	%xmm3, %xmm3, %xmm3
.LBB13:
	.loc 1 19 17 discriminator 2 view .LVU86
	movq	-128(%rbp), %r10
.LBE13:
	.loc 1 13 27 discriminator 2 view .LVU87
	movl	-140(%rbp), %r8d
	vmovsd	-112(%rbp), %xmm5
	vmovsd	-120(%rbp), %xmm4
	vmovsd	-160(%rbp), %xmm6
	movl	-132(%rbp), %edi
	movl	-136(%rbp), %edx
	movq	-152(%rbp), %r9
.LBB14:
	.loc 1 19 17 discriminator 2 view .LVU88
	vdivsd	%xmm0, %xmm2, %xmm2
	vcvtsd2ss	%xmm2, %xmm2, %xmm2
	vmovss	%xmm2, (%r10,%rbx,4)
.LBE14:
	.loc 1 13 9 is_stmt 1 discriminator 2 view .LVU89
.LVL29:
	.loc 1 13 27 discriminator 2 view .LVU90
	incq	%rbx
.LVL30:
	.loc 1 13 27 is_stmt 0 discriminator 2 view .LVU91
	cmpl	%ebx, %r8d
	jg	.L16
	jmp	.L24
.LBE15:
.LBE16:
	.cfi_endproc
.LFE967:
	.size	_Z9correlateiiPKfPf, .-_Z9correlateiiPKfPf
.Letext0:
	.file 2 "/usr/include/c++/12/cmath"
	.file 3 "/usr/include/c++/12/type_traits"
	.file 4 "/usr/include/c++/12/debug/debug.h"
	.file 5 "/usr/include/c++/12/bits/stl_iterator.h"
	.file 6 "/usr/include/c++/12/bits/predefined_ops.h"
	.file 7 "/usr/include/math.h"
	.file 8 "/usr/include/c++/12/x86_64-redhat-linux/bits/c++config.h"
	.file 9 "/usr/include/bits/mathcalls.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x2bd
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0xc
	.long	.LASF35
	.byte	0x21
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0xd
	.string	"std"
	.byte	0x8
	.value	0x9e8
	.byte	0xb
	.long	0x6a
	.uleb128 0x4
	.value	0x429
	.long	0x107
	.uleb128 0x4
	.value	0x42a
	.long	0xfc
	.uleb128 0x3
	.long	.LASF2
	.byte	0x3
	.value	0xa9f
	.uleb128 0x3
	.long	.LASF3
	.byte	0x3
	.value	0xaf5
	.uleb128 0x5
	.long	.LASF4
	.byte	0x4
	.byte	0x32
	.byte	0xd
	.uleb128 0x3
	.long	.LASF5
	.byte	0x5
	.value	0x589
	.byte	0
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.long	.LASF6
	.uleb128 0x1
	.byte	0x1
	.byte	0x2
	.long	.LASF7
	.uleb128 0xe
	.long	.LASF8
	.byte	0x8
	.value	0xa0d
	.byte	0xb
	.long	0x8e
	.uleb128 0x5
	.long	.LASF9
	.byte	0x6
	.byte	0x25
	.byte	0xb
	.byte	0
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.long	.LASF10
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.long	.LASF11
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.long	.LASF12
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.long	.LASF13
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.long	.LASF14
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.long	.LASF15
	.uleb128 0xf
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.long	.LASF16
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.long	.LASF17
	.uleb128 0x1
	.byte	0x10
	.byte	0x4
	.long	.LASF18
	.uleb128 0x1
	.byte	0x8
	.byte	0x4
	.long	.LASF19
	.uleb128 0x1
	.byte	0x4
	.byte	0x4
	.long	.LASF20
	.uleb128 0x10
	.long	0xdb
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.long	.LASF21
	.uleb128 0x1
	.byte	0x20
	.byte	0x3
	.long	.LASF22
	.uleb128 0x1
	.byte	0x10
	.byte	0x4
	.long	.LASF23
	.uleb128 0x6
	.long	.LASF24
	.byte	0xa3
	.byte	0xf
	.long	0xdb
	.uleb128 0x6
	.long	.LASF25
	.byte	0xa4
	.byte	0x10
	.long	0xd4
	.uleb128 0x1
	.byte	0x4
	.byte	0x5
	.long	.LASF26
	.uleb128 0x1
	.byte	0x2
	.byte	0x10
	.long	.LASF27
	.uleb128 0x1
	.byte	0x4
	.byte	0x10
	.long	.LASF28
	.uleb128 0x11
	.long	.LASF29
	.byte	0x4
	.byte	0x38
	.byte	0xb
	.long	0x13c
	.uleb128 0x12
	.byte	0x4
	.byte	0x3a
	.byte	0x18
	.long	0x59
	.byte	0
	.uleb128 0x1
	.byte	0x10
	.byte	0x5
	.long	.LASF30
	.uleb128 0x1
	.byte	0x10
	.byte	0x7
	.long	.LASF31
	.uleb128 0x13
	.long	.LASF36
	.byte	0x9
	.byte	0x8f
	.byte	0x1
	.long	0xd4
	.long	0x160
	.uleb128 0x14
	.long	0xd4
	.byte	0
	.uleb128 0x15
	.long	.LASF37
	.byte	0x1
	.byte	0x2
	.byte	0x6
	.long	.LASF38
	.quad	.LFB967
	.quad	.LFE967-.LFB967
	.uleb128 0x1
	.byte	0x9c
	.long	0x2a7
	.uleb128 0x7
	.string	"ny"
	.byte	0x14
	.long	0xb8
	.long	.LLST2
	.long	.LVUS2
	.uleb128 0x7
	.string	"nx"
	.byte	0x1c
	.long	0xb8
	.long	.LLST3
	.long	.LVUS3
	.uleb128 0x8
	.long	.LASF32
	.byte	0x2d
	.long	0x2a7
	.long	.LLST4
	.long	.LVUS4
	.uleb128 0x8
	.long	.LASF33
	.byte	0x3a
	.long	0x2ac
	.long	.LLST5
	.long	.LVUS5
	.uleb128 0x2
	.string	"row"
	.byte	0x3
	.byte	0xc
	.long	0x2b1
	.long	.LLST6
	.long	.LVUS6
	.uleb128 0x16
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.long	0x225
	.uleb128 0x2
	.string	"r"
	.byte	0x4
	.byte	0xe
	.long	0xb8
	.long	.LLST7
	.long	.LVUS7
	.uleb128 0x17
	.quad	.LBB4
	.quad	.LBE4-.LBB4
	.uleb128 0x2
	.string	"c"
	.byte	0x7
	.byte	0x12
	.long	0xb8
	.long	.LLST8
	.long	.LVUS8
	.byte	0
	.byte	0
	.uleb128 0x9
	.long	.LLRL9
	.long	0x299
	.uleb128 0x2
	.string	"j"
	.byte	0xc
	.byte	0xe
	.long	0xb8
	.long	.LLST10
	.long	.LVUS10
	.uleb128 0xa
	.long	.LLRL11
	.uleb128 0x2
	.string	"i"
	.byte	0xd
	.byte	0x12
	.long	0xb8
	.long	.LLST12
	.long	.LVUS12
	.uleb128 0xa
	.long	.LLRL13
	.uleb128 0x18
	.long	.LASF34
	.byte	0x1
	.byte	0xe
	.byte	0x14
	.long	0xd4
	.long	.LLST14
	.long	.LVUS14
	.uleb128 0x9
	.long	.LLRL15
	.long	0x289
	.uleb128 0x2
	.string	"n"
	.byte	0xf
	.byte	0x16
	.long	0xb8
	.long	.LLST16
	.long	.LVUS16
	.byte	0
	.uleb128 0x19
	.quad	.LVL28
	.long	0x14a
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x1a
	.long	0x9c
	.long	.LLST1
	.long	.LVUS1
	.byte	0
	.uleb128 0xb
	.long	0xe2
	.uleb128 0xb
	.long	0xdb
	.uleb128 0x1b
	.long	0xd4
	.uleb128 0x1c
	.long	0x9c
	.long	0x299
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x39
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x8
	.byte	0
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 11
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x39
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 7
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x39
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x3a
	.byte	0
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x18
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x6e
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x34
	.uleb128 0x19
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS2:
	.uleb128 0
	.uleb128 .LVU16
	.uleb128 .LVU16
	.uleb128 .LVU36
	.uleb128 .LVU36
	.uleb128 .LVU77
	.uleb128 .LVU77
	.uleb128 0
.LLST2:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x1
	.byte	0x55
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL24-.Ltext0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LFE967-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x9f
	.byte	0
.LVUS3:
	.uleb128 0
	.uleb128 .LVU15
	.uleb128 .LVU15
	.uleb128 .LVU77
	.uleb128 .LVU77
	.uleb128 .LVU81
	.uleb128 .LVU81
	.uleb128 0
.LLST3:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x54
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL24-.Ltext0
	.uleb128 0x1
	.byte	0x5d
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL27-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x54
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LFE967-.Ltext0
	.uleb128 0x1
	.byte	0x5d
	.byte	0
.LVUS4:
	.uleb128 0
	.uleb128 .LVU14
	.uleb128 .LVU14
	.uleb128 .LVU77
	.uleb128 .LVU77
	.uleb128 .LVU81
	.uleb128 .LVU81
	.uleb128 0
.LLST4:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL3-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL24-.Ltext0
	.uleb128 0x1
	.byte	0x5f
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LVL27-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LFE967-.Ltext0
	.uleb128 0x1
	.byte	0x5f
	.byte	0
.LVUS5:
	.uleb128 0
	.uleb128 .LVU13
	.uleb128 .LVU13
	.uleb128 .LVU80
	.uleb128 .LVU80
	.uleb128 .LVU81
	.uleb128 .LVU81
	.uleb128 0
.LLST5:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL2-.Ltext0
	.uleb128 0x1
	.byte	0x52
	.byte	0x4
	.uleb128 .LVL2-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.byte	0x4
	.uleb128 .LVL26-.Ltext0
	.uleb128 .LVL27-.Ltext0
	.uleb128 0x3
	.byte	0x77
	.sleb128 -104
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LFE967-.Ltext0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.byte	0
.LVUS6:
	.uleb128 .LVU11
	.uleb128 .LVU79
	.uleb128 .LVU81
	.uleb128 0
.LLST6:
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL25-.Ltext0
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LFE967-.Ltext0
	.uleb128 0x2
	.byte	0x77
	.sleb128 0
	.byte	0
.LVUS7:
	.uleb128 .LVU12
	.uleb128 .LVU16
	.uleb128 .LVU16
	.uleb128 .LVU33
	.uleb128 .LVU33
	.uleb128 .LVU34
	.uleb128 .LVU34
	.uleb128 .LVU35
.LLST7:
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL10-.Ltext0
	.uleb128 0x8
	.byte	0x71
	.sleb128 0
	.byte	0x77
	.sleb128 0
	.byte	0x1c
	.byte	0x33
	.byte	0x25
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0xa
	.byte	0x71
	.sleb128 0
	.byte	0x77
	.sleb128 0
	.byte	0x1c
	.byte	0x33
	.byte	0x25
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0xc
	.byte	0x71
	.sleb128 0
	.byte	0x77
	.sleb128 0
	.byte	0x1c
	.byte	0x38
	.byte	0x1c
	.byte	0x33
	.byte	0x25
	.byte	0x23
	.uleb128 0x1
	.byte	0x9f
	.byte	0
.LVUS8:
	.uleb128 .LVU21
	.uleb128 .LVU22
	.uleb128 .LVU22
	.uleb128 .LVU26
	.uleb128 .LVU26
	.uleb128 .LVU30
.LLST8:
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL7-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LVL8-.Ltext0
	.uleb128 0x13
	.byte	0x70
	.sleb128 0
	.byte	0x7f
	.sleb128 0
	.byte	0x1c
	.byte	0x79
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x32
	.byte	0x24
	.byte	0x1c
	.byte	0x32
	.byte	0x25
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.Ltext0
	.uleb128 .LVL9-.Ltext0
	.uleb128 0x15
	.byte	0x70
	.sleb128 0
	.byte	0x7f
	.sleb128 0
	.byte	0x1c
	.byte	0x79
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x32
	.byte	0x24
	.byte	0x1c
	.byte	0x34
	.byte	0x1c
	.byte	0x32
	.byte	0x25
	.byte	0x9f
	.byte	0
.LVUS10:
	.uleb128 .LVU36
	.uleb128 .LVU74
	.uleb128 .LVU81
	.uleb128 0
.LLST10:
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL22-.Ltext0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LFE967-.Ltext0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.byte	0
.LVUS12:
	.uleb128 .LVU36
	.uleb128 .LVU43
	.uleb128 .LVU43
	.uleb128 .LVU70
	.uleb128 .LVU70
	.uleb128 .LVU71
	.uleb128 .LVU81
	.uleb128 .LVU90
	.uleb128 .LVU90
	.uleb128 .LVU91
.LLST12:
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL14-.Ltext0
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LVL20-.Ltext0
	.uleb128 0x3
	.byte	0x73
	.sleb128 1
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LVL29-.Ltext0
	.uleb128 0x1
	.byte	0x53
	.byte	0x4
	.uleb128 .LVL29-.Ltext0
	.uleb128 .LVL30-.Ltext0
	.uleb128 0x3
	.byte	0x73
	.sleb128 1
	.byte	0x9f
	.byte	0
.LVUS14:
	.uleb128 .LVU43
	.uleb128 .LVU48
	.uleb128 .LVU48
	.uleb128 .LVU56
.LLST14:
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LVL15-.Ltext0
	.uleb128 0xa
	.byte	0x9e
	.uleb128 0x8
	.long	0
	.long	0
	.byte	0x4
	.uleb128 .LVL15-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x1
	.byte	0x63
	.byte	0
.LVUS16:
	.uleb128 .LVU43
	.uleb128 .LVU48
	.uleb128 .LVU48
	.uleb128 .LVU51
	.uleb128 .LVU51
	.uleb128 .LVU55
.LLST16:
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LVL15-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL15-.Ltext0
	.uleb128 .LVL16-.Ltext0
	.uleb128 0x13
	.byte	0x70
	.sleb128 0
	.byte	0x7f
	.sleb128 0
	.byte	0x1c
	.byte	0x7c
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x32
	.byte	0x24
	.byte	0x1c
	.byte	0x32
	.byte	0x25
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL16-.Ltext0
	.uleb128 .LVL17-.Ltext0
	.uleb128 0x15
	.byte	0x70
	.sleb128 0
	.byte	0x7f
	.sleb128 0
	.byte	0x1c
	.byte	0x7c
	.sleb128 0
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x32
	.byte	0x24
	.byte	0x1c
	.byte	0x34
	.byte	0x1c
	.byte	0x32
	.byte	0x25
	.byte	0x9f
	.byte	0
.LVUS1:
	.uleb128 .LVU2
	.uleb128 .LVU16
	.uleb128 .LVU16
	.uleb128 .LVU36
	.uleb128 .LVU36
	.uleb128 .LVU77
	.uleb128 .LVU77
	.uleb128 0
.LLST1:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0xd
	.byte	0x75
	.sleb128 0
	.byte	0x31
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x31
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0xd
	.byte	0x78
	.sleb128 0
	.byte	0x31
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x31
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL24-.Ltext0
	.uleb128 0x10
	.byte	0x91
	.sleb128 -104
	.byte	0x94
	.byte	0x4
	.byte	0x31
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x31
	.byte	0x1c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL24-.Ltext0
	.uleb128 .LFE967-.Ltext0
	.uleb128 0xe
	.byte	0xa3
	.uleb128 0x1
	.byte	0x55
	.byte	0x31
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x24
	.byte	0x8
	.byte	0x20
	.byte	0x26
	.byte	0x31
	.byte	0x1c
	.byte	0x9f
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.long	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.LLRL9:
	.byte	0x4
	.uleb128 .LBB5-.Ltext0
	.uleb128 .LBE5-.Ltext0
	.byte	0x4
	.uleb128 .LBB16-.Ltext0
	.uleb128 .LBE16-.Ltext0
	.byte	0
.LLRL11:
	.byte	0x4
	.uleb128 .LBB6-.Ltext0
	.uleb128 .LBE6-.Ltext0
	.byte	0x4
	.uleb128 .LBB15-.Ltext0
	.uleb128 .LBE15-.Ltext0
	.byte	0
.LLRL13:
	.byte	0x4
	.uleb128 .LBB7-.Ltext0
	.uleb128 .LBE7-.Ltext0
	.byte	0x4
	.uleb128 .LBB11-.Ltext0
	.uleb128 .LBE11-.Ltext0
	.byte	0x4
	.uleb128 .LBB12-.Ltext0
	.uleb128 .LBE12-.Ltext0
	.byte	0x4
	.uleb128 .LBB13-.Ltext0
	.uleb128 .LBE13-.Ltext0
	.byte	0x4
	.uleb128 .LBB14-.Ltext0
	.uleb128 .LBE14-.Ltext0
	.byte	0
.LLRL15:
	.byte	0x4
	.uleb128 .LBB8-.Ltext0
	.uleb128 .LBE8-.Ltext0
	.byte	0x4
	.uleb128 .LBB9-.Ltext0
	.uleb128 .LBE9-.Ltext0
	.byte	0x4
	.uleb128 .LBB10-.Ltext0
	.uleb128 .LBE10-.Ltext0
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF31:
	.string	"__int128 unsigned"
.LASF35:
	.ascii	"GNU C++17 12.2.1 20221121 (Red Hat 12.2.1-4) -march=znver2 -"
	.ascii	"mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 "
	.ascii	"-mavx -mavx2 -msse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -"
	.ascii	"mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-"
	.ascii	"avx512dq -mno-avx512cd -mno-avx512er -mno-avx512pf -mno-avx5"
	.ascii	"12vbmi -mno-avx512ifma -mno-avx5124vnniw -mno-avx5124fmaps -"
	.ascii	"mno-avx512vpopcntdq -mno-avx512vbmi2 -mno-gfni -mno-vpclmulq"
	.ascii	"dq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-av"
	.ascii	"x512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclfl"
	.ascii	"ushopt -mclwb -mclzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase "
	.ascii	"-mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mno-movdir6"
	.ascii	"4b -mno-movdiri -mmwaitx -mno-pconfig -mno-pku -mno-prefetch"
	.ascii	"wt1 -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm "
	.ascii	"-mno-serialize -mno-sgx -msha -mno-shstk -mno-tbm -mno-tsxld"
	.ascii	"trk -mno-vaes -mno-waitpkg -mwbnoinvd -mxsave"
	.string	" -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mno-avxvnni -mno-avx512fp16 --param=l1-cache-size=32 --param=l1-cache-line-size=64 --param=l2-cache-size=512 -mtune=znver2 -g -O3 -std=c++17"
.LASF3:
	.string	"__swappable_with_details"
.LASF8:
	.string	"__gnu_cxx"
.LASF24:
	.string	"float_t"
.LASF25:
	.string	"double_t"
.LASF38:
	.string	"_Z9correlateiiPKfPf"
.LASF20:
	.string	"float"
.LASF13:
	.string	"long long unsigned int"
.LASF10:
	.string	"unsigned char"
.LASF37:
	.string	"correlate"
.LASF12:
	.string	"long unsigned int"
.LASF11:
	.string	"short unsigned int"
.LASF30:
	.string	"__int128"
.LASF4:
	.string	"__debug"
.LASF19:
	.string	"double"
.LASF2:
	.string	"__swappable_details"
.LASF23:
	.string	"__float128"
.LASF34:
	.string	"sumIJ"
.LASF26:
	.string	"wchar_t"
.LASF29:
	.string	"__gnu_debug"
.LASF6:
	.string	"unsigned int"
.LASF21:
	.string	"char"
.LASF33:
	.string	"result"
.LASF27:
	.string	"char16_t"
.LASF28:
	.string	"char32_t"
.LASF9:
	.string	"__ops"
.LASF17:
	.string	"long long int"
.LASF5:
	.string	"__detail"
.LASF15:
	.string	"short int"
.LASF22:
	.string	"__unknown__"
.LASF16:
	.string	"long int"
.LASF7:
	.string	"bool"
.LASF18:
	.string	"long double"
.LASF14:
	.string	"signed char"
.LASF32:
	.string	"data"
.LASF36:
	.string	"sqrt"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"cp_naive.cc"
.LASF1:
	.string	"/home/rv/Documents/university/PPC/cp1"
	.ident	"GCC: (GNU) 12.2.1 20221121 (Red Hat 12.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
