-- ----------------------------------------------------------------------
--  HLS HDL:        VHDL Netlister
--  HLS Version:    10.5c/896140 Production Release
--  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
-- 
--  Generated by:   yl7897@newnano.poly.edu
--  Generated date: Tue Aug 31 22:22:44 2021
-- ----------------------------------------------------------------------

-- 
-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    radr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen;

ARCHITECTURE v17 OF inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  radr <= (radr_d);
END v17;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
    IS
  PORT(
    q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    radr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    we : OUT STD_LOGIC;
    d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    wadr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    radr_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    wadr_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
    we_d : IN STD_LOGIC;
    writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
    readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
  );
END inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen;

ARCHITECTURE v17 OF inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
    IS
  -- Default Constants

BEGIN
  q_d <= q;
  radr <= (radr_d);
  we <= (writeA_w_ram_ir_internal_WMASK_B_d);
  d <= (d_d);
  wadr <= (wadr_d);
END v17;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIF_core_core_fsm
--  FSM Module
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIF_core_core_fsm IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    fsm_output : OUT STD_LOGIC_VECTOR (33 DOWNTO 0);
    COMP_LOOP_C_28_tr0 : IN STD_LOGIC;
    VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
    STAGE_LOOP_C_1_tr0 : IN STD_LOGIC
  );
END inPlaceNTT_DIF_core_core_fsm;

ARCHITECTURE v17 OF inPlaceNTT_DIF_core_core_fsm IS
  -- Default Constants

  -- FSM State Type Declaration for inPlaceNTT_DIF_core_core_fsm_1
  TYPE inPlaceNTT_DIF_core_core_fsm_1_ST IS (main_C_0, STAGE_LOOP_C_0, COMP_LOOP_C_0,
      COMP_LOOP_C_1, COMP_LOOP_C_2, COMP_LOOP_C_3, COMP_LOOP_C_4, COMP_LOOP_C_5,
      COMP_LOOP_C_6, COMP_LOOP_C_7, COMP_LOOP_C_8, COMP_LOOP_C_9, COMP_LOOP_C_10,
      COMP_LOOP_C_11, COMP_LOOP_C_12, COMP_LOOP_C_13, COMP_LOOP_C_14, COMP_LOOP_C_15,
      COMP_LOOP_C_16, COMP_LOOP_C_17, COMP_LOOP_C_18, COMP_LOOP_C_19, COMP_LOOP_C_20,
      COMP_LOOP_C_21, COMP_LOOP_C_22, COMP_LOOP_C_23, COMP_LOOP_C_24, COMP_LOOP_C_25,
      COMP_LOOP_C_26, COMP_LOOP_C_27, COMP_LOOP_C_28, VEC_LOOP_C_0, STAGE_LOOP_C_1,
      main_C_1);

  SIGNAL state_var : inPlaceNTT_DIF_core_core_fsm_1_ST;
  SIGNAL state_var_NS : inPlaceNTT_DIF_core_core_fsm_1_ST;

