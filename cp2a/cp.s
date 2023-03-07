	.file	"cp.cc"
# GNU C++17 (GCC) version 12.2.1 20221121 (Red Hat 12.2.1-4) (x86_64-redhat-linux)
#	compiled by GNU C version 12.2.1 20221121 (Red Hat 12.2.1-4), GMP version 6.2.1, MPFR version 4.1.0-p13, MPC version 1.2.1, isl version none
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=znver2 -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -msse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512er -mno-avx512pf -mno-avx512vbmi -mno-avx512ifma -mno-avx5124vnniw -mno-avx5124fmaps -mno-avx512vpopcntdq -mno-avx512vbmi2 -mno-gfni -mno-vpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mclzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mno-movdir64b -mno-movdiri -mmwaitx -mno-pconfig -mno-pku -mno-prefetchwt1 -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mno-serialize -mno-sgx -msha -mno-shstk -mno-tbm -mno-tsxldtrk -mno-vaes -mno-waitpkg -mwbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mno-avxvnni -mno-avx512fp16 --param=l1-cache-size=32 --param=l1-cache-line-size=64 --param=l2-cache-size=512 -mtune=znver2 -O3 -std=c++17
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"cannot create std::vector larger than max_size()"
	.text
	.p2align 4
	.globl	_Z9correlateiiPKfPf
	.type	_Z9correlateiiPKfPf, @function
_Z9correlateiiPKfPf:
.LFB1613:
	.cfi_startproc
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	16(%rsp), %r13	#,
	.cfi_def_cfa 13, 0
	andq	$-32, %rsp	#,
	pushq	-8(%r13)	#
	pushq	%rbp	#
	movq	%rsp, %rbp	#,
	.cfi_escape 0x10,0x6,0x2,0x76,0
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	.cfi_escape 0xf,0x3,0x76,0x68,0x6
	.cfi_escape 0x10,0xf,0x2,0x76,0x78
	.cfi_escape 0x10,0xe,0x2,0x76,0x70
	pushq	%r12	#
	pushq	%rbx	#
	subq	$136, %rsp	#,
	.cfi_escape 0x10,0xc,0x2,0x76,0x60
	.cfi_escape 0x10,0x3,0x2,0x76,0x58
# cp.cc:11: void correlate(int ny, int nx, const float *data, float *result) {
	movl	%edi, -52(%rbp)	# ny, %sfp
	movq	%rcx, -64(%rbp)	# tmp361, %sfp
# cp.cc:12:     std::vector<double> input(ny * nx);
	imull	%esi, %edi	# nx, tmp263
	movslq	%edi, %r13	# tmp263,
# /usr/include/c++/12/bits/stl_vector.h:1904: 	if (__n > _S_max_size(_Tp_alloc_type(__a)))
	movq	%r13, %rax	# _2, tmp371
	shrq	$60, %rax	#, tmp371
	jne	.L63	#,
	movl	%esi, %r12d	# tmp359, nx
	movq	%rdx, %r15	# tmp360, data
# /usr/include/c++/12/bits/stl_vector.h:378: 	return __n != 0 ? _Tr::allocate(_M_impl, __n) : pointer();
	testq	%r13, %r13	# _2
	je	.L64	#,
# /usr/include/c++/12/bits/new_allocator.h:137: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	leaq	0(,%r13,8), %r14	#, _116
	vmovaps	%xmm3, -80(%rbp)	# tmp304, %sfp
	movq	%r14, %rdi	# _116,
	call	_Znwm	#
# /usr/include/c++/12/bits/stl_algobase.h:1114:       if (__n <= 0)
	cmpq	$1, %r13	#, _2
	vmovaps	-80(%rbp), %xmm3	# %sfp, tmp304
# /usr/include/c++/12/bits/new_allocator.h:137: 	return static_cast<_Tp*>(_GLIBCXX_OPERATOR_NEW(__n * sizeof(_Tp)));
	movq	%rax, %rbx	# tmp362, input$_M_start
# /usr/include/c++/12/bits/stl_construct.h:119:       ::new((void*)__p) _Tp(std::forward<_Args>(__args)...);
	movq	$0x000000000, (%rax)	#, *_117
