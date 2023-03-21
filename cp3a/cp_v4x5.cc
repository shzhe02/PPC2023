#include <cmath>
#include <new>
#include <x86intrin.h>
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
    constexpr int blockSize = 2;
    const int doublesPerBlock = blockSize * doublesPerVector;
    constexpr double4_t d4zero{0,0,0,0};
    const int vectorsPerCol = (ny + doublesPerVector - 1) / doublesPerVector;
    const int blocksPerCol = (ny + doublesPerBlock - 1) / doublesPerBlock;
    double4_t* input = double4_alloc(nx * blocksPerCol * blockSize);
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
    for (int vec = vectorsPerCol; vec < blockSize * blocksPerCol; ++vec) {
        for (int col = 0; col < nx; ++col) {
            input[col + vec * nx] = d4zero;
        }
    }
    #pragma omp parallel for schedule(static,1)
    for (int outer = 0; outer < blocksPerCol; ++outer) {
        double4_t n[blockSize * blockSize * doublesPerVector];
        double4_t in[blockSize];
        double4_t out[blockSize];
        double4_t inS[blockSize];
        double4_t outS[blockSize];
        for (int inner = outer; inner < blocksPerCol; ++inner) {
            for (int i = 0; i < 16; ++i) {
                n[i] = d4zero;
            }
            for (int col = 0; col < nx; ++col) {
                out[0] = input[col + outer * blockSize * nx];
                outS[0] = swap(out[0]);
                out[1] = input[col + (outer * blockSize + 1) * nx];
                outS[1] = swap(out[1]);
                in[0] = input[col + inner * blockSize * nx];
                inS[0] = swap2(in[0]);
                in[1] = input[col + (inner * blockSize + 1) * nx];
                inS[1] = swap2(in[1]);
                n[0] += out[0] * in[0]; // Q1
                n[1] += outS[0] * in[0];
                n[2] += out[0] * inS[0];
                n[3] += outS[0] * inS[0];
                n[4] += out[0] * in[1]; // Q2
                n[5] += outS[0] * in[1];
                n[6] += out[0] * inS[1];
                n[7] += outS[0] * inS[1];
                n[8] += out[1] * in[0]; // Q3
                n[9] += outS[1] * in[0];
                n[10] += out[1] * inS[0];
                n[11] += outS[1] * inS[0];
                n[12] += out[1] * in[1]; // Q4
                n[13] += outS[1] * in[1];
                n[14] += out[1] * inS[1];
                n[15] += outS[1] * inS[1];
            }
            n[2] = swap2(n[2]);
            n[3] = swap2(n[3]);
            n[6] = swap2(n[6]);
            n[7] = swap2(n[7]);
            n[10] = swap2(n[10]);
            n[11] = swap2(n[11]);
            n[14] = swap2(n[14]);
            n[15] = swap2(n[15]);
            for (int blockRow = 0; blockRow < blockSize; ++blockRow) {
                for (int blockCol = 0; blockCol < blockSize; ++blockCol) {
                    for (int i = 0; i < doublesPerVector; ++i) {
                        for (int j = 0; j < doublesPerVector; ++j) {
                            int row = (outer * blockSize + blockRow) * doublesPerVector + i;
                            int col = (inner * blockSize + blockCol) * doublesPerVector + j;
                            if (row < ny && col < ny) {
                                result[col + row * ny] = n[(i^j) + (4 * blockCol) + (8 * blockRow)][j];
                            }
                        }
                    }
                }
            }
        }
    }
    free(input);
}