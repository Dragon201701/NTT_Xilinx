
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

//------> ../td_ccore_solutions/mult_537fa58b3c62ba07ee98ed4139c27adf70e3_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:05:55 2021
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
  reg VEC_LOOP_asn_itm_1;
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
  assign and_dcpl = main_stage_0_2 & VEC_LOOP_asn_itm_1;
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_32_2_2(if_acc_nl, res_sva_1, slc_32_svs_1);
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      VEC_LOOP_asn_itm_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
    end
    else if ( ccs_ccore_en ) begin
      VEC_LOOP_asn_itm_1 <= ccs_ccore_start_rsci_idat;
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




//------> ../td_ccore_solutions/modulo_sub_35e8763e05b723902e0a11aa8bf94b5d6374_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:05:56 2021
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




//------> ../td_ccore_solutions/modulo_add_0a37945888dd1e74de5ead9499a92e0360eb_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon Sep 13 21:05:57 2021
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
//  Generated date: Mon Sep 13 21:18:01 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_17_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_17_10_32_1024_1024_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [9:0] adrb;
  input [9:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_16_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_16_10_32_1024_1024_32_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] qb;
  output [9:0] adrb;
  input [9:0] adrb_d;
  output [31:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_10_32_1024_1024_32_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_10_32_1024_1024_32_1_gen
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
  clk, rst, twiddle_h_rsci_qb_d, twiddle_h_rsci_qb_d_mxwt, twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsci_qb_d;
  output [31:0] twiddle_h_rsci_qb_d_mxwt;
  input twiddle_h_rsci_biwt;
  input twiddle_h_rsci_bdwt;


  // Interconnect Declarations
  reg twiddle_h_rsci_bcwt;
  reg [31:0] twiddle_h_rsci_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_qb_d_mxwt = MUX_v_32_2_2(twiddle_h_rsci_qb_d, twiddle_h_rsci_qb_d_bfwt,
      twiddle_h_rsci_bcwt);
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
      twiddle_h_rsci_qb_d_bfwt <= twiddle_h_rsci_qb_d;
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
  core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_biwt, twiddle_h_rsci_bdwt,
      twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct, twiddle_h_rsci_oswt_pff,
      core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_h_rsci_oswt;
  output twiddle_h_rsci_biwt;
  output twiddle_h_rsci_bdwt;
  output twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_h_rsci_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_h_rsci_bdwt = twiddle_h_rsci_oswt & core_wen;
  assign twiddle_h_rsci_biwt = (~ core_wten) & twiddle_h_rsci_oswt;
  assign twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_h_rsci_oswt_pff
      & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp (
  clk, rst, twiddle_rsci_qb_d, twiddle_rsci_qb_d_mxwt, twiddle_rsci_biwt, twiddle_rsci_bdwt
);
  input clk;
  input rst;
  input [31:0] twiddle_rsci_qb_d;
  output [31:0] twiddle_rsci_qb_d_mxwt;
  input twiddle_rsci_biwt;
  input twiddle_rsci_bdwt;


  // Interconnect Declarations
  reg twiddle_rsci_bcwt;
  reg [31:0] twiddle_rsci_qb_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_qb_d_mxwt = MUX_v_32_2_2(twiddle_rsci_qb_d, twiddle_rsci_qb_d_bfwt,
      twiddle_rsci_bcwt);
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
      twiddle_rsci_qb_d_bfwt <= twiddle_rsci_qb_d;
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
  core_wen, core_wten, twiddle_rsci_oswt, twiddle_rsci_biwt, twiddle_rsci_bdwt, twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct,
      twiddle_rsci_oswt_pff, core_wten_pff
);
  input core_wen;
  input core_wten;
  input twiddle_rsci_oswt;
  output twiddle_rsci_biwt;
  output twiddle_rsci_bdwt;
  output twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
  input twiddle_rsci_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_bdwt = twiddle_rsci_oswt & core_wen;
  assign twiddle_rsci_biwt = (~ core_wten) & twiddle_rsci_oswt;
  assign twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct = twiddle_rsci_oswt_pff
      & (~ core_wten_pff);
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
  clk, rst, twiddle_h_rsci_qb_d, twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, twiddle_h_rsci_oswt, twiddle_h_rsci_qb_d_mxwt, twiddle_h_rsci_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_h_rsci_qb_d;
  output twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_h_rsci_oswt;
  output [31:0] twiddle_h_rsci_qb_d_mxwt;
  input twiddle_h_rsci_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_h_rsci_biwt;
  wire twiddle_h_rsci_bdwt;
  wire twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_h_rsci_oswt(twiddle_h_rsci_oswt),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt),
      .twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_h_rsci_oswt_pff(twiddle_h_rsci_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_twiddle_h_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_qb_d(twiddle_h_rsci_qb_d),
      .twiddle_h_rsci_qb_d_mxwt(twiddle_h_rsci_qb_d_mxwt),
      .twiddle_h_rsci_biwt(twiddle_h_rsci_biwt),
      .twiddle_h_rsci_bdwt(twiddle_h_rsci_bdwt)
    );
  assign twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp_core_twiddle_rsci_1
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp_core_twiddle_rsci_1 (
  clk, rst, twiddle_rsci_qb_d, twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d, core_wen,
      core_wten, twiddle_rsci_oswt, twiddle_rsci_qb_d_mxwt, twiddle_rsci_oswt_pff,
      core_wten_pff
);
  input clk;
  input rst;
  input [31:0] twiddle_rsci_qb_d;
  output twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input twiddle_rsci_oswt;
  output [31:0] twiddle_rsci_qb_d_mxwt;
  input twiddle_rsci_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire twiddle_rsci_biwt;
  wire twiddle_rsci_bdwt;
  wire twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(twiddle_rsci_oswt),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt),
      .twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct(twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct),
      .twiddle_rsci_oswt_pff(twiddle_rsci_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp inPlaceNTT_DIF_precomp_core_twiddle_rsci_1_twiddle_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_rsci_qb_d(twiddle_rsci_qb_d),
      .twiddle_rsci_qb_d_mxwt(twiddle_rsci_qb_d_mxwt),
      .twiddle_rsci_biwt(twiddle_rsci_biwt),
      .twiddle_rsci_bdwt(twiddle_rsci_bdwt)
    );
  assign twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_core_sct;
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
      twiddle_rsci_adrb_d, twiddle_rsci_qb_d, twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d,
      twiddle_h_rsci_adrb_d, twiddle_h_rsci_qb_d, twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d
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
  output [9:0] twiddle_rsci_adrb_d;
  input [31:0] twiddle_rsci_qb_d;
  output twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d;
  output [9:0] twiddle_h_rsci_adrb_d;
  input [31:0] twiddle_h_rsci_qb_d;
  output twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations
  wire core_wten;
  wire run_rsci_ivld_mxwt;
  wire [63:0] vec_rsci_qa_d_mxwt;
  wire [31:0] p_rsci_idat;
  wire [31:0] twiddle_rsci_qb_d_mxwt;
  wire [31:0] twiddle_h_rsci_qb_d_mxwt;
  wire complete_rsci_wen_comp;
  wire [31:0] COMP_LOOP_1_mult_cmp_return_rsc_z;
  wire COMP_LOOP_1_mult_cmp_ccs_ccore_en;
  wire [31:0] COMP_LOOP_1_modulo_sub_cmp_return_rsc_z;
  wire COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en;
  wire [31:0] COMP_LOOP_1_modulo_add_cmp_return_rsc_z;
  wire [8:0] fsm_output;
  wire and_dcpl_3;
  wire or_dcpl_152;
  wire or_tmp_46;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_34;
  wire and_dcpl_35;
  wire and_dcpl_37;
  wire and_dcpl_39;
  wire xor_dcpl_1;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire and_dcpl_43;
  wire and_dcpl_44;
  wire and_dcpl_45;
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
  wire and_dcpl_103;
  wire and_dcpl_104;
  wire and_dcpl_105;
  wire and_dcpl_106;
  wire and_dcpl_107;
  wire and_dcpl_108;
  wire and_dcpl_109;
  wire and_dcpl_110;
  wire and_dcpl_111;
  wire and_dcpl_112;
  wire and_dcpl_117;
  wire and_dcpl_126;
  wire and_dcpl_128;
  wire and_dcpl_129;
  wire and_dcpl_132;
  wire and_dcpl_136;
  wire and_dcpl_137;
  wire and_dcpl_138;
  wire and_dcpl_139;
  wire and_dcpl_142;
  wire and_dcpl_143;
  wire and_dcpl_144;
  wire and_dcpl_149;
  wire and_dcpl_151;
  wire and_dcpl_157;
  wire or_tmp_56;
  wire and_dcpl_164;
  wire and_dcpl_165;
  wire mux_tmp_81;
  wire mux_tmp_84;
  wire and_dcpl_182;
  wire not_tmp_93;
  wire mux_tmp_108;
  wire and_dcpl_220;
  wire mux_tmp_121;
  reg [9:0] VEC_LOOP_acc_1_cse_10_sva;
  reg [10:0] STAGE_LOOP_lshift_psp_sva;
  reg [10:0] VEC_LOOP_j_10_0_1_sva_1;
  reg run_ac_sync_tmp_dobj_sva;
  reg reg_run_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_cse;
  reg reg_vec_rsci_oswt_1_cse;
  reg reg_twiddle_rsci_oswt_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_vec_rsc_triosy_obj_iswt0_cse;
  reg reg_ensig_cgo_cse;
  reg reg_ensig_cgo_1_cse;
  wire and_268_cse;
  wire or_265_cse;
  wire or_244_cse;
  wire or_215_cse;
  wire and_267_cse;
  wire or_30_cse;
  wire or_247_cse;
  wire nor_56_cse;
  wire and_258_cse;
  wire mux_52_cse;
  wire and_8_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire and_135_rmff;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_31_rmff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [4:0] COMP_LOOP_twiddle_f_mux1h_25_rmff;
  wire COMP_LOOP_twiddle_f_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_9_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_4_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_12_rmff;
  wire COMP_LOOP_twiddle_f_mux_rmff;
  wire twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_138_rmff;
  wire twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_167_rmff;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  wire [9:0] VEC_LOOP_acc_10_cse_2_sva_mx0w1;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1;
  wire [4:0] VEC_LOOP_acc_psp_sva_mx0w0;
  wire [5:0] nl_VEC_LOOP_acc_psp_sva_mx0w0;
  reg [9:0] VEC_LOOP_acc_10_cse_1_sva;
  wire [9:0] VEC_LOOP_acc_10_cse_3_sva_mx0w2;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2;
  reg [8:0] COMP_LOOP_11_twiddle_f_mul_psp_sva;
  wire [9:0] VEC_LOOP_acc_10_cse_4_sva_mx0w3;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3;
  wire [9:0] VEC_LOOP_acc_10_cse_5_sva_mx0w4;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4;
  wire [9:0] VEC_LOOP_acc_10_cse_6_sva_mx0w5;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5;
  wire [9:0] VEC_LOOP_acc_10_cse_7_sva_mx0w6;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6;
  wire [9:0] VEC_LOOP_acc_10_cse_8_sva_mx0w7;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7;
  wire [9:0] VEC_LOOP_acc_10_cse_10_sva_mx0w9;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9;
  wire [9:0] VEC_LOOP_acc_10_cse_11_sva_mx0w10;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10;
  wire [9:0] VEC_LOOP_acc_10_cse_12_sva_mx0w11;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11;
  wire [9:0] VEC_LOOP_acc_10_cse_13_sva_mx0w12;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12;
  wire [9:0] VEC_LOOP_acc_10_cse_14_sva_mx0w13;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13;
  wire [9:0] VEC_LOOP_acc_10_cse_15_sva_mx0w14;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14;
  wire [9:0] VEC_LOOP_acc_10_cse_16_sva_mx0w15;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15;
  reg [5:0] COMP_LOOP_17_twiddle_f_lshift_itm;
  wire [9:0] VEC_LOOP_acc_10_cse_18_sva_mx0w17;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17;
  wire [9:0] VEC_LOOP_acc_10_cse_19_sva_mx0w18;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18;
  wire [9:0] VEC_LOOP_acc_10_cse_20_sva_mx0w19;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_20_sva_mx0w19;
  wire [9:0] VEC_LOOP_acc_10_cse_21_sva_mx0w20;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20;
  wire [9:0] VEC_LOOP_acc_10_cse_22_sva_mx0w21;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_22_sva_mx0w21;
  wire [9:0] VEC_LOOP_acc_10_cse_23_sva_mx0w22;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22;
  wire [9:0] VEC_LOOP_acc_10_cse_24_sva_mx0w23;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_24_sva_mx0w23;
  wire [9:0] VEC_LOOP_acc_10_cse_26_sva_mx0w25;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_26_sva_mx0w25;
  wire [9:0] VEC_LOOP_acc_10_cse_27_sva_mx0w26;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26;
  wire [9:0] VEC_LOOP_acc_10_cse_28_sva_mx0w27;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_28_sva_mx0w27;
  wire [9:0] VEC_LOOP_acc_10_cse_29_sva_mx0w28;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28;
  wire [9:0] VEC_LOOP_acc_10_cse_30_sva_mx0w29;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29;
  wire [9:0] VEC_LOOP_acc_10_cse_31_sva_mx0w30;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30;
  wire [9:0] VEC_LOOP_acc_10_cse_sva_mx0w31;
  wire [10:0] nl_VEC_LOOP_acc_10_cse_sva_mx0w31;
  reg [31:0] p_sva;
  wire mux_62_itm;
  wire mux_74_itm;
  wire [5:0] COMP_LOOP_17_twiddle_f_lshift_itm_1;
  wire [4:0] COMP_LOOP_1_twiddle_f_lshift_itm;
  wire [7:0] COMP_LOOP_5_twiddle_f_lshift_itm;
  wire [10:0] z_out;
  wire and_dcpl_242;
  wire and_dcpl_243;
  wire and_dcpl_244;
  wire and_dcpl_246;
  wire and_dcpl_251;
  wire and_dcpl_252;
  wire and_dcpl_253;
  wire and_dcpl_254;
  wire and_dcpl_255;
  wire and_dcpl_256;
  wire and_dcpl_257;
  wire and_dcpl_258;
  wire and_dcpl_259;
  wire and_dcpl_260;
  wire and_dcpl_261;
  wire and_dcpl_262;
  wire and_dcpl_263;
  wire and_dcpl_264;
  wire and_dcpl_265;
  wire and_dcpl_266;
  wire and_dcpl_267;
  wire and_dcpl_268;
  wire and_dcpl_269;
  wire and_dcpl_270;
  wire and_dcpl_271;
  wire and_dcpl_272;
  wire and_dcpl_274;
  wire and_dcpl_275;
  wire and_dcpl_276;
  wire and_dcpl_278;
  wire and_dcpl_279;
  wire and_dcpl_281;
  wire and_dcpl_282;
  wire and_dcpl_283;
  wire and_dcpl_284;
  wire and_dcpl_285;
  wire and_dcpl_286;
  wire and_dcpl_287;
  wire and_dcpl_288;
  wire [9:0] z_out_1;
  wire [19:0] nl_z_out_1;
  wire and_dcpl_291;
  wire and_dcpl_295;
  wire and_dcpl_296;
  wire and_dcpl_299;
  wire and_dcpl_302;
  wire and_dcpl_305;
  wire and_dcpl_306;
  wire and_dcpl_307;
  wire and_dcpl_308;
  wire and_dcpl_311;
  wire and_dcpl_314;
  wire and_dcpl_329;
  wire [9:0] z_out_3;
  wire [19:0] nl_z_out_3;
  wire and_dcpl_338;
  wire and_dcpl_339;
  wire and_dcpl_340;
  wire and_dcpl_342;
  wire and_dcpl_343;
  wire and_dcpl_345;
  wire and_dcpl_346;
  wire and_dcpl_349;
  wire and_dcpl_351;
  wire and_dcpl_352;
  wire and_dcpl_355;
  wire and_dcpl_357;
  wire and_dcpl_358;
  wire and_dcpl_360;
  wire and_dcpl_361;
  wire and_dcpl_363;
  wire and_dcpl_364;
  wire and_dcpl_365;
  wire and_dcpl_366;
  wire and_dcpl_367;
  wire and_dcpl_368;
  wire and_dcpl_371;
  wire [10:0] z_out_4;
  wire and_dcpl_377;
  wire and_dcpl_378;
  wire and_dcpl_384;
  wire and_dcpl_386;
  wire and_dcpl_400;
  wire and_dcpl_401;
  wire and_dcpl_402;
  wire and_dcpl_406;
  wire and_dcpl_408;
  wire and_dcpl_409;
  wire and_dcpl_411;
  wire and_dcpl_412;
  wire and_dcpl_415;
  wire and_dcpl_418;
  wire and_dcpl_419;
  wire and_dcpl_420;
  wire and_dcpl_422;
  wire and_dcpl_424;
  wire and_dcpl_425;
  wire and_dcpl_426;
  wire and_dcpl_428;
  wire and_dcpl_429;
  wire and_dcpl_430;
  wire and_dcpl_434;
  wire and_dcpl_436;
  wire and_dcpl_437;
  wire and_dcpl_438;
  wire and_dcpl_440;
  wire and_dcpl_441;
  wire and_dcpl_442;
  wire and_dcpl_443;
  wire and_dcpl_446;
  wire and_dcpl_447;
  wire and_dcpl_449;
  wire and_dcpl_450;
  wire and_dcpl_452;
  wire [8:0] z_out_6;
  wire and_dcpl_459;
  wire and_dcpl_462;
  wire and_dcpl_465;
  wire [6:0] z_out_7;
  wire [7:0] nl_z_out_7;
  wire and_dcpl_473;
  wire [9:0] z_out_8;
  wire [10:0] nl_z_out_8;
  wire [9:0] z_out_9;
  wire [10:0] nl_z_out_9;
  wire and_dcpl_561;
  wire [9:0] z_out_10;
  wire [10:0] nl_z_out_10;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva;
  reg [9:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva;
  reg [7:0] COMP_LOOP_5_twiddle_f_lshift_ncse_sva;
  reg [6:0] COMP_LOOP_9_twiddle_f_lshift_ncse_sva;
  reg [9:0] COMP_LOOP_twiddle_f_mul_cse_10_sva;
  reg [4:0] COMP_LOOP_k_10_5_sva_4_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire [9:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
  wire [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva_1;
  wire [4:0] nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_1;
  wire [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
  wire COMP_LOOP_twiddle_f_or_7_rgt;
  wire COMP_LOOP_twiddle_f_or_6_rgt;
  wire COMP_LOOP_twiddle_f_or_ssc;
  wire COMP_LOOP_twiddle_f_or_8_cse;
  wire VEC_LOOP_or_5_cse;
  wire VEC_LOOP_or_13_cse;
  wire and_243_cse;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire and_628_cse;
  wire or_tmp_89;
  wire [7:0] COMP_LOOP_twiddle_f_mux1h_40_rgt;
  reg COMP_LOOP_13_twiddle_f_mul_psp_sva_7;
  reg [1:0] reg_COMP_LOOP_13_twiddle_f_mul_psp_1_reg;
  reg [4:0] reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg;
  wire nor_129_cse;
  wire and_646_cse;
  wire nor_123_cse;
  wire and_650_cse;
  wire or_281_cse;
  wire or_299_cse;
  wire or_282_cse;
  wire and_cse;
  wire COMP_LOOP_twiddle_f_nor_1_itm;
  wire COMP_LOOP_twiddle_f_or_21_itm;
  wire COMP_LOOP_twiddle_f_nor_7_itm;
  wire COMP_LOOP_twiddle_f_or_15_itm;
  wire COMP_LOOP_twiddle_f_nor_8_itm;
  wire COMP_LOOP_twiddle_f_or_16_itm;
  wire COMP_LOOP_twiddle_f_or_17_itm;
  wire VEC_LOOP_or_38_itm;
  wire VEC_LOOP_or_29_itm;
  wire VEC_LOOP_or_30_itm;
  wire VEC_LOOP_or_40_itm;
  wire VEC_LOOP_or_46_itm;
  wire VEC_LOOP_or_48_itm;
  wire VEC_LOOP_or_49_itm;
  wire and_524_itm;
  wire and_527_itm;
  wire and_530_itm;
  wire and_533_itm;
  wire and_534_itm;
  wire and_535_itm;
  wire and_536_itm;
  wire and_539_itm;
  wire and_541_itm;
  wire and_543_itm;
  wire and_545_itm;
  wire and_546_itm;
  wire and_547_itm;
  wire and_548_itm;
  wire and_521_itm;
  wire and_549_itm;
  wire VEC_LOOP_or_63_itm;
  wire and_620_cse;
  wire VEC_LOOP_nor_12_seb;
  wire [8:0] z_out_2_8_0;
  wire [17:0] nl_z_out_2_8_0;
  wire z_out_5_10;
  wire [31:0] VEC_LOOP_mux_19_cse;

  wire[0:0] mux_61_nl;
  wire[0:0] or_207_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] or_204_nl;
  wire[0:0] mux_71_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] or_219_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] or_218_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_4_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_9_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_18_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] or_226_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] or_225_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] or_232_nl;
  wire[0:0] and_253_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] mux_131_nl;
  wire[0:0] mux_130_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] mux_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] nor_48_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] mux_90_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] and_241_nl;
  wire[0:0] and_183_nl;
  wire[0:0] and_178_nl;
  wire[0:0] and_189_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] mux_95_nl;
  wire[0:0] mux_94_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] nor_47_nl;
  wire[0:0] and_239_nl;
  wire[0:0] or_246_nl;
  wire[0:0] and_203_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] and_236_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] and_237_nl;
  wire[4:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_nl;
  wire[6:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_3_nl;
  wire[0:0] and_210_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_4_nl;
  wire[0:0] nor_64_nl;
  wire[0:0] mux_114_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] mux_112_nl;
  wire[0:0] or_258_nl;
  wire[0:0] mux_111_nl;
  wire[0:0] mux_110_nl;
  wire[0:0] mux_109_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] mux_139_nl;
  wire[0:0] mux_138_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] or_289_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] mux_134_nl;
  wire[0:0] or_283_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] nor_119_nl;
  wire[0:0] and_647_nl;
  wire[0:0] mux_143_nl;
  wire[0:0] mux_141_nl;
  wire[0:0] nor_120_nl;
  wire[0:0] nor_122_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] nor_125_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_1_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_2_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] mux_116_nl;
  wire[0:0] and_234_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_nl;
  wire[0:0] VEC_LOOP_or_nl;
  wire[0:0] not_nl;
  wire[0:0] VEC_LOOP_or_19_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] and_227_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] and_252_nl;
  wire[0:0] and_245_nl;
  wire[5:0] VEC_LOOP_mux1h_10_nl;
  wire[0:0] VEC_LOOP_mux1h_8_nl;
  wire[0:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] and_128_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] and_123_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_119_nl;
  wire[4:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_42_nl;
  wire[0:0] and_50_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] and_117_nl;
  wire[0:0] mux_63_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] and_120_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] nor_49_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] and_124_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] VEC_LOOP_mux1h_7_nl;
  wire[0:0] and_129_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] VEC_LOOP_mux1h_9_nl;
  wire[0:0] and_134_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_9_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_15_nl;
  wire[8:0] COMP_LOOP_twiddle_f_mux1h_103_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_28_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_19_nl;
  wire[3:0] COMP_LOOP_twiddle_f_mux1h_104_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_29_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_30_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_6_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_7_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_10_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_11_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_16_nl;
  wire[6:0] COMP_LOOP_twiddle_f_mux1h_105_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_12_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_13_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_17_nl;
  wire[2:0] COMP_LOOP_twiddle_f_mux1h_106_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_14_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_18_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_8_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_9_nl;
  wire[9:0] COMP_LOOP_twiddle_f_mux_19_nl;
  wire[4:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_15_nl;
  wire[0:0] not_517_nl;
  wire[4:0] COMP_LOOP_twiddle_f_mux_20_nl;
  wire[11:0] acc_nl;
  wire[12:0] nl_acc_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_9_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_8_nl;
  wire[0:0] VEC_LOOP_or_65_nl;
  wire[4:0] VEC_LOOP_VEC_LOOP_mux_9_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_10_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_11_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_12_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_13_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_14_nl;
  wire[11:0] acc_1_nl;
  wire[12:0] nl_acc_1_nl;
  wire[3:0] COMP_LOOP_mux1h_4_nl;
  wire[0:0] and_652_nl;
  wire[0:0] and_653_nl;
  wire[0:0] and_654_nl;
  wire[0:0] and_655_nl;
  wire[0:0] and_656_nl;
  wire[0:0] and_657_nl;
  wire[0:0] and_658_nl;
  wire[9:0] acc_2_nl;
  wire[10:0] nl_acc_2_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_15_nl;
  wire[0:0] VEC_LOOP_or_66_nl;
  wire[0:0] VEC_LOOP_mux1h_36_nl;
  wire[6:0] VEC_LOOP_mux1h_37_nl;
  wire[0:0] VEC_LOOP_or_67_nl;
  wire[0:0] VEC_LOOP_or_68_nl;
  wire[0:0] VEC_LOOP_or_69_nl;
  wire[0:0] VEC_LOOP_and_27_nl;
  wire[0:0] VEC_LOOP_and_28_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_10_nl;
  wire[0:0] VEC_LOOP_and_29_nl;
  wire[0:0] VEC_LOOP_mux1h_38_nl;
  wire[1:0] VEC_LOOP_and_30_nl;
  wire[1:0] VEC_LOOP_mux1h_39_nl;
  wire[0:0] VEC_LOOP_and_31_nl;
  wire[0:0] VEC_LOOP_mux1h_40_nl;
  wire[0:0] VEC_LOOP_or_71_nl;
  wire[0:0] VEC_LOOP_mux1h_41_nl;
  wire[0:0] VEC_LOOP_or_72_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_11_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_16_nl;
  wire[4:0] VEC_LOOP_VEC_LOOP_mux_12_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_17_nl;
  wire[6:0] VEC_LOOP_VEC_LOOP_mux_13_nl;
  wire[3:0] VEC_LOOP_or_73_nl;
  wire[3:0] VEC_LOOP_nor_32_nl;
  wire[3:0] VEC_LOOP_mux1h_42_nl;
  wire[4:0] VEC_LOOP_or_74_nl;
  wire[4:0] VEC_LOOP_mux1h_43_nl;
  wire[0:0] and_659_nl;
  wire[0:0] and_660_nl;
  wire[0:0] and_661_nl;
  wire[0:0] and_662_nl;
  wire[0:0] and_663_nl;
  wire[0:0] and_664_nl;
  wire[0:0] and_665_nl;
  wire[0:0] and_666_nl;
  wire[0:0] and_667_nl;
  wire[0:0] and_668_nl;
  wire[0:0] and_669_nl;
  wire[0:0] and_670_nl;
  wire[5:0] VEC_LOOP_mux1h_44_nl;
  wire[4:0] VEC_LOOP_acc_62_nl;
  wire[5:0] nl_VEC_LOOP_acc_62_nl;
  wire[0:0] and_671_nl;
  wire[0:0] and_672_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_14_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat = COMP_LOOP_twiddle_f_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1 = COMP_LOOP_twiddle_help_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_p_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_p_rsc_dat = p_sva;
  wire [0:0] nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat = and_dcpl_26 & and_dcpl_50;
  wire[32:0] acc_7_nl;
  wire[33:0] nl_acc_7_nl;
  wire[31:0] VEC_LOOP_mux_20_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_20_nl = MUX_v_32_2_2((~ (vec_rsci_qa_d_mxwt[63:32])), (~ (vec_rsci_qa_d_mxwt[31:0])),
      and_628_cse);
  assign nl_acc_7_nl = ({VEC_LOOP_mux_19_cse , 1'b1}) + ({VEC_LOOP_mux_20_nl , 1'b1});
  assign acc_7_nl = nl_acc_7_nl[32:0];
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = readslicef_33_32_1(acc_7_nl);
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire[31:0] VEC_LOOP_mux_22_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_22_nl = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
      and_628_cse);
  assign nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat = VEC_LOOP_mux_19_cse + VEC_LOOP_mux_22_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat = p_sva;
  wire[0:0] and_283_nl;
  wire [3:0] nl_COMP_LOOP_9_twiddle_f_lshift_rg_s;
  assign and_283_nl = (fsm_output==9'b000000010);
  assign nl_COMP_LOOP_9_twiddle_f_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva,
      COMP_LOOP_1_twiddle_f_acc_cse_sva_1, and_283_nl);
  wire[31:0] VEC_LOOP_mux_3_nl;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_3_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      COMP_LOOP_1_mult_cmp_return_rsc_z, and_dcpl_41);
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_3_nl};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , and_135_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_31_rmff , and_31_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , and_135_rmff};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_62_itm;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_wait_dp_inst_ensig_cgo_iro;
  assign nl_inPlaceNTT_DIF_precomp_core_wait_dp_inst_ensig_cgo_iro = ~ mux_74_itm;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ run_ac_sync_tmp_dobj_sva;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ z_out_5_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ z_out_5_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_6[8]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ z_out_5_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (z_out_6[7]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_10_tr0 = ~ z_out_5_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_9_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_11_tr0 = ~ z_out_5_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_10_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_11_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_13_tr0 = ~ (z_out_6[8]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_12_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_14_tr0 = ~ z_out_5_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_13_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_15_tr0 = ~ z_out_5_10;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_14_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_16_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_15_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_17_tr0 = ~ (z_out_6[6]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_16_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_18_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_17_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_19_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_18_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_20_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_19_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_21_tr0 = ~ (z_out_6[8]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_20_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_22_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_21_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_23_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_22_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_24_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_23_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_25_tr0 = ~ (z_out_6[7]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_24_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_26_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_25_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_27_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_26_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_28_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_27_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_29_tr0 = ~ (z_out_6[8]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_28_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_30_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_29_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_31_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_30_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_32_tr0 = ~ (z_out_4[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_31_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_33_tr0 = ~ (z_out_6[5]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_32_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire[10:0] COMP_LOOP_1_acc_nl;
  wire[11:0] nl_COMP_LOOP_1_acc_nl;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0;
  assign nl_COMP_LOOP_1_acc_nl = ({(z_out_6[5:0]) , 5'b00000}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:1]))})
      + 11'b00000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[10:0];
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_34_tr0 = ~ (readslicef_11_1_10(COMP_LOOP_1_acc_nl));
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ (z_out_6[4]);
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
      .ccs_ccore_start_rsc_dat(and_dcpl_165),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_dcpl_165),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd6)) COMP_LOOP_17_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva_1),
      .z(COMP_LOOP_17_twiddle_f_lshift_itm_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd5)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva_1),
      .z(COMP_LOOP_1_twiddle_f_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd8)) COMP_LOOP_5_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
      .z(COMP_LOOP_5_twiddle_f_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_2_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva_1),
      .z(COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd9)) COMP_LOOP_3_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
      .z(COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) COMP_LOOP_9_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_9_twiddle_f_lshift_rg_s[3:0]),
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
      .vec_rsci_oswt_1_pff(and_31_rmff)
    );
  inPlaceNTT_DIF_precomp_core_wait_dp inPlaceNTT_DIF_precomp_core_wait_dp_inst (
      .ensig_cgo_iro(nl_inPlaceNTT_DIF_precomp_core_wait_dp_inst_ensig_cgo_iro[0:0]),
      .ensig_cgo_iro_1(and_167_rmff),
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
      .twiddle_rsci_qb_d(twiddle_rsci_qb_d),
      .twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_rsci_qb_d_mxwt(twiddle_rsci_qb_d_mxwt),
      .twiddle_rsci_oswt_pff(and_138_rmff),
      .core_wten_pff(core_wten_iff)
    );
  inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1 inPlaceNTT_DIF_precomp_core_twiddle_h_rsci_1_inst
      (
      .clk(clk),
      .rst(rst),
      .twiddle_h_rsci_qb_d(twiddle_h_rsci_qb_d),
      .twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .twiddle_h_rsci_oswt(reg_twiddle_rsci_oswt_cse),
      .twiddle_h_rsci_qb_d_mxwt(twiddle_h_rsci_qb_d_mxwt),
      .twiddle_h_rsci_oswt_pff(and_138_rmff),
      .core_wten_pff(core_wten_iff)
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
  assign or_207_nl = (fsm_output[1:0]!=2'b10) | mux_52_cse;
  assign mux_61_nl = MUX_s_1_2_2(or_207_nl, or_tmp_46, fsm_output[2]);
  assign or_204_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[8]);
  assign mux_59_nl = MUX_s_1_2_2(or_204_nl, or_tmp_46, fsm_output[2]);
  assign mux_62_itm = MUX_s_1_2_2(mux_61_nl, mux_59_nl, fsm_output[3]);
  assign and_31_rmff = and_dcpl_26 & and_dcpl_25;
  assign or_215_cse = (fsm_output[5:4]!=2'b00);
  assign or_219_nl = (fsm_output[0]) | mux_52_cse;
  assign mux_70_nl = MUX_s_1_2_2(or_219_nl, or_tmp_46, fsm_output[2]);
  assign or_218_nl = (fsm_output[0]) | (fsm_output[8]);
  assign mux_69_nl = MUX_s_1_2_2(or_218_nl, or_tmp_46, fsm_output[2]);
  assign mux_71_nl = MUX_s_1_2_2(mux_70_nl, mux_69_nl, fsm_output[3]);
  assign and_135_rmff = (~ mux_71_nl) & (fsm_output[1]);
  assign and_138_rmff = (and_dcpl_129 | (VEC_LOOP_j_10_0_1_sva_1[10])) & and_dcpl_26
      & and_dcpl_132;
  assign COMP_LOOP_twiddle_f_mux1h_4_nl = MUX1HOT_s_1_3_2((COMP_LOOP_twiddle_f_mul_cse_10_sva[2]),
      (COMP_LOOP_11_twiddle_f_mul_psp_sva[1]), (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[0]),
      {and_dcpl_136 , and_dcpl_138 , and_dcpl_139});
  assign COMP_LOOP_twiddle_f_mux1h_4_rmff = COMP_LOOP_twiddle_f_mux1h_4_nl & (~(and_dcpl_3
      & and_dcpl_59 & and_dcpl_137));
  assign COMP_LOOP_twiddle_f_mux1h_9_nl = MUX1HOT_s_1_4_2((COMP_LOOP_twiddle_f_mul_cse_10_sva[3]),
      (COMP_LOOP_11_twiddle_f_mul_psp_sva[2]), (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[1]),
      (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[0]), {and_dcpl_136 , and_dcpl_138
      , and_dcpl_139 , and_dcpl_144});
  assign COMP_LOOP_twiddle_f_mux1h_9_rmff = COMP_LOOP_twiddle_f_mux1h_9_nl & (~(and_dcpl_32
      & and_dcpl_71 & and_dcpl_143));
  assign COMP_LOOP_twiddle_f_mux_nl = MUX_s_1_2_2((COMP_LOOP_twiddle_f_mul_cse_10_sva[1]),
      (COMP_LOOP_11_twiddle_f_mul_psp_sva[0]), and_dcpl_138);
  assign COMP_LOOP_twiddle_f_mux1h_12_rmff = COMP_LOOP_twiddle_f_mux_nl & (~(and_dcpl_117
      & (fsm_output[0]) & and_dcpl_137));
  assign COMP_LOOP_twiddle_f_mux1h_18_nl = MUX1HOT_s_1_5_2((COMP_LOOP_twiddle_f_mul_cse_10_sva[4]),
      (COMP_LOOP_11_twiddle_f_mul_psp_sva[3]), (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[2]),
      (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[1]), (COMP_LOOP_17_twiddle_f_lshift_itm[0]),
      {and_dcpl_136 , and_dcpl_138 , and_dcpl_139 , and_dcpl_144 , and_dcpl_149});
  assign COMP_LOOP_twiddle_f_and_rmff = COMP_LOOP_twiddle_f_mux1h_18_nl & (~(and_dcpl_129
      | or_tmp_46 | (fsm_output[2:1]!=2'b01)));
  assign COMP_LOOP_twiddle_f_mux_rmff = (COMP_LOOP_twiddle_f_mul_cse_10_sva[0]) &
      (~(and_dcpl_45 & and_dcpl_142));
  assign COMP_LOOP_twiddle_f_mux1h_25_rmff = MUX1HOT_v_5_6_2(reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg,
      (COMP_LOOP_twiddle_f_mul_cse_10_sva[9:5]), (COMP_LOOP_11_twiddle_f_mul_psp_sva[8:4]),
      ({COMP_LOOP_13_twiddle_f_mul_psp_sva_7 , reg_COMP_LOOP_13_twiddle_f_mul_psp_1_reg
      , (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[4:3])}), ({reg_COMP_LOOP_13_twiddle_f_mul_psp_1_reg
      , (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[4:2])}), (COMP_LOOP_17_twiddle_f_lshift_itm[5:1]),
      {and_dcpl_151 , and_dcpl_136 , and_dcpl_138 , and_dcpl_139 , and_dcpl_144 ,
      and_dcpl_149});
  assign or_226_nl = (fsm_output[1]) | mux_52_cse;
  assign mux_73_nl = MUX_s_1_2_2(or_226_nl, or_tmp_56, fsm_output[2]);
  assign or_225_nl = (fsm_output[1]) | (fsm_output[8]);
  assign mux_72_nl = MUX_s_1_2_2(or_225_nl, or_tmp_56, fsm_output[2]);
  assign mux_74_itm = MUX_s_1_2_2(mux_73_nl, mux_72_nl, fsm_output[3]);
  assign and_167_rmff = (~ (fsm_output[8])) & (fsm_output[1]) & (fsm_output[2]);
  assign and_cse = (fsm_output[8]) & or_30_cse;
  assign and_268_cse = (fsm_output[1:0]==2'b11);
  assign and_267_cse = (fsm_output[7:5]==3'b111);
  assign or_244_cse = (fsm_output[3:2]!=2'b00);
  assign and_243_cse = (fsm_output[5:4]==2'b11);
  assign or_247_cse = (fsm_output[6:5]!=2'b00);
  assign and_258_cse = (fsm_output[7:4]==4'b1111);
  assign or_265_cse = (fsm_output[1:0]!=2'b10);
  assign COMP_LOOP_twiddle_f_or_8_cse = and_dcpl_70 | and_dcpl_101;
  assign COMP_LOOP_twiddle_f_or_7_rgt = and_dcpl_58 | and_dcpl_80 | and_dcpl_95 |
      and_dcpl_107;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_nl = MUX_v_5_2_2((z_out_3[4:0]),
      VEC_LOOP_acc_psp_sva_mx0w0, and_dcpl_35);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_3_nl = MUX_v_7_2_2((z_out_2_8_0[6:0]),
      (z_out_6[6:0]), COMP_LOOP_twiddle_f_or_8_cse);
  assign mux_102_nl = MUX_s_1_2_2((~ (fsm_output[0])), (fsm_output[0]), fsm_output[1]);
  assign mux_103_nl = MUX_s_1_2_2(or_265_cse, mux_102_nl, fsm_output[2]);
  assign and_210_nl = (~ mux_103_nl) & and_dcpl_32 & and_dcpl_71 & and_dcpl_126;
  assign COMP_LOOP_twiddle_f_or_4_nl = (and_dcpl_48 & and_dcpl_143) | (and_dcpl_75
      & and_dcpl_143) | (and_dcpl_91 & and_dcpl_143) | (and_dcpl_103 & and_dcpl_143);
  assign or_258_nl = (fsm_output[6:4]!=3'b100);
  assign mux_112_nl = MUX_s_1_2_2(or_258_nl, mux_tmp_108, and_268_cse);
  assign mux_110_nl = MUX_s_1_2_2(or_281_cse, mux_tmp_108, fsm_output[0]);
  assign mux_109_nl = MUX_s_1_2_2(mux_tmp_108, or_281_cse, fsm_output[0]);
  assign mux_111_nl = MUX_s_1_2_2(mux_110_nl, mux_109_nl, fsm_output[1]);
  assign mux_113_nl = MUX_s_1_2_2(mux_112_nl, mux_111_nl, fsm_output[2]);
  assign mux_114_nl = MUX_s_1_2_2(mux_113_nl, or_281_cse, fsm_output[3]);
  assign nor_64_nl = ~(mux_114_nl | (fsm_output[8]));
  assign COMP_LOOP_twiddle_f_mux1h_40_rgt = MUX1HOT_v_8_4_2(({3'b000 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_2_nl}),
      (z_out_2_8_0[7:0]), (z_out_6[7:0]), ({1'b0 , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_3_nl}),
      {and_210_nl , COMP_LOOP_twiddle_f_or_4_nl , COMP_LOOP_twiddle_f_or_7_rgt ,
      nor_64_nl});
  assign nor_129_cse = ~((fsm_output[7:5]!=3'b100));
  assign and_650_cse = (fsm_output[6:5]==2'b11);
  assign or_281_cse = (fsm_output[6:4]!=3'b011);
  assign or_299_cse = (fsm_output[6:5]!=2'b10);
  assign or_282_cse = (fsm_output[6:5]!=2'b01);
  assign nor_119_nl = ~((fsm_output[7:4]!=4'b0000));
  assign and_647_nl = (fsm_output[4]) & (~((fsm_output[6:5]==2'b11)));
  assign mux_142_nl = MUX_s_1_2_2(nor_119_nl, and_647_nl, fsm_output[0]);
  assign and_646_cse = (fsm_output[1]) & mux_142_nl;
  assign nor_123_cse = ~((fsm_output[8]) | (fsm_output[3]));
  assign COMP_LOOP_twiddle_f_or_6_rgt = and_dcpl_49 | and_dcpl_65 | and_dcpl_76 |
      and_dcpl_83 | and_dcpl_92 | and_dcpl_98 | and_dcpl_104 | and_dcpl_110;
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & and_dcpl_220;
  assign nor_56_cse = ~((fsm_output[1:0]!=2'b00));
  assign nl_VEC_LOOP_acc_psp_sva_mx0w0 = (VEC_LOOP_acc_1_cse_10_sva[9:5]) + COMP_LOOP_k_10_5_sva_4_0;
  assign VEC_LOOP_acc_psp_sva_mx0w0 = nl_VEC_LOOP_acc_psp_sva_mx0w0[4:0];
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b1111;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_1 = (~ STAGE_LOOP_i_3_0_sva) + 4'b1011;
  assign COMP_LOOP_1_twiddle_f_acc_cse_sva_1 = nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_1[3:0];
  assign nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_2_sva_mx0w1 = nl_VEC_LOOP_acc_10_cse_2_sva_mx0w1[9:0];
  assign nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_3_sva_mx0w2 = nl_VEC_LOOP_acc_10_cse_3_sva_mx0w2[9:0];
  assign nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_4_sva_mx0w3 = nl_VEC_LOOP_acc_10_cse_4_sva_mx0w3[9:0];
  assign nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_5_sva_mx0w4 = nl_VEC_LOOP_acc_10_cse_5_sva_mx0w4[9:0];
  assign nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_6_sva_mx0w5 = nl_VEC_LOOP_acc_10_cse_6_sva_mx0w5[9:0];
  assign nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_7_sva_mx0w6 = nl_VEC_LOOP_acc_10_cse_7_sva_mx0w6[9:0];
  assign nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_8_sva_mx0w7 = nl_VEC_LOOP_acc_10_cse_8_sva_mx0w7[9:0];
  assign nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_10_sva_mx0w9 = nl_VEC_LOOP_acc_10_cse_10_sva_mx0w9[9:0];
  assign nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_11_sva_mx0w10 = nl_VEC_LOOP_acc_10_cse_11_sva_mx0w10[9:0];
  assign nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_12_sva_mx0w11 = nl_VEC_LOOP_acc_10_cse_12_sva_mx0w11[9:0];
  assign nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_13_sva_mx0w12 = nl_VEC_LOOP_acc_10_cse_13_sva_mx0w12[9:0];
  assign nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_14_sva_mx0w13 = nl_VEC_LOOP_acc_10_cse_14_sva_mx0w13[9:0];
  assign nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_15_sva_mx0w14 = nl_VEC_LOOP_acc_10_cse_15_sva_mx0w14[9:0];
  assign nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_16_sva_mx0w15 = nl_VEC_LOOP_acc_10_cse_16_sva_mx0w15[9:0];
  assign nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_18_sva_mx0w17 = nl_VEC_LOOP_acc_10_cse_18_sva_mx0w17[9:0];
  assign nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_19_sva_mx0w18 = nl_VEC_LOOP_acc_10_cse_19_sva_mx0w18[9:0];
  assign nl_VEC_LOOP_acc_10_cse_20_sva_mx0w19 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_20_sva_mx0w19 = nl_VEC_LOOP_acc_10_cse_20_sva_mx0w19[9:0];
  assign nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_21_sva_mx0w20 = nl_VEC_LOOP_acc_10_cse_21_sva_mx0w20[9:0];
  assign nl_VEC_LOOP_acc_10_cse_22_sva_mx0w21 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_22_sva_mx0w21 = nl_VEC_LOOP_acc_10_cse_22_sva_mx0w21[9:0];
  assign nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_23_sva_mx0w22 = nl_VEC_LOOP_acc_10_cse_23_sva_mx0w22[9:0];
  assign nl_VEC_LOOP_acc_10_cse_24_sva_mx0w23 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_24_sva_mx0w23 = nl_VEC_LOOP_acc_10_cse_24_sva_mx0w23[9:0];
  assign nl_VEC_LOOP_acc_10_cse_26_sva_mx0w25 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_26_sva_mx0w25 = nl_VEC_LOOP_acc_10_cse_26_sva_mx0w25[9:0];
  assign nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_27_sva_mx0w26 = nl_VEC_LOOP_acc_10_cse_27_sva_mx0w26[9:0];
  assign nl_VEC_LOOP_acc_10_cse_28_sva_mx0w27 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_28_sva_mx0w27 = nl_VEC_LOOP_acc_10_cse_28_sva_mx0w27[9:0];
  assign nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_29_sva_mx0w28 = nl_VEC_LOOP_acc_10_cse_29_sva_mx0w28[9:0];
  assign nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_30_sva_mx0w29 = nl_VEC_LOOP_acc_10_cse_30_sva_mx0w29[9:0];
  assign nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_31_sva_mx0w30 = nl_VEC_LOOP_acc_10_cse_31_sva_mx0w30[9:0];
  assign nl_VEC_LOOP_acc_10_cse_sva_mx0w31 = z_out_9 + VEC_LOOP_acc_1_cse_10_sva;
  assign VEC_LOOP_acc_10_cse_sva_mx0w31 = nl_VEC_LOOP_acc_10_cse_sva_mx0w31[9:0];
  assign and_dcpl_3 = ~((fsm_output[8]) | (fsm_output[5]));
  assign or_30_cse = (fsm_output[7:4]!=4'b0000);
  assign and_8_cse = (fsm_output[6]) & or_215_cse;
  assign mux_52_cse = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[8]), or_30_cse);
  assign or_dcpl_152 = (fsm_output[4]) | (fsm_output[7]);
  assign or_tmp_46 = (~ (fsm_output[0])) | (fsm_output[8]);
  assign and_dcpl_25 = (fsm_output[2:1]==2'b10);
  assign and_dcpl_26 = (~ (fsm_output[8])) & (fsm_output[0]);
  assign and_dcpl_28 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_29 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_30 = and_dcpl_29 & and_dcpl_28;
  assign and_dcpl_31 = ~((fsm_output[4]) | (fsm_output[7]));
  assign and_dcpl_32 = ~((fsm_output[8]) | (fsm_output[6]));
  assign and_dcpl_33 = and_dcpl_32 & (~ (fsm_output[5]));
  assign and_dcpl_34 = and_dcpl_33 & and_dcpl_31;
  assign and_dcpl_35 = and_dcpl_34 & and_dcpl_30;
  assign and_dcpl_37 = and_268_cse & and_dcpl_28;
  assign and_dcpl_39 = (fsm_output[1:0]==2'b10);
  assign xor_dcpl_1 = (or_247_cse | (fsm_output[4]) | (fsm_output[7]) | (fsm_output[3]))
      ^ (fsm_output[8]);
  assign and_dcpl_41 = xor_dcpl_1 & and_dcpl_39 & (~ (fsm_output[2]));
  assign and_dcpl_42 = (fsm_output[3:2]==2'b11);
  assign and_dcpl_43 = and_dcpl_29 & and_dcpl_42;
  assign and_dcpl_44 = and_dcpl_34 & and_dcpl_43;
  assign and_dcpl_45 = and_dcpl_26 & (fsm_output[1]);
  assign and_dcpl_47 = (fsm_output[4]) & (~ (fsm_output[7]));
  assign and_dcpl_48 = and_dcpl_33 & and_dcpl_47;
  assign and_dcpl_49 = and_dcpl_48 & and_dcpl_30;
  assign and_dcpl_50 = (fsm_output[2:1]==2'b11);
  assign and_dcpl_51 = and_dcpl_50 & (~ (fsm_output[3]));
  assign and_dcpl_53 = (~ (fsm_output[8])) & (fsm_output[4]) & (fsm_output[0]);
  assign and_dcpl_54 = and_dcpl_53 & and_dcpl_51;
  assign and_dcpl_55 = and_dcpl_48 & and_dcpl_43;
  assign and_dcpl_56 = and_dcpl_32 & (fsm_output[5]);
  assign and_dcpl_57 = and_dcpl_56 & and_dcpl_31;
  assign and_dcpl_58 = and_dcpl_57 & and_dcpl_30;
  assign and_dcpl_59 = (~ (fsm_output[4])) & (fsm_output[0]);
  assign and_dcpl_61 = (~ (fsm_output[8])) & (fsm_output[5]) & and_dcpl_59;
  assign and_dcpl_62 = and_dcpl_61 & and_dcpl_51;
  assign and_dcpl_63 = and_dcpl_57 & and_dcpl_43;
  assign and_dcpl_64 = and_dcpl_56 & and_dcpl_47;
  assign and_dcpl_65 = and_dcpl_64 & and_dcpl_30;
  assign and_dcpl_66 = and_dcpl_64 & and_dcpl_43;
  assign and_dcpl_67 = (~ (fsm_output[8])) & (fsm_output[6]);
  assign and_dcpl_68 = and_dcpl_67 & (~ (fsm_output[5]));
  assign and_dcpl_69 = and_dcpl_68 & and_dcpl_31;
  assign and_dcpl_70 = and_dcpl_69 & and_dcpl_30;
  assign and_dcpl_71 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_72 = and_dcpl_67 & and_dcpl_71;
  assign and_dcpl_73 = and_dcpl_72 & and_dcpl_37;
  assign and_dcpl_74 = and_dcpl_69 & and_dcpl_43;
  assign and_dcpl_75 = and_dcpl_68 & and_dcpl_47;
  assign and_dcpl_76 = and_dcpl_75 & and_dcpl_30;
  assign and_dcpl_77 = and_dcpl_75 & and_dcpl_43;
  assign and_dcpl_78 = and_dcpl_67 & (fsm_output[5]);
  assign and_dcpl_79 = and_dcpl_78 & and_dcpl_31;
  assign and_dcpl_80 = and_dcpl_79 & and_dcpl_30;
  assign and_dcpl_81 = and_dcpl_79 & and_dcpl_43;
  assign and_dcpl_82 = and_dcpl_78 & and_dcpl_47;
  assign and_dcpl_83 = and_dcpl_82 & and_dcpl_30;
  assign and_dcpl_84 = and_dcpl_82 & and_dcpl_43;
  assign and_dcpl_85 = (~ (fsm_output[4])) & (fsm_output[7]);
  assign and_dcpl_86 = and_dcpl_33 & and_dcpl_85;
  assign and_dcpl_87 = and_dcpl_86 & and_dcpl_30;
  assign and_dcpl_88 = and_dcpl_86 & and_dcpl_37;
  assign and_dcpl_89 = and_dcpl_86 & and_dcpl_43;
  assign and_dcpl_90 = (fsm_output[4]) & (fsm_output[7]);
  assign and_dcpl_91 = and_dcpl_33 & and_dcpl_90;
  assign and_dcpl_92 = and_dcpl_91 & and_dcpl_30;
  assign and_dcpl_93 = and_dcpl_91 & and_dcpl_43;
  assign and_dcpl_94 = and_dcpl_56 & and_dcpl_85;
  assign and_dcpl_95 = and_dcpl_94 & and_dcpl_30;
  assign and_dcpl_96 = and_dcpl_94 & and_dcpl_43;
  assign and_dcpl_97 = and_dcpl_56 & and_dcpl_90;
  assign and_dcpl_98 = and_dcpl_97 & and_dcpl_30;
  assign and_dcpl_99 = and_dcpl_97 & and_dcpl_43;
  assign and_dcpl_100 = and_dcpl_68 & and_dcpl_85;
  assign and_dcpl_101 = and_dcpl_100 & and_dcpl_30;
  assign and_dcpl_102 = and_dcpl_100 & and_dcpl_43;
  assign and_dcpl_103 = and_dcpl_68 & and_dcpl_90;
  assign and_dcpl_104 = and_dcpl_103 & and_dcpl_30;
  assign and_dcpl_105 = and_dcpl_103 & and_dcpl_43;
  assign and_dcpl_106 = and_dcpl_78 & and_dcpl_85;
  assign and_dcpl_107 = and_dcpl_106 & and_dcpl_30;
  assign and_dcpl_108 = and_dcpl_106 & and_dcpl_43;
  assign and_dcpl_109 = and_dcpl_78 & and_dcpl_90;
  assign and_dcpl_110 = and_dcpl_109 & and_dcpl_30;
  assign and_dcpl_111 = and_dcpl_109 & and_dcpl_43;
  assign and_dcpl_112 = and_dcpl_26 & (fsm_output[2]);
  assign and_dcpl_117 = ~((fsm_output[8]) | (fsm_output[4]));
  assign and_dcpl_126 = ~((fsm_output[7]) | (fsm_output[3]));
  assign and_dcpl_128 = ~((fsm_output[6:4]!=3'b000));
  assign and_dcpl_129 = and_dcpl_128 & and_dcpl_126;
  assign and_dcpl_132 = (fsm_output[2:1]==2'b01);
  assign and_dcpl_136 = and_dcpl_45 & (fsm_output[3:2]==2'b10);
  assign and_dcpl_137 = and_dcpl_132 & (~ (fsm_output[3]));
  assign and_dcpl_138 = and_dcpl_53 & and_dcpl_137;
  assign and_dcpl_139 = and_dcpl_61 & and_dcpl_137;
  assign and_dcpl_142 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_143 = and_268_cse & and_dcpl_142;
  assign and_dcpl_144 = and_dcpl_72 & and_dcpl_143;
  assign and_dcpl_149 = and_dcpl_86 & and_dcpl_143;
  assign and_dcpl_151 = and_dcpl_34 & and_dcpl_143;
  assign and_dcpl_157 = (fsm_output[8]) & (~ (fsm_output[6])) & (~ (fsm_output[5]))
      & and_dcpl_31;
  assign or_tmp_56 = (~ (fsm_output[1])) | (~ (fsm_output[0])) | (fsm_output[8]);
  assign and_dcpl_164 = ~((fsm_output[8]) | (fsm_output[0]));
  assign and_dcpl_165 = and_dcpl_164 & and_dcpl_50;
  assign mux_79_nl = MUX_s_1_2_2(mux_52_cse, and_cse, fsm_output[1]);
  assign and_252_nl = ((fsm_output[1]) | (fsm_output[0]) | (fsm_output[7]) | (fsm_output[6])
      | (fsm_output[4]) | (fsm_output[5])) & (fsm_output[8]);
  assign mux_80_nl = MUX_s_1_2_2(mux_79_nl, and_252_nl, fsm_output[2]);
  assign mux_tmp_81 = MUX_s_1_2_2(mux_80_nl, (fsm_output[8]), fsm_output[3]);
  assign and_245_nl = (fsm_output[6:4]==3'b111);
  assign mux_tmp_84 = MUX_s_1_2_2(and_dcpl_128, and_245_nl, fsm_output[7]);
  assign and_dcpl_182 = and_268_cse & (~ (fsm_output[2]));
  assign not_tmp_93 = ~((fsm_output[2]) | and_268_cse | (fsm_output[7:4]!=4'b0000));
  assign mux_tmp_108 = MUX_s_1_2_2(or_299_cse, or_282_cse, fsm_output[4]);
  assign and_dcpl_220 = and_dcpl_164 & and_dcpl_25;
  assign mux_tmp_121 = MUX_s_1_2_2(and_dcpl_128, and_8_cse, fsm_output[7]);
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_157 & and_dcpl_30;
  assign VEC_LOOP_or_5_cse = and_dcpl_55 | and_dcpl_63 | and_dcpl_66 | and_dcpl_74
      | and_dcpl_77 | and_dcpl_81 | and_dcpl_84 | and_dcpl_89 | and_dcpl_93 | and_dcpl_96
      | and_dcpl_99 | and_dcpl_102 | and_dcpl_105 | and_dcpl_108 | and_dcpl_111;
  assign VEC_LOOP_or_13_cse = and_dcpl_70 | and_dcpl_87 | and_dcpl_101;
  assign VEC_LOOP_mux1h_10_nl = MUX1HOT_v_6_7_2((z_out_10[9:4]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[9:4]),
      (z_out_6[8:3]), (z_out_8[9:4]), (z_out_6[7:2]), (z_out_6[6:1]), (z_out_6[5:0]),
      {and_dcpl_35 , and_dcpl_44 , COMP_LOOP_twiddle_f_or_6_rgt , VEC_LOOP_or_5_cse
      , COMP_LOOP_twiddle_f_or_7_rgt , COMP_LOOP_twiddle_f_or_8_cse , and_dcpl_87});
  assign VEC_LOOP_mux1h_8_nl = MUX1HOT_s_1_7_2((z_out_10[3]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[3]),
      (z_out_6[2]), (z_out_8[3]), (z_out_6[1]), (z_out_6[0]), (VEC_LOOP_acc_1_cse_10_sva[3]),
      {and_dcpl_35 , and_dcpl_44 , COMP_LOOP_twiddle_f_or_6_rgt , VEC_LOOP_or_5_cse
      , COMP_LOOP_twiddle_f_or_7_rgt , COMP_LOOP_twiddle_f_or_8_cse , and_dcpl_87});
  assign and_128_nl = and_dcpl_3 & (~ (fsm_output[4])) & ((fsm_output[7:6]!=2'b00))
      & and_dcpl_30;
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_s_1_6_2((z_out_10[2]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[2]),
      (z_out_6[1]), (z_out_8[2]), (z_out_6[0]), (VEC_LOOP_acc_1_cse_10_sva[2]), {and_dcpl_35
      , and_dcpl_44 , COMP_LOOP_twiddle_f_or_6_rgt , VEC_LOOP_or_5_cse , COMP_LOOP_twiddle_f_or_7_rgt
      , and_128_nl});
  assign and_123_nl = (or_247_cse | (fsm_output[7])) & and_dcpl_117 & and_dcpl_30;
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_5_2((z_out_10[1]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[1]),
      (z_out_6[0]), (z_out_8[1]), (VEC_LOOP_acc_1_cse_10_sva[1]), {and_dcpl_35 ,
      and_dcpl_44 , COMP_LOOP_twiddle_f_or_6_rgt , VEC_LOOP_or_5_cse , and_123_nl});
  assign and_119_nl = or_30_cse & (~ (fsm_output[8])) & and_dcpl_30;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_4_2((z_out_10[0]), (VEC_LOOP_acc_10_cse_2_sva_mx0w1[0]),
      (VEC_LOOP_acc_1_cse_10_sva[0]), (z_out_8[0]), {and_dcpl_35 , and_dcpl_44 ,
      and_119_nl , VEC_LOOP_or_5_cse});
  assign and_42_nl = and_dcpl_34 & and_dcpl_37;
  assign and_50_nl = and_dcpl_45 & and_dcpl_42;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_5_37_2(VEC_LOOP_acc_psp_sva_mx0w0, reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg,
      (VEC_LOOP_acc_10_cse_1_sva[9:5]), (z_out_8[9:5]), (VEC_LOOP_acc_1_cse_10_sva[9:5]),
      (VEC_LOOP_acc_10_cse_3_sva_mx0w2[9:5]), (COMP_LOOP_11_twiddle_f_mul_psp_sva[8:4]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[9:5]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[9:5]),
      ({COMP_LOOP_13_twiddle_f_mul_psp_sva_7 , reg_COMP_LOOP_13_twiddle_f_mul_psp_1_reg
      , (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[4:3])}), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[9:5]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[9:5]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[9:5]),
      (z_out_10[9:5]), ({reg_COMP_LOOP_13_twiddle_f_mul_psp_1_reg , (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[4:2])}),
      (VEC_LOOP_acc_10_cse_10_sva_mx0w9[9:5]), (VEC_LOOP_acc_10_cse_11_sva_mx0w10[9:5]),
      (VEC_LOOP_acc_10_cse_12_sva_mx0w11[9:5]), (VEC_LOOP_acc_10_cse_13_sva_mx0w12[9:5]),
      (VEC_LOOP_acc_10_cse_14_sva_mx0w13[9:5]), (VEC_LOOP_acc_10_cse_15_sva_mx0w14[9:5]),
      (VEC_LOOP_acc_10_cse_16_sva_mx0w15[9:5]), (COMP_LOOP_17_twiddle_f_lshift_itm[5:1]),
      (VEC_LOOP_acc_10_cse_18_sva_mx0w17[9:5]), (VEC_LOOP_acc_10_cse_19_sva_mx0w18[9:5]),
      (VEC_LOOP_acc_10_cse_20_sva_mx0w19[9:5]), (VEC_LOOP_acc_10_cse_21_sva_mx0w20[9:5]),
      (VEC_LOOP_acc_10_cse_22_sva_mx0w21[9:5]), (VEC_LOOP_acc_10_cse_23_sva_mx0w22[9:5]),
      (VEC_LOOP_acc_10_cse_24_sva_mx0w23[9:5]), (VEC_LOOP_acc_10_cse_26_sva_mx0w25[9:5]),
      (VEC_LOOP_acc_10_cse_27_sva_mx0w26[9:5]), (VEC_LOOP_acc_10_cse_28_sva_mx0w27[9:5]),
      (VEC_LOOP_acc_10_cse_29_sva_mx0w28[9:5]), (VEC_LOOP_acc_10_cse_30_sva_mx0w29[9:5]),
      (VEC_LOOP_acc_10_cse_31_sva_mx0w30[9:5]), (VEC_LOOP_acc_10_cse_sva_mx0w31[9:5]),
      {and_dcpl_35 , and_42_nl , and_dcpl_41 , and_dcpl_44 , and_50_nl , and_dcpl_49
      , and_dcpl_54 , and_dcpl_55 , and_dcpl_58 , and_dcpl_62 , and_dcpl_63 , and_dcpl_65
      , and_dcpl_66 , VEC_LOOP_or_13_cse , and_dcpl_73 , and_dcpl_74 , and_dcpl_76
      , and_dcpl_77 , and_dcpl_80 , and_dcpl_81 , and_dcpl_83 , and_dcpl_84 , and_dcpl_88
      , and_dcpl_89 , and_dcpl_92 , and_dcpl_93 , and_dcpl_95 , and_dcpl_96 , and_dcpl_98
      , and_dcpl_99 , and_dcpl_102 , and_dcpl_104 , and_dcpl_105 , and_dcpl_107 ,
      and_dcpl_108 , and_dcpl_110 , and_dcpl_111});
  assign mux_63_nl = MUX_s_1_2_2((~ or_30_cse), (fsm_output[1]), fsm_output[3]);
  assign and_117_nl = mux_63_nl & and_dcpl_112;
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_35_2((VEC_LOOP_acc_1_cse_10_sva[4]), (VEC_LOOP_acc_10_cse_1_sva[4]),
      (z_out_8[4]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[4]), (COMP_LOOP_11_twiddle_f_mul_psp_sva[3]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[4]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[4]),
      (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[2]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[4]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[4]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[4]),
      (z_out_10[4]), (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[1]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[4]),
      (VEC_LOOP_acc_10_cse_11_sva_mx0w10[4]), (VEC_LOOP_acc_10_cse_12_sva_mx0w11[4]),
      (VEC_LOOP_acc_10_cse_13_sva_mx0w12[4]), (VEC_LOOP_acc_10_cse_14_sva_mx0w13[4]),
      (VEC_LOOP_acc_10_cse_15_sva_mx0w14[4]), (VEC_LOOP_acc_10_cse_16_sva_mx0w15[4]),
      (COMP_LOOP_17_twiddle_f_lshift_itm[0]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[4]),
      (VEC_LOOP_acc_10_cse_19_sva_mx0w18[4]), (VEC_LOOP_acc_10_cse_20_sva_mx0w19[4]),
      (VEC_LOOP_acc_10_cse_21_sva_mx0w20[4]), (VEC_LOOP_acc_10_cse_22_sva_mx0w21[4]),
      (VEC_LOOP_acc_10_cse_23_sva_mx0w22[4]), (VEC_LOOP_acc_10_cse_24_sva_mx0w23[4]),
      (VEC_LOOP_acc_10_cse_26_sva_mx0w25[4]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[4]),
      (VEC_LOOP_acc_10_cse_28_sva_mx0w27[4]), (VEC_LOOP_acc_10_cse_29_sva_mx0w28[4]),
      (VEC_LOOP_acc_10_cse_30_sva_mx0w29[4]), (VEC_LOOP_acc_10_cse_31_sva_mx0w30[4]),
      (VEC_LOOP_acc_10_cse_sva_mx0w31[4]), {and_117_nl , and_dcpl_41 , and_dcpl_44
      , and_dcpl_49 , and_dcpl_54 , and_dcpl_55 , and_dcpl_58 , and_dcpl_62 , and_dcpl_63
      , and_dcpl_65 , and_dcpl_66 , VEC_LOOP_or_13_cse , and_dcpl_73 , and_dcpl_74
      , and_dcpl_76 , and_dcpl_77 , and_dcpl_80 , and_dcpl_81 , and_dcpl_83 , and_dcpl_84
      , and_dcpl_88 , and_dcpl_89 , and_dcpl_92 , and_dcpl_93 , and_dcpl_95 , and_dcpl_96
      , and_dcpl_98 , and_dcpl_99 , and_dcpl_102 , and_dcpl_104 , and_dcpl_105 ,
      and_dcpl_107 , and_dcpl_108 , and_dcpl_110 , and_dcpl_111});
  assign nor_49_nl = ~((~((fsm_output[1]) | (~ (fsm_output[7])))) | (fsm_output[6:4]!=3'b000));
  assign mux_64_nl = MUX_s_1_2_2(nor_49_nl, (fsm_output[1]), fsm_output[3]);
  assign and_120_nl = mux_64_nl & and_dcpl_112;
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_34_2((VEC_LOOP_acc_1_cse_10_sva[3]), (VEC_LOOP_acc_10_cse_1_sva[3]),
      (z_out_8[3]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[3]), (COMP_LOOP_11_twiddle_f_mul_psp_sva[2]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[3]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[3]),
      (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[1]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[3]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[3]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[3]),
      (z_out_10[3]), (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[0]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[3]),
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
      {and_120_nl , and_dcpl_41 , and_dcpl_44 , and_dcpl_49 , and_dcpl_54 , and_dcpl_55
      , and_dcpl_58 , and_dcpl_62 , and_dcpl_63 , and_dcpl_65 , and_dcpl_66 , VEC_LOOP_or_13_cse
      , and_dcpl_73 , and_dcpl_74 , and_dcpl_76 , and_dcpl_77 , and_dcpl_80 , and_dcpl_81
      , and_dcpl_83 , and_dcpl_84 , and_dcpl_89 , and_dcpl_92 , and_dcpl_93 , and_dcpl_95
      , and_dcpl_96 , and_dcpl_98 , and_dcpl_99 , and_dcpl_102 , and_dcpl_104 , and_dcpl_105
      , and_dcpl_107 , and_dcpl_108 , and_dcpl_110 , and_dcpl_111});
  assign mux_65_nl = MUX_s_1_2_2(or_30_cse, or_215_cse, fsm_output[1]);
  assign mux_66_nl = MUX_s_1_2_2((~ mux_65_nl), (fsm_output[1]), fsm_output[3]);
  assign and_124_nl = mux_66_nl & and_dcpl_112;
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_33_2((VEC_LOOP_acc_1_cse_10_sva[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_8[2]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[2]), (COMP_LOOP_11_twiddle_f_mul_psp_sva[1]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[2]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[2]),
      (reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg[0]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[2]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[2]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[2]),
      (z_out_10[2]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[2]), (VEC_LOOP_acc_10_cse_11_sva_mx0w10[2]),
      (VEC_LOOP_acc_10_cse_12_sva_mx0w11[2]), (VEC_LOOP_acc_10_cse_13_sva_mx0w12[2]),
      (VEC_LOOP_acc_10_cse_14_sva_mx0w13[2]), (VEC_LOOP_acc_10_cse_15_sva_mx0w14[2]),
      (VEC_LOOP_acc_10_cse_16_sva_mx0w15[2]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[2]),
      (VEC_LOOP_acc_10_cse_19_sva_mx0w18[2]), (VEC_LOOP_acc_10_cse_20_sva_mx0w19[2]),
      (VEC_LOOP_acc_10_cse_21_sva_mx0w20[2]), (VEC_LOOP_acc_10_cse_22_sva_mx0w21[2]),
      (VEC_LOOP_acc_10_cse_23_sva_mx0w22[2]), (VEC_LOOP_acc_10_cse_24_sva_mx0w23[2]),
      (VEC_LOOP_acc_10_cse_26_sva_mx0w25[2]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[2]),
      (VEC_LOOP_acc_10_cse_28_sva_mx0w27[2]), (VEC_LOOP_acc_10_cse_29_sva_mx0w28[2]),
      (VEC_LOOP_acc_10_cse_30_sva_mx0w29[2]), (VEC_LOOP_acc_10_cse_31_sva_mx0w30[2]),
      (VEC_LOOP_acc_10_cse_sva_mx0w31[2]), {and_124_nl , and_dcpl_41 , and_dcpl_44
      , and_dcpl_49 , and_dcpl_54 , and_dcpl_55 , and_dcpl_58 , and_dcpl_62 , and_dcpl_63
      , and_dcpl_65 , and_dcpl_66 , VEC_LOOP_or_13_cse , and_dcpl_74 , and_dcpl_76
      , and_dcpl_77 , and_dcpl_80 , and_dcpl_81 , and_dcpl_83 , and_dcpl_84 , and_dcpl_89
      , and_dcpl_92 , and_dcpl_93 , and_dcpl_95 , and_dcpl_96 , and_dcpl_98 , and_dcpl_99
      , and_dcpl_102 , and_dcpl_104 , and_dcpl_105 , and_dcpl_107 , and_dcpl_108
      , and_dcpl_110 , and_dcpl_111});
  assign mux_67_nl = MUX_s_1_2_2(or_30_cse, (fsm_output[4]), fsm_output[1]);
  assign mux_68_nl = MUX_s_1_2_2((~ mux_67_nl), (fsm_output[1]), fsm_output[3]);
  assign and_129_nl = mux_68_nl & and_dcpl_112;
  assign VEC_LOOP_mux1h_7_nl = MUX1HOT_s_1_32_2((VEC_LOOP_acc_1_cse_10_sva[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_8[1]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[1]), (COMP_LOOP_11_twiddle_f_mul_psp_sva[0]),
      (VEC_LOOP_acc_10_cse_4_sva_mx0w3[1]), (VEC_LOOP_acc_10_cse_5_sva_mx0w4[1]),
      (VEC_LOOP_acc_10_cse_6_sva_mx0w5[1]), (VEC_LOOP_acc_10_cse_7_sva_mx0w6[1]),
      (VEC_LOOP_acc_10_cse_8_sva_mx0w7[1]), (z_out_10[1]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[1]),
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
      {and_129_nl , and_dcpl_41 , and_dcpl_44 , and_dcpl_49 , and_dcpl_54 , and_dcpl_55
      , and_dcpl_58 , and_dcpl_63 , and_dcpl_65 , and_dcpl_66 , VEC_LOOP_or_13_cse
      , and_dcpl_74 , and_dcpl_76 , and_dcpl_77 , and_dcpl_80 , and_dcpl_81 , and_dcpl_83
      , and_dcpl_84 , and_dcpl_89 , and_dcpl_92 , and_dcpl_93 , and_dcpl_95 , and_dcpl_96
      , and_dcpl_98 , and_dcpl_99 , and_dcpl_102 , and_dcpl_104 , and_dcpl_105 ,
      and_dcpl_107 , and_dcpl_108 , and_dcpl_110 , and_dcpl_111});
  assign and_134_nl = (and_dcpl_129 | (fsm_output[1])) & and_dcpl_112;
  assign VEC_LOOP_mux1h_9_nl = MUX1HOT_s_1_31_2((VEC_LOOP_acc_1_cse_10_sva[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_8[0]), (VEC_LOOP_acc_10_cse_3_sva_mx0w2[0]), (VEC_LOOP_acc_10_cse_4_sva_mx0w3[0]),
      (VEC_LOOP_acc_10_cse_5_sva_mx0w4[0]), (VEC_LOOP_acc_10_cse_6_sva_mx0w5[0]),
      (VEC_LOOP_acc_10_cse_7_sva_mx0w6[0]), (VEC_LOOP_acc_10_cse_8_sva_mx0w7[0]),
      (z_out_10[0]), (VEC_LOOP_acc_10_cse_10_sva_mx0w9[0]), (VEC_LOOP_acc_10_cse_11_sva_mx0w10[0]),
      (VEC_LOOP_acc_10_cse_12_sva_mx0w11[0]), (VEC_LOOP_acc_10_cse_13_sva_mx0w12[0]),
      (VEC_LOOP_acc_10_cse_14_sva_mx0w13[0]), (VEC_LOOP_acc_10_cse_15_sva_mx0w14[0]),
      (VEC_LOOP_acc_10_cse_16_sva_mx0w15[0]), (VEC_LOOP_acc_10_cse_18_sva_mx0w17[0]),
      (VEC_LOOP_acc_10_cse_19_sva_mx0w18[0]), (VEC_LOOP_acc_10_cse_20_sva_mx0w19[0]),
      (VEC_LOOP_acc_10_cse_21_sva_mx0w20[0]), (VEC_LOOP_acc_10_cse_22_sva_mx0w21[0]),
      (VEC_LOOP_acc_10_cse_23_sva_mx0w22[0]), (VEC_LOOP_acc_10_cse_24_sva_mx0w23[0]),
      (VEC_LOOP_acc_10_cse_26_sva_mx0w25[0]), (VEC_LOOP_acc_10_cse_27_sva_mx0w26[0]),
      (VEC_LOOP_acc_10_cse_28_sva_mx0w27[0]), (VEC_LOOP_acc_10_cse_29_sva_mx0w28[0]),
      (VEC_LOOP_acc_10_cse_30_sva_mx0w29[0]), (VEC_LOOP_acc_10_cse_31_sva_mx0w30[0]),
      (VEC_LOOP_acc_10_cse_sva_mx0w31[0]), {and_134_nl , and_dcpl_41 , and_dcpl_44
      , and_dcpl_49 , and_dcpl_55 , and_dcpl_58 , and_dcpl_63 , and_dcpl_65 , and_dcpl_66
      , VEC_LOOP_or_13_cse , and_dcpl_74 , and_dcpl_76 , and_dcpl_77 , and_dcpl_80
      , and_dcpl_81 , and_dcpl_83 , and_dcpl_84 , and_dcpl_89 , and_dcpl_92 , and_dcpl_93
      , and_dcpl_95 , and_dcpl_96 , and_dcpl_98 , and_dcpl_99 , and_dcpl_102 , and_dcpl_104
      , and_dcpl_105 , and_dcpl_107 , and_dcpl_108 , and_dcpl_110 , and_dcpl_111});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_10_nl , VEC_LOOP_mux1h_8_nl , VEC_LOOP_mux1h_6_nl
      , VEC_LOOP_mux1h_4_nl , VEC_LOOP_mux1h_2_nl , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl
      , VEC_LOOP_mux1h_3_nl , VEC_LOOP_mux1h_5_nl , VEC_LOOP_mux1h_7_nl , VEC_LOOP_mux1h_9_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_adrb_d = {COMP_LOOP_twiddle_f_mux1h_25_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_9_rmff , COMP_LOOP_twiddle_f_mux1h_4_rmff , COMP_LOOP_twiddle_f_mux1h_12_rmff
      , COMP_LOOP_twiddle_f_mux_rmff};
  assign twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_adrb_d = {COMP_LOOP_twiddle_f_mux1h_25_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_9_rmff , COMP_LOOP_twiddle_f_mux1h_4_rmff , COMP_LOOP_twiddle_f_mux1h_12_rmff
      , COMP_LOOP_twiddle_f_mux_rmff};
  assign twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign and_dcpl_242 = (fsm_output[2:0]==3'b011);
  assign and_dcpl_243 = and_dcpl_242 & (~ (fsm_output[8])) & (fsm_output[6]);
  assign and_dcpl_244 = and_dcpl_243 & and_243_cse & and_dcpl_126;
  assign and_dcpl_246 = and_dcpl_71 & and_dcpl_126;
  assign and_dcpl_251 = (fsm_output[2:0]==3'b010) & and_dcpl_32 & and_dcpl_246;
  assign and_dcpl_252 = (~ (fsm_output[7])) & (fsm_output[3]);
  assign and_dcpl_253 = and_dcpl_71 & and_dcpl_252;
  assign and_dcpl_254 = and_dcpl_242 & and_dcpl_32;
  assign and_dcpl_255 = and_dcpl_254 & and_dcpl_253;
  assign and_dcpl_256 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_257 = and_dcpl_256 & and_dcpl_252;
  assign and_dcpl_258 = and_dcpl_254 & and_dcpl_257;
  assign and_dcpl_259 = (fsm_output[5:4]==2'b10);
  assign and_dcpl_260 = and_dcpl_259 & and_dcpl_252;
  assign and_dcpl_261 = and_dcpl_254 & and_dcpl_260;
  assign and_dcpl_262 = and_243_cse & and_dcpl_252;
  assign and_dcpl_263 = and_dcpl_254 & and_dcpl_262;
  assign and_dcpl_264 = and_dcpl_243 & and_dcpl_253;
  assign and_dcpl_265 = and_dcpl_243 & and_dcpl_257;
  assign and_dcpl_266 = and_dcpl_243 & and_dcpl_260;
  assign and_dcpl_267 = and_dcpl_243 & and_dcpl_262;
  assign and_dcpl_268 = (fsm_output[7]) & (fsm_output[3]);
  assign and_dcpl_269 = and_dcpl_71 & and_dcpl_268;
  assign and_dcpl_270 = and_dcpl_254 & and_dcpl_269;
  assign and_dcpl_271 = and_dcpl_256 & and_dcpl_268;
  assign and_dcpl_272 = and_dcpl_254 & and_dcpl_271;
  assign and_dcpl_274 = and_dcpl_254 & and_243_cse & and_dcpl_268;
  assign and_dcpl_275 = and_dcpl_243 & and_dcpl_269;
  assign and_dcpl_276 = and_dcpl_243 & and_dcpl_271;
  assign and_dcpl_278 = and_dcpl_243 & and_dcpl_259 & and_dcpl_268;
  assign and_dcpl_279 = and_dcpl_254 & and_dcpl_246;
  assign and_dcpl_281 = and_dcpl_243 & and_dcpl_259 & and_dcpl_126;
  assign and_dcpl_282 = (fsm_output[7]) & (~ (fsm_output[3]));
  assign and_dcpl_283 = and_dcpl_71 & and_dcpl_282;
  assign and_dcpl_284 = and_dcpl_254 & and_dcpl_283;
  assign and_dcpl_285 = and_dcpl_259 & and_dcpl_282;
  assign and_dcpl_286 = and_dcpl_254 & and_dcpl_285;
  assign and_dcpl_287 = and_dcpl_243 & and_dcpl_283;
  assign and_dcpl_288 = and_dcpl_243 & and_dcpl_285;
  assign and_dcpl_291 = and_dcpl_256 & and_dcpl_126;
  assign and_dcpl_295 = and_dcpl_242 & (~ (fsm_output[8])) & (~ (fsm_output[6]));
  assign and_dcpl_296 = and_dcpl_295 & and_dcpl_291;
  assign and_dcpl_299 = and_dcpl_295 & and_243_cse & and_dcpl_126;
  assign and_dcpl_302 = and_dcpl_295 & and_243_cse & and_dcpl_282;
  assign and_dcpl_305 = and_dcpl_243 & and_dcpl_291;
  assign and_dcpl_306 = and_dcpl_256 & and_dcpl_282;
  assign and_dcpl_307 = and_dcpl_295 & and_dcpl_306;
  assign and_dcpl_308 = and_dcpl_243 & and_dcpl_306;
  assign and_dcpl_311 = and_dcpl_295 & (fsm_output[5:4]==2'b10) & and_dcpl_126;
  assign and_dcpl_314 = and_dcpl_243 & (fsm_output[5:4]==2'b00) & and_dcpl_126;
  assign and_dcpl_329 = ~((fsm_output!=9'b000000010));
  assign and_dcpl_338 = (fsm_output[2:0]==3'b100);
  assign and_dcpl_339 = and_dcpl_338 & (~ (fsm_output[8])) & (fsm_output[6]);
  assign and_dcpl_340 = and_dcpl_339 & and_dcpl_285;
  assign and_dcpl_342 = and_243_cse & and_dcpl_282;
  assign and_dcpl_343 = and_dcpl_339 & and_dcpl_342;
  assign and_dcpl_345 = and_dcpl_259 & and_dcpl_268;
  assign and_dcpl_346 = and_dcpl_339 & and_dcpl_345;
  assign and_dcpl_349 = and_dcpl_339 & and_dcpl_306;
  assign and_dcpl_351 = and_dcpl_338 & (~ (fsm_output[8])) & (~ (fsm_output[6]));
  assign and_dcpl_352 = and_dcpl_351 & and_dcpl_342;
  assign and_dcpl_355 = and_dcpl_339 & and_dcpl_269;
  assign and_dcpl_357 = and_dcpl_339 & and_dcpl_283;
  assign and_dcpl_358 = and_dcpl_351 & and_dcpl_306;
  assign and_dcpl_360 = and_243_cse & and_dcpl_126;
  assign and_dcpl_361 = and_dcpl_339 & and_dcpl_360;
  assign and_dcpl_363 = and_dcpl_339 & and_dcpl_256 & and_dcpl_126;
  assign and_dcpl_364 = and_dcpl_351 & and_dcpl_360;
  assign and_dcpl_365 = and_dcpl_351 & and_dcpl_345;
  assign and_dcpl_366 = and_dcpl_351 & and_dcpl_285;
  assign and_dcpl_367 = and_dcpl_351 & and_dcpl_269;
  assign and_dcpl_368 = and_dcpl_351 & and_dcpl_283;
  assign and_dcpl_371 = and_dcpl_351 & and_dcpl_259 & (~ (fsm_output[7])) & (fsm_output[3]);
  assign and_dcpl_377 = nor_56_cse & (fsm_output[2]);
  assign and_dcpl_378 = and_dcpl_377 & (~ (fsm_output[8])) & (~ (fsm_output[6]));
  assign and_dcpl_384 = and_dcpl_377 & (~ (fsm_output[8])) & (fsm_output[6]);
  assign and_dcpl_386 = and_dcpl_259 & and_dcpl_126;
  assign and_dcpl_400 = (fsm_output[2:0]==3'b101);
  assign and_dcpl_401 = and_dcpl_400 & and_dcpl_32;
  assign and_dcpl_402 = and_dcpl_401 & and_dcpl_283;
  assign and_dcpl_406 = and_dcpl_401 & and_dcpl_386;
  assign and_dcpl_408 = and_dcpl_400 & and_dcpl_67;
  assign and_dcpl_409 = and_dcpl_408 & and_dcpl_386;
  assign and_dcpl_411 = and_dcpl_401 & and_dcpl_285;
  assign and_dcpl_412 = and_dcpl_408 & and_dcpl_285;
  assign and_dcpl_415 = and_dcpl_401 & and_dcpl_291;
  assign and_dcpl_418 = and_dcpl_401 & and_dcpl_360;
  assign and_dcpl_419 = and_dcpl_408 & and_dcpl_291;
  assign and_dcpl_420 = and_dcpl_408 & and_dcpl_360;
  assign and_dcpl_422 = and_dcpl_401 & and_dcpl_306;
  assign and_dcpl_424 = and_dcpl_401 & and_dcpl_342;
  assign and_dcpl_425 = and_dcpl_408 & and_dcpl_306;
  assign and_dcpl_426 = and_dcpl_408 & and_dcpl_342;
  assign and_dcpl_428 = and_dcpl_408 & and_dcpl_246;
  assign and_dcpl_429 = and_dcpl_408 & and_dcpl_283;
  assign and_dcpl_430 = (fsm_output[8]) & (~ (fsm_output[6]));
  assign and_dcpl_434 = and_dcpl_338 & and_dcpl_430 & and_dcpl_246;
  assign and_dcpl_436 = and_243_cse & and_dcpl_268;
  assign and_dcpl_437 = and_dcpl_338 & and_dcpl_67;
  assign and_dcpl_438 = and_dcpl_437 & and_dcpl_436;
  assign and_dcpl_440 = and_dcpl_437 & and_dcpl_271;
  assign and_dcpl_441 = and_dcpl_338 & and_dcpl_32;
  assign and_dcpl_442 = and_dcpl_441 & and_dcpl_436;
  assign and_dcpl_443 = and_dcpl_441 & and_dcpl_271;
  assign and_dcpl_446 = and_dcpl_437 & and_dcpl_262;
  assign and_dcpl_447 = and_dcpl_441 & and_dcpl_262;
  assign and_dcpl_449 = and_dcpl_437 & and_dcpl_257;
  assign and_dcpl_450 = and_dcpl_441 & and_dcpl_257;
  assign and_dcpl_452 = and_dcpl_400 & and_dcpl_430 & and_dcpl_246;
  assign and_dcpl_459 = and_dcpl_400 & (~ (fsm_output[8])) & (fsm_output[6]);
  assign and_dcpl_462 = and_dcpl_71 & (fsm_output[7]) & (~ (fsm_output[3]));
  assign and_dcpl_465 = and_dcpl_400 & (~ (fsm_output[8])) & (~ (fsm_output[6]))
      & and_dcpl_462;
  assign and_dcpl_473 = and_dcpl_400 & (~ (fsm_output[8])) & (~ (fsm_output[6]));
  assign and_dcpl_561 = and_dcpl_71 & (~ (fsm_output[7])) & (~ (fsm_output[3]));
  assign and_628_cse = or_30_cse & (~ (fsm_output[0])) & (fsm_output[1]) & (fsm_output[2])
      & (~ (fsm_output[8]));
  assign COMP_LOOP_twiddle_f_or_ssc = and_dcpl_255 | and_dcpl_258 | and_dcpl_261
      | and_dcpl_263 | and_dcpl_264 | and_dcpl_265 | and_dcpl_266 | and_dcpl_267
      | and_dcpl_270 | and_dcpl_272 | and_dcpl_274 | and_dcpl_275 | and_dcpl_276
      | and_dcpl_278;
  assign and_620_cse = and_dcpl_459 & and_dcpl_462;
  assign or_tmp_89 = (fsm_output[2]) | (fsm_output[5]) | (~ (fsm_output[6]));
  assign COMP_LOOP_twiddle_f_nor_1_itm = ~(and_dcpl_244 | and_dcpl_279 | and_dcpl_281
      | and_dcpl_284 | and_dcpl_286 | and_dcpl_287 | and_dcpl_288);
  assign COMP_LOOP_twiddle_f_or_21_itm = and_dcpl_279 | and_dcpl_281 | and_dcpl_284
      | and_dcpl_286 | and_dcpl_287 | and_dcpl_288;
  assign COMP_LOOP_twiddle_f_nor_7_itm = ~(and_dcpl_296 | and_dcpl_299 | and_dcpl_302
      | and_dcpl_305 | and_dcpl_307 | and_dcpl_308);
  assign COMP_LOOP_twiddle_f_or_15_itm = and_dcpl_311 | and_dcpl_314;
  assign COMP_LOOP_twiddle_f_nor_8_itm = ~(and_dcpl_299 | and_dcpl_302);
  assign COMP_LOOP_twiddle_f_or_16_itm = and_dcpl_296 | and_dcpl_305 | and_dcpl_307
      | and_dcpl_308;
  assign COMP_LOOP_twiddle_f_or_17_itm = and_dcpl_299 | and_dcpl_302;
  assign VEC_LOOP_or_38_itm = and_dcpl_340 | and_dcpl_343 | and_dcpl_346 | and_dcpl_349
      | and_dcpl_352 | and_dcpl_355 | and_dcpl_357 | and_dcpl_358 | and_dcpl_361
      | and_dcpl_363 | and_dcpl_364 | and_dcpl_365 | and_dcpl_366 | and_dcpl_367
      | and_dcpl_368 | and_dcpl_371;
  assign VEC_LOOP_or_29_itm = and_dcpl_406 | and_dcpl_409 | and_dcpl_411 | and_dcpl_412;
  assign VEC_LOOP_or_30_itm = and_dcpl_415 | and_dcpl_418 | and_dcpl_419 | and_dcpl_420
      | and_dcpl_422 | and_dcpl_424 | and_dcpl_425 | and_dcpl_426;
  assign VEC_LOOP_or_40_itm = and_dcpl_440 | and_dcpl_443 | and_dcpl_449 | and_dcpl_450;
  assign VEC_LOOP_or_46_itm = and_dcpl_406 | and_dcpl_409 | and_dcpl_411 | and_dcpl_412
      | and_dcpl_440 | and_dcpl_443 | and_dcpl_449 | and_dcpl_450;
  assign VEC_LOOP_or_48_itm = and_dcpl_428 | and_dcpl_429 | and_dcpl_442 | and_dcpl_447;
  assign VEC_LOOP_or_49_itm = and_dcpl_402 | and_dcpl_446;
  assign VEC_LOOP_nor_12_seb = ~(and_dcpl_434 | and_dcpl_452);
  assign and_524_itm = and_dcpl_473 & and_dcpl_257;
  assign and_527_itm = and_dcpl_473 & and_dcpl_260;
  assign and_530_itm = and_dcpl_473 & and_dcpl_262;
  assign and_533_itm = and_dcpl_459 & and_dcpl_253;
  assign and_534_itm = and_dcpl_459 & and_dcpl_257;
  assign and_535_itm = and_dcpl_459 & and_dcpl_260;
  assign and_536_itm = and_dcpl_459 & and_dcpl_262;
  assign and_539_itm = and_dcpl_473 & and_dcpl_269;
  assign and_541_itm = and_dcpl_473 & and_dcpl_271;
  assign and_543_itm = and_dcpl_473 & and_dcpl_345;
  assign and_545_itm = and_dcpl_473 & and_dcpl_436;
  assign and_546_itm = and_dcpl_459 & and_dcpl_269;
  assign and_547_itm = and_dcpl_459 & and_dcpl_271;
  assign and_548_itm = and_dcpl_459 & and_dcpl_345;
  assign and_521_itm = and_dcpl_473 & and_dcpl_253;
  assign and_549_itm = and_dcpl_459 & and_dcpl_436;
  assign VEC_LOOP_or_63_itm = (and_dcpl_459 & and_dcpl_561) | and_620_cse;
  always @(posedge clk) begin
    if ( rst ) begin
      reg_run_rsci_oswt_cse <= 1'b0;
      reg_vec_rsci_oswt_cse <= 1'b0;
      reg_vec_rsci_oswt_1_cse <= 1'b0;
      reg_twiddle_rsci_oswt_cse <= 1'b0;
      reg_complete_rsci_oswt_cse <= 1'b0;
      reg_vec_rsc_triosy_obj_iswt0_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      reg_ensig_cgo_1_cse <= 1'b0;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= ~((fsm_output[8]) | (fsm_output[6]) | (fsm_output[5])
          | or_dcpl_152 | (fsm_output[3:0]!=4'b0000));
      reg_vec_rsci_oswt_cse <= ~ mux_62_itm;
      reg_vec_rsci_oswt_1_cse <= and_31_rmff;
      reg_twiddle_rsci_oswt_cse <= and_138_rmff;
      reg_complete_rsci_oswt_cse <= and_dcpl_157 & and_dcpl_29 & (fsm_output[3:2]==2'b01)
          & (~ (z_out_6[4]));
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_157 & and_dcpl_39 & and_dcpl_28;
      reg_ensig_cgo_cse <= ~ mux_74_itm;
      reg_ensig_cgo_1_cse <= and_167_rmff;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_34 & nor_56_cse & and_dcpl_142) | STAGE_LOOP_i_3_0_sva_mx0c1)
        ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b1010, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_57_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      run_ac_sync_tmp_dobj_sva <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (~((~ (fsm_output[8])) | (fsm_output[6]) |
        (fsm_output[5]) | or_dcpl_152 | or_265_cse | (fsm_output[3:2]!=2'b01))) )
        begin
      run_ac_sync_tmp_dobj_sva <= run_rsci_ivld_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_81 ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( mux_132_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_10_5_sva_4_0 <= MUX_v_5_2_2(5'b00000, (z_out_6[4:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_87_nl | (fsm_output[8])) ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_88_nl | (fsm_output[8]) | or_30_cse) ) begin
      COMP_LOOP_1_twiddle_f_acc_cse_sva <= COMP_LOOP_1_twiddle_f_acc_cse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_91_nl | (fsm_output[8])) ) begin
      COMP_LOOP_9_twiddle_f_lshift_ncse_sva <= z_out[6:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_97_nl | (fsm_output[8])) ) begin
      COMP_LOOP_17_twiddle_f_lshift_itm <= MUX1HOT_v_6_3_2(COMP_LOOP_17_twiddle_f_lshift_itm_1,
          (z_out_1[5:0]), (z_out_6[5:0]), {and_178_nl , and_189_nl , and_dcpl_87});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_101_nl | (fsm_output[8])) ) begin
      COMP_LOOP_twiddle_f_mul_cse_10_sva <= MUX_v_10_2_2(z_out_1, z_out_3, and_203_nl);
    end
  end
  always @(posedge clk) begin
    if ( (~ mux_140_nl) & (~ (fsm_output[8])) & complete_rsci_wen_comp ) begin
      COMP_LOOP_13_twiddle_f_mul_psp_sva_7 <= COMP_LOOP_twiddle_f_mux1h_40_rgt[7];
    end
  end
  always @(posedge clk) begin
    if ( mux_143_nl & nor_123_cse & complete_rsci_wen_comp ) begin
      reg_COMP_LOOP_13_twiddle_f_mul_psp_1_reg <= COMP_LOOP_twiddle_f_mux1h_40_rgt[6:5];
    end
  end
  always @(posedge clk) begin
    if ( mux_145_nl & nor_123_cse & complete_rsci_wen_comp ) begin
      reg_COMP_LOOP_13_twiddle_f_mul_psp_2_reg <= COMP_LOOP_twiddle_f_mux1h_40_rgt[4:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_115_nl | (fsm_output[8])) ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva <= COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_117_nl | (fsm_output[8])) ) begin
      COMP_LOOP_11_twiddle_f_mul_psp_sva <= MUX1HOT_v_9_3_2((z_out_1[8:0]), z_out_6,
          z_out_2_8_0, {COMP_LOOP_twiddle_f_or_1_nl , COMP_LOOP_twiddle_f_or_6_rgt
          , COMP_LOOP_twiddle_f_or_2_nl});
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_cse ) begin
      COMP_LOOP_twiddle_help_1_sva <= twiddle_h_rsci_qb_d_mxwt;
      COMP_LOOP_twiddle_f_1_sva <= twiddle_rsci_qb_d_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((xor_dcpl_1 & and_dcpl_182) | and_dcpl_220 | and_dcpl_44
        | and_dcpl_55 | and_dcpl_63 | and_dcpl_66 | and_dcpl_74 | and_dcpl_77 | and_dcpl_81
        | and_dcpl_84 | and_dcpl_89 | and_dcpl_93 | and_dcpl_96 | and_dcpl_99 | and_dcpl_102
        | and_dcpl_105 | and_dcpl_108 | and_dcpl_111) ) begin
      VEC_LOOP_acc_1_cse_10_sva <= MUX_v_10_2_2(10'b0000000000, VEC_LOOP_VEC_LOOP_mux_nl,
          not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_0_1_sva_1 <= 11'b00000000000;
    end
    else if ( complete_rsci_wen_comp & (~(or_tmp_46 | (fsm_output[2:1]!=2'b10)))
        ) begin
      VEC_LOOP_j_10_0_1_sva_1 <= z_out_4;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_35 | and_dcpl_44 | and_dcpl_49 | and_dcpl_55
        | and_dcpl_58 | and_dcpl_63 | and_dcpl_65 | and_dcpl_66 | and_dcpl_70 | and_dcpl_74
        | and_dcpl_76 | and_dcpl_77 | and_dcpl_80 | and_dcpl_81 | and_dcpl_83 | and_dcpl_84
        | and_dcpl_87 | and_dcpl_89 | and_dcpl_92 | and_dcpl_93 | and_dcpl_95 | and_dcpl_96
        | and_dcpl_98 | and_dcpl_99 | and_dcpl_101 | and_dcpl_102 | and_dcpl_104
        | and_dcpl_105 | and_dcpl_107 | and_dcpl_108 | and_dcpl_110 | and_dcpl_111)
        ) begin
      VEC_LOOP_acc_10_cse_1_sva <= MUX1HOT_v_10_29_2(z_out_10, VEC_LOOP_acc_10_cse_2_sva_mx0w1,
          VEC_LOOP_acc_10_cse_3_sva_mx0w2, VEC_LOOP_acc_10_cse_4_sva_mx0w3, VEC_LOOP_acc_10_cse_5_sva_mx0w4,
          VEC_LOOP_acc_10_cse_6_sva_mx0w5, VEC_LOOP_acc_10_cse_7_sva_mx0w6, VEC_LOOP_acc_10_cse_8_sva_mx0w7,
          VEC_LOOP_acc_10_cse_10_sva_mx0w9, VEC_LOOP_acc_10_cse_11_sva_mx0w10, VEC_LOOP_acc_10_cse_12_sva_mx0w11,
          VEC_LOOP_acc_10_cse_13_sva_mx0w12, VEC_LOOP_acc_10_cse_14_sva_mx0w13, VEC_LOOP_acc_10_cse_15_sva_mx0w14,
          VEC_LOOP_acc_10_cse_16_sva_mx0w15, VEC_LOOP_acc_10_cse_18_sva_mx0w17, VEC_LOOP_acc_10_cse_19_sva_mx0w18,
          VEC_LOOP_acc_10_cse_20_sva_mx0w19, VEC_LOOP_acc_10_cse_21_sva_mx0w20, VEC_LOOP_acc_10_cse_22_sva_mx0w21,
          VEC_LOOP_acc_10_cse_23_sva_mx0w22, VEC_LOOP_acc_10_cse_24_sva_mx0w23, VEC_LOOP_acc_10_cse_26_sva_mx0w25,
          VEC_LOOP_acc_10_cse_27_sva_mx0w26, VEC_LOOP_acc_10_cse_28_sva_mx0w27, VEC_LOOP_acc_10_cse_29_sva_mx0w28,
          VEC_LOOP_acc_10_cse_30_sva_mx0w29, VEC_LOOP_acc_10_cse_31_sva_mx0w30, VEC_LOOP_acc_10_cse_sva_mx0w31,
          {VEC_LOOP_or_19_nl , and_dcpl_44 , and_dcpl_49 , and_dcpl_55 , and_dcpl_58
          , and_dcpl_63 , and_dcpl_65 , and_dcpl_66 , and_dcpl_74 , and_dcpl_76 ,
          and_dcpl_77 , and_dcpl_80 , and_dcpl_81 , and_dcpl_83 , and_dcpl_84 , and_dcpl_89
          , and_dcpl_92 , and_dcpl_93 , and_dcpl_95 , and_dcpl_96 , and_dcpl_98 ,
          and_dcpl_99 , and_dcpl_102 , and_dcpl_104 , and_dcpl_105 , and_dcpl_107
          , and_dcpl_108 , and_dcpl_110 , and_dcpl_111});
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_125_nl | (fsm_output[8])) ) begin
      COMP_LOOP_5_twiddle_f_lshift_ncse_sva <= COMP_LOOP_5_twiddle_f_lshift_itm;
    end
  end
  assign or_232_nl = (fsm_output[1:0]!=2'b00);
  assign mux_76_nl = MUX_s_1_2_2(mux_52_cse, and_cse, or_232_nl);
  assign and_253_nl = ((fsm_output[1]) | (fsm_output[7]) | (fsm_output[6]) | (fsm_output[4])
      | (fsm_output[5])) & (fsm_output[8]);
  assign mux_56_nl = MUX_s_1_2_2(mux_76_nl, and_253_nl, fsm_output[2]);
  assign mux_57_nl = MUX_s_1_2_2(mux_56_nl, (fsm_output[8]), fsm_output[3]);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_81;
  assign mux_129_nl = MUX_s_1_2_2((~ or_30_cse), or_30_cse, fsm_output[8]);
  assign mux_130_nl = MUX_s_1_2_2(mux_129_nl, (fsm_output[8]), fsm_output[2]);
  assign mux_nl = MUX_s_1_2_2(and_cse, (fsm_output[8]), fsm_output[2]);
  assign mux_131_nl = MUX_s_1_2_2(mux_130_nl, mux_nl, fsm_output[1]);
  assign mux_132_nl = MUX_s_1_2_2(mux_131_nl, (fsm_output[8]), fsm_output[3]);
  assign mux_85_nl = MUX_s_1_2_2(mux_tmp_84, and_258_cse, and_268_cse);
  assign mux_86_nl = MUX_s_1_2_2(mux_85_nl, and_258_cse, fsm_output[2]);
  assign mux_83_nl = MUX_s_1_2_2(and_258_cse, and_267_cse, fsm_output[2]);
  assign mux_87_nl = MUX_s_1_2_2(mux_86_nl, mux_83_nl, fsm_output[3]);
  assign nor_48_nl = ~((fsm_output[2]) | and_268_cse);
  assign mux_88_nl = MUX_s_1_2_2(nor_48_nl, (fsm_output[2]), fsm_output[3]);
  assign mux_89_nl = MUX_s_1_2_2(and_dcpl_128, (fsm_output[6]), fsm_output[7]);
  assign and_241_nl = (fsm_output[7:6]==2'b11);
  assign mux_90_nl = MUX_s_1_2_2(mux_89_nl, and_241_nl, and_268_cse);
  assign and_183_nl = (fsm_output[7]) & (and_243_cse | (fsm_output[6]));
  assign mux_91_nl = MUX_s_1_2_2(mux_90_nl, and_183_nl, or_244_cse);
  assign and_178_nl = and_dcpl_34 & and_dcpl_39 & and_dcpl_142;
  assign and_189_nl = and_dcpl_82 & and_dcpl_182 & (~ (fsm_output[3])) & (VEC_LOOP_j_10_0_1_sva_1[10]);
  assign mux_93_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[2]);
  assign nor_47_nl = ~((fsm_output[0]) | (fsm_output[7]));
  assign and_239_nl = (fsm_output[0]) & (fsm_output[7]);
  assign mux_92_nl = MUX_s_1_2_2(nor_47_nl, and_239_nl, fsm_output[2]);
  assign mux_94_nl = MUX_s_1_2_2(mux_93_nl, mux_92_nl, fsm_output[1]);
  assign mux_95_nl = MUX_s_1_2_2(mux_94_nl, (fsm_output[7]), or_247_cse);
  assign or_246_nl = ((fsm_output[5]) & (fsm_output[6]) & (fsm_output[1]) & (~ (fsm_output[2]))
      & (VEC_LOOP_j_10_0_1_sva_1[10]) & (fsm_output[0])) | (fsm_output[7]);
  assign mux_96_nl = MUX_s_1_2_2(mux_95_nl, or_246_nl, fsm_output[4]);
  assign mux_97_nl = MUX_s_1_2_2(mux_96_nl, (fsm_output[7]), fsm_output[3]);
  assign and_203_nl = and_dcpl_94 & and_dcpl_182 & (fsm_output[3]) & (VEC_LOOP_j_10_0_1_sva_1[10]);
  assign and_236_nl = (fsm_output[2]) & (fsm_output[7]) & (fsm_output[4]) & (fsm_output[5])
      & (fsm_output[6]);
  assign mux_100_nl = MUX_s_1_2_2(not_tmp_93, and_236_nl, fsm_output[3]);
  assign and_237_nl = (fsm_output[1:0]==2'b11) & (~ and_258_cse);
  assign mux_98_nl = MUX_s_1_2_2(and_237_nl, and_258_cse, fsm_output[2]);
  assign mux_99_nl = MUX_s_1_2_2(not_tmp_93, mux_98_nl, fsm_output[3]);
  assign mux_101_nl = MUX_s_1_2_2(mux_100_nl, mux_99_nl, VEC_LOOP_j_10_0_1_sva_1[10]);
  assign or_289_nl = (fsm_output[5]) | (~((fsm_output[7:6]!=2'b10)));
  assign mux_137_nl = MUX_s_1_2_2(or_tmp_89, or_289_nl, fsm_output[1]);
  assign mux_135_nl = MUX_s_1_2_2(or_299_cse, nor_129_cse, fsm_output[2]);
  assign mux_136_nl = MUX_s_1_2_2(mux_135_nl, or_tmp_89, fsm_output[1]);
  assign mux_138_nl = MUX_s_1_2_2(mux_137_nl, mux_136_nl, fsm_output[0]);
  assign or_283_nl = (~ (fsm_output[2])) | (~ (fsm_output[5])) | (fsm_output[6]);
  assign mux_133_nl = MUX_s_1_2_2(and_650_cse, or_282_cse, fsm_output[2]);
  assign mux_134_nl = MUX_s_1_2_2(or_283_nl, mux_133_nl, and_268_cse);
  assign mux_139_nl = MUX_s_1_2_2(mux_138_nl, mux_134_nl, fsm_output[4]);
  assign mux_140_nl = MUX_s_1_2_2(mux_139_nl, or_281_cse, fsm_output[3]);
  assign nor_120_nl = ~((~ (fsm_output[0])) | (fsm_output[4]) | nor_129_cse);
  assign nor_122_nl = ~((fsm_output[0]) | (fsm_output[4]) | (fsm_output[7]) | (fsm_output[6])
      | (fsm_output[5]));
  assign mux_141_nl = MUX_s_1_2_2(nor_120_nl, nor_122_nl, fsm_output[1]);
  assign mux_143_nl = MUX_s_1_2_2(and_646_cse, mux_141_nl, fsm_output[2]);
  assign nor_125_nl = ~((fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[4]) |
      nor_129_cse);
  assign mux_145_nl = MUX_s_1_2_2(and_646_cse, nor_125_nl, fsm_output[2]);
  assign mux_115_nl = MUX_s_1_2_2(mux_tmp_84, and_267_cse, or_244_cse);
  assign COMP_LOOP_twiddle_f_or_1_nl = and_dcpl_151 | (and_dcpl_79 & and_dcpl_143)
      | and_dcpl_149 | (and_dcpl_94 & and_dcpl_143) | (and_dcpl_100 & and_dcpl_143)
      | (and_dcpl_106 & and_dcpl_143);
  assign COMP_LOOP_twiddle_f_or_2_nl = (and_dcpl_57 & and_dcpl_143) | (and_dcpl_69
      & and_dcpl_143);
  assign and_234_nl = or_265_cse & (fsm_output[4]);
  assign mux_116_nl = MUX_s_1_2_2((~ (fsm_output[4])), and_234_nl, fsm_output[2]);
  assign mux_117_nl = MUX_s_1_2_2(mux_116_nl, (fsm_output[4]), fsm_output[3]);
  assign VEC_LOOP_or_nl = and_dcpl_44 | and_dcpl_55 | and_dcpl_63 | and_dcpl_66 |
      and_dcpl_74 | and_dcpl_77 | and_dcpl_81 | and_dcpl_84 | and_dcpl_89 | and_dcpl_93
      | and_dcpl_96 | and_dcpl_99 | and_dcpl_102 | and_dcpl_105 | and_dcpl_108 |
      and_dcpl_111;
  assign VEC_LOOP_VEC_LOOP_mux_nl = MUX_v_10_2_2((VEC_LOOP_j_10_0_1_sva_1[9:0]),
      z_out_8, VEC_LOOP_or_nl);
  assign not_nl = ~ and_dcpl_220;
  assign VEC_LOOP_or_19_nl = and_dcpl_35 | and_dcpl_70 | and_dcpl_87 | and_dcpl_101;
  assign mux_123_nl = MUX_s_1_2_2(and_dcpl_128, and_650_cse, fsm_output[7]);
  assign mux_124_nl = MUX_s_1_2_2(mux_123_nl, mux_tmp_121, fsm_output[2]);
  assign and_227_nl = (fsm_output[7]) & and_8_cse;
  assign mux_122_nl = MUX_s_1_2_2(mux_tmp_121, and_227_nl, fsm_output[2]);
  assign mux_125_nl = MUX_s_1_2_2(mux_124_nl, mux_122_nl, fsm_output[3]);
  assign COMP_LOOP_twiddle_f_mux_15_nl = MUX_s_1_2_2((COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1[9]),
      (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[9]), COMP_LOOP_twiddle_f_or_ssc);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_9_nl = COMP_LOOP_twiddle_f_mux_15_nl
      & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_or_28_nl = and_dcpl_281 | and_dcpl_284 | and_dcpl_286
      | and_dcpl_287 | and_dcpl_288;
  assign COMP_LOOP_twiddle_f_mux1h_103_nl = MUX1HOT_v_9_5_2(({3'b000 , COMP_LOOP_17_twiddle_f_lshift_itm}),
      (COMP_LOOP_2_twiddle_f_lshift_ncse_sva_1[8:0]), (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[8:0]),
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva_1, COMP_LOOP_3_twiddle_f_lshift_ncse_sva,
      {and_dcpl_244 , and_dcpl_251 , COMP_LOOP_twiddle_f_or_ssc , and_dcpl_279 ,
      COMP_LOOP_twiddle_f_or_28_nl});
  assign COMP_LOOP_twiddle_f_and_19_nl = (COMP_LOOP_k_10_5_sva_4_0[4]) & COMP_LOOP_twiddle_f_nor_1_itm;
  assign COMP_LOOP_twiddle_f_or_29_nl = and_dcpl_251 | and_dcpl_255 | and_dcpl_258
      | and_dcpl_261 | and_dcpl_263 | and_dcpl_264 | and_dcpl_265 | and_dcpl_266
      | and_dcpl_267 | and_dcpl_270 | and_dcpl_272 | and_dcpl_274 | and_dcpl_275
      | and_dcpl_276 | and_dcpl_278;
  assign COMP_LOOP_twiddle_f_mux1h_104_nl = MUX1HOT_v_4_3_2(({3'b000 , (COMP_LOOP_k_10_5_sva_4_0[4])}),
      (COMP_LOOP_k_10_5_sva_4_0[3:0]), (COMP_LOOP_k_10_5_sva_4_0[4:1]), {and_dcpl_244
      , COMP_LOOP_twiddle_f_or_29_nl , COMP_LOOP_twiddle_f_or_21_itm});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl = MUX_s_1_2_2((COMP_LOOP_k_10_5_sva_4_0[3]),
      (COMP_LOOP_k_10_5_sva_4_0[0]), COMP_LOOP_twiddle_f_or_21_itm);
  assign COMP_LOOP_twiddle_f_or_30_nl = (COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl
      & (~(and_dcpl_251 | and_dcpl_255 | and_dcpl_258 | and_dcpl_261 | and_dcpl_263
      | and_dcpl_264 | and_dcpl_265 | and_dcpl_266))) | and_dcpl_267 | and_dcpl_270
      | and_dcpl_272 | and_dcpl_274 | and_dcpl_275 | and_dcpl_276 | and_dcpl_278;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl = ((COMP_LOOP_k_10_5_sva_4_0[2])
      & (~(and_dcpl_251 | and_dcpl_255 | and_dcpl_258 | and_dcpl_261 | and_dcpl_267
      | and_dcpl_270 | and_dcpl_272 | and_dcpl_279 | and_dcpl_281))) | and_dcpl_263
      | and_dcpl_264 | and_dcpl_265 | and_dcpl_266 | and_dcpl_274 | and_dcpl_275
      | and_dcpl_276 | and_dcpl_278 | and_dcpl_284 | and_dcpl_286 | and_dcpl_287
      | and_dcpl_288;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_6_nl = ((COMP_LOOP_k_10_5_sva_4_0[1])
      & (~(and_dcpl_251 | and_dcpl_255 | and_dcpl_263 | and_dcpl_264 | and_dcpl_267
      | and_dcpl_270 | and_dcpl_274 | and_dcpl_275 | and_dcpl_279 | and_dcpl_284
      | and_dcpl_286))) | and_dcpl_258 | and_dcpl_261 | and_dcpl_265 | and_dcpl_266
      | and_dcpl_272 | and_dcpl_276 | and_dcpl_278 | and_dcpl_281 | and_dcpl_287
      | and_dcpl_288;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_7_nl = ((COMP_LOOP_k_10_5_sva_4_0[0])
      & (~(and_dcpl_251 | and_dcpl_258 | and_dcpl_263 | and_dcpl_265 | and_dcpl_267
      | and_dcpl_272 | and_dcpl_274 | and_dcpl_276 | and_dcpl_279 | and_dcpl_284
      | and_dcpl_287))) | and_dcpl_255 | and_dcpl_261 | and_dcpl_264 | and_dcpl_266
      | and_dcpl_270 | and_dcpl_275 | and_dcpl_278 | and_dcpl_281 | and_dcpl_286
      | and_dcpl_288;
  assign nl_z_out_1 = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_9_nl , COMP_LOOP_twiddle_f_mux1h_103_nl})
      * ({COMP_LOOP_twiddle_f_and_19_nl , COMP_LOOP_twiddle_f_mux1h_104_nl , COMP_LOOP_twiddle_f_or_30_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_5_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_6_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_7_nl , 1'b1});
  assign z_out_1 = nl_z_out_1[9:0];
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_10_nl = (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[8])
      & COMP_LOOP_twiddle_f_nor_7_itm;
  assign COMP_LOOP_twiddle_f_mux_16_nl = MUX_s_1_2_2((COMP_LOOP_5_twiddle_f_lshift_ncse_sva[7]),
      (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[7]), COMP_LOOP_twiddle_f_or_15_itm);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_11_nl = COMP_LOOP_twiddle_f_mux_16_nl
      & COMP_LOOP_twiddle_f_nor_8_itm;
  assign COMP_LOOP_twiddle_f_mux1h_105_nl = MUX1HOT_v_7_3_2((COMP_LOOP_5_twiddle_f_lshift_ncse_sva[6:0]),
      COMP_LOOP_9_twiddle_f_lshift_ncse_sva, (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[6:0]),
      {COMP_LOOP_twiddle_f_or_16_itm , COMP_LOOP_twiddle_f_or_17_itm , COMP_LOOP_twiddle_f_or_15_itm});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_12_nl = (COMP_LOOP_k_10_5_sva_4_0[4])
      & COMP_LOOP_twiddle_f_nor_7_itm;
  assign COMP_LOOP_twiddle_f_mux_17_nl = MUX_s_1_2_2((COMP_LOOP_k_10_5_sva_4_0[4]),
      (COMP_LOOP_k_10_5_sva_4_0[3]), COMP_LOOP_twiddle_f_or_15_itm);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_13_nl = COMP_LOOP_twiddle_f_mux_17_nl
      & COMP_LOOP_twiddle_f_nor_8_itm;
  assign COMP_LOOP_twiddle_f_mux1h_106_nl = MUX1HOT_v_3_3_2((COMP_LOOP_k_10_5_sva_4_0[3:1]),
      (COMP_LOOP_k_10_5_sva_4_0[4:2]), (COMP_LOOP_k_10_5_sva_4_0[2:0]), {COMP_LOOP_twiddle_f_or_16_itm
      , COMP_LOOP_twiddle_f_or_17_itm , COMP_LOOP_twiddle_f_or_15_itm});
  assign COMP_LOOP_twiddle_f_mux_18_nl = MUX_s_1_2_2((COMP_LOOP_k_10_5_sva_4_0[0]),
      (COMP_LOOP_k_10_5_sva_4_0[1]), COMP_LOOP_twiddle_f_or_17_itm);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_14_nl = COMP_LOOP_twiddle_f_mux_18_nl
      & (~(and_dcpl_311 | and_dcpl_314));
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_8_nl = ((COMP_LOOP_k_10_5_sva_4_0[0])
      & (~(and_dcpl_296 | and_dcpl_305 | and_dcpl_311))) | and_dcpl_307 | and_dcpl_308
      | and_dcpl_314;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_9_nl = (~(and_dcpl_296 | and_dcpl_299
      | and_dcpl_307 | and_dcpl_314)) | and_dcpl_302 | and_dcpl_305 | and_dcpl_308
      | and_dcpl_311;
  assign nl_z_out_2_8_0 = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_10_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_11_nl
      , COMP_LOOP_twiddle_f_mux1h_105_nl}) * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_12_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_13_nl , COMP_LOOP_twiddle_f_mux1h_106_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_14_nl , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_8_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_9_nl , 1'b1});
  assign z_out_2_8_0 = nl_z_out_2_8_0[8:0];
  assign COMP_LOOP_twiddle_f_mux_19_nl = MUX_v_10_2_2(COMP_LOOP_2_twiddle_f_lshift_ncse_sva,
      ({5'b00000 , COMP_LOOP_1_twiddle_f_lshift_itm}), and_dcpl_329);
  assign not_517_nl = ~ and_dcpl_329;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_15_nl = MUX_v_5_2_2(5'b00000,
      COMP_LOOP_k_10_5_sva_4_0, not_517_nl);
  assign COMP_LOOP_twiddle_f_mux_20_nl = MUX_v_5_2_2(5'b10111, COMP_LOOP_k_10_5_sva_4_0,
      and_dcpl_329);
  assign nl_z_out_3 = COMP_LOOP_twiddle_f_mux_19_nl * ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_15_nl
      , COMP_LOOP_twiddle_f_mux_20_nl});
  assign z_out_3 = nl_z_out_3[9:0];
  assign VEC_LOOP_VEC_LOOP_or_9_nl = (STAGE_LOOP_lshift_psp_sva[10]) | and_dcpl_340
      | and_dcpl_343 | and_dcpl_346 | and_dcpl_349 | and_dcpl_352 | and_dcpl_355
      | and_dcpl_357 | and_dcpl_358 | and_dcpl_361 | and_dcpl_363 | and_dcpl_364
      | and_dcpl_365 | and_dcpl_366 | and_dcpl_367 | and_dcpl_368 | and_dcpl_371;
  assign VEC_LOOP_VEC_LOOP_mux_8_nl = MUX_v_10_2_2((STAGE_LOOP_lshift_psp_sva[9:0]),
      (~ (STAGE_LOOP_lshift_psp_sva[10:1])), VEC_LOOP_or_38_itm);
  assign VEC_LOOP_or_65_nl = (~((~ (fsm_output[1])) & (fsm_output[0]) & (fsm_output[2])
      & (~ (fsm_output[8])))) | and_dcpl_340 | and_dcpl_343 | and_dcpl_346 | and_dcpl_349
      | and_dcpl_352 | and_dcpl_355 | and_dcpl_357 | and_dcpl_358 | and_dcpl_361
      | and_dcpl_363 | and_dcpl_364 | and_dcpl_365 | and_dcpl_366 | and_dcpl_367
      | and_dcpl_368 | and_dcpl_371;
  assign VEC_LOOP_VEC_LOOP_mux_9_nl = MUX_v_5_2_2((VEC_LOOP_acc_1_cse_10_sva[9:5]),
      COMP_LOOP_k_10_5_sva_4_0, VEC_LOOP_or_38_itm);
  assign VEC_LOOP_VEC_LOOP_or_10_nl = ((VEC_LOOP_acc_1_cse_10_sva[4]) & (~(and_dcpl_361
      | and_dcpl_363 | and_dcpl_364 | and_dcpl_371))) | and_dcpl_340 | and_dcpl_343
      | and_dcpl_346 | and_dcpl_349 | and_dcpl_352 | and_dcpl_355 | and_dcpl_357
      | and_dcpl_358 | and_dcpl_365 | and_dcpl_366 | and_dcpl_367 | and_dcpl_368;
  assign VEC_LOOP_VEC_LOOP_or_11_nl = ((VEC_LOOP_acc_1_cse_10_sva[3]) & (~(and_dcpl_352
      | and_dcpl_358 | and_dcpl_364 | and_dcpl_365 | and_dcpl_366 | and_dcpl_367
      | and_dcpl_368 | and_dcpl_371))) | and_dcpl_340 | and_dcpl_343 | and_dcpl_346
      | and_dcpl_349 | and_dcpl_355 | and_dcpl_357 | and_dcpl_361 | and_dcpl_363;
  assign VEC_LOOP_VEC_LOOP_or_12_nl = ((VEC_LOOP_acc_1_cse_10_sva[2]) & (~(and_dcpl_349
      | and_dcpl_355 | and_dcpl_357 | and_dcpl_358 | and_dcpl_363 | and_dcpl_367
      | and_dcpl_368))) | and_dcpl_340 | and_dcpl_343 | and_dcpl_346 | and_dcpl_352
      | and_dcpl_361 | and_dcpl_364 | and_dcpl_365 | and_dcpl_366 | and_dcpl_371;
  assign VEC_LOOP_VEC_LOOP_or_13_nl = ((VEC_LOOP_acc_1_cse_10_sva[1]) & (~(and_dcpl_340
      | and_dcpl_346 | and_dcpl_355 | and_dcpl_357 | and_dcpl_365 | and_dcpl_366
      | and_dcpl_367 | and_dcpl_368 | and_dcpl_371))) | and_dcpl_343 | and_dcpl_349
      | and_dcpl_352 | and_dcpl_358 | and_dcpl_361 | and_dcpl_363 | and_dcpl_364;
  assign VEC_LOOP_VEC_LOOP_or_14_nl = ((VEC_LOOP_acc_1_cse_10_sva[0]) & (~(and_dcpl_340
      | and_dcpl_343 | and_dcpl_349 | and_dcpl_352 | and_dcpl_357 | and_dcpl_358
      | and_dcpl_361 | and_dcpl_363 | and_dcpl_364 | and_dcpl_366 | and_dcpl_368)))
      | and_dcpl_346 | and_dcpl_355 | and_dcpl_365 | and_dcpl_367 | and_dcpl_371;
  assign nl_acc_nl = ({VEC_LOOP_VEC_LOOP_or_9_nl , VEC_LOOP_VEC_LOOP_mux_8_nl , VEC_LOOP_or_65_nl})
      + conv_u2u_11_12({VEC_LOOP_VEC_LOOP_mux_9_nl , VEC_LOOP_VEC_LOOP_or_10_nl ,
      VEC_LOOP_VEC_LOOP_or_11_nl , VEC_LOOP_VEC_LOOP_or_12_nl , VEC_LOOP_VEC_LOOP_or_13_nl
      , VEC_LOOP_VEC_LOOP_or_14_nl , 1'b1});
  assign acc_nl = nl_acc_nl[11:0];
  assign z_out_4 = readslicef_12_11_1(acc_nl);
  assign and_652_nl = and_dcpl_378 & (fsm_output[5:4]==2'b01) & and_dcpl_126;
  assign and_653_nl = and_dcpl_384 & and_dcpl_259 & and_dcpl_252;
  assign and_654_nl = and_dcpl_384 & and_dcpl_386;
  assign and_655_nl = and_dcpl_384 & and_dcpl_253;
  assign and_656_nl = and_dcpl_384 & and_dcpl_71 & and_dcpl_126;
  assign and_657_nl = and_dcpl_378 & and_dcpl_386;
  assign and_658_nl = and_dcpl_378 & and_dcpl_253;
  assign COMP_LOOP_mux1h_4_nl = MUX1HOT_v_4_7_2(4'b0010, 4'b1101, 4'b1100, 4'b1001,
      4'b1000, 4'b0100, 4'b0001, {and_652_nl , and_653_nl , and_654_nl , and_655_nl
      , and_656_nl , and_657_nl , and_658_nl});
  assign nl_acc_1_nl = ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:1])) , 1'b1}) +
      conv_u2u_11_12({COMP_LOOP_k_10_5_sva_4_0 , 1'b0 , COMP_LOOP_mux1h_4_nl , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[11:0];
  assign z_out_5_10 = readslicef_12_1_11(acc_1_nl);
  assign VEC_LOOP_VEC_LOOP_or_15_nl = ((VEC_LOOP_acc_1_cse_10_sva[9]) & (~(and_dcpl_402
      | and_dcpl_406 | and_dcpl_409 | and_dcpl_411 | and_dcpl_412 | and_dcpl_428
      | and_dcpl_429 | and_dcpl_434 | and_dcpl_438 | and_dcpl_442 | and_dcpl_446
      | and_dcpl_447 | and_dcpl_452))) | and_dcpl_440 | and_dcpl_443 | and_dcpl_449
      | and_dcpl_450;
  assign VEC_LOOP_mux1h_36_nl = MUX1HOT_s_1_3_2((VEC_LOOP_acc_1_cse_10_sva[9]), (VEC_LOOP_acc_1_cse_10_sva[8]),
      (~ (STAGE_LOOP_lshift_psp_sva[10])), {VEC_LOOP_or_29_itm , VEC_LOOP_or_30_itm
      , VEC_LOOP_or_40_itm});
  assign VEC_LOOP_or_66_nl = (VEC_LOOP_mux1h_36_nl & (~(and_dcpl_402 | and_dcpl_428
      | and_dcpl_429 | and_dcpl_434 | and_dcpl_438 | and_dcpl_446 | and_dcpl_452)))
      | and_dcpl_442 | and_dcpl_447;
  assign VEC_LOOP_or_67_nl = and_dcpl_428 | and_dcpl_429;
  assign VEC_LOOP_or_68_nl = and_dcpl_442 | and_dcpl_447;
  assign VEC_LOOP_mux1h_37_nl = MUX1HOT_v_7_10_2(({1'b0 , (VEC_LOOP_acc_1_cse_10_sva[9:4])}),
      (VEC_LOOP_acc_1_cse_10_sva[8:2]), (VEC_LOOP_acc_1_cse_10_sva[7:1]), (VEC_LOOP_acc_1_cse_10_sva[9:3]),
      ({2'b00 , COMP_LOOP_k_10_5_sva_4_0}), ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[10:6]))}),
      (~ (STAGE_LOOP_lshift_psp_sva[9:3])), (~ (STAGE_LOOP_lshift_psp_sva[10:4])),
      ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:5]))}), ({3'b001 , (~ STAGE_LOOP_i_3_0_sva_2)}),
      {and_dcpl_402 , VEC_LOOP_or_29_itm , VEC_LOOP_or_30_itm , VEC_LOOP_or_67_nl
      , and_dcpl_434 , and_dcpl_438 , VEC_LOOP_or_40_itm , VEC_LOOP_or_68_nl , and_dcpl_446
      , and_dcpl_452});
  assign VEC_LOOP_or_69_nl = (~(and_dcpl_402 | and_dcpl_406 | and_dcpl_409 | and_dcpl_411
      | and_dcpl_412 | and_dcpl_415 | and_dcpl_418 | and_dcpl_419 | and_dcpl_420
      | and_dcpl_422 | and_dcpl_424 | and_dcpl_425 | and_dcpl_426 | and_dcpl_428
      | and_dcpl_429 | and_dcpl_434 | and_dcpl_452)) | and_dcpl_438 | and_dcpl_440
      | and_dcpl_442 | and_dcpl_443 | and_dcpl_446 | and_dcpl_447 | and_dcpl_449
      | and_dcpl_450;
  assign VEC_LOOP_and_27_nl = (COMP_LOOP_k_10_5_sva_4_0[4]) & (~(and_dcpl_402 | and_dcpl_406
      | and_dcpl_409 | and_dcpl_411 | and_dcpl_412 | and_dcpl_428 | and_dcpl_429
      | and_dcpl_434 | and_dcpl_438 | and_dcpl_440 | and_dcpl_442 | and_dcpl_443
      | and_dcpl_446 | and_dcpl_447 | and_dcpl_449 | and_dcpl_450 | and_dcpl_452));
  assign VEC_LOOP_VEC_LOOP_mux_10_nl = MUX_s_1_2_2((COMP_LOOP_k_10_5_sva_4_0[4]),
      (COMP_LOOP_k_10_5_sva_4_0[3]), VEC_LOOP_or_30_itm);
  assign VEC_LOOP_and_28_nl = VEC_LOOP_VEC_LOOP_mux_10_nl & (~(and_dcpl_402 | and_dcpl_428
      | and_dcpl_429 | and_dcpl_434 | and_dcpl_438 | and_dcpl_442 | and_dcpl_446
      | and_dcpl_447 | and_dcpl_452));
  assign VEC_LOOP_mux1h_38_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_10_5_sva_4_0[3]), (COMP_LOOP_k_10_5_sva_4_0[2]),
      (COMP_LOOP_k_10_5_sva_4_0[4]), {VEC_LOOP_or_46_itm , VEC_LOOP_or_30_itm , VEC_LOOP_or_48_itm});
  assign VEC_LOOP_and_29_nl = VEC_LOOP_mux1h_38_nl & (~(and_dcpl_402 | and_dcpl_434
      | and_dcpl_438 | and_dcpl_446 | and_dcpl_452));
  assign VEC_LOOP_mux1h_39_nl = MUX1HOT_v_2_5_2((COMP_LOOP_k_10_5_sva_4_0[4:3]),
      (COMP_LOOP_k_10_5_sva_4_0[2:1]), (COMP_LOOP_k_10_5_sva_4_0[1:0]), (COMP_LOOP_k_10_5_sva_4_0[3:2]),
      ({1'b0 , (COMP_LOOP_k_10_5_sva_4_0[4])}), {VEC_LOOP_or_49_itm , VEC_LOOP_or_46_itm
      , VEC_LOOP_or_30_itm , VEC_LOOP_or_48_itm , and_dcpl_438});
  assign VEC_LOOP_and_30_nl = MUX_v_2_2_2(2'b00, VEC_LOOP_mux1h_39_nl, VEC_LOOP_nor_12_seb);
  assign VEC_LOOP_mux1h_40_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_10_5_sva_4_0[2]), (COMP_LOOP_k_10_5_sva_4_0[0]),
      (COMP_LOOP_k_10_5_sva_4_0[1]), (COMP_LOOP_k_10_5_sva_4_0[3]), {VEC_LOOP_or_49_itm
      , VEC_LOOP_or_46_itm , VEC_LOOP_or_48_itm , and_dcpl_438});
  assign VEC_LOOP_and_31_nl = ((VEC_LOOP_mux1h_40_nl & (~(and_dcpl_415 | and_dcpl_418
      | and_dcpl_419 | and_dcpl_420))) | and_dcpl_422 | and_dcpl_424 | and_dcpl_425
      | and_dcpl_426) & VEC_LOOP_nor_12_seb;
  assign VEC_LOOP_mux1h_41_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_10_5_sva_4_0[1]), (COMP_LOOP_k_10_5_sva_4_0[0]),
      (COMP_LOOP_k_10_5_sva_4_0[2]), {VEC_LOOP_or_49_itm , VEC_LOOP_or_48_itm , and_dcpl_438});
  assign VEC_LOOP_or_71_nl = (VEC_LOOP_mux1h_41_nl & (~(and_dcpl_406 | and_dcpl_409
      | and_dcpl_415 | and_dcpl_418 | and_dcpl_422 | and_dcpl_424 | and_dcpl_434
      | and_dcpl_449 | and_dcpl_450 | and_dcpl_452))) | and_dcpl_411 | and_dcpl_412
      | and_dcpl_419 | and_dcpl_420 | and_dcpl_425 | and_dcpl_426 | and_dcpl_440
      | and_dcpl_443;
  assign VEC_LOOP_VEC_LOOP_mux_11_nl = MUX_s_1_2_2((COMP_LOOP_k_10_5_sva_4_0[0]),
      (COMP_LOOP_k_10_5_sva_4_0[1]), and_dcpl_438);
  assign VEC_LOOP_or_72_nl = (VEC_LOOP_VEC_LOOP_mux_11_nl & (~(and_dcpl_406 | and_dcpl_411
      | and_dcpl_415 | and_dcpl_419 | and_dcpl_422 | and_dcpl_425 | and_dcpl_428
      | and_dcpl_434 | and_dcpl_443 | and_dcpl_447 | and_dcpl_450 | and_dcpl_452)))
      | and_dcpl_409 | and_dcpl_412 | and_dcpl_418 | and_dcpl_420 | and_dcpl_424
      | and_dcpl_426 | and_dcpl_429 | and_dcpl_440 | and_dcpl_442 | and_dcpl_449;
  assign VEC_LOOP_VEC_LOOP_or_16_nl = ((COMP_LOOP_k_10_5_sva_4_0[0]) & (~(and_dcpl_440
      | and_dcpl_442 | and_dcpl_443 | and_dcpl_447 | and_dcpl_449 | and_dcpl_450
      | and_dcpl_446))) | and_dcpl_402 | and_dcpl_406 | and_dcpl_409 | and_dcpl_411
      | and_dcpl_412 | and_dcpl_415 | and_dcpl_418 | and_dcpl_419 | and_dcpl_420
      | and_dcpl_422 | and_dcpl_424 | and_dcpl_425 | and_dcpl_426 | and_dcpl_428
      | and_dcpl_429 | and_dcpl_434 | and_dcpl_452;
  assign nl_acc_2_nl = ({VEC_LOOP_VEC_LOOP_or_15_nl , VEC_LOOP_or_66_nl , VEC_LOOP_mux1h_37_nl
      , VEC_LOOP_or_69_nl}) + ({VEC_LOOP_and_27_nl , VEC_LOOP_and_28_nl , VEC_LOOP_and_29_nl
      , VEC_LOOP_and_30_nl , VEC_LOOP_and_31_nl , VEC_LOOP_or_71_nl , VEC_LOOP_or_72_nl
      , VEC_LOOP_VEC_LOOP_or_16_nl , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[9:0];
  assign z_out_6 = readslicef_10_9_1(acc_2_nl);
  assign VEC_LOOP_VEC_LOOP_mux_12_nl = MUX_v_5_2_2(COMP_LOOP_k_10_5_sva_4_0, ({1'b0
      , (COMP_LOOP_k_10_5_sva_4_0[4:1])}), and_dcpl_465);
  assign VEC_LOOP_VEC_LOOP_or_17_nl = ((COMP_LOOP_k_10_5_sva_4_0[0]) & (~(and_dcpl_459
      & and_dcpl_71 & (~ (fsm_output[7])) & (~ (fsm_output[3]))))) | and_620_cse;
  assign VEC_LOOP_VEC_LOOP_mux_13_nl = MUX_v_7_2_2((STAGE_LOOP_lshift_psp_sva[10:4]),
      ({1'b0 , (STAGE_LOOP_lshift_psp_sva[10:5])}), and_dcpl_465);
  assign nl_z_out_7 = ({VEC_LOOP_VEC_LOOP_mux_12_nl , VEC_LOOP_VEC_LOOP_or_17_nl
      , 1'b1}) + VEC_LOOP_VEC_LOOP_mux_13_nl;
  assign z_out_7 = nl_z_out_7[6:0];
  assign VEC_LOOP_mux1h_42_nl = MUX1HOT_v_4_14_2(4'b1110, 4'b1101, 4'b1100, 4'b1011,
      4'b1010, 4'b1001, 4'b1000, 4'b0111, 4'b0110, 4'b0101, 4'b0100, 4'b0011, 4'b0010,
      4'b0001, {and_524_itm , and_527_itm , and_530_itm , and_533_itm , and_534_itm
      , and_535_itm , and_536_itm , and_539_itm , and_541_itm , and_543_itm , and_545_itm
      , and_546_itm , and_547_itm , and_548_itm});
  assign VEC_LOOP_nor_32_nl = ~(MUX_v_4_2_2(VEC_LOOP_mux1h_42_nl, 4'b1111, and_521_itm));
  assign VEC_LOOP_or_73_nl = MUX_v_4_2_2(VEC_LOOP_nor_32_nl, 4'b1111, and_549_itm);
  assign nl_z_out_8 = VEC_LOOP_acc_1_cse_10_sva + ({COMP_LOOP_k_10_5_sva_4_0 , VEC_LOOP_or_73_nl
      , 1'b1});
  assign z_out_8 = nl_z_out_8[9:0];
  assign and_659_nl = and_dcpl_473 & and_dcpl_291;
  assign and_660_nl = and_dcpl_473 & and_dcpl_386;
  assign and_661_nl = and_dcpl_473 & and_dcpl_360;
  assign and_662_nl = and_dcpl_459 & and_dcpl_291;
  assign and_663_nl = and_dcpl_459 & and_dcpl_386;
  assign and_664_nl = and_dcpl_459 & and_dcpl_360;
  assign and_665_nl = and_dcpl_473 & and_dcpl_306;
  assign and_666_nl = and_dcpl_473 & and_dcpl_285;
  assign and_667_nl = and_dcpl_473 & and_dcpl_342;
  assign and_668_nl = and_dcpl_459 & and_dcpl_306;
  assign and_669_nl = and_dcpl_459 & and_dcpl_285;
  assign and_670_nl = and_dcpl_459 & and_dcpl_342;
  assign VEC_LOOP_mux1h_43_nl = MUX1HOT_v_5_27_2(5'b00001, 5'b00010, 5'b00011, 5'b00100,
      5'b00101, 5'b00110, 5'b00111, 5'b01001, 5'b01010, 5'b01011, 5'b01100, 5'b01101,
      5'b01110, 5'b01111, 5'b10001, 5'b10010, 5'b10011, 5'b10100, 5'b10101, 5'b10110,
      5'b10111, 5'b11001, 5'b11010, 5'b11011, 5'b11100, 5'b11101, 5'b11110, {and_521_itm
      , and_659_nl , and_524_itm , and_660_nl , and_527_itm , and_661_nl , and_530_itm
      , and_533_itm , and_662_nl , and_534_itm , and_663_nl , and_535_itm , and_664_nl
      , and_536_itm , and_539_itm , and_665_nl , and_541_itm , and_666_nl , and_543_itm
      , and_667_nl , and_545_itm , and_546_itm , and_668_nl , and_547_itm , and_669_nl
      , and_548_itm , and_670_nl});
  assign VEC_LOOP_or_74_nl = MUX_v_5_2_2(VEC_LOOP_mux1h_43_nl, 5'b11111, and_549_itm);
  assign nl_z_out_9 = ({COMP_LOOP_k_10_5_sva_4_0 , VEC_LOOP_or_74_nl}) + (STAGE_LOOP_lshift_psp_sva[10:1]);
  assign z_out_9 = nl_z_out_9[9:0];
  assign nl_VEC_LOOP_acc_62_nl = COMP_LOOP_k_10_5_sva_4_0 + (STAGE_LOOP_lshift_psp_sva[10:6]);
  assign VEC_LOOP_acc_62_nl = nl_VEC_LOOP_acc_62_nl[4:0];
  assign and_671_nl = and_dcpl_473 & and_dcpl_561;
  assign and_672_nl = and_dcpl_473 & and_dcpl_462;
  assign VEC_LOOP_mux1h_44_nl = MUX1HOT_v_6_3_2(({VEC_LOOP_acc_62_nl , (STAGE_LOOP_lshift_psp_sva[5])}),
      (z_out_7[6:1]), (z_out_7[5:0]), {and_671_nl , VEC_LOOP_or_63_itm , and_672_nl});
  assign VEC_LOOP_VEC_LOOP_mux_14_nl = MUX_s_1_2_2((STAGE_LOOP_lshift_psp_sva[4]),
      (z_out_7[0]), VEC_LOOP_or_63_itm);
  assign nl_z_out_10 = ({VEC_LOOP_mux1h_44_nl , VEC_LOOP_VEC_LOOP_mux_14_nl , (STAGE_LOOP_lshift_psp_sva[3:1])})
      + VEC_LOOP_acc_1_cse_10_sva;
  assign z_out_10 = nl_z_out_10[9:0];
  assign VEC_LOOP_mux_19_cse = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
      and_628_cse);

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


  function automatic [0:0] MUX1HOT_s_1_35_2;
    input [0:0] input_34;
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
    input [34:0] sel;
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
    result = result | ( input_34 & {1{sel[34]}});
    MUX1HOT_s_1_35_2 = result;
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


  function automatic [9:0] MUX1HOT_v_10_29_2;
    input [9:0] input_28;
    input [9:0] input_27;
    input [9:0] input_26;
    input [9:0] input_25;
    input [9:0] input_24;
    input [9:0] input_23;
    input [9:0] input_22;
    input [9:0] input_21;
    input [9:0] input_20;
    input [9:0] input_19;
    input [9:0] input_18;
    input [9:0] input_17;
    input [9:0] input_16;
    input [9:0] input_15;
    input [9:0] input_14;
    input [9:0] input_13;
    input [9:0] input_12;
    input [9:0] input_11;
    input [9:0] input_10;
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
    input [28:0] sel;
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
    result = result | ( input_10 & {10{sel[10]}});
    result = result | ( input_11 & {10{sel[11]}});
    result = result | ( input_12 & {10{sel[12]}});
    result = result | ( input_13 & {10{sel[13]}});
    result = result | ( input_14 & {10{sel[14]}});
    result = result | ( input_15 & {10{sel[15]}});
    result = result | ( input_16 & {10{sel[16]}});
    result = result | ( input_17 & {10{sel[17]}});
    result = result | ( input_18 & {10{sel[18]}});
    result = result | ( input_19 & {10{sel[19]}});
    result = result | ( input_20 & {10{sel[20]}});
    result = result | ( input_21 & {10{sel[21]}});
    result = result | ( input_22 & {10{sel[22]}});
    result = result | ( input_23 & {10{sel[23]}});
    result = result | ( input_24 & {10{sel[24]}});
    result = result | ( input_25 & {10{sel[25]}});
    result = result | ( input_26 & {10{sel[26]}});
    result = result | ( input_27 & {10{sel[27]}});
    result = result | ( input_28 & {10{sel[28]}});
    MUX1HOT_v_10_29_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_5_2;
    input [1:0] input_4;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [4:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | ( input_1 & {2{sel[1]}});
    result = result | ( input_2 & {2{sel[2]}});
    result = result | ( input_3 & {2{sel[3]}});
    result = result | ( input_4 & {2{sel[4]}});
    MUX1HOT_v_2_5_2 = result;
  end
  endfunction


  function automatic [2:0] MUX1HOT_v_3_3_2;
    input [2:0] input_2;
    input [2:0] input_1;
    input [2:0] input_0;
    input [2:0] sel;
    reg [2:0] result;
  begin
    result = input_0 & {3{sel[0]}};
    result = result | ( input_1 & {3{sel[1]}});
    result = result | ( input_2 & {3{sel[2]}});
    MUX1HOT_v_3_3_2 = result;
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


  function automatic [3:0] MUX1HOT_v_4_7_2;
    input [3:0] input_6;
    input [3:0] input_5;
    input [3:0] input_4;
    input [3:0] input_3;
    input [3:0] input_2;
    input [3:0] input_1;
    input [3:0] input_0;
    input [6:0] sel;
    reg [3:0] result;
  begin
    result = input_0 & {4{sel[0]}};
    result = result | ( input_1 & {4{sel[1]}});
    result = result | ( input_2 & {4{sel[2]}});
    result = result | ( input_3 & {4{sel[3]}});
    result = result | ( input_4 & {4{sel[4]}});
    result = result | ( input_5 & {4{sel[5]}});
    result = result | ( input_6 & {4{sel[6]}});
    MUX1HOT_v_4_7_2 = result;
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


  function automatic [4:0] MUX1HOT_v_5_37_2;
    input [4:0] input_36;
    input [4:0] input_35;
    input [4:0] input_34;
    input [4:0] input_33;
    input [4:0] input_32;
    input [4:0] input_31;
    input [4:0] input_30;
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
    input [36:0] sel;
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
    result = result | ( input_30 & {5{sel[30]}});
    result = result | ( input_31 & {5{sel[31]}});
    result = result | ( input_32 & {5{sel[32]}});
    result = result | ( input_33 & {5{sel[33]}});
    result = result | ( input_34 & {5{sel[34]}});
    result = result | ( input_35 & {5{sel[35]}});
    result = result | ( input_36 & {5{sel[36]}});
    MUX1HOT_v_5_37_2 = result;
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


  function automatic [5:0] MUX1HOT_v_6_7_2;
    input [5:0] input_6;
    input [5:0] input_5;
    input [5:0] input_4;
    input [5:0] input_3;
    input [5:0] input_2;
    input [5:0] input_1;
    input [5:0] input_0;
    input [6:0] sel;
    reg [5:0] result;
  begin
    result = input_0 & {6{sel[0]}};
    result = result | ( input_1 & {6{sel[1]}});
    result = result | ( input_2 & {6{sel[2]}});
    result = result | ( input_3 & {6{sel[3]}});
    result = result | ( input_4 & {6{sel[4]}});
    result = result | ( input_5 & {6{sel[5]}});
    result = result | ( input_6 & {6{sel[6]}});
    MUX1HOT_v_6_7_2 = result;
  end
  endfunction


  function automatic [6:0] MUX1HOT_v_7_10_2;
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
    input [9:0] sel;
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
    MUX1HOT_v_7_10_2 = result;
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


  function automatic [8:0] MUX1HOT_v_9_5_2;
    input [8:0] input_4;
    input [8:0] input_3;
    input [8:0] input_2;
    input [8:0] input_1;
    input [8:0] input_0;
    input [4:0] sel;
    reg [8:0] result;
  begin
    result = input_0 & {9{sel[0]}};
    result = result | ( input_1 & {9{sel[1]}});
    result = result | ( input_2 & {9{sel[2]}});
    result = result | ( input_3 & {9{sel[3]}});
    result = result | ( input_4 & {9{sel[4]}});
    MUX1HOT_v_9_5_2 = result;
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


  function automatic [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
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


  function automatic [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_precomp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_precomp (
  clk, rst, run_rsc_rdy, run_rsc_vld, vec_rsc_adra, vec_rsc_da, vec_rsc_wea, vec_rsc_qa,
      vec_rsc_adrb, vec_rsc_db, vec_rsc_web, vec_rsc_qb, vec_rsc_triosy_lz, p_rsc_dat,
      p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz, twiddle_rsc_adrb, twiddle_rsc_qb,
      twiddle_rsc_triosy_lz, twiddle_h_rsc_adrb, twiddle_h_rsc_qb, twiddle_h_rsc_triosy_lz,
      complete_rsc_rdy, complete_rsc_vld
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
  output [9:0] twiddle_rsc_adrb;
  input [31:0] twiddle_rsc_qb;
  output twiddle_rsc_triosy_lz;
  output [9:0] twiddle_h_rsc_adrb;
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
  wire [9:0] twiddle_rsci_adrb_d;
  wire [31:0] twiddle_rsci_qb_d;
  wire twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d;
  wire [9:0] twiddle_h_rsci_adrb_d;
  wire [31:0] twiddle_h_rsci_qb_d;
  wire twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations for Component Instantiations 
  wire [63:0] nl_vec_rsci_da_d;
  assign nl_vec_rsci_da_d = {32'b00000000000000000000000000000000 , vec_rsci_da_d};
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_10_32_1024_1024_32_1_gen
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
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_16_10_32_1024_1024_32_1_gen
      twiddle_rsci (
      .qb(twiddle_rsc_qb),
      .adrb(twiddle_rsc_adrb),
      .adrb_d(twiddle_rsci_adrb_d),
      .qb_d(twiddle_rsci_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_precomp_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rport_17_10_32_1024_1024_32_1_gen
      twiddle_h_rsci (
      .qb(twiddle_h_rsc_qb),
      .adrb(twiddle_h_rsc_adrb),
      .adrb_d(twiddle_h_rsci_adrb_d),
      .qb_d(twiddle_h_rsci_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d)
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
      .twiddle_rsci_adrb_d(twiddle_rsci_adrb_d),
      .twiddle_rsci_qb_d(twiddle_rsci_qb_d),
      .twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsci_adrb_d(twiddle_h_rsci_adrb_d),
      .twiddle_h_rsci_qb_d(twiddle_h_rsci_qb_d),
      .twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d)
    );
endmodule



