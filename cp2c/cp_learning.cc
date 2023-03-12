#include <cmath>
#include <new>
typedef double double4_t __attribute__ ((vector_size (4 * sizeof(double))));

static double4_t* double4_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(double4_t), sizeof(double4_t) * n)) {
        throw std::bad_alloc();
    }
    return (double4_t*)tmp;
}

void correlate(int ny, int nx, const float *data, float *result) {
    constexpr int doublesPerVector = 4;
    const int vectorsPerRow = (nx + doublesPerVector - 1) / doublesPerVector;
    double row[ny];
    double row2[ny];
    for (int r = 0; r < ny; ++r) {
        row[r] = 0;
        row2[r] = 0;
        for (int c = 0; c < nx; ++c) {
            row[r] += (double) data[c + r * nx];
            row2[r] += (double) data[c + r * nx] * data[c + r * nx];
        }
    }
    for (int j = 0; j < ny; ++j) {
        for (int i = j; i < ny; ++i) {
            double sumIJ = 0;
            double4_t* partI = double4_alloc(vectorsPerRow);
            double4_t* partJ = double4_alloc(vectorsPerRow);
            double4_t* partIJ = double4_alloc(vectorsPerRow);
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                for (int doub = 0; doub < doublesPerVector; ++doub) {
                    int elem = vec * doublesPerVector + doub;
                    partI[vec][doub] = elem < nx ? data[elem + nx * i] : 0;
                    partJ[vec][doub] = elem < nx ? data[elem + nx * j] : 0;
                }
            }
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                partIJ[vec] = partI[vec] * partJ[vec];
            }
            for (int vec = 0; vec < vectorsPerRow; ++vec) {
                for (int doub = 0; doub < doublesPerVector; ++doub) {
                    sumIJ += partIJ[vec][doub];
                }
            }
            // for (int n = 0; n < nx; ++n) {
            //     sumIJ += (double) (data[n + i * nx]) * data[n + j * nx];
            // }
            result[i + j * ny] = (sumIJ * nx - row[i] * row[j]) 
                / sqrt((row2[i] * nx - row[i] * row[i]) * (row2[j] * nx - row[j] * row[j]));
            free(partI);
            free(partJ);
            free(partIJ);
        }
    }
}