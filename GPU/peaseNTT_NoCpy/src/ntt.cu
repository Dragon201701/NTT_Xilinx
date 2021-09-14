#include "../include/ntt.h"
#include "../include/utils.h"
#include <inttypes.h>
using namespace std;

void cpyVec(DATA_TYPE* src, DATA_TYPE*dst, int length){
    for(int i=0; i<length; i++){
        dst[i] = src[i];
    }
}
__device__ void modulo_cu(int64_t base, int64_t m, DATA_TYPE &a){
	int64_t result = base % m;
	a = result >= 0? result : result + m;
}

__device__ void modExp_cu(DATA_TYPE base, unsigned exp, DATA_TYPE m, DATA_TYPE &a){

	DATA_TYPE result = 1;
	
	while(exp > 0){

		if(exp % 2){

			modulo_cu(result*base, m, result);

		}

		exp = exp >> 1;
		modulo_cu(base*base,m,base);
	}

    a = result;
}


__global__ void butter_prec(DATA_TYPE *yt, DATA_TYPE *xt, DATA_TYPE *twiddle, unsigned base, DATA_TYPE p) {
    int r = blockIdx.x * blockDim.x + threadIdx.x;
    int mid = VECTOR_SIZE >> 1;
    if(r < mid){
        DATA_TYPE f1 = xt[r<<1];
        DATA_TYPE f2 ;
        modulo_cu(twiddle[r & base]* xt[(r<<1) + 1], p, f2);
        modulo_cu(f1 + f2, p, yt[r]);
        modulo_cu(f1 - f2, p, yt[r + mid]);
    }
}

__global__ void  bit_reverse_cu(DATA_TYPE *result, DATA_TYPE *vec, unsigned num_bits){
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if(i < VECTOR_SIZE){
		unsigned reverse_num = 0;
		for(unsigned j = 0; j < num_bits; j++){
			reverse_num = reverse_num << 1;
			if(i & (1 << j)){
				reverse_num = reverse_num | 1;
			}
		}
		result[reverse_num] = vec[i];
    }
}

// GPU Mem pointer
DATA_TYPE* d_x ;
DATA_TYPE* d_y ;
DATA_TYPE* d_twiddle ;
// CPU Mem pointer
DATA_TYPE *result ;

void cudaPrepare(int n, DATA_TYPE p, DATA_TYPE g){
    cudaDeviceProp myCuda;
    cudaGetDeviceProperties(&myCuda, 0);
    cout<<"Cuda Name : "<<myCuda.name<<endl;
    size_t freeMem, totalMem;
    cudaMemGetInfo(&freeMem, &totalMem);
    cout<<"Cuda FreeMemory is" << freeMem<<" ; Total Memory is "<<totalMem<<endl;
    DATA_TYPE * twiddle = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
    DATA_TYPE w0 = modExp(g, (p - 1) / n, p);
    DATA_TYPE witer = 1;
    for(int i = 0; i < n; i++){
        twiddle[i] = witer;
        witer = modulo(witer * w0, p);
    }
    cudaMalloc(&d_x, VECTOR_SIZE * sizeof(DATA_TYPE ));
    cudaMalloc(&d_y, VECTOR_SIZE * sizeof(DATA_TYPE ));
    cudaMalloc(&d_twiddle, VECTOR_SIZE * sizeof(DATA_TYPE ));
    cudaMemcpy(d_twiddle, twiddle, VECTOR_SIZE * sizeof(DATA_TYPE ), cudaMemcpyHostToDevice);
	result = (DATA_TYPE*) malloc((int)n*sizeof(DATA_TYPE));
}

void cudaFree(){
    cudaFree(&d_twiddle);
    free(result);
    cudaFree(&d_x);
    cudaFree(&d_y);
}

DATA_TYPE* peaseNTT(DATA_TYPE * vec,  int n, DATA_TYPE p, DATA_TYPE g){

    unsigned t = (unsigned)log2(n);

    cudaMemcpy(d_y, vec, VECTOR_SIZE * sizeof(DATA_TYPE ), cudaMemcpyHostToDevice);
    int threadsPerBlock = 256;
    int blocksPerGrid = ((VECTOR_SIZE>>1) + threadsPerBlock - 1) / threadsPerBlock;

    int threadsPerBlockRev = 256;
    int blocksPerGridRev = (VECTOR_SIZE + threadsPerBlock - 1) / threadsPerBlock;

    bit_reverse_cu<<<blocksPerGridRev, threadsPerBlockRev>>>(d_x, d_y, t);
    cudaMemcpy(result, d_x, VECTOR_SIZE * sizeof(DATA_TYPE ), cudaMemcpyDeviceToHost);

    for (unsigned c = t; c >= 2; c -= 2){
        unsigned base = -1 << (c - 1);
        butter_prec<<<blocksPerGrid, threadsPerBlock>>>(d_y, d_x, d_twiddle, base, p);
        //cudaMemcpy(d_x, d_y, VECTOR_SIZE * sizeof(DATA_TYPE), cudaMemcpyDeviceToDevice);
        base = -1 << (c - 2);
        butter_prec<<<blocksPerGrid, threadsPerBlock>>>(d_x, d_y, d_twiddle, base, p);
    }

    cudaMemcpy(result, d_y, VECTOR_SIZE * sizeof(DATA_TYPE ), cudaMemcpyDeviceToHost);

    return result;
}