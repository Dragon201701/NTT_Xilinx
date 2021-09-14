#ifndef NTT_H_
#define NTT_H_

#include "config.h"
#include "utils.h"
//#include <cmath>

#pragma hls_design top
void hybrid(DATA_TYPE x[VECTOR_SIZE], DATA_TYPE m, DATA_TYPE twiddle[HALF_VECTOR_SIZE], DATA_TYPE twiddle_h[VECTOR_SIZE], PARAMS_TYPE revArr[HALF_VECTOR_SIZE],  DATA_TYPE tw[VECTOR_SIZE], DATA_TYPE tw_h[VECTOR_SIZE]);
#endif /* NTT_H_ */