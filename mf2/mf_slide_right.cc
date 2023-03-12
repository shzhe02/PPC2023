#include <deque>
#include <algorithm>
void mf(int ny, int nx, int hy, int hx, const float *in, float *out) {
  #pragma omp parallel for
  for (int y = 0; y < ny; ++y) {
    int windowTop = (y - hy > 0) ? y - hy : 0;
    int windowBottom = (y + hy + 1 < ny) ? y + hy + 1 : ny;
    std::deque<float> d;
    int windowRight = (hx + 1 < nx) ? hx + 1 : nx; 
    for (int j = 0; j < windowRight; ++j) {
      for (int i = windowTop; i < windowBottom; ++i) {
        d.push_back(in[j + i * nx]);
      }
    }
    for (int x = 0; x < nx; ++x) {
      int windowLeft = (x - hx > 0) ? x - hx : 0;
      windowRight = (x + hx + 1 < nx) ? x + hx + 1 : nx;
      if (windowLeft) {
        d.erase(d.begin(), d.begin() + windowBottom - windowTop);
      }
      int dequeSize = d.size();
      float v[dequeSize];
      std::copy(d.begin(), d.end(), v);
      int halfSize = dequeSize >> 1;
      std::nth_element(v, v + halfSize, v + dequeSize);
      if (dequeSize % 2) {
        out[x + y * nx] = v[halfSize];
      } else {
        float first = v[halfSize];
        std::nth_element(v, v - 1 + halfSize, v + dequeSize);
        out[x + y * nx] = (v[halfSize - 1] + first) / 2;
      }
      if (windowRight - nx) {
        for (int i = windowTop; i < windowBottom; ++i) {
          d.push_back(in[windowRight + i * nx]);
        }
      }
    }
  }
}