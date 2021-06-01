vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm

vlog -work xil_defaultlib -64 -sv \
"D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_7vx.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_8k.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_16k.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_cpl.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_rep.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_rep_8k.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_bram_7vx_req.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_init_ctrl_7vx.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_pipe_lane.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_pipe_misc.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_pipe_pipeline.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_top.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_force_adapt.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_drp.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_eq.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_rate.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_reset.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_sync.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_user.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pipe_wrapper.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_qpll_drp.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_qpll_reset.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_qpll_wrapper.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_rxeq_scan.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gt_wrapper.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gt_top.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gt_common.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_gtx_cpllpd_ovrd.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_tlp_tph_tbl_7vx.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/source/pcie3_7x_0_pcie_3_0_7vx.v" \
"../../../../inplace_DIT_precomp.srcs/sources_1/ip/pcie3_7x_0/sim/pcie3_7x_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

