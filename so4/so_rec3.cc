#include <algorithm>
#include <cstdlib>
#include <omp.h>
typedef unsigned long long data_t;
void merge(int leftStart, int leftEnd, int rightStart, int rightEnd, int outputStart, data_t* data, data_t* aux) { // ends are exclusive
    int leftCursor = leftStart;
    int rightCursor = rightStart;
    int outputCursor = outputStart;
    while (leftCursor < leftEnd && rightCursor < rightEnd) {
        data_t elemA = data[leftCursor];
        data_t elemB = data[rightCursor];
        if (elemA < elemB) {
            aux[outputCursor++] = elemA;
            ++leftCursor;
        } else {
            aux[outputCursor++] = elemB;
            ++rightCursor;
        }
    }
    while (leftCursor < leftEnd) { aux[outputCursor++] = data[leftCursor++]; }
    while (rightCursor < rightEnd) { aux[outputCursor++] = data[rightCursor++]; }
    std::copy(aux + outputStart, aux + outputCursor, data + outputStart);
}
void inner(int left, int right, data_t* data, data_t* aux) { // right is exclusive
    constexpr int threshold = 1 << 13; // Change to 13 for final
    int midpoint = (left + right) / 2;
    if (right - left > threshold) { // Splitting/Sorting stage
        #pragma omp parallel
        #pragma omp single
        {
            #pragma omp task
            inner(left, midpoint, data, aux);
            #pragma omp task
            inner(midpoint, right, data, aux);
        }
    } else {
        std::sort(data + left, data + right);
        return;
    }
    merge(left, midpoint, midpoint, right, left, data, aux);
}
void psort(int n, data_t *data) {
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    inner(0, n, data, aux);
    free(aux);
}