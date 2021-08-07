// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_inPlaceNTT_DIT
extern void mc_testbench_capture_IN( ac_int<64, false > vec[1024], ac_int<64, false > p, ac_int<64, false > r);
extern void mc_testbench_capture_OUT( ac_int<64, false > vec[1024], ac_int<64, false > p, ac_int<64, false > r);
extern void mc_testbench_wait_for_idle_sync();

#define ccs_intercept_inPlaceNTT_DIT_56 \
  ccs_real_inPlaceNTT_DIT(ac_int<64, false > vec[1024],ac_int<64, false > p,ac_int<64, false > r);\
  void inPlaceNTT_DIT(ac_int<64, false > vec[1024],ac_int<64, false > p,ac_int<64, false > r)\
{\
    static bool ccs_intercept_flag = false;\
    if (!ccs_intercept_flag) {\
      std::cout << "SCVerify intercepting C++ function 'inPlaceNTT_DIT' for RTL block 'inPlaceNTT_DIT'" << std::endl;\
      ccs_intercept_flag=true;\
    }\
    mc_testbench_capture_IN(vec,p,r);\
    ccs_real_inPlaceNTT_DIT(vec,p,r);\
    mc_testbench_capture_OUT(vec,p,r);\
}\
  void ccs_real_inPlaceNTT_DIT
#else
#define ccs_intercept_inPlaceNTT_DIT_56 inPlaceNTT_DIT
#endif //CCS_DESIGN_FUNC_inPlaceNTT_DIT
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// modulo_dev 19 BLOCK
#define ccs_intercept_modulo_dev_19 modulo_dev
// atan_2mi 172 INLINE
#define ccs_intercept_atan_2mi_172 atan_2mi
// atan_pi_2mi 248 INLINE
#define ccs_intercept_atan_pi_2mi_248 atan_pi_2mi
// K 255 INLINE
#define ccs_intercept_K_255 K
// modExp_dev 34 INLINE
#define ccs_intercept_modExp_dev_34 modExp_dev
