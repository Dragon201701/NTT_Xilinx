// ----------------------------------------------------------------------------
// SystemC Testbench Body
//
//    HLS version: 10.3a/798110 Production Release
//       HLS date: Tue Dec  4 22:20:19 PST 2018
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 8.0a
//
//   Generated by: jd4691@newnano.poly.edu
// Generated date: Wed Jun 23 00:11:18 EDT 2021
//
// ----------------------------------------------------------------------------
// 
// -------------------------------------
// testbench
// User supplied testbench
// -------------------------------------
// 
#include "mc_testbench.h"
#include <mc_testbench_util.h>
#include <mc_simulator_extensions.h>

testbench* testbench::that;
bool testbench::enable_idle_sync_mode;
unsigned short testbench::idle_sync_stable_cycles;
bool testbench::i_sample_ignore;
bool testbench::i_sample_skip;
bool testbench::i_sample_skip_quiet;
bool testbench::i_sample_skip_once;
bool testbench::i_sample_skip_noerr;
void mc_testbench_i_sample_skip(bool v) { testbench::i_sample_skip = v; }
int testbench::i_sample_array_comp_first;
int testbench::i_sample_array_comp_last;
mc_wait_ctrl testbench::i_sample_wait_ctrl;
bool testbench::b_ignore;
bool testbench::b_skip;
bool testbench::b_skip_quiet;
bool testbench::b_skip_once;
bool testbench::b_skip_noerr;
void mc_testbench_b_skip(bool v) { testbench::b_skip = v; }
int testbench::b_array_comp_first;
int testbench::b_array_comp_last;
mc_wait_ctrl testbench::b_wait_ctrl;
bool testbench::y_ignore;
bool testbench::y_skip;
bool testbench::y_skip_quiet;
bool testbench::y_skip_once;
bool testbench::y_skip_noerr;
void mc_testbench_y_skip(bool v) { testbench::y_skip = v; }
int testbench::y_array_comp_first;
int testbench::y_array_comp_last;
bool testbench::y_use_mask;
ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > testbench::y_output_mask;
mc_wait_ctrl testbench::y_wait_ctrl;
#ifndef CCS_SCVERIFY_USE_CCS_BLOCK
extern "C++" void fir_filter(ac_fixed<3, 1, true, AC_TRN, AC_WRAP > i_sample,  ac_fixed<10, -2, true, AC_TRN, AC_WRAP > b[127],  ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > &y);
#endif

// ============================================
// Function: wait_for_idle_sync
// --------------------------------------------

void testbench::wait_for_idle_sync()
{
   if (enable_idle_sync_mode) {
      std::cout << "mc_testbench STOPPING   @ " << sc_time_stamp() << std::endl;
      that->cpp_testbench_active.write(false);
      while (that->design_is_idle.read())  that->wait(that->design_is_idle.value_changed_event());
      while (!that->design_is_idle.read()) that->wait(that->design_is_idle.value_changed_event());
      that->cpp_testbench_active.write(true);
      std::cout << "mc_testbench CONTINUING @ " << sc_time_stamp() << std::endl;
   } else {
      that->cpp_testbench_active.write(true);
   }
}
// ============================================
// Function: set_enable_stalls
// --------------------------------------------

void testbench::set_enable_stalls(bool flag)
{
   if (flag) {
     std::cout << "Enabling STALL_FLAG toggling" << std::endl;
     that->enable_stalls.write(sc_dt::Log_1);
   } else {
     std::cout << "Disabling STALL_FLAG toggling" << std::endl;
     that->enable_stalls.write(sc_dt::Log_0);
   }
}
// ============================================
// Function: capture_i_sample
// --------------------------------------------

void testbench::capture_i_sample(ac_fixed<3, 1, true, AC_TRN, AC_WRAP > i_sample)
{
   if (i_sample_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_i_sample && !i_sample_ignore)
   {
      int cur_iter = i_sample_iteration_count;
      ++i_sample_iteration_count;
      ccs_i_sample->put(i_sample); // THIS
      ++i_sample_capture_count;
      mc_testbench::process_wait_ctrl("i_sample",i_sample_wait_ctrl,ccs_wait_ctrl_i_sample.operator->(),cur_iter,i_sample_capture_count,0);
   }
   i_sample_ignore = false;
}
// ============================================
// Function: capture_b
// --------------------------------------------

