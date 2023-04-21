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
void mergePar(int leftStart, int leftEnd, int rightStart, int rightEnd, int outputStart, data_t* data, data_t* aux) {
    int lS = leftStart;
    int lE = leftEnd;
    int rS = rightStart;
    int rE = rightEnd;
    int leftLen = leftEnd - leftStart;
    int rightLen = rightEnd - rightStart;
    if (leftLen < rightLen) {
        int tmpS = lS;
        int tmpE = lE;
        lS = rS;
        lE = rE;
        rS = tmpS;
        rE = tmpE;
        int tmpLen = leftLen;
        leftLen = rightLen;
        rightLen = tmpLen;
    }
    if (leftLen <= 0) {
        return;
    }
    int r = (lS + lE) / 2;
    int s = binarySearch(rS, rE, data[r], data);
    int t = outputStart + (r - lS) + (s - rS);
    aux[outputStart] = data[r];

    #pragma omp parallel
    #pragma omp single
    {
        #pragma omp task
        mergePar(lS, r, rS, s, outputStart, data, aux);
        #pragma omp task
        mergePar(r + 1, lE, s, rE, t + 1, data, aux);
    }
    
    std::copy(aux + outputStart, aux + outputStart + leftLen + rightLen, data + outputStart);
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
    mergePar(left, midpoint, midpoint, right, left, data, aux);
}
void psort(int n, data_t *data) {
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    inner(0, n, data, aux);
    free(aux);
}