struct Result {
    float avg[3];
};
#include <iostream>
Result calculate(int, int nx, const float *data, int y0, int x0, int y1, int x1) {
    constexpr int parallels = 10;
    const int nx_3 = 3 * nx;
    const int nx0_3 = 3 * x0;
    const int totalPixels = (y1 - y0) * (x1 - x0);
    double r[parallels] = { 0.0 };
    double g[parallels] = { 0.0 };
    double b[parallels] = { 0.0 };
    for (int y = y0; y < y1; y += parallels) {
        int indexes[parallels];
        for (int i = 0; i < parallels; ++i) {
            indexes[i] = nx0_3 + nx_3 * (y + i) - 1;
        }
        for (int x = x0; x < x1; ++x) {
            for (int i = 0; i < parallels; ++i) {
                if (y + i < y1) {
                    r[i] += *(data + (++indexes[i]));
                    g[i] += *(data + (++indexes[i]));
                    b[i] += *(data + (++indexes[i]));
                } 
            }
        }
    }
    double rS = 0;
    double gS = 0;
    double bS = 0;
    for (int i = 0; i < parallels; ++i) {
        rS += r[i];
        gS += g[i];
        bS += b[i];
    }
    return Result{float(rS) / totalPixels, float(gS) / totalPixels, float(bS) / totalPixels};
}