void testbench::capture_b( ac_fixed<10, -2, true, AC_TRN, AC_WRAP > b[127])
{
   if (b_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_b && !b_ignore)
   {
      int cur_iter = b_iteration_count;
      ++b_iteration_count;
      mgc_sysc_ver_array1D<ac_fixed<10, -2, true, AC_TRN, AC_WRAP >,127> b_tmp;
      int b_linear_idx = 0;
      for (int b_idx_0 = 0; b_idx_0 < 127; ++b_idx_0)
         b_tmp[b_linear_idx++] = b[b_idx_0];
      ccs_b->put(b_tmp);
      ++b_capture_count;
      mc_testbench::process_wait_ctrl("b",b_wait_ctrl,ccs_wait_ctrl_b.operator->(),cur_iter,b_capture_count,0);
   }
   b_ignore = false;
}
// ============================================
// Function: capture_y
// --------------------------------------------

void testbench::capture_y( ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > &y)
{
   if (_capture_y)
   {
      int cur_iter = y_iteration_count;
      ++y_iteration_count;
      mc_golden_info< ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM >, ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > > y_tmp(y, y_ignore, ~0, false, y_iteration_count);
      // BEGIN: testbench output_mask control for field_name y
      if ( y_use_mask ) {
         y_tmp._use_mask = true;
         y_tmp._mask = y_output_mask ;
      }
      // END: testbench output_mask control for field_name y
      if (!y_skip) {
         y_golden.put(y_tmp);
         ++y_capture_count;
      } else {
         if (!y_skip_quiet || !y_skip_once) {
            std::ostringstream msg; msg.str("");
            msg << "y_skip=true for iteration=" << y_iteration_count << " @ " << sc_time_stamp();
            SC_REPORT_WARNING("User testbench", msg.str().c_str());
            y_skip_once = true;
         }
      }
      mc_testbench::process_wait_ctrl("y",y_wait_ctrl,ccs_wait_ctrl_y.operator->(),cur_iter,y_capture_count,0);
      y_use_mask = false;
   }
   y_ignore = false;
   y_skip = false;
}
// ============================================
// Function: wait_on_input_required
// --------------------------------------------

void testbench::wait_on_input_required()
{
   ++wait_cnt;
   wait(SC_ZERO_TIME); // get fifos a chance to update
   while (atleast_one_active_input) {
      if (_capture_i_sample && ccs_i_sample->used() == 0) return;
      if (_capture_b && ccs_b->used() == 0) return;
      that->cpp_testbench_active.write(false);
      wait(ccs_i_sample->ok_to_put() | ccs_b->ok_to_put());
      that->cpp_testbench_active.write(true);
   }
}
// ============================================
// Function: capture_IN
// --------------------------------------------

void testbench::capture_IN(ac_fixed<3, 1, true, AC_TRN, AC_WRAP > i_sample,  ac_fixed<10, -2, true, AC_TRN, AC_WRAP > b[127],  ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > &y)
{
   that->capture_i_sample(i_sample);
   that->capture_b(b);
}
// ============================================
// Function: capture_OUT
// --------------------------------------------

void testbench::capture_OUT(ac_fixed<3, 1, true, AC_TRN, AC_WRAP > i_sample,  ac_fixed<10, -2, true, AC_TRN, AC_WRAP > b[127],  ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > &y)
{
   that->capture_y(y);
}
// ============================================
// Function: exec_fir_filter
// --------------------------------------------

void testbench::exec_fir_filter(ac_fixed<3, 1, true, AC_TRN, AC_WRAP > i_sample,  ac_fixed<10, -2, true, AC_TRN, AC_WRAP > b[127],  ac_fixed<9, 1, true, AC_RND, AC_SAT_SYM > &y)
{
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   that->cpp_testbench_active.write(true);
   capture_IN(i_sample, b, y);
   fir_filter(i_sample, b, y);
   // throttle ac_channel based on number of calls to chan::size() or chan::empty() or chan::nb_read() (but not chan::available()) 
   if (1) {
      int cnt=0;
      if (cnt) std::cout << "mc_testbench.cpp: CONTINUES @ " << sc_time_stamp() << std::endl;
      if (cnt) that->cpp_testbench_active.write(true);
   }
   capture_OUT(i_sample, b, y);
   #else
   #endif
}
// ============================================
// Function: start_of_simulation
// --------------------------------------------

void testbench::start_of_simulation()
{
   set_enable_stalls(false);
}
// ============================================
// Function: end_of_simulation
// --------------------------------------------

