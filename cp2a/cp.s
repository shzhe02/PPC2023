	.file	"cp.cc"
# GNU C++17 (GCC) version 12.2.1 20221121 (Red Hat 12.2.1-4) (x86_64-redhat-linux)
#	compiled by GNU C version 12.2.1 20221121 (Red Hat 12.2.1-4), GMP version 6.2.1, MPFR version 4.1.0-p13, MPC version 1.2.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=znver2 -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -msse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512er -mno-avx512pf -mno-avx512vbmi -mno-avx512ifma -mno-avx5124vnniw -mno-avx5124fmaps -mno-avx512vpopcntdq -mno-avx512vbmi2 -mno-gfni -mno-vpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mclzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mno-movdir64b -mno-movdiri -mmwaitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mno-serialize -mno-sgx -msha -mno-shstk -mno-tbm -mno-tsxldtrk -mno-vaes -mno-waitpkg -mwbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mno-avxvnni -mno-avx512fp16 --param=l1-cache-size=32 --param=l1-cache-line-size=64 --param=l2-cache-size=512 -mtune=znver2 -O3 -std=c++17
	.text
	.p2align 4
	.globl	_Z9correlateiiPKfPf
	.type	_Z9correlateiiPKfPf, @function
_Z9correlateiiPKfPf:
.LFB967:
	.cfi_startproc
	leaq	8(%rsp), %r10	#,
	.cfi_def_cfa 10, 0
	andq	$-32, %rsp	#,
# cp.cc:4:     const int extra = nx % parallels;
	movl	%esi, %eax	# nx, tmp211
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	pushq	-8(%r10)	#
# cp.cc:4:     const int extra = nx % parallels;
	sarl	$31, %eax	#, tmp211
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	pushq	%rbp	#
# cp.cc:4:     const int extra = nx % parallels;
	shrl	$29, %eax	#, tmp212
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15	#
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	movq	%rdx, %r15	# tmp315, data
# cp.cc:4:     const int extra = nx % parallels;
	leal	(%rsi,%rax), %edx	#, tmp213
	andl	$7, %edx	#, tmp214
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
# cp.cc:4:     const int extra = nx % parallels;
	subl	%eax, %edx	# tmp212,
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	pushq	%r10	#
	.cfi_escape 0xf,0x3,0x76,0x58,0x6
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	.cfi_escape 0x10,0xd,0x2,0x76,0x68
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
# cp.cc:5:     const int max = (nx - extra) / parallels;
	movl	%esi, %r10d	# nx, _1
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	pushq	%rbx	#
	subq	$160, %rsp	#,
	.cfi_escape 0x10,0x3,0x2,0x76,0x50
# cp.cc:5:     const int max = (nx - extra) / parallels;
	subl	%edx, %r10d	# tmp215, _1
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	movq	%rcx, -128(%rbp)	# tmp316, %sfp
	movl	%edi, %ebx	# tmp313, ny
# cp.cc:5:     const int max = (nx - extra) / parallels;
	leal	7(%r10), %eax	#, tmp217
# cp.cc:2: void correlate(int ny, int nx, const float *data, float *result) {
	movl	%edi, -52(%rbp)	# ny, %sfp
# cp.cc:5:     const int max = (nx - extra) / parallels;
	cmovns	%r10d, %eax	# tmp217,, _1, _1
	sarl	$3, %eax	#, _1
	movl	%eax, %ecx	# _1, tmp218
# cp.cc:6:     double row[2*ny];
	leal	(%rdi,%rdi), %eax	#, tmp219
# cp.cc:6:     double row[2*ny];
	cltq
	leaq	0(,%rax,8), %rax	#, tmp227
	subq	%rax, %rsp	# tmp227,
