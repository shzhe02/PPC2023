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
    #pragma omp parallel for
    for (int vec = 0; vec < vectorsPerCol; ++vec) { // Packing data into input, vectorized and padded.
        for (int doub = 0; doub < doublesPerVector; ++doub) {
            for (int col = 0; col < nx; ++col) {
                int row = doub + doublesPerVector * vec;
                input[col + vec * nx][doub] = row < ny ? data[col + row * nx] : 0;
            }
        }
    }
    #pragma omp parallel for
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
    for (int vec = vectorsPerCol; vec < blockSize * blocksPerCol; ++vec) {
        for (int col = 0; col < nx; ++col) {
            input[col + vec * nx] = d4zero;
        }
    }
    // for (int i = 0; i < 4; ++i) {
    //     for (int j = 0; j < 4; ++j) {
    //         std::cout << (i ^ j) + 12 << " ";
    //     }
    //     std::cout << std::endl;
    // }
    #pragma omp parallel for schedule(static,1)
    for (int outer = 0; outer < blocksPerCol; ++outer) {
        double4_t n[blockSize * blockSize * doublesPerVector];
        for (int inner = outer; inner < blocksPerCol; ++inner) {
            for (int i = 0; i < 16; ++i) {
                n[i] = d4zero;
            }
            for (int col = 0; col < nx; ++col) {
                double4_t out = input[col + outer * blockSize * nx];
                double4_t outS = swap(out);
                double4_t out2 = input[col + (outer * blockSize + 1) * nx];
                double4_t out2S = swap(out2);
                double4_t in = input[col + inner * blockSize * nx];
                double4_t inS = swap2(in);
                double4_t in2 = input[col + (inner * blockSize + 1) * nx];
                double4_t in2S = swap2(in2);
                n[0] += out * in; // Q1
                n[1] += outS * in;
                n[2] += out * inS;
                n[3] += outS * inS;
                n[4] += out * in2; // Q2
                n[5] += outS * in2;
                n[6] += out * in2S;
                n[7] += outS * in2S;
                n[8] += out2 * in; // Q3
                n[9] += out2S * in;
                n[10] += out2 * inS;
                n[11] += out2S * inS;
                n[12] += out2 * in2; // Q4
                n[13] += out2S * in2;
                n[14] += out2 * in2S;
                n[15] += out2S * in2S;
            }
            n[2] = swap2(n[2]);
            n[3] = swap2(n[3]);
            n[6] = swap2(n[6]);
            n[7] = swap2(n[7]);
            n[10] = swap2(n[10]);
            n[11] = swap2(n[11]);
            n[14] = swap2(n[14]);
            n[15] = swap2(n[15]);
            // for (int i = 0; i < doublesPerVector; ++i) {
            //     for (int j = 0; j < doublesPerVector; ++j) {
            //         int row = outer * blockSize * doublesPerVector + i;
            //         int col = inner * blockSize * doublesPerVector + j;
            //         if (row < ny && col < ny) {
            //             result[col + row * ny] = n[i^j][j];
            //         }
            //     }
            // }
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