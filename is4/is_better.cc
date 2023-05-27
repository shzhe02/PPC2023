#include <new>
#include <cstdlib>
#include <algorithm>
#include <limits>
#include <iostream>
#include <vector>
typedef double double4_t __attribute__ ((vector_size (4 * sizeof(double))));
static double4_t* double4_alloc(std::size_t n) {
    void* tmp = 0;
    if (posix_memalign(&tmp, sizeof(double4_t), sizeof(double4_t) * n)) {
        throw std::bad_alloc();
    }
    return (double4_t*)tmp;
}
struct Result {
    int y0;
    int x0;
    int y1;
    int x1;
    float outer[3];
    float inner[3];
};
static inline double sumRGB(double4_t in) { return in[0] + in[1] + in[2]; }
Result segment(int ny, int nx, const float *data) {
    constexpr double4_t one4_t = {1, 1, 1, 1};
    // Packing into array
    double4_t* input = double4_alloc(ny * nx);

    #pragma omp parallel for
    for (int y = 0; y < ny; ++y) {
        for (int x = 0; x < nx; ++x) {
            double r = data[3 * x + 3 * nx * y];
            double g = data[1 + 3 * x + 3 * nx * y];
            double b = data[2 + 3 * x + 3 * nx * y];
            double4_t value = {
                r, g, b, r * r + g * g + b * b
            };
            input[x + y * nx] = value;
        }
    }
    // Calculating sums
    double4_t* sums = double4_alloc((ny + 1) * (nx + 1));

    #pragma omp parallel for
    for (int x = 1; x <= nx; ++x) {
        double4_t lastSum = {0};
        for (int y = 1; y <= ny; ++y) {
            double4_t newSum = {0};
            for (int k = 0; k < x; ++k) {
                newSum += input[k + (y - 1) * nx];
            }
            lastSum += newSum;
            sums[x + y * (nx + 1)] = lastSum;
        }
    }
    free(input);
    // Finding all possible combinations
    
    std::vector<double> errors(ny);
    for (int i = 0; i < ny; ++i) {
        errors[i] = std::numeric_limits<double>::max();
    }
    std::vector<Result> results(ny);
    double elemsB = double(ny * nx);
    double4_t totalElems = {elemsB, elemsB, elemsB, 1};


    #pragma omp parallel for schedule(dynamic)
    for (int height = 1; height <= ny; ++height) {
        Result result{0, 0, 0, 0, {0, 0, 0}, {0, 0, 0}};

        for (int width = 1; width <= nx; ++width) {

            double elems = double(height * width);
            double4_t elemsInWindow = {elems, elems, elems, 1};
            double4_t invElemsInWindow = one4_t / elemsInWindow;
            double4_t elemsInBg = totalElems - elemsInWindow;
            double4_t invElemsInBg = one4_t / elemsInBg;
            double elemsBg = elemsB - elems;

            for (int y0 = 0; y0 <= ny - height; ++y0) {
                int y1 = y0 + height;
                for (int x0 = 0; x0 <= nx - width; ++x0) {
                    int x1 = x0 + width;
                    double4_t windowSum = sums[x1 + y1 * (nx + 1)] - sums[x1 + y0 * (nx + 1)] - sums[x0 + y1 * (nx + 1)] + sums[x0 + y0 * (nx + 1)];
                    double4_t bgSum = sums[nx + ny * (nx + 1)] - windowSum;

                    double4_t avgWindowColor = windowSum * invElemsInWindow;
                    double4_t avgBgColor = bgSum * invElemsInBg;

                    double4_t avgWindowColor2 = avgWindowColor * avgWindowColor;
                    double4_t avgBgColor2 = avgBgColor * avgBgColor;

                    //double avgWindowSum2 = avgWindowColor2[0] + avgWindowColor2[1] + avgWindowColor2[2];
                    //double avgBgSum2 = avgBgColor2[0] + avgBgColor2[1] + avgBgColor2[2];

                    double4_t avgWindowColorAndSum = avgWindowColor * windowSum;
                    double4_t avgBgColorAndSum = avgBgColor * bgSum;

                    //double avgWindowSumColor = avgWindowColorAndSum[0] + avgWindowColorAndSum[1] + avgWindowColorAndSum[2];
                    //double avgBgSumColor = avgBgColorAndSum[0] + avgBgColorAndSum[1] + avgBgColorAndSum[2];

                    double windowError = elems * sumRGB(avgWindowColor2) - 2 * sumRGB(avgWindowColorAndSum) + windowSum[3];
                    double bgError = elemsBg * sumRGB(avgBgColor2) - 2 * sumRGB(avgBgColorAndSum) + bgSum[3];

                    double newError = windowError + bgError;

                    if (newError < errors[height - 1]) {
                        errors[height - 1] = newError;
                        result.y0 = y0;
                        result.x0 = x0;
                        result.y1 = y1;
                        result.x1 = x1;
                        for (int c = 0; c < 3; ++c) {
                            result.inner[c] = avgWindowColor[c];
                            result.outer[c] = avgBgColor[c];
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
