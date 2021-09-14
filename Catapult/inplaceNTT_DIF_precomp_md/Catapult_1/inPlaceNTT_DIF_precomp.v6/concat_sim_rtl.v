
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

//------> ../td_ccore_solutions/mult_81c1b7d49a9f3c7ad693045e78ab662170f2_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:46:34 2021
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




//------> ../td_ccore_solutions/modulo_sub_1bb50f5def739ec4079134016dea7c766383_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:46:35 2021
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




//------> ../td_ccore_solutions/modulo_add_86a4e13eef67db9706364ef65c383d9d60fa_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:46:36 2021
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
//  Generated date: Mon Sep 13 22:01:13 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_12_32_4096_4096_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_12_32_4096_4096_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [11:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [11:0] adra;
  input [23:0] adra_d;
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
  assign adrb = (adra_d[23:12]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[11:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_12_32_4096_4096_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_12_32_4096_4096_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [11:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [11:0] adra;
  input [23:0] adra_d;
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
  assign adrb = (adra_d[23:12]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[11:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_12_32_4096_4096_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_12_32_4096_4096_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [11:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [11:0] adra;
  input [23:0] adra_d;
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
  assign adrb = (adra_d[23:12]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[11:0]);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_core_fsm (
  clk, rst, complete_rsci_wen_comp, fsm_output, main_C_0_tr0, COMP_LOOP_1_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_2_tr0, COMP_LOOP_2_VEC_LOOP_C_6_tr0, COMP_LOOP_C_3_tr0, COMP_LOOP_3_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_4_tr0, COMP_LOOP_4_VEC_LOOP_C_6_tr0, COMP_LOOP_C_5_tr0, COMP_LOOP_5_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_6_tr0, COMP_LOOP_6_VEC_LOOP_C_6_tr0, COMP_LOOP_C_7_tr0, COMP_LOOP_7_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_8_tr0, COMP_LOOP_8_VEC_LOOP_C_6_tr0, COMP_LOOP_C_9_tr0, COMP_LOOP_9_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_10_tr0, COMP_LOOP_10_VEC_LOOP_C_6_tr0, COMP_LOOP_C_11_tr0, COMP_LOOP_11_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_12_tr0, COMP_LOOP_12_VEC_LOOP_C_6_tr0, COMP_LOOP_C_13_tr0, COMP_LOOP_13_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_14_tr0, COMP_LOOP_14_VEC_LOOP_C_6_tr0, COMP_LOOP_C_15_tr0, COMP_LOOP_15_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_16_tr0, COMP_LOOP_16_VEC_LOOP_C_6_tr0, COMP_LOOP_C_17_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input main_C_0_tr0;
  input COMP_LOOP_1_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_2_tr0;
  input COMP_LOOP_2_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_3_tr0;
  input COMP_LOOP_3_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_4_tr0;
  input COMP_LOOP_4_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_5_tr0;
  input COMP_LOOP_5_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_6_tr0;
  input COMP_LOOP_6_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_7_tr0;
  input COMP_LOOP_7_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_8_tr0;
  input COMP_LOOP_8_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_9_tr0;
  input COMP_LOOP_9_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_10_tr0;
  input COMP_LOOP_10_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_11_tr0;
  input COMP_LOOP_11_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_12_tr0;
  input COMP_LOOP_12_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_13_tr0;
  input COMP_LOOP_13_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_14_tr0;
  input COMP_LOOP_14_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_15_tr0;
  input COMP_LOOP_15_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_16_tr0;
  input COMP_LOOP_16_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_17_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIF_precomp_core_core_fsm_1
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
    COMP_LOOP_C_2 = 8'd11,
    COMP_LOOP_2_VEC_LOOP_C_0 = 8'd12,
    COMP_LOOP_2_VEC_LOOP_C_1 = 8'd13,
    COMP_LOOP_2_VEC_LOOP_C_2 = 8'd14,
    COMP_LOOP_2_VEC_LOOP_C_3 = 8'd15,
    COMP_LOOP_2_VEC_LOOP_C_4 = 8'd16,
    COMP_LOOP_2_VEC_LOOP_C_5 = 8'd17,
    COMP_LOOP_2_VEC_LOOP_C_6 = 8'd18,
    COMP_LOOP_C_3 = 8'd19,
    COMP_LOOP_3_VEC_LOOP_C_0 = 8'd20,
    COMP_LOOP_3_VEC_LOOP_C_1 = 8'd21,
    COMP_LOOP_3_VEC_LOOP_C_2 = 8'd22,
    COMP_LOOP_3_VEC_LOOP_C_3 = 8'd23,
    COMP_LOOP_3_VEC_LOOP_C_4 = 8'd24,
    COMP_LOOP_3_VEC_LOOP_C_5 = 8'd25,
    COMP_LOOP_3_VEC_LOOP_C_6 = 8'd26,
    COMP_LOOP_C_4 = 8'd27,
    COMP_LOOP_4_VEC_LOOP_C_0 = 8'd28,
    COMP_LOOP_4_VEC_LOOP_C_1 = 8'd29,
    COMP_LOOP_4_VEC_LOOP_C_2 = 8'd30,
    COMP_LOOP_4_VEC_LOOP_C_3 = 8'd31,
    COMP_LOOP_4_VEC_LOOP_C_4 = 8'd32,
    COMP_LOOP_4_VEC_LOOP_C_5 = 8'd33,
    COMP_LOOP_4_VEC_LOOP_C_6 = 8'd34,
    COMP_LOOP_C_5 = 8'd35,
    COMP_LOOP_5_VEC_LOOP_C_0 = 8'd36,
    COMP_LOOP_5_VEC_LOOP_C_1 = 8'd37,
    COMP_LOOP_5_VEC_LOOP_C_2 = 8'd38,
    COMP_LOOP_5_VEC_LOOP_C_3 = 8'd39,
    COMP_LOOP_5_VEC_LOOP_C_4 = 8'd40,
    COMP_LOOP_5_VEC_LOOP_C_5 = 8'd41,
    COMP_LOOP_5_VEC_LOOP_C_6 = 8'd42,
    COMP_LOOP_C_6 = 8'd43,
    COMP_LOOP_6_VEC_LOOP_C_0 = 8'd44,
    COMP_LOOP_6_VEC_LOOP_C_1 = 8'd45,
    COMP_LOOP_6_VEC_LOOP_C_2 = 8'd46,
    COMP_LOOP_6_VEC_LOOP_C_3 = 8'd47,
    COMP_LOOP_6_VEC_LOOP_C_4 = 8'd48,
    COMP_LOOP_6_VEC_LOOP_C_5 = 8'd49,
    COMP_LOOP_6_VEC_LOOP_C_6 = 8'd50,
    COMP_LOOP_C_7 = 8'd51,
    COMP_LOOP_7_VEC_LOOP_C_0 = 8'd52,
    COMP_LOOP_7_VEC_LOOP_C_1 = 8'd53,
    COMP_LOOP_7_VEC_LOOP_C_2 = 8'd54,
    COMP_LOOP_7_VEC_LOOP_C_3 = 8'd55,
    COMP_LOOP_7_VEC_LOOP_C_4 = 8'd56,
    COMP_LOOP_7_VEC_LOOP_C_5 = 8'd57,
    COMP_LOOP_7_VEC_LOOP_C_6 = 8'd58,
    COMP_LOOP_C_8 = 8'd59,
    COMP_LOOP_8_VEC_LOOP_C_0 = 8'd60,
    COMP_LOOP_8_VEC_LOOP_C_1 = 8'd61,
    COMP_LOOP_8_VEC_LOOP_C_2 = 8'd62,
    COMP_LOOP_8_VEC_LOOP_C_3 = 8'd63,
    COMP_LOOP_8_VEC_LOOP_C_4 = 8'd64,
    COMP_LOOP_8_VEC_LOOP_C_5 = 8'd65,
    COMP_LOOP_8_VEC_LOOP_C_6 = 8'd66,
    COMP_LOOP_C_9 = 8'd67,
    COMP_LOOP_9_VEC_LOOP_C_0 = 8'd68,
    COMP_LOOP_9_VEC_LOOP_C_1 = 8'd69,
    COMP_LOOP_9_VEC_LOOP_C_2 = 8'd70,
    COMP_LOOP_9_VEC_LOOP_C_3 = 8'd71,
    COMP_LOOP_9_VEC_LOOP_C_4 = 8'd72,
    COMP_LOOP_9_VEC_LOOP_C_5 = 8'd73,
    COMP_LOOP_9_VEC_LOOP_C_6 = 8'd74,
    COMP_LOOP_C_10 = 8'd75,
    COMP_LOOP_10_VEC_LOOP_C_0 = 8'd76,
    COMP_LOOP_10_VEC_LOOP_C_1 = 8'd77,
    COMP_LOOP_10_VEC_LOOP_C_2 = 8'd78,
    COMP_LOOP_10_VEC_LOOP_C_3 = 8'd79,
    COMP_LOOP_10_VEC_LOOP_C_4 = 8'd80,
    COMP_LOOP_10_VEC_LOOP_C_5 = 8'd81,
    COMP_LOOP_10_VEC_LOOP_C_6 = 8'd82,
    COMP_LOOP_C_11 = 8'd83,
    COMP_LOOP_11_VEC_LOOP_C_0 = 8'd84,
    COMP_LOOP_11_VEC_LOOP_C_1 = 8'd85,
    COMP_LOOP_11_VEC_LOOP_C_2 = 8'd86,
    COMP_LOOP_11_VEC_LOOP_C_3 = 8'd87,
    COMP_LOOP_11_VEC_LOOP_C_4 = 8'd88,
    COMP_LOOP_11_VEC_LOOP_C_5 = 8'd89,
    COMP_LOOP_11_VEC_LOOP_C_6 = 8'd90,
    COMP_LOOP_C_12 = 8'd91,
    COMP_LOOP_12_VEC_LOOP_C_0 = 8'd92,
    COMP_LOOP_12_VEC_LOOP_C_1 = 8'd93,
    COMP_LOOP_12_VEC_LOOP_C_2 = 8'd94,
    COMP_LOOP_12_VEC_LOOP_C_3 = 8'd95,
    COMP_LOOP_12_VEC_LOOP_C_4 = 8'd96,
    COMP_LOOP_12_VEC_LOOP_C_5 = 8'd97,
    COMP_LOOP_12_VEC_LOOP_C_6 = 8'd98,
    COMP_LOOP_C_13 = 8'd99,
    COMP_LOOP_13_VEC_LOOP_C_0 = 8'd100,
    COMP_LOOP_13_VEC_LOOP_C_1 = 8'd101,
    COMP_LOOP_13_VEC_LOOP_C_2 = 8'd102,
    COMP_LOOP_13_VEC_LOOP_C_3 = 8'd103,
    COMP_LOOP_13_VEC_LOOP_C_4 = 8'd104,
    COMP_LOOP_13_VEC_LOOP_C_5 = 8'd105,
    COMP_LOOP_13_VEC_LOOP_C_6 = 8'd106,
    COMP_LOOP_C_14 = 8'd107,
    COMP_LOOP_14_VEC_LOOP_C_0 = 8'd108,
    COMP_LOOP_14_VEC_LOOP_C_1 = 8'd109,
    COMP_LOOP_14_VEC_LOOP_C_2 = 8'd110,
    COMP_LOOP_14_VEC_LOOP_C_3 = 8'd111,
    COMP_LOOP_14_VEC_LOOP_C_4 = 8'd112,
    COMP_LOOP_14_VEC_LOOP_C_5 = 8'd113,
    COMP_LOOP_14_VEC_LOOP_C_6 = 8'd114,
    COMP_LOOP_C_15 = 8'd115,
    COMP_LOOP_15_VEC_LOOP_C_0 = 8'd116,
    COMP_LOOP_15_VEC_LOOP_C_1 = 8'd117,
    COMP_LOOP_15_VEC_LOOP_C_2 = 8'd118,
    COMP_LOOP_15_VEC_LOOP_C_3 = 8'd119,
    COMP_LOOP_15_VEC_LOOP_C_4 = 8'd120,
    COMP_LOOP_15_VEC_LOOP_C_5 = 8'd121,
    COMP_LOOP_15_VEC_LOOP_C_6 = 8'd122,
    COMP_LOOP_C_16 = 8'd123,
    COMP_LOOP_16_VEC_LOOP_C_0 = 8'd124,
    COMP_LOOP_16_VEC_LOOP_C_1 = 8'd125,
    COMP_LOOP_16_VEC_LOOP_C_2 = 8'd126,
    COMP_LOOP_16_VEC_LOOP_C_3 = 8'd127,
    COMP_LOOP_16_VEC_LOOP_C_4 = 8'd128,
    COMP_LOOP_16_VEC_LOOP_C_5 = 8'd129,
    COMP_LOOP_16_VEC_LOOP_C_6 = 8'd130,
    COMP_LOOP_C_17 = 8'd131,
    STAGE_LOOP_C_1 = 8'd132,
    main_C_1 = 8'd133,
    main_C_2 = 8'd134;

  reg [7:0] state_var;
  reg [7:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIF_precomp_core_core_fsm_1
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
        if ( COMP_LOOP_1_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 8'b00001011;
        if ( COMP_LOOP_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_2_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00001100;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_1;
      end
      COMP_LOOP_2_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00001101;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_2;
      end
      COMP_LOOP_2_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00001110;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_3;
      end
      COMP_LOOP_2_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00001111;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_4;
      end
      COMP_LOOP_2_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00010000;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_5;
      end
      COMP_LOOP_2_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00010001;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_6;
      end
      COMP_LOOP_2_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00010010;
        if ( COMP_LOOP_2_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_3;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 8'b00010011;
        if ( COMP_LOOP_C_3_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_3_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00010100;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_1;
      end
      COMP_LOOP_3_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00010101;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_2;
      end
      COMP_LOOP_3_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00010110;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_3;
      end
      COMP_LOOP_3_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00010111;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_4;
      end
      COMP_LOOP_3_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00011000;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_5;
      end
      COMP_LOOP_3_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00011001;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_6;
      end
      COMP_LOOP_3_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00011010;
        if ( COMP_LOOP_3_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_4;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 8'b00011011;
        if ( COMP_LOOP_C_4_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_4_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00011100;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_1;
      end
      COMP_LOOP_4_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00011101;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_2;
      end
      COMP_LOOP_4_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00011110;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_3;
      end
      COMP_LOOP_4_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00011111;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_4;
      end
      COMP_LOOP_4_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00100000;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_5;
      end
      COMP_LOOP_4_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00100001;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_6;
      end
      COMP_LOOP_4_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00100010;
        if ( COMP_LOOP_4_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_5;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 8'b00100011;
        if ( COMP_LOOP_C_5_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_5_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00100100;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_1;
      end
      COMP_LOOP_5_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00100101;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_2;
      end
      COMP_LOOP_5_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00100110;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_3;
      end
      COMP_LOOP_5_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00100111;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_4;
      end
      COMP_LOOP_5_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00101000;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_5;
      end
      COMP_LOOP_5_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00101001;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_6;
      end
      COMP_LOOP_5_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00101010;
        if ( COMP_LOOP_5_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_6;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 8'b00101011;
        if ( COMP_LOOP_C_6_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_6_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00101100;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_1;
      end
      COMP_LOOP_6_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00101101;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_2;
      end
      COMP_LOOP_6_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00101110;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_3;
      end
      COMP_LOOP_6_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00101111;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_4;
      end
      COMP_LOOP_6_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00110000;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_5;
      end
      COMP_LOOP_6_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00110001;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_6;
      end
      COMP_LOOP_6_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00110010;
        if ( COMP_LOOP_6_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_7;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 8'b00110011;
        if ( COMP_LOOP_C_7_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_7_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00110100;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_1;
      end
      COMP_LOOP_7_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00110101;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_2;
      end
      COMP_LOOP_7_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00110110;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_3;
      end
      COMP_LOOP_7_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00110111;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_4;
      end
      COMP_LOOP_7_VEC_LOOP_C_4 : begin
        fsm_output = 8'b00111000;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_5;
      end
      COMP_LOOP_7_VEC_LOOP_C_5 : begin
        fsm_output = 8'b00111001;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_6;
      end
      COMP_LOOP_7_VEC_LOOP_C_6 : begin
        fsm_output = 8'b00111010;
        if ( COMP_LOOP_7_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_8;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 8'b00111011;
        if ( COMP_LOOP_C_8_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_8_VEC_LOOP_C_0 : begin
        fsm_output = 8'b00111100;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_1;
      end
      COMP_LOOP_8_VEC_LOOP_C_1 : begin
        fsm_output = 8'b00111101;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_2;
      end
      COMP_LOOP_8_VEC_LOOP_C_2 : begin
        fsm_output = 8'b00111110;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_3;
      end
      COMP_LOOP_8_VEC_LOOP_C_3 : begin
        fsm_output = 8'b00111111;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_4;
      end
      COMP_LOOP_8_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01000000;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_5;
      end
      COMP_LOOP_8_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01000001;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_6;
      end
      COMP_LOOP_8_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01000010;
        if ( COMP_LOOP_8_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_9;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 8'b01000011;
        if ( COMP_LOOP_C_9_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_9_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01000100;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_1;
      end
      COMP_LOOP_9_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01000101;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_2;
      end
      COMP_LOOP_9_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01000110;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_3;
      end
      COMP_LOOP_9_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01000111;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_4;
      end
      COMP_LOOP_9_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01001000;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_5;
      end
      COMP_LOOP_9_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01001001;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_6;
      end
      COMP_LOOP_9_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01001010;
        if ( COMP_LOOP_9_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_10;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 8'b01001011;
        if ( COMP_LOOP_C_10_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_10_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01001100;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_1;
      end
      COMP_LOOP_10_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01001101;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_2;
      end
      COMP_LOOP_10_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01001110;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_3;
      end
      COMP_LOOP_10_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01001111;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_4;
      end
      COMP_LOOP_10_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01010000;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_5;
      end
      COMP_LOOP_10_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01010001;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_6;
      end
      COMP_LOOP_10_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01010010;
        if ( COMP_LOOP_10_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_11;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 8'b01010011;
        if ( COMP_LOOP_C_11_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_11_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01010100;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_1;
      end
      COMP_LOOP_11_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01010101;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_2;
      end
      COMP_LOOP_11_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01010110;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_3;
      end
      COMP_LOOP_11_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01010111;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_4;
      end
      COMP_LOOP_11_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01011000;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_5;
      end
      COMP_LOOP_11_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01011001;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_6;
      end
      COMP_LOOP_11_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01011010;
        if ( COMP_LOOP_11_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_12;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 8'b01011011;
        if ( COMP_LOOP_C_12_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_12_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01011100;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_1;
      end
      COMP_LOOP_12_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01011101;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_2;
      end
      COMP_LOOP_12_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01011110;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_3;
      end
      COMP_LOOP_12_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01011111;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_4;
      end
      COMP_LOOP_12_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01100000;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_5;
      end
      COMP_LOOP_12_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01100001;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_6;
      end
      COMP_LOOP_12_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01100010;
        if ( COMP_LOOP_12_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_13;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 8'b01100011;
        if ( COMP_LOOP_C_13_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_13_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01100100;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_1;
      end
      COMP_LOOP_13_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01100101;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_2;
      end
      COMP_LOOP_13_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01100110;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_3;
      end
      COMP_LOOP_13_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01100111;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_4;
      end
      COMP_LOOP_13_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01101000;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_5;
      end
      COMP_LOOP_13_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01101001;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_6;
      end
      COMP_LOOP_13_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01101010;
        if ( COMP_LOOP_13_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_14;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 8'b01101011;
        if ( COMP_LOOP_C_14_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_14_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01101100;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_1;
      end
      COMP_LOOP_14_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01101101;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_2;
      end
      COMP_LOOP_14_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01101110;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_3;
      end
      COMP_LOOP_14_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01101111;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_4;
      end
      COMP_LOOP_14_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01110000;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_5;
      end
      COMP_LOOP_14_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01110001;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_6;
      end
      COMP_LOOP_14_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01110010;
        if ( COMP_LOOP_14_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_15;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 8'b01110011;
        if ( COMP_LOOP_C_15_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_15_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01110100;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_1;
      end
      COMP_LOOP_15_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01110101;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_2;
      end
      COMP_LOOP_15_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01110110;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_3;
      end
      COMP_LOOP_15_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01110111;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_4;
      end
      COMP_LOOP_15_VEC_LOOP_C_4 : begin
        fsm_output = 8'b01111000;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_5;
      end
      COMP_LOOP_15_VEC_LOOP_C_5 : begin
        fsm_output = 8'b01111001;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_6;
      end
      COMP_LOOP_15_VEC_LOOP_C_6 : begin
        fsm_output = 8'b01111010;
        if ( COMP_LOOP_15_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_16;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 8'b01111011;
        if ( COMP_LOOP_C_16_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_16_VEC_LOOP_C_0 : begin
        fsm_output = 8'b01111100;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_1;
      end
      COMP_LOOP_16_VEC_LOOP_C_1 : begin
        fsm_output = 8'b01111101;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_2;
      end
      COMP_LOOP_16_VEC_LOOP_C_2 : begin
        fsm_output = 8'b01111110;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_3;
      end
      COMP_LOOP_16_VEC_LOOP_C_3 : begin
        fsm_output = 8'b01111111;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_4;
      end
      COMP_LOOP_16_VEC_LOOP_C_4 : begin
        fsm_output = 8'b10000000;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_5;
      end
      COMP_LOOP_16_VEC_LOOP_C_5 : begin
        fsm_output = 8'b10000001;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_6;
      end
      COMP_LOOP_16_VEC_LOOP_C_6 : begin
        fsm_output = 8'b10000010;
        if ( COMP_LOOP_16_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_17;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 8'b10000011;
        if ( COMP_LOOP_C_17_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 8'b10000100;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 8'b10000101;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 8'b10000110;
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl (
  core_wten, vec_rsc_triosy_obj_iswt0, vec_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input vec_rsc_triosy_obj_iswt0;
  output vec_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign vec_rsc_triosy_obj_ld_core_sct = vec_rsc_triosy_obj_iswt0 & (~ core_wten);
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp (
  clk, rst, twiddle_h_rsci_adra_d, twiddle_h_rsci_qa_d, twiddle_h_rsci_qa_d_mxwt,
      twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt, twiddle_h_rsci_biwt_1, twiddle_h_rsci_bdwt_2,
      twiddle_h_rsci_adra_d_core_pff, twiddle_h_rsci_adra_d_core_sct_pff
);
  input clk;
  input rst;
  output [23:0] twiddle_h_rsci_adra_d;
  input [63:0] twiddle_h_rsci_qa_d;
  output [63:0] twiddle_h_rsci_qa_d_mxwt;
  input twiddle_h_rsci_biwt;
  input twiddle_h_rsci_bdwt;
  input twiddle_h_rsci_biwt_1;
  input twiddle_h_rsci_bdwt_2;
  input [23:0] twiddle_h_rsci_adra_d_core_pff;
  input [1:0] twiddle_h_rsci_adra_d_core_sct_pff;


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
  assign twiddle_h_rsci_adra_d = {(twiddle_h_rsci_adra_d_core_pff[23:14]) , (~ (twiddle_h_rsci_adra_d_core_sct_pff[1]))
      , (~ (twiddle_h_rsci_adra_d_core_sct_pff[1])) , (twiddle_h_rsci_adra_d_core_pff[11:0])};
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl (
  core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_oswt_1, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt, twiddle_h_rsci_biwt_1, twiddle_h_rsci_bdwt_2,
      twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsci_adra_d_core_sct_pff,
      twiddle_h_rsci_adra_d_core_psct_pff, core_wten_pff, twiddle_h_rsci_oswt_1_pff,
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
  output [1:0] twiddle_h_rsci_adra_d_core_sct_pff;
  input [1:0] twiddle_h_rsci_adra_d_core_psct_pff;
  input core_wten_pff;
  input twiddle_h_rsci_oswt_1_pff;
  input twiddle_h_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_h_rsci_dswt_1_pff;
  wire twiddle_h_rsci_dswt_pff;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_bdwt = twiddle_h_rsci_oswt & core_wen;
  assign twiddle_h_rsci_biwt = (~ core_wten) & twiddle_h_rsci_oswt;
  assign twiddle_h_rsci_bdwt_2 = twiddle_h_rsci_oswt_1 & core_wen;
  assign twiddle_h_rsci_biwt_1 = (~ core_wten) & twiddle_h_rsci_oswt_1;
  assign twiddle_h_rsci_adra_d_core_sct_pff = twiddle_h_rsci_adra_d_core_psct_pff
      & ({twiddle_h_rsci_dswt_1_pff , twiddle_h_rsci_dswt_pff});
  assign twiddle_h_rsci_dswt_1_pff = (~ core_wten_pff) & twiddle_h_rsci_oswt_1_pff;
  assign twiddle_h_rsci_dswt_pff = (~ core_wten_pff) & twiddle_h_rsci_oswt_pff;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({twiddle_h_rsci_dswt_1_pff , twiddle_h_rsci_dswt_pff});
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp (
  clk, rst, twiddle_rsci_adra_d, twiddle_rsci_qa_d, twiddle_rsci_qa_d_mxwt, twiddle_rsci_biwt,
      twiddle_rsci_bdwt, twiddle_rsci_biwt_1, twiddle_rsci_bdwt_2, twiddle_rsci_adra_d_core_pff,
      twiddle_rsci_adra_d_core_sct_pff
);
  input clk;
  input rst;
  output [23:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  output [63:0] twiddle_rsci_qa_d_mxwt;
  input twiddle_rsci_biwt;
  input twiddle_rsci_bdwt;
  input twiddle_rsci_biwt_1;
  input twiddle_rsci_bdwt_2;
  input [23:0] twiddle_rsci_adra_d_core_pff;
  input [1:0] twiddle_rsci_adra_d_core_sct_pff;


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
  assign twiddle_rsci_adra_d = {(twiddle_rsci_adra_d_core_pff[23:14]) , (~ (twiddle_rsci_adra_d_core_sct_pff[1]))
      , (~ (twiddle_rsci_adra_d_core_sct_pff[1])) , (twiddle_rsci_adra_d_core_pff[11:0])};
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl (
  core_wen, core_wten, twiddle_rsci_oswt, twiddle_rsci_oswt_1, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      twiddle_rsci_biwt, twiddle_rsci_bdwt, twiddle_rsci_biwt_1, twiddle_rsci_bdwt_2,
      twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct, twiddle_rsci_adra_d_core_sct_pff,
      twiddle_rsci_adra_d_core_psct_pff, core_wten_pff, twiddle_rsci_oswt_1_pff,
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
  output [1:0] twiddle_rsci_adra_d_core_sct_pff;
  input [1:0] twiddle_rsci_adra_d_core_psct_pff;
  input core_wten_pff;
  input twiddle_rsci_oswt_1_pff;
  input twiddle_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_rsci_dswt_1_pff;
  wire twiddle_rsci_dswt_pff;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_bdwt = twiddle_rsci_oswt & core_wen;
  assign twiddle_rsci_biwt = (~ core_wten) & twiddle_rsci_oswt;
  assign twiddle_rsci_bdwt_2 = twiddle_rsci_oswt_1 & core_wen;
  assign twiddle_rsci_biwt_1 = (~ core_wten) & twiddle_rsci_oswt_1;
  assign twiddle_rsci_adra_d_core_sct_pff = twiddle_rsci_adra_d_core_psct_pff & ({twiddle_rsci_dswt_1_pff
      , twiddle_rsci_dswt_pff});
  assign twiddle_rsci_dswt_1_pff = (~ core_wten_pff) & twiddle_rsci_oswt_1_pff;
  assign twiddle_rsci_dswt_pff = (~ core_wten_pff) & twiddle_rsci_oswt_pff;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      & ({twiddle_rsci_dswt_1_pff , twiddle_rsci_dswt_pff});
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_wait_dp (
  ensig_cgo_iro, ensig_cgo_iro_1, core_wen, ensig_cgo, COMP_LOOP_1_mult_cmp_ccs_ccore_en,
      ensig_cgo_1, COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en
);
  input ensig_cgo_iro;
  input ensig_cgo_iro_1;
  input core_wen;
  input ensig_cgo;
  output COMP_LOOP_1_mult_cmp_ccs_ccore_en;
  input ensig_cgo_1;
  output COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  assign COMP_LOOP_1_mult_cmp_ccs_ccore_en = core_wen & (ensig_cgo | ensig_cgo_iro);
  assign COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en = core_wen & (ensig_cgo_1 | ensig_cgo_iro_1);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_dp (
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl (
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj (
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
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj_twiddle_h_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_obj_iswt0(twiddle_h_rsc_triosy_obj_iswt0),
      .twiddle_h_rsc_triosy_obj_ld_core_sct(twiddle_h_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj (
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
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl
      inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj_twiddle_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .twiddle_rsc_triosy_obj_iswt0(twiddle_rsc_triosy_obj_iswt0),
      .twiddle_rsc_triosy_obj_ld_core_sct(twiddle_rsc_triosy_obj_ld_core_sct)
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj (
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
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj_vec_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .vec_rsc_triosy_obj_iswt0(vec_rsc_triosy_obj_iswt0),
      .vec_rsc_triosy_obj_ld_core_sct(vec_rsc_triosy_obj_ld_core_sct)
    );
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1 (
  clk, rst, twiddle_h_rsci_adra_d, twiddle_h_rsci_qa_d, twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_oswt_1, twiddle_h_rsci_qa_d_mxwt,
      twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, twiddle_h_rsci_adra_d_core_pff,
      twiddle_h_rsci_adra_d_core_psct_pff, core_wten_pff, twiddle_h_rsci_oswt_1_pff,
      twiddle_h_rsci_oswt_pff
);
  input clk;
  input rst;
  output [23:0] twiddle_h_rsci_adra_d;
  input [63:0] twiddle_h_rsci_qa_d;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsci_oswt;
  input twiddle_h_rsci_oswt_1;
  output [63:0] twiddle_h_rsci_qa_d_mxwt;
  input [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [23:0] twiddle_h_rsci_adra_d_core_pff;
  input [1:0] twiddle_h_rsci_adra_d_core_psct_pff;
  input core_wten_pff;
  input twiddle_h_rsci_oswt_1_pff;
  input twiddle_h_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_h_rsci_biwt;
  wire twiddle_h_rsci_bdwt;
  wire twiddle_h_rsci_biwt_1;
  wire twiddle_h_rsci_bdwt_2;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [23:0] twiddle_h_rsci_adra_d_reg;
  wire [1:0] twiddle_h_rsci_adra_d_core_sct_iff;


  // Interconnect Declarations for Component Instantiations 
  wire [23:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_adra_d_core_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_adra_d_core_pff
      = {(twiddle_h_rsci_adra_d_core_pff[23:14]) , 2'b00 , (twiddle_h_rsci_adra_d_core_pff[11:0])};
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl_inst
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
      .twiddle_h_rsci_adra_d_core_sct_pff(twiddle_h_rsci_adra_d_core_sct_iff),
      .twiddle_h_rsci_adra_d_core_psct_pff(twiddle_h_rsci_adra_d_core_psct_pff),
      .core_wten_pff(core_wten_pff),
      .twiddle_h_rsci_oswt_1_pff(twiddle_h_rsci_oswt_1_pff),
      .twiddle_h_rsci_oswt_pff(twiddle_h_rsci_oswt_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_adra_d(twiddle_h_rsci_adra_d_reg),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_qa_d_mxwt(twiddle_h_rsci_qa_d_mxwt),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt),
      .twiddle_h_rsci_biwt_1(twiddle_h_rsci_biwt_1),
      .twiddle_h_rsci_bdwt_2(twiddle_h_rsci_bdwt_2),
      .twiddle_h_rsci_adra_d_core_pff(nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst_twiddle_h_rsci_adra_d_core_pff[23:0]),
      .twiddle_h_rsci_adra_d_core_sct_pff(twiddle_h_rsci_adra_d_core_sct_iff)
    );
  assign twiddle_h_rsci_adra_d = twiddle_h_rsci_adra_d_reg;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1 (
  clk, rst, twiddle_rsci_adra_d, twiddle_rsci_qa_d, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_rsci_oswt, twiddle_rsci_oswt_1, twiddle_rsci_qa_d_mxwt,
      twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct, twiddle_rsci_adra_d_core_pff,
      twiddle_rsci_adra_d_core_psct_pff, core_wten_pff, twiddle_rsci_oswt_1_pff,
      twiddle_rsci_oswt_pff
);
  input clk;
  input rst;
  output [23:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsci_oswt;
  input twiddle_rsci_oswt_1;
  output [63:0] twiddle_rsci_qa_d_mxwt;
  input [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input [23:0] twiddle_rsci_adra_d_core_pff;
  input [1:0] twiddle_rsci_adra_d_core_psct_pff;
  input core_wten_pff;
  input twiddle_rsci_oswt_1_pff;
  input twiddle_rsci_oswt_pff;


  // Interconnect Declarations
  wire twiddle_rsci_biwt;
  wire twiddle_rsci_bdwt;
  wire twiddle_rsci_biwt_1;
  wire twiddle_rsci_bdwt_2;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [23:0] twiddle_rsci_adra_d_reg;
  wire [1:0] twiddle_rsci_adra_d_core_sct_iff;


  // Interconnect Declarations for Component Instantiations 
  wire [23:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst_twiddle_rsci_adra_d_core_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst_twiddle_rsci_adra_d_core_pff
      = {(twiddle_rsci_adra_d_core_pff[23:14]) , 2'b00 , (twiddle_rsci_adra_d_core_pff[11:0])};
  inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl_inst
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
      .twiddle_rsci_adra_d_core_sct_pff(twiddle_rsci_adra_d_core_sct_iff),
      .twiddle_rsci_adra_d_core_psct_pff(twiddle_rsci_adra_d_core_psct_pff),
      .core_wten_pff(core_wten_pff),
      .twiddle_rsci_oswt_1_pff(twiddle_rsci_oswt_1_pff),
      .twiddle_rsci_oswt_pff(twiddle_rsci_oswt_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsci_adra_d(twiddle_rsci_adra_d_reg),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_qa_d_mxwt(twiddle_rsci_qa_d_mxwt),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt),
      .twiddle_rsci_biwt_1(twiddle_rsci_biwt_1),
      .twiddle_rsci_bdwt_2(twiddle_rsci_bdwt_2),
      .twiddle_rsci_adra_d_core_pff(nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst_twiddle_rsci_adra_d_core_pff[23:0]),
      .twiddle_rsci_adra_d_core_sct_pff(twiddle_rsci_adra_d_core_sct_iff)
    );
  assign twiddle_rsci_adra_d = twiddle_rsci_adra_d_reg;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_vec_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_vec_rsci_1 (
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
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (vec_rsci_wea_d_core_psct[0])};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[0])};
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst_vec_rsci_da_d_core;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst_vec_rsci_da_d_core
      = {32'b00000000000000000000000000000000 , (vec_rsci_da_d_core[31:0])};
  inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .vec_rsci_oswt(vec_rsci_oswt),
      .vec_rsci_oswt_1(vec_rsci_oswt_1),
      .vec_rsci_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_wea_d_core_psct[1:0]),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct),
      .vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_ctrl_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
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
  inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_dp inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .vec_rsci_da_d(vec_rsci_da_d_reg),
      .vec_rsci_qa_d(vec_rsci_qa_d),
      .vec_rsci_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_vec_rsc_wait_dp_inst_vec_rsci_da_d_core[63:0]),
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
  output [23:0] vec_rsci_adra_d;
  output [31:0] vec_rsci_da_d;
  input [63:0] vec_rsci_qa_d;
  output [1:0] vec_rsci_wea_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [23:0] twiddle_rsci_adra_d;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [23:0] twiddle_h_rsci_adra_d;
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
  wire [31:0] COMP_LOOP_1_mult_cmp_return_rsc_z;
  wire COMP_LOOP_1_mult_cmp_ccs_ccore_en;
  wire [31:0] COMP_LOOP_1_modulo_sub_cmp_return_rsc_z;
  wire COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en;
  wire [31:0] COMP_LOOP_1_modulo_add_cmp_return_rsc_z;
  wire [7:0] fsm_output;
  wire mux_tmp_2;
  wire and_dcpl_3;
  wire nor_tmp_3;
  wire or_tmp_6;
  wire and_dcpl_8;
  wire and_dcpl_14;
  wire nor_tmp_6;
  wire mux_tmp_22;
  wire or_dcpl_72;
  wire or_dcpl_76;
  wire or_tmp_26;
  wire nand_tmp;
  wire and_dcpl_22;
  wire and_dcpl_23;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_38;
  wire and_dcpl_39;
  wire and_dcpl_43;
  wire and_dcpl_44;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire and_dcpl_47;
  wire and_dcpl_50;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_56;
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
  wire and_dcpl_68;
  wire and_dcpl_69;
  wire and_dcpl_70;
  wire and_dcpl_71;
  wire and_dcpl_72;
  wire and_dcpl_73;
  wire and_dcpl_74;
  wire and_dcpl_75;
  wire and_dcpl_76;
  wire or_tmp_29;
  wire and_dcpl_79;
  wire and_dcpl_83;
  wire and_dcpl_89;
  wire and_dcpl_93;
  wire and_dcpl_94;
  wire nor_tmp_12;
  wire and_dcpl_97;
  wire and_dcpl_99;
  wire and_dcpl_101;
  wire and_dcpl_105;
  wire and_dcpl_109;
  wire and_dcpl_113;
  wire and_dcpl_122;
  wire and_dcpl_126;
  wire and_dcpl_128;
  wire and_dcpl_135;
  wire or_dcpl_87;
  wire mux_tmp_64;
  wire and_dcpl_149;
  wire mux_tmp_86;
  reg [11:0] VEC_LOOP_acc_1_cse_10_sva;
  reg [12:0] STAGE_LOOP_lshift_psp_sva;
  reg [12:0] VEC_LOOP_j_12_0_1_sva_1;
  reg run_ac_sync_tmp_dobj_sva;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_twiddle_rsci_oswt_1_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_1_cse;
  wire and_171_cse;
  wire and_184_cse;
  wire or_53_cse;
  wire nor_33_cse;
  wire or_58_cse;
  wire or_52_cse;
  wire mux_40_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_24_rmff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [23:0] twiddle_rsci_adra_d_reg;
  wire [7:0] COMP_LOOP_twiddle_f_mux1h_44_rmff;
  wire COMP_LOOP_twiddle_f_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_29_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_57_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_66_rmff;
  wire and_96_rmff;
  wire and_90_rmff;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire [23:0] twiddle_h_rsci_adra_d_reg;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire mux_60_rmff;
  wire and_132_rmff;
  wire and_136_rmff;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_f_9_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_9_sva;
  reg [7:0] VEC_LOOP_acc_psp_sva;
  reg [11:0] VEC_LOOP_acc_10_cse_1_sva;
  reg [8:0] COMP_LOOP_9_twiddle_f_mul_psp_sva;
  reg [31:0] p_sva;
  wire mux_50_itm;
  wire mux_55_itm;
  wire [12:0] STAGE_LOOP_lshift_itm;
  wire [8:0] COMP_LOOP_9_twiddle_f_lshift_itm;
  wire [9:0] z_out;
  wire and_dcpl_171;
  wire and_dcpl_176;
  wire and_dcpl_177;
  wire and_dcpl_178;
  wire and_dcpl_181;
  wire and_dcpl_184;
  wire and_dcpl_187;
  wire and_dcpl_189;
  wire and_dcpl_191;
  wire and_dcpl_194;
  wire and_dcpl_197;
  wire [11:0] z_out_1;
  wire [23:0] nl_z_out_1;
  wire and_dcpl_203;
  wire and_dcpl_204;
  wire and_dcpl_208;
  wire and_dcpl_209;
  wire and_dcpl_211;
  wire and_dcpl_214;
  wire and_dcpl_216;
  wire and_dcpl_217;
  wire and_dcpl_219;
  wire and_dcpl_221;
  wire [11:0] z_out_2;
  wire [23:0] nl_z_out_2;
  wire and_dcpl_227;
  wire and_dcpl_249;
  wire [11:0] z_out_3;
  wire [12:0] nl_z_out_3;
  wire [11:0] z_out_5;
  wire [12:0] nl_z_out_5;
  wire [11:0] z_out_6;
  wire [12:0] nl_z_out_6;
  wire and_dcpl_375;
  wire and_dcpl_376;
  wire and_dcpl_379;
  wire and_dcpl_382;
  wire and_dcpl_385;
  wire and_dcpl_387;
  wire and_dcpl_390;
  wire and_dcpl_392;
  wire and_dcpl_395;
  wire and_dcpl_397;
  wire and_dcpl_399;
  wire and_dcpl_401;
  wire [12:0] z_out_12;
  wire and_dcpl_408;
  wire and_dcpl_411;
  wire and_dcpl_423;
  wire and_dcpl_425;
  wire [9:0] z_out_13;
  wire and_dcpl_428;
  wire and_dcpl_431;
  wire and_dcpl_432;
  wire and_dcpl_435;
  wire and_dcpl_439;
  wire [8:0] z_out_14;
  wire [9:0] nl_z_out_14;
  wire and_dcpl_449;
  wire and_dcpl_455;
  wire and_dcpl_461;
  wire and_dcpl_463;
  wire [10:0] z_out_15;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva;
  reg [11:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [10:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva;
  reg [9:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva;
  reg [7:0] COMP_LOOP_k_12_4_sva_7_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
  wire [4:0] nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c1;
  wire [11:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
  wire [10:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
  wire COMP_LOOP_twiddle_f_or_6_cse;
  wire COMP_LOOP_twiddle_f_or_11_cse;
  wire COMP_LOOP_twiddle_f_or_15_cse;
  wire VEC_LOOP_or_6_cse;
  wire VEC_LOOP_or_7_cse;
  wire VEC_LOOP_or_8_cse;
  wire VEC_LOOP_or_53_cse;
  wire VEC_LOOP_or_54_cse;
  wire VEC_LOOP_or_55_cse;
  wire VEC_LOOP_or_56_cse;
  wire VEC_LOOP_or_57_cse;
  wire VEC_LOOP_or_15_cse;
  wire VEC_LOOP_or_19_cse;
  wire and_494_cse;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire COMP_LOOP_twiddle_help_and_1_cse;
  wire and_300_cse;
  wire and_316_cse;
  wire and_293_cse;
  wire and_311_cse;
  wire and_290_cse;
  wire and_296_cse;
  wire and_302_cse;
  wire and_306_cse;
  wire and_309_cse;
  wire and_313_cse;
  wire and_318_cse;
  wire and_322_cse;
  wire [10:0] VEC_LOOP_VEC_LOOP_mux_1_rgt;
  reg VEC_LOOP_acc_12_psp_sva_10;
  reg [9:0] VEC_LOOP_acc_12_psp_sva_9_0;
  wire or_175_cse;
  wire and_cse;
  wire COMP_LOOP_twiddle_f_or_18_itm;
  wire COMP_LOOP_twiddle_f_nor_5_itm;
  wire COMP_LOOP_twiddle_f_or_20_itm;
  wire COMP_LOOP_twiddle_f_or_1_itm;
  wire VEC_LOOP_or_65_itm;
  wire VEC_LOOP_or_60_itm;
  wire VEC_LOOP_or_69_itm;
  wire VEC_LOOP_or_72_itm;
  wire VEC_LOOP_nor_12_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire [31:0] VEC_LOOP_mux_41_cse;
  wire [11:0] acc_1_cse_12_1;
  wire [12:0] nl_acc_1_cse_12_1;
  wire VEC_LOOP_or_82_cse;

  wire[0:0] or_113_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] and_177_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_14_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_29_nl;
  wire[7:0] COMP_LOOP_1_twiddle_f_mul_nl;
  wire[15:0] nl_COMP_LOOP_1_twiddle_f_mul_nl;
  wire[0:0] and_116_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_57_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] or_118_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] nor_31_nl;
  wire[0:0] nor_32_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] mux_61_nl;
  wire[0:0] or_126_nl;
  wire[0:0] and_178_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] mux_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] or_59_nl;
  wire[0:0] mux_19_nl;
  wire[0:0] mux_16_nl;
  wire[0:0] mux_15_nl;
  wire[0:0] nor_5_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] or_142_nl;
  wire[0:0] or_141_nl;
  wire[0:0] or_140_nl;
  wire[0:0] mux_75_nl;
  wire[0:0] mux_74_nl;
  wire[0:0] or_139_nl;
  wire[0:0] or_138_nl;
  wire[0:0] nor_20_nl;
  wire[11:0] VEC_LOOP_VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_or_nl;
  wire[0:0] VEC_LOOP_not_nl;
  wire[0:0] VEC_LOOP_or_51_nl;
  wire[0:0] VEC_LOOP_or_52_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] nor_29_nl;
  wire[0:0] and_157_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] or_176_nl;
  wire[0:0] and_514_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] mux_63_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[8:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_85_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_81_nl;
  wire[7:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_33_nl;
  wire[0:0] and_42_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] and_77_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] mux_51_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] and_82_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] and_86_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] or_111_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] and_87_nl;
  wire[11:0] COMP_LOOP_twiddle_f_mux1h_164_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_30_nl;
  wire[1:0] COMP_LOOP_twiddle_f_and_17_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl;
  wire[0:0] COMP_LOOP_twiddle_f_nor_9_nl;
  wire[5:0] COMP_LOOP_twiddle_f_mux1h_165_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_31_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_32_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_7_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_4_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl;
  wire[10:0] COMP_LOOP_twiddle_f_mux1h_166_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_20_nl;
  wire[6:0] COMP_LOOP_twiddle_f_mux1h_167_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_33_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_8_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_6_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_7_nl;
  wire[11:0] VEC_LOOP_mux_39_nl;
  wire[7:0] VEC_LOOP_VEC_LOOP_mux_11_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_18_nl;
  wire[3:0] VEC_LOOP_or_76_nl;
  wire[3:0] VEC_LOOP_mux1h_32_nl;
  wire[0:0] and_515_nl;
  wire[0:0] and_516_nl;
  wire[8:0] VEC_LOOP_mux1h_33_nl;
  wire[0:0] and_517_nl;
  wire[2:0] VEC_LOOP_VEC_LOOP_mux_12_nl;
  wire[13:0] acc_9_nl;
  wire[14:0] nl_acc_9_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_19_nl;
  wire[11:0] VEC_LOOP_VEC_LOOP_mux_13_nl;
  wire[0:0] VEC_LOOP_or_77_nl;
  wire[7:0] VEC_LOOP_VEC_LOOP_mux_14_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_20_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_21_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_22_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_23_nl;
  wire[10:0] acc_10_nl;
  wire[11:0] nl_acc_10_nl;
  wire[9:0] VEC_LOOP_mux1h_34_nl;
  wire[0:0] VEC_LOOP_or_78_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_2_nl;
  wire[0:0] VEC_LOOP_and_24_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_15_nl;
  wire[5:0] VEC_LOOP_mux1h_35_nl;
  wire[0:0] VEC_LOOP_or_79_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_24_nl;
  wire[0:0] VEC_LOOP_mux_40_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_25_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_3_nl;
  wire[7:0] VEC_LOOP_VEC_LOOP_mux_16_nl;
  wire[8:0] VEC_LOOP_mux1h_36_nl;
  wire[11:0] acc_12_nl;
  wire[12:0] nl_acc_12_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_26_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_17_nl;
  wire[0:0] VEC_LOOP_or_80_nl;
  wire[0:0] VEC_LOOP_and_27_nl;
  wire[6:0] VEC_LOOP_VEC_LOOP_mux_18_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_27_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_28_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_29_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat = MUX_v_32_2_2(COMP_LOOP_twiddle_f_1_sva,
      COMP_LOOP_twiddle_f_9_sva, and_dcpl_68);
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1 = MUX_v_32_2_2(COMP_LOOP_twiddle_help_1_sva,
      COMP_LOOP_twiddle_help_9_sva, and_dcpl_68);
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_p_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_p_rsc_dat = p_sva;
  wire [0:0] nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat = and_dcpl_23 & and_dcpl_31;
  wire[32:0] acc_13_nl;
  wire[33:0] nl_acc_13_nl;
  wire[31:0] VEC_LOOP_mux_42_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_42_nl = MUX_v_32_2_2((~ (vec_rsci_qa_d_mxwt[63:32])), (~ (vec_rsci_qa_d_mxwt[31:0])),
      and_494_cse);
  assign nl_acc_13_nl = ({VEC_LOOP_mux_41_cse , 1'b1}) + ({VEC_LOOP_mux_42_nl , 1'b1});
  assign acc_13_nl = nl_acc_13_nl[32:0];
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = readslicef_33_32_1(acc_13_nl);
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire[31:0] VEC_LOOP_mux_44_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_44_nl = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
      and_494_cse);
  assign nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat = VEC_LOOP_mux_41_cse + VEC_LOOP_mux_44_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat = p_sva;
  wire[0:0] and_194_nl;
  wire [3:0] nl_COMP_LOOP_1_twiddle_f_lshift_rg_s;
  assign and_194_nl = (fsm_output==8'b00011010);
  assign nl_COMP_LOOP_1_twiddle_f_lshift_rg_s = MUX_v_4_2_2(COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0,
      COMP_LOOP_1_twiddle_f_acc_cse_sva, and_194_nl);
  wire[31:0] VEC_LOOP_mux_3_nl;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_3_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      COMP_LOOP_1_mult_cmp_return_rsc_z, and_dcpl_36);
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_3_nl};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (~ mux_55_itm)};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_24_rmff , and_24_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (~ mux_55_itm)};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_50_itm;
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_96_rmff , and_90_rmff};
  wire [23:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core_pff
      = {(z_out_1[9:0]) , 2'b00 , COMP_LOOP_twiddle_f_mux1h_44_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_29_rmff , COMP_LOOP_twiddle_f_mux1h_57_rmff , COMP_LOOP_twiddle_f_mux1h_66_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core_psct_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core_psct_pff
      = {and_96_rmff , and_90_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_96_rmff , and_90_rmff};
  wire [23:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core_pff
      = {(z_out_1[9:0]) , 2'b00 , COMP_LOOP_twiddle_f_mux1h_44_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_29_rmff , COMP_LOOP_twiddle_f_mux1h_57_rmff , COMP_LOOP_twiddle_f_mux1h_66_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core_psct_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core_psct_pff
      = {and_96_rmff , and_90_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ run_ac_sync_tmp_dobj_sva;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (z_out_15[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_13[9]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ (z_out_15[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ (z_out_12[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_13[8]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire[12:0] COMP_LOOP_1_acc_nl;
  wire[13:0] nl_COMP_LOOP_1_acc_nl;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_COMP_LOOP_1_acc_nl = ({z_out_14 , 4'b0000}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[12:1]))})
      + 13'b0000000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[12:0];
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (readslicef_13_1_12(COMP_LOOP_1_acc_nl));
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ STAGE_LOOP_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd14),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mult  COMP_LOOP_1_mult_cmp (
      .x_rsc_dat(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z),
      .y_rsc_dat(nl_COMP_LOOP_1_mult_cmp_y_rsc_dat[31:0]),
      .y_rsc_dat_1(nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1[31:0]),
      .p_rsc_dat(nl_COMP_LOOP_1_mult_cmp_p_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_mult_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat[0:0]),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_mult_cmp_ccs_ccore_en)
    );
  modulo_sub  COMP_LOOP_1_modulo_sub_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_136_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_136_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) STAGE_LOOP_lshift_rg (
      .a(1'b1),
      .s(STAGE_LOOP_i_3_0_sva),
      .z(STAGE_LOOP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd9)) COMP_LOOP_9_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0),
      .z(COMP_LOOP_9_twiddle_f_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd12)) COMP_LOOP_2_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
      .z(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) COMP_LOOP_3_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
      .z(COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_1_twiddle_f_lshift_rg_s[3:0]),
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
  inPlaceNTT_DIF_precomp_core_vec_rsci_1 inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst
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
      .vec_rsci_da_d_core(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core[63:0]),
      .vec_rsci_qa_d_mxwt(vec_rsci_qa_d_mxwt),
      .vec_rsci_wea_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct[1:0]),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .vec_rsci_oswt_pff(nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff[0:0]),
      .vec_rsci_oswt_1_pff(and_24_rmff)
    );
  inPlaceNTT_DIF_precomp_core_wait_dp inPlaceNTT_DIF_precomp_core_wait_dp_inst (
      .ensig_cgo_iro(mux_60_rmff),
      .ensig_cgo_iro_1(and_132_rmff),
      .core_wen(complete_rsci_wen_comp),
      .ensig_cgo(reg_ensig_cgo_cse),
      .COMP_LOOP_1_mult_cmp_ccs_ccore_en(COMP_LOOP_1_mult_cmp_ccs_ccore_en),
      .ensig_cgo_1(reg_ensig_cgo_1_cse),
      .COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsci_1 inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsci_adra_d(twiddle_rsci_adra_d_reg),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_rsci_oswt_1(reg_twiddle_rsci_oswt_1_cse),
      .twiddle_rsci_qa_d_mxwt(twiddle_rsci_qa_d_mxwt),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .twiddle_rsci_adra_d_core_pff(nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core_pff[23:0]),
      .twiddle_rsci_adra_d_core_psct_pff(nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_adra_d_core_psct_pff[1:0]),
      .core_wten_pff(core_wten_iff),
      .twiddle_rsci_oswt_1_pff(and_96_rmff),
      .twiddle_rsci_oswt_pff(and_90_rmff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_adra_d(twiddle_h_rsci_adra_d_reg),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_h_rsci_oswt_1(reg_twiddle_rsci_oswt_1_cse),
      .twiddle_h_rsci_qa_d_mxwt(twiddle_h_rsci_qa_d_mxwt),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .twiddle_h_rsci_adra_d_core_pff(nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core_pff[23:0]),
      .twiddle_h_rsci_adra_d_core_psct_pff(nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_adra_d_core_psct_pff[1:0]),
      .core_wten_pff(core_wten_iff),
      .twiddle_h_rsci_oswt_1_pff(and_96_rmff),
      .twiddle_h_rsci_oswt_pff(and_90_rmff)
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
  inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj inPlaceNTT_DIF_precomp_core_vec_rsc_triosy_obj_inst
      (
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .core_wten(core_wten),
      .vec_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj inPlaceNTT_DIF_precomp_core_p_rsc_triosy_obj_inst
      (
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .core_wten(core_wten),
      .p_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj inPlaceNTT_DIF_precomp_core_r_rsc_triosy_obj_inst
      (
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .core_wten(core_wten),
      .r_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj inPlaceNTT_DIF_precomp_core_twiddle_rsc_triosy_obj_inst
      (
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .core_wten(core_wten),
      .twiddle_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj inPlaceNTT_DIF_precomp_core_twiddle_h_rsc_triosy_obj_inst
      (
      .twiddle_h_rsc_triosy_lz(twiddle_h_rsc_triosy_lz),
      .core_wten(core_wten),
      .twiddle_h_rsc_triosy_obj_iswt0(reg_vec_rsc_triosy_obj_iswt0_cse)
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
      .COMP_LOOP_1_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_2_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0[0:0]),
      .COMP_LOOP_2_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_3_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0[0:0]),
      .COMP_LOOP_3_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_4_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0[0:0]),
      .COMP_LOOP_4_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_5_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0[0:0]),
      .COMP_LOOP_5_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_6_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_7_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0[0:0]),
      .COMP_LOOP_7_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_8_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_8_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_9_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0[0:0]),
      .COMP_LOOP_9_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_10_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0[0:0]),
      .COMP_LOOP_10_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_11_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0[0:0]),
      .COMP_LOOP_11_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_12_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0[0:0]),
      .COMP_LOOP_12_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_13_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0[0:0]),
      .COMP_LOOP_13_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_14_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0[0:0]),
      .COMP_LOOP_14_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_15_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0[0:0]),
      .COMP_LOOP_15_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_16_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0[0:0]),
      .COMP_LOOP_16_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_17_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign mux_50_itm = MUX_s_1_2_2(nand_tmp, or_tmp_26, fsm_output[2]);
  assign and_24_rmff = and_dcpl_23 & and_dcpl_22;
  assign or_113_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[7]);
  assign mux_55_itm = MUX_s_1_2_2(nand_tmp, or_113_nl, fsm_output[2]);
  assign and_177_nl = (fsm_output[6:3]==4'b1111);
  assign mux_56_nl = MUX_s_1_2_2(or_53_cse, and_177_nl, VEC_LOOP_j_12_0_1_sva_1[12]);
  assign and_90_rmff = (~ mux_56_nl) & and_dcpl_89;
  assign and_96_rmff = and_dcpl_94 & and_dcpl_93 & and_dcpl_46 & (~ (fsm_output[2]))
      & (VEC_LOOP_j_12_0_1_sva_1[12]);
  assign COMP_LOOP_twiddle_f_or_6_cse = (and_dcpl_38 & and_dcpl_97) | (and_dcpl_52
      & and_dcpl_97) | (and_dcpl_58 & and_dcpl_97) | (and_dcpl_62 & and_dcpl_97)
      | (and_dcpl_55 & and_dcpl_105);
  assign COMP_LOOP_twiddle_f_or_11_cse = (and_dcpl_60 & and_dcpl_97) | (and_dcpl_38
      & and_dcpl_105) | (and_dcpl_58 & and_dcpl_105);
  assign COMP_LOOP_twiddle_f_or_15_cse = (and_dcpl_14 & and_dcpl_105) | (and_dcpl_44
      & and_dcpl_105) | (and_dcpl_60 & and_dcpl_105);
  assign COMP_LOOP_twiddle_f_mux1h_14_nl = MUX1HOT_s_1_6_2((z_out_1[3]), (z_out_1[2]),
      (COMP_LOOP_9_twiddle_f_mul_psp_sva[0]), (z_out_2[2]), (z_out_2[3]), (z_out_1[1]),
      {COMP_LOOP_twiddle_f_or_6_cse , and_dcpl_99 , and_dcpl_101 , COMP_LOOP_twiddle_f_or_11_cse
      , COMP_LOOP_twiddle_f_or_15_cse , and_dcpl_109});
  assign mux_57_nl = MUX_s_1_2_2((~ or_tmp_6), nor_tmp_12, fsm_output[6]);
  assign COMP_LOOP_twiddle_f_and_rmff = COMP_LOOP_twiddle_f_mux1h_14_nl & (~(mux_57_nl
      | or_tmp_26 | (fsm_output[2:1]!=2'b01)));
  assign COMP_LOOP_twiddle_f_mux1h_29_nl = MUX1HOT_s_1_5_2((z_out_1[2]), (z_out_1[1]),
      (z_out_2[1]), (z_out_2[2]), (z_out_1[0]), {COMP_LOOP_twiddle_f_or_6_cse , and_dcpl_99
      , COMP_LOOP_twiddle_f_or_11_cse , COMP_LOOP_twiddle_f_or_15_cse , and_dcpl_109});
  assign COMP_LOOP_twiddle_f_mux1h_29_rmff = COMP_LOOP_twiddle_f_mux1h_29_nl & (~(and_dcpl_83
      & and_dcpl_93 & and_dcpl_113));
  assign nl_COMP_LOOP_1_twiddle_f_mul_nl = (z_out[7:0]) * COMP_LOOP_k_12_4_sva_7_0;
  assign COMP_LOOP_1_twiddle_f_mul_nl = nl_COMP_LOOP_1_twiddle_f_mul_nl[7:0];
  assign and_116_nl = and_dcpl_14 & and_dcpl_97;
  assign COMP_LOOP_twiddle_f_mux1h_44_rmff = MUX1HOT_v_8_7_2(COMP_LOOP_1_twiddle_f_mul_nl,
      (z_out_1[11:4]), (z_out_1[10:3]), (COMP_LOOP_9_twiddle_f_mul_psp_sva[8:1]),
      (z_out_2[10:3]), (z_out_2[11:4]), (z_out_1[9:2]), {and_116_nl , COMP_LOOP_twiddle_f_or_6_cse
      , and_dcpl_99 , and_dcpl_101 , COMP_LOOP_twiddle_f_or_11_cse , COMP_LOOP_twiddle_f_or_15_cse
      , and_dcpl_109});
  assign COMP_LOOP_twiddle_f_mux1h_57_nl = MUX1HOT_s_1_4_2((z_out_1[1]), (z_out_1[0]),
      (z_out_2[0]), (z_out_2[1]), {COMP_LOOP_twiddle_f_or_6_cse , and_dcpl_99 , COMP_LOOP_twiddle_f_or_11_cse
      , COMP_LOOP_twiddle_f_or_15_cse});
  assign or_118_nl = (fsm_output[5:3]!=3'b011);
  assign mux_58_nl = MUX_s_1_2_2(or_58_cse, or_118_nl, fsm_output[6]);
  assign COMP_LOOP_twiddle_f_mux1h_57_rmff = COMP_LOOP_twiddle_f_mux1h_57_nl & (~((~
      mux_58_nl) & and_dcpl_89));
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl = MUX_s_1_2_2((z_out_1[0]),
      (z_out_2[0]), COMP_LOOP_twiddle_f_or_15_cse);
  assign nand_1_nl = ~((fsm_output[3]) & (~ nor_tmp_3));
  assign mux_59_nl = MUX_s_1_2_2((fsm_output[3]), nand_1_nl, fsm_output[6]);
  assign COMP_LOOP_twiddle_f_mux1h_66_rmff = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl
      & (~((~ mux_59_nl) & and_dcpl_89));
  assign nor_31_nl = ~((fsm_output[1:0]!=2'b00) | mux_tmp_2);
  assign nor_32_nl = ~((~ (fsm_output[1])) | (fsm_output[7]));
  assign mux_60_rmff = MUX_s_1_2_2(nor_31_nl, nor_32_nl, fsm_output[2]);
  assign and_132_rmff = ((fsm_output[0]) ^ (fsm_output[1])) & (~ (fsm_output[7]))
      & (fsm_output[2]);
  assign and_136_rmff = and_dcpl_135 & and_dcpl_22;
  assign and_cse = (fsm_output[7]) & or_53_cse;
  assign and_171_cse = (fsm_output[1:0]==2'b11);
  assign and_184_cse = (fsm_output[4:3]==2'b11);
  assign or_58_cse = (fsm_output[4:3]!=2'b00);
  assign or_53_cse = (fsm_output[6:3]!=4'b0000);
  assign nor_33_cse = ~((fsm_output[4:3]!=2'b00));
  assign or_52_cse = (fsm_output[6:5]!=2'b00);
  assign mux_76_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign or_142_nl = (fsm_output[7:6]!=2'b00);
  assign mux_77_nl = MUX_s_1_2_2(mux_76_nl, or_142_nl, fsm_output[3]);
  assign or_141_nl = (~ (fsm_output[3])) | (~ (fsm_output[6])) | (fsm_output[7]);
  assign mux_78_nl = MUX_s_1_2_2(mux_77_nl, or_141_nl, and_171_cse);
  assign or_140_nl = (~((fsm_output[3]) | (~ (fsm_output[6])))) | (fsm_output[7]);
  assign mux_79_nl = MUX_s_1_2_2(mux_78_nl, or_140_nl, fsm_output[2]);
  assign or_139_nl = ((VEC_LOOP_j_12_0_1_sva_1[12]) & (fsm_output[6])) | (fsm_output[7]);
  assign or_138_nl = (fsm_output[7:6]!=2'b01);
  assign mux_74_nl = MUX_s_1_2_2(or_139_nl, or_138_nl, fsm_output[0]);
  assign nor_20_nl = ~((fsm_output[2:1]!=2'b01));
  assign mux_75_nl = MUX_s_1_2_2((fsm_output[7]), mux_74_nl, nor_20_nl);
  assign mux_80_nl = MUX_s_1_2_2(mux_79_nl, mux_75_nl, or_175_cse);
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & mux_80_nl;
  assign VEC_LOOP_or_53_cse = and_dcpl_45 | and_dcpl_72;
  assign VEC_LOOP_or_54_cse = and_dcpl_53 | and_dcpl_73;
  assign VEC_LOOP_or_55_cse = and_dcpl_56 | and_dcpl_74;
  assign VEC_LOOP_or_56_cse = and_dcpl_63 | and_dcpl_71;
  assign VEC_LOOP_or_57_cse = and_dcpl_69 | and_dcpl_75;
  assign and_157_nl = and_dcpl_94 & (fsm_output[3:1]==3'b010);
  assign VEC_LOOP_VEC_LOOP_mux_1_rgt = MUX_v_11_2_2(z_out_15, ({1'b0 , z_out_13}),
      and_157_nl);
  assign or_175_cse = (fsm_output[5:4]!=2'b00);
  assign mux_96_nl = MUX_s_1_2_2((~ nor_tmp_3), or_175_cse, fsm_output[6]);
  assign mux_97_nl = MUX_s_1_2_2(mux_96_nl, mux_40_cse, and_171_cse);
  assign mux_98_nl = MUX_s_1_2_2(mux_97_nl, mux_40_cse, fsm_output[2]);
  assign COMP_LOOP_twiddle_help_and_1_cse = complete_rsci_wen_comp & (mux_98_nl |
      (fsm_output[7]));
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b1111;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0 = (~ STAGE_LOOP_i_3_0_sva) +
      4'b1101;
  assign COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0 = nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0[3:0];
  assign mux_tmp_2 = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), or_53_cse);
  assign and_dcpl_3 = ~((fsm_output[7]) | (fsm_output[5]));
  assign nor_tmp_3 = (fsm_output[5:4]==2'b11);
  assign or_tmp_6 = (fsm_output[5:3]!=3'b000);
  assign and_dcpl_8 = (fsm_output[2:1]==2'b01);
  assign and_dcpl_14 = and_dcpl_3 & nor_33_cse;
  assign nor_tmp_6 = or_58_cse & (fsm_output[5]);
  assign mux_tmp_22 = MUX_s_1_2_2((~ or_175_cse), nor_tmp_6, fsm_output[6]);
  assign mux_40_cse = MUX_s_1_2_2((~ nor_tmp_6), or_tmp_6, fsm_output[6]);
  assign or_dcpl_72 = (fsm_output[6]) | (fsm_output[0]);
  assign or_dcpl_76 = (fsm_output[7]) | (fsm_output[5]) | or_58_cse;
  assign or_tmp_26 = (fsm_output[0]) | (fsm_output[7]);
  assign nand_tmp = (fsm_output[1:0]!=2'b01) | mux_tmp_2;
  assign and_dcpl_22 = (fsm_output[2:1]==2'b10);
  assign and_dcpl_23 = ~((fsm_output[7]) | (fsm_output[0]));
  assign and_dcpl_25 = ~((fsm_output[6]) | (fsm_output[0]));
  assign and_dcpl_26 = and_dcpl_25 & and_dcpl_22;
  assign and_dcpl_30 = and_dcpl_14 & and_dcpl_26;
  assign and_dcpl_31 = (fsm_output[2:1]==2'b11);
  assign and_dcpl_36 = ~(mux_tmp_2 | (fsm_output[2:0]!=3'b001));
  assign and_dcpl_37 = (fsm_output[4:3]==2'b01);
  assign and_dcpl_38 = and_dcpl_3 & and_dcpl_37;
  assign and_dcpl_39 = and_dcpl_38 & and_dcpl_26;
  assign and_dcpl_43 = (fsm_output[4:3]==2'b10);
  assign and_dcpl_44 = and_dcpl_3 & and_dcpl_43;
  assign and_dcpl_45 = and_dcpl_44 & and_dcpl_26;
  assign and_dcpl_46 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_47 = and_dcpl_46 & (fsm_output[2]);
  assign and_dcpl_50 = (~ (fsm_output[7])) & (fsm_output[4]) & (~ (fsm_output[3]))
      & and_dcpl_47;
  assign and_dcpl_52 = and_dcpl_3 & and_184_cse;
  assign and_dcpl_53 = and_dcpl_52 & and_dcpl_26;
  assign and_dcpl_54 = (~ (fsm_output[7])) & (fsm_output[5]);
  assign and_dcpl_55 = and_dcpl_54 & nor_33_cse;
  assign and_dcpl_56 = and_dcpl_55 & and_dcpl_26;
  assign and_dcpl_57 = and_dcpl_55 & and_dcpl_47;
  assign and_dcpl_58 = and_dcpl_54 & and_dcpl_37;
  assign and_dcpl_59 = and_dcpl_58 & and_dcpl_26;
  assign and_dcpl_60 = and_dcpl_54 & and_dcpl_43;
  assign and_dcpl_61 = and_dcpl_60 & and_dcpl_26;
  assign and_dcpl_62 = and_dcpl_54 & and_184_cse;
  assign and_dcpl_63 = and_dcpl_62 & and_dcpl_26;
  assign and_dcpl_64 = (fsm_output[6]) & (~ (fsm_output[0]));
  assign and_dcpl_65 = and_dcpl_64 & and_dcpl_22;
  assign and_dcpl_66 = and_dcpl_14 & and_dcpl_65;
  assign and_dcpl_68 = and_dcpl_14 & and_dcpl_64 & and_dcpl_31;
  assign and_dcpl_69 = and_dcpl_38 & and_dcpl_65;
  assign and_dcpl_70 = and_dcpl_44 & and_dcpl_65;
  assign and_dcpl_71 = and_dcpl_52 & and_dcpl_65;
  assign and_dcpl_72 = and_dcpl_55 & and_dcpl_65;
  assign and_dcpl_73 = and_dcpl_58 & and_dcpl_65;
  assign and_dcpl_74 = and_dcpl_60 & and_dcpl_65;
  assign and_dcpl_75 = and_dcpl_62 & and_dcpl_65;
  assign and_dcpl_76 = and_dcpl_23 & (fsm_output[2]);
  assign or_tmp_29 = (fsm_output[3]) | (~ or_175_cse);
  assign and_dcpl_79 = (~ (fsm_output[3])) & (~ (fsm_output[0])) & and_dcpl_22;
  assign and_dcpl_83 = ~((fsm_output[7]) | (fsm_output[4]));
  assign and_dcpl_89 = and_dcpl_23 & and_dcpl_8;
  assign and_dcpl_93 = ~((fsm_output[3]) | (fsm_output[6]));
  assign and_dcpl_94 = and_dcpl_54 & (~ (fsm_output[4]));
  assign nor_tmp_12 = (fsm_output[5:3]==3'b111);
  assign and_dcpl_97 = and_dcpl_25 & and_dcpl_8;
  assign and_dcpl_99 = and_dcpl_44 & and_dcpl_97;
  assign and_dcpl_101 = and_dcpl_55 & and_dcpl_97;
  assign and_dcpl_105 = and_dcpl_64 & and_dcpl_8;
  assign and_dcpl_109 = and_dcpl_52 & and_dcpl_105;
  assign and_dcpl_113 = and_dcpl_46 & (~ (fsm_output[2]));
  assign and_dcpl_122 = (fsm_output[7]) & (~ (fsm_output[5]));
  assign and_dcpl_126 = (~ (fsm_output[6])) & (fsm_output[0]);
  assign and_dcpl_128 = and_dcpl_122 & nor_33_cse;
  assign and_dcpl_135 = (~ (fsm_output[7])) & (fsm_output[0]);
  assign or_dcpl_87 = (fsm_output[2:1]!=2'b10);
  assign mux_63_nl = MUX_s_1_2_2(mux_tmp_2, and_cse, fsm_output[1]);
  assign mux_tmp_64 = MUX_s_1_2_2(mux_63_nl, (fsm_output[7]), fsm_output[2]);
  assign and_dcpl_149 = and_dcpl_55 & and_dcpl_126 & and_dcpl_8;
  assign mux_tmp_86 = MUX_s_1_2_2((~ or_tmp_6), nor_tmp_3, fsm_output[6]);
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_128 & and_dcpl_26;
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c1 = and_dcpl_135 & and_dcpl_8;
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ STAGE_LOOP_i_3_0_sva_2)}) + 5'b00001;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign VEC_LOOP_or_6_cse = and_dcpl_45 | and_dcpl_61 | and_dcpl_70 | and_dcpl_74;
  assign VEC_LOOP_or_7_cse = and_dcpl_53 | and_dcpl_59 | and_dcpl_63 | and_dcpl_69
      | and_dcpl_71 | and_dcpl_73 | and_dcpl_75;
  assign VEC_LOOP_or_8_cse = and_dcpl_56 | and_dcpl_72;
  assign VEC_LOOP_or_15_cse = and_dcpl_39 | and_dcpl_70;
  assign VEC_LOOP_or_19_cse = and_dcpl_61 | and_dcpl_66;
  assign VEC_LOOP_or_82_cse = VEC_LOOP_or_53_cse | VEC_LOOP_or_54_cse | VEC_LOOP_or_55_cse
      | VEC_LOOP_or_56_cse | VEC_LOOP_or_57_cse | and_dcpl_59;
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_v_9_6_2((z_out_6[11:3]), (acc_1_cse_12_1[11:3]),
      (z_out_15[10:2]), (z_out_3[11:3]), (z_out_13[9:1]), (z_out_13[8:0]), {and_dcpl_30
      , and_dcpl_39 , VEC_LOOP_or_6_cse , VEC_LOOP_or_7_cse , VEC_LOOP_or_8_cse ,
      and_dcpl_66});
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_6_2((z_out_6[2]), (acc_1_cse_12_1[2]),
      (z_out_15[1]), (z_out_3[2]), (z_out_13[0]), (VEC_LOOP_acc_1_cse_10_sva[2]),
      {and_dcpl_30 , and_dcpl_39 , VEC_LOOP_or_6_cse , VEC_LOOP_or_7_cse , VEC_LOOP_or_8_cse
      , and_dcpl_66});
  assign and_85_nl = and_dcpl_83 & or_52_cse & and_dcpl_79;
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_5_2((z_out_6[1]), (acc_1_cse_12_1[1]),
      (z_out_15[0]), (z_out_3[1]), (VEC_LOOP_acc_1_cse_10_sva[1]), {and_dcpl_30 ,
      and_dcpl_39 , VEC_LOOP_or_6_cse , VEC_LOOP_or_7_cse , and_85_nl});
  assign and_81_nl = (~((~(or_175_cse | (fsm_output[6]))) | (fsm_output[7]))) & and_dcpl_79;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_4_2((z_out_6[0]), (acc_1_cse_12_1[0]),
      (VEC_LOOP_acc_1_cse_10_sva[0]), (z_out_3[0]), {and_dcpl_30 , and_dcpl_39 ,
      and_81_nl , VEC_LOOP_or_7_cse});
  assign and_33_nl = and_dcpl_14 & and_dcpl_25 & and_dcpl_31;
  assign and_42_nl = (~ (fsm_output[7])) & (fsm_output[3]) & (~ (fsm_output[0]))
      & and_dcpl_31;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_8_10_2((z_out_13[7:0]), VEC_LOOP_acc_psp_sva,
      (VEC_LOOP_acc_10_cse_1_sva[11:4]), (z_out_3[11:4]), (VEC_LOOP_acc_1_cse_10_sva[11:4]),
      (acc_1_cse_12_1[11:4]), ({VEC_LOOP_acc_12_psp_sva_10 , (VEC_LOOP_acc_12_psp_sva_9_0[9:3])}),
      (VEC_LOOP_acc_12_psp_sva_9_0[9:2]), (z_out_6[11:4]), (COMP_LOOP_9_twiddle_f_mul_psp_sva[8:1]),
      {and_dcpl_30 , and_33_nl , and_dcpl_36 , VEC_LOOP_or_15_cse , and_42_nl , VEC_LOOP_or_82_cse
      , and_dcpl_50 , and_dcpl_57 , VEC_LOOP_or_19_cse , and_dcpl_68});
  assign mux_51_nl = MUX_s_1_2_2(or_tmp_29, (fsm_output[3]), fsm_output[6]);
  assign mux_52_nl = MUX_s_1_2_2((~ or_53_cse), mux_51_nl, fsm_output[1]);
  assign and_77_nl = mux_52_nl & and_dcpl_76;
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_8_2((VEC_LOOP_acc_1_cse_10_sva[3]), (VEC_LOOP_acc_10_cse_1_sva[3]),
      (z_out_3[3]), (acc_1_cse_12_1[3]), (VEC_LOOP_acc_12_psp_sva_9_0[2]), (VEC_LOOP_acc_12_psp_sva_9_0[1]),
      (z_out_6[3]), (COMP_LOOP_9_twiddle_f_mul_psp_sva[0]), {and_77_nl , and_dcpl_36
      , VEC_LOOP_or_15_cse , VEC_LOOP_or_82_cse , and_dcpl_50 , and_dcpl_57 , VEC_LOOP_or_19_cse
      , and_dcpl_68});
  assign mux_53_nl = MUX_s_1_2_2((~ or_53_cse), or_tmp_29, fsm_output[1]);
  assign and_82_nl = mux_53_nl & and_dcpl_76;
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_7_2((VEC_LOOP_acc_1_cse_10_sva[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_3[2]), (acc_1_cse_12_1[2]), (VEC_LOOP_acc_12_psp_sva_9_0[1]), (VEC_LOOP_acc_12_psp_sva_9_0[0]),
      (z_out_6[2]), {and_82_nl , and_dcpl_36 , VEC_LOOP_or_15_cse , VEC_LOOP_or_82_cse
      , and_dcpl_50 , and_dcpl_57 , VEC_LOOP_or_19_cse});
  assign or_111_nl = (fsm_output[4:3]!=2'b10);
  assign mux_54_nl = MUX_s_1_2_2((~ or_53_cse), or_111_nl, fsm_output[1]);
  assign and_86_nl = mux_54_nl & and_dcpl_76;
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_6_2((VEC_LOOP_acc_1_cse_10_sva[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_3[1]), (acc_1_cse_12_1[1]), (VEC_LOOP_acc_12_psp_sva_9_0[0]), (z_out_6[1]),
      {and_86_nl , and_dcpl_36 , VEC_LOOP_or_15_cse , VEC_LOOP_or_82_cse , and_dcpl_50
      , VEC_LOOP_or_19_cse});
  assign and_87_nl = ((~ or_53_cse) | (fsm_output[1])) & and_dcpl_76;
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_5_2((VEC_LOOP_acc_1_cse_10_sva[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_3[0]), (acc_1_cse_12_1[0]), (z_out_6[0]), {and_87_nl , and_dcpl_36 ,
      VEC_LOOP_or_15_cse , VEC_LOOP_or_82_cse , VEC_LOOP_or_19_cse});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_8_nl , VEC_LOOP_mux1h_6_nl , VEC_LOOP_mux1h_4_nl
      , VEC_LOOP_mux1h_2_nl , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl , VEC_LOOP_mux1h_3_nl
      , VEC_LOOP_mux1h_5_nl , VEC_LOOP_mux1h_7_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_adra_d = twiddle_rsci_adra_d_reg;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_adra_d = twiddle_h_rsci_adra_d_reg;
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign and_dcpl_171 = (fsm_output[6:5]==2'b01);
  assign and_dcpl_176 = (fsm_output[1]) & (~ (fsm_output[0])) & (~((fsm_output[2])
      | (fsm_output[7])));
  assign and_dcpl_177 = and_dcpl_176 & nor_33_cse & and_dcpl_171;
  assign and_dcpl_178 = ~((fsm_output[6:5]!=2'b00));
  assign and_dcpl_181 = and_dcpl_176 & and_dcpl_37 & and_dcpl_178;
  assign and_dcpl_184 = and_dcpl_176 & (fsm_output[4:3]==2'b10) & and_dcpl_178;
  assign and_dcpl_187 = and_dcpl_176 & and_184_cse & and_dcpl_178;
  assign and_dcpl_189 = and_dcpl_176 & and_dcpl_37 & and_dcpl_171;
  assign and_dcpl_191 = and_dcpl_176 & and_184_cse & and_dcpl_171;
  assign and_dcpl_194 = and_dcpl_176 & and_184_cse & (fsm_output[6:5]==2'b10);
  assign and_dcpl_197 = and_dcpl_176 & nor_33_cse & (fsm_output[6:5]==2'b11);
  assign and_dcpl_203 = (fsm_output[2:1]==2'b01) & and_dcpl_23;
  assign and_dcpl_204 = and_dcpl_203 & nor_33_cse & (fsm_output[6:5]==2'b00);
  assign and_dcpl_208 = and_dcpl_203 & and_dcpl_43 & (fsm_output[6:5]==2'b01);
  assign and_dcpl_209 = (fsm_output[6:5]==2'b10);
  assign and_dcpl_211 = and_dcpl_203 & nor_33_cse & and_dcpl_209;
  assign and_dcpl_214 = and_dcpl_203 & and_dcpl_37 & and_dcpl_209;
  assign and_dcpl_216 = and_dcpl_203 & and_dcpl_43 & and_dcpl_209;
  assign and_dcpl_217 = (fsm_output[6:5]==2'b11);
  assign and_dcpl_219 = and_dcpl_203 & and_dcpl_37 & and_dcpl_217;
  assign and_dcpl_221 = and_dcpl_203 & and_dcpl_43 & and_dcpl_217;
  assign and_dcpl_227 = (~((fsm_output[1:0]!=2'b00))) & (fsm_output[2]) & (~ (fsm_output[7]));
  assign and_dcpl_249 = and_dcpl_227 & (fsm_output[4:3]==2'b10) & and_dcpl_209;
  assign and_290_cse = and_dcpl_227 & and_dcpl_37 & and_dcpl_178;
  assign and_293_cse = and_dcpl_227 & and_dcpl_43 & and_dcpl_178;
  assign and_296_cse = and_dcpl_227 & and_184_cse & and_dcpl_178;
  assign and_300_cse = and_dcpl_227 & nor_33_cse & and_dcpl_171;
  assign and_302_cse = and_dcpl_227 & and_dcpl_37 & and_dcpl_171;
  assign and_306_cse = and_dcpl_227 & and_184_cse & and_dcpl_171;
  assign and_309_cse = and_dcpl_227 & and_dcpl_37 & and_dcpl_209;
  assign and_311_cse = and_dcpl_227 & and_dcpl_43 & and_dcpl_209;
  assign and_313_cse = and_dcpl_227 & and_184_cse & and_dcpl_209;
  assign and_316_cse = and_dcpl_227 & nor_33_cse & and_dcpl_217;
  assign and_318_cse = and_dcpl_227 & and_dcpl_37 & and_dcpl_217;
  assign and_322_cse = and_dcpl_227 & and_184_cse & and_dcpl_217;
  assign and_dcpl_375 = (~ (fsm_output[2])) & (fsm_output[1]) & (fsm_output[0]) &
      (~ (fsm_output[7]));
  assign and_dcpl_376 = and_dcpl_375 & and_dcpl_37 & and_dcpl_217;
  assign and_dcpl_379 = and_dcpl_375 & and_dcpl_43 & and_dcpl_217;
  assign and_dcpl_382 = and_dcpl_375 & nor_33_cse & and_dcpl_217;
  assign and_dcpl_385 = and_dcpl_375 & and_dcpl_43 & and_dcpl_209;
  assign and_dcpl_387 = and_dcpl_375 & and_dcpl_37 & and_dcpl_209;
  assign and_dcpl_390 = and_dcpl_375 & and_dcpl_43 & and_dcpl_178;
  assign and_dcpl_392 = and_dcpl_375 & nor_33_cse & and_dcpl_209;
  assign and_dcpl_395 = and_dcpl_375 & and_dcpl_37 & and_dcpl_171;
  assign and_dcpl_397 = and_dcpl_375 & nor_33_cse & and_dcpl_171;
  assign and_dcpl_399 = and_dcpl_375 & and_dcpl_43 & and_dcpl_171;
  assign and_dcpl_401 = and_dcpl_375 & and_dcpl_37 & and_dcpl_178;
  assign and_dcpl_408 = and_dcpl_227 & nor_33_cse & (fsm_output[6:5]==2'b00);
  assign and_dcpl_411 = and_dcpl_227 & nor_33_cse & (fsm_output[6:5]==2'b10);
  assign and_dcpl_423 = and_dcpl_375 & and_184_cse & and_dcpl_217;
  assign and_dcpl_425 = and_dcpl_375 & and_184_cse & and_dcpl_171;
  assign and_dcpl_428 = nor_33_cse & (fsm_output[6:5]==2'b00);
  assign and_dcpl_431 = (fsm_output[2:1]==2'b10) & and_dcpl_23;
  assign and_dcpl_432 = and_dcpl_431 & and_dcpl_428;
  assign and_dcpl_435 = and_dcpl_431 & nor_33_cse & (fsm_output[6:5]==2'b10);
  assign and_dcpl_439 = (~ (fsm_output[2])) & (fsm_output[1]) & (fsm_output[0]) &
      (fsm_output[7]) & and_dcpl_428;
  assign and_dcpl_449 = and_dcpl_227 & and_dcpl_43 & (fsm_output[6:5]==2'b01);
  assign and_dcpl_455 = and_dcpl_227 & and_dcpl_43 & (fsm_output[6:5]==2'b11);
  assign and_dcpl_461 = and_dcpl_375 & and_184_cse & and_dcpl_209;
  assign and_dcpl_463 = and_dcpl_375 & and_184_cse & and_dcpl_178;
  assign and_494_cse = (fsm_output[2]) & (~ (fsm_output[1])) & (fsm_output[0]) &
      (~ (fsm_output[7])) & ((fsm_output[6:4]!=3'b000));
  assign COMP_LOOP_twiddle_f_or_18_itm = and_dcpl_177 | and_dcpl_194;
  assign COMP_LOOP_twiddle_f_nor_5_itm = ~(and_dcpl_204 | and_dcpl_208 | and_dcpl_214
      | and_dcpl_219);
  assign COMP_LOOP_twiddle_f_or_20_itm = and_dcpl_208 | and_dcpl_214 | and_dcpl_219;
  assign COMP_LOOP_twiddle_f_or_1_itm = and_dcpl_211 | and_dcpl_216 | and_dcpl_221;
  assign VEC_LOOP_or_65_itm = and_dcpl_376 | and_dcpl_379 | and_dcpl_382 | and_dcpl_385
      | and_dcpl_387 | and_dcpl_390 | and_dcpl_392 | and_dcpl_395 | and_dcpl_397
      | and_dcpl_399 | and_dcpl_401;
  assign VEC_LOOP_or_60_itm = and_300_cse | and_316_cse;
  assign VEC_LOOP_or_69_itm = and_dcpl_411 | and_dcpl_425;
  assign VEC_LOOP_or_72_itm = and_dcpl_461 | and_dcpl_463;
  assign VEC_LOOP_nor_12_itm = ~(and_dcpl_461 | and_dcpl_463);
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
      reg_ensig_cgo_1_cse <= 1'b0;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= ~(or_dcpl_76 | or_dcpl_72 | (fsm_output[2:1]!=2'b00));
      reg_vec_rsci_oswt_cse <= ~ mux_50_itm;
      reg_vec_rsci_oswt_1_cse <= and_24_rmff;
      reg_twiddle_rsci_oswt_cse <= and_90_rmff;
      reg_twiddle_rsci_oswt_1_cse <= and_96_rmff;
      reg_complete_rsci_oswt_cse <= and_dcpl_122 & (~ (fsm_output[4])) & and_dcpl_93
          & (fsm_output[2:0]==3'b100) & (~ STAGE_LOOP_acc_itm_4_1);
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_128 & and_dcpl_126 & and_dcpl_22;
      reg_ensig_cgo_cse <= mux_60_rmff;
      reg_ensig_cgo_1_cse <= and_132_rmff;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_14 & and_dcpl_25 & (fsm_output[2:1]==2'b00))
        | STAGE_LOOP_i_3_0_sva_mx0c1) ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b1100, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_47_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      run_ac_sync_tmp_dobj_sva <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (~((~ (fsm_output[7])) | (fsm_output[5]) |
        or_58_cse | (fsm_output[6]) | (~ (fsm_output[0])) | or_dcpl_87)) ) begin
      run_ac_sync_tmp_dobj_sva <= run_rsci_ivld_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_64 ) begin
      STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_itm;
    end
  end
  always @(posedge clk) begin
    if ( mux_101_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_12_4_sva_7_0 <= MUX_v_8_2_2(8'b00000000, (z_out_14[7:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~((~ mux_68_nl) & and_dcpl_3 & (~ (fsm_output[6]))))
        ) begin
      COMP_LOOP_1_twiddle_f_acc_cse_sva <= COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_73_nl | (fsm_output[7])) ) begin
      COMP_LOOP_9_twiddle_f_mul_psp_sva <= MUX_v_9_2_2((z_out_2[8:0]), (z_out_13[8:0]),
          and_dcpl_66);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_cse ) begin
      COMP_LOOP_twiddle_help_1_sva <= MUX_v_32_2_2((twiddle_h_rsci_qa_d_mxwt[31:0]),
          (twiddle_h_rsci_qa_d_mxwt[63:32]), and_dcpl_149);
      COMP_LOOP_twiddle_f_1_sva <= MUX_v_32_2_2((twiddle_rsci_qa_d_mxwt[31:0]), (twiddle_rsci_qa_d_mxwt[63:32]),
          and_dcpl_149);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (((~ mux_tmp_2) & and_dcpl_113) | VEC_LOOP_acc_1_cse_10_sva_mx0c1
        | and_dcpl_39 | and_dcpl_53 | and_dcpl_59 | and_dcpl_63 | and_dcpl_69 | and_dcpl_71
        | and_dcpl_73 | and_dcpl_75) ) begin
      VEC_LOOP_acc_1_cse_10_sva <= MUX_v_12_2_2(12'b000000000000, VEC_LOOP_VEC_LOOP_mux_2_nl,
          VEC_LOOP_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_12_0_1_sva_1 <= 13'b0000000000000;
    end
    else if ( complete_rsci_wen_comp & (~(or_tmp_26 | or_dcpl_87)) ) begin
      VEC_LOOP_j_12_0_1_sva_1 <= z_out_12;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_30 | and_dcpl_39 | and_dcpl_45 | and_dcpl_53
        | and_dcpl_56 | and_dcpl_59 | and_dcpl_61 | and_dcpl_63 | and_dcpl_66 | and_dcpl_69
        | and_dcpl_70 | and_dcpl_71 | and_dcpl_72 | and_dcpl_73 | and_dcpl_74 | and_dcpl_75)
        ) begin
      VEC_LOOP_acc_10_cse_1_sva <= MUX1HOT_v_12_3_2(z_out_6, acc_1_cse_12_1, z_out_3,
          {VEC_LOOP_or_51_nl , VEC_LOOP_or_52_nl , and_dcpl_70});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_dcpl_76 | or_dcpl_72 | or_dcpl_87)) ) begin
      VEC_LOOP_acc_psp_sva <= z_out_13[7:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_89_nl | (fsm_output[7])) ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_93_nl | (fsm_output[7])) ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva <= COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( (~(mux_102_nl | (fsm_output[1]))) & (fsm_output[2]) & (~ (fsm_output[3]))
        & (~ (fsm_output[7])) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_12_psp_sva_10 <= VEC_LOOP_VEC_LOOP_mux_1_rgt[10];
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[2:1]==2'b10) & or_175_cse & (~((fsm_output[3]) | (fsm_output[7])))
        & (~ (fsm_output[0])) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_12_psp_sva_9_0 <= VEC_LOOP_VEC_LOOP_mux_1_rgt[9:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((~((((and_171_cse | (fsm_output[2])) & and_184_cse)
        | (fsm_output[5])) ^ (fsm_output[6]))) | (fsm_output[7])) ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_1_cse ) begin
      COMP_LOOP_twiddle_help_9_sva <= twiddle_h_rsci_qa_d_mxwt[31:0];
      COMP_LOOP_twiddle_f_9_sva <= twiddle_rsci_qa_d_mxwt[31:0];
    end
  end
  assign or_126_nl = (fsm_output[1:0]!=2'b00);
  assign mux_61_nl = MUX_s_1_2_2(mux_tmp_2, and_cse, or_126_nl);
  assign and_178_nl = ((fsm_output[1]) | (fsm_output[0]) | (fsm_output[6]) | (fsm_output[3])
      | (fsm_output[4]) | (fsm_output[5])) & (fsm_output[7]);
  assign mux_47_nl = MUX_s_1_2_2(mux_61_nl, and_178_nl, fsm_output[2]);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_64;
  assign mux_99_nl = MUX_s_1_2_2((~ or_53_cse), or_53_cse, fsm_output[7]);
  assign mux_nl = MUX_s_1_2_2(and_cse, (fsm_output[7]), fsm_output[0]);
  assign mux_100_nl = MUX_s_1_2_2(mux_99_nl, mux_nl, fsm_output[1]);
  assign mux_101_nl = MUX_s_1_2_2(mux_100_nl, (fsm_output[7]), fsm_output[2]);
  assign mux_67_nl = MUX_s_1_2_2(nor_33_cse, and_184_cse, and_171_cse);
  assign mux_68_nl = MUX_s_1_2_2(mux_67_nl, and_184_cse, fsm_output[2]);
  assign mux_19_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), or_58_cse);
  assign or_59_nl = (fsm_output[6]) | mux_19_nl;
  assign mux_72_nl = MUX_s_1_2_2(or_59_nl, or_52_cse, and_171_cse);
  assign mux_15_nl = MUX_s_1_2_2((fsm_output[5]), or_tmp_6, fsm_output[6]);
  assign nor_5_nl = ~((fsm_output[1:0]!=2'b01));
  assign mux_16_nl = MUX_s_1_2_2(or_52_cse, mux_15_nl, nor_5_nl);
  assign mux_73_nl = MUX_s_1_2_2(mux_72_nl, mux_16_nl, fsm_output[2]);
  assign VEC_LOOP_or_nl = and_dcpl_39 | and_dcpl_53 | and_dcpl_59 | and_dcpl_63 |
      and_dcpl_69 | and_dcpl_71 | and_dcpl_73 | and_dcpl_75;
  assign VEC_LOOP_VEC_LOOP_mux_2_nl = MUX_v_12_2_2((VEC_LOOP_j_12_0_1_sva_1[11:0]),
      z_out_3, VEC_LOOP_or_nl);
  assign VEC_LOOP_not_nl = ~ VEC_LOOP_acc_1_cse_10_sva_mx0c1;
  assign VEC_LOOP_or_51_nl = and_dcpl_30 | and_dcpl_61 | and_dcpl_66;
  assign VEC_LOOP_or_52_nl = and_dcpl_39 | and_dcpl_59 | VEC_LOOP_or_53_cse | VEC_LOOP_or_54_cse
      | VEC_LOOP_or_55_cse | VEC_LOOP_or_56_cse | VEC_LOOP_or_57_cse;
  assign mux_87_nl = MUX_s_1_2_2((~ or_175_cse), nor_tmp_12, fsm_output[6]);
  assign mux_88_nl = MUX_s_1_2_2(mux_87_nl, mux_tmp_86, and_171_cse);
  assign mux_89_nl = MUX_s_1_2_2(mux_88_nl, mux_tmp_86, fsm_output[2]);
  assign nor_29_nl = ~(and_184_cse | (fsm_output[5]));
  assign mux_91_nl = MUX_s_1_2_2(nor_29_nl, nor_tmp_3, fsm_output[6]);
  assign mux_92_nl = MUX_s_1_2_2(mux_91_nl, mux_tmp_22, and_171_cse);
  assign mux_93_nl = MUX_s_1_2_2(mux_92_nl, mux_tmp_22, fsm_output[2]);
  assign or_176_nl = (~ (fsm_output[4])) | (fsm_output[0]);
  assign and_514_nl = (fsm_output[4]) & (fsm_output[0]);
  assign mux_102_nl = MUX_s_1_2_2(or_176_nl, and_514_nl, fsm_output[5]);
  assign COMP_LOOP_twiddle_f_or_30_nl = and_dcpl_187 | and_dcpl_189 | and_dcpl_191
      | and_dcpl_197;
  assign COMP_LOOP_twiddle_f_mux1h_164_nl = MUX1HOT_v_12_4_2(({2'b00 , COMP_LOOP_5_twiddle_f_lshift_ncse_sva}),
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1, ({1'b0 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1}),
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva, {COMP_LOOP_twiddle_f_or_18_itm , and_dcpl_181
      , and_dcpl_184 , COMP_LOOP_twiddle_f_or_30_nl});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl = MUX_v_2_2_2((COMP_LOOP_k_12_4_sva_7_0[7:6]),
      ({1'b0 , (COMP_LOOP_k_12_4_sva_7_0[7])}), and_dcpl_184);
  assign COMP_LOOP_twiddle_f_nor_9_nl = ~(and_dcpl_177 | and_dcpl_194);
  assign COMP_LOOP_twiddle_f_and_17_nl = MUX_v_2_2_2(2'b00, COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl,
      COMP_LOOP_twiddle_f_nor_9_nl);
  assign COMP_LOOP_twiddle_f_or_31_nl = and_dcpl_181 | and_dcpl_187 | and_dcpl_189
      | and_dcpl_191 | and_dcpl_197;
  assign COMP_LOOP_twiddle_f_mux1h_165_nl = MUX1HOT_v_6_3_2((COMP_LOOP_k_12_4_sva_7_0[7:2]),
      (COMP_LOOP_k_12_4_sva_7_0[5:0]), (COMP_LOOP_k_12_4_sva_7_0[6:1]), {COMP_LOOP_twiddle_f_or_18_itm
      , COMP_LOOP_twiddle_f_or_31_nl , and_dcpl_184});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_7_nl = MUX_s_1_2_2((COMP_LOOP_k_12_4_sva_7_0[1]),
      (COMP_LOOP_k_12_4_sva_7_0[0]), and_dcpl_184);
  assign COMP_LOOP_twiddle_f_or_32_nl = (COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_7_nl
      & (~(and_dcpl_181 | and_dcpl_187 | and_dcpl_189 | and_dcpl_191))) | and_dcpl_197;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_4_nl = ((COMP_LOOP_k_12_4_sva_7_0[0])
      & (~(and_dcpl_181 | and_dcpl_184 | and_dcpl_187))) | and_dcpl_189 | and_dcpl_191
      | and_dcpl_197;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl = (~(and_dcpl_177 | and_dcpl_181
      | and_dcpl_184 | and_dcpl_189 | and_dcpl_197)) | and_dcpl_187 | and_dcpl_191
      | and_dcpl_194;
  assign nl_z_out_1 = COMP_LOOP_twiddle_f_mux1h_164_nl * ({COMP_LOOP_twiddle_f_and_17_nl
      , COMP_LOOP_twiddle_f_mux1h_165_nl , COMP_LOOP_twiddle_f_or_32_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_4_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl , 1'b1});
  assign z_out_1 = nl_z_out_1[11:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl = (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[11])
      & COMP_LOOP_twiddle_f_nor_5_itm;
  assign COMP_LOOP_twiddle_f_mux1h_166_nl = MUX1HOT_v_11_3_2(({2'b00 , COMP_LOOP_9_twiddle_f_lshift_itm}),
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva, (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[10:0]),
      {and_dcpl_204 , COMP_LOOP_twiddle_f_or_20_itm , COMP_LOOP_twiddle_f_or_1_itm});
  assign COMP_LOOP_twiddle_f_and_20_nl = (COMP_LOOP_k_12_4_sva_7_0[7]) & COMP_LOOP_twiddle_f_nor_5_itm;
  assign COMP_LOOP_twiddle_f_mux1h_167_nl = MUX1HOT_v_7_3_2(({2'b00 , (COMP_LOOP_k_12_4_sva_7_0[7:3])}),
      (COMP_LOOP_k_12_4_sva_7_0[7:1]), (COMP_LOOP_k_12_4_sva_7_0[6:0]), {and_dcpl_204
      , COMP_LOOP_twiddle_f_or_20_itm , COMP_LOOP_twiddle_f_or_1_itm});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_8_nl = MUX_s_1_2_2((COMP_LOOP_k_12_4_sva_7_0[2]),
      (COMP_LOOP_k_12_4_sva_7_0[0]), COMP_LOOP_twiddle_f_or_20_itm);
  assign COMP_LOOP_twiddle_f_or_33_nl = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_8_nl
      | and_dcpl_211 | and_dcpl_216 | and_dcpl_221;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_6_nl = ((COMP_LOOP_k_12_4_sva_7_0[1])
      & (~(and_dcpl_208 | and_dcpl_211 | and_dcpl_216))) | and_dcpl_214 | and_dcpl_219
      | and_dcpl_221;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_7_nl = ((COMP_LOOP_k_12_4_sva_7_0[0])
      & (~(and_dcpl_211 | and_dcpl_214))) | and_dcpl_208 | and_dcpl_216 | and_dcpl_219
      | and_dcpl_221;
  assign nl_z_out_2 = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl , COMP_LOOP_twiddle_f_mux1h_166_nl})
      * ({COMP_LOOP_twiddle_f_and_20_nl , COMP_LOOP_twiddle_f_mux1h_167_nl , COMP_LOOP_twiddle_f_or_33_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_6_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_7_nl
      , 1'b1});
  assign z_out_2 = nl_z_out_2[11:0];
  assign VEC_LOOP_mux_39_nl = MUX_v_12_2_2(VEC_LOOP_acc_1_cse_10_sva, z_out_5, and_dcpl_249);
  assign VEC_LOOP_VEC_LOOP_mux_11_nl = MUX_v_8_2_2(COMP_LOOP_k_12_4_sva_7_0, (VEC_LOOP_acc_1_cse_10_sva[11:4]),
      and_dcpl_249);
  assign VEC_LOOP_VEC_LOOP_or_15_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_290_cse
      | and_296_cse | and_302_cse | and_306_cse))) | and_309_cse | and_313_cse |
      and_318_cse | and_322_cse;
  assign VEC_LOOP_VEC_LOOP_or_16_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_290_cse
      | and_296_cse | and_309_cse | and_313_cse))) | and_302_cse | and_306_cse |
      and_318_cse | and_322_cse;
  assign VEC_LOOP_VEC_LOOP_or_17_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_290_cse
      | and_302_cse | and_309_cse | and_318_cse))) | and_296_cse | and_306_cse |
      and_313_cse | and_322_cse;
  assign VEC_LOOP_VEC_LOOP_or_18_nl = (VEC_LOOP_acc_1_cse_10_sva[0]) | and_290_cse
      | and_296_cse | and_302_cse | and_306_cse | and_309_cse | and_313_cse | and_318_cse
      | and_322_cse;
  assign nl_z_out_3 = VEC_LOOP_mux_39_nl + ({VEC_LOOP_VEC_LOOP_mux_11_nl , VEC_LOOP_VEC_LOOP_or_15_nl
      , VEC_LOOP_VEC_LOOP_or_16_nl , VEC_LOOP_VEC_LOOP_or_17_nl , VEC_LOOP_VEC_LOOP_or_18_nl});
  assign z_out_3 = nl_z_out_3[11:0];
  assign nl_acc_1_cse_12_1 = z_out_5 + VEC_LOOP_acc_1_cse_10_sva;
  assign acc_1_cse_12_1 = nl_acc_1_cse_12_1[11:0];
  assign and_515_nl = and_dcpl_227 & and_dcpl_43 & and_dcpl_171;
  assign and_516_nl = and_dcpl_227 & and_dcpl_43 & and_dcpl_217;
  assign VEC_LOOP_mux1h_32_nl = MUX1HOT_v_4_13_2(4'b0001, 4'b0010, 4'b0011, 4'b0100,
      4'b0101, 4'b0110, 4'b0111, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110,
      {and_290_cse , and_293_cse , and_296_cse , and_300_cse , and_302_cse , and_515_nl
      , and_306_cse , and_309_cse , and_311_cse , and_313_cse , and_316_cse , and_318_cse
      , and_516_nl});
  assign VEC_LOOP_or_76_nl = MUX_v_4_2_2(VEC_LOOP_mux1h_32_nl, 4'b1111, and_322_cse);
  assign nl_z_out_5 = ({COMP_LOOP_k_12_4_sva_7_0 , VEC_LOOP_or_76_nl}) + (STAGE_LOOP_lshift_psp_sva[12:1]);
  assign z_out_5 = nl_z_out_5[11:0];
  assign and_517_nl = (fsm_output[2:1]==2'b10) & and_dcpl_23 & nor_33_cse & and_dcpl_178;
  assign VEC_LOOP_mux1h_33_nl = MUX1HOT_v_9_3_2(({(z_out_14[7:0]) , (STAGE_LOOP_lshift_psp_sva[4])}),
      (z_out_5[11:3]), z_out_14, {and_517_nl , (fsm_output[5]) , (fsm_output[6])});
  assign VEC_LOOP_VEC_LOOP_mux_12_nl = MUX_v_3_2_2((STAGE_LOOP_lshift_psp_sva[3:1]),
      (z_out_5[2:0]), fsm_output[5]);
  assign nl_z_out_6 = ({VEC_LOOP_mux1h_33_nl , VEC_LOOP_VEC_LOOP_mux_12_nl}) + VEC_LOOP_acc_1_cse_10_sva;
  assign z_out_6 = nl_z_out_6[11:0];
  assign VEC_LOOP_VEC_LOOP_or_19_nl = (STAGE_LOOP_lshift_psp_sva[12]) | and_dcpl_376
      | and_dcpl_379 | and_dcpl_382 | and_dcpl_385 | and_dcpl_387 | and_dcpl_390
      | and_dcpl_392 | and_dcpl_395 | and_dcpl_397 | and_dcpl_399 | and_dcpl_401;
  assign VEC_LOOP_VEC_LOOP_mux_13_nl = MUX_v_12_2_2((STAGE_LOOP_lshift_psp_sva[11:0]),
      (~ (STAGE_LOOP_lshift_psp_sva[12:1])), VEC_LOOP_or_65_itm);
  assign VEC_LOOP_or_77_nl = (~ (fsm_output[2])) | (fsm_output[1]) | (fsm_output[0])
      | (fsm_output[7]) | and_dcpl_376 | and_dcpl_379 | and_dcpl_382 | and_dcpl_385
      | and_dcpl_387 | and_dcpl_390 | and_dcpl_392 | and_dcpl_395 | and_dcpl_397
      | and_dcpl_399 | and_dcpl_401;
  assign VEC_LOOP_VEC_LOOP_mux_14_nl = MUX_v_8_2_2((VEC_LOOP_acc_1_cse_10_sva[11:4]),
      COMP_LOOP_k_12_4_sva_7_0, VEC_LOOP_or_65_itm);
  assign VEC_LOOP_VEC_LOOP_or_20_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_dcpl_390
      | and_dcpl_395 | and_dcpl_397 | and_dcpl_399 | and_dcpl_401))) | and_dcpl_376
      | and_dcpl_379 | and_dcpl_382 | and_dcpl_385 | and_dcpl_387 | and_dcpl_392;
  assign VEC_LOOP_VEC_LOOP_or_21_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_dcpl_385
      | and_dcpl_387 | and_dcpl_390 | and_dcpl_392 | and_dcpl_401))) | and_dcpl_376
      | and_dcpl_379 | and_dcpl_382 | and_dcpl_395 | and_dcpl_397 | and_dcpl_399;
  assign VEC_LOOP_VEC_LOOP_or_22_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_dcpl_376
      | and_dcpl_382 | and_dcpl_387 | and_dcpl_392 | and_dcpl_395 | and_dcpl_397
      | and_dcpl_401))) | and_dcpl_379 | and_dcpl_385 | and_dcpl_390 | and_dcpl_399;
  assign VEC_LOOP_VEC_LOOP_or_23_nl = ((VEC_LOOP_acc_1_cse_10_sva[0]) & (~(and_dcpl_379
      | and_dcpl_382 | and_dcpl_385 | and_dcpl_390 | and_dcpl_392 | and_dcpl_397
      | and_dcpl_399))) | and_dcpl_376 | and_dcpl_387 | and_dcpl_395 | and_dcpl_401;
  assign nl_acc_9_nl = ({VEC_LOOP_VEC_LOOP_or_19_nl , VEC_LOOP_VEC_LOOP_mux_13_nl
      , VEC_LOOP_or_77_nl}) + conv_u2u_13_14({VEC_LOOP_VEC_LOOP_mux_14_nl , VEC_LOOP_VEC_LOOP_or_20_nl
      , VEC_LOOP_VEC_LOOP_or_21_nl , VEC_LOOP_VEC_LOOP_or_22_nl , VEC_LOOP_VEC_LOOP_or_23_nl
      , 1'b1});
  assign acc_9_nl = nl_acc_9_nl[13:0];
  assign z_out_12 = readslicef_14_13_1(acc_9_nl);
  assign VEC_LOOP_mux1h_34_nl = MUX1HOT_v_10_5_2(({2'b00 , (VEC_LOOP_acc_1_cse_10_sva[11:4])}),
      ({1'b0 , (VEC_LOOP_acc_1_cse_10_sva[11:3])}), (VEC_LOOP_acc_1_cse_10_sva[11:2]),
      ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[12:5]))}), ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[12:4]))}),
      {and_dcpl_408 , and_dcpl_411 , VEC_LOOP_or_60_itm , and_dcpl_423 , and_dcpl_425});
  assign VEC_LOOP_or_78_nl = (~(and_dcpl_408 | and_dcpl_411 | and_300_cse | and_316_cse))
      | and_dcpl_423 | and_dcpl_425;
  assign VEC_LOOP_VEC_LOOP_and_2_nl = (COMP_LOOP_k_12_4_sva_7_0[7]) & (~(and_dcpl_408
      | and_dcpl_411 | and_dcpl_423 | and_dcpl_425));
  assign VEC_LOOP_VEC_LOOP_mux_15_nl = MUX_s_1_2_2((COMP_LOOP_k_12_4_sva_7_0[7]),
      (COMP_LOOP_k_12_4_sva_7_0[6]), VEC_LOOP_or_60_itm);
  assign VEC_LOOP_and_24_nl = VEC_LOOP_VEC_LOOP_mux_15_nl & (~(and_dcpl_408 | and_dcpl_423));
  assign VEC_LOOP_or_79_nl = and_dcpl_408 | and_dcpl_423;
  assign VEC_LOOP_mux1h_35_nl = MUX1HOT_v_6_3_2((COMP_LOOP_k_12_4_sva_7_0[7:2]),
      (COMP_LOOP_k_12_4_sva_7_0[6:1]), (COMP_LOOP_k_12_4_sva_7_0[5:0]), {VEC_LOOP_or_79_nl
      , VEC_LOOP_or_69_itm , VEC_LOOP_or_60_itm});
  assign VEC_LOOP_mux_40_nl = MUX_s_1_2_2((COMP_LOOP_k_12_4_sva_7_0[1]), (COMP_LOOP_k_12_4_sva_7_0[0]),
      VEC_LOOP_or_69_itm);
  assign VEC_LOOP_VEC_LOOP_or_24_nl = (VEC_LOOP_mux_40_nl & (~ and_300_cse)) | and_316_cse;
  assign VEC_LOOP_VEC_LOOP_or_25_nl = ((COMP_LOOP_k_12_4_sva_7_0[0]) & (~ and_dcpl_425))
      | and_dcpl_411 | and_300_cse | and_316_cse;
  assign nl_acc_10_nl = ({VEC_LOOP_mux1h_34_nl , VEC_LOOP_or_78_nl}) + ({VEC_LOOP_VEC_LOOP_and_2_nl
      , VEC_LOOP_and_24_nl , VEC_LOOP_mux1h_35_nl , VEC_LOOP_VEC_LOOP_or_24_nl ,
      VEC_LOOP_VEC_LOOP_or_25_nl , 1'b1});
  assign acc_10_nl = nl_acc_10_nl[10:0];
  assign z_out_13 = readslicef_11_10_1(acc_10_nl);
  assign VEC_LOOP_VEC_LOOP_and_3_nl = (COMP_LOOP_k_12_4_sva_7_0[7]) & (~(and_dcpl_432
      | and_dcpl_439));
  assign VEC_LOOP_VEC_LOOP_mux_16_nl = MUX_v_8_2_2(COMP_LOOP_k_12_4_sva_7_0, ({(COMP_LOOP_k_12_4_sva_7_0[6:0])
      , 1'b1}), and_dcpl_435);
  assign VEC_LOOP_mux1h_36_nl = MUX1HOT_v_9_3_2(({1'b0 , (STAGE_LOOP_lshift_psp_sva[12:5])}),
      (STAGE_LOOP_lshift_psp_sva[12:4]), 9'b000000001, {and_dcpl_432 , and_dcpl_435
      , and_dcpl_439});
  assign nl_z_out_14 = ({VEC_LOOP_VEC_LOOP_and_3_nl , VEC_LOOP_VEC_LOOP_mux_16_nl})
      + VEC_LOOP_mux1h_36_nl;
  assign z_out_14 = nl_z_out_14[8:0];
  assign VEC_LOOP_VEC_LOOP_or_26_nl = (VEC_LOOP_acc_1_cse_10_sva[11]) | and_dcpl_461
      | and_dcpl_463;
  assign VEC_LOOP_VEC_LOOP_mux_17_nl = MUX_v_10_2_2((VEC_LOOP_acc_1_cse_10_sva[10:1]),
      (~ (STAGE_LOOP_lshift_psp_sva[12:3])), VEC_LOOP_or_72_itm);
  assign VEC_LOOP_or_80_nl = (~(and_293_cse | and_dcpl_449 | and_311_cse | and_dcpl_455))
      | and_dcpl_461 | and_dcpl_463;
  assign VEC_LOOP_and_27_nl = (COMP_LOOP_k_12_4_sva_7_0[7]) & VEC_LOOP_nor_12_itm;
  assign VEC_LOOP_VEC_LOOP_mux_18_nl = MUX_v_7_2_2((COMP_LOOP_k_12_4_sva_7_0[6:0]),
      (COMP_LOOP_k_12_4_sva_7_0[7:1]), VEC_LOOP_or_72_itm);
  assign VEC_LOOP_VEC_LOOP_or_27_nl = ((COMP_LOOP_k_12_4_sva_7_0[0]) & (~(and_293_cse
      | and_dcpl_449))) | and_311_cse | and_dcpl_455;
  assign VEC_LOOP_VEC_LOOP_or_28_nl = (~(and_293_cse | and_311_cse | and_dcpl_463))
      | and_dcpl_449 | and_dcpl_455 | and_dcpl_461;
  assign VEC_LOOP_VEC_LOOP_or_29_nl = VEC_LOOP_nor_12_itm | and_293_cse | and_dcpl_449
      | and_311_cse | and_dcpl_455;
  assign nl_acc_12_nl = ({VEC_LOOP_VEC_LOOP_or_26_nl , VEC_LOOP_VEC_LOOP_mux_17_nl
      , VEC_LOOP_or_80_nl}) + ({VEC_LOOP_and_27_nl , VEC_LOOP_VEC_LOOP_mux_18_nl
      , VEC_LOOP_VEC_LOOP_or_27_nl , VEC_LOOP_VEC_LOOP_or_28_nl , VEC_LOOP_VEC_LOOP_or_29_nl
      , 1'b1});
  assign acc_12_nl = nl_acc_12_nl[11:0];
  assign z_out_15 = readslicef_12_11_1(acc_12_nl);
  assign VEC_LOOP_mux_41_cse = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
      and_494_cse);

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


  function automatic [10:0] MUX1HOT_v_11_3_2;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [2:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | ( input_1 & {11{sel[1]}});
    result = result | ( input_2 & {11{sel[2]}});
    MUX1HOT_v_11_3_2 = result;
  end
  endfunction


  function automatic [11:0] MUX1HOT_v_12_3_2;
    input [11:0] input_2;
    input [11:0] input_1;
    input [11:0] input_0;
    input [2:0] sel;
    reg [11:0] result;
  begin
    result = input_0 & {12{sel[0]}};
    result = result | ( input_1 & {12{sel[1]}});
    result = result | ( input_2 & {12{sel[2]}});
    MUX1HOT_v_12_3_2 = result;
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


  function automatic [7:0] MUX1HOT_v_8_10_2;
    input [7:0] input_9;
    input [7:0] input_8;
    input [7:0] input_7;
    input [7:0] input_6;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [9:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    result = result | ( input_3 & {8{sel[3]}});
    result = result | ( input_4 & {8{sel[4]}});
    result = result | ( input_5 & {8{sel[5]}});
    result = result | ( input_6 & {8{sel[6]}});
    result = result | ( input_7 & {8{sel[7]}});
    result = result | ( input_8 & {8{sel[8]}});
    result = result | ( input_9 & {8{sel[9]}});
    MUX1HOT_v_8_10_2 = result;
  end
  endfunction


  function automatic [7:0] MUX1HOT_v_8_7_2;
    input [7:0] input_6;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [6:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    result = result | ( input_3 & {8{sel[3]}});
    result = result | ( input_4 & {8{sel[4]}});
    result = result | ( input_5 & {8{sel[5]}});
    result = result | ( input_6 & {8{sel[6]}});
    MUX1HOT_v_8_7_2 = result;
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


  function automatic [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
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


  function automatic [0:0] readslicef_13_1_12;
    input [12:0] vector;
    reg [12:0] tmp;
  begin
    tmp = vector >> 12;
    readslicef_13_1_12 = tmp[0:0];
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


  function automatic [13:0] conv_u2u_13_14 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_14 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp (
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
  output [11:0] vec_rsc_adra;
  output [31:0] vec_rsc_da;
  output vec_rsc_wea;
  input [31:0] vec_rsc_qa;
  output [11:0] vec_rsc_adrb;
  output [31:0] vec_rsc_db;
  output vec_rsc_web;
  input [31:0] vec_rsc_qb;
  output vec_rsc_triosy_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [31:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [11:0] twiddle_rsc_adra;
  output [31:0] twiddle_rsc_da;
  output twiddle_rsc_wea;
  input [31:0] twiddle_rsc_qa;
  output [11:0] twiddle_rsc_adrb;
  output [31:0] twiddle_rsc_db;
  output twiddle_rsc_web;
  input [31:0] twiddle_rsc_qb;
  output twiddle_rsc_triosy_lz;
  output [11:0] twiddle_h_rsc_adra;
  output [31:0] twiddle_h_rsc_da;
  output twiddle_h_rsc_wea;
  input [31:0] twiddle_h_rsc_qa;
  output [11:0] twiddle_h_rsc_adrb;
  output [31:0] twiddle_h_rsc_db;
  output twiddle_h_rsc_web;
  input [31:0] twiddle_h_rsc_qb;
  output twiddle_h_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;


  // Interconnect Declarations
  wire [23:0] vec_rsci_adra_d;
  wire [31:0] vec_rsci_da_d;
  wire [63:0] vec_rsci_qa_d;
  wire [1:0] vec_rsci_wea_d;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [23:0] twiddle_rsci_adra_d;
  wire [63:0] twiddle_rsci_qa_d;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [23:0] twiddle_h_rsci_adra_d;
  wire [63:0] twiddle_h_rsci_qa_d;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations for Component Instantiations 
  wire [63:0] nl_vec_rsci_da_d;
  assign nl_vec_rsci_da_d = {32'b00000000000000000000000000000000 , vec_rsci_da_d};
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_12_32_4096_4096_32_1_gen
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
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_16_12_32_4096_4096_32_1_gen
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
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_17_12_32_4096_4096_32_1_gen
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
  inPlaceNTT_DIF_precomp_core inPlaceNTT_DIF_precomp_core_inst (
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



