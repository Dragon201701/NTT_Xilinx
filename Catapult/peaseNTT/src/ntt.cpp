#include "../include/ntt.h"
#include "../include/utils.h"
#include "../include/config.h"

using namespace std;

/**
 * Perform the operation 'base (mod m)'
 *
 * @param base	The base of the expression
 * @param m	The modulus of the expression
 * @return 	The result of the expression
 */
#pragma hls_design inline
UINT64_T modulo_dev(INT64_T base, UINT64_T m){

	INT64_T result = base % m;

	return (result >= 0) ? (UINT64_T)result : (UINT64_T)(result + m);

}

/**
 * Perform the operation 'base^exp (mod m)' using the memory-efficient method
 *
 * @param base	The base of the expression
 * @param exp	The exponent of the expression
 * @param m	The modulus of the expression
 * @return 	The result of the expression
 */
#pragma hls_design inline
UINT64_T modExp_dev(UINT64_T base, UINT64_T exp, UINT64_T m){
    
	UINT64_T result = 1;

	MODEXP_WHILE: while(exp > 0){

        result = (UINT64_T)(result * base);

        result = modulo_dev(result, m);

		exp--;

	}

	return result;

}

/**
 * Copy from src array to dst array
 *
 * @param src The source array
 * @param dst The destination array
 */
#pragma hls_design inline
void cpyVec_dev(UINT64_T src[VECTOR_SIZE], UINT64_T dst[VECTOR_SIZE] ){

    COPY_LOOP: for(int i = 0; i < VECTOR_SIZE; i++){

        dst[i] = src[i];

    }

}

#pragma hls_design top
void peaceNTT(UINT64_T vec[VECTOR_SIZE], UINT64_T p, UINT64_T g, UINT64_T result[VECTOR_SIZE] ){
    /*
         Calculate Twiddle Factors array
    */
    UINT64_T twiddle[VECTOR_SIZE];

    UINT64_T w0 = modExp_dev(g, (p - 1) / VECTOR_ADDR_BIT, p), witer = 1;

    TWIDDLE_LOOP: for(int i = 0; i < VECTOR_ADDR_BIT; i++){

        twiddle[i] = witer;

        witer = modulo_dev(witer * w0, p);

    }

    /*
        Initialize parameters
    */
    UINT64_T t = VECTOR_ADDR_BIT, r_strt = 0, r_end  = VECTOR_SIZE / 2;

    UINT64_T xt[VECTOR_SIZE] ;

    cpyVec_dev(vec, xt);

    UINT64_T base = VECTOR_SIZE;

    unsigned mid = VECTOR_SIZE / 2;

    STAGE_LOOP: for (unsigned c = t; c >= 1; c--){
        unsigned base = base / 2;

        COMP_LOOP: for (unsigned r = r_strt; r < r_end; r++){

            unsigned r1 = r / base;

            UINT64_T f1 = xt[r << 1];

            UINT64_T f2 = modulo_dev(twiddle[r1 * (1 << (c - 1))] * xt[r << 1 + 1], p);

            result[r]       = modulo_dev(f1 + f2, p);

            result[r + mid]  = modulo_dev(f1 - f2, p);

        }

        cpyVec_dev(result, xt);

#ifndef __SYNTHESIS__
        cout<<"Device Complte stage: "<<c<<" computation.\n";
#endif
    }
}
