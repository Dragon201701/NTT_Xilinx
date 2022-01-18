
--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_sync_in_wait_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_sync_in_wait_pkg_v1 IS

COMPONENT ccs_sync_in_wait_v1 
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    rdy : OUT   std_logic;
    vld : IN    std_logic;
    irdy : IN    std_logic;
    ivld : OUT   std_logic
  );
END COMPONENT;

END ccs_sync_in_wait_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_sync_in_wait_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    rdy : OUT   std_logic;
    vld : IN    std_logic;
    irdy : IN    std_logic;
    ivld : OUT   std_logic
  );
END ccs_sync_in_wait_v1;

ARCHITECTURE beh OF ccs_sync_in_wait_v1 IS
BEGIN
   rdy <= irdy;
   ivld <= vld;
END beh; 

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_sync_out_wait_v1.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

PACKAGE ccs_sync_out_wait_pkg_v1 IS

COMPONENT ccs_sync_out_wait_v1
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    ivld : IN    std_logic;
    irdy : OUT   std_logic;
    vld : OUT   std_logic;
    rdy : IN    std_logic
  );
END COMPONENT;

END ccs_sync_out_wait_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_sync_out_wait_v1 IS
  GENERIC (
    rscid    : INTEGER
  );
  PORT (
    ivld : IN    std_logic;
    irdy : OUT   std_logic;
    vld : OUT   std_logic;
    rdy : IN    std_logic
  );
END ccs_sync_out_wait_v1;

ARCHITECTURE beh OF ccs_sync_out_wait_v1 IS
BEGIN
   irdy <= rdy;
   vld <= ivld;
END beh; 

--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.vhd 
--------------------------------------------------------------------------------
-- Catapult Synthesis - Sample I/O Port Library
--
-- Copyright (c) 2003-2017 Mentor Graphics Corp.
--       All Rights Reserved
--
-- This document may be used and distributed without restriction provided that
-- this copyright statement is not removed from the file and that any derivative
-- work contains this copyright notice.
--
-- The design information contained in this file is intended to be an example
-- of the functionality which the end user may study in preparation for creating
-- their own custom interfaces. This design does not necessarily present a 
-- complete implementation of the named protocol or standard.
--
--------------------------------------------------------------------------------

LIBRARY ieee;

USE ieee.std_logic_1164.all;
PACKAGE mgc_io_sync_pkg_v2 IS

COMPONENT mgc_io_sync_v2
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END COMPONENT;

END mgc_io_sync_pkg_v2;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY mgc_io_sync_v2 IS
  GENERIC (
    valid    : INTEGER RANGE 0 TO 1
  );
  PORT (
    ld       : IN    std_logic;
    lz       : OUT   std_logic
  );
END mgc_io_sync_v2;

ARCHITECTURE beh OF mgc_io_sync_v2 IS
BEGIN

  lz <= ld;

END beh;


