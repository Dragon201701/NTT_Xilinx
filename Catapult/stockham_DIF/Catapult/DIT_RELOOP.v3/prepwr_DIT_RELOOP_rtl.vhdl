-- ----------------------------------------------------------------------
--  HLS HDL:         VHDL Netlister
--  HLS Version:    10.5c/896140 Production Release
--  HLS Date:        Sun Sep  6 22:45:38 PDT 2020
--
--  Generated by:    yl7897@newnano.poly.edu
--  Generated date:  Wed Aug 18 21:51:12 2021
-- ----------------------------------------------------------------------

--
-- ------------------------------------------------------------------
--  Design Unit:     modulo_dev_core
-- ------------------------------------------------------------------

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
library mgc_hls;
USE mgc_hls.DIT_RELOOP_ccs_in_pkg_v1.ALL;
USE mgc_hls.DIT_RELOOP_mgc_out_dreg_pkg_v2.ALL;
USE mgc_hls.DIT_RELOOP_mgc_comps.ALL;


ENTITY DIT_RELOOP_modulo_dev_core IS
  PORT(
    base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    return_rsc_z : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    ccs_ccore_start_rsc_dat : IN STD_LOGIC;
    ccs_ccore_clk : IN STD_LOGIC;
    ccs_ccore_srst : IN STD_LOGIC;
    ccs_ccore_en : IN STD_LOGIC
  );
END DIT_RELOOP_modulo_dev_core;

