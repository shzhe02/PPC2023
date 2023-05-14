    .file	"cp.cc"
	.text
	.p2align 4
	.type	_Z9correlateiiPKfPf._omp_fn.0, @function
_Z9correlateiiPKfPf._omp_fn.0:
.LFB7671:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 112
	movl	24(%rdi), %r14d	# *.omp_data_i_9(D).vectorsPerCol, vectorsPerCol
	movl	16(%rdi), %eax	# *.omp_data_i_9(D).ny, ny
	movl	%r14d, 28(%rsp)	# vectorsPerCol, %sfp
	movl	%eax, 8(%rsp)	# ny, %sfp
	movq	8(%rdi), %r12	# *.omp_data_i_9(D).input, input
	movq	(%rdi), %rbp	# *.omp_data_i_9(D).data, data
	movl	20(%rdi), %ebx	# *.omp_data_i_9(D).nx, nx
	call	omp_get_num_threads@PLT	#
	movl	%eax, 32(%rsp)	# _15, %sfp
	movl	%eax, %r15d	# tmp258, _15
	call	omp_get_thread_num@PLT	#
	cmpl	%eax, %r14d	# _16, vectorsPerCol
	jle	.L27	#,
	movl	%ebx, %r11d	# nx, ivtmp.92
	imull	%eax, %r11d	# ivtmp.91, ivtmp.92
	movl	%eax, %r8d	# _16, ivtmp.91
	leal	-1(%rbx), %eax	#, _90
	imull	%ebx, %r15d	# nx, _240
	movl	%eax, 12(%rsp)	# _90, %sfp
	movl	%ebx, %eax	# nx, bnd.41
	shrl	$3, %eax	#,
	salq	$5, %rax	#, bnd.41
	movslq	%ebx, %rdx	# nx, nx
	movq	%rax, 16(%rsp)	# bnd.41, %sfp
	movl	%r15d, 36(%rsp)	# _240, %sfp
	movq	%rdx, 40(%rsp)	# nx, %sfp
	movl	%ebx, %r13d	# nx, _21
	vxorps	%xmm0, %xmm0, %xmm0	# tmp260
	andl	$-8, %r13d	#, _21
	.p2align 4,,10
	.p2align 3
.L5:
	movq	40(%rsp), %rax	# %sfp, nx
	movslq	%r11d, %r14	# ivtmp.92, _160
	movq	%r14, %r9	# _160, tmp209
	addq	%r14, %rax	# _160, tmp211
	movl	%r8d, 24(%rsp)	# ivtmp.91, %sfp
	salq	$6, %r9	#, tmp209
	salq	$6, %rax	#, tmp212
	leal	0(,%r8,8), %r15d	#, _247
	addq	%r12, %r9	# input, ivtmp.80
	addq	%r12, %rax	# input, ivtmp.81
	leal	0(,%r11,8), %edi	#, ivtmp.83
	xorl	%ecx, %ecx	# ivtmp.75
	.p2align 4,,10
	.p2align 3
.L6:
	testl	%ebx, %ebx	# nx
	jle	.L4	#,
	leal	(%r15,%rcx), %edx	#, row
	cmpl	%edx, 8(%rsp)	# row, %sfp
	jg	.L8	#,
	movq	%r9, %rdx	# ivtmp.80, ivtmp.62
	.p2align 4,,10
	.p2align 3
.L9:
	movq	$0x000000000, (%rdx)	#, MEM <double> [(double8_t *)_210]
	addq	$64, %rdx	#, ivtmp.62
	cmpq	%rdx, %rax	# ivtmp.62, ivtmp.81
	jne	.L9	#,
.L4:
	incq	%rcx	# ivtmp.75
	addq	$8, %r9	#, ivtmp.80
	addq	$8, %rax	#, ivtmp.81
	addl	%ebx, %edi	# nx, ivtmp.83
	cmpq	$8, %rcx	#, ivtmp.75
	jne	.L6	#,
	movl	32(%rsp), %eax	# %sfp, _15
	movl	24(%rsp), %r8d	# %sfp, ivtmp.91
	addl	%eax, %r8d	# _15, ivtmp.91
	movl	36(%rsp), %eax	# %sfp, _240
	addl	%eax, %r11d	# _240, ivtmp.92
	cmpl	%r8d, 28(%rsp)	# ivtmp.91, %sfp
	jg	.L5	#,
.L27:
	addq	$56, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
	.p2align 4,,10
	.p2align 3
.L8:
	.cfi_restore_state
	cmpl	$6, 12(%rsp)	#, %sfp
	jbe	.L17	#,
	movq	16(%rsp), %rsi	# %sfp, _3
	movslq	%edi, %rdx	# ivtmp.83, _23
	leaq	0(%rbp,%rdx,4), %rdx	#, ivtmp.67
	leaq	(%rsi,%rdx), %r8	#, _144
	movq	%r9, %rsi	# ivtmp.80, ivtmp.70
	.p2align 4,,10
	.p2align 3
.L12:
	vcvtss2sd	12(%rdx), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 96>, tmp260, tmp261
	vcvtss2sd	24(%rdx), %xmm0, %xmm2	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 192>, tmp260, tmp267
	vcvtss2sd	(%rdx), %xmm0, %xmm8	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 0>, tmp260, tmp268
	vmovsd	%xmm1, %xmm1, %xmm5	# tmp261, _124
	addq	$32, %rdx	#, ivtmp.67
	vcvtss2sd	-24(%rdx), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 64>, tmp260, tmp262
	vmovsd	%xmm1, %xmm1, %xmm6	# tmp262, _121
	vcvtss2sd	-28(%rdx), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 32>, tmp260, tmp263
	vmovsd	%xmm1, %xmm1, %xmm7	# tmp263, _118
	vcvtss2sd	-12(%rdx), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 160>, tmp260, tmp264
	vmovsd	%xmm1, %xmm1, %xmm3	# tmp264, _130
	vcvtss2sd	-16(%rdx), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 128>, tmp260, tmp265
	vmovsd	%xmm1, %xmm1, %xmm4	# tmp265, _127
	addq	$512, %rsi	#, ivtmp.70
	vcvtss2sd	-4(%rdx), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(8) float> [(const float *)_108], 32, 224>, tmp260, tmp266
	vmovsd	%xmm8, -512(%rsi)	# tmp217, MEM <double> [(double8_t *)_68]
	vmovsd	%xmm7, -448(%rsi)	# _118, MEM <double> [(double8_t *)_68 + 64B]
	vmovsd	%xmm6, -384(%rsi)	# _121, MEM <double> [(double8_t *)_68 + 128B]
	vmovsd	%xmm5, -320(%rsi)	# _124, MEM <double> [(double8_t *)_68 + 192B]
	vmovsd	%xmm4, -256(%rsi)	# _127, MEM <double> [(double8_t *)_68 + 256B]
	vmovsd	%xmm3, -192(%rsi)	# _130, MEM <double> [(double8_t *)_68 + 320B]
	vmovsd	%xmm2, -128(%rsi)	# _133, MEM <double> [(double8_t *)_68 + 384B]
	vmovsd	%xmm1, -64(%rsi)	# _136, MEM <double> [(double8_t *)_68 + 448B]
	cmpq	%r8, %rdx	# _144, ivtmp.67
	jne	.L12	#,
	cmpl	%r13d, %ebx	# _21, nx
	je	.L4	#,
	movl	%r13d, %edx	# _21,
	movl	%r13d, %esi	# _21, tmp.51
.L11:
	movl	%ebx, %r10d	# nx, niters.48
	subl	%edx, %r10d	# _97, niters.48
	leal	-1(%r10), %r8d	#, tmp218
	cmpl	$2, %r8d	#, tmp218
	jbe	.L15	#,
	movslq	%edi, %r8	# ivtmp.83, _23
	addq	%rdx, %r8	# _171, tmp220
	addq	%r14, %rdx	# _160, tmp222
	leaq	0(%rbp,%r8,4), %r8	#, vectp.53
	leaq	(%rcx,%rdx,8), %rdx	#, tmp224
	vcvtss2sd	4(%r8), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(4) float> [(const float *)vectp.53_169], 32, 32>, tmp260, tmp269
	leaq	(%r12,%rdx,8), %rdx	#, _186
	vmovsd	%xmm1, %xmm1, %xmm3	# tmp269, _192
	vcvtss2sd	8(%r8), %xmm0, %xmm2	# BIT_FIELD_REF <MEM <const vector(4) float> [(const float *)vectp.53_169], 32, 64>, tmp260, tmp271
	vcvtss2sd	12(%r8), %xmm0, %xmm1	# BIT_FIELD_REF <MEM <const vector(4) float> [(const float *)vectp.53_169], 32, 96>, tmp260, tmp270
	vcvtss2sd	(%r8), %xmm0, %xmm4	# BIT_FIELD_REF <MEM <const vector(4) float> [(const float *)vectp.53_169], 32, 0>, tmp260, tmp272
	vmovsd	%xmm3, 64(%rdx)	# _192, MEM <double> [(double8_t *)_186 + 64B]
	vmovsd	%xmm4, (%rdx)	# tmp226, MEM <double> [(double8_t *)_186]
	vmovsd	%xmm2, 128(%rdx)	# _195, MEM <double> [(double8_t *)_186 + 128B]
	vmovsd	%xmm1, 192(%rdx)	# _198, MEM <double> [(double8_t *)_186 + 192B]
	movl	%r10d, %edx	# niters.48, niters_vector_mult_vf.50
	andl	$-4, %edx	#, niters_vector_mult_vf.50
	addl	%edx, %esi	# niters_vector_mult_vf.50, tmp.51
	andl	$3, %r10d	#, niters.48
	je	.L4	#,
