#ifndef CONFIG_H_
#define CONFIG_H_

#include <inttypes.h>

#define VECTOR_SIZE  1024
#define HALF_VECTOR_SIZE 32
#define VECTOR_ADDR_BIT  10
#define HALF_VECTOR_ADDR_BIT 5

#define PARAM_WIDTH  32
#define VECTOR_WIDTH 32
typedef uint32_t DATA_TYPE;
typedef uint64_t DATA_TYPE_TMP;
typedef int32_t	DATA_TYPE_SIGNED;

typedef uint32_t PARAMS_TYPE;
//typedef ac_fixed<64,64, false> UFIXED64_T;
//typedef ac_fixed<8, 8, false> UFIXED8_T;

#endif /* CONFIG_H_ */