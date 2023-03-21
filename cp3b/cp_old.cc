#include <cmath>
#include <new>

typedef float float8_t __attribute__ ((vector_size (8 * sizeof(float))));

static float8_t* double4_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(float8_t), sizeof(float8_t) * n)) {
        throw std::bad_alloc();
    }
    return (float8_t*)tmp;
}

void correlate(int ny, int nx, const float *data, float *result) {
    constexpr int floatsPerVector = 8;
    constexpr int blockSize = 8;
    constexpr float8_t f8zero{0,0,0,0,0,0,0,0};
    const int vectorsPerRow = (nx + floatsPerVector - 1) / floatsPerVector;
    const int blocksPerCol = (ny + blockSize - 1) / blockSize;
    const int totalRows = blocksPerCol * blockSize;
    float8_t* input = double4_alloc(vectorsPerRow * totalRows);
    #pragma omp parallel for
    for (int row = 0; row < ny; ++row) { // Getting the normalized input matrix
        float mean = 0;
        float rootedSquaredSum = 0;
        for (int col = 0; col < nx; ++col) {
            mean += data[col + nx * row];
        }
        mean /= nx;
        for (int col = 0; col < nx; ++col) { // Get squared sum of the row
            rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
        }
        rootedSquaredSum = sqrt(rootedSquaredSum);
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < floatsPerVector; ++doub) {
                int elem = floatsPerVector * vec + doub;
                input[vectorsPerRow * row + vec][doub] = elem < nx ? (data[elem + nx * row] - mean) / rootedSquaredSum : 0;
            }
        }
    }
    for (int row = ny; row < totalRows; ++row) {
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < floatsPerVector; ++doub) {
                input[vectorsPerRow * row + vec][doub] = 0;
            }
        }
    }
    #pragma omp parallel for schedule(static,1)
    for (int outerBlock = 0; outerBlock < blocksPerCol; ++outerBlock) {
        for (int innerBlock = outerBlock; innerBlock < blocksPerCol; ++innerBlock) {
            float8_t sums[blockSize][blockSize];
            for (int i = 0; i < blockSize; ++i) {
                for (int j = 0; j < blockSize; ++j) {
                    sums[i][j] = f8zero;
                }
            }
            float8_t outers[blockSize];
            float8_t inners[blockSize];
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
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
                        float8_t res = sums[i][j];
                        result[col + row * ny] = res[0] + res[1] + res[2] + res[3] + res[4] + res[5] + res[6] + res[7];
                    }
                }
            }
        }
    }
    free(input);
}