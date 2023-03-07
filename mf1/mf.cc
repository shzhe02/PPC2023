/*
This is the function you need to implement. Quick reference:
- input rows: 0 <= y < ny
- input columns: 0 <= x < nx
- element at row y and column x is stored in in[x + y*nx]
- for each pixel (x, y), store the median of the pixels (a, b) which satisfy
  max(x-hx, 0) <= a < min(x+hx+1, nx), max(y-hy, 0) <= b < min(y+hy+1, ny)
  in out[x + y*nx].
*/
#include <deque>
#include <vector>
#include <algorithm>
void mf(int ny, int nx, int hy, int hx, const float *in, float *out) {
  for (int y = 0; y < ny; ++y) {
    int windowTop = (y - hy > 0) ? y - hy : 0;
    int windowBottom = (y + hy + 1 < ny) ? y + hy + 1 : ny;

    std::deque<float> d = {};
    int wr = (hx + 1 < nx) ? hx + 1 : nx; 
    for (int j = 0; j < wr; ++j) {
      for (int i = windowTop; i < windowBottom; ++i) {
        d.push_back(in[j + i * nx]);
      }
    }
    for (int x = 0; x < nx; ++x) {
      int windowLeft = (x - hx > 0) ? x - hx : 0;
      int windowRight = (x + hx + 1 < nx) ? x + hx + 1 : nx;

      if (windowLeft) {
        for (int n = windowTop; n < windowBottom; ++n) {
          d.pop_front();
        }
      }
      std::vector<float> v(std::begin(d), std::end(d));
      int halfSize = d.size() >> 1;
      std::nth_element(v.begin(), v.begin() + halfSize, v.end());
      if (v.size() % 2) {
        out[x + y * nx] = v[halfSize];
      } else {
        float first = v[halfSize];
        std::nth_element(v.begin(), v.begin() - 1 + halfSize, v.end());
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