--------> ./rtl.vhdl 
-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.5c/896140 Production Release
--  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
-- 
--  Generated by:   yl7897@newnano.poly.edu
--  Generated date: Sun Jan  2 21:48:37 2022
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen IS
  PORT(
    q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    adr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    adr_d : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    we_d : IN STD_LOGIC;
    rw_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rw_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen;

ARCHITECTURE v8 OF axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  we <= (rw_rw_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  adr <= (adr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen IS
  PORT(
    q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    adr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    adr_d : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    we_d : IN STD_LOGIC;
    rw_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
    rw_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
  );
END axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen;

ARCHITECTURE v8 OF axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  we <= (rw_rw_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  adr <= (adr_d);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    complete_rsci_wen_comp : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
    main_C_0_tr0 : IN STD_LOGIC;
    ADD_LOOP_C_2_tr0 : IN STD_LOGIC
  );
END axi_test_core_core_fsm;

ARCHITECTURE v8 OF axi_test_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for axi_test_core_core_fsm_1
  TYPE axi_test_core_core_fsm_1_ST IS (core_rlp_C_0, main_C_0, ADD_LOOP_C_0, ADD_LOOP_C_1,
      ADD_LOOP_C_2, main_C_1, main_C_2);

  SIGNAL state_var : axi_test_core_core_fsm_1_ST;
  SIGNAL state_var_NS : axi_test_core_core_fsm_1_ST;

BEGIN
  axi_test_core_core_fsm_1 : PROCESS (main_C_0_tr0, ADD_LOOP_C_2_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN main_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010");
        IF ( main_C_0_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= ADD_LOOP_C_0;
        END IF;
      WHEN ADD_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100");
        state_var_NS <= ADD_LOOP_C_1;
      WHEN ADD_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000");
        state_var_NS <= ADD_LOOP_C_2;
      WHEN ADD_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000");
        IF ( ADD_LOOP_C_2_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= ADD_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000");
        state_var_NS <= main_C_2;
      WHEN main_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000");
        state_var_NS <= main_C_0;
      -- core_rlp_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001");
        state_var_NS <= main_C_0;
    END CASE;
  END PROCESS axi_test_core_core_fsm_1;

  axi_test_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= core_rlp_C_0;
      ELSE
        IF ( complete_rsci_wen_comp = '1' ) THEN
          state_var <= state_var_NS;
        END IF;
      END IF;
    END IF;
  END PROCESS axi_test_core_core_fsm_1_REG;

END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_staller
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_staller IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    core_wten : OUT STD_LOGIC;
    complete_rsci_wen_comp : IN STD_LOGIC;
    core_wten_pff : OUT STD_LOGIC
  );
END axi_test_core_staller;

ARCHITECTURE v8 OF axi_test_core_staller IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL core_wten_reg : STD_LOGIC;

BEGIN
  core_wten <= core_wten_reg;
  core_wten_pff <= NOT complete_rsci_wen_comp;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        core_wten_reg <= '0';
      ELSE
        core_wten_reg <= NOT complete_rsci_wen_comp;
      END IF;
    END IF;
  END PROCESS;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl IS
  PORT(
    core_wten : IN STD_LOGIC;
    b_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
    b_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
  );
END axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl;

ARCHITECTURE v8 OF axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl IS
  -- Default Constants

BEGIN
  b_rsc_triosy_obj_ld_core_sct <= b_rsc_triosy_obj_iswt0 AND (NOT core_wten);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl IS
  PORT(
    core_wten : IN STD_LOGIC;
    a_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
    a_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
  );
END axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl;

ARCHITECTURE v8 OF axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl IS
  -- Default Constants

BEGIN
  a_rsc_triosy_obj_ld_core_sct <= a_rsc_triosy_obj_iswt0 AND (NOT core_wten);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_complete_rsci_complete_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_complete_rsci_complete_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    complete_rsci_oswt : IN STD_LOGIC;
    complete_rsci_wen_comp : OUT STD_LOGIC;
    complete_rsci_biwt : IN STD_LOGIC;
    complete_rsci_bdwt : IN STD_LOGIC;
    complete_rsci_bcwt : OUT STD_LOGIC
  );
END axi_test_core_complete_rsci_complete_wait_dp;

ARCHITECTURE v8 OF axi_test_core_complete_rsci_complete_wait_dp IS
  -- Default Constants

  -- Output Reader Declarations
  SIGNAL complete_rsci_bcwt_drv : STD_LOGIC;

BEGIN
  -- Output Reader Assignments
  complete_rsci_bcwt <= complete_rsci_bcwt_drv;

  complete_rsci_wen_comp <= (NOT complete_rsci_oswt) OR complete_rsci_biwt OR complete_rsci_bcwt_drv;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        complete_rsci_bcwt_drv <= '0';
      ELSE
        complete_rsci_bcwt_drv <= NOT((NOT(complete_rsci_bcwt_drv OR complete_rsci_biwt))
            OR complete_rsci_bdwt);
      END IF;
    END IF;
  END PROCESS;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_complete_rsci_complete_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_complete_rsci_complete_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    complete_rsci_oswt : IN STD_LOGIC;
    complete_rsci_biwt : OUT STD_LOGIC;
    complete_rsci_bdwt : OUT STD_LOGIC;
    complete_rsci_bcwt : IN STD_LOGIC;
    complete_rsci_ivld_core_sct : OUT STD_LOGIC;
    complete_rsci_irdy : IN STD_LOGIC
  );
END axi_test_core_complete_rsci_complete_wait_ctrl;

ARCHITECTURE v8 OF axi_test_core_complete_rsci_complete_wait_ctrl IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL complete_rsci_ogwt : STD_LOGIC;

BEGIN
  complete_rsci_bdwt <= complete_rsci_oswt AND core_wen;
  complete_rsci_biwt <= complete_rsci_ogwt AND complete_rsci_irdy;
  complete_rsci_ogwt <= complete_rsci_oswt AND (NOT complete_rsci_bcwt);
  complete_rsci_ivld_core_sct <= complete_rsci_ogwt;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_b_rsci_1_b_rsc_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_b_rsci_1_b_rsc_wait_ctrl IS
  PORT(
    b_rsci_we_d_core_sct_pff : OUT STD_LOGIC;
    b_rsci_iswt0_pff : IN STD_LOGIC;
    core_wten_pff : IN STD_LOGIC
  );
END axi_test_core_b_rsci_1_b_rsc_wait_ctrl;

ARCHITECTURE v8 OF axi_test_core_b_rsci_1_b_rsc_wait_ctrl IS
  -- Default Constants

BEGIN
  b_rsci_we_d_core_sct_pff <= b_rsci_iswt0_pff AND (NOT core_wten_pff);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_a_rsci_1_a_rsc_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_a_rsci_1_a_rsc_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    a_rsci_q_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsci_q_d_mxwt : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsci_biwt : IN STD_LOGIC;
    a_rsci_bdwt : IN STD_LOGIC
  );
END axi_test_core_a_rsci_1_a_rsc_wait_dp;

ARCHITECTURE v8 OF axi_test_core_a_rsci_1_a_rsc_wait_dp IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL a_rsci_bcwt : STD_LOGIC;
  SIGNAL a_rsci_q_d_bfwt : STD_LOGIC_VECTOR (31 DOWNTO 0);

  FUNCTION MUX_v_32_2_2(input_0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(31 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  a_rsci_q_d_mxwt <= MUX_v_32_2_2(a_rsci_q_d, a_rsci_q_d_bfwt, a_rsci_bcwt);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        a_rsci_bcwt <= '0';
      ELSE
        a_rsci_bcwt <= NOT((NOT(a_rsci_bcwt OR a_rsci_biwt)) OR a_rsci_bdwt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( a_rsci_biwt = '1' ) THEN
        a_rsci_q_d_bfwt <= a_rsci_q_d;
      END IF;
    END IF;
  END PROCESS;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_a_rsci_1_a_rsc_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_a_rsci_1_a_rsc_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    core_wten : IN STD_LOGIC;
    a_rsci_oswt : IN STD_LOGIC;
    a_rsci_biwt : OUT STD_LOGIC;
    a_rsci_bdwt : OUT STD_LOGIC;
    a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct : OUT STD_LOGIC;
    a_rsci_oswt_pff : IN STD_LOGIC;
    core_wten_pff : IN STD_LOGIC
  );
END axi_test_core_a_rsci_1_a_rsc_wait_ctrl;

ARCHITECTURE v8 OF axi_test_core_a_rsci_1_a_rsc_wait_ctrl IS
  -- Default Constants

BEGIN
  a_rsci_bdwt <= a_rsci_oswt AND core_wen;
  a_rsci_biwt <= (NOT core_wten) AND a_rsci_oswt;
  a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct <= a_rsci_oswt_pff AND (NOT core_wten_pff);
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_run_rsci_run_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_run_rsci_run_wait_dp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    run_rsci_ivld_mxwt : OUT STD_LOGIC;
    run_rsci_ivld : IN STD_LOGIC;
    run_rsci_biwt : IN STD_LOGIC;
    run_rsci_bdwt : IN STD_LOGIC
  );
END axi_test_core_run_rsci_run_wait_dp;

ARCHITECTURE v8 OF axi_test_core_run_rsci_run_wait_dp IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL run_rsci_bcwt : STD_LOGIC;
  SIGNAL run_rsci_ivld_bfwt : STD_LOGIC;

  FUNCTION MUX_s_1_2_2(input_0 : STD_LOGIC;
  input_1 : STD_LOGIC;
  sel : STD_LOGIC)
  RETURN STD_LOGIC IS
    VARIABLE result : STD_LOGIC;

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  run_rsci_ivld_mxwt <= MUX_s_1_2_2(run_rsci_ivld, run_rsci_ivld_bfwt, run_rsci_bcwt);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        run_rsci_bcwt <= '0';
      ELSE
        run_rsci_bcwt <= NOT((NOT(run_rsci_bcwt OR run_rsci_biwt)) OR run_rsci_bdwt);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( run_rsci_biwt = '1' ) THEN
        run_rsci_ivld_bfwt <= run_rsci_ivld;
      END IF;
    END IF;
  END PROCESS;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_run_rsci_run_wait_ctrl
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_run_rsci_run_wait_ctrl IS
  PORT(
    core_wen : IN STD_LOGIC;
    run_rsci_oswt : IN STD_LOGIC;
    core_wten : IN STD_LOGIC;
    run_rsci_biwt : OUT STD_LOGIC;
    run_rsci_bdwt : OUT STD_LOGIC
  );
END axi_test_core_run_rsci_run_wait_ctrl;

ARCHITECTURE v8 OF axi_test_core_run_rsci_run_wait_ctrl IS
  -- Default Constants

BEGIN
  run_rsci_bdwt <= run_rsci_oswt AND core_wen;
  run_rsci_biwt <= (NOT core_wten) AND run_rsci_oswt;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_b_rsc_triosy_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_b_rsc_triosy_obj IS
  PORT(
    b_rsc_triosy_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    b_rsc_triosy_obj_iswt0 : IN STD_LOGIC
  );
END axi_test_core_b_rsc_triosy_obj;

ARCHITECTURE v8 OF axi_test_core_b_rsc_triosy_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL b_rsc_triosy_obj_ld_core_sct : STD_LOGIC;

  COMPONENT axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      b_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
      b_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  b_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => b_rsc_triosy_obj_ld_core_sct,
      lz => b_rsc_triosy_lz
    );
  axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl_inst : axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      b_rsc_triosy_obj_iswt0 => b_rsc_triosy_obj_iswt0,
      b_rsc_triosy_obj_ld_core_sct => b_rsc_triosy_obj_ld_core_sct
    );
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_a_rsc_triosy_obj
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_a_rsc_triosy_obj IS
  PORT(
    a_rsc_triosy_lz : OUT STD_LOGIC;
    core_wten : IN STD_LOGIC;
    a_rsc_triosy_obj_iswt0 : IN STD_LOGIC
  );
END axi_test_core_a_rsc_triosy_obj;

ARCHITECTURE v8 OF axi_test_core_a_rsc_triosy_obj IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL a_rsc_triosy_obj_ld_core_sct : STD_LOGIC;

  COMPONENT axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl
    PORT(
      core_wten : IN STD_LOGIC;
      a_rsc_triosy_obj_iswt0 : IN STD_LOGIC;
      a_rsc_triosy_obj_ld_core_sct : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  a_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => a_rsc_triosy_obj_ld_core_sct,
      lz => a_rsc_triosy_lz
    );
  axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl_inst : axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl
    PORT MAP(
      core_wten => core_wten,
      a_rsc_triosy_obj_iswt0 => a_rsc_triosy_obj_iswt0,
      a_rsc_triosy_obj_ld_core_sct => a_rsc_triosy_obj_ld_core_sct
    );
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_complete_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_complete_rsci IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    complete_rsc_rdy : IN STD_LOGIC;
    complete_rsc_vld : OUT STD_LOGIC;
    core_wen : IN STD_LOGIC;
    complete_rsci_oswt : IN STD_LOGIC;
    complete_rsci_wen_comp : OUT STD_LOGIC
  );
