#include <cmath>
#include <vector>
void correlate(int ny, int nx, const float *data, float *result) {
    constexpr int parallels = 8;
    const int extra = nx % parallels;
    const int max = (nx - extra) / parallels;
    std::vector <double> row(ny);
    std::vector<double> row2(ny);
    for (int r = 0; r < ny; ++r) {
        row[r] = 0;
        row2[r] = 0;
        for (int c = 0; c < nx; ++c) {
            row[r] += data[c + r * nx];
            row2[r] += (double) data[c + r * nx] * data[c + r * nx];
        }
    }
    for (int j = 0; j < ny; ++j) {
        double sumJ = row[j];
        for (int i = j; i < ny; ++i) {
            double sums[parallels];
            for (int k = 0; k < parallels; ++k) {
                sums[k] = 0;
            }
            for (int n = 0; n < max; ++n) {
                for (int k = 0; k < parallels; ++k) {
                    sums[k] += (double) (data[n * parallels + k + i * nx]) * data[n * parallels + k + j * nx];
                }
            }
            double sumIJ = 0;
            for (int k = 0; k < parallels; ++k) {
                sumIJ += sums[k];
            }
            for (int n = nx - extra; n < nx; ++n) {
                sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
            }
            double sumI = row[i];
            result[i + j * ny] = (sumIJ * nx - sumI * sumJ) 
                / sqrt((row2[i] * nx - sumI * sumI) * (row2[j] * nx - sumJ * sumJ));
        }
    }
}