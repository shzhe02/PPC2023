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

__global__ void preprocessor(const float* raw, float* processed, int ny, int nx, int nnx) {
    int thread = threadIdx.x;
    int block = blockIdx.y;

    for (int i = 0; i < nnx; i += 64) {
        int j = i + thread;
        processed[nnx * block + j] = (block < ny && j < nx) ? raw[nx * i + j] : 0;
    }
}

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

    int nnx = roundup(nx, 64);
    int nny = roundup(ny, 64);

    float* input = (float*) malloc(nny * nnx * sizeof(float));
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
    float* rawGPU = NULL;
    float* inGPU = NULL; // Initialize buffers
    float* outGPU = NULL;
    CHECK(cudaMalloc((void**)&rawGPU, ny * nx * sizeof(float)));
    CHECK(cudaMalloc((void**)&inGPU, nny * nnx * sizeof(float)));
    CHECK(cudaMalloc((void**)&outGPU, nny * nny * sizeof(float)));
    CHECK(cudaMemcpy(rawGPU, input, ny * nx * sizeof(float), cudaMemcpyHostToDevice)); // Move input to GPU

    { // Preprocessing
        dim3 dimBlock(64, 1);
        dim3 dimGrid(1, nny);
        preprocessor<<<dimGrid, dimBlock>>>(rawGpu, inGpu, ny, nx, nnx);
    }

    {
        dim3 dimBlock(8, 8);
        dim3 dimGrid(nnx / 64, nny / 64);
        
    }
    
    dim3 dimBlock(16, 16); // Kernel preparation
    dim3 dimGrid(divup(ny, dimBlock.x), divup(ny, dimBlock.y));

    CHECK(cudaMemset(outGPU, 0, nny * nny * sizeof(float)));
    kernel<<<dimGrid, dimBlock>>>(outGPU, inGPU, ny, nx); // Run kernel
    CHECK(cudaGetLastError());
    CHECK(cudaMemcpy(result, outGPU, ny * ny * sizeof(float), cudaMemcpyDeviceToHost)); // Bring back output from GPU
    CHECK(cudaFree(inGPU)); // Cleanup
    CHECK(cudaFree(outGPU));
    free(input);
}