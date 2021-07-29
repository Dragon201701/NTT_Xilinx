// ----------------------------------------------------------------------------
// User Testbench Interface Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: jd4691@newnano.poly.edu
// Generated date: Wed Jul 28 06:09:25 EDT 2021
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
   static bool xt_ignore;
   static bool xt_skip;
   static bool xt_skip_quiet;
   static bool xt_skip_once;
   static bool xt_skip_noerr;
   static int  xt_array_comp_first;
   static int  xt_array_comp_last;
   static mc_wait_ctrl xt_IN_wait_ctrl;
   static bool xt_use_mask;
   static ac_int<64, false > xt_output_mask;
   static mc_wait_ctrl xt_wait_ctrl;
   static bool p_ignore;
   static bool p_skip;
   static bool p_skip_quiet;
   static bool p_skip_once;
   static bool p_skip_noerr;
   static int  p_array_comp_first;
   static int  p_array_comp_last;
   static mc_wait_ctrl p_wait_ctrl;
   static bool g_ignore;
   static bool g_skip;
   static bool g_skip_quiet;
   static bool g_skip_once;
   static bool g_skip_noerr;
   static int  g_array_comp_first;
   static int  g_array_comp_last;
   static mc_wait_ctrl g_wait_ctrl;
   static bool twiddle_ignore;
   static bool twiddle_skip;
   static bool twiddle_skip_quiet;
   static bool twiddle_skip_once;
   static bool twiddle_skip_noerr;
   static int  twiddle_array_comp_first;
   static int  twiddle_array_comp_last;
   static mc_wait_ctrl twiddle_wait_ctrl;
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   static void exec_stockham_DIT( ac_int<64, false > xt[1024], ac_int<64, false > p, ac_int<64, false > g,  ac_int<64, false > twiddle[1024]);
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
extern void mc_testbench_xt_skip(bool v);
extern void mc_testbench_p_skip(bool v);
extern void mc_testbench_g_skip(bool v);
extern void mc_testbench_twiddle_skip(bool v);
#endif //CCS_TESTBENCH_H
