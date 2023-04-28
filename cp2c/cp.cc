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
void correlate(int ny, int nx, const float *data, float *result) {
    constexpr int doublesPerVector = 8;
    const int vectorsPerRow = (nx + doublesPerVector - 1) / doublesPerVector;
    double8_t* input = double8_alloc(vectorsPerRow * ny);
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
                input[vectorsPerRow * row + vec][doub] = elem < nx ? (data[elem + nx * row] - mean) / rootedSquaredSum : 0.0;
            }
        }
    }
    for (int row = 0; row < ny; ++row) {
        result[row + row * ny] = 1;
        for (int innerRow = row + 1; innerRow < ny; ++innerRow) {
            double8_t sum = {0,0,0,0};
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                sum += input[vec + vectorsPerRow * row] * input[vec + vectorsPerRow * innerRow];
            }
            double acc = 0;
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                acc += sum[doub];
            }
            result[innerRow + row * ny] = acc;
        }
    }
    free(input);
}