#include <algorithm>
#include <omp.h>
#include <cmath>

typedef unsigned long long data_t;

void inner(data_t* start, data_t* end, int depth) {
    if (depth < 1) {
        std::sort(start, end);
        return;
    }
    if (start == end)
        return;
    auto mid = start + (end - start) / 2;
    auto pivot = *mid;
    auto middle1 = std::partition(start, end, [pivot](const auto& em) {
        return em < pivot;
    });
    auto middle2 = std::partition(middle1, end, [pivot](const auto& em) {
        return pivot == em;
    });
    #pragma omp task
    inner(start, middle1, depth - 1);
    #pragma omp task
    inner(middle2, end, depth - 1);
}

void psort(int n, data_t* data) {
    int depth = static_cast<int>(log2(omp_get_max_threads())) + 1;
    #pragma omp parallel
    #pragma omp single
    {
        #pragma omp taskgroup
        {
            #pragma omp taskloop shared(data) grainsize(1) nogroup
            for (int i = 0; i < n; ++i) {
                #pragma omp task
                inner(&data[i], &data[i + 1], depth);
            }
        }
    }
}