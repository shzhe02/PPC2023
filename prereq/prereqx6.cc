struct Result {
    float avg[3];
};
#include <iostream>
Result calculate(int, int nx, const float *data, int y0, int x0, int y1, int x1) {
    const int totalPixels = (y1 - y0) * (x1 - x0);
    const int nx0_3 = 3 * x0;
    const int nx_3 = 3 * nx;
    double c1[3] = { 0.0 };
    double c2[3] = { 0.0 };
    double c3[3] = { 0.0 };
    double c4[3] = { 0.0 };
    double c5[3] = { 0.0 };
    double c6[3] = { 0.0 };
    for (int y = y0; y < y1; y += 6) {
        int index1 = nx0_3 + nx_3 * y - 1;
        int index2 = nx0_3 + nx_3 * (y + 1) - 1;
        int index3 = nx0_3 + nx_3 * (y + 2) - 1;
        int index4 = nx0_3 + nx_3 * (y + 3) - 1;
        int index5 = nx0_3 + nx_3 * (y + 4) - 1;
        int index6 = nx0_3 + nx_3 * (y + 5) - 1;
        for (int x = x0; x < x1; ++x) {
            c1[0] += *(data + (++index1));
            c1[1] += *(data + (++index1));
            c1[2] += *(data + (++index1));
            if (y + 1 < y1) {
                c2[0] += *(data + (++index2));
                c2[1] += *(data + (++index2));
                c2[2] += *(data + (++index2));
            }
            if (y + 2 < y1) {
                c3[0] += *(data + (++index3));
                c3[1] += *(data + (++index3));
                c3[2] += *(data + (++index3));
            }
            if (y + 3 < y1) {
                c4[0] += *(data + (++index4));
                c4[1] += *(data + (++index4));
                c4[2] += *(data + (++index4));
            }
            if (y + 4 < y1) {
                c5[0] += *(data + (++index5));
                c5[1] += *(data + (++index5));
                c5[2] += *(data + (++index5));
            }
            if (y + 5 < y1) {
                c6[0] += *(data + (++index6));
                c6[1] += *(data + (++index6));
                c6[2] += *(data + (++index6));
            }
        }
    }
    return Result{(float) (c1[0] + c2[0] + c3[0] + c4[0] + c5[0] + c6[0]) / totalPixels, (float) (c1[1] + c2[1] + c3[1] + c4[1] + c5[1] + c6[1]) / totalPixels, (float) (c1[2] + c2[2] + c3[2] + c4[2] + c5[2] + c6[2]) / totalPixels};
}