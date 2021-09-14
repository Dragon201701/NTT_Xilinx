
//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_sync_in_wait_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2015 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------

module ccs_sync_in_wait_v1 (rdy, vld, irdy, ivld);
  parameter integer rscid = 1;

  output rdy;
  input  vld;
  input  irdy;
  output ivld;

  wire   ivld;
  wire   rdy;

  assign ivld = vld;
  assign rdy = irdy;
endmodule

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_sync_out_wait_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2015 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------

module ccs_sync_out_wait_v1 (vld, irdy, ivld, rdy);
  parameter integer rscid = 1;

  input  ivld;
  output irdy;
  output vld;
  input  rdy;

  wire   irdy;
  wire   vld;

  assign vld = ivld;
  assign irdy = rdy;
endmodule

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_io_sync_v2.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module mgc_io_sync_v2 (ld, lz);
    parameter valid = 0;

    input  ld;
    output lz;

    wire   lz;

    assign lz = ld;

endmodule


//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_in_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module ccs_in_v1 (idat, dat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] idat;
  input  [width-1:0] dat;

  wire   [width-1:0] idat;

  assign idat = dat;

endmodule


//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_out_dreg_v2.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2017 Mentor Graphics Corp.
//       All Rights Reserved
//
// This document may be used and distributed without restriction provided that
// this copyright statement is not removed from the file and that any derivative
// work contains this copyright notice.
//
// The design information contained in this file is intended to be an example
// of the functionality which the end user may study in preparation for creating
// their own custom interfaces. This design does not necessarily present a 
// complete implementation of the named protocol or standard.
//
//------------------------------------------------------------------------------


module mgc_out_dreg_v2 (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input    [width-1:0] d;
  output   [width-1:0] z;

  wire     [width-1:0] z;

  assign z = d;

endmodule

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_mul_pipe_beh.v 
//
// File:      $Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_mul_pipe_beh.v
//
// BASELINE:  Catapult-C version 2006b.63
// MODIFIED:  2007-04-03, tnagler
//
// Note: this file uses Verilog2001 features; 
//       please enable Verilog2001 in the flow!

module mgc_mul_pipe (a, b, clk, en, a_rst, s_rst, z);

    // Parameters:
    parameter integer width_a = 32'd4;  // input a bit width
    parameter         signd_a =  1'b1;  // input a type (1=signed, 0=unsigned)
    parameter integer width_b = 32'd4;  // input b bit width
    parameter         signd_b =  1'b1;  // input b type (1=signed, 0=unsigned)
    parameter integer width_z = 32'd8;  // result bit width (= width_a + width_b)
    parameter      clock_edge =  1'b0;  // clock polarity (1=posedge, 0=negedge)
    parameter   enable_active =  1'b0;  // enable polarity (1=posedge, 0=negedge)
    parameter    a_rst_active =  1'b1;  // unused
    parameter    s_rst_active =  1'b1;  // unused
    parameter integer  stages = 32'd2;  // number of output registers + 1 (careful!)
    parameter integer n_inreg = 32'd0;  // number of input registers
   
    localparam integer width_ab = width_a + width_b;  // multiplier result width
    localparam integer n_inreg_min = (n_inreg > 1) ? (n_inreg-1) : 0; // for Synopsys DC
   
    // I/O ports:
    input  [width_a-1:0] a;      // input A
    input  [width_b-1:0] b;      // input B
    input                clk;    // clock
    input                en;     // enable
    input                a_rst;  // async reset (unused)
    input                s_rst;  // sync reset (unused)
    output [width_z-1:0] z;      // output


    // Input registers:

    wire [width_a-1:0] a_f;
    wire [width_b-1:0] b_f;

    integer i;

    generate
    if (clock_edge == 1'b0)
    begin: NEG_EDGE1
        case (n_inreg)
        32'd0: begin: B1
            assign a_f = a, 
                   b_f = b;
        end
        default: begin: B2
            reg [width_a-1:0] a_reg [n_inreg_min:0];
            reg [width_b-1:0] b_reg [n_inreg_min:0];
            always @(negedge clk)
            if (en == enable_active)
            begin: B21
                a_reg[0] <= a;
                b_reg[0] <= b;
                for (i = 0; i < n_inreg_min; i = i + 1)
                begin: B3
                    a_reg[i+1] <= a_reg[i];
                    b_reg[i+1] <= b_reg[i];
                end
            end
            assign a_f = a_reg[n_inreg_min],
                   b_f = b_reg[n_inreg_min];
        end
        endcase
    end
    else
    begin: POS_EDGE1
        case (n_inreg)
        32'd0: begin: B1
            assign a_f = a, 
                   b_f = b;
        end
        default: begin: B2
            reg [width_a-1:0] a_reg [n_inreg_min:0];
            reg [width_b-1:0] b_reg [n_inreg_min:0];
            always @(posedge clk)
            if (en == enable_active)
            begin: B21
                a_reg[0] <= a;
                b_reg[0] <= b;
                for (i = 0; i < n_inreg_min; i = i + 1)
                begin: B3
                    a_reg[i+1] <= a_reg[i];
                    b_reg[i+1] <= b_reg[i];
                end
            end
            assign a_f = a_reg[n_inreg_min],
                   b_f = b_reg[n_inreg_min];
        end
        endcase
    end
    endgenerate


    // Output:
    wire [width_z-1:0]  xz;

    function signed [width_z-1:0] conv_signed;
      input signed [width_ab-1:0] res;
      conv_signed = res[width_z-1:0];
    endfunction

    generate
      wire signed [width_ab-1:0] res;
      if ( (signd_a == 1'b1) && (signd_b == 1'b1) )
      begin: SIGNED_AB
              assign res = $signed(a_f) * $signed(b_f);
              assign xz = conv_signed(res);
      end
      else if ( (signd_a == 1'b1) && (signd_b == 1'b0) )
      begin: SIGNED_A
              assign res = $signed(a_f) * $signed({1'b0, b_f});
              assign xz = conv_signed(res);
      end
      else if ( (signd_a == 1'b0) && (signd_b == 1'b1) )
      begin: SIGNED_B
              assign res = $signed({1'b0,a_f}) * $signed(b_f);
              assign xz = conv_signed(res);
      end
      else
      begin: UNSIGNED_AB
              assign res = a_f * b_f;
	      assign xz = res[width_z-1:0];
      end
    endgenerate


    // Output registers:

    reg  [width_z-1:0] reg_array[stages-2:0];
    wire [width_z-1:0] z;

    generate
    if (clock_edge == 1'b0)
    begin: NEG_EDGE2
        always @(negedge clk)
        if (en == enable_active)
            for (i = stages-2; i >= 0; i = i-1)
                if (i == 0)
                    reg_array[i] <= xz;
                else
                    reg_array[i] <= reg_array[i-1];
    end
    else
    begin: POS_EDGE2
        always @(posedge clk)
        if (en == enable_active)
            for (i = stages-2; i >= 0; i = i-1)
                if (i == 0)
                    reg_array[i] <= xz;
                else
                    reg_array[i] <= reg_array[i-1];
    end
    endgenerate

    assign z = reg_array[stages-2];
endmodule

//------> ../td_ccore_solutions/mult_b3d4a0c17af05a92530fe047f70695c970ca_0/rtl.v 
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




//------> ../td_ccore_solutions/modulo_sub_cc250ff62aef060f45cde5681b558542635b_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 16:20:59 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    modulo_sub_core
// ------------------------------------------------------------------


module modulo_sub_core (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_clk, ccs_ccore_en
);
  input [31:0] base_rsc_dat;
  input [31:0] m_rsc_dat;
  output [31:0] return_rsc_z;
  input ccs_ccore_clk;
  input ccs_ccore_en;


  // Interconnect Declarations
  wire [31:0] base_rsci_idat;
  wire [31:0] m_rsci_idat;
  reg [31:0] return_rsci_d;

  wire[31:0] qif_acc_nl;
  wire[32:0] nl_qif_acc_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_in_v1 #(.rscid(32'sd4),
  .width(32'sd32)) base_rsci (
      .dat(base_rsc_dat),
      .idat(base_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd5),
  .width(32'sd32)) m_rsci (
      .dat(m_rsc_dat),
      .idat(m_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd6),
  .width(32'sd32)) return_rsci (
      .d(return_rsci_d),
      .z(return_rsc_z)
    );
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_32_2_2(({1'b0 , (base_rsci_idat[30:0])}), qif_acc_nl,
          base_rsci_idat[31]);
    end
  end
  assign nl_qif_acc_nl = ({1'b1 , (base_rsci_idat[30:0])}) + m_rsci_idat;
  assign qif_acc_nl = nl_qif_acc_nl[31:0];

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    modulo_sub
// ------------------------------------------------------------------


module modulo_sub (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat, ccs_ccore_clk,
      ccs_ccore_srst, ccs_ccore_en
);
  input [31:0] base_rsc_dat;
  input [31:0] m_rsc_dat;
  output [31:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  modulo_sub_core modulo_sub_core_inst (
      .base_rsc_dat(base_rsc_dat),
      .m_rsc_dat(m_rsc_dat),
      .return_rsc_z(return_rsc_z),
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_en(ccs_ccore_en)
    );
endmodule




//------> ../td_ccore_solutions/modulo_add_12aaf73a68dd9ce714254cc9a57be62160d2_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 16:21:00 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    modulo_add_core
// ------------------------------------------------------------------


module modulo_add_core (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_clk, ccs_ccore_en
);
  input [31:0] base_rsc_dat;
  input [31:0] m_rsc_dat;
  output [31:0] return_rsc_z;
  input ccs_ccore_clk;
  input ccs_ccore_en;


  // Interconnect Declarations
  wire [31:0] base_rsci_idat;
  wire [31:0] m_rsci_idat;
  reg [31:0] return_rsci_d;

  wire[31:0] qif_acc_nl;
  wire[32:0] nl_qif_acc_nl;
  wire[33:0] acc_nl;
  wire[34:0] nl_acc_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_in_v1 #(.rscid(32'sd1),
  .width(32'sd32)) base_rsci (
      .dat(base_rsc_dat),
      .idat(base_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd32)) m_rsci (
      .dat(m_rsc_dat),
      .idat(m_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd3),
  .width(32'sd32)) return_rsci (
      .d(return_rsci_d),
      .z(return_rsc_z)
    );
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_32_2_2(base_rsci_idat, qif_acc_nl, readslicef_34_1_33(acc_nl));
    end
  end
  assign nl_qif_acc_nl = base_rsci_idat - m_rsci_idat;
  assign qif_acc_nl = nl_qif_acc_nl[31:0];
  assign nl_acc_nl = conv_u2u_32_34(m_rsci_idat) - conv_s2u_32_34(base_rsci_idat);
  assign acc_nl = nl_acc_nl[33:0];

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


  function automatic [0:0] readslicef_34_1_33;
    input [33:0] vector;
    reg [33:0] tmp;
  begin
    tmp = vector >> 33;
    readslicef_34_1_33 = tmp[0:0];
  end
  endfunction


  function automatic [33:0] conv_s2u_32_34 ;
    input [31:0]  vector ;
  begin
    conv_s2u_32_34 = {{2{vector[31]}}, vector};
  end
  endfunction


  function automatic [33:0] conv_u2u_32_34 ;
    input [31:0]  vector ;
  begin
    conv_u2u_32_34 = {{2{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    modulo_add
// ------------------------------------------------------------------


module modulo_add (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat, ccs_ccore_clk,
      ccs_ccore_srst, ccs_ccore_en
);
  input [31:0] base_rsc_dat;
  input [31:0] m_rsc_dat;
  output [31:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  modulo_add_core modulo_add_core_inst (
      .base_rsc_dat(base_rsc_dat),
      .m_rsc_dat(m_rsc_dat),
      .return_rsc_z(return_rsc_z),
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_en(ccs_ccore_en)
    );
endmodule




//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_shift_l_beh_v5.v 
module mgc_shift_l_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate
   if (signd_a)
   begin: SGNED
      assign z = fshl_u(a,s,a[width_a-1]);
   end
   else
   begin: UNSGNED
      assign z = fshl_u(a,s,1'b0);
   end
   endgenerate

   //Shift-left - unsigned shift argument one bit more
   function [width_z-1:0] fshl_u_1;
      input [width_a  :0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg [len-1:0] result;
      reg [len-1:0] result_t;
      begin
        result_t = {(len){sbit}};
        result_t[ilen-1:0] = arg1;
        result = result_t <<< arg2;
        fshl_u_1 =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift-left - unsigned shift argument
   function [width_z-1:0] fshl_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      fshl_u = fshl_u_1({sbit,arg1} ,arg2, sbit);
   endfunction // fshl_u

endmodule

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 19:31:59 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_69_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_69_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_68_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_68_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_67_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_67_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_66_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_66_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_65_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_65_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_64_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_64_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_63_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_63_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_62_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_62_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_61_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_61_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_60_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_60_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_59_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_59_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_58_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_58_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_57_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_57_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_56_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_56_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_55_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_55_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_54_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_54_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_53_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_53_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_52_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_52_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_51_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_51_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_50_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_50_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_49_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_49_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_48_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_48_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_47_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_47_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_46_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_46_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_45_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_45_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_44_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_44_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_43_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_43_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_42_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_42_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_41_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_41_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_40_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_40_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_39_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_39_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_38_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_38_6_32_64_64_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [5:0] adrb;
  input [5:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_37_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_37_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_36_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_36_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_35_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_35_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_34_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_34_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_33_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_33_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_32_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_32_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_31_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_31_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_30_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_30_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_29_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_29_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_28_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_28_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_27_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_27_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_26_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_26_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_25_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_25_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_24_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_24_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_23_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_23_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_22_6_32_64_64_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_22_6_32_64_64_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [5:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [5:0] adra;
  input [11:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[11:6]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[5:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_core_fsm (
  clk, rst, complete_rsci_wen_comp, fsm_output, main_C_0_tr0, VEC_LOOP_C_11_tr0,
      COMP_LOOP_C_4_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [21:0] fsm_output;
  reg [21:0] fsm_output;
  input main_C_0_tr0;
  input VEC_LOOP_C_11_tr0;
  input COMP_LOOP_C_4_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIF_precomp_core_core_fsm_1
  parameter
    main_C_0 = 5'd0,
    STAGE_LOOP_C_0 = 5'd1,
    COMP_LOOP_C_0 = 5'd2,
    COMP_LOOP_C_1 = 5'd3,
    COMP_LOOP_C_2 = 5'd4,
    COMP_LOOP_C_3 = 5'd5,
    VEC_LOOP_C_0 = 5'd6,
    VEC_LOOP_C_1 = 5'd7,
    VEC_LOOP_C_2 = 5'd8,
    VEC_LOOP_C_3 = 5'd9,
    VEC_LOOP_C_4 = 5'd10,
    VEC_LOOP_C_5 = 5'd11,
    VEC_LOOP_C_6 = 5'd12,
    VEC_LOOP_C_7 = 5'd13,
    VEC_LOOP_C_8 = 5'd14,
    VEC_LOOP_C_9 = 5'd15,
    VEC_LOOP_C_10 = 5'd16,
    VEC_LOOP_C_11 = 5'd17,
    COMP_LOOP_C_4 = 5'd18,
    STAGE_LOOP_C_1 = 5'd19,
    main_C_1 = 5'd20,
    main_C_2 = 5'd21;

  reg [4:0] state_var;
  reg [4:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIF_precomp_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 22'b0000000000000000000010;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 22'b0000000000000000000100;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 22'b0000000000000000001000;
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 22'b0000000000000000010000;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 22'b0000000000000000100000;
        state_var_NS = VEC_LOOP_C_0;
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 22'b0000000000000001000000;
        state_var_NS = VEC_LOOP_C_1;
      end
      VEC_LOOP_C_1 : begin
        fsm_output = 22'b0000000000000010000000;
        state_var_NS = VEC_LOOP_C_2;
      end
      VEC_LOOP_C_2 : begin
        fsm_output = 22'b0000000000000100000000;
        state_var_NS = VEC_LOOP_C_3;
      end
      VEC_LOOP_C_3 : begin
        fsm_output = 22'b0000000000001000000000;
        state_var_NS = VEC_LOOP_C_4;
      end
      VEC_LOOP_C_4 : begin
        fsm_output = 22'b0000000000010000000000;
        state_var_NS = VEC_LOOP_C_5;
      end
      VEC_LOOP_C_5 : begin
        fsm_output = 22'b0000000000100000000000;
        state_var_NS = VEC_LOOP_C_6;
      end
      VEC_LOOP_C_6 : begin
        fsm_output = 22'b0000000001000000000000;
        state_var_NS = VEC_LOOP_C_7;
      end
      VEC_LOOP_C_7 : begin
        fsm_output = 22'b0000000010000000000000;
        state_var_NS = VEC_LOOP_C_8;
      end
      VEC_LOOP_C_8 : begin
        fsm_output = 22'b0000000100000000000000;
        state_var_NS = VEC_LOOP_C_9;
      end
      VEC_LOOP_C_9 : begin
        fsm_output = 22'b0000001000000000000000;
        state_var_NS = VEC_LOOP_C_10;
      end
      VEC_LOOP_C_10 : begin
        fsm_output = 22'b0000010000000000000000;
        state_var_NS = VEC_LOOP_C_11;
      end
      VEC_LOOP_C_11 : begin
        fsm_output = 22'b0000100000000000000000;
        if ( VEC_LOOP_C_11_tr0 ) begin
          state_var_NS = COMP_LOOP_C_4;
        end
        else begin
          state_var_NS = VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 22'b0001000000000000000000;
        if ( COMP_LOOP_C_4_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 22'b0010000000000000000000;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 22'b0100000000000000000000;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 22'b1000000000000000000000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 22'b0000000000000000000001;
        if ( main_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= main_C_0;
    end
    else if ( complete_rsci_wen_comp ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_staller
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_staller (
  clk, rst, core_wten, complete_rsci_wen_comp, core_wten_pff
);
  input clk;
  input rst;
  output core_wten;
  input complete_rsci_wen_comp;
  output core_wten_pff;


  // Interconnect Declarations
  reg core_wten_reg;


  // Interconnect Declarations for Component Instantiations 
  assign core_wten = core_wten_reg;
  assign core_wten_pff = ~ complete_rsci_wen_comp;
  always @(posedge clk) begin
    if ( rst ) begin
      core_wten_reg <= 1'b0;
    end
    else begin
      core_wten_reg <= ~ complete_rsci_wen_comp;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj_twiddle_h_rsc_triosy_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj_twiddle_h_rsc_triosy_0_0_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_0_obj_iswt0, twiddle_h_rsc_triosy_0_0_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_0_obj_iswt0;
  output twiddle_h_rsc_triosy_0_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_0_obj_ld_core_sct = twiddle_h_rsc_triosy_0_0_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj_twiddle_h_rsc_triosy_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj_twiddle_h_rsc_triosy_0_1_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_1_obj_iswt0, twiddle_h_rsc_triosy_0_1_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_1_obj_iswt0;
  output twiddle_h_rsc_triosy_0_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_1_obj_ld_core_sct = twiddle_h_rsc_triosy_0_1_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj_twiddle_h_rsc_triosy_0_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj_twiddle_h_rsc_triosy_0_2_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_2_obj_iswt0, twiddle_h_rsc_triosy_0_2_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_2_obj_iswt0;
  output twiddle_h_rsc_triosy_0_2_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_2_obj_ld_core_sct = twiddle_h_rsc_triosy_0_2_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj_twiddle_h_rsc_triosy_0_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj_twiddle_h_rsc_triosy_0_3_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_3_obj_iswt0, twiddle_h_rsc_triosy_0_3_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_3_obj_iswt0;
  output twiddle_h_rsc_triosy_0_3_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_3_obj_ld_core_sct = twiddle_h_rsc_triosy_0_3_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj_twiddle_h_rsc_triosy_0_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj_twiddle_h_rsc_triosy_0_4_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_4_obj_iswt0, twiddle_h_rsc_triosy_0_4_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_4_obj_iswt0;
  output twiddle_h_rsc_triosy_0_4_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_4_obj_ld_core_sct = twiddle_h_rsc_triosy_0_4_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj_twiddle_h_rsc_triosy_0_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj_twiddle_h_rsc_triosy_0_5_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_5_obj_iswt0, twiddle_h_rsc_triosy_0_5_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_5_obj_iswt0;
  output twiddle_h_rsc_triosy_0_5_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_5_obj_ld_core_sct = twiddle_h_rsc_triosy_0_5_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj_twiddle_h_rsc_triosy_0_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj_twiddle_h_rsc_triosy_0_6_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_6_obj_iswt0, twiddle_h_rsc_triosy_0_6_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_6_obj_iswt0;
  output twiddle_h_rsc_triosy_0_6_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_6_obj_ld_core_sct = twiddle_h_rsc_triosy_0_6_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj_twiddle_h_rsc_triosy_0_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj_twiddle_h_rsc_triosy_0_7_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_0_7_obj_iswt0, twiddle_h_rsc_triosy_0_7_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_0_7_obj_iswt0;
  output twiddle_h_rsc_triosy_0_7_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_0_7_obj_ld_core_sct = twiddle_h_rsc_triosy_0_7_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj_twiddle_h_rsc_triosy_1_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj_twiddle_h_rsc_triosy_1_0_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_0_obj_iswt0, twiddle_h_rsc_triosy_1_0_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_0_obj_iswt0;
  output twiddle_h_rsc_triosy_1_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_0_obj_ld_core_sct = twiddle_h_rsc_triosy_1_0_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj_twiddle_h_rsc_triosy_1_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj_twiddle_h_rsc_triosy_1_1_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_1_obj_iswt0, twiddle_h_rsc_triosy_1_1_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_1_obj_iswt0;
  output twiddle_h_rsc_triosy_1_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_1_obj_ld_core_sct = twiddle_h_rsc_triosy_1_1_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj_twiddle_h_rsc_triosy_1_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj_twiddle_h_rsc_triosy_1_2_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_2_obj_iswt0, twiddle_h_rsc_triosy_1_2_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_2_obj_iswt0;
  output twiddle_h_rsc_triosy_1_2_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_2_obj_ld_core_sct = twiddle_h_rsc_triosy_1_2_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj_twiddle_h_rsc_triosy_1_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj_twiddle_h_rsc_triosy_1_3_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_3_obj_iswt0, twiddle_h_rsc_triosy_1_3_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_3_obj_iswt0;
  output twiddle_h_rsc_triosy_1_3_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_3_obj_ld_core_sct = twiddle_h_rsc_triosy_1_3_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj_twiddle_h_rsc_triosy_1_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj_twiddle_h_rsc_triosy_1_4_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_4_obj_iswt0, twiddle_h_rsc_triosy_1_4_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_4_obj_iswt0;
  output twiddle_h_rsc_triosy_1_4_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_4_obj_ld_core_sct = twiddle_h_rsc_triosy_1_4_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj_twiddle_h_rsc_triosy_1_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj_twiddle_h_rsc_triosy_1_5_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_5_obj_iswt0, twiddle_h_rsc_triosy_1_5_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_5_obj_iswt0;
  output twiddle_h_rsc_triosy_1_5_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_5_obj_ld_core_sct = twiddle_h_rsc_triosy_1_5_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj_twiddle_h_rsc_triosy_1_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj_twiddle_h_rsc_triosy_1_6_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_6_obj_iswt0, twiddle_h_rsc_triosy_1_6_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_6_obj_iswt0;
  output twiddle_h_rsc_triosy_1_6_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_6_obj_ld_core_sct = twiddle_h_rsc_triosy_1_6_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj_twiddle_h_rsc_triosy_1_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj_twiddle_h_rsc_triosy_1_7_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_1_7_obj_iswt0, twiddle_h_rsc_triosy_1_7_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_1_7_obj_iswt0;
  output twiddle_h_rsc_triosy_1_7_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_1_7_obj_ld_core_sct = twiddle_h_rsc_triosy_1_7_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_0_obj_iswt0, twiddle_rsc_triosy_0_0_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_0_obj_iswt0;
  output twiddle_rsc_triosy_0_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_0_obj_ld_core_sct = twiddle_rsc_triosy_0_0_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_1_obj_iswt0, twiddle_rsc_triosy_0_1_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_1_obj_iswt0;
  output twiddle_rsc_triosy_0_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_1_obj_ld_core_sct = twiddle_rsc_triosy_0_1_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj_twiddle_rsc_triosy_0_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj_twiddle_rsc_triosy_0_2_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_2_obj_iswt0, twiddle_rsc_triosy_0_2_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_2_obj_iswt0;
  output twiddle_rsc_triosy_0_2_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_2_obj_ld_core_sct = twiddle_rsc_triosy_0_2_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj_twiddle_rsc_triosy_0_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj_twiddle_rsc_triosy_0_3_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_3_obj_iswt0, twiddle_rsc_triosy_0_3_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_3_obj_iswt0;
  output twiddle_rsc_triosy_0_3_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_3_obj_ld_core_sct = twiddle_rsc_triosy_0_3_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj_twiddle_rsc_triosy_0_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj_twiddle_rsc_triosy_0_4_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_4_obj_iswt0, twiddle_rsc_triosy_0_4_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_4_obj_iswt0;
  output twiddle_rsc_triosy_0_4_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_4_obj_ld_core_sct = twiddle_rsc_triosy_0_4_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj_twiddle_rsc_triosy_0_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj_twiddle_rsc_triosy_0_5_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_5_obj_iswt0, twiddle_rsc_triosy_0_5_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_5_obj_iswt0;
  output twiddle_rsc_triosy_0_5_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_5_obj_ld_core_sct = twiddle_rsc_triosy_0_5_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj_twiddle_rsc_triosy_0_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj_twiddle_rsc_triosy_0_6_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_6_obj_iswt0, twiddle_rsc_triosy_0_6_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_6_obj_iswt0;
  output twiddle_rsc_triosy_0_6_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_6_obj_ld_core_sct = twiddle_rsc_triosy_0_6_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj_twiddle_rsc_triosy_0_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj_twiddle_rsc_triosy_0_7_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_0_7_obj_iswt0, twiddle_rsc_triosy_0_7_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_0_7_obj_iswt0;
  output twiddle_rsc_triosy_0_7_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_0_7_obj_ld_core_sct = twiddle_rsc_triosy_0_7_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj_twiddle_rsc_triosy_1_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj_twiddle_rsc_triosy_1_0_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_0_obj_iswt0, twiddle_rsc_triosy_1_0_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_0_obj_iswt0;
  output twiddle_rsc_triosy_1_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_0_obj_ld_core_sct = twiddle_rsc_triosy_1_0_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj_twiddle_rsc_triosy_1_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj_twiddle_rsc_triosy_1_1_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_1_obj_iswt0, twiddle_rsc_triosy_1_1_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_1_obj_iswt0;
  output twiddle_rsc_triosy_1_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_1_obj_ld_core_sct = twiddle_rsc_triosy_1_1_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj_twiddle_rsc_triosy_1_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj_twiddle_rsc_triosy_1_2_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_2_obj_iswt0, twiddle_rsc_triosy_1_2_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_2_obj_iswt0;
  output twiddle_rsc_triosy_1_2_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_2_obj_ld_core_sct = twiddle_rsc_triosy_1_2_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj_twiddle_rsc_triosy_1_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj_twiddle_rsc_triosy_1_3_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_3_obj_iswt0, twiddle_rsc_triosy_1_3_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_3_obj_iswt0;
  output twiddle_rsc_triosy_1_3_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_3_obj_ld_core_sct = twiddle_rsc_triosy_1_3_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj_twiddle_rsc_triosy_1_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj_twiddle_rsc_triosy_1_4_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_4_obj_iswt0, twiddle_rsc_triosy_1_4_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_4_obj_iswt0;
  output twiddle_rsc_triosy_1_4_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_4_obj_ld_core_sct = twiddle_rsc_triosy_1_4_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj_twiddle_rsc_triosy_1_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj_twiddle_rsc_triosy_1_5_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_5_obj_iswt0, twiddle_rsc_triosy_1_5_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_5_obj_iswt0;
  output twiddle_rsc_triosy_1_5_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_5_obj_ld_core_sct = twiddle_rsc_triosy_1_5_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj_twiddle_rsc_triosy_1_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj_twiddle_rsc_triosy_1_6_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_6_obj_iswt0, twiddle_rsc_triosy_1_6_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_6_obj_iswt0;
  output twiddle_rsc_triosy_1_6_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_6_obj_ld_core_sct = twiddle_rsc_triosy_1_6_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj_twiddle_rsc_triosy_1_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj_twiddle_rsc_triosy_1_7_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_1_7_obj_iswt0, twiddle_rsc_triosy_1_7_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_1_7_obj_iswt0;
  output twiddle_rsc_triosy_1_7_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_1_7_obj_ld_core_sct = twiddle_rsc_triosy_1_7_obj_iswt0
      & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl (
  core_wten, r_rsc_triosy_obj_iswt0, r_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input r_rsc_triosy_obj_iswt0;
  output r_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign r_rsc_triosy_obj_ld_core_sct = r_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl (
  core_wten, p_rsc_triosy_obj_iswt0, p_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input p_rsc_triosy_obj_iswt0;
  output p_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign p_rsc_triosy_obj_ld_core_sct = p_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_0_obj_iswt0, vec_rsc_triosy_0_0_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_0_obj_iswt0;
  output vec_rsc_triosy_0_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_0_obj_ld_core_sct = vec_rsc_triosy_0_0_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_1_obj_iswt0, vec_rsc_triosy_0_1_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_1_obj_iswt0;
  output vec_rsc_triosy_0_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_1_obj_ld_core_sct = vec_rsc_triosy_0_1_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj_vec_rsc_triosy_0_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj_vec_rsc_triosy_0_2_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_2_obj_iswt0, vec_rsc_triosy_0_2_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_2_obj_iswt0;
  output vec_rsc_triosy_0_2_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_2_obj_ld_core_sct = vec_rsc_triosy_0_2_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj_vec_rsc_triosy_0_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj_vec_rsc_triosy_0_3_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_3_obj_iswt0, vec_rsc_triosy_0_3_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_3_obj_iswt0;
  output vec_rsc_triosy_0_3_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_3_obj_ld_core_sct = vec_rsc_triosy_0_3_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj_vec_rsc_triosy_0_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj_vec_rsc_triosy_0_4_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_4_obj_iswt0, vec_rsc_triosy_0_4_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_4_obj_iswt0;
  output vec_rsc_triosy_0_4_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_4_obj_ld_core_sct = vec_rsc_triosy_0_4_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj_vec_rsc_triosy_0_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj_vec_rsc_triosy_0_5_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_5_obj_iswt0, vec_rsc_triosy_0_5_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_5_obj_iswt0;
  output vec_rsc_triosy_0_5_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_5_obj_ld_core_sct = vec_rsc_triosy_0_5_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj_vec_rsc_triosy_0_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj_vec_rsc_triosy_0_6_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_6_obj_iswt0, vec_rsc_triosy_0_6_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_6_obj_iswt0;
  output vec_rsc_triosy_0_6_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_6_obj_ld_core_sct = vec_rsc_triosy_0_6_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj_vec_rsc_triosy_0_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj_vec_rsc_triosy_0_7_wait_ctrl
    (
  core_wten, vec_rsc_triosy_0_7_obj_iswt0, vec_rsc_triosy_0_7_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_0_7_obj_iswt0;
  output vec_rsc_triosy_0_7_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_0_7_obj_ld_core_sct = vec_rsc_triosy_0_7_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj_vec_rsc_triosy_1_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj_vec_rsc_triosy_1_0_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_0_obj_iswt0, vec_rsc_triosy_1_0_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_0_obj_iswt0;
  output vec_rsc_triosy_1_0_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_0_obj_ld_core_sct = vec_rsc_triosy_1_0_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj_vec_rsc_triosy_1_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj_vec_rsc_triosy_1_1_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_1_obj_iswt0, vec_rsc_triosy_1_1_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_1_obj_iswt0;
  output vec_rsc_triosy_1_1_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_1_obj_ld_core_sct = vec_rsc_triosy_1_1_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj_vec_rsc_triosy_1_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj_vec_rsc_triosy_1_2_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_2_obj_iswt0, vec_rsc_triosy_1_2_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_2_obj_iswt0;
  output vec_rsc_triosy_1_2_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_2_obj_ld_core_sct = vec_rsc_triosy_1_2_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj_vec_rsc_triosy_1_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj_vec_rsc_triosy_1_3_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_3_obj_iswt0, vec_rsc_triosy_1_3_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_3_obj_iswt0;
  output vec_rsc_triosy_1_3_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_3_obj_ld_core_sct = vec_rsc_triosy_1_3_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj_vec_rsc_triosy_1_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj_vec_rsc_triosy_1_4_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_4_obj_iswt0, vec_rsc_triosy_1_4_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_4_obj_iswt0;
  output vec_rsc_triosy_1_4_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_4_obj_ld_core_sct = vec_rsc_triosy_1_4_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj_vec_rsc_triosy_1_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj_vec_rsc_triosy_1_5_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_5_obj_iswt0, vec_rsc_triosy_1_5_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_5_obj_iswt0;
  output vec_rsc_triosy_1_5_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_5_obj_ld_core_sct = vec_rsc_triosy_1_5_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj_vec_rsc_triosy_1_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj_vec_rsc_triosy_1_6_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_6_obj_iswt0, vec_rsc_triosy_1_6_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_6_obj_iswt0;
  output vec_rsc_triosy_1_6_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_6_obj_ld_core_sct = vec_rsc_triosy_1_6_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj_vec_rsc_triosy_1_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj_vec_rsc_triosy_1_7_wait_ctrl
    (
  core_wten, vec_rsc_triosy_1_7_obj_iswt0, vec_rsc_triosy_1_7_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_1_7_obj_iswt0;
  output vec_rsc_triosy_1_7_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_1_7_obj_ld_core_sct = vec_rsc_triosy_1_7_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_7_i_qb_d, twiddle_h_rsc_1_7_i_qb_d_mxwt, twiddle_h_rsc_1_7_i_biwt,
      twiddle_h_rsc_1_7_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_7_i_qb_d;
  output [31:0] twiddle_h_rsc_1_7_i_qb_d_mxwt;
  input twiddle_h_rsc_1_7_i_biwt;
  input twiddle_h_rsc_1_7_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_7_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_7_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_7_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_7_i_qb_d, twiddle_h_rsc_1_7_i_qb_d_bfwt,
      twiddle_h_rsc_1_7_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_7_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_7_i_bcwt <= ~((~(twiddle_h_rsc_1_7_i_bcwt | twiddle_h_rsc_1_7_i_biwt))
          | twiddle_h_rsc_1_7_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_7_i_biwt ) begin
      twiddle_h_rsc_1_7_i_qb_d_bfwt <= twiddle_h_rsc_1_7_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_7_i_oswt, twiddle_h_rsc_1_7_i_biwt, twiddle_h_rsc_1_7_i_bdwt,
      twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_7_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_7_i_oswt;
  output twiddle_h_rsc_1_7_i_biwt;
  output twiddle_h_rsc_1_7_i_bdwt;
  output twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_7_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_7_i_bdwt = twiddle_h_rsc_1_7_i_oswt & core_wen;
  assign twiddle_h_rsc_1_7_i_biwt = (~ core_wten) & twiddle_h_rsc_1_7_i_oswt;
  assign twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_7_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_6_i_qb_d, twiddle_h_rsc_1_6_i_qb_d_mxwt, twiddle_h_rsc_1_6_i_biwt,
      twiddle_h_rsc_1_6_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_6_i_qb_d;
  output [31:0] twiddle_h_rsc_1_6_i_qb_d_mxwt;
  input twiddle_h_rsc_1_6_i_biwt;
  input twiddle_h_rsc_1_6_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_6_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_6_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_6_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_6_i_qb_d, twiddle_h_rsc_1_6_i_qb_d_bfwt,
      twiddle_h_rsc_1_6_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_6_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_6_i_bcwt <= ~((~(twiddle_h_rsc_1_6_i_bcwt | twiddle_h_rsc_1_6_i_biwt))
          | twiddle_h_rsc_1_6_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_6_i_biwt ) begin
      twiddle_h_rsc_1_6_i_qb_d_bfwt <= twiddle_h_rsc_1_6_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_6_i_oswt, twiddle_h_rsc_1_6_i_biwt, twiddle_h_rsc_1_6_i_bdwt,
      twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_6_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_6_i_oswt;
  output twiddle_h_rsc_1_6_i_biwt;
  output twiddle_h_rsc_1_6_i_bdwt;
  output twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_6_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_6_i_bdwt = twiddle_h_rsc_1_6_i_oswt & core_wen;
  assign twiddle_h_rsc_1_6_i_biwt = (~ core_wten) & twiddle_h_rsc_1_6_i_oswt;
  assign twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_6_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_5_i_qb_d, twiddle_h_rsc_1_5_i_qb_d_mxwt, twiddle_h_rsc_1_5_i_biwt,
      twiddle_h_rsc_1_5_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_5_i_qb_d;
  output [31:0] twiddle_h_rsc_1_5_i_qb_d_mxwt;
  input twiddle_h_rsc_1_5_i_biwt;
  input twiddle_h_rsc_1_5_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_5_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_5_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_5_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_5_i_qb_d, twiddle_h_rsc_1_5_i_qb_d_bfwt,
      twiddle_h_rsc_1_5_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_5_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_5_i_bcwt <= ~((~(twiddle_h_rsc_1_5_i_bcwt | twiddle_h_rsc_1_5_i_biwt))
          | twiddle_h_rsc_1_5_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_5_i_biwt ) begin
      twiddle_h_rsc_1_5_i_qb_d_bfwt <= twiddle_h_rsc_1_5_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_5_i_oswt, twiddle_h_rsc_1_5_i_biwt, twiddle_h_rsc_1_5_i_bdwt,
      twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_5_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_5_i_oswt;
  output twiddle_h_rsc_1_5_i_biwt;
  output twiddle_h_rsc_1_5_i_bdwt;
  output twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_5_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_5_i_bdwt = twiddle_h_rsc_1_5_i_oswt & core_wen;
  assign twiddle_h_rsc_1_5_i_biwt = (~ core_wten) & twiddle_h_rsc_1_5_i_oswt;
  assign twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_5_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_4_i_qb_d, twiddle_h_rsc_1_4_i_qb_d_mxwt, twiddle_h_rsc_1_4_i_biwt,
      twiddle_h_rsc_1_4_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_4_i_qb_d;
  output [31:0] twiddle_h_rsc_1_4_i_qb_d_mxwt;
  input twiddle_h_rsc_1_4_i_biwt;
  input twiddle_h_rsc_1_4_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_4_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_4_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_4_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_4_i_qb_d, twiddle_h_rsc_1_4_i_qb_d_bfwt,
      twiddle_h_rsc_1_4_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_4_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_4_i_bcwt <= ~((~(twiddle_h_rsc_1_4_i_bcwt | twiddle_h_rsc_1_4_i_biwt))
          | twiddle_h_rsc_1_4_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_4_i_biwt ) begin
      twiddle_h_rsc_1_4_i_qb_d_bfwt <= twiddle_h_rsc_1_4_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_4_i_oswt, twiddle_h_rsc_1_4_i_biwt, twiddle_h_rsc_1_4_i_bdwt,
      twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_4_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_4_i_oswt;
  output twiddle_h_rsc_1_4_i_biwt;
  output twiddle_h_rsc_1_4_i_bdwt;
  output twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_4_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_4_i_bdwt = twiddle_h_rsc_1_4_i_oswt & core_wen;
  assign twiddle_h_rsc_1_4_i_biwt = (~ core_wten) & twiddle_h_rsc_1_4_i_oswt;
  assign twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_4_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_3_i_qb_d, twiddle_h_rsc_1_3_i_qb_d_mxwt, twiddle_h_rsc_1_3_i_biwt,
      twiddle_h_rsc_1_3_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_3_i_qb_d;
  output [31:0] twiddle_h_rsc_1_3_i_qb_d_mxwt;
  input twiddle_h_rsc_1_3_i_biwt;
  input twiddle_h_rsc_1_3_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_3_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_3_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_3_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_3_i_qb_d, twiddle_h_rsc_1_3_i_qb_d_bfwt,
      twiddle_h_rsc_1_3_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_3_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_3_i_bcwt <= ~((~(twiddle_h_rsc_1_3_i_bcwt | twiddle_h_rsc_1_3_i_biwt))
          | twiddle_h_rsc_1_3_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_3_i_biwt ) begin
      twiddle_h_rsc_1_3_i_qb_d_bfwt <= twiddle_h_rsc_1_3_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_3_i_oswt, twiddle_h_rsc_1_3_i_biwt, twiddle_h_rsc_1_3_i_bdwt,
      twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_3_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_3_i_oswt;
  output twiddle_h_rsc_1_3_i_biwt;
  output twiddle_h_rsc_1_3_i_bdwt;
  output twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_3_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_3_i_bdwt = twiddle_h_rsc_1_3_i_oswt & core_wen;
  assign twiddle_h_rsc_1_3_i_biwt = (~ core_wten) & twiddle_h_rsc_1_3_i_oswt;
  assign twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_3_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_2_i_qb_d, twiddle_h_rsc_1_2_i_qb_d_mxwt, twiddle_h_rsc_1_2_i_biwt,
      twiddle_h_rsc_1_2_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_2_i_qb_d;
  output [31:0] twiddle_h_rsc_1_2_i_qb_d_mxwt;
  input twiddle_h_rsc_1_2_i_biwt;
  input twiddle_h_rsc_1_2_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_2_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_2_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_2_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_2_i_qb_d, twiddle_h_rsc_1_2_i_qb_d_bfwt,
      twiddle_h_rsc_1_2_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_2_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_2_i_bcwt <= ~((~(twiddle_h_rsc_1_2_i_bcwt | twiddle_h_rsc_1_2_i_biwt))
          | twiddle_h_rsc_1_2_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_2_i_biwt ) begin
      twiddle_h_rsc_1_2_i_qb_d_bfwt <= twiddle_h_rsc_1_2_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_2_i_oswt, twiddle_h_rsc_1_2_i_biwt, twiddle_h_rsc_1_2_i_bdwt,
      twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_2_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_2_i_oswt;
  output twiddle_h_rsc_1_2_i_biwt;
  output twiddle_h_rsc_1_2_i_bdwt;
  output twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_2_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_2_i_bdwt = twiddle_h_rsc_1_2_i_oswt & core_wen;
  assign twiddle_h_rsc_1_2_i_biwt = (~ core_wten) & twiddle_h_rsc_1_2_i_oswt;
  assign twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_2_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_1_i_qb_d, twiddle_h_rsc_1_1_i_qb_d_mxwt, twiddle_h_rsc_1_1_i_biwt,
      twiddle_h_rsc_1_1_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_1_i_qb_d;
  output [31:0] twiddle_h_rsc_1_1_i_qb_d_mxwt;
  input twiddle_h_rsc_1_1_i_biwt;
  input twiddle_h_rsc_1_1_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_1_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_1_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_1_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_1_i_qb_d, twiddle_h_rsc_1_1_i_qb_d_bfwt,
      twiddle_h_rsc_1_1_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_1_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_1_i_bcwt <= ~((~(twiddle_h_rsc_1_1_i_bcwt | twiddle_h_rsc_1_1_i_biwt))
          | twiddle_h_rsc_1_1_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_1_i_biwt ) begin
      twiddle_h_rsc_1_1_i_qb_d_bfwt <= twiddle_h_rsc_1_1_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_1_i_oswt, twiddle_h_rsc_1_1_i_biwt, twiddle_h_rsc_1_1_i_bdwt,
      twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_1_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_1_i_oswt;
  output twiddle_h_rsc_1_1_i_biwt;
  output twiddle_h_rsc_1_1_i_bdwt;
  output twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_1_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_1_i_bdwt = twiddle_h_rsc_1_1_i_oswt & core_wen;
  assign twiddle_h_rsc_1_1_i_biwt = (~ core_wten) & twiddle_h_rsc_1_1_i_oswt;
  assign twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_1_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_dp
    (
  clk, rst, twiddle_h_rsc_1_0_i_qb_d, twiddle_h_rsc_1_0_i_qb_d_mxwt, twiddle_h_rsc_1_0_i_biwt,
      twiddle_h_rsc_1_0_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_0_i_qb_d;
  output [31:0] twiddle_h_rsc_1_0_i_qb_d_mxwt;
  input twiddle_h_rsc_1_0_i_biwt;
  input twiddle_h_rsc_1_0_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_1_0_i_bcwt;
  reg [31:0] twiddle_h_rsc_1_0_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_0_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_1_0_i_qb_d, twiddle_h_rsc_1_0_i_qb_d_bfwt,
      twiddle_h_rsc_1_0_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_1_0_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_1_0_i_bcwt <= ~((~(twiddle_h_rsc_1_0_i_bcwt | twiddle_h_rsc_1_0_i_biwt))
          | twiddle_h_rsc_1_0_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_1_0_i_biwt ) begin
      twiddle_h_rsc_1_0_i_qb_d_bfwt <= twiddle_h_rsc_1_0_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_1_0_i_oswt, twiddle_h_rsc_1_0_i_biwt, twiddle_h_rsc_1_0_i_bdwt,
      twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_1_0_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_0_i_oswt;
  output twiddle_h_rsc_1_0_i_biwt;
  output twiddle_h_rsc_1_0_i_bdwt;
  output twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_1_0_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_1_0_i_bdwt = twiddle_h_rsc_1_0_i_oswt & core_wen;
  assign twiddle_h_rsc_1_0_i_biwt = (~ core_wten) & twiddle_h_rsc_1_0_i_oswt;
  assign twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_1_0_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_7_i_qb_d, twiddle_h_rsc_0_7_i_qb_d_mxwt, twiddle_h_rsc_0_7_i_biwt,
      twiddle_h_rsc_0_7_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_7_i_qb_d;
  output [31:0] twiddle_h_rsc_0_7_i_qb_d_mxwt;
  input twiddle_h_rsc_0_7_i_biwt;
  input twiddle_h_rsc_0_7_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_7_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_7_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_7_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_7_i_qb_d, twiddle_h_rsc_0_7_i_qb_d_bfwt,
      twiddle_h_rsc_0_7_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_7_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_7_i_bcwt <= ~((~(twiddle_h_rsc_0_7_i_bcwt | twiddle_h_rsc_0_7_i_biwt))
          | twiddle_h_rsc_0_7_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_7_i_biwt ) begin
      twiddle_h_rsc_0_7_i_qb_d_bfwt <= twiddle_h_rsc_0_7_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_7_i_oswt, twiddle_h_rsc_0_7_i_biwt, twiddle_h_rsc_0_7_i_bdwt,
      twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_7_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_7_i_oswt;
  output twiddle_h_rsc_0_7_i_biwt;
  output twiddle_h_rsc_0_7_i_bdwt;
  output twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_7_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_7_i_bdwt = twiddle_h_rsc_0_7_i_oswt & core_wen;
  assign twiddle_h_rsc_0_7_i_biwt = (~ core_wten) & twiddle_h_rsc_0_7_i_oswt;
  assign twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_7_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_6_i_qb_d, twiddle_h_rsc_0_6_i_qb_d_mxwt, twiddle_h_rsc_0_6_i_biwt,
      twiddle_h_rsc_0_6_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_6_i_qb_d;
  output [31:0] twiddle_h_rsc_0_6_i_qb_d_mxwt;
  input twiddle_h_rsc_0_6_i_biwt;
  input twiddle_h_rsc_0_6_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_6_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_6_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_6_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_6_i_qb_d, twiddle_h_rsc_0_6_i_qb_d_bfwt,
      twiddle_h_rsc_0_6_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_6_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_6_i_bcwt <= ~((~(twiddle_h_rsc_0_6_i_bcwt | twiddle_h_rsc_0_6_i_biwt))
          | twiddle_h_rsc_0_6_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_6_i_biwt ) begin
      twiddle_h_rsc_0_6_i_qb_d_bfwt <= twiddle_h_rsc_0_6_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_6_i_oswt, twiddle_h_rsc_0_6_i_biwt, twiddle_h_rsc_0_6_i_bdwt,
      twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_6_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_6_i_oswt;
  output twiddle_h_rsc_0_6_i_biwt;
  output twiddle_h_rsc_0_6_i_bdwt;
  output twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_6_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_6_i_bdwt = twiddle_h_rsc_0_6_i_oswt & core_wen;
  assign twiddle_h_rsc_0_6_i_biwt = (~ core_wten) & twiddle_h_rsc_0_6_i_oswt;
  assign twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_6_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_5_i_qb_d, twiddle_h_rsc_0_5_i_qb_d_mxwt, twiddle_h_rsc_0_5_i_biwt,
      twiddle_h_rsc_0_5_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_5_i_qb_d;
  output [31:0] twiddle_h_rsc_0_5_i_qb_d_mxwt;
  input twiddle_h_rsc_0_5_i_biwt;
  input twiddle_h_rsc_0_5_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_5_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_5_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_5_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_5_i_qb_d, twiddle_h_rsc_0_5_i_qb_d_bfwt,
      twiddle_h_rsc_0_5_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_5_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_5_i_bcwt <= ~((~(twiddle_h_rsc_0_5_i_bcwt | twiddle_h_rsc_0_5_i_biwt))
          | twiddle_h_rsc_0_5_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_5_i_biwt ) begin
      twiddle_h_rsc_0_5_i_qb_d_bfwt <= twiddle_h_rsc_0_5_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_5_i_oswt, twiddle_h_rsc_0_5_i_biwt, twiddle_h_rsc_0_5_i_bdwt,
      twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_5_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_5_i_oswt;
  output twiddle_h_rsc_0_5_i_biwt;
  output twiddle_h_rsc_0_5_i_bdwt;
  output twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_5_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_5_i_bdwt = twiddle_h_rsc_0_5_i_oswt & core_wen;
  assign twiddle_h_rsc_0_5_i_biwt = (~ core_wten) & twiddle_h_rsc_0_5_i_oswt;
  assign twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_5_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_4_i_qb_d, twiddle_h_rsc_0_4_i_qb_d_mxwt, twiddle_h_rsc_0_4_i_biwt,
      twiddle_h_rsc_0_4_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_4_i_qb_d;
  output [31:0] twiddle_h_rsc_0_4_i_qb_d_mxwt;
  input twiddle_h_rsc_0_4_i_biwt;
  input twiddle_h_rsc_0_4_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_4_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_4_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_4_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_4_i_qb_d, twiddle_h_rsc_0_4_i_qb_d_bfwt,
      twiddle_h_rsc_0_4_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_4_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_4_i_bcwt <= ~((~(twiddle_h_rsc_0_4_i_bcwt | twiddle_h_rsc_0_4_i_biwt))
          | twiddle_h_rsc_0_4_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_4_i_biwt ) begin
      twiddle_h_rsc_0_4_i_qb_d_bfwt <= twiddle_h_rsc_0_4_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_4_i_oswt, twiddle_h_rsc_0_4_i_biwt, twiddle_h_rsc_0_4_i_bdwt,
      twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_4_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_4_i_oswt;
  output twiddle_h_rsc_0_4_i_biwt;
  output twiddle_h_rsc_0_4_i_bdwt;
  output twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_4_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_4_i_bdwt = twiddle_h_rsc_0_4_i_oswt & core_wen;
  assign twiddle_h_rsc_0_4_i_biwt = (~ core_wten) & twiddle_h_rsc_0_4_i_oswt;
  assign twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_4_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_3_i_qb_d, twiddle_h_rsc_0_3_i_qb_d_mxwt, twiddle_h_rsc_0_3_i_biwt,
      twiddle_h_rsc_0_3_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_3_i_qb_d;
  output [31:0] twiddle_h_rsc_0_3_i_qb_d_mxwt;
  input twiddle_h_rsc_0_3_i_biwt;
  input twiddle_h_rsc_0_3_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_3_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_3_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_3_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_3_i_qb_d, twiddle_h_rsc_0_3_i_qb_d_bfwt,
      twiddle_h_rsc_0_3_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_3_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_3_i_bcwt <= ~((~(twiddle_h_rsc_0_3_i_bcwt | twiddle_h_rsc_0_3_i_biwt))
          | twiddle_h_rsc_0_3_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_3_i_biwt ) begin
      twiddle_h_rsc_0_3_i_qb_d_bfwt <= twiddle_h_rsc_0_3_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_3_i_oswt, twiddle_h_rsc_0_3_i_biwt, twiddle_h_rsc_0_3_i_bdwt,
      twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_3_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_3_i_oswt;
  output twiddle_h_rsc_0_3_i_biwt;
  output twiddle_h_rsc_0_3_i_bdwt;
  output twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_3_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_3_i_bdwt = twiddle_h_rsc_0_3_i_oswt & core_wen;
  assign twiddle_h_rsc_0_3_i_biwt = (~ core_wten) & twiddle_h_rsc_0_3_i_oswt;
  assign twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_3_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_2_i_qb_d, twiddle_h_rsc_0_2_i_qb_d_mxwt, twiddle_h_rsc_0_2_i_biwt,
      twiddle_h_rsc_0_2_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_2_i_qb_d;
  output [31:0] twiddle_h_rsc_0_2_i_qb_d_mxwt;
  input twiddle_h_rsc_0_2_i_biwt;
  input twiddle_h_rsc_0_2_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_2_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_2_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_2_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_2_i_qb_d, twiddle_h_rsc_0_2_i_qb_d_bfwt,
      twiddle_h_rsc_0_2_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_2_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_2_i_bcwt <= ~((~(twiddle_h_rsc_0_2_i_bcwt | twiddle_h_rsc_0_2_i_biwt))
          | twiddle_h_rsc_0_2_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_2_i_biwt ) begin
      twiddle_h_rsc_0_2_i_qb_d_bfwt <= twiddle_h_rsc_0_2_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_2_i_oswt, twiddle_h_rsc_0_2_i_biwt, twiddle_h_rsc_0_2_i_bdwt,
      twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_2_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_2_i_oswt;
  output twiddle_h_rsc_0_2_i_biwt;
  output twiddle_h_rsc_0_2_i_bdwt;
  output twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_2_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_2_i_bdwt = twiddle_h_rsc_0_2_i_oswt & core_wen;
  assign twiddle_h_rsc_0_2_i_biwt = (~ core_wten) & twiddle_h_rsc_0_2_i_oswt;
  assign twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_2_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_1_i_qb_d, twiddle_h_rsc_0_1_i_qb_d_mxwt, twiddle_h_rsc_0_1_i_biwt,
      twiddle_h_rsc_0_1_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_1_i_qb_d;
  output [31:0] twiddle_h_rsc_0_1_i_qb_d_mxwt;
  input twiddle_h_rsc_0_1_i_biwt;
  input twiddle_h_rsc_0_1_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_1_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_1_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_1_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_1_i_qb_d, twiddle_h_rsc_0_1_i_qb_d_bfwt,
      twiddle_h_rsc_0_1_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_1_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_1_i_bcwt <= ~((~(twiddle_h_rsc_0_1_i_bcwt | twiddle_h_rsc_0_1_i_biwt))
          | twiddle_h_rsc_0_1_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_1_i_biwt ) begin
      twiddle_h_rsc_0_1_i_qb_d_bfwt <= twiddle_h_rsc_0_1_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_1_i_oswt, twiddle_h_rsc_0_1_i_biwt, twiddle_h_rsc_0_1_i_bdwt,
      twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_1_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_1_i_oswt;
  output twiddle_h_rsc_0_1_i_biwt;
  output twiddle_h_rsc_0_1_i_bdwt;
  output twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_1_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_1_i_bdwt = twiddle_h_rsc_0_1_i_oswt & core_wen;
  assign twiddle_h_rsc_0_1_i_biwt = (~ core_wten) & twiddle_h_rsc_0_1_i_oswt;
  assign twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_1_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_dp
    (
  clk, rst, twiddle_h_rsc_0_0_i_qb_d, twiddle_h_rsc_0_0_i_qb_d_mxwt, twiddle_h_rsc_0_0_i_biwt,
      twiddle_h_rsc_0_0_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_0_i_qb_d;
  output [31:0] twiddle_h_rsc_0_0_i_qb_d_mxwt;
  input twiddle_h_rsc_0_0_i_biwt;
  input twiddle_h_rsc_0_0_i_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsc_0_0_i_bcwt;
  reg [31:0] twiddle_h_rsc_0_0_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_0_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsc_0_0_i_qb_d, twiddle_h_rsc_0_0_i_qb_d_bfwt,
      twiddle_h_rsc_0_0_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsc_0_0_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsc_0_0_i_bcwt <= ~((~(twiddle_h_rsc_0_0_i_bcwt | twiddle_h_rsc_0_0_i_biwt))
          | twiddle_h_rsc_0_0_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsc_0_0_i_biwt ) begin
      twiddle_h_rsc_0_0_i_qb_d_bfwt <= twiddle_h_rsc_0_0_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_ctrl
    (
  core_wen, core_wten, twiddle_h_rsc_0_0_i_oswt, twiddle_h_rsc_0_0_i_biwt, twiddle_h_rsc_0_0_i_bdwt,
      twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsc_0_0_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_0_i_oswt;
  output twiddle_h_rsc_0_0_i_biwt;
  output twiddle_h_rsc_0_0_i_bdwt;
  output twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsc_0_0_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_0_0_i_bdwt = twiddle_h_rsc_0_0_i_oswt & core_wen;
  assign twiddle_h_rsc_0_0_i_biwt = (~ core_wten) & twiddle_h_rsc_0_0_i_oswt;
  assign twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsc_0_0_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_dp (
  clk, rst, twiddle_rsc_1_7_i_qb_d, twiddle_rsc_1_7_i_qb_d_mxwt, twiddle_rsc_1_7_i_biwt,
      twiddle_rsc_1_7_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_7_i_qb_d;
  output [31:0] twiddle_rsc_1_7_i_qb_d_mxwt;
  input twiddle_rsc_1_7_i_biwt;
  input twiddle_rsc_1_7_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_7_i_bcwt;
  reg [31:0] twiddle_rsc_1_7_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_7_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_7_i_qb_d, twiddle_rsc_1_7_i_qb_d_bfwt,
      twiddle_rsc_1_7_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_7_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_7_i_bcwt <= ~((~(twiddle_rsc_1_7_i_bcwt | twiddle_rsc_1_7_i_biwt))
          | twiddle_rsc_1_7_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_7_i_biwt ) begin
      twiddle_rsc_1_7_i_qb_d_bfwt <= twiddle_rsc_1_7_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_7_i_oswt, twiddle_rsc_1_7_i_biwt, twiddle_rsc_1_7_i_bdwt,
      twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_7_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_7_i_oswt;
  output twiddle_rsc_1_7_i_biwt;
  output twiddle_rsc_1_7_i_bdwt;
  output twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_7_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_7_i_bdwt = twiddle_rsc_1_7_i_oswt & core_wen;
  assign twiddle_rsc_1_7_i_biwt = (~ core_wten) & twiddle_rsc_1_7_i_oswt;
  assign twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_7_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_dp (
  clk, rst, twiddle_rsc_1_6_i_qb_d, twiddle_rsc_1_6_i_qb_d_mxwt, twiddle_rsc_1_6_i_biwt,
      twiddle_rsc_1_6_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_6_i_qb_d;
  output [31:0] twiddle_rsc_1_6_i_qb_d_mxwt;
  input twiddle_rsc_1_6_i_biwt;
  input twiddle_rsc_1_6_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_6_i_bcwt;
  reg [31:0] twiddle_rsc_1_6_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_6_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_6_i_qb_d, twiddle_rsc_1_6_i_qb_d_bfwt,
      twiddle_rsc_1_6_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_6_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_6_i_bcwt <= ~((~(twiddle_rsc_1_6_i_bcwt | twiddle_rsc_1_6_i_biwt))
          | twiddle_rsc_1_6_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_6_i_biwt ) begin
      twiddle_rsc_1_6_i_qb_d_bfwt <= twiddle_rsc_1_6_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_6_i_oswt, twiddle_rsc_1_6_i_biwt, twiddle_rsc_1_6_i_bdwt,
      twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_6_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_6_i_oswt;
  output twiddle_rsc_1_6_i_biwt;
  output twiddle_rsc_1_6_i_bdwt;
  output twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_6_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_6_i_bdwt = twiddle_rsc_1_6_i_oswt & core_wen;
  assign twiddle_rsc_1_6_i_biwt = (~ core_wten) & twiddle_rsc_1_6_i_oswt;
  assign twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_6_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_dp (
  clk, rst, twiddle_rsc_1_5_i_qb_d, twiddle_rsc_1_5_i_qb_d_mxwt, twiddle_rsc_1_5_i_biwt,
      twiddle_rsc_1_5_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_5_i_qb_d;
  output [31:0] twiddle_rsc_1_5_i_qb_d_mxwt;
  input twiddle_rsc_1_5_i_biwt;
  input twiddle_rsc_1_5_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_5_i_bcwt;
  reg [31:0] twiddle_rsc_1_5_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_5_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_5_i_qb_d, twiddle_rsc_1_5_i_qb_d_bfwt,
      twiddle_rsc_1_5_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_5_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_5_i_bcwt <= ~((~(twiddle_rsc_1_5_i_bcwt | twiddle_rsc_1_5_i_biwt))
          | twiddle_rsc_1_5_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_5_i_biwt ) begin
      twiddle_rsc_1_5_i_qb_d_bfwt <= twiddle_rsc_1_5_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_5_i_oswt, twiddle_rsc_1_5_i_biwt, twiddle_rsc_1_5_i_bdwt,
      twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_5_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_5_i_oswt;
  output twiddle_rsc_1_5_i_biwt;
  output twiddle_rsc_1_5_i_bdwt;
  output twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_5_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_5_i_bdwt = twiddle_rsc_1_5_i_oswt & core_wen;
  assign twiddle_rsc_1_5_i_biwt = (~ core_wten) & twiddle_rsc_1_5_i_oswt;
  assign twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_5_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_dp (
  clk, rst, twiddle_rsc_1_4_i_qb_d, twiddle_rsc_1_4_i_qb_d_mxwt, twiddle_rsc_1_4_i_biwt,
      twiddle_rsc_1_4_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_4_i_qb_d;
  output [31:0] twiddle_rsc_1_4_i_qb_d_mxwt;
  input twiddle_rsc_1_4_i_biwt;
  input twiddle_rsc_1_4_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_4_i_bcwt;
  reg [31:0] twiddle_rsc_1_4_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_4_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_4_i_qb_d, twiddle_rsc_1_4_i_qb_d_bfwt,
      twiddle_rsc_1_4_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_4_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_4_i_bcwt <= ~((~(twiddle_rsc_1_4_i_bcwt | twiddle_rsc_1_4_i_biwt))
          | twiddle_rsc_1_4_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_4_i_biwt ) begin
      twiddle_rsc_1_4_i_qb_d_bfwt <= twiddle_rsc_1_4_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_4_i_oswt, twiddle_rsc_1_4_i_biwt, twiddle_rsc_1_4_i_bdwt,
      twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_4_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_4_i_oswt;
  output twiddle_rsc_1_4_i_biwt;
  output twiddle_rsc_1_4_i_bdwt;
  output twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_4_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_4_i_bdwt = twiddle_rsc_1_4_i_oswt & core_wen;
  assign twiddle_rsc_1_4_i_biwt = (~ core_wten) & twiddle_rsc_1_4_i_oswt;
  assign twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_4_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_dp (
  clk, rst, twiddle_rsc_1_3_i_qb_d, twiddle_rsc_1_3_i_qb_d_mxwt, twiddle_rsc_1_3_i_biwt,
      twiddle_rsc_1_3_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_3_i_qb_d;
  output [31:0] twiddle_rsc_1_3_i_qb_d_mxwt;
  input twiddle_rsc_1_3_i_biwt;
  input twiddle_rsc_1_3_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_3_i_bcwt;
  reg [31:0] twiddle_rsc_1_3_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_3_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_3_i_qb_d, twiddle_rsc_1_3_i_qb_d_bfwt,
      twiddle_rsc_1_3_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_3_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_3_i_bcwt <= ~((~(twiddle_rsc_1_3_i_bcwt | twiddle_rsc_1_3_i_biwt))
          | twiddle_rsc_1_3_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_3_i_biwt ) begin
      twiddle_rsc_1_3_i_qb_d_bfwt <= twiddle_rsc_1_3_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_3_i_oswt, twiddle_rsc_1_3_i_biwt, twiddle_rsc_1_3_i_bdwt,
      twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_3_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_3_i_oswt;
  output twiddle_rsc_1_3_i_biwt;
  output twiddle_rsc_1_3_i_bdwt;
  output twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_3_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_3_i_bdwt = twiddle_rsc_1_3_i_oswt & core_wen;
  assign twiddle_rsc_1_3_i_biwt = (~ core_wten) & twiddle_rsc_1_3_i_oswt;
  assign twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_3_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_dp (
  clk, rst, twiddle_rsc_1_2_i_qb_d, twiddle_rsc_1_2_i_qb_d_mxwt, twiddle_rsc_1_2_i_biwt,
      twiddle_rsc_1_2_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_2_i_qb_d;
  output [31:0] twiddle_rsc_1_2_i_qb_d_mxwt;
  input twiddle_rsc_1_2_i_biwt;
  input twiddle_rsc_1_2_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_2_i_bcwt;
  reg [31:0] twiddle_rsc_1_2_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_2_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_2_i_qb_d, twiddle_rsc_1_2_i_qb_d_bfwt,
      twiddle_rsc_1_2_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_2_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_2_i_bcwt <= ~((~(twiddle_rsc_1_2_i_bcwt | twiddle_rsc_1_2_i_biwt))
          | twiddle_rsc_1_2_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_2_i_biwt ) begin
      twiddle_rsc_1_2_i_qb_d_bfwt <= twiddle_rsc_1_2_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_2_i_oswt, twiddle_rsc_1_2_i_biwt, twiddle_rsc_1_2_i_bdwt,
      twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_2_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_2_i_oswt;
  output twiddle_rsc_1_2_i_biwt;
  output twiddle_rsc_1_2_i_bdwt;
  output twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_2_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_2_i_bdwt = twiddle_rsc_1_2_i_oswt & core_wen;
  assign twiddle_rsc_1_2_i_biwt = (~ core_wten) & twiddle_rsc_1_2_i_oswt;
  assign twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_2_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_dp (
  clk, rst, twiddle_rsc_1_1_i_qb_d, twiddle_rsc_1_1_i_qb_d_mxwt, twiddle_rsc_1_1_i_biwt,
      twiddle_rsc_1_1_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_1_i_qb_d;
  output [31:0] twiddle_rsc_1_1_i_qb_d_mxwt;
  input twiddle_rsc_1_1_i_biwt;
  input twiddle_rsc_1_1_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_1_i_bcwt;
  reg [31:0] twiddle_rsc_1_1_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_1_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_1_i_qb_d, twiddle_rsc_1_1_i_qb_d_bfwt,
      twiddle_rsc_1_1_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_1_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_1_i_bcwt <= ~((~(twiddle_rsc_1_1_i_bcwt | twiddle_rsc_1_1_i_biwt))
          | twiddle_rsc_1_1_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_1_i_biwt ) begin
      twiddle_rsc_1_1_i_qb_d_bfwt <= twiddle_rsc_1_1_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_1_i_oswt, twiddle_rsc_1_1_i_biwt, twiddle_rsc_1_1_i_bdwt,
      twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_1_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_1_i_oswt;
  output twiddle_rsc_1_1_i_biwt;
  output twiddle_rsc_1_1_i_bdwt;
  output twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_1_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_1_i_bdwt = twiddle_rsc_1_1_i_oswt & core_wen;
  assign twiddle_rsc_1_1_i_biwt = (~ core_wten) & twiddle_rsc_1_1_i_oswt;
  assign twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_1_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_dp (
  clk, rst, twiddle_rsc_1_0_i_qb_d, twiddle_rsc_1_0_i_qb_d_mxwt, twiddle_rsc_1_0_i_biwt,
      twiddle_rsc_1_0_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_0_i_qb_d;
  output [31:0] twiddle_rsc_1_0_i_qb_d_mxwt;
  input twiddle_rsc_1_0_i_biwt;
  input twiddle_rsc_1_0_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_1_0_i_bcwt;
  reg [31:0] twiddle_rsc_1_0_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_0_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_1_0_i_qb_d, twiddle_rsc_1_0_i_qb_d_bfwt,
      twiddle_rsc_1_0_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_1_0_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_1_0_i_bcwt <= ~((~(twiddle_rsc_1_0_i_bcwt | twiddle_rsc_1_0_i_biwt))
          | twiddle_rsc_1_0_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_1_0_i_biwt ) begin
      twiddle_rsc_1_0_i_qb_d_bfwt <= twiddle_rsc_1_0_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_1_0_i_oswt, twiddle_rsc_1_0_i_biwt, twiddle_rsc_1_0_i_bdwt,
      twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_1_0_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_0_i_oswt;
  output twiddle_rsc_1_0_i_biwt;
  output twiddle_rsc_1_0_i_bdwt;
  output twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_1_0_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_1_0_i_bdwt = twiddle_rsc_1_0_i_oswt & core_wen;
  assign twiddle_rsc_1_0_i_biwt = (~ core_wten) & twiddle_rsc_1_0_i_oswt;
  assign twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_1_0_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_dp (
  clk, rst, twiddle_rsc_0_7_i_qb_d, twiddle_rsc_0_7_i_qb_d_mxwt, twiddle_rsc_0_7_i_biwt,
      twiddle_rsc_0_7_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_7_i_qb_d;
  output [31:0] twiddle_rsc_0_7_i_qb_d_mxwt;
  input twiddle_rsc_0_7_i_biwt;
  input twiddle_rsc_0_7_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_7_i_bcwt;
  reg [31:0] twiddle_rsc_0_7_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_7_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_7_i_qb_d, twiddle_rsc_0_7_i_qb_d_bfwt,
      twiddle_rsc_0_7_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_7_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_7_i_bcwt <= ~((~(twiddle_rsc_0_7_i_bcwt | twiddle_rsc_0_7_i_biwt))
          | twiddle_rsc_0_7_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_7_i_biwt ) begin
      twiddle_rsc_0_7_i_qb_d_bfwt <= twiddle_rsc_0_7_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_7_i_oswt, twiddle_rsc_0_7_i_biwt, twiddle_rsc_0_7_i_bdwt,
      twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_7_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_7_i_oswt;
  output twiddle_rsc_0_7_i_biwt;
  output twiddle_rsc_0_7_i_bdwt;
  output twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_7_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_7_i_bdwt = twiddle_rsc_0_7_i_oswt & core_wen;
  assign twiddle_rsc_0_7_i_biwt = (~ core_wten) & twiddle_rsc_0_7_i_oswt;
  assign twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_7_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_dp (
  clk, rst, twiddle_rsc_0_6_i_qb_d, twiddle_rsc_0_6_i_qb_d_mxwt, twiddle_rsc_0_6_i_biwt,
      twiddle_rsc_0_6_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_6_i_qb_d;
  output [31:0] twiddle_rsc_0_6_i_qb_d_mxwt;
  input twiddle_rsc_0_6_i_biwt;
  input twiddle_rsc_0_6_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_6_i_bcwt;
  reg [31:0] twiddle_rsc_0_6_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_6_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_6_i_qb_d, twiddle_rsc_0_6_i_qb_d_bfwt,
      twiddle_rsc_0_6_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_6_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_6_i_bcwt <= ~((~(twiddle_rsc_0_6_i_bcwt | twiddle_rsc_0_6_i_biwt))
          | twiddle_rsc_0_6_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_6_i_biwt ) begin
      twiddle_rsc_0_6_i_qb_d_bfwt <= twiddle_rsc_0_6_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_6_i_oswt, twiddle_rsc_0_6_i_biwt, twiddle_rsc_0_6_i_bdwt,
      twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_6_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_6_i_oswt;
  output twiddle_rsc_0_6_i_biwt;
  output twiddle_rsc_0_6_i_bdwt;
  output twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_6_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_6_i_bdwt = twiddle_rsc_0_6_i_oswt & core_wen;
  assign twiddle_rsc_0_6_i_biwt = (~ core_wten) & twiddle_rsc_0_6_i_oswt;
  assign twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_6_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_dp (
  clk, rst, twiddle_rsc_0_5_i_qb_d, twiddle_rsc_0_5_i_qb_d_mxwt, twiddle_rsc_0_5_i_biwt,
      twiddle_rsc_0_5_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_5_i_qb_d;
  output [31:0] twiddle_rsc_0_5_i_qb_d_mxwt;
  input twiddle_rsc_0_5_i_biwt;
  input twiddle_rsc_0_5_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_5_i_bcwt;
  reg [31:0] twiddle_rsc_0_5_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_5_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_5_i_qb_d, twiddle_rsc_0_5_i_qb_d_bfwt,
      twiddle_rsc_0_5_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_5_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_5_i_bcwt <= ~((~(twiddle_rsc_0_5_i_bcwt | twiddle_rsc_0_5_i_biwt))
          | twiddle_rsc_0_5_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_5_i_biwt ) begin
      twiddle_rsc_0_5_i_qb_d_bfwt <= twiddle_rsc_0_5_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_5_i_oswt, twiddle_rsc_0_5_i_biwt, twiddle_rsc_0_5_i_bdwt,
      twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_5_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_5_i_oswt;
  output twiddle_rsc_0_5_i_biwt;
  output twiddle_rsc_0_5_i_bdwt;
  output twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_5_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_5_i_bdwt = twiddle_rsc_0_5_i_oswt & core_wen;
  assign twiddle_rsc_0_5_i_biwt = (~ core_wten) & twiddle_rsc_0_5_i_oswt;
  assign twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_5_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_dp (
  clk, rst, twiddle_rsc_0_4_i_qb_d, twiddle_rsc_0_4_i_qb_d_mxwt, twiddle_rsc_0_4_i_biwt,
      twiddle_rsc_0_4_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_4_i_qb_d;
  output [31:0] twiddle_rsc_0_4_i_qb_d_mxwt;
  input twiddle_rsc_0_4_i_biwt;
  input twiddle_rsc_0_4_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_4_i_bcwt;
  reg [31:0] twiddle_rsc_0_4_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_4_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_4_i_qb_d, twiddle_rsc_0_4_i_qb_d_bfwt,
      twiddle_rsc_0_4_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_4_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_4_i_bcwt <= ~((~(twiddle_rsc_0_4_i_bcwt | twiddle_rsc_0_4_i_biwt))
          | twiddle_rsc_0_4_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_4_i_biwt ) begin
      twiddle_rsc_0_4_i_qb_d_bfwt <= twiddle_rsc_0_4_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_4_i_oswt, twiddle_rsc_0_4_i_biwt, twiddle_rsc_0_4_i_bdwt,
      twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_4_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_4_i_oswt;
  output twiddle_rsc_0_4_i_biwt;
  output twiddle_rsc_0_4_i_bdwt;
  output twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_4_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_4_i_bdwt = twiddle_rsc_0_4_i_oswt & core_wen;
  assign twiddle_rsc_0_4_i_biwt = (~ core_wten) & twiddle_rsc_0_4_i_oswt;
  assign twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_4_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_dp (
  clk, rst, twiddle_rsc_0_3_i_qb_d, twiddle_rsc_0_3_i_qb_d_mxwt, twiddle_rsc_0_3_i_biwt,
      twiddle_rsc_0_3_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_3_i_qb_d;
  output [31:0] twiddle_rsc_0_3_i_qb_d_mxwt;
  input twiddle_rsc_0_3_i_biwt;
  input twiddle_rsc_0_3_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_3_i_bcwt;
  reg [31:0] twiddle_rsc_0_3_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_3_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_3_i_qb_d, twiddle_rsc_0_3_i_qb_d_bfwt,
      twiddle_rsc_0_3_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_3_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_3_i_bcwt <= ~((~(twiddle_rsc_0_3_i_bcwt | twiddle_rsc_0_3_i_biwt))
          | twiddle_rsc_0_3_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_3_i_biwt ) begin
      twiddle_rsc_0_3_i_qb_d_bfwt <= twiddle_rsc_0_3_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_3_i_oswt, twiddle_rsc_0_3_i_biwt, twiddle_rsc_0_3_i_bdwt,
      twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_3_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_3_i_oswt;
  output twiddle_rsc_0_3_i_biwt;
  output twiddle_rsc_0_3_i_bdwt;
  output twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_3_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_3_i_bdwt = twiddle_rsc_0_3_i_oswt & core_wen;
  assign twiddle_rsc_0_3_i_biwt = (~ core_wten) & twiddle_rsc_0_3_i_oswt;
  assign twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_3_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_dp (
  clk, rst, twiddle_rsc_0_2_i_qb_d, twiddle_rsc_0_2_i_qb_d_mxwt, twiddle_rsc_0_2_i_biwt,
      twiddle_rsc_0_2_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_2_i_qb_d;
  output [31:0] twiddle_rsc_0_2_i_qb_d_mxwt;
  input twiddle_rsc_0_2_i_biwt;
  input twiddle_rsc_0_2_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_2_i_bcwt;
  reg [31:0] twiddle_rsc_0_2_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_2_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_2_i_qb_d, twiddle_rsc_0_2_i_qb_d_bfwt,
      twiddle_rsc_0_2_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_2_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_2_i_bcwt <= ~((~(twiddle_rsc_0_2_i_bcwt | twiddle_rsc_0_2_i_biwt))
          | twiddle_rsc_0_2_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_2_i_biwt ) begin
      twiddle_rsc_0_2_i_qb_d_bfwt <= twiddle_rsc_0_2_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_2_i_oswt, twiddle_rsc_0_2_i_biwt, twiddle_rsc_0_2_i_bdwt,
      twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_2_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_2_i_oswt;
  output twiddle_rsc_0_2_i_biwt;
  output twiddle_rsc_0_2_i_bdwt;
  output twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_2_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_2_i_bdwt = twiddle_rsc_0_2_i_oswt & core_wen;
  assign twiddle_rsc_0_2_i_biwt = (~ core_wten) & twiddle_rsc_0_2_i_oswt;
  assign twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_2_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_dp (
  clk, rst, twiddle_rsc_0_1_i_qb_d, twiddle_rsc_0_1_i_qb_d_mxwt, twiddle_rsc_0_1_i_biwt,
      twiddle_rsc_0_1_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_1_i_qb_d;
  output [31:0] twiddle_rsc_0_1_i_qb_d_mxwt;
  input twiddle_rsc_0_1_i_biwt;
  input twiddle_rsc_0_1_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_1_i_bcwt;
  reg [31:0] twiddle_rsc_0_1_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_1_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_1_i_qb_d, twiddle_rsc_0_1_i_qb_d_bfwt,
      twiddle_rsc_0_1_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_1_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_1_i_bcwt <= ~((~(twiddle_rsc_0_1_i_bcwt | twiddle_rsc_0_1_i_biwt))
          | twiddle_rsc_0_1_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_1_i_biwt ) begin
      twiddle_rsc_0_1_i_qb_d_bfwt <= twiddle_rsc_0_1_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_1_i_oswt, twiddle_rsc_0_1_i_biwt, twiddle_rsc_0_1_i_bdwt,
      twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_1_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_1_i_oswt;
  output twiddle_rsc_0_1_i_biwt;
  output twiddle_rsc_0_1_i_bdwt;
  output twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_1_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_1_i_bdwt = twiddle_rsc_0_1_i_oswt & core_wen;
  assign twiddle_rsc_0_1_i_biwt = (~ core_wten) & twiddle_rsc_0_1_i_oswt;
  assign twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_1_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_dp (
  clk, rst, twiddle_rsc_0_0_i_qb_d, twiddle_rsc_0_0_i_qb_d_mxwt, twiddle_rsc_0_0_i_biwt,
      twiddle_rsc_0_0_i_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_0_i_qb_d;
  output [31:0] twiddle_rsc_0_0_i_qb_d_mxwt;
  input twiddle_rsc_0_0_i_biwt;
  input twiddle_rsc_0_0_i_bdwt;


  // Interconnect Declarations
  reg twiddle_rsc_0_0_i_bcwt;
  reg [31:0] twiddle_rsc_0_0_i_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_0_i_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsc_0_0_i_qb_d, twiddle_rsc_0_0_i_qb_d_bfwt,
      twiddle_rsc_0_0_i_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsc_0_0_i_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsc_0_0_i_bcwt <= ~((~(twiddle_rsc_0_0_i_bcwt | twiddle_rsc_0_0_i_biwt))
          | twiddle_rsc_0_0_i_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsc_0_0_i_biwt ) begin
      twiddle_rsc_0_0_i_qb_d_bfwt <= twiddle_rsc_0_0_i_qb_d;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_ctrl
    (
  core_wen, core_wten, twiddle_rsc_0_0_i_oswt, twiddle_rsc_0_0_i_biwt, twiddle_rsc_0_0_i_bdwt,
      twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsc_0_0_i_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_0_i_oswt;
  output twiddle_rsc_0_0_i_biwt;
  output twiddle_rsc_0_0_i_bdwt;
  output twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsc_0_0_i_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_0_0_i_bdwt = twiddle_rsc_0_0_i_oswt & core_wen;
  assign twiddle_rsc_0_0_i_biwt = (~ core_wten) & twiddle_rsc_0_0_i_oswt;
  assign twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsc_0_0_i_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_dp (
  clk, rst, vec_rsc_1_7_i_da_d, vec_rsc_1_7_i_qa_d, vec_rsc_1_7_i_da_d_core, vec_rsc_1_7_i_qa_d_mxwt,
      vec_rsc_1_7_i_biwt, vec_rsc_1_7_i_bdwt, vec_rsc_1_7_i_biwt_1, vec_rsc_1_7_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_7_i_da_d;
  input [63:0] vec_rsc_1_7_i_qa_d;
  input [63:0] vec_rsc_1_7_i_da_d_core;
  output [63:0] vec_rsc_1_7_i_qa_d_mxwt;
  input vec_rsc_1_7_i_biwt;
  input vec_rsc_1_7_i_bdwt;
  input vec_rsc_1_7_i_biwt_1;
  input vec_rsc_1_7_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_7_i_bcwt;
  reg vec_rsc_1_7_i_bcwt_1;
  reg [31:0] vec_rsc_1_7_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_7_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_62_nl;
  wire[31:0] VEC_LOOP_mux_63_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_62_nl = MUX_v_32_2_2((vec_rsc_1_7_i_qa_d[63:32]), vec_rsc_1_7_i_qa_d_bfwt_63_32,
      vec_rsc_1_7_i_bcwt_1);
  assign VEC_LOOP_mux_63_nl = MUX_v_32_2_2((vec_rsc_1_7_i_qa_d[31:0]), vec_rsc_1_7_i_qa_d_bfwt_31_0,
      vec_rsc_1_7_i_bcwt);
  assign vec_rsc_1_7_i_qa_d_mxwt = {VEC_LOOP_mux_62_nl , VEC_LOOP_mux_63_nl};
  assign vec_rsc_1_7_i_da_d = vec_rsc_1_7_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_7_i_bcwt <= 1'b0;
      vec_rsc_1_7_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_7_i_bcwt <= ~((~(vec_rsc_1_7_i_bcwt | vec_rsc_1_7_i_biwt)) | vec_rsc_1_7_i_bdwt);
      vec_rsc_1_7_i_bcwt_1 <= ~((~(vec_rsc_1_7_i_bcwt_1 | vec_rsc_1_7_i_biwt_1))
          | vec_rsc_1_7_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_7_i_biwt_1 ) begin
      vec_rsc_1_7_i_qa_d_bfwt_63_32 <= vec_rsc_1_7_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_7_i_biwt ) begin
      vec_rsc_1_7_i_qa_d_bfwt_31_0 <= vec_rsc_1_7_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_7_i_oswt, vec_rsc_1_7_i_oswt_1, vec_rsc_1_7_i_wea_d_core_psct,
      vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_7_i_biwt, vec_rsc_1_7_i_bdwt, vec_rsc_1_7_i_biwt_1, vec_rsc_1_7_i_bdwt_2,
      vec_rsc_1_7_i_wea_d_core_sct, vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_7_i_oswt_pff,
      vec_rsc_1_7_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_7_i_oswt;
  input vec_rsc_1_7_i_oswt_1;
  input [1:0] vec_rsc_1_7_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_7_i_biwt;
  output vec_rsc_1_7_i_bdwt;
  output vec_rsc_1_7_i_biwt_1;
  output vec_rsc_1_7_i_bdwt_2;
  output [1:0] vec_rsc_1_7_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_7_i_oswt_pff;
  input vec_rsc_1_7_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_7_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_173_nl;
  wire[0:0] VEC_LOOP_and_177_nl;
  wire[0:0] VEC_LOOP_and_175_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_7_i_bdwt = vec_rsc_1_7_i_oswt & core_wen;
  assign vec_rsc_1_7_i_biwt = (~ core_wten) & vec_rsc_1_7_i_oswt;
  assign vec_rsc_1_7_i_bdwt_2 = vec_rsc_1_7_i_oswt_1 & core_wen;
  assign vec_rsc_1_7_i_biwt_1 = (~ core_wten) & vec_rsc_1_7_i_oswt_1;
  assign VEC_LOOP_and_173_nl = (vec_rsc_1_7_i_wea_d_core_psct[0]) & vec_rsc_1_7_i_dswt_pff;
  assign vec_rsc_1_7_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_173_nl};
  assign vec_rsc_1_7_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_7_i_oswt_pff;
  assign VEC_LOOP_and_177_nl = (~ core_wten_pff) & vec_rsc_1_7_i_oswt_1_pff;
  assign vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_177_nl , vec_rsc_1_7_i_dswt_pff});
  assign VEC_LOOP_and_175_nl = (vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_7_i_dswt_pff;
  assign vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_175_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_dp (
  clk, rst, vec_rsc_1_6_i_da_d, vec_rsc_1_6_i_qa_d, vec_rsc_1_6_i_da_d_core, vec_rsc_1_6_i_qa_d_mxwt,
      vec_rsc_1_6_i_biwt, vec_rsc_1_6_i_bdwt, vec_rsc_1_6_i_biwt_1, vec_rsc_1_6_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_6_i_da_d;
  input [63:0] vec_rsc_1_6_i_qa_d;
  input [63:0] vec_rsc_1_6_i_da_d_core;
  output [63:0] vec_rsc_1_6_i_qa_d_mxwt;
  input vec_rsc_1_6_i_biwt;
  input vec_rsc_1_6_i_bdwt;
  input vec_rsc_1_6_i_biwt_1;
  input vec_rsc_1_6_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_6_i_bcwt;
  reg vec_rsc_1_6_i_bcwt_1;
  reg [31:0] vec_rsc_1_6_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_6_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_58_nl;
  wire[31:0] VEC_LOOP_mux_59_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_58_nl = MUX_v_32_2_2((vec_rsc_1_6_i_qa_d[63:32]), vec_rsc_1_6_i_qa_d_bfwt_63_32,
      vec_rsc_1_6_i_bcwt_1);
  assign VEC_LOOP_mux_59_nl = MUX_v_32_2_2((vec_rsc_1_6_i_qa_d[31:0]), vec_rsc_1_6_i_qa_d_bfwt_31_0,
      vec_rsc_1_6_i_bcwt);
  assign vec_rsc_1_6_i_qa_d_mxwt = {VEC_LOOP_mux_58_nl , VEC_LOOP_mux_59_nl};
  assign vec_rsc_1_6_i_da_d = vec_rsc_1_6_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_6_i_bcwt <= 1'b0;
      vec_rsc_1_6_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_6_i_bcwt <= ~((~(vec_rsc_1_6_i_bcwt | vec_rsc_1_6_i_biwt)) | vec_rsc_1_6_i_bdwt);
      vec_rsc_1_6_i_bcwt_1 <= ~((~(vec_rsc_1_6_i_bcwt_1 | vec_rsc_1_6_i_biwt_1))
          | vec_rsc_1_6_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_6_i_biwt_1 ) begin
      vec_rsc_1_6_i_qa_d_bfwt_63_32 <= vec_rsc_1_6_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_6_i_biwt ) begin
      vec_rsc_1_6_i_qa_d_bfwt_31_0 <= vec_rsc_1_6_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_6_i_oswt, vec_rsc_1_6_i_oswt_1, vec_rsc_1_6_i_wea_d_core_psct,
      vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_6_i_biwt, vec_rsc_1_6_i_bdwt, vec_rsc_1_6_i_biwt_1, vec_rsc_1_6_i_bdwt_2,
      vec_rsc_1_6_i_wea_d_core_sct, vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_6_i_oswt_pff,
      vec_rsc_1_6_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_6_i_oswt;
  input vec_rsc_1_6_i_oswt_1;
  input [1:0] vec_rsc_1_6_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_6_i_biwt;
  output vec_rsc_1_6_i_bdwt;
  output vec_rsc_1_6_i_biwt_1;
  output vec_rsc_1_6_i_bdwt_2;
  output [1:0] vec_rsc_1_6_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_6_i_oswt_pff;
  input vec_rsc_1_6_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_6_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_162_nl;
  wire[0:0] VEC_LOOP_and_166_nl;
  wire[0:0] VEC_LOOP_and_164_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_6_i_bdwt = vec_rsc_1_6_i_oswt & core_wen;
  assign vec_rsc_1_6_i_biwt = (~ core_wten) & vec_rsc_1_6_i_oswt;
  assign vec_rsc_1_6_i_bdwt_2 = vec_rsc_1_6_i_oswt_1 & core_wen;
  assign vec_rsc_1_6_i_biwt_1 = (~ core_wten) & vec_rsc_1_6_i_oswt_1;
  assign VEC_LOOP_and_162_nl = (vec_rsc_1_6_i_wea_d_core_psct[0]) & vec_rsc_1_6_i_dswt_pff;
  assign vec_rsc_1_6_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_162_nl};
  assign vec_rsc_1_6_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_6_i_oswt_pff;
  assign VEC_LOOP_and_166_nl = (~ core_wten_pff) & vec_rsc_1_6_i_oswt_1_pff;
  assign vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_166_nl , vec_rsc_1_6_i_dswt_pff});
  assign VEC_LOOP_and_164_nl = (vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_6_i_dswt_pff;
  assign vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_164_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_dp (
  clk, rst, vec_rsc_1_5_i_da_d, vec_rsc_1_5_i_qa_d, vec_rsc_1_5_i_da_d_core, vec_rsc_1_5_i_qa_d_mxwt,
      vec_rsc_1_5_i_biwt, vec_rsc_1_5_i_bdwt, vec_rsc_1_5_i_biwt_1, vec_rsc_1_5_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_5_i_da_d;
  input [63:0] vec_rsc_1_5_i_qa_d;
  input [63:0] vec_rsc_1_5_i_da_d_core;
  output [63:0] vec_rsc_1_5_i_qa_d_mxwt;
  input vec_rsc_1_5_i_biwt;
  input vec_rsc_1_5_i_bdwt;
  input vec_rsc_1_5_i_biwt_1;
  input vec_rsc_1_5_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_5_i_bcwt;
  reg vec_rsc_1_5_i_bcwt_1;
  reg [31:0] vec_rsc_1_5_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_5_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_54_nl;
  wire[31:0] VEC_LOOP_mux_55_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_54_nl = MUX_v_32_2_2((vec_rsc_1_5_i_qa_d[63:32]), vec_rsc_1_5_i_qa_d_bfwt_63_32,
      vec_rsc_1_5_i_bcwt_1);
  assign VEC_LOOP_mux_55_nl = MUX_v_32_2_2((vec_rsc_1_5_i_qa_d[31:0]), vec_rsc_1_5_i_qa_d_bfwt_31_0,
      vec_rsc_1_5_i_bcwt);
  assign vec_rsc_1_5_i_qa_d_mxwt = {VEC_LOOP_mux_54_nl , VEC_LOOP_mux_55_nl};
  assign vec_rsc_1_5_i_da_d = vec_rsc_1_5_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_5_i_bcwt <= 1'b0;
      vec_rsc_1_5_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_5_i_bcwt <= ~((~(vec_rsc_1_5_i_bcwt | vec_rsc_1_5_i_biwt)) | vec_rsc_1_5_i_bdwt);
      vec_rsc_1_5_i_bcwt_1 <= ~((~(vec_rsc_1_5_i_bcwt_1 | vec_rsc_1_5_i_biwt_1))
          | vec_rsc_1_5_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_5_i_biwt_1 ) begin
      vec_rsc_1_5_i_qa_d_bfwt_63_32 <= vec_rsc_1_5_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_5_i_biwt ) begin
      vec_rsc_1_5_i_qa_d_bfwt_31_0 <= vec_rsc_1_5_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_5_i_oswt, vec_rsc_1_5_i_oswt_1, vec_rsc_1_5_i_wea_d_core_psct,
      vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_5_i_biwt, vec_rsc_1_5_i_bdwt, vec_rsc_1_5_i_biwt_1, vec_rsc_1_5_i_bdwt_2,
      vec_rsc_1_5_i_wea_d_core_sct, vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_5_i_oswt_pff,
      vec_rsc_1_5_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_5_i_oswt;
  input vec_rsc_1_5_i_oswt_1;
  input [1:0] vec_rsc_1_5_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_5_i_biwt;
  output vec_rsc_1_5_i_bdwt;
  output vec_rsc_1_5_i_biwt_1;
  output vec_rsc_1_5_i_bdwt_2;
  output [1:0] vec_rsc_1_5_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_5_i_oswt_pff;
  input vec_rsc_1_5_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_5_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_151_nl;
  wire[0:0] VEC_LOOP_and_155_nl;
  wire[0:0] VEC_LOOP_and_153_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_5_i_bdwt = vec_rsc_1_5_i_oswt & core_wen;
  assign vec_rsc_1_5_i_biwt = (~ core_wten) & vec_rsc_1_5_i_oswt;
  assign vec_rsc_1_5_i_bdwt_2 = vec_rsc_1_5_i_oswt_1 & core_wen;
  assign vec_rsc_1_5_i_biwt_1 = (~ core_wten) & vec_rsc_1_5_i_oswt_1;
  assign VEC_LOOP_and_151_nl = (vec_rsc_1_5_i_wea_d_core_psct[0]) & vec_rsc_1_5_i_dswt_pff;
  assign vec_rsc_1_5_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_151_nl};
  assign vec_rsc_1_5_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_5_i_oswt_pff;
  assign VEC_LOOP_and_155_nl = (~ core_wten_pff) & vec_rsc_1_5_i_oswt_1_pff;
  assign vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_155_nl , vec_rsc_1_5_i_dswt_pff});
  assign VEC_LOOP_and_153_nl = (vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_5_i_dswt_pff;
  assign vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_153_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_dp (
  clk, rst, vec_rsc_1_4_i_da_d, vec_rsc_1_4_i_qa_d, vec_rsc_1_4_i_da_d_core, vec_rsc_1_4_i_qa_d_mxwt,
      vec_rsc_1_4_i_biwt, vec_rsc_1_4_i_bdwt, vec_rsc_1_4_i_biwt_1, vec_rsc_1_4_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_4_i_da_d;
  input [63:0] vec_rsc_1_4_i_qa_d;
  input [63:0] vec_rsc_1_4_i_da_d_core;
  output [63:0] vec_rsc_1_4_i_qa_d_mxwt;
  input vec_rsc_1_4_i_biwt;
  input vec_rsc_1_4_i_bdwt;
  input vec_rsc_1_4_i_biwt_1;
  input vec_rsc_1_4_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_4_i_bcwt;
  reg vec_rsc_1_4_i_bcwt_1;
  reg [31:0] vec_rsc_1_4_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_4_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_50_nl;
  wire[31:0] VEC_LOOP_mux_51_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_50_nl = MUX_v_32_2_2((vec_rsc_1_4_i_qa_d[63:32]), vec_rsc_1_4_i_qa_d_bfwt_63_32,
      vec_rsc_1_4_i_bcwt_1);
  assign VEC_LOOP_mux_51_nl = MUX_v_32_2_2((vec_rsc_1_4_i_qa_d[31:0]), vec_rsc_1_4_i_qa_d_bfwt_31_0,
      vec_rsc_1_4_i_bcwt);
  assign vec_rsc_1_4_i_qa_d_mxwt = {VEC_LOOP_mux_50_nl , VEC_LOOP_mux_51_nl};
  assign vec_rsc_1_4_i_da_d = vec_rsc_1_4_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_4_i_bcwt <= 1'b0;
      vec_rsc_1_4_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_4_i_bcwt <= ~((~(vec_rsc_1_4_i_bcwt | vec_rsc_1_4_i_biwt)) | vec_rsc_1_4_i_bdwt);
      vec_rsc_1_4_i_bcwt_1 <= ~((~(vec_rsc_1_4_i_bcwt_1 | vec_rsc_1_4_i_biwt_1))
          | vec_rsc_1_4_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_4_i_biwt_1 ) begin
      vec_rsc_1_4_i_qa_d_bfwt_63_32 <= vec_rsc_1_4_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_4_i_biwt ) begin
      vec_rsc_1_4_i_qa_d_bfwt_31_0 <= vec_rsc_1_4_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_4_i_oswt, vec_rsc_1_4_i_oswt_1, vec_rsc_1_4_i_wea_d_core_psct,
      vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_4_i_biwt, vec_rsc_1_4_i_bdwt, vec_rsc_1_4_i_biwt_1, vec_rsc_1_4_i_bdwt_2,
      vec_rsc_1_4_i_wea_d_core_sct, vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_4_i_oswt_pff,
      vec_rsc_1_4_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_4_i_oswt;
  input vec_rsc_1_4_i_oswt_1;
  input [1:0] vec_rsc_1_4_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_4_i_biwt;
  output vec_rsc_1_4_i_bdwt;
  output vec_rsc_1_4_i_biwt_1;
  output vec_rsc_1_4_i_bdwt_2;
  output [1:0] vec_rsc_1_4_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_4_i_oswt_pff;
  input vec_rsc_1_4_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_4_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_140_nl;
  wire[0:0] VEC_LOOP_and_144_nl;
  wire[0:0] VEC_LOOP_and_142_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_4_i_bdwt = vec_rsc_1_4_i_oswt & core_wen;
  assign vec_rsc_1_4_i_biwt = (~ core_wten) & vec_rsc_1_4_i_oswt;
  assign vec_rsc_1_4_i_bdwt_2 = vec_rsc_1_4_i_oswt_1 & core_wen;
  assign vec_rsc_1_4_i_biwt_1 = (~ core_wten) & vec_rsc_1_4_i_oswt_1;
  assign VEC_LOOP_and_140_nl = (vec_rsc_1_4_i_wea_d_core_psct[0]) & vec_rsc_1_4_i_dswt_pff;
  assign vec_rsc_1_4_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_140_nl};
  assign vec_rsc_1_4_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_4_i_oswt_pff;
  assign VEC_LOOP_and_144_nl = (~ core_wten_pff) & vec_rsc_1_4_i_oswt_1_pff;
  assign vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_144_nl , vec_rsc_1_4_i_dswt_pff});
  assign VEC_LOOP_and_142_nl = (vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_4_i_dswt_pff;
  assign vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_142_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_dp (
  clk, rst, vec_rsc_1_3_i_da_d, vec_rsc_1_3_i_qa_d, vec_rsc_1_3_i_da_d_core, vec_rsc_1_3_i_qa_d_mxwt,
      vec_rsc_1_3_i_biwt, vec_rsc_1_3_i_bdwt, vec_rsc_1_3_i_biwt_1, vec_rsc_1_3_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_3_i_da_d;
  input [63:0] vec_rsc_1_3_i_qa_d;
  input [63:0] vec_rsc_1_3_i_da_d_core;
  output [63:0] vec_rsc_1_3_i_qa_d_mxwt;
  input vec_rsc_1_3_i_biwt;
  input vec_rsc_1_3_i_bdwt;
  input vec_rsc_1_3_i_biwt_1;
  input vec_rsc_1_3_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_3_i_bcwt;
  reg vec_rsc_1_3_i_bcwt_1;
  reg [31:0] vec_rsc_1_3_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_3_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_46_nl;
  wire[31:0] VEC_LOOP_mux_47_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_46_nl = MUX_v_32_2_2((vec_rsc_1_3_i_qa_d[63:32]), vec_rsc_1_3_i_qa_d_bfwt_63_32,
      vec_rsc_1_3_i_bcwt_1);
  assign VEC_LOOP_mux_47_nl = MUX_v_32_2_2((vec_rsc_1_3_i_qa_d[31:0]), vec_rsc_1_3_i_qa_d_bfwt_31_0,
      vec_rsc_1_3_i_bcwt);
  assign vec_rsc_1_3_i_qa_d_mxwt = {VEC_LOOP_mux_46_nl , VEC_LOOP_mux_47_nl};
  assign vec_rsc_1_3_i_da_d = vec_rsc_1_3_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_3_i_bcwt <= 1'b0;
      vec_rsc_1_3_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_3_i_bcwt <= ~((~(vec_rsc_1_3_i_bcwt | vec_rsc_1_3_i_biwt)) | vec_rsc_1_3_i_bdwt);
      vec_rsc_1_3_i_bcwt_1 <= ~((~(vec_rsc_1_3_i_bcwt_1 | vec_rsc_1_3_i_biwt_1))
          | vec_rsc_1_3_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_3_i_biwt_1 ) begin
      vec_rsc_1_3_i_qa_d_bfwt_63_32 <= vec_rsc_1_3_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_3_i_biwt ) begin
      vec_rsc_1_3_i_qa_d_bfwt_31_0 <= vec_rsc_1_3_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_3_i_oswt, vec_rsc_1_3_i_oswt_1, vec_rsc_1_3_i_wea_d_core_psct,
      vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_3_i_biwt, vec_rsc_1_3_i_bdwt, vec_rsc_1_3_i_biwt_1, vec_rsc_1_3_i_bdwt_2,
      vec_rsc_1_3_i_wea_d_core_sct, vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_3_i_oswt_pff,
      vec_rsc_1_3_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_3_i_oswt;
  input vec_rsc_1_3_i_oswt_1;
  input [1:0] vec_rsc_1_3_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_3_i_biwt;
  output vec_rsc_1_3_i_bdwt;
  output vec_rsc_1_3_i_biwt_1;
  output vec_rsc_1_3_i_bdwt_2;
  output [1:0] vec_rsc_1_3_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_3_i_oswt_pff;
  input vec_rsc_1_3_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_3_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_129_nl;
  wire[0:0] VEC_LOOP_and_133_nl;
  wire[0:0] VEC_LOOP_and_131_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_3_i_bdwt = vec_rsc_1_3_i_oswt & core_wen;
  assign vec_rsc_1_3_i_biwt = (~ core_wten) & vec_rsc_1_3_i_oswt;
  assign vec_rsc_1_3_i_bdwt_2 = vec_rsc_1_3_i_oswt_1 & core_wen;
  assign vec_rsc_1_3_i_biwt_1 = (~ core_wten) & vec_rsc_1_3_i_oswt_1;
  assign VEC_LOOP_and_129_nl = (vec_rsc_1_3_i_wea_d_core_psct[0]) & vec_rsc_1_3_i_dswt_pff;
  assign vec_rsc_1_3_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_129_nl};
  assign vec_rsc_1_3_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_3_i_oswt_pff;
  assign VEC_LOOP_and_133_nl = (~ core_wten_pff) & vec_rsc_1_3_i_oswt_1_pff;
  assign vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_133_nl , vec_rsc_1_3_i_dswt_pff});
  assign VEC_LOOP_and_131_nl = (vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_3_i_dswt_pff;
  assign vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_131_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_dp (
  clk, rst, vec_rsc_1_2_i_da_d, vec_rsc_1_2_i_qa_d, vec_rsc_1_2_i_da_d_core, vec_rsc_1_2_i_qa_d_mxwt,
      vec_rsc_1_2_i_biwt, vec_rsc_1_2_i_bdwt, vec_rsc_1_2_i_biwt_1, vec_rsc_1_2_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_2_i_da_d;
  input [63:0] vec_rsc_1_2_i_qa_d;
  input [63:0] vec_rsc_1_2_i_da_d_core;
  output [63:0] vec_rsc_1_2_i_qa_d_mxwt;
  input vec_rsc_1_2_i_biwt;
  input vec_rsc_1_2_i_bdwt;
  input vec_rsc_1_2_i_biwt_1;
  input vec_rsc_1_2_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_2_i_bcwt;
  reg vec_rsc_1_2_i_bcwt_1;
  reg [31:0] vec_rsc_1_2_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_2_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_42_nl;
  wire[31:0] VEC_LOOP_mux_43_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_42_nl = MUX_v_32_2_2((vec_rsc_1_2_i_qa_d[63:32]), vec_rsc_1_2_i_qa_d_bfwt_63_32,
      vec_rsc_1_2_i_bcwt_1);
  assign VEC_LOOP_mux_43_nl = MUX_v_32_2_2((vec_rsc_1_2_i_qa_d[31:0]), vec_rsc_1_2_i_qa_d_bfwt_31_0,
      vec_rsc_1_2_i_bcwt);
  assign vec_rsc_1_2_i_qa_d_mxwt = {VEC_LOOP_mux_42_nl , VEC_LOOP_mux_43_nl};
  assign vec_rsc_1_2_i_da_d = vec_rsc_1_2_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_2_i_bcwt <= 1'b0;
      vec_rsc_1_2_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_2_i_bcwt <= ~((~(vec_rsc_1_2_i_bcwt | vec_rsc_1_2_i_biwt)) | vec_rsc_1_2_i_bdwt);
      vec_rsc_1_2_i_bcwt_1 <= ~((~(vec_rsc_1_2_i_bcwt_1 | vec_rsc_1_2_i_biwt_1))
          | vec_rsc_1_2_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_2_i_biwt_1 ) begin
      vec_rsc_1_2_i_qa_d_bfwt_63_32 <= vec_rsc_1_2_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_2_i_biwt ) begin
      vec_rsc_1_2_i_qa_d_bfwt_31_0 <= vec_rsc_1_2_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_2_i_oswt, vec_rsc_1_2_i_oswt_1, vec_rsc_1_2_i_wea_d_core_psct,
      vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_2_i_biwt, vec_rsc_1_2_i_bdwt, vec_rsc_1_2_i_biwt_1, vec_rsc_1_2_i_bdwt_2,
      vec_rsc_1_2_i_wea_d_core_sct, vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_2_i_oswt_pff,
      vec_rsc_1_2_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_2_i_oswt;
  input vec_rsc_1_2_i_oswt_1;
  input [1:0] vec_rsc_1_2_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_2_i_biwt;
  output vec_rsc_1_2_i_bdwt;
  output vec_rsc_1_2_i_biwt_1;
  output vec_rsc_1_2_i_bdwt_2;
  output [1:0] vec_rsc_1_2_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_2_i_oswt_pff;
  input vec_rsc_1_2_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_2_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_118_nl;
  wire[0:0] VEC_LOOP_and_122_nl;
  wire[0:0] VEC_LOOP_and_120_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_2_i_bdwt = vec_rsc_1_2_i_oswt & core_wen;
  assign vec_rsc_1_2_i_biwt = (~ core_wten) & vec_rsc_1_2_i_oswt;
  assign vec_rsc_1_2_i_bdwt_2 = vec_rsc_1_2_i_oswt_1 & core_wen;
  assign vec_rsc_1_2_i_biwt_1 = (~ core_wten) & vec_rsc_1_2_i_oswt_1;
  assign VEC_LOOP_and_118_nl = (vec_rsc_1_2_i_wea_d_core_psct[0]) & vec_rsc_1_2_i_dswt_pff;
  assign vec_rsc_1_2_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_118_nl};
  assign vec_rsc_1_2_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_2_i_oswt_pff;
  assign VEC_LOOP_and_122_nl = (~ core_wten_pff) & vec_rsc_1_2_i_oswt_1_pff;
  assign vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_122_nl , vec_rsc_1_2_i_dswt_pff});
  assign VEC_LOOP_and_120_nl = (vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_2_i_dswt_pff;
  assign vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_120_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_dp (
  clk, rst, vec_rsc_1_1_i_da_d, vec_rsc_1_1_i_qa_d, vec_rsc_1_1_i_da_d_core, vec_rsc_1_1_i_qa_d_mxwt,
      vec_rsc_1_1_i_biwt, vec_rsc_1_1_i_bdwt, vec_rsc_1_1_i_biwt_1, vec_rsc_1_1_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_1_i_da_d;
  input [63:0] vec_rsc_1_1_i_qa_d;
  input [63:0] vec_rsc_1_1_i_da_d_core;
  output [63:0] vec_rsc_1_1_i_qa_d_mxwt;
  input vec_rsc_1_1_i_biwt;
  input vec_rsc_1_1_i_bdwt;
  input vec_rsc_1_1_i_biwt_1;
  input vec_rsc_1_1_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_1_i_bcwt;
  reg vec_rsc_1_1_i_bcwt_1;
  reg [31:0] vec_rsc_1_1_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_1_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_38_nl;
  wire[31:0] VEC_LOOP_mux_39_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_38_nl = MUX_v_32_2_2((vec_rsc_1_1_i_qa_d[63:32]), vec_rsc_1_1_i_qa_d_bfwt_63_32,
      vec_rsc_1_1_i_bcwt_1);
  assign VEC_LOOP_mux_39_nl = MUX_v_32_2_2((vec_rsc_1_1_i_qa_d[31:0]), vec_rsc_1_1_i_qa_d_bfwt_31_0,
      vec_rsc_1_1_i_bcwt);
  assign vec_rsc_1_1_i_qa_d_mxwt = {VEC_LOOP_mux_38_nl , VEC_LOOP_mux_39_nl};
  assign vec_rsc_1_1_i_da_d = vec_rsc_1_1_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_1_i_bcwt <= 1'b0;
      vec_rsc_1_1_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_1_i_bcwt <= ~((~(vec_rsc_1_1_i_bcwt | vec_rsc_1_1_i_biwt)) | vec_rsc_1_1_i_bdwt);
      vec_rsc_1_1_i_bcwt_1 <= ~((~(vec_rsc_1_1_i_bcwt_1 | vec_rsc_1_1_i_biwt_1))
          | vec_rsc_1_1_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_1_i_biwt_1 ) begin
      vec_rsc_1_1_i_qa_d_bfwt_63_32 <= vec_rsc_1_1_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_1_i_biwt ) begin
      vec_rsc_1_1_i_qa_d_bfwt_31_0 <= vec_rsc_1_1_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_1_i_oswt, vec_rsc_1_1_i_oswt_1, vec_rsc_1_1_i_wea_d_core_psct,
      vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_1_i_biwt, vec_rsc_1_1_i_bdwt, vec_rsc_1_1_i_biwt_1, vec_rsc_1_1_i_bdwt_2,
      vec_rsc_1_1_i_wea_d_core_sct, vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_1_i_oswt_pff,
      vec_rsc_1_1_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_1_i_oswt;
  input vec_rsc_1_1_i_oswt_1;
  input [1:0] vec_rsc_1_1_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_1_i_biwt;
  output vec_rsc_1_1_i_bdwt;
  output vec_rsc_1_1_i_biwt_1;
  output vec_rsc_1_1_i_bdwt_2;
  output [1:0] vec_rsc_1_1_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_1_i_oswt_pff;
  input vec_rsc_1_1_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_1_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_107_nl;
  wire[0:0] VEC_LOOP_and_111_nl;
  wire[0:0] VEC_LOOP_and_109_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_1_i_bdwt = vec_rsc_1_1_i_oswt & core_wen;
  assign vec_rsc_1_1_i_biwt = (~ core_wten) & vec_rsc_1_1_i_oswt;
  assign vec_rsc_1_1_i_bdwt_2 = vec_rsc_1_1_i_oswt_1 & core_wen;
  assign vec_rsc_1_1_i_biwt_1 = (~ core_wten) & vec_rsc_1_1_i_oswt_1;
  assign VEC_LOOP_and_107_nl = (vec_rsc_1_1_i_wea_d_core_psct[0]) & vec_rsc_1_1_i_dswt_pff;
  assign vec_rsc_1_1_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_107_nl};
  assign vec_rsc_1_1_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_1_i_oswt_pff;
  assign VEC_LOOP_and_111_nl = (~ core_wten_pff) & vec_rsc_1_1_i_oswt_1_pff;
  assign vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_111_nl , vec_rsc_1_1_i_dswt_pff});
  assign VEC_LOOP_and_109_nl = (vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_1_i_dswt_pff;
  assign vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_109_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_dp (
  clk, rst, vec_rsc_1_0_i_da_d, vec_rsc_1_0_i_qa_d, vec_rsc_1_0_i_da_d_core, vec_rsc_1_0_i_qa_d_mxwt,
      vec_rsc_1_0_i_biwt, vec_rsc_1_0_i_bdwt, vec_rsc_1_0_i_biwt_1, vec_rsc_1_0_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_0_i_da_d;
  input [63:0] vec_rsc_1_0_i_qa_d;
  input [63:0] vec_rsc_1_0_i_da_d_core;
  output [63:0] vec_rsc_1_0_i_qa_d_mxwt;
  input vec_rsc_1_0_i_biwt;
  input vec_rsc_1_0_i_bdwt;
  input vec_rsc_1_0_i_biwt_1;
  input vec_rsc_1_0_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_1_0_i_bcwt;
  reg vec_rsc_1_0_i_bcwt_1;
  reg [31:0] vec_rsc_1_0_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_1_0_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_34_nl;
  wire[31:0] VEC_LOOP_mux_35_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_34_nl = MUX_v_32_2_2((vec_rsc_1_0_i_qa_d[63:32]), vec_rsc_1_0_i_qa_d_bfwt_63_32,
      vec_rsc_1_0_i_bcwt_1);
  assign VEC_LOOP_mux_35_nl = MUX_v_32_2_2((vec_rsc_1_0_i_qa_d[31:0]), vec_rsc_1_0_i_qa_d_bfwt_31_0,
      vec_rsc_1_0_i_bcwt);
  assign vec_rsc_1_0_i_qa_d_mxwt = {VEC_LOOP_mux_34_nl , VEC_LOOP_mux_35_nl};
  assign vec_rsc_1_0_i_da_d = vec_rsc_1_0_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_1_0_i_bcwt <= 1'b0;
      vec_rsc_1_0_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_1_0_i_bcwt <= ~((~(vec_rsc_1_0_i_bcwt | vec_rsc_1_0_i_biwt)) | vec_rsc_1_0_i_bdwt);
      vec_rsc_1_0_i_bcwt_1 <= ~((~(vec_rsc_1_0_i_bcwt_1 | vec_rsc_1_0_i_biwt_1))
          | vec_rsc_1_0_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_0_i_biwt_1 ) begin
      vec_rsc_1_0_i_qa_d_bfwt_63_32 <= vec_rsc_1_0_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_1_0_i_biwt ) begin
      vec_rsc_1_0_i_qa_d_bfwt_31_0 <= vec_rsc_1_0_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl (
  core_wen, core_wten, vec_rsc_1_0_i_oswt, vec_rsc_1_0_i_oswt_1, vec_rsc_1_0_i_wea_d_core_psct,
      vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_1_0_i_biwt, vec_rsc_1_0_i_bdwt, vec_rsc_1_0_i_biwt_1, vec_rsc_1_0_i_bdwt_2,
      vec_rsc_1_0_i_wea_d_core_sct, vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_1_0_i_oswt_pff,
      vec_rsc_1_0_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_1_0_i_oswt;
  input vec_rsc_1_0_i_oswt_1;
  input [1:0] vec_rsc_1_0_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_1_0_i_biwt;
  output vec_rsc_1_0_i_bdwt;
  output vec_rsc_1_0_i_biwt_1;
  output vec_rsc_1_0_i_bdwt_2;
  output [1:0] vec_rsc_1_0_i_wea_d_core_sct;
  output [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_1_0_i_oswt_pff;
  input vec_rsc_1_0_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_0_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_96_nl;
  wire[0:0] VEC_LOOP_and_100_nl;
  wire[0:0] VEC_LOOP_and_98_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_1_0_i_bdwt = vec_rsc_1_0_i_oswt & core_wen;
  assign vec_rsc_1_0_i_biwt = (~ core_wten) & vec_rsc_1_0_i_oswt;
  assign vec_rsc_1_0_i_bdwt_2 = vec_rsc_1_0_i_oswt_1 & core_wen;
  assign vec_rsc_1_0_i_biwt_1 = (~ core_wten) & vec_rsc_1_0_i_oswt_1;
  assign VEC_LOOP_and_96_nl = (vec_rsc_1_0_i_wea_d_core_psct[0]) & vec_rsc_1_0_i_dswt_pff;
  assign vec_rsc_1_0_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_96_nl};
  assign vec_rsc_1_0_i_dswt_pff = (~ core_wten_pff) & vec_rsc_1_0_i_oswt_pff;
  assign VEC_LOOP_and_100_nl = (~ core_wten_pff) & vec_rsc_1_0_i_oswt_1_pff;
  assign vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_100_nl , vec_rsc_1_0_i_dswt_pff});
  assign VEC_LOOP_and_98_nl = (vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_1_0_i_dswt_pff;
  assign vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_98_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_dp (
  clk, rst, vec_rsc_0_7_i_da_d, vec_rsc_0_7_i_qa_d, vec_rsc_0_7_i_da_d_core, vec_rsc_0_7_i_qa_d_mxwt,
      vec_rsc_0_7_i_biwt, vec_rsc_0_7_i_bdwt, vec_rsc_0_7_i_biwt_1, vec_rsc_0_7_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_7_i_da_d;
  input [63:0] vec_rsc_0_7_i_qa_d;
  input [63:0] vec_rsc_0_7_i_da_d_core;
  output [63:0] vec_rsc_0_7_i_qa_d_mxwt;
  input vec_rsc_0_7_i_biwt;
  input vec_rsc_0_7_i_bdwt;
  input vec_rsc_0_7_i_biwt_1;
  input vec_rsc_0_7_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_7_i_bcwt;
  reg vec_rsc_0_7_i_bcwt_1;
  reg [31:0] vec_rsc_0_7_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_7_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_30_nl;
  wire[31:0] VEC_LOOP_mux_31_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_30_nl = MUX_v_32_2_2((vec_rsc_0_7_i_qa_d[63:32]), vec_rsc_0_7_i_qa_d_bfwt_63_32,
      vec_rsc_0_7_i_bcwt_1);
  assign VEC_LOOP_mux_31_nl = MUX_v_32_2_2((vec_rsc_0_7_i_qa_d[31:0]), vec_rsc_0_7_i_qa_d_bfwt_31_0,
      vec_rsc_0_7_i_bcwt);
  assign vec_rsc_0_7_i_qa_d_mxwt = {VEC_LOOP_mux_30_nl , VEC_LOOP_mux_31_nl};
  assign vec_rsc_0_7_i_da_d = vec_rsc_0_7_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_7_i_bcwt <= 1'b0;
      vec_rsc_0_7_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_7_i_bcwt <= ~((~(vec_rsc_0_7_i_bcwt | vec_rsc_0_7_i_biwt)) | vec_rsc_0_7_i_bdwt);
      vec_rsc_0_7_i_bcwt_1 <= ~((~(vec_rsc_0_7_i_bcwt_1 | vec_rsc_0_7_i_biwt_1))
          | vec_rsc_0_7_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_7_i_biwt_1 ) begin
      vec_rsc_0_7_i_qa_d_bfwt_63_32 <= vec_rsc_0_7_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_7_i_biwt ) begin
      vec_rsc_0_7_i_qa_d_bfwt_31_0 <= vec_rsc_0_7_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_7_i_oswt, vec_rsc_0_7_i_oswt_1, vec_rsc_0_7_i_wea_d_core_psct,
      vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_7_i_biwt, vec_rsc_0_7_i_bdwt, vec_rsc_0_7_i_biwt_1, vec_rsc_0_7_i_bdwt_2,
      vec_rsc_0_7_i_wea_d_core_sct, vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_7_i_oswt_pff,
      vec_rsc_0_7_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_7_i_oswt;
  input vec_rsc_0_7_i_oswt_1;
  input [1:0] vec_rsc_0_7_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_7_i_biwt;
  output vec_rsc_0_7_i_bdwt;
  output vec_rsc_0_7_i_biwt_1;
  output vec_rsc_0_7_i_bdwt_2;
  output [1:0] vec_rsc_0_7_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_7_i_oswt_pff;
  input vec_rsc_0_7_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_7_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_85_nl;
  wire[0:0] VEC_LOOP_and_89_nl;
  wire[0:0] VEC_LOOP_and_87_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_7_i_bdwt = vec_rsc_0_7_i_oswt & core_wen;
  assign vec_rsc_0_7_i_biwt = (~ core_wten) & vec_rsc_0_7_i_oswt;
  assign vec_rsc_0_7_i_bdwt_2 = vec_rsc_0_7_i_oswt_1 & core_wen;
  assign vec_rsc_0_7_i_biwt_1 = (~ core_wten) & vec_rsc_0_7_i_oswt_1;
  assign VEC_LOOP_and_85_nl = (vec_rsc_0_7_i_wea_d_core_psct[0]) & vec_rsc_0_7_i_dswt_pff;
  assign vec_rsc_0_7_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_85_nl};
  assign vec_rsc_0_7_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_7_i_oswt_pff;
  assign VEC_LOOP_and_89_nl = (~ core_wten_pff) & vec_rsc_0_7_i_oswt_1_pff;
  assign vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_89_nl , vec_rsc_0_7_i_dswt_pff});
  assign VEC_LOOP_and_87_nl = (vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_7_i_dswt_pff;
  assign vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_87_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_dp (
  clk, rst, vec_rsc_0_6_i_da_d, vec_rsc_0_6_i_qa_d, vec_rsc_0_6_i_da_d_core, vec_rsc_0_6_i_qa_d_mxwt,
      vec_rsc_0_6_i_biwt, vec_rsc_0_6_i_bdwt, vec_rsc_0_6_i_biwt_1, vec_rsc_0_6_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_6_i_da_d;
  input [63:0] vec_rsc_0_6_i_qa_d;
  input [63:0] vec_rsc_0_6_i_da_d_core;
  output [63:0] vec_rsc_0_6_i_qa_d_mxwt;
  input vec_rsc_0_6_i_biwt;
  input vec_rsc_0_6_i_bdwt;
  input vec_rsc_0_6_i_biwt_1;
  input vec_rsc_0_6_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_6_i_bcwt;
  reg vec_rsc_0_6_i_bcwt_1;
  reg [31:0] vec_rsc_0_6_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_6_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_26_nl;
  wire[31:0] VEC_LOOP_mux_27_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_26_nl = MUX_v_32_2_2((vec_rsc_0_6_i_qa_d[63:32]), vec_rsc_0_6_i_qa_d_bfwt_63_32,
      vec_rsc_0_6_i_bcwt_1);
  assign VEC_LOOP_mux_27_nl = MUX_v_32_2_2((vec_rsc_0_6_i_qa_d[31:0]), vec_rsc_0_6_i_qa_d_bfwt_31_0,
      vec_rsc_0_6_i_bcwt);
  assign vec_rsc_0_6_i_qa_d_mxwt = {VEC_LOOP_mux_26_nl , VEC_LOOP_mux_27_nl};
  assign vec_rsc_0_6_i_da_d = vec_rsc_0_6_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_6_i_bcwt <= 1'b0;
      vec_rsc_0_6_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_6_i_bcwt <= ~((~(vec_rsc_0_6_i_bcwt | vec_rsc_0_6_i_biwt)) | vec_rsc_0_6_i_bdwt);
      vec_rsc_0_6_i_bcwt_1 <= ~((~(vec_rsc_0_6_i_bcwt_1 | vec_rsc_0_6_i_biwt_1))
          | vec_rsc_0_6_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_6_i_biwt_1 ) begin
      vec_rsc_0_6_i_qa_d_bfwt_63_32 <= vec_rsc_0_6_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_6_i_biwt ) begin
      vec_rsc_0_6_i_qa_d_bfwt_31_0 <= vec_rsc_0_6_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_6_i_oswt, vec_rsc_0_6_i_oswt_1, vec_rsc_0_6_i_wea_d_core_psct,
      vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_6_i_biwt, vec_rsc_0_6_i_bdwt, vec_rsc_0_6_i_biwt_1, vec_rsc_0_6_i_bdwt_2,
      vec_rsc_0_6_i_wea_d_core_sct, vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_6_i_oswt_pff,
      vec_rsc_0_6_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_6_i_oswt;
  input vec_rsc_0_6_i_oswt_1;
  input [1:0] vec_rsc_0_6_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_6_i_biwt;
  output vec_rsc_0_6_i_bdwt;
  output vec_rsc_0_6_i_biwt_1;
  output vec_rsc_0_6_i_bdwt_2;
  output [1:0] vec_rsc_0_6_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_6_i_oswt_pff;
  input vec_rsc_0_6_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_6_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_74_nl;
  wire[0:0] VEC_LOOP_and_78_nl;
  wire[0:0] VEC_LOOP_and_76_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_6_i_bdwt = vec_rsc_0_6_i_oswt & core_wen;
  assign vec_rsc_0_6_i_biwt = (~ core_wten) & vec_rsc_0_6_i_oswt;
  assign vec_rsc_0_6_i_bdwt_2 = vec_rsc_0_6_i_oswt_1 & core_wen;
  assign vec_rsc_0_6_i_biwt_1 = (~ core_wten) & vec_rsc_0_6_i_oswt_1;
  assign VEC_LOOP_and_74_nl = (vec_rsc_0_6_i_wea_d_core_psct[0]) & vec_rsc_0_6_i_dswt_pff;
  assign vec_rsc_0_6_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_74_nl};
  assign vec_rsc_0_6_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_6_i_oswt_pff;
  assign VEC_LOOP_and_78_nl = (~ core_wten_pff) & vec_rsc_0_6_i_oswt_1_pff;
  assign vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_78_nl , vec_rsc_0_6_i_dswt_pff});
  assign VEC_LOOP_and_76_nl = (vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_6_i_dswt_pff;
  assign vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_76_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_dp (
  clk, rst, vec_rsc_0_5_i_da_d, vec_rsc_0_5_i_qa_d, vec_rsc_0_5_i_da_d_core, vec_rsc_0_5_i_qa_d_mxwt,
      vec_rsc_0_5_i_biwt, vec_rsc_0_5_i_bdwt, vec_rsc_0_5_i_biwt_1, vec_rsc_0_5_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_5_i_da_d;
  input [63:0] vec_rsc_0_5_i_qa_d;
  input [63:0] vec_rsc_0_5_i_da_d_core;
  output [63:0] vec_rsc_0_5_i_qa_d_mxwt;
  input vec_rsc_0_5_i_biwt;
  input vec_rsc_0_5_i_bdwt;
  input vec_rsc_0_5_i_biwt_1;
  input vec_rsc_0_5_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_5_i_bcwt;
  reg vec_rsc_0_5_i_bcwt_1;
  reg [31:0] vec_rsc_0_5_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_5_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_22_nl;
  wire[31:0] VEC_LOOP_mux_23_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_22_nl = MUX_v_32_2_2((vec_rsc_0_5_i_qa_d[63:32]), vec_rsc_0_5_i_qa_d_bfwt_63_32,
      vec_rsc_0_5_i_bcwt_1);
  assign VEC_LOOP_mux_23_nl = MUX_v_32_2_2((vec_rsc_0_5_i_qa_d[31:0]), vec_rsc_0_5_i_qa_d_bfwt_31_0,
      vec_rsc_0_5_i_bcwt);
  assign vec_rsc_0_5_i_qa_d_mxwt = {VEC_LOOP_mux_22_nl , VEC_LOOP_mux_23_nl};
  assign vec_rsc_0_5_i_da_d = vec_rsc_0_5_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_5_i_bcwt <= 1'b0;
      vec_rsc_0_5_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_5_i_bcwt <= ~((~(vec_rsc_0_5_i_bcwt | vec_rsc_0_5_i_biwt)) | vec_rsc_0_5_i_bdwt);
      vec_rsc_0_5_i_bcwt_1 <= ~((~(vec_rsc_0_5_i_bcwt_1 | vec_rsc_0_5_i_biwt_1))
          | vec_rsc_0_5_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_5_i_biwt_1 ) begin
      vec_rsc_0_5_i_qa_d_bfwt_63_32 <= vec_rsc_0_5_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_5_i_biwt ) begin
      vec_rsc_0_5_i_qa_d_bfwt_31_0 <= vec_rsc_0_5_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_5_i_oswt, vec_rsc_0_5_i_oswt_1, vec_rsc_0_5_i_wea_d_core_psct,
      vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_5_i_biwt, vec_rsc_0_5_i_bdwt, vec_rsc_0_5_i_biwt_1, vec_rsc_0_5_i_bdwt_2,
      vec_rsc_0_5_i_wea_d_core_sct, vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_5_i_oswt_pff,
      vec_rsc_0_5_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_5_i_oswt;
  input vec_rsc_0_5_i_oswt_1;
  input [1:0] vec_rsc_0_5_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_5_i_biwt;
  output vec_rsc_0_5_i_bdwt;
  output vec_rsc_0_5_i_biwt_1;
  output vec_rsc_0_5_i_bdwt_2;
  output [1:0] vec_rsc_0_5_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_5_i_oswt_pff;
  input vec_rsc_0_5_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_5_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_63_nl;
  wire[0:0] VEC_LOOP_and_67_nl;
  wire[0:0] VEC_LOOP_and_65_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_5_i_bdwt = vec_rsc_0_5_i_oswt & core_wen;
  assign vec_rsc_0_5_i_biwt = (~ core_wten) & vec_rsc_0_5_i_oswt;
  assign vec_rsc_0_5_i_bdwt_2 = vec_rsc_0_5_i_oswt_1 & core_wen;
  assign vec_rsc_0_5_i_biwt_1 = (~ core_wten) & vec_rsc_0_5_i_oswt_1;
  assign VEC_LOOP_and_63_nl = (vec_rsc_0_5_i_wea_d_core_psct[0]) & vec_rsc_0_5_i_dswt_pff;
  assign vec_rsc_0_5_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_63_nl};
  assign vec_rsc_0_5_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_5_i_oswt_pff;
  assign VEC_LOOP_and_67_nl = (~ core_wten_pff) & vec_rsc_0_5_i_oswt_1_pff;
  assign vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_67_nl , vec_rsc_0_5_i_dswt_pff});
  assign VEC_LOOP_and_65_nl = (vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_5_i_dswt_pff;
  assign vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_65_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_dp (
  clk, rst, vec_rsc_0_4_i_da_d, vec_rsc_0_4_i_qa_d, vec_rsc_0_4_i_da_d_core, vec_rsc_0_4_i_qa_d_mxwt,
      vec_rsc_0_4_i_biwt, vec_rsc_0_4_i_bdwt, vec_rsc_0_4_i_biwt_1, vec_rsc_0_4_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_4_i_da_d;
  input [63:0] vec_rsc_0_4_i_qa_d;
  input [63:0] vec_rsc_0_4_i_da_d_core;
  output [63:0] vec_rsc_0_4_i_qa_d_mxwt;
  input vec_rsc_0_4_i_biwt;
  input vec_rsc_0_4_i_bdwt;
  input vec_rsc_0_4_i_biwt_1;
  input vec_rsc_0_4_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_4_i_bcwt;
  reg vec_rsc_0_4_i_bcwt_1;
  reg [31:0] vec_rsc_0_4_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_4_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_18_nl;
  wire[31:0] VEC_LOOP_mux_19_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_18_nl = MUX_v_32_2_2((vec_rsc_0_4_i_qa_d[63:32]), vec_rsc_0_4_i_qa_d_bfwt_63_32,
      vec_rsc_0_4_i_bcwt_1);
  assign VEC_LOOP_mux_19_nl = MUX_v_32_2_2((vec_rsc_0_4_i_qa_d[31:0]), vec_rsc_0_4_i_qa_d_bfwt_31_0,
      vec_rsc_0_4_i_bcwt);
  assign vec_rsc_0_4_i_qa_d_mxwt = {VEC_LOOP_mux_18_nl , VEC_LOOP_mux_19_nl};
  assign vec_rsc_0_4_i_da_d = vec_rsc_0_4_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_4_i_bcwt <= 1'b0;
      vec_rsc_0_4_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_4_i_bcwt <= ~((~(vec_rsc_0_4_i_bcwt | vec_rsc_0_4_i_biwt)) | vec_rsc_0_4_i_bdwt);
      vec_rsc_0_4_i_bcwt_1 <= ~((~(vec_rsc_0_4_i_bcwt_1 | vec_rsc_0_4_i_biwt_1))
          | vec_rsc_0_4_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_4_i_biwt_1 ) begin
      vec_rsc_0_4_i_qa_d_bfwt_63_32 <= vec_rsc_0_4_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_4_i_biwt ) begin
      vec_rsc_0_4_i_qa_d_bfwt_31_0 <= vec_rsc_0_4_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_4_i_oswt, vec_rsc_0_4_i_oswt_1, vec_rsc_0_4_i_wea_d_core_psct,
      vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_4_i_biwt, vec_rsc_0_4_i_bdwt, vec_rsc_0_4_i_biwt_1, vec_rsc_0_4_i_bdwt_2,
      vec_rsc_0_4_i_wea_d_core_sct, vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_4_i_oswt_pff,
      vec_rsc_0_4_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_4_i_oswt;
  input vec_rsc_0_4_i_oswt_1;
  input [1:0] vec_rsc_0_4_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_4_i_biwt;
  output vec_rsc_0_4_i_bdwt;
  output vec_rsc_0_4_i_biwt_1;
  output vec_rsc_0_4_i_bdwt_2;
  output [1:0] vec_rsc_0_4_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_4_i_oswt_pff;
  input vec_rsc_0_4_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_4_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_52_nl;
  wire[0:0] VEC_LOOP_and_56_nl;
  wire[0:0] VEC_LOOP_and_54_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_4_i_bdwt = vec_rsc_0_4_i_oswt & core_wen;
  assign vec_rsc_0_4_i_biwt = (~ core_wten) & vec_rsc_0_4_i_oswt;
  assign vec_rsc_0_4_i_bdwt_2 = vec_rsc_0_4_i_oswt_1 & core_wen;
  assign vec_rsc_0_4_i_biwt_1 = (~ core_wten) & vec_rsc_0_4_i_oswt_1;
  assign VEC_LOOP_and_52_nl = (vec_rsc_0_4_i_wea_d_core_psct[0]) & vec_rsc_0_4_i_dswt_pff;
  assign vec_rsc_0_4_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_52_nl};
  assign vec_rsc_0_4_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_4_i_oswt_pff;
  assign VEC_LOOP_and_56_nl = (~ core_wten_pff) & vec_rsc_0_4_i_oswt_1_pff;
  assign vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_56_nl , vec_rsc_0_4_i_dswt_pff});
  assign VEC_LOOP_and_54_nl = (vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_4_i_dswt_pff;
  assign vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_54_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_dp (
  clk, rst, vec_rsc_0_3_i_da_d, vec_rsc_0_3_i_qa_d, vec_rsc_0_3_i_da_d_core, vec_rsc_0_3_i_qa_d_mxwt,
      vec_rsc_0_3_i_biwt, vec_rsc_0_3_i_bdwt, vec_rsc_0_3_i_biwt_1, vec_rsc_0_3_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_3_i_da_d;
  input [63:0] vec_rsc_0_3_i_qa_d;
  input [63:0] vec_rsc_0_3_i_da_d_core;
  output [63:0] vec_rsc_0_3_i_qa_d_mxwt;
  input vec_rsc_0_3_i_biwt;
  input vec_rsc_0_3_i_bdwt;
  input vec_rsc_0_3_i_biwt_1;
  input vec_rsc_0_3_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_3_i_bcwt;
  reg vec_rsc_0_3_i_bcwt_1;
  reg [31:0] vec_rsc_0_3_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_3_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_14_nl;
  wire[31:0] VEC_LOOP_mux_15_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_14_nl = MUX_v_32_2_2((vec_rsc_0_3_i_qa_d[63:32]), vec_rsc_0_3_i_qa_d_bfwt_63_32,
      vec_rsc_0_3_i_bcwt_1);
  assign VEC_LOOP_mux_15_nl = MUX_v_32_2_2((vec_rsc_0_3_i_qa_d[31:0]), vec_rsc_0_3_i_qa_d_bfwt_31_0,
      vec_rsc_0_3_i_bcwt);
  assign vec_rsc_0_3_i_qa_d_mxwt = {VEC_LOOP_mux_14_nl , VEC_LOOP_mux_15_nl};
  assign vec_rsc_0_3_i_da_d = vec_rsc_0_3_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_3_i_bcwt <= 1'b0;
      vec_rsc_0_3_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_3_i_bcwt <= ~((~(vec_rsc_0_3_i_bcwt | vec_rsc_0_3_i_biwt)) | vec_rsc_0_3_i_bdwt);
      vec_rsc_0_3_i_bcwt_1 <= ~((~(vec_rsc_0_3_i_bcwt_1 | vec_rsc_0_3_i_biwt_1))
          | vec_rsc_0_3_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_3_i_biwt_1 ) begin
      vec_rsc_0_3_i_qa_d_bfwt_63_32 <= vec_rsc_0_3_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_3_i_biwt ) begin
      vec_rsc_0_3_i_qa_d_bfwt_31_0 <= vec_rsc_0_3_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_3_i_oswt, vec_rsc_0_3_i_oswt_1, vec_rsc_0_3_i_wea_d_core_psct,
      vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_3_i_biwt, vec_rsc_0_3_i_bdwt, vec_rsc_0_3_i_biwt_1, vec_rsc_0_3_i_bdwt_2,
      vec_rsc_0_3_i_wea_d_core_sct, vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_3_i_oswt_pff,
      vec_rsc_0_3_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_3_i_oswt;
  input vec_rsc_0_3_i_oswt_1;
  input [1:0] vec_rsc_0_3_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_3_i_biwt;
  output vec_rsc_0_3_i_bdwt;
  output vec_rsc_0_3_i_biwt_1;
  output vec_rsc_0_3_i_bdwt_2;
  output [1:0] vec_rsc_0_3_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_3_i_oswt_pff;
  input vec_rsc_0_3_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_3_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_41_nl;
  wire[0:0] VEC_LOOP_and_45_nl;
  wire[0:0] VEC_LOOP_and_43_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_3_i_bdwt = vec_rsc_0_3_i_oswt & core_wen;
  assign vec_rsc_0_3_i_biwt = (~ core_wten) & vec_rsc_0_3_i_oswt;
  assign vec_rsc_0_3_i_bdwt_2 = vec_rsc_0_3_i_oswt_1 & core_wen;
  assign vec_rsc_0_3_i_biwt_1 = (~ core_wten) & vec_rsc_0_3_i_oswt_1;
  assign VEC_LOOP_and_41_nl = (vec_rsc_0_3_i_wea_d_core_psct[0]) & vec_rsc_0_3_i_dswt_pff;
  assign vec_rsc_0_3_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_41_nl};
  assign vec_rsc_0_3_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_3_i_oswt_pff;
  assign VEC_LOOP_and_45_nl = (~ core_wten_pff) & vec_rsc_0_3_i_oswt_1_pff;
  assign vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_45_nl , vec_rsc_0_3_i_dswt_pff});
  assign VEC_LOOP_and_43_nl = (vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_3_i_dswt_pff;
  assign vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_43_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_dp (
  clk, rst, vec_rsc_0_2_i_da_d, vec_rsc_0_2_i_qa_d, vec_rsc_0_2_i_da_d_core, vec_rsc_0_2_i_qa_d_mxwt,
      vec_rsc_0_2_i_biwt, vec_rsc_0_2_i_bdwt, vec_rsc_0_2_i_biwt_1, vec_rsc_0_2_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_2_i_da_d;
  input [63:0] vec_rsc_0_2_i_qa_d;
  input [63:0] vec_rsc_0_2_i_da_d_core;
  output [63:0] vec_rsc_0_2_i_qa_d_mxwt;
  input vec_rsc_0_2_i_biwt;
  input vec_rsc_0_2_i_bdwt;
  input vec_rsc_0_2_i_biwt_1;
  input vec_rsc_0_2_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_2_i_bcwt;
  reg vec_rsc_0_2_i_bcwt_1;
  reg [31:0] vec_rsc_0_2_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_2_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_10_nl;
  wire[31:0] VEC_LOOP_mux_11_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_10_nl = MUX_v_32_2_2((vec_rsc_0_2_i_qa_d[63:32]), vec_rsc_0_2_i_qa_d_bfwt_63_32,
      vec_rsc_0_2_i_bcwt_1);
  assign VEC_LOOP_mux_11_nl = MUX_v_32_2_2((vec_rsc_0_2_i_qa_d[31:0]), vec_rsc_0_2_i_qa_d_bfwt_31_0,
      vec_rsc_0_2_i_bcwt);
  assign vec_rsc_0_2_i_qa_d_mxwt = {VEC_LOOP_mux_10_nl , VEC_LOOP_mux_11_nl};
  assign vec_rsc_0_2_i_da_d = vec_rsc_0_2_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_2_i_bcwt <= 1'b0;
      vec_rsc_0_2_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_2_i_bcwt <= ~((~(vec_rsc_0_2_i_bcwt | vec_rsc_0_2_i_biwt)) | vec_rsc_0_2_i_bdwt);
      vec_rsc_0_2_i_bcwt_1 <= ~((~(vec_rsc_0_2_i_bcwt_1 | vec_rsc_0_2_i_biwt_1))
          | vec_rsc_0_2_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_2_i_biwt_1 ) begin
      vec_rsc_0_2_i_qa_d_bfwt_63_32 <= vec_rsc_0_2_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_2_i_biwt ) begin
      vec_rsc_0_2_i_qa_d_bfwt_31_0 <= vec_rsc_0_2_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_2_i_oswt, vec_rsc_0_2_i_oswt_1, vec_rsc_0_2_i_wea_d_core_psct,
      vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_2_i_biwt, vec_rsc_0_2_i_bdwt, vec_rsc_0_2_i_biwt_1, vec_rsc_0_2_i_bdwt_2,
      vec_rsc_0_2_i_wea_d_core_sct, vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_2_i_oswt_pff,
      vec_rsc_0_2_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_2_i_oswt;
  input vec_rsc_0_2_i_oswt_1;
  input [1:0] vec_rsc_0_2_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_2_i_biwt;
  output vec_rsc_0_2_i_bdwt;
  output vec_rsc_0_2_i_biwt_1;
  output vec_rsc_0_2_i_bdwt_2;
  output [1:0] vec_rsc_0_2_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_2_i_oswt_pff;
  input vec_rsc_0_2_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_2_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_30_nl;
  wire[0:0] VEC_LOOP_and_34_nl;
  wire[0:0] VEC_LOOP_and_32_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_2_i_bdwt = vec_rsc_0_2_i_oswt & core_wen;
  assign vec_rsc_0_2_i_biwt = (~ core_wten) & vec_rsc_0_2_i_oswt;
  assign vec_rsc_0_2_i_bdwt_2 = vec_rsc_0_2_i_oswt_1 & core_wen;
  assign vec_rsc_0_2_i_biwt_1 = (~ core_wten) & vec_rsc_0_2_i_oswt_1;
  assign VEC_LOOP_and_30_nl = (vec_rsc_0_2_i_wea_d_core_psct[0]) & vec_rsc_0_2_i_dswt_pff;
  assign vec_rsc_0_2_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_30_nl};
  assign vec_rsc_0_2_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_2_i_oswt_pff;
  assign VEC_LOOP_and_34_nl = (~ core_wten_pff) & vec_rsc_0_2_i_oswt_1_pff;
  assign vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_34_nl , vec_rsc_0_2_i_dswt_pff});
  assign VEC_LOOP_and_32_nl = (vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_2_i_dswt_pff;
  assign vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_32_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_dp (
  clk, rst, vec_rsc_0_1_i_da_d, vec_rsc_0_1_i_qa_d, vec_rsc_0_1_i_da_d_core, vec_rsc_0_1_i_qa_d_mxwt,
      vec_rsc_0_1_i_biwt, vec_rsc_0_1_i_bdwt, vec_rsc_0_1_i_biwt_1, vec_rsc_0_1_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_1_i_da_d;
  input [63:0] vec_rsc_0_1_i_qa_d;
  input [63:0] vec_rsc_0_1_i_da_d_core;
  output [63:0] vec_rsc_0_1_i_qa_d_mxwt;
  input vec_rsc_0_1_i_biwt;
  input vec_rsc_0_1_i_bdwt;
  input vec_rsc_0_1_i_biwt_1;
  input vec_rsc_0_1_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_1_i_bcwt;
  reg vec_rsc_0_1_i_bcwt_1;
  reg [31:0] vec_rsc_0_1_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_1_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_6_nl;
  wire[31:0] VEC_LOOP_mux_7_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_6_nl = MUX_v_32_2_2((vec_rsc_0_1_i_qa_d[63:32]), vec_rsc_0_1_i_qa_d_bfwt_63_32,
      vec_rsc_0_1_i_bcwt_1);
  assign VEC_LOOP_mux_7_nl = MUX_v_32_2_2((vec_rsc_0_1_i_qa_d[31:0]), vec_rsc_0_1_i_qa_d_bfwt_31_0,
      vec_rsc_0_1_i_bcwt);
  assign vec_rsc_0_1_i_qa_d_mxwt = {VEC_LOOP_mux_6_nl , VEC_LOOP_mux_7_nl};
  assign vec_rsc_0_1_i_da_d = vec_rsc_0_1_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_1_i_bcwt <= 1'b0;
      vec_rsc_0_1_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_1_i_bcwt <= ~((~(vec_rsc_0_1_i_bcwt | vec_rsc_0_1_i_biwt)) | vec_rsc_0_1_i_bdwt);
      vec_rsc_0_1_i_bcwt_1 <= ~((~(vec_rsc_0_1_i_bcwt_1 | vec_rsc_0_1_i_biwt_1))
          | vec_rsc_0_1_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_1_i_biwt_1 ) begin
      vec_rsc_0_1_i_qa_d_bfwt_63_32 <= vec_rsc_0_1_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_1_i_biwt ) begin
      vec_rsc_0_1_i_qa_d_bfwt_31_0 <= vec_rsc_0_1_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_1_i_oswt, vec_rsc_0_1_i_oswt_1, vec_rsc_0_1_i_wea_d_core_psct,
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_1_i_biwt, vec_rsc_0_1_i_bdwt, vec_rsc_0_1_i_biwt_1, vec_rsc_0_1_i_bdwt_2,
      vec_rsc_0_1_i_wea_d_core_sct, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_1_i_oswt_pff,
      vec_rsc_0_1_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_1_i_oswt;
  input vec_rsc_0_1_i_oswt_1;
  input [1:0] vec_rsc_0_1_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_1_i_biwt;
  output vec_rsc_0_1_i_bdwt;
  output vec_rsc_0_1_i_biwt_1;
  output vec_rsc_0_1_i_bdwt_2;
  output [1:0] vec_rsc_0_1_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_1_i_oswt_pff;
  input vec_rsc_0_1_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_1_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_19_nl;
  wire[0:0] VEC_LOOP_and_23_nl;
  wire[0:0] VEC_LOOP_and_21_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_1_i_bdwt = vec_rsc_0_1_i_oswt & core_wen;
  assign vec_rsc_0_1_i_biwt = (~ core_wten) & vec_rsc_0_1_i_oswt;
  assign vec_rsc_0_1_i_bdwt_2 = vec_rsc_0_1_i_oswt_1 & core_wen;
  assign vec_rsc_0_1_i_biwt_1 = (~ core_wten) & vec_rsc_0_1_i_oswt_1;
  assign VEC_LOOP_and_19_nl = (vec_rsc_0_1_i_wea_d_core_psct[0]) & vec_rsc_0_1_i_dswt_pff;
  assign vec_rsc_0_1_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_19_nl};
  assign vec_rsc_0_1_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_1_i_oswt_pff;
  assign VEC_LOOP_and_23_nl = (~ core_wten_pff) & vec_rsc_0_1_i_oswt_1_pff;
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_23_nl , vec_rsc_0_1_i_dswt_pff});
  assign VEC_LOOP_and_21_nl = (vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_1_i_dswt_pff;
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_21_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_wait_dp (
  ensig_cgo_iro, ensig_cgo_iro_1, core_wen, ensig_cgo, mult_cmp_ccs_ccore_en, ensig_cgo_1,
      modulo_sub_cmp_ccs_ccore_en
);
  input ensig_cgo_iro;
  input ensig_cgo_iro_1;
  input core_wen;
  input ensig_cgo;
  output mult_cmp_ccs_ccore_en;
  input ensig_cgo_1;
  output modulo_sub_cmp_ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  assign mult_cmp_ccs_ccore_en = core_wen & (ensig_cgo | ensig_cgo_iro);
  assign modulo_sub_cmp_ccs_ccore_en = core_wen & (ensig_cgo_1 | ensig_cgo_iro_1);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_dp (
  clk, rst, vec_rsc_0_0_i_da_d, vec_rsc_0_0_i_qa_d, vec_rsc_0_0_i_da_d_core, vec_rsc_0_0_i_qa_d_mxwt,
      vec_rsc_0_0_i_biwt, vec_rsc_0_0_i_bdwt, vec_rsc_0_0_i_biwt_1, vec_rsc_0_0_i_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_0_i_da_d;
  input [63:0] vec_rsc_0_0_i_qa_d;
  input [63:0] vec_rsc_0_0_i_da_d_core;
  output [63:0] vec_rsc_0_0_i_qa_d_mxwt;
  input vec_rsc_0_0_i_biwt;
  input vec_rsc_0_0_i_bdwt;
  input vec_rsc_0_0_i_biwt_1;
  input vec_rsc_0_0_i_bdwt_2;


  // Interconnect Declarations
  reg vec_rsc_0_0_i_bcwt;
  reg vec_rsc_0_0_i_bcwt_1;
  reg [31:0] vec_rsc_0_0_i_qa_d_bfwt_63_32;
  reg [31:0] vec_rsc_0_0_i_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_2_nl;
  wire[31:0] VEC_LOOP_mux_3_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_2_nl = MUX_v_32_2_2((vec_rsc_0_0_i_qa_d[63:32]), vec_rsc_0_0_i_qa_d_bfwt_63_32,
      vec_rsc_0_0_i_bcwt_1);
  assign VEC_LOOP_mux_3_nl = MUX_v_32_2_2((vec_rsc_0_0_i_qa_d[31:0]), vec_rsc_0_0_i_qa_d_bfwt_31_0,
      vec_rsc_0_0_i_bcwt);
  assign vec_rsc_0_0_i_qa_d_mxwt = {VEC_LOOP_mux_2_nl , VEC_LOOP_mux_3_nl};
  assign vec_rsc_0_0_i_da_d = vec_rsc_0_0_i_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsc_0_0_i_bcwt <= 1'b0;
      vec_rsc_0_0_i_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsc_0_0_i_bcwt <= ~((~(vec_rsc_0_0_i_bcwt | vec_rsc_0_0_i_biwt)) | vec_rsc_0_0_i_bdwt);
      vec_rsc_0_0_i_bcwt_1 <= ~((~(vec_rsc_0_0_i_bcwt_1 | vec_rsc_0_0_i_biwt_1))
          | vec_rsc_0_0_i_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_0_i_biwt_1 ) begin
      vec_rsc_0_0_i_qa_d_bfwt_63_32 <= vec_rsc_0_0_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsc_0_0_i_biwt ) begin
      vec_rsc_0_0_i_qa_d_bfwt_31_0 <= vec_rsc_0_0_i_qa_d[31:0];
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl (
  core_wen, core_wten, vec_rsc_0_0_i_oswt, vec_rsc_0_0_i_oswt_1, vec_rsc_0_0_i_wea_d_core_psct,
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsc_0_0_i_biwt, vec_rsc_0_0_i_bdwt, vec_rsc_0_0_i_biwt_1, vec_rsc_0_0_i_bdwt_2,
      vec_rsc_0_0_i_wea_d_core_sct, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct, core_wten_pff, vec_rsc_0_0_i_oswt_pff,
      vec_rsc_0_0_i_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsc_0_0_i_oswt;
  input vec_rsc_0_0_i_oswt_1;
  input [1:0] vec_rsc_0_0_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsc_0_0_i_biwt;
  output vec_rsc_0_0_i_bdwt;
  output vec_rsc_0_0_i_biwt_1;
  output vec_rsc_0_0_i_bdwt_2;
  output [1:0] vec_rsc_0_0_i_wea_d_core_sct;
  output [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsc_0_0_i_oswt_pff;
  input vec_rsc_0_0_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_0_i_dswt_pff;

  wire[0:0] VEC_LOOP_and_8_nl;
  wire[0:0] VEC_LOOP_and_12_nl;
  wire[0:0] VEC_LOOP_and_10_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_0_0_i_bdwt = vec_rsc_0_0_i_oswt & core_wen;
  assign vec_rsc_0_0_i_biwt = (~ core_wten) & vec_rsc_0_0_i_oswt;
  assign vec_rsc_0_0_i_bdwt_2 = vec_rsc_0_0_i_oswt_1 & core_wen;
  assign vec_rsc_0_0_i_biwt_1 = (~ core_wten) & vec_rsc_0_0_i_oswt_1;
  assign VEC_LOOP_and_8_nl = (vec_rsc_0_0_i_wea_d_core_psct[0]) & vec_rsc_0_0_i_dswt_pff;
  assign vec_rsc_0_0_i_wea_d_core_sct = {1'b0 , VEC_LOOP_and_8_nl};
  assign vec_rsc_0_0_i_dswt_pff = (~ core_wten_pff) & vec_rsc_0_0_i_oswt_pff;
  assign VEC_LOOP_and_12_nl = (~ core_wten_pff) & vec_rsc_0_0_i_oswt_1_pff;
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_12_nl , vec_rsc_0_0_i_dswt_pff});
  assign VEC_LOOP_and_10_nl = (vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsc_0_0_i_dswt_pff;
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_10_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_dp (
  clk, rst, complete_rsci_oswt, complete_rsci_wen_comp, complete_rsci_biwt, complete_rsci_bdwt,
      complete_rsci_bcwt
);
  input clk;
  input rst;
  input complete_rsci_oswt;
  output complete_rsci_wen_comp;
  input complete_rsci_biwt;
  input complete_rsci_bdwt;
  output complete_rsci_bcwt;
  reg complete_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign complete_rsci_wen_comp = (~ complete_rsci_oswt) | complete_rsci_biwt | complete_rsci_bcwt;
  always @(posedge clk) begin
    if ( rst ) begin
      complete_rsci_bcwt <= 1'b0;
    end
    else begin
      complete_rsci_bcwt <= ~((~(complete_rsci_bcwt | complete_rsci_biwt)) | complete_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_ctrl (
  core_wen, complete_rsci_oswt, complete_rsci_biwt, complete_rsci_bdwt, complete_rsci_bcwt,
      complete_rsci_ivld_core_sct, complete_rsci_irdy
);
  input core_wen;
  input complete_rsci_oswt;
  output complete_rsci_biwt;
  output complete_rsci_bdwt;
  input complete_rsci_bcwt;
  output complete_rsci_ivld_core_sct;
  input complete_rsci_irdy;


  // Interconnect Declarations
  wire complete_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign complete_rsci_bdwt = complete_rsci_oswt & core_wen;
  assign complete_rsci_biwt = complete_rsci_ogwt & complete_rsci_irdy;
  assign complete_rsci_ogwt = complete_rsci_oswt & (~ complete_rsci_bcwt);
  assign complete_rsci_ivld_core_sct = complete_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_dp (
  clk, rst, run_rsci_ivld_mxwt, run_rsci_ivld, run_rsci_biwt, run_rsci_bdwt
);
  input clk;
  input rst;
  output run_rsci_ivld_mxwt;
  input run_rsci_ivld;
  input run_rsci_biwt;
  input run_rsci_bdwt;


  // Interconnect Declarations
  reg run_rsci_bcwt;
  reg run_rsci_ivld_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign run_rsci_ivld_mxwt = MUX_s_1_2_2(run_rsci_ivld, run_rsci_ivld_bfwt, run_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      run_rsci_bcwt <= 1'b0;
    end
    else begin
      run_rsci_bcwt <= ~((~(run_rsci_bcwt | run_rsci_biwt)) | run_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( run_rsci_biwt ) begin
      run_rsci_ivld_bfwt <= run_rsci_ivld;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_ctrl (
  core_wen, run_rsci_oswt, core_wten, run_rsci_biwt, run_rsci_bdwt
);
  input core_wen;
  input run_rsci_oswt;
  input core_wten;
  output run_rsci_biwt;
  output run_rsci_bdwt;



  // Interconnect Declarations for Component Instantiations 
  assign run_rsci_bdwt = run_rsci_oswt & core_wen;
  assign run_rsci_biwt = (~ core_wten) & run_rsci_oswt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj (
  twiddle_h_rsc_triosy_0_0_lz, core_wten, twiddle_h_rsc_triosy_0_0_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_0_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_0_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_0_obj (
      .ld(twiddle_h_rsc_triosy_0_0_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_0_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj_twiddle_h_rsc_triosy_0_0_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj_twiddle_h_rsc_triosy_0_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_0_obj_iswt0(twiddle_h_rsc_triosy_0_0_obj_iswt0),
      .twiddle_h_rsc_triosy_0_0_obj_ld_core_sct(twiddle_h_rsc_triosy_0_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj (
  twiddle_h_rsc_triosy_0_1_lz, core_wten, twiddle_h_rsc_triosy_0_1_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_1_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_1_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_1_obj (
      .ld(twiddle_h_rsc_triosy_0_1_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_1_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj_twiddle_h_rsc_triosy_0_1_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj_twiddle_h_rsc_triosy_0_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_1_obj_iswt0(twiddle_h_rsc_triosy_0_1_obj_iswt0),
      .twiddle_h_rsc_triosy_0_1_obj_ld_core_sct(twiddle_h_rsc_triosy_0_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj (
  twiddle_h_rsc_triosy_0_2_lz, core_wten, twiddle_h_rsc_triosy_0_2_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_2_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_2_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_2_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_2_obj (
      .ld(twiddle_h_rsc_triosy_0_2_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_2_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj_twiddle_h_rsc_triosy_0_2_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj_twiddle_h_rsc_triosy_0_2_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_2_obj_iswt0(twiddle_h_rsc_triosy_0_2_obj_iswt0),
      .twiddle_h_rsc_triosy_0_2_obj_ld_core_sct(twiddle_h_rsc_triosy_0_2_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj (
  twiddle_h_rsc_triosy_0_3_lz, core_wten, twiddle_h_rsc_triosy_0_3_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_3_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_3_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_3_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_3_obj (
      .ld(twiddle_h_rsc_triosy_0_3_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_3_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj_twiddle_h_rsc_triosy_0_3_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj_twiddle_h_rsc_triosy_0_3_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_3_obj_iswt0(twiddle_h_rsc_triosy_0_3_obj_iswt0),
      .twiddle_h_rsc_triosy_0_3_obj_ld_core_sct(twiddle_h_rsc_triosy_0_3_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj (
  twiddle_h_rsc_triosy_0_4_lz, core_wten, twiddle_h_rsc_triosy_0_4_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_4_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_4_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_4_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_4_obj (
      .ld(twiddle_h_rsc_triosy_0_4_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_4_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj_twiddle_h_rsc_triosy_0_4_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj_twiddle_h_rsc_triosy_0_4_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_4_obj_iswt0(twiddle_h_rsc_triosy_0_4_obj_iswt0),
      .twiddle_h_rsc_triosy_0_4_obj_ld_core_sct(twiddle_h_rsc_triosy_0_4_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj (
  twiddle_h_rsc_triosy_0_5_lz, core_wten, twiddle_h_rsc_triosy_0_5_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_5_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_5_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_5_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_5_obj (
      .ld(twiddle_h_rsc_triosy_0_5_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_5_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj_twiddle_h_rsc_triosy_0_5_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj_twiddle_h_rsc_triosy_0_5_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_5_obj_iswt0(twiddle_h_rsc_triosy_0_5_obj_iswt0),
      .twiddle_h_rsc_triosy_0_5_obj_ld_core_sct(twiddle_h_rsc_triosy_0_5_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj (
  twiddle_h_rsc_triosy_0_6_lz, core_wten, twiddle_h_rsc_triosy_0_6_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_6_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_6_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_6_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_6_obj (
      .ld(twiddle_h_rsc_triosy_0_6_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_6_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj_twiddle_h_rsc_triosy_0_6_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj_twiddle_h_rsc_triosy_0_6_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_6_obj_iswt0(twiddle_h_rsc_triosy_0_6_obj_iswt0),
      .twiddle_h_rsc_triosy_0_6_obj_ld_core_sct(twiddle_h_rsc_triosy_0_6_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj (
  twiddle_h_rsc_triosy_0_7_lz, core_wten, twiddle_h_rsc_triosy_0_7_obj_iswt0
);
  output twiddle_h_rsc_triosy_0_7_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_0_7_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_0_7_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_7_obj (
      .ld(twiddle_h_rsc_triosy_0_7_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_0_7_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj_twiddle_h_rsc_triosy_0_7_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj_twiddle_h_rsc_triosy_0_7_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_7_obj_iswt0(twiddle_h_rsc_triosy_0_7_obj_iswt0),
      .twiddle_h_rsc_triosy_0_7_obj_ld_core_sct(twiddle_h_rsc_triosy_0_7_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj (
  twiddle_h_rsc_triosy_1_0_lz, core_wten, twiddle_h_rsc_triosy_1_0_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_0_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_0_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_0_obj (
      .ld(twiddle_h_rsc_triosy_1_0_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_0_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj_twiddle_h_rsc_triosy_1_0_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj_twiddle_h_rsc_triosy_1_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_0_obj_iswt0(twiddle_h_rsc_triosy_1_0_obj_iswt0),
      .twiddle_h_rsc_triosy_1_0_obj_ld_core_sct(twiddle_h_rsc_triosy_1_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj (
  twiddle_h_rsc_triosy_1_1_lz, core_wten, twiddle_h_rsc_triosy_1_1_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_1_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_1_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_1_obj (
      .ld(twiddle_h_rsc_triosy_1_1_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_1_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj_twiddle_h_rsc_triosy_1_1_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj_twiddle_h_rsc_triosy_1_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_1_obj_iswt0(twiddle_h_rsc_triosy_1_1_obj_iswt0),
      .twiddle_h_rsc_triosy_1_1_obj_ld_core_sct(twiddle_h_rsc_triosy_1_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj (
  twiddle_h_rsc_triosy_1_2_lz, core_wten, twiddle_h_rsc_triosy_1_2_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_2_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_2_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_2_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_2_obj (
      .ld(twiddle_h_rsc_triosy_1_2_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_2_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj_twiddle_h_rsc_triosy_1_2_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj_twiddle_h_rsc_triosy_1_2_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_2_obj_iswt0(twiddle_h_rsc_triosy_1_2_obj_iswt0),
      .twiddle_h_rsc_triosy_1_2_obj_ld_core_sct(twiddle_h_rsc_triosy_1_2_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj (
  twiddle_h_rsc_triosy_1_3_lz, core_wten, twiddle_h_rsc_triosy_1_3_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_3_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_3_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_3_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_3_obj (
      .ld(twiddle_h_rsc_triosy_1_3_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_3_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj_twiddle_h_rsc_triosy_1_3_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj_twiddle_h_rsc_triosy_1_3_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_3_obj_iswt0(twiddle_h_rsc_triosy_1_3_obj_iswt0),
      .twiddle_h_rsc_triosy_1_3_obj_ld_core_sct(twiddle_h_rsc_triosy_1_3_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj (
  twiddle_h_rsc_triosy_1_4_lz, core_wten, twiddle_h_rsc_triosy_1_4_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_4_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_4_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_4_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_4_obj (
      .ld(twiddle_h_rsc_triosy_1_4_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_4_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj_twiddle_h_rsc_triosy_1_4_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj_twiddle_h_rsc_triosy_1_4_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_4_obj_iswt0(twiddle_h_rsc_triosy_1_4_obj_iswt0),
      .twiddle_h_rsc_triosy_1_4_obj_ld_core_sct(twiddle_h_rsc_triosy_1_4_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj (
  twiddle_h_rsc_triosy_1_5_lz, core_wten, twiddle_h_rsc_triosy_1_5_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_5_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_5_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_5_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_5_obj (
      .ld(twiddle_h_rsc_triosy_1_5_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_5_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj_twiddle_h_rsc_triosy_1_5_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj_twiddle_h_rsc_triosy_1_5_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_5_obj_iswt0(twiddle_h_rsc_triosy_1_5_obj_iswt0),
      .twiddle_h_rsc_triosy_1_5_obj_ld_core_sct(twiddle_h_rsc_triosy_1_5_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj (
  twiddle_h_rsc_triosy_1_6_lz, core_wten, twiddle_h_rsc_triosy_1_6_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_6_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_6_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_6_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_6_obj (
      .ld(twiddle_h_rsc_triosy_1_6_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_6_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj_twiddle_h_rsc_triosy_1_6_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj_twiddle_h_rsc_triosy_1_6_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_6_obj_iswt0(twiddle_h_rsc_triosy_1_6_obj_iswt0),
      .twiddle_h_rsc_triosy_1_6_obj_ld_core_sct(twiddle_h_rsc_triosy_1_6_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj (
  twiddle_h_rsc_triosy_1_7_lz, core_wten, twiddle_h_rsc_triosy_1_7_obj_iswt0
);
  output twiddle_h_rsc_triosy_1_7_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_1_7_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_1_7_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_1_7_obj (
      .ld(twiddle_h_rsc_triosy_1_7_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_1_7_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj_twiddle_h_rsc_triosy_1_7_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj_twiddle_h_rsc_triosy_1_7_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_7_obj_iswt0(twiddle_h_rsc_triosy_1_7_obj_iswt0),
      .twiddle_h_rsc_triosy_1_7_obj_ld_core_sct(twiddle_h_rsc_triosy_1_7_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj (
  twiddle_rsc_triosy_0_0_lz, core_wten, twiddle_rsc_triosy_0_0_obj_iswt0
);
  output twiddle_rsc_triosy_0_0_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_0_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_0_obj (
      .ld(twiddle_rsc_triosy_0_0_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_0_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj_twiddle_rsc_triosy_0_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_0_obj_iswt0(twiddle_rsc_triosy_0_0_obj_iswt0),
      .twiddle_rsc_triosy_0_0_obj_ld_core_sct(twiddle_rsc_triosy_0_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj (
  twiddle_rsc_triosy_0_1_lz, core_wten, twiddle_rsc_triosy_0_1_obj_iswt0
);
  output twiddle_rsc_triosy_0_1_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_1_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_1_obj (
      .ld(twiddle_rsc_triosy_0_1_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_1_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj_twiddle_rsc_triosy_0_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_1_obj_iswt0(twiddle_rsc_triosy_0_1_obj_iswt0),
      .twiddle_rsc_triosy_0_1_obj_ld_core_sct(twiddle_rsc_triosy_0_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj (
  twiddle_rsc_triosy_0_2_lz, core_wten, twiddle_rsc_triosy_0_2_obj_iswt0
);
  output twiddle_rsc_triosy_0_2_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_2_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_2_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_2_obj (
      .ld(twiddle_rsc_triosy_0_2_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_2_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj_twiddle_rsc_triosy_0_2_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj_twiddle_rsc_triosy_0_2_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_2_obj_iswt0(twiddle_rsc_triosy_0_2_obj_iswt0),
      .twiddle_rsc_triosy_0_2_obj_ld_core_sct(twiddle_rsc_triosy_0_2_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj (
  twiddle_rsc_triosy_0_3_lz, core_wten, twiddle_rsc_triosy_0_3_obj_iswt0
);
  output twiddle_rsc_triosy_0_3_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_3_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_3_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_3_obj (
      .ld(twiddle_rsc_triosy_0_3_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_3_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj_twiddle_rsc_triosy_0_3_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj_twiddle_rsc_triosy_0_3_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_3_obj_iswt0(twiddle_rsc_triosy_0_3_obj_iswt0),
      .twiddle_rsc_triosy_0_3_obj_ld_core_sct(twiddle_rsc_triosy_0_3_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj (
  twiddle_rsc_triosy_0_4_lz, core_wten, twiddle_rsc_triosy_0_4_obj_iswt0
);
  output twiddle_rsc_triosy_0_4_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_4_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_4_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_4_obj (
      .ld(twiddle_rsc_triosy_0_4_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_4_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj_twiddle_rsc_triosy_0_4_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj_twiddle_rsc_triosy_0_4_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_4_obj_iswt0(twiddle_rsc_triosy_0_4_obj_iswt0),
      .twiddle_rsc_triosy_0_4_obj_ld_core_sct(twiddle_rsc_triosy_0_4_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj (
  twiddle_rsc_triosy_0_5_lz, core_wten, twiddle_rsc_triosy_0_5_obj_iswt0
);
  output twiddle_rsc_triosy_0_5_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_5_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_5_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_5_obj (
      .ld(twiddle_rsc_triosy_0_5_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_5_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj_twiddle_rsc_triosy_0_5_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj_twiddle_rsc_triosy_0_5_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_5_obj_iswt0(twiddle_rsc_triosy_0_5_obj_iswt0),
      .twiddle_rsc_triosy_0_5_obj_ld_core_sct(twiddle_rsc_triosy_0_5_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj (
  twiddle_rsc_triosy_0_6_lz, core_wten, twiddle_rsc_triosy_0_6_obj_iswt0
);
  output twiddle_rsc_triosy_0_6_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_6_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_6_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_6_obj (
      .ld(twiddle_rsc_triosy_0_6_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_6_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj_twiddle_rsc_triosy_0_6_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj_twiddle_rsc_triosy_0_6_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_6_obj_iswt0(twiddle_rsc_triosy_0_6_obj_iswt0),
      .twiddle_rsc_triosy_0_6_obj_ld_core_sct(twiddle_rsc_triosy_0_6_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj (
  twiddle_rsc_triosy_0_7_lz, core_wten, twiddle_rsc_triosy_0_7_obj_iswt0
);
  output twiddle_rsc_triosy_0_7_lz;
  input core_wten;
  input twiddle_rsc_triosy_0_7_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_0_7_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_7_obj (
      .ld(twiddle_rsc_triosy_0_7_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_0_7_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj_twiddle_rsc_triosy_0_7_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj_twiddle_rsc_triosy_0_7_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_7_obj_iswt0(twiddle_rsc_triosy_0_7_obj_iswt0),
      .twiddle_rsc_triosy_0_7_obj_ld_core_sct(twiddle_rsc_triosy_0_7_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj (
  twiddle_rsc_triosy_1_0_lz, core_wten, twiddle_rsc_triosy_1_0_obj_iswt0
);
  output twiddle_rsc_triosy_1_0_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_0_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_0_obj (
      .ld(twiddle_rsc_triosy_1_0_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_0_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj_twiddle_rsc_triosy_1_0_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj_twiddle_rsc_triosy_1_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_0_obj_iswt0(twiddle_rsc_triosy_1_0_obj_iswt0),
      .twiddle_rsc_triosy_1_0_obj_ld_core_sct(twiddle_rsc_triosy_1_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj (
  twiddle_rsc_triosy_1_1_lz, core_wten, twiddle_rsc_triosy_1_1_obj_iswt0
);
  output twiddle_rsc_triosy_1_1_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_1_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_1_obj (
      .ld(twiddle_rsc_triosy_1_1_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_1_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj_twiddle_rsc_triosy_1_1_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj_twiddle_rsc_triosy_1_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_1_obj_iswt0(twiddle_rsc_triosy_1_1_obj_iswt0),
      .twiddle_rsc_triosy_1_1_obj_ld_core_sct(twiddle_rsc_triosy_1_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj (
  twiddle_rsc_triosy_1_2_lz, core_wten, twiddle_rsc_triosy_1_2_obj_iswt0
);
  output twiddle_rsc_triosy_1_2_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_2_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_2_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_2_obj (
      .ld(twiddle_rsc_triosy_1_2_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_2_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj_twiddle_rsc_triosy_1_2_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj_twiddle_rsc_triosy_1_2_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_2_obj_iswt0(twiddle_rsc_triosy_1_2_obj_iswt0),
      .twiddle_rsc_triosy_1_2_obj_ld_core_sct(twiddle_rsc_triosy_1_2_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj (
  twiddle_rsc_triosy_1_3_lz, core_wten, twiddle_rsc_triosy_1_3_obj_iswt0
);
  output twiddle_rsc_triosy_1_3_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_3_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_3_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_3_obj (
      .ld(twiddle_rsc_triosy_1_3_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_3_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj_twiddle_rsc_triosy_1_3_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj_twiddle_rsc_triosy_1_3_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_3_obj_iswt0(twiddle_rsc_triosy_1_3_obj_iswt0),
      .twiddle_rsc_triosy_1_3_obj_ld_core_sct(twiddle_rsc_triosy_1_3_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj (
  twiddle_rsc_triosy_1_4_lz, core_wten, twiddle_rsc_triosy_1_4_obj_iswt0
);
  output twiddle_rsc_triosy_1_4_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_4_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_4_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_4_obj (
      .ld(twiddle_rsc_triosy_1_4_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_4_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj_twiddle_rsc_triosy_1_4_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj_twiddle_rsc_triosy_1_4_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_4_obj_iswt0(twiddle_rsc_triosy_1_4_obj_iswt0),
      .twiddle_rsc_triosy_1_4_obj_ld_core_sct(twiddle_rsc_triosy_1_4_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj (
  twiddle_rsc_triosy_1_5_lz, core_wten, twiddle_rsc_triosy_1_5_obj_iswt0
);
  output twiddle_rsc_triosy_1_5_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_5_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_5_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_5_obj (
      .ld(twiddle_rsc_triosy_1_5_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_5_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj_twiddle_rsc_triosy_1_5_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj_twiddle_rsc_triosy_1_5_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_5_obj_iswt0(twiddle_rsc_triosy_1_5_obj_iswt0),
      .twiddle_rsc_triosy_1_5_obj_ld_core_sct(twiddle_rsc_triosy_1_5_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj (
  twiddle_rsc_triosy_1_6_lz, core_wten, twiddle_rsc_triosy_1_6_obj_iswt0
);
  output twiddle_rsc_triosy_1_6_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_6_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_6_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_6_obj (
      .ld(twiddle_rsc_triosy_1_6_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_6_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj_twiddle_rsc_triosy_1_6_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj_twiddle_rsc_triosy_1_6_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_6_obj_iswt0(twiddle_rsc_triosy_1_6_obj_iswt0),
      .twiddle_rsc_triosy_1_6_obj_ld_core_sct(twiddle_rsc_triosy_1_6_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj (
  twiddle_rsc_triosy_1_7_lz, core_wten, twiddle_rsc_triosy_1_7_obj_iswt0
);
  output twiddle_rsc_triosy_1_7_lz;
  input core_wten;
  input twiddle_rsc_triosy_1_7_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_1_7_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_1_7_obj (
      .ld(twiddle_rsc_triosy_1_7_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_1_7_lz)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj_twiddle_rsc_triosy_1_7_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj_twiddle_rsc_triosy_1_7_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_7_obj_iswt0(twiddle_rsc_triosy_1_7_obj_iswt0),
      .twiddle_rsc_triosy_1_7_obj_ld_core_sct(twiddle_rsc_triosy_1_7_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj (
  r_rsc_triosy_lz, core_wten, r_rsc_triosy_obj_iswt0
);
  output r_rsc_triosy_lz;
  input core_wten;
  input r_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire r_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(r_rsc_triosy_obj_ld_core_sct),
      .lz(r_rsc_triosy_lz)
    );
  inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .r_rsc_triosy_obj_iswt0(r_rsc_triosy_obj_iswt0),
      .r_rsc_triosy_obj_ld_core_sct(r_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj (
  p_rsc_triosy_lz, core_wten, p_rsc_triosy_obj_iswt0
);
  output p_rsc_triosy_lz;
  input core_wten;
  input p_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire p_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) p_rsc_triosy_obj (
      .ld(p_rsc_triosy_obj_ld_core_sct),
      .lz(p_rsc_triosy_lz)
    );
  inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .p_rsc_triosy_obj_iswt0(p_rsc_triosy_obj_iswt0),
      .p_rsc_triosy_obj_ld_core_sct(p_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj (
  vec_rsc_triosy_0_0_lz, core_wten, vec_rsc_triosy_0_0_obj_iswt0
);
  output vec_rsc_triosy_0_0_lz;
  input core_wten;
  input vec_rsc_triosy_0_0_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_0_obj (
      .ld(vec_rsc_triosy_0_0_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_0_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj_vec_rsc_triosy_0_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_0_obj_iswt0(vec_rsc_triosy_0_0_obj_iswt0),
      .vec_rsc_triosy_0_0_obj_ld_core_sct(vec_rsc_triosy_0_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj (
  vec_rsc_triosy_0_1_lz, core_wten, vec_rsc_triosy_0_1_obj_iswt0
);
  output vec_rsc_triosy_0_1_lz;
  input core_wten;
  input vec_rsc_triosy_0_1_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_1_obj (
      .ld(vec_rsc_triosy_0_1_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_1_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj_vec_rsc_triosy_0_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_1_obj_iswt0(vec_rsc_triosy_0_1_obj_iswt0),
      .vec_rsc_triosy_0_1_obj_ld_core_sct(vec_rsc_triosy_0_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj (
  vec_rsc_triosy_0_2_lz, core_wten, vec_rsc_triosy_0_2_obj_iswt0
);
  output vec_rsc_triosy_0_2_lz;
  input core_wten;
  input vec_rsc_triosy_0_2_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_2_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_2_obj (
      .ld(vec_rsc_triosy_0_2_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_2_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj_vec_rsc_triosy_0_2_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj_vec_rsc_triosy_0_2_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_2_obj_iswt0(vec_rsc_triosy_0_2_obj_iswt0),
      .vec_rsc_triosy_0_2_obj_ld_core_sct(vec_rsc_triosy_0_2_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj (
  vec_rsc_triosy_0_3_lz, core_wten, vec_rsc_triosy_0_3_obj_iswt0
);
  output vec_rsc_triosy_0_3_lz;
  input core_wten;
  input vec_rsc_triosy_0_3_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_3_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_3_obj (
      .ld(vec_rsc_triosy_0_3_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_3_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj_vec_rsc_triosy_0_3_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj_vec_rsc_triosy_0_3_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_3_obj_iswt0(vec_rsc_triosy_0_3_obj_iswt0),
      .vec_rsc_triosy_0_3_obj_ld_core_sct(vec_rsc_triosy_0_3_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj (
  vec_rsc_triosy_0_4_lz, core_wten, vec_rsc_triosy_0_4_obj_iswt0
);
  output vec_rsc_triosy_0_4_lz;
  input core_wten;
  input vec_rsc_triosy_0_4_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_4_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_4_obj (
      .ld(vec_rsc_triosy_0_4_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_4_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj_vec_rsc_triosy_0_4_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj_vec_rsc_triosy_0_4_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_4_obj_iswt0(vec_rsc_triosy_0_4_obj_iswt0),
      .vec_rsc_triosy_0_4_obj_ld_core_sct(vec_rsc_triosy_0_4_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj (
  vec_rsc_triosy_0_5_lz, core_wten, vec_rsc_triosy_0_5_obj_iswt0
);
  output vec_rsc_triosy_0_5_lz;
  input core_wten;
  input vec_rsc_triosy_0_5_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_5_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_5_obj (
      .ld(vec_rsc_triosy_0_5_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_5_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj_vec_rsc_triosy_0_5_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj_vec_rsc_triosy_0_5_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_5_obj_iswt0(vec_rsc_triosy_0_5_obj_iswt0),
      .vec_rsc_triosy_0_5_obj_ld_core_sct(vec_rsc_triosy_0_5_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj (
  vec_rsc_triosy_0_6_lz, core_wten, vec_rsc_triosy_0_6_obj_iswt0
);
  output vec_rsc_triosy_0_6_lz;
  input core_wten;
  input vec_rsc_triosy_0_6_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_6_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_6_obj (
      .ld(vec_rsc_triosy_0_6_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_6_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj_vec_rsc_triosy_0_6_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj_vec_rsc_triosy_0_6_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_6_obj_iswt0(vec_rsc_triosy_0_6_obj_iswt0),
      .vec_rsc_triosy_0_6_obj_ld_core_sct(vec_rsc_triosy_0_6_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj (
  vec_rsc_triosy_0_7_lz, core_wten, vec_rsc_triosy_0_7_obj_iswt0
);
  output vec_rsc_triosy_0_7_lz;
  input core_wten;
  input vec_rsc_triosy_0_7_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_0_7_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_7_obj (
      .ld(vec_rsc_triosy_0_7_obj_ld_core_sct),
      .lz(vec_rsc_triosy_0_7_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj_vec_rsc_triosy_0_7_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj_vec_rsc_triosy_0_7_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_0_7_obj_iswt0(vec_rsc_triosy_0_7_obj_iswt0),
      .vec_rsc_triosy_0_7_obj_ld_core_sct(vec_rsc_triosy_0_7_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj (
  vec_rsc_triosy_1_0_lz, core_wten, vec_rsc_triosy_1_0_obj_iswt0
);
  output vec_rsc_triosy_1_0_lz;
  input core_wten;
  input vec_rsc_triosy_1_0_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_0_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_0_obj (
      .ld(vec_rsc_triosy_1_0_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_0_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj_vec_rsc_triosy_1_0_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj_vec_rsc_triosy_1_0_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_0_obj_iswt0(vec_rsc_triosy_1_0_obj_iswt0),
      .vec_rsc_triosy_1_0_obj_ld_core_sct(vec_rsc_triosy_1_0_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj (
  vec_rsc_triosy_1_1_lz, core_wten, vec_rsc_triosy_1_1_obj_iswt0
);
  output vec_rsc_triosy_1_1_lz;
  input core_wten;
  input vec_rsc_triosy_1_1_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_1_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_1_obj (
      .ld(vec_rsc_triosy_1_1_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_1_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj_vec_rsc_triosy_1_1_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj_vec_rsc_triosy_1_1_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_1_obj_iswt0(vec_rsc_triosy_1_1_obj_iswt0),
      .vec_rsc_triosy_1_1_obj_ld_core_sct(vec_rsc_triosy_1_1_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj (
  vec_rsc_triosy_1_2_lz, core_wten, vec_rsc_triosy_1_2_obj_iswt0
);
  output vec_rsc_triosy_1_2_lz;
  input core_wten;
  input vec_rsc_triosy_1_2_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_2_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_2_obj (
      .ld(vec_rsc_triosy_1_2_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_2_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj_vec_rsc_triosy_1_2_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj_vec_rsc_triosy_1_2_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_2_obj_iswt0(vec_rsc_triosy_1_2_obj_iswt0),
      .vec_rsc_triosy_1_2_obj_ld_core_sct(vec_rsc_triosy_1_2_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj (
  vec_rsc_triosy_1_3_lz, core_wten, vec_rsc_triosy_1_3_obj_iswt0
);
  output vec_rsc_triosy_1_3_lz;
  input core_wten;
  input vec_rsc_triosy_1_3_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_3_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_3_obj (
      .ld(vec_rsc_triosy_1_3_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_3_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj_vec_rsc_triosy_1_3_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj_vec_rsc_triosy_1_3_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_3_obj_iswt0(vec_rsc_triosy_1_3_obj_iswt0),
      .vec_rsc_triosy_1_3_obj_ld_core_sct(vec_rsc_triosy_1_3_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj (
  vec_rsc_triosy_1_4_lz, core_wten, vec_rsc_triosy_1_4_obj_iswt0
);
  output vec_rsc_triosy_1_4_lz;
  input core_wten;
  input vec_rsc_triosy_1_4_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_4_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_4_obj (
      .ld(vec_rsc_triosy_1_4_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_4_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj_vec_rsc_triosy_1_4_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj_vec_rsc_triosy_1_4_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_4_obj_iswt0(vec_rsc_triosy_1_4_obj_iswt0),
      .vec_rsc_triosy_1_4_obj_ld_core_sct(vec_rsc_triosy_1_4_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj (
  vec_rsc_triosy_1_5_lz, core_wten, vec_rsc_triosy_1_5_obj_iswt0
);
  output vec_rsc_triosy_1_5_lz;
  input core_wten;
  input vec_rsc_triosy_1_5_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_5_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_5_obj (
      .ld(vec_rsc_triosy_1_5_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_5_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj_vec_rsc_triosy_1_5_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj_vec_rsc_triosy_1_5_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_5_obj_iswt0(vec_rsc_triosy_1_5_obj_iswt0),
      .vec_rsc_triosy_1_5_obj_ld_core_sct(vec_rsc_triosy_1_5_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj (
  vec_rsc_triosy_1_6_lz, core_wten, vec_rsc_triosy_1_6_obj_iswt0
);
  output vec_rsc_triosy_1_6_lz;
  input core_wten;
  input vec_rsc_triosy_1_6_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_6_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_6_obj (
      .ld(vec_rsc_triosy_1_6_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_6_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj_vec_rsc_triosy_1_6_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj_vec_rsc_triosy_1_6_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_6_obj_iswt0(vec_rsc_triosy_1_6_obj_iswt0),
      .vec_rsc_triosy_1_6_obj_ld_core_sct(vec_rsc_triosy_1_6_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj (
  vec_rsc_triosy_1_7_lz, core_wten, vec_rsc_triosy_1_7_obj_iswt0
);
  output vec_rsc_triosy_1_7_lz;
  input core_wten;
  input vec_rsc_triosy_1_7_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_1_7_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_1_7_obj (
      .ld(vec_rsc_triosy_1_7_obj_ld_core_sct),
      .lz(vec_rsc_triosy_1_7_lz)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj_vec_rsc_triosy_1_7_wait_ctrl
      inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj_vec_rsc_triosy_1_7_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_1_7_obj_iswt0(vec_rsc_triosy_1_7_obj_iswt0),
      .vec_rsc_triosy_1_7_obj_ld_core_sct(vec_rsc_triosy_1_7_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1 (
  clk, rst, twiddle_h_rsc_1_7_i_qb_d, twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_7_i_oswt, twiddle_h_rsc_1_7_i_qb_d_mxwt,
      twiddle_h_rsc_1_7_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_7_i_qb_d;
  output twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_7_i_oswt;
  output [31:0] twiddle_h_rsc_1_7_i_qb_d_mxwt;
  input twiddle_h_rsc_1_7_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_7_i_biwt;
  wire twiddle_h_rsc_1_7_i_bdwt;
  wire twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_7_i_oswt(twiddle_h_rsc_1_7_i_oswt),
      .twiddle_h_rsc_1_7_i_biwt(twiddle_h_rsc_1_7_i_biwt),
      .twiddle_h_rsc_1_7_i_bdwt(twiddle_h_rsc_1_7_i_bdwt),
      .twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_7_i_oswt_pff(twiddle_h_rsc_1_7_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_twiddle_h_rsc_1_7_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_7_i_qb_d(twiddle_h_rsc_1_7_i_qb_d),
      .twiddle_h_rsc_1_7_i_qb_d_mxwt(twiddle_h_rsc_1_7_i_qb_d_mxwt),
      .twiddle_h_rsc_1_7_i_biwt(twiddle_h_rsc_1_7_i_biwt),
      .twiddle_h_rsc_1_7_i_bdwt(twiddle_h_rsc_1_7_i_bdwt)
    );
  assign twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1 (
  clk, rst, twiddle_h_rsc_1_6_i_qb_d, twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_6_i_oswt, twiddle_h_rsc_1_6_i_qb_d_mxwt,
      twiddle_h_rsc_1_6_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_6_i_qb_d;
  output twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_6_i_oswt;
  output [31:0] twiddle_h_rsc_1_6_i_qb_d_mxwt;
  input twiddle_h_rsc_1_6_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_6_i_biwt;
  wire twiddle_h_rsc_1_6_i_bdwt;
  wire twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_6_i_oswt(twiddle_h_rsc_1_6_i_oswt),
      .twiddle_h_rsc_1_6_i_biwt(twiddle_h_rsc_1_6_i_biwt),
      .twiddle_h_rsc_1_6_i_bdwt(twiddle_h_rsc_1_6_i_bdwt),
      .twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_6_i_oswt_pff(twiddle_h_rsc_1_6_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_twiddle_h_rsc_1_6_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_6_i_qb_d(twiddle_h_rsc_1_6_i_qb_d),
      .twiddle_h_rsc_1_6_i_qb_d_mxwt(twiddle_h_rsc_1_6_i_qb_d_mxwt),
      .twiddle_h_rsc_1_6_i_biwt(twiddle_h_rsc_1_6_i_biwt),
      .twiddle_h_rsc_1_6_i_bdwt(twiddle_h_rsc_1_6_i_bdwt)
    );
  assign twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1 (
  clk, rst, twiddle_h_rsc_1_5_i_qb_d, twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_5_i_oswt, twiddle_h_rsc_1_5_i_qb_d_mxwt,
      twiddle_h_rsc_1_5_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_5_i_qb_d;
  output twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_5_i_oswt;
  output [31:0] twiddle_h_rsc_1_5_i_qb_d_mxwt;
  input twiddle_h_rsc_1_5_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_5_i_biwt;
  wire twiddle_h_rsc_1_5_i_bdwt;
  wire twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_5_i_oswt(twiddle_h_rsc_1_5_i_oswt),
      .twiddle_h_rsc_1_5_i_biwt(twiddle_h_rsc_1_5_i_biwt),
      .twiddle_h_rsc_1_5_i_bdwt(twiddle_h_rsc_1_5_i_bdwt),
      .twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_5_i_oswt_pff(twiddle_h_rsc_1_5_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_twiddle_h_rsc_1_5_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_5_i_qb_d(twiddle_h_rsc_1_5_i_qb_d),
      .twiddle_h_rsc_1_5_i_qb_d_mxwt(twiddle_h_rsc_1_5_i_qb_d_mxwt),
      .twiddle_h_rsc_1_5_i_biwt(twiddle_h_rsc_1_5_i_biwt),
      .twiddle_h_rsc_1_5_i_bdwt(twiddle_h_rsc_1_5_i_bdwt)
    );
  assign twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1 (
  clk, rst, twiddle_h_rsc_1_4_i_qb_d, twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_4_i_oswt, twiddle_h_rsc_1_4_i_qb_d_mxwt,
      twiddle_h_rsc_1_4_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_4_i_qb_d;
  output twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_4_i_oswt;
  output [31:0] twiddle_h_rsc_1_4_i_qb_d_mxwt;
  input twiddle_h_rsc_1_4_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_4_i_biwt;
  wire twiddle_h_rsc_1_4_i_bdwt;
  wire twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_4_i_oswt(twiddle_h_rsc_1_4_i_oswt),
      .twiddle_h_rsc_1_4_i_biwt(twiddle_h_rsc_1_4_i_biwt),
      .twiddle_h_rsc_1_4_i_bdwt(twiddle_h_rsc_1_4_i_bdwt),
      .twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_4_i_oswt_pff(twiddle_h_rsc_1_4_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_twiddle_h_rsc_1_4_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_4_i_qb_d(twiddle_h_rsc_1_4_i_qb_d),
      .twiddle_h_rsc_1_4_i_qb_d_mxwt(twiddle_h_rsc_1_4_i_qb_d_mxwt),
      .twiddle_h_rsc_1_4_i_biwt(twiddle_h_rsc_1_4_i_biwt),
      .twiddle_h_rsc_1_4_i_bdwt(twiddle_h_rsc_1_4_i_bdwt)
    );
  assign twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1 (
  clk, rst, twiddle_h_rsc_1_3_i_qb_d, twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_3_i_oswt, twiddle_h_rsc_1_3_i_qb_d_mxwt,
      twiddle_h_rsc_1_3_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_3_i_qb_d;
  output twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_3_i_oswt;
  output [31:0] twiddle_h_rsc_1_3_i_qb_d_mxwt;
  input twiddle_h_rsc_1_3_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_3_i_biwt;
  wire twiddle_h_rsc_1_3_i_bdwt;
  wire twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_3_i_oswt(twiddle_h_rsc_1_3_i_oswt),
      .twiddle_h_rsc_1_3_i_biwt(twiddle_h_rsc_1_3_i_biwt),
      .twiddle_h_rsc_1_3_i_bdwt(twiddle_h_rsc_1_3_i_bdwt),
      .twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_3_i_oswt_pff(twiddle_h_rsc_1_3_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_twiddle_h_rsc_1_3_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_3_i_qb_d(twiddle_h_rsc_1_3_i_qb_d),
      .twiddle_h_rsc_1_3_i_qb_d_mxwt(twiddle_h_rsc_1_3_i_qb_d_mxwt),
      .twiddle_h_rsc_1_3_i_biwt(twiddle_h_rsc_1_3_i_biwt),
      .twiddle_h_rsc_1_3_i_bdwt(twiddle_h_rsc_1_3_i_bdwt)
    );
  assign twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1 (
  clk, rst, twiddle_h_rsc_1_2_i_qb_d, twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_2_i_oswt, twiddle_h_rsc_1_2_i_qb_d_mxwt,
      twiddle_h_rsc_1_2_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_2_i_qb_d;
  output twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_2_i_oswt;
  output [31:0] twiddle_h_rsc_1_2_i_qb_d_mxwt;
  input twiddle_h_rsc_1_2_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_2_i_biwt;
  wire twiddle_h_rsc_1_2_i_bdwt;
  wire twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_2_i_oswt(twiddle_h_rsc_1_2_i_oswt),
      .twiddle_h_rsc_1_2_i_biwt(twiddle_h_rsc_1_2_i_biwt),
      .twiddle_h_rsc_1_2_i_bdwt(twiddle_h_rsc_1_2_i_bdwt),
      .twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_2_i_oswt_pff(twiddle_h_rsc_1_2_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_twiddle_h_rsc_1_2_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_2_i_qb_d(twiddle_h_rsc_1_2_i_qb_d),
      .twiddle_h_rsc_1_2_i_qb_d_mxwt(twiddle_h_rsc_1_2_i_qb_d_mxwt),
      .twiddle_h_rsc_1_2_i_biwt(twiddle_h_rsc_1_2_i_biwt),
      .twiddle_h_rsc_1_2_i_bdwt(twiddle_h_rsc_1_2_i_bdwt)
    );
  assign twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1 (
  clk, rst, twiddle_h_rsc_1_1_i_qb_d, twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_1_i_oswt, twiddle_h_rsc_1_1_i_qb_d_mxwt,
      twiddle_h_rsc_1_1_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_1_i_qb_d;
  output twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_1_i_oswt;
  output [31:0] twiddle_h_rsc_1_1_i_qb_d_mxwt;
  input twiddle_h_rsc_1_1_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_1_i_biwt;
  wire twiddle_h_rsc_1_1_i_bdwt;
  wire twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_1_i_oswt(twiddle_h_rsc_1_1_i_oswt),
      .twiddle_h_rsc_1_1_i_biwt(twiddle_h_rsc_1_1_i_biwt),
      .twiddle_h_rsc_1_1_i_bdwt(twiddle_h_rsc_1_1_i_bdwt),
      .twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_1_i_oswt_pff(twiddle_h_rsc_1_1_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_twiddle_h_rsc_1_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_1_i_qb_d(twiddle_h_rsc_1_1_i_qb_d),
      .twiddle_h_rsc_1_1_i_qb_d_mxwt(twiddle_h_rsc_1_1_i_qb_d_mxwt),
      .twiddle_h_rsc_1_1_i_biwt(twiddle_h_rsc_1_1_i_biwt),
      .twiddle_h_rsc_1_1_i_bdwt(twiddle_h_rsc_1_1_i_bdwt)
    );
  assign twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1 (
  clk, rst, twiddle_h_rsc_1_0_i_qb_d, twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_1_0_i_oswt, twiddle_h_rsc_1_0_i_qb_d_mxwt,
      twiddle_h_rsc_1_0_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_1_0_i_qb_d;
  output twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_1_0_i_oswt;
  output [31:0] twiddle_h_rsc_1_0_i_qb_d_mxwt;
  input twiddle_h_rsc_1_0_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_1_0_i_biwt;
  wire twiddle_h_rsc_1_0_i_bdwt;
  wire twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_0_i_oswt(twiddle_h_rsc_1_0_i_oswt),
      .twiddle_h_rsc_1_0_i_biwt(twiddle_h_rsc_1_0_i_biwt),
      .twiddle_h_rsc_1_0_i_bdwt(twiddle_h_rsc_1_0_i_bdwt),
      .twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_1_0_i_oswt_pff(twiddle_h_rsc_1_0_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_twiddle_h_rsc_1_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_0_i_qb_d(twiddle_h_rsc_1_0_i_qb_d),
      .twiddle_h_rsc_1_0_i_qb_d_mxwt(twiddle_h_rsc_1_0_i_qb_d_mxwt),
      .twiddle_h_rsc_1_0_i_biwt(twiddle_h_rsc_1_0_i_biwt),
      .twiddle_h_rsc_1_0_i_bdwt(twiddle_h_rsc_1_0_i_bdwt)
    );
  assign twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1 (
  clk, rst, twiddle_h_rsc_0_7_i_qb_d, twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_7_i_oswt, twiddle_h_rsc_0_7_i_qb_d_mxwt,
      twiddle_h_rsc_0_7_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_7_i_qb_d;
  output twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_7_i_oswt;
  output [31:0] twiddle_h_rsc_0_7_i_qb_d_mxwt;
  input twiddle_h_rsc_0_7_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_7_i_biwt;
  wire twiddle_h_rsc_0_7_i_bdwt;
  wire twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_7_i_oswt(twiddle_h_rsc_0_7_i_oswt),
      .twiddle_h_rsc_0_7_i_biwt(twiddle_h_rsc_0_7_i_biwt),
      .twiddle_h_rsc_0_7_i_bdwt(twiddle_h_rsc_0_7_i_bdwt),
      .twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_7_i_oswt_pff(twiddle_h_rsc_0_7_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_twiddle_h_rsc_0_7_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_7_i_qb_d(twiddle_h_rsc_0_7_i_qb_d),
      .twiddle_h_rsc_0_7_i_qb_d_mxwt(twiddle_h_rsc_0_7_i_qb_d_mxwt),
      .twiddle_h_rsc_0_7_i_biwt(twiddle_h_rsc_0_7_i_biwt),
      .twiddle_h_rsc_0_7_i_bdwt(twiddle_h_rsc_0_7_i_bdwt)
    );
  assign twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1 (
  clk, rst, twiddle_h_rsc_0_6_i_qb_d, twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_6_i_oswt, twiddle_h_rsc_0_6_i_qb_d_mxwt,
      twiddle_h_rsc_0_6_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_6_i_qb_d;
  output twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_6_i_oswt;
  output [31:0] twiddle_h_rsc_0_6_i_qb_d_mxwt;
  input twiddle_h_rsc_0_6_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_6_i_biwt;
  wire twiddle_h_rsc_0_6_i_bdwt;
  wire twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_6_i_oswt(twiddle_h_rsc_0_6_i_oswt),
      .twiddle_h_rsc_0_6_i_biwt(twiddle_h_rsc_0_6_i_biwt),
      .twiddle_h_rsc_0_6_i_bdwt(twiddle_h_rsc_0_6_i_bdwt),
      .twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_6_i_oswt_pff(twiddle_h_rsc_0_6_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_twiddle_h_rsc_0_6_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_6_i_qb_d(twiddle_h_rsc_0_6_i_qb_d),
      .twiddle_h_rsc_0_6_i_qb_d_mxwt(twiddle_h_rsc_0_6_i_qb_d_mxwt),
      .twiddle_h_rsc_0_6_i_biwt(twiddle_h_rsc_0_6_i_biwt),
      .twiddle_h_rsc_0_6_i_bdwt(twiddle_h_rsc_0_6_i_bdwt)
    );
  assign twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1 (
  clk, rst, twiddle_h_rsc_0_5_i_qb_d, twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_5_i_oswt, twiddle_h_rsc_0_5_i_qb_d_mxwt,
      twiddle_h_rsc_0_5_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_5_i_qb_d;
  output twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_5_i_oswt;
  output [31:0] twiddle_h_rsc_0_5_i_qb_d_mxwt;
  input twiddle_h_rsc_0_5_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_5_i_biwt;
  wire twiddle_h_rsc_0_5_i_bdwt;
  wire twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_5_i_oswt(twiddle_h_rsc_0_5_i_oswt),
      .twiddle_h_rsc_0_5_i_biwt(twiddle_h_rsc_0_5_i_biwt),
      .twiddle_h_rsc_0_5_i_bdwt(twiddle_h_rsc_0_5_i_bdwt),
      .twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_5_i_oswt_pff(twiddle_h_rsc_0_5_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_twiddle_h_rsc_0_5_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_5_i_qb_d(twiddle_h_rsc_0_5_i_qb_d),
      .twiddle_h_rsc_0_5_i_qb_d_mxwt(twiddle_h_rsc_0_5_i_qb_d_mxwt),
      .twiddle_h_rsc_0_5_i_biwt(twiddle_h_rsc_0_5_i_biwt),
      .twiddle_h_rsc_0_5_i_bdwt(twiddle_h_rsc_0_5_i_bdwt)
    );
  assign twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1 (
  clk, rst, twiddle_h_rsc_0_4_i_qb_d, twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_4_i_oswt, twiddle_h_rsc_0_4_i_qb_d_mxwt,
      twiddle_h_rsc_0_4_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_4_i_qb_d;
  output twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_4_i_oswt;
  output [31:0] twiddle_h_rsc_0_4_i_qb_d_mxwt;
  input twiddle_h_rsc_0_4_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_4_i_biwt;
  wire twiddle_h_rsc_0_4_i_bdwt;
  wire twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_4_i_oswt(twiddle_h_rsc_0_4_i_oswt),
      .twiddle_h_rsc_0_4_i_biwt(twiddle_h_rsc_0_4_i_biwt),
      .twiddle_h_rsc_0_4_i_bdwt(twiddle_h_rsc_0_4_i_bdwt),
      .twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_4_i_oswt_pff(twiddle_h_rsc_0_4_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_twiddle_h_rsc_0_4_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_4_i_qb_d(twiddle_h_rsc_0_4_i_qb_d),
      .twiddle_h_rsc_0_4_i_qb_d_mxwt(twiddle_h_rsc_0_4_i_qb_d_mxwt),
      .twiddle_h_rsc_0_4_i_biwt(twiddle_h_rsc_0_4_i_biwt),
      .twiddle_h_rsc_0_4_i_bdwt(twiddle_h_rsc_0_4_i_bdwt)
    );
  assign twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1 (
  clk, rst, twiddle_h_rsc_0_3_i_qb_d, twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_3_i_oswt, twiddle_h_rsc_0_3_i_qb_d_mxwt,
      twiddle_h_rsc_0_3_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_3_i_qb_d;
  output twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_3_i_oswt;
  output [31:0] twiddle_h_rsc_0_3_i_qb_d_mxwt;
  input twiddle_h_rsc_0_3_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_3_i_biwt;
  wire twiddle_h_rsc_0_3_i_bdwt;
  wire twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_3_i_oswt(twiddle_h_rsc_0_3_i_oswt),
      .twiddle_h_rsc_0_3_i_biwt(twiddle_h_rsc_0_3_i_biwt),
      .twiddle_h_rsc_0_3_i_bdwt(twiddle_h_rsc_0_3_i_bdwt),
      .twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_3_i_oswt_pff(twiddle_h_rsc_0_3_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_twiddle_h_rsc_0_3_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_3_i_qb_d(twiddle_h_rsc_0_3_i_qb_d),
      .twiddle_h_rsc_0_3_i_qb_d_mxwt(twiddle_h_rsc_0_3_i_qb_d_mxwt),
      .twiddle_h_rsc_0_3_i_biwt(twiddle_h_rsc_0_3_i_biwt),
      .twiddle_h_rsc_0_3_i_bdwt(twiddle_h_rsc_0_3_i_bdwt)
    );
  assign twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1 (
  clk, rst, twiddle_h_rsc_0_2_i_qb_d, twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_2_i_oswt, twiddle_h_rsc_0_2_i_qb_d_mxwt,
      twiddle_h_rsc_0_2_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_2_i_qb_d;
  output twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_2_i_oswt;
  output [31:0] twiddle_h_rsc_0_2_i_qb_d_mxwt;
  input twiddle_h_rsc_0_2_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_2_i_biwt;
  wire twiddle_h_rsc_0_2_i_bdwt;
  wire twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_2_i_oswt(twiddle_h_rsc_0_2_i_oswt),
      .twiddle_h_rsc_0_2_i_biwt(twiddle_h_rsc_0_2_i_biwt),
      .twiddle_h_rsc_0_2_i_bdwt(twiddle_h_rsc_0_2_i_bdwt),
      .twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_2_i_oswt_pff(twiddle_h_rsc_0_2_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_twiddle_h_rsc_0_2_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_2_i_qb_d(twiddle_h_rsc_0_2_i_qb_d),
      .twiddle_h_rsc_0_2_i_qb_d_mxwt(twiddle_h_rsc_0_2_i_qb_d_mxwt),
      .twiddle_h_rsc_0_2_i_biwt(twiddle_h_rsc_0_2_i_biwt),
      .twiddle_h_rsc_0_2_i_bdwt(twiddle_h_rsc_0_2_i_bdwt)
    );
  assign twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1 (
  clk, rst, twiddle_h_rsc_0_1_i_qb_d, twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_1_i_oswt, twiddle_h_rsc_0_1_i_qb_d_mxwt,
      twiddle_h_rsc_0_1_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_1_i_qb_d;
  output twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_1_i_oswt;
  output [31:0] twiddle_h_rsc_0_1_i_qb_d_mxwt;
  input twiddle_h_rsc_0_1_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_1_i_biwt;
  wire twiddle_h_rsc_0_1_i_bdwt;
  wire twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_1_i_oswt(twiddle_h_rsc_0_1_i_oswt),
      .twiddle_h_rsc_0_1_i_biwt(twiddle_h_rsc_0_1_i_biwt),
      .twiddle_h_rsc_0_1_i_bdwt(twiddle_h_rsc_0_1_i_bdwt),
      .twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_1_i_oswt_pff(twiddle_h_rsc_0_1_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_twiddle_h_rsc_0_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_1_i_qb_d(twiddle_h_rsc_0_1_i_qb_d),
      .twiddle_h_rsc_0_1_i_qb_d_mxwt(twiddle_h_rsc_0_1_i_qb_d_mxwt),
      .twiddle_h_rsc_0_1_i_biwt(twiddle_h_rsc_0_1_i_biwt),
      .twiddle_h_rsc_0_1_i_bdwt(twiddle_h_rsc_0_1_i_bdwt)
    );
  assign twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1 (
  clk, rst, twiddle_h_rsc_0_0_i_qb_d, twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsc_0_0_i_oswt, twiddle_h_rsc_0_0_i_qb_d_mxwt,
      twiddle_h_rsc_0_0_i_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsc_0_0_i_qb_d;
  output twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsc_0_0_i_oswt;
  output [31:0] twiddle_h_rsc_0_0_i_qb_d_mxwt;
  input twiddle_h_rsc_0_0_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsc_0_0_i_biwt;
  wire twiddle_h_rsc_0_0_i_bdwt;
  wire twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_0_i_oswt(twiddle_h_rsc_0_0_i_oswt),
      .twiddle_h_rsc_0_0_i_biwt(twiddle_h_rsc_0_0_i_biwt),
      .twiddle_h_rsc_0_0_i_bdwt(twiddle_h_rsc_0_0_i_bdwt),
      .twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsc_0_0_i_oswt_pff(twiddle_h_rsc_0_0_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_twiddle_h_rsc_0_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_0_i_qb_d(twiddle_h_rsc_0_0_i_qb_d),
      .twiddle_h_rsc_0_0_i_qb_d_mxwt(twiddle_h_rsc_0_0_i_qb_d_mxwt),
      .twiddle_h_rsc_0_0_i_biwt(twiddle_h_rsc_0_0_i_biwt),
      .twiddle_h_rsc_0_0_i_bdwt(twiddle_h_rsc_0_0_i_bdwt)
    );
  assign twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1 (
  clk, rst, twiddle_rsc_1_7_i_qb_d, twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_7_i_oswt, twiddle_rsc_1_7_i_qb_d_mxwt, twiddle_rsc_1_7_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_7_i_qb_d;
  output twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_7_i_oswt;
  output [31:0] twiddle_rsc_1_7_i_qb_d_mxwt;
  input twiddle_rsc_1_7_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_7_i_biwt;
  wire twiddle_rsc_1_7_i_bdwt;
  wire twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_7_i_oswt(twiddle_rsc_1_7_i_oswt),
      .twiddle_rsc_1_7_i_biwt(twiddle_rsc_1_7_i_biwt),
      .twiddle_rsc_1_7_i_bdwt(twiddle_rsc_1_7_i_bdwt),
      .twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_7_i_oswt_pff(twiddle_rsc_1_7_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_twiddle_rsc_1_7_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_7_i_qb_d(twiddle_rsc_1_7_i_qb_d),
      .twiddle_rsc_1_7_i_qb_d_mxwt(twiddle_rsc_1_7_i_qb_d_mxwt),
      .twiddle_rsc_1_7_i_biwt(twiddle_rsc_1_7_i_biwt),
      .twiddle_rsc_1_7_i_bdwt(twiddle_rsc_1_7_i_bdwt)
    );
  assign twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1 (
  clk, rst, twiddle_rsc_1_6_i_qb_d, twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_6_i_oswt, twiddle_rsc_1_6_i_qb_d_mxwt, twiddle_rsc_1_6_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_6_i_qb_d;
  output twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_6_i_oswt;
  output [31:0] twiddle_rsc_1_6_i_qb_d_mxwt;
  input twiddle_rsc_1_6_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_6_i_biwt;
  wire twiddle_rsc_1_6_i_bdwt;
  wire twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_6_i_oswt(twiddle_rsc_1_6_i_oswt),
      .twiddle_rsc_1_6_i_biwt(twiddle_rsc_1_6_i_biwt),
      .twiddle_rsc_1_6_i_bdwt(twiddle_rsc_1_6_i_bdwt),
      .twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_6_i_oswt_pff(twiddle_rsc_1_6_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_twiddle_rsc_1_6_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_6_i_qb_d(twiddle_rsc_1_6_i_qb_d),
      .twiddle_rsc_1_6_i_qb_d_mxwt(twiddle_rsc_1_6_i_qb_d_mxwt),
      .twiddle_rsc_1_6_i_biwt(twiddle_rsc_1_6_i_biwt),
      .twiddle_rsc_1_6_i_bdwt(twiddle_rsc_1_6_i_bdwt)
    );
  assign twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1 (
  clk, rst, twiddle_rsc_1_5_i_qb_d, twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_5_i_oswt, twiddle_rsc_1_5_i_qb_d_mxwt, twiddle_rsc_1_5_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_5_i_qb_d;
  output twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_5_i_oswt;
  output [31:0] twiddle_rsc_1_5_i_qb_d_mxwt;
  input twiddle_rsc_1_5_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_5_i_biwt;
  wire twiddle_rsc_1_5_i_bdwt;
  wire twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_5_i_oswt(twiddle_rsc_1_5_i_oswt),
      .twiddle_rsc_1_5_i_biwt(twiddle_rsc_1_5_i_biwt),
      .twiddle_rsc_1_5_i_bdwt(twiddle_rsc_1_5_i_bdwt),
      .twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_5_i_oswt_pff(twiddle_rsc_1_5_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_twiddle_rsc_1_5_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_5_i_qb_d(twiddle_rsc_1_5_i_qb_d),
      .twiddle_rsc_1_5_i_qb_d_mxwt(twiddle_rsc_1_5_i_qb_d_mxwt),
      .twiddle_rsc_1_5_i_biwt(twiddle_rsc_1_5_i_biwt),
      .twiddle_rsc_1_5_i_bdwt(twiddle_rsc_1_5_i_bdwt)
    );
  assign twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1 (
  clk, rst, twiddle_rsc_1_4_i_qb_d, twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_4_i_oswt, twiddle_rsc_1_4_i_qb_d_mxwt, twiddle_rsc_1_4_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_4_i_qb_d;
  output twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_4_i_oswt;
  output [31:0] twiddle_rsc_1_4_i_qb_d_mxwt;
  input twiddle_rsc_1_4_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_4_i_biwt;
  wire twiddle_rsc_1_4_i_bdwt;
  wire twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_4_i_oswt(twiddle_rsc_1_4_i_oswt),
      .twiddle_rsc_1_4_i_biwt(twiddle_rsc_1_4_i_biwt),
      .twiddle_rsc_1_4_i_bdwt(twiddle_rsc_1_4_i_bdwt),
      .twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_4_i_oswt_pff(twiddle_rsc_1_4_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_twiddle_rsc_1_4_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_4_i_qb_d(twiddle_rsc_1_4_i_qb_d),
      .twiddle_rsc_1_4_i_qb_d_mxwt(twiddle_rsc_1_4_i_qb_d_mxwt),
      .twiddle_rsc_1_4_i_biwt(twiddle_rsc_1_4_i_biwt),
      .twiddle_rsc_1_4_i_bdwt(twiddle_rsc_1_4_i_bdwt)
    );
  assign twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1 (
  clk, rst, twiddle_rsc_1_3_i_qb_d, twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_3_i_oswt, twiddle_rsc_1_3_i_qb_d_mxwt, twiddle_rsc_1_3_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_3_i_qb_d;
  output twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_3_i_oswt;
  output [31:0] twiddle_rsc_1_3_i_qb_d_mxwt;
  input twiddle_rsc_1_3_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_3_i_biwt;
  wire twiddle_rsc_1_3_i_bdwt;
  wire twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_3_i_oswt(twiddle_rsc_1_3_i_oswt),
      .twiddle_rsc_1_3_i_biwt(twiddle_rsc_1_3_i_biwt),
      .twiddle_rsc_1_3_i_bdwt(twiddle_rsc_1_3_i_bdwt),
      .twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_3_i_oswt_pff(twiddle_rsc_1_3_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_twiddle_rsc_1_3_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_3_i_qb_d(twiddle_rsc_1_3_i_qb_d),
      .twiddle_rsc_1_3_i_qb_d_mxwt(twiddle_rsc_1_3_i_qb_d_mxwt),
      .twiddle_rsc_1_3_i_biwt(twiddle_rsc_1_3_i_biwt),
      .twiddle_rsc_1_3_i_bdwt(twiddle_rsc_1_3_i_bdwt)
    );
  assign twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1 (
  clk, rst, twiddle_rsc_1_2_i_qb_d, twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_2_i_oswt, twiddle_rsc_1_2_i_qb_d_mxwt, twiddle_rsc_1_2_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_2_i_qb_d;
  output twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_2_i_oswt;
  output [31:0] twiddle_rsc_1_2_i_qb_d_mxwt;
  input twiddle_rsc_1_2_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_2_i_biwt;
  wire twiddle_rsc_1_2_i_bdwt;
  wire twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_2_i_oswt(twiddle_rsc_1_2_i_oswt),
      .twiddle_rsc_1_2_i_biwt(twiddle_rsc_1_2_i_biwt),
      .twiddle_rsc_1_2_i_bdwt(twiddle_rsc_1_2_i_bdwt),
      .twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_2_i_oswt_pff(twiddle_rsc_1_2_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_twiddle_rsc_1_2_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_2_i_qb_d(twiddle_rsc_1_2_i_qb_d),
      .twiddle_rsc_1_2_i_qb_d_mxwt(twiddle_rsc_1_2_i_qb_d_mxwt),
      .twiddle_rsc_1_2_i_biwt(twiddle_rsc_1_2_i_biwt),
      .twiddle_rsc_1_2_i_bdwt(twiddle_rsc_1_2_i_bdwt)
    );
  assign twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1 (
  clk, rst, twiddle_rsc_1_1_i_qb_d, twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_1_i_oswt, twiddle_rsc_1_1_i_qb_d_mxwt, twiddle_rsc_1_1_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_1_i_qb_d;
  output twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_1_i_oswt;
  output [31:0] twiddle_rsc_1_1_i_qb_d_mxwt;
  input twiddle_rsc_1_1_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_1_i_biwt;
  wire twiddle_rsc_1_1_i_bdwt;
  wire twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_1_i_oswt(twiddle_rsc_1_1_i_oswt),
      .twiddle_rsc_1_1_i_biwt(twiddle_rsc_1_1_i_biwt),
      .twiddle_rsc_1_1_i_bdwt(twiddle_rsc_1_1_i_bdwt),
      .twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_1_i_oswt_pff(twiddle_rsc_1_1_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_twiddle_rsc_1_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_1_i_qb_d(twiddle_rsc_1_1_i_qb_d),
      .twiddle_rsc_1_1_i_qb_d_mxwt(twiddle_rsc_1_1_i_qb_d_mxwt),
      .twiddle_rsc_1_1_i_biwt(twiddle_rsc_1_1_i_biwt),
      .twiddle_rsc_1_1_i_bdwt(twiddle_rsc_1_1_i_bdwt)
    );
  assign twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1 (
  clk, rst, twiddle_rsc_1_0_i_qb_d, twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_1_0_i_oswt, twiddle_rsc_1_0_i_qb_d_mxwt, twiddle_rsc_1_0_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_1_0_i_qb_d;
  output twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_1_0_i_oswt;
  output [31:0] twiddle_rsc_1_0_i_qb_d_mxwt;
  input twiddle_rsc_1_0_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_1_0_i_biwt;
  wire twiddle_rsc_1_0_i_bdwt;
  wire twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_1_0_i_oswt(twiddle_rsc_1_0_i_oswt),
      .twiddle_rsc_1_0_i_biwt(twiddle_rsc_1_0_i_biwt),
      .twiddle_rsc_1_0_i_bdwt(twiddle_rsc_1_0_i_bdwt),
      .twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_1_0_i_oswt_pff(twiddle_rsc_1_0_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_twiddle_rsc_1_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_0_i_qb_d(twiddle_rsc_1_0_i_qb_d),
      .twiddle_rsc_1_0_i_qb_d_mxwt(twiddle_rsc_1_0_i_qb_d_mxwt),
      .twiddle_rsc_1_0_i_biwt(twiddle_rsc_1_0_i_biwt),
      .twiddle_rsc_1_0_i_bdwt(twiddle_rsc_1_0_i_bdwt)
    );
  assign twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1 (
  clk, rst, twiddle_rsc_0_7_i_qb_d, twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_7_i_oswt, twiddle_rsc_0_7_i_qb_d_mxwt, twiddle_rsc_0_7_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_7_i_qb_d;
  output twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_7_i_oswt;
  output [31:0] twiddle_rsc_0_7_i_qb_d_mxwt;
  input twiddle_rsc_0_7_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_7_i_biwt;
  wire twiddle_rsc_0_7_i_bdwt;
  wire twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_7_i_oswt(twiddle_rsc_0_7_i_oswt),
      .twiddle_rsc_0_7_i_biwt(twiddle_rsc_0_7_i_biwt),
      .twiddle_rsc_0_7_i_bdwt(twiddle_rsc_0_7_i_bdwt),
      .twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_7_i_oswt_pff(twiddle_rsc_0_7_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_twiddle_rsc_0_7_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_7_i_qb_d(twiddle_rsc_0_7_i_qb_d),
      .twiddle_rsc_0_7_i_qb_d_mxwt(twiddle_rsc_0_7_i_qb_d_mxwt),
      .twiddle_rsc_0_7_i_biwt(twiddle_rsc_0_7_i_biwt),
      .twiddle_rsc_0_7_i_bdwt(twiddle_rsc_0_7_i_bdwt)
    );
  assign twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1 (
  clk, rst, twiddle_rsc_0_6_i_qb_d, twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_6_i_oswt, twiddle_rsc_0_6_i_qb_d_mxwt, twiddle_rsc_0_6_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_6_i_qb_d;
  output twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_6_i_oswt;
  output [31:0] twiddle_rsc_0_6_i_qb_d_mxwt;
  input twiddle_rsc_0_6_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_6_i_biwt;
  wire twiddle_rsc_0_6_i_bdwt;
  wire twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_6_i_oswt(twiddle_rsc_0_6_i_oswt),
      .twiddle_rsc_0_6_i_biwt(twiddle_rsc_0_6_i_biwt),
      .twiddle_rsc_0_6_i_bdwt(twiddle_rsc_0_6_i_bdwt),
      .twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_6_i_oswt_pff(twiddle_rsc_0_6_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_twiddle_rsc_0_6_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_6_i_qb_d(twiddle_rsc_0_6_i_qb_d),
      .twiddle_rsc_0_6_i_qb_d_mxwt(twiddle_rsc_0_6_i_qb_d_mxwt),
      .twiddle_rsc_0_6_i_biwt(twiddle_rsc_0_6_i_biwt),
      .twiddle_rsc_0_6_i_bdwt(twiddle_rsc_0_6_i_bdwt)
    );
  assign twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1 (
  clk, rst, twiddle_rsc_0_5_i_qb_d, twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_5_i_oswt, twiddle_rsc_0_5_i_qb_d_mxwt, twiddle_rsc_0_5_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_5_i_qb_d;
  output twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_5_i_oswt;
  output [31:0] twiddle_rsc_0_5_i_qb_d_mxwt;
  input twiddle_rsc_0_5_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_5_i_biwt;
  wire twiddle_rsc_0_5_i_bdwt;
  wire twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_5_i_oswt(twiddle_rsc_0_5_i_oswt),
      .twiddle_rsc_0_5_i_biwt(twiddle_rsc_0_5_i_biwt),
      .twiddle_rsc_0_5_i_bdwt(twiddle_rsc_0_5_i_bdwt),
      .twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_5_i_oswt_pff(twiddle_rsc_0_5_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_twiddle_rsc_0_5_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_5_i_qb_d(twiddle_rsc_0_5_i_qb_d),
      .twiddle_rsc_0_5_i_qb_d_mxwt(twiddle_rsc_0_5_i_qb_d_mxwt),
      .twiddle_rsc_0_5_i_biwt(twiddle_rsc_0_5_i_biwt),
      .twiddle_rsc_0_5_i_bdwt(twiddle_rsc_0_5_i_bdwt)
    );
  assign twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1 (
  clk, rst, twiddle_rsc_0_4_i_qb_d, twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_4_i_oswt, twiddle_rsc_0_4_i_qb_d_mxwt, twiddle_rsc_0_4_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_4_i_qb_d;
  output twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_4_i_oswt;
  output [31:0] twiddle_rsc_0_4_i_qb_d_mxwt;
  input twiddle_rsc_0_4_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_4_i_biwt;
  wire twiddle_rsc_0_4_i_bdwt;
  wire twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_4_i_oswt(twiddle_rsc_0_4_i_oswt),
      .twiddle_rsc_0_4_i_biwt(twiddle_rsc_0_4_i_biwt),
      .twiddle_rsc_0_4_i_bdwt(twiddle_rsc_0_4_i_bdwt),
      .twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_4_i_oswt_pff(twiddle_rsc_0_4_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_twiddle_rsc_0_4_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_4_i_qb_d(twiddle_rsc_0_4_i_qb_d),
      .twiddle_rsc_0_4_i_qb_d_mxwt(twiddle_rsc_0_4_i_qb_d_mxwt),
      .twiddle_rsc_0_4_i_biwt(twiddle_rsc_0_4_i_biwt),
      .twiddle_rsc_0_4_i_bdwt(twiddle_rsc_0_4_i_bdwt)
    );
  assign twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1 (
  clk, rst, twiddle_rsc_0_3_i_qb_d, twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_3_i_oswt, twiddle_rsc_0_3_i_qb_d_mxwt, twiddle_rsc_0_3_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_3_i_qb_d;
  output twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_3_i_oswt;
  output [31:0] twiddle_rsc_0_3_i_qb_d_mxwt;
  input twiddle_rsc_0_3_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_3_i_biwt;
  wire twiddle_rsc_0_3_i_bdwt;
  wire twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_3_i_oswt(twiddle_rsc_0_3_i_oswt),
      .twiddle_rsc_0_3_i_biwt(twiddle_rsc_0_3_i_biwt),
      .twiddle_rsc_0_3_i_bdwt(twiddle_rsc_0_3_i_bdwt),
      .twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_3_i_oswt_pff(twiddle_rsc_0_3_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_twiddle_rsc_0_3_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_3_i_qb_d(twiddle_rsc_0_3_i_qb_d),
      .twiddle_rsc_0_3_i_qb_d_mxwt(twiddle_rsc_0_3_i_qb_d_mxwt),
      .twiddle_rsc_0_3_i_biwt(twiddle_rsc_0_3_i_biwt),
      .twiddle_rsc_0_3_i_bdwt(twiddle_rsc_0_3_i_bdwt)
    );
  assign twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1 (
  clk, rst, twiddle_rsc_0_2_i_qb_d, twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_2_i_oswt, twiddle_rsc_0_2_i_qb_d_mxwt, twiddle_rsc_0_2_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_2_i_qb_d;
  output twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_2_i_oswt;
  output [31:0] twiddle_rsc_0_2_i_qb_d_mxwt;
  input twiddle_rsc_0_2_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_2_i_biwt;
  wire twiddle_rsc_0_2_i_bdwt;
  wire twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_2_i_oswt(twiddle_rsc_0_2_i_oswt),
      .twiddle_rsc_0_2_i_biwt(twiddle_rsc_0_2_i_biwt),
      .twiddle_rsc_0_2_i_bdwt(twiddle_rsc_0_2_i_bdwt),
      .twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_2_i_oswt_pff(twiddle_rsc_0_2_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_twiddle_rsc_0_2_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_2_i_qb_d(twiddle_rsc_0_2_i_qb_d),
      .twiddle_rsc_0_2_i_qb_d_mxwt(twiddle_rsc_0_2_i_qb_d_mxwt),
      .twiddle_rsc_0_2_i_biwt(twiddle_rsc_0_2_i_biwt),
      .twiddle_rsc_0_2_i_bdwt(twiddle_rsc_0_2_i_bdwt)
    );
  assign twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1 (
  clk, rst, twiddle_rsc_0_1_i_qb_d, twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_1_i_oswt, twiddle_rsc_0_1_i_qb_d_mxwt, twiddle_rsc_0_1_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_1_i_qb_d;
  output twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_1_i_oswt;
  output [31:0] twiddle_rsc_0_1_i_qb_d_mxwt;
  input twiddle_rsc_0_1_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_1_i_biwt;
  wire twiddle_rsc_0_1_i_bdwt;
  wire twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_1_i_oswt(twiddle_rsc_0_1_i_oswt),
      .twiddle_rsc_0_1_i_biwt(twiddle_rsc_0_1_i_biwt),
      .twiddle_rsc_0_1_i_bdwt(twiddle_rsc_0_1_i_bdwt),
      .twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_1_i_oswt_pff(twiddle_rsc_0_1_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_twiddle_rsc_0_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_1_i_qb_d(twiddle_rsc_0_1_i_qb_d),
      .twiddle_rsc_0_1_i_qb_d_mxwt(twiddle_rsc_0_1_i_qb_d_mxwt),
      .twiddle_rsc_0_1_i_biwt(twiddle_rsc_0_1_i_biwt),
      .twiddle_rsc_0_1_i_bdwt(twiddle_rsc_0_1_i_bdwt)
    );
  assign twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1 (
  clk, rst, twiddle_rsc_0_0_i_qb_d, twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsc_0_0_i_oswt, twiddle_rsc_0_0_i_qb_d_mxwt, twiddle_rsc_0_0_i_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsc_0_0_i_qb_d;
  output twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsc_0_0_i_oswt;
  output [31:0] twiddle_rsc_0_0_i_qb_d_mxwt;
  input twiddle_rsc_0_0_i_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsc_0_0_i_biwt;
  wire twiddle_rsc_0_0_i_bdwt;
  wire twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsc_0_0_i_oswt(twiddle_rsc_0_0_i_oswt),
      .twiddle_rsc_0_0_i_biwt(twiddle_rsc_0_0_i_biwt),
      .twiddle_rsc_0_0_i_bdwt(twiddle_rsc_0_0_i_bdwt),
      .twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsc_0_0_i_oswt_pff(twiddle_rsc_0_0_i_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_twiddle_rsc_0_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_0_i_qb_d(twiddle_rsc_0_0_i_qb_d),
      .twiddle_rsc_0_0_i_qb_d_mxwt(twiddle_rsc_0_0_i_qb_d_mxwt),
      .twiddle_rsc_0_0_i_biwt(twiddle_rsc_0_0_i_biwt),
      .twiddle_rsc_0_0_i_bdwt(twiddle_rsc_0_0_i_bdwt)
    );
  assign twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1 (
  clk, rst, vec_rsc_1_7_i_da_d, vec_rsc_1_7_i_qa_d, vec_rsc_1_7_i_wea_d, vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_7_i_oswt,
      vec_rsc_1_7_i_oswt_1, vec_rsc_1_7_i_da_d_core, vec_rsc_1_7_i_qa_d_mxwt, vec_rsc_1_7_i_wea_d_core_psct,
      vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_7_i_oswt_pff, vec_rsc_1_7_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_7_i_da_d;
  input [63:0] vec_rsc_1_7_i_qa_d;
  output [1:0] vec_rsc_1_7_i_wea_d;
  output [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_7_i_oswt;
  input vec_rsc_1_7_i_oswt_1;
  input [63:0] vec_rsc_1_7_i_da_d_core;
  output [63:0] vec_rsc_1_7_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_7_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_7_i_oswt_pff;
  input vec_rsc_1_7_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_7_i_biwt;
  wire vec_rsc_1_7_i_bdwt;
  wire vec_rsc_1_7_i_biwt_1;
  wire vec_rsc_1_7_i_bdwt_2;
  wire [1:0] vec_rsc_1_7_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_7_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl_inst_vec_rsc_1_7_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl_inst_vec_rsc_1_7_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_7_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_dp_inst_vec_rsc_1_7_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_dp_inst_vec_rsc_1_7_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_7_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_7_i_oswt(vec_rsc_1_7_i_oswt),
      .vec_rsc_1_7_i_oswt_1(vec_rsc_1_7_i_oswt_1),
      .vec_rsc_1_7_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl_inst_vec_rsc_1_7_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_ctrl_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_7_i_biwt(vec_rsc_1_7_i_biwt),
      .vec_rsc_1_7_i_bdwt(vec_rsc_1_7_i_bdwt),
      .vec_rsc_1_7_i_biwt_1(vec_rsc_1_7_i_biwt_1),
      .vec_rsc_1_7_i_bdwt_2(vec_rsc_1_7_i_bdwt_2),
      .vec_rsc_1_7_i_wea_d_core_sct(vec_rsc_1_7_i_wea_d_core_sct),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_7_i_oswt_pff(vec_rsc_1_7_i_oswt_pff),
      .vec_rsc_1_7_i_oswt_1_pff(vec_rsc_1_7_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_7_i_da_d(vec_rsc_1_7_i_da_d_reg),
      .vec_rsc_1_7_i_qa_d(vec_rsc_1_7_i_qa_d),
      .vec_rsc_1_7_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_vec_rsc_1_7_wait_dp_inst_vec_rsc_1_7_i_da_d_core[63:0]),
      .vec_rsc_1_7_i_qa_d_mxwt(vec_rsc_1_7_i_qa_d_mxwt),
      .vec_rsc_1_7_i_biwt(vec_rsc_1_7_i_biwt),
      .vec_rsc_1_7_i_bdwt(vec_rsc_1_7_i_bdwt),
      .vec_rsc_1_7_i_biwt_1(vec_rsc_1_7_i_biwt_1),
      .vec_rsc_1_7_i_bdwt_2(vec_rsc_1_7_i_bdwt_2)
    );
  assign vec_rsc_1_7_i_wea_d = vec_rsc_1_7_i_wea_d_core_sct;
  assign vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_7_i_da_d = vec_rsc_1_7_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1 (
  clk, rst, vec_rsc_1_6_i_da_d, vec_rsc_1_6_i_qa_d, vec_rsc_1_6_i_wea_d, vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_6_i_oswt,
      vec_rsc_1_6_i_oswt_1, vec_rsc_1_6_i_da_d_core, vec_rsc_1_6_i_qa_d_mxwt, vec_rsc_1_6_i_wea_d_core_psct,
      vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_6_i_oswt_pff, vec_rsc_1_6_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_6_i_da_d;
  input [63:0] vec_rsc_1_6_i_qa_d;
  output [1:0] vec_rsc_1_6_i_wea_d;
  output [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_6_i_oswt;
  input vec_rsc_1_6_i_oswt_1;
  input [63:0] vec_rsc_1_6_i_da_d_core;
  output [63:0] vec_rsc_1_6_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_6_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_6_i_oswt_pff;
  input vec_rsc_1_6_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_6_i_biwt;
  wire vec_rsc_1_6_i_bdwt;
  wire vec_rsc_1_6_i_biwt_1;
  wire vec_rsc_1_6_i_bdwt_2;
  wire [1:0] vec_rsc_1_6_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_6_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl_inst_vec_rsc_1_6_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl_inst_vec_rsc_1_6_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_6_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_dp_inst_vec_rsc_1_6_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_dp_inst_vec_rsc_1_6_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_6_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_6_i_oswt(vec_rsc_1_6_i_oswt),
      .vec_rsc_1_6_i_oswt_1(vec_rsc_1_6_i_oswt_1),
      .vec_rsc_1_6_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl_inst_vec_rsc_1_6_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_ctrl_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_6_i_biwt(vec_rsc_1_6_i_biwt),
      .vec_rsc_1_6_i_bdwt(vec_rsc_1_6_i_bdwt),
      .vec_rsc_1_6_i_biwt_1(vec_rsc_1_6_i_biwt_1),
      .vec_rsc_1_6_i_bdwt_2(vec_rsc_1_6_i_bdwt_2),
      .vec_rsc_1_6_i_wea_d_core_sct(vec_rsc_1_6_i_wea_d_core_sct),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_6_i_oswt_pff(vec_rsc_1_6_i_oswt_pff),
      .vec_rsc_1_6_i_oswt_1_pff(vec_rsc_1_6_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_6_i_da_d(vec_rsc_1_6_i_da_d_reg),
      .vec_rsc_1_6_i_qa_d(vec_rsc_1_6_i_qa_d),
      .vec_rsc_1_6_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_vec_rsc_1_6_wait_dp_inst_vec_rsc_1_6_i_da_d_core[63:0]),
      .vec_rsc_1_6_i_qa_d_mxwt(vec_rsc_1_6_i_qa_d_mxwt),
      .vec_rsc_1_6_i_biwt(vec_rsc_1_6_i_biwt),
      .vec_rsc_1_6_i_bdwt(vec_rsc_1_6_i_bdwt),
      .vec_rsc_1_6_i_biwt_1(vec_rsc_1_6_i_biwt_1),
      .vec_rsc_1_6_i_bdwt_2(vec_rsc_1_6_i_bdwt_2)
    );
  assign vec_rsc_1_6_i_wea_d = vec_rsc_1_6_i_wea_d_core_sct;
  assign vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_6_i_da_d = vec_rsc_1_6_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1 (
  clk, rst, vec_rsc_1_5_i_da_d, vec_rsc_1_5_i_qa_d, vec_rsc_1_5_i_wea_d, vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_5_i_oswt,
      vec_rsc_1_5_i_oswt_1, vec_rsc_1_5_i_da_d_core, vec_rsc_1_5_i_qa_d_mxwt, vec_rsc_1_5_i_wea_d_core_psct,
      vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_5_i_oswt_pff, vec_rsc_1_5_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_5_i_da_d;
  input [63:0] vec_rsc_1_5_i_qa_d;
  output [1:0] vec_rsc_1_5_i_wea_d;
  output [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_5_i_oswt;
  input vec_rsc_1_5_i_oswt_1;
  input [63:0] vec_rsc_1_5_i_da_d_core;
  output [63:0] vec_rsc_1_5_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_5_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_5_i_oswt_pff;
  input vec_rsc_1_5_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_5_i_biwt;
  wire vec_rsc_1_5_i_bdwt;
  wire vec_rsc_1_5_i_biwt_1;
  wire vec_rsc_1_5_i_bdwt_2;
  wire [1:0] vec_rsc_1_5_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_5_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl_inst_vec_rsc_1_5_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl_inst_vec_rsc_1_5_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_5_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_dp_inst_vec_rsc_1_5_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_dp_inst_vec_rsc_1_5_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_5_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_5_i_oswt(vec_rsc_1_5_i_oswt),
      .vec_rsc_1_5_i_oswt_1(vec_rsc_1_5_i_oswt_1),
      .vec_rsc_1_5_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl_inst_vec_rsc_1_5_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_ctrl_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_5_i_biwt(vec_rsc_1_5_i_biwt),
      .vec_rsc_1_5_i_bdwt(vec_rsc_1_5_i_bdwt),
      .vec_rsc_1_5_i_biwt_1(vec_rsc_1_5_i_biwt_1),
      .vec_rsc_1_5_i_bdwt_2(vec_rsc_1_5_i_bdwt_2),
      .vec_rsc_1_5_i_wea_d_core_sct(vec_rsc_1_5_i_wea_d_core_sct),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_5_i_oswt_pff(vec_rsc_1_5_i_oswt_pff),
      .vec_rsc_1_5_i_oswt_1_pff(vec_rsc_1_5_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_5_i_da_d(vec_rsc_1_5_i_da_d_reg),
      .vec_rsc_1_5_i_qa_d(vec_rsc_1_5_i_qa_d),
      .vec_rsc_1_5_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_vec_rsc_1_5_wait_dp_inst_vec_rsc_1_5_i_da_d_core[63:0]),
      .vec_rsc_1_5_i_qa_d_mxwt(vec_rsc_1_5_i_qa_d_mxwt),
      .vec_rsc_1_5_i_biwt(vec_rsc_1_5_i_biwt),
      .vec_rsc_1_5_i_bdwt(vec_rsc_1_5_i_bdwt),
      .vec_rsc_1_5_i_biwt_1(vec_rsc_1_5_i_biwt_1),
      .vec_rsc_1_5_i_bdwt_2(vec_rsc_1_5_i_bdwt_2)
    );
  assign vec_rsc_1_5_i_wea_d = vec_rsc_1_5_i_wea_d_core_sct;
  assign vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_5_i_da_d = vec_rsc_1_5_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1 (
  clk, rst, vec_rsc_1_4_i_da_d, vec_rsc_1_4_i_qa_d, vec_rsc_1_4_i_wea_d, vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_4_i_oswt,
      vec_rsc_1_4_i_oswt_1, vec_rsc_1_4_i_da_d_core, vec_rsc_1_4_i_qa_d_mxwt, vec_rsc_1_4_i_wea_d_core_psct,
      vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_4_i_oswt_pff, vec_rsc_1_4_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_4_i_da_d;
  input [63:0] vec_rsc_1_4_i_qa_d;
  output [1:0] vec_rsc_1_4_i_wea_d;
  output [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_4_i_oswt;
  input vec_rsc_1_4_i_oswt_1;
  input [63:0] vec_rsc_1_4_i_da_d_core;
  output [63:0] vec_rsc_1_4_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_4_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_4_i_oswt_pff;
  input vec_rsc_1_4_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_4_i_biwt;
  wire vec_rsc_1_4_i_bdwt;
  wire vec_rsc_1_4_i_biwt_1;
  wire vec_rsc_1_4_i_bdwt_2;
  wire [1:0] vec_rsc_1_4_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_4_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl_inst_vec_rsc_1_4_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl_inst_vec_rsc_1_4_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_4_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_dp_inst_vec_rsc_1_4_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_dp_inst_vec_rsc_1_4_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_4_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_4_i_oswt(vec_rsc_1_4_i_oswt),
      .vec_rsc_1_4_i_oswt_1(vec_rsc_1_4_i_oswt_1),
      .vec_rsc_1_4_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl_inst_vec_rsc_1_4_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_ctrl_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_4_i_biwt(vec_rsc_1_4_i_biwt),
      .vec_rsc_1_4_i_bdwt(vec_rsc_1_4_i_bdwt),
      .vec_rsc_1_4_i_biwt_1(vec_rsc_1_4_i_biwt_1),
      .vec_rsc_1_4_i_bdwt_2(vec_rsc_1_4_i_bdwt_2),
      .vec_rsc_1_4_i_wea_d_core_sct(vec_rsc_1_4_i_wea_d_core_sct),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_4_i_oswt_pff(vec_rsc_1_4_i_oswt_pff),
      .vec_rsc_1_4_i_oswt_1_pff(vec_rsc_1_4_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_4_i_da_d(vec_rsc_1_4_i_da_d_reg),
      .vec_rsc_1_4_i_qa_d(vec_rsc_1_4_i_qa_d),
      .vec_rsc_1_4_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_vec_rsc_1_4_wait_dp_inst_vec_rsc_1_4_i_da_d_core[63:0]),
      .vec_rsc_1_4_i_qa_d_mxwt(vec_rsc_1_4_i_qa_d_mxwt),
      .vec_rsc_1_4_i_biwt(vec_rsc_1_4_i_biwt),
      .vec_rsc_1_4_i_bdwt(vec_rsc_1_4_i_bdwt),
      .vec_rsc_1_4_i_biwt_1(vec_rsc_1_4_i_biwt_1),
      .vec_rsc_1_4_i_bdwt_2(vec_rsc_1_4_i_bdwt_2)
    );
  assign vec_rsc_1_4_i_wea_d = vec_rsc_1_4_i_wea_d_core_sct;
  assign vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_4_i_da_d = vec_rsc_1_4_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1 (
  clk, rst, vec_rsc_1_3_i_da_d, vec_rsc_1_3_i_qa_d, vec_rsc_1_3_i_wea_d, vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_3_i_oswt,
      vec_rsc_1_3_i_oswt_1, vec_rsc_1_3_i_da_d_core, vec_rsc_1_3_i_qa_d_mxwt, vec_rsc_1_3_i_wea_d_core_psct,
      vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_3_i_oswt_pff, vec_rsc_1_3_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_3_i_da_d;
  input [63:0] vec_rsc_1_3_i_qa_d;
  output [1:0] vec_rsc_1_3_i_wea_d;
  output [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_3_i_oswt;
  input vec_rsc_1_3_i_oswt_1;
  input [63:0] vec_rsc_1_3_i_da_d_core;
  output [63:0] vec_rsc_1_3_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_3_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_3_i_oswt_pff;
  input vec_rsc_1_3_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_3_i_biwt;
  wire vec_rsc_1_3_i_bdwt;
  wire vec_rsc_1_3_i_biwt_1;
  wire vec_rsc_1_3_i_bdwt_2;
  wire [1:0] vec_rsc_1_3_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_3_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl_inst_vec_rsc_1_3_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl_inst_vec_rsc_1_3_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_3_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_dp_inst_vec_rsc_1_3_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_dp_inst_vec_rsc_1_3_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_3_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_3_i_oswt(vec_rsc_1_3_i_oswt),
      .vec_rsc_1_3_i_oswt_1(vec_rsc_1_3_i_oswt_1),
      .vec_rsc_1_3_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl_inst_vec_rsc_1_3_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_ctrl_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_3_i_biwt(vec_rsc_1_3_i_biwt),
      .vec_rsc_1_3_i_bdwt(vec_rsc_1_3_i_bdwt),
      .vec_rsc_1_3_i_biwt_1(vec_rsc_1_3_i_biwt_1),
      .vec_rsc_1_3_i_bdwt_2(vec_rsc_1_3_i_bdwt_2),
      .vec_rsc_1_3_i_wea_d_core_sct(vec_rsc_1_3_i_wea_d_core_sct),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_3_i_oswt_pff(vec_rsc_1_3_i_oswt_pff),
      .vec_rsc_1_3_i_oswt_1_pff(vec_rsc_1_3_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_3_i_da_d(vec_rsc_1_3_i_da_d_reg),
      .vec_rsc_1_3_i_qa_d(vec_rsc_1_3_i_qa_d),
      .vec_rsc_1_3_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_vec_rsc_1_3_wait_dp_inst_vec_rsc_1_3_i_da_d_core[63:0]),
      .vec_rsc_1_3_i_qa_d_mxwt(vec_rsc_1_3_i_qa_d_mxwt),
      .vec_rsc_1_3_i_biwt(vec_rsc_1_3_i_biwt),
      .vec_rsc_1_3_i_bdwt(vec_rsc_1_3_i_bdwt),
      .vec_rsc_1_3_i_biwt_1(vec_rsc_1_3_i_biwt_1),
      .vec_rsc_1_3_i_bdwt_2(vec_rsc_1_3_i_bdwt_2)
    );
  assign vec_rsc_1_3_i_wea_d = vec_rsc_1_3_i_wea_d_core_sct;
  assign vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_3_i_da_d = vec_rsc_1_3_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1 (
  clk, rst, vec_rsc_1_2_i_da_d, vec_rsc_1_2_i_qa_d, vec_rsc_1_2_i_wea_d, vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_2_i_oswt,
      vec_rsc_1_2_i_oswt_1, vec_rsc_1_2_i_da_d_core, vec_rsc_1_2_i_qa_d_mxwt, vec_rsc_1_2_i_wea_d_core_psct,
      vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_2_i_oswt_pff, vec_rsc_1_2_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_2_i_da_d;
  input [63:0] vec_rsc_1_2_i_qa_d;
  output [1:0] vec_rsc_1_2_i_wea_d;
  output [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_2_i_oswt;
  input vec_rsc_1_2_i_oswt_1;
  input [63:0] vec_rsc_1_2_i_da_d_core;
  output [63:0] vec_rsc_1_2_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_2_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_2_i_oswt_pff;
  input vec_rsc_1_2_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_2_i_biwt;
  wire vec_rsc_1_2_i_bdwt;
  wire vec_rsc_1_2_i_biwt_1;
  wire vec_rsc_1_2_i_bdwt_2;
  wire [1:0] vec_rsc_1_2_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_2_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl_inst_vec_rsc_1_2_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl_inst_vec_rsc_1_2_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_2_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_dp_inst_vec_rsc_1_2_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_dp_inst_vec_rsc_1_2_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_2_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_2_i_oswt(vec_rsc_1_2_i_oswt),
      .vec_rsc_1_2_i_oswt_1(vec_rsc_1_2_i_oswt_1),
      .vec_rsc_1_2_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl_inst_vec_rsc_1_2_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_ctrl_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_2_i_biwt(vec_rsc_1_2_i_biwt),
      .vec_rsc_1_2_i_bdwt(vec_rsc_1_2_i_bdwt),
      .vec_rsc_1_2_i_biwt_1(vec_rsc_1_2_i_biwt_1),
      .vec_rsc_1_2_i_bdwt_2(vec_rsc_1_2_i_bdwt_2),
      .vec_rsc_1_2_i_wea_d_core_sct(vec_rsc_1_2_i_wea_d_core_sct),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_2_i_oswt_pff(vec_rsc_1_2_i_oswt_pff),
      .vec_rsc_1_2_i_oswt_1_pff(vec_rsc_1_2_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_2_i_da_d(vec_rsc_1_2_i_da_d_reg),
      .vec_rsc_1_2_i_qa_d(vec_rsc_1_2_i_qa_d),
      .vec_rsc_1_2_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_vec_rsc_1_2_wait_dp_inst_vec_rsc_1_2_i_da_d_core[63:0]),
      .vec_rsc_1_2_i_qa_d_mxwt(vec_rsc_1_2_i_qa_d_mxwt),
      .vec_rsc_1_2_i_biwt(vec_rsc_1_2_i_biwt),
      .vec_rsc_1_2_i_bdwt(vec_rsc_1_2_i_bdwt),
      .vec_rsc_1_2_i_biwt_1(vec_rsc_1_2_i_biwt_1),
      .vec_rsc_1_2_i_bdwt_2(vec_rsc_1_2_i_bdwt_2)
    );
  assign vec_rsc_1_2_i_wea_d = vec_rsc_1_2_i_wea_d_core_sct;
  assign vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_2_i_da_d = vec_rsc_1_2_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1 (
  clk, rst, vec_rsc_1_1_i_da_d, vec_rsc_1_1_i_qa_d, vec_rsc_1_1_i_wea_d, vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_1_i_oswt,
      vec_rsc_1_1_i_oswt_1, vec_rsc_1_1_i_da_d_core, vec_rsc_1_1_i_qa_d_mxwt, vec_rsc_1_1_i_wea_d_core_psct,
      vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_1_i_oswt_pff, vec_rsc_1_1_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_1_i_da_d;
  input [63:0] vec_rsc_1_1_i_qa_d;
  output [1:0] vec_rsc_1_1_i_wea_d;
  output [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_1_i_oswt;
  input vec_rsc_1_1_i_oswt_1;
  input [63:0] vec_rsc_1_1_i_da_d_core;
  output [63:0] vec_rsc_1_1_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_1_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_1_i_oswt_pff;
  input vec_rsc_1_1_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_1_i_biwt;
  wire vec_rsc_1_1_i_bdwt;
  wire vec_rsc_1_1_i_biwt_1;
  wire vec_rsc_1_1_i_bdwt_2;
  wire [1:0] vec_rsc_1_1_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_1_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl_inst_vec_rsc_1_1_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl_inst_vec_rsc_1_1_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_1_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_dp_inst_vec_rsc_1_1_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_dp_inst_vec_rsc_1_1_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_1_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_1_i_oswt(vec_rsc_1_1_i_oswt),
      .vec_rsc_1_1_i_oswt_1(vec_rsc_1_1_i_oswt_1),
      .vec_rsc_1_1_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl_inst_vec_rsc_1_1_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_ctrl_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_1_i_biwt(vec_rsc_1_1_i_biwt),
      .vec_rsc_1_1_i_bdwt(vec_rsc_1_1_i_bdwt),
      .vec_rsc_1_1_i_biwt_1(vec_rsc_1_1_i_biwt_1),
      .vec_rsc_1_1_i_bdwt_2(vec_rsc_1_1_i_bdwt_2),
      .vec_rsc_1_1_i_wea_d_core_sct(vec_rsc_1_1_i_wea_d_core_sct),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_1_i_oswt_pff(vec_rsc_1_1_i_oswt_pff),
      .vec_rsc_1_1_i_oswt_1_pff(vec_rsc_1_1_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_1_i_da_d(vec_rsc_1_1_i_da_d_reg),
      .vec_rsc_1_1_i_qa_d(vec_rsc_1_1_i_qa_d),
      .vec_rsc_1_1_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_vec_rsc_1_1_wait_dp_inst_vec_rsc_1_1_i_da_d_core[63:0]),
      .vec_rsc_1_1_i_qa_d_mxwt(vec_rsc_1_1_i_qa_d_mxwt),
      .vec_rsc_1_1_i_biwt(vec_rsc_1_1_i_biwt),
      .vec_rsc_1_1_i_bdwt(vec_rsc_1_1_i_bdwt),
      .vec_rsc_1_1_i_biwt_1(vec_rsc_1_1_i_biwt_1),
      .vec_rsc_1_1_i_bdwt_2(vec_rsc_1_1_i_bdwt_2)
    );
  assign vec_rsc_1_1_i_wea_d = vec_rsc_1_1_i_wea_d_core_sct;
  assign vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_1_i_da_d = vec_rsc_1_1_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1 (
  clk, rst, vec_rsc_1_0_i_da_d, vec_rsc_1_0_i_qa_d, vec_rsc_1_0_i_wea_d, vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_1_0_i_oswt,
      vec_rsc_1_0_i_oswt_1, vec_rsc_1_0_i_da_d_core, vec_rsc_1_0_i_qa_d_mxwt, vec_rsc_1_0_i_wea_d_core_psct,
      vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_1_0_i_oswt_pff, vec_rsc_1_0_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_1_0_i_da_d;
  input [63:0] vec_rsc_1_0_i_qa_d;
  output [1:0] vec_rsc_1_0_i_wea_d;
  output [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_1_0_i_oswt;
  input vec_rsc_1_0_i_oswt_1;
  input [63:0] vec_rsc_1_0_i_da_d_core;
  output [63:0] vec_rsc_1_0_i_qa_d_mxwt;
  input [1:0] vec_rsc_1_0_i_wea_d_core_psct;
  input [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_1_0_i_oswt_pff;
  input vec_rsc_1_0_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_1_0_i_biwt;
  wire vec_rsc_1_0_i_bdwt;
  wire vec_rsc_1_0_i_biwt_1;
  wire vec_rsc_1_0_i_bdwt_2;
  wire [1:0] vec_rsc_1_0_i_wea_d_core_sct;
  wire [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_1_0_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl_inst_vec_rsc_1_0_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl_inst_vec_rsc_1_0_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_1_0_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_dp_inst_vec_rsc_1_0_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_dp_inst_vec_rsc_1_0_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_1_0_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_1_0_i_oswt(vec_rsc_1_0_i_oswt),
      .vec_rsc_1_0_i_oswt_1(vec_rsc_1_0_i_oswt_1),
      .vec_rsc_1_0_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl_inst_vec_rsc_1_0_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_ctrl_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_0_i_biwt(vec_rsc_1_0_i_biwt),
      .vec_rsc_1_0_i_bdwt(vec_rsc_1_0_i_bdwt),
      .vec_rsc_1_0_i_biwt_1(vec_rsc_1_0_i_biwt_1),
      .vec_rsc_1_0_i_bdwt_2(vec_rsc_1_0_i_bdwt_2),
      .vec_rsc_1_0_i_wea_d_core_sct(vec_rsc_1_0_i_wea_d_core_sct),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_1_0_i_oswt_pff(vec_rsc_1_0_i_oswt_pff),
      .vec_rsc_1_0_i_oswt_1_pff(vec_rsc_1_0_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_0_i_da_d(vec_rsc_1_0_i_da_d_reg),
      .vec_rsc_1_0_i_qa_d(vec_rsc_1_0_i_qa_d),
      .vec_rsc_1_0_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_vec_rsc_1_0_wait_dp_inst_vec_rsc_1_0_i_da_d_core[63:0]),
      .vec_rsc_1_0_i_qa_d_mxwt(vec_rsc_1_0_i_qa_d_mxwt),
      .vec_rsc_1_0_i_biwt(vec_rsc_1_0_i_biwt),
      .vec_rsc_1_0_i_bdwt(vec_rsc_1_0_i_bdwt),
      .vec_rsc_1_0_i_biwt_1(vec_rsc_1_0_i_biwt_1),
      .vec_rsc_1_0_i_bdwt_2(vec_rsc_1_0_i_bdwt_2)
    );
  assign vec_rsc_1_0_i_wea_d = vec_rsc_1_0_i_wea_d_core_sct;
  assign vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_1_0_i_da_d = vec_rsc_1_0_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1 (
  clk, rst, vec_rsc_0_7_i_da_d, vec_rsc_0_7_i_qa_d, vec_rsc_0_7_i_wea_d, vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_7_i_oswt,
      vec_rsc_0_7_i_oswt_1, vec_rsc_0_7_i_da_d_core, vec_rsc_0_7_i_qa_d_mxwt, vec_rsc_0_7_i_wea_d_core_psct,
      vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_7_i_oswt_pff, vec_rsc_0_7_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_7_i_da_d;
  input [63:0] vec_rsc_0_7_i_qa_d;
  output [1:0] vec_rsc_0_7_i_wea_d;
  output [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_7_i_oswt;
  input vec_rsc_0_7_i_oswt_1;
  input [63:0] vec_rsc_0_7_i_da_d_core;
  output [63:0] vec_rsc_0_7_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_7_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_7_i_oswt_pff;
  input vec_rsc_0_7_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_7_i_biwt;
  wire vec_rsc_0_7_i_bdwt;
  wire vec_rsc_0_7_i_biwt_1;
  wire vec_rsc_0_7_i_bdwt_2;
  wire [1:0] vec_rsc_0_7_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_7_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl_inst_vec_rsc_0_7_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl_inst_vec_rsc_0_7_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_7_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_dp_inst_vec_rsc_0_7_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_dp_inst_vec_rsc_0_7_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_7_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_7_i_oswt(vec_rsc_0_7_i_oswt),
      .vec_rsc_0_7_i_oswt_1(vec_rsc_0_7_i_oswt_1),
      .vec_rsc_0_7_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl_inst_vec_rsc_0_7_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_ctrl_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_7_i_biwt(vec_rsc_0_7_i_biwt),
      .vec_rsc_0_7_i_bdwt(vec_rsc_0_7_i_bdwt),
      .vec_rsc_0_7_i_biwt_1(vec_rsc_0_7_i_biwt_1),
      .vec_rsc_0_7_i_bdwt_2(vec_rsc_0_7_i_bdwt_2),
      .vec_rsc_0_7_i_wea_d_core_sct(vec_rsc_0_7_i_wea_d_core_sct),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_7_i_oswt_pff(vec_rsc_0_7_i_oswt_pff),
      .vec_rsc_0_7_i_oswt_1_pff(vec_rsc_0_7_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_7_i_da_d(vec_rsc_0_7_i_da_d_reg),
      .vec_rsc_0_7_i_qa_d(vec_rsc_0_7_i_qa_d),
      .vec_rsc_0_7_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_vec_rsc_0_7_wait_dp_inst_vec_rsc_0_7_i_da_d_core[63:0]),
      .vec_rsc_0_7_i_qa_d_mxwt(vec_rsc_0_7_i_qa_d_mxwt),
      .vec_rsc_0_7_i_biwt(vec_rsc_0_7_i_biwt),
      .vec_rsc_0_7_i_bdwt(vec_rsc_0_7_i_bdwt),
      .vec_rsc_0_7_i_biwt_1(vec_rsc_0_7_i_biwt_1),
      .vec_rsc_0_7_i_bdwt_2(vec_rsc_0_7_i_bdwt_2)
    );
  assign vec_rsc_0_7_i_wea_d = vec_rsc_0_7_i_wea_d_core_sct;
  assign vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_7_i_da_d = vec_rsc_0_7_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1 (
  clk, rst, vec_rsc_0_6_i_da_d, vec_rsc_0_6_i_qa_d, vec_rsc_0_6_i_wea_d, vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_6_i_oswt,
      vec_rsc_0_6_i_oswt_1, vec_rsc_0_6_i_da_d_core, vec_rsc_0_6_i_qa_d_mxwt, vec_rsc_0_6_i_wea_d_core_psct,
      vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_6_i_oswt_pff, vec_rsc_0_6_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_6_i_da_d;
  input [63:0] vec_rsc_0_6_i_qa_d;
  output [1:0] vec_rsc_0_6_i_wea_d;
  output [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_6_i_oswt;
  input vec_rsc_0_6_i_oswt_1;
  input [63:0] vec_rsc_0_6_i_da_d_core;
  output [63:0] vec_rsc_0_6_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_6_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_6_i_oswt_pff;
  input vec_rsc_0_6_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_6_i_biwt;
  wire vec_rsc_0_6_i_bdwt;
  wire vec_rsc_0_6_i_biwt_1;
  wire vec_rsc_0_6_i_bdwt_2;
  wire [1:0] vec_rsc_0_6_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_6_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl_inst_vec_rsc_0_6_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl_inst_vec_rsc_0_6_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_6_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_dp_inst_vec_rsc_0_6_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_dp_inst_vec_rsc_0_6_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_6_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_6_i_oswt(vec_rsc_0_6_i_oswt),
      .vec_rsc_0_6_i_oswt_1(vec_rsc_0_6_i_oswt_1),
      .vec_rsc_0_6_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl_inst_vec_rsc_0_6_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_ctrl_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_6_i_biwt(vec_rsc_0_6_i_biwt),
      .vec_rsc_0_6_i_bdwt(vec_rsc_0_6_i_bdwt),
      .vec_rsc_0_6_i_biwt_1(vec_rsc_0_6_i_biwt_1),
      .vec_rsc_0_6_i_bdwt_2(vec_rsc_0_6_i_bdwt_2),
      .vec_rsc_0_6_i_wea_d_core_sct(vec_rsc_0_6_i_wea_d_core_sct),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_6_i_oswt_pff(vec_rsc_0_6_i_oswt_pff),
      .vec_rsc_0_6_i_oswt_1_pff(vec_rsc_0_6_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_6_i_da_d(vec_rsc_0_6_i_da_d_reg),
      .vec_rsc_0_6_i_qa_d(vec_rsc_0_6_i_qa_d),
      .vec_rsc_0_6_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_vec_rsc_0_6_wait_dp_inst_vec_rsc_0_6_i_da_d_core[63:0]),
      .vec_rsc_0_6_i_qa_d_mxwt(vec_rsc_0_6_i_qa_d_mxwt),
      .vec_rsc_0_6_i_biwt(vec_rsc_0_6_i_biwt),
      .vec_rsc_0_6_i_bdwt(vec_rsc_0_6_i_bdwt),
      .vec_rsc_0_6_i_biwt_1(vec_rsc_0_6_i_biwt_1),
      .vec_rsc_0_6_i_bdwt_2(vec_rsc_0_6_i_bdwt_2)
    );
  assign vec_rsc_0_6_i_wea_d = vec_rsc_0_6_i_wea_d_core_sct;
  assign vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_6_i_da_d = vec_rsc_0_6_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1 (
  clk, rst, vec_rsc_0_5_i_da_d, vec_rsc_0_5_i_qa_d, vec_rsc_0_5_i_wea_d, vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_5_i_oswt,
      vec_rsc_0_5_i_oswt_1, vec_rsc_0_5_i_da_d_core, vec_rsc_0_5_i_qa_d_mxwt, vec_rsc_0_5_i_wea_d_core_psct,
      vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_5_i_oswt_pff, vec_rsc_0_5_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_5_i_da_d;
  input [63:0] vec_rsc_0_5_i_qa_d;
  output [1:0] vec_rsc_0_5_i_wea_d;
  output [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_5_i_oswt;
  input vec_rsc_0_5_i_oswt_1;
  input [63:0] vec_rsc_0_5_i_da_d_core;
  output [63:0] vec_rsc_0_5_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_5_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_5_i_oswt_pff;
  input vec_rsc_0_5_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_5_i_biwt;
  wire vec_rsc_0_5_i_bdwt;
  wire vec_rsc_0_5_i_biwt_1;
  wire vec_rsc_0_5_i_bdwt_2;
  wire [1:0] vec_rsc_0_5_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_5_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl_inst_vec_rsc_0_5_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl_inst_vec_rsc_0_5_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_5_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_dp_inst_vec_rsc_0_5_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_dp_inst_vec_rsc_0_5_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_5_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_5_i_oswt(vec_rsc_0_5_i_oswt),
      .vec_rsc_0_5_i_oswt_1(vec_rsc_0_5_i_oswt_1),
      .vec_rsc_0_5_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl_inst_vec_rsc_0_5_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_ctrl_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_5_i_biwt(vec_rsc_0_5_i_biwt),
      .vec_rsc_0_5_i_bdwt(vec_rsc_0_5_i_bdwt),
      .vec_rsc_0_5_i_biwt_1(vec_rsc_0_5_i_biwt_1),
      .vec_rsc_0_5_i_bdwt_2(vec_rsc_0_5_i_bdwt_2),
      .vec_rsc_0_5_i_wea_d_core_sct(vec_rsc_0_5_i_wea_d_core_sct),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_5_i_oswt_pff(vec_rsc_0_5_i_oswt_pff),
      .vec_rsc_0_5_i_oswt_1_pff(vec_rsc_0_5_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_5_i_da_d(vec_rsc_0_5_i_da_d_reg),
      .vec_rsc_0_5_i_qa_d(vec_rsc_0_5_i_qa_d),
      .vec_rsc_0_5_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_vec_rsc_0_5_wait_dp_inst_vec_rsc_0_5_i_da_d_core[63:0]),
      .vec_rsc_0_5_i_qa_d_mxwt(vec_rsc_0_5_i_qa_d_mxwt),
      .vec_rsc_0_5_i_biwt(vec_rsc_0_5_i_biwt),
      .vec_rsc_0_5_i_bdwt(vec_rsc_0_5_i_bdwt),
      .vec_rsc_0_5_i_biwt_1(vec_rsc_0_5_i_biwt_1),
      .vec_rsc_0_5_i_bdwt_2(vec_rsc_0_5_i_bdwt_2)
    );
  assign vec_rsc_0_5_i_wea_d = vec_rsc_0_5_i_wea_d_core_sct;
  assign vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_5_i_da_d = vec_rsc_0_5_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1 (
  clk, rst, vec_rsc_0_4_i_da_d, vec_rsc_0_4_i_qa_d, vec_rsc_0_4_i_wea_d, vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_4_i_oswt,
      vec_rsc_0_4_i_oswt_1, vec_rsc_0_4_i_da_d_core, vec_rsc_0_4_i_qa_d_mxwt, vec_rsc_0_4_i_wea_d_core_psct,
      vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_4_i_oswt_pff, vec_rsc_0_4_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_4_i_da_d;
  input [63:0] vec_rsc_0_4_i_qa_d;
  output [1:0] vec_rsc_0_4_i_wea_d;
  output [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_4_i_oswt;
  input vec_rsc_0_4_i_oswt_1;
  input [63:0] vec_rsc_0_4_i_da_d_core;
  output [63:0] vec_rsc_0_4_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_4_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_4_i_oswt_pff;
  input vec_rsc_0_4_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_4_i_biwt;
  wire vec_rsc_0_4_i_bdwt;
  wire vec_rsc_0_4_i_biwt_1;
  wire vec_rsc_0_4_i_bdwt_2;
  wire [1:0] vec_rsc_0_4_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_4_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl_inst_vec_rsc_0_4_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl_inst_vec_rsc_0_4_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_4_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_dp_inst_vec_rsc_0_4_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_dp_inst_vec_rsc_0_4_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_4_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_4_i_oswt(vec_rsc_0_4_i_oswt),
      .vec_rsc_0_4_i_oswt_1(vec_rsc_0_4_i_oswt_1),
      .vec_rsc_0_4_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl_inst_vec_rsc_0_4_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_ctrl_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_4_i_biwt(vec_rsc_0_4_i_biwt),
      .vec_rsc_0_4_i_bdwt(vec_rsc_0_4_i_bdwt),
      .vec_rsc_0_4_i_biwt_1(vec_rsc_0_4_i_biwt_1),
      .vec_rsc_0_4_i_bdwt_2(vec_rsc_0_4_i_bdwt_2),
      .vec_rsc_0_4_i_wea_d_core_sct(vec_rsc_0_4_i_wea_d_core_sct),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_4_i_oswt_pff(vec_rsc_0_4_i_oswt_pff),
      .vec_rsc_0_4_i_oswt_1_pff(vec_rsc_0_4_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_4_i_da_d(vec_rsc_0_4_i_da_d_reg),
      .vec_rsc_0_4_i_qa_d(vec_rsc_0_4_i_qa_d),
      .vec_rsc_0_4_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_vec_rsc_0_4_wait_dp_inst_vec_rsc_0_4_i_da_d_core[63:0]),
      .vec_rsc_0_4_i_qa_d_mxwt(vec_rsc_0_4_i_qa_d_mxwt),
      .vec_rsc_0_4_i_biwt(vec_rsc_0_4_i_biwt),
      .vec_rsc_0_4_i_bdwt(vec_rsc_0_4_i_bdwt),
      .vec_rsc_0_4_i_biwt_1(vec_rsc_0_4_i_biwt_1),
      .vec_rsc_0_4_i_bdwt_2(vec_rsc_0_4_i_bdwt_2)
    );
  assign vec_rsc_0_4_i_wea_d = vec_rsc_0_4_i_wea_d_core_sct;
  assign vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_4_i_da_d = vec_rsc_0_4_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1 (
  clk, rst, vec_rsc_0_3_i_da_d, vec_rsc_0_3_i_qa_d, vec_rsc_0_3_i_wea_d, vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_3_i_oswt,
      vec_rsc_0_3_i_oswt_1, vec_rsc_0_3_i_da_d_core, vec_rsc_0_3_i_qa_d_mxwt, vec_rsc_0_3_i_wea_d_core_psct,
      vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_3_i_oswt_pff, vec_rsc_0_3_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_3_i_da_d;
  input [63:0] vec_rsc_0_3_i_qa_d;
  output [1:0] vec_rsc_0_3_i_wea_d;
  output [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_3_i_oswt;
  input vec_rsc_0_3_i_oswt_1;
  input [63:0] vec_rsc_0_3_i_da_d_core;
  output [63:0] vec_rsc_0_3_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_3_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_3_i_oswt_pff;
  input vec_rsc_0_3_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_3_i_biwt;
  wire vec_rsc_0_3_i_bdwt;
  wire vec_rsc_0_3_i_biwt_1;
  wire vec_rsc_0_3_i_bdwt_2;
  wire [1:0] vec_rsc_0_3_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_3_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl_inst_vec_rsc_0_3_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl_inst_vec_rsc_0_3_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_3_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_dp_inst_vec_rsc_0_3_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_dp_inst_vec_rsc_0_3_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_3_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_3_i_oswt(vec_rsc_0_3_i_oswt),
      .vec_rsc_0_3_i_oswt_1(vec_rsc_0_3_i_oswt_1),
      .vec_rsc_0_3_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl_inst_vec_rsc_0_3_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_ctrl_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_3_i_biwt(vec_rsc_0_3_i_biwt),
      .vec_rsc_0_3_i_bdwt(vec_rsc_0_3_i_bdwt),
      .vec_rsc_0_3_i_biwt_1(vec_rsc_0_3_i_biwt_1),
      .vec_rsc_0_3_i_bdwt_2(vec_rsc_0_3_i_bdwt_2),
      .vec_rsc_0_3_i_wea_d_core_sct(vec_rsc_0_3_i_wea_d_core_sct),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_3_i_oswt_pff(vec_rsc_0_3_i_oswt_pff),
      .vec_rsc_0_3_i_oswt_1_pff(vec_rsc_0_3_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_3_i_da_d(vec_rsc_0_3_i_da_d_reg),
      .vec_rsc_0_3_i_qa_d(vec_rsc_0_3_i_qa_d),
      .vec_rsc_0_3_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_vec_rsc_0_3_wait_dp_inst_vec_rsc_0_3_i_da_d_core[63:0]),
      .vec_rsc_0_3_i_qa_d_mxwt(vec_rsc_0_3_i_qa_d_mxwt),
      .vec_rsc_0_3_i_biwt(vec_rsc_0_3_i_biwt),
      .vec_rsc_0_3_i_bdwt(vec_rsc_0_3_i_bdwt),
      .vec_rsc_0_3_i_biwt_1(vec_rsc_0_3_i_biwt_1),
      .vec_rsc_0_3_i_bdwt_2(vec_rsc_0_3_i_bdwt_2)
    );
  assign vec_rsc_0_3_i_wea_d = vec_rsc_0_3_i_wea_d_core_sct;
  assign vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_3_i_da_d = vec_rsc_0_3_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1 (
  clk, rst, vec_rsc_0_2_i_da_d, vec_rsc_0_2_i_qa_d, vec_rsc_0_2_i_wea_d, vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_2_i_oswt,
      vec_rsc_0_2_i_oswt_1, vec_rsc_0_2_i_da_d_core, vec_rsc_0_2_i_qa_d_mxwt, vec_rsc_0_2_i_wea_d_core_psct,
      vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_2_i_oswt_pff, vec_rsc_0_2_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_2_i_da_d;
  input [63:0] vec_rsc_0_2_i_qa_d;
  output [1:0] vec_rsc_0_2_i_wea_d;
  output [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_2_i_oswt;
  input vec_rsc_0_2_i_oswt_1;
  input [63:0] vec_rsc_0_2_i_da_d_core;
  output [63:0] vec_rsc_0_2_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_2_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_2_i_oswt_pff;
  input vec_rsc_0_2_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_2_i_biwt;
  wire vec_rsc_0_2_i_bdwt;
  wire vec_rsc_0_2_i_biwt_1;
  wire vec_rsc_0_2_i_bdwt_2;
  wire [1:0] vec_rsc_0_2_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_2_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl_inst_vec_rsc_0_2_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl_inst_vec_rsc_0_2_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_2_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_dp_inst_vec_rsc_0_2_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_dp_inst_vec_rsc_0_2_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_2_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_2_i_oswt(vec_rsc_0_2_i_oswt),
      .vec_rsc_0_2_i_oswt_1(vec_rsc_0_2_i_oswt_1),
      .vec_rsc_0_2_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl_inst_vec_rsc_0_2_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_ctrl_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_2_i_biwt(vec_rsc_0_2_i_biwt),
      .vec_rsc_0_2_i_bdwt(vec_rsc_0_2_i_bdwt),
      .vec_rsc_0_2_i_biwt_1(vec_rsc_0_2_i_biwt_1),
      .vec_rsc_0_2_i_bdwt_2(vec_rsc_0_2_i_bdwt_2),
      .vec_rsc_0_2_i_wea_d_core_sct(vec_rsc_0_2_i_wea_d_core_sct),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_2_i_oswt_pff(vec_rsc_0_2_i_oswt_pff),
      .vec_rsc_0_2_i_oswt_1_pff(vec_rsc_0_2_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_2_i_da_d(vec_rsc_0_2_i_da_d_reg),
      .vec_rsc_0_2_i_qa_d(vec_rsc_0_2_i_qa_d),
      .vec_rsc_0_2_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_vec_rsc_0_2_wait_dp_inst_vec_rsc_0_2_i_da_d_core[63:0]),
      .vec_rsc_0_2_i_qa_d_mxwt(vec_rsc_0_2_i_qa_d_mxwt),
      .vec_rsc_0_2_i_biwt(vec_rsc_0_2_i_biwt),
      .vec_rsc_0_2_i_bdwt(vec_rsc_0_2_i_bdwt),
      .vec_rsc_0_2_i_biwt_1(vec_rsc_0_2_i_biwt_1),
      .vec_rsc_0_2_i_bdwt_2(vec_rsc_0_2_i_bdwt_2)
    );
  assign vec_rsc_0_2_i_wea_d = vec_rsc_0_2_i_wea_d_core_sct;
  assign vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_2_i_da_d = vec_rsc_0_2_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1 (
  clk, rst, vec_rsc_0_1_i_da_d, vec_rsc_0_1_i_qa_d, vec_rsc_0_1_i_wea_d, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_1_i_oswt,
      vec_rsc_0_1_i_oswt_1, vec_rsc_0_1_i_da_d_core, vec_rsc_0_1_i_qa_d_mxwt, vec_rsc_0_1_i_wea_d_core_psct,
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_1_i_oswt_pff, vec_rsc_0_1_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_1_i_da_d;
  input [63:0] vec_rsc_0_1_i_qa_d;
  output [1:0] vec_rsc_0_1_i_wea_d;
  output [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_1_i_oswt;
  input vec_rsc_0_1_i_oswt_1;
  input [63:0] vec_rsc_0_1_i_da_d_core;
  output [63:0] vec_rsc_0_1_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_1_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_1_i_oswt_pff;
  input vec_rsc_0_1_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_1_i_biwt;
  wire vec_rsc_0_1_i_bdwt;
  wire vec_rsc_0_1_i_biwt_1;
  wire vec_rsc_0_1_i_bdwt_2;
  wire [1:0] vec_rsc_0_1_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_1_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl_inst_vec_rsc_0_1_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl_inst_vec_rsc_0_1_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_1_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_1_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_1_i_oswt(vec_rsc_0_1_i_oswt),
      .vec_rsc_0_1_i_oswt_1(vec_rsc_0_1_i_oswt_1),
      .vec_rsc_0_1_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl_inst_vec_rsc_0_1_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_ctrl_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_1_i_biwt(vec_rsc_0_1_i_biwt),
      .vec_rsc_0_1_i_bdwt(vec_rsc_0_1_i_bdwt),
      .vec_rsc_0_1_i_biwt_1(vec_rsc_0_1_i_biwt_1),
      .vec_rsc_0_1_i_bdwt_2(vec_rsc_0_1_i_bdwt_2),
      .vec_rsc_0_1_i_wea_d_core_sct(vec_rsc_0_1_i_wea_d_core_sct),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_1_i_oswt_pff(vec_rsc_0_1_i_oswt_pff),
      .vec_rsc_0_1_i_oswt_1_pff(vec_rsc_0_1_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_1_i_da_d(vec_rsc_0_1_i_da_d_reg),
      .vec_rsc_0_1_i_qa_d(vec_rsc_0_1_i_qa_d),
      .vec_rsc_0_1_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_vec_rsc_0_1_wait_dp_inst_vec_rsc_0_1_i_da_d_core[63:0]),
      .vec_rsc_0_1_i_qa_d_mxwt(vec_rsc_0_1_i_qa_d_mxwt),
      .vec_rsc_0_1_i_biwt(vec_rsc_0_1_i_biwt),
      .vec_rsc_0_1_i_bdwt(vec_rsc_0_1_i_bdwt),
      .vec_rsc_0_1_i_biwt_1(vec_rsc_0_1_i_biwt_1),
      .vec_rsc_0_1_i_bdwt_2(vec_rsc_0_1_i_bdwt_2)
    );
  assign vec_rsc_0_1_i_wea_d = vec_rsc_0_1_i_wea_d_core_sct;
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_1_i_da_d = vec_rsc_0_1_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1 (
  clk, rst, vec_rsc_0_0_i_da_d, vec_rsc_0_0_i_qa_d, vec_rsc_0_0_i_wea_d, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsc_0_0_i_oswt,
      vec_rsc_0_0_i_oswt_1, vec_rsc_0_0_i_da_d_core, vec_rsc_0_0_i_qa_d_mxwt, vec_rsc_0_0_i_wea_d_core_psct,
      vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsc_0_0_i_oswt_pff, vec_rsc_0_0_i_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsc_0_0_i_da_d;
  input [63:0] vec_rsc_0_0_i_qa_d;
  output [1:0] vec_rsc_0_0_i_wea_d;
  output [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsc_0_0_i_oswt;
  input vec_rsc_0_0_i_oswt_1;
  input [63:0] vec_rsc_0_0_i_da_d_core;
  output [63:0] vec_rsc_0_0_i_qa_d_mxwt;
  input [1:0] vec_rsc_0_0_i_wea_d_core_psct;
  input [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsc_0_0_i_oswt_pff;
  input vec_rsc_0_0_i_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsc_0_0_i_biwt;
  wire vec_rsc_0_0_i_bdwt;
  wire vec_rsc_0_0_i_biwt_1;
  wire vec_rsc_0_0_i_bdwt_2;
  wire [1:0] vec_rsc_0_0_i_wea_d_core_sct;
  wire [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsc_0_0_i_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl_inst_vec_rsc_0_0_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl_inst_vec_rsc_0_0_i_wea_d_core_psct
      = {1'b0 , (vec_rsc_0_0_i_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsc_0_0_i_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsc_0_0_i_oswt(vec_rsc_0_0_i_oswt),
      .vec_rsc_0_0_i_oswt_1(vec_rsc_0_0_i_oswt_1),
      .vec_rsc_0_0_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl_inst_vec_rsc_0_0_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_ctrl_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_0_i_biwt(vec_rsc_0_0_i_biwt),
      .vec_rsc_0_0_i_bdwt(vec_rsc_0_0_i_bdwt),
      .vec_rsc_0_0_i_biwt_1(vec_rsc_0_0_i_biwt_1),
      .vec_rsc_0_0_i_bdwt_2(vec_rsc_0_0_i_bdwt_2),
      .vec_rsc_0_0_i_wea_d_core_sct(vec_rsc_0_0_i_wea_d_core_sct),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsc_0_0_i_oswt_pff(vec_rsc_0_0_i_oswt_pff),
      .vec_rsc_0_0_i_oswt_1_pff(vec_rsc_0_0_i_oswt_1_pff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_0_i_da_d(vec_rsc_0_0_i_da_d_reg),
      .vec_rsc_0_0_i_qa_d(vec_rsc_0_0_i_qa_d),
      .vec_rsc_0_0_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_vec_rsc_0_0_wait_dp_inst_vec_rsc_0_0_i_da_d_core[63:0]),
      .vec_rsc_0_0_i_qa_d_mxwt(vec_rsc_0_0_i_qa_d_mxwt),
      .vec_rsc_0_0_i_biwt(vec_rsc_0_0_i_biwt),
      .vec_rsc_0_0_i_bdwt(vec_rsc_0_0_i_bdwt),
      .vec_rsc_0_0_i_biwt_1(vec_rsc_0_0_i_biwt_1),
      .vec_rsc_0_0_i_bdwt_2(vec_rsc_0_0_i_bdwt_2)
    );
  assign vec_rsc_0_0_i_wea_d = vec_rsc_0_0_i_wea_d_core_sct;
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsc_0_0_i_da_d = vec_rsc_0_0_i_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_complete_rsci
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_complete_rsci (
  clk, rst, complete_rsc_rdy, complete_rsc_vld, core_wen, complete_rsci_oswt, complete_rsci_wen_comp
);
  input clk;
  input rst;
  input complete_rsc_rdy;
  output complete_rsc_vld;
  input core_wen;
  input complete_rsci_oswt;
  output complete_rsci_wen_comp;


  // Interconnect Declarations
  wire complete_rsci_biwt;
  wire complete_rsci_bdwt;
  wire complete_rsci_bcwt;
  wire complete_rsci_ivld_core_sct;
  wire complete_rsci_irdy;


  // Interconnect Declarations for Component Instantiations 
  ccs_sync_out_wait_v1 #(.rscid(32'sd18)) complete_rsci (
      .vld(complete_rsc_vld),
      .rdy(complete_rsc_rdy),
      .ivld(complete_rsci_ivld_core_sct),
      .irdy(complete_rsci_irdy)
    );
  inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_ctrl inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .complete_rsci_oswt(complete_rsci_oswt),
      .complete_rsci_biwt(complete_rsci_biwt),
      .complete_rsci_bdwt(complete_rsci_bdwt),
      .complete_rsci_bcwt(complete_rsci_bcwt),
      .complete_rsci_ivld_core_sct(complete_rsci_ivld_core_sct),
      .complete_rsci_irdy(complete_rsci_irdy)
    );
  inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_dp inPlaceNTT_DIF_precomp_core_complete_rsci_complete_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .complete_rsci_oswt(complete_rsci_oswt),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .complete_rsci_biwt(complete_rsci_biwt),
      .complete_rsci_bdwt(complete_rsci_bdwt),
      .complete_rsci_bcwt(complete_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_run_rsci
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_run_rsci (
  clk, rst, run_rsc_rdy, run_rsc_vld, core_wen, run_rsci_oswt, core_wten, run_rsci_ivld_mxwt
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  input core_wen;
  input run_rsci_oswt;
  input core_wten;
  output run_rsci_ivld_mxwt;


  // Interconnect Declarations
  wire run_rsci_ivld;
  wire run_rsci_biwt;
  wire run_rsci_bdwt;


  // Interconnect Declarations for Component Instantiations 
  ccs_sync_in_wait_v1 #(.rscid(32'sd12)) run_rsci (
      .vld(run_rsc_vld),
      .rdy(run_rsc_rdy),
      .ivld(run_rsci_ivld),
      .irdy(run_rsci_biwt)
    );
  inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_ctrl inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .run_rsci_oswt(run_rsci_oswt),
      .core_wten(core_wten),
      .run_rsci_biwt(run_rsci_biwt),
      .run_rsci_bdwt(run_rsci_bdwt)
    );
  inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_dp inPlaceNTT_DIF_precomp_core_run_rsci_run_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .run_rsci_ivld_mxwt(run_rsci_ivld_mxwt),
      .run_rsci_ivld(run_rsci_ivld),
      .run_rsci_biwt(run_rsci_biwt),
      .run_rsci_bdwt(run_rsci_bdwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core (
  clk, rst, run_rsc_rdy, run_rsc_vld, vec_rsc_triosy_0_0_lz, vec_rsc_triosy_0_1_lz,
      vec_rsc_triosy_0_2_lz, vec_rsc_triosy_0_3_lz, vec_rsc_triosy_0_4_lz, vec_rsc_triosy_0_5_lz,
      vec_rsc_triosy_0_6_lz, vec_rsc_triosy_0_7_lz, vec_rsc_triosy_1_0_lz, vec_rsc_triosy_1_1_lz,
      vec_rsc_triosy_1_2_lz, vec_rsc_triosy_1_3_lz, vec_rsc_triosy_1_4_lz, vec_rsc_triosy_1_5_lz,
      vec_rsc_triosy_1_6_lz, vec_rsc_triosy_1_7_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_triosy_lz,
      twiddle_rsc_triosy_0_0_lz, twiddle_rsc_triosy_0_1_lz, twiddle_rsc_triosy_0_2_lz,
      twiddle_rsc_triosy_0_3_lz, twiddle_rsc_triosy_0_4_lz, twiddle_rsc_triosy_0_5_lz,
      twiddle_rsc_triosy_0_6_lz, twiddle_rsc_triosy_0_7_lz, twiddle_rsc_triosy_1_0_lz,
      twiddle_rsc_triosy_1_1_lz, twiddle_rsc_triosy_1_2_lz, twiddle_rsc_triosy_1_3_lz,
      twiddle_rsc_triosy_1_4_lz, twiddle_rsc_triosy_1_5_lz, twiddle_rsc_triosy_1_6_lz,
      twiddle_rsc_triosy_1_7_lz, twiddle_h_rsc_triosy_0_0_lz, twiddle_h_rsc_triosy_0_1_lz,
      twiddle_h_rsc_triosy_0_2_lz, twiddle_h_rsc_triosy_0_3_lz, twiddle_h_rsc_triosy_0_4_lz,
      twiddle_h_rsc_triosy_0_5_lz, twiddle_h_rsc_triosy_0_6_lz, twiddle_h_rsc_triosy_0_7_lz,
      twiddle_h_rsc_triosy_1_0_lz, twiddle_h_rsc_triosy_1_1_lz, twiddle_h_rsc_triosy_1_2_lz,
      twiddle_h_rsc_triosy_1_3_lz, twiddle_h_rsc_triosy_1_4_lz, twiddle_h_rsc_triosy_1_5_lz,
      twiddle_h_rsc_triosy_1_6_lz, twiddle_h_rsc_triosy_1_7_lz, complete_rsc_rdy,
      complete_rsc_vld, vec_rsc_0_0_i_adra_d, vec_rsc_0_0_i_da_d, vec_rsc_0_0_i_qa_d,
      vec_rsc_0_0_i_wea_d, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_0_1_i_adra_d, vec_rsc_0_1_i_da_d, vec_rsc_0_1_i_qa_d, vec_rsc_0_1_i_wea_d,
      vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_0_2_i_adra_d, vec_rsc_0_2_i_da_d, vec_rsc_0_2_i_qa_d, vec_rsc_0_2_i_wea_d,
      vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_0_3_i_adra_d, vec_rsc_0_3_i_da_d, vec_rsc_0_3_i_qa_d, vec_rsc_0_3_i_wea_d,
      vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_0_4_i_adra_d, vec_rsc_0_4_i_da_d, vec_rsc_0_4_i_qa_d, vec_rsc_0_4_i_wea_d,
      vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_0_5_i_adra_d, vec_rsc_0_5_i_da_d, vec_rsc_0_5_i_qa_d, vec_rsc_0_5_i_wea_d,
      vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_0_6_i_adra_d, vec_rsc_0_6_i_da_d, vec_rsc_0_6_i_qa_d, vec_rsc_0_6_i_wea_d,
      vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_0_7_i_adra_d, vec_rsc_0_7_i_da_d, vec_rsc_0_7_i_qa_d, vec_rsc_0_7_i_wea_d,
      vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_0_i_adra_d, vec_rsc_1_0_i_da_d, vec_rsc_1_0_i_qa_d, vec_rsc_1_0_i_wea_d,
      vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_1_i_adra_d, vec_rsc_1_1_i_da_d, vec_rsc_1_1_i_qa_d, vec_rsc_1_1_i_wea_d,
      vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_2_i_adra_d, vec_rsc_1_2_i_da_d, vec_rsc_1_2_i_qa_d, vec_rsc_1_2_i_wea_d,
      vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_3_i_adra_d, vec_rsc_1_3_i_da_d, vec_rsc_1_3_i_qa_d, vec_rsc_1_3_i_wea_d,
      vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_4_i_adra_d, vec_rsc_1_4_i_da_d, vec_rsc_1_4_i_qa_d, vec_rsc_1_4_i_wea_d,
      vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_5_i_adra_d, vec_rsc_1_5_i_da_d, vec_rsc_1_5_i_qa_d, vec_rsc_1_5_i_wea_d,
      vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_6_i_adra_d, vec_rsc_1_6_i_da_d, vec_rsc_1_6_i_qa_d, vec_rsc_1_6_i_wea_d,
      vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      vec_rsc_1_7_i_adra_d, vec_rsc_1_7_i_da_d, vec_rsc_1_7_i_qa_d, vec_rsc_1_7_i_wea_d,
      vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      twiddle_rsc_0_0_i_qb_d, twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_1_i_qb_d, twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_2_i_qb_d, twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_3_i_qb_d, twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_4_i_qb_d, twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_5_i_qb_d, twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_6_i_qb_d, twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_7_i_qb_d, twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_0_i_qb_d, twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_1_i_qb_d, twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_2_i_qb_d, twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_3_i_qb_d, twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_4_i_qb_d, twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_5_i_qb_d, twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_6_i_qb_d, twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_1_7_i_qb_d, twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_0_i_qb_d, twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_1_i_qb_d, twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_2_i_qb_d, twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_3_i_qb_d, twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_4_i_qb_d, twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_5_i_qb_d, twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_6_i_qb_d, twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_0_7_i_qb_d, twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_0_i_qb_d, twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_1_i_qb_d, twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_2_i_qb_d, twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_3_i_qb_d, twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_4_i_qb_d, twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_5_i_qb_d, twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_6_i_qb_d, twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsc_1_7_i_qb_d, twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_0_i_adrb_d_pff
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output vec_rsc_triosy_0_0_lz;
  output vec_rsc_triosy_0_1_lz;
  output vec_rsc_triosy_0_2_lz;
  output vec_rsc_triosy_0_3_lz;
  output vec_rsc_triosy_0_4_lz;
  output vec_rsc_triosy_0_5_lz;
  output vec_rsc_triosy_0_6_lz;
  output vec_rsc_triosy_0_7_lz;
  output vec_rsc_triosy_1_0_lz;
  output vec_rsc_triosy_1_1_lz;
  output vec_rsc_triosy_1_2_lz;
  output vec_rsc_triosy_1_3_lz;
  output vec_rsc_triosy_1_4_lz;
  output vec_rsc_triosy_1_5_lz;
  output vec_rsc_triosy_1_6_lz;
  output vec_rsc_triosy_1_7_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_0_0_lz;
  output twiddle_rsc_triosy_0_1_lz;
  output twiddle_rsc_triosy_0_2_lz;
  output twiddle_rsc_triosy_0_3_lz;
  output twiddle_rsc_triosy_0_4_lz;
  output twiddle_rsc_triosy_0_5_lz;
  output twiddle_rsc_triosy_0_6_lz;
  output twiddle_rsc_triosy_0_7_lz;
  output twiddle_rsc_triosy_1_0_lz;
  output twiddle_rsc_triosy_1_1_lz;
  output twiddle_rsc_triosy_1_2_lz;
  output twiddle_rsc_triosy_1_3_lz;
  output twiddle_rsc_triosy_1_4_lz;
  output twiddle_rsc_triosy_1_5_lz;
  output twiddle_rsc_triosy_1_6_lz;
  output twiddle_rsc_triosy_1_7_lz;
  output twiddle_h_rsc_triosy_0_0_lz;
  output twiddle_h_rsc_triosy_0_1_lz;
  output twiddle_h_rsc_triosy_0_2_lz;
  output twiddle_h_rsc_triosy_0_3_lz;
  output twiddle_h_rsc_triosy_0_4_lz;
  output twiddle_h_rsc_triosy_0_5_lz;
  output twiddle_h_rsc_triosy_0_6_lz;
  output twiddle_h_rsc_triosy_0_7_lz;
  output twiddle_h_rsc_triosy_1_0_lz;
  output twiddle_h_rsc_triosy_1_1_lz;
  output twiddle_h_rsc_triosy_1_2_lz;
  output twiddle_h_rsc_triosy_1_3_lz;
  output twiddle_h_rsc_triosy_1_4_lz;
  output twiddle_h_rsc_triosy_1_5_lz;
  output twiddle_h_rsc_triosy_1_6_lz;
  output twiddle_h_rsc_triosy_1_7_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;
  output [11:0] vec_rsc_0_0_i_adra_d;
  output [31:0] vec_rsc_0_0_i_da_d;
  input [63:0] vec_rsc_0_0_i_qa_d;
  output [1:0] vec_rsc_0_0_i_wea_d;
  output [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_0_1_i_adra_d;
  output [31:0] vec_rsc_0_1_i_da_d;
  input [63:0] vec_rsc_0_1_i_qa_d;
  output [1:0] vec_rsc_0_1_i_wea_d;
  output [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_0_2_i_adra_d;
  output [31:0] vec_rsc_0_2_i_da_d;
  input [63:0] vec_rsc_0_2_i_qa_d;
  output [1:0] vec_rsc_0_2_i_wea_d;
  output [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_0_3_i_adra_d;
  output [31:0] vec_rsc_0_3_i_da_d;
  input [63:0] vec_rsc_0_3_i_qa_d;
  output [1:0] vec_rsc_0_3_i_wea_d;
  output [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_0_4_i_adra_d;
  output [31:0] vec_rsc_0_4_i_da_d;
  input [63:0] vec_rsc_0_4_i_qa_d;
  output [1:0] vec_rsc_0_4_i_wea_d;
  output [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_0_5_i_adra_d;
  output [31:0] vec_rsc_0_5_i_da_d;
  input [63:0] vec_rsc_0_5_i_qa_d;
  output [1:0] vec_rsc_0_5_i_wea_d;
  output [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_0_6_i_adra_d;
  output [31:0] vec_rsc_0_6_i_da_d;
  input [63:0] vec_rsc_0_6_i_qa_d;
  output [1:0] vec_rsc_0_6_i_wea_d;
  output [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_0_7_i_adra_d;
  output [31:0] vec_rsc_0_7_i_da_d;
  input [63:0] vec_rsc_0_7_i_qa_d;
  output [1:0] vec_rsc_0_7_i_wea_d;
  output [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_0_i_adra_d;
  output [31:0] vec_rsc_1_0_i_da_d;
  input [63:0] vec_rsc_1_0_i_qa_d;
  output [1:0] vec_rsc_1_0_i_wea_d;
  output [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_1_i_adra_d;
  output [31:0] vec_rsc_1_1_i_da_d;
  input [63:0] vec_rsc_1_1_i_qa_d;
  output [1:0] vec_rsc_1_1_i_wea_d;
  output [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_2_i_adra_d;
  output [31:0] vec_rsc_1_2_i_da_d;
  input [63:0] vec_rsc_1_2_i_qa_d;
  output [1:0] vec_rsc_1_2_i_wea_d;
  output [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_3_i_adra_d;
  output [31:0] vec_rsc_1_3_i_da_d;
  input [63:0] vec_rsc_1_3_i_qa_d;
  output [1:0] vec_rsc_1_3_i_wea_d;
  output [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_4_i_adra_d;
  output [31:0] vec_rsc_1_4_i_da_d;
  input [63:0] vec_rsc_1_4_i_qa_d;
  output [1:0] vec_rsc_1_4_i_wea_d;
  output [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_5_i_adra_d;
  output [31:0] vec_rsc_1_5_i_da_d;
  input [63:0] vec_rsc_1_5_i_qa_d;
  output [1:0] vec_rsc_1_5_i_wea_d;
  output [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_6_i_adra_d;
  output [31:0] vec_rsc_1_6_i_da_d;
  input [63:0] vec_rsc_1_6_i_qa_d;
  output [1:0] vec_rsc_1_6_i_wea_d;
  output [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [11:0] vec_rsc_1_7_i_adra_d;
  output [31:0] vec_rsc_1_7_i_da_d;
  input [63:0] vec_rsc_1_7_i_qa_d;
  output [1:0] vec_rsc_1_7_i_wea_d;
  output [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input [31:0] twiddle_rsc_0_0_i_qb_d;
  output twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_0_1_i_qb_d;
  output twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_0_2_i_qb_d;
  output twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_0_3_i_qb_d;
  output twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_0_4_i_qb_d;
  output twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_0_5_i_qb_d;
  output twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_0_6_i_qb_d;
  output twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_0_7_i_qb_d;
  output twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_0_i_qb_d;
  output twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_1_i_qb_d;
  output twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_2_i_qb_d;
  output twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_3_i_qb_d;
  output twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_4_i_qb_d;
  output twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_5_i_qb_d;
  output twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_6_i_qb_d;
  output twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_rsc_1_7_i_qb_d;
  output twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_0_i_qb_d;
  output twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_1_i_qb_d;
  output twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_2_i_qb_d;
  output twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_3_i_qb_d;
  output twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_4_i_qb_d;
  output twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_5_i_qb_d;
  output twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_6_i_qb_d;
  output twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_0_7_i_qb_d;
  output twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_0_i_qb_d;
  output twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_1_i_qb_d;
  output twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_2_i_qb_d;
  output twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_3_i_qb_d;
  output twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_4_i_qb_d;
  output twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_5_i_qb_d;
  output twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_6_i_qb_d;
  output twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  input [31:0] twiddle_h_rsc_1_7_i_qb_d;
  output twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  output [5:0] twiddle_rsc_0_0_i_adrb_d_pff;


  // Interconnect Declarations
  wire core_wten;
  wire run_rsci_ivld_mxwt;
  wire [31:0] p_rsci_idat;
  wire complete_rsci_wen_comp;
  wire [63:0] vec_rsc_0_0_i_qa_d_mxwt;
  wire [63:0] vec_rsc_0_1_i_qa_d_mxwt;
  wire [63:0] vec_rsc_0_2_i_qa_d_mxwt;
  wire [63:0] vec_rsc_0_3_i_qa_d_mxwt;
  wire [63:0] vec_rsc_0_4_i_qa_d_mxwt;
  wire [63:0] vec_rsc_0_5_i_qa_d_mxwt;
  wire [63:0] vec_rsc_0_6_i_qa_d_mxwt;
  wire [63:0] vec_rsc_0_7_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_0_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_1_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_2_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_3_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_4_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_5_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_6_i_qa_d_mxwt;
  wire [63:0] vec_rsc_1_7_i_qa_d_mxwt;
  wire [31:0] twiddle_rsc_0_0_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_0_1_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_0_2_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_0_3_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_0_4_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_0_5_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_0_6_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_0_7_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_0_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_1_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_2_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_3_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_4_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_5_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_6_i_qb_d_mxwt;
  wire [31:0] twiddle_rsc_1_7_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_0_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_1_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_2_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_3_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_4_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_5_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_6_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_0_7_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_0_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_1_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_2_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_3_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_4_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_5_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_6_i_qb_d_mxwt;
  wire [31:0] twiddle_h_rsc_1_7_i_qb_d_mxwt;
  wire [31:0] mult_cmp_return_rsc_z;
  wire mult_cmp_ccs_ccore_en;
  wire [31:0] modulo_sub_cmp_return_rsc_z;
  wire modulo_sub_cmp_ccs_ccore_en;
  wire [31:0] modulo_add_cmp_return_rsc_z;
  wire [21:0] fsm_output;
  wire [9:0] VEC_LOOP_acc_10_tmp;
  wire [11:0] nl_VEC_LOOP_acc_10_tmp;
  wire [9:0] VEC_LOOP_acc_1_tmp;
  wire [10:0] nl_VEC_LOOP_acc_1_tmp;
  wire and_dcpl_7;
  wire and_dcpl_8;
  wire and_dcpl_13;
  wire and_dcpl_14;
  wire and_dcpl_19;
  wire and_dcpl_21;
  wire and_dcpl_23;
  wire and_dcpl_25;
  wire and_dcpl_27;
  wire and_dcpl_29;
  wire and_dcpl_31;
  wire and_dcpl_33;
  wire and_dcpl_35;
  wire and_dcpl_37;
  wire and_dcpl_39;
  wire and_dcpl_41;
  wire and_dcpl_43;
  wire and_dcpl_45;
  wire and_dcpl_47;
  wire and_dcpl_49;
  wire and_dcpl_63;
  wire and_dcpl_65;
  wire and_dcpl_67;
  wire and_dcpl_69;
  wire and_dcpl_83;
  wire and_dcpl_85;
  wire and_dcpl_87;
  wire and_dcpl_89;
  wire and_dcpl_103;
  wire and_dcpl_104;
  wire and_dcpl_106;
  wire and_dcpl_108;
  wire and_dcpl_110;
  wire and_dcpl_112;
  wire and_dcpl_117;
  wire and_dcpl_122;
  wire and_dcpl_129;
  wire and_dcpl_131;
  wire or_tmp_141;
  wire and_157_cse;
  wire and_159_cse;
  wire and_158_cse;
  wire and_178_cse;
  wire and_180_cse;
  wire and_179_cse;
  wire and_191_cse;
  wire and_193_cse;
  wire and_192_cse;
  wire and_204_cse;
  wire and_206_cse;
  wire and_205_cse;
  wire and_217_cse;
  wire and_219_cse;
  wire and_218_cse;
  wire and_230_cse;
  wire and_232_cse;
  wire and_231_cse;
  wire and_243_cse;
  wire and_245_cse;
  wire and_244_cse;
  wire and_256_cse;
  wire and_258_cse;
  wire and_257_cse;
  wire and_269_cse;
  wire and_271_cse;
  wire and_270_cse;
  wire and_282_cse;
  wire and_284_cse;
  wire and_283_cse;
  wire and_295_cse;
  wire and_297_cse;
  wire and_296_cse;
  wire and_308_cse;
  wire and_310_cse;
  wire and_309_cse;
  wire and_321_cse;
  wire and_323_cse;
  wire and_322_cse;
  wire and_334_cse;
  wire and_336_cse;
  wire and_335_cse;
  wire and_347_cse;
  wire and_349_cse;
  wire and_348_cse;
  wire and_360_cse;
  wire and_362_cse;
  wire and_361_cse;
  reg [9:0] COMP_LOOP_twiddle_f_lshift_itm;
  reg [10:0] STAGE_LOOP_lshift_psp_sva;
  reg [9:0] COMP_LOOP_twiddle_f_mul_cse_sva;
  reg COMP_LOOP_twiddle_f_nor_6_itm;
  reg COMP_LOOP_twiddle_f_nor_3_itm;
  reg COMP_LOOP_twiddle_f_nor_1_itm;
  reg COMP_LOOP_twiddle_f_nor_itm;
  reg [9:0] COMP_LOOP_k_10_0_sva_9_0;
  reg [10:0] VEC_LOOP_j_10_0_sva_1;
  wire [11:0] nl_VEC_LOOP_j_10_0_sva_1;
  reg VEC_LOOP_VEC_LOOP_and_10_itm;
  reg [9:0] VEC_LOOP_acc_10_cse_sva;
  wire [9:0] COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0;
  wire [19:0] nl_COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0;
  reg reg_run_rsci_oswt_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_0_0_i_oswt_cse;
  reg reg_vec_rsc_0_0_i_oswt_1_cse;
  reg reg_vec_rsc_0_1_i_oswt_cse;
  reg reg_vec_rsc_0_1_i_oswt_1_cse;
  reg reg_vec_rsc_0_2_i_oswt_cse;
  reg reg_vec_rsc_0_2_i_oswt_1_cse;
  reg reg_vec_rsc_0_3_i_oswt_cse;
  reg reg_vec_rsc_0_3_i_oswt_1_cse;
  reg reg_vec_rsc_0_4_i_oswt_cse;
  reg reg_vec_rsc_0_4_i_oswt_1_cse;
  reg reg_vec_rsc_0_5_i_oswt_cse;
  reg reg_vec_rsc_0_5_i_oswt_1_cse;
  reg reg_vec_rsc_0_6_i_oswt_cse;
  reg reg_vec_rsc_0_6_i_oswt_1_cse;
  reg reg_vec_rsc_0_7_i_oswt_cse;
  reg reg_vec_rsc_0_7_i_oswt_1_cse;
  reg reg_vec_rsc_1_0_i_oswt_cse;
  reg reg_vec_rsc_1_0_i_oswt_1_cse;
  reg reg_vec_rsc_1_1_i_oswt_cse;
  reg reg_vec_rsc_1_1_i_oswt_1_cse;
  reg reg_vec_rsc_1_2_i_oswt_cse;
  reg reg_vec_rsc_1_2_i_oswt_1_cse;
  reg reg_vec_rsc_1_3_i_oswt_cse;
  reg reg_vec_rsc_1_3_i_oswt_1_cse;
  reg reg_vec_rsc_1_4_i_oswt_cse;
  reg reg_vec_rsc_1_4_i_oswt_1_cse;
  reg reg_vec_rsc_1_5_i_oswt_cse;
  reg reg_vec_rsc_1_5_i_oswt_1_cse;
  reg reg_vec_rsc_1_6_i_oswt_cse;
  reg reg_vec_rsc_1_6_i_oswt_1_cse;
  reg reg_vec_rsc_1_7_i_oswt_cse;
  reg reg_vec_rsc_1_7_i_oswt_1_cse;
  reg reg_twiddle_rsc_0_0_i_oswt_cse;
  reg reg_twiddle_rsc_0_1_i_oswt_cse;
  reg reg_twiddle_rsc_0_2_i_oswt_cse;
  reg reg_twiddle_rsc_0_3_i_oswt_cse;
  reg reg_twiddle_rsc_0_4_i_oswt_cse;
  reg reg_twiddle_rsc_0_5_i_oswt_cse;
  reg reg_twiddle_rsc_0_6_i_oswt_cse;
  reg reg_twiddle_rsc_0_7_i_oswt_cse;
  reg reg_twiddle_rsc_1_0_i_oswt_cse;
  reg reg_twiddle_rsc_1_1_i_oswt_cse;
  reg reg_twiddle_rsc_1_2_i_oswt_cse;
  reg reg_twiddle_rsc_1_3_i_oswt_cse;
  reg reg_twiddle_rsc_1_4_i_oswt_cse;
  reg reg_twiddle_rsc_1_5_i_oswt_cse;
  reg reg_twiddle_rsc_1_6_i_oswt_cse;
  reg reg_twiddle_rsc_1_7_i_oswt_cse;
  reg reg_vec_rsc_triosy_1_7_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_1_cse;
  wire COMP_LOOP_twiddle_f_and_1_cse;
  wire VEC_LOOP_and_cse;
  wire VEC_LOOP_nor_9_cse;
  wire VEC_LOOP_nor_2_cse;
  wire VEC_LOOP_nor_19_cse;
  wire VEC_LOOP_nor_12_cse;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire COMP_LOOP_twiddle_help_and_1_cse;
  wire COMP_LOOP_twiddle_help_and_2_cse;
  wire COMP_LOOP_twiddle_help_and_3_cse;
  wire COMP_LOOP_twiddle_help_and_4_cse;
  wire COMP_LOOP_twiddle_help_and_5_cse;
  wire COMP_LOOP_twiddle_help_and_6_cse;
  wire COMP_LOOP_twiddle_help_and_7_cse;
  wire COMP_LOOP_twiddle_help_and_8_cse;
  wire COMP_LOOP_twiddle_help_and_9_cse;
  wire COMP_LOOP_twiddle_help_and_10_cse;
  wire COMP_LOOP_twiddle_help_and_11_cse;
  wire COMP_LOOP_twiddle_help_and_12_cse;
  wire COMP_LOOP_twiddle_help_and_13_cse;
  wire COMP_LOOP_twiddle_help_and_14_cse;
  wire COMP_LOOP_twiddle_help_and_15_cse;
  wire [5:0] VEC_LOOP_mux1h_rmff;
  wire [31:0] vec_rsc_0_0_i_da_d_reg;
  wire [31:0] VEC_LOOP_mux_4_rmff;
  wire [1:0] vec_rsc_0_0_i_wea_d_reg;
  wire or_21_rmff;
  wire core_wten_iff;
  wire or_15_rmff;
  wire [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_161_rmff;
  wire [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_0_1_i_da_d_reg;
  wire [1:0] vec_rsc_0_1_i_wea_d_reg;
  wire or_26_rmff;
  wire or_24_rmff;
  wire [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_182_rmff;
  wire [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_0_2_i_da_d_reg;
  wire [1:0] vec_rsc_0_2_i_wea_d_reg;
  wire or_31_rmff;
  wire or_29_rmff;
  wire [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_195_rmff;
  wire [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_0_3_i_da_d_reg;
  wire [1:0] vec_rsc_0_3_i_wea_d_reg;
  wire or_36_rmff;
  wire or_34_rmff;
  wire [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_208_rmff;
  wire [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_0_4_i_da_d_reg;
  wire [1:0] vec_rsc_0_4_i_wea_d_reg;
  wire or_41_rmff;
  wire or_39_rmff;
  wire [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_221_rmff;
  wire [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_0_5_i_da_d_reg;
  wire [1:0] vec_rsc_0_5_i_wea_d_reg;
  wire or_46_rmff;
  wire or_44_rmff;
  wire [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_234_rmff;
  wire [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_0_6_i_da_d_reg;
  wire [1:0] vec_rsc_0_6_i_wea_d_reg;
  wire or_51_rmff;
  wire or_49_rmff;
  wire [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_247_rmff;
  wire [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_0_7_i_da_d_reg;
  wire [1:0] vec_rsc_0_7_i_wea_d_reg;
  wire or_56_rmff;
  wire or_54_rmff;
  wire [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_260_rmff;
  wire [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_0_i_da_d_reg;
  wire [1:0] vec_rsc_1_0_i_wea_d_reg;
  wire or_61_rmff;
  wire or_59_rmff;
  wire [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_273_rmff;
  wire [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_1_i_da_d_reg;
  wire [1:0] vec_rsc_1_1_i_wea_d_reg;
  wire or_66_rmff;
  wire or_64_rmff;
  wire [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_286_rmff;
  wire [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_2_i_da_d_reg;
  wire [1:0] vec_rsc_1_2_i_wea_d_reg;
  wire or_71_rmff;
  wire or_69_rmff;
  wire [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_299_rmff;
  wire [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_3_i_da_d_reg;
  wire [1:0] vec_rsc_1_3_i_wea_d_reg;
  wire or_76_rmff;
  wire or_74_rmff;
  wire [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_312_rmff;
  wire [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_4_i_da_d_reg;
  wire [1:0] vec_rsc_1_4_i_wea_d_reg;
  wire or_81_rmff;
  wire or_79_rmff;
  wire [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_325_rmff;
  wire [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_5_i_da_d_reg;
  wire [1:0] vec_rsc_1_5_i_wea_d_reg;
  wire or_86_rmff;
  wire or_84_rmff;
  wire [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_338_rmff;
  wire [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_6_i_da_d_reg;
  wire [1:0] vec_rsc_1_6_i_wea_d_reg;
  wire or_91_rmff;
  wire or_89_rmff;
  wire [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_351_rmff;
  wire [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [31:0] vec_rsc_1_7_i_da_d_reg;
  wire [1:0] vec_rsc_1_7_i_wea_d_reg;
  wire or_96_rmff;
  wire or_94_rmff;
  wire [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_364_rmff;
  wire [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_373_rmff;
  wire twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_375_rmff;
  wire twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_377_rmff;
  wire twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_379_rmff;
  wire twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_381_rmff;
  wire twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_383_rmff;
  wire twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_385_rmff;
  wire twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_387_rmff;
  wire twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_389_rmff;
  wire twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_391_rmff;
  wire twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_393_rmff;
  wire twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_395_rmff;
  wire twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_397_rmff;
  wire twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_399_rmff;
  wire twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_401_rmff;
  wire twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_403_rmff;
  wire twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire or_116_rmff;
  wire or_118_rmff;
  reg [31:0] tmp_2_lpi_3_dfm;
  reg [31:0] tmp_3_lpi_3_dfm;
  reg [31:0] tmp_lpi_4_dfm;
  reg [31:0] tmp_1_lpi_4_dfm;
  reg [31:0] p_sva;
  wire [10:0] z_out;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg COMP_LOOP_twiddle_f_equal_tmp;
  reg COMP_LOOP_twiddle_f_equal_tmp_3;
  reg COMP_LOOP_twiddle_f_equal_tmp_5;
  reg COMP_LOOP_twiddle_f_equal_tmp_6;
  reg COMP_LOOP_twiddle_f_equal_tmp_7;
  reg COMP_LOOP_twiddle_f_equal_tmp_9;
  reg COMP_LOOP_twiddle_f_equal_tmp_10;
  reg COMP_LOOP_twiddle_f_equal_tmp_11;
  reg COMP_LOOP_twiddle_f_equal_tmp_12;
  reg COMP_LOOP_twiddle_f_equal_tmp_13;
  reg COMP_LOOP_twiddle_f_equal_tmp_14;
  reg COMP_LOOP_twiddle_f_equal_tmp_15;
  reg VEC_LOOP_VEC_LOOP_nor_itm;
  reg VEC_LOOP_nor_itm;
  reg VEC_LOOP_nor_1_itm;
  reg VEC_LOOP_VEC_LOOP_and_2_itm;
  reg VEC_LOOP_nor_3_itm;
  reg VEC_LOOP_VEC_LOOP_and_4_itm;
  reg VEC_LOOP_VEC_LOOP_and_5_itm;
  reg VEC_LOOP_VEC_LOOP_and_6_itm;
  reg VEC_LOOP_nor_6_itm;
  reg VEC_LOOP_VEC_LOOP_and_8_itm;
  reg VEC_LOOP_VEC_LOOP_and_9_itm;
  reg VEC_LOOP_VEC_LOOP_and_11_itm;
  reg VEC_LOOP_VEC_LOOP_and_12_itm;
  reg VEC_LOOP_VEC_LOOP_and_13_itm;
  reg VEC_LOOP_VEC_LOOP_and_14_itm;
  reg VEC_LOOP_VEC_LOOP_nor_1_itm;
  reg VEC_LOOP_nor_10_itm;
  reg VEC_LOOP_nor_11_itm;
  reg VEC_LOOP_VEC_LOOP_and_17_itm;
  reg VEC_LOOP_nor_13_itm;
  reg VEC_LOOP_VEC_LOOP_and_19_itm;
  reg VEC_LOOP_VEC_LOOP_and_20_itm;
  reg VEC_LOOP_VEC_LOOP_and_21_itm;
  reg VEC_LOOP_nor_16_itm;
  reg VEC_LOOP_VEC_LOOP_and_23_itm;
  reg VEC_LOOP_VEC_LOOP_and_24_itm;
  reg VEC_LOOP_VEC_LOOP_and_25_itm;
  reg VEC_LOOP_VEC_LOOP_and_26_itm;
  reg VEC_LOOP_VEC_LOOP_and_27_itm;
  reg VEC_LOOP_VEC_LOOP_and_28_itm;
  reg VEC_LOOP_VEC_LOOP_and_29_itm;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire [10:0] COMP_LOOP_k_10_0_sva_2;
  wire [11:0] nl_COMP_LOOP_k_10_0_sva_2;
  wire COMP_LOOP_twiddle_help_and_16_cse;
  wire STAGE_LOOP_acc_itm_4_1;

  wire[0:0] COMP_LOOP_k_not_1_nl;
  wire[9:0] COMP_LOOP_twiddle_f_mux1h_1_nl;
  wire[0:0] COMP_LOOP_twiddle_f_not_7_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_10_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_1_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_3_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_7_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_16_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_18_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_22_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_mult_cmp_p_rsc_dat;
  assign nl_mult_cmp_p_rsc_dat = p_sva;
  wire [0:0] nl_mult_cmp_ccs_ccore_start_rsc_dat;
  assign nl_mult_cmp_ccs_ccore_start_rsc_dat = fsm_output[9];
  wire [31:0] nl_modulo_sub_cmp_base_rsc_dat;
  assign nl_modulo_sub_cmp_base_rsc_dat = tmp_lpi_4_dfm - tmp_1_lpi_4_dfm;
  wire [31:0] nl_modulo_sub_cmp_m_rsc_dat;
  assign nl_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire [0:0] nl_modulo_sub_cmp_ccs_ccore_start_rsc_dat;
  assign nl_modulo_sub_cmp_ccs_ccore_start_rsc_dat = fsm_output[8];
  wire [31:0] nl_modulo_add_cmp_base_rsc_dat;
  assign nl_modulo_add_cmp_base_rsc_dat = tmp_lpi_4_dfm + tmp_1_lpi_4_dfm;
  wire [31:0] nl_modulo_add_cmp_m_rsc_dat;
  assign nl_modulo_add_cmp_m_rsc_dat = p_sva;
  wire [0:0] nl_modulo_add_cmp_ccs_ccore_start_rsc_dat;
  assign nl_modulo_add_cmp_ccs_ccore_start_rsc_dat = fsm_output[8];
  wire[3:0] COMP_LOOP_twiddle_f_acc_nl;
  wire[4:0] nl_COMP_LOOP_twiddle_f_acc_nl;
  wire [3:0] nl_COMP_LOOP_twiddle_f_lshift_rg_s;
  assign nl_COMP_LOOP_twiddle_f_acc_nl = (~ STAGE_LOOP_i_3_0_sva) + 4'b1011;
  assign COMP_LOOP_twiddle_f_acc_nl = nl_COMP_LOOP_twiddle_f_acc_nl[3:0];
  assign nl_COMP_LOOP_twiddle_f_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, COMP_LOOP_twiddle_f_acc_nl,
      fsm_output[2]);
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_wea_d_core_psct
      = {1'b0 , or_21_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_161_rmff , and_158_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_21_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_oswt_1_pff
      = and_161_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_wea_d_core_psct
      = {1'b0 , or_26_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_182_rmff , and_179_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_26_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_oswt_1_pff
      = and_182_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_wea_d_core_psct
      = {1'b0 , or_31_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_195_rmff , and_192_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_31_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_oswt_1_pff
      = and_195_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_wea_d_core_psct
      = {1'b0 , or_36_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_208_rmff , and_205_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_36_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_oswt_1_pff
      = and_208_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_wea_d_core_psct
      = {1'b0 , or_41_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_221_rmff , and_218_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_41_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_oswt_1_pff
      = and_221_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_wea_d_core_psct
      = {1'b0 , or_46_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_234_rmff , and_231_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_46_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_oswt_1_pff
      = and_234_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_wea_d_core_psct
      = {1'b0 , or_51_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_247_rmff , and_244_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_51_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_oswt_1_pff
      = and_247_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_wea_d_core_psct
      = {1'b0 , or_56_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_260_rmff , and_257_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_56_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_oswt_1_pff
      = and_260_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_wea_d_core_psct
      = {1'b0 , or_61_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_273_rmff , and_270_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_61_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_oswt_1_pff
      = and_273_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_wea_d_core_psct
      = {1'b0 , or_66_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_286_rmff , and_283_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_66_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_oswt_1_pff
      = and_286_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_wea_d_core_psct
      = {1'b0 , or_71_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_299_rmff , and_296_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_71_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_oswt_1_pff
      = and_299_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_wea_d_core_psct
      = {1'b0 , or_76_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_312_rmff , and_309_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_76_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_oswt_1_pff
      = and_312_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_wea_d_core_psct
      = {1'b0 , or_81_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_325_rmff , and_322_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_81_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_oswt_1_pff
      = and_325_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_wea_d_core_psct
      = {1'b0 , or_86_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_338_rmff , and_335_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_86_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_oswt_1_pff
      = and_338_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_wea_d_core_psct
      = {1'b0 , or_91_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_351_rmff , and_348_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_91_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_oswt_1_pff
      = and_351_rmff;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_da_d_core
      = {32'b00000000000000000000000000000000 , VEC_LOOP_mux_4_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_wea_d_core_psct
      = {1'b0 , or_96_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_364_rmff , and_361_cse};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , or_96_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_oswt_1_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_oswt_1_pff
      = and_364_rmff;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ VEC_LOOP_VEC_LOOP_and_10_itm;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_VEC_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_VEC_LOOP_C_11_tr0 = VEC_LOOP_j_10_0_sva_1[10];
  wire[10:0] COMP_LOOP_acc_nl;
  wire[11:0] nl_COMP_LOOP_acc_nl;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_COMP_LOOP_acc_nl = COMP_LOOP_k_10_0_sva_2 + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:1]))})
      + 11'b00000000001;
  assign COMP_LOOP_acc_nl = nl_COMP_LOOP_acc_nl[10:0];
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (readslicef_11_1_10(COMP_LOOP_acc_nl));
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ STAGE_LOOP_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd14),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mult  mult_cmp (
      .x_rsc_dat(modulo_sub_cmp_return_rsc_z),
      .y_rsc_dat(tmp_2_lpi_3_dfm),
      .y_rsc_dat_1(tmp_3_lpi_3_dfm),
      .p_rsc_dat(nl_mult_cmp_p_rsc_dat[31:0]),
      .return_rsc_z(mult_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nl_mult_cmp_ccs_ccore_start_rsc_dat[0:0]),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(mult_cmp_ccs_ccore_en)
    );
  modulo_sub  modulo_sub_cmp (
      .base_rsc_dat(nl_modulo_sub_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_modulo_sub_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(modulo_sub_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nl_modulo_sub_cmp_ccs_ccore_start_rsc_dat[0:0]),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  modulo_add_cmp (
      .base_rsc_dat(nl_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nl_modulo_add_cmp_ccs_ccore_start_rsc_dat[0:0]),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(modulo_sub_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) COMP_LOOP_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out)
    );
  inPlaceNTT_DIF_precomp_core_run_rsci inPlaceNTT_DIF_precomp_core_run_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .run_rsc_rdy(run_rsc_rdy),
      .run_rsc_vld(run_rsc_vld),
      .core_wen(complete_rsci_wen_comp),
      .run_rsci_oswt(reg_run_rsci_oswt_cse),
      .core_wten(core_wten),
      .run_rsci_ivld_mxwt(run_rsci_ivld_mxwt)
    );
  inPlaceNTT_DIF_precomp_core_complete_rsci inPlaceNTT_DIF_precomp_core_complete_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld),
      .core_wen(complete_rsci_wen_comp),
      .complete_rsci_oswt(reg_complete_rsci_oswt_cse),
      .complete_rsci_wen_comp(complete_rsci_wen_comp)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_0_i_da_d(vec_rsc_0_0_i_da_d_reg),
      .vec_rsc_0_0_i_qa_d(vec_rsc_0_0_i_qa_d),
      .vec_rsc_0_0_i_wea_d(vec_rsc_0_0_i_wea_d_reg),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_0_i_oswt(reg_vec_rsc_0_0_i_oswt_cse),
      .vec_rsc_0_0_i_oswt_1(reg_vec_rsc_0_0_i_oswt_1_cse),
      .vec_rsc_0_0_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_da_d_core[63:0]),
      .vec_rsc_0_0_i_qa_d_mxwt(vec_rsc_0_0_i_qa_d_mxwt),
      .vec_rsc_0_0_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_0_i_oswt_pff(or_15_rmff),
      .vec_rsc_0_0_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_0_i_1_inst_vec_rsc_0_0_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_wait_dp inPlaceNTT_DIF_precomp_core_wait_dp_inst (
      .ensig_cgo_iro(or_116_rmff),
      .ensig_cgo_iro_1(or_118_rmff),
      .core_wen(complete_rsci_wen_comp),
      .ensig_cgo(reg_ensig_cgo_cse),
      .mult_cmp_ccs_ccore_en(mult_cmp_ccs_ccore_en),
      .ensig_cgo_1(reg_ensig_cgo_1_cse),
      .modulo_sub_cmp_ccs_ccore_en(modulo_sub_cmp_ccs_ccore_en)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_1_i_da_d(vec_rsc_0_1_i_da_d_reg),
      .vec_rsc_0_1_i_qa_d(vec_rsc_0_1_i_qa_d),
      .vec_rsc_0_1_i_wea_d(vec_rsc_0_1_i_wea_d_reg),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_1_i_oswt(reg_vec_rsc_0_1_i_oswt_cse),
      .vec_rsc_0_1_i_oswt_1(reg_vec_rsc_0_1_i_oswt_1_cse),
      .vec_rsc_0_1_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_da_d_core[63:0]),
      .vec_rsc_0_1_i_qa_d_mxwt(vec_rsc_0_1_i_qa_d_mxwt),
      .vec_rsc_0_1_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_1_i_oswt_pff(or_24_rmff),
      .vec_rsc_0_1_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_1_i_1_inst_vec_rsc_0_1_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_2_i_da_d(vec_rsc_0_2_i_da_d_reg),
      .vec_rsc_0_2_i_qa_d(vec_rsc_0_2_i_qa_d),
      .vec_rsc_0_2_i_wea_d(vec_rsc_0_2_i_wea_d_reg),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_2_i_oswt(reg_vec_rsc_0_2_i_oswt_cse),
      .vec_rsc_0_2_i_oswt_1(reg_vec_rsc_0_2_i_oswt_1_cse),
      .vec_rsc_0_2_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_da_d_core[63:0]),
      .vec_rsc_0_2_i_qa_d_mxwt(vec_rsc_0_2_i_qa_d_mxwt),
      .vec_rsc_0_2_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_2_i_oswt_pff(or_29_rmff),
      .vec_rsc_0_2_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_2_i_1_inst_vec_rsc_0_2_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_3_i_da_d(vec_rsc_0_3_i_da_d_reg),
      .vec_rsc_0_3_i_qa_d(vec_rsc_0_3_i_qa_d),
      .vec_rsc_0_3_i_wea_d(vec_rsc_0_3_i_wea_d_reg),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_3_i_oswt(reg_vec_rsc_0_3_i_oswt_cse),
      .vec_rsc_0_3_i_oswt_1(reg_vec_rsc_0_3_i_oswt_1_cse),
      .vec_rsc_0_3_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_da_d_core[63:0]),
      .vec_rsc_0_3_i_qa_d_mxwt(vec_rsc_0_3_i_qa_d_mxwt),
      .vec_rsc_0_3_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_3_i_oswt_pff(or_34_rmff),
      .vec_rsc_0_3_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_3_i_1_inst_vec_rsc_0_3_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_4_i_da_d(vec_rsc_0_4_i_da_d_reg),
      .vec_rsc_0_4_i_qa_d(vec_rsc_0_4_i_qa_d),
      .vec_rsc_0_4_i_wea_d(vec_rsc_0_4_i_wea_d_reg),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_4_i_oswt(reg_vec_rsc_0_4_i_oswt_cse),
      .vec_rsc_0_4_i_oswt_1(reg_vec_rsc_0_4_i_oswt_1_cse),
      .vec_rsc_0_4_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_da_d_core[63:0]),
      .vec_rsc_0_4_i_qa_d_mxwt(vec_rsc_0_4_i_qa_d_mxwt),
      .vec_rsc_0_4_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_4_i_oswt_pff(or_39_rmff),
      .vec_rsc_0_4_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_4_i_1_inst_vec_rsc_0_4_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_5_i_da_d(vec_rsc_0_5_i_da_d_reg),
      .vec_rsc_0_5_i_qa_d(vec_rsc_0_5_i_qa_d),
      .vec_rsc_0_5_i_wea_d(vec_rsc_0_5_i_wea_d_reg),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_5_i_oswt(reg_vec_rsc_0_5_i_oswt_cse),
      .vec_rsc_0_5_i_oswt_1(reg_vec_rsc_0_5_i_oswt_1_cse),
      .vec_rsc_0_5_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_da_d_core[63:0]),
      .vec_rsc_0_5_i_qa_d_mxwt(vec_rsc_0_5_i_qa_d_mxwt),
      .vec_rsc_0_5_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_5_i_oswt_pff(or_44_rmff),
      .vec_rsc_0_5_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_5_i_1_inst_vec_rsc_0_5_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_6_i_da_d(vec_rsc_0_6_i_da_d_reg),
      .vec_rsc_0_6_i_qa_d(vec_rsc_0_6_i_qa_d),
      .vec_rsc_0_6_i_wea_d(vec_rsc_0_6_i_wea_d_reg),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_6_i_oswt(reg_vec_rsc_0_6_i_oswt_cse),
      .vec_rsc_0_6_i_oswt_1(reg_vec_rsc_0_6_i_oswt_1_cse),
      .vec_rsc_0_6_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_da_d_core[63:0]),
      .vec_rsc_0_6_i_qa_d_mxwt(vec_rsc_0_6_i_qa_d_mxwt),
      .vec_rsc_0_6_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_6_i_oswt_pff(or_49_rmff),
      .vec_rsc_0_6_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_6_i_1_inst_vec_rsc_0_6_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_0_7_i_da_d(vec_rsc_0_7_i_da_d_reg),
      .vec_rsc_0_7_i_qa_d(vec_rsc_0_7_i_qa_d),
      .vec_rsc_0_7_i_wea_d(vec_rsc_0_7_i_wea_d_reg),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_0_7_i_oswt(reg_vec_rsc_0_7_i_oswt_cse),
      .vec_rsc_0_7_i_oswt_1(reg_vec_rsc_0_7_i_oswt_1_cse),
      .vec_rsc_0_7_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_da_d_core[63:0]),
      .vec_rsc_0_7_i_qa_d_mxwt(vec_rsc_0_7_i_qa_d_mxwt),
      .vec_rsc_0_7_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_wea_d_core_psct[1:0]),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_0_7_i_oswt_pff(or_54_rmff),
      .vec_rsc_0_7_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_0_7_i_1_inst_vec_rsc_0_7_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_0_i_da_d(vec_rsc_1_0_i_da_d_reg),
      .vec_rsc_1_0_i_qa_d(vec_rsc_1_0_i_qa_d),
      .vec_rsc_1_0_i_wea_d(vec_rsc_1_0_i_wea_d_reg),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_0_i_oswt(reg_vec_rsc_1_0_i_oswt_cse),
      .vec_rsc_1_0_i_oswt_1(reg_vec_rsc_1_0_i_oswt_1_cse),
      .vec_rsc_1_0_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_da_d_core[63:0]),
      .vec_rsc_1_0_i_qa_d_mxwt(vec_rsc_1_0_i_qa_d_mxwt),
      .vec_rsc_1_0_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_0_i_oswt_pff(or_59_rmff),
      .vec_rsc_1_0_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_0_i_1_inst_vec_rsc_1_0_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_1_i_da_d(vec_rsc_1_1_i_da_d_reg),
      .vec_rsc_1_1_i_qa_d(vec_rsc_1_1_i_qa_d),
      .vec_rsc_1_1_i_wea_d(vec_rsc_1_1_i_wea_d_reg),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_1_i_oswt(reg_vec_rsc_1_1_i_oswt_cse),
      .vec_rsc_1_1_i_oswt_1(reg_vec_rsc_1_1_i_oswt_1_cse),
      .vec_rsc_1_1_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_da_d_core[63:0]),
      .vec_rsc_1_1_i_qa_d_mxwt(vec_rsc_1_1_i_qa_d_mxwt),
      .vec_rsc_1_1_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_1_i_oswt_pff(or_64_rmff),
      .vec_rsc_1_1_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_1_i_1_inst_vec_rsc_1_1_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_2_i_da_d(vec_rsc_1_2_i_da_d_reg),
      .vec_rsc_1_2_i_qa_d(vec_rsc_1_2_i_qa_d),
      .vec_rsc_1_2_i_wea_d(vec_rsc_1_2_i_wea_d_reg),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_2_i_oswt(reg_vec_rsc_1_2_i_oswt_cse),
      .vec_rsc_1_2_i_oswt_1(reg_vec_rsc_1_2_i_oswt_1_cse),
      .vec_rsc_1_2_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_da_d_core[63:0]),
      .vec_rsc_1_2_i_qa_d_mxwt(vec_rsc_1_2_i_qa_d_mxwt),
      .vec_rsc_1_2_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_2_i_oswt_pff(or_69_rmff),
      .vec_rsc_1_2_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_2_i_1_inst_vec_rsc_1_2_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_3_i_da_d(vec_rsc_1_3_i_da_d_reg),
      .vec_rsc_1_3_i_qa_d(vec_rsc_1_3_i_qa_d),
      .vec_rsc_1_3_i_wea_d(vec_rsc_1_3_i_wea_d_reg),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_3_i_oswt(reg_vec_rsc_1_3_i_oswt_cse),
      .vec_rsc_1_3_i_oswt_1(reg_vec_rsc_1_3_i_oswt_1_cse),
      .vec_rsc_1_3_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_da_d_core[63:0]),
      .vec_rsc_1_3_i_qa_d_mxwt(vec_rsc_1_3_i_qa_d_mxwt),
      .vec_rsc_1_3_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_3_i_oswt_pff(or_74_rmff),
      .vec_rsc_1_3_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_3_i_1_inst_vec_rsc_1_3_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_4_i_da_d(vec_rsc_1_4_i_da_d_reg),
      .vec_rsc_1_4_i_qa_d(vec_rsc_1_4_i_qa_d),
      .vec_rsc_1_4_i_wea_d(vec_rsc_1_4_i_wea_d_reg),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_4_i_oswt(reg_vec_rsc_1_4_i_oswt_cse),
      .vec_rsc_1_4_i_oswt_1(reg_vec_rsc_1_4_i_oswt_1_cse),
      .vec_rsc_1_4_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_da_d_core[63:0]),
      .vec_rsc_1_4_i_qa_d_mxwt(vec_rsc_1_4_i_qa_d_mxwt),
      .vec_rsc_1_4_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_4_i_oswt_pff(or_79_rmff),
      .vec_rsc_1_4_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_4_i_1_inst_vec_rsc_1_4_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_5_i_da_d(vec_rsc_1_5_i_da_d_reg),
      .vec_rsc_1_5_i_qa_d(vec_rsc_1_5_i_qa_d),
      .vec_rsc_1_5_i_wea_d(vec_rsc_1_5_i_wea_d_reg),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_5_i_oswt(reg_vec_rsc_1_5_i_oswt_cse),
      .vec_rsc_1_5_i_oswt_1(reg_vec_rsc_1_5_i_oswt_1_cse),
      .vec_rsc_1_5_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_da_d_core[63:0]),
      .vec_rsc_1_5_i_qa_d_mxwt(vec_rsc_1_5_i_qa_d_mxwt),
      .vec_rsc_1_5_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_5_i_oswt_pff(or_84_rmff),
      .vec_rsc_1_5_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_5_i_1_inst_vec_rsc_1_5_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_6_i_da_d(vec_rsc_1_6_i_da_d_reg),
      .vec_rsc_1_6_i_qa_d(vec_rsc_1_6_i_qa_d),
      .vec_rsc_1_6_i_wea_d(vec_rsc_1_6_i_wea_d_reg),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_6_i_oswt(reg_vec_rsc_1_6_i_oswt_cse),
      .vec_rsc_1_6_i_oswt_1(reg_vec_rsc_1_6_i_oswt_1_cse),
      .vec_rsc_1_6_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_da_d_core[63:0]),
      .vec_rsc_1_6_i_qa_d_mxwt(vec_rsc_1_6_i_qa_d_mxwt),
      .vec_rsc_1_6_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_6_i_oswt_pff(or_89_rmff),
      .vec_rsc_1_6_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_6_i_1_inst_vec_rsc_1_6_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1 inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsc_1_7_i_da_d(vec_rsc_1_7_i_da_d_reg),
      .vec_rsc_1_7_i_qa_d(vec_rsc_1_7_i_qa_d),
      .vec_rsc_1_7_i_wea_d(vec_rsc_1_7_i_wea_d_reg),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsc_1_7_i_oswt(reg_vec_rsc_1_7_i_oswt_cse),
      .vec_rsc_1_7_i_oswt_1(reg_vec_rsc_1_7_i_oswt_1_cse),
      .vec_rsc_1_7_i_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_da_d_core[63:0]),
      .vec_rsc_1_7_i_qa_d_mxwt(vec_rsc_1_7_i_qa_d_mxwt),
      .vec_rsc_1_7_i_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_wea_d_core_psct[1:0]),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsc_1_7_i_oswt_pff(or_94_rmff),
      .vec_rsc_1_7_i_oswt_1_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsc_1_7_i_1_inst_vec_rsc_1_7_i_oswt_1_pff[0:0])
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_0_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_0_i_qb_d(twiddle_rsc_0_0_i_qb_d),
      .twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_0_i_oswt(reg_twiddle_rsc_0_0_i_oswt_cse),
      .twiddle_rsc_0_0_i_qb_d_mxwt(twiddle_rsc_0_0_i_qb_d_mxwt),
      .twiddle_rsc_0_0_i_oswt_pff(and_373_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_1_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_1_i_qb_d(twiddle_rsc_0_1_i_qb_d),
      .twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_1_i_oswt(reg_twiddle_rsc_0_1_i_oswt_cse),
      .twiddle_rsc_0_1_i_qb_d_mxwt(twiddle_rsc_0_1_i_qb_d_mxwt),
      .twiddle_rsc_0_1_i_oswt_pff(and_375_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_2_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_2_i_qb_d(twiddle_rsc_0_2_i_qb_d),
      .twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_2_i_oswt(reg_twiddle_rsc_0_2_i_oswt_cse),
      .twiddle_rsc_0_2_i_qb_d_mxwt(twiddle_rsc_0_2_i_qb_d_mxwt),
      .twiddle_rsc_0_2_i_oswt_pff(and_377_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_3_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_3_i_qb_d(twiddle_rsc_0_3_i_qb_d),
      .twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_3_i_oswt(reg_twiddle_rsc_0_3_i_oswt_cse),
      .twiddle_rsc_0_3_i_qb_d_mxwt(twiddle_rsc_0_3_i_qb_d_mxwt),
      .twiddle_rsc_0_3_i_oswt_pff(and_379_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_4_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_4_i_qb_d(twiddle_rsc_0_4_i_qb_d),
      .twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_4_i_oswt(reg_twiddle_rsc_0_4_i_oswt_cse),
      .twiddle_rsc_0_4_i_qb_d_mxwt(twiddle_rsc_0_4_i_qb_d_mxwt),
      .twiddle_rsc_0_4_i_oswt_pff(and_381_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_5_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_5_i_qb_d(twiddle_rsc_0_5_i_qb_d),
      .twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_5_i_oswt(reg_twiddle_rsc_0_5_i_oswt_cse),
      .twiddle_rsc_0_5_i_qb_d_mxwt(twiddle_rsc_0_5_i_qb_d_mxwt),
      .twiddle_rsc_0_5_i_oswt_pff(and_383_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_6_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_6_i_qb_d(twiddle_rsc_0_6_i_qb_d),
      .twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_6_i_oswt(reg_twiddle_rsc_0_6_i_oswt_cse),
      .twiddle_rsc_0_6_i_qb_d_mxwt(twiddle_rsc_0_6_i_qb_d_mxwt),
      .twiddle_rsc_0_6_i_oswt_pff(and_385_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_0_7_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_0_7_i_qb_d(twiddle_rsc_0_7_i_qb_d),
      .twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_0_7_i_oswt(reg_twiddle_rsc_0_7_i_oswt_cse),
      .twiddle_rsc_0_7_i_qb_d_mxwt(twiddle_rsc_0_7_i_qb_d_mxwt),
      .twiddle_rsc_0_7_i_oswt_pff(and_387_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_0_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_0_i_qb_d(twiddle_rsc_1_0_i_qb_d),
      .twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_0_i_oswt(reg_twiddle_rsc_1_0_i_oswt_cse),
      .twiddle_rsc_1_0_i_qb_d_mxwt(twiddle_rsc_1_0_i_qb_d_mxwt),
      .twiddle_rsc_1_0_i_oswt_pff(and_389_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_1_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_1_i_qb_d(twiddle_rsc_1_1_i_qb_d),
      .twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_1_i_oswt(reg_twiddle_rsc_1_1_i_oswt_cse),
      .twiddle_rsc_1_1_i_qb_d_mxwt(twiddle_rsc_1_1_i_qb_d_mxwt),
      .twiddle_rsc_1_1_i_oswt_pff(and_391_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_2_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_2_i_qb_d(twiddle_rsc_1_2_i_qb_d),
      .twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_2_i_oswt(reg_twiddle_rsc_1_2_i_oswt_cse),
      .twiddle_rsc_1_2_i_qb_d_mxwt(twiddle_rsc_1_2_i_qb_d_mxwt),
      .twiddle_rsc_1_2_i_oswt_pff(and_393_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_3_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_3_i_qb_d(twiddle_rsc_1_3_i_qb_d),
      .twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_3_i_oswt(reg_twiddle_rsc_1_3_i_oswt_cse),
      .twiddle_rsc_1_3_i_qb_d_mxwt(twiddle_rsc_1_3_i_qb_d_mxwt),
      .twiddle_rsc_1_3_i_oswt_pff(and_395_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_4_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_4_i_qb_d(twiddle_rsc_1_4_i_qb_d),
      .twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_4_i_oswt(reg_twiddle_rsc_1_4_i_oswt_cse),
      .twiddle_rsc_1_4_i_qb_d_mxwt(twiddle_rsc_1_4_i_qb_d_mxwt),
      .twiddle_rsc_1_4_i_oswt_pff(and_397_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_5_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_5_i_qb_d(twiddle_rsc_1_5_i_qb_d),
      .twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_5_i_oswt(reg_twiddle_rsc_1_5_i_oswt_cse),
      .twiddle_rsc_1_5_i_qb_d_mxwt(twiddle_rsc_1_5_i_qb_d_mxwt),
      .twiddle_rsc_1_5_i_oswt_pff(and_399_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_6_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_6_i_qb_d(twiddle_rsc_1_6_i_qb_d),
      .twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_6_i_oswt(reg_twiddle_rsc_1_6_i_oswt_cse),
      .twiddle_rsc_1_6_i_qb_d_mxwt(twiddle_rsc_1_6_i_qb_d_mxwt),
      .twiddle_rsc_1_6_i_oswt_pff(and_401_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1 inPlaceNTT_DIF_precomp_core_twiddle_rsc_1_7_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsc_1_7_i_qb_d(twiddle_rsc_1_7_i_qb_d),
      .twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsc_1_7_i_oswt(reg_twiddle_rsc_1_7_i_oswt_cse),
      .twiddle_rsc_1_7_i_qb_d_mxwt(twiddle_rsc_1_7_i_qb_d_mxwt),
      .twiddle_rsc_1_7_i_oswt_pff(and_403_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_0_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_0_i_qb_d(twiddle_h_rsc_0_0_i_qb_d),
      .twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_0_i_oswt(reg_twiddle_rsc_0_0_i_oswt_cse),
      .twiddle_h_rsc_0_0_i_qb_d_mxwt(twiddle_h_rsc_0_0_i_qb_d_mxwt),
      .twiddle_h_rsc_0_0_i_oswt_pff(and_373_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_1_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_1_i_qb_d(twiddle_h_rsc_0_1_i_qb_d),
      .twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_1_i_oswt(reg_twiddle_rsc_0_1_i_oswt_cse),
      .twiddle_h_rsc_0_1_i_qb_d_mxwt(twiddle_h_rsc_0_1_i_qb_d_mxwt),
      .twiddle_h_rsc_0_1_i_oswt_pff(and_375_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_2_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_2_i_qb_d(twiddle_h_rsc_0_2_i_qb_d),
      .twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_2_i_oswt(reg_twiddle_rsc_0_2_i_oswt_cse),
      .twiddle_h_rsc_0_2_i_qb_d_mxwt(twiddle_h_rsc_0_2_i_qb_d_mxwt),
      .twiddle_h_rsc_0_2_i_oswt_pff(and_377_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_3_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_3_i_qb_d(twiddle_h_rsc_0_3_i_qb_d),
      .twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_3_i_oswt(reg_twiddle_rsc_0_3_i_oswt_cse),
      .twiddle_h_rsc_0_3_i_qb_d_mxwt(twiddle_h_rsc_0_3_i_qb_d_mxwt),
      .twiddle_h_rsc_0_3_i_oswt_pff(and_379_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_4_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_4_i_qb_d(twiddle_h_rsc_0_4_i_qb_d),
      .twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_4_i_oswt(reg_twiddle_rsc_0_4_i_oswt_cse),
      .twiddle_h_rsc_0_4_i_qb_d_mxwt(twiddle_h_rsc_0_4_i_qb_d_mxwt),
      .twiddle_h_rsc_0_4_i_oswt_pff(and_381_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_5_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_5_i_qb_d(twiddle_h_rsc_0_5_i_qb_d),
      .twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_5_i_oswt(reg_twiddle_rsc_0_5_i_oswt_cse),
      .twiddle_h_rsc_0_5_i_qb_d_mxwt(twiddle_h_rsc_0_5_i_qb_d_mxwt),
      .twiddle_h_rsc_0_5_i_oswt_pff(and_383_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_6_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_6_i_qb_d(twiddle_h_rsc_0_6_i_qb_d),
      .twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_6_i_oswt(reg_twiddle_rsc_0_6_i_oswt_cse),
      .twiddle_h_rsc_0_6_i_qb_d_mxwt(twiddle_h_rsc_0_6_i_qb_d_mxwt),
      .twiddle_h_rsc_0_6_i_oswt_pff(and_385_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_0_7_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_0_7_i_qb_d(twiddle_h_rsc_0_7_i_qb_d),
      .twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_0_7_i_oswt(reg_twiddle_rsc_0_7_i_oswt_cse),
      .twiddle_h_rsc_0_7_i_qb_d_mxwt(twiddle_h_rsc_0_7_i_qb_d_mxwt),
      .twiddle_h_rsc_0_7_i_oswt_pff(and_387_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_0_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_0_i_qb_d(twiddle_h_rsc_1_0_i_qb_d),
      .twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_0_i_oswt(reg_twiddle_rsc_1_0_i_oswt_cse),
      .twiddle_h_rsc_1_0_i_qb_d_mxwt(twiddle_h_rsc_1_0_i_qb_d_mxwt),
      .twiddle_h_rsc_1_0_i_oswt_pff(and_389_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_1_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_1_i_qb_d(twiddle_h_rsc_1_1_i_qb_d),
      .twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_1_i_oswt(reg_twiddle_rsc_1_1_i_oswt_cse),
      .twiddle_h_rsc_1_1_i_qb_d_mxwt(twiddle_h_rsc_1_1_i_qb_d_mxwt),
      .twiddle_h_rsc_1_1_i_oswt_pff(and_391_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_2_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_2_i_qb_d(twiddle_h_rsc_1_2_i_qb_d),
      .twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_2_i_oswt(reg_twiddle_rsc_1_2_i_oswt_cse),
      .twiddle_h_rsc_1_2_i_qb_d_mxwt(twiddle_h_rsc_1_2_i_qb_d_mxwt),
      .twiddle_h_rsc_1_2_i_oswt_pff(and_393_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_3_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_3_i_qb_d(twiddle_h_rsc_1_3_i_qb_d),
      .twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_3_i_oswt(reg_twiddle_rsc_1_3_i_oswt_cse),
      .twiddle_h_rsc_1_3_i_qb_d_mxwt(twiddle_h_rsc_1_3_i_qb_d_mxwt),
      .twiddle_h_rsc_1_3_i_oswt_pff(and_395_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_4_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_4_i_qb_d(twiddle_h_rsc_1_4_i_qb_d),
      .twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_4_i_oswt(reg_twiddle_rsc_1_4_i_oswt_cse),
      .twiddle_h_rsc_1_4_i_qb_d_mxwt(twiddle_h_rsc_1_4_i_qb_d_mxwt),
      .twiddle_h_rsc_1_4_i_oswt_pff(and_397_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_5_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_5_i_qb_d(twiddle_h_rsc_1_5_i_qb_d),
      .twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_5_i_oswt(reg_twiddle_rsc_1_5_i_oswt_cse),
      .twiddle_h_rsc_1_5_i_qb_d_mxwt(twiddle_h_rsc_1_5_i_qb_d_mxwt),
      .twiddle_h_rsc_1_5_i_oswt_pff(and_399_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_6_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_6_i_qb_d(twiddle_h_rsc_1_6_i_qb_d),
      .twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_6_i_oswt(reg_twiddle_rsc_1_6_i_oswt_cse),
      .twiddle_h_rsc_1_6_i_qb_d_mxwt(twiddle_h_rsc_1_6_i_qb_d_mxwt),
      .twiddle_h_rsc_1_6_i_oswt_pff(and_401_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_1_7_i_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsc_1_7_i_qb_d(twiddle_h_rsc_1_7_i_qb_d),
      .twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsc_1_7_i_oswt(reg_twiddle_rsc_1_7_i_oswt_cse),
      .twiddle_h_rsc_1_7_i_qb_d_mxwt(twiddle_h_rsc_1_7_i_qb_d_mxwt),
      .twiddle_h_rsc_1_7_i_oswt_pff(and_403_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_7_obj_inst
      (
      .vec_rsc_triosy_1_7_lz(vec_rsc_triosy_1_7_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_7_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_6_obj_inst
      (
      .vec_rsc_triosy_1_6_lz(vec_rsc_triosy_1_6_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_6_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_5_obj_inst
      (
      .vec_rsc_triosy_1_5_lz(vec_rsc_triosy_1_5_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_5_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_4_obj_inst
      (
      .vec_rsc_triosy_1_4_lz(vec_rsc_triosy_1_4_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_4_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_3_obj_inst
      (
      .vec_rsc_triosy_1_3_lz(vec_rsc_triosy_1_3_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_3_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_2_obj_inst
      (
      .vec_rsc_triosy_1_2_lz(vec_rsc_triosy_1_2_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_2_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_1_obj_inst
      (
      .vec_rsc_triosy_1_1_lz(vec_rsc_triosy_1_1_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_1_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_1_0_obj_inst
      (
      .vec_rsc_triosy_1_0_lz(vec_rsc_triosy_1_0_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_1_0_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_7_obj_inst
      (
      .vec_rsc_triosy_0_7_lz(vec_rsc_triosy_0_7_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_7_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_6_obj_inst
      (
      .vec_rsc_triosy_0_6_lz(vec_rsc_triosy_0_6_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_6_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_5_obj_inst
      (
      .vec_rsc_triosy_0_5_lz(vec_rsc_triosy_0_5_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_5_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_4_obj_inst
      (
      .vec_rsc_triosy_0_4_lz(vec_rsc_triosy_0_4_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_4_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_3_obj_inst
      (
      .vec_rsc_triosy_0_3_lz(vec_rsc_triosy_0_3_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_3_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_2_obj_inst
      (
      .vec_rsc_triosy_0_2_lz(vec_rsc_triosy_0_2_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_2_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_1_obj_inst
      (
      .vec_rsc_triosy_0_1_lz(vec_rsc_triosy_0_1_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_1_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_0_0_obj_inst
      (
      .vec_rsc_triosy_0_0_lz(vec_rsc_triosy_0_0_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_0_0_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj_inst
      (
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .core_wten(core_wten),
      .p_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj_inst
      (
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .core_wten(core_wten),
      .r_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_7_obj_inst
      (
      .twiddle_rsc_triosy_1_7_lz(twiddle_rsc_triosy_1_7_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_7_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_6_obj_inst
      (
      .twiddle_rsc_triosy_1_6_lz(twiddle_rsc_triosy_1_6_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_6_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_5_obj_inst
      (
      .twiddle_rsc_triosy_1_5_lz(twiddle_rsc_triosy_1_5_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_5_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_4_obj_inst
      (
      .twiddle_rsc_triosy_1_4_lz(twiddle_rsc_triosy_1_4_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_4_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_3_obj_inst
      (
      .twiddle_rsc_triosy_1_3_lz(twiddle_rsc_triosy_1_3_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_3_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_2_obj_inst
      (
      .twiddle_rsc_triosy_1_2_lz(twiddle_rsc_triosy_1_2_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_2_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_1_obj_inst
      (
      .twiddle_rsc_triosy_1_1_lz(twiddle_rsc_triosy_1_1_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_1_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_1_0_obj_inst
      (
      .twiddle_rsc_triosy_1_0_lz(twiddle_rsc_triosy_1_0_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_1_0_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_7_obj_inst
      (
      .twiddle_rsc_triosy_0_7_lz(twiddle_rsc_triosy_0_7_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_7_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_6_obj_inst
      (
      .twiddle_rsc_triosy_0_6_lz(twiddle_rsc_triosy_0_6_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_6_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_5_obj_inst
      (
      .twiddle_rsc_triosy_0_5_lz(twiddle_rsc_triosy_0_5_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_5_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_4_obj_inst
      (
      .twiddle_rsc_triosy_0_4_lz(twiddle_rsc_triosy_0_4_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_4_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_3_obj_inst
      (
      .twiddle_rsc_triosy_0_3_lz(twiddle_rsc_triosy_0_3_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_3_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_2_obj_inst
      (
      .twiddle_rsc_triosy_0_2_lz(twiddle_rsc_triosy_0_2_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_2_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_1_obj_inst
      (
      .twiddle_rsc_triosy_0_1_lz(twiddle_rsc_triosy_0_1_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_1_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_0_0_obj_inst
      (
      .twiddle_rsc_triosy_0_0_lz(twiddle_rsc_triosy_0_0_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_0_0_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_7_obj_inst
      (
      .twiddle_h_rsc_triosy_1_7_lz(twiddle_h_rsc_triosy_1_7_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_7_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_6_obj_inst
      (
      .twiddle_h_rsc_triosy_1_6_lz(twiddle_h_rsc_triosy_1_6_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_6_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_5_obj_inst
      (
      .twiddle_h_rsc_triosy_1_5_lz(twiddle_h_rsc_triosy_1_5_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_5_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_4_obj_inst
      (
      .twiddle_h_rsc_triosy_1_4_lz(twiddle_h_rsc_triosy_1_4_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_4_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_3_obj_inst
      (
      .twiddle_h_rsc_triosy_1_3_lz(twiddle_h_rsc_triosy_1_3_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_3_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_2_obj_inst
      (
      .twiddle_h_rsc_triosy_1_2_lz(twiddle_h_rsc_triosy_1_2_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_2_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_1_obj_inst
      (
      .twiddle_h_rsc_triosy_1_1_lz(twiddle_h_rsc_triosy_1_1_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_1_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_1_0_obj_inst
      (
      .twiddle_h_rsc_triosy_1_0_lz(twiddle_h_rsc_triosy_1_0_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_1_0_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_7_obj_inst
      (
      .twiddle_h_rsc_triosy_0_7_lz(twiddle_h_rsc_triosy_0_7_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_7_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_6_obj_inst
      (
      .twiddle_h_rsc_triosy_0_6_lz(twiddle_h_rsc_triosy_0_6_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_6_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_5_obj_inst
      (
      .twiddle_h_rsc_triosy_0_5_lz(twiddle_h_rsc_triosy_0_5_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_5_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_4_obj_inst
      (
      .twiddle_h_rsc_triosy_0_4_lz(twiddle_h_rsc_triosy_0_4_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_4_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_3_obj_inst
      (
      .twiddle_h_rsc_triosy_0_3_lz(twiddle_h_rsc_triosy_0_3_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_3_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_2_obj_inst
      (
      .twiddle_h_rsc_triosy_0_2_lz(twiddle_h_rsc_triosy_0_2_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_2_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_1_obj_inst
      (
      .twiddle_h_rsc_triosy_0_1_lz(twiddle_h_rsc_triosy_0_1_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_1_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_0_0_obj_inst
      (
      .twiddle_h_rsc_triosy_0_0_lz(twiddle_h_rsc_triosy_0_0_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_0_0_obj_iswt0(reg_vec_rsc_triosy_1_7_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_staller inPlaceNTT_DIF_precomp_core_staller_inst (
      .clk(clk),
      .rst(rst),
      .core_wten(core_wten),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_core_fsm inPlaceNTT_DIF_precomp_core_core_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .fsm_output(fsm_output),
      .main_C_0_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0[0:0]),
      .VEC_LOOP_C_11_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_VEC_LOOP_C_11_tr0[0:0]),
      .COMP_LOOP_C_4_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign or_15_rmff = and_157_cse | and_158_cse | and_159_cse;
  assign and_161_rmff = VEC_LOOP_nor_12_cse & VEC_LOOP_nor_19_cse & (fsm_output[6]);
  assign VEC_LOOP_mux1h_rmff = MUX1HOT_v_6_3_2((VEC_LOOP_acc_1_tmp[8:3]), (COMP_LOOP_twiddle_f_lshift_itm[8:3]),
      (VEC_LOOP_acc_10_cse_sva[8:3]), {(fsm_output[6]) , (fsm_output[9]) , (fsm_output[16])});
  assign VEC_LOOP_mux_4_rmff = MUX_v_32_2_2(modulo_add_cmp_return_rsc_z, mult_cmp_return_rsc_z,
      fsm_output[16]);
  assign or_21_rmff = and_157_cse | and_159_cse;
  assign or_24_rmff = and_178_cse | and_179_cse | and_180_cse;
  assign and_182_rmff = VEC_LOOP_nor_12_cse & and_dcpl_25 & (fsm_output[6]);
  assign or_26_rmff = and_178_cse | and_180_cse;
  assign or_29_rmff = and_191_cse | and_192_cse | and_193_cse;
  assign and_195_rmff = VEC_LOOP_nor_12_cse & and_dcpl_33 & (fsm_output[6]);
  assign or_31_rmff = and_191_cse | and_193_cse;
  assign or_34_rmff = and_204_cse | and_205_cse | and_206_cse;
  assign and_208_rmff = VEC_LOOP_nor_12_cse & and_dcpl_41 & (fsm_output[6]);
  assign or_36_rmff = and_204_cse | and_206_cse;
  assign or_39_rmff = and_217_cse | and_218_cse | and_219_cse;
  assign and_221_rmff = and_dcpl_49 & VEC_LOOP_nor_19_cse & (fsm_output[6]);
  assign or_41_rmff = and_217_cse | and_219_cse;
  assign or_44_rmff = and_230_cse | and_231_cse | and_232_cse;
  assign and_234_rmff = and_dcpl_49 & and_dcpl_25 & (fsm_output[6]);
  assign or_46_rmff = and_230_cse | and_232_cse;
  assign or_49_rmff = and_243_cse | and_244_cse | and_245_cse;
  assign and_247_rmff = and_dcpl_49 & and_dcpl_33 & (fsm_output[6]);
  assign or_51_rmff = and_243_cse | and_245_cse;
  assign or_54_rmff = and_256_cse | and_257_cse | and_258_cse;
  assign and_260_rmff = and_dcpl_49 & and_dcpl_41 & (fsm_output[6]);
  assign or_56_rmff = and_256_cse | and_258_cse;
  assign or_59_rmff = and_269_cse | and_270_cse | and_271_cse;
  assign and_273_rmff = and_dcpl_69 & VEC_LOOP_nor_19_cse & (fsm_output[6]);
  assign or_61_rmff = and_269_cse | and_271_cse;
  assign or_64_rmff = and_282_cse | and_283_cse | and_284_cse;
  assign and_286_rmff = and_dcpl_69 & and_dcpl_25 & (fsm_output[6]);
  assign or_66_rmff = and_282_cse | and_284_cse;
  assign or_69_rmff = and_295_cse | and_296_cse | and_297_cse;
  assign and_299_rmff = and_dcpl_69 & and_dcpl_33 & (fsm_output[6]);
  assign or_71_rmff = and_295_cse | and_297_cse;
  assign or_74_rmff = and_308_cse | and_309_cse | and_310_cse;
  assign and_312_rmff = and_dcpl_69 & and_dcpl_41 & (fsm_output[6]);
  assign or_76_rmff = and_308_cse | and_310_cse;
  assign or_79_rmff = and_321_cse | and_322_cse | and_323_cse;
  assign and_325_rmff = and_dcpl_89 & VEC_LOOP_nor_19_cse & (fsm_output[6]);
  assign or_81_rmff = and_321_cse | and_323_cse;
  assign or_84_rmff = and_334_cse | and_335_cse | and_336_cse;
  assign and_338_rmff = and_dcpl_89 & and_dcpl_25 & (fsm_output[6]);
  assign or_86_rmff = and_334_cse | and_336_cse;
  assign or_89_rmff = and_347_cse | and_348_cse | and_349_cse;
  assign and_351_rmff = and_dcpl_89 & and_dcpl_33 & (fsm_output[6]);
  assign or_91_rmff = and_347_cse | and_349_cse;
  assign or_94_rmff = and_360_cse | and_361_cse | and_362_cse;
  assign and_364_rmff = and_dcpl_89 & and_dcpl_41 & (fsm_output[6]);
  assign or_96_rmff = and_360_cse | and_362_cse;
  assign and_373_rmff = and_dcpl_104 & and_dcpl_103 & (fsm_output[4]);
  assign and_375_rmff = and_dcpl_104 & and_dcpl_106 & (fsm_output[4]);
  assign and_377_rmff = and_dcpl_104 & and_dcpl_108 & (fsm_output[4]);
  assign and_379_rmff = and_dcpl_104 & and_dcpl_110 & (fsm_output[4]);
  assign and_381_rmff = and_dcpl_112 & and_dcpl_103 & (fsm_output[4]);
  assign and_383_rmff = and_dcpl_112 & and_dcpl_106 & (fsm_output[4]);
  assign and_385_rmff = and_dcpl_112 & and_dcpl_108 & (fsm_output[4]);
  assign and_387_rmff = and_dcpl_112 & and_dcpl_110 & (fsm_output[4]);
  assign and_389_rmff = and_dcpl_117 & and_dcpl_103 & (fsm_output[4]);
  assign and_391_rmff = and_dcpl_117 & and_dcpl_106 & (fsm_output[4]);
  assign and_393_rmff = and_dcpl_117 & and_dcpl_108 & (fsm_output[4]);
  assign and_395_rmff = and_dcpl_117 & and_dcpl_110 & (fsm_output[4]);
  assign and_397_rmff = and_dcpl_122 & and_dcpl_103 & (fsm_output[4]);
  assign and_399_rmff = and_dcpl_122 & and_dcpl_106 & (fsm_output[4]);
  assign and_401_rmff = and_dcpl_122 & and_dcpl_108 & (fsm_output[4]);
  assign and_403_rmff = and_dcpl_122 & and_dcpl_110 & (fsm_output[4]);
  assign or_116_rmff = (fsm_output[15:9]!=7'b0000000);
  assign or_118_rmff = (fsm_output[9:8]!=2'b00);
  assign COMP_LOOP_twiddle_f_and_1_cse = complete_rsci_wen_comp & (fsm_output[3]);
  assign COMP_LOOP_twiddle_help_and_cse = COMP_LOOP_twiddle_f_equal_tmp & (~ or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_1_cse = (COMP_LOOP_twiddle_f_mul_cse_sva[0])
      & COMP_LOOP_twiddle_f_nor_itm & (~ or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_2_cse = (COMP_LOOP_twiddle_f_mul_cse_sva[1])
      & COMP_LOOP_twiddle_f_nor_1_itm & (~ or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_3_cse = COMP_LOOP_twiddle_f_equal_tmp_3 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_4_cse = (COMP_LOOP_twiddle_f_mul_cse_sva[2])
      & COMP_LOOP_twiddle_f_nor_3_itm & (~ or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_5_cse = COMP_LOOP_twiddle_f_equal_tmp_5 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_6_cse = COMP_LOOP_twiddle_f_equal_tmp_6 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_7_cse = COMP_LOOP_twiddle_f_equal_tmp_7 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_8_cse = (COMP_LOOP_twiddle_f_mul_cse_sva[9])
      & COMP_LOOP_twiddle_f_nor_6_itm & (~ or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_9_cse = COMP_LOOP_twiddle_f_equal_tmp_9 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_10_cse = COMP_LOOP_twiddle_f_equal_tmp_10 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_11_cse = COMP_LOOP_twiddle_f_equal_tmp_11 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_12_cse = COMP_LOOP_twiddle_f_equal_tmp_12 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_13_cse = COMP_LOOP_twiddle_f_equal_tmp_13 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_14_cse = COMP_LOOP_twiddle_f_equal_tmp_14 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_15_cse = COMP_LOOP_twiddle_f_equal_tmp_15 & (~
      or_tmp_141);
  assign COMP_LOOP_twiddle_help_and_16_cse = complete_rsci_wen_comp & (~ or_tmp_141);
  assign VEC_LOOP_and_cse = complete_rsci_wen_comp & (fsm_output[6]);
  assign VEC_LOOP_nor_12_cse = ~((VEC_LOOP_acc_10_tmp[9]) | (VEC_LOOP_acc_10_tmp[2]));
  assign VEC_LOOP_nor_19_cse = ~((VEC_LOOP_acc_10_tmp[1:0]!=2'b00));
  assign VEC_LOOP_nor_2_cse = ~((VEC_LOOP_acc_1_tmp[9]) | (VEC_LOOP_acc_1_tmp[2]));
  assign VEC_LOOP_nor_9_cse = ~((VEC_LOOP_acc_1_tmp[1:0]!=2'b00));
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b1111;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_VEC_LOOP_acc_1_tmp = COMP_LOOP_twiddle_f_lshift_itm + COMP_LOOP_k_10_0_sva_9_0;
  assign VEC_LOOP_acc_1_tmp = nl_VEC_LOOP_acc_1_tmp[9:0];
  assign nl_COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0 = COMP_LOOP_twiddle_f_lshift_itm
      * COMP_LOOP_k_10_0_sva_9_0;
  assign COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0 = nl_COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9:0];
  assign nl_VEC_LOOP_acc_10_tmp = COMP_LOOP_twiddle_f_lshift_itm + COMP_LOOP_k_10_0_sva_9_0
      + (STAGE_LOOP_lshift_psp_sva[10:1]);
  assign VEC_LOOP_acc_10_tmp = nl_VEC_LOOP_acc_10_tmp[9:0];
  assign nl_COMP_LOOP_k_10_0_sva_2 = conv_u2u_10_11(COMP_LOOP_k_10_0_sva_9_0) + 11'b00000000001;
  assign COMP_LOOP_k_10_0_sva_2 = nl_COMP_LOOP_k_10_0_sva_2[10:0];
  assign and_dcpl_7 = ~((COMP_LOOP_twiddle_f_lshift_itm[2]) | (COMP_LOOP_twiddle_f_lshift_itm[9]));
  assign and_dcpl_8 = ~((COMP_LOOP_twiddle_f_lshift_itm[1:0]!=2'b00));
  assign and_dcpl_13 = ~((VEC_LOOP_acc_10_cse_sva[2]) | (VEC_LOOP_acc_10_cse_sva[9]));
  assign and_dcpl_14 = ~((VEC_LOOP_acc_10_cse_sva[1:0]!=2'b00));
  assign and_dcpl_19 = (COMP_LOOP_twiddle_f_lshift_itm[1:0]==2'b01);
  assign and_dcpl_21 = (VEC_LOOP_acc_1_tmp[1:0]==2'b01);
  assign and_dcpl_23 = (VEC_LOOP_acc_10_cse_sva[1:0]==2'b01);
  assign and_dcpl_25 = (VEC_LOOP_acc_10_tmp[1:0]==2'b01);
  assign and_dcpl_27 = (COMP_LOOP_twiddle_f_lshift_itm[1:0]==2'b10);
  assign and_dcpl_29 = (VEC_LOOP_acc_1_tmp[1:0]==2'b10);
  assign and_dcpl_31 = (VEC_LOOP_acc_10_cse_sva[1:0]==2'b10);
  assign and_dcpl_33 = (VEC_LOOP_acc_10_tmp[1:0]==2'b10);
  assign and_dcpl_35 = (COMP_LOOP_twiddle_f_lshift_itm[1:0]==2'b11);
  assign and_dcpl_37 = (VEC_LOOP_acc_1_tmp[1:0]==2'b11);
  assign and_dcpl_39 = (VEC_LOOP_acc_10_cse_sva[1:0]==2'b11);
  assign and_dcpl_41 = (VEC_LOOP_acc_10_tmp[1:0]==2'b11);
  assign and_dcpl_43 = (COMP_LOOP_twiddle_f_lshift_itm[2]) & (~ (COMP_LOOP_twiddle_f_lshift_itm[9]));
  assign and_dcpl_45 = (~ (VEC_LOOP_acc_1_tmp[9])) & (VEC_LOOP_acc_1_tmp[2]);
  assign and_dcpl_47 = (VEC_LOOP_acc_10_cse_sva[2]) & (~ (VEC_LOOP_acc_10_cse_sva[9]));
  assign and_dcpl_49 = (~ (VEC_LOOP_acc_10_tmp[9])) & (VEC_LOOP_acc_10_tmp[2]);
  assign and_dcpl_63 = (~ (COMP_LOOP_twiddle_f_lshift_itm[2])) & (COMP_LOOP_twiddle_f_lshift_itm[9]);
  assign and_dcpl_65 = (VEC_LOOP_acc_1_tmp[9]) & (~ (VEC_LOOP_acc_1_tmp[2]));
  assign and_dcpl_67 = (~ (VEC_LOOP_acc_10_cse_sva[2])) & (VEC_LOOP_acc_10_cse_sva[9]);
  assign and_dcpl_69 = (VEC_LOOP_acc_10_tmp[9]) & (~ (VEC_LOOP_acc_10_tmp[2]));
  assign and_dcpl_83 = (COMP_LOOP_twiddle_f_lshift_itm[2]) & (COMP_LOOP_twiddle_f_lshift_itm[9]);
  assign and_dcpl_85 = (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[2]);
  assign and_dcpl_87 = (VEC_LOOP_acc_10_cse_sva[2]) & (VEC_LOOP_acc_10_cse_sva[9]);
  assign and_dcpl_89 = (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[2]);
  assign and_dcpl_103 = ~((COMP_LOOP_twiddle_f_mul_cse_sva[1:0]!=2'b00));
  assign and_dcpl_104 = ~((COMP_LOOP_twiddle_f_mul_cse_sva[9]) | (COMP_LOOP_twiddle_f_mul_cse_sva[2]));
  assign and_dcpl_106 = (COMP_LOOP_twiddle_f_mul_cse_sva[1:0]==2'b01);
  assign and_dcpl_108 = (COMP_LOOP_twiddle_f_mul_cse_sva[1:0]==2'b10);
  assign and_dcpl_110 = (COMP_LOOP_twiddle_f_mul_cse_sva[1:0]==2'b11);
  assign and_dcpl_112 = (~ (COMP_LOOP_twiddle_f_mul_cse_sva[9])) & (COMP_LOOP_twiddle_f_mul_cse_sva[2]);
  assign and_dcpl_117 = (COMP_LOOP_twiddle_f_mul_cse_sva[9]) & (~ (COMP_LOOP_twiddle_f_mul_cse_sva[2]));
  assign and_dcpl_122 = (COMP_LOOP_twiddle_f_mul_cse_sva[9]) & (COMP_LOOP_twiddle_f_mul_cse_sva[2]);
  assign and_dcpl_129 = ~((fsm_output[21]) | (fsm_output[20]) | (fsm_output[0]));
  assign and_dcpl_131 = and_dcpl_129 & (~ (fsm_output[1])) & (~ (fsm_output[19]));
  assign and_157_cse = and_dcpl_8 & and_dcpl_7 & (fsm_output[9]);
  assign and_159_cse = and_dcpl_14 & and_dcpl_13 & (fsm_output[16]);
  assign and_158_cse = VEC_LOOP_nor_2_cse & VEC_LOOP_nor_9_cse & (fsm_output[6]);
  assign and_178_cse = and_dcpl_19 & and_dcpl_7 & (fsm_output[9]);
  assign and_180_cse = and_dcpl_23 & and_dcpl_13 & (fsm_output[16]);
  assign and_179_cse = VEC_LOOP_nor_2_cse & and_dcpl_21 & (fsm_output[6]);
  assign and_191_cse = and_dcpl_27 & and_dcpl_7 & (fsm_output[9]);
  assign and_193_cse = and_dcpl_31 & and_dcpl_13 & (fsm_output[16]);
  assign and_192_cse = VEC_LOOP_nor_2_cse & and_dcpl_29 & (fsm_output[6]);
  assign and_204_cse = and_dcpl_35 & and_dcpl_7 & (fsm_output[9]);
  assign and_206_cse = and_dcpl_39 & and_dcpl_13 & (fsm_output[16]);
  assign and_205_cse = VEC_LOOP_nor_2_cse & and_dcpl_37 & (fsm_output[6]);
  assign and_217_cse = and_dcpl_8 & and_dcpl_43 & (fsm_output[9]);
  assign and_219_cse = and_dcpl_14 & and_dcpl_47 & (fsm_output[16]);
  assign and_218_cse = and_dcpl_45 & VEC_LOOP_nor_9_cse & (fsm_output[6]);
  assign and_230_cse = and_dcpl_19 & and_dcpl_43 & (fsm_output[9]);
  assign and_232_cse = and_dcpl_23 & and_dcpl_47 & (fsm_output[16]);
  assign and_231_cse = and_dcpl_45 & and_dcpl_21 & (fsm_output[6]);
  assign and_243_cse = and_dcpl_27 & and_dcpl_43 & (fsm_output[9]);
  assign and_245_cse = and_dcpl_31 & and_dcpl_47 & (fsm_output[16]);
  assign and_244_cse = and_dcpl_45 & and_dcpl_29 & (fsm_output[6]);
  assign and_256_cse = and_dcpl_35 & and_dcpl_43 & (fsm_output[9]);
  assign and_258_cse = and_dcpl_39 & and_dcpl_47 & (fsm_output[16]);
  assign and_257_cse = and_dcpl_45 & and_dcpl_37 & (fsm_output[6]);
  assign and_269_cse = and_dcpl_8 & and_dcpl_63 & (fsm_output[9]);
  assign and_271_cse = and_dcpl_14 & and_dcpl_67 & (fsm_output[16]);
  assign and_270_cse = and_dcpl_65 & VEC_LOOP_nor_9_cse & (fsm_output[6]);
  assign and_282_cse = and_dcpl_19 & and_dcpl_63 & (fsm_output[9]);
  assign and_284_cse = and_dcpl_23 & and_dcpl_67 & (fsm_output[16]);
  assign and_283_cse = and_dcpl_65 & and_dcpl_21 & (fsm_output[6]);
  assign and_295_cse = and_dcpl_27 & and_dcpl_63 & (fsm_output[9]);
  assign and_297_cse = and_dcpl_31 & and_dcpl_67 & (fsm_output[16]);
  assign and_296_cse = and_dcpl_65 & and_dcpl_29 & (fsm_output[6]);
  assign and_308_cse = and_dcpl_35 & and_dcpl_63 & (fsm_output[9]);
  assign and_310_cse = and_dcpl_39 & and_dcpl_67 & (fsm_output[16]);
  assign and_309_cse = and_dcpl_65 & and_dcpl_37 & (fsm_output[6]);
  assign and_321_cse = and_dcpl_8 & and_dcpl_83 & (fsm_output[9]);
  assign and_323_cse = and_dcpl_14 & and_dcpl_87 & (fsm_output[16]);
  assign and_322_cse = and_dcpl_85 & VEC_LOOP_nor_9_cse & (fsm_output[6]);
  assign and_334_cse = and_dcpl_19 & and_dcpl_83 & (fsm_output[9]);
  assign and_336_cse = and_dcpl_23 & and_dcpl_87 & (fsm_output[16]);
  assign and_335_cse = and_dcpl_85 & and_dcpl_21 & (fsm_output[6]);
  assign and_347_cse = and_dcpl_27 & and_dcpl_83 & (fsm_output[9]);
  assign and_349_cse = and_dcpl_31 & and_dcpl_87 & (fsm_output[16]);
  assign and_348_cse = and_dcpl_85 & and_dcpl_29 & (fsm_output[6]);
  assign and_360_cse = and_dcpl_35 & and_dcpl_83 & (fsm_output[9]);
  assign and_362_cse = and_dcpl_39 & and_dcpl_87 & (fsm_output[16]);
  assign and_361_cse = and_dcpl_85 & and_dcpl_37 & (fsm_output[6]);
  assign or_tmp_141 = ~((fsm_output[18]) | (fsm_output[3]) | (fsm_output[4]) | (fsm_output[2])
      | (fsm_output[5]) | (~ and_dcpl_131));
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ STAGE_LOOP_i_3_0_sva_2)}) + 5'b00001;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign vec_rsc_0_0_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_0_i_wea_d = vec_rsc_0_0_i_wea_d_reg;
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_0_1_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_1_i_wea_d = vec_rsc_0_1_i_wea_d_reg;
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_0_2_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_2_i_wea_d = vec_rsc_0_2_i_wea_d_reg;
  assign vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_0_3_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_3_i_wea_d = vec_rsc_0_3_i_wea_d_reg;
  assign vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_0_4_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_4_i_wea_d = vec_rsc_0_4_i_wea_d_reg;
  assign vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_0_5_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_5_i_wea_d = vec_rsc_0_5_i_wea_d_reg;
  assign vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_0_6_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_6_i_wea_d = vec_rsc_0_6_i_wea_d_reg;
  assign vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_0_7_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_0_7_i_wea_d = vec_rsc_0_7_i_wea_d_reg;
  assign vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_0_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_0_i_wea_d = vec_rsc_1_0_i_wea_d_reg;
  assign vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_1_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_1_i_wea_d = vec_rsc_1_1_i_wea_d_reg;
  assign vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_2_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_2_i_wea_d = vec_rsc_1_2_i_wea_d_reg;
  assign vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_3_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_3_i_wea_d = vec_rsc_1_3_i_wea_d_reg;
  assign vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_4_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_4_i_wea_d = vec_rsc_1_4_i_wea_d_reg;
  assign vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_5_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_5_i_wea_d = vec_rsc_1_5_i_wea_d_reg;
  assign vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_6_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_6_i_wea_d = vec_rsc_1_6_i_wea_d_reg;
  assign vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign vec_rsc_1_7_i_adra_d = {(VEC_LOOP_acc_10_tmp[8:3]) , VEC_LOOP_mux1h_rmff};
  assign vec_rsc_1_7_i_wea_d = vec_rsc_1_7_i_wea_d_reg;
  assign vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsc_0_0_i_adrb_d_pff = COMP_LOOP_twiddle_f_mul_cse_sva[8:3];
  assign twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsc_0_0_i_da_d = vec_rsc_0_0_i_da_d_reg;
  assign vec_rsc_0_1_i_da_d = vec_rsc_0_1_i_da_d_reg;
  assign vec_rsc_0_2_i_da_d = vec_rsc_0_2_i_da_d_reg;
  assign vec_rsc_0_3_i_da_d = vec_rsc_0_3_i_da_d_reg;
  assign vec_rsc_0_4_i_da_d = vec_rsc_0_4_i_da_d_reg;
  assign vec_rsc_0_5_i_da_d = vec_rsc_0_5_i_da_d_reg;
  assign vec_rsc_0_6_i_da_d = vec_rsc_0_6_i_da_d_reg;
  assign vec_rsc_0_7_i_da_d = vec_rsc_0_7_i_da_d_reg;
  assign vec_rsc_1_0_i_da_d = vec_rsc_1_0_i_da_d_reg;
  assign vec_rsc_1_1_i_da_d = vec_rsc_1_1_i_da_d_reg;
  assign vec_rsc_1_2_i_da_d = vec_rsc_1_2_i_da_d_reg;
  assign vec_rsc_1_3_i_da_d = vec_rsc_1_3_i_da_d_reg;
  assign vec_rsc_1_4_i_da_d = vec_rsc_1_4_i_da_d_reg;
  assign vec_rsc_1_5_i_da_d = vec_rsc_1_5_i_da_d_reg;
  assign vec_rsc_1_6_i_da_d = vec_rsc_1_6_i_da_d_reg;
  assign vec_rsc_1_7_i_da_d = vec_rsc_1_7_i_da_d_reg;
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp ) begin
      tmp_lpi_4_dfm <= MUX1HOT_v_32_16_2((vec_rsc_0_0_i_qa_d_mxwt[31:0]), (vec_rsc_0_1_i_qa_d_mxwt[31:0]),
          (vec_rsc_0_2_i_qa_d_mxwt[31:0]), (vec_rsc_0_3_i_qa_d_mxwt[31:0]), (vec_rsc_0_4_i_qa_d_mxwt[31:0]),
          (vec_rsc_0_5_i_qa_d_mxwt[31:0]), (vec_rsc_0_6_i_qa_d_mxwt[31:0]), (vec_rsc_0_7_i_qa_d_mxwt[31:0]),
          (vec_rsc_1_0_i_qa_d_mxwt[31:0]), (vec_rsc_1_1_i_qa_d_mxwt[31:0]), (vec_rsc_1_2_i_qa_d_mxwt[31:0]),
          (vec_rsc_1_3_i_qa_d_mxwt[31:0]), (vec_rsc_1_4_i_qa_d_mxwt[31:0]), (vec_rsc_1_5_i_qa_d_mxwt[31:0]),
          (vec_rsc_1_6_i_qa_d_mxwt[31:0]), (vec_rsc_1_7_i_qa_d_mxwt[31:0]), {VEC_LOOP_VEC_LOOP_nor_itm
          , VEC_LOOP_VEC_LOOP_and_nl , VEC_LOOP_VEC_LOOP_and_1_nl , VEC_LOOP_VEC_LOOP_and_2_itm
          , VEC_LOOP_VEC_LOOP_and_3_nl , VEC_LOOP_VEC_LOOP_and_4_itm , VEC_LOOP_VEC_LOOP_and_5_itm
          , VEC_LOOP_VEC_LOOP_and_6_itm , VEC_LOOP_VEC_LOOP_and_7_nl , VEC_LOOP_VEC_LOOP_and_8_itm
          , VEC_LOOP_VEC_LOOP_and_9_itm , VEC_LOOP_VEC_LOOP_and_10_itm , VEC_LOOP_VEC_LOOP_and_11_itm
          , VEC_LOOP_VEC_LOOP_and_12_itm , VEC_LOOP_VEC_LOOP_and_13_itm , VEC_LOOP_VEC_LOOP_and_14_itm});
      tmp_1_lpi_4_dfm <= MUX1HOT_v_32_16_2((vec_rsc_0_0_i_qa_d_mxwt[63:32]), (vec_rsc_0_1_i_qa_d_mxwt[63:32]),
          (vec_rsc_0_2_i_qa_d_mxwt[63:32]), (vec_rsc_0_3_i_qa_d_mxwt[63:32]), (vec_rsc_0_4_i_qa_d_mxwt[63:32]),
          (vec_rsc_0_5_i_qa_d_mxwt[63:32]), (vec_rsc_0_6_i_qa_d_mxwt[63:32]), (vec_rsc_0_7_i_qa_d_mxwt[63:32]),
          (vec_rsc_1_0_i_qa_d_mxwt[63:32]), (vec_rsc_1_1_i_qa_d_mxwt[63:32]), (vec_rsc_1_2_i_qa_d_mxwt[63:32]),
          (vec_rsc_1_3_i_qa_d_mxwt[63:32]), (vec_rsc_1_4_i_qa_d_mxwt[63:32]), (vec_rsc_1_5_i_qa_d_mxwt[63:32]),
          (vec_rsc_1_6_i_qa_d_mxwt[63:32]), (vec_rsc_1_7_i_qa_d_mxwt[63:32]), {VEC_LOOP_VEC_LOOP_nor_1_itm
          , VEC_LOOP_VEC_LOOP_and_15_nl , VEC_LOOP_VEC_LOOP_and_16_nl , VEC_LOOP_VEC_LOOP_and_17_itm
          , VEC_LOOP_VEC_LOOP_and_18_nl , VEC_LOOP_VEC_LOOP_and_19_itm , VEC_LOOP_VEC_LOOP_and_20_itm
          , VEC_LOOP_VEC_LOOP_and_21_itm , VEC_LOOP_VEC_LOOP_and_22_nl , VEC_LOOP_VEC_LOOP_and_23_itm
          , VEC_LOOP_VEC_LOOP_and_24_itm , VEC_LOOP_VEC_LOOP_and_25_itm , VEC_LOOP_VEC_LOOP_and_26_itm
          , VEC_LOOP_VEC_LOOP_and_27_itm , VEC_LOOP_VEC_LOOP_and_28_itm , VEC_LOOP_VEC_LOOP_and_29_itm});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_run_rsci_oswt_cse <= 1'b0;
      reg_complete_rsci_oswt_cse <= 1'b0;
      reg_vec_rsc_0_0_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_0_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_1_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_1_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_2_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_2_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_3_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_3_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_4_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_4_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_5_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_5_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_6_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_6_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_0_7_i_oswt_cse <= 1'b0;
      reg_vec_rsc_0_7_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_0_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_0_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_1_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_1_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_2_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_2_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_3_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_3_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_4_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_4_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_5_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_5_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_6_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_6_i_oswt_1_cse <= 1'b0;
      reg_vec_rsc_1_7_i_oswt_cse <= 1'b0;
      reg_vec_rsc_1_7_i_oswt_1_cse <= 1'b0;
      reg_twiddle_rsc_0_0_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_1_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_2_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_3_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_4_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_5_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_6_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_0_7_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_0_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_1_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_2_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_3_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_4_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_5_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_6_i_oswt_cse <= 1'b0;
      reg_twiddle_rsc_1_7_i_oswt_cse <= 1'b0;
      reg_vec_rsc_triosy_1_7_obj_iswt0_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      reg_ensig_cgo_1_cse <= 1'b0;
      VEC_LOOP_VEC_LOOP_nor_1_itm <= 1'b0;
      VEC_LOOP_nor_10_itm <= 1'b0;
      VEC_LOOP_nor_11_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_17_itm <= 1'b0;
      VEC_LOOP_nor_13_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_19_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_20_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_21_itm <= 1'b0;
      VEC_LOOP_nor_16_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_23_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_24_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_25_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_26_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_27_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_28_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_29_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_nor_itm <= 1'b0;
      VEC_LOOP_nor_itm <= 1'b0;
      VEC_LOOP_nor_1_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_2_itm <= 1'b0;
      VEC_LOOP_nor_3_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_4_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_5_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_6_itm <= 1'b0;
      VEC_LOOP_nor_6_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_8_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_9_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_11_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_12_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_13_itm <= 1'b0;
      VEC_LOOP_VEC_LOOP_and_14_itm <= 1'b0;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= fsm_output[0];
      reg_complete_rsci_oswt_cse <= (~ STAGE_LOOP_acc_itm_4_1) & (fsm_output[19]);
      reg_vec_rsc_0_0_i_oswt_cse <= or_15_rmff;
      reg_vec_rsc_0_0_i_oswt_1_cse <= and_161_rmff;
      reg_vec_rsc_0_1_i_oswt_cse <= or_24_rmff;
      reg_vec_rsc_0_1_i_oswt_1_cse <= and_182_rmff;
      reg_vec_rsc_0_2_i_oswt_cse <= or_29_rmff;
      reg_vec_rsc_0_2_i_oswt_1_cse <= and_195_rmff;
      reg_vec_rsc_0_3_i_oswt_cse <= or_34_rmff;
      reg_vec_rsc_0_3_i_oswt_1_cse <= and_208_rmff;
      reg_vec_rsc_0_4_i_oswt_cse <= or_39_rmff;
      reg_vec_rsc_0_4_i_oswt_1_cse <= and_221_rmff;
      reg_vec_rsc_0_5_i_oswt_cse <= or_44_rmff;
      reg_vec_rsc_0_5_i_oswt_1_cse <= and_234_rmff;
      reg_vec_rsc_0_6_i_oswt_cse <= or_49_rmff;
      reg_vec_rsc_0_6_i_oswt_1_cse <= and_247_rmff;
      reg_vec_rsc_0_7_i_oswt_cse <= or_54_rmff;
      reg_vec_rsc_0_7_i_oswt_1_cse <= and_260_rmff;
      reg_vec_rsc_1_0_i_oswt_cse <= or_59_rmff;
      reg_vec_rsc_1_0_i_oswt_1_cse <= and_273_rmff;
      reg_vec_rsc_1_1_i_oswt_cse <= or_64_rmff;
      reg_vec_rsc_1_1_i_oswt_1_cse <= and_286_rmff;
      reg_vec_rsc_1_2_i_oswt_cse <= or_69_rmff;
      reg_vec_rsc_1_2_i_oswt_1_cse <= and_299_rmff;
      reg_vec_rsc_1_3_i_oswt_cse <= or_74_rmff;
      reg_vec_rsc_1_3_i_oswt_1_cse <= and_312_rmff;
      reg_vec_rsc_1_4_i_oswt_cse <= or_79_rmff;
      reg_vec_rsc_1_4_i_oswt_1_cse <= and_325_rmff;
      reg_vec_rsc_1_5_i_oswt_cse <= or_84_rmff;
      reg_vec_rsc_1_5_i_oswt_1_cse <= and_338_rmff;
      reg_vec_rsc_1_6_i_oswt_cse <= or_89_rmff;
      reg_vec_rsc_1_6_i_oswt_1_cse <= and_351_rmff;
      reg_vec_rsc_1_7_i_oswt_cse <= or_94_rmff;
      reg_vec_rsc_1_7_i_oswt_1_cse <= and_364_rmff;
      reg_twiddle_rsc_0_0_i_oswt_cse <= and_373_rmff;
      reg_twiddle_rsc_0_1_i_oswt_cse <= and_375_rmff;
      reg_twiddle_rsc_0_2_i_oswt_cse <= and_377_rmff;
      reg_twiddle_rsc_0_3_i_oswt_cse <= and_379_rmff;
      reg_twiddle_rsc_0_4_i_oswt_cse <= and_381_rmff;
      reg_twiddle_rsc_0_5_i_oswt_cse <= and_383_rmff;
      reg_twiddle_rsc_0_6_i_oswt_cse <= and_385_rmff;
      reg_twiddle_rsc_0_7_i_oswt_cse <= and_387_rmff;
      reg_twiddle_rsc_1_0_i_oswt_cse <= and_389_rmff;
      reg_twiddle_rsc_1_1_i_oswt_cse <= and_391_rmff;
      reg_twiddle_rsc_1_2_i_oswt_cse <= and_393_rmff;
      reg_twiddle_rsc_1_3_i_oswt_cse <= and_395_rmff;
      reg_twiddle_rsc_1_4_i_oswt_cse <= and_397_rmff;
      reg_twiddle_rsc_1_5_i_oswt_cse <= and_399_rmff;
      reg_twiddle_rsc_1_6_i_oswt_cse <= and_401_rmff;
      reg_twiddle_rsc_1_7_i_oswt_cse <= and_403_rmff;
      reg_vec_rsc_triosy_1_7_obj_iswt0_cse <= fsm_output[20];
      reg_ensig_cgo_cse <= or_116_rmff;
      reg_ensig_cgo_1_cse <= or_118_rmff;
      VEC_LOOP_VEC_LOOP_nor_1_itm <= ~((VEC_LOOP_acc_10_tmp[9]) | (VEC_LOOP_acc_10_tmp[2])
          | (VEC_LOOP_acc_10_tmp[1]) | (VEC_LOOP_acc_10_tmp[0]));
      VEC_LOOP_nor_10_itm <= ~((VEC_LOOP_acc_10_tmp[9]) | (VEC_LOOP_acc_10_tmp[2])
          | (VEC_LOOP_acc_10_tmp[1]));
      VEC_LOOP_nor_11_itm <= ~((VEC_LOOP_acc_10_tmp[9]) | (VEC_LOOP_acc_10_tmp[2])
          | (VEC_LOOP_acc_10_tmp[0]));
      VEC_LOOP_VEC_LOOP_and_17_itm <= (VEC_LOOP_acc_10_tmp[1:0]==2'b11) & VEC_LOOP_nor_12_cse;
      VEC_LOOP_nor_13_itm <= ~((VEC_LOOP_acc_10_tmp[9]) | (VEC_LOOP_acc_10_tmp[1])
          | (VEC_LOOP_acc_10_tmp[0]));
      VEC_LOOP_VEC_LOOP_and_19_itm <= (VEC_LOOP_acc_10_tmp[2]) & (VEC_LOOP_acc_10_tmp[0])
          & (~((VEC_LOOP_acc_10_tmp[9]) | (VEC_LOOP_acc_10_tmp[1])));
      VEC_LOOP_VEC_LOOP_and_20_itm <= (VEC_LOOP_acc_10_tmp[2]) & (VEC_LOOP_acc_10_tmp[1])
          & (~((VEC_LOOP_acc_10_tmp[9]) | (VEC_LOOP_acc_10_tmp[0])));
      VEC_LOOP_VEC_LOOP_and_21_itm <= (VEC_LOOP_acc_10_tmp[2]) & (VEC_LOOP_acc_10_tmp[1])
          & (VEC_LOOP_acc_10_tmp[0]) & (~ (VEC_LOOP_acc_10_tmp[9]));
      VEC_LOOP_nor_16_itm <= ~((VEC_LOOP_acc_10_tmp[2:0]!=3'b000));
      VEC_LOOP_VEC_LOOP_and_23_itm <= (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[0])
          & (~((VEC_LOOP_acc_10_tmp[2:1]!=2'b00)));
      VEC_LOOP_VEC_LOOP_and_24_itm <= (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[1])
          & (~((VEC_LOOP_acc_10_tmp[2]) | (VEC_LOOP_acc_10_tmp[0])));
      VEC_LOOP_VEC_LOOP_and_25_itm <= (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[1])
          & (VEC_LOOP_acc_10_tmp[0]) & (~ (VEC_LOOP_acc_10_tmp[2]));
      VEC_LOOP_VEC_LOOP_and_26_itm <= (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[2])
          & VEC_LOOP_nor_19_cse;
      VEC_LOOP_VEC_LOOP_and_27_itm <= (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[2])
          & (VEC_LOOP_acc_10_tmp[0]) & (~ (VEC_LOOP_acc_10_tmp[1]));
      VEC_LOOP_VEC_LOOP_and_28_itm <= (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[2])
          & (VEC_LOOP_acc_10_tmp[1]) & (~ (VEC_LOOP_acc_10_tmp[0]));
      VEC_LOOP_VEC_LOOP_and_29_itm <= (VEC_LOOP_acc_10_tmp[9]) & (VEC_LOOP_acc_10_tmp[2])
          & (VEC_LOOP_acc_10_tmp[1]) & (VEC_LOOP_acc_10_tmp[0]);
      VEC_LOOP_VEC_LOOP_nor_itm <= ~((VEC_LOOP_acc_1_tmp[9]) | (VEC_LOOP_acc_1_tmp[2])
          | (VEC_LOOP_acc_1_tmp[1]) | (VEC_LOOP_acc_1_tmp[0]));
      VEC_LOOP_nor_itm <= ~((VEC_LOOP_acc_1_tmp[9]) | (VEC_LOOP_acc_1_tmp[2]) | (VEC_LOOP_acc_1_tmp[1]));
      VEC_LOOP_nor_1_itm <= ~((VEC_LOOP_acc_1_tmp[9]) | (VEC_LOOP_acc_1_tmp[2]) |
          (VEC_LOOP_acc_1_tmp[0]));
      VEC_LOOP_VEC_LOOP_and_2_itm <= (VEC_LOOP_acc_1_tmp[1:0]==2'b11) & VEC_LOOP_nor_2_cse;
      VEC_LOOP_nor_3_itm <= ~((VEC_LOOP_acc_1_tmp[9]) | (VEC_LOOP_acc_1_tmp[1]) |
          (VEC_LOOP_acc_1_tmp[0]));
      VEC_LOOP_VEC_LOOP_and_4_itm <= (VEC_LOOP_acc_1_tmp[2]) & (VEC_LOOP_acc_1_tmp[0])
          & (~((VEC_LOOP_acc_1_tmp[9]) | (VEC_LOOP_acc_1_tmp[1])));
      VEC_LOOP_VEC_LOOP_and_5_itm <= (VEC_LOOP_acc_1_tmp[2]) & (VEC_LOOP_acc_1_tmp[1])
          & (~((VEC_LOOP_acc_1_tmp[9]) | (VEC_LOOP_acc_1_tmp[0])));
      VEC_LOOP_VEC_LOOP_and_6_itm <= (VEC_LOOP_acc_1_tmp[2]) & (VEC_LOOP_acc_1_tmp[1])
          & (VEC_LOOP_acc_1_tmp[0]) & (~ (VEC_LOOP_acc_1_tmp[9]));
      VEC_LOOP_nor_6_itm <= ~((VEC_LOOP_acc_1_tmp[2:0]!=3'b000));
      VEC_LOOP_VEC_LOOP_and_8_itm <= (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[0])
          & (~((VEC_LOOP_acc_1_tmp[2:1]!=2'b00)));
      VEC_LOOP_VEC_LOOP_and_9_itm <= (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[1])
          & (~((VEC_LOOP_acc_1_tmp[2]) | (VEC_LOOP_acc_1_tmp[0])));
      VEC_LOOP_VEC_LOOP_and_11_itm <= (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[2])
          & VEC_LOOP_nor_9_cse;
      VEC_LOOP_VEC_LOOP_and_12_itm <= (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[2])
          & (VEC_LOOP_acc_1_tmp[0]) & (~ (VEC_LOOP_acc_1_tmp[1]));
      VEC_LOOP_VEC_LOOP_and_13_itm <= (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[2])
          & (VEC_LOOP_acc_1_tmp[1]) & (~ (VEC_LOOP_acc_1_tmp[0]));
      VEC_LOOP_VEC_LOOP_and_14_itm <= (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[2])
          & (VEC_LOOP_acc_1_tmp[1]) & (VEC_LOOP_acc_1_tmp[0]);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((fsm_output[19]) | (fsm_output[0])) ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b1010, STAGE_LOOP_i_3_0_sva_2, fsm_output[19]);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~ and_dcpl_129) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~ and_dcpl_131) ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((fsm_output[1]) | (fsm_output[18])) ) begin
      COMP_LOOP_k_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (COMP_LOOP_k_10_0_sva_2[9:0]),
          COMP_LOOP_k_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_twiddle_f_lshift_itm <= 10'b0000000000;
    end
    else if ( ((fsm_output[17]) | (fsm_output[6]) | (fsm_output[2]) | (fsm_output[5]))
        & complete_rsci_wen_comp ) begin
      COMP_LOOP_twiddle_f_lshift_itm <= MUX_v_10_2_2(10'b0000000000, COMP_LOOP_twiddle_f_mux1h_1_nl,
          COMP_LOOP_twiddle_f_not_7_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_twiddle_f_mul_cse_sva <= 10'b0000000000;
      COMP_LOOP_twiddle_f_equal_tmp <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_3 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_5 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_6 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_7 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_9 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_10 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_11 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_12 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_13 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_14 <= 1'b0;
      COMP_LOOP_twiddle_f_equal_tmp_15 <= 1'b0;
      COMP_LOOP_twiddle_f_nor_6_itm <= 1'b0;
      COMP_LOOP_twiddle_f_nor_3_itm <= 1'b0;
      COMP_LOOP_twiddle_f_nor_1_itm <= 1'b0;
      COMP_LOOP_twiddle_f_nor_itm <= 1'b0;
    end
    else if ( COMP_LOOP_twiddle_f_and_1_cse ) begin
      COMP_LOOP_twiddle_f_mul_cse_sva <= COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0;
      COMP_LOOP_twiddle_f_equal_tmp <= ~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]) | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]));
      COMP_LOOP_twiddle_f_equal_tmp_3 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]) & (~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2])));
      COMP_LOOP_twiddle_f_equal_tmp_5 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]) & (~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1])));
      COMP_LOOP_twiddle_f_equal_tmp_6 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1]) & (~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0])));
      COMP_LOOP_twiddle_f_equal_tmp_7 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1]) & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0])
          & (~ (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9]));
      COMP_LOOP_twiddle_f_equal_tmp_9 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]) & (~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2:1]!=2'b00)));
      COMP_LOOP_twiddle_f_equal_tmp_10 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1]) & (~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0])));
      COMP_LOOP_twiddle_f_equal_tmp_11 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1]) & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0])
          & (~ (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]));
      COMP_LOOP_twiddle_f_equal_tmp_12 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]) & (~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1:0]!=2'b00)));
      COMP_LOOP_twiddle_f_equal_tmp_13 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]) & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0])
          & (~ (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1]));
      COMP_LOOP_twiddle_f_equal_tmp_14 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]) & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1])
          & (~ (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]));
      COMP_LOOP_twiddle_f_equal_tmp_15 <= (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]) & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1])
          & (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]);
      COMP_LOOP_twiddle_f_nor_6_itm <= ~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2:0]!=3'b000));
      COMP_LOOP_twiddle_f_nor_3_itm <= ~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1]) | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]));
      COMP_LOOP_twiddle_f_nor_1_itm <= ~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]) | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[0]));
      COMP_LOOP_twiddle_f_nor_itm <= ~((COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[9])
          | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[2]) | (COMP_LOOP_twiddle_f_mul_cse_sva_mx0w0[1]));
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_16_cse ) begin
      tmp_3_lpi_3_dfm <= MUX1HOT_v_32_16_2(twiddle_h_rsc_0_0_i_qb_d_mxwt, twiddle_h_rsc_0_1_i_qb_d_mxwt,
          twiddle_h_rsc_0_2_i_qb_d_mxwt, twiddle_h_rsc_0_3_i_qb_d_mxwt, twiddle_h_rsc_0_4_i_qb_d_mxwt,
          twiddle_h_rsc_0_5_i_qb_d_mxwt, twiddle_h_rsc_0_6_i_qb_d_mxwt, twiddle_h_rsc_0_7_i_qb_d_mxwt,
          twiddle_h_rsc_1_0_i_qb_d_mxwt, twiddle_h_rsc_1_1_i_qb_d_mxwt, twiddle_h_rsc_1_2_i_qb_d_mxwt,
          twiddle_h_rsc_1_3_i_qb_d_mxwt, twiddle_h_rsc_1_4_i_qb_d_mxwt, twiddle_h_rsc_1_5_i_qb_d_mxwt,
          twiddle_h_rsc_1_6_i_qb_d_mxwt, twiddle_h_rsc_1_7_i_qb_d_mxwt, {COMP_LOOP_twiddle_help_and_cse
          , COMP_LOOP_twiddle_help_and_1_cse , COMP_LOOP_twiddle_help_and_2_cse ,
          COMP_LOOP_twiddle_help_and_3_cse , COMP_LOOP_twiddle_help_and_4_cse , COMP_LOOP_twiddle_help_and_5_cse
          , COMP_LOOP_twiddle_help_and_6_cse , COMP_LOOP_twiddle_help_and_7_cse ,
          COMP_LOOP_twiddle_help_and_8_cse , COMP_LOOP_twiddle_help_and_9_cse , COMP_LOOP_twiddle_help_and_10_cse
          , COMP_LOOP_twiddle_help_and_11_cse , COMP_LOOP_twiddle_help_and_12_cse
          , COMP_LOOP_twiddle_help_and_13_cse , COMP_LOOP_twiddle_help_and_14_cse
          , COMP_LOOP_twiddle_help_and_15_cse});
      tmp_2_lpi_3_dfm <= MUX1HOT_v_32_16_2(twiddle_rsc_0_0_i_qb_d_mxwt, twiddle_rsc_0_1_i_qb_d_mxwt,
          twiddle_rsc_0_2_i_qb_d_mxwt, twiddle_rsc_0_3_i_qb_d_mxwt, twiddle_rsc_0_4_i_qb_d_mxwt,
          twiddle_rsc_0_5_i_qb_d_mxwt, twiddle_rsc_0_6_i_qb_d_mxwt, twiddle_rsc_0_7_i_qb_d_mxwt,
          twiddle_rsc_1_0_i_qb_d_mxwt, twiddle_rsc_1_1_i_qb_d_mxwt, twiddle_rsc_1_2_i_qb_d_mxwt,
          twiddle_rsc_1_3_i_qb_d_mxwt, twiddle_rsc_1_4_i_qb_d_mxwt, twiddle_rsc_1_5_i_qb_d_mxwt,
          twiddle_rsc_1_6_i_qb_d_mxwt, twiddle_rsc_1_7_i_qb_d_mxwt, {COMP_LOOP_twiddle_help_and_cse
          , COMP_LOOP_twiddle_help_and_1_cse , COMP_LOOP_twiddle_help_and_2_cse ,
          COMP_LOOP_twiddle_help_and_3_cse , COMP_LOOP_twiddle_help_and_4_cse , COMP_LOOP_twiddle_help_and_5_cse
          , COMP_LOOP_twiddle_help_and_6_cse , COMP_LOOP_twiddle_help_and_7_cse ,
          COMP_LOOP_twiddle_help_and_8_cse , COMP_LOOP_twiddle_help_and_9_cse , COMP_LOOP_twiddle_help_and_10_cse
          , COMP_LOOP_twiddle_help_and_11_cse , COMP_LOOP_twiddle_help_and_12_cse
          , COMP_LOOP_twiddle_help_and_13_cse , COMP_LOOP_twiddle_help_and_14_cse
          , COMP_LOOP_twiddle_help_and_15_cse});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_acc_10_cse_sva <= 10'b0000000000;
      VEC_LOOP_j_10_0_sva_1 <= 11'b00000000000;
    end
    else if ( VEC_LOOP_and_cse ) begin
      VEC_LOOP_acc_10_cse_sva <= VEC_LOOP_acc_10_tmp;
      VEC_LOOP_j_10_0_sva_1 <= nl_VEC_LOOP_j_10_0_sva_1[10:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_VEC_LOOP_and_10_itm <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & ((fsm_output[20]) | (fsm_output[6])) ) begin
      VEC_LOOP_VEC_LOOP_and_10_itm <= MUX_s_1_2_2(VEC_LOOP_VEC_LOOP_and_10_nl, run_rsci_ivld_mxwt,
          fsm_output[20]);
    end
  end
  assign VEC_LOOP_VEC_LOOP_and_nl = (COMP_LOOP_twiddle_f_lshift_itm[0]) & VEC_LOOP_nor_itm;
  assign VEC_LOOP_VEC_LOOP_and_1_nl = (COMP_LOOP_twiddle_f_lshift_itm[1]) & VEC_LOOP_nor_1_itm;
  assign VEC_LOOP_VEC_LOOP_and_3_nl = (COMP_LOOP_twiddle_f_lshift_itm[2]) & VEC_LOOP_nor_3_itm;
  assign VEC_LOOP_VEC_LOOP_and_7_nl = (COMP_LOOP_twiddle_f_lshift_itm[9]) & VEC_LOOP_nor_6_itm;
  assign VEC_LOOP_VEC_LOOP_and_15_nl = (VEC_LOOP_acc_10_cse_sva[0]) & VEC_LOOP_nor_10_itm;
  assign VEC_LOOP_VEC_LOOP_and_16_nl = (VEC_LOOP_acc_10_cse_sva[1]) & VEC_LOOP_nor_11_itm;
  assign VEC_LOOP_VEC_LOOP_and_18_nl = (VEC_LOOP_acc_10_cse_sva[2]) & VEC_LOOP_nor_13_itm;
  assign VEC_LOOP_VEC_LOOP_and_22_nl = (VEC_LOOP_acc_10_cse_sva[9]) & VEC_LOOP_nor_16_itm;
  assign COMP_LOOP_k_not_1_nl = ~ (fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_1_nl = MUX1HOT_v_10_3_2((z_out[9:0]), VEC_LOOP_acc_1_tmp,
      (VEC_LOOP_j_10_0_sva_1[9:0]), {(fsm_output[2]) , (fsm_output[6]) , (fsm_output[17])});
  assign COMP_LOOP_twiddle_f_not_7_nl = ~ (fsm_output[5]);
  assign nl_VEC_LOOP_j_10_0_sva_1  = conv_u2u_10_11(COMP_LOOP_twiddle_f_lshift_itm)
      + STAGE_LOOP_lshift_psp_sva;
  assign VEC_LOOP_VEC_LOOP_and_10_nl = (VEC_LOOP_acc_1_tmp[9]) & (VEC_LOOP_acc_1_tmp[1])
      & (VEC_LOOP_acc_1_tmp[0]) & (~ (VEC_LOOP_acc_1_tmp[2]));

  function automatic [9:0] MUX1HOT_v_10_3_2;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [2:0] sel;
    reg [9:0] result;
  begin
    result = input_0 & {10{sel[0]}};
    result = result | ( input_1 & {10{sel[1]}});
    result = result | ( input_2 & {10{sel[2]}});
    MUX1HOT_v_10_3_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_16_2;
    input [31:0] input_15;
    input [31:0] input_14;
    input [31:0] input_13;
    input [31:0] input_12;
    input [31:0] input_11;
    input [31:0] input_10;
    input [31:0] input_9;
    input [31:0] input_8;
    input [31:0] input_7;
    input [31:0] input_6;
    input [31:0] input_5;
    input [31:0] input_4;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [15:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    result = result | ( input_4 & {32{sel[4]}});
    result = result | ( input_5 & {32{sel[5]}});
    result = result | ( input_6 & {32{sel[6]}});
    result = result | ( input_7 & {32{sel[7]}});
    result = result | ( input_8 & {32{sel[8]}});
    result = result | ( input_9 & {32{sel[9]}});
    result = result | ( input_10 & {32{sel[10]}});
    result = result | ( input_11 & {32{sel[11]}});
    result = result | ( input_12 & {32{sel[12]}});
    result = result | ( input_13 & {32{sel[13]}});
    result = result | ( input_14 & {32{sel[14]}});
    result = result | ( input_15 & {32{sel[15]}});
    MUX1HOT_v_32_16_2 = result;
  end
  endfunction


  function automatic [5:0] MUX1HOT_v_6_3_2;
    input [5:0] input_2;
    input [5:0] input_1;
    input [5:0] input_0;
    input [2:0] sel;
    reg [5:0] result;
  begin
    result = input_0 & {6{sel[0]}};
    result = result | ( input_1 & {6{sel[1]}});
    result = result | ( input_2 & {6{sel[2]}});
    MUX1HOT_v_6_3_2 = result;
  end
  endfunction


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


  function automatic [9:0] MUX_v_10_2_2;
    input [9:0] input_0;
    input [9:0] input_1;
    input [0:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_10_2_2 = result;
  end
  endfunction


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


  function automatic [3:0] MUX_v_4_2_2;
    input [3:0] input_0;
    input [3:0] input_1;
    input [0:0] sel;
    reg [3:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_4_2_2 = result;
  end
  endfunction


  function automatic [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_5_1_4;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 4;
    readslicef_5_1_4 = tmp[0:0];
  end
  endfunction


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp (
  clk, rst, run_rsc_rdy, run_rsc_vld, vec_rsc_0_0_adra, vec_rsc_0_0_da, vec_rsc_0_0_wea,
      vec_rsc_0_0_qa, vec_rsc_0_0_adrb, vec_rsc_0_0_db, vec_rsc_0_0_web, vec_rsc_0_0_qb,
      vec_rsc_triosy_0_0_lz, vec_rsc_0_1_adra, vec_rsc_0_1_da, vec_rsc_0_1_wea, vec_rsc_0_1_qa,
      vec_rsc_0_1_adrb, vec_rsc_0_1_db, vec_rsc_0_1_web, vec_rsc_0_1_qb, vec_rsc_triosy_0_1_lz,
      vec_rsc_0_2_adra, vec_rsc_0_2_da, vec_rsc_0_2_wea, vec_rsc_0_2_qa, vec_rsc_0_2_adrb,
      vec_rsc_0_2_db, vec_rsc_0_2_web, vec_rsc_0_2_qb, vec_rsc_triosy_0_2_lz, vec_rsc_0_3_adra,
      vec_rsc_0_3_da, vec_rsc_0_3_wea, vec_rsc_0_3_qa, vec_rsc_0_3_adrb, vec_rsc_0_3_db,
      vec_rsc_0_3_web, vec_rsc_0_3_qb, vec_rsc_triosy_0_3_lz, vec_rsc_0_4_adra, vec_rsc_0_4_da,
      vec_rsc_0_4_wea, vec_rsc_0_4_qa, vec_rsc_0_4_adrb, vec_rsc_0_4_db, vec_rsc_0_4_web,
      vec_rsc_0_4_qb, vec_rsc_triosy_0_4_lz, vec_rsc_0_5_adra, vec_rsc_0_5_da, vec_rsc_0_5_wea,
      vec_rsc_0_5_qa, vec_rsc_0_5_adrb, vec_rsc_0_5_db, vec_rsc_0_5_web, vec_rsc_0_5_qb,
      vec_rsc_triosy_0_5_lz, vec_rsc_0_6_adra, vec_rsc_0_6_da, vec_rsc_0_6_wea, vec_rsc_0_6_qa,
      vec_rsc_0_6_adrb, vec_rsc_0_6_db, vec_rsc_0_6_web, vec_rsc_0_6_qb, vec_rsc_triosy_0_6_lz,
      vec_rsc_0_7_adra, vec_rsc_0_7_da, vec_rsc_0_7_wea, vec_rsc_0_7_qa, vec_rsc_0_7_adrb,
      vec_rsc_0_7_db, vec_rsc_0_7_web, vec_rsc_0_7_qb, vec_rsc_triosy_0_7_lz, vec_rsc_1_0_adra,
      vec_rsc_1_0_da, vec_rsc_1_0_wea, vec_rsc_1_0_qa, vec_rsc_1_0_adrb, vec_rsc_1_0_db,
      vec_rsc_1_0_web, vec_rsc_1_0_qb, vec_rsc_triosy_1_0_lz, vec_rsc_1_1_adra, vec_rsc_1_1_da,
      vec_rsc_1_1_wea, vec_rsc_1_1_qa, vec_rsc_1_1_adrb, vec_rsc_1_1_db, vec_rsc_1_1_web,
      vec_rsc_1_1_qb, vec_rsc_triosy_1_1_lz, vec_rsc_1_2_adra, vec_rsc_1_2_da, vec_rsc_1_2_wea,
      vec_rsc_1_2_qa, vec_rsc_1_2_adrb, vec_rsc_1_2_db, vec_rsc_1_2_web, vec_rsc_1_2_qb,
      vec_rsc_triosy_1_2_lz, vec_rsc_1_3_adra, vec_rsc_1_3_da, vec_rsc_1_3_wea, vec_rsc_1_3_qa,
      vec_rsc_1_3_adrb, vec_rsc_1_3_db, vec_rsc_1_3_web, vec_rsc_1_3_qb, vec_rsc_triosy_1_3_lz,
      vec_rsc_1_4_adra, vec_rsc_1_4_da, vec_rsc_1_4_wea, vec_rsc_1_4_qa, vec_rsc_1_4_adrb,
      vec_rsc_1_4_db, vec_rsc_1_4_web, vec_rsc_1_4_qb, vec_rsc_triosy_1_4_lz, vec_rsc_1_5_adra,
      vec_rsc_1_5_da, vec_rsc_1_5_wea, vec_rsc_1_5_qa, vec_rsc_1_5_adrb, vec_rsc_1_5_db,
      vec_rsc_1_5_web, vec_rsc_1_5_qb, vec_rsc_triosy_1_5_lz, vec_rsc_1_6_adra, vec_rsc_1_6_da,
      vec_rsc_1_6_wea, vec_rsc_1_6_qa, vec_rsc_1_6_adrb, vec_rsc_1_6_db, vec_rsc_1_6_web,
      vec_rsc_1_6_qb, vec_rsc_triosy_1_6_lz, vec_rsc_1_7_adra, vec_rsc_1_7_da, vec_rsc_1_7_wea,
      vec_rsc_1_7_qa, vec_rsc_1_7_adrb, vec_rsc_1_7_db, vec_rsc_1_7_web, vec_rsc_1_7_qb,
      vec_rsc_triosy_1_7_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz,
      twiddle_rsc_0_0_adrb, twiddle_rsc_0_0_qb, twiddle_rsc_triosy_0_0_lz, twiddle_rsc_0_1_adrb,
      twiddle_rsc_0_1_qb, twiddle_rsc_triosy_0_1_lz, twiddle_rsc_0_2_adrb, twiddle_rsc_0_2_qb,
      twiddle_rsc_triosy_0_2_lz, twiddle_rsc_0_3_adrb, twiddle_rsc_0_3_qb, twiddle_rsc_triosy_0_3_lz,
      twiddle_rsc_0_4_adrb, twiddle_rsc_0_4_qb, twiddle_rsc_triosy_0_4_lz, twiddle_rsc_0_5_adrb,
      twiddle_rsc_0_5_qb, twiddle_rsc_triosy_0_5_lz, twiddle_rsc_0_6_adrb, twiddle_rsc_0_6_qb,
      twiddle_rsc_triosy_0_6_lz, twiddle_rsc_0_7_adrb, twiddle_rsc_0_7_qb, twiddle_rsc_triosy_0_7_lz,
      twiddle_rsc_1_0_adrb, twiddle_rsc_1_0_qb, twiddle_rsc_triosy_1_0_lz, twiddle_rsc_1_1_adrb,
      twiddle_rsc_1_1_qb, twiddle_rsc_triosy_1_1_lz, twiddle_rsc_1_2_adrb, twiddle_rsc_1_2_qb,
      twiddle_rsc_triosy_1_2_lz, twiddle_rsc_1_3_adrb, twiddle_rsc_1_3_qb, twiddle_rsc_triosy_1_3_lz,
      twiddle_rsc_1_4_adrb, twiddle_rsc_1_4_qb, twiddle_rsc_triosy_1_4_lz, twiddle_rsc_1_5_adrb,
      twiddle_rsc_1_5_qb, twiddle_rsc_triosy_1_5_lz, twiddle_rsc_1_6_adrb, twiddle_rsc_1_6_qb,
      twiddle_rsc_triosy_1_6_lz, twiddle_rsc_1_7_adrb, twiddle_rsc_1_7_qb, twiddle_rsc_triosy_1_7_lz,
      twiddle_h_rsc_0_0_adrb, twiddle_h_rsc_0_0_qb, twiddle_h_rsc_triosy_0_0_lz,
      twiddle_h_rsc_0_1_adrb, twiddle_h_rsc_0_1_qb, twiddle_h_rsc_triosy_0_1_lz,
      twiddle_h_rsc_0_2_adrb, twiddle_h_rsc_0_2_qb, twiddle_h_rsc_triosy_0_2_lz,
      twiddle_h_rsc_0_3_adrb, twiddle_h_rsc_0_3_qb, twiddle_h_rsc_triosy_0_3_lz,
      twiddle_h_rsc_0_4_adrb, twiddle_h_rsc_0_4_qb, twiddle_h_rsc_triosy_0_4_lz,
      twiddle_h_rsc_0_5_adrb, twiddle_h_rsc_0_5_qb, twiddle_h_rsc_triosy_0_5_lz,
      twiddle_h_rsc_0_6_adrb, twiddle_h_rsc_0_6_qb, twiddle_h_rsc_triosy_0_6_lz,
      twiddle_h_rsc_0_7_adrb, twiddle_h_rsc_0_7_qb, twiddle_h_rsc_triosy_0_7_lz,
      twiddle_h_rsc_1_0_adrb, twiddle_h_rsc_1_0_qb, twiddle_h_rsc_triosy_1_0_lz,
      twiddle_h_rsc_1_1_adrb, twiddle_h_rsc_1_1_qb, twiddle_h_rsc_triosy_1_1_lz,
      twiddle_h_rsc_1_2_adrb, twiddle_h_rsc_1_2_qb, twiddle_h_rsc_triosy_1_2_lz,
      twiddle_h_rsc_1_3_adrb, twiddle_h_rsc_1_3_qb, twiddle_h_rsc_triosy_1_3_lz,
      twiddle_h_rsc_1_4_adrb, twiddle_h_rsc_1_4_qb, twiddle_h_rsc_triosy_1_4_lz,
      twiddle_h_rsc_1_5_adrb, twiddle_h_rsc_1_5_qb, twiddle_h_rsc_triosy_1_5_lz,
      twiddle_h_rsc_1_6_adrb, twiddle_h_rsc_1_6_qb, twiddle_h_rsc_triosy_1_6_lz,
      twiddle_h_rsc_1_7_adrb, twiddle_h_rsc_1_7_qb, twiddle_h_rsc_triosy_1_7_lz,
      complete_rsc_rdy, complete_rsc_vld
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output [5:0] vec_rsc_0_0_adra;
  output [31:0] vec_rsc_0_0_da;
  output vec_rsc_0_0_wea;
  input [31:0] vec_rsc_0_0_qa;
  output [5:0] vec_rsc_0_0_adrb;
  output [31:0] vec_rsc_0_0_db;
  output vec_rsc_0_0_web;
  input [31:0] vec_rsc_0_0_qb;
  output vec_rsc_triosy_0_0_lz;
  output [5:0] vec_rsc_0_1_adra;
  output [31:0] vec_rsc_0_1_da;
  output vec_rsc_0_1_wea;
  input [31:0] vec_rsc_0_1_qa;
  output [5:0] vec_rsc_0_1_adrb;
  output [31:0] vec_rsc_0_1_db;
  output vec_rsc_0_1_web;
  input [31:0] vec_rsc_0_1_qb;
  output vec_rsc_triosy_0_1_lz;
  output [5:0] vec_rsc_0_2_adra;
  output [31:0] vec_rsc_0_2_da;
  output vec_rsc_0_2_wea;
  input [31:0] vec_rsc_0_2_qa;
  output [5:0] vec_rsc_0_2_adrb;
  output [31:0] vec_rsc_0_2_db;
  output vec_rsc_0_2_web;
  input [31:0] vec_rsc_0_2_qb;
  output vec_rsc_triosy_0_2_lz;
  output [5:0] vec_rsc_0_3_adra;
  output [31:0] vec_rsc_0_3_da;
  output vec_rsc_0_3_wea;
  input [31:0] vec_rsc_0_3_qa;
  output [5:0] vec_rsc_0_3_adrb;
  output [31:0] vec_rsc_0_3_db;
  output vec_rsc_0_3_web;
  input [31:0] vec_rsc_0_3_qb;
  output vec_rsc_triosy_0_3_lz;
  output [5:0] vec_rsc_0_4_adra;
  output [31:0] vec_rsc_0_4_da;
  output vec_rsc_0_4_wea;
  input [31:0] vec_rsc_0_4_qa;
  output [5:0] vec_rsc_0_4_adrb;
  output [31:0] vec_rsc_0_4_db;
  output vec_rsc_0_4_web;
  input [31:0] vec_rsc_0_4_qb;
  output vec_rsc_triosy_0_4_lz;
  output [5:0] vec_rsc_0_5_adra;
  output [31:0] vec_rsc_0_5_da;
  output vec_rsc_0_5_wea;
  input [31:0] vec_rsc_0_5_qa;
  output [5:0] vec_rsc_0_5_adrb;
  output [31:0] vec_rsc_0_5_db;
  output vec_rsc_0_5_web;
  input [31:0] vec_rsc_0_5_qb;
  output vec_rsc_triosy_0_5_lz;
  output [5:0] vec_rsc_0_6_adra;
  output [31:0] vec_rsc_0_6_da;
  output vec_rsc_0_6_wea;
  input [31:0] vec_rsc_0_6_qa;
  output [5:0] vec_rsc_0_6_adrb;
  output [31:0] vec_rsc_0_6_db;
  output vec_rsc_0_6_web;
  input [31:0] vec_rsc_0_6_qb;
  output vec_rsc_triosy_0_6_lz;
  output [5:0] vec_rsc_0_7_adra;
  output [31:0] vec_rsc_0_7_da;
  output vec_rsc_0_7_wea;
  input [31:0] vec_rsc_0_7_qa;
  output [5:0] vec_rsc_0_7_adrb;
  output [31:0] vec_rsc_0_7_db;
  output vec_rsc_0_7_web;
  input [31:0] vec_rsc_0_7_qb;
  output vec_rsc_triosy_0_7_lz;
  output [5:0] vec_rsc_1_0_adra;
  output [31:0] vec_rsc_1_0_da;
  output vec_rsc_1_0_wea;
  input [31:0] vec_rsc_1_0_qa;
  output [5:0] vec_rsc_1_0_adrb;
  output [31:0] vec_rsc_1_0_db;
  output vec_rsc_1_0_web;
  input [31:0] vec_rsc_1_0_qb;
  output vec_rsc_triosy_1_0_lz;
  output [5:0] vec_rsc_1_1_adra;
  output [31:0] vec_rsc_1_1_da;
  output vec_rsc_1_1_wea;
  input [31:0] vec_rsc_1_1_qa;
  output [5:0] vec_rsc_1_1_adrb;
  output [31:0] vec_rsc_1_1_db;
  output vec_rsc_1_1_web;
  input [31:0] vec_rsc_1_1_qb;
  output vec_rsc_triosy_1_1_lz;
  output [5:0] vec_rsc_1_2_adra;
  output [31:0] vec_rsc_1_2_da;
  output vec_rsc_1_2_wea;
  input [31:0] vec_rsc_1_2_qa;
  output [5:0] vec_rsc_1_2_adrb;
  output [31:0] vec_rsc_1_2_db;
  output vec_rsc_1_2_web;
  input [31:0] vec_rsc_1_2_qb;
  output vec_rsc_triosy_1_2_lz;
  output [5:0] vec_rsc_1_3_adra;
  output [31:0] vec_rsc_1_3_da;
  output vec_rsc_1_3_wea;
  input [31:0] vec_rsc_1_3_qa;
  output [5:0] vec_rsc_1_3_adrb;
  output [31:0] vec_rsc_1_3_db;
  output vec_rsc_1_3_web;
  input [31:0] vec_rsc_1_3_qb;
  output vec_rsc_triosy_1_3_lz;
  output [5:0] vec_rsc_1_4_adra;
  output [31:0] vec_rsc_1_4_da;
  output vec_rsc_1_4_wea;
  input [31:0] vec_rsc_1_4_qa;
  output [5:0] vec_rsc_1_4_adrb;
  output [31:0] vec_rsc_1_4_db;
  output vec_rsc_1_4_web;
  input [31:0] vec_rsc_1_4_qb;
  output vec_rsc_triosy_1_4_lz;
  output [5:0] vec_rsc_1_5_adra;
  output [31:0] vec_rsc_1_5_da;
  output vec_rsc_1_5_wea;
  input [31:0] vec_rsc_1_5_qa;
  output [5:0] vec_rsc_1_5_adrb;
  output [31:0] vec_rsc_1_5_db;
  output vec_rsc_1_5_web;
  input [31:0] vec_rsc_1_5_qb;
  output vec_rsc_triosy_1_5_lz;
  output [5:0] vec_rsc_1_6_adra;
  output [31:0] vec_rsc_1_6_da;
  output vec_rsc_1_6_wea;
  input [31:0] vec_rsc_1_6_qa;
  output [5:0] vec_rsc_1_6_adrb;
  output [31:0] vec_rsc_1_6_db;
  output vec_rsc_1_6_web;
  input [31:0] vec_rsc_1_6_qb;
  output vec_rsc_triosy_1_6_lz;
  output [5:0] vec_rsc_1_7_adra;
  output [31:0] vec_rsc_1_7_da;
  output vec_rsc_1_7_wea;
  input [31:0] vec_rsc_1_7_qa;
  output [5:0] vec_rsc_1_7_adrb;
  output [31:0] vec_rsc_1_7_db;
  output vec_rsc_1_7_web;
  input [31:0] vec_rsc_1_7_qb;
  output vec_rsc_triosy_1_7_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [31:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [5:0] twiddle_rsc_0_0_adrb;
  input [31:0] twiddle_rsc_0_0_qb;
  output twiddle_rsc_triosy_0_0_lz;
  output [5:0] twiddle_rsc_0_1_adrb;
  input [31:0] twiddle_rsc_0_1_qb;
  output twiddle_rsc_triosy_0_1_lz;
  output [5:0] twiddle_rsc_0_2_adrb;
  input [31:0] twiddle_rsc_0_2_qb;
  output twiddle_rsc_triosy_0_2_lz;
  output [5:0] twiddle_rsc_0_3_adrb;
  input [31:0] twiddle_rsc_0_3_qb;
  output twiddle_rsc_triosy_0_3_lz;
  output [5:0] twiddle_rsc_0_4_adrb;
  input [31:0] twiddle_rsc_0_4_qb;
  output twiddle_rsc_triosy_0_4_lz;
  output [5:0] twiddle_rsc_0_5_adrb;
  input [31:0] twiddle_rsc_0_5_qb;
  output twiddle_rsc_triosy_0_5_lz;
  output [5:0] twiddle_rsc_0_6_adrb;
  input [31:0] twiddle_rsc_0_6_qb;
  output twiddle_rsc_triosy_0_6_lz;
  output [5:0] twiddle_rsc_0_7_adrb;
  input [31:0] twiddle_rsc_0_7_qb;
  output twiddle_rsc_triosy_0_7_lz;
  output [5:0] twiddle_rsc_1_0_adrb;
  input [31:0] twiddle_rsc_1_0_qb;
  output twiddle_rsc_triosy_1_0_lz;
  output [5:0] twiddle_rsc_1_1_adrb;
  input [31:0] twiddle_rsc_1_1_qb;
  output twiddle_rsc_triosy_1_1_lz;
  output [5:0] twiddle_rsc_1_2_adrb;
  input [31:0] twiddle_rsc_1_2_qb;
  output twiddle_rsc_triosy_1_2_lz;
  output [5:0] twiddle_rsc_1_3_adrb;
  input [31:0] twiddle_rsc_1_3_qb;
  output twiddle_rsc_triosy_1_3_lz;
  output [5:0] twiddle_rsc_1_4_adrb;
  input [31:0] twiddle_rsc_1_4_qb;
  output twiddle_rsc_triosy_1_4_lz;
  output [5:0] twiddle_rsc_1_5_adrb;
  input [31:0] twiddle_rsc_1_5_qb;
  output twiddle_rsc_triosy_1_5_lz;
  output [5:0] twiddle_rsc_1_6_adrb;
  input [31:0] twiddle_rsc_1_6_qb;
  output twiddle_rsc_triosy_1_6_lz;
  output [5:0] twiddle_rsc_1_7_adrb;
  input [31:0] twiddle_rsc_1_7_qb;
  output twiddle_rsc_triosy_1_7_lz;
  output [5:0] twiddle_h_rsc_0_0_adrb;
  input [31:0] twiddle_h_rsc_0_0_qb;
  output twiddle_h_rsc_triosy_0_0_lz;
  output [5:0] twiddle_h_rsc_0_1_adrb;
  input [31:0] twiddle_h_rsc_0_1_qb;
  output twiddle_h_rsc_triosy_0_1_lz;
  output [5:0] twiddle_h_rsc_0_2_adrb;
  input [31:0] twiddle_h_rsc_0_2_qb;
  output twiddle_h_rsc_triosy_0_2_lz;
  output [5:0] twiddle_h_rsc_0_3_adrb;
  input [31:0] twiddle_h_rsc_0_3_qb;
  output twiddle_h_rsc_triosy_0_3_lz;
  output [5:0] twiddle_h_rsc_0_4_adrb;
  input [31:0] twiddle_h_rsc_0_4_qb;
  output twiddle_h_rsc_triosy_0_4_lz;
  output [5:0] twiddle_h_rsc_0_5_adrb;
  input [31:0] twiddle_h_rsc_0_5_qb;
  output twiddle_h_rsc_triosy_0_5_lz;
  output [5:0] twiddle_h_rsc_0_6_adrb;
  input [31:0] twiddle_h_rsc_0_6_qb;
  output twiddle_h_rsc_triosy_0_6_lz;
  output [5:0] twiddle_h_rsc_0_7_adrb;
  input [31:0] twiddle_h_rsc_0_7_qb;
  output twiddle_h_rsc_triosy_0_7_lz;
  output [5:0] twiddle_h_rsc_1_0_adrb;
  input [31:0] twiddle_h_rsc_1_0_qb;
  output twiddle_h_rsc_triosy_1_0_lz;
  output [5:0] twiddle_h_rsc_1_1_adrb;
  input [31:0] twiddle_h_rsc_1_1_qb;
  output twiddle_h_rsc_triosy_1_1_lz;
  output [5:0] twiddle_h_rsc_1_2_adrb;
  input [31:0] twiddle_h_rsc_1_2_qb;
  output twiddle_h_rsc_triosy_1_2_lz;
  output [5:0] twiddle_h_rsc_1_3_adrb;
  input [31:0] twiddle_h_rsc_1_3_qb;
  output twiddle_h_rsc_triosy_1_3_lz;
  output [5:0] twiddle_h_rsc_1_4_adrb;
  input [31:0] twiddle_h_rsc_1_4_qb;
  output twiddle_h_rsc_triosy_1_4_lz;
  output [5:0] twiddle_h_rsc_1_5_adrb;
  input [31:0] twiddle_h_rsc_1_5_qb;
  output twiddle_h_rsc_triosy_1_5_lz;
  output [5:0] twiddle_h_rsc_1_6_adrb;
  input [31:0] twiddle_h_rsc_1_6_qb;
  output twiddle_h_rsc_triosy_1_6_lz;
  output [5:0] twiddle_h_rsc_1_7_adrb;
  input [31:0] twiddle_h_rsc_1_7_qb;
  output twiddle_h_rsc_triosy_1_7_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;


  // Interconnect Declarations
  wire [11:0] vec_rsc_0_0_i_adra_d;
  wire [31:0] vec_rsc_0_0_i_da_d;
  wire [63:0] vec_rsc_0_0_i_qa_d;
  wire [1:0] vec_rsc_0_0_i_wea_d;
  wire [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_0_1_i_adra_d;
  wire [31:0] vec_rsc_0_1_i_da_d;
  wire [63:0] vec_rsc_0_1_i_qa_d;
  wire [1:0] vec_rsc_0_1_i_wea_d;
  wire [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_0_2_i_adra_d;
  wire [31:0] vec_rsc_0_2_i_da_d;
  wire [63:0] vec_rsc_0_2_i_qa_d;
  wire [1:0] vec_rsc_0_2_i_wea_d;
  wire [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_0_3_i_adra_d;
  wire [31:0] vec_rsc_0_3_i_da_d;
  wire [63:0] vec_rsc_0_3_i_qa_d;
  wire [1:0] vec_rsc_0_3_i_wea_d;
  wire [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_0_4_i_adra_d;
  wire [31:0] vec_rsc_0_4_i_da_d;
  wire [63:0] vec_rsc_0_4_i_qa_d;
  wire [1:0] vec_rsc_0_4_i_wea_d;
  wire [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_0_5_i_adra_d;
  wire [31:0] vec_rsc_0_5_i_da_d;
  wire [63:0] vec_rsc_0_5_i_qa_d;
  wire [1:0] vec_rsc_0_5_i_wea_d;
  wire [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_0_6_i_adra_d;
  wire [31:0] vec_rsc_0_6_i_da_d;
  wire [63:0] vec_rsc_0_6_i_qa_d;
  wire [1:0] vec_rsc_0_6_i_wea_d;
  wire [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_0_7_i_adra_d;
  wire [31:0] vec_rsc_0_7_i_da_d;
  wire [63:0] vec_rsc_0_7_i_qa_d;
  wire [1:0] vec_rsc_0_7_i_wea_d;
  wire [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_0_i_adra_d;
  wire [31:0] vec_rsc_1_0_i_da_d;
  wire [63:0] vec_rsc_1_0_i_qa_d;
  wire [1:0] vec_rsc_1_0_i_wea_d;
  wire [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_1_i_adra_d;
  wire [31:0] vec_rsc_1_1_i_da_d;
  wire [63:0] vec_rsc_1_1_i_qa_d;
  wire [1:0] vec_rsc_1_1_i_wea_d;
  wire [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_2_i_adra_d;
  wire [31:0] vec_rsc_1_2_i_da_d;
  wire [63:0] vec_rsc_1_2_i_qa_d;
  wire [1:0] vec_rsc_1_2_i_wea_d;
  wire [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_3_i_adra_d;
  wire [31:0] vec_rsc_1_3_i_da_d;
  wire [63:0] vec_rsc_1_3_i_qa_d;
  wire [1:0] vec_rsc_1_3_i_wea_d;
  wire [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_4_i_adra_d;
  wire [31:0] vec_rsc_1_4_i_da_d;
  wire [63:0] vec_rsc_1_4_i_qa_d;
  wire [1:0] vec_rsc_1_4_i_wea_d;
  wire [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_5_i_adra_d;
  wire [31:0] vec_rsc_1_5_i_da_d;
  wire [63:0] vec_rsc_1_5_i_qa_d;
  wire [1:0] vec_rsc_1_5_i_wea_d;
  wire [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_6_i_adra_d;
  wire [31:0] vec_rsc_1_6_i_da_d;
  wire [63:0] vec_rsc_1_6_i_qa_d;
  wire [1:0] vec_rsc_1_6_i_wea_d;
  wire [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [11:0] vec_rsc_1_7_i_adra_d;
  wire [31:0] vec_rsc_1_7_i_da_d;
  wire [63:0] vec_rsc_1_7_i_qa_d;
  wire [1:0] vec_rsc_1_7_i_wea_d;
  wire [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [31:0] twiddle_rsc_0_0_i_qb_d;
  wire twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_0_1_i_qb_d;
  wire twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_0_2_i_qb_d;
  wire twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_0_3_i_qb_d;
  wire twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_0_4_i_qb_d;
  wire twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_0_5_i_qb_d;
  wire twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_0_6_i_qb_d;
  wire twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_0_7_i_qb_d;
  wire twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_0_i_qb_d;
  wire twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_1_i_qb_d;
  wire twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_2_i_qb_d;
  wire twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_3_i_qb_d;
  wire twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_4_i_qb_d;
  wire twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_5_i_qb_d;
  wire twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_6_i_qb_d;
  wire twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_rsc_1_7_i_qb_d;
  wire twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_0_i_qb_d;
  wire twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_1_i_qb_d;
  wire twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_2_i_qb_d;
  wire twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_3_i_qb_d;
  wire twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_4_i_qb_d;
  wire twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_5_i_qb_d;
  wire twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_6_i_qb_d;
  wire twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_0_7_i_qb_d;
  wire twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_0_i_qb_d;
  wire twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_1_i_qb_d;
  wire twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_2_i_qb_d;
  wire twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_3_i_qb_d;
  wire twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_4_i_qb_d;
  wire twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_5_i_qb_d;
  wire twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_6_i_qb_d;
  wire twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [31:0] twiddle_h_rsc_1_7_i_qb_d;
  wire twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d;
  wire [5:0] twiddle_rsc_0_0_i_adrb_d_iff;


  // Interconnect Declarations for Component Instantiations 
  wire [63:0] nl_vec_rsc_0_0_i_da_d;
  assign nl_vec_rsc_0_0_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_0_i_da_d};
  wire [63:0] nl_vec_rsc_0_1_i_da_d;
  assign nl_vec_rsc_0_1_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_1_i_da_d};
  wire [63:0] nl_vec_rsc_0_2_i_da_d;
  assign nl_vec_rsc_0_2_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_2_i_da_d};
  wire [63:0] nl_vec_rsc_0_3_i_da_d;
  assign nl_vec_rsc_0_3_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_3_i_da_d};
  wire [63:0] nl_vec_rsc_0_4_i_da_d;
  assign nl_vec_rsc_0_4_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_4_i_da_d};
  wire [63:0] nl_vec_rsc_0_5_i_da_d;
  assign nl_vec_rsc_0_5_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_5_i_da_d};
  wire [63:0] nl_vec_rsc_0_6_i_da_d;
  assign nl_vec_rsc_0_6_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_6_i_da_d};
  wire [63:0] nl_vec_rsc_0_7_i_da_d;
  assign nl_vec_rsc_0_7_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_0_7_i_da_d};
  wire [63:0] nl_vec_rsc_1_0_i_da_d;
  assign nl_vec_rsc_1_0_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_0_i_da_d};
  wire [63:0] nl_vec_rsc_1_1_i_da_d;
  assign nl_vec_rsc_1_1_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_1_i_da_d};
  wire [63:0] nl_vec_rsc_1_2_i_da_d;
  assign nl_vec_rsc_1_2_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_2_i_da_d};
  wire [63:0] nl_vec_rsc_1_3_i_da_d;
  assign nl_vec_rsc_1_3_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_3_i_da_d};
  wire [63:0] nl_vec_rsc_1_4_i_da_d;
  assign nl_vec_rsc_1_4_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_4_i_da_d};
  wire [63:0] nl_vec_rsc_1_5_i_da_d;
  assign nl_vec_rsc_1_5_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_5_i_da_d};
  wire [63:0] nl_vec_rsc_1_6_i_da_d;
  assign nl_vec_rsc_1_6_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_6_i_da_d};
  wire [63:0] nl_vec_rsc_1_7_i_da_d;
  assign nl_vec_rsc_1_7_i_da_d = {32'b00000000000000000000000000000000 , vec_rsc_1_7_i_da_d};
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_22_6_32_64_64_32_1_gen
      vec_rsc_0_0_i (
      .qb(vec_rsc_0_0_qb),
      .web(vec_rsc_0_0_web),
      .db(vec_rsc_0_0_db),
      .adrb(vec_rsc_0_0_adrb),
      .qa(vec_rsc_0_0_qa),
      .wea(vec_rsc_0_0_wea),
      .da(vec_rsc_0_0_da),
      .adra(vec_rsc_0_0_adra),
      .adra_d(vec_rsc_0_0_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_0_i_da_d[63:0]),
      .qa_d(vec_rsc_0_0_i_qa_d),
      .wea_d(vec_rsc_0_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_23_6_32_64_64_32_1_gen
      vec_rsc_0_1_i (
      .qb(vec_rsc_0_1_qb),
      .web(vec_rsc_0_1_web),
      .db(vec_rsc_0_1_db),
      .adrb(vec_rsc_0_1_adrb),
      .qa(vec_rsc_0_1_qa),
      .wea(vec_rsc_0_1_wea),
      .da(vec_rsc_0_1_da),
      .adra(vec_rsc_0_1_adra),
      .adra_d(vec_rsc_0_1_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_1_i_da_d[63:0]),
      .qa_d(vec_rsc_0_1_i_qa_d),
      .wea_d(vec_rsc_0_1_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_24_6_32_64_64_32_1_gen
      vec_rsc_0_2_i (
      .qb(vec_rsc_0_2_qb),
      .web(vec_rsc_0_2_web),
      .db(vec_rsc_0_2_db),
      .adrb(vec_rsc_0_2_adrb),
      .qa(vec_rsc_0_2_qa),
      .wea(vec_rsc_0_2_wea),
      .da(vec_rsc_0_2_da),
      .adra(vec_rsc_0_2_adra),
      .adra_d(vec_rsc_0_2_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_2_i_da_d[63:0]),
      .qa_d(vec_rsc_0_2_i_qa_d),
      .wea_d(vec_rsc_0_2_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_25_6_32_64_64_32_1_gen
      vec_rsc_0_3_i (
      .qb(vec_rsc_0_3_qb),
      .web(vec_rsc_0_3_web),
      .db(vec_rsc_0_3_db),
      .adrb(vec_rsc_0_3_adrb),
      .qa(vec_rsc_0_3_qa),
      .wea(vec_rsc_0_3_wea),
      .da(vec_rsc_0_3_da),
      .adra(vec_rsc_0_3_adra),
      .adra_d(vec_rsc_0_3_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_3_i_da_d[63:0]),
      .qa_d(vec_rsc_0_3_i_qa_d),
      .wea_d(vec_rsc_0_3_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_26_6_32_64_64_32_1_gen
      vec_rsc_0_4_i (
      .qb(vec_rsc_0_4_qb),
      .web(vec_rsc_0_4_web),
      .db(vec_rsc_0_4_db),
      .adrb(vec_rsc_0_4_adrb),
      .qa(vec_rsc_0_4_qa),
      .wea(vec_rsc_0_4_wea),
      .da(vec_rsc_0_4_da),
      .adra(vec_rsc_0_4_adra),
      .adra_d(vec_rsc_0_4_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_4_i_da_d[63:0]),
      .qa_d(vec_rsc_0_4_i_qa_d),
      .wea_d(vec_rsc_0_4_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_27_6_32_64_64_32_1_gen
      vec_rsc_0_5_i (
      .qb(vec_rsc_0_5_qb),
      .web(vec_rsc_0_5_web),
      .db(vec_rsc_0_5_db),
      .adrb(vec_rsc_0_5_adrb),
      .qa(vec_rsc_0_5_qa),
      .wea(vec_rsc_0_5_wea),
      .da(vec_rsc_0_5_da),
      .adra(vec_rsc_0_5_adra),
      .adra_d(vec_rsc_0_5_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_5_i_da_d[63:0]),
      .qa_d(vec_rsc_0_5_i_qa_d),
      .wea_d(vec_rsc_0_5_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_28_6_32_64_64_32_1_gen
      vec_rsc_0_6_i (
      .qb(vec_rsc_0_6_qb),
      .web(vec_rsc_0_6_web),
      .db(vec_rsc_0_6_db),
      .adrb(vec_rsc_0_6_adrb),
      .qa(vec_rsc_0_6_qa),
      .wea(vec_rsc_0_6_wea),
      .da(vec_rsc_0_6_da),
      .adra(vec_rsc_0_6_adra),
      .adra_d(vec_rsc_0_6_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_6_i_da_d[63:0]),
      .qa_d(vec_rsc_0_6_i_qa_d),
      .wea_d(vec_rsc_0_6_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_29_6_32_64_64_32_1_gen
      vec_rsc_0_7_i (
      .qb(vec_rsc_0_7_qb),
      .web(vec_rsc_0_7_web),
      .db(vec_rsc_0_7_db),
      .adrb(vec_rsc_0_7_adrb),
      .qa(vec_rsc_0_7_qa),
      .wea(vec_rsc_0_7_wea),
      .da(vec_rsc_0_7_da),
      .adra(vec_rsc_0_7_adra),
      .adra_d(vec_rsc_0_7_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_0_7_i_da_d[63:0]),
      .qa_d(vec_rsc_0_7_i_qa_d),
      .wea_d(vec_rsc_0_7_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_30_6_32_64_64_32_1_gen
      vec_rsc_1_0_i (
      .qb(vec_rsc_1_0_qb),
      .web(vec_rsc_1_0_web),
      .db(vec_rsc_1_0_db),
      .adrb(vec_rsc_1_0_adrb),
      .qa(vec_rsc_1_0_qa),
      .wea(vec_rsc_1_0_wea),
      .da(vec_rsc_1_0_da),
      .adra(vec_rsc_1_0_adra),
      .adra_d(vec_rsc_1_0_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_0_i_da_d[63:0]),
      .qa_d(vec_rsc_1_0_i_qa_d),
      .wea_d(vec_rsc_1_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_31_6_32_64_64_32_1_gen
      vec_rsc_1_1_i (
      .qb(vec_rsc_1_1_qb),
      .web(vec_rsc_1_1_web),
      .db(vec_rsc_1_1_db),
      .adrb(vec_rsc_1_1_adrb),
      .qa(vec_rsc_1_1_qa),
      .wea(vec_rsc_1_1_wea),
      .da(vec_rsc_1_1_da),
      .adra(vec_rsc_1_1_adra),
      .adra_d(vec_rsc_1_1_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_1_i_da_d[63:0]),
      .qa_d(vec_rsc_1_1_i_qa_d),
      .wea_d(vec_rsc_1_1_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_32_6_32_64_64_32_1_gen
      vec_rsc_1_2_i (
      .qb(vec_rsc_1_2_qb),
      .web(vec_rsc_1_2_web),
      .db(vec_rsc_1_2_db),
      .adrb(vec_rsc_1_2_adrb),
      .qa(vec_rsc_1_2_qa),
      .wea(vec_rsc_1_2_wea),
      .da(vec_rsc_1_2_da),
      .adra(vec_rsc_1_2_adra),
      .adra_d(vec_rsc_1_2_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_2_i_da_d[63:0]),
      .qa_d(vec_rsc_1_2_i_qa_d),
      .wea_d(vec_rsc_1_2_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_33_6_32_64_64_32_1_gen
      vec_rsc_1_3_i (
      .qb(vec_rsc_1_3_qb),
      .web(vec_rsc_1_3_web),
      .db(vec_rsc_1_3_db),
      .adrb(vec_rsc_1_3_adrb),
      .qa(vec_rsc_1_3_qa),
      .wea(vec_rsc_1_3_wea),
      .da(vec_rsc_1_3_da),
      .adra(vec_rsc_1_3_adra),
      .adra_d(vec_rsc_1_3_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_3_i_da_d[63:0]),
      .qa_d(vec_rsc_1_3_i_qa_d),
      .wea_d(vec_rsc_1_3_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_34_6_32_64_64_32_1_gen
      vec_rsc_1_4_i (
      .qb(vec_rsc_1_4_qb),
      .web(vec_rsc_1_4_web),
      .db(vec_rsc_1_4_db),
      .adrb(vec_rsc_1_4_adrb),
      .qa(vec_rsc_1_4_qa),
      .wea(vec_rsc_1_4_wea),
      .da(vec_rsc_1_4_da),
      .adra(vec_rsc_1_4_adra),
      .adra_d(vec_rsc_1_4_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_4_i_da_d[63:0]),
      .qa_d(vec_rsc_1_4_i_qa_d),
      .wea_d(vec_rsc_1_4_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_35_6_32_64_64_32_1_gen
      vec_rsc_1_5_i (
      .qb(vec_rsc_1_5_qb),
      .web(vec_rsc_1_5_web),
      .db(vec_rsc_1_5_db),
      .adrb(vec_rsc_1_5_adrb),
      .qa(vec_rsc_1_5_qa),
      .wea(vec_rsc_1_5_wea),
      .da(vec_rsc_1_5_da),
      .adra(vec_rsc_1_5_adra),
      .adra_d(vec_rsc_1_5_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_5_i_da_d[63:0]),
      .qa_d(vec_rsc_1_5_i_qa_d),
      .wea_d(vec_rsc_1_5_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_36_6_32_64_64_32_1_gen
      vec_rsc_1_6_i (
      .qb(vec_rsc_1_6_qb),
      .web(vec_rsc_1_6_web),
      .db(vec_rsc_1_6_db),
      .adrb(vec_rsc_1_6_adrb),
      .qa(vec_rsc_1_6_qa),
      .wea(vec_rsc_1_6_wea),
      .da(vec_rsc_1_6_da),
      .adra(vec_rsc_1_6_adra),
      .adra_d(vec_rsc_1_6_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_6_i_da_d[63:0]),
      .qa_d(vec_rsc_1_6_i_qa_d),
      .wea_d(vec_rsc_1_6_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_37_6_32_64_64_32_1_gen
      vec_rsc_1_7_i (
      .qb(vec_rsc_1_7_qb),
      .web(vec_rsc_1_7_web),
      .db(vec_rsc_1_7_db),
      .adrb(vec_rsc_1_7_adrb),
      .qa(vec_rsc_1_7_qa),
      .wea(vec_rsc_1_7_wea),
      .da(vec_rsc_1_7_da),
      .adra(vec_rsc_1_7_adra),
      .adra_d(vec_rsc_1_7_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsc_1_7_i_da_d[63:0]),
      .qa_d(vec_rsc_1_7_i_qa_d),
      .wea_d(vec_rsc_1_7_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_38_6_32_64_64_32_1_gen
      twiddle_rsc_0_0_i (
      .qb(twiddle_rsc_0_0_qb),
      .adrb(twiddle_rsc_0_0_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_0_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_39_6_32_64_64_32_1_gen
      twiddle_rsc_0_1_i (
      .qb(twiddle_rsc_0_1_qb),
      .adrb(twiddle_rsc_0_1_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_1_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_40_6_32_64_64_32_1_gen
      twiddle_rsc_0_2_i (
      .qb(twiddle_rsc_0_2_qb),
      .adrb(twiddle_rsc_0_2_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_2_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_41_6_32_64_64_32_1_gen
      twiddle_rsc_0_3_i (
      .qb(twiddle_rsc_0_3_qb),
      .adrb(twiddle_rsc_0_3_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_3_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_42_6_32_64_64_32_1_gen
      twiddle_rsc_0_4_i (
      .qb(twiddle_rsc_0_4_qb),
      .adrb(twiddle_rsc_0_4_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_4_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_43_6_32_64_64_32_1_gen
      twiddle_rsc_0_5_i (
      .qb(twiddle_rsc_0_5_qb),
      .adrb(twiddle_rsc_0_5_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_5_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_44_6_32_64_64_32_1_gen
      twiddle_rsc_0_6_i (
      .qb(twiddle_rsc_0_6_qb),
      .adrb(twiddle_rsc_0_6_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_6_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_45_6_32_64_64_32_1_gen
      twiddle_rsc_0_7_i (
      .qb(twiddle_rsc_0_7_qb),
      .adrb(twiddle_rsc_0_7_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_0_7_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_46_6_32_64_64_32_1_gen
      twiddle_rsc_1_0_i (
      .qb(twiddle_rsc_1_0_qb),
      .adrb(twiddle_rsc_1_0_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_0_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_47_6_32_64_64_32_1_gen
      twiddle_rsc_1_1_i (
      .qb(twiddle_rsc_1_1_qb),
      .adrb(twiddle_rsc_1_1_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_1_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_48_6_32_64_64_32_1_gen
      twiddle_rsc_1_2_i (
      .qb(twiddle_rsc_1_2_qb),
      .adrb(twiddle_rsc_1_2_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_2_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_49_6_32_64_64_32_1_gen
      twiddle_rsc_1_3_i (
      .qb(twiddle_rsc_1_3_qb),
      .adrb(twiddle_rsc_1_3_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_3_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_50_6_32_64_64_32_1_gen
      twiddle_rsc_1_4_i (
      .qb(twiddle_rsc_1_4_qb),
      .adrb(twiddle_rsc_1_4_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_4_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_51_6_32_64_64_32_1_gen
      twiddle_rsc_1_5_i (
      .qb(twiddle_rsc_1_5_qb),
      .adrb(twiddle_rsc_1_5_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_5_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_52_6_32_64_64_32_1_gen
      twiddle_rsc_1_6_i (
      .qb(twiddle_rsc_1_6_qb),
      .adrb(twiddle_rsc_1_6_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_6_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_53_6_32_64_64_32_1_gen
      twiddle_rsc_1_7_i (
      .qb(twiddle_rsc_1_7_qb),
      .adrb(twiddle_rsc_1_7_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_rsc_1_7_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_54_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_0_i (
      .qb(twiddle_h_rsc_0_0_qb),
      .adrb(twiddle_h_rsc_0_0_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_0_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_55_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_1_i (
      .qb(twiddle_h_rsc_0_1_qb),
      .adrb(twiddle_h_rsc_0_1_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_1_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_56_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_2_i (
      .qb(twiddle_h_rsc_0_2_qb),
      .adrb(twiddle_h_rsc_0_2_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_2_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_57_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_3_i (
      .qb(twiddle_h_rsc_0_3_qb),
      .adrb(twiddle_h_rsc_0_3_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_3_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_58_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_4_i (
      .qb(twiddle_h_rsc_0_4_qb),
      .adrb(twiddle_h_rsc_0_4_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_4_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_59_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_5_i (
      .qb(twiddle_h_rsc_0_5_qb),
      .adrb(twiddle_h_rsc_0_5_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_5_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_60_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_6_i (
      .qb(twiddle_h_rsc_0_6_qb),
      .adrb(twiddle_h_rsc_0_6_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_6_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_61_6_32_64_64_32_1_gen
      twiddle_h_rsc_0_7_i (
      .qb(twiddle_h_rsc_0_7_qb),
      .adrb(twiddle_h_rsc_0_7_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_0_7_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_62_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_0_i (
      .qb(twiddle_h_rsc_1_0_qb),
      .adrb(twiddle_h_rsc_1_0_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_0_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_63_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_1_i (
      .qb(twiddle_h_rsc_1_1_qb),
      .adrb(twiddle_h_rsc_1_1_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_1_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_64_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_2_i (
      .qb(twiddle_h_rsc_1_2_qb),
      .adrb(twiddle_h_rsc_1_2_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_2_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_65_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_3_i (
      .qb(twiddle_h_rsc_1_3_qb),
      .adrb(twiddle_h_rsc_1_3_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_3_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_66_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_4_i (
      .qb(twiddle_h_rsc_1_4_qb),
      .adrb(twiddle_h_rsc_1_4_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_4_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_67_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_5_i (
      .qb(twiddle_h_rsc_1_5_qb),
      .adrb(twiddle_h_rsc_1_5_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_5_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_68_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_6_i (
      .qb(twiddle_h_rsc_1_6_qb),
      .adrb(twiddle_h_rsc_1_6_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_6_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_69_6_32_64_64_32_1_gen
      twiddle_h_rsc_1_7_i (
      .qb(twiddle_h_rsc_1_7_qb),
      .adrb(twiddle_h_rsc_1_7_adrb),
      .adrb_d(twiddle_rsc_0_0_i_adrb_d_iff),
      .qb_d(twiddle_h_rsc_1_7_i_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_core inPlaceNTT_DIF_precomp_core_inst (
      .clk(clk),
      .rst(rst),
      .run_rsc_rdy(run_rsc_rdy),
      .run_rsc_vld(run_rsc_vld),
      .vec_rsc_triosy_0_0_lz(vec_rsc_triosy_0_0_lz),
      .vec_rsc_triosy_0_1_lz(vec_rsc_triosy_0_1_lz),
      .vec_rsc_triosy_0_2_lz(vec_rsc_triosy_0_2_lz),
      .vec_rsc_triosy_0_3_lz(vec_rsc_triosy_0_3_lz),
      .vec_rsc_triosy_0_4_lz(vec_rsc_triosy_0_4_lz),
      .vec_rsc_triosy_0_5_lz(vec_rsc_triosy_0_5_lz),
      .vec_rsc_triosy_0_6_lz(vec_rsc_triosy_0_6_lz),
      .vec_rsc_triosy_0_7_lz(vec_rsc_triosy_0_7_lz),
      .vec_rsc_triosy_1_0_lz(vec_rsc_triosy_1_0_lz),
      .vec_rsc_triosy_1_1_lz(vec_rsc_triosy_1_1_lz),
      .vec_rsc_triosy_1_2_lz(vec_rsc_triosy_1_2_lz),
      .vec_rsc_triosy_1_3_lz(vec_rsc_triosy_1_3_lz),
      .vec_rsc_triosy_1_4_lz(vec_rsc_triosy_1_4_lz),
      .vec_rsc_triosy_1_5_lz(vec_rsc_triosy_1_5_lz),
      .vec_rsc_triosy_1_6_lz(vec_rsc_triosy_1_6_lz),
      .vec_rsc_triosy_1_7_lz(vec_rsc_triosy_1_7_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_0_0_lz(twiddle_rsc_triosy_0_0_lz),
      .twiddle_rsc_triosy_0_1_lz(twiddle_rsc_triosy_0_1_lz),
      .twiddle_rsc_triosy_0_2_lz(twiddle_rsc_triosy_0_2_lz),
      .twiddle_rsc_triosy_0_3_lz(twiddle_rsc_triosy_0_3_lz),
      .twiddle_rsc_triosy_0_4_lz(twiddle_rsc_triosy_0_4_lz),
      .twiddle_rsc_triosy_0_5_lz(twiddle_rsc_triosy_0_5_lz),
      .twiddle_rsc_triosy_0_6_lz(twiddle_rsc_triosy_0_6_lz),
      .twiddle_rsc_triosy_0_7_lz(twiddle_rsc_triosy_0_7_lz),
      .twiddle_rsc_triosy_1_0_lz(twiddle_rsc_triosy_1_0_lz),
      .twiddle_rsc_triosy_1_1_lz(twiddle_rsc_triosy_1_1_lz),
      .twiddle_rsc_triosy_1_2_lz(twiddle_rsc_triosy_1_2_lz),
      .twiddle_rsc_triosy_1_3_lz(twiddle_rsc_triosy_1_3_lz),
      .twiddle_rsc_triosy_1_4_lz(twiddle_rsc_triosy_1_4_lz),
      .twiddle_rsc_triosy_1_5_lz(twiddle_rsc_triosy_1_5_lz),
      .twiddle_rsc_triosy_1_6_lz(twiddle_rsc_triosy_1_6_lz),
      .twiddle_rsc_triosy_1_7_lz(twiddle_rsc_triosy_1_7_lz),
      .twiddle_h_rsc_triosy_0_0_lz(twiddle_h_rsc_triosy_0_0_lz),
      .twiddle_h_rsc_triosy_0_1_lz(twiddle_h_rsc_triosy_0_1_lz),
      .twiddle_h_rsc_triosy_0_2_lz(twiddle_h_rsc_triosy_0_2_lz),
      .twiddle_h_rsc_triosy_0_3_lz(twiddle_h_rsc_triosy_0_3_lz),
      .twiddle_h_rsc_triosy_0_4_lz(twiddle_h_rsc_triosy_0_4_lz),
      .twiddle_h_rsc_triosy_0_5_lz(twiddle_h_rsc_triosy_0_5_lz),
      .twiddle_h_rsc_triosy_0_6_lz(twiddle_h_rsc_triosy_0_6_lz),
      .twiddle_h_rsc_triosy_0_7_lz(twiddle_h_rsc_triosy_0_7_lz),
      .twiddle_h_rsc_triosy_1_0_lz(twiddle_h_rsc_triosy_1_0_lz),
      .twiddle_h_rsc_triosy_1_1_lz(twiddle_h_rsc_triosy_1_1_lz),
      .twiddle_h_rsc_triosy_1_2_lz(twiddle_h_rsc_triosy_1_2_lz),
      .twiddle_h_rsc_triosy_1_3_lz(twiddle_h_rsc_triosy_1_3_lz),
      .twiddle_h_rsc_triosy_1_4_lz(twiddle_h_rsc_triosy_1_4_lz),
      .twiddle_h_rsc_triosy_1_5_lz(twiddle_h_rsc_triosy_1_5_lz),
      .twiddle_h_rsc_triosy_1_6_lz(twiddle_h_rsc_triosy_1_6_lz),
      .twiddle_h_rsc_triosy_1_7_lz(twiddle_h_rsc_triosy_1_7_lz),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld),
      .vec_rsc_0_0_i_adra_d(vec_rsc_0_0_i_adra_d),
      .vec_rsc_0_0_i_da_d(vec_rsc_0_0_i_da_d),
      .vec_rsc_0_0_i_qa_d(vec_rsc_0_0_i_qa_d),
      .vec_rsc_0_0_i_wea_d(vec_rsc_0_0_i_wea_d),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_0_1_i_adra_d(vec_rsc_0_1_i_adra_d),
      .vec_rsc_0_1_i_da_d(vec_rsc_0_1_i_da_d),
      .vec_rsc_0_1_i_qa_d(vec_rsc_0_1_i_qa_d),
      .vec_rsc_0_1_i_wea_d(vec_rsc_0_1_i_wea_d),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_0_2_i_adra_d(vec_rsc_0_2_i_adra_d),
      .vec_rsc_0_2_i_da_d(vec_rsc_0_2_i_da_d),
      .vec_rsc_0_2_i_qa_d(vec_rsc_0_2_i_qa_d),
      .vec_rsc_0_2_i_wea_d(vec_rsc_0_2_i_wea_d),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_0_3_i_adra_d(vec_rsc_0_3_i_adra_d),
      .vec_rsc_0_3_i_da_d(vec_rsc_0_3_i_da_d),
      .vec_rsc_0_3_i_qa_d(vec_rsc_0_3_i_qa_d),
      .vec_rsc_0_3_i_wea_d(vec_rsc_0_3_i_wea_d),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_0_4_i_adra_d(vec_rsc_0_4_i_adra_d),
      .vec_rsc_0_4_i_da_d(vec_rsc_0_4_i_da_d),
      .vec_rsc_0_4_i_qa_d(vec_rsc_0_4_i_qa_d),
      .vec_rsc_0_4_i_wea_d(vec_rsc_0_4_i_wea_d),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_4_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_0_5_i_adra_d(vec_rsc_0_5_i_adra_d),
      .vec_rsc_0_5_i_da_d(vec_rsc_0_5_i_da_d),
      .vec_rsc_0_5_i_qa_d(vec_rsc_0_5_i_qa_d),
      .vec_rsc_0_5_i_wea_d(vec_rsc_0_5_i_wea_d),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_5_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_0_6_i_adra_d(vec_rsc_0_6_i_adra_d),
      .vec_rsc_0_6_i_da_d(vec_rsc_0_6_i_da_d),
      .vec_rsc_0_6_i_qa_d(vec_rsc_0_6_i_qa_d),
      .vec_rsc_0_6_i_wea_d(vec_rsc_0_6_i_wea_d),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_6_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_0_7_i_adra_d(vec_rsc_0_7_i_adra_d),
      .vec_rsc_0_7_i_da_d(vec_rsc_0_7_i_da_d),
      .vec_rsc_0_7_i_qa_d(vec_rsc_0_7_i_qa_d),
      .vec_rsc_0_7_i_wea_d(vec_rsc_0_7_i_wea_d),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_7_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_0_i_adra_d(vec_rsc_1_0_i_adra_d),
      .vec_rsc_1_0_i_da_d(vec_rsc_1_0_i_da_d),
      .vec_rsc_1_0_i_qa_d(vec_rsc_1_0_i_qa_d),
      .vec_rsc_1_0_i_wea_d(vec_rsc_1_0_i_wea_d),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_1_i_adra_d(vec_rsc_1_1_i_adra_d),
      .vec_rsc_1_1_i_da_d(vec_rsc_1_1_i_da_d),
      .vec_rsc_1_1_i_qa_d(vec_rsc_1_1_i_qa_d),
      .vec_rsc_1_1_i_wea_d(vec_rsc_1_1_i_wea_d),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_1_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_2_i_adra_d(vec_rsc_1_2_i_adra_d),
      .vec_rsc_1_2_i_da_d(vec_rsc_1_2_i_da_d),
      .vec_rsc_1_2_i_qa_d(vec_rsc_1_2_i_qa_d),
      .vec_rsc_1_2_i_wea_d(vec_rsc_1_2_i_wea_d),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_2_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_3_i_adra_d(vec_rsc_1_3_i_adra_d),
      .vec_rsc_1_3_i_da_d(vec_rsc_1_3_i_da_d),
      .vec_rsc_1_3_i_qa_d(vec_rsc_1_3_i_qa_d),
      .vec_rsc_1_3_i_wea_d(vec_rsc_1_3_i_wea_d),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_3_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_4_i_adra_d(vec_rsc_1_4_i_adra_d),
      .vec_rsc_1_4_i_da_d(vec_rsc_1_4_i_da_d),
      .vec_rsc_1_4_i_qa_d(vec_rsc_1_4_i_qa_d),
      .vec_rsc_1_4_i_wea_d(vec_rsc_1_4_i_wea_d),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_4_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_5_i_adra_d(vec_rsc_1_5_i_adra_d),
      .vec_rsc_1_5_i_da_d(vec_rsc_1_5_i_da_d),
      .vec_rsc_1_5_i_qa_d(vec_rsc_1_5_i_qa_d),
      .vec_rsc_1_5_i_wea_d(vec_rsc_1_5_i_wea_d),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_5_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_6_i_adra_d(vec_rsc_1_6_i_adra_d),
      .vec_rsc_1_6_i_da_d(vec_rsc_1_6_i_da_d),
      .vec_rsc_1_6_i_qa_d(vec_rsc_1_6_i_qa_d),
      .vec_rsc_1_6_i_wea_d(vec_rsc_1_6_i_wea_d),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_6_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .vec_rsc_1_7_i_adra_d(vec_rsc_1_7_i_adra_d),
      .vec_rsc_1_7_i_da_d(vec_rsc_1_7_i_da_d),
      .vec_rsc_1_7_i_qa_d(vec_rsc_1_7_i_qa_d),
      .vec_rsc_1_7_i_wea_d(vec_rsc_1_7_i_wea_d),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_1_7_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .twiddle_rsc_0_0_i_qb_d(twiddle_rsc_0_0_i_qb_d),
      .twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_1_i_qb_d(twiddle_rsc_0_1_i_qb_d),
      .twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_2_i_qb_d(twiddle_rsc_0_2_i_qb_d),
      .twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_3_i_qb_d(twiddle_rsc_0_3_i_qb_d),
      .twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_4_i_qb_d(twiddle_rsc_0_4_i_qb_d),
      .twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_5_i_qb_d(twiddle_rsc_0_5_i_qb_d),
      .twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_6_i_qb_d(twiddle_rsc_0_6_i_qb_d),
      .twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_7_i_qb_d(twiddle_rsc_0_7_i_qb_d),
      .twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_0_i_qb_d(twiddle_rsc_1_0_i_qb_d),
      .twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_1_i_qb_d(twiddle_rsc_1_1_i_qb_d),
      .twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_2_i_qb_d(twiddle_rsc_1_2_i_qb_d),
      .twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_3_i_qb_d(twiddle_rsc_1_3_i_qb_d),
      .twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_4_i_qb_d(twiddle_rsc_1_4_i_qb_d),
      .twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_5_i_qb_d(twiddle_rsc_1_5_i_qb_d),
      .twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_6_i_qb_d(twiddle_rsc_1_6_i_qb_d),
      .twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_1_7_i_qb_d(twiddle_rsc_1_7_i_qb_d),
      .twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_0_i_qb_d(twiddle_h_rsc_0_0_i_qb_d),
      .twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_0_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_1_i_qb_d(twiddle_h_rsc_0_1_i_qb_d),
      .twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_1_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_2_i_qb_d(twiddle_h_rsc_0_2_i_qb_d),
      .twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_2_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_3_i_qb_d(twiddle_h_rsc_0_3_i_qb_d),
      .twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_3_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_4_i_qb_d(twiddle_h_rsc_0_4_i_qb_d),
      .twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_4_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_5_i_qb_d(twiddle_h_rsc_0_5_i_qb_d),
      .twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_5_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_6_i_qb_d(twiddle_h_rsc_0_6_i_qb_d),
      .twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_6_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_0_7_i_qb_d(twiddle_h_rsc_0_7_i_qb_d),
      .twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_0_7_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_0_i_qb_d(twiddle_h_rsc_1_0_i_qb_d),
      .twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_0_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_1_i_qb_d(twiddle_h_rsc_1_1_i_qb_d),
      .twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_1_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_2_i_qb_d(twiddle_h_rsc_1_2_i_qb_d),
      .twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_2_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_3_i_qb_d(twiddle_h_rsc_1_3_i_qb_d),
      .twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_3_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_4_i_qb_d(twiddle_h_rsc_1_4_i_qb_d),
      .twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_4_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_5_i_qb_d(twiddle_h_rsc_1_5_i_qb_d),
      .twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_5_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_6_i_qb_d(twiddle_h_rsc_1_6_i_qb_d),
      .twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_6_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsc_1_7_i_qb_d(twiddle_h_rsc_1_7_i_qb_d),
      .twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsc_1_7_i_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_0_i_adrb_d_pff(twiddle_rsc_0_0_i_adrb_d_iff)
    );
endmodule



