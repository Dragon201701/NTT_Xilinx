#include <string>
#include <fstream>
#include <iostream>
#include "mc_testbench.h"
#include <mc_reset.h>
#include <mc_transactors.h>
#include <mc_scverify.h>
#include <mc_stall_ctrl.h>
#include "/opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/ccs_xilinx/hdl/BLOCK_1R1W_RBW_trans_rsc.h"
#include "ccs_ioport_trans_rsc_v1.h"
#include <mc_monitor.h>
#include <mc_simulator_extensions.h>
#include "mc_dut_wrapper.h"
#include "ccs_probes.cpp"
#include <mt19937ar.c>
#ifndef TO_QUOTED_STRING
#define TO_QUOTED_STRING(x) TO_QUOTED_STRING1(x)
#define TO_QUOTED_STRING1(x) #x
#endif
#ifndef TOP_HDL_ENTITY
#define TOP_HDL_ENTITY inPlaceNTT_DIF
#endif
// Hold time for the SCVerify testbench to account for the gate delay after downstream synthesis in pico second(s)
// Hold time value is obtained from 'top_gate_constraints.cpp', which is generated at the end of RTL synthesis
#ifdef CCS_DUT_GATE
extern double __scv_hold_time;
extern double __scv_hold_time_RSCID_5;
extern double __scv_hold_time_RSCID_6;
extern double __scv_hold_time_RSCID_9;
extern double __scv_hold_time_RSCID_10;
extern double __scv_hold_time_RSCID_11;
extern double __scv_hold_time_RSCID_12;
extern double __scv_hold_time_RSCID_13;
extern double __scv_hold_time_RSCID_14;
extern double __scv_hold_time_RSCID_15;
extern double __scv_hold_time_RSCID_16;
extern double __scv_hold_time_RSCID_17;
extern double __scv_hold_time_RSCID_18;
extern double __scv_hold_time_RSCID_19;
extern double __scv_hold_time_RSCID_20;
extern double __scv_hold_time_RSCID_21;
extern double __scv_hold_time_RSCID_22;
extern double __scv_hold_time_RSCID_23;
extern double __scv_hold_time_RSCID_24;
extern double __scv_hold_time_RSCID_25;
extern double __scv_hold_time_RSCID_26;
extern double __scv_hold_time_RSCID_27;
extern double __scv_hold_time_RSCID_28;
extern double __scv_hold_time_RSCID_29;
extern double __scv_hold_time_RSCID_30;
extern double __scv_hold_time_RSCID_31;
extern double __scv_hold_time_RSCID_32;
extern double __scv_hold_time_RSCID_33;
extern double __scv_hold_time_RSCID_34;
extern double __scv_hold_time_RSCID_35;
extern double __scv_hold_time_RSCID_36;
extern double __scv_hold_time_RSCID_37;
extern double __scv_hold_time_RSCID_38;
extern double __scv_hold_time_RSCID_39;
extern double __scv_hold_time_RSCID_40;
#else
double __scv_hold_time = 0.0; // default for non-gate simulation is zero
double __scv_hold_time_RSCID_5 = 0;
double __scv_hold_time_RSCID_6 = 0;
double __scv_hold_time_RSCID_9 = 0;
double __scv_hold_time_RSCID_10 = 0;
double __scv_hold_time_RSCID_11 = 0;
double __scv_hold_time_RSCID_12 = 0;
double __scv_hold_time_RSCID_13 = 0;
double __scv_hold_time_RSCID_14 = 0;
double __scv_hold_time_RSCID_15 = 0;
double __scv_hold_time_RSCID_16 = 0;
double __scv_hold_time_RSCID_17 = 0;
double __scv_hold_time_RSCID_18 = 0;
double __scv_hold_time_RSCID_19 = 0;
double __scv_hold_time_RSCID_20 = 0;
double __scv_hold_time_RSCID_21 = 0;
double __scv_hold_time_RSCID_22 = 0;
double __scv_hold_time_RSCID_23 = 0;
double __scv_hold_time_RSCID_24 = 0;
double __scv_hold_time_RSCID_25 = 0;
double __scv_hold_time_RSCID_26 = 0;
double __scv_hold_time_RSCID_27 = 0;
double __scv_hold_time_RSCID_28 = 0;
double __scv_hold_time_RSCID_29 = 0;
double __scv_hold_time_RSCID_30 = 0;
double __scv_hold_time_RSCID_31 = 0;
double __scv_hold_time_RSCID_32 = 0;
double __scv_hold_time_RSCID_33 = 0;
double __scv_hold_time_RSCID_34 = 0;
double __scv_hold_time_RSCID_35 = 0;
double __scv_hold_time_RSCID_36 = 0;
double __scv_hold_time_RSCID_37 = 0;
double __scv_hold_time_RSCID_38 = 0;
double __scv_hold_time_RSCID_39 = 0;
double __scv_hold_time_RSCID_40 = 0;
#endif

class scverify_top : public sc_module
{
public:
  sc_signal<sc_logic>                                                          rst;
  sc_signal<sc_logic>                                                          rst_n;
  sc_signal<sc_logic>                                                          SIG_SC_LOGIC_0;
  sc_signal<sc_logic>                                                          SIG_SC_LOGIC_1;
  sc_signal<sc_logic>                                                          TLS_design_is_idle;
  sc_signal<bool>                                                              TLS_design_is_idle_reg;
  sc_clock                                                                     clk;
  mc_programmable_reset                                                        rst_driver;
  sc_signal<sc_logic>                                                          TLS_rst;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_0_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_0_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_0_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_0_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_0_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_0_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_1_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_1_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_1_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_1_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_1_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_1_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_2_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_2_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_2_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_2_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_2_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_2_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_3_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_3_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_3_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_3_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_3_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_3_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_4_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_4_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_4_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_4_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_4_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_4_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_5_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_5_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_5_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_5_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_5_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_5_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_6_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_6_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_6_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_6_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_6_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_6_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_7_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_7_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_7_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_7_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_7_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_7_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_8_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_8_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_8_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_8_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_8_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_8_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_9_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_9_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_9_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_9_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_9_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_9_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_10_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_10_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_10_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_10_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_10_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_10_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_11_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_11_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_11_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_11_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_11_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_11_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_12_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_12_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_12_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_12_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_12_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_12_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_13_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_13_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_13_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_13_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_13_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_13_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_14_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_14_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_14_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_14_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_14_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_14_lz;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_15_wadr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_15_d;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_0_15_we;
  sc_signal<sc_lv<6> >                                                         TLS_vec_rsc_0_15_radr;
  sc_signal<sc_lv<64> >                                                        TLS_vec_rsc_0_15_q;
  sc_signal<sc_logic>                                                          TLS_vec_rsc_triosy_0_15_lz;
  sc_signal<sc_lv<64> >                                                        TLS_p_rsc_dat;
  sc_signal<sc_logic>                                                          TLS_p_rsc_triosy_lz;
  sc_signal<sc_lv<64> >                                                        TLS_r_rsc_dat;
  sc_signal<sc_logic>                                                          TLS_r_rsc_triosy_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_0_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_0_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_0_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_1_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_1_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_1_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_2_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_2_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_2_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_3_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_3_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_3_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_4_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_4_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_4_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_5_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_5_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_5_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_6_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_6_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_6_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_7_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_7_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_7_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_8_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_8_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_8_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_9_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_9_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_9_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_10_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_10_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_10_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_11_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_11_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_11_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_12_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_12_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_12_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_13_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_13_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_13_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_14_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_14_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_14_lz;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0_15_radr;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0_15_q;
  sc_signal<sc_logic>                                                          TLS_twiddle_rsc_triosy_0_15_lz;
  ccs_DUT_wrapper                                                              inPlaceNTT_DIF_INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__0__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__1__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__2__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__3__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__4__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__5__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__6__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__7__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__8__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__9__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__10__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__11__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__12__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__13__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__14__INST;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           vec_rsc_0__15__INST;
  ccs_in_trans_rsc_v1<1,64 >                                                   p_rsc_INST;
  ccs_in_trans_rsc_v1<1,64 >                                                   r_rsc_INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__0__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__0__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__0__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__0__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__1__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__1__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__1__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__1__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__2__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__2__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__2__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__2__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__3__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__3__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__3__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__3__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__4__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__4__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__4__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__4__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__5__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__5__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__5__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__5__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__6__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__6__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__6__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__6__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__7__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__7__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__7__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__7__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__8__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__8__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__8__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__8__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__9__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__9__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__9__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__9__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__10__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__10__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__10__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__10__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__11__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__11__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__11__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__11__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__12__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__12__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__12__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__12__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__13__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__13__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__13__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__13__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__14__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__14__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__14__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__14__INST;
  sc_signal<sc_lv<64> >                                                        TLS_twiddle_rsc_0__15__d;
  sc_signal<sc_lv<6> >                                                         TLS_twiddle_rsc_0__15__wadr;
  sc_signal<sc_logic >                                                         TLS_twiddle_rsc_0__15__we;
  BLOCK_1R1W_RBW_trans_rsc<6,64,64 >                                           twiddle_rsc_0__15__INST;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_int<64, false >,1024> >                TLS_in_fifo_vec;
  tlm::tlm_fifo<mc_wait_ctrl>                                                  TLS_in_wait_ctrl_fifo_vec;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_int<64, false >,1024> >                TLS_out_fifo_vec;
  tlm::tlm_fifo<mc_wait_ctrl>                                                  TLS_out_wait_ctrl_fifo_vec;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_0_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_1_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_2_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_3_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_4_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_5_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_6_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_7_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_8_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_9_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_10_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_11_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_12_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_13_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_14_lz_INST;
  mc_trios_inout_monitor                                                       trios_monitor_vec_rsc_triosy_0_15_lz_INST;
  mc_inout_transactor<mgc_sysc_ver_array1D<ac_int<64, false >,1024>,64,false>  transactor_vec;
  tlm::tlm_fifo<ac_int<64, false > >                                           TLS_in_fifo_p;
  tlm::tlm_fifo<mc_wait_ctrl>                                                  TLS_in_wait_ctrl_fifo_p;
  mc_trios_input_monitor                                                       trios_monitor_p_rsc_triosy_lz_INST;
  mc_input_transactor<ac_int<64, false >,64,false>                             transactor_p;
  tlm::tlm_fifo<ac_int<64, false > >                                           TLS_in_fifo_r;
  tlm::tlm_fifo<mc_wait_ctrl>                                                  TLS_in_wait_ctrl_fifo_r;
  mc_trios_input_monitor                                                       trios_monitor_r_rsc_triosy_lz_INST;
  mc_input_transactor<ac_int<64, false >,64,false>                             transactor_r;
  tlm::tlm_fifo<mgc_sysc_ver_array1D<ac_int<64, false >,1024> >                TLS_in_fifo_twiddle;
  tlm::tlm_fifo<mc_wait_ctrl>                                                  TLS_in_wait_ctrl_fifo_twiddle;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_0_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_1_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_2_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_3_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_4_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_5_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_6_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_7_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_8_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_9_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_10_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_11_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_12_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_13_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_14_lz_INST;
  mc_trios_input_monitor                                                       trios_monitor_twiddle_rsc_triosy_0_15_lz_INST;
  mc_input_transactor<mgc_sysc_ver_array1D<ac_int<64, false >,1024>,64,false>  transactor_twiddle;
  mc_testbench                                                                 testbench_INST;
  sc_signal<sc_logic>                                                          catapult_start;
  sc_signal<sc_logic>                                                          catapult_done;
  sc_signal<sc_logic>                                                          catapult_ready;
  sc_signal<sc_logic>                                                          in_sync;
  sc_signal<sc_logic>                                                          out_sync;
  sc_signal<sc_logic>                                                          inout_sync;
  sc_signal<unsigned>                                                          wait_for_init;
  sync_generator                                                               sync_generator_INST;
  catapult_monitor                                                             catapult_monitor_INST;
  ccs_probe_monitor                                                           *ccs_probe_monitor_INST;
  sc_event                                                                     generate_reset_event;
  sc_event                                                                     deadlock_event;
  sc_signal<sc_logic>                                                          deadlocked;
  sc_signal<sc_logic>                                                          maxsimtime;
  sc_event                                                                     max_sim_time_event;
  sc_signal<sc_logic>                                                          TLS_enable_stalls;
  sc_signal<unsigned short>                                                    TLS_stall_coverage;

