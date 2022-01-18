# ----------------------------------------------------------------------------
# RTL VHDL output 'rtl.vhdl' vs Untimed C++
#
#    HLS version: 10.5c/896140 Production Release
#       HLS date: Sun Sep  6 22:45:38 PDT 2020
#  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
#
#   Generated by: yl7897@newnano.poly.edu
# Generated date: Sun Jan 02 17:49:26 EST 2022
#
# ----------------------------------------------------------------------------
# ===================================================
# DEFAULT GOAL is the help target
.PHONY: all
all: help

# ===================================================
# Directories (at the time this makefile was created)
#   MGC_HOME      /opt/mentorgraphics/Catapult_10.5c/Mgc_home
#   PROJECT_HOME  /home/yl7897/NTT_Xilinx/Catapult/axi_test
#   SOLUTION_DIR  /home/yl7897/NTT_Xilinx/Catapult/axi_test/Catapult_1/axi_add.v3
#   WORKING_DIR   /home/yl7897/NTT_Xilinx/Catapult/axi_test/Catapult_1/axi_add.v3/.

# ===================================================
# VARIABLES
# 
MGC_HOME          = /opt/mentorgraphics/Catapult_10.5c/Mgc_home
export MGC_HOME

WORK_DIR  = $(CURDIR)
WORK2PROJ = ../..
WORK2SOLN = .
PROJ2WORK = ./Catapult_1/axi_add.v3
PROJ2SOLN = ./Catapult_1/axi_add.v3
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
NETLIST                     = vhdl
endif
export NETLIST
ifeq "$(RTL_NETLIST_FNAME)" ""
RTL_NETLIST_FNAME           = /home/yl7897/NTT_Xilinx/Catapult/axi_test/Catapult_1/axi_add.v3/rtl.vhdl
endif
export RTL_NETLIST_FNAME
ifeq "$(INVOKE_ARGS)" ""
INVOKE_ARGS                 = 
endif
export INVOKE_ARGS
ifeq "$(FAMILY)" ""
FAMILY                      = kintex-u
endif
export FAMILY
export SCVLIBS
export MODELSIM
TOP_HDL_ENTITY           := axi_add
TOP_DU                   := scverify_top
CXX_TYPE                 := gcc
MSIM_SCRIPT              := ./Catapult_1/axi_add.v3/scverify_msim.tcl
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
HDL_LIB_NAMES = mgc_hls amba_lib work
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
GATE_VHDL_DEP = ./rtl.vhdl/rtl.vhdl.vhdlts
endif
ifeq ($(GATE_VLOG_DEP),)
GATE_VLOG_DEP = 
endif
endif
VHDL_SRC += $(MGC_HOME)/pkgs/siflibs/ccs_sync_in_wait_v1.vhd/ccs_sync_in_wait_v1.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/amba_comps.vhd/amba_comps.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_read_core.vhd/ccs_axi4_master_read_core.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_write_core.vhd/ccs_axi4_master_write_core.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_core.vhd/ccs_axi4_master_core.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master.vhd/ccs_axi4_master.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/ccs_sync_out_wait_v1.vhd/ccs_sync_out_wait_v1.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.vhd/mgc_io_sync_v2.vhd.vhdlts $(GATE_VHDL_DEP)
VLOG_SRC +=  $(GATE_VLOG_DEP)
else
VHDL_SRC += $(MGC_HOME)/pkgs/siflibs/ccs_sync_in_wait_v1.vhd/ccs_sync_in_wait_v1.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/amba_comps.vhd/amba_comps.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_read_core.vhd/ccs_axi4_master_read_core.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_write_core.vhd/ccs_axi4_master_write_core.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_core.vhd/ccs_axi4_master_core.vhd.vhdlts $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master.vhd/ccs_axi4_master.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/ccs_sync_out_wait_v1.vhd/ccs_sync_out_wait_v1.vhd.vhdlts $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.vhd/mgc_io_sync_v2.vhd.vhdlts ./rtl.vhdl/rtl.vhdl.vhdlts
VLOG_SRC += 
endif
CXX_SRC  = ../../src/axI_test_tb.cpp/axI_test_tb.cpp.cxxts ../../src/axi_test.cpp/axi_test.cpp.cxxts ./scverify/mc_testbench.cpp/mc_testbench.cpp.cxxts ./scverify/scverify_top.cpp/scverify_top.cpp.cxxts
# Specify RTL synthesis scripts (if any)
RTL_SCRIPT = 

# Specify hold time file name (for verifying synthesized netlists)
HLD_CONSTRAINT_FNAME = top_gate_constraints.cpp

