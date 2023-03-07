/*
This is the function you need to implement. Quick reference:
- input rows: 0 <= y < ny
- input columns: 0 <= x < nx
- element at row y and column x is stored in data[x + y*nx]
- correlation between rows i and row j has to be stored in result[i + j*ny]
- only parts with 0 <= j <= i < ny need to be filled
*/
#include <cmath>
#include <vector>
//#include <chrono>
//#include <iostream>
void correlate(int ny, int nx, const float *data, float *result) {
    //auto start = std::chrono::high_resolution_clock::now();
    double* input = (double*) malloc(ny * nx * sizeof(double));
    // Getting the normalized input matrix
    
    for (int row = 0; row < ny; ++row) {
        // Get the mean of the column
        double rootedSquaredSum = 0;
        int parallels = 16;
        double rootedSums[parallels];
        int extra = nx % parallels;
        int max = (nx - extra) / parallels;
        double means[parallels];
        for (int i = 0; i < parallels; ++i) {
            means[i] = 0;
            rootedSums[i] = 0;
        }
        for (int col = 0; col < max; ++col) {
            for (int i = 0; i < parallels; ++i) {
                means[i] += data[col * parallels + i + nx * row];
            }
        }
        double mean = 0;
        for (int i = 0; i < parallels; ++i) {
            mean += means[i];
        }
        for (int col = nx - extra; col < nx; ++col) {
            mean += data[col + nx * row];
        }
        mean /= nx;
        // Get squared sum of the row

        for (int col = 0; col < max; ++col) {
            for (int i = 0; i < parallels; ++i) {
                rootedSums[i] += pow(data[col * parallels + i + nx * row] - mean, 2);
            }
        }
        for (int i = 0; i < parallels; ++i) {
            rootedSquaredSum += rootedSums[i];
        }
        for (int col = nx - extra; col < nx; ++col) {
            rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
        }
        // for (int col = 0; col < nx; ++col) {
        //     rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
        // }
        rootedSquaredSum = sqrt(rootedSquaredSum);
        // Normalize inputs
        for (int col = 0; col < nx; ++col) {
            input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
        }
    }
    // for (int row = 0; row < ny; ++row) {
    //     asm("# Normalizing");
    //     // Get the mean of the column
    //     double rootedSquaredSum = 0;
    //     double mean = 0;
    //     for (int col = 0; col < nx; ++col) {
    //         mean += data[col + nx * row];
    //     }
    //     mean /= nx;
    //     // Get squared sum of the row
    //     for (int col = 0; col < nx; ++col) {
    //         rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
    //     }
    //     rootedSquaredSum = sqrt(rootedSquaredSum);
    //     // Normalize inputs
    //     for (int col = 0; col < nx; ++col) {
    //         input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
    //     }
    // }
    // auto normFin = std::chrono::high_resolution_clock::now();
    // auto duration = std::chrono::duration_cast<std::chrono::microseconds>(normFin - start);
    // std::cout << "Normalized: " << duration.count() << " microseconds." << std::endl;
    for (int row = 0; row < ny; ++row) {
        for (int innerRow = row; innerRow < ny; ++innerRow) {
            // Matrix multiplication
            double sum = 0;
            int parallels = 16;
            int extra = nx % parallels;
            int max = (nx - extra) / parallels;
            double sums[parallels];
            for (int i = 0; i < parallels; ++i) {
                sums[i] = 0;
            }
            // for (int col = 0; col < nx; ++col) {
            //     sum += input[col + row * nx] * input[col + innerRow * nx];
            // }
            for (int col = 0; col < max; ++col) {
                for (int i = 0; i < parallels; ++i) {
                    sums[i] += input[col * parallels + i + row * nx] * input[col * parallels + i + innerRow * nx];
                }
            }
            for (int i = 0; i < parallels; ++i) {
                sum += sums[i];
            }
            for (int col = nx - extra; col < nx; ++col) {
                sum += input[col + row * nx] * input[col + innerRow * nx];
            }
            result[innerRow + row * ny] = sum;
        }
    }
    // auto allFin = std::chrono::high_resolution_clock::now();
    // auto endduration = std::chrono::duration_cast<std::chrono::microseconds>(allFin - start);
    // std::cout << "Done: " << endduration.count() << " microseconds." << std::endl;
    free(input);
}