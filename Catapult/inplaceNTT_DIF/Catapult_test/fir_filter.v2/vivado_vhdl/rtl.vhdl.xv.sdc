# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 10.0 -waveform { 0.0 5.0 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 10.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {i_sample_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {i_sample_rsc_triosy_lz}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_s_tdone}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_tr_write_done}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_RREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_RVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_RUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_RLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_RRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_RDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_RID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARREADY}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARVALID}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARUSER}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_ARID}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_BREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_BVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_BUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_BRESP[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_BID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_WREADY}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_WVALID}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_WUSER}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_WLAST}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_WSTRB[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_WDATA[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWREADY}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWVALID}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWUSER}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWREGION[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWQOS[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWPROT[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWCACHE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWLOCK}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWBURST[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWSIZE[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWLEN[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWADDR[*]}]
set_input_delay -clock [get_clocks {clk}] 0.87 [get_ports {b_rsc_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {y_rsc_dat[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {y_rsc_triosy_lz}]