END axi_test_core_complete_rsci;

ARCHITECTURE v8 OF axi_test_core_complete_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL complete_rsci_biwt : STD_LOGIC;
  SIGNAL complete_rsci_bdwt : STD_LOGIC;
  SIGNAL complete_rsci_bcwt : STD_LOGIC;
  SIGNAL complete_rsci_ivld_core_sct : STD_LOGIC;
  SIGNAL complete_rsci_irdy : STD_LOGIC;

  COMPONENT axi_test_core_complete_rsci_complete_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      complete_rsci_oswt : IN STD_LOGIC;
      complete_rsci_biwt : OUT STD_LOGIC;
      complete_rsci_bdwt : OUT STD_LOGIC;
      complete_rsci_bcwt : IN STD_LOGIC;
      complete_rsci_ivld_core_sct : OUT STD_LOGIC;
      complete_rsci_irdy : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_complete_rsci_complete_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      complete_rsci_oswt : IN STD_LOGIC;
      complete_rsci_wen_comp : OUT STD_LOGIC;
      complete_rsci_biwt : IN STD_LOGIC;
      complete_rsci_bdwt : IN STD_LOGIC;
      complete_rsci_bcwt : OUT STD_LOGIC
    );
  END COMPONENT;
BEGIN
  complete_rsci : work.ccs_sync_out_wait_pkg_v1.ccs_sync_out_wait_v1
    GENERIC MAP(
      rscid => 4
      )
    PORT MAP(
      vld => complete_rsc_vld,
      rdy => complete_rsc_rdy,
      ivld => complete_rsci_ivld_core_sct,
      irdy => complete_rsci_irdy
    );
  axi_test_core_complete_rsci_complete_wait_ctrl_inst : axi_test_core_complete_rsci_complete_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      complete_rsci_oswt => complete_rsci_oswt,
      complete_rsci_biwt => complete_rsci_biwt,
      complete_rsci_bdwt => complete_rsci_bdwt,
      complete_rsci_bcwt => complete_rsci_bcwt,
      complete_rsci_ivld_core_sct => complete_rsci_ivld_core_sct,
      complete_rsci_irdy => complete_rsci_irdy
    );
  axi_test_core_complete_rsci_complete_wait_dp_inst : axi_test_core_complete_rsci_complete_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      complete_rsci_oswt => complete_rsci_oswt,
      complete_rsci_wen_comp => complete_rsci_wen_comp,
      complete_rsci_biwt => complete_rsci_biwt,
      complete_rsci_bdwt => complete_rsci_bdwt,
      complete_rsci_bcwt => complete_rsci_bcwt
    );
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_b_rsci_1
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_b_rsci_1 IS
  PORT(
    b_rsci_we_d_pff : OUT STD_LOGIC;
    b_rsci_iswt0_pff : IN STD_LOGIC;
    core_wten_pff : IN STD_LOGIC
  );
