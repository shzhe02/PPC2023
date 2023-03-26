#include <algorithm>
#include <iostream>
typedef unsigned long long data_t;
int binarySearch(int start, int end, data_t target, data_t* data) {
    int left = start;
    int right = end - 1;
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
    int leftCursor = leftStart, rightCursor = rightStart, outputCursor = outputStart;
    while (leftCursor < leftEnd && rightCursor < rightEnd) {
        data_t elemA = data[leftCursor], elemB = data[rightCursor];
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
}
void mergePar(int start, int mid, int end, data_t* data, data_t* aux) {
    int increment = 1 << 16;
    int sections = (mid - start - 1) / increment;
    int leftBreaks[sections + 2];
    int rightBreaks[sections + 2];
    leftBreaks[0] = start;
    rightBreaks[0] = mid;
    leftBreaks[sections + 1] = mid;
    rightBreaks[sections + 1] = end;
    #pragma omp parallel for // Calculating breaks
    for (int i = 1; i <= sections; ++i) {
        int leftBreak = start + i * increment;
        leftBreaks[i] = leftBreak;
        rightBreaks[i] = binarySearch(mid, end, data[leftBreak], data);
    }
    #pragma omp parallel for schedule(static,1)
    for (int i = 0; i <= sections; ++i) {
        merge(leftBreaks[i], leftBreaks[i + 1], rightBreaks[i], rightBreaks[i + 1], leftBreaks[i] + rightBreaks[i] - mid, data, aux);
    }
    std::copy(aux + start, aux + end, data + start);
}
void inner(int left, int right, data_t* data, data_t* aux) { // right is exclusive
    constexpr int threshold = 1 << 25; // Change to 13 for final
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
        // inner(left, midpoint, data, aux);
        // inner(midpoint, right, data, aux);
    } else {
        std::sort(data + left, data + right);
        return;
    }
    mergePar(left, midpoint, right, data, aux);
}
void psort(int n, data_t *data) {
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    inner(0, n, data, aux);
    free(aux);
}