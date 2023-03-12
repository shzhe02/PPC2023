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
    double row[2*ny];
    constexpr int doublesPerVector = 4;
    const int vectorsPerRow = (nx + doublesPerVector - 1) / doublesPerVector;
    double4_t* in = double4_alloc(vectorsPerRow * ny);
    for (int r = 0; r < ny; ++r) {
        double rowSum = 0;
        double rowSumSquared = 0;
        for (int c = 0; c < nx; ++c) {
            double point = data[c + r * nx];
            rowSum += point;
            rowSumSquared += point * point;
        }
        row[r] = rowSum;
        row[r + ny] = rowSumSquared;
    }
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::cout << "Summed - " << duration.count() << " microseconds" << std::endl;
    for (int j = 0; j < ny; ++j) {
        for (int vec = 0; vec < vectorsPerRow; ++vec) {
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                int elem = vec * doublesPerVector + doub;
                in[vectorsPerRow * j + vec][doub] = elem < nx ? data[elem + j * nx] : 0;
            }
        }
    }
    end = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start - duration);
    std::cout << "Vectors packed - " << duration.count() << " microseconds" << std::endl;
    for (int j = 0; j < ny; ++j) {
        double sumJ = row[j];
        result[j + j * ny] = 1;
        for (int i = j + 1; i < ny; ++i) {
            double sumIJ = 0;
            double4_t sumsIJ = {0, 0, 0, 0};
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                sumsIJ += in[vectorsPerRow * i + vec] * in[vectorsPerRow * j + vec];
            }
            for (int doub = 0; doub < doublesPerVector; ++doub) {
                sumIJ += sumsIJ[doub];
            }
            result[i + j * ny] = (sumIJ * nx - row[i] * sumJ) 
                / sqrt((row[i + ny] * nx - row[i] * row[i]) * (row[j + ny] * nx - sumJ * sumJ));
        }
    }
    free(in);
    end = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start - duration);
    std::cout << "Done - " << duration.count() << " microseconds" << std::endl;
}