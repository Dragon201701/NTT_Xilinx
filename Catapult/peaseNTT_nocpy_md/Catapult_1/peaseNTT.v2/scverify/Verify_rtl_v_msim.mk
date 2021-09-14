# ----------------------------------------------------------------------------
# RTL Verilog output 'rtl.v' vs Untimed C++
#
#    HLS version: 10.5c/896140 Production Release
#       HLS date: Sun Sep  6 22:45:38 PDT 2020
#  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
#
#   Generated by: jd4691@newnano.poly.edu
# Generated date: Fri Sep 10 02:51:58 EDT 2021
#
# ----------------------------------------------------------------------------
# ===================================================
# DEFAULT GOAL is the help target
.PHONY: all
all: help

# ===================================================
# Directories (at the time this makefile was created)
#   MGC_HOME      /opt/mentorgraphics/Catapult_10.5c/Mgc_home/
#   PROJECT_HOME  /home/jd4691/research/NTT_CPU/peaseNTT_nocpy
#   SOLUTION_DIR  /home/jd4691/research/NTT_CPU/peaseNTT_nocpy/Catapult_1/peaseNTT.v2
#   WORKING_DIR   /home/jd4691/research/NTT_CPU/peaseNTT_nocpy/Catapult_1/peaseNTT.v2/.

# ===================================================
# VARIABLES
# 
MGC_HOME          = /opt/mentorgraphics/Catapult_10.5c/Mgc_home/
export MGC_HOME

WORK_DIR  = $(CURDIR)
WORK2PROJ = ../..
WORK2SOLN = .
PROJ2WORK = ./Catapult_1/peaseNTT.v2
PROJ2SOLN = ./Catapult_1/peaseNTT.v2
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
RTL_NETLIST_FNAME           = /home/jd4691/research/NTT_CPU/peaseNTT_nocpy/Catapult_1/peaseNTT.v2/rtl.v
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
TOP_HDL_ENTITY           := peaseNTT
TOP_DU                   := scverify_top
CXX_TYPE                 := gcc
MSIM_SCRIPT              := ./Catapult_1/peaseNTT.v2/scverify_msim.tcl
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
HDL_LIB_NAMES = work mgc_hls
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
GATE_VLOG_DEP = ./rtl.v/rtl.v.vts
endif
endif
VHDL_SRC +=  $(GATE_VHDL_DEP)
VLOG_SRC += $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_slave_mem.v/ccs_axi4_slave_mem.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.v/mgc_io_sync_v2.v.vts $(MGC_HOME)/pkgs/siflibs/ccs_in_v1.v/ccs_in_v1.v.vts $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_mul_pipe_beh.v/mgc_mul_pipe_beh.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_shift_bl_beh_v5.v/mgc_shift_bl_beh_v5.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.v/mgc_shift_l_beh_v5.v.vts $(MGC_HOME)/pkgs/ccs_xilinx/hdl/BLOCK_2R1W_RBW.v/BLOCK_2R1W_RBW.v.vts $(GATE_VLOG_DEP)
else
VHDL_SRC += 
VLOG_SRC += $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_slave_mem.v/ccs_axi4_slave_mem.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.v/mgc_io_sync_v2.v.vts $(MGC_HOME)/pkgs/siflibs/ccs_in_v1.v/ccs_in_v1.v.vts $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_mul_pipe_beh.v/mgc_mul_pipe_beh.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_shift_bl_beh_v5.v/mgc_shift_bl_beh_v5.v.vts $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.v/mgc_shift_l_beh_v5.v.vts $(MGC_HOME)/pkgs/ccs_xilinx/hdl/BLOCK_2R1W_RBW.v/BLOCK_2R1W_RBW.v.vts ./rtl.v/rtl.v.vts
endif
CXX_SRC  = ../../src/ntt.cpp/ntt.cpp.cxxts ../../src/utils.cpp/utils.cpp.cxxts ./scverify/mc_testbench.cpp/mc_testbench.cpp.cxxts ./scverify/scverify_top.cpp/scverify_top.cpp.cxxts
# Specify RTL synthesis scripts (if any)
RTL_SCRIPT = 

# Specify hold time file name (for verifying synthesized netlists)
HLD_CONSTRAINT_FNAME = top_gate_constraints.cpp

