
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

//------> ../td_ccore_solutions/modulo_sub_f83f1ef2ff5a4101c59f332e5a2a07d06350_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:50:47 2021
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




//------> ../td_ccore_solutions/modulo_add_1c7cb5effec07f258b1f9fafcfd3564d6028_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:50:48 2021
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




//------> ../td_ccore_solutions/mult_211a0e259bca55d0a7d87e37cf4e500170bb_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:50:49 2021
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
//  Generated date: Thu Sep 16 13:31:11 2021
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
      COMP_LOOP_C_3_tr0, COMP_LOOP_2_VEC_LOOP_C_8_tr0, COMP_LOOP_C_4_tr0, COMP_LOOP_3_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_5_tr0, COMP_LOOP_4_VEC_LOOP_C_8_tr0, COMP_LOOP_C_6_tr0, COMP_LOOP_5_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_7_tr0, COMP_LOOP_6_VEC_LOOP_C_8_tr0, COMP_LOOP_C_8_tr0, COMP_LOOP_7_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_9_tr0, COMP_LOOP_8_VEC_LOOP_C_8_tr0, COMP_LOOP_C_10_tr0, COMP_LOOP_9_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_11_tr0, COMP_LOOP_10_VEC_LOOP_C_8_tr0, COMP_LOOP_C_12_tr0, COMP_LOOP_11_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_13_tr0, COMP_LOOP_12_VEC_LOOP_C_8_tr0, COMP_LOOP_C_14_tr0, COMP_LOOP_13_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_15_tr0, COMP_LOOP_14_VEC_LOOP_C_8_tr0, COMP_LOOP_C_16_tr0, COMP_LOOP_15_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_17_tr0, COMP_LOOP_16_VEC_LOOP_C_8_tr0, COMP_LOOP_C_18_tr0, COMP_LOOP_17_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_19_tr0, COMP_LOOP_18_VEC_LOOP_C_8_tr0, COMP_LOOP_C_20_tr0, COMP_LOOP_19_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_21_tr0, COMP_LOOP_20_VEC_LOOP_C_8_tr0, COMP_LOOP_C_22_tr0, COMP_LOOP_21_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_23_tr0, COMP_LOOP_22_VEC_LOOP_C_8_tr0, COMP_LOOP_C_24_tr0, COMP_LOOP_23_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_25_tr0, COMP_LOOP_24_VEC_LOOP_C_8_tr0, COMP_LOOP_C_26_tr0, COMP_LOOP_25_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_27_tr0, COMP_LOOP_26_VEC_LOOP_C_8_tr0, COMP_LOOP_C_28_tr0, COMP_LOOP_27_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_29_tr0, COMP_LOOP_28_VEC_LOOP_C_8_tr0, COMP_LOOP_C_30_tr0, COMP_LOOP_29_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_31_tr0, COMP_LOOP_30_VEC_LOOP_C_8_tr0, COMP_LOOP_C_32_tr0, COMP_LOOP_31_VEC_LOOP_C_8_tr0,
      COMP_LOOP_C_33_tr0, COMP_LOOP_32_VEC_LOOP_C_8_tr0, COMP_LOOP_C_34_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
  input main_C_0_tr0;
  input COMP_LOOP_1_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_3_tr0;
  input COMP_LOOP_2_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_4_tr0;
  input COMP_LOOP_3_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_5_tr0;
  input COMP_LOOP_4_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_6_tr0;
  input COMP_LOOP_5_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_7_tr0;
  input COMP_LOOP_6_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_8_tr0;
  input COMP_LOOP_7_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_9_tr0;
  input COMP_LOOP_8_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_10_tr0;
  input COMP_LOOP_9_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_11_tr0;
  input COMP_LOOP_10_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_12_tr0;
  input COMP_LOOP_11_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_13_tr0;
  input COMP_LOOP_12_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_14_tr0;
  input COMP_LOOP_13_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_15_tr0;
  input COMP_LOOP_14_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_16_tr0;
  input COMP_LOOP_15_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_17_tr0;
  input COMP_LOOP_16_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_18_tr0;
  input COMP_LOOP_17_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_19_tr0;
  input COMP_LOOP_18_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_20_tr0;
  input COMP_LOOP_19_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_21_tr0;
  input COMP_LOOP_20_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_22_tr0;
  input COMP_LOOP_21_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_23_tr0;
  input COMP_LOOP_22_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_24_tr0;
  input COMP_LOOP_23_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_25_tr0;
  input COMP_LOOP_24_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_26_tr0;
  input COMP_LOOP_25_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_27_tr0;
  input COMP_LOOP_26_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_28_tr0;
  input COMP_LOOP_27_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_29_tr0;
  input COMP_LOOP_28_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_30_tr0;
  input COMP_LOOP_29_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_31_tr0;
  input COMP_LOOP_30_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_32_tr0;
  input COMP_LOOP_31_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_33_tr0;
  input COMP_LOOP_32_VEC_LOOP_C_8_tr0;
  input COMP_LOOP_C_34_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_precomp_core_core_fsm_1
  parameter
    main_C_0 = 9'd0,
    STAGE_LOOP_C_0 = 9'd1,
    COMP_LOOP_C_0 = 9'd2,
    COMP_LOOP_C_1 = 9'd3,
    COMP_LOOP_C_2 = 9'd4,
    COMP_LOOP_1_VEC_LOOP_C_0 = 9'd5,
    COMP_LOOP_1_VEC_LOOP_C_1 = 9'd6,
    COMP_LOOP_1_VEC_LOOP_C_2 = 9'd7,
    COMP_LOOP_1_VEC_LOOP_C_3 = 9'd8,
    COMP_LOOP_1_VEC_LOOP_C_4 = 9'd9,
    COMP_LOOP_1_VEC_LOOP_C_5 = 9'd10,
    COMP_LOOP_1_VEC_LOOP_C_6 = 9'd11,
    COMP_LOOP_1_VEC_LOOP_C_7 = 9'd12,
    COMP_LOOP_1_VEC_LOOP_C_8 = 9'd13,
    COMP_LOOP_C_3 = 9'd14,
    COMP_LOOP_2_VEC_LOOP_C_0 = 9'd15,
    COMP_LOOP_2_VEC_LOOP_C_1 = 9'd16,
    COMP_LOOP_2_VEC_LOOP_C_2 = 9'd17,
    COMP_LOOP_2_VEC_LOOP_C_3 = 9'd18,
    COMP_LOOP_2_VEC_LOOP_C_4 = 9'd19,
    COMP_LOOP_2_VEC_LOOP_C_5 = 9'd20,
    COMP_LOOP_2_VEC_LOOP_C_6 = 9'd21,
    COMP_LOOP_2_VEC_LOOP_C_7 = 9'd22,
    COMP_LOOP_2_VEC_LOOP_C_8 = 9'd23,
    COMP_LOOP_C_4 = 9'd24,
    COMP_LOOP_3_VEC_LOOP_C_0 = 9'd25,
    COMP_LOOP_3_VEC_LOOP_C_1 = 9'd26,
    COMP_LOOP_3_VEC_LOOP_C_2 = 9'd27,
    COMP_LOOP_3_VEC_LOOP_C_3 = 9'd28,
    COMP_LOOP_3_VEC_LOOP_C_4 = 9'd29,
    COMP_LOOP_3_VEC_LOOP_C_5 = 9'd30,
    COMP_LOOP_3_VEC_LOOP_C_6 = 9'd31,
    COMP_LOOP_3_VEC_LOOP_C_7 = 9'd32,
    COMP_LOOP_3_VEC_LOOP_C_8 = 9'd33,
    COMP_LOOP_C_5 = 9'd34,
    COMP_LOOP_4_VEC_LOOP_C_0 = 9'd35,
    COMP_LOOP_4_VEC_LOOP_C_1 = 9'd36,
    COMP_LOOP_4_VEC_LOOP_C_2 = 9'd37,
    COMP_LOOP_4_VEC_LOOP_C_3 = 9'd38,
    COMP_LOOP_4_VEC_LOOP_C_4 = 9'd39,
    COMP_LOOP_4_VEC_LOOP_C_5 = 9'd40,
    COMP_LOOP_4_VEC_LOOP_C_6 = 9'd41,
    COMP_LOOP_4_VEC_LOOP_C_7 = 9'd42,
    COMP_LOOP_4_VEC_LOOP_C_8 = 9'd43,
    COMP_LOOP_C_6 = 9'd44,
    COMP_LOOP_5_VEC_LOOP_C_0 = 9'd45,
    COMP_LOOP_5_VEC_LOOP_C_1 = 9'd46,
    COMP_LOOP_5_VEC_LOOP_C_2 = 9'd47,
    COMP_LOOP_5_VEC_LOOP_C_3 = 9'd48,
    COMP_LOOP_5_VEC_LOOP_C_4 = 9'd49,
    COMP_LOOP_5_VEC_LOOP_C_5 = 9'd50,
    COMP_LOOP_5_VEC_LOOP_C_6 = 9'd51,
    COMP_LOOP_5_VEC_LOOP_C_7 = 9'd52,
    COMP_LOOP_5_VEC_LOOP_C_8 = 9'd53,
    COMP_LOOP_C_7 = 9'd54,
    COMP_LOOP_6_VEC_LOOP_C_0 = 9'd55,
    COMP_LOOP_6_VEC_LOOP_C_1 = 9'd56,
    COMP_LOOP_6_VEC_LOOP_C_2 = 9'd57,
    COMP_LOOP_6_VEC_LOOP_C_3 = 9'd58,
    COMP_LOOP_6_VEC_LOOP_C_4 = 9'd59,
    COMP_LOOP_6_VEC_LOOP_C_5 = 9'd60,
    COMP_LOOP_6_VEC_LOOP_C_6 = 9'd61,
    COMP_LOOP_6_VEC_LOOP_C_7 = 9'd62,
    COMP_LOOP_6_VEC_LOOP_C_8 = 9'd63,
    COMP_LOOP_C_8 = 9'd64,
    COMP_LOOP_7_VEC_LOOP_C_0 = 9'd65,
    COMP_LOOP_7_VEC_LOOP_C_1 = 9'd66,
    COMP_LOOP_7_VEC_LOOP_C_2 = 9'd67,
    COMP_LOOP_7_VEC_LOOP_C_3 = 9'd68,
    COMP_LOOP_7_VEC_LOOP_C_4 = 9'd69,
    COMP_LOOP_7_VEC_LOOP_C_5 = 9'd70,
    COMP_LOOP_7_VEC_LOOP_C_6 = 9'd71,
    COMP_LOOP_7_VEC_LOOP_C_7 = 9'd72,
    COMP_LOOP_7_VEC_LOOP_C_8 = 9'd73,
    COMP_LOOP_C_9 = 9'd74,
    COMP_LOOP_8_VEC_LOOP_C_0 = 9'd75,
    COMP_LOOP_8_VEC_LOOP_C_1 = 9'd76,
    COMP_LOOP_8_VEC_LOOP_C_2 = 9'd77,
    COMP_LOOP_8_VEC_LOOP_C_3 = 9'd78,
    COMP_LOOP_8_VEC_LOOP_C_4 = 9'd79,
    COMP_LOOP_8_VEC_LOOP_C_5 = 9'd80,
    COMP_LOOP_8_VEC_LOOP_C_6 = 9'd81,
    COMP_LOOP_8_VEC_LOOP_C_7 = 9'd82,
    COMP_LOOP_8_VEC_LOOP_C_8 = 9'd83,
    COMP_LOOP_C_10 = 9'd84,
    COMP_LOOP_9_VEC_LOOP_C_0 = 9'd85,
    COMP_LOOP_9_VEC_LOOP_C_1 = 9'd86,
    COMP_LOOP_9_VEC_LOOP_C_2 = 9'd87,
    COMP_LOOP_9_VEC_LOOP_C_3 = 9'd88,
    COMP_LOOP_9_VEC_LOOP_C_4 = 9'd89,
    COMP_LOOP_9_VEC_LOOP_C_5 = 9'd90,
    COMP_LOOP_9_VEC_LOOP_C_6 = 9'd91,
    COMP_LOOP_9_VEC_LOOP_C_7 = 9'd92,
    COMP_LOOP_9_VEC_LOOP_C_8 = 9'd93,
    COMP_LOOP_C_11 = 9'd94,
    COMP_LOOP_10_VEC_LOOP_C_0 = 9'd95,
    COMP_LOOP_10_VEC_LOOP_C_1 = 9'd96,
    COMP_LOOP_10_VEC_LOOP_C_2 = 9'd97,
    COMP_LOOP_10_VEC_LOOP_C_3 = 9'd98,
    COMP_LOOP_10_VEC_LOOP_C_4 = 9'd99,
    COMP_LOOP_10_VEC_LOOP_C_5 = 9'd100,
    COMP_LOOP_10_VEC_LOOP_C_6 = 9'd101,
    COMP_LOOP_10_VEC_LOOP_C_7 = 9'd102,
    COMP_LOOP_10_VEC_LOOP_C_8 = 9'd103,
    COMP_LOOP_C_12 = 9'd104,
    COMP_LOOP_11_VEC_LOOP_C_0 = 9'd105,
    COMP_LOOP_11_VEC_LOOP_C_1 = 9'd106,
    COMP_LOOP_11_VEC_LOOP_C_2 = 9'd107,
    COMP_LOOP_11_VEC_LOOP_C_3 = 9'd108,
    COMP_LOOP_11_VEC_LOOP_C_4 = 9'd109,
    COMP_LOOP_11_VEC_LOOP_C_5 = 9'd110,
    COMP_LOOP_11_VEC_LOOP_C_6 = 9'd111,
    COMP_LOOP_11_VEC_LOOP_C_7 = 9'd112,
    COMP_LOOP_11_VEC_LOOP_C_8 = 9'd113,
    COMP_LOOP_C_13 = 9'd114,
    COMP_LOOP_12_VEC_LOOP_C_0 = 9'd115,
    COMP_LOOP_12_VEC_LOOP_C_1 = 9'd116,
    COMP_LOOP_12_VEC_LOOP_C_2 = 9'd117,
    COMP_LOOP_12_VEC_LOOP_C_3 = 9'd118,
    COMP_LOOP_12_VEC_LOOP_C_4 = 9'd119,
    COMP_LOOP_12_VEC_LOOP_C_5 = 9'd120,
    COMP_LOOP_12_VEC_LOOP_C_6 = 9'd121,
    COMP_LOOP_12_VEC_LOOP_C_7 = 9'd122,
    COMP_LOOP_12_VEC_LOOP_C_8 = 9'd123,
    COMP_LOOP_C_14 = 9'd124,
    COMP_LOOP_13_VEC_LOOP_C_0 = 9'd125,
    COMP_LOOP_13_VEC_LOOP_C_1 = 9'd126,
    COMP_LOOP_13_VEC_LOOP_C_2 = 9'd127,
    COMP_LOOP_13_VEC_LOOP_C_3 = 9'd128,
    COMP_LOOP_13_VEC_LOOP_C_4 = 9'd129,
    COMP_LOOP_13_VEC_LOOP_C_5 = 9'd130,
    COMP_LOOP_13_VEC_LOOP_C_6 = 9'd131,
    COMP_LOOP_13_VEC_LOOP_C_7 = 9'd132,
    COMP_LOOP_13_VEC_LOOP_C_8 = 9'd133,
    COMP_LOOP_C_15 = 9'd134,
    COMP_LOOP_14_VEC_LOOP_C_0 = 9'd135,
    COMP_LOOP_14_VEC_LOOP_C_1 = 9'd136,
    COMP_LOOP_14_VEC_LOOP_C_2 = 9'd137,
    COMP_LOOP_14_VEC_LOOP_C_3 = 9'd138,
    COMP_LOOP_14_VEC_LOOP_C_4 = 9'd139,
    COMP_LOOP_14_VEC_LOOP_C_5 = 9'd140,
    COMP_LOOP_14_VEC_LOOP_C_6 = 9'd141,
    COMP_LOOP_14_VEC_LOOP_C_7 = 9'd142,
    COMP_LOOP_14_VEC_LOOP_C_8 = 9'd143,
    COMP_LOOP_C_16 = 9'd144,
    COMP_LOOP_15_VEC_LOOP_C_0 = 9'd145,
    COMP_LOOP_15_VEC_LOOP_C_1 = 9'd146,
    COMP_LOOP_15_VEC_LOOP_C_2 = 9'd147,
    COMP_LOOP_15_VEC_LOOP_C_3 = 9'd148,
    COMP_LOOP_15_VEC_LOOP_C_4 = 9'd149,
    COMP_LOOP_15_VEC_LOOP_C_5 = 9'd150,
    COMP_LOOP_15_VEC_LOOP_C_6 = 9'd151,
    COMP_LOOP_15_VEC_LOOP_C_7 = 9'd152,
    COMP_LOOP_15_VEC_LOOP_C_8 = 9'd153,
    COMP_LOOP_C_17 = 9'd154,
    COMP_LOOP_16_VEC_LOOP_C_0 = 9'd155,
    COMP_LOOP_16_VEC_LOOP_C_1 = 9'd156,
    COMP_LOOP_16_VEC_LOOP_C_2 = 9'd157,
    COMP_LOOP_16_VEC_LOOP_C_3 = 9'd158,
    COMP_LOOP_16_VEC_LOOP_C_4 = 9'd159,
    COMP_LOOP_16_VEC_LOOP_C_5 = 9'd160,
    COMP_LOOP_16_VEC_LOOP_C_6 = 9'd161,
    COMP_LOOP_16_VEC_LOOP_C_7 = 9'd162,
    COMP_LOOP_16_VEC_LOOP_C_8 = 9'd163,
    COMP_LOOP_C_18 = 9'd164,
    COMP_LOOP_17_VEC_LOOP_C_0 = 9'd165,
    COMP_LOOP_17_VEC_LOOP_C_1 = 9'd166,
    COMP_LOOP_17_VEC_LOOP_C_2 = 9'd167,
    COMP_LOOP_17_VEC_LOOP_C_3 = 9'd168,
    COMP_LOOP_17_VEC_LOOP_C_4 = 9'd169,
    COMP_LOOP_17_VEC_LOOP_C_5 = 9'd170,
    COMP_LOOP_17_VEC_LOOP_C_6 = 9'd171,
    COMP_LOOP_17_VEC_LOOP_C_7 = 9'd172,
    COMP_LOOP_17_VEC_LOOP_C_8 = 9'd173,
    COMP_LOOP_C_19 = 9'd174,
    COMP_LOOP_18_VEC_LOOP_C_0 = 9'd175,
    COMP_LOOP_18_VEC_LOOP_C_1 = 9'd176,
    COMP_LOOP_18_VEC_LOOP_C_2 = 9'd177,
    COMP_LOOP_18_VEC_LOOP_C_3 = 9'd178,
    COMP_LOOP_18_VEC_LOOP_C_4 = 9'd179,
    COMP_LOOP_18_VEC_LOOP_C_5 = 9'd180,
    COMP_LOOP_18_VEC_LOOP_C_6 = 9'd181,
    COMP_LOOP_18_VEC_LOOP_C_7 = 9'd182,
    COMP_LOOP_18_VEC_LOOP_C_8 = 9'd183,
    COMP_LOOP_C_20 = 9'd184,
    COMP_LOOP_19_VEC_LOOP_C_0 = 9'd185,
    COMP_LOOP_19_VEC_LOOP_C_1 = 9'd186,
    COMP_LOOP_19_VEC_LOOP_C_2 = 9'd187,
    COMP_LOOP_19_VEC_LOOP_C_3 = 9'd188,
    COMP_LOOP_19_VEC_LOOP_C_4 = 9'd189,
    COMP_LOOP_19_VEC_LOOP_C_5 = 9'd190,
    COMP_LOOP_19_VEC_LOOP_C_6 = 9'd191,
    COMP_LOOP_19_VEC_LOOP_C_7 = 9'd192,
    COMP_LOOP_19_VEC_LOOP_C_8 = 9'd193,
    COMP_LOOP_C_21 = 9'd194,
    COMP_LOOP_20_VEC_LOOP_C_0 = 9'd195,
    COMP_LOOP_20_VEC_LOOP_C_1 = 9'd196,
    COMP_LOOP_20_VEC_LOOP_C_2 = 9'd197,
    COMP_LOOP_20_VEC_LOOP_C_3 = 9'd198,
    COMP_LOOP_20_VEC_LOOP_C_4 = 9'd199,
    COMP_LOOP_20_VEC_LOOP_C_5 = 9'd200,
    COMP_LOOP_20_VEC_LOOP_C_6 = 9'd201,
    COMP_LOOP_20_VEC_LOOP_C_7 = 9'd202,
    COMP_LOOP_20_VEC_LOOP_C_8 = 9'd203,
    COMP_LOOP_C_22 = 9'd204,
    COMP_LOOP_21_VEC_LOOP_C_0 = 9'd205,
    COMP_LOOP_21_VEC_LOOP_C_1 = 9'd206,
    COMP_LOOP_21_VEC_LOOP_C_2 = 9'd207,
    COMP_LOOP_21_VEC_LOOP_C_3 = 9'd208,
    COMP_LOOP_21_VEC_LOOP_C_4 = 9'd209,
    COMP_LOOP_21_VEC_LOOP_C_5 = 9'd210,
    COMP_LOOP_21_VEC_LOOP_C_6 = 9'd211,
    COMP_LOOP_21_VEC_LOOP_C_7 = 9'd212,
    COMP_LOOP_21_VEC_LOOP_C_8 = 9'd213,
    COMP_LOOP_C_23 = 9'd214,
    COMP_LOOP_22_VEC_LOOP_C_0 = 9'd215,
    COMP_LOOP_22_VEC_LOOP_C_1 = 9'd216,
    COMP_LOOP_22_VEC_LOOP_C_2 = 9'd217,
    COMP_LOOP_22_VEC_LOOP_C_3 = 9'd218,
    COMP_LOOP_22_VEC_LOOP_C_4 = 9'd219,
    COMP_LOOP_22_VEC_LOOP_C_5 = 9'd220,
    COMP_LOOP_22_VEC_LOOP_C_6 = 9'd221,
    COMP_LOOP_22_VEC_LOOP_C_7 = 9'd222,
    COMP_LOOP_22_VEC_LOOP_C_8 = 9'd223,
    COMP_LOOP_C_24 = 9'd224,
    COMP_LOOP_23_VEC_LOOP_C_0 = 9'd225,
    COMP_LOOP_23_VEC_LOOP_C_1 = 9'd226,
    COMP_LOOP_23_VEC_LOOP_C_2 = 9'd227,
    COMP_LOOP_23_VEC_LOOP_C_3 = 9'd228,
    COMP_LOOP_23_VEC_LOOP_C_4 = 9'd229,
    COMP_LOOP_23_VEC_LOOP_C_5 = 9'd230,
    COMP_LOOP_23_VEC_LOOP_C_6 = 9'd231,
    COMP_LOOP_23_VEC_LOOP_C_7 = 9'd232,
    COMP_LOOP_23_VEC_LOOP_C_8 = 9'd233,
    COMP_LOOP_C_25 = 9'd234,
    COMP_LOOP_24_VEC_LOOP_C_0 = 9'd235,
    COMP_LOOP_24_VEC_LOOP_C_1 = 9'd236,
    COMP_LOOP_24_VEC_LOOP_C_2 = 9'd237,
    COMP_LOOP_24_VEC_LOOP_C_3 = 9'd238,
    COMP_LOOP_24_VEC_LOOP_C_4 = 9'd239,
    COMP_LOOP_24_VEC_LOOP_C_5 = 9'd240,
    COMP_LOOP_24_VEC_LOOP_C_6 = 9'd241,
    COMP_LOOP_24_VEC_LOOP_C_7 = 9'd242,
    COMP_LOOP_24_VEC_LOOP_C_8 = 9'd243,
    COMP_LOOP_C_26 = 9'd244,
    COMP_LOOP_25_VEC_LOOP_C_0 = 9'd245,
    COMP_LOOP_25_VEC_LOOP_C_1 = 9'd246,
    COMP_LOOP_25_VEC_LOOP_C_2 = 9'd247,
    COMP_LOOP_25_VEC_LOOP_C_3 = 9'd248,
    COMP_LOOP_25_VEC_LOOP_C_4 = 9'd249,
    COMP_LOOP_25_VEC_LOOP_C_5 = 9'd250,
    COMP_LOOP_25_VEC_LOOP_C_6 = 9'd251,
    COMP_LOOP_25_VEC_LOOP_C_7 = 9'd252,
    COMP_LOOP_25_VEC_LOOP_C_8 = 9'd253,
    COMP_LOOP_C_27 = 9'd254,
    COMP_LOOP_26_VEC_LOOP_C_0 = 9'd255,
    COMP_LOOP_26_VEC_LOOP_C_1 = 9'd256,
    COMP_LOOP_26_VEC_LOOP_C_2 = 9'd257,
    COMP_LOOP_26_VEC_LOOP_C_3 = 9'd258,
    COMP_LOOP_26_VEC_LOOP_C_4 = 9'd259,
    COMP_LOOP_26_VEC_LOOP_C_5 = 9'd260,
    COMP_LOOP_26_VEC_LOOP_C_6 = 9'd261,
    COMP_LOOP_26_VEC_LOOP_C_7 = 9'd262,
    COMP_LOOP_26_VEC_LOOP_C_8 = 9'd263,
    COMP_LOOP_C_28 = 9'd264,
    COMP_LOOP_27_VEC_LOOP_C_0 = 9'd265,
    COMP_LOOP_27_VEC_LOOP_C_1 = 9'd266,
    COMP_LOOP_27_VEC_LOOP_C_2 = 9'd267,
    COMP_LOOP_27_VEC_LOOP_C_3 = 9'd268,
    COMP_LOOP_27_VEC_LOOP_C_4 = 9'd269,
    COMP_LOOP_27_VEC_LOOP_C_5 = 9'd270,
    COMP_LOOP_27_VEC_LOOP_C_6 = 9'd271,
    COMP_LOOP_27_VEC_LOOP_C_7 = 9'd272,
    COMP_LOOP_27_VEC_LOOP_C_8 = 9'd273,
    COMP_LOOP_C_29 = 9'd274,
    COMP_LOOP_28_VEC_LOOP_C_0 = 9'd275,
    COMP_LOOP_28_VEC_LOOP_C_1 = 9'd276,
    COMP_LOOP_28_VEC_LOOP_C_2 = 9'd277,
    COMP_LOOP_28_VEC_LOOP_C_3 = 9'd278,
    COMP_LOOP_28_VEC_LOOP_C_4 = 9'd279,
    COMP_LOOP_28_VEC_LOOP_C_5 = 9'd280,
    COMP_LOOP_28_VEC_LOOP_C_6 = 9'd281,
    COMP_LOOP_28_VEC_LOOP_C_7 = 9'd282,
    COMP_LOOP_28_VEC_LOOP_C_8 = 9'd283,
    COMP_LOOP_C_30 = 9'd284,
    COMP_LOOP_29_VEC_LOOP_C_0 = 9'd285,
    COMP_LOOP_29_VEC_LOOP_C_1 = 9'd286,
    COMP_LOOP_29_VEC_LOOP_C_2 = 9'd287,
    COMP_LOOP_29_VEC_LOOP_C_3 = 9'd288,
    COMP_LOOP_29_VEC_LOOP_C_4 = 9'd289,
    COMP_LOOP_29_VEC_LOOP_C_5 = 9'd290,
    COMP_LOOP_29_VEC_LOOP_C_6 = 9'd291,
    COMP_LOOP_29_VEC_LOOP_C_7 = 9'd292,
    COMP_LOOP_29_VEC_LOOP_C_8 = 9'd293,
    COMP_LOOP_C_31 = 9'd294,
    COMP_LOOP_30_VEC_LOOP_C_0 = 9'd295,
    COMP_LOOP_30_VEC_LOOP_C_1 = 9'd296,
    COMP_LOOP_30_VEC_LOOP_C_2 = 9'd297,
    COMP_LOOP_30_VEC_LOOP_C_3 = 9'd298,
    COMP_LOOP_30_VEC_LOOP_C_4 = 9'd299,
    COMP_LOOP_30_VEC_LOOP_C_5 = 9'd300,
    COMP_LOOP_30_VEC_LOOP_C_6 = 9'd301,
    COMP_LOOP_30_VEC_LOOP_C_7 = 9'd302,
    COMP_LOOP_30_VEC_LOOP_C_8 = 9'd303,
    COMP_LOOP_C_32 = 9'd304,
    COMP_LOOP_31_VEC_LOOP_C_0 = 9'd305,
    COMP_LOOP_31_VEC_LOOP_C_1 = 9'd306,
    COMP_LOOP_31_VEC_LOOP_C_2 = 9'd307,
    COMP_LOOP_31_VEC_LOOP_C_3 = 9'd308,
    COMP_LOOP_31_VEC_LOOP_C_4 = 9'd309,
    COMP_LOOP_31_VEC_LOOP_C_5 = 9'd310,
    COMP_LOOP_31_VEC_LOOP_C_6 = 9'd311,
    COMP_LOOP_31_VEC_LOOP_C_7 = 9'd312,
    COMP_LOOP_31_VEC_LOOP_C_8 = 9'd313,
    COMP_LOOP_C_33 = 9'd314,
    COMP_LOOP_32_VEC_LOOP_C_0 = 9'd315,
    COMP_LOOP_32_VEC_LOOP_C_1 = 9'd316,
    COMP_LOOP_32_VEC_LOOP_C_2 = 9'd317,
    COMP_LOOP_32_VEC_LOOP_C_3 = 9'd318,
    COMP_LOOP_32_VEC_LOOP_C_4 = 9'd319,
    COMP_LOOP_32_VEC_LOOP_C_5 = 9'd320,
    COMP_LOOP_32_VEC_LOOP_C_6 = 9'd321,
    COMP_LOOP_32_VEC_LOOP_C_7 = 9'd322,
    COMP_LOOP_32_VEC_LOOP_C_8 = 9'd323,
    COMP_LOOP_C_34 = 9'd324,
    STAGE_LOOP_C_1 = 9'd325,
    main_C_1 = 9'd326,
    main_C_2 = 9'd327;

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
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 9'b000000100;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
      end
      COMP_LOOP_1_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000000101;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_1;
      end
      COMP_LOOP_1_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000000110;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_2;
      end
      COMP_LOOP_1_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000000111;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_3;
      end
      COMP_LOOP_1_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000001000;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_4;
      end
      COMP_LOOP_1_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000001001;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_5;
      end
      COMP_LOOP_1_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000001010;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_6;
      end
      COMP_LOOP_1_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000001011;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_7;
      end
      COMP_LOOP_1_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000001100;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_8;
      end
      COMP_LOOP_1_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000001101;
        if ( COMP_LOOP_1_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_3;
        end
        else begin
          state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 9'b000001110;
        if ( COMP_LOOP_C_3_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_2_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000001111;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_1;
      end
      COMP_LOOP_2_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000010000;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_2;
      end
      COMP_LOOP_2_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000010001;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_3;
      end
      COMP_LOOP_2_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000010010;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_4;
      end
      COMP_LOOP_2_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000010011;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_5;
      end
      COMP_LOOP_2_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000010100;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_6;
      end
      COMP_LOOP_2_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000010101;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_7;
      end
      COMP_LOOP_2_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000010110;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_8;
      end
      COMP_LOOP_2_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000010111;
        if ( COMP_LOOP_2_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_4;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 9'b000011000;
        if ( COMP_LOOP_C_4_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_3_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000011001;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_1;
      end
      COMP_LOOP_3_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000011010;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_2;
      end
      COMP_LOOP_3_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000011011;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_3;
      end
      COMP_LOOP_3_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000011100;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_4;
      end
      COMP_LOOP_3_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000011101;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_5;
      end
      COMP_LOOP_3_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000011110;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_6;
      end
      COMP_LOOP_3_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000011111;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_7;
      end
      COMP_LOOP_3_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000100000;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_8;
      end
      COMP_LOOP_3_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000100001;
        if ( COMP_LOOP_3_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_5;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 9'b000100010;
        if ( COMP_LOOP_C_5_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_4_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000100011;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_1;
      end
      COMP_LOOP_4_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000100100;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_2;
      end
      COMP_LOOP_4_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000100101;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_3;
      end
      COMP_LOOP_4_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000100110;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_4;
      end
      COMP_LOOP_4_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000100111;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_5;
      end
      COMP_LOOP_4_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000101000;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_6;
      end
      COMP_LOOP_4_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000101001;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_7;
      end
      COMP_LOOP_4_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000101010;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_8;
      end
      COMP_LOOP_4_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000101011;
        if ( COMP_LOOP_4_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_6;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 9'b000101100;
        if ( COMP_LOOP_C_6_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_5_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000101101;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_1;
      end
      COMP_LOOP_5_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000101110;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_2;
      end
      COMP_LOOP_5_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000101111;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_3;
      end
      COMP_LOOP_5_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000110000;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_4;
      end
      COMP_LOOP_5_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000110001;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_5;
      end
      COMP_LOOP_5_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000110010;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_6;
      end
      COMP_LOOP_5_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000110011;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_7;
      end
      COMP_LOOP_5_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000110100;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_8;
      end
      COMP_LOOP_5_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000110101;
        if ( COMP_LOOP_5_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_7;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 9'b000110110;
        if ( COMP_LOOP_C_7_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_6_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000110111;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_1;
      end
      COMP_LOOP_6_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000111000;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_2;
      end
      COMP_LOOP_6_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000111001;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_3;
      end
      COMP_LOOP_6_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000111010;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_4;
      end
      COMP_LOOP_6_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000111011;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_5;
      end
      COMP_LOOP_6_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000111100;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_6;
      end
      COMP_LOOP_6_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000111101;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_7;
      end
      COMP_LOOP_6_VEC_LOOP_C_7 : begin
        fsm_output = 9'b000111110;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_8;
      end
      COMP_LOOP_6_VEC_LOOP_C_8 : begin
        fsm_output = 9'b000111111;
        if ( COMP_LOOP_6_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_8;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 9'b001000000;
        if ( COMP_LOOP_C_8_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_7_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001000001;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_1;
      end
      COMP_LOOP_7_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001000010;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_2;
      end
      COMP_LOOP_7_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001000011;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_3;
      end
      COMP_LOOP_7_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001000100;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_4;
      end
      COMP_LOOP_7_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001000101;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_5;
      end
      COMP_LOOP_7_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001000110;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_6;
      end
      COMP_LOOP_7_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001000111;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_7;
      end
      COMP_LOOP_7_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001001000;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_8;
      end
      COMP_LOOP_7_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001001001;
        if ( COMP_LOOP_7_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_9;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 9'b001001010;
        if ( COMP_LOOP_C_9_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_8_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001001011;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_1;
      end
      COMP_LOOP_8_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001001100;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_2;
      end
      COMP_LOOP_8_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001001101;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_3;
      end
      COMP_LOOP_8_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001001110;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_4;
      end
      COMP_LOOP_8_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001001111;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_5;
      end
      COMP_LOOP_8_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001010000;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_6;
      end
      COMP_LOOP_8_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001010001;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_7;
      end
      COMP_LOOP_8_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001010010;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_8;
      end
      COMP_LOOP_8_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001010011;
        if ( COMP_LOOP_8_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_10;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 9'b001010100;
        if ( COMP_LOOP_C_10_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_9_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001010101;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_1;
      end
      COMP_LOOP_9_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001010110;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_2;
      end
      COMP_LOOP_9_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001010111;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_3;
      end
      COMP_LOOP_9_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001011000;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_4;
      end
      COMP_LOOP_9_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001011001;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_5;
      end
      COMP_LOOP_9_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001011010;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_6;
      end
      COMP_LOOP_9_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001011011;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_7;
      end
      COMP_LOOP_9_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001011100;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_8;
      end
      COMP_LOOP_9_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001011101;
        if ( COMP_LOOP_9_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_11;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 9'b001011110;
        if ( COMP_LOOP_C_11_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_10_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001011111;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_1;
      end
      COMP_LOOP_10_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001100000;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_2;
      end
      COMP_LOOP_10_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001100001;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_3;
      end
      COMP_LOOP_10_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001100010;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_4;
      end
      COMP_LOOP_10_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001100011;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_5;
      end
      COMP_LOOP_10_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001100100;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_6;
      end
      COMP_LOOP_10_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001100101;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_7;
      end
      COMP_LOOP_10_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001100110;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_8;
      end
      COMP_LOOP_10_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001100111;
        if ( COMP_LOOP_10_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_12;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 9'b001101000;
        if ( COMP_LOOP_C_12_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_11_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001101001;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_1;
      end
      COMP_LOOP_11_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001101010;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_2;
      end
      COMP_LOOP_11_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001101011;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_3;
      end
      COMP_LOOP_11_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001101100;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_4;
      end
      COMP_LOOP_11_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001101101;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_5;
      end
      COMP_LOOP_11_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001101110;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_6;
      end
      COMP_LOOP_11_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001101111;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_7;
      end
      COMP_LOOP_11_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001110000;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_8;
      end
      COMP_LOOP_11_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001110001;
        if ( COMP_LOOP_11_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_13;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 9'b001110010;
        if ( COMP_LOOP_C_13_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_12_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001110011;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_1;
      end
      COMP_LOOP_12_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001110100;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_2;
      end
      COMP_LOOP_12_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001110101;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_3;
      end
      COMP_LOOP_12_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001110110;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_4;
      end
      COMP_LOOP_12_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001110111;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_5;
      end
      COMP_LOOP_12_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001111000;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_6;
      end
      COMP_LOOP_12_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001111001;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_7;
      end
      COMP_LOOP_12_VEC_LOOP_C_7 : begin
        fsm_output = 9'b001111010;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_8;
      end
      COMP_LOOP_12_VEC_LOOP_C_8 : begin
        fsm_output = 9'b001111011;
        if ( COMP_LOOP_12_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_14;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 9'b001111100;
        if ( COMP_LOOP_C_14_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_13_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001111101;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_1;
      end
      COMP_LOOP_13_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001111110;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_2;
      end
      COMP_LOOP_13_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001111111;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_3;
      end
      COMP_LOOP_13_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010000000;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_4;
      end
      COMP_LOOP_13_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010000001;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_5;
      end
      COMP_LOOP_13_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010000010;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_6;
      end
      COMP_LOOP_13_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010000011;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_7;
      end
      COMP_LOOP_13_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010000100;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_8;
      end
      COMP_LOOP_13_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010000101;
        if ( COMP_LOOP_13_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_15;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 9'b010000110;
        if ( COMP_LOOP_C_15_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_14_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010000111;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_1;
      end
      COMP_LOOP_14_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010001000;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_2;
      end
      COMP_LOOP_14_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010001001;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_3;
      end
      COMP_LOOP_14_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010001010;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_4;
      end
      COMP_LOOP_14_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010001011;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_5;
      end
      COMP_LOOP_14_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010001100;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_6;
      end
      COMP_LOOP_14_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010001101;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_7;
      end
      COMP_LOOP_14_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010001110;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_8;
      end
      COMP_LOOP_14_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010001111;
        if ( COMP_LOOP_14_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_16;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 9'b010010000;
        if ( COMP_LOOP_C_16_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_15_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010010001;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_1;
      end
      COMP_LOOP_15_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010010010;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_2;
      end
      COMP_LOOP_15_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010010011;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_3;
      end
      COMP_LOOP_15_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010010100;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_4;
      end
      COMP_LOOP_15_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010010101;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_5;
      end
      COMP_LOOP_15_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010010110;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_6;
      end
      COMP_LOOP_15_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010010111;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_7;
      end
      COMP_LOOP_15_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010011000;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_8;
      end
      COMP_LOOP_15_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010011001;
        if ( COMP_LOOP_15_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_17;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 9'b010011010;
        if ( COMP_LOOP_C_17_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_16_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010011011;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_1;
      end
      COMP_LOOP_16_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010011100;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_2;
      end
      COMP_LOOP_16_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010011101;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_3;
      end
      COMP_LOOP_16_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010011110;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_4;
      end
      COMP_LOOP_16_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010011111;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_5;
      end
      COMP_LOOP_16_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010100000;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_6;
      end
      COMP_LOOP_16_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010100001;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_7;
      end
      COMP_LOOP_16_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010100010;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_8;
      end
      COMP_LOOP_16_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010100011;
        if ( COMP_LOOP_16_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_18;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 9'b010100100;
        if ( COMP_LOOP_C_18_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_17_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_17_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010100101;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_1;
      end
      COMP_LOOP_17_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010100110;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_2;
      end
      COMP_LOOP_17_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010100111;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_3;
      end
      COMP_LOOP_17_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010101000;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_4;
      end
      COMP_LOOP_17_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010101001;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_5;
      end
      COMP_LOOP_17_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010101010;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_6;
      end
      COMP_LOOP_17_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010101011;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_7;
      end
      COMP_LOOP_17_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010101100;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_8;
      end
      COMP_LOOP_17_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010101101;
        if ( COMP_LOOP_17_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_19;
        end
        else begin
          state_var_NS = COMP_LOOP_17_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 9'b010101110;
        if ( COMP_LOOP_C_19_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_18_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_18_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010101111;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_1;
      end
      COMP_LOOP_18_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010110000;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_2;
      end
      COMP_LOOP_18_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010110001;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_3;
      end
      COMP_LOOP_18_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010110010;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_4;
      end
      COMP_LOOP_18_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010110011;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_5;
      end
      COMP_LOOP_18_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010110100;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_6;
      end
      COMP_LOOP_18_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010110101;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_7;
      end
      COMP_LOOP_18_VEC_LOOP_C_7 : begin
        fsm_output = 9'b010110110;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_8;
      end
      COMP_LOOP_18_VEC_LOOP_C_8 : begin
        fsm_output = 9'b010110111;
        if ( COMP_LOOP_18_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_20;
        end
        else begin
          state_var_NS = COMP_LOOP_18_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 9'b010111000;
        if ( COMP_LOOP_C_20_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_19_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_19_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010111001;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_1;
      end
      COMP_LOOP_19_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010111010;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_2;
      end
      COMP_LOOP_19_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010111011;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_3;
      end
      COMP_LOOP_19_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010111100;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_4;
      end
      COMP_LOOP_19_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010111101;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_5;
      end
      COMP_LOOP_19_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010111110;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_6;
      end
      COMP_LOOP_19_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010111111;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_7;
      end
      COMP_LOOP_19_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011000000;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_8;
      end
      COMP_LOOP_19_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011000001;
        if ( COMP_LOOP_19_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_21;
        end
        else begin
          state_var_NS = COMP_LOOP_19_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 9'b011000010;
        if ( COMP_LOOP_C_21_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_20_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_20_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011000011;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_1;
      end
      COMP_LOOP_20_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011000100;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_2;
      end
      COMP_LOOP_20_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011000101;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_3;
      end
      COMP_LOOP_20_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011000110;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_4;
      end
      COMP_LOOP_20_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011000111;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_5;
      end
      COMP_LOOP_20_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011001000;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_6;
      end
      COMP_LOOP_20_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011001001;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_7;
      end
      COMP_LOOP_20_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011001010;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_8;
      end
      COMP_LOOP_20_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011001011;
        if ( COMP_LOOP_20_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_22;
        end
        else begin
          state_var_NS = COMP_LOOP_20_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 9'b011001100;
        if ( COMP_LOOP_C_22_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_21_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_21_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011001101;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_1;
      end
      COMP_LOOP_21_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011001110;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_2;
      end
      COMP_LOOP_21_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011001111;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_3;
      end
      COMP_LOOP_21_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011010000;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_4;
      end
      COMP_LOOP_21_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011010001;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_5;
      end
      COMP_LOOP_21_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011010010;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_6;
      end
      COMP_LOOP_21_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011010011;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_7;
      end
      COMP_LOOP_21_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011010100;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_8;
      end
      COMP_LOOP_21_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011010101;
        if ( COMP_LOOP_21_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_23;
        end
        else begin
          state_var_NS = COMP_LOOP_21_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 9'b011010110;
        if ( COMP_LOOP_C_23_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_22_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_22_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011010111;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_1;
      end
      COMP_LOOP_22_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011011000;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_2;
      end
      COMP_LOOP_22_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011011001;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_3;
      end
      COMP_LOOP_22_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011011010;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_4;
      end
      COMP_LOOP_22_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011011011;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_5;
      end
      COMP_LOOP_22_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011011100;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_6;
      end
      COMP_LOOP_22_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011011101;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_7;
      end
      COMP_LOOP_22_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011011110;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_8;
      end
      COMP_LOOP_22_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011011111;
        if ( COMP_LOOP_22_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_24;
        end
        else begin
          state_var_NS = COMP_LOOP_22_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 9'b011100000;
        if ( COMP_LOOP_C_24_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_23_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_23_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011100001;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_1;
      end
      COMP_LOOP_23_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011100010;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_2;
      end
      COMP_LOOP_23_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011100011;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_3;
      end
      COMP_LOOP_23_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011100100;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_4;
      end
      COMP_LOOP_23_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011100101;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_5;
      end
      COMP_LOOP_23_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011100110;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_6;
      end
      COMP_LOOP_23_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011100111;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_7;
      end
      COMP_LOOP_23_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011101000;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_8;
      end
      COMP_LOOP_23_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011101001;
        if ( COMP_LOOP_23_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_25;
        end
        else begin
          state_var_NS = COMP_LOOP_23_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 9'b011101010;
        if ( COMP_LOOP_C_25_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_24_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_24_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011101011;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_1;
      end
      COMP_LOOP_24_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011101100;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_2;
      end
      COMP_LOOP_24_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011101101;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_3;
      end
      COMP_LOOP_24_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011101110;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_4;
      end
      COMP_LOOP_24_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011101111;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_5;
      end
      COMP_LOOP_24_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011110000;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_6;
      end
      COMP_LOOP_24_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011110001;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_7;
      end
      COMP_LOOP_24_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011110010;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_8;
      end
      COMP_LOOP_24_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011110011;
        if ( COMP_LOOP_24_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_26;
        end
        else begin
          state_var_NS = COMP_LOOP_24_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 9'b011110100;
        if ( COMP_LOOP_C_26_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_25_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_25_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011110101;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_1;
      end
      COMP_LOOP_25_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011110110;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_2;
      end
      COMP_LOOP_25_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011110111;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_3;
      end
      COMP_LOOP_25_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011111000;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_4;
      end
      COMP_LOOP_25_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011111001;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_5;
      end
      COMP_LOOP_25_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011111010;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_6;
      end
      COMP_LOOP_25_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011111011;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_7;
      end
      COMP_LOOP_25_VEC_LOOP_C_7 : begin
        fsm_output = 9'b011111100;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_8;
      end
      COMP_LOOP_25_VEC_LOOP_C_8 : begin
        fsm_output = 9'b011111101;
        if ( COMP_LOOP_25_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_27;
        end
        else begin
          state_var_NS = COMP_LOOP_25_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 9'b011111110;
        if ( COMP_LOOP_C_27_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_26_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_26_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011111111;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_1;
      end
      COMP_LOOP_26_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100000000;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_2;
      end
      COMP_LOOP_26_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100000001;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_3;
      end
      COMP_LOOP_26_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100000010;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_4;
      end
      COMP_LOOP_26_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100000011;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_5;
      end
      COMP_LOOP_26_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100000100;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_6;
      end
      COMP_LOOP_26_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100000101;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_7;
      end
      COMP_LOOP_26_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100000110;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_8;
      end
      COMP_LOOP_26_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100000111;
        if ( COMP_LOOP_26_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_28;
        end
        else begin
          state_var_NS = COMP_LOOP_26_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 9'b100001000;
        if ( COMP_LOOP_C_28_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_27_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_27_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100001001;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_1;
      end
      COMP_LOOP_27_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100001010;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_2;
      end
      COMP_LOOP_27_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100001011;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_3;
      end
      COMP_LOOP_27_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100001100;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_4;
      end
      COMP_LOOP_27_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100001101;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_5;
      end
      COMP_LOOP_27_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100001110;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_6;
      end
      COMP_LOOP_27_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100001111;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_7;
      end
      COMP_LOOP_27_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100010000;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_8;
      end
      COMP_LOOP_27_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100010001;
        if ( COMP_LOOP_27_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_29;
        end
        else begin
          state_var_NS = COMP_LOOP_27_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 9'b100010010;
        if ( COMP_LOOP_C_29_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_28_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_28_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100010011;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_1;
      end
      COMP_LOOP_28_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100010100;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_2;
      end
      COMP_LOOP_28_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100010101;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_3;
      end
      COMP_LOOP_28_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100010110;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_4;
      end
      COMP_LOOP_28_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100010111;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_5;
      end
      COMP_LOOP_28_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100011000;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_6;
      end
      COMP_LOOP_28_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100011001;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_7;
      end
      COMP_LOOP_28_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100011010;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_8;
      end
      COMP_LOOP_28_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100011011;
        if ( COMP_LOOP_28_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_30;
        end
        else begin
          state_var_NS = COMP_LOOP_28_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 9'b100011100;
        if ( COMP_LOOP_C_30_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_29_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_29_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100011101;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_1;
      end
      COMP_LOOP_29_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100011110;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_2;
      end
      COMP_LOOP_29_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100011111;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_3;
      end
      COMP_LOOP_29_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100100000;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_4;
      end
      COMP_LOOP_29_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100100001;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_5;
      end
      COMP_LOOP_29_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100100010;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_6;
      end
      COMP_LOOP_29_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100100011;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_7;
      end
      COMP_LOOP_29_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100100100;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_8;
      end
      COMP_LOOP_29_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100100101;
        if ( COMP_LOOP_29_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_31;
        end
        else begin
          state_var_NS = COMP_LOOP_29_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 9'b100100110;
        if ( COMP_LOOP_C_31_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_30_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_30_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100100111;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_1;
      end
      COMP_LOOP_30_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100101000;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_2;
      end
      COMP_LOOP_30_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100101001;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_3;
      end
      COMP_LOOP_30_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100101010;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_4;
      end
      COMP_LOOP_30_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100101011;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_5;
      end
      COMP_LOOP_30_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100101100;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_6;
      end
      COMP_LOOP_30_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100101101;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_7;
      end
      COMP_LOOP_30_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100101110;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_8;
      end
      COMP_LOOP_30_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100101111;
        if ( COMP_LOOP_30_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_32;
        end
        else begin
          state_var_NS = COMP_LOOP_30_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 9'b100110000;
        if ( COMP_LOOP_C_32_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_31_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_31_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100110001;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_1;
      end
      COMP_LOOP_31_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100110010;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_2;
      end
      COMP_LOOP_31_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100110011;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_3;
      end
      COMP_LOOP_31_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100110100;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_4;
      end
      COMP_LOOP_31_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100110101;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_5;
      end
      COMP_LOOP_31_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100110110;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_6;
      end
      COMP_LOOP_31_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100110111;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_7;
      end
      COMP_LOOP_31_VEC_LOOP_C_7 : begin
        fsm_output = 9'b100111000;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_8;
      end
      COMP_LOOP_31_VEC_LOOP_C_8 : begin
        fsm_output = 9'b100111001;
        if ( COMP_LOOP_31_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_33;
        end
        else begin
          state_var_NS = COMP_LOOP_31_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 9'b100111010;
        if ( COMP_LOOP_C_33_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_32_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_32_VEC_LOOP_C_0 : begin
        fsm_output = 9'b100111011;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_1;
      end
      COMP_LOOP_32_VEC_LOOP_C_1 : begin
        fsm_output = 9'b100111100;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_2;
      end
      COMP_LOOP_32_VEC_LOOP_C_2 : begin
        fsm_output = 9'b100111101;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_3;
      end
      COMP_LOOP_32_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100111110;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_4;
      end
      COMP_LOOP_32_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100111111;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_5;
      end
      COMP_LOOP_32_VEC_LOOP_C_5 : begin
        fsm_output = 9'b101000000;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_6;
      end
      COMP_LOOP_32_VEC_LOOP_C_6 : begin
        fsm_output = 9'b101000001;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_7;
      end
      COMP_LOOP_32_VEC_LOOP_C_7 : begin
        fsm_output = 9'b101000010;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_8;
      end
      COMP_LOOP_32_VEC_LOOP_C_8 : begin
        fsm_output = 9'b101000011;
        if ( COMP_LOOP_32_VEC_LOOP_C_8_tr0 ) begin
          state_var_NS = COMP_LOOP_C_34;
        end
        else begin
          state_var_NS = COMP_LOOP_32_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 9'b101000100;
        if ( COMP_LOOP_C_34_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 9'b101000101;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b101000110;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 9'b101000111;
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
  output [27:0] vec_rsci_adra_d;
  output [31:0] vec_rsci_da_d;
  input [63:0] vec_rsci_qa_d;
  output [1:0] vec_rsci_wea_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [27:0] twiddle_h_rsci_adra_d;
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
  wire [8:0] fsm_output;
  wire or_tmp_25;
  wire and_tmp_2;
  wire nor_tmp_7;
  wire or_tmp_36;
  wire or_tmp_37;
  wire or_tmp_62;
  wire or_tmp_63;
  wire nor_tmp_16;
  wire nor_tmp_36;
  wire or_dcpl_161;
  wire or_tmp_134;
  wire mux_tmp_274;
  wire mux_tmp_276;
  wire or_tmp_137;
  wire mux_tmp_277;
  wire mux_tmp_278;
  wire or_tmp_138;
  wire mux_tmp_281;
  wire mux_tmp_282;
  wire mux_tmp_283;
  wire mux_tmp_284;
  wire mux_tmp_286;
  wire mux_tmp_288;
  wire mux_tmp_293;
  wire mux_tmp_294;
  wire or_tmp_145;
  wire or_tmp_146;
  wire mux_tmp_308;
  wire or_tmp_149;
  wire mux_tmp_310;
  wire mux_tmp_312;
  wire mux_tmp_314;
  wire and_dcpl_11;
  wire and_dcpl_12;
  wire and_dcpl_13;
  wire and_dcpl_14;
  wire and_dcpl_15;
  wire and_dcpl_16;
  wire and_dcpl_17;
  wire and_dcpl_18;
  wire and_dcpl_20;
  wire and_dcpl_21;
  wire and_dcpl_23;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire mux_tmp_339;
  wire or_tmp_161;
  wire or_tmp_164;
  wire mux_tmp_342;
  wire mux_tmp_343;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire mux_tmp_351;
  wire mux_tmp_352;
  wire mux_tmp_354;
  wire mux_tmp_356;
  wire and_dcpl_34;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_38;
  wire and_dcpl_39;
  wire and_dcpl_40;
  wire and_dcpl_41;
  wire mux_tmp_357;
  wire mux_tmp_358;
  wire and_dcpl_42;
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
  wire xor_dcpl;
  wire and_dcpl_57;
  wire and_dcpl_58;
  wire and_dcpl_59;
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
  wire and_dcpl_102;
  wire or_tmp_173;
  wire or_tmp_174;
  wire and_dcpl_105;
  wire mux_tmp_362;
  wire mux_tmp_363;
  wire mux_tmp_382;
  wire mux_tmp_383;
  wire mux_tmp_389;
  wire mux_tmp_391;
  wire mux_tmp_400;
  wire mux_tmp_405;
  wire mux_tmp_412;
  wire or_tmp_210;
  wire or_tmp_218;
  wire or_tmp_225;
  wire mux_tmp_425;
  wire mux_tmp_434;
  wire mux_tmp_441;
  wire mux_tmp_446;
  wire or_tmp_235;
  wire or_tmp_236;
  wire mux_tmp_453;
  wire or_tmp_237;
  wire or_tmp_238;
  wire not_tmp_151;
  wire or_tmp_241;
  wire mux_tmp_459;
  wire mux_tmp_460;
  wire mux_tmp_478;
  wire or_tmp_254;
  wire mux_tmp_483;
  wire and_dcpl_125;
  wire and_dcpl_132;
  wire and_dcpl_133;
  wire mux_tmp_502;
  wire mux_tmp_506;
  wire and_dcpl_164;
  wire and_dcpl_166;
  wire and_dcpl_168;
  wire not_tmp_164;
  wire or_tmp_282;
  wire or_tmp_284;
  wire mux_tmp_514;
  wire mux_tmp_516;
  wire mux_tmp_517;
  wire mux_tmp_518;
  wire mux_tmp_519;
  wire mux_tmp_520;
  wire mux_tmp_521;
  wire mux_tmp_523;
  wire mux_tmp_524;
  wire mux_tmp_525;
  wire or_tmp_289;
  wire mux_tmp_533;
  wire or_tmp_293;
  wire and_dcpl_170;
  wire mux_tmp_564;
  wire and_dcpl_176;
  wire and_dcpl_181;
  wire mux_tmp_570;
  wire or_tmp_316;
  wire mux_tmp_574;
  wire mux_tmp_575;
  wire mux_tmp_579;
  wire mux_tmp_580;
  wire nor_tmp_66;
  wire mux_tmp_595;
  wire and_dcpl_190;
  wire mux_tmp_619;
  wire mux_tmp_620;
  wire mux_tmp_621;
  wire mux_tmp_624;
  wire mux_tmp_625;
  wire mux_tmp_631;
  wire mux_tmp_633;
  wire mux_tmp_638;
  wire mux_tmp_643;
  wire mux_tmp_648;
  wire or_tmp_351;
  wire or_tmp_352;
  wire or_tmp_354;
  wire and_dcpl_195;
  wire or_tmp_380;
  wire mux_tmp_719;
  wire mux_tmp_721;
  wire mux_tmp_722;
  wire mux_tmp_724;
  wire mux_tmp_735;
  wire or_tmp_387;
  wire and_dcpl_199;
  wire mux_tmp_753;
  wire mux_tmp_755;
  wire and_dcpl_200;
  wire or_tmp_426;
  wire mux_tmp_808;
  wire mux_tmp_813;
  wire mux_tmp_814;
  wire nand_tmp_12;
  reg COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  reg [13:0] VEC_LOOP_acc_1_cse_10_sva;
  reg [14:0] STAGE_LOOP_lshift_psp_sva;
  reg [14:0] VEC_LOOP_j_10_14_0_sva_1;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_twiddle_rsci_oswt_1_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_2_cse;
  wire or_483_cse;
  wire or_499_cse;
  wire and_242_cse;
  wire and_265_cse;
  wire or_480_cse;
  wire or_285_cse;
  wire or_140_cse;
  wire or_558_cse;
  wire or_445_cse;
  wire or_420_cse;
  wire or_322_cse;
  wire nor_125_cse;
  wire mux_266_cse;
  wire and_232_cse;
  wire or_559_cse;
  wire or_659_cse;
  wire mux_307_cse;
  wire mux_311_cse;
  wire mux_375_cse;
  wire mux_489_cse;
  wire mux_331_cse;
  wire mux_350_cse;
  wire mux_267_cse;
  wire mux_594_cse;
  wire mux_360_cse;
  wire mux_361_cse;
  wire mux_366_cse;
  wire mux_908_cse;
  wire mux_318_cse;
  wire mux_551_cse;
  wire mux_548_cse;
  wire mux_428_cse;
  wire mux_364_cse;
  wire nand_4_cse;
  wire nand_3_cse;
  wire or_358_cse;
  wire mux_426_cse;
  wire mux_420_cse;
  wire mux_367_cse;
  wire or_656_cse;
  wire mux_910_cse;
  wire mux_319_cse;
  wire mux_316_cse;
  wire mux_549_cse;
  wire mux_789_cse;
  wire mux_372_cse;
  wire mux_377_cse;
  wire mux_373_cse;
  wire mux_378_cse;
  wire mux_271_cse;
  wire mux_797_cse;
  wire mux_320_cse;
  wire mux_317_cse;
  wire mux_427_cse;
  wire mux_877_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_14_rmff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [9:0] COMP_LOOP_twiddle_help_mux_1_rmff;
  wire [3:0] COMP_LOOP_twiddle_help_mux_rmff;
  wire [8:0] COMP_LOOP_twiddle_f_mux1h_87_rmff;
  wire [1:0] COMP_LOOP_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_57_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_111_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_128_rmff;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_128_rmff;
  wire and_123_rmff;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  reg [31:0] factor1_1_sva;
  reg [31:0] VEC_LOOP_mult_vec_1_sva;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_f_17_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_17_sva;
  wire [13:0] VEC_LOOP_acc_10_cse_2_sva_mx0w1;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1;
  reg [13:0] VEC_LOOP_acc_10_cse_1_sva;
  wire [13:0] VEC_LOOP_acc_10_cse_3_sva_mx0w2;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2;
  wire [13:0] VEC_LOOP_acc_10_cse_4_sva_mx0w3;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3;
  wire [13:0] VEC_LOOP_acc_10_cse_5_sva_mx0w4;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4;
  wire [13:0] VEC_LOOP_acc_10_cse_6_sva_mx0w5;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5;
  wire [13:0] VEC_LOOP_acc_10_cse_7_sva_mx0w6;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6;
  wire [13:0] VEC_LOOP_acc_10_cse_8_sva_mx0w7;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7;
  wire [13:0] VEC_LOOP_acc_10_cse_9_sva_mx0w8;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_9_sva_mx0w8;
  wire [13:0] VEC_LOOP_acc_10_cse_10_sva_mx0w9;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9;
  wire [13:0] VEC_LOOP_acc_10_cse_11_sva_mx0w10;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10;
  wire [13:0] VEC_LOOP_acc_10_cse_12_sva_mx0w11;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11;
  wire [13:0] VEC_LOOP_acc_10_cse_13_sva_mx0w12;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12;
  wire [13:0] VEC_LOOP_acc_10_cse_14_sva_mx0w13;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13;
  wire [13:0] VEC_LOOP_acc_10_cse_15_sva_mx0w14;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14;
  wire [13:0] VEC_LOOP_acc_10_cse_16_sva_mx0w15;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15;
  reg [9:0] COMP_LOOP_17_twiddle_f_mul_psp_sva;
  wire [13:0] VEC_LOOP_acc_10_cse_18_sva_mx0w17;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17;
  wire [13:0] VEC_LOOP_acc_10_cse_19_sva_mx0w18;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18;
  wire [13:0] VEC_LOOP_acc_10_cse_21_sva_mx0w20;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20;
  wire [13:0] VEC_LOOP_acc_10_cse_23_sva_mx0w22;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22;
  wire [13:0] VEC_LOOP_acc_10_cse_25_sva_mx0w24;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_25_sva_mx0w24;
  wire [13:0] VEC_LOOP_acc_10_cse_27_sva_mx0w26;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26;
  wire [13:0] VEC_LOOP_acc_10_cse_29_sva_mx0w28;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28;
  wire [13:0] VEC_LOOP_acc_10_cse_30_sva_mx0w29;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29;
  wire [13:0] VEC_LOOP_acc_10_cse_31_sva_mx0w30;
  wire [14:0] nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30;
  reg [31:0] p_sva;
  wire mux_306_itm;
  wire mux_452_itm;
  wire mux_532_itm;
  wire mux_411_itm;
  wire [14:0] z_out;
  wire [11:0] z_out_1;
  wire and_dcpl_251;
  wire [13:0] z_out_2;
  wire [27:0] nl_z_out_2;
  wire and_dcpl_265;
  wire and_dcpl_267;
  wire and_dcpl_271;
  wire and_dcpl_276;
  wire [13:0] z_out_3;
  wire [27:0] nl_z_out_3;
  wire and_dcpl_289;
  wire and_dcpl_294;
  wire and_dcpl_300;
  wire [13:0] z_out_4;
  wire [27:0] nl_z_out_4;
  wire and_dcpl_303;
  wire and_dcpl_308;
  wire and_dcpl_313;
  wire and_dcpl_316;
  wire and_dcpl_320;
  wire and_dcpl_324;
  wire and_dcpl_337;
  wire [13:0] z_out_6;
  wire [27:0] nl_z_out_6;
  wire and_dcpl_351;
  wire and_dcpl_356;
  wire and_dcpl_363;
  wire and_dcpl_368;
  wire and_dcpl_374;
  wire and_dcpl_377;
  wire and_dcpl_382;
  wire and_dcpl_387;
  wire and_dcpl_392;
  wire and_dcpl_423;
  wire and_dcpl_429;
  wire [13:0] z_out_10;
  wire [27:0] nl_z_out_10;
  wire and_dcpl_433;
  wire and_dcpl_436;
  wire and_dcpl_438;
  wire and_dcpl_441;
  wire and_dcpl_444;
  wire and_dcpl_446;
  wire and_dcpl_449;
  wire and_dcpl_451;
  wire and_dcpl_454;
  wire and_dcpl_455;
  wire and_dcpl_458;
  wire and_dcpl_459;
  wire and_dcpl_461;
  wire and_dcpl_463;
  wire and_dcpl_467;
  wire and_dcpl_468;
  wire and_dcpl_470;
  wire and_dcpl_472;
  wire and_dcpl_473;
  wire and_dcpl_474;
  wire and_dcpl_476;
  wire and_dcpl_478;
  wire and_dcpl_480;
  wire and_dcpl_481;
  wire [14:0] z_out_11;
  wire and_dcpl_547;
  wire [3:0] z_out_14;
  wire [4:0] nl_z_out_14;
  wire and_dcpl_550;
  wire and_dcpl_568;
  wire and_dcpl_574;
  wire [13:0] z_out_15;
  wire [14:0] nl_z_out_15;
  wire and_dcpl_635;
  wire [13:0] z_out_16;
  wire [14:0] nl_z_out_16;
  wire and_dcpl_646;
  wire and_dcpl_653;
  wire and_dcpl_658;
  wire [13:0] z_out_17;
  wire [14:0] nl_z_out_17;
  wire [13:0] z_out_18;
  wire [14:0] nl_z_out_18;
  wire [13:0] z_out_19;
  wire [14:0] nl_z_out_19;
  wire and_dcpl_752;
  wire and_dcpl_757;
  wire and_dcpl_761;
  wire and_dcpl_766;
  wire and_dcpl_771;
  wire and_dcpl_775;
  wire and_dcpl_777;
  wire and_dcpl_780;
  wire and_dcpl_782;
  wire and_dcpl_785;
  wire and_dcpl_787;
  wire [11:0] z_out_20;
  wire [31:0] z_out_21;
  wire and_dcpl_804;
  wire and_dcpl_817;
  wire [9:0] z_out_22;
  wire and_dcpl_820;
  wire and_dcpl_825;
  wire and_dcpl_830;
  wire [9:0] z_out_23;
  wire [10:0] nl_z_out_23;
  wire and_dcpl_839;
  wire and_dcpl_844;
  wire and_dcpl_850;
  wire and_dcpl_853;
  wire and_dcpl_857;
  wire and_dcpl_860;
  wire and_dcpl_867;
  wire and_dcpl_871;
  wire and_dcpl_873;
  wire and_dcpl_875;
  wire and_dcpl_877;
  wire and_dcpl_879;
  wire [12:0] z_out_24;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva;
  reg [13:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [11:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva;
  reg [10:0] COMP_LOOP_9_twiddle_f_lshift_ncse_sva;
  reg [8:0] COMP_LOOP_k_14_5_sva_8_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [12:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
  wire [13:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c0;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c2;
  wire COMP_LOOP_or_cse;
  wire COMP_LOOP_or_2_cse;
  wire COMP_LOOP_or_1_cse;
  wire COMP_LOOP_or_5_cse;
  wire COMP_LOOP_or_4_cse;
  wire COMP_LOOP_or_3_cse;
  wire COMP_LOOP_or_7_cse;
  wire COMP_LOOP_or_6_cse;
  wire VEC_LOOP_or_37_cse;
  wire VEC_LOOP_or_12_cse;
  wire VEC_LOOP_or_13_cse;
  wire VEC_LOOP_or_38_cse;
  wire VEC_LOOP_or_36_cse;
  wire VEC_LOOP_or_23_cse;
  wire nor_175_cse;
  wire VEC_LOOP_or_42_ssc;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire and_634_cse;
  wire and_606_cse;
  wire nor_179_cse;
  wire or_tmp_510;
  wire [12:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt;
  wire or_tmp_517;
  wire mux_tmp_957;
  wire not_tmp_446;
  wire or_tmp_523;
  wire or_tmp_524;
  wire mux_tmp_974;
  wire nand_tmp_21;
  wire mux_tmp_975;
  wire or_tmp_537;
  wire mux_tmp_976;
  wire mux_tmp_978;
  wire mux_tmp_979;
  wire mux_tmp_980;
  wire and_tmp;
  wire mux_tmp_990;
  wire or_tmp_549;
  wire mux_tmp_993;
  wire mux_tmp_999;
  wire or_tmp_556;
  wire or_tmp_558;
  wire and_tmp_4;
  wire or_tmp_560;
  wire or_tmp_562;
  reg [3:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_12_9;
  reg [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_8_0;
  reg VEC_LOOP_acc_11_psp_sva_12;
  reg VEC_LOOP_acc_11_psp_sva_11;
  reg [10:0] VEC_LOOP_acc_11_psp_sva_10_0;
  wire mux_885_ssc;
  wire or_714_cse;
  wire and_237_cse_1;
  wire or_717_cse;
  wire and_257_cse;
  wire or_743_cse;
  wire and_973_cse;
  wire VEC_LOOP_or_51_itm;
  wire and_767_itm;
  wire and_771_itm;
  wire VEC_LOOP_or_46_itm;
  wire VEC_LOOP_or_61_itm;
  wire VEC_LOOP_nor_17_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire and_937_cse;
  wire and_943_cse;
  wire [11:0] z_out_5_11_0;
  wire [23:0] nl_z_out_5_11_0;
  wire [12:0] z_out_7_12_0;
  wire [25:0] nl_z_out_7_12_0;
  wire [12:0] z_out_8_12_0;
  wire [25:0] nl_z_out_8_12_0;
  wire [10:0] z_out_9_10_0;
  wire [21:0] nl_z_out_9_10_0;
  wire z_out_12_14;
  wire [4:0] z_out_13_18_14;

  wire[0:0] mux_305_nl;
  wire[0:0] mux_304_nl;
  wire[0:0] mux_303_nl;
  wire[0:0] mux_302_nl;
  wire[0:0] nand_nl;
  wire[0:0] mux_301_nl;
  wire[0:0] mux_300_nl;
  wire[0:0] mux_299_nl;
  wire[0:0] or_307_nl;
  wire[0:0] mux_298_nl;
  wire[0:0] mux_297_nl;
  wire[0:0] mux_296_nl;
  wire[0:0] mux_295_nl;
  wire[0:0] mux_291_nl;
  wire[0:0] mux_290_nl;
  wire[0:0] mux_289_nl;
  wire[0:0] mux_315_nl;
  wire[0:0] mux_321_nl;
  wire[0:0] nand_33_nl;
  wire[0:0] or_356_nl;
  wire[0:0] mux_424_nl;
  wire[0:0] mux_451_nl;
  wire[0:0] mux_450_nl;
  wire[0:0] mux_449_nl;
  wire[0:0] mux_448_nl;
  wire[0:0] mux_447_nl;
  wire[0:0] mux_442_nl;
  wire[0:0] mux_437_nl;
  wire[0:0] mux_473_nl;
  wire[0:0] mux_472_nl;
  wire[0:0] mux_471_nl;
  wire[0:0] mux_470_nl;
  wire[0:0] mux_469_nl;
  wire[0:0] mux_468_nl;
  wire[0:0] mux_467_nl;
  wire[0:0] or_410_nl;
  wire[0:0] mux_466_nl;
  wire[0:0] mux_465_nl;
  wire[0:0] or_408_nl;
  wire[0:0] mux_464_nl;
  wire[0:0] mux_463_nl;
  wire[0:0] mux_462_nl;
  wire[0:0] mux_461_nl;
  wire[0:0] or_407_nl;
  wire[0:0] mux_458_nl;
  wire[0:0] mux_457_nl;
  wire[0:0] mux_455_nl;
  wire[0:0] mux_454_nl;
  wire[0:0] mux_475_nl;
  wire[0:0] nor_121_nl;
  wire[0:0] mux_15_nl;
  wire[1:0] COMP_LOOP_mux1h_nl;
  wire[0:0] COMP_LOOP_twiddle_f_nor_nl;
  wire[0:0] mux_493_nl;
  wire[0:0] mux_492_nl;
  wire[0:0] mux_491_nl;
  wire[0:0] mux_490_nl;
  wire[0:0] mux_488_nl;
  wire[0:0] mux_487_nl;
  wire[0:0] mux_486_nl;
  wire[0:0] mux_485_nl;
  wire[0:0] mux_484_nl;
  wire[0:0] mux_480_nl;
  wire[0:0] mux_479_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_57_nl;
  wire[0:0] mux_495_nl;
  wire[0:0] nor_119_nl;
  wire[0:0] mux_494_nl;
  wire[0:0] nor_120_nl;
  wire[0:0] and_254_nl;
  wire[0:0] and_161_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_111_nl;
  wire[0:0] mux_501_nl;
  wire[0:0] mux_500_nl;
  wire[0:0] nor_114_nl;
  wire[0:0] mux_499_nl;
  wire[0:0] mux_498_nl;
  wire[0:0] or_432_nl;
  wire[0:0] or_431_nl;
  wire[0:0] or_429_nl;
  wire[0:0] mux_497_nl;
  wire[0:0] nor_115_nl;
  wire[0:0] mux_496_nl;
  wire[0:0] nor_116_nl;
  wire[0:0] nor_117_nl;
  wire[0:0] nor_118_nl;
  wire[0:0] not_1027_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_128_nl;
  wire[0:0] mux_512_nl;
  wire[0:0] mux_511_nl;
  wire[0:0] mux_510_nl;
  wire[0:0] mux_509_nl;
  wire[0:0] or_446_nl;
  wire[0:0] mux_508_nl;
  wire[0:0] or_444_nl;
  wire[0:0] nand_8_nl;
  wire[0:0] mux_507_nl;
  wire[0:0] mux_505_nl;
  wire[0:0] or_441_nl;
  wire[0:0] mux_504_nl;
  wire[0:0] or_440_nl;
  wire[0:0] or_439_nl;
  wire[0:0] mux_503_nl;
  wire[0:0] or_438_nl;
  wire[0:0] mux_531_nl;
  wire[0:0] mux_530_nl;
  wire[0:0] mux_529_nl;
  wire[0:0] mux_528_nl;
  wire[0:0] mux_527_nl;
  wire[0:0] mux_526_nl;
  wire[0:0] mux_269_nl;
  wire[0:0] mux_268_nl;
  wire[0:0] and_260_nl;
  wire[0:0] mux_272_nl;
  wire[0:0] and_255_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_951_nl;
  wire[0:0] mux_950_nl;
  wire[0:0] mux_949_nl;
  wire[0:0] mux_948_nl;
  wire[0:0] mux_947_nl;
  wire[0:0] mux_nl;
  wire[0:0] mux_568_nl;
  wire[0:0] mux_567_nl;
  wire[0:0] mux_566_nl;
  wire[0:0] or_482_nl;
  wire[0:0] mux_565_nl;
  wire[9:0] COMP_LOOP_17_twiddle_f_mul_nl;
  wire[19:0] nl_COMP_LOOP_17_twiddle_f_mul_nl;
  wire[0:0] mux_584_nl;
  wire[0:0] mux_583_nl;
  wire[0:0] mux_582_nl;
  wire[0:0] mux_581_nl;
  wire[0:0] mux_576_nl;
  wire[0:0] or_488_nl;
  wire[8:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl;
  wire[8:0] COMP_LOOP_1_twiddle_f_mul_nl;
  wire[17:0] nl_COMP_LOOP_1_twiddle_f_mul_nl;
  wire[0:0] mux_954_nl;
  wire[0:0] mux_953_nl;
  wire[0:0] mux_952_nl;
  wire[0:0] nor_223_nl;
  wire[0:0] mux_956_nl;
  wire[0:0] mux_955_nl;
  wire[0:0] or_769_nl;
  wire[0:0] or_770_nl;
  wire[0:0] or_771_nl;
  wire[0:0] mux_599_nl;
  wire[0:0] mux_598_nl;
  wire[0:0] mux_597_nl;
  wire[0:0] and_235_nl;
  wire[0:0] mux_596_nl;
  wire[0:0] mux_657_nl;
  wire[0:0] mux_656_nl;
  wire[0:0] mux_655_nl;
  wire[0:0] mux_654_nl;
  wire[0:0] mux_653_nl;
  wire[0:0] or_518_nl;
  wire[0:0] or_517_nl;
  wire[0:0] mux_652_nl;
  wire[0:0] mux_651_nl;
  wire[0:0] mux_650_nl;
  wire[0:0] mux_649_nl;
  wire[0:0] mux_647_nl;
  wire[0:0] mux_646_nl;
  wire[0:0] mux_645_nl;
  wire[0:0] mux_644_nl;
  wire[0:0] mux_641_nl;
  wire[0:0] mux_640_nl;
  wire[0:0] mux_639_nl;
  wire[0:0] mux_636_nl;
  wire[0:0] mux_635_nl;
  wire[0:0] mux_634_nl;
  wire[0:0] mux_627_nl;
  wire[0:0] mux_626_nl;
  wire[0:0] mux_623_nl;
  wire[0:0] mux_622_nl;
  wire[0:0] or_513_nl;
  wire[31:0] VEC_LOOP_mux1h_12_nl;
  wire[0:0] and_197_nl;
  wire[0:0] mux_666_nl;
  wire[0:0] mux_665_nl;
  wire[0:0] mux_664_nl;
  wire[0:0] mux_663_nl;
  wire[0:0] or_526_nl;
  wire[0:0] nand_11_nl;
  wire[0:0] mux_662_nl;
  wire[0:0] or_127_nl;
  wire[0:0] mux_661_nl;
  wire[0:0] mux_660_nl;
  wire[0:0] mux_659_nl;
  wire[0:0] or_522_nl;
  wire[0:0] mux_658_nl;
  wire[0:0] or_519_nl;
  wire[0:0] COMP_LOOP_twiddle_f_nand_nl;
  wire[0:0] mux_973_nl;
  wire[0:0] mux_972_nl;
  wire[0:0] mux_971_nl;
  wire[0:0] mux_970_nl;
  wire[0:0] mux_969_nl;
  wire[0:0] nand_49_nl;
  wire[0:0] mux_968_nl;
  wire[0:0] or_740_nl;
  wire[0:0] mux_967_nl;
  wire[0:0] or_739_nl;
  wire[0:0] or_768_nl;
  wire[0:0] or_737_nl;
  wire[0:0] mux_966_nl;
  wire[0:0] mux_965_nl;
  wire[0:0] or_736_nl;
  wire[0:0] or_734_nl;
  wire[0:0] or_732_nl;
  wire[0:0] or_730_nl;
  wire[0:0] mux_964_nl;
  wire[0:0] mux_963_nl;
  wire[0:0] mux_962_nl;
  wire[0:0] mux_961_nl;
  wire[0:0] mux_960_nl;
  wire[0:0] mux_959_nl;
  wire[0:0] or_727_nl;
  wire[0:0] nand_47_nl;
  wire[0:0] mux_958_nl;
  wire[0:0] nor_220_nl;
  wire[0:0] and_970_nl;
  wire[0:0] VEC_LOOP_or_35_nl;
  wire[0:0] mux_746_nl;
  wire[0:0] mux_745_nl;
  wire[0:0] mux_744_nl;
  wire[0:0] mux_743_nl;
  wire[0:0] mux_742_nl;
  wire[0:0] mux_741_nl;
  wire[0:0] or_561_nl;
  wire[0:0] mux_740_nl;
  wire[0:0] mux_739_nl;
  wire[0:0] mux_738_nl;
  wire[0:0] mux_737_nl;
  wire[0:0] nor_87_nl;
  wire[0:0] mux_736_nl;
  wire[0:0] mux_734_nl;
  wire[0:0] mux_733_nl;
  wire[0:0] mux_732_nl;
  wire[0:0] mux_731_nl;
  wire[0:0] mux_730_nl;
  wire[0:0] mux_729_nl;
  wire[0:0] mux_728_nl;
  wire[0:0] mux_727_nl;
  wire[0:0] mux_726_nl;
  wire[0:0] mux_725_nl;
  wire[0:0] mux_723_nl;
  wire[0:0] mux_720_nl;
  wire[0:0] mux_717_nl;
  wire[0:0] mux_788_nl;
  wire[0:0] and_205_nl;
  wire[0:0] mux_791_nl;
  wire[0:0] mux_787_nl;
  wire[0:0] mux_786_nl;
  wire[13:0] VEC_LOOP_VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_not_nl;
  wire[0:0] mux_876_nl;
  wire[0:0] mux_875_nl;
  wire[0:0] mux_874_nl;
  wire[0:0] mux_873_nl;
  wire[0:0] mux_872_nl;
  wire[0:0] mux_879_nl;
  wire[0:0] mux_878_nl;
  wire[0:0] mux_588_nl;
  wire[0:0] or_637_nl;
  wire[0:0] or_635_nl;
  wire[0:0] mux_809_nl;
  wire[0:0] nor_94_nl;
  wire[0:0] mux_912_nl;
  wire[0:0] or_664_nl;
  wire[0:0] mux_911_nl;
  wire[0:0] or_663_nl;
  wire[0:0] or_662_nl;
  wire[0:0] and_219_nl;
  wire[0:0] mux_987_nl;
  wire[0:0] mux_986_nl;
  wire[0:0] mux_985_nl;
  wire[0:0] mux_984_nl;
  wire[0:0] mux_983_nl;
  wire[0:0] or_749_nl;
  wire[0:0] or_748_nl;
  wire[0:0] or_746_nl;
  wire[0:0] mux_982_nl;
  wire[0:0] mux_981_nl;
  wire[0:0] or_745_nl;
  wire[0:0] mux_998_nl;
  wire[0:0] mux_997_nl;
  wire[0:0] mux_996_nl;
  wire[0:0] mux_995_nl;
  wire[0:0] mux_994_nl;
  wire[0:0] or_760_nl;
  wire[0:0] or_757_nl;
  wire[0:0] or_756_nl;
  wire[0:0] mux_992_nl;
  wire[0:0] mux_991_nl;
  wire[0:0] or_755_nl;
  wire[0:0] VEC_LOOP_or_66_nl;
  wire[0:0] mux_886_nl;
  wire[0:0] mux_571_nl;
  wire[0:0] mux_585_nl;
  wire[0:0] mux_1008_nl;
  wire[0:0] mux_1007_nl;
  wire[0:0] mux_1006_nl;
  wire[0:0] mux_1005_nl;
  wire[0:0] mux_1004_nl;
  wire[0:0] or_766_nl;
  wire[0:0] mux_1003_nl;
  wire[0:0] or_764_nl;
  wire[0:0] mux_1002_nl;
  wire[0:0] mux_1001_nl;
  wire[0:0] mux_1000_nl;
  wire[0:0] mux_907_nl;
  wire[0:0] mux_906_nl;
  wire[0:0] mux_905_nl;
  wire[0:0] mux_904_nl;
  wire[0:0] and_217_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] mux_275_nl;
  wire[0:0] mux_280_nl;
  wire[0:0] mux_279_nl;
  wire[0:0] mux_285_nl;
  wire[0:0] or_303_nl;
  wire[0:0] mux_287_nl;
  wire[0:0] or_306_nl;
  wire[0:0] mux_292_nl;
  wire[0:0] mux_338_nl;
  wire[0:0] mux_334_nl;
  wire[0:0] mux_333_nl;
  wire[0:0] mux_332_nl;
  wire[0:0] or_329_nl;
  wire[0:0] mux_349_nl;
  wire[0:0] mux_348_nl;
  wire[0:0] mux_347_nl;
  wire[0:0] mux_346_nl;
  wire[0:0] mux_345_nl;
  wire[0:0] mux_344_nl;
  wire[0:0] mux_341_nl;
  wire[0:0] mux_355_nl;
  wire[0:0] mux_359_nl;
  wire[0:0] mux_388_nl;
  wire[0:0] mux_387_nl;
  wire[0:0] mux_386_nl;
  wire[0:0] mux_385_nl;
  wire[0:0] mux_404_nl;
  wire[0:0] mux_402_nl;
  wire[0:0] mux_410_nl;
  wire[0:0] mux_409_nl;
  wire[0:0] mux_408_nl;
  wire[0:0] mux_406_nl;
  wire[0:0] mux_401_nl;
  wire[0:0] mux_397_nl;
  wire[0:0] or_373_nl;
  wire[0:0] or_372_nl;
  wire[0:0] mux_445_nl;
  wire[0:0] mux_443_nl;
  wire[0:0] mux_456_nl;
  wire[0:0] or_404_nl;
  wire[0:0] or_403_nl;
  wire[0:0] nand_25_nl;
  wire[0:0] mux_513_nl;
  wire[0:0] mux_515_nl;
  wire[0:0] or_451_nl;
  wire[0:0] or_452_nl;
  wire[0:0] mux_522_nl;
  wire[0:0] mux_539_nl;
  wire[0:0] mux_538_nl;
  wire[0:0] mux_537_nl;
  wire[0:0] mux_536_nl;
  wire[0:0] mux_535_nl;
  wire[0:0] mux_563_nl;
  wire[0:0] mux_562_nl;
  wire[0:0] mux_573_nl;
  wire[0:0] mux_578_nl;
  wire[0:0] mux_577_nl;
  wire[0:0] or_490_nl;
  wire[0:0] or_489_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] mux_630_nl;
  wire[0:0] mux_629_nl;
  wire[0:0] mux_628_nl;
  wire[0:0] mux_632_nl;
  wire[0:0] mux_637_nl;
  wire[0:0] or_516_nl;
  wire[0:0] mux_642_nl;
  wire[0:0] mux_699_nl;
  wire[0:0] mux_698_nl;
  wire[0:0] or_539_nl;
  wire[0:0] mux_697_nl;
  wire[0:0] mux_696_nl;
  wire[0:0] and_221_nl;
  wire[0:0] mux_747_nl;
  wire[0:0] nor_100_nl;
  wire[0:0] nor_106_nl;
  wire[0:0] mux_752_nl;
  wire[0:0] mux_750_nl;
  wire[0:0] mux_763_nl;
  wire[0:0] mux_762_nl;
  wire[0:0] mux_761_nl;
  wire[0:0] mux_760_nl;
  wire[0:0] mux_758_nl;
  wire[0:0] mux_757_nl;
  wire[0:0] mux_756_nl;
  wire[0:0] mux_794_nl;
  wire[0:0] mux_792_nl;
  wire[0:0] or_599_nl;
  wire[0:0] mux_900_nl;
  wire[0:0] mux_824_nl;
  wire[0:0] mux_823_nl;
  wire[0:0] mux_822_nl;
  wire[0:0] mux_821_nl;
  wire[0:0] mux_820_nl;
  wire[0:0] mux_819_nl;
  wire[0:0] mux_818_nl;
  wire[0:0] mux_817_nl;
  wire[0:0] mux_816_nl;
  wire[0:0] or_608_nl;
  wire[0:0] mux_815_nl;
  wire[0:0] or_606_nl;
  wire[9:0] VEC_LOOP_mux1h_10_nl;
  wire[0:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] and_116_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_114_nl;
  wire[0:0] mux_384_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_110_nl;
  wire[0:0] mux_369_nl;
  wire[0:0] mux_368_nl;
  wire[0:0] mux_365_nl;
  wire[8:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_26_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] and_111_nl;
  wire[0:0] mux_381_nl;
  wire[0:0] mux_380_nl;
  wire[0:0] mux_379_nl;
  wire[0:0] mux_374_nl;
  wire[0:0] or_349_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] and_115_nl;
  wire[0:0] mux_390_nl;
  wire[0:0] or_694_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] and_117_nl;
  wire[0:0] mux_392_nl;
  wire[0:0] or_362_nl;
  wire[0:0] VEC_LOOP_mux1h_9_nl;
  wire[0:0] and_118_nl;
  wire[0:0] mux_394_nl;
  wire[0:0] mux_393_nl;
  wire[0:0] or_724_nl;
  wire[0:0] or_741_nl;
  wire[0:0] mux_977_nl;
  wire[0:0] or_744_nl;
  wire[0:0] mux_989_nl;
  wire[0:0] or_752_nl;
  wire[0:0] mux_988_nl;
  wire[0:0] nand_51_nl;
  wire[0:0] or_751_nl;
  wire[0:0] or_759_nl;
  wire[0:0] nand_52_nl;
  wire[13:0] COMP_LOOP_twiddle_f_mux_11_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl;
  wire[7:0] COMP_LOOP_twiddle_f_mux_12_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl;
  wire[1:0] COMP_LOOP_twiddle_f_or_40_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_5_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_41_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_42_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_11_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_12_nl;
  wire[1:0] COMP_LOOP_twiddle_f_mux_13_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_43_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_13_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_14_nl;
  wire[3:0] COMP_LOOP_twiddle_f_mux1h_296_nl;
  wire[0:0] and_977_nl;
  wire[0:0] and_978_nl;
  wire[0:0] and_979_nl;
  wire[0:0] and_980_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_15_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_16_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_17_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_18_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_19_nl;
  wire[0:0] and_981_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_20_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_21_nl;
  wire[15:0] acc_nl;
  wire[16:0] nl_acc_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[13:0] VEC_LOOP_VEC_LOOP_mux_14_nl;
  wire[0:0] VEC_LOOP_or_67_nl;
  wire[8:0] VEC_LOOP_VEC_LOOP_mux_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_18_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_19_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_20_nl;
  wire[15:0] acc_1_nl;
  wire[16:0] nl_acc_1_nl;
  wire[4:0] COMP_LOOP_mux1h_5_nl;
  wire[0:0] and_983_nl;
  wire[0:0] and_984_nl;
  wire[0:0] and_985_nl;
  wire[0:0] and_986_nl;
  wire[0:0] and_987_nl;
  wire[0:0] and_988_nl;
  wire[0:0] and_989_nl;
  wire[0:0] and_990_nl;
  wire[0:0] and_991_nl;
  wire[19:0] acc_2_nl;
  wire[20:0] nl_acc_2_nl;
  wire[17:0] VEC_LOOP_mux_5_nl;
  wire[0:0] VEC_LOOP_or_68_nl;
  wire[13:0] VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl;
  wire[3:0] STAGE_LOOP_mux_4_nl;
  wire[9:0] VEC_LOOP_mux1h_47_nl;
  wire[0:0] and_992_nl;
  wire[3:0] VEC_LOOP_VEC_LOOP_mux_16_nl;
  wire[13:0] VEC_LOOP_mux_6_nl;
  wire[0:0] VEC_LOOP_or_69_nl;
  wire[4:0] VEC_LOOP_mux1h_48_nl;
  wire[0:0] and_993_nl;
  wire[0:0] and_994_nl;
  wire[0:0] and_995_nl;
  wire[0:0] and_996_nl;
  wire[0:0] and_997_nl;
  wire[0:0] and_998_nl;
  wire[0:0] and_999_nl;
  wire[0:0] and_1000_nl;
  wire[0:0] and_1001_nl;
  wire[0:0] and_1002_nl;
  wire[0:0] and_1003_nl;
  wire[0:0] and_1004_nl;
  wire[3:0] VEC_LOOP_or_70_nl;
  wire[3:0] VEC_LOOP_nor_27_nl;
  wire[3:0] VEC_LOOP_mux1h_49_nl;
  wire[0:0] and_1005_nl;
  wire[0:0] and_1006_nl;
  wire[0:0] and_1007_nl;
  wire[0:0] and_1008_nl;
  wire[0:0] and_1009_nl;
  wire[0:0] and_1010_nl;
  wire[0:0] and_1011_nl;
  wire[0:0] and_1012_nl;
  wire[0:0] and_1013_nl;
  wire[0:0] and_1014_nl;
  wire[0:0] and_1015_nl;
  wire[0:0] and_1016_nl;
  wire[0:0] and_1017_nl;
  wire[0:0] and_1018_nl;
  wire[2:0] VEC_LOOP_or_71_nl;
  wire[2:0] VEC_LOOP_mux1h_50_nl;
  wire[0:0] and_1019_nl;
  wire[0:0] and_1020_nl;
  wire[0:0] and_1021_nl;
  wire[0:0] and_1022_nl;
  wire[12:0] acc_9_nl;
  wire[13:0] nl_acc_9_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_21_nl;
  wire[10:0] VEC_LOOP_mux1h_51_nl;
  wire[0:0] VEC_LOOP_or_72_nl;
  wire[0:0] VEC_LOOP_or_73_nl;
  wire[0:0] VEC_LOOP_or_74_nl;
  wire[0:0] VEC_LOOP_and_24_nl;
  wire[7:0] VEC_LOOP_mux1h_52_nl;
  wire[0:0] VEC_LOOP_or_75_nl;
  wire[0:0] VEC_LOOP_or_76_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_17_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_22_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_23_nl;
  wire[32:0] acc_10_nl;
  wire[33:0] nl_acc_10_nl;
  wire[31:0] VEC_LOOP_mux_7_nl;
  wire[0:0] VEC_LOOP_or_77_nl;
  wire[31:0] VEC_LOOP_mux_8_nl;
  wire[10:0] acc_11_nl;
  wire[11:0] nl_acc_11_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_24_nl;
  wire[8:0] VEC_LOOP_mux1h_53_nl;
  wire[0:0] VEC_LOOP_or_78_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_2_nl;
  wire[8:0] VEC_LOOP_VEC_LOOP_mux_18_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_3_nl;
  wire[8:0] VEC_LOOP_VEC_LOOP_mux_19_nl;
  wire[9:0] VEC_LOOP_mux1h_54_nl;
  wire[13:0] acc_13_nl;
  wire[14:0] nl_acc_13_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_25_nl;
  wire[11:0] VEC_LOOP_VEC_LOOP_mux_20_nl;
  wire[0:0] VEC_LOOP_or_79_nl;
  wire[0:0] VEC_LOOP_and_28_nl;
  wire[7:0] VEC_LOOP_VEC_LOOP_mux_21_nl;
  wire[0:0] VEC_LOOP_or_80_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_26_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_27_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_28_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = z_out_21;
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat = factor1_1_sva + COMP_LOOP_1_mult_cmp_return_rsc_z;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat = p_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_x_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_x_rsc_dat = VEC_LOOP_mult_vec_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat = MUX_v_32_2_2(COMP_LOOP_twiddle_f_1_sva,
      COMP_LOOP_twiddle_f_17_sva, and_dcpl_170);
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1 = MUX_v_32_2_2(COMP_LOOP_twiddle_help_1_sva,
      COMP_LOOP_twiddle_help_17_sva, and_dcpl_170);
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_p_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_p_rsc_dat = p_sva;
  wire[0:0] mux_554_nl;
  wire[0:0] mux_553_nl;
  wire[0:0] mux_552_nl;
  wire [0:0] nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat;
  assign mux_552_nl = MUX_s_1_2_2(mux_551_cse, mux_318_cse, fsm_output[5]);
  assign mux_553_nl = MUX_s_1_2_2(mux_319_cse, mux_552_nl, fsm_output[3]);
  assign mux_554_nl = MUX_s_1_2_2(mux_553_nl, mux_320_cse, fsm_output[1]);
  assign nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat = (~ mux_554_nl) & (fsm_output[0]);
  wire[0:0] and_294_nl;
  wire [3:0] nl_COMP_LOOP_17_twiddle_f_lshift_rg_s;
  assign and_294_nl = (fsm_output==9'b000000010);
  assign nl_COMP_LOOP_17_twiddle_f_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva,
      z_out_14, and_294_nl);
  wire[0:0] COMP_LOOP_twiddle_f_or_1_nl;
  wire [3:0] nl_COMP_LOOP_1_twiddle_f_lshift_rg_s;
  assign COMP_LOOP_twiddle_f_or_1_nl = (nor_175_cse & (fsm_output[5:0]==6'b010111))
      | (nor_175_cse & (fsm_output[5:0]==6'b100001));
  assign nl_COMP_LOOP_1_twiddle_f_lshift_rg_s = MUX_v_4_2_2(z_out_14, COMP_LOOP_1_twiddle_f_acc_cse_sva,
      COMP_LOOP_twiddle_f_or_1_nl);
  wire[31:0] VEC_LOOP_mux1h_11_nl;
  wire[0:0] and_119_nl;
  wire[0:0] nor_160_nl;
  wire[0:0] mux_418_nl;
  wire[0:0] mux_417_nl;
  wire[0:0] or_380_nl;
  wire[0:0] mux_416_nl;
  wire[0:0] or_379_nl;
  wire[0:0] mux_415_nl;
  wire[0:0] or_378_nl;
  wire[0:0] mux_414_nl;
  wire[0:0] or_377_nl;
  wire[0:0] or_375_nl;
  wire[0:0] mux_413_nl;
  wire[0:0] nor_156_nl;
  wire[0:0] mux_431_nl;
  wire[0:0] mux_430_nl;
  wire[0:0] mux_429_nl;
  wire [63:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign and_119_nl = (~ mux_411_itm) & (fsm_output[0]);
  assign or_379_nl = (~ (fsm_output[2])) | (fsm_output[8]) | (fsm_output[4]);
  assign mux_416_nl = MUX_s_1_2_2(or_379_nl, mux_tmp_412, fsm_output[6]);
  assign or_380_nl = (fsm_output[5]) | mux_416_nl;
  assign mux_417_nl = MUX_s_1_2_2(or_tmp_210, or_380_nl, fsm_output[3]);
  assign or_377_nl = (~ (fsm_output[2])) | (fsm_output[8]) | (~ (fsm_output[4]));
  assign mux_413_nl = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[8]);
  assign or_375_nl = (fsm_output[2]) | mux_413_nl;
  assign mux_414_nl = MUX_s_1_2_2(or_377_nl, or_375_nl, fsm_output[6]);
  assign or_378_nl = (fsm_output[5]) | mux_414_nl;
  assign mux_415_nl = MUX_s_1_2_2(or_378_nl, or_tmp_210, fsm_output[3]);
  assign mux_418_nl = MUX_s_1_2_2(mux_417_nl, mux_415_nl, fsm_output[1]);
  assign nor_160_nl = ~(mux_418_nl | (fsm_output[7]) | (fsm_output[0]));
  assign mux_429_nl = MUX_s_1_2_2(mux_428_cse, mux_tmp_425, fsm_output[2]);
  assign mux_430_nl = MUX_s_1_2_2(mux_789_cse, mux_429_nl, fsm_output[3]);
  assign mux_431_nl = MUX_s_1_2_2(mux_430_nl, mux_427_cse, fsm_output[1]);
  assign nor_156_nl = ~(mux_431_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_11_nl = MUX1HOT_v_32_3_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      COMP_LOOP_twiddle_f_17_sva, VEC_LOOP_mult_vec_1_sva, {and_119_nl , nor_160_nl
      , nor_156_nl});
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux1h_11_nl};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (~ mux_452_itm)};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_14_rmff , and_14_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (~ mux_452_itm)};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_306_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro = ~ mux_411_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2 = ~ mux_532_itm;
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_128_rmff , and_123_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_128_rmff , and_123_rmff};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0
      = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_24[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_20[11]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ (z_out_24[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (z_out_20[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0 = ~ (z_out_24[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0 = ~ z_out_12_14;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0 = ~ (z_out_20[11]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0 = ~ (z_out_24[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0 = ~ (z_out_11[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0 = ~ (z_out_22[9]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0 = ~ (z_out_13_18_14[0]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = STAGE_LOOP_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd14),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  modulo_sub  COMP_LOOP_1_modulo_sub_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nor_179_cse),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nor_179_cse),
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
  .width_z(32'sd13)) COMP_LOOP_3_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
      .z(COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd14)) COMP_LOOP_2_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
      .z(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd15)) COMP_LOOP_17_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_17_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd12)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_1_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out_1)
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
      .vec_rsci_oswt_1_pff(and_14_rmff)
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
      .twiddle_rsci_oswt_1_pff(and_128_rmff),
      .twiddle_rsci_oswt_pff(and_123_rmff)
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
      .twiddle_h_rsci_oswt_1_pff(and_128_rmff),
      .twiddle_h_rsci_oswt_pff(and_123_rmff)
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
      .COMP_LOOP_C_3_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0[0:0]),
      .COMP_LOOP_2_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_4_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0[0:0]),
      .COMP_LOOP_3_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_5_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0[0:0]),
      .COMP_LOOP_4_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_6_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_5_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_7_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0[0:0]),
      .COMP_LOOP_6_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_7_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_9_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0[0:0]),
      .COMP_LOOP_8_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_10_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0[0:0]),
      .COMP_LOOP_9_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_11_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0[0:0]),
      .COMP_LOOP_10_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_12_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0[0:0]),
      .COMP_LOOP_11_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_13_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0[0:0]),
      .COMP_LOOP_12_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_14_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0[0:0]),
      .COMP_LOOP_13_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_15_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0[0:0]),
      .COMP_LOOP_14_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_16_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0[0:0]),
      .COMP_LOOP_15_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_17_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0[0:0]),
      .COMP_LOOP_16_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_18_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0[0:0]),
      .COMP_LOOP_17_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_19_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0[0:0]),
      .COMP_LOOP_18_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_20_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0[0:0]),
      .COMP_LOOP_19_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_21_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0[0:0]),
      .COMP_LOOP_20_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_22_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0[0:0]),
      .COMP_LOOP_21_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_23_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0[0:0]),
      .COMP_LOOP_22_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_24_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0[0:0]),
      .COMP_LOOP_23_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_25_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0[0:0]),
      .COMP_LOOP_24_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_26_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0[0:0]),
      .COMP_LOOP_25_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_27_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0[0:0]),
      .COMP_LOOP_26_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_28_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0[0:0]),
      .COMP_LOOP_27_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_29_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0[0:0]),
      .COMP_LOOP_28_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_30_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0[0:0]),
      .COMP_LOOP_29_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_31_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0[0:0]),
      .COMP_LOOP_30_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_32_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0[0:0]),
      .COMP_LOOP_31_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_33_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0[0:0]),
      .COMP_LOOP_32_VEC_LOOP_C_8_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_C_34_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign nand_nl = ~((fsm_output[5]) & (~ mux_tmp_276));
  assign mux_301_nl = MUX_s_1_2_2(mux_tmp_284, or_tmp_134, fsm_output[5]);
  assign mux_302_nl = MUX_s_1_2_2(nand_nl, mux_301_nl, fsm_output[6]);
  assign mux_299_nl = MUX_s_1_2_2(or_tmp_134, mux_tmp_284, fsm_output[5]);
  assign or_307_nl = (fsm_output[5]) | mux_tmp_283;
  assign mux_300_nl = MUX_s_1_2_2(mux_299_nl, or_307_nl, fsm_output[6]);
  assign mux_303_nl = MUX_s_1_2_2(mux_302_nl, mux_300_nl, fsm_output[1]);
  assign mux_298_nl = MUX_s_1_2_2(mux_tmp_293, mux_tmp_281, fsm_output[1]);
  assign mux_304_nl = MUX_s_1_2_2(mux_303_nl, mux_298_nl, fsm_output[4]);
  assign mux_297_nl = MUX_s_1_2_2(mux_tmp_282, mux_tmp_294, fsm_output[4]);
  assign mux_305_nl = MUX_s_1_2_2(mux_304_nl, mux_297_nl, fsm_output[3]);
  assign mux_291_nl = MUX_s_1_2_2(mux_tmp_278, mux_tmp_288, fsm_output[1]);
  assign mux_295_nl = MUX_s_1_2_2(mux_tmp_294, mux_291_nl, fsm_output[4]);
  assign mux_289_nl = MUX_s_1_2_2(mux_tmp_288, mux_tmp_286, fsm_output[1]);
  assign mux_290_nl = MUX_s_1_2_2(mux_289_nl, mux_tmp_282, fsm_output[4]);
  assign mux_296_nl = MUX_s_1_2_2(mux_295_nl, mux_290_nl, fsm_output[3]);
  assign mux_306_itm = MUX_s_1_2_2(mux_305_nl, mux_296_nl, fsm_output[2]);
  assign mux_318_cse = MUX_s_1_2_2(mux_tmp_314, mux_tmp_308, fsm_output[2]);
  assign mux_319_cse = MUX_s_1_2_2(mux_318_cse, mux_tmp_312, fsm_output[5]);
  assign mux_315_nl = MUX_s_1_2_2(mux_tmp_310, mux_tmp_314, fsm_output[2]);
  assign mux_316_cse = MUX_s_1_2_2(mux_548_cse, mux_315_nl, fsm_output[5]);
  assign mux_320_cse = MUX_s_1_2_2(mux_549_cse, mux_319_cse, fsm_output[3]);
  assign mux_317_cse = MUX_s_1_2_2(mux_316_cse, mux_549_cse, fsm_output[3]);
  assign mux_321_nl = MUX_s_1_2_2(mux_320_cse, mux_317_cse, fsm_output[1]);
  assign and_14_rmff = (~ mux_321_nl) & (fsm_output[0]);
  assign mux_366_cse = MUX_s_1_2_2(or_445_cse, or_tmp_146, fsm_output[3]);
  assign nand_33_nl = ~((fsm_output[3]) & (fsm_output[7]) & (~ (fsm_output[8])) &
      (fsm_output[6]));
  assign mux_364_cse = MUX_s_1_2_2(nand_33_nl, mux_tmp_363, fsm_output[5]);
  assign mux_367_cse = MUX_s_1_2_2(mux_tmp_363, mux_366_cse, fsm_output[5]);
  assign or_356_nl = (~ (fsm_output[3])) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign mux_375_cse = MUX_s_1_2_2(or_tmp_164, or_356_nl, fsm_output[6]);
  assign nand_4_cse = ~((fsm_output[6]) & (~ mux_tmp_343));
  assign nand_3_cse = ~((fsm_output[6]) & (~ mux_tmp_339));
  assign or_358_cse = (fsm_output[6]) | mux_tmp_343;
  assign mux_372_cse = MUX_s_1_2_2(mux_tmp_342, or_tmp_161, fsm_output[4]);
  assign mux_377_cse = MUX_s_1_2_2(or_358_cse, mux_375_cse, fsm_output[4]);
  assign mux_373_cse = MUX_s_1_2_2(or_tmp_161, nand_3_cse, fsm_output[4]);
  assign mux_378_cse = MUX_s_1_2_2(nand_4_cse, mux_tmp_342, fsm_output[4]);
  assign mux_428_cse = MUX_s_1_2_2(or_tmp_225, mux_489_cse, fsm_output[4]);
  assign mux_424_nl = MUX_s_1_2_2(mux_tmp_351, or_420_cse, fsm_output[4]);
  assign mux_426_cse = MUX_s_1_2_2(mux_tmp_425, mux_424_nl, fsm_output[2]);
  assign mux_427_cse = MUX_s_1_2_2(mux_426_cse, mux_789_cse, fsm_output[3]);
  assign mux_448_nl = MUX_s_1_2_2(mux_375_cse, mux_tmp_342, fsm_output[4]);
  assign mux_449_nl = MUX_s_1_2_2(mux_tmp_434, mux_448_nl, fsm_output[5]);
  assign mux_450_nl = MUX_s_1_2_2(mux_449_nl, mux_tmp_441, fsm_output[2]);
  assign mux_451_nl = MUX_s_1_2_2(mux_450_nl, mux_tmp_446, fsm_output[1]);
  assign mux_437_nl = MUX_s_1_2_2(mux_372_cse, mux_tmp_434, fsm_output[5]);
  assign mux_442_nl = MUX_s_1_2_2(mux_tmp_441, mux_437_nl, fsm_output[2]);
  assign mux_447_nl = MUX_s_1_2_2(mux_tmp_446, mux_442_nl, fsm_output[1]);
  assign mux_452_itm = MUX_s_1_2_2(mux_451_nl, mux_447_nl, fsm_output[0]);
  assign mux_470_nl = MUX_s_1_2_2(mux_tmp_460, or_tmp_237, fsm_output[4]);
  assign mux_471_nl = MUX_s_1_2_2(mux_tmp_459, mux_470_nl, fsm_output[3]);
  assign or_410_nl = (fsm_output[6:5]!=2'b01) | not_tmp_151;
  assign mux_467_nl = MUX_s_1_2_2(or_410_nl, or_tmp_238, fsm_output[7]);
  assign mux_468_nl = MUX_s_1_2_2(mux_467_nl, mux_tmp_453, fsm_output[4]);
  assign or_408_nl = COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm | (fsm_output[5])
      | (fsm_output[6]) | (fsm_output[8]);
  assign mux_465_nl = MUX_s_1_2_2(or_408_nl, or_tmp_236, fsm_output[7]);
  assign mux_466_nl = MUX_s_1_2_2(mux_465_nl, mux_tmp_460, fsm_output[4]);
  assign mux_469_nl = MUX_s_1_2_2(mux_468_nl, mux_466_nl, fsm_output[3]);
  assign mux_472_nl = MUX_s_1_2_2(mux_471_nl, mux_469_nl, fsm_output[2]);
  assign or_407_nl = (fsm_output[5]) | (fsm_output[6]) | (fsm_output[8]);
  assign mux_461_nl = MUX_s_1_2_2(or_407_nl, or_tmp_236, fsm_output[7]);
  assign mux_462_nl = MUX_s_1_2_2(mux_461_nl, mux_tmp_460, fsm_output[4]);
  assign mux_463_nl = MUX_s_1_2_2(mux_462_nl, mux_tmp_459, fsm_output[3]);
  assign mux_455_nl = MUX_s_1_2_2(or_tmp_238, or_tmp_236, fsm_output[7]);
  assign mux_457_nl = MUX_s_1_2_2(or_tmp_241, mux_455_nl, fsm_output[4]);
  assign mux_454_nl = MUX_s_1_2_2(or_tmp_237, mux_tmp_453, fsm_output[4]);
  assign mux_458_nl = MUX_s_1_2_2(mux_457_nl, mux_454_nl, fsm_output[3]);
  assign mux_464_nl = MUX_s_1_2_2(mux_463_nl, mux_458_nl, fsm_output[2]);
  assign mux_473_nl = MUX_s_1_2_2(mux_472_nl, mux_464_nl, fsm_output[1]);
  assign and_123_rmff = (~ mux_473_nl) & (fsm_output[0]);
  assign nor_121_nl = ~((fsm_output[4]) | (fsm_output[6]));
  assign mux_15_nl = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[4]);
  assign mux_475_nl = MUX_s_1_2_2(nor_121_nl, mux_15_nl, VEC_LOOP_j_10_14_0_sva_1[14]);
  assign and_128_rmff = mux_475_nl & and_dcpl_15 & (~ (fsm_output[5])) & (~ (fsm_output[3]))
      & (~ (fsm_output[2])) & and_265_cse;
  assign mux_489_cse = MUX_s_1_2_2(or_tmp_146, or_445_cse, fsm_output[5]);
  assign COMP_LOOP_or_cse = (and_dcpl_30 & and_dcpl_43) | (and_dcpl_38 & and_dcpl_21)
      | (and_dcpl_45 & and_dcpl_25) | (and_dcpl_81 & and_dcpl_13);
  assign COMP_LOOP_or_2_cse = (and_dcpl_38 & and_dcpl_47) | (and_dcpl_61 & and_dcpl_47)
      | (and_dcpl_75 & and_dcpl_43) | (and_dcpl_91 & and_dcpl_43);
  assign COMP_LOOP_or_1_cse = (and_dcpl_45 & and_dcpl_13) | and_dcpl_133 | (and_dcpl_66
      & and_dcpl_13) | (and_dcpl_71 & and_dcpl_36);
  assign COMP_LOOP_or_5_cse = and_dcpl_132 | (and_dcpl_78 & and_dcpl_47) | (and_dcpl_86
      & and_dcpl_40) | (and_dcpl_93 & and_dcpl_47);
  assign COMP_LOOP_or_4_cse = (and_dcpl_59 & and_dcpl_43) | (and_dcpl_68 & and_dcpl_28)
      | (and_dcpl_71 & and_dcpl_40) | (and_dcpl_96 & and_dcpl_13);
  assign COMP_LOOP_or_3_cse = (and_dcpl_61 & and_dcpl_21) | (and_dcpl_66 & and_dcpl_25)
      | (and_dcpl_83 & and_dcpl_28);
  assign COMP_LOOP_or_7_cse = (and_dcpl_78 & and_dcpl_21) | (and_dcpl_86 & and_dcpl_36)
      | (and_dcpl_93 & and_dcpl_21);
  assign COMP_LOOP_or_6_cse = (and_dcpl_49 & and_dcpl_28) | (and_dcpl_81 & and_dcpl_25);
  assign COMP_LOOP_mux1h_nl = MUX1HOT_v_2_9_2((z_out_2[3:2]), (z_out_4[4:3]), (z_out_5_11_0[2:1]),
      (z_out_7_12_0[3:2]), (z_out_9_10_0[1:0]), (z_out_6[4:3]), (z_out_3[4:3]), (z_out_10[4:3]),
      (z_out_8_12_0[3:2]), {and_dcpl_125 , COMP_LOOP_or_cse , COMP_LOOP_or_2_cse
      , COMP_LOOP_or_1_cse , COMP_LOOP_or_6_cse , COMP_LOOP_or_5_cse , COMP_LOOP_or_4_cse
      , COMP_LOOP_or_3_cse , COMP_LOOP_or_7_cse});
  assign mux_490_nl = MUX_s_1_2_2(mux_tmp_357, mux_489_cse, fsm_output[2]);
  assign mux_491_nl = MUX_s_1_2_2(mux_490_nl, mux_tmp_478, fsm_output[4]);
  assign mux_487_nl = MUX_s_1_2_2(or_tmp_254, mux_tmp_354, fsm_output[2]);
  assign mux_488_nl = MUX_s_1_2_2(mux_tmp_483, mux_487_nl, fsm_output[4]);
  assign mux_492_nl = MUX_s_1_2_2(mux_491_nl, mux_488_nl, fsm_output[3]);
  assign mux_484_nl = MUX_s_1_2_2(or_420_cse, mux_tmp_351, fsm_output[2]);
  assign mux_485_nl = MUX_s_1_2_2(mux_484_nl, mux_tmp_483, fsm_output[4]);
  assign mux_479_nl = MUX_s_1_2_2(mux_tmp_357, or_tmp_254, fsm_output[2]);
  assign mux_480_nl = MUX_s_1_2_2(mux_479_nl, mux_tmp_478, fsm_output[4]);
  assign mux_486_nl = MUX_s_1_2_2(mux_485_nl, mux_480_nl, fsm_output[3]);
  assign mux_493_nl = MUX_s_1_2_2(mux_492_nl, mux_486_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_nor_nl = ~(mux_493_nl | (~ (fsm_output[0])));
  assign COMP_LOOP_and_rmff = MUX_v_2_2_2(2'b00, COMP_LOOP_mux1h_nl, COMP_LOOP_twiddle_f_nor_nl);
  assign COMP_LOOP_twiddle_f_mux1h_57_nl = MUX1HOT_s_1_8_2((z_out_2[1]), (z_out_4[2]),
      (z_out_5_11_0[0]), (z_out_7_12_0[1]), (z_out_6[2]), (z_out_3[2]), (z_out_10[2]),
      (z_out_8_12_0[1]), {and_dcpl_125 , COMP_LOOP_or_cse , COMP_LOOP_or_2_cse ,
      COMP_LOOP_or_1_cse , COMP_LOOP_or_5_cse , COMP_LOOP_or_4_cse , COMP_LOOP_or_3_cse
      , COMP_LOOP_or_7_cse});
  assign nor_119_nl = ~((fsm_output[2]) | (~ (fsm_output[3])) | (fsm_output[4]) |
      (~ (fsm_output[6])) | (fsm_output[7]));
  assign nor_120_nl = ~((fsm_output[3]) | (fsm_output[4]) | (fsm_output[6]) | (fsm_output[7]));
  assign and_254_nl = (fsm_output[3]) & (fsm_output[4]) & (fsm_output[6]) & (fsm_output[7]);
  assign mux_494_nl = MUX_s_1_2_2(nor_120_nl, and_254_nl, fsm_output[2]);
  assign mux_495_nl = MUX_s_1_2_2(nor_119_nl, mux_494_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_57_rmff = COMP_LOOP_twiddle_f_mux1h_57_nl & (~(mux_495_nl
      & (~ (fsm_output[8])) & (~ (fsm_output[5])) & (fsm_output[0])));
  assign and_161_nl = and_dcpl_17 & and_dcpl_36;
  assign COMP_LOOP_twiddle_f_mux1h_87_rmff = MUX1HOT_v_9_10_2(COMP_LOOP_3_twiddle_f_lshift_ncse_sva_8_0,
      (z_out_2[12:4]), (z_out_4[13:5]), (z_out_5_11_0[11:3]), (z_out_7_12_0[12:4]),
      (z_out_9_10_0[10:2]), (z_out_6[13:5]), (z_out_3[13:5]), (z_out_10[13:5]), (z_out_8_12_0[12:4]),
      {and_161_nl , and_dcpl_125 , COMP_LOOP_or_cse , COMP_LOOP_or_2_cse , COMP_LOOP_or_1_cse
      , COMP_LOOP_or_6_cse , COMP_LOOP_or_5_cse , COMP_LOOP_or_4_cse , COMP_LOOP_or_3_cse
      , COMP_LOOP_or_7_cse});
  assign COMP_LOOP_twiddle_f_mux1h_111_nl = MUX1HOT_s_1_7_2((z_out_2[0]), (z_out_4[1]),
      (z_out_7_12_0[0]), (z_out_6[1]), (z_out_3[1]), (z_out_10[1]), (z_out_8_12_0[0]),
      {and_dcpl_125 , COMP_LOOP_or_cse , COMP_LOOP_or_1_cse , COMP_LOOP_or_5_cse
      , COMP_LOOP_or_4_cse , COMP_LOOP_or_3_cse , COMP_LOOP_or_7_cse});
  assign or_432_nl = (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[4]);
  assign or_431_nl = (~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign mux_498_nl = MUX_s_1_2_2(or_432_nl, or_431_nl, fsm_output[6]);
  assign or_429_nl = (fsm_output[7:4]!=4'b0100);
  assign mux_499_nl = MUX_s_1_2_2(mux_498_nl, or_429_nl, fsm_output[3]);
  assign nor_114_nl = ~((fsm_output[2]) | mux_499_nl);
  assign nor_115_nl = ~((fsm_output[7:3]!=5'b00000));
  assign nor_116_nl = ~((fsm_output[7:4]!=4'b1011));
  assign nor_117_nl = ~((fsm_output[7:4]!=4'b1101));
  assign mux_496_nl = MUX_s_1_2_2(nor_116_nl, nor_117_nl, fsm_output[3]);
  assign mux_497_nl = MUX_s_1_2_2(nor_115_nl, mux_496_nl, fsm_output[2]);
  assign mux_500_nl = MUX_s_1_2_2(nor_114_nl, mux_497_nl, fsm_output[1]);
  assign nor_118_nl = ~((fsm_output[7:1]!=7'b0000011));
  assign mux_501_nl = MUX_s_1_2_2(mux_500_nl, nor_118_nl, fsm_output[8]);
  assign COMP_LOOP_twiddle_f_mux1h_111_rmff = COMP_LOOP_twiddle_f_mux1h_111_nl &
      (~(mux_501_nl & (fsm_output[0])));
  assign not_1027_nl = ~ and_dcpl_132;
  assign COMP_LOOP_twiddle_help_mux_rmff = MUX_v_4_2_2(4'b0000, (z_out_2[3:0]), not_1027_nl);
  assign COMP_LOOP_twiddle_f_mux1h_128_nl = MUX1HOT_s_1_4_2((z_out_4[0]), (z_out_6[0]),
      (z_out_3[0]), (z_out_10[0]), {COMP_LOOP_or_cse , COMP_LOOP_or_5_cse , COMP_LOOP_or_4_cse
      , COMP_LOOP_or_3_cse});
  assign or_446_nl = (~ (fsm_output[1])) | (fsm_output[7]) | (fsm_output[8]) | (fsm_output[6]);
  assign mux_508_nl = MUX_s_1_2_2(or_tmp_146, or_445_cse, fsm_output[1]);
  assign mux_509_nl = MUX_s_1_2_2(or_446_nl, mux_508_nl, fsm_output[2]);
  assign or_444_nl = (fsm_output[2]) | mux_tmp_506;
  assign mux_510_nl = MUX_s_1_2_2(mux_509_nl, or_444_nl, fsm_output[5]);
  assign mux_507_nl = MUX_s_1_2_2(mux_tmp_502, mux_tmp_506, fsm_output[2]);
  assign nand_8_nl = ~((fsm_output[5]) & (~ mux_507_nl));
  assign mux_511_nl = MUX_s_1_2_2(mux_510_nl, nand_8_nl, fsm_output[4]);
  assign or_440_nl = (fsm_output[1]) | (fsm_output[7]) | (fsm_output[8]) | (fsm_output[6]);
  assign mux_504_nl = MUX_s_1_2_2(mux_tmp_502, or_440_nl, fsm_output[2]);
  assign or_441_nl = (fsm_output[5]) | mux_504_nl;
  assign or_438_nl = (~ (fsm_output[1])) | (fsm_output[7]) | (~ (fsm_output[8]))
      | (fsm_output[6]);
  assign mux_503_nl = MUX_s_1_2_2(or_438_nl, mux_tmp_502, fsm_output[2]);
  assign or_439_nl = (fsm_output[5]) | mux_503_nl;
  assign mux_505_nl = MUX_s_1_2_2(or_441_nl, or_439_nl, fsm_output[4]);
  assign mux_512_nl = MUX_s_1_2_2(mux_511_nl, mux_505_nl, fsm_output[3]);
  assign COMP_LOOP_twiddle_f_mux1h_128_rmff = COMP_LOOP_twiddle_f_mux1h_128_nl &
      (~((~ mux_512_nl) & (fsm_output[0])));
  assign COMP_LOOP_twiddle_help_mux_1_rmff = MUX_v_10_2_2((z_out_2[13:4]), COMP_LOOP_17_twiddle_f_mul_psp_sva,
      and_dcpl_132);
  assign nor_179_cse = ~(mux_411_itm | (fsm_output[0]));
  assign mux_529_nl = MUX_s_1_2_2(mux_tmp_525, mux_tmp_517, fsm_output[2]);
  assign mux_530_nl = MUX_s_1_2_2(mux_529_nl, mux_tmp_523, fsm_output[5]);
  assign mux_531_nl = MUX_s_1_2_2(mux_tmp_524, mux_530_nl, fsm_output[3]);
  assign mux_526_nl = MUX_s_1_2_2(mux_tmp_521, mux_tmp_525, fsm_output[2]);
  assign mux_527_nl = MUX_s_1_2_2(mux_tmp_518, mux_526_nl, fsm_output[5]);
  assign mux_528_nl = MUX_s_1_2_2(mux_527_nl, mux_tmp_524, fsm_output[3]);
  assign mux_532_itm = MUX_s_1_2_2(mux_531_nl, mux_528_nl, fsm_output[1]);
  assign mux_551_cse = MUX_s_1_2_2(mux_307_cse, mux_311_cse, fsm_output[2]);
  assign mux_548_cse = MUX_s_1_2_2(mux_tmp_308, mux_307_cse, fsm_output[2]);
  assign mux_549_cse = MUX_s_1_2_2(mux_tmp_312, mux_548_cse, fsm_output[5]);
  assign mux_268_nl = MUX_s_1_2_2(mux_267_cse, and_tmp_2, or_285_cse);
  assign and_260_nl = ((or_285_cse & (fsm_output[6])) | (fsm_output[7])) & (fsm_output[8]);
  assign mux_269_nl = MUX_s_1_2_2(mux_268_nl, and_260_nl, fsm_output[2]);
  assign mux_271_cse = MUX_s_1_2_2(mux_269_nl, nor_tmp_36, fsm_output[1]);
  assign and_257_cse = (fsm_output[2:1]==2'b11);
  assign or_714_cse = (fsm_output[5:2]!=4'b0000);
  assign and_973_cse = or_714_cse & (fsm_output[6]);
  assign or_483_cse = (fsm_output[4:2]!=3'b000);
  assign or_480_cse = (fsm_output[4:1]!=4'b0000);
  assign or_140_cse = (fsm_output[5:4]!=2'b00);
  assign and_242_cse = (fsm_output[4:3]==2'b11);
  assign and_237_cse_1 = (fsm_output[3:2]==2'b11);
  assign nl_COMP_LOOP_1_twiddle_f_mul_nl = (z_out_1[8:0]) * COMP_LOOP_k_14_5_sva_8_0;
  assign COMP_LOOP_1_twiddle_f_mul_nl = nl_COMP_LOOP_1_twiddle_f_mul_nl[8:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl = MUX_v_9_2_2(COMP_LOOP_1_twiddle_f_mul_nl,
      (z_out_22[8:0]), and_dcpl_18);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt = MUX_v_13_2_2(({4'b0000
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl}), COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1,
      and_dcpl_125);
  assign or_717_cse = (fsm_output[7:5]!=3'b000);
  assign or_499_cse = (fsm_output[4:3]!=2'b00);
  assign mux_654_nl = MUX_s_1_2_2(mux_tmp_648, mux_tmp_620, fsm_output[4]);
  assign or_518_nl = (fsm_output[4]) | (fsm_output[1]);
  assign mux_653_nl = MUX_s_1_2_2(mux_tmp_619, mux_tmp_620, or_518_nl);
  assign mux_655_nl = MUX_s_1_2_2(mux_654_nl, mux_653_nl, fsm_output[2]);
  assign or_517_nl = (fsm_output[3]) | (fsm_output[5]);
  assign mux_656_nl = MUX_s_1_2_2(mux_655_nl, mux_tmp_620, or_517_nl);
  assign mux_649_nl = MUX_s_1_2_2(mux_tmp_648, mux_tmp_625, fsm_output[4]);
  assign mux_647_nl = MUX_s_1_2_2(mux_tmp_638, mux_tmp_621, fsm_output[4]);
  assign mux_650_nl = MUX_s_1_2_2(mux_649_nl, mux_647_nl, fsm_output[2]);
  assign mux_645_nl = MUX_s_1_2_2(mux_tmp_643, mux_tmp_631, fsm_output[4]);
  assign mux_644_nl = MUX_s_1_2_2(mux_tmp_625, mux_tmp_643, fsm_output[4]);
  assign mux_646_nl = MUX_s_1_2_2(mux_645_nl, mux_644_nl, fsm_output[2]);
  assign mux_651_nl = MUX_s_1_2_2(mux_650_nl, mux_646_nl, fsm_output[5]);
  assign mux_639_nl = MUX_s_1_2_2(mux_tmp_631, mux_tmp_638, fsm_output[4]);
  assign mux_634_nl = MUX_s_1_2_2(mux_tmp_619, mux_tmp_620, COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm);
  assign mux_635_nl = MUX_s_1_2_2(mux_634_nl, mux_tmp_633, fsm_output[1]);
  assign mux_636_nl = MUX_s_1_2_2(mux_635_nl, mux_tmp_631, fsm_output[4]);
  assign mux_640_nl = MUX_s_1_2_2(mux_639_nl, mux_636_nl, fsm_output[2]);
  assign mux_626_nl = MUX_s_1_2_2(mux_tmp_621, mux_tmp_625, fsm_output[4]);
  assign or_513_nl = and_232_cse | (fsm_output[7]);
  assign mux_622_nl = MUX_s_1_2_2(nor_tmp_16, (fsm_output[8]), or_513_nl);
  assign mux_623_nl = MUX_s_1_2_2(mux_622_nl, mux_tmp_621, fsm_output[4]);
  assign mux_627_nl = MUX_s_1_2_2(mux_626_nl, mux_623_nl, fsm_output[2]);
  assign mux_641_nl = MUX_s_1_2_2(mux_640_nl, mux_627_nl, fsm_output[5]);
  assign mux_652_nl = MUX_s_1_2_2(mux_651_nl, mux_641_nl, fsm_output[3]);
  assign mux_657_nl = MUX_s_1_2_2(mux_656_nl, mux_652_nl, fsm_output[0]);
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & mux_657_nl;
  assign and_265_cse = (fsm_output[1:0]==2'b11);
  assign nor_125_cse = ~((fsm_output[1:0]!=2'b00));
  assign VEC_LOOP_or_36_cse = and_dcpl_79 | and_dcpl_82 | and_dcpl_85 | and_dcpl_100;
  assign or_558_cse = (fsm_output[8:7]!=2'b10);
  assign or_559_cse = (fsm_output[4:3]!=2'b01);
  assign mux_788_nl = MUX_s_1_2_2(or_tmp_218, mux_tmp_351, fsm_output[4]);
  assign mux_789_cse = MUX_s_1_2_2(mux_788_nl, mux_420_cse, fsm_output[2]);
  assign mux_874_nl = MUX_s_1_2_2(mux_366_cse, mux_361_cse, fsm_output[5]);
  assign mux_875_nl = MUX_s_1_2_2(mux_367_cse, mux_874_nl, fsm_output[1]);
  assign mux_876_nl = MUX_s_1_2_2(mux_797_cse, mux_875_nl, fsm_output[4]);
  assign mux_872_nl = MUX_s_1_2_2(mux_364_cse, mux_367_cse, fsm_output[1]);
  assign mux_873_nl = MUX_s_1_2_2(mux_872_nl, mux_797_cse, fsm_output[4]);
  assign mux_877_cse = MUX_s_1_2_2(mux_876_nl, mux_873_nl, fsm_output[2]);
  assign or_659_cse = (~ (fsm_output[8])) | (fsm_output[5]) | (fsm_output[7]);
  assign mux_908_cse = MUX_s_1_2_2(or_659_cse, or_tmp_426, fsm_output[6]);
  assign mux_809_nl = MUX_s_1_2_2(or_tmp_37, or_558_cse, fsm_output[5]);
  assign or_656_cse = (fsm_output[6]) | mux_809_nl;
  assign mux_910_cse = MUX_s_1_2_2(mux_tmp_808, mux_908_cse, fsm_output[4]);
  assign VEC_LOOP_or_37_cse = and_dcpl_31 | and_dcpl_50 | and_dcpl_60 | and_dcpl_69
      | and_dcpl_76 | and_dcpl_84 | and_dcpl_92 | and_dcpl_99;
  assign or_663_nl = (fsm_output[5]) | (~ (fsm_output[7]));
  assign or_662_nl = (~ (fsm_output[5])) | (fsm_output[7]);
  assign mux_911_nl = MUX_s_1_2_2(or_663_nl, or_662_nl, fsm_output[8]);
  assign or_664_nl = (fsm_output[6]) | mux_911_nl;
  assign mux_912_nl = MUX_s_1_2_2(or_664_nl, mux_tmp_808, fsm_output[4]);
  assign nor_94_nl = ~((fsm_output[3]) | and_265_cse | mux_912_nl);
  assign and_219_nl = (fsm_output[3]) & (~(nor_125_cse | mux_910_cse));
  assign mux_885_ssc = MUX_s_1_2_2(nor_94_nl, and_219_nl, fsm_output[2]);
  assign or_420_cse = (fsm_output[8:5]!=4'b0101);
  assign or_445_cse = (fsm_output[8:6]!=3'b100);
  assign nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_2_sva_mx0w1 = nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1[13:0];
  assign nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_3_sva_mx0w2 = nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2[13:0];
  assign nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_4_sva_mx0w3 = nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3[13:0];
  assign nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_5_sva_mx0w4 = nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4[13:0];
  assign nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_6_sva_mx0w5 = nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5[13:0];
  assign nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_7_sva_mx0w6 = nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6[13:0];
  assign nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_8_sva_mx0w7 = nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7[13:0];
  assign nl_VEC_LOOP_acc_10_cse_9_sva_mx0w8 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_9_sva_mx0w8 = nl_VEC_LOOP_acc_10_cse_9_sva_mx0w8[13:0];
  assign nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_10_sva_mx0w9 = nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9[13:0];
  assign nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_11_sva_mx0w10 = nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10[13:0];
  assign nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_12_sva_mx0w11 = nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11[13:0];
  assign nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_13_sva_mx0w12 = nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12[13:0];
  assign nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_14_sva_mx0w13 = nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13[13:0];
  assign nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_15_sva_mx0w14 = nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14[13:0];
  assign nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_16_sva_mx0w15 = nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15[13:0];
  assign nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_18_sva_mx0w17 = nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17[13:0];
  assign nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_19_sva_mx0w18 = nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18[13:0];
  assign nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_21_sva_mx0w20 = nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20[13:0];
  assign nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_23_sva_mx0w22 = nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22[13:0];
  assign nl_VEC_LOOP_acc_10_cse_25_sva_mx0w24 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_25_sva_mx0w24 = nl_VEC_LOOP_acc_10_cse_25_sva_mx0w24[13:0];
  assign nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_27_sva_mx0w26 = nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26[13:0];
  assign nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_29_sva_mx0w28 = nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28[13:0];
  assign nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_30_sva_mx0w29 = nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29[13:0];
  assign nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30 = z_out_16 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_31_sva_mx0w30 = nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30[13:0];
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ z_out_14)}) + 5'b01111;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign or_tmp_25 = (fsm_output[7:6]!=2'b00);
  assign and_tmp_2 = (fsm_output[8]) & or_tmp_25;
  assign nor_tmp_7 = (fsm_output[8:7]==2'b11);
  assign or_tmp_36 = (fsm_output[8:7]!=2'b00);
  assign or_tmp_37 = (fsm_output[8:7]!=2'b01);
  assign or_tmp_62 = (fsm_output[8]) | (fsm_output[6]);
  assign or_tmp_63 = (fsm_output[8]) | (~ (fsm_output[6]));
  assign nor_tmp_16 = (fsm_output[8]) & (fsm_output[6]);
  assign nor_tmp_36 = (and_973_cse | (fsm_output[7])) & (fsm_output[8]);
  assign or_285_cse = (fsm_output[5:3]!=3'b000);
  assign mux_266_cse = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[8]), fsm_output[7]);
  assign mux_267_cse = MUX_s_1_2_2(mux_266_cse, nor_tmp_7, fsm_output[6]);
  assign or_dcpl_161 = (fsm_output[8:6]!=3'b000);
  assign or_tmp_134 = (~ (fsm_output[0])) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign mux_tmp_274 = MUX_s_1_2_2(or_tmp_37, or_tmp_36, fsm_output[0]);
  assign mux_tmp_276 = MUX_s_1_2_2(or_tmp_36, or_tmp_37, fsm_output[0]);
  assign or_tmp_137 = (~ (fsm_output[0])) | (fsm_output[8]) | (fsm_output[7]);
  assign mux_tmp_277 = MUX_s_1_2_2(or_tmp_137, mux_tmp_276, fsm_output[5]);
  assign mux_275_nl = MUX_s_1_2_2(mux_tmp_274, or_tmp_134, fsm_output[5]);
  assign mux_tmp_278 = MUX_s_1_2_2(mux_tmp_277, mux_275_nl, fsm_output[6]);
  assign or_tmp_138 = (~ (fsm_output[0])) | (~ (fsm_output[8])) | (fsm_output[7]);
  assign mux_280_nl = MUX_s_1_2_2(or_tmp_138, or_tmp_137, fsm_output[5]);
  assign mux_279_nl = MUX_s_1_2_2(mux_tmp_276, mux_tmp_274, fsm_output[5]);
  assign mux_tmp_281 = MUX_s_1_2_2(mux_280_nl, mux_279_nl, fsm_output[6]);
  assign mux_tmp_282 = MUX_s_1_2_2(mux_tmp_281, mux_tmp_278, fsm_output[1]);
  assign mux_tmp_283 = MUX_s_1_2_2(or_558_cse, or_tmp_37, fsm_output[0]);
  assign mux_tmp_284 = MUX_s_1_2_2(or_tmp_37, (fsm_output[7]), fsm_output[0]);
  assign mux_285_nl = MUX_s_1_2_2(mux_tmp_284, mux_tmp_283, fsm_output[5]);
  assign or_303_nl = (~ (fsm_output[5])) | (~ (fsm_output[0])) | (fsm_output[8])
      | (fsm_output[7]);
  assign mux_tmp_286 = MUX_s_1_2_2(mux_285_nl, or_303_nl, fsm_output[6]);
  assign mux_287_nl = MUX_s_1_2_2(mux_tmp_276, mux_tmp_284, fsm_output[5]);
  assign or_306_nl = (fsm_output[5]) | (~ (fsm_output[0])) | (fsm_output[8]) | (~
      (fsm_output[7]));
  assign mux_tmp_288 = MUX_s_1_2_2(mux_287_nl, or_306_nl, fsm_output[6]);
  assign mux_292_nl = MUX_s_1_2_2(mux_tmp_283, or_tmp_138, fsm_output[5]);
  assign mux_tmp_293 = MUX_s_1_2_2(mux_292_nl, mux_tmp_277, fsm_output[6]);
  assign mux_tmp_294 = MUX_s_1_2_2(mux_tmp_286, mux_tmp_293, fsm_output[1]);
  assign or_tmp_145 = (fsm_output[8:6]!=3'b011);
  assign or_tmp_146 = (fsm_output[8:6]!=3'b010);
  assign mux_tmp_308 = MUX_s_1_2_2(or_tmp_145, or_445_cse, fsm_output[4]);
  assign mux_307_cse = MUX_s_1_2_2(or_tmp_146, or_tmp_145, fsm_output[4]);
  assign or_tmp_149 = (fsm_output[8:6]!=3'b001);
  assign mux_tmp_310 = MUX_s_1_2_2(or_dcpl_161, or_tmp_149, fsm_output[4]);
  assign mux_311_cse = MUX_s_1_2_2(or_tmp_149, or_tmp_146, fsm_output[4]);
  assign mux_tmp_312 = MUX_s_1_2_2(mux_311_cse, mux_tmp_310, fsm_output[2]);
  assign mux_tmp_314 = MUX_s_1_2_2(or_445_cse, or_dcpl_161, fsm_output[4]);
  assign and_dcpl_11 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_12 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_13 = and_dcpl_12 & and_dcpl_11;
  assign and_dcpl_14 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_15 = ~((fsm_output[8:7]!=2'b00));
  assign and_dcpl_16 = and_dcpl_15 & (~ (fsm_output[6]));
  assign and_dcpl_17 = and_dcpl_16 & and_dcpl_14;
  assign and_dcpl_18 = and_dcpl_17 & and_dcpl_13;
  assign and_dcpl_20 = (fsm_output[3:2]==2'b10);
  assign and_dcpl_21 = and_dcpl_20 & and_265_cse;
  assign or_322_cse = (fsm_output[8:6]!=3'b101);
  assign mux_331_cse = MUX_s_1_2_2(or_322_cse, or_tmp_149, fsm_output[4]);
  assign mux_332_nl = MUX_s_1_2_2(mux_331_cse, mux_tmp_314, fsm_output[2]);
  assign mux_333_nl = MUX_s_1_2_2(mux_332_nl, mux_551_cse, fsm_output[5]);
  assign mux_334_nl = MUX_s_1_2_2(mux_333_nl, mux_316_cse, fsm_output[3]);
  assign mux_338_nl = MUX_s_1_2_2(mux_317_cse, mux_334_nl, fsm_output[1]);
  assign and_dcpl_23 = ~(mux_338_nl | (fsm_output[0]));
  assign and_dcpl_25 = and_237_cse_1 & and_265_cse;
  assign and_dcpl_26 = and_dcpl_17 & and_dcpl_25;
  assign mux_tmp_339 = MUX_s_1_2_2(or_tmp_37, or_tmp_36, fsm_output[3]);
  assign or_tmp_161 = (fsm_output[6]) | mux_tmp_339;
  assign or_tmp_164 = (fsm_output[3]) | (fsm_output[8]) | (fsm_output[7]);
  assign or_329_nl = (~ (fsm_output[3])) | (~ (fsm_output[8])) | (fsm_output[7]);
  assign mux_tmp_342 = MUX_s_1_2_2(or_329_nl, or_tmp_164, fsm_output[6]);
  assign mux_tmp_343 = MUX_s_1_2_2(or_558_cse, or_tmp_37, fsm_output[3]);
  assign mux_347_nl = MUX_s_1_2_2(nand_4_cse, or_tmp_161, fsm_output[5]);
  assign mux_346_nl = MUX_s_1_2_2(mux_tmp_342, nand_3_cse, fsm_output[5]);
  assign mux_348_nl = MUX_s_1_2_2(mux_347_nl, mux_346_nl, fsm_output[4]);
  assign mux_344_nl = MUX_s_1_2_2(or_358_cse, mux_tmp_342, fsm_output[5]);
  assign mux_341_nl = MUX_s_1_2_2(mux_375_cse, or_tmp_161, fsm_output[5]);
  assign mux_345_nl = MUX_s_1_2_2(mux_344_nl, mux_341_nl, fsm_output[4]);
  assign mux_349_nl = MUX_s_1_2_2(mux_348_nl, mux_345_nl, fsm_output[2]);
  assign and_dcpl_27 = (~ mux_349_nl) & and_dcpl_11;
  assign and_dcpl_28 = and_dcpl_20 & and_dcpl_11;
  assign and_dcpl_29 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_30 = and_dcpl_16 & and_dcpl_29;
  assign and_dcpl_31 = and_dcpl_30 & and_dcpl_28;
  assign mux_tmp_351 = MUX_s_1_2_2(or_445_cse, or_tmp_149, fsm_output[5]);
  assign mux_350_cse = MUX_s_1_2_2(or_dcpl_161, or_tmp_146, fsm_output[5]);
  assign mux_tmp_352 = MUX_s_1_2_2(mux_tmp_351, mux_350_cse, fsm_output[4]);
  assign mux_tmp_354 = MUX_s_1_2_2(or_tmp_149, or_tmp_145, fsm_output[5]);
  assign mux_355_nl = MUX_s_1_2_2(mux_tmp_354, mux_489_cse, fsm_output[4]);
  assign mux_tmp_356 = MUX_s_1_2_2(mux_355_nl, mux_tmp_352, fsm_output[3]);
  assign and_dcpl_34 = (~ mux_tmp_356) & (fsm_output[2:0]==3'b111);
  assign and_dcpl_35 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_36 = and_dcpl_35 & and_265_cse;
  assign and_dcpl_37 = (fsm_output[5:4]==2'b10);
  assign and_dcpl_38 = and_dcpl_16 & and_dcpl_37;
  assign and_dcpl_39 = and_dcpl_38 & and_dcpl_36;
  assign and_dcpl_40 = and_237_cse_1 & and_dcpl_11;
  assign and_dcpl_41 = and_dcpl_38 & and_dcpl_40;
  assign mux_tmp_357 = MUX_s_1_2_2(or_tmp_145, or_dcpl_161, fsm_output[5]);
  assign mux_tmp_358 = MUX_s_1_2_2(mux_489_cse, mux_tmp_357, fsm_output[4]);
  assign and_dcpl_42 = (~ mux_tmp_358) & and_dcpl_36;
  assign and_dcpl_43 = and_dcpl_12 & and_265_cse;
  assign and_dcpl_44 = (fsm_output[5:4]==2'b11);
  assign and_dcpl_45 = and_dcpl_16 & and_dcpl_44;
  assign and_dcpl_46 = and_dcpl_45 & and_dcpl_43;
  assign and_dcpl_47 = and_dcpl_35 & and_dcpl_11;
  assign and_dcpl_48 = and_dcpl_15 & (fsm_output[6]);
  assign and_dcpl_49 = and_dcpl_48 & and_dcpl_14;
  assign and_dcpl_50 = and_dcpl_49 & and_dcpl_47;
  assign and_dcpl_51 = and_dcpl_49 & and_dcpl_21;
  assign and_dcpl_52 = and_dcpl_48 & and_dcpl_29;
  assign and_dcpl_53 = and_dcpl_52 & and_dcpl_13;
  assign and_dcpl_57 = xor_dcpl & (~ (fsm_output[8])) & (fsm_output[6]) & (fsm_output[4])
      & and_dcpl_21;
  assign and_dcpl_58 = and_dcpl_52 & and_dcpl_25;
  assign and_dcpl_59 = and_dcpl_48 & and_dcpl_37;
  assign and_dcpl_60 = and_dcpl_59 & and_dcpl_28;
  assign and_dcpl_61 = and_dcpl_48 & and_dcpl_44;
  assign and_dcpl_62 = and_dcpl_61 & and_dcpl_36;
  assign and_dcpl_63 = and_dcpl_61 & and_dcpl_40;
  assign and_dcpl_64 = (fsm_output[8:7]==2'b01);
  assign and_dcpl_65 = and_dcpl_64 & (~ (fsm_output[6]));
  assign and_dcpl_66 = and_dcpl_65 & and_dcpl_14;
  assign and_dcpl_67 = and_dcpl_66 & and_dcpl_43;
  assign and_dcpl_68 = and_dcpl_65 & and_dcpl_29;
  assign and_dcpl_69 = and_dcpl_68 & and_dcpl_47;
  assign and_dcpl_70 = and_dcpl_68 & and_dcpl_21;
  assign and_dcpl_71 = and_dcpl_65 & and_dcpl_37;
  assign and_dcpl_72 = and_dcpl_71 & and_dcpl_13;
  assign and_dcpl_73 = and_dcpl_71 & and_dcpl_21;
  assign and_dcpl_74 = and_dcpl_71 & and_dcpl_25;
  assign and_dcpl_75 = and_dcpl_65 & and_dcpl_44;
  assign and_dcpl_76 = and_dcpl_75 & and_dcpl_28;
  assign and_dcpl_77 = and_dcpl_64 & (fsm_output[6]);
  assign and_dcpl_78 = and_dcpl_77 & and_dcpl_14;
  assign and_dcpl_79 = and_dcpl_78 & and_dcpl_36;
  assign and_dcpl_80 = and_dcpl_78 & and_dcpl_40;
  assign and_dcpl_81 = and_dcpl_77 & and_dcpl_29;
  assign and_dcpl_82 = and_dcpl_81 & and_dcpl_43;
  assign and_dcpl_83 = and_dcpl_77 & and_dcpl_37;
  assign and_dcpl_84 = and_dcpl_83 & and_dcpl_47;
  assign and_dcpl_85 = and_dcpl_83 & and_dcpl_21;
  assign and_dcpl_86 = and_dcpl_77 & and_dcpl_44;
  assign and_dcpl_87 = and_dcpl_86 & and_dcpl_13;
  assign and_dcpl_88 = and_dcpl_86 & and_dcpl_25;
  assign and_dcpl_89 = (fsm_output[8:7]==2'b10);
  assign and_dcpl_90 = and_dcpl_89 & (~ (fsm_output[6]));
  assign and_dcpl_91 = and_dcpl_90 & and_dcpl_14;
  assign and_dcpl_92 = and_dcpl_91 & and_dcpl_28;
  assign and_dcpl_93 = and_dcpl_90 & and_dcpl_29;
  assign and_dcpl_94 = and_dcpl_93 & and_dcpl_36;
  assign and_dcpl_95 = and_dcpl_93 & and_dcpl_40;
  assign and_dcpl_96 = and_dcpl_90 & and_dcpl_37;
  assign and_dcpl_97 = and_dcpl_96 & and_dcpl_43;
  assign and_dcpl_98 = and_dcpl_90 & and_dcpl_44;
  assign and_dcpl_99 = and_dcpl_98 & and_dcpl_47;
  assign and_dcpl_100 = and_dcpl_98 & and_dcpl_21;
  assign and_dcpl_102 = ~((fsm_output[6:5]!=2'b00));
  assign or_tmp_173 = (fsm_output[3:2]!=2'b10);
  assign or_tmp_174 = (fsm_output[3:2]!=2'b01);
  assign mux_359_nl = MUX_s_1_2_2(or_tmp_174, or_tmp_173, fsm_output[1]);
  assign and_dcpl_105 = (~ mux_359_nl) & and_dcpl_15 & and_dcpl_102 & (~ (fsm_output[4]))
      & (fsm_output[0]);
  assign mux_360_cse = MUX_s_1_2_2(or_tmp_145, or_tmp_149, fsm_output[3]);
  assign mux_361_cse = MUX_s_1_2_2(or_tmp_149, or_445_cse, fsm_output[3]);
  assign mux_tmp_362 = MUX_s_1_2_2(mux_361_cse, mux_360_cse, fsm_output[5]);
  assign mux_tmp_363 = MUX_s_1_2_2(or_tmp_146, or_dcpl_161, fsm_output[3]);
  assign mux_tmp_382 = MUX_s_1_2_2(mux_tmp_357, mux_tmp_351, fsm_output[4]);
  assign mux_tmp_383 = MUX_s_1_2_2(or_420_cse, mux_tmp_354, fsm_output[4]);
  assign mux_386_nl = MUX_s_1_2_2(or_322_cse, or_tmp_146, fsm_output[5]);
  assign mux_387_nl = MUX_s_1_2_2(mux_386_nl, mux_tmp_354, fsm_output[4]);
  assign mux_388_nl = MUX_s_1_2_2(mux_387_nl, mux_tmp_382, fsm_output[3]);
  assign mux_385_nl = MUX_s_1_2_2(mux_tmp_352, mux_tmp_358, fsm_output[3]);
  assign mux_tmp_389 = MUX_s_1_2_2(mux_388_nl, mux_385_nl, fsm_output[2]);
  assign mux_tmp_391 = MUX_s_1_2_2(mux_tmp_358, mux_tmp_383, fsm_output[3]);
  assign mux_tmp_400 = MUX_s_1_2_2(mux_tmp_314, mux_307_cse, fsm_output[3]);
  assign mux_404_nl = MUX_s_1_2_2(mux_307_cse, mux_tmp_310, fsm_output[3]);
  assign mux_402_nl = MUX_s_1_2_2(mux_311_cse, mux_tmp_314, fsm_output[3]);
  assign mux_tmp_405 = MUX_s_1_2_2(mux_404_nl, mux_402_nl, fsm_output[2]);
  assign mux_408_nl = MUX_s_1_2_2(mux_331_cse, mux_tmp_308, fsm_output[3]);
  assign mux_409_nl = MUX_s_1_2_2(mux_408_nl, mux_tmp_400, fsm_output[2]);
  assign mux_410_nl = MUX_s_1_2_2(mux_409_nl, mux_tmp_405, fsm_output[5]);
  assign mux_397_nl = MUX_s_1_2_2(mux_tmp_308, mux_311_cse, fsm_output[3]);
  assign mux_401_nl = MUX_s_1_2_2(mux_tmp_400, mux_397_nl, fsm_output[2]);
  assign mux_406_nl = MUX_s_1_2_2(mux_tmp_405, mux_401_nl, fsm_output[5]);
  assign mux_411_itm = MUX_s_1_2_2(mux_410_nl, mux_406_nl, fsm_output[1]);
  assign or_373_nl = (fsm_output[8]) | (fsm_output[4]);
  assign or_372_nl = (fsm_output[8]) | (~ (fsm_output[4]));
  assign mux_tmp_412 = MUX_s_1_2_2(or_373_nl, or_372_nl, fsm_output[2]);
  assign or_tmp_210 = (fsm_output[6:5]!=2'b01) | mux_tmp_412;
  assign or_tmp_218 = (fsm_output[8:5]!=4'b0110);
  assign mux_420_cse = MUX_s_1_2_2(mux_489_cse, or_tmp_218, fsm_output[4]);
  assign or_tmp_225 = ~((fsm_output[8:5]==4'b0111));
  assign mux_tmp_425 = MUX_s_1_2_2(or_420_cse, or_tmp_225, fsm_output[4]);
  assign mux_tmp_434 = MUX_s_1_2_2(nand_3_cse, or_358_cse, fsm_output[4]);
  assign mux_tmp_441 = MUX_s_1_2_2(mux_373_cse, mux_377_cse, fsm_output[5]);
  assign mux_445_nl = MUX_s_1_2_2(mux_378_cse, mux_373_cse, fsm_output[5]);
  assign mux_443_nl = MUX_s_1_2_2(mux_377_cse, mux_372_cse, fsm_output[5]);
  assign mux_tmp_446 = MUX_s_1_2_2(mux_445_nl, mux_443_nl, fsm_output[2]);
  assign or_tmp_235 = (fsm_output[6:5]!=2'b10) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[8]);
  assign or_tmp_236 = (fsm_output[6:5]!=2'b01) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[8]);
  assign mux_tmp_453 = MUX_s_1_2_2(or_tmp_236, or_tmp_235, fsm_output[7]);
  assign or_tmp_237 = (fsm_output[7:5]!=3'b100) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[8]);
  assign or_tmp_238 = (fsm_output[6:5]!=2'b00) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[8]);
  assign not_tmp_151 = ~((VEC_LOOP_j_10_14_0_sva_1[14]) & (fsm_output[8]));
  assign or_404_nl = (fsm_output[6]) | not_tmp_151;
  assign or_403_nl = (~ (fsm_output[6])) | (~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (fsm_output[8]);
  assign mux_456_nl = MUX_s_1_2_2(or_404_nl, or_403_nl, fsm_output[5]);
  assign or_tmp_241 = (fsm_output[7]) | mux_456_nl;
  assign mux_tmp_459 = MUX_s_1_2_2(mux_tmp_453, or_tmp_241, fsm_output[4]);
  assign nand_25_nl = ~((fsm_output[6:5]==2'b11) & (VEC_LOOP_j_10_14_0_sva_1[14])
      & (~ (fsm_output[8])));
  assign mux_tmp_460 = MUX_s_1_2_2(or_tmp_235, nand_25_nl, fsm_output[7]);
  assign mux_tmp_478 = MUX_s_1_2_2(mux_tmp_351, mux_tmp_357, fsm_output[2]);
  assign or_tmp_254 = (fsm_output[8:5]!=4'b0100);
  assign mux_tmp_483 = MUX_s_1_2_2(mux_tmp_354, mux_350_cse, fsm_output[2]);
  assign and_dcpl_125 = and_dcpl_17 & and_dcpl_40;
  assign and_dcpl_132 = and_dcpl_52 & and_dcpl_36;
  assign and_dcpl_133 = and_dcpl_52 & and_dcpl_40;
  assign mux_tmp_502 = MUX_s_1_2_2(or_tmp_149, or_tmp_145, fsm_output[1]);
  assign mux_tmp_506 = MUX_s_1_2_2(or_dcpl_161, or_tmp_146, fsm_output[1]);
  assign and_dcpl_164 = and_dcpl_89 & (fsm_output[6]) & and_dcpl_14;
  assign and_dcpl_166 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_168 = and_dcpl_164 & and_dcpl_12 & and_dcpl_166;
  assign not_tmp_164 = ~((fsm_output[0]) & (fsm_output[6]));
  assign mux_513_nl = MUX_s_1_2_2(not_tmp_164, (fsm_output[6]), fsm_output[8]);
  assign or_tmp_282 = (fsm_output[7]) | mux_513_nl;
  assign or_tmp_284 = (fsm_output[8]) | (~ (fsm_output[0])) | (fsm_output[6]);
  assign mux_tmp_514 = MUX_s_1_2_2(or_tmp_284, or_tmp_63, fsm_output[7]);
  assign mux_tmp_516 = MUX_s_1_2_2(or_tmp_62, or_tmp_284, fsm_output[7]);
  assign mux_tmp_517 = MUX_s_1_2_2(or_tmp_282, mux_tmp_516, fsm_output[4]);
  assign mux_515_nl = MUX_s_1_2_2(mux_tmp_514, or_tmp_282, fsm_output[4]);
  assign mux_tmp_518 = MUX_s_1_2_2(mux_tmp_517, mux_515_nl, fsm_output[2]);
  assign or_451_nl = (~ (fsm_output[8])) | (~ (fsm_output[0])) | (fsm_output[6]);
  assign mux_tmp_519 = MUX_s_1_2_2(or_451_nl, or_tmp_62, fsm_output[7]);
  assign or_452_nl = (fsm_output[8]) | not_tmp_164;
  assign mux_tmp_520 = MUX_s_1_2_2(or_tmp_63, or_452_nl, fsm_output[7]);
  assign mux_tmp_521 = MUX_s_1_2_2(mux_tmp_520, mux_tmp_519, fsm_output[4]);
  assign mux_522_nl = MUX_s_1_2_2(mux_tmp_519, mux_tmp_514, fsm_output[4]);
  assign mux_tmp_523 = MUX_s_1_2_2(mux_522_nl, mux_tmp_521, fsm_output[2]);
  assign mux_tmp_524 = MUX_s_1_2_2(mux_tmp_523, mux_tmp_518, fsm_output[5]);
  assign mux_tmp_525 = MUX_s_1_2_2(mux_tmp_516, mux_tmp_520, fsm_output[4]);
  assign or_tmp_289 = (fsm_output[8:5]!=4'b1000);
  assign mux_tmp_533 = MUX_s_1_2_2(or_tmp_218, or_tmp_289, fsm_output[4]);
  assign or_tmp_293 = (fsm_output[8:5]!=4'b1001);
  assign mux_537_nl = MUX_s_1_2_2(or_tmp_225, or_tmp_293, fsm_output[4]);
  assign mux_536_nl = MUX_s_1_2_2(or_tmp_289, or_420_cse, fsm_output[4]);
  assign mux_538_nl = MUX_s_1_2_2(mux_537_nl, mux_536_nl, fsm_output[3]);
  assign mux_535_nl = MUX_s_1_2_2(mux_tmp_425, mux_tmp_533, fsm_output[3]);
  assign mux_539_nl = MUX_s_1_2_2(mux_538_nl, mux_535_nl, fsm_output[2]);
  assign and_dcpl_170 = (~ mux_539_nl) & and_265_cse;
  assign mux_562_nl = MUX_s_1_2_2(mux_267_cse, and_tmp_2, or_714_cse);
  assign mux_563_nl = MUX_s_1_2_2(mux_562_nl, nor_tmp_36, fsm_output[1]);
  assign mux_tmp_564 = MUX_s_1_2_2(mux_271_cse, mux_563_nl, fsm_output[0]);
  assign and_dcpl_176 = and_dcpl_12 & nor_125_cse;
  assign and_dcpl_181 = ~((fsm_output[7:6]!=2'b00));
  assign mux_tmp_570 = MUX_s_1_2_2((~ (fsm_output[3])), (fsm_output[3]), fsm_output[2]);
  assign or_tmp_316 = (or_140_cse & (fsm_output[6])) | (fsm_output[7]);
  assign mux_573_nl = MUX_s_1_2_2((fsm_output[7]), (fsm_output[6]), fsm_output[5]);
  assign mux_tmp_574 = MUX_s_1_2_2(mux_573_nl, or_tmp_25, fsm_output[4]);
  assign mux_tmp_575 = MUX_s_1_2_2(mux_tmp_574, or_tmp_316, fsm_output[3]);
  assign or_490_nl = (fsm_output[7:6]!=2'b01);
  assign mux_577_nl = MUX_s_1_2_2(or_490_nl, or_tmp_25, fsm_output[5]);
  assign or_489_nl = ((fsm_output[6:5]==2'b11)) | (fsm_output[7]);
  assign mux_578_nl = MUX_s_1_2_2(mux_577_nl, or_489_nl, fsm_output[4]);
  assign mux_tmp_579 = MUX_s_1_2_2(mux_578_nl, mux_tmp_574, fsm_output[3]);
  assign mux_tmp_580 = MUX_s_1_2_2(mux_tmp_579, or_tmp_316, fsm_output[2]);
  assign nor_tmp_66 = or_717_cse & (fsm_output[8]);
  assign mux_594_cse = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[8]), or_tmp_25);
  assign mux_tmp_595 = MUX_s_1_2_2(mux_594_cse, and_tmp_2, fsm_output[5]);
  assign and_dcpl_190 = and_dcpl_17 & and_237_cse_1 & (~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm)
      & and_dcpl_11;
  assign mux_136_nl = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[8]);
  assign mux_tmp_619 = MUX_s_1_2_2(mux_136_nl, (fsm_output[8]), fsm_output[7]);
  assign mux_tmp_620 = MUX_s_1_2_2(nor_tmp_16, (fsm_output[8]), fsm_output[7]);
  assign and_232_cse = (fsm_output[1]) & (VEC_LOOP_j_10_14_0_sva_1[14]);
  assign mux_tmp_621 = MUX_s_1_2_2(mux_tmp_620, mux_tmp_619, and_232_cse);
  assign mux_tmp_624 = MUX_s_1_2_2((fsm_output[6]), (fsm_output[8]), fsm_output[7]);
  assign mux_tmp_625 = MUX_s_1_2_2(mux_tmp_620, mux_tmp_624, and_232_cse);
  assign mux_630_nl = MUX_s_1_2_2(mux_tmp_620, mux_tmp_624, VEC_LOOP_j_10_14_0_sva_1[14]);
  assign mux_628_nl = MUX_s_1_2_2(nor_tmp_16, or_tmp_62, fsm_output[7]);
  assign mux_629_nl = MUX_s_1_2_2(mux_tmp_620, mux_628_nl, VEC_LOOP_j_10_14_0_sva_1[14]);
  assign mux_tmp_631 = MUX_s_1_2_2(mux_630_nl, mux_629_nl, fsm_output[1]);
  assign mux_632_nl = MUX_s_1_2_2(nor_tmp_16, or_tmp_63, fsm_output[7]);
  assign mux_tmp_633 = MUX_s_1_2_2(mux_tmp_620, mux_632_nl, VEC_LOOP_j_10_14_0_sva_1[14]);
  assign or_516_nl = (VEC_LOOP_j_10_14_0_sva_1[14]) | (fsm_output[7]);
  assign mux_637_nl = MUX_s_1_2_2(nor_tmp_16, (fsm_output[8]), or_516_nl);
  assign mux_tmp_638 = MUX_s_1_2_2(mux_tmp_633, mux_637_nl, fsm_output[1]);
  assign mux_642_nl = MUX_s_1_2_2(mux_tmp_620, mux_tmp_619, VEC_LOOP_j_10_14_0_sva_1[14]);
  assign mux_tmp_643 = MUX_s_1_2_2(mux_642_nl, mux_tmp_633, fsm_output[1]);
  assign mux_tmp_648 = MUX_s_1_2_2((~ or_tmp_62), (fsm_output[8]), fsm_output[7]);
  assign or_tmp_351 = (~ (fsm_output[3])) | (fsm_output[6]) | (fsm_output[5]);
  assign or_tmp_352 = (fsm_output[3]) | (~ (fsm_output[6])) | (fsm_output[5]);
  assign or_tmp_354 = (fsm_output[6:5]!=2'b01);
  assign or_539_nl = (fsm_output[8:4]!=5'b01110);
  assign mux_698_nl = MUX_s_1_2_2(mux_tmp_533, or_539_nl, fsm_output[3]);
  assign mux_696_nl = MUX_s_1_2_2(or_tmp_293, or_tmp_218, fsm_output[4]);
  assign mux_697_nl = MUX_s_1_2_2(mux_696_nl, mux_tmp_425, fsm_output[3]);
  assign mux_699_nl = MUX_s_1_2_2(mux_698_nl, mux_697_nl, fsm_output[2]);
  assign and_dcpl_195 = (~ mux_699_nl) & and_dcpl_11 & (VEC_LOOP_j_10_14_0_sva_1[14]);
  assign or_tmp_380 = and_dcpl_181 | (fsm_output[8]);
  assign mux_tmp_719 = MUX_s_1_2_2(mux_266_cse, or_tmp_37, fsm_output[6]);
  assign mux_tmp_721 = MUX_s_1_2_2(nor_tmp_7, or_tmp_37, fsm_output[6]);
  assign mux_tmp_722 = MUX_s_1_2_2(mux_tmp_721, mux_tmp_719, fsm_output[4]);
  assign mux_tmp_724 = MUX_s_1_2_2(mux_tmp_721, mux_tmp_719, or_559_cse);
  assign and_221_nl = (fsm_output[4:2]==3'b111);
  assign mux_tmp_735 = MUX_s_1_2_2(mux_594_cse, or_tmp_380, and_221_nl);
  assign or_tmp_387 = (fsm_output[6]) | mux_266_cse;
  assign nor_100_nl = ~((fsm_output[2]) | (~ (fsm_output[4])));
  assign nor_106_nl = ~((~ (fsm_output[2])) | (fsm_output[4]));
  assign mux_747_nl = MUX_s_1_2_2(nor_100_nl, nor_106_nl, fsm_output[1]);
  assign and_dcpl_199 = mux_747_nl & and_dcpl_15 & and_dcpl_102 & (~ (fsm_output[3]))
      & (~ (fsm_output[0]));
  assign mux_752_nl = MUX_s_1_2_2(mux_tmp_351, mux_489_cse, fsm_output[3]);
  assign mux_750_nl = MUX_s_1_2_2(mux_tmp_354, mux_tmp_351, fsm_output[3]);
  assign mux_tmp_753 = MUX_s_1_2_2(mux_752_nl, mux_750_nl, fsm_output[1]);
  assign mux_tmp_755 = MUX_s_1_2_2(or_420_cse, mux_tmp_357, fsm_output[3]);
  assign mux_760_nl = MUX_s_1_2_2(mux_489_cse, mux_350_cse, fsm_output[3]);
  assign mux_761_nl = MUX_s_1_2_2(mux_tmp_755, mux_760_nl, fsm_output[1]);
  assign mux_762_nl = MUX_s_1_2_2(mux_tmp_753, mux_761_nl, fsm_output[4]);
  assign mux_756_nl = MUX_s_1_2_2(mux_tmp_357, mux_tmp_354, fsm_output[3]);
  assign mux_757_nl = MUX_s_1_2_2(mux_756_nl, mux_tmp_755, fsm_output[1]);
  assign mux_758_nl = MUX_s_1_2_2(mux_757_nl, mux_tmp_753, fsm_output[4]);
  assign mux_763_nl = MUX_s_1_2_2(mux_762_nl, mux_758_nl, fsm_output[2]);
  assign and_dcpl_200 = ~(mux_763_nl | (fsm_output[0]));
  assign mux_792_nl = MUX_s_1_2_2(or_dcpl_161, or_tmp_145, fsm_output[3]);
  assign mux_794_nl = MUX_s_1_2_2(mux_360_cse, mux_792_nl, fsm_output[5]);
  assign mux_797_cse = MUX_s_1_2_2(mux_tmp_362, mux_794_nl, fsm_output[1]);
  assign or_tmp_426 = (~ (fsm_output[5])) | (fsm_output[8]) | (fsm_output[7]);
  assign or_599_nl = (fsm_output[5]) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign mux_tmp_808 = MUX_s_1_2_2(or_tmp_426, or_599_nl, fsm_output[6]);
  assign mux_900_nl = MUX_s_1_2_2(or_656_cse, mux_tmp_808, fsm_output[4]);
  assign mux_tmp_813 = MUX_s_1_2_2(mux_910_cse, mux_900_nl, fsm_output[2]);
  assign mux_tmp_814 = MUX_s_1_2_2(or_tmp_36, or_tmp_37, fsm_output[5]);
  assign nand_tmp_12 = ~((fsm_output[6]) & (~ mux_tmp_814));
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_164 & and_dcpl_13;
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c0 = ~(mux_877_cse | (fsm_output[0]));
  assign mux_821_nl = MUX_s_1_2_2(nand_tmp_12, or_656_cse, fsm_output[4]);
  assign mux_820_nl = MUX_s_1_2_2(or_420_cse, nand_tmp_12, fsm_output[4]);
  assign mux_822_nl = MUX_s_1_2_2(mux_821_nl, mux_820_nl, fsm_output[2]);
  assign mux_823_nl = MUX_s_1_2_2(mux_tmp_813, mux_822_nl, fsm_output[3]);
  assign or_608_nl = (~ (fsm_output[5])) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign mux_816_nl = MUX_s_1_2_2(or_608_nl, or_659_cse, fsm_output[6]);
  assign mux_817_nl = MUX_s_1_2_2(mux_816_nl, nand_tmp_12, fsm_output[4]);
  assign or_606_nl = (fsm_output[6]) | mux_tmp_814;
  assign mux_815_nl = MUX_s_1_2_2(mux_908_cse, or_606_nl, fsm_output[4]);
  assign mux_818_nl = MUX_s_1_2_2(mux_817_nl, mux_815_nl, fsm_output[2]);
  assign mux_819_nl = MUX_s_1_2_2(mux_818_nl, mux_tmp_813, fsm_output[3]);
  assign mux_824_nl = MUX_s_1_2_2(mux_823_nl, mux_819_nl, fsm_output[1]);
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c2 = (~ mux_824_nl) & (fsm_output[0]);
  assign xor_dcpl = ~((fsm_output[7]) ^ (fsm_output[5]));
  assign VEC_LOOP_or_12_cse = and_dcpl_39 | and_dcpl_46 | and_dcpl_51 | and_dcpl_58
      | and_dcpl_62 | and_dcpl_67 | and_dcpl_70 | and_dcpl_74 | and_dcpl_79 | and_dcpl_82
      | and_dcpl_85 | and_dcpl_88 | and_dcpl_94 | and_dcpl_97 | and_dcpl_100;
  assign VEC_LOOP_or_13_cse = and_dcpl_41 | and_dcpl_63 | and_dcpl_80 | and_dcpl_95;
  assign VEC_LOOP_or_38_cse = and_dcpl_53 | and_dcpl_87;
  assign VEC_LOOP_or_23_cse = and_dcpl_72 | and_dcpl_88 | and_dcpl_94;
  assign VEC_LOOP_mux1h_10_nl = MUX1HOT_v_10_7_2((z_out_15[13:4]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[13:4]),
      (z_out_24[12:3]), (z_out_17[13:4]), (z_out_20[11:2]), (z_out_20[10:1]), z_out_22,
      {and_dcpl_18 , and_dcpl_26 , VEC_LOOP_or_37_cse , VEC_LOOP_or_12_cse , VEC_LOOP_or_13_cse
      , VEC_LOOP_or_38_cse , and_dcpl_72});
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_s_1_7_2((z_out_15[3]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[3]),
      (z_out_24[2]), (z_out_17[3]), (z_out_20[1]), (z_out_20[0]), (VEC_LOOP_acc_1_cse_10_sva[3]),
      {and_dcpl_18 , and_dcpl_26 , VEC_LOOP_or_37_cse , VEC_LOOP_or_12_cse , VEC_LOOP_or_13_cse
      , VEC_LOOP_or_38_cse , and_dcpl_72});
  assign and_116_nl = (~ mux_tmp_383) & and_dcpl_13;
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_6_2((z_out_15[2]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[2]),
      (z_out_24[1]), (z_out_17[2]), (z_out_20[0]), (VEC_LOOP_acc_1_cse_10_sva[2]),
      {and_dcpl_18 , and_dcpl_26 , VEC_LOOP_or_37_cse , VEC_LOOP_or_12_cse , VEC_LOOP_or_13_cse
      , and_116_nl});
  assign mux_384_nl = MUX_s_1_2_2(mux_tmp_383, mux_tmp_382, fsm_output[3]);
  assign and_114_nl = (~ mux_384_nl) & (fsm_output[2:0]==3'b101);
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_5_2((z_out_15[1]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[1]),
      (z_out_24[0]), (z_out_17[1]), (VEC_LOOP_acc_1_cse_10_sva[1]), {and_dcpl_18
      , and_dcpl_26 , VEC_LOOP_or_37_cse , VEC_LOOP_or_12_cse , and_114_nl});
  assign mux_368_nl = MUX_s_1_2_2(mux_tmp_362, mux_367_cse, fsm_output[4]);
  assign mux_365_nl = MUX_s_1_2_2(mux_364_cse, mux_tmp_362, fsm_output[4]);
  assign mux_369_nl = MUX_s_1_2_2(mux_368_nl, mux_365_nl, fsm_output[2]);
  assign and_110_nl = (~ mux_369_nl) & and_dcpl_11;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_4_2((z_out_15[0]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[0]),
      (VEC_LOOP_acc_1_cse_10_sva[0]), (z_out_17[0]), {and_dcpl_18 , and_dcpl_26 ,
      and_110_nl , VEC_LOOP_or_12_cse});
  assign and_26_nl = and_dcpl_17 & and_dcpl_21;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_9_34_2((z_out_22[8:0]), COMP_LOOP_3_twiddle_f_lshift_ncse_sva_8_0,
      (VEC_LOOP_acc_10_cse_1_sva[13:5]), (z_out_17[13:5]), (VEC_LOOP_acc_1_cse_10_sva[13:5]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[13:5]), ({VEC_LOOP_acc_11_psp_sva_12 , VEC_LOOP_acc_11_psp_sva_11
      , (VEC_LOOP_acc_11_psp_sva_10_0[10:4])}), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[13:5]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[13:5]), ({VEC_LOOP_acc_11_psp_sva_11 , (VEC_LOOP_acc_11_psp_sva_10_0[10:3])}),
      (VEC_LOOP_acc_10_cse_6_sva_mx0w5[13:5]), (VEC_LOOP_acc_10_cse_7_sva_mx0w6[13:5]),
      (VEC_LOOP_acc_10_cse_8_sva_mx0w7[13:5]), (VEC_LOOP_acc_10_cse_9_sva_mx0w8[13:5]),
      (VEC_LOOP_acc_11_psp_sva_10_0[10:2]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[13:5]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[13:5]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[13:5]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[13:5]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[13:5]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[13:5]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[13:5]),
      (z_out_15[13:5]), (COMP_LOOP_17_twiddle_f_mul_psp_sva[9:1]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[13:5]),
      (VEC_LOOP_acc_10_cse_19_sva_mx0w18[13:5]), (z_out_18[13:5]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[13:5]),
      (VEC_LOOP_acc_10_cse_23_sva_mx0w22[13:5]), (VEC_LOOP_acc_10_cse_25_sva_mx0w24[13:5]),
      (VEC_LOOP_acc_10_cse_27_sva_mx0w26[13:5]), (VEC_LOOP_acc_10_cse_29_sva_mx0w28[13:5]),
      (VEC_LOOP_acc_10_cse_30_sva_mx0w29[13:5]), (VEC_LOOP_acc_10_cse_31_sva_mx0w30[13:5]),
      {and_dcpl_18 , and_26_nl , and_dcpl_23 , and_dcpl_26 , and_dcpl_27 , and_dcpl_31
      , and_dcpl_34 , and_dcpl_39 , and_dcpl_41 , and_dcpl_42 , and_dcpl_46 , and_dcpl_50
      , and_dcpl_51 , and_dcpl_53 , and_dcpl_57 , and_dcpl_58 , and_dcpl_60 , and_dcpl_62
      , and_dcpl_63 , and_dcpl_67 , and_dcpl_69 , and_dcpl_70 , VEC_LOOP_or_23_cse
      , and_dcpl_73 , and_dcpl_74 , and_dcpl_76 , VEC_LOOP_or_36_cse , and_dcpl_80
      , and_dcpl_84 , and_dcpl_87 , and_dcpl_92 , and_dcpl_95 , and_dcpl_97 , and_dcpl_99});
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_33_2((COMP_LOOP_twiddle_f_17_sva[4]),
      (VEC_LOOP_acc_10_cse_1_sva[4]), (z_out_17[4]), (VEC_LOOP_acc_1_cse_10_sva[4]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[4]), (VEC_LOOP_acc_11_psp_sva_10_0[3]), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[4]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[4]), (VEC_LOOP_acc_11_psp_sva_10_0[2]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[4]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[4]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[4]),
      (VEC_LOOP_acc_10_cse_9_sva_mx0w8[4]), (VEC_LOOP_acc_11_psp_sva_10_0[1]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[4]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[4]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[4]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[4]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[4]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[4]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[4]),
      (z_out_15[4]), (COMP_LOOP_17_twiddle_f_mul_psp_sva[0]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[4]),
      (VEC_LOOP_acc_10_cse_19_sva_mx0w18[4]), (z_out_18[4]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[4]),
      (VEC_LOOP_acc_10_cse_23_sva_mx0w22[4]), (VEC_LOOP_acc_10_cse_25_sva_mx0w24[4]),
      (VEC_LOOP_acc_10_cse_27_sva_mx0w26[4]), (VEC_LOOP_acc_10_cse_29_sva_mx0w28[4]),
      (VEC_LOOP_acc_10_cse_30_sva_mx0w29[4]), (VEC_LOOP_acc_10_cse_31_sva_mx0w30[4]),
      {and_dcpl_105 , and_dcpl_23 , and_dcpl_26 , and_dcpl_27 , and_dcpl_31 , and_dcpl_34
      , and_dcpl_39 , and_dcpl_41 , and_dcpl_42 , and_dcpl_46 , and_dcpl_50 , and_dcpl_51
      , and_dcpl_53 , and_dcpl_57 , and_dcpl_58 , and_dcpl_60 , and_dcpl_62 , and_dcpl_63
      , and_dcpl_67 , and_dcpl_69 , and_dcpl_70 , VEC_LOOP_or_23_cse , and_dcpl_73
      , and_dcpl_74 , and_dcpl_76 , VEC_LOOP_or_36_cse , and_dcpl_80 , and_dcpl_84
      , and_dcpl_87 , and_dcpl_92 , and_dcpl_95 , and_dcpl_97 , and_dcpl_99});
  assign mux_379_nl = MUX_s_1_2_2(mux_378_cse, mux_377_cse, fsm_output[2]);
  assign mux_374_nl = MUX_s_1_2_2(mux_373_cse, mux_372_cse, fsm_output[2]);
  assign mux_380_nl = MUX_s_1_2_2(mux_379_nl, mux_374_nl, fsm_output[5]);
  assign or_349_nl = (fsm_output[8:2]!=7'b0101010);
  assign mux_381_nl = MUX_s_1_2_2(mux_380_nl, or_349_nl, fsm_output[1]);
  assign and_111_nl = (~ mux_381_nl) & (fsm_output[0]);
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_32_2((COMP_LOOP_twiddle_f_17_sva[3]),
      (VEC_LOOP_acc_10_cse_1_sva[3]), (z_out_17[3]), (VEC_LOOP_acc_1_cse_10_sva[3]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[3]), (VEC_LOOP_acc_11_psp_sva_10_0[2]), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[3]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[3]), (VEC_LOOP_acc_11_psp_sva_10_0[1]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[3]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[3]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[3]),
      (VEC_LOOP_acc_10_cse_9_sva_mx0w8[3]), (VEC_LOOP_acc_11_psp_sva_10_0[0]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[3]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[3]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[3]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[3]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[3]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[3]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[3]),
      (z_out_15[3]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[3]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[3]),
      (z_out_18[3]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[3]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[3]),
      (VEC_LOOP_acc_10_cse_25_sva_mx0w24[3]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[3]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[3]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[3]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[3]), {and_dcpl_105 , and_dcpl_23 , and_dcpl_26
      , and_111_nl , and_dcpl_31 , and_dcpl_34 , and_dcpl_39 , and_dcpl_41 , and_dcpl_42
      , and_dcpl_46 , and_dcpl_50 , and_dcpl_51 , and_dcpl_53 , and_dcpl_57 , and_dcpl_58
      , and_dcpl_60 , and_dcpl_62 , and_dcpl_63 , and_dcpl_67 , and_dcpl_69 , and_dcpl_70
      , VEC_LOOP_or_23_cse , and_dcpl_74 , and_dcpl_76 , VEC_LOOP_or_36_cse , and_dcpl_80
      , and_dcpl_84 , and_dcpl_87 , and_dcpl_92 , and_dcpl_95 , and_dcpl_97 , and_dcpl_99});
  assign or_694_nl = (fsm_output[3:2]!=2'b10) | mux_tmp_383;
  assign mux_390_nl = MUX_s_1_2_2(mux_tmp_389, or_694_nl, fsm_output[1]);
  assign and_115_nl = (~ mux_390_nl) & (fsm_output[0]);
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_31_2((COMP_LOOP_twiddle_f_17_sva[2]),
      (VEC_LOOP_acc_10_cse_1_sva[2]), (z_out_17[2]), (VEC_LOOP_acc_1_cse_10_sva[2]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[2]), (VEC_LOOP_acc_11_psp_sva_10_0[1]), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[2]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[2]), (VEC_LOOP_acc_11_psp_sva_10_0[0]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[2]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[2]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[2]),
      (VEC_LOOP_acc_10_cse_9_sva_mx0w8[2]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[2]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[2]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[2]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[2]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[2]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[2]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[2]),
      (z_out_15[2]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[2]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[2]),
      (z_out_18[2]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[2]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[2]),
      (VEC_LOOP_acc_10_cse_25_sva_mx0w24[2]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[2]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[2]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[2]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[2]), {and_dcpl_105 , and_dcpl_23 , and_dcpl_26
      , and_115_nl , and_dcpl_31 , and_dcpl_34 , and_dcpl_39 , and_dcpl_41 , and_dcpl_42
      , and_dcpl_46 , and_dcpl_50 , and_dcpl_51 , and_dcpl_53 , and_dcpl_58 , and_dcpl_60
      , and_dcpl_62 , and_dcpl_63 , and_dcpl_67 , and_dcpl_69 , and_dcpl_70 , VEC_LOOP_or_23_cse
      , and_dcpl_74 , and_dcpl_76 , VEC_LOOP_or_36_cse , and_dcpl_80 , and_dcpl_84
      , and_dcpl_87 , and_dcpl_92 , and_dcpl_95 , and_dcpl_97 , and_dcpl_99});
  assign or_362_nl = (fsm_output[2]) | mux_tmp_391;
  assign mux_392_nl = MUX_s_1_2_2(mux_tmp_389, or_362_nl, fsm_output[1]);
  assign and_117_nl = (~ mux_392_nl) & (fsm_output[0]);
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_30_2((COMP_LOOP_twiddle_f_17_sva[1]),
      (VEC_LOOP_acc_10_cse_1_sva[1]), (z_out_17[1]), (VEC_LOOP_acc_1_cse_10_sva[1]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[1]), (VEC_LOOP_acc_11_psp_sva_10_0[0]), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[1]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[1]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[1]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[1]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[1]),
      (VEC_LOOP_acc_10_cse_9_sva_mx0w8[1]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[1]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[1]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[1]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[1]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[1]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[1]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[1]),
      (z_out_15[1]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[1]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[1]),
      (z_out_18[1]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[1]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[1]),
      (VEC_LOOP_acc_10_cse_25_sva_mx0w24[1]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[1]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[1]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[1]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[1]), {and_dcpl_105 , and_dcpl_23 , and_dcpl_26
      , and_117_nl , and_dcpl_31 , and_dcpl_34 , and_dcpl_39 , and_dcpl_41 , and_dcpl_46
      , and_dcpl_50 , and_dcpl_51 , and_dcpl_53 , and_dcpl_58 , and_dcpl_60 , and_dcpl_62
      , and_dcpl_63 , and_dcpl_67 , and_dcpl_69 , and_dcpl_70 , VEC_LOOP_or_23_cse
      , and_dcpl_74 , and_dcpl_76 , VEC_LOOP_or_36_cse , and_dcpl_80 , and_dcpl_84
      , and_dcpl_87 , and_dcpl_92 , and_dcpl_95 , and_dcpl_97 , and_dcpl_99});
  assign mux_393_nl = MUX_s_1_2_2(mux_tmp_391, mux_tmp_356, fsm_output[2]);
  assign mux_394_nl = MUX_s_1_2_2(mux_tmp_389, mux_393_nl, fsm_output[1]);
  assign and_118_nl = (~ mux_394_nl) & (fsm_output[0]);
  assign VEC_LOOP_mux1h_9_nl = MUX1HOT_s_1_29_2((COMP_LOOP_twiddle_f_17_sva[0]),
      (VEC_LOOP_acc_10_cse_1_sva[0]), (z_out_17[0]), (VEC_LOOP_acc_1_cse_10_sva[0]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[0]), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[0]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[0]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[0]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[0]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[0]),
      (VEC_LOOP_acc_10_cse_9_sva_mx0w8[0]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[0]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[0]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[0]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[0]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[0]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[0]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[0]),
      (z_out_15[0]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[0]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[0]),
      (z_out_18[0]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[0]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[0]),
      (VEC_LOOP_acc_10_cse_25_sva_mx0w24[0]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[0]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[0]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[0]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[0]), {and_dcpl_105 , and_dcpl_23 , and_dcpl_26
      , and_118_nl , and_dcpl_31 , and_dcpl_39 , and_dcpl_41 , and_dcpl_46 , and_dcpl_50
      , and_dcpl_51 , and_dcpl_53 , and_dcpl_58 , and_dcpl_60 , and_dcpl_62 , and_dcpl_63
      , and_dcpl_67 , and_dcpl_69 , and_dcpl_70 , VEC_LOOP_or_23_cse , and_dcpl_74
      , and_dcpl_76 , VEC_LOOP_or_36_cse , and_dcpl_80 , and_dcpl_84 , and_dcpl_87
      , and_dcpl_92 , and_dcpl_95 , and_dcpl_97 , and_dcpl_99});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_10_nl , VEC_LOOP_mux1h_8_nl , VEC_LOOP_mux1h_6_nl
      , VEC_LOOP_mux1h_4_nl , VEC_LOOP_mux1h_2_nl , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl
      , VEC_LOOP_mux1h_3_nl , VEC_LOOP_mux1h_5_nl , VEC_LOOP_mux1h_7_nl , VEC_LOOP_mux1h_9_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_adra_d = {COMP_LOOP_twiddle_help_mux_1_rmff , COMP_LOOP_twiddle_help_mux_rmff
      , COMP_LOOP_twiddle_f_mux1h_87_rmff , COMP_LOOP_and_rmff , COMP_LOOP_twiddle_f_mux1h_57_rmff
      , COMP_LOOP_twiddle_f_mux1h_111_rmff , COMP_LOOP_twiddle_f_mux1h_128_rmff};
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_adra_d = {COMP_LOOP_twiddle_help_mux_1_rmff , COMP_LOOP_twiddle_help_mux_rmff
      , COMP_LOOP_twiddle_f_mux1h_87_rmff , COMP_LOOP_and_rmff , COMP_LOOP_twiddle_f_mux1h_57_rmff
      , COMP_LOOP_twiddle_f_mux1h_111_rmff , COMP_LOOP_twiddle_f_mux1h_128_rmff};
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign nor_175_cse = ~((fsm_output[8:6]!=3'b000));
  assign and_dcpl_251 = nor_175_cse & and_dcpl_14 & (fsm_output[3:0]==4'b1101);
  assign and_dcpl_265 = (fsm_output[8:6]==3'b010);
  assign and_dcpl_267 = and_dcpl_265 & (fsm_output[5:2]==4'b0110) & and_dcpl_11;
  assign and_dcpl_271 = and_dcpl_265 & and_dcpl_37 & (fsm_output[3:2]==2'b11) & and_dcpl_11;
  assign and_dcpl_276 = (fsm_output[8:6]==3'b100) & and_dcpl_37 & and_dcpl_12 & and_dcpl_11;
  assign and_dcpl_289 = nor_175_cse & (fsm_output[5:2]==4'b1010) & and_265_cse;
  assign and_dcpl_294 = nor_175_cse & (fsm_output[5:2]==4'b1111) & and_265_cse;
  assign and_dcpl_300 = (fsm_output[8:6]==3'b011) & and_dcpl_29 & and_dcpl_12 & (fsm_output[1:0]==2'b01);
  assign and_dcpl_303 = ~((fsm_output[3:0]!=4'b0001));
  assign and_dcpl_308 = and_dcpl_181 & (~ (fsm_output[8])) & (fsm_output[5]) & (~
      (fsm_output[4])) & and_dcpl_303;
  assign and_dcpl_313 = (fsm_output[8:6]==3'b001) & and_dcpl_44 & and_dcpl_303;
  assign and_dcpl_316 = (fsm_output[3:0]==4'b0111);
  assign and_dcpl_320 = (fsm_output[8:6]==3'b010) & and_dcpl_44 & and_dcpl_316;
  assign and_dcpl_324 = and_dcpl_181 & (fsm_output[8]) & (~ (fsm_output[5])) & (~
      (fsm_output[4])) & and_dcpl_316;
  assign and_dcpl_337 = (fsm_output[8:6]==3'b011);
  assign and_dcpl_351 = (fsm_output[3:2]==2'b01) & and_dcpl_11;
  assign and_dcpl_356 = (fsm_output[8:4]==5'b00011) & and_dcpl_351;
  assign and_dcpl_363 = (fsm_output[8:2]==7'b0010111) & and_dcpl_11;
  assign and_dcpl_368 = and_dcpl_265 & (fsm_output[5:4]==2'b00) & and_dcpl_351;
  assign and_dcpl_374 = and_dcpl_265 & (fsm_output[5:0]==6'b100011);
  assign and_dcpl_377 = (fsm_output[3:2]==2'b10) & and_265_cse;
  assign and_dcpl_382 = and_dcpl_337 & (fsm_output[5:4]==2'b00) & and_dcpl_377;
  assign and_dcpl_387 = and_dcpl_337 & (fsm_output[5:2]==4'b1100) & and_265_cse;
  assign and_dcpl_392 = (fsm_output[8:4]==5'b10001) & and_dcpl_377;
  assign and_dcpl_423 = and_dcpl_64 & (fsm_output[6:2]==5'b00011) & and_265_cse;
  assign and_dcpl_429 = and_dcpl_64 & (fsm_output[6:4]==3'b110) & and_dcpl_20 & (fsm_output[1:0]==2'b01);
  assign and_dcpl_433 = (fsm_output[3:2]==2'b00) & nor_125_cse;
  assign and_dcpl_436 = and_dcpl_181 & (fsm_output[8]);
  assign and_dcpl_438 = and_dcpl_436 & and_dcpl_44 & and_dcpl_433;
  assign and_dcpl_441 = and_dcpl_12 & and_dcpl_166;
  assign and_dcpl_444 = and_dcpl_436 & and_dcpl_37 & and_dcpl_441;
  assign and_dcpl_446 = and_237_cse_1 & nor_125_cse;
  assign and_dcpl_449 = and_dcpl_436 & and_dcpl_29 & and_dcpl_446;
  assign and_dcpl_451 = (fsm_output[3:2]==2'b10) & nor_125_cse;
  assign and_dcpl_454 = and_dcpl_436 & and_dcpl_14 & and_dcpl_451;
  assign and_dcpl_455 = and_237_cse_1 & and_dcpl_166;
  assign and_dcpl_458 = and_dcpl_337 & and_dcpl_44;
  assign and_dcpl_459 = and_dcpl_458 & and_dcpl_455;
  assign and_dcpl_461 = and_dcpl_337 & and_dcpl_37 & and_dcpl_433;
  assign and_dcpl_463 = and_dcpl_458 & and_dcpl_176;
  assign and_dcpl_467 = (fsm_output[8:6]==3'b010) & and_dcpl_29 & and_dcpl_433;
  assign and_dcpl_468 = and_dcpl_181 & (~ (fsm_output[8]));
  assign and_dcpl_470 = and_dcpl_468 & and_dcpl_29 & and_dcpl_451;
  assign and_dcpl_472 = (fsm_output[8:6]==3'b001);
  assign and_dcpl_473 = and_dcpl_472 & and_dcpl_29;
  assign and_dcpl_474 = and_dcpl_473 & and_dcpl_176;
  assign and_dcpl_476 = and_dcpl_468 & and_dcpl_37 & and_dcpl_446;
  assign and_dcpl_478 = and_dcpl_472 & and_dcpl_14 & and_dcpl_433;
  assign and_dcpl_480 = and_dcpl_468 & and_dcpl_44 & and_dcpl_441;
  assign and_dcpl_481 = and_dcpl_473 & and_dcpl_455;
  assign and_606_cse = (fsm_output[8:6]==3'b101) & and_dcpl_14 & and_dcpl_12 & (fsm_output[1:0]==2'b00);
  assign and_dcpl_547 = ~((fsm_output!=9'b000000010));
  assign and_dcpl_550 = (fsm_output[3:0]==4'b0101);
  assign and_634_cse = (fsm_output[8:4]==5'b01010) & and_dcpl_550;
  assign and_dcpl_568 = (fsm_output[8:2]==7'b0111111) & and_265_cse;
  assign and_dcpl_574 = and_dcpl_181 & (fsm_output[8]) & (~ (fsm_output[5])) & (fsm_output[4])
      & (~ (fsm_output[3])) & (~ (fsm_output[2])) & and_265_cse;
  assign and_dcpl_635 = (fsm_output[8:6]==3'b100);
  assign and_dcpl_646 = (fsm_output[3:2]==2'b11) & and_265_cse;
  assign and_dcpl_653 = (fsm_output[3:2]==2'b00) & and_265_cse;
  assign and_dcpl_658 = (fsm_output[3:2]==2'b01) & and_265_cse;
  assign and_dcpl_752 = (fsm_output[3:2]==2'b11) & and_dcpl_11;
  assign and_dcpl_757 = and_dcpl_15 & (~ (fsm_output[6])) & and_dcpl_37 & and_dcpl_752;
  assign and_dcpl_761 = and_dcpl_48 & and_dcpl_44 & and_dcpl_752;
  assign and_dcpl_766 = and_dcpl_77 & and_dcpl_14 & and_dcpl_752;
  assign and_dcpl_771 = (fsm_output[8:6]==3'b100) & and_dcpl_29 & and_dcpl_752;
  assign and_dcpl_775 = and_dcpl_48 & and_dcpl_29 & and_dcpl_351;
  assign and_dcpl_777 = and_dcpl_77 & and_dcpl_44 & and_dcpl_351;
  assign and_dcpl_780 = (fsm_output[3:0]==4'b1010);
  assign and_dcpl_782 = and_dcpl_77 & and_dcpl_37 & and_dcpl_780;
  assign and_dcpl_785 = and_dcpl_64 & (~ (fsm_output[6])) & and_dcpl_29 & and_dcpl_780;
  assign and_dcpl_787 = and_dcpl_48 & and_dcpl_14 & and_dcpl_780;
  assign and_dcpl_804 = ~((fsm_output[8:4]!=5'b00000) | (~ and_dcpl_550));
  assign and_dcpl_817 = (fsm_output==9'b100111010);
  assign and_dcpl_820 = and_dcpl_12 & (fsm_output[1:0]==2'b01);
  assign and_dcpl_825 = (fsm_output[8:6]==3'b000) & and_dcpl_14 & and_dcpl_820;
  assign and_dcpl_830 = (fsm_output[8:4]==5'b01010) & and_dcpl_820;
  assign and_dcpl_839 = (fsm_output[3:2]==2'b10) & and_dcpl_11;
  assign and_dcpl_844 = and_dcpl_16 & and_dcpl_29 & and_dcpl_839;
  assign and_dcpl_850 = and_dcpl_48 & and_dcpl_14 & and_dcpl_47;
  assign and_dcpl_853 = and_dcpl_48 & and_dcpl_37 & and_dcpl_839;
  assign and_dcpl_857 = and_dcpl_65 & and_dcpl_29 & and_dcpl_47;
  assign and_dcpl_860 = and_dcpl_65 & and_dcpl_44 & and_dcpl_839;
  assign and_937_cse = and_dcpl_77 & and_dcpl_37 & and_dcpl_47;
  assign and_dcpl_867 = and_dcpl_635 & and_dcpl_14 & and_dcpl_839;
  assign and_943_cse = and_dcpl_635 & and_dcpl_44 & and_dcpl_47;
  assign and_dcpl_871 = and_dcpl_35 & (fsm_output[1:0]==2'b10);
  assign and_dcpl_873 = and_dcpl_635 & and_dcpl_29 & and_dcpl_871;
  assign and_dcpl_875 = and_dcpl_77 & and_dcpl_14 & and_dcpl_871;
  assign and_dcpl_877 = and_dcpl_48 & and_dcpl_44 & and_dcpl_871;
  assign and_dcpl_879 = and_dcpl_16 & and_dcpl_37 & and_dcpl_871;
  assign VEC_LOOP_or_42_ssc = and_dcpl_568 | and_dcpl_574;
  assign or_tmp_510 = (fsm_output[7:4]!=4'b0000);
  assign or_tmp_517 = (~ (fsm_output[4])) | (fsm_output[1]) | (~ (fsm_output[0]));
  assign or_724_nl = (fsm_output[4]) | (fsm_output[1]) | (~ (fsm_output[0]));
  assign mux_tmp_957 = MUX_s_1_2_2(or_724_nl, or_tmp_517, fsm_output[2]);
  assign not_tmp_446 = ~((fsm_output[4]) & (fsm_output[1]) & (fsm_output[0]));
  assign or_tmp_523 = (fsm_output[1:0]!=2'b01);
  assign or_tmp_524 = (fsm_output[4]) | (~ and_265_cse);
  assign or_741_nl = (fsm_output[2:1]!=2'b00);
  assign mux_tmp_974 = MUX_s_1_2_2((fsm_output[2]), or_741_nl, fsm_output[0]);
  assign nand_tmp_21 = ~((fsm_output[4]) & (~ mux_tmp_974));
  assign mux_tmp_975 = MUX_s_1_2_2(and_257_cse, (fsm_output[2]), fsm_output[0]);
  assign or_tmp_537 = (fsm_output[2:0]!=3'b001);
  assign mux_tmp_976 = MUX_s_1_2_2((~ or_tmp_537), mux_tmp_975, fsm_output[4]);
  assign or_743_cse = (fsm_output[4:0]!=5'b11001);
  assign mux_977_nl = MUX_s_1_2_2((~ mux_tmp_976), nand_tmp_21, fsm_output[3]);
  assign mux_tmp_978 = MUX_s_1_2_2(or_743_cse, mux_977_nl, fsm_output[6]);
  assign or_744_nl = (fsm_output[4]) | (~ mux_tmp_975);
  assign mux_tmp_979 = MUX_s_1_2_2(nand_tmp_21, or_744_nl, fsm_output[3]);
  assign mux_tmp_980 = MUX_s_1_2_2(mux_tmp_974, or_tmp_537, fsm_output[4]);
  assign and_tmp = (fsm_output[3]) & mux_tmp_976;
  assign or_752_nl = (fsm_output[3:0]!=4'b0001);
  assign nand_51_nl = ~((fsm_output[3]) & (~((fsm_output[1:0]==2'b11))));
  assign or_751_nl = (fsm_output[3]) | nor_125_cse;
  assign mux_988_nl = MUX_s_1_2_2(nand_51_nl, or_751_nl, fsm_output[2]);
  assign mux_989_nl = MUX_s_1_2_2(or_752_nl, mux_988_nl, fsm_output[4]);
  assign mux_tmp_990 = MUX_s_1_2_2(or_743_cse, mux_989_nl, fsm_output[6]);
  assign or_tmp_549 = (fsm_output[4:0]!=5'b01101);
  assign or_759_nl = (fsm_output[3:0]!=4'b1001);
  assign nand_52_nl = ~((fsm_output[3:0]==4'b1101));
  assign mux_tmp_993 = MUX_s_1_2_2(or_759_nl, nand_52_nl, fsm_output[4]);
  assign mux_tmp_999 = MUX_s_1_2_2((~ (fsm_output[2])), (fsm_output[2]), fsm_output[4]);
  assign or_tmp_556 = (fsm_output[3]) | (~ mux_tmp_999);
  assign or_tmp_558 = (fsm_output[4:2]!=3'b011);
  assign and_tmp_4 = (fsm_output[3]) & mux_tmp_999;
  assign or_tmp_560 = (fsm_output[4:2]!=3'b100);
  assign or_tmp_562 = (fsm_output[4:2]!=3'b110);
  assign VEC_LOOP_or_51_itm = and_dcpl_438 | and_dcpl_444 | and_dcpl_449 | and_dcpl_454
      | and_dcpl_459 | and_dcpl_461 | and_dcpl_463 | and_dcpl_467 | and_dcpl_470
      | and_dcpl_474 | and_dcpl_476 | and_dcpl_478 | and_dcpl_480 | and_dcpl_481;
  assign and_767_itm = and_dcpl_436 & and_dcpl_29 & and_dcpl_653;
  assign and_771_itm = and_dcpl_436 & and_dcpl_44 & and_dcpl_377;
  assign VEC_LOOP_or_46_itm = and_dcpl_757 | and_dcpl_761 | and_dcpl_766 | and_dcpl_771;
  assign VEC_LOOP_or_61_itm = and_dcpl_873 | and_dcpl_875 | and_dcpl_877 | and_dcpl_879;
  assign VEC_LOOP_nor_17_itm = ~(and_dcpl_873 | and_dcpl_875 | and_dcpl_877 | and_dcpl_879);
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp ) begin
      VEC_LOOP_mult_vec_1_sva <= MUX1HOT_v_32_3_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
          COMP_LOOP_1_modulo_sub_cmp_return_rsc_z, {and_dcpl_199 , and_dcpl_200 ,
          and_205_nl});
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
      reg_run_rsci_oswt_cse <= ~(or_dcpl_161 | or_140_cse | (fsm_output[3:0]!=4'b0000));
      reg_vec_rsci_oswt_cse <= ~ mux_306_itm;
      reg_vec_rsci_oswt_1_cse <= and_14_rmff;
      reg_twiddle_rsci_oswt_cse <= and_123_rmff;
      reg_twiddle_rsci_oswt_1_cse <= and_128_rmff;
      reg_complete_rsci_oswt_cse <= and_dcpl_164 & and_dcpl_12 & (fsm_output[1:0]==2'b01)
          & STAGE_LOOP_acc_itm_4_1;
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_168;
      reg_ensig_cgo_cse <= ~ mux_411_itm;
      reg_ensig_cgo_2_cse <= ~ mux_532_itm;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_17 & and_dcpl_35 & nor_125_cse) | STAGE_LOOP_i_3_0_sva_mx0c1)
        ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, z_out_14, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_272_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_564 ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( mux_951_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_14_5_sva_8_0 <= MUX_v_9_2_2(9'b000000000, (z_out_23[8:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~((~ mux_568_nl) & and_dcpl_16)) ) begin
      COMP_LOOP_1_twiddle_f_acc_cse_sva <= z_out_14;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_584_nl | (fsm_output[8])) ) begin
      COMP_LOOP_17_twiddle_f_mul_psp_sva <= MUX_v_10_2_2(COMP_LOOP_17_twiddle_f_mul_nl,
          z_out_22, and_dcpl_72);
    end
  end
  always @(posedge clk) begin
    if ( mux_954_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva_12_9 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt[12:9];
    end
  end
  always @(posedge clk) begin
    if ( (~(mux_956_nl | (fsm_output[7]))) & (~((fsm_output[6:4]!=3'b000))) & (~
        (fsm_output[8])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva_8_0 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt[8:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_599_nl ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_cse ) begin
      COMP_LOOP_twiddle_help_1_sva <= MUX_v_32_2_2((twiddle_h_rsci_qa_d_mxwt[31:0]),
          (twiddle_h_rsci_qa_d_mxwt[63:32]), and_dcpl_190);
      COMP_LOOP_twiddle_f_1_sva <= MUX_v_32_2_2((twiddle_rsci_qa_d_mxwt[31:0]), (twiddle_rsci_qa_d_mxwt[63:32]),
          and_dcpl_190);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_973_nl) & complete_rsci_wen_comp ) begin
      COMP_LOOP_twiddle_f_17_sva <= MUX_v_32_2_2(32'b00000000000000000000000000000000,
          VEC_LOOP_mux1h_12_nl, COMP_LOOP_twiddle_f_nand_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (and_dcpl_18 | and_dcpl_168) ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm <= MUX_s_1_2_2((z_out_13_18_14[4]),
          run_rsci_ivld_mxwt, and_dcpl_168);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_18 | and_dcpl_26 | and_dcpl_31 | and_dcpl_39
        | and_dcpl_41 | and_dcpl_46 | and_dcpl_50 | and_dcpl_51 | and_dcpl_53 | and_dcpl_58
        | and_dcpl_60 | and_dcpl_62 | and_dcpl_63 | and_dcpl_67 | and_dcpl_69 | and_dcpl_70
        | and_dcpl_72 | and_dcpl_74 | and_dcpl_76 | and_dcpl_79 | and_dcpl_80 | and_dcpl_82
        | and_dcpl_84 | and_dcpl_85 | and_dcpl_87 | and_dcpl_88 | and_dcpl_92 | and_dcpl_94
        | and_dcpl_95 | and_dcpl_97 | and_dcpl_99 | and_dcpl_100) ) begin
      VEC_LOOP_acc_10_cse_1_sva <= MUX1HOT_v_14_26_2(z_out_15, VEC_LOOP_acc_10_cse_2_sva_mx0w1,
          VEC_LOOP_acc_10_cse_3_sva_mx0w2, VEC_LOOP_acc_10_cse_4_sva_mx0w3, VEC_LOOP_acc_10_cse_5_sva_mx0w4,
          VEC_LOOP_acc_10_cse_6_sva_mx0w5, VEC_LOOP_acc_10_cse_7_sva_mx0w6, VEC_LOOP_acc_10_cse_8_sva_mx0w7,
          VEC_LOOP_acc_10_cse_9_sva_mx0w8, VEC_LOOP_acc_10_cse_10_sva_mx0w9, VEC_LOOP_acc_10_cse_11_sva_mx0w10,
          VEC_LOOP_acc_10_cse_12_sva_mx0w11, VEC_LOOP_acc_10_cse_13_sva_mx0w12, VEC_LOOP_acc_10_cse_14_sva_mx0w13,
          VEC_LOOP_acc_10_cse_15_sva_mx0w14, VEC_LOOP_acc_10_cse_16_sva_mx0w15, VEC_LOOP_acc_10_cse_18_sva_mx0w17,
          VEC_LOOP_acc_10_cse_19_sva_mx0w18, z_out_18, VEC_LOOP_acc_10_cse_21_sva_mx0w20,
          VEC_LOOP_acc_10_cse_23_sva_mx0w22, VEC_LOOP_acc_10_cse_25_sva_mx0w24, VEC_LOOP_acc_10_cse_27_sva_mx0w26,
          VEC_LOOP_acc_10_cse_29_sva_mx0w28, VEC_LOOP_acc_10_cse_30_sva_mx0w29, VEC_LOOP_acc_10_cse_31_sva_mx0w30,
          {VEC_LOOP_or_35_nl , and_dcpl_26 , and_dcpl_31 , and_dcpl_39 , and_dcpl_41
          , and_dcpl_46 , and_dcpl_50 , and_dcpl_51 , and_dcpl_53 , and_dcpl_58 ,
          and_dcpl_60 , and_dcpl_62 , and_dcpl_63 , and_dcpl_67 , and_dcpl_69 , and_dcpl_70
          , and_dcpl_74 , and_dcpl_76 , VEC_LOOP_or_36_cse , and_dcpl_80 , and_dcpl_84
          , and_dcpl_87 , and_dcpl_92 , and_dcpl_95 , and_dcpl_97 , and_dcpl_99});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_746_nl ) begin
      COMP_LOOP_twiddle_help_17_sva <= MUX1HOT_v_32_3_2(z_out_21, (twiddle_h_rsci_qa_d_mxwt[63:32]),
          (twiddle_h_rsci_qa_d_mxwt[31:0]), {and_dcpl_18 , and_dcpl_133 , and_dcpl_195});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_199 | and_dcpl_200) ) begin
      factor1_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
          and_dcpl_200);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (VEC_LOOP_acc_1_cse_10_sva_mx0c0 | and_dcpl_26
        | VEC_LOOP_acc_1_cse_10_sva_mx0c2 | and_dcpl_39 | and_dcpl_46 | and_dcpl_51
        | and_dcpl_58 | and_dcpl_62 | and_dcpl_67 | and_dcpl_70 | and_dcpl_74 | and_dcpl_79
        | and_dcpl_82 | and_dcpl_85 | and_dcpl_88 | and_dcpl_94 | and_dcpl_97 | and_dcpl_100)
        ) begin
      VEC_LOOP_acc_1_cse_10_sva <= MUX_v_14_2_2(14'b00000000000000, VEC_LOOP_VEC_LOOP_mux_2_nl,
          VEC_LOOP_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_14_0_sva_1 <= 15'b000000000000000;
    end
    else if ( complete_rsci_wen_comp & (~(mux_877_cse | (~ (fsm_output[0])))) ) begin
      VEC_LOOP_j_10_14_0_sva_1 <= z_out_11;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_879_nl ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva <= z_out_1;
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_987_nl) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_11_psp_sva_12 <= z_out_24[12];
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_998_nl) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_11_psp_sva_11 <= MUX_s_1_2_2((z_out_24[11]), (z_out_20[11]), mux_885_ssc);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_1008_nl) & (fsm_output[1:0]==2'b01) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_11_psp_sva_10_0 <= MUX_v_11_2_2((z_out_24[10:0]), (z_out_20[10:0]),
          VEC_LOOP_or_66_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_907_nl | (fsm_output[8])) ) begin
      COMP_LOOP_9_twiddle_f_lshift_ncse_sva <= z_out_1[10:0];
    end
  end
  assign mux_786_nl = MUX_s_1_2_2(mux_420_cse, mux_428_cse, fsm_output[2]);
  assign mux_787_nl = MUX_s_1_2_2(mux_786_nl, mux_426_cse, fsm_output[3]);
  assign mux_791_nl = MUX_s_1_2_2(mux_427_cse, mux_787_nl, fsm_output[1]);
  assign and_205_nl = (~ mux_791_nl) & (fsm_output[0]);
  assign and_255_nl = (((and_257_cse | (fsm_output[5:3]!=3'b000)) & (fsm_output[6]))
      | (fsm_output[7])) & (fsm_output[8]);
  assign mux_272_nl = MUX_s_1_2_2(mux_271_cse, and_255_nl, fsm_output[0]);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_564;
  assign mux_948_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[8]);
  assign mux_949_nl = MUX_s_1_2_2(mux_948_nl, nor_tmp_7, fsm_output[6]);
  assign mux_947_nl = MUX_s_1_2_2(nor_tmp_7, (fsm_output[8]), fsm_output[6]);
  assign mux_950_nl = MUX_s_1_2_2(mux_949_nl, mux_947_nl, or_714_cse);
  assign mux_nl = MUX_s_1_2_2(nor_tmp_7, (fsm_output[8]), and_973_cse);
  assign mux_951_nl = MUX_s_1_2_2(mux_950_nl, mux_nl, fsm_output[1]);
  assign mux_566_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), or_483_cse);
  assign or_482_nl = (~((fsm_output[4:2]!=3'b000))) | (fsm_output[5]);
  assign mux_567_nl = MUX_s_1_2_2(mux_566_nl, or_482_nl, fsm_output[1]);
  assign mux_565_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), or_480_cse);
  assign mux_568_nl = MUX_s_1_2_2(mux_567_nl, mux_565_nl, fsm_output[0]);
  assign nl_COMP_LOOP_17_twiddle_f_mul_nl = (z_out[9:0]) * ({COMP_LOOP_k_14_5_sva_8_0
      , 1'b1});
  assign COMP_LOOP_17_twiddle_f_mul_nl = nl_COMP_LOOP_17_twiddle_f_mul_nl[9:0];
  assign mux_582_nl = MUX_s_1_2_2(mux_tmp_579, mux_tmp_575, fsm_output[2]);
  assign mux_583_nl = MUX_s_1_2_2(mux_tmp_580, mux_582_nl, fsm_output[1]);
  assign or_488_nl = ((and_242_cse | (fsm_output[5])) & (fsm_output[6])) | (fsm_output[7]);
  assign mux_576_nl = MUX_s_1_2_2(or_488_nl, mux_tmp_575, fsm_output[2]);
  assign mux_581_nl = MUX_s_1_2_2(mux_tmp_580, mux_576_nl, fsm_output[1]);
  assign mux_584_nl = MUX_s_1_2_2(mux_583_nl, mux_581_nl, fsm_output[0]);
  assign mux_953_nl = MUX_s_1_2_2((~ or_tmp_510), or_717_cse, fsm_output[8]);
  assign nor_223_nl = ~((fsm_output[4]) | (fsm_output[1]) | (fsm_output[5]) | (fsm_output[6])
      | (fsm_output[7]));
  assign mux_952_nl = MUX_s_1_2_2(nor_223_nl, or_tmp_510, fsm_output[8]);
  assign mux_954_nl = MUX_s_1_2_2(mux_953_nl, mux_952_nl, and_237_cse_1);
  assign or_769_nl = (fsm_output[2:1]!=2'b01);
  assign or_770_nl = (fsm_output[2:1]!=2'b10);
  assign mux_955_nl = MUX_s_1_2_2(or_769_nl, or_770_nl, fsm_output[0]);
  assign or_771_nl = (fsm_output[2:0]!=3'b101);
  assign mux_956_nl = MUX_s_1_2_2(mux_955_nl, or_771_nl, fsm_output[3]);
  assign mux_597_nl = MUX_s_1_2_2(mux_tmp_595, nor_tmp_66, or_499_cse);
  assign and_235_nl = ((or_499_cse & (fsm_output[5])) | (fsm_output[7:6]!=2'b00))
      & (fsm_output[8]);
  assign mux_598_nl = MUX_s_1_2_2(mux_597_nl, and_235_nl, fsm_output[2]);
  assign mux_596_nl = MUX_s_1_2_2(mux_tmp_595, nor_tmp_66, or_483_cse);
  assign mux_599_nl = MUX_s_1_2_2(mux_598_nl, mux_596_nl, fsm_output[1]);
  assign or_526_nl = (~ (fsm_output[3])) | (fsm_output[6]) | (~ (fsm_output[5]));
  assign mux_663_nl = MUX_s_1_2_2(or_526_nl, or_tmp_352, fsm_output[4]);
  assign or_127_nl = (fsm_output[6:5]!=2'b00);
  assign mux_662_nl = MUX_s_1_2_2(or_127_nl, or_tmp_354, fsm_output[3]);
  assign nand_11_nl = ~((fsm_output[4]) & (~ mux_662_nl));
  assign mux_664_nl = MUX_s_1_2_2(mux_663_nl, nand_11_nl, fsm_output[2]);
  assign or_522_nl = (fsm_output[6:5]!=2'b10);
  assign mux_659_nl = MUX_s_1_2_2(or_tmp_354, or_522_nl, fsm_output[3]);
  assign mux_660_nl = MUX_s_1_2_2(or_tmp_351, mux_659_nl, fsm_output[4]);
  assign mux_658_nl = MUX_s_1_2_2(or_tmp_352, or_tmp_351, fsm_output[4]);
  assign mux_661_nl = MUX_s_1_2_2(mux_660_nl, mux_658_nl, fsm_output[2]);
  assign mux_665_nl = MUX_s_1_2_2(mux_664_nl, mux_661_nl, fsm_output[1]);
  assign or_519_nl = (fsm_output[6:1]!=6'b100000);
  assign mux_666_nl = MUX_s_1_2_2(mux_665_nl, or_519_nl, fsm_output[8]);
  assign and_197_nl = (~ mux_666_nl) & (~ (fsm_output[7])) & (fsm_output[0]);
  assign VEC_LOOP_mux1h_12_nl = MUX1HOT_v_32_4_2(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z,
      COMP_LOOP_twiddle_help_17_sva, (twiddle_rsci_qa_d_mxwt[63:32]), (twiddle_rsci_qa_d_mxwt[31:0]),
      {and_197_nl , and_dcpl_125 , and_dcpl_133 , and_dcpl_195});
  assign COMP_LOOP_twiddle_f_nand_nl = ~(and_dcpl_17 & and_dcpl_176);
  assign or_740_nl = (fsm_output[1:0]!=2'b00);
  assign mux_968_nl = MUX_s_1_2_2(or_740_nl, or_tmp_523, fsm_output[4]);
  assign nand_49_nl = ~((fsm_output[2]) & (~ mux_968_nl));
  assign mux_967_nl = MUX_s_1_2_2(or_tmp_517, or_tmp_524, fsm_output[2]);
  assign mux_969_nl = MUX_s_1_2_2(nand_49_nl, mux_967_nl, fsm_output[6]);
  assign or_739_nl = (fsm_output[6]) | (fsm_output[2]) | not_tmp_446;
  assign mux_970_nl = MUX_s_1_2_2(mux_969_nl, or_739_nl, fsm_output[5]);
  assign or_768_nl = (fsm_output[6:5]!=2'b10) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | mux_tmp_957;
  assign mux_971_nl = MUX_s_1_2_2(mux_970_nl, or_768_nl, fsm_output[7]);
  assign or_736_nl = (~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (fsm_output[2]) | (~ (fsm_output[4]))
      | (fsm_output[1]) | (~ (fsm_output[0]));
  assign or_734_nl = (fsm_output[2]) | (fsm_output[4]) | (fsm_output[1]) | (~ (fsm_output[0]));
  assign mux_965_nl = MUX_s_1_2_2(or_736_nl, or_734_nl, fsm_output[6]);
  assign or_732_nl = (fsm_output[6]) | (~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (~ (fsm_output[2]))
      | (fsm_output[4]) | (fsm_output[1]) | (~ (fsm_output[0]));
  assign mux_966_nl = MUX_s_1_2_2(mux_965_nl, or_732_nl, fsm_output[5]);
  assign or_737_nl = (fsm_output[7]) | mux_966_nl;
  assign mux_972_nl = MUX_s_1_2_2(mux_971_nl, or_737_nl, fsm_output[8]);
  assign mux_960_nl = MUX_s_1_2_2(or_tmp_523, (~ and_265_cse), fsm_output[4]);
  assign mux_961_nl = MUX_s_1_2_2(or_tmp_524, mux_960_nl, fsm_output[2]);
  assign mux_959_nl = MUX_s_1_2_2(not_tmp_446, or_tmp_517, fsm_output[2]);
  assign mux_962_nl = MUX_s_1_2_2(mux_961_nl, mux_959_nl, fsm_output[6]);
  assign or_727_nl = (fsm_output[6]) | mux_tmp_957;
  assign mux_963_nl = MUX_s_1_2_2(mux_962_nl, or_727_nl, fsm_output[5]);
  assign nor_220_nl = ~((~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (~ (fsm_output[2]))
      | (fsm_output[4]) | (fsm_output[1]) | (~ (fsm_output[0])));
  assign and_970_nl = (VEC_LOOP_j_10_14_0_sva_1[14]) & (~ mux_tmp_957);
  assign mux_958_nl = MUX_s_1_2_2(nor_220_nl, and_970_nl, fsm_output[6]);
  assign nand_47_nl = ~((fsm_output[5]) & mux_958_nl);
  assign mux_964_nl = MUX_s_1_2_2(mux_963_nl, nand_47_nl, fsm_output[7]);
  assign or_730_nl = (fsm_output[8]) | mux_964_nl;
  assign mux_973_nl = MUX_s_1_2_2(mux_972_nl, or_730_nl, fsm_output[3]);
  assign VEC_LOOP_or_35_nl = and_dcpl_18 | and_dcpl_72 | and_dcpl_88 | and_dcpl_94;
  assign mux_744_nl = MUX_s_1_2_2(mux_tmp_724, mux_tmp_735, fsm_output[5]);
  assign or_561_nl = (fsm_output[4:2]!=3'b010);
  assign mux_741_nl = MUX_s_1_2_2(mux_tmp_721, mux_tmp_719, or_561_nl);
  assign mux_738_nl = MUX_s_1_2_2(or_tmp_387, or_tmp_37, fsm_output[4]);
  assign mux_739_nl = MUX_s_1_2_2(mux_738_nl, mux_tmp_722, fsm_output[3]);
  assign nor_87_nl = ~((fsm_output[4:3]!=2'b10));
  assign mux_737_nl = MUX_s_1_2_2(mux_tmp_719, or_tmp_387, nor_87_nl);
  assign mux_740_nl = MUX_s_1_2_2(mux_739_nl, mux_737_nl, fsm_output[2]);
  assign mux_742_nl = MUX_s_1_2_2(mux_741_nl, mux_740_nl, VEC_LOOP_j_10_14_0_sva_1[14]);
  assign mux_732_nl = MUX_s_1_2_2(mux_266_cse, or_tmp_36, fsm_output[6]);
  assign mux_733_nl = MUX_s_1_2_2(mux_732_nl, mux_594_cse, or_559_cse);
  assign mux_730_nl = MUX_s_1_2_2(or_tmp_380, mux_594_cse, fsm_output[4]);
  assign mux_728_nl = MUX_s_1_2_2(or_558_cse, (fsm_output[8]), fsm_output[6]);
  assign mux_727_nl = MUX_s_1_2_2(or_tmp_37, or_tmp_36, fsm_output[6]);
  assign mux_729_nl = MUX_s_1_2_2(mux_728_nl, mux_727_nl, fsm_output[4]);
  assign mux_731_nl = MUX_s_1_2_2(mux_730_nl, mux_729_nl, fsm_output[3]);
  assign mux_734_nl = MUX_s_1_2_2(mux_733_nl, mux_731_nl, fsm_output[2]);
  assign mux_736_nl = MUX_s_1_2_2(mux_tmp_735, mux_734_nl, VEC_LOOP_j_10_14_0_sva_1[14]);
  assign mux_743_nl = MUX_s_1_2_2(mux_742_nl, mux_736_nl, fsm_output[5]);
  assign mux_745_nl = MUX_s_1_2_2(mux_744_nl, mux_743_nl, fsm_output[0]);
  assign mux_720_nl = MUX_s_1_2_2(mux_tmp_719, mux_594_cse, fsm_output[4]);
  assign mux_723_nl = MUX_s_1_2_2(mux_tmp_722, mux_720_nl, fsm_output[3]);
  assign mux_725_nl = MUX_s_1_2_2(mux_tmp_724, mux_723_nl, fsm_output[2]);
  assign mux_717_nl = MUX_s_1_2_2(mux_594_cse, or_tmp_380, and_242_cse);
  assign mux_726_nl = MUX_s_1_2_2(mux_725_nl, mux_717_nl, fsm_output[5]);
  assign mux_746_nl = MUX_s_1_2_2(mux_745_nl, mux_726_nl, fsm_output[1]);
  assign VEC_LOOP_VEC_LOOP_mux_2_nl = MUX_v_14_2_2(z_out_17, (VEC_LOOP_j_10_14_0_sva_1[13:0]),
      VEC_LOOP_acc_1_cse_10_sva_mx0c2);
  assign VEC_LOOP_not_nl = ~ VEC_LOOP_acc_1_cse_10_sva_mx0c0;
  assign mux_588_nl = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[8]), or_717_cse);
  assign or_637_nl = (~((fsm_output[7:5]!=3'b000))) | (fsm_output[8]);
  assign mux_878_nl = MUX_s_1_2_2(mux_588_nl, or_637_nl, fsm_output[4]);
  assign or_635_nl = (~((fsm_output[7:4]!=4'b0000))) | (fsm_output[8]);
  assign mux_879_nl = MUX_s_1_2_2(mux_878_nl, or_635_nl, fsm_output[3]);
  assign mux_984_nl = MUX_s_1_2_2(mux_tmp_979, (~ and_tmp), fsm_output[6]);
  assign mux_985_nl = MUX_s_1_2_2(mux_tmp_978, mux_984_nl, fsm_output[5]);
  assign or_749_nl = (fsm_output[6]) | (~ and_tmp);
  assign or_748_nl = (fsm_output[6]) | (fsm_output[3]) | mux_tmp_980;
  assign mux_983_nl = MUX_s_1_2_2(or_749_nl, or_748_nl, fsm_output[5]);
  assign mux_986_nl = MUX_s_1_2_2(mux_985_nl, mux_983_nl, fsm_output[8]);
  assign or_745_nl = (fsm_output[3]) | mux_tmp_980;
  assign mux_981_nl = MUX_s_1_2_2(or_745_nl, mux_tmp_979, fsm_output[6]);
  assign mux_982_nl = MUX_s_1_2_2(mux_981_nl, mux_tmp_978, fsm_output[5]);
  assign or_746_nl = (fsm_output[8]) | mux_982_nl;
  assign mux_987_nl = MUX_s_1_2_2(mux_986_nl, or_746_nl, fsm_output[7]);
  assign mux_995_nl = MUX_s_1_2_2(or_tmp_549, mux_tmp_993, fsm_output[6]);
  assign mux_996_nl = MUX_s_1_2_2(mux_tmp_990, mux_995_nl, fsm_output[5]);
  assign or_760_nl = (fsm_output[6]) | mux_tmp_993;
  assign or_757_nl = (fsm_output[6]) | (~ (fsm_output[4])) | (fsm_output[2]) | (fsm_output[3])
      | (~ (fsm_output[0])) | (fsm_output[1]);
  assign mux_994_nl = MUX_s_1_2_2(or_760_nl, or_757_nl, fsm_output[5]);
  assign mux_997_nl = MUX_s_1_2_2(mux_996_nl, mux_994_nl, fsm_output[8]);
  assign or_755_nl = (fsm_output[4:0]!=5'b10001);
  assign mux_991_nl = MUX_s_1_2_2(or_755_nl, or_tmp_549, fsm_output[6]);
  assign mux_992_nl = MUX_s_1_2_2(mux_991_nl, mux_tmp_990, fsm_output[5]);
  assign or_756_nl = (fsm_output[8]) | mux_992_nl;
  assign mux_998_nl = MUX_s_1_2_2(mux_997_nl, or_756_nl, fsm_output[7]);
  assign mux_571_nl = MUX_s_1_2_2(or_tmp_173, mux_tmp_570, fsm_output[1]);
  assign mux_585_nl = MUX_s_1_2_2(mux_tmp_570, or_tmp_174, fsm_output[1]);
  assign mux_886_nl = MUX_s_1_2_2(mux_571_nl, mux_585_nl, fsm_output[0]);
  assign VEC_LOOP_or_66_nl = mux_885_ssc | ((~ mux_886_nl) & xor_dcpl & (~ (fsm_output[8]))
      & (fsm_output[6]) & (fsm_output[4]));
  assign mux_1005_nl = MUX_s_1_2_2(or_tmp_562, or_tmp_558, fsm_output[5]);
  assign mux_1004_nl = MUX_s_1_2_2(or_tmp_560, or_tmp_562, fsm_output[5]);
  assign mux_1006_nl = MUX_s_1_2_2(mux_1005_nl, mux_1004_nl, fsm_output[7]);
  assign mux_1003_nl = MUX_s_1_2_2((~ and_tmp_4), or_tmp_560, fsm_output[5]);
  assign or_766_nl = (fsm_output[7]) | mux_1003_nl;
  assign mux_1007_nl = MUX_s_1_2_2(mux_1006_nl, or_766_nl, fsm_output[8]);
  assign mux_1001_nl = MUX_s_1_2_2(or_tmp_556, (~ and_tmp_4), fsm_output[5]);
  assign mux_1000_nl = MUX_s_1_2_2(or_tmp_558, or_tmp_556, fsm_output[5]);
  assign mux_1002_nl = MUX_s_1_2_2(mux_1001_nl, mux_1000_nl, fsm_output[7]);
  assign or_764_nl = (fsm_output[8]) | mux_1002_nl;
  assign mux_1008_nl = MUX_s_1_2_2(mux_1007_nl, or_764_nl, fsm_output[6]);
  assign mux_905_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign mux_906_nl = MUX_s_1_2_2(and_dcpl_181, mux_905_nl, fsm_output[5]);
  assign and_217_nl = (fsm_output[7:6]==2'b11);
  assign mux_904_nl = MUX_s_1_2_2(and_dcpl_181, and_217_nl, fsm_output[5]);
  assign mux_907_nl = MUX_s_1_2_2(mux_906_nl, mux_904_nl, or_480_cse);
  assign COMP_LOOP_twiddle_f_mux_11_nl = MUX_v_14_2_2(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1,
      ({1'b0 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1}), and_dcpl_251);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl = (COMP_LOOP_k_14_5_sva_8_0[8])
      & (~ and_dcpl_251);
  assign COMP_LOOP_twiddle_f_mux_12_nl = MUX_v_8_2_2((COMP_LOOP_k_14_5_sva_8_0[7:0]),
      (COMP_LOOP_k_14_5_sva_8_0[8:1]), and_dcpl_251);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl = (COMP_LOOP_k_14_5_sva_8_0[0])
      & and_dcpl_251;
  assign nl_z_out_2 = COMP_LOOP_twiddle_f_mux_11_nl * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl
      , COMP_LOOP_twiddle_f_mux_12_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl
      , 4'b0001});
  assign z_out_2 = nl_z_out_2[13:0];
  assign COMP_LOOP_twiddle_f_or_41_nl = and_dcpl_267 | and_dcpl_271;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_5_nl = MUX_v_2_2_2(2'b01, 2'b10,
      COMP_LOOP_twiddle_f_or_41_nl);
  assign COMP_LOOP_twiddle_f_or_40_nl = MUX_v_2_2_2(COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_5_nl,
      2'b11, and_dcpl_276);
  assign COMP_LOOP_twiddle_f_or_42_nl = (~ and_dcpl_267) | ((fsm_output[8:6]==3'b001)
      & and_dcpl_37 & and_dcpl_12 & (fsm_output[1:0]==2'b11)) | and_dcpl_271 | and_dcpl_276;
  assign nl_z_out_3 = COMP_LOOP_2_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_14_5_sva_8_0
      , COMP_LOOP_twiddle_f_or_40_nl , and_dcpl_276 , COMP_LOOP_twiddle_f_or_42_nl
      , 1'b1});
  assign z_out_3 = nl_z_out_3[13:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_11_nl = (~((nor_175_cse & and_dcpl_29
      & and_dcpl_12 & and_265_cse) | and_dcpl_289 | and_dcpl_294)) | and_dcpl_300;
  assign COMP_LOOP_twiddle_f_mux_13_nl = MUX_v_2_2_2(2'b01, 2'b10, and_dcpl_289);
  assign COMP_LOOP_twiddle_f_or_43_nl = and_dcpl_294 | and_dcpl_300;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_12_nl = MUX_v_2_2_2(COMP_LOOP_twiddle_f_mux_13_nl,
      2'b11, COMP_LOOP_twiddle_f_or_43_nl);
  assign nl_z_out_4 = COMP_LOOP_2_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_14_5_sva_8_0
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_11_nl , 1'b0 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_12_nl
      , 1'b1});
  assign z_out_4 = nl_z_out_4[13:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_13_nl = (~(and_dcpl_308 | and_dcpl_313))
      | and_dcpl_320 | and_dcpl_324;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_14_nl = (~(and_dcpl_308 | and_dcpl_320))
      | and_dcpl_313 | and_dcpl_324;
  assign nl_z_out_5_11_0 = COMP_LOOP_5_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_14_5_sva_8_0
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_13_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_14_nl
      , 1'b1});
  assign z_out_5_11_0 = nl_z_out_5_11_0[11:0];
  assign and_977_nl = (fsm_output[8:6]==3'b001) & and_dcpl_29 & and_dcpl_35 & (fsm_output[1:0]==2'b11);
  assign and_978_nl = and_dcpl_337 & (fsm_output[5:4]==2'b00) & and_dcpl_47;
  assign and_979_nl = and_dcpl_337 & (fsm_output[5:2]==4'b1111) & and_dcpl_11;
  assign and_980_nl = (fsm_output[8:6]==3'b100) & and_dcpl_29 & and_dcpl_47;
  assign COMP_LOOP_twiddle_f_mux1h_296_nl = MUX1HOT_v_4_4_2(4'b0100, 4'b1010, 4'b1101,
      4'b1110, {and_977_nl , and_978_nl , and_979_nl , and_980_nl});
  assign nl_z_out_6 = COMP_LOOP_2_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_14_5_sva_8_0
      , COMP_LOOP_twiddle_f_mux1h_296_nl , 1'b1});
  assign z_out_6 = nl_z_out_6[13:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_15_nl = (~(and_dcpl_356 | and_dcpl_363
      | and_dcpl_368)) | and_dcpl_374;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_16_nl = (~(and_dcpl_356 | and_dcpl_374))
      | and_dcpl_363 | and_dcpl_368;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_17_nl = (~(and_dcpl_363 | and_dcpl_374))
      | and_dcpl_356 | and_dcpl_368;
  assign nl_z_out_7_12_0 = ({COMP_LOOP_3_twiddle_f_lshift_ncse_sva_12_9 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_8_0})
      * ({COMP_LOOP_k_14_5_sva_8_0 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_15_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_16_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_17_nl
      , 1'b1});
  assign z_out_7_12_0 = nl_z_out_7_12_0[12:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_18_nl = (~ and_dcpl_382) | and_dcpl_387
      | and_dcpl_392;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_19_nl = (~ and_dcpl_387) | and_dcpl_382
      | and_dcpl_392;
  assign nl_z_out_8_12_0 = ({COMP_LOOP_3_twiddle_f_lshift_ncse_sva_12_9 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_8_0})
      * ({COMP_LOOP_k_14_5_sva_8_0 , 1'b1 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_18_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_19_nl , 1'b1});
  assign z_out_8_12_0 = nl_z_out_8_12_0[12:0];
  assign and_981_nl = (fsm_output==9'b011011111);
  assign nl_z_out_9_10_0 = COMP_LOOP_9_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_14_5_sva_8_0
      , and_981_nl , 1'b1});
  assign z_out_9_10_0 = nl_z_out_9_10_0[10:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_20_nl = (~(((fsm_output[8:4]==5'b00111)
      & and_dcpl_20 & and_265_cse) | and_dcpl_423)) | and_dcpl_429;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_21_nl = (~ and_dcpl_429) | and_dcpl_423;
  assign nl_z_out_10 = COMP_LOOP_2_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_14_5_sva_8_0
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_20_nl , 1'b1 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_21_nl
      , and_dcpl_423 , 1'b1});
  assign z_out_10 = nl_z_out_10[13:0];
  assign VEC_LOOP_VEC_LOOP_or_15_nl = (STAGE_LOOP_lshift_psp_sva[14]) | and_dcpl_438
      | and_dcpl_444 | and_dcpl_449 | and_dcpl_454 | and_dcpl_459 | and_dcpl_461
      | and_dcpl_463 | and_dcpl_467 | and_dcpl_470 | and_dcpl_474 | and_dcpl_476
      | and_dcpl_478 | and_dcpl_480 | and_dcpl_481;
  assign VEC_LOOP_VEC_LOOP_mux_14_nl = MUX_v_14_2_2((STAGE_LOOP_lshift_psp_sva[13:0]),
      (~ (STAGE_LOOP_lshift_psp_sva[14:1])), VEC_LOOP_or_51_itm);
  assign VEC_LOOP_or_67_nl = (~((~ mux_877_cse) & (fsm_output[0]))) | and_dcpl_438
      | and_dcpl_444 | and_dcpl_449 | and_dcpl_454 | and_dcpl_459 | and_dcpl_461
      | and_dcpl_463 | and_dcpl_467 | and_dcpl_470 | and_dcpl_474 | and_dcpl_476
      | and_dcpl_478 | and_dcpl_480 | and_dcpl_481;
  assign VEC_LOOP_VEC_LOOP_mux_15_nl = MUX_v_9_2_2((VEC_LOOP_acc_1_cse_10_sva[13:5]),
      COMP_LOOP_k_14_5_sva_8_0, VEC_LOOP_or_51_itm);
  assign VEC_LOOP_VEC_LOOP_or_16_nl = ((VEC_LOOP_acc_1_cse_10_sva[4]) & (~(and_dcpl_467
      | and_dcpl_470 | and_dcpl_474 | and_dcpl_476 | and_dcpl_478 | and_dcpl_480
      | and_dcpl_481))) | and_dcpl_438 | and_dcpl_444 | and_dcpl_449 | and_dcpl_454
      | and_dcpl_459 | and_dcpl_461 | and_dcpl_463;
  assign VEC_LOOP_VEC_LOOP_or_17_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_dcpl_461
      | and_dcpl_470 | and_dcpl_476 | and_dcpl_478 | and_dcpl_480))) | and_dcpl_438
      | and_dcpl_444 | and_dcpl_449 | and_dcpl_454 | and_dcpl_459 | and_dcpl_463
      | and_dcpl_467 | and_dcpl_474 | and_dcpl_481;
  assign VEC_LOOP_VEC_LOOP_or_18_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_dcpl_454
      | and_dcpl_459 | and_dcpl_463 | and_dcpl_470 | and_dcpl_474 | and_dcpl_481)))
      | and_dcpl_438 | and_dcpl_444 | and_dcpl_449 | and_dcpl_461 | and_dcpl_467
      | and_dcpl_476 | and_dcpl_478 | and_dcpl_480;
  assign VEC_LOOP_VEC_LOOP_or_19_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_dcpl_444
      | and_dcpl_449 | and_dcpl_459 | and_dcpl_463 | and_dcpl_474 | and_dcpl_476
      | and_dcpl_480 | and_dcpl_481))) | and_dcpl_438 | and_dcpl_454 | and_dcpl_461
      | and_dcpl_467 | and_dcpl_470 | and_dcpl_478;
  assign VEC_LOOP_VEC_LOOP_or_20_nl = ((VEC_LOOP_acc_1_cse_10_sva[0]) & (~(and_dcpl_438
      | and_dcpl_449 | and_dcpl_454 | and_dcpl_461 | and_dcpl_463 | and_dcpl_467
      | and_dcpl_470 | and_dcpl_474 | and_dcpl_476 | and_dcpl_478))) | and_dcpl_444
      | and_dcpl_459 | and_dcpl_480 | and_dcpl_481;
  assign nl_acc_nl = ({VEC_LOOP_VEC_LOOP_or_15_nl , VEC_LOOP_VEC_LOOP_mux_14_nl ,
      VEC_LOOP_or_67_nl}) + conv_u2u_15_16({VEC_LOOP_VEC_LOOP_mux_15_nl , VEC_LOOP_VEC_LOOP_or_16_nl
      , VEC_LOOP_VEC_LOOP_or_17_nl , VEC_LOOP_VEC_LOOP_or_18_nl , VEC_LOOP_VEC_LOOP_or_19_nl
      , VEC_LOOP_VEC_LOOP_or_20_nl , 1'b1});
  assign acc_nl = nl_acc_nl[15:0];
  assign z_out_11 = readslicef_16_15_1(acc_nl);
  assign and_983_nl = and_dcpl_65 & and_dcpl_44 & and_dcpl_451;
  assign and_984_nl = and_dcpl_71 & and_dcpl_455;
  assign and_985_nl = and_dcpl_71 & and_dcpl_12 & nor_125_cse;
  assign and_986_nl = and_dcpl_48 & and_dcpl_44 & and_dcpl_446;
  assign and_987_nl = and_dcpl_77 & and_dcpl_14 & and_dcpl_446;
  assign and_988_nl = and_dcpl_65 & and_dcpl_14 & and_dcpl_441;
  assign and_989_nl = and_dcpl_77 & (fsm_output[5:4]==2'b01) & and_dcpl_441;
  assign and_990_nl = and_dcpl_48 & and_dcpl_37 & and_dcpl_451;
  assign and_991_nl = and_dcpl_15 & (~ (fsm_output[6])) & and_dcpl_14 & and_dcpl_455;
  assign COMP_LOOP_mux1h_5_nl = MUX1HOT_v_5_9_2(5'b10010, 5'b10001, 5'b10000, 5'b01100,
      5'b10100, 5'b01101, 5'b10101, 5'b01010, 5'b00001, {and_983_nl , and_984_nl
      , and_985_nl , and_986_nl , and_987_nl , and_988_nl , and_989_nl , and_990_nl
      , and_991_nl});
  assign nl_acc_1_nl = ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[14:1])) , 1'b1}) +
      conv_u2u_15_16({COMP_LOOP_k_14_5_sva_8_0 , COMP_LOOP_mux1h_5_nl , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[15:0];
  assign z_out_12_14 = readslicef_16_1_15(acc_1_nl);
  assign VEC_LOOP_mux_5_nl = MUX_v_18_2_2((z_out_21[31:14]), ({3'b000 , z_out_23
      , 5'b00000}), and_606_cse);
  assign VEC_LOOP_or_68_nl = (~(nor_175_cse & and_dcpl_14 & and_dcpl_12 & (fsm_output[1:0]==2'b01)))
      | and_606_cse;
  assign VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl = ~(MUX_v_14_2_2(14'b00000000000000,
      (STAGE_LOOP_lshift_psp_sva[14:1]), and_606_cse));
  assign nl_acc_2_nl = conv_u2u_19_20({VEC_LOOP_mux_5_nl , VEC_LOOP_or_68_nl}) +
      conv_s2u_16_20({1'b1 , VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[19:0];
  assign z_out_13_18_14 = readslicef_20_5_15(acc_2_nl);
  assign STAGE_LOOP_mux_4_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (~ STAGE_LOOP_i_3_0_sva),
      and_dcpl_547);
  assign nl_z_out_14 = STAGE_LOOP_mux_4_nl + conv_s2u_2_4({and_dcpl_547 , 1'b1});
  assign z_out_14 = nl_z_out_14[3:0];
  assign and_992_nl = and_dcpl_181 & (~ (fsm_output[8])) & and_dcpl_14 & and_dcpl_550;
  assign VEC_LOOP_mux1h_47_nl = MUX1HOT_v_10_3_2(({(z_out_23[8:0]) , (STAGE_LOOP_lshift_psp_sva[5])}),
      z_out_23, (z_out_19[13:4]), {and_992_nl , and_634_cse , VEC_LOOP_or_42_ssc});
  assign VEC_LOOP_VEC_LOOP_mux_16_nl = MUX_v_4_2_2((STAGE_LOOP_lshift_psp_sva[4:1]),
      (z_out_19[3:0]), VEC_LOOP_or_42_ssc);
  assign VEC_LOOP_or_69_nl = and_634_cse | and_dcpl_568 | and_dcpl_574;
  assign VEC_LOOP_mux_6_nl = MUX_v_14_2_2((COMP_LOOP_twiddle_f_17_sva[13:0]), VEC_LOOP_acc_1_cse_10_sva,
      VEC_LOOP_or_69_nl);
  assign nl_z_out_15 = ({VEC_LOOP_mux1h_47_nl , VEC_LOOP_VEC_LOOP_mux_16_nl}) + VEC_LOOP_mux_6_nl;
  assign z_out_15 = nl_z_out_15[13:0];
  assign and_993_nl = and_dcpl_16 & and_dcpl_14 & and_dcpl_25;
  assign and_994_nl = and_dcpl_16 & and_dcpl_29 & and_dcpl_28;
  assign and_995_nl = and_dcpl_16 & and_dcpl_44 & and_dcpl_43;
  assign and_996_nl = and_dcpl_48 & and_dcpl_37 & and_dcpl_28;
  assign and_997_nl = and_dcpl_65 & and_dcpl_14 & and_dcpl_43;
  assign and_998_nl = and_dcpl_65 & and_dcpl_37 & and_dcpl_25;
  assign and_999_nl = and_dcpl_65 & and_dcpl_44 & and_dcpl_28;
  assign and_1000_nl = and_dcpl_77 & and_dcpl_14 & and_dcpl_40;
  assign and_1001_nl = and_dcpl_77 & and_dcpl_44 & and_dcpl_13;
  assign and_1002_nl = and_dcpl_635 & and_dcpl_14 & and_dcpl_28;
  assign and_1003_nl = and_dcpl_635 & and_dcpl_29 & and_dcpl_40;
  assign and_1004_nl = and_dcpl_635 & and_dcpl_37 & and_dcpl_43;
  assign VEC_LOOP_mux1h_48_nl = MUX1HOT_v_5_24_2(5'b00001, 5'b00010, 5'b00011, 5'b00100,
      5'b00101, 5'b00110, 5'b00111, 5'b01000, 5'b01001, 5'b01010, 5'b01011, 5'b01100,
      5'b01101, 5'b01110, 5'b01111, 5'b10001, 5'b10010, 5'b10100, 5'b10110, 5'b11000,
      5'b11010, 5'b11100, 5'b11101, 5'b11110, {and_993_nl , and_994_nl , and_dcpl_39
      , and_dcpl_41 , and_995_nl , and_dcpl_50 , and_dcpl_51 , and_dcpl_53 , and_dcpl_58
      , and_996_nl , and_dcpl_62 , and_dcpl_63 , and_997_nl , and_dcpl_69 , and_dcpl_70
      , and_998_nl , and_999_nl , and_1000_nl , and_937_cse , and_1001_nl , and_1002_nl
      , and_1003_nl , and_1004_nl , and_943_cse});
  assign nl_z_out_16 = ({COMP_LOOP_k_14_5_sva_8_0 , VEC_LOOP_mux1h_48_nl}) + (STAGE_LOOP_lshift_psp_sva[14:1]);
  assign z_out_16 = nl_z_out_16[13:0];
  assign and_1005_nl = and_dcpl_468 & and_dcpl_37 & and_dcpl_653;
  assign and_1006_nl = and_dcpl_468 & and_dcpl_44 & and_dcpl_658;
  assign and_1007_nl = and_dcpl_472 & and_dcpl_14 & and_dcpl_377;
  assign and_1008_nl = and_dcpl_472 & and_dcpl_29 & and_dcpl_646;
  assign and_1009_nl = and_dcpl_472 & and_dcpl_44 & and_dcpl_653;
  assign and_1010_nl = and_dcpl_265 & and_dcpl_14 & and_dcpl_658;
  assign and_1011_nl = and_dcpl_265 & and_dcpl_29 & and_dcpl_377;
  assign and_1012_nl = and_dcpl_265 & and_dcpl_37 & and_dcpl_646;
  assign and_1013_nl = and_dcpl_337 & and_dcpl_14 & and_dcpl_653;
  assign and_1014_nl = and_dcpl_337 & and_dcpl_29 & and_dcpl_658;
  assign and_1015_nl = and_dcpl_337 & and_dcpl_37 & and_dcpl_377;
  assign and_1016_nl = and_dcpl_337 & and_dcpl_44 & and_dcpl_646;
  assign and_1017_nl = and_dcpl_436 & and_dcpl_37 & and_dcpl_658;
  assign VEC_LOOP_mux1h_49_nl = MUX1HOT_v_4_14_2(4'b1110, 4'b1101, 4'b1100, 4'b1011,
      4'b1010, 4'b1001, 4'b1000, 4'b0111, 4'b0110, 4'b0101, 4'b0100, 4'b0011, 4'b0010,
      4'b0001, {and_1005_nl , and_1006_nl , and_1007_nl , and_1008_nl , and_1009_nl
      , and_1010_nl , and_1011_nl , and_1012_nl , and_1013_nl , and_1014_nl , and_1015_nl
      , and_1016_nl , and_767_itm , and_1017_nl});
  assign and_1018_nl = and_dcpl_468 & and_dcpl_14 & and_dcpl_646;
  assign VEC_LOOP_nor_27_nl = ~(MUX_v_4_2_2(VEC_LOOP_mux1h_49_nl, 4'b1111, and_1018_nl));
  assign VEC_LOOP_or_70_nl = MUX_v_4_2_2(VEC_LOOP_nor_27_nl, 4'b1111, and_771_itm);
  assign nl_z_out_17 = VEC_LOOP_acc_1_cse_10_sva + ({COMP_LOOP_k_14_5_sva_8_0 , VEC_LOOP_or_70_nl
      , 1'b1});
  assign z_out_17 = nl_z_out_17[13:0];
  assign nl_z_out_18 = z_out_19 + VEC_LOOP_acc_1_cse_10_sva;
  assign z_out_18 = nl_z_out_18[13:0];
  assign and_1019_nl = and_dcpl_337 & (fsm_output[5:4]==2'b00) & and_dcpl_653;
  assign and_1020_nl = and_dcpl_337 & and_dcpl_29 & (fsm_output[3:2]==2'b01) & and_265_cse;
  assign and_1021_nl = and_dcpl_337 & (fsm_output[5:4]==2'b10) & and_dcpl_377;
  assign and_1022_nl = and_dcpl_337 & and_dcpl_44 & (fsm_output[3:2]==2'b11) & and_265_cse;
  assign VEC_LOOP_mux1h_50_nl = MUX1HOT_v_3_5_2(3'b001, 3'b010, 3'b011, 3'b100, 3'b101,
      {and_1019_nl , and_1020_nl , and_1021_nl , and_1022_nl , and_767_itm});
  assign VEC_LOOP_or_71_nl = MUX_v_3_2_2(VEC_LOOP_mux1h_50_nl, 3'b111, and_771_itm);
  assign nl_z_out_19 = ({COMP_LOOP_k_14_5_sva_8_0 , 1'b1 , VEC_LOOP_or_71_nl , 1'b1})
      + (STAGE_LOOP_lshift_psp_sva[14:1]);
  assign z_out_19 = nl_z_out_19[13:0];
  assign VEC_LOOP_VEC_LOOP_or_21_nl = ((VEC_LOOP_acc_1_cse_10_sva[13]) & (~(and_dcpl_775
      | and_dcpl_777 | and_dcpl_785))) | and_dcpl_782 | and_dcpl_787;
  assign VEC_LOOP_or_72_nl = and_dcpl_775 | and_dcpl_777;
  assign VEC_LOOP_or_73_nl = and_dcpl_782 | and_dcpl_787;
  assign VEC_LOOP_mux1h_51_nl = MUX1HOT_v_11_4_2((VEC_LOOP_acc_1_cse_10_sva[12:2]),
      (VEC_LOOP_acc_1_cse_10_sva[13:3]), (~ (STAGE_LOOP_lshift_psp_sva[14:4])), ({1'b1
      , (~ (STAGE_LOOP_lshift_psp_sva[14:5]))}), {VEC_LOOP_or_46_itm , VEC_LOOP_or_72_nl
      , VEC_LOOP_or_73_nl , and_dcpl_785});
  assign VEC_LOOP_or_74_nl = (~(and_dcpl_757 | and_dcpl_761 | and_dcpl_766 | and_dcpl_771
      | and_dcpl_775 | and_dcpl_777)) | and_dcpl_782 | and_dcpl_785 | and_dcpl_787;
  assign VEC_LOOP_and_24_nl = (COMP_LOOP_k_14_5_sva_8_0[8]) & (~(and_dcpl_775 | and_dcpl_777
      | and_dcpl_782 | and_dcpl_785 | and_dcpl_787));
  assign VEC_LOOP_or_75_nl = and_dcpl_775 | and_dcpl_777 | and_dcpl_782 | and_dcpl_787;
  assign VEC_LOOP_mux1h_52_nl = MUX1HOT_v_8_3_2((COMP_LOOP_k_14_5_sva_8_0[7:0]),
      (COMP_LOOP_k_14_5_sva_8_0[8:1]), ({1'b0 , (COMP_LOOP_k_14_5_sva_8_0[8:2])}),
      {VEC_LOOP_or_46_itm , VEC_LOOP_or_75_nl , and_dcpl_785});
  assign VEC_LOOP_VEC_LOOP_mux_17_nl = MUX_s_1_2_2((COMP_LOOP_k_14_5_sva_8_0[0]),
      (COMP_LOOP_k_14_5_sva_8_0[1]), and_dcpl_785);
  assign VEC_LOOP_or_76_nl = (VEC_LOOP_VEC_LOOP_mux_17_nl & (~(and_dcpl_757 | and_dcpl_761)))
      | and_dcpl_766 | and_dcpl_771;
  assign VEC_LOOP_VEC_LOOP_or_22_nl = ((COMP_LOOP_k_14_5_sva_8_0[0]) & (~(and_dcpl_757
      | and_dcpl_766 | and_dcpl_775 | and_dcpl_787))) | and_dcpl_761 | and_dcpl_771
      | and_dcpl_777 | and_dcpl_782;
  assign VEC_LOOP_VEC_LOOP_or_23_nl = (~(and_dcpl_782 | and_dcpl_787 | and_dcpl_785))
      | and_dcpl_757 | and_dcpl_761 | and_dcpl_766 | and_dcpl_771 | and_dcpl_775
      | and_dcpl_777;
  assign nl_acc_9_nl = ({VEC_LOOP_VEC_LOOP_or_21_nl , VEC_LOOP_mux1h_51_nl , VEC_LOOP_or_74_nl})
      + ({VEC_LOOP_and_24_nl , VEC_LOOP_mux1h_52_nl , VEC_LOOP_or_76_nl , VEC_LOOP_VEC_LOOP_or_22_nl
      , VEC_LOOP_VEC_LOOP_or_23_nl , 1'b1});
  assign acc_9_nl = nl_acc_9_nl[12:0];
  assign z_out_20 = readslicef_13_12_1(acc_9_nl);
  assign VEC_LOOP_mux_7_nl = MUX_v_32_2_2(COMP_LOOP_twiddle_f_17_sva, factor1_1_sva,
      nor_179_cse);
  assign VEC_LOOP_or_77_nl = (~(nor_175_cse & and_dcpl_14 & (fsm_output[3:0]==4'b0101)))
      | nor_179_cse;
  assign VEC_LOOP_mux_8_nl = MUX_v_32_2_2(({17'b00000000000000000 , STAGE_LOOP_lshift_psp_sva}),
      (~ COMP_LOOP_1_mult_cmp_return_rsc_z), nor_179_cse);
  assign nl_acc_10_nl = ({VEC_LOOP_mux_7_nl , VEC_LOOP_or_77_nl}) + ({VEC_LOOP_mux_8_nl
      , 1'b1});
  assign acc_10_nl = nl_acc_10_nl[32:0];
  assign z_out_21 = readslicef_33_32_1(acc_10_nl);
  assign VEC_LOOP_VEC_LOOP_or_24_nl = ((VEC_LOOP_acc_1_cse_10_sva[13]) & (~ and_dcpl_804))
      | and_dcpl_817;
  assign VEC_LOOP_mux1h_53_nl = MUX1HOT_v_9_3_2((COMP_LOOP_twiddle_f_17_sva[13:5]),
      (VEC_LOOP_acc_1_cse_10_sva[12:4]), (~ (STAGE_LOOP_lshift_psp_sva[14:6])), {and_dcpl_804
      , and_634_cse , and_dcpl_817});
  assign VEC_LOOP_or_78_nl = (~(and_dcpl_804 | and_634_cse)) | and_dcpl_817;
  assign VEC_LOOP_VEC_LOOP_and_2_nl = (COMP_LOOP_k_14_5_sva_8_0[8]) & (~(and_dcpl_804
      | and_dcpl_817));
  assign VEC_LOOP_VEC_LOOP_mux_18_nl = MUX_v_9_2_2(COMP_LOOP_k_14_5_sva_8_0, ({(COMP_LOOP_k_14_5_sva_8_0[7:0])
      , 1'b1}), and_634_cse);
  assign nl_acc_11_nl = ({VEC_LOOP_VEC_LOOP_or_24_nl , VEC_LOOP_mux1h_53_nl , VEC_LOOP_or_78_nl})
      + ({VEC_LOOP_VEC_LOOP_and_2_nl , VEC_LOOP_VEC_LOOP_mux_18_nl , 1'b1});
  assign acc_11_nl = nl_acc_11_nl[10:0];
  assign z_out_22 = readslicef_11_10_1(acc_11_nl);
  assign VEC_LOOP_VEC_LOOP_and_3_nl = (COMP_LOOP_k_14_5_sva_8_0[8]) & (~(and_dcpl_825
      | and_606_cse));
  assign VEC_LOOP_VEC_LOOP_mux_19_nl = MUX_v_9_2_2(COMP_LOOP_k_14_5_sva_8_0, ({(COMP_LOOP_k_14_5_sva_8_0[7:0])
      , 1'b1}), and_dcpl_830);
  assign VEC_LOOP_mux1h_54_nl = MUX1HOT_v_10_3_2(({1'b0 , (STAGE_LOOP_lshift_psp_sva[14:6])}),
      (STAGE_LOOP_lshift_psp_sva[14:5]), 10'b0000000001, {and_dcpl_825 , and_dcpl_830
      , and_606_cse});
  assign nl_z_out_23 = ({VEC_LOOP_VEC_LOOP_and_3_nl , VEC_LOOP_VEC_LOOP_mux_19_nl})
      + VEC_LOOP_mux1h_54_nl;
  assign z_out_23 = nl_z_out_23[9:0];
  assign VEC_LOOP_VEC_LOOP_or_25_nl = (VEC_LOOP_acc_1_cse_10_sva[13]) | and_dcpl_873
      | and_dcpl_875 | and_dcpl_877 | and_dcpl_879;
  assign VEC_LOOP_VEC_LOOP_mux_20_nl = MUX_v_12_2_2((VEC_LOOP_acc_1_cse_10_sva[12:1]),
      (~ (STAGE_LOOP_lshift_psp_sva[14:3])), VEC_LOOP_or_61_itm);
  assign VEC_LOOP_or_79_nl = (~(and_dcpl_844 | and_dcpl_850 | and_dcpl_853 | and_dcpl_857
      | and_dcpl_860 | and_937_cse | and_dcpl_867 | and_943_cse)) | and_dcpl_873
      | and_dcpl_875 | and_dcpl_877 | and_dcpl_879;
  assign VEC_LOOP_and_28_nl = (COMP_LOOP_k_14_5_sva_8_0[8]) & VEC_LOOP_nor_17_itm;
  assign VEC_LOOP_VEC_LOOP_mux_21_nl = MUX_v_8_2_2((COMP_LOOP_k_14_5_sva_8_0[7:0]),
      (COMP_LOOP_k_14_5_sva_8_0[8:1]), VEC_LOOP_or_61_itm);
  assign VEC_LOOP_or_80_nl = ((COMP_LOOP_k_14_5_sva_8_0[0]) & (~(and_dcpl_844 | and_dcpl_850
      | and_dcpl_853 | and_dcpl_857))) | and_dcpl_860 | and_937_cse | and_dcpl_867
      | and_943_cse;
  assign VEC_LOOP_VEC_LOOP_or_26_nl = (~(and_dcpl_844 | and_dcpl_850 | and_dcpl_860
      | and_937_cse | and_dcpl_877 | and_dcpl_879)) | and_dcpl_853 | and_dcpl_857
      | and_dcpl_867 | and_943_cse | and_dcpl_873 | and_dcpl_875;
  assign VEC_LOOP_VEC_LOOP_or_27_nl = (~(and_dcpl_844 | and_dcpl_853 | and_dcpl_860
      | and_dcpl_867 | and_dcpl_875 | and_dcpl_879)) | and_dcpl_850 | and_dcpl_857
      | and_937_cse | and_943_cse | and_dcpl_873 | and_dcpl_877;
  assign VEC_LOOP_VEC_LOOP_or_28_nl = VEC_LOOP_nor_17_itm | and_dcpl_844 | and_dcpl_850
      | and_dcpl_853 | and_dcpl_857 | and_dcpl_860 | and_937_cse | and_dcpl_867 |
      and_943_cse;
  assign nl_acc_13_nl = ({VEC_LOOP_VEC_LOOP_or_25_nl , VEC_LOOP_VEC_LOOP_mux_20_nl
      , VEC_LOOP_or_79_nl}) + ({VEC_LOOP_and_28_nl , VEC_LOOP_VEC_LOOP_mux_21_nl
      , VEC_LOOP_or_80_nl , VEC_LOOP_VEC_LOOP_or_26_nl , VEC_LOOP_VEC_LOOP_or_27_nl
      , VEC_LOOP_VEC_LOOP_or_28_nl , 1'b1});
  assign acc_13_nl = nl_acc_13_nl[13:0];
  assign z_out_24 = readslicef_14_13_1(acc_13_nl);

  function automatic [0:0] MUX1HOT_s_1_29_2;
    input [0:0] input_28;
    input [0:0] input_27;
    input [0:0] input_26;
    input [0:0] input_25;
    input [0:0] input_24;
    input [0:0] input_23;
    input [0:0] input_22;
    input [0:0] input_21;
    input [0:0] input_20;
    input [0:0] input_19;
    input [0:0] input_18;
    input [0:0] input_17;
    input [0:0] input_16;
    input [0:0] input_15;
    input [0:0] input_14;
    input [0:0] input_13;
    input [0:0] input_12;
    input [0:0] input_11;
    input [0:0] input_10;
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
    input [28:0] sel;
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
    result = result | ( input_10 & {1{sel[10]}});
    result = result | ( input_11 & {1{sel[11]}});
    result = result | ( input_12 & {1{sel[12]}});
    result = result | ( input_13 & {1{sel[13]}});
    result = result | ( input_14 & {1{sel[14]}});
    result = result | ( input_15 & {1{sel[15]}});
    result = result | ( input_16 & {1{sel[16]}});
    result = result | ( input_17 & {1{sel[17]}});
    result = result | ( input_18 & {1{sel[18]}});
    result = result | ( input_19 & {1{sel[19]}});
    result = result | ( input_20 & {1{sel[20]}});
    result = result | ( input_21 & {1{sel[21]}});
    result = result | ( input_22 & {1{sel[22]}});
    result = result | ( input_23 & {1{sel[23]}});
    result = result | ( input_24 & {1{sel[24]}});
    result = result | ( input_25 & {1{sel[25]}});
    result = result | ( input_26 & {1{sel[26]}});
    result = result | ( input_27 & {1{sel[27]}});
    result = result | ( input_28 & {1{sel[28]}});
    MUX1HOT_s_1_29_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_30_2;
    input [0:0] input_29;
    input [0:0] input_28;
    input [0:0] input_27;
    input [0:0] input_26;
    input [0:0] input_25;
    input [0:0] input_24;
    input [0:0] input_23;
    input [0:0] input_22;
    input [0:0] input_21;
    input [0:0] input_20;
    input [0:0] input_19;
    input [0:0] input_18;
    input [0:0] input_17;
    input [0:0] input_16;
    input [0:0] input_15;
    input [0:0] input_14;
    input [0:0] input_13;
    input [0:0] input_12;
    input [0:0] input_11;
    input [0:0] input_10;
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
    input [29:0] sel;
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
    result = result | ( input_10 & {1{sel[10]}});
    result = result | ( input_11 & {1{sel[11]}});
    result = result | ( input_12 & {1{sel[12]}});
    result = result | ( input_13 & {1{sel[13]}});
    result = result | ( input_14 & {1{sel[14]}});
    result = result | ( input_15 & {1{sel[15]}});
    result = result | ( input_16 & {1{sel[16]}});
    result = result | ( input_17 & {1{sel[17]}});
    result = result | ( input_18 & {1{sel[18]}});
    result = result | ( input_19 & {1{sel[19]}});
    result = result | ( input_20 & {1{sel[20]}});
    result = result | ( input_21 & {1{sel[21]}});
    result = result | ( input_22 & {1{sel[22]}});
    result = result | ( input_23 & {1{sel[23]}});
    result = result | ( input_24 & {1{sel[24]}});
    result = result | ( input_25 & {1{sel[25]}});
    result = result | ( input_26 & {1{sel[26]}});
    result = result | ( input_27 & {1{sel[27]}});
    result = result | ( input_28 & {1{sel[28]}});
    result = result | ( input_29 & {1{sel[29]}});
    MUX1HOT_s_1_30_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_31_2;
    input [0:0] input_30;
    input [0:0] input_29;
    input [0:0] input_28;
    input [0:0] input_27;
    input [0:0] input_26;
    input [0:0] input_25;
    input [0:0] input_24;
    input [0:0] input_23;
    input [0:0] input_22;
    input [0:0] input_21;
    input [0:0] input_20;
    input [0:0] input_19;
    input [0:0] input_18;
    input [0:0] input_17;
    input [0:0] input_16;
    input [0:0] input_15;
    input [0:0] input_14;
    input [0:0] input_13;
    input [0:0] input_12;
    input [0:0] input_11;
    input [0:0] input_10;
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
    input [30:0] sel;
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
    result = result | ( input_10 & {1{sel[10]}});
    result = result | ( input_11 & {1{sel[11]}});
    result = result | ( input_12 & {1{sel[12]}});
    result = result | ( input_13 & {1{sel[13]}});
    result = result | ( input_14 & {1{sel[14]}});
    result = result | ( input_15 & {1{sel[15]}});
    result = result | ( input_16 & {1{sel[16]}});
    result = result | ( input_17 & {1{sel[17]}});
    result = result | ( input_18 & {1{sel[18]}});
    result = result | ( input_19 & {1{sel[19]}});
    result = result | ( input_20 & {1{sel[20]}});
    result = result | ( input_21 & {1{sel[21]}});
    result = result | ( input_22 & {1{sel[22]}});
    result = result | ( input_23 & {1{sel[23]}});
    result = result | ( input_24 & {1{sel[24]}});
    result = result | ( input_25 & {1{sel[25]}});
    result = result | ( input_26 & {1{sel[26]}});
    result = result | ( input_27 & {1{sel[27]}});
    result = result | ( input_28 & {1{sel[28]}});
    result = result | ( input_29 & {1{sel[29]}});
    result = result | ( input_30 & {1{sel[30]}});
    MUX1HOT_s_1_31_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_32_2;
    input [0:0] input_31;
    input [0:0] input_30;
    input [0:0] input_29;
    input [0:0] input_28;
    input [0:0] input_27;
    input [0:0] input_26;
    input [0:0] input_25;
    input [0:0] input_24;
    input [0:0] input_23;
    input [0:0] input_22;
    input [0:0] input_21;
    input [0:0] input_20;
    input [0:0] input_19;
    input [0:0] input_18;
    input [0:0] input_17;
    input [0:0] input_16;
    input [0:0] input_15;
    input [0:0] input_14;
    input [0:0] input_13;
    input [0:0] input_12;
    input [0:0] input_11;
    input [0:0] input_10;
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
    input [31:0] sel;
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
    result = result | ( input_10 & {1{sel[10]}});
    result = result | ( input_11 & {1{sel[11]}});
    result = result | ( input_12 & {1{sel[12]}});
    result = result | ( input_13 & {1{sel[13]}});
    result = result | ( input_14 & {1{sel[14]}});
    result = result | ( input_15 & {1{sel[15]}});
    result = result | ( input_16 & {1{sel[16]}});
    result = result | ( input_17 & {1{sel[17]}});
    result = result | ( input_18 & {1{sel[18]}});
    result = result | ( input_19 & {1{sel[19]}});
    result = result | ( input_20 & {1{sel[20]}});
    result = result | ( input_21 & {1{sel[21]}});
    result = result | ( input_22 & {1{sel[22]}});
    result = result | ( input_23 & {1{sel[23]}});
    result = result | ( input_24 & {1{sel[24]}});
    result = result | ( input_25 & {1{sel[25]}});
    result = result | ( input_26 & {1{sel[26]}});
    result = result | ( input_27 & {1{sel[27]}});
    result = result | ( input_28 & {1{sel[28]}});
    result = result | ( input_29 & {1{sel[29]}});
    result = result | ( input_30 & {1{sel[30]}});
    result = result | ( input_31 & {1{sel[31]}});
    MUX1HOT_s_1_32_2 = result;
  end
  endfunction


  function automatic [0:0] MUX1HOT_s_1_33_2;
    input [0:0] input_32;
    input [0:0] input_31;
    input [0:0] input_30;
    input [0:0] input_29;
    input [0:0] input_28;
    input [0:0] input_27;
    input [0:0] input_26;
    input [0:0] input_25;
    input [0:0] input_24;
    input [0:0] input_23;
    input [0:0] input_22;
    input [0:0] input_21;
    input [0:0] input_20;
    input [0:0] input_19;
    input [0:0] input_18;
    input [0:0] input_17;
    input [0:0] input_16;
    input [0:0] input_15;
    input [0:0] input_14;
    input [0:0] input_13;
    input [0:0] input_12;
    input [0:0] input_11;
    input [0:0] input_10;
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
    input [32:0] sel;
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
    result = result | ( input_10 & {1{sel[10]}});
    result = result | ( input_11 & {1{sel[11]}});
    result = result | ( input_12 & {1{sel[12]}});
    result = result | ( input_13 & {1{sel[13]}});
    result = result | ( input_14 & {1{sel[14]}});
    result = result | ( input_15 & {1{sel[15]}});
    result = result | ( input_16 & {1{sel[16]}});
    result = result | ( input_17 & {1{sel[17]}});
    result = result | ( input_18 & {1{sel[18]}});
    result = result | ( input_19 & {1{sel[19]}});
    result = result | ( input_20 & {1{sel[20]}});
    result = result | ( input_21 & {1{sel[21]}});
    result = result | ( input_22 & {1{sel[22]}});
    result = result | ( input_23 & {1{sel[23]}});
    result = result | ( input_24 & {1{sel[24]}});
    result = result | ( input_25 & {1{sel[25]}});
    result = result | ( input_26 & {1{sel[26]}});
    result = result | ( input_27 & {1{sel[27]}});
    result = result | ( input_28 & {1{sel[28]}});
    result = result | ( input_29 & {1{sel[29]}});
    result = result | ( input_30 & {1{sel[30]}});
    result = result | ( input_31 & {1{sel[31]}});
    result = result | ( input_32 & {1{sel[32]}});
    MUX1HOT_s_1_33_2 = result;
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


  function automatic [9:0] MUX1HOT_v_10_7_2;
    input [9:0] input_6;
    input [9:0] input_5;
    input [9:0] input_4;
    input [9:0] input_3;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [6:0] sel;
    reg [9:0] result;
  begin
    result = input_0 & {10{sel[0]}};
    result = result | ( input_1 & {10{sel[1]}});
    result = result | ( input_2 & {10{sel[2]}});
    result = result | ( input_3 & {10{sel[3]}});
    result = result | ( input_4 & {10{sel[4]}});
    result = result | ( input_5 & {10{sel[5]}});
    result = result | ( input_6 & {10{sel[6]}});
    MUX1HOT_v_10_7_2 = result;
  end
  endfunction


  function automatic [10:0] MUX1HOT_v_11_4_2;
    input [10:0] input_3;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [3:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | ( input_1 & {11{sel[1]}});
    result = result | ( input_2 & {11{sel[2]}});
    result = result | ( input_3 & {11{sel[3]}});
    MUX1HOT_v_11_4_2 = result;
  end
  endfunction


  function automatic [13:0] MUX1HOT_v_14_26_2;
    input [13:0] input_25;
    input [13:0] input_24;
    input [13:0] input_23;
    input [13:0] input_22;
    input [13:0] input_21;
    input [13:0] input_20;
    input [13:0] input_19;
    input [13:0] input_18;
    input [13:0] input_17;
    input [13:0] input_16;
    input [13:0] input_15;
    input [13:0] input_14;
    input [13:0] input_13;
    input [13:0] input_12;
    input [13:0] input_11;
    input [13:0] input_10;
    input [13:0] input_9;
    input [13:0] input_8;
    input [13:0] input_7;
    input [13:0] input_6;
    input [13:0] input_5;
    input [13:0] input_4;
    input [13:0] input_3;
    input [13:0] input_2;
    input [13:0] input_1;
    input [13:0] input_0;
    input [25:0] sel;
    reg [13:0] result;
  begin
    result = input_0 & {14{sel[0]}};
    result = result | ( input_1 & {14{sel[1]}});
    result = result | ( input_2 & {14{sel[2]}});
    result = result | ( input_3 & {14{sel[3]}});
    result = result | ( input_4 & {14{sel[4]}});
    result = result | ( input_5 & {14{sel[5]}});
    result = result | ( input_6 & {14{sel[6]}});
    result = result | ( input_7 & {14{sel[7]}});
    result = result | ( input_8 & {14{sel[8]}});
    result = result | ( input_9 & {14{sel[9]}});
    result = result | ( input_10 & {14{sel[10]}});
    result = result | ( input_11 & {14{sel[11]}});
    result = result | ( input_12 & {14{sel[12]}});
    result = result | ( input_13 & {14{sel[13]}});
    result = result | ( input_14 & {14{sel[14]}});
    result = result | ( input_15 & {14{sel[15]}});
    result = result | ( input_16 & {14{sel[16]}});
    result = result | ( input_17 & {14{sel[17]}});
    result = result | ( input_18 & {14{sel[18]}});
    result = result | ( input_19 & {14{sel[19]}});
    result = result | ( input_20 & {14{sel[20]}});
    result = result | ( input_21 & {14{sel[21]}});
    result = result | ( input_22 & {14{sel[22]}});
    result = result | ( input_23 & {14{sel[23]}});
    result = result | ( input_24 & {14{sel[24]}});
    result = result | ( input_25 & {14{sel[25]}});
    MUX1HOT_v_14_26_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_9_2;
    input [1:0] input_8;
    input [1:0] input_7;
    input [1:0] input_6;
    input [1:0] input_5;
    input [1:0] input_4;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [8:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | ( input_1 & {2{sel[1]}});
    result = result | ( input_2 & {2{sel[2]}});
    result = result | ( input_3 & {2{sel[3]}});
    result = result | ( input_4 & {2{sel[4]}});
    result = result | ( input_5 & {2{sel[5]}});
    result = result | ( input_6 & {2{sel[6]}});
    result = result | ( input_7 & {2{sel[7]}});
    result = result | ( input_8 & {2{sel[8]}});
    MUX1HOT_v_2_9_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_3_2;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [2:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    MUX1HOT_v_32_3_2 = result;
  end
  endfunction


  function automatic [31:0] MUX1HOT_v_32_4_2;
    input [31:0] input_3;
    input [31:0] input_2;
    input [31:0] input_1;
    input [31:0] input_0;
    input [3:0] sel;
    reg [31:0] result;
  begin
    result = input_0 & {32{sel[0]}};
    result = result | ( input_1 & {32{sel[1]}});
    result = result | ( input_2 & {32{sel[2]}});
    result = result | ( input_3 & {32{sel[3]}});
    MUX1HOT_v_32_4_2 = result;
  end
  endfunction


  function automatic [2:0] MUX1HOT_v_3_5_2;
    input [2:0] input_4;
    input [2:0] input_3;
    input [2:0] input_2;
    input [2:0] input_1;
    input [2:0] input_0;
    input [4:0] sel;
    reg [2:0] result;
  begin
    result = input_0 & {3{sel[0]}};
    result = result | ( input_1 & {3{sel[1]}});
    result = result | ( input_2 & {3{sel[2]}});
    result = result | ( input_3 & {3{sel[3]}});
    result = result | ( input_4 & {3{sel[4]}});
    MUX1HOT_v_3_5_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_14_2;
    input [3:0] input_13;
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
    input [13:0] sel;
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
    result = result | ( input_13 & {4{sel[13]}});
    MUX1HOT_v_4_14_2 = result;
  end
  endfunction


  function automatic [3:0] MUX1HOT_v_4_4_2;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [3:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | ( input_1 & {4{sel[1]}});
    result = result | ( input_2 & {4{sel[2]}});
    result = result | ( input_3 & {4{sel[3]}});
    MUX1HOT_v_4_4_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_24_2;
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
    input [23:0] sel;
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
    MUX1HOT_v_5_24_2 = result;
  end
  endfunction


  function automatic [4:0] MUX1HOT_v_5_9_2;
    input [4:0] input_8;
    input [4:0] input_7;
    input [4:0] input_6;
    input [4:0] input_5;
    input [4:0] input_4;
    input [4:0] input_3;
    input [4:0] input_2;
    input [4:0] input_1;
    input [4:0] input_0;
    input [8:0] sel;
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
    MUX1HOT_v_5_9_2 = result;
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


  function automatic [8:0] MUX1HOT_v_9_34_2;
    input [8:0] input_33;
    input [8:0] input_32;
    input [8:0] input_31;
    input [8:0] input_30;
    input [8:0] input_29;
    input [8:0] input_28;
    input [8:0] input_27;
    input [8:0] input_26;
    input [8:0] input_25;
    input [8:0] input_24;
    input [8:0] input_23;
    input [8:0] input_22;
    input [8:0] input_21;
    input [8:0] input_20;
    input [8:0] input_19;
    input [8:0] input_18;
    input [8:0] input_17;
    input [8:0] input_16;
    input [8:0] input_15;
    input [8:0] input_14;
    input [8:0] input_13;
    input [8:0] input_12;
    input [8:0] input_11;
    input [8:0] input_10;
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
    input [33:0] sel;
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
    result = result | ( input_10 & {9{sel[10]}});
    result = result | ( input_11 & {9{sel[11]}});
    result = result | ( input_12 & {9{sel[12]}});
    result = result | ( input_13 & {9{sel[13]}});
    result = result | ( input_14 & {9{sel[14]}});
    result = result | ( input_15 & {9{sel[15]}});
    result = result | ( input_16 & {9{sel[16]}});
    result = result | ( input_17 & {9{sel[17]}});
    result = result | ( input_18 & {9{sel[18]}});
    result = result | ( input_19 & {9{sel[19]}});
    result = result | ( input_20 & {9{sel[20]}});
    result = result | ( input_21 & {9{sel[21]}});
    result = result | ( input_22 & {9{sel[22]}});
    result = result | ( input_23 & {9{sel[23]}});
    result = result | ( input_24 & {9{sel[24]}});
    result = result | ( input_25 & {9{sel[25]}});
    result = result | ( input_26 & {9{sel[26]}});
    result = result | ( input_27 & {9{sel[27]}});
    result = result | ( input_28 & {9{sel[28]}});
    result = result | ( input_29 & {9{sel[29]}});
    result = result | ( input_30 & {9{sel[30]}});
    result = result | ( input_31 & {9{sel[31]}});
    result = result | ( input_32 & {9{sel[32]}});
    result = result | ( input_33 & {9{sel[33]}});
    MUX1HOT_v_9_34_2 = result;
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


  function automatic [10:0] MUX_v_11_2_2;
    input [10:0] input_0;
    input [10:0] input_1;
    input [0:0] sel;
    reg [10:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_11_2_2 = result;
  end
  endfunction


  function automatic [11:0] MUX_v_12_2_2;
    input [11:0] input_0;
    input [11:0] input_1;
    input [0:0] sel;
    reg [11:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_12_2_2 = result;
  end
  endfunction


  function automatic [12:0] MUX_v_13_2_2;
    input [12:0] input_0;
    input [12:0] input_1;
    input [0:0] sel;
    reg [12:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_13_2_2 = result;
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


  function automatic [17:0] MUX_v_18_2_2;
    input [17:0] input_0;
    input [17:0] input_1;
    input [0:0] sel;
    reg [17:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_18_2_2 = result;
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


  function automatic [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
  end
  endfunction


  function automatic [11:0] readslicef_13_12_1;
    input [12:0] vector;
    reg [12:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_13_12_1 = tmp[11:0];
  end
  endfunction


  function automatic [12:0] readslicef_14_13_1;
    input [13:0] vector;
    reg [13:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_14_13_1 = tmp[12:0];
  end
  endfunction


  function automatic [14:0] readslicef_16_15_1;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_16_15_1 = tmp[14:0];
  end
  endfunction


  function automatic [0:0] readslicef_16_1_15;
    input [15:0] vector;
    reg [15:0] tmp;
  begin
    tmp = vector >> 15;
    readslicef_16_1_15 = tmp[0:0];
  end
  endfunction


  function automatic [4:0] readslicef_20_5_15;
    input [19:0] vector;
    reg [19:0] tmp;
  begin
    tmp = vector >> 15;
    readslicef_20_5_15 = tmp[4:0];
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


  function automatic [0:0] readslicef_5_1_4;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 4;
    readslicef_5_1_4 = tmp[0:0];
  end
  endfunction


  function automatic [3:0] conv_s2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_4 = {{2{vector[1]}}, vector};
  end
  endfunction


  function automatic [19:0] conv_s2u_16_20 ;
    input [15:0]  vector ;
  begin
    conv_s2u_16_20 = {{4{vector[15]}}, vector};
  end
  endfunction


  function automatic [15:0] conv_u2u_15_16 ;
    input [14:0]  vector ;
  begin
    conv_u2u_15_16 = {1'b0, vector};
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
  wire [27:0] twiddle_rsci_adra_d;
  wire [63:0] twiddle_rsci_qa_d;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [27:0] twiddle_h_rsci_adra_d;
  wire [63:0] twiddle_h_rsci_qa_d;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations for Component Instantiations 
  wire [63:0] nl_vec_rsci_da_d;
  assign nl_vec_rsci_da_d = {32'b00000000000000000000000000000000 , vec_rsci_da_d};
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
      .adra_d(twiddle_rsci_adra_d),
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



