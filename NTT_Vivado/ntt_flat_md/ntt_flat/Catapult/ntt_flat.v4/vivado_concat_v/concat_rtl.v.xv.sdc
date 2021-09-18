# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 5.26 -waveform { 0.0 2.63 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 5.26
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
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_adra[*]}]
set_max_delay 5.26 -from [all_inputs] -to [all_outputs]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_wea}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {result_rsc_web}]
set_input_delay -clock [get_clocks {clk}] 2.4 [get_ports {result_rsc_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {result_rsc_triosy_lz}]

