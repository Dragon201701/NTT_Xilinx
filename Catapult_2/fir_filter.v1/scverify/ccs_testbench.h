// ----------------------------------------------------------------------------
// User Testbench Interface Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: jd4691@newnano.poly.edu
// Generated date: Tue Jun 22 23:59:01 EDT 2021
//
// ----------------------------------------------------------------------------

#ifndef CCS_TESTBENCH_H
#define CCS_TESTBENCH_H
#include <ac_fixed.h>
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
   static bool i_sample_ignore;
   static bool i_sample_skip;
   static bool i_sample_skip_quiet;
   static bool i_sample_skip_once;
   static bool i_sample_skip_noerr;
   static int  i_sample_array_comp_first;
   static int  i_sample_array_comp_last;
   static mc_wait_ctrl i_sample_wait_ctrl;
   static bool b_ignore;
   static bool b_skip;
   static bool b_skip_quiet;
   static bool b_skip_once;
   static bool b_skip_noerr;
   static int  b_array_comp_first;
   static int  b_array_comp_last;
   static mc_wait_ctrl b_wait_ctrl;
   static bool y_ignore;
   static bool y_skip;
   static bool y_skip_quiet;
   static bool y_skip_once;
   static bool y_skip_noerr;
   static int  y_array_comp_first;
   static int  y_array_comp_last;
   static bool y_use_mask;
   static ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > y_output_mask;
   static mc_wait_ctrl y_wait_ctrl;
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   static void exec_fir_filter(ac_fixed<3, 1, true, AC_TRN, AC_WRAP > i_sample,  ac_fixed<10, -2, true, AC_TRN, AC_WRAP > b[127],  ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > &y);
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
extern void mc_testbench_i_sample_skip(bool v);
extern void mc_testbench_b_skip(bool v);
extern void mc_testbench_y_skip(bool v);
#endif //CCS_TESTBENCH_H