# cp.cc:7:     for (int r = 0; r < ny; ++r) {
	testl	%edi, %edi	# ny
	jle	.L29	#,
	movslq	%ebx, %rax	# ny, _280
	movq	%rsp, %r8	#, tmp231
	movl	%esi, %edi	# tmp314, nx
	vxorps	%xmm2, %xmm2, %xmm2	# tmp318
	movq	%rax, -120(%rbp)	# _280, %sfp
	salq	$3, %rax	#, ivtmp.75
	movq	%r8, %r9	# tmp231, ivtmp.86
	xorl	%r11d, %r11d	# ivtmp.89
	leaq	(%r8,%rax), %rsi	#, ivtmp.87
	movslq	%edi, %rbx	# nx, nx
	movq	%rsi, %r12	# ivtmp.87, _303
.L4:
# cp.cc:8:         row[r] = 0;
	movq	$0x000000000, (%r9)	#, MEM[(double *)_293]
# cp.cc:9:         row[r + ny] = 0;
	movq	$0x000000000, (%rsi)	#, MEM[(double *)_297]
# cp.cc:10:         for (int c = 0; c < nx; ++c) {
	testl	%edi, %edi	# nx
	jle	.L7	#,
	movslq	%r11d, %r14	# ivtmp.89, _256
	leaq	(%r15,%r14,4), %r13	#, ivtmp.81
	addq	%rbx, %r14	# nx, tmp236
	leaq	(%r15,%r14,4), %r14	#, _272
	.p2align 4
	.p2align 3
.L6:
# cp.cc:11:             row[r] += (double) data[c + r * nx];
	vcvtss2sd	0(%r13), %xmm2, %xmm0	# MEM[(const float *)_265], tmp318, tmp319
# cp.cc:11:             row[r] += (double) data[c + r * nx];
	vaddsd	(%r9), %xmm0, %xmm1	# MEM[(double *)_293], _13, tmp238
# cp.cc:10:         for (int c = 0; c < nx; ++c) {
	addq	$4, %r13	#, ivtmp.81
# cp.cc:11:             row[r] += (double) data[c + r * nx];
	vmovsd	%xmm1, (%r9)	# tmp238, MEM[(double *)_293]
# cp.cc:12:             row[r + ny] += (double) data[c + r * nx] * data[c + r * nx];
	vfmadd213sd	(%rsi), %xmm0, %xmm0	# MEM[(double *)_297], _13, _17
	vmovsd	%xmm0, (%rsi)	# _17, MEM[(double *)_297]
# cp.cc:10:         for (int c = 0; c < nx; ++c) {
	cmpq	%r14, %r13	# _272, ivtmp.81
	jne	.L6	#,
.L7:
# cp.cc:7:     for (int r = 0; r < ny; ++r) {
	addq	$8, %r9	#, ivtmp.86
	addq	$8, %rsi	#, ivtmp.87
	addl	%edi, %r11d	# nx, ivtmp.89
	cmpq	%r12, %r9	# _303, ivtmp.86
	jne	.L4	#,
	cmpl	$7, %r10d	#, _1
	movl	$1, %esi	#, tmp241
	movslq	%r10d, %r11	# _1, _87
	movq	$0, -96(%rbp)	#, %sfp
	cmovg	%ecx, %esi	# tmp218,, tmp241
	xorl	%ecx, %ecx	# ivtmp.68
	addq	%r11, %rdx	# _87, tmp310
	movl	$0, -56(%rbp)	#, %sfp
	movl	%esi, %ebx	# tmp241,
	xorl	%esi, %esi	# ivtmp.76
	movq	%rdx, -80(%rbp)	# tmp310, %sfp
	movq	%rcx, -88(%rbp)	# ivtmp.68, %sfp
	salq	$5, %rbx	#, _198
	movq	%rax, -104(%rbp)	# ivtmp.75, %sfp
	movl	%esi, -108(%rbp)	# ivtmp.76, %sfp
	vcvtsi2sdl	%edi, %xmm2, %xmm3	# nx, tmp318, tmp320
