// Generated by ZYANG
#ifndef INCLUDED_CCS_DUT_WRAPPER_H
#define INCLUDED_CCS_DUT_WRAPPER_H

#ifndef SC_USE_STD_STRING
#define SC_USE_STD_STRING
#endif

#include <systemc.h>
#include <mc_simulator_extensions.h>

#ifdef CCS_SYSC
namespace HDL {
#endif
#if defined(CCS_DUT_SYSC)
// alias ccs_DUT_wrapper to namespace enclosure of either cycle or RTL SystemC netlist
namespace
    ccs_design {
#if defined(CCS_DUT_CYCLE)
#include "cycle.cxx"
#else
#if defined(CCS_DUT_RTL)
#include "rtl.cxx"
#endif
#endif
}
typedef
    ccs_design::HDL::DIT_RELOOP ccs_DUT_wrapper;

#else

// Create a foreign module wrapper around the HDL
#ifdef VCS_SYSTEMC
// VCS support - ccs_DUT_wrapper is derived from VCS-generated SystemC wrapper around HDL code
class ccs_DUT_wrapper : public TOP_HDL_ENTITY
{
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  : TOP_HDL_ENTITY(nm)
  {
  // elaborate_foreign_module(hdl_name);
  }

  ~ccs_DUT_wrapper() {}
};

#else
// non VCS simulators - ccs_DUT_wrapper is derived from mc_foreign_module (adding 2nd ctor arg)
class ccs_DUT_wrapper: public mc_foreign_module
{
public:
  // Interface Ports
  sc_in<bool> clk;
  sc_in<sc_logic> rst;
  sc_out<sc_lv<9> > vec_rsc_0_0_radr;
  sc_out<sc_logic> vec_rsc_0_0_re;
  sc_in<sc_lv<64> > vec_rsc_0_0_q;
  sc_out<sc_lv<9> > vec_rsc_0_0_wadr;
  sc_out<sc_lv<64> > vec_rsc_0_0_d;
  sc_out<sc_logic> vec_rsc_0_0_we;
  sc_out<sc_logic> vec_rsc_triosy_0_0_lz;
  sc_out<sc_lv<9> > vec_rsc_0_1_radr;
  sc_out<sc_logic> vec_rsc_0_1_re;
  sc_in<sc_lv<64> > vec_rsc_0_1_q;
  sc_out<sc_lv<9> > vec_rsc_0_1_wadr;
  sc_out<sc_lv<64> > vec_rsc_0_1_d;
  sc_out<sc_logic> vec_rsc_0_1_we;
  sc_out<sc_logic> vec_rsc_triosy_0_1_lz;
  sc_in<sc_lv<64> > p_rsc_dat;
  sc_out<sc_logic> p_rsc_triosy_lz;
  sc_in<sc_lv<64> > r_rsc_dat;
  sc_out<sc_logic> r_rsc_triosy_lz;
  sc_out<sc_lv<9> > twiddle_rsc_0_0_radr;
  sc_out<sc_logic> twiddle_rsc_0_0_re;
  sc_in<sc_lv<64> > twiddle_rsc_0_0_q;
  sc_out<sc_logic> twiddle_rsc_triosy_0_0_lz;
  sc_out<sc_lv<9> > twiddle_rsc_0_1_radr;
  sc_out<sc_logic> twiddle_rsc_0_1_re;
  sc_in<sc_lv<64> > twiddle_rsc_0_1_q;
  sc_out<sc_logic> twiddle_rsc_triosy_0_1_lz;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    vec_rsc_0_0_radr("vec_rsc_0_0_radr"), 
    vec_rsc_0_0_re("vec_rsc_0_0_re"), 
    vec_rsc_0_0_q("vec_rsc_0_0_q"), 
    vec_rsc_0_0_wadr("vec_rsc_0_0_wadr"), 
    vec_rsc_0_0_d("vec_rsc_0_0_d"), 
    vec_rsc_0_0_we("vec_rsc_0_0_we"), 
    vec_rsc_triosy_0_0_lz("vec_rsc_triosy_0_0_lz"), 
    vec_rsc_0_1_radr("vec_rsc_0_1_radr"), 
    vec_rsc_0_1_re("vec_rsc_0_1_re"), 
    vec_rsc_0_1_q("vec_rsc_0_1_q"), 
    vec_rsc_0_1_wadr("vec_rsc_0_1_wadr"), 
    vec_rsc_0_1_d("vec_rsc_0_1_d"), 
    vec_rsc_0_1_we("vec_rsc_0_1_we"), 
    vec_rsc_triosy_0_1_lz("vec_rsc_triosy_0_1_lz"), 
    p_rsc_dat("p_rsc_dat"), 
    p_rsc_triosy_lz("p_rsc_triosy_lz"), 
    r_rsc_dat("r_rsc_dat"), 
    r_rsc_triosy_lz("r_rsc_triosy_lz"), 
    twiddle_rsc_0_0_radr("twiddle_rsc_0_0_radr"), 
    twiddle_rsc_0_0_re("twiddle_rsc_0_0_re"), 
    twiddle_rsc_0_0_q("twiddle_rsc_0_0_q"), 
    twiddle_rsc_triosy_0_0_lz("twiddle_rsc_triosy_0_0_lz"), 
    twiddle_rsc_0_1_radr("twiddle_rsc_0_1_radr"), 
    twiddle_rsc_0_1_re("twiddle_rsc_0_1_re"), 
    twiddle_rsc_0_1_q("twiddle_rsc_0_1_q"), 
    twiddle_rsc_triosy_0_1_lz("twiddle_rsc_triosy_0_1_lz")
  {
    elaborate_foreign_module(hdl_name);
  }

  ~ccs_DUT_wrapper() {}
};
#endif

#endif

#ifdef CCS_SYSC
} // end namespace HDL
#endif
#endif


