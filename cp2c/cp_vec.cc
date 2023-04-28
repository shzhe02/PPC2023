#include <cmath>
#include <new>
#include <vector>
#include <immintrin.h>
typedef double double4_t __attribute__ ((vector_size (4 * sizeof(double))));
static double4_t* double4_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(double4_t), sizeof(double4_t) * n)) {
        throw std::bad_alloc();
    }
    return (double4_t*)tmp;
}
static inline double4_t sqrt4_t(double4_t x) { return _mm256_sqrt_pd(x); }
void correlate(int ny, int nx, const float *data, float *result) {
    std::vector<double> row(2*ny);
    constexpr int doublesPerVector = 4;
    constexpr double4_t zero{0,0,0,0};
    const int vectorsPerRow = (nx + doublesPerVector - 1) / doublesPerVector;
    double4_t* in = double4_alloc(vectorsPerRow * ny);
    double4_t* sums = double4_alloc(2);
    for (int j = 0; j < ny; ++j) {
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                int elem = vec * doublesPerVector + doub;
                in[vectorsPerRow * j + vec][doub] = elem < nx ? data[elem + j * nx] : 0.0;
            }
        }
    }
    for (int r = 0; r < ny; ++r) {
        sums[0] = zero;
        sums[1] = zero;
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            double4_t point = in[r * vectorsPerRow + vec];
            sums[0] += point;
            sums[1] += point * point;
        }
        row[2*r] = 0;
        row[2*r + 1] = 0;
        for (int doub = 0; doub < doublesPerVector; ++doub) {
            row[2*r] += sums[0][doub];
            row[2*r + 1] += sums[1][doub];
        }
    }
    for (int j = 0; j < ny; ++j) {
        double sumJ = row[2*j];
        result[j + j * ny] = 1;
        for (int i = j + 1; i < ny; ++i) {
            double sumIJ = 0;
            double4_t sumsIJ = zero;
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                sumsIJ += in[vectorsPerRow * i + vec] * in[vectorsPerRow * j + vec];
            }
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                sumIJ += sumsIJ[doub];
            }
            result[i + j * ny] = (sumIJ * nx - row[2*i] * sumJ) 
                / sqrt4_t((row[2*i + 1] * nx - row[2*i] * row[2*i]) * (row[2*j + 1] * nx - sumJ * sumJ));
        }
    }
    free(sums);
    free(in);
}