void testbench::end_of_simulation()
{
   if (!_checked_results) {
      SC_REPORT_INFO(name(), "Simulation ran into deadlock");
      check_results();
   }
}
// ============================================
// Function: check_results
// --------------------------------------------

void testbench::check_results()
{
   if (_checked_results) return;
   _checked_results = true;
   cout<<endl;
   cout<<"Checking results"<<endl;
   if (main_exit_code) _failed = true;
   int _num_outputs_checked = 0;
   bool _has_capture_counts = false;
   std::ostringstream mctb_msg;
   
   if (!_capture_y) {
      cout<<"'y' - warning, output was optimized away"<<endl;
   } else {
      _num_outputs_checked++;
      _failed |= y_comp->check_results(y_capture_count,y_skip_noerr);
      _has_capture_counts |= !!(y_capture_count);
   }
   cout<<endl;
   if (_num_outputs_checked == 0) {
      cout<<"Error: All outputs were optimized away. No output values were compared."<<endl;
      _failed = _failed || (_num_outputs_checked == 0);
   }
   if (!_has_capture_counts) {
      cout<<"Error: Nothing to compare, all output capture counts are zero."<<endl;
      _failed = true;
   }
   if (main_exit_code) cout << "Error: C++ Testbench 'main()' returned a non-zero exit code ("<<main_exit_code<<"). Check your testbench." <<endl;
   mctb_msg.clear();
   if (_failed) mctb_msg << "Simulation FAILED";
   else         mctb_msg << "Simulation PASSED";
   mctb_msg << " @ " << sc_time_stamp();
   SC_REPORT_INFO(this->name(), mctb_msg.str().c_str());
}
// ============================================
// Function: failed
// --------------------------------------------

bool testbench::failed()
{
   return _failed;
}
// ============================================
// Function: set_failed
// --------------------------------------------

void testbench::set_failed(bool fail)
{
   _failed = fail;
}
// ---------------------------------------------------------------
// Process: SC_METHOD wait_for_end
// Static sensitivity: sensitive << clk.pos() << testbench_end_event;

void testbench::wait_for_end() {
   // If run() has not finished, we do nothing here
   if (!testbench_ended) return;
   // check for completed outputs
   if (y_comp->get_compare_count() < y_capture_count) {testbench_end_event.notify(1,SC_NS); return;}
   // If we made it here, all outputs have flushed. Check the results
   SC_REPORT_INFO(name(), "Simulation completed");
   check_results();
   sc_stop();
}
// ---------------------------------------------------------------
// Process: SC_THREAD run
// Static sensitivity: 

void testbench::run() {
   enable_idle_sync_mode = false;
   idle_sync_stable_cycles = 1;
   i_sample_ignore = false;
   i_sample_skip = false;
   i_sample_skip_quiet = false;
   i_sample_skip_once = false;
   i_sample_skip_noerr = false;
   i_sample_array_comp_first = -1;
   i_sample_array_comp_last = -1;
   i_sample_wait_ctrl.clear();
   i_sample_capture_count = 0;
   i_sample_iteration_count = 0;
   b_ignore = false;
   b_skip = false;
   b_skip_quiet = false;
   b_skip_once = false;
   b_skip_noerr = false;
   b_array_comp_first = -1;
   b_array_comp_last = -1;
   b_wait_ctrl.clear();
   b_capture_count = 0;
   b_iteration_count = 0;
   y_ignore = false;
   y_skip = false;
   y_skip_quiet = false;
   y_skip_once = false;
   y_skip_noerr = false;
   y_array_comp_first = -1;
   y_array_comp_last = -1;
   y_use_mask = false;
   y_output_mask = ~0;
   y_wait_ctrl.clear();
   y_capture_count = 0;
   y_iteration_count = 0;
   main_exit_code = main();
   cout<<"Info: Execution of user-supplied C++ testbench 'main()' has completed with exit code = " << main_exit_code << endl;
   cout<<endl;
   cout<<"Info: Collecting data completed"<<endl;
   cout<<"   captured "<<i_sample_capture_count<<" values of i_sample"<<endl;
   cout<<"   captured "<<b_capture_count<<" values of b"<<endl;
   cout<<"   captured "<<y_capture_count<<" values of y"<<endl;
   testbench_ended = true;
   testbench_end_event.notify(SC_ZERO_TIME);
}
#ifdef CCS_SCVERIFY_USE_CCS_BLOCK
#include "ccs_block_macros.cpp"
#endif
