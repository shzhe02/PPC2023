#include <cmath>
void correlate(int ny, int nx, const float *data, float *result) {
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
}