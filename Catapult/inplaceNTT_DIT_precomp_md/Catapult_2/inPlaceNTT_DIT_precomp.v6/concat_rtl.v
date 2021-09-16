
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
//  Generated date: Thu Sep 16 13:27:59 2021
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
  wire [7:0] fsm_output;
  wire nor_tmp_4;
  wire mux_tmp_99;
  wire nor_tmp_14;
  wire or_dcpl_68;
  wire or_tmp_58;
  wire mux_tmp_121;
  wire mux_tmp_122;
  wire or_tmp_60;
  wire mux_tmp_123;
  wire or_tmp_61;
  wire or_tmp_63;
  wire mux_tmp_141;
  wire mux_tmp_142;
  wire mux_tmp_143;
  wire and_dcpl_17;
  wire and_dcpl_18;
  wire and_dcpl_19;
  wire and_dcpl_21;
  wire and_dcpl_22;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire mux_tmp_150;
  wire or_tmp_78;
  wire or_tmp_81;
  wire mux_tmp_153;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire nor_tmp_20;
  wire mux_tmp_162;
  wire mux_tmp_163;
  wire mux_tmp_164;
  wire mux_tmp_165;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire mux_tmp_168;
  wire and_dcpl_39;
  wire and_dcpl_40;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire and_dcpl_43;
  wire and_dcpl_47;
  wire and_dcpl_48;
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_56;
  wire and_dcpl_57;
  wire and_dcpl_58;
  wire and_dcpl_59;
  wire and_dcpl_60;
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
  wire and_dcpl_75;
  wire or_tmp_96;
  wire and_dcpl_80;
  wire or_tmp_101;
  wire or_tmp_112;
  wire or_tmp_114;
  wire or_tmp_116;
  wire not_tmp_102;
  wire or_tmp_135;
  wire mux_tmp_205;
  wire or_tmp_136;
  wire and_dcpl_87;
  wire xor_dcpl;
  wire and_dcpl_103;
  wire or_tmp_143;
  wire mux_tmp_217;
  wire or_tmp_148;
  wire mux_tmp_218;
  wire and_dcpl_107;
  wire and_dcpl_108;
  wire and_dcpl_121;
  wire mux_tmp_244;
  wire mux_tmp_245;
  wire or_tmp_173;
  wire mux_tmp_253;
  wire mux_tmp_256;
  wire mux_tmp_257;
  wire or_tmp_185;
  wire mux_tmp_268;
  wire or_tmp_197;
  wire mux_tmp_279;
  wire or_tmp_214;
  wire mux_tmp_300;
  wire mux_tmp_360;
  wire and_dcpl_148;
  wire or_tmp_272;
  wire or_tmp_273;
  wire or_tmp_275;
  wire or_tmp_280;
  wire mux_tmp_373;
  wire mux_tmp_374;
  wire mux_tmp_402;
  wire mux_tmp_403;
  wire mux_tmp_404;
  wire mux_tmp_405;
  wire mux_tmp_406;
  reg COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  reg [14:0] STAGE_LOOP_lshift_psp_sva;
  reg [14:0] VEC_LOOP_j_10_14_0_sva_1;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  wire or_179_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_2_cse;
  wire or_119_cse;
  wire or_116_cse;
  wire and_169_cse;
  wire or_172_cse;
  wire or_173_cse;
  wire and_164_cse;
  wire or_199_cse;
  wire or_98_cse;
  wire or_97_cse;
  wire or_24_cse;
  wire or_193_cse;
  wire or_248_cse;
  wire and_159_cse;
  wire nor_55_cse;
  wire or_377_cse;
  wire or_388_cse;
  wire or_237_cse;
  wire or_238_cse;
  wire or_127_cse;
  wire and_158_cse;
  wire or_392_cse;
  wire and_176_cse;
  wire mux_135_cse;
  wire mux_389_cse;
  wire mux_388_cse;
  wire mux_151_cse;
  wire or_251_cse;
  wire or_400_cse;
  wire mux_145_cse;
  wire mux_155_cse;
  wire nand_2_cse;
  wire or_397_cse;
  wire or_259_cse;
  wire or_145_cse;
  wire mux_224_cse;
  wire or_154_cse;
  wire mux_239_cse;
  wire mux_156_cse;
  wire mux_237_cse;
  wire nor_88_cse;
  wire mux_240_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [13:0] twiddle_rsci_adra_d_reg;
  wire [9:0] COMP_LOOP_twiddle_f_mux1h_60_rmff;
  wire COMP_LOOP_twiddle_f_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_15_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_44_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_69_rmff;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire nor_84_rmff;
  wire [13:0] twiddle_h_rsci_adra_d_reg;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_123_rmff;
  reg [31:0] factor1_1_sva;
  reg [31:0] VEC_LOOP_mult_vec_1_sva;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [13:0] VEC_LOOP_acc_10_cse_1_sva;
  reg [10:0] COMP_LOOP_9_twiddle_f_lshift_itm;
  reg [31:0] VEC_LOOP_j_1_sva;
  reg [31:0] p_sva;
  wire mux_140_itm;
  wire mux_241_itm;
  wire mux_265_itm;
  wire and_dcpl_155;
  wire and_dcpl_156;
  wire and_dcpl_164;
  wire [14:0] z_out;
  wire and_dcpl_181;
  wire [3:0] z_out_1;
  wire [4:0] nl_z_out_1;
  wire and_dcpl_193;
  wire [13:0] z_out_2;
  wire [14:0] nl_z_out_2;
  wire and_dcpl_194;
  wire and_dcpl_196;
  wire and_dcpl_201;
  wire and_dcpl_202;
  wire and_dcpl_207;
  wire and_dcpl_208;
  wire and_dcpl_212;
  wire and_dcpl_213;
  wire and_dcpl_215;
  wire and_dcpl_216;
  wire and_dcpl_220;
  wire and_dcpl_223;
  wire and_dcpl_224;
  wire and_dcpl_226;
  wire and_dcpl_229;
  wire and_dcpl_238;
  wire [13:0] z_out_3;
  wire [14:0] nl_z_out_3;
  wire [13:0] z_out_7;
  wire [14:0] nl_z_out_7;
  wire and_dcpl_369;
  wire and_dcpl_370;
  wire or_tmp_306;
  wire mux_tmp_419;
  wire not_tmp_282;
  wire and_dcpl_371;
  wire and_dcpl_372;
  wire and_dcpl_374;
  wire and_dcpl_378;
  wire and_dcpl_379;
  wire and_dcpl_381;
  wire and_dcpl_383;
  wire and_dcpl_384;
  wire and_dcpl_388;
  wire and_dcpl_389;
  wire and_dcpl_391;
  wire and_dcpl_392;
  wire and_dcpl_394;
  wire and_dcpl_398;
  wire and_dcpl_400;
  wire and_dcpl_403;
  wire and_dcpl_405;
  wire and_dcpl_407;
  wire and_dcpl_408;
  wire and_dcpl_410;
  wire [18:0] z_out_12;
  wire or_tmp_313;
  wire mux_tmp_429;
  wire mux_tmp_430;
  wire mux_tmp_431;
  wire and_dcpl_418;
  wire [31:0] z_out_13;
  wire and_dcpl_425;
  wire and_dcpl_430;
  wire and_dcpl_435;
  wire and_dcpl_439;
  wire and_dcpl_444;
  wire and_dcpl_448;
  wire [11:0] z_out_14;
  wire [10:0] z_out_15;
  wire [11:0] nl_z_out_15;
  wire and_dcpl_471;
  wire and_dcpl_475;
  wire and_dcpl_479;
  wire and_dcpl_482;
  wire and_dcpl_485;
  wire and_dcpl_488;
  wire and_dcpl_491;
  wire and_dcpl_494;
  wire [13:0] z_out_16;
  wire [27:0] nl_z_out_16;
  wire and_dcpl_501;
  wire and_dcpl_508;
  wire and_dcpl_511;
  wire and_dcpl_514;
  wire and_dcpl_518;
  wire and_dcpl_520;
  wire and_dcpl_523;
  wire and_dcpl_530;
  wire and_dcpl_536;
  wire and_dcpl_539;
  wire and_dcpl_540;
  wire and_dcpl_544;
  wire and_dcpl_547;
  wire and_dcpl_551;
  wire [12:0] z_out_18;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva;
  reg [31:0] VEC_LOOP_j_1_sva_1;
  reg [13:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [12:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva;
  reg [11:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva;
  reg [9:0] COMP_LOOP_k_14_4_sva_9_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire VEC_LOOP_j_1_sva_mx0c0;
  wire [13:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
  wire [12:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
  wire COMP_LOOP_twiddle_f_or_6_cse;
  wire COMP_LOOP_twiddle_f_or_10_cse;
  wire COMP_LOOP_twiddle_f_or_11_cse;
  wire VEC_LOOP_or_8_cse;
  wire VEC_LOOP_or_9_cse;
  wire VEC_LOOP_or_10_cse;
  wire VEC_LOOP_or_50_cse;
  wire VEC_LOOP_or_51_cse;
  wire VEC_LOOP_or_52_cse;
  wire VEC_LOOP_or_53_cse;
  wire VEC_LOOP_or_54_cse;
  wire VEC_LOOP_or_55_cse;
  wire nor_139_cse;
  wire and_196_cse;
  wire nor_126_cse;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire mux_tmp;
  wire not_tmp;
  wire or_tmp_321;
  wire nor_tmp;
  wire mux_tmp_443;
  wire or_tmp_326;
  wire mux_tmp_444;
  wire or_tmp_328;
  wire or_tmp_334;
  wire mux_tmp_455;
  wire or_tmp_335;
  wire not_tmp_344;
  wire or_tmp_336;
  wire mux_tmp_458;
  wire [13:0] VEC_LOOP_and_4_rgt;
  wire nor_tmp_51;
  wire or_tmp_347;
  wire [12:0] VEC_LOOP_VEC_LOOP_mux_2_rgt;
  reg VEC_LOOP_acc_11_psp_sva_12;
  reg [11:0] VEC_LOOP_acc_11_psp_sva_11_0;
  reg [3:0] reg_VEC_LOOP_acc_1_reg;
  reg [9:0] reg_VEC_LOOP_acc_1_1_reg;
  wire nor_45_cse_1;
  wire or_cse;
  wire nor_157_cse;
  wire nor_159_cse;
  wire or_272_cse;
  wire and_244_itm;
  wire and_254_itm;
  wire VEC_LOOP_nor_5_itm;
  wire VEC_LOOP_or_65_itm;
  wire VEC_LOOP_or_60_itm;
  wire VEC_LOOP_or_69_itm;
  wire COMP_LOOP_twiddle_f_or_16_itm;
  wire COMP_LOOP_twiddle_f_nor_2_itm;
  wire COMP_LOOP_twiddle_f_or_17_itm;
  wire VEC_LOOP_or_72_itm;
  wire VEC_LOOP_nor_15_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire and_280_cse;
  wire [12:0] z_out_17_12_0;
  wire [25:0] nl_z_out_17_12_0;
  wire [13:0] acc_3_cse_14_1;
  wire [14:0] nl_acc_3_cse_14_1;
  wire VEC_LOOP_or_84_cse;

  wire[0:0] mux_139_nl;
  wire[0:0] mux_138_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] or_136_nl;
  wire[0:0] or_135_nl;
  wire[0:0] mux_134_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] mux_131_nl;
  wire[0:0] mux_130_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] mux_128_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] nor_60_nl;
  wire[0:0] or_141_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] nor_59_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] mux_146_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] mux_212_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] or_211_nl;
  wire[0:0] or_209_nl;
  wire[0:0] mux_210_nl;
  wire[0:0] or_208_nl;
  wire[0:0] mux_209_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] mux_207_nl;
  wire[0:0] or_207_nl;
  wire[0:0] mux_206_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_15_nl;
  wire[0:0] mux_223_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[0:0] mux_219_nl;
  wire[0:0] nand_26_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_31_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl;
  wire[9:0] COMP_LOOP_1_twiddle_f_mul_nl;
  wire[19:0] nl_COMP_LOOP_1_twiddle_f_mul_nl;
  wire[0:0] and_110_nl;
  wire[0:0] mux_226_nl;
  wire[0:0] mux_225_nl;
  wire[0:0] nor_53_nl;
  wire[0:0] mux_238_nl;
  wire[0:0] nand_6_nl;
  wire[0:0] mux_236_nl;
  wire[0:0] mux_233_nl;
  wire[0:0] mux_232_nl;
  wire[0:0] mux_250_nl;
  wire[0:0] mux_249_nl;
  wire[0:0] or_241_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] or_240_nl;
  wire[0:0] mux_247_nl;
  wire[0:0] or_239_nl;
  wire[0:0] mux_246_nl;
  wire[0:0] nand_21_nl;
  wire[0:0] mux_264_nl;
  wire[0:0] mux_263_nl;
  wire[0:0] mux_262_nl;
  wire[0:0] mux_261_nl;
  wire[0:0] or_252_nl;
  wire[0:0] mux_260_nl;
  wire[0:0] mux_259_nl;
  wire[0:0] mux_258_nl;
  wire[0:0] nand_19_nl;
  wire[0:0] mux_269_nl;
  wire[0:0] or_258_nl;
  wire[0:0] mux_277_nl;
  wire[0:0] mux_276_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_441_nl;
  wire[0:0] mux_440_nl;
  wire[0:0] mux_439_nl;
  wire[0:0] mux_438_nl;
  wire[0:0] mux_284_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] mux_43_nl;
  wire[31:0] VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_j_not_1_nl;
  wire[0:0] mux_306_nl;
  wire[0:0] mux_305_nl;
  wire[0:0] mux_302_nl;
  wire[0:0] mux_301_nl;
  wire[0:0] VEC_LOOP_or_49_nl;
  wire[13:0] VEC_LOOP_mux1h_14_nl;
  wire[0:0] nor_91_nl;
  wire[0:0] mux_318_nl;
  wire[0:0] mux_317_nl;
  wire[0:0] VEC_LOOP_or_47_nl;
  wire[0:0] nor_82_nl;
  wire[0:0] mux_339_nl;
  wire[0:0] mux_338_nl;
  wire[0:0] mux_337_nl;
  wire[0:0] or_330_nl;
  wire[0:0] VEC_LOOP_nand_nl;
  wire[0:0] mux_455_nl;
  wire[0:0] mux_454_nl;
  wire[0:0] mux_453_nl;
  wire[0:0] mux_452_nl;
  wire[0:0] nand_40_nl;
  wire[0:0] or_437_nl;
  wire[0:0] mux_451_nl;
  wire[0:0] mux_450_nl;
  wire[0:0] or_435_nl;
  wire[0:0] mux_449_nl;
  wire[0:0] or_433_nl;
  wire[0:0] mux_448_nl;
  wire[0:0] mux_447_nl;
  wire[0:0] mux_446_nl;
  wire[0:0] or_430_nl;
  wire[0:0] or_429_nl;
  wire[0:0] mux_443_nl;
  wire[0:0] mux_442_nl;
  wire[0:0] nor_162_nl;
  wire[0:0] mux_472_nl;
  wire[0:0] mux_471_nl;
  wire[0:0] mux_470_nl;
  wire[0:0] mux_469_nl;
  wire[0:0] mux_468_nl;
  wire[0:0] mux_467_nl;
  wire[0:0] or_449_nl;
  wire[0:0] or_448_nl;
  wire[0:0] mux_466_nl;
  wire[0:0] mux_465_nl;
  wire[0:0] mux_464_nl;
  wire[0:0] or_447_nl;
  wire[0:0] mux_463_nl;
  wire[0:0] or_446_nl;
  wire[0:0] nor_153_nl;
  wire[0:0] or_445_nl;
  wire[0:0] mux_462_nl;
  wire[0:0] mux_461_nl;
  wire[0:0] nand_38_nl;
  wire[0:0] mux_460_nl;
  wire[0:0] mux_370_nl;
  wire[0:0] mux_369_nl;
  wire[0:0] nor_48_nl;
  wire[0:0] mux_368_nl;
  wire[0:0] mux_380_nl;
  wire[0:0] mux_379_nl;
  wire[0:0] mux_378_nl;
  wire[0:0] mux_377_nl;
  wire[0:0] or_368_nl;
  wire[0:0] mux_376_nl;
  wire[0:0] or_367_nl;
  wire[0:0] mux_375_nl;
  wire[0:0] or_366_nl;
  wire[0:0] mux_383_nl;
  wire[0:0] mux_382_nl;
  wire[0:0] mux_381_nl;
  wire[0:0] nor_47_nl;
  wire[0:0] mux_386_nl;
  wire[0:0] mux_385_nl;
  wire[0:0] mux_384_nl;
  wire[0:0] and_154_nl;
  wire[0:0] nor_46_nl;
  wire[0:0] mux_479_nl;
  wire[0:0] mux_478_nl;
  wire[0:0] mux_477_nl;
  wire[0:0] mux_476_nl;
  wire[0:0] or_455_nl;
  wire[0:0] mux_475_nl;
  wire[0:0] mux_474_nl;
  wire[0:0] or_454_nl;
  wire[0:0] nor_161_nl;
  wire[0:0] mux_473_nl;
  wire[0:0] or_451_nl;
  wire[0:0] or_450_nl;
  wire[0:0] mux_484_nl;
  wire[0:0] mux_483_nl;
  wire[0:0] mux_482_nl;
  wire[0:0] nor_156_nl;
  wire[0:0] mux_481_nl;
  wire[0:0] and_603_nl;
  wire[0:0] mux_480_nl;
  wire[0:0] nor_158_nl;
  wire[0:0] mux_401_nl;
  wire[0:0] mux_400_nl;
  wire[0:0] mux_399_nl;
  wire[0:0] mux_398_nl;
  wire[0:0] mux_397_nl;
  wire[0:0] mux_396_nl;
  wire[0:0] and_161_nl;
  wire[0:0] mux_414_nl;
  wire[0:0] mux_413_nl;
  wire[0:0] mux_412_nl;
  wire[0:0] mux_411_nl;
  wire[0:0] mux_410_nl;
  wire[0:0] mux_409_nl;
  wire[0:0] mux_408_nl;
  wire[0:0] mux_407_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] mux_112_nl;
  wire[0:0] nor_61_nl;
  wire[0:0] or_140_nl;
  wire[0:0] or_150_nl;
  wire[0:0] mux_152_nl;
  wire[0:0] or_157_nl;
  wire[0:0] nor_58_nl;
  wire[0:0] mux_167_nl;
  wire[0:0] mux_166_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] nor_56_nl;
  wire[0:0] nor_57_nl;
  wire[0:0] or_163_nl;
  wire[0:0] mux_169_nl;
  wire[0:0] or_161_nl;
  wire[0:0] mux_170_nl;
  wire[0:0] mux_171_nl;
  wire[0:0] or_165_nl;
  wire[0:0] mux_182_nl;
  wire[0:0] or_181_nl;
  wire[0:0] mux_204_nl;
  wire[0:0] mux_203_nl;
  wire[0:0] or_204_nl;
  wire[0:0] or_203_nl;
  wire[0:0] or_202_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] mux_215_nl;
  wire[0:0] or_384_nl;
  wire[0:0] or_217_nl;
  wire[0:0] mux_243_nl;
  wire[0:0] or_236_nl;
  wire[0:0] or_234_nl;
  wire[0:0] mux_255_nl;
  wire[0:0] mux_254_nl;
  wire[0:0] mux_252_nl;
  wire[0:0] or_243_nl;
  wire[0:0] or_254_nl;
  wire[0:0] mux_278_nl;
  wire[0:0] mux_299_nl;
  wire[0:0] or_289_nl;
  wire[0:0] or_346_nl;
  wire[0:0] mux_367_nl;
  wire[0:0] mux_366_nl;
  wire[0:0] mux_363_nl;
  wire[0:0] mux_372_nl;
  wire[0:0] mux_371_nl;
  wire[0:0] or_360_nl;
  wire[0:0] or_359_nl;
  wire[0:0] or_364_nl;
  wire[10:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_83_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_81_nl;
  wire[0:0] mux_173_nl;
  wire[0:0] mux_172_nl;
  wire[9:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_28_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] nor_87_nl;
  wire[0:0] mux_181_nl;
  wire[0:0] mux_180_nl;
  wire[0:0] mux_179_nl;
  wire[0:0] or_177_nl;
  wire[0:0] mux_178_nl;
  wire[0:0] mux_177_nl;
  wire[0:0] mux_176_nl;
  wire[0:0] mux_175_nl;
  wire[0:0] or_174_nl;
  wire[0:0] mux_174_nl;
  wire[0:0] or_169_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] nor_86_nl;
  wire[0:0] mux_190_nl;
  wire[0:0] mux_189_nl;
  wire[0:0] mux_188_nl;
  wire[0:0] mux_187_nl;
  wire[0:0] or_189_nl;
  wire[0:0] mux_186_nl;
  wire[0:0] or_188_nl;
  wire[0:0] mux_185_nl;
  wire[0:0] mux_184_nl;
  wire[0:0] or_183_nl;
  wire[0:0] mux_183_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] nor_85_nl;
  wire[0:0] mux_202_nl;
  wire[0:0] mux_201_nl;
  wire[0:0] mux_200_nl;
  wire[0:0] mux_199_nl;
  wire[0:0] or_201_nl;
  wire[0:0] nand_4_nl;
  wire[0:0] mux_198_nl;
  wire[0:0] mux_197_nl;
  wire[0:0] mux_196_nl;
  wire[0:0] mux_195_nl;
  wire[0:0] mux_193_nl;
  wire[0:0] or_195_nl;
  wire[0:0] mux_192_nl;
  wire[0:0] mux_418_nl;
  wire[0:0] mux_437_nl;
  wire[0:0] or_413_nl;
  wire[0:0] or_412_nl;
  wire[0:0] mux_426_nl;
  wire[0:0] mux_425_nl;
  wire[0:0] or_416_nl;
  wire[0:0] mux_424_nl;
  wire[0:0] nand_33_nl;
  wire[0:0] mux_423_nl;
  wire[0:0] mux_422_nl;
  wire[0:0] or_415_nl;
  wire[0:0] mux_421_nl;
  wire[0:0] and_596_nl;
  wire[0:0] mux_428_nl;
  wire[0:0] mux_427_nl;
  wire[0:0] or_424_nl;
  wire[0:0] nand_nl;
  wire[0:0] or_417_nl;
  wire[0:0] or_420_nl;
  wire[0:0] or_422_nl;
  wire[0:0] or_421_nl;
  wire[0:0] mux_436_nl;
  wire[0:0] mux_435_nl;
  wire[0:0] mux_434_nl;
  wire[0:0] nand_32_nl;
  wire[0:0] mux_433_nl;
  wire[0:0] mux_432_nl;
  wire[0:0] or_423_nl;
  wire[0:0] or_425_nl;
  wire[0:0] or_443_nl;
  wire[0:0] mux_458_nl;
  wire[0:0] mux_457_nl;
  wire[3:0] STAGE_LOOP_mux_3_nl;
  wire[13:0] VEC_LOOP_mux_23_nl;
  wire[13:0] VEC_LOOP_mux_24_nl;
  wire[3:0] VEC_LOOP_or_76_nl;
  wire[3:0] VEC_LOOP_mux1h_32_nl;
  wire[0:0] and_610_nl;
  wire[0:0] and_611_nl;
  wire[0:0] and_612_nl;
  wire[0:0] and_613_nl;
  wire[0:0] and_614_nl;
  wire[0:0] and_615_nl;
  wire[0:0] and_616_nl;
  wire[0:0] and_617_nl;
  wire[0:0] and_618_nl;
  wire[0:0] and_619_nl;
  wire[0:0] and_620_nl;
  wire[0:0] and_621_nl;
  wire[2:0] VEC_LOOP_or_77_nl;
  wire[2:0] VEC_LOOP_nor_19_nl;
  wire[2:0] VEC_LOOP_mux1h_33_nl;
  wire[0:0] and_622_nl;
  wire[0:0] and_623_nl;
  wire[0:0] and_624_nl;
  wire[0:0] and_625_nl;
  wire[0:0] and_626_nl;
  wire[19:0] acc_11_nl;
  wire[20:0] nl_acc_11_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_5_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_6_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_7_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_12_nl;
  wire[0:0] VEC_LOOP_mux_25_nl;
  wire[13:0] VEC_LOOP_mux1h_34_nl;
  wire[0:0] VEC_LOOP_or_78_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_13_nl;
  wire[9:0] VEC_LOOP_or_79_nl;
  wire[9:0] VEC_LOOP_mux1h_35_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_14_nl;
  wire[0:0] VEC_LOOP_mux_26_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[0:0] VEC_LOOP_mux_27_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[0:0] VEC_LOOP_mux_28_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;
  wire[0:0] VEC_LOOP_mux_29_nl;
  wire[32:0] acc_12_nl;
  wire[33:0] nl_acc_12_nl;
  wire[31:0] VEC_LOOP_mux_30_nl;
  wire[0:0] VEC_LOOP_or_80_nl;
  wire[31:0] VEC_LOOP_mux_31_nl;
  wire[12:0] acc_13_nl;
  wire[13:0] nl_acc_13_nl;
  wire[11:0] VEC_LOOP_mux1h_36_nl;
  wire[0:0] VEC_LOOP_or_81_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_8_nl;
  wire[0:0] VEC_LOOP_and_22_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_6_nl;
  wire[7:0] VEC_LOOP_mux1h_37_nl;
  wire[0:0] VEC_LOOP_or_82_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_18_nl;
  wire[0:0] VEC_LOOP_mux_32_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_19_nl;
  wire[9:0] VEC_LOOP_mux_33_nl;
  wire[0:0] and_627_nl;
  wire[13:0] COMP_LOOP_twiddle_f_mux_7_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_22_nl;
  wire[2:0] COMP_LOOP_twiddle_f_or_23_nl;
  wire[2:0] COMP_LOOP_twiddle_f_nor_6_nl;
  wire[2:0] COMP_LOOP_twiddle_f_mux1h_162_nl;
  wire[0:0] and_628_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_8_nl;
  wire[11:0] COMP_LOOP_twiddle_f_mux1h_163_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl;
  wire[8:0] COMP_LOOP_twiddle_f_mux1h_164_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_24_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_9_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl;
  wire[13:0] acc_15_nl;
  wire[14:0] nl_acc_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_20_nl;
  wire[11:0] VEC_LOOP_VEC_LOOP_mux_7_nl;
  wire[0:0] VEC_LOOP_or_83_nl;
  wire[0:0] VEC_LOOP_and_25_nl;
  wire[8:0] VEC_LOOP_VEC_LOOP_mux_8_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_21_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_22_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_23_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = z_out_13;
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
  wire[0:0] mux_274_nl;
  wire[0:0] mux_273_nl;
  wire[0:0] mux_272_nl;
  wire[0:0] mux_271_nl;
  wire[0:0] or_261_nl;
  wire[0:0] or_260_nl;
  wire[0:0] mux_270_nl;
  wire [0:0] nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat;
  assign or_261_nl = (~ (fsm_output[6])) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign or_260_nl = (fsm_output[6]) | (~ mux_tmp_141);
  assign mux_271_nl = MUX_s_1_2_2(or_261_nl, or_260_nl, fsm_output[7]);
  assign mux_272_nl = MUX_s_1_2_2(mux_271_nl, or_tmp_185, fsm_output[5]);
  assign mux_273_nl = MUX_s_1_2_2(mux_tmp_268, mux_272_nl, fsm_output[3]);
  assign mux_270_nl = MUX_s_1_2_2(or_259_cse, mux_tmp_268, fsm_output[3]);
  assign mux_274_nl = MUX_s_1_2_2(mux_273_nl, mux_270_nl, fsm_output[1]);
  assign nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat = ~(mux_274_nl | (fsm_output[0]));
  wire[0:0] and_201_nl;
  wire[0:0] and_205_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_nl;
  wire [3:0] nl_COMP_LOOP_1_twiddle_f_lshift_rg_s;
  assign and_201_nl = and_dcpl_156 & and_196_cse & nor_139_cse;
  assign and_205_nl = and_dcpl_156 & nor_126_cse & (~ (fsm_output[3])) & (fsm_output[0]);
  assign COMP_LOOP_twiddle_f_or_nl = (and_dcpl_164 & nor_126_cse & nor_139_cse) |
      (and_dcpl_164 & and_196_cse & (fsm_output[3]) & (~ (fsm_output[0])));
  assign nl_COMP_LOOP_1_twiddle_f_lshift_rg_s = MUX1HOT_v_4_3_2(z_out_1, STAGE_LOOP_i_3_0_sva,
      COMP_LOOP_1_twiddle_f_acc_cse_sva, {and_201_nl , and_205_nl , COMP_LOOP_twiddle_f_or_nl});
  wire[31:0] VEC_LOOP_mux_nl;
  wire [63:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      VEC_LOOP_j_1_sva, and_dcpl_29);
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_nl};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (~ mux_240_cse)};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {nor_88_cse , nor_88_cse};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (~ mux_240_cse)};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_140_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro = ~ mux_241_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro_2 = ~ mux_265_itm;
  wire [27:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core
      = {14'b00000000000000 , COMP_LOOP_twiddle_f_mux1h_60_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_15_rmff , COMP_LOOP_twiddle_f_mux1h_44_rmff , COMP_LOOP_twiddle_f_mux1h_69_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , nor_84_rmff};
  wire [27:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core
      = {14'b00000000000000 , COMP_LOOP_twiddle_f_mux1h_60_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_15_rmff , COMP_LOOP_twiddle_f_mux1h_44_rmff , COMP_LOOP_twiddle_f_mux1h_69_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , nor_84_rmff};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0
      = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (z_out_18[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_14[11]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ (z_out_18[12]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ (z_out_12[14]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_14[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_14_0_sva_1[14];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (z_out_12[14]);
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
      .ccs_ccore_start_rsc_dat(and_123_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_123_rmff),
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
  .width_z(32'sd14)) COMP_LOOP_2_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
      .z(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1)
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
  .width_z(32'sd15)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_1_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out)
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
      .vec_rsci_oswt_1_pff(nor_88_cse)
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
      .twiddle_rsci_oswt_pff(nor_84_rmff)
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
      .twiddle_h_rsci_oswt_pff(nor_84_rmff)
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
  assign mux_135_cse = MUX_s_1_2_2(or_193_cse, or_24_cse, fsm_output[2]);
  assign or_136_nl = (fsm_output[0]) | (~ (fsm_output[6])) | (fsm_output[7]);
  assign mux_136_nl = MUX_s_1_2_2(or_136_nl, or_tmp_60, fsm_output[2]);
  assign mux_137_nl = MUX_s_1_2_2(mux_136_nl, mux_tmp_122, fsm_output[4]);
  assign or_135_nl = (fsm_output[4]) | mux_135_cse;
  assign mux_138_nl = MUX_s_1_2_2(mux_137_nl, or_135_nl, fsm_output[5]);
  assign mux_133_nl = MUX_s_1_2_2(or_tmp_63, or_tmp_61, fsm_output[4]);
  assign mux_131_nl = MUX_s_1_2_2(or_24_cse, or_tmp_58, fsm_output[2]);
  assign mux_132_nl = MUX_s_1_2_2(mux_tmp_123, mux_131_nl, fsm_output[4]);
  assign mux_134_nl = MUX_s_1_2_2(mux_133_nl, mux_132_nl, fsm_output[5]);
  assign mux_139_nl = MUX_s_1_2_2(mux_138_nl, mux_134_nl, fsm_output[3]);
  assign mux_127_nl = MUX_s_1_2_2(or_193_cse, mux_tmp_121, fsm_output[2]);
  assign mux_128_nl = MUX_s_1_2_2(mux_127_nl, or_tmp_63, fsm_output[4]);
  assign mux_126_nl = MUX_s_1_2_2(or_tmp_61, mux_tmp_123, fsm_output[4]);
  assign mux_129_nl = MUX_s_1_2_2(mux_128_nl, mux_126_nl, fsm_output[5]);
  assign mux_124_nl = MUX_s_1_2_2(mux_tmp_123, mux_tmp_122, fsm_output[4]);
  assign mux_125_nl = MUX_s_1_2_2(mux_124_nl, or_127_cse, fsm_output[5]);
  assign mux_130_nl = MUX_s_1_2_2(mux_129_nl, mux_125_nl, fsm_output[3]);
  assign mux_140_itm = MUX_s_1_2_2(mux_139_nl, mux_130_nl, fsm_output[1]);
  assign nor_60_nl = ~((fsm_output[2]) | (~ (fsm_output[4])));
  assign mux_144_nl = MUX_s_1_2_2(mux_tmp_141, nor_60_nl, fsm_output[6]);
  assign nand_1_nl = ~((fsm_output[5]) & mux_144_nl);
  assign or_141_nl = (fsm_output[5]) | (fsm_output[6]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_145_cse = MUX_s_1_2_2(nand_1_nl, or_141_nl, fsm_output[7]);
  assign nor_59_nl = ~((fsm_output[6]) | (fsm_output[2]) | (~ (fsm_output[4])));
  assign mux_147_nl = MUX_s_1_2_2(nor_59_nl, mux_tmp_142, fsm_output[5]);
  assign or_145_cse = (fsm_output[7]) | (~ mux_147_nl);
  assign mux_148_nl = MUX_s_1_2_2(mux_tmp_143, or_145_cse, fsm_output[3]);
  assign mux_146_nl = MUX_s_1_2_2(mux_145_cse, mux_tmp_143, fsm_output[3]);
  assign mux_149_nl = MUX_s_1_2_2(mux_148_nl, mux_146_nl, fsm_output[1]);
  assign nor_88_cse = ~(mux_149_nl | (fsm_output[0]));
  assign or_172_cse = (~ (fsm_output[6])) | (fsm_output[7]) | (fsm_output[4]);
  assign or_173_cse = (fsm_output[7]) | (~ (fsm_output[4]));
  assign or_179_cse = (fsm_output[7:4]!=4'b0101);
  assign or_199_cse = (fsm_output[7:6]!=2'b00);
  assign or_193_cse = (fsm_output[7:6]!=2'b10);
  assign or_211_nl = (fsm_output[5:4]!=2'b01) | not_tmp_102;
  assign or_209_nl = COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm | (fsm_output[4])
      | (fsm_output[5]) | (fsm_output[7]);
  assign mux_211_nl = MUX_s_1_2_2(or_211_nl, or_209_nl, fsm_output[2]);
  assign or_208_nl = (fsm_output[5:4]!=2'b00) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[7]);
  assign mux_210_nl = MUX_s_1_2_2(or_208_nl, or_tmp_136, fsm_output[2]);
  assign mux_212_nl = MUX_s_1_2_2(mux_211_nl, mux_210_nl, fsm_output[6]);
  assign mux_213_nl = MUX_s_1_2_2(mux_tmp_205, mux_212_nl, fsm_output[3]);
  assign or_207_nl = (fsm_output[4]) | (fsm_output[5]) | (fsm_output[7]);
  assign mux_207_nl = MUX_s_1_2_2(or_207_nl, or_tmp_136, fsm_output[2]);
  assign mux_206_nl = MUX_s_1_2_2(or_tmp_136, or_tmp_135, fsm_output[2]);
  assign mux_208_nl = MUX_s_1_2_2(mux_207_nl, mux_206_nl, fsm_output[6]);
  assign mux_209_nl = MUX_s_1_2_2(mux_208_nl, mux_tmp_205, fsm_output[3]);
  assign mux_214_nl = MUX_s_1_2_2(mux_213_nl, mux_209_nl, fsm_output[1]);
  assign nor_84_rmff = ~(mux_214_nl | (fsm_output[0]));
  assign COMP_LOOP_twiddle_f_or_6_cse = and_dcpl_87 | (and_dcpl_40 & and_dcpl_33)
      | (and_dcpl_49 & and_dcpl_18) | (and_dcpl_54 & and_dcpl_33) | (and_dcpl_58
      & and_dcpl_18) | (and_dcpl_63 & and_dcpl_33) | (and_dcpl_21 & and_dcpl_103)
      | (and_dcpl_35 & and_dcpl_71);
  assign COMP_LOOP_twiddle_f_or_10_cse = (and_dcpl_72 & and_dcpl_30) | ((~ or_98_cse)
      & and_159_cse & and_dcpl_30) | (nor_tmp_20 & and_dcpl_19 & and_dcpl_30) | (and_dcpl_27
      & and_dcpl_68);
  assign COMP_LOOP_twiddle_f_or_11_cse = (and_dcpl_42 & and_dcpl_25) | (and_dcpl_65
      & and_dcpl_25);
  assign COMP_LOOP_twiddle_f_mux1h_15_nl = MUX1HOT_s_1_3_2((z_out_16[2]), (z_out_17_12_0[1]),
      (z_out_17_12_0[0]), {COMP_LOOP_twiddle_f_or_6_cse , COMP_LOOP_twiddle_f_or_10_cse
      , COMP_LOOP_twiddle_f_or_11_cse});
  assign COMP_LOOP_twiddle_f_mux1h_15_rmff = COMP_LOOP_twiddle_f_mux1h_15_nl & (~(xor_dcpl
      & (~ (fsm_output[5])) & (~ (fsm_output[3])) & and_dcpl_25));
  assign mux_221_nl = MUX_s_1_2_2(or_388_cse, or_tmp_148, fsm_output[2]);
  assign mux_222_nl = MUX_s_1_2_2(mux_tmp_218, mux_221_nl, fsm_output[4]);
  assign mux_223_nl = MUX_s_1_2_2(mux_tmp_217, mux_222_nl, fsm_output[3]);
  assign nand_26_nl = ~((fsm_output[2]) & (fsm_output[6]) & (~ (fsm_output[7])) &
      (fsm_output[5]));
  assign mux_219_nl = MUX_s_1_2_2(nand_26_nl, mux_tmp_218, fsm_output[4]);
  assign mux_220_nl = MUX_s_1_2_2(mux_219_nl, mux_tmp_217, fsm_output[3]);
  assign mux_224_cse = MUX_s_1_2_2(mux_223_nl, mux_220_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_31_nl = MUX1HOT_s_1_4_2((z_out_16[3]), (z_out_17_12_0[2]),
      (z_out_17_12_0[1]), (z_out_17_12_0[0]), {COMP_LOOP_twiddle_f_or_6_cse , COMP_LOOP_twiddle_f_or_10_cse
      , COMP_LOOP_twiddle_f_or_11_cse , and_dcpl_107});
  assign COMP_LOOP_twiddle_f_and_rmff = COMP_LOOP_twiddle_f_mux1h_31_nl & (~(mux_224_cse
      | (fsm_output[0])));
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl = MUX_s_1_2_2((z_out_16[1]),
      (z_out_17_12_0[0]), COMP_LOOP_twiddle_f_or_10_cse);
  assign COMP_LOOP_twiddle_f_mux1h_44_rmff = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl
      & (~(and_dcpl_108 & and_dcpl_25));
  assign nl_COMP_LOOP_1_twiddle_f_mul_nl = (z_out[9:0]) * COMP_LOOP_k_14_4_sva_9_0;
  assign COMP_LOOP_1_twiddle_f_mul_nl = nl_COMP_LOOP_1_twiddle_f_mul_nl[9:0];
  assign and_110_nl = and_dcpl_21 & and_dcpl_25;
  assign COMP_LOOP_twiddle_f_mux1h_60_rmff = MUX1HOT_v_10_5_2(COMP_LOOP_1_twiddle_f_mul_nl,
      (z_out_16[13:4]), (z_out_17_12_0[12:3]), (z_out_17_12_0[11:2]), (z_out_17_12_0[10:1]),
      {and_110_nl , COMP_LOOP_twiddle_f_or_6_cse , COMP_LOOP_twiddle_f_or_10_cse
      , COMP_LOOP_twiddle_f_or_11_cse , and_dcpl_107});
  assign mux_225_nl = MUX_s_1_2_2(and_dcpl_108, (~ mux_tmp_163), fsm_output[2]);
  assign nor_53_nl = ~((fsm_output[6:2]!=5'b00011));
  assign mux_226_nl = MUX_s_1_2_2(mux_225_nl, nor_53_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_mux1h_69_rmff = (z_out_16[0]) & (~(mux_226_nl & and_dcpl_23));
  assign mux_237_cse = MUX_s_1_2_2(mux_tmp_153, nand_2_cse, fsm_output[4]);
  assign nand_6_nl = ~((fsm_output[5]) & (~ mux_135_cse));
  assign mux_238_nl = MUX_s_1_2_2(nand_6_nl, or_tmp_78, fsm_output[4]);
  assign mux_239_cse = MUX_s_1_2_2(mux_238_nl, mux_237_cse, fsm_output[3]);
  assign mux_240_cse = MUX_s_1_2_2(mux_239_cse, mux_156_cse, fsm_output[1]);
  assign mux_232_nl = MUX_s_1_2_2(nand_2_cse, mux_151_cse, fsm_output[4]);
  assign mux_233_nl = MUX_s_1_2_2(mux_232_nl, mux_155_cse, fsm_output[3]);
  assign mux_236_nl = MUX_s_1_2_2(mux_156_cse, mux_233_nl, fsm_output[1]);
  assign mux_241_itm = MUX_s_1_2_2(mux_240_cse, mux_236_nl, fsm_output[0]);
  assign or_240_nl = (fsm_output[5]) | (~ mux_tmp_141);
  assign mux_248_nl = MUX_s_1_2_2(or_240_nl, mux_tmp_245, fsm_output[6]);
  assign or_241_nl = (fsm_output[7]) | mux_248_nl;
  assign mux_249_nl = MUX_s_1_2_2(mux_tmp_244, or_241_nl, fsm_output[3]);
  assign nand_21_nl = ~((fsm_output[5]) & mux_tmp_141);
  assign mux_246_nl = MUX_s_1_2_2(mux_tmp_245, nand_21_nl, fsm_output[6]);
  assign or_239_nl = (fsm_output[7]) | mux_246_nl;
  assign mux_247_nl = MUX_s_1_2_2(or_239_nl, mux_tmp_244, fsm_output[3]);
  assign mux_250_nl = MUX_s_1_2_2(mux_249_nl, mux_247_nl, fsm_output[1]);
  assign and_123_rmff = (~ mux_250_nl) & (fsm_output[0]);
  assign or_251_cse = (fsm_output[6:5]!=2'b00) | (~ mux_tmp_141);
  assign or_252_nl = (fsm_output[0]) | (~ mux_tmp_141);
  assign mux_261_nl = MUX_s_1_2_2(or_252_nl, or_238_cse, fsm_output[5]);
  assign mux_262_nl = MUX_s_1_2_2(mux_261_nl, mux_tmp_257, fsm_output[6]);
  assign mux_263_nl = MUX_s_1_2_2(mux_262_nl, or_251_cse, fsm_output[7]);
  assign mux_264_nl = MUX_s_1_2_2(mux_tmp_256, mux_263_nl, fsm_output[3]);
  assign nand_19_nl = ~((~((fsm_output[5]) & (fsm_output[0]))) & mux_tmp_141);
  assign mux_258_nl = MUX_s_1_2_2(mux_tmp_257, nand_19_nl, fsm_output[6]);
  assign mux_259_nl = MUX_s_1_2_2(mux_258_nl, or_248_cse, fsm_output[7]);
  assign mux_260_nl = MUX_s_1_2_2(mux_259_nl, mux_tmp_256, fsm_output[3]);
  assign mux_265_itm = MUX_s_1_2_2(mux_264_nl, mux_260_nl, fsm_output[1]);
  assign or_258_nl = (fsm_output[6]) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign mux_269_nl = MUX_s_1_2_2((~ mux_tmp_142), or_258_nl, fsm_output[7]);
  assign or_259_cse = (fsm_output[5]) | mux_269_nl;
  assign or_119_cse = (fsm_output[4:3]!=2'b00);
  assign or_116_cse = (fsm_output[1:0]!=2'b00);
  assign and_176_cse = or_119_cse & (fsm_output[5]);
  assign or_397_cse = and_176_cse | (fsm_output[6]);
  assign or_cse = (fsm_output[6:5]!=2'b00);
  assign and_169_cse = (fsm_output[1:0]==2'b11);
  assign or_272_cse = and_169_cse | (fsm_output[2]);
  assign mux_305_nl = MUX_s_1_2_2(mux_tmp_300, or_259_cse, fsm_output[3]);
  assign mux_301_nl = MUX_s_1_2_2(or_tmp_214, or_127_cse, fsm_output[5]);
  assign mux_302_nl = MUX_s_1_2_2(mux_301_nl, mux_tmp_300, fsm_output[3]);
  assign mux_306_nl = MUX_s_1_2_2(mux_305_nl, mux_302_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & (~ mux_306_nl)
      & (fsm_output[0]);
  assign or_392_cse = (fsm_output[7]) | (fsm_output[5]);
  assign VEC_LOOP_or_50_cse = and_dcpl_36 | and_dcpl_57;
  assign VEC_LOOP_or_51_cse = and_dcpl_41 | and_dcpl_75;
  assign VEC_LOOP_or_52_cse = and_dcpl_43 | and_dcpl_62;
  assign VEC_LOOP_or_53_cse = and_dcpl_50 | and_dcpl_55;
  assign VEC_LOOP_or_54_cse = and_dcpl_53 | and_dcpl_66;
  assign VEC_LOOP_or_55_cse = and_dcpl_64 | and_dcpl_69;
  assign mux_317_nl = MUX_s_1_2_2((~ (fsm_output[3])), (fsm_output[3]), fsm_output[2]);
  assign mux_318_nl = MUX_s_1_2_2(mux_317_nl, or_tmp_96, fsm_output[1]);
  assign nor_91_nl = ~(mux_318_nl | (fsm_output[6]) | (~ nor_55_cse) | (fsm_output[7]));
  assign VEC_LOOP_or_47_nl = and_dcpl_31 | and_dcpl_41 | and_dcpl_50 | and_dcpl_55
      | and_dcpl_60 | and_dcpl_64 | and_dcpl_69 | and_dcpl_75;
  assign or_330_nl = (fsm_output[5]) | (fsm_output[2]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_337_nl = MUX_s_1_2_2(or_330_nl, or_154_cse, fsm_output[4]);
  assign mux_338_nl = MUX_s_1_2_2(mux_237_cse, mux_337_nl, fsm_output[3]);
  assign mux_339_nl = MUX_s_1_2_2(mux_338_nl, mux_239_cse, fsm_output[1]);
  assign nor_82_nl = ~(mux_339_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_14_nl = MUX1HOT_v_14_3_2(({4'b0000 , (z_out_14[9:0])}), z_out_7,
      (VEC_LOOP_j_10_14_0_sva_1[13:0]), {nor_91_nl , VEC_LOOP_or_47_nl , nor_82_nl});
  assign VEC_LOOP_nand_nl = ~((~ mux_224_cse) & (fsm_output[0]));
  assign VEC_LOOP_and_4_rgt = MUX_v_14_2_2(14'b00000000000000, VEC_LOOP_mux1h_14_nl,
      VEC_LOOP_nand_nl);
  assign and_164_cse = (fsm_output[4:2]==3'b111);
  assign nor_45_cse_1 = ~((fsm_output[1:0]!=2'b00));
  assign or_377_cse = (fsm_output[6]) | (fsm_output[4]) | (~ (fsm_output[7]));
  assign or_388_cse = (fsm_output[7:5]!=3'b100);
  assign mux_389_cse = MUX_s_1_2_2(or_tmp_101, or_172_cse, fsm_output[5]);
  assign mux_388_cse = MUX_s_1_2_2(or_377_cse, or_tmp_101, fsm_output[5]);
  assign and_154_nl = (fsm_output[3]) & mux_tmp_164;
  assign mux_384_nl = MUX_s_1_2_2(and_dcpl_49, and_154_nl, fsm_output[2]);
  assign mux_385_nl = MUX_s_1_2_2(mux_384_nl, (~ or_tmp_197), fsm_output[7]);
  assign nor_46_nl = ~((fsm_output[7]) | (~((fsm_output[3:2]==2'b11) & mux_tmp_164)));
  assign mux_386_nl = MUX_s_1_2_2(mux_385_nl, nor_46_nl, fsm_output[1]);
  assign VEC_LOOP_VEC_LOOP_mux_2_rgt = MUX_v_13_2_2(z_out_18, ({1'b0 , z_out_14}),
      mux_386_nl);
  assign nor_157_cse = ~((fsm_output[6:5]!=2'b00));
  assign nor_159_cse = ~((fsm_output[6:2]!=5'b00100));
  assign or_98_cse = (fsm_output[6:5]!=2'b01);
  assign or_97_cse = (fsm_output[6:5]!=2'b10);
  assign and_159_cse = (fsm_output[4:3]==2'b11);
  assign and_158_cse = (fsm_output[3:2]==2'b11);
  assign or_127_cse = (fsm_output[4]) | (~ (fsm_output[2])) | (~ (fsm_output[6]))
      | (fsm_output[7]);
  assign or_248_cse = (fsm_output[6]) | (fsm_output[5]) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ z_out_1)}) + 5'b01111;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign or_24_cse = (fsm_output[7:6]!=2'b01);
  assign nor_tmp_4 = (fsm_output[5:4]==2'b11);
  assign mux_tmp_99 = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[5]);
  assign or_400_cse = (((fsm_output[4:2]!=3'b000)) & (fsm_output[5])) | (fsm_output[6]);
  assign nor_tmp_14 = or_400_cse & (fsm_output[7]);
  assign or_dcpl_68 = or_cse | or_119_cse;
  assign or_tmp_58 = ((fsm_output[0]) & (fsm_output[6])) | (fsm_output[7]);
  assign mux_112_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign mux_tmp_121 = MUX_s_1_2_2(mux_112_nl, or_24_cse, fsm_output[0]);
  assign mux_tmp_122 = MUX_s_1_2_2(mux_tmp_121, or_tmp_58, fsm_output[2]);
  assign or_tmp_60 = (fsm_output[0]) | (fsm_output[6]) | (fsm_output[7]);
  assign mux_tmp_123 = MUX_s_1_2_2(or_tmp_58, or_tmp_60, fsm_output[2]);
  assign or_tmp_61 = (fsm_output[2]) | (fsm_output[0]) | (fsm_output[6]) | (fsm_output[7]);
  assign or_tmp_63 = (~ (fsm_output[2])) | (fsm_output[6]) | (~ (fsm_output[7]));
  assign mux_tmp_141 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[2]);
  assign nor_61_nl = ~((~ (fsm_output[2])) | (fsm_output[4]));
  assign mux_tmp_142 = MUX_s_1_2_2(nor_61_nl, mux_tmp_141, fsm_output[6]);
  assign or_140_nl = (fsm_output[5]) | (~ mux_tmp_142);
  assign mux_tmp_143 = MUX_s_1_2_2(or_140_nl, or_248_cse, fsm_output[7]);
  assign and_dcpl_17 = (fsm_output[2]) & (~ (fsm_output[7]));
  assign and_dcpl_18 = and_dcpl_17 & nor_45_cse_1;
  assign and_dcpl_19 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_21 = nor_157_cse & and_dcpl_19;
  assign and_dcpl_22 = and_dcpl_21 & and_dcpl_18;
  assign and_dcpl_23 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_24 = ~((fsm_output[2]) | (fsm_output[7]));
  assign and_dcpl_25 = and_dcpl_24 & and_dcpl_23;
  assign and_dcpl_26 = (fsm_output[4:3]==2'b01);
  assign and_dcpl_27 = nor_157_cse & and_dcpl_26;
  assign mux_tmp_150 = MUX_s_1_2_2(or_24_cse, or_199_cse, fsm_output[2]);
  assign or_tmp_78 = (fsm_output[5]) | mux_tmp_150;
  assign or_tmp_81 = (fsm_output[2]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_tmp_153 = MUX_s_1_2_2(or_tmp_63, or_tmp_81, fsm_output[5]);
  assign or_150_nl = (~ (fsm_output[2])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_151_cse = MUX_s_1_2_2(or_tmp_81, or_150_nl, fsm_output[5]);
  assign or_154_cse = (fsm_output[5]) | mux_135_cse;
  assign mux_155_cse = MUX_s_1_2_2(or_154_cse, mux_tmp_153, fsm_output[4]);
  assign nand_2_cse = ~((fsm_output[5]) & (~ mux_tmp_150));
  assign mux_152_nl = MUX_s_1_2_2(mux_151_cse, or_tmp_78, fsm_output[4]);
  assign mux_156_cse = MUX_s_1_2_2(mux_155_cse, mux_152_nl, fsm_output[3]);
  assign and_dcpl_29 = (~ mux_240_cse) & (fsm_output[0]);
  assign and_dcpl_30 = and_dcpl_17 & and_dcpl_23;
  assign and_dcpl_31 = and_dcpl_27 & and_dcpl_30;
  assign nor_tmp_20 = (fsm_output[6:5]==2'b11);
  assign mux_tmp_162 = MUX_s_1_2_2((~ nor_tmp_20), or_cse, fsm_output[4]);
  assign or_157_nl = (fsm_output[6:4]!=3'b011);
  assign mux_tmp_163 = MUX_s_1_2_2(mux_tmp_162, or_157_nl, fsm_output[3]);
  assign mux_tmp_164 = MUX_s_1_2_2((~ or_98_cse), nor_tmp_20, fsm_output[4]);
  assign nor_58_nl = ~((fsm_output[6:4]!=3'b101));
  assign mux_tmp_165 = MUX_s_1_2_2(nor_58_nl, mux_tmp_164, fsm_output[3]);
  assign mux_166_nl = MUX_s_1_2_2(mux_tmp_165, (~ mux_tmp_163), fsm_output[2]);
  assign nor_56_nl = ~((fsm_output[6:3]!=4'b0100));
  assign nor_57_nl = ~((fsm_output[6:3]!=4'b0001));
  assign mux_161_nl = MUX_s_1_2_2(nor_56_nl, nor_57_nl, fsm_output[2]);
  assign mux_167_nl = MUX_s_1_2_2(mux_166_nl, mux_161_nl, fsm_output[7]);
  assign and_dcpl_32 = mux_167_nl & nor_45_cse_1;
  assign and_dcpl_33 = and_dcpl_24 & nor_45_cse_1;
  assign and_dcpl_35 = nor_157_cse & and_159_cse;
  assign and_dcpl_36 = and_dcpl_35 & and_dcpl_33;
  assign or_163_nl = (fsm_output[6:4]!=3'b100);
  assign mux_tmp_168 = MUX_s_1_2_2(or_163_nl, mux_tmp_162, fsm_output[3]);
  assign or_161_nl = (fsm_output[6:3]!=4'b0010);
  assign mux_169_nl = MUX_s_1_2_2(mux_tmp_168, or_161_nl, fsm_output[7]);
  assign and_dcpl_39 = (~ mux_169_nl) & (fsm_output[2:0]==3'b110);
  assign and_dcpl_40 = (~ or_98_cse) & and_dcpl_19;
  assign and_dcpl_41 = and_dcpl_40 & and_dcpl_25;
  assign and_dcpl_42 = (~ or_98_cse) & and_dcpl_26;
  assign and_dcpl_43 = and_dcpl_42 & and_dcpl_18;
  assign nor_55_cse = ~((fsm_output[5:4]!=2'b00));
  assign mux_170_nl = MUX_s_1_2_2(nor_tmp_4, nor_55_cse, fsm_output[7]);
  assign and_dcpl_47 = mux_170_nl & (~ (fsm_output[6])) & (~ (fsm_output[3])) & (~
      (fsm_output[2])) & and_dcpl_23;
  assign and_dcpl_48 = (fsm_output[4:3]==2'b10);
  assign and_dcpl_49 = (~ or_98_cse) & and_dcpl_48;
  assign and_dcpl_50 = and_dcpl_49 & and_dcpl_30;
  assign and_dcpl_51 = (fsm_output[6:5]==2'b10);
  assign and_dcpl_53 = and_dcpl_51 & and_dcpl_19 & and_dcpl_33;
  assign and_dcpl_54 = and_dcpl_51 & and_dcpl_26;
  assign and_dcpl_55 = and_dcpl_54 & and_dcpl_25;
  assign and_dcpl_56 = and_dcpl_51 & and_dcpl_48;
  assign and_dcpl_57 = and_dcpl_56 & and_dcpl_18;
  assign and_dcpl_58 = and_dcpl_51 & and_159_cse;
  assign and_dcpl_59 = and_dcpl_58 & and_dcpl_25;
  assign and_dcpl_60 = and_dcpl_58 & and_dcpl_30;
  assign and_dcpl_62 = nor_tmp_20 & and_dcpl_26 & and_dcpl_33;
  assign and_dcpl_63 = nor_tmp_20 & and_dcpl_48;
  assign and_dcpl_64 = and_dcpl_63 & and_dcpl_25;
  assign and_dcpl_65 = nor_tmp_20 & and_159_cse;
  assign and_dcpl_66 = and_dcpl_65 & and_dcpl_18;
  assign and_dcpl_67 = (fsm_output[2]) & (fsm_output[7]);
  assign and_dcpl_68 = and_dcpl_67 & and_dcpl_23;
  assign and_dcpl_69 = and_dcpl_21 & and_dcpl_68;
  assign and_dcpl_70 = (~ (fsm_output[2])) & (fsm_output[7]);
  assign and_dcpl_71 = and_dcpl_70 & nor_45_cse_1;
  assign and_dcpl_72 = nor_157_cse & and_dcpl_48;
  assign and_dcpl_73 = and_dcpl_72 & and_dcpl_71;
  assign and_dcpl_75 = and_dcpl_35 & and_dcpl_70 & and_dcpl_23;
  assign or_tmp_96 = (fsm_output[3:2]!=2'b01);
  assign or_165_nl = (fsm_output[3:2]!=2'b10);
  assign mux_171_nl = MUX_s_1_2_2(or_tmp_96, or_165_nl, fsm_output[1]);
  assign and_dcpl_80 = ~(mux_171_nl | (fsm_output[6]) | (~ nor_55_cse) | (fsm_output[7])
      | (fsm_output[0]));
  assign or_tmp_101 = (fsm_output[6]) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign or_181_nl = (~ (fsm_output[7])) | (fsm_output[4]);
  assign mux_182_nl = MUX_s_1_2_2(or_181_nl, or_173_cse, fsm_output[5]);
  assign or_tmp_112 = (fsm_output[6]) | mux_182_nl;
  assign or_tmp_114 = (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[4]);
  assign or_tmp_116 = (fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign not_tmp_102 = ~((VEC_LOOP_j_10_14_0_sva_1[14]) & (fsm_output[7]));
  assign or_tmp_135 = (fsm_output[5:4]!=2'b10) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[7]);
  assign or_204_nl = (fsm_output[5]) | not_tmp_102;
  assign or_203_nl = (~ (fsm_output[5])) | (~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (fsm_output[7]);
  assign mux_203_nl = MUX_s_1_2_2(or_204_nl, or_203_nl, fsm_output[4]);
  assign mux_204_nl = MUX_s_1_2_2(or_tmp_135, mux_203_nl, fsm_output[2]);
  assign or_202_nl = (fsm_output[2]) | (~ (fsm_output[4])) | (~ (fsm_output[5]))
      | (~ (VEC_LOOP_j_10_14_0_sva_1[14])) | (fsm_output[7]);
  assign mux_tmp_205 = MUX_s_1_2_2(mux_204_nl, or_202_nl, fsm_output[6]);
  assign or_tmp_136 = (fsm_output[5:4]!=2'b01) | (~ (VEC_LOOP_j_10_14_0_sva_1[14]))
      | (fsm_output[7]);
  assign and_dcpl_87 = and_dcpl_27 & and_dcpl_18;
  assign and_dcpl_103 = and_dcpl_67 & nor_45_cse_1;
  assign or_tmp_143 = (fsm_output[7:5]!=3'b001);
  assign mux_216_nl = MUX_s_1_2_2(or_tmp_143, or_388_cse, fsm_output[2]);
  assign or_384_nl = (fsm_output[7:5]!=3'b011);
  assign mux_215_nl = MUX_s_1_2_2(or_384_nl, or_tmp_143, fsm_output[2]);
  assign mux_tmp_217 = MUX_s_1_2_2(mux_216_nl, mux_215_nl, fsm_output[4]);
  assign or_tmp_148 = (fsm_output[7:5]!=3'b010);
  assign or_217_nl = (fsm_output[7:5]!=3'b000);
  assign mux_tmp_218 = MUX_s_1_2_2(or_tmp_148, or_217_nl, fsm_output[2]);
  assign and_dcpl_107 = and_dcpl_56 & and_dcpl_25;
  assign and_dcpl_108 = xor_dcpl & (~((fsm_output[5]) ^ (fsm_output[3])));
  assign and_dcpl_121 = and_dcpl_40 & and_dcpl_67 & (fsm_output[1:0]==2'b01);
  assign or_236_nl = (~ (fsm_output[5])) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign or_234_nl = (fsm_output[5]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_243_nl = MUX_s_1_2_2(or_236_nl, or_234_nl, fsm_output[6]);
  assign mux_tmp_244 = MUX_s_1_2_2(mux_243_nl, or_251_cse, fsm_output[7]);
  assign or_237_cse = (~ (fsm_output[2])) | (fsm_output[4]);
  assign or_238_cse = (fsm_output[2]) | (~ (fsm_output[4]));
  assign mux_tmp_245 = MUX_s_1_2_2(or_238_cse, or_237_cse, fsm_output[5]);
  assign or_tmp_173 = (fsm_output[0]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_tmp_253 = MUX_s_1_2_2(mux_tmp_141, or_237_cse, fsm_output[0]);
  assign mux_254_nl = MUX_s_1_2_2(or_238_cse, mux_tmp_253, fsm_output[5]);
  assign mux_252_nl = MUX_s_1_2_2(or_tmp_173, (~ mux_tmp_141), fsm_output[5]);
  assign mux_255_nl = MUX_s_1_2_2(mux_254_nl, mux_252_nl, fsm_output[6]);
  assign or_243_nl = (fsm_output[6]) | (fsm_output[5]) | (fsm_output[0]) | (~ mux_tmp_141);
  assign mux_tmp_256 = MUX_s_1_2_2(mux_255_nl, or_243_nl, fsm_output[7]);
  assign mux_tmp_257 = MUX_s_1_2_2(mux_tmp_253, or_tmp_173, fsm_output[5]);
  assign or_tmp_185 = (fsm_output[7]) | (fsm_output[6]) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign or_254_nl = (fsm_output[7]) | (~ mux_tmp_142);
  assign mux_tmp_268 = MUX_s_1_2_2(or_tmp_185, or_254_nl, fsm_output[5]);
  assign or_tmp_197 = (fsm_output[6:2]!=5'b00000);
  assign mux_278_nl = MUX_s_1_2_2((~ or_tmp_197), or_400_cse, fsm_output[7]);
  assign mux_tmp_279 = MUX_s_1_2_2(mux_278_nl, nor_tmp_14, fsm_output[1]);
  assign mux_299_nl = MUX_s_1_2_2((~ mux_tmp_141), or_238_cse, fsm_output[6]);
  assign or_tmp_214 = (fsm_output[7]) | mux_299_nl;
  assign or_289_nl = (~ (fsm_output[7])) | (fsm_output[6]) | (~ (fsm_output[2]))
      | (fsm_output[4]);
  assign mux_tmp_300 = MUX_s_1_2_2(or_289_nl, or_tmp_214, fsm_output[5]);
  assign or_346_nl = (fsm_output[5]) | (~((fsm_output[6]) & mux_tmp_141));
  assign mux_tmp_360 = MUX_s_1_2_2(or_346_nl, or_248_cse, fsm_output[7]);
  assign mux_366_nl = MUX_s_1_2_2(mux_tmp_360, or_145_cse, fsm_output[3]);
  assign mux_363_nl = MUX_s_1_2_2(mux_145_cse, mux_tmp_360, fsm_output[3]);
  assign mux_367_nl = MUX_s_1_2_2(mux_366_nl, mux_363_nl, fsm_output[1]);
  assign and_dcpl_148 = (~ mux_367_nl) & (fsm_output[0]);
  assign or_tmp_272 = and_159_cse | (fsm_output[6:5]!=2'b00);
  assign or_tmp_273 = and_158_cse | (fsm_output[6:4]!=3'b000);
  assign or_tmp_275 = (fsm_output[6:4]!=3'b000);
  assign or_tmp_280 = (~ (fsm_output[1])) | (fsm_output[3]) | (fsm_output[7]) | (~
      (fsm_output[5]));
  assign or_360_nl = (fsm_output[7]) | (~ (fsm_output[5]));
  assign mux_371_nl = MUX_s_1_2_2(or_392_cse, or_360_nl, fsm_output[3]);
  assign or_359_nl = (~ (fsm_output[3])) | (fsm_output[7]) | (fsm_output[5]);
  assign mux_372_nl = MUX_s_1_2_2(mux_371_nl, or_359_nl, fsm_output[1]);
  assign mux_tmp_373 = MUX_s_1_2_2(or_tmp_280, mux_372_nl, fsm_output[6]);
  assign or_364_nl = (~ (fsm_output[7])) | (fsm_output[5]);
  assign mux_tmp_374 = MUX_s_1_2_2(or_364_nl, or_392_cse, fsm_output[3]);
  assign mux_tmp_402 = MUX_s_1_2_2(mux_tmp_99, or_98_cse, fsm_output[4]);
  assign mux_tmp_403 = MUX_s_1_2_2(or_97_cse, mux_tmp_99, fsm_output[4]);
  assign mux_tmp_404 = MUX_s_1_2_2(mux_tmp_403, mux_tmp_402, fsm_output[3]);
  assign mux_tmp_405 = MUX_s_1_2_2(or_97_cse, or_98_cse, fsm_output[4]);
  assign mux_tmp_406 = MUX_s_1_2_2(mux_tmp_405, mux_tmp_402, fsm_output[3]);
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_40 & and_dcpl_103;
  assign VEC_LOOP_j_1_sva_mx0c0 = and_dcpl_21 & and_dcpl_24 & and_169_cse;
  assign xor_dcpl = ~((fsm_output[6]) ^ (fsm_output[4]));
  assign VEC_LOOP_or_8_cse = and_dcpl_36 | and_dcpl_53 | and_dcpl_62 | and_dcpl_73;
  assign VEC_LOOP_or_9_cse = and_dcpl_41 | and_dcpl_50 | and_dcpl_55 | and_dcpl_60
      | and_dcpl_64 | and_dcpl_69 | and_dcpl_75;
  assign VEC_LOOP_or_10_cse = and_dcpl_43 | and_dcpl_66;
  assign VEC_LOOP_or_84_cse = VEC_LOOP_or_50_cse | VEC_LOOP_or_51_cse | and_dcpl_60
      | VEC_LOOP_or_55_cse | VEC_LOOP_or_53_cse | VEC_LOOP_or_52_cse | VEC_LOOP_or_54_cse;
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_v_11_6_2((z_out_2[13:3]), (acc_3_cse_14_1[13:3]),
      (z_out_18[12:2]), (z_out_7[13:3]), (z_out_14[11:1]), (z_out_14[10:0]), {and_dcpl_22
      , and_dcpl_31 , VEC_LOOP_or_8_cse , VEC_LOOP_or_9_cse , VEC_LOOP_or_10_cse
      , and_dcpl_57});
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_6_2((z_out_2[2]), (acc_3_cse_14_1[2]),
      (z_out_18[1]), (z_out_7[2]), (z_out_14[0]), (reg_VEC_LOOP_acc_1_1_reg[2]),
      {and_dcpl_22 , and_dcpl_31 , VEC_LOOP_or_8_cse , VEC_LOOP_or_9_cse , VEC_LOOP_or_10_cse
      , and_dcpl_57});
  assign and_83_nl = mux_tmp_165 & and_dcpl_18;
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_5_2((z_out_2[1]), (acc_3_cse_14_1[1]),
      (z_out_18[0]), (z_out_7[1]), (reg_VEC_LOOP_acc_1_1_reg[1]), {and_dcpl_22 ,
      and_dcpl_31 , VEC_LOOP_or_8_cse , VEC_LOOP_or_9_cse , and_83_nl});
  assign mux_172_nl = MUX_s_1_2_2((~ mux_tmp_168), mux_tmp_165, fsm_output[2]);
  assign mux_173_nl = MUX_s_1_2_2(mux_172_nl, nor_159_cse, fsm_output[7]);
  assign and_81_nl = mux_173_nl & nor_45_cse_1;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_4_2((z_out_2[0]), (acc_3_cse_14_1[0]),
      (reg_VEC_LOOP_acc_1_1_reg[0]), (z_out_7[0]), {and_dcpl_22 , and_dcpl_31 , and_81_nl
      , VEC_LOOP_or_9_cse});
  assign and_28_nl = and_dcpl_27 & and_dcpl_25;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_10_10_2((z_out_14[9:0]), reg_VEC_LOOP_acc_1_1_reg,
      (VEC_LOOP_acc_10_cse_1_sva[13:4]), (z_out_7[13:4]), ({reg_VEC_LOOP_acc_1_reg
      , (reg_VEC_LOOP_acc_1_1_reg[9:4])}), (acc_3_cse_14_1[13:4]), ({VEC_LOOP_acc_11_psp_sva_12
      , (VEC_LOOP_acc_11_psp_sva_11_0[11:3])}), (VEC_LOOP_acc_11_psp_sva_11_0[11:2]),
      (COMP_LOOP_9_twiddle_f_lshift_itm[10:1]), (z_out_2[13:4]), {and_dcpl_22 , and_28_nl
      , and_dcpl_29 , and_dcpl_31 , and_dcpl_32 , VEC_LOOP_or_84_cse , and_dcpl_39
      , and_dcpl_47 , and_dcpl_59 , and_dcpl_73});
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_9_2((VEC_LOOP_j_1_sva[3]), (VEC_LOOP_acc_10_cse_1_sva[3]),
      (z_out_7[3]), (reg_VEC_LOOP_acc_1_1_reg[3]), (acc_3_cse_14_1[3]), (VEC_LOOP_acc_11_psp_sva_11_0[2]),
      (VEC_LOOP_acc_11_psp_sva_11_0[1]), (COMP_LOOP_9_twiddle_f_lshift_itm[0]), (z_out_2[3]),
      {and_dcpl_80 , and_dcpl_29 , and_dcpl_31 , and_dcpl_32 , VEC_LOOP_or_84_cse
      , and_dcpl_39 , and_dcpl_47 , and_dcpl_59 , and_dcpl_73});
  assign or_177_nl = (fsm_output[3]) | (~ (fsm_output[6])) | (fsm_output[7]) | (~
      (fsm_output[4]));
  assign mux_178_nl = MUX_s_1_2_2(or_tmp_101, or_377_cse, fsm_output[3]);
  assign mux_179_nl = MUX_s_1_2_2(or_177_nl, mux_178_nl, fsm_output[2]);
  assign or_174_nl = (fsm_output[7]) | (fsm_output[4]);
  assign mux_175_nl = MUX_s_1_2_2(or_174_nl, or_173_cse, fsm_output[6]);
  assign mux_176_nl = MUX_s_1_2_2(or_377_cse, mux_175_nl, fsm_output[3]);
  assign mux_174_nl = MUX_s_1_2_2(or_172_cse, or_tmp_101, fsm_output[3]);
  assign mux_177_nl = MUX_s_1_2_2(mux_176_nl, mux_174_nl, fsm_output[2]);
  assign mux_180_nl = MUX_s_1_2_2(mux_179_nl, mux_177_nl, fsm_output[5]);
  assign or_169_nl = (fsm_output[7:2]!=6'b010110);
  assign mux_181_nl = MUX_s_1_2_2(mux_180_nl, or_169_nl, fsm_output[1]);
  assign nor_87_nl = ~(mux_181_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_8_2((VEC_LOOP_j_1_sva[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_7[2]), (reg_VEC_LOOP_acc_1_1_reg[2]), (acc_3_cse_14_1[2]), (VEC_LOOP_acc_11_psp_sva_11_0[1]),
      (VEC_LOOP_acc_11_psp_sva_11_0[0]), (z_out_2[2]), {and_dcpl_80 , and_dcpl_29
      , and_dcpl_31 , nor_87_nl , VEC_LOOP_or_84_cse , and_dcpl_39 , and_dcpl_47
      , and_dcpl_73});
  assign or_189_nl = (~ (fsm_output[5])) | (~ (fsm_output[7])) | (fsm_output[4]);
  assign mux_187_nl = MUX_s_1_2_2(or_189_nl, or_tmp_116, fsm_output[6]);
  assign or_188_nl = (~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign mux_186_nl = MUX_s_1_2_2(or_tmp_114, or_188_nl, fsm_output[6]);
  assign mux_188_nl = MUX_s_1_2_2(mux_187_nl, mux_186_nl, fsm_output[3]);
  assign mux_184_nl = MUX_s_1_2_2(or_tmp_116, or_tmp_114, fsm_output[6]);
  assign mux_185_nl = MUX_s_1_2_2(mux_184_nl, or_tmp_112, fsm_output[3]);
  assign mux_189_nl = MUX_s_1_2_2(mux_188_nl, mux_185_nl, fsm_output[2]);
  assign mux_183_nl = MUX_s_1_2_2(or_tmp_112, or_179_cse, fsm_output[3]);
  assign or_183_nl = (fsm_output[2]) | mux_183_nl;
  assign mux_190_nl = MUX_s_1_2_2(mux_189_nl, or_183_nl, fsm_output[1]);
  assign nor_86_nl = ~(mux_190_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_7_2((VEC_LOOP_j_1_sva[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_7[1]), (reg_VEC_LOOP_acc_1_1_reg[1]), (acc_3_cse_14_1[1]), (VEC_LOOP_acc_11_psp_sva_11_0[0]),
      (z_out_2[1]), {and_dcpl_80 , and_dcpl_29 , and_dcpl_31 , nor_86_nl , VEC_LOOP_or_84_cse
      , and_dcpl_39 , and_dcpl_73});
  assign or_201_nl = (~ (fsm_output[4])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_199_nl = MUX_s_1_2_2(or_201_nl, or_377_cse, fsm_output[5]);
  assign mux_198_nl = MUX_s_1_2_2(or_199_cse, or_24_cse, fsm_output[4]);
  assign nand_4_nl = ~((fsm_output[5]) & (~ mux_198_nl));
  assign mux_200_nl = MUX_s_1_2_2(mux_199_nl, nand_4_nl, fsm_output[3]);
  assign mux_197_nl = MUX_s_1_2_2(mux_389_cse, mux_388_cse, fsm_output[3]);
  assign mux_201_nl = MUX_s_1_2_2(mux_200_nl, mux_197_nl, fsm_output[2]);
  assign mux_195_nl = MUX_s_1_2_2(mux_388_cse, or_179_cse, fsm_output[3]);
  assign mux_192_nl = MUX_s_1_2_2(or_24_cse, or_193_cse, fsm_output[4]);
  assign or_195_nl = (fsm_output[5]) | mux_192_nl;
  assign mux_193_nl = MUX_s_1_2_2(or_195_nl, mux_389_cse, fsm_output[3]);
  assign mux_196_nl = MUX_s_1_2_2(mux_195_nl, mux_193_nl, fsm_output[2]);
  assign mux_202_nl = MUX_s_1_2_2(mux_201_nl, mux_196_nl, fsm_output[1]);
  assign nor_85_nl = ~(mux_202_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_6_2((VEC_LOOP_j_1_sva[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_7[0]), (reg_VEC_LOOP_acc_1_1_reg[0]), (acc_3_cse_14_1[0]), (z_out_2[0]),
      {and_dcpl_80 , and_dcpl_29 , and_dcpl_31 , nor_85_nl , VEC_LOOP_or_84_cse ,
      and_dcpl_73});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_8_nl , VEC_LOOP_mux1h_6_nl , VEC_LOOP_mux1h_4_nl
      , VEC_LOOP_mux1h_2_nl , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl , VEC_LOOP_mux1h_3_nl
      , VEC_LOOP_mux1h_5_nl , VEC_LOOP_mux1h_7_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign twiddle_rsci_adra_d = twiddle_rsci_adra_d_reg;
  assign twiddle_h_rsci_adra_d = twiddle_h_rsci_adra_d_reg;
  assign nor_139_cse = ~((fsm_output[3]) | (fsm_output[0]));
  assign and_196_cse = (~ (fsm_output[4])) & (fsm_output[1]);
  assign and_dcpl_155 = ~((fsm_output[7:6]!=2'b00));
  assign and_dcpl_156 = and_dcpl_155 & (~ (fsm_output[5])) & (~ (fsm_output[2]));
  assign nor_126_cse = ~((fsm_output[4]) | (fsm_output[1]));
  assign and_dcpl_164 = and_dcpl_155 & (fsm_output[5]) & (~ (fsm_output[2]));
  assign and_dcpl_181 = ~((fsm_output!=8'b00000010));
  assign and_dcpl_193 = nor_157_cse & (fsm_output[7]) & (~ (fsm_output[2])) & (fsm_output[4])
      & (~ (fsm_output[1])) & nor_139_cse;
  assign and_dcpl_194 = (fsm_output[3]) & (~ (fsm_output[0]));
  assign and_dcpl_196 = and_196_cse & and_dcpl_194;
  assign and_dcpl_201 = (fsm_output[4]) & (~ (fsm_output[1]));
  assign and_dcpl_202 = and_dcpl_201 & and_dcpl_194;
  assign and_dcpl_207 = and_196_cse & nor_139_cse;
  assign and_dcpl_208 = (fsm_output[6:5]==2'b01);
  assign and_dcpl_212 = nor_126_cse & and_dcpl_194;
  assign and_dcpl_213 = and_dcpl_208 & and_dcpl_17;
  assign and_dcpl_215 = (fsm_output[4]) & (fsm_output[1]);
  assign and_dcpl_216 = and_dcpl_215 & nor_139_cse;
  assign and_dcpl_220 = and_dcpl_51 & and_dcpl_24;
  assign and_dcpl_223 = and_dcpl_201 & nor_139_cse;
  assign and_dcpl_224 = and_dcpl_51 & and_dcpl_17;
  assign and_dcpl_226 = and_dcpl_215 & and_dcpl_194;
  assign and_dcpl_229 = nor_tmp_20 & and_dcpl_24;
  assign and_dcpl_238 = nor_157_cse & (fsm_output[7]) & (~ (fsm_output[2]));
  assign and_dcpl_369 = nor_157_cse & and_dcpl_17;
  assign and_dcpl_370 = and_dcpl_369 & nor_126_cse & (~ (fsm_output[3])) & (~ (fsm_output[0]));
  assign or_tmp_306 = (fsm_output[1]) | (fsm_output[7]) | (~ (fsm_output[3]));
  assign or_413_nl = (fsm_output[7]) | (fsm_output[3]);
  assign or_412_nl = (fsm_output[7]) | (~ (fsm_output[3]));
  assign mux_437_nl = MUX_s_1_2_2(or_413_nl, or_412_nl, fsm_output[1]);
  assign mux_418_nl = MUX_s_1_2_2(mux_437_nl, or_tmp_306, fsm_output[5]);
  assign mux_tmp_419 = MUX_s_1_2_2(or_tmp_280, mux_418_nl, fsm_output[6]);
  assign not_tmp_282 = MUX_s_1_2_2((fsm_output[3]), (~ (fsm_output[3])), fsm_output[7]);
  assign nand_33_nl = ~((fsm_output[1]) & not_tmp_282);
  assign mux_424_nl = MUX_s_1_2_2(nand_33_nl, or_tmp_306, fsm_output[5]);
  assign or_416_nl = (fsm_output[6]) | mux_424_nl;
  assign mux_425_nl = MUX_s_1_2_2(mux_tmp_419, or_416_nl, fsm_output[2]);
  assign and_596_nl = (fsm_output[7]) & (fsm_output[3]);
  assign mux_421_nl = MUX_s_1_2_2(not_tmp_282, and_596_nl, fsm_output[1]);
  assign or_415_nl = (fsm_output[5]) | (~ mux_421_nl);
  assign mux_422_nl = MUX_s_1_2_2(or_415_nl, or_tmp_280, fsm_output[6]);
  assign mux_423_nl = MUX_s_1_2_2(mux_422_nl, mux_tmp_419, fsm_output[2]);
  assign mux_426_nl = MUX_s_1_2_2(mux_425_nl, mux_423_nl, fsm_output[4]);
  assign and_dcpl_371 = ~(mux_426_nl | (fsm_output[0]));
  assign and_dcpl_372 = (~ (fsm_output[3])) & (fsm_output[0]);
  assign and_dcpl_374 = and_196_cse & and_dcpl_372;
  assign and_dcpl_378 = and_dcpl_208 & (fsm_output[7]) & (~ (fsm_output[2])) & and_dcpl_374;
  assign and_dcpl_379 = (fsm_output[3]) & (fsm_output[0]);
  assign and_dcpl_381 = and_dcpl_215 & and_dcpl_379;
  assign and_dcpl_383 = and_dcpl_213 & and_dcpl_381;
  assign and_dcpl_384 = and_dcpl_215 & and_dcpl_372;
  assign and_dcpl_388 = and_dcpl_51 & and_dcpl_24 & and_dcpl_384;
  assign and_dcpl_389 = and_196_cse & and_dcpl_379;
  assign and_dcpl_391 = nor_157_cse & (fsm_output[7]) & (fsm_output[2]);
  assign and_dcpl_392 = and_dcpl_391 & and_dcpl_389;
  assign and_dcpl_394 = and_dcpl_391 & nor_126_cse & and_dcpl_372;
  assign and_dcpl_398 = and_dcpl_51 & and_dcpl_17 & and_dcpl_201 & and_dcpl_379;
  assign and_dcpl_400 = and_dcpl_213 & and_dcpl_201 & and_dcpl_372;
  assign and_dcpl_403 = nor_tmp_20 & and_dcpl_24 & and_dcpl_381;
  assign and_dcpl_405 = nor_tmp_20 & and_dcpl_17 & and_dcpl_374;
  assign and_dcpl_407 = and_dcpl_208 & and_dcpl_24 & and_dcpl_389;
  assign and_dcpl_408 = and_dcpl_369 & and_dcpl_384;
  assign and_dcpl_410 = and_dcpl_369 & nor_126_cse & and_dcpl_379;
  assign or_tmp_313 = (~ (fsm_output[4])) | (fsm_output[2]) | (fsm_output[7]);
  assign or_424_nl = (fsm_output[2]) | (~ (fsm_output[7]));
  assign nand_nl = ~((fsm_output[2]) & (fsm_output[7]));
  assign mux_427_nl = MUX_s_1_2_2(or_424_nl, nand_nl, fsm_output[4]);
  assign mux_428_nl = MUX_s_1_2_2(mux_427_nl, or_tmp_313, fsm_output[5]);
  assign or_417_nl = (fsm_output[5]) | (fsm_output[4]) | (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_tmp_429 = MUX_s_1_2_2(mux_428_nl, or_417_nl, fsm_output[6]);
  assign or_420_nl = (fsm_output[4]) | (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_tmp_430 = MUX_s_1_2_2(or_tmp_313, or_420_nl, fsm_output[5]);
  assign or_422_nl = (fsm_output[2]) | (fsm_output[7]);
  assign or_421_nl = (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_tmp_431 = MUX_s_1_2_2(or_422_nl, or_421_nl, fsm_output[4]);
  assign nand_32_nl = ~((fsm_output[5]) & (~ mux_tmp_431));
  assign mux_434_nl = MUX_s_1_2_2(mux_tmp_430, nand_32_nl, fsm_output[6]);
  assign mux_435_nl = MUX_s_1_2_2(mux_tmp_429, mux_434_nl, fsm_output[1]);
  assign or_423_nl = (fsm_output[5]) | mux_tmp_431;
  assign mux_432_nl = MUX_s_1_2_2(or_423_nl, mux_tmp_430, fsm_output[6]);
  assign mux_433_nl = MUX_s_1_2_2(mux_432_nl, mux_tmp_429, fsm_output[1]);
  assign mux_436_nl = MUX_s_1_2_2(mux_435_nl, mux_433_nl, fsm_output[3]);
  assign and_dcpl_418 = (~ mux_436_nl) & (fsm_output[0]);
  assign and_dcpl_425 = nor_157_cse & and_dcpl_17 & nor_126_cse & nor_139_cse;
  assign and_dcpl_430 = and_dcpl_51 & and_dcpl_17 & and_dcpl_201 & nor_139_cse;
  assign and_dcpl_435 = (fsm_output[6:5]==2'b01) & and_dcpl_17 & nor_126_cse & and_dcpl_194;
  assign and_dcpl_439 = (fsm_output[6:5]==2'b11) & and_dcpl_17 & and_dcpl_201 & and_dcpl_194;
  assign and_dcpl_444 = nor_157_cse & (fsm_output[7]) & (~ (fsm_output[2])) & and_dcpl_201
      & and_dcpl_379;
  assign and_dcpl_448 = and_dcpl_51 & (~ (fsm_output[7])) & (~ (fsm_output[2])) &
      nor_126_cse & and_dcpl_379;
  assign and_dcpl_471 = nor_126_cse & nor_139_cse;
  assign and_dcpl_475 = and_dcpl_208 & and_dcpl_24 & and_dcpl_471;
  assign and_dcpl_479 = and_dcpl_208 & and_dcpl_17 & and_dcpl_223;
  assign and_dcpl_482 = and_dcpl_51 & and_dcpl_24 & and_dcpl_212;
  assign and_dcpl_485 = and_dcpl_51 & and_dcpl_17 & and_dcpl_202;
  assign and_dcpl_488 = (fsm_output[6:5]==2'b11) & and_dcpl_24 & and_dcpl_223;
  assign and_dcpl_491 = nor_157_cse & (fsm_output[7]) & (fsm_output[2]) & and_dcpl_471;
  assign and_dcpl_494 = nor_157_cse & (fsm_output[7]) & (~ (fsm_output[2])) & and_dcpl_202;
  assign and_dcpl_501 = nor_157_cse & and_dcpl_17 & and_dcpl_216;
  assign and_dcpl_508 = and_dcpl_208 & and_dcpl_24 & and_dcpl_196;
  assign and_dcpl_511 = and_dcpl_208 & and_dcpl_17 & and_dcpl_226;
  assign and_dcpl_514 = (fsm_output[6:5]==2'b10) & and_dcpl_24 & and_dcpl_216;
  assign and_dcpl_518 = nor_tmp_20 & and_dcpl_17 & and_196_cse & nor_139_cse;
  assign and_dcpl_520 = nor_tmp_20 & and_dcpl_24 & and_dcpl_226;
  assign and_dcpl_523 = nor_157_cse & (fsm_output[7]) & (fsm_output[2]) & and_dcpl_196;
  assign and_dcpl_530 = nor_157_cse & and_dcpl_24 & and_dcpl_201 & and_dcpl_194;
  assign and_dcpl_536 = (fsm_output[6:5]==2'b10) & and_dcpl_24 & nor_126_cse & nor_139_cse;
  assign and_dcpl_539 = (fsm_output[6:5]==2'b11) & and_dcpl_24;
  assign and_dcpl_540 = and_dcpl_539 & nor_126_cse & and_dcpl_194;
  assign and_dcpl_544 = nor_157_cse & (fsm_output[7]) & (~ (fsm_output[2])) & and_dcpl_201
      & nor_139_cse;
  assign and_dcpl_547 = and_dcpl_539 & and_dcpl_201 & and_dcpl_372;
  assign and_dcpl_551 = (fsm_output[6:5]==2'b01) & and_dcpl_24 & nor_126_cse & and_dcpl_372;
  assign or_425_nl = (fsm_output[6]) | (fsm_output[3]) | (fsm_output[4]) | (fsm_output[2]);
  assign mux_tmp = MUX_s_1_2_2((fsm_output[6]), or_425_nl, fsm_output[5]);
  assign not_tmp = ~((fsm_output[6:1]!=6'b000000));
  assign or_tmp_321 = (~ (fsm_output[4])) | (~ (fsm_output[1])) | (fsm_output[2]);
  assign nor_tmp = (fsm_output[2:1]==2'b11);
  assign mux_tmp_443 = MUX_s_1_2_2((~ nor_tmp), or_272_cse, fsm_output[4]);
  assign or_tmp_326 = ~((~((fsm_output[1:0]==2'b11))) & (fsm_output[2]));
  assign mux_tmp_444 = MUX_s_1_2_2(or_272_cse, or_tmp_326, fsm_output[4]);
  assign or_tmp_328 = (fsm_output[0]) | (~ (fsm_output[2]));
  assign or_tmp_334 = (fsm_output[5]) | (fsm_output[1]);
  assign mux_tmp_455 = MUX_s_1_2_2((fsm_output[5]), or_tmp_334, fsm_output[0]);
  assign or_tmp_335 = (~ (fsm_output[3])) | (fsm_output[7]) | mux_tmp_455;
  assign not_tmp_344 = ~((fsm_output[5]) & (fsm_output[1]));
  assign or_tmp_336 = (fsm_output[7]) | not_tmp_344;
  assign mux_457_nl = MUX_s_1_2_2((~ (fsm_output[1])), (fsm_output[1]), fsm_output[5]);
  assign mux_458_nl = MUX_s_1_2_2((~ or_tmp_334), mux_457_nl, fsm_output[0]);
  assign or_443_nl = (fsm_output[7]) | mux_458_nl;
  assign mux_tmp_458 = MUX_s_1_2_2(or_443_nl, or_tmp_336, fsm_output[3]);
  assign nor_tmp_51 = (fsm_output[5]) & (fsm_output[3]) & (fsm_output[2]);
  assign or_tmp_347 = (fsm_output[3:0]!=4'b1000);
  assign and_244_itm = nor_157_cse & and_dcpl_17 & and_dcpl_196;
  assign and_254_itm = and_dcpl_208 & and_dcpl_24 & and_dcpl_207;
  assign and_280_cse = nor_157_cse & (fsm_output[7]) & (fsm_output[2]) & and_dcpl_207;
  assign VEC_LOOP_nor_5_itm = ~(and_dcpl_371 | and_dcpl_378 | and_dcpl_383 | and_dcpl_388
      | and_dcpl_392 | and_dcpl_394 | and_dcpl_398 | and_dcpl_400 | and_dcpl_403
      | and_dcpl_405 | and_dcpl_407 | and_dcpl_408 | and_dcpl_410);
  assign VEC_LOOP_or_65_itm = and_dcpl_383 | and_dcpl_388 | and_dcpl_392 | and_dcpl_394
      | and_dcpl_398 | and_dcpl_400 | and_dcpl_403 | and_dcpl_405 | and_dcpl_407
      | and_dcpl_408 | and_dcpl_410;
  assign VEC_LOOP_or_60_itm = and_dcpl_435 | and_dcpl_439;
  assign VEC_LOOP_or_69_itm = and_dcpl_430 | and_dcpl_448;
  assign COMP_LOOP_twiddle_f_or_16_itm = and_dcpl_511 | and_dcpl_518 | and_dcpl_523;
  assign COMP_LOOP_twiddle_f_nor_2_itm = ~(and_dcpl_508 | and_dcpl_514 | and_dcpl_520);
  assign COMP_LOOP_twiddle_f_or_17_itm = and_dcpl_508 | and_dcpl_520;
  assign VEC_LOOP_or_72_itm = and_dcpl_547 | and_dcpl_551;
  assign VEC_LOOP_nor_15_itm = ~(and_dcpl_547 | and_dcpl_551);
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp ) begin
      VEC_LOOP_mult_vec_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
          and_dcpl_148);
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
      reg_run_rsci_oswt_cse <= ~(or_dcpl_68 | (fsm_output[2]) | (fsm_output[7]) |
          or_116_cse);
      reg_vec_rsci_oswt_cse <= ~ mux_140_itm;
      reg_vec_rsci_oswt_1_cse <= nor_88_cse;
      reg_twiddle_rsci_oswt_cse <= nor_84_rmff;
      reg_complete_rsci_oswt_cse <= (~ or_98_cse) & (~ (fsm_output[4])) & (~ (fsm_output[3]))
          & (fsm_output[2]) & (fsm_output[7]) & (~ (fsm_output[1])) & (~ (fsm_output[0]))
          & STAGE_LOOP_acc_itm_4_1;
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_121;
      reg_ensig_cgo_cse <= ~ mux_241_itm;
      reg_ensig_cgo_2_cse <= ~ mux_265_itm;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_21 & and_dcpl_33) | STAGE_LOOP_i_3_0_sva_mx0c1)
        ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, z_out_1, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_277_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_279 ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( mux_441_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_14_4_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (z_out_15[9:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_284_nl | (fsm_output[7:6]!=2'b00)) ) begin
      COMP_LOOP_1_twiddle_f_acc_cse_sva <= z_out_1;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (VEC_LOOP_j_1_sva_mx0c0 | (~(mux_240_cse | (fsm_output[0])))
        | and_dcpl_87) ) begin
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
    else if ( complete_rsci_wen_comp & (and_dcpl_22 | and_dcpl_121) ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_18_itm <= MUX_s_1_2_2((z_out_12[18]),
          run_rsci_ivld_mxwt, and_dcpl_121);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_22 | and_dcpl_31 | and_dcpl_36 | and_dcpl_41
        | and_dcpl_43 | and_dcpl_50 | and_dcpl_53 | and_dcpl_55 | and_dcpl_57 | and_dcpl_60
        | and_dcpl_62 | and_dcpl_64 | and_dcpl_66 | and_dcpl_69 | and_dcpl_73 | and_dcpl_75)
        ) begin
      VEC_LOOP_acc_10_cse_1_sva <= MUX_v_14_2_2(z_out_2, acc_3_cse_14_1, VEC_LOOP_or_49_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_dcpl_68 | (~ (fsm_output[2])) | (fsm_output[7])
        | or_116_cse)) ) begin
      VEC_LOOP_j_1_sva_1 <= z_out_13;
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_455_nl) & complete_rsci_wen_comp ) begin
      reg_VEC_LOOP_acc_1_reg <= VEC_LOOP_and_4_rgt[13:10];
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_472_nl) & complete_rsci_wen_comp ) begin
      reg_VEC_LOOP_acc_1_1_reg <= VEC_LOOP_and_4_rgt[9:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((nor_157_cse & (~((fsm_output[1]) ^ (fsm_output[3])))
        & (~ (fsm_output[4])) & (fsm_output[2]) & (~ (fsm_output[7])) & (fsm_output[0]))
        | and_dcpl_148) ) begin
      factor1_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
          and_dcpl_148);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~ mux_370_nl) ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_14_0_sva_1 <= 15'b000000000000000;
    end
    else if ( complete_rsci_wen_comp & (~(mux_380_nl | (fsm_output[0]))) ) begin
      VEC_LOOP_j_10_14_0_sva_1 <= z_out_12[14:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_383_nl ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva <= COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( mux_479_nl & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_11_psp_sva_12 <= VEC_LOOP_VEC_LOOP_mux_2_rgt[12];
    end
  end
  always @(posedge clk) begin
    if ( mux_484_nl & nor_45_cse_1 & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_11_psp_sva_11_0 <= VEC_LOOP_VEC_LOOP_mux_2_rgt[11:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_401_nl | (fsm_output[7])) ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva <= z_out[11:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_414_nl | (fsm_output[7])) ) begin
      COMP_LOOP_9_twiddle_f_lshift_itm <= MUX_v_11_2_2((z_out[10:0]), (z_out_14[10:0]),
          and_dcpl_57);
    end
  end
  assign mux_276_nl = MUX_s_1_2_2((~ or_tmp_197), or_397_cse, fsm_output[7]);
  assign mux_277_nl = MUX_s_1_2_2(mux_276_nl, nor_tmp_14, or_116_cse);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_279;
  assign mux_440_nl = MUX_s_1_2_2(not_tmp, mux_tmp, fsm_output[7]);
  assign mux_438_nl = MUX_s_1_2_2(mux_tmp, or_cse, fsm_output[1]);
  assign mux_439_nl = MUX_s_1_2_2(not_tmp, mux_438_nl, fsm_output[7]);
  assign mux_441_nl = MUX_s_1_2_2(mux_440_nl, mux_439_nl, fsm_output[0]);
  assign mux_43_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[4]);
  assign mux_44_nl = MUX_s_1_2_2(mux_43_nl, nor_tmp_4, fsm_output[3]);
  assign mux_284_nl = MUX_s_1_2_2(mux_44_nl, and_176_cse, or_272_cse);
  assign VEC_LOOP_mux_2_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z,
      VEC_LOOP_j_1_sva_1, and_dcpl_87);
  assign VEC_LOOP_j_not_1_nl = ~ VEC_LOOP_j_1_sva_mx0c0;
  assign VEC_LOOP_or_49_nl = and_dcpl_31 | and_dcpl_60 | VEC_LOOP_or_51_cse | VEC_LOOP_or_50_cse
      | VEC_LOOP_or_55_cse | VEC_LOOP_or_53_cse | VEC_LOOP_or_52_cse | VEC_LOOP_or_54_cse;
  assign nand_40_nl = ~(((~ (fsm_output[4])) | (fsm_output[1])) & (fsm_output[2]));
  assign mux_452_nl = MUX_s_1_2_2(nand_40_nl, or_tmp_321, fsm_output[6]);
  assign or_437_nl = (fsm_output[6]) | (fsm_output[4]) | or_tmp_326;
  assign mux_453_nl = MUX_s_1_2_2(mux_452_nl, or_437_nl, fsm_output[7]);
  assign mux_449_nl = MUX_s_1_2_2((~ or_tmp_328), or_tmp_328, fsm_output[1]);
  assign or_435_nl = (fsm_output[4]) | mux_449_nl;
  assign mux_450_nl = MUX_s_1_2_2(or_435_nl, mux_tmp_444, fsm_output[6]);
  assign or_433_nl = (fsm_output[6]) | mux_tmp_443;
  assign mux_451_nl = MUX_s_1_2_2(mux_450_nl, or_433_nl, fsm_output[7]);
  assign mux_454_nl = MUX_s_1_2_2(mux_453_nl, mux_451_nl, fsm_output[3]);
  assign mux_446_nl = MUX_s_1_2_2(mux_tmp_444, mux_tmp_443, fsm_output[6]);
  assign or_430_nl = (fsm_output[6]) | (fsm_output[4]) | (~ (fsm_output[1])) | (fsm_output[0])
      | (fsm_output[2]);
  assign mux_447_nl = MUX_s_1_2_2(mux_446_nl, or_430_nl, fsm_output[7]);
  assign nor_162_nl = ~((fsm_output[2:1]!=2'b01));
  assign mux_442_nl = MUX_s_1_2_2(nor_162_nl, nor_tmp, fsm_output[4]);
  assign mux_443_nl = MUX_s_1_2_2((~ mux_442_nl), or_tmp_321, fsm_output[6]);
  assign or_429_nl = (fsm_output[7]) | mux_443_nl;
  assign mux_448_nl = MUX_s_1_2_2(mux_447_nl, or_429_nl, fsm_output[3]);
  assign mux_455_nl = MUX_s_1_2_2(mux_454_nl, mux_448_nl, fsm_output[5]);
  assign or_449_nl = (~ (fsm_output[5])) | (fsm_output[1]);
  assign mux_467_nl = MUX_s_1_2_2((~ (fsm_output[5])), or_449_nl, fsm_output[0]);
  assign or_448_nl = (fsm_output[0]) | not_tmp_344;
  assign mux_468_nl = MUX_s_1_2_2(mux_467_nl, or_448_nl, fsm_output[7]);
  assign mux_469_nl = MUX_s_1_2_2(mux_468_nl, or_tmp_336, fsm_output[3]);
  assign mux_470_nl = MUX_s_1_2_2(mux_469_nl, or_tmp_335, fsm_output[6]);
  assign or_447_nl = (fsm_output[0]) | (fsm_output[5]) | (fsm_output[1]);
  assign mux_464_nl = MUX_s_1_2_2(or_447_nl, mux_tmp_455, fsm_output[7]);
  assign or_446_nl = (fsm_output[5]) | (~ (fsm_output[1]));
  assign nor_153_nl = ~((fsm_output[7]) | (~ (fsm_output[0])));
  assign mux_463_nl = MUX_s_1_2_2(or_446_nl, or_tmp_334, nor_153_nl);
  assign mux_465_nl = MUX_s_1_2_2(mux_464_nl, mux_463_nl, fsm_output[3]);
  assign or_445_nl = (fsm_output[3]) | (fsm_output[7]) | not_tmp_344;
  assign mux_466_nl = MUX_s_1_2_2(mux_465_nl, or_445_nl, fsm_output[6]);
  assign mux_471_nl = MUX_s_1_2_2(mux_470_nl, mux_466_nl, fsm_output[2]);
  assign nand_38_nl = ~((fsm_output[3]) & (fsm_output[7]) & (~ mux_tmp_455));
  assign mux_461_nl = MUX_s_1_2_2(nand_38_nl, mux_tmp_458, fsm_output[6]);
  assign mux_460_nl = MUX_s_1_2_2(mux_tmp_458, or_tmp_335, fsm_output[6]);
  assign mux_462_nl = MUX_s_1_2_2(mux_461_nl, mux_460_nl, fsm_output[2]);
  assign mux_472_nl = MUX_s_1_2_2(mux_471_nl, mux_462_nl, fsm_output[4]);
  assign nor_48_nl = ~(and_164_cse | (fsm_output[6:5]!=2'b00));
  assign mux_369_nl = MUX_s_1_2_2(or_tmp_275, nor_48_nl, fsm_output[7]);
  assign mux_368_nl = MUX_s_1_2_2(or_tmp_273, (~ or_tmp_272), fsm_output[7]);
  assign mux_370_nl = MUX_s_1_2_2(mux_369_nl, mux_368_nl, or_116_cse);
  assign or_368_nl = (~ (fsm_output[3])) | (~ (fsm_output[7])) | (fsm_output[5]);
  assign mux_377_nl = MUX_s_1_2_2(mux_tmp_374, or_368_nl, fsm_output[1]);
  assign mux_378_nl = MUX_s_1_2_2(mux_377_nl, or_tmp_280, fsm_output[6]);
  assign mux_379_nl = MUX_s_1_2_2(mux_tmp_373, mux_378_nl, fsm_output[4]);
  assign or_366_nl = (~ (fsm_output[3])) | (fsm_output[7]) | (~ (fsm_output[5]));
  assign mux_375_nl = MUX_s_1_2_2(or_366_nl, mux_tmp_374, fsm_output[1]);
  assign or_367_nl = (fsm_output[6]) | mux_375_nl;
  assign mux_376_nl = MUX_s_1_2_2(or_367_nl, mux_tmp_373, fsm_output[4]);
  assign mux_380_nl = MUX_s_1_2_2(mux_379_nl, mux_376_nl, fsm_output[2]);
  assign mux_382_nl = MUX_s_1_2_2((~ or_tmp_272), or_tmp_275, fsm_output[7]);
  assign nor_47_nl = ~((((fsm_output[3:2]!=2'b00)) & (fsm_output[4])) | (fsm_output[6:5]!=2'b00));
  assign mux_381_nl = MUX_s_1_2_2(nor_47_nl, or_tmp_273, fsm_output[7]);
  assign mux_383_nl = MUX_s_1_2_2(mux_382_nl, mux_381_nl, and_169_cse);
  assign or_455_nl = (fsm_output[3:1]!=3'b000);
  assign mux_476_nl = MUX_s_1_2_2(or_tmp_347, or_455_nl, fsm_output[5]);
  assign mux_477_nl = MUX_s_1_2_2(nor_tmp_51, (~ mux_476_nl), fsm_output[4]);
  assign or_454_nl = (fsm_output[3:0]!=4'b0000);
  assign mux_474_nl = MUX_s_1_2_2(or_454_nl, or_tmp_347, fsm_output[5]);
  assign mux_475_nl = MUX_s_1_2_2((~ mux_474_nl), nor_tmp_51, fsm_output[4]);
  assign mux_478_nl = MUX_s_1_2_2(mux_477_nl, mux_475_nl, fsm_output[6]);
  assign or_451_nl = (fsm_output[5]) | (fsm_output[3]) | (fsm_output[1]) | (fsm_output[2]);
  assign or_450_nl = (fsm_output[5]) | (fsm_output[0]) | (fsm_output[3]) | (fsm_output[1])
      | (fsm_output[2]);
  assign mux_473_nl = MUX_s_1_2_2(or_451_nl, or_450_nl, fsm_output[4]);
  assign nor_161_nl = ~((fsm_output[6]) | mux_473_nl);
  assign mux_479_nl = MUX_s_1_2_2(mux_478_nl, nor_161_nl, fsm_output[7]);
  assign nor_156_nl = ~((fsm_output[6:4]!=3'b100));
  assign mux_481_nl = MUX_s_1_2_2(nor_tmp_20, nor_157_cse, fsm_output[4]);
  assign mux_482_nl = MUX_s_1_2_2(nor_156_nl, mux_481_nl, fsm_output[3]);
  assign nor_158_nl = ~((fsm_output[6:5]!=2'b01));
  assign mux_480_nl = MUX_s_1_2_2(nor_158_nl, nor_tmp_20, fsm_output[4]);
  assign and_603_nl = (fsm_output[3]) & mux_480_nl;
  assign mux_483_nl = MUX_s_1_2_2(mux_482_nl, and_603_nl, fsm_output[2]);
  assign mux_484_nl = MUX_s_1_2_2(mux_483_nl, nor_159_cse, fsm_output[7]);
  assign mux_398_nl = MUX_s_1_2_2(nor_157_cse, mux_tmp_99, and_159_cse);
  assign mux_399_nl = MUX_s_1_2_2((~ or_397_cse), mux_398_nl, fsm_output[2]);
  assign mux_397_nl = MUX_s_1_2_2(nor_157_cse, mux_tmp_99, and_164_cse);
  assign mux_400_nl = MUX_s_1_2_2(mux_399_nl, mux_397_nl, fsm_output[1]);
  assign and_161_nl = ((fsm_output[2:1]!=2'b00)) & (fsm_output[4:3]==2'b11);
  assign mux_396_nl = MUX_s_1_2_2(nor_157_cse, mux_tmp_99, and_161_nl);
  assign mux_401_nl = MUX_s_1_2_2(mux_400_nl, mux_396_nl, fsm_output[0]);
  assign mux_412_nl = MUX_s_1_2_2(mux_tmp_403, mux_tmp_406, fsm_output[2]);
  assign mux_410_nl = MUX_s_1_2_2(mux_tmp_403, mux_tmp_405, fsm_output[3]);
  assign mux_411_nl = MUX_s_1_2_2(mux_410_nl, mux_tmp_404, fsm_output[2]);
  assign mux_413_nl = MUX_s_1_2_2(mux_412_nl, mux_411_nl, fsm_output[1]);
  assign mux_408_nl = MUX_s_1_2_2(mux_tmp_403, mux_tmp_402, and_158_cse);
  assign mux_407_nl = MUX_s_1_2_2(mux_tmp_406, mux_tmp_404, fsm_output[2]);
  assign mux_409_nl = MUX_s_1_2_2(mux_408_nl, mux_407_nl, fsm_output[1]);
  assign mux_414_nl = MUX_s_1_2_2(mux_413_nl, mux_409_nl, fsm_output[0]);
  assign STAGE_LOOP_mux_3_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (~ STAGE_LOOP_i_3_0_sva),
      and_dcpl_181);
  assign nl_z_out_1 = STAGE_LOOP_mux_3_nl + conv_s2u_2_4({and_dcpl_181 , 1'b1});
  assign z_out_1 = nl_z_out_1[3:0];
  assign VEC_LOOP_mux_23_nl = MUX_v_14_2_2(({(z_out_15[9:0]) , (STAGE_LOOP_lshift_psp_sva[4:1])}),
      z_out_3, and_dcpl_193);
  assign VEC_LOOP_mux_24_nl = MUX_v_14_2_2((VEC_LOOP_j_1_sva[13:0]), ({reg_VEC_LOOP_acc_1_reg
      , reg_VEC_LOOP_acc_1_1_reg}), and_dcpl_193);
  assign nl_z_out_2 = VEC_LOOP_mux_23_nl + VEC_LOOP_mux_24_nl;
  assign z_out_2 = nl_z_out_2[13:0];
  assign and_610_nl = nor_157_cse & and_dcpl_24 & and_dcpl_202;
  assign and_611_nl = and_dcpl_213 & and_dcpl_212;
  assign and_612_nl = and_dcpl_213 & and_dcpl_216;
  assign and_613_nl = and_dcpl_220 & nor_126_cse & nor_139_cse;
  assign and_614_nl = and_dcpl_220 & and_dcpl_196;
  assign and_615_nl = and_dcpl_224 & and_dcpl_223;
  assign and_616_nl = and_dcpl_224 & and_dcpl_226;
  assign and_617_nl = and_dcpl_229 & and_dcpl_212;
  assign and_618_nl = and_dcpl_229 & and_dcpl_216;
  assign and_619_nl = nor_tmp_20 & and_dcpl_17 & and_dcpl_202;
  assign and_620_nl = and_dcpl_238 & and_dcpl_223;
  assign VEC_LOOP_mux1h_32_nl = MUX1HOT_v_4_14_2(4'b0001, 4'b0010, 4'b0011, 4'b0100,
      4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101,
      4'b1110, {and_244_itm , and_610_nl , and_254_itm , and_611_nl , and_612_nl
      , and_613_nl , and_614_nl , and_615_nl , and_616_nl , and_617_nl , and_618_nl
      , and_619_nl , and_280_cse , and_620_nl});
  assign and_621_nl = and_dcpl_238 & and_dcpl_226;
  assign VEC_LOOP_or_76_nl = MUX_v_4_2_2(VEC_LOOP_mux1h_32_nl, 4'b1111, and_621_nl);
  assign nl_z_out_3 = ({COMP_LOOP_k_14_4_sva_9_0 , VEC_LOOP_or_76_nl}) + (STAGE_LOOP_lshift_psp_sva[14:1]);
  assign z_out_3 = nl_z_out_3[13:0];
  assign nl_acc_3_cse_14_1 = z_out_3 + ({reg_VEC_LOOP_acc_1_reg , reg_VEC_LOOP_acc_1_1_reg});
  assign acc_3_cse_14_1 = nl_acc_3_cse_14_1[13:0];
  assign and_622_nl = and_dcpl_208 & and_dcpl_17 & and_dcpl_216;
  assign and_623_nl = and_dcpl_51 & and_dcpl_24 & and_dcpl_196;
  assign and_624_nl = and_dcpl_51 & and_dcpl_17 & and_dcpl_226;
  assign and_625_nl = (fsm_output[6:5]==2'b11) & and_dcpl_24 & and_dcpl_216;
  assign VEC_LOOP_mux1h_33_nl = MUX1HOT_v_3_6_2(3'b110, 3'b101, 3'b100, 3'b011, 3'b010,
      3'b001, {and_254_itm , and_622_nl , and_623_nl , and_624_nl , and_625_nl ,
      and_280_cse});
  assign VEC_LOOP_nor_19_nl = ~(MUX_v_3_2_2(VEC_LOOP_mux1h_33_nl, 3'b111, and_244_itm));
  assign and_626_nl = nor_157_cse & (fsm_output[7]) & (~ (fsm_output[2])) & and_dcpl_226;
  assign VEC_LOOP_or_77_nl = MUX_v_3_2_2(VEC_LOOP_nor_19_nl, 3'b111, and_626_nl);
  assign nl_z_out_7 = ({reg_VEC_LOOP_acc_1_reg , reg_VEC_LOOP_acc_1_1_reg}) + ({COMP_LOOP_k_14_4_sva_9_0
      , VEC_LOOP_or_77_nl , 1'b1});
  assign z_out_7 = nl_z_out_7[13:0];
  assign VEC_LOOP_VEC_LOOP_and_5_nl = (z_out_13[31]) & VEC_LOOP_nor_5_itm;
  assign VEC_LOOP_VEC_LOOP_and_6_nl = (z_out_13[30]) & VEC_LOOP_nor_5_itm;
  assign VEC_LOOP_VEC_LOOP_and_7_nl = (z_out_13[29]) & VEC_LOOP_nor_5_itm;
  assign VEC_LOOP_mux_25_nl = MUX_s_1_2_2((z_out_13[28]), (z_out_15[10]), and_dcpl_378);
  assign VEC_LOOP_VEC_LOOP_or_12_nl = (VEC_LOOP_mux_25_nl & (~ and_dcpl_371)) | and_dcpl_383
      | and_dcpl_388 | and_dcpl_392 | and_dcpl_394 | and_dcpl_398 | and_dcpl_400
      | and_dcpl_403 | and_dcpl_405 | and_dcpl_407 | and_dcpl_408 | and_dcpl_410;
  assign VEC_LOOP_mux1h_34_nl = MUX1HOT_v_14_4_2((z_out_13[27:14]), ({reg_VEC_LOOP_acc_1_reg
      , reg_VEC_LOOP_acc_1_1_reg}), ({(z_out_15[9:0]) , 4'b0000}), (~ (STAGE_LOOP_lshift_psp_sva[14:1])),
      {and_dcpl_370 , and_dcpl_371 , and_dcpl_378 , VEC_LOOP_or_65_itm});
  assign VEC_LOOP_or_78_nl = (~(and_dcpl_370 | and_dcpl_371)) | and_dcpl_378 | and_dcpl_383
      | and_dcpl_388 | and_dcpl_392 | and_dcpl_394 | and_dcpl_398 | and_dcpl_400
      | and_dcpl_403 | and_dcpl_405 | and_dcpl_407 | and_dcpl_408 | and_dcpl_410;
  assign VEC_LOOP_VEC_LOOP_or_13_nl = ((STAGE_LOOP_lshift_psp_sva[14]) & (~(and_dcpl_383
      | and_dcpl_388 | and_dcpl_392 | and_dcpl_394 | and_dcpl_398 | and_dcpl_400
      | and_dcpl_403 | and_dcpl_405 | and_dcpl_407 | and_dcpl_408 | and_dcpl_410)))
      | and_dcpl_370 | and_dcpl_378;
  assign VEC_LOOP_mux1h_35_nl = MUX1HOT_v_10_3_2((STAGE_LOOP_lshift_psp_sva[13:4]),
      (~ (STAGE_LOOP_lshift_psp_sva[14:5])), COMP_LOOP_k_14_4_sva_9_0, {and_dcpl_371
      , and_dcpl_378 , VEC_LOOP_or_65_itm});
  assign VEC_LOOP_or_79_nl = MUX_v_10_2_2(VEC_LOOP_mux1h_35_nl, 10'b1111111111, and_dcpl_370);
  assign VEC_LOOP_mux_26_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[3]), (~ (STAGE_LOOP_lshift_psp_sva[4])),
      and_dcpl_378);
  assign VEC_LOOP_VEC_LOOP_or_14_nl = (VEC_LOOP_mux_26_nl & (~(and_dcpl_383 | and_dcpl_400
      | and_dcpl_407 | and_dcpl_408 | and_dcpl_410))) | and_dcpl_370 | and_dcpl_388
      | and_dcpl_392 | and_dcpl_394 | and_dcpl_398 | and_dcpl_403 | and_dcpl_405;
  assign VEC_LOOP_mux_27_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[2]), (~ (STAGE_LOOP_lshift_psp_sva[3])),
      and_dcpl_378);
  assign VEC_LOOP_VEC_LOOP_or_15_nl = (VEC_LOOP_mux_27_nl & (~(and_dcpl_388 | and_dcpl_398
      | and_dcpl_405 | and_dcpl_408 | and_dcpl_410))) | and_dcpl_370 | and_dcpl_383
      | and_dcpl_392 | and_dcpl_394 | and_dcpl_400 | and_dcpl_403 | and_dcpl_407;
  assign VEC_LOOP_mux_28_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[1]), (~ (STAGE_LOOP_lshift_psp_sva[2])),
      and_dcpl_378);
  assign VEC_LOOP_VEC_LOOP_or_16_nl = (VEC_LOOP_mux_28_nl & (~(and_dcpl_388 | and_dcpl_394
      | and_dcpl_398 | and_dcpl_400 | and_dcpl_403 | and_dcpl_407 | and_dcpl_410)))
      | and_dcpl_370 | and_dcpl_383 | and_dcpl_392 | and_dcpl_405 | and_dcpl_408;
  assign VEC_LOOP_mux_29_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[0]), (~ (STAGE_LOOP_lshift_psp_sva[1])),
      and_dcpl_378);
  assign VEC_LOOP_VEC_LOOP_or_17_nl = (VEC_LOOP_mux_29_nl & (~(and_dcpl_383 | and_dcpl_388
      | and_dcpl_392 | and_dcpl_403 | and_dcpl_405 | and_dcpl_407 | and_dcpl_408)))
      | and_dcpl_370 | and_dcpl_394 | and_dcpl_398 | and_dcpl_400 | and_dcpl_410;
  assign nl_acc_11_nl = conv_u2u_19_20({VEC_LOOP_VEC_LOOP_and_5_nl , VEC_LOOP_VEC_LOOP_and_6_nl
      , VEC_LOOP_VEC_LOOP_and_7_nl , VEC_LOOP_VEC_LOOP_or_12_nl , VEC_LOOP_mux1h_34_nl
      , VEC_LOOP_or_78_nl}) + conv_s2u_16_20({VEC_LOOP_VEC_LOOP_or_13_nl , VEC_LOOP_or_79_nl
      , VEC_LOOP_VEC_LOOP_or_14_nl , VEC_LOOP_VEC_LOOP_or_15_nl , VEC_LOOP_VEC_LOOP_or_16_nl
      , VEC_LOOP_VEC_LOOP_or_17_nl , 1'b1});
  assign acc_11_nl = nl_acc_11_nl[19:0];
  assign z_out_12 = readslicef_20_19_1(acc_11_nl);
  assign VEC_LOOP_mux_30_nl = MUX_v_32_2_2(VEC_LOOP_j_1_sva, factor1_1_sva, and_dcpl_418);
  assign VEC_LOOP_or_80_nl = (~(nor_157_cse & (~ (fsm_output[7])) & (fsm_output[2])
      & nor_126_cse & nor_139_cse)) | and_dcpl_418;
  assign VEC_LOOP_mux_31_nl = MUX_v_32_2_2(({17'b00000000000000000 , STAGE_LOOP_lshift_psp_sva}),
      (~ COMP_LOOP_1_mult_cmp_return_rsc_z), and_dcpl_418);
  assign nl_acc_12_nl = ({VEC_LOOP_mux_30_nl , VEC_LOOP_or_80_nl}) + ({VEC_LOOP_mux_31_nl
      , 1'b1});
  assign acc_12_nl = nl_acc_12_nl[32:0];
  assign z_out_13 = readslicef_33_32_1(acc_12_nl);
  assign VEC_LOOP_mux1h_36_nl = MUX1HOT_v_12_5_2(({2'b00 , (VEC_LOOP_j_1_sva[13:4])}),
      ({1'b0 , reg_VEC_LOOP_acc_1_reg , (reg_VEC_LOOP_acc_1_1_reg[9:3])}), ({reg_VEC_LOOP_acc_1_reg
      , (reg_VEC_LOOP_acc_1_1_reg[9:2])}), ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[14:5]))}),
      ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[14:4]))}), {and_dcpl_425 , and_dcpl_430
      , VEC_LOOP_or_60_itm , and_dcpl_444 , and_dcpl_448});
  assign VEC_LOOP_or_81_nl = (~(and_dcpl_425 | and_dcpl_430 | and_dcpl_435 | and_dcpl_439))
      | and_dcpl_444 | and_dcpl_448;
  assign VEC_LOOP_VEC_LOOP_and_8_nl = (COMP_LOOP_k_14_4_sva_9_0[9]) & (~(and_dcpl_425
      | and_dcpl_430 | and_dcpl_444 | and_dcpl_448));
  assign VEC_LOOP_VEC_LOOP_mux_6_nl = MUX_s_1_2_2((COMP_LOOP_k_14_4_sva_9_0[9]),
      (COMP_LOOP_k_14_4_sva_9_0[8]), VEC_LOOP_or_60_itm);
  assign VEC_LOOP_and_22_nl = VEC_LOOP_VEC_LOOP_mux_6_nl & (~(and_dcpl_425 | and_dcpl_444));
  assign VEC_LOOP_or_82_nl = and_dcpl_425 | and_dcpl_444;
  assign VEC_LOOP_mux1h_37_nl = MUX1HOT_v_8_3_2((COMP_LOOP_k_14_4_sva_9_0[9:2]),
      (COMP_LOOP_k_14_4_sva_9_0[8:1]), (COMP_LOOP_k_14_4_sva_9_0[7:0]), {VEC_LOOP_or_82_nl
      , VEC_LOOP_or_69_itm , VEC_LOOP_or_60_itm});
  assign VEC_LOOP_mux_32_nl = MUX_s_1_2_2((COMP_LOOP_k_14_4_sva_9_0[1]), (COMP_LOOP_k_14_4_sva_9_0[0]),
      VEC_LOOP_or_69_itm);
  assign VEC_LOOP_VEC_LOOP_or_18_nl = (VEC_LOOP_mux_32_nl & (~ and_dcpl_435)) | and_dcpl_439;
  assign VEC_LOOP_VEC_LOOP_or_19_nl = ((COMP_LOOP_k_14_4_sva_9_0[0]) & (~ and_dcpl_448))
      | and_dcpl_430 | and_dcpl_435 | and_dcpl_439;
  assign nl_acc_13_nl = ({VEC_LOOP_mux1h_36_nl , VEC_LOOP_or_81_nl}) + ({VEC_LOOP_VEC_LOOP_and_8_nl
      , VEC_LOOP_and_22_nl , VEC_LOOP_mux1h_37_nl , VEC_LOOP_VEC_LOOP_or_18_nl ,
      VEC_LOOP_VEC_LOOP_or_19_nl , 1'b1});
  assign acc_13_nl = nl_acc_13_nl[12:0];
  assign z_out_14 = readslicef_13_12_1(acc_13_nl);
  assign and_627_nl = (fsm_output==8'b10100011);
  assign VEC_LOOP_mux_33_nl = MUX_v_10_2_2((STAGE_LOOP_lshift_psp_sva[14:5]), 10'b0000000001,
      and_627_nl);
  assign nl_z_out_15 = conv_u2u_10_11(COMP_LOOP_k_14_4_sva_9_0) + conv_u2u_10_11(VEC_LOOP_mux_33_nl);
  assign z_out_15 = nl_z_out_15[10:0];
  assign COMP_LOOP_twiddle_f_or_22_nl = and_dcpl_475 | and_dcpl_479 | and_dcpl_482
      | and_dcpl_485 | and_dcpl_488 | and_dcpl_491 | and_dcpl_494;
  assign COMP_LOOP_twiddle_f_mux_7_nl = MUX_v_14_2_2(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1,
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva, COMP_LOOP_twiddle_f_or_22_nl);
  assign COMP_LOOP_twiddle_f_mux1h_162_nl = MUX1HOT_v_3_6_2(3'b110, 3'b101, 3'b100,
      3'b011, 3'b010, 3'b001, {and_dcpl_475 , and_dcpl_479 , and_dcpl_482 , and_dcpl_485
      , and_dcpl_488 , and_dcpl_491});
  assign and_628_nl = nor_157_cse & and_dcpl_17 & and_dcpl_212;
  assign COMP_LOOP_twiddle_f_nor_6_nl = ~(MUX_v_3_2_2(COMP_LOOP_twiddle_f_mux1h_162_nl,
      3'b111, and_628_nl));
  assign COMP_LOOP_twiddle_f_or_23_nl = MUX_v_3_2_2(COMP_LOOP_twiddle_f_nor_6_nl,
      3'b111, and_dcpl_494);
  assign nl_z_out_16 = COMP_LOOP_twiddle_f_mux_7_nl * ({COMP_LOOP_k_14_4_sva_9_0
      , COMP_LOOP_twiddle_f_or_23_nl , 1'b1});
  assign z_out_16 = nl_z_out_16[13:0];
  assign COMP_LOOP_twiddle_f_mux_8_nl = MUX_s_1_2_2((COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1[12]),
      (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[12]), COMP_LOOP_twiddle_f_or_16_itm);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl = COMP_LOOP_twiddle_f_mux_8_nl
      & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_mux1h_163_nl = MUX1HOT_v_12_4_2((COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1[11:0]),
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva, (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[11:0]),
      ({1'b0 , COMP_LOOP_9_twiddle_f_lshift_itm}), {and_dcpl_501 , COMP_LOOP_twiddle_f_or_17_itm
      , COMP_LOOP_twiddle_f_or_16_itm , and_dcpl_514});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl = (COMP_LOOP_k_14_4_sva_9_0[9])
      & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_or_24_nl = and_dcpl_501 | and_dcpl_511 | and_dcpl_518
      | and_dcpl_523;
  assign COMP_LOOP_twiddle_f_mux1h_164_nl = MUX1HOT_v_9_3_2((COMP_LOOP_k_14_4_sva_9_0[8:0]),
      (COMP_LOOP_k_14_4_sva_9_0[9:1]), ({1'b0 , (COMP_LOOP_k_14_4_sva_9_0[9:2])}),
      {COMP_LOOP_twiddle_f_or_24_nl , COMP_LOOP_twiddle_f_or_17_itm , and_dcpl_514});
  assign COMP_LOOP_twiddle_f_mux_9_nl = MUX_s_1_2_2((COMP_LOOP_k_14_4_sva_9_0[0]),
      (COMP_LOOP_k_14_4_sva_9_0[1]), and_dcpl_514);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl = (COMP_LOOP_twiddle_f_mux_9_nl
      & (~(and_dcpl_501 | and_dcpl_511))) | and_dcpl_518 | and_dcpl_523;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl = ((COMP_LOOP_k_14_4_sva_9_0[0])
      & (~(and_dcpl_501 | and_dcpl_508 | and_dcpl_518))) | and_dcpl_511 | and_dcpl_520
      | and_dcpl_523;
  assign nl_z_out_17_12_0 = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_2_nl ,
      COMP_LOOP_twiddle_f_mux1h_163_nl}) * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_3_nl
      , COMP_LOOP_twiddle_f_mux1h_164_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl , 1'b1});
  assign z_out_17_12_0 = nl_z_out_17_12_0[12:0];
  assign VEC_LOOP_VEC_LOOP_or_20_nl = (reg_VEC_LOOP_acc_1_reg[3]) | and_dcpl_547
      | and_dcpl_551;
  assign VEC_LOOP_VEC_LOOP_mux_7_nl = MUX_v_12_2_2(({(reg_VEC_LOOP_acc_1_reg[2:0])
      , (reg_VEC_LOOP_acc_1_1_reg[9:1])}), (~ (STAGE_LOOP_lshift_psp_sva[14:3])),
      VEC_LOOP_or_72_itm);
  assign VEC_LOOP_or_83_nl = (~(and_dcpl_530 | and_dcpl_536 | and_dcpl_540 | and_dcpl_544))
      | and_dcpl_547 | and_dcpl_551;
  assign VEC_LOOP_and_25_nl = (COMP_LOOP_k_14_4_sva_9_0[9]) & VEC_LOOP_nor_15_itm;
  assign VEC_LOOP_VEC_LOOP_mux_8_nl = MUX_v_9_2_2((COMP_LOOP_k_14_4_sva_9_0[8:0]),
      (COMP_LOOP_k_14_4_sva_9_0[9:1]), VEC_LOOP_or_72_itm);
  assign VEC_LOOP_VEC_LOOP_or_21_nl = ((COMP_LOOP_k_14_4_sva_9_0[0]) & (~(and_dcpl_530
      | and_dcpl_536))) | and_dcpl_540 | and_dcpl_544;
  assign VEC_LOOP_VEC_LOOP_or_22_nl = (~(and_dcpl_530 | and_dcpl_540 | and_dcpl_551))
      | and_dcpl_536 | and_dcpl_544 | and_dcpl_547;
  assign VEC_LOOP_VEC_LOOP_or_23_nl = VEC_LOOP_nor_15_itm | and_dcpl_530 | and_dcpl_536
      | and_dcpl_540 | and_dcpl_544;
  assign nl_acc_15_nl = ({VEC_LOOP_VEC_LOOP_or_20_nl , VEC_LOOP_VEC_LOOP_mux_7_nl
      , VEC_LOOP_or_83_nl}) + ({VEC_LOOP_and_25_nl , VEC_LOOP_VEC_LOOP_mux_8_nl ,
      VEC_LOOP_VEC_LOOP_or_21_nl , VEC_LOOP_VEC_LOOP_or_22_nl , VEC_LOOP_VEC_LOOP_or_23_nl
      , 1'b1});
  assign acc_15_nl = nl_acc_15_nl[13:0];
  assign z_out_18 = readslicef_14_13_1(acc_15_nl);

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


  function automatic [9:0] MUX1HOT_v_10_10_2;
    input [9:0] input_9;
    input [9:0] input_8;
    input [9:0] input_7;
    input [9:0] input_6;
    input [9:0] input_5;
    input [9:0] input_4;
    input [9:0] input_3;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [9:0] sel;
    reg [9:0] result;
  begin
    result = input_0 & {10{sel[0]}};
    result = result | ( input_1 & {10{sel[1]}});
    result = result | ( input_2 & {10{sel[2]}});
    result = result | ( input_3 & {10{sel[3]}});
    result = result | ( input_4 & {10{sel[4]}});
    result = result | ( input_5 & {10{sel[5]}});
    result = result | ( input_6 & {10{sel[6]}});
    result = result | ( input_7 & {10{sel[7]}});
    result = result | ( input_8 & {10{sel[8]}});
    result = result | ( input_9 & {10{sel[9]}});
    MUX1HOT_v_10_10_2 = result;
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


  function automatic [9:0] MUX1HOT_v_10_5_2;
    input [9:0] input_4;
    input [9:0] input_3;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [4:0] sel;
    reg [9:0] result;
  begin
    result = input_0 & {10{sel[0]}};
    result = result | ( input_1 & {10{sel[1]}});
    result = result | ( input_2 & {10{sel[2]}});
    result = result | ( input_3 & {10{sel[3]}});
    result = result | ( input_4 & {10{sel[4]}});
    MUX1HOT_v_10_5_2 = result;
  end
  endfunction


  function automatic [10:0] MUX1HOT_v_11_6_2;
    input [10:0] input_5;
    input [10:0] input_4;
    input [10:0] input_3;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [5:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | ( input_1 & {11{sel[1]}});
    result = result | ( input_2 & {11{sel[2]}});
    result = result | ( input_3 & {11{sel[3]}});
    result = result | ( input_4 & {11{sel[4]}});
    result = result | ( input_5 & {11{sel[5]}});
    MUX1HOT_v_11_6_2 = result;
  end
  endfunction


  function automatic [11:0] MUX1HOT_v_12_4_2;
    input [11:0] input_3;
    input [11:0] input_2;
    input [11:0] input_1;
    input [11:0] input_0;
    input [3:0] sel;
    reg [11:0] result;
  begin
    result = input_0 & {12{sel[0]}};
    result = result | ( input_1 & {12{sel[1]}});
    result = result | ( input_2 & {12{sel[2]}});
    result = result | ( input_3 & {12{sel[3]}});
    MUX1HOT_v_12_4_2 = result;
  end
  endfunction


  function automatic [11:0] MUX1HOT_v_12_5_2;
    input [11:0] input_4;
    input [11:0] input_3;
    input [11:0] input_2;
    input [11:0] input_1;
    input [11:0] input_0;
    input [4:0] sel;
    reg [11:0] result;
  begin
    result = input_0 & {12{sel[0]}};
    result = result | ( input_1 & {12{sel[1]}});
    result = result | ( input_2 & {12{sel[2]}});
    result = result | ( input_3 & {12{sel[3]}});
    result = result | ( input_4 & {12{sel[4]}});
    MUX1HOT_v_12_5_2 = result;
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


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
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



