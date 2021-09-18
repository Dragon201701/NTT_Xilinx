# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 5.99 -waveform { 0.0 2.995 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 5.99
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {vec_rsc_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {vec_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_h_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_wadr[*]}]
set_max_delay 5.99 -from [all_inputs] -to [all_outputs]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_0_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_0_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_1_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_1_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_2_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_2_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_3_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_3_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_4_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_4_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_5_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_5_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_6_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_6_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_7_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_7_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_8_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_8_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_9_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_9_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_10_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_10_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_11_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_11_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_11_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_11_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_11_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_11_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_12_0_wadr[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_12_0_d[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_12_0_we}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_12_0_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_12_0_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_12_0_lz}]

