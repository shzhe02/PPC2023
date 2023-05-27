#include <algorithm>
#include <omp.h>
#include <vector>
#include <cmath>
typedef unsigned long long data_t;
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
void mergePar(int leftStart, int leftEnd, int rightStart, int rightEnd, int outputStart, data_t* in, data_t* out) {
    constexpr int threshold = 1 << 24;
    int lS = leftStart;
    int lE = leftEnd;
    int rS = rightStart;
    int rE = rightEnd;
    int leftLen = leftEnd - leftStart;
    int rightLen = rightEnd - rightStart;
    if (leftLen + rightLen < threshold) {
        std::merge(in + leftStart, in + leftEnd, in + rightStart, in + rightEnd, out + outputStart);
        return;
    } else if (leftLen < rightLen) { // If the left window is smaller than the right window, swap variables (left window always bigger)
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
    int s = binarySearch(rS, rE, in[r], in); // Equivalent middle element in right window
    int t = outputStart + (r - lS) + (s - rS);
    out[t] = in[r];
    #pragma omp parallel
    #pragma omp single
    {
        #pragma omp task
        mergePar(lS, r, rS, s, outputStart, in, out);
        #pragma omp task
        mergePar(r + 1, lE, s, rE, t + 1, in, out);
        #pragma omp taskwait
    }
}
void psort(int n, data_t *data) {
    int threads = omp_get_max_threads();
    if (threads > 1) {
        unsigned int power = static_cast<unsigned int>(log2(threads));
        threads = 1 << power;
    }
    if (n < 2 * threads) {
        std::sort(data, data + n);
        return;
    }
    data_t* aux = (data_t*) malloc(n * sizeof(data_t));
    int elemPerThread = (n + threads - 1) / threads;
    #pragma omp parallel num_threads(threads)
    {
        int thread = omp_get_thread_num();
        int start = thread * elemPerThread;
        if (start < n) {
            std::sort(data + start, data + std::min(n, start + elemPerThread));
        }
    }
    data_t* a = data;
    data_t* b = aux;
    while (threads > 1) {
        threads = (threads + 1) >> 1;
        #pragma omp parallel num_threads(threads)
        {   
            int thread = omp_get_thread_num();
            int start = (thread * elemPerThread) << 1;
            if (start < n) {
                int mid = std::min(n, start + elemPerThread);
                int end = std::min(n, mid + elemPerThread);
                mergePar(start, mid, mid, end, start, a, b);
            }
        }
        data_t* tmp = a;
        a = b;
        b = tmp;
        elemPerThread <<= 1;
    }
    if (a != data) {
        std::copy(a, a + n, data);
    }
    free(aux);
}