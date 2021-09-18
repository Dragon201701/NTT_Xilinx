# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 5.99 -waveform { 0.0 2.995 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 5.99
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {vec_rsc_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {vec_rsc_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {vec_rsc_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {vec_rsc_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {vec_rsc_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {vec_rsc_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {vec_rsc_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {vec_rsc_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {vec_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_rsc_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_rsc_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_h_rsc_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_h_rsc_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_adra[*]}]
set_max_delay 5.99 -from [all_inputs] -to [all_outputs]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_0_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_0_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_0_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_0_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_1_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_1_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_1_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_1_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_2_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_2_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_2_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_2_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_3_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_3_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_3_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_3_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_4_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_4_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_4_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_4_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_5_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_5_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_5_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_5_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_6_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_6_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_6_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_6_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_7_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_7_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_7_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_7_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_8_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_8_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_8_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_8_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_9_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_9_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_9_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_9_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_10_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_10_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_10_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_10_0_lz}]