  void TLS_rst_method();
  void max_sim_time_notify();
  void start_of_simulation();
  void setup_debug();
  void debug(const char* varname, int flags, int count);
  void generate_reset();
  void install_observe_foreign_signals();
  void deadlock_watch();
  void deadlock_notify();

  // Constructor
  SC_HAS_PROCESS(scverify_top);
  scverify_top(const sc_module_name& name)
    : rst("rst")
    , rst_n("rst_n")
    , SIG_SC_LOGIC_0("SIG_SC_LOGIC_0")
    , SIG_SC_LOGIC_1("SIG_SC_LOGIC_1")
    , TLS_design_is_idle("TLS_design_is_idle")
    , TLS_design_is_idle_reg("TLS_design_is_idle_reg")
    , CCS_CLK_CTOR(clk, "clk", 20, SC_NS, 0.5, 0, SC_NS, false)
    , rst_driver("rst_driver", 140.000000, false)
    , TLS_rst("TLS_rst")
    , TLS_vec_rsc_0_0_wadr("TLS_vec_rsc_0_0_wadr")
    , TLS_vec_rsc_0_0_d("TLS_vec_rsc_0_0_d")
    , TLS_vec_rsc_0_0_we("TLS_vec_rsc_0_0_we")
    , TLS_vec_rsc_0_0_radr("TLS_vec_rsc_0_0_radr")
    , TLS_vec_rsc_0_0_q("TLS_vec_rsc_0_0_q")
    , TLS_vec_rsc_triosy_0_0_lz("TLS_vec_rsc_triosy_0_0_lz")
    , TLS_vec_rsc_0_1_wadr("TLS_vec_rsc_0_1_wadr")
    , TLS_vec_rsc_0_1_d("TLS_vec_rsc_0_1_d")
    , TLS_vec_rsc_0_1_we("TLS_vec_rsc_0_1_we")
    , TLS_vec_rsc_0_1_radr("TLS_vec_rsc_0_1_radr")
    , TLS_vec_rsc_0_1_q("TLS_vec_rsc_0_1_q")
    , TLS_vec_rsc_triosy_0_1_lz("TLS_vec_rsc_triosy_0_1_lz")
    , TLS_vec_rsc_0_2_wadr("TLS_vec_rsc_0_2_wadr")
    , TLS_vec_rsc_0_2_d("TLS_vec_rsc_0_2_d")
    , TLS_vec_rsc_0_2_we("TLS_vec_rsc_0_2_we")
    , TLS_vec_rsc_0_2_radr("TLS_vec_rsc_0_2_radr")
    , TLS_vec_rsc_0_2_q("TLS_vec_rsc_0_2_q")
    , TLS_vec_rsc_triosy_0_2_lz("TLS_vec_rsc_triosy_0_2_lz")
    , TLS_vec_rsc_0_3_wadr("TLS_vec_rsc_0_3_wadr")
    , TLS_vec_rsc_0_3_d("TLS_vec_rsc_0_3_d")
    , TLS_vec_rsc_0_3_we("TLS_vec_rsc_0_3_we")
    , TLS_vec_rsc_0_3_radr("TLS_vec_rsc_0_3_radr")
    , TLS_vec_rsc_0_3_q("TLS_vec_rsc_0_3_q")
    , TLS_vec_rsc_triosy_0_3_lz("TLS_vec_rsc_triosy_0_3_lz")
    , TLS_vec_rsc_0_4_wadr("TLS_vec_rsc_0_4_wadr")
    , TLS_vec_rsc_0_4_d("TLS_vec_rsc_0_4_d")
    , TLS_vec_rsc_0_4_we("TLS_vec_rsc_0_4_we")
    , TLS_vec_rsc_0_4_radr("TLS_vec_rsc_0_4_radr")
    , TLS_vec_rsc_0_4_q("TLS_vec_rsc_0_4_q")
    , TLS_vec_rsc_triosy_0_4_lz("TLS_vec_rsc_triosy_0_4_lz")
    , TLS_vec_rsc_0_5_wadr("TLS_vec_rsc_0_5_wadr")
    , TLS_vec_rsc_0_5_d("TLS_vec_rsc_0_5_d")
    , TLS_vec_rsc_0_5_we("TLS_vec_rsc_0_5_we")
    , TLS_vec_rsc_0_5_radr("TLS_vec_rsc_0_5_radr")
    , TLS_vec_rsc_0_5_q("TLS_vec_rsc_0_5_q")
    , TLS_vec_rsc_triosy_0_5_lz("TLS_vec_rsc_triosy_0_5_lz")
    , TLS_vec_rsc_0_6_wadr("TLS_vec_rsc_0_6_wadr")
    , TLS_vec_rsc_0_6_d("TLS_vec_rsc_0_6_d")
    , TLS_vec_rsc_0_6_we("TLS_vec_rsc_0_6_we")
    , TLS_vec_rsc_0_6_radr("TLS_vec_rsc_0_6_radr")
    , TLS_vec_rsc_0_6_q("TLS_vec_rsc_0_6_q")
    , TLS_vec_rsc_triosy_0_6_lz("TLS_vec_rsc_triosy_0_6_lz")
    , TLS_vec_rsc_0_7_wadr("TLS_vec_rsc_0_7_wadr")
    , TLS_vec_rsc_0_7_d("TLS_vec_rsc_0_7_d")
    , TLS_vec_rsc_0_7_we("TLS_vec_rsc_0_7_we")
    , TLS_vec_rsc_0_7_radr("TLS_vec_rsc_0_7_radr")
    , TLS_vec_rsc_0_7_q("TLS_vec_rsc_0_7_q")
    , TLS_vec_rsc_triosy_0_7_lz("TLS_vec_rsc_triosy_0_7_lz")
    , TLS_vec_rsc_0_8_wadr("TLS_vec_rsc_0_8_wadr")
    , TLS_vec_rsc_0_8_d("TLS_vec_rsc_0_8_d")
    , TLS_vec_rsc_0_8_we("TLS_vec_rsc_0_8_we")
    , TLS_vec_rsc_0_8_radr("TLS_vec_rsc_0_8_radr")
    , TLS_vec_rsc_0_8_q("TLS_vec_rsc_0_8_q")
    , TLS_vec_rsc_triosy_0_8_lz("TLS_vec_rsc_triosy_0_8_lz")
    , TLS_vec_rsc_0_9_wadr("TLS_vec_rsc_0_9_wadr")
    , TLS_vec_rsc_0_9_d("TLS_vec_rsc_0_9_d")
    , TLS_vec_rsc_0_9_we("TLS_vec_rsc_0_9_we")
    , TLS_vec_rsc_0_9_radr("TLS_vec_rsc_0_9_radr")
    , TLS_vec_rsc_0_9_q("TLS_vec_rsc_0_9_q")
    , TLS_vec_rsc_triosy_0_9_lz("TLS_vec_rsc_triosy_0_9_lz")
    , TLS_vec_rsc_0_10_wadr("TLS_vec_rsc_0_10_wadr")
    , TLS_vec_rsc_0_10_d("TLS_vec_rsc_0_10_d")
    , TLS_vec_rsc_0_10_we("TLS_vec_rsc_0_10_we")
    , TLS_vec_rsc_0_10_radr("TLS_vec_rsc_0_10_radr")
    , TLS_vec_rsc_0_10_q("TLS_vec_rsc_0_10_q")
    , TLS_vec_rsc_triosy_0_10_lz("TLS_vec_rsc_triosy_0_10_lz")
    , TLS_vec_rsc_0_11_wadr("TLS_vec_rsc_0_11_wadr")
    , TLS_vec_rsc_0_11_d("TLS_vec_rsc_0_11_d")
    , TLS_vec_rsc_0_11_we("TLS_vec_rsc_0_11_we")
    , TLS_vec_rsc_0_11_radr("TLS_vec_rsc_0_11_radr")
    , TLS_vec_rsc_0_11_q("TLS_vec_rsc_0_11_q")
    , TLS_vec_rsc_triosy_0_11_lz("TLS_vec_rsc_triosy_0_11_lz")
    , TLS_vec_rsc_0_12_wadr("TLS_vec_rsc_0_12_wadr")
    , TLS_vec_rsc_0_12_d("TLS_vec_rsc_0_12_d")
    , TLS_vec_rsc_0_12_we("TLS_vec_rsc_0_12_we")
    , TLS_vec_rsc_0_12_radr("TLS_vec_rsc_0_12_radr")
    , TLS_vec_rsc_0_12_q("TLS_vec_rsc_0_12_q")
    , TLS_vec_rsc_triosy_0_12_lz("TLS_vec_rsc_triosy_0_12_lz")
    , TLS_vec_rsc_0_13_wadr("TLS_vec_rsc_0_13_wadr")
    , TLS_vec_rsc_0_13_d("TLS_vec_rsc_0_13_d")
    , TLS_vec_rsc_0_13_we("TLS_vec_rsc_0_13_we")
    , TLS_vec_rsc_0_13_radr("TLS_vec_rsc_0_13_radr")
    , TLS_vec_rsc_0_13_q("TLS_vec_rsc_0_13_q")
    , TLS_vec_rsc_triosy_0_13_lz("TLS_vec_rsc_triosy_0_13_lz")
    , TLS_vec_rsc_0_14_wadr("TLS_vec_rsc_0_14_wadr")
    , TLS_vec_rsc_0_14_d("TLS_vec_rsc_0_14_d")
    , TLS_vec_rsc_0_14_we("TLS_vec_rsc_0_14_we")
    , TLS_vec_rsc_0_14_radr("TLS_vec_rsc_0_14_radr")
    , TLS_vec_rsc_0_14_q("TLS_vec_rsc_0_14_q")
    , TLS_vec_rsc_triosy_0_14_lz("TLS_vec_rsc_triosy_0_14_lz")
    , TLS_vec_rsc_0_15_wadr("TLS_vec_rsc_0_15_wadr")
    , TLS_vec_rsc_0_15_d("TLS_vec_rsc_0_15_d")
    , TLS_vec_rsc_0_15_we("TLS_vec_rsc_0_15_we")
    , TLS_vec_rsc_0_15_radr("TLS_vec_rsc_0_15_radr")
    , TLS_vec_rsc_0_15_q("TLS_vec_rsc_0_15_q")
    , TLS_vec_rsc_triosy_0_15_lz("TLS_vec_rsc_triosy_0_15_lz")
    , TLS_p_rsc_dat("TLS_p_rsc_dat")
    , TLS_p_rsc_triosy_lz("TLS_p_rsc_triosy_lz")
    , TLS_r_rsc_dat("TLS_r_rsc_dat")
    , TLS_r_rsc_triosy_lz("TLS_r_rsc_triosy_lz")
    , TLS_twiddle_rsc_0_0_radr("TLS_twiddle_rsc_0_0_radr")
    , TLS_twiddle_rsc_0_0_q("TLS_twiddle_rsc_0_0_q")
    , TLS_twiddle_rsc_triosy_0_0_lz("TLS_twiddle_rsc_triosy_0_0_lz")
    , TLS_twiddle_rsc_0_1_radr("TLS_twiddle_rsc_0_1_radr")
    , TLS_twiddle_rsc_0_1_q("TLS_twiddle_rsc_0_1_q")
    , TLS_twiddle_rsc_triosy_0_1_lz("TLS_twiddle_rsc_triosy_0_1_lz")
    , TLS_twiddle_rsc_0_2_radr("TLS_twiddle_rsc_0_2_radr")
    , TLS_twiddle_rsc_0_2_q("TLS_twiddle_rsc_0_2_q")
    , TLS_twiddle_rsc_triosy_0_2_lz("TLS_twiddle_rsc_triosy_0_2_lz")
    , TLS_twiddle_rsc_0_3_radr("TLS_twiddle_rsc_0_3_radr")
    , TLS_twiddle_rsc_0_3_q("TLS_twiddle_rsc_0_3_q")
    , TLS_twiddle_rsc_triosy_0_3_lz("TLS_twiddle_rsc_triosy_0_3_lz")
    , TLS_twiddle_rsc_0_4_radr("TLS_twiddle_rsc_0_4_radr")
    , TLS_twiddle_rsc_0_4_q("TLS_twiddle_rsc_0_4_q")
    , TLS_twiddle_rsc_triosy_0_4_lz("TLS_twiddle_rsc_triosy_0_4_lz")
    , TLS_twiddle_rsc_0_5_radr("TLS_twiddle_rsc_0_5_radr")
    , TLS_twiddle_rsc_0_5_q("TLS_twiddle_rsc_0_5_q")
    , TLS_twiddle_rsc_triosy_0_5_lz("TLS_twiddle_rsc_triosy_0_5_lz")
    , TLS_twiddle_rsc_0_6_radr("TLS_twiddle_rsc_0_6_radr")
    , TLS_twiddle_rsc_0_6_q("TLS_twiddle_rsc_0_6_q")
    , TLS_twiddle_rsc_triosy_0_6_lz("TLS_twiddle_rsc_triosy_0_6_lz")
    , TLS_twiddle_rsc_0_7_radr("TLS_twiddle_rsc_0_7_radr")
    , TLS_twiddle_rsc_0_7_q("TLS_twiddle_rsc_0_7_q")
    , TLS_twiddle_rsc_triosy_0_7_lz("TLS_twiddle_rsc_triosy_0_7_lz")
    , TLS_twiddle_rsc_0_8_radr("TLS_twiddle_rsc_0_8_radr")
    , TLS_twiddle_rsc_0_8_q("TLS_twiddle_rsc_0_8_q")
    , TLS_twiddle_rsc_triosy_0_8_lz("TLS_twiddle_rsc_triosy_0_8_lz")
    , TLS_twiddle_rsc_0_9_radr("TLS_twiddle_rsc_0_9_radr")
    , TLS_twiddle_rsc_0_9_q("TLS_twiddle_rsc_0_9_q")
    , TLS_twiddle_rsc_triosy_0_9_lz("TLS_twiddle_rsc_triosy_0_9_lz")
    , TLS_twiddle_rsc_0_10_radr("TLS_twiddle_rsc_0_10_radr")
    , TLS_twiddle_rsc_0_10_q("TLS_twiddle_rsc_0_10_q")
    , TLS_twiddle_rsc_triosy_0_10_lz("TLS_twiddle_rsc_triosy_0_10_lz")
    , TLS_twiddle_rsc_0_11_radr("TLS_twiddle_rsc_0_11_radr")
    , TLS_twiddle_rsc_0_11_q("TLS_twiddle_rsc_0_11_q")
    , TLS_twiddle_rsc_triosy_0_11_lz("TLS_twiddle_rsc_triosy_0_11_lz")
    , TLS_twiddle_rsc_0_12_radr("TLS_twiddle_rsc_0_12_radr")
    , TLS_twiddle_rsc_0_12_q("TLS_twiddle_rsc_0_12_q")
    , TLS_twiddle_rsc_triosy_0_12_lz("TLS_twiddle_rsc_triosy_0_12_lz")
    , TLS_twiddle_rsc_0_13_radr("TLS_twiddle_rsc_0_13_radr")
    , TLS_twiddle_rsc_0_13_q("TLS_twiddle_rsc_0_13_q")
    , TLS_twiddle_rsc_triosy_0_13_lz("TLS_twiddle_rsc_triosy_0_13_lz")
    , TLS_twiddle_rsc_0_14_radr("TLS_twiddle_rsc_0_14_radr")
    , TLS_twiddle_rsc_0_14_q("TLS_twiddle_rsc_0_14_q")
    , TLS_twiddle_rsc_triosy_0_14_lz("TLS_twiddle_rsc_triosy_0_14_lz")
    , TLS_twiddle_rsc_0_15_radr("TLS_twiddle_rsc_0_15_radr")
    , TLS_twiddle_rsc_0_15_q("TLS_twiddle_rsc_0_15_q")
    , TLS_twiddle_rsc_triosy_0_15_lz("TLS_twiddle_rsc_triosy_0_15_lz")
    , inPlaceNTT_DIF_INST("rtl", TO_QUOTED_STRING(TOP_HDL_ENTITY))
    , vec_rsc_0__0__INST("vec_rsc_0__0_", true)
    , vec_rsc_0__1__INST("vec_rsc_0__1_", true)
    , vec_rsc_0__2__INST("vec_rsc_0__2_", true)
    , vec_rsc_0__3__INST("vec_rsc_0__3_", true)
    , vec_rsc_0__4__INST("vec_rsc_0__4_", true)
    , vec_rsc_0__5__INST("vec_rsc_0__5_", true)
    , vec_rsc_0__6__INST("vec_rsc_0__6_", true)
    , vec_rsc_0__7__INST("vec_rsc_0__7_", true)
    , vec_rsc_0__8__INST("vec_rsc_0__8_", true)
    , vec_rsc_0__9__INST("vec_rsc_0__9_", true)
    , vec_rsc_0__10__INST("vec_rsc_0__10_", true)
    , vec_rsc_0__11__INST("vec_rsc_0__11_", true)
    , vec_rsc_0__12__INST("vec_rsc_0__12_", true)
    , vec_rsc_0__13__INST("vec_rsc_0__13_", true)
    , vec_rsc_0__14__INST("vec_rsc_0__14_", true)
    , vec_rsc_0__15__INST("vec_rsc_0__15_", true)
    , p_rsc_INST("p_rsc", true)
    , r_rsc_INST("r_rsc", true)
    , TLS_twiddle_rsc_0__0__d("TLS_twiddle_rsc_0__0__d")
    , TLS_twiddle_rsc_0__0__wadr("TLS_twiddle_rsc_0__0__wadr")
    , TLS_twiddle_rsc_0__0__we("TLS_twiddle_rsc_0__0__we")
    , twiddle_rsc_0__0__INST("twiddle_rsc_0__0_", true)
    , TLS_twiddle_rsc_0__1__d("TLS_twiddle_rsc_0__1__d")
    , TLS_twiddle_rsc_0__1__wadr("TLS_twiddle_rsc_0__1__wadr")
    , TLS_twiddle_rsc_0__1__we("TLS_twiddle_rsc_0__1__we")
    , twiddle_rsc_0__1__INST("twiddle_rsc_0__1_", true)
    , TLS_twiddle_rsc_0__2__d("TLS_twiddle_rsc_0__2__d")
    , TLS_twiddle_rsc_0__2__wadr("TLS_twiddle_rsc_0__2__wadr")
    , TLS_twiddle_rsc_0__2__we("TLS_twiddle_rsc_0__2__we")
    , twiddle_rsc_0__2__INST("twiddle_rsc_0__2_", true)
    , TLS_twiddle_rsc_0__3__d("TLS_twiddle_rsc_0__3__d")
    , TLS_twiddle_rsc_0__3__wadr("TLS_twiddle_rsc_0__3__wadr")
    , TLS_twiddle_rsc_0__3__we("TLS_twiddle_rsc_0__3__we")
    , twiddle_rsc_0__3__INST("twiddle_rsc_0__3_", true)
    , TLS_twiddle_rsc_0__4__d("TLS_twiddle_rsc_0__4__d")
    , TLS_twiddle_rsc_0__4__wadr("TLS_twiddle_rsc_0__4__wadr")
    , TLS_twiddle_rsc_0__4__we("TLS_twiddle_rsc_0__4__we")
    , twiddle_rsc_0__4__INST("twiddle_rsc_0__4_", true)
    , TLS_twiddle_rsc_0__5__d("TLS_twiddle_rsc_0__5__d")
    , TLS_twiddle_rsc_0__5__wadr("TLS_twiddle_rsc_0__5__wadr")
    , TLS_twiddle_rsc_0__5__we("TLS_twiddle_rsc_0__5__we")
    , twiddle_rsc_0__5__INST("twiddle_rsc_0__5_", true)
    , TLS_twiddle_rsc_0__6__d("TLS_twiddle_rsc_0__6__d")
    , TLS_twiddle_rsc_0__6__wadr("TLS_twiddle_rsc_0__6__wadr")
    , TLS_twiddle_rsc_0__6__we("TLS_twiddle_rsc_0__6__we")
    , twiddle_rsc_0__6__INST("twiddle_rsc_0__6_", true)
    , TLS_twiddle_rsc_0__7__d("TLS_twiddle_rsc_0__7__d")
    , TLS_twiddle_rsc_0__7__wadr("TLS_twiddle_rsc_0__7__wadr")
    , TLS_twiddle_rsc_0__7__we("TLS_twiddle_rsc_0__7__we")
    , twiddle_rsc_0__7__INST("twiddle_rsc_0__7_", true)
    , TLS_twiddle_rsc_0__8__d("TLS_twiddle_rsc_0__8__d")
    , TLS_twiddle_rsc_0__8__wadr("TLS_twiddle_rsc_0__8__wadr")
    , TLS_twiddle_rsc_0__8__we("TLS_twiddle_rsc_0__8__we")
    , twiddle_rsc_0__8__INST("twiddle_rsc_0__8_", true)
    , TLS_twiddle_rsc_0__9__d("TLS_twiddle_rsc_0__9__d")
    , TLS_twiddle_rsc_0__9__wadr("TLS_twiddle_rsc_0__9__wadr")
    , TLS_twiddle_rsc_0__9__we("TLS_twiddle_rsc_0__9__we")
    , twiddle_rsc_0__9__INST("twiddle_rsc_0__9_", true)
    , TLS_twiddle_rsc_0__10__d("TLS_twiddle_rsc_0__10__d")
    , TLS_twiddle_rsc_0__10__wadr("TLS_twiddle_rsc_0__10__wadr")
    , TLS_twiddle_rsc_0__10__we("TLS_twiddle_rsc_0__10__we")
    , twiddle_rsc_0__10__INST("twiddle_rsc_0__10_", true)
    , TLS_twiddle_rsc_0__11__d("TLS_twiddle_rsc_0__11__d")
    , TLS_twiddle_rsc_0__11__wadr("TLS_twiddle_rsc_0__11__wadr")
    , TLS_twiddle_rsc_0__11__we("TLS_twiddle_rsc_0__11__we")
    , twiddle_rsc_0__11__INST("twiddle_rsc_0__11_", true)
    , TLS_twiddle_rsc_0__12__d("TLS_twiddle_rsc_0__12__d")
    , TLS_twiddle_rsc_0__12__wadr("TLS_twiddle_rsc_0__12__wadr")
    , TLS_twiddle_rsc_0__12__we("TLS_twiddle_rsc_0__12__we")
    , twiddle_rsc_0__12__INST("twiddle_rsc_0__12_", true)
    , TLS_twiddle_rsc_0__13__d("TLS_twiddle_rsc_0__13__d")
    , TLS_twiddle_rsc_0__13__wadr("TLS_twiddle_rsc_0__13__wadr")
    , TLS_twiddle_rsc_0__13__we("TLS_twiddle_rsc_0__13__we")
    , twiddle_rsc_0__13__INST("twiddle_rsc_0__13_", true)
    , TLS_twiddle_rsc_0__14__d("TLS_twiddle_rsc_0__14__d")
    , TLS_twiddle_rsc_0__14__wadr("TLS_twiddle_rsc_0__14__wadr")
    , TLS_twiddle_rsc_0__14__we("TLS_twiddle_rsc_0__14__we")
    , twiddle_rsc_0__14__INST("twiddle_rsc_0__14_", true)
    , TLS_twiddle_rsc_0__15__d("TLS_twiddle_rsc_0__15__d")
    , TLS_twiddle_rsc_0__15__wadr("TLS_twiddle_rsc_0__15__wadr")
    , TLS_twiddle_rsc_0__15__we("TLS_twiddle_rsc_0__15__we")
    , twiddle_rsc_0__15__INST("twiddle_rsc_0__15_", true)
    , TLS_in_fifo_vec("TLS_in_fifo_vec", -1)
    , TLS_in_wait_ctrl_fifo_vec("TLS_in_wait_ctrl_fifo_vec", -1)
    , TLS_out_fifo_vec("TLS_out_fifo_vec", -1)
    , TLS_out_wait_ctrl_fifo_vec("TLS_out_wait_ctrl_fifo_vec", -1)
    , trios_monitor_vec_rsc_triosy_0_0_lz_INST("trios_monitor_vec_rsc_triosy_0_0_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_1_lz_INST("trios_monitor_vec_rsc_triosy_0_1_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_2_lz_INST("trios_monitor_vec_rsc_triosy_0_2_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_3_lz_INST("trios_monitor_vec_rsc_triosy_0_3_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_4_lz_INST("trios_monitor_vec_rsc_triosy_0_4_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_5_lz_INST("trios_monitor_vec_rsc_triosy_0_5_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_6_lz_INST("trios_monitor_vec_rsc_triosy_0_6_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_7_lz_INST("trios_monitor_vec_rsc_triosy_0_7_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_8_lz_INST("trios_monitor_vec_rsc_triosy_0_8_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_9_lz_INST("trios_monitor_vec_rsc_triosy_0_9_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_10_lz_INST("trios_monitor_vec_rsc_triosy_0_10_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_11_lz_INST("trios_monitor_vec_rsc_triosy_0_11_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_12_lz_INST("trios_monitor_vec_rsc_triosy_0_12_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_13_lz_INST("trios_monitor_vec_rsc_triosy_0_13_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_14_lz_INST("trios_monitor_vec_rsc_triosy_0_14_lz_INST")
    , trios_monitor_vec_rsc_triosy_0_15_lz_INST("trios_monitor_vec_rsc_triosy_0_15_lz_INST")
    , transactor_vec("transactor_vec", 0, 64, 0)
    , TLS_in_fifo_p("TLS_in_fifo_p", -1)
    , TLS_in_wait_ctrl_fifo_p("TLS_in_wait_ctrl_fifo_p", -1)
    , trios_monitor_p_rsc_triosy_lz_INST("trios_monitor_p_rsc_triosy_lz_INST")
    , transactor_p("transactor_p", 0, 64, 0)
    , TLS_in_fifo_r("TLS_in_fifo_r", -1)
    , TLS_in_wait_ctrl_fifo_r("TLS_in_wait_ctrl_fifo_r", -1)
    , trios_monitor_r_rsc_triosy_lz_INST("trios_monitor_r_rsc_triosy_lz_INST")
    , transactor_r("transactor_r", 0, 64, 0)
    , TLS_in_fifo_twiddle("TLS_in_fifo_twiddle", -1)
    , TLS_in_wait_ctrl_fifo_twiddle("TLS_in_wait_ctrl_fifo_twiddle", -1)
    , trios_monitor_twiddle_rsc_triosy_0_0_lz_INST("trios_monitor_twiddle_rsc_triosy_0_0_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_1_lz_INST("trios_monitor_twiddle_rsc_triosy_0_1_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_2_lz_INST("trios_monitor_twiddle_rsc_triosy_0_2_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_3_lz_INST("trios_monitor_twiddle_rsc_triosy_0_3_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_4_lz_INST("trios_monitor_twiddle_rsc_triosy_0_4_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_5_lz_INST("trios_monitor_twiddle_rsc_triosy_0_5_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_6_lz_INST("trios_monitor_twiddle_rsc_triosy_0_6_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_7_lz_INST("trios_monitor_twiddle_rsc_triosy_0_7_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_8_lz_INST("trios_monitor_twiddle_rsc_triosy_0_8_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_9_lz_INST("trios_monitor_twiddle_rsc_triosy_0_9_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_10_lz_INST("trios_monitor_twiddle_rsc_triosy_0_10_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_11_lz_INST("trios_monitor_twiddle_rsc_triosy_0_11_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_12_lz_INST("trios_monitor_twiddle_rsc_triosy_0_12_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_13_lz_INST("trios_monitor_twiddle_rsc_triosy_0_13_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_14_lz_INST("trios_monitor_twiddle_rsc_triosy_0_14_lz_INST")
    , trios_monitor_twiddle_rsc_triosy_0_15_lz_INST("trios_monitor_twiddle_rsc_triosy_0_15_lz_INST")
    , transactor_twiddle("transactor_twiddle", 0, 64, 0)
    , testbench_INST("user_tb")
    , catapult_start("catapult_start")
    , catapult_done("catapult_done")
    , catapult_ready("catapult_ready")
    , in_sync("in_sync")
    , out_sync("out_sync")
    , inout_sync("inout_sync")
    , wait_for_init("wait_for_init")
    , sync_generator_INST("sync_generator", true, false, false, false, 290282, 290282, 0)
    , catapult_monitor_INST("Monitor", clk, true, 290282LL, 290282LL)
    , ccs_probe_monitor_INST(NULL)
    , deadlocked("deadlocked")
    , maxsimtime("maxsimtime")
  {
    rst_driver.reset_out(TLS_rst);

    inPlaceNTT_DIF_INST.clk(clk);
    inPlaceNTT_DIF_INST.rst(TLS_rst);
    inPlaceNTT_DIF_INST.vec_rsc_0_0_wadr(TLS_vec_rsc_0_0_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_0_d(TLS_vec_rsc_0_0_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_0_we(TLS_vec_rsc_0_0_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_0_radr(TLS_vec_rsc_0_0_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_0_q(TLS_vec_rsc_0_0_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_0_lz(TLS_vec_rsc_triosy_0_0_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_1_wadr(TLS_vec_rsc_0_1_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_1_d(TLS_vec_rsc_0_1_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_1_we(TLS_vec_rsc_0_1_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_1_radr(TLS_vec_rsc_0_1_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_1_q(TLS_vec_rsc_0_1_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_1_lz(TLS_vec_rsc_triosy_0_1_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_2_wadr(TLS_vec_rsc_0_2_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_2_d(TLS_vec_rsc_0_2_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_2_we(TLS_vec_rsc_0_2_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_2_radr(TLS_vec_rsc_0_2_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_2_q(TLS_vec_rsc_0_2_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_2_lz(TLS_vec_rsc_triosy_0_2_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_3_wadr(TLS_vec_rsc_0_3_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_3_d(TLS_vec_rsc_0_3_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_3_we(TLS_vec_rsc_0_3_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_3_radr(TLS_vec_rsc_0_3_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_3_q(TLS_vec_rsc_0_3_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_3_lz(TLS_vec_rsc_triosy_0_3_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_4_wadr(TLS_vec_rsc_0_4_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_4_d(TLS_vec_rsc_0_4_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_4_we(TLS_vec_rsc_0_4_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_4_radr(TLS_vec_rsc_0_4_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_4_q(TLS_vec_rsc_0_4_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_4_lz(TLS_vec_rsc_triosy_0_4_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_5_wadr(TLS_vec_rsc_0_5_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_5_d(TLS_vec_rsc_0_5_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_5_we(TLS_vec_rsc_0_5_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_5_radr(TLS_vec_rsc_0_5_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_5_q(TLS_vec_rsc_0_5_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_5_lz(TLS_vec_rsc_triosy_0_5_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_6_wadr(TLS_vec_rsc_0_6_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_6_d(TLS_vec_rsc_0_6_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_6_we(TLS_vec_rsc_0_6_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_6_radr(TLS_vec_rsc_0_6_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_6_q(TLS_vec_rsc_0_6_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_6_lz(TLS_vec_rsc_triosy_0_6_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_7_wadr(TLS_vec_rsc_0_7_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_7_d(TLS_vec_rsc_0_7_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_7_we(TLS_vec_rsc_0_7_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_7_radr(TLS_vec_rsc_0_7_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_7_q(TLS_vec_rsc_0_7_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_7_lz(TLS_vec_rsc_triosy_0_7_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_8_wadr(TLS_vec_rsc_0_8_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_8_d(TLS_vec_rsc_0_8_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_8_we(TLS_vec_rsc_0_8_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_8_radr(TLS_vec_rsc_0_8_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_8_q(TLS_vec_rsc_0_8_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_8_lz(TLS_vec_rsc_triosy_0_8_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_9_wadr(TLS_vec_rsc_0_9_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_9_d(TLS_vec_rsc_0_9_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_9_we(TLS_vec_rsc_0_9_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_9_radr(TLS_vec_rsc_0_9_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_9_q(TLS_vec_rsc_0_9_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_9_lz(TLS_vec_rsc_triosy_0_9_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_10_wadr(TLS_vec_rsc_0_10_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_10_d(TLS_vec_rsc_0_10_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_10_we(TLS_vec_rsc_0_10_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_10_radr(TLS_vec_rsc_0_10_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_10_q(TLS_vec_rsc_0_10_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_10_lz(TLS_vec_rsc_triosy_0_10_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_11_wadr(TLS_vec_rsc_0_11_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_11_d(TLS_vec_rsc_0_11_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_11_we(TLS_vec_rsc_0_11_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_11_radr(TLS_vec_rsc_0_11_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_11_q(TLS_vec_rsc_0_11_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_11_lz(TLS_vec_rsc_triosy_0_11_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_12_wadr(TLS_vec_rsc_0_12_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_12_d(TLS_vec_rsc_0_12_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_12_we(TLS_vec_rsc_0_12_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_12_radr(TLS_vec_rsc_0_12_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_12_q(TLS_vec_rsc_0_12_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_12_lz(TLS_vec_rsc_triosy_0_12_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_13_wadr(TLS_vec_rsc_0_13_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_13_d(TLS_vec_rsc_0_13_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_13_we(TLS_vec_rsc_0_13_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_13_radr(TLS_vec_rsc_0_13_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_13_q(TLS_vec_rsc_0_13_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_13_lz(TLS_vec_rsc_triosy_0_13_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_14_wadr(TLS_vec_rsc_0_14_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_14_d(TLS_vec_rsc_0_14_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_14_we(TLS_vec_rsc_0_14_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_14_radr(TLS_vec_rsc_0_14_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_14_q(TLS_vec_rsc_0_14_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_14_lz(TLS_vec_rsc_triosy_0_14_lz);
    inPlaceNTT_DIF_INST.vec_rsc_0_15_wadr(TLS_vec_rsc_0_15_wadr);
    inPlaceNTT_DIF_INST.vec_rsc_0_15_d(TLS_vec_rsc_0_15_d);
    inPlaceNTT_DIF_INST.vec_rsc_0_15_we(TLS_vec_rsc_0_15_we);
    inPlaceNTT_DIF_INST.vec_rsc_0_15_radr(TLS_vec_rsc_0_15_radr);
    inPlaceNTT_DIF_INST.vec_rsc_0_15_q(TLS_vec_rsc_0_15_q);
    inPlaceNTT_DIF_INST.vec_rsc_triosy_0_15_lz(TLS_vec_rsc_triosy_0_15_lz);
    inPlaceNTT_DIF_INST.p_rsc_dat(TLS_p_rsc_dat);
    inPlaceNTT_DIF_INST.p_rsc_triosy_lz(TLS_p_rsc_triosy_lz);
    inPlaceNTT_DIF_INST.r_rsc_dat(TLS_r_rsc_dat);
    inPlaceNTT_DIF_INST.r_rsc_triosy_lz(TLS_r_rsc_triosy_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_0_radr(TLS_twiddle_rsc_0_0_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_0_q(TLS_twiddle_rsc_0_0_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_0_lz(TLS_twiddle_rsc_triosy_0_0_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_1_radr(TLS_twiddle_rsc_0_1_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_1_q(TLS_twiddle_rsc_0_1_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_1_lz(TLS_twiddle_rsc_triosy_0_1_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_2_radr(TLS_twiddle_rsc_0_2_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_2_q(TLS_twiddle_rsc_0_2_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_2_lz(TLS_twiddle_rsc_triosy_0_2_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_3_radr(TLS_twiddle_rsc_0_3_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_3_q(TLS_twiddle_rsc_0_3_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_3_lz(TLS_twiddle_rsc_triosy_0_3_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_4_radr(TLS_twiddle_rsc_0_4_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_4_q(TLS_twiddle_rsc_0_4_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_4_lz(TLS_twiddle_rsc_triosy_0_4_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_5_radr(TLS_twiddle_rsc_0_5_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_5_q(TLS_twiddle_rsc_0_5_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_5_lz(TLS_twiddle_rsc_triosy_0_5_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_6_radr(TLS_twiddle_rsc_0_6_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_6_q(TLS_twiddle_rsc_0_6_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_6_lz(TLS_twiddle_rsc_triosy_0_6_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_7_radr(TLS_twiddle_rsc_0_7_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_7_q(TLS_twiddle_rsc_0_7_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_7_lz(TLS_twiddle_rsc_triosy_0_7_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_8_radr(TLS_twiddle_rsc_0_8_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_8_q(TLS_twiddle_rsc_0_8_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_8_lz(TLS_twiddle_rsc_triosy_0_8_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_9_radr(TLS_twiddle_rsc_0_9_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_9_q(TLS_twiddle_rsc_0_9_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_9_lz(TLS_twiddle_rsc_triosy_0_9_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_10_radr(TLS_twiddle_rsc_0_10_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_10_q(TLS_twiddle_rsc_0_10_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_10_lz(TLS_twiddle_rsc_triosy_0_10_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_11_radr(TLS_twiddle_rsc_0_11_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_11_q(TLS_twiddle_rsc_0_11_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_11_lz(TLS_twiddle_rsc_triosy_0_11_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_12_radr(TLS_twiddle_rsc_0_12_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_12_q(TLS_twiddle_rsc_0_12_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_12_lz(TLS_twiddle_rsc_triosy_0_12_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_13_radr(TLS_twiddle_rsc_0_13_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_13_q(TLS_twiddle_rsc_0_13_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_13_lz(TLS_twiddle_rsc_triosy_0_13_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_14_radr(TLS_twiddle_rsc_0_14_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_14_q(TLS_twiddle_rsc_0_14_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_14_lz(TLS_twiddle_rsc_triosy_0_14_lz);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_15_radr(TLS_twiddle_rsc_0_15_radr);
    inPlaceNTT_DIF_INST.twiddle_rsc_0_15_q(TLS_twiddle_rsc_0_15_q);
    inPlaceNTT_DIF_INST.twiddle_rsc_triosy_0_15_lz(TLS_twiddle_rsc_triosy_0_15_lz);

    vec_rsc_0__0__INST.q(TLS_vec_rsc_0_0_q);
    vec_rsc_0__0__INST.radr(TLS_vec_rsc_0_0_radr);
    vec_rsc_0__0__INST.we(TLS_vec_rsc_0_0_we);
    vec_rsc_0__0__INST.d(TLS_vec_rsc_0_0_d);
    vec_rsc_0__0__INST.wadr(TLS_vec_rsc_0_0_wadr);
    vec_rsc_0__0__INST.clk(clk);
    vec_rsc_0__0__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__0__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_9)));

    vec_rsc_0__1__INST.q(TLS_vec_rsc_0_1_q);
    vec_rsc_0__1__INST.radr(TLS_vec_rsc_0_1_radr);
    vec_rsc_0__1__INST.we(TLS_vec_rsc_0_1_we);
    vec_rsc_0__1__INST.d(TLS_vec_rsc_0_1_d);
    vec_rsc_0__1__INST.wadr(TLS_vec_rsc_0_1_wadr);
    vec_rsc_0__1__INST.clk(clk);
    vec_rsc_0__1__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__1__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_10)));

    vec_rsc_0__2__INST.q(TLS_vec_rsc_0_2_q);
    vec_rsc_0__2__INST.radr(TLS_vec_rsc_0_2_radr);
    vec_rsc_0__2__INST.we(TLS_vec_rsc_0_2_we);
    vec_rsc_0__2__INST.d(TLS_vec_rsc_0_2_d);
    vec_rsc_0__2__INST.wadr(TLS_vec_rsc_0_2_wadr);
    vec_rsc_0__2__INST.clk(clk);
    vec_rsc_0__2__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__2__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_11)));

    vec_rsc_0__3__INST.q(TLS_vec_rsc_0_3_q);
    vec_rsc_0__3__INST.radr(TLS_vec_rsc_0_3_radr);
    vec_rsc_0__3__INST.we(TLS_vec_rsc_0_3_we);
    vec_rsc_0__3__INST.d(TLS_vec_rsc_0_3_d);
    vec_rsc_0__3__INST.wadr(TLS_vec_rsc_0_3_wadr);
    vec_rsc_0__3__INST.clk(clk);
    vec_rsc_0__3__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__3__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_12)));

    vec_rsc_0__4__INST.q(TLS_vec_rsc_0_4_q);
    vec_rsc_0__4__INST.radr(TLS_vec_rsc_0_4_radr);
    vec_rsc_0__4__INST.we(TLS_vec_rsc_0_4_we);
    vec_rsc_0__4__INST.d(TLS_vec_rsc_0_4_d);
    vec_rsc_0__4__INST.wadr(TLS_vec_rsc_0_4_wadr);
    vec_rsc_0__4__INST.clk(clk);
    vec_rsc_0__4__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__4__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_13)));

    vec_rsc_0__5__INST.q(TLS_vec_rsc_0_5_q);
    vec_rsc_0__5__INST.radr(TLS_vec_rsc_0_5_radr);
    vec_rsc_0__5__INST.we(TLS_vec_rsc_0_5_we);
    vec_rsc_0__5__INST.d(TLS_vec_rsc_0_5_d);
    vec_rsc_0__5__INST.wadr(TLS_vec_rsc_0_5_wadr);
    vec_rsc_0__5__INST.clk(clk);
    vec_rsc_0__5__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__5__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_14)));

    vec_rsc_0__6__INST.q(TLS_vec_rsc_0_6_q);
    vec_rsc_0__6__INST.radr(TLS_vec_rsc_0_6_radr);
    vec_rsc_0__6__INST.we(TLS_vec_rsc_0_6_we);
    vec_rsc_0__6__INST.d(TLS_vec_rsc_0_6_d);
    vec_rsc_0__6__INST.wadr(TLS_vec_rsc_0_6_wadr);
    vec_rsc_0__6__INST.clk(clk);
    vec_rsc_0__6__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__6__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_15)));

    vec_rsc_0__7__INST.q(TLS_vec_rsc_0_7_q);
    vec_rsc_0__7__INST.radr(TLS_vec_rsc_0_7_radr);
    vec_rsc_0__7__INST.we(TLS_vec_rsc_0_7_we);
    vec_rsc_0__7__INST.d(TLS_vec_rsc_0_7_d);
    vec_rsc_0__7__INST.wadr(TLS_vec_rsc_0_7_wadr);
    vec_rsc_0__7__INST.clk(clk);
    vec_rsc_0__7__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__7__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_16)));

    vec_rsc_0__8__INST.q(TLS_vec_rsc_0_8_q);
    vec_rsc_0__8__INST.radr(TLS_vec_rsc_0_8_radr);
    vec_rsc_0__8__INST.we(TLS_vec_rsc_0_8_we);
    vec_rsc_0__8__INST.d(TLS_vec_rsc_0_8_d);
    vec_rsc_0__8__INST.wadr(TLS_vec_rsc_0_8_wadr);
    vec_rsc_0__8__INST.clk(clk);
    vec_rsc_0__8__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__8__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_17)));

    vec_rsc_0__9__INST.q(TLS_vec_rsc_0_9_q);
    vec_rsc_0__9__INST.radr(TLS_vec_rsc_0_9_radr);
    vec_rsc_0__9__INST.we(TLS_vec_rsc_0_9_we);
    vec_rsc_0__9__INST.d(TLS_vec_rsc_0_9_d);
    vec_rsc_0__9__INST.wadr(TLS_vec_rsc_0_9_wadr);
    vec_rsc_0__9__INST.clk(clk);
    vec_rsc_0__9__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__9__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_18)));

    vec_rsc_0__10__INST.q(TLS_vec_rsc_0_10_q);
    vec_rsc_0__10__INST.radr(TLS_vec_rsc_0_10_radr);
    vec_rsc_0__10__INST.we(TLS_vec_rsc_0_10_we);
    vec_rsc_0__10__INST.d(TLS_vec_rsc_0_10_d);
    vec_rsc_0__10__INST.wadr(TLS_vec_rsc_0_10_wadr);
    vec_rsc_0__10__INST.clk(clk);
    vec_rsc_0__10__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__10__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_19)));

    vec_rsc_0__11__INST.q(TLS_vec_rsc_0_11_q);
    vec_rsc_0__11__INST.radr(TLS_vec_rsc_0_11_radr);
    vec_rsc_0__11__INST.we(TLS_vec_rsc_0_11_we);
    vec_rsc_0__11__INST.d(TLS_vec_rsc_0_11_d);
    vec_rsc_0__11__INST.wadr(TLS_vec_rsc_0_11_wadr);
    vec_rsc_0__11__INST.clk(clk);
    vec_rsc_0__11__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__11__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_20)));

    vec_rsc_0__12__INST.q(TLS_vec_rsc_0_12_q);
    vec_rsc_0__12__INST.radr(TLS_vec_rsc_0_12_radr);
    vec_rsc_0__12__INST.we(TLS_vec_rsc_0_12_we);
    vec_rsc_0__12__INST.d(TLS_vec_rsc_0_12_d);
    vec_rsc_0__12__INST.wadr(TLS_vec_rsc_0_12_wadr);
    vec_rsc_0__12__INST.clk(clk);
    vec_rsc_0__12__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__12__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_21)));

    vec_rsc_0__13__INST.q(TLS_vec_rsc_0_13_q);
    vec_rsc_0__13__INST.radr(TLS_vec_rsc_0_13_radr);
    vec_rsc_0__13__INST.we(TLS_vec_rsc_0_13_we);
    vec_rsc_0__13__INST.d(TLS_vec_rsc_0_13_d);
    vec_rsc_0__13__INST.wadr(TLS_vec_rsc_0_13_wadr);
    vec_rsc_0__13__INST.clk(clk);
    vec_rsc_0__13__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__13__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_22)));

    vec_rsc_0__14__INST.q(TLS_vec_rsc_0_14_q);
    vec_rsc_0__14__INST.radr(TLS_vec_rsc_0_14_radr);
    vec_rsc_0__14__INST.we(TLS_vec_rsc_0_14_we);
    vec_rsc_0__14__INST.d(TLS_vec_rsc_0_14_d);
    vec_rsc_0__14__INST.wadr(TLS_vec_rsc_0_14_wadr);
    vec_rsc_0__14__INST.clk(clk);
    vec_rsc_0__14__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__14__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_23)));

    vec_rsc_0__15__INST.q(TLS_vec_rsc_0_15_q);
    vec_rsc_0__15__INST.radr(TLS_vec_rsc_0_15_radr);
    vec_rsc_0__15__INST.we(TLS_vec_rsc_0_15_we);
    vec_rsc_0__15__INST.d(TLS_vec_rsc_0_15_d);
    vec_rsc_0__15__INST.wadr(TLS_vec_rsc_0_15_wadr);
    vec_rsc_0__15__INST.clk(clk);
    vec_rsc_0__15__INST.clken(SIG_SC_LOGIC_1);
    vec_rsc_0__15__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_24)));

    p_rsc_INST.dat(TLS_p_rsc_dat);
    p_rsc_INST.clk(clk);
    p_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_5)));

    r_rsc_INST.dat(TLS_r_rsc_dat);
    r_rsc_INST.clk(clk);
    r_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_6)));

    twiddle_rsc_0__0__INST.q(TLS_twiddle_rsc_0_0_q);
    twiddle_rsc_0__0__INST.radr(TLS_twiddle_rsc_0_0_radr);
    twiddle_rsc_0__0__INST.clk(clk);
    twiddle_rsc_0__0__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__0__INST.d(TLS_twiddle_rsc_0__0__d);
    twiddle_rsc_0__0__INST.wadr(TLS_twiddle_rsc_0__0__wadr);
    twiddle_rsc_0__0__INST.we(TLS_twiddle_rsc_0__0__we);
    twiddle_rsc_0__0__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_25)));

    twiddle_rsc_0__1__INST.q(TLS_twiddle_rsc_0_1_q);
    twiddle_rsc_0__1__INST.radr(TLS_twiddle_rsc_0_1_radr);
    twiddle_rsc_0__1__INST.clk(clk);
    twiddle_rsc_0__1__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__1__INST.d(TLS_twiddle_rsc_0__1__d);
    twiddle_rsc_0__1__INST.wadr(TLS_twiddle_rsc_0__1__wadr);
    twiddle_rsc_0__1__INST.we(TLS_twiddle_rsc_0__1__we);
    twiddle_rsc_0__1__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_26)));

    twiddle_rsc_0__2__INST.q(TLS_twiddle_rsc_0_2_q);
    twiddle_rsc_0__2__INST.radr(TLS_twiddle_rsc_0_2_radr);
    twiddle_rsc_0__2__INST.clk(clk);
    twiddle_rsc_0__2__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__2__INST.d(TLS_twiddle_rsc_0__2__d);
    twiddle_rsc_0__2__INST.wadr(TLS_twiddle_rsc_0__2__wadr);
    twiddle_rsc_0__2__INST.we(TLS_twiddle_rsc_0__2__we);
    twiddle_rsc_0__2__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_27)));

    twiddle_rsc_0__3__INST.q(TLS_twiddle_rsc_0_3_q);
    twiddle_rsc_0__3__INST.radr(TLS_twiddle_rsc_0_3_radr);
    twiddle_rsc_0__3__INST.clk(clk);
    twiddle_rsc_0__3__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__3__INST.d(TLS_twiddle_rsc_0__3__d);
    twiddle_rsc_0__3__INST.wadr(TLS_twiddle_rsc_0__3__wadr);
    twiddle_rsc_0__3__INST.we(TLS_twiddle_rsc_0__3__we);
    twiddle_rsc_0__3__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_28)));

    twiddle_rsc_0__4__INST.q(TLS_twiddle_rsc_0_4_q);
    twiddle_rsc_0__4__INST.radr(TLS_twiddle_rsc_0_4_radr);
    twiddle_rsc_0__4__INST.clk(clk);
    twiddle_rsc_0__4__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__4__INST.d(TLS_twiddle_rsc_0__4__d);
    twiddle_rsc_0__4__INST.wadr(TLS_twiddle_rsc_0__4__wadr);
    twiddle_rsc_0__4__INST.we(TLS_twiddle_rsc_0__4__we);
    twiddle_rsc_0__4__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_29)));

    twiddle_rsc_0__5__INST.q(TLS_twiddle_rsc_0_5_q);
    twiddle_rsc_0__5__INST.radr(TLS_twiddle_rsc_0_5_radr);
    twiddle_rsc_0__5__INST.clk(clk);
    twiddle_rsc_0__5__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__5__INST.d(TLS_twiddle_rsc_0__5__d);
    twiddle_rsc_0__5__INST.wadr(TLS_twiddle_rsc_0__5__wadr);
    twiddle_rsc_0__5__INST.we(TLS_twiddle_rsc_0__5__we);
    twiddle_rsc_0__5__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_30)));

    twiddle_rsc_0__6__INST.q(TLS_twiddle_rsc_0_6_q);
    twiddle_rsc_0__6__INST.radr(TLS_twiddle_rsc_0_6_radr);
    twiddle_rsc_0__6__INST.clk(clk);
    twiddle_rsc_0__6__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__6__INST.d(TLS_twiddle_rsc_0__6__d);
    twiddle_rsc_0__6__INST.wadr(TLS_twiddle_rsc_0__6__wadr);
    twiddle_rsc_0__6__INST.we(TLS_twiddle_rsc_0__6__we);
    twiddle_rsc_0__6__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_31)));

    twiddle_rsc_0__7__INST.q(TLS_twiddle_rsc_0_7_q);
    twiddle_rsc_0__7__INST.radr(TLS_twiddle_rsc_0_7_radr);
    twiddle_rsc_0__7__INST.clk(clk);
    twiddle_rsc_0__7__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__7__INST.d(TLS_twiddle_rsc_0__7__d);
    twiddle_rsc_0__7__INST.wadr(TLS_twiddle_rsc_0__7__wadr);
    twiddle_rsc_0__7__INST.we(TLS_twiddle_rsc_0__7__we);
    twiddle_rsc_0__7__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_32)));

    twiddle_rsc_0__8__INST.q(TLS_twiddle_rsc_0_8_q);
    twiddle_rsc_0__8__INST.radr(TLS_twiddle_rsc_0_8_radr);
    twiddle_rsc_0__8__INST.clk(clk);
    twiddle_rsc_0__8__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__8__INST.d(TLS_twiddle_rsc_0__8__d);
    twiddle_rsc_0__8__INST.wadr(TLS_twiddle_rsc_0__8__wadr);
    twiddle_rsc_0__8__INST.we(TLS_twiddle_rsc_0__8__we);
    twiddle_rsc_0__8__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_33)));

    twiddle_rsc_0__9__INST.q(TLS_twiddle_rsc_0_9_q);
    twiddle_rsc_0__9__INST.radr(TLS_twiddle_rsc_0_9_radr);
    twiddle_rsc_0__9__INST.clk(clk);
    twiddle_rsc_0__9__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__9__INST.d(TLS_twiddle_rsc_0__9__d);
    twiddle_rsc_0__9__INST.wadr(TLS_twiddle_rsc_0__9__wadr);
    twiddle_rsc_0__9__INST.we(TLS_twiddle_rsc_0__9__we);
    twiddle_rsc_0__9__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_34)));

    twiddle_rsc_0__10__INST.q(TLS_twiddle_rsc_0_10_q);
    twiddle_rsc_0__10__INST.radr(TLS_twiddle_rsc_0_10_radr);
    twiddle_rsc_0__10__INST.clk(clk);
    twiddle_rsc_0__10__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__10__INST.d(TLS_twiddle_rsc_0__10__d);
    twiddle_rsc_0__10__INST.wadr(TLS_twiddle_rsc_0__10__wadr);
    twiddle_rsc_0__10__INST.we(TLS_twiddle_rsc_0__10__we);
    twiddle_rsc_0__10__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_35)));

    twiddle_rsc_0__11__INST.q(TLS_twiddle_rsc_0_11_q);
    twiddle_rsc_0__11__INST.radr(TLS_twiddle_rsc_0_11_radr);
    twiddle_rsc_0__11__INST.clk(clk);
    twiddle_rsc_0__11__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__11__INST.d(TLS_twiddle_rsc_0__11__d);
    twiddle_rsc_0__11__INST.wadr(TLS_twiddle_rsc_0__11__wadr);
    twiddle_rsc_0__11__INST.we(TLS_twiddle_rsc_0__11__we);
    twiddle_rsc_0__11__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_36)));

    twiddle_rsc_0__12__INST.q(TLS_twiddle_rsc_0_12_q);
    twiddle_rsc_0__12__INST.radr(TLS_twiddle_rsc_0_12_radr);
    twiddle_rsc_0__12__INST.clk(clk);
    twiddle_rsc_0__12__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__12__INST.d(TLS_twiddle_rsc_0__12__d);
    twiddle_rsc_0__12__INST.wadr(TLS_twiddle_rsc_0__12__wadr);
    twiddle_rsc_0__12__INST.we(TLS_twiddle_rsc_0__12__we);
    twiddle_rsc_0__12__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_37)));

    twiddle_rsc_0__13__INST.q(TLS_twiddle_rsc_0_13_q);
    twiddle_rsc_0__13__INST.radr(TLS_twiddle_rsc_0_13_radr);
    twiddle_rsc_0__13__INST.clk(clk);
    twiddle_rsc_0__13__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__13__INST.d(TLS_twiddle_rsc_0__13__d);
    twiddle_rsc_0__13__INST.wadr(TLS_twiddle_rsc_0__13__wadr);
    twiddle_rsc_0__13__INST.we(TLS_twiddle_rsc_0__13__we);
    twiddle_rsc_0__13__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_38)));

    twiddle_rsc_0__14__INST.q(TLS_twiddle_rsc_0_14_q);
    twiddle_rsc_0__14__INST.radr(TLS_twiddle_rsc_0_14_radr);
    twiddle_rsc_0__14__INST.clk(clk);
    twiddle_rsc_0__14__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__14__INST.d(TLS_twiddle_rsc_0__14__d);
    twiddle_rsc_0__14__INST.wadr(TLS_twiddle_rsc_0__14__wadr);
    twiddle_rsc_0__14__INST.we(TLS_twiddle_rsc_0__14__we);
    twiddle_rsc_0__14__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_39)));

    twiddle_rsc_0__15__INST.q(TLS_twiddle_rsc_0_15_q);
    twiddle_rsc_0__15__INST.radr(TLS_twiddle_rsc_0_15_radr);
    twiddle_rsc_0__15__INST.clk(clk);
    twiddle_rsc_0__15__INST.clken(SIG_SC_LOGIC_1);
    twiddle_rsc_0__15__INST.d(TLS_twiddle_rsc_0__15__d);
    twiddle_rsc_0__15__INST.wadr(TLS_twiddle_rsc_0__15__wadr);
    twiddle_rsc_0__15__INST.we(TLS_twiddle_rsc_0__15__we);
    twiddle_rsc_0__15__INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_40)));

    trios_monitor_vec_rsc_triosy_0_0_lz_INST.trios(TLS_vec_rsc_triosy_0_0_lz);
    trios_monitor_vec_rsc_triosy_0_0_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_1_lz_INST.trios(TLS_vec_rsc_triosy_0_1_lz);
    trios_monitor_vec_rsc_triosy_0_1_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_2_lz_INST.trios(TLS_vec_rsc_triosy_0_2_lz);
    trios_monitor_vec_rsc_triosy_0_2_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_3_lz_INST.trios(TLS_vec_rsc_triosy_0_3_lz);
    trios_monitor_vec_rsc_triosy_0_3_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_4_lz_INST.trios(TLS_vec_rsc_triosy_0_4_lz);
    trios_monitor_vec_rsc_triosy_0_4_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_5_lz_INST.trios(TLS_vec_rsc_triosy_0_5_lz);
    trios_monitor_vec_rsc_triosy_0_5_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_6_lz_INST.trios(TLS_vec_rsc_triosy_0_6_lz);
    trios_monitor_vec_rsc_triosy_0_6_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_7_lz_INST.trios(TLS_vec_rsc_triosy_0_7_lz);
    trios_monitor_vec_rsc_triosy_0_7_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_8_lz_INST.trios(TLS_vec_rsc_triosy_0_8_lz);
    trios_monitor_vec_rsc_triosy_0_8_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_9_lz_INST.trios(TLS_vec_rsc_triosy_0_9_lz);
    trios_monitor_vec_rsc_triosy_0_9_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_10_lz_INST.trios(TLS_vec_rsc_triosy_0_10_lz);
    trios_monitor_vec_rsc_triosy_0_10_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_11_lz_INST.trios(TLS_vec_rsc_triosy_0_11_lz);
    trios_monitor_vec_rsc_triosy_0_11_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_12_lz_INST.trios(TLS_vec_rsc_triosy_0_12_lz);
    trios_monitor_vec_rsc_triosy_0_12_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_13_lz_INST.trios(TLS_vec_rsc_triosy_0_13_lz);
    trios_monitor_vec_rsc_triosy_0_13_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_14_lz_INST.trios(TLS_vec_rsc_triosy_0_14_lz);
    trios_monitor_vec_rsc_triosy_0_14_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_vec_rsc_triosy_0_15_lz_INST.trios(TLS_vec_rsc_triosy_0_15_lz);
    trios_monitor_vec_rsc_triosy_0_15_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_vec.in_fifo(TLS_in_fifo_vec);
    transactor_vec.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_vec);
    transactor_vec.out_fifo(TLS_out_fifo_vec);
    transactor_vec.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_vec);
    transactor_vec.bind_clk(clk, true, rst);
    transactor_vec.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_vec.register_block(&vec_rsc_0__0__INST, vec_rsc_0__0__INST.basename(), TLS_vec_rsc_triosy_0_0_lz,
        0, 1008, 16);
    transactor_vec.register_block(&vec_rsc_0__1__INST, vec_rsc_0__1__INST.basename(), TLS_vec_rsc_triosy_0_1_lz,
        1, 1009, 16);
    transactor_vec.register_block(&vec_rsc_0__2__INST, vec_rsc_0__2__INST.basename(), TLS_vec_rsc_triosy_0_2_lz,
        2, 1010, 16);
    transactor_vec.register_block(&vec_rsc_0__3__INST, vec_rsc_0__3__INST.basename(), TLS_vec_rsc_triosy_0_3_lz,
        3, 1011, 16);
    transactor_vec.register_block(&vec_rsc_0__4__INST, vec_rsc_0__4__INST.basename(), TLS_vec_rsc_triosy_0_4_lz,
        4, 1012, 16);
    transactor_vec.register_block(&vec_rsc_0__5__INST, vec_rsc_0__5__INST.basename(), TLS_vec_rsc_triosy_0_5_lz,
        5, 1013, 16);
    transactor_vec.register_block(&vec_rsc_0__6__INST, vec_rsc_0__6__INST.basename(), TLS_vec_rsc_triosy_0_6_lz,
        6, 1014, 16);
    transactor_vec.register_block(&vec_rsc_0__7__INST, vec_rsc_0__7__INST.basename(), TLS_vec_rsc_triosy_0_7_lz,
        7, 1015, 16);
    transactor_vec.register_block(&vec_rsc_0__8__INST, vec_rsc_0__8__INST.basename(), TLS_vec_rsc_triosy_0_8_lz,
        8, 1016, 16);
    transactor_vec.register_block(&vec_rsc_0__9__INST, vec_rsc_0__9__INST.basename(), TLS_vec_rsc_triosy_0_9_lz,
        9, 1017, 16);
    transactor_vec.register_block(&vec_rsc_0__10__INST, vec_rsc_0__10__INST.basename(), TLS_vec_rsc_triosy_0_10_lz,
        10, 1018, 16);
    transactor_vec.register_block(&vec_rsc_0__11__INST, vec_rsc_0__11__INST.basename(), TLS_vec_rsc_triosy_0_11_lz,
        11, 1019, 16);
    transactor_vec.register_block(&vec_rsc_0__12__INST, vec_rsc_0__12__INST.basename(), TLS_vec_rsc_triosy_0_12_lz,
        12, 1020, 16);
    transactor_vec.register_block(&vec_rsc_0__13__INST, vec_rsc_0__13__INST.basename(), TLS_vec_rsc_triosy_0_13_lz,
        13, 1021, 16);
    transactor_vec.register_block(&vec_rsc_0__14__INST, vec_rsc_0__14__INST.basename(), TLS_vec_rsc_triosy_0_14_lz,
        14, 1022, 16);
    transactor_vec.register_block(&vec_rsc_0__15__INST, vec_rsc_0__15__INST.basename(), TLS_vec_rsc_triosy_0_15_lz,
        15, 1023, 16);

    trios_monitor_p_rsc_triosy_lz_INST.trios(TLS_p_rsc_triosy_lz);
    trios_monitor_p_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_p.in_fifo(TLS_in_fifo_p);
    transactor_p.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_p);
    transactor_p.bind_clk(clk, true, rst);
    transactor_p.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_p.register_block(&p_rsc_INST, p_rsc_INST.basename(), TLS_p_rsc_triosy_lz, 0, 0, 1);

    trios_monitor_r_rsc_triosy_lz_INST.trios(TLS_r_rsc_triosy_lz);
    trios_monitor_r_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_r.in_fifo(TLS_in_fifo_r);
    transactor_r.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_r);
    transactor_r.bind_clk(clk, true, rst);
    transactor_r.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_r.register_block(&r_rsc_INST, r_rsc_INST.basename(), TLS_r_rsc_triosy_lz, 0, 0, 1);

    trios_monitor_twiddle_rsc_triosy_0_0_lz_INST.trios(TLS_twiddle_rsc_triosy_0_0_lz);
    trios_monitor_twiddle_rsc_triosy_0_0_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_1_lz_INST.trios(TLS_twiddle_rsc_triosy_0_1_lz);
    trios_monitor_twiddle_rsc_triosy_0_1_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_2_lz_INST.trios(TLS_twiddle_rsc_triosy_0_2_lz);
    trios_monitor_twiddle_rsc_triosy_0_2_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_3_lz_INST.trios(TLS_twiddle_rsc_triosy_0_3_lz);
    trios_monitor_twiddle_rsc_triosy_0_3_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_4_lz_INST.trios(TLS_twiddle_rsc_triosy_0_4_lz);
    trios_monitor_twiddle_rsc_triosy_0_4_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_5_lz_INST.trios(TLS_twiddle_rsc_triosy_0_5_lz);
    trios_monitor_twiddle_rsc_triosy_0_5_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_6_lz_INST.trios(TLS_twiddle_rsc_triosy_0_6_lz);
    trios_monitor_twiddle_rsc_triosy_0_6_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_7_lz_INST.trios(TLS_twiddle_rsc_triosy_0_7_lz);
    trios_monitor_twiddle_rsc_triosy_0_7_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_8_lz_INST.trios(TLS_twiddle_rsc_triosy_0_8_lz);
    trios_monitor_twiddle_rsc_triosy_0_8_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_9_lz_INST.trios(TLS_twiddle_rsc_triosy_0_9_lz);
    trios_monitor_twiddle_rsc_triosy_0_9_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_10_lz_INST.trios(TLS_twiddle_rsc_triosy_0_10_lz);
    trios_monitor_twiddle_rsc_triosy_0_10_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_11_lz_INST.trios(TLS_twiddle_rsc_triosy_0_11_lz);
    trios_monitor_twiddle_rsc_triosy_0_11_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_12_lz_INST.trios(TLS_twiddle_rsc_triosy_0_12_lz);
    trios_monitor_twiddle_rsc_triosy_0_12_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_13_lz_INST.trios(TLS_twiddle_rsc_triosy_0_13_lz);
    trios_monitor_twiddle_rsc_triosy_0_13_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_14_lz_INST.trios(TLS_twiddle_rsc_triosy_0_14_lz);
    trios_monitor_twiddle_rsc_triosy_0_14_lz_INST.register_mon(&catapult_monitor_INST);

    trios_monitor_twiddle_rsc_triosy_0_15_lz_INST.trios(TLS_twiddle_rsc_triosy_0_15_lz);
    trios_monitor_twiddle_rsc_triosy_0_15_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_twiddle.in_fifo(TLS_in_fifo_twiddle);
    transactor_twiddle.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_twiddle);
    transactor_twiddle.bind_clk(clk, true, rst);
    transactor_twiddle.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_twiddle.register_block(&twiddle_rsc_0__0__INST, twiddle_rsc_0__0__INST.basename(), TLS_twiddle_rsc_triosy_0_0_lz,
        0, 1008, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__1__INST, twiddle_rsc_0__1__INST.basename(), TLS_twiddle_rsc_triosy_0_1_lz,
        1, 1009, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__2__INST, twiddle_rsc_0__2__INST.basename(), TLS_twiddle_rsc_triosy_0_2_lz,
        2, 1010, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__3__INST, twiddle_rsc_0__3__INST.basename(), TLS_twiddle_rsc_triosy_0_3_lz,
        3, 1011, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__4__INST, twiddle_rsc_0__4__INST.basename(), TLS_twiddle_rsc_triosy_0_4_lz,
        4, 1012, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__5__INST, twiddle_rsc_0__5__INST.basename(), TLS_twiddle_rsc_triosy_0_5_lz,
        5, 1013, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__6__INST, twiddle_rsc_0__6__INST.basename(), TLS_twiddle_rsc_triosy_0_6_lz,
        6, 1014, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__7__INST, twiddle_rsc_0__7__INST.basename(), TLS_twiddle_rsc_triosy_0_7_lz,
        7, 1015, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__8__INST, twiddle_rsc_0__8__INST.basename(), TLS_twiddle_rsc_triosy_0_8_lz,
        8, 1016, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__9__INST, twiddle_rsc_0__9__INST.basename(), TLS_twiddle_rsc_triosy_0_9_lz,
        9, 1017, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__10__INST, twiddle_rsc_0__10__INST.basename(), TLS_twiddle_rsc_triosy_0_10_lz,
        10, 1018, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__11__INST, twiddle_rsc_0__11__INST.basename(), TLS_twiddle_rsc_triosy_0_11_lz,
        11, 1019, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__12__INST, twiddle_rsc_0__12__INST.basename(), TLS_twiddle_rsc_triosy_0_12_lz,
        12, 1020, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__13__INST, twiddle_rsc_0__13__INST.basename(), TLS_twiddle_rsc_triosy_0_13_lz,
        13, 1021, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__14__INST, twiddle_rsc_0__14__INST.basename(), TLS_twiddle_rsc_triosy_0_14_lz,
        14, 1022, 16);
    transactor_twiddle.register_block(&twiddle_rsc_0__15__INST, twiddle_rsc_0__15__INST.basename(), TLS_twiddle_rsc_triosy_0_15_lz,
        15, 1023, 16);

    testbench_INST.clk(clk);
    testbench_INST.ccs_vec_IN(TLS_in_fifo_vec);
    testbench_INST.ccs_wait_ctrl_vec_IN(TLS_in_wait_ctrl_fifo_vec);
    testbench_INST.ccs_vec(TLS_out_fifo_vec);
    testbench_INST.ccs_wait_ctrl_vec(TLS_out_wait_ctrl_fifo_vec);
    testbench_INST.ccs_p(TLS_in_fifo_p);
    testbench_INST.ccs_wait_ctrl_p(TLS_in_wait_ctrl_fifo_p);
    testbench_INST.ccs_r(TLS_in_fifo_r);
    testbench_INST.ccs_wait_ctrl_r(TLS_in_wait_ctrl_fifo_r);
    testbench_INST.ccs_twiddle(TLS_in_fifo_twiddle);
    testbench_INST.ccs_wait_ctrl_twiddle(TLS_in_wait_ctrl_fifo_twiddle);
    testbench_INST.design_is_idle(TLS_design_is_idle_reg);
    testbench_INST.enable_stalls(TLS_enable_stalls);
    testbench_INST.stall_coverage(TLS_stall_coverage);

    sync_generator_INST.clk(clk);
    sync_generator_INST.rst(rst);
    sync_generator_INST.in_sync(in_sync);
    sync_generator_INST.out_sync(out_sync);
    sync_generator_INST.inout_sync(inout_sync);
    sync_generator_INST.wait_for_init(wait_for_init);
    sync_generator_INST.catapult_start(catapult_start);
    sync_generator_INST.catapult_ready(catapult_ready);
    sync_generator_INST.catapult_done(catapult_done);

    catapult_monitor_INST.rst(rst);


    SC_METHOD(TLS_rst_method);
      sensitive_pos << TLS_rst;
      dont_initialize();

    SC_METHOD(max_sim_time_notify);
      sensitive << max_sim_time_event;
      dont_initialize();

    SC_METHOD(generate_reset);
      sensitive << generate_reset_event;
      sensitive << testbench_INST.reset_request_event;

    SC_METHOD(deadlock_watch);
      sensitive << clk;
      dont_initialize();

    SC_METHOD(deadlock_notify);
      sensitive << deadlock_event;
      dont_initialize();


    #if defined(CCS_SCVERIFY) && defined(CCS_DUT_RTL) && !defined(CCS_DUT_SYSC) && !defined(CCS_SYSC) && !defined(CCS_DUT_POWER)
        ccs_probe_monitor_INST = new ccs_probe_monitor("ccs_probe_monitor");
    ccs_probe_monitor_INST->clk(clk);
    ccs_probe_monitor_INST->rst(rst);
    #endif
    SIG_SC_LOGIC_0.write(SC_LOGIC_0);
    SIG_SC_LOGIC_1.write(SC_LOGIC_1);
    mt19937_init_genrand(19650218UL);
    install_observe_foreign_signals();
  }
};
void scverify_top::TLS_rst_method() {
  std::ostringstream msg;
  msg << "TLS_rst active @ " << sc_time_stamp();
  SC_REPORT_INFO("HW reset", msg.str().c_str());
  vec_rsc_0__0__INST.clear();
  vec_rsc_0__1__INST.clear();
  vec_rsc_0__2__INST.clear();
  vec_rsc_0__3__INST.clear();
  vec_rsc_0__4__INST.clear();
  vec_rsc_0__5__INST.clear();
  vec_rsc_0__6__INST.clear();
  vec_rsc_0__7__INST.clear();
  vec_rsc_0__8__INST.clear();
  vec_rsc_0__9__INST.clear();
  vec_rsc_0__10__INST.clear();
  vec_rsc_0__11__INST.clear();
  vec_rsc_0__12__INST.clear();
  vec_rsc_0__13__INST.clear();
  vec_rsc_0__14__INST.clear();
  vec_rsc_0__15__INST.clear();
  p_rsc_INST.clear();
  r_rsc_INST.clear();
  twiddle_rsc_0__0__INST.clear();
  twiddle_rsc_0__1__INST.clear();
  twiddle_rsc_0__2__INST.clear();
  twiddle_rsc_0__3__INST.clear();
  twiddle_rsc_0__4__INST.clear();
  twiddle_rsc_0__5__INST.clear();
  twiddle_rsc_0__6__INST.clear();
  twiddle_rsc_0__7__INST.clear();
  twiddle_rsc_0__8__INST.clear();
  twiddle_rsc_0__9__INST.clear();
  twiddle_rsc_0__10__INST.clear();
  twiddle_rsc_0__11__INST.clear();
  twiddle_rsc_0__12__INST.clear();
  twiddle_rsc_0__13__INST.clear();
  twiddle_rsc_0__14__INST.clear();
  twiddle_rsc_0__15__INST.clear();
}

void scverify_top::max_sim_time_notify() {
  testbench_INST.set_failed(true);
  testbench_INST.check_results();
  SC_REPORT_ERROR("System", "Specified maximum simulation time reached");
  sc_stop();
}

void scverify_top::start_of_simulation() {
  char *SCVerify_AUTOWAIT = getenv("SCVerify_AUTOWAIT");
  if (SCVerify_AUTOWAIT) {
    int l = atoi(SCVerify_AUTOWAIT);
    transactor_vec.set_auto_wait_limit(l);
    transactor_p.set_auto_wait_limit(l);
    transactor_r.set_auto_wait_limit(l);
    transactor_twiddle.set_auto_wait_limit(l);
  }
}

void scverify_top::setup_debug() {
#ifdef MC_DEFAULT_TRANSACTOR_LOG
  static int transactor_vec_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_p_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_r_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_twiddle_flags = MC_DEFAULT_TRANSACTOR_LOG;
#else
  static int transactor_vec_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_p_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_r_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_twiddle_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
#endif
  static int transactor_vec_count = -1;
  static int transactor_p_count = -1;
  static int transactor_r_count = -1;
  static int transactor_twiddle_count = -1;

  // At the breakpoint, modify the local variables
  // above to turn on/off different levels of transaction
  // logging for each variable. Available flags are:
  //   MC_TRANSACTOR_EMPTY       - log empty FIFOs (on by default)
  //   MC_TRANSACTOR_UNDERFLOW   - log FIFOs that run empty and then are loaded again (off)
  //   MC_TRANSACTOR_READ        - log all read events
  //   MC_TRANSACTOR_WRITE       - log all write events
  //   MC_TRANSACTOR_LOAD        - log all FIFO load events
  //   MC_TRANSACTOR_DUMP        - log all FIFO dump events
  //   MC_TRANSACTOR_STREAMCNT   - log all streamed port index counter events
  //   MC_TRANSACTOR_WAIT        - log user specified handshake waits
  //   MC_TRANSACTOR_SIZE        - log input FIFO size updates

  std::ifstream debug_cmds;
  debug_cmds.open("scverify.cmd",std::fstream::in);
  if (debug_cmds.is_open()) {
    std::cout << "Reading SCVerify debug commands from file 'scverify.cmd'" << std::endl;
    std::string line;
    while (getline(debug_cmds,line)) {
      std::size_t pos1 = line.find(" ");
      if (pos1 == std::string::npos) continue;
      std::size_t pos2 = line.find(" ", pos1+1);
      std::string varname = line.substr(0,pos1);
      std::string flags = line.substr(pos1+1,pos2-pos1-1);
      std::string count = line.substr(pos2+1);
      debug(varname.c_str(),std::atoi(flags.c_str()),std::atoi(count.c_str()));
    }
    debug_cmds.close();
  } else {
    debug("transactor_vec",transactor_vec_flags,transactor_vec_count);
    debug("transactor_p",transactor_p_flags,transactor_p_count);
    debug("transactor_r",transactor_r_flags,transactor_r_count);
    debug("transactor_twiddle",transactor_twiddle_flags,transactor_twiddle_count);
  }
}

void scverify_top::debug(const char* varname, int flags, int count) {
  sc_module *xlator_p = 0;
  sc_attr_base *debug_attr_p = 0;
  if (strcmp(varname,"transactor_vec") == 0)
    xlator_p = &transactor_vec;
  if (strcmp(varname,"transactor_p") == 0)
    xlator_p = &transactor_p;
  if (strcmp(varname,"transactor_r") == 0)
    xlator_p = &transactor_r;
  if (strcmp(varname,"transactor_twiddle") == 0)
    xlator_p = &transactor_twiddle;
  if (xlator_p) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_EVENT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_EVENT",flags);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = flags;
  }

  if (count>=0) {
    debug_attr_p = xlator_p->get_attribute("MC_TRANSACTOR_COUNT");
    if (!debug_attr_p) {
      debug_attr_p = new sc_attribute<int>("MC_TRANSACTOR_COUNT",count);
      xlator_p->add_attribute(*debug_attr_p);
    }
    ((sc_attribute<int>*)debug_attr_p)->value = count;
  }
}

// Process: SC_METHOD generate_reset
void scverify_top::generate_reset() {
  static bool activate_reset = true;
  static bool toggle_hw_reset = false;
  if (activate_reset || sc_time_stamp() == SC_ZERO_TIME) {
    setup_debug();
    activate_reset = false;
    rst.write(SC_LOGIC_1);
    rst_driver.reset_driver();
    generate_reset_event.notify(140.000000 , SC_NS);
  } else {
    if (toggle_hw_reset) {
      toggle_hw_reset = false;
      generate_reset_event.notify(140.000000 , SC_NS);
    } else {
      transactor_vec.reset_streams();
      transactor_p.reset_streams();
      transactor_r.reset_streams();
      transactor_twiddle.reset_streams();
      rst.write(SC_LOGIC_0);
    }
    activate_reset = true;
  }
}

void scverify_top::install_observe_foreign_signals() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#endif
#endif
}

void scverify_top::deadlock_watch() {
#if !defined(CCS_DUT_SYSC) && defined(DEADLOCK_DETECTION)
#if defined(CCS_DUT_CYCLE) || defined(CCS_DUT_RTL)
#if defined(MTI_SYSTEMC) || defined(NCSC) || defined(VCS_SYSTEMC)
#endif
#endif
#endif
}

void scverify_top::deadlock_notify() {
  if (deadlocked.read() == SC_LOGIC_1) {
    testbench_INST.check_results();
    SC_REPORT_ERROR("System", "Simulation deadlock detected");
    sc_stop();
  }
}

#if defined(MC_SIMULATOR_OSCI) || defined(MC_SIMULATOR_VCS)
int sc_main(int argc, char *argv[]) {
  sc_report_handler::set_actions("/IEEE_Std_1666/deprecated", SC_DO_NOTHING);
  scverify_top scverify_top("scverify_top");
  sc_start();
  return scverify_top.testbench_INST.failed();
}
#else
MC_MODULE_EXPORT(scverify_top);
#endif
