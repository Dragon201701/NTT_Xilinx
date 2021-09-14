
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

//------> ../td_ccore_solutions/mult_a1e233277d0d5c0cfe721a9995382bef70e4_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:49:27 2021
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




//------> ../td_ccore_solutions/modulo_sub_221cc38820a0941d4772a0cf032267436375_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:49:28 2021
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




//------> ../td_ccore_solutions/modulo_add_8b3f96d27942dd35d77cd1e313d6ead560ec_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:49:29 2021
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
//  Generated date: Mon Sep 13 22:25:05 2021
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
      COMP_LOOP_C_3_tr0, COMP_LOOP_2_VEC_LOOP_C_6_tr0, COMP_LOOP_C_4_tr0, COMP_LOOP_3_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_5_tr0, COMP_LOOP_4_VEC_LOOP_C_6_tr0, COMP_LOOP_C_6_tr0, COMP_LOOP_5_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_7_tr0, COMP_LOOP_6_VEC_LOOP_C_6_tr0, COMP_LOOP_C_8_tr0, COMP_LOOP_7_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_9_tr0, COMP_LOOP_8_VEC_LOOP_C_6_tr0, COMP_LOOP_C_10_tr0, COMP_LOOP_9_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_11_tr0, COMP_LOOP_10_VEC_LOOP_C_6_tr0, COMP_LOOP_C_12_tr0, COMP_LOOP_11_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_13_tr0, COMP_LOOP_12_VEC_LOOP_C_6_tr0, COMP_LOOP_C_14_tr0, COMP_LOOP_13_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_15_tr0, COMP_LOOP_14_VEC_LOOP_C_6_tr0, COMP_LOOP_C_16_tr0, COMP_LOOP_15_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_17_tr0, COMP_LOOP_16_VEC_LOOP_C_6_tr0, COMP_LOOP_C_18_tr0, COMP_LOOP_17_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_19_tr0, COMP_LOOP_18_VEC_LOOP_C_6_tr0, COMP_LOOP_C_20_tr0, COMP_LOOP_19_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_21_tr0, COMP_LOOP_20_VEC_LOOP_C_6_tr0, COMP_LOOP_C_22_tr0, COMP_LOOP_21_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_23_tr0, COMP_LOOP_22_VEC_LOOP_C_6_tr0, COMP_LOOP_C_24_tr0, COMP_LOOP_23_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_25_tr0, COMP_LOOP_24_VEC_LOOP_C_6_tr0, COMP_LOOP_C_26_tr0, COMP_LOOP_25_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_27_tr0, COMP_LOOP_26_VEC_LOOP_C_6_tr0, COMP_LOOP_C_28_tr0, COMP_LOOP_27_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_29_tr0, COMP_LOOP_28_VEC_LOOP_C_6_tr0, COMP_LOOP_C_30_tr0, COMP_LOOP_29_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_31_tr0, COMP_LOOP_30_VEC_LOOP_C_6_tr0, COMP_LOOP_C_32_tr0, COMP_LOOP_31_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_33_tr0, COMP_LOOP_32_VEC_LOOP_C_6_tr0, COMP_LOOP_C_34_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
  input main_C_0_tr0;
  input COMP_LOOP_1_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_3_tr0;
  input COMP_LOOP_2_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_4_tr0;
  input COMP_LOOP_3_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_5_tr0;
  input COMP_LOOP_4_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_6_tr0;
  input COMP_LOOP_5_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_7_tr0;
  input COMP_LOOP_6_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_8_tr0;
  input COMP_LOOP_7_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_9_tr0;
  input COMP_LOOP_8_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_10_tr0;
  input COMP_LOOP_9_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_11_tr0;
  input COMP_LOOP_10_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_12_tr0;
  input COMP_LOOP_11_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_13_tr0;
  input COMP_LOOP_12_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_14_tr0;
  input COMP_LOOP_13_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_15_tr0;
  input COMP_LOOP_14_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_16_tr0;
  input COMP_LOOP_15_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_17_tr0;
  input COMP_LOOP_16_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_18_tr0;
  input COMP_LOOP_17_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_19_tr0;
  input COMP_LOOP_18_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_20_tr0;
  input COMP_LOOP_19_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_21_tr0;
  input COMP_LOOP_20_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_22_tr0;
  input COMP_LOOP_21_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_23_tr0;
  input COMP_LOOP_22_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_24_tr0;
  input COMP_LOOP_23_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_25_tr0;
  input COMP_LOOP_24_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_26_tr0;
  input COMP_LOOP_25_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_27_tr0;
  input COMP_LOOP_26_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_28_tr0;
  input COMP_LOOP_27_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_29_tr0;
  input COMP_LOOP_28_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_30_tr0;
  input COMP_LOOP_29_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_31_tr0;
  input COMP_LOOP_30_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_32_tr0;
  input COMP_LOOP_31_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_33_tr0;
  input COMP_LOOP_32_VEC_LOOP_C_6_tr0;
  input COMP_LOOP_C_34_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIF_precomp_core_core_fsm_1
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
    COMP_LOOP_C_3 = 9'd12,
    COMP_LOOP_2_VEC_LOOP_C_0 = 9'd13,
    COMP_LOOP_2_VEC_LOOP_C_1 = 9'd14,
    COMP_LOOP_2_VEC_LOOP_C_2 = 9'd15,
    COMP_LOOP_2_VEC_LOOP_C_3 = 9'd16,
    COMP_LOOP_2_VEC_LOOP_C_4 = 9'd17,
    COMP_LOOP_2_VEC_LOOP_C_5 = 9'd18,
    COMP_LOOP_2_VEC_LOOP_C_6 = 9'd19,
    COMP_LOOP_C_4 = 9'd20,
    COMP_LOOP_3_VEC_LOOP_C_0 = 9'd21,
    COMP_LOOP_3_VEC_LOOP_C_1 = 9'd22,
    COMP_LOOP_3_VEC_LOOP_C_2 = 9'd23,
    COMP_LOOP_3_VEC_LOOP_C_3 = 9'd24,
    COMP_LOOP_3_VEC_LOOP_C_4 = 9'd25,
    COMP_LOOP_3_VEC_LOOP_C_5 = 9'd26,
    COMP_LOOP_3_VEC_LOOP_C_6 = 9'd27,
    COMP_LOOP_C_5 = 9'd28,
    COMP_LOOP_4_VEC_LOOP_C_0 = 9'd29,
    COMP_LOOP_4_VEC_LOOP_C_1 = 9'd30,
    COMP_LOOP_4_VEC_LOOP_C_2 = 9'd31,
    COMP_LOOP_4_VEC_LOOP_C_3 = 9'd32,
    COMP_LOOP_4_VEC_LOOP_C_4 = 9'd33,
    COMP_LOOP_4_VEC_LOOP_C_5 = 9'd34,
    COMP_LOOP_4_VEC_LOOP_C_6 = 9'd35,
    COMP_LOOP_C_6 = 9'd36,
    COMP_LOOP_5_VEC_LOOP_C_0 = 9'd37,
    COMP_LOOP_5_VEC_LOOP_C_1 = 9'd38,
    COMP_LOOP_5_VEC_LOOP_C_2 = 9'd39,
    COMP_LOOP_5_VEC_LOOP_C_3 = 9'd40,
    COMP_LOOP_5_VEC_LOOP_C_4 = 9'd41,
    COMP_LOOP_5_VEC_LOOP_C_5 = 9'd42,
    COMP_LOOP_5_VEC_LOOP_C_6 = 9'd43,
    COMP_LOOP_C_7 = 9'd44,
    COMP_LOOP_6_VEC_LOOP_C_0 = 9'd45,
    COMP_LOOP_6_VEC_LOOP_C_1 = 9'd46,
    COMP_LOOP_6_VEC_LOOP_C_2 = 9'd47,
    COMP_LOOP_6_VEC_LOOP_C_3 = 9'd48,
    COMP_LOOP_6_VEC_LOOP_C_4 = 9'd49,
    COMP_LOOP_6_VEC_LOOP_C_5 = 9'd50,
    COMP_LOOP_6_VEC_LOOP_C_6 = 9'd51,
    COMP_LOOP_C_8 = 9'd52,
    COMP_LOOP_7_VEC_LOOP_C_0 = 9'd53,
    COMP_LOOP_7_VEC_LOOP_C_1 = 9'd54,
    COMP_LOOP_7_VEC_LOOP_C_2 = 9'd55,
    COMP_LOOP_7_VEC_LOOP_C_3 = 9'd56,
    COMP_LOOP_7_VEC_LOOP_C_4 = 9'd57,
    COMP_LOOP_7_VEC_LOOP_C_5 = 9'd58,
    COMP_LOOP_7_VEC_LOOP_C_6 = 9'd59,
    COMP_LOOP_C_9 = 9'd60,
    COMP_LOOP_8_VEC_LOOP_C_0 = 9'd61,
    COMP_LOOP_8_VEC_LOOP_C_1 = 9'd62,
    COMP_LOOP_8_VEC_LOOP_C_2 = 9'd63,
    COMP_LOOP_8_VEC_LOOP_C_3 = 9'd64,
    COMP_LOOP_8_VEC_LOOP_C_4 = 9'd65,
    COMP_LOOP_8_VEC_LOOP_C_5 = 9'd66,
    COMP_LOOP_8_VEC_LOOP_C_6 = 9'd67,
    COMP_LOOP_C_10 = 9'd68,
    COMP_LOOP_9_VEC_LOOP_C_0 = 9'd69,
    COMP_LOOP_9_VEC_LOOP_C_1 = 9'd70,
    COMP_LOOP_9_VEC_LOOP_C_2 = 9'd71,
    COMP_LOOP_9_VEC_LOOP_C_3 = 9'd72,
    COMP_LOOP_9_VEC_LOOP_C_4 = 9'd73,
    COMP_LOOP_9_VEC_LOOP_C_5 = 9'd74,
    COMP_LOOP_9_VEC_LOOP_C_6 = 9'd75,
    COMP_LOOP_C_11 = 9'd76,
    COMP_LOOP_10_VEC_LOOP_C_0 = 9'd77,
    COMP_LOOP_10_VEC_LOOP_C_1 = 9'd78,
    COMP_LOOP_10_VEC_LOOP_C_2 = 9'd79,
    COMP_LOOP_10_VEC_LOOP_C_3 = 9'd80,
    COMP_LOOP_10_VEC_LOOP_C_4 = 9'd81,
    COMP_LOOP_10_VEC_LOOP_C_5 = 9'd82,
    COMP_LOOP_10_VEC_LOOP_C_6 = 9'd83,
    COMP_LOOP_C_12 = 9'd84,
    COMP_LOOP_11_VEC_LOOP_C_0 = 9'd85,
    COMP_LOOP_11_VEC_LOOP_C_1 = 9'd86,
    COMP_LOOP_11_VEC_LOOP_C_2 = 9'd87,
    COMP_LOOP_11_VEC_LOOP_C_3 = 9'd88,
    COMP_LOOP_11_VEC_LOOP_C_4 = 9'd89,
    COMP_LOOP_11_VEC_LOOP_C_5 = 9'd90,
    COMP_LOOP_11_VEC_LOOP_C_6 = 9'd91,
    COMP_LOOP_C_13 = 9'd92,
    COMP_LOOP_12_VEC_LOOP_C_0 = 9'd93,
    COMP_LOOP_12_VEC_LOOP_C_1 = 9'd94,
    COMP_LOOP_12_VEC_LOOP_C_2 = 9'd95,
    COMP_LOOP_12_VEC_LOOP_C_3 = 9'd96,
    COMP_LOOP_12_VEC_LOOP_C_4 = 9'd97,
    COMP_LOOP_12_VEC_LOOP_C_5 = 9'd98,
    COMP_LOOP_12_VEC_LOOP_C_6 = 9'd99,
    COMP_LOOP_C_14 = 9'd100,
    COMP_LOOP_13_VEC_LOOP_C_0 = 9'd101,
    COMP_LOOP_13_VEC_LOOP_C_1 = 9'd102,
    COMP_LOOP_13_VEC_LOOP_C_2 = 9'd103,
    COMP_LOOP_13_VEC_LOOP_C_3 = 9'd104,
    COMP_LOOP_13_VEC_LOOP_C_4 = 9'd105,
    COMP_LOOP_13_VEC_LOOP_C_5 = 9'd106,
    COMP_LOOP_13_VEC_LOOP_C_6 = 9'd107,
    COMP_LOOP_C_15 = 9'd108,
    COMP_LOOP_14_VEC_LOOP_C_0 = 9'd109,
    COMP_LOOP_14_VEC_LOOP_C_1 = 9'd110,
    COMP_LOOP_14_VEC_LOOP_C_2 = 9'd111,
    COMP_LOOP_14_VEC_LOOP_C_3 = 9'd112,
    COMP_LOOP_14_VEC_LOOP_C_4 = 9'd113,
    COMP_LOOP_14_VEC_LOOP_C_5 = 9'd114,
    COMP_LOOP_14_VEC_LOOP_C_6 = 9'd115,
    COMP_LOOP_C_16 = 9'd116,
    COMP_LOOP_15_VEC_LOOP_C_0 = 9'd117,
    COMP_LOOP_15_VEC_LOOP_C_1 = 9'd118,
    COMP_LOOP_15_VEC_LOOP_C_2 = 9'd119,
    COMP_LOOP_15_VEC_LOOP_C_3 = 9'd120,
    COMP_LOOP_15_VEC_LOOP_C_4 = 9'd121,
    COMP_LOOP_15_VEC_LOOP_C_5 = 9'd122,
    COMP_LOOP_15_VEC_LOOP_C_6 = 9'd123,
    COMP_LOOP_C_17 = 9'd124,
    COMP_LOOP_16_VEC_LOOP_C_0 = 9'd125,
    COMP_LOOP_16_VEC_LOOP_C_1 = 9'd126,
    COMP_LOOP_16_VEC_LOOP_C_2 = 9'd127,
    COMP_LOOP_16_VEC_LOOP_C_3 = 9'd128,
    COMP_LOOP_16_VEC_LOOP_C_4 = 9'd129,
    COMP_LOOP_16_VEC_LOOP_C_5 = 9'd130,
    COMP_LOOP_16_VEC_LOOP_C_6 = 9'd131,
    COMP_LOOP_C_18 = 9'd132,
    COMP_LOOP_17_VEC_LOOP_C_0 = 9'd133,
    COMP_LOOP_17_VEC_LOOP_C_1 = 9'd134,
    COMP_LOOP_17_VEC_LOOP_C_2 = 9'd135,
    COMP_LOOP_17_VEC_LOOP_C_3 = 9'd136,
    COMP_LOOP_17_VEC_LOOP_C_4 = 9'd137,
    COMP_LOOP_17_VEC_LOOP_C_5 = 9'd138,
    COMP_LOOP_17_VEC_LOOP_C_6 = 9'd139,
    COMP_LOOP_C_19 = 9'd140,
    COMP_LOOP_18_VEC_LOOP_C_0 = 9'd141,
    COMP_LOOP_18_VEC_LOOP_C_1 = 9'd142,
    COMP_LOOP_18_VEC_LOOP_C_2 = 9'd143,
    COMP_LOOP_18_VEC_LOOP_C_3 = 9'd144,
    COMP_LOOP_18_VEC_LOOP_C_4 = 9'd145,
    COMP_LOOP_18_VEC_LOOP_C_5 = 9'd146,
    COMP_LOOP_18_VEC_LOOP_C_6 = 9'd147,
    COMP_LOOP_C_20 = 9'd148,
    COMP_LOOP_19_VEC_LOOP_C_0 = 9'd149,
    COMP_LOOP_19_VEC_LOOP_C_1 = 9'd150,
    COMP_LOOP_19_VEC_LOOP_C_2 = 9'd151,
    COMP_LOOP_19_VEC_LOOP_C_3 = 9'd152,
    COMP_LOOP_19_VEC_LOOP_C_4 = 9'd153,
    COMP_LOOP_19_VEC_LOOP_C_5 = 9'd154,
    COMP_LOOP_19_VEC_LOOP_C_6 = 9'd155,
    COMP_LOOP_C_21 = 9'd156,
    COMP_LOOP_20_VEC_LOOP_C_0 = 9'd157,
    COMP_LOOP_20_VEC_LOOP_C_1 = 9'd158,
    COMP_LOOP_20_VEC_LOOP_C_2 = 9'd159,
    COMP_LOOP_20_VEC_LOOP_C_3 = 9'd160,
    COMP_LOOP_20_VEC_LOOP_C_4 = 9'd161,
    COMP_LOOP_20_VEC_LOOP_C_5 = 9'd162,
    COMP_LOOP_20_VEC_LOOP_C_6 = 9'd163,
    COMP_LOOP_C_22 = 9'd164,
    COMP_LOOP_21_VEC_LOOP_C_0 = 9'd165,
    COMP_LOOP_21_VEC_LOOP_C_1 = 9'd166,
    COMP_LOOP_21_VEC_LOOP_C_2 = 9'd167,
    COMP_LOOP_21_VEC_LOOP_C_3 = 9'd168,
    COMP_LOOP_21_VEC_LOOP_C_4 = 9'd169,
    COMP_LOOP_21_VEC_LOOP_C_5 = 9'd170,
    COMP_LOOP_21_VEC_LOOP_C_6 = 9'd171,
    COMP_LOOP_C_23 = 9'd172,
    COMP_LOOP_22_VEC_LOOP_C_0 = 9'd173,
    COMP_LOOP_22_VEC_LOOP_C_1 = 9'd174,
    COMP_LOOP_22_VEC_LOOP_C_2 = 9'd175,
    COMP_LOOP_22_VEC_LOOP_C_3 = 9'd176,
    COMP_LOOP_22_VEC_LOOP_C_4 = 9'd177,
    COMP_LOOP_22_VEC_LOOP_C_5 = 9'd178,
    COMP_LOOP_22_VEC_LOOP_C_6 = 9'd179,
    COMP_LOOP_C_24 = 9'd180,
    COMP_LOOP_23_VEC_LOOP_C_0 = 9'd181,
    COMP_LOOP_23_VEC_LOOP_C_1 = 9'd182,
    COMP_LOOP_23_VEC_LOOP_C_2 = 9'd183,
    COMP_LOOP_23_VEC_LOOP_C_3 = 9'd184,
    COMP_LOOP_23_VEC_LOOP_C_4 = 9'd185,
    COMP_LOOP_23_VEC_LOOP_C_5 = 9'd186,
    COMP_LOOP_23_VEC_LOOP_C_6 = 9'd187,
    COMP_LOOP_C_25 = 9'd188,
    COMP_LOOP_24_VEC_LOOP_C_0 = 9'd189,
    COMP_LOOP_24_VEC_LOOP_C_1 = 9'd190,
    COMP_LOOP_24_VEC_LOOP_C_2 = 9'd191,
    COMP_LOOP_24_VEC_LOOP_C_3 = 9'd192,
    COMP_LOOP_24_VEC_LOOP_C_4 = 9'd193,
    COMP_LOOP_24_VEC_LOOP_C_5 = 9'd194,
    COMP_LOOP_24_VEC_LOOP_C_6 = 9'd195,
    COMP_LOOP_C_26 = 9'd196,
    COMP_LOOP_25_VEC_LOOP_C_0 = 9'd197,
    COMP_LOOP_25_VEC_LOOP_C_1 = 9'd198,
    COMP_LOOP_25_VEC_LOOP_C_2 = 9'd199,
    COMP_LOOP_25_VEC_LOOP_C_3 = 9'd200,
    COMP_LOOP_25_VEC_LOOP_C_4 = 9'd201,
    COMP_LOOP_25_VEC_LOOP_C_5 = 9'd202,
    COMP_LOOP_25_VEC_LOOP_C_6 = 9'd203,
    COMP_LOOP_C_27 = 9'd204,
    COMP_LOOP_26_VEC_LOOP_C_0 = 9'd205,
    COMP_LOOP_26_VEC_LOOP_C_1 = 9'd206,
    COMP_LOOP_26_VEC_LOOP_C_2 = 9'd207,
    COMP_LOOP_26_VEC_LOOP_C_3 = 9'd208,
    COMP_LOOP_26_VEC_LOOP_C_4 = 9'd209,
    COMP_LOOP_26_VEC_LOOP_C_5 = 9'd210,
    COMP_LOOP_26_VEC_LOOP_C_6 = 9'd211,
    COMP_LOOP_C_28 = 9'd212,
    COMP_LOOP_27_VEC_LOOP_C_0 = 9'd213,
    COMP_LOOP_27_VEC_LOOP_C_1 = 9'd214,
    COMP_LOOP_27_VEC_LOOP_C_2 = 9'd215,
    COMP_LOOP_27_VEC_LOOP_C_3 = 9'd216,
    COMP_LOOP_27_VEC_LOOP_C_4 = 9'd217,
    COMP_LOOP_27_VEC_LOOP_C_5 = 9'd218,
    COMP_LOOP_27_VEC_LOOP_C_6 = 9'd219,
    COMP_LOOP_C_29 = 9'd220,
    COMP_LOOP_28_VEC_LOOP_C_0 = 9'd221,
    COMP_LOOP_28_VEC_LOOP_C_1 = 9'd222,
    COMP_LOOP_28_VEC_LOOP_C_2 = 9'd223,
    COMP_LOOP_28_VEC_LOOP_C_3 = 9'd224,
    COMP_LOOP_28_VEC_LOOP_C_4 = 9'd225,
    COMP_LOOP_28_VEC_LOOP_C_5 = 9'd226,
    COMP_LOOP_28_VEC_LOOP_C_6 = 9'd227,
    COMP_LOOP_C_30 = 9'd228,
    COMP_LOOP_29_VEC_LOOP_C_0 = 9'd229,
    COMP_LOOP_29_VEC_LOOP_C_1 = 9'd230,
    COMP_LOOP_29_VEC_LOOP_C_2 = 9'd231,
    COMP_LOOP_29_VEC_LOOP_C_3 = 9'd232,
    COMP_LOOP_29_VEC_LOOP_C_4 = 9'd233,
    COMP_LOOP_29_VEC_LOOP_C_5 = 9'd234,
    COMP_LOOP_29_VEC_LOOP_C_6 = 9'd235,
    COMP_LOOP_C_31 = 9'd236,
    COMP_LOOP_30_VEC_LOOP_C_0 = 9'd237,
    COMP_LOOP_30_VEC_LOOP_C_1 = 9'd238,
    COMP_LOOP_30_VEC_LOOP_C_2 = 9'd239,
    COMP_LOOP_30_VEC_LOOP_C_3 = 9'd240,
    COMP_LOOP_30_VEC_LOOP_C_4 = 9'd241,
    COMP_LOOP_30_VEC_LOOP_C_5 = 9'd242,
    COMP_LOOP_30_VEC_LOOP_C_6 = 9'd243,
    COMP_LOOP_C_32 = 9'd244,
    COMP_LOOP_31_VEC_LOOP_C_0 = 9'd245,
    COMP_LOOP_31_VEC_LOOP_C_1 = 9'd246,
    COMP_LOOP_31_VEC_LOOP_C_2 = 9'd247,
    COMP_LOOP_31_VEC_LOOP_C_3 = 9'd248,
    COMP_LOOP_31_VEC_LOOP_C_4 = 9'd249,
    COMP_LOOP_31_VEC_LOOP_C_5 = 9'd250,
    COMP_LOOP_31_VEC_LOOP_C_6 = 9'd251,
    COMP_LOOP_C_33 = 9'd252,
    COMP_LOOP_32_VEC_LOOP_C_0 = 9'd253,
    COMP_LOOP_32_VEC_LOOP_C_1 = 9'd254,
    COMP_LOOP_32_VEC_LOOP_C_2 = 9'd255,
    COMP_LOOP_32_VEC_LOOP_C_3 = 9'd256,
    COMP_LOOP_32_VEC_LOOP_C_4 = 9'd257,
    COMP_LOOP_32_VEC_LOOP_C_5 = 9'd258,
    COMP_LOOP_32_VEC_LOOP_C_6 = 9'd259,
    COMP_LOOP_C_34 = 9'd260,
    STAGE_LOOP_C_1 = 9'd261,
    main_C_1 = 9'd262,
    main_C_2 = 9'd263;

  reg [8:0] state_var;
  reg [8:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIF_precomp_core_core_fsm_1
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
        if ( COMP_LOOP_1_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_3;
        end
        else begin
          state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 9'b000001100;
        if ( COMP_LOOP_C_3_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_2_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000001101;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_1;
      end
      COMP_LOOP_2_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000001110;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_2;
      end
      COMP_LOOP_2_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000001111;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_3;
      end
      COMP_LOOP_2_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000010000;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_4;
      end
      COMP_LOOP_2_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000010001;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_5;
      end
      COMP_LOOP_2_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000010010;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_6;
      end
      COMP_LOOP_2_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000010011;
        if ( COMP_LOOP_2_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_4;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 9'b000010100;
        if ( COMP_LOOP_C_4_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_3_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000010101;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_1;
      end
      COMP_LOOP_3_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000010110;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_2;
      end
      COMP_LOOP_3_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000010111;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_3;
      end
      COMP_LOOP_3_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000011000;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_4;
      end
      COMP_LOOP_3_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000011001;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_5;
      end
      COMP_LOOP_3_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000011010;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_6;
      end
      COMP_LOOP_3_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000011011;
        if ( COMP_LOOP_3_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_5;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 9'b000011100;
        if ( COMP_LOOP_C_5_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_4_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000011101;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_1;
      end
      COMP_LOOP_4_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000011110;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_2;
      end
      COMP_LOOP_4_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000011111;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_3;
      end
      COMP_LOOP_4_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000100000;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_4;
      end
      COMP_LOOP_4_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000100001;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_5;
      end
      COMP_LOOP_4_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000100010;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_6;
      end
      COMP_LOOP_4_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000100011;
        if ( COMP_LOOP_4_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_6;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 9'b000100100;
        if ( COMP_LOOP_C_6_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_5_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000100101;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_1;
      end
      COMP_LOOP_5_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000100110;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_2;
      end
      COMP_LOOP_5_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000100111;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_3;
      end
      COMP_LOOP_5_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000101000;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_4;
      end
      COMP_LOOP_5_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000101001;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_5;
      end
      COMP_LOOP_5_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000101010;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_6;
      end
      COMP_LOOP_5_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000101011;
        if ( COMP_LOOP_5_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_7;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 9'b000101100;
        if ( COMP_LOOP_C_7_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_6_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000101101;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_1;
      end
      COMP_LOOP_6_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000101110;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_2;
      end
      COMP_LOOP_6_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000101111;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_3;
      end
      COMP_LOOP_6_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000110000;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_4;
      end
      COMP_LOOP_6_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000110001;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_5;
      end
      COMP_LOOP_6_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000110010;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_6;
      end
      COMP_LOOP_6_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000110011;
        if ( COMP_LOOP_6_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_8;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 9'b000110100;
        if ( COMP_LOOP_C_8_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_7_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000110101;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_1;
      end
      COMP_LOOP_7_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000110110;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_2;
      end
      COMP_LOOP_7_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000110111;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_3;
      end
      COMP_LOOP_7_VEC_LOOP_C_3 : begin
        fsm_output = 9'b000111000;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_4;
      end
      COMP_LOOP_7_VEC_LOOP_C_4 : begin
        fsm_output = 9'b000111001;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_5;
      end
      COMP_LOOP_7_VEC_LOOP_C_5 : begin
        fsm_output = 9'b000111010;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_6;
      end
      COMP_LOOP_7_VEC_LOOP_C_6 : begin
        fsm_output = 9'b000111011;
        if ( COMP_LOOP_7_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_9;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 9'b000111100;
        if ( COMP_LOOP_C_9_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_8_VEC_LOOP_C_0 : begin
        fsm_output = 9'b000111101;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_1;
      end
      COMP_LOOP_8_VEC_LOOP_C_1 : begin
        fsm_output = 9'b000111110;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_2;
      end
      COMP_LOOP_8_VEC_LOOP_C_2 : begin
        fsm_output = 9'b000111111;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_3;
      end
      COMP_LOOP_8_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001000000;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_4;
      end
      COMP_LOOP_8_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001000001;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_5;
      end
      COMP_LOOP_8_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001000010;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_6;
      end
      COMP_LOOP_8_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001000011;
        if ( COMP_LOOP_8_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_10;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 9'b001000100;
        if ( COMP_LOOP_C_10_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_9_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001000101;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_1;
      end
      COMP_LOOP_9_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001000110;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_2;
      end
      COMP_LOOP_9_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001000111;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_3;
      end
      COMP_LOOP_9_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001001000;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_4;
      end
      COMP_LOOP_9_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001001001;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_5;
      end
      COMP_LOOP_9_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001001010;
        state_var_NS = COMP_LOOP_9_VEC_LOOP_C_6;
      end
      COMP_LOOP_9_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001001011;
        if ( COMP_LOOP_9_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_11;
        end
        else begin
          state_var_NS = COMP_LOOP_9_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 9'b001001100;
        if ( COMP_LOOP_C_11_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_10_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001001101;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_1;
      end
      COMP_LOOP_10_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001001110;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_2;
      end
      COMP_LOOP_10_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001001111;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_3;
      end
      COMP_LOOP_10_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001010000;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_4;
      end
      COMP_LOOP_10_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001010001;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_5;
      end
      COMP_LOOP_10_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001010010;
        state_var_NS = COMP_LOOP_10_VEC_LOOP_C_6;
      end
      COMP_LOOP_10_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001010011;
        if ( COMP_LOOP_10_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_12;
        end
        else begin
          state_var_NS = COMP_LOOP_10_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 9'b001010100;
        if ( COMP_LOOP_C_12_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_11_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001010101;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_1;
      end
      COMP_LOOP_11_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001010110;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_2;
      end
      COMP_LOOP_11_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001010111;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_3;
      end
      COMP_LOOP_11_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001011000;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_4;
      end
      COMP_LOOP_11_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001011001;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_5;
      end
      COMP_LOOP_11_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001011010;
        state_var_NS = COMP_LOOP_11_VEC_LOOP_C_6;
      end
      COMP_LOOP_11_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001011011;
        if ( COMP_LOOP_11_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_13;
        end
        else begin
          state_var_NS = COMP_LOOP_11_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 9'b001011100;
        if ( COMP_LOOP_C_13_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_12_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001011101;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_1;
      end
      COMP_LOOP_12_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001011110;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_2;
      end
      COMP_LOOP_12_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001011111;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_3;
      end
      COMP_LOOP_12_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001100000;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_4;
      end
      COMP_LOOP_12_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001100001;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_5;
      end
      COMP_LOOP_12_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001100010;
        state_var_NS = COMP_LOOP_12_VEC_LOOP_C_6;
      end
      COMP_LOOP_12_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001100011;
        if ( COMP_LOOP_12_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_14;
        end
        else begin
          state_var_NS = COMP_LOOP_12_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 9'b001100100;
        if ( COMP_LOOP_C_14_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_13_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001100101;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_1;
      end
      COMP_LOOP_13_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001100110;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_2;
      end
      COMP_LOOP_13_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001100111;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_3;
      end
      COMP_LOOP_13_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001101000;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_4;
      end
      COMP_LOOP_13_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001101001;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_5;
      end
      COMP_LOOP_13_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001101010;
        state_var_NS = COMP_LOOP_13_VEC_LOOP_C_6;
      end
      COMP_LOOP_13_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001101011;
        if ( COMP_LOOP_13_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_15;
        end
        else begin
          state_var_NS = COMP_LOOP_13_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 9'b001101100;
        if ( COMP_LOOP_C_15_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_14_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001101101;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_1;
      end
      COMP_LOOP_14_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001101110;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_2;
      end
      COMP_LOOP_14_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001101111;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_3;
      end
      COMP_LOOP_14_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001110000;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_4;
      end
      COMP_LOOP_14_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001110001;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_5;
      end
      COMP_LOOP_14_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001110010;
        state_var_NS = COMP_LOOP_14_VEC_LOOP_C_6;
      end
      COMP_LOOP_14_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001110011;
        if ( COMP_LOOP_14_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_16;
        end
        else begin
          state_var_NS = COMP_LOOP_14_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 9'b001110100;
        if ( COMP_LOOP_C_16_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_15_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001110101;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_1;
      end
      COMP_LOOP_15_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001110110;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_2;
      end
      COMP_LOOP_15_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001110111;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_3;
      end
      COMP_LOOP_15_VEC_LOOP_C_3 : begin
        fsm_output = 9'b001111000;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_4;
      end
      COMP_LOOP_15_VEC_LOOP_C_4 : begin
        fsm_output = 9'b001111001;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_5;
      end
      COMP_LOOP_15_VEC_LOOP_C_5 : begin
        fsm_output = 9'b001111010;
        state_var_NS = COMP_LOOP_15_VEC_LOOP_C_6;
      end
      COMP_LOOP_15_VEC_LOOP_C_6 : begin
        fsm_output = 9'b001111011;
        if ( COMP_LOOP_15_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_17;
        end
        else begin
          state_var_NS = COMP_LOOP_15_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 9'b001111100;
        if ( COMP_LOOP_C_17_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_16_VEC_LOOP_C_0 : begin
        fsm_output = 9'b001111101;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_1;
      end
      COMP_LOOP_16_VEC_LOOP_C_1 : begin
        fsm_output = 9'b001111110;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_2;
      end
      COMP_LOOP_16_VEC_LOOP_C_2 : begin
        fsm_output = 9'b001111111;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_3;
      end
      COMP_LOOP_16_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010000000;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_4;
      end
      COMP_LOOP_16_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010000001;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_5;
      end
      COMP_LOOP_16_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010000010;
        state_var_NS = COMP_LOOP_16_VEC_LOOP_C_6;
      end
      COMP_LOOP_16_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010000011;
        if ( COMP_LOOP_16_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_18;
        end
        else begin
          state_var_NS = COMP_LOOP_16_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 9'b010000100;
        if ( COMP_LOOP_C_18_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_17_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_17_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010000101;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_1;
      end
      COMP_LOOP_17_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010000110;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_2;
      end
      COMP_LOOP_17_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010000111;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_3;
      end
      COMP_LOOP_17_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010001000;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_4;
      end
      COMP_LOOP_17_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010001001;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_5;
      end
      COMP_LOOP_17_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010001010;
        state_var_NS = COMP_LOOP_17_VEC_LOOP_C_6;
      end
      COMP_LOOP_17_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010001011;
        if ( COMP_LOOP_17_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_19;
        end
        else begin
          state_var_NS = COMP_LOOP_17_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 9'b010001100;
        if ( COMP_LOOP_C_19_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_18_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_18_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010001101;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_1;
      end
      COMP_LOOP_18_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010001110;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_2;
      end
      COMP_LOOP_18_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010001111;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_3;
      end
      COMP_LOOP_18_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010010000;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_4;
      end
      COMP_LOOP_18_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010010001;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_5;
      end
      COMP_LOOP_18_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010010010;
        state_var_NS = COMP_LOOP_18_VEC_LOOP_C_6;
      end
      COMP_LOOP_18_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010010011;
        if ( COMP_LOOP_18_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_20;
        end
        else begin
          state_var_NS = COMP_LOOP_18_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 9'b010010100;
        if ( COMP_LOOP_C_20_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_19_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_19_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010010101;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_1;
      end
      COMP_LOOP_19_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010010110;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_2;
      end
      COMP_LOOP_19_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010010111;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_3;
      end
      COMP_LOOP_19_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010011000;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_4;
      end
      COMP_LOOP_19_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010011001;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_5;
      end
      COMP_LOOP_19_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010011010;
        state_var_NS = COMP_LOOP_19_VEC_LOOP_C_6;
      end
      COMP_LOOP_19_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010011011;
        if ( COMP_LOOP_19_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_21;
        end
        else begin
          state_var_NS = COMP_LOOP_19_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 9'b010011100;
        if ( COMP_LOOP_C_21_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_20_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_20_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010011101;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_1;
      end
      COMP_LOOP_20_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010011110;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_2;
      end
      COMP_LOOP_20_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010011111;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_3;
      end
      COMP_LOOP_20_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010100000;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_4;
      end
      COMP_LOOP_20_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010100001;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_5;
      end
      COMP_LOOP_20_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010100010;
        state_var_NS = COMP_LOOP_20_VEC_LOOP_C_6;
      end
      COMP_LOOP_20_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010100011;
        if ( COMP_LOOP_20_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_22;
        end
        else begin
          state_var_NS = COMP_LOOP_20_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 9'b010100100;
        if ( COMP_LOOP_C_22_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_21_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_21_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010100101;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_1;
      end
      COMP_LOOP_21_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010100110;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_2;
      end
      COMP_LOOP_21_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010100111;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_3;
      end
      COMP_LOOP_21_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010101000;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_4;
      end
      COMP_LOOP_21_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010101001;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_5;
      end
      COMP_LOOP_21_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010101010;
        state_var_NS = COMP_LOOP_21_VEC_LOOP_C_6;
      end
      COMP_LOOP_21_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010101011;
        if ( COMP_LOOP_21_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_23;
        end
        else begin
          state_var_NS = COMP_LOOP_21_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 9'b010101100;
        if ( COMP_LOOP_C_23_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_22_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_22_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010101101;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_1;
      end
      COMP_LOOP_22_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010101110;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_2;
      end
      COMP_LOOP_22_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010101111;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_3;
      end
      COMP_LOOP_22_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010110000;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_4;
      end
      COMP_LOOP_22_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010110001;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_5;
      end
      COMP_LOOP_22_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010110010;
        state_var_NS = COMP_LOOP_22_VEC_LOOP_C_6;
      end
      COMP_LOOP_22_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010110011;
        if ( COMP_LOOP_22_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_24;
        end
        else begin
          state_var_NS = COMP_LOOP_22_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 9'b010110100;
        if ( COMP_LOOP_C_24_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_23_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_23_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010110101;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_1;
      end
      COMP_LOOP_23_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010110110;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_2;
      end
      COMP_LOOP_23_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010110111;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_3;
      end
      COMP_LOOP_23_VEC_LOOP_C_3 : begin
        fsm_output = 9'b010111000;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_4;
      end
      COMP_LOOP_23_VEC_LOOP_C_4 : begin
        fsm_output = 9'b010111001;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_5;
      end
      COMP_LOOP_23_VEC_LOOP_C_5 : begin
        fsm_output = 9'b010111010;
        state_var_NS = COMP_LOOP_23_VEC_LOOP_C_6;
      end
      COMP_LOOP_23_VEC_LOOP_C_6 : begin
        fsm_output = 9'b010111011;
        if ( COMP_LOOP_23_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_25;
        end
        else begin
          state_var_NS = COMP_LOOP_23_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 9'b010111100;
        if ( COMP_LOOP_C_25_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_24_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_24_VEC_LOOP_C_0 : begin
        fsm_output = 9'b010111101;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_1;
      end
      COMP_LOOP_24_VEC_LOOP_C_1 : begin
        fsm_output = 9'b010111110;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_2;
      end
      COMP_LOOP_24_VEC_LOOP_C_2 : begin
        fsm_output = 9'b010111111;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_3;
      end
      COMP_LOOP_24_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011000000;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_4;
      end
      COMP_LOOP_24_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011000001;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_5;
      end
      COMP_LOOP_24_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011000010;
        state_var_NS = COMP_LOOP_24_VEC_LOOP_C_6;
      end
      COMP_LOOP_24_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011000011;
        if ( COMP_LOOP_24_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_26;
        end
        else begin
          state_var_NS = COMP_LOOP_24_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 9'b011000100;
        if ( COMP_LOOP_C_26_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_25_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_25_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011000101;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_1;
      end
      COMP_LOOP_25_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011000110;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_2;
      end
      COMP_LOOP_25_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011000111;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_3;
      end
      COMP_LOOP_25_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011001000;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_4;
      end
      COMP_LOOP_25_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011001001;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_5;
      end
      COMP_LOOP_25_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011001010;
        state_var_NS = COMP_LOOP_25_VEC_LOOP_C_6;
      end
      COMP_LOOP_25_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011001011;
        if ( COMP_LOOP_25_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_27;
        end
        else begin
          state_var_NS = COMP_LOOP_25_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 9'b011001100;
        if ( COMP_LOOP_C_27_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_26_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_26_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011001101;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_1;
      end
      COMP_LOOP_26_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011001110;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_2;
      end
      COMP_LOOP_26_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011001111;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_3;
      end
      COMP_LOOP_26_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011010000;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_4;
      end
      COMP_LOOP_26_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011010001;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_5;
      end
      COMP_LOOP_26_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011010010;
        state_var_NS = COMP_LOOP_26_VEC_LOOP_C_6;
      end
      COMP_LOOP_26_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011010011;
        if ( COMP_LOOP_26_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_28;
        end
        else begin
          state_var_NS = COMP_LOOP_26_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 9'b011010100;
        if ( COMP_LOOP_C_28_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_27_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_27_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011010101;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_1;
      end
      COMP_LOOP_27_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011010110;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_2;
      end
      COMP_LOOP_27_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011010111;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_3;
      end
      COMP_LOOP_27_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011011000;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_4;
      end
      COMP_LOOP_27_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011011001;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_5;
      end
      COMP_LOOP_27_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011011010;
        state_var_NS = COMP_LOOP_27_VEC_LOOP_C_6;
      end
      COMP_LOOP_27_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011011011;
        if ( COMP_LOOP_27_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_29;
        end
        else begin
          state_var_NS = COMP_LOOP_27_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 9'b011011100;
        if ( COMP_LOOP_C_29_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_28_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_28_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011011101;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_1;
      end
      COMP_LOOP_28_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011011110;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_2;
      end
      COMP_LOOP_28_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011011111;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_3;
      end
      COMP_LOOP_28_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011100000;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_4;
      end
      COMP_LOOP_28_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011100001;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_5;
      end
      COMP_LOOP_28_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011100010;
        state_var_NS = COMP_LOOP_28_VEC_LOOP_C_6;
      end
      COMP_LOOP_28_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011100011;
        if ( COMP_LOOP_28_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_30;
        end
        else begin
          state_var_NS = COMP_LOOP_28_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 9'b011100100;
        if ( COMP_LOOP_C_30_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_29_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_29_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011100101;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_1;
      end
      COMP_LOOP_29_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011100110;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_2;
      end
      COMP_LOOP_29_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011100111;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_3;
      end
      COMP_LOOP_29_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011101000;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_4;
      end
      COMP_LOOP_29_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011101001;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_5;
      end
      COMP_LOOP_29_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011101010;
        state_var_NS = COMP_LOOP_29_VEC_LOOP_C_6;
      end
      COMP_LOOP_29_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011101011;
        if ( COMP_LOOP_29_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_31;
        end
        else begin
          state_var_NS = COMP_LOOP_29_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 9'b011101100;
        if ( COMP_LOOP_C_31_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_30_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_30_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011101101;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_1;
      end
      COMP_LOOP_30_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011101110;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_2;
      end
      COMP_LOOP_30_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011101111;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_3;
      end
      COMP_LOOP_30_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011110000;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_4;
      end
      COMP_LOOP_30_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011110001;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_5;
      end
      COMP_LOOP_30_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011110010;
        state_var_NS = COMP_LOOP_30_VEC_LOOP_C_6;
      end
      COMP_LOOP_30_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011110011;
        if ( COMP_LOOP_30_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_32;
        end
        else begin
          state_var_NS = COMP_LOOP_30_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 9'b011110100;
        if ( COMP_LOOP_C_32_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_31_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_31_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011110101;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_1;
      end
      COMP_LOOP_31_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011110110;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_2;
      end
      COMP_LOOP_31_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011110111;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_3;
      end
      COMP_LOOP_31_VEC_LOOP_C_3 : begin
        fsm_output = 9'b011111000;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_4;
      end
      COMP_LOOP_31_VEC_LOOP_C_4 : begin
        fsm_output = 9'b011111001;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_5;
      end
      COMP_LOOP_31_VEC_LOOP_C_5 : begin
        fsm_output = 9'b011111010;
        state_var_NS = COMP_LOOP_31_VEC_LOOP_C_6;
      end
      COMP_LOOP_31_VEC_LOOP_C_6 : begin
        fsm_output = 9'b011111011;
        if ( COMP_LOOP_31_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_33;
        end
        else begin
          state_var_NS = COMP_LOOP_31_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 9'b011111100;
        if ( COMP_LOOP_C_33_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_32_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_32_VEC_LOOP_C_0 : begin
        fsm_output = 9'b011111101;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_1;
      end
      COMP_LOOP_32_VEC_LOOP_C_1 : begin
        fsm_output = 9'b011111110;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_2;
      end
      COMP_LOOP_32_VEC_LOOP_C_2 : begin
        fsm_output = 9'b011111111;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_3;
      end
      COMP_LOOP_32_VEC_LOOP_C_3 : begin
        fsm_output = 9'b100000000;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_4;
      end
      COMP_LOOP_32_VEC_LOOP_C_4 : begin
        fsm_output = 9'b100000001;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_5;
      end
      COMP_LOOP_32_VEC_LOOP_C_5 : begin
        fsm_output = 9'b100000010;
        state_var_NS = COMP_LOOP_32_VEC_LOOP_C_6;
      end
      COMP_LOOP_32_VEC_LOOP_C_6 : begin
        fsm_output = 9'b100000011;
        if ( COMP_LOOP_32_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_34;
        end
        else begin
          state_var_NS = COMP_LOOP_32_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 9'b100000100;
        if ( COMP_LOOP_C_34_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 9'b100000101;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b100000110;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 9'b100000111;
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl (
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp (
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl (
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
      .core_wten_pff(core_wten_pff),
      .twiddle_h_rsci_oswt_1_pff(twiddle_h_rsci_oswt_1_pff),
      .twiddle_h_rsci_oswt_pff(twiddle_h_rsci_oswt_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst
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
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1 (
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
      .core_wten_pff(core_wten_pff),
      .twiddle_rsci_oswt_1_pff(twiddle_rsci_oswt_1_pff),
      .twiddle_rsci_oswt_pff(twiddle_rsci_oswt_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst
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
  wire [8:0] fsm_output;
  wire nor_tmp_1;
  wire and_dcpl_3;
  wire and_dcpl_7;
  wire or_dcpl_141;
  wire or_dcpl_143;
  wire or_tmp_34;
  wire or_tmp_36;
  wire and_dcpl_23;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_34;
  wire and_dcpl_35;
  wire xor_dcpl;
  wire and_dcpl_39;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire and_dcpl_44;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire and_dcpl_48;
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_56;
  wire and_dcpl_57;
  wire and_dcpl_59;
  wire and_dcpl_60;
  wire and_dcpl_61;
  wire and_dcpl_62;
  wire and_dcpl_63;
  wire and_dcpl_64;
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
  wire and_dcpl_103;
  wire and_dcpl_104;
  wire and_dcpl_106;
  wire nor_tmp_10;
  wire or_tmp_38;
  wire and_dcpl_123;
  wire and_dcpl_124;
  wire and_dcpl_127;
  wire and_dcpl_133;
  wire and_dcpl_134;
  wire and_dcpl_135;
  wire and_dcpl_142;
  wire and_dcpl_146;
  wire and_dcpl_154;
  wire nor_tmp_16;
  wire and_dcpl_177;
  wire or_tmp_63;
  wire and_dcpl_183;
  wire and_dcpl_185;
  wire and_dcpl_186;
  wire mux_tmp_66;
  wire and_dcpl_208;
  wire and_dcpl_220;
  wire and_tmp_12;
  wire and_dcpl_226;
  wire and_dcpl_236;
  reg [11:0] VEC_LOOP_acc_1_cse_10_sva;
  reg [12:0] STAGE_LOOP_lshift_psp_sva;
  reg [12:0] VEC_LOOP_j_12_0_1_sva_1;
  reg run_ac_sync_tmp_dobj_sva;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  wire or_193_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_twiddle_rsci_oswt_1_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_1_cse;
  wire or_169_cse;
  wire or_191_cse;
  wire or_289_cse;
  wire and_260_cse;
  wire or_194_cse;
  wire and_269_cse;
  wire nor_46_cse;
  wire and_272_cse;
  wire nor_44_cse;
  wire nand_8_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire and_130_rmff;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_33_rmff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [7:0] COMP_LOOP_twiddle_help_mux_1_rmff;
  wire [3:0] COMP_LOOP_twiddle_help_mux_rmff;
  wire [6:0] COMP_LOOP_twiddle_f_mux1h_87_rmff;
  wire [1:0] COMP_LOOP_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_57_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_111_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_128_rmff;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_139_rmff;
  wire and_133_rmff;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_192_rmff;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_f_17_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_17_sva;
  wire [11:0] VEC_LOOP_acc_10_cse_2_sva_mx0w1;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1;
  reg [11:0] VEC_LOOP_acc_10_cse_1_sva;
  wire [11:0] VEC_LOOP_acc_10_cse_3_sva_mx0w2;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2;
  wire [11:0] VEC_LOOP_acc_10_cse_4_sva_mx0w3;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3;
  wire [11:0] VEC_LOOP_acc_10_cse_5_sva_mx0w4;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4;
  wire [11:0] VEC_LOOP_acc_10_cse_6_sva_mx0w5;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5;
  wire [11:0] VEC_LOOP_acc_10_cse_7_sva_mx0w6;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6;
  wire [11:0] VEC_LOOP_acc_10_cse_8_sva_mx0w7;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7;
  wire [11:0] VEC_LOOP_acc_10_cse_10_sva_mx0w9;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9;
  wire [11:0] VEC_LOOP_acc_10_cse_11_sva_mx0w10;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10;
  wire [11:0] VEC_LOOP_acc_10_cse_12_sva_mx0w11;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11;
  wire [11:0] VEC_LOOP_acc_10_cse_13_sva_mx0w12;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12;
  wire [11:0] VEC_LOOP_acc_10_cse_14_sva_mx0w13;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13;
  wire [11:0] VEC_LOOP_acc_10_cse_15_sva_mx0w14;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14;
  wire [11:0] VEC_LOOP_acc_10_cse_16_sva_mx0w15;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15;
  reg [7:0] COMP_LOOP_17_twiddle_f_mul_psp_sva;
  wire [11:0] VEC_LOOP_acc_10_cse_18_sva_mx0w17;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17;
  wire [11:0] VEC_LOOP_acc_10_cse_19_sva_mx0w18;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18;
  wire [11:0] VEC_LOOP_acc_10_cse_20_sva_mx0w19;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_20_sva_mx0w19;
  wire [11:0] VEC_LOOP_acc_10_cse_21_sva_mx0w20;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20;
  wire [11:0] VEC_LOOP_acc_10_cse_22_sva_mx0w21;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_22_sva_mx0w21;
  wire [11:0] VEC_LOOP_acc_10_cse_23_sva_mx0w22;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22;
  wire [11:0] VEC_LOOP_acc_10_cse_24_sva_mx0w23;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_24_sva_mx0w23;
  wire [11:0] VEC_LOOP_acc_10_cse_26_sva_mx0w25;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_26_sva_mx0w25;
  wire [11:0] VEC_LOOP_acc_10_cse_27_sva_mx0w26;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26;
  wire [11:0] VEC_LOOP_acc_10_cse_28_sva_mx0w27;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_28_sva_mx0w27;
  wire [11:0] VEC_LOOP_acc_10_cse_29_sva_mx0w28;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28;
  wire [11:0] VEC_LOOP_acc_10_cse_30_sva_mx0w29;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29;
  wire [11:0] VEC_LOOP_acc_10_cse_31_sva_mx0w30;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30;
  wire [11:0] VEC_LOOP_acc_10_cse_sva_mx0w31;
  wire [12:0] nl_VEC_LOOP_acc_10_cse_sva_mx0w31;
  reg [31:0] p_sva;
  wire mux_38_itm;
  wire mux_61_itm;
  wire [12:0] z_out;
  wire [9:0] z_out_1;
  wire and_dcpl_274;
  wire [11:0] z_out_2;
  wire [23:0] nl_z_out_2;
  wire and_dcpl_280;
  wire and_dcpl_282;
  wire and_dcpl_287;
  wire and_dcpl_288;
  wire and_dcpl_291;
  wire and_dcpl_293;
  wire [11:0] z_out_3;
  wire [23:0] nl_z_out_3;
  wire and_dcpl_304;
  wire and_dcpl_307;
  wire and_dcpl_312;
  wire [11:0] z_out_4;
  wire [23:0] nl_z_out_4;
  wire and_dcpl_319;
  wire and_dcpl_320;
  wire and_dcpl_323;
  wire and_dcpl_328;
  wire and_dcpl_331;
  wire [11:0] z_out_6;
  wire [23:0] nl_z_out_6;
  wire and_dcpl_358;
  wire and_dcpl_362;
  wire and_dcpl_364;
  wire and_dcpl_369;
  wire and_dcpl_377;
  wire and_dcpl_381;
  wire and_dcpl_385;
  wire and_dcpl_388;
  wire [11:0] z_out_8;
  wire [23:0] nl_z_out_8;
  wire and_dcpl_401;
  wire and_dcpl_405;
  wire and_dcpl_409;
  wire [11:0] z_out_9;
  wire [23:0] nl_z_out_9;
  wire and_dcpl_422;
  wire [3:0] z_out_10;
  wire [4:0] nl_z_out_10;
  wire and_dcpl_429;
  wire and_dcpl_430;
  wire and_dcpl_433;
  wire and_dcpl_436;
  wire and_dcpl_439;
  wire and_dcpl_441;
  wire and_dcpl_444;
  wire and_dcpl_446;
  wire and_dcpl_448;
  wire and_dcpl_453;
  wire and_dcpl_454;
  wire and_dcpl_456;
  wire and_dcpl_458;
  wire and_dcpl_460;
  wire [9:0] z_out_11;
  wire and_dcpl_463;
  wire and_dcpl_467;
  wire and_dcpl_468;
  wire and_dcpl_471;
  wire and_dcpl_474;
  wire and_dcpl_477;
  wire and_dcpl_481;
  wire [8:0] z_out_12;
  wire [9:0] nl_z_out_12;
  wire and_dcpl_488;
  wire and_dcpl_489;
  wire and_dcpl_492;
  wire and_dcpl_495;
  wire and_dcpl_498;
  wire and_dcpl_501;
  wire and_dcpl_503;
  wire and_dcpl_505;
  wire and_dcpl_507;
  wire and_dcpl_510;
  wire and_dcpl_512;
  wire and_dcpl_514;
  wire and_dcpl_516;
  wire and_dcpl_519;
  wire and_dcpl_521;
  wire and_dcpl_523;
  wire and_dcpl_525;
  wire and_dcpl_527;
  wire and_dcpl_528;
  wire and_dcpl_529;
  wire and_dcpl_530;
  wire and_dcpl_531;
  wire [11:0] z_out_13;
  wire [12:0] nl_z_out_13;
  wire [11:0] z_out_14;
  wire [12:0] nl_z_out_14;
  wire and_dcpl_598;
  wire and_dcpl_599;
  wire and_dcpl_604;
  wire and_dcpl_605;
  wire and_dcpl_608;
  wire and_dcpl_611;
  wire and_dcpl_613;
  wire and_dcpl_614;
  wire and_dcpl_616;
  wire and_dcpl_617;
  wire and_dcpl_620;
  wire and_dcpl_622;
  wire and_dcpl_623;
  wire and_dcpl_626;
  wire and_dcpl_628;
  wire and_dcpl_630;
  wire and_dcpl_631;
  wire and_dcpl_633;
  wire and_dcpl_635;
  wire and_dcpl_636;
  wire and_dcpl_638;
  wire and_dcpl_640;
  wire [12:0] z_out_15;
  wire and_dcpl_646;
  wire [10:0] z_out_17;
  wire [11:0] nl_z_out_17;
  wire and_dcpl_690;
  wire and_dcpl_691;
  wire and_dcpl_694;
  wire and_dcpl_697;
  wire and_dcpl_700;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [11:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [9:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva;
  reg [6:0] COMP_LOOP_k_12_5_sva_6_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [10:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
  wire [11:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c1;
  wire COMP_LOOP_or_cse;
  wire COMP_LOOP_or_2_cse;
  wire COMP_LOOP_or_1_cse;
  wire COMP_LOOP_or_4_cse;
  wire COMP_LOOP_or_3_cse;
  wire COMP_LOOP_or_6_cse;
  wire COMP_LOOP_or_7_cse;
  wire COMP_LOOP_or_5_cse;
  wire VEC_LOOP_or_26_cse;
  wire VEC_LOOP_or_7_cse;
  wire VEC_LOOP_or_9_cse;
  wire VEC_LOOP_or_28_cse;
  wire VEC_LOOP_or_19_cse;
  wire or_187_cse;
  wire VEC_LOOP_or_34_ssc;
  wire VEC_LOOP_or_3_ssc;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire COMP_LOOP_twiddle_help_and_1_cse;
  wire and_752_cse;
  wire [8:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt;
  wire [10:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt;
  reg [3:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_10_7;
  reg [6:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_6_0;
  reg VEC_LOOP_acc_11_psp_sva_10;
  reg VEC_LOOP_acc_11_psp_sva_9;
  reg [8:0] VEC_LOOP_acc_11_psp_sva_8_0;
  reg [4:0] COMP_LOOP_9_twiddle_f_lshift_ncse_sva_8_4;
  reg [3:0] COMP_LOOP_9_twiddle_f_lshift_ncse_sva_3_0;
  wire and_241_ssc;
  wire and_762_cse;
  wire or_326_cse;
  wire mux_cse;
  wire or_334_cse;
  wire nor_117_cse;
  wire or_306_cse;
  wire and_788_cse;
  wire nor_114_cse;
  wire COMP_LOOP_twiddle_f_or_36_itm;
  wire COMP_LOOP_twiddle_f_nor_8_itm;
  wire COMP_LOOP_twiddle_f_or_37_itm;
  wire VEC_LOOP_or_32_itm;
  wire VEC_LOOP_or_44_itm;
  wire VEC_LOOP_or_45_itm;
  wire VEC_LOOP_or_55_itm;
  wire VEC_LOOP_or_56_itm;
  wire VEC_LOOP_or_59_itm;
  wire VEC_LOOP_or_62_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire [9:0] z_out_5_9_0;
  wire [19:0] nl_z_out_5_9_0;
  wire [10:0] z_out_7_10_0;
  wire [21:0] nl_z_out_7_10_0;
  wire z_out_16_12;
  wire z_out_18_10;
  wire [31:0] VEC_LOOP_mux_26_cse;

  wire[0:0] mux_37_nl;
  wire[0:0] mux_36_nl;
  wire[0:0] or_182_nl;
  wire[0:0] mux_48_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] or_203_nl;
  wire[0:0] mux_46_nl;
  wire[0:0] or_202_nl;
  wire[0:0] mux_49_nl;
  wire[0:0] or_287_nl;
  wire[0:0] and_261_nl;
  wire[1:0] COMP_LOOP_mux1h_nl;
  wire[0:0] COMP_LOOP_twiddle_f_nor_nl;
  wire[0:0] mux_50_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_57_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] mux_51_nl;
  wire[0:0] nor_43_nl;
  wire[0:0] and_177_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_111_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] nor_41_nl;
  wire[0:0] nor_42_nl;
  wire[0:0] not_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_128_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] and_277_nl;
  wire[0:0] nor_40_nl;
  wire[0:0] mux_60_nl;
  wire[0:0] or_222_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] mux_34_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_94_nl;
  wire[0:0] or_nl;
  wire[7:0] COMP_LOOP_17_twiddle_f_mul_nl;
  wire[15:0] nl_COMP_LOOP_17_twiddle_f_mul_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] nor_74_nl;
  wire[0:0] or_297_nl;
  wire[0:0] or_298_nl;
  wire[0:0] and_218_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] mux_95_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] nor_116_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] or_313_nl;
  wire[0:0] nand_15_nl;
  wire[6:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_9_nl;
  wire[6:0] COMP_LOOP_1_twiddle_f_mul_nl;
  wire[13:0] nl_COMP_LOOP_1_twiddle_f_mul_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] nor_115_nl;
  wire[0:0] and_766_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] or_333_nl;
  wire[0:0] or_335_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] nor_63_nl;
  wire[0:0] and_279_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] nor_58_nl;
  wire[0:0] nor_59_nl;
  wire[0:0] or_258_nl;
  wire[0:0] nor_60_nl;
  wire[11:0] VEC_LOOP_VEC_LOOP_mux_1_nl;
  wire[0:0] VEC_LOOP_or_nl;
  wire[0:0] VEC_LOOP_not_nl;
  wire[0:0] VEC_LOOP_or_25_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] nor_57_nl;
  wire[0:0] and_278_nl;
  wire[0:0] or_324_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] or_323_nl;
  wire[0:0] mux_106_nl;
  wire[0:0] mux_105_nl;
  wire[0:0] VEC_LOOP_or_65_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] and_252_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] and_268_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[7:0] VEC_LOOP_mux1h_10_nl;
  wire[0:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] and_125_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_122_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_119_nl;
  wire[6:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_44_nl;
  wire[0:0] and_51_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] and_115_nl;
  wire[0:0] mux_39_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] and_120_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] and_264_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] and_123_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] or_197_nl;
  wire[0:0] and_263_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] and_126_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] and_262_nl;
  wire[0:0] VEC_LOOP_mux1h_9_nl;
  wire[0:0] and_129_nl;
  wire[11:0] COMP_LOOP_twiddle_f_mux_10_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_6_nl;
  wire[5:0] COMP_LOOP_twiddle_f_mux_11_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_7_nl;
  wire[11:0] COMP_LOOP_twiddle_f_mux1h_295_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_8_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_9_nl;
  wire[1:0] COMP_LOOP_twiddle_f_mux_12_nl;
  wire[0:0] COMP_LOOP_twiddle_f_nor_13_nl;
  wire[6:0] COMP_LOOP_twiddle_f_mux1h_296_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_12_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_13_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_14_nl;
  wire[1:0] COMP_LOOP_twiddle_f_mux_13_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_46_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_15_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_16_nl;
  wire[3:0] COMP_LOOP_twiddle_f_mux1h_297_nl;
  wire[0:0] and_792_nl;
  wire[0:0] and_793_nl;
  wire[0:0] and_794_nl;
  wire[0:0] and_795_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_17_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_18_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_19_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_10_nl;
  wire[10:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_10_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_11_nl;
  wire[5:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_11_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_20_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_21_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_22_nl;
  wire[1:0] COMP_LOOP_twiddle_f_or_47_nl;
  wire[1:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_12_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_48_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_49_nl;
  wire[3:0] STAGE_LOOP_mux_4_nl;
  wire[10:0] acc_1_nl;
  wire[11:0] nl_acc_1_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[8:0] VEC_LOOP_mux1h_40_nl;
  wire[0:0] VEC_LOOP_or_66_nl;
  wire[0:0] VEC_LOOP_or_67_nl;
  wire[0:0] VEC_LOOP_or_68_nl;
  wire[0:0] VEC_LOOP_and_22_nl;
  wire[0:0] VEC_LOOP_and_23_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_10_nl;
  wire[0:0] VEC_LOOP_and_24_nl;
  wire[0:0] VEC_LOOP_mux1h_41_nl;
  wire[3:0] VEC_LOOP_mux1h_42_nl;
  wire[0:0] VEC_LOOP_or_69_nl;
  wire[0:0] VEC_LOOP_mux1h_43_nl;
  wire[0:0] VEC_LOOP_or_70_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_11_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[6:0] VEC_LOOP_mux1h_44_nl;
  wire[0:0] VEC_LOOP_or_71_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;
  wire[0:0] VEC_LOOP_mux_25_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_18_nl;
  wire[8:0] VEC_LOOP_mux1h_45_nl;
  wire[7:0] VEC_LOOP_mux1h_46_nl;
  wire[0:0] VEC_LOOP_mux1h_47_nl;
  wire[0:0] VEC_LOOP_or_72_nl;
  wire[2:0] VEC_LOOP_VEC_LOOP_mux_12_nl;
  wire[6:0] VEC_LOOP_VEC_LOOP_mux_13_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_19_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_20_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_21_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_22_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_23_nl;
  wire[4:0] VEC_LOOP_or_73_nl;
  wire[4:0] VEC_LOOP_mux1h_48_nl;
  wire[0:0] and_797_nl;
  wire[0:0] and_798_nl;
  wire[0:0] and_799_nl;
  wire[0:0] and_800_nl;
  wire[0:0] and_801_nl;
  wire[0:0] and_802_nl;
  wire[0:0] and_803_nl;
  wire[0:0] and_804_nl;
  wire[0:0] and_805_nl;
  wire[0:0] and_806_nl;
  wire[0:0] and_807_nl;
  wire[0:0] and_808_nl;
  wire[0:0] and_809_nl;
  wire[0:0] and_810_nl;
  wire[0:0] and_811_nl;
  wire[0:0] and_812_nl;
  wire[0:0] and_813_nl;
  wire[0:0] and_814_nl;
  wire[0:0] and_815_nl;
  wire[0:0] and_816_nl;
  wire[0:0] and_817_nl;
  wire[0:0] and_818_nl;
  wire[0:0] and_819_nl;
  wire[0:0] and_820_nl;
  wire[0:0] and_821_nl;
  wire[0:0] and_822_nl;
  wire[0:0] and_823_nl;
  wire[0:0] and_824_nl;
  wire[13:0] acc_5_nl;
  wire[14:0] nl_acc_5_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_24_nl;
  wire[11:0] VEC_LOOP_VEC_LOOP_mux_14_nl;
  wire[0:0] VEC_LOOP_or_74_nl;
  wire[6:0] VEC_LOOP_VEC_LOOP_mux_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_25_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_26_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_27_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_28_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_29_nl;
  wire[13:0] acc_6_nl;
  wire[14:0] nl_acc_6_nl;
  wire[3:0] COMP_LOOP_mux1h_8_nl;
  wire[0:0] and_825_nl;
  wire[2:0] VEC_LOOP_or_75_nl;
  wire[2:0] VEC_LOOP_nor_35_nl;
  wire[2:0] VEC_LOOP_mux1h_49_nl;
  wire[0:0] and_826_nl;
  wire[0:0] and_827_nl;
  wire[0:0] and_828_nl;
  wire[0:0] and_829_nl;
  wire[0:0] and_830_nl;
  wire[0:0] and_831_nl;
  wire[0:0] and_832_nl;
  wire[0:0] and_833_nl;
  wire[11:0] acc_8_nl;
  wire[12:0] nl_acc_8_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_2_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_3_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat = MUX_v_32_2_2(COMP_LOOP_twiddle_f_1_sva,
      COMP_LOOP_twiddle_f_17_sva, and_dcpl_183);
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1 = MUX_v_32_2_2(COMP_LOOP_twiddle_help_1_sva,
      COMP_LOOP_twiddle_help_17_sva, and_dcpl_183);
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_p_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_p_rsc_dat = p_sva;
  wire[32:0] acc_9_nl;
  wire[33:0] nl_acc_9_nl;
  wire[31:0] VEC_LOOP_mux_27_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_27_nl = MUX_v_32_2_2((~ (vec_rsci_qa_d_mxwt[63:32])), (~ (vec_rsci_qa_d_mxwt[31:0])),
      and_752_cse);
  assign nl_acc_9_nl = ({VEC_LOOP_mux_26_cse , 1'b1}) + ({VEC_LOOP_mux_27_nl , 1'b1});
  assign acc_9_nl = nl_acc_9_nl[32:0];
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = readslicef_33_32_1(acc_9_nl);
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire[31:0] VEC_LOOP_mux_29_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_29_nl = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
      and_752_cse);
  assign nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat = VEC_LOOP_mux_26_cse + VEC_LOOP_mux_29_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat = p_sva;
  wire[0:0] and_291_nl;
  wire [3:0] nl_COMP_LOOP_17_twiddle_f_lshift_rg_s;
  assign and_291_nl = (fsm_output==9'b000000010);
  assign nl_COMP_LOOP_17_twiddle_f_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva,
      z_out_10, and_291_nl);
  wire[0:0] and_305_nl;
  wire [3:0] nl_COMP_LOOP_1_twiddle_f_lshift_rg_s;
  assign and_305_nl = and_dcpl_33 & (~ (fsm_output[0])) & and_dcpl_127 & (fsm_output[5:4]==2'b00)
      & and_dcpl_3;
  assign nl_COMP_LOOP_1_twiddle_f_lshift_rg_s = MUX_v_4_2_2(COMP_LOOP_9_twiddle_f_lshift_ncse_sva_3_0,
      z_out_10, and_305_nl);
  wire[31:0] VEC_LOOP_mux_3_nl;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_3_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      COMP_LOOP_1_mult_cmp_return_rsc_z, and_dcpl_39);
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_3_nl};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , and_130_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_33_rmff , and_33_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , and_130_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_38_itm;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_wait_dp_inst_ensig_cgo_iro;
  assign nl_inPlaceNTT_DIF_precomp_core_wait_dp_inst_ensig_cgo_iro = ~ mux_61_itm;
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_139_rmff , and_133_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_139_rmff , and_133_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ run_ac_sync_tmp_dobj_sva;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ z_out_16_12;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ z_out_18_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_11[9]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ z_out_16_12;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ z_out_18_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ z_out_16_12;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (z_out_11[8]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0 = ~ z_out_18_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0 = ~ (z_out_11[9]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0 = ~ z_out_18_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0 = ~ (z_out_15[12]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0 = ~ (z_out_11[7]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_12_0_1_sva_1[12];
  wire[12:0] COMP_LOOP_1_acc_nl;
  wire[13:0] nl_COMP_LOOP_1_acc_nl;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0;
  assign nl_COMP_LOOP_1_acc_nl = ({(z_out_12[7:0]) , 5'b00000}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[12:1]))})
      + 13'b0000000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[12:0];
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0 = ~ (readslicef_13_1_12(COMP_LOOP_1_acc_nl));
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
      .ccs_ccore_start_rsc_dat(and_dcpl_55),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_mult_cmp_ccs_ccore_en)
    );
  modulo_sub  COMP_LOOP_1_modulo_sub_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_dcpl_186),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_dcpl_186),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) COMP_LOOP_3_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_9_twiddle_f_lshift_ncse_sva_3_0),
      .z(COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd12)) COMP_LOOP_2_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_9_twiddle_f_lshift_ncse_sva_3_0),
      .z(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd13)) COMP_LOOP_17_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_17_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_1_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out_1)
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
      .vec_rsci_oswt_1_pff(and_33_rmff)
    );
  inPlaceNTT_DIF_precomp_core_wait_dp inPlaceNTT_DIF_precomp_core_wait_dp_inst (
      .ensig_cgo_iro(nl_inPlaceNTT_DIF_precomp_core_wait_dp_inst_ensig_cgo_iro[0:0]),
      .ensig_cgo_iro_1(and_192_rmff),
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
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_rsci_oswt_1(reg_twiddle_rsci_oswt_1_cse),
      .twiddle_rsci_qa_d_mxwt(twiddle_rsci_qa_d_mxwt),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .twiddle_rsci_oswt_1_pff(and_139_rmff),
      .twiddle_rsci_oswt_pff(and_133_rmff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst
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
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .twiddle_h_rsci_oswt_1_pff(and_139_rmff),
      .twiddle_h_rsci_oswt_pff(and_133_rmff)
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
      .COMP_LOOP_C_3_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0[0:0]),
      .COMP_LOOP_2_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_4_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0[0:0]),
      .COMP_LOOP_3_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_5_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0[0:0]),
      .COMP_LOOP_4_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_5_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_7_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0[0:0]),
      .COMP_LOOP_6_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_8_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0[0:0]),
      .COMP_LOOP_7_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_9_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0[0:0]),
      .COMP_LOOP_8_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_10_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0[0:0]),
      .COMP_LOOP_9_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_11_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0[0:0]),
      .COMP_LOOP_10_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_12_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0[0:0]),
      .COMP_LOOP_11_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_13_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0[0:0]),
      .COMP_LOOP_12_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_14_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0[0:0]),
      .COMP_LOOP_13_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_15_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0[0:0]),
      .COMP_LOOP_14_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_16_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0[0:0]),
      .COMP_LOOP_15_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_17_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0[0:0]),
      .COMP_LOOP_16_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_18_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0[0:0]),
      .COMP_LOOP_17_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_19_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0[0:0]),
      .COMP_LOOP_18_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_20_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0[0:0]),
      .COMP_LOOP_19_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_21_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0[0:0]),
      .COMP_LOOP_20_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_22_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0[0:0]),
      .COMP_LOOP_21_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_23_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0[0:0]),
      .COMP_LOOP_22_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_24_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0[0:0]),
      .COMP_LOOP_23_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_25_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0[0:0]),
      .COMP_LOOP_24_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_26_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0[0:0]),
      .COMP_LOOP_25_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_27_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0[0:0]),
      .COMP_LOOP_26_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_28_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0[0:0]),
      .COMP_LOOP_27_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_29_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0[0:0]),
      .COMP_LOOP_28_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_30_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0[0:0]),
      .COMP_LOOP_29_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_31_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0[0:0]),
      .COMP_LOOP_30_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_32_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0[0:0]),
      .COMP_LOOP_31_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_33_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0[0:0]),
      .COMP_LOOP_32_VEC_LOOP_C_6_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_6_tr0[0:0]),
      .COMP_LOOP_C_34_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign mux_37_nl = MUX_s_1_2_2(or_tmp_36, or_tmp_34, fsm_output[2]);
  assign or_182_nl = (fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[8]);
  assign mux_36_nl = MUX_s_1_2_2(or_182_nl, or_tmp_34, fsm_output[2]);
  assign mux_38_itm = MUX_s_1_2_2(mux_37_nl, mux_36_nl, or_169_cse);
  assign and_33_rmff = nor_117_cse & and_dcpl_23;
  assign or_191_cse = (fsm_output[6:4]!=3'b000);
  assign or_193_cse = (fsm_output[7:5]!=3'b000);
  assign nor_46_cse = ~((fsm_output[5:4]!=2'b00));
  assign or_289_cse = nor_46_cse | (fsm_output[3]);
  assign or_194_cse = (fsm_output[7:6]!=2'b00);
  assign or_203_nl = (fsm_output[0]) | (~ (fsm_output[8]));
  assign mux_47_nl = MUX_s_1_2_2(or_203_nl, or_tmp_34, fsm_output[2]);
  assign or_202_nl = (fsm_output[0]) | (fsm_output[8]);
  assign mux_46_nl = MUX_s_1_2_2(or_202_nl, or_tmp_34, fsm_output[2]);
  assign mux_48_nl = MUX_s_1_2_2(mux_47_nl, mux_46_nl, or_169_cse);
  assign and_130_rmff = (~ mux_48_nl) & (fsm_output[1]);
  assign or_287_nl = nor_44_cse | (VEC_LOOP_j_12_0_1_sva_1[12]);
  assign and_261_nl = nand_8_cse & (VEC_LOOP_j_12_0_1_sva_1[12]);
  assign mux_49_nl = MUX_s_1_2_2(or_287_nl, and_261_nl, fsm_output[7]);
  assign and_133_rmff = mux_49_nl & and_dcpl_124;
  assign and_139_rmff = and_dcpl_34 & ((VEC_LOOP_j_12_0_1_sva_1[12]) | (~ (fsm_output[6])))
      & and_dcpl_127 & (~ (fsm_output[4])) & (~ (fsm_output[5])) & (~ (fsm_output[7]));
  assign COMP_LOOP_or_cse = (and_dcpl_135 & and_dcpl_45) | (and_dcpl_135 & and_dcpl_51)
      | (and_dcpl_135 & and_dcpl_59) | (and_dcpl_133 & and_dcpl_86);
  assign COMP_LOOP_or_2_cse = (and_dcpl_133 & and_dcpl_45) | (and_dcpl_133 & and_dcpl_69)
      | (and_dcpl_135 & and_dcpl_83) | (and_dcpl_135 & and_dcpl_96);
  assign COMP_LOOP_or_1_cse = (and_dcpl_133 & and_dcpl_51) | (and_dcpl_133 & and_dcpl_63)
      | (and_dcpl_133 & and_dcpl_72) | (and_dcpl_135 & and_dcpl_99);
  assign COMP_LOOP_or_4_cse = and_dcpl_142 | (and_dcpl_133 & and_dcpl_83) | (and_dcpl_133
      & and_dcpl_93) | (and_dcpl_133 & and_dcpl_96);
  assign COMP_LOOP_or_3_cse = (and_dcpl_135 & and_dcpl_69) | (and_dcpl_133 & and_dcpl_75)
      | (and_dcpl_133 & and_dcpl_79) | (and_dcpl_133 & and_dcpl_99);
  assign COMP_LOOP_or_6_cse = (and_dcpl_135 & and_dcpl_75) | (and_dcpl_133 & and_dcpl_89);
  assign COMP_LOOP_or_7_cse = (and_dcpl_135 & and_dcpl_79) | (and_dcpl_135 & and_dcpl_93);
  assign COMP_LOOP_or_5_cse = (and_dcpl_133 & and_dcpl_59) | (and_dcpl_135 & and_dcpl_89);
  assign COMP_LOOP_mux1h_nl = MUX1HOT_v_2_11_2((z_out_2[3:2]), (z_out_4[4:3]), (z_out_5_9_0[2:1]),
      (z_out_7_10_0[3:2]), (z_out_3[1:0]), (z_out_6[4:3]), (z_out_9[4:3]), (z_out_3[4:3]),
      (z_out_8[4:3]), (z_out_8[3:2]), (z_out_3[3:2]), {and_dcpl_134 , COMP_LOOP_or_cse
      , COMP_LOOP_or_2_cse , COMP_LOOP_or_1_cse , COMP_LOOP_or_5_cse , COMP_LOOP_or_4_cse
      , COMP_LOOP_or_3_cse , and_dcpl_146 , COMP_LOOP_or_6_cse , COMP_LOOP_or_7_cse
      , and_dcpl_154});
  assign mux_50_nl = MUX_s_1_2_2(nor_44_cse, and_260_cse, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_nor_nl = ~(mux_50_nl | (fsm_output[8]) | (~ (fsm_output[1]))
      | (~ (fsm_output[0])) | (fsm_output[2]));
  assign COMP_LOOP_and_rmff = MUX_v_2_2_2(2'b00, COMP_LOOP_mux1h_nl, COMP_LOOP_twiddle_f_nor_nl);
  assign COMP_LOOP_twiddle_f_mux1h_57_nl = MUX1HOT_s_1_10_2((z_out_2[1]), (z_out_4[2]),
      (z_out_5_9_0[0]), (z_out_7_10_0[1]), (z_out_6[2]), (z_out_9[2]), (z_out_3[2]),
      (z_out_8[2]), (z_out_8[1]), (z_out_3[1]), {and_dcpl_134 , COMP_LOOP_or_cse
      , COMP_LOOP_or_2_cse , COMP_LOOP_or_1_cse , COMP_LOOP_or_4_cse , COMP_LOOP_or_3_cse
      , and_dcpl_146 , COMP_LOOP_or_6_cse , COMP_LOOP_or_7_cse , and_dcpl_154});
  assign mux_51_nl = MUX_s_1_2_2(and_dcpl_53, nor_tmp_16, fsm_output[5]);
  assign nor_43_nl = ~((fsm_output[5:3]!=3'b110));
  assign mux_52_nl = MUX_s_1_2_2(mux_51_nl, nor_43_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_mux1h_57_rmff = COMP_LOOP_twiddle_f_mux1h_57_nl & (~(mux_52_nl
      & (~ (fsm_output[8])) & nor_tmp_1 & (~ (fsm_output[2])) & (~ (fsm_output[6]))));
  assign and_177_nl = and_dcpl_135 & and_dcpl_28;
  assign COMP_LOOP_twiddle_f_mux1h_87_rmff = MUX1HOT_v_7_12_2(COMP_LOOP_3_twiddle_f_lshift_ncse_sva_6_0,
      (z_out_2[10:4]), (z_out_4[11:5]), (z_out_5_9_0[9:3]), (z_out_7_10_0[10:4]),
      (z_out_3[8:2]), (z_out_6[11:5]), (z_out_9[11:5]), (z_out_3[11:5]), (z_out_8[11:5]),
      (z_out_8[10:4]), (z_out_3[10:4]), {and_177_nl , and_dcpl_134 , COMP_LOOP_or_cse
      , COMP_LOOP_or_2_cse , COMP_LOOP_or_1_cse , COMP_LOOP_or_5_cse , COMP_LOOP_or_4_cse
      , COMP_LOOP_or_3_cse , and_dcpl_146 , COMP_LOOP_or_6_cse , COMP_LOOP_or_7_cse
      , and_dcpl_154});
  assign COMP_LOOP_twiddle_f_mux1h_111_nl = MUX1HOT_s_1_9_2((z_out_2[0]), (z_out_4[1]),
      (z_out_7_10_0[0]), (z_out_6[1]), (z_out_9[1]), (z_out_3[1]), (z_out_8[1]),
      (z_out_8[0]), (z_out_3[0]), {and_dcpl_134 , COMP_LOOP_or_cse , COMP_LOOP_or_1_cse
      , COMP_LOOP_or_4_cse , COMP_LOOP_or_3_cse , and_dcpl_146 , COMP_LOOP_or_6_cse
      , COMP_LOOP_or_7_cse , and_dcpl_154});
  assign mux_53_nl = MUX_s_1_2_2((~ (fsm_output[3])), (fsm_output[3]), fsm_output[4]);
  assign mux_54_nl = MUX_s_1_2_2(mux_53_nl, nor_tmp_16, fsm_output[5]);
  assign nor_41_nl = ~((fsm_output[5]) | (~ nor_tmp_16));
  assign mux_55_nl = MUX_s_1_2_2(mux_54_nl, nor_41_nl, fsm_output[6]);
  assign nor_42_nl = ~(((fsm_output[6:5]==2'b11)) | (fsm_output[4:3]!=2'b10));
  assign mux_56_nl = MUX_s_1_2_2(mux_55_nl, nor_42_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_mux1h_111_rmff = COMP_LOOP_twiddle_f_mux1h_111_nl &
      (~(mux_56_nl & and_dcpl_124));
  assign not_nl = ~ and_dcpl_142;
  assign COMP_LOOP_twiddle_help_mux_rmff = MUX_v_4_2_2(4'b0000, (z_out_2[3:0]), not_nl);
  assign COMP_LOOP_twiddle_f_mux1h_128_nl = MUX1HOT_s_1_5_2((z_out_4[0]), (z_out_6[0]),
      (z_out_9[0]), (z_out_3[0]), (z_out_8[0]), {COMP_LOOP_or_cse , COMP_LOOP_or_4_cse
      , COMP_LOOP_or_3_cse , and_dcpl_146 , COMP_LOOP_or_6_cse});
  assign and_277_nl = (~((fsm_output[5:4]==2'b11))) & (fsm_output[3]);
  assign mux_57_nl = MUX_s_1_2_2(or_289_cse, and_277_nl, fsm_output[6]);
  assign nor_40_nl = ~(and_260_cse | (fsm_output[3]));
  assign mux_58_nl = MUX_s_1_2_2(mux_57_nl, nor_40_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_mux1h_128_rmff = COMP_LOOP_twiddle_f_mux1h_128_nl &
      (~(mux_58_nl & and_dcpl_124));
  assign COMP_LOOP_twiddle_help_mux_1_rmff = MUX_v_8_2_2((z_out_2[11:4]), COMP_LOOP_17_twiddle_f_mul_psp_sva,
      and_dcpl_142);
  assign or_222_nl = (fsm_output[1]) | (~ (fsm_output[8]));
  assign mux_60_nl = MUX_s_1_2_2(or_222_nl, or_tmp_63, fsm_output[2]);
  assign mux_59_nl = MUX_s_1_2_2(or_dcpl_143, or_tmp_63, fsm_output[2]);
  assign mux_61_itm = MUX_s_1_2_2(mux_60_nl, mux_59_nl, or_169_cse);
  assign and_192_rmff = and_dcpl_33 & (fsm_output[2]);
  assign or_169_cse = (fsm_output[7:3]!=5'b00000);
  assign and_269_cse = (fsm_output[1]) & (fsm_output[8]);
  assign nor_117_cse = ~((fsm_output[8]) | (fsm_output[1]));
  assign and_272_cse = (fsm_output[5:4]==2'b11);
  assign and_218_nl = and_dcpl_208 & nor_tmp_16 & (~ (fsm_output[5])) & and_dcpl_3;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt = MUX_v_9_2_2(({5'b00000
      , z_out_10}), (z_out_1[8:0]), and_218_nl);
  assign or_306_cse = (fsm_output[3:2]!=2'b00);
  assign and_762_cse = (fsm_output[7]) & (fsm_output[4]) & or_306_cse;
  assign nl_COMP_LOOP_1_twiddle_f_mul_nl = (z_out_1[6:0]) * COMP_LOOP_k_12_5_sva_6_0;
  assign COMP_LOOP_1_twiddle_f_mul_nl = nl_COMP_LOOP_1_twiddle_f_mul_nl[6:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_9_nl = MUX_v_7_2_2(COMP_LOOP_1_twiddle_f_mul_nl,
      (z_out_11[6:0]), and_dcpl_32);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt = MUX_v_11_2_2(({4'b0000
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_9_nl}), COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1,
      and_dcpl_134);
  assign and_788_cse = (fsm_output[3:2]==2'b11);
  assign or_334_cse = (fsm_output[1:0]!=2'b01);
  assign nor_114_cse = ~((fsm_output[6:4]!=3'b000));
  assign nor_58_nl = ~((~((fsm_output[1:0]!=2'b00))) | (fsm_output[8]));
  assign mux_80_nl = MUX_s_1_2_2((fsm_output[8]), nor_58_nl, fsm_output[2]);
  assign nor_59_nl = ~(((VEC_LOOP_j_12_0_1_sva_1[12]) & (fsm_output[2:0]==3'b011))
      | (fsm_output[8]));
  assign or_258_nl = (fsm_output[6:3]!=4'b0000);
  assign mux_81_nl = MUX_s_1_2_2(mux_80_nl, nor_59_nl, or_258_nl);
  assign nor_60_nl = ~((~((fsm_output[3]) | (~ (VEC_LOOP_j_12_0_1_sva_1[12])) | (fsm_output[2:0]!=3'b011)))
      | (fsm_output[8]));
  assign mux_82_nl = MUX_s_1_2_2(mux_81_nl, nor_60_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & (~ mux_82_nl);
  assign VEC_LOOP_or_26_cse = and_dcpl_46 | and_dcpl_60 | and_dcpl_70 | and_dcpl_76
      | and_dcpl_84 | and_dcpl_90 | and_dcpl_97 | and_dcpl_103;
  assign and_241_ssc = and_dcpl_226 & and_dcpl_54;
  assign or_326_cse = (~ (fsm_output[0])) | (fsm_output[1]) | (~ (fsm_output[4]));
  assign or_324_nl = (~ (fsm_output[1])) | (fsm_output[4]);
  assign mux_cse = MUX_s_1_2_2(or_324_nl, (fsm_output[1]), fsm_output[0]);
  assign nand_1_nl = ~((fsm_output[6]) & ((fsm_output[5:4]!=2'b00) | and_788_cse));
  assign and_252_nl = (fsm_output[3]) & (VEC_LOOP_j_12_0_1_sva_1[12]) & (~ (fsm_output[2]))
      & nor_tmp_1;
  assign mux_92_nl = MUX_s_1_2_2(and_252_nl, and_788_cse, and_260_cse);
  assign mux_93_nl = MUX_s_1_2_2(nand_1_nl, mux_92_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_help_and_1_cse = complete_rsci_wen_comp & (mux_93_nl |
      (fsm_output[8]));
  assign and_260_cse = (fsm_output[6:4]==3'b111);
  assign nor_44_cse = ~((fsm_output[6:3]!=4'b0000));
  assign nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_2_sva_mx0w1 = nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1[11:0];
  assign nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_3_sva_mx0w2 = nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2[11:0];
  assign nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_4_sva_mx0w3 = nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3[11:0];
  assign nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_5_sva_mx0w4 = nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4[11:0];
  assign nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_6_sva_mx0w5 = nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5[11:0];
  assign nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_7_sva_mx0w6 = nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6[11:0];
  assign nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_8_sva_mx0w7 = nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7[11:0];
  assign nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_10_sva_mx0w9 = nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9[11:0];
  assign nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_11_sva_mx0w10 = nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10[11:0];
  assign nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_12_sva_mx0w11 = nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11[11:0];
  assign nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_13_sva_mx0w12 = nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12[11:0];
  assign nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_14_sva_mx0w13 = nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13[11:0];
  assign nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_15_sva_mx0w14 = nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14[11:0];
  assign nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_16_sva_mx0w15 = nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15[11:0];
  assign nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_18_sva_mx0w17 = nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17[11:0];
  assign nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_19_sva_mx0w18 = nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18[11:0];
  assign nl_VEC_LOOP_acc_10_cse_20_sva_mx0w19 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_20_sva_mx0w19 = nl_VEC_LOOP_acc_10_cse_20_sva_mx0w19[11:0];
  assign nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_21_sva_mx0w20 = nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20[11:0];
  assign nl_VEC_LOOP_acc_10_cse_22_sva_mx0w21 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_22_sva_mx0w21 = nl_VEC_LOOP_acc_10_cse_22_sva_mx0w21[11:0];
  assign nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_23_sva_mx0w22 = nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22[11:0];
  assign nl_VEC_LOOP_acc_10_cse_24_sva_mx0w23 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_24_sva_mx0w23 = nl_VEC_LOOP_acc_10_cse_24_sva_mx0w23[11:0];
  assign nl_VEC_LOOP_acc_10_cse_26_sva_mx0w25 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_26_sva_mx0w25 = nl_VEC_LOOP_acc_10_cse_26_sva_mx0w25[11:0];
  assign nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_27_sva_mx0w26 = nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26[11:0];
  assign nl_VEC_LOOP_acc_10_cse_28_sva_mx0w27 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_28_sva_mx0w27 = nl_VEC_LOOP_acc_10_cse_28_sva_mx0w27[11:0];
  assign nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_29_sva_mx0w28 = nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28[11:0];
  assign nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_30_sva_mx0w29 = nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29[11:0];
  assign nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_31_sva_mx0w30 = nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30[11:0];
  assign nl_VEC_LOOP_acc_10_cse_sva_mx0w31 = z_out_14 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_sva_mx0w31 = nl_VEC_LOOP_acc_10_cse_sva_mx0w31[11:0];
  assign nor_tmp_1 = (fsm_output[1:0]==2'b11);
  assign and_dcpl_3 = ~((fsm_output[7:6]!=2'b00));
  assign and_dcpl_7 = nor_117_cse & (~ (fsm_output[0]));
  assign or_dcpl_141 = (fsm_output[5:4]!=2'b00) | or_194_cse;
  assign or_dcpl_143 = (fsm_output[8]) | (fsm_output[1]);
  assign or_tmp_34 = (~ (fsm_output[0])) | (fsm_output[8]);
  assign or_tmp_36 = (fsm_output[0]) | (~ and_269_cse);
  assign and_dcpl_23 = (fsm_output[0]) & (fsm_output[2]);
  assign and_dcpl_28 = nor_46_cse & and_dcpl_3;
  assign and_dcpl_29 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_30 = nor_117_cse & (fsm_output[0]);
  assign and_dcpl_31 = and_dcpl_30 & and_dcpl_29;
  assign and_dcpl_32 = and_dcpl_31 & and_dcpl_28;
  assign and_dcpl_33 = (~ (fsm_output[8])) & (fsm_output[1]);
  assign and_dcpl_34 = and_dcpl_33 & (fsm_output[0]);
  assign and_dcpl_35 = and_dcpl_34 & and_dcpl_29;
  assign xor_dcpl = ((fsm_output[5:3]!=3'b000) | or_194_cse) ^ (fsm_output[8]);
  assign and_dcpl_39 = xor_dcpl & (fsm_output[2:0]==3'b010);
  assign and_dcpl_41 = and_dcpl_30 & and_788_cse;
  assign and_dcpl_42 = and_dcpl_41 & and_dcpl_28;
  assign and_dcpl_44 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_45 = and_dcpl_44 & and_dcpl_3;
  assign and_dcpl_46 = and_dcpl_31 & and_dcpl_45;
  assign and_dcpl_48 = and_dcpl_34 & and_dcpl_29 & (fsm_output[4]);
  assign and_dcpl_49 = and_dcpl_41 & and_dcpl_45;
  assign and_dcpl_50 = (fsm_output[5:4]==2'b10);
  assign and_dcpl_51 = and_dcpl_50 & and_dcpl_3;
  assign and_dcpl_52 = and_dcpl_31 & and_dcpl_51;
  assign and_dcpl_53 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_54 = and_dcpl_53 & (fsm_output[5]);
  assign and_dcpl_55 = and_dcpl_33 & and_dcpl_23;
  assign and_dcpl_56 = and_dcpl_55 & and_dcpl_54;
  assign and_dcpl_57 = and_dcpl_41 & and_dcpl_51;
  assign and_dcpl_59 = and_272_cse & and_dcpl_3;
  assign and_dcpl_60 = and_dcpl_31 & and_dcpl_59;
  assign and_dcpl_61 = and_dcpl_41 & and_dcpl_59;
  assign and_dcpl_62 = (fsm_output[7:6]==2'b01);
  assign and_dcpl_63 = nor_46_cse & and_dcpl_62;
  assign and_dcpl_64 = and_dcpl_31 & and_dcpl_63;
  assign and_dcpl_66 = and_dcpl_53 & (fsm_output[6:5]==2'b10);
  assign and_dcpl_67 = and_dcpl_55 & and_dcpl_66;
  assign and_dcpl_68 = and_dcpl_41 & and_dcpl_63;
  assign and_dcpl_69 = and_dcpl_44 & and_dcpl_62;
  assign and_dcpl_70 = and_dcpl_31 & and_dcpl_69;
  assign and_dcpl_71 = and_dcpl_41 & and_dcpl_69;
  assign and_dcpl_72 = and_dcpl_50 & and_dcpl_62;
  assign and_dcpl_73 = and_dcpl_31 & and_dcpl_72;
  assign and_dcpl_74 = and_dcpl_41 & and_dcpl_72;
  assign and_dcpl_75 = and_272_cse & and_dcpl_62;
  assign and_dcpl_76 = and_dcpl_31 & and_dcpl_75;
  assign and_dcpl_77 = and_dcpl_41 & and_dcpl_75;
  assign and_dcpl_78 = (fsm_output[7:6]==2'b10);
  assign and_dcpl_79 = nor_46_cse & and_dcpl_78;
  assign and_dcpl_80 = and_dcpl_31 & and_dcpl_79;
  assign and_dcpl_81 = and_dcpl_35 & and_dcpl_79;
  assign and_dcpl_82 = and_dcpl_41 & and_dcpl_79;
  assign and_dcpl_83 = and_dcpl_44 & and_dcpl_78;
  assign and_dcpl_84 = and_dcpl_31 & and_dcpl_83;
  assign and_dcpl_85 = and_dcpl_41 & and_dcpl_83;
  assign and_dcpl_86 = and_dcpl_50 & and_dcpl_78;
  assign and_dcpl_87 = and_dcpl_31 & and_dcpl_86;
  assign and_dcpl_88 = and_dcpl_41 & and_dcpl_86;
  assign and_dcpl_89 = and_272_cse & and_dcpl_78;
  assign and_dcpl_90 = and_dcpl_31 & and_dcpl_89;
  assign and_dcpl_91 = and_dcpl_41 & and_dcpl_89;
  assign and_dcpl_92 = (fsm_output[7:6]==2'b11);
  assign and_dcpl_93 = nor_46_cse & and_dcpl_92;
  assign and_dcpl_94 = and_dcpl_31 & and_dcpl_93;
  assign and_dcpl_95 = and_dcpl_41 & and_dcpl_93;
  assign and_dcpl_96 = and_dcpl_44 & and_dcpl_92;
  assign and_dcpl_97 = and_dcpl_31 & and_dcpl_96;
  assign and_dcpl_98 = and_dcpl_41 & and_dcpl_96;
  assign and_dcpl_99 = and_dcpl_50 & and_dcpl_92;
  assign and_dcpl_100 = and_dcpl_31 & and_dcpl_99;
  assign and_dcpl_101 = and_dcpl_41 & and_dcpl_99;
  assign and_dcpl_102 = and_272_cse & and_dcpl_92;
  assign and_dcpl_103 = and_dcpl_31 & and_dcpl_102;
  assign and_dcpl_104 = and_dcpl_41 & and_dcpl_102;
  assign and_dcpl_106 = (~ (fsm_output[8])) & (fsm_output[0]) & (fsm_output[2]);
  assign nor_tmp_10 = (fsm_output[3]) & (fsm_output[1]);
  assign or_tmp_38 = (~ (fsm_output[3])) | (fsm_output[1]);
  assign and_dcpl_123 = (fsm_output[0]) & (~ (fsm_output[2]));
  assign and_dcpl_124 = and_dcpl_33 & and_dcpl_123;
  assign nand_8_cse = ~((fsm_output[6:4]==3'b111));
  assign and_dcpl_127 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_133 = and_dcpl_34 & (fsm_output[3:2]==2'b10);
  assign and_dcpl_134 = and_dcpl_133 & and_dcpl_28;
  assign and_dcpl_135 = and_dcpl_34 & and_dcpl_127;
  assign and_dcpl_142 = and_dcpl_135 & and_dcpl_63;
  assign and_dcpl_146 = and_dcpl_135 & and_dcpl_72;
  assign and_dcpl_154 = and_dcpl_135 & and_dcpl_86;
  assign nor_tmp_16 = (fsm_output[4:3]==2'b11);
  assign and_dcpl_177 = (fsm_output[8]) & (~ (fsm_output[1])) & (fsm_output[0]) &
      and_dcpl_29;
  assign or_tmp_63 = (~ (fsm_output[0])) | (~ (fsm_output[1])) | (fsm_output[8]);
  assign and_dcpl_183 = and_dcpl_34 & and_dcpl_29 & (fsm_output[7]);
  assign and_dcpl_185 = (~ (fsm_output[0])) & (fsm_output[2]);
  assign and_dcpl_186 = and_dcpl_33 & and_dcpl_185;
  assign and_268_nl = ((fsm_output[1:0]!=2'b00)) & (fsm_output[8]);
  assign mux_65_nl = MUX_s_1_2_2(nor_117_cse, and_268_nl, fsm_output[2]);
  assign mux_tmp_66 = MUX_s_1_2_2(mux_65_nl, (fsm_output[8]), or_169_cse);
  assign and_dcpl_208 = and_dcpl_34 & (~ (fsm_output[2])) & (VEC_LOOP_j_12_0_1_sva_1[12]);
  assign and_dcpl_220 = and_dcpl_208 & (fsm_output[5:3]==3'b001) & and_dcpl_3;
  assign and_tmp_12 = (fsm_output[4]) & or_306_cse;
  assign and_dcpl_226 = ((fsm_output[1]) ^ (fsm_output[0])) & (~ (fsm_output[8]))
      & (fsm_output[2]);
  assign and_dcpl_236 = nand_8_cse & and_dcpl_33 & and_dcpl_123 & (VEC_LOOP_j_12_0_1_sva_1[12])
      & (fsm_output[3]) & (fsm_output[7]);
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_177 & and_dcpl_28;
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c1 = nor_117_cse & and_dcpl_185;
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ z_out_10)}) + 5'b00001;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign VEC_LOOP_or_7_cse = and_dcpl_32 | and_dcpl_49 | and_dcpl_57 | and_dcpl_61
      | and_dcpl_68 | and_dcpl_71 | and_dcpl_74 | and_dcpl_77 | and_dcpl_82 | and_dcpl_85
      | and_dcpl_88 | and_dcpl_91 | and_dcpl_95 | and_dcpl_98 | and_dcpl_101 | and_dcpl_104;
  assign VEC_LOOP_or_9_cse = and_dcpl_52 | and_dcpl_73 | and_dcpl_87 | and_dcpl_100;
  assign VEC_LOOP_or_28_cse = and_dcpl_64 | and_dcpl_94;
  assign VEC_LOOP_or_19_cse = and_dcpl_42 | and_dcpl_64 | and_dcpl_80 | and_dcpl_94;
  assign or_187_cse = (fsm_output[7:4]!=4'b0000);
  assign VEC_LOOP_mux1h_10_nl = MUX1HOT_v_8_6_2((z_out_13[11:4]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[11:4]),
      (z_out_17[10:3]), (z_out_11[9:2]), (z_out_11[8:1]), (z_out_11[7:0]), {VEC_LOOP_or_7_cse
      , and_dcpl_42 , VEC_LOOP_or_26_cse , VEC_LOOP_or_9_cse , VEC_LOOP_or_28_cse
      , and_dcpl_80});
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_s_1_6_2((z_out_13[3]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[3]),
      (z_out_17[2]), (z_out_11[1]), (z_out_11[0]), (VEC_LOOP_acc_1_cse_10_sva[3]),
      {VEC_LOOP_or_7_cse , and_dcpl_42 , VEC_LOOP_or_26_cse , VEC_LOOP_or_9_cse ,
      VEC_LOOP_or_28_cse , and_dcpl_80});
  assign and_125_nl = and_dcpl_31 & nor_46_cse & or_194_cse;
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_5_2((z_out_13[2]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[2]),
      (z_out_17[1]), (z_out_11[0]), (VEC_LOOP_acc_1_cse_10_sva[2]), {VEC_LOOP_or_7_cse
      , and_dcpl_42 , VEC_LOOP_or_26_cse , VEC_LOOP_or_9_cse , and_125_nl});
  assign and_122_nl = and_dcpl_31 & or_193_cse & (~ (fsm_output[4]));
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_4_2((z_out_13[1]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[1]),
      (z_out_17[0]), (VEC_LOOP_acc_1_cse_10_sva[1]), {VEC_LOOP_or_7_cse , and_dcpl_42
      , VEC_LOOP_or_26_cse , and_122_nl});
  assign and_119_nl = or_dcpl_141 & (~ (fsm_output[8])) & (~ (fsm_output[1])) & (fsm_output[0])
      & and_dcpl_29;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_3_2((z_out_13[0]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[0]),
      (VEC_LOOP_acc_1_cse_10_sva[0]), {VEC_LOOP_or_7_cse , and_dcpl_42 , and_119_nl});
  assign and_44_nl = and_dcpl_35 & and_dcpl_28;
  assign and_51_nl = and_dcpl_34 & and_788_cse;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_7_36_2((z_out_11[6:0]), COMP_LOOP_3_twiddle_f_lshift_ncse_sva_6_0,
      (VEC_LOOP_acc_10_cse_1_sva[11:5]), (z_out_13[11:5]), (VEC_LOOP_acc_1_cse_10_sva[11:5]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[11:5]), ({VEC_LOOP_acc_11_psp_sva_10 , VEC_LOOP_acc_11_psp_sva_9
      , (VEC_LOOP_acc_11_psp_sva_8_0[8:4])}), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[11:5]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[11:5]), ({VEC_LOOP_acc_11_psp_sva_9 , (VEC_LOOP_acc_11_psp_sva_8_0[8:3])}),
      (VEC_LOOP_acc_10_cse_6_sva_mx0w5[11:5]), (VEC_LOOP_acc_10_cse_7_sva_mx0w6[11:5]),
      (VEC_LOOP_acc_10_cse_8_sva_mx0w7[11:5]), (VEC_LOOP_acc_11_psp_sva_8_0[8:2]),
      (VEC_LOOP_acc_10_cse_10_sva_mx0w9[11:5]), (VEC_LOOP_acc_10_cse_11_sva_mx0w10[11:5]),
      (VEC_LOOP_acc_10_cse_12_sva_mx0w11[11:5]), (VEC_LOOP_acc_10_cse_13_sva_mx0w12[11:5]),
      (VEC_LOOP_acc_10_cse_14_sva_mx0w13[11:5]), (VEC_LOOP_acc_10_cse_15_sva_mx0w14[11:5]),
      (VEC_LOOP_acc_10_cse_16_sva_mx0w15[11:5]), (COMP_LOOP_17_twiddle_f_mul_psp_sva[7:1]),
      (VEC_LOOP_acc_10_cse_18_sva_mx0w17[11:5]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[11:5]),
      (VEC_LOOP_acc_10_cse_20_sva_mx0w19[11:5]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[11:5]),
      (VEC_LOOP_acc_10_cse_22_sva_mx0w21[11:5]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[11:5]),
      (VEC_LOOP_acc_10_cse_24_sva_mx0w23[11:5]), (VEC_LOOP_acc_10_cse_26_sva_mx0w25[11:5]),
      (VEC_LOOP_acc_10_cse_27_sva_mx0w26[11:5]), (VEC_LOOP_acc_10_cse_28_sva_mx0w27[11:5]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[11:5]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[11:5]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[11:5]), (VEC_LOOP_acc_10_cse_sva_mx0w31[11:5]),
      {and_dcpl_32 , and_44_nl , and_dcpl_39 , VEC_LOOP_or_19_cse , and_51_nl , and_dcpl_46
      , and_dcpl_48 , and_dcpl_49 , and_dcpl_52 , and_dcpl_56 , and_dcpl_57 , and_dcpl_60
      , and_dcpl_61 , and_dcpl_67 , and_dcpl_68 , and_dcpl_70 , and_dcpl_71 , and_dcpl_73
      , and_dcpl_74 , and_dcpl_76 , and_dcpl_77 , and_dcpl_81 , and_dcpl_82 , and_dcpl_84
      , and_dcpl_85 , and_dcpl_87 , and_dcpl_88 , and_dcpl_90 , and_dcpl_91 , and_dcpl_95
      , and_dcpl_97 , and_dcpl_98 , and_dcpl_100 , and_dcpl_101 , and_dcpl_103 ,
      and_dcpl_104});
  assign mux_39_nl = MUX_s_1_2_2(or_tmp_38, nor_tmp_10, or_187_cse);
  assign and_115_nl = mux_39_nl & and_dcpl_106;
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_34_2((VEC_LOOP_acc_1_cse_10_sva[4]), (VEC_LOOP_acc_10_cse_1_sva[4]),
      (z_out_13[4]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[4]), (VEC_LOOP_acc_11_psp_sva_8_0[3]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[4]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[4]),
      (VEC_LOOP_acc_11_psp_sva_8_0[2]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[4]), (VEC_LOOP_acc_10_cse_7_sva_mx0w6[4]),
      (VEC_LOOP_acc_10_cse_8_sva_mx0w7[4]), (VEC_LOOP_acc_11_psp_sva_8_0[1]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[4]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[4]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[4]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[4]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[4]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[4]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[4]),
      (COMP_LOOP_17_twiddle_f_mul_psp_sva[0]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[4]),
      (VEC_LOOP_acc_10_cse_19_sva_mx0w18[4]), (VEC_LOOP_acc_10_cse_20_sva_mx0w19[4]),
      (VEC_LOOP_acc_10_cse_21_sva_mx0w20[4]), (VEC_LOOP_acc_10_cse_22_sva_mx0w21[4]),
      (VEC_LOOP_acc_10_cse_23_sva_mx0w22[4]), (VEC_LOOP_acc_10_cse_24_sva_mx0w23[4]),
      (VEC_LOOP_acc_10_cse_26_sva_mx0w25[4]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[4]),
      (VEC_LOOP_acc_10_cse_28_sva_mx0w27[4]), (VEC_LOOP_acc_10_cse_29_sva_mx0w28[4]),
      (VEC_LOOP_acc_10_cse_30_sva_mx0w29[4]), (VEC_LOOP_acc_10_cse_31_sva_mx0w30[4]),
      (VEC_LOOP_acc_10_cse_sva_mx0w31[4]), {and_115_nl , and_dcpl_39 , VEC_LOOP_or_19_cse
      , and_dcpl_46 , and_dcpl_48 , and_dcpl_49 , and_dcpl_52 , and_dcpl_56 , and_dcpl_57
      , and_dcpl_60 , and_dcpl_61 , and_dcpl_67 , and_dcpl_68 , and_dcpl_70 , and_dcpl_71
      , and_dcpl_73 , and_dcpl_74 , and_dcpl_76 , and_dcpl_77 , and_dcpl_81 , and_dcpl_82
      , and_dcpl_84 , and_dcpl_85 , and_dcpl_87 , and_dcpl_88 , and_dcpl_90 , and_dcpl_91
      , and_dcpl_95 , and_dcpl_97 , and_dcpl_98 , and_dcpl_100 , and_dcpl_101 , and_dcpl_103
      , and_dcpl_104});
  assign mux_40_nl = MUX_s_1_2_2(or_tmp_38, nor_tmp_10, or_191_cse);
  assign and_264_nl = (nor_114_cse | (fsm_output[3])) & (fsm_output[1]);
  assign mux_41_nl = MUX_s_1_2_2(mux_40_nl, and_264_nl, fsm_output[7]);
  assign and_120_nl = mux_41_nl & and_dcpl_106;
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_33_2((VEC_LOOP_acc_1_cse_10_sva[3]), (VEC_LOOP_acc_10_cse_1_sva[3]),
      (z_out_13[3]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[3]), (VEC_LOOP_acc_11_psp_sva_8_0[2]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[3]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[3]),
      (VEC_LOOP_acc_11_psp_sva_8_0[1]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[3]), (VEC_LOOP_acc_10_cse_7_sva_mx0w6[3]),
      (VEC_LOOP_acc_10_cse_8_sva_mx0w7[3]), (VEC_LOOP_acc_11_psp_sva_8_0[0]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[3]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[3]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[3]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[3]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[3]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[3]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[3]),
      (VEC_LOOP_acc_10_cse_18_sva_mx0w17[3]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[3]),
      (VEC_LOOP_acc_10_cse_20_sva_mx0w19[3]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[3]),
      (VEC_LOOP_acc_10_cse_22_sva_mx0w21[3]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[3]),
      (VEC_LOOP_acc_10_cse_24_sva_mx0w23[3]), (VEC_LOOP_acc_10_cse_26_sva_mx0w25[3]),
      (VEC_LOOP_acc_10_cse_27_sva_mx0w26[3]), (VEC_LOOP_acc_10_cse_28_sva_mx0w27[3]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[3]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[3]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[3]), (VEC_LOOP_acc_10_cse_sva_mx0w31[3]),
      {and_120_nl , and_dcpl_39 , VEC_LOOP_or_19_cse , and_dcpl_46 , and_dcpl_48
      , and_dcpl_49 , and_dcpl_52 , and_dcpl_56 , and_dcpl_57 , and_dcpl_60 , and_dcpl_61
      , and_dcpl_67 , and_dcpl_68 , and_dcpl_70 , and_dcpl_71 , and_dcpl_73 , and_dcpl_74
      , and_dcpl_76 , and_dcpl_77 , and_dcpl_82 , and_dcpl_84 , and_dcpl_85 , and_dcpl_87
      , and_dcpl_88 , and_dcpl_90 , and_dcpl_91 , and_dcpl_95 , and_dcpl_97 , and_dcpl_98
      , and_dcpl_100 , and_dcpl_101 , and_dcpl_103 , and_dcpl_104});
  assign or_197_nl = (fsm_output[5:4]!=2'b00);
  assign mux_42_nl = MUX_s_1_2_2(or_tmp_38, nor_tmp_10, or_197_nl);
  assign and_263_nl = or_289_cse & (fsm_output[1]);
  assign mux_43_nl = MUX_s_1_2_2(mux_42_nl, and_263_nl, or_194_cse);
  assign and_123_nl = mux_43_nl & and_dcpl_106;
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_32_2((VEC_LOOP_acc_1_cse_10_sva[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_13[2]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[2]), (VEC_LOOP_acc_11_psp_sva_8_0[1]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[2]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[2]),
      (VEC_LOOP_acc_11_psp_sva_8_0[0]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[2]), (VEC_LOOP_acc_10_cse_7_sva_mx0w6[2]),
      (VEC_LOOP_acc_10_cse_8_sva_mx0w7[2]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[2]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[2]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[2]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[2]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[2]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[2]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[2]),
      (VEC_LOOP_acc_10_cse_18_sva_mx0w17[2]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[2]),
      (VEC_LOOP_acc_10_cse_20_sva_mx0w19[2]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[2]),
      (VEC_LOOP_acc_10_cse_22_sva_mx0w21[2]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[2]),
      (VEC_LOOP_acc_10_cse_24_sva_mx0w23[2]), (VEC_LOOP_acc_10_cse_26_sva_mx0w25[2]),
      (VEC_LOOP_acc_10_cse_27_sva_mx0w26[2]), (VEC_LOOP_acc_10_cse_28_sva_mx0w27[2]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[2]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[2]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[2]), (VEC_LOOP_acc_10_cse_sva_mx0w31[2]),
      {and_123_nl , and_dcpl_39 , VEC_LOOP_or_19_cse , and_dcpl_46 , and_dcpl_48
      , and_dcpl_49 , and_dcpl_52 , and_dcpl_56 , and_dcpl_57 , and_dcpl_60 , and_dcpl_61
      , and_dcpl_68 , and_dcpl_70 , and_dcpl_71 , and_dcpl_73 , and_dcpl_74 , and_dcpl_76
      , and_dcpl_77 , and_dcpl_82 , and_dcpl_84 , and_dcpl_85 , and_dcpl_87 , and_dcpl_88
      , and_dcpl_90 , and_dcpl_91 , and_dcpl_95 , and_dcpl_97 , and_dcpl_98 , and_dcpl_100
      , and_dcpl_101 , and_dcpl_103 , and_dcpl_104});
  assign mux_44_nl = MUX_s_1_2_2(or_tmp_38, nor_tmp_10, fsm_output[4]);
  assign and_262_nl = ((fsm_output[4:3]!=2'b10)) & (fsm_output[1]);
  assign mux_45_nl = MUX_s_1_2_2(mux_44_nl, and_262_nl, or_193_cse);
  assign and_126_nl = mux_45_nl & and_dcpl_106;
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_31_2((VEC_LOOP_acc_1_cse_10_sva[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_13[1]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[1]), (VEC_LOOP_acc_11_psp_sva_8_0[0]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[1]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[1]),
      (VEC_LOOP_acc_10_cse_6_sva_mx0w5[1]), (VEC_LOOP_acc_10_cse_7_sva_mx0w6[1]),
      (VEC_LOOP_acc_10_cse_8_sva_mx0w7[1]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[1]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[1]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[1]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[1]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[1]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[1]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[1]),
      (VEC_LOOP_acc_10_cse_18_sva_mx0w17[1]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[1]),
      (VEC_LOOP_acc_10_cse_20_sva_mx0w19[1]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[1]),
      (VEC_LOOP_acc_10_cse_22_sva_mx0w21[1]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[1]),
      (VEC_LOOP_acc_10_cse_24_sva_mx0w23[1]), (VEC_LOOP_acc_10_cse_26_sva_mx0w25[1]),
      (VEC_LOOP_acc_10_cse_27_sva_mx0w26[1]), (VEC_LOOP_acc_10_cse_28_sva_mx0w27[1]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[1]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[1]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[1]), (VEC_LOOP_acc_10_cse_sva_mx0w31[1]),
      {and_126_nl , and_dcpl_39 , VEC_LOOP_or_19_cse , and_dcpl_46 , and_dcpl_48
      , and_dcpl_49 , and_dcpl_52 , and_dcpl_57 , and_dcpl_60 , and_dcpl_61 , and_dcpl_68
      , and_dcpl_70 , and_dcpl_71 , and_dcpl_73 , and_dcpl_74 , and_dcpl_76 , and_dcpl_77
      , and_dcpl_82 , and_dcpl_84 , and_dcpl_85 , and_dcpl_87 , and_dcpl_88 , and_dcpl_90
      , and_dcpl_91 , and_dcpl_95 , and_dcpl_97 , and_dcpl_98 , and_dcpl_100 , and_dcpl_101
      , and_dcpl_103 , and_dcpl_104});
  assign and_129_nl = ((and_dcpl_53 & (~ (fsm_output[5])) & and_dcpl_3) | (fsm_output[1]))
      & and_dcpl_106;
  assign VEC_LOOP_mux1h_9_nl = MUX1HOT_s_1_30_2((VEC_LOOP_acc_1_cse_10_sva[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_13[0]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[0]), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[0]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[0]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[0]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[0]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[0]),
      (VEC_LOOP_acc_10_cse_10_sva_mx0w9[0]), (VEC_LOOP_acc_10_cse_11_sva_mx0w10[0]),
      (VEC_LOOP_acc_10_cse_12_sva_mx0w11[0]), (VEC_LOOP_acc_10_cse_13_sva_mx0w12[0]),
      (VEC_LOOP_acc_10_cse_14_sva_mx0w13[0]), (VEC_LOOP_acc_10_cse_15_sva_mx0w14[0]),
      (VEC_LOOP_acc_10_cse_16_sva_mx0w15[0]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[0]),
      (VEC_LOOP_acc_10_cse_19_sva_mx0w18[0]), (VEC_LOOP_acc_10_cse_20_sva_mx0w19[0]),
      (VEC_LOOP_acc_10_cse_21_sva_mx0w20[0]), (VEC_LOOP_acc_10_cse_22_sva_mx0w21[0]),
      (VEC_LOOP_acc_10_cse_23_sva_mx0w22[0]), (VEC_LOOP_acc_10_cse_24_sva_mx0w23[0]),
      (VEC_LOOP_acc_10_cse_26_sva_mx0w25[0]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[0]),
      (VEC_LOOP_acc_10_cse_28_sva_mx0w27[0]), (VEC_LOOP_acc_10_cse_29_sva_mx0w28[0]),
      (VEC_LOOP_acc_10_cse_30_sva_mx0w29[0]), (VEC_LOOP_acc_10_cse_31_sva_mx0w30[0]),
      (VEC_LOOP_acc_10_cse_sva_mx0w31[0]), {and_129_nl , and_dcpl_39 , VEC_LOOP_or_19_cse
      , and_dcpl_46 , and_dcpl_49 , and_dcpl_52 , and_dcpl_57 , and_dcpl_60 , and_dcpl_61
      , and_dcpl_68 , and_dcpl_70 , and_dcpl_71 , and_dcpl_73 , and_dcpl_74 , and_dcpl_76
      , and_dcpl_77 , and_dcpl_82 , and_dcpl_84 , and_dcpl_85 , and_dcpl_87 , and_dcpl_88
      , and_dcpl_90 , and_dcpl_91 , and_dcpl_95 , and_dcpl_97 , and_dcpl_98 , and_dcpl_100
      , and_dcpl_101 , and_dcpl_103 , and_dcpl_104});
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
  assign and_dcpl_274 = (~ (fsm_output[8])) & (fsm_output[1]) & (fsm_output[0]) &
      (~ (fsm_output[2])) & (fsm_output[3]) & nor_46_cse & and_dcpl_3;
  assign and_dcpl_280 = (fsm_output[1]) & (~ (fsm_output[8])) & (fsm_output[0]);
  assign and_dcpl_282 = and_dcpl_280 & (fsm_output[3:2]==2'b10) & and_272_cse & (fsm_output[7:6]==2'b00);
  assign and_dcpl_287 = and_dcpl_280 & (fsm_output[3:2]==2'b00);
  assign and_dcpl_288 = and_dcpl_287 & and_dcpl_50 & (fsm_output[7:6]==2'b01);
  assign and_dcpl_291 = and_dcpl_287 & and_dcpl_50 & and_dcpl_78;
  assign and_dcpl_293 = and_dcpl_287 & and_272_cse & and_dcpl_78;
  assign and_dcpl_304 = and_dcpl_287 & and_dcpl_50 & and_dcpl_3;
  assign and_dcpl_307 = and_dcpl_287 & (fsm_output[5:4]==2'b11) & and_dcpl_3;
  assign and_dcpl_312 = and_dcpl_280 & (fsm_output[3:2]==2'b10) & and_dcpl_50 & (fsm_output[7:6]==2'b10);
  assign and_dcpl_319 = and_dcpl_280 & (fsm_output[3:2]==2'b10);
  assign and_dcpl_320 = and_dcpl_319 & and_dcpl_44 & (fsm_output[7:6]==2'b00);
  assign and_dcpl_323 = and_dcpl_319 & and_dcpl_44 & (fsm_output[7:6]==2'b01);
  assign and_dcpl_328 = and_dcpl_287 & and_dcpl_44 & (fsm_output[7:6]==2'b10);
  assign and_dcpl_331 = and_dcpl_287 & and_dcpl_44 & (fsm_output[7:6]==2'b11);
  assign and_dcpl_358 = and_dcpl_319 & and_dcpl_50 & (fsm_output[7:6]==2'b00);
  assign and_dcpl_362 = and_dcpl_319 & (fsm_output[5:4]==2'b00) & and_dcpl_62;
  assign and_dcpl_364 = and_dcpl_319 & and_dcpl_50 & and_dcpl_62;
  assign and_dcpl_369 = and_dcpl_280 & (fsm_output[3:2]==2'b00) & and_dcpl_50 & (fsm_output[7:6]==2'b11);
  assign and_dcpl_377 = and_dcpl_287 & and_272_cse & (fsm_output[7:6]==2'b01);
  assign and_dcpl_381 = and_dcpl_287 & nor_46_cse & and_dcpl_78;
  assign and_dcpl_385 = and_dcpl_280 & (fsm_output[3:2]==2'b10) & and_272_cse & and_dcpl_78;
  assign and_dcpl_388 = and_dcpl_287 & nor_46_cse & (fsm_output[7:6]==2'b11);
  assign and_dcpl_401 = and_dcpl_319 & (fsm_output[5:4]==2'b11) & and_dcpl_62;
  assign and_dcpl_405 = and_dcpl_319 & (fsm_output[7:4]==4'b1000);
  assign and_dcpl_409 = and_dcpl_319 & (fsm_output[7:4]==4'b1110);
  assign and_dcpl_422 = ~((fsm_output!=9'b000000010));
  assign and_dcpl_429 = nor_117_cse & (fsm_output[0]) & (fsm_output[2]) & (~ (fsm_output[3]));
  assign and_dcpl_430 = and_dcpl_429 & nor_46_cse & and_dcpl_3;
  assign and_dcpl_433 = and_dcpl_429 & nor_46_cse & and_dcpl_78;
  assign and_dcpl_436 = and_dcpl_429 & and_dcpl_50 & and_dcpl_3;
  assign and_dcpl_439 = and_dcpl_429 & and_dcpl_50 & and_dcpl_62;
  assign and_dcpl_441 = and_dcpl_429 & and_dcpl_50 & and_dcpl_78;
  assign and_dcpl_444 = and_dcpl_429 & and_dcpl_50 & and_dcpl_92;
  assign and_dcpl_446 = and_dcpl_429 & nor_46_cse & and_dcpl_62;
  assign and_dcpl_448 = and_dcpl_429 & nor_46_cse & and_dcpl_92;
  assign and_dcpl_453 = nor_117_cse & (~ (fsm_output[0])) & (fsm_output[2]) & (fsm_output[3]);
  assign and_dcpl_454 = and_dcpl_453 & and_272_cse & and_dcpl_92;
  assign and_dcpl_456 = and_dcpl_453 & and_272_cse & and_dcpl_3;
  assign and_dcpl_458 = and_dcpl_453 & and_272_cse & and_dcpl_78;
  assign and_dcpl_460 = and_dcpl_453 & and_272_cse & and_dcpl_62;
  assign and_dcpl_463 = nor_46_cse & (fsm_output[7:6]==2'b00);
  assign and_dcpl_467 = (~ (fsm_output[8])) & (~ (fsm_output[1])) & (fsm_output[0])
      & and_dcpl_29;
  assign and_dcpl_468 = and_dcpl_467 & and_dcpl_463;
  assign and_dcpl_471 = and_dcpl_467 & nor_46_cse & (fsm_output[7:6]==2'b01);
  assign and_dcpl_474 = and_dcpl_467 & nor_46_cse & (fsm_output[7:6]==2'b10);
  assign and_dcpl_477 = and_dcpl_467 & nor_46_cse & (fsm_output[7:6]==2'b11);
  assign and_dcpl_481 = (fsm_output[8]) & (~ (fsm_output[1])) & (~ (fsm_output[0]))
      & and_dcpl_29 & and_dcpl_463;
  assign and_dcpl_488 = and_dcpl_30 & (fsm_output[3:2]==2'b11);
  assign and_dcpl_489 = and_dcpl_488 & and_dcpl_28;
  assign and_dcpl_492 = and_dcpl_488 & and_dcpl_44 & and_dcpl_3;
  assign and_dcpl_495 = and_dcpl_488 & and_dcpl_50 & and_dcpl_3;
  assign and_dcpl_498 = and_dcpl_488 & and_272_cse & and_dcpl_3;
  assign and_dcpl_501 = and_dcpl_488 & and_dcpl_63;
  assign and_dcpl_503 = and_dcpl_488 & and_dcpl_44 & and_dcpl_62;
  assign and_dcpl_505 = and_dcpl_488 & and_dcpl_50 & and_dcpl_62;
  assign and_dcpl_507 = and_dcpl_488 & and_272_cse & and_dcpl_62;
  assign and_dcpl_510 = and_dcpl_488 & and_dcpl_79;
  assign and_dcpl_512 = and_dcpl_488 & and_dcpl_44 & and_dcpl_78;
  assign and_dcpl_514 = and_dcpl_488 & and_dcpl_50 & and_dcpl_78;
  assign and_dcpl_516 = and_dcpl_488 & and_272_cse & and_dcpl_78;
  assign and_dcpl_519 = and_dcpl_488 & and_dcpl_93;
  assign and_dcpl_521 = and_dcpl_488 & and_dcpl_44 & and_dcpl_92;
  assign and_dcpl_523 = and_dcpl_488 & and_dcpl_50 & and_dcpl_92;
  assign and_dcpl_525 = and_dcpl_488 & and_272_cse & and_dcpl_92;
  assign and_dcpl_527 = and_dcpl_30 & (fsm_output[3:2]==2'b01);
  assign and_dcpl_528 = and_dcpl_527 & and_dcpl_28;
  assign and_dcpl_529 = and_dcpl_527 & and_dcpl_63;
  assign and_dcpl_530 = and_dcpl_527 & and_dcpl_79;
  assign and_dcpl_531 = and_dcpl_527 & and_dcpl_93;
  assign and_dcpl_598 = and_dcpl_7 & (fsm_output[3:2]==2'b01);
  assign and_dcpl_599 = and_dcpl_598 & and_dcpl_99;
  assign and_dcpl_604 = and_dcpl_7 & (fsm_output[3:2]==2'b11);
  assign and_dcpl_605 = and_dcpl_604 & nor_46_cse & and_dcpl_3;
  assign and_dcpl_608 = and_dcpl_598 & nor_46_cse & and_dcpl_62;
  assign and_dcpl_611 = and_dcpl_598 & and_272_cse & and_dcpl_3;
  assign and_dcpl_613 = and_dcpl_604 & and_dcpl_51;
  assign and_dcpl_614 = and_dcpl_598 & and_dcpl_51;
  assign and_dcpl_616 = and_dcpl_598 & and_272_cse & and_dcpl_92;
  assign and_dcpl_617 = and_dcpl_604 & and_dcpl_99;
  assign and_dcpl_620 = and_dcpl_598 & and_dcpl_44 & and_dcpl_92;
  assign and_dcpl_622 = and_dcpl_604 & and_dcpl_93;
  assign and_dcpl_623 = and_dcpl_598 & and_dcpl_93;
  assign and_dcpl_626 = and_dcpl_598 & and_272_cse & and_dcpl_78;
  assign and_dcpl_628 = and_dcpl_598 & and_dcpl_44 & and_dcpl_62;
  assign and_dcpl_630 = and_dcpl_604 & and_dcpl_86;
  assign and_dcpl_631 = and_dcpl_598 & and_dcpl_86;
  assign and_dcpl_633 = and_dcpl_598 & and_dcpl_44 & and_dcpl_78;
  assign and_dcpl_635 = and_dcpl_604 & and_dcpl_79;
  assign and_dcpl_636 = and_dcpl_598 & and_dcpl_79;
  assign and_dcpl_638 = and_dcpl_598 & and_272_cse & and_dcpl_62;
  assign and_dcpl_640 = and_dcpl_604 & and_dcpl_50 & and_dcpl_62;
  assign and_dcpl_646 = ~((fsm_output[8]) | (fsm_output[1]) | (fsm_output[0]));
  assign and_dcpl_690 = and_dcpl_646 & (fsm_output[3:2]==2'b11);
  assign and_dcpl_691 = and_dcpl_690 & and_dcpl_44 & (fsm_output[7:6]==2'b00);
  assign and_dcpl_694 = and_dcpl_690 & and_dcpl_44 & (fsm_output[7:6]==2'b11);
  assign and_dcpl_697 = and_dcpl_690 & and_dcpl_44 & (fsm_output[7:6]==2'b10);
  assign and_dcpl_700 = and_dcpl_690 & and_dcpl_44 & (fsm_output[7:6]==2'b01);
  assign and_752_cse = or_187_cse & (fsm_output[1]) & (~ (fsm_output[8])) & (~ (fsm_output[0]))
      & (fsm_output[2]);
  assign VEC_LOOP_or_34_ssc = and_dcpl_430 | and_dcpl_454;
  assign VEC_LOOP_or_3_ssc = and_dcpl_489 | and_dcpl_492 | and_dcpl_495 | and_dcpl_498
      | and_dcpl_501 | and_dcpl_503 | and_dcpl_505 | and_dcpl_507 | and_dcpl_510
      | and_dcpl_512 | and_dcpl_514 | and_dcpl_516 | and_dcpl_519 | and_dcpl_521
      | and_dcpl_523 | and_dcpl_525;
  assign COMP_LOOP_twiddle_f_or_36_itm = and_dcpl_282 | and_dcpl_293;
  assign COMP_LOOP_twiddle_f_nor_8_itm = ~(and_dcpl_381 | and_dcpl_388);
  assign COMP_LOOP_twiddle_f_or_37_itm = and_dcpl_381 | and_dcpl_388;
  assign VEC_LOOP_or_32_itm = and_dcpl_436 | and_dcpl_439 | and_dcpl_441 | and_dcpl_444;
  assign VEC_LOOP_or_44_itm = and_dcpl_446 | and_dcpl_448 | and_dcpl_456 | and_dcpl_458;
  assign VEC_LOOP_or_45_itm = and_dcpl_433 | and_dcpl_460;
  assign VEC_LOOP_or_55_itm = and_dcpl_471 | and_dcpl_477;
  assign VEC_LOOP_or_56_itm = and_dcpl_529 | and_dcpl_531;
  assign VEC_LOOP_or_59_itm = and_dcpl_528 | and_dcpl_529 | and_dcpl_530 | and_dcpl_531;
  assign VEC_LOOP_or_62_itm = and_dcpl_599 | and_dcpl_605 | and_dcpl_608 | and_dcpl_611
      | and_dcpl_613 | and_dcpl_614 | and_dcpl_616 | and_dcpl_617 | and_dcpl_620
      | and_dcpl_622 | and_dcpl_623 | and_dcpl_626 | and_dcpl_628 | and_dcpl_630
      | and_dcpl_631 | and_dcpl_633 | and_dcpl_635 | and_dcpl_636 | and_dcpl_638
      | and_dcpl_640;
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
      reg_run_rsci_oswt_cse <= ~(or_dcpl_143 | (fsm_output[0]) | or_306_cse | or_dcpl_141);
      reg_vec_rsci_oswt_cse <= ~ mux_38_itm;
      reg_vec_rsci_oswt_1_cse <= and_33_rmff;
      reg_twiddle_rsci_oswt_cse <= and_133_rmff;
      reg_twiddle_rsci_oswt_1_cse <= and_139_rmff;
      reg_complete_rsci_oswt_cse <= and_dcpl_177 & nor_46_cse & (fsm_output[7:6]==2'b00)
          & (~ STAGE_LOOP_acc_itm_4_1);
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_269_cse & (~ (fsm_output[0])) & and_dcpl_29
          & and_dcpl_28;
      reg_ensig_cgo_cse <= ~ mux_61_itm;
      reg_ensig_cgo_1_cse <= and_192_rmff;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_7 & and_dcpl_127 & and_dcpl_28) | STAGE_LOOP_i_3_0_sva_mx0c1)
        ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b1100, z_out_10, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_34_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      run_ac_sync_tmp_dobj_sva <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (~(or_tmp_36 | (fsm_output[3:2]!=2'b01) |
        or_dcpl_141)) ) begin
      run_ac_sync_tmp_dobj_sva <= run_rsci_ivld_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_66 ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( mux_94_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_12_5_sva_6_0 <= MUX_v_7_2_2(7'b0000000, (z_out_12[6:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_70_nl | (fsm_output[8])) ) begin
      COMP_LOOP_17_twiddle_f_mul_psp_sva <= MUX_v_8_2_2(COMP_LOOP_17_twiddle_f_mul_nl,
          (z_out_11[7:0]), and_dcpl_80);
    end
  end
  always @(posedge clk) begin
    if ( (mux_96_nl | (fsm_output[8])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_9_twiddle_f_lshift_ncse_sva_8_4 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt[8:4];
    end
  end
  always @(posedge clk) begin
    if ( (mux_99_nl | (fsm_output[8])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_9_twiddle_f_lshift_ncse_sva_3_0 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_1_rgt[3:0];
    end
  end
  always @(posedge clk) begin
    if ( (mux_100_nl | (fsm_output[8])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva_10_7 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt[10:7];
    end
  end
  always @(posedge clk) begin
    if ( (~(mux_102_nl | (fsm_output[8]))) & nor_114_cse & (~ (fsm_output[7])) &
        complete_rsci_wen_comp ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva_6_0 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt[6:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_77_nl | (fsm_output[8])) ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_cse ) begin
      COMP_LOOP_twiddle_help_1_sva <= MUX_v_32_2_2((twiddle_h_rsci_qa_d_mxwt[31:0]),
          (twiddle_h_rsci_qa_d_mxwt[63:32]), and_dcpl_220);
      COMP_LOOP_twiddle_f_1_sva <= MUX_v_32_2_2((twiddle_rsci_qa_d_mxwt[31:0]), (twiddle_rsci_qa_d_mxwt[63:32]),
          and_dcpl_220);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((xor_dcpl & nor_tmp_1 & (~ (fsm_output[2]))) |
        VEC_LOOP_acc_1_cse_10_sva_mx0c1 | and_dcpl_42 | and_dcpl_49 | and_dcpl_57
        | and_dcpl_61 | and_dcpl_68 | and_dcpl_71 | and_dcpl_74 | and_dcpl_77 | and_dcpl_82
        | and_dcpl_85 | and_dcpl_88 | and_dcpl_91 | and_dcpl_95 | and_dcpl_98 | and_dcpl_101
        | and_dcpl_104) ) begin
      VEC_LOOP_acc_1_cse_10_sva <= MUX_v_12_2_2(12'b000000000000, VEC_LOOP_VEC_LOOP_mux_1_nl,
          VEC_LOOP_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_12_0_1_sva_1 <= 13'b0000000000000;
    end
    else if ( complete_rsci_wen_comp & (~(or_dcpl_143 | (~ (fsm_output[0])) | (~
        (fsm_output[2])))) ) begin
      VEC_LOOP_j_12_0_1_sva_1 <= z_out_15;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_32 | and_dcpl_42 | and_dcpl_46 | and_dcpl_49
        | and_dcpl_52 | and_dcpl_57 | and_dcpl_60 | and_dcpl_61 | and_dcpl_64 | and_dcpl_68
        | and_dcpl_70 | and_dcpl_71 | and_dcpl_73 | and_dcpl_74 | and_dcpl_76 | and_dcpl_77
        | and_dcpl_80 | and_dcpl_82 | and_dcpl_84 | and_dcpl_85 | and_dcpl_87 | and_dcpl_88
        | and_dcpl_90 | and_dcpl_91 | and_dcpl_94 | and_dcpl_95 | and_dcpl_97 | and_dcpl_98
        | and_dcpl_100 | and_dcpl_101 | and_dcpl_103 | and_dcpl_104) ) begin
      VEC_LOOP_acc_10_cse_1_sva <= MUX1HOT_v_12_29_2(z_out_13, VEC_LOOP_acc_10_cse_2_sva_mx0w1,
          VEC_LOOP_acc_10_cse_3_sva_mx0w2, VEC_LOOP_acc_10_cse_4_sva_mx0w3, VEC_LOOP_acc_10_cse_5_sva_mx0w4,
          VEC_LOOP_acc_10_cse_6_sva_mx0w5, VEC_LOOP_acc_10_cse_7_sva_mx0w6, VEC_LOOP_acc_10_cse_8_sva_mx0w7,
          VEC_LOOP_acc_10_cse_10_sva_mx0w9, VEC_LOOP_acc_10_cse_11_sva_mx0w10, VEC_LOOP_acc_10_cse_12_sva_mx0w11,
          VEC_LOOP_acc_10_cse_13_sva_mx0w12, VEC_LOOP_acc_10_cse_14_sva_mx0w13, VEC_LOOP_acc_10_cse_15_sva_mx0w14,
          VEC_LOOP_acc_10_cse_16_sva_mx0w15, VEC_LOOP_acc_10_cse_18_sva_mx0w17, VEC_LOOP_acc_10_cse_19_sva_mx0w18,
          VEC_LOOP_acc_10_cse_20_sva_mx0w19, VEC_LOOP_acc_10_cse_21_sva_mx0w20, VEC_LOOP_acc_10_cse_22_sva_mx0w21,
          VEC_LOOP_acc_10_cse_23_sva_mx0w22, VEC_LOOP_acc_10_cse_24_sva_mx0w23, VEC_LOOP_acc_10_cse_26_sva_mx0w25,
          VEC_LOOP_acc_10_cse_27_sva_mx0w26, VEC_LOOP_acc_10_cse_28_sva_mx0w27, VEC_LOOP_acc_10_cse_29_sva_mx0w28,
          VEC_LOOP_acc_10_cse_30_sva_mx0w29, VEC_LOOP_acc_10_cse_31_sva_mx0w30, VEC_LOOP_acc_10_cse_sva_mx0w31,
          {VEC_LOOP_or_25_nl , and_dcpl_42 , and_dcpl_46 , and_dcpl_49 , and_dcpl_52
          , and_dcpl_57 , and_dcpl_60 , and_dcpl_61 , and_dcpl_68 , and_dcpl_70 ,
          and_dcpl_71 , and_dcpl_73 , and_dcpl_74 , and_dcpl_76 , and_dcpl_77 , and_dcpl_82
          , and_dcpl_84 , and_dcpl_85 , and_dcpl_87 , and_dcpl_88 , and_dcpl_90 ,
          and_dcpl_91 , and_dcpl_95 , and_dcpl_97 , and_dcpl_98 , and_dcpl_100 ,
          and_dcpl_101 , and_dcpl_103 , and_dcpl_104});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_89_nl | (fsm_output[8])) ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva <= z_out_1;
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_103_nl) & (~ (fsm_output[3])) & (fsm_output[2]) & (~ (fsm_output[8]))
        & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_11_psp_sva_10 <= z_out_17[10];
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_106_nl) & (~ (fsm_output[3])) & (fsm_output[2]) & (~ (fsm_output[8]))
        & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_11_psp_sva_9 <= MUX_s_1_2_2((z_out_17[9]), (z_out_11[9]), and_241_ssc);
    end
  end
  always @(posedge clk) begin
    if ( (~ (fsm_output[3])) & (fsm_output[2]) & (~ (fsm_output[8])) & (~ (fsm_output[1]))
        & (fsm_output[0]) & complete_rsci_wen_comp & or_191_cse ) begin
      VEC_LOOP_acc_11_psp_sva_8_0 <= MUX_v_9_2_2((z_out_17[8:0]), (z_out_11[8:0]),
          VEC_LOOP_or_65_nl);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_1_cse ) begin
      COMP_LOOP_twiddle_help_17_sva <= MUX_v_32_2_2((twiddle_h_rsci_qa_d_mxwt[63:32]),
          (twiddle_h_rsci_qa_d_mxwt[31:0]), and_dcpl_236);
      COMP_LOOP_twiddle_f_17_sva <= MUX_v_32_2_2((twiddle_rsci_qa_d_mxwt[63:32]),
          (twiddle_rsci_qa_d_mxwt[31:0]), and_dcpl_236);
    end
  end
  assign mux_33_nl = MUX_s_1_2_2(and_dcpl_7, and_269_cse, fsm_output[2]);
  assign mux_34_nl = MUX_s_1_2_2(mux_33_nl, (fsm_output[8]), or_169_cse);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_66;
  assign or_nl = (fsm_output[7:2]!=6'b000000);
  assign mux_94_nl = MUX_s_1_2_2(nor_117_cse, (fsm_output[8]), or_nl);
  assign nl_COMP_LOOP_17_twiddle_f_mul_nl = (z_out[7:0]) * ({COMP_LOOP_k_12_5_sva_6_0
      , 1'b1});
  assign COMP_LOOP_17_twiddle_f_mul_nl = nl_COMP_LOOP_17_twiddle_f_mul_nl[7:0];
  assign nor_74_nl = ~((fsm_output[5:2]!=4'b0000) | nor_tmp_1);
  assign or_297_nl = (fsm_output[5:2]!=4'b0000);
  assign mux_69_nl = MUX_s_1_2_2(nor_74_nl, or_297_nl, fsm_output[6]);
  assign or_298_nl = (fsm_output[6:0]!=7'b0000110);
  assign mux_70_nl = MUX_s_1_2_2(mux_69_nl, or_298_nl, fsm_output[7]);
  assign nor_nl = ~((fsm_output[7]) | ((fsm_output[4:2]==3'b111)));
  assign mux_95_nl = MUX_s_1_2_2(nor_nl, and_762_cse, fsm_output[5]);
  assign mux_96_nl = MUX_s_1_2_2(mux_95_nl, (fsm_output[7]), fsm_output[6]);
  assign or_313_nl = (fsm_output[3:2]!=2'b00) | nor_tmp_1;
  assign nand_15_nl = ~((fsm_output[3]) & (VEC_LOOP_j_12_0_1_sva_1[12]) & (~ (fsm_output[2]))
      & nor_tmp_1);
  assign mux_97_nl = MUX_s_1_2_2(or_313_nl, nand_15_nl, fsm_output[4]);
  assign nor_116_nl = ~((fsm_output[7]) | mux_97_nl);
  assign mux_98_nl = MUX_s_1_2_2(nor_116_nl, and_762_cse, fsm_output[5]);
  assign mux_99_nl = MUX_s_1_2_2(mux_98_nl, (fsm_output[7]), fsm_output[6]);
  assign nor_115_nl = ~((fsm_output[6:4]!=3'b000) | and_788_cse);
  assign and_766_nl = (fsm_output[6:5]==2'b11) & ((fsm_output[4:2]!=3'b000));
  assign mux_100_nl = MUX_s_1_2_2(nor_115_nl, and_766_nl, fsm_output[7]);
  assign or_333_nl = (fsm_output[1:0]!=2'b10);
  assign mux_101_nl = MUX_s_1_2_2(or_333_nl, or_334_cse, fsm_output[2]);
  assign or_335_nl = (fsm_output[2:0]!=3'b011);
  assign mux_102_nl = MUX_s_1_2_2(mux_101_nl, or_335_nl, fsm_output[3]);
  assign nor_63_nl = ~((fsm_output[6:2]!=5'b00000));
  assign and_279_nl = (fsm_output[6:5]==2'b11) & ((fsm_output[4]) | and_788_cse);
  assign mux_77_nl = MUX_s_1_2_2(nor_63_nl, and_279_nl, fsm_output[7]);
  assign VEC_LOOP_or_nl = and_dcpl_42 | and_dcpl_49 | and_dcpl_57 | and_dcpl_61 |
      and_dcpl_68 | and_dcpl_71 | and_dcpl_74 | and_dcpl_77 | and_dcpl_82 | and_dcpl_85
      | and_dcpl_88 | and_dcpl_91 | and_dcpl_95 | and_dcpl_98 | and_dcpl_101 | and_dcpl_104;
  assign VEC_LOOP_VEC_LOOP_mux_1_nl = MUX_v_12_2_2((VEC_LOOP_j_12_0_1_sva_1[11:0]),
      z_out_13, VEC_LOOP_or_nl);
  assign VEC_LOOP_not_nl = ~ VEC_LOOP_acc_1_cse_10_sva_mx0c1;
  assign VEC_LOOP_or_25_nl = and_dcpl_32 | and_dcpl_64 | and_dcpl_80 | and_dcpl_94;
  assign nor_57_nl = ~((fsm_output[6:5]!=2'b00) | and_tmp_12);
  assign and_278_nl = (fsm_output[6]) & ((fsm_output[5]) | and_tmp_12);
  assign mux_89_nl = MUX_s_1_2_2(nor_57_nl, and_278_nl, fsm_output[7]);
  assign or_323_nl = (fsm_output[6:5]!=2'b00);
  assign mux_103_nl = MUX_s_1_2_2(or_326_cse, mux_cse, or_323_nl);
  assign mux_105_nl = MUX_s_1_2_2(or_326_cse, mux_cse, fsm_output[6]);
  assign mux_106_nl = MUX_s_1_2_2(mux_105_nl, or_334_cse, fsm_output[5]);
  assign VEC_LOOP_or_65_nl = and_241_ssc | (and_dcpl_226 & and_dcpl_66);
  assign COMP_LOOP_twiddle_f_mux_10_nl = MUX_v_12_2_2(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1,
      ({1'b0 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1}), and_dcpl_274);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_6_nl = (COMP_LOOP_k_12_5_sva_6_0[6])
      & (~ and_dcpl_274);
  assign COMP_LOOP_twiddle_f_mux_11_nl = MUX_v_6_2_2((COMP_LOOP_k_12_5_sva_6_0[5:0]),
      (COMP_LOOP_k_12_5_sva_6_0[6:1]), and_dcpl_274);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_7_nl = (COMP_LOOP_k_12_5_sva_6_0[0])
      & and_dcpl_274;
  assign nl_z_out_2 = COMP_LOOP_twiddle_f_mux_10_nl * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_6_nl
      , COMP_LOOP_twiddle_f_mux_11_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_7_nl
      , 4'b0001});
  assign z_out_2 = nl_z_out_2[11:0];
  assign COMP_LOOP_twiddle_f_mux1h_295_nl = MUX1HOT_v_12_3_2(({3'b000 , COMP_LOOP_9_twiddle_f_lshift_ncse_sva_8_4
      , COMP_LOOP_9_twiddle_f_lshift_ncse_sva_3_0}), COMP_LOOP_2_twiddle_f_lshift_ncse_sva,
      ({1'b0 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_10_7 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_6_0}),
      {COMP_LOOP_twiddle_f_or_36_itm , and_dcpl_288 , and_dcpl_291});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_8_nl = (COMP_LOOP_k_12_5_sva_6_0[6])
      & (~(and_dcpl_282 | and_dcpl_291 | and_dcpl_293));
  assign COMP_LOOP_twiddle_f_mux_12_nl = MUX_v_2_2_2((COMP_LOOP_k_12_5_sva_6_0[5:4]),
      (COMP_LOOP_k_12_5_sva_6_0[6:5]), and_dcpl_291);
  assign COMP_LOOP_twiddle_f_nor_13_nl = ~(and_dcpl_282 | and_dcpl_293);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_9_nl = MUX_v_2_2_2(2'b00, COMP_LOOP_twiddle_f_mux_12_nl,
      COMP_LOOP_twiddle_f_nor_13_nl);
  assign COMP_LOOP_twiddle_f_mux1h_296_nl = MUX1HOT_v_7_3_2(COMP_LOOP_k_12_5_sva_6_0,
      ({(COMP_LOOP_k_12_5_sva_6_0[3:0]) , 3'b011}), ({(COMP_LOOP_k_12_5_sva_6_0[4:0])
      , 2'b10}), {COMP_LOOP_twiddle_f_or_36_itm , and_dcpl_288 , and_dcpl_291});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_12_nl = (~(and_dcpl_282 | and_dcpl_288))
      | and_dcpl_291 | and_dcpl_293;
  assign nl_z_out_3 = COMP_LOOP_twiddle_f_mux1h_295_nl * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_8_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_9_nl , COMP_LOOP_twiddle_f_mux1h_296_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_12_nl , 1'b1});
  assign z_out_3 = nl_z_out_3[11:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_13_nl = (~((and_dcpl_287 & (fsm_output[5:4]==2'b01)
      & and_dcpl_3) | and_dcpl_304 | and_dcpl_307)) | and_dcpl_312;
  assign COMP_LOOP_twiddle_f_mux_13_nl = MUX_v_2_2_2(2'b01, 2'b10, and_dcpl_304);
  assign COMP_LOOP_twiddle_f_or_46_nl = and_dcpl_307 | and_dcpl_312;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_14_nl = MUX_v_2_2_2(COMP_LOOP_twiddle_f_mux_13_nl,
      2'b11, COMP_LOOP_twiddle_f_or_46_nl);
  assign nl_z_out_4 = COMP_LOOP_2_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_12_5_sva_6_0
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_13_nl , 1'b0 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_14_nl
      , 1'b1});
  assign z_out_4 = nl_z_out_4[11:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_15_nl = (~(and_dcpl_320 | and_dcpl_323))
      | and_dcpl_328 | and_dcpl_331;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_16_nl = (~(and_dcpl_320 | and_dcpl_328))
      | and_dcpl_323 | and_dcpl_331;
  assign nl_z_out_5_9_0 = COMP_LOOP_5_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_12_5_sva_6_0
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_15_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_16_nl
      , 1'b1});
  assign z_out_5_9_0 = nl_z_out_5_9_0[9:0];
  assign and_792_nl = and_dcpl_280 & (fsm_output[3:2]==2'b00) & nor_46_cse & (fsm_output[7:6]==2'b01);
  assign and_793_nl = and_dcpl_319 & and_dcpl_44 & (fsm_output[7:6]==2'b10);
  assign and_794_nl = and_dcpl_319 & nor_46_cse & and_dcpl_92;
  assign and_795_nl = and_dcpl_319 & and_dcpl_44 & and_dcpl_92;
  assign COMP_LOOP_twiddle_f_mux1h_297_nl = MUX1HOT_v_4_4_2(4'b0100, 4'b1010, 4'b1101,
      4'b1110, {and_792_nl , and_793_nl , and_794_nl , and_795_nl});
  assign nl_z_out_6 = COMP_LOOP_2_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_12_5_sva_6_0
      , COMP_LOOP_twiddle_f_mux1h_297_nl , 1'b1});
  assign z_out_6 = nl_z_out_6[11:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_17_nl = (~(and_dcpl_358 | and_dcpl_362
      | and_dcpl_364)) | and_dcpl_369;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_18_nl = (~ and_dcpl_358) | and_dcpl_362
      | and_dcpl_364 | and_dcpl_369;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_19_nl = (~ and_dcpl_362) | and_dcpl_358
      | and_dcpl_364 | and_dcpl_369;
  assign nl_z_out_7_10_0 = ({COMP_LOOP_3_twiddle_f_lshift_ncse_sva_10_7 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_6_0})
      * ({COMP_LOOP_k_12_5_sva_6_0 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_17_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_18_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_19_nl
      , 1'b1});
  assign z_out_7_10_0 = nl_z_out_7_10_0[10:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_10_nl = (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[11])
      & COMP_LOOP_twiddle_f_nor_8_itm;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_10_nl = MUX_v_11_2_2((COMP_LOOP_2_twiddle_f_lshift_ncse_sva[10:0]),
      ({COMP_LOOP_3_twiddle_f_lshift_ncse_sva_10_7 , COMP_LOOP_3_twiddle_f_lshift_ncse_sva_6_0}),
      COMP_LOOP_twiddle_f_or_37_itm);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_11_nl = (COMP_LOOP_k_12_5_sva_6_0[6])
      & COMP_LOOP_twiddle_f_nor_8_itm;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_11_nl = MUX_v_6_2_2((COMP_LOOP_k_12_5_sva_6_0[5:0]),
      (COMP_LOOP_k_12_5_sva_6_0[6:1]), COMP_LOOP_twiddle_f_or_37_itm);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_20_nl = ((COMP_LOOP_k_12_5_sva_6_0[0])
      & (~ and_dcpl_377)) | and_dcpl_385;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_21_nl = (~(and_dcpl_381 | and_dcpl_385))
      | and_dcpl_377 | and_dcpl_388;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_22_nl = (~(and_dcpl_381 | and_dcpl_385
      | and_dcpl_388)) | and_dcpl_377;
  assign nl_z_out_8 = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_10_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_10_nl})
      * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_11_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_11_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_20_nl , 1'b1 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_21_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_22_nl , 1'b1});
  assign z_out_8 = nl_z_out_8[11:0];
  assign COMP_LOOP_twiddle_f_or_48_nl = and_dcpl_401 | and_dcpl_405;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_12_nl = MUX_v_2_2_2(2'b01, 2'b10,
      COMP_LOOP_twiddle_f_or_48_nl);
  assign COMP_LOOP_twiddle_f_or_47_nl = MUX_v_2_2_2(COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_12_nl,
      2'b11, and_dcpl_409);
  assign COMP_LOOP_twiddle_f_or_49_nl = (~ and_dcpl_401) | (and_dcpl_280 & (fsm_output[5:2]==4'b0100)
      & and_dcpl_62) | and_dcpl_405 | and_dcpl_409;
  assign nl_z_out_9 = COMP_LOOP_2_twiddle_f_lshift_ncse_sva * ({COMP_LOOP_k_12_5_sva_6_0
      , COMP_LOOP_twiddle_f_or_47_nl , and_dcpl_409 , COMP_LOOP_twiddle_f_or_49_nl
      , 1'b1});
  assign z_out_9 = nl_z_out_9[11:0];
  assign STAGE_LOOP_mux_4_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (~ STAGE_LOOP_i_3_0_sva),
      and_dcpl_422);
  assign nl_z_out_10 = STAGE_LOOP_mux_4_nl + conv_s2u_3_4({1'b1 , (~ and_dcpl_422)
      , 1'b1});
  assign z_out_10 = nl_z_out_10[3:0];
  assign VEC_LOOP_VEC_LOOP_or_15_nl = ((VEC_LOOP_acc_1_cse_10_sva[11]) & (~(and_dcpl_430
      | and_dcpl_433 | and_dcpl_446 | and_dcpl_448 | and_dcpl_454 | and_dcpl_460)))
      | and_dcpl_456 | and_dcpl_458;
  assign VEC_LOOP_or_66_nl = and_dcpl_446 | and_dcpl_448;
  assign VEC_LOOP_or_67_nl = and_dcpl_456 | and_dcpl_458;
  assign VEC_LOOP_mux1h_40_nl = MUX1HOT_v_9_7_2(({2'b00 , (VEC_LOOP_acc_1_cse_10_sva[11:5])}),
      ({1'b0 , (VEC_LOOP_acc_1_cse_10_sva[11:4])}), (VEC_LOOP_acc_1_cse_10_sva[10:2]),
      (VEC_LOOP_acc_1_cse_10_sva[11:3]), ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[12:6]))}),
      (~ (STAGE_LOOP_lshift_psp_sva[12:4])), ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[12:5]))}),
      {and_dcpl_430 , and_dcpl_433 , VEC_LOOP_or_32_itm , VEC_LOOP_or_66_nl , and_dcpl_454
      , VEC_LOOP_or_67_nl , and_dcpl_460});
  assign VEC_LOOP_or_68_nl = (~(and_dcpl_430 | and_dcpl_433 | and_dcpl_436 | and_dcpl_439
      | and_dcpl_441 | and_dcpl_444 | and_dcpl_446 | and_dcpl_448)) | and_dcpl_454
      | and_dcpl_456 | and_dcpl_458 | and_dcpl_460;
  assign VEC_LOOP_and_22_nl = (COMP_LOOP_k_12_5_sva_6_0[6]) & (~(and_dcpl_430 | and_dcpl_433
      | and_dcpl_446 | and_dcpl_448 | and_dcpl_454 | and_dcpl_456 | and_dcpl_458
      | and_dcpl_460));
  assign VEC_LOOP_VEC_LOOP_mux_10_nl = MUX_s_1_2_2((COMP_LOOP_k_12_5_sva_6_0[5]),
      (COMP_LOOP_k_12_5_sva_6_0[6]), VEC_LOOP_or_44_itm);
  assign VEC_LOOP_and_23_nl = VEC_LOOP_VEC_LOOP_mux_10_nl & (~(and_dcpl_430 | and_dcpl_433
      | and_dcpl_454 | and_dcpl_460));
  assign VEC_LOOP_mux1h_41_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_12_5_sva_6_0[6]), (COMP_LOOP_k_12_5_sva_6_0[4]),
      (COMP_LOOP_k_12_5_sva_6_0[5]), {VEC_LOOP_or_45_itm , VEC_LOOP_or_32_itm , VEC_LOOP_or_44_itm});
  assign VEC_LOOP_and_24_nl = VEC_LOOP_mux1h_41_nl & (~(and_dcpl_430 | and_dcpl_454));
  assign VEC_LOOP_mux1h_42_nl = MUX1HOT_v_4_4_2((COMP_LOOP_k_12_5_sva_6_0[6:3]),
      (COMP_LOOP_k_12_5_sva_6_0[5:2]), (COMP_LOOP_k_12_5_sva_6_0[3:0]), (COMP_LOOP_k_12_5_sva_6_0[4:1]),
      {VEC_LOOP_or_34_ssc , VEC_LOOP_or_45_itm , VEC_LOOP_or_32_itm , VEC_LOOP_or_44_itm});
  assign VEC_LOOP_mux1h_43_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_12_5_sva_6_0[2]), (COMP_LOOP_k_12_5_sva_6_0[1]),
      (COMP_LOOP_k_12_5_sva_6_0[0]), {VEC_LOOP_or_34_ssc , VEC_LOOP_or_45_itm , VEC_LOOP_or_44_itm});
  assign VEC_LOOP_or_69_nl = (VEC_LOOP_mux1h_43_nl & (~(and_dcpl_436 | and_dcpl_439)))
      | and_dcpl_441 | and_dcpl_444;
  assign VEC_LOOP_VEC_LOOP_mux_11_nl = MUX_s_1_2_2((COMP_LOOP_k_12_5_sva_6_0[1]),
      (COMP_LOOP_k_12_5_sva_6_0[0]), VEC_LOOP_or_45_itm);
  assign VEC_LOOP_or_70_nl = (VEC_LOOP_VEC_LOOP_mux_11_nl & (~(and_dcpl_436 | and_dcpl_441
      | and_dcpl_446 | and_dcpl_456))) | and_dcpl_439 | and_dcpl_444 | and_dcpl_448
      | and_dcpl_458;
  assign VEC_LOOP_VEC_LOOP_or_16_nl = ((COMP_LOOP_k_12_5_sva_6_0[0]) & (~(and_dcpl_456
      | and_dcpl_458 | and_dcpl_460))) | and_dcpl_433 | and_dcpl_436 | and_dcpl_439
      | and_dcpl_441 | and_dcpl_444 | and_dcpl_446 | and_dcpl_448;
  assign nl_acc_1_nl = ({VEC_LOOP_VEC_LOOP_or_15_nl , VEC_LOOP_mux1h_40_nl , VEC_LOOP_or_68_nl})
      + ({VEC_LOOP_and_22_nl , VEC_LOOP_and_23_nl , VEC_LOOP_and_24_nl , VEC_LOOP_mux1h_42_nl
      , VEC_LOOP_or_69_nl , VEC_LOOP_or_70_nl , VEC_LOOP_VEC_LOOP_or_16_nl , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[10:0];
  assign z_out_11 = readslicef_11_10_1(acc_1_nl);
  assign VEC_LOOP_or_71_nl = and_dcpl_468 | and_dcpl_481;
  assign VEC_LOOP_mux1h_44_nl = MUX1HOT_v_7_3_2(({2'b00 , (COMP_LOOP_k_12_5_sva_6_0[6:2])}),
      COMP_LOOP_k_12_5_sva_6_0, ({1'b0 , (COMP_LOOP_k_12_5_sva_6_0[6:1])}), {VEC_LOOP_or_71_nl
      , VEC_LOOP_or_55_itm , and_dcpl_474});
  assign VEC_LOOP_mux_25_nl = MUX_s_1_2_2((COMP_LOOP_k_12_5_sva_6_0[1]), (COMP_LOOP_k_12_5_sva_6_0[0]),
      and_dcpl_474);
  assign VEC_LOOP_VEC_LOOP_or_17_nl = (VEC_LOOP_mux_25_nl & (~ and_dcpl_471)) | and_dcpl_477;
  assign VEC_LOOP_VEC_LOOP_or_18_nl = (COMP_LOOP_k_12_5_sva_6_0[0]) | and_dcpl_471
      | and_dcpl_477 | and_dcpl_474;
  assign VEC_LOOP_mux1h_45_nl = MUX1HOT_v_9_4_2(({2'b00 , (STAGE_LOOP_lshift_psp_sva[12:6])}),
      (STAGE_LOOP_lshift_psp_sva[12:4]), ({1'b0 , (STAGE_LOOP_lshift_psp_sva[12:5])}),
      9'b000000001, {and_dcpl_468 , VEC_LOOP_or_55_itm , and_dcpl_474 , and_dcpl_481});
  assign nl_z_out_12 = ({VEC_LOOP_mux1h_44_nl , VEC_LOOP_VEC_LOOP_or_17_nl , VEC_LOOP_VEC_LOOP_or_18_nl})
      + VEC_LOOP_mux1h_45_nl;
  assign z_out_12 = nl_z_out_12[8:0];
  assign VEC_LOOP_mux1h_46_nl = MUX1HOT_v_8_4_2((VEC_LOOP_acc_1_cse_10_sva[11:4]),
      ({(z_out_12[6:0]) , (STAGE_LOOP_lshift_psp_sva[5])}), (z_out_12[8:1]), (z_out_12[7:0]),
      {VEC_LOOP_or_3_ssc , and_dcpl_528 , VEC_LOOP_or_56_itm , and_dcpl_530});
  assign VEC_LOOP_or_72_nl = and_dcpl_528 | and_dcpl_530;
  assign VEC_LOOP_mux1h_47_nl = MUX1HOT_s_1_3_2((VEC_LOOP_acc_1_cse_10_sva[3]), (STAGE_LOOP_lshift_psp_sva[4]),
      (z_out_12[0]), {VEC_LOOP_or_3_ssc , VEC_LOOP_or_72_nl , VEC_LOOP_or_56_itm});
  assign VEC_LOOP_VEC_LOOP_mux_12_nl = MUX_v_3_2_2((VEC_LOOP_acc_1_cse_10_sva[2:0]),
      (STAGE_LOOP_lshift_psp_sva[3:1]), VEC_LOOP_or_59_itm);
  assign VEC_LOOP_VEC_LOOP_mux_13_nl = MUX_v_7_2_2(COMP_LOOP_k_12_5_sva_6_0, (VEC_LOOP_acc_1_cse_10_sva[11:5]),
      VEC_LOOP_or_59_itm);
  assign VEC_LOOP_VEC_LOOP_or_19_nl = ((VEC_LOOP_acc_1_cse_10_sva[4]) & (~(and_dcpl_489
      | and_dcpl_492 | and_dcpl_495 | and_dcpl_498 | and_dcpl_501 | and_dcpl_503
      | and_dcpl_505 | and_dcpl_507))) | and_dcpl_510 | and_dcpl_512 | and_dcpl_514
      | and_dcpl_516 | and_dcpl_519 | and_dcpl_521 | and_dcpl_523 | and_dcpl_525;
  assign VEC_LOOP_VEC_LOOP_or_20_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_dcpl_489
      | and_dcpl_492 | and_dcpl_495 | and_dcpl_498 | and_dcpl_510 | and_dcpl_512
      | and_dcpl_514 | and_dcpl_516))) | and_dcpl_501 | and_dcpl_503 | and_dcpl_505
      | and_dcpl_507 | and_dcpl_519 | and_dcpl_521 | and_dcpl_523 | and_dcpl_525;
  assign VEC_LOOP_VEC_LOOP_or_21_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_dcpl_489
      | and_dcpl_492 | and_dcpl_501 | and_dcpl_503 | and_dcpl_510 | and_dcpl_512
      | and_dcpl_519 | and_dcpl_521))) | and_dcpl_495 | and_dcpl_498 | and_dcpl_505
      | and_dcpl_507 | and_dcpl_514 | and_dcpl_516 | and_dcpl_523 | and_dcpl_525;
  assign VEC_LOOP_VEC_LOOP_or_22_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_dcpl_489
      | and_dcpl_495 | and_dcpl_501 | and_dcpl_505 | and_dcpl_510 | and_dcpl_514
      | and_dcpl_519 | and_dcpl_523))) | and_dcpl_492 | and_dcpl_498 | and_dcpl_503
      | and_dcpl_507 | and_dcpl_512 | and_dcpl_516 | and_dcpl_521 | and_dcpl_525;
  assign VEC_LOOP_VEC_LOOP_or_23_nl = (VEC_LOOP_acc_1_cse_10_sva[0]) | and_dcpl_489
      | and_dcpl_492 | and_dcpl_495 | and_dcpl_498 | and_dcpl_501 | and_dcpl_503
      | and_dcpl_505 | and_dcpl_507 | and_dcpl_510 | and_dcpl_512 | and_dcpl_514
      | and_dcpl_516 | and_dcpl_519 | and_dcpl_521 | and_dcpl_523 | and_dcpl_525;
  assign nl_z_out_13 = ({VEC_LOOP_mux1h_46_nl , VEC_LOOP_mux1h_47_nl , VEC_LOOP_VEC_LOOP_mux_12_nl})
      + ({VEC_LOOP_VEC_LOOP_mux_13_nl , VEC_LOOP_VEC_LOOP_or_19_nl , VEC_LOOP_VEC_LOOP_or_20_nl
      , VEC_LOOP_VEC_LOOP_or_21_nl , VEC_LOOP_VEC_LOOP_or_22_nl , VEC_LOOP_VEC_LOOP_or_23_nl});
  assign z_out_13 = nl_z_out_13[11:0];
  assign and_797_nl = and_dcpl_488 & nor_46_cse & and_dcpl_3;
  assign and_798_nl = and_dcpl_527 & and_dcpl_45;
  assign and_799_nl = and_dcpl_488 & and_dcpl_45;
  assign and_800_nl = and_dcpl_527 & and_dcpl_51;
  assign and_801_nl = and_dcpl_488 & and_dcpl_51;
  assign and_802_nl = and_dcpl_527 & and_dcpl_59;
  assign and_803_nl = and_dcpl_488 & and_dcpl_59;
  assign and_804_nl = and_dcpl_488 & nor_46_cse & and_dcpl_62;
  assign and_805_nl = and_dcpl_527 & and_dcpl_69;
  assign and_806_nl = and_dcpl_488 & and_dcpl_69;
  assign and_807_nl = and_dcpl_527 & and_dcpl_72;
  assign and_808_nl = and_dcpl_488 & and_dcpl_72;
  assign and_809_nl = and_dcpl_527 & and_dcpl_75;
  assign and_810_nl = and_dcpl_488 & and_dcpl_75;
  assign and_811_nl = and_dcpl_488 & nor_46_cse & and_dcpl_78;
  assign and_812_nl = and_dcpl_527 & and_dcpl_83;
  assign and_813_nl = and_dcpl_488 & and_dcpl_83;
  assign and_814_nl = and_dcpl_527 & and_dcpl_86;
  assign and_815_nl = and_dcpl_488 & and_dcpl_86;
  assign and_816_nl = and_dcpl_527 & and_dcpl_89;
  assign and_817_nl = and_dcpl_488 & and_dcpl_89;
  assign and_818_nl = and_dcpl_488 & nor_46_cse & and_dcpl_92;
  assign and_819_nl = and_dcpl_527 & and_dcpl_96;
  assign and_820_nl = and_dcpl_488 & and_dcpl_96;
  assign and_821_nl = and_dcpl_527 & and_dcpl_99;
  assign and_822_nl = and_dcpl_488 & and_dcpl_99;
  assign and_823_nl = and_dcpl_527 & and_dcpl_102;
  assign VEC_LOOP_mux1h_48_nl = MUX1HOT_v_5_27_2(5'b00001, 5'b00010, 5'b00011, 5'b00100,
      5'b00101, 5'b00110, 5'b00111, 5'b01001, 5'b01010, 5'b01011, 5'b01100, 5'b01101,
      5'b01110, 5'b01111, 5'b10001, 5'b10010, 5'b10011, 5'b10100, 5'b10101, 5'b10110,
      5'b10111, 5'b11001, 5'b11010, 5'b11011, 5'b11100, 5'b11101, 5'b11110, {and_797_nl
      , and_798_nl , and_799_nl , and_800_nl , and_801_nl , and_802_nl , and_803_nl
      , and_804_nl , and_805_nl , and_806_nl , and_807_nl , and_808_nl , and_809_nl
      , and_810_nl , and_811_nl , and_812_nl , and_813_nl , and_814_nl , and_815_nl
      , and_816_nl , and_817_nl , and_818_nl , and_819_nl , and_820_nl , and_821_nl
      , and_822_nl , and_823_nl});
  assign and_824_nl = and_dcpl_488 & and_dcpl_102;
  assign VEC_LOOP_or_73_nl = MUX_v_5_2_2(VEC_LOOP_mux1h_48_nl, 5'b11111, and_824_nl);
  assign nl_z_out_14 = ({COMP_LOOP_k_12_5_sva_6_0 , VEC_LOOP_or_73_nl}) + (STAGE_LOOP_lshift_psp_sva[12:1]);
  assign z_out_14 = nl_z_out_14[11:0];
  assign VEC_LOOP_VEC_LOOP_or_24_nl = (STAGE_LOOP_lshift_psp_sva[12]) | and_dcpl_599
      | and_dcpl_605 | and_dcpl_608 | and_dcpl_611 | and_dcpl_613 | and_dcpl_614
      | and_dcpl_616 | and_dcpl_617 | and_dcpl_620 | and_dcpl_622 | and_dcpl_623
      | and_dcpl_626 | and_dcpl_628 | and_dcpl_630 | and_dcpl_631 | and_dcpl_633
      | and_dcpl_635 | and_dcpl_636 | and_dcpl_638 | and_dcpl_640;
  assign VEC_LOOP_VEC_LOOP_mux_14_nl = MUX_v_12_2_2((STAGE_LOOP_lshift_psp_sva[11:0]),
      (~ (STAGE_LOOP_lshift_psp_sva[12:1])), VEC_LOOP_or_62_itm);
  assign VEC_LOOP_or_74_nl = (~(nor_117_cse & (fsm_output[0]) & (fsm_output[2])))
      | and_dcpl_599 | and_dcpl_605 | and_dcpl_608 | and_dcpl_611 | and_dcpl_613
      | and_dcpl_614 | and_dcpl_616 | and_dcpl_617 | and_dcpl_620 | and_dcpl_622
      | and_dcpl_623 | and_dcpl_626 | and_dcpl_628 | and_dcpl_630 | and_dcpl_631
      | and_dcpl_633 | and_dcpl_635 | and_dcpl_636 | and_dcpl_638 | and_dcpl_640;
  assign VEC_LOOP_VEC_LOOP_mux_15_nl = MUX_v_7_2_2((VEC_LOOP_acc_1_cse_10_sva[11:5]),
      COMP_LOOP_k_12_5_sva_6_0, VEC_LOOP_or_62_itm);
  assign VEC_LOOP_VEC_LOOP_or_25_nl = ((VEC_LOOP_acc_1_cse_10_sva[4]) & (~(and_dcpl_605
      | and_dcpl_608 | and_dcpl_611 | and_dcpl_613 | and_dcpl_614 | and_dcpl_628
      | and_dcpl_638 | and_dcpl_640))) | and_dcpl_599 | and_dcpl_616 | and_dcpl_617
      | and_dcpl_620 | and_dcpl_622 | and_dcpl_623 | and_dcpl_626 | and_dcpl_630
      | and_dcpl_631 | and_dcpl_633 | and_dcpl_635 | and_dcpl_636;
  assign VEC_LOOP_VEC_LOOP_or_26_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_dcpl_605
      | and_dcpl_611 | and_dcpl_613 | and_dcpl_614 | and_dcpl_626 | and_dcpl_630
      | and_dcpl_631 | and_dcpl_633 | and_dcpl_635 | and_dcpl_636))) | and_dcpl_599
      | and_dcpl_608 | and_dcpl_616 | and_dcpl_617 | and_dcpl_620 | and_dcpl_622
      | and_dcpl_623 | and_dcpl_628 | and_dcpl_638 | and_dcpl_640;
  assign VEC_LOOP_VEC_LOOP_or_27_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_dcpl_605
      | and_dcpl_608 | and_dcpl_620 | and_dcpl_622 | and_dcpl_623 | and_dcpl_628
      | and_dcpl_633 | and_dcpl_635 | and_dcpl_636))) | and_dcpl_599 | and_dcpl_611
      | and_dcpl_613 | and_dcpl_614 | and_dcpl_616 | and_dcpl_617 | and_dcpl_626
      | and_dcpl_630 | and_dcpl_631 | and_dcpl_638 | and_dcpl_640;
  assign VEC_LOOP_VEC_LOOP_or_28_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_dcpl_599
      | and_dcpl_605 | and_dcpl_608 | and_dcpl_613 | and_dcpl_614 | and_dcpl_617
      | and_dcpl_622 | and_dcpl_623 | and_dcpl_630 | and_dcpl_631 | and_dcpl_635
      | and_dcpl_636 | and_dcpl_640))) | and_dcpl_611 | and_dcpl_616 | and_dcpl_620
      | and_dcpl_626 | and_dcpl_628 | and_dcpl_633 | and_dcpl_638;
  assign VEC_LOOP_VEC_LOOP_or_29_nl = ((VEC_LOOP_acc_1_cse_10_sva[0]) & (~(and_dcpl_599
      | and_dcpl_608 | and_dcpl_611 | and_dcpl_614 | and_dcpl_616 | and_dcpl_620
      | and_dcpl_623 | and_dcpl_626 | and_dcpl_628 | and_dcpl_631 | and_dcpl_633
      | and_dcpl_636 | and_dcpl_638))) | and_dcpl_605 | and_dcpl_613 | and_dcpl_617
      | and_dcpl_622 | and_dcpl_630 | and_dcpl_635 | and_dcpl_640;
  assign nl_acc_5_nl = ({VEC_LOOP_VEC_LOOP_or_24_nl , VEC_LOOP_VEC_LOOP_mux_14_nl
      , VEC_LOOP_or_74_nl}) + conv_u2u_13_14({VEC_LOOP_VEC_LOOP_mux_15_nl , VEC_LOOP_VEC_LOOP_or_25_nl
      , VEC_LOOP_VEC_LOOP_or_26_nl , VEC_LOOP_VEC_LOOP_or_27_nl , VEC_LOOP_VEC_LOOP_or_28_nl
      , VEC_LOOP_VEC_LOOP_or_29_nl , 1'b1});
  assign acc_5_nl = nl_acc_5_nl[13:0];
  assign z_out_15 = readslicef_14_13_1(acc_5_nl);
  assign and_825_nl = and_dcpl_646 & (fsm_output[5:2]==4'b0011) & and_dcpl_62;
  assign COMP_LOOP_mux1h_8_nl = MUX1HOT_v_4_3_2(4'b0010, 4'b1001, 4'b1100, {(fsm_output[4])
      , and_825_nl , (fsm_output[5])});
  assign nl_acc_6_nl = ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[12:1])) , 1'b1}) +
      conv_u2u_13_14({COMP_LOOP_k_12_5_sva_6_0 , 1'b0 , COMP_LOOP_mux1h_8_nl , 1'b1});
  assign acc_6_nl = nl_acc_6_nl[13:0];
  assign z_out_16_12 = readslicef_14_1_13(acc_6_nl);
  assign and_826_nl = and_dcpl_429 & and_272_cse & and_dcpl_3;
  assign and_827_nl = and_dcpl_429 & and_dcpl_44 & and_dcpl_62;
  assign and_828_nl = and_dcpl_429 & and_272_cse & and_dcpl_62;
  assign and_829_nl = and_dcpl_429 & and_dcpl_44 & and_dcpl_78;
  assign and_830_nl = and_dcpl_429 & and_272_cse & and_dcpl_78;
  assign and_831_nl = and_dcpl_429 & and_dcpl_44 & and_dcpl_92;
  assign VEC_LOOP_mux1h_49_nl = MUX1HOT_v_3_6_2(3'b110, 3'b101, 3'b100, 3'b011, 3'b010,
      3'b001, {and_826_nl , and_827_nl , and_828_nl , and_829_nl , and_830_nl , and_831_nl});
  assign and_832_nl = and_dcpl_429 & and_dcpl_44 & and_dcpl_3;
  assign VEC_LOOP_nor_35_nl = ~(MUX_v_3_2_2(VEC_LOOP_mux1h_49_nl, 3'b111, and_832_nl));
  assign and_833_nl = and_dcpl_429 & and_272_cse & and_dcpl_92;
  assign VEC_LOOP_or_75_nl = MUX_v_3_2_2(VEC_LOOP_nor_35_nl, 3'b111, and_833_nl);
  assign nl_z_out_17 = (VEC_LOOP_acc_1_cse_10_sva[11:1]) + ({COMP_LOOP_k_12_5_sva_6_0
      , VEC_LOOP_or_75_nl , 1'b1});
  assign z_out_17 = nl_z_out_17[10:0];
  assign COMP_LOOP_COMP_LOOP_or_2_nl = (~(and_dcpl_691 | and_dcpl_700)) | and_dcpl_694
      | and_dcpl_697;
  assign COMP_LOOP_COMP_LOOP_or_3_nl = (~(and_dcpl_691 | and_dcpl_697)) | and_dcpl_694
      | and_dcpl_700;
  assign nl_acc_8_nl = ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[12:3])) , 1'b1}) +
      conv_u2u_11_12({COMP_LOOP_k_12_5_sva_6_0 , COMP_LOOP_COMP_LOOP_or_2_nl , COMP_LOOP_COMP_LOOP_or_3_nl
      , 2'b01});
  assign acc_8_nl = nl_acc_8_nl[11:0];
  assign z_out_18_10 = readslicef_12_1_11(acc_8_nl);
  assign VEC_LOOP_mux_26_cse = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
      and_752_cse);

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


  function automatic [0:0] MUX1HOT_s_1_34_2;
    input [0:0] input_33;
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
    input [33:0] sel;
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
    result = result | ( input_33 & {1{sel[33]}});
    MUX1HOT_s_1_34_2 = result;
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


  function automatic [11:0] MUX1HOT_v_12_29_2;
    input [11:0] input_28;
    input [11:0] input_27;
    input [11:0] input_26;
    input [11:0] input_25;
    input [11:0] input_24;
    input [11:0] input_23;
    input [11:0] input_22;
    input [11:0] input_21;
    input [11:0] input_20;
    input [11:0] input_19;
    input [11:0] input_18;
    input [11:0] input_17;
    input [11:0] input_16;
    input [11:0] input_15;
    input [11:0] input_14;
    input [11:0] input_13;
    input [11:0] input_12;
    input [11:0] input_11;
    input [11:0] input_10;
    input [11:0] input_9;
    input [11:0] input_8;
    input [11:0] input_7;
    input [11:0] input_6;
    input [11:0] input_5;
    input [11:0] input_4;
    input [11:0] input_3;
    input [11:0] input_2;
    input [11:0] input_1;
    input [11:0] input_0;
    input [28:0] sel;
    reg [11:0] result;
  begin
    result = input_0 & {12{sel[0]}};
    result = result | ( input_1 & {12{sel[1]}});
    result = result | ( input_2 & {12{sel[2]}});
    result = result | ( input_3 & {12{sel[3]}});
    result = result | ( input_4 & {12{sel[4]}});
    result = result | ( input_5 & {12{sel[5]}});
    result = result | ( input_6 & {12{sel[6]}});
    result = result | ( input_7 & {12{sel[7]}});
    result = result | ( input_8 & {12{sel[8]}});
    result = result | ( input_9 & {12{sel[9]}});
    result = result | ( input_10 & {12{sel[10]}});
    result = result | ( input_11 & {12{sel[11]}});
    result = result | ( input_12 & {12{sel[12]}});
    result = result | ( input_13 & {12{sel[13]}});
    result = result | ( input_14 & {12{sel[14]}});
    result = result | ( input_15 & {12{sel[15]}});
    result = result | ( input_16 & {12{sel[16]}});
    result = result | ( input_17 & {12{sel[17]}});
    result = result | ( input_18 & {12{sel[18]}});
    result = result | ( input_19 & {12{sel[19]}});
    result = result | ( input_20 & {12{sel[20]}});
    result = result | ( input_21 & {12{sel[21]}});
    result = result | ( input_22 & {12{sel[22]}});
    result = result | ( input_23 & {12{sel[23]}});
    result = result | ( input_24 & {12{sel[24]}});
    result = result | ( input_25 & {12{sel[25]}});
    result = result | ( input_26 & {12{sel[26]}});
    result = result | ( input_27 & {12{sel[27]}});
    result = result | ( input_28 & {12{sel[28]}});
    MUX1HOT_v_12_29_2 = result;
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


  function automatic [1:0] MUX1HOT_v_2_11_2;
    input [1:0] input_10;
    input [1:0] input_9;
    input [1:0] input_8;
    input [1:0] input_7;
    input [1:0] input_6;
    input [1:0] input_5;
    input [1:0] input_4;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [10:0] sel;
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
    result = result | ( input_9 & {2{sel[9]}});
    result = result | ( input_10 & {2{sel[10]}});
    MUX1HOT_v_2_11_2 = result;
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


  function automatic [4:0] MUX1HOT_v_5_27_2;
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
    input [26:0] sel;
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
    MUX1HOT_v_5_27_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_12_2;
    input [6:0] input_11;
    input [6:0] input_10;
    input [6:0] input_9;
    input [6:0] input_8;
    input [6:0] input_7;
    input [6:0] input_6;
    input [6:0] input_5;
    input [6:0] input_4;
    input [6:0] input_3;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [11:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | ( input_1 & {7{sel[1]}});
    result = result | ( input_2 & {7{sel[2]}});
    result = result | ( input_3 & {7{sel[3]}});
    result = result | ( input_4 & {7{sel[4]}});
    result = result | ( input_5 & {7{sel[5]}});
    result = result | ( input_6 & {7{sel[6]}});
    result = result | ( input_7 & {7{sel[7]}});
    result = result | ( input_8 & {7{sel[8]}});
    result = result | ( input_9 & {7{sel[9]}});
    result = result | ( input_10 & {7{sel[10]}});
    result = result | ( input_11 & {7{sel[11]}});
    MUX1HOT_v_7_12_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_36_2;
    input [6:0] input_35;
    input [6:0] input_34;
    input [6:0] input_33;
    input [6:0] input_32;
    input [6:0] input_31;
    input [6:0] input_30;
    input [6:0] input_29;
    input [6:0] input_28;
    input [6:0] input_27;
    input [6:0] input_26;
    input [6:0] input_25;
    input [6:0] input_24;
    input [6:0] input_23;
    input [6:0] input_22;
    input [6:0] input_21;
    input [6:0] input_20;
    input [6:0] input_19;
    input [6:0] input_18;
    input [6:0] input_17;
    input [6:0] input_16;
    input [6:0] input_15;
    input [6:0] input_14;
    input [6:0] input_13;
    input [6:0] input_12;
    input [6:0] input_11;
    input [6:0] input_10;
    input [6:0] input_9;
    input [6:0] input_8;
    input [6:0] input_7;
    input [6:0] input_6;
    input [6:0] input_5;
    input [6:0] input_4;
    input [6:0] input_3;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [35:0] sel;
    reg [6:0] result;
  begin
    result = input_0 & {7{sel[0]}};
    result = result | ( input_1 & {7{sel[1]}});
    result = result | ( input_2 & {7{sel[2]}});
    result = result | ( input_3 & {7{sel[3]}});
    result = result | ( input_4 & {7{sel[4]}});
    result = result | ( input_5 & {7{sel[5]}});
    result = result | ( input_6 & {7{sel[6]}});
    result = result | ( input_7 & {7{sel[7]}});
    result = result | ( input_8 & {7{sel[8]}});
    result = result | ( input_9 & {7{sel[9]}});
    result = result | ( input_10 & {7{sel[10]}});
    result = result | ( input_11 & {7{sel[11]}});
    result = result | ( input_12 & {7{sel[12]}});
    result = result | ( input_13 & {7{sel[13]}});
    result = result | ( input_14 & {7{sel[14]}});
    result = result | ( input_15 & {7{sel[15]}});
    result = result | ( input_16 & {7{sel[16]}});
    result = result | ( input_17 & {7{sel[17]}});
    result = result | ( input_18 & {7{sel[18]}});
    result = result | ( input_19 & {7{sel[19]}});
    result = result | ( input_20 & {7{sel[20]}});
    result = result | ( input_21 & {7{sel[21]}});
    result = result | ( input_22 & {7{sel[22]}});
    result = result | ( input_23 & {7{sel[23]}});
    result = result | ( input_24 & {7{sel[24]}});
    result = result | ( input_25 & {7{sel[25]}});
    result = result | ( input_26 & {7{sel[26]}});
    result = result | ( input_27 & {7{sel[27]}});
    result = result | ( input_28 & {7{sel[28]}});
    result = result | ( input_29 & {7{sel[29]}});
    result = result | ( input_30 & {7{sel[30]}});
    result = result | ( input_31 & {7{sel[31]}});
    result = result | ( input_32 & {7{sel[32]}});
    result = result | ( input_33 & {7{sel[33]}});
    result = result | ( input_34 & {7{sel[34]}});
    result = result | ( input_35 & {7{sel[35]}});
    MUX1HOT_v_7_36_2 = result;
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


  function automatic [7:0] MUX1HOT_v_8_6_2;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [5:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    result = result | ( input_3 & {8{sel[3]}});
    result = result | ( input_4 & {8{sel[4]}});
    result = result | ( input_5 & {8{sel[5]}});
    MUX1HOT_v_8_6_2 = result;
  end
  endfunction


  function automatic [8:0] MUX1HOT_v_9_4_2;
    input [8:0] input_3;
    input [8:0] input_2;
    input [8:0] input_1;
    input [8:0] input_0;
    input [3:0] sel;
    reg [8:0] result;
  begin
    result = input_0 & {9{sel[0]}};
    result = result | ( input_1 & {9{sel[1]}});
    result = result | ( input_2 & {9{sel[2]}});
    result = result | ( input_3 & {9{sel[3]}});
    MUX1HOT_v_9_4_2 = result;
  end
  endfunction


  function automatic [8:0] MUX1HOT_v_9_7_2;
    input [8:0] input_6;
    input [8:0] input_5;
    input [8:0] input_4;
    input [8:0] input_3;
    input [8:0] input_2;
    input [8:0] input_1;
    input [8:0] input_0;
    input [6:0] sel;
    reg [8:0] result;
  begin
    result = input_0 & {9{sel[0]}};
    result = result | ( input_1 & {9{sel[1]}});
    result = result | ( input_2 & {9{sel[2]}});
    result = result | ( input_3 & {9{sel[3]}});
    result = result | ( input_4 & {9{sel[4]}});
    result = result | ( input_5 & {9{sel[5]}});
    result = result | ( input_6 & {9{sel[6]}});
    MUX1HOT_v_9_7_2 = result;
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


  function automatic [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
  end
  endfunction


  function automatic [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
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


  function automatic [0:0] readslicef_14_1_13;
    input [13:0] vector;
    reg [13:0] tmp;
  begin
    tmp = vector >> 13;
    readslicef_14_1_13 = tmp[0:0];
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


  function automatic [3:0] conv_s2u_3_4 ;
    input [2:0]  vector ;
  begin
    conv_s2u_3_4 = {vector[2], vector};
  end
  endfunction


  function automatic [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
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



