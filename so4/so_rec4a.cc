#include <algorithm>
#include <cstdlib>
#include <omp.h>
typedef unsigned long long data_t;
int binarySearch(int start, int end, data_t target, data_t* data) {
    int left = start;
    int right = end - 2;
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
void merge(int leftStart, int leftEnd, int rightStart, int rightEnd, int outputStart, data_t* data, data_t* aux) { // ends are exclusive
    constexpr int threshold = 1 << 1;
    if (leftEnd - leftStart + rightEnd - rightStart > threshold) {
        int mid1 = (leftStart + leftEnd) / 2;
        int mid2 = binarySearch(rightStart, rightEnd, data[mid1], data);
        #pragma omp parallel
        #pragma omp single
        {
            #pragma omp task
            merge(leftStart, mid1, rightStart, mid2, leftStart, data, aux);
            #pragma omp task
            merge(mid1, leftEnd, mid2, rightEnd, mid1 + mid2 - rightStart, data, aux);
        }
        return;
    }
    int leftCursor = leftStart, rightCursor = rightStart, outputCursor = outputStart;
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
    constexpr int threshold = 1 << 2; // Change to 13 for final
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