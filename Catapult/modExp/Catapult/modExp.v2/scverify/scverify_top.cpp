#include <string>
#include <fstream>
#include <iostream>
#include "mc_testbench.h"
#include <mc_reset.h>
#include <mc_transactors.h>
#include <mc_scverify.h>
#include <mc_stall_ctrl.h>
#include "ccs_ioport_trans_rsc_v1.h"
#include "mgc_ioport_trans_rsc_v1.h"
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
#define TOP_HDL_ENTITY modExp
#endif
// Hold time for the SCVerify testbench to account for the gate delay after downstream synthesis in pico second(s)
// Hold time value is obtained from 'top_gate_constraints.cpp', which is generated at the end of RTL synthesis
#ifdef CCS_DUT_GATE
extern double __scv_hold_time;
extern double __scv_hold_time_RSCID_1;
extern double __scv_hold_time_RSCID_2;
extern double __scv_hold_time_RSCID_3;
extern double __scv_hold_time_RSCID_4;
#else
double __scv_hold_time = 0.0; // default for non-gate simulation is zero
double __scv_hold_time_RSCID_1 = 0;
double __scv_hold_time_RSCID_2 = 0;
double __scv_hold_time_RSCID_3 = 0;
double __scv_hold_time_RSCID_4 = 0;
#endif

