#include <new>
#include <cstdlib>
#include <algorithm>
#include <limits>
#include <iostream>
#include <immintrin.h>
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
    int* sums = (int*) calloc((ny + 1) * (nx + 1), sizeof(int));
    for (int x = 1; x <= nx; ++x) {
        int lastSum = 0;
        for (int y = 1; y <= ny; ++y) {
            int newSum = 0;
            for (int k = 0; k < x; ++k) {
                newSum += data[k * 3 + (y - 1) * 3 * nx];
            }
            lastSum += newSum;
            sums[x + y * (nx + 1)] = lastSum;
        }
    }
    int totalElems = ny * nx;
    int totalSum = sums[nx + ny * (nx + 1)];
    float bestError = std::numeric_limits<float>::max();
    Result best;
    for (int height = 1; height <= ny; ++height) {
        for (int width = 1; width <= nx; ++width) {
            for (int y0 = 0; y0 <= ny - height; ++y0) {
                for (int x0 = 0; x0 <= nx - width; ++x0) {
                    Result result{0, 0, 0, 0, {0, 0, 0}, {0, 0, 0}};
                    float localError = std::numeric_limits<float>::max();
                    int elemsInWindow = height * width;
                    float invElemsInWindow = 1.0 / elemsInWindow;
                    int elemsInBg = totalElems - elemsInWindow;
                    float invElemsInBg = 1.0 / elemsInBg;
                    int x1 = x0 + width;
                    int y1 = y0 + height;
                    int windowSum = sums[x1 + y1 * (nx + 1)] - sums[x1 + y0 * (nx + 1)] - sums[x0 + y1 * (nx + 1)] + sums[x0 + y0 * (nx + 1)];
                    int bgSum = totalSum - windowSum;
                    float newError = - (invElemsInBg * bgSum * bgSum + invElemsInWindow * windowSum * windowSum);
                    if (newError < localError) {
                        localError = newError;
                        result.y0 = y0;
                        result.x0 = x0;
                        result.y1 = y1;
                        result.x1 = x1;
                        float avgWindowColor = invElemsInWindow * windowSum;
                        float avgBgColor = invElemsInBg * bgSum;
                        for (int c = 0; c < 3; ++c) {
                            result.inner[c] = avgWindowColor;
                            result.outer[c] = avgBgColor;
                        }
                    }
                }
            }
        }
        // if (localError < bestError) {
        //     best = result;
        //     bestError = localError;
        // }
    }
    free(sums);
    return best;
}
