// ----------------------------------------------------------------------------
// SystemC Testbench Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: yl7897@newnano.poly.edu
// Generated date: Sun Jan 02 12:34:23 EST 2022
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
   
   // Interface Ports
   sc_in< bool > clk;
   sc_port< tlm::tlm_fifo_put_if< mgc_sysc_ver_array1D<ac_int<32, false >,16> > > ccs_a;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_a;
   sc_port< tlm::tlm_fifo_get_if< mgc_sysc_ver_array1D<ac_int<32, false >,16> > > ccs_b;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_b;
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
   bool _capture_a;
   int a_capture_count;
   int a_iteration_count;
   ac_int<32, false > *a_access_ptr;
   tlm::tlm_fifo< mc_golden_info< mgc_sysc_ver_array1D<ac_int<32, false >,16>, MaskPacket<0, 32> > > b_golden;
   bool _capture_b;
   int b_capture_count;
   int b_iteration_count;
   ac_int<32, false > *b_access_ptr;
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
      , ccs_a("ccs_a")
      , ccs_wait_ctrl_a("ccs_wait_ctrl_a")
      , ccs_b("ccs_b")
      , ccs_wait_ctrl_b("ccs_wait_ctrl_b")
      , design_is_idle("design_is_idle")
      , enable_stalls("enable_stalls")
      , stall_coverage("stall_coverage")
      , cpp_testbench_active("cpp_testbench_active")
      , b_golden("b_golden",-1)
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
      _capture_a = true;
      _capture_b = true;
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
   }
   
   // C++ class functions
   public:
      static void wait_for_idle_sync() ;
   public:
      static void set_enable_stalls(bool flag) ;
   public:
      void reset_request() ;
   public:
      void capture_a( ac_int<32, false > a[16]) ;
   public:
      void capture_b( ac_int<32, false > b[16]) ;
   protected:
      void wait_on_input_required() ;
   public:
      static void capture_IN( ac_int<32, false > a[16],  ac_int<32, false > b[16]) ;
   public:
      static void capture_OUT( ac_int<32, false > a[16],  ac_int<32, false > b[16]) ;
   public:
      static void exec_axi_add( ac_int<32, false > a[16],  ac_int<32, false > b[16]) ;
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
