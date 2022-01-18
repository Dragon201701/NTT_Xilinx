// ----------------------------------------------------------------------------
// SystemC Testbench Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: yl7897@newnano.poly.edu
// Generated date: Sun Jan 02 18:33:49 EST 2022
//
// ----------------------------------------------------------------------------
#ifdef CCS_SCVERIFY

// 
// -------------------------------------
// mc_testbench
// SCVerify mc_testbench SC_MODULE
// -------------------------------------
// 
#ifndef INCLUDED_MC_TESTBENCH_H
#define INCLUDED_MC_TESTBENCH_H


#ifndef SC_USE_STD_STRING
#define SC_USE_STD_STRING
#endif

#include "../../include/axi_test.h"
#include "ccs_testbench.h"
#include <systemc.h>
#include <tlm.h>
#include <ac_int.h>
#include <ac_channel.h>
#include <mc_container_types.h>
#include <mc_typeconv.h>
#include <mc_transactors.h>
#include <mc_comparator.h>
#include <mc_end_of_testbench.h>
#include <vector>


class mc_testbench : public sc_module
{
public:
   // Module instance pointers
   mc_comparator< mgc_sysc_ver_array1D<ac_int<32, false >,16> , MaskPacket< 0, 32 > > *b_comp;
   mc_comparator< bool , MaskPacket< 1, 1 > > *complete_comp;
   
   // Interface Ports
   sc_in< bool > clk;
   sc_port< tlm::tlm_fifo_put_if< bool > > ccs_run;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_run;
   sc_port< tlm::tlm_fifo_put_if< int > > ccs_sizecount_run;
   sc_port< tlm::tlm_fifo_put_if< mgc_sysc_ver_array1D<ac_int<32, false >,16> > > ccs_a;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_a;
   sc_port< tlm::tlm_fifo_get_if< mgc_sysc_ver_array1D<ac_int<32, false >,16> > > ccs_b;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_b;
   sc_port< tlm::tlm_fifo_get_if< bool > > ccs_complete;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_complete;
   sc_in< bool > design_is_idle;
   sc_out< sc_logic > enable_stalls;
   sc_in< unsigned short > stall_coverage;
   
   // Named Objects
   
   // Data objects
   bool testbench_ended;
   int main_exit_code;
   bool atleast_one_active_input;
   sc_time last_event_time;
   sc_time last_event_time2;
   sc_signal< bool >                          cpp_testbench_active;
   sc_event testbench_end_event;
   sc_event reset_request_event;
   bool _checked_results;
   bool _failed;
   static mc_testbench* that;
   bool _channel_mismatch;
   unsigned int remaining_ccs_run;
   bool _capture_run;
   int run_capture_count;
   int run_iteration_count;
   void* run_pointer;
   bool run_pointer_set;
   bool _capture_a;
   int a_capture_count;
   int a_iteration_count;
   ac_int<32, false > *a_access_ptr;
   tlm::tlm_fifo< mc_golden_info< mgc_sysc_ver_array1D<ac_int<32, false >,16>, MaskPacket<0, 32> > > b_golden;
   bool _capture_b;
   int b_capture_count;
   int b_iteration_count;
   ac_int<32, false > *b_access_ptr;
   unsigned int remaining_complete_golden;
   tlm::tlm_fifo< mc_golden_info< bool, MaskPacket<1, 1> > > complete_golden;
   bool _capture_complete;
   int complete_capture_count;
   int complete_iteration_count;
   void* complete_pointer;
   bool complete_pointer_set;
   int wait_cnt;
   sc_time previous_timestamp;
   sc_time average_period;
   unsigned int period_counter;
   bool calculate_period;
   
   // Declare processes (SC_METHOD and SC_THREAD)
   void wait_for_end();
   void run();
   
   // Constructor
   SC_HAS_PROCESS(mc_testbench);
   mc_testbench(
      const sc_module_name& name
   )
      : clk("clk")
      , ccs_run("ccs_run")
      , ccs_wait_ctrl_run("ccs_wait_ctrl_run")
      , ccs_sizecount_run("ccs_sizecount_run")
      , ccs_a("ccs_a")
      , ccs_wait_ctrl_a("ccs_wait_ctrl_a")
      , ccs_b("ccs_b")
      , ccs_wait_ctrl_b("ccs_wait_ctrl_b")
      , ccs_complete("ccs_complete")
      , ccs_wait_ctrl_complete("ccs_wait_ctrl_complete")
      , design_is_idle("design_is_idle")
      , enable_stalls("enable_stalls")
      , stall_coverage("stall_coverage")
      , cpp_testbench_active("cpp_testbench_active")
      , remaining_ccs_run(0)
      , b_golden("b_golden",-1)
      , remaining_complete_golden(0)
      , complete_golden("complete_golden",-1)
   {
      // Instantiate other modules
      b_comp = new mc_comparator< mgc_sysc_ver_array1D<ac_int<32, false >,16> , MaskPacket< 0, 32 > > (
         "b_comp",
         "b",
         0,
         0,
         1
      );
      b_comp->data_in(ccs_b);
      b_comp->data_golden(b_golden);
      
      complete_comp = new mc_comparator< bool , MaskPacket< 1, 1 > > (
         "complete_comp",
         "complete",
         1,
         0,
         1
      );
      complete_comp->data_in(ccs_complete);
      complete_comp->data_golden(complete_golden);
      
      
      // Register processes
      SC_METHOD(wait_for_end);
      sensitive << clk.pos() << testbench_end_event;
      SC_THREAD(run);
      // Other constructor statements
      set_stack_size(64000000);
      _checked_results = false;
      that = this;
      testbench_ended = false;
      main_exit_code = 0;
      atleast_one_active_input = true;
      _failed = false;
      _capture_run = true;
      _capture_a = true;
      _capture_b = true;
      _capture_complete = true;
      wait_cnt = 0;
      previous_timestamp = SC_ZERO_TIME;
      average_period = SC_ZERO_TIME;
      period_counter = 0;
      calculate_period = true;
   }
   
   ~mc_testbench()
   {
      delete b_comp;
      b_comp = 0;
      delete complete_comp;
      complete_comp = 0;
   }
   
   // C++ class functions
   public:
      static void wait_for_idle_sync() ;
   public:
      static void set_enable_stalls(bool flag) ;
   public:
      void reset_request() ;
   public:
      void capture_run( ac_sync &run) ;
   public:
      void capture_a( ac_int<32, false > a[16]) ;
   public:
      void capture_b( ac_int<32, false > b[16]) ;
   public:
      void capture_complete( ac_sync &complete) ;
   protected:
      void wait_on_input_required() ;
   public:
      static void capture_IN( ac_sync &run,  ac_int<32, false > a[16],  ac_int<32, false > b[16],  ac_sync &complete) ;
   public:
      static void capture_OUT( ac_sync &run,  ac_int<32, false > a[16],  ac_int<32, false > b[16],  ac_sync &complete) ;
   public:
      static void exec_axi_add( ac_sync &run,  ac_int<32, false > a[16],  ac_int<32, false > b[16],  ac_sync &complete) ;
   protected:
      void start_of_simulation() ;
   protected:
      void end_of_simulation() ;
   public:
      void check_results() ;
   public:
      bool failed() ;
   public:
      void set_failed(bool fail) ;
};
#endif
#endif //CCS_SCVERIFY
