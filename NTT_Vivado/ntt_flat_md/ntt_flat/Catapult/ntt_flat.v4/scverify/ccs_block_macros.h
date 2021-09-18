// ccs_block_macros.h
#include "ccs_testbench.h"

#ifndef EXCLUDE_CCS_BLOCK_INTERCEPT
#ifndef INCLUDE_CCS_BLOCK_INTERCEPT
#define INCLUDE_CCS_BLOCK_INTERCEPT
#ifdef  CCS_DESIGN_FUNC_ntt_flat
extern void mc_testbench_capture_IN( ac_int<32, false > vec[16384], ac_int<32, false > p, ac_int<32, false > r,  ac_int<32, false > twiddle[16384],  ac_int<32, false > twiddle_h[16384],  ac_int<32, false > result[15][16384]);
extern void mc_testbench_capture_OUT( ac_int<32, false > vec[16384], ac_int<32, false > p, ac_int<32, false > r,  ac_int<32, false > twiddle[16384],  ac_int<32, false > twiddle_h[16384],  ac_int<32, false > result[15][16384]);
extern void mc_testbench_wait_for_idle_sync();

#define ccs_intercept_ntt_flat_73 \
  ccs_real_ntt_flat(ac_int<32, false > vec[16384],ac_int<32, false > p,ac_int<32, false > r,ac_int<32, false > twiddle[16384],ac_int<32, false > twiddle_h[16384],ac_int<32, false > result[15][16384]);\
  void ntt_flat(ac_int<32, false > vec[16384],ac_int<32, false > p,ac_int<32, false > r,ac_int<32, false > twiddle[16384],ac_int<32, false > twiddle_h[16384],ac_int<32, false > result[15][16384])\
{\
    static bool ccs_intercept_flag = false;\
    if (!ccs_intercept_flag) {\
      std::cout << "SCVerify intercepting C++ function 'ntt_flat' for RTL block 'ntt_flat'" << std::endl;\
      ccs_intercept_flag=true;\
    }\
    mc_testbench_capture_IN(vec,p,r,twiddle,twiddle_h,result);\
    ccs_real_ntt_flat(vec,p,r,twiddle,twiddle_h,result);\
    mc_testbench_capture_OUT(vec,p,r,twiddle,twiddle_h,result);\
}\
  void ccs_real_ntt_flat
#else
#define ccs_intercept_ntt_flat_73 ntt_flat
#endif //CCS_DESIGN_FUNC_ntt_flat
#endif //INCLUDE_CCS_BLOCK_INTERCEPT
#endif //EXCLUDE_CCS_BLOCK_INTERCEPT

// atan_2mi 172 INLINE
#define ccs_intercept_atan_2mi_172 atan_2mi
// atan_pi_2mi 248 INLINE
#define ccs_intercept_atan_pi_2mi_248 atan_pi_2mi
// K 255 INLINE
#define ccs_intercept_K_255 K
// modulo_add 12 INLINE
#define ccs_intercept_modulo_add_12 modulo_add
// modulo_sub 26 INLINE
#define ccs_intercept_modulo_sub_26 modulo_sub
// mult 40 INLINE
#define ccs_intercept_mult_40 mult
// butterFly 62 INLINE
#define ccs_intercept_butterFly_62 butterFly
