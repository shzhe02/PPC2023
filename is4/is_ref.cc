#include <vector>
#include <algorithm>
#include <limits>
#include <omp.h>

struct Result {
    int y0;
    int x0;
    int y1;
    int x1;
    float outer[3];
    float inner[3];
};

Result segment(int ny, int nx, const float *data) {
    std::vector<std::vector<std::vector<float>>> prefix_sum(ny+1, std::vector<std::vector<float>>(nx+1, std::vector<float>(3)));

    // Precompute the prefix sum array
    for (int y = 1; y <= ny; ++y) {
        for (int x = 1; x <= nx; ++x) {
            for (int c = 0; c < 3; ++c) {
                prefix_sum[y][x][c] = data[c + 3 * (x - 1) + 3 * nx * (y - 1)] 
                                      - prefix_sum[y - 1][x - 1][c] + prefix_sum[y - 1][x][c] + prefix_sum[y][x - 1][c];
            }
        }
    }

    // Helper function to compute the sum of the color components in a rectangle
    auto rect_sum = [&](int y0, int x0, int y1, int x1, int c) {
        return prefix_sum[y1][x1][c] - prefix_sum[y0][x1][c] - prefix_sum[y1][x0][c] + prefix_sum[y0][x0][c];
    };

    double min_cost = std::numeric_limits<double>::max();
    Result result{0, 0, 0, 0, {0, 0, 0}, {0, 0, 0}};

    // Iterate over all possible rectangle sizes
    // Result local_result{0, 0, 0, 0, {0, 0, 0}, {0, 0, 0}};
    // double local_min_cost = std::numeric_limits<double>::max();

    for (int height = 1; height <= ny; ++height) {
        for (int width = 1; width <= nx; ++width) {

            // Iterate over all possible rectangle positions
            for (int y0 = 0; y0 <= ny - height; ++y0) {
                for (int x0 = 0; x0 <= nx - width; ++x0) {
                    int y1 = y0 + height;
                    int x1 = x0 + width;

                    // Compute average color for outer and inner rectangles
                    float outer_avg[3], inner_avg[3];
                    for (int c = 0; c < 3; ++c) {
                        outer_avg[c] = (prefix_sum[ny][nx][c] - rect_sum(y0, x0, y1, x1, c)) / (ny * nx - height * width);
                        inner_avg[c] = rect_sum(y0, x0, y1, x1, c) / (height * width);
                    }

                    // Compute the total cost of the current segmentation
                    double cost = 0;
                    for (int y = 0; y < ny; ++y) {
                        for (int x = 0; x < nx; ++x) {
                            for (int c = 0; c < 3; ++c) {
                                float color = data[c + 3 * x + 3 * nx * y];
                                float error;
                                if (y >= y0 && y < y1 && x >= x0 && x < x1) {
                                    // Inside the rectangle
                                    error = inner_avg[c] - color;
                                } else {
                                    // Outside the rectangle
                                    error = outer_avg[c] - color;
                                }
                                cost += error * error;
                            }
                        }
                    }
                    // Update the result if the current segmentation has a lower cost
                    if (cost < min_cost) {
                        min_cost = cost;
                        result.y0 = y0;
                        result.x0 = x0;
                        result.y1 = y1;
                        result.x1 = x1;
                        for (int c = 0; c < 3; ++c) {
                            result.outer[c] = outer_avg[c];
                            result.inner[c] = inner_avg[c];
                        }
                    }
                }
            }
        }
    }

    return result;
}