.L15:
	leal	(%r11,%rsi), %edx	#, tmp229
	movslq	%edx, %rdx	# tmp229, tmp230
	salq	$6, %rdx	#, tmp232
	leal	(%rdi,%rsi), %r10d	#, tmp234
	addq	%r12, %rdx	# input, tmp231
	leaq	0(,%rcx,8), %r8	#, _65
	movslq	%r10d, %r10	# tmp234, tmp235
	vcvtss2sd	0(%rbp,%r10,4), %xmm0, %xmm1	# *_28, tmp260, tmp273
	vmovsd	%xmm1, (%rdx,%r8)	# tmp236, MEM <double> [(double8_t *)_204]
	leal	1(%rsi), %edx	#, col
	cmpl	%edx, %ebx	# col, nx
	jle	.L4	#,
	leal	(%r11,%rdx), %r10d	#, tmp237
	movslq	%r10d, %r10	# tmp237, tmp238
	salq	$6, %r10	#, tmp240
	addl	%edi, %edx	# ivtmp.83, tmp242
	addq	%r12, %r10	# input, tmp239
	movslq	%edx, %rdx	# tmp242, tmp243
	addl	$2, %esi	#, col
	vcvtss2sd	0(%rbp,%rdx,4), %xmm0, %xmm1	# *_81, tmp260, tmp274
	vmovsd	%xmm1, (%r10,%r8)	# tmp244, MEM <double> [(double8_t *)_54]
	cmpl	%esi, %ebx	# col, nx
	jle	.L4	#,
	leal	(%r11,%rsi), %edx	#, tmp245
	movslq	%edx, %rdx	# tmp245, tmp246
	salq	$6, %rdx	#, tmp248
	addl	%edi, %esi	# ivtmp.83, tmp250
	addq	%r12, %rdx	# input, tmp247
	movslq	%esi, %rsi	# tmp250, tmp251
	vcvtss2sd	0(%rbp,%rsi,4), %xmm0, %xmm1	# *_149, tmp260, tmp275
	vmovsd	%xmm1, (%rdx,%r8)	# tmp252, MEM <double> [(double8_t *)_213]
	jmp	.L4	#
.L17:
	xorl	%edx, %edx	#
	xorl	%esi, %esi	# tmp.51
	jmp	.L11	#
	.cfi_endproc
.LFE7671:
	.size	_Z9correlateiiPKfPf._omp_fn.0, .-_Z9correlateiiPKfPf._omp_fn.0
	.p2align 4
	.type	_Z9correlateiiPKfPf._omp_fn.1, @function
_Z9correlateiiPKfPf._omp_fn.1:
.LFB7672:
	.cfi_startproc
	endbr64	
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-64, %rsp	#,
	pushq	-8(%r10)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	pushq	%rbx	#
	subq	$192, %rsp	#,
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
	movl	12(%rdi), %ecx	# *.omp_data_i_14(D).vectorsPerCol, vectorsPerCol
	movq	(%rdi), %rbx	# *.omp_data_i_14(D).input, input
	movl	%ecx, -112(%rbp)	# vectorsPerCol, %sfp
	movl	8(%rdi), %r13d	# *.omp_data_i_14(D).nx, nx
	call	omp_get_num_threads@PLT	#
	movl	%eax, %r15d	# tmp240, _18
	call	omp_get_thread_num@PLT	#
	movl	-112(%rbp), %ecx	# %sfp, vectorsPerCol
	cmpl	%eax, %ecx	# _19, vectorsPerCol
	jle	.L69	#,
	vxorps	%xmm6, %xmm6, %xmm6	# tmp250
	vcvtsi2sdl	%r13d, %xmm6, %xmm6	# nx, tmp250, tmp251
	movl	%r13d, %esi	# nx, _155
	movl	%r13d, %r12d	# nx, ivtmp.132
	imull	%r15d, %esi	# _18, _155
	imull	%eax, %r12d	# ivtmp.131, ivtmp.132
	movl	%eax, %r14d	# tmp241, _19
	vbroadcastsd	%xmm6, %ymm6	# _213, _246
	testl	%r13d, %r13d	# nx
	jle	.L65	#,
	movslq	%r13d, %rdx	# nx, nx
	.p2align 4,,10
	.p2align 3
.L32:
	movslq	%r12d, %rdi	# ivtmp.132, _278
	movq	%rdi, %rax	# _278, tmp230
	addq	%rdi, %rdx	# _278, tmp232
	salq	$6, %rax	#, tmp230
	salq	$6, %rdx	#, tmp233
	addq	%rbx, %rax	# input, ivtmp.124
	addq	%rbx, %rdx	# input, _164
	vxorpd	%xmm0, %xmm0, %xmm0	# means.2_68
	.p2align 4,,10
	.p2align 3
.L59:
	vaddpd	(%rax), %zmm0, %zmm0	# MEM[(double8_t *)_170], means.2_68, means.2_68
	addq	$64, %rax	#, ivtmp.124
	cmpq	%rax, %rdx	# ivtmp.124, _164
	jne	.L59	#,
	vmovapd	%ymm0, %ymm2	# means.2_68, vect_prephitmp_250.109
	vshuff64x2	$238, %zmm0, %zmm0, %zmm0	#, means.2_68, tmp234
.L33:
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
.L51:
	vdivpd	%ymm6, %ymm2, %ymm2	# _246, vect_prephitmp_250.109, vect__75.110
	vdivpd	%ymm6, %ymm0, %ymm0	# _246, vect_prephitmp_250.109, vect__75.110
	vinsertf64x4	$0x1, %ymm0, %zmm2, %zmm2	# vect__75.110, vect__75.110, means
	testl	%r13d, %r13d	# nx
	jle	.L72	#,
	movslq	%r12d, %rdi	# ivtmp.132, _206
	movslq	%r13d, %rdx	# nx, nx
	movq	%rdi, %rax	# _206, tmp225
	addq	%rdi, %rdx	# _206, tmp227
	salq	$6, %rax	#, tmp225
	salq	$6, %rdx	#, tmp228
	addq	%rbx, %rax	# input, ivtmp.119
	addq	%rbx, %rdx	# input, _173
	vxorpd	%xmm1, %xmm1, %xmm1	# rsSums_lsm.106
	.p2align 4,,10
	.p2align 3
.L57:
	vmovapd	(%rax), %zmm7	# MEM[(double8_t *)_196], tmp310
	addq	$64, %rax	#, ivtmp.119
	vsubpd	%zmm2, %zmm7, %zmm0	# means, tmp310, diff
	vmovapd	%zmm0, -64(%rax)	# diff, MEM[(double8_t *)_196]
	vfmadd231pd	%zmm0, %zmm0, %zmm1	# diff, diff, rsSums_lsm.106
	cmpq	%rax, %rdx	# ivtmp.119, _173
	jne	.L57	#,
.L58:
	vucomisd	%xmm1, %xmm4	# _270, tmp173
	vmovapd	%ymm1, %ymm2	# rsSums_lsm.106, tmp236
	vmovapd	%xmm1, %xmm0	# tmp236, tmp172
	ja	.L73	#,
	vsqrtsd	%xmm1, %xmm1, %xmm8	# _270, _266
.L36:
	vunpckhpd	%xmm2, %xmm2, %xmm0	# tmp175, _242
	vucomisd	%xmm0, %xmm4	# _242, tmp173
	ja	.L74	#,
	vsqrtsd	%xmm0, %xmm0, %xmm7	# _242, _238
.L38:
	vextractf64x2	$1, %ymm2, %xmm11	#, tmp236, _230
	vucomisd	%xmm11, %xmm4	# _230, tmp173
	ja	.L75	#,
	vsqrtsd	%xmm11, %xmm11, %xmm11	# _230, _226
.L40:
	valignq	$3, %ymm2, %ymm2, %ymm2	#, tmp236, _218
	vucomisd	%xmm2, %xmm4	# _218, tmp173
	ja	.L76	#,
	vsqrtsd	%xmm2, %xmm2, %xmm2	# _218, _214
.L42:
	vextractf64x2	$2, %zmm1, %xmm10	#, rsSums_lsm.106, _205
	vextractf64x4	$0x1, %zmm1, %ymm3	# rsSums_lsm.106, tmp237
	vucomisd	%xmm10, %xmm4	# _205, tmp173
	ja	.L77	#,
	vsqrtsd	%xmm10, %xmm10, %xmm10	# _205, _201
.L44:
	vunpckhpd	%xmm3, %xmm3, %xmm0	# tmp187, _193
	vucomisd	%xmm0, %xmm4	# _193, tmp173
	ja	.L78	#,
	vsqrtsd	%xmm0, %xmm0, %xmm5	# _193, _189
.L46:
	vextractf64x2	$1, %ymm3, %xmm9	#, tmp237, _181
	vucomisd	%xmm9, %xmm4	# _181, tmp173
	ja	.L79	#,
	vsqrtsd	%xmm9, %xmm9, %xmm9	# _181, _177
.L48:
	valignq	$3, %ymm3, %ymm3, %ymm3	#, tmp237, _37
	vucomisd	%xmm3, %xmm4	# _37, tmp173
	ja	.L80	#,
	vsqrtsd	%xmm3, %xmm3, %xmm3	# _37, _39