# ===================================================
# GLOBAL OPTIONS
# 
# CXXFLAGS - global C++ options (apply to all C++ compilations) except for include file search paths
CXXFLAGS += -DCCS_SCVERIFY -DSC_INCLUDE_DYNAMIC_PROCESSES -DSC_USE_STD_STRING -DTOP_HDL_ENTITY=$(TOP_HDL_ENTITY) -DCCS_DESIGN_FUNC_axi_add -DCCS_DESIGN_TOP_$(TOP_HDL_ENTITY) -DCCS_MISMATCHED_OUTPUTS_ONLY $(F_WRAP_OPT)
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
$(TARGET)/ccs_sync_in_wait_v1.vhd.vhdlts: $(MGC_HOME)/pkgs/siflibs/ccs_sync_in_wait_v1.vhd
$(TARGET)/amba_comps.vhd.vhdlts: $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/amba_comps.vhd
$(TARGET)/ccs_axi4_master_read_core.vhd.vhdlts: $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_read_core.vhd
$(TARGET)/ccs_axi4_master_write_core.vhd.vhdlts: $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_write_core.vhd
$(TARGET)/ccs_axi4_master_core.vhd.vhdlts: $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master_core.vhd
$(TARGET)/ccs_axi4_master.vhd.vhdlts: $(MGC_HOME)/pkgs/ccs_libs/interfaces/amba/ccs_axi4_master.vhd
$(TARGET)/ccs_sync_out_wait_v1.vhd.vhdlts: $(MGC_HOME)/pkgs/siflibs/ccs_sync_out_wait_v1.vhd
$(TARGET)/mgc_io_sync_v2.vhd.vhdlts: $(MGC_HOME)/pkgs/siflibs/mgc_io_sync_v2.vhd
$(TARGET)/rtl.vhdl.vhdlts: ./rtl.vhdl
ifeq ($(STAGE),gate)
ifneq ($(GATE_VHDL_DEP),)
$(TARGET)/$(notdir $(GATE_VHDL_DEP)): $(dir $(GATE_VHDL_DEP))
endif
ifneq ($(GATE_VLOG_DEP),)
$(TARGET)/$(notdir $(GATE_VLOG_DEP)): $(dir $(GATE_VLOG_DEP))
endif
endif
$(TARGET)/axI_test_tb.cpp.cxxts: ../../src/axI_test_tb.cpp
$(TARGET)/axi_test.cpp.cxxts: ../../src/axi_test.cpp
$(TARGET)/mc_testbench.cpp.cxxts: ./scverify/mc_testbench.cpp
$(TARGET)/scverify_top.cpp.cxxts: ./scverify/scverify_top.cpp
# 
# Specify additional C++ options per C++ source by setting CXX_OPTS
$(TARGET)/axi_test.cpp.cxxts: CXX_OPTS=
$(TARGET)/scverify_top.cpp.cxxts: CXX_OPTS=
$(TARGET)/mc_testbench.cpp.cxxts: CXX_OPTS=$(F_WRAP_OPT)
$(TARGET)/axI_test_tb.cpp.cxxts: CXX_OPTS=
# 
# Specify dependencies
$(TARGET)/axI_test_tb.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/axi_test.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/mc_testbench.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/scverify_top.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts .ccs_env_opts/SCVerify_DEADLOCK_DETECTION.ts
# 
# Specify compilation library for HDL source
$(TARGET)/ccs_sync_out_wait_v1.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/ccs_axi4_master_read_core.vhd.vhdlts: HDL_LIB=amba_lib
$(TARGET)/amba_comps.vhd.vhdlts: HDL_LIB=amba_lib
$(TARGET)/mgc_io_sync_v2.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/ccs_sync_in_wait_v1.vhd.vhdlts: HDL_LIB=mgc_hls
$(TARGET)/rtl.vhdl.vhdlts: HDL_LIB=work
$(TARGET)/ccs_axi4_master.vhd.vhdlts: HDL_LIB=amba_lib
$(TARGET)/ccs_axi4_master_core.vhd.vhdlts: HDL_LIB=amba_lib
$(TARGET)/ccs_axi4_master_write_core.vhd.vhdlts: HDL_LIB=amba_lib
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
$(TARGET)/ccs_sync_out_wait_v1.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/ccs_axi4_master_read_core.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/amba_comps.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/mgc_io_sync_v2.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/ccs_sync_in_wait_v1.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/rtl.vhdl.vhdlts: VHDL_F_OPTS=
$(TARGET)/ccs_axi4_master.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/ccs_axi4_master_core.vhd.vhdlts: VHDL_F_OPTS=
$(TARGET)/ccs_axi4_master_write_core.vhd.vhdlts: VHDL_F_OPTS=
# 
# Specify top design unit for HDL source
$(TARGET)/rtl.vhdl.vhdlts: DUT_E=axi_add

# Specify top design unit
$(TARGET)/rtl.vhdl.vhdlts: VHDL_TOP=1

ifneq "$(RTLTOOL)" ""
# ===================================================
# Include makefile for RTL synthesis
include $(MGC_HOME)/shared/include/mkfiles/ccs_$(RTLTOOL).mk
else
# ===================================================
# Include makefile for simulator
include $(MGC_HOME)/shared/include/mkfiles/ccs_questasim.mk
endif

