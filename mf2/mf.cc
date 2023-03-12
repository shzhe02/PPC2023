#include <vector>
#include <algorithm>
void mf(int ny, int nx, int hy, int hx, const float *in, float *out) {
  #pragma omp parallel for schedule(static,1)
  for (int y = 0; y < ny; ++y) {
    int windowTop = (y - hy > 0) ? y - hy : 0;
    int windowBottom = (y + hy + 1 < ny) ? y + hy + 1 : ny;
    std::vector<float> v;
    v.reserve(hx * hy);
    for (int x = 0; x < nx; ++x) {
      int windowLeft = (x - hx > 0) ? x - hx : 0;
      int windowRight = (x + hx + 1 < nx) ? x + hx + 1 : nx;
      // Create vector
      v.clear();
      //v.reserve((windowBottom - windowTop) * (windowRight - windowLeft));
      for (int i = windowTop; i < windowBottom; ++i) {
        v.insert(v.end(), in + windowLeft + i * nx, in + windowRight + i*nx);
      }
      std::nth_element(v.begin(), v.begin() + v.size() / 2, v.end());
      out[x + y * nx] = v[v.size() / 2];
      if (!(v.size() % 2)) {
        std::nth_element(v.begin(), v.begin() - 1 + v.size() / 2, v.end());
        out[x + y * nx] /= 2;
        out[x + y * nx] += v[v.size() / 2 - 1] / 2;
      }
    }
  }
}