.L54:
	testl	%r13d, %r13d	# nx
	jle	.L81	#,
	movl	$1, %eax	#, tmp197
	kmovb	%eax, %k1	# tmp197, tmp197
	movl	$2, %eax	#, tmp200
	vbroadcastsd	%xmm8, %zmm1{%k1}	# _266, rsSums_lsm.106, tmp197, rsSums_lsm.106
	kmovb	%eax, %k2	# tmp200, tmp200
	movl	$4, %eax	#, tmp203
	kmovb	%eax, %k3	# tmp203, tmp203
	vmovapd	%zmm1, %zmm0	# rsSums_lsm.106, rsSums_lsm.106
	movl	$8, %eax	#, tmp206
	kmovb	%eax, %k4	# tmp206, tmp206
	vbroadcastsd	%xmm7, %zmm0{%k2}	# _238, rsSums, tmp200, rsSums_lsm.106
	movl	$16, %eax	#, tmp209
	kmovb	%eax, %k5	# tmp209, tmp209
	vbroadcastsd	%xmm11, %zmm0{%k3}	# _226, rsSums, tmp203, rsSums
	movl	$32, %eax	#, tmp212
	kmovb	%eax, %k6	# tmp212, tmp212
	vbroadcastsd	%xmm2, %zmm0{%k4}	# _214, rsSums, tmp206, rsSums
	movl	$64, %eax	#, tmp215
	movslq	%r12d, %rdi	# ivtmp.132, _195
	kmovb	%eax, %k7	# tmp215, tmp215
	vbroadcastsd	%xmm10, %zmm0{%k5}	# _201, rsSums, tmp209, rsSums
	movl	$-128, %eax	#, tmp218
	movslq	%r13d, %rdx	# nx, nx
	kmovb	%eax, %k1	# tmp218, tmp218
	vbroadcastsd	%xmm5, %zmm0{%k6}	# _189, rsSums, tmp212, rsSums
	movq	%rdi, %rax	# _195, tmp219
	addq	%rdx, %rdi	# nx, tmp221
	vbroadcastsd	%xmm9, %zmm0{%k7}	# _177, rsSums, tmp215, rsSums
	salq	$6, %rax	#, tmp219
	salq	$6, %rdi	#, tmp222
	vbroadcastsd	%xmm3, %zmm0{%k1}	# _39, rsSums, tmp218, rsSums
	addq	%rbx, %rax	# input, ivtmp.114
	addq	%rbx, %rdi	# input, _219
	.p2align 4,,10
	.p2align 3
.L52:
	vmovapd	(%rax), %zmm5	# MEM[(double8_t *)_235], tmp308
	addq	$64, %rax	#, ivtmp.114
	vdivpd	%zmm0, %zmm5, %zmm1	# rsSums, tmp308, tmp223
	vmovapd	%zmm1, -64(%rax)	# tmp223, MEM[(double8_t *)_235]
	cmpq	%rax, %rdi	# ivtmp.114, _219
	jne	.L52	#,
	addl	%r15d, %r14d	# _18, ivtmp.131
	addl	%esi, %r12d	# _155, ivtmp.132
	cmpl	%r14d, %ecx	# ivtmp.131, vectorsPerCol
	jg	.L32	#,
.L71:
	vzeroupper
.L69:
	addq	$192, %rsp	#,
	popq	%rbx	#
	popq	%r10	#
	.cfi_remember_state
	.cfi_def_cfa 10, 0
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-8(%r10), %rsp	#,
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4,,10
	.p2align 3
.L81:
	.cfi_restore_state
	vxorpd	%xmm2, %xmm2, %xmm2	# vect_prephitmp_250.109
	addl	%r15d, %r14d	# _18, ivtmp.131
	addl	%esi, %r12d	# _155, ivtmp.132
	vmovapd	%ymm2, %ymm0	#, vect_prephitmp_250.109
	cmpl	%r14d, %ecx	# ivtmp.131, vectorsPerCol
	jg	.L51	#,
	jmp	.L71	#
	.p2align 4,,10
	.p2align 3
.L72:
	vxorpd	%xmm1, %xmm1, %xmm1	# rsSums_lsm.106
	jmp	.L58	#
.L65:
	vxorpd	%xmm0, %xmm0, %xmm0	# vect_prephitmp_250.109
	vmovapd	%ymm0, %ymm2	#, vect_prephitmp_250.109
	jmp	.L33	#
.L80:
	movl	%esi, -180(%rbp)	# _155, %sfp
	movl	%ecx, -176(%rbp)	# vectorsPerCol, %sfp
	vmovsd	%xmm8, -240(%rbp)	# _266, %sfp
	vmovsd	%xmm7, -232(%rbp)	# _238, %sfp
	vmovsd	%xmm11, -224(%rbp)	# _226, %sfp
	vmovsd	%xmm2, -216(%rbp)	# _214, %sfp
	vmovsd	%xmm10, -208(%rbp)	# _201, %sfp
	vmovsd	%xmm5, -200(%rbp)	# _189, %sfp
	vmovsd	%xmm9, -192(%rbp)	# _177, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vmovsd	%xmm3, %xmm3, %xmm0	# _37,
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm3	# tmp249, _39
	vmovsd	-240(%rbp), %xmm8	# %sfp, _266
	vmovsd	-232(%rbp), %xmm7	# %sfp, _238
	vmovsd	-224(%rbp), %xmm11	# %sfp, _226
	vmovsd	-216(%rbp), %xmm2	# %sfp, _214
	vmovsd	-208(%rbp), %xmm10	# %sfp, _201
	vmovsd	-200(%rbp), %xmm5	# %sfp, _189
	vmovsd	-192(%rbp), %xmm9	# %sfp, _177
	movl	-180(%rbp), %esi	# %sfp, _155
	movl	-176(%rbp), %ecx	# %sfp, vectorsPerCol
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L54	#
.L79:
	movl	%esi, -192(%rbp)	# _155, %sfp
	movl	%ecx, -180(%rbp)	# vectorsPerCol, %sfp
	vmovsd	%xmm8, -240(%rbp)	# _266, %sfp
	vmovsd	%xmm7, -232(%rbp)	# _238, %sfp
	vmovsd	%xmm11, -224(%rbp)	# _226, %sfp
	vmovsd	%xmm2, -216(%rbp)	# _214, %sfp
	vmovsd	%xmm10, -208(%rbp)	# _201, %sfp
	vmovsd	%xmm5, -200(%rbp)	# _189, %sfp
	vmovapd	%ymm3, -176(%rbp)	# tmp237, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vmovsd	%xmm9, %xmm9, %xmm0	# _181,
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm9	# tmp248, _177
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	vmovapd	-176(%rbp), %ymm3	# %sfp, tmp237
	movl	-180(%rbp), %ecx	# %sfp, vectorsPerCol
	movl	-192(%rbp), %esi	# %sfp, _155
	vmovsd	-200(%rbp), %xmm5	# %sfp, _189
	vmovsd	-208(%rbp), %xmm10	# %sfp, _201
	vmovsd	-216(%rbp), %xmm2	# %sfp, _214
	vmovsd	-224(%rbp), %xmm11	# %sfp, _226
	vmovsd	-232(%rbp), %xmm7	# %sfp, _238
	vmovsd	-240(%rbp), %xmm8	# %sfp, _266
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L48	#
.L78:
	movl	%esi, -192(%rbp)	# _155, %sfp
	movl	%ecx, -180(%rbp)	# vectorsPerCol, %sfp
	vmovsd	%xmm8, -232(%rbp)	# _266, %sfp
	vmovsd	%xmm7, -224(%rbp)	# _238, %sfp
	vmovsd	%xmm11, -216(%rbp)	# _226, %sfp
	vmovsd	%xmm2, -208(%rbp)	# _214, %sfp
	vmovsd	%xmm10, -200(%rbp)	# _201, %sfp
	vmovapd	%ymm3, -176(%rbp)	# tmp237, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm5	# tmp247, _189
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	vmovapd	-176(%rbp), %ymm3	# %sfp, tmp237
	movl	-180(%rbp), %ecx	# %sfp, vectorsPerCol
	movl	-192(%rbp), %esi	# %sfp, _155
	vmovsd	-200(%rbp), %xmm10	# %sfp, _201
	vmovsd	-208(%rbp), %xmm2	# %sfp, _214
	vmovsd	-216(%rbp), %xmm11	# %sfp, _226
	vmovsd	-224(%rbp), %xmm7	# %sfp, _238
	vmovsd	-232(%rbp), %xmm8	# %sfp, _266
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L46	#
.L77:
	movl	%esi, -192(%rbp)	# _155, %sfp
	movl	%ecx, -180(%rbp)	# vectorsPerCol, %sfp
	vmovsd	%xmm8, -224(%rbp)	# _266, %sfp
	vmovsd	%xmm7, -216(%rbp)	# _238, %sfp
	vmovsd	%xmm11, -208(%rbp)	# _226, %sfp
	vmovsd	%xmm2, -200(%rbp)	# _214, %sfp
	vmovapd	%ymm3, -176(%rbp)	# tmp237, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vmovsd	%xmm10, %xmm10, %xmm0	# _205,
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm10	# tmp246, _201
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	vmovapd	-176(%rbp), %ymm3	# %sfp, tmp237
	movl	-180(%rbp), %ecx	# %sfp, vectorsPerCol
	movl	-192(%rbp), %esi	# %sfp, _155
	vmovsd	-200(%rbp), %xmm2	# %sfp, _214
	vmovsd	-208(%rbp), %xmm11	# %sfp, _226
	vmovsd	-216(%rbp), %xmm7	# %sfp, _238
	vmovsd	-224(%rbp), %xmm8	# %sfp, _266
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L44	#
.L76:
	movl	%esi, -180(%rbp)	# _155, %sfp
	movl	%ecx, -176(%rbp)	# vectorsPerCol, %sfp
	vmovsd	%xmm8, -208(%rbp)	# _266, %sfp
	vmovsd	%xmm7, -200(%rbp)	# _238, %sfp
	vmovsd	%xmm11, -192(%rbp)	# _226, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vmovsd	%xmm2, %xmm2, %xmm0	# _218,
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm2	# tmp245, _214
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	movl	-176(%rbp), %ecx	# %sfp, vectorsPerCol
	movl	-180(%rbp), %esi	# %sfp, _155
	vmovsd	-192(%rbp), %xmm11	# %sfp, _226
	vmovsd	-200(%rbp), %xmm7	# %sfp, _238
	vmovsd	-208(%rbp), %xmm8	# %sfp, _266
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L42	#
.L75:
	movl	%esi, -192(%rbp)	# _155, %sfp
	movl	%ecx, -180(%rbp)	# vectorsPerCol, %sfp
	vmovsd	%xmm8, -208(%rbp)	# _266, %sfp
	vmovsd	%xmm7, -200(%rbp)	# _238, %sfp
	vmovapd	%ymm2, -176(%rbp)	# tmp236, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vmovsd	%xmm11, %xmm11, %xmm0	# _230,
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm11	# tmp244, _226
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	vmovapd	-176(%rbp), %ymm2	# %sfp, tmp236
	movl	-180(%rbp), %ecx	# %sfp, vectorsPerCol
	movl	-192(%rbp), %esi	# %sfp, _155
	vmovsd	-200(%rbp), %xmm7	# %sfp, _238
	vmovsd	-208(%rbp), %xmm8	# %sfp, _266
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L40	#
.L74:
	movl	%esi, -192(%rbp)	# _155, %sfp
	movl	%ecx, -180(%rbp)	# vectorsPerCol, %sfp
	vmovsd	%xmm8, -200(%rbp)	# _266, %sfp
	vmovapd	%ymm2, -176(%rbp)	# tmp236, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm7	# tmp243, _238
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	vmovapd	-176(%rbp), %ymm2	# %sfp, tmp236
	movl	-180(%rbp), %ecx	# %sfp, vectorsPerCol
	movl	-192(%rbp), %esi	# %sfp, _155
	vmovsd	-200(%rbp), %xmm8	# %sfp, _266
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L38	#
.L73:
	movl	%esi, -192(%rbp)	# _155, %sfp
	movl	%ecx, -180(%rbp)	# vectorsPerCol, %sfp
	vmovapd	%ymm1, -176(%rbp)	# tmp236, %sfp
	vmovapd	%ymm6, -144(%rbp)	# _246, %sfp
	vmovapd	%zmm1, -112(%rbp)	# rsSums_lsm.106, %sfp
	vzeroupper
	call	sqrt@PLT	#
	vmovsd	%xmm0, %xmm0, %xmm8	# tmp242, _266
	vmovapd	-112(%rbp), %zmm1	# %sfp, rsSums_lsm.106
	vmovapd	-144(%rbp), %ymm6	# %sfp, _246
	vmovapd	-176(%rbp), %ymm2	# %sfp, tmp236
	movl	-180(%rbp), %ecx	# %sfp, vectorsPerCol
	movl	-192(%rbp), %esi	# %sfp, _155
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp173
	jmp	.L36	#
	.cfi_endproc
