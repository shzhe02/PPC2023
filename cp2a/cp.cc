#include <cmath>
void correlate(int ny, int nx, const float *data, float *result) {
    const int parallels = 8;
    const int extra = nx % parallels;
    const int max = (nx - extra) / parallels;
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
        double sumJ = row[j];
        for (int i = j; i < ny; ++i) {
            double sumIJ = 0;
            double sums[parallels];
            for (int k = 0; k < parallels; ++k) {
                sums[k] = 0;
            }
            for (int n = 0; n < max; ++n) {
                for (int k = 0; k < parallels; ++k) {
                    sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
                }
            }
            for (int k = 0; k < parallels; ++k) {
                sumIJ += sums[k];
            }
            for (int n = nx - extra; n < nx; ++n) {
                sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
            }
            sumIJ *= nx;
            double sumI = row[i];
            result[i + j * ny] = (sumIJ - sumI * sumJ) 
                / sqrt((row[i + ny] * nx - sumI * sumI) * (row[j + ny] * nx - sumJ * sumJ));
        }
    }
}