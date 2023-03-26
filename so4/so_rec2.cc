#include <algorithm>
#include <vector>
typedef unsigned long long data_t;
void inner(int n, data_t* data, data_t* aux) {
    constexpr int threshold = 1 << 13;
    int midpoint = n / 2;
    if (n > threshold) { // Splitting/Sorting stage
        #pragma omp parallel
        #pragma omp single
        {
            #pragma omp task
            inner(midpoint, data, aux);
            #pragma omp task
            inner(n - midpoint, data + midpoint, aux + midpoint);
        }
    } else {
        std::sort(data, data + n);
        return;
    }
    int cursorA = 0; // Merging stage
    int cursorB = midpoint;
    int outputCursor = 0;
    while (cursorA < midpoint && cursorB < n) {
        data_t elemA = data[cursorA];
        data_t elemB = data[cursorB];
        if (elemA > elemB) {
            aux[outputCursor] = elemB;
            cursorB++;
            outputCursor++;
        } else {
            aux[outputCursor] = elemA;
            cursorA++;
            outputCursor++;
        }
    }
    for(; cursorA < midpoint; ++cursorA, ++outputCursor) {
        aux[outputCursor] = data[cursorA];
    }
    for(; cursorB < n; ++cursorB, ++outputCursor) {
        aux[outputCursor] = data[cursorB];
    }
    std::copy(aux, aux + n, data);
}
void psort(int n, data_t *data) {
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    inner(n, data, aux);
    free(aux);
}