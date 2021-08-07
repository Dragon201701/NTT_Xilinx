// ----------------------------------------------------------------------------
// SystemC Testbench Body
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: yl7897@newnano.poly.edu
// Generated date: Wed May 19 22:40:45 EDT 2021
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
bool testbench::vec_ignore;
void mc_testbench_vec_skip(bool v) { testbench::vec_skip = v; }
bool testbench::vec_skip;
bool testbench::vec_skip_quiet;
bool testbench::vec_skip_once;
bool testbench::vec_skip_noerr;
int  testbench::vec_array_comp_first;
int  testbench::vec_array_comp_last;
mc_wait_ctrl testbench::vec_IN_wait_ctrl;
bool testbench::vec_use_mask;
ac_int<64, false > testbench::vec_output_mask;
mc_wait_ctrl testbench::vec_wait_ctrl;
bool testbench::p_ignore;
void mc_testbench_p_skip(bool v) { testbench::p_skip = v; }
bool testbench::p_skip;
bool testbench::p_skip_quiet;
bool testbench::p_skip_once;
bool testbench::p_skip_noerr;
int  testbench::p_array_comp_first;
int  testbench::p_array_comp_last;
mc_wait_ctrl testbench::p_wait_ctrl;
bool testbench::r_ignore;
void mc_testbench_r_skip(bool v) { testbench::r_skip = v; }
bool testbench::r_skip;
bool testbench::r_skip_quiet;
bool testbench::r_skip_once;
bool testbench::r_skip_noerr;
int  testbench::r_array_comp_first;
int  testbench::r_array_comp_last;
mc_wait_ctrl testbench::r_wait_ctrl;
#ifndef CCS_SCVERIFY_USE_CCS_BLOCK
extern "C++" void inPlaceNTT_DIT( ac_int<64, false > vec[4096], ac_int<64, false > p, ac_int<64, false > r);
#endif
#ifndef CCS_SCVERIFY_USE_CCS_BLOCK
void testbench::exec_inPlaceNTT_DIT( ac_int<64, false > vec[4096], ac_int<64, false > p, ac_int<64, false > r) {
   return mc_testbench::exec_inPlaceNTT_DIT(vec, p, r);
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
// Function: capture_vec_IN
// --------------------------------------------

void mc_testbench::capture_vec_IN( ac_int<64, false > vec[4096])
{
   if (vec_IN_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_vec_IN && !testbench::vec_ignore)
   {
      int cur_iter = vec_IN_iteration_count;
      ++vec_IN_iteration_count;
      mgc_sysc_ver_array1D<ac_int<64, false >,4096> vec_IN_tmp;
      int vec_linear_idx = 0;
      for (int vec_idx_0 = 0; vec_idx_0 < 4096; ++vec_idx_0)
         vec_IN_tmp[vec_linear_idx++] = vec[vec_idx_0];
      ccs_vec_IN->put(vec_IN_tmp);
      ++vec_IN_capture_count;
      mc_testbench_util::process_wait_ctrl("vec_IN",testbench::vec_IN_wait_ctrl,ccs_wait_ctrl_vec_IN.operator->(),cur_iter,vec_IN_capture_count,0);
   }
   testbench::vec_ignore = false;
}
// ============================================
// Function: capture_vec
// --------------------------------------------

void mc_testbench::capture_vec( ac_int<64, false > vec[4096])
{
   if (_capture_vec)
   {
      int cur_iter = vec_iteration_count;
      ++vec_iteration_count;
      mc_golden_info< mgc_sysc_ver_array1D<ac_int<64, false >,4096>, MaskPacket<0, 64> > vec_tmp(testbench::vec_ignore, false, vec_iteration_count);
      vec_tmp._data.mc_testbench_process_array_bounds("vec",testbench::vec_array_comp_first,testbench::vec_array_comp_last,4095,0);
      // BEGIN: testbench output_mask control for field_name vec
      if ( testbench::vec_use_mask ) {
         sc_lv<64> tmp_mask_lv;
         type_to_vector(testbench::vec_output_mask, 64, tmp_mask_lv);
         vec_tmp._use_mask = true;
         vec_tmp._packet._mask = tmp_mask_lv;
      }
      // END: testbench output_mask control for field_name vec
      int vec_linear_idx = 0;
      for (int vec_idx_0 = 0; vec_idx_0 < 4096; ++vec_idx_0)
         vec_tmp._data[vec_linear_idx++] = vec[vec_idx_0];
      if (!testbench::vec_skip) {
         vec_golden.put(vec_tmp);
         ++vec_capture_count;
      } else {
         if (!testbench::vec_skip_quiet || !testbench::vec_skip_once) {
            std::ostringstream msg; msg.str("");
            msg << "testbench::vec_skip=true for iteration=" << vec_iteration_count << " @ " << sc_time_stamp();
            SC_REPORT_WARNING("User testbench", msg.str().c_str());
            testbench::vec_skip_once = true;
         }
      }
      mc_testbench_util::process_wait_ctrl("vec",testbench::vec_wait_ctrl,ccs_wait_ctrl_vec.operator->(),cur_iter,vec_capture_count,0);
      testbench::vec_use_mask = false;
   }
   testbench::vec_ignore = false;
   testbench::vec_skip = false;
}
// ============================================
// Function: capture_p
// --------------------------------------------

void mc_testbench::capture_p(ac_int<64, false > p)
{
   if (p_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_p && !testbench::p_ignore)
   {
      int cur_iter = p_iteration_count;
      ++p_iteration_count;
      ccs_p->put(p); // THIS
      ++p_capture_count;
      mc_testbench_util::process_wait_ctrl("p",testbench::p_wait_ctrl,ccs_wait_ctrl_p.operator->(),cur_iter,p_capture_count,0);
   }
   testbench::p_ignore = false;
}
// ============================================
// Function: capture_r
// --------------------------------------------

void mc_testbench::capture_r(ac_int<64, false > r)
{
   if (r_capture_count == wait_cnt)
      wait_on_input_required();
   if (_capture_r && !testbench::r_ignore)
   {
      int cur_iter = r_iteration_count;
      ++r_iteration_count;
      ccs_r->put(r); // THIS
      ++r_capture_count;
      mc_testbench_util::process_wait_ctrl("r",testbench::r_wait_ctrl,ccs_wait_ctrl_r.operator->(),cur_iter,r_capture_count,0);
   }
   testbench::r_ignore = false;
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
      if (_capture_vec_IN && ccs_vec_IN->used() == 0) return;
      if (_capture_p && ccs_p->used() == 0) return;
      if (_capture_r && ccs_r->used() == 0) return;
      that->cpp_testbench_active.write(false);
      if (average_period > SC_ZERO_TIME && sc_time_stamp() != timeout)
         wait(average_period * 10, ccs_vec_IN->ok_to_put() | ccs_p->ok_to_put() | ccs_r->ok_to_put());
      else
         wait(ccs_vec_IN->ok_to_put() | ccs_p->ok_to_put() | ccs_r->ok_to_put());
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

void mc_testbench::capture_IN( ac_int<64, false > vec[4096], ac_int<64, false > p, ac_int<64, false > r)
{
   that->capture_vec_IN(vec);
   that->capture_p(p);
   that->capture_r(r);
}
// ============================================
// Function: capture_OUT
// --------------------------------------------

void mc_testbench::capture_OUT( ac_int<64, false > vec[4096], ac_int<64, false > p, ac_int<64, false > r)
{
   that->capture_vec(vec);
}
// ============================================
// Function: exec_inPlaceNTT_DIT
// --------------------------------------------

void mc_testbench::exec_inPlaceNTT_DIT( ac_int<64, false > vec[4096], ac_int<64, false > p, ac_int<64, false > r)
{
   #ifndef CCS_SCVERIFY_USE_CCS_BLOCK
   that->cpp_testbench_active.write(true);
   capture_IN(vec, p, r);
   inPlaceNTT_DIT(vec, p, r);
   // throttle ac_channel based on number of calls to chan::size() or chan::empty() or chan::nb_read() (but not chan::available()) 
   if (1) {
      int cnt=0;
      if (cnt) std::cout << "mc_testbench.cpp: CONTINUES @ " << sc_time_stamp() << std::endl;
      if (cnt) that->cpp_testbench_active.write(true);
   }
   capture_OUT(vec, p, r);
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
   
   if (!_capture_vec) {
      cout<<"'vec' - warning, output was optimized away"<<endl;
   } else {
      _num_outputs_checked++;
      _failed |= vec_comp->check_results(vec_capture_count,testbench::vec_skip_noerr);
      _has_capture_counts |= !!(vec_capture_count);
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
   if (vec_comp->get_compare_count() < vec_capture_count) {testbench_end_event.notify(1,SC_NS); return;}
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
   testbench::vec_ignore = false;
   testbench::vec_skip = false;
   testbench::vec_skip_quiet = false;
   testbench::vec_skip_once = false;
   testbench::vec_skip_noerr = false;
   testbench::vec_array_comp_first = -1;
   testbench::vec_array_comp_last = -1;
   testbench::vec_IN_wait_ctrl.clear();
   vec_IN_capture_count = 0;
   vec_IN_iteration_count = 0;
   testbench::vec_use_mask = false;
   testbench::vec_output_mask = (ac_int<64, false >) ~0;
   testbench::vec_wait_ctrl.clear();
   vec_capture_count = 0;
   vec_iteration_count = 0;
   vec_IN_access_ptr = 0;
   vec_access_ptr = 0;
   testbench::p_ignore = false;
   testbench::p_skip = false;
   testbench::p_skip_quiet = false;
   testbench::p_skip_once = false;
   testbench::p_skip_noerr = false;
   testbench::p_array_comp_first = -1;
   testbench::p_array_comp_last = -1;
   testbench::p_wait_ctrl.clear();
   p_capture_count = 0;
   p_iteration_count = 0;
   testbench::r_ignore = false;
   testbench::r_skip = false;
   testbench::r_skip_quiet = false;
   testbench::r_skip_once = false;
   testbench::r_skip_noerr = false;
   testbench::r_array_comp_first = -1;
   testbench::r_array_comp_last = -1;
   testbench::r_wait_ctrl.clear();
   r_capture_count = 0;
   r_iteration_count = 0;
   testbench testbench_inst(sc_argc(), sc_argv());
   main_exit_code = testbench_inst.main();
   cout<<"Info: Execution of user-supplied C++ testbench 'main()' has completed with exit code = " << main_exit_code << endl;
   cout<<endl;
   cout<<"Info: Collecting data completed"<<endl;
   cout<<"   captured "<<vec_IN_capture_count<<" values of vec_IN"<<endl;
   cout<<"   captured "<<vec_capture_count<<" values of vec"<<endl;
   cout<<"   captured "<<p_capture_count<<" values of p"<<endl;
   cout<<"   captured "<<r_capture_count<<" values of r"<<endl;
   testbench_ended = true;
   testbench_end_event.notify(SC_ZERO_TIME);
}
#ifdef CCS_SCVERIFY_USE_CCS_BLOCK
#include "ccs_block_macros.cpp"
#endif
