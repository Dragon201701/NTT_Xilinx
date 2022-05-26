// ----------------------------------------------------------------------------
// User Testbench Interface Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: yl7897@newnano.poly.edu
// Generated date: Sun Jan 23 14:55:08 EST 2022
//
// ----------------------------------------------------------------------------

#ifndef CCS_TESTBENCH_H
#define CCS_TESTBENCH_H
#include <ac_int.h>
#include <ac_channel.h>
#include <ac_sync.h>
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
   static bool run_ignore;
   static bool run_skip;
   static bool run_skip_quiet;
   static bool run_skip_once;
   static bool run_skip_noerr;
   static int  run_array_comp_first;
   static int  run_array_comp_last;
   static mc_wait_ctrl run_wait_ctrl;
   static bool a_ignore;
   static bool a_skip;
   static bool a_skip_quiet;
   static bool a_skip_once;
   static bool a_skip_noerr;
   static int  a_array_comp_first;
   static int  a_array_comp_last;
   static mc_wait_ctrl a_wait_ctrl;
   static bool arrsum_ignore;
   static bool arrsum_skip;
   static bool arrsum_skip_quiet;
   static bool arrsum_skip_once;
   static bool arrsum_skip_noerr;
   static int  arrsum_array_comp_first;
   static int  arrsum_array_comp_last;
   static bool arrsum_use_mask;
   static ac_int<32, false > arrsum_output_mask;
   static mc_wait_ctrl arrsum_wait_ctrl;
   static bool complete_ignore;
   static bool complete_skip;
   static bool complete_skip_quiet;
   static bool complete_skip_once;
   static bool complete_skip_noerr;
   static int  complete_array_comp_first;
   static int  complete_array_comp_last;
   static bool complete_use_mask;
   static bool complete_output_mask;
   static mc_wait_ctrl complete_wait_ctrl;
   static bool result_ignore;
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   static void exec_axi_test( ac_sync &run,  ac_int<32, false > a[16],  ac_int<32, false > &arrsum,  ac_sync &complete);
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
extern void mc_testbench_run_skip(bool v);
extern void mc_testbench_a_skip(bool v);
extern void mc_testbench_arrsum_skip(bool v);
extern void mc_testbench_complete_skip(bool v);
#endif //CCS_TESTBENCH_H
