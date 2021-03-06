// ----------------------------------------------------------------------------
// SystemC Testbench Body
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: yl7897@newnano.poly.edu
// Generated date: Sun Jan 23 22:51:26 EST 2022
//
// ----------------------------------------------------------------------------
// 
// -------------------------------------
// mc_testbench
// SCVerify mc_testbench SC_MODULE
// -------------------------------------
// 
#include "mc_testbench.h"
#include <mc_testbench_util.h>
#include <mc_simulator_extensions.h>

mc_testbench* mc_testbench::that;
bool testbench::enable_idle_sync_mode;
unsigned short testbench::idle_sync_stable_cycles;
void testbench::set_enable_stalls(bool flag) { mc_testbench::set_enable_stalls(flag); }
void testbench::reset_request() { mc_testbench::that->reset_request(); }
void mc_testbench_reset_request() { mc_testbench::that->reset_request(); }
bool testbench::run_ignore;
void mc_testbench_run_skip(bool v) { testbench::run_skip = v; }
bool testbench::run_skip;
bool testbench::run_skip_quiet;
bool testbench::run_skip_once;
bool testbench::run_skip_noerr;
int  testbench::run_array_comp_first;
int  testbench::run_array_comp_last;
mc_wait_ctrl testbench::run_wait_ctrl;
bool testbench::a_ignore;
void mc_testbench_a_skip(bool v) { testbench::a_skip = v; }
bool testbench::a_skip;
bool testbench::a_skip_quiet;
bool testbench::a_skip_once;
bool testbench::a_skip_noerr;
int  testbench::a_array_comp_first;
int  testbench::a_array_comp_last;
mc_wait_ctrl testbench::a_IN_wait_ctrl;
bool testbench::a_use_mask;
ac_int<32, false > testbench::a_output_mask;
mc_wait_ctrl testbench::a_wait_ctrl;
bool testbench::complete_ignore;
void mc_testbench_complete_skip(bool v) { testbench::complete_skip = v; }
bool testbench::complete_skip;
bool testbench::complete_skip_quiet;
bool testbench::complete_skip_once;
bool testbench::complete_skip_noerr;
int  testbench::complete_array_comp_first;
int  testbench::complete_array_comp_last;
bool testbench::complete_use_mask;
bool testbench::complete_output_mask;
mc_wait_ctrl testbench::complete_wait_ctrl;
#ifndef CCS_SCVERIFY_USE_CCS_BLOCK
extern "C++" void axi_test( ac_sync &run,  ac_int<32, false > a[16],  ac_sync &complete);
#endif
#ifndef CCS_SCVERIFY_USE_CCS_BLOCK
void testbench::exec_axi_test( ac_sync &run,  ac_int<32, false > a[16],  ac_sync &complete) {
   return mc_testbench::exec_axi_test(run, a, complete);
}
#endif

// ============================================
// Function: wait_for_idle_sync
// --------------------------------------------