BEGIN
  inPlaceNTT_DIF_core_core_fsm_1 : PROCESS (COMP_LOOP_C_28_tr0, VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_1_tr0, state_var)
  BEGIN
    CASE state_var IS
      WHEN STAGE_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000010");
        state_var_NS <= COMP_LOOP_C_0;
      WHEN COMP_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000100");
        state_var_NS <= COMP_LOOP_C_1;
      WHEN COMP_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000001000");
        state_var_NS <= COMP_LOOP_C_2;
      WHEN COMP_LOOP_C_2 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000010000");
        state_var_NS <= COMP_LOOP_C_3;
      WHEN COMP_LOOP_C_3 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000100000");
        state_var_NS <= COMP_LOOP_C_4;
      WHEN COMP_LOOP_C_4 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000001000000");
        state_var_NS <= COMP_LOOP_C_5;
      WHEN COMP_LOOP_C_5 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000010000000");
        state_var_NS <= COMP_LOOP_C_6;
      WHEN COMP_LOOP_C_6 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000100000000");
        state_var_NS <= COMP_LOOP_C_7;
      WHEN COMP_LOOP_C_7 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000001000000000");
        state_var_NS <= COMP_LOOP_C_8;
      WHEN COMP_LOOP_C_8 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000010000000000");
        state_var_NS <= COMP_LOOP_C_9;
      WHEN COMP_LOOP_C_9 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000100000000000");
        state_var_NS <= COMP_LOOP_C_10;
      WHEN COMP_LOOP_C_10 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000001000000000000");
        state_var_NS <= COMP_LOOP_C_11;
      WHEN COMP_LOOP_C_11 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000010000000000000");
        state_var_NS <= COMP_LOOP_C_12;
      WHEN COMP_LOOP_C_12 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000100000000000000");
        state_var_NS <= COMP_LOOP_C_13;
      WHEN COMP_LOOP_C_13 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000001000000000000000");
        state_var_NS <= COMP_LOOP_C_14;
      WHEN COMP_LOOP_C_14 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000010000000000000000");
        state_var_NS <= COMP_LOOP_C_15;
      WHEN COMP_LOOP_C_15 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000100000000000000000");
        state_var_NS <= COMP_LOOP_C_16;
      WHEN COMP_LOOP_C_16 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000001000000000000000000");
        state_var_NS <= COMP_LOOP_C_17;
      WHEN COMP_LOOP_C_17 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000010000000000000000000");
        state_var_NS <= COMP_LOOP_C_18;
      WHEN COMP_LOOP_C_18 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000100000000000000000000");
        state_var_NS <= COMP_LOOP_C_19;
      WHEN COMP_LOOP_C_19 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000001000000000000000000000");
        state_var_NS <= COMP_LOOP_C_20;
      WHEN COMP_LOOP_C_20 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000010000000000000000000000");
        state_var_NS <= COMP_LOOP_C_21;
      WHEN COMP_LOOP_C_21 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000100000000000000000000000");
        state_var_NS <= COMP_LOOP_C_22;
      WHEN COMP_LOOP_C_22 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000001000000000000000000000000");
        state_var_NS <= COMP_LOOP_C_23;
      WHEN COMP_LOOP_C_23 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000010000000000000000000000000");
        state_var_NS <= COMP_LOOP_C_24;
      WHEN COMP_LOOP_C_24 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000100000000000000000000000000");
        state_var_NS <= COMP_LOOP_C_25;
      WHEN COMP_LOOP_C_25 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000001000000000000000000000000000");
        state_var_NS <= COMP_LOOP_C_26;
      WHEN COMP_LOOP_C_26 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000010000000000000000000000000000");
        state_var_NS <= COMP_LOOP_C_27;
      WHEN COMP_LOOP_C_27 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000100000000000000000000000000000");
        state_var_NS <= COMP_LOOP_C_28;
      WHEN COMP_LOOP_C_28 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0001000000000000000000000000000000");
        IF ( COMP_LOOP_C_28_tr0 = '1' ) THEN
          state_var_NS <= VEC_LOOP_C_0;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN VEC_LOOP_C_0 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0010000000000000000000000000000000");
        IF ( VEC_LOOP_C_0_tr0 = '1' ) THEN
          state_var_NS <= STAGE_LOOP_C_1;
        ELSE
          state_var_NS <= COMP_LOOP_C_0;
        END IF;
      WHEN STAGE_LOOP_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "0100000000000000000000000000000000");
        IF ( STAGE_LOOP_C_1_tr0 = '1' ) THEN
          state_var_NS <= main_C_1;
        ELSE
          state_var_NS <= STAGE_LOOP_C_0;
        END IF;
      WHEN main_C_1 =>
        fsm_output <= STD_LOGIC_VECTOR'( "1000000000000000000000000000000000");
        state_var_NS <= main_C_0;
      -- main_C_0
      WHEN OTHERS =>
        fsm_output <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000001");
        state_var_NS <= STAGE_LOOP_C_0;
    END CASE;
  END PROCESS inPlaceNTT_DIF_core_core_fsm_1;

  inPlaceNTT_DIF_core_core_fsm_1_REG : PROCESS (clk)
  BEGIN
    IF clk'event AND ( clk = '1' ) THEN
      IF ( rst = '1' ) THEN
        state_var <= main_C_0;
      ELSE
        state_var <= state_var_NS;
      END IF;
    END IF;
  END PROCESS inPlaceNTT_DIF_core_core_fsm_1_REG;

