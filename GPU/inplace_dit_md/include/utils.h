#ifndef UTILS_H
#define UTILS_H

#include <cstdint> 	/* int64_t, DATA_TYPE */
#include <cstdlib>	/* RAND_MAX */
#include <cmath>		/* log2() */
#include <ctime>		/* time() */
#include <iostream> 		/* std::cout, std::endl */

typedef uint64_t DATA_TYPE;

/**
 * Return vector with each element of the input at its bit-reversed position
 *
 * @param vec The vector to bit reverse
 * @param n   The length of the vector, must be a power of two
 * @return    The bit reversed vector
 */
DATA_TYPE *bit_reverse(DATA_TYPE *result, DATA_TYPE *vec, DATA_TYPE n);

/**
 * Compare two vectors element-wise and return whether they are equivalent
 *
 * @param vec1	The first vector to compare
 * @param vec2 	The second vector to compare
 * @param n 	The length of the vectors
 * @param debug	Whether to print debug information (will run entire vector)
 * @return 	Whether the two vectors are element-wise equivalent
 */
bool compVec(DATA_TYPE *vec1, DATA_TYPE *vec2, DATA_TYPE n, bool debug=false);

/**
 * Perform the operation 'base^exp (mod m)' using the memory-efficient method
 *
 * @param base	The base of the expression
 * @param exp	The exponent of the expression
 * @param m	The modulus of the expression
 * @return 	The result of the expression
 */
DATA_TYPE modExp(DATA_TYPE base, DATA_TYPE exp, DATA_TYPE m);
/**
 * Perform the operation 'base (mod m)'
 *
 * @param base	The base of the expression
 * @param m	The modulus of the expression
 * @return 	The result of the expression
 */
DATA_TYPE modulo(int64_t base, int64_t m);

/**
 * Print an array of arbitrary length in a readable format
 *
 * @param vec	The array to be displayed
 * @param n	The length of the array
 */
void printVec(DATA_TYPE *vec, DATA_TYPE n);

/**
 * Generate an array of arbitrary length containing random positive integers 
 *
 * @param n	The length of the array
 * @param max	The maximum value for an array element [Default: RAND_MAX]
 */
DATA_TYPE *randVec(DATA_TYPE n, DATA_TYPE max=RAND_MAX);

DATA_TYPE* twiddle_cal(DATA_TYPE n, DATA_TYPE r, DATA_TYPE p);
#endif