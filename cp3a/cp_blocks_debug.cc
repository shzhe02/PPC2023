#include <cmath>
#include <new>
#include <chrono>
#include <iostream>

typedef double double4_t __attribute__ ((vector_size (4 * sizeof(double))));

static double4_t* double4_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(double4_t), sizeof(double4_t) * n)) {
        throw std::bad_alloc();
    }
    return (double4_t*)tmp;
}

void correlate(int ny, int nx, const float *data, float *result) {
    auto start = std::chrono::high_resolution_clock::now();
    constexpr int doublesPerVector = 4;
    constexpr int blockSize = 8;
    constexpr double4_t d4zero{0,0,0,0};
    const int vectorsPerRow = (nx + doublesPerVector - 1) / doublesPerVector;
    const int blocksPerCol = (ny + blockSize - 1) / blockSize;
    const int totalRows = blocksPerCol * blockSize;
    double4_t* input = double4_alloc(vectorsPerRow * totalRows);
    #pragma omp parallel for
    for (int row = 0; row < ny; ++row) { // Getting the normalized input matrix
        double mean = 0;
        double rootedSquaredSum = 0;
        for (int col = 0; col < nx; ++col) {
            mean += data[col + nx * row];
        }
        mean /= nx;
        for (int col = 0; col < nx; ++col) { // Get squared sum of the row
            rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
        }
        rootedSquaredSum = sqrt(rootedSquaredSum);
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                int elem = doublesPerVector * vec + doub;
                input[vectorsPerRow * row + vec][doub] = elem < nx ? (data[elem + nx * row] - mean) / rootedSquaredSum : 0;
            }
        }
    }
    for (int row = ny; row < totalRows; ++row) {
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                input[vectorsPerRow * row + vec][doub] = 0;
            }
        }
    }
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::cout << "Normalized and padded - " << duration.count() << " microseconds" << std::endl;
    #pragma omp parallel for schedule(static,1)
    for (int outerBlock = 0; outerBlock < blocksPerCol; ++outerBlock) {
        for (int innerBlock = outerBlock; innerBlock < blocksPerCol; ++innerBlock) {
            double4_t sums[blockSize][blockSize];
            for (int i = 0; i < blockSize; ++i) {
                for (int j = 0; j < blockSize; ++j) {
                    sums[i][j] = d4zero;
                }
            }
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                double4_t outers[blockSize];
                double4_t inners[blockSize];
                for (int i = 0; i < blockSize; ++i) {
                    outers[i] = input[vec + vectorsPerRow * (i + outerBlock * blockSize)];
                    inners[i] = input[vec + vectorsPerRow * (i + innerBlock * blockSize)];
                }
                for (int i = 0; i < blockSize; ++i) {
                    for (int j = 0; j < blockSize; ++j) {
                        sums[i][j] += outers[i] * inners[j];
                    }
                }
            }
            for (int i = 0; i < blockSize; ++i) {
                for (int j = 0; j < blockSize; ++j) {
                    int row = outerBlock * blockSize + i;
                    int col = innerBlock * blockSize + j;
                    if (row < ny && col < ny && row <= col) {
                        double4_t res = sums[i][j];
                        result[col + row * ny] = res[0] + res[1] + res[2] + res[3];
                    }
                }
            }
        }
    }
    free(input);
}