END v17;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIF_core_wait_dp
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIF_core_wait_dp IS
  PORT(
    ensig_cgo_iro : IN STD_LOGIC;
    ensig_cgo : IN STD_LOGIC;
    modulo_dev_cmp_ccs_ccore_en : OUT STD_LOGIC
  );
END inPlaceNTT_DIF_core_wait_dp;

ARCHITECTURE v17 OF inPlaceNTT_DIF_core_wait_dp IS
  -- Default Constants

BEGIN
  modulo_dev_cmp_ccs_ccore_en <= ensig_cgo OR ensig_cgo_iro;
END v17;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIF_core
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIF_core IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_triosy_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_triosy_lz : OUT STD_LOGIC;
    twiddle_rsc_triosy_lz : OUT STD_LOGIC;
    vec_rsci_d_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsci_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsci_radr_d : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsci_wadr_d : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsci_readA_r_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    twiddle_rsci_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsci_radr_d : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
    vec_rsci_we_d_pff : OUT STD_LOGIC
  );
END inPlaceNTT_DIF_core;

ARCHITECTURE v17 OF inPlaceNTT_DIF_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL p_rsci_idat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_cmp_return_rsc_z : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_cmp_ccs_ccore_en : STD_LOGIC;
  SIGNAL fsm_output : STD_LOGIC_VECTOR (33 DOWNTO 0);
  SIGNAL and_dcpl_5 : STD_LOGIC;
  SIGNAL and_dcpl_6 : STD_LOGIC;
  SIGNAL exit_COMP_LOOP_sva : STD_LOGIC;
  SIGNAL reg_vec_rsc_triosy_obj_ld_cse : STD_LOGIC;
  SIGNAL reg_ensig_cgo_cse : STD_LOGIC;
  SIGNAL VEC_LOOP_j_or_cse : STD_LOGIC;
  SIGNAL and_56_rmff : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_8_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_twiddle_f_asn_itm : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_sva : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_1_cse_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_10_cse_10_1_sva : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_twiddle_f_acc_3 : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL COMP_LOOP_k_10_0_sva_9_0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL z_out : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL z_out_1 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL z_out_2 : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL STAGE_LOOP_i_3_0_sva : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL STAGE_LOOP_lshift_psp_sva : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL VEC_LOOP_j_10_0_sva_9_0 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_10_itm_10_1_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);

  SIGNAL VEC_LOOP_j_not_1_nl : STD_LOGIC;
  SIGNAL VEC_LOOP_j_not_nl : STD_LOGIC;
  SIGNAL COMP_LOOP_acc_8_nl : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL COMP_LOOP_acc_10_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL acc_nl : STD_LOGIC_VECTOR (11 DOWNTO 0);
  SIGNAL VEC_LOOP_mux_2_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL VEC_LOOP_or_1_nl : STD_LOGIC;
  SIGNAL VEC_LOOP_mux_3_nl : STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL COMP_LOOP_mux_11_nl : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL p_rsci_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL p_rsci_idat_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);

  COMPONENT modulo_dev
    PORT (
      base_rsc_dat : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      m_rsc_dat : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      return_rsc_z : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      ccs_ccore_start_rsc_dat : IN STD_LOGIC;
      ccs_ccore_clk : IN STD_LOGIC;
      ccs_ccore_srst : IN STD_LOGIC;
      ccs_ccore_en : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL modulo_dev_cmp_base_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_cmp_m_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_cmp_return_rsc_z_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_cmp_ccs_ccore_start_rsc_dat : STD_LOGIC;

  SIGNAL COMP_LOOP_twiddle_f_lshift_rg_a : STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL COMP_LOOP_twiddle_f_lshift_rg_s : STD_LOGIC_VECTOR (3 DOWNTO 0);
  SIGNAL COMP_LOOP_twiddle_f_lshift_rg_z : STD_LOGIC_VECTOR (10 DOWNTO 0);

  COMPONENT inPlaceNTT_DIF_core_wait_dp
    PORT(
      ensig_cgo_iro : IN STD_LOGIC;
      ensig_cgo : IN STD_LOGIC;
      modulo_dev_cmp_ccs_ccore_en : OUT STD_LOGIC
    );
  END COMPONENT;
  COMPONENT inPlaceNTT_DIF_core_core_fsm
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      fsm_output : OUT STD_LOGIC_VECTOR (33 DOWNTO 0);
      COMP_LOOP_C_28_tr0 : IN STD_LOGIC;
      VEC_LOOP_C_0_tr0 : IN STD_LOGIC;
      STAGE_LOOP_C_1_tr0 : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIF_core_core_fsm_inst_fsm_output : STD_LOGIC_VECTOR (33 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0 : STD_LOGIC;
  SIGNAL inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 : STD_LOGIC;

  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

  FUNCTION MUX1HOT_v_64_3_2(input_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 : STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel : STD_LOGIC_VECTOR(2 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(63 DOWNTO 0);
    VARIABLE tmp : STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
    RETURN result;
  END;

  FUNCTION MUX_v_10_2_2(input_0 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(9 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(9 DOWNTO 0);

    BEGIN
      CASE sel IS
        WHEN '0' =>
          result := input_0;
        WHEN others =>
          result := input_1;
      END CASE;
    RETURN result;
  END;

  FUNCTION MUX_v_11_2_2(input_0 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  input_1 : STD_LOGIC_VECTOR(10 DOWNTO 0);
  sel : STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result : STD_LOGIC_VECTOR(10 DOWNTO 0);

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
  p_rsci : mgc_hls.ccs_in_pkg_v1.ccs_in_v1
    GENERIC MAP(
      rscid => 5,
      width => 64
      )
    PORT MAP(
      dat => p_rsci_dat,
      idat => p_rsci_idat_1
    );
  p_rsci_dat <= p_rsc_dat;
  p_rsci_idat <= p_rsci_idat_1;

  vec_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_obj_ld_cse,
      lz => vec_rsc_triosy_lz
    );
  p_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_obj_ld_cse,
      lz => p_rsc_triosy_lz
    );
  r_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_obj_ld_cse,
      lz => r_rsc_triosy_lz
    );
  twiddle_rsc_triosy_obj : mgc_hls.mgc_io_sync_pkg_v2.mgc_io_sync_v2
    GENERIC MAP(
      valid => 0
      )
    PORT MAP(
      ld => reg_vec_rsc_triosy_obj_ld_cse,
      lz => twiddle_rsc_triosy_lz
    );
  modulo_dev_cmp : modulo_dev
    PORT MAP(
      base_rsc_dat => modulo_dev_cmp_base_rsc_dat,
      m_rsc_dat => modulo_dev_cmp_m_rsc_dat,
      return_rsc_z => modulo_dev_cmp_return_rsc_z_1,
      ccs_ccore_start_rsc_dat => modulo_dev_cmp_ccs_ccore_start_rsc_dat,
      ccs_ccore_clk => clk,
      ccs_ccore_srst => rst,
      ccs_ccore_en => modulo_dev_cmp_ccs_ccore_en
    );
  modulo_dev_cmp_base_rsc_dat <= MUX1HOT_v_64_3_2(STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(vec_rsci_q_d)
      - UNSIGNED(COMP_LOOP_acc_8_itm), 64)), COMP_LOOP_acc_8_itm, STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED'(
      UNSIGNED(COMP_LOOP_twiddle_f_asn_itm) * UNSIGNED(modulo_dev_cmp_return_rsc_z)),
      64)), STD_LOGIC_VECTOR'( (fsm_output(4)) & (fsm_output(5)) & (fsm_output(16))));
  modulo_dev_cmp_m_rsc_dat <= p_sva;
  modulo_dev_cmp_return_rsc_z <= modulo_dev_cmp_return_rsc_z_1;
  modulo_dev_cmp_ccs_ccore_start_rsc_dat <= (fsm_output(16)) OR (fsm_output(5)) OR
      (fsm_output(4));

  COMP_LOOP_twiddle_f_lshift_rg : mgc_hls.mgc_shift_comps_v5.mgc_shift_l_v5
    GENERIC MAP(
      width_a => 1,
      signd_a => 0,
      width_s => 4,
      width_z => 11
      )
    PORT MAP(
      a => COMP_LOOP_twiddle_f_lshift_rg_a,
      s => COMP_LOOP_twiddle_f_lshift_rg_s,
      z => COMP_LOOP_twiddle_f_lshift_rg_z
    );
  COMP_LOOP_twiddle_f_lshift_rg_a(0) <= '1';
  COMP_LOOP_twiddle_f_lshift_rg_s <= MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, COMP_LOOP_twiddle_f_acc_3,
      fsm_output(2));
  z_out <= COMP_LOOP_twiddle_f_lshift_rg_z;

  inPlaceNTT_DIF_core_wait_dp_inst : inPlaceNTT_DIF_core_wait_dp
    PORT MAP(
      ensig_cgo_iro => and_56_rmff,
      ensig_cgo => reg_ensig_cgo_cse,
      modulo_dev_cmp_ccs_ccore_en => modulo_dev_cmp_ccs_ccore_en
    );
  inPlaceNTT_DIF_core_core_fsm_inst : inPlaceNTT_DIF_core_core_fsm
    PORT MAP(
      clk => clk,
      rst => rst,
      fsm_output => inPlaceNTT_DIF_core_core_fsm_inst_fsm_output,
      COMP_LOOP_C_28_tr0 => exit_COMP_LOOP_sva,
      VEC_LOOP_C_0_tr0 => inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_1_tr0 => inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0
    );
  fsm_output <= inPlaceNTT_DIF_core_core_fsm_inst_fsm_output;
  inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0 <= z_out_1(10);
  inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 <= NOT (z_out_2(4));

  and_56_rmff <= and_dcpl_5 AND (NOT (fsm_output(30))) AND (NOT(CONV_SL_1_1(fsm_output(29
      DOWNTO 28)/=STD_LOGIC_VECTOR'("00")))) AND (NOT (fsm_output(3))) AND (NOT (fsm_output(2)))
      AND (NOT (fsm_output(31))) AND and_dcpl_6;
  VEC_LOOP_j_or_cse <= (fsm_output(1)) OR (fsm_output(31));
  COMP_LOOP_twiddle_f_acc_3 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(STAGE_LOOP_i_3_0_sva)
      + UNSIGNED'( "1111"), 4));
  COMP_LOOP_acc_10_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_10_0_sva_9_0),
      10), 11) + CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_k_10_0_sva_9_0),
      10), 11) + UNSIGNED(STAGE_LOOP_lshift_psp_sva), 11));
  COMP_LOOP_acc_10_itm_10_1_1 <= COMP_LOOP_acc_10_nl(10 DOWNTO 1);
  and_dcpl_5 <= NOT((fsm_output(33)) OR (fsm_output(0)));
  and_dcpl_6 <= NOT((fsm_output(32)) OR (fsm_output(1)));
  vec_rsci_d_d <= MUX_v_64_2_2(modulo_dev_cmp_return_rsc_z, COMP_LOOP_acc_8_itm,
      fsm_output(29));
  vec_rsci_radr_d <= MUX_v_10_2_2(COMP_LOOP_acc_10_itm_10_1_1, COMP_LOOP_acc_1_cse_sva,
      fsm_output(3));
  vec_rsci_wadr_d <= MUX_v_10_2_2(COMP_LOOP_acc_10_cse_10_1_sva, COMP_LOOP_acc_1_cse_sva,
      fsm_output(29));
  vec_rsci_we_d_pff <= CONV_SL_1_1(fsm_output(29 DOWNTO 28)/=STD_LOGIC_VECTOR'("00"));
  vec_rsci_readA_r_ram_ir_internal_RMASK_B_d <= CONV_SL_1_1(fsm_output(3 DOWNTO 2)/=STD_LOGIC_VECTOR'("00"));
  twiddle_rsci_radr_d <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(z_out(9 DOWNTO 0))
      + UNSIGNED(COMP_LOOP_k_10_0_sva_9_0), 10));
  twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d <= fsm_output(2);
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((fsm_output(32)) OR (fsm_output(0))) = '1' ) THEN
        STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(STD_LOGIC_VECTOR'( "1010"), COMP_LOOP_twiddle_f_acc_3,
            fsm_output(32));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( and_dcpl_5 = '0' ) THEN
        p_sva <= p_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        reg_vec_rsc_triosy_obj_ld_cse <= '0';
        reg_ensig_cgo_cse <= '0';
      ELSE
        reg_vec_rsc_triosy_obj_ld_cse <= (NOT (z_out_2(4))) AND (fsm_output(32));
        reg_ensig_cgo_cse <= and_56_rmff;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( VEC_LOOP_j_or_cse = '1' ) THEN
        VEC_LOOP_j_10_0_sva_9_0 <= MUX_v_10_2_2(STD_LOGIC_VECTOR'("0000000000"),
            (z_out_1(9 DOWNTO 0)), VEC_LOOP_j_not_1_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (NOT(and_dcpl_5 AND and_dcpl_6)) = '1' ) THEN
        STAGE_LOOP_lshift_psp_sva <= z_out;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((fsm_output(32)) OR (fsm_output(2)) OR (fsm_output(0)) OR (fsm_output(31))
          OR (fsm_output(33)) OR (fsm_output(1))) = '1' ) THEN
        COMP_LOOP_k_10_0_sva_9_0 <= MUX_v_10_2_2(STD_LOGIC_VECTOR'("0000000000"),
            (z_out_2(9 DOWNTO 0)), VEC_LOOP_j_not_nl);
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF (rst = '1') THEN
        exit_COMP_LOOP_sva <= '0';
      ELSIF ( (fsm_output(2)) = '1' ) THEN
        exit_COMP_LOOP_sva <= NOT (z_out_1(10));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (fsm_output(2)) = '1' ) THEN
        COMP_LOOP_acc_1_cse_sva <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_j_10_0_sva_9_0)
            + UNSIGNED(COMP_LOOP_k_10_0_sva_9_0), 10));
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (fsm_output(2)) = '1' ) THEN
        COMP_LOOP_acc_10_cse_10_1_sva <= COMP_LOOP_acc_10_itm_10_1_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( (fsm_output(3)) = '1' ) THEN
        COMP_LOOP_twiddle_f_asn_itm <= twiddle_rsci_q_d;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (clk)
  BEGIN
    IF clk'EVENT AND ( clk = '1' ) THEN
      IF ( ((fsm_output(17)) OR (fsm_output(3)) OR (fsm_output(4))) = '1' ) THEN
        COMP_LOOP_acc_8_itm <= MUX1HOT_v_64_3_2(vec_rsci_q_d, STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_acc_8_nl),
            64)), modulo_dev_cmp_return_rsc_z, STD_LOGIC_VECTOR'( (fsm_output(3))
            & (fsm_output(4)) & (fsm_output(17))));
      END IF;
    END IF;
  END PROCESS;
  VEC_LOOP_j_not_1_nl <= NOT (fsm_output(1));
  VEC_LOOP_j_not_nl <= NOT VEC_LOOP_j_or_cse;
  COMP_LOOP_acc_8_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(vec_rsci_q_d) + UNSIGNED(COMP_LOOP_acc_8_itm),
      64));
  VEC_LOOP_mux_2_nl <= MUX_v_11_2_2(('0' & VEC_LOOP_j_10_0_sva_9_0), z_out_2, fsm_output(2));
  VEC_LOOP_or_1_nl <= (NOT (fsm_output(31))) OR (fsm_output(2));
  VEC_LOOP_mux_3_nl <= MUX_v_11_2_2(STAGE_LOOP_lshift_psp_sva, ('1' & (NOT (STAGE_LOOP_lshift_psp_sva(10
      DOWNTO 1)))), fsm_output(2));
  acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(VEC_LOOP_mux_2_nl & VEC_LOOP_or_1_nl)
      + UNSIGNED(VEC_LOOP_mux_3_nl & '1'), 12));
  z_out_1 <= acc_nl(11 DOWNTO 1);
  COMP_LOOP_mux_11_nl <= MUX_v_10_2_2(COMP_LOOP_k_10_0_sva_9_0, (STD_LOGIC_VECTOR'(
      "000001") & (NOT COMP_LOOP_twiddle_f_acc_3)), fsm_output(32));
  z_out_2 <= STD_LOGIC_VECTOR(CONV_UNSIGNED(CONV_UNSIGNED(UNSIGNED(COMP_LOOP_mux_11_nl),
      11) + UNSIGNED'( "00000000001"), 11));
END v17;

-- ------------------------------------------------------------------
--  Design Unit:    inPlaceNTT_DIF
-- ------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
LIBRARY mgc_hls;
USE mgc_hls.ccs_in_pkg_v1.ALL;
USE mgc_hls.mgc_io_sync_pkg_v2.ALL;
USE mgc_hls.mgc_shift_comps_v5.ALL;


ENTITY inPlaceNTT_DIF IS
  PORT(
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    vec_rsc_wadr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsc_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_we : OUT STD_LOGIC;
    vec_rsc_radr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    vec_rsc_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    vec_rsc_triosy_lz : OUT STD_LOGIC;
    p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    p_rsc_triosy_lz : OUT STD_LOGIC;
    r_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    r_rsc_triosy_lz : OUT STD_LOGIC;
    twiddle_rsc_radr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
    twiddle_rsc_q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    twiddle_rsc_triosy_lz : OUT STD_LOGIC
  );
END inPlaceNTT_DIF;

ARCHITECTURE v17 OF inPlaceNTT_DIF IS
  -- Default Constants
  CONSTANT PWR : STD_LOGIC := '1';

  -- Interconnect Declarations
  SIGNAL vec_rsci_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsci_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsci_radr_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsci_wadr_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsci_readA_r_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL twiddle_rsci_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsci_radr_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d : STD_LOGIC;
  SIGNAL vec_rsci_we_d_iff : STD_LOGIC;

  COMPONENT inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      radr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      we : OUT STD_LOGIC;
      d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      wadr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      d_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      wadr_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      we_d : IN STD_LOGIC;
      writeA_w_ram_ir_internal_WMASK_B_d : IN STD_LOGIC;
      readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL vec_rsci_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsci_radr : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsci_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsci_wadr : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsci_d_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsci_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL vec_rsci_radr_d_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL vec_rsci_wadr_d_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);

  COMPONENT inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen
    PORT(
      q : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      radr : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      q_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      radr_d : IN STD_LOGIC_VECTOR (9 DOWNTO 0);
      readA_r_ram_ir_internal_RMASK_B_d : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL twiddle_rsci_q : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsci_radr : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL twiddle_rsci_q_d_1 : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL twiddle_rsci_radr_d_1 : STD_LOGIC_VECTOR (9 DOWNTO 0);

  COMPONENT inPlaceNTT_DIF_core
    PORT(
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      vec_rsc_triosy_lz : OUT STD_LOGIC;
      p_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      p_rsc_triosy_lz : OUT STD_LOGIC;
      r_rsc_triosy_lz : OUT STD_LOGIC;
      twiddle_rsc_triosy_lz : OUT STD_LOGIC;
      vec_rsci_d_d : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsci_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      vec_rsci_radr_d : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      vec_rsci_wadr_d : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      vec_rsci_readA_r_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      twiddle_rsci_q_d : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      twiddle_rsci_radr_d : OUT STD_LOGIC_VECTOR (9 DOWNTO 0);
      twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d : OUT STD_LOGIC;
      vec_rsci_we_d_pff : OUT STD_LOGIC
    );
  END COMPONENT;
  SIGNAL inPlaceNTT_DIF_core_inst_p_rsc_dat : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIF_core_inst_vec_rsci_d_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIF_core_inst_vec_rsci_q_d : STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL inPlaceNTT_DIF_core_inst_vec_rsci_radr_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL inPlaceNTT_DIF_core_inst_vec_rsci_wadr_d : STD_LOGIC_VECTOR (9 DOWNTO 0);
  SIGNAL inPlaceNTT_DIF_core_inst_twiddle_rsci_q_d : STD_LOGIC_VECTOR (63 DOWNTO
      0);
  SIGNAL inPlaceNTT_DIF_core_inst_twiddle_rsci_radr_d : STD_LOGIC_VECTOR (9 DOWNTO
      0);

BEGIN
  vec_rsci : inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
    PORT MAP(
      q => vec_rsci_q,
      radr => vec_rsci_radr,
      we => vec_rsc_we,
      d => vec_rsci_d,
      wadr => vec_rsci_wadr,
      d_d => vec_rsci_d_d_1,
      q_d => vec_rsci_q_d_1,
      radr_d => vec_rsci_radr_d_1,
      wadr_d => vec_rsci_wadr_d_1,
      we_d => vec_rsci_we_d_iff,
      writeA_w_ram_ir_internal_WMASK_B_d => vec_rsci_we_d_iff,
      readA_r_ram_ir_internal_RMASK_B_d => vec_rsci_readA_r_ram_ir_internal_RMASK_B_d
    );
  vec_rsci_q <= vec_rsc_q;
  vec_rsc_radr <= vec_rsci_radr;
  vec_rsc_d <= vec_rsci_d;
  vec_rsc_wadr <= vec_rsci_wadr;
  vec_rsci_d_d_1 <= vec_rsci_d_d;
  vec_rsci_q_d <= vec_rsci_q_d_1;
  vec_rsci_radr_d_1 <= vec_rsci_radr_d;
  vec_rsci_wadr_d_1 <= vec_rsci_wadr_d;

  twiddle_rsci : inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen
    PORT MAP(
      q => twiddle_rsci_q,
      radr => twiddle_rsci_radr,
      q_d => twiddle_rsci_q_d_1,
      radr_d => twiddle_rsci_radr_d_1,
      readA_r_ram_ir_internal_RMASK_B_d => twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d
    );
  twiddle_rsci_q <= twiddle_rsc_q;
  twiddle_rsc_radr <= twiddle_rsci_radr;
  twiddle_rsci_q_d <= twiddle_rsci_q_d_1;
  twiddle_rsci_radr_d_1 <= twiddle_rsci_radr_d;

  inPlaceNTT_DIF_core_inst : inPlaceNTT_DIF_core
    PORT MAP(
      clk => clk,
      rst => rst,
      vec_rsc_triosy_lz => vec_rsc_triosy_lz,
      p_rsc_dat => inPlaceNTT_DIF_core_inst_p_rsc_dat,
      p_rsc_triosy_lz => p_rsc_triosy_lz,
      r_rsc_triosy_lz => r_rsc_triosy_lz,
      twiddle_rsc_triosy_lz => twiddle_rsc_triosy_lz,
      vec_rsci_d_d => inPlaceNTT_DIF_core_inst_vec_rsci_d_d,
      vec_rsci_q_d => inPlaceNTT_DIF_core_inst_vec_rsci_q_d,
      vec_rsci_radr_d => inPlaceNTT_DIF_core_inst_vec_rsci_radr_d,
      vec_rsci_wadr_d => inPlaceNTT_DIF_core_inst_vec_rsci_wadr_d,
      vec_rsci_readA_r_ram_ir_internal_RMASK_B_d => vec_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsci_q_d => inPlaceNTT_DIF_core_inst_twiddle_rsci_q_d,
      twiddle_rsci_radr_d => inPlaceNTT_DIF_core_inst_twiddle_rsci_radr_d,
      twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d => twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      vec_rsci_we_d_pff => vec_rsci_we_d_iff
    );
  inPlaceNTT_DIF_core_inst_p_rsc_dat <= p_rsc_dat;
  vec_rsci_d_d <= inPlaceNTT_DIF_core_inst_vec_rsci_d_d;
  inPlaceNTT_DIF_core_inst_vec_rsci_q_d <= vec_rsci_q_d;
  vec_rsci_radr_d <= inPlaceNTT_DIF_core_inst_vec_rsci_radr_d;
  vec_rsci_wadr_d <= inPlaceNTT_DIF_core_inst_vec_rsci_wadr_d;
  inPlaceNTT_DIF_core_inst_twiddle_rsci_q_d <= twiddle_rsci_q_d;
  twiddle_rsci_radr_d <= inPlaceNTT_DIF_core_inst_twiddle_rsci_radr_d;

END v17;



