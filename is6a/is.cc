#include <algorithm>
#include <limits>
#include <immintrin.h>
#include <vector>
typedef float float8_t __attribute__ ((vector_size (8 * sizeof(float))));
struct Result {
    int y0;
    int x0;
    int y1;
    int x1;
    float outer[3];
    float inner[3];
};
Result segment(int ny, int nx, const float *data) {
    constexpr float8_t one8_t = {1, 1, 1, 1, 1, 1, 1, 1}; 
    const int nnx = nx + 9;
    float* sums = (float*) calloc((ny + 1) * nnx, sizeof(float));
    #pragma omp parallel for
    for (int x = 1; x <= nx; ++x) {
        int lastSum = 0;
        for (int y = 1; y <= ny; ++y) {
            int newSum = 0;
            for (int k = 0; k < x; ++k) {
                newSum += data[k * 3 + (y - 1) * 3 * nx];
            }
            lastSum += newSum;
            sums[x + y * nnx] = lastSum;
        }
    }
    int totalElems = ny * nx;
    float totalSum = sums[nx + ny * nnx];
    float8_t totalSums = {totalSum, totalSum, totalSum, totalSum, totalSum, totalSum, totalSum, totalSum};
    float bestError = std::numeric_limits<float>::max();
    Result best;
    #pragma omp parallel for schedule(dynamic)
    for (int height = 1; height <= ny; ++height) {
        Result result{0, 0, 0, 0, {0, 0, 0}, {0, 0, 0}};
        float localError = std::numeric_limits<float>::max();
        for (int width = 1; width <= nx; ++width) {
            float elemsInWindow = height * width;
            float8_t nWindow = {elemsInWindow, elemsInWindow, elemsInWindow, elemsInWindow, elemsInWindow, elemsInWindow, elemsInWindow, elemsInWindow};
            float8_t invNWindow = one8_t / nWindow;
            float elemsInBg = totalElems - elemsInWindow;
            float8_t nBg = {elemsInBg, elemsInBg, elemsInBg, elemsInBg, elemsInBg, elemsInBg, elemsInBg, elemsInBg};
            float8_t invNBg = one8_t / nBg;
            for (int y0 = 0; y0 <= ny - height; ++y0) {
                int y1 = y0 + height;
                for (int x0 = 0; x0 <= nx - width; x0 += 8) {
                    int x1 = x0 + width;
                    float8_t big = _mm256_loadu_ps(sums + x1 + y1 * nnx);
                    float8_t side1 = _mm256_loadu_ps(sums + x1 + y0 * nnx);
                    float8_t side2 = _mm256_loadu_ps(sums + x0 + y1 * nnx);
                    float8_t small = _mm256_loadu_ps(sums + x0 + y0 * nnx);
                    float8_t windowSum = big - side1 - side2 + small;
                    float8_t bgSum = totalSums - windowSum;
                    float8_t newError = - (invNBg * bgSum * bgSum + invNWindow * windowSum * windowSum);
                    for (int k = 0; k < 8; ++k) {
                        if (newError[k] < localError && x1 + k <= nx) {
                            localError = newError[k];
                            result.y0 = y0;
                            result.x0 = x0 + k;
                            result.y1 = y1;
                            result.x1 = x1 + k;
                            float avgWindowColor = invNWindow[k] * windowSum[k];
                            float avgBgColor = invNBg[k] * bgSum[k];
                            for (int c = 0; c < 3; ++c) {
                                result.inner[c] = avgWindowColor;
                                result.outer[c] = avgBgColor;
                            }
                        }
                    }
                }
            }
        }
        #pragma omp critical
        {
            if (localError < bestError) {
                best = result;
                bestError = localError;
            }
        }
    }
    free(sums);
    return best;
}