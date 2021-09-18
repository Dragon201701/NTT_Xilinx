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
    ccs_design::HDL::ntt_flat ccs_DUT_wrapper;

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
  sc_in<sc_logic> vec_rsc_s_tdone;
  sc_in<sc_logic> vec_rsc_tr_write_done;
  sc_in<sc_logic> vec_rsc_RREADY;
  sc_out<sc_logic> vec_rsc_RVALID;
  sc_out<sc_logic> vec_rsc_RUSER;
  sc_out<sc_logic> vec_rsc_RLAST;
  sc_out<sc_lv<2> > vec_rsc_RRESP;
  sc_out<sc_lv<32> > vec_rsc_RDATA;
  sc_out<sc_logic> vec_rsc_RID;
  sc_out<sc_logic> vec_rsc_ARREADY;
  sc_in<sc_logic> vec_rsc_ARVALID;
  sc_in<sc_logic> vec_rsc_ARUSER;
  sc_in<sc_lv<4> > vec_rsc_ARREGION;
  sc_in<sc_lv<4> > vec_rsc_ARQOS;
  sc_in<sc_lv<3> > vec_rsc_ARPROT;
  sc_in<sc_lv<4> > vec_rsc_ARCACHE;
  sc_in<sc_logic> vec_rsc_ARLOCK;
  sc_in<sc_lv<2> > vec_rsc_ARBURST;
  sc_in<sc_lv<3> > vec_rsc_ARSIZE;
  sc_in<sc_lv<8> > vec_rsc_ARLEN;
  sc_in<sc_lv<12> > vec_rsc_ARADDR;
  sc_in<sc_logic> vec_rsc_ARID;
  sc_in<sc_logic> vec_rsc_BREADY;
  sc_out<sc_logic> vec_rsc_BVALID;
  sc_out<sc_logic> vec_rsc_BUSER;
  sc_out<sc_lv<2> > vec_rsc_BRESP;
  sc_out<sc_logic> vec_rsc_BID;
  sc_out<sc_logic> vec_rsc_WREADY;
  sc_in<sc_logic> vec_rsc_WVALID;
  sc_in<sc_logic> vec_rsc_WUSER;
  sc_in<sc_logic> vec_rsc_WLAST;
  sc_in<sc_lv<4> > vec_rsc_WSTRB;
  sc_in<sc_lv<32> > vec_rsc_WDATA;
  sc_out<sc_logic> vec_rsc_AWREADY;
  sc_in<sc_logic> vec_rsc_AWVALID;
  sc_in<sc_logic> vec_rsc_AWUSER;
  sc_in<sc_lv<4> > vec_rsc_AWREGION;
  sc_in<sc_lv<4> > vec_rsc_AWQOS;
  sc_in<sc_lv<3> > vec_rsc_AWPROT;
  sc_in<sc_lv<4> > vec_rsc_AWCACHE;
  sc_in<sc_logic> vec_rsc_AWLOCK;
  sc_in<sc_lv<2> > vec_rsc_AWBURST;
  sc_in<sc_lv<3> > vec_rsc_AWSIZE;
  sc_in<sc_lv<8> > vec_rsc_AWLEN;
  sc_in<sc_lv<12> > vec_rsc_AWADDR;
  sc_in<sc_logic> vec_rsc_AWID;
  sc_out<sc_logic> vec_rsc_triosy_lz;
  sc_in<sc_lv<32> > p_rsc_dat;
  sc_out<sc_logic> p_rsc_triosy_lz;
  sc_in<sc_lv<32> > r_rsc_dat;
  sc_out<sc_logic> r_rsc_triosy_lz;
  sc_in<sc_logic> twiddle_rsc_s_tdone;
  sc_in<sc_logic> twiddle_rsc_tr_write_done;
  sc_in<sc_logic> twiddle_rsc_RREADY;
  sc_out<sc_logic> twiddle_rsc_RVALID;
  sc_out<sc_logic> twiddle_rsc_RUSER;
  sc_out<sc_logic> twiddle_rsc_RLAST;
  sc_out<sc_lv<2> > twiddle_rsc_RRESP;
  sc_out<sc_lv<32> > twiddle_rsc_RDATA;
  sc_out<sc_logic> twiddle_rsc_RID;
  sc_out<sc_logic> twiddle_rsc_ARREADY;
  sc_in<sc_logic> twiddle_rsc_ARVALID;
  sc_in<sc_logic> twiddle_rsc_ARUSER;
  sc_in<sc_lv<4> > twiddle_rsc_ARREGION;
  sc_in<sc_lv<4> > twiddle_rsc_ARQOS;
  sc_in<sc_lv<3> > twiddle_rsc_ARPROT;
  sc_in<sc_lv<4> > twiddle_rsc_ARCACHE;
  sc_in<sc_logic> twiddle_rsc_ARLOCK;
  sc_in<sc_lv<2> > twiddle_rsc_ARBURST;
  sc_in<sc_lv<3> > twiddle_rsc_ARSIZE;
  sc_in<sc_lv<8> > twiddle_rsc_ARLEN;
  sc_in<sc_lv<12> > twiddle_rsc_ARADDR;
  sc_in<sc_logic> twiddle_rsc_ARID;
  sc_in<sc_logic> twiddle_rsc_BREADY;
  sc_out<sc_logic> twiddle_rsc_BVALID;
  sc_out<sc_logic> twiddle_rsc_BUSER;
  sc_out<sc_lv<2> > twiddle_rsc_BRESP;
  sc_out<sc_logic> twiddle_rsc_BID;
  sc_out<sc_logic> twiddle_rsc_WREADY;
  sc_in<sc_logic> twiddle_rsc_WVALID;
  sc_in<sc_logic> twiddle_rsc_WUSER;
  sc_in<sc_logic> twiddle_rsc_WLAST;
  sc_in<sc_lv<4> > twiddle_rsc_WSTRB;
  sc_in<sc_lv<32> > twiddle_rsc_WDATA;
  sc_out<sc_logic> twiddle_rsc_AWREADY;
  sc_in<sc_logic> twiddle_rsc_AWVALID;
  sc_in<sc_logic> twiddle_rsc_AWUSER;
  sc_in<sc_lv<4> > twiddle_rsc_AWREGION;
  sc_in<sc_lv<4> > twiddle_rsc_AWQOS;
  sc_in<sc_lv<3> > twiddle_rsc_AWPROT;
  sc_in<sc_lv<4> > twiddle_rsc_AWCACHE;
  sc_in<sc_logic> twiddle_rsc_AWLOCK;
  sc_in<sc_lv<2> > twiddle_rsc_AWBURST;
  sc_in<sc_lv<3> > twiddle_rsc_AWSIZE;
  sc_in<sc_lv<8> > twiddle_rsc_AWLEN;
  sc_in<sc_lv<12> > twiddle_rsc_AWADDR;
  sc_in<sc_logic> twiddle_rsc_AWID;
  sc_out<sc_logic> twiddle_rsc_triosy_lz;
  sc_in<sc_logic> twiddle_h_rsc_s_tdone;
  sc_in<sc_logic> twiddle_h_rsc_tr_write_done;
  sc_in<sc_logic> twiddle_h_rsc_RREADY;
  sc_out<sc_logic> twiddle_h_rsc_RVALID;
  sc_out<sc_logic> twiddle_h_rsc_RUSER;
  sc_out<sc_logic> twiddle_h_rsc_RLAST;
  sc_out<sc_lv<2> > twiddle_h_rsc_RRESP;
  sc_out<sc_lv<32> > twiddle_h_rsc_RDATA;
  sc_out<sc_logic> twiddle_h_rsc_RID;
  sc_out<sc_logic> twiddle_h_rsc_ARREADY;
  sc_in<sc_logic> twiddle_h_rsc_ARVALID;
  sc_in<sc_logic> twiddle_h_rsc_ARUSER;
  sc_in<sc_lv<4> > twiddle_h_rsc_ARREGION;
  sc_in<sc_lv<4> > twiddle_h_rsc_ARQOS;
  sc_in<sc_lv<3> > twiddle_h_rsc_ARPROT;
  sc_in<sc_lv<4> > twiddle_h_rsc_ARCACHE;
  sc_in<sc_logic> twiddle_h_rsc_ARLOCK;
  sc_in<sc_lv<2> > twiddle_h_rsc_ARBURST;
  sc_in<sc_lv<3> > twiddle_h_rsc_ARSIZE;
  sc_in<sc_lv<8> > twiddle_h_rsc_ARLEN;
  sc_in<sc_lv<12> > twiddle_h_rsc_ARADDR;
  sc_in<sc_logic> twiddle_h_rsc_ARID;
  sc_in<sc_logic> twiddle_h_rsc_BREADY;
  sc_out<sc_logic> twiddle_h_rsc_BVALID;
  sc_out<sc_logic> twiddle_h_rsc_BUSER;
  sc_out<sc_lv<2> > twiddle_h_rsc_BRESP;
  sc_out<sc_logic> twiddle_h_rsc_BID;
  sc_out<sc_logic> twiddle_h_rsc_WREADY;
  sc_in<sc_logic> twiddle_h_rsc_WVALID;
  sc_in<sc_logic> twiddle_h_rsc_WUSER;
  sc_in<sc_logic> twiddle_h_rsc_WLAST;
  sc_in<sc_lv<4> > twiddle_h_rsc_WSTRB;
  sc_in<sc_lv<32> > twiddle_h_rsc_WDATA;
  sc_out<sc_logic> twiddle_h_rsc_AWREADY;
  sc_in<sc_logic> twiddle_h_rsc_AWVALID;
  sc_in<sc_logic> twiddle_h_rsc_AWUSER;
  sc_in<sc_lv<4> > twiddle_h_rsc_AWREGION;
  sc_in<sc_lv<4> > twiddle_h_rsc_AWQOS;
  sc_in<sc_lv<3> > twiddle_h_rsc_AWPROT;
  sc_in<sc_lv<4> > twiddle_h_rsc_AWCACHE;
  sc_in<sc_logic> twiddle_h_rsc_AWLOCK;
  sc_in<sc_lv<2> > twiddle_h_rsc_AWBURST;
  sc_in<sc_lv<3> > twiddle_h_rsc_AWSIZE;
  sc_in<sc_lv<8> > twiddle_h_rsc_AWLEN;
  sc_in<sc_lv<12> > twiddle_h_rsc_AWADDR;
  sc_in<sc_logic> twiddle_h_rsc_AWID;
  sc_out<sc_logic> twiddle_h_rsc_triosy_lz;
  sc_in<sc_logic> result_rsc_s_tdone;
  sc_in<sc_logic> result_rsc_tr_write_done;
  sc_in<sc_logic> result_rsc_RREADY;
  sc_out<sc_logic> result_rsc_RVALID;
  sc_out<sc_logic> result_rsc_RUSER;
  sc_out<sc_logic> result_rsc_RLAST;
  sc_out<sc_lv<2> > result_rsc_RRESP;
  sc_out<sc_lv<32> > result_rsc_RDATA;
  sc_out<sc_logic> result_rsc_RID;
  sc_out<sc_logic> result_rsc_ARREADY;
  sc_in<sc_logic> result_rsc_ARVALID;
  sc_in<sc_logic> result_rsc_ARUSER;
  sc_in<sc_lv<4> > result_rsc_ARREGION;
  sc_in<sc_lv<4> > result_rsc_ARQOS;
  sc_in<sc_lv<3> > result_rsc_ARPROT;
  sc_in<sc_lv<4> > result_rsc_ARCACHE;
  sc_in<sc_logic> result_rsc_ARLOCK;
  sc_in<sc_lv<2> > result_rsc_ARBURST;
  sc_in<sc_lv<3> > result_rsc_ARSIZE;
  sc_in<sc_lv<8> > result_rsc_ARLEN;
  sc_in<sc_lv<16> > result_rsc_ARADDR;
  sc_in<sc_logic> result_rsc_ARID;
  sc_in<sc_logic> result_rsc_BREADY;
  sc_out<sc_logic> result_rsc_BVALID;
  sc_out<sc_logic> result_rsc_BUSER;
  sc_out<sc_lv<2> > result_rsc_BRESP;
  sc_out<sc_logic> result_rsc_BID;
  sc_out<sc_logic> result_rsc_WREADY;
  sc_in<sc_logic> result_rsc_WVALID;
  sc_in<sc_logic> result_rsc_WUSER;
  sc_in<sc_logic> result_rsc_WLAST;
  sc_in<sc_lv<4> > result_rsc_WSTRB;
  sc_in<sc_lv<32> > result_rsc_WDATA;
  sc_out<sc_logic> result_rsc_AWREADY;
  sc_in<sc_logic> result_rsc_AWVALID;
  sc_in<sc_logic> result_rsc_AWUSER;
  sc_in<sc_lv<4> > result_rsc_AWREGION;
  sc_in<sc_lv<4> > result_rsc_AWQOS;
  sc_in<sc_lv<3> > result_rsc_AWPROT;
  sc_in<sc_lv<4> > result_rsc_AWCACHE;
  sc_in<sc_logic> result_rsc_AWLOCK;
  sc_in<sc_lv<2> > result_rsc_AWBURST;
  sc_in<sc_lv<3> > result_rsc_AWSIZE;
  sc_in<sc_lv<8> > result_rsc_AWLEN;
  sc_in<sc_lv<16> > result_rsc_AWADDR;
  sc_in<sc_logic> result_rsc_AWID;
  sc_out<sc_logic> result_rsc_triosy_lz;
