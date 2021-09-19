#include "../include/ntt.h"

/**
 * Perform the operation 'base^exp (mod m)' using the memory-efficient method
 *
 * @param base	The base of the expression
 * @param exp	The exponent of the expression
 * @param m	The modulus of the expression
 * @return 	The result of the expression
 */
#pragma hls_design inline
inline DATA_TYPE modulo_add(DATA_TYPE base, DATA_TYPE m){
	return base > m? (DATA_TYPE)(base - m) : base;

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
inline DATA_TYPE modulo_sub(DATA_TYPE_SIGNED base, DATA_TYPE m){
	return base < 0? (DATA_TYPE)(base + m) : base;

}

#include <iostream>
 
void stockham_dit(DATA_TYPE * xt, DATA_TYPE p, DATA_TYPE * twiddle, DATA_TYPE * twiddle_h){

    DATA_TYPE yt[VECTOR_SIZE];
    DATA_TYPE * x = xt;
    DATA_TYPE * y = yt;
    DATA_TYPE *tmp = x;
    x = y;
    y = tmp;
    PARAMS_TYPE s = VECTOR_SIZE >> 1;
    PARAMS_TYPE shift = VECTOR_ADDR_BIT - 1;
    for(PARAMS_TYPE nn = 2; nn <= VECTOR_SIZE; nn = nn << 1, s = s >> 1, shift = shift - 1){
        PARAMS_TYPE m = nn >> 1;
        std::cout<<"Stage "<<nn<<std::endl;
        for (int t = 0; t < (VECTOR_SIZE >> 1); t++) {
                    const PARAMS_TYPE upper = (~(s - 1)) & t;
                    DATA_TYPE w = twiddle[(upper >> shift) << shift];
                    DATA_TYPE wh = twiddle_h[(upper >> shift) << shift];
                    const PARAMS_TYPE q     = (s - 1) & t;
                    const DATA_TYPE a = y[q + (upper << 1)];
                    const DATA_TYPE b = mult(y[q + (upper << 1) + s] , w, wh, p);
                    x[q + upper] = modulo_add(a + b, p);
                    x[q + upper + s * m] = modulo_sub(a - b, p);
                    std::cout<<q+upper<<" "<<q+upper +s*m<<std::endl;
        }
        DATA_TYPE *tmp = x;
        x = y;
        y = tmp;
    }   
    if(VECTOR_ADDR_BIT % 2){
        for(int i=0; i < VECTOR_SIZE; i++)
            xt[i] = y[i];
    }
}