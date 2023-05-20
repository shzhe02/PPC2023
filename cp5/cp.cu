#include <cstdlib>
#include <iostream>
#include <cuda_runtime.h>
#include <cmath>
static inline int divup(int a, int b) {return (a + b - 1)/b;}
static inline int roundup(int a, int b) {return divup(a, b) * b;}
static inline void check(cudaError_t err, const char* context) {
    if (err != cudaSuccess) {
        std::cerr << "CUDA error: " << context << ": " << cudaGetErrorString(err) << std::endl;
        std::exit(EXIT_FAILURE);
    }
}
#define CHECK(x) check(x, #x)
// __global__ void preprocessor(int ny, int nx, int nn, const float* originalData, const float* processedData) {
//     int ti = threadIdx.x;
//     int bi = blockIdx.y;
// }
__global__ void kernel(float* out, const float* input, int ny, int nx) {
    int col = threadIdx.x + blockIdx.x * blockDim.x; // handling i, aka innerRow
    int row = threadIdx.y + blockIdx.y * blockDim.y; // handling j, aka outerRow
    if (row > col || row >= ny || col >= ny) {return;}
    else if (row == col) {
        out[col + row * ny] = 1;
        return;
    }
    float sum = 0;
    for (int n = 0; n < nx; ++n) {
        sum += input[n + col * nx] * input[n + row * nx];
    }
    out[col + row * ny] = sum;
}
void correlate(int ny, int nx, const float *data, float *result) {
    float* input = (float*) malloc(ny * nx * sizeof(float));
    for (int row = 0; row < ny; ++row) { // Getting the normalized input matrix
        float mean = 0; // Get the mean of the column
        float rootedSquaredSum = 0;
        for (int col = 0; col < nx; ++col) {
            mean += data[col + nx * row];
        }
        mean /= nx;
        for (int col = 0; col < nx; ++col) { // Get squared sum of the row
            float diff = data[col + nx * row] - mean;
            rootedSquaredSum += diff * diff;
            input[col + nx * row] = diff;
        }
        rootedSquaredSum = sqrt(rootedSquaredSum);
        for (int col = 0; col < nx; ++col) { // Normalize inputs
            input[col + nx * row] /= rootedSquaredSum;
        }
    }
    float* inGPU = NULL; // Initialize buffers
    float* outGPU = NULL;
    CHECK(cudaMalloc((void**)&inGPU, ny * nx * sizeof(float)));
    CHECK(cudaMalloc((void**)&outGPU, ny * ny * sizeof(float)));
    CHECK(cudaMemcpy(inGPU, input, ny * nx * sizeof(float), cudaMemcpyHostToDevice)); // Move input to GPU
    dim3 dimBlock(16, 16); // Kernel preparation
    dim3 dimGrid(divup(ny, dimBlock.x), divup(ny, dimBlock.y));
    CHECK(cudaMemset(outGPU, 0, ny * ny * sizeof(float)));
    kernel<<<dimGrid, dimBlock>>>(outGPU, inGPU, ny, nx); // Run kernel
    CHECK(cudaGetLastError());
    CHECK(cudaMemcpy(result, outGPU, ny * ny * sizeof(float), cudaMemcpyDeviceToHost)); // Bring back output from GPU
    CHECK(cudaFree(inGPU)); // Cleanup
    CHECK(cudaFree(outGPU));
    free(input);
}