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
    constexpr int windowHeight = 11;
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
        double8_t vv[8 * windowHeight];
        double8_t b[1 + windowHeight];
        double8_t a000, a100, a010, a110;
        for (int inner = outer; inner < vectorsPerCol; inner += windowHeight) {
            for (int i = 0; i < 8 * windowHeight; ++i) {
                vv[i] = d8zero;
            }
            int actualWindow = windowHeight;
            if (inner + windowHeight > vectorsPerCol) {
                actualWindow = vectorsPerCol - inner;
            }
            for (int col = 0; col < nx; ++col) {
                a000 = input[nx*outer + col];
                a100 = swap4(a000);
                a010 = swap2(a000);
                a110 = swap2(a100);
                for (int k = 0; k < actualWindow; ++k) {
                    b[k] = d8zero; //input[nx*(inner + k) + col]; NOTE: Remember to undo this
                    vv[0 + 8 * k] += a000 * b[k];
                    vv[2 + 8 * k] += a010 * b[k];
                    vv[4 + 8 * k] += a100 * b[k];
                    vv[6 + 8 * k] += a110 * b[k];
                    b[k] = swap1(b[k]);
                    vv[1 + 8 * k] += a000 * b[k];
                    vv[3 + 8 * k] += a010 * b[k];
                    vv[5 + 8 * k] += a100 * b[k];
                    vv[7 + 8 * k] += a110 * b[k];
                }
            }
            for (int i = 1; i < 8 * windowHeight; i += 2) {
                vv[i] = swap1(vv[i]);
            }
            for (int ib = 0; ib < 8; ++ib) {
                int i = ib + outer * 8;
                for (int jb = 0; jb < 8 && i < ny; ++jb) {
                    for (int k = 0; k < actualWindow; ++k) {
                        int j = jb + (inner + k) * 8;
                        if (j < ny) {
                            result[ny * i + j] = vv[(ib ^ jb) + 8 * k][jb];
                        }
                    }
                }
            }
        }
    }
    free(input);
}