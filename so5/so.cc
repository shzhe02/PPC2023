#include <omp.h>
#include <algorithm>
#include <random>
typedef unsigned long long data_t;
std::random_device rd;
std::mt19937 gen(rd());
void inner(data_t* start, data_t* end, int threads) {
    int len = std::distance(start, end);
    if (len <= 1) { return; }
    else if (threads <= 1) {
        std::sort(start, end);
        return;
    }
    std::uniform_int_distribution<int> dist(0, len - 1);
    auto pivot = *(start + dist(gen));
    auto middle1 = std::partition(start, end, [pivot](const auto& elem) { return elem < pivot; });
    auto middle2 = std::partition(middle1, end, [pivot](const auto& elem) { return elem == pivot; });
    int firstHalf = middle1 - start;
    int secondHalf = end - middle2;
    int total = firstHalf + secondHalf;
    if (total == 0) { return; }
    int threads1 = threads * ((float) firstHalf / total);
    #pragma omp task
    inner(start, middle1, threads1);
    #pragma omp task
    inner(middle2, end, threads - threads1);
}
void psort(int n, data_t *data) {
    const int threads = omp_get_max_threads() << 6;
    #pragma omp parallel
    #pragma omp single nowait
    {
        inner(data, data + n, threads);
    }
}