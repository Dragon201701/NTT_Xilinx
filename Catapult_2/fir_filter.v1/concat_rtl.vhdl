
--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_in_v1.vhd 
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

PACKAGE ccs_in_pkg_v1 IS

COMPONENT ccs_in_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    idat   : OUT std_logic_vector(width-1 DOWNTO 0);
    dat    : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

END ccs_in_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_in_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    idat  : OUT std_logic_vector(width-1 DOWNTO 0);
    dat   : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END ccs_in_v1;

ARCHITECTURE beh OF ccs_in_v1 IS
BEGIN

  idat <= dat;

END beh;


--------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_out_v1.vhd 
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

PACKAGE ccs_out_pkg_v1 IS

COMPONENT ccs_out_v1
  GENERIC (
    rscid    : INTEGER;
    width    : INTEGER
  );
  PORT (
    dat    : OUT std_logic_vector(width-1 DOWNTO 0);
    idat   : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END COMPONENT;

END ccs_out_pkg_v1;

LIBRARY ieee;

USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all; -- Prevent STARC 2.1.1.2 violation

ENTITY ccs_out_v1 IS
  GENERIC (
    rscid : INTEGER;
    width : INTEGER
  );
  PORT (
    dat   : OUT std_logic_vector(width-1 DOWNTO 0);
    idat  : IN  std_logic_vector(width-1 DOWNTO 0)
  );
END ccs_out_v1;

ARCHITECTURE beh OF ccs_out_v1 IS
BEGIN

  dat <= idat;

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
--  Generated by:   jd4691@newnano.poly.edu
--  Generated date: Tue Jun 22 23:59:00 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    fir_filter_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.ccs_out_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY fir_filter_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
    SHIFT_LOOP_C_0_tr0 : IN STD_LOGIC;
    MAC_LOOP_C_0_tr0 : IN STD_LOGIC
  );
END fir_filter_core_core_fsm;

ARCHITECTURE v1 OF fir_filter_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for fir_filter_core_core_fsm_1
  TYPE fir_filter_core_core_fsm_1_ST IS (main_C_0, SHIFT_LOOP_C_0, MAC_LOOP_C_0,
      main_C_1, main_C_2);

  SIGNAL state_var : fir_filter_core_core_fsm_1_ST;
  SIGNAL state_var_NS : fir_filter_core_core_fsm_1_ST;

BEGIN
  fir_filter_core_core_fsm_1 : PROCESS (SHIFT_LOOP_C_0_tr0, MAC_LOOP_C_0_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN SHIFT_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "00010");
        IF ( SHIFT_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= MAC_LOOP_C_0;
        ELSE
          state_var_NS <= SHIFT_LOOP_C_0;
        END IF;
      WHEN MAC_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "00100");
        IF ( MAC_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= MAC_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "01000");
        state_var_NS <= main_C_2;
      WHEN main_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "10000");
        state_var_NS <= main_C_0;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "00001");
        state_var_NS <= SHIFT_LOOP_C_0;
    END CASE;
  END PROCESS fir_filter_core_core_fsm_1;

  fir_filter_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= main_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS fir_filter_core_core_fsm_1_REG;

END v1;

-- ------------------------------------------------------------------
--  Design Unit:    fir_filter_core
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.ccs_out_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY fir_filter_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    i_sample_rsc_dat : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    i_sample_rsc_triosy_lz : OUT STD_LOGIC;
    b_rsc_dat : IN STD_LOGIC_VECTOR (1269 DOWNTO 0);
    b_rsc_triosy_lz : OUT STD_LOGIC;
    y_rsc_dat : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    y_rsc_triosy_lz : OUT STD_LOGIC
  );
END fir_filter_core;