# /usr/include/c++/12/bits/stl_algobase.h:1114:       if (__n <= 0)
	je	.L65	#,
# /usr/include/c++/12/bits/stl_uninitialized.h:662: 	      ++__first;
	leaq	8(%rax), %rdi	#, __first
# /usr/include/c++/12/bits/stl_vector.h:397: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	leaq	(%rax,%r14), %rax	#, tmp267
	movq	%r14, %rcx	# _116, prephitmp_109
# /usr/include/c++/12/bits/stl_algobase.h:921:       for (; __first != __last; ++__first)
	cmpq	%rax, %rdi	# tmp267, __first
	je	.L66	#,
# /usr/include/c++/12/bits/stl_algobase.h:922: 	*__first = __tmp;
	xorl	%esi, %esi	#
	leaq	-8(%r14), %rdx	#, tmp268
	vmovaps	%xmm3, -96(%rbp)	# tmp304, %sfp
	movq	%r14, -80(%rbp)	# prephitmp_109, %sfp
	call	memset	#
# cp.cc:16:     for (int row = 0; row < ny; ++row) {
	movl	-52(%rbp), %eax	# %sfp,
	vmovaps	-96(%rbp), %xmm3	# %sfp, tmp304
	movq	-80(%rbp), %rcx	# %sfp, prephitmp_109
	testl	%eax, %eax	#
	jle	.L7	#,
.L4:
	movl	%r12d, %esi	# nx, bnd.74
# /usr/include/c++/12/bits/stl_vector.h:395: 	this->_M_impl._M_start = this->_M_allocate(__n);
	xorl	%r9d, %r9d	# ivtmp.148
	leal	-1(%r12), %r14d	#, _147
# cp.cc:16:     for (int row = 0; row < ny; ++row) {
	xorl	%r13d, %r13d	# row
	shrl	$3, %esi	#,
	movl	%r12d, %r10d	# nx, _363
	movq	%rcx, -80(%rbp)	# prephitmp_109, %sfp
	movl	%r9d, %ecx	# ivtmp.148, ivtmp.148
	salq	$5, %rsi	#, _347
	vxorps	%xmm2, %xmm2, %xmm2	# tmp364
	movl	%r13d, %edi	# row, row
	movl	%r14d, %r9d	# _147, _147
	movq	%rsi, %rax	# _347, _347
	andl	$-8, %r10d	#, _363
	movq	%rbx, %rsi	# input$_M_start, input$_M_start
	movslq	%r12d, %r8	# nx, nx
	movl	%r12d, %r13d	# nx, nx
	movq	%rax, %rbx	# _347, _347
	movl	%ecx, %r14d	# ivtmp.148, ivtmp.148
	vcvtsi2sdl	%r12d, %xmm2, %xmm4	# nx, tmp364, tmp365
	.p2align 4
	.p2align 3
.L18:
# cp.cc:17:         asm("# Normalizing");
#APP
# 17 "cp.cc" 1
	# Normalizing
# 0 "" 2
# cp.cc:21:         for (int col = 0; col < nx; ++col) {
#NO_APP
	testl	%r13d, %r13d	# nx
	jle	.L10	#,
	movslq	%r14d, %r12	# ivtmp.148, _330
# cp.cc:19:         double mean = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# mean
	leaq	(%r15,%r12,4), %r11	#, _328
	leaq	(%r8,%r12), %rdx	#, tmp277
	leaq	(%r15,%rdx,4), %rcx	#, _321
	movq	%r11, %rax	# _328, ivtmp.138
# cp.cc:22:             mean += data[col + nx * row];
	movq	%r11, %rdx	# _328, ivtmp.143
	.p2align 4
	.p2align 3
.L11:
# cp.cc:22:             mean += data[col + nx * row];
	vcvtss2sd	(%rdx), %xmm2, %xmm0	# MEM[(const float *)_327], tmp364, tmp366
# cp.cc:21:         for (int col = 0; col < nx; ++col) {
	addq	$4, %rdx	#, ivtmp.143