.LFE7672:
	.size	_Z9correlateiiPKfPf._omp_fn.1, .-_Z9correlateiiPKfPf._omp_fn.1
	.p2align 4
	.type	_Z9correlateiiPKfPf._omp_fn.2, @function
_Z9correlateiiPKfPf._omp_fn.2:
.LFB7673:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%rbx	#
	andq	$-64, %rsp	#,
	subq	$1280, %rsp	#,
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	24(%rdi), %r13d	# *.omp_data_i_21(D).vectorsPerCol, vectorsPerCol
	movq	8(%rdi), %rcx	# *.omp_data_i_21(D).input, input
	movl	20(%rdi), %ebx	# *.omp_data_i_21(D).nx, nx
	movq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp758
	movq	%rdx, 1272(%rsp)	# tmp758, D.63483
	xorl	%edx, %edx	# tmp758
	movq	(%rdi), %r12	# *.omp_data_i_21(D).result, result
	movq	%rcx, 8(%rsp)	# input, %sfp
	movl	%r13d, 108(%rsp)	# vectorsPerCol, %sfp
	movl	%ebx, 92(%rsp)	# nx, %sfp
	movl	16(%rdi), %r15d	# *.omp_data_i_21(D).ny, ny
	call	omp_get_num_threads@PLT	#
	movl	%eax, 36(%rsp)	# tmp739, %sfp
	call	omp_get_thread_num@PLT	#
	cmpl	%eax, %r13d	# _32, vectorsPerCol
	jle	.L82	#,
	movl	%eax, %r14d	# tmp740, _32
	leal	0(,%rax,8), %edx	#, ivtmp.243
	kmovd	36(%rsp), %k6	# %sfp, _28
	leal	0(,%r15,8), %eax	#, _545
	kmovd	%k6, %ecx	#, _28
	movl	%ecx, %esi	# _28, _638
	imull	%eax, %esi	# _545, _638
	movl	%edx, 184(%rsp)	# ivtmp.243, %sfp
	addl	$2, %edx	#, tmp378
	imull	%r15d, %edx	# ny, tmp378
	kmovd	%esi, %k2	# _638, _638
	imull	%r14d, %eax	# _32, tmp379
	movl	%ebx, %esi	# nx, nx
	imull	%ecx, %ebx	# _28, _648
	subl	%edx, %eax	# ivtmp.254, tmp379
	movl	%eax, 4(%rsp)	# tmp379, %sfp
	kmovd	%ebx, %k1	# _648, _648
	movl	%esi, %ebx	# nx, ivtmp.259
	leal	(%r15,%r15), %eax	#, _663
	imull	%r14d, %ebx	# _32, ivtmp.259
	kmovd	%eax, %k0	# _663, _663
	leal	(%rsi,%rsi), %eax	#, _532
	movl	%eax, 72(%rsp)	# _532, %sfp
	movslq	%esi, %rcx	# nx, nx
	leaq	192(%rsp), %rax	#, tmp1109
	movl	%edx, 96(%rsp)	# ivtmp.254, %sfp
	movl	%ebx, 32(%rsp)	# ivtmp.259, %sfp
	movq	%rax, 64(%rsp)	# tmp1109, %sfp
	movq	%rcx, 16(%rsp)	# nx, %sfp
	vxorps	%xmm0, %xmm0, %xmm0	# tmp741
	vxorpd	%xmm15, %xmm15, %xmm15	# tmp737
	movq	%r12, %r9	# result, result
	movl	%r15d, %r10d	# ny, ny
	movl	%r14d, %edi	# _32, _32
	kshiftld	$3, %k6, %k3	#, _28, _41
	kmovd	%k1, 28(%rsp)	# _648, %sfp
	kmovd	%k3, %k7	# _41, _41
	kmovd	%k2, %k6	# _638, _638
	kmovd	%k0, 24(%rsp)	# _663, %sfp
.L85:
	# --- Compute - Inner
	cmpl	%edi, 108(%rsp)	# _32, %sfp
	jle	.L89	#,
	movl	96(%rsp), %eax	# %sfp, ivtmp.254
	movl	4(%rsp), %esi	# %sfp, _679
	movl	184(%rsp), %r11d	# %sfp, ivtmp.243
	leal	(%rax,%rsi), %ecx	#, _211
	movl	%ecx, 84(%rsp)	# _211, %sfp
	leal	3(%r11), %ecx	#, i
	movl	%ecx, 188(%rsp)	# i, %sfp
	movl	24(%rsp), %ecx	# %sfp, _663
	subl	%r10d, %eax	# ny, _68
	movl	%eax, 88(%rsp)	# _68, %sfp
	addl	%ecx, %eax	# _663, _487
	movl	%eax, 76(%rsp)	# _487, %sfp
	addl	%r10d, %eax	# ny, _415
	movl	%eax, 80(%rsp)	# _415, %sfp
	addl	%r10d, %eax	# ny, _69
	movl	%eax, 156(%rsp)	# _69, %sfp
	addl	%r10d, %eax	# ny, _52
	movl	%eax, 164(%rsp)	# _52, %sfp
	addl	%r10d, %eax	# ny, _58
	movl	32(%rsp), %edx	# %sfp, ivtmp.259
	movl	%eax, 160(%rsp)	# _58, %sfp
	movl	92(%rsp), %eax	# %sfp, nx
	leal	4(%r11), %esi	#, i
	addl	%edx, %eax	# ivtmp.259, ivtmp.233
	movl	%eax, 100(%rsp)	# ivtmp.233, %sfp
	movslq	%edx, %rax	# ivtmp.259, _377
	movl	%esi, 176(%rsp)	# i, %sfp
	movq	%rax, %rcx	# _377, _490
	movq	8(%rsp), %rsi	# %sfp, input
	salq	$6, %rcx	#, _490
	movq	%rcx, 48(%rsp)	# _490, %sfp
	addq	%rsi, %rcx	# input, ivtmp.203
	movq	%rcx, 56(%rsp)	# ivtmp.203, %sfp
	movq	16(%rsp), %rcx	# %sfp, nx
	movl	%edi, 112(%rsp)	# _32, %sfp
	addq	%rcx, %rax	# nx, tmp381
	salq	$6, %rax	#, tmp382
	addq	%rsi, %rax	# input, _519
	movq	%rax, 40(%rsp)	# _519, %sfp
	movl	%edi, (%rsp)	# _32, %sfp
	leal	8(%r11), %ebx	#, ivtmp.230
	leal	1(%r11), %r8d	#, i
	movl	176(%rsp), %esi	# %sfp, i
	movl	188(%rsp), %ecx	# %sfp, i
	leal	2(%r11), %r13d	#, i
	movl	%ebx, 188(%rsp)	# ivtmp.230, %sfp
	leal	5(%r11), %r12d	#, i
	leal	6(%r11), %r14d	#, i
	leal	7(%r11), %r15d	#, i
	movl	%r8d, %ebx	# i, i
	.p2align 4,,10
	.p2align 3
