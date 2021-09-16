# ----------------------------------------------------------------------------
# RTL Verilog output 'rtl.v' vs Untimed C++
#
#    HLS version: 10.5c/896140 Production Release
#       HLS date: Sun Sep  6 22:45:38 PDT 2020
#  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
#
#   Generated by: yl7897@newnano.poly.edu
# Generated date: Thu Sep 16 13:31:11 EDT 2021
#
# ----------------------------------------------------------------------------
# ===================================================
# DEFAULT GOAL is the help target
.PHONY: all
all: help

# ===================================================
# Directories (at the time this makefile was created)
#   MGC_HOME      /opt/mentorgraphics/Catapult_10.5c/Mgc_home
#   PROJECT_HOME  /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIT_precomp_md
#   SOLUTION_DIR  /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIT_precomp_md/Catapult_2/inPlaceNTT_DIT_precomp.v7
#   WORKING_DIR   /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIT_precomp_md/Catapult_2/inPlaceNTT_DIT_precomp.v7/.

# ===================================================
# VARIABLES
# 
MGC_HOME          = /opt/mentorgraphics/Catapult_10.5c/Mgc_home
export MGC_HOME

WORK_DIR  = $(CURDIR)
WORK2PROJ = ../..
WORK2SOLN = .
PROJ2WORK = ./Catapult_2/inPlaceNTT_DIT_precomp.v7
PROJ2SOLN = ./Catapult_2/inPlaceNTT_DIT_precomp.v7
export WORK_DIR
export WORK2PROJ
export WORK2SOLN
export PROJ2WORK
export PROJ2SOLN

# Variables that can be overridden from the make command line
ifeq "$(INCL_DIRS)" ""
INCL_DIRS                   = ./scverify . ../..
endif
export INCL_DIRS
ifeq "$(STAGE)" ""
STAGE                       = rtl
endif
export STAGE
ifeq "$(NETLIST_LEAF)" ""
NETLIST_LEAF                = rtl
endif
export NETLIST_LEAF
ifeq "$(SIMTOOL)" ""
SIMTOOL                     = msim
endif
export SIMTOOL
ifeq "$(NETLIST)" ""
NETLIST                     = v
endif
export NETLIST
ifeq "$(RTL_NETLIST_FNAME)" ""
RTL_NETLIST_FNAME           = /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIT_precomp_md/Catapult_2/inPlaceNTT_DIT_precomp.v7/rtl.v
endif
export RTL_NETLIST_FNAME
ifeq "$(INVOKE_ARGS)" ""
INVOKE_ARGS                 = 
endif
export INVOKE_ARGS
ifeq "$(FAMILY)" ""
FAMILY                      = virtex-7
endif
export FAMILY
export SCVLIBS
export MODELSIM
TOP_HDL_ENTITY           := inPlaceNTT_DIT_precomp
TOP_DU                   := scverify_top
CXX_TYPE                 := gcc
MSIM_SCRIPT              := ./Catapult_2/inPlaceNTT_DIT_precomp.v7/scverify_msim.tcl
TARGET                   := scverify/$(NETLIST_LEAF)_$(NETLIST)_$(SIMTOOL)
export TOP_HDL_ENTITY
export TARGET

ifeq ($(RECUR),)
ifeq ($(STAGE),mapped)
ifeq ($(RTLTOOL),)
   $(error This makefile requires specifying the RTLTOOL variable on the make command line)
endif
endif
endif
# ===================================================
# Include environment variables set by flow options
include ./ccs_env.mk

# ===================================================
# Include makefile for default commands and variables
include $(MGC_HOME)/shared/include/mkfiles/ccs_default_cmds.mk

