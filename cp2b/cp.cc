#include <cmath>
void correlate(int ny, int nx, const float *data, float *result) {
    double row[2*ny];
    #pragma omp parallel for
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
    #pragma omp parallel for
    for (int j = 0; j < ny; ++j) {
        result[j + j * ny] = 1;
    }
    for (int j = 0; j < ny; ++j) {
        double sumJ = row[j];
        #pragma omp parallel for
        for (int i = j + 1; i < ny; ++i) {
            double sumIJ = 0;
            double sumI = row[i];
            for (int n = 0; n < nx; ++n) {
                sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
            }
            result[i + j * ny] = (sumIJ * nx - sumI * sumJ) / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
        }
    }
}