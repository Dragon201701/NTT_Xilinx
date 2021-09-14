# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 5.0 -waveform { 0.0 2.5 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 5.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_0_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_0_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_0_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_0_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_1_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_1_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_1_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_1_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_2_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_2_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_2_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_2_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_3_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_3_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_3_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_3_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_4_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_4_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_4_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_4_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_5_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_5_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_5_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_5_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_6_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_6_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_6_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_6_lz}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_adra[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_da[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_wea}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_7_qa[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_adrb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_db[*]}]
set_output_delay -clock [get_clocks {clk}] 0.5 [get_ports {xt_rsc_0_7_web}]
set_input_delay -clock [get_clocks {clk}] 2.68 [get_ports {xt_rsc_0_7_qb[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {xt_rsc_triosy_0_7_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {p_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {r_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_0_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_0_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_triosy_0_0_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_1_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_1_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_triosy_0_1_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_2_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_2_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_triosy_0_2_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_0_3_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_rsc_0_3_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_rsc_triosy_0_3_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_0_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_0_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_triosy_0_0_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_1_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_1_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_triosy_0_1_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_2_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_2_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_triosy_0_2_lz}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_0_3_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.95 [get_ports {twiddle_h_rsc_0_3_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {twiddle_h_rsc_triosy_0_3_lz}]