SYNTHESIS_FLOWPKG := Vivado
SYN_FLOW          := Vivado
# ===================================================
# SOURCES
# 
# Specify list of Questa SIM libraries to create
HDL_LIB_NAMES = mgc_hls work
# ===================================================
# Simulation libraries required by loaded Catapult libraries or gate simulation
SIMLIBS_V   += 
SIMLIBS_VHD += 
# 
# Specify list of source files - MUST be ordered properly
ifeq ($(STAGE),gate)
ifeq ($(RTLTOOL),)
# Unless overridden on make command line, GATE_*_DEP is the last item in the netlist dependency list
ifeq ($(GATE_VHDL_DEP),)
GATE_VHDL_DEP = 
endif
ifeq ($(GATE_VLOG_DEP),)
GATE_VLOG_DEP = ./rtl.v/rtl.v_9.vts
endif
endif
VHDL_SRC +=  $(GATE_VHDL_DEP)
VLOG_SRC += $(MGC_HOME)/pkgs/siflibs/ccs_sync_in_wait_v1.v/ccs_sync_in_wait_v1.v.vts $(MGC_HOME)/pkgs/siflibs/ccs_sync_out_wait_v1.v/ccs_sync_out_wait_v1.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.v/mgc_io_sync_v2.v.vts $(MGC_HOME)/pkgs/siflibs/ccs_in_v1.v/ccs_in_v1.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_out_dreg_v2.v/mgc_out_dreg_v2.v.vts ../td_ccore_solutions/modulo_sub_f83f1ef2ff5a4101c59f332e5a2a07d06350_0/rtl.v/rtl.v.vts ../td_ccore_solutions/modulo_add_1c7cb5effec07f258b1f9fafcfd3564d6028_0/rtl.v/rtl.v_6.vts ../td_ccore_solutions/mult_211a0e259bca55d0a7d87e37cf4e500170bb_0/rtl.v/rtl.v_7.vts $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.v/mgc_shift_l_beh_v5.v.vts $(GATE_VLOG_DEP)
else
VHDL_SRC += 
VLOG_SRC += $(MGC_HOME)/pkgs/siflibs/ccs_sync_in_wait_v1.v/ccs_sync_in_wait_v1.v.vts $(MGC_HOME)/pkgs/siflibs/ccs_sync_out_wait_v1.v/ccs_sync_out_wait_v1.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.v/mgc_io_sync_v2.v.vts $(MGC_HOME)/pkgs/siflibs/ccs_in_v1.v/ccs_in_v1.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_out_dreg_v2.v/mgc_out_dreg_v2.v.vts ../td_ccore_solutions/modulo_sub_f83f1ef2ff5a4101c59f332e5a2a07d06350_0/rtl.v/rtl.v.vts ../td_ccore_solutions/modulo_add_1c7cb5effec07f258b1f9fafcfd3564d6028_0/rtl.v/rtl.v_6.vts ../td_ccore_solutions/mult_211a0e259bca55d0a7d87e37cf4e500170bb_0/rtl.v/rtl.v_7.vts $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.v/mgc_shift_l_beh_v5.v.vts ./rtl.v/rtl.v_9.vts
endif
CXX_SRC  = ../../src/main.cpp/main.cpp.cxxts ../../src/ntt.cpp/ntt.cpp.cxxts ../../src/utils.cpp/utils.cpp.cxxts ./scverify/mc_testbench.cpp/mc_testbench.cpp.cxxts ./scverify/scverify_top.cpp/scverify_top.cpp.cxxts
# Specify RTL synthesis scripts (if any)
RTL_SCRIPT = 

# Specify hold time file name (for verifying synthesized netlists)
HLD_CONSTRAINT_FNAME = top_gate_constraints.cpp

# ===================================================
# GLOBAL OPTIONS
# 
# CXXFLAGS - global C++ options (apply to all C++ compilations) except for include file search paths
CXXFLAGS += -DCCS_SCVERIFY -DSC_INCLUDE_DYNAMIC_PROCESSES -DSC_USE_STD_STRING -DTOP_HDL_ENTITY=$(TOP_HDL_ENTITY) -DCCS_DESIGN_FUNC_inPlaceNTT_DIT_precomp -DCCS_DESIGN_TOP_$(TOP_HDL_ENTITY) -DCCS_MISMATCHED_OUTPUTS_ONLY $(F_WRAP_OPT)
# 
# If the make command line includes a definition of the special variable MC_DEFAULT_TRANSACTOR_LOG
# then define that value for all compilations as well
ifneq "$(MC_DEFAULT_TRANSACTOR_LOG)" ""
CXXFLAGS += -DMC_DEFAULT_TRANSACTOR_LOG=$(MC_DEFAULT_TRANSACTOR_LOG)
endif
# 
# CXX_INCLUDES - include file search paths
CXX_INCLUDES = ./scverify . ../..
# 
# TCL shell
TCLSH_CMD = /opt/mentorgraphics/Catapult_10.5c/Mgc_home/bin/tclsh8.5

