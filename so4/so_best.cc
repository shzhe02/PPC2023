#include <algorithm>
#include <omp.h>
typedef unsigned long long data_t;
void psort(int n, data_t *data) {
    int threads = omp_get_max_threads();
    if (n < threads) {
        std::sort(data, data + n);
        return;
    }
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    int elemPerThread = (n + threads - 1) / threads;
    #pragma omp parallel num_threads(threads)
    {
        int thread = omp_get_thread_num();
        std::sort(data + std::min(n, thread * elemPerThread), data + std::min(n, (thread + 1) * elemPerThread));
    }
    threads = (threads + 1) >> 1;
    data_t* a = data;
    data_t* b = aux;
    while (true) {
        #pragma omp parallel num_threads(threads)
        {   
            int thread = omp_get_thread_num();
            int start = (thread * elemPerThread) << 1;
            if (start < n) {
                int mid = std::min(n, start + elemPerThread);
                int end = std::min(n, ((thread + 1) << 1) * elemPerThread);
                std::merge(a + start, a + mid, a + mid, a + end, b + start);
            }
        }
        data_t* tmp = a;
        a = b;
        b = tmp;
        if (threads == 1) {
            break;
        }
        threads = (threads + 1) >> 1;
        elemPerThread <<= 1;
    }
    if (a != data) {
        std::copy(a, a + n, data);
    }
    free(aux);
}