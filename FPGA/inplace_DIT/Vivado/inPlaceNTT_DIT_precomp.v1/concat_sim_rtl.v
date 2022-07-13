
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

//------> ../td_ccore_solutions/modulo_sub_9cc7439c5775bc162fe17431e78231ea6384_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Jun  9 11:07:43 2022
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




//------> ../td_ccore_solutions/modulo_add_0c8c8b8581199e9d1dc87e75ec5d104e605c_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Jun  9 11:07:45 2022
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
  wire[32:0] acc_nl;
  wire[33:0] nl_acc_nl;

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
      return_rsci_d <= MUX_v_32_2_2(base_rsci_idat, qif_acc_nl, readslicef_33_1_32(acc_nl));
    end
  end
  assign nl_qif_acc_nl = base_rsci_idat - m_rsci_idat;
  assign qif_acc_nl = nl_qif_acc_nl[31:0];
  assign nl_acc_nl = ({1'b1 , m_rsci_idat}) + conv_u2u_32_33(~ base_rsci_idat) +
      33'b000000000000000000000000000000001;
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




//------> ../td_ccore_solutions/mult_9b8ae6c857951539e3f3886315ce73b770ef_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Jun  9 11:07:46 2022
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
  wire acc_itm_32_1;

  wire[31:0] if_acc_nl;
  wire[32:0] nl_if_acc_nl;
  wire[63:0] t_mul_nl;
  wire[31:0] z_mul_nl;
  wire[63:0] nl_z_mul_nl;
  wire[32:0] acc_nl;
  wire[33:0] nl_acc_nl;

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
  assign nl_acc_nl = ({1'b1 , res_sva_3}) + conv_u2u_32_33(~ p_buf_sva_1) + 33'b000000000000000000000000000000001;
  assign acc_nl = nl_acc_nl[32:0];
  assign acc_itm_32_1 = readslicef_33_1_32(acc_nl);
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
      slc_32_svs_1 <= acc_itm_32_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en & and_dcpl & (~ acc_itm_32_1) ) begin
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
//  Generated date: Thu Jun  9 11:09:14 2022
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [13:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [13:0] adra;
  input [27:0] adra_d;
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
  assign adrb = (adra_d[27:14]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[13:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [13:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [13:0] adra;
  input [27:0] adra_d;
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
  assign adrb = (adra_d[27:14]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[13:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [13:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [13:0] adra;
  input [27:0] adra_d;
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
  assign adrb = (adra_d[27:14]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[13:0]);
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
      COMP_LOOP_C_16_tr0, COMP_LOOP_16_VEC_LOOP_C_8_tr0, COMP_LOOP_C_17_tr0, COMP_LOOP_17_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_18_tr0, COMP_LOOP_18_VEC_LOOP_C_8_tr0, COMP_LOOP_C_19_tr0, COMP_LOOP_19_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_20_tr0, COMP_LOOP_20_VEC_LOOP_C_8_tr0, COMP_LOOP_C_21_tr0, COMP_LOOP_21_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_22_tr0, COMP_LOOP_22_VEC_LOOP_C_8_tr0, COMP_LOOP_C_23_tr0, COMP_LOOP_23_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_24_tr0, COMP_LOOP_24_VEC_LOOP_C_8_tr0, COMP_LOOP_C_25_tr0, COMP_LOOP_25_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_26_tr0, COMP_LOOP_26_VEC_LOOP_C_8_tr0, COMP_LOOP_C_27_tr0, COMP_LOOP_27_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_28_tr0, COMP_LOOP_28_VEC_LOOP_C_8_tr0, COMP_LOOP_C_29_tr0, COMP_LOOP_29_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_30_tr0, COMP_LOOP_30_VEC_LOOP_C_8_tr0, COMP_LOOP_C_31_tr0, COMP_LOOP_31_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_32_tr0, COMP_LOOP_32_VEC_LOOP_C_8_tr0, COMP_LOOP_C_33_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
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
  input COMP_LOOP_17_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_18_tr0;
  input COMP_LOOP_18_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_19_tr0;
  input COMP_LOOP_19_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_20_tr0;
  input COMP_LOOP_20_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_21_tr0;
  input COMP_LOOP_21_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_22_tr0;
  input COMP_LOOP_22_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_23_tr0;
  input COMP_LOOP_23_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_24_tr0;
  input COMP_LOOP_24_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_25_tr0;
  input COMP_LOOP_25_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_26_tr0;
  input COMP_LOOP_26_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_27_tr0;
  input COMP_LOOP_27_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_28_tr0;
  input COMP_LOOP_28_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_29_tr0;
  input COMP_LOOP_29_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_30_tr0;
  input COMP_LOOP_30_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_31_tr0;
  input COMP_LOOP_31_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_32_tr0;
  input COMP_LOOP_32_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_33_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_precomp_core_core_fsm_1
  parameter
    main_C_0 = 9'd0,
    STAGE_LOOP_C_0 = 9'd1,
    COMP_LOOP_C_0 = 9'd2,
    COMP_LOOP_C_1 = 9'd3,
    COMP_LOOP_1_VEC_LOOP_C_0 = 9'd4,
    COMP_LOOP_1_VEC_LOOP_C_1 = 9'd5,
    COMP_LOOP_1_VEC_LOOP_C_2 = 9'd6,
    COMP_LOOP_1_VEC_LOOP_C_3 = 9'd7,
    COMP_LOOP_1_VEC_LOOP_C_4 = 9'd8,
    COMP_LOOP_1_VEC_LOOP_C_5 = 9'd9,
    COMP_LOOP_1_VEC_LOOP_C_6 = 9'd10,
    COMP_LOOP_1_VEC_LOOP_C_7 = 9'd11,
    COMP_LOOP_1_VEC_LOOP_C_8 = 9'd12,
    COMP_LOOP_C_2 = 9'd13,
    COMP_LOOP_2_VEC_LOOP_C_0 = 9'd14,
    COMP_LOOP_2_VEC_LOOP_C_1 = 9'd15,
    COMP_LOOP_2_VEC_LOOP_C_2 = 9'd16,
    COMP_LOOP_2_VEC_LOOP_C_3 = 9'd17,
    COMP_LOOP_2_VEC_LOOP_C_4 = 9'd18,
    COMP_LOOP_2_VEC_LOOP_C_5 = 9'd19,
    COMP_LOOP_2_VEC_LOOP_C_6 = 9'd20,
    COMP_LOOP_2_VEC_LOOP_C_7 = 9'd21,
    COMP_LOOP_2_VEC_LOOP_C_8 = 9'd22,
    COMP_LOOP_C_3 = 9'd23,
    COMP_LOOP_3_VEC_LOOP_C_0 = 9'd24,
    COMP_LOOP_3_VEC_LOOP_C_1 = 9'd25,
    COMP_LOOP_3_VEC_LOOP_C_2 = 9'd26,
    COMP_LOOP_3_VEC_LOOP_C_3 = 9'd27,
    COMP_LOOP_3_VEC_LOOP_C_4 = 9'd28,
    COMP_LOOP_3_VEC_LOOP_C_5 = 9'd29,
    COMP_LOOP_3_VEC_LOOP_C_6 = 9'd30,
    COMP_LOOP_3_VEC_LOOP_C_7 = 9'd31,
    COMP_LOOP_3_VEC_LOOP_C_8 = 9'd32,
    COMP_LOOP_C_4 = 9'd33,
    COMP_LOOP_4_VEC_LOOP_C_0 = 9'd34,
    COMP_LOOP_4_VEC_LOOP_C_1 = 9'd35,
    COMP_LOOP_4_VEC_LOOP_C_2 = 9'd36,
    COMP_LOOP_4_VEC_LOOP_C_3 = 9'd37,
    COMP_LOOP_4_VEC_LOOP_C_4 = 9'd38,
    COMP_LOOP_4_VEC_LOOP_C_5 = 9'd39,
    COMP_LOOP_4_VEC_LOOP_C_6 = 9'd40,
    COMP_LOOP_4_VEC_LOOP_C_7 = 9'd41,
    COMP_LOOP_4_VEC_LOOP_C_8 = 9'd42,
    COMP_LOOP_C_5 = 9'd43,
    COMP_LOOP_5_VEC_LOOP_C_0 = 9'd44,
    COMP_LOOP_5_VEC_LOOP_C_1 = 9'd45,
    COMP_LOOP_5_VEC_LOOP_C_2 = 9'd46,
    COMP_LOOP_5_VEC_LOOP_C_3 = 9'd47,
    COMP_LOOP_5_VEC_LOOP_C_4 = 9'd48,
    COMP_LOOP_5_VEC_LOOP_C_5 = 9'd49,
    COMP_LOOP_5_VEC_LOOP_C_6 = 9'd50,
    COMP_LOOP_5_VEC_LOOP_C_7 = 9'd51,
    COMP_LOOP_5_VEC_LOOP_C_8 = 9'd52,
    COMP_LOOP_C_6 = 9'd53,
    COMP_LOOP_6_VEC_LOOP_C_0 = 9'd54,
    COMP_LOOP_6_VEC_LOOP_C_1 = 9'd55,
    COMP_LOOP_6_VEC_LOOP_C_2 = 9'd56,
    COMP_LOOP_6_VEC_LOOP_C_3 = 9'd57,
    COMP_LOOP_6_VEC_LOOP_C_4 = 9'd58,
    COMP_LOOP_6_VEC_LOOP_C_5 = 9'd59,
    COMP_LOOP_6_VEC_LOOP_C_6 = 9'd60,
    COMP_LOOP_6_VEC_LOOP_C_7 = 9'd61,
    COMP_LOOP_6_VEC_LOOP_C_8 = 9'd62,
    COMP_LOOP_C_7 = 9'd63,
    COMP_LOOP_7_VEC_LOOP_C_0 = 9'd64,
    COMP_LOOP_7_VEC_LOOP_C_1 = 9'd65,
    COMP_LOOP_7_VEC_LOOP_C_2 = 9'd66,
    COMP_LOOP_7_VEC_LOOP_C_3 = 9'd67,
    COMP_LOOP_7_VEC_LOOP_C_4 = 9'd68,
    COMP_LOOP_7_VEC_LOOP_C_5 = 9'd69,
    COMP_LOOP_7_VEC_LOOP_C_6 = 9'd70,
    COMP_LOOP_7_VEC_LOOP_C_7 = 9'd71,
    COMP_LOOP_7_VEC_LOOP_C_8 = 9'd72,
    COMP_LOOP_C_8 = 9'd73,
    COMP_LOOP_8_VEC_LOOP_C_0 = 9'd74,
    COMP_LOOP_8_VEC_LOOP_C_1 = 9'd75,
    COMP_LOOP_8_VEC_LOOP_C_2 = 9'd76,
    COMP_LOOP_8_VEC_LOOP_C_3 = 9'd77,
    COMP_LOOP_8_VEC_LOOP_C_4 = 9'd78,
    COMP_LOOP_8_VEC_LOOP_C_5 = 9'd79,
    COMP_LOOP_8_VEC_LOOP_C_6 = 9'd80,
    COMP_LOOP_8_VEC_LOOP_C_7 = 9'd81,
    COMP_LOOP_8_VEC_LOOP_C_8 = 9'd82,
    COMP_LOOP_C_9 = 9'd83,
    COMP_LOOP_9_VEC_LOOP_C_0 = 9'd84,
    COMP_LOOP_9_VEC_LOOP_C_1 = 9'd85,
    COMP_LOOP_9_VEC_LOOP_C_2 = 9'd86,
    COMP_LOOP_9_VEC_LOOP_C_3 = 9'd87,
    COMP_LOOP_9_VEC_LOOP_C_4 = 9'd88,
    COMP_LOOP_9_VEC_LOOP_C_5 = 9'd89,
    COMP_LOOP_9_VEC_LOOP_C_6 = 9'd90,
    COMP_LOOP_9_VEC_LOOP_C_7 = 9'd91,
    COMP_LOOP_9_VEC_LOOP_C_8 = 9'd92,
    COMP_LOOP_C_10 = 9'd93,
    COMP_LOOP_10_VEC_LOOP_C_0 = 9'd94,
    COMP_LOOP_10_VEC_LOOP_C_1 = 9'd95,
    COMP_LOOP_10_VEC_LOOP_C_2 = 9'd96,
    COMP_LOOP_10_VEC_LOOP_C_3 = 9'd97,
    COMP_LOOP_10_VEC_LOOP_C_4 = 9'd98,
    COMP_LOOP_10_VEC_LOOP_C_5 = 9'd99,
    COMP_LOOP_10_VEC_LOOP_C_6 = 9'd100,
    COMP_LOOP_10_VEC_LOOP_C_7 = 9'd101,
    COMP_LOOP_10_VEC_LOOP_C_8 = 9'd102,
    COMP_LOOP_C_11 = 9'd103,
    COMP_LOOP_11_VEC_LOOP_C_0 = 9'd104,
    COMP_LOOP_11_VEC_LOOP_C_1 = 9'd105,
    COMP_LOOP_11_VEC_LOOP_C_2 = 9'd106,
    COMP_LOOP_11_VEC_LOOP_C_3 = 9'd107,
    COMP_LOOP_11_VEC_LOOP_C_4 = 9'd108,
    COMP_LOOP_11_VEC_LOOP_C_5 = 9'd109,
    COMP_LOOP_11_VEC_LOOP_C_6 = 9'd110,
    COMP_LOOP_11_VEC_LOOP_C_7 = 9'd111,
    COMP_LOOP_11_VEC_LOOP_C_8 = 9'd112,
    COMP_LOOP_C_12 = 9'd113,
    COMP_LOOP_12_VEC_LOOP_C_0 = 9'd114,
    COMP_LOOP_12_VEC_LOOP_C_1 = 9'd115,
    COMP_LOOP_12_VEC_LOOP_C_2 = 9'd116,
    COMP_LOOP_12_VEC_LOOP_C_3 = 9'd117,
    COMP_LOOP_12_VEC_LOOP_C_4 = 9'd118,
    COMP_LOOP_12_VEC_LOOP_C_5 = 9'd119,
    COMP_LOOP_12_VEC_LOOP_C_6 = 9'd120,
    COMP_LOOP_12_VEC_LOOP_C_7 = 9'd121,
    COMP_LOOP_12_VEC_LOOP_C_8 = 9'd122,
    COMP_LOOP_C_13 = 9'd123,
    COMP_LOOP_13_VEC_LOOP_C_0 = 9'd124,
    COMP_LOOP_13_VEC_LOOP_C_1 = 9'd125,
    COMP_LOOP_13_VEC_LOOP_C_2 = 9'd126,
    COMP_LOOP_13_VEC_LOOP_C_3 = 9'd127,
    COMP_LOOP_13_VEC_LOOP_C_4 = 9'd128,
    COMP_LOOP_13_VEC_LOOP_C_5 = 9'd129,
    COMP_LOOP_13_VEC_LOOP_C_6 = 9'd130,
    COMP_LOOP_13_VEC_LOOP_C_7 = 9'd131,
    COMP_LOOP_13_VEC_LOOP_C_8 = 9'd132,
    COMP_LOOP_C_14 = 9'd133,
    COMP_LOOP_14_VEC_LOOP_C_0 = 9'd134,
    COMP_LOOP_14_VEC_LOOP_C_1 = 9'd135,
    COMP_LOOP_14_VEC_LOOP_C_2 = 9'd136,
    COMP_LOOP_14_VEC_LOOP_C_3 = 9'd137,
    COMP_LOOP_14_VEC_LOOP_C_4 = 9'd138,
    COMP_LOOP_14_VEC_LOOP_C_5 = 9'd139,
    COMP_LOOP_14_VEC_LOOP_C_6 = 9'd140,
    COMP_LOOP_14_VEC_LOOP_C_7 = 9'd141,
    COMP_LOOP_14_VEC_LOOP_C_8 = 9'd142,
    COMP_LOOP_C_15 = 9'd143,
    COMP_LOOP_15_VEC_LOOP_C_0 = 9'd144,
    COMP_LOOP_15_VEC_LOOP_C_1 = 9'd145,
    COMP_LOOP_15_VEC_LOOP_C_2 = 9'd146,
    COMP_LOOP_15_VEC_LOOP_C_3 = 9'd147,
    COMP_LOOP_15_VEC_LOOP_C_4 = 9'd148,
    COMP_LOOP_15_VEC_LOOP_C_5 = 9'd149,
    COMP_LOOP_15_VEC_LOOP_C_6 = 9'd150,
    COMP_LOOP_15_VEC_LOOP_C_7 = 9'd151,
    COMP_LOOP_15_VEC_LOOP_C_8 = 9'd152,
    COMP_LOOP_C_16 = 9'd153,
    COMP_LOOP_16_VEC_LOOP_C_0 = 9'd154,
    COMP_LOOP_16_VEC_LOOP_C_1 = 9'd155,
    COMP_LOOP_16_VEC_LOOP_C_2 = 9'd156,
    COMP_LOOP_16_VEC_LOOP_C_3 = 9'd157,
    COMP_LOOP_16_VEC_LOOP_C_4 = 9'd158,
    COMP_LOOP_16_VEC_LOOP_C_5 = 9'd159,
    COMP_LOOP_16_VEC_LOOP_C_6 = 9'd160,
    COMP_LOOP_16_VEC_LOOP_C_7 = 9'd161,
    COMP_LOOP_16_VEC_LOOP_C_8 = 9'd162,
    COMP_LOOP_C_17 = 9'd163,
    COMP_LOOP_17_VEC_LOOP_C_0 = 9'd164,
    COMP_LOOP_17_VEC_LOOP_C_1 = 9'd165,
    COMP_LOOP_17_VEC_LOOP_C_2 = 9'd166,
    COMP_LOOP_17_VEC_LOOP_C_3 = 9'd167,
    COMP_LOOP_17_VEC_LOOP_C_4 = 9'd168,
    COMP_LOOP_17_VEC_LOOP_C_5 = 9'd169,
    COMP_LOOP_17_VEC_LOOP_C_6 = 9'd170,
    COMP_LOOP_17_VEC_LOOP_C_7 = 9'd171,
    COMP_LOOP_17_VEC_LOOP_C_8 = 9'd172,
    COMP_LOOP_C_18 = 9'd173,
    COMP_LOOP_18_VEC_LOOP_C_0 = 9'd174,
    COMP_LOOP_18_VEC_LOOP_C_1 = 9'd175,
    COMP_LOOP_18_VEC_LOOP_C_2 = 9'd176,
    COMP_LOOP_18_VEC_LOOP_C_3 = 9'd177,
    COMP_LOOP_18_VEC_LOOP_C_4 = 9'd178,
    COMP_LOOP_18_VEC_LOOP_C_5 = 9'd179,
    COMP_LOOP_18_VEC_LOOP_C_6 = 9'd180,
    COMP_LOOP_18_VEC_LOOP_C_7 = 9'd181,
    COMP_LOOP_18_VEC_LOOP_C_8 = 9'd182,
    COMP_LOOP_C_19 = 9'd183,
    COMP_LOOP_19_VEC_LOOP_C_0 = 9'd184,
    COMP_LOOP_19_VEC_LOOP_C_1 = 9'd185,
    COMP_LOOP_19_VEC_LOOP_C_2 = 9'd186,
    COMP_LOOP_19_VEC_LOOP_C_3 = 9'd187,
    COMP_LOOP_19_VEC_LOOP_C_4 = 9'd188,
    COMP_LOOP_19_VEC_LOOP_C_5 = 9'd189,
    COMP_LOOP_19_VEC_LOOP_C_6 = 9'd190,
    COMP_LOOP_19_VEC_LOOP_C_7 = 9'd191,
    COMP_LOOP_19_VEC_LOOP_C_8 = 9'd192,
    COMP_LOOP_C_20 = 9'd193,
    COMP_LOOP_20_VEC_LOOP_C_0 = 9'd194,
    COMP_LOOP_20_VEC_LOOP_C_1 = 9'd195,
    COMP_LOOP_20_VEC_LOOP_C_2 = 9'd196,
    COMP_LOOP_20_VEC_LOOP_C_3 = 9'd197,
    COMP_LOOP_20_VEC_LOOP_C_4 = 9'd198,
    COMP_LOOP_20_VEC_LOOP_C_5 = 9'd199,
    COMP_LOOP_20_VEC_LOOP_C_6 = 9'd200,
    COMP_LOOP_20_VEC_LOOP_C_7 = 9'd201,
    COMP_LOOP_20_VEC_LOOP_C_8 = 9'd202,
    COMP_LOOP_C_21 = 9'd203,
    COMP_LOOP_21_VEC_LOOP_C_0 = 9'd204,
    COMP_LOOP_21_VEC_LOOP_C_1 = 9'd205,
    COMP_LOOP_21_VEC_LOOP_C_2 = 9'd206,
    COMP_LOOP_21_VEC_LOOP_C_3 = 9'd207,
    COMP_LOOP_21_VEC_LOOP_C_4 = 9'd208,
    COMP_LOOP_21_VEC_LOOP_C_5 = 9'd209,
    COMP_LOOP_21_VEC_LOOP_C_6 = 9'd210,
    COMP_LOOP_21_VEC_LOOP_C_7 = 9'd211,
    COMP_LOOP_21_VEC_LOOP_C_8 = 9'd212,
    COMP_LOOP_C_22 = 9'd213,
    COMP_LOOP_22_VEC_LOOP_C_0 = 9'd214,
    COMP_LOOP_22_VEC_LOOP_C_1 = 9'd215,
    COMP_LOOP_22_VEC_LOOP_C_2 = 9'd216,
    COMP_LOOP_22_VEC_LOOP_C_3 = 9'd217,
    COMP_LOOP_22_VEC_LOOP_C_4 = 9'd218,
    COMP_LOOP_22_VEC_LOOP_C_5 = 9'd219,
    COMP_LOOP_22_VEC_LOOP_C_6 = 9'd220,
    COMP_LOOP_22_VEC_LOOP_C_7 = 9'd221,
    COMP_LOOP_22_VEC_LOOP_C_8 = 9'd222,
    COMP_LOOP_C_23 = 9'd223,
    COMP_LOOP_23_VEC_LOOP_C_0 = 9'd224,
    COMP_LOOP_23_VEC_LOOP_C_1 = 9'd225,
    COMP_LOOP_23_VEC_LOOP_C_2 = 9'd226,
    COMP_LOOP_23_VEC_LOOP_C_3 = 9'd227,
    COMP_LOOP_23_VEC_LOOP_C_4 = 9'd228,
    COMP_LOOP_23_VEC_LOOP_C_5 = 9'd229,
    COMP_LOOP_23_VEC_LOOP_C_6 = 9'd230,
    COMP_LOOP_23_VEC_LOOP_C_7 = 9'd231,
    COMP_LOOP_23_VEC_LOOP_C_8 = 9'd232,
    COMP_LOOP_C_24 = 9'd233,
    COMP_LOOP_24_VEC_LOOP_C_0 = 9'd234,
    COMP_LOOP_24_VEC_LOOP_C_1 = 9'd235,
    COMP_LOOP_24_VEC_LOOP_C_2 = 9'd236,
    COMP_LOOP_24_VEC_LOOP_C_3 = 9'd237,
    COMP_LOOP_24_VEC_LOOP_C_4 = 9'd238,
    COMP_LOOP_24_VEC_LOOP_C_5 = 9'd239,
    COMP_LOOP_24_VEC_LOOP_C_6 = 9'd240,
    COMP_LOOP_24_VEC_LOOP_C_7 = 9'd241,
    COMP_LOOP_24_VEC_LOOP_C_8 = 9'd242,
    COMP_LOOP_C_25 = 9'd243,
    COMP_LOOP_25_VEC_LOOP_C_0 = 9'd244,
    COMP_LOOP_25_VEC_LOOP_C_1 = 9'd245,
    COMP_LOOP_25_VEC_LOOP_C_2 = 9'd246,
    COMP_LOOP_25_VEC_LOOP_C_3 = 9'd247,
    COMP_LOOP_25_VEC_LOOP_C_4 = 9'd248,
    COMP_LOOP_25_VEC_LOOP_C_5 = 9'd249,
    COMP_LOOP_25_VEC_LOOP_C_6 = 9'd250,
    COMP_LOOP_25_VEC_LOOP_C_7 = 9'd251,
    COMP_LOOP_25_VEC_LOOP_C_8 = 9'd252,
    COMP_LOOP_C_26 = 9'd253,
    COMP_LOOP_26_VEC_LOOP_C_0 = 9'd254,
    COMP_LOOP_26_VEC_LOOP_C_1 = 9'd255,
    COMP_LOOP_26_VEC_LOOP_C_2 = 9'd256,
    COMP_LOOP_26_VEC_LOOP_C_3 = 9'd257,
    COMP_LOOP_26_VEC_LOOP_C_4 = 9'd258,
    COMP_LOOP_26_VEC_LOOP_C_5 = 9'd259,
    COMP_LOOP_26_VEC_LOOP_C_6 = 9'd260,
    COMP_LOOP_26_VEC_LOOP_C_7 = 9'd261,
    COMP_LOOP_26_VEC_LOOP_C_8 = 9'd262,
    COMP_LOOP_C_27 = 9'd263,
    COMP_LOOP_27_VEC_LOOP_C_0 = 9'd264,
    COMP_LOOP_27_VEC_LOOP_C_1 = 9'd265,
    COMP_LOOP_27_VEC_LOOP_C_2 = 9'd266,
    COMP_LOOP_27_VEC_LOOP_C_3 = 9'd267,
    COMP_LOOP_27_VEC_LOOP_C_4 = 9'd268,
    COMP_LOOP_27_VEC_LOOP_C_5 = 9'd269,
    COMP_LOOP_27_VEC_LOOP_C_6 = 9'd270,
    COMP_LOOP_27_VEC_LOOP_C_7 = 9'd271,
    COMP_LOOP_27_VEC_LOOP_C_8 = 9'd272,
    COMP_LOOP_C_28 = 9'd273,
    COMP_LOOP_28_VEC_LOOP_C_0 = 9'd274,
    COMP_LOOP_28_VEC_LOOP_C_1 = 9'd275,
    COMP_LOOP_28_VEC_LOOP_C_2 = 9'd276,
    COMP_LOOP_28_VEC_LOOP_C_3 = 9'd277,
    COMP_LOOP_28_VEC_LOOP_C_4 = 9'd278,
    COMP_LOOP_28_VEC_LOOP_C_5 = 9'd279,
    COMP_LOOP_28_VEC_LOOP_C_6 = 9'd280,
    COMP_LOOP_28_VEC_LOOP_C_7 = 9'd281,
    COMP_LOOP_28_VEC_LOOP_C_8 = 9'd282,
    COMP_LOOP_C_29 = 9'd283,
    COMP_LOOP_29_VEC_LOOP_C_0 = 9'd284,
    COMP_LOOP_29_VEC_LOOP_C_1 = 9'd285,
    COMP_LOOP_29_VEC_LOOP_C_2 = 9'd286,
    COMP_LOOP_29_VEC_LOOP_C_3 = 9'd287,
    COMP_LOOP_29_VEC_LOOP_C_4 = 9'd288,
    COMP_LOOP_29_VEC_LOOP_C_5 = 9'd289,
    COMP_LOOP_29_VEC_LOOP_C_6 = 9'd290,
    COMP_LOOP_29_VEC_LOOP_C_7 = 9'd291,
    COMP_LOOP_29_VEC_LOOP_C_8 = 9'd292,
    COMP_LOOP_C_30 = 9'd293,
    COMP_LOOP_30_VEC_LOOP_C_0 = 9'd294,
    COMP_LOOP_30_VEC_LOOP_C_1 = 9'd295,
    COMP_LOOP_30_VEC_LOOP_C_2 = 9'd296,
    COMP_LOOP_30_VEC_LOOP_C_3 = 9'd297,
    COMP_LOOP_30_VEC_LOOP_C_4 = 9'd298,
    COMP_LOOP_30_VEC_LOOP_C_5 = 9'd299,
    COMP_LOOP_30_VEC_LOOP_C_6 = 9'd300,
    COMP_LOOP_30_VEC_LOOP_C_7 = 9'd301,
    COMP_LOOP_30_VEC_LOOP_C_8 = 9'd302,
    COMP_LOOP_C_31 = 9'd303,
    COMP_LOOP_31_VEC_LOOP_C_0 = 9'd304,
    COMP_LOOP_31_VEC_LOOP_C_1 = 9'd305,
    COMP_LOOP_31_VEC_LOOP_C_2 = 9'd306,
    COMP_LOOP_31_VEC_LOOP_C_3 = 9'd307,
    COMP_LOOP_31_VEC_LOOP_C_4 = 9'd308,
    COMP_LOOP_31_VEC_LOOP_C_5 = 9'd309,
    COMP_LOOP_31_VEC_LOOP_C_6 = 9'd310,
    COMP_LOOP_31_VEC_LOOP_C_7 = 9'd311,
    COMP_LOOP_31_VEC_LOOP_C_8 = 9'd312,
    COMP_LOOP_C_32 = 9'd313,
    COMP_LOOP_32_VEC_LOOP_C_0 = 9'd314,
    COMP_LOOP_32_VEC_LOOP_C_1 = 9'd315,
    COMP_LOOP_32_VEC_LOOP_C_2 = 9'd316,
    COMP_LOOP_32_VEC_LOOP_C_3 = 9'd317,
    COMP_LOOP_32_VEC_LOOP_C_4 = 9'd318,
    COMP_LOOP_32_VEC_LOOP_C_5 = 9'd319,
    COMP_LOOP_32_VEC_LOOP_C_6 = 9'd320,
    COMP_LOOP_32_VEC_LOOP_C_7 = 9'd321,
    COMP_LOOP_32_VEC_LOOP_C_8 = 9'd322,
    COMP_LOOP_C_33 = 9'd323,
    STAGE_LOOP_C_1 = 9'd324,
    main_C_1 = 9'd325,
    main_C_2 = 9'd326;

  reg [8:0] state_var;
  reg [8:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIT_precomp_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 9'b000000001;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 9'b000000010;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 9'b000000011;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
      end
      COMP_LOOP_1_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000000100;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_1;
      end
      COMP_LOOP_1_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000000101;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_2;
      end
      COMP_LOOP_1_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000000110;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_3;
      end
      COMP_LOOP_1_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000000111;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_4;
      end
      COMP_LOOP_1_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000001000;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_5;
      end
      COMP_LOOP_1_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000001001;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_6;
      end
      COMP_LOOP_1_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000001010;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_7;
      end
      COMP_LOOP_1_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000001011;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_8;
      end
      COMP_LOOP_1_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000001100;
        if ( COMP_LOOP_1_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 9'b000001101;
        if ( COMP_LOOP_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_2_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000001110;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_1;
      end
      COMP_LOOP_2_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000001111;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_2;
      end
      COMP_LOOP_2_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000010000;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_3;
      end
      COMP_LOOP_2_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000010001;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_4;
      end
      COMP_LOOP_2_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000010010;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_5;
      end
      COMP_LOOP_2_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000010011;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_6;
      end
      COMP_LOOP_2_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000010100;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_7;
      end
      COMP_LOOP_2_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000010101;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_8;
      end
      COMP_LOOP_2_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000010110;
        if ( COMP_LOOP_2_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_3;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 9'b000010111;
        if ( COMP_LOOP_C_3_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_3_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000011000;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_1;
      end
      COMP_LOOP_3_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000011001;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_2;
      end
      COMP_LOOP_3_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000011010;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_3;
      end
      COMP_LOOP_3_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000011011;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_4;
      end
      COMP_LOOP_3_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000011100;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_5;
      end
      COMP_LOOP_3_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000011101;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_6;
      end
      COMP_LOOP_3_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000011110;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_7;
      end
      COMP_LOOP_3_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000011111;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_8;
      end
      COMP_LOOP_3_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000100000;
        if ( COMP_LOOP_3_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_4;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 9'b000100001;
        if ( COMP_LOOP_C_4_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_4_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000100010;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_1;
      end
      COMP_LOOP_4_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000100011;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_2;
      end
      COMP_LOOP_4_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000100100;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_3;
      end
      COMP_LOOP_4_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000100101;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_4;
      end
      COMP_LOOP_4_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000100110;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_5;
      end
      COMP_LOOP_4_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000100111;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_6;
      end
      COMP_LOOP_4_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000101000;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_7;
      end
      COMP_LOOP_4_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000101001;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_8;
      end
      COMP_LOOP_4_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000101010;
        if ( COMP_LOOP_4_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_5;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 9'b000101011;
        if ( COMP_LOOP_C_5_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_5_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000101100;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_1;
      end
      COMP_LOOP_5_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000101101;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_2;
      end
      COMP_LOOP_5_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000101110;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_3;
      end
      COMP_LOOP_5_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000101111;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_4;
      end
      COMP_LOOP_5_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000110000;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_5;
      end
      COMP_LOOP_5_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000110001;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_6;
      end
      COMP_LOOP_5_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000110010;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_7;
      end
      COMP_LOOP_5_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000110011;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_8;
      end
      COMP_LOOP_5_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000110100;
        if ( COMP_LOOP_5_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_6;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 9'b000110101;
        if ( COMP_LOOP_C_6_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_6_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000110110;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_1;
      end
      COMP_LOOP_6_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000110111;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_2;
      end
      COMP_LOOP_6_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000111000;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_3;
      end
      COMP_LOOP_6_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000111001;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_4;
      end
      COMP_LOOP_6_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000111010;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_5;
      end
      COMP_LOOP_6_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000111011;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_6;
      end
      COMP_LOOP_6_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000111100;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_7;
      end
      COMP_LOOP_6_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000111101;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_8;
      end
      COMP_LOOP_6_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000111110;
        if ( COMP_LOOP_6_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_7;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 9'b000111111;
        if ( COMP_LOOP_C_7_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_7_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001000000;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_1;
      end
      COMP_LOOP_7_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001000001;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_2;
      end
      COMP_LOOP_7_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001000010;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_3;
      end
      COMP_LOOP_7_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001000011;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_4;
      end
      COMP_LOOP_7_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001000100;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_5;
      end
      COMP_LOOP_7_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001000101;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_6;
      end
      COMP_LOOP_7_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001000110;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_7;
      end
      COMP_LOOP_7_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001000111;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_8;
      end
      COMP_LOOP_7_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001001000;
        if ( COMP_LOOP_7_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_8;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 9'b001001001;
        if ( COMP_LOOP_C_8_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_8_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001001010;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_1;
      end
      COMP_LOOP_8_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001001011;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_2;
      end
      COMP_LOOP_8_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001001100;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_3;
      end
      COMP_LOOP_8_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001001101;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_4;
      end
      COMP_LOOP_8_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001001110;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_5;
      end
      COMP_LOOP_8_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001001111;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_6;
      end
      COMP_LOOP_8_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001010000;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_7;
      end
      COMP_LOOP_8_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001010001;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_8;
      end
      COMP_LOOP_8_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001010010;
        if ( COMP_LOOP_8_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_9;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 9'b001010011;
        if ( COMP_LOOP_C_9_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_9_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001010100;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_1;
      end
      COMP_LOOP_9_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001010101;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_2;
      end
      COMP_LOOP_9_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001010110;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_3;
      end
      COMP_LOOP_9_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001010111;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_4;
      end
      COMP_LOOP_9_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001011000;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_5;
      end
      COMP_LOOP_9_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001011001;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_6;
      end
      COMP_LOOP_9_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001011010;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_7;
      end
      COMP_LOOP_9_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001011011;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_8;
      end
      COMP_LOOP_9_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001011100;
        if ( COMP_LOOP_9_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_10;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 9'b001011101;
        if ( COMP_LOOP_C_10_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_10_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001011110;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_1;
      end
      COMP_LOOP_10_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001011111;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_2;
      end
      COMP_LOOP_10_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001100000;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_3;
      end
      COMP_LOOP_10_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001100001;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_4;
      end
      COMP_LOOP_10_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001100010;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_5;
      end
      COMP_LOOP_10_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001100011;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_6;
      end
      COMP_LOOP_10_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001100100;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_7;
      end
      COMP_LOOP_10_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001100101;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_8;
      end
      COMP_LOOP_10_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001100110;
        if ( COMP_LOOP_10_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_11;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 9'b001100111;
        if ( COMP_LOOP_C_11_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_11_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001101000;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_1;
      end
      COMP_LOOP_11_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001101001;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_2;
      end
      COMP_LOOP_11_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001101010;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_3;
      end
      COMP_LOOP_11_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001101011;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_4;
      end
      COMP_LOOP_11_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001101100;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_5;
      end
      COMP_LOOP_11_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001101101;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_6;
      end
      COMP_LOOP_11_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001101110;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_7;
      end
      COMP_LOOP_11_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001101111;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_8;
      end
      COMP_LOOP_11_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001110000;
        if ( COMP_LOOP_11_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_12;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 9'b001110001;
        if ( COMP_LOOP_C_12_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_12_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001110010;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_1;
      end
      COMP_LOOP_12_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001110011;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_2;
      end
      COMP_LOOP_12_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001110100;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_3;
      end
      COMP_LOOP_12_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001110101;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_4;
      end
      COMP_LOOP_12_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001110110;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_5;
      end
      COMP_LOOP_12_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001110111;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_6;
      end
      COMP_LOOP_12_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001111000;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_7;
      end
      COMP_LOOP_12_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001111001;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_8;
      end
      COMP_LOOP_12_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001111010;
        if ( COMP_LOOP_12_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_13;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 9'b001111011;
        if ( COMP_LOOP_C_13_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_13_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001111100;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_1;
      end
      COMP_LOOP_13_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001111101;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_2;
      end
      COMP_LOOP_13_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001111110;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_3;
      end
      COMP_LOOP_13_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001111111;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_4;
      end
      COMP_LOOP_13_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010000000;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_5;
      end
      COMP_LOOP_13_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010000001;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_6;
      end
      COMP_LOOP_13_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010000010;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_7;
      end
      COMP_LOOP_13_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010000011;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_8;
      end
      COMP_LOOP_13_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010000100;
        if ( COMP_LOOP_13_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_14;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 9'b010000101;
        if ( COMP_LOOP_C_14_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_14_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010000110;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_1;
      end
      COMP_LOOP_14_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010000111;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_2;
      end
      COMP_LOOP_14_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010001000;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_3;
      end
      COMP_LOOP_14_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010001001;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_4;
      end
      COMP_LOOP_14_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010001010;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_5;
      end
      COMP_LOOP_14_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010001011;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_6;
      end
      COMP_LOOP_14_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010001100;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_7;
      end
      COMP_LOOP_14_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010001101;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_8;
      end
      COMP_LOOP_14_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010001110;
        if ( COMP_LOOP_14_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_15;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 9'b010001111;
        if ( COMP_LOOP_C_15_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_15_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010010000;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_1;
      end
      COMP_LOOP_15_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010010001;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_2;
      end
      COMP_LOOP_15_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010010010;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_3;
      end
      COMP_LOOP_15_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010010011;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_4;
      end
      COMP_LOOP_15_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010010100;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_5;
      end
      COMP_LOOP_15_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010010101;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_6;
      end
      COMP_LOOP_15_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010010110;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_7;
      end
      COMP_LOOP_15_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010010111;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_8;
      end
      COMP_LOOP_15_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010011000;
        if ( COMP_LOOP_15_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_16;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 9'b010011001;
        if ( COMP_LOOP_C_16_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_16_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010011010;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_1;
      end
      COMP_LOOP_16_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010011011;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_2;
      end
      COMP_LOOP_16_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010011100;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_3;
      end
      COMP_LOOP_16_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010011101;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_4;
      end
      COMP_LOOP_16_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010011110;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_5;
      end
      COMP_LOOP_16_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010011111;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_6;
      end
      COMP_LOOP_16_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010100000;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_7;
      end
      COMP_LOOP_16_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010100001;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_8;
      end
      COMP_LOOP_16_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010100010;
        if ( COMP_LOOP_16_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_17;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 9'b010100011;
        if ( COMP_LOOP_C_17_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_17_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_17_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010100100;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_1;
      end
      COMP_LOOP_17_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010100101;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_2;
      end
      COMP_LOOP_17_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010100110;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_3;
      end
      COMP_LOOP_17_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010100111;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_4;
      end
      COMP_LOOP_17_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010101000;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_5;
      end
      COMP_LOOP_17_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010101001;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_6;
      end
      COMP_LOOP_17_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010101010;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_7;
      end
      COMP_LOOP_17_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010101011;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_8;
      end
      COMP_LOOP_17_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010101100;
        if ( COMP_LOOP_17_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_18;
        end
        else begin
          state_var_NS = COMP_LOOP_17_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 9'b010101101;
        if ( COMP_LOOP_C_18_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_18_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_18_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010101110;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_1;
      end
      COMP_LOOP_18_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010101111;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_2;
      end
      COMP_LOOP_18_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010110000;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_3;
      end
      COMP_LOOP_18_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010110001;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_4;
      end
      COMP_LOOP_18_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010110010;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_5;
      end
      COMP_LOOP_18_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010110011;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_6;
      end
      COMP_LOOP_18_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010110100;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_7;
      end
      COMP_LOOP_18_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010110101;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_8;
      end
      COMP_LOOP_18_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010110110;
        if ( COMP_LOOP_18_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_19;
        end
        else begin
          state_var_NS = COMP_LOOP_18_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 9'b010110111;
        if ( COMP_LOOP_C_19_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_19_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_19_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010111000;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_1;
      end
      COMP_LOOP_19_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010111001;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_2;
      end
      COMP_LOOP_19_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010111010;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_3;
      end
      COMP_LOOP_19_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010111011;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_4;
      end
      COMP_LOOP_19_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010111100;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_5;
      end
      COMP_LOOP_19_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010111101;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_6;
      end
      COMP_LOOP_19_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010111110;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_7;
      end
      COMP_LOOP_19_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010111111;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_8;
      end
      COMP_LOOP_19_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011000000;
        if ( COMP_LOOP_19_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_20;
        end
        else begin
          state_var_NS = COMP_LOOP_19_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 9'b011000001;
        if ( COMP_LOOP_C_20_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_20_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_20_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011000010;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_1;
      end
      COMP_LOOP_20_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011000011;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_2;
      end
      COMP_LOOP_20_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011000100;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_3;
      end
      COMP_LOOP_20_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011000101;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_4;
      end
      COMP_LOOP_20_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011000110;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_5;
      end
      COMP_LOOP_20_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011000111;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_6;
      end
      COMP_LOOP_20_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011001000;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_7;
      end
      COMP_LOOP_20_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011001001;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_8;
      end
      COMP_LOOP_20_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011001010;
        if ( COMP_LOOP_20_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_21;
        end
        else begin
          state_var_NS = COMP_LOOP_20_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 9'b011001011;
        if ( COMP_LOOP_C_21_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_21_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_21_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011001100;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_1;
      end
      COMP_LOOP_21_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011001101;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_2;
      end
      COMP_LOOP_21_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011001110;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_3;
      end
      COMP_LOOP_21_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011001111;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_4;
      end
      COMP_LOOP_21_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011010000;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_5;
      end
      COMP_LOOP_21_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011010001;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_6;
      end
      COMP_LOOP_21_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011010010;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_7;
      end
      COMP_LOOP_21_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011010011;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_8;
      end
      COMP_LOOP_21_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011010100;
        if ( COMP_LOOP_21_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_22;
        end
        else begin
          state_var_NS = COMP_LOOP_21_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 9'b011010101;
        if ( COMP_LOOP_C_22_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_22_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_22_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011010110;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_1;
      end
      COMP_LOOP_22_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011010111;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_2;
      end
      COMP_LOOP_22_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011011000;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_3;
      end
      COMP_LOOP_22_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011011001;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_4;
      end
      COMP_LOOP_22_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011011010;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_5;
      end
      COMP_LOOP_22_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011011011;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_6;
      end
      COMP_LOOP_22_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011011100;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_7;
      end
      COMP_LOOP_22_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011011101;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_8;
      end
      COMP_LOOP_22_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011011110;
        if ( COMP_LOOP_22_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_23;
        end
        else begin
          state_var_NS = COMP_LOOP_22_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 9'b011011111;
        if ( COMP_LOOP_C_23_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_23_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_23_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011100000;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_1;
      end
      COMP_LOOP_23_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011100001;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_2;
      end
      COMP_LOOP_23_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011100010;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_3;
      end
      COMP_LOOP_23_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011100011;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_4;
      end
      COMP_LOOP_23_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011100100;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_5;
      end
      COMP_LOOP_23_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011100101;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_6;
      end
      COMP_LOOP_23_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011100110;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_7;
      end
      COMP_LOOP_23_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011100111;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_8;
      end
      COMP_LOOP_23_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011101000;
        if ( COMP_LOOP_23_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_24;
        end
        else begin
          state_var_NS = COMP_LOOP_23_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 9'b011101001;
        if ( COMP_LOOP_C_24_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_24_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_24_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011101010;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_1;
      end
      COMP_LOOP_24_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011101011;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_2;
      end
      COMP_LOOP_24_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011101100;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_3;
      end
      COMP_LOOP_24_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011101101;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_4;
      end
      COMP_LOOP_24_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011101110;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_5;
      end
      COMP_LOOP_24_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011101111;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_6;
      end
      COMP_LOOP_24_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011110000;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_7;
      end
      COMP_LOOP_24_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011110001;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_8;
      end
      COMP_LOOP_24_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011110010;
        if ( COMP_LOOP_24_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_25;
        end
        else begin
          state_var_NS = COMP_LOOP_24_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 9'b011110011;
        if ( COMP_LOOP_C_25_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_25_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_25_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011110100;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_1;
      end
      COMP_LOOP_25_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011110101;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_2;
      end
      COMP_LOOP_25_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011110110;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_3;
      end
      COMP_LOOP_25_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011110111;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_4;
      end
      COMP_LOOP_25_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011111000;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_5;
      end
      COMP_LOOP_25_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011111001;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_6;
      end
      COMP_LOOP_25_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011111010;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_7;
      end
      COMP_LOOP_25_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011111011;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_8;
      end
      COMP_LOOP_25_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011111100;
        if ( COMP_LOOP_25_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_26;
        end
        else begin
          state_var_NS = COMP_LOOP_25_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 9'b011111101;
        if ( COMP_LOOP_C_26_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_26_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_26_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011111110;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_1;
      end
      COMP_LOOP_26_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011111111;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_2;
      end
      COMP_LOOP_26_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100000000;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_3;
      end
      COMP_LOOP_26_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100000001;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_4;
      end
      COMP_LOOP_26_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100000010;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_5;
      end
      COMP_LOOP_26_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100000011;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_6;
      end
      COMP_LOOP_26_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100000100;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_7;
      end
      COMP_LOOP_26_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100000101;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_8;
      end
      COMP_LOOP_26_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100000110;
        if ( COMP_LOOP_26_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_27;
        end
        else begin
          state_var_NS = COMP_LOOP_26_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 9'b100000111;
        if ( COMP_LOOP_C_27_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_27_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_27_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100001000;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_1;
      end
      COMP_LOOP_27_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100001001;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_2;
      end
      COMP_LOOP_27_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100001010;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_3;
      end
      COMP_LOOP_27_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100001011;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_4;
      end
      COMP_LOOP_27_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100001100;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_5;
      end
      COMP_LOOP_27_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100001101;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_6;
      end
      COMP_LOOP_27_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100001110;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_7;
      end
      COMP_LOOP_27_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100001111;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_8;
      end
      COMP_LOOP_27_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100010000;
        if ( COMP_LOOP_27_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_28;
        end
        else begin
          state_var_NS = COMP_LOOP_27_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 9'b100010001;
        if ( COMP_LOOP_C_28_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_28_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_28_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100010010;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_1;
      end
      COMP_LOOP_28_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100010011;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_2;
      end
      COMP_LOOP_28_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100010100;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_3;
      end
      COMP_LOOP_28_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100010101;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_4;
      end
      COMP_LOOP_28_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100010110;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_5;
      end
      COMP_LOOP_28_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100010111;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_6;
      end
      COMP_LOOP_28_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100011000;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_7;
      end
      COMP_LOOP_28_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100011001;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_8;
      end
      COMP_LOOP_28_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100011010;
        if ( COMP_LOOP_28_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_29;
        end
        else begin
          state_var_NS = COMP_LOOP_28_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 9'b100011011;
        if ( COMP_LOOP_C_29_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_29_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_29_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100011100;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_1;
      end
      COMP_LOOP_29_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100011101;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_2;
      end
      COMP_LOOP_29_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100011110;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_3;
      end
      COMP_LOOP_29_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100011111;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_4;
      end
      COMP_LOOP_29_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100100000;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_5;
      end
      COMP_LOOP_29_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100100001;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_6;
      end
      COMP_LOOP_29_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100100010;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_7;
      end
      COMP_LOOP_29_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100100011;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_8;
      end
      COMP_LOOP_29_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100100100;
        if ( COMP_LOOP_29_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_30;
        end
        else begin
          state_var_NS = COMP_LOOP_29_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 9'b100100101;
        if ( COMP_LOOP_C_30_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_30_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_30_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100100110;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_1;
      end
      COMP_LOOP_30_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100100111;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_2;
      end
      COMP_LOOP_30_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100101000;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_3;
      end
      COMP_LOOP_30_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100101001;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_4;
      end
      COMP_LOOP_30_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100101010;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_5;
      end
      COMP_LOOP_30_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100101011;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_6;
      end
      COMP_LOOP_30_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100101100;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_7;
      end
      COMP_LOOP_30_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100101101;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_8;
      end
      COMP_LOOP_30_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100101110;
        if ( COMP_LOOP_30_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_31;
        end
        else begin
          state_var_NS = COMP_LOOP_30_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 9'b100101111;
        if ( COMP_LOOP_C_31_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_31_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_31_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100110000;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_1;
      end
      COMP_LOOP_31_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100110001;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_2;
      end
      COMP_LOOP_31_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100110010;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_3;
      end
      COMP_LOOP_31_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100110011;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_4;
      end
      COMP_LOOP_31_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100110100;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_5;
      end
      COMP_LOOP_31_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100110101;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_6;
      end
      COMP_LOOP_31_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100110110;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_7;
      end
      COMP_LOOP_31_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100110111;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_8;
      end
      COMP_LOOP_31_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100111000;
        if ( COMP_LOOP_31_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_32;
        end
        else begin
          state_var_NS = COMP_LOOP_31_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 9'b100111001;
        if ( COMP_LOOP_C_32_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_32_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_32_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100111010;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_1;
      end
      COMP_LOOP_32_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100111011;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_2;
      end
      COMP_LOOP_32_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100111100;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_3;
      end
      COMP_LOOP_32_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100111101;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_4;
      end
      COMP_LOOP_32_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100111110;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_5;
      end
      COMP_LOOP_32_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100111111;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_6;
      end
      COMP_LOOP_32_VEC_LOOP_C_6 : begin
        fsm_output = 9'b101000000;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_7;
      end
      COMP_LOOP_32_VEC_LOOP_C_7 : begin
        fsm_output = 9'b101000001;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_8;
      end
      COMP_LOOP_32_VEC_LOOP_C_8 : begin
        fsm_output = 9'b101000010;
        if ( COMP_LOOP_32_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_33;
        end
        else begin
          state_var_NS = COMP_LOOP_32_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 9'b101000011;
        if ( COMP_LOOP_C_33_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 9'b101000100;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b101000101;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 9'b101000110;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 9'b000000000;
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
  clk, rst, twiddle_h_rsci_adra_d, twiddle_h_rsci_qa_d, twiddle_h_rsci_adra_d_core,
      twiddle_h_rsci_qa_d_mxwt, twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt
);
  input clk;
  input rst;
  output [13:0] twiddle_h_rsci_adra_d;
  input [63:0] twiddle_h_rsci_qa_d;
  input [27:0] twiddle_h_rsci_adra_d_core;
  output [31:0] twiddle_h_rsci_qa_d_mxwt;
  input twiddle_h_rsci_biwt;
  input twiddle_h_rsci_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsci_bcwt;
  reg [31:0] twiddle_h_rsci_qa_d_bfwt_31_0;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_qa_d_mxwt = MUX_v_32_2_2((twiddle_h_rsci_qa_d[31:0]), twiddle_h_rsci_qa_d_bfwt_31_0,
      twiddle_h_rsci_bcwt);
  assign twiddle_h_rsci_adra_d = twiddle_h_rsci_adra_d_core[13:0];
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_h_rsci_bcwt <= 1'b0;
    end
    else begin
      twiddle_h_rsci_bcwt <= ~((~(twiddle_h_rsci_bcwt | twiddle_h_rsci_biwt)) | twiddle_h_rsci_bdwt);
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
  core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      core_wten_pff, twiddle_h_rsci_oswt_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsci_oswt;
  input [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  output twiddle_h_rsci_biwt;
  output twiddle_h_rsci_bdwt;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  input core_wten_pff;
  input twiddle_h_rsci_oswt_pff;


  wire[0:0] COMP_LOOP_twiddle_help_and_7_nl;

  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_bdwt = twiddle_h_rsci_oswt & core_wen;
  assign twiddle_h_rsci_biwt = (~ core_wten) & twiddle_h_rsci_oswt;
  assign COMP_LOOP_twiddle_help_and_7_nl = (twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[0])
      & (~ core_wten_pff) & twiddle_h_rsci_oswt_pff;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = {1'b0 , COMP_LOOP_twiddle_help_and_7_nl};
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp (
  clk, rst, twiddle_rsci_adra_d, twiddle_rsci_qa_d, twiddle_rsci_adra_d_core, twiddle_rsci_qa_d_mxwt,
      twiddle_rsci_biwt, twiddle_rsci_bdwt
);
  input clk;
  input rst;
  output [13:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  input [27:0] twiddle_rsci_adra_d_core;
  output [31:0] twiddle_rsci_qa_d_mxwt;
  input twiddle_rsci_biwt;
  input twiddle_rsci_bdwt;


  // Interconnect Declarations
  reg twiddle_rsci_bcwt;
  reg [31:0] twiddle_rsci_qa_d_bfwt_31_0;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_qa_d_mxwt = MUX_v_32_2_2((twiddle_rsci_qa_d[31:0]), twiddle_rsci_qa_d_bfwt_31_0,
      twiddle_rsci_bcwt);
  assign twiddle_rsci_adra_d = twiddle_rsci_adra_d_core[13:0];
  always @(posedge clk) begin
    if ( rst ) begin
      twiddle_rsci_bcwt <= 1'b0;
    end
    else begin
      twiddle_rsci_bcwt <= ~((~(twiddle_rsci_bcwt | twiddle_rsci_biwt)) | twiddle_rsci_bdwt);
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
  core_wen, core_wten, twiddle_rsci_oswt, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      twiddle_rsci_biwt, twiddle_rsci_bdwt, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      core_wten_pff, twiddle_rsci_oswt_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsci_oswt;
  input [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  output twiddle_rsci_biwt;
  output twiddle_rsci_bdwt;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  input core_wten_pff;
  input twiddle_rsci_oswt_pff;


  wire[0:0] COMP_LOOP_twiddle_f_and_7_nl;

  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_bdwt = twiddle_rsci_oswt & core_wen;
  assign twiddle_rsci_biwt = (~ core_wten) & twiddle_rsci_oswt;
  assign COMP_LOOP_twiddle_f_and_7_nl = (twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[0])
      & (~ core_wten_pff) & twiddle_rsci_oswt_pff;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = {1'b0 , COMP_LOOP_twiddle_f_and_7_nl};
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
  clk, rst, twiddle_h_rsci_adra_d, twiddle_h_rsci_qa_d, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_adra_d_core, twiddle_h_rsci_qa_d_mxwt,
      twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, core_wten_pff, twiddle_h_rsci_oswt_pff
);
  input clk;
  input rst;
  output [13:0] twiddle_h_rsci_adra_d;
  input [63:0] twiddle_h_rsci_qa_d;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsci_oswt;
  input [27:0] twiddle_h_rsci_adra_d_core;
  output [31:0] twiddle_h_rsci_qa_d_mxwt;
  input [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input core_wten_pff;
  input twiddle_h_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_h_rsci_biwt;
  wire twiddle_h_rsci_bdwt;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [31:0] twiddle_h_rsci_qa_d_mxwt_pconst;
  wire [13:0] twiddle_h_rsci_adra_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , (twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[0])};
  wire [27:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_adra_d_core;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_adra_d_core
      = {14'b00000000000000 , (twiddle_h_rsci_adra_d_core[13:0])};
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsci_oswt(twiddle_h_rsci_oswt),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .twiddle_h_rsci_oswt_pff(twiddle_h_rsci_oswt_pff)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_adra_d(twiddle_h_rsci_adra_d_reg),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_adra_d_core(nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_adra_d_core[27:0]),
      .twiddle_h_rsci_qa_d_mxwt(twiddle_h_rsci_qa_d_mxwt_pconst),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt)
    );
  assign twiddle_h_rsci_qa_d_mxwt = twiddle_h_rsci_qa_d_mxwt_pconst;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign twiddle_h_rsci_adra_d = twiddle_h_rsci_adra_d_reg;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_core_twiddle_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_twiddle_rsci_1 (
  clk, rst, twiddle_rsci_adra_d, twiddle_rsci_qa_d, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsci_oswt, twiddle_rsci_adra_d_core, twiddle_rsci_qa_d_mxwt,
      twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, core_wten_pff, twiddle_rsci_oswt_pff
);
  input clk;
  input rst;
  output [13:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsci_oswt;
  input [27:0] twiddle_rsci_adra_d_core;
  output [31:0] twiddle_rsci_qa_d_mxwt;
  input [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input core_wten_pff;
  input twiddle_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_rsci_biwt;
  wire twiddle_rsci_bdwt;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [31:0] twiddle_rsci_qa_d_mxwt_pconst;
  wire [13:0] twiddle_rsci_adra_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , (twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[0])};
  wire [27:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst_twiddle_rsci_adra_d_core;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst_twiddle_rsci_adra_d_core
      = {14'b00000000000000 , (twiddle_rsci_adra_d_core[13:0])};
  inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(twiddle_rsci_oswt),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .twiddle_rsci_oswt_pff(twiddle_rsci_oswt_pff)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsci_adra_d(twiddle_rsci_adra_d_reg),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_adra_d_core(nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst_twiddle_rsci_adra_d_core[27:0]),
      .twiddle_rsci_qa_d_mxwt(twiddle_rsci_qa_d_mxwt_pconst),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt)
    );
  assign twiddle_rsci_qa_d_mxwt = twiddle_rsci_qa_d_mxwt_pconst;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign twiddle_rsci_adra_d = twiddle_rsci_adra_d_reg;
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
  output [27:0] vec_rsci_adra_d;
  output [31:0] vec_rsci_da_d;
  input [63:0] vec_rsci_qa_d;
  output [1:0] vec_rsci_wea_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [13:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [13:0] twiddle_h_rsci_adra_d;
  input [63:0] twiddle_h_rsci_qa_d;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations
  wire core_wten;
  wire run_rsci_ivld_mxwt;
  wire [63:0] vec_rsci_qa_d_mxwt;
  wire [31:0] p_rsci_idat;
  wire [31:0] twiddle_rsci_qa_d_mxwt;
  wire [31:0] twiddle_h_rsci_qa_d_mxwt;
  wire complete_rsci_wen_comp;
  wire [31:0] COMP_LOOP_1_modulo_sub_cmp_return_rsc_z;
  wire COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en;
  wire [31:0] COMP_LOOP_1_modulo_add_cmp_return_rsc_z;
  wire [31:0] COMP_LOOP_1_mult_cmp_return_rsc_z;
  wire COMP_LOOP_1_mult_cmp_ccs_ccore_en;
  wire [8:0] fsm_output;
  wire or_dcpl_138;
  wire or_dcpl_139;
  wire or_dcpl_141;
  wire or_dcpl_142;
  wire or_tmp_59;
  wire nand_tmp_1;
  wire or_tmp_61;
  wire mux_tmp_111;
  wire mux_tmp_112;
  wire or_tmp_63;
  wire or_tmp_64;
  wire mux_tmp_113;
  wire mux_tmp_114;
  wire mux_tmp_116;
  wire or_tmp_67;
  wire mux_tmp_117;
  wire mux_tmp_118;
  wire mux_tmp_123;
  wire or_tmp_70;
  wire or_tmp_71;
  wire or_tmp_72;
  wire or_tmp_74;
  wire or_tmp_75;
  wire mux_tmp_137;
  wire and_dcpl_19;
  wire and_dcpl_20;
  wire and_dcpl_21;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire mux_tmp_150;
  wire mux_tmp_155;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_34;
  wire or_tmp_85;
  wire mux_tmp_162;
  wire or_tmp_86;
  wire or_tmp_89;
  wire mux_tmp_165;
  wire mux_tmp_166;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_38;
  wire and_dcpl_39;
  wire or_tmp_94;
  wire or_tmp_95;
  wire mux_tmp_173;
  wire or_tmp_97;
  wire mux_tmp_175;
  wire mux_tmp_176;
  wire and_dcpl_40;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire and_dcpl_43;
  wire and_dcpl_44;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire nor_tmp_24;
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_56;
  wire and_dcpl_57;
  wire and_dcpl_58;
  wire xor_dcpl;
  wire and_dcpl_60;
  wire and_dcpl_61;
  wire and_dcpl_62;
  wire and_dcpl_63;
  wire and_dcpl_64;
  wire and_dcpl_65;
  wire and_dcpl_66;
  wire and_dcpl_67;
  wire and_dcpl_68;
  wire and_dcpl_69;
  wire and_dcpl_70;
  wire and_dcpl_71;
  wire and_dcpl_72;
  wire and_dcpl_73;
  wire and_dcpl_74;
  wire and_dcpl_75;
  wire and_dcpl_76;
  wire and_dcpl_77;
  wire and_dcpl_78;
  wire and_dcpl_79;
  wire and_dcpl_80;
  wire and_dcpl_81;
  wire and_dcpl_82;
  wire and_dcpl_83;
  wire and_dcpl_84;
  wire and_dcpl_85;
  wire and_dcpl_86;
  wire and_dcpl_87;
  wire and_dcpl_88;
  wire and_dcpl_89;
  wire and_dcpl_90;
  wire and_dcpl_91;
  wire and_dcpl_92;
  wire and_dcpl_93;
  wire and_dcpl_94;
  wire and_dcpl_95;
  wire and_dcpl_96;
  wire and_dcpl_97;
  wire and_dcpl_98;
  wire and_dcpl_99;
  wire and_dcpl_100;
  wire and_dcpl_101;
  wire and_dcpl_102;
  wire and_dcpl_105;
  wire mux_tmp_186;
  wire mux_tmp_187;
  wire or_tmp_126;
  wire mux_tmp_206;
  wire mux_tmp_210;
  wire mux_tmp_212;
  wire mux_tmp_215;
  wire and_dcpl_110;
  wire mux_tmp_230;
  wire or_tmp_164;
  wire or_tmp_165;
  wire mux_tmp_263;
  wire nand_tmp_6;
  wire or_tmp_168;
  wire mux_tmp_266;
  wire mux_tmp_267;
  wire mux_tmp_268;
  wire and_dcpl_118;
  wire and_dcpl_155;
  wire or_tmp_184;
  wire not_tmp_150;
  wire mux_tmp_298;
  wire or_tmp_186;
  wire and_dcpl_164;
  wire and_dcpl_168;
  wire mux_tmp_315;
  wire mux_tmp_319;
  wire or_tmp_209;
  wire mux_tmp_343;
  wire or_tmp_213;
  wire mux_tmp_345;
  wire mux_tmp_346;
  wire mux_tmp_347;
  wire or_tmp_217;
  wire mux_tmp_348;
  wire mux_tmp_350;
  wire mux_tmp_351;
  wire mux_tmp_352;
  wire mux_tmp_379;
  wire or_tmp_233;
  wire or_tmp_234;
  wire or_tmp_278;
  wire mux_tmp_460;
  wire mux_tmp_461;
  wire mux_tmp_499;
  wire and_dcpl_193;
  wire mux_tmp_516;
  reg COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  reg [14:0] STAGE_LOOP_lshift_psp_sva;
  reg [14:0] VEC_LOOP_j_10_14_0_sva_1;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  wire or_284_cse;
  wire or_291_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_2_cse;
  wire or_193_cse;
  wire and_231_cse;
  wire nor_62_cse;
  wire or_228_cse;
  wire or_204_cse;
  wire nor_27_cse;
  wire or_516_cse;
  wire or_502_cse;
  wire or_278_cse;
  wire mux_238_cse;
  wire mux_235_cse;
  wire mux_236_cse;
  wire mux_232_cse;
  wire mux_130_cse;
  wire mux_199_cse;
  wire mux_548_cse;
  wire mux_184_cse;
  wire mux_185_cse;
  wire mux_190_cse;
  wire mux_138_cse;
  wire mux_291_cse;
  wire mux_287_cse;
  wire nand_5_cse;
  wire mux_188_cse;
  wire mux_368_cse;
  wire nand_4_cse;
  wire or_268_cse;
  wire mux_233_cse;
  wire mux_141_cse;
  wire mux_191_cse;
  wire mux_241_cse;
  wire mux_231_cse;
  wire mux_142_cse;
  wire mux_292_cse;
  wire mux_139_cse;
  wire mux_196_cse;
  wire mux_201_cse;
  wire mux_372_cse;
  wire mux_338_cse;
  wire mux_140_cse;
  wire mux_336_cse;
  wire mux_143_cse;
  wire mux_198_cse;
  wire mux_204_cse;
  wire mux_294_cse;
  wire nor_87_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [13:0] twiddle_rsci_adra_d_reg;
  wire [8:0] COMP_LOOP_twiddle_f_mux1h_144_rmff;
  wire COMP_LOOP_twiddle_f_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_30_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_58_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_113_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_161_rmff;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire nor_82_rmff;
  wire [13:0] twiddle_h_rsci_adra_d_reg;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  reg [31:0] factor1_1_sva;
  reg [31:0] VEC_LOOP_mult_vec_1_sva;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [13:0] VEC_LOOP_acc_10_cse_1_sva;
  reg [9:0] COMP_LOOP_17_twiddle_f_lshift_itm;
  reg [31:0] VEC_LOOP_j_1_sva;
  reg [31:0] p_sva;
  wire mux_129_itm;
  wire mux_325_itm;
  wire mux_359_itm;
  wire mux_161_itm;
  wire and_dcpl;
  wire and_dcpl_201;
  wire and_dcpl_202;
  wire and_dcpl_204;
  wire and_dcpl_205;
  wire and_dcpl_206;
  wire and_dcpl_207;
  wire and_dcpl_208;
  wire and_dcpl_209;
  wire and_dcpl_210;
  wire and_dcpl_211;
  wire and_dcpl_212;
  wire and_dcpl_213;
  wire and_dcpl_215;
  wire and_dcpl_216;
  wire and_dcpl_217;
  wire and_dcpl_218;
  wire and_dcpl_219;
  wire and_dcpl_220;
  wire and_dcpl_221;
  wire and_dcpl_222;
  wire and_dcpl_223;
  wire and_dcpl_224;
  wire and_dcpl_226;
  wire and_dcpl_227;
  wire and_dcpl_228;
  wire and_dcpl_229;
  wire and_dcpl_230;
  wire and_dcpl_231;
  wire and_dcpl_233;
  wire and_dcpl_234;
  wire and_dcpl_235;
  wire and_dcpl_236;
  wire and_dcpl_238;
  wire and_dcpl_239;
  wire and_dcpl_240;
  wire and_dcpl_241;
  wire and_dcpl_242;
  wire and_dcpl_243;
  wire and_dcpl_244;
  wire and_dcpl_245;
  wire and_dcpl_246;
  wire and_dcpl_248;
  wire and_dcpl_249;
  wire and_dcpl_250;
  wire and_dcpl_251;
  wire and_dcpl_253;
  wire and_dcpl_254;
  wire and_dcpl_255;
  wire and_dcpl_256;
  wire and_dcpl_257;
  wire and_dcpl_258;
  wire and_dcpl_259;
  wire and_dcpl_260;
  wire and_dcpl_262;
  wire and_dcpl_263;
  wire and_dcpl_264;
  wire and_dcpl_265;
  wire and_dcpl_267;
  wire and_dcpl_269;
  wire and_dcpl_270;
  wire and_dcpl_271;
  wire and_dcpl_272;
  wire and_dcpl_273;
  wire and_dcpl_274;
  wire and_dcpl_275;
  wire and_dcpl_277;
  wire [13:0] z_out;
  wire [27:0] nl_z_out;
  wire [14:0] z_out_1;
  wire and_dcpl_295;
  wire and_dcpl_301;
  wire [13:0] z_out_2;
  wire and_dcpl_328;
  wire [9:0] z_out_3;
  wire [10:0] nl_z_out_3;
  wire and_dcpl_334;
  wire and_dcpl_335;
  wire and_dcpl_336;
  wire mux_tmp_559;
  wire mux_tmp_561;
  wire and_dcpl_337;
  wire and_dcpl_338;
  wire and_dcpl_340;
  wire and_dcpl_344;
  wire and_dcpl_345;
  wire and_dcpl_347;
  wire and_dcpl_352;
  wire and_dcpl_353;
  wire and_dcpl_354;
  wire and_dcpl_355;
  wire and_dcpl_358;
  wire and_dcpl_359;
  wire and_dcpl_361;
  wire and_dcpl_363;
  wire and_dcpl_366;
  wire and_dcpl_367;
  wire and_dcpl_368;
  wire and_dcpl_369;
  wire and_dcpl_371;
  wire and_dcpl_373;
  wire and_dcpl_374;
  wire and_dcpl_375;
  wire and_dcpl_376;
  wire and_dcpl_377;
  wire and_dcpl_379;
  wire and_dcpl_380;
  wire and_dcpl_381;
  wire and_dcpl_382;
  wire and_dcpl_384;
  wire and_dcpl_385;
  wire and_dcpl_386;
  wire and_dcpl_387;
  wire and_dcpl_388;
  wire and_dcpl_390;
  wire and_dcpl_392;
  wire and_dcpl_393;
  wire and_dcpl_394;
  wire and_dcpl_395;
  wire and_dcpl_396;
  wire and_dcpl_397;
  wire and_dcpl_398;
  wire and_dcpl_399;
  wire [18:0] z_out_4;
  wire and_dcpl_410;
  wire and_dcpl_420;
  wire and_dcpl_431;
  wire and_dcpl_440;
  wire and_dcpl_446;
  wire and_dcpl_455;
  wire and_dcpl_460;
  wire and_dcpl_475;
  wire [13:0] z_out_5;
  wire [15:0] nl_z_out_5;
  wire [31:0] z_out_6;
  wire and_dcpl_500;
  wire and_dcpl_567;
  wire and_dcpl_569;
  wire and_dcpl_570;
  wire and_dcpl_571;
  wire and_dcpl_572;
  wire and_dcpl_573;
  wire and_dcpl_574;
  wire and_dcpl_575;
  wire and_dcpl_576;
  wire and_dcpl_577;
  wire and_dcpl_578;
  wire [13:0] z_out_7;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva;
  reg [31:0] VEC_LOOP_j_1_sva_1;
  reg [13:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [12:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva;
  reg [11:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva;
  reg [10:0] COMP_LOOP_9_twiddle_f_lshift_ncse_sva;
  reg [8:0] COMP_LOOP_k_14_5_sva_8_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
  wire [4:0] nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
  wire VEC_LOOP_j_1_sva_mx0c0;
  wire COMP_LOOP_twiddle_f_or_ssc;
  wire VEC_LOOP_or_6_ssc;
  wire COMP_LOOP_twiddle_f_or_7_cse;
  wire COMP_LOOP_twiddle_f_or_12_cse;
  wire COMP_LOOP_twiddle_f_or_16_cse;
  wire COMP_LOOP_twiddle_f_or_17_cse;
  wire VEC_LOOP_or_26_cse;
  wire VEC_LOOP_or_9_cse;
  wire VEC_LOOP_or_10_cse;
  wire VEC_LOOP_or_32_cse;
  wire VEC_LOOP_or_35_cse;
  wire VEC_LOOP_or_19_cse;
  wire nor_97_cse;
  wire nand_27_cse;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire and_474_cse;
  wire and_492_cse;
  wire and_506_cse;
  wire and_518_cse;
  wire and_521_cse;
  wire and_524_cse;
  wire and_463_cse;
  wire and_486_cse;
  wire and_500_cse;
  wire and_516_cse;
  wire and_523_cse;
  wire and_519_cse;
  wire mux_169_cse;
  wire mux_167_cse;
  wire and_497_cse;
  wire and_468_cse;
  wire and_481_cse;
  wire and_484_cse;
  wire and_488_cse;
  wire and_495_cse;
  wire and_498_cse;
  wire and_503_cse;
  wire and_509_cse;
  wire and_512_cse;
  wire and_479_cse;
  wire and_494_cse;
  wire and_508_cse;
  wire and_470_cse;
  wire and_489_cse;
  wire and_504_cse;
  wire and_483_cse;
  wire and_511_cse;
  wire or_tmp;
  wire mux_tmp;
  wire nand_tmp;
  wire nor_tmp_42;
  wire or_tmp_369;
  wire mux_tmp_587;
  wire mux_tmp_588;
  wire mux_tmp_589;
  wire or_tmp_373;
  wire mux_tmp_590;
  wire mux_tmp_593;
  wire mux_tmp_594;
  wire mux_tmp_597;
  wire or_tmp_375;
  wire or_tmp_376;
  wire or_tmp_377;
  wire mux_tmp_608;
  wire or_tmp_378;
  wire mux_tmp_609;
  wire or_tmp_379;
  wire mux_tmp_610;
  wire not_tmp_311;
  wire nand_tmp_19;
  wire nor_tmp_47;
  wire mux_tmp_617;
  wire [13:0] VEC_LOOP_and_4_rgt;
  wire nand_tmp_22;
  wire mux_tmp_661;
  reg VEC_LOOP_acc_12_psp_sva_12;
  reg VEC_LOOP_acc_12_psp_sva_11;
  reg [10:0] VEC_LOOP_acc_12_psp_sva_10_0;
  wire and_173_cse;
  reg [4:0] reg_VEC_LOOP_acc_1_reg;
  reg [8:0] reg_VEC_LOOP_acc_1_1_reg;
  wire or_573_cse;
  wire or_571_cse;
  wire nor_44_cse_1;
  wire or_539_cse;
  wire or_247_cse;
  wire nand_52_cse;
  wire mux_649_cse;
  wire mux_654_cse;
  wire or_564_cse;
  wire mux_633_cse;
  wire or_442_cse;
  wire nand_47_cse;
  wire mux_468_cse;
  wire mux_637_cse;
  wire mux_639_cse;
  wire COMP_LOOP_twiddle_f_nor_1_itm;
  wire COMP_LOOP_twiddle_f_or_itm;
  wire COMP_LOOP_twiddle_f_or_21_itm;
  wire COMP_LOOP_twiddle_f_nor_2_itm;
  wire COMP_LOOP_twiddle_f_or_23_itm;
  wire COMP_LOOP_twiddle_f_nor_3_itm;
  wire COMP_LOOP_twiddle_f_or_28_itm;
  wire COMP_LOOP_twiddle_f_or_39_itm;
  wire COMP_LOOP_twiddle_f_or_40_itm;
  wire VEC_LOOP_nor_3_itm;
  wire VEC_LOOP_or_51_itm;
  wire VEC_LOOP_nor_12_itm;
  wire VEC_LOOP_or_40_itm;
  wire VEC_LOOP_or_43_itm;
  wire VEC_LOOP_or_54_itm;
  wire VEC_LOOP_or_62_itm;
  wire VEC_LOOP_or_66_itm;
  wire VEC_LOOP_or_67_itm;

  wire[0:0] mux_128_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] or_212_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] or_266_nl;
  wire[0:0] mux_197_nl;
  wire[0:0] mux_203_nl;
  wire[0:0] mux_202_nl;
  wire[0:0] mux_240_nl;
  wire[0:0] mux_239_nl;
  wire[0:0] mux_237_nl;
  wire[0:0] mux_234_nl;
  wire[0:0] mux_228_nl;
  wire[0:0] mux_278_nl;
  wire[0:0] mux_277_nl;
  wire[0:0] mux_276_nl;
  wire[0:0] mux_275_nl;
  wire[0:0] or_318_nl;
  wire[0:0] mux_274_nl;
  wire[0:0] or_317_nl;
  wire[0:0] mux_273_nl;
  wire[0:0] mux_272_nl;
  wire[0:0] mux_271_nl;
  wire[0:0] or_316_nl;
  wire[0:0] mux_270_nl;
  wire[0:0] or_315_nl;
  wire[0:0] mux_269_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_30_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_58_nl;
  wire[0:0] mux_290_nl;
  wire[0:0] mux_289_nl;
  wire[0:0] mux_288_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_89_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl;
  wire[0:0] mux_296_nl;
  wire[0:0] mux_295_nl;
  wire[0:0] and_161_nl;
  wire[0:0] mux_305_nl;
  wire[0:0] mux_304_nl;
  wire[0:0] mux_303_nl;
  wire[0:0] nand_7_nl;
  wire[0:0] or_336_nl;
  wire[0:0] mux_302_nl;
  wire[0:0] mux_301_nl;
  wire[0:0] mux_300_nl;
  wire[0:0] or_335_nl;
  wire[0:0] or_333_nl;
  wire[0:0] mux_324_nl;
  wire[0:0] mux_320_nl;
  wire[0:0] mux_316_nl;
  wire[0:0] mux_311_nl;
  wire[0:0] mux_308_nl;
  wire[0:0] mux_340_nl;
  wire[0:0] mux_339_nl;
  wire[0:0] mux_358_nl;
  wire[0:0] mux_357_nl;
  wire[0:0] mux_356_nl;
  wire[0:0] mux_355_nl;
  wire[0:0] mux_354_nl;
  wire[0:0] mux_353_nl;
  wire[0:0] mux_377_nl;
  wire[0:0] nor_55_nl;
  wire[0:0] mux_376_nl;
  wire[0:0] or_377_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_586_nl;
  wire[0:0] mux_585_nl;
  wire[0:0] and_627_nl;
  wire[0:0] mux_584_nl;
  wire[0:0] and_nl;
  wire[0:0] mux_382_nl;
  wire[0:0] nor_53_nl;
  wire[0:0] mux_386_nl;
  wire[0:0] mux_385_nl;
  wire[0:0] nor_52_nl;
  wire[0:0] and_185_nl;
  wire[0:0] mux_384_nl;
  wire[0:0] mux_383_nl;
  wire[31:0] VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_j_not_1_nl;
  wire[0:0] mux_420_nl;
  wire[0:0] mux_416_nl;
  wire[13:0] VEC_LOOP_mux1h_16_nl;
  wire[0:0] and_193_nl;
  wire[0:0] mux_438_nl;
  wire[0:0] VEC_LOOP_or_27_nl;
  wire[0:0] nor_80_nl;
  wire[0:0] mux_471_nl;
  wire[0:0] mux_470_nl;
  wire[0:0] mux_469_nl;
  wire[0:0] mux_467_nl;
  wire[0:0] mux_466_nl;
  wire[0:0] mux_465_nl;
  wire[0:0] mux_464_nl;
  wire[0:0] mux_463_nl;
  wire[0:0] or_444_nl;
  wire[0:0] mux_462_nl;
  wire[0:0] VEC_LOOP_nand_nl;
  wire[0:0] mux_607_nl;
  wire[0:0] mux_606_nl;
  wire[0:0] mux_605_nl;
  wire[0:0] mux_604_nl;
  wire[0:0] mux_603_nl;
  wire[0:0] mux_602_nl;
  wire[0:0] mux_601_nl;
  wire[0:0] mux_600_nl;
  wire[0:0] mux_599_nl;
  wire[0:0] mux_598_nl;
  wire[0:0] mux_596_nl;
  wire[0:0] mux_595_nl;
  wire[0:0] or_546_nl;
  wire[0:0] mux_592_nl;
  wire[0:0] mux_591_nl;
  wire[0:0] or_543_nl;
  wire[0:0] or_542_nl;
  wire[0:0] mux_630_nl;
  wire[0:0] mux_629_nl;
  wire[0:0] mux_628_nl;
  wire[0:0] mux_627_nl;
  wire[0:0] nand_43_nl;
  wire[0:0] mux_626_nl;
  wire[0:0] or_556_nl;
  wire[0:0] mux_625_nl;
  wire[0:0] or_555_nl;
  wire[0:0] mux_624_nl;
  wire[0:0] mux_623_nl;
  wire[0:0] mux_622_nl;
  wire[0:0] mux_621_nl;
  wire[0:0] or_554_nl;
  wire[0:0] mux_620_nl;
  wire[0:0] mux_619_nl;
  wire[0:0] mux_618_nl;
  wire[0:0] mux_614_nl;
  wire[0:0] mux_613_nl;
  wire[0:0] mux_612_nl;
  wire[0:0] mux_611_nl;
  wire[0:0] nand_40_nl;
  wire[0:0] or_552_nl;
  wire[0:0] mux_510_nl;
  wire[0:0] nor_127_nl;
  wire[0:0] or_537_nl;
  wire[0:0] mux_526_nl;
  wire[0:0] mux_525_nl;
  wire[0:0] mux_524_nl;
  wire[0:0] mux_523_nl;
  wire[0:0] mux_522_nl;
  wire[0:0] mux_521_nl;
  wire[0:0] mux_527_nl;
  wire[0:0] nor_126_nl;
  wire[0:0] or_536_nl;
  wire[0:0] mux_636_nl;
  wire[0:0] mux_646_nl;
  wire[0:0] or_565_nl;
  wire[0:0] mux_645_nl;
  wire[0:0] mux_644_nl;
  wire[0:0] mux_643_nl;
  wire[0:0] mux_642_nl;
  wire[0:0] mux_641_nl;
  wire[0:0] mux_640_nl;
  wire[0:0] mux_635_nl;
  wire[0:0] mux_658_nl;
  wire[0:0] mux_657_nl;
  wire[0:0] mux_656_nl;
  wire[0:0] or_575_nl;
  wire[0:0] mux_653_nl;
  wire[0:0] or_572_nl;
  wire[0:0] nand_45_nl;
  wire[0:0] mux_667_nl;
  wire[0:0] mux_666_nl;
  wire[0:0] mux_665_nl;
  wire[0:0] mux_663_nl;
  wire[0:0] nand_49_nl;
  wire[0:0] mux_546_nl;
  wire[0:0] nor_nl;
  wire[0:0] or_nl;
  wire[0:0] mux_547_nl;
  wire[0:0] nor_77_nl;
  wire[0:0] and_245_nl;
  wire[0:0] or_210_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] mux_154_nl;
  wire[0:0] mux_152_nl;
  wire[0:0] mux_160_nl;
  wire[0:0] mux_159_nl;
  wire[0:0] mux_158_nl;
  wire[0:0] mux_156_nl;
  wire[0:0] mux_151_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] or_234_nl;
  wire[0:0] mux_172_nl;
  wire[0:0] mux_171_nl;
  wire[0:0] mux_401_nl;
  wire[0:0] mux_168_nl;
  wire[0:0] mux_393_nl;
  wire[0:0] mux_174_nl;
  wire[0:0] mux_179_nl;
  wire[0:0] mux_178_nl;
  wire[0:0] mux_177_nl;
  wire[0:0] nor_60_nl;
  wire[0:0] nor_61_nl;
  wire[0:0] mux_182_nl;
  wire[0:0] mux_181_nl;
  wire[0:0] mux_180_nl;
  wire[0:0] nor_58_nl;
  wire[0:0] nor_59_nl;
  wire[0:0] mux_183_nl;
  wire[0:0] or_248_nl;
  wire[0:0] mux_262_nl;
  wire[0:0] nand_22_nl;
  wire[0:0] or_307_nl;
  wire[0:0] or_310_nl;
  wire[0:0] mux_265_nl;
  wire[0:0] or_313_nl;
  wire[0:0] mux_264_nl;
  wire[0:0] or_311_nl;
  wire[0:0] or_314_nl;
  wire[0:0] or_330_nl;
  wire[0:0] mux_299_nl;
  wire[0:0] mux_313_nl;
  wire[0:0] mux_342_nl;
  wire[0:0] mux_341_nl;
  wire[0:0] or_357_nl;
  wire[0:0] or_356_nl;
  wire[0:0] mux_344_nl;
  wire[0:0] or_360_nl;
  wire[0:0] mux_349_nl;
  wire[0:0] nor_54_nl;
  wire[0:0] mux_378_nl;
  wire[0:0] mux_498_nl;
  wire[0:0] mux_509_nl;
  wire[0:0] mux_508_nl;
  wire[0:0] mux_504_nl;
  wire[0:0] mux_513_nl;
  wire[0:0] mux_511_nl;
  wire[9:0] VEC_LOOP_mux1h_10_nl;
  wire[0:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] and_118_nl;
  wire[0:0] mux_226_nl;
  wire[0:0] nor_56_nl;
  wire[0:0] mux_225_nl;
  wire[0:0] nor_57_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_112_nl;
  wire[0:0] mux_209_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] mux_207_nl;
  wire[0:0] or_272_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_110_nl;
  wire[0:0] mux_193_nl;
  wire[0:0] mux_192_nl;
  wire[0:0] mux_189_nl;
  wire[8:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_34_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] nor_86_nl;
  wire[0:0] mux_205_nl;
  wire[0:0] or_259_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] nor_85_nl;
  wire[0:0] mux_224_nl;
  wire[0:0] mux_223_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[0:0] mux_219_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] or_279_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] nor_84_nl;
  wire[0:0] mux_242_nl;
  wire[0:0] or_294_nl;
  wire[0:0] VEC_LOOP_mux1h_9_nl;
  wire[0:0] nor_83_nl;
  wire[0:0] mux_261_nl;
  wire[0:0] mux_253_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] mux_247_nl;
  wire[0:0] mux_555_nl;
  wire[0:0] mux_567_nl;
  wire[0:0] mux_566_nl;
  wire[0:0] mux_565_nl;
  wire[0:0] mux_563_nl;
  wire[0:0] mux_562_nl;
  wire[0:0] mux_561_nl;
  wire[0:0] nand_39_nl;
  wire[0:0] mux_616_nl;
  wire[0:0] mux_615_nl;
  wire[0:0] or_585_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_8_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_22_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_353_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_23_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_354_nl;
  wire[1:0] COMP_LOOP_twiddle_f_and_24_nl;
  wire[1:0] COMP_LOOP_twiddle_f_mux1h_355_nl;
  wire[0:0] not_825_nl;
  wire[8:0] COMP_LOOP_twiddle_f_mux1h_356_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_53_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_25_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_26_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_3_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_27_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_357_nl;
  wire[5:0] COMP_LOOP_twiddle_f_mux1h_358_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_54_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_359_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_55_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_360_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_56_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_361_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_9_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl;
  wire[8:0] VEC_LOOP_mux_15_nl;
  wire[8:0] VEC_LOOP_mux_16_nl;
  wire[19:0] acc_1_nl;
  wire[20:0] nl_acc_1_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_5_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_6_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_7_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_9_nl;
  wire[0:0] VEC_LOOP_mux_17_nl;
  wire[13:0] VEC_LOOP_mux1h_38_nl;
  wire[0:0] VEC_LOOP_or_82_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_10_nl;
  wire[8:0] VEC_LOOP_or_83_nl;
  wire[8:0] VEC_LOOP_mux1h_39_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_11_nl;
  wire[0:0] VEC_LOOP_mux_18_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_12_nl;
  wire[0:0] VEC_LOOP_mux_19_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_13_nl;
  wire[0:0] VEC_LOOP_mux_20_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_14_nl;
  wire[0:0] VEC_LOOP_mux_21_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[0:0] VEC_LOOP_mux_22_nl;
  wire[13:0] VEC_LOOP_mux_23_nl;
  wire[0:0] VEC_LOOP_or_84_nl;
  wire[4:0] VEC_LOOP_or_85_nl;
  wire[4:0] VEC_LOOP_VEC_LOOP_nor_1_nl;
  wire[4:0] VEC_LOOP_mux1h_40_nl;
  wire[0:0] and_643_nl;
  wire[32:0] acc_3_nl;
  wire[33:0] nl_acc_3_nl;
  wire[31:0] VEC_LOOP_mux_24_nl;
  wire[0:0] VEC_LOOP_or_86_nl;
  wire[31:0] VEC_LOOP_mux_25_nl;
  wire[14:0] acc_4_nl;
  wire[15:0] nl_acc_4_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_8_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[0:0] VEC_LOOP_mux_26_nl;
  wire[0:0] VEC_LOOP_or_87_nl;
  wire[0:0] VEC_LOOP_mux1h_41_nl;
  wire[10:0] VEC_LOOP_mux1h_42_nl;
  wire[0:0] VEC_LOOP_or_88_nl;
  wire[0:0] VEC_LOOP_or_89_nl;
  wire[0:0] VEC_LOOP_or_90_nl;
  wire[0:0] VEC_LOOP_and_34_nl;
  wire[0:0] VEC_LOOP_and_35_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_5_nl;
  wire[0:0] VEC_LOOP_and_36_nl;
  wire[0:0] VEC_LOOP_mux1h_43_nl;
  wire[0:0] VEC_LOOP_and_37_nl;
  wire[0:0] VEC_LOOP_mux1h_44_nl;
  wire[4:0] VEC_LOOP_and_38_nl;
  wire[4:0] VEC_LOOP_mux1h_45_nl;
  wire[0:0] not_828_nl;
  wire[0:0] VEC_LOOP_or_91_nl;
  wire[0:0] VEC_LOOP_mux1h_46_nl;
  wire[0:0] VEC_LOOP_or_92_nl;
  wire[0:0] VEC_LOOP_mux1h_47_nl;
  wire[0:0] VEC_LOOP_or_93_nl;
  wire[0:0] VEC_LOOP_mux1h_48_nl;
  wire[0:0] VEC_LOOP_or_94_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_6_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = z_out_6;
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
  wire[0:0] mux_374_nl;
  wire [0:0] nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat;
  assign mux_374_nl = MUX_s_1_2_2(mux_336_cse, mux_143_cse, fsm_output[1]);
  assign nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat = ~(mux_374_nl | (fsm_output[0]));
  wire[0:0] and_336_nl;
  wire [3:0] nl_COMP_LOOP_17_twiddle_f_lshift_rg_s;
  assign and_336_nl = (fsm_output==9'b000000010);
  assign nl_COMP_LOOP_17_twiddle_f_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva,
      COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0, and_336_nl);
  wire[0:0] COMP_LOOP_twiddle_f_or_1_nl;
  wire [3:0] nl_COMP_LOOP_1_twiddle_f_lshift_rg_s;
  assign COMP_LOOP_twiddle_f_or_1_nl = (and_dcpl_301 & (~((fsm_output[3]) | (fsm_output[1])))
      & and_dcpl) | (and_dcpl_301 & (fsm_output[3]) & (fsm_output[1]) & and_dcpl)
      | (and_dcpl_295 & (~ (fsm_output[5])) & (~ (fsm_output[4])) & (fsm_output[3])
      & (~ (fsm_output[1])) & and_dcpl_208) | (and_dcpl_295 & (~ (fsm_output[5]))
      & (fsm_output[4]) & (~ (fsm_output[3])) & (fsm_output[1]) & and_dcpl_208);
  assign nl_COMP_LOOP_1_twiddle_f_lshift_rg_s = MUX_v_4_2_2(COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0,
      COMP_LOOP_1_twiddle_f_acc_cse_sva, COMP_LOOP_twiddle_f_or_1_nl);
  wire[31:0] VEC_LOOP_mux_nl;
  wire [63:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      VEC_LOOP_j_1_sva, and_dcpl_31);
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_nl};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (~ mux_161_itm)};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {nor_87_cse , nor_87_cse};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (~ mux_161_itm)};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_129_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro = ~ mux_325_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2 = ~ mux_359_itm;
  wire [27:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core
      = {14'b00000000000000 , COMP_LOOP_twiddle_f_mux1h_144_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_30_rmff , COMP_LOOP_twiddle_f_mux1h_58_rmff , COMP_LOOP_twiddle_f_mux1h_113_rmff
      , COMP_LOOP_twiddle_f_mux1h_161_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , nor_82_rmff};
  wire [27:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core
      = {14'b00000000000000 , COMP_LOOP_twiddle_f_mux1h_144_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_30_rmff , COMP_LOOP_twiddle_f_mux1h_58_rmff , COMP_LOOP_twiddle_f_mux1h_113_rmff
      , COMP_LOOP_twiddle_f_mux1h_161_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , nor_82_rmff};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0
      = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (z_out_7[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_7[11]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ (z_out_7[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_7[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0 = ~ (z_out_7[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0 = ~ (z_out_7[11]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0 = ~ (z_out_7[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0 = ~ (z_out_7[9]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0 = ~ (z_out_4[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = z_out_7[4];
  ccs_in_v1 #(.rscid(32'sd14),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  modulo_sub  COMP_LOOP_1_modulo_sub_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_173_cse),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_173_cse),
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
  .width_z(32'sd15)) COMP_LOOP_17_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_17_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd14)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_1_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out_2)
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
      .vec_rsci_oswt_1_pff(nor_87_cse)
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
      .twiddle_rsci_adra_d(twiddle_rsci_adra_d_reg),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_rsci_adra_d_core(nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core[27:0]),
      .twiddle_rsci_qa_d_mxwt(twiddle_rsci_qa_d_mxwt),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .twiddle_rsci_oswt_pff(nor_82_rmff)
    );
  inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1 inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_adra_d(twiddle_h_rsci_adra_d_reg),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_h_rsci_adra_d_core(nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core[27:0]),
      .twiddle_h_rsci_qa_d_mxwt(twiddle_h_rsci_qa_d_mxwt),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
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
      .COMP_LOOP_17_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_18_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0[0:0]),
      .COMP_LOOP_18_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_19_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0[0:0]),
      .COMP_LOOP_19_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_20_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0[0:0]),
      .COMP_LOOP_20_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_21_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0[0:0]),
      .COMP_LOOP_21_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_22_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0[0:0]),
      .COMP_LOOP_22_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_23_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0[0:0]),
      .COMP_LOOP_23_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_24_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0[0:0]),
      .COMP_LOOP_24_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_25_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0[0:0]),
      .COMP_LOOP_25_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_26_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0[0:0]),
      .COMP_LOOP_26_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_27_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0[0:0]),
      .COMP_LOOP_27_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_28_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0[0:0]),
      .COMP_LOOP_28_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_29_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0[0:0]),
      .COMP_LOOP_29_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_30_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0[0:0]),
      .COMP_LOOP_30_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_31_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0[0:0]),
      .COMP_LOOP_31_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_32_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0[0:0]),
      .COMP_LOOP_32_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_33_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign or_212_nl = (fsm_output[7]) | (~((fsm_output[6]) & or_tmp_63));
  assign mux_125_nl = MUX_s_1_2_2(or_212_nl, mux_tmp_111, fsm_output[4]);
  assign mux_126_nl = MUX_s_1_2_2(mux_125_nl, mux_tmp_114, fsm_output[3]);
  assign mux_127_nl = MUX_s_1_2_2(mux_126_nl, mux_tmp_118, fsm_output[2]);
  assign mux_128_nl = MUX_s_1_2_2(mux_127_nl, mux_tmp_123, fsm_output[5]);
  assign mux_115_nl = MUX_s_1_2_2(mux_tmp_114, mux_tmp_112, fsm_output[3]);
  assign mux_119_nl = MUX_s_1_2_2(mux_tmp_118, mux_115_nl, fsm_output[2]);
  assign mux_124_nl = MUX_s_1_2_2(mux_tmp_123, mux_119_nl, fsm_output[5]);
  assign mux_129_itm = MUX_s_1_2_2(mux_128_nl, mux_124_nl, fsm_output[1]);
  assign mux_138_cse = MUX_s_1_2_2(mux_235_cse, mux_tmp_137, fsm_output[2]);
  assign mux_141_cse = MUX_s_1_2_2(mux_tmp_137, mux_236_cse, fsm_output[2]);
  assign mux_142_cse = MUX_s_1_2_2(mux_141_cse, mux_291_cse, fsm_output[5]);
  assign mux_139_cse = MUX_s_1_2_2(mux_368_cse, mux_138_cse, fsm_output[5]);
  assign mux_140_cse = MUX_s_1_2_2(mux_139_cse, mux_292_cse, fsm_output[3]);
  assign mux_143_cse = MUX_s_1_2_2(mux_292_cse, mux_142_cse, fsm_output[3]);
  assign mux_144_nl = MUX_s_1_2_2(mux_143_cse, mux_140_cse, fsm_output[1]);
  assign nor_87_cse = ~(mux_144_nl | (fsm_output[0]));
  assign mux_190_cse = MUX_s_1_2_2(or_tmp_72, or_tmp_71, fsm_output[3]);
  assign nand_27_cse = ~((fsm_output[3]) & (fsm_output[7]) & (~ (fsm_output[8]))
      & (fsm_output[6]));
  assign mux_188_cse = MUX_s_1_2_2(nand_27_cse, mux_tmp_187, fsm_output[5]);
  assign mux_191_cse = MUX_s_1_2_2(mux_tmp_187, mux_190_cse, fsm_output[5]);
  assign or_266_nl = (~ (fsm_output[3])) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign mux_199_cse = MUX_s_1_2_2(or_tmp_89, or_266_nl, fsm_output[6]);
  assign nand_5_cse = ~((fsm_output[6]) & (~ mux_tmp_166));
  assign nand_4_cse = ~((fsm_output[6]) & (~ mux_tmp_162));
  assign or_268_cse = (fsm_output[6]) | mux_tmp_166;
  assign mux_196_cse = MUX_s_1_2_2(mux_tmp_165, or_tmp_86, fsm_output[4]);
  assign mux_201_cse = MUX_s_1_2_2(or_268_cse, mux_199_cse, fsm_output[4]);
  assign mux_197_nl = MUX_s_1_2_2(or_tmp_86, nand_4_cse, fsm_output[4]);
  assign mux_198_cse = MUX_s_1_2_2(mux_197_nl, mux_196_cse, fsm_output[2]);
  assign mux_202_nl = MUX_s_1_2_2(nand_5_cse, mux_tmp_165, fsm_output[4]);
  assign mux_203_nl = MUX_s_1_2_2(mux_202_nl, mux_201_cse, fsm_output[2]);
  assign mux_204_cse = MUX_s_1_2_2(mux_203_nl, mux_198_cse, fsm_output[5]);
  assign or_284_cse = (fsm_output[8:6]!=3'b101);
  assign or_278_cse = (fsm_output[8:5]!=4'b0101);
  assign or_291_cse = (~ (fsm_output[4])) | (~ (fsm_output[6])) | (fsm_output[8])
      | (fsm_output[7]);
  assign mux_238_cse = MUX_s_1_2_2(or_284_cse, or_tmp_74, fsm_output[4]);
  assign mux_235_cse = MUX_s_1_2_2(or_tmp_75, or_tmp_74, fsm_output[4]);
  assign mux_236_cse = MUX_s_1_2_2(or_tmp_70, or_tmp_72, fsm_output[4]);
  assign mux_232_cse = MUX_s_1_2_2(or_tmp_74, or_tmp_71, fsm_output[4]);
  assign mux_233_cse = MUX_s_1_2_2(mux_tmp_137, mux_232_cse, fsm_output[5]);
  assign mux_239_nl = MUX_s_1_2_2(mux_238_cse, mux_130_cse, fsm_output[5]);
  assign mux_237_nl = MUX_s_1_2_2(mux_236_cse, mux_235_cse, fsm_output[5]);
  assign mux_240_nl = MUX_s_1_2_2(mux_239_nl, mux_237_nl, fsm_output[3]);
  assign mux_234_nl = MUX_s_1_2_2(mux_233_cse, mux_tmp_230, fsm_output[3]);
  assign mux_241_cse = MUX_s_1_2_2(mux_240_nl, mux_234_nl, fsm_output[2]);
  assign mux_228_nl = MUX_s_1_2_2(or_291_cse, mux_130_cse, fsm_output[5]);
  assign mux_231_cse = MUX_s_1_2_2(mux_tmp_230, mux_228_nl, fsm_output[3]);
  assign or_317_nl = COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm | (fsm_output[4])
      | (fsm_output[8]);
  assign mux_274_nl = MUX_s_1_2_2(or_317_nl, or_tmp_165, fsm_output[6]);
  assign or_318_nl = (fsm_output[7]) | mux_274_nl;
  assign mux_275_nl = MUX_s_1_2_2(mux_tmp_268, or_318_nl, fsm_output[2]);
  assign mux_276_nl = MUX_s_1_2_2(mux_275_nl, mux_tmp_266, fsm_output[5]);
  assign mux_277_nl = MUX_s_1_2_2(mux_tmp_267, mux_276_nl, fsm_output[3]);
  assign or_315_nl = (fsm_output[4]) | (fsm_output[8]);
  assign mux_270_nl = MUX_s_1_2_2(or_315_nl, or_tmp_165, fsm_output[6]);
  assign or_316_nl = (fsm_output[7]) | mux_270_nl;
  assign mux_271_nl = MUX_s_1_2_2(or_316_nl, or_tmp_164, fsm_output[2]);
  assign mux_269_nl = MUX_s_1_2_2(nand_tmp_6, mux_tmp_268, fsm_output[2]);
  assign mux_272_nl = MUX_s_1_2_2(mux_271_nl, mux_269_nl, fsm_output[5]);
  assign mux_273_nl = MUX_s_1_2_2(mux_272_nl, mux_tmp_267, fsm_output[3]);
  assign mux_278_nl = MUX_s_1_2_2(mux_277_nl, mux_273_nl, fsm_output[1]);
  assign nor_82_rmff = ~(mux_278_nl | (fsm_output[0]));
  assign COMP_LOOP_twiddle_f_or_7_cse = and_dcpl_118 | (and_dcpl_54 & and_dcpl_42)
      | (and_dcpl_57 & and_dcpl_42) | (and_dcpl_65 & and_dcpl_53) | (and_dcpl_69
      & and_dcpl_53) | (and_dcpl_75 & and_dcpl_64) | (and_dcpl_24 & and_dcpl_72)
      | (and_dcpl_38 & and_dcpl_72) | (and_dcpl_45 & and_dcpl_80) | (and_dcpl_54
      & and_dcpl_85) | (and_dcpl_57 & and_dcpl_85) | (and_dcpl_65 & and_dcpl_89)
      | (and_dcpl_69 & and_dcpl_89) | (and_dcpl_75 & and_dcpl_95) | (and_dcpl_24
      & and_dcpl_99) | (and_dcpl_38 & and_dcpl_99);
  assign COMP_LOOP_twiddle_f_or_12_cse = (and_dcpl_50 & and_dcpl_20) | (and_dcpl_62
      & and_dcpl_42) | (and_dcpl_73 & and_dcpl_64) | (and_dcpl_33 & and_dcpl_72)
      | (and_dcpl_50 & and_dcpl_80) | (and_dcpl_62 & and_dcpl_85) | (and_dcpl_73
      & and_dcpl_95) | (and_dcpl_33 & and_dcpl_99);
  assign COMP_LOOP_twiddle_f_or_16_cse = (and_dcpl_29 & and_dcpl_42) | (and_dcpl_77
      & and_dcpl_64) | (and_dcpl_29 & and_dcpl_85) | (and_dcpl_77 & and_dcpl_95);
  assign COMP_LOOP_twiddle_f_or_17_cse = (and_dcpl_67 & and_dcpl_53) | (and_dcpl_67
      & and_dcpl_89);
  assign COMP_LOOP_twiddle_f_mux1h_30_nl = MUX1HOT_s_1_4_2((z_out[3]), (z_out[2]),
      (z_out[1]), (z_out[0]), {COMP_LOOP_twiddle_f_or_7_cse , COMP_LOOP_twiddle_f_or_12_cse
      , COMP_LOOP_twiddle_f_or_16_cse , COMP_LOOP_twiddle_f_or_17_cse});
  assign COMP_LOOP_twiddle_f_mux1h_30_rmff = COMP_LOOP_twiddle_f_mux1h_30_nl & (~(and_dcpl_60
      & and_dcpl_21 & nor_62_cse));
  assign COMP_LOOP_twiddle_f_mux1h_58_nl = MUX1HOT_s_1_3_2((z_out[2]), (z_out[1]),
      (z_out[0]), {COMP_LOOP_twiddle_f_or_7_cse , COMP_LOOP_twiddle_f_or_12_cse ,
      COMP_LOOP_twiddle_f_or_16_cse});
  assign COMP_LOOP_twiddle_f_mux1h_58_rmff = COMP_LOOP_twiddle_f_mux1h_58_nl & (~(xor_dcpl
      & (~ (fsm_output[0])) & (~((fsm_output[4]) ^ (fsm_output[6]))) & (fsm_output[2:1]==2'b01)
      & and_dcpl_110));
  assign mux_291_cse = MUX_s_1_2_2(mux_232_cse, mux_235_cse, fsm_output[2]);
  assign mux_287_cse = MUX_s_1_2_2(mux_130_cse, mux_232_cse, fsm_output[2]);
  assign mux_292_cse = MUX_s_1_2_2(mux_291_cse, mux_368_cse, fsm_output[5]);
  assign mux_288_nl = MUX_s_1_2_2(or_291_cse, mux_tmp_137, fsm_output[2]);
  assign mux_289_nl = MUX_s_1_2_2(mux_288_nl, mux_287_cse, fsm_output[5]);
  assign mux_290_nl = MUX_s_1_2_2(mux_289_nl, mux_139_cse, fsm_output[3]);
  assign mux_294_cse = MUX_s_1_2_2(mux_140_cse, mux_290_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_89_nl = MUX1HOT_s_1_5_2((z_out[4]), (z_out[3]),
      (z_out[2]), (z_out[1]), (z_out[0]), {COMP_LOOP_twiddle_f_or_7_cse , COMP_LOOP_twiddle_f_or_12_cse
      , COMP_LOOP_twiddle_f_or_16_cse , COMP_LOOP_twiddle_f_or_17_cse , and_dcpl_155});
  assign COMP_LOOP_twiddle_f_and_rmff = COMP_LOOP_twiddle_f_mux1h_89_nl & (~(mux_294_cse
      | (fsm_output[0])));
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl = MUX_s_1_2_2((z_out[1]),
      (z_out[0]), COMP_LOOP_twiddle_f_or_12_cse);
  assign mux_295_nl = MUX_s_1_2_2(mux_tmp_175, mux_tmp_206, fsm_output[6]);
  assign mux_296_nl = MUX_s_1_2_2(mux_295_nl, or_tmp_126, fsm_output[8]);
  assign COMP_LOOP_twiddle_f_mux1h_113_rmff = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl
      & (~((~ mux_296_nl) & and_dcpl_28));
  assign and_161_nl = and_dcpl_43 & and_dcpl_20;
  assign COMP_LOOP_twiddle_f_mux1h_144_rmff = MUX1HOT_v_9_6_2((z_out[8:0]), (z_out[13:5]),
      (z_out[12:4]), (z_out[11:3]), (z_out[10:2]), (z_out[9:1]), {and_161_nl , COMP_LOOP_twiddle_f_or_7_cse
      , COMP_LOOP_twiddle_f_or_12_cse , COMP_LOOP_twiddle_f_or_16_cse , COMP_LOOP_twiddle_f_or_17_cse
      , and_dcpl_155});
  assign nand_7_nl = ~((fsm_output[6]) & (~ mux_tmp_298));
  assign or_336_nl = (fsm_output[6]) | (fsm_output[7]) | (~ (fsm_output[3])) | (fsm_output[5]);
  assign mux_303_nl = MUX_s_1_2_2(nand_7_nl, or_336_nl, fsm_output[8]);
  assign mux_304_nl = MUX_s_1_2_2(or_tmp_186, mux_303_nl, fsm_output[4]);
  assign or_335_nl = (fsm_output[7]) | (fsm_output[3]) | (~ (fsm_output[5]));
  assign mux_300_nl = MUX_s_1_2_2(or_tmp_184, or_335_nl, fsm_output[6]);
  assign or_333_nl = (fsm_output[7:6]!=2'b00) | not_tmp_150;
  assign mux_301_nl = MUX_s_1_2_2(mux_300_nl, or_333_nl, fsm_output[8]);
  assign mux_302_nl = MUX_s_1_2_2(mux_301_nl, or_tmp_186, fsm_output[4]);
  assign mux_305_nl = MUX_s_1_2_2(mux_304_nl, mux_302_nl, fsm_output[2]);
  assign COMP_LOOP_twiddle_f_mux1h_161_rmff = (z_out[0]) & (~((~ mux_305_nl) & and_dcpl_27));
  assign mux_324_nl = MUX_s_1_2_2(mux_204_cse, mux_tmp_319, fsm_output[1]);
  assign mux_308_nl = MUX_s_1_2_2(mux_199_cse, mux_tmp_165, fsm_output[4]);
  assign mux_311_nl = MUX_s_1_2_2(mux_196_cse, mux_308_nl, fsm_output[2]);
  assign mux_316_nl = MUX_s_1_2_2(mux_tmp_315, mux_311_nl, fsm_output[5]);
  assign mux_320_nl = MUX_s_1_2_2(mux_tmp_319, mux_316_nl, fsm_output[1]);
  assign mux_325_itm = MUX_s_1_2_2(mux_324_nl, mux_320_nl, fsm_output[0]);
  assign mux_338_cse = MUX_s_1_2_2(mux_138_cse, mux_287_cse, fsm_output[5]);
  assign mux_336_cse = MUX_s_1_2_2(mux_142_cse, mux_372_cse, fsm_output[3]);
  assign mux_339_nl = MUX_s_1_2_2(mux_372_cse, mux_338_cse, fsm_output[3]);
  assign mux_340_nl = MUX_s_1_2_2(mux_339_nl, mux_336_cse, fsm_output[1]);
  assign and_173_cse = (~ mux_340_nl) & (fsm_output[0]);
  assign mux_356_nl = MUX_s_1_2_2(mux_tmp_352, mux_tmp_345, fsm_output[2]);
  assign mux_357_nl = MUX_s_1_2_2(mux_356_nl, mux_tmp_350, fsm_output[5]);
  assign mux_358_nl = MUX_s_1_2_2(mux_tmp_351, mux_357_nl, fsm_output[3]);
  assign mux_353_nl = MUX_s_1_2_2(mux_tmp_348, mux_tmp_352, fsm_output[2]);
  assign mux_354_nl = MUX_s_1_2_2(mux_tmp_346, mux_353_nl, fsm_output[5]);
  assign mux_355_nl = MUX_s_1_2_2(mux_354_nl, mux_tmp_351, fsm_output[3]);
  assign mux_359_itm = MUX_s_1_2_2(mux_358_nl, mux_355_nl, fsm_output[1]);
  assign mux_368_cse = MUX_s_1_2_2(mux_236_cse, mux_130_cse, fsm_output[2]);
  assign mux_372_cse = MUX_s_1_2_2(mux_287_cse, mux_141_cse, fsm_output[5]);
  assign or_193_cse = (fsm_output[1:0]!=2'b00);
  assign nor_62_cse = ~((fsm_output[6]) | (fsm_output[8]));
  assign or_539_cse = (fsm_output[2]) | (fsm_output[3]) | (fsm_output[4]) | (fsm_output[5])
      | (fsm_output[7]);
  assign mux_416_nl = MUX_s_1_2_2(mux_338_cse, mux_139_cse, fsm_output[3]);
  assign mux_420_nl = MUX_s_1_2_2(mux_140_cse, mux_416_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & (~ mux_420_nl)
      & (fsm_output[0]);
  assign or_442_cse = (fsm_output[6]) | mux_tmp_461;
  assign mux_468_cse = MUX_s_1_2_2(nand_47_cse, or_564_cse, fsm_output[4]);
  assign mux_438_nl = MUX_s_1_2_2((fsm_output[2]), (~ or_516_cse), fsm_output[3]);
  assign and_193_nl = mux_438_nl & (~ (fsm_output[4])) & and_dcpl_20;
  assign VEC_LOOP_or_27_nl = and_dcpl_34 | and_dcpl_44 | and_dcpl_51 | and_dcpl_56
      | and_dcpl_63 | and_dcpl_68 | and_dcpl_74 | and_dcpl_78 | and_dcpl_83 | and_dcpl_86
      | and_dcpl_88 | and_dcpl_91 | and_dcpl_93 | and_dcpl_97 | and_dcpl_100 | and_dcpl_102;
  assign mux_467_nl = MUX_s_1_2_2(or_278_cse, nand_47_cse, fsm_output[4]);
  assign mux_469_nl = MUX_s_1_2_2(mux_468_cse, mux_467_nl, fsm_output[2]);
  assign mux_470_nl = MUX_s_1_2_2(mux_tmp_460, mux_469_nl, fsm_output[3]);
  assign or_444_nl = (~ (fsm_output[5])) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign mux_463_nl = MUX_s_1_2_2(or_444_nl, or_502_cse, fsm_output[6]);
  assign mux_464_nl = MUX_s_1_2_2(mux_463_nl, nand_47_cse, fsm_output[4]);
  assign mux_462_nl = MUX_s_1_2_2(mux_548_cse, or_442_cse, fsm_output[4]);
  assign mux_465_nl = MUX_s_1_2_2(mux_464_nl, mux_462_nl, fsm_output[2]);
  assign mux_466_nl = MUX_s_1_2_2(mux_465_nl, mux_tmp_460, fsm_output[3]);
  assign mux_471_nl = MUX_s_1_2_2(mux_470_nl, mux_466_nl, fsm_output[1]);
  assign nor_80_nl = ~(mux_471_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_16_nl = MUX1HOT_v_14_3_2(({5'b00000 , (z_out_3[8:0])}), z_out_7,
      (VEC_LOOP_j_10_14_0_sva_1[13:0]), {and_193_nl , VEC_LOOP_or_27_nl , nor_80_nl});
  assign VEC_LOOP_nand_nl = ~((~ mux_294_cse) & (fsm_output[0]));
  assign VEC_LOOP_and_4_rgt = MUX_v_14_2_2(14'b00000000000000, VEC_LOOP_mux1h_16_nl,
      VEC_LOOP_nand_nl);
  assign nor_44_cse_1 = ~((fsm_output[1:0]!=2'b00));
  assign or_502_cse = (~ (fsm_output[8])) | (fsm_output[5]) | (fsm_output[7]);
  assign mux_548_cse = MUX_s_1_2_2(or_502_cse, or_tmp_278, fsm_output[6]);
  assign VEC_LOOP_or_26_cse = and_dcpl_39 | and_dcpl_55 | and_dcpl_66 | and_dcpl_76
      | and_dcpl_84 | and_dcpl_90 | and_dcpl_96 | and_dcpl_101;
  assign or_564_cse = (fsm_output[6]) | mux_654_cse;
  assign mux_633_cse = MUX_s_1_2_2(mux_649_cse, mux_548_cse, fsm_output[4]);
  assign mux_636_nl = MUX_s_1_2_2(mux_548_cse, mux_tmp_461, fsm_output[4]);
  assign mux_637_cse = MUX_s_1_2_2(mux_636_nl, nand_tmp_22, fsm_output[0]);
  assign mux_639_cse = MUX_s_1_2_2(or_564_cse, mux_649_cse, fsm_output[4]);
  assign or_573_cse = (fsm_output[8:7]!=2'b10);
  assign or_571_cse = (fsm_output[5]) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign mux_654_cse = MUX_s_1_2_2(or_tmp_85, or_573_cse, fsm_output[5]);
  assign mux_649_cse = MUX_s_1_2_2(or_tmp_278, or_571_cse, fsm_output[6]);
  assign nand_47_cse = ~((fsm_output[6]) & (~ mux_tmp_461));
  assign and_231_cse = (fsm_output[1:0]==2'b11);
  assign or_516_cse = (fsm_output[2:1]!=2'b00);
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b0001;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0 = (~ STAGE_LOOP_i_3_0_sva) +
      4'b1111;
  assign COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0 = nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0[3:0];
  assign or_dcpl_138 = (fsm_output[8:5]!=4'b0000);
  assign or_dcpl_139 = (fsm_output[4:3]!=2'b00);
  assign or_dcpl_141 = or_193_cse | (fsm_output[2]);
  assign or_dcpl_142 = or_dcpl_141 | or_dcpl_139;
  assign or_tmp_59 = ((fsm_output[6]) & (fsm_output[0])) | (fsm_output[8]);
  assign nand_tmp_1 = ~((fsm_output[7]) & (~ or_tmp_59));
  assign or_tmp_61 = (~ (fsm_output[6])) | (fsm_output[8]);
  assign or_204_cse = (fsm_output[6]) | (fsm_output[0]) | (fsm_output[8]);
  assign mux_tmp_111 = MUX_s_1_2_2(or_tmp_61, or_204_cse, fsm_output[7]);
  assign mux_tmp_112 = MUX_s_1_2_2(mux_tmp_111, nand_tmp_1, fsm_output[4]);
  assign or_tmp_63 = (~ (fsm_output[0])) | (fsm_output[8]);
  assign or_tmp_64 = (fsm_output[7:6]!=2'b00) | (~ or_tmp_63);
  assign or_210_nl = (fsm_output[6]) | (fsm_output[0]) | (~ (fsm_output[8]));
  assign mux_tmp_113 = MUX_s_1_2_2(or_210_nl, or_tmp_61, fsm_output[7]);
  assign mux_tmp_114 = MUX_s_1_2_2(mux_tmp_113, or_tmp_64, fsm_output[4]);
  assign mux_tmp_116 = MUX_s_1_2_2(nand_tmp_1, mux_tmp_113, fsm_output[4]);
  assign or_tmp_67 = (fsm_output[7]) | or_tmp_59;
  assign mux_tmp_117 = MUX_s_1_2_2(or_tmp_64, or_tmp_67, fsm_output[4]);
  assign mux_tmp_118 = MUX_s_1_2_2(mux_tmp_117, mux_tmp_116, fsm_output[3]);
  assign mux_121_nl = MUX_s_1_2_2(or_tmp_67, mux_tmp_111, fsm_output[4]);
  assign mux_122_nl = MUX_s_1_2_2(mux_tmp_116, mux_121_nl, fsm_output[3]);
  assign mux_120_nl = MUX_s_1_2_2(mux_tmp_112, mux_tmp_117, fsm_output[3]);
  assign mux_tmp_123 = MUX_s_1_2_2(mux_122_nl, mux_120_nl, fsm_output[2]);
  assign or_tmp_70 = (fsm_output[8:6]!=3'b011);
  assign or_tmp_71 = (fsm_output[8:6]!=3'b010);
  assign or_tmp_72 = (fsm_output[8:6]!=3'b100);
  assign mux_130_cse = MUX_s_1_2_2(or_tmp_71, or_tmp_70, fsm_output[4]);
  assign or_tmp_74 = (fsm_output[8:6]!=3'b001);
  assign or_tmp_75 = (fsm_output[8:6]!=3'b000);
  assign mux_tmp_137 = MUX_s_1_2_2(or_tmp_72, or_tmp_75, fsm_output[4]);
  assign and_dcpl_19 = ~((fsm_output[5]) | (fsm_output[7]));
  assign and_dcpl_20 = and_dcpl_19 & nor_62_cse;
  assign and_dcpl_21 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_23 = nor_44_cse_1 & (fsm_output[2]);
  assign and_dcpl_24 = and_dcpl_23 & and_dcpl_21;
  assign and_dcpl_25 = and_dcpl_24 & and_dcpl_20;
  assign and_dcpl_26 = (fsm_output[4:3]==2'b01);
  assign and_dcpl_27 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_28 = and_dcpl_27 & (~ (fsm_output[2]));
  assign and_dcpl_29 = and_dcpl_28 & and_dcpl_26;
  assign mux_tmp_150 = MUX_s_1_2_2(mux_tmp_137, mux_130_cse, fsm_output[3]);
  assign mux_154_nl = MUX_s_1_2_2(mux_130_cse, mux_235_cse, fsm_output[3]);
  assign mux_152_nl = MUX_s_1_2_2(mux_232_cse, mux_tmp_137, fsm_output[3]);
  assign mux_tmp_155 = MUX_s_1_2_2(mux_154_nl, mux_152_nl, fsm_output[2]);
  assign mux_158_nl = MUX_s_1_2_2(mux_238_cse, mux_236_cse, fsm_output[3]);
  assign mux_159_nl = MUX_s_1_2_2(mux_158_nl, mux_tmp_150, fsm_output[2]);
  assign mux_160_nl = MUX_s_1_2_2(mux_159_nl, mux_tmp_155, fsm_output[5]);
  assign mux_147_nl = MUX_s_1_2_2(mux_236_cse, mux_232_cse, fsm_output[3]);
  assign mux_151_nl = MUX_s_1_2_2(mux_tmp_150, mux_147_nl, fsm_output[2]);
  assign mux_156_nl = MUX_s_1_2_2(mux_tmp_155, mux_151_nl, fsm_output[5]);
  assign mux_161_itm = MUX_s_1_2_2(mux_160_nl, mux_156_nl, fsm_output[1]);
  assign and_dcpl_31 = (~ mux_161_itm) & (fsm_output[0]);
  assign and_dcpl_32 = and_dcpl_27 & (fsm_output[2]);
  assign and_dcpl_33 = and_dcpl_32 & and_dcpl_26;
  assign and_dcpl_34 = and_dcpl_33 & and_dcpl_20;
  assign or_tmp_85 = (fsm_output[8:7]!=2'b01);
  assign or_228_cse = (fsm_output[8:7]!=2'b00);
  assign mux_tmp_162 = MUX_s_1_2_2(or_tmp_85, or_228_cse, fsm_output[3]);
  assign or_tmp_86 = (fsm_output[6]) | mux_tmp_162;
  assign or_tmp_89 = (fsm_output[3]) | (fsm_output[8]) | (fsm_output[7]);
  assign or_234_nl = (~ (fsm_output[3])) | (~ (fsm_output[8])) | (fsm_output[7]);
  assign mux_tmp_165 = MUX_s_1_2_2(or_234_nl, or_tmp_89, fsm_output[6]);
  assign mux_tmp_166 = MUX_s_1_2_2(or_573_cse, or_tmp_85, fsm_output[3]);
  assign mux_169_cse = MUX_s_1_2_2(mux_tmp_165, nand_4_cse, fsm_output[5]);
  assign mux_167_cse = MUX_s_1_2_2(or_268_cse, mux_tmp_165, fsm_output[5]);
  assign mux_401_nl = MUX_s_1_2_2(nand_5_cse, or_tmp_86, fsm_output[5]);
  assign mux_171_nl = MUX_s_1_2_2(mux_401_nl, mux_169_cse, fsm_output[4]);
  assign mux_393_nl = MUX_s_1_2_2(mux_199_cse, or_tmp_86, fsm_output[5]);
  assign mux_168_nl = MUX_s_1_2_2(mux_167_cse, mux_393_nl, fsm_output[4]);
  assign mux_172_nl = MUX_s_1_2_2(mux_171_nl, mux_168_nl, fsm_output[2]);
  assign and_dcpl_35 = (~ mux_172_nl) & nor_44_cse_1;
  assign and_dcpl_36 = (fsm_output[4:3]==2'b11);
  assign and_dcpl_37 = nor_44_cse_1 & (~ (fsm_output[2]));
  assign and_dcpl_38 = and_dcpl_37 & and_dcpl_36;
  assign and_dcpl_39 = and_dcpl_38 & and_dcpl_20;
  assign or_tmp_94 = (fsm_output[4:3]!=2'b10);
  assign or_tmp_95 = (fsm_output[4:3]!=2'b01);
  assign mux_tmp_173 = MUX_s_1_2_2(or_tmp_95, or_tmp_94, fsm_output[5]);
  assign or_tmp_97 = (fsm_output[5:3]!=3'b100);
  assign mux_174_nl = MUX_s_1_2_2(or_dcpl_139, or_tmp_95, fsm_output[5]);
  assign mux_tmp_175 = MUX_s_1_2_2(mux_174_nl, or_tmp_97, fsm_output[7]);
  assign mux_tmp_176 = MUX_s_1_2_2((~ or_tmp_94), and_dcpl_36, fsm_output[5]);
  assign nor_60_nl = ~((fsm_output[5]) | (~ and_dcpl_36));
  assign mux_177_nl = MUX_s_1_2_2(nor_60_nl, mux_tmp_176, fsm_output[7]);
  assign mux_178_nl = MUX_s_1_2_2(mux_177_nl, (~ mux_tmp_175), fsm_output[6]);
  assign nor_61_nl = ~((fsm_output[7:6]!=2'b00) | mux_tmp_173);
  assign mux_179_nl = MUX_s_1_2_2(mux_178_nl, nor_61_nl, fsm_output[8]);
  assign and_dcpl_40 = mux_179_nl & and_dcpl_32;
  assign and_dcpl_41 = (fsm_output[5]) & (~ (fsm_output[7]));
  assign and_dcpl_42 = and_dcpl_41 & nor_62_cse;
  assign and_dcpl_43 = and_dcpl_28 & and_dcpl_21;
  assign and_dcpl_44 = and_dcpl_43 & and_dcpl_42;
  assign and_dcpl_45 = and_dcpl_23 & and_dcpl_26;
  assign and_dcpl_46 = and_dcpl_45 & and_dcpl_42;
  assign nor_tmp_24 = (fsm_output[5:4]==2'b11);
  assign nor_97_cse = ~((fsm_output[5:4]!=2'b00));
  assign mux_180_nl = MUX_s_1_2_2(nor_tmp_24, nor_97_cse, fsm_output[7]);
  assign nor_58_nl = ~((~ (fsm_output[7])) | (fsm_output[5]) | (~ (fsm_output[4])));
  assign mux_181_nl = MUX_s_1_2_2(mux_180_nl, nor_58_nl, fsm_output[6]);
  assign nor_59_nl = ~((fsm_output[7:4]!=4'b0010));
  assign mux_182_nl = MUX_s_1_2_2(mux_181_nl, nor_59_nl, fsm_output[8]);
  assign and_dcpl_49 = mux_182_nl & and_dcpl_27 & (fsm_output[3:2]==2'b00);
  assign and_dcpl_50 = and_dcpl_32 & (~ or_tmp_94);
  assign and_dcpl_51 = and_dcpl_50 & and_dcpl_42;
  assign and_dcpl_52 = (fsm_output[6]) & (~ (fsm_output[8]));
  assign and_dcpl_53 = and_dcpl_19 & and_dcpl_52;
  assign and_dcpl_54 = and_dcpl_37 & and_dcpl_21;
  assign and_dcpl_55 = and_dcpl_54 & and_dcpl_53;
  assign and_dcpl_56 = and_dcpl_29 & and_dcpl_53;
  assign and_dcpl_57 = and_dcpl_23 & (~ or_tmp_94);
  assign and_dcpl_58 = and_dcpl_57 & and_dcpl_53;
  assign and_dcpl_60 = and_dcpl_28 & xor_dcpl;
  assign and_dcpl_61 = and_dcpl_60 & and_dcpl_36 & and_dcpl_52;
  assign and_dcpl_62 = and_dcpl_32 & and_dcpl_36;
  assign and_dcpl_63 = and_dcpl_62 & and_dcpl_53;
  assign and_dcpl_64 = and_dcpl_41 & and_dcpl_52;
  assign and_dcpl_65 = and_dcpl_37 & and_dcpl_26;
  assign and_dcpl_66 = and_dcpl_65 & and_dcpl_64;
  assign and_dcpl_67 = and_dcpl_28 & (~ or_tmp_94);
  assign and_dcpl_68 = and_dcpl_67 & and_dcpl_64;
  assign and_dcpl_69 = and_dcpl_23 & and_dcpl_36;
  assign and_dcpl_70 = and_dcpl_69 & and_dcpl_64;
  assign and_dcpl_71 = (~ (fsm_output[5])) & (fsm_output[7]);
  assign and_dcpl_72 = and_dcpl_71 & nor_62_cse;
  assign and_dcpl_73 = and_dcpl_32 & and_dcpl_21;
  assign and_dcpl_74 = and_dcpl_73 & and_dcpl_72;
  assign and_dcpl_75 = and_dcpl_37 & (~ or_tmp_94);
  assign and_dcpl_76 = and_dcpl_75 & and_dcpl_72;
  assign and_dcpl_77 = and_dcpl_28 & and_dcpl_36;
  assign and_dcpl_78 = and_dcpl_77 & and_dcpl_72;
  assign and_dcpl_79 = (fsm_output[5]) & (fsm_output[7]);
  assign and_dcpl_80 = and_dcpl_79 & nor_62_cse;
  assign and_dcpl_81 = and_dcpl_24 & and_dcpl_80;
  assign and_dcpl_82 = and_dcpl_29 & and_dcpl_80;
  assign and_dcpl_83 = and_dcpl_33 & and_dcpl_80;
  assign and_dcpl_84 = and_dcpl_38 & and_dcpl_80;
  assign and_dcpl_85 = and_dcpl_71 & and_dcpl_52;
  assign and_dcpl_86 = and_dcpl_43 & and_dcpl_85;
  assign and_dcpl_87 = and_dcpl_45 & and_dcpl_85;
  assign and_dcpl_88 = and_dcpl_50 & and_dcpl_85;
  assign and_dcpl_89 = and_dcpl_79 & and_dcpl_52;
  assign and_dcpl_90 = and_dcpl_54 & and_dcpl_89;
  assign and_dcpl_91 = and_dcpl_29 & and_dcpl_89;
  assign and_dcpl_92 = and_dcpl_57 & and_dcpl_89;
  assign and_dcpl_93 = and_dcpl_62 & and_dcpl_89;
  assign and_dcpl_94 = (~ (fsm_output[6])) & (fsm_output[8]);
  assign and_dcpl_95 = and_dcpl_19 & and_dcpl_94;
  assign and_dcpl_96 = and_dcpl_65 & and_dcpl_95;
  assign and_dcpl_97 = and_dcpl_67 & and_dcpl_95;
  assign and_dcpl_98 = and_dcpl_69 & and_dcpl_95;
  assign and_dcpl_99 = and_dcpl_41 & and_dcpl_94;
  assign and_dcpl_100 = and_dcpl_73 & and_dcpl_99;
  assign and_dcpl_101 = and_dcpl_75 & and_dcpl_99;
  assign and_dcpl_102 = and_dcpl_77 & and_dcpl_99;
  assign or_247_cse = (fsm_output[2:1]!=2'b01);
  assign or_248_nl = (fsm_output[2:1]!=2'b10);
  assign mux_183_nl = MUX_s_1_2_2(or_248_nl, or_247_cse, fsm_output[3]);
  assign and_dcpl_105 = ~(mux_183_nl | (fsm_output[0]) | (fsm_output[4]) | (~ and_dcpl_20));
  assign mux_184_cse = MUX_s_1_2_2(or_tmp_70, or_tmp_74, fsm_output[3]);
  assign mux_185_cse = MUX_s_1_2_2(or_tmp_74, or_tmp_72, fsm_output[3]);
  assign mux_tmp_186 = MUX_s_1_2_2(mux_185_cse, mux_184_cse, fsm_output[5]);
  assign mux_tmp_187 = MUX_s_1_2_2(or_tmp_71, or_tmp_75, fsm_output[3]);
  assign or_tmp_126 = (fsm_output[7:5]!=3'b000) | (~ and_dcpl_36);
  assign mux_tmp_206 = MUX_s_1_2_2((~ mux_tmp_176), mux_tmp_173, fsm_output[7]);
  assign mux_tmp_210 = MUX_s_1_2_2(or_tmp_74, or_tmp_70, fsm_output[5]);
  assign mux_tmp_212 = MUX_s_1_2_2(or_tmp_70, or_tmp_75, fsm_output[5]);
  assign mux_tmp_215 = MUX_s_1_2_2(or_tmp_72, or_tmp_74, fsm_output[5]);
  assign and_dcpl_110 = ~((fsm_output[3]) | (fsm_output[8]));
  assign mux_tmp_230 = MUX_s_1_2_2(mux_130_cse, mux_tmp_137, fsm_output[5]);
  assign nand_22_nl = ~((VEC_LOOP_j_10_14_0_sva_1[14]) & (fsm_output[8]));
  assign or_307_nl = (~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (fsm_output[8]);
  assign mux_262_nl = MUX_s_1_2_2(nand_22_nl, or_307_nl, fsm_output[4]);
  assign or_tmp_164 = (fsm_output[7:6]!=2'b00) | mux_262_nl;
  assign or_tmp_165 = (~ (fsm_output[4])) | (~ (VEC_LOOP_j_10_14_0_sva_1[14])) |
      (fsm_output[8]);
  assign or_310_nl = (fsm_output[4]) | (~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (fsm_output[8]);
  assign mux_tmp_263 = MUX_s_1_2_2(or_310_nl, or_tmp_165, fsm_output[6]);
  assign nand_tmp_6 = ~((fsm_output[7]) & (~ mux_tmp_263));
  assign or_tmp_168 = (~ (fsm_output[6])) | (fsm_output[4]) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[8]);
  assign or_313_nl = (fsm_output[6]) | (~((fsm_output[4]) & (VEC_LOOP_j_10_14_0_sva_1[14])
      & (fsm_output[8])));
  assign mux_265_nl = MUX_s_1_2_2(or_313_nl, or_tmp_168, fsm_output[7]);
  assign mux_tmp_266 = MUX_s_1_2_2(mux_265_nl, nand_tmp_6, fsm_output[2]);
  assign or_311_nl = (fsm_output[7]) | mux_tmp_263;
  assign mux_264_nl = MUX_s_1_2_2(or_311_nl, or_tmp_164, fsm_output[2]);
  assign mux_tmp_267 = MUX_s_1_2_2(mux_tmp_266, mux_264_nl, fsm_output[5]);
  assign or_314_nl = (fsm_output[6]) | (~ (fsm_output[4])) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[8]);
  assign mux_tmp_268 = MUX_s_1_2_2(or_tmp_168, or_314_nl, fsm_output[7]);
  assign and_dcpl_118 = and_dcpl_45 & and_dcpl_20;
  assign and_dcpl_155 = and_dcpl_43 & and_dcpl_80;
  assign or_tmp_184 = (~ (fsm_output[7])) | (~ (fsm_output[3])) | (fsm_output[5]);
  assign not_tmp_150 = MUX_s_1_2_2((fsm_output[5]), (~ (fsm_output[5])), fsm_output[3]);
  assign or_330_nl = (fsm_output[3]) | (~ (fsm_output[5]));
  assign mux_tmp_298 = MUX_s_1_2_2(not_tmp_150, or_330_nl, fsm_output[7]);
  assign mux_299_nl = MUX_s_1_2_2(mux_tmp_298, or_tmp_184, fsm_output[6]);
  assign or_tmp_186 = (fsm_output[8]) | mux_299_nl;
  assign and_dcpl_164 = and_dcpl_19 & (fsm_output[6]) & (fsm_output[8]);
  assign and_dcpl_168 = (fsm_output[2:0]==3'b101) & and_dcpl_21 & and_dcpl_164;
  assign mux_313_nl = MUX_s_1_2_2(nand_4_cse, or_268_cse, fsm_output[4]);
  assign mux_tmp_315 = MUX_s_1_2_2(mux_201_cse, mux_313_nl, fsm_output[2]);
  assign mux_tmp_319 = MUX_s_1_2_2(mux_198_cse, mux_tmp_315, fsm_output[5]);
  assign mux_341_nl = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[8]);
  assign mux_342_nl = MUX_s_1_2_2(mux_341_nl, or_tmp_61, fsm_output[0]);
  assign or_tmp_209 = (fsm_output[7]) | mux_342_nl;
  assign or_357_nl = (fsm_output[8]) | (fsm_output[6]);
  assign or_356_nl = (fsm_output[0]) | (fsm_output[8]) | (~ (fsm_output[6]));
  assign mux_tmp_343 = MUX_s_1_2_2(or_357_nl, or_356_nl, fsm_output[7]);
  assign nor_27_cse = ~((fsm_output[7]) | (~ (fsm_output[0])));
  assign or_tmp_213 = nor_27_cse | (fsm_output[8]) | (fsm_output[6]);
  assign mux_tmp_345 = MUX_s_1_2_2(or_tmp_209, or_tmp_213, fsm_output[4]);
  assign mux_344_nl = MUX_s_1_2_2(mux_tmp_343, or_tmp_209, fsm_output[4]);
  assign mux_tmp_346 = MUX_s_1_2_2(mux_tmp_345, mux_344_nl, fsm_output[2]);
  assign or_360_nl = (~ (fsm_output[8])) | (fsm_output[6]);
  assign mux_tmp_347 = MUX_s_1_2_2(or_360_nl, or_204_cse, fsm_output[7]);
  assign or_tmp_217 = nor_27_cse | (fsm_output[8]) | (~ (fsm_output[6]));
  assign mux_tmp_348 = MUX_s_1_2_2(or_tmp_217, mux_tmp_347, fsm_output[4]);
  assign mux_349_nl = MUX_s_1_2_2(mux_tmp_347, mux_tmp_343, fsm_output[4]);
  assign mux_tmp_350 = MUX_s_1_2_2(mux_349_nl, mux_tmp_348, fsm_output[2]);
  assign mux_tmp_351 = MUX_s_1_2_2(mux_tmp_350, mux_tmp_346, fsm_output[5]);
  assign mux_tmp_352 = MUX_s_1_2_2(or_tmp_213, or_tmp_217, fsm_output[4]);
  assign nor_54_nl = ~((fsm_output[7:1]!=7'b0000000));
  assign mux_378_nl = MUX_s_1_2_2((fsm_output[7]), or_539_cse, fsm_output[6]);
  assign mux_tmp_379 = MUX_s_1_2_2(nor_54_nl, mux_378_nl, fsm_output[8]);
  assign or_tmp_233 = (fsm_output[2]) | and_231_cse;
  assign or_tmp_234 = (fsm_output[4]) | ((fsm_output[3]) & or_tmp_233);
  assign or_tmp_278 = (~ (fsm_output[5])) | (fsm_output[8]) | (fsm_output[7]);
  assign mux_tmp_460 = MUX_s_1_2_2(mux_633_cse, mux_639_cse, fsm_output[2]);
  assign mux_tmp_461 = MUX_s_1_2_2(or_228_cse, or_tmp_85, fsm_output[5]);
  assign mux_498_nl = MUX_s_1_2_2(mux_232_cse, or_291_cse, fsm_output[2]);
  assign mux_tmp_499 = MUX_s_1_2_2(mux_498_nl, mux_368_cse, fsm_output[5]);
  assign mux_508_nl = MUX_s_1_2_2(mux_tmp_499, mux_142_cse, fsm_output[3]);
  assign mux_504_nl = MUX_s_1_2_2(mux_139_cse, mux_tmp_499, fsm_output[3]);
  assign mux_509_nl = MUX_s_1_2_2(mux_508_nl, mux_504_nl, fsm_output[1]);
  assign and_dcpl_193 = (~ mux_509_nl) & (fsm_output[0]);
  assign mux_511_nl = MUX_s_1_2_2(or_tmp_75, or_tmp_70, fsm_output[3]);
  assign mux_513_nl = MUX_s_1_2_2(mux_184_cse, mux_511_nl, fsm_output[5]);
  assign mux_tmp_516 = MUX_s_1_2_2(mux_tmp_186, mux_513_nl, fsm_output[1]);
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_24 & and_dcpl_164;
  assign VEC_LOOP_j_1_sva_mx0c0 = and_231_cse & (~ (fsm_output[2])) & and_dcpl_21
      & and_dcpl_20;
  assign xor_dcpl = ~((fsm_output[5]) ^ (fsm_output[7]));
  assign VEC_LOOP_or_9_cse = and_dcpl_25 | and_dcpl_34;
  assign VEC_LOOP_or_10_cse = and_dcpl_44 | and_dcpl_51 | and_dcpl_56 | and_dcpl_63
      | and_dcpl_68 | and_dcpl_74 | and_dcpl_78 | and_dcpl_83 | and_dcpl_86 | and_dcpl_88
      | and_dcpl_91 | and_dcpl_93 | and_dcpl_97 | and_dcpl_100 | and_dcpl_102;
  assign VEC_LOOP_or_32_cse = and_dcpl_46 | and_dcpl_70 | and_dcpl_87 | and_dcpl_98;
  assign VEC_LOOP_or_35_cse = and_dcpl_58 | and_dcpl_92;
  assign VEC_LOOP_or_19_cse = and_dcpl_39 | and_dcpl_44 | and_dcpl_46 | and_dcpl_51
      | and_dcpl_55 | and_dcpl_56 | and_dcpl_58 | and_dcpl_63 | and_dcpl_66 | and_dcpl_68
      | and_dcpl_70 | and_dcpl_74 | and_dcpl_76 | and_dcpl_78 | and_dcpl_81 | and_dcpl_83
      | and_dcpl_84 | and_dcpl_86 | and_dcpl_87 | and_dcpl_88 | and_dcpl_90 | and_dcpl_91
      | and_dcpl_92 | and_dcpl_93 | and_dcpl_96 | and_dcpl_97 | and_dcpl_98 | and_dcpl_100
      | and_dcpl_101 | and_dcpl_102;
  assign VEC_LOOP_mux1h_10_nl = MUX1HOT_v_10_6_2((z_out_5[13:4]), (z_out_7[12:3]),
      (z_out_7[13:4]), (z_out_7[11:2]), (z_out_7[10:1]), (z_out_7[9:0]), {VEC_LOOP_or_9_cse
      , VEC_LOOP_or_26_cse , VEC_LOOP_or_10_cse , VEC_LOOP_or_32_cse , VEC_LOOP_or_35_cse
      , and_dcpl_81});
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_s_1_6_2((z_out_5[3]), (z_out_7[2]), (z_out_7[3]),
      (z_out_7[1]), (z_out_7[0]), (reg_VEC_LOOP_acc_1_1_reg[3]), {VEC_LOOP_or_9_cse
      , VEC_LOOP_or_26_cse , VEC_LOOP_or_10_cse , VEC_LOOP_or_32_cse , VEC_LOOP_or_35_cse
      , and_dcpl_81});
  assign nor_56_nl = ~((~ (fsm_output[7])) | (~ (fsm_output[5])) | (fsm_output[4]));
  assign nor_57_nl = ~((fsm_output[5:4]!=2'b01));
  assign mux_225_nl = MUX_s_1_2_2(nor_57_nl, nor_tmp_24, fsm_output[7]);
  assign mux_226_nl = MUX_s_1_2_2(nor_56_nl, mux_225_nl, fsm_output[6]);
  assign and_118_nl = mux_226_nl & (fsm_output[2:0]==3'b100) & and_dcpl_110;
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_5_2((z_out_5[2]), (z_out_7[1]), (z_out_7[2]),
      (z_out_7[0]), (reg_VEC_LOOP_acc_1_1_reg[2]), {VEC_LOOP_or_9_cse , VEC_LOOP_or_26_cse
      , VEC_LOOP_or_10_cse , VEC_LOOP_or_32_cse , and_118_nl});
  assign or_272_nl = (fsm_output[5:3]!=3'b101);
  assign mux_207_nl = MUX_s_1_2_2(or_272_nl, or_tmp_97, fsm_output[7]);
  assign mux_208_nl = MUX_s_1_2_2(mux_207_nl, mux_tmp_206, fsm_output[6]);
  assign mux_209_nl = MUX_s_1_2_2(mux_208_nl, or_tmp_126, fsm_output[8]);
  assign and_112_nl = (~ mux_209_nl) & and_dcpl_23;
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_4_2((z_out_5[1]), (z_out_7[0]), (z_out_7[1]),
      (reg_VEC_LOOP_acc_1_1_reg[1]), {VEC_LOOP_or_9_cse , VEC_LOOP_or_26_cse , VEC_LOOP_or_10_cse
      , and_112_nl});
  assign mux_192_nl = MUX_s_1_2_2(mux_tmp_186, mux_191_cse, fsm_output[4]);
  assign mux_189_nl = MUX_s_1_2_2(mux_188_cse, mux_tmp_186, fsm_output[4]);
  assign mux_193_nl = MUX_s_1_2_2(mux_192_nl, mux_189_nl, fsm_output[2]);
  assign and_110_nl = (~ mux_193_nl) & nor_44_cse_1;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_3_2((z_out_5[0]), (reg_VEC_LOOP_acc_1_1_reg[0]),
      (z_out_7[0]), {VEC_LOOP_or_9_cse , and_110_nl , VEC_LOOP_or_10_cse});
  assign and_34_nl = and_dcpl_29 & and_dcpl_20;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_9_10_2((z_out_3[8:0]), reg_VEC_LOOP_acc_1_1_reg,
      (VEC_LOOP_acc_10_cse_1_sva[13:5]), (z_out_7[13:5]), ({reg_VEC_LOOP_acc_1_reg
      , (reg_VEC_LOOP_acc_1_1_reg[8:5])}), (z_out_5[13:5]), ({VEC_LOOP_acc_12_psp_sva_12
      , VEC_LOOP_acc_12_psp_sva_11 , (VEC_LOOP_acc_12_psp_sva_10_0[10:4])}), ({VEC_LOOP_acc_12_psp_sva_11
      , (VEC_LOOP_acc_12_psp_sva_10_0[10:3])}), (VEC_LOOP_acc_12_psp_sva_10_0[10:2]),
      (COMP_LOOP_17_twiddle_f_lshift_itm[9:1]), {and_dcpl_25 , and_34_nl , and_dcpl_31
      , and_dcpl_34 , and_dcpl_35 , VEC_LOOP_or_19_cse , and_dcpl_40 , and_dcpl_49
      , and_dcpl_61 , and_dcpl_82});
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_9_2((VEC_LOOP_j_1_sva[4]), (VEC_LOOP_acc_10_cse_1_sva[4]),
      (z_out_7[4]), (reg_VEC_LOOP_acc_1_1_reg[4]), (z_out_5[4]), (VEC_LOOP_acc_12_psp_sva_10_0[3]),
      (VEC_LOOP_acc_12_psp_sva_10_0[2]), (VEC_LOOP_acc_12_psp_sva_10_0[1]), (COMP_LOOP_17_twiddle_f_lshift_itm[0]),
      {and_dcpl_105 , and_dcpl_31 , and_dcpl_34 , and_dcpl_35 , VEC_LOOP_or_19_cse
      , and_dcpl_40 , and_dcpl_49 , and_dcpl_61 , and_dcpl_82});
  assign or_259_nl = (fsm_output[8:2]!=7'b0101010);
  assign mux_205_nl = MUX_s_1_2_2(mux_204_cse, or_259_nl, fsm_output[1]);
  assign nor_86_nl = ~(mux_205_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_8_2((VEC_LOOP_j_1_sva[3]), (VEC_LOOP_acc_10_cse_1_sva[3]),
      (z_out_7[3]), (reg_VEC_LOOP_acc_1_1_reg[3]), (z_out_5[3]), (VEC_LOOP_acc_12_psp_sva_10_0[2]),
      (VEC_LOOP_acc_12_psp_sva_10_0[1]), (VEC_LOOP_acc_12_psp_sva_10_0[0]), {and_dcpl_105
      , and_dcpl_31 , and_dcpl_34 , nor_86_nl , VEC_LOOP_or_19_cse , and_dcpl_40
      , and_dcpl_49 , and_dcpl_61});
  assign mux_220_nl = MUX_s_1_2_2(or_284_cse, or_tmp_71, fsm_output[5]);
  assign mux_221_nl = MUX_s_1_2_2(mux_220_nl, mux_tmp_210, fsm_output[4]);
  assign mux_218_nl = MUX_s_1_2_2(or_tmp_75, or_tmp_71, fsm_output[5]);
  assign mux_219_nl = MUX_s_1_2_2(mux_tmp_215, mux_218_nl, fsm_output[4]);
  assign mux_222_nl = MUX_s_1_2_2(mux_221_nl, mux_219_nl, fsm_output[2]);
  assign mux_216_nl = MUX_s_1_2_2(mux_tmp_212, mux_tmp_215, fsm_output[4]);
  assign mux_213_nl = MUX_s_1_2_2(or_tmp_71, or_tmp_72, fsm_output[5]);
  assign mux_214_nl = MUX_s_1_2_2(mux_213_nl, mux_tmp_212, fsm_output[4]);
  assign mux_217_nl = MUX_s_1_2_2(mux_216_nl, mux_214_nl, fsm_output[2]);
  assign mux_223_nl = MUX_s_1_2_2(mux_222_nl, mux_217_nl, fsm_output[3]);
  assign mux_211_nl = MUX_s_1_2_2(or_278_cse, mux_tmp_210, fsm_output[4]);
  assign or_279_nl = (fsm_output[3:2]!=2'b10) | mux_211_nl;
  assign mux_224_nl = MUX_s_1_2_2(mux_223_nl, or_279_nl, fsm_output[1]);
  assign nor_85_nl = ~(mux_224_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_7_2((VEC_LOOP_j_1_sva[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_7[2]), (reg_VEC_LOOP_acc_1_1_reg[2]), (z_out_5[2]), (VEC_LOOP_acc_12_psp_sva_10_0[1]),
      (VEC_LOOP_acc_12_psp_sva_10_0[0]), {and_dcpl_105 , and_dcpl_31 , and_dcpl_34
      , nor_85_nl , VEC_LOOP_or_19_cse , and_dcpl_40 , and_dcpl_49});
  assign or_294_nl = (fsm_output[2]) | mux_231_cse;
  assign mux_242_nl = MUX_s_1_2_2(mux_241_cse, or_294_nl, fsm_output[1]);
  assign nor_84_nl = ~(mux_242_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_6_2((VEC_LOOP_j_1_sva[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_7[1]), (reg_VEC_LOOP_acc_1_1_reg[1]), (z_out_5[1]), (VEC_LOOP_acc_12_psp_sva_10_0[0]),
      {and_dcpl_105 , and_dcpl_31 , and_dcpl_34 , nor_84_nl , VEC_LOOP_or_19_cse
      , and_dcpl_40});
  assign mux_247_nl = MUX_s_1_2_2(mux_232_cse, mux_236_cse, fsm_output[5]);
  assign mux_248_nl = MUX_s_1_2_2(mux_247_nl, mux_233_cse, fsm_output[3]);
  assign mux_253_nl = MUX_s_1_2_2(mux_231_cse, mux_248_nl, fsm_output[2]);
  assign mux_261_nl = MUX_s_1_2_2(mux_241_cse, mux_253_nl, fsm_output[1]);
  assign nor_83_nl = ~(mux_261_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_9_nl = MUX1HOT_s_1_5_2((VEC_LOOP_j_1_sva[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_7[0]), (reg_VEC_LOOP_acc_1_1_reg[0]), (z_out_5[0]), {and_dcpl_105 ,
      and_dcpl_31 , and_dcpl_34 , nor_83_nl , VEC_LOOP_or_19_cse});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_10_nl , VEC_LOOP_mux1h_8_nl , VEC_LOOP_mux1h_6_nl
      , VEC_LOOP_mux1h_4_nl , VEC_LOOP_mux1h_2_nl , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl
      , VEC_LOOP_mux1h_3_nl , VEC_LOOP_mux1h_5_nl , VEC_LOOP_mux1h_7_nl , VEC_LOOP_mux1h_9_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign twiddle_rsci_adra_d = twiddle_rsci_adra_d_reg;
  assign twiddle_h_rsci_adra_d = twiddle_h_rsci_adra_d_reg;
  assign and_dcpl = ~((fsm_output[2]) | (fsm_output[0]));
  assign and_dcpl_201 = (~ (fsm_output[3])) & (fsm_output[1]);
  assign and_dcpl_202 = and_dcpl_201 & and_dcpl;
  assign and_dcpl_204 = ~((fsm_output[8:7]!=2'b00));
  assign and_dcpl_205 = and_dcpl_204 & (~ (fsm_output[6]));
  assign and_dcpl_206 = and_dcpl_205 & nor_97_cse;
  assign and_dcpl_207 = and_dcpl_206 & and_dcpl_202;
  assign and_dcpl_208 = (fsm_output[2]) & (~ (fsm_output[0]));
  assign and_dcpl_209 = (fsm_output[3]) & (~ (fsm_output[1]));
  assign and_dcpl_210 = and_dcpl_209 & and_dcpl_208;
  assign and_dcpl_211 = and_dcpl_206 & and_dcpl_210;
  assign and_dcpl_212 = and_dcpl_201 & and_dcpl_208;
  assign and_dcpl_213 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_215 = and_dcpl_205 & and_dcpl_213 & and_dcpl_212;
  assign and_dcpl_216 = ~((fsm_output[3]) | (fsm_output[1]));
  assign and_dcpl_217 = and_dcpl_216 & and_dcpl;
  assign and_dcpl_218 = (fsm_output[5:4]==2'b10);
  assign and_dcpl_219 = and_dcpl_205 & and_dcpl_218;
  assign and_dcpl_220 = and_dcpl_219 & and_dcpl_217;
  assign and_dcpl_221 = (fsm_output[3]) & (fsm_output[1]);
  assign and_dcpl_222 = and_dcpl_221 & and_dcpl;
  assign and_dcpl_223 = and_dcpl_219 & and_dcpl_222;
  assign and_dcpl_224 = and_dcpl_216 & and_dcpl_208;
  assign and_dcpl_226 = and_dcpl_205 & nor_tmp_24;
  assign and_dcpl_227 = and_dcpl_226 & and_dcpl_224;
  assign and_dcpl_228 = and_dcpl_221 & and_dcpl_208;
  assign and_dcpl_229 = and_dcpl_226 & and_dcpl_228;
  assign and_dcpl_230 = and_dcpl_209 & and_dcpl;
  assign and_dcpl_231 = and_dcpl_204 & (fsm_output[6]);
  assign and_dcpl_233 = and_dcpl_231 & nor_97_cse & and_dcpl_230;
  assign and_dcpl_234 = and_dcpl_231 & and_dcpl_213;
  assign and_dcpl_235 = and_dcpl_234 & and_dcpl_202;
  assign and_dcpl_236 = and_dcpl_234 & and_dcpl_210;
  assign and_dcpl_238 = and_dcpl_231 & and_dcpl_218 & and_dcpl_212;
  assign and_dcpl_239 = and_dcpl_231 & nor_tmp_24;
  assign and_dcpl_240 = and_dcpl_239 & and_dcpl_217;
  assign and_dcpl_241 = and_dcpl_239 & and_dcpl_222;
  assign and_dcpl_242 = (fsm_output[8:7]==2'b01);
  assign and_dcpl_243 = and_dcpl_242 & (~ (fsm_output[6]));
  assign and_dcpl_244 = and_dcpl_243 & nor_97_cse;
  assign and_dcpl_245 = and_dcpl_244 & and_dcpl_224;
  assign and_dcpl_246 = and_dcpl_244 & and_dcpl_228;
  assign and_dcpl_248 = and_dcpl_243 & and_dcpl_213 & and_dcpl_230;
  assign and_dcpl_249 = and_dcpl_243 & and_dcpl_218;
  assign and_dcpl_250 = and_dcpl_249 & and_dcpl_202;
  assign and_dcpl_251 = and_dcpl_249 & and_dcpl_210;
  assign and_dcpl_253 = and_dcpl_243 & nor_tmp_24 & and_dcpl_212;
  assign and_dcpl_254 = and_dcpl_242 & (fsm_output[6]);
  assign and_dcpl_255 = and_dcpl_254 & nor_97_cse;
  assign and_dcpl_256 = and_dcpl_255 & and_dcpl_217;
  assign and_dcpl_257 = and_dcpl_255 & and_dcpl_222;
  assign and_dcpl_258 = and_dcpl_254 & and_dcpl_213;
  assign and_dcpl_259 = and_dcpl_258 & and_dcpl_224;
  assign and_dcpl_260 = and_dcpl_258 & and_dcpl_228;
  assign and_dcpl_262 = and_dcpl_254 & and_dcpl_218 & and_dcpl_230;
  assign and_dcpl_263 = and_dcpl_254 & nor_tmp_24;
  assign and_dcpl_264 = and_dcpl_263 & and_dcpl_202;
  assign and_dcpl_265 = and_dcpl_263 & and_dcpl_210;
  assign and_dcpl_267 = (fsm_output[8:6]==3'b100);
  assign and_dcpl_269 = and_dcpl_267 & nor_97_cse & and_dcpl_212;
  assign and_dcpl_270 = and_dcpl_267 & and_dcpl_213;
  assign and_dcpl_271 = and_dcpl_270 & and_dcpl_217;
  assign and_dcpl_272 = and_dcpl_270 & and_dcpl_222;
  assign and_dcpl_273 = and_dcpl_267 & and_dcpl_218;
  assign and_dcpl_274 = and_dcpl_273 & and_dcpl_224;
  assign and_dcpl_275 = and_dcpl_273 & and_dcpl_228;
  assign and_dcpl_277 = and_dcpl_267 & nor_tmp_24 & and_dcpl_230;
  assign and_dcpl_295 = ~((fsm_output[8:6]!=3'b000));
  assign and_dcpl_301 = and_dcpl_295 & (fsm_output[5:4]==2'b10);
  assign and_dcpl_328 = (fsm_output[8:6]==3'b101) & nor_97_cse & (fsm_output[3:0]==4'b0011);
  assign and_dcpl_334 = nor_62_cse & (~ (fsm_output[7]));
  assign and_dcpl_335 = and_dcpl_334 & nor_97_cse;
  assign and_dcpl_336 = and_dcpl_335 & and_dcpl_216 & (fsm_output[2]) & (~ (fsm_output[0]));
  assign mux_555_nl = MUX_s_1_2_2(nand_4_cse, mux_199_cse, fsm_output[5]);
  assign mux_tmp_559 = MUX_s_1_2_2(mux_169_cse, mux_555_nl, fsm_output[1]);
  assign mux_tmp_561 = MUX_s_1_2_2(or_tmp_86, or_268_cse, fsm_output[5]);
  assign mux_565_nl = MUX_s_1_2_2(mux_tmp_561, mux_167_cse, fsm_output[1]);
  assign mux_566_nl = MUX_s_1_2_2(mux_tmp_559, mux_565_nl, fsm_output[4]);
  assign mux_561_nl = MUX_s_1_2_2(nand_27_cse, or_tmp_86, fsm_output[5]);
  assign mux_562_nl = MUX_s_1_2_2(mux_561_nl, mux_tmp_561, fsm_output[1]);
  assign mux_563_nl = MUX_s_1_2_2(mux_562_nl, mux_tmp_559, fsm_output[4]);
  assign mux_567_nl = MUX_s_1_2_2(mux_566_nl, mux_563_nl, fsm_output[2]);
  assign and_dcpl_337 = ~(mux_567_nl | (fsm_output[0]));
  assign and_dcpl_338 = (~ (fsm_output[2])) & (fsm_output[0]);
  assign and_dcpl_340 = and_dcpl_201 & and_dcpl_338;
  assign and_dcpl_344 = (fsm_output[8:6]==3'b101) & nor_97_cse & and_dcpl_340;
  assign and_dcpl_345 = (fsm_output[2]) & (fsm_output[0]);
  assign and_dcpl_347 = and_dcpl_221 & and_dcpl_345;
  assign and_dcpl_352 = and_dcpl_273 & and_dcpl_347;
  assign and_dcpl_353 = and_dcpl_216 & and_dcpl_345;
  assign and_dcpl_354 = and_dcpl_273 & and_dcpl_353;
  assign and_dcpl_355 = and_dcpl_221 & and_dcpl_338;
  assign and_dcpl_358 = and_dcpl_267 & and_dcpl_213 & and_dcpl_355;
  assign and_dcpl_359 = and_dcpl_201 & and_dcpl_345;
  assign and_dcpl_361 = and_dcpl_334 & and_dcpl_213 & and_dcpl_359;
  assign and_dcpl_363 = (fsm_output[3]) & (~ (fsm_output[1])) & and_dcpl_345;
  assign and_dcpl_366 = and_dcpl_52 & (fsm_output[7]);
  assign and_dcpl_367 = and_dcpl_366 & nor_tmp_24;
  assign and_dcpl_368 = and_dcpl_367 & and_dcpl_363;
  assign and_dcpl_369 = and_dcpl_367 & and_dcpl_340;
  assign and_dcpl_371 = and_dcpl_267 & nor_97_cse & and_dcpl_359;
  assign and_dcpl_373 = and_dcpl_334 & and_dcpl_218 & and_dcpl_355;
  assign and_dcpl_374 = and_dcpl_366 & and_dcpl_213;
  assign and_dcpl_375 = and_dcpl_374 & and_dcpl_347;
  assign and_dcpl_376 = and_dcpl_374 & and_dcpl_353;
  assign and_dcpl_377 = nor_62_cse & (fsm_output[7]);
  assign and_dcpl_379 = and_dcpl_377 & nor_tmp_24 & and_dcpl_359;
  assign and_dcpl_380 = and_dcpl_377 & and_dcpl_218;
  assign and_dcpl_381 = and_dcpl_380 & and_dcpl_363;
  assign and_dcpl_382 = and_dcpl_380 & and_dcpl_340;
  assign and_dcpl_384 = and_dcpl_366 & nor_97_cse & and_dcpl_355;
  assign and_dcpl_385 = and_dcpl_377 & nor_97_cse;
  assign and_dcpl_386 = and_dcpl_385 & and_dcpl_347;
  assign and_dcpl_387 = and_dcpl_385 & and_dcpl_353;
  assign and_dcpl_388 = and_dcpl_52 & (~ (fsm_output[7]));
  assign and_dcpl_390 = and_dcpl_388 & nor_tmp_24 & and_dcpl_355;
  assign and_dcpl_392 = and_dcpl_388 & and_dcpl_218 & and_dcpl_359;
  assign and_dcpl_393 = and_dcpl_388 & and_dcpl_213;
  assign and_dcpl_394 = and_dcpl_393 & and_dcpl_340;
  assign and_dcpl_395 = and_dcpl_393 & and_dcpl_363;
  assign and_dcpl_396 = and_dcpl_334 & nor_tmp_24;
  assign and_dcpl_397 = and_dcpl_396 & and_dcpl_353;
  assign and_dcpl_398 = and_dcpl_396 & and_dcpl_347;
  assign and_dcpl_399 = and_dcpl_335 & and_dcpl_363;
  assign and_dcpl_410 = and_dcpl_335 & and_dcpl_228;
  assign and_463_cse = and_dcpl_334 & and_dcpl_213 & and_dcpl_230;
  assign and_dcpl_420 = and_dcpl_334 & and_dcpl_218;
  assign and_468_cse = and_dcpl_420 & and_dcpl_202;
  assign and_470_cse = and_dcpl_420 & and_dcpl_210;
  assign and_474_cse = and_dcpl_334 & nor_tmp_24 & and_dcpl_212;
  assign and_dcpl_431 = and_dcpl_388 & nor_97_cse;
  assign and_479_cse = and_dcpl_431 & and_dcpl_217;
  assign and_481_cse = and_dcpl_431 & and_dcpl_222;
  assign and_483_cse = and_dcpl_393 & and_dcpl_224;
  assign and_484_cse = and_dcpl_393 & and_dcpl_228;
  assign and_486_cse = and_dcpl_388 & and_dcpl_218 & and_dcpl_230;
  assign and_dcpl_440 = and_dcpl_388 & nor_tmp_24;
  assign and_488_cse = and_dcpl_440 & and_dcpl_202;
  assign and_489_cse = and_dcpl_440 & and_dcpl_210;
  assign and_492_cse = and_dcpl_377 & nor_97_cse & and_dcpl_212;
  assign and_dcpl_446 = and_dcpl_377 & and_dcpl_213;
  assign and_494_cse = and_dcpl_446 & and_dcpl_217;
  assign and_495_cse = and_dcpl_446 & and_dcpl_222;
  assign and_497_cse = and_dcpl_380 & and_dcpl_224;
  assign and_498_cse = and_dcpl_380 & and_dcpl_228;
  assign and_500_cse = and_dcpl_377 & nor_tmp_24 & and_dcpl_230;
  assign and_dcpl_455 = and_dcpl_366 & nor_97_cse;
  assign and_503_cse = and_dcpl_455 & and_dcpl_202;
  assign and_504_cse = and_dcpl_455 & and_dcpl_210;
  assign and_506_cse = and_dcpl_366 & and_dcpl_213 & and_dcpl_212;
  assign and_dcpl_460 = and_dcpl_366 & and_dcpl_218;
  assign and_508_cse = and_dcpl_460 & and_dcpl_217;
  assign and_509_cse = and_dcpl_460 & and_dcpl_222;
  assign and_511_cse = and_dcpl_367 & and_dcpl_224;
  assign and_512_cse = and_dcpl_367 & and_dcpl_228;
  assign and_516_cse = and_dcpl_267 & nor_97_cse & and_dcpl_230;
  assign and_518_cse = and_dcpl_270 & and_dcpl_202;
  assign and_519_cse = and_dcpl_270 & and_dcpl_210;
  assign and_521_cse = and_dcpl_267 & and_dcpl_218 & and_dcpl_212;
  assign and_dcpl_475 = and_dcpl_267 & nor_tmp_24;
  assign and_523_cse = and_dcpl_475 & and_dcpl_217;
  assign and_524_cse = and_dcpl_475 & and_dcpl_222;
  assign and_dcpl_500 = and_dcpl_334 & nor_97_cse & and_dcpl_228;
  assign and_dcpl_567 = (fsm_output[8:6]==3'b101) & nor_97_cse & and_dcpl_224;
  assign and_dcpl_569 = and_dcpl_209 & and_dcpl_338;
  assign and_dcpl_570 = and_dcpl_475 & and_dcpl_569;
  assign and_dcpl_571 = and_dcpl_216 & and_dcpl_338;
  assign and_dcpl_572 = and_dcpl_420 & and_dcpl_571;
  assign and_dcpl_573 = and_dcpl_270 & and_dcpl_571;
  assign and_dcpl_574 = and_dcpl_460 & and_dcpl_569;
  assign and_dcpl_575 = and_dcpl_455 & and_dcpl_571;
  assign and_dcpl_576 = and_dcpl_440 & and_dcpl_571;
  assign and_dcpl_577 = and_dcpl_446 & and_dcpl_569;
  assign and_dcpl_578 = and_dcpl_431 & and_dcpl_569;
  assign COMP_LOOP_twiddle_f_or_ssc = and_dcpl_220 | and_dcpl_227 | and_dcpl_233
      | and_dcpl_236 | and_dcpl_240 | and_dcpl_245 | and_dcpl_248 | and_dcpl_251
      | and_dcpl_256 | and_dcpl_259 | and_dcpl_262 | and_dcpl_265 | and_dcpl_271
      | and_dcpl_274 | and_dcpl_277;
  assign VEC_LOOP_or_6_ssc = and_dcpl_500 | and_468_cse | and_474_cse | and_481_cse
      | and_484_cse | and_488_cse | and_492_cse | and_495_cse | and_498_cse | and_503_cse
      | and_506_cse | and_509_cse | and_512_cse | and_518_cse | and_521_cse | and_524_cse;
  assign or_tmp = (fsm_output[1]) | (fsm_output[2]) | (fsm_output[3]) | (fsm_output[4])
      | (fsm_output[5]) | (fsm_output[7]);
  assign mux_tmp = MUX_s_1_2_2((~ or_tmp), (fsm_output[7]), fsm_output[8]);
  assign nand_tmp = ~((fsm_output[3]) & (~ or_tmp_233));
  assign nor_tmp_42 = (fsm_output[2:1]==2'b11);
  assign nand_52_cse = ~((fsm_output[1:0]==2'b11));
  assign or_tmp_369 = ~(nand_52_cse & (fsm_output[2]));
  assign mux_tmp_587 = MUX_s_1_2_2((~ or_tmp_369), nor_tmp_42, fsm_output[3]);
  assign mux_tmp_588 = MUX_s_1_2_2((~ mux_tmp_587), nand_tmp, fsm_output[4]);
  assign mux_tmp_589 = MUX_s_1_2_2(or_tmp_233, or_247_cse, fsm_output[3]);
  assign or_tmp_373 = (fsm_output[3]) | (~ nor_tmp_42);
  assign mux_tmp_590 = MUX_s_1_2_2(or_tmp_373, mux_tmp_589, fsm_output[4]);
  assign mux_tmp_593 = MUX_s_1_2_2(or_247_cse, or_tmp_369, fsm_output[3]);
  assign mux_tmp_594 = MUX_s_1_2_2(nand_tmp, mux_tmp_593, fsm_output[4]);
  assign mux_tmp_597 = MUX_s_1_2_2((~ mux_tmp_589), mux_tmp_587, fsm_output[4]);
  assign or_tmp_375 = (fsm_output[0]) | (~ (fsm_output[2]));
  assign or_tmp_376 = and_231_cse | (fsm_output[8]);
  assign or_tmp_377 = (fsm_output[3]) | (~ (fsm_output[1])) | (fsm_output[8]);
  assign nand_39_nl = ~((fsm_output[3]) & (~ or_tmp_376));
  assign mux_tmp_608 = MUX_s_1_2_2(or_tmp_377, nand_39_nl, fsm_output[6]);
  assign or_tmp_378 = (~ (fsm_output[1])) | (fsm_output[8]);
  assign mux_tmp_609 = MUX_s_1_2_2(or_tmp_376, or_tmp_378, fsm_output[3]);
  assign or_tmp_379 = (fsm_output[6]) | mux_tmp_609;
  assign mux_tmp_610 = MUX_s_1_2_2(or_tmp_379, mux_tmp_608, fsm_output[7]);
  assign not_tmp_311 = nand_52_cse & (fsm_output[8]);
  assign nand_tmp_19 = ~((fsm_output[6]) & (~ mux_tmp_609));
  assign nor_tmp_47 = (fsm_output[1]) & (fsm_output[8]);
  assign mux_615_nl = MUX_s_1_2_2(not_tmp_311, nor_tmp_47, fsm_output[3]);
  assign mux_616_nl = MUX_s_1_2_2((~ mux_615_nl), or_tmp_377, fsm_output[6]);
  assign or_585_nl = (fsm_output[6]) | (~ (fsm_output[3])) | or_tmp_376;
  assign mux_tmp_617 = MUX_s_1_2_2(mux_616_nl, or_585_nl, fsm_output[7]);
  assign nand_tmp_22 = ~((fsm_output[4]) & (fsm_output[6]) & (~ mux_tmp_461));
  assign mux_tmp_661 = MUX_s_1_2_2(nand_47_cse, mux_548_cse, fsm_output[3]);
  assign COMP_LOOP_twiddle_f_nor_1_itm = ~(and_dcpl_207 | and_dcpl_215 | and_dcpl_223
      | and_dcpl_229 | and_dcpl_235 | and_dcpl_238 | and_dcpl_241 | and_dcpl_246
      | and_dcpl_250 | and_dcpl_253 | and_dcpl_257 | and_dcpl_260 | and_dcpl_264
      | and_dcpl_269 | and_dcpl_272 | and_dcpl_275);
  assign COMP_LOOP_twiddle_f_or_itm = and_dcpl_211 | and_dcpl_215;
  assign COMP_LOOP_twiddle_f_or_21_itm = and_dcpl_229 | and_dcpl_238 | and_dcpl_246
      | and_dcpl_253 | and_dcpl_260 | and_dcpl_269 | and_dcpl_275;
  assign COMP_LOOP_twiddle_f_nor_2_itm = ~(and_dcpl_207 | and_dcpl_223 | and_dcpl_235
      | and_dcpl_241 | and_dcpl_250 | and_dcpl_257 | and_dcpl_264 | and_dcpl_272);
  assign COMP_LOOP_twiddle_f_or_23_itm = and_dcpl_223 | and_dcpl_241 | and_dcpl_257
      | and_dcpl_272;
  assign COMP_LOOP_twiddle_f_nor_3_itm = ~(and_dcpl_207 | and_dcpl_235 | and_dcpl_250
      | and_dcpl_264);
  assign COMP_LOOP_twiddle_f_or_28_itm = and_dcpl_235 | and_dcpl_264;
  assign COMP_LOOP_twiddle_f_or_39_itm = and_dcpl_215 | and_dcpl_229 | and_dcpl_238
      | and_dcpl_246 | and_dcpl_253 | and_dcpl_260 | and_dcpl_269 | and_dcpl_275;
  assign COMP_LOOP_twiddle_f_or_40_itm = and_dcpl_211 | and_dcpl_220 | and_dcpl_227
      | and_dcpl_233 | and_dcpl_236 | and_dcpl_240 | and_dcpl_245 | and_dcpl_248
      | and_dcpl_251 | and_dcpl_256 | and_dcpl_259 | and_dcpl_262 | and_dcpl_265
      | and_dcpl_271 | and_dcpl_274 | and_dcpl_277;
  assign VEC_LOOP_nor_3_itm = ~(and_dcpl_337 | and_dcpl_344 | and_dcpl_352 | and_dcpl_354
      | and_dcpl_358 | and_dcpl_361 | and_dcpl_368 | and_dcpl_369 | and_dcpl_371
      | and_dcpl_373 | and_dcpl_375 | and_dcpl_376 | and_dcpl_379 | and_dcpl_381
      | and_dcpl_382 | and_dcpl_384 | and_dcpl_386 | and_dcpl_387 | and_dcpl_390
      | and_dcpl_392 | and_dcpl_394 | and_dcpl_395 | and_dcpl_397 | and_dcpl_398
      | and_dcpl_399);
  assign VEC_LOOP_or_51_itm = and_dcpl_352 | and_dcpl_354 | and_dcpl_358 | and_dcpl_361
      | and_dcpl_368 | and_dcpl_369 | and_dcpl_371 | and_dcpl_373 | and_dcpl_375
      | and_dcpl_376 | and_dcpl_379 | and_dcpl_381 | and_dcpl_382 | and_dcpl_384
      | and_dcpl_386 | and_dcpl_387 | and_dcpl_390 | and_dcpl_392 | and_dcpl_394
      | and_dcpl_395 | and_dcpl_397 | and_dcpl_398 | and_dcpl_399;
  assign VEC_LOOP_nor_12_itm = ~(and_497_cse | and_463_cse | and_479_cse | and_486_cse
      | and_494_cse | and_500_cse | and_508_cse | and_516_cse | and_523_cse | and_470_cse
      | and_489_cse | and_504_cse | and_519_cse | and_483_cse | and_511_cse | and_dcpl_567
      | and_dcpl_570 | and_dcpl_572 | and_dcpl_573 | and_dcpl_574 | and_dcpl_575
      | and_dcpl_576 | and_dcpl_577 | and_dcpl_578);
  assign VEC_LOOP_or_40_itm = and_463_cse | and_479_cse | and_486_cse | and_494_cse
      | and_500_cse | and_508_cse | and_516_cse | and_523_cse;
  assign VEC_LOOP_or_43_itm = and_470_cse | and_489_cse | and_504_cse | and_519_cse;
  assign VEC_LOOP_or_54_itm = and_dcpl_572 | and_dcpl_573 | and_dcpl_575 | and_dcpl_576;
  assign VEC_LOOP_or_62_itm = and_470_cse | and_489_cse | and_504_cse | and_519_cse
      | and_dcpl_572 | and_dcpl_573 | and_dcpl_575 | and_dcpl_576;
  assign VEC_LOOP_or_66_itm = and_483_cse | and_511_cse | and_dcpl_574 | and_dcpl_578;
  assign VEC_LOOP_or_67_itm = and_497_cse | and_dcpl_577;
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp ) begin
      VEC_LOOP_mult_vec_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
          and_dcpl_193);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_run_rsci_oswt_cse <= 1'b0;
      reg_vec_rsci_oswt_cse <= 1'b0;
      reg_vec_rsci_oswt_1_cse <= 1'b0;
      reg_twiddle_rsci_oswt_cse <= 1'b0;
      reg_complete_rsci_oswt_cse <= 1'b0;
      reg_vec_rsc_triosy_obj_iswt0_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      reg_ensig_cgo_2_cse <= 1'b0;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= ~(or_dcpl_142 | or_dcpl_138);
      reg_vec_rsci_oswt_cse <= ~ mux_129_itm;
      reg_vec_rsci_oswt_1_cse <= nor_87_cse;
      reg_twiddle_rsci_oswt_cse <= nor_82_rmff;
      reg_complete_rsci_oswt_cse <= and_dcpl_24 & and_dcpl_19 & (fsm_output[6]) &
          (fsm_output[8]) & (z_out_7[4]);
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_168;
      reg_ensig_cgo_cse <= ~ mux_325_itm;
      reg_ensig_cgo_2_cse <= ~ mux_359_itm;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_54 & and_dcpl_20) | STAGE_LOOP_i_3_0_sva_mx0c1)
        ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_377_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_379 ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out_1;
    end
  end
  always @(posedge clk) begin
    if ( mux_586_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_14_5_sva_8_0 <= MUX_v_9_2_2(9'b000000000, (z_out_3[8:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_382_nl | (fsm_output[8:6]!=3'b000)) ) begin
      COMP_LOOP_1_twiddle_f_acc_cse_sva <= COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_386_nl | (fsm_output[8])) ) begin
      COMP_LOOP_17_twiddle_f_lshift_itm <= MUX_v_10_2_2((z_out_1[9:0]), (z_out_7[9:0]),
          and_dcpl_81);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (VEC_LOOP_j_1_sva_mx0c0 | (~(mux_161_itm | (fsm_output[0])))
        | and_dcpl_118) ) begin
      VEC_LOOP_j_1_sva <= MUX_v_32_2_2(32'b00000000000000000000000000000000, VEC_LOOP_mux_2_nl,
          VEC_LOOP_j_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_cse ) begin
      COMP_LOOP_twiddle_help_1_sva <= twiddle_h_rsci_qa_d_mxwt;
      COMP_LOOP_twiddle_f_1_sva <= twiddle_rsci_qa_d_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (and_dcpl_25 | and_dcpl_168) ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm <= MUX_s_1_2_2((z_out_4[18]),
          run_rsci_ivld_mxwt, and_dcpl_168);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_25 | and_dcpl_34 | and_dcpl_39 | and_dcpl_44
        | and_dcpl_46 | and_dcpl_51 | and_dcpl_55 | and_dcpl_56 | and_dcpl_58 | and_dcpl_63
        | and_dcpl_66 | and_dcpl_68 | and_dcpl_70 | and_dcpl_74 | and_dcpl_76 | and_dcpl_78
        | and_dcpl_81 | and_dcpl_83 | and_dcpl_84 | and_dcpl_86 | and_dcpl_87 | and_dcpl_88
        | and_dcpl_90 | and_dcpl_91 | and_dcpl_92 | and_dcpl_93 | and_dcpl_96 | and_dcpl_97
        | and_dcpl_98 | and_dcpl_100 | and_dcpl_101 | and_dcpl_102) ) begin
      VEC_LOOP_acc_10_cse_1_sva <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_193_cse | (~ (fsm_output[2])) | or_dcpl_139
        | or_dcpl_138)) ) begin
      VEC_LOOP_j_1_sva_1 <= z_out_6;
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_607_nl) & complete_rsci_wen_comp ) begin
      reg_VEC_LOOP_acc_1_reg <= VEC_LOOP_and_4_rgt[13:9];
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_630_nl) & complete_rsci_wen_comp ) begin
      reg_VEC_LOOP_acc_1_1_reg <= VEC_LOOP_and_4_rgt[8:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (((~((fsm_output[1]) ^ (fsm_output[3]))) & (fsm_output[0])
        & (fsm_output[2]) & (~ (fsm_output[4])) & and_dcpl_20) | and_dcpl_193) )
        begin
      factor1_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
          and_dcpl_193);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_510_nl ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= z_out_2;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_14_0_sva_1 <= 15'b000000000000000;
    end
    else if ( complete_rsci_wen_comp & (~(mux_526_nl | (fsm_output[0]))) ) begin
      VEC_LOOP_j_10_14_0_sva_1 <= z_out_4[14:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_527_nl ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva <= z_out_2[12:0];
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_646_nl) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_12_psp_sva_12 <= z_out_7[12];
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_658_nl) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_12_psp_sva_11 <= z_out_7[11];
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_667_nl) & nor_44_cse_1 & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_12_psp_sva_10_0 <= z_out_7[10:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_546_nl ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva <= z_out_2[11:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_547_nl | (fsm_output[8])) ) begin
      COMP_LOOP_9_twiddle_f_lshift_ncse_sva <= z_out_2[10:0];
    end
  end
  assign nor_55_nl = ~((fsm_output[7:0]!=8'b00000000));
  assign or_377_nl = (fsm_output[7]) | (fsm_output[5]) | (fsm_output[4]) | (fsm_output[3])
      | (or_193_cse & (fsm_output[2]));
  assign mux_376_nl = MUX_s_1_2_2((fsm_output[7]), or_377_nl, fsm_output[6]);
  assign mux_377_nl = MUX_s_1_2_2(nor_55_nl, mux_376_nl, fsm_output[8]);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_379;
  assign and_627_nl = (fsm_output[8]) & or_539_cse;
  assign mux_585_nl = MUX_s_1_2_2(mux_tmp, and_627_nl, fsm_output[6]);
  assign and_nl = (fsm_output[8]) & or_tmp;
  assign mux_584_nl = MUX_s_1_2_2(mux_tmp, and_nl, fsm_output[6]);
  assign mux_586_nl = MUX_s_1_2_2(mux_585_nl, mux_584_nl, fsm_output[0]);
  assign nor_53_nl = ~((fsm_output[4:2]!=3'b000) | and_231_cse);
  assign mux_382_nl = MUX_s_1_2_2(nor_53_nl, or_tmp_234, fsm_output[5]);
  assign nor_52_nl = ~((fsm_output[5:2]!=4'b0000) | and_231_cse);
  assign mux_383_nl = MUX_s_1_2_2(and_231_cse, (~ or_193_cse), fsm_output[2]);
  assign mux_384_nl = MUX_s_1_2_2(mux_383_nl, or_516_cse, fsm_output[3]);
  assign and_185_nl = (fsm_output[5]) & ((fsm_output[4]) | mux_384_nl);
  assign mux_385_nl = MUX_s_1_2_2(nor_52_nl, and_185_nl, fsm_output[7]);
  assign mux_386_nl = MUX_s_1_2_2(mux_385_nl, (fsm_output[7]), fsm_output[6]);
  assign VEC_LOOP_mux_2_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z,
      VEC_LOOP_j_1_sva_1, and_dcpl_118);
  assign VEC_LOOP_j_not_1_nl = ~ VEC_LOOP_j_1_sva_mx0c0;
  assign mux_601_nl = MUX_s_1_2_2((~ or_tmp_375), or_tmp_375, fsm_output[1]);
  assign mux_602_nl = MUX_s_1_2_2((~ (fsm_output[2])), mux_601_nl, fsm_output[3]);
  assign mux_603_nl = MUX_s_1_2_2(mux_602_nl, or_tmp_373, fsm_output[4]);
  assign mux_604_nl = MUX_s_1_2_2(mux_603_nl, mux_tmp_594, fsm_output[6]);
  assign mux_600_nl = MUX_s_1_2_2((~ mux_tmp_597), mux_tmp_590, fsm_output[6]);
  assign mux_605_nl = MUX_s_1_2_2(mux_604_nl, mux_600_nl, fsm_output[5]);
  assign mux_598_nl = MUX_s_1_2_2(mux_tmp_588, (~ mux_tmp_597), fsm_output[6]);
  assign mux_595_nl = MUX_s_1_2_2(mux_tmp_593, or_tmp_373, fsm_output[4]);
  assign mux_596_nl = MUX_s_1_2_2(mux_595_nl, mux_tmp_594, fsm_output[6]);
  assign mux_599_nl = MUX_s_1_2_2(mux_598_nl, mux_596_nl, fsm_output[5]);
  assign mux_606_nl = MUX_s_1_2_2(mux_605_nl, mux_599_nl, fsm_output[7]);
  assign or_543_nl = (fsm_output[4:0]!=5'b00010);
  assign mux_591_nl = MUX_s_1_2_2(mux_tmp_590, or_543_nl, fsm_output[6]);
  assign or_542_nl = (fsm_output[6]) | mux_tmp_588;
  assign mux_592_nl = MUX_s_1_2_2(mux_591_nl, or_542_nl, fsm_output[5]);
  assign or_546_nl = (fsm_output[7]) | mux_592_nl;
  assign mux_607_nl = MUX_s_1_2_2(mux_606_nl, or_546_nl, fsm_output[8]);
  assign or_556_nl = (fsm_output[0]) | (~ nor_tmp_47);
  assign mux_626_nl = MUX_s_1_2_2(or_556_nl, or_tmp_376, fsm_output[3]);
  assign nand_43_nl = ~((fsm_output[6]) & (~ mux_626_nl));
  assign mux_627_nl = MUX_s_1_2_2(nand_43_nl, nand_tmp_19, fsm_output[7]);
  assign mux_622_nl = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[8]), fsm_output[1]);
  assign mux_623_nl = MUX_s_1_2_2(mux_622_nl, nor_tmp_47, fsm_output[0]);
  assign or_554_nl = (fsm_output[1]) | (fsm_output[8]);
  assign mux_621_nl = MUX_s_1_2_2(or_tmp_378, or_554_nl, fsm_output[0]);
  assign mux_624_nl = MUX_s_1_2_2((~ mux_623_nl), mux_621_nl, fsm_output[3]);
  assign or_555_nl = (fsm_output[6]) | mux_624_nl;
  assign mux_625_nl = MUX_s_1_2_2(or_555_nl, or_tmp_379, fsm_output[7]);
  assign mux_628_nl = MUX_s_1_2_2(mux_627_nl, mux_625_nl, fsm_output[2]);
  assign mux_620_nl = MUX_s_1_2_2(mux_tmp_610, mux_tmp_617, fsm_output[2]);
  assign mux_629_nl = MUX_s_1_2_2(mux_628_nl, mux_620_nl, fsm_output[5]);
  assign mux_614_nl = MUX_s_1_2_2(mux_tmp_608, nand_tmp_19, fsm_output[7]);
  assign mux_618_nl = MUX_s_1_2_2(mux_tmp_617, mux_614_nl, fsm_output[2]);
  assign nand_40_nl = ~((fsm_output[3]) & not_tmp_311);
  assign mux_611_nl = MUX_s_1_2_2(nand_40_nl, mux_tmp_609, fsm_output[6]);
  assign or_552_nl = (~ (fsm_output[6])) | (fsm_output[3]) | (~ (fsm_output[1]))
      | (fsm_output[8]);
  assign mux_612_nl = MUX_s_1_2_2(mux_611_nl, or_552_nl, fsm_output[7]);
  assign mux_613_nl = MUX_s_1_2_2(mux_612_nl, mux_tmp_610, fsm_output[2]);
  assign mux_619_nl = MUX_s_1_2_2(mux_618_nl, mux_613_nl, fsm_output[5]);
  assign mux_630_nl = MUX_s_1_2_2(mux_629_nl, mux_619_nl, fsm_output[4]);
  assign nor_127_nl = ~((fsm_output[7:4]!=4'b0000) | ((fsm_output[3:2]==2'b11) &
      or_193_cse));
  assign or_537_nl = (fsm_output[7:6]!=2'b00) | ((fsm_output[5:3]==3'b111) & or_dcpl_141);
  assign mux_510_nl = MUX_s_1_2_2(nor_127_nl, or_537_nl, fsm_output[8]);
  assign mux_523_nl = MUX_s_1_2_2(mux_190_cse, mux_185_cse, fsm_output[5]);
  assign mux_524_nl = MUX_s_1_2_2(mux_191_cse, mux_523_nl, fsm_output[1]);
  assign mux_525_nl = MUX_s_1_2_2(mux_tmp_516, mux_524_nl, fsm_output[4]);
  assign mux_521_nl = MUX_s_1_2_2(mux_188_cse, mux_191_cse, fsm_output[1]);
  assign mux_522_nl = MUX_s_1_2_2(mux_521_nl, mux_tmp_516, fsm_output[4]);
  assign mux_526_nl = MUX_s_1_2_2(mux_525_nl, mux_522_nl, fsm_output[2]);
  assign nor_126_nl = ~((fsm_output[7:5]!=3'b000) | ((fsm_output[4]) & ((fsm_output[3])
      | ((fsm_output[2:0]==3'b111)))));
  assign or_536_nl = (fsm_output[7:6]!=2'b00) | ((fsm_output[5]) & ((fsm_output[4])
      | ((fsm_output[3:0]==4'b1111))));
  assign mux_527_nl = MUX_s_1_2_2(nor_126_nl, or_536_nl, fsm_output[8]);
  assign mux_642_nl = MUX_s_1_2_2(mux_654_cse, mux_tmp_461, fsm_output[6]);
  assign mux_640_nl = MUX_s_1_2_2(or_tmp_85, (fsm_output[7]), fsm_output[5]);
  assign mux_641_nl = MUX_s_1_2_2(mux_640_nl, or_571_cse, fsm_output[6]);
  assign mux_643_nl = MUX_s_1_2_2(mux_642_nl, mux_641_nl, fsm_output[4]);
  assign mux_644_nl = MUX_s_1_2_2(mux_643_nl, mux_639_cse, fsm_output[0]);
  assign mux_645_nl = MUX_s_1_2_2(mux_644_nl, mux_637_cse, fsm_output[3]);
  assign or_565_nl = (fsm_output[1]) | mux_645_nl;
  assign mux_635_nl = MUX_s_1_2_2(nand_tmp_22, mux_633_cse, fsm_output[3]);
  assign mux_646_nl = MUX_s_1_2_2(or_565_nl, mux_635_nl, fsm_output[2]);
  assign or_575_nl = (fsm_output[0]) | mux_468_cse;
  assign mux_656_nl = MUX_s_1_2_2(or_575_nl, nand_tmp_22, fsm_output[2]);
  assign or_572_nl = (fsm_output[0]) | mux_633_cse;
  assign mux_653_nl = MUX_s_1_2_2(mux_637_cse, or_572_nl, fsm_output[2]);
  assign mux_657_nl = MUX_s_1_2_2(mux_656_nl, mux_653_nl, fsm_output[3]);
  assign nand_45_nl = ~((~ (fsm_output[3])) & (fsm_output[2]) & (fsm_output[4]) &
      (fsm_output[6]) & (~ mux_tmp_461));
  assign mux_658_nl = MUX_s_1_2_2(mux_657_nl, nand_45_nl, fsm_output[1]);
  assign mux_665_nl = MUX_s_1_2_2(or_564_cse, or_442_cse, fsm_output[3]);
  assign mux_666_nl = MUX_s_1_2_2(mux_tmp_661, mux_665_nl, fsm_output[4]);
  assign nand_49_nl = ~((fsm_output[3]) & (~ mux_649_cse));
  assign mux_663_nl = MUX_s_1_2_2(nand_49_nl, mux_tmp_661, fsm_output[4]);
  assign mux_667_nl = MUX_s_1_2_2(mux_666_nl, mux_663_nl, fsm_output[2]);
  assign nor_nl = ~((fsm_output[7:6]!=2'b00) | ((fsm_output[5]) & or_dcpl_142));
  assign or_nl = (fsm_output[7:5]!=3'b000) | ((fsm_output[4:3]==2'b11) & or_tmp_233);
  assign mux_546_nl = MUX_s_1_2_2(nor_nl, or_nl, fsm_output[8]);
  assign nor_77_nl = ~((fsm_output[7]) | ((fsm_output[5]) & or_tmp_234));
  assign and_245_nl = (fsm_output[7]) & (fsm_output[5]) & (fsm_output[4]) & ((fsm_output[3:2]!=2'b00)
      | and_231_cse);
  assign mux_547_nl = MUX_s_1_2_2(nor_77_nl, and_245_nl, fsm_output[6]);
  assign COMP_LOOP_twiddle_f_mux_8_nl = MUX_s_1_2_2((z_out_2[13]), (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[13]),
      COMP_LOOP_twiddle_f_or_ssc);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl = COMP_LOOP_twiddle_f_mux_8_nl
      & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_mux1h_353_nl = MUX1HOT_s_1_3_2((z_out_2[12]), (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[12]),
      (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[12]), {COMP_LOOP_twiddle_f_or_itm ,
      COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_21_itm});
  assign COMP_LOOP_twiddle_f_and_22_nl = COMP_LOOP_twiddle_f_mux1h_353_nl & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_mux1h_354_nl = MUX1HOT_s_1_4_2((z_out_2[11]), (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[11]),
      (COMP_LOOP_5_twiddle_f_lshift_ncse_sva[11]), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[11]),
      {COMP_LOOP_twiddle_f_or_itm , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_23_itm
      , COMP_LOOP_twiddle_f_or_21_itm});
  assign COMP_LOOP_twiddle_f_and_23_nl = COMP_LOOP_twiddle_f_mux1h_354_nl & COMP_LOOP_twiddle_f_nor_3_itm;
  assign COMP_LOOP_twiddle_f_mux1h_355_nl = MUX1HOT_v_2_6_2((z_out_2[10:9]), (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[10:9]),
      (COMP_LOOP_5_twiddle_f_lshift_ncse_sva[10:9]), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[10:9]),
      (COMP_LOOP_9_twiddle_f_lshift_ncse_sva[10:9]), ({1'b0 , (COMP_LOOP_17_twiddle_f_lshift_itm[9])}),
      {COMP_LOOP_twiddle_f_or_itm , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_23_itm
      , COMP_LOOP_twiddle_f_or_21_itm , COMP_LOOP_twiddle_f_or_28_itm , and_dcpl_250});
  assign not_825_nl = ~ and_dcpl_207;
  assign COMP_LOOP_twiddle_f_and_24_nl = MUX_v_2_2_2(2'b00, COMP_LOOP_twiddle_f_mux1h_355_nl,
      not_825_nl);
  assign COMP_LOOP_twiddle_f_or_53_nl = and_dcpl_207 | and_dcpl_211 | and_dcpl_215;
  assign COMP_LOOP_twiddle_f_mux1h_356_nl = MUX1HOT_v_9_6_2((z_out_2[8:0]), (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[8:0]),
      (COMP_LOOP_5_twiddle_f_lshift_ncse_sva[8:0]), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[8:0]),
      (COMP_LOOP_9_twiddle_f_lshift_ncse_sva[8:0]), (COMP_LOOP_17_twiddle_f_lshift_itm[8:0]),
      {COMP_LOOP_twiddle_f_or_53_nl , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_23_itm
      , COMP_LOOP_twiddle_f_or_21_itm , COMP_LOOP_twiddle_f_or_28_itm , and_dcpl_250});
  assign COMP_LOOP_twiddle_f_and_25_nl = (COMP_LOOP_k_14_5_sva_8_0[8]) & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_3_nl = MUX_s_1_2_2((COMP_LOOP_k_14_5_sva_8_0[7]),
      (COMP_LOOP_k_14_5_sva_8_0[8]), COMP_LOOP_twiddle_f_or_39_itm);
  assign COMP_LOOP_twiddle_f_and_26_nl = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_3_nl
      & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_mux1h_357_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_14_5_sva_8_0[6]),
      (COMP_LOOP_k_14_5_sva_8_0[7]), (COMP_LOOP_k_14_5_sva_8_0[8]), {COMP_LOOP_twiddle_f_or_40_itm
      , COMP_LOOP_twiddle_f_or_39_itm , COMP_LOOP_twiddle_f_or_23_itm});
  assign COMP_LOOP_twiddle_f_and_27_nl = COMP_LOOP_twiddle_f_mux1h_357_nl & COMP_LOOP_twiddle_f_nor_3_itm;
  assign COMP_LOOP_twiddle_f_mux1h_358_nl = MUX1HOT_v_6_6_2(({2'b00 , (COMP_LOOP_k_14_5_sva_8_0[8:5])}),
      (COMP_LOOP_k_14_5_sva_8_0[5:0]), (COMP_LOOP_k_14_5_sva_8_0[6:1]), (COMP_LOOP_k_14_5_sva_8_0[7:2]),
      (COMP_LOOP_k_14_5_sva_8_0[8:3]), ({1'b0 , (COMP_LOOP_k_14_5_sva_8_0[8:4])}),
      {and_dcpl_207 , COMP_LOOP_twiddle_f_or_40_itm , COMP_LOOP_twiddle_f_or_39_itm
      , COMP_LOOP_twiddle_f_or_23_itm , COMP_LOOP_twiddle_f_or_28_itm , and_dcpl_250});
  assign COMP_LOOP_twiddle_f_mux1h_359_nl = MUX1HOT_s_1_5_2((COMP_LOOP_k_14_5_sva_8_0[4]),
      (COMP_LOOP_k_14_5_sva_8_0[0]), (COMP_LOOP_k_14_5_sva_8_0[1]), (COMP_LOOP_k_14_5_sva_8_0[2]),
      (COMP_LOOP_k_14_5_sva_8_0[3]), {and_dcpl_207 , COMP_LOOP_twiddle_f_or_39_itm
      , COMP_LOOP_twiddle_f_or_23_itm , COMP_LOOP_twiddle_f_or_28_itm , and_dcpl_250});
  assign COMP_LOOP_twiddle_f_or_54_nl = (COMP_LOOP_twiddle_f_mux1h_359_nl & (~(and_dcpl_211
      | and_dcpl_220 | and_dcpl_227 | and_dcpl_233 | and_dcpl_236 | and_dcpl_240
      | and_dcpl_245 | and_dcpl_248))) | and_dcpl_251 | and_dcpl_256 | and_dcpl_259
      | and_dcpl_262 | and_dcpl_265 | and_dcpl_271 | and_dcpl_274 | and_dcpl_277;
  assign COMP_LOOP_twiddle_f_mux1h_360_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_14_5_sva_8_0[3]),
      (COMP_LOOP_k_14_5_sva_8_0[0]), (COMP_LOOP_k_14_5_sva_8_0[1]), (COMP_LOOP_k_14_5_sva_8_0[2]),
      {and_dcpl_207 , COMP_LOOP_twiddle_f_or_23_itm , COMP_LOOP_twiddle_f_or_28_itm
      , and_dcpl_250});
  assign COMP_LOOP_twiddle_f_or_55_nl = (COMP_LOOP_twiddle_f_mux1h_360_nl & (~(and_dcpl_211
      | and_dcpl_215 | and_dcpl_220 | and_dcpl_227 | and_dcpl_229 | and_dcpl_233
      | and_dcpl_238 | and_dcpl_246 | and_dcpl_251 | and_dcpl_256 | and_dcpl_259
      | and_dcpl_262))) | and_dcpl_236 | and_dcpl_240 | and_dcpl_245 | and_dcpl_248
      | and_dcpl_253 | and_dcpl_260 | and_dcpl_265 | and_dcpl_269 | and_dcpl_271
      | and_dcpl_274 | and_dcpl_275 | and_dcpl_277;
  assign COMP_LOOP_twiddle_f_mux1h_361_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_14_5_sva_8_0[2]),
      (COMP_LOOP_k_14_5_sva_8_0[0]), (COMP_LOOP_k_14_5_sva_8_0[1]), {and_dcpl_207
      , COMP_LOOP_twiddle_f_or_28_itm , and_dcpl_250});
  assign COMP_LOOP_twiddle_f_or_56_nl = (COMP_LOOP_twiddle_f_mux1h_361_nl & (~(and_dcpl_211
      | and_dcpl_215 | and_dcpl_220 | and_dcpl_223 | and_dcpl_229 | and_dcpl_236
      | and_dcpl_240 | and_dcpl_241 | and_dcpl_251 | and_dcpl_253 | and_dcpl_256
      | and_dcpl_260 | and_dcpl_265 | and_dcpl_271))) | and_dcpl_227 | and_dcpl_233
      | and_dcpl_238 | and_dcpl_245 | and_dcpl_246 | and_dcpl_248 | and_dcpl_257
      | and_dcpl_259 | and_dcpl_262 | and_dcpl_269 | and_dcpl_272 | and_dcpl_274
      | and_dcpl_275 | and_dcpl_277;
  assign COMP_LOOP_twiddle_f_mux_9_nl = MUX_s_1_2_2((COMP_LOOP_k_14_5_sva_8_0[1]),
      (COMP_LOOP_k_14_5_sva_8_0[0]), and_dcpl_250);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl = (COMP_LOOP_twiddle_f_mux_9_nl
      & (~(and_dcpl_211 | and_dcpl_215 | and_dcpl_223 | and_dcpl_227 | and_dcpl_235
      | and_dcpl_236 | and_dcpl_238 | and_dcpl_245 | and_dcpl_251 | and_dcpl_253
      | and_dcpl_257 | and_dcpl_259 | and_dcpl_265 | and_dcpl_269 | and_dcpl_274)))
      | and_dcpl_220 | and_dcpl_229 | and_dcpl_233 | and_dcpl_240 | and_dcpl_241
      | and_dcpl_246 | and_dcpl_248 | and_dcpl_256 | and_dcpl_260 | and_dcpl_262
      | and_dcpl_264 | and_dcpl_271 | and_dcpl_272 | and_dcpl_275 | and_dcpl_277;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl = (COMP_LOOP_k_14_5_sva_8_0[0])
      | and_dcpl_211 | and_dcpl_215 | and_dcpl_220 | and_dcpl_223 | and_dcpl_227
      | and_dcpl_229 | and_dcpl_233 | and_dcpl_235 | and_dcpl_236 | and_dcpl_238
      | and_dcpl_240 | and_dcpl_241 | and_dcpl_245 | and_dcpl_246 | and_dcpl_248
      | and_dcpl_251 | and_dcpl_253 | and_dcpl_256 | and_dcpl_257 | and_dcpl_259
      | and_dcpl_260 | and_dcpl_262 | and_dcpl_264 | and_dcpl_265 | and_dcpl_269
      | and_dcpl_271 | and_dcpl_272 | and_dcpl_274 | and_dcpl_275 | and_dcpl_277
      | and_dcpl_250;
  assign nl_z_out = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl , COMP_LOOP_twiddle_f_and_22_nl
      , COMP_LOOP_twiddle_f_and_23_nl , COMP_LOOP_twiddle_f_and_24_nl , COMP_LOOP_twiddle_f_mux1h_356_nl})
      * ({COMP_LOOP_twiddle_f_and_25_nl , COMP_LOOP_twiddle_f_and_26_nl , COMP_LOOP_twiddle_f_and_27_nl
      , COMP_LOOP_twiddle_f_mux1h_358_nl , COMP_LOOP_twiddle_f_or_54_nl , COMP_LOOP_twiddle_f_or_55_nl
      , COMP_LOOP_twiddle_f_or_56_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl});
  assign z_out = nl_z_out[13:0];
  assign VEC_LOOP_mux_15_nl = MUX_v_9_2_2((VEC_LOOP_j_1_sva[13:5]), COMP_LOOP_k_14_5_sva_8_0,
      and_dcpl_328);
  assign VEC_LOOP_mux_16_nl = MUX_v_9_2_2(COMP_LOOP_k_14_5_sva_8_0, 9'b000000001,
      and_dcpl_328);
  assign nl_z_out_3 = conv_u2u_9_10(VEC_LOOP_mux_15_nl) + conv_u2u_9_10(VEC_LOOP_mux_16_nl);
  assign z_out_3 = nl_z_out_3[9:0];
  assign VEC_LOOP_VEC_LOOP_and_5_nl = (z_out_6[31]) & VEC_LOOP_nor_3_itm;
  assign VEC_LOOP_VEC_LOOP_and_6_nl = (z_out_6[30]) & VEC_LOOP_nor_3_itm;
  assign VEC_LOOP_VEC_LOOP_and_7_nl = (z_out_6[29]) & VEC_LOOP_nor_3_itm;
  assign VEC_LOOP_mux_17_nl = MUX_s_1_2_2((z_out_6[28]), (z_out_3[9]), and_dcpl_344);
  assign VEC_LOOP_VEC_LOOP_or_9_nl = (VEC_LOOP_mux_17_nl & (~ and_dcpl_337)) | and_dcpl_352
      | and_dcpl_354 | and_dcpl_358 | and_dcpl_361 | and_dcpl_368 | and_dcpl_369
      | and_dcpl_371 | and_dcpl_373 | and_dcpl_375 | and_dcpl_376 | and_dcpl_379
      | and_dcpl_381 | and_dcpl_382 | and_dcpl_384 | and_dcpl_386 | and_dcpl_387
      | and_dcpl_390 | and_dcpl_392 | and_dcpl_394 | and_dcpl_395 | and_dcpl_397
      | and_dcpl_398 | and_dcpl_399;
  assign VEC_LOOP_mux1h_38_nl = MUX1HOT_v_14_4_2((z_out_6[27:14]), ({reg_VEC_LOOP_acc_1_reg
      , reg_VEC_LOOP_acc_1_1_reg}), ({(z_out_3[8:0]) , 5'b00000}), (~ (STAGE_LOOP_lshift_psp_sva[14:1])),
      {and_dcpl_336 , and_dcpl_337 , and_dcpl_344 , VEC_LOOP_or_51_itm});
  assign VEC_LOOP_or_82_nl = (~(and_dcpl_336 | and_dcpl_337)) | and_dcpl_344 | and_dcpl_352
      | and_dcpl_354 | and_dcpl_358 | and_dcpl_361 | and_dcpl_368 | and_dcpl_369
      | and_dcpl_371 | and_dcpl_373 | and_dcpl_375 | and_dcpl_376 | and_dcpl_379
      | and_dcpl_381 | and_dcpl_382 | and_dcpl_384 | and_dcpl_386 | and_dcpl_387
      | and_dcpl_390 | and_dcpl_392 | and_dcpl_394 | and_dcpl_395 | and_dcpl_397
      | and_dcpl_398 | and_dcpl_399;
  assign VEC_LOOP_VEC_LOOP_or_10_nl = ((STAGE_LOOP_lshift_psp_sva[14]) & (~(and_dcpl_352
      | and_dcpl_354 | and_dcpl_358 | and_dcpl_361 | and_dcpl_368 | and_dcpl_369
      | and_dcpl_371 | and_dcpl_373 | and_dcpl_375 | and_dcpl_376 | and_dcpl_379
      | and_dcpl_381 | and_dcpl_382 | and_dcpl_384 | and_dcpl_386 | and_dcpl_387
      | and_dcpl_390 | and_dcpl_392 | and_dcpl_394 | and_dcpl_395 | and_dcpl_397
      | and_dcpl_398 | and_dcpl_399))) | and_dcpl_336 | and_dcpl_344;
  assign VEC_LOOP_mux1h_39_nl = MUX1HOT_v_9_3_2((STAGE_LOOP_lshift_psp_sva[13:5]),
      (~ (STAGE_LOOP_lshift_psp_sva[14:6])), COMP_LOOP_k_14_5_sva_8_0, {and_dcpl_337
      , and_dcpl_344 , VEC_LOOP_or_51_itm});
  assign VEC_LOOP_or_83_nl = MUX_v_9_2_2(VEC_LOOP_mux1h_39_nl, 9'b111111111, and_dcpl_336);
  assign VEC_LOOP_mux_18_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[4]), (~ (STAGE_LOOP_lshift_psp_sva[5])),
      and_dcpl_344);
  assign VEC_LOOP_VEC_LOOP_or_11_nl = (VEC_LOOP_mux_18_nl & (~(and_dcpl_361 | and_dcpl_373
      | and_dcpl_386 | and_dcpl_387 | and_dcpl_390 | and_dcpl_392 | and_dcpl_394
      | and_dcpl_395 | and_dcpl_397 | and_dcpl_398 | and_dcpl_399))) | and_dcpl_336
      | and_dcpl_352 | and_dcpl_354 | and_dcpl_358 | and_dcpl_368 | and_dcpl_369
      | and_dcpl_371 | and_dcpl_375 | and_dcpl_376 | and_dcpl_379 | and_dcpl_381
      | and_dcpl_382 | and_dcpl_384;
  assign VEC_LOOP_mux_19_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[3]), (~ (STAGE_LOOP_lshift_psp_sva[4])),
      and_dcpl_344);
  assign VEC_LOOP_VEC_LOOP_or_12_nl = (VEC_LOOP_mux_19_nl & (~(and_dcpl_361 | and_dcpl_373
      | and_dcpl_375 | and_dcpl_376 | and_dcpl_379 | and_dcpl_381 | and_dcpl_382
      | and_dcpl_384 | and_dcpl_397 | and_dcpl_398 | and_dcpl_399))) | and_dcpl_336
      | and_dcpl_352 | and_dcpl_354 | and_dcpl_358 | and_dcpl_368 | and_dcpl_369
      | and_dcpl_371 | and_dcpl_386 | and_dcpl_387 | and_dcpl_390 | and_dcpl_392
      | and_dcpl_394 | and_dcpl_395;
  assign VEC_LOOP_mux_20_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[2]), (~ (STAGE_LOOP_lshift_psp_sva[3])),
      and_dcpl_344);
  assign VEC_LOOP_VEC_LOOP_or_13_nl = (VEC_LOOP_mux_20_nl & (~(and_dcpl_361 | and_dcpl_368
      | and_dcpl_369 | and_dcpl_371 | and_dcpl_379 | and_dcpl_381 | and_dcpl_382
      | and_dcpl_392 | and_dcpl_394 | and_dcpl_395 | and_dcpl_399))) | and_dcpl_336
      | and_dcpl_352 | and_dcpl_354 | and_dcpl_358 | and_dcpl_373 | and_dcpl_375
      | and_dcpl_376 | and_dcpl_384 | and_dcpl_386 | and_dcpl_387 | and_dcpl_390
      | and_dcpl_397 | and_dcpl_398;
  assign VEC_LOOP_mux_21_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[1]), (~ (STAGE_LOOP_lshift_psp_sva[2])),
      and_dcpl_344);
  assign VEC_LOOP_VEC_LOOP_or_14_nl = (VEC_LOOP_mux_21_nl & (~(and_dcpl_354 | and_dcpl_358
      | and_dcpl_368 | and_dcpl_369 | and_dcpl_373 | and_dcpl_376 | and_dcpl_381
      | and_dcpl_382 | and_dcpl_384 | and_dcpl_387 | and_dcpl_390 | and_dcpl_394
      | and_dcpl_395 | and_dcpl_397 | and_dcpl_399))) | and_dcpl_336 | and_dcpl_352
      | and_dcpl_361 | and_dcpl_371 | and_dcpl_375 | and_dcpl_379 | and_dcpl_386
      | and_dcpl_392 | and_dcpl_398;
  assign VEC_LOOP_mux_22_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[0]), (~ (STAGE_LOOP_lshift_psp_sva[1])),
      and_dcpl_344);
  assign VEC_LOOP_VEC_LOOP_or_15_nl = (VEC_LOOP_mux_22_nl & (~(and_dcpl_352 | and_dcpl_358
      | and_dcpl_361 | and_dcpl_369 | and_dcpl_371 | and_dcpl_373 | and_dcpl_375
      | and_dcpl_379 | and_dcpl_382 | and_dcpl_384 | and_dcpl_386 | and_dcpl_390
      | and_dcpl_392 | and_dcpl_394 | and_dcpl_398))) | and_dcpl_336 | and_dcpl_354
      | and_dcpl_368 | and_dcpl_376 | and_dcpl_381 | and_dcpl_387 | and_dcpl_395
      | and_dcpl_397 | and_dcpl_399;
  assign nl_acc_1_nl = conv_u2u_19_20({VEC_LOOP_VEC_LOOP_and_5_nl , VEC_LOOP_VEC_LOOP_and_6_nl
      , VEC_LOOP_VEC_LOOP_and_7_nl , VEC_LOOP_VEC_LOOP_or_9_nl , VEC_LOOP_mux1h_38_nl
      , VEC_LOOP_or_82_nl}) + conv_s2u_16_20({VEC_LOOP_VEC_LOOP_or_10_nl , VEC_LOOP_or_83_nl
      , VEC_LOOP_VEC_LOOP_or_11_nl , VEC_LOOP_VEC_LOOP_or_12_nl , VEC_LOOP_VEC_LOOP_or_13_nl
      , VEC_LOOP_VEC_LOOP_or_14_nl , VEC_LOOP_VEC_LOOP_or_15_nl , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[19:0];
  assign z_out_4 = readslicef_20_19_1(acc_1_nl);
  assign VEC_LOOP_or_84_nl = and_dcpl_410 | and_463_cse | and_468_cse | and_470_cse
      | and_474_cse | and_479_cse | and_481_cse | and_483_cse | and_484_cse | and_486_cse
      | and_488_cse | and_489_cse | and_492_cse | and_494_cse | and_495_cse | and_497_cse
      | and_498_cse | and_500_cse | and_503_cse | and_504_cse | and_506_cse | and_508_cse
      | and_509_cse | and_511_cse | and_512_cse | and_516_cse | and_518_cse | and_519_cse
      | and_521_cse | and_523_cse | and_524_cse;
  assign VEC_LOOP_mux_23_nl = MUX_v_14_2_2((VEC_LOOP_j_1_sva[13:0]), ({reg_VEC_LOOP_acc_1_reg
      , reg_VEC_LOOP_acc_1_1_reg}), VEC_LOOP_or_84_nl);
  assign VEC_LOOP_mux1h_40_nl = MUX1HOT_v_5_30_2(5'b11110, 5'b11101, 5'b11100, 5'b11011,
      5'b11010, 5'b11001, 5'b11000, 5'b10111, 5'b10110, 5'b10101, 5'b10100, 5'b10011,
      5'b10010, 5'b10001, 5'b10000, 5'b01111, 5'b01110, 5'b01101, 5'b01100, 5'b01011,
      5'b01010, 5'b01001, 5'b01000, 5'b00111, 5'b00110, 5'b00101, 5'b00100, 5'b00011,
      5'b00010, 5'b00001, {and_dcpl_410 , and_463_cse , and_468_cse , and_470_cse
      , and_474_cse , and_479_cse , and_481_cse , and_483_cse , and_484_cse , and_486_cse
      , and_488_cse , and_489_cse , and_492_cse , and_494_cse , and_495_cse , and_497_cse
      , and_498_cse , and_500_cse , and_503_cse , and_504_cse , and_506_cse , and_508_cse
      , and_509_cse , and_511_cse , and_512_cse , and_516_cse , and_518_cse , and_519_cse
      , and_521_cse , and_523_cse});
  assign and_643_nl = and_dcpl_335 & and_dcpl_224;
  assign VEC_LOOP_VEC_LOOP_nor_1_nl = ~(MUX_v_5_2_2(VEC_LOOP_mux1h_40_nl, 5'b11111,
      and_643_nl));
  assign VEC_LOOP_or_85_nl = MUX_v_5_2_2(VEC_LOOP_VEC_LOOP_nor_1_nl, 5'b11111, and_524_cse);
  assign nl_z_out_5 = VEC_LOOP_mux_23_nl + ({COMP_LOOP_k_14_5_sva_8_0 , VEC_LOOP_or_85_nl})
      + (STAGE_LOOP_lshift_psp_sva[14:1]);
  assign z_out_5 = nl_z_out_5[13:0];
  assign VEC_LOOP_mux_24_nl = MUX_v_32_2_2(VEC_LOOP_j_1_sva, factor1_1_sva, and_173_cse);
  assign VEC_LOOP_or_86_nl = (~(and_dcpl_295 & nor_97_cse & and_dcpl_216 & (fsm_output[2])
      & (~ (fsm_output[0])))) | and_173_cse;
  assign VEC_LOOP_mux_25_nl = MUX_v_32_2_2(({17'b00000000000000000 , STAGE_LOOP_lshift_psp_sva}),
      (~ COMP_LOOP_1_mult_cmp_return_rsc_z), and_173_cse);
  assign nl_acc_3_nl = ({VEC_LOOP_mux_24_nl , VEC_LOOP_or_86_nl}) + ({VEC_LOOP_mux_25_nl
      , 1'b1});
  assign acc_3_nl = nl_acc_3_nl[32:0];
  assign z_out_6 = readslicef_33_32_1(acc_3_nl);
  assign VEC_LOOP_VEC_LOOP_and_8_nl = (reg_VEC_LOOP_acc_1_reg[4]) & VEC_LOOP_nor_12_itm;
  assign VEC_LOOP_mux_26_nl = MUX_s_1_2_2((reg_VEC_LOOP_acc_1_reg[3]), (reg_VEC_LOOP_acc_1_reg[4]),
      VEC_LOOP_or_40_itm);
  assign VEC_LOOP_VEC_LOOP_or_16_nl = (VEC_LOOP_mux_26_nl & (~(and_497_cse | and_470_cse
      | and_489_cse | and_504_cse | and_519_cse | and_483_cse | and_511_cse | and_dcpl_567
      | and_dcpl_570 | and_dcpl_574 | and_dcpl_577 | and_dcpl_578))) | and_dcpl_572
      | and_dcpl_573 | and_dcpl_575 | and_dcpl_576;
  assign VEC_LOOP_mux1h_41_nl = MUX1HOT_s_1_4_2((reg_VEC_LOOP_acc_1_reg[2]), (reg_VEC_LOOP_acc_1_reg[3]),
      (reg_VEC_LOOP_acc_1_reg[4]), (~ (STAGE_LOOP_lshift_psp_sva[14])), {VEC_LOOP_or_6_ssc
      , VEC_LOOP_or_40_itm , VEC_LOOP_or_43_itm , VEC_LOOP_or_54_itm});
  assign VEC_LOOP_or_87_nl = (VEC_LOOP_mux1h_41_nl & (~(and_497_cse | and_483_cse
      | and_511_cse | and_dcpl_567 | and_dcpl_570 | and_dcpl_577))) | and_dcpl_574
      | and_dcpl_578;
  assign VEC_LOOP_or_88_nl = and_483_cse | and_511_cse;
  assign VEC_LOOP_or_89_nl = and_dcpl_574 | and_dcpl_578;
  assign VEC_LOOP_mux1h_42_nl = MUX1HOT_v_11_10_2(({1'b0 , reg_VEC_LOOP_acc_1_reg
      , (reg_VEC_LOOP_acc_1_1_reg[8:4])}), ({(reg_VEC_LOOP_acc_1_reg[1:0]) , reg_VEC_LOOP_acc_1_1_reg}),
      ({(reg_VEC_LOOP_acc_1_reg[2:0]) , (reg_VEC_LOOP_acc_1_1_reg[8:1])}), ({(reg_VEC_LOOP_acc_1_reg[3:0])
      , (reg_VEC_LOOP_acc_1_1_reg[8:2])}), ({reg_VEC_LOOP_acc_1_reg , (reg_VEC_LOOP_acc_1_1_reg[8:3])}),
      ({7'b0000001 , (~ STAGE_LOOP_i_3_0_sva_2)}), ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[14:6]))}),
      (~ (STAGE_LOOP_lshift_psp_sva[13:3])), (~ (STAGE_LOOP_lshift_psp_sva[14:4])),
      ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[14:5]))}), {and_497_cse , VEC_LOOP_or_6_ssc
      , VEC_LOOP_or_40_itm , VEC_LOOP_or_43_itm , VEC_LOOP_or_88_nl , and_dcpl_567
      , and_dcpl_570 , VEC_LOOP_or_54_itm , VEC_LOOP_or_89_nl , and_dcpl_577});
  assign VEC_LOOP_or_90_nl = (~(and_497_cse | and_dcpl_500 | and_468_cse | and_474_cse
      | and_481_cse | and_484_cse | and_488_cse | and_492_cse | and_495_cse | and_498_cse
      | and_503_cse | and_506_cse | and_509_cse | and_512_cse | and_518_cse | and_521_cse
      | and_524_cse | and_463_cse | and_479_cse | and_486_cse | and_494_cse | and_500_cse
      | and_508_cse | and_516_cse | and_523_cse | and_470_cse | and_489_cse | and_504_cse
      | and_519_cse | and_483_cse | and_511_cse | and_dcpl_567)) | and_dcpl_570 |
      and_dcpl_572 | and_dcpl_573 | and_dcpl_574 | and_dcpl_575 | and_dcpl_576 |
      and_dcpl_577 | and_dcpl_578;
  assign VEC_LOOP_and_34_nl = (COMP_LOOP_k_14_5_sva_8_0[8]) & VEC_LOOP_nor_12_itm;
  assign VEC_LOOP_VEC_LOOP_mux_5_nl = MUX_s_1_2_2((COMP_LOOP_k_14_5_sva_8_0[7]),
      (COMP_LOOP_k_14_5_sva_8_0[8]), VEC_LOOP_or_40_itm);
  assign VEC_LOOP_and_35_nl = VEC_LOOP_VEC_LOOP_mux_5_nl & (~(and_497_cse | and_470_cse
      | and_489_cse | and_504_cse | and_519_cse | and_483_cse | and_511_cse | and_dcpl_567
      | and_dcpl_570 | and_dcpl_572 | and_dcpl_573 | and_dcpl_574 | and_dcpl_575
      | and_dcpl_576 | and_dcpl_577 | and_dcpl_578));
  assign VEC_LOOP_mux1h_43_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_14_5_sva_8_0[6]), (COMP_LOOP_k_14_5_sva_8_0[7]),
      (COMP_LOOP_k_14_5_sva_8_0[8]), {VEC_LOOP_or_6_ssc , VEC_LOOP_or_40_itm , VEC_LOOP_or_62_itm});
  assign VEC_LOOP_and_36_nl = VEC_LOOP_mux1h_43_nl & (~(and_497_cse | and_483_cse
      | and_511_cse | and_dcpl_567 | and_dcpl_570 | and_dcpl_574 | and_dcpl_577 |
      and_dcpl_578));
  assign VEC_LOOP_mux1h_44_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_14_5_sva_8_0[5]), (COMP_LOOP_k_14_5_sva_8_0[6]),
      (COMP_LOOP_k_14_5_sva_8_0[7]), (COMP_LOOP_k_14_5_sva_8_0[8]), {VEC_LOOP_or_6_ssc
      , VEC_LOOP_or_40_itm , VEC_LOOP_or_62_itm , VEC_LOOP_or_66_itm});
  assign VEC_LOOP_and_37_nl = VEC_LOOP_mux1h_44_nl & (~(and_497_cse | and_dcpl_567
      | and_dcpl_570 | and_dcpl_577));
  assign VEC_LOOP_mux1h_45_nl = MUX1HOT_v_5_6_2((COMP_LOOP_k_14_5_sva_8_0[8:4]),
      (COMP_LOOP_k_14_5_sva_8_0[4:0]), (COMP_LOOP_k_14_5_sva_8_0[5:1]), (COMP_LOOP_k_14_5_sva_8_0[6:2]),
      (COMP_LOOP_k_14_5_sva_8_0[7:3]), ({1'b0 , (COMP_LOOP_k_14_5_sva_8_0[8:5])}),
      {VEC_LOOP_or_67_itm , VEC_LOOP_or_6_ssc , VEC_LOOP_or_40_itm , VEC_LOOP_or_62_itm
      , VEC_LOOP_or_66_itm , and_dcpl_570});
  assign not_828_nl = ~ and_dcpl_567;
  assign VEC_LOOP_and_38_nl = MUX_v_5_2_2(5'b00000, VEC_LOOP_mux1h_45_nl, not_828_nl);
  assign VEC_LOOP_mux1h_46_nl = MUX1HOT_s_1_5_2((COMP_LOOP_k_14_5_sva_8_0[3]), (COMP_LOOP_k_14_5_sva_8_0[0]),
      (COMP_LOOP_k_14_5_sva_8_0[1]), (COMP_LOOP_k_14_5_sva_8_0[2]), (COMP_LOOP_k_14_5_sva_8_0[4]),
      {VEC_LOOP_or_67_itm , VEC_LOOP_or_40_itm , VEC_LOOP_or_62_itm , VEC_LOOP_or_66_itm
      , and_dcpl_570});
  assign VEC_LOOP_or_91_nl = (VEC_LOOP_mux1h_46_nl & (~(and_dcpl_500 | and_468_cse
      | and_474_cse | and_481_cse | and_484_cse | and_488_cse | and_492_cse | and_495_cse
      | and_dcpl_567))) | and_498_cse | and_503_cse | and_506_cse | and_509_cse |
      and_512_cse | and_518_cse | and_521_cse | and_524_cse;
  assign VEC_LOOP_mux1h_47_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_14_5_sva_8_0[2]), (COMP_LOOP_k_14_5_sva_8_0[0]),
      (COMP_LOOP_k_14_5_sva_8_0[1]), (COMP_LOOP_k_14_5_sva_8_0[3]), {VEC_LOOP_or_67_itm
      , VEC_LOOP_or_62_itm , VEC_LOOP_or_66_itm , and_dcpl_570});
  assign VEC_LOOP_or_92_nl = (VEC_LOOP_mux1h_47_nl & (~(and_dcpl_500 | and_468_cse
      | and_474_cse | and_481_cse | and_498_cse | and_503_cse | and_506_cse | and_509_cse
      | and_463_cse | and_479_cse | and_486_cse | and_494_cse))) | and_484_cse |
      and_488_cse | and_492_cse | and_495_cse | and_512_cse | and_518_cse | and_521_cse
      | and_524_cse | and_500_cse | and_508_cse | and_516_cse | and_523_cse | and_dcpl_567;
  assign VEC_LOOP_mux1h_48_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_14_5_sva_8_0[1]), (COMP_LOOP_k_14_5_sva_8_0[0]),
      (COMP_LOOP_k_14_5_sva_8_0[2]), {VEC_LOOP_or_67_itm , VEC_LOOP_or_66_itm , and_dcpl_570});
  assign VEC_LOOP_or_93_nl = (VEC_LOOP_mux1h_48_nl & (~(and_dcpl_500 | and_468_cse
      | and_484_cse | and_488_cse | and_498_cse | and_503_cse | and_512_cse | and_518_cse
      | and_463_cse | and_479_cse | and_500_cse | and_508_cse | and_470_cse | and_489_cse
      | and_dcpl_572 | and_dcpl_576))) | and_474_cse | and_481_cse | and_492_cse
      | and_495_cse | and_506_cse | and_509_cse | and_521_cse | and_524_cse | and_486_cse
      | and_494_cse | and_516_cse | and_523_cse | and_504_cse | and_519_cse | and_dcpl_567
      | and_dcpl_573 | and_dcpl_575;
  assign VEC_LOOP_VEC_LOOP_mux_6_nl = MUX_s_1_2_2((COMP_LOOP_k_14_5_sva_8_0[0]),
      (COMP_LOOP_k_14_5_sva_8_0[1]), and_dcpl_570);
  assign VEC_LOOP_or_94_nl = (VEC_LOOP_VEC_LOOP_mux_6_nl & (~(and_dcpl_500 | and_474_cse
      | and_484_cse | and_492_cse | and_498_cse | and_506_cse | and_512_cse | and_521_cse
      | and_463_cse | and_486_cse | and_500_cse | and_516_cse | and_470_cse | and_504_cse
      | and_483_cse | and_dcpl_572 | and_dcpl_575 | and_dcpl_578))) | and_468_cse
      | and_481_cse | and_488_cse | and_495_cse | and_503_cse | and_509_cse | and_518_cse
      | and_524_cse | and_479_cse | and_494_cse | and_508_cse | and_523_cse | and_489_cse
      | and_519_cse | and_511_cse | and_dcpl_567 | and_dcpl_573 | and_dcpl_574 |
      and_dcpl_576;
  assign VEC_LOOP_VEC_LOOP_or_17_nl = ((COMP_LOOP_k_14_5_sva_8_0[0]) & (~(and_dcpl_572
      | and_dcpl_573 | and_dcpl_574 | and_dcpl_575 | and_dcpl_576 | and_dcpl_578
      | and_dcpl_577))) | and_497_cse | and_dcpl_500 | and_468_cse | and_474_cse
      | and_481_cse | and_484_cse | and_488_cse | and_492_cse | and_495_cse | and_498_cse
      | and_503_cse | and_506_cse | and_509_cse | and_512_cse | and_518_cse | and_521_cse
      | and_524_cse | and_463_cse | and_479_cse | and_486_cse | and_494_cse | and_500_cse
      | and_508_cse | and_516_cse | and_523_cse | and_470_cse | and_489_cse | and_504_cse
      | and_519_cse | and_483_cse | and_511_cse | and_dcpl_567;
  assign nl_acc_4_nl = ({VEC_LOOP_VEC_LOOP_and_8_nl , VEC_LOOP_VEC_LOOP_or_16_nl
      , VEC_LOOP_or_87_nl , VEC_LOOP_mux1h_42_nl , VEC_LOOP_or_90_nl}) + ({VEC_LOOP_and_34_nl
      , VEC_LOOP_and_35_nl , VEC_LOOP_and_36_nl , VEC_LOOP_and_37_nl , VEC_LOOP_and_38_nl
      , VEC_LOOP_or_91_nl , VEC_LOOP_or_92_nl , VEC_LOOP_or_93_nl , VEC_LOOP_or_94_nl
      , VEC_LOOP_VEC_LOOP_or_17_nl , 1'b1});
  assign acc_4_nl = nl_acc_4_nl[14:0];
  assign z_out_7 = readslicef_15_14_1(acc_4_nl);

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


  function automatic [9:0] MUX1HOT_v_10_6_2;
    input [9:0] input_5;
    input [9:0] input_4;
    input [9:0] input_3;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [5:0] sel;
    reg [9:0] result;
  begin
    result = input_0 & {10{sel[0]}};
    result = result | ( input_1 & {10{sel[1]}});
    result = result | ( input_2 & {10{sel[2]}});
    result = result | ( input_3 & {10{sel[3]}});
    result = result | ( input_4 & {10{sel[4]}});
    result = result | ( input_5 & {10{sel[5]}});
    MUX1HOT_v_10_6_2 = result;
  end
  endfunction


  function automatic [10:0] MUX1HOT_v_11_10_2;
    input [10:0] input_9;
    input [10:0] input_8;
    input [10:0] input_7;
    input [10:0] input_6;
    input [10:0] input_5;
    input [10:0] input_4;
    input [10:0] input_3;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [9:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | ( input_1 & {11{sel[1]}});
    result = result | ( input_2 & {11{sel[2]}});
    result = result | ( input_3 & {11{sel[3]}});
    result = result | ( input_4 & {11{sel[4]}});
    result = result | ( input_5 & {11{sel[5]}});
    result = result | ( input_6 & {11{sel[6]}});
    result = result | ( input_7 & {11{sel[7]}});
    result = result | ( input_8 & {11{sel[8]}});
    result = result | ( input_9 & {11{sel[9]}});
    MUX1HOT_v_11_10_2 = result;
  end
  endfunction


  function automatic [13:0] MUX1HOT_v_14_3_2;
    input [13:0] input_2;
    input [13:0] input_1;
    input [13:0] input_0;
    input [2:0] sel;
    reg [13:0] result;
  begin
    result = input_0 & {14{sel[0]}};
    result = result | ( input_1 & {14{sel[1]}});
    result = result | ( input_2 & {14{sel[2]}});
    MUX1HOT_v_14_3_2 = result;
  end
  endfunction


  function automatic [13:0] MUX1HOT_v_14_4_2;
    input [13:0] input_3;
    input [13:0] input_2;
    input [13:0] input_1;
    input [13:0] input_0;
    input [3:0] sel;
    reg [13:0] result;
  begin
    result = input_0 & {14{sel[0]}};
    result = result | ( input_1 & {14{sel[1]}});
    result = result | ( input_2 & {14{sel[2]}});
    result = result | ( input_3 & {14{sel[3]}});
    MUX1HOT_v_14_4_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_6_2;
    input [1:0] input_5;
    input [1:0] input_4;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [5:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | ( input_1 & {2{sel[1]}});
    result = result | ( input_2 & {2{sel[2]}});
    result = result | ( input_3 & {2{sel[3]}});
    result = result | ( input_4 & {2{sel[4]}});
    result = result | ( input_5 & {2{sel[5]}});
    MUX1HOT_v_2_6_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_30_2;
    input [4:0] input_29;
    input [4:0] input_28;
    input [4:0] input_27;
    input [4:0] input_26;
    input [4:0] input_25;
    input [4:0] input_24;
    input [4:0] input_23;
    input [4:0] input_22;
    input [4:0] input_21;
    input [4:0] input_20;
    input [4:0] input_19;
    input [4:0] input_18;
    input [4:0] input_17;
    input [4:0] input_16;
    input [4:0] input_15;
    input [4:0] input_14;
    input [4:0] input_13;
    input [4:0] input_12;
    input [4:0] input_11;
    input [4:0] input_10;
    input [4:0] input_9;
    input [4:0] input_8;
    input [4:0] input_7;
    input [4:0] input_6;
    input [4:0] input_5;
    input [4:0] input_4;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [29:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | ( input_1 & {5{sel[1]}});
    result = result | ( input_2 & {5{sel[2]}});
    result = result | ( input_3 & {5{sel[3]}});
    result = result | ( input_4 & {5{sel[4]}});
    result = result | ( input_5 & {5{sel[5]}});
    result = result | ( input_6 & {5{sel[6]}});
    result = result | ( input_7 & {5{sel[7]}});
    result = result | ( input_8 & {5{sel[8]}});
    result = result | ( input_9 & {5{sel[9]}});
    result = result | ( input_10 & {5{sel[10]}});
    result = result | ( input_11 & {5{sel[11]}});
    result = result | ( input_12 & {5{sel[12]}});
    result = result | ( input_13 & {5{sel[13]}});
    result = result | ( input_14 & {5{sel[14]}});
    result = result | ( input_15 & {5{sel[15]}});
    result = result | ( input_16 & {5{sel[16]}});
    result = result | ( input_17 & {5{sel[17]}});
    result = result | ( input_18 & {5{sel[18]}});
    result = result | ( input_19 & {5{sel[19]}});
    result = result | ( input_20 & {5{sel[20]}});
    result = result | ( input_21 & {5{sel[21]}});
    result = result | ( input_22 & {5{sel[22]}});
    result = result | ( input_23 & {5{sel[23]}});
    result = result | ( input_24 & {5{sel[24]}});
    result = result | ( input_25 & {5{sel[25]}});
    result = result | ( input_26 & {5{sel[26]}});
    result = result | ( input_27 & {5{sel[27]}});
    result = result | ( input_28 & {5{sel[28]}});
    result = result | ( input_29 & {5{sel[29]}});
    MUX1HOT_v_5_30_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_6_2;
    input [4:0] input_5;
    input [4:0] input_4;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [5:0] sel;
    reg [4:0] result;
  begin
    result = input_0 & {5{sel[0]}};
    result = result | ( input_1 & {5{sel[1]}});
    result = result | ( input_2 & {5{sel[2]}});
    result = result | ( input_3 & {5{sel[3]}});
    result = result | ( input_4 & {5{sel[4]}});
    result = result | ( input_5 & {5{sel[5]}});
    MUX1HOT_v_5_6_2 = result;
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


  function automatic [8:0] MUX1HOT_v_9_10_2;
    input [8:0] input_9;
    input [8:0] input_8;
    input [8:0] input_7;
    input [8:0] input_6;
    input [8:0] input_5;
    input [8:0] input_4;
    input [8:0] input_3;
    input [8:0] input_2;
    input [8:0] input_1;
    input [8:0] input_0;
    input [9:0] sel;
    reg [8:0] result;
  begin
    result = input_0 & {9{sel[0]}};
    result = result | ( input_1 & {9{sel[1]}});
    result = result | ( input_2 & {9{sel[2]}});
    result = result | ( input_3 & {9{sel[3]}});
    result = result | ( input_4 & {9{sel[4]}});
    result = result | ( input_5 & {9{sel[5]}});
    result = result | ( input_6 & {9{sel[6]}});
    result = result | ( input_7 & {9{sel[7]}});
    result = result | ( input_8 & {9{sel[8]}});
    result = result | ( input_9 & {9{sel[9]}});
    MUX1HOT_v_9_10_2 = result;
  end
  endfunction


  function automatic [8:0] MUX1HOT_v_9_3_2;
    input [8:0] input_2;
    input [8:0] input_1;
    input [8:0] input_0;
    input [2:0] sel;
    reg [8:0] result;
  begin
    result = input_0 & {9{sel[0]}};
    result = result | ( input_1 & {9{sel[1]}});
    result = result | ( input_2 & {9{sel[2]}});
    MUX1HOT_v_9_3_2 = result;
  end
  endfunction


  function automatic [8:0] MUX1HOT_v_9_6_2;
    input [8:0] input_5;
    input [8:0] input_4;
    input [8:0] input_3;
    input [8:0] input_2;
    input [8:0] input_1;
    input [8:0] input_0;
    input [5:0] sel;
    reg [8:0] result;
  begin
    result = input_0 & {9{sel[0]}};
    result = result | ( input_1 & {9{sel[1]}});
    result = result | ( input_2 & {9{sel[2]}});
    result = result | ( input_3 & {9{sel[3]}});
    result = result | ( input_4 & {9{sel[4]}});
    result = result | ( input_5 & {9{sel[5]}});
    MUX1HOT_v_9_6_2 = result;
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


  function automatic [13:0] MUX_v_14_2_2;
    input [13:0] input_0;
    input [13:0] input_1;
    input [0:0] sel;
    reg [13:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_14_2_2 = result;
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


  function automatic [4:0] MUX_v_5_2_2;
    input [4:0] input_0;
    input [4:0] input_1;
    input [0:0] sel;
    reg [4:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_5_2_2 = result;
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


  function automatic [13:0] readslicef_15_14_1;
    input [14:0] vector;
    reg [14:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_15_14_1 = tmp[13:0];
  end
  endfunction


  function automatic [18:0] readslicef_20_19_1;
    input [19:0] vector;
    reg [19:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_20_19_1 = tmp[18:0];
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


  function automatic [19:0] conv_s2u_16_20 ;
    input [15:0]  vector ;
  begin
    conv_s2u_16_20 = {{4{vector[15]}}, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function automatic [19:0] conv_u2u_19_20 ;
    input [18:0]  vector ;
  begin
    conv_u2u_19_20 = {1'b0, vector};
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
  output [13:0] vec_rsc_adra;
  output [31:0] vec_rsc_da;
  output vec_rsc_wea;
  input [31:0] vec_rsc_qa;
  output [13:0] vec_rsc_adrb;
  output [31:0] vec_rsc_db;
  output vec_rsc_web;
  input [31:0] vec_rsc_qb;
  output vec_rsc_triosy_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [31:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [13:0] twiddle_rsc_adra;
  output [31:0] twiddle_rsc_da;
  output twiddle_rsc_wea;
  input [31:0] twiddle_rsc_qa;
  output [13:0] twiddle_rsc_adrb;
  output [31:0] twiddle_rsc_db;
  output twiddle_rsc_web;
  input [31:0] twiddle_rsc_qb;
  output twiddle_rsc_triosy_lz;
  output [13:0] twiddle_h_rsc_adra;
  output [31:0] twiddle_h_rsc_da;
  output twiddle_h_rsc_wea;
  input [31:0] twiddle_h_rsc_qa;
  output [13:0] twiddle_h_rsc_adrb;
  output [31:0] twiddle_h_rsc_db;
  output twiddle_h_rsc_web;
  input [31:0] twiddle_h_rsc_qb;
  output twiddle_h_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;


  // Interconnect Declarations
  wire [27:0] vec_rsci_adra_d;
  wire [31:0] vec_rsci_da_d;
  wire [63:0] vec_rsci_qa_d;
  wire [1:0] vec_rsci_wea_d;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [13:0] twiddle_rsci_adra_d;
  wire [63:0] twiddle_rsci_qa_d;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [13:0] twiddle_h_rsci_adra_d;
  wire [63:0] twiddle_h_rsci_qa_d;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations for Component Instantiations 
  wire [63:0] nl_vec_rsci_da_d;
  assign nl_vec_rsci_da_d = {32'b00000000000000000000000000000000 , vec_rsci_da_d};
  wire [27:0] nl_twiddle_rsci_adra_d;
  assign nl_twiddle_rsci_adra_d = {14'b00000000000000 , twiddle_rsci_adra_d};
  wire [27:0] nl_twiddle_h_rsci_adra_d;
  assign nl_twiddle_h_rsci_adra_d = {14'b00000000000000 , twiddle_h_rsci_adra_d};
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_14_32_16384_16384_32_1_gen
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
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_14_32_16384_16384_32_1_gen
      twiddle_rsci (
      .qb(twiddle_rsc_qb),
      .web(twiddle_rsc_web),
      .db(twiddle_rsc_db),
      .adrb(twiddle_rsc_adrb),
      .qa(twiddle_rsc_qa),
      .wea(twiddle_rsc_wea),
      .da(twiddle_rsc_da),
      .adra(twiddle_rsc_adra),
      .adra_d(nl_twiddle_rsci_adra_d[27:0]),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .qa_d(twiddle_rsci_qa_d),
      .wea_d(2'b00),
      .rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(2'b00)
    );
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_14_32_16384_16384_32_1_gen
      twiddle_h_rsci (
      .qb(twiddle_h_rsc_qb),
      .web(twiddle_h_rsc_web),
      .db(twiddle_h_rsc_db),
      .adrb(twiddle_h_rsc_adrb),
      .qa(twiddle_h_rsc_qa),
      .wea(twiddle_h_rsc_wea),
      .da(twiddle_h_rsc_da),
      .adra(twiddle_h_rsc_adra),
      .adra_d(nl_twiddle_h_rsci_adra_d[27:0]),
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



