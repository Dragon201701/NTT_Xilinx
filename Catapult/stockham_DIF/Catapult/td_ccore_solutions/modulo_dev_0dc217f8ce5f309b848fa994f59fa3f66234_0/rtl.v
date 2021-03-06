// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Wed Aug 18 22:11:42 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    modulo_dev_core
// ------------------------------------------------------------------


module modulo_dev_core (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat, ccs_ccore_clk,
      ccs_ccore_srst, ccs_ccore_en
);
  input [63:0] base_rsc_dat;
  input [63:0] m_rsc_dat;
  output [63:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;


  // Interconnect Declarations
  wire [63:0] base_rsci_idat;
  wire [63:0] m_rsci_idat;
  reg [63:0] return_rsci_d;
  wire ccs_ccore_start_rsci_idat;
  wire [64:0] rem_2_cmp_z;
  wire [64:0] rem_2_cmp_1_z;
  reg [63:0] rem_2_cmp_b_63_0;
  reg [63:0] rem_2_cmp_1_b_63_0;
  reg [63:0] rem_2_cmp_a_63_0;
  reg [63:0] rem_2_cmp_1_a_63_0;
  wire and_dcpl;
  reg rem_2cyc;
  reg rem_2cyc_st_2;
  reg [63:0] result_sva_1;
  wire and_3_cse;
  wire and_5_cse;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg [63:0] m_buf_sva_1;
  reg [63:0] m_buf_sva_2;
  reg [63:0] m_buf_sva_3;
  reg asn_itm_1;
  reg asn_itm_2;
  wire and_8_cse;
  wire and_7_cse;

  wire[63:0] qelse_acc_nl;
  wire[64:0] nl_qelse_acc_nl;
  wire[0:0] mux_2_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_rem_2_cmp_a;
  assign nl_rem_2_cmp_a = {{1{rem_2_cmp_a_63_0[63]}}, rem_2_cmp_a_63_0};
  wire [64:0] nl_rem_2_cmp_b;
  assign nl_rem_2_cmp_b = {1'b0 , rem_2_cmp_b_63_0};
  wire [64:0] nl_rem_2_cmp_1_a;
  assign nl_rem_2_cmp_1_a = {{1{rem_2_cmp_1_a_63_0[63]}}, rem_2_cmp_1_a_63_0};
  wire [64:0] nl_rem_2_cmp_1_b;
  assign nl_rem_2_cmp_1_b = {1'b0 , rem_2_cmp_1_b_63_0};
  ccs_in_v1 #(.rscid(32'sd1),
  .width(32'sd64)) base_rsci (
      .dat(base_rsc_dat),
      .idat(base_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) m_rsci (
      .dat(m_rsc_dat),
      .idat(m_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd3),
  .width(32'sd64)) return_rsci (
      .d(return_rsci_d),
      .z(return_rsc_z)
    );
  ccs_in_v1 #(.rscid(32'sd8),
  .width(32'sd1)) ccs_ccore_start_rsci (
      .dat(ccs_ccore_start_rsc_dat),
      .idat(ccs_ccore_start_rsci_idat)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_2_cmp (
      .a(nl_rem_2_cmp_a[64:0]),
      .b(nl_rem_2_cmp_b[64:0]),
      .z(rem_2_cmp_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_2_cmp_1 (
      .a(nl_rem_2_cmp_1_a[64:0]),
      .b(nl_rem_2_cmp_1_b[64:0]),
      .z(rem_2_cmp_1_z)
    );
  assign and_8_cse = ccs_ccore_en & main_stage_0_2 & asn_itm_1;
  assign and_3_cse = ccs_ccore_en & rem_2cyc;
  assign and_5_cse = ccs_ccore_en & (~ rem_2cyc);
  assign and_7_cse = ccs_ccore_en & ccs_ccore_start_rsci_idat;
  assign and_dcpl = main_stage_0_3 & asn_itm_2;
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      return_rsci_d <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      asn_itm_2 <= 1'b0;
      asn_itm_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
    end
    else if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_64_2_2(result_sva_1, qelse_acc_nl, result_sva_1[63]);
      asn_itm_2 <= asn_itm_1;
      asn_itm_1 <= ccs_ccore_start_rsci_idat;
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      result_sva_1 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ccs_ccore_en & and_dcpl ) begin
      result_sva_1 <= MUX_v_64_2_2((rem_2_cmp_1_z[63:0]), (rem_2_cmp_z[63:0]), rem_2cyc_st_2);
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      m_buf_sva_3 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ccs_ccore_en & mux_2_nl & and_dcpl ) begin
      m_buf_sva_3 <= m_buf_sva_2;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2cyc_st_2 <= 1'b0;
      m_buf_sva_2 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_8_cse ) begin
      rem_2cyc_st_2 <= rem_2cyc;
      m_buf_sva_2 <= m_buf_sva_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2_cmp_1_b_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      rem_2_cmp_1_a_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_3_cse ) begin
      rem_2_cmp_1_b_63_0 <= m_rsci_idat;
      rem_2_cmp_1_a_63_0 <= base_rsci_idat;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2_cmp_b_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      rem_2_cmp_a_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_5_cse ) begin
      rem_2_cmp_b_63_0 <= m_rsci_idat;
      rem_2_cmp_a_63_0 <= base_rsci_idat;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2cyc <= 1'b0;
      m_buf_sva_1 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_7_cse ) begin
      rem_2cyc <= ~ rem_2cyc;
      m_buf_sva_1 <= m_rsci_idat;
    end
  end
  assign nl_qelse_acc_nl = result_sva_1 + m_buf_sva_3;
  assign qelse_acc_nl = nl_qelse_acc_nl[63:0];
  assign mux_2_nl = MUX_s_1_2_2((rem_2_cmp_1_z[63]), (rem_2_cmp_z[63]), rem_2cyc_st_2);

  function automatic [0:0] MUX_s_1_2_2;
    input [0:0] input_0;
    input [0:0] input_1;
    input [0:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function automatic [63:0] MUX_v_64_2_2;
    input [63:0] input_0;
    input [63:0] input_1;
    input [0:0] sel;
    reg [63:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_64_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    modulo_dev
// ------------------------------------------------------------------


module modulo_dev (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat, ccs_ccore_clk,
      ccs_ccore_srst, ccs_ccore_en
);
  input [63:0] base_rsc_dat;
  input [63:0] m_rsc_dat;
  output [63:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  modulo_dev_core modulo_dev_core_inst (
      .base_rsc_dat(base_rsc_dat),
      .m_rsc_dat(m_rsc_dat),
      .return_rsc_z(return_rsc_z),
      .ccs_ccore_start_rsc_dat(ccs_ccore_start_rsc_dat),
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_srst(ccs_ccore_srst),
      .ccs_ccore_en(ccs_ccore_en)
    );
endmodule



