#include <deque>
#include <algorithm>
void mf(int ny, int nx, int hy, int hx, const float *in, float *out) {
  #pragma omp parallel for
  for (int x = 0; x < nx; ++x) {
    int windowLeft = (x - hx > 0) ? x - hx : 0;
    int windowRight = (x + hx + 1 < nx) ? x + hx + 1 : nx;
    std::deque<float> d;
    int windowBottom = (hy + 1 < ny) ? hy + 1 : ny; 
    for (int j = 0; j < windowBottom; ++j) {
      std::copy(in + windowLeft + j * nx, in + windowRight + j * nx, std::back_inserter(d));
    }
    for (int y = 0; y < ny; ++y) {
      int windowTop = (y - hy > 0) ? y - hy : 0;
      windowBottom = (y + hy + 1 < ny) ? y + hy + 1 : ny;
      if (windowTop) {
        for (int i = windowLeft; i < windowRight; ++i) {
          d.pop_front();
        }
      }
      int dequeSize = d.size();
      float v[dequeSize];
      std::copy(d.begin(), d.end(), v);
      int halfSize = dequeSize >> 1;
      std::nth_element(v, v + halfSize, v + dequeSize);
      float first = v[halfSize];
      if (dequeSize % 2) {
        out[x + y * nx] = first;
      } else {
        std::nth_element(v, v - 1 + halfSize, v + dequeSize);
        out[x + y * nx] = (v[halfSize - 1] + first) / 2;
      }
      if (windowBottom - ny) {
        std::copy(in + windowLeft + windowBottom * nx, in + windowRight + windowBottom * nx, std::back_inserter(d));
      }
    }
  }
}