.L18:
# cp.cc:29:                 sumIJ += sums[k];
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp307
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	movq	-104(%rbp), %rax	# %sfp, ivtmp.75
# cp.cc:16:         double sumJ = row[j];
	movq	-88(%rbp), %r13	# %sfp, ivtmp.68
	movslq	-108(%rbp), %rsi	# %sfp,
	movslq	-56(%rbp), %rdx	# %sfp, ivtmp.73
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vmulsd	(%r8,%rax), %xmm3, %xmm5	# MEM[(double *)row.0_102 + ivtmp.75_242 * 1], _596, tmp243
# cp.cc:16:         double sumJ = row[j];
	vmovsd	(%r8,%r13,8), %xmm6	# MEM[(double *)row.0_102 + ivtmp.68_229 * 8], sumJ
	movq	%rsi, %r14	#,
	movq	%rsi, -72(%rbp)	# _719, %sfp
	leaq	(%r15,%rsi,4), %r12	#, vectp.29
	movq	-128(%rbp), %rsi	# %sfp, result
	leaq	(%rsi,%rdx,4), %r9	#, _212
	movq	-96(%rbp), %rsi	# %sfp, ivtmp.74
	addq	%rsi, %rax	# ivtmp.74, tmp305
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vfnmadd231sd	%xmm6, %xmm6, %xmm5	# sumJ, sumJ, _603
	movq	%rax, -64(%rbp)	# tmp305, %sfp
	.p2align 4
	.p2align 3
.L8:
# cp.cc:23:             for (int n = 0; n < max; ++n) {
	vxorpd	%xmm8, %xmm8, %xmm8	# sumIJ
	cmpl	$7, %r10d	#, _1
	jle	.L17	#,
	movslq	%r14d, %rax	# ivtmp.64, ivtmp.64
# cp.cc:25:                     sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
	vxorpd	%xmm8, %xmm8, %xmm8	# vect_sums_7_87.33
	leaq	(%r15,%rax,4), %rdx	#, vectp.25
	vmovapd	%ymm8, %ymm10	#, vect__350.34
	xorl	%eax, %eax	# ivtmp.51
	.p2align 4
	.p2align 3
.L9:
# cp.cc:25:                     sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
	vmovups	(%rdx,%rax), %ymm1	# MEM <const vector(8) float> [(const float *)vectp.25_728 + ivtmp.51_188 * 1], tmp416
	vcvtps2pd	(%rdx,%rax), %ymm0	# MEM <const vector(8) float> [(const float *)vectp.25_728 + ivtmp.51_188 * 1], vect__341.27
	vextractf128	$0x1, %ymm1, %xmm7	# tmp416, tmp250
# cp.cc:25:                     sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
	vmovups	(%r12,%rax), %ymm1	# MEM <const vector(8) float> [(const float *)vectp.29_720 + ivtmp.51_188 * 1], tmp417
	addq	$32, %rax	#, ivtmp.51
# cp.cc:25:                     sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
	vcvtps2pd	%xmm7, %ymm7	# tmp250, vect__341.27
# cp.cc:25:                     sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
	vextractf128	$0x1, %ymm1, %xmm9	# tmp417, tmp252
	vcvtps2pd	%xmm1, %ymm1	#, vect__348.31
	vcvtps2pd	%xmm9, %ymm9	# tmp252, vect__348.31
# cp.cc:25:                     sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
	vfmadd231pd	%ymm0, %ymm1, %ymm10	# vect__341.27, vect__348.31, vect__350.34
	vfmadd231pd	%ymm7, %ymm9, %ymm8	# vect__341.27, vect__348.31, vect_sums_7_87.33
	cmpq	%rbx, %rax	# _198, ivtmp.51
	jne	.L9	#,
