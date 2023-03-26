#include <algorithm>
#include <iostream>
typedef unsigned long long data_t;
void psort(int n, data_t *data) {
    constexpr int threshold = 1 << 13;
    int midpoint = n / 2;
    if (n > threshold) { // Splitting/Sorting stage
        #pragma omp parallel
        #pragma omp single
        {
            #pragma omp task
            psort(midpoint, data);
            #pragma omp task
            psort(n - midpoint, data + midpoint);
        }
    } else {
        std::sort(data, data + n);
        return;
    }
    data_t* merged = (data_t*) malloc(n * sizeof(data_t)); // Merging stage
    int cursorA = 0;
    int cursorB = midpoint;
    int outputCursor = 0;
    while (cursorA < midpoint && cursorB < n) {
        data_t elemA = data[cursorA];
        data_t elemB = data[cursorB];
        if (elemA > elemB) {
            merged[outputCursor] = elemB;
            cursorB++;
            outputCursor++;
        } else {
            merged[outputCursor] = elemA;
            cursorA++;
            outputCursor++;
        }
    }
    for(; cursorA < midpoint; ++cursorA, ++outputCursor) {
        merged[outputCursor] = data[cursorA];
    }
    for(; cursorB < n; ++cursorB, ++outputCursor) {
        merged[outputCursor] = data[cursorB];
    }
    std::copy(merged, merged + n, data);
    free(merged);
}