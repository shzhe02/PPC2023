#include <cmath>
#include <chrono>
#include <iostream>

void correlate(int ny, int nx, const float *data, float *result) {
    auto start = std::chrono::high_resolution_clock::now();
    constexpr int doublesPerVector = 4;
    const int vectorsPerRow = (nx + doublesPerVector - 1) / doublesPerVector;
    double* input = (double*) malloc(ny * nx * sizeof(double));
    for (int row = 0; row < ny; ++row) { // Getting the normalized input matrix
        double mean = 0; // Get the mean of the column
        double rootedSquaredSum = 0;
        for (int col = 0; col < nx; ++col) {
            mean += data[col + nx * row];
        }
        mean /= nx;
        for (int col = 0; col < nx; ++col) { // Get squared sum of the row
            rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
        }
        rootedSquaredSum = sqrt(rootedSquaredSum);
        for (int col = 0; col < nx; ++col) { // Normalize inputs
            input[col + nx * row] = (data[col + nx * row] - mean) / rootedSquaredSum;
        }
    }
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::cout << "Normalized - " << duration.count() << " microseconds" << std::endl;
    for (int row = 0; row < ny; ++row) { // Matrix multiplication
        for (int innerRow = row; innerRow < ny; ++innerRow) {
            double sum = 0;
            for (int col = 0; col < nx; ++col) {
                sum += input[col + row * nx] * input[col + innerRow * nx];
            }
            result[innerRow + row * ny] = sum;
        }
    }
    free(input);
    end = std::chrono::high_resolution_clock::now();
    duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start - duration);
    std::cout << "Done - " << duration.count() << " microseconds" << std::endl;
}