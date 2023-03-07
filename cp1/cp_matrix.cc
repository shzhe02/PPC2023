#include <cmath>
//#include <vector>
void correlate(int ny, int nx, const float *data, float *result) {
    //std::vector<double> input(ny * nx);
    double* input = (double*) malloc(ny * nx * sizeof(double));
    // Getting the normalized input matrix
    for (int row = 0; row < ny; ++row) {
        // Get the mean of the column
        double mean = 0;
        double rootedSquaredSum = 0;
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
            input[col + nx * row] = (data[col + nx * row] - mean) / rootedSquaredSum;
        }
    }
    for (int row = 0; row < ny; ++row) {
        for (int innerRow = row; innerRow < ny; ++innerRow) {
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