.L88:
	# --- Setting to zero
	vmovapd	%zmm15, 192(%rsp)	# tmp737, vv[0]
	vmovapd	%zmm15, 256(%rsp)	# tmp737, vv[1]
	vmovapd	%zmm15, 320(%rsp)	# tmp737, vv[2]
	vmovapd	%zmm15, 384(%rsp)	# tmp737, vv[3]
	vmovapd	%zmm15, 448(%rsp)	# tmp737, vv[4]
	vmovapd	%zmm15, 512(%rsp)	# tmp737, vv[5]
	vmovapd	%zmm15, 576(%rsp)	# tmp737, vv[6]
	vmovapd	%zmm15, 640(%rsp)	# tmp737, vv[7]
	vmovapd	%zmm15, 704(%rsp)	# tmp737, vv[8]
	vmovapd	%zmm15, 768(%rsp)	# tmp737, vv[9]
	vmovapd	%zmm15, 832(%rsp)	# tmp737, vv[10]
	vmovapd	%zmm15, 896(%rsp)	# tmp737, vv[11]
	vmovapd	%zmm15, 960(%rsp)	# tmp737, vv[12]
	vmovapd	%zmm15, 1024(%rsp)	# tmp737, vv[13]
	vmovapd	%zmm15, 1088(%rsp)	# tmp737, vv[14]
	vmovapd	%zmm15, 1152(%rsp)	# tmp737, vv[15]
	# --- Compute - Computing
	movl	92(%rsp), %eax	# %sfp,
	testl	%eax, %eax	#
	jle	.L125	#,
	movl	112(%rsp), %eax	# %sfp, inner
	vmovdqa64	idx(%rip), %zmm24	# idx, idx.17_94
	incl	%eax	# tmp620
	vmovapd	192(%rsp), %zmm11	# vv[0], vv_I_lsm.141
	vmovapd	256(%rsp), %zmm8	# vv[1], vv_I_lsm.142
	vmovapd	320(%rsp), %zmm12	# vv[2], vv_I_lsm.143
	vmovapd	384(%rsp), %zmm7	# vv[3], vv_I_lsm.144
	vmovapd	448(%rsp), %zmm13	# vv[4], vv_I_lsm.145
	vmovapd	512(%rsp), %zmm9	# vv[5], vv_I_lsm.146
	vmovapd	576(%rsp), %zmm14	# vv[6], vv_I_lsm.147
	vmovapd	640(%rsp), %zmm10	# vv[7], vv_I_lsm.148
	vmovapd	704(%rsp), %zmm20	# vv[8], vv_I_lsm.149
	vmovapd	768(%rsp), %zmm16	# vv[9], vv_I_lsm.151
	vmovapd	832(%rsp), %zmm21	# vv[10], vv_I_lsm.153
	vmovapd	896(%rsp), %zmm17	# vv[11], vv_I_lsm.155
	vmovapd	960(%rsp), %zmm22	# vv[12], vv_I_lsm.157
	vmovapd	1024(%rsp), %zmm18	# vv[13], vv_I_lsm.159
	vmovapd	1088(%rsp), %zmm23	# vv[14], vv_I_lsm.161
	vmovapd	1152(%rsp), %zmm19	# vv[15], vv_I_lsm.163
	cmpl	%eax, 108(%rsp)	# tmp620, %sfp
	jle	.L126	#,
	movslq	100(%rsp), %rdi	# %sfp, ivtmp.233
	movq	%r9, 176(%rsp)	# result, %sfp
	movl	%r10d, 168(%rsp)	# ny, %sfp
	movl	%ebx, 152(%rsp)	# i, %sfp
	movslq	%edx, %r8	# ivtmp.231, _80
	movq	56(%rsp), %rax	# %sfp, ivtmp.203
	movq	48(%rsp), %r10	# %sfp, _490
	movq	40(%rsp), %rbx	# %sfp, _519
	salq	$6, %r8	#, _496
	salq	$6, %rdi	#, _478
	.p2align 4,,10
	.p2align 3
.L110:
	vmovapd	(%rax), %zmm1	# MEM[(double8_t *)_491], a000
	movq	%rax, %r9	# ivtmp.203, _143
	subq	%r10, %r9	# _490, _143
	vmovapd	%zmm1, %zmm3	# a000, tmp662
	vmovapd	(%r9,%r8), %zmm2	# MEM[(double8_t *)_143 + _496 * 1], b000
	vpermt2pd	%zmm1, %zmm24, %zmm3	# a000, idx.17_94, tmp662
	vshuff64x2	$177, %zmm3, %zmm3, %zmm4	#, tmp662, tmp667
	vshuff64x2	$177, %zmm1, %zmm1, %zmm6	#, a000, tmp671
	vpermilpd	$85, %zmm2, %zmm5	#, b000, tmp675
	vfmadd231pd	%zmm2, %zmm1, %zmm11	# b000, a000, vv_I_lsm.141
	vfmadd231pd	%zmm2, %zmm6, %zmm12	# b000, tmp671, vv_I_lsm.143
	vfmadd231pd	%zmm3, %zmm2, %zmm13	# tmp662, b000, vv_I_lsm.145
	vfmadd231pd	%zmm4, %zmm2, %zmm14	# tmp667, b000, vv_I_lsm.147
	vmovapd	(%r9,%rdi), %zmm2	# MEM[(double8_t *)_143 + _478 * 1], c000
	vfmadd231pd	%zmm5, %zmm1, %zmm8	# tmp675, a000, vv_I_lsm.142
	vfmadd231pd	%zmm5, %zmm6, %zmm7	# tmp675, tmp671, vv_I_lsm.144
	vfmadd231pd	%zmm5, %zmm3, %zmm9	# tmp675, tmp662, vv_I_lsm.146
	vfmadd231pd	%zmm5, %zmm4, %zmm10	# tmp675, tmp667, vv_I_lsm.148
	addq	$64, %rax	#, ivtmp.203
	vpermilpd	$85, %zmm2, %zmm5	#, c000, tmp699
	vfmadd231pd	%zmm2, %zmm1, %zmm20	# c000, a000, vv_I_lsm.149
	vfmadd231pd	%zmm5, %zmm1, %zmm16	# tmp699, a000, vv_I_lsm.151
	vfmadd231pd	%zmm2, %zmm6, %zmm21	# c000, tmp671, vv_I_lsm.153
	vfmadd231pd	%zmm5, %zmm6, %zmm17	# tmp699, tmp671, vv_I_lsm.155
	vfmadd231pd	%zmm2, %zmm3, %zmm22	# c000, tmp662, vv_I_lsm.157
	vfmadd231pd	%zmm3, %zmm5, %zmm18	# tmp662, tmp699, vv_I_lsm.159
	vfmadd231pd	%zmm2, %zmm4, %zmm23	# c000, tmp667, vv_I_lsm.161
	vfmadd231pd	%zmm4, %zmm5, %zmm19	# tmp667, tmp699, vv_I_lsm.163
	cmpq	%rbx, %rax	# _519, ivtmp.203
	jne	.L110	#,
	movq	176(%rsp), %r9	# %sfp, result
	movl	168(%rsp), %r10d	# %sfp, ny
	movl	152(%rsp), %ebx	# %sfp, i
	vmovapd	%zmm14, 576(%rsp)	# vv_I_lsm.147, vv[6]
	vmovapd	%zmm13, 448(%rsp)	# vv_I_lsm.145, vv[4]
	vmovapd	%zmm12, 320(%rsp)	# vv_I_lsm.143, vv[2]
	vmovapd	%zmm11, 192(%rsp)	# vv_I_lsm.141, vv[0]
	vmovapd	%zmm23, 1088(%rsp)	# vv_I_lsm.161, vv[14]
	vmovapd	%zmm22, 960(%rsp)	# vv_I_lsm.157, vv[12]
	vmovapd	%zmm21, 832(%rsp)	# vv_I_lsm.153, vv[10]
	vmovapd	%zmm20, 704(%rsp)	# vv_I_lsm.149, vv[8]
.L112:
	movl	84(%rsp), %edi	# %sfp, _211
	movq	64(%rsp), %rax	# %sfp, ivtmp.188
	movl	%r11d, 176(%rsp)	# ivtmp.229, %sfp
	movq	%rax, 168(%rsp)	# ivtmp.188, %sfp
	leal	(%rdi,%r11), %eax	#, tmp725
	movl	%eax, 152(%rsp)	# tmp725, %sfp
	movl	%edi, %eax	# _211, _211
	movl	188(%rsp), %edi	# %sfp, ivtmp.230
	movl	%edx, 104(%rsp)	# ivtmp.231, %sfp
	addl	%edi, %eax	# ivtmp.230, tmp726
	movl	%eax, 148(%rsp)	# tmp726, %sfp
	movl	88(%rsp), %eax	# %sfp, _68
	vpermilpd	$85, %zmm8, %zmm8	#, vv_I_lsm.142, tmp399
	leal	(%rax,%r11), %r8d	#, tmp727
	addl	%edi, %eax	# ivtmp.230, tmp728
	movl	%eax, 140(%rsp)	# tmp728, %sfp
	movl	96(%rsp), %eax	# %sfp, ivtmp.254
	movl	%r8d, 144(%rsp)	# tmp727, %sfp
	leal	(%r11,%rax), %r8d	#, tmp729
	addl	%edi, %eax	# ivtmp.230, tmp730
	movl	%eax, 132(%rsp)	# tmp730, %sfp
	movl	76(%rsp), %eax	# %sfp, _487
	movl	%r8d, 136(%rsp)	# tmp729, %sfp
	leal	(%rax,%r11), %r8d	#, tmp731
	addl	%edi, %eax	# ivtmp.230, tmp732
	movl	%eax, 124(%rsp)	# tmp732, %sfp
	movl	80(%rsp), %eax	# %sfp, _415
	movl	%r8d, 128(%rsp)	# tmp731, %sfp
	leal	(%rax,%r11), %r8d	#, tmp733
	movl	%r8d, 120(%rsp)	# tmp733, %sfp
	addl	%edi, %eax	# ivtmp.230, tmp734
	vpermilpd	$85, %zmm7, %zmm7	#, vv_I_lsm.144, tmp403
	vpermilpd	$85, %zmm9, %zmm9	#, vv_I_lsm.146, tmp407
	vpermilpd	$85, %zmm10, %zmm10	#, vv_I_lsm.148, tmp411
	vpermilpd	$85, %zmm16, %zmm16	#, vv_I_lsm.151, tmp415
	vpermilpd	$85, %zmm17, %zmm17	#, vv_I_lsm.155, tmp419
	vpermilpd	$85, %zmm18, %zmm18	#, vv_I_lsm.159, tmp423
	vpermilpd	$85, %zmm19, %zmm19	#, vv_I_lsm.163, tmp427
	movl	%eax, 116(%rsp)	# tmp734, %sfp
	vmovapd	%zmm8, 256(%rsp)	# tmp399, vv[1]
	vmovapd	%zmm7, 384(%rsp)	# tmp403, vv[3]
	vmovapd	%zmm9, 512(%rsp)	# tmp407, vv[5]
	vmovapd	%zmm10, 640(%rsp)	# tmp411, vv[7]
	vmovapd	%zmm16, 768(%rsp)	# tmp415, vv[9]
	vmovapd	%zmm17, 896(%rsp)	# tmp419, vv[11]
	vmovapd	%zmm18, 1024(%rsp)	# tmp423, vv[13]
	vmovapd	%zmm19, 1152(%rsp)	# tmp427, vv[15]
	xorl	%eax, %eax	# jb
	.p2align 4,,10
	.p2align 3
