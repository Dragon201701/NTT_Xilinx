// ----------------------------------------------------------------------------
// User Testbench Interface Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: yl7897@newnano.poly.edu
// Generated date: Wed Aug 04 23:06:06 EDT 2021
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
   static mc_wait_ctrl vec_IN_wait_ctrl;
   static bool vec_use_mask;
   static ac_int<64, false > vec_output_mask;
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
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   static void exec_inPlaceNTT_DIT( ac_int<64, false > vec[1024], ac_int<64, false > p, ac_int<64, false > r);
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
#endif //CCS_TESTBENCH_H