# cp.cc:22:             mean += data[col + nx * row];
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp279, mean, mean
# cp.cc:21:         for (int col = 0; col < nx; ++col) {
	cmpq	%rdx, %rcx	# ivtmp.143, _321
	jne	.L11	#,
# cp.cc:24:         mean /= nx;
	vdivsd	%xmm4, %xmm1, %xmm1	# _259, mean, mean
# cp.cc:20:         double rootedSquaredSum = 0;
	vxorpd	%xmm5, %xmm5, %xmm5	# rootedSquaredSum
	.p2align 4
	.p2align 3
.L12:
# cp.cc:26:         for (int col = 0; col < nx; ++col) {
	addq	$4, %rax	#, ivtmp.138
# cp.cc:27:             rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
	vcvtss2sd	-4(%rax), %xmm2, %xmm0	# MEM[(const float *)_340], tmp364, tmp367
# cp.cc:27:             rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
	vsubsd	%xmm1, %xmm0, %xmm0	# mean, tmp280, _18
	vmulsd	%xmm0, %xmm0, %xmm0	# _18, _18, tmp281
# cp.cc:27:             rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
	vaddsd	%xmm0, %xmm5, %xmm5	# tmp281, rootedSquaredSum, rootedSquaredSum
# cp.cc:26:         for (int col = 0; col < nx; ++col) {
	cmpq	%rax, %rcx	# ivtmp.138, _321
	jne	.L12	#,
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp282
	vucomisd	%xmm5, %xmm0	# rootedSquaredSum, tmp282
	ja	.L53	#,
# cp.cc:29:         rootedSquaredSum = sqrt(rootedSquaredSum);
	vsqrtsd	%xmm5, %xmm5, %xmm5	# rootedSquaredSum, rootedSquaredSum
.L15:
	cmpl	$6, %r9d	#, _147
	jbe	.L67	#,
	vbroadcastsd	%xmm1, %ymm7	# mean, vect_cst__97
	vbroadcastsd	%xmm5, %ymm6	# rootedSquaredSum, vect_cst__84
	leaq	(%rsi,%r12,8), %rdx	#, vectp.84
# cp.cc:20:         double rootedSquaredSum = 0;
	xorl	%eax, %eax	# ivtmp.132
	.p2align 4
	.p2align 3
.L20:
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovups	(%r11,%rax), %ymm0	# MEM <const vector(8) float> [(const float *)_328 + ivtmp.132_350 * 1], MEM <const vector(8) float> [(const float *)_328 + ivtmp.132_350 * 1]
	vcvtps2pd	%xmm0, %ymm9	# MEM <const vector(8) float> [(const float *)_328 + ivtmp.132_350 * 1], vect__25.80
	vextractf128	$0x1, %ymm0, %xmm0	# MEM <const vector(8) float> [(const float *)_328 + ivtmp.132_350 * 1], tmp291
	vcvtps2pd	%xmm0, %ymm0	# tmp291, vect__25.80
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vsubpd	%ymm7, %ymm9, %ymm10	# vect_cst__97, vect__25.80, vect__26.81
	vsubpd	%ymm7, %ymm0, %ymm0	# vect_cst__97, vect__25.80, vect__26.81
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vdivpd	%ymm6, %ymm10, %ymm11	# vect_cst__84, vect__26.81, vect__27.82
	vdivpd	%ymm6, %ymm0, %ymm0	# vect_cst__84, vect__26.81, vect__27.82
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovupd	%ymm11, (%rdx,%rax,2)	# vect__27.82, MEM <vector(4) double> [(value_type &)vectp.84_58 + ivtmp.132_350 * 2]
	vmovupd	%ymm0, 32(%rdx,%rax,2)	# vect__27.82, MEM <vector(4) double> [(value_type &)vectp.84_58 + 32 + ivtmp.132_350 * 2]
	addq	$32, %rax	#, ivtmp.132
	cmpq	%rax, %rbx	# ivtmp.132, _347
	jne	.L20	#,
	cmpl	%r13d, %r10d	# nx, _363
	je	.L10	#,
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	movl	%r10d, %eax	# _363,
# cp.cc:31:         for (int col = 0; col < nx; ++col) {
	movl	%r10d, %edx	# _363, tmp.88
