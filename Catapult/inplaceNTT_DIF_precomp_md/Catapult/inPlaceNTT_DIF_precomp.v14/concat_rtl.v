
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
//  Generated date: Mon Sep 13 21:06:35 2021
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
      COMP_LOOP_C_2_tr0, COMP_LOOP_2_VEC_LOOP_C_6_tr0, COMP_LOOP_C_3_tr0, COMP_LOOP_3_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_4_tr0, COMP_LOOP_4_VEC_LOOP_C_6_tr0, COMP_LOOP_C_5_tr0, COMP_LOOP_5_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_6_tr0, COMP_LOOP_6_VEC_LOOP_C_6_tr0, COMP_LOOP_C_7_tr0, COMP_LOOP_7_VEC_LOOP_C_6_tr0,
      COMP_LOOP_C_8_tr0, COMP_LOOP_8_VEC_LOOP_C_6_tr0, COMP_LOOP_C_9_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
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
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIF_precomp_core_core_fsm_1
  parameter
    main_C_0 = 7'd0,
    STAGE_LOOP_C_0 = 7'd1,
    COMP_LOOP_C_0 = 7'd2,
    COMP_LOOP_C_1 = 7'd3,
    COMP_LOOP_1_VEC_LOOP_C_0 = 7'd4,
    COMP_LOOP_1_VEC_LOOP_C_1 = 7'd5,
    COMP_LOOP_1_VEC_LOOP_C_2 = 7'd6,
    COMP_LOOP_1_VEC_LOOP_C_3 = 7'd7,
    COMP_LOOP_1_VEC_LOOP_C_4 = 7'd8,
    COMP_LOOP_1_VEC_LOOP_C_5 = 7'd9,
    COMP_LOOP_1_VEC_LOOP_C_6 = 7'd10,
    COMP_LOOP_C_2 = 7'd11,
    COMP_LOOP_2_VEC_LOOP_C_0 = 7'd12,
    COMP_LOOP_2_VEC_LOOP_C_1 = 7'd13,
    COMP_LOOP_2_VEC_LOOP_C_2 = 7'd14,
    COMP_LOOP_2_VEC_LOOP_C_3 = 7'd15,
    COMP_LOOP_2_VEC_LOOP_C_4 = 7'd16,
    COMP_LOOP_2_VEC_LOOP_C_5 = 7'd17,
    COMP_LOOP_2_VEC_LOOP_C_6 = 7'd18,
    COMP_LOOP_C_3 = 7'd19,
    COMP_LOOP_3_VEC_LOOP_C_0 = 7'd20,
    COMP_LOOP_3_VEC_LOOP_C_1 = 7'd21,
    COMP_LOOP_3_VEC_LOOP_C_2 = 7'd22,
    COMP_LOOP_3_VEC_LOOP_C_3 = 7'd23,
    COMP_LOOP_3_VEC_LOOP_C_4 = 7'd24,
    COMP_LOOP_3_VEC_LOOP_C_5 = 7'd25,
    COMP_LOOP_3_VEC_LOOP_C_6 = 7'd26,
    COMP_LOOP_C_4 = 7'd27,
    COMP_LOOP_4_VEC_LOOP_C_0 = 7'd28,
    COMP_LOOP_4_VEC_LOOP_C_1 = 7'd29,
    COMP_LOOP_4_VEC_LOOP_C_2 = 7'd30,
    COMP_LOOP_4_VEC_LOOP_C_3 = 7'd31,
    COMP_LOOP_4_VEC_LOOP_C_4 = 7'd32,
    COMP_LOOP_4_VEC_LOOP_C_5 = 7'd33,
    COMP_LOOP_4_VEC_LOOP_C_6 = 7'd34,
    COMP_LOOP_C_5 = 7'd35,
    COMP_LOOP_5_VEC_LOOP_C_0 = 7'd36,
    COMP_LOOP_5_VEC_LOOP_C_1 = 7'd37,
    COMP_LOOP_5_VEC_LOOP_C_2 = 7'd38,
    COMP_LOOP_5_VEC_LOOP_C_3 = 7'd39,
    COMP_LOOP_5_VEC_LOOP_C_4 = 7'd40,
    COMP_LOOP_5_VEC_LOOP_C_5 = 7'd41,
    COMP_LOOP_5_VEC_LOOP_C_6 = 7'd42,
    COMP_LOOP_C_6 = 7'd43,
    COMP_LOOP_6_VEC_LOOP_C_0 = 7'd44,
    COMP_LOOP_6_VEC_LOOP_C_1 = 7'd45,
    COMP_LOOP_6_VEC_LOOP_C_2 = 7'd46,
    COMP_LOOP_6_VEC_LOOP_C_3 = 7'd47,
    COMP_LOOP_6_VEC_LOOP_C_4 = 7'd48,
    COMP_LOOP_6_VEC_LOOP_C_5 = 7'd49,
    COMP_LOOP_6_VEC_LOOP_C_6 = 7'd50,
    COMP_LOOP_C_7 = 7'd51,
    COMP_LOOP_7_VEC_LOOP_C_0 = 7'd52,
    COMP_LOOP_7_VEC_LOOP_C_1 = 7'd53,
    COMP_LOOP_7_VEC_LOOP_C_2 = 7'd54,
    COMP_LOOP_7_VEC_LOOP_C_3 = 7'd55,
    COMP_LOOP_7_VEC_LOOP_C_4 = 7'd56,
    COMP_LOOP_7_VEC_LOOP_C_5 = 7'd57,
    COMP_LOOP_7_VEC_LOOP_C_6 = 7'd58,
    COMP_LOOP_C_8 = 7'd59,
    COMP_LOOP_8_VEC_LOOP_C_0 = 7'd60,
    COMP_LOOP_8_VEC_LOOP_C_1 = 7'd61,
    COMP_LOOP_8_VEC_LOOP_C_2 = 7'd62,
    COMP_LOOP_8_VEC_LOOP_C_3 = 7'd63,
    COMP_LOOP_8_VEC_LOOP_C_4 = 7'd64,
    COMP_LOOP_8_VEC_LOOP_C_5 = 7'd65,
    COMP_LOOP_8_VEC_LOOP_C_6 = 7'd66,
    COMP_LOOP_C_9 = 7'd67,
    STAGE_LOOP_C_1 = 7'd68,
    main_C_1 = 7'd69,
    main_C_2 = 7'd70;

  reg [6:0] state_var;
  reg [6:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIF_precomp_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 7'b0000001;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 7'b0000010;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 7'b0000011;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
      end
      COMP_LOOP_1_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0000100;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_1;
      end
      COMP_LOOP_1_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0000101;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_2;
      end
      COMP_LOOP_1_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0000110;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_3;
      end
      COMP_LOOP_1_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0000111;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_4;
      end
      COMP_LOOP_1_VEC_LOOP_C_4 : begin
        fsm_output = 7'b0001000;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_5;
      end
      COMP_LOOP_1_VEC_LOOP_C_5 : begin
        fsm_output = 7'b0001001;
        state_var_NS = COMP_LOOP_1_VEC_LOOP_C_6;
      end
      COMP_LOOP_1_VEC_LOOP_C_6 : begin
        fsm_output = 7'b0001010;
        if ( COMP_LOOP_1_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 7'b0001011;
        if ( COMP_LOOP_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_2_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0001100;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_1;
      end
      COMP_LOOP_2_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0001101;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_2;
      end
      COMP_LOOP_2_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0001110;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_3;
      end
      COMP_LOOP_2_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0001111;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_4;
      end
      COMP_LOOP_2_VEC_LOOP_C_4 : begin
        fsm_output = 7'b0010000;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_5;
      end
      COMP_LOOP_2_VEC_LOOP_C_5 : begin
        fsm_output = 7'b0010001;
        state_var_NS = COMP_LOOP_2_VEC_LOOP_C_6;
      end
      COMP_LOOP_2_VEC_LOOP_C_6 : begin
        fsm_output = 7'b0010010;
        if ( COMP_LOOP_2_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_3;
        end
        else begin
          state_var_NS = COMP_LOOP_2_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 7'b0010011;
        if ( COMP_LOOP_C_3_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_3_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0010100;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_1;
      end
      COMP_LOOP_3_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0010101;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_2;
      end
      COMP_LOOP_3_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0010110;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_3;
      end
      COMP_LOOP_3_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0010111;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_4;
      end
      COMP_LOOP_3_VEC_LOOP_C_4 : begin
        fsm_output = 7'b0011000;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_5;
      end
      COMP_LOOP_3_VEC_LOOP_C_5 : begin
        fsm_output = 7'b0011001;
        state_var_NS = COMP_LOOP_3_VEC_LOOP_C_6;
      end
      COMP_LOOP_3_VEC_LOOP_C_6 : begin
        fsm_output = 7'b0011010;
        if ( COMP_LOOP_3_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_4;
        end
        else begin
          state_var_NS = COMP_LOOP_3_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 7'b0011011;
        if ( COMP_LOOP_C_4_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_4_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0011100;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_1;
      end
      COMP_LOOP_4_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0011101;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_2;
      end
      COMP_LOOP_4_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0011110;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_3;
      end
      COMP_LOOP_4_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0011111;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_4;
      end
      COMP_LOOP_4_VEC_LOOP_C_4 : begin
        fsm_output = 7'b0100000;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_5;
      end
      COMP_LOOP_4_VEC_LOOP_C_5 : begin
        fsm_output = 7'b0100001;
        state_var_NS = COMP_LOOP_4_VEC_LOOP_C_6;
      end
      COMP_LOOP_4_VEC_LOOP_C_6 : begin
        fsm_output = 7'b0100010;
        if ( COMP_LOOP_4_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_5;
        end
        else begin
          state_var_NS = COMP_LOOP_4_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 7'b0100011;
        if ( COMP_LOOP_C_5_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_5_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0100100;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_1;
      end
      COMP_LOOP_5_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0100101;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_2;
      end
      COMP_LOOP_5_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0100110;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_3;
      end
      COMP_LOOP_5_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0100111;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_4;
      end
      COMP_LOOP_5_VEC_LOOP_C_4 : begin
        fsm_output = 7'b0101000;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_5;
      end
      COMP_LOOP_5_VEC_LOOP_C_5 : begin
        fsm_output = 7'b0101001;
        state_var_NS = COMP_LOOP_5_VEC_LOOP_C_6;
      end
      COMP_LOOP_5_VEC_LOOP_C_6 : begin
        fsm_output = 7'b0101010;
        if ( COMP_LOOP_5_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_6;
        end
        else begin
          state_var_NS = COMP_LOOP_5_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 7'b0101011;
        if ( COMP_LOOP_C_6_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_6_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0101100;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_1;
      end
      COMP_LOOP_6_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0101101;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_2;
      end
      COMP_LOOP_6_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0101110;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_3;
      end
      COMP_LOOP_6_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0101111;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_4;
      end
      COMP_LOOP_6_VEC_LOOP_C_4 : begin
        fsm_output = 7'b0110000;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_5;
      end
      COMP_LOOP_6_VEC_LOOP_C_5 : begin
        fsm_output = 7'b0110001;
        state_var_NS = COMP_LOOP_6_VEC_LOOP_C_6;
      end
      COMP_LOOP_6_VEC_LOOP_C_6 : begin
        fsm_output = 7'b0110010;
        if ( COMP_LOOP_6_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_7;
        end
        else begin
          state_var_NS = COMP_LOOP_6_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 7'b0110011;
        if ( COMP_LOOP_C_7_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_7_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0110100;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_1;
      end
      COMP_LOOP_7_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0110101;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_2;
      end
      COMP_LOOP_7_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0110110;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_3;
      end
      COMP_LOOP_7_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0110111;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_4;
      end
      COMP_LOOP_7_VEC_LOOP_C_4 : begin
        fsm_output = 7'b0111000;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_5;
      end
      COMP_LOOP_7_VEC_LOOP_C_5 : begin
        fsm_output = 7'b0111001;
        state_var_NS = COMP_LOOP_7_VEC_LOOP_C_6;
      end
      COMP_LOOP_7_VEC_LOOP_C_6 : begin
        fsm_output = 7'b0111010;
        if ( COMP_LOOP_7_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_8;
        end
        else begin
          state_var_NS = COMP_LOOP_7_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 7'b0111011;
        if ( COMP_LOOP_C_8_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_8_VEC_LOOP_C_0 : begin
        fsm_output = 7'b0111100;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_1;
      end
      COMP_LOOP_8_VEC_LOOP_C_1 : begin
        fsm_output = 7'b0111101;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_2;
      end
      COMP_LOOP_8_VEC_LOOP_C_2 : begin
        fsm_output = 7'b0111110;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_3;
      end
      COMP_LOOP_8_VEC_LOOP_C_3 : begin
        fsm_output = 7'b0111111;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_4;
      end
      COMP_LOOP_8_VEC_LOOP_C_4 : begin
        fsm_output = 7'b1000000;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_5;
      end
      COMP_LOOP_8_VEC_LOOP_C_5 : begin
        fsm_output = 7'b1000001;
        state_var_NS = COMP_LOOP_8_VEC_LOOP_C_6;
      end
      COMP_LOOP_8_VEC_LOOP_C_6 : begin
        fsm_output = 7'b1000010;
        if ( COMP_LOOP_8_VEC_LOOP_C_6_tr0 ) begin
          state_var_NS = COMP_LOOP_C_9;
        end
        else begin
          state_var_NS = COMP_LOOP_8_VEC_LOOP_C_0;
        end
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 7'b1000011;
        if ( COMP_LOOP_C_9_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 7'b1000100;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b1000101;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 7'b1000110;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 7'b0000000;
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
  wire [6:0] fsm_output;
  wire or_tmp_6;
  wire mux_tmp_9;
  wire nor_tmp_3;
  wire mux_tmp_20;
  wire or_tmp_13;
  wire or_dcpl_31;
  wire or_tmp_18;
  wire mux_tmp_36;
  wire nand_tmp;
  wire and_dcpl_19;
  wire and_dcpl_20;
  wire and_dcpl_22;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_30;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_34;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_39;
  wire and_dcpl_40;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire and_dcpl_44;
  wire and_dcpl_46;
  wire and_dcpl_47;
  wire and_dcpl_48;
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_57;
  wire and_dcpl_60;
  wire or_dcpl_33;
  wire and_dcpl_62;
  wire and_dcpl_65;
  wire and_dcpl_71;
  wire and_dcpl_73;
  wire and_dcpl_75;
  wire and_dcpl_77;
  wire and_dcpl_81;
  wire and_dcpl_82;
  wire and_dcpl_83;
  wire and_dcpl_90;
  wire and_dcpl_99;
  wire and_tmp_1;
  wire mux_tmp_41;
  wire mux_tmp_45;
  wire and_dcpl_109;
  reg [9:0] VEC_LOOP_j_10_0_2_sva_9_0;
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
  wire and_124_cse;
  wire or_69_cse;
  wire mux_8_cse;
  wire [31:0] vec_rsci_da_d_reg;
  wire [1:0] vec_rsci_wea_d_reg;
  wire core_wten_iff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire and_22_rmff;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  wire [6:0] COMP_LOOP_twiddle_f_mux1h_24_rmff;
  wire COMP_LOOP_twiddle_f_and_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_6_rmff;
  wire COMP_LOOP_twiddle_f_mux1h_17_rmff;
  wire twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire and_75_rmff;
  wire twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  wire mux_39_rmff;
  wire and_97_rmff;
  wire and_101_rmff;
  reg [31:0] COMP_LOOP_twiddle_f_1_sva;
  reg [31:0] COMP_LOOP_twiddle_help_1_sva;
  reg [6:0] VEC_LOOP_acc_psp_sva;
  reg [9:0] VEC_LOOP_acc_10_cse_1_sva;
  reg [9:0] COMP_LOOP_twiddle_f_mul_cse_6_sva;
  reg [8:0] VEC_LOOP_acc_11_psp_sva;
  reg [7:0] COMP_LOOP_5_twiddle_f_mul_psp_sva;
  reg [31:0] p_sva;
  wire mux_37_itm;
  wire mux_38_itm;
  wire [6:0] COMP_LOOP_1_twiddle_f_lshift_itm;
  wire [10:0] STAGE_LOOP_lshift_itm;
  wire [7:0] COMP_LOOP_5_twiddle_f_lshift_itm;
  wire [9:0] z_out;
  wire and_dcpl_130;
  wire and_dcpl_131;
  wire and_dcpl_132;
  wire and_dcpl_134;
  wire and_dcpl_136;
  wire and_dcpl_139;
  wire and_dcpl_140;
  wire and_dcpl_142;
  wire and_dcpl_144;
  wire and_dcpl_146;
  wire [9:0] z_out_1;
  wire [19:0] nl_z_out_1;
  wire and_dcpl_154;
  wire and_dcpl_155;
  wire and_dcpl_158;
  wire and_dcpl_160;
  wire and_dcpl_163;
  wire and_dcpl_166;
  wire [10:0] z_out_2;
  wire and_dcpl_172;
  wire and_dcpl_175;
  wire and_dcpl_177;
  wire and_dcpl_179;
  wire and_dcpl_185;
  wire and_dcpl_188;
  wire [8:0] z_out_3;
  wire [7:0] z_out_4;
  wire [8:0] nl_z_out_4;
  wire [9:0] z_out_5;
  wire [10:0] nl_z_out_5;
  wire [9:0] z_out_7;
  wire [10:0] nl_z_out_7;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva;
  reg [9:0] COMP_LOOP_2_twiddle_f_lshift_ncse_sva;
  reg [8:0] COMP_LOOP_3_twiddle_f_lshift_ncse_sva;
  reg [6:0] COMP_LOOP_k_10_3_sva_6_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire [3:0] COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
  wire [4:0] nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
  wire COMP_LOOP_twiddle_f_or_3_cse;
  wire VEC_LOOP_or_1_cse;
  wire VEC_LOOP_or_4_cse;
  wire VEC_LOOP_or_6_cse;
  wire VEC_LOOP_or_12_cse;
  wire nor_19_cse;
  wire and_225_cse;
  wire COMP_LOOP_twiddle_help_and_cse;
  wire and_159_cse;
  wire and_272_cse;
  wire or_tmp_28;
  wire mux_tmp;
  wire COMP_LOOP_twiddle_f_or_10_itm;
  wire VEC_LOOP_or_24_itm;
  wire VEC_LOOP_or_20_itm;
  wire VEC_LOOP_or_28_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire COMP_LOOP_twiddle_f_nor_5_cse;
  wire and_237_cse_1;
  wire and_248_cse_1;
  wire and_252_cse_1;
  wire and_284_cse;
  wire [31:0] VEC_LOOP_mux_27_cse;

  wire[0:0] or_55_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_6_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux1h_13_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl;
  wire[6:0] COMP_LOOP_1_twiddle_f_mul_nl;
  wire[13:0] nl_COMP_LOOP_1_twiddle_f_mul_nl;
  wire[0:0] and_87_nl;
  wire[0:0] nor_15_nl;
  wire[0:0] nor_16_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] or_68_nl;
  wire[0:0] COMP_LOOP_k_not_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] mux_71_nl;
  wire[0:0] and_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] or_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] mux_51_nl;
  wire[0:0] mux_16_nl;
  wire[0:0] mux_14_nl;
  wire[0:0] and_11_nl;
  wire[0:0] nor_4_nl;
  wire[0:0] not_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] mux_11_nl;
  wire[0:0] VEC_LOOP_or_16_nl;
  wire[0:0] mux_60_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] nand_2_nl;
  wire[0:0] mux_28_nl;
  wire[0:0] mux_27_nl;
  wire[0:0] and_120_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] mux_63_nl;
  wire[0:0] mux_62_nl;
  wire[0:0] mux_35_nl;
  wire[0:0] mux_44_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[7:0] VEC_LOOP_mux1h_6_nl;
  wire[0:0] VEC_LOOP_mux1h_4_nl;
  wire[0:0] VEC_LOOP_mux1h_2_nl;
  wire[0:0] and_65_nl;
  wire[6:0] VEC_LOOP_mux1h_nl;
  wire[0:0] and_30_nl;
  wire[0:0] VEC_LOOP_mux1h_1_nl;
  wire[0:0] and_62_nl;
  wire[0:0] VEC_LOOP_mux1h_3_nl;
  wire[0:0] and_68_nl;
  wire[0:0] VEC_LOOP_mux1h_5_nl;
  wire[0:0] and_71_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl;
  wire[0:0] COMP_LOOP_twiddle_f_mux_3_nl;
  wire[8:0] COMP_LOOP_twiddle_f_mux1h_73_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_13_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_14_nl;
  wire[0:0] COMP_LOOP_twiddle_f_and_12_nl;
  wire[5:0] COMP_LOOP_twiddle_f_mux1h_74_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_15_nl;
  wire[0:0] COMP_LOOP_twiddle_f_or_16_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl;
  wire[0:0] COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_1_nl;
  wire[11:0] acc_nl;
  wire[12:0] nl_acc_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_6_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_5_nl;
  wire[0:0] VEC_LOOP_or_33_nl;
  wire[6:0] VEC_LOOP_VEC_LOOP_mux_6_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_7_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_8_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_9_nl;
  wire[9:0] acc_1_nl;
  wire[10:0] nl_acc_1_nl;
  wire[8:0] VEC_LOOP_mux1h_21_nl;
  wire[0:0] VEC_LOOP_or_34_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_and_1_nl;
  wire[0:0] VEC_LOOP_and_12_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_mux_7_nl;
  wire[4:0] VEC_LOOP_mux1h_22_nl;
  wire[0:0] VEC_LOOP_or_35_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_10_nl;
  wire[0:0] VEC_LOOP_mux_24_nl;
  wire[0:0] VEC_LOOP_VEC_LOOP_or_11_nl;
  wire[6:0] VEC_LOOP_mux_25_nl;
  wire[0:0] and_281_nl;
  wire[9:0] VEC_LOOP_VEC_LOOP_mux_8_nl;
  wire[9:0] VEC_LOOP_acc_24_nl;
  wire[10:0] nl_VEC_LOOP_acc_24_nl;
  wire[2:0] VEC_LOOP_or_37_nl;
  wire[2:0] VEC_LOOP_mux1h_23_nl;
  wire[0:0] and_289_nl;
  wire[0:0] VEC_LOOP_or_36_nl;
  wire[1:0] VEC_LOOP_or_38_nl;
  wire[1:0] VEC_LOOP_VEC_LOOP_VEC_LOOP_nor_1_nl;
  wire[1:0] VEC_LOOP_mux_26_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat = COMP_LOOP_twiddle_f_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1;
  assign nl_COMP_LOOP_1_mult_cmp_y_rsc_dat_1 = COMP_LOOP_twiddle_help_1_sva;
  wire [31:0] nl_COMP_LOOP_1_mult_cmp_p_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_p_rsc_dat = p_sva;
  wire [0:0] nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat;
  assign nl_COMP_LOOP_1_mult_cmp_ccs_ccore_start_rsc_dat = and_dcpl_20 & and_dcpl_36;
  wire[32:0] acc_6_nl;
  wire[33:0] nl_acc_6_nl;
  wire[31:0] VEC_LOOP_mux_28_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_28_nl = MUX_v_32_2_2((~ (vec_rsci_qa_d_mxwt[63:32])), (~ (vec_rsci_qa_d_mxwt[31:0])),
      and_272_cse);
  assign nl_acc_6_nl = ({VEC_LOOP_mux_27_cse , 1'b1}) + ({VEC_LOOP_mux_28_nl , 1'b1});
  assign acc_6_nl = nl_acc_6_nl[32:0];
  assign nl_COMP_LOOP_1_modulo_sub_cmp_base_rsc_dat = readslicef_33_32_1(acc_6_nl);
  wire [31:0] nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_sub_cmp_m_rsc_dat = p_sva;
  wire[31:0] VEC_LOOP_mux_30_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat;
  assign VEC_LOOP_mux_30_nl = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[63:32]), (vec_rsci_qa_d_mxwt[31:0]),
      and_272_cse);
  assign nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat = VEC_LOOP_mux_27_cse + VEC_LOOP_mux_30_nl;
  wire [31:0] nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat;
  assign nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat = p_sva;
  wire[31:0] VEC_LOOP_mux_3_nl;
  wire [63:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core;
  assign VEC_LOOP_mux_3_nl = MUX_v_32_2_2(COMP_LOOP_1_modulo_add_cmp_return_rsc_z,
      COMP_LOOP_1_mult_cmp_return_rsc_z, and_dcpl_32);
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_da_d_core = {32'b00000000000000000000000000000000
      , VEC_LOOP_mux_3_nl};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_wea_d_core_psct
      = {1'b0 , (~ mux_38_itm)};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {and_22_rmff , and_22_rmff};
  wire [1:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_core_psct
      = {1'b0 , (~ mux_38_itm)};
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff;
  assign nl_inPlaceNTT_DIF_precomp_core_vec_rsci_1_inst_vec_rsci_oswt_pff = ~ mux_37_itm;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_main_C_0_tr0 = ~ run_ac_sync_tmp_dobj_sva;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_1_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_2_tr0 = ~ (z_out_2[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_2_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_3_tr0 = ~ (z_out_2[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_3_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_4_tr0 = ~ (z_out_3[8]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_4_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_5_tr0 = ~ (z_out_2[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_5_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_6_tr0 = ~ (z_out_2[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_6_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_7_tr0 = ~ (z_out_2[10]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_7_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_8_tr0 = ~ (z_out_3[7]);
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_8_VEC_LOOP_C_6_tr0
      = VEC_LOOP_j_10_0_1_sva_1[10];
  wire[10:0] COMP_LOOP_1_acc_nl;
  wire[11:0] nl_COMP_LOOP_1_acc_nl;
  wire [0:0] nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0;
  assign nl_COMP_LOOP_1_acc_nl = ({z_out_4 , 3'b000}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:1]))})
      + 11'b00000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[10:0];
  assign nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_COMP_LOOP_C_9_tr0 = ~ (readslicef_11_1_10(COMP_LOOP_1_acc_nl));
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
      .ccs_ccore_start_rsc_dat(and_101_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  modulo_add  COMP_LOOP_1_modulo_add_cmp (
      .base_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_base_rsc_dat[31:0]),
      .m_rsc_dat(nl_COMP_LOOP_1_modulo_add_cmp_m_rsc_dat[31:0]),
      .return_rsc_z(COMP_LOOP_1_modulo_add_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(and_101_rmff),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(COMP_LOOP_1_modulo_sub_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd7)) COMP_LOOP_1_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0),
      .z(COMP_LOOP_1_twiddle_f_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) STAGE_LOOP_lshift_rg (
      .a(1'b1),
      .s(STAGE_LOOP_i_3_0_sva),
      .z(STAGE_LOOP_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd8)) COMP_LOOP_5_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0),
      .z(COMP_LOOP_5_twiddle_f_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_2_twiddle_f_lshift_rg (
      .a(1'b1),
      .s(COMP_LOOP_1_twiddle_f_acc_cse_sva),
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
      .vec_rsci_oswt_1_pff(and_22_rmff)
    );
  inPlaceNTT_DIF_precomp_core_wait_dp inPlaceNTT_DIF_precomp_core_wait_dp_inst (
      .ensig_cgo_iro(mux_39_rmff),
      .ensig_cgo_iro_1(and_97_rmff),
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
      .twiddle_rsci_oswt_pff(and_75_rmff),
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
      .twiddle_h_rsci_oswt_pff(and_75_rmff),
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
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIF_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign mux_37_itm = MUX_s_1_2_2(nand_tmp, or_tmp_18, fsm_output[2]);
  assign and_22_rmff = and_dcpl_20 & and_dcpl_19;
  assign or_55_nl = (~ (fsm_output[1])) | (fsm_output[0]) | (fsm_output[6]);
  assign mux_38_itm = MUX_s_1_2_2(nand_tmp, or_55_nl, fsm_output[2]);
  assign and_75_rmff = (and_dcpl_73 | (VEC_LOOP_j_10_0_1_sva_1[10])) & and_dcpl_20
      & and_dcpl_71;
  assign COMP_LOOP_twiddle_f_or_3_cse = (and_dcpl_34 & and_dcpl_75) | (and_dcpl_46
      & and_dcpl_75);
  assign COMP_LOOP_twiddle_f_mux1h_6_nl = MUX1HOT_s_1_4_2((z_out_1[1]), (z_out_1[0]),
      (COMP_LOOP_twiddle_f_mul_cse_6_sva[1]), (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[0]),
      {COMP_LOOP_twiddle_f_or_3_cse , and_dcpl_77 , and_dcpl_81 , and_dcpl_82});
  assign COMP_LOOP_twiddle_f_mux1h_6_rmff = COMP_LOOP_twiddle_f_mux1h_6_nl & (~(and_dcpl_60
      & and_dcpl_75));
  assign COMP_LOOP_twiddle_f_mux1h_13_nl = MUX1HOT_s_1_5_2((z_out_1[2]), (z_out_1[1]),
      (COMP_LOOP_5_twiddle_f_mul_psp_sva[0]), (COMP_LOOP_twiddle_f_mul_cse_6_sva[2]),
      (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[1]), {COMP_LOOP_twiddle_f_or_3_cse ,
      and_dcpl_77 , and_dcpl_83 , and_dcpl_81 , and_dcpl_82});
  assign COMP_LOOP_twiddle_f_and_rmff = COMP_LOOP_twiddle_f_mux1h_13_nl & (~(and_dcpl_73
      | (fsm_output[6]) | (fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[2])));
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl = MUX_s_1_2_2((z_out_1[0]),
      (COMP_LOOP_twiddle_f_mul_cse_6_sva[0]), and_dcpl_81);
  assign COMP_LOOP_twiddle_f_mux1h_17_rmff = COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_nl
      & (~(and_dcpl_62 & (~ (fsm_output[0])) & and_dcpl_71));
  assign nl_COMP_LOOP_1_twiddle_f_mul_nl = COMP_LOOP_1_twiddle_f_lshift_itm * COMP_LOOP_k_10_3_sva_6_0;
  assign COMP_LOOP_1_twiddle_f_mul_nl = nl_COMP_LOOP_1_twiddle_f_mul_nl[6:0];
  assign and_87_nl = and_dcpl_25 & and_dcpl_75;
  assign COMP_LOOP_twiddle_f_mux1h_24_rmff = MUX1HOT_v_7_6_2(COMP_LOOP_1_twiddle_f_mul_nl,
      (z_out_1[9:3]), (z_out_1[8:2]), (COMP_LOOP_5_twiddle_f_mul_psp_sva[7:1]), (COMP_LOOP_twiddle_f_mul_cse_6_sva[9:3]),
      (COMP_LOOP_3_twiddle_f_lshift_ncse_sva[8:2]), {and_87_nl , COMP_LOOP_twiddle_f_or_3_cse
      , and_dcpl_77 , and_dcpl_83 , and_dcpl_81 , and_dcpl_82});
  assign nor_15_nl = ~((fsm_output[1:0]!=2'b00) | mux_tmp_36);
  assign nor_16_nl = ~((~ (fsm_output[1])) | (fsm_output[6]));
  assign mux_39_rmff = MUX_s_1_2_2(nor_15_nl, nor_16_nl, fsm_output[2]);
  assign and_97_rmff = ((fsm_output[0]) ^ (fsm_output[1])) & (~ (fsm_output[6]))
      & (fsm_output[2]);
  assign and_101_rmff = and_dcpl_99 & and_dcpl_19;
  assign or_69_cse = (fsm_output[1:0]!=2'b00);
  assign and_124_cse = (fsm_output[1:0]==2'b11);
  assign COMP_LOOP_twiddle_help_and_cse = complete_rsci_wen_comp & and_dcpl_109;
  assign mux_8_cse = MUX_s_1_2_2((~ or_tmp_6), (fsm_output[4]), fsm_output[5]);
  assign nor_19_cse = ~((fsm_output[5]) | (fsm_output[3]));
  assign VEC_LOOP_or_1_cse = and_dcpl_42 | and_dcpl_55;
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b1111;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0 = (~ STAGE_LOOP_i_3_0_sva) +
      4'b1011;
  assign COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0 = nl_COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0[3:0];
  assign or_tmp_6 = (fsm_output[4:3]!=2'b00);
  assign mux_tmp_9 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[5]);
  assign nor_tmp_3 = (fsm_output[4:3]==2'b11);
  assign mux_tmp_20 = MUX_s_1_2_2((~ nor_tmp_3), nor_tmp_3, fsm_output[5]);
  assign or_tmp_13 = (~ (fsm_output[5])) | (fsm_output[3]);
  assign or_dcpl_31 = or_tmp_6 | (fsm_output[6:5]!=2'b00);
  assign or_tmp_18 = (fsm_output[0]) | (fsm_output[6]);
  assign mux_35_nl = MUX_s_1_2_2((~ or_tmp_6), or_tmp_6, fsm_output[6]);
  assign mux_tmp_36 = MUX_s_1_2_2(mux_35_nl, (fsm_output[6]), fsm_output[5]);
  assign nand_tmp = (fsm_output[1:0]!=2'b01) | mux_tmp_36;
  assign and_dcpl_19 = (fsm_output[2:1]==2'b10);
  assign and_dcpl_20 = ~((fsm_output[6]) | (fsm_output[0]));
  assign and_dcpl_22 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_23 = and_dcpl_22 & (fsm_output[2]);
  assign and_dcpl_24 = ~((fsm_output[6:5]!=2'b00));
  assign and_dcpl_25 = (~ or_tmp_6) & and_dcpl_24;
  assign and_dcpl_26 = and_dcpl_25 & and_dcpl_23;
  assign and_dcpl_27 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_28 = and_dcpl_27 & (fsm_output[2]);
  assign and_dcpl_30 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_32 = (~ mux_tmp_36) & and_dcpl_30 & (~ (fsm_output[2]));
  assign and_dcpl_33 = (fsm_output[4:3]==2'b01);
  assign and_dcpl_34 = and_dcpl_33 & and_dcpl_24;
  assign and_dcpl_35 = and_dcpl_34 & and_dcpl_23;
  assign and_dcpl_36 = (fsm_output[2:1]==2'b11);
  assign and_dcpl_37 = (fsm_output[3]) & (~ (fsm_output[6]));
  assign and_dcpl_39 = and_dcpl_37 & (~ (fsm_output[0])) & and_dcpl_36;
  assign and_dcpl_40 = (fsm_output[4:3]==2'b10);
  assign and_dcpl_41 = and_dcpl_40 & and_dcpl_24;
  assign and_dcpl_42 = and_dcpl_41 & and_dcpl_23;
  assign and_dcpl_44 = and_dcpl_40 & (~ (fsm_output[6])) & and_dcpl_28;
  assign and_dcpl_46 = nor_tmp_3 & and_dcpl_24;
  assign and_dcpl_47 = and_dcpl_46 & and_dcpl_23;
  assign and_dcpl_48 = (fsm_output[6:5]==2'b01);
  assign and_dcpl_49 = (~ or_tmp_6) & and_dcpl_48;
  assign and_dcpl_50 = and_dcpl_49 & and_dcpl_23;
  assign and_dcpl_51 = and_dcpl_49 & and_dcpl_28;
  assign and_dcpl_52 = and_dcpl_33 & and_dcpl_48;
  assign and_dcpl_53 = and_dcpl_52 & and_dcpl_23;
  assign and_dcpl_54 = and_dcpl_40 & and_dcpl_48;
  assign and_dcpl_55 = and_dcpl_54 & and_dcpl_23;
  assign and_dcpl_57 = nor_tmp_3 & and_dcpl_48 & and_dcpl_23;
  assign and_dcpl_60 = ~(or_tmp_6 | (fsm_output[6]));
  assign or_dcpl_33 = (fsm_output[5:4]!=2'b00);
  assign and_dcpl_62 = ~((fsm_output[3]) | (fsm_output[6]));
  assign and_dcpl_65 = and_dcpl_20 & (fsm_output[2]);
  assign and_dcpl_71 = (fsm_output[2:1]==2'b01);
  assign and_dcpl_73 = ~(or_tmp_6 | (fsm_output[5]));
  assign and_dcpl_75 = and_dcpl_27 & (~ (fsm_output[2]));
  assign and_dcpl_77 = and_dcpl_41 & and_dcpl_75;
  assign and_dcpl_81 = and_dcpl_37 & (fsm_output[5]) & and_dcpl_75;
  assign and_dcpl_82 = and_dcpl_54 & and_dcpl_75;
  assign and_dcpl_83 = and_dcpl_49 & and_dcpl_75;
  assign and_dcpl_90 = (~ or_tmp_6) & (fsm_output[6:5]==2'b10);
  assign and_dcpl_99 = (~ (fsm_output[6])) & (fsm_output[0]);
  assign and_tmp_1 = (fsm_output[6]) & or_tmp_6;
  assign mux_tmp_41 = MUX_s_1_2_2(and_tmp_1, (fsm_output[6]), fsm_output[5]);
  assign mux_44_nl = MUX_s_1_2_2(mux_tmp_36, mux_tmp_41, fsm_output[1]);
  assign mux_tmp_45 = MUX_s_1_2_2(mux_44_nl, (fsm_output[6]), fsm_output[2]);
  assign and_dcpl_109 = and_dcpl_99 & and_dcpl_71;
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_90 & and_dcpl_23;
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ STAGE_LOOP_i_3_0_sva_2)}) + 5'b00001;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign VEC_LOOP_or_4_cse = and_dcpl_26 | and_dcpl_35;
  assign VEC_LOOP_or_6_cse = and_dcpl_47 | and_dcpl_53 | and_dcpl_57;
  assign VEC_LOOP_or_12_cse = and_dcpl_42 | and_dcpl_47 | and_dcpl_50 | and_dcpl_53
      | and_dcpl_55 | and_dcpl_57;
  assign VEC_LOOP_mux1h_6_nl = MUX1HOT_v_8_4_2((z_out_5[9:2]), (z_out_3[8:1]), (z_out_7[9:2]),
      (z_out_3[7:0]), {VEC_LOOP_or_4_cse , VEC_LOOP_or_1_cse , VEC_LOOP_or_6_cse
      , and_dcpl_50});
  assign VEC_LOOP_mux1h_4_nl = MUX1HOT_s_1_4_2((z_out_5[1]), (z_out_3[0]), (z_out_7[1]),
      (VEC_LOOP_j_10_0_2_sva_9_0[1]), {VEC_LOOP_or_4_cse , VEC_LOOP_or_1_cse , VEC_LOOP_or_6_cse
      , and_dcpl_50});
  assign and_65_nl = and_dcpl_62 & or_dcpl_33 & and_dcpl_23;
  assign VEC_LOOP_mux1h_2_nl = MUX1HOT_s_1_3_2((z_out_5[0]), (VEC_LOOP_j_10_0_2_sva_9_0[0]),
      (z_out_7[0]), {VEC_LOOP_or_4_cse , and_65_nl , VEC_LOOP_or_6_cse});
  assign and_30_nl = and_dcpl_25 & and_dcpl_28;
  assign VEC_LOOP_mux1h_nl = MUX1HOT_v_7_8_2((z_out_3[6:0]), VEC_LOOP_acc_psp_sva,
      (VEC_LOOP_acc_10_cse_1_sva[9:3]), (z_out_7[9:3]), (COMP_LOOP_twiddle_f_mul_cse_6_sva[9:3]),
      (z_out_5[9:3]), (VEC_LOOP_acc_11_psp_sva[8:2]), (COMP_LOOP_5_twiddle_f_mul_psp_sva[7:1]),
      {and_dcpl_26 , and_30_nl , and_dcpl_32 , and_dcpl_35 , and_dcpl_39 , VEC_LOOP_or_12_cse
      , and_dcpl_44 , and_dcpl_51});
  assign and_62_nl = and_dcpl_60 & (~((fsm_output[5]) | (fsm_output[0]))) & (fsm_output[2]);
  assign VEC_LOOP_mux1h_1_nl = MUX1HOT_s_1_7_2((VEC_LOOP_j_10_0_2_sva_9_0[2]), (VEC_LOOP_acc_10_cse_1_sva[2]),
      (z_out_7[2]), (COMP_LOOP_twiddle_f_mul_cse_6_sva[2]), (z_out_5[2]), (VEC_LOOP_acc_11_psp_sva[1]),
      (COMP_LOOP_5_twiddle_f_mul_psp_sva[0]), {and_62_nl , and_dcpl_32 , and_dcpl_35
      , and_dcpl_39 , VEC_LOOP_or_12_cse , and_dcpl_44 , and_dcpl_51});
  assign and_68_nl = (~(or_tmp_6 | (~((~ (fsm_output[5])) | (fsm_output[1]))))) &
      and_dcpl_65;
  assign VEC_LOOP_mux1h_3_nl = MUX1HOT_s_1_6_2((VEC_LOOP_j_10_0_2_sva_9_0[1]), (VEC_LOOP_acc_10_cse_1_sva[1]),
      (z_out_7[1]), (COMP_LOOP_twiddle_f_mul_cse_6_sva[1]), (z_out_5[1]), (VEC_LOOP_acc_11_psp_sva[0]),
      {and_68_nl , and_dcpl_32 , and_dcpl_35 , and_dcpl_39 , VEC_LOOP_or_12_cse ,
      and_dcpl_44});
  assign and_71_nl = ((~((fsm_output[5:4]!=2'b00))) | (fsm_output[1])) & (~ (fsm_output[3]))
      & and_dcpl_65;
  assign VEC_LOOP_mux1h_5_nl = MUX1HOT_s_1_5_2((VEC_LOOP_j_10_0_2_sva_9_0[0]), (VEC_LOOP_acc_10_cse_1_sva[0]),
      (z_out_7[0]), (COMP_LOOP_twiddle_f_mul_cse_6_sva[0]), (z_out_5[0]), {and_71_nl
      , and_dcpl_32 , and_dcpl_35 , and_dcpl_39 , VEC_LOOP_or_12_cse});
  assign vec_rsci_adra_d = {VEC_LOOP_mux1h_6_nl , VEC_LOOP_mux1h_4_nl , VEC_LOOP_mux1h_2_nl
      , VEC_LOOP_mux1h_nl , VEC_LOOP_mux1h_1_nl , VEC_LOOP_mux1h_3_nl , VEC_LOOP_mux1h_5_nl};
  assign vec_rsci_wea_d = vec_rsci_wea_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d = vec_rsci_rwA_rw_ram_ir_internal_WMASK_B_d_reg;
  assign twiddle_rsci_adrb_d = {COMP_LOOP_twiddle_f_mux1h_24_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_6_rmff , COMP_LOOP_twiddle_f_mux1h_17_rmff};
  assign twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d = twiddle_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign twiddle_h_rsci_adrb_d = {COMP_LOOP_twiddle_f_mux1h_24_rmff , COMP_LOOP_twiddle_f_and_rmff
      , COMP_LOOP_twiddle_f_mux1h_6_rmff , COMP_LOOP_twiddle_f_mux1h_17_rmff};
  assign twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d = twiddle_h_rsci_readB_r_ram_ir_internal_RMASK_B_d_reg;
  assign vec_rsci_da_d = vec_rsci_da_d_reg;
  assign and_dcpl_130 = (~ (fsm_output[0])) & (fsm_output[1]) & (~((fsm_output[2])
      | (fsm_output[6])));
  assign and_dcpl_131 = and_dcpl_130 & nor_19_cse & (~ (fsm_output[4]));
  assign and_dcpl_132 = (fsm_output[5]) & (~ (fsm_output[3]));
  assign and_dcpl_134 = and_dcpl_130 & and_dcpl_132 & (~ (fsm_output[4]));
  assign and_dcpl_136 = and_dcpl_130 & and_dcpl_132 & (fsm_output[4]);
  assign and_dcpl_139 = and_dcpl_130 & (fsm_output[5:3]==3'b101);
  assign and_dcpl_140 = (~ (fsm_output[5])) & (fsm_output[3]);
  assign and_dcpl_142 = and_dcpl_130 & and_dcpl_140 & (~ (fsm_output[4]));
  assign and_dcpl_144 = and_dcpl_130 & nor_19_cse & (fsm_output[4]);
  assign and_dcpl_146 = and_dcpl_130 & and_dcpl_140 & (fsm_output[4]);
  assign and_159_cse = and_dcpl_22 & (fsm_output[2]) & (~ (fsm_output[6]));
  assign and_dcpl_154 = (fsm_output[1]) & (fsm_output[0]) & (~ (fsm_output[2])) &
      (~ (fsm_output[6]));
  assign and_dcpl_155 = and_dcpl_154 & and_dcpl_132 & (fsm_output[4]);
  assign and_dcpl_158 = and_dcpl_154 & (fsm_output[5:3]==3'b010);
  assign and_dcpl_160 = and_dcpl_154 & and_dcpl_132 & (~ (fsm_output[4]));
  assign and_dcpl_163 = and_dcpl_154 & (fsm_output[5:3]==3'b101);
  assign and_dcpl_166 = and_dcpl_154 & (fsm_output[5:3]==3'b001);
  assign and_dcpl_172 = and_159_cse & nor_19_cse & (~ (fsm_output[4]));
  assign and_dcpl_175 = and_159_cse & and_dcpl_132 & (~ (fsm_output[4]));
  assign and_dcpl_177 = and_159_cse & nor_19_cse & (fsm_output[4]);
  assign and_dcpl_179 = and_159_cse & and_dcpl_132 & (fsm_output[4]);
  assign and_dcpl_185 = and_dcpl_154 & (fsm_output[5:3]==3'b111);
  assign and_dcpl_188 = and_dcpl_154 & (fsm_output[5:3]==3'b011);
  assign and_225_cse = (fsm_output[5]) & (fsm_output[3]);
  assign and_272_cse = (fsm_output[2:0]==3'b101) & or_dcpl_33 & (~ (fsm_output[6]));
  assign or_tmp_28 = (fsm_output[5:3]!=3'b000);
  assign mux_tmp = MUX_s_1_2_2((~ or_tmp_28), or_tmp_28, fsm_output[6]);
  assign COMP_LOOP_twiddle_f_or_10_itm = and_dcpl_139 | and_dcpl_144;
  assign VEC_LOOP_or_24_itm = and_dcpl_155 | and_dcpl_158 | and_dcpl_160 | and_dcpl_163
      | and_dcpl_166;
  assign VEC_LOOP_or_20_itm = and_dcpl_177 | and_dcpl_179;
  assign VEC_LOOP_or_28_itm = and_dcpl_175 | and_dcpl_188;
  assign and_248_cse_1 = and_159_cse & and_225_cse & (~ (fsm_output[4]));
  assign and_237_cse_1 = and_159_cse & and_dcpl_140 & (~ (fsm_output[4]));
  assign and_252_cse_1 = and_159_cse & and_225_cse & (fsm_output[4]);
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
      reg_run_rsci_oswt_cse <= ~(or_dcpl_31 | or_69_cse | (fsm_output[2]));
      reg_vec_rsci_oswt_cse <= ~ mux_37_itm;
      reg_vec_rsci_oswt_1_cse <= and_22_rmff;
      reg_twiddle_rsci_oswt_cse <= and_75_rmff;
      reg_complete_rsci_oswt_cse <= and_dcpl_90 & and_dcpl_22 & (fsm_output[2]) &
          (~ STAGE_LOOP_acc_itm_4_1);
      reg_vec_rsc_triosy_obj_iswt0_cse <= and_dcpl_90 & and_dcpl_30 & (fsm_output[2]);
      reg_ensig_cgo_cse <= mux_39_rmff;
      reg_ensig_cgo_1_cse <= and_97_rmff;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((and_dcpl_25 & and_dcpl_22 & (~ (fsm_output[2])))
        | STAGE_LOOP_i_3_0_sva_mx0c1) ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b1010, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_43_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      run_ac_sync_tmp_dobj_sva <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (~(or_tmp_6 | (~ (fsm_output[6])) | (fsm_output[5])
        | (~ (fsm_output[0])) | (fsm_output[1]) | (~ (fsm_output[2])))) ) begin
      run_ac_sync_tmp_dobj_sva <= run_rsci_ivld_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & mux_tmp_45 ) begin
      STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_itm;
    end
  end
  always @(posedge clk) begin
    if ( mux_73_nl & complete_rsci_wen_comp ) begin
      COMP_LOOP_k_10_3_sva_6_0 <= MUX_v_7_2_2(7'b0000000, (z_out_4[6:0]), COMP_LOOP_k_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(((and_124_cse | (fsm_output[3:2]!=2'b00)) ^
        (fsm_output[4])) & and_dcpl_24)) ) begin
      COMP_LOOP_1_twiddle_f_acc_cse_sva <= COMP_LOOP_1_twiddle_f_acc_cse_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_52_nl | (fsm_output[6])) ) begin
      COMP_LOOP_5_twiddle_f_mul_psp_sva <= MUX_v_8_2_2((z_out_1[7:0]), (z_out_3[7:0]),
          and_dcpl_50);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_twiddle_help_and_cse ) begin
      COMP_LOOP_twiddle_help_1_sva <= twiddle_h_rsci_qb_d_mxwt;
      COMP_LOOP_twiddle_f_1_sva <= twiddle_rsci_qb_d_mxwt;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (((~ mux_tmp_36) & and_dcpl_75) | and_dcpl_109)
        ) begin
      VEC_LOOP_j_10_0_2_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (VEC_LOOP_j_10_0_1_sva_1[9:0]),
          not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_0_1_sva_1 <= 11'b00000000000;
    end
    else if ( complete_rsci_wen_comp & (~(or_tmp_18 | (fsm_output[2:1]!=2'b10)))
        ) begin
      VEC_LOOP_j_10_0_1_sva_1 <= z_out_2;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (and_dcpl_26 | and_dcpl_35 | and_dcpl_42 | and_dcpl_47
        | and_dcpl_50 | and_dcpl_53 | and_dcpl_55 | and_dcpl_57) ) begin
      VEC_LOOP_acc_10_cse_1_sva <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (~(or_dcpl_31 | or_69_cse | (~ (fsm_output[2]))))
        ) begin
      VEC_LOOP_acc_psp_sva <= z_out_3[6:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_56_nl | (fsm_output[6])) ) begin
      COMP_LOOP_2_twiddle_f_lshift_ncse_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_60_nl | (fsm_output[6])) ) begin
      COMP_LOOP_twiddle_f_mul_cse_6_sva <= MUX_v_10_2_2(z_out_7, z_out_1, VEC_LOOP_or_16_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (mux_69_nl | (fsm_output[6])) ) begin
      COMP_LOOP_3_twiddle_f_lshift_ncse_sva <= MUX_v_9_2_2((z_out[8:0]), (z_out_1[8:0]),
          and_120_nl);
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & VEC_LOOP_or_1_cse ) begin
      VEC_LOOP_acc_11_psp_sva <= z_out_3;
    end
  end
  assign mux_42_nl = MUX_s_1_2_2(mux_tmp_36, mux_tmp_41, or_69_cse);
  assign or_68_nl = (fsm_output[1]) | (fsm_output[0]) | (fsm_output[5]);
  assign mux_40_nl = MUX_s_1_2_2(and_tmp_1, (fsm_output[6]), or_68_nl);
  assign mux_43_nl = MUX_s_1_2_2(mux_42_nl, mux_40_nl, fsm_output[2]);
  assign COMP_LOOP_k_not_nl = ~ mux_tmp_45;
  assign and_nl = (fsm_output[6]) & or_tmp_28;
  assign mux_71_nl = MUX_s_1_2_2(mux_tmp, and_nl, fsm_output[1]);
  assign mux_72_nl = MUX_s_1_2_2(mux_71_nl, (fsm_output[6]), fsm_output[2]);
  assign or_nl = (fsm_output[2:1]!=2'b00);
  assign mux_70_nl = MUX_s_1_2_2(mux_tmp, (fsm_output[6]), or_nl);
  assign mux_73_nl = MUX_s_1_2_2(mux_72_nl, mux_70_nl, fsm_output[0]);
  assign mux_16_nl = MUX_s_1_2_2((~ or_tmp_6), or_tmp_6, fsm_output[5]);
  assign mux_51_nl = MUX_s_1_2_2(mux_16_nl, (fsm_output[5]), and_124_cse);
  assign and_11_nl = (fsm_output[5]) & or_tmp_6;
  assign nor_4_nl = ~((fsm_output[1:0]!=2'b01));
  assign mux_14_nl = MUX_s_1_2_2((fsm_output[5]), and_11_nl, nor_4_nl);
  assign mux_52_nl = MUX_s_1_2_2(mux_51_nl, mux_14_nl, fsm_output[2]);
  assign not_nl = ~ and_dcpl_109;
  assign mux_11_nl = MUX_s_1_2_2((~ (fsm_output[4])), nor_tmp_3, fsm_output[5]);
  assign mux_55_nl = MUX_s_1_2_2(mux_11_nl, mux_8_cse, and_124_cse);
  assign mux_56_nl = MUX_s_1_2_2(mux_55_nl, mux_8_cse, fsm_output[2]);
  assign VEC_LOOP_or_16_nl = and_dcpl_83 | and_dcpl_82;
  assign nand_2_nl = ~((fsm_output[5]) & (fsm_output[3]));
  assign mux_59_nl = MUX_s_1_2_2(nand_2_nl, or_tmp_13, and_124_cse);
  assign mux_27_nl = MUX_s_1_2_2(or_tmp_13, nor_19_cse, fsm_output[0]);
  assign mux_28_nl = MUX_s_1_2_2(mux_27_nl, or_tmp_13, fsm_output[1]);
  assign mux_60_nl = MUX_s_1_2_2(mux_59_nl, mux_28_nl, fsm_output[2]);
  assign and_120_nl = and_dcpl_52 & and_dcpl_27 & (~ (fsm_output[2])) & (VEC_LOOP_j_10_0_1_sva_1[10]);
  assign mux_67_nl = MUX_s_1_2_2(mux_tmp_20, mux_tmp_9, and_124_cse);
  assign mux_68_nl = MUX_s_1_2_2(mux_67_nl, mux_tmp_9, fsm_output[2]);
  assign mux_62_nl = MUX_s_1_2_2((~ nor_tmp_3), (fsm_output[3]), fsm_output[5]);
  assign mux_63_nl = MUX_s_1_2_2(mux_62_nl, mux_tmp_9, fsm_output[0]);
  assign mux_65_nl = MUX_s_1_2_2(mux_tmp_20, mux_63_nl, fsm_output[1]);
  assign mux_66_nl = MUX_s_1_2_2(mux_65_nl, mux_tmp_9, fsm_output[2]);
  assign mux_69_nl = MUX_s_1_2_2(mux_68_nl, mux_66_nl, VEC_LOOP_j_10_0_1_sva_1[10]);
  assign COMP_LOOP_twiddle_f_nor_5_cse = ~(and_dcpl_131 | and_dcpl_139 | and_dcpl_144);
  assign COMP_LOOP_twiddle_f_mux_3_nl = MUX_s_1_2_2((COMP_LOOP_2_twiddle_f_lshift_ncse_sva[9]),
      (z_out[9]), and_dcpl_142);
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl = COMP_LOOP_twiddle_f_mux_3_nl
      & COMP_LOOP_twiddle_f_nor_5_cse;
  assign COMP_LOOP_twiddle_f_or_13_nl = and_dcpl_134 | and_dcpl_136 | and_dcpl_146;
  assign COMP_LOOP_twiddle_f_or_14_nl = and_dcpl_142 | and_dcpl_144;
  assign COMP_LOOP_twiddle_f_mux1h_73_nl = MUX1HOT_v_9_4_2(({1'b0 , COMP_LOOP_5_twiddle_f_lshift_itm}),
      (COMP_LOOP_2_twiddle_f_lshift_ncse_sva[8:0]), COMP_LOOP_3_twiddle_f_lshift_ncse_sva,
      (z_out[8:0]), {and_dcpl_131 , COMP_LOOP_twiddle_f_or_13_nl , and_dcpl_139 ,
      COMP_LOOP_twiddle_f_or_14_nl});
  assign COMP_LOOP_twiddle_f_and_12_nl = (COMP_LOOP_k_10_3_sva_6_0[6]) & COMP_LOOP_twiddle_f_nor_5_cse;
  assign COMP_LOOP_twiddle_f_or_15_nl = and_dcpl_134 | and_dcpl_136 | and_dcpl_142
      | and_dcpl_146;
  assign COMP_LOOP_twiddle_f_mux1h_74_nl = MUX1HOT_v_6_3_2(({1'b0 , (COMP_LOOP_k_10_3_sva_6_0[6:2])}),
      (COMP_LOOP_k_10_3_sva_6_0[5:0]), (COMP_LOOP_k_10_3_sva_6_0[6:1]), {and_dcpl_131
      , COMP_LOOP_twiddle_f_or_15_nl , COMP_LOOP_twiddle_f_or_10_itm});
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl = MUX_s_1_2_2((COMP_LOOP_k_10_3_sva_6_0[1]),
      (COMP_LOOP_k_10_3_sva_6_0[0]), COMP_LOOP_twiddle_f_or_10_itm);
  assign COMP_LOOP_twiddle_f_or_16_nl = (COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_mux_4_nl
      & (~(and_dcpl_142 | and_dcpl_146))) | and_dcpl_134 | and_dcpl_136;
  assign COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_1_nl = ((COMP_LOOP_k_10_3_sva_6_0[0])
      & (~(and_dcpl_134 | and_dcpl_142 | and_dcpl_144))) | and_dcpl_136 | and_dcpl_139
      | and_dcpl_146;
  assign nl_z_out_1 = ({COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_and_1_nl , COMP_LOOP_twiddle_f_mux1h_73_nl})
      * ({COMP_LOOP_twiddle_f_and_12_nl , COMP_LOOP_twiddle_f_mux1h_74_nl , COMP_LOOP_twiddle_f_or_16_nl
      , COMP_LOOP_twiddle_f_COMP_LOOP_twiddle_f_or_1_nl , 1'b1});
  assign z_out_1 = nl_z_out_1[9:0];
  assign VEC_LOOP_VEC_LOOP_or_6_nl = (STAGE_LOOP_lshift_psp_sva[10]) | and_dcpl_155
      | and_dcpl_158 | and_dcpl_160 | and_dcpl_163 | and_dcpl_166;
  assign VEC_LOOP_VEC_LOOP_mux_5_nl = MUX_v_10_2_2((STAGE_LOOP_lshift_psp_sva[9:0]),
      (~ (STAGE_LOOP_lshift_psp_sva[10:1])), VEC_LOOP_or_24_itm);
  assign VEC_LOOP_or_33_nl = (~ and_159_cse) | and_dcpl_155 | and_dcpl_158 | and_dcpl_160
      | and_dcpl_163 | and_dcpl_166;
  assign VEC_LOOP_VEC_LOOP_mux_6_nl = MUX_v_7_2_2((VEC_LOOP_j_10_0_2_sva_9_0[9:3]),
      COMP_LOOP_k_10_3_sva_6_0, VEC_LOOP_or_24_itm);
  assign VEC_LOOP_VEC_LOOP_or_7_nl = ((VEC_LOOP_j_10_0_2_sva_9_0[2]) & (~(and_dcpl_158
      | and_dcpl_166))) | and_dcpl_155 | and_dcpl_160 | and_dcpl_163;
  assign VEC_LOOP_VEC_LOOP_or_8_nl = ((VEC_LOOP_j_10_0_2_sva_9_0[1]) & (~(and_dcpl_160
      | and_dcpl_163 | and_dcpl_166))) | and_dcpl_155 | and_dcpl_158;
  assign VEC_LOOP_VEC_LOOP_or_9_nl = ((VEC_LOOP_j_10_0_2_sva_9_0[0]) & (~(and_dcpl_155
      | and_dcpl_158 | and_dcpl_160))) | and_dcpl_163 | and_dcpl_166;
  assign nl_acc_nl = ({VEC_LOOP_VEC_LOOP_or_6_nl , VEC_LOOP_VEC_LOOP_mux_5_nl , VEC_LOOP_or_33_nl})
      + conv_u2u_11_12({VEC_LOOP_VEC_LOOP_mux_6_nl , VEC_LOOP_VEC_LOOP_or_7_nl ,
      VEC_LOOP_VEC_LOOP_or_8_nl , VEC_LOOP_VEC_LOOP_or_9_nl , 1'b1});
  assign acc_nl = nl_acc_nl[11:0];
  assign z_out_2 = readslicef_12_11_1(acc_nl);
  assign VEC_LOOP_mux1h_21_nl = MUX1HOT_v_9_5_2(({2'b00 , (VEC_LOOP_j_10_0_2_sva_9_0[9:3])}),
      ({1'b0 , (VEC_LOOP_j_10_0_2_sva_9_0[9:2])}), (VEC_LOOP_j_10_0_2_sva_9_0[9:1]),
      ({2'b01 , (~ (STAGE_LOOP_lshift_psp_sva[10:4]))}), ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:3]))}),
      {and_dcpl_172 , and_dcpl_175 , VEC_LOOP_or_20_itm , and_dcpl_185 , and_dcpl_188});
  assign VEC_LOOP_or_34_nl = (~(and_dcpl_172 | and_dcpl_175 | and_dcpl_177 | and_dcpl_179))
      | and_dcpl_185 | and_dcpl_188;
  assign VEC_LOOP_VEC_LOOP_and_1_nl = (COMP_LOOP_k_10_3_sva_6_0[6]) & (~(and_dcpl_172
      | and_dcpl_175 | and_dcpl_185 | and_dcpl_188));
  assign VEC_LOOP_VEC_LOOP_mux_7_nl = MUX_s_1_2_2((COMP_LOOP_k_10_3_sva_6_0[6]),
      (COMP_LOOP_k_10_3_sva_6_0[5]), VEC_LOOP_or_20_itm);
  assign VEC_LOOP_and_12_nl = VEC_LOOP_VEC_LOOP_mux_7_nl & (~(and_dcpl_172 | and_dcpl_185));
  assign VEC_LOOP_or_35_nl = and_dcpl_172 | and_dcpl_185;
  assign VEC_LOOP_mux1h_22_nl = MUX1HOT_v_5_3_2((COMP_LOOP_k_10_3_sva_6_0[6:2]),
      (COMP_LOOP_k_10_3_sva_6_0[5:1]), (COMP_LOOP_k_10_3_sva_6_0[4:0]), {VEC_LOOP_or_35_nl
      , VEC_LOOP_or_28_itm , VEC_LOOP_or_20_itm});
  assign VEC_LOOP_mux_24_nl = MUX_s_1_2_2((COMP_LOOP_k_10_3_sva_6_0[1]), (COMP_LOOP_k_10_3_sva_6_0[0]),
      VEC_LOOP_or_28_itm);
  assign VEC_LOOP_VEC_LOOP_or_10_nl = (VEC_LOOP_mux_24_nl & (~ and_dcpl_177)) | and_dcpl_179;
  assign VEC_LOOP_VEC_LOOP_or_11_nl = ((COMP_LOOP_k_10_3_sva_6_0[0]) & (~ and_dcpl_188))
      | and_dcpl_175 | and_dcpl_177 | and_dcpl_179;
  assign nl_acc_1_nl = ({VEC_LOOP_mux1h_21_nl , VEC_LOOP_or_34_nl}) + ({VEC_LOOP_VEC_LOOP_and_1_nl
      , VEC_LOOP_and_12_nl , VEC_LOOP_mux1h_22_nl , VEC_LOOP_VEC_LOOP_or_10_nl ,
      VEC_LOOP_VEC_LOOP_or_11_nl , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[9:0];
  assign z_out_3 = readslicef_10_9_1(acc_1_nl);
  assign and_281_nl = (fsm_output==7'b1000011);
  assign VEC_LOOP_mux_25_nl = MUX_v_7_2_2((STAGE_LOOP_lshift_psp_sva[10:4]), 7'b0000001,
      and_281_nl);
  assign nl_z_out_4 = conv_u2u_7_8(COMP_LOOP_k_10_3_sva_6_0) + conv_u2u_7_8(VEC_LOOP_mux_25_nl);
  assign z_out_4 = nl_z_out_4[7:0];
  assign and_284_cse = and_159_cse & and_dcpl_140 & (fsm_output[4]);
  assign and_289_nl = and_159_cse & (fsm_output[5:3]==3'b010);
  assign VEC_LOOP_mux1h_23_nl = MUX1HOT_v_3_6_2(3'b001, 3'b010, 3'b011, 3'b100, 3'b101,
      3'b110, {and_237_cse_1 , and_289_nl , and_284_cse , and_dcpl_175 , and_248_cse_1
      , and_dcpl_179});
  assign VEC_LOOP_or_37_nl = MUX_v_3_2_2(VEC_LOOP_mux1h_23_nl, 3'b111, and_252_cse_1);
  assign nl_VEC_LOOP_acc_24_nl = ({COMP_LOOP_k_10_3_sva_6_0 , VEC_LOOP_or_37_nl})
      + (STAGE_LOOP_lshift_psp_sva[10:1]);
  assign VEC_LOOP_acc_24_nl = nl_VEC_LOOP_acc_24_nl[9:0];
  assign VEC_LOOP_or_36_nl = and_237_cse_1 | and_dcpl_177 | and_284_cse | and_dcpl_175
      | and_248_cse_1 | and_dcpl_179 | and_252_cse_1;
  assign VEC_LOOP_VEC_LOOP_mux_8_nl = MUX_v_10_2_2(({(z_out_4[6:0]) , (STAGE_LOOP_lshift_psp_sva[3:1])}),
      VEC_LOOP_acc_24_nl, VEC_LOOP_or_36_nl);
  assign nl_z_out_5 = VEC_LOOP_VEC_LOOP_mux_8_nl + VEC_LOOP_j_10_0_2_sva_9_0;
  assign z_out_5 = nl_z_out_5[9:0];
  assign VEC_LOOP_mux_26_nl = MUX_v_2_2_2(2'b10, 2'b01, and_248_cse_1);
  assign VEC_LOOP_VEC_LOOP_VEC_LOOP_nor_1_nl = ~(MUX_v_2_2_2(VEC_LOOP_mux_26_nl,
      2'b11, and_237_cse_1));
  assign VEC_LOOP_or_38_nl = MUX_v_2_2_2(VEC_LOOP_VEC_LOOP_VEC_LOOP_nor_1_nl, 2'b11,
      and_252_cse_1);
  assign nl_z_out_7 = VEC_LOOP_j_10_0_2_sva_9_0 + ({COMP_LOOP_k_10_3_sva_6_0 , VEC_LOOP_or_38_nl
      , 1'b1});
  assign z_out_7 = nl_z_out_7[9:0];
  assign VEC_LOOP_mux_27_cse = MUX_v_32_2_2((vec_rsci_qa_d_mxwt[31:0]), (vec_rsci_qa_d_mxwt[63:32]),
      and_272_cse);

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


  function automatic [6:0] MUX1HOT_v_7_8_2;
    input [6:0] input_7;
    input [6:0] input_6;
    input [6:0] input_5;
    input [6:0] input_4;
    input [6:0] input_3;
    input [6:0] input_2;
    input [6:0] input_1;
    input [6:0] input_0;
    input [7:0] sel;
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
    MUX1HOT_v_7_8_2 = result;
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


  function automatic [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
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