.L87:
	movl	176(%rsp), %edi	# %sfp, ivtmp.229
	movl	188(%rsp), %edx	# %sfp, ivtmp.230
	addl	%eax, %edi	# jb, j
	addl	%eax, %edx	# jb, j2
	# --- Compute - Returning
	movl	184(%rsp), %r11d	# %sfp, ivtmp.243
	cmpl	%r11d, %edi	# ivtmp.243, j
	movl	%r11d, %r8d	# ivtmp.243, tmp431
	cmovge	%edi, %r8d	# j,, tmp431
	cmpl	%r8d, %r10d	# tmp431, ny
	jle	.L90	#,
	movl	152(%rsp), %r11d	# %sfp, tmp725
	leal	(%r11,%rax), %r8d	#, tmp433
	movq	168(%rsp), %r11	# %sfp, ivtmp.188
	movslq	%r8d, %r8	# tmp433, tmp434
	vcvtsd2ss	(%r11), %xmm0, %xmm1	# MEM <double> [(vector(8) double *)_184], tmp741, tmp742
	vmovss	%xmm1, (%r9,%r8,4)	# tmp437, *_165
.L90:
	movl	184(%rsp), %r11d	# %sfp, ivtmp.243
	cmpl	%r11d, %edx	# ivtmp.243, j2
	movl	%r11d, %r8d	# ivtmp.243, tmp438
	cmovge	%edx, %r8d	# j2,, tmp438
	cmpl	%r8d, %r10d	# tmp438, ny
	jle	.L91	#,
	movl	148(%rsp), %r11d	# %sfp, tmp726
	leal	(%r11,%rax), %r8d	#, tmp440
	movq	168(%rsp), %r11	# %sfp, ivtmp.188
	movslq	%r8d, %r8	# tmp440, tmp441
	vcvtsd2ss	512(%r11), %xmm0, %xmm1	# MEM <double> [(vector(8) double *)_383 + 512B], tmp741, tmp743
	vmovss	%xmm1, (%r9,%r8,4)	# tmp444, *_177
.L91:
	cmpl	%ebx, %edi	# i, j
	movl	%ebx, %r8d	# i, tmp445
	cmovge	%edi, %r8d	# j,, tmp445
	cmpl	%r8d, %r10d	# tmp445, ny
	jle	.L92	#,
	movl	144(%rsp), %r11d	# %sfp, tmp727
	leal	(%r11,%rax), %r8d	#, tmp447
	movslq	%r8d, %r11	# tmp447, tmp448
	kmovq	%r11, %k5	# tmp448, tmp448
	movl	%eax, %r11d	# jb, tmp450
	xorl	$1, %r11d	#, tmp450
	movslq	%r11d, %r11	# tmp450, tmp451
	movslq	%eax, %r8	# jb, jb
	leaq	(%r8,%r11,8), %r8	#, tmp453
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_187])[jb_16], tmp741, tmp744
	kmovq	%k5, %r11	# tmp448, tmp448
	vmovss	%xmm1, (%r9,%r11,4)	# tmp456, *_193
.L92:
	cmpl	%ebx, %edx	# i, j2
	movl	%ebx, %r8d	# i, tmp457
	cmovge	%edx, %r8d	# j2,, tmp457
	cmpl	%r8d, %r10d	# tmp457, ny
	jle	.L93	#,
	movl	140(%rsp), %r11d	# %sfp, tmp728
	leal	(%r11,%rax), %r8d	#, tmp459
	movslq	%r8d, %r11	# tmp459, tmp460
	movl	%eax, %r8d	# jb, tmp462
	xorl	$1, %r8d	#, tmp462
	addl	$8, %r8d	#, tmp463
	kmovq	%r11, %k5	# tmp460, tmp460
	movslq	%r8d, %r8	# tmp463, tmp464
	movslq	%eax, %r11	# jb, jb
	leaq	(%r11,%r8,8), %r8	#, tmp466
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_199])[jb_16], tmp741, tmp745
	kmovq	%k5, %r11	# tmp460, tmp460
	vmovss	%xmm1, (%r9,%r11,4)	# tmp469, *_205
.L93:
	cmpl	%r13d, %edi	# i, j
	movl	%r13d, %r8d	# i, tmp470
	cmovge	%edi, %r8d	# j,, tmp470
	cmpl	%r8d, %r10d	# tmp470, ny
	jle	.L94	#,
	movl	136(%rsp), %r11d	# %sfp, tmp729
	leal	(%r11,%rax), %r8d	#, tmp472
	movslq	%r8d, %r11	# tmp472, tmp473
	kmovq	%r11, %k5	# tmp473, tmp473
	movl	%eax, %r11d	# jb, tmp475
	xorl	$2, %r11d	#, tmp475
	movslq	%r11d, %r11	# tmp475, tmp476
	movslq	%eax, %r8	# jb, jb
	leaq	(%r8,%r11,8), %r8	#, tmp478
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_215])[jb_16], tmp741, tmp746
	kmovq	%k5, %r11	# tmp473, tmp473
	vmovss	%xmm1, (%r9,%r11,4)	# tmp481, *_221
.L94:
	cmpl	%r13d, %edx	# i, j2
	movl	%r13d, %r8d	# i, tmp482
	cmovge	%edx, %r8d	# j2,, tmp482
	cmpl	%r8d, %r10d	# tmp482, ny
	jle	.L95	#,
	movl	132(%rsp), %r11d	# %sfp, tmp730
	leal	(%r11,%rax), %r8d	#, tmp484
	movslq	%r8d, %r11	# tmp484, tmp485
	movl	%eax, %r8d	# jb, tmp487
	xorl	$2, %r8d	#, tmp487
	addl	$8, %r8d	#, tmp488
	kmovq	%r11, %k5	# tmp485, tmp485
	movslq	%r8d, %r8	# tmp488, tmp489
	movslq	%eax, %r11	# jb, jb
	leaq	(%r11,%r8,8), %r8	#, tmp491
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_227])[jb_16], tmp741, tmp747
	kmovq	%k5, %r11	# tmp485, tmp485
	vmovss	%xmm1, (%r9,%r11,4)	# tmp494, *_233
.L95:
	cmpl	%ecx, %edi	# i, j
	movl	%ecx, %r8d	# i, tmp495
	cmovge	%edi, %r8d	# j,, tmp495
	cmpl	%r8d, %r10d	# tmp495, ny
	jle	.L96	#,
	movl	128(%rsp), %r11d	# %sfp, tmp731
	leal	(%r11,%rax), %r8d	#, tmp497
	movslq	%r8d, %r11	# tmp497, tmp498
	kmovq	%r11, %k5	# tmp498, tmp498
	movl	%eax, %r11d	# jb, tmp500
	xorl	$3, %r11d	#, tmp500
	movslq	%r11d, %r11	# tmp500, tmp501
	movslq	%eax, %r8	# jb, jb
	leaq	(%r8,%r11,8), %r8	#, tmp503
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_243])[jb_16], tmp741, tmp748
	kmovq	%k5, %r11	# tmp498, tmp498
	vmovss	%xmm1, (%r9,%r11,4)	# tmp506, *_249
.L96:
	cmpl	%ecx, %edx	# i, j2
	movl	%ecx, %r8d	# i, tmp507
	cmovge	%edx, %r8d	# j2,, tmp507
	cmpl	%r8d, %r10d	# tmp507, ny
	jle	.L97	#,
	movl	124(%rsp), %r11d	# %sfp, tmp732
	leal	(%r11,%rax), %r8d	#, tmp509
	movslq	%r8d, %r11	# tmp509, tmp510
	movl	%eax, %r8d	# jb, tmp512
	xorl	$3, %r8d	#, tmp512
	addl	$8, %r8d	#, tmp513
	kmovq	%r11, %k5	# tmp510, tmp510
	movslq	%r8d, %r8	# tmp513, tmp514
	movslq	%eax, %r11	# jb, jb
	leaq	(%r11,%r8,8), %r8	#, tmp516
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_255])[jb_16], tmp741, tmp749
	kmovq	%k5, %r11	# tmp510, tmp510
	vmovss	%xmm1, (%r9,%r11,4)	# tmp519, *_261
.L97:
	cmpl	%esi, %edi	# i, j
	movl	%esi, %r8d	# i, tmp520
	cmovge	%edi, %r8d	# j,, tmp520
	cmpl	%r8d, %r10d	# tmp520, ny
	jle	.L98	#,
	movl	120(%rsp), %r11d	# %sfp, tmp733
	leal	(%r11,%rax), %r8d	#, tmp522
	movslq	%r8d, %r11	# tmp522, tmp523
	kmovq	%r11, %k5	# tmp523, tmp523
	movl	%eax, %r11d	# jb, tmp525
	xorl	$4, %r11d	#, tmp525
	movslq	%r11d, %r11	# tmp525, tmp526
	movslq	%eax, %r8	# jb, jb
	leaq	(%r8,%r11,8), %r8	#, tmp528
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_271])[jb_16], tmp741, tmp750
	kmovq	%k5, %r11	# tmp523, tmp523
	vmovss	%xmm1, (%r9,%r11,4)	# tmp531, *_277
