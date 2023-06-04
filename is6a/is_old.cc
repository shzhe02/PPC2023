#include <new>
#include <cstdlib>
#include <algorithm>
#include <limits>
#include <iostream>
#include <vector>
struct Result {
    int y0;
    int x0;
    int y1;
    int x1;
    float outer[3];
    float inner[3];
};
Result segment(int ny, int nx, const float *data) {
    // Packing into array
    int* sums = (int*) calloc((ny + 1) * (nx + 1), sizeof(int));

    #pragma omp parallel for
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

    // Finding all possible combinations
    
    std::vector<double> errors(ny);
    for (int i = 0; i < ny; ++i) {
        errors[i] = std::numeric_limits<double>::max();
    }
    std::vector<Result> results(ny);
    int totalElems = ny * nx;
    int totalSum = sums[nx + ny * (nx + 1)];
    int firstTerm = 3 * totalSum * totalSum;

    #pragma omp parallel for schedule(dynamic)
    for (int height = 1; height <= ny; ++height) {
        Result result{0, 0, 0, 0, {0, 0, 0}, {0, 0, 0}};

        for (int width = 1; width <= nx; ++width) {

            int elemsInWindow = height * width;
            float invElemsInWindow = 1.0 / elemsInWindow;
            int elemsInBg = totalElems - elemsInWindow;
            float invElemsInBg = 1.0 / elemsInBg;

            for (int y0 = 0; y0 <= ny - height; ++y0) {
                int y1 = y0 + height;
                for (int x0 = 0; x0 <= nx - width; ++x0) {
                    int x1 = x0 + width;
                    int windowSum = sums[x1 + y1 * (nx + 1)] - sums[x1 + y0 * (nx + 1)] - sums[x0 + y1 * (nx + 1)] + sums[x0 + y0 * (nx + 1)];
                    int bgSum = totalSum - windowSum;

                    double newError = firstTerm + 3.0 * (1.0 * bgSum * bgSum * (invElemsInBg - 2.0 * invElemsInBg) - 1.0 * windowSum * invElemsInWindow * windowSum);

                    if (newError < errors[height - 1]) {
                        errors[height - 1] = newError;
                        result.y0 = y0;
                        result.x0 = x0;
                        result.y1 = y1;
                        result.x1 = x1;
                        float avgWindowColor = windowSum * invElemsInWindow;
                        float avgBgColor = bgSum * invElemsInBg;
                        for (int c = 0; c < 3; ++c) {
                            result.inner[c] = avgWindowColor;
                            result.outer[c] = avgBgColor;
                        }
                    }
                }
            }
        }
        results[height - 1] = result;
    }
    free(sums);

    auto min = std::min_element(errors.begin(), errors.end());
    int idx = std::distance(errors.begin(), min);
    return results[idx];
}