# cp.cc:29:                 sumIJ += sums[k];
	vaddsd	%xmm4, %xmm10, %xmm1	# tmp307, tmp255, tmp257
	vunpckhpd	%xmm10, %xmm10, %xmm0	# tmp256, tmp259
	vextractf128	$0x1, %ymm10, %xmm10	# vect__350.34, tmp263
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp259, tmp257, tmp261
	vunpckhpd	%xmm8, %xmm8, %xmm0	# tmp269, tmp271
	vaddsd	%xmm10, %xmm1, %xmm1	# tmp262, tmp261, tmp264
	vunpckhpd	%xmm10, %xmm10, %xmm10	# tmp263, tmp265
	vaddsd	%xmm10, %xmm1, %xmm10	# tmp265, tmp264, tmp267
	vaddsd	%xmm8, %xmm10, %xmm10	# tmp268, tmp267, tmp270
	vextractf128	$0x1, %ymm8, %xmm8	# vect_sums_7_87.33, tmp275
	vaddsd	%xmm0, %xmm10, %xmm10	# tmp271, tmp270, tmp273
	vaddsd	%xmm8, %xmm10, %xmm10	# tmp274, tmp273, tmp276
	vunpckhpd	%xmm8, %xmm8, %xmm8	# tmp275, tmp277
	vaddsd	%xmm8, %xmm10, %xmm8	# tmp277, tmp276, sumIJ
.L17:
# cp.cc:31:             for (int n = nx - extra; n < nx; ++n) {
	cmpl	%edi, %r10d	# nx, _1
	jge	.L10	#,
	movq	-80(%rbp), %rcx	# %sfp, tmp310
	movslq	%r14d, %rsi	# ivtmp.64, _378
	leaq	(%r11,%rsi), %rax	#, tmp279
	leaq	(%r15,%rax,4), %rax	#, ivtmp.41
	leaq	(%rcx,%rsi), %rdx	#, tmp283
	leaq	(%r15,%rdx,4), %rcx	#, _187
# cp.cc:32:                 sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
	movq	-72(%rbp), %rdx	# %sfp, tmp285
	subq	%rsi, %rdx	# _378, tmp285
	.p2align 4
	.p2align 3
.L11:
# cp.cc:32:                 sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
	vcvtss2sd	(%rax,%rdx,4), %xmm2, %xmm0	# MEM[(const float *)_91 + _175 * 4], tmp318, tmp321
# cp.cc:31:             for (int n = nx - extra; n < nx; ++n) {
	addq	$4, %rax	#, ivtmp.41
# cp.cc:32:                 sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
	vcvtss2sd	-4(%rax), %xmm2, %xmm7	# MEM[(const float *)_91], tmp318, tmp322
# cp.cc:32:                 sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
	vmulsd	%xmm7, %xmm0, %xmm0	# tmp287, tmp286, tmp288
# cp.cc:32:                 sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
	vaddsd	%xmm0, %xmm8, %xmm8	# tmp288, sumIJ, sumIJ
# cp.cc:31:             for (int n = nx - extra; n < nx; ++n) {
	cmpq	%rax, %rcx	# ivtmp.41, _187
	jne	.L11	#,
.L10:
# cp.cc:35:             double sumI = row[i];
	vmovsd	(%r8,%r13,8), %xmm0	# MEM[(double *)row.0_102 + ivtmp.58_199 * 8], sumI
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	movq	-64(%rbp), %rax	# %sfp, tmp305
	addq	%r8, %rax	# tmp231, tmp291
# cp.cc:36:             result[i + j * ny] = (sumIJ - sumI * sumJ) 
	vmulsd	%xmm0, %xmm6, %xmm1	# sumI, sumJ, tmp289
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vmulsd	%xmm0, %xmm0, %xmm0	# sumI, sumI, tmp292
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vfmsub231sd	(%rax,%r13,8), %xmm3, %xmm0	# MEM[(double *)_228 + ivtmp.58_199 * 8], _596, _60
# cp.cc:36:             result[i + j * ny] = (sumIJ - sumI * sumJ) 
	vfmsub132sd	%xmm3, %xmm1, %xmm8	# _596, tmp289, _55
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vmulsd	%xmm5, %xmm0, %xmm0	# _603, _60, _66
	vucomisd	%xmm0, %xmm4	# _66, tmp307
	ja	.L27	#,
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vsqrtsd	%xmm0, %xmm0, %xmm0	# _66, _67
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vdivsd	%xmm0, %xmm8, %xmm8	# _67, _55, tmp294
# cp.cc:17:         for (int i = j; i < ny; ++i) {
	addl	%edi, %r14d	# nx, ivtmp.64
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vcvtsd2ss	%xmm8, %xmm8, %xmm8	# tmp294, tmp297
	vmovss	%xmm8, (%r9,%r13,4)	# tmp297, MEM[(float *)_212 + ivtmp.58_199 * 4]