class scverify_top : public sc_module
{
public:
  sc_signal<sc_logic>                               rst;
  sc_signal<sc_logic>                               rst_n;
  sc_signal<sc_logic>                               SIG_SC_LOGIC_0;
  sc_signal<sc_logic>                               SIG_SC_LOGIC_1;
  sc_signal<sc_logic>                               TLS_design_is_idle;
  sc_signal<bool>                                   TLS_design_is_idle_reg;
  sc_clock                                          clk;
  mc_programmable_reset                             rst_driver;
  sc_signal<sc_logic>                               TLS_rst;
  sc_signal<sc_lv<64> >                             TLS_base_rsc_dat;
  sc_signal<sc_logic>                               TLS_base_rsc_triosy_lz;
  sc_signal<sc_lv<64> >                             TLS_exp_rsc_dat;
  sc_signal<sc_logic>                               TLS_exp_rsc_triosy_lz;
  sc_signal<sc_lv<64> >                             TLS_m_rsc_dat;
  sc_signal<sc_logic>                               TLS_m_rsc_triosy_lz;
  sc_signal<sc_lv<64> >                             TLS_result_rsc_zout;
  sc_signal<sc_logic>                               TLS_result_rsc_lzout;
  sc_signal<sc_lv<64> >                             TLS_result_rsc_zin;
  sc_signal<sc_logic>                               TLS_result_rsc_triosy_lz;
  ccs_DUT_wrapper                                   modExp_INST;
  ccs_in_trans_rsc_v1<1,64 >                        base_rsc_INST;
  ccs_in_trans_rsc_v1<1,64 >                        exp_rsc_INST;
  ccs_in_trans_rsc_v1<1,64 >                        m_rsc_INST;
  mgc_inout_prereg_en_trans_rsc_v1<1,64 >           result_rsc_INST;
  tlm::tlm_fifo<ac_int<64, false > >                TLS_in_fifo_base;
  tlm::tlm_fifo<mc_wait_ctrl>                       TLS_in_wait_ctrl_fifo_base;
  mc_trios_input_monitor                            trios_monitor_base_rsc_triosy_lz_INST;
  mc_input_transactor<ac_int<64, false >,64,false>  transactor_base;
  tlm::tlm_fifo<ac_int<64, false > >                TLS_in_fifo_exp;
  tlm::tlm_fifo<mc_wait_ctrl>                       TLS_in_wait_ctrl_fifo_exp;
  mc_trios_input_monitor                            trios_monitor_exp_rsc_triosy_lz_INST;
  mc_input_transactor<ac_int<64, false >,64,false>  transactor_exp;
  tlm::tlm_fifo<ac_int<64, false > >                TLS_in_fifo_m;
  tlm::tlm_fifo<mc_wait_ctrl>                       TLS_in_wait_ctrl_fifo_m;
  mc_trios_input_monitor                            trios_monitor_m_rsc_triosy_lz_INST;
  mc_input_transactor<ac_int<64, false >,64,false>  transactor_m;
  tlm::tlm_fifo<ac_int<64, false > >                TLS_in_fifo_result;
  tlm::tlm_fifo<mc_wait_ctrl>                       TLS_in_wait_ctrl_fifo_result;
  tlm::tlm_fifo<ac_int<64, false > >                TLS_out_fifo_result;
  tlm::tlm_fifo<mc_wait_ctrl>                       TLS_out_wait_ctrl_fifo_result;
  mc_trios_inout_monitor                            trios_monitor_result_rsc_triosy_lz_INST;
  mc_inout_transactor<ac_int<64, false >,64,false>  transactor_result;
  mc_testbench                                      testbench_INST;
  sc_signal<sc_logic>                               catapult_start;
  sc_signal<sc_logic>                               catapult_done;
  sc_signal<sc_logic>                               catapult_ready;
  sc_signal<sc_logic>                               in_sync;
  sc_signal<sc_logic>                               out_sync;
  sc_signal<sc_logic>                               inout_sync;
  sc_signal<unsigned>                               wait_for_init;
  sync_generator                                    sync_generator_INST;
  catapult_monitor                                  catapult_monitor_INST;
  ccs_probe_monitor                                *ccs_probe_monitor_INST;
  sc_event                                          generate_reset_event;
  sc_event                                          deadlock_event;
  sc_signal<sc_logic>                               deadlocked;
  sc_signal<sc_logic>                               maxsimtime;
  sc_event                                          max_sim_time_event;
  sc_signal<sc_logic>                               TLS_enable_stalls;
  sc_signal<unsigned short>                         TLS_stall_coverage;

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
    , CCS_CLK_CTOR(clk, "clk", 10, SC_NS, 0.5, 0, SC_NS, false)
    , rst_driver("rst_driver", 120.000000, false)
    , TLS_rst("TLS_rst")
    , TLS_base_rsc_dat("TLS_base_rsc_dat")
    , TLS_base_rsc_triosy_lz("TLS_base_rsc_triosy_lz")
    , TLS_exp_rsc_dat("TLS_exp_rsc_dat")
    , TLS_exp_rsc_triosy_lz("TLS_exp_rsc_triosy_lz")
    , TLS_m_rsc_dat("TLS_m_rsc_dat")
    , TLS_m_rsc_triosy_lz("TLS_m_rsc_triosy_lz")
    , TLS_result_rsc_zout("TLS_result_rsc_zout")
    , TLS_result_rsc_lzout("TLS_result_rsc_lzout")
    , TLS_result_rsc_zin("TLS_result_rsc_zin")
    , TLS_result_rsc_triosy_lz("TLS_result_rsc_triosy_lz")
    , modExp_INST("rtl", TO_QUOTED_STRING(TOP_HDL_ENTITY))
    , base_rsc_INST("base_rsc", true)
    , exp_rsc_INST("exp_rsc", true)
    , m_rsc_INST("m_rsc", true)
    , result_rsc_INST("result_rsc", true)
    , TLS_in_fifo_base("TLS_in_fifo_base", -1)
    , TLS_in_wait_ctrl_fifo_base("TLS_in_wait_ctrl_fifo_base", -1)
    , trios_monitor_base_rsc_triosy_lz_INST("trios_monitor_base_rsc_triosy_lz_INST")
    , transactor_base("transactor_base", 0, 64, 0)
    , TLS_in_fifo_exp("TLS_in_fifo_exp", -1)
    , TLS_in_wait_ctrl_fifo_exp("TLS_in_wait_ctrl_fifo_exp", -1)
    , trios_monitor_exp_rsc_triosy_lz_INST("trios_monitor_exp_rsc_triosy_lz_INST")
    , transactor_exp("transactor_exp", 0, 64, 0)
    , TLS_in_fifo_m("TLS_in_fifo_m", -1)
    , TLS_in_wait_ctrl_fifo_m("TLS_in_wait_ctrl_fifo_m", -1)
    , trios_monitor_m_rsc_triosy_lz_INST("trios_monitor_m_rsc_triosy_lz_INST")
    , transactor_m("transactor_m", 0, 64, 0)
    , TLS_in_fifo_result("TLS_in_fifo_result", -1)
    , TLS_in_wait_ctrl_fifo_result("TLS_in_wait_ctrl_fifo_result", -1)
    , TLS_out_fifo_result("TLS_out_fifo_result", -1)
    , TLS_out_wait_ctrl_fifo_result("TLS_out_wait_ctrl_fifo_result", -1)
    , trios_monitor_result_rsc_triosy_lz_INST("trios_monitor_result_rsc_triosy_lz_INST")
    , transactor_result("transactor_result", 0, 64, 0)
    , testbench_INST("user_tb")
    , catapult_start("catapult_start")
    , catapult_done("catapult_done")
    , catapult_ready("catapult_ready")
    , in_sync("in_sync")
    , out_sync("out_sync")
    , inout_sync("inout_sync")
    , wait_for_init("wait_for_init")
    , sync_generator_INST("sync_generator", true, false, false, false, 26, 26, 0)
    , catapult_monitor_INST("Monitor", clk, true, 26LL, 25LL)
    , ccs_probe_monitor_INST(NULL)
    , deadlocked("deadlocked")
    , maxsimtime("maxsimtime")
  {
    rst_driver.reset_out(TLS_rst);

    modExp_INST.clk(clk);
    modExp_INST.rst(TLS_rst);
    modExp_INST.base_rsc_dat(TLS_base_rsc_dat);
    modExp_INST.base_rsc_triosy_lz(TLS_base_rsc_triosy_lz);
    modExp_INST.exp_rsc_dat(TLS_exp_rsc_dat);
    modExp_INST.exp_rsc_triosy_lz(TLS_exp_rsc_triosy_lz);
    modExp_INST.m_rsc_dat(TLS_m_rsc_dat);
    modExp_INST.m_rsc_triosy_lz(TLS_m_rsc_triosy_lz);
    modExp_INST.result_rsc_zout(TLS_result_rsc_zout);
    modExp_INST.result_rsc_lzout(TLS_result_rsc_lzout);
    modExp_INST.result_rsc_zin(TLS_result_rsc_zin);
    modExp_INST.result_rsc_triosy_lz(TLS_result_rsc_triosy_lz);

    base_rsc_INST.dat(TLS_base_rsc_dat);
    base_rsc_INST.clk(clk);
    base_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_1)));

    exp_rsc_INST.dat(TLS_exp_rsc_dat);
    exp_rsc_INST.clk(clk);
    exp_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_2)));

    m_rsc_INST.dat(TLS_m_rsc_dat);
    m_rsc_INST.clk(clk);
    m_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_3)));

    result_rsc_INST.zin(TLS_result_rsc_zin);
    result_rsc_INST.lzout(TLS_result_rsc_lzout);
    result_rsc_INST.zout(TLS_result_rsc_zout);
    result_rsc_INST.clk(clk);
    result_rsc_INST.add_attribute(*(new sc_attribute<double>("CLK_SKEW_DELAY", __scv_hold_time_RSCID_4)));

    trios_monitor_base_rsc_triosy_lz_INST.trios(TLS_base_rsc_triosy_lz);
    trios_monitor_base_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_base.in_fifo(TLS_in_fifo_base);
    transactor_base.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_base);
    transactor_base.bind_clk(clk, true, rst);
    transactor_base.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_base.register_block(&base_rsc_INST, base_rsc_INST.basename(), TLS_base_rsc_triosy_lz, 0, 0, 1);

    trios_monitor_exp_rsc_triosy_lz_INST.trios(TLS_exp_rsc_triosy_lz);
    trios_monitor_exp_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_exp.in_fifo(TLS_in_fifo_exp);
    transactor_exp.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_exp);
    transactor_exp.bind_clk(clk, true, rst);
    transactor_exp.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_exp.register_block(&exp_rsc_INST, exp_rsc_INST.basename(), TLS_exp_rsc_triosy_lz, 0, 0, 1);

    trios_monitor_m_rsc_triosy_lz_INST.trios(TLS_m_rsc_triosy_lz);
    trios_monitor_m_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_m.in_fifo(TLS_in_fifo_m);
    transactor_m.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_m);
    transactor_m.bind_clk(clk, true, rst);
    transactor_m.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_m.register_block(&m_rsc_INST, m_rsc_INST.basename(), TLS_m_rsc_triosy_lz, 0, 0, 1);

    trios_monitor_result_rsc_triosy_lz_INST.trios(TLS_result_rsc_triosy_lz);
    trios_monitor_result_rsc_triosy_lz_INST.register_mon(&catapult_monitor_INST);

    transactor_result.in_fifo(TLS_in_fifo_result);
    transactor_result.in_wait_ctrl_fifo(TLS_in_wait_ctrl_fifo_result);
    transactor_result.out_fifo(TLS_out_fifo_result);
    transactor_result.out_wait_ctrl_fifo(TLS_out_wait_ctrl_fifo_result);
    transactor_result.bind_clk(clk, true, rst);
    transactor_result.add_attribute(*(new sc_attribute<int>("MC_TRANSACTOR_EVENT", 0 )));
    transactor_result.register_block(&result_rsc_INST, result_rsc_INST.basename(), TLS_result_rsc_triosy_lz, 0,
        0, 1);

    testbench_INST.clk(clk);
    testbench_INST.ccs_base(TLS_in_fifo_base);
    testbench_INST.ccs_wait_ctrl_base(TLS_in_wait_ctrl_fifo_base);
    testbench_INST.ccs_exp(TLS_in_fifo_exp);
    testbench_INST.ccs_wait_ctrl_exp(TLS_in_wait_ctrl_fifo_exp);
    testbench_INST.ccs_m(TLS_in_fifo_m);
    testbench_INST.ccs_wait_ctrl_m(TLS_in_wait_ctrl_fifo_m);
    testbench_INST.ccs_result_IN(TLS_in_fifo_result);
    testbench_INST.ccs_wait_ctrl_result_IN(TLS_in_wait_ctrl_fifo_result);
    testbench_INST.ccs_result(TLS_out_fifo_result);
    testbench_INST.ccs_wait_ctrl_result(TLS_out_wait_ctrl_fifo_result);
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
  base_rsc_INST.clear();
  exp_rsc_INST.clear();
  m_rsc_INST.clear();
  result_rsc_INST.clear();
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
    transactor_base.set_auto_wait_limit(l);
    transactor_exp.set_auto_wait_limit(l);
    transactor_m.set_auto_wait_limit(l);
    transactor_result.set_auto_wait_limit(l);
  }
}