.L16:
	movl	%r13d, %ecx	# nx, niters.85
	subl	%eax, %ecx	# _133, niters.85
	leal	-1(%rcx), %r11d	#, tmp294
	cmpl	$2, %r11d	#, tmp294
	jbe	.L23	#,
	addq	%r12, %rax	# _330, _282
	vmovddup	%xmm1, %xmm7	# mean, tmp296
	vmovddup	%xmm5, %xmm6	# rootedSquaredSum, tmp297
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovups	(%r15,%rax,4), %xmm8	# MEM <const vector(4) float> [(const float *)vectp.90_279], MEM <const vector(4) float> [(const float *)vectp.90_279]
	leaq	(%rsi,%rax,8), %r11	#, vectp.96
	movl	%ecx, %eax	# niters.85, niters_vector_mult_vf.87
	andl	$-4, %eax	#, niters_vector_mult_vf.87
	addl	%eax, %edx	# niters_vector_mult_vf.87, tmp.88
	andl	$3, %ecx	#, niters.85
	vcvtps2pd	%xmm8, %xmm0	# MEM <const vector(4) float> [(const float *)vectp.90_279], vect__165.92
	vmovhlps	%xmm8, %xmm3, %xmm3	# MEM <const vector(4) float> [(const float *)vectp.90_279], tmp304, tmp304
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vsubpd	%xmm7, %xmm0, %xmm0	# tmp296, vect__165.92, vect__164.93
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vdivpd	%xmm6, %xmm0, %xmm0	# tmp297, vect__164.93, vect__160.94
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovupd	%xmm0, (%r11)	# vect__160.94, MEM <vector(2) double> [(value_type &)vectp.96_295]
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vcvtps2pd	%xmm3, %xmm0	# tmp304, vect__165.92
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vsubpd	%xmm7, %xmm0, %xmm0	# tmp296, vect__165.92, vect__164.93
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vdivpd	%xmm6, %xmm0, %xmm0	# tmp297, vect__164.93, vect__160.94
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovupd	%xmm0, 16(%r11)	# vect__160.94, MEM <vector(2) double> [(value_type &)vectp.96_295 + 16]
	je	.L10	#,
.L23:
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	leal	(%r14,%rdx), %eax	#, tmp309
	cltq
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vcvtss2sd	(%r15,%rax,4), %xmm2, %xmm0	# *_65, tmp364, tmp368
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vsubsd	%xmm1, %xmm0, %xmm0	# mean, tmp310, tmp311
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vdivsd	%xmm5, %xmm0, %xmm0	# rootedSquaredSum, tmp311, tmp312
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovsd	%xmm0, (%rsi,%rax,8)	# tmp312, *_180
# cp.cc:31:         for (int col = 0; col < nx; ++col) {
	leal	1(%rdx), %eax	#, col
# cp.cc:31:         for (int col = 0; col < nx; ++col) {
	cmpl	%eax, %r13d	# col, nx
	jle	.L10	#,
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	addl	%r14d, %eax	# ivtmp.148, tmp313
# cp.cc:31:         for (int col = 0; col < nx; ++col) {
	addl	$2, %edx	#, col
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	cltq
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vcvtss2sd	(%r15,%rax,4), %xmm2, %xmm0	# *_184, tmp364, tmp369
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vsubsd	%xmm1, %xmm0, %xmm0	# mean, tmp314, tmp315
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vdivsd	%xmm5, %xmm0, %xmm0	# rootedSquaredSum, tmp315, tmp316
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovsd	%xmm0, (%rsi,%rax,8)	# tmp316, *_123
# cp.cc:31:         for (int col = 0; col < nx; ++col) {
	cmpl	%edx, %r13d	# col, nx
	jle	.L10	#,
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	addl	%r14d, %edx	# ivtmp.148, tmp317
	movslq	%edx, %rax	# tmp317, _198
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vcvtss2sd	(%r15,%rax,4), %xmm2, %xmm0	# *_10, tmp364, tmp370
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vsubsd	%xmm1, %xmm0, %xmm0	# mean, tmp318, tmp319
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vdivsd	%xmm5, %xmm0, %xmm0	# rootedSquaredSum, tmp319, tmp320
# cp.cc:32:             input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
	vmovsd	%xmm0, (%rsi,%rax,8)	# tmp320, *_265
