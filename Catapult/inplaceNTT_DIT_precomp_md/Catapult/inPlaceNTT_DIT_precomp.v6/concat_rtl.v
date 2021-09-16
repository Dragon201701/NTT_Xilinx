
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

//------> ../td_ccore_solutions/modulo_sub_a48ff83301b11bc89e50b3ecfb088e71634e_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:33:31 2021
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




//------> ../td_ccore_solutions/modulo_add_9e6b06881060c48119593246171fb95f6028_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Sep 16 11:33:32 2021
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
//  Generated date: Thu Sep 16 11:44:08 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_12_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_12_10_32_1024_1024_32_1_gen
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
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_11_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_11_10_32_1024_1024_32_1_gen
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
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_8_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_8_10_32_1024_1024_32_1_gen
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
  ensig_cgo_iro, core_wen, ensig_cgo, COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en
);
  input ensig_cgo_iro;
  input core_wen;
  input ensig_cgo;
  output COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  assign COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en = core_wen & (ensig_cgo | ensig_cgo_iro);
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
  ccs_sync_out_wait_v1 #(.rscid(32'sd13)) complete_rsci (
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
  ccs_sync_in_wait_v1 #(.rscid(32'sd7)) run_rsci (
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
  wire [7:0] fsm_output;
  wire mux_tmp_98;
  wire nor_tmp_31;
  wire or_dcpl_72;
  wire or_dcpl_73;
  wire or_dcpl_76;
  wire or_tmp_103;
  wire mux_tmp_153;
  wire mux_tmp_154;
  wire mux_tmp_155;
  wire mux_tmp_173;
  wire mux_tmp_174;
  wire mux_tmp_175;
  wire and_dcpl_12;
  wire and_dcpl_13;
  wire and_dcpl_14;
  wire and_dcpl_15;
  wire and_dcpl_16;
  wire and_dcpl_17;
  wire and_dcpl_18;
  wire and_dcpl_19;
  wire and_dcpl_20;
  wire and_dcpl_21;
  wire and_dcpl_22;
  wire and_dcpl_23;
  wire or_tmp_123;
  wire or_tmp_126;
  wire mux_tmp_185;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire or_tmp_130;
  wire or_tmp_131;
  wire or_tmp_132;
  wire nor_tmp_37;
  wire mux_tmp_194;
  wire or_tmp_133;
  wire mux_tmp_196;
  wire mux_tmp_197;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire or_tmp_136;
  wire or_tmp_138;
  wire mux_tmp_200;
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
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_56;
  wire and_dcpl_58;
  wire and_dcpl_59;
  wire and_dcpl_60;
  wire and_dcpl_61;
  wire and_dcpl_62;
  wire and_dcpl_63;
  wire and_dcpl_65;
  wire and_dcpl_66;
  wire and_dcpl_68;
  wire and_dcpl_69;
  wire and_dcpl_71;
  wire and_dcpl_72;
  wire and_dcpl_76;
  wire or_tmp_146;
  wire or_tmp_150;
  wire or_tmp_157;
  wire or_tmp_159;
  wire or_tmp_161;
  wire mux_tmp_223;
  wire mux_tmp_226;
  wire or_tmp_177;
  wire or_tmp_178;
  wire mux_tmp_235;
  wire and_dcpl_84;
  wire mux_tmp_247;
  wire and_dcpl_96;
  wire and_dcpl_102;
  wire mux_tmp_249;
  wire nand_tmp_6;
  wire nor_tmp_41;
  wire and_dcpl_104;
  wire mux_tmp_257;
  wire or_tmp_195;
  wire and_dcpl_112;
  wire and_dcpl_117;
  wire and_dcpl_118;
  wire mux_tmp_281;
  wire mux_tmp_282;
  wire or_tmp_220;
  wire mux_tmp_292;
  wire nor_tmp_48;
  wire mux_tmp_299;
  wire mux_tmp_302;
  wire nor_tmp_50;
  wire and_dcpl_164;
  wire and_dcpl_166;
  wire or_tmp_247;
  wire nor_tmp_57;
  wire mux_tmp_342;
  wire not_tmp_166;
  wire or_tmp_257;
  wire mux_tmp_361;
  wire mux_tmp_362;
  wire and_dcpl_177;
  wire mux_tmp_397;
  wire and_dcpl_178;
  wire not_tmp_201;
  wire mux_tmp_407;
  wire or_tmp_314;
  wire or_dcpl_89;
  wire or_dcpl_90;
  wire or_dcpl_91;
  wire or_tmp_329;
  wire or_tmp_332;
  wire mux_tmp_441;
  wire or_tmp_334;
  wire mux_tmp_442;
  wire or_tmp_364;
  wire mux_tmp_478;
  wire mux_tmp_479;
  wire or_dcpl_98;
  wire or_dcpl_99;
  wire or_dcpl_100;
  wire or_dcpl_102;
  wire or_dcpl_113;
  wire or_dcpl_124;
  reg COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm;
  reg [9:0] VEC_LOOP_acc_1_cse_10_sva;
  reg [10:0] STAGE_LOOP_lshift_psp_sva;
  reg [10:0] VEC_LOOP_j_10_10_0_sva_1;
  reg [31:0] mult_res_1_sva;
  wire [32:0] nl_mult_res_1_sva;
  reg [31:0] mult_res_2_sva;
  wire [32:0] nl_mult_res_2_sva;
  reg [31:0] mult_res_3_sva;
  wire [32:0] nl_mult_res_3_sva;
  reg [31:0] mult_res_4_sva;
  wire [32:0] nl_mult_res_4_sva;
  reg [31:0] mult_res_5_sva;
  wire [32:0] nl_mult_res_5_sva;
  reg [31:0] mult_res_6_sva;
  wire [32:0] nl_mult_res_6_sva;
  reg [31:0] mult_res_7_sva;
  wire [32:0] nl_mult_res_7_sva;
  reg [31:0] mult_res_8_sva;
  wire [32:0] nl_mult_res_8_sva;
  reg [31:0] mult_res_9_sva;
  wire [32:0] nl_mult_res_9_sva;
  reg [31:0] mult_res_10_sva;
  wire [32:0] nl_mult_res_10_sva;
  reg [31:0] mult_res_11_sva;
  wire [32:0] nl_mult_res_11_sva;
  reg [31:0] mult_res_12_sva;
  wire [32:0] nl_mult_res_12_sva;
  reg [31:0] mult_res_13_sva;
  wire [32:0] nl_mult_res_13_sva;
  reg [31:0] mult_res_14_sva;
  wire [32:0] nl_mult_res_14_sva;
  reg [31:0] mult_res_15_sva;
  wire [32:0] nl_mult_res_15_sva;
  reg [31:0] mult_res_sva;
  wire [32:0] nl_mult_res_sva;
  reg [31:0] p_sva;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  wire or_232_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_twiddle_rsci_oswt_1_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  wire or_172_cse;
  wire or_169_cse;
  wire and_210_cse;
  wire and_232_cse;
  wire or_246_cse;
  wire or_226_cse;
  wire or_252_cse;
  wire or_33_cse;
  wire or_108_cse;
  wire or_111_cse;
  wire or_444_cse;
  wire nor_77_cse;
  wire nand_36_cse;
  wire or_506_cse;
  wire or_225_cse;
  wire or_507_cse;
  wire or_362_cse;
  wire or_321_cse;
  wire or_191_cse;
  wire or_268_cse;
  wire or_502_cse;
  wire mux_167_cse;
  wire mux_183_cse;
  wire or_515_cse;
  wire or_345_cse;
  wire mux_177_cse;
  wire mux_187_cse;
  wire nand_3_cse;
  wire or_198_cse;
  wire or_207_cse;
  wire mux_276_cse;
  wire mux_188_cse;
  wire mux_274_cse;
  wire nor_119_cse;
  wire mux_277_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [9:0] COMP_LOOP_twiddle_f_mux_rmff;
  wire [5:0] COMP_LOOP_twiddle_f_mux1h_52_rmff;
  wire COMP_LOOP_twiddle_f_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_13_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_38_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_59_rmff;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_91_rmff;
  wire nor_115_rmff;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_149_rmff;
  reg [31:0] factor1_1_sva;
  wire [31:0] mult_res_1_lpi_4_dfm_mx0;
  wire [31:0] mult_res_2_lpi_4_dfm_mx0;
  wire [31:0] mult_res_3_lpi_4_dfm_mx0;
  wire [31:0] mult_res_4_lpi_4_dfm_mx0;
  wire [31:0] mult_res_5_lpi_4_dfm_mx0;
  wire [31:0] mult_res_6_lpi_4_dfm_mx0;
  wire [31:0] mult_res_7_lpi_4_dfm_mx0;
  wire [31:0] mult_res_8_lpi_4_dfm_mx0;
  wire [31:0] mult_res_9_lpi_4_dfm_mx0;
  wire [31:0] mult_res_10_lpi_4_dfm_mx0;
  wire [31:0] mult_res_11_lpi_4_dfm_mx0;
  wire [31:0] mult_res_12_lpi_4_dfm_mx0;
  wire [31:0] mult_res_13_lpi_4_dfm_mx0;
  wire [31:0] mult_res_14_lpi_4_dfm_mx0;
  wire [31:0] mult_res_15_lpi_4_dfm_mx0;
  wire [31:0] mult_res_lpi_4_dfm_mx0;
  reg [9:0] VEC_LOOP_acc_10_cse_1_sva;
  reg [8:0] VEC_LOOP_acc_11_psp_sva;
  reg [6:0] COMP_LOOP_9_twiddle_f_lshift_itm;
  reg [31:0] COMP_LOOP_twiddle_f_sva;
  reg [31:0] COMP_LOOP_10_mult_z_mul_itm;
  wire mux_172_itm;
  wire [5:0] COMP_LOOP_1_twiddle_f_lshift_itm;
  wire mux_278_itm;
  wire and_dcpl;
  wire and_dcpl_184;
  wire and_dcpl_186;
  wire and_dcpl_187;
  wire and_dcpl_188;
  wire and_dcpl_189;
  wire and_dcpl_190;
  wire and_dcpl_191;
  wire and_dcpl_192;
  wire and_dcpl_193;
  wire and_dcpl_194;
  wire and_dcpl_195;
  wire and_dcpl_196;
  wire and_dcpl_197;
  wire and_dcpl_198;
  wire and_dcpl_199;
  wire and_dcpl_201;
  wire and_dcpl_202;
  wire and_dcpl_203;
  wire and_dcpl_204;
  wire and_dcpl_205;
  wire and_dcpl_206;
  wire and_dcpl_207;
  wire and_dcpl_209;
  wire and_dcpl_211;
  wire and_dcpl_214;
  wire and_dcpl_217;
  wire and_dcpl_218;
  wire and_dcpl_219;
  wire and_dcpl_220;
  wire and_dcpl_223;
  wire [9:0] z_out;
  wire [19:0] nl_z_out;
  wire mux_tmp;
  wire or_tmp_372;
  wire mux_tmp_487;
  wire mux_tmp_488;
  wire [63:0] z_out_1;
  wire and_dcpl_248;
  wire [31:0] z_out_2;
  wire [63:0] nl_z_out_2;
  wire and_dcpl_261;
  wire [31:0] z_out_3;
  wire [63:0] nl_z_out_3;
  wire [31:0] z_out_4;
  wire [63:0] nl_z_out_4;
  wire and_dcpl_313;
  wire [31:0] z_out_5;
  wire [63:0] nl_z_out_5;
  wire [9:0] z_out_6;
  wire [10:0] z_out_7;
  wire and_dcpl_352;
  wire [3:0] z_out_8;
  wire [4:0] nl_z_out_8;
  wire and_dcpl_373;
  wire and_dcpl_378;
  wire and_dcpl_383;
  wire and_dcpl_387;
  wire and_dcpl_392;
  wire and_dcpl_397;
  wire [7:0] z_out_10;
  wire and_dcpl_404;
  wire and_dcpl_409;
  wire [6:0] z_out_11;
  wire [7:0] nl_z_out_11;
  wire and_dcpl_429;
  wire [9:0] z_out_12;
  wire [10:0] nl_z_out_12;
  wire and_dcpl_432;
  wire and_dcpl_439;
  wire and_dcpl_444;
  wire and_dcpl_445;
  wire and_dcpl_448;
  wire and_dcpl_449;
  wire and_dcpl_456;
  wire and_dcpl_463;
  wire [9:0] z_out_13;
  wire [10:0] nl_z_out_13;
  wire [9:0] z_out_15;
  wire [10:0] nl_z_out_15;
  wire [9:0] z_out_18;
  wire [10:0] nl_z_out_18;
  wire or_tmp_377;
  wire mux_tmp_496;
  wire not_tmp_380;
  wire and_dcpl_602;
  wire and_dcpl_608;
  wire and_dcpl_609;
  wire and_dcpl_611;
  wire and_dcpl_615;
  wire and_dcpl_618;
  wire and_dcpl_619;
  wire and_dcpl_623;
  wire and_dcpl_627;
  wire and_dcpl_628;
  wire and_dcpl_629;
  wire and_dcpl_630;
  wire and_dcpl_632;
  wire and_dcpl_635;
  wire and_dcpl_637;
  wire and_dcpl_639;
  wire and_dcpl_641;
  wire [10:0] z_out_22;
  wire and_dcpl_692;
  wire and_dcpl_719;
  wire and_dcpl_751;
  wire and_dcpl_757;
  wire and_dcpl_760;
  wire and_dcpl_761;
  wire and_dcpl_765;
  wire and_dcpl_768;
  wire and_dcpl_773;
  wire [8:0] z_out_31;
  wire [31:0] z_out_32;
  wire [31:0] z_out_34;
  wire [31:0] z_out_36;
  wire [31:0] z_out_37;
  wire [31:0] z_out_38;
  wire [31:0] z_out_39;
  wire [31:0] z_out_40;
  wire [31:0] z_out_41;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [9:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva;
  reg [9:0] COMP_LOOP_twiddle_f_mul_cse_sva;
  wire [19:0] nl_COMP_LOOP_twiddle_f_mul_cse_sva;
  reg [31:0] COMP_LOOP_twiddle_help_sva;
  reg [31:0] COMP_LOOP_1_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_2_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_3_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_4_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_5_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_6_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_7_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_8_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_9_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_10_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_11_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_12_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_13_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_14_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_15_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [31:0] COMP_LOOP_16_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm;
  reg [5:0] COMP_LOOP_k_10_4_sva_5_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [31:0] VEC_LOOP_j_1_sva_2;
  wire [32:0] nl_VEC_LOOP_j_1_sva_2;
  wire COMP_LOOP_10_mult_z_mul_itm_mx0c1;
  wire COMP_LOOP_10_mult_z_mul_itm_mx0c2;
  wire COMP_LOOP_10_mult_z_mul_itm_mx0c4;
  wire [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c0;
  wire VEC_LOOP_acc_1_cse_10_sva_mx0c2;
  wire [6:0] COMP_LOOP_9_twiddle_f_mul_psp_sva_1;
  wire [13:0] nl_COMP_LOOP_9_twiddle_f_mul_psp_sva_1;
  wire COMP_LOOP_twiddle_f_or_ssc;
  wire COMP_LOOP_twiddle_f_or_9_cse;
  wire COMP_LOOP_twiddle_f_or_6_cse;
  wire COMP_LOOP_twiddle_f_or_12_cse;
  wire VEC_LOOP_or_4_cse;
  wire VEC_LOOP_or_48_cse;
  wire VEC_LOOP_or_10_cse;
  wire VEC_LOOP_or_51_cse;
  wire VEC_LOOP_or_52_cse;
  wire VEC_LOOP_or_53_cse;
  wire VEC_LOOP_or_54_cse;
  wire VEC_LOOP_or_55_cse;
  wire VEC_LOOP_or_56_cse;
  wire or_447_cse;
  wire and_429_cse;
  wire COMP_LOOP_twiddle_f_and_8_cse;
  wire and_350_cse;
  wire and_293_cse;
  wire and_850_cse;
  wire and_853_cse;
  wire and_859_cse;
  wire and_863_cse;
  wire and_868_cse;
  wire and_869_cse;
  wire and_874_cse;
  wire and_876_cse;
  wire and_885_cse;
  wire mux_tmp_504;
  wire not_tmp;
  wire [7:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt;
  reg [1:0] VEC_LOOP_acc_12_psp_sva_7_6;
  reg [5:0] VEC_LOOP_acc_12_psp_sva_5_0;
  reg [3:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva_7_4;
  reg [3:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0;
  wire and_1049_cse;
  wire nor_220_cse;
  wire or_306_cse;
  wire or_540_cse;
  wire or_567_cse;
  wire mux_515_cse;
  wire or_305_cse;
  wire mux_493_itm;
  wire COMP_LOOP_twiddle_f_nor_1_itm;
  wire COMP_LOOP_twiddle_f_or_itm;
  wire COMP_LOOP_twiddle_f_nor_2_itm;
  wire COMP_LOOP_twiddle_f_or_16_itm;
  wire VEC_LOOP_or_61_itm;
  wire VEC_LOOP_or_67_itm;
  wire and_499_itm;
  wire and_510_itm;
  wire and_524_itm;
  wire VEC_LOOP_or_72_itm;
  wire VEC_LOOP_or_74_itm;
  wire VEC_LOOP_nor_13_itm;
  wire and_854_itm;
  wire and_858_itm;
  wire and_862_itm;
  wire and_866_itm;
  wire and_870_itm;
  wire and_873_itm;
  wire and_877_itm;
  wire and_879_itm;
  wire and_881_itm;
  wire and_884_itm;
  wire and_886_itm;
  wire and_887_itm;
  wire and_890_itm;
  wire and_891_itm;
  wire and_894_itm;
  wire and_895_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire and_533_cse;
  wire [12:0] z_out_9_22_10;
  wire z_out_23_32;
  wire z_out_24_32;
  wire z_out_25_32;
  wire z_out_26_32;
  wire z_out_27_32;
  wire z_out_28_32;
  wire z_out_29_32;
  wire z_out_30_32;
  wire [31:0] mult_if_mux_40_cse;
  wire [9:0] acc_6_cse_10_1;
  wire [10:0] nl_acc_6_cse_10_1;
  wire VEC_LOOP_or_85_cse;

  wire[0:0] mux_171_nl;
  wire[0:0] mux_170_nl;
  wire[0:0] mux_169_nl;
  wire[0:0] mux_168_nl;
  wire[0:0] or_189_nl;
  wire[0:0] or_188_nl;
  wire[0:0] mux_166_nl;
  wire[0:0] mux_165_nl;
  wire[0:0] mux_164_nl;
  wire[0:0] mux_163_nl;
  wire[0:0] mux_162_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] mux_160_nl;
  wire[0:0] mux_159_nl;
  wire[0:0] mux_158_nl;
  wire[0:0] mux_157_nl;
  wire[0:0] mux_156_nl;
  wire[0:0] or_180_nl;
  wire[0:0] nand_2_nl;
  wire[0:0] mux_176_nl;
  wire[0:0] nor_87_nl;
  wire[0:0] or_194_nl;
  wire[0:0] mux_179_nl;
  wire[0:0] nor_86_nl;
  wire[0:0] mux_181_nl;
  wire[0:0] mux_180_nl;
  wire[0:0] mux_178_nl;
  wire[0:0] mux_246_nl;
  wire[0:0] mux_245_nl;
  wire[0:0] mux_244_nl;
  wire[0:0] mux_243_nl;
  wire[0:0] mux_242_nl;
  wire[0:0] or_264_nl;
  wire[0:0] or_263_nl;
  wire[0:0] or_262_nl;
  wire[0:0] mux_241_nl;
  wire[0:0] mux_240_nl;
  wire[0:0] or_261_nl;
  wire[0:0] or_260_nl;
  wire[0:0] mux_239_nl;
  wire[0:0] mux_238_nl;
  wire[0:0] mux_237_nl;
  wire[0:0] or_259_nl;
  wire[0:0] or_258_nl;
  wire[0:0] mux_236_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] or_266_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_13_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_27_nl;
  wire[0:0] mux_256_nl;
  wire[0:0] mux_255_nl;
  wire[0:0] mux_254_nl;
  wire[0:0] or_270_nl;
  wire[0:0] mux_253_nl;
  wire[0:0] mux_252_nl;
  wire[0:0] mux_251_nl;
  wire[0:0] nand_7_nl;
  wire[0:0] or_269_nl;
  wire[0:0] or_267_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl;
  wire[0:0] mux_258_nl;
  wire[5:0] COMP_LOOP_1_twiddle_f_mul_nl;
  wire[11:0] nl_COMP_LOOP_1_twiddle_f_mul_nl;
  wire[0:0] and_112_nl;
  wire[0:0] mux_263_nl;
  wire[0:0] mux_262_nl;
  wire[0:0] mux_261_nl;
  wire[0:0] mux_260_nl;
  wire[0:0] mux_259_nl;
  wire[0:0] or_273_nl;
  wire[0:0] or_272_nl;
  wire[9:0] COMP_LOOP_2_twiddle_f_mul_nl;
  wire[19:0] nl_COMP_LOOP_2_twiddle_f_mul_nl;
  wire[0:0] mux_275_nl;
  wire[0:0] nand_9_nl;
  wire[0:0] mux_273_nl;
  wire[0:0] mux_270_nl;
  wire[0:0] mux_269_nl;
  wire[0:0] mux_287_nl;
  wire[0:0] mux_286_nl;
  wire[0:0] or_293_nl;
  wire[0:0] mux_285_nl;
  wire[0:0] or_292_nl;
  wire[0:0] mux_284_nl;
  wire[0:0] or_291_nl;
  wire[0:0] mux_283_nl;
  wire[0:0] nand_21_nl;
  wire[0:0] mux_289_nl;
  wire[0:0] mux_288_nl;
  wire[0:0] nor_108_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_508_nl;
  wire[0:0] mux_507_nl;
  wire[0:0] mux_506_nl;
  wire[0:0] mux_505_nl;
  wire[0:0] mux_298_nl;
  wire[0:0] mux_306_nl;
  wire[0:0] mux_305_nl;
  wire[0:0] mux_304_nl;
  wire[0:0] mux_303_nl;
  wire[0:0] and_208_nl;
  wire[0:0] mux_301_nl;
  wire[0:0] mux_300_nl;
  wire[0:0] mux_315_nl;
  wire[0:0] mux_314_nl;
  wire[0:0] mux_313_nl;
  wire[0:0] mux_312_nl;
  wire[0:0] mux_311_nl;
  wire[0:0] mux_310_nl;
  wire[0:0] mux_309_nl;
  wire[0:0] mux_308_nl;
  wire[0:0] and_206_nl;
  wire[0:0] mux_307_nl;
  wire[0:0] and_166_nl;
  wire[0:0] mux_510_nl;
  wire[0:0] mux_509_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_513_nl;
  wire[0:0] nor_219_nl;
  wire[0:0] mux_512_nl;
  wire[0:0] or_551_nl;
  wire[0:0] or_550_nl;
  wire[0:0] mux_511_nl;
  wire[0:0] or_548_nl;
  wire[0:0] mux_355_nl;
  wire[0:0] mux_354_nl;
  wire[0:0] mux_353_nl;
  wire[0:0] mux_352_nl;
  wire[0:0] mux_351_nl;
  wire[0:0] or_503_nl;
  wire[0:0] mux_350_nl;
  wire[0:0] or_342_nl;
  wire[0:0] mux_349_nl;
  wire[0:0] mux_348_nl;
  wire[0:0] mux_347_nl;
  wire[0:0] or_341_nl;
  wire[0:0] mux_346_nl;
  wire[0:0] mux_345_nl;
  wire[0:0] mux_344_nl;
  wire[0:0] or_338_nl;
  wire[0:0] or_337_nl;
  wire[0:0] mux_343_nl;
  wire[0:0] or_335_nl;
  wire[0:0] mux_341_nl;
  wire[0:0] mux_340_nl;
  wire[0:0] mux_339_nl;
  wire[0:0] nor_56_nl;
  wire[0:0] mux_338_nl;
  wire[0:0] mux_337_nl;
  wire[0:0] and_205_nl;
  wire[0:0] or_328_nl;
  wire[0:0] or_327_nl;
  wire[31:0] VEC_LOOP_VEC_LOOP_mux_9_nl;
  wire[0:0] COMP_LOOP_twiddle_f_not_1_nl;
  wire[0:0] mux_360_nl;
  wire[0:0] mux_359_nl;
  wire[0:0] mux_358_nl;
  wire[0:0] nor_76_nl;
  wire[0:0] or_353_nl;
  wire[0:0] or_350_nl;
  wire[0:0] mux_357_nl;
  wire[0:0] mux_356_nl;
  wire[0:0] or_347_nl;
  wire[0:0] mux_518_nl;
  wire[0:0] mux_517_nl;
  wire[0:0] mux_516_nl;
  wire[0:0] nor_218_nl;
  wire[0:0] and_1037_nl;
  wire[0:0] mux_514_nl;
  wire[0:0] or_556_nl;
  wire[0:0] VEC_LOOP_or_49_nl;
  wire[0:0] VEC_LOOP_or_50_nl;
  wire[0:0] mux_389_nl;
  wire[0:0] mux_388_nl;
  wire[0:0] mux_365_nl;
  wire[0:0] mux_364_nl;
  wire[0:0] nand_35_nl;
  wire[0:0] mux_385_nl;
  wire[0:0] mux_384_nl;
  wire[0:0] mux_521_nl;
  wire[0:0] mux_520_nl;
  wire[0:0] nor_215_nl;
  wire[0:0] nor_216_nl;
  wire[0:0] nor_217_nl;
  wire[0:0] mux_523_nl;
  wire[0:0] mux_522_nl;
  wire[0:0] nand_42_nl;
  wire[0:0] factor1_or_1_nl;
  wire[0:0] mux_438_nl;
  wire[0:0] mux_437_nl;
  wire[0:0] mux_436_nl;
  wire[0:0] nor_68_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_not_nl;
  wire[0:0] mux_485_nl;
  wire[0:0] mux_484_nl;
  wire[0:0] mux_483_nl;
  wire[0:0] mux_482_nl;
  wire[0:0] or_462_nl;
  wire[0:0] mux_481_nl;
  wire[0:0] or_461_nl;
  wire[0:0] mux_480_nl;
  wire[0:0] or_460_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] or_193_nl;
  wire[0:0] mux_184_nl;
  wire[0:0] nor_85_nl;
  wire[0:0] mux_199_nl;
  wire[0:0] mux_198_nl;
  wire[0:0] mux_195_nl;
  wire[0:0] mux_193_nl;
  wire[0:0] mux_201_nl;
  wire[0:0] mux_202_nl;
  wire[0:0] mux_203_nl;
  wire[0:0] nor_222_nl;
  wire[0:0] nor_223_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] or_234_nl;
  wire[0:0] or_257_nl;
  wire[0:0] nand_22_nl;
  wire[0:0] or_265_nl;
  wire[0:0] mux_250_nl;
  wire[0:0] mux_280_nl;
  wire[0:0] or_288_nl;
  wire[0:0] or_286_nl;
  wire[0:0] or_285_nl;
  wire[0:0] or_290_nl;
  wire[0:0] or_289_nl;
  wire[0:0] mux_291_nl;
  wire[0:0] or_333_nl;
  wire[0:0] or_361_nl;
  wire[0:0] or_390_nl;
  wire[0:0] mux_404_nl;
  wire[0:0] mux_403_nl;
  wire[0:0] mux_400_nl;
  wire[0:0] or_401_nl;
  wire[0:0] mux_405_nl;
  wire[0:0] or_398_nl;
  wire[0:0] mux_408_nl;
  wire[0:0] mux_440_nl;
  wire[0:0] mux_439_nl;
  wire[0:0] or_424_nl;
  wire[0:0] or_426_nl;
  wire[0:0] mux_477_nl;
  wire[0:0] mux_476_nl;
  wire[0:0] or_453_nl;
  wire[0:0] mux_413_nl;
  wire[0:0] mux_412_nl;
  wire[0:0] mux_411_nl;
  wire[0:0] or_406_nl;
  wire[0:0] mux_410_nl;
  wire[0:0] mux_409_nl;
  wire[0:0] or_405_nl;
  wire[0:0] mux_448_nl;
  wire[0:0] mux_447_nl;
  wire[0:0] mux_446_nl;
  wire[0:0] mux_445_nl;
  wire[0:0] mux_444_nl;
  wire[0:0] mux_443_nl;
  wire[0:0] nand_32_nl;
  wire[0:0] mux_457_nl;
  wire[0:0] mux_456_nl;
  wire[0:0] mux_455_nl;
  wire[0:0] or_438_nl;
  wire[6:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_84_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_82_nl;
  wire[0:0] mux_205_nl;
  wire[0:0] mux_204_nl;
  wire[0:0] nor_83_nl;
  wire[5:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_29_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] nor_118_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] mux_212_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] or_230_nl;
  wire[0:0] mux_210_nl;
  wire[0:0] mux_209_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] mux_207_nl;
  wire[0:0] or_227_nl;
  wire[0:0] mux_206_nl;
  wire[0:0] or_222_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] nor_117_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[0:0] mux_219_nl;
  wire[0:0] or_242_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] or_241_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] or_236_nl;
  wire[0:0] mux_215_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] nor_116_nl;
  wire[0:0] mux_234_nl;
  wire[0:0] mux_233_nl;
  wire[0:0] mux_232_nl;
  wire[0:0] mux_231_nl;
  wire[0:0] or_254_nl;
  wire[0:0] nand_5_nl;
  wire[0:0] mux_230_nl;
  wire[0:0] mux_229_nl;
  wire[0:0] mux_228_nl;
  wire[0:0] mux_227_nl;
  wire[0:0] mux_225_nl;
  wire[0:0] or_248_nl;
  wire[0:0] mux_224_nl;
  wire[0:0] mux_486_nl;
  wire[0:0] mux_492_nl;
  wire[0:0] or_530_nl;
  wire[0:0] mux_491_nl;
  wire[0:0] mux_490_nl;
  wire[0:0] mux_489_nl;
  wire[0:0] or_529_nl;
  wire[0:0] mux_495_nl;
  wire[0:0] mux_494_nl;
  wire[0:0] or_534_nl;
  wire[0:0] or_533_nl;
  wire[0:0] or_541_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_15_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_144_nl;
  wire[7:0] COMP_LOOP_twiddle_f_mux1h_145_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_16_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_17_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl;
  wire[3:0] COMP_LOOP_twiddle_f_mux1h_146_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_28_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_29_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_7_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl;
  wire[31:0] mult_z_mux1h_1_nl;
  wire[0:0] and_1050_nl;
  wire[0:0] and_1051_nl;
  wire[0:0] and_1052_nl;
  wire[0:0] nor_225_nl;
  wire[31:0] mult_z_mux1h_4_nl;
  wire[0:0] and_1053_nl;
  wire[0:0] and_1054_nl;
  wire[0:0] and_1055_nl;
  wire[0:0] and_1056_nl;
  wire[31:0] mult_z_mux1h_5_nl;
  wire[0:0] and_1057_nl;
  wire[0:0] and_1058_nl;
  wire[0:0] and_1059_nl;
  wire[0:0] and_1060_nl;
  wire[31:0] mult_z_mux1h_6_nl;
  wire[0:0] and_1061_nl;
  wire[0:0] and_1062_nl;
  wire[0:0] and_1063_nl;
  wire[0:0] and_1064_nl;
  wire[31:0] mult_z_mux1h_7_nl;
  wire[0:0] and_1065_nl;
  wire[0:0] and_1066_nl;
  wire[0:0] and_1067_nl;
  wire[0:0] and_1068_nl;
  wire[3:0] STAGE_LOOP_mux_4_nl;
  wire[23:0] acc_1_nl;
  wire[24:0] nl_acc_1_nl;
  wire[21:0] VEC_LOOP_mux_16_nl;
  wire[0:0] VEC_LOOP_or_78_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl;
  wire[8:0] acc_2_nl;
  wire[9:0] nl_acc_2_nl;
  wire[7:0] VEC_LOOP_mux1h_38_nl;
  wire[0:0] VEC_LOOP_or_79_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_2_nl;
  wire[0:0] VEC_LOOP_and_16_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_10_nl;
  wire[3:0] VEC_LOOP_mux1h_39_nl;
  wire[0:0] VEC_LOOP_or_80_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_11_nl;
  wire[0:0] VEC_LOOP_mux_17_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_12_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_3_nl;
  wire[5:0] VEC_LOOP_VEC_LOOP_mux_11_nl;
  wire[6:0] VEC_LOOP_mux1h_40_nl;
  wire[9:0] VEC_LOOP_mux_18_nl;
  wire[9:0] VEC_LOOP_mux_19_nl;
  wire[3:0] VEC_LOOP_or_81_nl;
  wire[3:0] VEC_LOOP_mux1h_41_nl;
  wire[0:0] and_1069_nl;
  wire[0:0] and_1070_nl;
  wire[0:0] and_1071_nl;
  wire[0:0] and_1072_nl;
  wire[0:0] and_1073_nl;
  wire[0:0] and_1074_nl;
  wire[0:0] and_1075_nl;
  wire[0:0] and_1076_nl;
  wire[0:0] and_1077_nl;
  wire[0:0] and_1078_nl;
  wire[2:0] VEC_LOOP_or_82_nl;
  wire[2:0] VEC_LOOP_nor_21_nl;
  wire[2:0] VEC_LOOP_mux1h_42_nl;
  wire[0:0] and_1079_nl;
  wire[0:0] and_1080_nl;
  wire[0:0] and_1081_nl;
  wire[0:0] and_1082_nl;
  wire[9:0] VEC_LOOP_mux_20_nl;
  wire[0:0] and_1083_nl;
  wire[11:0] acc_14_nl;
  wire[12:0] nl_acc_14_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_13_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_12_nl;
  wire[0:0] VEC_LOOP_or_83_nl;
  wire[0:0] mux_524_nl;
  wire[0:0] mux_525_nl;
  wire[0:0] or_570_nl;
  wire[0:0] mux_526_nl;
  wire[0:0] nand_44_nl;
  wire[0:0] mux_527_nl;
  wire[0:0] mux_528_nl;
  wire[0:0] or_571_nl;
  wire[0:0] mux_529_nl;
  wire[0:0] and_1084_nl;
  wire[5:0] VEC_LOOP_VEC_LOOP_mux_13_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_14_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;
  wire[0:0] and_1085_nl;
  wire[33:0] acc_15_nl;
  wire[34:0] nl_acc_15_nl;
  wire[33:0] acc_16_nl;
  wire[34:0] nl_acc_16_nl;
  wire[31:0] mult_if_mux_41_nl;
  wire[0:0] and_1086_nl;
  wire[33:0] acc_17_nl;
  wire[34:0] nl_acc_17_nl;
  wire[31:0] mult_if_mux_42_nl;
  wire[0:0] and_1087_nl;
  wire[33:0] acc_18_nl;
  wire[34:0] nl_acc_18_nl;
  wire[31:0] mult_if_mux_43_nl;
  wire[33:0] acc_19_nl;
  wire[34:0] nl_acc_19_nl;
  wire[31:0] mult_if_mux_44_nl;
  wire[0:0] and_1088_nl;
  wire[33:0] acc_20_nl;
  wire[34:0] nl_acc_20_nl;
  wire[31:0] mult_if_mux_45_nl;
  wire[33:0] acc_21_nl;
  wire[34:0] nl_acc_21_nl;
  wire[31:0] mult_if_mux_46_nl;
  wire[0:0] and_1089_nl;
  wire[33:0] acc_22_nl;
  wire[34:0] nl_acc_22_nl;
  wire[31:0] mult_if_mux_47_nl;
  wire[0:0] and_1090_nl;
  wire[9:0] acc_23_nl;
  wire[10:0] nl_acc_23_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_18_nl;
  wire[7:0] VEC_LOOP_VEC_LOOP_mux_14_nl;
  wire[0:0] VEC_LOOP_or_84_nl;
  wire[0:0] VEC_LOOP_and_23_nl;
  wire[4:0] VEC_LOOP_VEC_LOOP_mux_15_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_19_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_20_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_21_nl;
  wire[32:0] acc_24_nl;
  wire[33:0] nl_acc_24_nl;
  wire[32:0] acc_26_nl;
  wire[33:0] nl_acc_26_nl;
  wire[31:0] mult_if_mux_49_nl;
  wire[0:0] and_1092_nl;
  wire[32:0] acc_28_nl;
  wire[33:0] nl_acc_28_nl;
  wire[31:0] mult_if_mux_50_nl;
  wire[0:0] and_1093_nl;
  wire[32:0] acc_29_nl;
  wire[33:0] nl_acc_29_nl;
  wire[31:0] mult_if_mux_51_nl;
  wire[0:0] and_1094_nl;
  wire[32:0] acc_30_nl;
  wire[33:0] nl_acc_30_nl;
  wire[31:0] mult_if_mux_52_nl;
  wire[0:0] and_1095_nl;
  wire[32:0] acc_31_nl;
  wire[33:0] nl_acc_31_nl;
  wire[31:0] mult_if_mux_53_nl;
  wire[32:0] acc_32_nl;
  wire[33:0] nl_acc_32_nl;
  wire[31:0] mult_if_mux_54_nl;
  wire[0:0] and_1096_nl;
  wire[32:0] acc_33_nl;
  wire[33:0] nl_acc_33_nl;
  wire[31:0] mult_if_mux_55_nl;

  // Interconnect Declarations for Component Instantiations 
  wire[32:0] acc_27_nl;
  wire[33:0] nl_acc_27_nl;
  wire[31:0] VEC_LOOP_mux1h_44_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign VEC_LOOP_mux1h_44_nl = MUX1HOT_v_32_16_2((~ mult_res_1_lpi_4_dfm_mx0), (~
      mult_res_2_lpi_4_dfm_mx0), (~ mult_res_3_lpi_4_dfm_mx0), (~ mult_res_4_lpi_4_dfm_mx0),
      (~ mult_res_5_lpi_4_dfm_mx0), (~ mult_res_6_lpi_4_dfm_mx0), (~ mult_res_7_lpi_4_dfm_mx0),
      (~ mult_res_8_lpi_4_dfm_mx0), (~ mult_res_9_lpi_4_dfm_mx0), (~ mult_res_10_lpi_4_dfm_mx0),
      (~ mult_res_11_lpi_4_dfm_mx0), (~ mult_res_12_lpi_4_dfm_mx0), (~ mult_res_13_lpi_4_dfm_mx0),
      (~ mult_res_14_lpi_4_dfm_mx0), (~ mult_res_15_lpi_4_dfm_mx0), (~ mult_res_lpi_4_dfm_mx0),
      {and_854_itm , and_858_itm , and_862_itm , and_866_itm , and_870_itm , and_873_itm
      , and_877_itm , and_879_itm , and_881_itm , and_884_itm , and_886_itm , and_887_itm
      , and_890_itm , and_891_itm , and_894_itm , and_895_itm});
  assign nl_acc_27_nl = ({factor1_1_sva , 1'b1}) + ({VEC_LOOP_mux1h_44_nl , 1'b1});
  assign acc_27_nl = nl_acc_27_nl[32:0];
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = readslicef_33_32_1(acc_27_nl);
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire[31:0] VEC_LOOP_mux1h_43_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat;
  assign VEC_LOOP_mux1h_43_nl = MUX1HOT_v_32_16_2(mult_res_1_lpi_4_dfm_mx0, mult_res_2_lpi_4_dfm_mx0,
      mult_res_3_lpi_4_dfm_mx0, mult_res_4_lpi_4_dfm_mx0, mult_res_5_lpi_4_dfm_mx0,
      mult_res_6_lpi_4_dfm_mx0, mult_res_7_lpi_4_dfm_mx0, mult_res_8_lpi_4_dfm_mx0,
      mult_res_9_lpi_4_dfm_mx0, mult_res_10_lpi_4_dfm_mx0, mult_res_11_lpi_4_dfm_mx0,
      mult_res_12_lpi_4_dfm_mx0, mult_res_13_lpi_4_dfm_mx0, mult_res_14_lpi_4_dfm_mx0,
      mult_res_15_lpi_4_dfm_mx0, mult_res_lpi_4_dfm_mx0, {and_854_itm , and_858_itm
      , and_862_itm , and_866_itm , and_870_itm , and_873_itm , and_877_itm , and_879_itm
      , and_881_itm , and_884_itm , and_886_itm , and_887_itm , and_890_itm , and_891_itm
      , and_894_itm , and_895_itm});
  assign nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat = factor1_1_sva + VEC_LOOP_mux1h_43_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat = p_sva;
  wire[0:0] and_391_nl;
  wire [3:0] nl_COMP_LOOP_2_twiddle_f_lshift_rg_s;
  assign and_391_nl = (fsm_output==8'b00000010);
  assign nl_COMP_LOOP_2_twiddle_f_lshift_rg_s = MUX_v_4_2_2(COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0,
      z_out_8, and_391_nl);
  wire[0:0] and_402_nl;
  wire [3:0] nl_COMP_LOOP_9_twiddle_f_lshift_rg_s;
  assign and_402_nl = (fsm_output==8'b00000010);
  assign nl_COMP_LOOP_9_twiddle_f_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva,
      z_out_8, and_402_nl);
  wire[31:0] VEC_LOOP_mux_nl;
  wire [63:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      COMP_LOOP_10_mult_z_mul_itm, and_dcpl_25);
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_nl};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (~ mux_277_cse)};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {nor_119_cse , nor_119_cse};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (~ mux_277_cse)};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIT_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_172_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro;
  assign nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro = ~ mux_278_itm;
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_rsci_1_inst_twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_91_rmff , nor_115_rmff};
  wire [1:0] nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIT_precomp_core_twiddle_h_rsci_1_inst_twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_91_rmff , nor_115_rmff};
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_8_tr0
      = ~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (z_out_31[8]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_10[7]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ (z_out_31[8]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ (z_out_22[10]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_10[6]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_8_tr0
      = VEC_LOOP_j_10_10_0_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (z_out_9_22_10[0]);
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = STAGE_LOOP_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd9),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  modulo_sub  COMP_LOOP_1_modulo_sub_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_sub_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_149_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_149_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd6)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(z_out_8),
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
      .z(z_out_6)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) COMP_LOOP_9_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_9_twiddle_f_lshift_rg_s[3:0]),
      .z(z_out_7)
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
      .vec_rsci_oswt_1_pff(nor_119_cse)
    );
  inPlaceNTT_DIT_precomp_core_wait_dp inPlaceNTT_DIT_precomp_core_wait_dp_inst (
      .ensig_cgo_iro(nl_inPlaceNTT_DIT_precomp_core_wait_dp_inst_ensig_cgo_iro[0:0]),
      .core_wen(complete_rsci_wen_comp),
      .ensig_cgo(reg_ensig_cgo_cse),
      .COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
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
      .twiddle_rsci_oswt_1_pff(and_91_rmff),
      .twiddle_rsci_oswt_pff(nor_115_rmff)
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
      .twiddle_h_rsci_oswt_1_pff(and_91_rmff),
      .twiddle_h_rsci_oswt_pff(nor_115_rmff)
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
  assign mux_167_cse = MUX_s_1_2_2(or_246_cse, or_33_cse, fsm_output[2]);
  assign or_189_nl = (fsm_output[0]) | (~ (fsm_output[6])) | (fsm_output[7]);
  assign mux_168_nl = MUX_s_1_2_2(or_189_nl, or_108_cse, fsm_output[2]);
  assign mux_169_nl = MUX_s_1_2_2(mux_168_nl, mux_tmp_154, fsm_output[4]);
  assign or_188_nl = (fsm_output[4]) | mux_167_cse;
  assign mux_170_nl = MUX_s_1_2_2(mux_169_nl, or_188_nl, fsm_output[5]);
  assign mux_165_nl = MUX_s_1_2_2(or_444_cse, or_111_cse, fsm_output[4]);
  assign mux_163_nl = MUX_s_1_2_2(or_33_cse, or_tmp_103, fsm_output[2]);
  assign mux_164_nl = MUX_s_1_2_2(mux_tmp_155, mux_163_nl, fsm_output[4]);
  assign mux_166_nl = MUX_s_1_2_2(mux_165_nl, mux_164_nl, fsm_output[5]);
  assign mux_171_nl = MUX_s_1_2_2(mux_170_nl, mux_166_nl, fsm_output[3]);
  assign mux_159_nl = MUX_s_1_2_2(or_246_cse, mux_tmp_153, fsm_output[2]);
  assign mux_160_nl = MUX_s_1_2_2(mux_159_nl, or_444_cse, fsm_output[4]);
  assign mux_158_nl = MUX_s_1_2_2(or_111_cse, mux_tmp_155, fsm_output[4]);
  assign mux_161_nl = MUX_s_1_2_2(mux_160_nl, mux_158_nl, fsm_output[5]);
  assign mux_156_nl = MUX_s_1_2_2(mux_tmp_155, mux_tmp_154, fsm_output[4]);
  assign or_180_nl = (fsm_output[4]) | (~ (fsm_output[2])) | (~ (fsm_output[6]))
      | (fsm_output[7]);
  assign mux_157_nl = MUX_s_1_2_2(mux_156_nl, or_180_nl, fsm_output[5]);
  assign mux_162_nl = MUX_s_1_2_2(mux_161_nl, mux_157_nl, fsm_output[3]);
  assign mux_172_itm = MUX_s_1_2_2(mux_171_nl, mux_162_nl, fsm_output[1]);
  assign nor_87_nl = ~((fsm_output[2]) | (~ (fsm_output[4])));
  assign mux_176_nl = MUX_s_1_2_2(mux_tmp_173, nor_87_nl, fsm_output[6]);
  assign nand_2_nl = ~((fsm_output[5]) & mux_176_nl);
  assign or_194_nl = (fsm_output[5]) | (fsm_output[6]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_177_cse = MUX_s_1_2_2(nand_2_nl, or_194_nl, fsm_output[7]);
  assign nor_86_nl = ~((fsm_output[6]) | (fsm_output[2]) | (~ (fsm_output[4])));
  assign mux_179_nl = MUX_s_1_2_2(nor_86_nl, mux_tmp_174, fsm_output[5]);
  assign or_198_cse = (fsm_output[7]) | (~ mux_179_nl);
  assign mux_180_nl = MUX_s_1_2_2(mux_tmp_175, or_198_cse, fsm_output[3]);
  assign mux_178_nl = MUX_s_1_2_2(mux_177_cse, mux_tmp_175, fsm_output[3]);
  assign mux_181_nl = MUX_s_1_2_2(mux_180_nl, mux_178_nl, fsm_output[1]);
  assign nor_119_cse = ~(mux_181_nl | (fsm_output[0]));
  assign or_226_cse = (fsm_output[7]) | (~ (fsm_output[4]));
  assign or_225_cse = (~ (fsm_output[6])) | (fsm_output[7]) | (fsm_output[4]);
  assign or_232_cse = (fsm_output[7:4]!=4'b0101);
  assign or_246_cse = (fsm_output[7:6]!=2'b10);
  assign or_252_cse = (fsm_output[7:6]!=2'b00);
  assign or_264_nl = (fsm_output[5]) | (~((VEC_LOOP_j_10_10_0_sva_1[10]) & (fsm_output[7])));
  assign or_263_nl = (~ (fsm_output[5])) | (~ (VEC_LOOP_j_10_10_0_sva_1[10])) | (fsm_output[7]);
  assign mux_242_nl = MUX_s_1_2_2(or_264_nl, or_263_nl, fsm_output[4]);
  assign or_262_nl = COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm | (fsm_output[4])
      | (fsm_output[5]) | (fsm_output[7]);
  assign mux_243_nl = MUX_s_1_2_2(mux_242_nl, or_262_nl, fsm_output[3]);
  assign mux_244_nl = MUX_s_1_2_2(or_tmp_177, mux_243_nl, fsm_output[2]);
  assign or_261_nl = (fsm_output[4]) | (fsm_output[5]) | (fsm_output[7]);
  assign or_260_nl = (fsm_output[5:4]!=2'b10) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]))
      | (fsm_output[7]);
  assign mux_240_nl = MUX_s_1_2_2(or_261_nl, or_260_nl, fsm_output[3]);
  assign mux_241_nl = MUX_s_1_2_2(mux_240_nl, mux_tmp_235, fsm_output[2]);
  assign mux_245_nl = MUX_s_1_2_2(mux_244_nl, mux_241_nl, fsm_output[1]);
  assign or_259_nl = (fsm_output[5:4]!=2'b00) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]))
      | (fsm_output[7]);
  assign mux_237_nl = MUX_s_1_2_2(or_tmp_178, or_259_nl, fsm_output[3]);
  assign or_258_nl = (fsm_output[5:3]!=3'b011) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]))
      | (fsm_output[7]);
  assign mux_238_nl = MUX_s_1_2_2(mux_237_nl, or_258_nl, fsm_output[2]);
  assign mux_236_nl = MUX_s_1_2_2(mux_tmp_235, or_tmp_177, fsm_output[2]);
  assign mux_239_nl = MUX_s_1_2_2(mux_238_nl, mux_236_nl, fsm_output[1]);
  assign mux_246_nl = MUX_s_1_2_2(mux_245_nl, mux_239_nl, fsm_output[6]);
  assign nor_115_rmff = ~(mux_246_nl | (fsm_output[0]));
  assign or_266_nl = (~ (fsm_output[1])) | (fsm_output[3]) | (fsm_output[6]);
  assign mux_248_nl = MUX_s_1_2_2(or_266_nl, mux_tmp_247, VEC_LOOP_j_10_10_0_sva_1[10]);
  assign and_91_rmff = (~ mux_248_nl) & (~ (fsm_output[5])) & and_dcpl_84;
  assign COMP_LOOP_twiddle_f_or_9_cse = (and_dcpl_23 & and_dcpl_14) | (and_dcpl_45
      & and_dcpl_14) | (and_dcpl_54 & and_dcpl_14) | (and_dcpl_17 & and_dcpl_102);
  assign COMP_LOOP_twiddle_f_or_6_cse = (and_dcpl_68 & and_dcpl_26) | (and_dcpl_38
      & and_dcpl_21) | ((~ or_tmp_133) & and_232_cse & and_dcpl_26) | and_dcpl_96
      | (nor_tmp_37 & and_dcpl_15 & and_dcpl_26) | (and_dcpl_61 & and_dcpl_21);
  assign COMP_LOOP_twiddle_f_or_12_cse = (and_dcpl_36 & and_dcpl_29) | (and_dcpl_59
      & and_dcpl_29);
  assign COMP_LOOP_twiddle_f_mux1h_13_nl = MUX1HOT_s_1_3_2((z_out[1]), (z_out[2]),
      (z_out[0]), {COMP_LOOP_twiddle_f_or_9_cse , COMP_LOOP_twiddle_f_or_6_cse ,
      COMP_LOOP_twiddle_f_or_12_cse});
  assign COMP_LOOP_twiddle_f_mux1h_13_rmff = COMP_LOOP_twiddle_f_mux1h_13_nl & (~((~
      mux_tmp_247) & (~ (fsm_output[5])) & and_dcpl_84));
  assign COMP_LOOP_twiddle_f_mux1h_27_nl = MUX1HOT_s_1_4_2((z_out[2]), (z_out[3]),
      (z_out[1]), (COMP_LOOP_9_twiddle_f_mul_psp_sva_1[0]), {COMP_LOOP_twiddle_f_or_9_cse
      , COMP_LOOP_twiddle_f_or_6_cse , COMP_LOOP_twiddle_f_or_12_cse , and_dcpl_104});
  assign mux_253_nl = MUX_s_1_2_2(mux_tmp_249, (~ nor_tmp_41), fsm_output[4]);
  assign or_270_nl = (fsm_output[5]) | mux_253_nl;
  assign mux_254_nl = MUX_s_1_2_2(nand_tmp_6, or_270_nl, fsm_output[3]);
  assign nand_7_nl = ~((fsm_output[4]) & (~ mux_tmp_249));
  assign or_269_nl = (fsm_output[4]) | (~ nor_tmp_41);
  assign mux_251_nl = MUX_s_1_2_2(nand_7_nl, or_269_nl, fsm_output[5]);
  assign mux_252_nl = MUX_s_1_2_2(mux_251_nl, nand_tmp_6, fsm_output[3]);
  assign mux_255_nl = MUX_s_1_2_2(mux_254_nl, mux_252_nl, fsm_output[1]);
  assign or_267_nl = (fsm_output[6:1]!=6'b000010);
  assign mux_256_nl = MUX_s_1_2_2(mux_255_nl, or_267_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_and_rmff = COMP_LOOP_twiddle_f_mux1h_27_nl & (~(mux_256_nl
      | (fsm_output[0])));
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl = MUX_s_1_2_2((z_out[0]),
      (z_out[1]), COMP_LOOP_twiddle_f_or_6_cse);
  assign mux_258_nl = MUX_s_1_2_2(mux_tmp_257, or_dcpl_76, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_38_rmff = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl
      & (~((~ mux_258_nl) & and_dcpl_20 & (~ (fsm_output[0]))));
  assign nl_COMP_LOOP_1_twiddle_f_mul_nl = COMP_LOOP_1_twiddle_f_lshift_itm * COMP_LOOP_k_10_4_sva_5_0;
  assign COMP_LOOP_1_twiddle_f_mul_nl = nl_COMP_LOOP_1_twiddle_f_mul_nl[5:0];
  assign and_112_nl = and_dcpl_17 & and_dcpl_21;
  assign COMP_LOOP_twiddle_f_mux1h_52_rmff = MUX1HOT_v_6_5_2(COMP_LOOP_1_twiddle_f_mul_nl,
      (z_out[8:3]), (z_out[9:4]), (z_out[7:2]), (COMP_LOOP_9_twiddle_f_mul_psp_sva_1[6:1]),
      {and_112_nl , COMP_LOOP_twiddle_f_or_9_cse , COMP_LOOP_twiddle_f_or_6_cse ,
      COMP_LOOP_twiddle_f_or_12_cse , and_dcpl_104});
  assign mux_259_nl = MUX_s_1_2_2(or_540_cse, or_tmp_195, fsm_output[4]);
  assign mux_260_nl = MUX_s_1_2_2(or_tmp_132, mux_259_nl, fsm_output[3]);
  assign mux_261_nl = MUX_s_1_2_2(mux_tmp_257, mux_260_nl, fsm_output[2]);
  assign or_273_nl = (fsm_output[6:2]!=5'b00001);
  assign mux_262_nl = MUX_s_1_2_2(mux_261_nl, or_273_nl, fsm_output[7]);
  assign or_272_nl = (fsm_output[7:2]!=6'b000000);
  assign mux_263_nl = MUX_s_1_2_2(mux_262_nl, or_272_nl, fsm_output[1]);
  assign COMP_LOOP_twiddle_f_mux1h_59_rmff = (z_out[0]) & (mux_263_nl | (fsm_output[0]));
  assign nl_COMP_LOOP_2_twiddle_f_mul_nl = z_out_6 * ({COMP_LOOP_k_10_4_sva_5_0 ,
      4'b0001});
  assign COMP_LOOP_2_twiddle_f_mul_nl = nl_COMP_LOOP_2_twiddle_f_mul_nl[9:0];
  assign COMP_LOOP_twiddle_f_mux_rmff = MUX_v_10_2_2(COMP_LOOP_2_twiddle_f_mul_nl,
      COMP_LOOP_twiddle_f_mul_cse_sva, and_dcpl_104);
  assign mux_274_cse = MUX_s_1_2_2(mux_tmp_185, nand_3_cse, fsm_output[4]);
  assign nand_9_nl = ~((fsm_output[5]) & (~ mux_167_cse));
  assign mux_275_nl = MUX_s_1_2_2(nand_9_nl, or_tmp_123, fsm_output[4]);
  assign mux_276_cse = MUX_s_1_2_2(mux_275_nl, mux_274_cse, fsm_output[3]);
  assign mux_277_cse = MUX_s_1_2_2(mux_276_cse, mux_188_cse, fsm_output[1]);
  assign mux_269_nl = MUX_s_1_2_2(nand_3_cse, mux_183_cse, fsm_output[4]);
  assign mux_270_nl = MUX_s_1_2_2(mux_269_nl, mux_187_cse, fsm_output[3]);
  assign mux_273_nl = MUX_s_1_2_2(mux_188_cse, mux_270_nl, fsm_output[1]);
  assign mux_278_itm = MUX_s_1_2_2(mux_277_cse, mux_273_nl, fsm_output[0]);
  assign or_292_nl = (fsm_output[5]) | (~ mux_tmp_173);
  assign mux_285_nl = MUX_s_1_2_2(or_292_nl, mux_tmp_282, fsm_output[6]);
  assign or_293_nl = (fsm_output[7]) | mux_285_nl;
  assign mux_286_nl = MUX_s_1_2_2(mux_tmp_281, or_293_nl, fsm_output[3]);
  assign nand_21_nl = ~((fsm_output[5]) & mux_tmp_173);
  assign mux_283_nl = MUX_s_1_2_2(mux_tmp_282, nand_21_nl, fsm_output[6]);
  assign or_291_nl = (fsm_output[7]) | mux_283_nl;
  assign mux_284_nl = MUX_s_1_2_2(or_291_nl, mux_tmp_281, fsm_output[3]);
  assign mux_287_nl = MUX_s_1_2_2(mux_286_nl, mux_284_nl, fsm_output[1]);
  assign and_149_rmff = (~ mux_287_nl) & (fsm_output[0]);
  assign or_172_cse = (fsm_output[4:3]!=2'b00);
  assign or_169_cse = (fsm_output[1:0]!=2'b00);
  assign or_540_cse = (fsm_output[6:5]!=2'b00);
  assign and_210_cse = (fsm_output[1:0]==2'b11);
  assign or_305_cse = and_210_cse | (fsm_output[2]);
  assign or_506_cse = (fsm_output[5:4]!=2'b00);
  assign or_306_cse = (fsm_output[2:1]!=2'b00);
  assign and_232_cse = (fsm_output[4:3]==2'b11);
  assign and_166_nl = and_dcpl_16 & (fsm_output[4]) & and_dcpl_112 & (~ (fsm_output[7]))
      & (fsm_output[1]) & (~ (fsm_output[0])) & (VEC_LOOP_j_10_10_0_sva_1[10]);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt = MUX_v_8_2_2(({4'b0000
      , z_out_8}), (z_out_6[7:0]), and_166_nl);
  assign and_1049_cse = ((fsm_output[3:0]!=4'b0000)) & (fsm_output[5:4]==2'b11);
  assign nor_220_cse = ~((fsm_output[5:4]!=2'b00));
  assign or_342_nl = (fsm_output[6]) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]));
  assign mux_350_nl = MUX_s_1_2_2((fsm_output[6]), or_342_nl, fsm_output[5]);
  assign or_503_nl = (fsm_output[2]) | mux_350_nl;
  assign mux_349_nl = MUX_s_1_2_2(or_540_cse, (~ nor_tmp_57), fsm_output[2]);
  assign mux_351_nl = MUX_s_1_2_2(or_503_nl, mux_349_nl, fsm_output[1]);
  assign or_341_nl = (fsm_output[6:5]!=2'b00) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]));
  assign mux_347_nl = MUX_s_1_2_2(or_tmp_257, or_341_nl, fsm_output[2]);
  assign mux_348_nl = MUX_s_1_2_2(mux_tmp_342, mux_347_nl, fsm_output[1]);
  assign mux_352_nl = MUX_s_1_2_2(mux_351_nl, mux_348_nl, fsm_output[4]);
  assign or_338_nl = COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm | (fsm_output[6:5]!=2'b00);
  assign mux_344_nl = MUX_s_1_2_2(or_tmp_257, or_338_nl, fsm_output[2]);
  assign or_337_nl = (fsm_output[2]) | (~ (fsm_output[5])) | (fsm_output[6]) | (~
      (VEC_LOOP_j_10_10_0_sva_1[10]));
  assign mux_345_nl = MUX_s_1_2_2(mux_344_nl, or_337_nl, fsm_output[1]);
  assign or_335_nl = (~ (fsm_output[2])) | (fsm_output[5]) | not_tmp_166;
  assign mux_343_nl = MUX_s_1_2_2(or_335_nl, mux_tmp_342, fsm_output[1]);
  assign mux_346_nl = MUX_s_1_2_2(mux_345_nl, mux_343_nl, fsm_output[4]);
  assign mux_353_nl = MUX_s_1_2_2(mux_352_nl, mux_346_nl, fsm_output[3]);
  assign mux_354_nl = MUX_s_1_2_2(mux_353_nl, or_tmp_220, fsm_output[0]);
  assign nor_56_nl = ~((fsm_output[4]) | (fsm_output[1]) | (~ (fsm_output[2])));
  assign mux_339_nl = MUX_s_1_2_2(or_540_cse, or_tmp_247, nor_56_nl);
  assign and_205_nl = (fsm_output[2:1]==2'b11);
  assign mux_337_nl = MUX_s_1_2_2(or_540_cse, or_tmp_247, and_205_nl);
  assign or_328_nl = (fsm_output[1]) | (fsm_output[2]) | (fsm_output[5]) | (fsm_output[6]);
  assign mux_338_nl = MUX_s_1_2_2(mux_337_nl, or_328_nl, fsm_output[4]);
  assign mux_340_nl = MUX_s_1_2_2(mux_339_nl, mux_338_nl, fsm_output[3]);
  assign or_327_nl = and_232_cse | (fsm_output[6:5]!=2'b00);
  assign mux_341_nl = MUX_s_1_2_2(mux_340_nl, or_327_nl, fsm_output[0]);
  assign mux_355_nl = MUX_s_1_2_2((~ mux_354_nl), mux_341_nl, fsm_output[7]);
  assign COMP_LOOP_twiddle_f_and_8_cse = complete_rsci_wen_comp & mux_355_nl;
  assign nand_36_cse = ~((fsm_output[5:4]==2'b11));
  assign or_362_cse = (~ (fsm_output[5])) | (fsm_output[7]);
  assign nor_77_cse = ~((~ (fsm_output[2])) | (fsm_output[4]));
  assign or_345_cse = nor_220_cse | (fsm_output[7]);
  assign mux_515_cse = MUX_s_1_2_2((~ (fsm_output[2])), or_306_cse, fsm_output[3]);
  assign or_502_cse = (fsm_output[7]) | (fsm_output[5]);
  assign VEC_LOOP_or_51_cse = and_dcpl_37 | and_dcpl_60;
  assign VEC_LOOP_or_52_cse = and_dcpl_39 | and_dcpl_51;
  assign VEC_LOOP_or_53_cse = and_dcpl_46 | and_dcpl_49;
  assign VEC_LOOP_or_54_cse = and_dcpl_53 | and_dcpl_58;
  assign VEC_LOOP_or_55_cse = and_dcpl_56 | and_dcpl_69;
  assign VEC_LOOP_or_56_cse = and_dcpl_62 | and_dcpl_65;
  assign VEC_LOOP_or_48_cse = and_dcpl_39 | and_dcpl_62;
  assign or_567_cse = (fsm_output[4:3]!=2'b01);
  assign or_444_cse = (~ (fsm_output[2])) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign VEC_LOOP_or_4_cse = and_dcpl_32 | and_dcpl_49 | and_dcpl_58 | and_dcpl_69;
  assign nl_VEC_LOOP_j_1_sva_2 = COMP_LOOP_twiddle_f_sva + conv_u2u_11_32(STAGE_LOOP_lshift_psp_sva);
  assign VEC_LOOP_j_1_sva_2 = nl_VEC_LOOP_j_1_sva_2[31:0];
  assign mult_res_1_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_32, mult_res_1_sva, z_out_23_32);
  assign mult_res_2_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_32, mult_res_2_sva, z_out_23_32);
  assign mult_res_3_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_34, mult_res_3_sva, z_out_24_32);
  assign mult_res_4_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_34, mult_res_4_sva, z_out_25_32);
  assign mult_res_5_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_36, mult_res_5_sva, z_out_26_32);
  assign mult_res_6_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_36, mult_res_6_sva, z_out_27_32);
  assign mult_res_7_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_37, mult_res_7_sva, z_out_28_32);
  assign nl_COMP_LOOP_9_twiddle_f_mul_psp_sva_1 = COMP_LOOP_9_twiddle_f_lshift_itm
      * ({COMP_LOOP_k_10_4_sva_5_0 , 1'b1});
  assign COMP_LOOP_9_twiddle_f_mul_psp_sva_1 = nl_COMP_LOOP_9_twiddle_f_mul_psp_sva_1[6:0];
  assign mult_res_8_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_38, mult_res_8_sva, z_out_29_32);
  assign mult_res_9_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_39, mult_res_9_sva, z_out_30_32);
  assign mult_res_10_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_40, mult_res_10_sva, z_out_30_32);
  assign mult_res_11_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_41, mult_res_11_sva, z_out_29_32);
  assign mult_res_12_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_41, mult_res_12_sva, z_out_28_32);
  assign mult_res_13_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_40, mult_res_13_sva, z_out_27_32);
  assign mult_res_14_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_39, mult_res_14_sva, z_out_26_32);
  assign mult_res_15_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_38, mult_res_15_sva, z_out_25_32);
  assign mult_res_lpi_4_dfm_mx0 = MUX_v_32_2_2(z_out_37, mult_res_sva, z_out_24_32);
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ z_out_8)}) + 5'b01011;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign or_33_cse = (fsm_output[7:6]!=2'b01);
  assign or_108_cse = (fsm_output[0]) | (fsm_output[7]) | (fsm_output[6]);
  assign or_111_cse = (fsm_output[2]) | (fsm_output[0]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_tmp_98 = MUX_s_1_2_2(or_33_cse, or_252_cse, fsm_output[2]);
  assign or_515_cse = (((fsm_output[4:2]!=3'b000)) & (fsm_output[5])) | (fsm_output[6]);
  assign nor_tmp_31 = or_515_cse & (fsm_output[7]);
  assign or_dcpl_72 = (fsm_output[2]) | (fsm_output[7]);
  assign or_dcpl_73 = or_dcpl_72 | or_169_cse;
  assign or_dcpl_76 = or_540_cse | or_172_cse;
  assign or_tmp_103 = ((fsm_output[0]) & (fsm_output[6])) | (fsm_output[7]);
  assign mux_144_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign mux_tmp_153 = MUX_s_1_2_2(mux_144_nl, or_33_cse, fsm_output[0]);
  assign mux_tmp_154 = MUX_s_1_2_2(mux_tmp_153, or_tmp_103, fsm_output[2]);
  assign mux_tmp_155 = MUX_s_1_2_2(or_tmp_103, or_108_cse, fsm_output[2]);
  assign mux_tmp_173 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[2]);
  assign mux_tmp_174 = MUX_s_1_2_2(nor_77_cse, mux_tmp_173, fsm_output[6]);
  assign or_191_cse = (fsm_output[5]) | (fsm_output[6]) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign or_193_nl = (fsm_output[5]) | (~ mux_tmp_174);
  assign mux_tmp_175 = MUX_s_1_2_2(or_193_nl, or_191_cse, fsm_output[7]);
  assign and_dcpl_12 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_13 = (fsm_output[2]) & (~ (fsm_output[7]));
  assign and_dcpl_14 = and_dcpl_13 & and_dcpl_12;
  assign and_dcpl_15 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_16 = ~((fsm_output[6:5]!=2'b00));
  assign and_dcpl_17 = and_dcpl_16 & and_dcpl_15;
  assign and_dcpl_18 = and_dcpl_17 & and_dcpl_14;
  assign and_dcpl_19 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_20 = ~((fsm_output[2]) | (fsm_output[7]));
  assign and_dcpl_21 = and_dcpl_20 & and_dcpl_19;
  assign and_dcpl_22 = (fsm_output[4:3]==2'b01);
  assign and_dcpl_23 = and_dcpl_16 & and_dcpl_22;
  assign or_tmp_123 = (fsm_output[5]) | mux_tmp_98;
  assign or_tmp_126 = (fsm_output[2]) | (fsm_output[7]) | (fsm_output[6]);
  assign mux_tmp_185 = MUX_s_1_2_2(or_444_cse, or_tmp_126, fsm_output[5]);
  assign or_447_cse = (~ (fsm_output[2])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_183_cse = MUX_s_1_2_2(or_tmp_126, or_447_cse, fsm_output[5]);
  assign or_207_cse = (fsm_output[5]) | mux_167_cse;
  assign mux_187_cse = MUX_s_1_2_2(or_207_cse, mux_tmp_185, fsm_output[4]);
  assign nand_3_cse = ~((fsm_output[5]) & (~ mux_tmp_98));
  assign mux_184_nl = MUX_s_1_2_2(mux_183_cse, or_tmp_123, fsm_output[4]);
  assign mux_188_cse = MUX_s_1_2_2(mux_187_cse, mux_184_nl, fsm_output[3]);
  assign and_dcpl_25 = (~ mux_277_cse) & (fsm_output[0]);
  assign and_dcpl_26 = and_dcpl_13 & and_dcpl_19;
  assign and_dcpl_27 = and_dcpl_23 & and_dcpl_26;
  assign or_tmp_130 = (fsm_output[6:3]!=4'b0001);
  assign or_tmp_131 = (fsm_output[6:3]!=4'b0100);
  assign or_tmp_132 = (fsm_output[6:4]!=3'b011);
  assign nor_tmp_37 = (fsm_output[6:5]==2'b11);
  assign mux_tmp_194 = MUX_s_1_2_2((~ nor_tmp_37), or_540_cse, fsm_output[4]);
  assign or_tmp_133 = (fsm_output[6:5]!=2'b01);
  assign mux_tmp_196 = MUX_s_1_2_2((~ or_tmp_133), nor_tmp_37, fsm_output[4]);
  assign nor_85_nl = ~((fsm_output[6:4]!=3'b101));
  assign mux_tmp_197 = MUX_s_1_2_2(nor_85_nl, mux_tmp_196, fsm_output[3]);
  assign mux_195_nl = MUX_s_1_2_2(mux_tmp_194, or_tmp_132, fsm_output[3]);
  assign mux_198_nl = MUX_s_1_2_2((~ mux_tmp_197), mux_195_nl, fsm_output[2]);
  assign mux_193_nl = MUX_s_1_2_2(or_tmp_131, or_tmp_130, fsm_output[2]);
  assign mux_199_nl = MUX_s_1_2_2(mux_198_nl, mux_193_nl, fsm_output[7]);
  assign and_dcpl_28 = (~ mux_199_nl) & and_dcpl_12;
  assign and_dcpl_29 = and_dcpl_20 & and_dcpl_12;
  assign and_dcpl_31 = and_dcpl_16 & and_232_cse;
  assign and_dcpl_32 = and_dcpl_31 & and_dcpl_29;
  assign or_tmp_136 = (fsm_output[6:3]!=4'b0010);
  assign or_tmp_138 = (fsm_output[6:4]!=3'b100);
  assign mux_tmp_200 = MUX_s_1_2_2(or_tmp_138, mux_tmp_194, fsm_output[3]);
  assign mux_201_nl = MUX_s_1_2_2(mux_tmp_200, or_tmp_136, fsm_output[7]);
  assign and_dcpl_35 = (~ mux_201_nl) & (fsm_output[2:0]==3'b110);
  assign and_dcpl_36 = (~ or_tmp_133) & and_dcpl_15;
  assign and_dcpl_37 = and_dcpl_36 & and_dcpl_21;
  assign and_dcpl_38 = (~ or_tmp_133) & and_dcpl_22;
  assign and_dcpl_39 = and_dcpl_38 & and_dcpl_14;
  assign mux_202_nl = MUX_s_1_2_2(nand_36_cse, or_506_cse, fsm_output[7]);
  assign and_dcpl_43 = ~(mux_202_nl | (fsm_output[6]) | (fsm_output[3]) | (fsm_output[2])
      | (~ and_dcpl_19));
  assign and_dcpl_44 = (fsm_output[4:3]==2'b10);
  assign and_dcpl_45 = (~ or_tmp_133) & and_dcpl_44;
  assign and_dcpl_46 = and_dcpl_45 & and_dcpl_26;
  assign and_dcpl_47 = (fsm_output[6:5]==2'b10);
  assign and_dcpl_49 = and_dcpl_47 & and_dcpl_15 & and_dcpl_29;
  assign and_dcpl_50 = and_dcpl_47 & and_dcpl_22;
  assign and_dcpl_51 = and_dcpl_50 & and_dcpl_21;
  assign and_dcpl_52 = and_dcpl_47 & and_dcpl_44;
  assign and_dcpl_53 = and_dcpl_52 & and_dcpl_14;
  assign and_dcpl_54 = and_dcpl_47 & and_232_cse;
  assign and_dcpl_55 = and_dcpl_54 & and_dcpl_21;
  assign and_dcpl_56 = and_dcpl_54 & and_dcpl_26;
  assign and_dcpl_58 = nor_tmp_37 & and_dcpl_22 & and_dcpl_29;
  assign and_dcpl_59 = nor_tmp_37 & and_dcpl_44;
  assign and_dcpl_60 = and_dcpl_59 & and_dcpl_21;
  assign and_dcpl_61 = nor_tmp_37 & and_232_cse;
  assign and_dcpl_62 = and_dcpl_61 & and_dcpl_14;
  assign and_dcpl_63 = (fsm_output[2]) & (fsm_output[7]);
  assign and_dcpl_65 = and_dcpl_17 & and_dcpl_63 & and_dcpl_19;
  assign and_dcpl_66 = (~ (fsm_output[2])) & (fsm_output[7]);
  assign and_dcpl_68 = and_dcpl_16 & and_dcpl_44;
  assign and_dcpl_69 = and_dcpl_68 & and_dcpl_66 & and_dcpl_12;
  assign and_dcpl_71 = and_dcpl_31 & and_dcpl_66 & and_dcpl_19;
  assign and_dcpl_72 = ~((fsm_output[7]) | (fsm_output[0]));
  assign nor_222_nl = ~((fsm_output[3:2]!=2'b01));
  assign nor_223_nl = ~((fsm_output[3:2]!=2'b10));
  assign mux_203_nl = MUX_s_1_2_2(nor_222_nl, nor_223_nl, fsm_output[1]);
  assign and_dcpl_76 = mux_203_nl & (~ (fsm_output[6])) & nor_220_cse & and_dcpl_72;
  assign or_tmp_146 = (fsm_output[6]) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign or_tmp_150 = (fsm_output[6]) | (~ (fsm_output[7])) | (fsm_output[4]);
  assign or_234_nl = (~ (fsm_output[7])) | (fsm_output[4]);
  assign mux_214_nl = MUX_s_1_2_2(or_234_nl, or_226_cse, fsm_output[5]);
  assign or_tmp_157 = (fsm_output[6]) | mux_214_nl;
  assign or_tmp_159 = (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[4]);
  assign or_tmp_161 = (fsm_output[5]) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign mux_tmp_223 = MUX_s_1_2_2(or_tmp_146, or_225_cse, fsm_output[5]);
  assign mux_tmp_226 = MUX_s_1_2_2(or_tmp_150, or_tmp_146, fsm_output[5]);
  assign or_tmp_177 = (fsm_output[5:3]!=3'b100) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]))
      | (fsm_output[7]);
  assign or_tmp_178 = ~((fsm_output[5:4]==2'b11) & (VEC_LOOP_j_10_10_0_sva_1[10])
      & (~ (fsm_output[7])));
  assign or_257_nl = (fsm_output[5:4]!=2'b01) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]))
      | (fsm_output[7]);
  assign mux_tmp_235 = MUX_s_1_2_2(or_257_nl, or_tmp_178, fsm_output[3]);
  assign and_dcpl_84 = (~ (fsm_output[4])) & (~ (fsm_output[2])) & and_dcpl_72;
  assign nand_22_nl = ~((fsm_output[3]) & (fsm_output[6]));
  assign or_265_nl = (fsm_output[3]) | (fsm_output[6]);
  assign mux_tmp_247 = MUX_s_1_2_2(nand_22_nl, or_265_nl, fsm_output[1]);
  assign and_dcpl_96 = and_dcpl_52 & and_dcpl_21;
  assign and_dcpl_102 = and_dcpl_63 & and_dcpl_12;
  assign mux_tmp_249 = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), fsm_output[2]);
  assign or_268_cse = (fsm_output[2]) | (fsm_output[6]);
  assign mux_250_nl = MUX_s_1_2_2(or_268_cse, mux_tmp_249, fsm_output[4]);
  assign nand_tmp_6 = ~((fsm_output[5]) & (~ mux_250_nl));
  assign nor_tmp_41 = (fsm_output[2]) & (fsm_output[6]);
  assign and_dcpl_104 = and_dcpl_50 & and_dcpl_29;
  assign mux_tmp_257 = MUX_s_1_2_2((~ mux_tmp_196), or_tmp_138, fsm_output[3]);
  assign or_tmp_195 = (fsm_output[6:5]!=2'b10);
  assign and_dcpl_112 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_117 = and_dcpl_63 & (fsm_output[1:0]==2'b01);
  assign and_dcpl_118 = and_dcpl_36 & and_dcpl_117;
  assign or_288_nl = (~ (fsm_output[5])) | (fsm_output[2]) | (~ (fsm_output[4]));
  assign or_286_nl = (fsm_output[5]) | (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_280_nl = MUX_s_1_2_2(or_288_nl, or_286_nl, fsm_output[6]);
  assign or_285_nl = (fsm_output[6:5]!=2'b00) | (~ mux_tmp_173);
  assign mux_tmp_281 = MUX_s_1_2_2(mux_280_nl, or_285_nl, fsm_output[7]);
  assign or_290_nl = (fsm_output[2]) | (~ (fsm_output[4]));
  assign or_289_nl = (~ (fsm_output[2])) | (fsm_output[4]);
  assign mux_tmp_282 = MUX_s_1_2_2(or_290_nl, or_289_nl, fsm_output[5]);
  assign or_tmp_220 = (fsm_output[6:2]!=5'b00000);
  assign mux_291_nl = MUX_s_1_2_2((~ or_tmp_220), or_515_cse, fsm_output[7]);
  assign mux_tmp_292 = MUX_s_1_2_2(mux_291_nl, nor_tmp_31, fsm_output[1]);
  assign or_507_cse = (fsm_output[5:3]!=3'b000);
  assign nor_tmp_48 = or_507_cse & (fsm_output[6]);
  assign mux_tmp_299 = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), or_507_cse);
  assign mux_tmp_302 = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), or_506_cse);
  assign nor_tmp_50 = ((fsm_output[3]) | (fsm_output[5])) & (fsm_output[6]);
  assign or_321_cse = (~ (fsm_output[7])) | (fsm_output[5]);
  assign and_dcpl_164 = and_dcpl_16 & (~ (fsm_output[4]));
  assign and_dcpl_166 = and_dcpl_164 & (fsm_output[3]) & (fsm_output[2]) & (~ (fsm_output[7]))
      & (~ (fsm_output[1])) & (~ COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm) &
      (~ (fsm_output[0]));
  assign or_tmp_247 = (fsm_output[6:5]!=2'b00) | (VEC_LOOP_j_10_10_0_sva_1[10]);
  assign nor_tmp_57 = (fsm_output[6:5]==2'b11) & (VEC_LOOP_j_10_10_0_sva_1[10]);
  assign or_333_nl = (fsm_output[6:5]!=2'b01) | (~ (VEC_LOOP_j_10_10_0_sva_1[10]));
  assign mux_tmp_342 = MUX_s_1_2_2((~ nor_tmp_57), or_333_nl, fsm_output[2]);
  assign not_tmp_166 = ~((fsm_output[6]) & (VEC_LOOP_j_10_10_0_sva_1[10]));
  assign or_tmp_257 = (fsm_output[5]) | not_tmp_166;
  assign mux_tmp_361 = MUX_s_1_2_2(or_321_cse, or_345_cse, fsm_output[6]);
  assign or_361_nl = (fsm_output[5]) | (~((~ (fsm_output[4])) | (fsm_output[7])));
  assign mux_tmp_362 = MUX_s_1_2_2(or_361_nl, or_345_cse, fsm_output[6]);
  assign and_dcpl_177 = and_dcpl_16 & (~((fsm_output[3]) ^ (fsm_output[1]))) & (~
      (fsm_output[4])) & (fsm_output[2]) & (~ (fsm_output[7])) & (fsm_output[0]);
  assign or_390_nl = (fsm_output[5]) | (~((fsm_output[6]) & mux_tmp_173));
  assign mux_tmp_397 = MUX_s_1_2_2(or_390_nl, or_191_cse, fsm_output[7]);
  assign mux_403_nl = MUX_s_1_2_2(mux_tmp_397, or_198_cse, fsm_output[3]);
  assign mux_400_nl = MUX_s_1_2_2(mux_177_cse, mux_tmp_397, fsm_output[3]);
  assign mux_404_nl = MUX_s_1_2_2(mux_403_nl, mux_400_nl, fsm_output[1]);
  assign and_dcpl_178 = (~ mux_404_nl) & (fsm_output[0]);
  assign not_tmp_201 = ~((fsm_output[2]) & (fsm_output[6]));
  assign or_401_nl = (~ (fsm_output[5])) | (fsm_output[7]) | mux_tmp_249;
  assign or_398_nl = (fsm_output[7]) | not_tmp_201;
  assign mux_405_nl = MUX_s_1_2_2(or_tmp_126, or_398_nl, fsm_output[5]);
  assign mux_tmp_407 = MUX_s_1_2_2(or_401_nl, mux_405_nl, fsm_output[4]);
  assign mux_408_nl = MUX_s_1_2_2(not_tmp_201, or_268_cse, fsm_output[7]);
  assign or_tmp_314 = (fsm_output[5]) | mux_408_nl;
  assign or_dcpl_89 = (fsm_output[1:0]!=2'b10);
  assign or_dcpl_90 = (~ (fsm_output[2])) | (fsm_output[7]);
  assign or_dcpl_91 = or_dcpl_90 | or_dcpl_89;
  assign or_tmp_329 = (fsm_output[7:5]!=3'b001);
  assign or_tmp_332 = (fsm_output[7:5]!=3'b100);
  assign mux_440_nl = MUX_s_1_2_2(or_tmp_329, or_tmp_332, fsm_output[2]);
  assign or_424_nl = (fsm_output[7:5]!=3'b011);
  assign mux_439_nl = MUX_s_1_2_2(or_424_nl, or_tmp_329, fsm_output[2]);
  assign mux_tmp_441 = MUX_s_1_2_2(mux_440_nl, mux_439_nl, fsm_output[4]);
  assign or_tmp_334 = (fsm_output[7:5]!=3'b010);
  assign or_426_nl = (fsm_output[7:5]!=3'b000);
  assign mux_tmp_442 = MUX_s_1_2_2(or_tmp_334, or_426_nl, fsm_output[2]);
  assign or_tmp_364 = (~ (fsm_output[1])) | (fsm_output[3]) | (fsm_output[7]) | (~
      (fsm_output[5]));
  assign mux_476_nl = MUX_s_1_2_2(or_502_cse, or_362_cse, fsm_output[3]);
  assign or_453_nl = (~ (fsm_output[3])) | (fsm_output[7]) | (fsm_output[5]);
  assign mux_477_nl = MUX_s_1_2_2(mux_476_nl, or_453_nl, fsm_output[1]);
  assign mux_tmp_478 = MUX_s_1_2_2(or_tmp_364, mux_477_nl, fsm_output[6]);
  assign mux_tmp_479 = MUX_s_1_2_2(or_321_cse, or_502_cse, fsm_output[3]);
  assign or_dcpl_98 = or_dcpl_72 | or_dcpl_89;
  assign or_dcpl_99 = ~((fsm_output[4:3]==2'b11));
  assign or_dcpl_100 = or_540_cse | or_dcpl_99;
  assign or_dcpl_102 = or_dcpl_90 | or_169_cse;
  assign or_dcpl_113 = (fsm_output[4:3]!=2'b10);
  assign or_dcpl_124 = (fsm_output[2]) | (~ (fsm_output[7]));
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_36 & and_dcpl_102;
  assign or_406_nl = (~ (fsm_output[5])) | (fsm_output[7]) | (fsm_output[2]) | (fsm_output[6]);
  assign mux_411_nl = MUX_s_1_2_2(or_tmp_314, or_406_nl, fsm_output[4]);
  assign mux_412_nl = MUX_s_1_2_2(mux_tmp_407, mux_411_nl, fsm_output[3]);
  assign or_405_nl = (fsm_output[5]) | (fsm_output[7]) | mux_tmp_249;
  assign mux_409_nl = MUX_s_1_2_2(or_405_nl, or_tmp_314, fsm_output[4]);
  assign mux_410_nl = MUX_s_1_2_2(mux_409_nl, mux_tmp_407, fsm_output[3]);
  assign mux_413_nl = MUX_s_1_2_2(mux_412_nl, mux_410_nl, fsm_output[1]);
  assign COMP_LOOP_10_mult_z_mul_itm_mx0c1 = (~ mux_413_nl) & (fsm_output[0]);
  assign COMP_LOOP_10_mult_z_mul_itm_mx0c2 = ~(mux_277_cse | (fsm_output[0]));
  assign COMP_LOOP_10_mult_z_mul_itm_mx0c4 = and_dcpl_31 & and_dcpl_117;
  assign mux_445_nl = MUX_s_1_2_2(or_tmp_332, or_tmp_334, fsm_output[2]);
  assign mux_446_nl = MUX_s_1_2_2(mux_tmp_442, mux_445_nl, fsm_output[4]);
  assign mux_447_nl = MUX_s_1_2_2(mux_tmp_441, mux_446_nl, fsm_output[3]);
  assign nand_32_nl = ~((fsm_output[2]) & (fsm_output[6]) & (~ (fsm_output[7])) &
      (fsm_output[5]));
  assign mux_443_nl = MUX_s_1_2_2(nand_32_nl, mux_tmp_442, fsm_output[4]);
  assign mux_444_nl = MUX_s_1_2_2(mux_443_nl, mux_tmp_441, fsm_output[3]);
  assign mux_448_nl = MUX_s_1_2_2(mux_447_nl, mux_444_nl, fsm_output[1]);
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c0 = (~ mux_448_nl) & (fsm_output[0]);
  assign or_438_nl = (fsm_output[5]) | (fsm_output[2]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_455_nl = MUX_s_1_2_2(or_438_nl, or_207_cse, fsm_output[4]);
  assign mux_456_nl = MUX_s_1_2_2(mux_274_cse, mux_455_nl, fsm_output[3]);
  assign mux_457_nl = MUX_s_1_2_2(mux_456_nl, mux_276_cse, fsm_output[1]);
  assign VEC_LOOP_acc_1_cse_10_sva_mx0c2 = ~(mux_457_nl | (fsm_output[0]));
  assign VEC_LOOP_or_10_cse = and_dcpl_37 | and_dcpl_46 | and_dcpl_51 | and_dcpl_56
      | and_dcpl_60 | and_dcpl_65 | and_dcpl_71;
  assign VEC_LOOP_or_85_cse = and_dcpl_32 | VEC_LOOP_or_55_cse | VEC_LOOP_or_51_cse
      | VEC_LOOP_or_52_cse | VEC_LOOP_or_56_cse | VEC_LOOP_or_53_cse;
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_v_7_6_2((z_out_12[9:3]), (acc_6_cse_10_1[9:3]),
      (z_out_31[8:2]), (z_out_15[9:3]), (z_out_10[7:1]), (z_out_10[6:0]), {and_dcpl_18
      , and_dcpl_27 , VEC_LOOP_or_4_cse , VEC_LOOP_or_10_cse , VEC_LOOP_or_48_cse
      , and_dcpl_53});
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_6_2((z_out_12[2]), (acc_6_cse_10_1[2]),
      (z_out_31[1]), (z_out_15[2]), (z_out_10[0]), (VEC_LOOP_acc_1_cse_10_sva[2]),
      {and_dcpl_18 , and_dcpl_27 , VEC_LOOP_or_4_cse , VEC_LOOP_or_10_cse , VEC_LOOP_or_48_cse
      , and_dcpl_53});
  assign and_84_nl = mux_tmp_197 & and_dcpl_14;
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_5_2((z_out_12[1]), (acc_6_cse_10_1[1]),
      (z_out_31[0]), (z_out_15[1]), (VEC_LOOP_acc_1_cse_10_sva[1]), {and_dcpl_18
      , and_dcpl_27 , VEC_LOOP_or_4_cse , VEC_LOOP_or_10_cse , and_84_nl});
  assign mux_204_nl = MUX_s_1_2_2((~ mux_tmp_200), mux_tmp_197, fsm_output[2]);
  assign nor_83_nl = ~((fsm_output[6:2]!=5'b00100));
  assign mux_205_nl = MUX_s_1_2_2(mux_204_nl, nor_83_nl, fsm_output[7]);
  assign and_82_nl = mux_205_nl & and_dcpl_12;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_4_2((z_out_12[0]), (acc_6_cse_10_1[0]),
      (VEC_LOOP_acc_1_cse_10_sva[0]), (z_out_15[0]), {and_dcpl_18 , and_dcpl_27 ,
      and_82_nl , VEC_LOOP_or_10_cse});
  assign and_29_nl = and_dcpl_23 & and_dcpl_21;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_6_11_2((z_out_10[5:0]), VEC_LOOP_acc_12_psp_sva_5_0,
      (VEC_LOOP_acc_10_cse_1_sva[9:4]), (z_out_15[9:4]), (VEC_LOOP_acc_1_cse_10_sva[9:4]),
      (acc_6_cse_10_1[9:4]), (VEC_LOOP_acc_11_psp_sva[8:3]), ({VEC_LOOP_acc_12_psp_sva_7_6
      , (VEC_LOOP_acc_12_psp_sva_5_0[5:2])}), (z_out_18[9:4]), (COMP_LOOP_9_twiddle_f_lshift_itm[6:1]),
      (z_out_12[9:4]), {and_dcpl_18 , and_29_nl , and_dcpl_25 , and_dcpl_27 , and_dcpl_28
      , VEC_LOOP_or_85_cse , and_dcpl_35 , and_dcpl_43 , VEC_LOOP_or_54_cse , and_dcpl_55
      , and_dcpl_71});
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_10_2((COMP_LOOP_twiddle_f_sva[3]), (VEC_LOOP_acc_10_cse_1_sva[3]),
      (z_out_15[3]), (VEC_LOOP_acc_1_cse_10_sva[3]), (acc_6_cse_10_1[3]), (VEC_LOOP_acc_11_psp_sva[2]),
      (VEC_LOOP_acc_12_psp_sva_5_0[1]), (z_out_18[3]), (COMP_LOOP_9_twiddle_f_lshift_itm[0]),
      (z_out_12[3]), {and_dcpl_76 , and_dcpl_25 , and_dcpl_27 , and_dcpl_28 , VEC_LOOP_or_85_cse
      , and_dcpl_35 , and_dcpl_43 , VEC_LOOP_or_54_cse , and_dcpl_55 , and_dcpl_71});
  assign or_230_nl = (fsm_output[3]) | (~ (fsm_output[6])) | (fsm_output[7]) | (~
      (fsm_output[4]));
  assign mux_210_nl = MUX_s_1_2_2(or_tmp_146, or_tmp_150, fsm_output[3]);
  assign mux_211_nl = MUX_s_1_2_2(or_230_nl, mux_210_nl, fsm_output[2]);
  assign or_227_nl = (fsm_output[7]) | (fsm_output[4]);
  assign mux_207_nl = MUX_s_1_2_2(or_227_nl, or_226_cse, fsm_output[6]);
  assign mux_208_nl = MUX_s_1_2_2(or_tmp_150, mux_207_nl, fsm_output[3]);
  assign mux_206_nl = MUX_s_1_2_2(or_225_cse, or_tmp_146, fsm_output[3]);
  assign mux_209_nl = MUX_s_1_2_2(mux_208_nl, mux_206_nl, fsm_output[2]);
  assign mux_212_nl = MUX_s_1_2_2(mux_211_nl, mux_209_nl, fsm_output[5]);
  assign or_222_nl = (fsm_output[7:2]!=6'b010110);
  assign mux_213_nl = MUX_s_1_2_2(mux_212_nl, or_222_nl, fsm_output[1]);
  assign nor_118_nl = ~(mux_213_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_9_2((COMP_LOOP_twiddle_f_sva[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_15[2]), (VEC_LOOP_acc_1_cse_10_sva[2]), (acc_6_cse_10_1[2]), (VEC_LOOP_acc_11_psp_sva[1]),
      (VEC_LOOP_acc_12_psp_sva_5_0[0]), (z_out_18[2]), (z_out_12[2]), {and_dcpl_76
      , and_dcpl_25 , and_dcpl_27 , nor_118_nl , VEC_LOOP_or_85_cse , and_dcpl_35
      , and_dcpl_43 , VEC_LOOP_or_54_cse , and_dcpl_71});
  assign or_242_nl = (~ (fsm_output[5])) | (~ (fsm_output[7])) | (fsm_output[4]);
  assign mux_219_nl = MUX_s_1_2_2(or_242_nl, or_tmp_161, fsm_output[6]);
  assign or_241_nl = (~ (fsm_output[5])) | (fsm_output[7]) | (~ (fsm_output[4]));
  assign mux_218_nl = MUX_s_1_2_2(or_tmp_159, or_241_nl, fsm_output[6]);
  assign mux_220_nl = MUX_s_1_2_2(mux_219_nl, mux_218_nl, fsm_output[3]);
  assign mux_216_nl = MUX_s_1_2_2(or_tmp_161, or_tmp_159, fsm_output[6]);
  assign mux_217_nl = MUX_s_1_2_2(mux_216_nl, or_tmp_157, fsm_output[3]);
  assign mux_221_nl = MUX_s_1_2_2(mux_220_nl, mux_217_nl, fsm_output[2]);
  assign mux_215_nl = MUX_s_1_2_2(or_tmp_157, or_232_cse, fsm_output[3]);
  assign or_236_nl = (fsm_output[2]) | mux_215_nl;
  assign mux_222_nl = MUX_s_1_2_2(mux_221_nl, or_236_nl, fsm_output[1]);
  assign nor_117_nl = ~(mux_222_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_8_2((COMP_LOOP_twiddle_f_sva[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_15[1]), (VEC_LOOP_acc_1_cse_10_sva[1]), (acc_6_cse_10_1[1]), (VEC_LOOP_acc_11_psp_sva[0]),
      (z_out_18[1]), (z_out_12[1]), {and_dcpl_76 , and_dcpl_25 , and_dcpl_27 , nor_117_nl
      , VEC_LOOP_or_85_cse , and_dcpl_35 , VEC_LOOP_or_54_cse , and_dcpl_71});
  assign or_254_nl = (~ (fsm_output[4])) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign mux_231_nl = MUX_s_1_2_2(or_254_nl, or_tmp_150, fsm_output[5]);
  assign mux_230_nl = MUX_s_1_2_2(or_252_cse, or_33_cse, fsm_output[4]);
  assign nand_5_nl = ~((fsm_output[5]) & (~ mux_230_nl));
  assign mux_232_nl = MUX_s_1_2_2(mux_231_nl, nand_5_nl, fsm_output[3]);
  assign mux_229_nl = MUX_s_1_2_2(mux_tmp_223, mux_tmp_226, fsm_output[3]);
  assign mux_233_nl = MUX_s_1_2_2(mux_232_nl, mux_229_nl, fsm_output[2]);
  assign mux_227_nl = MUX_s_1_2_2(mux_tmp_226, or_232_cse, fsm_output[3]);
  assign mux_224_nl = MUX_s_1_2_2(or_33_cse, or_246_cse, fsm_output[4]);
  assign or_248_nl = (fsm_output[5]) | mux_224_nl;
  assign mux_225_nl = MUX_s_1_2_2(or_248_nl, mux_tmp_223, fsm_output[3]);
  assign mux_228_nl = MUX_s_1_2_2(mux_227_nl, mux_225_nl, fsm_output[2]);
  assign mux_234_nl = MUX_s_1_2_2(mux_233_nl, mux_228_nl, fsm_output[1]);
  assign nor_116_nl = ~(mux_234_nl | (fsm_output[0]));
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_7_2((COMP_LOOP_twiddle_f_sva[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_15[0]), (VEC_LOOP_acc_1_cse_10_sva[0]), (acc_6_cse_10_1[0]), (z_out_18[0]),
      (z_out_12[0]), {and_dcpl_76 , and_dcpl_25 , and_dcpl_27 , nor_116_nl , VEC_LOOP_or_85_cse
      , VEC_LOOP_or_54_cse , and_dcpl_71});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_8_nl , VEC_LOOP_mux1h_6_nl , VEC_LOOP_mux1h_4_nl
      , VEC_LOOP_mux1h_2_nl , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl , VEC_LOOP_mux1h_3_nl
      , VEC_LOOP_mux1h_5_nl , VEC_LOOP_mux1h_7_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_adra_d = {COMP_LOOP_twiddle_f_mux_rmff , COMP_LOOP_twiddle_f_mux1h_52_rmff
      , COMP_LOOP_twiddle_f_and_rmff , COMP_LOOP_twiddle_f_mux1h_13_rmff , COMP_LOOP_twiddle_f_mux1h_38_rmff
      , COMP_LOOP_twiddle_f_mux1h_59_rmff};
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_adra_d = {COMP_LOOP_twiddle_f_mux_rmff , COMP_LOOP_twiddle_f_mux1h_52_rmff
      , COMP_LOOP_twiddle_f_and_rmff , COMP_LOOP_twiddle_f_mux1h_13_rmff , COMP_LOOP_twiddle_f_mux1h_38_rmff
      , COMP_LOOP_twiddle_f_mux1h_59_rmff};
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign and_dcpl = ~((fsm_output[0]) | (fsm_output[4]));
  assign and_dcpl_184 = (fsm_output[3]) & (~ (fsm_output[1]));
  assign and_dcpl_186 = (~ (fsm_output[5])) & (fsm_output[2]);
  assign and_dcpl_187 = ~((fsm_output[7:6]!=2'b00));
  assign and_dcpl_188 = and_dcpl_187 & and_dcpl_186;
  assign and_dcpl_189 = and_dcpl_188 & and_dcpl_184 & and_dcpl;
  assign and_dcpl_190 = (~ (fsm_output[0])) & (fsm_output[4]);
  assign and_dcpl_191 = (~ (fsm_output[3])) & (fsm_output[1]);
  assign and_dcpl_192 = and_dcpl_191 & and_dcpl_190;
  assign and_dcpl_193 = and_dcpl_188 & and_dcpl_192;
  assign and_dcpl_194 = ~((fsm_output[3]) | (fsm_output[1]));
  assign and_dcpl_195 = and_dcpl_194 & and_dcpl;
  assign and_dcpl_196 = (fsm_output[5]) & (~ (fsm_output[2]));
  assign and_dcpl_197 = and_dcpl_187 & and_dcpl_196;
  assign and_dcpl_198 = and_dcpl_197 & and_dcpl_195;
  assign and_dcpl_199 = (fsm_output[3]) & (fsm_output[1]);
  assign and_dcpl_201 = and_dcpl_197 & and_dcpl_199 & and_dcpl;
  assign and_dcpl_202 = and_dcpl_194 & and_dcpl_190;
  assign and_dcpl_203 = (fsm_output[5]) & (fsm_output[2]);
  assign and_dcpl_204 = and_dcpl_187 & and_dcpl_203;
  assign and_dcpl_205 = and_dcpl_204 & and_dcpl_202;
  assign and_dcpl_206 = and_dcpl_199 & and_dcpl_190;
  assign and_dcpl_207 = and_dcpl_204 & and_dcpl_206;
  assign and_dcpl_209 = (fsm_output[7:6]==2'b01);
  assign and_dcpl_211 = and_dcpl_209 & (~ (fsm_output[5])) & (~ (fsm_output[2]))
      & and_dcpl_192;
  assign and_dcpl_214 = and_dcpl_209 & and_dcpl_186 & and_dcpl_184 & and_dcpl_190;
  assign and_dcpl_217 = and_dcpl_209 & and_dcpl_203 & and_dcpl_191 & and_dcpl;
  assign and_dcpl_218 = and_dcpl_209 & and_dcpl_196;
  assign and_dcpl_219 = and_dcpl_218 & and_dcpl_202;
  assign and_dcpl_220 = and_dcpl_218 & and_dcpl_206;
  assign and_dcpl_223 = (fsm_output[7:6]==2'b10) & and_dcpl_186 & and_dcpl_195;
  assign mux_tmp = MUX_s_1_2_2(or_dcpl_90, or_dcpl_72, fsm_output[6]);
  assign or_tmp_372 = (~ (fsm_output[4])) | (fsm_output[6]) | (fsm_output[2]) | (fsm_output[7]);
  assign mux_486_nl = MUX_s_1_2_2(mux_tmp, or_447_cse, fsm_output[4]);
  assign mux_tmp_487 = MUX_s_1_2_2(or_tmp_372, mux_486_nl, fsm_output[5]);
  assign mux_tmp_488 = MUX_s_1_2_2(or_dcpl_124, or_dcpl_90, fsm_output[6]);
  assign mux_491_nl = MUX_s_1_2_2(mux_tmp, mux_tmp_488, fsm_output[4]);
  assign or_530_nl = (fsm_output[5]) | mux_491_nl;
  assign mux_492_nl = MUX_s_1_2_2(mux_tmp_487, or_530_nl, fsm_output[1]);
  assign or_529_nl = (fsm_output[4]) | mux_tmp_488;
  assign mux_489_nl = MUX_s_1_2_2(or_529_nl, or_tmp_372, fsm_output[5]);
  assign mux_490_nl = MUX_s_1_2_2(mux_489_nl, mux_tmp_487, fsm_output[1]);
  assign mux_493_itm = MUX_s_1_2_2(mux_492_nl, mux_490_nl, fsm_output[3]);
  assign and_293_cse = and_dcpl_16 & (fsm_output[2]) & (fsm_output[7]);
  assign and_dcpl_248 = and_dcpl_47 & (fsm_output[2]) & (~ (fsm_output[7]));
  assign and_dcpl_261 = and_dcpl_16 & (~ (fsm_output[2])) & (~ (fsm_output[7]));
  assign and_350_cse = and_dcpl_16 & (~ (fsm_output[2])) & (fsm_output[7]);
  assign and_dcpl_313 = nor_tmp_37 & (fsm_output[2]) & (~ (fsm_output[7]));
  assign and_dcpl_352 = ~((fsm_output!=8'b00000010));
  assign and_429_cse = (fsm_output==8'b10100011);
  assign and_dcpl_373 = and_dcpl_16 & and_dcpl_13 & and_dcpl_194 & and_dcpl;
  assign and_dcpl_378 = and_dcpl_47 & and_dcpl_13 & and_dcpl_194 & and_dcpl_190;
  assign and_dcpl_383 = (fsm_output[6:5]==2'b01) & and_dcpl_13 & and_dcpl_184 & and_dcpl;
  assign and_dcpl_387 = (fsm_output[6:5]==2'b11) & and_dcpl_13 & and_dcpl_184 & and_dcpl_190;
  assign and_dcpl_392 = and_dcpl_16 & (~ (fsm_output[2])) & (fsm_output[7]) & and_dcpl_184
      & (fsm_output[4]) & (fsm_output[0]);
  assign and_dcpl_397 = and_dcpl_47 & (~ (fsm_output[2])) & (~ (fsm_output[7])) &
      and_dcpl_184 & (~ (fsm_output[4])) & (fsm_output[0]);
  assign and_dcpl_404 = (fsm_output[6:5]==2'b00) & and_dcpl_13 & and_dcpl_194 & (~
      (fsm_output[4])) & (~ (fsm_output[0]));
  assign and_dcpl_409 = (fsm_output[6:5]==2'b10) & and_dcpl_13 & and_dcpl_194 & (fsm_output[4])
      & (~ (fsm_output[0]));
  assign and_dcpl_429 = and_dcpl_16 & (~ (fsm_output[2])) & (fsm_output[7]) & (fsm_output[3])
      & (fsm_output[1]) & (fsm_output[4]) & (~ (fsm_output[0]));
  assign and_dcpl_432 = and_dcpl_199 & and_dcpl;
  assign and_dcpl_439 = and_dcpl_184 & and_dcpl_190;
  assign and_dcpl_444 = and_dcpl_191 & and_dcpl;
  assign and_dcpl_445 = (fsm_output[6:5]==2'b01);
  assign and_dcpl_448 = and_dcpl_184 & and_dcpl;
  assign and_dcpl_449 = and_dcpl_445 & and_dcpl_13;
  assign and_dcpl_456 = and_dcpl_47 & and_dcpl_20;
  assign and_dcpl_463 = nor_tmp_37 & and_dcpl_20;
  assign or_tmp_377 = (fsm_output[1]) | (fsm_output[7]) | (~ (fsm_output[3]));
  assign or_534_nl = (fsm_output[7]) | (fsm_output[3]);
  assign or_533_nl = (fsm_output[7]) | (~ (fsm_output[3]));
  assign mux_494_nl = MUX_s_1_2_2(or_534_nl, or_533_nl, fsm_output[1]);
  assign mux_495_nl = MUX_s_1_2_2(mux_494_nl, or_tmp_377, fsm_output[5]);
  assign mux_tmp_496 = MUX_s_1_2_2(or_tmp_364, mux_495_nl, fsm_output[6]);
  assign not_tmp_380 = MUX_s_1_2_2((fsm_output[3]), (~ (fsm_output[3])), fsm_output[7]);
  assign and_dcpl_602 = (fsm_output[4]) & (fsm_output[0]);
  assign and_dcpl_608 = and_dcpl_47 & and_dcpl_13 & and_dcpl_184 & and_dcpl_602;
  assign and_dcpl_609 = (~ (fsm_output[4])) & (fsm_output[0]);
  assign and_dcpl_611 = and_dcpl_199 & and_dcpl_609;
  assign and_dcpl_615 = and_293_cse & and_dcpl_611;
  assign and_dcpl_618 = and_293_cse & and_dcpl_194 & and_dcpl_609;
  assign and_dcpl_619 = and_dcpl_199 & and_dcpl_602;
  assign and_dcpl_623 = nor_tmp_37 & and_dcpl_20 & and_dcpl_619;
  assign and_dcpl_627 = nor_tmp_37 & and_dcpl_13 & and_dcpl_191 & and_dcpl_609;
  assign and_dcpl_628 = and_dcpl_191 & and_dcpl_602;
  assign and_dcpl_629 = and_dcpl_16 & and_dcpl_13;
  assign and_dcpl_630 = and_dcpl_629 & and_dcpl_628;
  assign and_dcpl_632 = and_dcpl_47 & and_dcpl_20 & and_dcpl_628;
  assign and_dcpl_635 = and_dcpl_445 & and_dcpl_20 & and_dcpl_611;
  assign and_dcpl_637 = and_dcpl_449 & and_dcpl_619;
  assign and_dcpl_639 = and_dcpl_449 & and_dcpl_194 & and_dcpl_602;
  assign and_dcpl_641 = and_dcpl_629 & and_dcpl_184 & and_dcpl_609;
  assign and_dcpl_692 = (fsm_output==8'b10001011);
  assign and_dcpl_719 = (fsm_output==8'b01110111);
  assign and_dcpl_751 = and_dcpl_16 & and_dcpl_20 & and_dcpl_184 & and_dcpl_190;
  assign and_dcpl_757 = (fsm_output[6:5]==2'b10) & and_dcpl_20 & and_dcpl_194 & and_dcpl;
  assign and_dcpl_760 = (fsm_output[6:5]==2'b11) & and_dcpl_20;
  assign and_dcpl_761 = and_dcpl_760 & and_dcpl_184 & and_dcpl;
  assign and_dcpl_765 = and_dcpl_16 & (~ (fsm_output[2])) & (fsm_output[7]) & and_dcpl_194
      & and_dcpl_190;
  assign and_dcpl_768 = and_dcpl_760 & and_dcpl_194 & (fsm_output[4]) & (fsm_output[0]);
  assign and_dcpl_773 = (fsm_output[6:5]==2'b01) & and_dcpl_20 & and_dcpl_194 & (~
      (fsm_output[4])) & (fsm_output[0]);
  assign and_850_cse = and_dcpl_184 & and_dcpl_609;
  assign and_853_cse = and_dcpl_16 & and_dcpl_20;
  assign and_859_cse = and_dcpl_184 & and_dcpl_602;
  assign and_863_cse = and_dcpl_191 & and_dcpl_609;
  assign and_868_cse = and_dcpl_194 & and_dcpl_602;
  assign and_869_cse = and_dcpl_445 & and_dcpl_20;
  assign and_874_cse = and_dcpl_194 & and_dcpl_609;
  assign and_876_cse = and_dcpl_47 & and_dcpl_13;
  assign and_885_cse = nor_tmp_37 & and_dcpl_13;
  assign COMP_LOOP_twiddle_f_or_ssc = and_dcpl_193 | and_dcpl_201 | and_dcpl_207
      | and_dcpl_211 | and_dcpl_217 | and_dcpl_220;
  assign or_541_nl = (fsm_output[6]) | (fsm_output[3]) | (fsm_output[4]) | (fsm_output[2]);
  assign mux_tmp_504 = MUX_s_1_2_2((fsm_output[6]), or_541_nl, fsm_output[5]);
  assign not_tmp = ~((fsm_output[6:1]!=6'b000000));
  assign COMP_LOOP_twiddle_f_nor_1_itm = ~(and_dcpl_189 | and_dcpl_198 | and_dcpl_205
      | and_dcpl_214 | and_dcpl_219 | and_dcpl_223);
  assign COMP_LOOP_twiddle_f_or_itm = and_dcpl_205 | and_dcpl_214 | and_dcpl_223;
  assign COMP_LOOP_twiddle_f_nor_2_itm = ~(and_dcpl_198 | and_dcpl_219);
  assign COMP_LOOP_twiddle_f_or_16_itm = and_dcpl_198 | and_dcpl_219;
  assign VEC_LOOP_or_61_itm = and_dcpl_383 | and_dcpl_387;
  assign VEC_LOOP_or_67_itm = and_dcpl_378 | and_dcpl_397;
  assign and_499_itm = and_dcpl_16 & and_dcpl_13 & and_dcpl_432;
  assign and_510_itm = and_dcpl_445 & and_dcpl_20 & and_dcpl_444;
  assign and_524_itm = and_dcpl_47 & and_dcpl_13 & and_dcpl_206;
  assign and_533_cse = and_dcpl_16 & (fsm_output[2]) & (fsm_output[7]) & and_dcpl_444;
  assign VEC_LOOP_or_72_itm = and_dcpl_608 | and_dcpl_615 | and_dcpl_618 | and_dcpl_623
      | and_dcpl_627 | and_dcpl_630 | and_dcpl_632 | and_dcpl_635 | and_dcpl_637
      | and_dcpl_639 | and_dcpl_641;
  assign VEC_LOOP_or_74_itm = and_dcpl_768 | and_dcpl_773;
  assign VEC_LOOP_nor_13_itm = ~(and_dcpl_768 | and_dcpl_773);
  assign and_854_itm = and_853_cse & and_850_cse;
  assign and_858_itm = and_853_cse & and_dcpl_628;
  assign and_862_itm = and_dcpl_16 & and_dcpl_13 & and_859_cse;
  assign and_866_itm = and_dcpl_445 & and_dcpl_13 & and_863_cse;
  assign and_870_itm = and_869_cse & and_868_cse;
  assign and_873_itm = and_869_cse & and_dcpl_619;
  assign and_877_itm = and_876_cse & and_874_cse;
  assign and_879_itm = and_876_cse & and_dcpl_611;
  assign and_881_itm = and_dcpl_47 & and_dcpl_20 & and_859_cse;
  assign and_884_itm = nor_tmp_37 & and_dcpl_20 & and_863_cse;
  assign and_886_itm = and_885_cse & and_850_cse;
  assign and_887_itm = and_885_cse & and_dcpl_628;
  assign and_890_itm = and_350_cse & and_874_cse;
  assign and_891_itm = and_350_cse & and_dcpl_611;
  assign and_894_itm = and_293_cse & and_868_cse;
  assign and_895_itm = and_293_cse & and_dcpl_619;
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp ) begin
      mult_res_1_sva <= nl_mult_res_1_sva[31:0];
      mult_res_2_sva <= nl_mult_res_2_sva[31:0];
      mult_res_3_sva <= nl_mult_res_3_sva[31:0];
      mult_res_4_sva <= nl_mult_res_4_sva[31:0];
      mult_res_5_sva <= nl_mult_res_5_sva[31:0];
      mult_res_6_sva <= nl_mult_res_6_sva[31:0];
      mult_res_7_sva <= nl_mult_res_7_sva[31:0];
      mult_res_8_sva <= nl_mult_res_8_sva[31:0];
      mult_res_9_sva <= nl_mult_res_9_sva[31:0];
      mult_res_10_sva <= nl_mult_res_10_sva[31:0];
      mult_res_11_sva <= nl_mult_res_11_sva[31:0];
      mult_res_12_sva <= nl_mult_res_12_sva[31:0];
      mult_res_13_sva <= nl_mult_res_13_sva[31:0];
      mult_res_14_sva <= nl_mult_res_14_sva[31:0];
      mult_res_15_sva <= nl_mult_res_15_sva[31:0];
      mult_res_sva <= nl_mult_res_sva[31:0];
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
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= ~(or_dcpl_76 | or_dcpl_73);
      reg_vec_rsci_oswt_cse <= ~ mux_172_itm;
      reg_vec_rsci_oswt_1_cse <= nor_119_cse;
      reg_twiddle_rsci_oswt_cse <= nor_115_rmff;
      reg_twiddle_rsci_oswt_1_cse <= and_91_rmff;
      reg_complete_rsci_oswt_cse <= (~ or_tmp_133) & (~ (fsm_output[4])) & and_dcpl_112
          & (fsm_output[7]) & (~ (fsm_output[1])) & (~ (fsm_output[0])) & STAGE_LOOP_acc_itm_4_1;
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_118;
      reg_ensig_cgo_cse <= ~ mux_278_itm;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_289_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_17 & and_dcpl_29) | STAGE_LOOP_i_3_0_sva_mx0c1)
        ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, z_out_8, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_292 ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out_7;
    end
  end
  always @(posedge clk) begin
    if ( mux_508_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_10_4_sva_5_0 <= MUX_v_6_2_2(6'b000000, (z_out_11[5:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_298_nl | (fsm_output[7])) ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= z_out_6;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_306_nl | (fsm_output[7])) ) begin
      COMP_LOOP_twiddle_f_mul_cse_sva <= nl_COMP_LOOP_twiddle_f_mul_cse_sva[9:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_315_nl | (fsm_output[7])) ) begin
      COMP_LOOP_9_twiddle_f_lshift_itm <= MUX_v_7_2_2((z_out_7[6:0]), (z_out_10[6:0]),
          and_dcpl_53);
    end
  end
  always @(posedge clk) begin
    if ( (mux_510_nl | (fsm_output[7])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva_7_4 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt[7:4];
    end
  end
  always @(posedge clk) begin
    if ( (mux_513_nl | (fsm_output[7])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0 <= COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_rgt[3:0];
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_f_and_8_cse ) begin
      COMP_LOOP_twiddle_f_1_sva <= MUX_v_32_2_2((twiddle_rsci_qa_d_mxwt[31:0]), (twiddle_rsci_qa_d_mxwt[63:32]),
          and_dcpl_166);
      COMP_LOOP_twiddle_help_1_sva <= MUX_v_32_2_2((twiddle_h_rsci_qa_d_mxwt[31:0]),
          (twiddle_h_rsci_qa_d_mxwt[63:32]), and_dcpl_166);
    end
  end
  always @(posedge clk) begin
    if ( mux_518_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_twiddle_f_sva <= MUX_v_32_2_2(32'b00000000000000000000000000000000,
          VEC_LOOP_VEC_LOOP_mux_9_nl, COMP_LOOP_twiddle_f_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (and_dcpl_18 | and_dcpl_118) ) begin
      COMP_LOOP_1_VEC_LOOP_slc_VEC_LOOP_acc_22_itm <= MUX_s_1_2_2((z_out_9_22_10[12]),
          run_rsci_ivld_mxwt, and_dcpl_118);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_18 | and_dcpl_27 | and_dcpl_32 | and_dcpl_37
        | and_dcpl_39 | and_dcpl_46 | and_dcpl_49 | and_dcpl_51 | and_dcpl_53 | and_dcpl_56
        | and_dcpl_58 | and_dcpl_60 | and_dcpl_62 | and_dcpl_65 | and_dcpl_69 | and_dcpl_71)
        ) begin
      VEC_LOOP_acc_10_cse_1_sva <= MUX1HOT_v_10_3_2(z_out_12, acc_6_cse_10_1, z_out_18,
          {VEC_LOOP_or_49_nl , VEC_LOOP_or_50_nl , VEC_LOOP_or_54_cse});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_389_nl ) begin
      COMP_LOOP_twiddle_help_sva <= MUX_v_32_2_2(VEC_LOOP_j_1_sva_2, (twiddle_h_rsci_qa_d_mxwt[63:32]),
          and_dcpl_96);
    end
  end
  always @(posedge clk) begin
    if ( mux_521_nl & (~ (fsm_output[7])) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_12_psp_sva_7_6 <= z_out_10[7:6];
    end
  end
  always @(posedge clk) begin
    if ( (~(mux_523_nl | (fsm_output[1]))) & (~ (fsm_output[0])) & (fsm_output[2])
        & (~ (fsm_output[7])) & complete_rsci_wen_comp ) begin
      VEC_LOOP_acc_12_psp_sva_5_0 <= z_out_10[5:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_177 | and_dcpl_178) ) begin
      factor1_1_sva <= MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
          and_dcpl_178);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_177 | COMP_LOOP_10_mult_z_mul_itm_mx0c1
        | COMP_LOOP_10_mult_z_mul_itm_mx0c2 | and_dcpl_178 | COMP_LOOP_10_mult_z_mul_itm_mx0c4)
        ) begin
      COMP_LOOP_10_mult_z_mul_itm <= MUX1HOT_v_32_4_2((vec_rsci_qa_d_mxwt[63:32]),
          (z_out_1[31:0]), COMP_LOOP_1_modulo_sub_cmp_return_rsc_z, (vec_rsci_qa_d_mxwt[31:0]),
          {and_dcpl_177 , factor1_or_1_nl , COMP_LOOP_10_mult_z_mul_itm_mx0c2 , and_dcpl_178});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_dcpl_76 | or_dcpl_91)) ) begin
      COMP_LOOP_1_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_438_nl ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva <= COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (VEC_LOOP_acc_1_cse_10_sva_mx0c0 | and_dcpl_27
        | VEC_LOOP_acc_1_cse_10_sva_mx0c2 | and_dcpl_37 | and_dcpl_46 | and_dcpl_51
        | and_dcpl_56 | and_dcpl_60 | and_dcpl_65 | and_dcpl_71) ) begin
      VEC_LOOP_acc_1_cse_10_sva <= MUX_v_10_2_2(10'b0000000000, VEC_LOOP_VEC_LOOP_mux_2_nl,
          VEC_LOOP_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_10_0_sva_1 <= 11'b00000000000;
    end
    else if ( complete_rsci_wen_comp & (~(mux_485_nl | (fsm_output[0]))) ) begin
      VEC_LOOP_j_10_10_0_sva_1 <= z_out_22;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_136 | or_dcpl_73)) ) begin
      COMP_LOOP_2_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & VEC_LOOP_or_4_cse ) begin
      VEC_LOOP_acc_11_psp_sva <= z_out_31;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_dcpl_100 | or_dcpl_98)) ) begin
      COMP_LOOP_3_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_131 | or_dcpl_102)) ) begin
      COMP_LOOP_4_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_133 | or_567_cse | or_dcpl_91)) ) begin
      COMP_LOOP_5_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_133 | or_dcpl_99 | or_dcpl_73)) ) begin
      COMP_LOOP_6_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_195 | or_172_cse | or_dcpl_98)) ) begin
      COMP_LOOP_7_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_195 | or_567_cse | or_dcpl_102)) ) begin
      COMP_LOOP_8_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_195 | or_dcpl_113 | or_dcpl_91)) ) begin
      COMP_LOOP_9_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~((~ nor_tmp_37) | or_172_cse | or_dcpl_73)) )
        begin
      COMP_LOOP_10_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~((~ nor_tmp_37) | or_567_cse | or_dcpl_98)) )
        begin
      COMP_LOOP_11_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~((~ nor_tmp_37) | or_dcpl_113 | or_dcpl_102))
        ) begin
      COMP_LOOP_12_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~((~ nor_tmp_37) | or_dcpl_99 | or_dcpl_91)) )
        begin
      COMP_LOOP_13_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_130 | or_dcpl_124 | or_169_cse)) ) begin
      COMP_LOOP_14_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_tmp_136 | or_dcpl_124 | or_dcpl_89)) ) begin
      COMP_LOOP_15_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_dcpl_100 | (~ (fsm_output[2])) | (~ (fsm_output[7]))
        | or_169_cse)) ) begin
      COMP_LOOP_16_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm <=
          z_out_1[63:32];
    end
  end
  assign nl_mult_res_1_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_3;
  assign nl_mult_res_2_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_3;
  assign nl_mult_res_3_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_3;
  assign nl_mult_res_4_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_4;
  assign nl_mult_res_5_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_5;
  assign nl_mult_res_6_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_2;
  assign nl_mult_res_7_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_2;
  assign nl_mult_res_8_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_2;
  assign nl_mult_res_9_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_2;
  assign nl_mult_res_10_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_5;
  assign nl_mult_res_11_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_5;
  assign nl_mult_res_12_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_5;
  assign nl_mult_res_13_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_4;
  assign nl_mult_res_14_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_4;
  assign nl_mult_res_15_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_4;
  assign nl_mult_res_sva  = COMP_LOOP_10_mult_z_mul_itm - z_out_3;
  assign nor_108_nl = ~((or_172_cse & (fsm_output[5])) | (fsm_output[6]));
  assign mux_288_nl = MUX_s_1_2_2(or_tmp_220, nor_108_nl, fsm_output[7]);
  assign mux_289_nl = MUX_s_1_2_2((~ mux_288_nl), nor_tmp_31, or_169_cse);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_292;
  assign mux_507_nl = MUX_s_1_2_2(not_tmp, mux_tmp_504, fsm_output[7]);
  assign mux_505_nl = MUX_s_1_2_2(mux_tmp_504, or_540_cse, fsm_output[1]);
  assign mux_506_nl = MUX_s_1_2_2(not_tmp, mux_505_nl, fsm_output[7]);
  assign mux_508_nl = MUX_s_1_2_2(mux_507_nl, mux_506_nl, fsm_output[0]);
  assign mux_298_nl = MUX_s_1_2_2(and_dcpl_17, and_dcpl_61, or_305_cse);
  assign nl_COMP_LOOP_twiddle_f_mul_cse_sva  = z_out_6 * ({COMP_LOOP_k_10_4_sva_5_0
      , 4'b1111});
  assign and_208_nl = or_506_cse & (fsm_output[6]);
  assign mux_303_nl = MUX_s_1_2_2(mux_tmp_302, and_208_nl, fsm_output[3]);
  assign mux_304_nl = MUX_s_1_2_2(mux_303_nl, nor_tmp_48, fsm_output[2]);
  assign mux_301_nl = MUX_s_1_2_2(mux_tmp_299, nor_tmp_48, fsm_output[2]);
  assign mux_305_nl = MUX_s_1_2_2(mux_304_nl, mux_301_nl, fsm_output[1]);
  assign mux_300_nl = MUX_s_1_2_2(mux_tmp_299, nor_tmp_48, or_306_cse);
  assign mux_306_nl = MUX_s_1_2_2(mux_305_nl, mux_300_nl, fsm_output[0]);
  assign mux_312_nl = MUX_s_1_2_2(mux_tmp_302, nor_tmp_37, fsm_output[3]);
  assign mux_313_nl = MUX_s_1_2_2(mux_312_nl, nor_tmp_48, fsm_output[2]);
  assign mux_311_nl = MUX_s_1_2_2(mux_tmp_299, nor_tmp_50, fsm_output[2]);
  assign mux_314_nl = MUX_s_1_2_2(mux_313_nl, mux_311_nl, fsm_output[1]);
  assign and_206_nl = ((fsm_output[5:4]!=2'b01)) & (fsm_output[6]);
  assign mux_308_nl = MUX_s_1_2_2(mux_tmp_302, and_206_nl, fsm_output[3]);
  assign mux_309_nl = MUX_s_1_2_2(mux_308_nl, nor_tmp_50, fsm_output[2]);
  assign mux_307_nl = MUX_s_1_2_2(nor_tmp_48, nor_tmp_50, fsm_output[2]);
  assign mux_310_nl = MUX_s_1_2_2(mux_309_nl, mux_307_nl, fsm_output[1]);
  assign mux_315_nl = MUX_s_1_2_2(mux_314_nl, mux_310_nl, fsm_output[0]);
  assign nor_nl = ~(((fsm_output[1]) & (fsm_output[0]) & (fsm_output[2]) & (fsm_output[4]))
      | (fsm_output[5]));
  assign mux_509_nl = MUX_s_1_2_2(nor_nl, nor_220_cse, fsm_output[3]);
  assign mux_510_nl = MUX_s_1_2_2(mux_509_nl, and_1049_cse, fsm_output[6]);
  assign or_551_nl = (fsm_output[2]) | (fsm_output[4]) | (fsm_output[5]);
  assign or_548_nl = (~ (VEC_LOOP_j_10_10_0_sva_1[10])) | (fsm_output[5:4]!=2'b01);
  assign mux_511_nl = MUX_s_1_2_2(or_506_cse, or_548_nl, fsm_output[2]);
  assign or_550_nl = (fsm_output[0]) | mux_511_nl;
  assign mux_512_nl = MUX_s_1_2_2(or_551_nl, or_550_nl, fsm_output[1]);
  assign nor_219_nl = ~((fsm_output[3]) | mux_512_nl);
  assign mux_513_nl = MUX_s_1_2_2(nor_219_nl, and_1049_cse, fsm_output[6]);
  assign VEC_LOOP_VEC_LOOP_mux_9_nl = MUX_v_32_2_2(COMP_LOOP_twiddle_help_sva, (twiddle_rsci_qa_d_mxwt[63:32]),
      and_dcpl_96);
  assign nor_76_nl = ~(nor_77_cse | (fsm_output[7]));
  assign or_353_nl = (fsm_output[2]) | and_210_cse | (fsm_output[4]) | (~ (fsm_output[7]));
  assign mux_358_nl = MUX_s_1_2_2(nor_76_nl, or_353_nl, fsm_output[5]);
  assign or_350_nl = (fsm_output[5]) | (~((~(((fsm_output[2]) & (fsm_output[0]))
      | (fsm_output[1]) | (fsm_output[4]))) | (fsm_output[7])));
  assign mux_359_nl = MUX_s_1_2_2(mux_358_nl, or_350_nl, fsm_output[3]);
  assign or_347_nl = (~((fsm_output[2:1]!=2'b00))) | (~ (fsm_output[4])) | (fsm_output[7]);
  assign mux_356_nl = MUX_s_1_2_2(or_347_nl, (fsm_output[7]), fsm_output[5]);
  assign mux_357_nl = MUX_s_1_2_2(mux_356_nl, or_345_cse, fsm_output[3]);
  assign mux_360_nl = MUX_s_1_2_2(mux_359_nl, mux_357_nl, fsm_output[6]);
  assign COMP_LOOP_twiddle_f_not_1_nl = ~ mux_360_nl;
  assign nor_218_nl = ~((fsm_output[6]) | mux_515_cse);
  assign and_1037_nl = (fsm_output[6]) & ((fsm_output[3]) | or_305_cse);
  assign mux_516_nl = MUX_s_1_2_2(nor_218_nl, and_1037_nl, fsm_output[4]);
  assign mux_517_nl = MUX_s_1_2_2(mux_516_nl, (fsm_output[6]), fsm_output[5]);
  assign or_556_nl = (fsm_output[4]) | (fsm_output[6]) | (fsm_output[3]) | or_305_cse;
  assign mux_514_nl = MUX_s_1_2_2((fsm_output[6]), or_556_nl, fsm_output[5]);
  assign mux_518_nl = MUX_s_1_2_2((~ mux_517_nl), mux_514_nl, fsm_output[7]);
  assign VEC_LOOP_or_49_nl = and_dcpl_18 | and_dcpl_71;
  assign VEC_LOOP_or_50_nl = and_dcpl_27 | and_dcpl_32 | VEC_LOOP_or_55_cse | VEC_LOOP_or_51_cse
      | VEC_LOOP_or_52_cse | VEC_LOOP_or_56_cse | VEC_LOOP_or_53_cse;
  assign nand_35_nl = ~(nand_36_cse & (fsm_output[7]));
  assign mux_364_nl = MUX_s_1_2_2(nand_35_nl, or_362_cse, fsm_output[6]);
  assign mux_365_nl = MUX_s_1_2_2(mux_364_nl, mux_tmp_361, and_210_cse);
  assign mux_385_nl = MUX_s_1_2_2(mux_tmp_361, mux_tmp_362, or_169_cse);
  assign mux_388_nl = MUX_s_1_2_2(mux_365_nl, mux_385_nl, fsm_output[2]);
  assign mux_384_nl = MUX_s_1_2_2(mux_tmp_362, mux_tmp_361, fsm_output[2]);
  assign mux_389_nl = MUX_s_1_2_2(mux_388_nl, mux_384_nl, fsm_output[3]);
  assign nor_215_nl = ~((fsm_output[4]) | mux_515_cse);
  assign nor_216_nl = ~((fsm_output[4:0]!=5'b01100));
  assign mux_520_nl = MUX_s_1_2_2(nor_215_nl, nor_216_nl, fsm_output[5]);
  assign nor_217_nl = ~((fsm_output[5:0]!=6'b111100));
  assign mux_521_nl = MUX_s_1_2_2(mux_520_nl, nor_217_nl, fsm_output[6]);
  assign mux_522_nl = MUX_s_1_2_2(or_172_cse, or_567_cse, fsm_output[5]);
  assign nand_42_nl = ~((fsm_output[5:3]==3'b111));
  assign mux_523_nl = MUX_s_1_2_2(mux_522_nl, nand_42_nl, fsm_output[6]);
  assign factor1_or_1_nl = COMP_LOOP_10_mult_z_mul_itm_mx0c1 | COMP_LOOP_10_mult_z_mul_itm_mx0c4;
  assign mux_437_nl = MUX_s_1_2_2(and_dcpl_164, or_dcpl_76, fsm_output[7]);
  assign nor_68_nl = ~(((fsm_output[3:2]==2'b11)) | (fsm_output[6:4]!=3'b000));
  assign mux_436_nl = MUX_s_1_2_2(nor_68_nl, or_tmp_220, fsm_output[7]);
  assign mux_438_nl = MUX_s_1_2_2(mux_437_nl, mux_436_nl, or_169_cse);
  assign VEC_LOOP_VEC_LOOP_mux_2_nl = MUX_v_10_2_2(z_out_15, (VEC_LOOP_j_10_10_0_sva_1[9:0]),
      VEC_LOOP_acc_1_cse_10_sva_mx0c2);
  assign VEC_LOOP_not_nl = ~ VEC_LOOP_acc_1_cse_10_sva_mx0c0;
  assign or_462_nl = (~ (fsm_output[3])) | (~ (fsm_output[7])) | (fsm_output[5]);
  assign mux_482_nl = MUX_s_1_2_2(mux_tmp_479, or_462_nl, fsm_output[1]);
  assign mux_483_nl = MUX_s_1_2_2(mux_482_nl, or_tmp_364, fsm_output[6]);
  assign mux_484_nl = MUX_s_1_2_2(mux_tmp_478, mux_483_nl, fsm_output[4]);
  assign or_460_nl = (~ (fsm_output[3])) | (fsm_output[7]) | (~ (fsm_output[5]));
  assign mux_480_nl = MUX_s_1_2_2(or_460_nl, mux_tmp_479, fsm_output[1]);
  assign or_461_nl = (fsm_output[6]) | mux_480_nl;
  assign mux_481_nl = MUX_s_1_2_2(or_461_nl, mux_tmp_478, fsm_output[4]);
  assign mux_485_nl = MUX_s_1_2_2(mux_484_nl, mux_481_nl, fsm_output[2]);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl = (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[9])
      & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_mux1h_144_nl = MUX1HOT_s_1_3_2((COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1[8]),
      (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[8]), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[8]),
      {and_dcpl_189 , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_itm});
  assign COMP_LOOP_twiddle_f_and_15_nl = COMP_LOOP_twiddle_f_mux1h_144_nl & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_mux1h_145_nl = MUX1HOT_v_8_4_2((COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1[7:0]),
      (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[7:0]), ({COMP_LOOP_5_twiddle_f_lshift_ncse_sva_7_4
      , COMP_LOOP_5_twiddle_f_lshift_ncse_sva_3_0}), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[7:0]),
      {and_dcpl_189 , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_16_itm
      , COMP_LOOP_twiddle_f_or_itm});
  assign COMP_LOOP_twiddle_f_and_16_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[5]),
      (COMP_LOOP_k_10_4_sva_5_0[4]), COMP_LOOP_twiddle_f_or_ssc);
  assign COMP_LOOP_twiddle_f_and_17_nl = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_6_nl
      & COMP_LOOP_twiddle_f_nor_2_itm;
  assign COMP_LOOP_twiddle_f_or_28_nl = and_dcpl_189 | and_dcpl_205 | and_dcpl_214
      | and_dcpl_223;
  assign COMP_LOOP_twiddle_f_mux1h_146_nl = MUX1HOT_v_4_3_2((COMP_LOOP_k_10_4_sva_5_0[4:1]),
      (COMP_LOOP_k_10_4_sva_5_0[3:0]), (COMP_LOOP_k_10_4_sva_5_0[5:2]), {COMP_LOOP_twiddle_f_or_28_nl
      , COMP_LOOP_twiddle_f_or_ssc , COMP_LOOP_twiddle_f_or_16_itm});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_7_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[0]),
      (COMP_LOOP_k_10_4_sva_5_0[1]), COMP_LOOP_twiddle_f_or_16_itm);
  assign COMP_LOOP_twiddle_f_or_29_nl = (COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_7_nl
      & (~(and_dcpl_193 | and_dcpl_201 | and_dcpl_207))) | and_dcpl_211 | and_dcpl_217
      | and_dcpl_220;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl = ((COMP_LOOP_k_10_4_sva_5_0[0])
      & (~(and_dcpl_189 | and_dcpl_193 | and_dcpl_205 | and_dcpl_211 | and_dcpl_217)))
      | and_dcpl_201 | and_dcpl_207 | and_dcpl_214 | and_dcpl_220 | and_dcpl_223;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl = (~(and_dcpl_189 | and_dcpl_198
      | and_dcpl_201 | and_dcpl_211 | and_dcpl_214 | and_dcpl_220)) | and_dcpl_193
      | and_dcpl_205 | and_dcpl_207 | and_dcpl_217 | and_dcpl_219 | and_dcpl_223;
  assign nl_z_out = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl , COMP_LOOP_twiddle_f_and_15_nl
      , COMP_LOOP_twiddle_f_mux1h_145_nl}) * ({COMP_LOOP_twiddle_f_and_16_nl , COMP_LOOP_twiddle_f_and_17_nl
      , COMP_LOOP_twiddle_f_mux1h_146_nl , COMP_LOOP_twiddle_f_or_29_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_2_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_3_nl , 1'b1});
  assign z_out = nl_z_out[9:0];
  assign and_1050_nl = (~ mux_493_itm) & (fsm_output[0]);
  assign and_1051_nl = and_293_cse & and_dcpl_184 & (fsm_output[4]) & (fsm_output[0]);
  assign and_1052_nl = and_293_cse & and_dcpl_184 & (fsm_output[4]) & (~ (fsm_output[0]));
  assign nor_225_nl = ~(mux_493_itm | (fsm_output[0]));
  assign mult_z_mux1h_1_nl = MUX1HOT_v_32_4_2(COMP_LOOP_twiddle_f_1_sva, COMP_LOOP_twiddle_f_sva,
      COMP_LOOP_twiddle_help_sva, COMP_LOOP_twiddle_help_1_sva, {and_1050_nl , and_1051_nl
      , and_1052_nl , nor_225_nl});
  assign z_out_1 = conv_u2u_64_64(COMP_LOOP_10_mult_z_mul_itm * mult_z_mux1h_1_nl);
  assign and_1053_nl = (fsm_output[6:5]==2'b01) & and_dcpl_20 & and_dcpl_199 & and_dcpl_190;
  assign and_1054_nl = and_dcpl_248 & and_dcpl_194 & and_dcpl;
  assign and_1055_nl = and_dcpl_248 & and_dcpl_199 & and_dcpl;
  assign and_1056_nl = and_dcpl_47 & and_dcpl_20 & (fsm_output[3]) & (~ (fsm_output[1]))
      & and_dcpl_190;
  assign mult_z_mux1h_4_nl = MUX1HOT_v_32_4_2(COMP_LOOP_6_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_7_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm, COMP_LOOP_8_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_9_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm, {and_1053_nl
      , and_1054_nl , and_1055_nl , and_1056_nl});
  assign nl_z_out_2 = mult_z_mux1h_4_nl * p_sva;
  assign z_out_2 = nl_z_out_2[31:0];
  assign and_1057_nl = and_dcpl_261 & and_dcpl_184 & and_dcpl;
  assign and_1058_nl = and_dcpl_261 & (~ (fsm_output[3])) & (fsm_output[1]) & and_dcpl_190;
  assign and_1059_nl = and_dcpl_16 & (fsm_output[2]) & (~ (fsm_output[7])) & and_dcpl_184
      & and_dcpl_190;
  assign and_1060_nl = and_dcpl_16 & (fsm_output[2]) & (fsm_output[7]) & (fsm_output[3])
      & (fsm_output[1]) & and_dcpl_190;
  assign mult_z_mux1h_5_nl = MUX1HOT_v_32_4_2(COMP_LOOP_1_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_2_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm, COMP_LOOP_3_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_16_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      {and_1057_nl , and_1058_nl , and_1059_nl , and_1060_nl});
  assign nl_z_out_3 = mult_z_mux1h_5_nl * p_sva;
  assign z_out_3 = nl_z_out_3[31:0];
  assign and_1061_nl = (fsm_output[5]) & (~ (fsm_output[6])) & (fsm_output[2]) &
      (~ (fsm_output[7])) & (~ (fsm_output[3])) & (fsm_output[1]) & and_dcpl;
  assign and_1062_nl = and_350_cse & and_dcpl_194 & and_dcpl;
  assign and_1063_nl = and_350_cse & (fsm_output[3]) & (fsm_output[1]) & and_dcpl;
  assign and_1064_nl = and_dcpl_16 & (fsm_output[2]) & (fsm_output[7]) & and_dcpl_194
      & (fsm_output[4]) & (~ (fsm_output[0]));
  assign mult_z_mux1h_6_nl = MUX1HOT_v_32_4_2(COMP_LOOP_4_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_13_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_14_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_15_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      {and_1061_nl , and_1062_nl , and_1063_nl , and_1064_nl});
  assign nl_z_out_4 = mult_z_mux1h_6_nl * p_sva;
  assign z_out_4 = nl_z_out_4[31:0];
  assign and_1065_nl = (fsm_output[6:5]==2'b01) & and_dcpl_20 & and_dcpl_194 & and_dcpl_190;
  assign and_1066_nl = nor_tmp_37 & and_dcpl_20 & and_dcpl_191 & and_dcpl;
  assign and_1067_nl = and_dcpl_313 & (fsm_output[3]) & (~ (fsm_output[1])) & and_dcpl;
  assign and_1068_nl = and_dcpl_313 & and_dcpl_191 & and_dcpl_190;
  assign mult_z_mux1h_7_nl = MUX1HOT_v_32_4_2(COMP_LOOP_5_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_10_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_11_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      COMP_LOOP_12_operator_96_false_operator_96_false_slc_mult_t_mul_63_32_itm,
      {and_1065_nl , and_1066_nl , and_1067_nl , and_1068_nl});
  assign nl_z_out_5 = mult_z_mux1h_7_nl * p_sva;
  assign z_out_5 = nl_z_out_5[31:0];
  assign STAGE_LOOP_mux_4_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (~ STAGE_LOOP_i_3_0_sva),
      and_dcpl_352);
  assign nl_z_out_8 = STAGE_LOOP_mux_4_nl + ({and_dcpl_352 , 1'b0 , and_dcpl_352
      , 1'b1});
  assign z_out_8 = nl_z_out_8[3:0];
  assign VEC_LOOP_mux_16_nl = MUX_v_22_2_2((VEC_LOOP_j_1_sva_2[31:10]), ({11'b00000000000
      , z_out_11 , 4'b0000}), and_429_cse);
  assign VEC_LOOP_or_78_nl = (~(and_dcpl_16 & (fsm_output[2]) & (~ (fsm_output[7]))
      & and_dcpl_194 & and_dcpl)) | and_429_cse;
  assign VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl = ~(MUX_v_10_2_2(10'b0000000000, (STAGE_LOOP_lshift_psp_sva[10:1]),
      and_429_cse));
  assign nl_acc_1_nl = conv_u2u_23_24({VEC_LOOP_mux_16_nl , VEC_LOOP_or_78_nl}) +
      conv_s2u_12_24({1'b1 , VEC_LOOP_VEC_LOOP_VEC_LOOP_nand_1_nl , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[23:0];
  assign z_out_9_22_10 = readslicef_24_13_11(acc_1_nl);
  assign VEC_LOOP_mux1h_38_nl = MUX1HOT_v_8_5_2(({2'b00 , (COMP_LOOP_twiddle_f_sva[9:4])}),
      ({1'b0 , (VEC_LOOP_acc_1_cse_10_sva[9:3])}), (VEC_LOOP_acc_1_cse_10_sva[9:2]),
      ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[10:5]))}), ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:4]))}),
      {and_dcpl_373 , and_dcpl_378 , VEC_LOOP_or_61_itm , and_dcpl_392 , and_dcpl_397});
  assign VEC_LOOP_or_79_nl = (~(and_dcpl_373 | and_dcpl_378 | and_dcpl_383 | and_dcpl_387))
      | and_dcpl_392 | and_dcpl_397;
  assign VEC_LOOP_VEC_LOOP_and_2_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & (~(and_dcpl_373
      | and_dcpl_378 | and_dcpl_392 | and_dcpl_397));
  assign VEC_LOOP_VEC_LOOP_mux_10_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[5]),
      (COMP_LOOP_k_10_4_sva_5_0[4]), VEC_LOOP_or_61_itm);
  assign VEC_LOOP_and_16_nl = VEC_LOOP_VEC_LOOP_mux_10_nl & (~(and_dcpl_373 | and_dcpl_392));
  assign VEC_LOOP_or_80_nl = and_dcpl_373 | and_dcpl_392;
  assign VEC_LOOP_mux1h_39_nl = MUX1HOT_v_4_3_2((COMP_LOOP_k_10_4_sva_5_0[5:2]),
      (COMP_LOOP_k_10_4_sva_5_0[4:1]), (COMP_LOOP_k_10_4_sva_5_0[3:0]), {VEC_LOOP_or_80_nl
      , VEC_LOOP_or_67_itm , VEC_LOOP_or_61_itm});
  assign VEC_LOOP_mux_17_nl = MUX_s_1_2_2((COMP_LOOP_k_10_4_sva_5_0[1]), (COMP_LOOP_k_10_4_sva_5_0[0]),
      VEC_LOOP_or_67_itm);
  assign VEC_LOOP_VEC_LOOP_or_11_nl = (VEC_LOOP_mux_17_nl & (~ and_dcpl_383)) | and_dcpl_387;
  assign VEC_LOOP_VEC_LOOP_or_12_nl = ((COMP_LOOP_k_10_4_sva_5_0[0]) & (~ and_dcpl_397))
      | and_dcpl_378 | and_dcpl_383 | and_dcpl_387;
  assign nl_acc_2_nl = ({VEC_LOOP_mux1h_38_nl , VEC_LOOP_or_79_nl}) + ({VEC_LOOP_VEC_LOOP_and_2_nl
      , VEC_LOOP_and_16_nl , VEC_LOOP_mux1h_39_nl , VEC_LOOP_VEC_LOOP_or_11_nl ,
      VEC_LOOP_VEC_LOOP_or_12_nl , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[8:0];
  assign z_out_10 = readslicef_9_8_1(acc_2_nl);
  assign VEC_LOOP_VEC_LOOP_and_3_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & (~(and_dcpl_404
      | and_429_cse));
  assign VEC_LOOP_VEC_LOOP_mux_11_nl = MUX_v_6_2_2(COMP_LOOP_k_10_4_sva_5_0, ({(COMP_LOOP_k_10_4_sva_5_0[4:0])
      , 1'b1}), and_dcpl_409);
  assign VEC_LOOP_mux1h_40_nl = MUX1HOT_v_7_3_2(({1'b0 , (STAGE_LOOP_lshift_psp_sva[10:5])}),
      (STAGE_LOOP_lshift_psp_sva[10:4]), 7'b0000001, {and_dcpl_404 , and_dcpl_409
      , and_429_cse});
  assign nl_z_out_11 = ({VEC_LOOP_VEC_LOOP_and_3_nl , VEC_LOOP_VEC_LOOP_mux_11_nl})
      + VEC_LOOP_mux1h_40_nl;
  assign z_out_11 = nl_z_out_11[6:0];
  assign VEC_LOOP_mux_18_nl = MUX_v_10_2_2(({(z_out_11[5:0]) , (STAGE_LOOP_lshift_psp_sva[4:1])}),
      z_out_13, and_dcpl_429);
  assign VEC_LOOP_mux_19_nl = MUX_v_10_2_2((COMP_LOOP_twiddle_f_sva[9:0]), VEC_LOOP_acc_1_cse_10_sva,
      and_dcpl_429);
  assign nl_z_out_12 = VEC_LOOP_mux_18_nl + VEC_LOOP_mux_19_nl;
  assign z_out_12 = nl_z_out_12[9:0];
  assign and_1069_nl = and_dcpl_16 & and_dcpl_20 & and_dcpl_439;
  assign and_1070_nl = and_dcpl_449 & and_dcpl_448;
  assign and_1071_nl = and_dcpl_449 & and_dcpl_192;
  assign and_1072_nl = and_dcpl_456 & and_dcpl_194 & and_dcpl;
  assign and_1073_nl = and_dcpl_456 & and_dcpl_432;
  assign and_1074_nl = and_dcpl_463 & and_dcpl_448;
  assign and_1075_nl = and_dcpl_463 & and_dcpl_192;
  assign and_1076_nl = nor_tmp_37 & and_dcpl_13 & and_dcpl_439;
  assign and_1077_nl = and_350_cse & and_dcpl_194 & and_dcpl_190;
  assign VEC_LOOP_mux1h_41_nl = MUX1HOT_v_4_13_2(4'b0001, 4'b0010, 4'b0011, 4'b0100,
      4'b0101, 4'b0110, 4'b0111, 4'b1001, 4'b1010, 4'b1011, 4'b1100, 4'b1101, 4'b1110,
      {and_499_itm , and_1069_nl , and_510_itm , and_1070_nl , and_1071_nl , and_1072_nl
      , and_1073_nl , and_524_itm , and_1074_nl , and_1075_nl , and_1076_nl , and_533_cse
      , and_1077_nl});
  assign and_1078_nl = and_350_cse & and_dcpl_206;
  assign VEC_LOOP_or_81_nl = MUX_v_4_2_2(VEC_LOOP_mux1h_41_nl, 4'b1111, and_1078_nl);
  assign nl_z_out_13 = ({COMP_LOOP_k_10_4_sva_5_0 , VEC_LOOP_or_81_nl}) + (STAGE_LOOP_lshift_psp_sva[10:1]);
  assign z_out_13 = nl_z_out_13[9:0];
  assign nl_acc_6_cse_10_1 = z_out_13 + VEC_LOOP_acc_1_cse_10_sva;
  assign acc_6_cse_10_1 = nl_acc_6_cse_10_1[9:0];
  assign and_1079_nl = and_dcpl_445 & and_dcpl_13 & and_dcpl_192;
  assign and_1080_nl = and_dcpl_47 & and_dcpl_20 & and_dcpl_432;
  assign and_1081_nl = (fsm_output[6:5]==2'b11) & and_dcpl_20 & and_dcpl_192;
  assign VEC_LOOP_mux1h_42_nl = MUX1HOT_v_3_6_2(3'b110, 3'b101, 3'b100, 3'b011, 3'b010,
      3'b001, {and_510_itm , and_1079_nl , and_1080_nl , and_524_itm , and_1081_nl
      , and_533_cse});
  assign VEC_LOOP_nor_21_nl = ~(MUX_v_3_2_2(VEC_LOOP_mux1h_42_nl, 3'b111, and_499_itm));
  assign and_1082_nl = and_dcpl_16 & (~ (fsm_output[2])) & (fsm_output[7]) & and_dcpl_206;
  assign VEC_LOOP_or_82_nl = MUX_v_3_2_2(VEC_LOOP_nor_21_nl, 3'b111, and_1082_nl);
  assign nl_z_out_15 = VEC_LOOP_acc_1_cse_10_sva + ({COMP_LOOP_k_10_4_sva_5_0 , VEC_LOOP_or_82_nl
      , 1'b1});
  assign z_out_15 = nl_z_out_15[9:0];
  assign and_1083_nl = (fsm_output[6:5]==2'b11) & and_dcpl_20 & (fsm_output[3]) &
      (~ (fsm_output[1])) & and_dcpl;
  assign VEC_LOOP_mux_20_nl = MUX_v_10_2_2(({z_out_11 , (STAGE_LOOP_lshift_psp_sva[3:1])}),
      z_out_13, and_1083_nl);
  assign nl_z_out_18 = VEC_LOOP_mux_20_nl + VEC_LOOP_acc_1_cse_10_sva;
  assign z_out_18 = nl_z_out_18[9:0];
  assign VEC_LOOP_VEC_LOOP_or_13_nl = (STAGE_LOOP_lshift_psp_sva[10]) | and_dcpl_608
      | and_dcpl_615 | and_dcpl_618 | and_dcpl_623 | and_dcpl_627 | and_dcpl_630
      | and_dcpl_632 | and_dcpl_635 | and_dcpl_637 | and_dcpl_639 | and_dcpl_641;
  assign VEC_LOOP_VEC_LOOP_mux_12_nl = MUX_v_10_2_2((STAGE_LOOP_lshift_psp_sva[9:0]),
      (~ (STAGE_LOOP_lshift_psp_sva[10:1])), VEC_LOOP_or_72_itm);
  assign nand_44_nl = ~((fsm_output[1]) & not_tmp_380);
  assign mux_526_nl = MUX_s_1_2_2(nand_44_nl, or_tmp_377, fsm_output[5]);
  assign or_570_nl = (fsm_output[6]) | mux_526_nl;
  assign mux_525_nl = MUX_s_1_2_2(mux_tmp_496, or_570_nl, fsm_output[2]);
  assign and_1084_nl = (fsm_output[7]) & (fsm_output[3]);
  assign mux_529_nl = MUX_s_1_2_2(not_tmp_380, and_1084_nl, fsm_output[1]);
  assign or_571_nl = (fsm_output[5]) | (~ mux_529_nl);
  assign mux_528_nl = MUX_s_1_2_2(or_571_nl, or_tmp_364, fsm_output[6]);
  assign mux_527_nl = MUX_s_1_2_2(mux_528_nl, mux_tmp_496, fsm_output[2]);
  assign mux_524_nl = MUX_s_1_2_2(mux_525_nl, mux_527_nl, fsm_output[4]);
  assign VEC_LOOP_or_83_nl = mux_524_nl | (fsm_output[0]) | and_dcpl_608 | and_dcpl_615
      | and_dcpl_618 | and_dcpl_623 | and_dcpl_627 | and_dcpl_630 | and_dcpl_632
      | and_dcpl_635 | and_dcpl_637 | and_dcpl_639 | and_dcpl_641;
  assign VEC_LOOP_VEC_LOOP_mux_13_nl = MUX_v_6_2_2((VEC_LOOP_acc_1_cse_10_sva[9:4]),
      COMP_LOOP_k_10_4_sva_5_0, VEC_LOOP_or_72_itm);
  assign VEC_LOOP_VEC_LOOP_or_14_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_dcpl_630
      | and_dcpl_635 | and_dcpl_637 | and_dcpl_639 | and_dcpl_641))) | and_dcpl_608
      | and_dcpl_615 | and_dcpl_618 | and_dcpl_623 | and_dcpl_627 | and_dcpl_632;
  assign VEC_LOOP_VEC_LOOP_or_15_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_dcpl_608
      | and_dcpl_627 | and_dcpl_630 | and_dcpl_632 | and_dcpl_641))) | and_dcpl_615
      | and_dcpl_618 | and_dcpl_623 | and_dcpl_635 | and_dcpl_637 | and_dcpl_639;
  assign VEC_LOOP_VEC_LOOP_or_16_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_dcpl_608
      | and_dcpl_618 | and_dcpl_623 | and_dcpl_632 | and_dcpl_635 | and_dcpl_639
      | and_dcpl_641))) | and_dcpl_615 | and_dcpl_627 | and_dcpl_630 | and_dcpl_637;
  assign VEC_LOOP_VEC_LOOP_or_17_nl = ((VEC_LOOP_acc_1_cse_10_sva[0]) & (~(and_dcpl_615
      | and_dcpl_623 | and_dcpl_627 | and_dcpl_630 | and_dcpl_632 | and_dcpl_635
      | and_dcpl_637))) | and_dcpl_608 | and_dcpl_618 | and_dcpl_639 | and_dcpl_641;
  assign nl_acc_14_nl = ({VEC_LOOP_VEC_LOOP_or_13_nl , VEC_LOOP_VEC_LOOP_mux_12_nl
      , VEC_LOOP_or_83_nl}) + conv_u2u_11_12({VEC_LOOP_VEC_LOOP_mux_13_nl , VEC_LOOP_VEC_LOOP_or_14_nl
      , VEC_LOOP_VEC_LOOP_or_15_nl , VEC_LOOP_VEC_LOOP_or_16_nl , VEC_LOOP_VEC_LOOP_or_17_nl
      , 1'b1});
  assign acc_14_nl = nl_acc_14_nl[11:0];
  assign z_out_22 = readslicef_12_11_1(acc_14_nl);
  assign and_1085_nl = and_dcpl_16 & and_dcpl_20 & (~ (fsm_output[3])) & (fsm_output[1])
      & (fsm_output[4]) & (fsm_output[0]);
  assign mult_if_mux_40_cse = MUX_v_32_2_2(mult_res_1_sva, mult_res_2_sva, and_1085_nl);
  assign nl_acc_15_nl = ({1'b1 , mult_if_mux_40_cse , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_15_nl = nl_acc_15_nl[33:0];
  assign z_out_23_32 = readslicef_34_1_33(acc_15_nl);
  assign and_1086_nl = and_dcpl_16 & (fsm_output[2]) & (fsm_output[7]) & (fsm_output[3])
      & (fsm_output[1]) & (fsm_output[4]) & (fsm_output[0]);
  assign mult_if_mux_41_nl = MUX_v_32_2_2(mult_res_3_sva, mult_res_sva, and_1086_nl);
  assign nl_acc_16_nl = ({1'b1 , mult_if_mux_41_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_16_nl = nl_acc_16_nl[33:0];
  assign z_out_24_32 = readslicef_34_1_33(acc_16_nl);
  assign and_1087_nl = (fsm_output==8'b10010101);
  assign mult_if_mux_42_nl = MUX_v_32_2_2(mult_res_4_sva, mult_res_15_sva, and_1087_nl);
  assign nl_acc_17_nl = ({1'b1 , mult_if_mux_42_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_17_nl = nl_acc_17_nl[33:0];
  assign z_out_25_32 = readslicef_34_1_33(acc_17_nl);
  assign mult_if_mux_43_nl = MUX_v_32_2_2(mult_res_5_sva, mult_res_14_sva, and_dcpl_692);
  assign nl_acc_18_nl = ({1'b1 , mult_if_mux_43_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_18_nl = nl_acc_18_nl[33:0];
  assign z_out_26_32 = readslicef_34_1_33(acc_18_nl);
  assign and_1088_nl = (~ (fsm_output[6])) & (~ (fsm_output[5])) & (~ (fsm_output[2]))
      & (fsm_output[7]) & and_dcpl_194 & (~ (fsm_output[4])) & (fsm_output[0]);
  assign mult_if_mux_44_nl = MUX_v_32_2_2(mult_res_6_sva, mult_res_13_sva, and_1088_nl);
  assign nl_acc_19_nl = ({1'b1 , mult_if_mux_44_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_19_nl = nl_acc_19_nl[33:0];
  assign z_out_27_32 = readslicef_34_1_33(acc_19_nl);
  assign mult_if_mux_45_nl = MUX_v_32_2_2(mult_res_7_sva, mult_res_12_sva, and_dcpl_719);
  assign nl_acc_20_nl = ({1'b1 , mult_if_mux_45_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_20_nl = nl_acc_20_nl[33:0];
  assign z_out_28_32 = readslicef_34_1_33(acc_20_nl);
  assign and_1089_nl = (fsm_output==8'b01101101);
  assign mult_if_mux_46_nl = MUX_v_32_2_2(mult_res_8_sva, mult_res_11_sva, and_1089_nl);
  assign nl_acc_21_nl = ({1'b1 , mult_if_mux_46_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_21_nl = nl_acc_21_nl[33:0];
  assign z_out_29_32 = readslicef_34_1_33(acc_21_nl);
  assign and_1090_nl = (fsm_output[6:5]==2'b11) & and_dcpl_20 & (~ (fsm_output[3]))
      & (fsm_output[1]) & (~ (fsm_output[4])) & (fsm_output[0]);
  assign mult_if_mux_47_nl = MUX_v_32_2_2(mult_res_9_sva, mult_res_10_sva, and_1090_nl);
  assign nl_acc_22_nl = ({1'b1 , mult_if_mux_47_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_22_nl = nl_acc_22_nl[33:0];
  assign z_out_30_32 = readslicef_34_1_33(acc_22_nl);
  assign VEC_LOOP_VEC_LOOP_or_18_nl = (VEC_LOOP_acc_1_cse_10_sva[9]) | and_dcpl_768
      | and_dcpl_773;
  assign VEC_LOOP_VEC_LOOP_mux_14_nl = MUX_v_8_2_2((VEC_LOOP_acc_1_cse_10_sva[8:1]),
      (~ (STAGE_LOOP_lshift_psp_sva[10:3])), VEC_LOOP_or_74_itm);
  assign VEC_LOOP_or_84_nl = (~(and_dcpl_751 | and_dcpl_757 | and_dcpl_761 | and_dcpl_765))
      | and_dcpl_768 | and_dcpl_773;
  assign VEC_LOOP_and_23_nl = (COMP_LOOP_k_10_4_sva_5_0[5]) & VEC_LOOP_nor_13_itm;
  assign VEC_LOOP_VEC_LOOP_mux_15_nl = MUX_v_5_2_2((COMP_LOOP_k_10_4_sva_5_0[4:0]),
      (COMP_LOOP_k_10_4_sva_5_0[5:1]), VEC_LOOP_or_74_itm);
  assign VEC_LOOP_VEC_LOOP_or_19_nl = ((COMP_LOOP_k_10_4_sva_5_0[0]) & (~(and_dcpl_751
      | and_dcpl_757))) | and_dcpl_761 | and_dcpl_765;
  assign VEC_LOOP_VEC_LOOP_or_20_nl = (~(and_dcpl_751 | and_dcpl_761 | and_dcpl_773))
      | and_dcpl_757 | and_dcpl_765 | and_dcpl_768;
  assign VEC_LOOP_VEC_LOOP_or_21_nl = VEC_LOOP_nor_13_itm | and_dcpl_751 | and_dcpl_757
      | and_dcpl_761 | and_dcpl_765;
  assign nl_acc_23_nl = ({VEC_LOOP_VEC_LOOP_or_18_nl , VEC_LOOP_VEC_LOOP_mux_14_nl
      , VEC_LOOP_or_84_nl}) + ({VEC_LOOP_and_23_nl , VEC_LOOP_VEC_LOOP_mux_15_nl
      , VEC_LOOP_VEC_LOOP_or_19_nl , VEC_LOOP_VEC_LOOP_or_20_nl , VEC_LOOP_VEC_LOOP_or_21_nl
      , 1'b1});
  assign acc_23_nl = nl_acc_23_nl[9:0];
  assign z_out_31 = readslicef_10_9_1(acc_23_nl);
  assign nl_acc_24_nl = ({mult_if_mux_40_cse , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_24_nl = nl_acc_24_nl[32:0];
  assign z_out_32 = readslicef_33_32_1(acc_24_nl);
  assign and_1092_nl = (fsm_output==8'b00100111);
  assign mult_if_mux_49_nl = MUX_v_32_2_2(mult_res_3_sva, mult_res_4_sva, and_1092_nl);
  assign nl_acc_26_nl = ({mult_if_mux_49_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_26_nl = nl_acc_26_nl[32:0];
  assign z_out_34 = readslicef_33_32_1(acc_26_nl);
  assign and_1093_nl = (fsm_output[6:5]==2'b01) & and_dcpl_20 & (fsm_output[3]) &
      (fsm_output[1]) & (fsm_output[4]) & (fsm_output[0]);
  assign mult_if_mux_50_nl = MUX_v_32_2_2(mult_res_5_sva, mult_res_6_sva, and_1093_nl);
  assign nl_acc_28_nl = ({mult_if_mux_50_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_28_nl = nl_acc_28_nl[32:0];
  assign z_out_36 = readslicef_33_32_1(acc_28_nl);
  assign and_1094_nl = (fsm_output==8'b10011111);
  assign mult_if_mux_51_nl = MUX_v_32_2_2(mult_res_7_sva, mult_res_sva, and_1094_nl);
  assign nl_acc_29_nl = ({mult_if_mux_51_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_29_nl = nl_acc_29_nl[32:0];
  assign z_out_37 = readslicef_33_32_1(acc_29_nl);
  assign and_1095_nl = (~ (fsm_output[5])) & (~ (fsm_output[6])) & (fsm_output[2])
      & (fsm_output[7]) & and_dcpl_194 & (fsm_output[4]) & (fsm_output[0]);
  assign mult_if_mux_52_nl = MUX_v_32_2_2(mult_res_8_sva, mult_res_15_sva, and_1095_nl);
  assign nl_acc_30_nl = ({mult_if_mux_52_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_30_nl = nl_acc_30_nl[32:0];
  assign z_out_38 = readslicef_33_32_1(acc_30_nl);
  assign mult_if_mux_53_nl = MUX_v_32_2_2(mult_res_9_sva, mult_res_14_sva, and_dcpl_692);
  assign nl_acc_31_nl = ({mult_if_mux_53_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_31_nl = nl_acc_31_nl[32:0];
  assign z_out_39 = readslicef_33_32_1(acc_31_nl);
  assign and_1096_nl = and_dcpl_16 & (~ (fsm_output[2])) & (fsm_output[7]) & (~ (fsm_output[3]))
      & (~ (fsm_output[1])) & (~ (fsm_output[4])) & (fsm_output[0]);
  assign mult_if_mux_54_nl = MUX_v_32_2_2(mult_res_10_sva, mult_res_13_sva, and_1096_nl);
  assign nl_acc_32_nl = ({mult_if_mux_54_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_32_nl = nl_acc_32_nl[32:0];
  assign z_out_40 = readslicef_33_32_1(acc_32_nl);
  assign mult_if_mux_55_nl = MUX_v_32_2_2(mult_res_11_sva, mult_res_12_sva, and_dcpl_719);
  assign nl_acc_33_nl = ({mult_if_mux_55_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_33_nl = nl_acc_33_nl[32:0];
  assign z_out_41 = readslicef_33_32_1(acc_33_nl);

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


  function automatic [5:0] MUX1HOT_v_6_5_2;
    input [5:0] input_4;
    input [5:0] input_3;
    input [5:0] input_2;
    input [5:0] input_1;
    input [5:0] input_0;
    input [4:0] sel;
    reg [5:0] result;
  begin
    result = input_0 & {6{sel[0]}};
    result = result | ( input_1 & {6{sel[1]}});
    result = result | ( input_2 & {6{sel[2]}});
    result = result | ( input_3 & {6{sel[3]}});
    result = result | ( input_4 & {6{sel[4]}});
    MUX1HOT_v_6_5_2 = result;
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


  function automatic [8:0] readslicef_10_9_1;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_10_9_1 = tmp[8:0];
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


  function automatic [0:0] readslicef_34_1_33;
    input [33:0] vector;
    reg [33:0] tmp;
  begin
    tmp = vector >> 33;
    readslicef_34_1_33 = tmp[0:0];
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


  function automatic [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function automatic [31:0] conv_u2u_11_32 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_32 = {{21{1'b0}}, vector};
  end
  endfunction


  function automatic [23:0] conv_u2u_23_24 ;
    input [22:0]  vector ;
  begin
    conv_u2u_23_24 = {1'b0, vector};
  end
  endfunction


  function automatic [33:0] conv_u2u_33_34 ;
    input [32:0]  vector ;
  begin
    conv_u2u_33_34 = {1'b0, vector};
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
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_8_10_32_1024_1024_32_1_gen
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
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_11_10_32_1024_1024_32_1_gen
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
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_12_10_32_1024_1024_32_1_gen
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