# ===================================================
# GLOBAL OPTIONS
# 
# CXXFLAGS - global C++ options (apply to all C++ compilations) except for include file search paths
CXXFLAGS += -DCCS_SCVERIFY -DSC_INCLUDE_DYNAMIC_PROCESSES -DSC_USE_STD_STRING -DTOP_HDL_ENTITY=$(TOP_HDL_ENTITY) -DCCS_DESIGN_FUNC_peaseNTT -DCCS_DESIGN_TOP_$(TOP_HDL_ENTITY) -DCCS_MISMATCHED_OUTPUTS_ONLY $(F_WRAP_OPT)
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
TCLSH_CMD = /opt/mentorgraphics/Catapult_10.5c/Mgc_home//bin/tclsh8.5

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
$(TARGET)/ccs_axi4_slave_mem.v.vts: $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_slave_mem.v
$(TARGET)/mgc_io_sync_v2.v.vts: $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.v
$(TARGET)/ccs_in_v1.v.vts: $(MGC_HOME)/pkgs/siflibs/ccs_in_v1.v
$(TARGET)/mgc_mul_pipe_beh.v.vts: $(MGC_HOME)/pkgs/hls_pkgs/mgc_comps_src/mgc_mul_pipe_beh.v
$(TARGET)/mgc_shift_bl_beh_v5.v.vts: $(MGC_HOME)/pkgs/siflibs/mgc_shift_bl_beh_v5.v
$(TARGET)/mgc_shift_l_beh_v5.v.vts: $(MGC_HOME)/pkgs/siflibs/mgc_shift_l_beh_v5.v
$(TARGET)/BLOCK_2R1W_RBW.v.vts: $(MGC_HOME)/pkgs/ccs_xilinx/hdl/BLOCK_2R1W_RBW.v
$(TARGET)/rtl.v.vts: ./rtl.v
$(TARGET)/ntt.cpp.cxxts: ../../src/ntt.cpp
$(TARGET)/utils.cpp.cxxts: ../../src/utils.cpp
$(TARGET)/mc_testbench.cpp.cxxts: ./scverify/mc_testbench.cpp
$(TARGET)/scverify_top.cpp.cxxts: ./scverify/scverify_top.cpp
# 
# Specify additional C++ options per C++ source by setting CXX_OPTS
$(TARGET)/utils.cpp.cxxts: CXX_OPTS=
$(TARGET)/scverify_top.cpp.cxxts: CXX_OPTS=
$(TARGET)/mc_testbench.cpp.cxxts: CXX_OPTS=$(F_WRAP_OPT)
$(TARGET)/ntt.cpp.cxxts: CXX_OPTS=
# 
# Specify dependencies
$(TARGET)/ntt.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/utils.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/mc_testbench.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/scverify_top.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts .ccs_env_opts/SCVerify_DEADLOCK_DETECTION.ts
# 
# Specify compilation library for HDL source
$(TARGET)/ccs_axi4_slave_mem.v.vts: HDL_LIB=work
$(TARGET)/mgc_shift_l_beh_v5.v.vts: HDL_LIB=mgc_hls
$(TARGET)/mgc_shift_bl_beh_v5.v.vts: HDL_LIB=mgc_hls
$(TARGET)/ccs_in_v1.v.vts: HDL_LIB=mgc_hls
$(TARGET)/mgc_io_sync_v2.v.vts: HDL_LIB=mgc_hls
$(TARGET)/rtl.v.vts: HDL_LIB=work
$(TARGET)/BLOCK_2R1W_RBW.v.vts: HDL_LIB=mgc_hls
$(TARGET)/mgc_mul_pipe_beh.v.vts: HDL_LIB=mgc_hls
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
$(TARGET)/ccs_axi4_slave_mem.v.vts: VLOG_F_OPTS=
$(TARGET)/mgc_shift_l_beh_v5.v.vts: VLOG_F_OPTS=
$(TARGET)/mgc_shift_bl_beh_v5.v.vts: VLOG_F_OPTS=
$(TARGET)/ccs_in_v1.v.vts: VLOG_F_OPTS=
$(TARGET)/mgc_io_sync_v2.v.vts: VLOG_F_OPTS=
$(TARGET)/rtl.v.vts: VLOG_F_OPTS=
$(TARGET)/BLOCK_2R1W_RBW.v.vts: VLOG_F_OPTS=
$(TARGET)/mgc_mul_pipe_beh.v.vts: VLOG_F_OPTS=
$(TARGET)/ccs_axi4_slave_mem.v.vts: NCVLOG_F_OPTS=
$(TARGET)/mgc_shift_l_beh_v5.v.vts: NCVLOG_F_OPTS=
$(TARGET)/mgc_shift_bl_beh_v5.v.vts: NCVLOG_F_OPTS=
$(TARGET)/ccs_in_v1.v.vts: NCVLOG_F_OPTS=
$(TARGET)/mgc_io_sync_v2.v.vts: NCVLOG_F_OPTS=
$(TARGET)/rtl.v.vts: NCVLOG_F_OPTS=
$(TARGET)/BLOCK_2R1W_RBW.v.vts: NCVLOG_F_OPTS=
$(TARGET)/mgc_mul_pipe_beh.v.vts: NCVLOG_F_OPTS=
$(TARGET)/ccs_axi4_slave_mem.v.vts: VCS_F_OPTS=
$(TARGET)/mgc_shift_l_beh_v5.v.vts: VCS_F_OPTS=
$(TARGET)/mgc_shift_bl_beh_v5.v.vts: VCS_F_OPTS=
$(TARGET)/ccs_in_v1.v.vts: VCS_F_OPTS=
$(TARGET)/mgc_io_sync_v2.v.vts: VCS_F_OPTS=
$(TARGET)/rtl.v.vts: VCS_F_OPTS=
$(TARGET)/BLOCK_2R1W_RBW.v.vts: VCS_F_OPTS=
$(TARGET)/mgc_mul_pipe_beh.v.vts: VCS_F_OPTS=
# 
# Specify top design unit for HDL source
$(TARGET)/ccs_axi4_slave_mem.v.vts: DUT_E=ccs_axi4_slave_mem
$(TARGET)/rtl.v.vts: DUT_E=peaseNTT

# Specify top design unit
$(TARGET)/rtl.v.vts: VLOG_TOP=1

ifneq "$(RTLTOOL)" ""
# ===================================================
# Include makefile for RTL synthesis
include $(MGC_HOME)/shared/include/mkfiles/ccs_$(RTLTOOL).mk
else
# ===================================================
# Include makefile for simulator
include $(MGC_HOME)/shared/include/mkfiles/ccs_questasim.mk
endif

