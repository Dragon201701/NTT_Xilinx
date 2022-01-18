# written for flow package Vivado 
set sdc_version 1.7 

create_clock -name clk -period 10.0 -waveform { 0.0 5.0 } [get_ports {clk}]
set_clock_uncertainty 0.0 [get_clocks {clk}]

create_clock -name virtual_io_clk -period 10.0
## IO TIMING CONSTRAINTS
set_input_delay -clock [get_clocks {clk}] 0.0 [get_ports {rst}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_m_wstate[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_m_wCaughtUp}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_RREADY}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_RVALID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_RUSER}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_RLAST}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_RRESP[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_RDATA[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_RID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_ARREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARREGION[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARQOS[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARPROT[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARCACHE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARLOCK}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARBURST[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARSIZE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARLEN[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARADDR[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_ARID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_BREADY}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_BVALID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_BUSER}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_BRESP[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_BID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_WREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_WVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_WUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_WLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_WSTRB[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_WDATA[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {a_rsc_AWREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWREGION[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWQOS[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWPROT[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWCACHE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWLOCK}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWBURST[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWSIZE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWLEN[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWADDR[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {a_rsc_triosy_lz}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_m_wstate[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_m_wCaughtUp}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_RREADY}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_RVALID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_RUSER}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_RLAST}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_RRESP[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_RDATA[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_RID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_ARREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARREGION[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARQOS[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARPROT[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARCACHE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARLOCK}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARBURST[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARSIZE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARLEN[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARADDR[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_ARID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_BREADY}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_BVALID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_BUSER}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_BRESP[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_BID}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_WREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_WVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_WUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_WLAST}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_WSTRB[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_WDATA[*]}]
set_input_delay -clock [get_clocks {clk}] 0.634615 [get_ports {b_rsc_AWREADY}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWVALID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWUSER}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWREGION[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWQOS[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWPROT[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWCACHE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWLOCK}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWBURST[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWSIZE[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWLEN[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWADDR[*]}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_AWID}]
set_output_delay -clock [get_clocks {clk}] 0.0 [get_ports {b_rsc_triosy_lz}]