ARCHITECTURE v1 OF DIT_RELOOP_modulo_dev_core IS
  -- Default Constants

  -- Interconnect Declarations
  SIGNAL base_rsci_idat :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_rsci_idat :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL return_rsci_d :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL ccs_ccore_start_rsci_idat :  STD_LOGIC;
  SIGNAL rem_4_cmp_z :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_1_z :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_2_z :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_3_z :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_b_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_4_cmp_1_b_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_4_cmp_2_b_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_4_cmp_3_b_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_4_cmp_a_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_4_cmp_1_a_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_4_cmp_2_a_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL rem_4_cmp_3_a_63_0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL acc_tmp :  STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL or_dcpl :  STD_LOGIC;
  SIGNAL or_dcpl_3 :  STD_LOGIC;
  SIGNAL rem_4cyc_st_4 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL result_sva_duc_mx0 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL and_7_cse :  STD_LOGIC;
  SIGNAL and_9_cse :  STD_LOGIC;
  SIGNAL and_11_cse :  STD_LOGIC;
  SIGNAL and_13_cse :  STD_LOGIC;
  SIGNAL rem_4cyc :  STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL main_stage_0_2 :  STD_LOGIC;
  SIGNAL main_stage_0_3 :  STD_LOGIC;
  SIGNAL main_stage_0_4 :  STD_LOGIC;
  SIGNAL m_buf_sva_1 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_buf_sva_2 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_buf_sva_3 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_buf_sva_4 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL asn_itm_1 :  STD_LOGIC;
  SIGNAL asn_itm_2 :  STD_LOGIC;
  SIGNAL asn_itm_3 :  STD_LOGIC;
  SIGNAL rem_4cyc_st_2 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL rem_4cyc_st_3 :  STD_LOGIC_VECTOR (1 DOWNTO 0);
  SIGNAL m_and_cse :  STD_LOGIC;
  SIGNAL and_17_cse :  STD_LOGIC;
  SIGNAL and_18_cse :  STD_LOGIC;
  SIGNAL and_15_cse :  STD_LOGIC;

  SIGNAL qelse_acc_nl :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL nor_nl :  STD_LOGIC;
  SIGNAL and_4_nl :  STD_LOGIC;
  SIGNAL and_5_nl :  STD_LOGIC;
  SIGNAL and_6_nl :  STD_LOGIC;
  SIGNAL base_rsci_dat :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL base_rsci_idat_1 :  STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL m_rsci_dat :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL m_rsci_idat_1 :  STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL return_rsci_d_1 :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL return_rsci_z :  STD_LOGIC_VECTOR (63 DOWNTO 0);

  SIGNAL ccs_ccore_start_rsci_dat :  STD_LOGIC_VECTOR (0 DOWNTO 0);
  SIGNAL ccs_ccore_start_rsci_idat_1 :  STD_LOGIC_VECTOR (0 DOWNTO 0);

  SIGNAL rem_4_cmp_a :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_b :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_z_1 :  STD_LOGIC_VECTOR (64 DOWNTO 0);

  SIGNAL rem_4_cmp_1_a :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_1_b :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_1_z_1 :  STD_LOGIC_VECTOR (64 DOWNTO 0);

  SIGNAL rem_4_cmp_2_a :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_2_b :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_2_z_1 :  STD_LOGIC_VECTOR (64 DOWNTO 0);

  SIGNAL rem_4_cmp_3_a :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_3_b :  STD_LOGIC_VECTOR (64 DOWNTO 0);
  SIGNAL rem_4_cmp_3_z_1 :  STD_LOGIC_VECTOR (64 DOWNTO 0);

  FUNCTION CONV_SL_1_1(input_val:BOOLEAN)
  RETURN STD_LOGIC IS
  BEGIN
    IF input_val THEN RETURN '1';ELSE RETURN '0';END IF;
  END;

  FUNCTION MUX1HOT_v_64_4_2(input_3 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_2 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_0 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel :  STD_LOGIC_VECTOR(3 DOWNTO 0))
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result :  STD_LOGIC_VECTOR(63 DOWNTO 0);
    VARIABLE tmp :  STD_LOGIC_VECTOR(63 DOWNTO 0);

    BEGIN
      tmp := (OTHERS=>sel(0));
      result := input_0 and tmp;
      tmp := (OTHERS=>sel( 1));
      result := result or ( input_1 and tmp);
      tmp := (OTHERS=>sel( 2));
      result := result or ( input_2 and tmp);
      tmp := (OTHERS=>sel( 3));
      result := result or ( input_3 and tmp);
    RETURN result;
  END;

  FUNCTION MUX_v_64_2_2(input_0 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
  input_1 :  STD_LOGIC_VECTOR(63 DOWNTO 0);
  sel :  STD_LOGIC)
  RETURN STD_LOGIC_VECTOR IS
    VARIABLE result :  STD_LOGIC_VECTOR(63 DOWNTO 0);

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
  base_rsci :  mgc_hls.DIT_RELOOP_ccs_in_pkg_v1.DIT_RELOOP_ccs_in_v1
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

  m_rsci :  mgc_hls.DIT_RELOOP_ccs_in_pkg_v1.DIT_RELOOP_ccs_in_v1
    GENERIC MAP(
      rscid => 2,
      width => 64
      )
    PORT MAP(
      dat => m_rsci_dat,
      idat => m_rsci_idat_1
    );
  m_rsci_dat <= m_rsc_dat;
  m_rsci_idat <= m_rsci_idat_1;

  return_rsci :  mgc_hls.DIT_RELOOP_mgc_out_dreg_pkg_v2.DIT_RELOOP_mgc_out_dreg_v2
    GENERIC MAP(
      rscid => 3,
      width => 64
      )
    PORT MAP(
      d => return_rsci_d_1,
      z => return_rsci_z
    );
  return_rsci_d_1 <= return_rsci_d;
  return_rsc_z <= return_rsci_z;

  ccs_ccore_start_rsci :  mgc_hls.DIT_RELOOP_ccs_in_pkg_v1.DIT_RELOOP_ccs_in_v1
    GENERIC MAP(
      rscid => 8,
      width => 1
      )
    PORT MAP(
      dat => ccs_ccore_start_rsci_dat,
      idat => ccs_ccore_start_rsci_idat_1
    );
  ccs_ccore_start_rsci_dat(0) <= ccs_ccore_start_rsc_dat;
  ccs_ccore_start_rsci_idat <= ccs_ccore_start_rsci_idat_1(0);

  rem_4_cmp :  mgc_hls.DIT_RELOOP_mgc_comps.DIT_RELOOP_mgc_rem
    GENERIC MAP(
      width_a => 65,
      width_b => 65,
      signd => 1
      )
    PORT MAP(
      a => rem_4_cmp_a,
      b => rem_4_cmp_b,
      z => rem_4_cmp_z_1
    );
  rem_4_cmp_a <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(rem_4_cmp_a_63_0),65));
  rem_4_cmp_b <= '0' & rem_4_cmp_b_63_0;
  rem_4_cmp_z <= rem_4_cmp_z_1;

  rem_4_cmp_1 :  mgc_hls.DIT_RELOOP_mgc_comps.DIT_RELOOP_mgc_rem
    GENERIC MAP(
      width_a => 65,
      width_b => 65,
      signd => 1
      )
    PORT MAP(
      a => rem_4_cmp_1_a,
      b => rem_4_cmp_1_b,
      z => rem_4_cmp_1_z_1
    );
  rem_4_cmp_1_a <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(rem_4_cmp_1_a_63_0),65));
  rem_4_cmp_1_b <= '0' & rem_4_cmp_1_b_63_0;
  rem_4_cmp_1_z <= rem_4_cmp_1_z_1;

  rem_4_cmp_2 :  mgc_hls.DIT_RELOOP_mgc_comps.DIT_RELOOP_mgc_rem
    GENERIC MAP(
      width_a => 65,
      width_b => 65,
      signd => 1
      )
    PORT MAP(
      a => rem_4_cmp_2_a,
      b => rem_4_cmp_2_b,
      z => rem_4_cmp_2_z_1
    );
  rem_4_cmp_2_a <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(rem_4_cmp_2_a_63_0),65));
  rem_4_cmp_2_b <= '0' & rem_4_cmp_2_b_63_0;
  rem_4_cmp_2_z <= rem_4_cmp_2_z_1;

  rem_4_cmp_3 :  mgc_hls.DIT_RELOOP_mgc_comps.DIT_RELOOP_mgc_rem
    GENERIC MAP(
      width_a => 65,
      width_b => 65,
      signd => 1
      )
    PORT MAP(
      a => rem_4_cmp_3_a,
      b => rem_4_cmp_3_b,
      z => rem_4_cmp_3_z_1
    );
  rem_4_cmp_3_a <= STD_LOGIC_VECTOR(CONV_SIGNED(SIGNED(rem_4_cmp_3_a_63_0),65));
  rem_4_cmp_3_b <= '0' & rem_4_cmp_3_b_63_0;
  rem_4_cmp_3_z <= rem_4_cmp_3_z_1;

  m_and_cse <= ccs_ccore_en AND main_stage_0_4 AND asn_itm_3;
  and_7_cse <= ccs_ccore_en AND (NOT(or_dcpl OR (acc_tmp(0))));
  and_9_cse <= ccs_ccore_en AND (NOT(or_dcpl OR (NOT (acc_tmp(0)))));
  and_11_cse <= ccs_ccore_en AND (NOT(or_dcpl_3 OR (acc_tmp(0))));
  and_13_cse <= ccs_ccore_en AND (NOT(or_dcpl_3 OR (NOT (acc_tmp(0)))));
  and_17_cse <= ccs_ccore_en AND main_stage_0_3 AND asn_itm_2;
  and_18_cse <= ccs_ccore_en AND main_stage_0_2 AND asn_itm_1;
  and_15_cse <= ccs_ccore_en AND ccs_ccore_start_rsci_idat;
  nor_nl <= NOT(CONV_SL_1_1(rem_4cyc_st_4/=STD_LOGIC_VECTOR'("00")));
  and_4_nl <= CONV_SL_1_1(rem_4cyc_st_4=STD_LOGIC_VECTOR'("01"));
  and_5_nl <= CONV_SL_1_1(rem_4cyc_st_4=STD_LOGIC_VECTOR'("10"));
  and_6_nl <= CONV_SL_1_1(rem_4cyc_st_4=STD_LOGIC_VECTOR'("11"));
  result_sva_duc_mx0 <= MUX1HOT_v_64_4_2((rem_4_cmp_1_z(63 DOWNTO 0)), (rem_4_cmp_2_z(63
      DOWNTO 0)), (rem_4_cmp_3_z(63 DOWNTO 0)), (rem_4_cmp_z(63 DOWNTO 0)), STD_LOGIC_VECTOR'(
      nor_nl & and_4_nl & and_5_nl & and_6_nl));
  acc_tmp <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(rem_4cyc) + UNSIGNED'( "01"),
      2));
  or_dcpl <= (NOT ccs_ccore_start_rsci_idat) OR (acc_tmp(1));
  or_dcpl_3 <= NOT(ccs_ccore_start_rsci_idat AND (acc_tmp(1)));
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        return_rsci_d <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        asn_itm_3 <= '0';
        asn_itm_2 <= '0';
        asn_itm_1 <= '0';
        main_stage_0_2 <= '0';
        main_stage_0_3 <= '0';
        main_stage_0_4 <= '0';
      ELSIF ( ccs_ccore_en = '1' ) THEN
        return_rsci_d <= MUX_v_64_2_2(result_sva_duc_mx0, STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(qelse_acc_nl),
            64)), result_sva_duc_mx0(63));
        asn_itm_3 <= asn_itm_2;
        asn_itm_2 <= asn_itm_1;
        asn_itm_1 <= ccs_ccore_start_rsci_idat;
        main_stage_0_2 <= '1';
        main_stage_0_3 <= main_stage_0_2;
        main_stage_0_4 <= main_stage_0_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        m_buf_sva_4 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        rem_4cyc_st_4 <= STD_LOGIC_VECTOR'( "00");
      ELSIF ( m_and_cse = '1' ) THEN
        m_buf_sva_4 <= m_buf_sva_3;
        rem_4cyc_st_4 <= rem_4cyc_st_3;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_4_cmp_1_b_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        rem_4_cmp_1_a_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_7_cse = '1' ) THEN
        rem_4_cmp_1_b_63_0 <= m_rsci_idat;
        rem_4_cmp_1_a_63_0 <= base_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_4_cmp_2_b_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        rem_4_cmp_2_a_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_9_cse = '1' ) THEN
        rem_4_cmp_2_b_63_0 <= m_rsci_idat;
        rem_4_cmp_2_a_63_0 <= base_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_4_cmp_3_b_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        rem_4_cmp_3_a_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_11_cse = '1' ) THEN
        rem_4_cmp_3_b_63_0 <= m_rsci_idat;
        rem_4_cmp_3_a_63_0 <= base_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_4_cmp_b_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
        rem_4_cmp_a_63_0 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_13_cse = '1' ) THEN
        rem_4_cmp_b_63_0 <= m_rsci_idat;
        rem_4_cmp_a_63_0 <= base_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_4cyc_st_3 <= STD_LOGIC_VECTOR'( "00");
        m_buf_sva_3 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_17_cse = '1' ) THEN
        rem_4cyc_st_3 <= rem_4cyc_st_2;
        m_buf_sva_3 <= m_buf_sva_2;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_4cyc_st_2 <= STD_LOGIC_VECTOR'( "00");
        m_buf_sva_2 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_18_cse = '1' ) THEN
        rem_4cyc_st_2 <= rem_4cyc;
        m_buf_sva_2 <= m_buf_sva_1;
      END IF;
    END IF;
  END PROCESS;
  PROCESS (ccs_ccore_clk)
  BEGIN
    IF ccs_ccore_clk'EVENT AND ( ccs_ccore_clk = '1' ) THEN
      IF (ccs_ccore_srst = '1') THEN
        rem_4cyc <= STD_LOGIC_VECTOR'( "00");
        m_buf_sva_1 <= STD_LOGIC_VECTOR'( "0000000000000000000000000000000000000000000000000000000000000000");
      ELSIF ( and_15_cse = '1' ) THEN
        rem_4cyc <= acc_tmp;
        m_buf_sva_1 <= m_rsci_idat;
      END IF;
    END IF;
  END PROCESS;
  qelse_acc_nl <= STD_LOGIC_VECTOR(CONV_UNSIGNED(UNSIGNED(result_sva_duc_mx0) + UNSIGNED(m_buf_sva_4),
      64));
