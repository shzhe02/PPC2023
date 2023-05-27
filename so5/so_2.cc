#include <algorithm>
#include <omp.h>
#include <iostream>
#include <cmath>

typedef unsigned long long data_t;

void inner(int start, int end, data_t *data, int depth) {
    // std::cout << "Threads: " << threads << std::endl;
    if (start == end) {
        return;
    } else if (depth <= 1) {
        std::sort(data + start, data + end);
        return;
    }
    auto pivot = *std::next(data + start, (end - start) / 2);
    auto middle1 = std::partition(data + start, data + end, [pivot](const auto& em)
    {
        return em < pivot;
    });
    auto middle2 = std::partition(middle1, data + end, [pivot](const auto& em)
    {
        return em == pivot;
    });
    int mid1 = std::distance(data, middle1);
    int mid2 = std::distance(data, middle2);
    #pragma omp task
    inner(start, mid1, data, depth - 1);
    #pragma omp task
    inner(mid2, end, data, depth - 1);
}

void psort(int n, data_t *data) {
    int depth = static_cast<unsigned int>(log2(omp_get_max_threads())) + 1;
    #pragma omp parallel
    #pragma omp single
    {
        inner(0, n, data, depth);
    }
}