void scverify_top::setup_debug() {
#ifdef MC_DEFAULT_TRANSACTOR_LOG
  static int transactor_base_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_exp_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_m_flags = MC_DEFAULT_TRANSACTOR_LOG;
  static int transactor_result_flags = MC_DEFAULT_TRANSACTOR_LOG;
#else
  static int transactor_base_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_exp_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_m_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
  static int transactor_result_flags = MC_TRANSACTOR_UNDERFLOW | MC_TRANSACTOR_WAIT;
#endif
  static int transactor_base_count = -1;
  static int transactor_exp_count = -1;
  static int transactor_m_count = -1;
  static int transactor_result_count = -1;

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
    debug("transactor_base",transactor_base_flags,transactor_base_count);
    debug("transactor_exp",transactor_exp_flags,transactor_exp_count);
    debug("transactor_m",transactor_m_flags,transactor_m_count);
    debug("transactor_result",transactor_result_flags,transactor_result_count);
  }
}

void scverify_top::debug(const char* varname, int flags, int count) {
  sc_module *xlator_p = 0;
  sc_attr_base *debug_attr_p = 0;
  if (strcmp(varname,"transactor_base") == 0)
    xlator_p = &transactor_base;
  if (strcmp(varname,"transactor_exp") == 0)
    xlator_p = &transactor_exp;
  if (strcmp(varname,"transactor_m") == 0)
    xlator_p = &transactor_m;
  if (strcmp(varname,"transactor_result") == 0)
    xlator_p = &transactor_result;
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
    generate_reset_event.notify(120.000000 , SC_NS);
  } else {
    if (toggle_hw_reset) {
      toggle_hw_reset = false;
      generate_reset_event.notify(120.000000 , SC_NS);
    } else {
      transactor_base.reset_streams();
      transactor_exp.reset_streams();
      transactor_m.reset_streams();
      transactor_result.reset_streams();
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
