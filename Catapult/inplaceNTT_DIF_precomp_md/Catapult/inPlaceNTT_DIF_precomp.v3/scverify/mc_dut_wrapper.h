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
    ccs_design::HDL::inPlaceNTT_DIF_precomp ccs_DUT_wrapper;

#else

// Create a foreign module wrapper around
    // the HDL
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
  sc_out<sc_logic> run_rsc_rdy;
  sc_in<sc_logic> run_rsc_vld;
  sc_out<sc_lv<9> > vec_rsc_0_0_adra;
  sc_out<sc_lv<32> > vec_rsc_0_0_da;
  sc_out<sc_logic> vec_rsc_0_0_wea;
  sc_in<sc_lv<32> > vec_rsc_0_0_qa;
  sc_out<sc_lv<9> > vec_rsc_0_0_adrb;
  sc_out<sc_lv<32> > vec_rsc_0_0_db;
  sc_out<sc_logic> vec_rsc_0_0_web;
  sc_in<sc_lv<32> > vec_rsc_0_0_qb;
  sc_out<sc_logic> vec_rsc_triosy_0_0_lz;
  sc_out<sc_lv<9> > vec_rsc_0_1_adra;
  sc_out<sc_lv<32> > vec_rsc_0_1_da;
  sc_out<sc_logic> vec_rsc_0_1_wea;
  sc_in<sc_lv<32> > vec_rsc_0_1_qa;
  sc_out<sc_lv<9> > vec_rsc_0_1_adrb;
  sc_out<sc_lv<32> > vec_rsc_0_1_db;
  sc_out<sc_logic> vec_rsc_0_1_web;
  sc_in<sc_lv<32> > vec_rsc_0_1_qb;
  sc_out<sc_logic> vec_rsc_triosy_0_1_lz;
  sc_in<sc_lv<32> > p_rsc_dat;
  sc_out<sc_logic> p_rsc_triosy_lz;
  sc_in<sc_lv<32> > r_rsc_dat;
  sc_out<sc_logic> r_rsc_triosy_lz;
  sc_out<sc_lv<10> > twiddle_rsc_adrb;
  sc_in<sc_lv<32> > twiddle_rsc_qb;
  sc_out<sc_logic> twiddle_rsc_triosy_lz;
  sc_out<sc_lv<10> > twiddle_h_rsc_adrb;
  sc_in<sc_lv<32> > twiddle_h_rsc_qb;
  sc_out<sc_logic> twiddle_h_rsc_triosy_lz;
  sc_in<sc_logic> complete_rsc_rdy;
  sc_out<sc_logic> complete_rsc_vld;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    run_rsc_rdy("run_rsc_rdy"), 
    run_rsc_vld("run_rsc_vld"), 
    vec_rsc_0_0_adra("vec_rsc_0_0_adra"), 
    vec_rsc_0_0_da("vec_rsc_0_0_da"), 
    vec_rsc_0_0_wea("vec_rsc_0_0_wea"), 
    vec_rsc_0_0_qa("vec_rsc_0_0_qa"), 
    vec_rsc_0_0_adrb("vec_rsc_0_0_adrb"), 
    vec_rsc_0_0_db("vec_rsc_0_0_db"), 
    vec_rsc_0_0_web("vec_rsc_0_0_web"), 
    vec_rsc_0_0_qb("vec_rsc_0_0_qb"), 
    vec_rsc_triosy_0_0_lz("vec_rsc_triosy_0_0_lz"), 
    vec_rsc_0_1_adra("vec_rsc_0_1_adra"), 
    vec_rsc_0_1_da("vec_rsc_0_1_da"), 
    vec_rsc_0_1_wea("vec_rsc_0_1_wea"), 
    vec_rsc_0_1_qa("vec_rsc_0_1_qa"), 
    vec_rsc_0_1_adrb("vec_rsc_0_1_adrb"), 
    vec_rsc_0_1_db("vec_rsc_0_1_db"), 
    vec_rsc_0_1_web("vec_rsc_0_1_web"), 
    vec_rsc_0_1_qb("vec_rsc_0_1_qb"), 
    vec_rsc_triosy_0_1_lz("vec_rsc_triosy_0_1_lz"), 
    p_rsc_dat("p_rsc_dat"), 
    p_rsc_triosy_lz("p_rsc_triosy_lz"), 
    r_rsc_dat("r_rsc_dat"), 
    r_rsc_triosy_lz("r_rsc_triosy_lz"), 
    twiddle_rsc_adrb("twiddle_rsc_adrb"), 
    twiddle_rsc_qb("twiddle_rsc_qb"), 
    twiddle_rsc_triosy_lz("twiddle_rsc_triosy_lz"), 
    twiddle_h_rsc_adrb("twiddle_h_rsc_adrb"), 
    twiddle_h_rsc_qb("twiddle_h_rsc_qb"), 
    twiddle_h_rsc_triosy_lz("twiddle_h_rsc_triosy_lz"), 
    complete_rsc_rdy("complete_rsc_rdy"), 
    complete_rsc_vld("complete_rsc_vld")
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