void mc_testbench::wait_for_idle_sync()
{
   if (testbench::enable_idle_sync_mode) {
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

void mc_testbench::set_enable_stalls(bool flag)
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
// Function: reset_request
// --------------------------------------------

void mc_testbench::reset_request()
{
   reset_request_event.notify(0,SC_NS);
}
// ============================================
// Function: capture_run
// --------------------------------------------

void mc_testbench::capture_run( ac_sync &run)
{
   static bool run_tmp;
   static int last_j_run_in = 0;
   if (run_iteration_count == wait_cnt)
      wait_on_input_required();
   if (_capture_run && !testbench::run_ignore)
   {
      if (!run_pointer_set) {
         run_pointer = &(run);
         run_pointer_set = true;
      } else if (run_pointer != &(run) && remaining_ccs_run == 0) {
         std::ostringstream msg; msg.str("");
         msg << "Interface run source switched to a difference object in testbench with "
             << remaining_ccs_run << " values remaining in input fifo. No data mismatch detected." <<" @ " << sc_time_stamp();
         SC_REPORT_INFO("User testbench", msg.str().c_str());
         run_pointer = &(run);
      } else if (run_pointer != &(run) && remaining_ccs_run > 0 && remaining_ccs_run != run.ac_channel<bool >::debug_size()) {
         std::ostringstream msg; msg.str("");
         msg << "Interface run source switched to a different object in testbench with "
             << remaining_ccs_run << " values remaining in input fifo. Simulation mismatch likely. Check golden vs DUT comparison values for errors." <<" @ " << sc_time_stamp();
         SC_REPORT_WARNING("User testbench", msg.str().c_str());
         _channel_mismatch = true;
      }
      int cur_iter = run_capture_count;
      ++run_iteration_count;
      unsigned int chan_factor = 1;
      unsigned int ccs_scv_i,ccs_scv_j;
      ccs_scv_i = remaining_ccs_run;
      while (ccs_scv_i < run.ac_channel<bool >::debug_size()) {
         for (ccs_scv_j = last_j_run_in; ccs_scv_j < chan_factor; ccs_scv_j++,ccs_scv_i++) {
            if (ccs_scv_i < run.ac_channel<bool >::debug_size()) {
               run_tmp = run.ac_channel<bool >::chan[ccs_scv_i];
            } else {
               break;
            }
         }
         if (ccs_scv_j == chan_factor) {
            ccs_run->put(run_tmp);
            last_j_run_in = 0;
            run_capture_count += chan_factor;
         } else {
            last_j_run_in = ccs_scv_j;
         }
      }
      mc_testbench_util::process_wait_ctrl("run",testbench::run_wait_ctrl,ccs_wait_ctrl_run.operator->(),cur_iter,run_capture_count,1);
   }
   testbench::run_ignore = false;
}
// ============================================
// Function: capture_a_IN
// --------------------------------------------

void mc_testbench::capture_a_IN( ac_int<32, false > a[16])
{
   if (a_IN_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_a_IN && !testbench::a_ignore)
   {
      int cur_iter = a_IN_iteration_count;
      ++a_IN_iteration_count;
      mgc_sysc_ver_array1D<ac_int<32, false >,16> a_IN_tmp;
      int a_linear_idx = 0;
      for (int a_idx_0 = 0; a_idx_0 < 16; ++a_idx_0)
         a_IN_tmp[a_linear_idx++] = a[a_idx_0];
      ccs_a_IN->put(a_IN_tmp);
      ++a_IN_capture_count;
      mc_testbench_util::process_wait_ctrl("a_IN",testbench::a_IN_wait_ctrl,ccs_wait_ctrl_a_IN.operator->(),cur_iter,a_IN_capture_count,0);
   }
   testbench::a_ignore = false;
}
// ============================================
// Function: capture_a
// --------------------------------------------

void mc_testbench::capture_a( ac_int<32, false > a[16])
{
   if (_capture_a)
   {
      int cur_iter = a_iteration_count;
      ++a_iteration_count;
      mc_golden_info< mgc_sysc_ver_array1D<ac_int<32, false >,16>, MaskPacket<0, 32> > a_tmp(testbench::a_ignore, false, a_iteration_count);
      a_tmp._data.mc_testbench_process_array_bounds("a",testbench::a_array_comp_first,testbench::a_array_comp_last,15,0);
      // BEGIN: testbench output_mask control for field_name a
      if ( testbench::a_use_mask ) {
         sc_lv<32> tmp_mask_lv;
         type_to_vector(testbench::a_output_mask, 32, tmp_mask_lv);
         a_tmp._use_mask = true;
         a_tmp._packet._mask = tmp_mask_lv;
      }
      // END: testbench output_mask control for field_name a
      int a_linear_idx = 0;
      for (int a_idx_0 = 0; a_idx_0 < 16; ++a_idx_0)
         a_tmp._data[a_linear_idx++] = a[a_idx_0];
      if (!testbench::a_skip) {
         a_golden.put(a_tmp);
         ++a_capture_count;
      } else {
         if (!testbench::a_skip_quiet || !testbench::a_skip_once) {
            std::ostringstream msg; msg.str("");
            msg << "testbench::a_skip=true for iteration=" << a_iteration_count << " @ " << sc_time_stamp();
            SC_REPORT_WARNING("User testbench", msg.str().c_str());
            testbench::a_skip_once = true;
         }
      }
      mc_testbench_util::process_wait_ctrl("a",testbench::a_wait_ctrl,ccs_wait_ctrl_a.operator->(),cur_iter,a_capture_count,0);
      testbench::a_use_mask = false;
   }
   testbench::a_ignore = false;
   testbench::a_skip = false;
}
// ============================================
// Function: capture_complete
// --------------------------------------------

void mc_testbench::capture_complete( ac_sync &complete)
{
   static mc_golden_info< bool, MaskPacket<1, 1> > complete_tmp(testbench::complete_ignore, false, complete_iteration_count);
   complete_tmp._ignore = testbench::complete_ignore;
   complete_tmp._iteration = complete_iteration_count;
   // BEGIN: testbench output_mask control for field_name complete
   if ( testbench::complete_use_mask ) {
      sc_lv<1> tmp_mask_lv;
      type_to_vector(testbench::complete_output_mask, 1, tmp_mask_lv);
      complete_tmp._use_mask = true;
      complete_tmp._packet._mask = tmp_mask_lv;
   }
   // END: testbench output_mask control for field_name complete
   static int last_j_complete_out = 0;
   if (_capture_complete)
   {
      int cur_iter = complete_capture_count;
      ++complete_iteration_count;
      unsigned int chan_factor = 1;
      unsigned int ccs_scv_i,ccs_scv_j;
      ccs_scv_i = remaining_complete_golden;
      while (ccs_scv_i < complete.ac_channel<bool >::debug_size()) {
         for (ccs_scv_j = last_j_complete_out; ccs_scv_j < chan_factor; ccs_scv_j++,ccs_scv_i++) {
            if (ccs_scv_i < complete.ac_channel<bool >::debug_size()) {
               complete_tmp._data = complete.ac_channel<bool >::chan[ccs_scv_i];
            } else {
               break;
            }
         }
         if (ccs_scv_j == chan_factor) {
            complete_golden.put(complete_tmp);
            last_j_complete_out = 0;
            complete_capture_count += chan_factor;
         } else {
            last_j_complete_out = ccs_scv_j;
         }
      }
      mc_testbench_util::process_wait_ctrl("complete",testbench::complete_wait_ctrl,ccs_wait_ctrl_complete.operator->(),cur_iter,complete_capture_count,1);
      testbench::complete_use_mask = false;
   }
   testbench::complete_ignore = false;
   testbench::complete_skip = false;
}
// ============================================
// Function: wait_on_input_required
// --------------------------------------------

void mc_testbench::wait_on_input_required()
{
   ++wait_cnt;
   wait(SC_ZERO_TIME); // get fifos a chance to update
   ++period_counter;
   sc_time timeout = sc_time_stamp() - previous_timestamp;
   if (calculate_period && sc_time_stamp() > SC_ZERO_TIME && sc_time_stamp() != previous_timestamp && sc_time_stamp() != timeout) {
      average_period = (average_period + timeout) / 2;
   }
   previous_timestamp = sc_time_stamp();
   while (atleast_one_active_input) {
      if (_capture_run && ccs_run->used() == 0) return;
      if (_capture_a_IN && ccs_a_IN->used() == 0) return;
      that->cpp_testbench_active.write(false);
      if (average_period > SC_ZERO_TIME && sc_time_stamp() != timeout)
         wait(average_period * 10, ccs_run->ok_to_put() | ccs_a_IN->ok_to_put());
      else
         wait(ccs_run->ok_to_put() | ccs_a_IN->ok_to_put());
      that->cpp_testbench_active.write(true);
      if (timed_out()) {
         calculate_period = false;
         return;
      }
   }
}
// ============================================
// Function: capture_IN
// --------------------------------------------

void mc_testbench::capture_IN( ac_sync &run,  ac_int<32, false > a[16],  ac_sync &complete)
{
   that->capture_run(run);
   that->capture_a_IN(a);
   that->remaining_complete_golden =  complete.ac_channel<bool >::debug_size();
}
// ============================================
// Function: capture_OUT
// --------------------------------------------

void mc_testbench::capture_OUT( ac_sync &run,  ac_int<32, false > a[16],  ac_sync &complete)
{
   that->remaining_ccs_run =  run.ac_channel<bool >::debug_size();
   if (testbench::enable_idle_sync_mode && that->remaining_ccs_run != 0) {
      cout << "Warning: Testbench input channel 'run' not empty. Remaining size: " << that->remaining_ccs_run << endl;
   }
   that->capture_a(a);
   that->capture_complete(complete);
}
// ============================================
// Function: exec_axi_test
// --------------------------------------------

void mc_testbench::exec_axi_test( ac_sync &run,  ac_int<32, false > a[16],  ac_sync &complete)
{
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   that->cpp_testbench_active.write(true);
   capture_IN(run, a, complete);
   axi_test(run, a, complete);
   // throttle ac_channel based on number of calls to chan::size() or chan::empty() or chan::nb_read() (but not chan::available()) 
   if (1) {
      int cnt=0;
      if (cnt) std::cout << "mc_testbench.cpp: CONTINUES @ " << sc_time_stamp() << std::endl;
      if (cnt) that->cpp_testbench_active.write(true);
   }
   capture_OUT(run, a, complete);
   #else
   #endif
}
// ============================================
// Function: start_of_simulation
// --------------------------------------------

void mc_testbench::start_of_simulation()
{
   set_enable_stalls(false);
}
// ============================================
// Function: end_of_simulation
// --------------------------------------------

void mc_testbench::end_of_simulation()
{
   if (!_checked_results) {
      SC_REPORT_INFO(name(), "Testbench exited early or ran into deadlock");
      check_results();
   }
}
// ============================================
// Function: check_results
// --------------------------------------------

void mc_testbench::check_results()
{
   if (_checked_results) return;
   _checked_results = true;
   cout<<endl;
   cout<<"Checking results"<<endl;
   if (main_exit_code) _failed = true;
   int _num_outputs_checked = 0;
   bool _has_capture_counts = false;
   std::ostringstream mctb_msg;
   
   if (!_capture_a) {
      cout<<"'a' - warning, output was optimized away"<<endl;
   } else {
      _num_outputs_checked++;
      _failed |= a_comp->check_results(a_capture_count,testbench::a_skip_noerr);
      _has_capture_counts |= !!(a_capture_count);
   }
   if (!_capture_complete) {
      cout<<"'complete' - warning, output was optimized away"<<endl;
   } else {
      _num_outputs_checked++;
      _failed |= complete_comp->check_results(complete_capture_count,testbench::complete_skip_noerr);
      _has_capture_counts |= !!(complete_capture_count);
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
   if (_channel_mismatch && _failed)
   mctb_msg << endl << "An input channel was switched before the input fifo was fully empty. Check your testbench.";
   SC_REPORT_INFO(this->name(), mctb_msg.str().c_str());
}
// ============================================
// Function: failed
// --------------------------------------------

bool mc_testbench::failed()
{
   return _failed;
}
// ============================================
// Function: set_failed
// --------------------------------------------

void mc_testbench::set_failed(bool fail)
{
   _failed = fail;
}
// ---------------------------------------------------------------
// Process: SC_METHOD wait_for_end
// Static sensitivity: sensitive << clk.pos() << testbench_end_event;

void mc_testbench::wait_for_end() {
   // If run() has not finished, we do nothing here
   if (!testbench_ended) return;
   // check for completed outputs
   if (a_comp->get_compare_count() < a_capture_count) {testbench_end_event.notify(1,SC_NS); return;}
   if (complete_comp->get_compare_count() < complete_capture_count) {testbench_end_event.notify(1,SC_NS); return;}
   // If we made it here, all outputs have flushed. Check the results
   SC_REPORT_INFO(name(), "Simulation completed");
   check_results();
   sc_stop();
}
// ---------------------------------------------------------------
// Process: SC_THREAD run
// Static sensitivity: 

void mc_testbench::run() {
   testbench::enable_idle_sync_mode = false;
   testbench::idle_sync_stable_cycles = 1;
   _channel_mismatch = false;
   testbench::run_ignore = false;
   testbench::run_skip = false;
   testbench::run_skip_quiet = false;
   testbench::run_skip_once = false;
   testbench::run_skip_noerr = false;
   testbench::run_array_comp_first = -1;
   testbench::run_array_comp_last = -1;
   testbench::run_wait_ctrl.clear();
   run_capture_count = 0;
   run_iteration_count = 0;
   run_pointer_set = false;
   testbench::a_ignore = false;
   testbench::a_skip = false;
   testbench::a_skip_quiet = false;
   testbench::a_skip_once = false;
   testbench::a_skip_noerr = false;
   testbench::a_array_comp_first = -1;
   testbench::a_array_comp_last = -1;
   testbench::a_IN_wait_ctrl.clear();
   a_IN_capture_count = 0;
   a_IN_iteration_count = 0;
   testbench::a_use_mask = false;
   testbench::a_output_mask = (ac_int<32, false >) ~0;
   testbench::a_wait_ctrl.clear();
   a_capture_count = 0;
   a_iteration_count = 0;
   a_IN_access_ptr = 0;
   a_access_ptr = 0;
   testbench::complete_ignore = false;
   testbench::complete_skip = false;
   testbench::complete_skip_quiet = false;
   testbench::complete_skip_once = false;
   testbench::complete_skip_noerr = false;
   testbench::complete_array_comp_first = -1;
   testbench::complete_array_comp_last = -1;
   testbench::complete_use_mask = false;
   testbench::complete_output_mask = (bool) ~0;
   testbench::complete_wait_ctrl.clear();
   complete_capture_count = 0;
   complete_iteration_count = 0;
   complete_pointer_set = false;
   testbench testbench_inst(sc_argc(), sc_argv());
   main_exit_code = testbench_inst.main();
   cout<<"Info: Execution of user-supplied C++ testbench 'main()' has completed with exit code = " << main_exit_code << endl;
   cout<<endl;
   cout<<"Info: Collecting data completed"<<endl;
   cout<<"   captured "<<run_capture_count<<" values of run"<<endl;
   cout<<"   captured "<<a_IN_capture_count<<" values of a_IN"<<endl;
   cout<<"   captured "<<a_capture_count<<" values of a"<<endl;
   cout<<"   captured "<<complete_capture_count<<" values of complete"<<endl;
   testbench_ended = true;
   testbench_end_event.notify(SC_ZERO_TIME);
}
#ifdef CCS_SCVERIFY_USE_CCS_BLOCK
#include "ccs_block_macros.cpp"
#endif