.L10:
# cp.cc:16:     for (int row = 0; row < ny; ++row) {
	incl	%edi	# row
# cp.cc:16:     for (int row = 0; row < ny; ++row) {
	addl	%r13d, %r14d	# nx, ivtmp.148
	cmpl	%edi, -52(%rbp)	# row, %sfp
	jne	.L18	#,
	movq	-80(%rbp), %rcx	# %sfp, prephitmp_109
	movl	%r13d, %r12d	# nx, nx
	movslq	%edi, %rax	# row,
	movq	-64(%rbp), %r11	# %sfp, ivtmp.123
	movq	%rsi, %rbx	# input$_M_start, input$_M_start
	movl	%r9d, %r14d	# _147, _147
	movq	%rax, %r13	#,
	leaq	0(,%rax,4), %r9	#, _357
	movq	%rax, -80(%rbp)	# _358, %sfp
	movl	%r12d, %esi	# nx, bnd.62
	movl	%r12d, %eax	# nx, _261
	movl	%r12d, %r15d	# nx, tmp351
	shrl	$2, %esi	#,
	andl	$-4, %eax	#, _261
	xorl	%r10d, %r10d	# ivtmp.124
	xorl	%edx, %edx	# ivtmp.120
	salq	$5, %rsi	#, _379
	movl	%eax, -52(%rbp)	# _261, %sfp
	andl	$3, %r15d	#, tmp351
	movq	%rcx, -104(%rbp)	# prephitmp_109, %sfp
	movq	%r9, -96(%rbp)	# _357, %sfp
	.p2align 4
	.p2align 3
.L30:
	movslq	%r10d, %rax	# ivtmp.124, _30
# cp.cc:31:         for (int col = 0; col < nx; ++col) {
	movl	%r10d, %edi	# ivtmp.124, ivtmp.118
	movq	%rdx, %r8	# ivtmp.120, ivtmp.114
	movq	%rdx, -64(%rbp)	# ivtmp.120, %sfp
	leaq	(%rbx,%rax,8), %rcx	#, vectp.66
	.p2align 4
	.p2align 3
.L29:
# cp.cc:37:             asm("# Matrix Multiplication");
#APP
# 37 "cp.cc" 1
	# Matrix Multiplication
# 0 "" 2
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
#NO_APP
	testl	%r12d, %r12d	# nx
	jle	.L34	#,
	cmpl	$2, %r14d	#, _147
	jbe	.L35	#,
	movslq	%edi, %rax	# ivtmp.118, _34
# cp.cc:39:             double sum = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# sum
	leaq	(%rbx,%rax,8), %rdx	#, vectp.69
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	xorl	%eax, %eax	# ivtmp.106
	.p2align 4
	.p2align 3
.L27:
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	vmovupd	(%rdx,%rax), %ymm4	# MEM <vector(4) double> [(value_type &)vectp.69_213 + ivtmp.106_382 * 1], tmp477
	vmulpd	(%rcx,%rax), %ymm4, %ymm2	# MEM <vector(4) double> [(value_type &)vectp.66_255 + ivtmp.106_382 * 1], tmp477, vect__75.71
	addq	$32, %rax	#, ivtmp.106
	vaddsd	%xmm2, %xmm1, %xmm1	# stmp_sum_76.72, sum, stmp_sum_76.72
	vunpckhpd	%xmm2, %xmm2, %xmm0	# tmp325, stmp_sum_76.72
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_sum_76.72, stmp_sum_76.72, stmp_sum_76.72
	vextractf128	$0x1, %ymm2, %xmm1	# vect__75.71, tmp327
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	vaddsd	%xmm0, %xmm1, %xmm3	# stmp_sum_76.72, stmp_sum_76.72, stmp_sum_76.72
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp327, stmp_sum_76.72
	vaddsd	%xmm1, %xmm3, %xmm1	# stmp_sum_76.72, stmp_sum_76.72, sum
	cmpq	%rax, %rsi	# ivtmp.106, _379
	jne	.L27	#,
	testl	%r15d, %r15d	# tmp351
	je	.L28	#,
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
	movl	-52(%rbp), %eax	# %sfp, col
.L26:
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	leal	(%r10,%rax), %r9d	#, tmp332
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	leal	(%rdi,%rax), %edx	#, tmp334
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	movslq	%r9d, %r9	# tmp332, tmp333
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	movslq	%edx, %rdx	# tmp334, tmp335
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	vmovsd	(%rbx,%r9,8), %xmm6	# *_24, tmp478
	vfmadd231sd	(%rbx,%rdx,8), %xmm6, %xmm1	# *_73, tmp478, sum
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
	leal	1(%rax), %edx	#, col
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
	cmpl	%edx, %r12d	# col, nx
	jle	.L28	#,
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	leal	(%r10,%rdx), %r9d	#, tmp336
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	addl	%edi, %edx	# ivtmp.118, tmp338
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
	addl	$2, %eax	#, col
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	movslq	%r9d, %r9	# tmp336, tmp337
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	movslq	%edx, %rdx	# tmp338, tmp339
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	vmovsd	(%rbx,%r9,8), %xmm7	# *_164, tmp479
	vfmadd231sd	(%rbx,%rdx,8), %xmm7, %xmm1	# *_149, tmp479, sum
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
	cmpl	%r12d, %eax	# nx, col
	jge	.L28	#,
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	leal	(%r10,%rax), %edx	#, tmp340
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	addl	%edi, %eax	# ivtmp.118, tmp342
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	movslq	%edx, %rdx	# tmp340, tmp341
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	cltq
# cp.cc:41:                 sum += input[col + row * nx] * input[col + innerRow * nx];
	vmovsd	(%rbx,%rdx,8), %xmm5	# *_232, tmp480
	vfmadd231sd	(%rbx,%rax,8), %xmm5, %xmm1	# *_243, tmp480, sum
.L28:
# cp.cc:43:             result[innerRow + row * ny] = sum;
	vcvtsd2ss	%xmm1, %xmm1, %xmm1	# sum, _257
.L25:
# cp.cc:43:             result[innerRow + row * ny] = sum;
	vmovss	%xmm1, (%r11,%r8,4)	# _257, MEM[(float *)_367 + ivtmp.114_378 * 4]
# cp.cc:36:         for (int innerRow = row; innerRow < ny; ++innerRow) {
	incq	%r8	# ivtmp.114
	addl	%r12d, %edi	# nx, ivtmp.118
	cmpl	%r8d, %r13d	# ivtmp.114, row
	jg	.L29	#,
# cp.cc:35:     for (int row = 0; row < ny; ++row) {
	movq	-64(%rbp), %rdx	# %sfp, ivtmp.120
	movq	-96(%rbp), %rax	# %sfp, _357
	addl	%r12d, %r10d	# nx, ivtmp.124
	incq	%rdx	# ivtmp.120
	addq	%rax, %r11	# _357, ivtmp.123
	cmpq	%rdx, -80(%rbp)	# ivtmp.120, %sfp
	jne	.L30	#,
	movq	-104(%rbp), %rcx	# %sfp, prephitmp_109
# /usr/include/c++/12/bits/stl_vector.h:386: 	if (__p)
	testq	%rbx, %rbx	# input$_M_start
	je	.L59	#,
	vzeroupper
.L7:
# cp.cc:46: }
	addq	$136, %rsp	#,
# /usr/include/c++/12/bits/new_allocator.h:158: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	movq	%rbx, %rdi	# input$_M_start,
	movq	%rcx, %rsi	# prephitmp_109,
# cp.cc:46: }
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-16(%r13), %rsp	#,
	.cfi_def_cfa 7, 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
# /usr/include/c++/12/bits/new_allocator.h:158: 	_GLIBCXX_OPERATOR_DELETE(_GLIBCXX_SIZED_DEALLOC(__p, __n));
	jmp	_ZdlPvm	#
	.p2align 4
	.p2align 3
.L34:
	.cfi_restore_state
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
	vxorps	%xmm1, %xmm1, %xmm1	# _257
	jmp	.L25	#
.L35:
# cp.cc:40:             for (int col = 0; col < nx; ++col) {
	xorl	%eax, %eax	# col
# cp.cc:39:             double sum = 0;
	vxorpd	%xmm1, %xmm1, %xmm1	# sum
	jmp	.L26	#
.L67:
# cp.cc:31:         for (int col = 0; col < nx; ++col) {
	xorl	%eax, %eax	#
	xorl	%edx, %edx	# tmp.88
	jmp	.L16	#
.L59:
	vzeroupper
.L60:
# cp.cc:46: }
	addq	$136, %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	.cfi_remember_state
	.cfi_def_cfa 13, 0
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	leaq	-16(%r13), %rsp	#,
	.cfi_def_cfa 7, 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
	ret	
.L64:
	.cfi_restore_state
# cp.cc:16:     for (int row = 0; row < ny; ++row) {
	movl	-52(%rbp), %edi	# %sfp,
	xorl	%ecx, %ecx	# prephitmp_109
# /usr/include/c++/12/bits/stl_vector.h:395: 	this->_M_impl._M_start = this->_M_allocate(__n);
	xorl	%ebx, %ebx	# input$_M_start
# cp.cc:16:     for (int row = 0; row < ny; ++row) {
	testl	%edi, %edi	#
	jg	.L4	#,
	jmp	.L60	#
.L65:
	movl	-52(%rbp), %esi	# %sfp,
	movq	%r14, %rcx	# _116, prephitmp_109
	testl	%esi, %esi	#
	jg	.L4	#,
	jmp	.L7	#
.L66:
	movl	-52(%rbp), %edx	# %sfp,
	testl	%edx, %edx	#
	jg	.L4	#,
	jmp	.L7	#
.L63:
# /usr/include/c++/12/bits/stl_vector.h:1905: 	  __throw_length_error(
	movl	$.LC2, %edi	#,
	call	_ZSt20__throw_length_errorPKc	#
.L53:
	movq	%r8, -152(%rbp)	# nx, %sfp
	movl	%r10d, -144(%rbp)	# _363, %sfp
	movl	%r9d, -140(%rbp)	# _147, %sfp
# cp.cc:29:         rootedSquaredSum = sqrt(rootedSquaredSum);
	vmovsd	%xmm5, %xmm5, %xmm0	# rootedSquaredSum,
	movl	%edi, -56(%rbp)	# row, %sfp
	movq	%rsi, -136(%rbp)	# input$_M_start, %sfp
	vmovsd	%xmm4, -112(%rbp)	# _259, %sfp
	vmovaps	%xmm3, -128(%rbp)	# tmp304, %sfp
	movq	%r11, -104(%rbp)	# _328, %sfp
	vmovsd	%xmm1, -96(%rbp)	# mean, %sfp
	vzeroupper
	call	sqrt	#
	vmovsd	-112(%rbp), %xmm4	# %sfp, _259
	vxorps	%xmm2, %xmm2, %xmm2	# tmp364
	vmovaps	-128(%rbp), %xmm3	# %sfp, tmp304
	vmovsd	-96(%rbp), %xmm1	# %sfp, mean
	vmovsd	%xmm0, %xmm0, %xmm5	# tmp363, rootedSquaredSum
	movq	-152(%rbp), %r8	# %sfp, nx
	movl	-144(%rbp), %r10d	# %sfp, _363
	movl	-140(%rbp), %r9d	# %sfp, _147
	movl	-56(%rbp), %edi	# %sfp, row
	movq	-136(%rbp), %rsi	# %sfp, input$_M_start
	movq	-104(%rbp), %r11	# %sfp, _328
	jmp	.L15	#
	.cfi_endproc
.LFE1613:
	.size	_Z9correlateiiPKfPf, .-_Z9correlateiiPKfPf
	.ident	"GCC: (GNU) 12.2.1 20221121 (Red Hat 12.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
