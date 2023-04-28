#include <cmath>
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
    const int vectorsPerRow = (nx + doublesPerVector - 1) / doublesPerVector;
    double4_t* input = double4_alloc(vectorsPerRow * ny);
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
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::cout << "Normalized - " << duration.count() << " microseconds" << std::endl;
    for (int row = 0; row < ny; ++row) {
        result[row + row * ny] = 1;
        for (int innerRow = row + 1; innerRow < ny; ++innerRow) {
            double4_t sum = {0,0,0,0};
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
    end = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start - duration);
    std::cout << "Done - " << duration.count() << " microseconds" << std::endl;
}