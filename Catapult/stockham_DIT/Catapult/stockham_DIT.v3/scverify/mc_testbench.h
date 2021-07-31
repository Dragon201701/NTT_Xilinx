// ----------------------------------------------------------------------------
// SystemC Testbench Header
//
//    HLS version: 10.5c/896140 Production Release
//       HLS date: Sun Sep  6 22:45:38 PDT 2020
//  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
//
//   Generated by: yl7897@newnano.poly.edu
// Generated date: Thu Jul 29 10:48:26 EDT 2021
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

#include "../../include/ntt.h"
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
   mc_comparator< mgc_sysc_ver_array1D<ac_int<64, false >,1024> , MaskPacket< 0, 64 > > *xt_comp;
   
   // Interface Ports
   sc_in< bool > clk;
   sc_port< tlm::tlm_fifo_put_if< mgc_sysc_ver_array1D<ac_int<64, false >,1024> > > ccs_xt_IN;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_xt_IN;
   sc_port< tlm::tlm_fifo_get_if< mgc_sysc_ver_array1D<ac_int<64, false >,1024> > > ccs_xt;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_xt;
   sc_port< tlm::tlm_fifo_put_if< ac_int<64, false > > > ccs_p;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_p;
   sc_port< tlm::tlm_fifo_put_if< ac_int<64, false > > > ccs_g;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_g;
   sc_port< tlm::tlm_fifo_put_if< mgc_sysc_ver_array1D<ac_int<64, false >,1024> > > ccs_twiddle;
   sc_port< tlm::tlm_fifo_put_if< mc_wait_ctrl > > ccs_wait_ctrl_twiddle;
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
   bool _capture_xt_IN;
   int xt_IN_capture_count;
   int xt_IN_iteration_count;
   tlm::tlm_fifo< mc_golden_info< mgc_sysc_ver_array1D<ac_int<64, false >,1024>, MaskPacket<0, 64> > > xt_golden;
   bool _capture_xt;
   int xt_capture_count;
   int xt_iteration_count;
   ac_int<64, false > *xt_IN_access_ptr;
   ac_int<64, false > *xt_access_ptr;
   bool _capture_p;
   int p_capture_count;
   int p_iteration_count;
   bool _capture_g;
   int g_capture_count;
   int g_iteration_count;
   bool _capture_twiddle;
   int twiddle_capture_count;
   int twiddle_iteration_count;
   ac_int<64, false > *twiddle_access_ptr;
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
      , ccs_xt_IN("ccs_xt_IN")
      , ccs_wait_ctrl_xt_IN("ccs_wait_ctrl_xt_IN")
      , ccs_xt("ccs_xt")
      , ccs_wait_ctrl_xt("ccs_wait_ctrl_xt")
      , ccs_p("ccs_p")
      , ccs_wait_ctrl_p("ccs_wait_ctrl_p")
      , ccs_g("ccs_g")
      , ccs_wait_ctrl_g("ccs_wait_ctrl_g")
      , ccs_twiddle("ccs_twiddle")
      , ccs_wait_ctrl_twiddle("ccs_wait_ctrl_twiddle")
      , design_is_idle("design_is_idle")
      , enable_stalls("enable_stalls")
      , stall_coverage("stall_coverage")
      , cpp_testbench_active("cpp_testbench_active")
      , xt_golden("xt_golden",-1)
   {
      // Instantiate other modules
      xt_comp = new mc_comparator< mgc_sysc_ver_array1D<ac_int<64, false >,1024> , MaskPacket< 0, 64 > > (
         "xt_comp",
         "xt",
         0,
         0,
         1
      );
      xt_comp->data_in(ccs_xt);
      xt_comp->data_golden(xt_golden);
      
      
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
      _capture_xt_IN = true;
      _capture_xt = true;
      _capture_p = true;
      _capture_g = true;
      _capture_twiddle = true;
      wait_cnt = 0;
      previous_timestamp = SC_ZERO_TIME;
      average_period = SC_ZERO_TIME;
      period_counter = 0;
      calculate_period = true;
   }
   
   ~mc_testbench()
   {
      delete xt_comp;
      xt_comp = 0;
   }
   
   // C++ class functions
   public:
      static void wait_for_idle_sync() ;
   public:
      static void set_enable_stalls(bool flag) ;
   public:
      void reset_request() ;
   public:
      void capture_xt_IN( ac_int<64, false > xt[1024]) ;
   public:
      void capture_xt( ac_int<64, false > xt[1024]) ;
   public:
      void capture_p(ac_int<64, false > p) ;
   public:
      void capture_g(ac_int<64, false > g) ;
   public:
      void capture_twiddle( ac_int<64, false > twiddle[1024]) ;
   protected:
      void wait_on_input_required() ;
   public:
      static void capture_IN( ac_int<64, false > xt[1024], ac_int<64, false > p, ac_int<64, false > g,  ac_int<64, false > twiddle[1024]) ;
   public:
      static void capture_OUT( ac_int<64, false > xt[1024], ac_int<64, false > p, ac_int<64, false > g,  ac_int<64, false > twiddle[1024]) ;
   public:
      static void exec_stockham_DIT( ac_int<64, false > xt[1024], ac_int<64, false > p, ac_int<64, false > g,  ac_int<64, false > twiddle[1024]) ;
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
