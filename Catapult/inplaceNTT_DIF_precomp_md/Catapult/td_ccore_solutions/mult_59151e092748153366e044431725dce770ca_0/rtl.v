// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Sat Sep 11 12:28:00 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    mult_core_wait_dp
// ------------------------------------------------------------------


module mult_core_wait_dp (
  ccs_ccore_clk, ccs_ccore_en, t_mul_cmp_z, z_mul_cmp_z, z_mul_cmp_1_z, t_mul_cmp_z_oreg,
      z_mul_cmp_z_oreg, z_mul_cmp_1_z_oreg
);
  input ccs_ccore_clk;
  input ccs_ccore_en;
  input [63:0] t_mul_cmp_z;
  input [31:0] z_mul_cmp_z;
  input [31:0] z_mul_cmp_1_z;
  output [31:0] t_mul_cmp_z_oreg;
  output [31:0] z_mul_cmp_z_oreg;
  reg [31:0] z_mul_cmp_z_oreg;
  output [31:0] z_mul_cmp_1_z_oreg;
  reg [31:0] z_mul_cmp_1_z_oreg;


  // Interconnect Declarations
  reg [31:0] t_mul_cmp_z_oreg_pconst_63_32;


  // Interconnect Declarations for Component Instantiations 
  assign t_mul_cmp_z_oreg = t_mul_cmp_z_oreg_pconst_63_32;
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      t_mul_cmp_z_oreg_pconst_63_32 <= t_mul_cmp_z[63:32];
      z_mul_cmp_z_oreg <= z_mul_cmp_z;
      z_mul_cmp_1_z_oreg <= z_mul_cmp_1_z;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult_core
// ------------------------------------------------------------------


