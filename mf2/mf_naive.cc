#include <vector>
#include <algorithm>
#include <iostream>
void mf(int ny, int nx, int hy, int hx, const float *in, float *out) {
  for (int y = 0; y < ny; ++y) {
    int windowTop = 0;
    if (y - hy > 0) {
      windowTop = y - hy;
    }
    int windowBottom = ny;
    if (y + hy + 1 < ny) {
      windowBottom = y + hy + 1;
    }
    #pragma omp parallel for
    for (int x = 0; x < nx; ++x) {
      int windowLeft = 0;
      if (x - hx > 0) {
        windowLeft = x - hx;
      }
      int windowRight = nx;
      if (x + hx + 1 < nx) {
        windowRight = x + hx + 1;
      }

      // Create vector
      std::vector<float> v = {};
      for (int i = windowTop; i < windowBottom; ++i) {
        for (int j = windowLeft; j < windowRight; ++j) {
          v.push_back(in[j + i * nx]);
        }
      }
      int odd = v.size() % 2;
      if (odd) {
        std::nth_element(v.begin(), v.begin() + v.size() / 2, v.end());
        out[x + y * nx] = v[v.size() / 2];
      } else {
        std::nth_element(v.begin(), v.begin() - 1 + v.size() / 2, v.end());
        float first = v[(v.size() / 2) - 1];
        std::nth_element(v.begin(), v.begin() + v.size() / 2, v.end());
        out[x + y * nx] = (v[(1 + v.size() / 2) - 1] + first) / 2;
      }
    }
  }
}