# Pass along SCVerify_DEADLOCK_DETECTION option
ifneq "$(SCVerify_DEADLOCK_DETECTION)" "false"
CXXFLAGS += -DDEADLOCK_DETECTION
endif
# ===================================================
# PER SOURCE FILE SPECIALIZATIONS
# 
# Specify source file paths
ifeq ($(STAGE),gate)
ifneq ($(GATE_VHDL_DEP),)
$(TARGET)/$(notdir $(GATE_VHDL_DEP)): $(dir $(GATE_VHDL_DEP))
endif
ifneq ($(GATE_VLOG_DEP),)
$(TARGET)/$(notdir $(GATE_VLOG_DEP)): $(dir $(GATE_VLOG_DEP))
endif
endif
$(TARGET)/ccs_sync_in_wait_v1.v.vts: $(MGC_HOME)/pkgs/siflibs/ccs_sync_in_wait_v1.v
$(TARGET)/ccs_sync_out_wait_v1.v.vts: $(MGC_HOME)/pkgs/siflibs/ccs_sync_out_wait_v1.v
$(TARGET)/mgc_io_sync_v2.v.vts: $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.v
$(TARGET)/ccs_in_v1.v.vts: $(MGC_HOME)/pkgs/siflibs/ccs_in_v1.v
$(TARGET)/mgc_out_dreg_v2.v.vts: $(MGC_HOME)/pkgs/siflibs/mgc_out_dreg_v2.v
$(TARGET)/rtl.v.vts: ../td_ccore_solutions/modulo_sub_f83f1ef2ff5a4101c59f332e5a2a07d06350_0/rtl.v
$(TARGET)/rtl.v_6.vts: ../td_ccore_solutions/modulo_add_1c7cb5effec07f258b1f9fafcfd3564d6028_0/rtl.v
$(TARGET)/rtl.v_7.vts: ../td_ccore_solutions/mult_211a0e259bca55d0a7d87e37cf4e500170bb_0/rtl.v
$(TARGET)/mgc_shift_l_beh_v5.v.vts: $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.v
$(TARGET)/rtl.v_9.vts: ./rtl.v
$(TARGET)/main.cpp.cxxts: ../../src/main.cpp
$(TARGET)/ntt.cpp.cxxts: ../../src/ntt.cpp
$(TARGET)/utils.cpp.cxxts: ../../src/utils.cpp
$(TARGET)/mc_testbench.cpp.cxxts: ./scverify/mc_testbench.cpp
$(TARGET)/scverify_top.cpp.cxxts: ./scverify/scverify_top.cpp
# 
# Specify additional C++ options per C++ source by setting CXX_OPTS
$(TARGET)/utils.cpp.cxxts: CXX_OPTS=
$(TARGET)/main.cpp.cxxts: CXX_OPTS=
$(TARGET)/scverify_top.cpp.cxxts: CXX_OPTS=
$(TARGET)/mc_testbench.cpp.cxxts: CXX_OPTS=$(F_WRAP_OPT)
$(TARGET)/ntt.cpp.cxxts: CXX_OPTS=
# 
# Specify dependencies
$(TARGET)/main.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/ntt.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/utils.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/mc_testbench.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/scverify_top.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts .ccs_env_opts/SCVerify_DEADLOCK_DETECTION.ts
# 
# Specify compilation library for HDL source
$(TARGET)/rtl.v_6.vts: HDL_LIB=work
$(TARGET)/mgc_out_dreg_v2.v.vts: HDL_LIB=mgc_hls
$(TARGET)/ccs_sync_out_wait_v1.v.vts: HDL_LIB=mgc_hls
$(TARGET)/mgc_shift_l_beh_v5.v.vts: HDL_LIB=mgc_hls
$(TARGET)/rtl.v_7.vts: HDL_LIB=work
$(TARGET)/ccs_in_v1.v.vts: HDL_LIB=mgc_hls
$(TARGET)/mgc_io_sync_v2.v.vts: HDL_LIB=mgc_hls
$(TARGET)/ccs_sync_in_wait_v1.v.vts: HDL_LIB=mgc_hls
$(TARGET)/rtl.v_9.vts: HDL_LIB=work
$(TARGET)/rtl.v.vts: HDL_LIB=work
ifeq ($(STAGE),gate)
ifneq ($(GATE_VHDL_DEP),)
$(TARGET)/$(notdir $(GATE_VHDL_DEP)): HDL_LIB=work
endif
ifneq ($(GATE_VLOG_DEP),)
$(TARGET)/$(notdir $(GATE_VLOG_DEP)): HDL_LIB=work
endif
endif
# 
# Specify additional HDL source compilation options if any
$(TARGET)/rtl.v_6.vts: VLOG_F_OPTS=
$(TARGET)/mgc_out_dreg_v2.v.vts: VLOG_F_OPTS=
$(TARGET)/ccs_sync_out_wait_v1.v.vts: VLOG_F_OPTS=
$(TARGET)/mgc_shift_l_beh_v5.v.vts: VLOG_F_OPTS=
$(TARGET)/rtl.v_7.vts: VLOG_F_OPTS=
$(TARGET)/ccs_in_v1.v.vts: VLOG_F_OPTS=
$(TARGET)/mgc_io_sync_v2.v.vts: VLOG_F_OPTS=
$(TARGET)/ccs_sync_in_wait_v1.v.vts: VLOG_F_OPTS=
$(TARGET)/rtl.v_9.vts: VLOG_F_OPTS=
$(TARGET)/rtl.v.vts: VLOG_F_OPTS=
$(TARGET)/rtl.v_6.vts: NCVLOG_F_OPTS=
$(TARGET)/mgc_out_dreg_v2.v.vts: NCVLOG_F_OPTS=
$(TARGET)/ccs_sync_out_wait_v1.v.vts: NCVLOG_F_OPTS=
$(TARGET)/mgc_shift_l_beh_v5.v.vts: NCVLOG_F_OPTS=
$(TARGET)/rtl.v_7.vts: NCVLOG_F_OPTS=
$(TARGET)/ccs_in_v1.v.vts: NCVLOG_F_OPTS=
$(TARGET)/mgc_io_sync_v2.v.vts: NCVLOG_F_OPTS=
$(TARGET)/ccs_sync_in_wait_v1.v.vts: NCVLOG_F_OPTS=
$(TARGET)/rtl.v_9.vts: NCVLOG_F_OPTS=
$(TARGET)/rtl.v.vts: NCVLOG_F_OPTS=
$(TARGET)/rtl.v_6.vts: VCS_F_OPTS=
$(TARGET)/mgc_out_dreg_v2.v.vts: VCS_F_OPTS=
$(TARGET)/ccs_sync_out_wait_v1.v.vts: VCS_F_OPTS=
$(TARGET)/mgc_shift_l_beh_v5.v.vts: VCS_F_OPTS=
$(TARGET)/rtl.v_7.vts: VCS_F_OPTS=
$(TARGET)/ccs_in_v1.v.vts: VCS_F_OPTS=
$(TARGET)/mgc_io_sync_v2.v.vts: VCS_F_OPTS=
$(TARGET)/ccs_sync_in_wait_v1.v.vts: VCS_F_OPTS=
$(TARGET)/rtl.v_9.vts: VCS_F_OPTS=
$(TARGET)/rtl.v.vts: VCS_F_OPTS=
# 
# Specify top design unit for HDL source
$(TARGET)/rtl.v_6.vts: DUT_E=modulo_add
$(TARGET)/rtl.v_7.vts: DUT_E=mult
$(TARGET)/rtl.v_9.vts: DUT_E=inPlaceNTT_DIT_precomp
$(TARGET)/rtl.v.vts: DUT_E=modulo_sub

# Specify top design unit
$(TARGET)/rtl.v_9.vts: VLOG_TOP=1

ifneq "$(RTLTOOL)" ""
# ===================================================
# Include makefile for RTL synthesis
include $(MGC_HOME)/shared/include/mkfiles/ccs_$(RTLTOOL).mk
else
# ===================================================
# Include makefile for simulator
include $(MGC_HOME)/shared/include/mkfiles/ccs_questasim.mk
endif

