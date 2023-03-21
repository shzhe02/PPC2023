#include <cmath>
#include <new>
#include <algorithm>

typedef double double4_t __attribute__ ((vector_size (4 * sizeof(double))));

static double4_t* double4_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(double4_t), sizeof(double4_t) * n)) {
        throw std::bad_alloc();
    }
    return (double4_t*)tmp;
}

void correlate(int ny, int nx, const float *data, float *result) {
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
            double norm = data[col + nx * row] - mean;
            rootedSquaredSum += norm * norm;
        }
        rootedSquaredSum = sqrt(rootedSquaredSum);
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                int elem = doublesPerVector * vec + doub;
                input[vectorsPerRow * row + vec][doub] = elem < nx ? (data[elem + nx * row] - mean) / rootedSquaredSum : 0;
            }
        }
    }
    #pragma omp parallel for
    for (int row = ny; row < totalRows; ++row) {
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                input[vectorsPerRow * row + vec][doub] = 0;
            }
        }
    }

    #pragma omp parallel for schedule(static,1)
    for (int outerBlock = 0; outerBlock < blocksPerCol; ++outerBlock) {
        double4_t sums[blockSize * blockSize];
        for (int i = 0; i < blockSize; ++i) { // Reset sums
            for (int j = 0; j < blockSize; ++j) {
                sums[j + i * blockSize] = d4zero;
            }
        }
        double4_t outers[blockSize];
        double4_t inners[blockSize];
        double4_t res;
        for (int innerBlock = outerBlock; innerBlock < blocksPerCol; ++innerBlock) { // For each block
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                for (int i = 0; i < blockSize; ++i) { // Retrieve the vectors from the inner and outer sections
                    outers[i] = input[vec + vectorsPerRow * (i + outerBlock * blockSize)];
                    inners[i] = input[vec + vectorsPerRow * (i + innerBlock * blockSize)];
                }
                for (int i = 0; i < blockSize; ++i) { // Multiply
                    for (int j = 0; j < blockSize; ++j) {
                        sums[j + i * blockSize] += outers[i] * inners[j];
                    }
                }
            }
            for (int i = 0; i < blockSize; ++i) { // Sum up the sums and put into result
                for (int j = 0; j < blockSize; ++j) {
                    int row = outerBlock * blockSize + i;
                    int col = innerBlock * blockSize + j;
                    if (row < ny && col < ny) {
                        res = sums[j + i * blockSize];
                        result[col + row * ny] = res[0] + res[1] + res[2] + res[3];
                        sums[j + i * blockSize] = d4zero;
                    }
                    
                }
            }
        }
    }
    free(input);
}