END v1;

-- ------------------------------------------------------------------
--  Design Unit:     modulo_dev
-- ------------------------------------------------------------------

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
library mgc_hls;
USE mgc_hls.DIT_RELOOP_ccs_in_pkg_v1.ALL;
USE mgc_hls.DIT_RELOOP_mgc_out_dreg_pkg_v2.ALL;
USE mgc_hls.DIT_RELOOP_mgc_comps.ALL;


ENTITY DIT_RELOOP_modulo_dev IS
  PORT(
    base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
    return_rsc_z : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
    ccs_ccore_start_rsc_dat : IN STD_LOGIC;
    ccs_ccore_clk : IN STD_LOGIC;
    ccs_ccore_srst : IN STD_LOGIC;
    ccs_ccore_en : IN STD_LOGIC
  );
END DIT_RELOOP_modulo_dev;

ARCHITECTURE v1 OF DIT_RELOOP_modulo_dev IS
  -- Default Constants

  COMPONENT DIT_RELOOP_modulo_dev_core
    PORT(
      base_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      m_rsc_dat : IN STD_LOGIC_VECTOR (63 DOWNTO 0);
      return_rsc_z : OUT STD_LOGIC_VECTOR (63 DOWNTO 0);
      ccs_ccore_start_rsc_dat : IN STD_LOGIC;
      ccs_ccore_clk : IN STD_LOGIC;
      ccs_ccore_srst : IN STD_LOGIC;
      ccs_ccore_en : IN STD_LOGIC
    );
  END COMPONENT;
  SIGNAL modulo_dev_core_inst_base_rsc_dat :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_core_inst_m_rsc_dat :  STD_LOGIC_VECTOR (63 DOWNTO 0);
  SIGNAL modulo_dev_core_inst_return_rsc_z :  STD_LOGIC_VECTOR (63 DOWNTO 0);

BEGIN
  modulo_dev_core_inst :  DIT_RELOOP_modulo_dev_core
    PORT MAP(
      base_rsc_dat => modulo_dev_core_inst_base_rsc_dat,
      m_rsc_dat => modulo_dev_core_inst_m_rsc_dat,
      return_rsc_z => modulo_dev_core_inst_return_rsc_z,
      ccs_ccore_start_rsc_dat => ccs_ccore_start_rsc_dat,
      ccs_ccore_clk => ccs_ccore_clk,
      ccs_ccore_srst => ccs_ccore_srst,
      ccs_ccore_en => ccs_ccore_en
    );
  modulo_dev_core_inst_base_rsc_dat <= base_rsc_dat;
  modulo_dev_core_inst_m_rsc_dat <= m_rsc_dat;
  return_rsc_z <= modulo_dev_core_inst_return_rsc_z;

END v1;



