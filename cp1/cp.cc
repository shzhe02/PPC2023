#include <cmath>
void correlate(int ny, int nx, const float *data, float *result) {
    double row[2*ny];
    for (int r = 0; r < ny; ++r) {
        row[r] = 0;
        row[r + ny] = 0;
        for (int c = 0; c < nx; ++c) {
            row[r] += (double) data[c + r * nx];
            row[r + ny] += (double) data[c + r * nx] * data[c + r * nx];
        }
    }
    for (int j = 0; j < ny; ++j) {
        for (int i = j; i < ny; ++i) {
            double sumIJ = 0;
            for (int n = 0; n < nx; ++n) {
                sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
            }
            result[i + j * ny] = (sumIJ * nx - row[i] * row[j]) 
                / sqrt((row[i + ny] * nx - row[i] * row[i]) * (row[j + ny] * nx - row[j] * row[j]));
        }
    }
}