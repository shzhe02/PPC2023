struct Result {
    float avg[3];
};

/*
This is the function you need to implement. Quick reference:
- x coordinates: 0 <= x < nx
- y coordinates: 0 <= y < ny
- horizontal position: 0 <= x0 < x1 <= nx
- vertical position: 0 <= y0 < y1 <= ny
- color components: 0 <= c < 3
- input: data[c + 3 * x + 3 * nx * y]
- output: avg[c]
*/
Result calculate(int, int nx, const float *data, int y0, int x0, int y1, int x1) {
    double c[3] = { 0.0 };
    for (int y = y0; y < y1; ++y) {
        for (int x = x0; x < x1; ++x) {
            c[0] += data[3 * x + 3 * nx * y];
            c[1] += data[1 + 3 * x + 3 * nx * y];            
            c[2] += data[2 + 3 * x + 3 * nx * y];
        }
    }
    int totalPixels = (y1 - y0) * (x1 - x0);
    Result result{{(float) c[0] / totalPixels, (float) c[1] / totalPixels, (float) c[2] / totalPixels}};
    return result;
}
