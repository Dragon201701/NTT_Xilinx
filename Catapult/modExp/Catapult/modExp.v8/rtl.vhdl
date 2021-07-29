-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.5c/896140 Production Release
--  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
-- 
--  Generated by:   yl7897@newnano.poly.edu
--  Generated date: Thu Jul 15 15:14:29 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    modExp_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_inout_prereg_en_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_comps.ALL;


ENTITY modExp_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (30 DOWNTO 0);
    main_C_1_tr0 : IN STD_LOGIC;
    while_C_26_tr0 : IN STD_LOGIC
  );
END modExp_core_core_fsm;

ARCHITECTURE v8 OF modExp_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for modExp_core_core_fsm_1
  TYPE modExp_core_core_fsm_1_ST IS (core_rlp_C_0, main_C_0, main_C_1, while_C_0,
      while_C_1, while_C_2, while_C_3, while_C_4, while_C_5, while_C_6, while_C_7,
      while_C_8, while_C_9, while_C_10, while_C_11, while_C_12, while_C_13, while_C_14,
      while_C_15, while_C_16, while_C_17, while_C_18, while_C_19, while_C_20, while_C_21,
      while_C_22, while_C_23, while_C_24, while_C_25, while_C_26, main_C_2);

  SIGNAL state_var : modExp_core_core_fsm_1_ST;
  SIGNAL state_var_NS : modExp_core_core_fsm_1_ST;

BEGIN
  modExp_core_core_fsm_1 : PROCESS (main_C_1_tr0, while_C_26_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN main_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000010");
        state_var_NS <= main_C_1;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000100");
        IF ( main_C_1_tr0 = '1' ) THEN
          state_var_NS <= main_C_2;
        ELSE
          state_var_NS <= while_C_0;
        END IF;
      WHEN while_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000001000");
        state_var_NS <= while_C_1;
      WHEN while_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000010000");
        state_var_NS <= while_C_2;
      WHEN while_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000100000");
        state_var_NS <= while_C_3;
      WHEN while_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000001000000");
        state_var_NS <= while_C_4;
      WHEN while_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000010000000");
        state_var_NS <= while_C_5;
      WHEN while_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000100000000");
        state_var_NS <= while_C_6;
      WHEN while_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000001000000000");
        state_var_NS <= while_C_7;
      WHEN while_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000010000000000");
        state_var_NS <= while_C_8;
      WHEN while_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000100000000000");
        state_var_NS <= while_C_9;
      WHEN while_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000001000000000000");
        state_var_NS <= while_C_10;
      WHEN while_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000010000000000000");
        state_var_NS <= while_C_11;
      WHEN while_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000100000000000000");
        state_var_NS <= while_C_12;
      WHEN while_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000001000000000000000");
        state_var_NS <= while_C_13;
      WHEN while_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000010000000000000000");
        state_var_NS <= while_C_14;
      WHEN while_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000100000000000000000");
        state_var_NS <= while_C_15;
      WHEN while_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000001000000000000000000");
        state_var_NS <= while_C_16;
      WHEN while_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000010000000000000000000");
        state_var_NS <= while_C_17;
      WHEN while_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000100000000000000000000");
        state_var_NS <= while_C_18;
      WHEN while_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000001000000000000000000000");
        state_var_NS <= while_C_19;
      WHEN while_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000010000000000000000000000");
        state_var_NS <= while_C_20;
      WHEN while_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000100000000000000000000000");
        state_var_NS <= while_C_21;
      WHEN while_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001000000000000000000000000");
        state_var_NS <= while_C_22;
      WHEN while_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010000000000000000000000000");
        state_var_NS <= while_C_23;
      WHEN while_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100000000000000000000000000");
        state_var_NS <= while_C_24;
      WHEN while_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000000000000000000000000000");
        state_var_NS <= while_C_25;
      WHEN while_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000000000000000000000000000");
        state_var_NS <= while_C_26;
      WHEN while_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000000000000000000000000000");
        IF ( while_C_26_tr0 = '1' ) THEN
          state_var_NS <= main_C_2;
        ELSE
          state_var_NS <= while_C_0;
        END IF;
      WHEN main_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000000000000000000000000000");
        state_var_NS <= main_C_0;
      -- core_rlp_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000001");
        state_var_NS <= main_C_0;
    END CASE;
  END PROCESS modExp_core_core_fsm_1;

  modExp_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= core_rlp_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS modExp_core_core_fsm_1_REG;

END v8;

-- ------------------------------------------------------------------
--  Design Unit:    modExp_core
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_inout_prereg_en_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_comps.ALL;


ENTITY modExp_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    base_rsc_triosy_lz : OUT STD_LOGIC;
    exp_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    exp_rsc_triosy_lz : OUT STD_LOGIC;
    m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    m_rsc_triosy_lz : OUT STD_LOGIC;
    result_rsc_zout : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    result_rsc_lzout : OUT STD_LOGIC;
    result_rsc_zin : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    result_rsc_triosy_lz : OUT STD_LOGIC
  );
