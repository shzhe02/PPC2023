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
void correlate(int ny, int nx, const float *data, float *result) {
    //std::vector<double> input(ny * nx);
    double* input = (double*) malloc(ny * nx * sizeof(double));
    // Getting the normalized input matrix
    
    for (int row = 0; row < ny; ++row) {
        asm("# Normalizing");
        // Get the mean of the column
        double rootedSquaredSum = 0;
        double mean = 0;
        for (int col = 0; col < nx; ++col) {
            mean += data[col + nx * row];
        }
        mean /= nx;
        // Get squared sum of the row
        for (int col = 0; col < nx; ++col) {
            rootedSquaredSum += pow(data[col + nx * row] - mean, 2);
        }
        rootedSquaredSum = sqrt(rootedSquaredSum);
        // Normalize inputs
        for (int col = 0; col < nx; ++col) {
            input[col + row * nx] = (data[col + nx * row] - mean) / rootedSquaredSum;
        }
    }
    for (int row = 0; row < ny; ++row) {
        for (int innerRow = row; innerRow < ny; ++innerRow) {
            asm("# Matrix Multiplication");
            // Matrix multiplication
            double sum = 0;
            for (int col = 0; col < nx; ++col) {
                sum += input[col + row * nx] * input[col + innerRow * nx];
            }
            result[innerRow + row * ny] = sum;
        }
    }
    free(input);
}