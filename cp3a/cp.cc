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
static inline double8_t fma(double8_t a, double8_t b, double8_t c) { return _mm512_fmadd_pd(a, b, c);}
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
    #pragma omp parallel for schedule(static,1)
    for (int outer = 0; outer < vectorsPerCol; ++outer) {
        double8_t vv[24];
        double8_t a000, a100, a010, a110, b000, b001, c000, c001, d000, d001;
        for (int inner = outer; inner < vectorsPerCol; inner += 3) {
            for (int i = 0; i < 24; ++i) {
                vv[i] = d8zero;
            }
            for (int col = 0; col < nx; ++col) {
                a000 = input[nx*outer + col];
                a100 = swap4(a000);
                a110 = swap2(a100);
                a010 = swap2(a000);
                b000 = input[nx*inner + col];
                b001 = swap1(b000);
                vv[0] = fma(a000, b000, vv[0]); // Half FMA seems to improve times slightly (?)
                vv[1] = fma(a000, b001, vv[1]);
                vv[2] = fma(a010, b000, vv[2]);
                vv[3] = fma(a010, b001, vv[3]);
                vv[4] += a100 * b000;
                vv[5] += a100 * b001;
                vv[6] += a110 * b000;
                vv[7] += a110 * b001;
                if (inner + 1 < vectorsPerCol) {
                    c000 = input[nx*(inner + 1) + col];
                    c001 = swap1(c000);
                    vv[8] = fma(a000, c000, vv[8]);
                    vv[9] = fma(a000, c001, vv[9]);
                    vv[10] = fma(a010, c000, vv[10]);
                    vv[11] = fma(a010, c001, vv[11]);
                    vv[12] += a100 * c000;
                    vv[13] += a100 * c001;
                    vv[14] += a110 * c000;
                    vv[15] += a110 * c001;
                }
                if (inner + 2 < vectorsPerCol) {
                    d000 = input[nx*(inner + 2) + col];
                    d001 = swap1(d000);
                    vv[16] = fma(a000, d000, vv[16]);
                    vv[17] = fma(a000, d001, vv[17]);
                    vv[18] = fma(a010, d000, vv[18]);
                    vv[19] = fma(a010, d001, vv[19]);
                    vv[20] += a100 * d000;
                    vv[21] += a100 * d001;
                    vv[22] += a110 * d000;
                    vv[23] += a110 * d001;
                }
            }
            for (int i = 1; i < 24; i += 2) {
                vv[i] = swap1(vv[i]);
            }
            for (int jb = 0; jb < 8; ++jb) { 
                int j = jb + inner*8;
                int j2 = jb + (inner + 1) * 8;
                int j3 = jb + (inner + 2) * 8;
                for (int ib = 0; ib < 8; ++ib) {
                    int i = ib + outer*8;
                    if (j < ny && i < ny) {
                        result[ny*i + j] = vv[ib^jb][jb];
                    }
                    if (j2 < ny && i < ny) {
                        result[ny*i + j2] = vv[(ib^jb) + 8][jb];
                    }
                    if (j3 < ny && i < ny) {
                        result[ny*i + j3] = vv[(ib^jb) + 16][jb];
                    }
                }
            }
        }
    }
    free(input);
}   