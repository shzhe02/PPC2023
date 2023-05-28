#include <cstdlib>
#include <iostream>
#include <cuda_runtime.h>
#include <cmath>
static inline int roundup(int a, int b) {return ((a + b - 1) / b) * b;}
static inline void check(cudaError_t err, const char* context) {
    if (err != cudaSuccess) {
        std::cerr << "CUDA error: " << context << ": " << cudaGetErrorString(err) << std::endl;
        std::exit(EXIT_FAILURE);
    }
}
#define CHECK(x) check(x, #x);
__global__ void preprocessor(float* raw, int ny, int nx, int nny) {
    int thread = threadIdx.x;
    int row = blockIdx.y;
    if (row >= ny) { return; }
    float* processed = raw + nx * ny;
    float mean = 0;
    float rootedSquaredSum = 0;

    for (int i = 0; i < nx; i += 64) {
        int col = i + thread;
        processed[nny * col + row] = (col < nx) ? raw[nx * row + col] : 0;
    }
}
__global__ void kernel(float* out, const float* in, int ny, int nx, int nny) {
    int ia = threadIdx.x;
    int ja = threadIdx.y;
    int ic = blockIdx.x;
    int jc = blockIdx.y;
    if (ic < jc || ic >= ny || jc >= ny){
        return;
    }
    const float* t = in + nx * ny;
    __shared__ float xx[4][64];
    __shared__ float yy[4][64];
    float v[8][8];
    for (int ib = 0; ib < 8; ++ib) {
        for (int jb = 0; jb < 8; ++jb) {
            v[ib][jb] = 0;
        }
    }
    for (int ks = 0; ks < nx; ks += 4) {
        int ija = ja * 8 + ia;
        int i = ic * 64 + ija;
        int j = jc * 64 + ija;
        for (int f = 0; f < 4; f++) {
            int k = ks + f;
            xx[f][ija] = t[nny * k + i];
            yy[f][ija] = t[nny * k + j];
        }
        __syncthreads();
        #pragma unroll
        for (int f = 0; f < 4; ++f) {
            float y[8];
            for (int jb = 0; jb < 8; ++jb) {
                y[jb] = yy[f][jb * 8 + ja];
            }
            for (int ib = 0; ib < 8; ++ib) {
                float x = xx[f][ib * 8 + ia];
                for (int jb = 0; jb < 8; ++jb) {
                    v[ib][jb] += x * y[jb];
                }
            }
        }
        __syncthreads();
    }
    for (int ib = 0; ib < 8; ++ib) {
        for (int jb = 0; jb < 8; ++jb) {
            int i = ic * 64 + ib * 8 + ia;
            int j = jc * 64 + jb * 8 + ja;
            if (i < ny && j < ny) {
                out[ny * j + i] = v[ib][jb];
            }
        }
    }
}
void correlate(int ny, int nx, const float *data, float *result) {

    int nnx = roundup(nx, 64);
    int nny = roundup(ny, 64);

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
    CHECK(cudaMalloc((void**)&inGPU, (nny * nnx + ny * nx) * sizeof(float)));
    CHECK(cudaMalloc((void**)&outGPU, nny * nny * sizeof(float)));
    CHECK(cudaMemcpy(inGPU, input, ny * nx * sizeof(float), cudaMemcpyHostToDevice)); // Move input to GPU
    free(input);
    { // Preprocessing
        dim3 dimBlock(64, 1);
        dim3 dimGrid(1, nny);
        preprocessor<<<dimGrid, dimBlock>>>(inGPU, ny, nx, nny);
        CHECK(cudaGetLastError());
    }
    { // Compute
        dim3 dimBlock(8, 8);
        dim3 dimGrid(nny / 64, nny / 64);
        CHECK(cudaMemset(outGPU, 0, nny * nny * sizeof(float)));
        kernel<<<dimGrid, dimBlock>>>(outGPU, inGPU, ny, nx, nny);
        CHECK(cudaGetLastError());
    }
    CHECK(cudaMemcpy(result, outGPU, ny * ny * sizeof(float), cudaMemcpyDeviceToHost)); // Bring back output from GPU
    CHECK(cudaFree(inGPU)); // Cleanup
    CHECK(cudaFree(outGPU));
}