#include <algorithm>
#include <omp.h>
#include <iostream>
typedef unsigned long long data_t;

void psort(int n, data_t *data) {
    int threads = omp_get_max_threads();
    if (n < threads) {
        std::sort(data, data + n);
        return;
    }
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    int elemPerThread = (n + threads - 1) / threads;
    std::cout << "Number of elements per thread: " << elemPerThread << std::endl;
    #pragma omp parallel num_threads(threads)
    {
        int thread = omp_get_thread_num();
        std::sort(data + std::min(n, thread * elemPerThread), data + std::min(n, (thread + 1) * elemPerThread));
        #pragma omp critical
        {
            std::cout << "Thread " << thread << ": start = "  << std::min(n, thread * elemPerThread) << ", end = " <<std::min(n, (thread + 1) * elemPerThread) << std::endl;
        }
    }
    std::cout << "---" << std::endl;
    std::cout << "n = " << n << std::endl;
    std::cout << "Post-sorting" << std::endl;
    for (int i = 0; i < n; ++i) {
        std::cout << data[i] << " ";   
    }
    std::cout << std::endl;
    std::cout << "Threads total: " << threads << std::endl;
    // Stage 2: Merge stuff
    threads = (threads + 1) / 2;
    data_t* a = data;
    data_t* b = aux;
    while (true) {
        std::cout << "---" << std::endl;
        std::cout << "Threads for merging: " << threads << std::endl;
        std::cout << "Number of elements per thread: " << elemPerThread * 2 << std::endl;
        #pragma omp parallel num_threads(threads)
        {   
            int thread = omp_get_thread_num();
            int start = std::min(n, thread * elemPerThread * 2);
            int mid = std::min(n, start + elemPerThread);
            int end = std::min(n, (thread + 1) * 2 * elemPerThread);
            #pragma omp critical
            {
                std::cout << "Thread " << thread << ": start = " << start << ", mid = " << mid << ", end = " << end << std::endl;
                std::merge(a + start, a + mid, a + mid, a + end, b + start);
                for (int i = 0; i < n; ++i) {
                    int elem = b[i];
                    if (elem > 100) {
                        std::cout << b[i] << " ";   
                    }
                }
                std::cout << std::endl;
            }
        }
        data_t* tmp = a;
        a = b;
        b = tmp;
        if (threads == 1) {
            break;
        }
        threads = (threads + 1) / 2;
        elemPerThread <<= 1;
    }
    if (a != data) {
        std::copy(a, a + n, data);
    }
    free(aux);
}