// ----------------------------------------------------------------------------
// User Testbench Interface Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: ls5382@newnano.poly.edu
// Generated date: Thu Sep 16 11:15:32 EDT 2021
//
// ----------------------------------------------------------------------------

#ifndef CCS_TESTBENCH_H
#define CCS_TESTBENCH_H
#include <ac_int.h>
#include "mc_wait_ctrl.h"
#include <string.h>
#include <iostream>

class testbench
{
   public:
   int argc;
   char** argv;
   int main(); //CCS_MAIN
   static bool enable_idle_sync_mode;
   static unsigned short idle_sync_stable_cycles;
   static void set_enable_stalls(bool flag);
   static void reset_request();
   static bool vec_ignore;
   static bool vec_skip;
   static bool vec_skip_quiet;
   static bool vec_skip_once;
   static bool vec_skip_noerr;
   static int  vec_array_comp_first;
   static int  vec_array_comp_last;
   static mc_wait_ctrl vec_wait_ctrl;
   static bool p_ignore;
   static bool p_skip;
   static bool p_skip_quiet;
   static bool p_skip_once;
   static bool p_skip_noerr;
   static int  p_array_comp_first;
   static int  p_array_comp_last;
   static mc_wait_ctrl p_wait_ctrl;
   static bool r_ignore;
   static bool r_skip;
   static bool r_skip_quiet;
   static bool r_skip_once;
   static bool r_skip_noerr;
   static int  r_array_comp_first;
   static int  r_array_comp_last;
   static mc_wait_ctrl r_wait_ctrl;
   static bool twiddle_ignore;
   static bool twiddle_skip;
   static bool twiddle_skip_quiet;
   static bool twiddle_skip_once;
   static bool twiddle_skip_noerr;
   static int  twiddle_array_comp_first;
   static int  twiddle_array_comp_last;
   static mc_wait_ctrl twiddle_wait_ctrl;
   static bool twiddle_h_ignore;
   static bool twiddle_h_skip;
   static bool twiddle_h_skip_quiet;
   static bool twiddle_h_skip_once;
   static bool twiddle_h_skip_noerr;
   static int  twiddle_h_array_comp_first;
   static int  twiddle_h_array_comp_last;
   static mc_wait_ctrl twiddle_h_wait_ctrl;
   static bool result_ignore;
   static bool result_skip;
   static bool result_skip_quiet;
   static bool result_skip_once;
   static bool result_skip_noerr;
   static int  result_array_comp_first;
   static int  result_array_comp_last;
   static mc_wait_ctrl result_IN_wait_ctrl;
   static bool result_use_mask;
   static ac_int<32, false > result_output_mask;
   static mc_wait_ctrl result_wait_ctrl;
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   static void exec_ntt_flat( ac_int<32, false > vec[4096], ac_int<32, false > p, ac_int<32, false > r,  ac_int<32, false > twiddle[4096],  ac_int<32, false > twiddle_h[4096],  ac_int<32, false > result[13][4096]);
   #endif
   explicit testbench(int _argc, const char* const *_argv)
      :argc(_argc), argv(const_cast<char**>(_argv))
   {
   }
   ~testbench()
   {
   }
   private:
   testbench() {}
};
extern void mc_testbench_reset_request();
extern void mc_testbench_vec_skip(bool v);
extern void mc_testbench_p_skip(bool v);
extern void mc_testbench_r_skip(bool v);
extern void mc_testbench_twiddle_skip(bool v);
extern void mc_testbench_twiddle_h_skip(bool v);
extern void mc_testbench_result_skip(bool v);
#endif //CCS_TESTBENCH_H
