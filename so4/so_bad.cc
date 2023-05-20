#include <algorithm>
typedef unsigned long long data_t;
// Note: I replaced a bunch of divisions by 2 into bitshift right by 1. Does the same thing, just faster (I hope).
int binarySearch(int start, int end, data_t target, data_t* data) {
    int left = start;
    int right = end - 1;
    while (left <= right) {
        int mid = (left + right) >> 1; // Bitshift used here instead of dividing by 2
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
    constexpr int threshold = 1 << 10;
    int lS = leftStart;
    int lE = leftEnd;
    int rS = rightStart;
    int rE = rightEnd;
    int leftLen = leftEnd - leftStart;
    int rightLen = rightEnd - rightStart;
    if ( true /*leftLen + rightLen < threshold*/) {
        std::merge(data + leftStart, data + leftEnd, data + rightStart, data + rightEnd, aux + outputStart);
    } else {
        if (leftLen < rightLen) { // If the left window is smaller than the right window, swap variables (left window always bigger)
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
        int r = (lS + lE) >> 1; // Midpoint of left window. Bitshift used here instead of dividing by 2
        int s = binarySearch(rS, rE, data[r], data); // Equivalent middle element in right window
        int t = outputStart + (r - lS) + (s - rS);
        aux[t] = data[r];

        #pragma omp parallel
        #pragma omp single
        {
            #pragma omp task
            mergePar(lS, r, rS, s, outputStart, data, aux);
            #pragma omp task
            mergePar(r + 1, lE, s, rE, t + 1, data, aux);
        }
    }
}

void inner(int left, int right, data_t* data, data_t* aux) { // right is exclusive
    constexpr int threshold = 1 << 9; // 9 is ideal
    int midpoint = (left + right) >> 1; // Bitshift used here instead of dividing by 2
    if (right - left > threshold) { // Splitting/Sorting stage
        #pragma omp parallel
        #pragma omp single
        {
            #pragma omp task
            inner(left, midpoint, data, aux);
            #pragma omp task
            inner(midpoint, right, data, aux);
        }
        mergePar(left, midpoint, midpoint, right, left, data, aux);
        std::copy(aux + left, aux + right, data + left);
    } else {
        std::sort(data + left, data + right);
        return;
    }
}

void psort(int n, data_t *data) {
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    inner(0, n, data, aux);
    // std::sort(data, data + n);
    free(aux);
}