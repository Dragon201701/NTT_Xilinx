
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

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_shift_r_beh_v5.v 
module mgc_shift_r_v5(a,s,z);
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
       assign z = fshr_u(a,s,a[width_a-1]);
     end
     else
     begin: UNSGNED
       assign z = fshr_u(a,s,1'b0);
     end
   endgenerate

   //Shift right - unsigned shift argument
   function [width_z-1:0] fshr_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = signd_a ? width_a : width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg signed [len-1:0] result;
      reg signed [len-1:0] result_t;
      begin
        result_t = $signed( {(len){sbit}} );
        result_t[width_a-1:0] = arg1;
        result = result_t >>> arg2;
        fshr_u =  result[olen-1:0];
      end
   endfunction // fshl_u

endmodule

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   ls5382@newnano.poly.edu
//  Generated date: Wed Sep 15 16:02:09 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_21_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_21_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_20_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_20_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_19_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_19_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_18_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_18_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_17_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_17_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_16_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_16_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_15_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_15_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_14_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_14_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_13_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_13_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_12_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_12_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_11_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_11_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_10_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_10_14_32_16384_16384_32_1_gen
    (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_9_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_9_14_32_16384_16384_32_1_gen (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_8_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_8_14_32_16384_16384_32_1_gen (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_7_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_7_14_32_16384_16384_32_1_gen (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_5_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_5_14_32_16384_16384_32_1_gen (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_4_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_4_14_32_16384_16384_32_1_gen (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_1_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_1_14_32_16384_16384_32_1_gen (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
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
//  Design Unit:    ntt_flat_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module ntt_flat_core_core_fsm (
  clk, rst, fsm_output, for_C_0_tr0, INNER_LOOP_C_2_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input for_C_0_tr0;
  input INNER_LOOP_C_2_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for ntt_flat_core_core_fsm_1
  parameter
    main_C_0 = 3'd0,
    for_C_0 = 3'd1,
    STAGE_LOOP_C_0 = 3'd2,
    INNER_LOOP_C_0 = 3'd3,
    INNER_LOOP_C_1 = 3'd4,
    INNER_LOOP_C_2 = 3'd5,
    STAGE_LOOP_C_1 = 3'd6,
    main_C_1 = 3'd7;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : ntt_flat_core_core_fsm_1
    case (state_var)
      for_C_0 : begin
        fsm_output = 8'b00000010;
        if ( for_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_0;
        end
        else begin
          state_var_NS = for_C_0;
        end
      end
      STAGE_LOOP_C_0 : begin
        fsm_output = 8'b00000100;
        state_var_NS = INNER_LOOP_C_0;
      end
      INNER_LOOP_C_0 : begin
        fsm_output = 8'b00001000;
        state_var_NS = INNER_LOOP_C_1;
      end
      INNER_LOOP_C_1 : begin
        fsm_output = 8'b00010000;
        state_var_NS = INNER_LOOP_C_2;
      end
      INNER_LOOP_C_2 : begin
        fsm_output = 8'b00100000;
        if ( INNER_LOOP_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = INNER_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 8'b01000000;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 8'b10000000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 8'b00000001;
        state_var_NS = for_C_0;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= main_C_0;
    end
    else begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    ntt_flat_core_wait_dp
// ------------------------------------------------------------------


module ntt_flat_core_wait_dp (
  clk, ensig_cgo_iro, mult_z_mul_cmp_z, ensig_cgo, mult_t_mul_cmp_en, mult_z_mul_cmp_z_oreg
);
  input clk;
  input ensig_cgo_iro;
  input [31:0] mult_z_mul_cmp_z;
  input ensig_cgo;
  output mult_t_mul_cmp_en;
  output [31:0] mult_z_mul_cmp_z_oreg;
  reg [31:0] mult_z_mul_cmp_z_oreg;



  // Interconnect Declarations for Component Instantiations 
  assign mult_t_mul_cmp_en = ensig_cgo | ensig_cgo_iro;
  always @(posedge clk) begin
    mult_z_mul_cmp_z_oreg <= mult_z_mul_cmp_z;
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    ntt_flat_core
// ------------------------------------------------------------------


module ntt_flat_core (
  clk, rst, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_triosy_lz, twiddle_rsc_triosy_lz,
      twiddle_h_rsc_triosy_lz, result_rsc_triosy_0_0_lz, result_rsc_triosy_1_0_lz,
      result_rsc_triosy_2_0_lz, result_rsc_triosy_3_0_lz, result_rsc_triosy_4_0_lz,
      result_rsc_triosy_5_0_lz, result_rsc_triosy_6_0_lz, result_rsc_triosy_7_0_lz,
      result_rsc_triosy_8_0_lz, result_rsc_triosy_9_0_lz, result_rsc_triosy_10_0_lz,
      result_rsc_triosy_11_0_lz, result_rsc_triosy_12_0_lz, result_rsc_triosy_13_0_lz,
      result_rsc_triosy_14_0_lz, vec_rsci_adra_d, vec_rsci_qa_d, vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      twiddle_rsci_qa_d, twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d, twiddle_h_rsci_qa_d,
      twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d, result_rsc_0_0_i_adra_d, result_rsc_0_0_i_da_d,
      result_rsc_0_0_i_qa_d, result_rsc_0_0_i_wea_d, result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_1_0_i_adra_d,
      result_rsc_1_0_i_qa_d, result_rsc_1_0_i_wea_d, result_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_2_0_i_adra_d,
      result_rsc_2_0_i_qa_d, result_rsc_2_0_i_wea_d, result_rsc_2_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_2_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_3_0_i_adra_d,
      result_rsc_3_0_i_qa_d, result_rsc_3_0_i_wea_d, result_rsc_3_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_3_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_4_0_i_adra_d,
      result_rsc_4_0_i_qa_d, result_rsc_4_0_i_wea_d, result_rsc_4_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_4_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_5_0_i_adra_d,
      result_rsc_5_0_i_qa_d, result_rsc_5_0_i_wea_d, result_rsc_5_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_5_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_6_0_i_adra_d,
      result_rsc_6_0_i_qa_d, result_rsc_6_0_i_wea_d, result_rsc_6_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_6_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_7_0_i_adra_d,
      result_rsc_7_0_i_qa_d, result_rsc_7_0_i_wea_d, result_rsc_7_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_7_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_8_0_i_adra_d,
      result_rsc_8_0_i_qa_d, result_rsc_8_0_i_wea_d, result_rsc_8_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_8_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_9_0_i_adra_d,
      result_rsc_9_0_i_qa_d, result_rsc_9_0_i_wea_d, result_rsc_9_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_9_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_10_0_i_adra_d,
      result_rsc_10_0_i_qa_d, result_rsc_10_0_i_wea_d, result_rsc_10_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_10_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_11_0_i_adra_d,
      result_rsc_11_0_i_qa_d, result_rsc_11_0_i_wea_d, result_rsc_11_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_11_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_12_0_i_adra_d,
      result_rsc_12_0_i_qa_d, result_rsc_12_0_i_wea_d, result_rsc_12_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_12_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_13_0_i_adra_d,
      result_rsc_13_0_i_qa_d, result_rsc_13_0_i_wea_d, result_rsc_13_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_13_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, result_rsc_14_0_i_adra_d,
      result_rsc_14_0_i_qa_d, result_rsc_14_0_i_wea_d, result_rsc_14_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      result_rsc_14_0_i_rwA_rw_ram_ir_internal_WMASK_B_d, mult_z_mul_cmp_a, mult_z_mul_cmp_b,
      mult_z_mul_cmp_z, twiddle_rsci_adra_d_pff, result_rsc_1_0_i_da_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_lz;
  output twiddle_h_rsc_triosy_lz;
  output result_rsc_triosy_0_0_lz;
  output result_rsc_triosy_1_0_lz;
  output result_rsc_triosy_2_0_lz;
  output result_rsc_triosy_3_0_lz;
  output result_rsc_triosy_4_0_lz;
  output result_rsc_triosy_5_0_lz;
  output result_rsc_triosy_6_0_lz;
  output result_rsc_triosy_7_0_lz;
  output result_rsc_triosy_8_0_lz;
  output result_rsc_triosy_9_0_lz;
  output result_rsc_triosy_10_0_lz;
  output result_rsc_triosy_11_0_lz;
  output result_rsc_triosy_12_0_lz;
  output result_rsc_triosy_13_0_lz;
  output result_rsc_triosy_14_0_lz;
  output [13:0] vec_rsci_adra_d;
  input [63:0] vec_rsci_qa_d;
  output [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_rsci_qa_d;
  output [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_h_rsci_qa_d;
  output [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [27:0] result_rsc_0_0_i_adra_d;
  output [31:0] result_rsc_0_0_i_da_d;
  input [63:0] result_rsc_0_0_i_qa_d;
  output [1:0] result_rsc_0_0_i_wea_d;
  output [1:0] result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_1_0_i_adra_d;
  input [63:0] result_rsc_1_0_i_qa_d;
  output [1:0] result_rsc_1_0_i_wea_d;
  output [1:0] result_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_2_0_i_adra_d;
  input [63:0] result_rsc_2_0_i_qa_d;
  output [1:0] result_rsc_2_0_i_wea_d;
  output [1:0] result_rsc_2_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_2_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_3_0_i_adra_d;
  input [63:0] result_rsc_3_0_i_qa_d;
  output [1:0] result_rsc_3_0_i_wea_d;
  output [1:0] result_rsc_3_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_3_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_4_0_i_adra_d;
  input [63:0] result_rsc_4_0_i_qa_d;
  output [1:0] result_rsc_4_0_i_wea_d;
  output [1:0] result_rsc_4_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_4_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_5_0_i_adra_d;
  input [63:0] result_rsc_5_0_i_qa_d;
  output [1:0] result_rsc_5_0_i_wea_d;
  output [1:0] result_rsc_5_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_5_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_6_0_i_adra_d;
  input [63:0] result_rsc_6_0_i_qa_d;
  output [1:0] result_rsc_6_0_i_wea_d;
  output [1:0] result_rsc_6_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_6_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_7_0_i_adra_d;
  input [63:0] result_rsc_7_0_i_qa_d;
  output [1:0] result_rsc_7_0_i_wea_d;
  output [1:0] result_rsc_7_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_7_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_8_0_i_adra_d;
  input [63:0] result_rsc_8_0_i_qa_d;
  output [1:0] result_rsc_8_0_i_wea_d;
  output [1:0] result_rsc_8_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_8_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_9_0_i_adra_d;
  input [63:0] result_rsc_9_0_i_qa_d;
  output [1:0] result_rsc_9_0_i_wea_d;
  output [1:0] result_rsc_9_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_9_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_10_0_i_adra_d;
  input [63:0] result_rsc_10_0_i_qa_d;
  output [1:0] result_rsc_10_0_i_wea_d;
  output [1:0] result_rsc_10_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_10_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_11_0_i_adra_d;
  input [63:0] result_rsc_11_0_i_qa_d;
  output [1:0] result_rsc_11_0_i_wea_d;
  output [1:0] result_rsc_11_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_11_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_12_0_i_adra_d;
  input [63:0] result_rsc_12_0_i_qa_d;
  output [1:0] result_rsc_12_0_i_wea_d;
  output [1:0] result_rsc_12_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_12_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_13_0_i_adra_d;
  input [63:0] result_rsc_13_0_i_qa_d;
  output [1:0] result_rsc_13_0_i_wea_d;
  output [1:0] result_rsc_13_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_13_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] result_rsc_14_0_i_adra_d;
  input [63:0] result_rsc_14_0_i_qa_d;
  output [1:0] result_rsc_14_0_i_wea_d;
  output [1:0] result_rsc_14_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] result_rsc_14_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [31:0] mult_z_mul_cmp_a;
  reg [31:0] mult_z_mul_cmp_a;
  output [31:0] mult_z_mul_cmp_b;
  reg [31:0] mult_z_mul_cmp_b;
  input [31:0] mult_z_mul_cmp_z;
  output [13:0] twiddle_rsci_adra_d_pff;
  output [31:0] result_rsc_1_0_i_da_d_pff;


  // Interconnect Declarations
  wire [31:0] p_rsci_idat;
  wire mult_t_mul_cmp_en;
  wire [51:0] mult_t_mul_cmp_z;
  wire [31:0] mult_z_mul_cmp_z_oreg;
  wire [7:0] fsm_output;
  wire [3:0] butterFly_f2_acc_1_tmp;
  wire [4:0] nl_butterFly_f2_acc_1_tmp;
  wire [3:0] butterFly_f1_acc_1_tmp;
  wire [4:0] nl_butterFly_f1_acc_1_tmp;
  wire or_dcpl_38;
  wire or_dcpl_39;
  wire and_dcpl_19;
  wire and_dcpl_20;
  wire and_dcpl_21;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_25;
  wire or_tmp_3;
  wire and_dcpl_31;
  wire and_dcpl_33;
  wire or_dcpl_41;
  wire or_dcpl_42;
  wire or_dcpl_44;
  wire or_dcpl_45;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_39;
  wire or_tmp_5;
  wire and_dcpl_43;
  wire and_dcpl_44;
  wire or_dcpl_47;
  wire or_dcpl_49;
  wire or_dcpl_50;
  wire and_dcpl_47;
  wire and_dcpl_49;
  wire or_tmp_7;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire or_dcpl_52;
  wire or_dcpl_54;
  wire and_dcpl_57;
  wire or_tmp_9;
  wire and_dcpl_61;
  wire and_dcpl_62;
  wire or_dcpl_57;
  wire or_dcpl_58;
  wire and_dcpl_65;
  wire and_dcpl_67;
  wire or_tmp_12;
  wire not_tmp_65;
  wire or_dcpl_60;
  wire or_dcpl_62;
  wire or_tmp_16;
  wire not_tmp_67;
  wire or_dcpl_65;
  wire or_dcpl_66;
  wire and_dcpl_80;
  wire not_tmp_68;
  wire or_tmp_19;
  wire not_tmp_70;
  wire or_dcpl_69;
  wire or_dcpl_73;
  wire and_dcpl_91;
  wire and_dcpl_93;
  wire and_dcpl_94;
  wire and_dcpl_98;
  wire and_dcpl_99;
  wire or_dcpl_75;
  wire or_dcpl_77;
  wire or_dcpl_78;
  wire and_dcpl_103;
  wire and_dcpl_107;
  wire or_dcpl_80;
  wire or_dcpl_82;
  wire and_dcpl_113;
  wire or_dcpl_85;
  wire or_dcpl_88;
  wire and_dcpl_122;
  wire or_dcpl_91;
  wire or_dcpl_94;
  wire or_dcpl_97;
  wire or_dcpl_98;
  wire or_dcpl_99;
  wire or_dcpl_103;
  wire or_tmp_169;
  wire [31:0] modulo_sub_base_sva_1;
  wire [32:0] nl_modulo_sub_base_sva_1;
  wire [13:0] INNER_LOOP_j_13_0_sva_2;
  wire [14:0] nl_INNER_LOOP_j_13_0_sva_2;
  reg INNER_LOOP_stage_0;
  reg INNER_LOOP_stage_0_1;
  reg [3:0] butterFly_acc_itm_3;
  reg [3:0] butterFly_acc_itm_2;
  reg [3:0] butterFly_acc_4_itm_3;
  reg [3:0] butterFly_acc_4_itm_2;
  reg INNER_LOOP_stage_0_3;
  reg [3:0] butterFly_acc_itm_1;
  wire [4:0] nl_butterFly_acc_itm_1;
  reg [3:0] butterFly_acc_4_itm_1;
  wire [4:0] nl_butterFly_acc_4_itm_1;
  reg INNER_LOOP_stage_0_2;
  reg INNER_LOOP_stage_0_4;
  reg [3:0] butterFly_acc_4_itm_4;
  reg [31:0] p_sva;
  wire [31:0] modulo_add_base_sva_1;
  wire [32:0] nl_modulo_add_base_sva_1;
  wire [31:0] mult_res_sva_1;
  wire [32:0] nl_mult_res_sva_1;
  reg reg_vec_rsc_triosy_obj_ld_cse;
  reg reg_ensig_cgo_cse;
  wire and_517_cse;
  wire INNER_LOOP_or_1_cse;
  wire or_85_cse;
  wire butterFly_f1_nor_9_cse;
  wire or_123_cse;
  wire and_161_rmff;
  wire or_146_rmff;
  wire or_154_rmff;
  wire or_161_rmff;
  wire or_168_rmff;
  wire or_175_rmff;
  wire or_182_rmff;
  wire or_189_rmff;
  wire or_196_rmff;
  wire or_203_rmff;
  wire or_210_rmff;
  wire or_217_rmff;
  wire or_224_rmff;
  wire or_231_rmff;
  wire or_238_rmff;
  wire or_245_rmff;
  wire or_250_rmff;
  wire for_or_13_seb;
  wire for_or_12_seb;
  wire for_or_11_seb;
  wire for_or_10_seb;
  wire for_or_9_seb;
  wire for_or_8_seb;
  wire for_or_7_seb;
  wire for_or_6_seb;
  wire for_or_5_seb;
  wire for_or_4_seb;
  wire for_or_3_seb;
  wire for_or_2_seb;
  wire for_or_1_seb;
  wire for_or_seb;
  reg [31:0] INNER_LOOP_tf_h_slc_twiddle_h_rsci_qa_d_31_0_itm;
  wire result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_mx0c0;
  reg [31:0] mult_res_lpi_3_dfm_1;
  reg [31:0] modulo_add_qr_lpi_3_dfm_2;
  reg [13:0] butterFly_idx2_17_0_sva_2_13_0;
  reg [13:0] butterFly_idx2_17_0_sva_3_13_0;
  reg [13:0] butterFly_idx2_17_0_sva_4_13_0;
  reg [12:0] INNER_LOOP_idx1_acc_psp_sva_3_12_0;
  reg INNER_LOOP_k_17_0_sva_3_0;
  reg [13:0] INNER_LOOP_tf_mul_cse_sva;
  wire signed [28:0] nl_INNER_LOOP_tf_mul_cse_sva;
  wire [13:0] operator_33_true_lshift_itm;
  wire [17:0] INNER_LOOP_k_lshift_itm;
  wire [31:0] modulo_sub_qelse_mux_itm;
  wire [13:0] z_out;
  wire [14:0] z_out_1;
  wire [15:0] nl_z_out_1;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] operator_20_false_acc_psp_sva;
  wire [4:0] nl_operator_20_false_acc_psp_sva;
  reg [13:0] operator_33_true_return_13_0_sva;
  reg [13:0] operator_20_false_rshift_psp_sva;
  reg [17:0] INNER_LOOP_k_17_0_sva;
  wire [18:0] nl_INNER_LOOP_k_17_0_sva;
  reg [31:0] tmp_lpi_3_dfm;
  reg [31:0] tmp_1_lpi_3_dfm;
  reg [31:0] modulo_add_qr_lpi_3_dfm;
  reg [31:0] mult_res_lpi_3_dfm;
  reg INNER_LOOP_stage_0_5;
  reg [16:0] INNER_LOOP_idx1_mul_itm;
  wire [26:0] nl_INNER_LOOP_idx1_mul_itm;
  reg [31:0] INNER_LOOP_tf_slc_twiddle_rsci_qa_d_31_0_itm;
  reg [3:0] butterFly_f1_acc_1_svs_1;
  reg [3:0] butterFly_f2_acc_1_svs_1;
  reg [31:0] modulo_add_qr_lpi_3_dfm_1;
  reg butterFly_f1_butterFly_f1_nor_itm_1;
  reg butterFly_f1_nor_itm_1;
  reg butterFly_f1_nor_1_itm_1;
  reg butterFly_f1_butterFly_f1_and_2_itm_1;
  reg butterFly_f1_nor_3_itm_1;
  reg butterFly_f1_butterFly_f1_and_4_itm_1;
  reg butterFly_f1_butterFly_f1_and_5_itm_1;
  reg butterFly_f1_butterFly_f1_and_6_itm_1;
  reg butterFly_f1_nor_6_itm_1;
  reg butterFly_f1_butterFly_f1_and_8_itm_1;
  reg butterFly_f1_butterFly_f1_and_9_itm_1;
  reg butterFly_f1_butterFly_f1_and_10_itm_1;
  reg butterFly_f1_butterFly_f1_and_11_itm_1;
  reg butterFly_f1_butterFly_f1_and_12_itm_1;
  reg butterFly_f1_butterFly_f1_and_13_itm_1;
  reg butterFly_f2_butterFly_f2_nor_itm_1;
  reg butterFly_f2_nor_itm_1;
  reg butterFly_f2_nor_1_itm_1;
  reg butterFly_f2_butterFly_f2_and_2_itm_1;
  reg butterFly_f2_nor_3_itm_1;
  reg butterFly_f2_butterFly_f2_and_4_itm_1;
  reg butterFly_f2_butterFly_f2_and_5_itm_1;
  reg butterFly_f2_butterFly_f2_and_6_itm_1;
  reg butterFly_f2_nor_6_itm_1;
  reg butterFly_f2_butterFly_f2_and_8_itm_1;
  reg butterFly_f2_butterFly_f2_and_9_itm_1;
  reg butterFly_f2_butterFly_f2_and_10_itm_1;
  reg butterFly_f2_butterFly_f2_and_11_itm_1;
  reg butterFly_f2_butterFly_f2_and_12_itm_1;
  reg butterFly_f2_butterFly_f2_and_13_itm_1;
  reg [31:0] mult_z_asn_itm_1;
  reg [12:0] INNER_LOOP_j_13_0_sva_12_0;
  reg INNER_LOOP_k_17_0_sva_1_0;
  reg INNER_LOOP_k_17_0_sva_2_0;
  reg [12:0] INNER_LOOP_idx1_acc_psp_sva_1_12_0;
  reg [12:0] INNER_LOOP_idx1_acc_psp_sva_2_12_0;
  reg [13:0] butterFly_idx2_17_0_sva_1_13_0;
  wire [16:0] INNER_LOOP_idx1_acc_psp_sva_1;
  wire [17:0] nl_INNER_LOOP_idx1_acc_psp_sva_1;
  wire [17:0] butterFly_idx2_17_0_sva_1;
  wire [18:0] nl_butterFly_idx2_17_0_sva_1;
  wire [12:0] for_mux1h_7_itm;
  wire for_mux1h_39_itm;
  wire operator_20_false_acc_itm_4_1;

  wire[0:0] mux_1_nl;
  wire[0:0] and_47_nl;
  wire[0:0] mux_2_nl;
  wire[0:0] and_58_nl;
  wire[0:0] mux_3_nl;
  wire[0:0] and_68_nl;
  wire[0:0] mux_5_nl;
  wire[0:0] mux_4_nl;
  wire[0:0] or_69_nl;
  wire[0:0] mux_7_nl;
  wire[0:0] mux_6_nl;
  wire[0:0] or_77_nl;
  wire[0:0] mux_9_nl;
  wire[0:0] mux_8_nl;
  wire[0:0] mux_10_nl;
  wire[0:0] nor_6_nl;
  wire[0:0] mux_11_nl;
  wire[0:0] and_105_nl;
  wire[0:0] mux_12_nl;
  wire[0:0] and_115_nl;
  wire[0:0] mux_13_nl;
  wire[0:0] and_123_nl;
  wire[0:0] mux_14_nl;
  wire[0:0] and_130_nl;
  wire[0:0] mux_16_nl;
  wire[0:0] mux_15_nl;
  wire[0:0] or_115_nl;
  wire[0:0] mux_18_nl;
  wire[0:0] mux_17_nl;
  wire[0:0] or_119_nl;
  wire[0:0] mux_20_nl;
  wire[0:0] mux_19_nl;
  wire[0:0] butterFly_mux_nl;
  wire[0:0] INNER_LOOP_INNER_LOOP_and_nl;
  wire[0:0] or_256_nl;
  wire[13:0] for_i_for_i_mux_nl;
  wire[0:0] INNER_LOOP_nor_nl;
  wire[0:0] INNER_LOOP_j_or_nl;
  wire[0:0] butterFly_f2_butterFly_f2_and_nl;
  wire[0:0] butterFly_f2_butterFly_f2_and_1_nl;
  wire[0:0] butterFly_f2_butterFly_f2_and_3_nl;
  wire[0:0] butterFly_f2_butterFly_f2_and_7_nl;
  wire[0:0] butterFly_f1_butterFly_f1_and_nl;
  wire[0:0] butterFly_f1_butterFly_f1_and_1_nl;
  wire[0:0] butterFly_f1_butterFly_f1_and_3_nl;
  wire[0:0] butterFly_f1_butterFly_f1_and_7_nl;
  wire[31:0] mult_if_acc_nl;
  wire[32:0] nl_mult_if_acc_nl;
  wire[32:0] mult_if_acc_1_nl;
  wire[33:0] nl_mult_if_acc_1_nl;
  wire[31:0] modulo_add_qif_acc_nl;
  wire[32:0] nl_modulo_add_qif_acc_nl;
  wire[32:0] modulo_add_acc_1_nl;
  wire[33:0] nl_modulo_add_acc_1_nl;
  wire[31:0] modulo_sub_qif_acc_nl;
  wire[32:0] nl_modulo_sub_qif_acc_nl;
  wire[4:0] operator_20_false_acc_nl;
  wire[5:0] nl_operator_20_false_acc_nl;
  wire[0:0] mux_nl;
  wire[0:0] and_32_nl;
  wire[0:0] and_159_nl;
  wire[13:0] for_mux1h_3_nl;
  wire[0:0] for_for_for_nor_14_nl;
  wire[0:0] for_for_for_nor_15_nl;
  wire[0:0] for_for_for_nor_13_nl;
  wire[0:0] for_for_for_nor_16_nl;
  wire[0:0] for_for_for_nor_12_nl;
  wire[0:0] for_for_for_nor_17_nl;
  wire[0:0] for_for_for_nor_11_nl;
  wire[0:0] for_for_for_nor_18_nl;
  wire[0:0] for_for_for_nor_10_nl;
  wire[0:0] for_for_for_nor_19_nl;
  wire[0:0] for_for_for_nor_9_nl;
  wire[0:0] for_for_for_nor_20_nl;
  wire[0:0] for_for_for_nor_8_nl;
  wire[0:0] for_for_for_nor_21_nl;
  wire[0:0] for_for_for_nor_7_nl;
  wire[0:0] for_for_for_nor_22_nl;
  wire[0:0] for_for_for_nor_6_nl;
  wire[0:0] for_for_for_nor_23_nl;
  wire[0:0] for_for_for_nor_5_nl;
  wire[0:0] for_for_for_nor_24_nl;
  wire[0:0] for_for_for_nor_4_nl;
  wire[0:0] for_for_for_nor_25_nl;
  wire[0:0] for_for_for_nor_3_nl;
  wire[0:0] for_for_for_nor_26_nl;
  wire[0:0] for_for_for_nor_2_nl;
  wire[0:0] for_for_for_nor_27_nl;
  wire[0:0] for_for_for_nor_1_nl;
  wire[0:0] for_for_for_nor_28_nl;
  wire[0:0] for_for_for_nor_nl;
  wire[0:0] for_for_for_nor_29_nl;
  wire[13:0] STAGE_LOOP_mux_1_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_mult_t_mul_cmp_b;
  assign nl_mult_t_mul_cmp_b = INNER_LOOP_tf_h_slc_twiddle_h_rsci_qa_d_31_0_itm;
  wire [3:0] nl_operator_33_true_lshift_rg_s;
  assign nl_operator_33_true_lshift_rg_s = STAGE_LOOP_i_3_0_sva + 4'b1111;
  wire [12:0] nl_INNER_LOOP_k_lshift_rg_a;
  assign nl_INNER_LOOP_k_lshift_rg_a = z_out[12:0];
  wire [3:0] nl_INNER_LOOP_k_lshift_rg_s;
  assign nl_INNER_LOOP_k_lshift_rg_s = operator_20_false_acc_psp_sva;
  wire[12:0] operator_20_false_operator_20_false_and_nl;
  wire [14:0] nl_INNER_LOOP_g_rshift_rg_a;
  assign operator_20_false_operator_20_false_and_nl = MUX_v_13_2_2(13'b0000000000000,
      INNER_LOOP_j_13_0_sva_12_0, (fsm_output[3]));
  assign nl_INNER_LOOP_g_rshift_rg_a = {(~ (fsm_output[3])) , 1'b0 , operator_20_false_operator_20_false_and_nl};
  wire [3:0] nl_INNER_LOOP_g_rshift_rg_s;
  assign nl_INNER_LOOP_g_rshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, operator_20_false_acc_psp_sva,
      fsm_output[3]);
  wire [0:0] nl_ntt_flat_core_core_fsm_inst_for_C_0_tr0;
  assign nl_ntt_flat_core_core_fsm_inst_for_C_0_tr0 = ~(INNER_LOOP_stage_0_1 | INNER_LOOP_stage_0);
  wire [0:0] nl_ntt_flat_core_core_fsm_inst_INNER_LOOP_C_2_tr0;
  assign nl_ntt_flat_core_core_fsm_inst_INNER_LOOP_C_2_tr0 = (~(INNER_LOOP_stage_0_4
      | INNER_LOOP_stage_0_1 | INNER_LOOP_stage_0_3)) & (~(INNER_LOOP_stage_0_2 |
      INNER_LOOP_stage_0));
  wire [0:0] nl_ntt_flat_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_ntt_flat_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = operator_20_false_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(vec_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) p_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(p_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(r_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(twiddle_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(twiddle_h_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_14_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_14_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_13_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_13_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_12_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_12_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_11_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_11_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_10_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_10_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_9_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_9_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_8_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_8_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_7_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_7_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_6_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_6_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_5_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_5_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_4_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_4_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_3_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_3_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_2_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_2_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_1_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_1_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_0_0_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_0_0_lz)
    );
  mgc_mul_pipe #(.width_a(32'sd32),
  .signd_a(32'sd0),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd52),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) mult_t_mul_cmp (
      .a(modulo_sub_qelse_mux_itm),
      .b(nl_mult_t_mul_cmp_b[31:0]),
      .clk(clk),
      .en(mult_t_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(mult_t_mul_cmp_z)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd14)) operator_33_true_lshift_rg (
      .a(1'b1),
      .s(nl_operator_33_true_lshift_rg_s[3:0]),
      .z(operator_33_true_lshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd13),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd18)) INNER_LOOP_k_lshift_rg (
      .a(nl_INNER_LOOP_k_lshift_rg_a[12:0]),
      .s(nl_INNER_LOOP_k_lshift_rg_s[3:0]),
      .z(INNER_LOOP_k_lshift_itm)
    );
  mgc_shift_r_v5 #(.width_a(32'sd15),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd14)) INNER_LOOP_g_rshift_rg (
      .a(nl_INNER_LOOP_g_rshift_rg_a[14:0]),
      .s(nl_INNER_LOOP_g_rshift_rg_s[3:0]),
      .z(z_out)
    );
  ntt_flat_core_wait_dp ntt_flat_core_wait_dp_inst (
      .clk(clk),
      .ensig_cgo_iro(or_250_rmff),
      .mult_z_mul_cmp_z(mult_z_mul_cmp_z),
      .ensig_cgo(reg_ensig_cgo_cse),
      .mult_t_mul_cmp_en(mult_t_mul_cmp_en),
      .mult_z_mul_cmp_z_oreg(mult_z_mul_cmp_z_oreg)
    );
  ntt_flat_core_core_fsm ntt_flat_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .for_C_0_tr0(nl_ntt_flat_core_core_fsm_inst_for_C_0_tr0[0:0]),
      .INNER_LOOP_C_2_tr0(nl_ntt_flat_core_core_fsm_inst_INNER_LOOP_C_2_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_ntt_flat_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign and_161_rmff = INNER_LOOP_stage_0_1 & (fsm_output[5]);
  assign or_146_rmff = (and_dcpl_21 & and_dcpl_19 & (fsm_output[3])) | (INNER_LOOP_stage_0_1
      & (fsm_output[1])) | (and_dcpl_25 & and_dcpl_23 & (fsm_output[4]));
  assign or_154_rmff = (and_dcpl_37 & and_dcpl_19 & (fsm_output[3])) | (and_dcpl_39
      & and_dcpl_23 & (fsm_output[4]));
  assign and_47_nl = ((butterFly_f2_acc_1_tmp!=4'b0001)) & or_tmp_5;
  assign mux_1_nl = MUX_s_1_2_2(and_47_nl, or_dcpl_45, butterFly_f1_acc_1_tmp[3]);
  assign for_or_13_seb = (~ (fsm_output[5])) | mux_1_nl | (~ INNER_LOOP_stage_0_1);
  assign or_161_rmff = (and_dcpl_47 & and_dcpl_19 & (fsm_output[3])) | (and_dcpl_25
      & and_dcpl_49 & (fsm_output[4]));
  assign and_58_nl = ((butterFly_f2_acc_1_tmp!=4'b0010)) & or_tmp_7;
  assign mux_2_nl = MUX_s_1_2_2(and_58_nl, or_dcpl_50, butterFly_f1_acc_1_tmp[3]);
  assign for_or_12_seb = (~ (fsm_output[5])) | mux_2_nl | (~ INNER_LOOP_stage_0_1);
  assign or_168_rmff = (and_dcpl_57 & and_dcpl_19 & (fsm_output[3])) | (and_dcpl_39
      & and_dcpl_49 & (fsm_output[4]));
  assign and_68_nl = ((butterFly_f2_acc_1_tmp!=4'b0011)) & or_tmp_9;
  assign mux_3_nl = MUX_s_1_2_2(and_68_nl, or_dcpl_54, butterFly_f1_acc_1_tmp[3]);
  assign for_or_11_seb = (~ (fsm_output[5])) | mux_3_nl | (~ INNER_LOOP_stage_0_1);
  assign or_175_rmff = (and_dcpl_21 & and_dcpl_65 & (fsm_output[3])) | (and_dcpl_25
      & and_dcpl_67 & (fsm_output[4]));
  assign or_69_nl = (butterFly_f2_acc_1_tmp[3]) | (butterFly_f2_acc_1_tmp[0]) | (butterFly_f2_acc_1_tmp[1]);
  assign mux_4_nl = MUX_s_1_2_2(not_tmp_65, or_tmp_12, or_69_nl);
  assign mux_5_nl = MUX_s_1_2_2(mux_4_nl, or_dcpl_58, butterFly_f1_acc_1_tmp[3]);
  assign for_or_10_seb = (~ (fsm_output[5])) | mux_5_nl | (~ INNER_LOOP_stage_0_1);
  assign or_182_rmff = (and_dcpl_37 & and_dcpl_65 & (fsm_output[3])) | (and_dcpl_39
      & and_dcpl_67 & (fsm_output[4]));
  assign or_77_nl = (butterFly_f2_acc_1_tmp[3]) | (~ (butterFly_f2_acc_1_tmp[0]))
      | (butterFly_f2_acc_1_tmp[1]);
  assign mux_6_nl = MUX_s_1_2_2(not_tmp_67, or_tmp_16, or_77_nl);
  assign mux_7_nl = MUX_s_1_2_2(mux_6_nl, or_dcpl_62, butterFly_f1_acc_1_tmp[3]);
  assign for_or_9_seb = (~ (fsm_output[5])) | mux_7_nl | (~ INNER_LOOP_stage_0_1);
  assign or_189_rmff = (and_dcpl_47 & and_dcpl_65 & (fsm_output[3])) | (and_dcpl_25
      & and_dcpl_80 & (fsm_output[4]));
  assign or_85_cse = (butterFly_f2_acc_1_tmp[3]) | (butterFly_f2_acc_1_tmp[0]);
  assign mux_8_nl = MUX_s_1_2_2(not_tmp_70, or_tmp_19, or_85_cse);
  assign mux_9_nl = MUX_s_1_2_2(mux_8_nl, or_dcpl_66, butterFly_f1_acc_1_tmp[3]);
  assign for_or_8_seb = (~ (fsm_output[5])) | mux_9_nl | (~ INNER_LOOP_stage_0_1);
  assign or_196_rmff = (and_dcpl_57 & and_dcpl_65 & (fsm_output[3])) | (and_dcpl_39
      & and_dcpl_80 & (fsm_output[4]));
  assign and_517_cse = (butterFly_f2_acc_1_tmp==4'b0111);
  assign nor_6_nl = ~(and_517_cse | ((butterFly_f1_acc_1_tmp[2:0]==3'b111)));
  assign mux_10_nl = MUX_s_1_2_2(nor_6_nl, or_dcpl_69, butterFly_f1_acc_1_tmp[3]);
  assign for_or_7_seb = (~ (fsm_output[5])) | mux_10_nl | (~ INNER_LOOP_stage_0_1);
  assign or_203_rmff = (and_dcpl_21 & and_dcpl_91 & (fsm_output[3])) | (and_dcpl_94
      & and_dcpl_23 & (fsm_output[4]));
  assign and_105_nl = ((butterFly_f2_acc_1_tmp!=4'b1000)) & or_tmp_3;
  assign mux_11_nl = MUX_s_1_2_2(or_dcpl_73, and_105_nl, butterFly_f1_acc_1_tmp[3]);
  assign for_or_6_seb = (~ (fsm_output[5])) | mux_11_nl | (~ INNER_LOOP_stage_0_1);
  assign or_210_rmff = (and_dcpl_37 & and_dcpl_91 & (fsm_output[3])) | (and_dcpl_103
      & and_dcpl_23 & (fsm_output[4]));
  assign and_115_nl = ((butterFly_f2_acc_1_tmp!=4'b1001)) & or_tmp_5;
  assign mux_12_nl = MUX_s_1_2_2(or_dcpl_78, and_115_nl, butterFly_f1_acc_1_tmp[3]);
  assign for_or_5_seb = (~ (fsm_output[5])) | mux_12_nl | (~ INNER_LOOP_stage_0_1);
  assign or_217_rmff = (and_dcpl_47 & and_dcpl_91 & (fsm_output[3])) | (and_dcpl_94
      & and_dcpl_49 & (fsm_output[4]));
  assign and_123_nl = ((butterFly_f2_acc_1_tmp!=4'b1010)) & or_tmp_7;
  assign mux_13_nl = MUX_s_1_2_2(or_dcpl_82, and_123_nl, butterFly_f1_acc_1_tmp[3]);
  assign for_or_4_seb = (~ (fsm_output[5])) | mux_13_nl | (~ INNER_LOOP_stage_0_1);
  assign or_224_rmff = (and_dcpl_57 & and_dcpl_91 & (fsm_output[3])) | (and_dcpl_103
      & and_dcpl_49 & (fsm_output[4]));
  assign and_130_nl = (~((butterFly_f2_acc_1_tmp==4'b1011))) & or_tmp_9;
  assign mux_14_nl = MUX_s_1_2_2(or_dcpl_85, and_130_nl, butterFly_f1_acc_1_tmp[3]);
  assign for_or_3_seb = (~ (fsm_output[5])) | mux_14_nl | (~ INNER_LOOP_stage_0_1);
  assign or_231_rmff = (and_dcpl_21 & and_dcpl_122 & (fsm_output[3])) | (and_dcpl_94
      & and_dcpl_67 & (fsm_output[4]));
  assign or_115_nl = (~ (butterFly_f2_acc_1_tmp[3])) | (butterFly_f2_acc_1_tmp[0])
      | (butterFly_f2_acc_1_tmp[1]);
  assign mux_15_nl = MUX_s_1_2_2(not_tmp_65, or_tmp_12, or_115_nl);
  assign mux_16_nl = MUX_s_1_2_2(or_dcpl_88, mux_15_nl, butterFly_f1_acc_1_tmp[3]);
  assign for_or_2_seb = (~ (fsm_output[5])) | mux_16_nl | (~ INNER_LOOP_stage_0_1);
  assign or_238_rmff = (and_dcpl_37 & and_dcpl_122 & (fsm_output[3])) | (and_dcpl_103
      & and_dcpl_67 & (fsm_output[4]));
  assign or_119_nl = (~ (butterFly_f2_acc_1_tmp[3])) | (~ (butterFly_f2_acc_1_tmp[0]))
      | (butterFly_f2_acc_1_tmp[1]);
  assign mux_17_nl = MUX_s_1_2_2(not_tmp_67, or_tmp_16, or_119_nl);
  assign mux_18_nl = MUX_s_1_2_2(or_dcpl_91, mux_17_nl, butterFly_f1_acc_1_tmp[3]);
  assign for_or_1_seb = (~ (fsm_output[5])) | mux_18_nl | (~ INNER_LOOP_stage_0_1);
  assign or_245_rmff = (and_dcpl_47 & and_dcpl_122 & (fsm_output[3])) | (and_dcpl_94
      & and_dcpl_80 & (fsm_output[4]));
  assign or_123_cse = (~ (butterFly_f2_acc_1_tmp[3])) | (butterFly_f2_acc_1_tmp[0]);
  assign mux_19_nl = MUX_s_1_2_2(not_tmp_70, or_tmp_19, or_123_cse);
  assign mux_20_nl = MUX_s_1_2_2(or_dcpl_94, mux_19_nl, butterFly_f1_acc_1_tmp[3]);
  assign for_or_seb = (~ (fsm_output[5])) | mux_20_nl | (~ INNER_LOOP_stage_0_1);
  assign or_250_rmff = (INNER_LOOP_stage_0_3 & (fsm_output[3])) | (INNER_LOOP_stage_0_2
      & or_dcpl_97);
  assign butterFly_f1_nor_9_cse = ~((butterFly_f1_acc_1_tmp[1:0]!=2'b00));
  assign INNER_LOOP_or_1_cse = (fsm_output[2]) | (fsm_output[5]);
  assign nl_modulo_sub_qif_acc_nl = ({1'b1 , (modulo_sub_base_sva_1[30:0])}) + p_sva;
  assign modulo_sub_qif_acc_nl = nl_modulo_sub_qif_acc_nl[31:0];
  assign modulo_sub_qelse_mux_itm = MUX_v_32_2_2(({1'b0 , (modulo_sub_base_sva_1[30:0])}),
      modulo_sub_qif_acc_nl, modulo_sub_base_sva_1[31]);
  assign nl_butterFly_f2_acc_1_tmp = (butterFly_idx2_17_0_sva_1[17:14]) + STAGE_LOOP_i_3_0_sva;
  assign butterFly_f2_acc_1_tmp = nl_butterFly_f2_acc_1_tmp[3:0];
  assign nl_butterFly_f1_acc_1_tmp = (INNER_LOOP_idx1_acc_psp_sva_1[16:13]) + STAGE_LOOP_i_3_0_sva;
  assign butterFly_f1_acc_1_tmp = nl_butterFly_f1_acc_1_tmp[3:0];
  assign nl_INNER_LOOP_j_13_0_sva_2 = conv_u2u_13_14(INNER_LOOP_j_13_0_sva_12_0)
      + 14'b00000000000001;
  assign INNER_LOOP_j_13_0_sva_2 = nl_INNER_LOOP_j_13_0_sva_2[13:0];
  assign nl_mult_res_sva_1 = mult_z_asn_itm_1 - mult_z_mul_cmp_z_oreg;
  assign mult_res_sva_1 = nl_mult_res_sva_1[31:0];
  assign nl_modulo_sub_base_sva_1 = tmp_lpi_3_dfm - tmp_1_lpi_3_dfm;
  assign modulo_sub_base_sva_1 = nl_modulo_sub_base_sva_1[31:0];
  assign nl_modulo_add_base_sva_1 = tmp_lpi_3_dfm + tmp_1_lpi_3_dfm;
  assign modulo_add_base_sva_1 = nl_modulo_add_base_sva_1[31:0];
  assign nl_INNER_LOOP_idx1_acc_psp_sva_1 = INNER_LOOP_idx1_mul_itm + (INNER_LOOP_k_17_0_sva[17:1]);
  assign INNER_LOOP_idx1_acc_psp_sva_1 = nl_INNER_LOOP_idx1_acc_psp_sva_1[16:0];
  assign nl_butterFly_idx2_17_0_sva_1 = ({INNER_LOOP_idx1_acc_psp_sva_1 , (INNER_LOOP_k_17_0_sva[0])})
      + conv_u2u_14_18(operator_20_false_rshift_psp_sva);
  assign butterFly_idx2_17_0_sva_1 = nl_butterFly_idx2_17_0_sva_1[17:0];
  assign nl_operator_20_false_acc_nl = ({1'b1 , (~ (z_out_1[3:0]))}) + 5'b01111;
  assign operator_20_false_acc_nl = nl_operator_20_false_acc_nl[4:0];
  assign operator_20_false_acc_itm_4_1 = readslicef_5_1_4(operator_20_false_acc_nl);
  assign or_dcpl_38 = (butterFly_f2_acc_1_tmp[2:1]!=2'b00);
  assign or_dcpl_39 = or_dcpl_38 | or_85_cse;
  assign and_dcpl_19 = ~((butterFly_acc_4_itm_4[3:2]!=2'b00));
  assign and_dcpl_20 = (~ (butterFly_acc_4_itm_4[0])) & INNER_LOOP_stage_0_5;
  assign and_dcpl_21 = and_dcpl_20 & (~ (butterFly_acc_4_itm_4[1]));
  assign and_dcpl_23 = ~((butterFly_acc_itm_3[2:1]!=2'b00));
  assign and_dcpl_24 = INNER_LOOP_stage_0_4 & (~ (butterFly_acc_itm_3[3]));
  assign and_dcpl_25 = and_dcpl_24 & (~ (butterFly_acc_itm_3[0]));
  assign or_tmp_3 = (butterFly_f1_acc_1_tmp[2:0]!=3'b000);
  assign and_dcpl_31 = INNER_LOOP_stage_0_1 & (~ (butterFly_f1_acc_1_tmp[3]));
  assign and_dcpl_33 = butterFly_f1_nor_9_cse & and_dcpl_31;
  assign or_dcpl_41 = (butterFly_f1_acc_1_tmp[0]) | (butterFly_f1_acc_1_tmp[3]);
  assign or_dcpl_42 = (butterFly_f1_acc_1_tmp[2:1]!=2'b00);
  assign or_dcpl_44 = (~ (butterFly_f2_acc_1_tmp[0])) | (butterFly_f2_acc_1_tmp[3]);
  assign or_dcpl_45 = or_dcpl_38 | or_dcpl_44;
  assign and_dcpl_36 = (butterFly_acc_4_itm_4[0]) & INNER_LOOP_stage_0_5;
  assign and_dcpl_37 = and_dcpl_36 & (~ (butterFly_acc_4_itm_4[1]));
  assign and_dcpl_39 = and_dcpl_24 & (butterFly_acc_itm_3[0]);
  assign or_tmp_5 = (butterFly_f1_acc_1_tmp[2:0]!=3'b001);
  assign and_dcpl_43 = (butterFly_f1_acc_1_tmp[1:0]==2'b01);
  assign and_dcpl_44 = and_dcpl_43 & and_dcpl_31;
  assign or_dcpl_47 = (~ (butterFly_f1_acc_1_tmp[0])) | (butterFly_f1_acc_1_tmp[3]);
  assign or_dcpl_49 = (butterFly_f2_acc_1_tmp[2:1]!=2'b01);
  assign or_dcpl_50 = or_dcpl_49 | or_85_cse;
  assign and_dcpl_47 = and_dcpl_20 & (butterFly_acc_4_itm_4[1]);
  assign and_dcpl_49 = (butterFly_acc_itm_3[2:1]==2'b01);
  assign or_tmp_7 = (butterFly_f1_acc_1_tmp[2:0]!=3'b010);
  assign and_dcpl_53 = (butterFly_f1_acc_1_tmp[1:0]==2'b10);
  assign and_dcpl_54 = and_dcpl_53 & and_dcpl_31;
  assign or_dcpl_52 = (butterFly_f1_acc_1_tmp[2:1]!=2'b01);
  assign or_dcpl_54 = or_dcpl_49 | or_dcpl_44;
  assign and_dcpl_57 = and_dcpl_36 & (butterFly_acc_4_itm_4[1]);
  assign or_tmp_9 = (butterFly_f1_acc_1_tmp[2:0]!=3'b011);
  assign and_dcpl_61 = (butterFly_f1_acc_1_tmp[1:0]==2'b11);
  assign and_dcpl_62 = and_dcpl_61 & and_dcpl_31;
  assign or_dcpl_57 = (butterFly_f2_acc_1_tmp[2:1]!=2'b10);
  assign or_dcpl_58 = or_dcpl_57 | or_85_cse;
  assign and_dcpl_65 = (butterFly_acc_4_itm_4[3:2]==2'b01);
  assign and_dcpl_67 = (butterFly_acc_itm_3[2:1]==2'b10);
  assign or_tmp_12 = (butterFly_f1_acc_1_tmp[2:0]!=3'b100);
  assign not_tmp_65 = ~((butterFly_f2_acc_1_tmp[2]) | (~ or_tmp_12));
  assign or_dcpl_60 = (butterFly_f1_acc_1_tmp[2:1]!=2'b10);
  assign or_dcpl_62 = or_dcpl_57 | or_dcpl_44;
  assign or_tmp_16 = (butterFly_f1_acc_1_tmp[2:0]!=3'b101);
  assign not_tmp_67 = ~((butterFly_f2_acc_1_tmp[2]) | (~ or_tmp_16));
  assign or_dcpl_65 = ~((butterFly_f2_acc_1_tmp[2:1]==2'b11));
  assign or_dcpl_66 = or_dcpl_65 | or_85_cse;
  assign and_dcpl_80 = (butterFly_acc_itm_3[2:1]==2'b11);
  assign not_tmp_68 = ~((butterFly_f1_acc_1_tmp[2:1]==2'b11));
  assign or_tmp_19 = (butterFly_f1_acc_1_tmp[0]) | not_tmp_68;
  assign not_tmp_70 = or_dcpl_65 & or_tmp_19;
  assign or_dcpl_69 = or_dcpl_65 | or_dcpl_44;
  assign or_dcpl_73 = or_dcpl_38 | or_123_cse;
  assign and_dcpl_91 = (butterFly_acc_4_itm_4[3:2]==2'b10);
  assign and_dcpl_93 = INNER_LOOP_stage_0_4 & (butterFly_acc_itm_3[3]);
  assign and_dcpl_94 = and_dcpl_93 & (~ (butterFly_acc_itm_3[0]));
  assign and_dcpl_98 = INNER_LOOP_stage_0_1 & (butterFly_f1_acc_1_tmp[3]);
  assign and_dcpl_99 = butterFly_f1_nor_9_cse & and_dcpl_98;
  assign or_dcpl_75 = (butterFly_f1_acc_1_tmp[0]) | (~ (butterFly_f1_acc_1_tmp[3]));
  assign or_dcpl_77 = ~((butterFly_f2_acc_1_tmp[0]) & (butterFly_f2_acc_1_tmp[3]));
  assign or_dcpl_78 = or_dcpl_38 | or_dcpl_77;
  assign and_dcpl_103 = and_dcpl_93 & (butterFly_acc_itm_3[0]);
  assign and_dcpl_107 = and_dcpl_43 & and_dcpl_98;
  assign or_dcpl_80 = ~((butterFly_f1_acc_1_tmp[0]) & (butterFly_f1_acc_1_tmp[3]));
  assign or_dcpl_82 = or_dcpl_49 | or_123_cse;
  assign and_dcpl_113 = and_dcpl_53 & and_dcpl_98;
  assign or_dcpl_85 = or_dcpl_49 | or_dcpl_77;
  assign or_dcpl_88 = or_dcpl_57 | or_123_cse;
  assign and_dcpl_122 = (butterFly_acc_4_itm_4[3:2]==2'b11);
  assign or_dcpl_91 = or_dcpl_57 | or_dcpl_77;
  assign or_dcpl_94 = or_dcpl_65 | or_123_cse;
  assign or_dcpl_97 = (fsm_output[5:4]!=2'b00);
  assign or_dcpl_98 = (fsm_output[0]) | (fsm_output[2]);
  assign or_dcpl_99 = (fsm_output[7:6]!=2'b00);
  assign or_dcpl_103 = (fsm_output[4:3]!=2'b00);
  assign or_tmp_169 = or_dcpl_103 | (fsm_output[5]);
  assign and_32_nl = ((butterFly_f2_acc_1_tmp!=4'b0000)) & or_tmp_3;
  assign mux_nl = MUX_s_1_2_2(and_32_nl, or_dcpl_39, butterFly_f1_acc_1_tmp[3]);
  assign result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_mx0c0 = (~ (fsm_output[5]))
      | mux_nl | (~ INNER_LOOP_stage_0_1);
  assign for_mux1h_7_itm = MUX1HOT_v_13_3_2((butterFly_idx2_17_0_sva_4_13_0[13:1]),
      INNER_LOOP_idx1_acc_psp_sva_3_12_0, (INNER_LOOP_idx1_acc_psp_sva_1[12:0]),
      {(fsm_output[3]) , (fsm_output[4]) , (fsm_output[5])});
  assign for_mux1h_39_itm = MUX1HOT_s_1_3_2((butterFly_idx2_17_0_sva_4_13_0[0]),
      INNER_LOOP_k_17_0_sva_3_0, (INNER_LOOP_k_17_0_sva[0]), {(fsm_output[3]) , (fsm_output[4])
      , (fsm_output[5])});
  assign vec_rsci_adra_d = butterFly_idx2_17_0_sva_2_13_0;
  assign and_159_nl = INNER_LOOP_stage_0 & (fsm_output[1]);
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = {1'b0 , and_159_nl};
  assign twiddle_rsci_adra_d_pff = INNER_LOOP_tf_mul_cse_sva;
  assign twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = {1'b0 , and_161_rmff};
  assign twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = {1'b0 , and_161_rmff};
  assign for_mux1h_3_nl = MUX1HOT_v_14_4_2(butterFly_idx2_17_0_sva_3_13_0, butterFly_idx2_17_0_sva_4_13_0,
      ({INNER_LOOP_idx1_acc_psp_sva_3_12_0 , INNER_LOOP_k_17_0_sva_3_0}), (butterFly_idx2_17_0_sva_1[13:0]),
      {(fsm_output[1]) , (fsm_output[3]) , (fsm_output[4]) , (fsm_output[5])});
  assign result_rsc_0_0_i_adra_d = {(INNER_LOOP_idx1_acc_psp_sva_1[12:0]) , (INNER_LOOP_k_17_0_sva[0])
      , for_mux1h_3_nl};
  assign result_rsc_0_0_i_da_d = MUX1HOT_v_32_3_2((vec_rsci_qa_d[31:0]), mult_res_lpi_3_dfm_1,
      modulo_add_qr_lpi_3_dfm_2, {(fsm_output[1]) , (fsm_output[3]) , (fsm_output[4])});
  assign result_rsc_0_0_i_wea_d = {1'b0 , or_146_rmff};
  assign for_for_for_nor_14_nl = ~(or_dcpl_42 | or_dcpl_41 | result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_mx0c0);
  assign for_for_for_nor_15_nl = ~((or_dcpl_39 & (~ (butterFly_f1_acc_1_tmp[2]))
      & and_dcpl_33 & (fsm_output[5])) | result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d_mx0c0);
  assign result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_14_nl
      , for_for_for_nor_15_nl};
  assign result_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_146_rmff};
  assign result_rsc_1_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_1_0_i_da_d_pff = MUX_v_32_2_2(mult_res_lpi_3_dfm_1, modulo_add_qr_lpi_3_dfm_2,
      fsm_output[4]);
  assign result_rsc_1_0_i_wea_d = {1'b0 , or_154_rmff};
  assign for_for_for_nor_13_nl = ~((or_dcpl_45 & (~ (butterFly_f1_acc_1_tmp[2]))
      & and_dcpl_44 & (fsm_output[5])) | for_or_13_seb);
  assign for_for_for_nor_16_nl = ~(or_dcpl_42 | or_dcpl_47 | for_or_13_seb);
  assign result_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_13_nl
      , for_for_for_nor_16_nl};
  assign result_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_154_rmff};
  assign result_rsc_2_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_2_0_i_wea_d = {1'b0 , or_161_rmff};
  assign for_for_for_nor_12_nl = ~((or_dcpl_50 & (~ (butterFly_f1_acc_1_tmp[2]))
      & and_dcpl_54 & (fsm_output[5])) | for_or_12_seb);
  assign for_for_for_nor_17_nl = ~(or_dcpl_52 | or_dcpl_41 | for_or_12_seb);
  assign result_rsc_2_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_12_nl
      , for_for_for_nor_17_nl};
  assign result_rsc_2_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_161_rmff};
  assign result_rsc_3_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_3_0_i_wea_d = {1'b0 , or_168_rmff};
  assign for_for_for_nor_11_nl = ~((or_dcpl_54 & (~ (butterFly_f1_acc_1_tmp[2]))
      & and_dcpl_62 & (fsm_output[5])) | for_or_11_seb);
  assign for_for_for_nor_18_nl = ~(or_dcpl_52 | or_dcpl_47 | for_or_11_seb);
  assign result_rsc_3_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_11_nl
      , for_for_for_nor_18_nl};
  assign result_rsc_3_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_168_rmff};
  assign result_rsc_4_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_4_0_i_wea_d = {1'b0 , or_175_rmff};
  assign for_for_for_nor_10_nl = ~((or_dcpl_58 & (butterFly_f1_acc_1_tmp[2]) & and_dcpl_33
      & (fsm_output[5])) | for_or_10_seb);
  assign for_for_for_nor_19_nl = ~(or_dcpl_60 | or_dcpl_41 | for_or_10_seb);
  assign result_rsc_4_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_10_nl
      , for_for_for_nor_19_nl};
  assign result_rsc_4_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_175_rmff};
  assign result_rsc_5_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_5_0_i_wea_d = {1'b0 , or_182_rmff};
  assign for_for_for_nor_9_nl = ~((or_dcpl_62 & (butterFly_f1_acc_1_tmp[2]) & and_dcpl_44
      & (fsm_output[5])) | for_or_9_seb);
  assign for_for_for_nor_20_nl = ~(or_dcpl_60 | or_dcpl_47 | for_or_9_seb);
  assign result_rsc_5_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_9_nl
      , for_for_for_nor_20_nl};
  assign result_rsc_5_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_182_rmff};
  assign result_rsc_6_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_6_0_i_wea_d = {1'b0 , or_189_rmff};
  assign for_for_for_nor_8_nl = ~((or_dcpl_66 & (butterFly_f1_acc_1_tmp[2]) & and_dcpl_54
      & (fsm_output[5])) | for_or_8_seb);
  assign for_for_for_nor_21_nl = ~(not_tmp_68 | or_dcpl_41 | for_or_8_seb);
  assign result_rsc_6_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_8_nl
      , for_for_for_nor_21_nl};
  assign result_rsc_6_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_189_rmff};
  assign result_rsc_7_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_7_0_i_wea_d = {1'b0 , or_196_rmff};
  assign for_for_for_nor_7_nl = ~((or_dcpl_69 & (butterFly_f1_acc_1_tmp[2]) & and_dcpl_62
      & (fsm_output[5])) | for_or_7_seb);
  assign for_for_for_nor_22_nl = ~(not_tmp_68 | or_dcpl_47 | for_or_7_seb);
  assign result_rsc_7_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_7_nl
      , for_for_for_nor_22_nl};
  assign result_rsc_7_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_196_rmff};
  assign result_rsc_8_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_8_0_i_wea_d = {1'b0 , or_203_rmff};
  assign for_for_for_nor_6_nl = ~((or_dcpl_73 & (~ (butterFly_f1_acc_1_tmp[2])) &
      and_dcpl_99 & (fsm_output[5])) | for_or_6_seb);
  assign for_for_for_nor_23_nl = ~(or_dcpl_42 | or_dcpl_75 | for_or_6_seb);
  assign result_rsc_8_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_6_nl
      , for_for_for_nor_23_nl};
  assign result_rsc_8_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_203_rmff};
  assign result_rsc_9_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_9_0_i_wea_d = {1'b0 , or_210_rmff};
  assign for_for_for_nor_5_nl = ~((or_dcpl_78 & (~ (butterFly_f1_acc_1_tmp[2])) &
      and_dcpl_107 & (fsm_output[5])) | for_or_5_seb);
  assign for_for_for_nor_24_nl = ~(or_dcpl_42 | or_dcpl_80 | for_or_5_seb);
  assign result_rsc_9_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_5_nl
      , for_for_for_nor_24_nl};
  assign result_rsc_9_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_210_rmff};
  assign result_rsc_10_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_10_0_i_wea_d = {1'b0 , or_217_rmff};
  assign for_for_for_nor_4_nl = ~((or_dcpl_82 & (~ (butterFly_f1_acc_1_tmp[2])) &
      and_dcpl_113 & (fsm_output[5])) | for_or_4_seb);
  assign for_for_for_nor_25_nl = ~(or_dcpl_52 | or_dcpl_75 | for_or_4_seb);
  assign result_rsc_10_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_4_nl
      , for_for_for_nor_25_nl};
  assign result_rsc_10_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_217_rmff};
  assign result_rsc_11_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_11_0_i_wea_d = {1'b0 , or_224_rmff};
  assign for_for_for_nor_3_nl = ~((or_dcpl_85 & (~ (butterFly_f1_acc_1_tmp[2])) &
      and_dcpl_61 & and_dcpl_98 & (fsm_output[5])) | for_or_3_seb);
  assign for_for_for_nor_26_nl = ~(or_dcpl_52 | or_dcpl_80 | for_or_3_seb);
  assign result_rsc_11_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_3_nl
      , for_for_for_nor_26_nl};
  assign result_rsc_11_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_224_rmff};
  assign result_rsc_12_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_12_0_i_wea_d = {1'b0 , or_231_rmff};
  assign for_for_for_nor_2_nl = ~((or_dcpl_88 & (butterFly_f1_acc_1_tmp[2]) & and_dcpl_99
      & (fsm_output[5])) | for_or_2_seb);
  assign for_for_for_nor_27_nl = ~(or_dcpl_60 | or_dcpl_75 | for_or_2_seb);
  assign result_rsc_12_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_2_nl
      , for_for_for_nor_27_nl};
  assign result_rsc_12_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_231_rmff};
  assign result_rsc_13_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_13_0_i_wea_d = {1'b0 , or_238_rmff};
  assign for_for_for_nor_1_nl = ~((or_dcpl_91 & (butterFly_f1_acc_1_tmp[2]) & and_dcpl_107
      & (fsm_output[5])) | for_or_1_seb);
  assign for_for_for_nor_28_nl = ~(or_dcpl_60 | or_dcpl_80 | for_or_1_seb);
  assign result_rsc_13_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_1_nl
      , for_for_for_nor_28_nl};
  assign result_rsc_13_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_238_rmff};
  assign result_rsc_14_0_i_adra_d = {(butterFly_idx2_17_0_sva_1[13:0]) , for_mux1h_7_itm
      , for_mux1h_39_itm};
  assign result_rsc_14_0_i_wea_d = {1'b0 , or_245_rmff};
  assign for_for_for_nor_nl = ~((or_dcpl_94 & (butterFly_f1_acc_1_tmp[2]) & and_dcpl_113
      & (fsm_output[5])) | for_or_seb);
  assign for_for_for_nor_29_nl = ~(not_tmp_68 | or_dcpl_75 | for_or_seb);
  assign result_rsc_14_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {for_for_for_nor_nl
      , for_for_for_nor_29_nl};
  assign result_rsc_14_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {1'b0 , or_245_rmff};
  always @(posedge clk) begin
    if ( (fsm_output[7]) | (fsm_output[0]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_obj_ld_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      INNER_LOOP_stage_0 <= 1'b0;
      butterFly_acc_4_itm_4 <= 4'b0000;
      INNER_LOOP_stage_0_5 <= 1'b0;
    end
    else begin
      reg_vec_rsc_triosy_obj_ld_cse <= operator_20_false_acc_itm_4_1 & (fsm_output[6]);
      reg_ensig_cgo_cse <= or_250_rmff;
      INNER_LOOP_stage_0 <= (butterFly_mux_nl & (~(or_dcpl_99 | (INNER_LOOP_stage_0_1
          & (INNER_LOOP_j_13_0_sva_2[13]) & (fsm_output[3]))))) | or_dcpl_98;
      butterFly_acc_4_itm_4 <= butterFly_acc_4_itm_3;
      INNER_LOOP_stage_0_5 <= INNER_LOOP_stage_0_4 & (fsm_output[5]);
    end
  end
  always @(posedge clk) begin
    mult_z_mul_cmp_a <= MUX_v_32_2_2(modulo_sub_qelse_mux_itm, INNER_LOOP_tf_slc_twiddle_rsci_qa_d_31_0_itm,
        fsm_output[5]);
    mult_z_mul_cmp_b <= MUX_v_32_2_2(INNER_LOOP_tf_slc_twiddle_rsci_qa_d_31_0_itm,
        p_sva, fsm_output[5]);
    butterFly_idx2_17_0_sva_4_13_0 <= MUX_v_14_2_2(({1'b0 , (z_out[12:0])}), butterFly_idx2_17_0_sva_3_13_0,
        fsm_output[5]);
    INNER_LOOP_tf_slc_twiddle_rsci_qa_d_31_0_itm <= MUX_v_32_2_2((twiddle_rsci_qa_d[31:0]),
        (mult_t_mul_cmp_z[51:20]), fsm_output[4]);
  end
  always @(posedge clk) begin
    if ( rst ) begin
      INNER_LOOP_stage_0_1 <= 1'b0;
    end
    else if ( (fsm_output[0]) | (fsm_output[1]) | (fsm_output[5]) | (fsm_output[2])
        ) begin
      INNER_LOOP_stage_0_1 <= (INNER_LOOP_stage_0 & (~ (fsm_output[0]))) | (fsm_output[2]);
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[5]) | (fsm_output[1]) | (fsm_output[2]) | (fsm_output[7]) |
        (fsm_output[0]) | (fsm_output[6]) ) begin
      butterFly_idx2_17_0_sva_2_13_0 <= MUX_v_14_2_2(14'b00000000000000, for_i_for_i_mux_nl,
          INNER_LOOP_nor_nl);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_103 ) begin
      butterFly_idx2_17_0_sva_3_13_0 <= butterFly_idx2_17_0_sva_2_13_0;
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[6]) | (fsm_output[1]) ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, (z_out_1[3:0]), fsm_output[6]);
    end
  end
  always @(posedge clk) begin
    if ( ~ (fsm_output[4]) ) begin
      mult_res_lpi_3_dfm_1 <= MUX_v_32_2_2(mult_z_mul_cmp_z_oreg, mult_res_lpi_3_dfm,
          fsm_output[5]);
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP_stage_0_1 ) begin
      INNER_LOOP_idx1_mul_itm <= nl_INNER_LOOP_idx1_mul_itm[16:0];
      INNER_LOOP_tf_mul_cse_sva <= nl_INNER_LOOP_tf_mul_cse_sva[13:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      butterFly_f2_butterFly_f2_nor_itm_1 <= 1'b0;
      butterFly_f2_acc_1_svs_1 <= 4'b0000;
      butterFly_f2_nor_itm_1 <= 1'b0;
      butterFly_f2_nor_1_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_2_itm_1 <= 1'b0;
      butterFly_f2_nor_3_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_4_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_5_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_6_itm_1 <= 1'b0;
      butterFly_f2_nor_6_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_8_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_9_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_10_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_11_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_12_itm_1 <= 1'b0;
      butterFly_f2_butterFly_f2_and_13_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_nor_itm_1 <= 1'b0;
      butterFly_f1_acc_1_svs_1 <= 4'b0000;
      butterFly_f1_nor_itm_1 <= 1'b0;
      butterFly_f1_nor_1_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_2_itm_1 <= 1'b0;
      butterFly_f1_nor_3_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_4_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_5_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_6_itm_1 <= 1'b0;
      butterFly_f1_nor_6_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_8_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_9_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_10_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_11_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_12_itm_1 <= 1'b0;
      butterFly_f1_butterFly_f1_and_13_itm_1 <= 1'b0;
    end
    else if ( INNER_LOOP_stage_0_1 ) begin
      butterFly_f2_butterFly_f2_nor_itm_1 <= ~((butterFly_f2_acc_1_tmp!=4'b0000));
      butterFly_f2_acc_1_svs_1 <= butterFly_f2_acc_1_tmp;
      butterFly_f2_nor_itm_1 <= ~((butterFly_f2_acc_1_tmp[3:1]!=3'b000));
      butterFly_f2_nor_1_itm_1 <= ~((butterFly_f2_acc_1_tmp[3]) | (butterFly_f2_acc_1_tmp[2])
          | (butterFly_f2_acc_1_tmp[0]));
      butterFly_f2_butterFly_f2_and_2_itm_1 <= (butterFly_f2_acc_1_tmp==4'b0011);
      butterFly_f2_nor_3_itm_1 <= ~((butterFly_f2_acc_1_tmp[3]) | (butterFly_f2_acc_1_tmp[1])
          | (butterFly_f2_acc_1_tmp[0]));
      butterFly_f2_butterFly_f2_and_4_itm_1 <= (butterFly_f2_acc_1_tmp==4'b0101);
      butterFly_f2_butterFly_f2_and_5_itm_1 <= (butterFly_f2_acc_1_tmp==4'b0110);
      butterFly_f2_butterFly_f2_and_6_itm_1 <= and_517_cse;
      butterFly_f2_nor_6_itm_1 <= ~((butterFly_f2_acc_1_tmp[2:0]!=3'b000));
      butterFly_f2_butterFly_f2_and_8_itm_1 <= (butterFly_f2_acc_1_tmp==4'b1001);
      butterFly_f2_butterFly_f2_and_9_itm_1 <= (butterFly_f2_acc_1_tmp==4'b1010);
      butterFly_f2_butterFly_f2_and_10_itm_1 <= (butterFly_f2_acc_1_tmp==4'b1011);
      butterFly_f2_butterFly_f2_and_11_itm_1 <= (butterFly_f2_acc_1_tmp==4'b1100);
      butterFly_f2_butterFly_f2_and_12_itm_1 <= (butterFly_f2_acc_1_tmp==4'b1101);
      butterFly_f2_butterFly_f2_and_13_itm_1 <= (butterFly_f2_acc_1_tmp==4'b1110);
      butterFly_f1_butterFly_f1_nor_itm_1 <= ~((butterFly_f1_acc_1_tmp!=4'b0000));
      butterFly_f1_acc_1_svs_1 <= butterFly_f1_acc_1_tmp;
      butterFly_f1_nor_itm_1 <= ~((butterFly_f1_acc_1_tmp[3:1]!=3'b000));
      butterFly_f1_nor_1_itm_1 <= ~((butterFly_f1_acc_1_tmp[3]) | (butterFly_f1_acc_1_tmp[2])
          | (butterFly_f1_acc_1_tmp[0]));
      butterFly_f1_butterFly_f1_and_2_itm_1 <= (butterFly_f1_acc_1_tmp==4'b0011);
      butterFly_f1_nor_3_itm_1 <= ~((butterFly_f1_acc_1_tmp[3]) | (butterFly_f1_acc_1_tmp[1])
          | (butterFly_f1_acc_1_tmp[0]));
      butterFly_f1_butterFly_f1_and_4_itm_1 <= (butterFly_f1_acc_1_tmp==4'b0101);
      butterFly_f1_butterFly_f1_and_5_itm_1 <= (butterFly_f1_acc_1_tmp==4'b0110);
      butterFly_f1_butterFly_f1_and_6_itm_1 <= (butterFly_f1_acc_1_tmp==4'b0111);
      butterFly_f1_nor_6_itm_1 <= ~((butterFly_f1_acc_1_tmp[2:0]!=3'b000));
      butterFly_f1_butterFly_f1_and_8_itm_1 <= (butterFly_f1_acc_1_tmp==4'b1001);
      butterFly_f1_butterFly_f1_and_9_itm_1 <= (butterFly_f1_acc_1_tmp==4'b1010);
      butterFly_f1_butterFly_f1_and_10_itm_1 <= (butterFly_f1_acc_1_tmp==4'b1011);
      butterFly_f1_butterFly_f1_and_11_itm_1 <= (butterFly_f1_acc_1_tmp[3:2]==2'b11)
          & butterFly_f1_nor_9_cse;
      butterFly_f1_butterFly_f1_and_12_itm_1 <= (butterFly_f1_acc_1_tmp==4'b1101);
      butterFly_f1_butterFly_f1_and_13_itm_1 <= (butterFly_f1_acc_1_tmp==4'b1110);
    end
  end
  always @(posedge clk) begin
    if ( (INNER_LOOP_stage_0_1 | (~ (fsm_output[3]))) & (fsm_output[5:4]==2'b00)
        ) begin
      INNER_LOOP_j_13_0_sva_12_0 <= MUX_v_13_2_2(13'b0000000000000, (INNER_LOOP_j_13_0_sva_2[12:0]),
          INNER_LOOP_j_or_nl);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_tmp_169 ) begin
      operator_20_false_acc_psp_sva <= nl_operator_20_false_acc_psp_sva[3:0];
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      modulo_add_qr_lpi_3_dfm_2 <= modulo_add_qr_lpi_3_dfm_1;
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      INNER_LOOP_idx1_acc_psp_sva_3_12_0 <= INNER_LOOP_idx1_acc_psp_sva_2_12_0;
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      INNER_LOOP_k_17_0_sva_3_0 <= INNER_LOOP_k_17_0_sva_2_0;
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      mult_z_asn_itm_1 <= mult_res_lpi_3_dfm_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      butterFly_acc_itm_3 <= 4'b0000;
    end
    else if ( fsm_output[5] ) begin
      butterFly_acc_itm_3 <= butterFly_acc_itm_2;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_tmp_169 ) begin
      operator_20_false_rshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      INNER_LOOP_stage_0_2 <= 1'b0;
      INNER_LOOP_stage_0_3 <= 1'b0;
      INNER_LOOP_stage_0_4 <= 1'b0;
    end
    else if ( INNER_LOOP_or_1_cse ) begin
      INNER_LOOP_stage_0_2 <= INNER_LOOP_stage_0_1 & (~ (fsm_output[2]));
      INNER_LOOP_stage_0_3 <= INNER_LOOP_stage_0_2 & (~ (fsm_output[2]));
      INNER_LOOP_stage_0_4 <= INNER_LOOP_stage_0_3 & (~ (fsm_output[2]));
    end
  end
  always @(posedge clk) begin
    if ( ~ or_tmp_169 ) begin
      operator_33_true_return_13_0_sva <= operator_33_true_lshift_itm;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      butterFly_acc_4_itm_3 <= 4'b0000;
    end
    else if ( fsm_output[5] ) begin
      butterFly_acc_4_itm_3 <= butterFly_acc_4_itm_2;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      butterFly_acc_itm_2 <= 4'b0000;
    end
    else if ( fsm_output[5] ) begin
      butterFly_acc_itm_2 <= butterFly_acc_itm_1;
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      modulo_add_qr_lpi_3_dfm_1 <= modulo_add_qr_lpi_3_dfm;
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      INNER_LOOP_idx1_acc_psp_sva_2_12_0 <= INNER_LOOP_idx1_acc_psp_sva_1_12_0;
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      INNER_LOOP_k_17_0_sva_2_0 <= INNER_LOOP_k_17_0_sva_1_0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      butterFly_acc_4_itm_2 <= 4'b0000;
    end
    else if ( fsm_output[5] ) begin
      butterFly_acc_4_itm_2 <= butterFly_acc_4_itm_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      butterFly_acc_itm_1 <= 4'b0000;
    end
    else if ( fsm_output[5] ) begin
      butterFly_acc_itm_1 <= nl_butterFly_acc_itm_1[3:0];
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      INNER_LOOP_idx1_acc_psp_sva_1_12_0 <= INNER_LOOP_idx1_acc_psp_sva_1[12:0];
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      INNER_LOOP_k_17_0_sva_1_0 <= INNER_LOOP_k_17_0_sva[0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      butterFly_acc_4_itm_1 <= 4'b0000;
    end
    else if ( fsm_output[5] ) begin
      butterFly_acc_4_itm_1 <= nl_butterFly_acc_4_itm_1[3:0];
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[5] ) begin
      butterFly_idx2_17_0_sva_1_13_0 <= butterFly_idx2_17_0_sva_1[13:0];
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP_stage_0_2 ) begin
      INNER_LOOP_tf_h_slc_twiddle_h_rsci_qa_d_31_0_itm <= twiddle_h_rsci_qa_d[31:0];
      tmp_1_lpi_3_dfm <= MUX1HOT_v_32_15_2((result_rsc_0_0_i_qa_d[31:0]), (result_rsc_1_0_i_qa_d[63:32]),
          (result_rsc_2_0_i_qa_d[63:32]), (result_rsc_3_0_i_qa_d[63:32]), (result_rsc_4_0_i_qa_d[63:32]),
          (result_rsc_5_0_i_qa_d[63:32]), (result_rsc_6_0_i_qa_d[63:32]), (result_rsc_7_0_i_qa_d[63:32]),
          (result_rsc_8_0_i_qa_d[63:32]), (result_rsc_9_0_i_qa_d[63:32]), (result_rsc_10_0_i_qa_d[63:32]),
          (result_rsc_11_0_i_qa_d[63:32]), (result_rsc_12_0_i_qa_d[63:32]), (result_rsc_13_0_i_qa_d[63:32]),
          (result_rsc_14_0_i_qa_d[63:32]), {butterFly_f2_butterFly_f2_nor_itm_1 ,
          butterFly_f2_butterFly_f2_and_nl , butterFly_f2_butterFly_f2_and_1_nl ,
          butterFly_f2_butterFly_f2_and_2_itm_1 , butterFly_f2_butterFly_f2_and_3_nl
          , butterFly_f2_butterFly_f2_and_4_itm_1 , butterFly_f2_butterFly_f2_and_5_itm_1
          , butterFly_f2_butterFly_f2_and_6_itm_1 , butterFly_f2_butterFly_f2_and_7_nl
          , butterFly_f2_butterFly_f2_and_8_itm_1 , butterFly_f2_butterFly_f2_and_9_itm_1
          , butterFly_f2_butterFly_f2_and_10_itm_1 , butterFly_f2_butterFly_f2_and_11_itm_1
          , butterFly_f2_butterFly_f2_and_12_itm_1 , butterFly_f2_butterFly_f2_and_13_itm_1});
      tmp_lpi_3_dfm <= MUX1HOT_v_32_15_2((result_rsc_0_0_i_qa_d[63:32]), (result_rsc_1_0_i_qa_d[31:0]),
          (result_rsc_2_0_i_qa_d[31:0]), (result_rsc_3_0_i_qa_d[31:0]), (result_rsc_4_0_i_qa_d[31:0]),
          (result_rsc_5_0_i_qa_d[31:0]), (result_rsc_6_0_i_qa_d[31:0]), (result_rsc_7_0_i_qa_d[31:0]),
          (result_rsc_8_0_i_qa_d[31:0]), (result_rsc_9_0_i_qa_d[31:0]), (result_rsc_10_0_i_qa_d[31:0]),
          (result_rsc_11_0_i_qa_d[31:0]), (result_rsc_12_0_i_qa_d[31:0]), (result_rsc_13_0_i_qa_d[31:0]),
          (result_rsc_14_0_i_qa_d[31:0]), {butterFly_f1_butterFly_f1_nor_itm_1 ,
          butterFly_f1_butterFly_f1_and_nl , butterFly_f1_butterFly_f1_and_1_nl ,
          butterFly_f1_butterFly_f1_and_2_itm_1 , butterFly_f1_butterFly_f1_and_3_nl
          , butterFly_f1_butterFly_f1_and_4_itm_1 , butterFly_f1_butterFly_f1_and_5_itm_1
          , butterFly_f1_butterFly_f1_and_6_itm_1 , butterFly_f1_butterFly_f1_and_7_nl
          , butterFly_f1_butterFly_f1_and_8_itm_1 , butterFly_f1_butterFly_f1_and_9_itm_1
          , butterFly_f1_butterFly_f1_and_10_itm_1 , butterFly_f1_butterFly_f1_and_11_itm_1
          , butterFly_f1_butterFly_f1_and_12_itm_1 , butterFly_f1_butterFly_f1_and_13_itm_1});
    end
  end
  always @(posedge clk) begin
    if ( ~ (fsm_output[4]) ) begin
      INNER_LOOP_k_17_0_sva <= nl_INNER_LOOP_k_17_0_sva[17:0];
    end
  end
  always @(posedge clk) begin
    if ( ((butterFly_acc_4_itm_3!=4'b1111)) & INNER_LOOP_stage_0_4 ) begin
      mult_res_lpi_3_dfm <= MUX_v_32_2_2(mult_if_acc_nl, mult_res_sva_1, readslicef_33_1_32(mult_if_acc_1_nl));
    end
  end
  always @(posedge clk) begin
    if ( ((butterFly_acc_itm_1!=4'b1111)) & INNER_LOOP_stage_0_2 ) begin
      modulo_add_qr_lpi_3_dfm <= MUX_v_32_2_2(modulo_add_base_sva_1, modulo_add_qif_acc_nl,
          readslicef_33_1_32(modulo_add_acc_1_nl));
    end
  end
  assign INNER_LOOP_INNER_LOOP_and_nl = INNER_LOOP_stage_0 & (~ (z_out_1[14]));
  assign or_256_nl = ((~(INNER_LOOP_stage_0_1 & (INNER_LOOP_j_13_0_sva_2[13]))) &
      (fsm_output[3])) | or_dcpl_97;
  assign butterFly_mux_nl = MUX_s_1_2_2(INNER_LOOP_INNER_LOOP_and_nl, INNER_LOOP_stage_0,
      or_256_nl);
  assign for_i_for_i_mux_nl = MUX_v_14_2_2((z_out_1[13:0]), butterFly_idx2_17_0_sva_1_13_0,
      fsm_output[5]);
  assign INNER_LOOP_nor_nl = ~(or_dcpl_99 | or_dcpl_98);
  assign nl_INNER_LOOP_idx1_mul_itm  = (butterFly_idx2_17_0_sva_4_13_0[12:0]) * operator_20_false_rshift_psp_sva;
  assign nl_INNER_LOOP_tf_mul_cse_sva  = $signed(operator_33_true_return_13_0_sva)
      * $signed(conv_u2s_14_15(INNER_LOOP_k_17_0_sva[13:0]));
  assign INNER_LOOP_j_or_nl = (fsm_output[5:3]!=3'b000);
  assign nl_operator_20_false_acc_psp_sva  = (~ STAGE_LOOP_i_3_0_sva) + 4'b1111;
  assign nl_butterFly_acc_itm_1  = (INNER_LOOP_idx1_acc_psp_sva_1[16:13]) + STAGE_LOOP_i_3_0_sva
      + 4'b0001;
  assign nl_butterFly_acc_4_itm_1  = (butterFly_idx2_17_0_sva_1[17:14]) + STAGE_LOOP_i_3_0_sva
      + 4'b0001;
  assign butterFly_f2_butterFly_f2_and_nl = (butterFly_f2_acc_1_svs_1[0]) & butterFly_f2_nor_itm_1;
  assign butterFly_f2_butterFly_f2_and_1_nl = (butterFly_f2_acc_1_svs_1[1]) & butterFly_f2_nor_1_itm_1;
  assign butterFly_f2_butterFly_f2_and_3_nl = (butterFly_f2_acc_1_svs_1[2]) & butterFly_f2_nor_3_itm_1;
  assign butterFly_f2_butterFly_f2_and_7_nl = (butterFly_f2_acc_1_svs_1[3]) & butterFly_f2_nor_6_itm_1;
  assign butterFly_f1_butterFly_f1_and_nl = (butterFly_f1_acc_1_svs_1[0]) & butterFly_f1_nor_itm_1;
  assign butterFly_f1_butterFly_f1_and_1_nl = (butterFly_f1_acc_1_svs_1[1]) & butterFly_f1_nor_1_itm_1;
  assign butterFly_f1_butterFly_f1_and_3_nl = (butterFly_f1_acc_1_svs_1[2]) & butterFly_f1_nor_3_itm_1;
  assign butterFly_f1_butterFly_f1_and_7_nl = (butterFly_f1_acc_1_svs_1[3]) & butterFly_f1_nor_6_itm_1;
  assign nl_INNER_LOOP_k_17_0_sva  = conv_u2u_13_18(INNER_LOOP_j_13_0_sva_12_0) -
      INNER_LOOP_k_lshift_itm;
  assign nl_mult_if_acc_nl = mult_res_sva_1 - p_sva;
  assign mult_if_acc_nl = nl_mult_if_acc_nl[31:0];
  assign nl_mult_if_acc_1_nl = ({1'b1 , mult_res_sva_1}) + conv_u2u_32_33(~ p_sva)
      + 33'b000000000000000000000000000000001;
  assign mult_if_acc_1_nl = nl_mult_if_acc_1_nl[32:0];
  assign nl_modulo_add_qif_acc_nl = modulo_add_base_sva_1 - p_sva;
  assign modulo_add_qif_acc_nl = nl_modulo_add_qif_acc_nl[31:0];
  assign nl_modulo_add_acc_1_nl = ({1'b1 , p_sva}) + conv_u2u_32_33(~ modulo_add_base_sva_1)
      + 33'b000000000000000000000000000000001;
  assign modulo_add_acc_1_nl = nl_modulo_add_acc_1_nl[32:0];
  assign STAGE_LOOP_mux_1_nl = MUX_v_14_2_2(({10'b0000000000 , STAGE_LOOP_i_3_0_sva}),
      butterFly_idx2_17_0_sva_2_13_0, fsm_output[1]);
  assign nl_z_out_1 = conv_u2u_14_15(STAGE_LOOP_mux_1_nl) + 15'b000000000000001;
  assign z_out_1 = nl_z_out_1[14:0];

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


  function automatic [12:0] MUX1HOT_v_13_3_2;
    input [12:0] input_2;
    input [12:0] input_1;
    input [12:0] input_0;
    input [2:0] sel;
    reg [12:0] result;
  begin
    result = input_0 & {13{sel[0]}};
    result = result | ( input_1 & {13{sel[1]}});
    result = result | ( input_2 & {13{sel[2]}});
    MUX1HOT_v_13_3_2 = result;
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


  function automatic [31:0] MUX1HOT_v_32_15_2;
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
    input [14:0] sel;
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
    MUX1HOT_v_32_15_2 = result;
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


  function automatic [0:0] readslicef_33_1_32;
    input [32:0] vector;
    reg [32:0] tmp;
  begin
    tmp = vector >> 32;
    readslicef_33_1_32 = tmp[0:0];
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


  function automatic [14:0] conv_u2s_14_15 ;
    input [13:0]  vector ;
  begin
    conv_u2s_14_15 =  {1'b0, vector};
  end
  endfunction


  function automatic [13:0] conv_u2u_13_14 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_14 = {1'b0, vector};
  end
  endfunction


  function automatic [17:0] conv_u2u_13_18 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_18 = {{5{1'b0}}, vector};
  end
  endfunction


  function automatic [14:0] conv_u2u_14_15 ;
    input [13:0]  vector ;
  begin
    conv_u2u_14_15 = {1'b0, vector};
  end
  endfunction


  function automatic [17:0] conv_u2u_14_18 ;
    input [13:0]  vector ;
  begin
    conv_u2u_14_18 = {{4{1'b0}}, vector};
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
//  Design Unit:    ntt_flat
// ------------------------------------------------------------------


module ntt_flat (
  clk, rst, vec_rsc_adra, vec_rsc_da, vec_rsc_wea, vec_rsc_qa, vec_rsc_adrb, vec_rsc_db,
      vec_rsc_web, vec_rsc_qb, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat,
      r_rsc_triosy_lz, twiddle_rsc_adra, twiddle_rsc_da, twiddle_rsc_wea, twiddle_rsc_qa,
      twiddle_rsc_adrb, twiddle_rsc_db, twiddle_rsc_web, twiddle_rsc_qb, twiddle_rsc_triosy_lz,
      twiddle_h_rsc_adra, twiddle_h_rsc_da, twiddle_h_rsc_wea, twiddle_h_rsc_qa,
      twiddle_h_rsc_adrb, twiddle_h_rsc_db, twiddle_h_rsc_web, twiddle_h_rsc_qb,
      twiddle_h_rsc_triosy_lz, result_rsc_0_0_adra, result_rsc_0_0_da, result_rsc_0_0_wea,
      result_rsc_0_0_qa, result_rsc_0_0_adrb, result_rsc_0_0_db, result_rsc_0_0_web,
      result_rsc_0_0_qb, result_rsc_triosy_0_0_lz, result_rsc_1_0_adra, result_rsc_1_0_da,
      result_rsc_1_0_wea, result_rsc_1_0_qa, result_rsc_1_0_adrb, result_rsc_1_0_db,
      result_rsc_1_0_web, result_rsc_1_0_qb, result_rsc_triosy_1_0_lz, result_rsc_2_0_adra,
      result_rsc_2_0_da, result_rsc_2_0_wea, result_rsc_2_0_qa, result_rsc_2_0_adrb,
      result_rsc_2_0_db, result_rsc_2_0_web, result_rsc_2_0_qb, result_rsc_triosy_2_0_lz,
      result_rsc_3_0_adra, result_rsc_3_0_da, result_rsc_3_0_wea, result_rsc_3_0_qa,
      result_rsc_3_0_adrb, result_rsc_3_0_db, result_rsc_3_0_web, result_rsc_3_0_qb,
      result_rsc_triosy_3_0_lz, result_rsc_4_0_adra, result_rsc_4_0_da, result_rsc_4_0_wea,
      result_rsc_4_0_qa, result_rsc_4_0_adrb, result_rsc_4_0_db, result_rsc_4_0_web,
      result_rsc_4_0_qb, result_rsc_triosy_4_0_lz, result_rsc_5_0_adra, result_rsc_5_0_da,
      result_rsc_5_0_wea, result_rsc_5_0_qa, result_rsc_5_0_adrb, result_rsc_5_0_db,
      result_rsc_5_0_web, result_rsc_5_0_qb, result_rsc_triosy_5_0_lz, result_rsc_6_0_adra,
      result_rsc_6_0_da, result_rsc_6_0_wea, result_rsc_6_0_qa, result_rsc_6_0_adrb,
      result_rsc_6_0_db, result_rsc_6_0_web, result_rsc_6_0_qb, result_rsc_triosy_6_0_lz,
      result_rsc_7_0_adra, result_rsc_7_0_da, result_rsc_7_0_wea, result_rsc_7_0_qa,
      result_rsc_7_0_adrb, result_rsc_7_0_db, result_rsc_7_0_web, result_rsc_7_0_qb,
      result_rsc_triosy_7_0_lz, result_rsc_8_0_adra, result_rsc_8_0_da, result_rsc_8_0_wea,
      result_rsc_8_0_qa, result_rsc_8_0_adrb, result_rsc_8_0_db, result_rsc_8_0_web,
      result_rsc_8_0_qb, result_rsc_triosy_8_0_lz, result_rsc_9_0_adra, result_rsc_9_0_da,
      result_rsc_9_0_wea, result_rsc_9_0_qa, result_rsc_9_0_adrb, result_rsc_9_0_db,
      result_rsc_9_0_web, result_rsc_9_0_qb, result_rsc_triosy_9_0_lz, result_rsc_10_0_adra,
      result_rsc_10_0_da, result_rsc_10_0_wea, result_rsc_10_0_qa, result_rsc_10_0_adrb,
      result_rsc_10_0_db, result_rsc_10_0_web, result_rsc_10_0_qb, result_rsc_triosy_10_0_lz,
      result_rsc_11_0_adra, result_rsc_11_0_da, result_rsc_11_0_wea, result_rsc_11_0_qa,
      result_rsc_11_0_adrb, result_rsc_11_0_db, result_rsc_11_0_web, result_rsc_11_0_qb,
      result_rsc_triosy_11_0_lz, result_rsc_12_0_adra, result_rsc_12_0_da, result_rsc_12_0_wea,
      result_rsc_12_0_qa, result_rsc_12_0_adrb, result_rsc_12_0_db, result_rsc_12_0_web,
      result_rsc_12_0_qb, result_rsc_triosy_12_0_lz, result_rsc_13_0_adra, result_rsc_13_0_da,
      result_rsc_13_0_wea, result_rsc_13_0_qa, result_rsc_13_0_adrb, result_rsc_13_0_db,
      result_rsc_13_0_web, result_rsc_13_0_qb, result_rsc_triosy_13_0_lz, result_rsc_14_0_adra,
      result_rsc_14_0_da, result_rsc_14_0_wea, result_rsc_14_0_qa, result_rsc_14_0_adrb,
      result_rsc_14_0_db, result_rsc_14_0_web, result_rsc_14_0_qb, result_rsc_triosy_14_0_lz
);
  input clk;
  input rst;
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
  output [13:0] result_rsc_0_0_adra;
  output [31:0] result_rsc_0_0_da;
  output result_rsc_0_0_wea;
  input [31:0] result_rsc_0_0_qa;
  output [13:0] result_rsc_0_0_adrb;
  output [31:0] result_rsc_0_0_db;
  output result_rsc_0_0_web;
  input [31:0] result_rsc_0_0_qb;
  output result_rsc_triosy_0_0_lz;
  output [13:0] result_rsc_1_0_adra;
  output [31:0] result_rsc_1_0_da;
  output result_rsc_1_0_wea;
  input [31:0] result_rsc_1_0_qa;
  output [13:0] result_rsc_1_0_adrb;
  output [31:0] result_rsc_1_0_db;
  output result_rsc_1_0_web;
  input [31:0] result_rsc_1_0_qb;
  output result_rsc_triosy_1_0_lz;
  output [13:0] result_rsc_2_0_adra;
  output [31:0] result_rsc_2_0_da;
  output result_rsc_2_0_wea;
  input [31:0] result_rsc_2_0_qa;
  output [13:0] result_rsc_2_0_adrb;
  output [31:0] result_rsc_2_0_db;
  output result_rsc_2_0_web;
  input [31:0] result_rsc_2_0_qb;
  output result_rsc_triosy_2_0_lz;
  output [13:0] result_rsc_3_0_adra;
  output [31:0] result_rsc_3_0_da;
  output result_rsc_3_0_wea;
  input [31:0] result_rsc_3_0_qa;
  output [13:0] result_rsc_3_0_adrb;
  output [31:0] result_rsc_3_0_db;
  output result_rsc_3_0_web;
  input [31:0] result_rsc_3_0_qb;
  output result_rsc_triosy_3_0_lz;
  output [13:0] result_rsc_4_0_adra;
  output [31:0] result_rsc_4_0_da;
  output result_rsc_4_0_wea;
  input [31:0] result_rsc_4_0_qa;
  output [13:0] result_rsc_4_0_adrb;
  output [31:0] result_rsc_4_0_db;
  output result_rsc_4_0_web;
  input [31:0] result_rsc_4_0_qb;
  output result_rsc_triosy_4_0_lz;
  output [13:0] result_rsc_5_0_adra;
  output [31:0] result_rsc_5_0_da;
  output result_rsc_5_0_wea;
  input [31:0] result_rsc_5_0_qa;
  output [13:0] result_rsc_5_0_adrb;
  output [31:0] result_rsc_5_0_db;
  output result_rsc_5_0_web;
  input [31:0] result_rsc_5_0_qb;
  output result_rsc_triosy_5_0_lz;
  output [13:0] result_rsc_6_0_adra;
  output [31:0] result_rsc_6_0_da;
  output result_rsc_6_0_wea;
  input [31:0] result_rsc_6_0_qa;
  output [13:0] result_rsc_6_0_adrb;
  output [31:0] result_rsc_6_0_db;
  output result_rsc_6_0_web;
  input [31:0] result_rsc_6_0_qb;
  output result_rsc_triosy_6_0_lz;
  output [13:0] result_rsc_7_0_adra;
  output [31:0] result_rsc_7_0_da;
  output result_rsc_7_0_wea;
  input [31:0] result_rsc_7_0_qa;
  output [13:0] result_rsc_7_0_adrb;
  output [31:0] result_rsc_7_0_db;
  output result_rsc_7_0_web;
  input [31:0] result_rsc_7_0_qb;
  output result_rsc_triosy_7_0_lz;
  output [13:0] result_rsc_8_0_adra;
  output [31:0] result_rsc_8_0_da;
  output result_rsc_8_0_wea;
  input [31:0] result_rsc_8_0_qa;
  output [13:0] result_rsc_8_0_adrb;
  output [31:0] result_rsc_8_0_db;
  output result_rsc_8_0_web;
  input [31:0] result_rsc_8_0_qb;
  output result_rsc_triosy_8_0_lz;
  output [13:0] result_rsc_9_0_adra;
  output [31:0] result_rsc_9_0_da;
  output result_rsc_9_0_wea;
  input [31:0] result_rsc_9_0_qa;
  output [13:0] result_rsc_9_0_adrb;
  output [31:0] result_rsc_9_0_db;
  output result_rsc_9_0_web;
  input [31:0] result_rsc_9_0_qb;
  output result_rsc_triosy_9_0_lz;
  output [13:0] result_rsc_10_0_adra;
  output [31:0] result_rsc_10_0_da;
  output result_rsc_10_0_wea;
  input [31:0] result_rsc_10_0_qa;
  output [13:0] result_rsc_10_0_adrb;
  output [31:0] result_rsc_10_0_db;
  output result_rsc_10_0_web;
  input [31:0] result_rsc_10_0_qb;
  output result_rsc_triosy_10_0_lz;
  output [13:0] result_rsc_11_0_adra;
  output [31:0] result_rsc_11_0_da;
  output result_rsc_11_0_wea;
  input [31:0] result_rsc_11_0_qa;
  output [13:0] result_rsc_11_0_adrb;
  output [31:0] result_rsc_11_0_db;
  output result_rsc_11_0_web;
  input [31:0] result_rsc_11_0_qb;
  output result_rsc_triosy_11_0_lz;
  output [13:0] result_rsc_12_0_adra;
  output [31:0] result_rsc_12_0_da;
  output result_rsc_12_0_wea;
  input [31:0] result_rsc_12_0_qa;
  output [13:0] result_rsc_12_0_adrb;
  output [31:0] result_rsc_12_0_db;
  output result_rsc_12_0_web;
  input [31:0] result_rsc_12_0_qb;
  output result_rsc_triosy_12_0_lz;
  output [13:0] result_rsc_13_0_adra;
  output [31:0] result_rsc_13_0_da;
  output result_rsc_13_0_wea;
  input [31:0] result_rsc_13_0_qa;
  output [13:0] result_rsc_13_0_adrb;
  output [31:0] result_rsc_13_0_db;
  output result_rsc_13_0_web;
  input [31:0] result_rsc_13_0_qb;
  output result_rsc_triosy_13_0_lz;
  output [13:0] result_rsc_14_0_adra;
  output [31:0] result_rsc_14_0_da;
  output result_rsc_14_0_wea;
  input [31:0] result_rsc_14_0_qa;
  output [13:0] result_rsc_14_0_adrb;
  output [31:0] result_rsc_14_0_db;
  output result_rsc_14_0_web;
  input [31:0] result_rsc_14_0_qb;
  output result_rsc_triosy_14_0_lz;


  // Interconnect Declarations
  wire [13:0] vec_rsci_adra_d;
  wire [63:0] vec_rsci_qa_d;
  wire [1:0] vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_rsci_qa_d;
  wire [1:0] twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_h_rsci_qa_d;
  wire [1:0] twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [27:0] result_rsc_0_0_i_adra_d;
  wire [31:0] result_rsc_0_0_i_da_d;
  wire [63:0] result_rsc_0_0_i_qa_d;
  wire [1:0] result_rsc_0_0_i_wea_d;
  wire [1:0] result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_1_0_i_adra_d;
  wire [63:0] result_rsc_1_0_i_qa_d;
  wire [1:0] result_rsc_1_0_i_wea_d;
  wire [1:0] result_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_2_0_i_adra_d;
  wire [63:0] result_rsc_2_0_i_qa_d;
  wire [1:0] result_rsc_2_0_i_wea_d;
  wire [1:0] result_rsc_2_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_2_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_3_0_i_adra_d;
  wire [63:0] result_rsc_3_0_i_qa_d;
  wire [1:0] result_rsc_3_0_i_wea_d;
  wire [1:0] result_rsc_3_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_3_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_4_0_i_adra_d;
  wire [63:0] result_rsc_4_0_i_qa_d;
  wire [1:0] result_rsc_4_0_i_wea_d;
  wire [1:0] result_rsc_4_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_4_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_5_0_i_adra_d;
  wire [63:0] result_rsc_5_0_i_qa_d;
  wire [1:0] result_rsc_5_0_i_wea_d;
  wire [1:0] result_rsc_5_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_5_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_6_0_i_adra_d;
  wire [63:0] result_rsc_6_0_i_qa_d;
  wire [1:0] result_rsc_6_0_i_wea_d;
  wire [1:0] result_rsc_6_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_6_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_7_0_i_adra_d;
  wire [63:0] result_rsc_7_0_i_qa_d;
  wire [1:0] result_rsc_7_0_i_wea_d;
  wire [1:0] result_rsc_7_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_7_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_8_0_i_adra_d;
  wire [63:0] result_rsc_8_0_i_qa_d;
  wire [1:0] result_rsc_8_0_i_wea_d;
  wire [1:0] result_rsc_8_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_8_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_9_0_i_adra_d;
  wire [63:0] result_rsc_9_0_i_qa_d;
  wire [1:0] result_rsc_9_0_i_wea_d;
  wire [1:0] result_rsc_9_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_9_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_10_0_i_adra_d;
  wire [63:0] result_rsc_10_0_i_qa_d;
  wire [1:0] result_rsc_10_0_i_wea_d;
  wire [1:0] result_rsc_10_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_10_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_11_0_i_adra_d;
  wire [63:0] result_rsc_11_0_i_qa_d;
  wire [1:0] result_rsc_11_0_i_wea_d;
  wire [1:0] result_rsc_11_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_11_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_12_0_i_adra_d;
  wire [63:0] result_rsc_12_0_i_qa_d;
  wire [1:0] result_rsc_12_0_i_wea_d;
  wire [1:0] result_rsc_12_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_12_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_13_0_i_adra_d;
  wire [63:0] result_rsc_13_0_i_qa_d;
  wire [1:0] result_rsc_13_0_i_wea_d;
  wire [1:0] result_rsc_13_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_13_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] result_rsc_14_0_i_adra_d;
  wire [63:0] result_rsc_14_0_i_qa_d;
  wire [1:0] result_rsc_14_0_i_wea_d;
  wire [1:0] result_rsc_14_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] result_rsc_14_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [31:0] mult_z_mul_cmp_a;
  wire [31:0] mult_z_mul_cmp_b;
  wire [13:0] twiddle_rsci_adra_d_iff;
  wire [31:0] result_rsc_1_0_i_da_d_iff;


  // Interconnect Declarations for Component Instantiations 
  wire [27:0] nl_vec_rsci_adra_d;
  assign nl_vec_rsci_adra_d = {14'b00000000000000 , vec_rsci_adra_d};
  wire [27:0] nl_twiddle_rsci_adra_d;
  assign nl_twiddle_rsci_adra_d = {14'b00000000000000 , twiddle_rsci_adra_d_iff};
  wire [27:0] nl_twiddle_h_rsci_adra_d;
  assign nl_twiddle_h_rsci_adra_d = {14'b00000000000000 , twiddle_rsci_adra_d_iff};
  wire [63:0] nl_result_rsc_0_0_i_da_d;
  assign nl_result_rsc_0_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_0_0_i_da_d};
  wire [63:0] nl_result_rsc_1_0_i_da_d;
  assign nl_result_rsc_1_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_2_0_i_da_d;
  assign nl_result_rsc_2_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_3_0_i_da_d;
  assign nl_result_rsc_3_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_4_0_i_da_d;
  assign nl_result_rsc_4_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_5_0_i_da_d;
  assign nl_result_rsc_5_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_6_0_i_da_d;
  assign nl_result_rsc_6_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_7_0_i_da_d;
  assign nl_result_rsc_7_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_8_0_i_da_d;
  assign nl_result_rsc_8_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_9_0_i_da_d;
  assign nl_result_rsc_9_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_10_0_i_da_d;
  assign nl_result_rsc_10_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_11_0_i_da_d;
  assign nl_result_rsc_11_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_12_0_i_da_d;
  assign nl_result_rsc_12_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_13_0_i_da_d;
  assign nl_result_rsc_13_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [63:0] nl_result_rsc_14_0_i_da_d;
  assign nl_result_rsc_14_0_i_da_d = {32'b00000000000000000000000000000000 , result_rsc_1_0_i_da_d_iff};
  wire [31:0] nl_ntt_flat_core_inst_mult_z_mul_cmp_z;
  assign nl_ntt_flat_core_inst_mult_z_mul_cmp_z = conv_u2u_64_32(mult_z_mul_cmp_a
      * mult_z_mul_cmp_b);
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_1_14_32_16384_16384_32_1_gen vec_rsci
      (
      .qb(vec_rsc_qb),
      .web(vec_rsc_web),
      .db(vec_rsc_db),
      .adrb(vec_rsc_adrb),
      .qa(vec_rsc_qa),
      .wea(vec_rsc_wea),
      .da(vec_rsc_da),
      .adra(vec_rsc_adra),
      .adra_d(nl_vec_rsci_adra_d[27:0]),
      .da_d(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .qa_d(vec_rsci_qa_d),
      .wea_d(2'b00),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(2'b00)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_4_14_32_16384_16384_32_1_gen twiddle_rsci
      (
      .qb(twiddle_rsc_qb),
      .web(twiddle_rsc_web),
      .db(twiddle_rsc_db),
      .adrb(twiddle_rsc_adrb),
      .qa(twiddle_rsc_qa),
      .wea(twiddle_rsc_wea),
      .da(twiddle_rsc_da),
      .adra(twiddle_rsc_adra),
      .adra_d(nl_twiddle_rsci_adra_d[27:0]),
      .da_d(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .qa_d(twiddle_rsci_qa_d),
      .wea_d(2'b00),
      .rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(2'b00)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_5_14_32_16384_16384_32_1_gen twiddle_h_rsci
      (
      .qb(twiddle_h_rsc_qb),
      .web(twiddle_h_rsc_web),
      .db(twiddle_h_rsc_db),
      .adrb(twiddle_h_rsc_adrb),
      .qa(twiddle_h_rsc_qa),
      .wea(twiddle_h_rsc_wea),
      .da(twiddle_h_rsc_da),
      .adra(twiddle_h_rsc_adra),
      .adra_d(nl_twiddle_h_rsci_adra_d[27:0]),
      .da_d(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .qa_d(twiddle_h_rsci_qa_d),
      .wea_d(2'b00),
      .rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(2'b00)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_7_14_32_16384_16384_32_1_gen result_rsc_0_0_i
      (
      .qb(result_rsc_0_0_qb),
      .web(result_rsc_0_0_web),
      .db(result_rsc_0_0_db),
      .adrb(result_rsc_0_0_adrb),
      .qa(result_rsc_0_0_qa),
      .wea(result_rsc_0_0_wea),
      .da(result_rsc_0_0_da),
      .adra(result_rsc_0_0_adra),
      .adra_d(result_rsc_0_0_i_adra_d),
      .da_d(nl_result_rsc_0_0_i_da_d[63:0]),
      .qa_d(result_rsc_0_0_i_qa_d),
      .wea_d(result_rsc_0_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_8_14_32_16384_16384_32_1_gen result_rsc_1_0_i
      (
      .qb(result_rsc_1_0_qb),
      .web(result_rsc_1_0_web),
      .db(result_rsc_1_0_db),
      .adrb(result_rsc_1_0_adrb),
      .qa(result_rsc_1_0_qa),
      .wea(result_rsc_1_0_wea),
      .da(result_rsc_1_0_da),
      .adra(result_rsc_1_0_adra),
      .adra_d(result_rsc_1_0_i_adra_d),
      .da_d(nl_result_rsc_1_0_i_da_d[63:0]),
      .qa_d(result_rsc_1_0_i_qa_d),
      .wea_d(result_rsc_1_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_9_14_32_16384_16384_32_1_gen result_rsc_2_0_i
      (
      .qb(result_rsc_2_0_qb),
      .web(result_rsc_2_0_web),
      .db(result_rsc_2_0_db),
      .adrb(result_rsc_2_0_adrb),
      .qa(result_rsc_2_0_qa),
      .wea(result_rsc_2_0_wea),
      .da(result_rsc_2_0_da),
      .adra(result_rsc_2_0_adra),
      .adra_d(result_rsc_2_0_i_adra_d),
      .da_d(nl_result_rsc_2_0_i_da_d[63:0]),
      .qa_d(result_rsc_2_0_i_qa_d),
      .wea_d(result_rsc_2_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_2_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_2_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_10_14_32_16384_16384_32_1_gen result_rsc_3_0_i
      (
      .qb(result_rsc_3_0_qb),
      .web(result_rsc_3_0_web),
      .db(result_rsc_3_0_db),
      .adrb(result_rsc_3_0_adrb),
      .qa(result_rsc_3_0_qa),
      .wea(result_rsc_3_0_wea),
      .da(result_rsc_3_0_da),
      .adra(result_rsc_3_0_adra),
      .adra_d(result_rsc_3_0_i_adra_d),
      .da_d(nl_result_rsc_3_0_i_da_d[63:0]),
      .qa_d(result_rsc_3_0_i_qa_d),
      .wea_d(result_rsc_3_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_3_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_3_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_11_14_32_16384_16384_32_1_gen result_rsc_4_0_i
      (
      .qb(result_rsc_4_0_qb),
      .web(result_rsc_4_0_web),
      .db(result_rsc_4_0_db),
      .adrb(result_rsc_4_0_adrb),
      .qa(result_rsc_4_0_qa),
      .wea(result_rsc_4_0_wea),
      .da(result_rsc_4_0_da),
      .adra(result_rsc_4_0_adra),
      .adra_d(result_rsc_4_0_i_adra_d),
      .da_d(nl_result_rsc_4_0_i_da_d[63:0]),
      .qa_d(result_rsc_4_0_i_qa_d),
      .wea_d(result_rsc_4_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_4_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_4_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_12_14_32_16384_16384_32_1_gen result_rsc_5_0_i
      (
      .qb(result_rsc_5_0_qb),
      .web(result_rsc_5_0_web),
      .db(result_rsc_5_0_db),
      .adrb(result_rsc_5_0_adrb),
      .qa(result_rsc_5_0_qa),
      .wea(result_rsc_5_0_wea),
      .da(result_rsc_5_0_da),
      .adra(result_rsc_5_0_adra),
      .adra_d(result_rsc_5_0_i_adra_d),
      .da_d(nl_result_rsc_5_0_i_da_d[63:0]),
      .qa_d(result_rsc_5_0_i_qa_d),
      .wea_d(result_rsc_5_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_5_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_5_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_13_14_32_16384_16384_32_1_gen result_rsc_6_0_i
      (
      .qb(result_rsc_6_0_qb),
      .web(result_rsc_6_0_web),
      .db(result_rsc_6_0_db),
      .adrb(result_rsc_6_0_adrb),
      .qa(result_rsc_6_0_qa),
      .wea(result_rsc_6_0_wea),
      .da(result_rsc_6_0_da),
      .adra(result_rsc_6_0_adra),
      .adra_d(result_rsc_6_0_i_adra_d),
      .da_d(nl_result_rsc_6_0_i_da_d[63:0]),
      .qa_d(result_rsc_6_0_i_qa_d),
      .wea_d(result_rsc_6_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_6_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_6_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_14_14_32_16384_16384_32_1_gen result_rsc_7_0_i
      (
      .qb(result_rsc_7_0_qb),
      .web(result_rsc_7_0_web),
      .db(result_rsc_7_0_db),
      .adrb(result_rsc_7_0_adrb),
      .qa(result_rsc_7_0_qa),
      .wea(result_rsc_7_0_wea),
      .da(result_rsc_7_0_da),
      .adra(result_rsc_7_0_adra),
      .adra_d(result_rsc_7_0_i_adra_d),
      .da_d(nl_result_rsc_7_0_i_da_d[63:0]),
      .qa_d(result_rsc_7_0_i_qa_d),
      .wea_d(result_rsc_7_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_7_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_7_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_15_14_32_16384_16384_32_1_gen result_rsc_8_0_i
      (
      .qb(result_rsc_8_0_qb),
      .web(result_rsc_8_0_web),
      .db(result_rsc_8_0_db),
      .adrb(result_rsc_8_0_adrb),
      .qa(result_rsc_8_0_qa),
      .wea(result_rsc_8_0_wea),
      .da(result_rsc_8_0_da),
      .adra(result_rsc_8_0_adra),
      .adra_d(result_rsc_8_0_i_adra_d),
      .da_d(nl_result_rsc_8_0_i_da_d[63:0]),
      .qa_d(result_rsc_8_0_i_qa_d),
      .wea_d(result_rsc_8_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_8_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_8_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_16_14_32_16384_16384_32_1_gen result_rsc_9_0_i
      (
      .qb(result_rsc_9_0_qb),
      .web(result_rsc_9_0_web),
      .db(result_rsc_9_0_db),
      .adrb(result_rsc_9_0_adrb),
      .qa(result_rsc_9_0_qa),
      .wea(result_rsc_9_0_wea),
      .da(result_rsc_9_0_da),
      .adra(result_rsc_9_0_adra),
      .adra_d(result_rsc_9_0_i_adra_d),
      .da_d(nl_result_rsc_9_0_i_da_d[63:0]),
      .qa_d(result_rsc_9_0_i_qa_d),
      .wea_d(result_rsc_9_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_9_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_9_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_17_14_32_16384_16384_32_1_gen result_rsc_10_0_i
      (
      .qb(result_rsc_10_0_qb),
      .web(result_rsc_10_0_web),
      .db(result_rsc_10_0_db),
      .adrb(result_rsc_10_0_adrb),
      .qa(result_rsc_10_0_qa),
      .wea(result_rsc_10_0_wea),
      .da(result_rsc_10_0_da),
      .adra(result_rsc_10_0_adra),
      .adra_d(result_rsc_10_0_i_adra_d),
      .da_d(nl_result_rsc_10_0_i_da_d[63:0]),
      .qa_d(result_rsc_10_0_i_qa_d),
      .wea_d(result_rsc_10_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_10_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_10_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_18_14_32_16384_16384_32_1_gen result_rsc_11_0_i
      (
      .qb(result_rsc_11_0_qb),
      .web(result_rsc_11_0_web),
      .db(result_rsc_11_0_db),
      .adrb(result_rsc_11_0_adrb),
      .qa(result_rsc_11_0_qa),
      .wea(result_rsc_11_0_wea),
      .da(result_rsc_11_0_da),
      .adra(result_rsc_11_0_adra),
      .adra_d(result_rsc_11_0_i_adra_d),
      .da_d(nl_result_rsc_11_0_i_da_d[63:0]),
      .qa_d(result_rsc_11_0_i_qa_d),
      .wea_d(result_rsc_11_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_11_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_11_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_19_14_32_16384_16384_32_1_gen result_rsc_12_0_i
      (
      .qb(result_rsc_12_0_qb),
      .web(result_rsc_12_0_web),
      .db(result_rsc_12_0_db),
      .adrb(result_rsc_12_0_adrb),
      .qa(result_rsc_12_0_qa),
      .wea(result_rsc_12_0_wea),
      .da(result_rsc_12_0_da),
      .adra(result_rsc_12_0_adra),
      .adra_d(result_rsc_12_0_i_adra_d),
      .da_d(nl_result_rsc_12_0_i_da_d[63:0]),
      .qa_d(result_rsc_12_0_i_qa_d),
      .wea_d(result_rsc_12_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_12_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_12_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_20_14_32_16384_16384_32_1_gen result_rsc_13_0_i
      (
      .qb(result_rsc_13_0_qb),
      .web(result_rsc_13_0_web),
      .db(result_rsc_13_0_db),
      .adrb(result_rsc_13_0_adrb),
      .qa(result_rsc_13_0_qa),
      .wea(result_rsc_13_0_wea),
      .da(result_rsc_13_0_da),
      .adra(result_rsc_13_0_adra),
      .adra_d(result_rsc_13_0_i_adra_d),
      .da_d(nl_result_rsc_13_0_i_da_d[63:0]),
      .qa_d(result_rsc_13_0_i_qa_d),
      .wea_d(result_rsc_13_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_13_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_13_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_Xilinx_RAMS_BLOCK_DPRAM_RBW_rwport_21_14_32_16384_16384_32_1_gen result_rsc_14_0_i
      (
      .qb(result_rsc_14_0_qb),
      .web(result_rsc_14_0_web),
      .db(result_rsc_14_0_db),
      .adrb(result_rsc_14_0_adrb),
      .qa(result_rsc_14_0_qa),
      .wea(result_rsc_14_0_wea),
      .da(result_rsc_14_0_da),
      .adra(result_rsc_14_0_adra),
      .adra_d(result_rsc_14_0_i_adra_d),
      .da_d(nl_result_rsc_14_0_i_da_d[63:0]),
      .qa_d(result_rsc_14_0_i_qa_d),
      .wea_d(result_rsc_14_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_14_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_14_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  ntt_flat_core ntt_flat_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .twiddle_h_rsc_triosy_lz(twiddle_h_rsc_triosy_lz),
      .result_rsc_triosy_0_0_lz(result_rsc_triosy_0_0_lz),
      .result_rsc_triosy_1_0_lz(result_rsc_triosy_1_0_lz),
      .result_rsc_triosy_2_0_lz(result_rsc_triosy_2_0_lz),
      .result_rsc_triosy_3_0_lz(result_rsc_triosy_3_0_lz),
      .result_rsc_triosy_4_0_lz(result_rsc_triosy_4_0_lz),
      .result_rsc_triosy_5_0_lz(result_rsc_triosy_5_0_lz),
      .result_rsc_triosy_6_0_lz(result_rsc_triosy_6_0_lz),
      .result_rsc_triosy_7_0_lz(result_rsc_triosy_7_0_lz),
      .result_rsc_triosy_8_0_lz(result_rsc_triosy_8_0_lz),
      .result_rsc_triosy_9_0_lz(result_rsc_triosy_9_0_lz),
      .result_rsc_triosy_10_0_lz(result_rsc_triosy_10_0_lz),
      .result_rsc_triosy_11_0_lz(result_rsc_triosy_11_0_lz),
      .result_rsc_triosy_12_0_lz(result_rsc_triosy_12_0_lz),
      .result_rsc_triosy_13_0_lz(result_rsc_triosy_13_0_lz),
      .result_rsc_triosy_14_0_lz(result_rsc_triosy_14_0_lz),
      .vec_rsci_adra_d(vec_rsci_adra_d),
      .vec_rsci_qa_d(vec_rsci_qa_d),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .twiddle_rsci_qa_d(twiddle_rsci_qa_d),
      .twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .twiddle_h_rsci_qa_d(twiddle_h_rsci_qa_d),
      .twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(twiddle_h_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_0_0_i_adra_d(result_rsc_0_0_i_adra_d),
      .result_rsc_0_0_i_da_d(result_rsc_0_0_i_da_d),
      .result_rsc_0_0_i_qa_d(result_rsc_0_0_i_qa_d),
      .result_rsc_0_0_i_wea_d(result_rsc_0_0_i_wea_d),
      .result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_1_0_i_adra_d(result_rsc_1_0_i_adra_d),
      .result_rsc_1_0_i_qa_d(result_rsc_1_0_i_qa_d),
      .result_rsc_1_0_i_wea_d(result_rsc_1_0_i_wea_d),
      .result_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_1_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_1_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_2_0_i_adra_d(result_rsc_2_0_i_adra_d),
      .result_rsc_2_0_i_qa_d(result_rsc_2_0_i_qa_d),
      .result_rsc_2_0_i_wea_d(result_rsc_2_0_i_wea_d),
      .result_rsc_2_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_2_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_2_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_2_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_3_0_i_adra_d(result_rsc_3_0_i_adra_d),
      .result_rsc_3_0_i_qa_d(result_rsc_3_0_i_qa_d),
      .result_rsc_3_0_i_wea_d(result_rsc_3_0_i_wea_d),
      .result_rsc_3_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_3_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_3_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_3_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_4_0_i_adra_d(result_rsc_4_0_i_adra_d),
      .result_rsc_4_0_i_qa_d(result_rsc_4_0_i_qa_d),
      .result_rsc_4_0_i_wea_d(result_rsc_4_0_i_wea_d),
      .result_rsc_4_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_4_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_4_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_4_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_5_0_i_adra_d(result_rsc_5_0_i_adra_d),
      .result_rsc_5_0_i_qa_d(result_rsc_5_0_i_qa_d),
      .result_rsc_5_0_i_wea_d(result_rsc_5_0_i_wea_d),
      .result_rsc_5_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_5_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_5_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_5_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_6_0_i_adra_d(result_rsc_6_0_i_adra_d),
      .result_rsc_6_0_i_qa_d(result_rsc_6_0_i_qa_d),
      .result_rsc_6_0_i_wea_d(result_rsc_6_0_i_wea_d),
      .result_rsc_6_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_6_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_6_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_6_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_7_0_i_adra_d(result_rsc_7_0_i_adra_d),
      .result_rsc_7_0_i_qa_d(result_rsc_7_0_i_qa_d),
      .result_rsc_7_0_i_wea_d(result_rsc_7_0_i_wea_d),
      .result_rsc_7_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_7_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_7_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_7_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_8_0_i_adra_d(result_rsc_8_0_i_adra_d),
      .result_rsc_8_0_i_qa_d(result_rsc_8_0_i_qa_d),
      .result_rsc_8_0_i_wea_d(result_rsc_8_0_i_wea_d),
      .result_rsc_8_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_8_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_8_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_8_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_9_0_i_adra_d(result_rsc_9_0_i_adra_d),
      .result_rsc_9_0_i_qa_d(result_rsc_9_0_i_qa_d),
      .result_rsc_9_0_i_wea_d(result_rsc_9_0_i_wea_d),
      .result_rsc_9_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_9_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_9_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_9_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_10_0_i_adra_d(result_rsc_10_0_i_adra_d),
      .result_rsc_10_0_i_qa_d(result_rsc_10_0_i_qa_d),
      .result_rsc_10_0_i_wea_d(result_rsc_10_0_i_wea_d),
      .result_rsc_10_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_10_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_10_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_10_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_11_0_i_adra_d(result_rsc_11_0_i_adra_d),
      .result_rsc_11_0_i_qa_d(result_rsc_11_0_i_qa_d),
      .result_rsc_11_0_i_wea_d(result_rsc_11_0_i_wea_d),
      .result_rsc_11_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_11_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_11_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_11_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_12_0_i_adra_d(result_rsc_12_0_i_adra_d),
      .result_rsc_12_0_i_qa_d(result_rsc_12_0_i_qa_d),
      .result_rsc_12_0_i_wea_d(result_rsc_12_0_i_wea_d),
      .result_rsc_12_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_12_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_12_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_12_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_13_0_i_adra_d(result_rsc_13_0_i_adra_d),
      .result_rsc_13_0_i_qa_d(result_rsc_13_0_i_qa_d),
      .result_rsc_13_0_i_wea_d(result_rsc_13_0_i_wea_d),
      .result_rsc_13_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_13_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_13_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_13_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .result_rsc_14_0_i_adra_d(result_rsc_14_0_i_adra_d),
      .result_rsc_14_0_i_qa_d(result_rsc_14_0_i_qa_d),
      .result_rsc_14_0_i_wea_d(result_rsc_14_0_i_wea_d),
      .result_rsc_14_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(result_rsc_14_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .result_rsc_14_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(result_rsc_14_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .mult_z_mul_cmp_a(mult_z_mul_cmp_a),
      .mult_z_mul_cmp_b(mult_z_mul_cmp_b),
      .mult_z_mul_cmp_z(nl_ntt_flat_core_inst_mult_z_mul_cmp_z[31:0]),
      .twiddle_rsci_adra_d_pff(twiddle_rsci_adra_d_iff),
      .result_rsc_1_0_i_da_d_pff(result_rsc_1_0_i_da_d_iff)
    );

  function automatic [31:0] conv_u2u_64_32 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_32 = vector[31:0];
  end
  endfunction

endmodule