.L98:
	cmpl	%esi, %edx	# i, j2
	movl	%esi, %r8d	# i, tmp532
	cmovge	%edx, %r8d	# j2,, tmp532
	cmpl	%r8d, %r10d	# tmp532, ny
	jle	.L99	#,
	movl	116(%rsp), %r11d	# %sfp, tmp734
	leal	(%r11,%rax), %r8d	#, tmp534
	movslq	%r8d, %r11	# tmp534, tmp535
	movl	%eax, %r8d	# jb, tmp537
	xorl	$4, %r8d	#, tmp537
	addl	$8, %r8d	#, tmp538
	kmovq	%r11, %k5	# tmp535, tmp535
	movslq	%r8d, %r8	# tmp538, tmp539
	movslq	%eax, %r11	# jb, jb
	leaq	(%r11,%r8,8), %r8	#, tmp541
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_283])[jb_16], tmp741, tmp751
	kmovq	%k5, %r11	# tmp535, tmp535
	vmovss	%xmm1, (%r9,%r11,4)	# tmp544, *_289
.L99:
	cmpl	%r12d, %edi	# i, j
	movl	%r12d, %r8d	# i, tmp545
	cmovge	%edi, %r8d	# j,, tmp545
	cmpl	%r8d, %r10d	# tmp545, ny
	jle	.L100	#,
	movl	156(%rsp), %r11d	# %sfp, _69
	movl	176(%rsp), %r8d	# %sfp, ivtmp.229
	addl	%r11d, %r8d	# _69, tmp546
	addl	%eax, %r8d	# jb, tmp547
	movslq	%r8d, %r11	# tmp547, tmp548
	kmovq	%r11, %k5	# tmp548, tmp548
	movl	%eax, %r11d	# jb, tmp550
	xorl	$5, %r11d	#, tmp550
	movslq	%r11d, %r11	# tmp550, tmp551
	movslq	%eax, %r8	# jb, jb
	leaq	(%r8,%r11,8), %r8	#, tmp553
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_299])[jb_16], tmp741, tmp752
	kmovq	%k5, %r11	# tmp548, tmp548
	vmovss	%xmm1, (%r9,%r11,4)	# tmp556, *_305
.L100:
	cmpl	%r12d, %edx	# i, j2
	movl	%r12d, %r8d	# i, tmp557
	cmovge	%edx, %r8d	# j2,, tmp557
	cmpl	%r8d, %r10d	# tmp557, ny
	jle	.L101	#,
	movl	156(%rsp), %r11d	# %sfp, _69
	movl	188(%rsp), %r8d	# %sfp, ivtmp.230
	addl	%r11d, %r8d	# _69, tmp558
	addl	%eax, %r8d	# jb, tmp559
	movslq	%r8d, %r11	# tmp559, tmp560
	movl	%eax, %r8d	# jb, tmp562
	xorl	$5, %r8d	#, tmp562
	addl	$8, %r8d	#, tmp563
	kmovq	%r11, %k5	# tmp560, tmp560
	movslq	%r8d, %r8	# tmp563, tmp564
	movslq	%eax, %r11	# jb, jb
	leaq	(%r11,%r8,8), %r8	#, tmp566
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_311])[jb_16], tmp741, tmp753
	kmovq	%k5, %r11	# tmp560, tmp560
	vmovss	%xmm1, (%r9,%r11,4)	# tmp569, *_317
.L101:
	cmpl	%r14d, %edi	# i, j
	movl	%r14d, %r8d	# i, tmp570
	cmovge	%edi, %r8d	# j,, tmp570
	cmpl	%r8d, %r10d	# tmp570, ny
	jle	.L102	#,
	movl	164(%rsp), %r11d	# %sfp, _52
	movl	176(%rsp), %r8d	# %sfp, ivtmp.229
	addl	%r11d, %r8d	# _52, tmp571
	addl	%eax, %r8d	# jb, tmp572
	movslq	%r8d, %r11	# tmp572, tmp573
	kmovq	%r11, %k5	# tmp573, tmp573
	movl	%eax, %r11d	# jb, tmp575
	xorl	$6, %r11d	#, tmp575
	movslq	%r11d, %r11	# tmp575, tmp576
	movslq	%eax, %r8	# jb, jb
	leaq	(%r8,%r11,8), %r8	#, tmp578
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_327])[jb_16], tmp741, tmp754
	kmovq	%k5, %r11	# tmp573, tmp573
	vmovss	%xmm1, (%r9,%r11,4)	# tmp581, *_333
.L102:
	cmpl	%r14d, %edx	# i, j2
	movl	%r14d, %r8d	# i, tmp582
	cmovge	%edx, %r8d	# j2,, tmp582
	cmpl	%r8d, %r10d	# tmp582, ny
	jle	.L103	#,
	movl	164(%rsp), %r11d	# %sfp, _52
	movl	188(%rsp), %r8d	# %sfp, ivtmp.230
	addl	%r11d, %r8d	# _52, tmp583
	addl	%eax, %r8d	# jb, tmp584
	movslq	%r8d, %r11	# tmp584, tmp585
	movl	%eax, %r8d	# jb, tmp587
	xorl	$6, %r8d	#, tmp587
	addl	$8, %r8d	#, tmp588
	kmovq	%r11, %k5	# tmp585, tmp585
	movslq	%r8d, %r8	# tmp588, tmp589
	movslq	%eax, %r11	# jb, jb
	leaq	(%r11,%r8,8), %r8	#, tmp591
	vcvtsd2ss	192(%rsp,%r8,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_339])[jb_16], tmp741, tmp755
	kmovq	%k5, %r11	# tmp585, tmp585
	vmovss	%xmm1, (%r9,%r11,4)	# tmp594, *_345
.L103:
	cmpl	%r15d, %edi	# i, j
	cmovl	%r15d, %edi	# j,, i, tmp595
	cmpl	%edi, %r10d	# tmp595, ny
	jle	.L104	#,
	movl	176(%rsp), %r11d	# %sfp, ivtmp.229
	movl	160(%rsp), %edi	# %sfp, _58
	movl	%eax, %r8d	# jb, tmp600
	addl	%r11d, %edi	# ivtmp.229, tmp596
	addl	%eax, %edi	# jb, tmp597
	xorl	$7, %r8d	#, tmp600
	movslq	%edi, %r11	# tmp597, tmp598
	movslq	%r8d, %r8	# tmp600, tmp601
	movslq	%eax, %rdi	# jb, jb
	leaq	(%rdi,%r8,8), %rdi	#, tmp603
	vcvtsd2ss	192(%rsp,%rdi,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_355])[jb_16], tmp741, tmp756
	vmovss	%xmm1, (%r9,%r11,4)	# tmp606, *_361
.L104:
	cmpl	%r15d, %edx	# i, j2
	cmovl	%r15d, %edx	# j2,, i, tmp607
	cmpl	%edx, %r10d	# tmp607, ny
	jle	.L105	#,
	movl	160(%rsp), %edi	# %sfp, _58
	movl	188(%rsp), %edx	# %sfp, ivtmp.230
	addl	%edi, %edx	# _58, tmp608
	addl	%eax, %edx	# jb, tmp609
	movslq	%edx, %r8	# tmp609, tmp610
	movl	%eax, %edx	# jb, tmp612
	xorl	$7, %edx	#, tmp612
	addl	$8, %edx	#, tmp613
	movslq	%eax, %rdi	# jb, jb
	movslq	%edx, %rdx	# tmp613, tmp614
	leaq	(%rdi,%rdx,8), %rdx	#, tmp616
	vcvtsd2ss	192(%rsp,%rdx,8), %xmm0, %xmm1	# VIEW_CONVERT_EXPR<double[8]>(vv[_367])[jb_16], tmp741, tmp757
	vmovss	%xmm1, (%r9,%r8,4)	# tmp619, *_373
.L105:
	incl	%eax	# jb
	addq	$72, 168(%rsp)	#, %sfp
	cmpl	$8, %eax	#, jb
	jne	.L87	#,
	addl	$2, 112(%rsp)	#, %sfp
	movl	72(%rsp), %edi	# %sfp, _532
	movl	176(%rsp), %r11d	# %sfp, ivtmp.229
	movl	104(%rsp), %edx	# %sfp, ivtmp.231
	movl	112(%rsp), %eax	# %sfp, inner
	addl	$16, 188(%rsp)	#, %sfp
	addl	%edi, 100(%rsp)	# _532, %sfp
	addl	$16, %r11d	#, ivtmp.229
	addl	%edi, %edx	# _532, ivtmp.231
	cmpl	%eax, 108(%rsp)	# inner, %sfp
	jg	.L88	#,
	movl	(%rsp), %edi	# %sfp, _32
.L89:
	movl	36(%rsp), %eax	# %sfp, _28
	kmovd	%k7, %esi	# _41, _41
	addl	%esi, 184(%rsp)	# _41, %sfp
	movl	28(%rsp), %esi	# %sfp, _648
	addl	%eax, %edi	# _28, _32
	kmovd	%k6, %ecx	# _638, _638
	addl	%esi, 32(%rsp)	# _648, %sfp
	addl	%ecx, 96(%rsp)	# _638, %sfp
	cmpl	%edi, 108(%rsp)	# _32, %sfp
	jg	.L85	#,
	vzeroupper
.L82:
	movq	1272(%rsp), %rax	# D.63483, tmp759
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp759
	jne	.L127	#,
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
.L126:
	.cfi_restore_state
	movq	%r9, 176(%rsp)	# result, %sfp
	movl	%r10d, 168(%rsp)	# ny, %sfp
	movslq	%edx, %rdi	# ivtmp.231, _80
	movq	56(%rsp), %rax	# %sfp, ivtmp.196
	movq	48(%rsp), %r9	# %sfp, _490
	movq	40(%rsp), %r10	# %sfp, _519
	salq	$6, %rdi	#, _111
	.p2align 4,,10
	.p2align 3