END axi_test_core_b_rsci_1;

ARCHITECTURE v8 OF axi_test_core_b_rsci_1 IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL b_rsci_we_d_core_sct_iff : STD_LOGIC;

  COMPONENT axi_test_core_b_rsci_1_b_rsc_wait_ctrl
    PORT(
      b_rsci_we_d_core_sct_pff : OUT STD_LOGIC;
      b_rsci_iswt0_pff : IN STD_LOGIC;
      core_wten_pff : IN STD_LOGIC
    );
  END COMPONENT;
BEGIN
  axi_test_core_b_rsci_1_b_rsc_wait_ctrl_inst : axi_test_core_b_rsci_1_b_rsc_wait_ctrl
    PORT MAP(
      b_rsci_we_d_core_sct_pff => b_rsci_we_d_core_sct_iff,
      b_rsci_iswt0_pff => b_rsci_iswt0_pff,
      core_wten_pff => core_wten_pff
    );
  b_rsci_we_d_pff <= b_rsci_we_d_core_sct_iff;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_a_rsci_1
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_a_rsci_1 IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    a_rsci_q_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsci_rw_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    core_wen : IN STD_LOGIC;
    core_wten : IN STD_LOGIC;
    a_rsci_oswt : IN STD_LOGIC;
    a_rsci_q_d_mxwt : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsci_oswt_pff : IN STD_LOGIC;
    core_wten_pff : IN STD_LOGIC
  );
END axi_test_core_a_rsci_1;

ARCHITECTURE v8 OF axi_test_core_a_rsci_1 IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL a_rsci_biwt : STD_LOGIC;
  SIGNAL a_rsci_bdwt : STD_LOGIC;
  SIGNAL a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct : STD_LOGIC;

  COMPONENT axi_test_core_a_rsci_1_a_rsc_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      core_wten : IN STD_LOGIC;
      a_rsci_oswt : IN STD_LOGIC;
      a_rsci_biwt : OUT STD_LOGIC;
      a_rsci_bdwt : OUT STD_LOGIC;
      a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct : OUT STD_LOGIC;
      a_rsci_oswt_pff : IN STD_LOGIC;
      core_wten_pff : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_a_rsci_1_a_rsc_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      a_rsci_q_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      a_rsci_q_d_mxwt : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      a_rsci_biwt : IN STD_LOGIC;
      a_rsci_bdwt : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_q_d : STD_LOGIC_VECTOR
      (31 DOWNTO 0);
  SIGNAL axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_q_d_mxwt : STD_LOGIC_VECTOR
      (31 DOWNTO 0);