public:
  ccs_DUT_wrapper(const sc_module_name& nm, const char *hdl_name)
  :
    mc_foreign_module(nm, hdl_name), 
    clk("clk"), 
    rst("rst"), 
    vec_rsc_s_tdone("vec_rsc_s_tdone"), 
    vec_rsc_tr_write_done("vec_rsc_tr_write_done"), 
    vec_rsc_RREADY("vec_rsc_RREADY"), 
    vec_rsc_RVALID("vec_rsc_RVALID"), 
    vec_rsc_RUSER("vec_rsc_RUSER"), 
    vec_rsc_RLAST("vec_rsc_RLAST"), 
    vec_rsc_RRESP("vec_rsc_RRESP"), 
    vec_rsc_RDATA("vec_rsc_RDATA"), 
    vec_rsc_RID("vec_rsc_RID"), 
    vec_rsc_ARREADY("vec_rsc_ARREADY"), 
    vec_rsc_ARVALID("vec_rsc_ARVALID"), 
    vec_rsc_ARUSER("vec_rsc_ARUSER"), 
    vec_rsc_ARREGION("vec_rsc_ARREGION"), 
    vec_rsc_ARQOS("vec_rsc_ARQOS"), 
    vec_rsc_ARPROT("vec_rsc_ARPROT"), 
    vec_rsc_ARCACHE("vec_rsc_ARCACHE"), 
    vec_rsc_ARLOCK("vec_rsc_ARLOCK"), 
    vec_rsc_ARBURST("vec_rsc_ARBURST"), 
    vec_rsc_ARSIZE("vec_rsc_ARSIZE"), 
    vec_rsc_ARLEN("vec_rsc_ARLEN"), 
    vec_rsc_ARADDR("vec_rsc_ARADDR"), 
    vec_rsc_ARID("vec_rsc_ARID"), 
    vec_rsc_BREADY("vec_rsc_BREADY"), 
    vec_rsc_BVALID("vec_rsc_BVALID"), 
    vec_rsc_BUSER("vec_rsc_BUSER"), 
    vec_rsc_BRESP("vec_rsc_BRESP"), 
    vec_rsc_BID("vec_rsc_BID"), 
    vec_rsc_WREADY("vec_rsc_WREADY"), 
    vec_rsc_WVALID("vec_rsc_WVALID"), 
    vec_rsc_WUSER("vec_rsc_WUSER"), 
    vec_rsc_WLAST("vec_rsc_WLAST"), 
    vec_rsc_WSTRB("vec_rsc_WSTRB"), 
    vec_rsc_WDATA("vec_rsc_WDATA"), 
    vec_rsc_AWREADY("vec_rsc_AWREADY"), 
    vec_rsc_AWVALID("vec_rsc_AWVALID"), 
    vec_rsc_AWUSER("vec_rsc_AWUSER"), 
    vec_rsc_AWREGION("vec_rsc_AWREGION"), 
    vec_rsc_AWQOS("vec_rsc_AWQOS"), 
    vec_rsc_AWPROT("vec_rsc_AWPROT"), 
    vec_rsc_AWCACHE("vec_rsc_AWCACHE"), 
    vec_rsc_AWLOCK("vec_rsc_AWLOCK"), 
    vec_rsc_AWBURST("vec_rsc_AWBURST"), 
    vec_rsc_AWSIZE("vec_rsc_AWSIZE"), 
    vec_rsc_AWLEN("vec_rsc_AWLEN"), 
    vec_rsc_AWADDR("vec_rsc_AWADDR"), 
    vec_rsc_AWID("vec_rsc_AWID"), 
    vec_rsc_triosy_lz("vec_rsc_triosy_lz"), 
    p_rsc_dat("p_rsc_dat"), 
    p_rsc_triosy_lz("p_rsc_triosy_lz"), 
    r_rsc_dat("r_rsc_dat"), 
    r_rsc_triosy_lz("r_rsc_triosy_lz"), 
    twiddle_rsc_s_tdone("twiddle_rsc_s_tdone"), 
    twiddle_rsc_tr_write_done("twiddle_rsc_tr_write_done"), 
    twiddle_rsc_RREADY("twiddle_rsc_RREADY"), 
    twiddle_rsc_RVALID("twiddle_rsc_RVALID"), 
    twiddle_rsc_RUSER("twiddle_rsc_RUSER"), 
    twiddle_rsc_RLAST("twiddle_rsc_RLAST"), 
    twiddle_rsc_RRESP("twiddle_rsc_RRESP"), 
    twiddle_rsc_RDATA("twiddle_rsc_RDATA"), 
    twiddle_rsc_RID("twiddle_rsc_RID"), 
    twiddle_rsc_ARREADY("twiddle_rsc_ARREADY"), 
    twiddle_rsc_ARVALID("twiddle_rsc_ARVALID"), 
    twiddle_rsc_ARUSER("twiddle_rsc_ARUSER"), 
    twiddle_rsc_ARREGION("twiddle_rsc_ARREGION"), 
    twiddle_rsc_ARQOS("twiddle_rsc_ARQOS"), 
    twiddle_rsc_ARPROT("twiddle_rsc_ARPROT"), 
    twiddle_rsc_ARCACHE("twiddle_rsc_ARCACHE"), 
    twiddle_rsc_ARLOCK("twiddle_rsc_ARLOCK"), 
    twiddle_rsc_ARBURST("twiddle_rsc_ARBURST"), 
    twiddle_rsc_ARSIZE("twiddle_rsc_ARSIZE"), 
    twiddle_rsc_ARLEN("twiddle_rsc_ARLEN"), 
    twiddle_rsc_ARADDR("twiddle_rsc_ARADDR"), 
    twiddle_rsc_ARID("twiddle_rsc_ARID"), 
    twiddle_rsc_BREADY("twiddle_rsc_BREADY"), 
    twiddle_rsc_BVALID("twiddle_rsc_BVALID"), 
    twiddle_rsc_BUSER("twiddle_rsc_BUSER"), 
    twiddle_rsc_BRESP("twiddle_rsc_BRESP"), 
    twiddle_rsc_BID("twiddle_rsc_BID"), 
    twiddle_rsc_WREADY("twiddle_rsc_WREADY"), 
    twiddle_rsc_WVALID("twiddle_rsc_WVALID"), 
    twiddle_rsc_WUSER("twiddle_rsc_WUSER"), 
    twiddle_rsc_WLAST("twiddle_rsc_WLAST"), 
    twiddle_rsc_WSTRB("twiddle_rsc_WSTRB"), 
    twiddle_rsc_WDATA("twiddle_rsc_WDATA"), 
    twiddle_rsc_AWREADY("twiddle_rsc_AWREADY"), 
    twiddle_rsc_AWVALID("twiddle_rsc_AWVALID"), 
    twiddle_rsc_AWUSER("twiddle_rsc_AWUSER"), 
    twiddle_rsc_AWREGION("twiddle_rsc_AWREGION"), 
    twiddle_rsc_AWQOS("twiddle_rsc_AWQOS"), 
    twiddle_rsc_AWPROT("twiddle_rsc_AWPROT"), 
    twiddle_rsc_AWCACHE("twiddle_rsc_AWCACHE"), 
    twiddle_rsc_AWLOCK("twiddle_rsc_AWLOCK"), 
    twiddle_rsc_AWBURST("twiddle_rsc_AWBURST"), 
    twiddle_rsc_AWSIZE("twiddle_rsc_AWSIZE"), 
    twiddle_rsc_AWLEN("twiddle_rsc_AWLEN"), 
    twiddle_rsc_AWADDR("twiddle_rsc_AWADDR"), 
    twiddle_rsc_AWID("twiddle_rsc_AWID"), 
    twiddle_rsc_triosy_lz("twiddle_rsc_triosy_lz"), 
    twiddle_h_rsc_s_tdone("twiddle_h_rsc_s_tdone"), 
    twiddle_h_rsc_tr_write_done("twiddle_h_rsc_tr_write_done"), 
    twiddle_h_rsc_RREADY("twiddle_h_rsc_RREADY"), 
    twiddle_h_rsc_RVALID("twiddle_h_rsc_RVALID"), 
    twiddle_h_rsc_RUSER("twiddle_h_rsc_RUSER"), 
    twiddle_h_rsc_RLAST("twiddle_h_rsc_RLAST"), 
    twiddle_h_rsc_RRESP("twiddle_h_rsc_RRESP"), 
    twiddle_h_rsc_RDATA("twiddle_h_rsc_RDATA"), 
    twiddle_h_rsc_RID("twiddle_h_rsc_RID"), 
    twiddle_h_rsc_ARREADY("twiddle_h_rsc_ARREADY"), 
    twiddle_h_rsc_ARVALID("twiddle_h_rsc_ARVALID"), 
    twiddle_h_rsc_ARUSER("twiddle_h_rsc_ARUSER"), 
    twiddle_h_rsc_ARREGION("twiddle_h_rsc_ARREGION"), 
    twiddle_h_rsc_ARQOS("twiddle_h_rsc_ARQOS"), 
    twiddle_h_rsc_ARPROT("twiddle_h_rsc_ARPROT"), 
    twiddle_h_rsc_ARCACHE("twiddle_h_rsc_ARCACHE"), 
    twiddle_h_rsc_ARLOCK("twiddle_h_rsc_ARLOCK"), 
    twiddle_h_rsc_ARBURST("twiddle_h_rsc_ARBURST"), 
    twiddle_h_rsc_ARSIZE("twiddle_h_rsc_ARSIZE"), 
    twiddle_h_rsc_ARLEN("twiddle_h_rsc_ARLEN"), 
    twiddle_h_rsc_ARADDR("twiddle_h_rsc_ARADDR"), 
    twiddle_h_rsc_ARID("twiddle_h_rsc_ARID"), 
    twiddle_h_rsc_BREADY("twiddle_h_rsc_BREADY"), 
    twiddle_h_rsc_BVALID("twiddle_h_rsc_BVALID"), 
    twiddle_h_rsc_BUSER("twiddle_h_rsc_BUSER"), 
    twiddle_h_rsc_BRESP("twiddle_h_rsc_BRESP"), 
    twiddle_h_rsc_BID("twiddle_h_rsc_BID"), 
    twiddle_h_rsc_WREADY("twiddle_h_rsc_WREADY"), 
    twiddle_h_rsc_WVALID("twiddle_h_rsc_WVALID"), 
    twiddle_h_rsc_WUSER("twiddle_h_rsc_WUSER"), 
    twiddle_h_rsc_WLAST("twiddle_h_rsc_WLAST"), 
    twiddle_h_rsc_WSTRB("twiddle_h_rsc_WSTRB"), 
    twiddle_h_rsc_WDATA("twiddle_h_rsc_WDATA"), 
    twiddle_h_rsc_AWREADY("twiddle_h_rsc_AWREADY"), 
    twiddle_h_rsc_AWVALID("twiddle_h_rsc_AWVALID"), 
    twiddle_h_rsc_AWUSER("twiddle_h_rsc_AWUSER"), 
    twiddle_h_rsc_AWREGION("twiddle_h_rsc_AWREGION"), 
    twiddle_h_rsc_AWQOS("twiddle_h_rsc_AWQOS"), 
    twiddle_h_rsc_AWPROT("twiddle_h_rsc_AWPROT"), 
    twiddle_h_rsc_AWCACHE("twiddle_h_rsc_AWCACHE"), 
    twiddle_h_rsc_AWLOCK("twiddle_h_rsc_AWLOCK"), 
    twiddle_h_rsc_AWBURST("twiddle_h_rsc_AWBURST"), 
    twiddle_h_rsc_AWSIZE("twiddle_h_rsc_AWSIZE"), 
    twiddle_h_rsc_AWLEN("twiddle_h_rsc_AWLEN"), 
    twiddle_h_rsc_AWADDR("twiddle_h_rsc_AWADDR"), 
    twiddle_h_rsc_AWID("twiddle_h_rsc_AWID"), 
    twiddle_h_rsc_triosy_lz("twiddle_h_rsc_triosy_lz"), 
    result_rsc_s_tdone("result_rsc_s_tdone"), 
    result_rsc_tr_write_done("result_rsc_tr_write_done"), 
    result_rsc_RREADY("result_rsc_RREADY"), 
    result_rsc_RVALID("result_rsc_RVALID"), 
    result_rsc_RUSER("result_rsc_RUSER"), 
    result_rsc_RLAST("result_rsc_RLAST"), 
    result_rsc_RRESP("result_rsc_RRESP"), 
    result_rsc_RDATA("result_rsc_RDATA"), 
    result_rsc_RID("result_rsc_RID"), 
    result_rsc_ARREADY("result_rsc_ARREADY"), 
    result_rsc_ARVALID("result_rsc_ARVALID"), 
    result_rsc_ARUSER("result_rsc_ARUSER"), 
    result_rsc_ARREGION("result_rsc_ARREGION"), 
    result_rsc_ARQOS("result_rsc_ARQOS"), 
    result_rsc_ARPROT("result_rsc_ARPROT"), 
    result_rsc_ARCACHE("result_rsc_ARCACHE"), 
    result_rsc_ARLOCK("result_rsc_ARLOCK"), 
    result_rsc_ARBURST("result_rsc_ARBURST"), 
    result_rsc_ARSIZE("result_rsc_ARSIZE"), 
    result_rsc_ARLEN("result_rsc_ARLEN"), 
    result_rsc_ARADDR("result_rsc_ARADDR"), 
    result_rsc_ARID("result_rsc_ARID"), 
    result_rsc_BREADY("result_rsc_BREADY"), 
    result_rsc_BVALID("result_rsc_BVALID"), 
    result_rsc_BUSER("result_rsc_BUSER"), 
    result_rsc_BRESP("result_rsc_BRESP"), 
    result_rsc_BID("result_rsc_BID"), 
    result_rsc_WREADY("result_rsc_WREADY"), 
    result_rsc_WVALID("result_rsc_WVALID"), 
    result_rsc_WUSER("result_rsc_WUSER"), 
    result_rsc_WLAST("result_rsc_WLAST"), 
    result_rsc_WSTRB("result_rsc_WSTRB"), 
    result_rsc_WDATA("result_rsc_WDATA"), 
    result_rsc_AWREADY("result_rsc_AWREADY"), 
    result_rsc_AWVALID("result_rsc_AWVALID"), 
    result_rsc_AWUSER("result_rsc_AWUSER"), 
    result_rsc_AWREGION("result_rsc_AWREGION"), 
    result_rsc_AWQOS("result_rsc_AWQOS"), 
    result_rsc_AWPROT("result_rsc_AWPROT"), 
    result_rsc_AWCACHE("result_rsc_AWCACHE"), 
    result_rsc_AWLOCK("result_rsc_AWLOCK"), 
    result_rsc_AWBURST("result_rsc_AWBURST"), 
    result_rsc_AWSIZE("result_rsc_AWSIZE"), 
    result_rsc_AWLEN("result_rsc_AWLEN"), 
    result_rsc_AWADDR("result_rsc_AWADDR"), 
    result_rsc_AWID("result_rsc_AWID"), 
    result_rsc_triosy_lz("result_rsc_triosy_lz")
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