.L108:
	vmovapd	(%rax), %zmm2	# MEM[(double8_t *)_266], a000
	movq	%rax, %r8	# ivtmp.196, tmp635
	subq	%r9, %r8	# _490, tmp635
	vmovapd	(%r8,%rdi), %zmm1	# MEM[(double8_t *)_107 + _111 * 1], b000
	vmovapd	%zmm2, %zmm4	# a000, tmp622
	vpermt2pd	%zmm2, %zmm24, %zmm4	# a000, idx.17_94, tmp622
	vpermilpd	$85, %zmm1, %zmm3	#, b000, tmp636
	vshuff64x2	$177, %zmm4, %zmm4, %zmm5	#, tmp622, tmp627
	vshuff64x2	$177, %zmm2, %zmm2, %zmm6	#, a000, tmp631
	addq	$64, %rax	#, ivtmp.196
	vfmadd231pd	%zmm1, %zmm2, %zmm11	# b000, a000, vv_I_lsm.141
	vfmadd231pd	%zmm3, %zmm2, %zmm8	# tmp636, a000, vv_I_lsm.142
	vfmadd231pd	%zmm1, %zmm6, %zmm12	# b000, tmp631, vv_I_lsm.143
	vfmadd231pd	%zmm3, %zmm6, %zmm7	# tmp636, tmp631, vv_I_lsm.144
	vfmadd231pd	%zmm4, %zmm1, %zmm13	# tmp622, b000, vv_I_lsm.145
	vfmadd231pd	%zmm4, %zmm3, %zmm9	# tmp622, tmp636, vv_I_lsm.146
	vfmadd231pd	%zmm5, %zmm1, %zmm14	# tmp627, b000, vv_I_lsm.147
	vfmadd231pd	%zmm5, %zmm3, %zmm10	# tmp627, tmp636, vv_I_lsm.148
	cmpq	%r10, %rax	# _519, ivtmp.196
	jne	.L108	#,
	movq	176(%rsp), %r9	# %sfp, result
	movl	168(%rsp), %r10d	# %sfp, ny
	vmovapd	%zmm14, 576(%rsp)	# vv_I_lsm.147, vv[6]
	vmovapd	%zmm13, 448(%rsp)	# vv_I_lsm.145, vv[4]
	vmovapd	%zmm12, 320(%rsp)	# vv_I_lsm.143, vv[2]
	vmovapd	%zmm11, 192(%rsp)	# vv_I_lsm.141, vv[0]
	jmp	.L112	#
.L125:
	vmovapd	256(%rsp), %zmm8	# vv[1], vv_I_lsm.142
	vmovapd	384(%rsp), %zmm7	# vv[3], vv_I_lsm.144
	vmovapd	512(%rsp), %zmm9	# vv[5], vv_I_lsm.146
	vmovapd	640(%rsp), %zmm10	# vv[7], vv_I_lsm.148
	vmovapd	768(%rsp), %zmm16	# vv[9], vv_I_lsm.151
	vmovapd	896(%rsp), %zmm17	# vv[11], vv_I_lsm.155
	vmovapd	1024(%rsp), %zmm18	# vv[13], vv_I_lsm.159
	vmovapd	1152(%rsp), %zmm19	# vv[15], vv_I_lsm.163
	jmp	.L112	#
.L127:
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE7673:
	.size	_Z9correlateiiPKfPf._omp_fn.2, .-_Z9correlateiiPKfPf._omp_fn.2
	.section	.text.unlikely,"ax",@progbits
.LCOLDB1:
	.text
.LHOTB1:
	.p2align 4
	.globl	_Z9correlateiiPKfPf
	.type	_Z9correlateiiPKfPf, @function
_Z9correlateiiPKfPf:
.LFB7551:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	movq	%rdx, %r15	# tmp118, data
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movl	%edi, %r14d	# tmp116, ny
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movl	%esi, %ebp	# tmp117, nx
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leal	14(%rdi), %ebx	#, tmp97
	subq	$72, %rsp	#,
	.cfi_def_cfa_offset 128
	movq	%rcx, 8(%rsp)	# tmp119, %sfp
	leaq	16(%rsp), %r12	#, tmp102
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp122
	movq	%rax, 56(%rsp)	# tmp122, D.63494
	xorl	%eax, %eax	# tmp122
	movl	%edi, %eax	# ny, tmp95
	addl	$7, %eax	#, tmp95
	cmovns	%eax, %ebx	# tmp97,, tmp95, tmp96
	movq	%r12, %rdi	# tmp102,
	sarl	$3, %ebx	#, tmp98
	movl	%ebx, %edx	# tmp98, tmp99
	imull	%esi, %edx	# nx, tmp99
	movl	$64, %esi	#,
	movq	$0, 16(%rsp)	#, MEM[(void * *)_44]
	movslq	%edx, %rdx	# tmp99, tmp100
	salq	$6, %rdx	#, tmp101
	call	posix_memalign@PLT	#
	testl	%eax, %eax	# tmp120
	jne	.L132	#,
	movq	16(%rsp), %r13	# MEM[(void * *)_44], _38
	# --- Packing
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	movq	%r12, %rsi	# tmp102,
	leaq	_Z9correlateiiPKfPf._omp_fn.0(%rip), %rdi	#, tmp109
	movq	%r13, 24(%rsp)	# _38, MEM[(struct .omp_data_s.5 *)_44].input
	movl	%ebx, 40(%rsp)	# tmp98, MEM[(struct .omp_data_s.5 *)_44].vectorsPerCol
	movq	%r15, 16(%rsp)	# data, MEM[(struct .omp_data_s.5 *)_44].data
	movl	%ebp, 36(%rsp)	# nx, MEM[(struct .omp_data_s.5 *)_44].nx
	movl	%r14d, 32(%rsp)	# ny, MEM[(struct .omp_data_s.5 *)_44].ny
	call	GOMP_parallel@PLT	#
	# --- Normalization step
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	movq	%r12, %rsi	# tmp102,
	leaq	_Z9correlateiiPKfPf._omp_fn.1(%rip), %rdi	#, tmp111
	movq	%r13, 16(%rsp)	# _38, MEM[(struct .omp_data_s.6 *)_44].input
	movl	%ebx, 28(%rsp)	# tmp98, MEM[(struct .omp_data_s.6 *)_44].vectorsPerCol
	movl	%ebp, 24(%rsp)	# nx, MEM[(struct .omp_data_s.6 *)_44].nx
	call	GOMP_parallel@PLT	#
	# --- Compute - Outer
	movq	8(%rsp), %rax	# %sfp, result
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	movq	%r12, %rsi	# tmp102,
	leaq	_Z9correlateiiPKfPf._omp_fn.2(%rip), %rdi	#, tmp113
	movq	%rax, 16(%rsp)	# result, MEM[(struct .omp_data_s.7 *)_44].result
	movq	%r13, 24(%rsp)	# _38, MEM[(struct .omp_data_s.7 *)_44].input
	movl	%ebx, 40(%rsp)	# tmp98, MEM[(struct .omp_data_s.7 *)_44].vectorsPerCol
	movl	%ebp, 36(%rsp)	# nx, MEM[(struct .omp_data_s.7 *)_44].nx
	movl	%r14d, 32(%rsp)	# ny, MEM[(struct .omp_data_s.7 *)_44].ny
	call	GOMP_parallel@PLT	#
	movq	56(%rsp), %rax	# D.63494, tmp123
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp123
	jne	.L134	#,
	addq	$72, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	movq	%r13, %rdi	# _38,
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	jmp	free@PLT	#
.L134:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	_Z9correlateiiPKfPf.cold, @function
_Z9correlateiiPKfPf.cold:
.LFSB7551:
.L132:
	.cfi_def_cfa_offset 128
	.cfi_offset 3, -56
	.cfi_offset 6, -48
	.cfi_offset 12, -40
	.cfi_offset 13, -32
	.cfi_offset 14, -24
	.cfi_offset 15, -16
	movl	$8, %edi	#,
	call	__cxa_allocate_exception@PLT	#
	movq	%rax, %rdi	# tmp121, tmp103
	leaq	16+_ZTVSt9bad_alloc(%rip), %rax	#, tmp127
	movq	%rax, (%rdi)	# tmp127, MEM[(struct bad_alloc *)_37].D.20645._vptr.exception
	movq	_ZNSt9bad_allocD1Ev@GOTPCREL(%rip), %rdx	#,
	leaq	_ZTISt9bad_alloc(%rip), %rsi	#, tmp107
	call	__cxa_throw@PLT	#
	.cfi_endproc
.LFE7551:
	.text
	.size	_Z9correlateiiPKfPf, .-_Z9correlateiiPKfPf
	.section	.text.unlikely
	.size	_Z9correlateiiPKfPf.cold, .-_Z9correlateiiPKfPf.cold
.LCOLDE1:
	.text
.LHOTE1:
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.type	_GLOBAL__sub_I_idx, @function
_GLOBAL__sub_I_idx:
.LFB7670:
	.cfi_startproc
	endbr64	
	vmovdqa64	.LC2(%rip), %zmm0	#, tmp82
	vmovdqa64	%zmm0, idx(%rip)	# tmp82, idx
	vzeroupper
	ret	
	.cfi_endproc
.LFE7670:
	.size	_GLOBAL__sub_I_idx, .-_GLOBAL__sub_I_idx
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_idx
	.globl	idx
	.bss
	.align 64
	.type	idx, @object
	.size	idx, 64
idx:
	.zero	64
	.section	.rodata
	.align 64
.LC2:
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.quad	0
	.quad	1
	.quad	2
	.quad	3
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.ident	"GCC: (Ubuntu 12.1.0-2ubuntu1~22.04) 12.1.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4: