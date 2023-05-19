#include <cmath>
#include <new>
#include <immintrin.h>
typedef double double8_t __attribute__ ((vector_size (8 * sizeof(double))));
static double8_t* double8_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(double8_t), sizeof(double8_t) * n)) {
        throw std::bad_alloc();
    }
    return (double8_t*)tmp;
}
__m512i idx = _mm512_set_epi32(0, 3, 0, 2, 0, 1, 0, 0, 0, 7, 0, 6, 0, 5, 0, 4);
static inline double8_t swap4(double8_t x) { return _mm512_permutex2var_pd(x, idx, x); }
#if defined(__clang__)
    static inline double8_t swap2(double8_t x) { return _mm512_permutex_pd(x, 0b01001110); }
    static inline double8_t swap1(double8_t x) { return _mm512_permute_pd(x, 0b01010101); }
#elif defined(___GNUC__) || defined(__GNUG__)
    // Hacky workaround due to GCC bug. Code below essentially does the same thing as the intrinsics in the function definitions above,
    // but with "_mm512_undefined_pd" removed from the intrinsics' definitions.
    static inline double8_t swap2(double8_t x) { return ((__m512d) __builtin_ia32_permdf512_mask ((__v8df)(__m512d)(x), (int)(0b01001110),	\
					    (__v8df)(__m512d) {},\
					    (__mmask8)-1)); }
    static inline double8_t swap1(double8_t x) { return ((__m512d) __builtin_ia32_vpermilpd512_mask ((__v8df)(__m512d)(x), (int)(0b01010101),	    \
					      (__v8df)(__m512d) {},\
					      (__mmask8)(-1))); }
#endif
void correlate(int ny, int nx, const float *data, float *result) {
    //constexpr int PF = 2;
    constexpr int doublesPerVector = 8;
    constexpr double8_t d8zero{0};
    const int vectorsPerCol = (ny + doublesPerVector - 1) / doublesPerVector;
    double8_t* input = double8_alloc(nx * vectorsPerCol);
    #pragma omp parallel for schedule(static,1)
    for (int vec = 0; vec < vectorsPerCol; ++vec) { // Packing data into input, vectorized and padded.
        for (int doub = 0; doub < doublesPerVector; ++doub) {
            for (int col = 0; col < nx; ++col) {
                int row = doub + doublesPerVector * vec;
                input[col + vec * nx][doub] = row < ny ? data[col + row * nx] : 0;
            }
        }
    }
    #pragma omp parallel for schedule(static,1)
    for (int vec = 0; vec < vectorsPerCol; ++vec) { // Normalization
        double8_t means = d8zero;
        double8_t rsSums = d8zero;
        for (int col = 0; col < nx; ++col) { // Calculating means
            means += input[col + vec * nx];
        }
        for (int i = 0; i < doublesPerVector; ++i) {
            means[i] /= nx;
        } // Means calculated
        for (int col = 0; col < nx; ++col) { // Calculating rooted squared sums
            double8_t diff = input[col + vec * nx] - means;
            rsSums += diff * diff;
            input[col + vec * nx] = diff;
        }
        for (int i = 0; i < doublesPerVector; ++i) {
            rsSums[i] = sqrt(rsSums[i]);
        } // rsSum calculated
        for (int col = 0; col < nx; ++col) { // Normalization step
            input[col + vec * nx] /= rsSums;
        } // Normalized
    } // Preparations complete
    #pragma omp parallel for schedule(dynamic)
    for (int outer = 0; outer < vectorsPerCol; ++outer) {
        double8_t vv[40];
        double8_t a000, a100, a010, a110, b000, c000, d000, e000, f000;
        for (int inner = outer; inner < vectorsPerCol; inner += 5) {
            for (int i = 0; i < 40; ++i) {
                vv[i] = d8zero;
            }
            int skip = 0;
            if (inner + 5 > vectorsPerCol) {
                skip = inner - vectorsPerCol + 5;
            }
            for (int col = 0; col < nx; ++col) {
                a000 = input[nx*outer + col];
                a100 = swap4(a000);
                a110 = swap2(a100);
                a010 = swap2(a000);
                b000 = input[nx*inner + col];
                vv[0] += a000 * b000;
                vv[2] += a010 * b000;
                vv[4] += a100 * b000;
                vv[6] += a110 * b000;
                b000 = swap1(b000);
                vv[1] += a000 * b000;
                vv[3] += a010 * b000;
                vv[5] += a100 * b000;
                vv[7] += a110 * b000;
                switch (skip) {
                    case 0:
                        f000 = input[nx*(inner + 4) + col];
                        vv[32] += a000 * f000;
                        vv[34] += a010 * f000;
                        vv[36] += a100 * f000;
                        vv[38] += a110 * f000;
                        f000 = swap1(f000);
                        vv[33] += a000 * f000;
                        vv[35] += a010 * f000;
                        vv[37] += a100 * f000;
                        vv[39] += a110 * f000;
                        [[fallthrough]];
                    case 1:
                        e000 = input[nx*(inner + 3) + col];
                        vv[24] += a000 * e000;
                        vv[26] += a010 * e000;
                        vv[28] += a100 * e000;
                        vv[30] += a110 * e000;
                        e000 = swap1(e000);
                        vv[25] += a000 * e000;
                        vv[27] += a010 * e000;
                        vv[29] += a100 * e000;
                        vv[31] += a110 * e000;
                        [[fallthrough]];
                    case 2:
                        d000 = input[nx*(inner + 2) + col];
                        vv[16] += a000 * d000;
                        vv[18] += a010 * d000;
                        vv[20] += a100 * d000;
                        vv[22] += a110 * d000;
                        d000 = swap1(d000);
                        vv[17] += a000 * d000;
                        vv[19] += a010 * d000;
                        vv[21] += a100 * d000;
                        vv[23] += a110 * d000;
                        [[fallthrough]];
                    case 3:
                        c000 = input[nx*(inner + 1) + col];
                        vv[8] += a000 * c000;
                        vv[10] += a010 * c000;
                        vv[12] += a100 * c000;
                        vv[14] += a110 * c000;
                        c000 = swap1(c000);
                        vv[9] += a000 * c000;
                        vv[11] += a010 * c000;
                        vv[13] += a100 * c000;
                        vv[15] += a110 * c000;
                        [[fallthrough]];
                    case 4:
                        break;
                }
            }
            for (int i = 1; i < 40; i += 2) {
                vv[i] = swap1(vv[i]);
            }
            for (int jb = 0; jb < 8; ++jb) { 
                int j = jb + inner*8;
                int j2 = jb + (inner + 1) * 8;
                int j3 = jb + (inner + 2) * 8;
                int j4 = jb + (inner + 3) * 8;
                int j5 = jb + (inner + 4) * 8;
                for (int ib = 0; ib < 8; ++ib) {
                    int i = ib + outer*8;
                    if (i < ny && j < ny) {
                        result[ny*i + j] = vv[ib^jb][jb];
                    }
                    if (i < ny && j2 < ny) {
                        result[ny*i + j2] = vv[(ib^jb) + 8][jb];
                    }
                    if (i < ny && j3 < ny) {
                        result[ny*i + j3] = vv[(ib^jb) + 16][jb];
                    }
                    if (i < ny && j4 < ny) {
                        result[ny*i + j4] = vv[(ib^jb) + 24][jb];
                    }
                    if (i < ny && j5 < ny) {
                        result[ny*i + j5] = vv[(ib^jb) + 32][jb];
                    }
                }
            }
        }
    }
    free(input);
}   