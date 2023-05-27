#include <omp.h>
#include <algorithm>
#include <cstdlib>
typedef unsigned long long data_t;
void inner(data_t* start, data_t* end, int threads) {
    constexpr int threshold = 1 << 10;
    int len = std::distance(start, end);
    if (len <= 1) { return; }
    else if (threads <= 1 || len <= threshold) {
        std::sort(start, end);
        return;
    }
    auto pivot = *(start + rand() % len);
    auto middle1 = std::partition(start, end, [pivot](const auto& elem) { return elem < pivot; });
    auto middle2 = std::partition(middle1, end, [pivot](const auto& elem) { return elem == pivot; });
    int firstHalf = std::distance(start, middle1);
    int secondHalf = std::distance(middle2, end);
    int total = firstHalf + secondHalf;
    if (total == 0) { return; }
    int threads1 = threads * firstHalf / total;
    #pragma omp task
    inner(start, middle1, threads1);
    #pragma omp task
    inner(middle2, end, threads - threads1);
}
void psort(int n, data_t *data) {
    const int threads = omp_get_max_threads();
    #pragma omp parallel
    #pragma omp single nowait
    {
        inner(data, data + n, threads);
    }
}