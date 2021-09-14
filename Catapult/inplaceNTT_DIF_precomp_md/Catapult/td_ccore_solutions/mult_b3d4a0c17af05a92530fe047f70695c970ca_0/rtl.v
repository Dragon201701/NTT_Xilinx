// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 16:20:57 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    mult_core_wait_dp
// ------------------------------------------------------------------


module mult_core_wait_dp (
  ccs_ccore_clk, ccs_ccore_en, ensig_cgo_iro, z_mul_cmp_z, z_mul_cmp_1_z, ensig_cgo,
      t_mul_cmp_en, z_mul_cmp_z_oreg, z_mul_cmp_1_z_oreg
);
  input ccs_ccore_clk;
  input ccs_ccore_en;
  input ensig_cgo_iro;
  input [31:0] z_mul_cmp_z;
  input [31:0] z_mul_cmp_1_z;
  input ensig_cgo;
  output t_mul_cmp_en;
  output [31:0] z_mul_cmp_z_oreg;
  reg [31:0] z_mul_cmp_z_oreg;
  output [31:0] z_mul_cmp_1_z_oreg;
  reg [31:0] z_mul_cmp_1_z_oreg;



  // Interconnect Declarations for Component Instantiations 
  assign t_mul_cmp_en = ccs_ccore_en & (ensig_cgo | ensig_cgo_iro);
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
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
      ccs_ccore_clk, ccs_ccore_srst, ccs_ccore_en, z_mul_cmp_a, z_mul_cmp_b, z_mul_cmp_z,
      z_mul_cmp_1_a, z_mul_cmp_1_b, z_mul_cmp_1_z
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
  output [31:0] z_mul_cmp_a;
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
  wire t_mul_cmp_en;
  wire [63:0] t_mul_cmp_z;
  wire [31:0] z_mul_cmp_z_oreg;
  wire [31:0] z_mul_cmp_1_z_oreg;
  wire and_dcpl;
  reg main_stage_0_2;
  reg VEC_LOOP_asn_itm_1;
  reg main_stage_0_4;
  reg VEC_LOOP_asn_itm_3;
  reg slc_32_svs_1;
  reg VEC_LOOP_asn_itm_2;
  reg main_stage_0_3;
  reg reg_CGHpart_irsig_cse;
  reg [31:0] reg_t_mul_cmp_a_cse;
  wire and_4_cse;
  wire and_8_cse;
  wire t_or_rmff;
  reg main_stage_0_5;
  reg main_stage_0_6;
  reg [31:0] p_buf_sva_1;
  reg [31:0] p_buf_sva_2;
  reg [31:0] p_buf_sva_3;
  reg [31:0] p_buf_sva_5;
  reg [31:0] p_buf_sva_6;
  reg [31:0] res_sva_1;
  reg [31:0] z_asn_itm_1;
  reg [31:0] z_asn_itm_2;
  reg [31:0] z_asn_itm_3;
  reg VEC_LOOP_asn_itm_4;
  reg VEC_LOOP_asn_itm_5;
  wire [31:0] res_sva_3;
  wire [32:0] nl_res_sva_3;
  wire res_and_cse;
  wire p_and_2_cse;
  wire p_and_1_cse;
  wire if_acc_1_itm_32_1;

  wire[31:0] if_acc_nl;
  wire[32:0] nl_if_acc_nl;
  wire[32:0] if_acc_1_nl;
  wire[33:0] nl_if_acc_1_nl;

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
  mgc_mul_pipe #(.width_a(32'sd32),
  .signd_a(32'sd0),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd64),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) t_mul_cmp (
      .a(x_rsci_idat),
      .b(y_rsci_idat_1),
      .clk(ccs_ccore_clk),
      .en(t_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(ccs_ccore_srst),
      .z(t_mul_cmp_z)
    );
  mult_core_wait_dp mult_core_wait_dp_inst (
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_en(ccs_ccore_en),
      .ensig_cgo_iro(t_or_rmff),
      .z_mul_cmp_z(z_mul_cmp_z),
      .z_mul_cmp_1_z(z_mul_cmp_1_z),
      .ensig_cgo(reg_CGHpart_irsig_cse),
      .t_mul_cmp_en(t_mul_cmp_en),
      .z_mul_cmp_z_oreg(z_mul_cmp_z_oreg),
      .z_mul_cmp_1_z_oreg(z_mul_cmp_1_z_oreg)
    );
  assign res_and_cse = ccs_ccore_en & and_dcpl;
  assign p_and_1_cse = ccs_ccore_en & and_8_cse;
  assign t_or_rmff = and_8_cse | and_4_cse | ccs_ccore_start_rsci_idat;
  assign z_mul_cmp_a = reg_t_mul_cmp_a_cse;
  assign p_and_2_cse = ccs_ccore_en & main_stage_0_5 & VEC_LOOP_asn_itm_4;
  assign and_4_cse = main_stage_0_2 & VEC_LOOP_asn_itm_1;
  assign nl_res_sva_3 = z_asn_itm_3 - z_mul_cmp_1_z_oreg;
  assign res_sva_3 = nl_res_sva_3[31:0];
  assign nl_if_acc_1_nl = ({1'b1 , res_sva_3}) + conv_u2u_32_33(~ p_buf_sva_5) +
      33'b000000000000000000000000000000001;
  assign if_acc_1_nl = nl_if_acc_1_nl[32:0];
  assign if_acc_1_itm_32_1 = readslicef_33_1_32(if_acc_1_nl);
  assign and_8_cse = main_stage_0_3 & VEC_LOOP_asn_itm_2;
  assign and_dcpl = main_stage_0_6 & VEC_LOOP_asn_itm_5;
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_32_2_2(if_acc_nl, res_sva_1, slc_32_svs_1);
      z_mul_cmp_1_b <= p_buf_sva_3;
      z_mul_cmp_1_a <= t_mul_cmp_z[63:32];
      reg_t_mul_cmp_a_cse <= x_rsci_idat;
      z_mul_cmp_b <= y_rsci_idat;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      VEC_LOOP_asn_itm_5 <= 1'b0;
      VEC_LOOP_asn_itm_3 <= 1'b0;
      reg_CGHpart_irsig_cse <= 1'b0;
      VEC_LOOP_asn_itm_2 <= 1'b0;
      VEC_LOOP_asn_itm_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      main_stage_0_6 <= 1'b0;
      VEC_LOOP_asn_itm_4 <= 1'b0;
      main_stage_0_5 <= 1'b0;
    end
    else if ( ccs_ccore_en ) begin
      VEC_LOOP_asn_itm_5 <= VEC_LOOP_asn_itm_4;
      VEC_LOOP_asn_itm_3 <= VEC_LOOP_asn_itm_2;
      reg_CGHpart_irsig_cse <= t_or_rmff;
      VEC_LOOP_asn_itm_2 <= VEC_LOOP_asn_itm_1;
      VEC_LOOP_asn_itm_1 <= ccs_ccore_start_rsci_idat;
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      main_stage_0_4 <= main_stage_0_3;
      main_stage_0_6 <= main_stage_0_5;
      VEC_LOOP_asn_itm_4 <= VEC_LOOP_asn_itm_3;
      main_stage_0_5 <= main_stage_0_4;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( res_and_cse ) begin
      res_sva_1 <= res_sva_3;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      slc_32_svs_1 <= 1'b0;
    end
    else if ( res_and_cse ) begin
      slc_32_svs_1 <= if_acc_1_itm_32_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & and_dcpl & (~ if_acc_1_itm_32_1) ) begin
      p_buf_sva_6 <= p_buf_sva_5;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( p_and_1_cse ) begin
      p_buf_sva_3 <= p_buf_sva_2;
      z_asn_itm_1 <= z_mul_cmp_z_oreg;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( p_and_2_cse ) begin
      p_buf_sva_5 <= z_mul_cmp_1_b;
      z_asn_itm_3 <= z_asn_itm_2;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & and_4_cse ) begin
      p_buf_sva_2 <= p_buf_sva_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & main_stage_0_4 & VEC_LOOP_asn_itm_3 ) begin
      z_asn_itm_2 <= z_asn_itm_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & ccs_ccore_start_rsci_idat ) begin
      p_buf_sva_1 <= p_rsci_idat;
    end
  end
  assign nl_if_acc_nl = res_sva_1 - p_buf_sva_6;
  assign if_acc_nl = nl_if_acc_nl[31:0];

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
  wire [31:0] z_mul_cmp_a;
  wire [31:0] z_mul_cmp_b;
  wire [31:0] z_mul_cmp_1_a;
  wire [31:0] z_mul_cmp_1_b;


  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_mult_core_inst_z_mul_cmp_z;
  assign nl_mult_core_inst_z_mul_cmp_z = conv_u2u_64_32(z_mul_cmp_a * z_mul_cmp_b);
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
      .z_mul_cmp_a(z_mul_cmp_a),
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

endmodule



