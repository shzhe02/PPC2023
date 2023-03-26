#include <algorithm>
#include <vector>
#include <mutex>
#include <chrono>
#include <iostream>

std::once_flag flag;
auto start = std::chrono::high_resolution_clock::now();

typedef unsigned long long data_t;
int binarySearch(data_t target, int start, int end, data_t* data) {
    int left = start;
    int right = end;
    while (left <= right) {
        int mid = (left + right) / 2;
        if (data[mid] == target) {
            return mid;
        } else if (data[mid] < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return left;
}
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
    std::call_once(flag, [](){
        auto end = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
        std::cout << "Split and sorted: " << duration.count() << " microseconds" << std::endl;
    });
    // int mid1 = midpoint / 2; // Midpoint of the first half
    // int midElem = data[mid1];
    // int mid2 = binarySearch(midElem, n - midpoint, n, data);
    // int mid3 = mid1 + mid2;
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
} // TODO: Improve merging by recursively splitting to a threshold.
void psort(int n, data_t *data) {
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    inner(n, data, aux);
    free(aux);
    auto end = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(end - start);
    std::cout << "Merged: " << duration.count() << " microseconds" << std::endl;
}