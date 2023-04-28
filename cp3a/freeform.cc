#include <new>
#include <immintrin.h>
#include <iostream>
typedef double double8_t __attribute__ ((vector_size (8 * sizeof(double))));
static inline double8_t swap4(double8_t x) { return _mm512_permutex_pd(x, 0b00000001); }
static inline double8_t swap2(double8_t x) { return _mm512_permute_pd(x, 0b01001110); }
static inline double8_t swap1(double8_t x) { return _mm512_permute_pd(x, 0b10110001); }

int main() {
    double8_t vec{1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0};
    double8_t vec2 = swap4(vec);
    for (int i = 0; i < 8; ++i) {
        std::cout << vec2[i] << " ";
    }
    return 0;
}