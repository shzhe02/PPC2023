#include <cmath>
#include <new>
#include <immintrin.h>
#include <iostream>
typedef double double4_t __attribute__ ((vector_size (4 * sizeof(double))));
static double4_t* double4_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(double4_t), sizeof(double4_t) * n)) {
        throw std::bad_alloc();
    }
    return (double4_t*)tmp;
}
static inline double4_t swap(double4_t x) { return _mm256_permute_pd(x, 0b0101); }
static inline double4_t swap2(double4_t x) { return _mm256_permute2f128_pd(x, x, 0b0001); }
void correlate(int ny, int nx, const float *data, float *result) {
    constexpr int doublesPerVector = 4;
    constexpr double4_t d4zero{0,0,0,0};
    const int vectorsPerCol = (ny + doublesPerVector - 1) / doublesPerVector;
    double4_t* input = double4_alloc(nx * vectorsPerCol);
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
        double4_t means = d4zero;
        double4_t rsSums = d4zero;
        for (int col = 0; col < nx; ++col) { // Calculating means
            means += input[col + vec * nx];
        }
        for (int i = 0; i < doublesPerVector; ++i) {
            means[i] /= nx;
        } // Means calculated
        for (int col = 0; col < nx; ++col) { // Calculating rooted squared sums
            rsSums += (input[col + vec * nx] - means) * (input[col + vec * nx] - means);
        }
        for (int i = 0; i < doublesPerVector; ++i) {
            rsSums[i] = sqrt(rsSums[i]);
        } // rsSum calculated
        for (int col = 0; col < nx; ++col) { // Normalization step
            input[col + vec * nx] = (input[col + vec * nx] - means) / rsSums;
        } // Normalized
    }
    #pragma omp parallel for schedule(static,1)
    for (int outer = 0; outer < vectorsPerCol; ++outer) {
        double4_t n[4];
        for (int inner = outer; inner < vectorsPerCol; ++inner) {
            n[0] = d4zero;
            n[1] = d4zero;
            n[2] = d4zero;
            n[3] = d4zero;
            for (int col = 0; col < nx; ++col) {
                double4_t out = input[col + outer * nx];
                double4_t outS = swap(out);
                double4_t in = input[col + inner * nx];
                double4_t inS = swap2(in);
                n[0] += out * in;
                n[1] += outS * in;
                n[2] += out * inS;
                n[3] += outS * inS;
            }
            n[2] = swap2(n[2]);
            n[3] = swap2(n[3]);
            for (int i = 0; i < doublesPerVector; ++i) {
                for (int j = 0; j < doublesPerVector; ++j) {
                    int row = outer * doublesPerVector + i;
                    int col = inner * doublesPerVector + j;
                    if (row < ny && col < ny) {
                        result[col + row * ny] = n[i^j][j];
                    }
                }
            }
        }
    }
    free(input);
}