# cp.cc:17:         for (int i = j; i < ny; ++i) {
	incq	%r13	# ivtmp.58
	cmpl	%r13d, -52(%rbp)	# ivtmp.58, %sfp
	jg	.L8	#,
.L15:
# cp.cc:15:     for (int j = 0; j < ny; ++j) {
	incq	-88(%rbp)	# %sfp
	movq	-88(%rbp), %rax	# %sfp, ivtmp.68
	movq	-120(%rbp), %rsi	# %sfp, _280
	movl	-52(%rbp), %ecx	# %sfp, ny
	subq	$8, -96(%rbp)	#, %sfp
	addl	%ecx, -56(%rbp)	# ny, %sfp
	addq	$8, -104(%rbp)	#, %sfp
	addl	%edi, -108(%rbp)	# nx, %sfp
	cmpq	%rsi, %rax	# _280, ivtmp.68
	jne	.L18	#,
	vzeroupper
.L29:
# cp.cc:40: }
	leaq	-48(%rbp), %rsp	#,
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
.L27:
	.cfi_restore_state
	movq	%r8, -192(%rbp)	# tmp231, %sfp
	movq	%r11, -184(%rbp)	# _87, %sfp
	movl	%edi, -172(%rbp)	# nx, %sfp
	movq	%r9, -168(%rbp)	# _212, %sfp
	movl	%r10d, -112(%rbp)	# _1, %sfp
	vmovsd	%xmm3, -160(%rbp)	# _596, %sfp
	vmovsd	%xmm5, -152(%rbp)	# _603, %sfp
	vmovsd	%xmm6, -144(%rbp)	# sumJ, %sfp
	vmovsd	%xmm8, -136(%rbp)	# _55, %sfp
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vzeroupper
	call	sqrt	#
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vmovsd	-136(%rbp), %xmm8	# %sfp, _55
# cp.cc:17:         for (int i = j; i < ny; ++i) {
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp307
	vxorps	%xmm2, %xmm2, %xmm2	# tmp318
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	movq	-168(%rbp), %r9	# %sfp, _212
# cp.cc:17:         for (int i = j; i < ny; ++i) {
	movl	-172(%rbp), %edi	# %sfp, nx
	vmovsd	-144(%rbp), %xmm6	# %sfp, sumJ
	vmovsd	-152(%rbp), %xmm5	# %sfp, _603
	vmovsd	-160(%rbp), %xmm3	# %sfp, _596
	movl	-112(%rbp), %r10d	# %sfp, _1
	movq	-184(%rbp), %r11	# %sfp, _87
	movq	-192(%rbp), %r8	# %sfp, tmp231
	addl	%edi, %r14d	# nx, ivtmp.64
# cp.cc:37:                 / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
	vdivsd	%xmm0, %xmm8, %xmm8	# tmp317, _55, tmp298
	vcvtsd2ss	%xmm8, %xmm8, %xmm8	# tmp298, tmp301
	vmovss	%xmm8, (%r9,%r13,4)	# tmp301, MEM[(float *)_212 + ivtmp.58_199 * 4]
# cp.cc:17:         for (int i = j; i < ny; ++i) {
	incq	%r13	# ivtmp.58
	cmpl	%r13d, -52(%rbp)	# ivtmp.58, %sfp
	jg	.L8	#,
	jmp	.L15	#
	.cfi_endproc
.LFE967:
	.size	_Z9correlateiiPKfPf, .-_Z9correlateiiPKfPf
	.ident	"GCC: (GNU) 12.2.1 20221121 (Red Hat 12.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
