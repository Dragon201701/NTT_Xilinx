void mc_testbench_capture_IN( ac_sync &run,  ac_int<32, false > a[16],  ac_sync &complete) { mc_testbench::capture_IN(run,a,complete); }
void mc_testbench_capture_OUT( ac_sync &run,  ac_int<32, false > a[16],  ac_sync &complete) { mc_testbench::capture_OUT(run,a,complete); }
void mc_testbench_wait_for_idle_sync() {mc_testbench::wait_for_idle_sync(); }

