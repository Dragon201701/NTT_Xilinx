
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

//------> ../td_ccore_solutions/modulo_sub_20f67d2a306b3300fd71db6974653bfb635e_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:48:09 2021
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
  ccs_in_v1 #(.rscid(32'sd9),
  .width(32'sd32)) base_rsci (
      .dat(base_rsc_dat),
      .idat(base_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd10),
  .width(32'sd32)) m_rsci (
      .dat(m_rsc_dat),
      .idat(m_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd11),
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




//------> ../td_ccore_solutions/modulo_add_09234dfffbf6bf3991e053db4676dd156036_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:48:10 2021
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
  wire[32:0] acc_1_nl;
  wire[33:0] nl_acc_1_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_in_v1 #(.rscid(32'sd6),
  .width(32'sd32)) base_rsci (
      .dat(base_rsc_dat),
      .idat(base_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd7),
  .width(32'sd32)) m_rsci (
      .dat(m_rsc_dat),
      .idat(m_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd8),
  .width(32'sd32)) return_rsci (
      .d(return_rsci_d),
      .z(return_rsc_z)
    );
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_32_2_2(base_rsci_idat, qif_acc_nl, readslicef_33_1_32(acc_1_nl));
    end
  end
  assign nl_qif_acc_nl = base_rsci_idat - m_rsci_idat;
  assign qif_acc_nl = nl_qif_acc_nl[31:0];
  assign nl_acc_1_nl = ({1'b1 , m_rsci_idat}) + conv_u2u_32_33(~ base_rsci_idat)
      + 33'b000000000000000000000000000000001;
  assign acc_1_nl = nl_acc_1_nl[32:0];

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




//------> ../td_ccore_solutions/mult_2e4bc42889b304aeffa2245c869db4ef70c9_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:48:12 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    mult_core
// ------------------------------------------------------------------


module mult_core (
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
  wire [31:0] x_rsci_idat;
  wire [31:0] y_rsci_idat;
  wire [31:0] y_rsci_idat_1;
  wire [31:0] p_rsci_idat;
  reg [31:0] return_rsci_d;
  wire ccs_ccore_start_rsci_idat;
  wire and_dcpl;
  reg slc_32_svs_1;
  reg main_stage_0_2;
  reg [31:0] p_buf_sva_1;
  reg [31:0] p_buf_sva_2;
  reg [31:0] res_sva_1;
  reg [31:0] z_mul_itm_1;
  wire [63:0] nl_z_mul_itm_1;
  reg [31:0] operator_96_false_operator_96_false_slc_t_mul_63_32_itm_1;
  reg asn_itm_1;
  wire [31:0] res_sva_3;
  wire [32:0] nl_res_sva_3;
  wire res_and_cse;
  wire p_and_1_cse;
  wire if_acc_1_itm_32_1;

  wire[31:0] if_acc_nl;
  wire[32:0] nl_if_acc_nl;
  wire[63:0] t_mul_nl;
  wire[31:0] z_mul_nl;
  wire[63:0] nl_z_mul_nl;
  wire[32:0] if_acc_1_nl;
  wire[33:0] nl_if_acc_1_nl;

  // Interconnect Declarations for Component Instantiations 
  ccs_in_v1 #(.rscid(32'sd1),
  .width(32'sd32)) x_rsci (
      .dat(x_rsc_dat),
      .idat(x_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd32)) y_rsci (
      .dat(y_rsc_dat),
      .idat(y_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd32)) y_rsci_1 (
      .dat(y_rsc_dat_1),
      .idat(y_rsci_idat_1)
    );
  ccs_in_v1 #(.rscid(32'sd4),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd5),
  .width(32'sd32)) return_rsci (
      .d(return_rsci_d),
      .z(return_rsc_z)
    );
  ccs_in_v1 #(.rscid(32'sd21),
  .width(32'sd1)) ccs_ccore_start_rsci (
      .dat(ccs_ccore_start_rsc_dat),
      .idat(ccs_ccore_start_rsci_idat)
    );
  assign res_and_cse = ccs_ccore_en & and_dcpl;
  assign p_and_1_cse = ccs_ccore_en & ccs_ccore_start_rsci_idat;
  assign nl_z_mul_nl = operator_96_false_operator_96_false_slc_t_mul_63_32_itm_1
      * p_buf_sva_1;
  assign z_mul_nl = nl_z_mul_nl[31:0];
  assign nl_res_sva_3 = z_mul_itm_1 - z_mul_nl;
  assign res_sva_3 = nl_res_sva_3[31:0];
  assign nl_if_acc_1_nl = ({1'b1 , res_sva_3}) + conv_u2u_32_33(~ p_buf_sva_1) +
      33'b000000000000000000000000000000001;
  assign if_acc_1_nl = nl_if_acc_1_nl[32:0];
  assign if_acc_1_itm_32_1 = readslicef_33_1_32(if_acc_1_nl);
  assign and_dcpl = main_stage_0_2 & asn_itm_1;
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_32_2_2(if_acc_nl, res_sva_1, slc_32_svs_1);
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      asn_itm_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
    end
    else if ( ccs_ccore_en ) begin
      asn_itm_1 <= ccs_ccore_start_rsci_idat;
      main_stage_0_2 <= 1'b1;
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
      p_buf_sva_2 <= p_buf_sva_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( p_and_1_cse ) begin
      p_buf_sva_1 <= p_rsci_idat;
      z_mul_itm_1 <= nl_z_mul_itm_1[31:0];
      operator_96_false_operator_96_false_slc_t_mul_63_32_itm_1 <= readslicef_64_32_32(t_mul_nl);
    end
  end
  assign nl_if_acc_nl = res_sva_1 - p_buf_sva_2;
  assign if_acc_nl = nl_if_acc_nl[31:0];
  assign nl_z_mul_itm_1  = x_rsci_idat * y_rsci_idat;
  assign t_mul_nl = conv_u2u_64_64(x_rsci_idat * y_rsci_idat_1);

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


  function automatic [31:0] readslicef_64_32_32;
    input [63:0] vector;
    reg [63:0] tmp;
  begin
    tmp = vector >> 32;
    readslicef_64_32_32 = tmp[31:0];
  end
  endfunction


  function automatic [32:0] conv_u2u_32_33 ;
    input [31:0]  vector ;
  begin
    conv_u2u_32_33 = {1'b0, vector};
  end
  endfunction


  function automatic [63:0] conv_u2u_64_64 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_64 = vector;
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



  // Interconnect Declarations for Component Instantiations 
  mult_core mult_core_inst (
      .x_rsc_dat(x_rsc_dat),
      .y_rsc_dat(y_rsc_dat),
      .y_rsc_dat_1(y_rsc_dat_1),
      .p_rsc_dat(p_rsc_dat),
      .return_rsc_z(return_rsc_z),
      .ccs_ccore_start_rsc_dat(ccs_ccore_start_rsc_dat),
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_srst(ccs_ccore_srst),
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
//  Generated date: Thu Sep 16 11:49:08 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_10_32_1024_1024_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [9:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [9:0] adra;
  input [19:0] adra_d;
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
  assign adrb = (adra_d[19:10]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[9:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_10_32_1024_1024_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [9:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [9:0] adra;
  input [19:0] adra_d;
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
  assign adrb = (adra_d[19:10]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[9:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_10_32_1024_1024_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [9:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [9:0] adra;
  input [19:0] adra_d;
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
  assign adrb = (adra_d[19:10]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[9:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_core_fsm (
  clk, rst, complete_rsci_wen_comp, fsm_output, main_C_0_tr0, COMP_LOOP_1_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_2_tr0, COMP_LOOP_2_VEC_LOOP_C_8_tr0, COMP_LOOP_C_3_tr0, COMP_LOOP_3_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_4_tr0, COMP_LOOP_4_VEC_LOOP_C_8_tr0, COMP_LOOP_C_5_tr0, COMP_LOOP_5_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_6_tr0, COMP_LOOP_6_VEC_LOOP_C_8_tr0, COMP_LOOP_C_7_tr0, COMP_LOOP_7_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_8_tr0, COMP_LOOP_8_VEC_LOOP_C_8_tr0, COMP_LOOP_C_9_tr0, COMP_LOOP_9_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_10_tr0, COMP_LOOP_10_VEC_LOOP_C_8_tr0, COMP_LOOP_C_11_tr0, COMP_LOOP_11_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_12_tr0, COMP_LOOP_12_VEC_LOOP_C_8_tr0, COMP_LOOP_C_13_tr0, COMP_LOOP_13_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_14_tr0, COMP_LOOP_14_VEC_LOOP_C_8_tr0, COMP_LOOP_C_15_tr0, COMP_LOOP_15_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_16_tr0, COMP_LOOP_16_VEC_LOOP_C_8_tr0, COMP_LOOP_C_17_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input main_C_0_tr0;
  input COMP_LOOP_1_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_2_tr0;
  input COMP_LOOP_2_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_3_tr0;
  input COMP_LOOP_3_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_4_tr0;
  input COMP_LOOP_4_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_5_tr0;
  input COMP_LOOP_5_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_6_tr0;
  input COMP_LOOP_6_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_7_tr0;
  input COMP_LOOP_7_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_8_tr0;
  input COMP_LOOP_8_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_9_tr0;
  input COMP_LOOP_9_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_10_tr0;
  input COMP_LOOP_10_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_11_tr0;
  input COMP_LOOP_11_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_12_tr0;
  input COMP_LOOP_12_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_13_tr0;
  input COMP_LOOP_13_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_14_tr0;
  input COMP_LOOP_14_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_15_tr0;
  input COMP_LOOP_15_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_16_tr0;
  input COMP_LOOP_16_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_17_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_precomp_core_core_fsm_1
  parameter
    main_C_0 = 8'd0,
    STAGE_LOOP_C_0 = 8'd1,
    COMP_LOOP_C_0 = 8'd2,
    COMP_LOOP_C_1 = 8'd3,
    COMP_LOOP_1_VEC_LOOP_C_0 = 8'd4,
    COMP_LOOP_1_VEC_LOOP_C_1 = 8'd5,
    COMP_LOOP_1_VEC_LOOP_C_2 = 8'd6,
    COMP_LOOP_1_VEC_LOOP_C_3 = 8'd7,
    COMP_LOOP_1_VEC_LOOP_C_4 = 8'd8,
    COMP_LOOP_1_VEC_LOOP_C_5 = 8'd9,
    COMP_LOOP_1_VEC_LOOP_C_6 = 8'd10,
    COMP_LOOP_1_VEC_LOOP_C_7 = 8'd11,
    COMP_LOOP_1_VEC_LOOP_C_8 = 8'd12,
    COMP_LOOP_C_2 = 8'd13,
    COMP_LOOP_2_VEC_LOOP_C_0 = 8'd14,
    COMP_LOOP_2_VEC_LOOP_C_1 = 8'd15,
    COMP_LOOP_2_VEC_LOOP_C_2 = 8'd16,
    COMP_LOOP_2_VEC_LOOP_C_3 = 8'd17,
    COMP_LOOP_2_VEC_LOOP_C_4 = 8'd18,
    COMP_LOOP_2_VEC_LOOP_C_5 = 8'd19,
    COMP_LOOP_2_VEC_LOOP_C_6 = 8'd20,
    COMP_LOOP_2_VEC_LOOP_C_7 = 8'd21,
    COMP_LOOP_2_VEC_LOOP_C_8 = 8'd22,
    COMP_LOOP_C_3 = 8'd23,
    COMP_LOOP_3_VEC_LOOP_C_0 = 8'd24,
    COMP_LOOP_3_VEC_LOOP_C_1 = 8'd25,
    COMP_LOOP_3_VEC_LOOP_C_2 = 8'd26,
    COMP_LOOP_3_VEC_LOOP_C_3 = 8'd27,
    COMP_LOOP_3_VEC_LOOP_C_4 = 8'd28,
    COMP_LOOP_3_VEC_LOOP_C_5 = 8'd29,
    COMP_LOOP_3_VEC_LOOP_C_6 = 8'd30,
    COMP_LOOP_3_VEC_LOOP_C_7 = 8'd31,
    COMP_LOOP_3_VEC_LOOP_C_8 = 8'd32,
    COMP_LOOP_C_4 = 8'd33,
    COMP_LOOP_4_VEC_LOOP_C_0 = 8'd34,
    COMP_LOOP_4_VEC_LOOP_C_1 = 8'd35,
    COMP_LOOP_4_VEC_LOOP_C_2 = 8'd36,
    COMP_LOOP_4_VEC_LOOP_C_3 = 8'd37,
    COMP_LOOP_4_VEC_LOOP_C_4 = 8'd38,
    COMP_LOOP_4_VEC_LOOP_C_5 = 8'd39,
    COMP_LOOP_4_VEC_LOOP_C_6 = 8'd40,
    COMP_LOOP_4_VEC_LOOP_C_7 = 8'd41,
    COMP_LOOP_4_VEC_LOOP_C_8 = 8'd42,
    COMP_LOOP_C_5 = 8'd43,
    COMP_LOOP_5_VEC_LOOP_C_0 = 8'd44,
    COMP_LOOP_5_VEC_LOOP_C_1 = 8'd45,
    COMP_LOOP_5_VEC_LOOP_C_2 = 8'd46,
    COMP_LOOP_5_VEC_LOOP_C_3 = 8'd47,
    COMP_LOOP_5_VEC_LOOP_C_4 = 8'd48,
    COMP_LOOP_5_VEC_LOOP_C_5 = 8'd49,
    COMP_LOOP_5_VEC_LOOP_C_6 = 8'd50,
    COMP_LOOP_5_VEC_LOOP_C_7 = 8'd51,
    COMP_LOOP_5_VEC_LOOP_C_8 = 8'd52,
    COMP_LOOP_C_6 = 8'd53,
    COMP_LOOP_6_VEC_LOOP_C_0 = 8'd54,
    COMP_LOOP_6_VEC_LOOP_C_1 = 8'd55,
    COMP_LOOP_6_VEC_LOOP_C_2 = 8'd56,
    COMP_LOOP_6_VEC_LOOP_C_3 = 8'd57,
    COMP_LOOP_6_VEC_LOOP_C_4 = 8'd58,
    COMP_LOOP_6_VEC_LOOP_C_5 = 8'd59,
    COMP_LOOP_6_VEC_LOOP_C_6 = 8'd60,
    COMP_LOOP_6_VEC_LOOP_C_7 = 8'd61,
    COMP_LOOP_6_VEC_LOOP_C_8 = 8'd62,
    COMP_LOOP_C_7 = 8'd63,
    COMP_LOOP_7_VEC_LOOP_C_0 = 8'd64,
    COMP_LOOP_7_VEC_LOOP_C_1 = 8'd65,
    COMP_LOOP_7_VEC_LOOP_C_2 = 8'd66,
    COMP_LOOP_7_VEC_LOOP_C_3 = 8'd67,
    COMP_LOOP_7_VEC_LOOP_C_4 = 8'd68,
    COMP_LOOP_7_VEC_LOOP_C_5 = 8'd69,
    COMP_LOOP_7_VEC_LOOP_C_6 = 8'd70,
    COMP_LOOP_7_VEC_LOOP_C_7 = 8'd71,
    COMP_LOOP_7_VEC_LOOP_C_8 = 8'd72,
    COMP_LOOP_C_8 = 8'd73,
    COMP_LOOP_8_VEC_LOOP_C_0 = 8'd74,
    COMP_LOOP_8_VEC_LOOP_C_1 = 8'd75,
    COMP_LOOP_8_VEC_LOOP_C_2 = 8'd76,
    COMP_LOOP_8_VEC_LOOP_C_3 = 8'd77,
    COMP_LOOP_8_VEC_LOOP_C_4 = 8'd78,
    COMP_LOOP_8_VEC_LOOP_C_5 = 8'd79,
    COMP_LOOP_8_VEC_LOOP_C_6 = 8'd80,
    COMP_LOOP_8_VEC_LOOP_C_7 = 8'd81,
    COMP_LOOP_8_VEC_LOOP_C_8 = 8'd82,
    COMP_LOOP_C_9 = 8'd83,
    COMP_LOOP_9_VEC_LOOP_C_0 = 8'd84,
    COMP_LOOP_9_VEC_LOOP_C_1 = 8'd85,
    COMP_LOOP_9_VEC_LOOP_C_2 = 8'd86,
    COMP_LOOP_9_VEC_LOOP_C_3 = 8'd87,
    COMP_LOOP_9_VEC_LOOP_C_4 = 8'd88,
    COMP_LOOP_9_VEC_LOOP_C_5 = 8'd89,
    COMP_LOOP_9_VEC_LOOP_C_6 = 8'd90,
    COMP_LOOP_9_VEC_LOOP_C_7 = 8'd91,
    COMP_LOOP_9_VEC_LOOP_C_8 = 8'd92,
    COMP_LOOP_C_10 = 8'd93,
    COMP_LOOP_10_VEC_LOOP_C_0 = 8'd94,
    COMP_LOOP_10_VEC_LOOP_C_1 = 8'd95,
    COMP_LOOP_10_VEC_LOOP_C_2 = 8'd96,
    COMP_LOOP_10_VEC_LOOP_C_3 = 8'd97,
    COMP_LOOP_10_VEC_LOOP_C_4 = 8'd98,
    COMP_LOOP_10_VEC_LOOP_C_5 = 8'd99,
    COMP_LOOP_10_VEC_LOOP_C_6 = 8'd100,
    COMP_LOOP_10_VEC_LOOP_C_7 = 8'd101,
    COMP_LOOP_10_VEC_LOOP_C_8 = 8'd102,
    COMP_LOOP_C_11 = 8'd103,
    COMP_LOOP_11_VEC_LOOP_C_0 = 8'd104,
    COMP_LOOP_11_VEC_LOOP_C_1 = 8'd105,
    COMP_LOOP_11_VEC_LOOP_C_2 = 8'd106,
    COMP_LOOP_11_VEC_LOOP_C_3 = 8'd107,
    COMP_LOOP_11_VEC_LOOP_C_4 = 8'd108,
    COMP_LOOP_11_VEC_LOOP_C_5 = 8'd109,
    COMP_LOOP_11_VEC_LOOP_C_6 = 8'd110,
    COMP_LOOP_11_VEC_LOOP_C_7 = 8'd111,
    COMP_LOOP_11_VEC_LOOP_C_8 = 8'd112,
    COMP_LOOP_C_12 = 8'd113,
    COMP_LOOP_12_VEC_LOOP_C_0 = 8'd114,
    COMP_LOOP_12_VEC_LOOP_C_1 = 8'd115,
    COMP_LOOP_12_VEC_LOOP_C_2 = 8'd116,
    COMP_LOOP_12_VEC_LOOP_C_3 = 8'd117,
    COMP_LOOP_12_VEC_LOOP_C_4 = 8'd118,
    COMP_LOOP_12_VEC_LOOP_C_5 = 8'd119,
    COMP_LOOP_12_VEC_LOOP_C_6 = 8'd120,
    COMP_LOOP_12_VEC_LOOP_C_7 = 8'd121,
    COMP_LOOP_12_VEC_LOOP_C_8 = 8'd122,
    COMP_LOOP_C_13 = 8'd123,
    COMP_LOOP_13_VEC_LOOP_C_0 = 8'd124,
    COMP_LOOP_13_VEC_LOOP_C_1 = 8'd125,
    COMP_LOOP_13_VEC_LOOP_C_2 = 8'd126,
    COMP_LOOP_13_VEC_LOOP_C_3 = 8'd127,
    COMP_LOOP_13_VEC_LOOP_C_4 = 8'd128,
    COMP_LOOP_13_VEC_LOOP_C_5 = 8'd129,
    COMP_LOOP_13_VEC_LOOP_C_6 = 8'd130,
    COMP_LOOP_13_VEC_LOOP_C_7 = 8'd131,
    COMP_LOOP_13_VEC_LOOP_C_8 = 8'd132,
    COMP_LOOP_C_14 = 8'd133,
    COMP_LOOP_14_VEC_LOOP_C_0 = 8'd134,
    COMP_LOOP_14_VEC_LOOP_C_1 = 8'd135,
    COMP_LOOP_14_VEC_LOOP_C_2 = 8'd136,
    COMP_LOOP_14_VEC_LOOP_C_3 = 8'd137,
    COMP_LOOP_14_VEC_LOOP_C_4 = 8'd138,
    COMP_LOOP_14_VEC_LOOP_C_5 = 8'd139,
    COMP_LOOP_14_VEC_LOOP_C_6 = 8'd140,
    COMP_LOOP_14_VEC_LOOP_C_7 = 8'd141,
    COMP_LOOP_14_VEC_LOOP_C_8 = 8'd142,
    COMP_LOOP_C_15 = 8'd143,
    COMP_LOOP_15_VEC_LOOP_C_0 = 8'd144,
    COMP_LOOP_15_VEC_LOOP_C_1 = 8'd145,
    COMP_LOOP_15_VEC_LOOP_C_2 = 8'd146,
    COMP_LOOP_15_VEC_LOOP_C_3 = 8'd147,
    COMP_LOOP_15_VEC_LOOP_C_4 = 8'd148,
    COMP_LOOP_15_VEC_LOOP_C_5 = 8'd149,
    COMP_LOOP_15_VEC_LOOP_C_6 = 8'd150,
    COMP_LOOP_15_VEC_LOOP_C_7 = 8'd151,
    COMP_LOOP_15_VEC_LOOP_C_8 = 8'd152,
    COMP_LOOP_C_16 = 8'd153,
    COMP_LOOP_16_VEC_LOOP_C_0 = 8'd154,
    COMP_LOOP_16_VEC_LOOP_C_1 = 8'd155,
    COMP_LOOP_16_VEC_LOOP_C_2 = 8'd156,
    COMP_LOOP_16_VEC_LOOP_C_3 = 8'd157,
    COMP_LOOP_16_VEC_LOOP_C_4 = 8'd158,
    COMP_LOOP_16_VEC_LOOP_C_5 = 8'd159,
    COMP_LOOP_16_VEC_LOOP_C_6 = 8'd160,
    COMP_LOOP_16_VEC_LOOP_C_7 = 8'd161,
    COMP_LOOP_16_VEC_LOOP_C_8 = 8'd162,
    COMP_LOOP_C_17 = 8'd163,
    STAGE_LOOP_C_1 = 8'd164,
    main_C_1 = 8'd165,
    main_C_2 = 8'd166;

  reg [7:0] state_var;
  reg [7:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIT_precomp_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 8'b00000001;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 8'b00000010;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 8'b00000011;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
      end
      COMP_LOOP_1_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00000100;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_1;
      end
      COMP_LOOP_1_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00000101;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_2;
      end
      COMP_LOOP_1_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00000110;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_3;
      end
      COMP_LOOP_1_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00000111;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_4;
      end
      COMP_LOOP_1_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00001000;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_5;
      end
      COMP_LOOP_1_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00001001;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_6;
      end
      COMP_LOOP_1_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00001010;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_7;
      end
      COMP_LOOP_1_VEC_LOOP_C_7 : begin
        fsm_output = 8'b00001011;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_8;
      end
      COMP_LOOP_1_VEC_LOOP_C_8 : begin
        fsm_output = 8'b00001100;
        if ( COMP_LOOP_1_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 8'b00001101;
        if ( COMP_LOOP_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_2_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00001110;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_1;
      end
      COMP_LOOP_2_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00001111;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_2;
      end
      COMP_LOOP_2_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00010000;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_3;
      end
      COMP_LOOP_2_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00010001;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_4;
      end
      COMP_LOOP_2_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00010010;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_5;
      end
      COMP_LOOP_2_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00010011;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_6;
      end
      COMP_LOOP_2_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00010100;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_7;
      end
      COMP_LOOP_2_VEC_LOOP_C_7 : begin
        fsm_output = 8'b00010101;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_8;
      end
      COMP_LOOP_2_VEC_LOOP_C_8 : begin
        fsm_output = 8'b00010110;
        if ( COMP_LOOP_2_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_3;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 8'b00010111;
        if ( COMP_LOOP_C_3_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_3_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00011000;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_1;
      end
      COMP_LOOP_3_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00011001;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_2;
      end
      COMP_LOOP_3_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00011010;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_3;
      end
      COMP_LOOP_3_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00011011;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_4;
      end
      COMP_LOOP_3_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00011100;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_5;
      end
      COMP_LOOP_3_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00011101;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_6;
      end
      COMP_LOOP_3_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00011110;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_7;
      end
      COMP_LOOP_3_VEC_LOOP_C_7 : begin
        fsm_output = 8'b00011111;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_8;
      end
      COMP_LOOP_3_VEC_LOOP_C_8 : begin
        fsm_output = 8'b00100000;
        if ( COMP_LOOP_3_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_4;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 8'b00100001;
        if ( COMP_LOOP_C_4_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_4_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00100010;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_1;
      end
      COMP_LOOP_4_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00100011;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_2;
      end
      COMP_LOOP_4_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00100100;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_3;
      end
      COMP_LOOP_4_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00100101;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_4;
      end
      COMP_LOOP_4_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00100110;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_5;
      end
      COMP_LOOP_4_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00100111;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_6;
      end
      COMP_LOOP_4_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00101000;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_7;
      end
      COMP_LOOP_4_VEC_LOOP_C_7 : begin
        fsm_output = 8'b00101001;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_8;
      end
      COMP_LOOP_4_VEC_LOOP_C_8 : begin
        fsm_output = 8'b00101010;
        if ( COMP_LOOP_4_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_5;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 8'b00101011;
        if ( COMP_LOOP_C_5_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_5_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00101100;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_1;
      end
      COMP_LOOP_5_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00101101;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_2;
      end
      COMP_LOOP_5_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00101110;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_3;
      end
      COMP_LOOP_5_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00101111;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_4;
      end
      COMP_LOOP_5_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00110000;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_5;
      end
      COMP_LOOP_5_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00110001;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_6;
      end
      COMP_LOOP_5_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00110010;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_7;
      end
      COMP_LOOP_5_VEC_LOOP_C_7 : begin
        fsm_output = 8'b00110011;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_8;
      end
      COMP_LOOP_5_VEC_LOOP_C_8 : begin
        fsm_output = 8'b00110100;
        if ( COMP_LOOP_5_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_6;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 8'b00110101;
        if ( COMP_LOOP_C_6_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_6_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00110110;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_1;
      end
      COMP_LOOP_6_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00110111;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_2;
      end
      COMP_LOOP_6_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00111000;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_3;
      end
      COMP_LOOP_6_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00111001;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_4;
      end
      COMP_LOOP_6_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00111010;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_5;
      end
      COMP_LOOP_6_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00111011;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_6;
      end
      COMP_LOOP_6_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00111100;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_7;
      end
      COMP_LOOP_6_VEC_LOOP_C_7 : begin
        fsm_output = 8'b00111101;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_8;
      end
      COMP_LOOP_6_VEC_LOOP_C_8 : begin
        fsm_output = 8'b00111110;
        if ( COMP_LOOP_6_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_7;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 8'b00111111;
        if ( COMP_LOOP_C_7_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_7_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01000000;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_1;
      end
      COMP_LOOP_7_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01000001;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_2;
      end
      COMP_LOOP_7_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01000010;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_3;
      end
      COMP_LOOP_7_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01000011;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_4;
      end
      COMP_LOOP_7_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01000100;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_5;
      end
      COMP_LOOP_7_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01000101;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_6;
      end
      COMP_LOOP_7_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01000110;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_7;
      end
      COMP_LOOP_7_VEC_LOOP_C_7 : begin
        fsm_output = 8'b01000111;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_8;
      end
      COMP_LOOP_7_VEC_LOOP_C_8 : begin
        fsm_output = 8'b01001000;
        if ( COMP_LOOP_7_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_8;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 8'b01001001;
        if ( COMP_LOOP_C_8_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_8_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01001010;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_1;
      end
      COMP_LOOP_8_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01001011;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_2;
      end
      COMP_LOOP_8_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01001100;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_3;
      end
      COMP_LOOP_8_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01001101;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_4;
      end
      COMP_LOOP_8_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01001110;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_5;
      end
      COMP_LOOP_8_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01001111;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_6;
      end
      COMP_LOOP_8_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01010000;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_7;
      end
      COMP_LOOP_8_VEC_LOOP_C_7 : begin
        fsm_output = 8'b01010001;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_8;
      end
      COMP_LOOP_8_VEC_LOOP_C_8 : begin
        fsm_output = 8'b01010010;
        if ( COMP_LOOP_8_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_9;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 8'b01010011;
        if ( COMP_LOOP_C_9_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_9_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01010100;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_1;
      end
      COMP_LOOP_9_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01010101;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_2;
      end
      COMP_LOOP_9_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01010110;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_3;
      end
      COMP_LOOP_9_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01010111;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_4;
      end
      COMP_LOOP_9_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01011000;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_5;
      end
      COMP_LOOP_9_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01011001;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_6;
      end
      COMP_LOOP_9_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01011010;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_7;
      end
      COMP_LOOP_9_VEC_LOOP_C_7 : begin
        fsm_output = 8'b01011011;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_8;
      end
      COMP_LOOP_9_VEC_LOOP_C_8 : begin
        fsm_output = 8'b01011100;
        if ( COMP_LOOP_9_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_10;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 8'b01011101;
        if ( COMP_LOOP_C_10_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_10_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01011110;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_1;
      end
      COMP_LOOP_10_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01011111;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_2;
      end
      COMP_LOOP_10_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01100000;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_3;
      end
      COMP_LOOP_10_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01100001;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_4;
      end
      COMP_LOOP_10_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01100010;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_5;
      end
      COMP_LOOP_10_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01100011;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_6;
      end
      COMP_LOOP_10_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01100100;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_7;
      end
      COMP_LOOP_10_VEC_LOOP_C_7 : begin
        fsm_output = 8'b01100101;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_8;
      end
      COMP_LOOP_10_VEC_LOOP_C_8 : begin
        fsm_output = 8'b01100110;
        if ( COMP_LOOP_10_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_11;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 8'b01100111;
        if ( COMP_LOOP_C_11_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_11_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01101000;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_1;
      end
      COMP_LOOP_11_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01101001;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_2;
      end
      COMP_LOOP_11_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01101010;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_3;
      end
      COMP_LOOP_11_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01101011;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_4;
      end
      COMP_LOOP_11_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01101100;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_5;
      end
      COMP_LOOP_11_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01101101;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_6;
      end
      COMP_LOOP_11_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01101110;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_7;
      end
      COMP_LOOP_11_VEC_LOOP_C_7 : begin
        fsm_output = 8'b01101111;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_8;
      end
      COMP_LOOP_11_VEC_LOOP_C_8 : begin
        fsm_output = 8'b01110000;
        if ( COMP_LOOP_11_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_12;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 8'b01110001;
        if ( COMP_LOOP_C_12_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_12_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01110010;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_1;
      end
      COMP_LOOP_12_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01110011;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_2;
      end
      COMP_LOOP_12_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01110100;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_3;
      end
      COMP_LOOP_12_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01110101;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_4;
      end
      COMP_LOOP_12_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01110110;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_5;
      end
      COMP_LOOP_12_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01110111;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_6;
      end
      COMP_LOOP_12_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01111000;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_7;
      end
      COMP_LOOP_12_VEC_LOOP_C_7 : begin
        fsm_output = 8'b01111001;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_8;
      end
      COMP_LOOP_12_VEC_LOOP_C_8 : begin
        fsm_output = 8'b01111010;
        if ( COMP_LOOP_12_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_13;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 8'b01111011;
        if ( COMP_LOOP_C_13_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_13_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01111100;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_1;
      end
      COMP_LOOP_13_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01111101;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_2;
      end
      COMP_LOOP_13_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01111110;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_3;
      end
      COMP_LOOP_13_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01111111;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_4;
      end
      COMP_LOOP_13_VEC_LOOP_C_4 : begin
        fsm_output = 8'b10000000;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_5;
      end
      COMP_LOOP_13_VEC_LOOP_C_5 : begin
        fsm_output = 8'b10000001;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_6;
      end
      COMP_LOOP_13_VEC_LOOP_C_6 : begin
        fsm_output = 8'b10000010;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_7;
      end
      COMP_LOOP_13_VEC_LOOP_C_7 : begin
        fsm_output = 8'b10000011;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_8;
      end
      COMP_LOOP_13_VEC_LOOP_C_8 : begin
        fsm_output = 8'b10000100;
        if ( COMP_LOOP_13_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_14;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 8'b10000101;
        if ( COMP_LOOP_C_14_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_14_VEC_LOOP_C_0 : begin
        fsm_output = 8'b10000110;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_1;
      end
      COMP_LOOP_14_VEC_LOOP_C_1 : begin
        fsm_output = 8'b10000111;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_2;
      end
      COMP_LOOP_14_VEC_LOOP_C_2 : begin
        fsm_output = 8'b10001000;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_3;
      end
      COMP_LOOP_14_VEC_LOOP_C_3 : begin
        fsm_output = 8'b10001001;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_4;
      end
      COMP_LOOP_14_VEC_LOOP_C_4 : begin
        fsm_output = 8'b10001010;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_5;
      end
      COMP_LOOP_14_VEC_LOOP_C_5 : begin
        fsm_output = 8'b10001011;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_6;
      end
      COMP_LOOP_14_VEC_LOOP_C_6 : begin
        fsm_output = 8'b10001100;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_7;
      end
      COMP_LOOP_14_VEC_LOOP_C_7 : begin
        fsm_output = 8'b10001101;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_8;
      end
      COMP_LOOP_14_VEC_LOOP_C_8 : begin
        fsm_output = 8'b10001110;
        if ( COMP_LOOP_14_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_15;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 8'b10001111;
        if ( COMP_LOOP_C_15_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_15_VEC_LOOP_C_0 : begin
        fsm_output = 8'b10010000;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_1;
      end
      COMP_LOOP_15_VEC_LOOP_C_1 : begin
        fsm_output = 8'b10010001;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_2;
      end
      COMP_LOOP_15_VEC_LOOP_C_2 : begin
        fsm_output = 8'b10010010;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_3;
      end
      COMP_LOOP_15_VEC_LOOP_C_3 : begin
        fsm_output = 8'b10010011;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_4;
      end
      COMP_LOOP_15_VEC_LOOP_C_4 : begin
        fsm_output = 8'b10010100;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_5;
      end
      COMP_LOOP_15_VEC_LOOP_C_5 : begin
        fsm_output = 8'b10010101;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_6;
      end
      COMP_LOOP_15_VEC_LOOP_C_6 : begin
        fsm_output = 8'b10010110;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_7;
      end
      COMP_LOOP_15_VEC_LOOP_C_7 : begin
        fsm_output = 8'b10010111;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_8;
      end
      COMP_LOOP_15_VEC_LOOP_C_8 : begin
        fsm_output = 8'b10011000;
        if ( COMP_LOOP_15_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_16;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 8'b10011001;
        if ( COMP_LOOP_C_16_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_16_VEC_LOOP_C_0 : begin
        fsm_output = 8'b10011010;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_1;
      end
      COMP_LOOP_16_VEC_LOOP_C_1 : begin
        fsm_output = 8'b10011011;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_2;
      end
      COMP_LOOP_16_VEC_LOOP_C_2 : begin
        fsm_output = 8'b10011100;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_3;
      end
      COMP_LOOP_16_VEC_LOOP_C_3 : begin
        fsm_output = 8'b10011101;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_4;
      end
      COMP_LOOP_16_VEC_LOOP_C_4 : begin
        fsm_output = 8'b10011110;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_5;
      end
      COMP_LOOP_16_VEC_LOOP_C_5 : begin
        fsm_output = 8'b10011111;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_6;
      end
      COMP_LOOP_16_VEC_LOOP_C_6 : begin
        fsm_output = 8'b10100000;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_7;
      end
      COMP_LOOP_16_VEC_LOOP_C_7 : begin
        fsm_output = 8'b10100001;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_8;
      end
      COMP_LOOP_16_VEC_LOOP_C_8 : begin
        fsm_output = 8'b10100010;
        if ( COMP_LOOP_16_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_17;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 8'b10100011;
        if ( COMP_LOOP_C_17_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 8'b10100100;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 8'b10100101;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 8'b10100110;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 8'b00000000;
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_staller
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_staller (
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl
    (
  core_wten, twiddle_h_rsc_triosy_obj_iswt0, twiddle_h_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input twiddle_h_rsc_triosy_obj_iswt0;
  output twiddle_h_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsc_triosy_obj_ld_core_sct = twiddle_h_rsc_triosy_obj_iswt0 &
      (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl
    (
  core_wten, twiddle_rsc_triosy_obj_iswt0, twiddle_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input twiddle_rsc_triosy_obj_iswt0;
  output twiddle_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsc_triosy_obj_ld_core_sct = twiddle_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl (
  core_wten, r_rsc_triosy_obj_iswt0, r_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input r_rsc_triosy_obj_iswt0;
  output r_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign r_rsc_triosy_obj_ld_core_sct = r_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl (
  core_wten, p_rsc_triosy_obj_iswt0, p_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input p_rsc_triosy_obj_iswt0;
  output p_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign p_rsc_triosy_obj_ld_core_sct = p_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl (
  core_wten, vec_rsc_triosy_obj_iswt0, vec_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_obj_iswt0;
  output vec_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_obj_ld_core_sct = vec_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_dp (
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_ctrl (
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp (
  clk, rst, twiddle_h_rsci_qa_d, twiddle_h_rsci_qa_d_mxwt, twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt,
      twiddle_h_rsci_biwt_1, twiddle_h_rsci_bdwt_2
);
  input clk;
  input rst;
  input [63:0] twiddle_h_rsci_qa_d;
  output [63:0] twiddle_h_rsci_qa_d_mxwt;
  input twiddle_h_rsci_biwt;
  input twiddle_h_rsci_bdwt;
  input twiddle_h_rsci_biwt_1;
  input twiddle_h_rsci_bdwt_2;


  // Interconnect Declarations
  reg twiddle_h_rsci_bcwt;
  reg twiddle_h_rsci_bcwt_1;
  reg [31:0] twiddle_h_rsci_qa_d_bfwt_63_32;
  reg [31:0] twiddle_h_rsci_qa_d_bfwt_31_0;

  wire[31:0] COMP_LOOP_twiddle_help_mux_2_nl;
  wire[31:0] COMP_LOOP_twiddle_help_mux_3_nl;

  // Interconnect Declarations for Component Instantiations 
  assign COMP_LOOP_twiddle_help_mux_2_nl = MUX_v_32_2_2((twiddle_h_rsci_qa_d[63:32]),
      twiddle_h_rsci_qa_d_bfwt_63_32, twiddle_h_rsci_bcwt_1);
  assign COMP_LOOP_twiddle_help_mux_3_nl = MUX_v_32_2_2((twiddle_h_rsci_qa_d[31:0]),
      twiddle_h_rsci_qa_d_bfwt_31_0, twiddle_h_rsci_bcwt);
  assign twiddle_h_rsci_qa_d_mxwt = {COMP_LOOP_twiddle_help_mux_2_nl , COMP_LOOP_twiddle_help_mux_3_nl};
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsci_bcwt <= 1'b0;
      twiddle_h_rsci_bcwt_1 <= 1'b0;
    end
    else begin
      twiddle_h_rsci_bcwt <= ~((~(twiddle_h_rsci_bcwt | twiddle_h_rsci_biwt)) | twiddle_h_rsci_bdwt);
      twiddle_h_rsci_bcwt_1 <= ~((~(twiddle_h_rsci_bcwt_1 | twiddle_h_rsci_biwt_1))
          | twiddle_h_rsci_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsci_biwt_1 ) begin
      twiddle_h_rsci_qa_d_bfwt_63_32 <= twiddle_h_rsci_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( twiddle_h_rsci_biwt ) begin
      twiddle_h_rsci_qa_d_bfwt_31_0 <= twiddle_h_rsci_qa_d[31:0];
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl (
  core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_oswt_1, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt, twiddle_h_rsci_biwt_1, twiddle_h_rsci_bdwt_2,
      twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct, core_wten_pff, twiddle_h_rsci_oswt_1_pff,
      twiddle_h_rsci_oswt_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsci_oswt;
  input twiddle_h_rsci_oswt_1;
  input [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  output twiddle_h_rsci_biwt;
  output twiddle_h_rsci_bdwt;
  output twiddle_h_rsci_biwt_1;
  output twiddle_h_rsci_bdwt_2;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  input core_wten_pff;
  input twiddle_h_rsci_oswt_1_pff;
  input twiddle_h_rsci_oswt_pff;


  wire[0:0] COMP_LOOP_twiddle_help_and_8_nl;
  wire[0:0] COMP_LOOP_twiddle_help_and_9_nl;

  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_bdwt = twiddle_h_rsci_oswt & core_wen;
  assign twiddle_h_rsci_biwt = (~ core_wten) & twiddle_h_rsci_oswt;
  assign twiddle_h_rsci_bdwt_2 = twiddle_h_rsci_oswt_1 & core_wen;
  assign twiddle_h_rsci_biwt_1 = (~ core_wten) & twiddle_h_rsci_oswt_1;
  assign COMP_LOOP_twiddle_help_and_8_nl = (~ core_wten_pff) & twiddle_h_rsci_oswt_1_pff;
  assign COMP_LOOP_twiddle_help_and_9_nl = (~ core_wten_pff) & twiddle_h_rsci_oswt_pff;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({COMP_LOOP_twiddle_help_and_8_nl , COMP_LOOP_twiddle_help_and_9_nl});
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp (
  clk, rst, twiddle_rsci_qa_d, twiddle_rsci_qa_d_mxwt, twiddle_rsci_biwt, twiddle_rsci_bdwt,
      twiddle_rsci_biwt_1, twiddle_rsci_bdwt_2
);
  input clk;
  input rst;
  input [63:0] twiddle_rsci_qa_d;
  output [63:0] twiddle_rsci_qa_d_mxwt;
  input twiddle_rsci_biwt;
  input twiddle_rsci_bdwt;
  input twiddle_rsci_biwt_1;
  input twiddle_rsci_bdwt_2;


  // Interconnect Declarations
  reg twiddle_rsci_bcwt;
  reg twiddle_rsci_bcwt_1;
  reg [31:0] twiddle_rsci_qa_d_bfwt_63_32;
  reg [31:0] twiddle_rsci_qa_d_bfwt_31_0;

  wire[31:0] COMP_LOOP_twiddle_f_mux_2_nl;
  wire[31:0] COMP_LOOP_twiddle_f_mux_3_nl;

  // Interconnect Declarations for Component Instantiations 
  assign COMP_LOOP_twiddle_f_mux_2_nl = MUX_v_32_2_2((twiddle_rsci_qa_d[63:32]),
      twiddle_rsci_qa_d_bfwt_63_32, twiddle_rsci_bcwt_1);
  assign COMP_LOOP_twiddle_f_mux_3_nl = MUX_v_32_2_2((twiddle_rsci_qa_d[31:0]), twiddle_rsci_qa_d_bfwt_31_0,
      twiddle_rsci_bcwt);
  assign twiddle_rsci_qa_d_mxwt = {COMP_LOOP_twiddle_f_mux_2_nl , COMP_LOOP_twiddle_f_mux_3_nl};
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsci_bcwt <= 1'b0;
      twiddle_rsci_bcwt_1 <= 1'b0;
    end
    else begin
      twiddle_rsci_bcwt <= ~((~(twiddle_rsci_bcwt | twiddle_rsci_biwt)) | twiddle_rsci_bdwt);
      twiddle_rsci_bcwt_1 <= ~((~(twiddle_rsci_bcwt_1 | twiddle_rsci_biwt_1)) | twiddle_rsci_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsci_biwt_1 ) begin
      twiddle_rsci_qa_d_bfwt_63_32 <= twiddle_rsci_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( twiddle_rsci_biwt ) begin
      twiddle_rsci_qa_d_bfwt_31_0 <= twiddle_rsci_qa_d[31:0];
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl (
  core_wen, core_wten, twiddle_rsci_oswt, twiddle_rsci_oswt_1, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      twiddle_rsci_biwt, twiddle_rsci_bdwt, twiddle_rsci_biwt_1, twiddle_rsci_bdwt_2,
      twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct, core_wten_pff, twiddle_rsci_oswt_1_pff,
      twiddle_rsci_oswt_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsci_oswt;
  input twiddle_rsci_oswt_1;
  input [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  output twiddle_rsci_biwt;
  output twiddle_rsci_bdwt;
  output twiddle_rsci_biwt_1;
  output twiddle_rsci_bdwt_2;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  input core_wten_pff;
  input twiddle_rsci_oswt_1_pff;
  input twiddle_rsci_oswt_pff;


  wire[0:0] COMP_LOOP_twiddle_f_and_8_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_9_nl;

  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_bdwt = twiddle_rsci_oswt & core_wen;
  assign twiddle_rsci_biwt = (~ core_wten) & twiddle_rsci_oswt;
  assign twiddle_rsci_bdwt_2 = twiddle_rsci_oswt_1 & core_wen;
  assign twiddle_rsci_biwt_1 = (~ core_wten) & twiddle_rsci_oswt_1;
  assign COMP_LOOP_twiddle_f_and_8_nl = (~ core_wten_pff) & twiddle_rsci_oswt_1_pff;
  assign COMP_LOOP_twiddle_f_and_9_nl = (~ core_wten_pff) & twiddle_rsci_oswt_pff;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({COMP_LOOP_twiddle_f_and_8_nl , COMP_LOOP_twiddle_f_and_9_nl});
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_wait_dp (
  ensig_cgo_iro, ensig_cgo_iro_2, core_wen, ensig_cgo, COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en,
      ensig_cgo_2, COMP_LOOP_1_mult_cmp_ccs_ccore_en
);
  input ensig_cgo_iro;
  input ensig_cgo_iro_2;
  input core_wen;
  input ensig_cgo;
  output COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en;
  input ensig_cgo_2;
  output COMP_LOOP_1_mult_cmp_ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  assign COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en = core_wen & (ensig_cgo | ensig_cgo_iro);
  assign COMP_LOOP_1_mult_cmp_ccs_ccore_en = core_wen & (ensig_cgo_2 | ensig_cgo_iro_2);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_dp (
  clk, rst, vec_rsci_da_d, vec_rsci_qa_d, vec_rsci_da_d_core, vec_rsci_qa_d_mxwt,
      vec_rsci_biwt, vec_rsci_bdwt, vec_rsci_biwt_1, vec_rsci_bdwt_2
);
  input clk;
  input rst;
  output [31:0] vec_rsci_da_d;
  input [63:0] vec_rsci_qa_d;
  input [63:0] vec_rsci_da_d_core;
  output [63:0] vec_rsci_qa_d_mxwt;
  input vec_rsci_biwt;
  input vec_rsci_bdwt;
  input vec_rsci_biwt_1;
  input vec_rsci_bdwt_2;


  // Interconnect Declarations
  reg vec_rsci_bcwt;
  reg vec_rsci_bcwt_1;
  reg [31:0] vec_rsci_qa_d_bfwt_63_32;
  reg [31:0] vec_rsci_qa_d_bfwt_31_0;

  wire[31:0] VEC_LOOP_mux_2_nl;
  wire[31:0] VEC_LOOP_mux_3_nl;

  // Interconnect Declarations for Component Instantiations 
  assign VEC_LOOP_mux_2_nl = MUX_v_32_2_2((vec_rsci_qa_d[63:32]), vec_rsci_qa_d_bfwt_63_32,
      vec_rsci_bcwt_1);
  assign VEC_LOOP_mux_3_nl = MUX_v_32_2_2((vec_rsci_qa_d[31:0]), vec_rsci_qa_d_bfwt_31_0,
      vec_rsci_bcwt);
  assign vec_rsci_qa_d_mxwt = {VEC_LOOP_mux_2_nl , VEC_LOOP_mux_3_nl};
  assign vec_rsci_da_d = vec_rsci_da_d_core[31:0];
  always @(posedge clk) begin
    if ( rst ) begin
      vec_rsci_bcwt <= 1'b0;
      vec_rsci_bcwt_1 <= 1'b0;
    end
    else begin
      vec_rsci_bcwt <= ~((~(vec_rsci_bcwt | vec_rsci_biwt)) | vec_rsci_bdwt);
      vec_rsci_bcwt_1 <= ~((~(vec_rsci_bcwt_1 | vec_rsci_biwt_1)) | vec_rsci_bdwt_2);
    end
  end
  always @(posedge clk) begin
    if ( vec_rsci_biwt_1 ) begin
      vec_rsci_qa_d_bfwt_63_32 <= vec_rsci_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( vec_rsci_biwt ) begin
      vec_rsci_qa_d_bfwt_31_0 <= vec_rsci_qa_d[31:0];
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl (
  core_wen, core_wten, vec_rsci_oswt, vec_rsci_oswt_1, vec_rsci_wea_d_core_psct,
      vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      vec_rsci_biwt, vec_rsci_bdwt, vec_rsci_biwt_1, vec_rsci_bdwt_2, vec_rsci_wea_d_core_sct,
      vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct, vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct,
      core_wten_pff, vec_rsci_oswt_pff, vec_rsci_oswt_1_pff
);
  input core_wen;
  input core_wten;
  input vec_rsci_oswt;
  input vec_rsci_oswt_1;
  input [1:0] vec_rsci_wea_d_core_psct;
  input [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  output vec_rsci_biwt;
  output vec_rsci_bdwt;
  output vec_rsci_biwt_1;
  output vec_rsci_bdwt_2;
  output [1:0] vec_rsci_wea_d_core_sct;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  input core_wten_pff;
  input vec_rsci_oswt_pff;
  input vec_rsci_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsci_dswt_pff;

  wire[0:0] VEC_LOOP_and_8_nl;
  wire[0:0] VEC_LOOP_and_12_nl;
  wire[0:0] VEC_LOOP_and_10_nl;

  // Interconnect Declarations for Component Instantiations 
  assign vec_rsci_bdwt = vec_rsci_oswt & core_wen;
  assign vec_rsci_biwt = (~ core_wten) & vec_rsci_oswt;
  assign vec_rsci_bdwt_2 = vec_rsci_oswt_1 & core_wen;
  assign vec_rsci_biwt_1 = (~ core_wten) & vec_rsci_oswt_1;
  assign VEC_LOOP_and_8_nl = (vec_rsci_wea_d_core_psct[0]) & vec_rsci_dswt_pff;
  assign vec_rsci_wea_d_core_sct = {1'b0 , VEC_LOOP_and_8_nl};
  assign vec_rsci_dswt_pff = (~ core_wten_pff) & vec_rsci_oswt_pff;
  assign VEC_LOOP_and_12_nl = (~ core_wten_pff) & vec_rsci_oswt_1_pff;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({VEC_LOOP_and_12_nl , vec_rsci_dswt_pff});
  assign VEC_LOOP_and_10_nl = (vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])
      & vec_rsci_dswt_pff;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct = {1'b0 , VEC_LOOP_and_10_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_dp (
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_ctrl (
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj (
  twiddle_h_rsc_triosy_lz, core_wten, twiddle_h_rsc_triosy_obj_iswt0
);
  output twiddle_h_rsc_triosy_lz;
  input core_wten;
  input twiddle_h_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_h_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_obj (
      .ld(twiddle_h_rsc_triosy_obj_ld_core_sct),
      .lz(twiddle_h_rsc_triosy_lz)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl
      inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_obj_iswt0(twiddle_h_rsc_triosy_obj_iswt0),
      .twiddle_h_rsc_triosy_obj_ld_core_sct(twiddle_h_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj (
  twiddle_rsc_triosy_lz, core_wten, twiddle_rsc_triosy_obj_iswt0
);
  output twiddle_rsc_triosy_lz;
  input core_wten;
  input twiddle_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire twiddle_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_obj (
      .ld(twiddle_rsc_triosy_obj_ld_core_sct),
      .lz(twiddle_rsc_triosy_lz)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl
      inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_obj_iswt0(twiddle_rsc_triosy_obj_iswt0),
      .twiddle_rsc_triosy_obj_ld_core_sct(twiddle_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj (
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
  inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_r_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .r_rsc_triosy_obj_iswt0(r_rsc_triosy_obj_iswt0),
      .r_rsc_triosy_obj_ld_core_sct(r_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj (
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
  inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_p_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .p_rsc_triosy_obj_iswt0(p_rsc_triosy_obj_iswt0),
      .p_rsc_triosy_obj_ld_core_sct(p_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj (
  vec_rsc_triosy_lz, core_wten, vec_rsc_triosy_obj_iswt0
);
  output vec_rsc_triosy_lz;
  input core_wten;
  input vec_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire vec_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_obj (
      .ld(vec_rsc_triosy_obj_ld_core_sct),
      .lz(vec_rsc_triosy_lz)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_obj_iswt0(vec_rsc_triosy_obj_iswt0),
      .vec_rsc_triosy_obj_ld_core_sct(vec_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_complete_rsci
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_complete_rsci (
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
  inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_ctrl inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .complete_rsci_oswt(complete_rsci_oswt),
      .complete_rsci_biwt(complete_rsci_biwt),
      .complete_rsci_bdwt(complete_rsci_bdwt),
      .complete_rsci_bcwt(complete_rsci_bcwt),
      .complete_rsci_ivld_core_sct(complete_rsci_ivld_core_sct),
      .complete_rsci_irdy(complete_rsci_irdy)
    );
  inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_dp inPlaceNTT_DIT_precomp_core_complete_rsci_complete_wait_dp_inst
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1 (
  clk, rst, twiddle_h_rsci_qa_d, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_oswt_1, twiddle_h_rsci_qa_d_mxwt,
      twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, core_wten_pff, twiddle_h_rsci_oswt_1_pff,
      twiddle_h_rsci_oswt_pff
);
  input clk;
  input rst;
  input [63:0] twiddle_h_rsci_qa_d;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsci_oswt;
  input twiddle_h_rsci_oswt_1;
  output [63:0] twiddle_h_rsci_qa_d_mxwt;
  input [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input core_wten_pff;
  input twiddle_h_rsci_oswt_1_pff;
  input twiddle_h_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_h_rsci_biwt;
  wire twiddle_h_rsci_bdwt;
  wire twiddle_h_rsci_biwt_1;
  wire twiddle_h_rsci_bdwt_2;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsci_oswt(twiddle_h_rsci_oswt),
      .twiddle_h_rsci_oswt_1(twiddle_h_rsci_oswt_1),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt),
      .twiddle_h_rsci_biwt_1(twiddle_h_rsci_biwt_1),
      .twiddle_h_rsci_bdwt_2(twiddle_h_rsci_bdwt_2),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .twiddle_h_rsci_oswt_1_pff(twiddle_h_rsci_oswt_1_pff),
      .twiddle_h_rsci_oswt_pff(twiddle_h_rsci_oswt_pff)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_qa_d_mxwt(twiddle_h_rsci_qa_d_mxwt),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt),
      .twiddle_h_rsci_biwt_1(twiddle_h_rsci_biwt_1),
      .twiddle_h_rsci_bdwt_2(twiddle_h_rsci_bdwt_2)
    );
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsci_1 (
  clk, rst, twiddle_rsci_qa_d, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d, core_wen,
      core_wten, twiddle_rsci_oswt, twiddle_rsci_oswt_1, twiddle_rsci_qa_d_mxwt,
      twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, core_wten_pff, twiddle_rsci_oswt_1_pff,
      twiddle_rsci_oswt_pff
);
  input clk;
  input rst;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsci_oswt;
  input twiddle_rsci_oswt_1;
  output [63:0] twiddle_rsci_qa_d_mxwt;
  input [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input core_wten_pff;
  input twiddle_rsci_oswt_1_pff;
  input twiddle_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_rsci_biwt;
  wire twiddle_rsci_bdwt;
  wire twiddle_rsci_biwt_1;
  wire twiddle_rsci_bdwt_2;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(twiddle_rsci_oswt),
      .twiddle_rsci_oswt_1(twiddle_rsci_oswt_1),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt),
      .twiddle_rsci_biwt_1(twiddle_rsci_biwt_1),
      .twiddle_rsci_bdwt_2(twiddle_rsci_bdwt_2),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .twiddle_rsci_oswt_1_pff(twiddle_rsci_oswt_1_pff),
      .twiddle_rsci_oswt_pff(twiddle_rsci_oswt_pff)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_qa_d_mxwt(twiddle_rsci_qa_d_mxwt),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt),
      .twiddle_rsci_biwt_1(twiddle_rsci_biwt_1),
      .twiddle_rsci_bdwt_2(twiddle_rsci_bdwt_2)
    );
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_vec_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_vec_rsci_1 (
  clk, rst, vec_rsci_da_d, vec_rsci_qa_d, vec_rsci_wea_d, vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d, core_wen, core_wten, vec_rsci_oswt,
      vec_rsci_oswt_1, vec_rsci_da_d_core, vec_rsci_qa_d_mxwt, vec_rsci_wea_d_core_psct,
      vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct,
      core_wten_pff, vec_rsci_oswt_pff, vec_rsci_oswt_1_pff
);
  input clk;
  input rst;
  output [31:0] vec_rsci_da_d;
  input [63:0] vec_rsci_qa_d;
  output [1:0] vec_rsci_wea_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  input core_wen;
  input core_wten;
  input vec_rsci_oswt;
  input vec_rsci_oswt_1;
  input [63:0] vec_rsci_da_d_core;
  output [63:0] vec_rsci_qa_d_mxwt;
  input [1:0] vec_rsci_wea_d_core_psct;
  input [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  input core_wten_pff;
  input vec_rsci_oswt_pff;
  input vec_rsci_oswt_1_pff;


  // Interconnect Declarations
  wire vec_rsci_biwt;
  wire vec_rsci_bdwt;
  wire vec_rsci_biwt_1;
  wire vec_rsci_bdwt_2;
  wire [1:0] vec_rsci_wea_d_core_sct;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  wire [31:0] vec_rsci_da_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (vec_rsci_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst_vec_rsci_da_d_core;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst_vec_rsci_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsci_da_d_core[31:0])};
  inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsci_oswt(vec_rsci_oswt),
      .vec_rsci_oswt_1(vec_rsci_oswt_1),
      .vec_rsci_wea_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_wea_d_core_psct[1:0]),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .vec_rsci_biwt(vec_rsci_biwt),
      .vec_rsci_bdwt(vec_rsci_bdwt),
      .vec_rsci_biwt_1(vec_rsci_biwt_1),
      .vec_rsci_bdwt_2(vec_rsci_bdwt_2),
      .vec_rsci_wea_d_core_sct(vec_rsci_wea_d_core_sct),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct(vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .vec_rsci_oswt_pff(vec_rsci_oswt_pff),
      .vec_rsci_oswt_1_pff(vec_rsci_oswt_1_pff)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_dp inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsci_da_d(vec_rsci_da_d_reg),
      .vec_rsci_qa_d(vec_rsci_qa_d),
      .vec_rsci_da_d_core(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst_vec_rsci_da_d_core[63:0]),
      .vec_rsci_qa_d_mxwt(vec_rsci_qa_d_mxwt),
      .vec_rsci_biwt(vec_rsci_biwt),
      .vec_rsci_bdwt(vec_rsci_bdwt),
      .vec_rsci_biwt_1(vec_rsci_biwt_1),
      .vec_rsci_bdwt_2(vec_rsci_bdwt_2)
    );
  assign vec_rsci_wea_d = vec_rsci_wea_d_core_sct;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_sct;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_run_rsci
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_run_rsci (
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
  inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_ctrl inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .run_rsci_oswt(run_rsci_oswt),
      .core_wten(core_wten),
      .run_rsci_biwt(run_rsci_biwt),
      .run_rsci_bdwt(run_rsci_bdwt)
    );
  inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_dp inPlaceNTT_DIT_precomp_core_run_rsci_run_wait_dp_inst
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core (
  clk, rst, run_rsc_rdy, run_rsc_vld, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz,
      r_rsc_triosy_lz, twiddle_rsc_triosy_lz, twiddle_h_rsc_triosy_lz, complete_rsc_rdy,
      complete_rsc_vld, vec_rsci_adra_d, vec_rsci_da_d, vec_rsci_qa_d, vec_rsci_wea_d,
      vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d,
      twiddle_rsci_adra_d, twiddle_rsci_qa_d, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsci_adra_d, twiddle_h_rsci_qa_d, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output vec_rsc_triosy_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_lz;
  output twiddle_h_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;
  output [19:0] vec_rsci_adra_d;
  output [31:0] vec_rsci_da_d;
  input [63:0] vec_rsci_qa_d;
  output [1:0] vec_rsci_wea_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [19:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [19:0] twiddle_h_rsci_adra_d;
  input [63:0] twiddle_h_rsci_qa_d;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations
  wire core_wten;
  wire run_rsci_ivld_mxwt;
  wire [63:0] vec_rsci_qa_d_mxwt;
  wire [31:0] p_rsci_idat;
  wire [63:0] twiddle_rsci_qa_d_mxwt;
  wire [63:0] twiddle_h_rsci_qa_d_mxwt;
  wire complete_rsci_wen_comp;
  wire [31:0] COMP_LOOP_1_modulo_sub_cmp_return_rsc_z;
  wire COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en;
  wire [31:0] COMP_LOOP_1_modulo_add_cmp_return_rsc_z;
  wire [31:0] COMP_LOOP_1_mult_cmp_return_rsc_z;
  wire COMP_LOOP_1_mult_cmp_ccs_ccore_en;
  wire [7:0] fsm_output;
  wire nor_tmp;
  wire mux_tmp_3;
  wire mux_tmp_4;
  wire mux_tmp_5;
  wire or_tmp_5;
  wire or_tmp_6;
  wire nor_tmp_1;
  wire mux_tmp_70;
  wire mux_tmp_105;
  wire and_tmp_2;
  wire or_dcpl_66;
  wire or_dcpl_69;
  wire or_tmp_58;
  wire mux_tmp_114;
  wire mux_tmp_115;
  wire mux_tmp_116;
  wire mux_tmp_134;
  wire mux_tmp_135;
  wire mux_tmp_136;
  wire and_dcpl_10;
  wire and_dcpl_11;
  wire and_dcpl_12;
  wire and_dcpl_13;
  wire and_dcpl_15;
  wire and_dcpl_16;
  wire and_dcpl_17;
  wire and_dcpl_18;
  wire and_dcpl_19;
  wire and_dcpl_20;
  wire and_dcpl_21;
  wire or_tmp_78;
  wire or_tmp_81;
  wire mux_tmp_146;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire mux_tmp_155;
  wire nand_tmp_4;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire or_tmp_93;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_34;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_38;
  wire and_dcpl_39;
  wire and_dcpl_43;
  wire and_dcpl_44;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire and_dcpl_47;
  wire and_dcpl_48;
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_56;
  wire and_dcpl_57;
  wire and_dcpl_58;
  wire and_dcpl_60;
  wire and_dcpl_61;
  wire and_dcpl_63;
  wire and_dcpl_64;
  wire and_dcpl_65;
  wire and_dcpl_67;
  wire and_dcpl_68;
  wire and_dcpl_69;
  wire and_dcpl_73;
  wire mux_tmp_166;
  wire or_tmp_103;
  wire or_tmp_107;
  wire and_tmp_3;
  wire or_tmp_115;
  wire or_tmp_117;
  wire or_tmp_119;
  wire mux_tmp_189;
  wire mux_tmp_192;
  wire nor_tmp_18;
  wire or_tmp_137;
  wire mux_tmp_201;
  wire mux_tmp_203;
  wire and_dcpl_82;
  wire and_dcpl_83;
  wire and_dcpl_99;
  wire mux_tmp_212;
  wire mux_tmp_215;
  wire and_dcpl_101;
  wire or_tmp_155;
  wire and_dcpl_110;
  wire and_dcpl_115;
  wire mux_tmp_242;
  wire mux_tmp_243;
  wire or_tmp_180;
  wire mux_tmp_251;
  wire mux_tmp_254;
  wire mux_tmp_255;
  wire or_tmp_192;
  wire mux_tmp_266;
  wire or_tmp_202;
  wire mux_tmp_280;
  wire mux_tmp_285;
  wire or_tmp_227;
  wire or_tmp_228;
  wire and_dcpl_143;
  wire mux_tmp_337;
  wire mux_tmp_339;
  wire mux_tmp_340;
  wire mux_tmp_341;
  wire mux_tmp_348;
  wire mux_tmp_349;
  wire mux_tmp_380;
  wire and_dcpl_153;
  wire mux_tmp_393;
  wire mux_tmp_394;
  wire or_tmp_292;
  wire or_tmp_294;
  wire mux_tmp_430;
  wire mux_tmp_431;
  reg COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm;
  reg [9:0] VEC_LOOP_acc_1_cse_10_sva;
  reg [10:0] STAGE_LOOP_lshift_psp_sva;
  reg [10:0] VEC_LOOP_j_10_10_0_sva_1;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  wire or_183_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_twiddle_rsci_oswt_1_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_2_cse;
  wire or_119_cse;
  wire and_176_cse;
  wire or_203_cse;
  wire or_13_cse;
  wire or_197_cse;
  wire or_85_cse;
  wire or_88_cse;
  wire or_365_cse;
  wire or_256_cse;
  wire nor_53_cse;
  wire or_142_cse;
  wire or_269_cse;
  wire or_176_cse;
  wire or_175_cse;
  wire or_245_cse;
  wire or_246_cse;
  wire or_309_cse;
  wire mux_128_cse;
  wire mux_144_cse;
  wire or_259_cse;
  wire mux_138_cse;
  wire mux_148_cse;
  wire nand_2_cse;
  wire or_146_cse;
  wire or_155_cse;
  wire mux_237_cse;
  wire mux_149_cse;
  wire mux_235_cse;
  wire nor_86_cse;
  wire mux_238_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [9:0] COMP_LOOP_2_twiddle_f_mul_rmff;
  wire [19:0] nl_COMP_LOOP_2_twiddle_f_mul_rmff;
  wire [5:0] COMP_LOOP_twiddle_f_mux1h_56_rmff;
  wire COMP_LOOP_twiddle_f_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_14_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_41_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_64_rmff;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire nor_82_rmff;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_122_rmff;
  reg [31:0] factor1_1_sva;
  reg [31:0] VEC_LOOP_mult_vec_1_sva;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [9:0] VEC_LOOP_acc_10_cse_1_sva;
  reg [8:0] VEC_LOOP_acc_12_psp_sva;
  reg [6:0] COMP_LOOP_9_twiddle_f_lshift_itm;
  reg [31:0] VEC_LOOP_j_1_sva;
  reg [31:0] p_sva;
  wire mux_133_itm;
  wire [5:0] COMP_LOOP_1_twiddle_f_lshift_itm;
  wire mux_239_itm;
  wire mux_263_itm;
  wire and_dcpl;
  wire and_dcpl_156;
  wire and_dcpl_158;
  wire and_dcpl_159;
  wire and_dcpl_161;
  wire and_dcpl_162;
  wire and_dcpl_163;
  wire and_dcpl_164;
  wire and_dcpl_166;
  wire and_dcpl_167;
  wire and_dcpl_169;
  wire and_dcpl_170;
  wire and_dcpl_171;
  wire and_dcpl_172;
  wire and_dcpl_174;
  wire and_dcpl_175;
  wire and_dcpl_176;
  wire and_dcpl_177;
  wire and_dcpl_178;
  wire and_dcpl_179;
  wire and_dcpl_180;
  wire and_dcpl_181;
  wire and_dcpl_182;
  wire and_dcpl_184;
  wire and_dcpl_186;
  wire and_dcpl_187;
  wire and_dcpl_188;
  wire and_dcpl_189;
  wire and_dcpl_191;
  wire and_dcpl_193;
  wire and_dcpl_196;
  wire [9:0] z_out;
  wire [19:0] nl_z_out;
  wire and_dcpl_209;
  wire [9:0] z_out_2;
  wire [10:0] z_out_3;
  wire and_dcpl_245;
  wire [3:0] z_out_4;
  wire [4:0] nl_z_out_4;
  wire and_dcpl_273;
  wire [9:0] z_out_6;
  wire [10:0] nl_z_out_6;
  wire and_dcpl_278;
  wire and_dcpl_279;
  wire and_dcpl_283;
  wire and_dcpl_285;
  wire and_dcpl_287;
  wire and_dcpl_288;
  wire and_dcpl_297;
  wire and_dcpl_298;
  wire and_dcpl_301;
  wire and_dcpl_304;
  wire and_dcpl_305;
  wire and_dcpl_313;
  wire [9:0] z_out_7;
  wire [10:0] nl_z_out_7;
  wire and_dcpl_341;
  wire and_dcpl_347;
  wire [9:0] z_out_9;
  wire [10:0] nl_z_out_9;
  wire [9:0] z_out_12;
  wire [10:0] nl_z_out_12;
  wire or_tmp_300;
  wire mux_tmp_438;
  wire mux_tmp_440;
  wire mux_tmp_441;
  wire and_dcpl_445;
  wire [31:0] z_out_16;
  wire and_dcpl_448;
  wire and_dcpl_452;
  wire and_dcpl_457;
  wire and_dcpl_461;
  wire and_dcpl_464;
  wire and_dcpl_465;
  wire and_dcpl_469;
  wire and_dcpl_472;
  wire [7:0] z_out_17;
  wire and_dcpl_479;
  wire and_dcpl_484;
  wire [6:0] z_out_18;
  wire [7:0] nl_z_out_18;
  wire and_dcpl_498;
  wire and_dcpl_504;
  wire and_dcpl_507;
  wire and_dcpl_510;
  wire and_dcpl_515;
  wire and_dcpl_519;
  wire and_dcpl_522;
  wire [8:0] z_out_19;
  wire or_tmp_309;
  wire mux_tmp_448;
  wire mux_tmp_450;
  wire or_tmp_313;
  wire and_tmp;
  wire and_dcpl_524;
  wire and_dcpl_526;
  wire and_dcpl_528;
  wire and_dcpl_530;
  wire and_dcpl_535;
  wire and_dcpl_537;
  wire and_dcpl_541;
  wire and_dcpl_546;
  wire and_dcpl_548;
  wire and_dcpl_549;
  wire and_dcpl_551;
  wire and_dcpl_552;
  wire and_dcpl_555;
  wire and_dcpl_557;
  wire and_dcpl_559;
  wire and_dcpl_561;
  wire [10:0] z_out_20;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [31:0] VEC_LOOP_j_1_sva_1;
  reg [9:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva;
  reg [5:0] COMP_LOOP_k_10_4_sva_5_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire VEC_LOOP_j_1_sva_mx0c0;
  wire [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c0;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c2;
  wire COMP_LOOP_twiddle_f_or_ssc;
  wire COMP_LOOP_twiddle_f_or_9_cse;
  wire COMP_LOOP_twiddle_f_or_6_cse;
  wire COMP_LOOP_twiddle_f_or_10_cse;
  wire VEC_LOOP_or_4_cse;
  wire VEC_LOOP_or_49_cse;
  wire VEC_LOOP_or_11_cse;
  wire VEC_LOOP_or_52_cse;
  wire VEC_LOOP_or_53_cse;
  wire VEC_LOOP_or_54_cse;
  wire VEC_LOOP_or_55_cse;
  wire VEC_LOOP_or_56_cse;
  wire VEC_LOOP_or_57_cse;
  wire mux_241_cse;
  wire and_302_cse;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire mux_tmp;
  wire not_tmp;
  wire [7:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt;
  reg [1:0] VEC_LOOP_acc_13_psp_sva_7_6;
  reg [5:0] VEC_LOOP_acc_13_psp_sva_5_0;
  reg [3:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva_7_4;
  reg [3:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0;
  wire and_621_cse;
  wire or_415_cse;
  wire nor_159_cse;
  wire COMP_LOOP_twiddle_f_nor_1_itm;
  wire COMP_LOOP_twiddle_f_or_itm;
  wire COMP_LOOP_twiddle_f_nor_2_itm;
  wire COMP_LOOP_twiddle_f_or_16_itm;
  wire VEC_LOOP_or_61_itm;
  wire VEC_LOOP_or_68_itm;
  wire VEC_LOOP_or_63_itm;
  wire VEC_LOOP_or_71_itm;
  wire VEC_LOOP_or_75_itm;
  wire and_361_cse;
  wire [8:0] z_out_1_8_0;
  wire [17:0] nl_z_out_1_8_0;
  wire [12:0] z_out_5_22_10;
  wire [9:0] acc_4_cse_10_1;
  wire [10:0] nl_acc_4_cse_10_1;
  wire VEC_LOOP_or_85_cse;

  wire[0:0] mux_132_nl;
  wire[0:0] mux_131_nl;
  wire[0:0] mux_130_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] or_137_nl;
  wire[0:0] or_136_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] or_128_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] nor_57_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] mux_141_nl;
  wire[0:0] mux_139_nl;
  wire[0:0] mux_210_nl;
  wire[0:0] mux_209_nl;
  wire[0:0] or_215_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] nor_49_nl;
  wire[0:0] mux_207_nl;
  wire[0:0] or_212_nl;
  wire[0:0] mux_206_nl;
  wire[0:0] mux_205_nl;
  wire[0:0] mux_204_nl;
  wire[0:0] nand_23_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_14_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] and_180_nl;
  wire[0:0] nor_48_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_29_nl;
  wire[0:0] mux_219_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] nor_45_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] or_221_nl;
  wire[0:0] or_219_nl;
  wire[0:0] or_218_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_41_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[5:0] COMP_LOOP_1_twiddle_f_mul_nl;
  wire[11:0] nl_COMP_LOOP_1_twiddle_f_mul_nl;
  wire[0:0] mux_224_nl;
  wire[0:0] mux_223_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] or_230_nl;
  wire[0:0] or_229_nl;
  wire[0:0] or_228_nl;
  wire[0:0] mux_236_nl;
  wire[0:0] nand_8_nl;
  wire[0:0] mux_234_nl;
  wire[0:0] mux_231_nl;
  wire[0:0] mux_230_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] mux_247_nl;
  wire[0:0] or_249_nl;
  wire[0:0] mux_246_nl;
  wire[0:0] or_248_nl;
  wire[0:0] mux_245_nl;
  wire[0:0] or_247_nl;
  wire[0:0] mux_244_nl;
  wire[0:0] nand_20_nl;
  wire[0:0] mux_262_nl;
  wire[0:0] mux_261_nl;
  wire[0:0] mux_260_nl;
  wire[0:0] mux_259_nl;
  wire[0:0] or_260_nl;
  wire[0:0] mux_258_nl;
  wire[0:0] mux_257_nl;
  wire[0:0] mux_256_nl;
  wire[0:0] nand_18_nl;
  wire[0:0] mux_278_nl;
  wire[0:0] mux_277_nl;
  wire[0:0] mux_276_nl;
  wire[0:0] or_277_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_462_nl;
  wire[0:0] mux_461_nl;
  wire[0:0] mux_460_nl;
  wire[0:0] mux_459_nl;
  wire[0:0] mux_287_nl;
  wire[0:0] mux_286_nl;
  wire[0:0] and_nl;
  wire[0:0] mux_292_nl;
  wire[0:0] mux_291_nl;
  wire[0:0] mux_290_nl;
  wire[0:0] mux_289_nl;
  wire[0:0] nor_42_nl;
  wire[0:0] and_175_nl;
  wire[0:0] mux_288_nl;
  wire[0:0] nor_43_nl;
  wire[0:0] and_143_nl;
  wire[0:0] mux_464_nl;
  wire[0:0] mux_463_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_466_nl;
  wire[0:0] nor_158_nl;
  wire[0:0] mux_465_nl;
  wire[0:0] or_424_nl;
  wire[0:0] or_423_nl;
  wire[31:0] VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_j_not_1_nl;
  wire[0:0] mux_358_nl;
  wire[0:0] mux_357_nl;
  wire[0:0] mux_356_nl;
  wire[0:0] mux_355_nl;
  wire[0:0] mux_354_nl;
  wire[0:0] and_168_nl;
  wire[0:0] mux_353_nl;
  wire[0:0] mux_352_nl;
  wire[0:0] mux_351_nl;
  wire[0:0] mux_350_nl;
  wire[0:0] mux_346_nl;
  wire[0:0] mux_345_nl;
  wire[0:0] mux_344_nl;
  wire[0:0] mux_343_nl;
  wire[0:0] mux_342_nl;
  wire[0:0] mux_335_nl;
  wire[0:0] mux_334_nl;
  wire[0:0] mux_333_nl;
  wire[0:0] or_15_nl;
  wire[0:0] VEC_LOOP_or_50_nl;
  wire[0:0] VEC_LOOP_or_51_nl;
  wire[0:0] mux_469_nl;
  wire[0:0] nor_156_nl;
  wire[0:0] mux_468_nl;
  wire[0:0] mux_467_nl;
  wire[0:0] or_429_nl;
  wire[0:0] or_428_nl;
  wire[0:0] nor_157_nl;
  wire[0:0] mux_471_nl;
  wire[0:0] or_432_nl;
  wire[0:0] mux_470_nl;
  wire[0:0] nand_30_nl;
  wire[0:0] mux_390_nl;
  wire[0:0] mux_389_nl;
  wire[0:0] mux_388_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_not_nl;
  wire[0:0] mux_437_nl;
  wire[0:0] mux_436_nl;
  wire[0:0] mux_435_nl;
  wire[0:0] mux_434_nl;
  wire[0:0] or_383_nl;
  wire[0:0] mux_433_nl;
  wire[0:0] or_382_nl;
  wire[0:0] mux_432_nl;
  wire[0:0] or_381_nl;
  wire[0:0] mux_104_nl;
  wire[0:0] or_49_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] nor_58_nl;
  wire[0:0] or_141_nl;
  wire[0:0] or_368_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] mux_156_nl;
  wire[0:0] mux_160_nl;
  wire[0:0] mux_159_nl;
  wire[0:0] mux_158_nl;
  wire[0:0] mux_157_nl;
  wire[0:0] mux_154_nl;
  wire[0:0] or_157_nl;
  wire[0:0] mux_163_nl;
  wire[0:0] mux_162_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] or_162_nl;
  wire[0:0] or_161_nl;
  wire[0:0] mux_164_nl;
  wire[0:0] nand_24_nl;
  wire[0:0] or_395_nl;
  wire[0:0] mux_165_nl;
  wire[0:0] nor_161_nl;
  wire[0:0] nor_162_nl;
  wire[0:0] mux_180_nl;
  wire[0:0] or_185_nl;
  wire[0:0] nor_50_nl;
  wire[0:0] nand_6_nl;
  wire[0:0] mux_202_nl;
  wire[0:0] or_207_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] nor_46_nl;
  wire[0:0] nor_47_nl;
  wire[0:0] and_105_nl;
  wire[0:0] or_244_nl;
  wire[0:0] or_242_nl;
  wire[0:0] mux_253_nl;
  wire[0:0] mux_252_nl;
  wire[0:0] mux_250_nl;
  wire[0:0] or_251_nl;
  wire[0:0] or_262_nl;
  wire[0:0] mux_279_nl;
  wire[0:0] mux_nl;
  wire[0:0] mux_1_nl;
  wire[0:0] or_312_nl;
  wire[0:0] mux_10_nl;
  wire[0:0] or_333_nl;
  wire[0:0] mux_387_nl;
  wire[0:0] mux_386_nl;
  wire[0:0] mux_383_nl;
  wire[0:0] mux_392_nl;
  wire[0:0] mux_391_nl;
  wire[0:0] or_306_nl;
  wire[0:0] or_307_nl;
  wire[0:0] mux_429_nl;
  wire[0:0] mux_428_nl;
  wire[0:0] or_375_nl;
  wire[0:0] or_374_nl;
  wire[0:0] or_379_nl;
  wire[0:0] mux_400_nl;
  wire[0:0] mux_399_nl;
  wire[0:0] mux_398_nl;
  wire[0:0] mux_397_nl;
  wire[0:0] mux_396_nl;
  wire[0:0] mux_395_nl;
  wire[0:0] nand_nl;
  wire[0:0] mux_409_nl;
  wire[0:0] mux_408_nl;
  wire[0:0] mux_407_nl;
  wire[0:0] or_359_nl;
  wire[6:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_82_nl;
  wire[0:0] mux_179_nl;
  wire[0:0] nor_51_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_77_nl;
  wire[0:0] mux_170_nl;
  wire[0:0] mux_169_nl;
  wire[0:0] nor_52_nl;
  wire[0:0] mux_168_nl;
  wire[0:0] mux_167_nl;
  wire[0:0] nor_54_nl;
  wire[5:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_25_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] nor_85_nl;
  wire[0:0] mux_178_nl;
  wire[0:0] mux_177_nl;
  wire[0:0] mux_176_nl;
  wire[0:0] or_180_nl;
  wire[0:0] mux_175_nl;
  wire[0:0] mux_174_nl;
  wire[0:0] mux_173_nl;
  wire[0:0] mux_172_nl;
  wire[0:0] or_177_nl;
  wire[0:0] mux_171_nl;
  wire[0:0] or_172_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] nor_84_nl;
  wire[0:0] mux_188_nl;
  wire[0:0] mux_187_nl;
  wire[0:0] mux_186_nl;
  wire[0:0] mux_185_nl;
  wire[0:0] or_193_nl;
  wire[0:0] mux_184_nl;
  wire[0:0] or_192_nl;
  wire[0:0] mux_183_nl;
  wire[0:0] mux_182_nl;
  wire[0:0] or_187_nl;
  wire[0:0] mux_181_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] nor_83_nl;
  wire[0:0] mux_200_nl;
  wire[0:0] mux_199_nl;
  wire[0:0] mux_198_nl;
  wire[0:0] mux_197_nl;
  wire[0:0] or_205_nl;
  wire[0:0] nand_5_nl;
  wire[0:0] mux_196_nl;
  wire[0:0] mux_195_nl;
  wire[0:0] mux_194_nl;
  wire[0:0] mux_193_nl;
  wire[0:0] mux_191_nl;
  wire[0:0] or_199_nl;
  wire[0:0] mux_190_nl;
  wire[0:0] or_412_nl;
  wire[0:0] or_397_nl;
  wire[0:0] mux_446_nl;
  wire[0:0] mux_445_nl;
  wire[0:0] or_403_nl;
  wire[0:0] mux_444_nl;
  wire[0:0] mux_443_nl;
  wire[0:0] nor_102_nl;
  wire[0:0] mux_442_nl;
  wire[0:0] or_401_nl;
  wire[0:0] mux_441_nl;
  wire[0:0] or_416_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_14_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_147_nl;
  wire[7:0] COMP_LOOP_twiddle_f_mux1h_148_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_15_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_16_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_5_nl;
  wire[3:0] COMP_LOOP_twiddle_f_mux1h_149_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_28_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_29_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_4_nl;
  wire[8:0] COMP_LOOP_twiddle_f_mux_7_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl;
  wire[3:0] COMP_LOOP_twiddle_f_mux_8_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl;
  wire[3:0] STAGE_LOOP_mux_4_nl;
  wire[23:0] acc_1_nl;
  wire[24:0] nl_acc_1_nl;
  wire[21:0] VEC_LOOP_mux_19_nl;
  wire[0:0] VEC_LOOP_or_77_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl;
  wire[9:0] VEC_LOOP_mux_20_nl;
  wire[9:0] VEC_LOOP_mux_21_nl;
  wire[3:0] VEC_LOOP_or_78_nl;
  wire[3:0] VEC_LOOP_mux1h_34_nl;
  wire[0:0] and_622_nl;
  wire[0:0] and_623_nl;
  wire[0:0] and_624_nl;
  wire[0:0] and_625_nl;
  wire[0:0] and_626_nl;
  wire[0:0] and_627_nl;
  wire[0:0] and_628_nl;
  wire[0:0] and_629_nl;
  wire[0:0] and_630_nl;
  wire[0:0] and_631_nl;
  wire[0:0] and_632_nl;
  wire[0:0] and_633_nl;
  wire[0:0] and_634_nl;
  wire[2:0] VEC_LOOP_or_79_nl;
  wire[2:0] VEC_LOOP_nor_17_nl;
  wire[2:0] VEC_LOOP_mux1h_35_nl;
  wire[0:0] and_635_nl;
  wire[0:0] and_636_nl;
  wire[0:0] and_637_nl;
  wire[0:0] and_638_nl;
  wire[0:0] and_639_nl;
  wire[0:0] and_640_nl;
  wire[0:0] and_641_nl;
  wire[9:0] VEC_LOOP_mux_22_nl;
  wire[0:0] and_642_nl;
  wire[32:0] acc_12_nl;
  wire[33:0] nl_acc_12_nl;
  wire[31:0] VEC_LOOP_mux_23_nl;
  wire[0:0] VEC_LOOP_or_80_nl;
  wire[31:0] VEC_LOOP_mux_24_nl;
  wire[8:0] acc_13_nl;
  wire[9:0] nl_acc_13_nl;
  wire[7:0] VEC_LOOP_mux1h_36_nl;
  wire[0:0] VEC_LOOP_or_81_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_3_nl;
  wire[0:0] VEC_LOOP_and_16_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_7_nl;
  wire[3:0] VEC_LOOP_mux1h_37_nl;
  wire[0:0] VEC_LOOP_or_82_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_11_nl;
  wire[0:0] VEC_LOOP_mux_25_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_12_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_4_nl;
  wire[5:0] VEC_LOOP_VEC_LOOP_mux_8_nl;
  wire[6:0] VEC_LOOP_mux1h_38_nl;
  wire[9:0] acc_15_nl;
  wire[10:0] nl_acc_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_13_nl;
  wire[7:0] VEC_LOOP_mux1h_39_nl;
  wire[0:0] VEC_LOOP_or_83_nl;
  wire[0:0] VEC_LOOP_and_20_nl;
  wire[4:0] VEC_LOOP_mux1h_40_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_14_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[11:0] acc_16_nl;
  wire[12:0] nl_acc_16_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_9_nl;
  wire[0:0] VEC_LOOP_or_84_nl;
  wire[0:0] mux_472_nl;
  wire[0:0] mux_473_nl;
  wire[0:0] mux_474_nl;
  wire[0:0] nand_33_nl;
  wire[0:0] mux_475_nl;
  wire[0:0] mux_476_nl;
  wire[0:0] mux_477_nl;
  wire[0:0] or_435_nl;
  wire[0:0] mux_478_nl;
  wire[0:0] or_436_nl;
  wire[0:0] mux_479_nl;
  wire[5:0] VEC_LOOP_VEC_LOOP_mux_10_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_18_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_19_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_20_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_21_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = z_out_16;
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat = factor1_1_sva + COMP_LOOP_1_mult_cmp_return_rsc_z;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat = p_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_x_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_x_rsc_dat = VEC_LOOP_mult_vec_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat = COMP_LOOP_twiddle_f_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1 = COMP_LOOP_twiddle_help_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_p_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_p_rsc_dat = p_sva;
  wire[0:0] mux_272_nl;
  wire[0:0] mux_271_nl;
  wire[0:0] mux_270_nl;
  wire[0:0] mux_269_nl;
  wire[0:0] or_268_nl;
  wire[0:0] mux_268_nl;
  wire[0:0] or_267_nl;
  wire[0:0] mux_267_nl;
  wire[0:0] or_266_nl;
  wire [0:0] nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat;
  assign or_268_nl = (fsm_output[6]) | (~ mux_tmp_134);
  assign mux_269_nl = MUX_s_1_2_2(or_269_cse, or_268_nl, fsm_output[7]);
  assign mux_270_nl = MUX_s_1_2_2(mux_269_nl, or_tmp_192, fsm_output[5]);
  assign mux_271_nl = MUX_s_1_2_2(mux_tmp_266, mux_270_nl, fsm_output[3]);
  assign or_266_nl = (fsm_output[6]) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign mux_267_nl = MUX_s_1_2_2((~ mux_tmp_135), or_266_nl, fsm_output[7]);
  assign or_267_nl = (fsm_output[5]) | mux_267_nl;
  assign mux_268_nl = MUX_s_1_2_2(or_267_nl, mux_tmp_266, fsm_output[3]);
  assign mux_272_nl = MUX_s_1_2_2(mux_271_nl, mux_268_nl, fsm_output[1]);
  assign nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat = ~(mux_272_nl | (fsm_output[0]));
  wire[0:0] and_263_nl;
  wire [3:0] nl_COMP_LOOP_2_twiddle_f_lshift_rg_s;
  assign and_263_nl = (fsm_output==8'b00000010);
  assign nl_COMP_LOOP_2_twiddle_f_lshift_rg_s = MUX_v_4_2_2(COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0,
      z_out_4, and_263_nl);
  wire[0:0] and_274_nl;
  wire [3:0] nl_COMP_LOOP_9_twiddle_f_lshift_rg_s;
  assign and_274_nl = (fsm_output==8'b00000010);
  assign nl_COMP_LOOP_9_twiddle_f_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva,
      z_out_4, and_274_nl);
  wire[31:0] VEC_LOOP_mux_nl;
  wire [63:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      VEC_LOOP_j_1_sva, and_dcpl_23);
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_nl};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (~ mux_238_cse)};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {nor_86_cse , nor_86_cse};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (~ mux_238_cse)};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_133_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro = ~ mux_239_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2 = ~ mux_263_itm;
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_dcpl_82 , nor_82_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_dcpl_82 , nor_82_rmff};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0
      = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm;
  wire[10:0] COMP_LOOP_2_acc_nl;
  wire[11:0] nl_COMP_LOOP_2_acc_nl;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0;
  assign nl_COMP_LOOP_2_acc_nl = ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:1]))})
      + conv_u2s_10_11({COMP_LOOP_k_10_4_sva_5_0 , 4'b0001}) + 11'b00000000001;
  assign COMP_LOOP_2_acc_nl = nl_COMP_LOOP_2_acc_nl[10:0];
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0 = ~ (readslicef_11_1_10(COMP_LOOP_2_acc_nl));
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (z_out_19[8]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_17[7]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ (z_out_19[8]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_17[6]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (z_out_5_22_10[0]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = z_out_19[4];
  ccs_in_v1 #(.rscid(32'sd14),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  modulo_sub  COMP_LOOP_1_modulo_sub_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_122_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_122_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  mult  COMP_LOOP_1_mult_cmp (
      .x_rsc_dat(nl_COMP_LOOP_1_mult_cmp_x_rsc_dat[31:0]),
      .y_rsc_dat(nl_COMP_LOOP_1_mult_cmp_y_rsc_dat[31:0]),
      .y_rsc_dat_1(nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1[31:0]),
      .p_rsc_dat(nl_COMP_LOOP_1_mult_cmp_p_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_mult_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat[0:0]),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_mult_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd6)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(z_out_4),
      .z(COMP_LOOP_1_twiddle_f_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd9)) COMP_LOOP_3_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0),
      .z(COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_2_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_2_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out_2)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) COMP_LOOP_9_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_9_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out_3)
    );
  inPlaceNTT_DIT_precomp_core_run_rsci inPlaceNTT_DIT_precomp_core_run_rsci_inst
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
  inPlaceNTT_DIT_precomp_core_vec_rsci_1 inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsci_da_d(vec_rsci_da_d_reg),
      .vec_rsci_qa_d(vec_rsci_qa_d),
      .vec_rsci_wea_d(vec_rsci_wea_d_reg),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .vec_rsci_oswt(reg_vec_rsci_oswt_cse),
      .vec_rsci_oswt_1(reg_vec_rsci_oswt_1_cse),
      .vec_rsci_da_d_core(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core[63:0]),
      .vec_rsci_qa_d_mxwt(vec_rsci_qa_d_mxwt),
      .vec_rsci_wea_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct[1:0]),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsci_oswt_pff(nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff[0:0]),
      .vec_rsci_oswt_1_pff(nor_86_cse)
    );
  inPlaceNTT_DIT_precomp_core_wait_dp inPlaceNTT_DIT_precomp_core_wait_dp_inst (
      .ensig_cgo_iro(nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro[0:0]),
      .ensig_cgo_iro_2(nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2[0:0]),
      .core_wen(complete_rsci_wen_comp),
      .ensig_cgo(reg_ensig_cgo_cse),
      .COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en),
      .ensig_cgo_2(reg_ensig_cgo_2_cse),
      .COMP_LOOP_1_mult_cmp_ccs_ccore_en(COMP_LOOP_1_mult_cmp_ccs_ccore_en)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsci_1 inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_rsci_oswt_1(reg_twiddle_rsci_oswt_1_cse),
      .twiddle_rsci_qa_d_mxwt(twiddle_rsci_qa_d_mxwt),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .twiddle_rsci_oswt_1_pff(and_dcpl_82),
      .twiddle_rsci_oswt_pff(nor_82_rmff)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1 inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_h_rsci_oswt_1(reg_twiddle_rsci_oswt_1_cse),
      .twiddle_h_rsci_qa_d_mxwt(twiddle_h_rsci_qa_d_mxwt),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .twiddle_h_rsci_oswt_1_pff(and_dcpl_82),
      .twiddle_h_rsci_oswt_pff(nor_82_rmff)
    );
  inPlaceNTT_DIT_precomp_core_complete_rsci inPlaceNTT_DIT_precomp_core_complete_rsci_inst
      (
      .clk(clk),
      .rst(rst),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld),
      .core_wen(complete_rsci_wen_comp),
      .complete_rsci_oswt(reg_complete_rsci_oswt_cse),
      .complete_rsci_wen_comp(complete_rsci_wen_comp)
    );
  inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj inPlaceNTT_DIT_precomp_core_vec_rsc_triosy_obj_inst
      (
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj inPlaceNTT_DIT_precomp_core_p_rsc_triosy_obj_inst
      (
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .core_wten(core_wten),
      .p_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj inPlaceNTT_DIT_precomp_core_r_rsc_triosy_obj_inst
      (
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .core_wten(core_wten),
      .r_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj inPlaceNTT_DIT_precomp_core_twiddle_rsc_triosy_obj_inst
      (
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj inPlaceNTT_DIT_precomp_core_twiddle_h_rsc_triosy_obj_inst
      (
      .twiddle_h_rsc_triosy_lz(twiddle_h_rsc_triosy_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIT_precomp_core_staller inPlaceNTT_DIT_precomp_core_staller_inst (
      .clk(clk),
      .rst(rst),
      .core_wten(core_wten),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIT_precomp_core_core_fsm inPlaceNTT_DIT_precomp_core_core_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .fsm_output(fsm_output),
      .main_C_0_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0[0:0]),
      .COMP_LOOP_1_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_2_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0[0:0]),
      .COMP_LOOP_2_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_3_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0[0:0]),
      .COMP_LOOP_3_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_4_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0[0:0]),
      .COMP_LOOP_4_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_5_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0[0:0]),
      .COMP_LOOP_5_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_6_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_6_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_7_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0[0:0]),
      .COMP_LOOP_7_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_8_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_9_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0[0:0]),
      .COMP_LOOP_9_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_10_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0[0:0]),
      .COMP_LOOP_10_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_11_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0[0:0]),
      .COMP_LOOP_11_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_12_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0[0:0]),
      .COMP_LOOP_12_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_13_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0[0:0]),
      .COMP_LOOP_13_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_14_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0[0:0]),
      .COMP_LOOP_14_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_15_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0[0:0]),
      .COMP_LOOP_15_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_16_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0[0:0]),
      .COMP_LOOP_16_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_17_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign mux_128_cse = MUX_s_1_2_2(or_197_cse, or_13_cse, fsm_output[2]);
  assign or_137_nl = (fsm_output[0]) | (~ (fsm_output[6])) | (fsm_output[7]);
  assign mux_129_nl = MUX_s_1_2_2(or_137_nl, or_85_cse, fsm_output[2]);
  assign mux_130_nl = MUX_s_1_2_2(mux_129_nl, mux_tmp_115, fsm_output[4]);
  assign or_136_nl = (fsm_output[4]) | mux_128_cse;
  assign mux_131_nl = MUX_s_1_2_2(mux_130_nl, or_136_nl, fsm_output[5]);
  assign mux_126_nl = MUX_s_1_2_2(or_365_cse, or_88_cse, fsm_output[4]);
  assign mux_124_nl = MUX_s_1_2_2(or_13_cse, or_tmp_58, fsm_output[2]);
  assign mux_125_nl = MUX_s_1_2_2(mux_tmp_116, mux_124_nl, fsm_output[4]);
  assign mux_127_nl = MUX_s_1_2_2(mux_126_nl, mux_125_nl, fsm_output[5]);
  assign mux_132_nl = MUX_s_1_2_2(mux_131_nl, mux_127_nl, fsm_output[3]);
  assign mux_120_nl = MUX_s_1_2_2(or_197_cse, mux_tmp_114, fsm_output[2]);
  assign mux_121_nl = MUX_s_1_2_2(mux_120_nl, or_365_cse, fsm_output[4]);
  assign mux_119_nl = MUX_s_1_2_2(or_88_cse, mux_tmp_116, fsm_output[4]);
  assign mux_122_nl = MUX_s_1_2_2(mux_121_nl, mux_119_nl, fsm_output[5]);
  assign mux_117_nl = MUX_s_1_2_2(mux_tmp_116, mux_tmp_115, fsm_output[4]);
  assign or_128_nl = (fsm_output[4]) | (~ (fsm_output[2])) | (~ (fsm_output[6]))
      | (fsm_output[7]);
  assign mux_118_nl = MUX_s_1_2_2(mux_117_nl, or_128_nl, fsm_output[5]);
  assign mux_123_nl = MUX_s_1_2_2(mux_122_nl, mux_118_nl, fsm_output[3]);
  assign mux_133_itm = MUX_s_1_2_2(mux_132_nl, mux_123_nl, fsm_output[1]);
  assign nor_57_nl = ~((fsm_output[2]) | (~ (fsm_output[4])));
  assign mux_137_nl = MUX_s_1_2_2(mux_tmp_134, nor_57_nl, fsm_output[6]);
  assign nand_1_nl = ~((fsm_output[5]) & mux_137_nl);
  assign mux_138_cse = MUX_s_1_2_2(nand_1_nl, or_142_cse, fsm_output[7]);
  assign mux_140_nl = MUX_s_1_2_2(nor_53_cse, mux_tmp_135, fsm_output[5]);
  assign or_146_cse = (fsm_output[7]) | (~ mux_140_nl);
  assign mux_141_nl = MUX_s_1_2_2(mux_tmp_136, or_146_cse, fsm_output[3]);
  assign mux_139_nl = MUX_s_1_2_2(mux_138_cse, mux_tmp_136, fsm_output[3]);
  assign mux_142_nl = MUX_s_1_2_2(mux_141_nl, mux_139_nl, fsm_output[1]);
  assign nor_86_cse = ~(mux_142_nl | (fsm_output[0]));
  assign nor_53_cse = ~((fsm_output[2]) | (~ (fsm_output[4])) | (fsm_output[6]));
  assign or_176_cse = (fsm_output[7]) | (~ (fsm_output[4]));
  assign or_175_cse = (~ (fsm_output[6])) | (fsm_output[7]) | (fsm_output[4]);
  assign or_183_cse = (fsm_output[7:4]!=4'b0101);
  assign or_203_cse = (fsm_output[7:6]!=2'b00);
  assign or_197_cse = (fsm_output[7:6]!=2'b10);
  assign nor_49_nl = ~((~ (fsm_output[2])) | COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm
      | (fsm_output[4]));
  assign mux_208_nl = MUX_s_1_2_2(nor_49_nl, mux_tmp_201, fsm_output[6]);
  assign or_215_nl = (fsm_output[7]) | (fsm_output[5]) | (~ mux_208_nl);
  assign mux_209_nl = MUX_s_1_2_2(mux_tmp_203, or_215_nl, fsm_output[3]);
  assign mux_204_nl = MUX_s_1_2_2((fsm_output[4]), (~ nor_tmp_18), fsm_output[2]);
  assign mux_205_nl = MUX_s_1_2_2(mux_204_nl, or_tmp_137, fsm_output[6]);
  assign nand_23_nl = ~((fsm_output[6]) & (fsm_output[2]) & (~ (fsm_output[4])) &
      (VEC_LOOP_j_10_10_0_sva_1[10]));
  assign mux_206_nl = MUX_s_1_2_2(mux_205_nl, nand_23_nl, fsm_output[5]);
  assign or_212_nl = (fsm_output[7]) | mux_206_nl;
  assign mux_207_nl = MUX_s_1_2_2(or_212_nl, mux_tmp_203, fsm_output[3]);
  assign mux_210_nl = MUX_s_1_2_2(mux_209_nl, mux_207_nl, fsm_output[1]);
  assign nor_82_rmff = ~(mux_210_nl | (fsm_output[0]));
  assign COMP_LOOP_twiddle_f_or_9_cse = and_dcpl_83 | (and_dcpl_44 & and_dcpl_12)
      | (and_dcpl_50 & and_dcpl_26);
  assign COMP_LOOP_twiddle_f_or_6_cse = (and_dcpl_27 & and_dcpl_13 & and_dcpl_33)
      | (and_dcpl_35 & and_dcpl_19) | (and_dcpl_44 & and_dcpl_19) | (and_dcpl_52
      & and_dcpl_33) | (and_dcpl_46 & and_dcpl_37 & and_dcpl_33) | (and_dcpl_57 &
      and_dcpl_19) | (and_dcpl_15 & and_dcpl_67);
  assign COMP_LOOP_twiddle_f_or_10_cse = (and_dcpl_35 & and_dcpl_12) | (and_dcpl_57
      & and_dcpl_12);
  assign COMP_LOOP_twiddle_f_mux1h_14_nl = MUX1HOT_s_1_4_2((z_out[1]), (z_out[2]),
      (z_out[0]), (z_out_1_8_0[1]), {COMP_LOOP_twiddle_f_or_9_cse , COMP_LOOP_twiddle_f_or_6_cse
      , COMP_LOOP_twiddle_f_or_10_cse , and_dcpl_99});
  assign and_180_nl = (fsm_output[3]) & (fsm_output[6]);
  assign nor_48_nl = ~((fsm_output[3]) | (fsm_output[6]));
  assign mux_211_nl = MUX_s_1_2_2(and_180_nl, nor_48_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_14_rmff = COMP_LOOP_twiddle_f_mux1h_14_nl & (~(mux_211_nl
      & (~ (fsm_output[4])) & and_dcpl_20 & and_dcpl_69));
  assign COMP_LOOP_twiddle_f_mux1h_29_nl = MUX1HOT_s_1_5_2((z_out[2]), (z_out[3]),
      (z_out[1]), (z_out_1_8_0[0]), (z_out_1_8_0[2]), {COMP_LOOP_twiddle_f_or_9_cse
      , COMP_LOOP_twiddle_f_or_6_cse , COMP_LOOP_twiddle_f_or_10_cse , and_dcpl_101
      , and_dcpl_99});
  assign nor_45_nl = ~((fsm_output[5:4]!=2'b10) | (~ mux_tmp_212));
  assign mux_217_nl = MUX_s_1_2_2(nor_45_nl, mux_tmp_215, fsm_output[6]);
  assign or_221_nl = (~ (fsm_output[4])) | (fsm_output[1]) | (~ (fsm_output[3]));
  assign or_219_nl = (fsm_output[4]) | (~ (fsm_output[1])) | (fsm_output[3]);
  assign mux_213_nl = MUX_s_1_2_2(or_221_nl, or_219_nl, fsm_output[5]);
  assign mux_216_nl = MUX_s_1_2_2((~ mux_tmp_215), mux_213_nl, fsm_output[6]);
  assign mux_218_nl = MUX_s_1_2_2((~ mux_217_nl), mux_216_nl, fsm_output[2]);
  assign or_218_nl = (~ (fsm_output[2])) | (fsm_output[6]) | (fsm_output[5]) | (fsm_output[4])
      | (~ mux_tmp_212);
  assign mux_219_nl = MUX_s_1_2_2(mux_218_nl, or_218_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_and_rmff = COMP_LOOP_twiddle_f_mux1h_29_nl & (~(mux_219_nl
      | (fsm_output[0])));
  assign COMP_LOOP_twiddle_f_mux1h_41_nl = MUX1HOT_s_1_3_2((z_out[0]), (z_out[1]),
      (z_out_1_8_0[0]), {COMP_LOOP_twiddle_f_or_9_cse , COMP_LOOP_twiddle_f_or_6_cse
      , and_dcpl_99});
  assign mux_220_nl = MUX_s_1_2_2((~ and_tmp_3), or_tmp_93, fsm_output[3]);
  assign mux_221_nl = MUX_s_1_2_2(mux_220_nl, or_tmp_155, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_41_rmff = COMP_LOOP_twiddle_f_mux1h_41_nl & (mux_221_nl
      | (fsm_output[2]) | (fsm_output[7]) | (fsm_output[0]));
  assign nl_COMP_LOOP_1_twiddle_f_mul_nl = COMP_LOOP_1_twiddle_f_lshift_itm * COMP_LOOP_k_10_4_sva_5_0;
  assign COMP_LOOP_1_twiddle_f_mul_nl = nl_COMP_LOOP_1_twiddle_f_mul_nl[5:0];
  assign COMP_LOOP_twiddle_f_mux1h_56_rmff = MUX1HOT_v_6_6_2(COMP_LOOP_1_twiddle_f_mul_nl,
      (z_out[8:3]), (z_out[9:4]), (z_out[7:2]), (z_out_1_8_0[6:1]), (z_out_1_8_0[8:3]),
      {and_dcpl_82 , COMP_LOOP_twiddle_f_or_9_cse , COMP_LOOP_twiddle_f_or_6_cse
      , COMP_LOOP_twiddle_f_or_10_cse , and_dcpl_101 , and_dcpl_99});
  assign or_230_nl = (fsm_output[5]) | (~ mux_tmp_166);
  assign mux_222_nl = MUX_s_1_2_2(nand_tmp_4, or_230_nl, fsm_output[3]);
  assign or_229_nl = (fsm_output[6:2]!=5'b00001);
  assign mux_223_nl = MUX_s_1_2_2(mux_222_nl, or_229_nl, fsm_output[7]);
  assign or_228_nl = (fsm_output[7:2]!=6'b000000);
  assign mux_224_nl = MUX_s_1_2_2(mux_223_nl, or_228_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_64_rmff = (z_out[0]) & (mux_224_nl | (fsm_output[0]));
  assign nl_COMP_LOOP_2_twiddle_f_mul_rmff = z_out_2 * ({COMP_LOOP_k_10_4_sva_5_0
      , 4'b0001});
  assign COMP_LOOP_2_twiddle_f_mul_rmff = nl_COMP_LOOP_2_twiddle_f_mul_rmff[9:0];
  assign mux_235_cse = MUX_s_1_2_2(mux_tmp_146, nand_2_cse, fsm_output[4]);
  assign nand_8_nl = ~((fsm_output[5]) & (~ mux_128_cse));
  assign mux_236_nl = MUX_s_1_2_2(nand_8_nl, or_tmp_78, fsm_output[4]);
  assign mux_237_cse = MUX_s_1_2_2(mux_236_nl, mux_235_cse, fsm_output[3]);
  assign mux_238_cse = MUX_s_1_2_2(mux_237_cse, mux_149_cse, fsm_output[1]);
  assign mux_230_nl = MUX_s_1_2_2(nand_2_cse, mux_144_cse, fsm_output[4]);
  assign mux_231_nl = MUX_s_1_2_2(mux_230_nl, mux_148_cse, fsm_output[3]);
  assign mux_234_nl = MUX_s_1_2_2(mux_149_cse, mux_231_nl, fsm_output[1]);
  assign mux_239_itm = MUX_s_1_2_2(mux_238_cse, mux_234_nl, fsm_output[0]);
  assign or_248_nl = (fsm_output[5]) | (~ mux_tmp_134);
  assign mux_246_nl = MUX_s_1_2_2(or_248_nl, mux_tmp_243, fsm_output[6]);
  assign or_249_nl = (fsm_output[7]) | mux_246_nl;
  assign mux_247_nl = MUX_s_1_2_2(mux_tmp_242, or_249_nl, fsm_output[3]);
  assign nand_20_nl = ~((fsm_output[5]) & mux_tmp_134);
  assign mux_244_nl = MUX_s_1_2_2(mux_tmp_243, nand_20_nl, fsm_output[6]);
  assign or_247_nl = (fsm_output[7]) | mux_244_nl;
  assign mux_245_nl = MUX_s_1_2_2(or_247_nl, mux_tmp_242, fsm_output[3]);
  assign mux_248_nl = MUX_s_1_2_2(mux_247_nl, mux_245_nl, fsm_output[1]);
  assign and_122_rmff = (~ mux_248_nl) & (fsm_output[0]);
  assign or_259_cse = (fsm_output[6:5]!=2'b00) | (~ mux_tmp_134);
  assign or_260_nl = (fsm_output[0]) | (~ mux_tmp_134);
  assign mux_259_nl = MUX_s_1_2_2(or_260_nl, or_246_cse, fsm_output[5]);
  assign mux_260_nl = MUX_s_1_2_2(mux_259_nl, mux_tmp_255, fsm_output[6]);
  assign mux_261_nl = MUX_s_1_2_2(mux_260_nl, or_259_cse, fsm_output[7]);
  assign mux_262_nl = MUX_s_1_2_2(mux_tmp_254, mux_261_nl, fsm_output[3]);
  assign nand_18_nl = ~((~((fsm_output[5]) & (fsm_output[0]))) & mux_tmp_134);
  assign mux_256_nl = MUX_s_1_2_2(mux_tmp_255, nand_18_nl, fsm_output[6]);
  assign mux_257_nl = MUX_s_1_2_2(mux_256_nl, or_256_cse, fsm_output[7]);
  assign mux_258_nl = MUX_s_1_2_2(mux_257_nl, mux_tmp_254, fsm_output[3]);
  assign mux_263_itm = MUX_s_1_2_2(mux_262_nl, mux_258_nl, fsm_output[1]);
  assign or_269_cse = (~ (fsm_output[6])) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign or_119_cse = (fsm_output[1:0]!=2'b00);
  assign or_415_cse = (fsm_output[6:5]!=2'b00);
  assign and_176_cse = (fsm_output[1:0]==2'b11);
  assign and_143_nl = and_dcpl_27 & (fsm_output[2]) & (~ (fsm_output[5])) & (~ (fsm_output[3]))
      & (~ (fsm_output[7])) & (fsm_output[1]) & (~ (fsm_output[0])) & (VEC_LOOP_j_10_10_0_sva_1[10]);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt = MUX_v_8_2_2(({4'b0000
      , z_out_4}), (z_out_2[7:0]), and_143_nl);
  assign and_621_cse = ((fsm_output[3:0]!=4'b0000)) & (fsm_output[4]) & (fsm_output[6]);
  assign nor_159_cse = ~((fsm_output[4]) | (fsm_output[6]));
  assign and_168_nl = ((fsm_output[1]) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]))) & (fsm_output[5]);
  assign mux_354_nl = MUX_s_1_2_2(mux_tmp_3, nor_tmp, and_168_nl);
  assign mux_353_nl = MUX_s_1_2_2(mux_tmp_348, mux_tmp_339, fsm_output[1]);
  assign mux_355_nl = MUX_s_1_2_2(mux_354_nl, mux_353_nl, fsm_output[4]);
  assign mux_352_nl = MUX_s_1_2_2(mux_tmp_340, mux_tmp_349, fsm_output[4]);
  assign mux_356_nl = MUX_s_1_2_2(mux_355_nl, mux_352_nl, fsm_output[3]);
  assign mux_345_nl = MUX_s_1_2_2(mux_tmp_5, mux_tmp_4, VEC_LOOP_j_10_10_0_sva_1[10]);
  assign mux_346_nl = MUX_s_1_2_2(mux_tmp_337, mux_345_nl, fsm_output[1]);
  assign mux_350_nl = MUX_s_1_2_2(mux_tmp_349, mux_346_nl, fsm_output[4]);
  assign mux_342_nl = MUX_s_1_2_2(mux_tmp_4, mux_tmp_5, COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm);
  assign mux_343_nl = MUX_s_1_2_2(mux_342_nl, mux_tmp_341, fsm_output[1]);
  assign mux_344_nl = MUX_s_1_2_2(mux_343_nl, mux_tmp_340, fsm_output[4]);
  assign mux_351_nl = MUX_s_1_2_2(mux_350_nl, mux_344_nl, fsm_output[3]);
  assign mux_357_nl = MUX_s_1_2_2(mux_356_nl, mux_351_nl, fsm_output[2]);
  assign mux_333_nl = MUX_s_1_2_2(mux_tmp_3, nor_tmp, fsm_output[5]);
  assign mux_334_nl = MUX_s_1_2_2(mux_333_nl, mux_tmp_4, fsm_output[1]);
  assign or_15_nl = (fsm_output[4:2]!=3'b000);
  assign mux_335_nl = MUX_s_1_2_2(mux_334_nl, mux_tmp_5, or_15_nl);
  assign mux_358_nl = MUX_s_1_2_2(mux_357_nl, mux_335_nl, fsm_output[0]);
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & mux_358_nl;
  assign VEC_LOOP_or_52_cse = and_dcpl_36 | and_dcpl_58;
  assign VEC_LOOP_or_53_cse = and_dcpl_39 | and_dcpl_49;
  assign VEC_LOOP_or_54_cse = and_dcpl_45 | and_dcpl_48;
  assign VEC_LOOP_or_55_cse = and_dcpl_51 | and_dcpl_56;
  assign VEC_LOOP_or_56_cse = and_dcpl_54 | and_dcpl_65;
  assign VEC_LOOP_or_57_cse = and_dcpl_60 | and_dcpl_63;
  assign VEC_LOOP_or_49_cse = and_dcpl_39 | and_dcpl_60;
  assign or_365_cse = (~ (fsm_output[2])) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign VEC_LOOP_or_4_cse = and_dcpl_29 | and_dcpl_48 | and_dcpl_56 | and_dcpl_65;
  assign or_256_cse = (fsm_output[6]) | (fsm_output[5]) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign nor_tmp = (fsm_output[7:6]==2'b11);
  assign or_13_cse = (fsm_output[7:6]!=2'b01);
  assign mux_tmp_3 = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[7]);
  assign mux_tmp_4 = MUX_s_1_2_2(mux_tmp_3, (fsm_output[7]), fsm_output[5]);
  assign mux_tmp_5 = MUX_s_1_2_2(nor_tmp, (fsm_output[7]), fsm_output[5]);
  assign or_tmp_5 = (fsm_output[6:4]!=3'b000);
  assign or_tmp_6 = (fsm_output[6]) | (~ (fsm_output[4]));
  assign nor_tmp_1 = (fsm_output[6]) & (fsm_output[4]);
  assign or_85_cse = (fsm_output[0]) | (fsm_output[7]) | (fsm_output[6]);
  assign or_88_cse = (fsm_output[2]) | (fsm_output[0]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_tmp_70 = MUX_s_1_2_2(or_13_cse, or_203_cse, fsm_output[2]);
  assign or_49_nl = (fsm_output[4]) | (fsm_output[6]) | (fsm_output[2]);
  assign mux_104_nl = MUX_s_1_2_2((fsm_output[6]), or_49_nl, fsm_output[5]);
  assign mux_tmp_105 = MUX_s_1_2_2(mux_104_nl, or_415_cse, fsm_output[3]);
  assign and_tmp_2 = (fsm_output[7]) & mux_tmp_105;
  assign or_dcpl_66 = (fsm_output[3]) | (fsm_output[7]) | or_119_cse;
  assign or_dcpl_69 = (fsm_output[6]) | (fsm_output[4]) | (fsm_output[2]) | (fsm_output[5]);
  assign or_tmp_58 = ((fsm_output[0]) & (fsm_output[6])) | (fsm_output[7]);
  assign mux_113_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign mux_tmp_114 = MUX_s_1_2_2(mux_113_nl, or_13_cse, fsm_output[0]);
  assign mux_tmp_115 = MUX_s_1_2_2(mux_tmp_114, or_tmp_58, fsm_output[2]);
  assign mux_tmp_116 = MUX_s_1_2_2(or_tmp_58, or_85_cse, fsm_output[2]);
  assign mux_tmp_134 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[2]);
  assign nor_58_nl = ~((~ (fsm_output[2])) | (fsm_output[4]));
  assign mux_tmp_135 = MUX_s_1_2_2(nor_58_nl, mux_tmp_134, fsm_output[6]);
  assign or_141_nl = (fsm_output[5]) | (~ mux_tmp_135);
  assign mux_tmp_136 = MUX_s_1_2_2(or_141_nl, or_256_cse, fsm_output[7]);
  assign or_142_cse = (fsm_output[5]) | (fsm_output[6]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign and_dcpl_10 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_11 = ~((fsm_output[3]) | (fsm_output[7]));
  assign and_dcpl_12 = and_dcpl_11 & and_dcpl_10;
  assign and_dcpl_13 = (fsm_output[2]) & (~ (fsm_output[5]));
  assign and_dcpl_15 = nor_159_cse & and_dcpl_13;
  assign and_dcpl_16 = and_dcpl_15 & and_dcpl_12;
  assign and_dcpl_17 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_18 = (fsm_output[3]) & (~ (fsm_output[7]));
  assign and_dcpl_19 = and_dcpl_18 & and_dcpl_17;
  assign and_dcpl_20 = ~((fsm_output[2]) | (fsm_output[5]));
  assign and_dcpl_21 = nor_159_cse & and_dcpl_20;
  assign or_tmp_78 = (fsm_output[5]) | mux_tmp_70;
  assign or_tmp_81 = (fsm_output[2]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_tmp_146 = MUX_s_1_2_2(or_365_cse, or_tmp_81, fsm_output[5]);
  assign or_368_nl = (~ (fsm_output[2])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_144_cse = MUX_s_1_2_2(or_tmp_81, or_368_nl, fsm_output[5]);
  assign or_155_cse = (fsm_output[5]) | mux_128_cse;
  assign mux_148_cse = MUX_s_1_2_2(or_155_cse, mux_tmp_146, fsm_output[4]);
  assign nand_2_cse = ~((fsm_output[5]) & (~ mux_tmp_70));
  assign mux_145_nl = MUX_s_1_2_2(mux_144_cse, or_tmp_78, fsm_output[4]);
  assign mux_149_cse = MUX_s_1_2_2(mux_148_cse, mux_145_nl, fsm_output[3]);
  assign and_dcpl_23 = (~ mux_238_cse) & (fsm_output[0]);
  assign and_dcpl_24 = and_dcpl_15 & and_dcpl_19;
  assign mux_tmp_155 = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[4]);
  assign mux_156_nl = MUX_s_1_2_2(mux_tmp_155, (~ or_tmp_6), fsm_output[2]);
  assign nand_tmp_4 = ~((fsm_output[5]) & mux_156_nl);
  assign mux_157_nl = MUX_s_1_2_2((~ nor_tmp_1), or_tmp_6, fsm_output[2]);
  assign mux_158_nl = MUX_s_1_2_2(mux_157_nl, or_269_cse, fsm_output[5]);
  assign mux_159_nl = MUX_s_1_2_2(mux_158_nl, nand_tmp_4, fsm_output[3]);
  assign or_157_nl = (~ (fsm_output[5])) | (fsm_output[2]) | (fsm_output[4]) | (fsm_output[6]);
  assign mux_154_nl = MUX_s_1_2_2(or_157_nl, or_142_cse, fsm_output[3]);
  assign mux_160_nl = MUX_s_1_2_2(mux_159_nl, mux_154_nl, fsm_output[7]);
  assign and_dcpl_25 = (~ mux_160_nl) & and_dcpl_10;
  assign and_dcpl_26 = and_dcpl_18 & and_dcpl_10;
  assign and_dcpl_27 = (~ (fsm_output[6])) & (fsm_output[4]);
  assign and_dcpl_28 = and_dcpl_27 & and_dcpl_20;
  assign and_dcpl_29 = and_dcpl_28 & and_dcpl_26;
  assign or_tmp_93 = (fsm_output[6:4]!=3'b100);
  assign or_162_nl = (fsm_output[4]) | (~ (fsm_output[6]));
  assign mux_161_nl = MUX_s_1_2_2(or_tmp_6, or_162_nl, fsm_output[5]);
  assign mux_162_nl = MUX_s_1_2_2(or_tmp_93, mux_161_nl, fsm_output[3]);
  assign or_161_nl = (fsm_output[6:3]!=4'b0010);
  assign mux_163_nl = MUX_s_1_2_2(mux_162_nl, or_161_nl, fsm_output[7]);
  assign and_dcpl_32 = (~ mux_163_nl) & (fsm_output[2:0]==3'b110);
  assign and_dcpl_33 = and_dcpl_11 & and_dcpl_17;
  assign and_dcpl_34 = (~ (fsm_output[2])) & (fsm_output[5]);
  assign and_dcpl_35 = nor_159_cse & and_dcpl_34;
  assign and_dcpl_36 = and_dcpl_35 & and_dcpl_33;
  assign and_dcpl_37 = (fsm_output[2]) & (fsm_output[5]);
  assign and_dcpl_38 = nor_159_cse & and_dcpl_37;
  assign and_dcpl_39 = and_dcpl_38 & and_dcpl_26;
  assign nand_24_nl = ~((fsm_output[5:4]==2'b11));
  assign or_395_nl = (fsm_output[5:4]!=2'b00);
  assign mux_164_nl = MUX_s_1_2_2(nand_24_nl, or_395_nl, fsm_output[7]);
  assign and_dcpl_43 = ~(mux_164_nl | (fsm_output[6]) | (fsm_output[2]) | (fsm_output[3])
      | (~ and_dcpl_17));
  assign and_dcpl_44 = and_dcpl_27 & and_dcpl_37;
  assign and_dcpl_45 = and_dcpl_44 & and_dcpl_33;
  assign and_dcpl_46 = (fsm_output[6]) & (~ (fsm_output[4]));
  assign and_dcpl_47 = and_dcpl_46 & and_dcpl_20;
  assign and_dcpl_48 = and_dcpl_47 & and_dcpl_12;
  assign and_dcpl_49 = and_dcpl_47 & and_dcpl_19;
  assign and_dcpl_50 = nor_tmp_1 & and_dcpl_13;
  assign and_dcpl_51 = and_dcpl_50 & and_dcpl_12;
  assign and_dcpl_52 = nor_tmp_1 & and_dcpl_20;
  assign and_dcpl_53 = and_dcpl_52 & and_dcpl_19;
  assign and_dcpl_54 = and_dcpl_50 & and_dcpl_19;
  assign and_dcpl_56 = and_dcpl_46 & and_dcpl_34 & and_dcpl_26;
  assign and_dcpl_57 = nor_tmp_1 & and_dcpl_34;
  assign and_dcpl_58 = and_dcpl_57 & and_dcpl_33;
  assign and_dcpl_60 = nor_tmp_1 & and_dcpl_37 & and_dcpl_26;
  assign and_dcpl_61 = (~ (fsm_output[3])) & (fsm_output[7]);
  assign and_dcpl_63 = and_dcpl_15 & and_dcpl_61 & and_dcpl_17;
  assign and_dcpl_64 = and_dcpl_61 & and_dcpl_10;
  assign and_dcpl_65 = and_dcpl_28 & and_dcpl_64;
  assign and_dcpl_67 = (fsm_output[3]) & (fsm_output[7]) & and_dcpl_17;
  assign and_dcpl_68 = and_dcpl_28 & and_dcpl_67;
  assign and_dcpl_69 = ~((fsm_output[7]) | (fsm_output[0]));
  assign nor_161_nl = ~((fsm_output[3:2]!=2'b01));
  assign nor_162_nl = ~((fsm_output[3:2]!=2'b10));
  assign mux_165_nl = MUX_s_1_2_2(nor_161_nl, nor_162_nl, fsm_output[1]);
  assign and_dcpl_73 = mux_165_nl & (fsm_output[6:4]==3'b000) & and_dcpl_69;
  assign mux_tmp_166 = MUX_s_1_2_2(and_dcpl_46, mux_tmp_155, fsm_output[2]);
  assign or_tmp_103 = (fsm_output[6]) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign or_tmp_107 = (fsm_output[6]) | (~ (fsm_output[7])) | (fsm_output[4]);
  assign and_tmp_3 = (fsm_output[5]) & mux_tmp_155;
  assign or_185_nl = (~ (fsm_output[7])) | (fsm_output[4]);
  assign mux_180_nl = MUX_s_1_2_2(or_185_nl, or_176_cse, fsm_output[5]);
  assign or_tmp_115 = (fsm_output[6]) | mux_180_nl;
  assign or_tmp_117 = (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[4]);
  assign or_tmp_119 = (fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign mux_tmp_189 = MUX_s_1_2_2(or_tmp_103, or_175_cse, fsm_output[5]);
  assign mux_tmp_192 = MUX_s_1_2_2(or_tmp_107, or_tmp_103, fsm_output[5]);
  assign nor_tmp_18 = (fsm_output[4]) & (VEC_LOOP_j_10_10_0_sva_1[10]);
  assign or_tmp_137 = (fsm_output[2]) | (~ nor_tmp_18);
  assign nor_50_nl = ~((fsm_output[4]) | (~ (VEC_LOOP_j_10_10_0_sva_1[10])));
  assign mux_tmp_201 = MUX_s_1_2_2(nor_50_nl, nor_tmp_18, fsm_output[2]);
  assign mux_202_nl = MUX_s_1_2_2(mux_tmp_201, (~ or_tmp_137), fsm_output[6]);
  assign nand_6_nl = ~((fsm_output[5]) & mux_202_nl);
  assign or_207_nl = (fsm_output[5]) | (fsm_output[6]) | (~ (fsm_output[2])) | (fsm_output[4])
      | (~ (VEC_LOOP_j_10_10_0_sva_1[10]));
  assign mux_tmp_203 = MUX_s_1_2_2(nand_6_nl, or_207_nl, fsm_output[7]);
  assign and_dcpl_82 = and_dcpl_21 & and_dcpl_33;
  assign and_dcpl_83 = and_dcpl_15 & and_dcpl_26;
  assign and_dcpl_99 = and_dcpl_15 & and_dcpl_64;
  assign mux_tmp_212 = MUX_s_1_2_2((~ (fsm_output[3])), (fsm_output[3]), fsm_output[1]);
  assign nor_46_nl = ~((fsm_output[1]) | (~ (fsm_output[3])));
  assign nor_47_nl = ~((~ (fsm_output[1])) | (fsm_output[3]));
  assign mux_214_nl = MUX_s_1_2_2(nor_46_nl, nor_47_nl, fsm_output[4]);
  assign and_105_nl = (fsm_output[4]) & mux_tmp_212;
  assign mux_tmp_215 = MUX_s_1_2_2(mux_214_nl, and_105_nl, fsm_output[5]);
  assign and_dcpl_101 = and_dcpl_47 & and_dcpl_26;
  assign or_tmp_155 = (fsm_output[6:3]!=4'b0000);
  assign and_dcpl_110 = nor_159_cse & (fsm_output[2]);
  assign and_dcpl_115 = and_dcpl_38 & and_dcpl_61 & (fsm_output[1:0]==2'b01);
  assign or_244_nl = (~ (fsm_output[5])) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign or_242_nl = (fsm_output[5]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_241_cse = MUX_s_1_2_2(or_244_nl, or_242_nl, fsm_output[6]);
  assign mux_tmp_242 = MUX_s_1_2_2(mux_241_cse, or_259_cse, fsm_output[7]);
  assign or_245_cse = (~ (fsm_output[2])) | (fsm_output[4]);
  assign or_246_cse = (fsm_output[2]) | (~ (fsm_output[4]));
  assign mux_tmp_243 = MUX_s_1_2_2(or_246_cse, or_245_cse, fsm_output[5]);
  assign or_tmp_180 = (fsm_output[0]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_tmp_251 = MUX_s_1_2_2(mux_tmp_134, or_245_cse, fsm_output[0]);
  assign mux_252_nl = MUX_s_1_2_2(or_246_cse, mux_tmp_251, fsm_output[5]);
  assign mux_250_nl = MUX_s_1_2_2(or_tmp_180, (~ mux_tmp_134), fsm_output[5]);
  assign mux_253_nl = MUX_s_1_2_2(mux_252_nl, mux_250_nl, fsm_output[6]);
  assign or_251_nl = (fsm_output[6]) | (fsm_output[5]) | (fsm_output[0]) | (~ mux_tmp_134);
  assign mux_tmp_254 = MUX_s_1_2_2(mux_253_nl, or_251_nl, fsm_output[7]);
  assign mux_tmp_255 = MUX_s_1_2_2(mux_tmp_251, or_tmp_180, fsm_output[5]);
  assign or_tmp_192 = (fsm_output[7]) | (fsm_output[6]) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign or_262_nl = (fsm_output[7]) | (~ mux_tmp_135);
  assign mux_tmp_266 = MUX_s_1_2_2(or_tmp_192, or_262_nl, fsm_output[5]);
  assign or_tmp_202 = (fsm_output[6:2]!=5'b00000);
  assign mux_279_nl = MUX_s_1_2_2((~ or_tmp_202), mux_tmp_105, fsm_output[7]);
  assign mux_tmp_280 = MUX_s_1_2_2(mux_279_nl, and_tmp_2, fsm_output[1]);
  assign mux_tmp_285 = MUX_s_1_2_2(or_tmp_5, or_dcpl_69, fsm_output[3]);
  assign or_tmp_227 = (fsm_output[7:5]!=3'b001);
  assign or_tmp_228 = (fsm_output[7:5]!=3'b100);
  assign or_309_cse = (fsm_output[7:5]!=3'b010);
  assign and_dcpl_143 = and_dcpl_110 & (~ (fsm_output[5])) & (fsm_output[3]) & (~
      (fsm_output[7])) & (~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm) & and_dcpl_10;
  assign mux_nl = MUX_s_1_2_2(nor_tmp, or_13_cse, fsm_output[5]);
  assign mux_tmp_337 = MUX_s_1_2_2(mux_tmp_5, mux_nl, VEC_LOOP_j_10_10_0_sva_1[10]);
  assign mux_1_nl = MUX_s_1_2_2((fsm_output[6]), (fsm_output[7]), fsm_output[5]);
  assign mux_tmp_339 = MUX_s_1_2_2(mux_tmp_5, mux_1_nl, VEC_LOOP_j_10_10_0_sva_1[10]);
  assign mux_tmp_340 = MUX_s_1_2_2(mux_tmp_339, mux_tmp_337, fsm_output[1]);
  assign or_312_nl = (VEC_LOOP_j_10_10_0_sva_1[10]) | (fsm_output[5]);
  assign mux_tmp_341 = MUX_s_1_2_2(nor_tmp, (fsm_output[7]), or_312_nl);
  assign mux_10_nl = MUX_s_1_2_2(nor_tmp, or_203_cse, fsm_output[5]);
  assign mux_tmp_348 = MUX_s_1_2_2(mux_tmp_5, mux_10_nl, VEC_LOOP_j_10_10_0_sva_1[10]);
  assign mux_tmp_349 = MUX_s_1_2_2(mux_tmp_341, mux_tmp_348, fsm_output[1]);
  assign or_333_nl = (fsm_output[5]) | (~((fsm_output[6]) & mux_tmp_134));
  assign mux_tmp_380 = MUX_s_1_2_2(or_333_nl, or_256_cse, fsm_output[7]);
  assign mux_386_nl = MUX_s_1_2_2(mux_tmp_380, or_146_cse, fsm_output[3]);
  assign mux_383_nl = MUX_s_1_2_2(mux_138_cse, mux_tmp_380, fsm_output[3]);
  assign mux_387_nl = MUX_s_1_2_2(mux_386_nl, mux_383_nl, fsm_output[1]);
  assign and_dcpl_153 = (~ mux_387_nl) & (fsm_output[0]);
  assign mux_392_nl = MUX_s_1_2_2(or_tmp_227, or_tmp_228, fsm_output[2]);
  assign or_306_nl = (fsm_output[7:5]!=3'b011);
  assign mux_391_nl = MUX_s_1_2_2(or_306_nl, or_tmp_227, fsm_output[2]);
  assign mux_tmp_393 = MUX_s_1_2_2(mux_392_nl, mux_391_nl, fsm_output[4]);
  assign or_307_nl = (fsm_output[7:5]!=3'b000);
  assign mux_tmp_394 = MUX_s_1_2_2(or_309_cse, or_307_nl, fsm_output[2]);
  assign or_tmp_292 = (fsm_output[7]) | (fsm_output[5]);
  assign or_tmp_294 = (~ (fsm_output[1])) | (fsm_output[3]) | (fsm_output[7]) | (~
      (fsm_output[5]));
  assign or_375_nl = (fsm_output[7]) | (~ (fsm_output[5]));
  assign mux_428_nl = MUX_s_1_2_2(or_tmp_292, or_375_nl, fsm_output[3]);
  assign or_374_nl = (~ (fsm_output[3])) | (fsm_output[7]) | (fsm_output[5]);
  assign mux_429_nl = MUX_s_1_2_2(mux_428_nl, or_374_nl, fsm_output[1]);
  assign mux_tmp_430 = MUX_s_1_2_2(or_tmp_294, mux_429_nl, fsm_output[6]);
  assign or_379_nl = (~ (fsm_output[7])) | (fsm_output[5]);
  assign mux_tmp_431 = MUX_s_1_2_2(or_379_nl, or_tmp_292, fsm_output[3]);
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_38 & and_dcpl_64;
  assign VEC_LOOP_j_1_sva_mx0c0 = and_dcpl_21 & and_dcpl_11 & and_176_cse;
  assign mux_397_nl = MUX_s_1_2_2(or_tmp_228, or_309_cse, fsm_output[2]);
  assign mux_398_nl = MUX_s_1_2_2(mux_tmp_394, mux_397_nl, fsm_output[4]);
  assign mux_399_nl = MUX_s_1_2_2(mux_tmp_393, mux_398_nl, fsm_output[3]);
  assign nand_nl = ~((fsm_output[2]) & (fsm_output[6]) & (~ (fsm_output[7])) & (fsm_output[5]));
  assign mux_395_nl = MUX_s_1_2_2(nand_nl, mux_tmp_394, fsm_output[4]);
  assign mux_396_nl = MUX_s_1_2_2(mux_395_nl, mux_tmp_393, fsm_output[3]);
  assign mux_400_nl = MUX_s_1_2_2(mux_399_nl, mux_396_nl, fsm_output[1]);
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c0 = (~ mux_400_nl) & (fsm_output[0]);
  assign or_359_nl = (fsm_output[5]) | (fsm_output[2]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_407_nl = MUX_s_1_2_2(or_359_nl, or_155_cse, fsm_output[4]);
  assign mux_408_nl = MUX_s_1_2_2(mux_235_cse, mux_407_nl, fsm_output[3]);
  assign mux_409_nl = MUX_s_1_2_2(mux_408_nl, mux_237_cse, fsm_output[1]);
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c2 = ~(mux_409_nl | (fsm_output[0]));
  assign VEC_LOOP_or_11_cse = and_dcpl_36 | and_dcpl_45 | and_dcpl_49 | and_dcpl_54
      | and_dcpl_58 | and_dcpl_63 | and_dcpl_68;
  assign VEC_LOOP_or_85_cse = and_dcpl_29 | VEC_LOOP_or_56_cse | VEC_LOOP_or_52_cse
      | VEC_LOOP_or_53_cse | VEC_LOOP_or_57_cse | VEC_LOOP_or_54_cse;
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_v_7_6_2((z_out_6[9:3]), (acc_4_cse_10_1[9:3]),
      (z_out_19[8:2]), (z_out_9[9:3]), (z_out_17[7:1]), (z_out_17[6:0]), {and_dcpl_16
      , and_dcpl_24 , VEC_LOOP_or_4_cse , VEC_LOOP_or_11_cse , VEC_LOOP_or_49_cse
      , and_dcpl_51});
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_6_2((z_out_6[2]), (acc_4_cse_10_1[2]),
      (z_out_19[1]), (z_out_9[2]), (z_out_17[0]), (VEC_LOOP_acc_1_cse_10_sva[2]),
      {and_dcpl_16 , and_dcpl_24 , VEC_LOOP_or_4_cse , VEC_LOOP_or_11_cse , VEC_LOOP_or_49_cse
      , and_dcpl_51});
  assign nor_51_nl = ~((fsm_output[5]) | (~ nor_tmp_1));
  assign mux_179_nl = MUX_s_1_2_2(nor_51_nl, and_tmp_3, fsm_output[3]);
  assign and_82_nl = mux_179_nl & (fsm_output[2]) & (~ (fsm_output[7])) & and_dcpl_10;
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_5_2((z_out_6[1]), (acc_4_cse_10_1[1]),
      (z_out_19[0]), (z_out_9[1]), (VEC_LOOP_acc_1_cse_10_sva[1]), {and_dcpl_16 ,
      and_dcpl_24 , VEC_LOOP_or_4_cse , VEC_LOOP_or_11_cse , and_82_nl});
  assign mux_168_nl = MUX_s_1_2_2(and_dcpl_46, nor_tmp_1, fsm_output[2]);
  assign nor_52_nl = ~((fsm_output[5]) | (~ mux_168_nl));
  assign mux_167_nl = MUX_s_1_2_2(nor_53_cse, mux_tmp_166, fsm_output[5]);
  assign mux_169_nl = MUX_s_1_2_2(nor_52_nl, mux_167_nl, fsm_output[3]);
  assign nor_54_nl = ~((fsm_output[6:2]!=5'b00100));
  assign mux_170_nl = MUX_s_1_2_2(mux_169_nl, nor_54_nl, fsm_output[7]);
  assign and_77_nl = mux_170_nl & and_dcpl_10;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_4_2((z_out_6[0]), (acc_4_cse_10_1[0]),
      (VEC_LOOP_acc_1_cse_10_sva[0]), (z_out_9[0]), {and_dcpl_16 , and_dcpl_24 ,
      and_77_nl , VEC_LOOP_or_11_cse});
  assign and_25_nl = and_dcpl_21 & and_dcpl_19;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_6_11_2((z_out_17[5:0]), VEC_LOOP_acc_13_psp_sva_5_0,
      (VEC_LOOP_acc_10_cse_1_sva[9:4]), (z_out_9[9:4]), (VEC_LOOP_acc_1_cse_10_sva[9:4]),
      (acc_4_cse_10_1[9:4]), (VEC_LOOP_acc_12_psp_sva[8:3]), ({VEC_LOOP_acc_13_psp_sva_7_6
      , (VEC_LOOP_acc_13_psp_sva_5_0[5:2])}), (z_out_12[9:4]), (COMP_LOOP_9_twiddle_f_lshift_itm[6:1]),
      (z_out_6[9:4]), {and_dcpl_16 , and_25_nl , and_dcpl_23 , and_dcpl_24 , and_dcpl_25
      , VEC_LOOP_or_85_cse , and_dcpl_32 , and_dcpl_43 , VEC_LOOP_or_55_cse , and_dcpl_53
      , and_dcpl_68});
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_10_2((VEC_LOOP_j_1_sva[3]), (VEC_LOOP_acc_10_cse_1_sva[3]),
      (z_out_9[3]), (VEC_LOOP_acc_1_cse_10_sva[3]), (acc_4_cse_10_1[3]), (VEC_LOOP_acc_12_psp_sva[2]),
      (VEC_LOOP_acc_13_psp_sva_5_0[1]), (z_out_12[3]), (COMP_LOOP_9_twiddle_f_lshift_itm[0]),
      (z_out_6[3]), {and_dcpl_73 , and_dcpl_23 , and_dcpl_24 , and_dcpl_25 , VEC_LOOP_or_85_cse
      , and_dcpl_32 , and_dcpl_43 , VEC_LOOP_or_55_cse , and_dcpl_53 , and_dcpl_68});
  assign or_180_nl = (fsm_output[3]) | (~ (fsm_output[6])) | (fsm_output[7]) | (~
      (fsm_output[4]));
  assign mux_175_nl = MUX_s_1_2_2(or_tmp_103, or_tmp_107, fsm_output[3]);
  assign mux_176_nl = MUX_s_1_2_2(or_180_nl, mux_175_nl, fsm_output[2]);
  assign or_177_nl = (fsm_output[7]) | (fsm_output[4]);
  assign mux_172_nl = MUX_s_1_2_2(or_177_nl, or_176_cse, fsm_output[6]);
  assign mux_173_nl = MUX_s_1_2_2(or_tmp_107, mux_172_nl, fsm_output[3]);
  assign mux_171_nl = MUX_s_1_2_2(or_175_cse, or_tmp_103, fsm_output[3]);
  assign mux_174_nl = MUX_s_1_2_2(mux_173_nl, mux_171_nl, fsm_output[2]);
  assign mux_177_nl = MUX_s_1_2_2(mux_176_nl, mux_174_nl, fsm_output[5]);
  assign or_172_nl = (fsm_output[7:2]!=6'b010110);
  assign mux_178_nl = MUX_s_1_2_2(mux_177_nl, or_172_nl, fsm_output[1]);
  assign nor_85_nl = ~(mux_178_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_9_2((VEC_LOOP_j_1_sva[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_9[2]), (VEC_LOOP_acc_1_cse_10_sva[2]), (acc_4_cse_10_1[2]), (VEC_LOOP_acc_12_psp_sva[1]),
      (VEC_LOOP_acc_13_psp_sva_5_0[0]), (z_out_12[2]), (z_out_6[2]), {and_dcpl_73
      , and_dcpl_23 , and_dcpl_24 , nor_85_nl , VEC_LOOP_or_85_cse , and_dcpl_32
      , and_dcpl_43 , VEC_LOOP_or_55_cse , and_dcpl_68});
  assign or_193_nl = (~ (fsm_output[5])) | (~ (fsm_output[7])) | (fsm_output[4]);
  assign mux_185_nl = MUX_s_1_2_2(or_193_nl, or_tmp_119, fsm_output[6]);
  assign or_192_nl = (~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign mux_184_nl = MUX_s_1_2_2(or_tmp_117, or_192_nl, fsm_output[6]);
  assign mux_186_nl = MUX_s_1_2_2(mux_185_nl, mux_184_nl, fsm_output[3]);
  assign mux_182_nl = MUX_s_1_2_2(or_tmp_119, or_tmp_117, fsm_output[6]);
  assign mux_183_nl = MUX_s_1_2_2(mux_182_nl, or_tmp_115, fsm_output[3]);
  assign mux_187_nl = MUX_s_1_2_2(mux_186_nl, mux_183_nl, fsm_output[2]);
  assign mux_181_nl = MUX_s_1_2_2(or_tmp_115, or_183_cse, fsm_output[3]);
  assign or_187_nl = (fsm_output[2]) | mux_181_nl;
  assign mux_188_nl = MUX_s_1_2_2(mux_187_nl, or_187_nl, fsm_output[1]);
  assign nor_84_nl = ~(mux_188_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_8_2((VEC_LOOP_j_1_sva[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_9[1]), (VEC_LOOP_acc_1_cse_10_sva[1]), (acc_4_cse_10_1[1]), (VEC_LOOP_acc_12_psp_sva[0]),
      (z_out_12[1]), (z_out_6[1]), {and_dcpl_73 , and_dcpl_23 , and_dcpl_24 , nor_84_nl
      , VEC_LOOP_or_85_cse , and_dcpl_32 , VEC_LOOP_or_55_cse , and_dcpl_68});
  assign or_205_nl = (~ (fsm_output[4])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_197_nl = MUX_s_1_2_2(or_205_nl, or_tmp_107, fsm_output[5]);
  assign mux_196_nl = MUX_s_1_2_2(or_203_cse, or_13_cse, fsm_output[4]);
  assign nand_5_nl = ~((fsm_output[5]) & (~ mux_196_nl));
  assign mux_198_nl = MUX_s_1_2_2(mux_197_nl, nand_5_nl, fsm_output[3]);
  assign mux_195_nl = MUX_s_1_2_2(mux_tmp_189, mux_tmp_192, fsm_output[3]);
  assign mux_199_nl = MUX_s_1_2_2(mux_198_nl, mux_195_nl, fsm_output[2]);
  assign mux_193_nl = MUX_s_1_2_2(mux_tmp_192, or_183_cse, fsm_output[3]);
  assign mux_190_nl = MUX_s_1_2_2(or_13_cse, or_197_cse, fsm_output[4]);
  assign or_199_nl = (fsm_output[5]) | mux_190_nl;
  assign mux_191_nl = MUX_s_1_2_2(or_199_nl, mux_tmp_189, fsm_output[3]);
  assign mux_194_nl = MUX_s_1_2_2(mux_193_nl, mux_191_nl, fsm_output[2]);
  assign mux_200_nl = MUX_s_1_2_2(mux_199_nl, mux_194_nl, fsm_output[1]);
  assign nor_83_nl = ~(mux_200_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_7_2((VEC_LOOP_j_1_sva[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_9[0]), (VEC_LOOP_acc_1_cse_10_sva[0]), (acc_4_cse_10_1[0]), (z_out_12[0]),
      (z_out_6[0]), {and_dcpl_73 , and_dcpl_23 , and_dcpl_24 , nor_83_nl , VEC_LOOP_or_85_cse
      , VEC_LOOP_or_55_cse , and_dcpl_68});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_8_nl , VEC_LOOP_mux1h_6_nl , VEC_LOOP_mux1h_4_nl
      , VEC_LOOP_mux1h_2_nl , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl , VEC_LOOP_mux1h_3_nl
      , VEC_LOOP_mux1h_5_nl , VEC_LOOP_mux1h_7_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_adra_d = {COMP_LOOP_2_twiddle_f_mul_rmff , COMP_LOOP_twiddle_f_mux1h_56_rmff
      , COMP_LOOP_twiddle_f_and_rmff , COMP_LOOP_twiddle_f_mux1h_14_rmff , COMP_LOOP_twiddle_f_mux1h_41_rmff
      , COMP_LOOP_twiddle_f_mux1h_64_rmff};
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_adra_d = {COMP_LOOP_2_twiddle_f_mul_rmff , COMP_LOOP_twiddle_f_mux1h_56_rmff
      , COMP_LOOP_twiddle_f_and_rmff , COMP_LOOP_twiddle_f_mux1h_14_rmff , COMP_LOOP_twiddle_f_mux1h_41_rmff
      , COMP_LOOP_twiddle_f_mux1h_64_rmff};
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign and_dcpl = (fsm_output[2]) & (~ (fsm_output[0]));
  assign and_dcpl_156 = ~((fsm_output[4]) | (fsm_output[1]));
  assign and_dcpl_158 = (~ (fsm_output[5])) & (fsm_output[3]);
  assign and_dcpl_159 = ~((fsm_output[7:6]!=2'b00));
  assign and_dcpl_161 = and_dcpl_159 & and_dcpl_158 & and_dcpl_156 & and_dcpl;
  assign and_dcpl_162 = (fsm_output[4]) & (fsm_output[1]);
  assign and_dcpl_163 = and_dcpl_162 & and_dcpl;
  assign and_dcpl_164 = ~((fsm_output[5]) | (fsm_output[3]));
  assign and_dcpl_166 = and_dcpl_159 & and_dcpl_164 & and_dcpl_163;
  assign and_dcpl_167 = ~((fsm_output[2]) | (fsm_output[0]));
  assign and_dcpl_169 = (fsm_output[5]) & (~ (fsm_output[3]));
  assign and_dcpl_170 = and_dcpl_159 & and_dcpl_169;
  assign and_dcpl_171 = and_dcpl_170 & and_dcpl_156 & and_dcpl_167;
  assign and_dcpl_172 = (~ (fsm_output[4])) & (fsm_output[1]);
  assign and_dcpl_174 = (fsm_output[5]) & (fsm_output[3]);
  assign and_dcpl_175 = and_dcpl_159 & and_dcpl_174;
  assign and_dcpl_176 = and_dcpl_175 & and_dcpl_172 & and_dcpl_167;
  assign and_dcpl_177 = (fsm_output[4]) & (~ (fsm_output[1]));
  assign and_dcpl_178 = and_dcpl_177 & and_dcpl;
  assign and_dcpl_179 = and_dcpl_170 & and_dcpl_178;
  assign and_dcpl_180 = and_dcpl_175 & and_dcpl_163;
  assign and_dcpl_181 = and_dcpl_162 & and_dcpl_167;
  assign and_dcpl_182 = (fsm_output[7:6]==2'b01);
  assign and_dcpl_184 = and_dcpl_182 & and_dcpl_164 & and_dcpl_181;
  assign and_dcpl_186 = and_dcpl_182 & and_dcpl_158 & and_dcpl_178;
  assign and_dcpl_187 = and_dcpl_172 & and_dcpl;
  assign and_dcpl_188 = and_dcpl_182 & and_dcpl_169;
  assign and_dcpl_189 = and_dcpl_188 & and_dcpl_187;
  assign and_dcpl_191 = and_dcpl_188 & and_dcpl_177 & and_dcpl_167;
  assign and_dcpl_193 = and_dcpl_182 & and_dcpl_174 & and_dcpl_181;
  assign and_dcpl_196 = (fsm_output[7:6]==2'b10) & and_dcpl_158 & and_dcpl_187;
  assign and_dcpl_209 = (~ (fsm_output[6])) & (~ (fsm_output[5])) & (fsm_output[7])
      & (~ (fsm_output[3])) & and_dcpl_156 & (fsm_output[2]) & (~ (fsm_output[0]));
  assign and_dcpl_245 = ~((fsm_output!=8'b00000010));
  assign and_302_cse = (fsm_output==8'b10100011);
  assign and_dcpl_273 = (fsm_output==8'b10011010);
  assign and_dcpl_278 = ~((fsm_output[6:5]!=2'b00));
  assign and_dcpl_279 = and_dcpl_278 & and_dcpl_18;
  assign and_dcpl_283 = and_dcpl_177 & and_dcpl_167;
  assign and_dcpl_285 = and_dcpl_172 & and_dcpl_167;
  assign and_dcpl_287 = (fsm_output[6:5]==2'b01);
  assign and_dcpl_288 = and_dcpl_287 & and_dcpl_11;
  assign and_dcpl_297 = and_dcpl_156 & and_dcpl_167;
  assign and_dcpl_298 = (fsm_output[6:5]==2'b10);
  assign and_dcpl_301 = and_dcpl_298 & and_dcpl_18;
  assign and_dcpl_304 = (fsm_output[6:5]==2'b11);
  assign and_dcpl_305 = and_dcpl_304 & and_dcpl_18;
  assign and_dcpl_313 = and_dcpl_278 & (fsm_output[7]) & (~ (fsm_output[3]));
  assign and_dcpl_341 = (fsm_output[6:5]==2'b01) & and_dcpl_11;
  assign and_dcpl_347 = (fsm_output[6:5]==2'b10) & and_dcpl_18;
  assign or_tmp_300 = (fsm_output[2]) | (fsm_output[5]);
  assign or_412_nl = (~ (fsm_output[2])) | (fsm_output[5]);
  assign mux_tmp_438 = MUX_s_1_2_2(or_tmp_300, or_412_nl, fsm_output[4]);
  assign or_397_nl = (fsm_output[6]) | mux_tmp_438;
  assign mux_tmp_440 = MUX_s_1_2_2(mux_241_cse, or_397_nl, fsm_output[7]);
  assign mux_tmp_441 = MUX_s_1_2_2((~ and_dcpl_37), or_tmp_300, fsm_output[4]);
  assign nor_102_nl = ~((fsm_output[2]) | (~ (fsm_output[5])));
  assign mux_443_nl = MUX_s_1_2_2(nor_102_nl, and_dcpl_37, fsm_output[4]);
  assign mux_444_nl = MUX_s_1_2_2(mux_tmp_441, (~ mux_443_nl), fsm_output[6]);
  assign or_403_nl = (fsm_output[7]) | mux_444_nl;
  assign mux_445_nl = MUX_s_1_2_2(mux_tmp_440, or_403_nl, fsm_output[1]);
  assign mux_441_nl = MUX_s_1_2_2(mux_tmp_438, mux_tmp_441, fsm_output[6]);
  assign or_401_nl = (fsm_output[7]) | mux_441_nl;
  assign mux_442_nl = MUX_s_1_2_2(or_401_nl, mux_tmp_440, fsm_output[1]);
  assign mux_446_nl = MUX_s_1_2_2(mux_445_nl, mux_442_nl, fsm_output[3]);
  assign and_dcpl_445 = (~ mux_446_nl) & (fsm_output[0]);
  assign and_dcpl_448 = and_dcpl_156 & and_dcpl;
  assign and_dcpl_452 = and_dcpl_278 & and_dcpl_11 & and_dcpl_448;
  assign and_dcpl_457 = and_dcpl_298 & and_dcpl_11 & and_dcpl_178;
  assign and_dcpl_461 = (fsm_output[6:5]==2'b01) & and_dcpl_18 & and_dcpl_448;
  assign and_dcpl_464 = (fsm_output[6:5]==2'b11) & and_dcpl_18 & and_dcpl_178;
  assign and_dcpl_465 = (~ (fsm_output[2])) & (fsm_output[0]);
  assign and_dcpl_469 = and_dcpl_278 & (fsm_output[7]) & (fsm_output[3]) & and_dcpl_177
      & and_dcpl_465;
  assign and_dcpl_472 = and_dcpl_298 & and_dcpl_18 & and_dcpl_156 & and_dcpl_465;
  assign and_dcpl_479 = (fsm_output[7:6]==2'b00) & and_dcpl_164 & (~ (fsm_output[4]))
      & (~ (fsm_output[1])) & and_dcpl;
  assign and_dcpl_484 = (fsm_output[7:6]==2'b01) & and_dcpl_164 & (fsm_output[4])
      & (~ (fsm_output[1])) & and_dcpl;
  assign and_dcpl_498 = and_dcpl_278 & and_dcpl_18 & and_dcpl_283;
  assign and_dcpl_504 = (fsm_output[6:5]==2'b10) & and_dcpl_11 & and_dcpl_297;
  assign and_dcpl_507 = and_dcpl_304 & and_dcpl_18 & and_dcpl_297;
  assign and_dcpl_510 = and_dcpl_278 & and_dcpl_61 & and_dcpl_283;
  assign and_dcpl_515 = and_dcpl_287 & and_dcpl_61 & and_dcpl_156 & (fsm_output[2])
      & (~ (fsm_output[0]));
  assign and_dcpl_519 = and_dcpl_287 & and_dcpl_11 & and_dcpl_156 & and_dcpl_465;
  assign and_dcpl_522 = and_dcpl_304 & and_dcpl_11 & and_dcpl_177 & and_dcpl_465;
  assign or_tmp_309 = (~ (fsm_output[1])) | (~ (fsm_output[4])) | (fsm_output[2]);
  assign mux_tmp_448 = MUX_s_1_2_2(or_246_cse, or_245_cse, fsm_output[1]);
  assign mux_tmp_450 = MUX_s_1_2_2((~ (fsm_output[2])), (fsm_output[2]), fsm_output[4]);
  assign or_tmp_313 = (fsm_output[1]) | (~ mux_tmp_450);
  assign and_tmp = (fsm_output[1]) & mux_tmp_450;
  assign and_dcpl_524 = (fsm_output[2]) & (fsm_output[0]);
  assign and_dcpl_526 = and_dcpl_172 & and_dcpl_524;
  assign and_dcpl_528 = (fsm_output[7:6]==2'b10);
  assign and_dcpl_530 = and_dcpl_528 & and_dcpl_158 & and_dcpl_526;
  assign and_dcpl_535 = and_dcpl_528 & and_dcpl_164 & (~ (fsm_output[4])) & (~ (fsm_output[1]))
      & and_dcpl_524;
  assign and_dcpl_537 = (fsm_output[4]) & (~ (fsm_output[1])) & and_dcpl_524;
  assign and_dcpl_541 = and_dcpl_159 & and_dcpl_169 & and_dcpl_537;
  assign and_dcpl_546 = and_dcpl_175 & and_dcpl_172 & and_dcpl_465;
  assign and_dcpl_548 = and_dcpl_162 & and_dcpl_524;
  assign and_dcpl_549 = and_dcpl_175 & and_dcpl_548;
  assign and_dcpl_551 = and_dcpl_159 & and_dcpl_164 & and_dcpl_548;
  assign and_dcpl_552 = and_dcpl_162 & and_dcpl_465;
  assign and_dcpl_555 = and_dcpl_182 & and_dcpl_174 & and_dcpl_552;
  assign and_dcpl_557 = and_dcpl_182 & and_dcpl_158 & and_dcpl_537;
  assign and_dcpl_559 = and_dcpl_182 & and_dcpl_169 & and_dcpl_526;
  assign and_dcpl_561 = and_dcpl_182 & and_dcpl_164 & and_dcpl_552;
  assign COMP_LOOP_twiddle_f_or_ssc = and_dcpl_166 | and_dcpl_176 | and_dcpl_180
      | and_dcpl_184 | and_dcpl_189 | and_dcpl_193 | and_dcpl_196;
  assign or_416_nl = (fsm_output[3]) | (fsm_output[2]) | (fsm_output[6]) | (fsm_output[4]);
  assign mux_tmp = MUX_s_1_2_2((fsm_output[6]), or_416_nl, fsm_output[5]);
  assign not_tmp = ~((fsm_output[6:1]!=6'b000000));
  assign COMP_LOOP_twiddle_f_nor_1_itm = ~(and_dcpl_161 | and_dcpl_171 | and_dcpl_179
      | and_dcpl_186 | and_dcpl_191);
  assign COMP_LOOP_twiddle_f_or_itm = and_dcpl_179 | and_dcpl_186;
  assign COMP_LOOP_twiddle_f_nor_2_itm = ~(and_dcpl_171 | and_dcpl_191);
  assign COMP_LOOP_twiddle_f_or_16_itm = and_dcpl_171 | and_dcpl_191;
  assign and_361_cse = and_dcpl_278 & (fsm_output[7]) & (fsm_output[3]) & and_dcpl_181;
  assign VEC_LOOP_or_61_itm = and_dcpl_461 | and_dcpl_464;
  assign VEC_LOOP_or_68_itm = and_dcpl_457 | and_dcpl_472;
  assign VEC_LOOP_or_63_itm = and_dcpl_498 | and_dcpl_504 | and_dcpl_507 | and_dcpl_510;
  assign VEC_LOOP_or_71_itm = and_dcpl_519 | and_dcpl_522;
  assign VEC_LOOP_or_75_itm = and_dcpl_530 | and_dcpl_535 | and_dcpl_541 | and_dcpl_546
      | and_dcpl_549 | and_dcpl_551 | and_dcpl_555 | and_dcpl_557 | and_dcpl_559
      | and_dcpl_561;
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp ) begin
      VEC_LOOP_mult_vec_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
          and_dcpl_153);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_run_rsci_oswt_cse <= 1'b0;
      reg_vec_rsci_oswt_cse <= 1'b0;
      reg_vec_rsci_oswt_1_cse <= 1'b0;
      reg_twiddle_rsci_oswt_cse <= 1'b0;
      reg_twiddle_rsci_oswt_1_cse <= 1'b0;
      reg_complete_rsci_oswt_cse <= 1'b0;
      reg_vec_rsc_triosy_obj_iswt0_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      reg_ensig_cgo_2_cse <= 1'b0;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= ~(or_dcpl_69 | or_dcpl_66);
      reg_vec_rsci_oswt_cse <= ~ mux_133_itm;
      reg_vec_rsci_oswt_1_cse <= nor_86_cse;
      reg_twiddle_rsci_oswt_cse <= nor_82_rmff;
      reg_twiddle_rsci_oswt_1_cse <= and_dcpl_82;
      reg_complete_rsci_oswt_cse <= and_dcpl_110 & (fsm_output[5]) & (~ (fsm_output[3]))
          & (fsm_output[7]) & (~ (fsm_output[1])) & (~ (fsm_output[0])) & (z_out_19[4]);
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_115;
      reg_ensig_cgo_cse <= ~ mux_239_itm;
      reg_ensig_cgo_2_cse <= ~ mux_263_itm;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_21 & and_dcpl_12) | STAGE_LOOP_i_3_0_sva_mx0c1)
        ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, z_out_4, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_278_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_280 ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( mux_462_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_10_4_sva_5_0 <= MUX_v_6_2_2(6'b000000, (z_out_18[5:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_287_nl ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= z_out_2;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_292_nl | (fsm_output[7])) ) begin
      COMP_LOOP_9_twiddle_f_lshift_itm <= MUX_v_7_2_2((z_out_3[6:0]), (z_out_17[6:0]),
          and_dcpl_51);
    end
  end
  always @(posedge clk) begin
    if ( (mux_464_nl | (fsm_output[7])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva_7_4 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt[7:4];
    end
  end
  always @(posedge clk) begin
    if ( (mux_466_nl | (fsm_output[7])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt[3:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (VEC_LOOP_j_1_sva_mx0c0 | (~(mux_238_cse | (fsm_output[0])))
        | and_dcpl_83) ) begin
      VEC_LOOP_j_1_sva <= MUX_v_32_2_2(32'b00000000000000000000000000000000, VEC_LOOP_mux_2_nl,
          VEC_LOOP_j_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_cse ) begin
      COMP_LOOP_twiddle_help_1_sva <= MUX_v_32_2_2((twiddle_h_rsci_qa_d_mxwt[31:0]),
          (twiddle_h_rsci_qa_d_mxwt[63:32]), and_dcpl_143);
      COMP_LOOP_twiddle_f_1_sva <= MUX_v_32_2_2((twiddle_rsci_qa_d_mxwt[31:0]), (twiddle_rsci_qa_d_mxwt[63:32]),
          and_dcpl_143);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (and_dcpl_16 | and_dcpl_115) ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm <= MUX_s_1_2_2((z_out_5_22_10[12]),
          run_rsci_ivld_mxwt, and_dcpl_115);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_16 | and_dcpl_24 | and_dcpl_29 | and_dcpl_36
        | and_dcpl_39 | and_dcpl_45 | and_dcpl_48 | and_dcpl_49 | and_dcpl_51 | and_dcpl_54
        | and_dcpl_56 | and_dcpl_58 | and_dcpl_60 | and_dcpl_63 | and_dcpl_65 | and_dcpl_68)
        ) begin
      VEC_LOOP_acc_10_cse_1_sva <= MUX1HOT_v_10_3_2(z_out_6, acc_4_cse_10_1, z_out_12,
          {VEC_LOOP_or_50_nl , VEC_LOOP_or_51_nl , VEC_LOOP_or_55_cse});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_142_cse | or_dcpl_66)) ) begin
      VEC_LOOP_j_1_sva_1 <= z_out_16;
    end
  end
  always @(posedge clk) begin
    if ( mux_469_nl & (~ (fsm_output[7])) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_13_psp_sva_7_6 <= z_out_17[7:6];
    end
  end
  always @(posedge clk) begin
    if ( (~(mux_471_nl | (fsm_output[1]))) & (~ (fsm_output[0])) & (fsm_output[2])
        & (~ (fsm_output[7])) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_13_psp_sva_5_0 <= z_out_17[5:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((nor_159_cse & (~((fsm_output[3]) ^ (fsm_output[1])))
        & and_dcpl_13 & (~ (fsm_output[7])) & (fsm_output[0])) | and_dcpl_153) )
        begin
      factor1_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
          and_dcpl_153);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_390_nl ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva <= COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (VEC_LOOP_acc_1_cse_10_sva_mx0c0 | and_dcpl_24
        | VEC_LOOP_acc_1_cse_10_sva_mx0c2 | and_dcpl_36 | and_dcpl_45 | and_dcpl_49
        | and_dcpl_54 | and_dcpl_58 | and_dcpl_63 | and_dcpl_68) ) begin
      VEC_LOOP_acc_1_cse_10_sva <= MUX_v_10_2_2(10'b0000000000, VEC_LOOP_VEC_LOOP_mux_2_nl,
          VEC_LOOP_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_10_0_sva_1 <= 11'b00000000000;
    end
    else if ( complete_rsci_wen_comp & (~(mux_437_nl | (fsm_output[0]))) ) begin
      VEC_LOOP_j_10_10_0_sva_1 <= z_out_20;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & VEC_LOOP_or_4_cse ) begin
      VEC_LOOP_acc_12_psp_sva <= z_out_19;
    end
  end
  assign or_277_nl = ((fsm_output[5:4]==2'b11)) | (fsm_output[6]);
  assign mux_276_nl = MUX_s_1_2_2(or_277_nl, or_415_cse, fsm_output[3]);
  assign mux_277_nl = MUX_s_1_2_2((~ or_tmp_202), mux_276_nl, fsm_output[7]);
  assign mux_278_nl = MUX_s_1_2_2(mux_277_nl, and_tmp_2, or_119_cse);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_280;
  assign mux_461_nl = MUX_s_1_2_2(not_tmp, mux_tmp, fsm_output[7]);
  assign mux_459_nl = MUX_s_1_2_2(mux_tmp, or_415_cse, fsm_output[1]);
  assign mux_460_nl = MUX_s_1_2_2(not_tmp, mux_459_nl, fsm_output[7]);
  assign mux_462_nl = MUX_s_1_2_2(mux_461_nl, mux_460_nl, fsm_output[0]);
  assign mux_286_nl = MUX_s_1_2_2((~ or_tmp_202), or_tmp_5, fsm_output[7]);
  assign and_nl = (fsm_output[7]) & mux_tmp_285;
  assign mux_287_nl = MUX_s_1_2_2(mux_286_nl, and_nl, and_176_cse);
  assign nor_42_nl = ~(and_176_cse | (fsm_output[6]));
  assign mux_289_nl = MUX_s_1_2_2(nor_42_nl, (fsm_output[6]), fsm_output[4]);
  assign and_175_nl = ((~((fsm_output[4]) | (~ (fsm_output[0])))) | (fsm_output[1]))
      & (fsm_output[6]);
  assign mux_290_nl = MUX_s_1_2_2(mux_289_nl, and_175_nl, fsm_output[3]);
  assign nor_43_nl = ~((~ (fsm_output[4])) | (fsm_output[0]) | (fsm_output[1]) |
      (~ (fsm_output[6])));
  assign mux_288_nl = MUX_s_1_2_2(nor_43_nl, (fsm_output[6]), fsm_output[3]);
  assign mux_291_nl = MUX_s_1_2_2(mux_290_nl, mux_288_nl, fsm_output[2]);
  assign mux_292_nl = MUX_s_1_2_2(mux_291_nl, (fsm_output[6]), fsm_output[5]);
  assign nor_nl = ~(((fsm_output[2]) & (fsm_output[0]) & (fsm_output[1]) & (fsm_output[4]))
      | (fsm_output[6]));
  assign mux_463_nl = MUX_s_1_2_2(nor_nl, nor_159_cse, fsm_output[3]);
  assign mux_464_nl = MUX_s_1_2_2(mux_463_nl, and_621_cse, fsm_output[5]);
  assign or_424_nl = and_176_cse | (fsm_output[4]) | (fsm_output[6]);
  assign or_423_nl = (~ (VEC_LOOP_j_10_10_0_sva_1[10])) | (fsm_output[0]) | (~ (fsm_output[1]))
      | (~ (fsm_output[4])) | (fsm_output[6]);
  assign mux_465_nl = MUX_s_1_2_2(or_424_nl, or_423_nl, fsm_output[2]);
  assign nor_158_nl = ~((fsm_output[3]) | mux_465_nl);
  assign mux_466_nl = MUX_s_1_2_2(nor_158_nl, and_621_cse, fsm_output[5]);
  assign VEC_LOOP_mux_2_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z,
      VEC_LOOP_j_1_sva_1, and_dcpl_83);
  assign VEC_LOOP_j_not_1_nl = ~ VEC_LOOP_j_1_sva_mx0c0;
  assign VEC_LOOP_or_50_nl = and_dcpl_16 | and_dcpl_68;
  assign VEC_LOOP_or_51_nl = and_dcpl_24 | and_dcpl_29 | VEC_LOOP_or_56_cse | VEC_LOOP_or_52_cse
      | VEC_LOOP_or_53_cse | VEC_LOOP_or_57_cse | VEC_LOOP_or_54_cse;
  assign or_429_nl = (fsm_output[2:1]!=2'b00);
  assign mux_467_nl = MUX_s_1_2_2((~ (fsm_output[2])), or_429_nl, fsm_output[3]);
  assign or_428_nl = (fsm_output[3:0]!=4'b1100);
  assign mux_468_nl = MUX_s_1_2_2(mux_467_nl, or_428_nl, fsm_output[5]);
  assign nor_156_nl = ~((fsm_output[4]) | mux_468_nl);
  assign nor_157_nl = ~((fsm_output[5:0]!=6'b111100));
  assign mux_469_nl = MUX_s_1_2_2(nor_156_nl, nor_157_nl, fsm_output[6]);
  assign mux_470_nl = MUX_s_1_2_2((fsm_output[3]), (~ (fsm_output[3])), fsm_output[5]);
  assign or_432_nl = (fsm_output[4]) | mux_470_nl;
  assign nand_30_nl = ~((fsm_output[5:3]==3'b111));
  assign mux_471_nl = MUX_s_1_2_2(or_432_nl, nand_30_nl, fsm_output[6]);
  assign mux_389_nl = MUX_s_1_2_2((~ or_tmp_5), or_tmp_155, fsm_output[7]);
  assign mux_388_nl = MUX_s_1_2_2((~ mux_tmp_285), or_tmp_202, fsm_output[7]);
  assign mux_390_nl = MUX_s_1_2_2(mux_389_nl, mux_388_nl, or_119_cse);
  assign VEC_LOOP_VEC_LOOP_mux_2_nl = MUX_v_10_2_2(z_out_9, (VEC_LOOP_j_10_10_0_sva_1[9:0]),
      VEC_LOOP_acc_1_cse_10_sva_mx0c2);
  assign VEC_LOOP_not_nl = ~ VEC_LOOP_acc_1_cse_10_sva_mx0c0;
  assign or_383_nl = (~ (fsm_output[3])) | (~ (fsm_output[7])) | (fsm_output[5]);
  assign mux_434_nl = MUX_s_1_2_2(mux_tmp_431, or_383_nl, fsm_output[1]);
  assign mux_435_nl = MUX_s_1_2_2(mux_434_nl, or_tmp_294, fsm_output[6]);
  assign mux_436_nl = MUX_s_1_2_2(mux_tmp_430, mux_435_nl, fsm_output[4]);
  assign or_381_nl = (~ (fsm_output[3])) | (fsm_output[7]) | (~ (fsm_output[5]));
  assign mux_432_nl = MUX_s_1_2_2(or_381_nl, mux_tmp_431, fsm_output[1]);
  assign or_382_nl = (fsm_output[6]) | mux_432_nl;
  assign mux_433_nl = MUX_s_1_2_2(or_382_nl, mux_tmp_430, fsm_output[4]);
  assign mux_437_nl = MUX_s_1_2_2(mux_436_nl, mux_433_nl, fsm_output[2]);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl = (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[9])
      & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_mux1h_147_nl = MUX1HOT_s_1_3_2((COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1[8]),
      (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[8]), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[8]),
      {and_dcpl_161 , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_itm});
  assign COMP_LOOP_twiddle_f_and_14_nl = COMP_LOOP_twiddle_f_mux1h_147_nl & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_mux1h_148_nl = MUX1HOT_v_8_4_2((COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1[7:0]),
      (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[7:0]), ({COMP_LOOP_5_twiddle_f_lshift_ncse_sva_7_4
      , COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0}), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[7:0]),
      {and_dcpl_161 , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_16_itm
      , COMP_LOOP_twiddle_f_or_itm});
  assign COMP_LOOP_twiddle_f_and_15_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_5_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[5]),
      (COMP_LOOP_k_10_4_sva_5_0[4]), COMP_LOOP_twiddle_f_or_ssc);
  assign COMP_LOOP_twiddle_f_and_16_nl = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_5_nl
      & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_or_28_nl = and_dcpl_161 | and_dcpl_179 | and_dcpl_186;
  assign COMP_LOOP_twiddle_f_mux1h_149_nl = MUX1HOT_v_4_3_2((COMP_LOOP_k_10_4_sva_5_0[4:1]),
      (COMP_LOOP_k_10_4_sva_5_0[3:0]), (COMP_LOOP_k_10_4_sva_5_0[5:2]), {COMP_LOOP_twiddle_f_or_28_nl
      , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_16_itm});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[0]),
      (COMP_LOOP_k_10_4_sva_5_0[1]), COMP_LOOP_twiddle_f_or_16_itm);
  assign COMP_LOOP_twiddle_f_or_29_nl = (COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl
      & (~(and_dcpl_166 | and_dcpl_176 | and_dcpl_180))) | and_dcpl_184 | and_dcpl_189
      | and_dcpl_193 | and_dcpl_196;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl = ((COMP_LOOP_k_10_4_sva_5_0[0])
      & (~(and_dcpl_161 | and_dcpl_166 | and_dcpl_179 | and_dcpl_184 | and_dcpl_189)))
      | and_dcpl_176 | and_dcpl_180 | and_dcpl_186 | and_dcpl_193 | and_dcpl_196;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_4_nl = (~(and_dcpl_161 | and_dcpl_171
      | and_dcpl_176 | and_dcpl_184 | and_dcpl_186 | and_dcpl_193)) | and_dcpl_166
      | and_dcpl_179 | and_dcpl_180 | and_dcpl_189 | and_dcpl_191 | and_dcpl_196;
  assign nl_z_out = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl , COMP_LOOP_twiddle_f_and_14_nl
      , COMP_LOOP_twiddle_f_mux1h_148_nl}) * ({COMP_LOOP_twiddle_f_and_15_nl , COMP_LOOP_twiddle_f_and_16_nl
      , COMP_LOOP_twiddle_f_mux1h_149_nl , COMP_LOOP_twiddle_f_or_29_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_4_nl , 1'b1});
  assign z_out = nl_z_out[9:0];
  assign COMP_LOOP_twiddle_f_mux_7_nl = MUX_v_9_2_2(({2'b00 , COMP_LOOP_9_twiddle_f_lshift_itm}),
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva, and_dcpl_209);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl = MUX_v_2_2_2(2'b00, (COMP_LOOP_k_10_4_sva_5_0[5:4]),
      and_dcpl_209);
  assign COMP_LOOP_twiddle_f_mux_8_nl = MUX_v_4_2_2((COMP_LOOP_k_10_4_sva_5_0[5:2]),
      (COMP_LOOP_k_10_4_sva_5_0[3:0]), and_dcpl_209);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl = MUX_v_2_2_2((COMP_LOOP_k_10_4_sva_5_0[1:0]),
      2'b11, and_dcpl_209);
  assign nl_z_out_1_8_0 = COMP_LOOP_twiddle_f_mux_7_nl * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl
      , COMP_LOOP_twiddle_f_mux_8_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl
      , 1'b1});
  assign z_out_1_8_0 = nl_z_out_1_8_0[8:0];
  assign STAGE_LOOP_mux_4_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (~ STAGE_LOOP_i_3_0_sva),
      and_dcpl_245);
  assign nl_z_out_4 = STAGE_LOOP_mux_4_nl + ({and_dcpl_245 , 1'b0 , and_dcpl_245
      , 1'b1});
  assign z_out_4 = nl_z_out_4[3:0];
  assign VEC_LOOP_mux_19_nl = MUX_v_22_2_2((z_out_16[31:10]), ({11'b00000000000 ,
      z_out_18 , 4'b0000}), and_302_cse);
  assign VEC_LOOP_or_77_nl = (~(and_dcpl_278 & and_dcpl_11 & and_dcpl_156 & (fsm_output[2])
      & (~ (fsm_output[0])))) | and_302_cse;
  assign VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl = ~(MUX_v_10_2_2(10'b0000000000, (STAGE_LOOP_lshift_psp_sva[10:1]),
      and_302_cse));
  assign nl_acc_1_nl = conv_u2u_23_24({VEC_LOOP_mux_19_nl , VEC_LOOP_or_77_nl}) +
      conv_s2u_12_24({1'b1 , VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[23:0];
  assign z_out_5_22_10 = readslicef_24_13_11(acc_1_nl);
  assign VEC_LOOP_mux_20_nl = MUX_v_10_2_2(({(z_out_18[5:0]) , (STAGE_LOOP_lshift_psp_sva[4:1])}),
      z_out_7, and_dcpl_273);
  assign VEC_LOOP_mux_21_nl = MUX_v_10_2_2((VEC_LOOP_j_1_sva[9:0]), VEC_LOOP_acc_1_cse_10_sva,
      and_dcpl_273);
  assign nl_z_out_6 = VEC_LOOP_mux_20_nl + VEC_LOOP_mux_21_nl;
  assign z_out_6 = nl_z_out_6[9:0];
  assign and_622_nl = and_dcpl_279 & and_dcpl_187;
  assign and_623_nl = and_dcpl_279 & and_dcpl_283;
  assign and_624_nl = and_dcpl_288 & and_dcpl_285;
  assign and_625_nl = and_dcpl_287 & and_dcpl_18 & and_dcpl_156 & and_dcpl;
  assign and_626_nl = and_dcpl_288 & and_dcpl_163;
  assign and_627_nl = and_dcpl_298 & and_dcpl_11 & and_dcpl_297;
  assign and_628_nl = and_dcpl_301 & and_dcpl_285;
  assign and_629_nl = and_dcpl_301 & and_dcpl_163;
  assign and_630_nl = and_dcpl_305 & and_dcpl_297;
  assign and_631_nl = and_dcpl_304 & and_dcpl_11 & and_dcpl_181;
  assign and_632_nl = and_dcpl_305 & and_dcpl_177 & and_dcpl;
  assign and_633_nl = and_dcpl_313 & and_dcpl_187;
  assign and_634_nl = and_dcpl_313 & and_dcpl_283;
  assign VEC_LOOP_mux1h_34_nl = MUX1HOT_v_4_13_2(4'b0001, 4'b0010, 4'b0011, 4'b0100,
      4'b0101, 4'b0110, 4'b0111, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110,
      {and_622_nl , and_623_nl , and_624_nl , and_625_nl , and_626_nl , and_627_nl
      , and_628_nl , and_629_nl , and_630_nl , and_631_nl , and_632_nl , and_633_nl
      , and_634_nl});
  assign VEC_LOOP_or_78_nl = MUX_v_4_2_2(VEC_LOOP_mux1h_34_nl, 4'b1111, and_361_cse);
  assign nl_z_out_7 = ({COMP_LOOP_k_10_4_sva_5_0 , VEC_LOOP_or_78_nl}) + (STAGE_LOOP_lshift_psp_sva[10:1]);
  assign z_out_7 = nl_z_out_7[9:0];
  assign nl_acc_4_cse_10_1 = z_out_7 + VEC_LOOP_acc_1_cse_10_sva;
  assign acc_4_cse_10_1 = nl_acc_4_cse_10_1[9:0];
  assign and_635_nl = and_dcpl_341 & and_dcpl_285;
  assign and_636_nl = and_dcpl_341 & and_dcpl_163;
  assign and_637_nl = and_dcpl_347 & and_dcpl_285;
  assign and_638_nl = and_dcpl_347 & and_dcpl_163;
  assign and_639_nl = (fsm_output[6:5]==2'b11) & and_dcpl_11 & and_dcpl_181;
  assign and_640_nl = and_dcpl_278 & (fsm_output[7]) & (~ (fsm_output[3])) & and_dcpl_187;
  assign VEC_LOOP_mux1h_35_nl = MUX1HOT_v_3_6_2(3'b110, 3'b101, 3'b100, 3'b011, 3'b010,
      3'b001, {and_635_nl , and_636_nl , and_637_nl , and_638_nl , and_639_nl , and_640_nl});
  assign and_641_nl = and_dcpl_278 & and_dcpl_18 & and_dcpl_187;
  assign VEC_LOOP_nor_17_nl = ~(MUX_v_3_2_2(VEC_LOOP_mux1h_35_nl, 3'b111, and_641_nl));
  assign VEC_LOOP_or_79_nl = MUX_v_3_2_2(VEC_LOOP_nor_17_nl, 3'b111, and_361_cse);
  assign nl_z_out_9 = VEC_LOOP_acc_1_cse_10_sva + ({COMP_LOOP_k_10_4_sva_5_0 , VEC_LOOP_or_79_nl
      , 1'b1});
  assign z_out_9 = nl_z_out_9[9:0];
  assign and_642_nl = (~ (fsm_output[7])) & (fsm_output[6]) & (fsm_output[5]) & (fsm_output[3])
      & and_dcpl_156 & and_dcpl_167;
  assign VEC_LOOP_mux_22_nl = MUX_v_10_2_2(({z_out_18 , (STAGE_LOOP_lshift_psp_sva[3:1])}),
      z_out_7, and_642_nl);
  assign nl_z_out_12 = VEC_LOOP_mux_22_nl + VEC_LOOP_acc_1_cse_10_sva;
  assign z_out_12 = nl_z_out_12[9:0];
  assign VEC_LOOP_mux_23_nl = MUX_v_32_2_2(VEC_LOOP_j_1_sva, factor1_1_sva, and_dcpl_445);
  assign VEC_LOOP_or_80_nl = (~(and_dcpl_159 & and_dcpl_164 & and_dcpl_156 & (fsm_output[2])
      & (~ (fsm_output[0])))) | and_dcpl_445;
  assign VEC_LOOP_mux_24_nl = MUX_v_32_2_2(({21'b000000000000000000000 , STAGE_LOOP_lshift_psp_sva}),
      (~ COMP_LOOP_1_mult_cmp_return_rsc_z), and_dcpl_445);
  assign nl_acc_12_nl = ({VEC_LOOP_mux_23_nl , VEC_LOOP_or_80_nl}) + ({VEC_LOOP_mux_24_nl
      , 1'b1});
  assign acc_12_nl = nl_acc_12_nl[32:0];
  assign z_out_16 = readslicef_33_32_1(acc_12_nl);
  assign VEC_LOOP_mux1h_36_nl = MUX1HOT_v_8_5_2(({2'b00 , (VEC_LOOP_j_1_sva[9:4])}),
      ({1'b0 , (VEC_LOOP_acc_1_cse_10_sva[9:3])}), (VEC_LOOP_acc_1_cse_10_sva[9:2]),
      ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[10:5]))}), ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:4]))}),
      {and_dcpl_452 , and_dcpl_457 , VEC_LOOP_or_61_itm , and_dcpl_469 , and_dcpl_472});
  assign VEC_LOOP_or_81_nl = (~(and_dcpl_452 | and_dcpl_457 | and_dcpl_461 | and_dcpl_464))
      | and_dcpl_469 | and_dcpl_472;
  assign VEC_LOOP_VEC_LOOP_and_3_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & (~(and_dcpl_452
      | and_dcpl_457 | and_dcpl_469 | and_dcpl_472));
  assign VEC_LOOP_VEC_LOOP_mux_7_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[5]),
      (COMP_LOOP_k_10_4_sva_5_0[4]), VEC_LOOP_or_61_itm);
  assign VEC_LOOP_and_16_nl = VEC_LOOP_VEC_LOOP_mux_7_nl & (~(and_dcpl_452 | and_dcpl_469));
  assign VEC_LOOP_or_82_nl = and_dcpl_452 | and_dcpl_469;
  assign VEC_LOOP_mux1h_37_nl = MUX1HOT_v_4_3_2((COMP_LOOP_k_10_4_sva_5_0[5:2]),
      (COMP_LOOP_k_10_4_sva_5_0[4:1]), (COMP_LOOP_k_10_4_sva_5_0[3:0]), {VEC_LOOP_or_82_nl
      , VEC_LOOP_or_68_itm , VEC_LOOP_or_61_itm});
  assign VEC_LOOP_mux_25_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[1]), (COMP_LOOP_k_10_4_sva_5_0[0]),
      VEC_LOOP_or_68_itm);
  assign VEC_LOOP_VEC_LOOP_or_11_nl = (VEC_LOOP_mux_25_nl & (~ and_dcpl_461)) | and_dcpl_464;
  assign VEC_LOOP_VEC_LOOP_or_12_nl = ((COMP_LOOP_k_10_4_sva_5_0[0]) & (~ and_dcpl_472))
      | and_dcpl_457 | and_dcpl_461 | and_dcpl_464;
  assign nl_acc_13_nl = ({VEC_LOOP_mux1h_36_nl , VEC_LOOP_or_81_nl}) + ({VEC_LOOP_VEC_LOOP_and_3_nl
      , VEC_LOOP_and_16_nl , VEC_LOOP_mux1h_37_nl , VEC_LOOP_VEC_LOOP_or_11_nl ,
      VEC_LOOP_VEC_LOOP_or_12_nl , 1'b1});
  assign acc_13_nl = nl_acc_13_nl[8:0];
  assign z_out_17 = readslicef_9_8_1(acc_13_nl);
  assign VEC_LOOP_VEC_LOOP_and_4_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & (~(and_dcpl_479
      | and_302_cse));
  assign VEC_LOOP_VEC_LOOP_mux_8_nl = MUX_v_6_2_2(COMP_LOOP_k_10_4_sva_5_0, ({(COMP_LOOP_k_10_4_sva_5_0[4:0])
      , 1'b1}), and_dcpl_484);
  assign VEC_LOOP_mux1h_38_nl = MUX1HOT_v_7_3_2(({1'b0 , (STAGE_LOOP_lshift_psp_sva[10:5])}),
      (STAGE_LOOP_lshift_psp_sva[10:4]), 7'b0000001, {and_dcpl_479 , and_dcpl_484
      , and_302_cse});
  assign nl_z_out_18 = ({VEC_LOOP_VEC_LOOP_and_4_nl , VEC_LOOP_VEC_LOOP_mux_8_nl})
      + VEC_LOOP_mux1h_38_nl;
  assign z_out_18 = nl_z_out_18[6:0];
  assign VEC_LOOP_VEC_LOOP_or_13_nl = ((VEC_LOOP_acc_1_cse_10_sva[9]) & (~ and_dcpl_515))
      | and_dcpl_519 | and_dcpl_522;
  assign VEC_LOOP_mux1h_39_nl = MUX1HOT_v_8_3_2((VEC_LOOP_acc_1_cse_10_sva[8:1]),
      ({4'b0001 , (~ z_out_4)}), (~ (STAGE_LOOP_lshift_psp_sva[10:3])), {VEC_LOOP_or_63_itm
      , and_dcpl_515 , VEC_LOOP_or_71_itm});
  assign VEC_LOOP_or_83_nl = (~(and_dcpl_498 | and_dcpl_504 | and_dcpl_507 | and_dcpl_510
      | and_dcpl_515)) | and_dcpl_519 | and_dcpl_522;
  assign VEC_LOOP_and_20_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & (~(and_dcpl_515 | and_dcpl_519
      | and_dcpl_522));
  assign VEC_LOOP_mux1h_40_nl = MUX1HOT_v_5_3_2((COMP_LOOP_k_10_4_sva_5_0[4:0]),
      5'b00001, (COMP_LOOP_k_10_4_sva_5_0[5:1]), {VEC_LOOP_or_63_itm , and_dcpl_515
      , VEC_LOOP_or_71_itm});
  assign VEC_LOOP_VEC_LOOP_or_14_nl = ((COMP_LOOP_k_10_4_sva_5_0[0]) & (~(and_dcpl_498
      | and_dcpl_504 | and_dcpl_515))) | and_dcpl_507 | and_dcpl_510;
  assign VEC_LOOP_VEC_LOOP_or_15_nl = (~(and_dcpl_498 | and_dcpl_507 | and_dcpl_519))
      | and_dcpl_504 | and_dcpl_510 | and_dcpl_515 | and_dcpl_522;
  assign VEC_LOOP_VEC_LOOP_or_16_nl = (~(and_dcpl_519 | and_dcpl_522)) | and_dcpl_498
      | and_dcpl_504 | and_dcpl_507 | and_dcpl_510 | and_dcpl_515;
  assign nl_acc_15_nl = ({VEC_LOOP_VEC_LOOP_or_13_nl , VEC_LOOP_mux1h_39_nl , VEC_LOOP_or_83_nl})
      + ({VEC_LOOP_and_20_nl , VEC_LOOP_mux1h_40_nl , VEC_LOOP_VEC_LOOP_or_14_nl
      , VEC_LOOP_VEC_LOOP_or_15_nl , VEC_LOOP_VEC_LOOP_or_16_nl , 1'b1});
  assign acc_15_nl = nl_acc_15_nl[9:0];
  assign z_out_19 = readslicef_10_9_1(acc_15_nl);
  assign VEC_LOOP_VEC_LOOP_or_17_nl = (STAGE_LOOP_lshift_psp_sva[10]) | and_dcpl_530
      | and_dcpl_535 | and_dcpl_541 | and_dcpl_546 | and_dcpl_549 | and_dcpl_551
      | and_dcpl_555 | and_dcpl_557 | and_dcpl_559 | and_dcpl_561;
  assign VEC_LOOP_VEC_LOOP_mux_9_nl = MUX_v_10_2_2((STAGE_LOOP_lshift_psp_sva[9:0]),
      (~ (STAGE_LOOP_lshift_psp_sva[10:1])), VEC_LOOP_or_75_itm);
  assign nand_33_nl = ~((fsm_output[3]) & (~ mux_tmp_448));
  assign mux_475_nl = MUX_s_1_2_2(or_tmp_313, (~ and_tmp), fsm_output[3]);
  assign mux_474_nl = MUX_s_1_2_2(nand_33_nl, mux_475_nl, fsm_output[6]);
  assign or_435_nl = (fsm_output[1]) | (fsm_output[4]) | (~ (fsm_output[2]));
  assign mux_477_nl = MUX_s_1_2_2((~ and_tmp), or_435_nl, fsm_output[3]);
  assign mux_478_nl = MUX_s_1_2_2(or_tmp_309, or_tmp_313, fsm_output[3]);
  assign mux_476_nl = MUX_s_1_2_2(mux_477_nl, mux_478_nl, fsm_output[6]);
  assign mux_473_nl = MUX_s_1_2_2(mux_474_nl, mux_476_nl, fsm_output[5]);
  assign mux_479_nl = MUX_s_1_2_2(mux_tmp_448, or_tmp_309, fsm_output[3]);
  assign or_436_nl = (fsm_output[6:5]!=2'b00) | mux_479_nl;
  assign mux_472_nl = MUX_s_1_2_2(mux_473_nl, or_436_nl, fsm_output[7]);
  assign VEC_LOOP_or_84_nl = mux_472_nl | (fsm_output[0]) | and_dcpl_530 | and_dcpl_535
      | and_dcpl_541 | and_dcpl_546 | and_dcpl_549 | and_dcpl_551 | and_dcpl_555
      | and_dcpl_557 | and_dcpl_559 | and_dcpl_561;
  assign VEC_LOOP_VEC_LOOP_mux_10_nl = MUX_v_6_2_2((VEC_LOOP_acc_1_cse_10_sva[9:4]),
      COMP_LOOP_k_10_4_sva_5_0, VEC_LOOP_or_75_itm);
  assign VEC_LOOP_VEC_LOOP_or_18_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_dcpl_541
      | and_dcpl_546 | and_dcpl_549 | and_dcpl_551))) | and_dcpl_530 | and_dcpl_535
      | and_dcpl_555 | and_dcpl_557 | and_dcpl_559 | and_dcpl_561;
  assign VEC_LOOP_VEC_LOOP_or_19_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_dcpl_551
      | and_dcpl_557 | and_dcpl_559 | and_dcpl_561))) | and_dcpl_530 | and_dcpl_535
      | and_dcpl_541 | and_dcpl_546 | and_dcpl_549 | and_dcpl_555;
  assign VEC_LOOP_VEC_LOOP_or_20_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_dcpl_535
      | and_dcpl_541 | and_dcpl_546 | and_dcpl_555 | and_dcpl_557 | and_dcpl_561)))
      | and_dcpl_530 | and_dcpl_549 | and_dcpl_551 | and_dcpl_559;
  assign VEC_LOOP_VEC_LOOP_or_21_nl = ((VEC_LOOP_acc_1_cse_10_sva[0]) & (~(and_dcpl_530
      | and_dcpl_546 | and_dcpl_549 | and_dcpl_551 | and_dcpl_555 | and_dcpl_559
      | and_dcpl_561))) | and_dcpl_535 | and_dcpl_541 | and_dcpl_557;
  assign nl_acc_16_nl = ({VEC_LOOP_VEC_LOOP_or_17_nl , VEC_LOOP_VEC_LOOP_mux_9_nl
      , VEC_LOOP_or_84_nl}) + conv_u2u_11_12({VEC_LOOP_VEC_LOOP_mux_10_nl , VEC_LOOP_VEC_LOOP_or_18_nl
      , VEC_LOOP_VEC_LOOP_or_19_nl , VEC_LOOP_VEC_LOOP_or_20_nl , VEC_LOOP_VEC_LOOP_or_21_nl
      , 1'b1});
  assign acc_16_nl = nl_acc_16_nl[11:0];
  assign z_out_20 = readslicef_12_11_1(acc_16_nl);

  function automatic [0:0] MUX1HOT_s_1_10_2;
    input [0:0] input_9;
    input [0:0] input_8;
    input [0:0] input_7;
    input [0:0] input_6;
    input [0:0] input_5;
    input [0:0] input_4;
    input [0:0] input_3;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [9:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    result = result | ( input_3 & {1{sel[3]}});
    result = result | ( input_4 & {1{sel[4]}});
    result = result | ( input_5 & {1{sel[5]}});
    result = result | ( input_6 & {1{sel[6]}});
    result = result | ( input_7 & {1{sel[7]}});
    result = result | ( input_8 & {1{sel[8]}});
    result = result | ( input_9 & {1{sel[9]}});
    MUX1HOT_s_1_10_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_3_2;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [2:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    MUX1HOT_s_1_3_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_4_2;
    input [0:0] input_3;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [3:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    result = result | ( input_3 & {1{sel[3]}});
    MUX1HOT_s_1_4_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_5_2;
    input [0:0] input_4;
    input [0:0] input_3;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [4:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    result = result | ( input_3 & {1{sel[3]}});
    result = result | ( input_4 & {1{sel[4]}});
    MUX1HOT_s_1_5_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_6_2;
    input [0:0] input_5;
    input [0:0] input_4;
    input [0:0] input_3;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [5:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    result = result | ( input_3 & {1{sel[3]}});
    result = result | ( input_4 & {1{sel[4]}});
    result = result | ( input_5 & {1{sel[5]}});
    MUX1HOT_s_1_6_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_7_2;
    input [0:0] input_6;
    input [0:0] input_5;
    input [0:0] input_4;
    input [0:0] input_3;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [6:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    result = result | ( input_3 & {1{sel[3]}});
    result = result | ( input_4 & {1{sel[4]}});
    result = result | ( input_5 & {1{sel[5]}});
    result = result | ( input_6 & {1{sel[6]}});
    MUX1HOT_s_1_7_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_8_2;
    input [0:0] input_7;
    input [0:0] input_6;
    input [0:0] input_5;
    input [0:0] input_4;
    input [0:0] input_3;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [7:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    result = result | ( input_3 & {1{sel[3]}});
    result = result | ( input_4 & {1{sel[4]}});
    result = result | ( input_5 & {1{sel[5]}});
    result = result | ( input_6 & {1{sel[6]}});
    result = result | ( input_7 & {1{sel[7]}});
    MUX1HOT_s_1_8_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_9_2;
    input [0:0] input_8;
    input [0:0] input_7;
    input [0:0] input_6;
    input [0:0] input_5;
    input [0:0] input_4;
    input [0:0] input_3;
    input [0:0] input_2;
    input [0:0] input_1;
    input [0:0] input_0;
    input [8:0] sel;
    reg [0:0] result;
  begin
    result = input_0 & {1{sel[0]}};
    result = result | ( input_1 & {1{sel[1]}});
    result = result | ( input_2 & {1{sel[2]}});
    result = result | ( input_3 & {1{sel[3]}});
    result = result | ( input_4 & {1{sel[4]}});
    result = result | ( input_5 & {1{sel[5]}});
    result = result | ( input_6 & {1{sel[6]}});
    result = result | ( input_7 & {1{sel[7]}});
    result = result | ( input_8 & {1{sel[8]}});
    MUX1HOT_s_1_9_2 = result;
  end
  endfunction


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


  function automatic [2:0] MUX1HOT_v_3_6_2;
    input [2:0] input_5;
    input [2:0] input_4;
    input [2:0] input_3;
    input [2:0] input_2;
    input [2:0] input_1;
    input [2:0] input_0;
    input [5:0] sel;
    reg [2:0] result;
  begin
    result = input_0 & {3{sel[0]}};
    result = result | ( input_1 & {3{sel[1]}});
    result = result | ( input_2 & {3{sel[2]}});
    result = result | ( input_3 & {3{sel[3]}});
    result = result | ( input_4 & {3{sel[4]}});
    result = result | ( input_5 & {3{sel[5]}});
    MUX1HOT_v_3_6_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_13_2;
    input [3:0] input_12;
    input [3:0] input_11;
    input [3:0] input_10;
    input [3:0] input_9;
    input [3:0] input_8;
    input [3:0] input_7;
    input [3:0] input_6;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [12:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | ( input_1 & {4{sel[1]}});
    result = result | ( input_2 & {4{sel[2]}});
    result = result | ( input_3 & {4{sel[3]}});
    result = result | ( input_4 & {4{sel[4]}});
    result = result | ( input_5 & {4{sel[5]}});
    result = result | ( input_6 & {4{sel[6]}});
    result = result | ( input_7 & {4{sel[7]}});
    result = result | ( input_8 & {4{sel[8]}});
    result = result | ( input_9 & {4{sel[9]}});
    result = result | ( input_10 & {4{sel[10]}});
    result = result | ( input_11 & {4{sel[11]}});
    result = result | ( input_12 & {4{sel[12]}});
    MUX1HOT_v_4_13_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_3_2;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [2:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | ( input_1 & {4{sel[1]}});
    result = result | ( input_2 & {4{sel[2]}});
    MUX1HOT_v_4_3_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_3_2;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [2:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | ( input_1 & {5{sel[1]}});
    result = result | ( input_2 & {5{sel[2]}});
    MUX1HOT_v_5_3_2 = result;
  end
  endfunction


  function automatic [5:0] MUX1HOT_v_6_11_2;
    input [5:0] input_10;
    input [5:0] input_9;
    input [5:0] input_8;
    input [5:0] input_7;
    input [5:0] input_6;
    input [5:0] input_5;
    input [5:0] input_4;
    input [5:0] input_3;
    input [5:0] input_2;
    input [5:0] input_1;
    input [5:0] input_0;
    input [10:0] sel;
    reg [5:0] result;
  begin
    result = input_0 & {6{sel[0]}};
    result = result | ( input_1 & {6{sel[1]}});
    result = result | ( input_2 & {6{sel[2]}});
    result = result | ( input_3 & {6{sel[3]}});
    result = result | ( input_4 & {6{sel[4]}});
    result = result | ( input_5 & {6{sel[5]}});
    result = result | ( input_6 & {6{sel[6]}});
    result = result | ( input_7 & {6{sel[7]}});
    result = result | ( input_8 & {6{sel[8]}});
    result = result | ( input_9 & {6{sel[9]}});
    result = result | ( input_10 & {6{sel[10]}});
    MUX1HOT_v_6_11_2 = result;
  end
  endfunction


  function automatic [5:0] MUX1HOT_v_6_6_2;
    input [5:0] input_5;
    input [5:0] input_4;
    input [5:0] input_3;
    input [5:0] input_2;
    input [5:0] input_1;
    input [5:0] input_0;
    input [5:0] sel;
    reg [5:0] result;
  begin
    result = input_0 & {6{sel[0]}};
    result = result | ( input_1 & {6{sel[1]}});
    result = result | ( input_2 & {6{sel[2]}});
    result = result | ( input_3 & {6{sel[3]}});
    result = result | ( input_4 & {6{sel[4]}});
    result = result | ( input_5 & {6{sel[5]}});
    MUX1HOT_v_6_6_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_3_2;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [2:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | ( input_1 & {7{sel[1]}});
    result = result | ( input_2 & {7{sel[2]}});
    MUX1HOT_v_7_3_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_6_2;
    input [6:0] input_5;
    input [6:0] input_4;
    input [6:0] input_3;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [5:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | ( input_1 & {7{sel[1]}});
    result = result | ( input_2 & {7{sel[2]}});
    result = result | ( input_3 & {7{sel[3]}});
    result = result | ( input_4 & {7{sel[4]}});
    result = result | ( input_5 & {7{sel[5]}});
    MUX1HOT_v_7_6_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_3_2;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [2:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    MUX1HOT_v_8_3_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_4_2;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [3:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    result = result | ( input_3 & {8{sel[3]}});
    MUX1HOT_v_8_4_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_5_2;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [4:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    result = result | ( input_3 & {8{sel[3]}});
    result = result | ( input_4 & {8{sel[4]}});
    MUX1HOT_v_8_5_2 = result;
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


  function automatic [21:0] MUX_v_22_2_2;
    input [21:0] input_0;
    input [21:0] input_1;
    input [0:0] sel;
    reg [21:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_22_2_2 = result;
  end
  endfunction


  function automatic [1:0] MUX_v_2_2_2;
    input [1:0] input_0;
    input [1:0] input_1;
    input [0:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_2_2_2 = result;
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


  function automatic [2:0] MUX_v_3_2_2;
    input [2:0] input_0;
    input [2:0] input_1;
    input [0:0] sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_3_2_2 = result;
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


  function automatic [5:0] MUX_v_6_2_2;
    input [5:0] input_0;
    input [5:0] input_1;
    input [0:0] sel;
    reg [5:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_6_2_2 = result;
  end
  endfunction


  function automatic [6:0] MUX_v_7_2_2;
    input [6:0] input_0;
    input [6:0] input_1;
    input [0:0] sel;
    reg [6:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_7_2_2 = result;
  end
  endfunction


  function automatic [7:0] MUX_v_8_2_2;
    input [7:0] input_0;
    input [7:0] input_1;
    input [0:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function automatic [8:0] MUX_v_9_2_2;
    input [8:0] input_0;
    input [8:0] input_1;
    input [0:0] sel;
    reg [8:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_9_2_2 = result;
  end
  endfunction


  function automatic [8:0] readslicef_10_9_1;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_10_9_1 = tmp[8:0];
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


  function automatic [10:0] readslicef_12_11_1;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_12_11_1 = tmp[10:0];
  end
  endfunction


  function automatic [12:0] readslicef_24_13_11;
    input [23:0] vector;
    reg [23:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_24_13_11 = tmp[12:0];
  end
  endfunction


  function automatic [31:0] readslicef_33_32_1;
    input [32:0] vector;
    reg [32:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_33_32_1 = tmp[31:0];
  end
  endfunction


  function automatic [7:0] readslicef_9_8_1;
    input [8:0] vector;
    reg [8:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_9_8_1 = tmp[7:0];
  end
  endfunction


  function automatic [23:0] conv_s2u_12_24 ;
    input [11:0]  vector ;
  begin
    conv_s2u_12_24 = {{12{vector[11]}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 =  {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function automatic [23:0] conv_u2u_23_24 ;
    input [22:0]  vector ;
  begin
    conv_u2u_23_24 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp (
  clk, rst, run_rsc_rdy, run_rsc_vld, vec_rsc_adra, vec_rsc_da, vec_rsc_wea, vec_rsc_qa,
      vec_rsc_adrb, vec_rsc_db, vec_rsc_web, vec_rsc_qb, vec_rsc_triosy_lz, p_rsc_dat,
      p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz, twiddle_rsc_adra, twiddle_rsc_da,
      twiddle_rsc_wea, twiddle_rsc_qa, twiddle_rsc_adrb, twiddle_rsc_db, twiddle_rsc_web,
      twiddle_rsc_qb, twiddle_rsc_triosy_lz, twiddle_h_rsc_adra, twiddle_h_rsc_da,
      twiddle_h_rsc_wea, twiddle_h_rsc_qa, twiddle_h_rsc_adrb, twiddle_h_rsc_db,
      twiddle_h_rsc_web, twiddle_h_rsc_qb, twiddle_h_rsc_triosy_lz, complete_rsc_rdy,
      complete_rsc_vld
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output [9:0] vec_rsc_adra;
  output [31:0] vec_rsc_da;
  output vec_rsc_wea;
  input [31:0] vec_rsc_qa;
  output [9:0] vec_rsc_adrb;
  output [31:0] vec_rsc_db;
  output vec_rsc_web;
  input [31:0] vec_rsc_qb;
  output vec_rsc_triosy_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [31:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [9:0] twiddle_rsc_adra;
  output [31:0] twiddle_rsc_da;
  output twiddle_rsc_wea;
  input [31:0] twiddle_rsc_qa;
  output [9:0] twiddle_rsc_adrb;
  output [31:0] twiddle_rsc_db;
  output twiddle_rsc_web;
  input [31:0] twiddle_rsc_qb;
  output twiddle_rsc_triosy_lz;
  output [9:0] twiddle_h_rsc_adra;
  output [31:0] twiddle_h_rsc_da;
  output twiddle_h_rsc_wea;
  input [31:0] twiddle_h_rsc_qa;
  output [9:0] twiddle_h_rsc_adrb;
  output [31:0] twiddle_h_rsc_db;
  output twiddle_h_rsc_web;
  input [31:0] twiddle_h_rsc_qb;
  output twiddle_h_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;


  // Interconnect Declarations
  wire [19:0] vec_rsci_adra_d;
  wire [31:0] vec_rsci_da_d;
  wire [63:0] vec_rsci_qa_d;
  wire [1:0] vec_rsci_wea_d;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [19:0] twiddle_rsci_adra_d;
  wire [63:0] twiddle_rsci_qa_d;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [19:0] twiddle_h_rsci_adra_d;
  wire [63:0] twiddle_h_rsci_qa_d;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations for Component Instantiations 
  wire [63:0] nl_vec_rsci_da_d;
  assign nl_vec_rsci_da_d = {32'b00000000000000000000000000000000 , vec_rsci_da_d};
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_10_32_1024_1024_32_1_gen
      vec_rsci (
      .qb(vec_rsc_qb),
      .web(vec_rsc_web),
      .db(vec_rsc_db),
      .adrb(vec_rsc_adrb),
      .qa(vec_rsc_qa),
      .wea(vec_rsc_wea),
      .da(vec_rsc_da),
      .adra(vec_rsc_adra),
      .adra_d(vec_rsci_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(nl_vec_rsci_da_d[63:0]),
      .qa_d(vec_rsci_qa_d),
      .wea_d(vec_rsci_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_10_32_1024_1024_32_1_gen
      twiddle_rsci (
      .qb(twiddle_rsc_qb),
      .web(twiddle_rsc_web),
      .db(twiddle_rsc_db),
      .adrb(twiddle_rsc_adrb),
      .qa(twiddle_rsc_qa),
      .wea(twiddle_rsc_wea),
      .da(twiddle_rsc_da),
      .adra(twiddle_rsc_adra),
      .adra_d(twiddle_rsci_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .qa_d(twiddle_rsci_qa_d),
      .wea_d(2'b00),
      .rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(2'b00)
    );
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_10_32_1024_1024_32_1_gen
      twiddle_h_rsci (
      .qb(twiddle_h_rsc_qb),
      .web(twiddle_h_rsc_web),
      .db(twiddle_h_rsc_db),
      .adrb(twiddle_h_rsc_adrb),
      .qa(twiddle_h_rsc_qa),
      .wea(twiddle_h_rsc_wea),
      .da(twiddle_h_rsc_da),
      .adra(twiddle_h_rsc_adra),
      .adra_d(twiddle_h_rsci_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .qa_d(twiddle_h_rsci_qa_d),
      .wea_d(2'b00),
      .rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(2'b00)
    );
  inPlaceNTT_DIT_precomp_core inPlaceNTT_DIT_precomp_core_inst (
      .clk(clk),
      .rst(rst),
      .run_rsc_rdy(run_rsc_rdy),
      .run_rsc_vld(run_rsc_vld),
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .twiddle_h_rsc_triosy_lz(twiddle_h_rsc_triosy_lz),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld),
      .vec_rsci_adra_d(vec_rsci_adra_d),
      .vec_rsci_da_d(vec_rsci_da_d),
      .vec_rsci_qa_d(vec_rsci_qa_d),
      .vec_rsci_wea_d(vec_rsci_wea_d),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d),
      .twiddle_rsci_adra_d(twiddle_rsci_adra_d),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsci_adra_d(twiddle_h_rsci_adra_d),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d)
    );
endmodule