ARCHITECTURE v1 OF fir_filter_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL i_sample_rsci_idat : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL b_rsci_idat : STD_LOGIC_VECTOR (1269 DOWNTO 0);
  SIGNAL y_rsc_triosy_obj_ld : STD_LOGIC;
  SIGNAL y_rsci_idat_8 : STD_LOGIC;
  SIGNAL y_rsci_idat_7_1 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL y_rsci_idat_0 : STD_LOGIC;
  SIGNAL fsm_output : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL or_dcpl_9 : STD_LOGIC;
  SIGNAL or_dcpl_10 : STD_LOGIC;
  SIGNAL or_dcpl_11 : STD_LOGIC;
  SIGNAL or_dcpl_12 : STD_LOGIC;
  SIGNAL or_dcpl_13 : STD_LOGIC;
  SIGNAL or_dcpl_15 : STD_LOGIC;
  SIGNAL or_dcpl_16 : STD_LOGIC;
  SIGNAL or_dcpl_17 : STD_LOGIC;
  SIGNAL or_dcpl_19 : STD_LOGIC;
  SIGNAL or_dcpl_20 : STD_LOGIC;
  SIGNAL or_dcpl_21 : STD_LOGIC;
  SIGNAL or_dcpl_22 : STD_LOGIC;
  SIGNAL or_dcpl_23 : STD_LOGIC;
  SIGNAL or_dcpl_26 : STD_LOGIC;
  SIGNAL or_dcpl_27 : STD_LOGIC;
  SIGNAL or_dcpl_28 : STD_LOGIC;
  SIGNAL or_dcpl_30 : STD_LOGIC;
  SIGNAL or_dcpl_34 : STD_LOGIC;
  SIGNAL or_dcpl_36 : STD_LOGIC;
  SIGNAL or_dcpl_40 : STD_LOGIC;
  SIGNAL or_dcpl_42 : STD_LOGIC;
  SIGNAL or_dcpl_43 : STD_LOGIC;
  SIGNAL or_dcpl_47 : STD_LOGIC;
  SIGNAL or_dcpl_48 : STD_LOGIC;
  SIGNAL or_dcpl_50 : STD_LOGIC;
  SIGNAL or_dcpl_54 : STD_LOGIC;
  SIGNAL or_dcpl_56 : STD_LOGIC;
  SIGNAL or_dcpl_60 : STD_LOGIC;
  SIGNAL or_dcpl_62 : STD_LOGIC;
  SIGNAL or_dcpl_66 : STD_LOGIC;
  SIGNAL or_dcpl_100 : STD_LOGIC;
  SIGNAL or_dcpl_101 : STD_LOGIC;
  SIGNAL or_dcpl_104 : STD_LOGIC;
  SIGNAL or_dcpl_106 : STD_LOGIC;
  SIGNAL or_dcpl_107 : STD_LOGIC;
  SIGNAL or_dcpl_110 : STD_LOGIC;
  SIGNAL sum_sva : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL MAC_LOOP_n_6_0_sva : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL reg_b_rsc_triosy_obj_ld_cse : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL z_out_3 : STD_LOGIC_VECTOR (19 DOWNTO 0);
  SIGNAL x_0_sva : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_63_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_62_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_64_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_61_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_65_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_60_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_66_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_59_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_67_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_58_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_68_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_57_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_69_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_56_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_70_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_55_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_71_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_54_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_72_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_53_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_73_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_52_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_74_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_51_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_75_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_50_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_76_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_49_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_77_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_48_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_78_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_47_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_79_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_46_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_80_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_45_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_81_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_44_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_82_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_43_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_83_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_42_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_84_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_41_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_85_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_40_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_86_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_39_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_87_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_38_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_88_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_37_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_89_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_36_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_90_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_35_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_91_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_34_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_92_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_33_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_93_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_32_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_94_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_31_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_95_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_30_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_96_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_29_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_97_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_28_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_98_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_27_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_99_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_26_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_100_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_25_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_101_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_24_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_102_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_23_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_103_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_22_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_104_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_21_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_105_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_20_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_106_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_19_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_107_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_18_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_108_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_17_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_109_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_16_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_110_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_15_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_111_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_14_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_112_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_13_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_113_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_12_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_114_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_11_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_115_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_10_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_116_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_9_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_117_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_8_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_118_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_7_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_119_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_6_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_120_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_5_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_121_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_4_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_122_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_3_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_123_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_2_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_124_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_1_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_125_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL x_126_lpi_2 : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL i_sample_sva : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL nor_ovfl_sva_1 : STD_LOGIC;
  SIGNAL and_unfl_sva_1 : STD_LOGIC;
  SIGNAL z_out_1_7 : STD_LOGIC;

  SIGNAL nor_5_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL SHIFT_LOOP_n_SHIFT_LOOP_n_mux_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL SHIFT_LOOP_n_or_nl : STD_LOGIC;
  SIGNAL MAC_LOOP_n_nor_nl : STD_LOGIC;
  SIGNAL SHIFT_LOOP_acc_nl : STD_LOGIC_VECTOR (7 DOWNTO 0);
  SIGNAL SHIFT_LOOP_mux_129_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL MAC_LOOP_mux_7_nl : STD_LOGIC_VECTOR (18 DOWNTO 0);
  SIGNAL MAC_LOOP_mux_8_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL MAC_LOOP_mul_1_nl : STD_LOGIC_VECTOR (12 DOWNTO 0);
  SIGNAL MAC_LOOP_mux_9_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL MAC_LOOP_mux_10_nl : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL MAC_LOOP_mux_11_nl : STD_LOGIC_VECTOR (6 DOWNTO 0);
  SIGNAL i_sample_rsci_dat : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL i_sample_rsci_idat_1 : STD_LOGIC_VECTOR (2 DOWNTO 0);

  SIGNAL b_rsci_dat : STD_LOGIC_VECTOR (1269 DOWNTO 0);
  SIGNAL b_rsci_idat_1 : STD_LOGIC_VECTOR (1269 DOWNTO 0);

  SIGNAL y_rsci_idat : STD_LOGIC_VECTOR (8 DOWNTO 0);
  SIGNAL y_rsci_dat : STD_LOGIC_VECTOR (8 DOWNTO 0);

  COMPONENT fir_filter_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (4 DOWNTO 0);
      SHIFT_LOOP_C_0_tr0 : IN STD_LOGIC;
      MAC_LOOP_C_0_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL fir_filter_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (4 DOWNTO 0);
  SIGNAL fir_filter_core_core_fsm_inst_SHIFT_LOOP_C_0_tr0 : STD_LOGIC;
  SIGNAL fir_filter_core_core_fsm_inst_MAC_LOOP_C_0_tr0 : STD_LOGIC;

  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

  FUNCTION MUX_v_10_127_2(input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_10 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_11 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_12 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_13 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_14 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_15 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_16 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_17 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_18 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_19 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_20 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_21 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_22 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_23 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_24 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_25 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_26 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_27 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_28 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_29 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_30 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_31 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_32 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_33 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_34 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_35 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_36 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_37 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_38 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_39 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_40 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_41 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_42 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_43 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_44 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_45 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_46 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_47 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_48 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_49 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_50 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_51 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_52 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_53 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_54 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_55 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_56 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_57 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_58 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_59 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_60 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_61 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_62 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_63 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_64 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_65 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_66 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_67 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_68 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_69 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_70 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_71 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_72 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_73 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_74 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_75 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_76 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_77 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_78 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_79 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_80 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_81 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_82 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_83 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_84 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_85 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_86 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_87 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_88 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_89 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_90 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_91 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_92 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_93 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_94 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_95 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_96 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_97 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_98 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_99 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_100 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_101 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_102 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_103 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_104 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_105 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_106 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_107 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_108 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_109 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_110 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_111 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_112 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_113 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_114 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_115 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_116 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_117 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_118 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_119 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_120 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_121 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_122 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_123 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_124 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_125 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_126 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(6 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(9 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "0000000" =>
          result := input_0;
        WHEN "0000001" =>
          result := input_1;
        WHEN "0000010" =>
          result := input_2;
        WHEN "0000011" =>
          result := input_3;
        WHEN "0000100" =>
          result := input_4;
        WHEN "0000101" =>
          result := input_5;
        WHEN "0000110" =>
          result := input_6;
        WHEN "0000111" =>
          result := input_7;
        WHEN "0001000" =>
          result := input_8;
        WHEN "0001001" =>
          result := input_9;
        WHEN "0001010" =>
          result := input_10;
        WHEN "0001011" =>
          result := input_11;
        WHEN "0001100" =>
          result := input_12;
        WHEN "0001101" =>
          result := input_13;
        WHEN "0001110" =>
          result := input_14;
        WHEN "0001111" =>
          result := input_15;
        WHEN "0010000" =>
          result := input_16;
        WHEN "0010001" =>
          result := input_17;
        WHEN "0010010" =>
          result := input_18;
        WHEN "0010011" =>
          result := input_19;
        WHEN "0010100" =>
          result := input_20;
        WHEN "0010101" =>
          result := input_21;
        WHEN "0010110" =>
          result := input_22;
        WHEN "0010111" =>
          result := input_23;
        WHEN "0011000" =>
          result := input_24;
        WHEN "0011001" =>
          result := input_25;
        WHEN "0011010" =>
          result := input_26;
        WHEN "0011011" =>
          result := input_27;
        WHEN "0011100" =>
          result := input_28;
        WHEN "0011101" =>
          result := input_29;
        WHEN "0011110" =>
          result := input_30;
        WHEN "0011111" =>
          result := input_31;
        WHEN "0100000" =>
          result := input_32;
        WHEN "0100001" =>
          result := input_33;
        WHEN "0100010" =>
          result := input_34;
        WHEN "0100011" =>
          result := input_35;
        WHEN "0100100" =>
          result := input_36;
        WHEN "0100101" =>
          result := input_37;
        WHEN "0100110" =>
          result := input_38;
        WHEN "0100111" =>
          result := input_39;
        WHEN "0101000" =>
          result := input_40;
        WHEN "0101001" =>
          result := input_41;
        WHEN "0101010" =>
          result := input_42;
        WHEN "0101011" =>
          result := input_43;
        WHEN "0101100" =>
          result := input_44;
        WHEN "0101101" =>
          result := input_45;
        WHEN "0101110" =>
          result := input_46;
        WHEN "0101111" =>
          result := input_47;
        WHEN "0110000" =>
          result := input_48;
        WHEN "0110001" =>
          result := input_49;
        WHEN "0110010" =>
          result := input_50;
        WHEN "0110011" =>
          result := input_51;
        WHEN "0110100" =>
          result := input_52;
        WHEN "0110101" =>
          result := input_53;
        WHEN "0110110" =>
          result := input_54;
        WHEN "0110111" =>
          result := input_55;
        WHEN "0111000" =>
          result := input_56;
        WHEN "0111001" =>
          result := input_57;
        WHEN "0111010" =>
          result := input_58;
        WHEN "0111011" =>
          result := input_59;
        WHEN "0111100" =>
          result := input_60;
        WHEN "0111101" =>
          result := input_61;
        WHEN "0111110" =>
          result := input_62;
        WHEN "0111111" =>
          result := input_63;
        WHEN "1000000" =>
          result := input_64;
        WHEN "1000001" =>
          result := input_65;
        WHEN "1000010" =>
          result := input_66;
        WHEN "1000011" =>
          result := input_67;
        WHEN "1000100" =>
          result := input_68;
        WHEN "1000101" =>
          result := input_69;
        WHEN "1000110" =>
          result := input_70;
        WHEN "1000111" =>
          result := input_71;
        WHEN "1001000" =>
          result := input_72;
        WHEN "1001001" =>
          result := input_73;
        WHEN "1001010" =>
          result := input_74;
        WHEN "1001011" =>
          result := input_75;
        WHEN "1001100" =>
          result := input_76;
        WHEN "1001101" =>
          result := input_77;
        WHEN "1001110" =>
          result := input_78;
        WHEN "1001111" =>
          result := input_79;
        WHEN "1010000" =>
          result := input_80;
        WHEN "1010001" =>
          result := input_81;
        WHEN "1010010" =>
          result := input_82;
        WHEN "1010011" =>
          result := input_83;
        WHEN "1010100" =>
          result := input_84;
        WHEN "1010101" =>
          result := input_85;
        WHEN "1010110" =>
          result := input_86;
        WHEN "1010111" =>
          result := input_87;
        WHEN "1011000" =>
          result := input_88;
        WHEN "1011001" =>
          result := input_89;
        WHEN "1011010" =>
          result := input_90;
        WHEN "1011011" =>
          result := input_91;
        WHEN "1011100" =>
          result := input_92;
        WHEN "1011101" =>
          result := input_93;
        WHEN "1011110" =>
          result := input_94;
        WHEN "1011111" =>
          result := input_95;
        WHEN "1100000" =>
          result := input_96;
        WHEN "1100001" =>
          result := input_97;
        WHEN "1100010" =>
          result := input_98;
        WHEN "1100011" =>
          result := input_99;
        WHEN "1100100" =>
          result := input_100;
        WHEN "1100101" =>
          result := input_101;
        WHEN "1100110" =>
          result := input_102;
        WHEN "1100111" =>
          result := input_103;
        WHEN "1101000" =>
          result := input_104;
        WHEN "1101001" =>
          result := input_105;
        WHEN "1101010" =>
          result := input_106;
        WHEN "1101011" =>
          result := input_107;
        WHEN "1101100" =>
          result := input_108;
        WHEN "1101101" =>
          result := input_109;
        WHEN "1101110" =>
          result := input_110;
        WHEN "1101111" =>
          result := input_111;
        WHEN "1110000" =>
          result := input_112;
        WHEN "1110001" =>
          result := input_113;
        WHEN "1110010" =>
          result := input_114;
        WHEN "1110011" =>
          result := input_115;
        WHEN "1110100" =>
          result := input_116;
        WHEN "1110101" =>
          result := input_117;
        WHEN "1110110" =>
          result := input_118;
        WHEN "1110111" =>
          result := input_119;
        WHEN "1111000" =>
          result := input_120;
        WHEN "1111001" =>
          result := input_121;
        WHEN "1111010" =>
          result := input_122;
        WHEN "1111011" =>
          result := input_123;
        WHEN "1111100" =>
          result := input_124;
        WHEN "1111101" =>
          result := input_125;
        WHEN others =>
          result := input_126;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_13_2_2(input_0 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(12 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(12 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_19_2_2(input_0 : STD_LOGIC_VECTOR(18 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(18 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(18 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_20_2_2(input_0 : STD_LOGIC_VECTOR(19 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(19 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(19 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_3_127_2(input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_2 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_3 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_4 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_5 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_6 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_7 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_8 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_9 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_10 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_11 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_12 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_13 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_14 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_15 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_16 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_17 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_18 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_19 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_20 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_21 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_22 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_23 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_24 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_25 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_26 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_27 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_28 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_29 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_30 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_31 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_32 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_33 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_34 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_35 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_36 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_37 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_38 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_39 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_40 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_41 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_42 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_43 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_44 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_45 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_46 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_47 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_48 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_49 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_50 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_51 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_52 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_53 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_54 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_55 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_56 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_57 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_58 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_59 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_60 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_61 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_62 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_63 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_64 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_65 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_66 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_67 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_68 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_69 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_70 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_71 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_72 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_73 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_74 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_75 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_76 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_77 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_78 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_79 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_80 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_81 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_82 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_83 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_84 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_85 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_86 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_87 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_88 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_89 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_90 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_91 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_92 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_93 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_94 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_95 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_96 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_97 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_98 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_99 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_100 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_101 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_102 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_103 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_104 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_105 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_106 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_107 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_108 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_109 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_110 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_111 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_112 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_113 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_114 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_115 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_116 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_117 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_118 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_119 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_120 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_121 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_122 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_123 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_124 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_125 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_126 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(6 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN "0000000" =>
          result := input_0;
        WHEN "0000001" =>
          result := input_1;
        WHEN "0000010" =>
          result := input_2;
        WHEN "0000011" =>
          result := input_3;
        WHEN "0000100" =>
          result := input_4;
        WHEN "0000101" =>
          result := input_5;
        WHEN "0000110" =>
          result := input_6;
        WHEN "0000111" =>
          result := input_7;
        WHEN "0001000" =>
          result := input_8;
        WHEN "0001001" =>
          result := input_9;
        WHEN "0001010" =>
          result := input_10;
        WHEN "0001011" =>
          result := input_11;
        WHEN "0001100" =>
          result := input_12;
        WHEN "0001101" =>
          result := input_13;
        WHEN "0001110" =>
          result := input_14;
        WHEN "0001111" =>
          result := input_15;
        WHEN "0010000" =>
          result := input_16;
        WHEN "0010001" =>
          result := input_17;
        WHEN "0010010" =>
          result := input_18;
        WHEN "0010011" =>
          result := input_19;
        WHEN "0010100" =>
          result := input_20;
        WHEN "0010101" =>
          result := input_21;
        WHEN "0010110" =>
          result := input_22;
        WHEN "0010111" =>
          result := input_23;
        WHEN "0011000" =>
          result := input_24;
        WHEN "0011001" =>
          result := input_25;
        WHEN "0011010" =>
          result := input_26;
        WHEN "0011011" =>
          result := input_27;
        WHEN "0011100" =>
          result := input_28;
        WHEN "0011101" =>
          result := input_29;
        WHEN "0011110" =>
          result := input_30;
        WHEN "0011111" =>
          result := input_31;
        WHEN "0100000" =>
          result := input_32;
        WHEN "0100001" =>
          result := input_33;
        WHEN "0100010" =>
          result := input_34;
        WHEN "0100011" =>
          result := input_35;
        WHEN "0100100" =>
          result := input_36;
        WHEN "0100101" =>
          result := input_37;
        WHEN "0100110" =>
          result := input_38;
        WHEN "0100111" =>
          result := input_39;
        WHEN "0101000" =>
          result := input_40;
        WHEN "0101001" =>
          result := input_41;
        WHEN "0101010" =>
          result := input_42;
        WHEN "0101011" =>
          result := input_43;
        WHEN "0101100" =>
          result := input_44;
        WHEN "0101101" =>
          result := input_45;
        WHEN "0101110" =>
          result := input_46;
        WHEN "0101111" =>
          result := input_47;
        WHEN "0110000" =>
          result := input_48;
        WHEN "0110001" =>
          result := input_49;
        WHEN "0110010" =>
          result := input_50;
        WHEN "0110011" =>
          result := input_51;
        WHEN "0110100" =>
          result := input_52;
        WHEN "0110101" =>
          result := input_53;
        WHEN "0110110" =>
          result := input_54;
        WHEN "0110111" =>
          result := input_55;
        WHEN "0111000" =>
          result := input_56;
        WHEN "0111001" =>
          result := input_57;
        WHEN "0111010" =>
          result := input_58;
        WHEN "0111011" =>
          result := input_59;
        WHEN "0111100" =>
          result := input_60;
        WHEN "0111101" =>
          result := input_61;
        WHEN "0111110" =>
          result := input_62;
        WHEN "0111111" =>
          result := input_63;
        WHEN "1000000" =>
          result := input_64;
        WHEN "1000001" =>
          result := input_65;
        WHEN "1000010" =>
          result := input_66;
        WHEN "1000011" =>
          result := input_67;
        WHEN "1000100" =>
          result := input_68;
        WHEN "1000101" =>
          result := input_69;
        WHEN "1000110" =>
          result := input_70;
        WHEN "1000111" =>
          result := input_71;
        WHEN "1001000" =>
          result := input_72;
        WHEN "1001001" =>
          result := input_73;
        WHEN "1001010" =>
          result := input_74;
        WHEN "1001011" =>
          result := input_75;
        WHEN "1001100" =>
          result := input_76;
        WHEN "1001101" =>
          result := input_77;
        WHEN "1001110" =>
          result := input_78;
        WHEN "1001111" =>
          result := input_79;
        WHEN "1010000" =>
          result := input_80;
        WHEN "1010001" =>
          result := input_81;
        WHEN "1010010" =>
          result := input_82;
        WHEN "1010011" =>
          result := input_83;
        WHEN "1010100" =>
          result := input_84;
        WHEN "1010101" =>
          result := input_85;
        WHEN "1010110" =>
          result := input_86;
        WHEN "1010111" =>
          result := input_87;
        WHEN "1011000" =>
          result := input_88;
        WHEN "1011001" =>
          result := input_89;
        WHEN "1011010" =>
          result := input_90;
        WHEN "1011011" =>
          result := input_91;
        WHEN "1011100" =>
          result := input_92;
        WHEN "1011101" =>
          result := input_93;
        WHEN "1011110" =>
          result := input_94;
        WHEN "1011111" =>
          result := input_95;
        WHEN "1100000" =>
          result := input_96;
        WHEN "1100001" =>
          result := input_97;
        WHEN "1100010" =>
          result := input_98;
        WHEN "1100011" =>
          result := input_99;
        WHEN "1100100" =>
          result := input_100;
        WHEN "1100101" =>
          result := input_101;
        WHEN "1100110" =>
          result := input_102;
        WHEN "1100111" =>
          result := input_103;
        WHEN "1101000" =>
          result := input_104;
        WHEN "1101001" =>
          result := input_105;
        WHEN "1101010" =>
          result := input_106;
        WHEN "1101011" =>
          result := input_107;
        WHEN "1101100" =>
          result := input_108;
        WHEN "1101101" =>
          result := input_109;
        WHEN "1101110" =>
          result := input_110;
        WHEN "1101111" =>
          result := input_111;
        WHEN "1110000" =>
          result := input_112;
        WHEN "1110001" =>
          result := input_113;
        WHEN "1110010" =>
          result := input_114;
        WHEN "1110011" =>
          result := input_115;
        WHEN "1110100" =>
          result := input_116;
        WHEN "1110101" =>
          result := input_117;
        WHEN "1110110" =>
          result := input_118;
        WHEN "1110111" =>
          result := input_119;
        WHEN "1111000" =>
          result := input_120;
        WHEN "1111001" =>
          result := input_121;
        WHEN "1111010" =>
          result := input_122;
        WHEN "1111011" =>
          result := input_123;
        WHEN "1111100" =>
          result := input_124;
        WHEN "1111101" =>
          result := input_125;
        WHEN others =>
          result := input_126;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_3_2_2(input_0 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(2 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_7_2_2(input_0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(6 DOWNTO 0);

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
  i_sample_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 1,
      width => 3
      )
    PORT MAP(
      dat => i_sample_rsci_dat,
      idat => i_sample_rsci_idat_1
    );
  i_sample_rsci_dat <= i_sample_rsc_dat;
  i_sample_rsci_idat <= i_sample_rsci_idat_1;

  b_rsci : work.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 2,
      width => 1270
      )
    PORT MAP(
      dat => b_rsci_dat,
      idat => b_rsci_idat_1
    );
  b_rsci_dat <= b_rsc_dat;
  b_rsci_idat <= b_rsci_idat_1;

  y_rsci : work.ccs_out_pkg_v1.ccs_out_v1
    GENERIC MAP(
      rscid => 3,
      width => 9
      )
    PORT MAP(
      idat => y_rsci_idat,
      dat => y_rsci_dat
    );
  y_rsci_idat <= y_rsci_idat_8 & y_rsci_idat_7_1 & y_rsci_idat_0;
  y_rsc_dat <= y_rsci_dat;

  i_sample_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_b_rsc_triosy_obj_ld_cse,
      lz => i_sample_rsc_triosy_lz
    );
  b_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_b_rsc_triosy_obj_ld_cse,
      lz => b_rsc_triosy_lz
    );
  y_rsc_triosy_obj : work.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => y_rsc_triosy_obj_ld,
      lz => y_rsc_triosy_lz
    );
  fir_filter_core_core_fsm_inst : fir_filter_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => fir_filter_core_core_fsm_inst_fsm_output,
      SHIFT_LOOP_C_0_tr0 => fir_filter_core_core_fsm_inst_SHIFT_LOOP_C_0_tr0,
      MAC_LOOP_C_0_tr0 => fir_filter_core_core_fsm_inst_MAC_LOOP_C_0_tr0
    );
  fsm_output <= fir_filter_core_core_fsm_inst_fsm_output;
  fir_filter_core_core_fsm_inst_SHIFT_LOOP_C_0_tr0 <= NOT z_out_1_7;
  fir_filter_core_core_fsm_inst_MAC_LOOP_C_0_tr0 <= NOT z_out_1_7;

  nor_ovfl_sva_1 <= NOT((z_out_3(14)) OR (NOT(CONV_SL_1_1(z_out_3(13 DOWNTO 8)/=STD_LOGIC_VECTOR'("000000")))));
  and_unfl_sva_1 <= (z_out_3(14)) AND (NOT(CONV_SL_1_1(z_out_3(13 DOWNTO 8)=STD_LOGIC_VECTOR'("111111"))
      AND (CONV_SL_1_1(z_out_3(7 DOWNTO 0)/=STD_LOGIC_VECTOR'("00000000")))));
  or_dcpl_9 <= NOT(CONV_SL_1_1(MAC_LOOP_n_6_0_sva(6 DOWNTO 5)=STD_LOGIC_VECTOR'("11")));
  or_dcpl_10 <= or_dcpl_9 OR (MAC_LOOP_n_6_0_sva(0));
  or_dcpl_11 <= NOT(CONV_SL_1_1(MAC_LOOP_n_6_0_sva(4 DOWNTO 3)=STD_LOGIC_VECTOR'("11")));
  or_dcpl_12 <= NOT(CONV_SL_1_1(MAC_LOOP_n_6_0_sva(2 DOWNTO 1)=STD_LOGIC_VECTOR'("11")));
  or_dcpl_13 <= or_dcpl_12 OR or_dcpl_11;
  or_dcpl_15 <= or_dcpl_9 OR (NOT (MAC_LOOP_n_6_0_sva(0)));
  or_dcpl_16 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("10"));
  or_dcpl_17 <= or_dcpl_16 OR or_dcpl_11;
  or_dcpl_19 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_20 <= or_dcpl_19 OR (NOT (MAC_LOOP_n_6_0_sva(0)));
  or_dcpl_21 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_22 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"));
  or_dcpl_23 <= or_dcpl_22 OR or_dcpl_21;
  or_dcpl_26 <= or_dcpl_19 OR (MAC_LOOP_n_6_0_sva(0));
  or_dcpl_27 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("01"));
  or_dcpl_28 <= or_dcpl_27 OR or_dcpl_21;
  or_dcpl_30 <= or_dcpl_27 OR or_dcpl_11;
  or_dcpl_34 <= or_dcpl_16 OR or_dcpl_21;
  or_dcpl_36 <= or_dcpl_22 OR or_dcpl_11;
  or_dcpl_40 <= or_dcpl_12 OR or_dcpl_21;
  or_dcpl_42 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("10"));
  or_dcpl_43 <= or_dcpl_12 OR or_dcpl_42;
  or_dcpl_47 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("01"));
  or_dcpl_48 <= or_dcpl_22 OR or_dcpl_47;
  or_dcpl_50 <= or_dcpl_16 OR or_dcpl_42;
  or_dcpl_54 <= or_dcpl_27 OR or_dcpl_47;
  or_dcpl_56 <= or_dcpl_27 OR or_dcpl_42;
  or_dcpl_60 <= or_dcpl_16 OR or_dcpl_47;
  or_dcpl_62 <= or_dcpl_22 OR or_dcpl_42;
  or_dcpl_66 <= or_dcpl_12 OR or_dcpl_47;
  or_dcpl_100 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("10"));
  or_dcpl_101 <= or_dcpl_100 OR (NOT (MAC_LOOP_n_6_0_sva(0)));
  or_dcpl_104 <= or_dcpl_100 OR (MAC_LOOP_n_6_0_sva(0));
  or_dcpl_106 <= CONV_SL_1_1(MAC_LOOP_n_6_0_sva(6 DOWNTO 5)/=STD_LOGIC_VECTOR'("01"));
  or_dcpl_107 <= or_dcpl_106 OR (MAC_LOOP_n_6_0_sva(0));
  or_dcpl_110 <= or_dcpl_106 OR (NOT (MAC_LOOP_n_6_0_sva(0)));
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        y_rsci_idat_0 <= '0';
      ELSIF ( (fsm_output(3)) = '1' ) THEN
        y_rsci_idat_0 <= (z_out_3(0)) OR nor_ovfl_sva_1 OR and_unfl_sva_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        y_rsci_idat_7_1 <= STD_LOGIC_VECTOR'( "0000000");
      ELSIF ( (fsm_output(3)) = '1' ) THEN
        y_rsci_idat_7_1 <= NOT(MUX_v_7_2_2(nor_5_nl, STD_LOGIC_VECTOR'("1111111"),
            and_unfl_sva_1));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        y_rsci_idat_8 <= '0';
      ELSIF ( (fsm_output(3)) = '1' ) THEN
        y_rsci_idat_8 <= z_out_3(14);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        i_sample_sva <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT(CONV_SL_1_1(fsm_output(2 DOWNTO 1)/=STD_LOGIC_VECTOR'("00"))))
          = '1' ) THEN
        i_sample_sva <= i_sample_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_126_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT(or_dcpl_13 OR or_dcpl_10 OR (fsm_output(2)))) = '1' ) THEN
        x_126_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_125_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_15)) = '1' ) THEN
        x_125_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_1_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_23 OR or_dcpl_20)) = '1' ) THEN
        x_1_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_124_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_10)) = '1' ) THEN
        x_124_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_2_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_26)) = '1' ) THEN
        x_2_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_123_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_15)) = '1' ) THEN
        x_123_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_3_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_20)) = '1' ) THEN
        x_3_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_122_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_10)) = '1' ) THEN
        x_122_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_4_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_26)) = '1' ) THEN
        x_4_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_121_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_15)) = '1' ) THEN
        x_121_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_5_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_20)) = '1' ) THEN
        x_5_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_120_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_10)) = '1' ) THEN
        x_120_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_6_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_26)) = '1' ) THEN
        x_6_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_119_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_15)) = '1' ) THEN
        x_119_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_7_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_20)) = '1' ) THEN
        x_7_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_118_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_10)) = '1' ) THEN
        x_118_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_8_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_26)) = '1' ) THEN
        x_8_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_117_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_15)) = '1' ) THEN
        x_117_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_9_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_20)) = '1' ) THEN
        x_9_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_116_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_10)) = '1' ) THEN
        x_116_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_10_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_26)) = '1' ) THEN
        x_10_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_115_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_15)) = '1' ) THEN
        x_115_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_11_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_20)) = '1' ) THEN
        x_11_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_114_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_10)) = '1' ) THEN
        x_114_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_12_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_26)) = '1' ) THEN
        x_12_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_113_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_15)) = '1' ) THEN
        x_113_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_13_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_20)) = '1' ) THEN
        x_13_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_112_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_10)) = '1' ) THEN
        x_112_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_14_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_26)) = '1' ) THEN
        x_14_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_111_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_15)) = '1' ) THEN
        x_111_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_15_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_20)) = '1' ) THEN
        x_15_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_110_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_10)) = '1' ) THEN
        x_110_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_16_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_26)) = '1' ) THEN
        x_16_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_109_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_15)) = '1' ) THEN
        x_109_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_17_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_20)) = '1' ) THEN
        x_17_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_108_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_10)) = '1' ) THEN
        x_108_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_18_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_26)) = '1' ) THEN
        x_18_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_107_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_15)) = '1' ) THEN
        x_107_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_19_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_20)) = '1' ) THEN
        x_19_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_106_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_10)) = '1' ) THEN
        x_106_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_20_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_26)) = '1' ) THEN
        x_20_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_105_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_15)) = '1' ) THEN
        x_105_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_21_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_20)) = '1' ) THEN
        x_21_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_104_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_10)) = '1' ) THEN
        x_104_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_22_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_26)) = '1' ) THEN
        x_22_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_103_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_15)) = '1' ) THEN
        x_103_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_23_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_20)) = '1' ) THEN
        x_23_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_102_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_10)) = '1' ) THEN
        x_102_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_24_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_26)) = '1' ) THEN
        x_24_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_101_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_15)) = '1' ) THEN
        x_101_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_25_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_20)) = '1' ) THEN
        x_25_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_100_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_10)) = '1' ) THEN
        x_100_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_26_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_26)) = '1' ) THEN
        x_26_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_99_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_15)) = '1' ) THEN
        x_99_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_27_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_20)) = '1' ) THEN
        x_27_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_98_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_10)) = '1' ) THEN
        x_98_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_28_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_26)) = '1' ) THEN
        x_28_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_97_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_23 OR or_dcpl_15)) = '1' ) THEN
        x_97_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_29_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_20)) = '1' ) THEN
        x_29_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_96_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_23 OR or_dcpl_10)) = '1' ) THEN
        x_96_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_30_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_13 OR or_dcpl_26)) = '1' ) THEN
        x_30_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_95_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_13 OR or_dcpl_101)) = '1' ) THEN
        x_95_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_31_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_13 OR or_dcpl_20)) = '1' ) THEN
        x_31_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_94_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_13 OR or_dcpl_104)) = '1' ) THEN
        x_94_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_32_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_23 OR or_dcpl_107)) = '1' ) THEN
        x_32_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_93_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_101)) = '1' ) THEN
        x_93_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_33_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_23 OR or_dcpl_110)) = '1' ) THEN
        x_33_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_92_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_104)) = '1' ) THEN
        x_92_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_34_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_107)) = '1' ) THEN
        x_34_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_91_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_101)) = '1' ) THEN
        x_91_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_35_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_110)) = '1' ) THEN
        x_35_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_90_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_104)) = '1' ) THEN
        x_90_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_36_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_107)) = '1' ) THEN
        x_36_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_89_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_101)) = '1' ) THEN
        x_89_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_37_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_110)) = '1' ) THEN
        x_37_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_88_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_104)) = '1' ) THEN
        x_88_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_38_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_107)) = '1' ) THEN
        x_38_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_87_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_101)) = '1' ) THEN
        x_87_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_39_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_110)) = '1' ) THEN
        x_39_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_86_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_104)) = '1' ) THEN
        x_86_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_40_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_107)) = '1' ) THEN
        x_40_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_85_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_101)) = '1' ) THEN
        x_85_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_41_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_110)) = '1' ) THEN
        x_41_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_84_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_104)) = '1' ) THEN
        x_84_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_42_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_107)) = '1' ) THEN
        x_42_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_83_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_101)) = '1' ) THEN
        x_83_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_43_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_110)) = '1' ) THEN
        x_43_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_82_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_104)) = '1' ) THEN
        x_82_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_44_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_107)) = '1' ) THEN
        x_44_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_81_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_101)) = '1' ) THEN
        x_81_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_45_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_110)) = '1' ) THEN
        x_45_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_80_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_104)) = '1' ) THEN
        x_80_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_46_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_107)) = '1' ) THEN
        x_46_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_79_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_101)) = '1' ) THEN
        x_79_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_47_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_110)) = '1' ) THEN
        x_47_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_78_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_66 OR or_dcpl_104)) = '1' ) THEN
        x_78_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_48_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_107)) = '1' ) THEN
        x_48_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_77_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_101)) = '1' ) THEN
        x_77_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_49_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_62 OR or_dcpl_110)) = '1' ) THEN
        x_49_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_76_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_60 OR or_dcpl_104)) = '1' ) THEN
        x_76_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_50_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_107)) = '1' ) THEN
        x_50_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_75_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_101)) = '1' ) THEN
        x_75_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_51_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_56 OR or_dcpl_110)) = '1' ) THEN
        x_51_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_74_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_54 OR or_dcpl_104)) = '1' ) THEN
        x_74_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_52_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_107)) = '1' ) THEN
        x_52_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_73_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_101)) = '1' ) THEN
        x_73_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_53_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_50 OR or_dcpl_110)) = '1' ) THEN
        x_53_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_72_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_48 OR or_dcpl_104)) = '1' ) THEN
        x_72_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_54_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_107)) = '1' ) THEN
        x_54_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_71_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_101)) = '1' ) THEN
        x_71_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_55_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_43 OR or_dcpl_110)) = '1' ) THEN
        x_55_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_70_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_40 OR or_dcpl_104)) = '1' ) THEN
        x_70_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_56_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_107)) = '1' ) THEN
        x_56_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_69_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_101)) = '1' ) THEN
        x_69_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_57_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_36 OR or_dcpl_110)) = '1' ) THEN
        x_57_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_68_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_34 OR or_dcpl_104)) = '1' ) THEN
        x_68_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_58_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_107)) = '1' ) THEN
        x_58_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_67_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_101)) = '1' ) THEN
        x_67_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_59_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_30 OR or_dcpl_110)) = '1' ) THEN
        x_59_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_66_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_28 OR or_dcpl_104)) = '1' ) THEN
        x_66_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_60_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_107)) = '1' ) THEN
        x_60_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_65_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_23 OR or_dcpl_101)) = '1' ) THEN
        x_65_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_61_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_17 OR or_dcpl_110)) = '1' ) THEN
        x_61_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_64_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_23 OR or_dcpl_104)) = '1' ) THEN
        x_64_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_62_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_13 OR or_dcpl_107)) = '1' ) THEN
        x_62_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_63_lpi_2 <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (NOT((NOT (fsm_output(1))) OR or_dcpl_13 OR or_dcpl_110)) = '1' ) THEN
        x_63_lpi_2 <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        x_0_sva <= STD_LOGIC_VECTOR'( "000");
      ELSIF ( (fsm_output(2)) = '1' ) THEN
        x_0_sva <= i_sample_sva;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        y_rsc_triosy_obj_ld <= '0';
        reg_b_rsc_triosy_obj_ld_cse <= '0';
        MAC_LOOP_n_6_0_sva <= STD_LOGIC_VECTOR'( "0000000");
        sum_sva <= STD_LOGIC_VECTOR'( "00000000000000000000");
      ELSE
        y_rsc_triosy_obj_ld <= fsm_output(3);
        reg_b_rsc_triosy_obj_ld_cse <= (NOT z_out_1_7) AND (fsm_output(2));
        MAC_LOOP_n_6_0_sva <= MUX_v_7_2_2(STD_LOGIC_VECTOR'("0000000"), SHIFT_LOOP_n_SHIFT_LOOP_n_mux_nl,
            MAC_LOOP_n_nor_nl);
        sum_sva <= MUX_v_20_2_2(STD_LOGIC_VECTOR'("00000000000000000000"), z_out_3,
            (fsm_output(2)));
      END IF;
    END IF;
  END PROCESS;
  nor_5_nl <= NOT(MUX_v_7_2_2((z_out_3(7 DOWNTO 1)), STD_LOGIC_VECTOR'("1111111"),
      nor_ovfl_sva_1));
  SHIFT_LOOP_n_or_nl <= (z_out_1_7 AND (fsm_output(1))) OR (fsm_output(2));
  SHIFT_LOOP_n_SHIFT_LOOP_n_mux_nl <= MUX_v_7_2_2(STD_LOGIC_VECTOR'( "1111110"),
      z_out_2, SHIFT_LOOP_n_or_nl);
  MAC_LOOP_n_nor_nl <= NOT(CONV_SL_1_1(fsm_output(4 DOWNTO 3)/=STD_LOGIC_VECTOR'("00"))
      OR ((NOT z_out_1_7) AND (fsm_output(1))));
  SHIFT_LOOP_mux_129_nl <= MUX_v_7_2_2((NOT z_out_2), z_out_2, fsm_output(2));
  SHIFT_LOOP_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED('1' & SHIFT_LOOP_mux_129_nl)
      + UNSIGNED'( "00000001"), 8));
  z_out_1_7 <= SHIFT_LOOP_acc_nl(7);
  z_out_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(MAC_LOOP_n_6_0_sva) + CONV_UNSIGNED(CONV_SIGNED(SIGNED'(
      (fsm_output(1)) & '1'), 2), 7), 7));
  MAC_LOOP_mux_7_nl <= MUX_v_19_2_2((sum_sva(18 DOWNTO 0)), STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(sum_sva(19
      DOWNTO 6)),19)), fsm_output(3));
  MAC_LOOP_mux_9_nl <= MUX_v_10_127_2((b_rsci_idat(9 DOWNTO 0)), (b_rsci_idat(19
      DOWNTO 10)), (b_rsci_idat(29 DOWNTO 20)), (b_rsci_idat(39 DOWNTO 30)), (b_rsci_idat(49
      DOWNTO 40)), (b_rsci_idat(59 DOWNTO 50)), (b_rsci_idat(69 DOWNTO 60)), (b_rsci_idat(79
      DOWNTO 70)), (b_rsci_idat(89 DOWNTO 80)), (b_rsci_idat(99 DOWNTO 90)), (b_rsci_idat(109
      DOWNTO 100)), (b_rsci_idat(119 DOWNTO 110)), (b_rsci_idat(129 DOWNTO 120)),
      (b_rsci_idat(139 DOWNTO 130)), (b_rsci_idat(149 DOWNTO 140)), (b_rsci_idat(159
      DOWNTO 150)), (b_rsci_idat(169 DOWNTO 160)), (b_rsci_idat(179 DOWNTO 170)),
      (b_rsci_idat(189 DOWNTO 180)), (b_rsci_idat(199 DOWNTO 190)), (b_rsci_idat(209
      DOWNTO 200)), (b_rsci_idat(219 DOWNTO 210)), (b_rsci_idat(229 DOWNTO 220)),
      (b_rsci_idat(239 DOWNTO 230)), (b_rsci_idat(249 DOWNTO 240)), (b_rsci_idat(259
      DOWNTO 250)), (b_rsci_idat(269 DOWNTO 260)), (b_rsci_idat(279 DOWNTO 270)),
      (b_rsci_idat(289 DOWNTO 280)), (b_rsci_idat(299 DOWNTO 290)), (b_rsci_idat(309
      DOWNTO 300)), (b_rsci_idat(319 DOWNTO 310)), (b_rsci_idat(329 DOWNTO 320)),
      (b_rsci_idat(339 DOWNTO 330)), (b_rsci_idat(349 DOWNTO 340)), (b_rsci_idat(359
      DOWNTO 350)), (b_rsci_idat(369 DOWNTO 360)), (b_rsci_idat(379 DOWNTO 370)),
      (b_rsci_idat(389 DOWNTO 380)), (b_rsci_idat(399 DOWNTO 390)), (b_rsci_idat(409
      DOWNTO 400)), (b_rsci_idat(419 DOWNTO 410)), (b_rsci_idat(429 DOWNTO 420)),
      (b_rsci_idat(439 DOWNTO 430)), (b_rsci_idat(449 DOWNTO 440)), (b_rsci_idat(459
      DOWNTO 450)), (b_rsci_idat(469 DOWNTO 460)), (b_rsci_idat(479 DOWNTO 470)),
      (b_rsci_idat(489 DOWNTO 480)), (b_rsci_idat(499 DOWNTO 490)), (b_rsci_idat(509
      DOWNTO 500)), (b_rsci_idat(519 DOWNTO 510)), (b_rsci_idat(529 DOWNTO 520)),
      (b_rsci_idat(539 DOWNTO 530)), (b_rsci_idat(549 DOWNTO 540)), (b_rsci_idat(559
      DOWNTO 550)), (b_rsci_idat(569 DOWNTO 560)), (b_rsci_idat(579 DOWNTO 570)),
      (b_rsci_idat(589 DOWNTO 580)), (b_rsci_idat(599 DOWNTO 590)), (b_rsci_idat(609
      DOWNTO 600)), (b_rsci_idat(619 DOWNTO 610)), (b_rsci_idat(629 DOWNTO 620)),
      (b_rsci_idat(639 DOWNTO 630)), (b_rsci_idat(649 DOWNTO 640)), (b_rsci_idat(659
      DOWNTO 650)), (b_rsci_idat(669 DOWNTO 660)), (b_rsci_idat(679 DOWNTO 670)),
      (b_rsci_idat(689 DOWNTO 680)), (b_rsci_idat(699 DOWNTO 690)), (b_rsci_idat(709
      DOWNTO 700)), (b_rsci_idat(719 DOWNTO 710)), (b_rsci_idat(729 DOWNTO 720)),
      (b_rsci_idat(739 DOWNTO 730)), (b_rsci_idat(749 DOWNTO 740)), (b_rsci_idat(759
      DOWNTO 750)), (b_rsci_idat(769 DOWNTO 760)), (b_rsci_idat(779 DOWNTO 770)),
      (b_rsci_idat(789 DOWNTO 780)), (b_rsci_idat(799 DOWNTO 790)), (b_rsci_idat(809
      DOWNTO 800)), (b_rsci_idat(819 DOWNTO 810)), (b_rsci_idat(829 DOWNTO 820)),
      (b_rsci_idat(839 DOWNTO 830)), (b_rsci_idat(849 DOWNTO 840)), (b_rsci_idat(859
      DOWNTO 850)), (b_rsci_idat(869 DOWNTO 860)), (b_rsci_idat(879 DOWNTO 870)),
      (b_rsci_idat(889 DOWNTO 880)), (b_rsci_idat(899 DOWNTO 890)), (b_rsci_idat(909
      DOWNTO 900)), (b_rsci_idat(919 DOWNTO 910)), (b_rsci_idat(929 DOWNTO 920)),
      (b_rsci_idat(939 DOWNTO 930)), (b_rsci_idat(949 DOWNTO 940)), (b_rsci_idat(959
      DOWNTO 950)), (b_rsci_idat(969 DOWNTO 960)), (b_rsci_idat(979 DOWNTO 970)),
      (b_rsci_idat(989 DOWNTO 980)), (b_rsci_idat(999 DOWNTO 990)), (b_rsci_idat(1009
      DOWNTO 1000)), (b_rsci_idat(1019 DOWNTO 1010)), (b_rsci_idat(1029 DOWNTO 1020)),
      (b_rsci_idat(1039 DOWNTO 1030)), (b_rsci_idat(1049 DOWNTO 1040)), (b_rsci_idat(1059
      DOWNTO 1050)), (b_rsci_idat(1069 DOWNTO 1060)), (b_rsci_idat(1079 DOWNTO 1070)),
      (b_rsci_idat(1089 DOWNTO 1080)), (b_rsci_idat(1099 DOWNTO 1090)), (b_rsci_idat(1109
      DOWNTO 1100)), (b_rsci_idat(1119 DOWNTO 1110)), (b_rsci_idat(1129 DOWNTO 1120)),
      (b_rsci_idat(1139 DOWNTO 1130)), (b_rsci_idat(1149 DOWNTO 1140)), (b_rsci_idat(1159
      DOWNTO 1150)), (b_rsci_idat(1169 DOWNTO 1160)), (b_rsci_idat(1179 DOWNTO 1170)),
      (b_rsci_idat(1189 DOWNTO 1180)), (b_rsci_idat(1199 DOWNTO 1190)), (b_rsci_idat(1209
      DOWNTO 1200)), (b_rsci_idat(1219 DOWNTO 1210)), (b_rsci_idat(1229 DOWNTO 1220)),
      (b_rsci_idat(1239 DOWNTO 1230)), (b_rsci_idat(1249 DOWNTO 1240)), (b_rsci_idat(1259
      DOWNTO 1250)), (b_rsci_idat(1269 DOWNTO 1260)), MAC_LOOP_n_6_0_sva);
  MAC_LOOP_mul_1_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED'( SIGNED(z_out) * SIGNED(MAC_LOOP_mux_9_nl)),
      13));
  MAC_LOOP_mux_8_nl <= MUX_v_13_2_2(STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(MAC_LOOP_mul_1_nl),
      13)), (STD_LOGIC_VECTOR'( "000000000000") & (sum_sva(5))), fsm_output(3));
  z_out_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED((sum_sva(19)) & MAC_LOOP_mux_7_nl)
      + CONV_UNSIGNED(SIGNED(MAC_LOOP_mux_8_nl), 20), 20));
  MAC_LOOP_mux_10_nl <= MUX_v_3_2_2(i_sample_sva, x_0_sva, fsm_output(1));
  MAC_LOOP_mux_11_nl <= MUX_v_7_2_2(MAC_LOOP_n_6_0_sva, z_out_2, fsm_output(1));
  z_out <= MUX_v_3_127_2(MAC_LOOP_mux_10_nl, x_1_lpi_2, x_2_lpi_2, x_3_lpi_2, x_4_lpi_2,
      x_5_lpi_2, x_6_lpi_2, x_7_lpi_2, x_8_lpi_2, x_9_lpi_2, x_10_lpi_2, x_11_lpi_2,
      x_12_lpi_2, x_13_lpi_2, x_14_lpi_2, x_15_lpi_2, x_16_lpi_2, x_17_lpi_2, x_18_lpi_2,
      x_19_lpi_2, x_20_lpi_2, x_21_lpi_2, x_22_lpi_2, x_23_lpi_2, x_24_lpi_2, x_25_lpi_2,
      x_26_lpi_2, x_27_lpi_2, x_28_lpi_2, x_29_lpi_2, x_30_lpi_2, x_31_lpi_2, x_32_lpi_2,
      x_33_lpi_2, x_34_lpi_2, x_35_lpi_2, x_36_lpi_2, x_37_lpi_2, x_38_lpi_2, x_39_lpi_2,
      x_40_lpi_2, x_41_lpi_2, x_42_lpi_2, x_43_lpi_2, x_44_lpi_2, x_45_lpi_2, x_46_lpi_2,
      x_47_lpi_2, x_48_lpi_2, x_49_lpi_2, x_50_lpi_2, x_51_lpi_2, x_52_lpi_2, x_53_lpi_2,
      x_54_lpi_2, x_55_lpi_2, x_56_lpi_2, x_57_lpi_2, x_58_lpi_2, x_59_lpi_2, x_60_lpi_2,
      x_61_lpi_2, x_62_lpi_2, x_63_lpi_2, x_64_lpi_2, x_65_lpi_2, x_66_lpi_2, x_67_lpi_2,
      x_68_lpi_2, x_69_lpi_2, x_70_lpi_2, x_71_lpi_2, x_72_lpi_2, x_73_lpi_2, x_74_lpi_2,
      x_75_lpi_2, x_76_lpi_2, x_77_lpi_2, x_78_lpi_2, x_79_lpi_2, x_80_lpi_2, x_81_lpi_2,
      x_82_lpi_2, x_83_lpi_2, x_84_lpi_2, x_85_lpi_2, x_86_lpi_2, x_87_lpi_2, x_88_lpi_2,
      x_89_lpi_2, x_90_lpi_2, x_91_lpi_2, x_92_lpi_2, x_93_lpi_2, x_94_lpi_2, x_95_lpi_2,
      x_96_lpi_2, x_97_lpi_2, x_98_lpi_2, x_99_lpi_2, x_100_lpi_2, x_101_lpi_2, x_102_lpi_2,
      x_103_lpi_2, x_104_lpi_2, x_105_lpi_2, x_106_lpi_2, x_107_lpi_2, x_108_lpi_2,
      x_109_lpi_2, x_110_lpi_2, x_111_lpi_2, x_112_lpi_2, x_113_lpi_2, x_114_lpi_2,
      x_115_lpi_2, x_116_lpi_2, x_117_lpi_2, x_118_lpi_2, x_119_lpi_2, x_120_lpi_2,
      x_121_lpi_2, x_122_lpi_2, x_123_lpi_2, x_124_lpi_2, x_125_lpi_2, x_126_lpi_2,
      MAC_LOOP_mux_11_nl);
