#include <algorithm>
#include <omp.h>
#include <iostream>
#include <cmath>

typedef unsigned long long data_t;

void inner(int start, int end, data_t *data, int threads) {
    if (threads <= 1 || end - start <= 1) {
        std::sort(data + start, data + end);
        return;
    }
    auto pivot = *(data + start);
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
    int firstHalf = mid1 - start;
    int secondHalf = end - mid2;
    int total = firstHalf + secondHalf;
    if (total == 0) {
        return;
    }
    int threads1 = threads * firstHalf / total;
    int threads2 = threads - threads1;
    if (firstHalf > 1) {
        #pragma omp task
        inner(start, mid1, data, threads1);
    }
    if (secondHalf > 1) {
        #pragma omp task
        inner(mid2, end, data, threads2);
    }
}

void psort(int n, data_t *data) {
    const int threads = omp_get_max_threads();
    #pragma omp parallel
    #pragma omp single nowait
    {
        inner(0, n, data, threads);
    }
}
