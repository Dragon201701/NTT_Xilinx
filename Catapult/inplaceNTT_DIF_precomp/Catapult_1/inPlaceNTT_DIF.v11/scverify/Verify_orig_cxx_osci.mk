# ----------------------------------------------------------------------------
# Original Design + Testbench
#
#    HLS version: 10.5c/896140 Production Release
#       HLS date: Sun Sep  6 22:45:38 PDT 2020
#  Flow Packages: HDL_Tcl 8.0a, SCVerify 10.4.1
#
#   Generated by: yl7897@newnano.poly.edu
# Generated date: Mon Aug 23 22:36:48 EDT 2021
#
# ----------------------------------------------------------------------------
# ===================================================
# DEFAULT GOAL is the help target
.PHONY: all
all: help

# ===================================================
# Directories (at the time this makefile was created)
#   MGC_HOME      /opt/mentorgraphics/Catapult_10.5c/Mgc_home
#   PROJECT_HOME  /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIF_precomp
#   SOLUTION_DIR  /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIF_precomp/Catapult_1/inPlaceNTT_DIF.v11
#   WORKING_DIR   /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIF_precomp/Catapult_1/inPlaceNTT_DIF.v11/.

# ===================================================
# VARIABLES
# 
MGC_HOME          = /opt/mentorgraphics/Catapult_10.5c/Mgc_home
export MGC_HOME

WORK_DIR  = $(CURDIR)
WORK2PROJ = ../..
WORK2SOLN = .
PROJ2WORK = ./Catapult_1/inPlaceNTT_DIF.v11
PROJ2SOLN = ./Catapult_1/inPlaceNTT_DIF.v11
export WORK_DIR
export WORK2PROJ
export WORK2SOLN
export PROJ2WORK
export PROJ2SOLN

# Variables that can be overridden from the make command line
ifeq "$(INCL_DIRS)" ""
INCL_DIRS                   =  .
endif
export INCL_DIRS
ifeq "$(STAGE)" ""
STAGE                       = orig
endif
export STAGE
ifeq "$(NETLIST_LEAF)" ""
NETLIST_LEAF                = orig
endif
export NETLIST_LEAF
ifeq "$(SIMTOOL)" ""
SIMTOOL                     = osci
endif
export SIMTOOL
ifeq "$(NETLIST)" ""
NETLIST                     = cxx
endif
export NETLIST
ifeq "$(RTL_NETLIST_FNAME)" ""
RTL_NETLIST_FNAME           = /home/yl7897/NTT_Xilinx/Catapult/inplaceNTT_DIF_precomp/Catapult_1/inPlaceNTT_DIF.v11/orig
endif
export RTL_NETLIST_FNAME
ifeq "$(INVOKE_ARGS)" ""
INVOKE_ARGS                 = 
endif
export INVOKE_ARGS
export SCVLIBS
LINK_SYSTEMC             := true
TOP_HDL_ENTITY           := dummy
TOP_DU                   := scverify_top
TARGET                   := scverify/$(NETLIST_LEAF)_$(NETLIST)_$(SIMTOOL)
LINK_SYSTEMC             := true
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
SYN_FLOW          := 
# ===================================================
# SOURCES
# 
# Specify list of Questa SIM libraries to create
HDL_LIB_NAMES = work
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
GATE_VLOG_DEP = 
endif
endif
VHDL_SRC +=  $(GATE_VHDL_DEP)
VLOG_SRC +=  $(GATE_VLOG_DEP)
else
VHDL_SRC += 
VLOG_SRC += 
endif
CXX_SRC  = ../../src/ntt_tb.cpp/ntt_tb.cpp.cxxts ../../src/ntt.cpp/ntt.cpp.cxxts
# Specify RTL synthesis scripts (if any)
RTL_SCRIPT = 

# Specify hold time file name (for verifying synthesized netlists)
HLD_CONSTRAINT_FNAME = top_gate_constraints.cpp

# ===================================================
# GLOBAL OPTIONS
# 
# CXXFLAGS - global C++ options (apply to all C++ compilations) except for include file search paths
CXXFLAGS += -DSC_INCLUDE_DYNAMIC_PROCESSES -DSC_USE_STD_STRING -DCCS_MISMATCHED_OUTPUTS_ONLY
# 
# If the make command line includes a definition of the special variable MC_DEFAULT_TRANSACTOR_LOG
# then define that value for all compilations as well
ifneq "$(MC_DEFAULT_TRANSACTOR_LOG)" ""
CXXFLAGS += -DMC_DEFAULT_TRANSACTOR_LOG=$(MC_DEFAULT_TRANSACTOR_LOG)
endif
# 
# CXX_INCLUDES - include file search paths
CXX_INCLUDES = . ../..
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
$(TARGET)/ntt_tb.cpp.cxxts: ../../src/ntt_tb.cpp
$(TARGET)/ntt.cpp.cxxts: ../../src/ntt.cpp
# 
# Specify additional C++ options per C++ source by setting CXX_OPTS
$(TARGET)/ntt_tb.cpp.cxxts: CXX_OPTS=
$(TARGET)/ntt.cpp.cxxts: CXX_OPTS=
# 
# Specify dependencies
$(TARGET)/ntt_tb.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
$(TARGET)/ntt.cpp.cxxts: .ccs_env_opts/SCVerify_USE_CCS_BLOCK.ts
# 
# Specify compilation library for HDL source
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
# 
# Specify top design unit for HDL source

# Specify top design unit

ifneq "$(RTLTOOL)" ""
# ===================================================
# Include makefile for RTL synthesis
include $(MGC_HOME)/shared/include/mkfiles/ccs_$(RTLTOOL).mk
else
# ===================================================
# Include makefile for simulator
include $(MGC_HOME)/shared/include/mkfiles/ccs_$(SIMTOOL).mk
endif