BEGIN
  axi_test_core_a_rsci_1_a_rsc_wait_ctrl_inst : axi_test_core_a_rsci_1_a_rsc_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      core_wten => core_wten,
      a_rsci_oswt => a_rsci_oswt,
      a_rsci_biwt => a_rsci_biwt,
      a_rsci_bdwt => a_rsci_bdwt,
      a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct => a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct,
      a_rsci_oswt_pff => a_rsci_oswt_pff,
      core_wten_pff => core_wten_pff
    );
  axi_test_core_a_rsci_1_a_rsc_wait_dp_inst : axi_test_core_a_rsci_1_a_rsc_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      a_rsci_q_d => axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_q_d,
      a_rsci_q_d_mxwt => axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_q_d_mxwt,
      a_rsci_biwt => a_rsci_biwt,
      a_rsci_bdwt => a_rsci_bdwt
    );
  axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_q_d <= a_rsci_q_d;
  a_rsci_q_d_mxwt <= axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_q_d_mxwt;

  a_rsci_rw_rw_ram_ir_internal_RMASK_B_d <= a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct;
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core_run_rsci
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core_run_rsci IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    run_rsc_rdy : OUT STD_LOGIC;
    run_rsc_vld : IN STD_LOGIC;
    core_wen : IN STD_LOGIC;
    run_rsci_oswt : IN STD_LOGIC;
    core_wten : IN STD_LOGIC;
    run_rsci_ivld_mxwt : OUT STD_LOGIC
  );
END axi_test_core_run_rsci;

ARCHITECTURE v8 OF axi_test_core_run_rsci IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL run_rsci_ivld : STD_LOGIC;
  SIGNAL run_rsci_biwt : STD_LOGIC;
  SIGNAL run_rsci_bdwt : STD_LOGIC;

  COMPONENT axi_test_core_run_rsci_run_wait_ctrl
    PORT(
      core_wen : IN STD_LOGIC;
      run_rsci_oswt : IN STD_LOGIC;
      core_wten : IN STD_LOGIC;
      run_rsci_biwt : OUT STD_LOGIC;
      run_rsci_bdwt : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_run_rsci_run_wait_dp
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      run_rsci_ivld_mxwt : OUT STD_LOGIC;
      run_rsci_ivld : IN STD_LOGIC;
      run_rsci_biwt : IN STD_LOGIC;
      run_rsci_bdwt : IN STD_LOGIC
    );
  END COMPONENT;
BEGIN
  run_rsci : work.ccs_sync_in_wait_pkg_v1.ccs_sync_in_wait_v1
    GENERIC MAP(
      rscid => 1
      )
    PORT MAP(
      vld => run_rsc_vld,
      rdy => run_rsc_rdy,
      ivld => run_rsci_ivld,
      irdy => run_rsci_biwt
    );
  axi_test_core_run_rsci_run_wait_ctrl_inst : axi_test_core_run_rsci_run_wait_ctrl
    PORT MAP(
      core_wen => core_wen,
      run_rsci_oswt => run_rsci_oswt,
      core_wten => core_wten,
      run_rsci_biwt => run_rsci_biwt,
      run_rsci_bdwt => run_rsci_bdwt
    );
  axi_test_core_run_rsci_run_wait_dp_inst : axi_test_core_run_rsci_run_wait_dp
    PORT MAP(
      clk => clk,
      rst => rst,
      run_rsci_ivld_mxwt => run_rsci_ivld_mxwt,
      run_rsci_ivld => run_rsci_ivld,
      run_rsci_biwt => run_rsci_biwt,
      run_rsci_bdwt => run_rsci_bdwt
    );
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    run_rsc_rdy : OUT STD_LOGIC;
    run_rsc_vld : IN STD_LOGIC;
    a_rsc_triosy_lz : OUT STD_LOGIC;
    b_rsc_triosy_lz : OUT STD_LOGIC;
    complete_rsc_rdy : IN STD_LOGIC;
    complete_rsc_vld : OUT STD_LOGIC;
    a_rsci_q_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsci_rw_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    b_rsci_d_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsci_adr_d_pff : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    b_rsci_we_d_pff : OUT STD_LOGIC
  );
END axi_test_core;

