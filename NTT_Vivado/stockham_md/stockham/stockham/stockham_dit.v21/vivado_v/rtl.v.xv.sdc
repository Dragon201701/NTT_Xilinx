# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 7.41 -waveform { 0.0 3.705 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 7.41
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_1_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_1_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_1_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_2_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_2_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_2_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_3_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_3_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_3_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_4_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_4_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_4_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_5_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_5_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_5_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_6_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_6_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_6_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_7_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {xt_rsc_0_7_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_7_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_rsc_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {twiddle_h_rsc_radr[*]}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {twiddle_h_rsc_q[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_triosy_lz}]

