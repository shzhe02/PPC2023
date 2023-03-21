#include <cmath>
#include <new>
#include <x86intrin.h>
typedef float float8_t __attribute__ ((vector_size (8 * sizeof(float))));
static float8_t* float8_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(float8_t), sizeof(float8_t) * n)) {
        throw std::bad_alloc();
    }
    return (float8_t*)tmp;
}
static inline float8_t swap4(float8_t x) { return _mm256_permute2f128_ps(x, x, 0b00000001); }
static inline float8_t swap2(float8_t x) { return _mm256_permute_ps(x, 0b01001110); }
static inline float8_t swap1(float8_t x) { return _mm256_permute_ps(x, 0b10110001); }
void correlate(int ny, int nx, const float *data, float *result) {
    constexpr int floatsPerVector = 8;
    constexpr float8_t f8zero{0};
    const int vectorsPerCol = (ny + floatsPerVector - 1) / floatsPerVector;
    float8_t* input = float8_alloc(nx * vectorsPerCol);
    #pragma omp parallel for schedule(static,1)
    for (int vec = 0; vec < vectorsPerCol; ++vec) { // Packing data into input, vectorized and padded.
        for (int doub = 0; doub < floatsPerVector; ++doub) {
            for (int col = 0; col < nx; ++col) {
                int row = doub + floatsPerVector * vec;
                input[col + vec * nx][doub] = row < ny ? data[col + row * nx] : 0;
            }
        }
    }
    #pragma omp parallel for schedule(static,1)
    for (int vec = 0; vec < vectorsPerCol; ++vec) { // Normalization
        float8_t means = f8zero;
        float8_t rsSums = f8zero;
        for (int col = 0; col < nx; ++col) { // Calculating means
            means += input[col + vec * nx];
        }
        for (int i = 0; i < floatsPerVector; ++i) {
            means[i] /= nx;
        } // Means calculated
        for (int col = 0; col < nx; ++col) { // Calculating rooted squared sums
            rsSums += (input[col + vec * nx] - means) * (input[col + vec * nx] - means);
        }
        for (int i = 0; i < floatsPerVector; ++i) {
            rsSums[i] = sqrt(rsSums[i]);
        } // rsSum calculated
        for (int col = 0; col < nx; ++col) { // Normalization step
            input[col + vec * nx] = (input[col + vec * nx] - means) / rsSums;
        } // Normalized
    } // Preparations complete
    #pragma omp parallel for schedule(static,1)
    for (int outer = 0; outer < vectorsPerCol; ++outer) {
        float8_t vv[8];
        for (int inner = outer; inner < vectorsPerCol; ++inner) {
            vv[0] = f8zero;
            vv[1] = f8zero;
            vv[2] = f8zero;
            vv[3] = f8zero;
            vv[4] = f8zero;
            vv[5] = f8zero;
            vv[6] = f8zero;
            vv[7] = f8zero;
            for (int col = 0; col < nx; ++col) {
                float8_t a000 = input[nx*outer + col];
                float8_t b000 = input[nx*inner + col];
                float8_t a100 = swap4(a000);
                float8_t a010 = swap2(a000);
                float8_t a110 = swap2(a100);
                float8_t b001 = swap1(b000);
                vv[0] += a000 * b000;
                vv[1] += a000 * b001;
                vv[2] += a010 * b000;
                vv[3] += a010 * b001;
                vv[4] += a100 * b000;
                vv[5] += a100 * b001;
                vv[6] += a110 * b000;
                vv[7] += a110 * b001;
            }
            for (int kb = 1; kb < 8; kb += 2) {
                vv[kb] = swap1(vv[kb]);
            }
            for (int jb = 0; jb < 8; ++jb) {
                for (int ib = 0; ib < 8; ++ib) {
                    int i = ib + outer*8;
                    int j = jb + inner*8;
                    if (j < ny && i < ny) {
                        result[ny*i + j] = vv[ib^jb][jb];
                    }
                }
            }
        }
    }
    free(input);
}   