module mult_core (
  x_rsc_dat, y_rsc_dat, y_rsc_dat_1, p_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat,
      ccs_ccore_clk, ccs_ccore_srst, ccs_ccore_en, t_mul_cmp_a, t_mul_cmp_b, t_mul_cmp_z,
      z_mul_cmp_b, z_mul_cmp_z, z_mul_cmp_1_a, z_mul_cmp_1_b, z_mul_cmp_1_z
);
  input [31:0] x_rsc_dat;
  input [31:0] y_rsc_dat;
  input [31:0] y_rsc_dat_1;
  input [31:0] p_rsc_dat;
  output [31:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;
  output [31:0] t_mul_cmp_a;
  output [31:0] t_mul_cmp_b;
  reg [31:0] t_mul_cmp_b;
  input [63:0] t_mul_cmp_z;
  output [31:0] z_mul_cmp_b;
  reg [31:0] z_mul_cmp_b;
  input [31:0] z_mul_cmp_z;
  output [31:0] z_mul_cmp_1_a;
  reg [31:0] z_mul_cmp_1_a;
  output [31:0] z_mul_cmp_1_b;
  reg [31:0] z_mul_cmp_1_b;
  input [31:0] z_mul_cmp_1_z;


  // Interconnect Declarations
  wire [31:0] x_rsci_idat;
  wire [31:0] y_rsci_idat;
  wire [31:0] y_rsci_idat_1;
  wire [31:0] p_rsci_idat;
  reg [31:0] return_rsci_d;
  wire ccs_ccore_start_rsci_idat;
  wire [31:0] t_mul_cmp_z_oreg;
  wire [31:0] z_mul_cmp_z_oreg;
  wire [31:0] z_mul_cmp_1_z_oreg;
  reg main_stage_0_2;
  reg VEC_LOOP_asn_itm_1;
  reg main_stage_0_3;
  reg VEC_LOOP_asn_itm_2;
  wire [31:0] res_sva_1;
  wire [32:0] nl_res_sva_1;
  reg [31:0] p_buf_sva_4;
  reg [31:0] reg_t_mul_cmp_a_cse;
  reg main_stage_0_4;
  reg [31:0] p_buf_sva_1;
  reg [31:0] p_buf_sva_2;
  reg [31:0] z_asn_itm_1;
  reg [31:0] z_asn_itm_2;
  reg VEC_LOOP_asn_itm_3;
  wire p_and_cse;

  wire[31:0] if_acc_nl;
  wire[32:0] nl_if_acc_nl;
  wire[32:0] acc_nl;
  wire[33:0] nl_acc_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_in_v1 #(.rscid(32'sd7),
  .width(32'sd32)) x_rsci (
      .dat(x_rsc_dat),
      .idat(x_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd8),
  .width(32'sd32)) y_rsci (
      .dat(y_rsc_dat),
      .idat(y_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd9),
  .width(32'sd32)) y_rsci_1 (
      .dat(y_rsc_dat_1),
      .idat(y_rsci_idat_1)
    );
  ccs_in_v1 #(.rscid(32'sd10),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd11),
  .width(32'sd32)) return_rsci (
      .d(return_rsci_d),
      .z(return_rsc_z)
    );
  ccs_in_v1 #(.rscid(32'sd19),
  .width(32'sd1)) ccs_ccore_start_rsci (
      .dat(ccs_ccore_start_rsc_dat),
      .idat(ccs_ccore_start_rsci_idat)
    );
  mult_core_wait_dp mult_core_wait_dp_inst (
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_en(ccs_ccore_en),
      .t_mul_cmp_z(t_mul_cmp_z),
      .z_mul_cmp_z(z_mul_cmp_z),
      .z_mul_cmp_1_z(z_mul_cmp_1_z),
      .t_mul_cmp_z_oreg(t_mul_cmp_z_oreg),
      .z_mul_cmp_z_oreg(z_mul_cmp_z_oreg),
      .z_mul_cmp_1_z_oreg(z_mul_cmp_1_z_oreg)
    );
  assign p_and_cse = ccs_ccore_en & main_stage_0_4 & VEC_LOOP_asn_itm_3;
  assign t_mul_cmp_a = reg_t_mul_cmp_a_cse;
  assign nl_res_sva_1 = z_asn_itm_2 - z_mul_cmp_1_z_oreg;
  assign res_sva_1 = nl_res_sva_1[31:0];
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_32_2_2(if_acc_nl, res_sva_1, readslicef_33_1_32(acc_nl));
      z_mul_cmp_1_b <= p_buf_sva_2;
      z_mul_cmp_1_a <= t_mul_cmp_z_oreg;
      t_mul_cmp_b <= y_rsci_idat_1;
      reg_t_mul_cmp_a_cse <= x_rsci_idat;
      z_mul_cmp_b <= y_rsci_idat;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      VEC_LOOP_asn_itm_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      VEC_LOOP_asn_itm_1 <= 1'b0;
      VEC_LOOP_asn_itm_3 <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_4 <= 1'b0;
    end
    else if ( ccs_ccore_en ) begin
      VEC_LOOP_asn_itm_2 <= VEC_LOOP_asn_itm_1;
      main_stage_0_3 <= main_stage_0_2;
      VEC_LOOP_asn_itm_1 <= ccs_ccore_start_rsci_idat;
      VEC_LOOP_asn_itm_3 <= VEC_LOOP_asn_itm_2;
      main_stage_0_2 <= 1'b1;
      main_stage_0_4 <= main_stage_0_3;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( p_and_cse ) begin
      p_buf_sva_4 <= z_mul_cmp_1_b;
      z_asn_itm_2 <= z_asn_itm_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & main_stage_0_2 & VEC_LOOP_asn_itm_1 ) begin
      p_buf_sva_2 <= p_buf_sva_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & main_stage_0_3 & VEC_LOOP_asn_itm_2 ) begin
      z_asn_itm_1 <= z_mul_cmp_z_oreg;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & ccs_ccore_start_rsci_idat ) begin
      p_buf_sva_1 <= p_rsci_idat;
    end
  end
  assign nl_if_acc_nl = res_sva_1 - p_buf_sva_4;
  assign if_acc_nl = nl_if_acc_nl[31:0];
  assign nl_acc_nl = ({1'b1 , res_sva_1}) + conv_u2u_32_33(~ p_buf_sva_4) + 33'b000000000000000000000000000000001;
  assign acc_nl = nl_acc_nl[32:0];

  function automatic [31:0] MUX_v_32_2_2;
    input [31:0] input_0;
    input [31:0] input_1;
    input [0:0] sel;
    reg [31:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_32_2_2 = result;
  end
  endfunction


  function automatic [0:0] readslicef_33_1_32;
    input [32:0] vector;
    reg [32:0] tmp;
  begin
    tmp = vector >> 32;
    readslicef_33_1_32 = tmp[0:0];
  end
  endfunction


  function automatic [32:0] conv_u2u_32_33 ;
    input [31:0]  vector ;
  begin
    conv_u2u_32_33 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    mult
// ------------------------------------------------------------------


module mult (
  x_rsc_dat, y_rsc_dat, y_rsc_dat_1, p_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat,
      ccs_ccore_clk, ccs_ccore_srst, ccs_ccore_en
);
  input [31:0] x_rsc_dat;
  input [31:0] y_rsc_dat;
  input [31:0] y_rsc_dat_1;
  input [31:0] p_rsc_dat;
  output [31:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;


  // Interconnect Declarations
  wire [31:0] t_mul_cmp_a;
  wire [31:0] t_mul_cmp_b;
  wire [31:0] z_mul_cmp_b;
  wire [31:0] z_mul_cmp_1_a;
  wire [31:0] z_mul_cmp_1_b;


  // Interconnect Declarations for Component Instantiations 
  wire [63:0] nl_mult_core_inst_t_mul_cmp_z;
  assign nl_mult_core_inst_t_mul_cmp_z = conv_u2u_64_64(t_mul_cmp_a * t_mul_cmp_b);
  wire [31:0] nl_mult_core_inst_z_mul_cmp_z;
  assign nl_mult_core_inst_z_mul_cmp_z = conv_u2u_64_32(t_mul_cmp_a * z_mul_cmp_b);
  wire [31:0] nl_mult_core_inst_z_mul_cmp_1_z;
  assign nl_mult_core_inst_z_mul_cmp_1_z = conv_u2u_64_32(z_mul_cmp_1_a * z_mul_cmp_1_b);
  mult_core mult_core_inst (
      .x_rsc_dat(x_rsc_dat),
      .y_rsc_dat(y_rsc_dat),
      .y_rsc_dat_1(y_rsc_dat_1),
      .p_rsc_dat(p_rsc_dat),
      .return_rsc_z(return_rsc_z),
      .ccs_ccore_start_rsc_dat(ccs_ccore_start_rsc_dat),
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_srst(ccs_ccore_srst),
      .ccs_ccore_en(ccs_ccore_en),
      .t_mul_cmp_a(t_mul_cmp_a),
      .t_mul_cmp_b(t_mul_cmp_b),
      .t_mul_cmp_z(nl_mult_core_inst_t_mul_cmp_z[63:0]),
      .z_mul_cmp_b(z_mul_cmp_b),
      .z_mul_cmp_z(nl_mult_core_inst_z_mul_cmp_z[31:0]),
      .z_mul_cmp_1_a(z_mul_cmp_1_a),
      .z_mul_cmp_1_b(z_mul_cmp_1_b),
      .z_mul_cmp_1_z(nl_mult_core_inst_z_mul_cmp_1_z[31:0])
    );

  function automatic [31:0] conv_u2u_64_32 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_32 = vector[31:0];
  end
  endfunction


  function automatic [63:0] conv_u2u_64_64 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_64 = vector;
  end
  endfunction

endmodule