END modExp_core;

ARCHITECTURE v8 OF modExp_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL base_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL exp_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL result_rsci_din : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL while_rem_cmp_a : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL while_rem_cmp_b : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL while_rem_cmp_z : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL fsm_output : STD_LOGIC_VECTOR (30 DOWNTO 0);
  SIGNAL and_dcpl_12 : STD_LOGIC;
  SIGNAL or_tmp_5 : STD_LOGIC;
  SIGNAL exit_while_sva : STD_LOGIC;
  SIGNAL reg_result_rsc_triosy_obj_ld_cse : STD_LOGIC;
  SIGNAL z_out : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL base_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL exp_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL while_mul_mut : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL while_mul_mut_mx0w0 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL nor_5_nl : STD_LOGIC;
  SIGNAL operator_64_false_acc_nl : STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL operator_64_false_mux_2_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL base_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL base_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL exp_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL exp_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL m_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL result_rsci_din_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL result_rsci_ldout : STD_LOGIC;
  SIGNAL result_rsci_dout : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL result_rsci_zin : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL result_rsci_zout : STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL while_rem_cmp_a_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL while_rem_cmp_b_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL while_rem_cmp_z_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT modExp_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (30 DOWNTO 0);
      main_C_1_tr0 : IN STD_LOGIC;
      while_C_26_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL modExp_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (30 DOWNTO 0);
  SIGNAL modExp_core_core_fsm_inst_main_C_1_tr0 : STD_LOGIC;

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

  FUNCTION MUX_v_64_2_2(input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);

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
  base_rsci : mgc_hls.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 1,
      width => 64
      )
    PORT MAP(
      dat => base_rsci_dat,
      idat => base_rsci_idat_1
    );
  base_rsci_dat <= base_rsc_dat;
  base_rsci_idat <= base_rsci_idat_1;

  exp_rsci : mgc_hls.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 2,
      width => 64
      )
    PORT MAP(
      dat => exp_rsci_dat,
      idat => exp_rsci_idat_1
    );
  exp_rsci_dat <= exp_rsc_dat;
  exp_rsci_idat <= exp_rsci_idat_1;

  m_rsci : mgc_hls.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 3,
      width => 64
      )
    PORT MAP(
      dat => m_rsci_dat,
      idat => m_rsci_idat_1
    );
  m_rsci_dat <= m_rsc_dat;
  m_rsci_idat <= m_rsci_idat_1;

  result_rsci : mgc_hls.mgc_inout_prereg_en_pkg_v1.mgc_inout_prereg_en_v1
    GENERIC MAP(
      rscid => 4,
      width => 64
      )
    PORT MAP(
      din => result_rsci_din_1,
      ldout => result_rsci_ldout,
      dout => result_rsci_dout,
      zin => result_rsci_zin,
      lzout => result_rsc_lzout,
      zout => result_rsci_zout
    );
  result_rsci_din <= result_rsci_din_1;
  result_rsci_ldout <= (fsm_output(28)) OR (fsm_output(1));
  result_rsci_dout <= MUX_v_64_2_2(STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000001"),
      while_rem_cmp_z, fsm_output(28));
  result_rsci_zin <= result_rsc_zin;
  result_rsc_zout <= result_rsci_zout;

  base_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_result_rsc_triosy_obj_ld_cse,
      lz => base_rsc_triosy_lz
    );
  exp_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_result_rsc_triosy_obj_ld_cse,
      lz => exp_rsc_triosy_lz
    );
  m_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_result_rsc_triosy_obj_ld_cse,
      lz => m_rsc_triosy_lz
    );
  result_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_result_rsc_triosy_obj_ld_cse,
      lz => result_rsc_triosy_lz
    );
  while_rem_cmp : mgc_hls.mgc_comps.mgc_rem
    GENERIC MAP(
      width_a => 64,
      width_b => 64,
      signd => 0
      )
    PORT MAP(
      a => while_rem_cmp_a_1,
      b => while_rem_cmp_b_1,
      z => while_rem_cmp_z_1
    );
  while_rem_cmp_a_1 <= while_rem_cmp_a;
  while_rem_cmp_b_1 <= while_rem_cmp_b;
  while_rem_cmp_z <= while_rem_cmp_z_1;

  modExp_core_core_fsm_inst : modExp_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => modExp_core_core_fsm_inst_fsm_output,
      main_C_1_tr0 => modExp_core_core_fsm_inst_main_C_1_tr0,
      while_C_26_tr0 => exit_while_sva
    );
  fsm_output <= modExp_core_core_fsm_inst_fsm_output;
  modExp_core_core_fsm_inst_main_C_1_tr0 <= NOT exit_while_sva;

  while_mul_mut_mx0w0 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'( UNSIGNED(result_rsci_din)
      * UNSIGNED(base_sva)), 64));
  and_dcpl_12 <= NOT((fsm_output(30)) OR (fsm_output(0)));
  or_tmp_5 <= and_dcpl_12 AND (NOT (fsm_output(1)));
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        while_rem_cmp_b <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        while_rem_cmp_a <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        reg_result_rsc_triosy_obj_ld_cse <= '0';
      ELSE
        while_rem_cmp_b <= m_sva;
        while_rem_cmp_a <= MUX_v_64_2_2(while_mul_mut_mx0w0, while_mul_mut, nor_5_nl);
        reg_result_rsc_triosy_obj_ld_cse <= (exit_while_sva AND (fsm_output(29)))
            OR ((NOT exit_while_sva) AND (fsm_output(2)));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        m_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( or_tmp_5 = '0' ) THEN
        m_sva <= m_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exp_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (NOT(and_dcpl_12 AND (NOT((fsm_output(1)) OR (fsm_output(3)))))) =
          '1' ) THEN
        exp_sva <= MUX_v_64_2_2(exp_rsci_idat, (z_out(63 DOWNTO 0)), fsm_output(3));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        base_sva <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( or_tmp_5 = '0' ) THEN
        base_sva <= base_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exit_while_sva <= '0';
      ELSIF ( ((fsm_output(1)) OR (fsm_output(3))) = '1' ) THEN
        exit_while_sva <= MUX_s_1_2_2((z_out(64)), (NOT (operator_64_false_acc_nl(64))),
            fsm_output(3));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        while_mul_mut <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( (fsm_output(3)) = '1' ) THEN
        while_mul_mut <= while_mul_mut_mx0w0;
      END IF;
    END IF;
  END PROCESS;
  nor_5_nl <= NOT((fsm_output(29)) OR (fsm_output(30)) OR (fsm_output(28)) OR (fsm_output(0))
      OR (fsm_output(2)) OR (fsm_output(1)) OR (fsm_output(3)));
  operator_64_false_acc_nl <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED('1' & (NOT (z_out(63
      DOWNTO 0)))) + SIGNED'( "00000000000000000000000000000000000000000000000000000000000000001"),
      65));
  operator_64_false_mux_2_nl <= MUX_v_64_2_2((NOT exp_rsci_idat), exp_sva, fsm_output(3));
  z_out <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED((NOT (fsm_output(3))) & operator_64_false_mux_2_nl)
      + CONV_UNSIGNED(CONV_SIGNED(SIGNED'( (fsm_output(3)) & '1'), 2), 65), 65));
END v8;

-- ------------------------------------------------------------------
--  Design Unit:    modExp
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_inout_prereg_en_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_comps.ALL;


ENTITY modExp IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    base_rsc_triosy_lz : OUT STD_LOGIC;
    exp_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    exp_rsc_triosy_lz : OUT STD_LOGIC;
    m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    m_rsc_triosy_lz : OUT STD_LOGIC;
    result_rsc_zout : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    result_rsc_lzout : OUT STD_LOGIC;
    result_rsc_zin : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    result_rsc_triosy_lz : OUT STD_LOGIC
  );
END modExp;

ARCHITECTURE v8 OF modExp IS
  -- Default Constants

  COMPONENT modExp_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      base_rsc_triosy_lz : OUT STD_LOGIC;
      exp_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      exp_rsc_triosy_lz : OUT STD_LOGIC;
      m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      m_rsc_triosy_lz : OUT STD_LOGIC;
      result_rsc_zout : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      result_rsc_lzout : OUT STD_LOGIC;
      result_rsc_zin : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      result_rsc_triosy_lz : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL modExp_core_inst_base_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_core_inst_exp_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_core_inst_m_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_core_inst_result_rsc_zout : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modExp_core_inst_result_rsc_zin : STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
  modExp_core_inst : modExp_core
    PORT MAP(
      clk => clk,
      rst => rst,
      base_rsc_dat => modExp_core_inst_base_rsc_dat,
      base_rsc_triosy_lz => base_rsc_triosy_lz,
      exp_rsc_dat => modExp_core_inst_exp_rsc_dat,
      exp_rsc_triosy_lz => exp_rsc_triosy_lz,
      m_rsc_dat => modExp_core_inst_m_rsc_dat,
      m_rsc_triosy_lz => m_rsc_triosy_lz,
      result_rsc_zout => modExp_core_inst_result_rsc_zout,
      result_rsc_lzout => result_rsc_lzout,
      result_rsc_zin => modExp_core_inst_result_rsc_zin,
      result_rsc_triosy_lz => result_rsc_triosy_lz
    );
  modExp_core_inst_base_rsc_dat <= base_rsc_dat;
  modExp_core_inst_exp_rsc_dat <= exp_rsc_dat;
  modExp_core_inst_m_rsc_dat <= m_rsc_dat;
  result_rsc_zout <= modExp_core_inst_result_rsc_zout;
  modExp_core_inst_result_rsc_zin <= result_rsc_zin;

END v8;



