# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 20.0 -waveform { 0.0 10.0 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 20.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_0_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_0_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_1_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_1_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_1_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_1_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_1_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_2_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_2_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_2_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_2_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_2_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_3_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_3_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_3_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_3_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_3_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_4_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_4_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_4_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_4_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_4_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_5_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_5_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_5_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_5_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_5_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_6_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_6_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_6_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_6_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_6_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_7_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_7_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_7_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_7_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_7_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_8_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_8_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_8_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_8_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_8_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_9_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_9_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_9_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_9_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_9_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_10_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_10_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_10_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_10_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_10_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_11_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_11_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_11_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_11_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_11_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_12_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_12_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_12_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_12_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_12_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_13_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_13_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_13_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_13_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_13_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_14_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_14_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_14_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_14_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_14_lz}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_15_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_15_da[*]}]
set_output_delay -clock [get_clocks {clk}] 1.17 [get_ports {vec_rsc_0_15_wea}]
set_input_delay -clock [get_clocks {clk}] 1.51 [get_ports {vec_rsc_0_15_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_0_15_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_triosy_lz}]

