#include <cstdlib>
#include <iostream>
#include <cuda_runtime.h>
#include <cmath>
static inline int divup(int a, int b) {return (a + b - 1)/b;}
static inline void check(cudaError_t err, const char* context) {
    if (err != cudaSuccess) {
        std::cerr << "CUDA error: " << context << ": "
            << cudaGetErrorString(err) << std::endl;
        std::exit(EXIT_FAILURE);
    }
}
#define CHECK(x) check(x, #x)
__global__ void kernel(float* out, const float* in, int ny, int nx, const double* prep) {
    int col = threadIdx.x + blockIdx.x * blockDim.x; // handling i, aka innerRow
    int row = threadIdx.y + blockIdx.y * blockDim.y; // handling j, aka outerRow
    if (row > col || row >= ny || col >= ny) {
        return;
    }
    if (row == col) {
        out[col + row * ny] = 1;
        return;
    }
    double sumIJ = 0;
    for (int n = 0; n < nx; ++n) {
        sumIJ += double(in[n + col * nx]) * in[n + row * nx];
    }
    out[col + row * ny] = (sumIJ * nx - prep[col] * prep[row]) 
        / sqrt((prep[col + ny] * nx - prep[col] * prep[col]) * (prep[row + ny] * nx - prep[row] * prep[row]));
}
void correlate(int ny, int nx, const float *data, float *result) {
    double prep[2*ny]; // Precalculating the sums and squared sums per row
    for (int r = 0; r < ny; ++r) {
        prep[r] = 0.0;
        prep[r + ny] = 0.0;
        for (int c = 0; c < nx; ++c) {
            prep[r] += double(data[c + r * nx]);
            prep[r + ny] += double(data[c + r * nx]) * data[c + r * nx];
        }
    }
    double* prepGPU = NULL; // Intialize GPU buffers
    CHECK(cudaMalloc((void**)&prepGPU, 2 * ny * sizeof(double)));
    float* inGPU = NULL; 
    CHECK(cudaMalloc((void**)&inGPU, ny * nx * sizeof(float)));
    float* outGPU = NULL;
    CHECK(cudaMalloc((void**)&outGPU, ny * ny * sizeof(float)));
    CHECK(cudaMemcpy(inGPU, data, ny * nx * sizeof(float), cudaMemcpyHostToDevice)); // Move input to GPU
    CHECK(cudaMemcpy(prepGPU, prep, 2 * ny * sizeof(double), cudaMemcpyHostToDevice));
    dim3 dimBlock(16, 16); // Kernel preparation
    dim3 dimGrid(divup(ny, dimBlock.x), divup(ny, dimBlock.y));
    CHECK(cudaMemset(outGPU, 0, ny * ny * sizeof(float)));
    kernel<<<dimGrid, dimBlock>>>(outGPU, inGPU, ny, nx, prepGPU); // Run kernel
    CHECK(cudaGetLastError());
    CHECK(cudaMemcpy(result, outGPU, ny * ny * sizeof(float), cudaMemcpyDeviceToHost)); // Bring back output from GPU
    CHECK(cudaFree(inGPU)); // Cleanup
    CHECK(cudaFree(outGPU));
    CHECK(cudaFree(prepGPU));
}