ARCHITECTURE v8 OF axi_test_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL core_wten : STD_LOGIC;
  SIGNAL run_rsci_ivld_mxwt : STD_LOGIC;
  SIGNAL a_rsci_q_d_mxwt : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL complete_rsci_wen_comp : STD_LOGIC;
  SIGNAL fsm_output : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL ADD_LOOP_i_4_0_sva_3_0 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL ADD_LOOP_i_4_0_sva_1 : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL run_ac_sync_tmp_dobj_sva : STD_LOGIC;
  SIGNAL reg_run_rsci_oswt_cse : STD_LOGIC;
  SIGNAL reg_a_rsci_oswt_cse : STD_LOGIC;
  SIGNAL reg_complete_rsci_oswt_cse : STD_LOGIC;
  SIGNAL reg_a_rsc_triosy_obj_iswt0_cse : STD_LOGIC;
  SIGNAL a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_reg : STD_LOGIC;
  SIGNAL core_wten_iff : STD_LOGIC;
  SIGNAL b_rsci_we_d_iff : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (29 DOWNTO 0);

  SIGNAL ADD_LOOP_mux_2_nl : STD_LOGIC_VECTOR (29 DOWNTO 0);
  COMPONENT axi_test_core_run_rsci
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      run_rsc_rdy : OUT STD_LOGIC;
      run_rsc_vld : IN STD_LOGIC;
      core_wen : IN STD_LOGIC;
      run_rsci_oswt : IN STD_LOGIC;
      core_wten : IN STD_LOGIC;
      run_rsci_ivld_mxwt : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_a_rsci_1
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      a_rsci_q_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      a_rsci_rw_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      core_wen : IN STD_LOGIC;
      core_wten : IN STD_LOGIC;
      a_rsci_oswt : IN STD_LOGIC;
      a_rsci_q_d_mxwt : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      a_rsci_oswt_pff : IN STD_LOGIC;
      core_wten_pff : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL axi_test_core_a_rsci_1_inst_a_rsci_q_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL axi_test_core_a_rsci_1_inst_a_rsci_q_d_mxwt : STD_LOGIC_VECTOR (31 DOWNTO
      0);
  SIGNAL axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff : STD_LOGIC;

  COMPONENT axi_test_core_b_rsci_1
    PORT(
      b_rsci_we_d_pff : OUT STD_LOGIC;
      b_rsci_iswt0_pff : IN STD_LOGIC;
      core_wten_pff : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL axi_test_core_b_rsci_1_inst_b_rsci_iswt0_pff : STD_LOGIC;

  COMPONENT axi_test_core_complete_rsci
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      complete_rsc_rdy : IN STD_LOGIC;
      complete_rsc_vld : OUT STD_LOGIC;
      core_wen : IN STD_LOGIC;
      complete_rsci_oswt : IN STD_LOGIC;
      complete_rsci_wen_comp : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_a_rsc_triosy_obj
    PORT(
      a_rsc_triosy_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      a_rsc_triosy_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_b_rsc_triosy_obj
    PORT(
      b_rsc_triosy_lz : OUT STD_LOGIC;
      core_wten : IN STD_LOGIC;
      b_rsc_triosy_obj_iswt0 : IN STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_staller
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      core_wten : OUT STD_LOGIC;
      complete_rsci_wen_comp : IN STD_LOGIC;
      core_wten_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT axi_test_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      complete_rsci_wen_comp : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
      main_C_0_tr0 : IN STD_LOGIC;
      ADD_LOOP_C_2_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL axi_test_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL axi_test_core_core_fsm_inst_main_C_0_tr0 : STD_LOGIC;
  SIGNAL axi_test_core_core_fsm_inst_ADD_LOOP_C_2_tr0 : STD_LOGIC;

  FUNCTION MUX_v_30_2_2(input_0 : STD_LOGIC_VECTOR(29 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(29 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(29 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_4_2_2(input_0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(3 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

BEGIN
  axi_test_core_run_rsci_inst : axi_test_core_run_rsci
    PORT MAP(
      clk => clk,
      rst => rst,
      run_rsc_rdy => run_rsc_rdy,
      run_rsc_vld => run_rsc_vld,
      core_wen => complete_rsci_wen_comp,
      run_rsci_oswt => reg_run_rsci_oswt_cse,
      core_wten => core_wten,
      run_rsci_ivld_mxwt => run_rsci_ivld_mxwt
    );
  axi_test_core_a_rsci_1_inst : axi_test_core_a_rsci_1
    PORT MAP(
      clk => clk,
      rst => rst,
      a_rsci_q_d => axi_test_core_a_rsci_1_inst_a_rsci_q_d,
      a_rsci_rw_rw_ram_ir_internal_RMASK_B_d => a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_reg,
      core_wen => complete_rsci_wen_comp,
      core_wten => core_wten,
      a_rsci_oswt => reg_a_rsci_oswt_cse,
      a_rsci_q_d_mxwt => axi_test_core_a_rsci_1_inst_a_rsci_q_d_mxwt,
      a_rsci_oswt_pff => axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff,
      core_wten_pff => core_wten_iff
    );
  axi_test_core_a_rsci_1_inst_a_rsci_q_d <= a_rsci_q_d;
  a_rsci_q_d_mxwt <= axi_test_core_a_rsci_1_inst_a_rsci_q_d_mxwt;
  axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff <= fsm_output(2);

  axi_test_core_b_rsci_1_inst : axi_test_core_b_rsci_1
    PORT MAP(
      b_rsci_we_d_pff => b_rsci_we_d_iff,
      b_rsci_iswt0_pff => axi_test_core_b_rsci_1_inst_b_rsci_iswt0_pff,
      core_wten_pff => core_wten_iff
    );
  axi_test_core_b_rsci_1_inst_b_rsci_iswt0_pff <= fsm_output(3);

  axi_test_core_complete_rsci_inst : axi_test_core_complete_rsci
    PORT MAP(
      clk => clk,
      rst => rst,
      complete_rsc_rdy => complete_rsc_rdy,
      complete_rsc_vld => complete_rsc_vld,
      core_wen => complete_rsci_wen_comp,
      complete_rsci_oswt => reg_complete_rsci_oswt_cse,
      complete_rsci_wen_comp => complete_rsci_wen_comp
    );
  axi_test_core_a_rsc_triosy_obj_inst : axi_test_core_a_rsc_triosy_obj
    PORT MAP(
      a_rsc_triosy_lz => a_rsc_triosy_lz,
      core_wten => core_wten,
      a_rsc_triosy_obj_iswt0 => reg_a_rsc_triosy_obj_iswt0_cse
    );
  axi_test_core_b_rsc_triosy_obj_inst : axi_test_core_b_rsc_triosy_obj
    PORT MAP(
      b_rsc_triosy_lz => b_rsc_triosy_lz,
      core_wten => core_wten,
      b_rsc_triosy_obj_iswt0 => reg_a_rsc_triosy_obj_iswt0_cse
    );
  axi_test_core_staller_inst : axi_test_core_staller
    PORT MAP(
      clk => clk,
      rst => rst,
      core_wten => core_wten,
      complete_rsci_wen_comp => complete_rsci_wen_comp,
      core_wten_pff => core_wten_iff
    );
  axi_test_core_core_fsm_inst : axi_test_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      complete_rsci_wen_comp => complete_rsci_wen_comp,
      fsm_output => axi_test_core_core_fsm_inst_fsm_output,
      main_C_0_tr0 => axi_test_core_core_fsm_inst_main_C_0_tr0,
      ADD_LOOP_C_2_tr0 => axi_test_core_core_fsm_inst_ADD_LOOP_C_2_tr0
    );
  fsm_output <= axi_test_core_core_fsm_inst_fsm_output;
  axi_test_core_core_fsm_inst_main_C_0_tr0 <= NOT run_ac_sync_tmp_dobj_sva;
  axi_test_core_core_fsm_inst_ADD_LOOP_C_2_tr0 <= ADD_LOOP_i_4_0_sva_1(4);

  a_rsci_adr_d_pff <= ADD_LOOP_i_4_0_sva_3_0;
  a_rsci_rw_rw_ram_ir_internal_RMASK_B_d <= a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_reg;
  b_rsci_d_d <= z_out & (a_rsci_q_d_mxwt(1 DOWNTO 0));
  b_rsci_we_d_pff <= b_rsci_we_d_iff;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_run_rsci_oswt_cse <= '0';
        reg_a_rsci_oswt_cse <= '0';
        reg_complete_rsci_oswt_cse <= '0';
        reg_a_rsc_triosy_obj_iswt0_cse <= '0';
      ELSIF ( complete_rsci_wen_comp = '1' ) THEN
        reg_run_rsci_oswt_cse <= (fsm_output(0)) OR (fsm_output(6));
        reg_a_rsci_oswt_cse <= fsm_output(2);
        reg_complete_rsci_oswt_cse <= (ADD_LOOP_i_4_0_sva_1(4)) AND (fsm_output(4));
        reg_a_rsc_triosy_obj_iswt0_cse <= fsm_output(5);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        run_ac_sync_tmp_dobj_sva <= '0';
      ELSIF ( (complete_rsci_wen_comp AND (fsm_output(1))) = '1' ) THEN
        run_ac_sync_tmp_dobj_sva <= run_rsci_ivld_mxwt;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (complete_rsci_wen_comp AND ((fsm_output(4)) OR (fsm_output(1)))) = '1'
          ) THEN
        ADD_LOOP_i_4_0_sva_3_0 <= MUX_v_4_2_2(STD_LOGIC_VECTOR'("0000"), (ADD_LOOP_i_4_0_sva_1(3
            DOWNTO 0)), (fsm_output(4)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        ADD_LOOP_i_4_0_sva_1 <= STD_LOGIC_VECTOR'( "00000");
      ELSIF ( (complete_rsci_wen_comp AND (fsm_output(2))) = '1' ) THEN
        ADD_LOOP_i_4_0_sva_1 <= z_out(4 DOWNTO 0);
      END IF;
    END IF;
  END PROCESS;
  ADD_LOOP_mux_2_nl <= MUX_v_30_2_2((STD_LOGIC_VECTOR'( "00000000000000000000000000")
      & ADD_LOOP_i_4_0_sva_3_0), (a_rsci_q_d_mxwt(31 DOWNTO 2)), fsm_output(3));
  z_out <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(ADD_LOOP_mux_2_nl) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(CONV_SIGNED(SIGNED((fsm_output(3))
      & STD_LOGIC_VECTOR'( "001")),5)), 5), 30), 30));
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    axi_test
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_sync_in_wait_pkg_v1.ALL;
USE work.ccs_sync_out_wait_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY axi_test IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    run_rsc_rdy : OUT STD_LOGIC;
    run_rsc_vld : IN STD_LOGIC;
    a_rsc_adr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    a_rsc_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsc_we : OUT STD_LOGIC;
    a_rsc_q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    a_rsc_triosy_lz : OUT STD_LOGIC;
    b_rsc_adr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    b_rsc_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
    b_rsc_we : OUT STD_LOGIC;
    b_rsc_q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
    b_rsc_triosy_lz : OUT STD_LOGIC;
    complete_rsc_rdy : IN STD_LOGIC;
    complete_rsc_vld : OUT STD_LOGIC
  );
END axi_test;

ARCHITECTURE v8 OF axi_test IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';
  CONSTANT GND : STD_LOGIC := '0';

  -- Interconnect Declarations
  SIGNAL a_rsci_q_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL a_rsci_rw_rw_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL b_rsci_d_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL b_rsci_q_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL a_rsci_adr_d_iff : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL b_rsci_we_d_iff : STD_LOGIC;

  COMPONENT axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      adr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      adr_d : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      we_d : IN STD_LOGIC;
      rw_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rw_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL a_rsci_q : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL a_rsci_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL a_rsci_adr : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL a_rsci_adr_d : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL a_rsci_d_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL a_rsci_q_d_1 : STD_LOGIC_VECTOR (31 DOWNTO 0);

  COMPONENT axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      adr : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      adr_d : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      we_d : IN STD_LOGIC;
      rw_rw_ram_ir_internal_RMASK_B_d : IN STD_LOGIC;
      rw_rw_ram_ir_internal_WMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL b_rsci_q : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL b_rsci_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL b_rsci_adr : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL b_rsci_adr_d : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL b_rsci_d_d_1 : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL b_rsci_q_d_1 : STD_LOGIC_VECTOR (31 DOWNTO 0);

  COMPONENT axi_test_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      run_rsc_rdy : OUT STD_LOGIC;
      run_rsc_vld : IN STD_LOGIC;
      a_rsc_triosy_lz : OUT STD_LOGIC;
      b_rsc_triosy_lz : OUT STD_LOGIC;
      complete_rsc_rdy : IN STD_LOGIC;
      complete_rsc_vld : OUT STD_LOGIC;
      a_rsci_q_d : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
      a_rsci_rw_rw_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      b_rsci_d_d : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
      a_rsci_adr_d_pff : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
      b_rsci_we_d_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL axi_test_core_inst_a_rsci_q_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL axi_test_core_inst_b_rsci_d_d : STD_LOGIC_VECTOR (31 DOWNTO 0);
  SIGNAL axi_test_core_inst_a_rsci_adr_d_pff : STD_LOGIC_VECTOR (3 DOWNTO 0);

BEGIN
  a_rsci : axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen
    PORT MAP(
      q => a_rsci_q,
      we => a_rsc_we,
      d => a_rsci_d,
      adr => a_rsci_adr,
      adr_d => a_rsci_adr_d,
      d_d => a_rsci_d_d,
      q_d => a_rsci_q_d_1,
      we_d => '0',
      rw_rw_ram_ir_internal_RMASK_B_d => a_rsci_rw_rw_ram_ir_internal_RMASK_B_d,
      rw_rw_ram_ir_internal_WMASK_B_d => '0'
    );
  a_rsci_q <= a_rsc_q;
  a_rsc_d <= a_rsci_d;
  a_rsc_adr <= a_rsci_adr;
  a_rsci_adr_d <= a_rsci_adr_d_iff;
  a_rsci_d_d <= STD_LOGIC_VECTOR'( "00000000000000000000000000000000");
  a_rsci_q_d <= a_rsci_q_d_1;

  b_rsci : axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen
    PORT MAP(
      q => b_rsci_q,
      we => b_rsc_we,
      d => b_rsci_d,
      adr => b_rsci_adr,
      adr_d => b_rsci_adr_d,
      d_d => b_rsci_d_d_1,
      q_d => b_rsci_q_d_1,
      we_d => b_rsci_we_d_iff,
      rw_rw_ram_ir_internal_RMASK_B_d => '0',
      rw_rw_ram_ir_internal_WMASK_B_d => b_rsci_we_d_iff
    );
  b_rsci_q <= b_rsc_q;
  b_rsc_d <= b_rsci_d;
  b_rsc_adr <= b_rsci_adr;
  b_rsci_adr_d <= a_rsci_adr_d_iff;
  b_rsci_d_d_1 <= b_rsci_d_d;
  b_rsci_q_d <= b_rsci_q_d_1;

  axi_test_core_inst : axi_test_core
    PORT MAP(
      clk => clk,
      rst => rst,
      run_rsc_rdy => run_rsc_rdy,
      run_rsc_vld => run_rsc_vld,
      a_rsc_triosy_lz => a_rsc_triosy_lz,
      b_rsc_triosy_lz => b_rsc_triosy_lz,
      complete_rsc_rdy => complete_rsc_rdy,
      complete_rsc_vld => complete_rsc_vld,
      a_rsci_q_d => axi_test_core_inst_a_rsci_q_d,
      a_rsci_rw_rw_ram_ir_internal_RMASK_B_d => a_rsci_rw_rw_ram_ir_internal_RMASK_B_d,
      b_rsci_d_d => axi_test_core_inst_b_rsci_d_d,
      a_rsci_adr_d_pff => axi_test_core_inst_a_rsci_adr_d_pff,
      b_rsci_we_d_pff => b_rsci_we_d_iff
    );
  axi_test_core_inst_a_rsci_q_d <= a_rsci_q_d;
  b_rsci_d_d <= axi_test_core_inst_b_rsci_d_d;
  a_rsci_adr_d_iff <= axi_test_core_inst_a_rsci_adr_d_pff;

END v8;