END v1;

-- ------------------------------------------------------------------
--  Design Unit:    fir_filter
-- ------------------------------------------------------------------

LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

USE work.ccs_in_pkg_v1.ALL;
USE work.ccs_out_pkg_v1.ALL;
USE work.mgc_io_sync_pkg_v2.ALL;


ENTITY fir_filter IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    i_sample_rsc_dat : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    i_sample_rsc_triosy_lz : OUT STD_LOGIC;
    b_rsc_dat : IN STD_LOGIC_VECTOR (1269 DOWNTO 0);
    b_rsc_triosy_lz : OUT STD_LOGIC;
    y_rsc_dat : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
    y_rsc_triosy_lz : OUT STD_LOGIC
  );
END fir_filter;

ARCHITECTURE v1 OF fir_filter IS
  -- Default Constants

  COMPONENT fir_filter_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      i_sample_rsc_dat : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
      i_sample_rsc_triosy_lz : OUT STD_LOGIC;
      b_rsc_dat : IN STD_LOGIC_VECTOR (1269 DOWNTO 0);
      b_rsc_triosy_lz : OUT STD_LOGIC;
      y_rsc_dat : OUT STD_LOGIC_VECTOR (8 DOWNTO 0);
      y_rsc_triosy_lz : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL fir_filter_core_inst_i_sample_rsc_dat : STD_LOGIC_VECTOR (2 DOWNTO 0);
  SIGNAL fir_filter_core_inst_b_rsc_dat : STD_LOGIC_VECTOR (1269 DOWNTO 0);
  SIGNAL fir_filter_core_inst_y_rsc_dat : STD_LOGIC_VECTOR (8 DOWNTO 0);

BEGIN
  fir_filter_core_inst : fir_filter_core
    PORT MAP(
      clk => clk,
      rst => rst,
      i_sample_rsc_dat => fir_filter_core_inst_i_sample_rsc_dat,
      i_sample_rsc_triosy_lz => i_sample_rsc_triosy_lz,
      b_rsc_dat => fir_filter_core_inst_b_rsc_dat,
      b_rsc_triosy_lz => b_rsc_triosy_lz,
      y_rsc_dat => fir_filter_core_inst_y_rsc_dat,
      y_rsc_triosy_lz => y_rsc_triosy_lz
    );
  fir_filter_core_inst_i_sample_rsc_dat <= i_sample_rsc_dat;
  fir_filter_core_inst_b_rsc_dat <= b_rsc_dat;
  y_rsc_dat <= fir_filter_core_inst_y_rsc_dat;

END v1;



