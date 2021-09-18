
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

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/ccs_xilinx/hdl/BLOCK_DPRAM_RBW_DUAL.v 
// Memory Type:            BLOCK
// Operating Mode:         True Dual Port (2-Port)
// Clock Mode:             Dual Clock
// 
// RTL Code RW Resolution: RBW
// Catapult RW Resolution: RBW
// 
// HDL Work Library:       Xilinx_RAMS_lib
// Component Name:         BLOCK_DPRAM_RBW_DUAL
// Latency = 1:            RAM with no registers on inputs or outputs
//         = 2:            adds embedded register on RAM output
//         = 3:            adds fabric registers to non-clock input RAM pins
//         = 4:            adds fabric register to output (driven by embedded register from latency=2)

module BLOCK_DPRAM_RBW_DUAL #(
  parameter addr_width = 8 ,
  parameter data_width = 7 ,
  parameter depth = 256 ,
  parameter latency = 1 
  
)( adra,adrb,clka,clka_en,clkb,clkb_en,da,db,qa,qb,wea,web);

  input [addr_width-1:0] adra;
  input [addr_width-1:0] adrb;
  input  clka;
  input  clka_en;
  input  clkb;
  input  clkb_en;
  input [data_width-1:0] da;
  input [data_width-1:0] db;
  output [data_width-1:0] qa;
  output [data_width-1:0] qb;
  input  wea;
  input  web;
  
  (* ram_style = "block" *)
  reg [data_width-1:0] mem [depth-1:0];// synthesis syn_ramstyle="block"
  
  reg [data_width-1:0] ramqa;
  reg [data_width-1:0] ramqb;
  
  // Port Map
  // rwA :: ADDRESS adra CLOCK clka ENABLE clka_en DATA_IN da DATA_OUT qa WRITE_ENABLE wea
  // rwB :: ADDRESS adrb CLOCK clkb ENABLE clkb_en DATA_IN db DATA_OUT qb WRITE_ENABLE web

  generate
    // Register all non-clock inputs (latency < 3)
    if (latency > 2 ) begin
      reg [addr_width-1:0] adra_reg;
      reg [data_width-1:0] da_reg;
      reg wea_reg;
      reg [addr_width-1:0] adrb_reg;
      reg [data_width-1:0] db_reg;
      reg web_reg;
      
      always @(posedge clka) begin
        if (clka_en) begin
          adra_reg <= adra;
          da_reg <= da;
          wea_reg <= wea;
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
          adrb_reg <= adrb;
          db_reg <= db;
          web_reg <= web;
        end
      end
      
    // Access memory with registered inputs
      always @(posedge clka) begin
        if (clka_en) begin
            ramqa <= mem[adra_reg];
            if (wea_reg) begin
              mem[adra_reg] <= da_reg;
            end
        end
      end
      always @(posedge clka) begin
        if (clka_en) begin
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
            ramqb <= mem[adrb_reg];
            if (web_reg) begin
              mem[adrb_reg] <= db_reg;
            end
        end
      end
      
    end // END register inputs

    else begin
    // latency = 1||2: Access memory with non-registered inputs
      always @(posedge clka) begin
        if (clka_en) begin
            ramqa <= mem[adra];
            if (wea) begin
              mem[adra] <= da;
            end
        end
      end
      always @(posedge clka) begin
        if (clka_en) begin
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
            ramqb <= mem[adrb];
            if (web) begin
              mem[adrb] <= db;
            end
        end
      end
      
    end
  endgenerate //END input port generate 

  generate
    // latency=1: sequential RAM outputs drive module outputs
    if (latency == 1) begin
      assign qa = ramqa;
      assign qb = ramqb;
      
    end

    else if (latency == 2 || latency == 3) begin
    // latency=2: sequential (RAM output => tmp register => module output)
      reg [data_width-1:0] tmpqa;
      reg [data_width-1:0] tmpqb;
      
      always @(posedge clka) begin
        if (clka_en) begin
          tmpqa <= ramqa;
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
          tmpqb <= ramqb;
        end
      end
      
      assign qa = tmpqa;
      assign qb = tmpqb;
      
    end
    else if (latency == 4) begin
    // latency=4: (RAM => tmp1 register => tmp2 fabric register => module output)
      reg [data_width-1:0] tmp1qa;
      reg [data_width-1:0] tmp1qb;
      
      reg [data_width-1:0] tmp2qa;
      reg [data_width-1:0] tmp2qb;
      
      always @(posedge clka) begin
        if (clka_en) begin
          tmp1qa <= ramqa;
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
          tmp1qb <= ramqb;
        end
      end
      
      always @(posedge clka) begin
        if (clka_en) begin
          tmp2qa <= tmp1qa;
        end
      end
      always @(posedge clkb) begin
        if (clkb_en) begin
          tmp2qb <= tmp1qb;
        end
      end
      
      assign qa = tmp2qa;
      assign qb = tmp2qb;
      
    end
    else begin
      //Add error check if latency > 4 or add N-pipeline regs
    end
  endgenerate //END output port generate

endmodule

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   ls5382@newnano.poly.edu
//  Generated date: Thu Sep 16 18:53:22 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_22_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_22_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_21_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_21_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_20_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_20_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_19_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_19_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_18_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_18_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_17_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_17_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_16_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_16_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_15_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_15_14_32_16384_16384_32_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [31:0] q;
  output [13:0] radr;
  output [31:0] q_d;
  input [13:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_14_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_14_14_32_16384_16384_32_1_gen
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
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_14_32_16384_16384_32_1_gen
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
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_12_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_12_14_32_16384_16384_32_1_gen
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
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_11_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_11_14_32_16384_16384_32_1_gen
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
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_10_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_10_14_32_16384_16384_32_1_gen
    (
  clkb_en, clka_en, qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en_d,
      clkb_en_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  output clkb_en;
  output clka_en;
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
  input clka_en_d;
  input clkb_en_d;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clkb_en = clkb_en_d;
  assign clka_en = clka_en_d;
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
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_9_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_9_14_32_16384_16384_32_1_gen
    (
  clkb_en, clka_en, qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en_d,
      clkb_en_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  output clkb_en;
  output clka_en;
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
  input clka_en_d;
  input clkb_en_d;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clkb_en = clkb_en_d;
  assign clka_en = clka_en_d;
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
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_8_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_8_14_32_16384_16384_32_1_gen
    (
  clkb_en, clka_en, qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en_d,
      clkb_en_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  output clkb_en;
  output clka_en;
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
  input clka_en_d;
  input clkb_en_d;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clkb_en = clkb_en_d;
  assign clka_en = clka_en_d;
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
//  Design Unit:    peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_7_14_32_16384_16384_32_1_gen
// ------------------------------------------------------------------


module peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_7_14_32_16384_16384_32_1_gen
    (
  clkb_en, clka_en, qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en_d,
      clkb_en_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  output clkb_en;
  output clka_en;
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
  input clka_en_d;
  input clkb_en_d;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clkb_en = clkb_en_d;
  assign clka_en = clka_en_d;
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
//  Design Unit:    peaseNTT_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module peaseNTT_core_core_fsm (
  clk, rst, fsm_output, INNER_LOOP1_C_0_tr0, INNER_LOOP2_C_0_tr0, STAGE_LOOP_C_2_tr0,
      INNER_LOOP3_C_0_tr0, INNER_LOOP4_C_0_tr0
);
  input clk;
  input rst;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
  input INNER_LOOP1_C_0_tr0;
  input INNER_LOOP2_C_0_tr0;
  input STAGE_LOOP_C_2_tr0;
  input INNER_LOOP3_C_0_tr0;
  input INNER_LOOP4_C_0_tr0;


  // FSM State Type Declaration for peaseNTT_core_core_fsm_1
  parameter
    main_C_0 = 4'd0,
    STAGE_LOOP_C_0 = 4'd1,
    INNER_LOOP1_C_0 = 4'd2,
    STAGE_LOOP_C_1 = 4'd3,
    INNER_LOOP2_C_0 = 4'd4,
    STAGE_LOOP_C_2 = 4'd5,
    INNER_LOOP3_C_0 = 4'd6,
    INNER_LOOP4_C_0 = 4'd7,
    main_C_1 = 4'd8;

  reg [3:0] state_var;
  reg [3:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : peaseNTT_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 9'b000000010;
        state_var_NS = INNER_LOOP1_C_0;
      end
      INNER_LOOP1_C_0 : begin
        fsm_output = 9'b000000100;
        if ( INNER_LOOP1_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = INNER_LOOP1_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 9'b000001000;
        state_var_NS = INNER_LOOP2_C_0;
      end
      INNER_LOOP2_C_0 : begin
        fsm_output = 9'b000010000;
        if ( INNER_LOOP2_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_2;
        end
        else begin
          state_var_NS = INNER_LOOP2_C_0;
        end
      end
      STAGE_LOOP_C_2 : begin
        fsm_output = 9'b000100000;
        if ( STAGE_LOOP_C_2_tr0 ) begin
          state_var_NS = INNER_LOOP3_C_0;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      INNER_LOOP3_C_0 : begin
        fsm_output = 9'b001000000;
        if ( INNER_LOOP3_C_0_tr0 ) begin
          state_var_NS = INNER_LOOP4_C_0;
        end
        else begin
          state_var_NS = INNER_LOOP3_C_0;
        end
      end
      INNER_LOOP4_C_0 : begin
        fsm_output = 9'b010000000;
        if ( INNER_LOOP4_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = INNER_LOOP4_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b100000000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 9'b000000001;
        state_var_NS = STAGE_LOOP_C_0;
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
//  Design Unit:    peaseNTT_core_wait_dp
// ------------------------------------------------------------------


module peaseNTT_core_wait_dp (
  clk, yt_rsc_0_0_cgo_iro, yt_rsc_0_0_i_clka_en_d, ensig_cgo_iro, mult_z_mul_cmp_z,
      mult_z_mul_cmp_1_z, mult_z_mul_cmp_2_z, mult_z_mul_cmp_3_z, mult_z_mul_cmp_4_z,
      mult_z_mul_cmp_5_z, mult_z_mul_cmp_6_z, mult_z_mul_cmp_7_z, yt_rsc_0_0_cgo,
      ensig_cgo, mult_t_mul_cmp_en, mult_z_mul_cmp_z_oreg, mult_z_mul_cmp_1_z_oreg,
      mult_z_mul_cmp_2_z_oreg, mult_z_mul_cmp_3_z_oreg, mult_z_mul_cmp_4_z_oreg,
      mult_z_mul_cmp_5_z_oreg, mult_z_mul_cmp_6_z_oreg, mult_z_mul_cmp_7_z_oreg
);
  input clk;
  input yt_rsc_0_0_cgo_iro;
  output yt_rsc_0_0_i_clka_en_d;
  input ensig_cgo_iro;
  input [31:0] mult_z_mul_cmp_z;
  input [31:0] mult_z_mul_cmp_1_z;
  input [31:0] mult_z_mul_cmp_2_z;
  input [31:0] mult_z_mul_cmp_3_z;
  input [31:0] mult_z_mul_cmp_4_z;
  input [31:0] mult_z_mul_cmp_5_z;
  input [31:0] mult_z_mul_cmp_6_z;
  input [31:0] mult_z_mul_cmp_7_z;
  input yt_rsc_0_0_cgo;
  input ensig_cgo;
  output mult_t_mul_cmp_en;
  output [31:0] mult_z_mul_cmp_z_oreg;
  reg [31:0] mult_z_mul_cmp_z_oreg;
  output [31:0] mult_z_mul_cmp_1_z_oreg;
  reg [31:0] mult_z_mul_cmp_1_z_oreg;
  output [31:0] mult_z_mul_cmp_2_z_oreg;
  reg [31:0] mult_z_mul_cmp_2_z_oreg;
  output [31:0] mult_z_mul_cmp_3_z_oreg;
  reg [31:0] mult_z_mul_cmp_3_z_oreg;
  output [31:0] mult_z_mul_cmp_4_z_oreg;
  reg [31:0] mult_z_mul_cmp_4_z_oreg;
  output [31:0] mult_z_mul_cmp_5_z_oreg;
  reg [31:0] mult_z_mul_cmp_5_z_oreg;
  output [31:0] mult_z_mul_cmp_6_z_oreg;
  reg [31:0] mult_z_mul_cmp_6_z_oreg;
  output [31:0] mult_z_mul_cmp_7_z_oreg;
  reg [31:0] mult_z_mul_cmp_7_z_oreg;



  // Interconnect Declarations for Component Instantiations 
  assign yt_rsc_0_0_i_clka_en_d = yt_rsc_0_0_cgo | yt_rsc_0_0_cgo_iro;
  assign mult_t_mul_cmp_en = ensig_cgo | ensig_cgo_iro;
  always @(posedge clk) begin
    mult_z_mul_cmp_z_oreg <= mult_z_mul_cmp_z;
    mult_z_mul_cmp_1_z_oreg <= mult_z_mul_cmp_1_z;
    mult_z_mul_cmp_2_z_oreg <= mult_z_mul_cmp_2_z;
    mult_z_mul_cmp_3_z_oreg <= mult_z_mul_cmp_3_z;
    mult_z_mul_cmp_4_z_oreg <= mult_z_mul_cmp_4_z;
    mult_z_mul_cmp_5_z_oreg <= mult_z_mul_cmp_5_z;
    mult_z_mul_cmp_6_z_oreg <= mult_z_mul_cmp_6_z;
    mult_z_mul_cmp_7_z_oreg <= mult_z_mul_cmp_7_z;
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT_core
// ------------------------------------------------------------------


module peaseNTT_core (
  clk, rst, xt_rsc_triosy_0_0_lz, xt_rsc_triosy_0_1_lz, xt_rsc_triosy_0_2_lz, xt_rsc_triosy_0_3_lz,
      p_rsc_dat, p_rsc_triosy_lz, r_rsc_triosy_lz, twiddle_rsc_triosy_0_0_lz, twiddle_rsc_triosy_0_1_lz,
      twiddle_rsc_triosy_0_2_lz, twiddle_rsc_triosy_0_3_lz, twiddle_h_rsc_triosy_0_0_lz,
      twiddle_h_rsc_triosy_0_1_lz, twiddle_h_rsc_triosy_0_2_lz, twiddle_h_rsc_triosy_0_3_lz,
      yt_rsc_0_0_i_adra_d, yt_rsc_0_0_i_clka_en_d, yt_rsc_0_0_i_da_d, yt_rsc_0_0_i_qa_d,
      yt_rsc_0_0_i_wea_d, yt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d, yt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      yt_rsc_0_1_i_adra_d, yt_rsc_0_1_i_da_d, yt_rsc_0_1_i_qa_d, yt_rsc_0_1_i_wea_d,
      yt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d, yt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      yt_rsc_0_2_i_adra_d, yt_rsc_0_2_i_da_d, yt_rsc_0_2_i_qa_d, yt_rsc_0_2_i_wea_d,
      yt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d, yt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      yt_rsc_0_3_i_adra_d, yt_rsc_0_3_i_da_d, yt_rsc_0_3_i_qa_d, yt_rsc_0_3_i_wea_d,
      yt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d, yt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      xt_rsc_0_0_i_adra_d, xt_rsc_0_0_i_da_d, xt_rsc_0_0_i_qa_d, xt_rsc_0_0_i_wea_d,
      xt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d, xt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      xt_rsc_0_1_i_adra_d, xt_rsc_0_1_i_da_d, xt_rsc_0_1_i_qa_d, xt_rsc_0_1_i_wea_d,
      xt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d, xt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      xt_rsc_0_2_i_adra_d, xt_rsc_0_2_i_da_d, xt_rsc_0_2_i_qa_d, xt_rsc_0_2_i_wea_d,
      xt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d, xt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      xt_rsc_0_3_i_adra_d, xt_rsc_0_3_i_da_d, xt_rsc_0_3_i_qa_d, xt_rsc_0_3_i_wea_d,
      xt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d, xt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d,
      twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_0_i_radr_d, twiddle_rsc_0_1_i_q_d, twiddle_rsc_0_1_i_radr_d,
      twiddle_rsc_0_2_i_q_d, twiddle_rsc_0_2_i_radr_d, twiddle_rsc_0_3_i_q_d, twiddle_rsc_0_3_i_radr_d,
      twiddle_h_rsc_0_0_i_q_d, twiddle_h_rsc_0_0_i_radr_d, twiddle_h_rsc_0_1_i_q_d,
      twiddle_h_rsc_0_1_i_radr_d, twiddle_h_rsc_0_2_i_q_d, twiddle_h_rsc_0_2_i_radr_d,
      twiddle_h_rsc_0_3_i_q_d, twiddle_h_rsc_0_3_i_radr_d, mult_z_mul_cmp_a, mult_z_mul_cmp_b,
      mult_z_mul_cmp_z, mult_z_mul_cmp_1_a, mult_z_mul_cmp_1_b, mult_z_mul_cmp_1_z,
      mult_z_mul_cmp_2_a, mult_z_mul_cmp_2_b, mult_z_mul_cmp_2_z, mult_z_mul_cmp_3_a,
      mult_z_mul_cmp_3_z, mult_z_mul_cmp_4_a, mult_z_mul_cmp_4_b, mult_z_mul_cmp_4_z,
      mult_z_mul_cmp_5_a, mult_z_mul_cmp_5_z, mult_z_mul_cmp_6_a, mult_z_mul_cmp_6_b,
      mult_z_mul_cmp_6_z, mult_z_mul_cmp_7_a, mult_z_mul_cmp_7_z, twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_pff,
      twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_pff, twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_pff
);
  input clk;
  input rst;
  output xt_rsc_triosy_0_0_lz;
  output xt_rsc_triosy_0_1_lz;
  output xt_rsc_triosy_0_2_lz;
  output xt_rsc_triosy_0_3_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_0_0_lz;
  output twiddle_rsc_triosy_0_1_lz;
  output twiddle_rsc_triosy_0_2_lz;
  output twiddle_rsc_triosy_0_3_lz;
  output twiddle_h_rsc_triosy_0_0_lz;
  output twiddle_h_rsc_triosy_0_1_lz;
  output twiddle_h_rsc_triosy_0_2_lz;
  output twiddle_h_rsc_triosy_0_3_lz;
  output [27:0] yt_rsc_0_0_i_adra_d;
  output yt_rsc_0_0_i_clka_en_d;
  output [63:0] yt_rsc_0_0_i_da_d;
  input [63:0] yt_rsc_0_0_i_qa_d;
  output [1:0] yt_rsc_0_0_i_wea_d;
  output [1:0] yt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] yt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] yt_rsc_0_1_i_adra_d;
  output [63:0] yt_rsc_0_1_i_da_d;
  input [63:0] yt_rsc_0_1_i_qa_d;
  output [1:0] yt_rsc_0_1_i_wea_d;
  output [1:0] yt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] yt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] yt_rsc_0_2_i_adra_d;
  output [63:0] yt_rsc_0_2_i_da_d;
  input [63:0] yt_rsc_0_2_i_qa_d;
  output [1:0] yt_rsc_0_2_i_wea_d;
  output [1:0] yt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] yt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] yt_rsc_0_3_i_adra_d;
  output [63:0] yt_rsc_0_3_i_da_d;
  input [63:0] yt_rsc_0_3_i_qa_d;
  output [1:0] yt_rsc_0_3_i_wea_d;
  output [1:0] yt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] yt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] xt_rsc_0_0_i_adra_d;
  output [63:0] xt_rsc_0_0_i_da_d;
  input [63:0] xt_rsc_0_0_i_qa_d;
  output [1:0] xt_rsc_0_0_i_wea_d;
  output [1:0] xt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] xt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] xt_rsc_0_1_i_adra_d;
  output [63:0] xt_rsc_0_1_i_da_d;
  input [63:0] xt_rsc_0_1_i_qa_d;
  output [1:0] xt_rsc_0_1_i_wea_d;
  output [1:0] xt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] xt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] xt_rsc_0_2_i_adra_d;
  output [63:0] xt_rsc_0_2_i_da_d;
  input [63:0] xt_rsc_0_2_i_qa_d;
  output [1:0] xt_rsc_0_2_i_wea_d;
  output [1:0] xt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] xt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  output [27:0] xt_rsc_0_3_i_adra_d;
  output [63:0] xt_rsc_0_3_i_da_d;
  input [63:0] xt_rsc_0_3_i_qa_d;
  output [1:0] xt_rsc_0_3_i_wea_d;
  output [1:0] xt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [1:0] xt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  input [31:0] twiddle_rsc_0_0_i_q_d;
  output [13:0] twiddle_rsc_0_0_i_radr_d;
  input [31:0] twiddle_rsc_0_1_i_q_d;
  output [13:0] twiddle_rsc_0_1_i_radr_d;
  input [31:0] twiddle_rsc_0_2_i_q_d;
  output [13:0] twiddle_rsc_0_2_i_radr_d;
  input [31:0] twiddle_rsc_0_3_i_q_d;
  output [13:0] twiddle_rsc_0_3_i_radr_d;
  input [31:0] twiddle_h_rsc_0_0_i_q_d;
  output [13:0] twiddle_h_rsc_0_0_i_radr_d;
  input [31:0] twiddle_h_rsc_0_1_i_q_d;
  output [13:0] twiddle_h_rsc_0_1_i_radr_d;
  input [31:0] twiddle_h_rsc_0_2_i_q_d;
  output [13:0] twiddle_h_rsc_0_2_i_radr_d;
  input [31:0] twiddle_h_rsc_0_3_i_q_d;
  output [13:0] twiddle_h_rsc_0_3_i_radr_d;
  output [31:0] mult_z_mul_cmp_a;
  reg [31:0] mult_z_mul_cmp_a;
  output [31:0] mult_z_mul_cmp_b;
  reg [31:0] mult_z_mul_cmp_b;
  input [31:0] mult_z_mul_cmp_z;
  output [31:0] mult_z_mul_cmp_1_a;
  reg [31:0] mult_z_mul_cmp_1_a;
  output [31:0] mult_z_mul_cmp_1_b;
  input [31:0] mult_z_mul_cmp_1_z;
  output [31:0] mult_z_mul_cmp_2_a;
  reg [31:0] mult_z_mul_cmp_2_a;
  output [31:0] mult_z_mul_cmp_2_b;
  reg [31:0] mult_z_mul_cmp_2_b;
  input [31:0] mult_z_mul_cmp_2_z;
  output [31:0] mult_z_mul_cmp_3_a;
  reg [31:0] mult_z_mul_cmp_3_a;
  input [31:0] mult_z_mul_cmp_3_z;
  output [31:0] mult_z_mul_cmp_4_a;
  reg [31:0] mult_z_mul_cmp_4_a;
  output [31:0] mult_z_mul_cmp_4_b;
  reg [31:0] mult_z_mul_cmp_4_b;
  input [31:0] mult_z_mul_cmp_4_z;
  output [31:0] mult_z_mul_cmp_5_a;
  reg [31:0] mult_z_mul_cmp_5_a;
  input [31:0] mult_z_mul_cmp_5_z;
  output [31:0] mult_z_mul_cmp_6_a;
  reg [31:0] mult_z_mul_cmp_6_a;
  output [31:0] mult_z_mul_cmp_6_b;
  reg [31:0] mult_z_mul_cmp_6_b;
  input [31:0] mult_z_mul_cmp_6_z;
  output [31:0] mult_z_mul_cmp_7_a;
  reg [31:0] mult_z_mul_cmp_7_a;
  input [31:0] mult_z_mul_cmp_7_z;
  output twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_pff;
  output twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_pff;
  output twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_pff;


  // Interconnect Declarations
  wire [31:0] p_rsci_idat;
  wire mult_t_mul_cmp_en;
  wire [63:0] mult_t_mul_cmp_z;
  wire [63:0] mult_t_mul_cmp_1_z;
  wire [63:0] mult_t_mul_cmp_2_z;
  wire [63:0] mult_t_mul_cmp_3_z;
  wire [31:0] mult_z_mul_cmp_z_oreg;
  wire [31:0] mult_z_mul_cmp_1_z_oreg;
  wire [31:0] mult_z_mul_cmp_2_z_oreg;
  wire [31:0] mult_z_mul_cmp_3_z_oreg;
  wire [31:0] mult_z_mul_cmp_4_z_oreg;
  wire [31:0] mult_z_mul_cmp_5_z_oreg;
  wire [31:0] mult_z_mul_cmp_6_z_oreg;
  wire [31:0] mult_z_mul_cmp_7_z_oreg;
  wire [8:0] fsm_output;
  wire INNER_LOOP4_nor_tmp;
  wire INNER_LOOP2_nor_tmp;
  wire or_dcpl_2;
  wire or_dcpl_3;
  wire or_dcpl_14;
  wire or_tmp_153;
  wire or_tmp_232;
  wire and_206_cse;
  wire and_207_cse;
  reg [31:0] tmp_14_sva_6;
  wire [31:0] mult_15_res_lpi_2_dfm_mx0;
  reg [31:0] tmp_12_sva_6;
  wire [31:0] mult_14_res_lpi_2_dfm_mx0;
  reg [31:0] tmp_10_sva_6;
  wire [31:0] mult_13_res_lpi_2_dfm_mx0;
  reg [31:0] tmp_8_sva_6;
  wire [31:0] mult_12_res_lpi_2_dfm_mx0;
  wire [31:0] mult_11_res_lpi_2_dfm_mx0;
  wire [31:0] mult_10_res_lpi_2_dfm_mx0;
  wire [31:0] mult_9_res_lpi_2_dfm_mx0;
  wire [31:0] mult_8_res_lpi_2_dfm_mx0;
  reg [31:0] tmp_6_sva_6;
  wire [31:0] mult_7_res_lpi_3_dfm_mx0;
  reg [31:0] tmp_4_sva_6;
  wire [31:0] mult_6_res_lpi_3_dfm_mx0;
  reg [31:0] tmp_2_sva_6;
  wire [31:0] mult_5_res_lpi_3_dfm_mx0;
  reg [31:0] tmp_sva_6;
  wire [31:0] mult_4_res_lpi_3_dfm_mx0;
  wire [31:0] mult_3_res_lpi_3_dfm_mx0;
  wire [31:0] mult_2_res_lpi_3_dfm_mx0;
  wire [31:0] mult_1_res_lpi_3_dfm_mx0;
  wire [31:0] mult_res_lpi_3_dfm_mx0;
  reg INNER_LOOP1_stage_0_4;
  reg INNER_LOOP1_stage_0_2;
  reg INNER_LOOP4_stage_0_4;
  reg INNER_LOOP4_stage_0_3;
  reg INNER_LOOP4_stage_0_7;
  reg INNER_LOOP4_stage_0_5;
  reg INNER_LOOP4_stage_0_6;
  reg INNER_LOOP4_stage_0_8;
  reg INNER_LOOP1_stage_0_10;
  reg INNER_LOOP1_stage_0_9;
  reg INNER_LOOP2_stage_0_2;
  reg INNER_LOOP2_stage_0;
  reg INNER_LOOP4_stage_0_9;
  reg INNER_LOOP2_stage_0_9;
  reg INNER_LOOP4_stage_0_2;
  reg INNER_LOOP1_stage_0_3;
  reg INNER_LOOP2_stage_0_4;
  reg INNER_LOOP2_stage_0_3;
  reg INNER_LOOP1_r_asn_11_itm_1;
  reg INNER_LOOP1_stage_0;
  reg INNER_LOOP2_r_asn_10_itm_1;
  reg mult_7_slc_32_svs_st_1;
  reg mult_6_slc_32_svs_st_1;
  reg mult_5_slc_32_svs_st_1;
  reg mult_4_slc_32_svs_st_1;
  reg INNER_LOOP3_r_asn_14_itm_1;
  reg INNER_LOOP3_stage_0;
  reg INNER_LOOP4_r_asn_18_itm_1;
  reg INNER_LOOP4_stage_0;
  reg mult_15_slc_32_svs_st_1;
  reg mult_14_slc_32_svs_st_1;
  reg mult_13_slc_32_svs_st_1;
  reg mult_12_slc_32_svs_st_1;
  reg [31:0] modulo_add_base_15_sva_1;
  wire [32:0] nl_modulo_add_base_15_sva_1;
  reg [31:0] modulo_add_base_14_sva_1;
  wire [32:0] nl_modulo_add_base_14_sva_1;
  reg [31:0] modulo_add_base_13_sva_1;
  reg [31:0] modulo_add_base_12_sva_1;
  wire [31:0] mult_15_res_sva_2;
  wire [32:0] nl_mult_15_res_sva_2;
  wire [31:0] mult_14_res_sva_2;
  wire [32:0] nl_mult_14_res_sva_2;
  wire [31:0] mult_13_res_sva_2;
  wire [32:0] nl_mult_13_res_sva_2;
  wire [31:0] mult_12_res_sva_2;
  wire [32:0] nl_mult_12_res_sva_2;
  reg [31:0] modulo_add_base_11_sva_1;
  wire [32:0] nl_modulo_add_base_11_sva_1;
  reg [31:0] modulo_add_base_10_sva_1;
  wire [32:0] nl_modulo_add_base_10_sva_1;
  reg [31:0] modulo_add_base_9_sva_1;
  reg [31:0] modulo_add_base_8_sva_1;
  wire [31:0] mult_11_res_sva_2;
  wire [32:0] nl_mult_11_res_sva_2;
  wire [31:0] mult_10_res_sva_2;
  wire [32:0] nl_mult_10_res_sva_2;
  wire [31:0] mult_9_res_sva_2;
  wire [32:0] nl_mult_9_res_sva_2;
  wire [31:0] mult_8_res_sva_2;
  wire [32:0] nl_mult_8_res_sva_2;
  reg [31:0] modulo_add_base_7_sva_1;
  wire [32:0] nl_modulo_add_base_7_sva_1;
  reg [31:0] modulo_add_base_6_sva_1;
  wire [32:0] nl_modulo_add_base_6_sva_1;
  reg [31:0] modulo_add_base_5_sva_1;
  reg [31:0] modulo_add_base_4_sva_1;
  wire [31:0] mult_7_res_sva_2;
  wire [32:0] nl_mult_7_res_sva_2;
  wire [31:0] mult_6_res_sva_2;
  wire [32:0] nl_mult_6_res_sva_2;
  wire [31:0] mult_5_res_sva_2;
  wire [32:0] nl_mult_5_res_sva_2;
  wire [31:0] mult_4_res_sva_2;
  wire [32:0] nl_mult_4_res_sva_2;
  reg [31:0] modulo_add_base_3_sva_1;
  wire [32:0] nl_modulo_add_base_3_sva_1;
  reg [31:0] modulo_add_base_2_sva_1;
  reg [31:0] modulo_add_base_1_sva_1;
  wire [32:0] nl_modulo_add_base_1_sva_1;
  reg [31:0] modulo_add_base_sva_1;
  wire [31:0] mult_3_res_sva_2;
  wire [32:0] nl_mult_3_res_sva_2;
  wire [31:0] mult_2_res_sva_2;
  wire [32:0] nl_mult_2_res_sva_2;
  wire [31:0] mult_1_res_sva_2;
  wire [32:0] nl_mult_1_res_sva_2;
  wire [31:0] mult_res_sva_2;
  wire [32:0] nl_mult_res_sva_2;
  reg [31:0] p_sva;
  wire butterFly1_3_f2_and_ssc;
  wire butterFly1_3_f2_and_ssc_2;
  wire butterFly1_3_f1_and_ssc;
  wire butterFly1_3_f1_and_ssc_2;
  wire butterFly1_2_f2_and_ssc;
  wire butterFly1_2_f2_and_ssc_2;
  wire butterFly1_2_f1_and_ssc;
  wire butterFly1_2_f1_and_ssc_2;
  wire butterFly1_3_and_ssc;
  wire butterFly1_3_and_ssc_2;
  wire butterFly1_2_and_ssc;
  wire butterFly1_2_and_ssc_2;
  wire butterFly1_1_and_ssc;
  wire butterFly1_1_and_ssc_2;
  wire butterFly1_and_ssc;
  wire butterFly1_and_ssc_2;
  reg reg_yt_rsc_0_0_cgo_cse;
  reg reg_xt_rsc_triosy_0_3_obj_ld_cse;
  reg reg_ensig_cgo_cse;
  reg [31:0] reg_mult_z_mul_cmp_1_b_cse;
  wire butterFly1_mux_4_cse;
  wire butterFly1_mux_5_cse;
  wire butterFly1_nor_1_cse;
  wire butterFly1_nor_2_cse;
  wire butterFly1_3_f2_mux_16_cse;
  wire butterFly1_3_f2_mux_17_cse;
  reg [31:0] modulo_sub_base_7_sva_1;
  wire [32:0] nl_modulo_sub_base_7_sva_1;
  reg [31:0] modulo_sub_base_15_sva_1;
  wire [32:0] nl_modulo_sub_base_15_sva_1;
  reg [31:0] modulo_sub_base_6_sva_1;
  wire [32:0] nl_modulo_sub_base_6_sva_1;
  reg [31:0] modulo_sub_base_14_sva_1;
  wire [32:0] nl_modulo_sub_base_14_sva_1;
  reg [31:0] modulo_sub_base_5_sva_1;
  reg [31:0] modulo_sub_base_13_sva_1;
  reg [31:0] modulo_sub_base_4_sva_1;
  reg [31:0] modulo_sub_base_12_sva_1;
  reg [31:0] modulo_sub_base_3_sva_1;
  wire [32:0] nl_modulo_sub_base_3_sva_1;
  reg [31:0] modulo_sub_base_11_sva_1;
  wire [32:0] nl_modulo_sub_base_11_sva_1;
  reg [31:0] modulo_sub_base_2_sva_1;
  reg [31:0] modulo_sub_base_10_sva_1;
  wire [32:0] nl_modulo_sub_base_10_sva_1;
  reg [31:0] modulo_sub_base_1_sva_1;
  wire [32:0] nl_modulo_sub_base_1_sva_1;
  reg [31:0] modulo_sub_base_9_sva_1;
  reg [31:0] modulo_sub_base_sva_1;
  reg [31:0] modulo_sub_base_8_sva_1;
  wire or_39_rmff;
  wire butterFly1_butterFly1_or_rmff;
  wire [11:0] butterFly1_mux1h_1_rmff;
  wire butterFly1_butterFly1_and_4_rmff;
  wire butterFly1_butterFly1_and_5_rmff;
  wire butterFly1_butterFly1_or_1_rmff;
  wire butterFly1_butterFly1_butterFly1_and_rmff;
  wire or_52_rmff;
  wire butterFly1_3_f2_butterFly1_3_f2_and_10_rmff;
  wire [11:0] butterFly1_3_f2_mux1h_rmff;
  wire butterFly1_3_f2_butterFly1_3_f2_or_6_rmff;
  wire butterFly1_3_f2_butterFly1_3_f2_or_7_rmff;
  wire butterFly1_3_f2_butterFly1_3_f2_and_11_rmff;
  wire butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff;
  wire or_112_rmff;
  wire INNER_LOOP1_tw_h_INNER_LOOP1_tw_h_nor_1_rmff;
  wire [12:0] INNER_LOOP1_tw_h_mux1h_rmff;
  wire butterFly2_2_tw_butterFly2_2_tw_nor_rmff;
  wire [12:0] butterFly2_2_tw_butterFly2_2_tw_mux_rmff;
  wire or_182_rmff;
  wire [12:0] INNER_LOOP4_r_15_2_sva_12_0_mx1;
  wire [31:0] z_out;
  wire [32:0] nl_z_out;
  wire [31:0] z_out_1;
  wire [31:0] z_out_2;
  wire [32:0] nl_z_out_2;
  wire [31:0] z_out_3;
  wire [31:0] z_out_5;
  wire [32:0] nl_z_out_5;
  wire [31:0] z_out_6;
  wire [32:0] nl_z_out_6;
  wire [31:0] z_out_7;
  wire [32:0] nl_z_out_7;
  wire [31:0] z_out_8;
  wire [32:0] nl_z_out_8;
  wire [31:0] z_out_9;
  wire [31:0] z_out_10;
  wire [32:0] nl_z_out_10;
  wire [31:0] z_out_11;
  wire [31:0] z_out_12;
  wire [32:0] nl_z_out_12;
  wire [31:0] z_out_14;
  wire [32:0] nl_z_out_14;
  wire [31:0] z_out_15;
  wire [32:0] nl_z_out_15;
  wire [31:0] z_out_16;
  wire [31:0] z_out_17;
  wire [31:0] z_out_18;
  wire [31:0] z_out_19;
  wire [31:0] z_out_20;
  wire [31:0] z_out_21;
  wire [31:0] z_out_22;
  wire [31:0] z_out_23;
  wire [31:0] z_out_24;
  wire [31:0] z_out_26;
  wire [31:0] z_out_27;
  wire [32:0] nl_z_out_27;
  wire [31:0] z_out_29;
  wire [32:0] nl_z_out_29;
  wire [13:0] z_out_30;
  wire [14:0] nl_z_out_30;
  wire [14:0] z_out_43;
  wire [2:0] z_out_44;
  wire [3:0] nl_z_out_44;
  reg [2:0] c_3_1_sva;
  reg [2:0] operator_32_false_acc_psp_sva;
  reg [12:0] operator_34_true_return_14_2_sva;
  reg [11:0] operator_34_true_1_lshift_psp_13_2_sva;
  reg INNER_LOOP1_stage_0_5;
  reg INNER_LOOP1_stage_0_6;
  reg INNER_LOOP1_stage_0_7;
  reg INNER_LOOP1_stage_0_8;
  reg [31:0] tmp_16_sva_1;
  reg [31:0] tmp_16_sva_2;
  reg [31:0] tmp_16_sva_4;
  reg [31:0] tmp_16_sva_5;
  reg [31:0] mult_res_sva_1;
  reg [31:0] tmp_18_sva_1;
  reg [31:0] tmp_18_sva_2;
  reg [31:0] tmp_18_sva_4;
  reg [31:0] tmp_18_sva_5;
  reg [31:0] mult_1_res_sva_1;
  reg [31:0] tmp_20_sva_1;
  reg [31:0] tmp_20_sva_2;
  reg [31:0] tmp_20_sva_4;
  reg [31:0] tmp_20_sva_5;
  reg [31:0] mult_2_res_sva_1;
  reg [31:0] tmp_22_sva_1;
  reg [31:0] tmp_22_sva_2;
  reg [31:0] tmp_22_sva_4;
  reg [31:0] tmp_22_sva_5;
  reg [31:0] mult_3_res_sva_1;
  reg [31:0] mult_z_asn_itm_1;
  reg [31:0] mult_z_asn_itm_2;
  reg [31:0] mult_1_z_asn_itm_1;
  reg [31:0] mult_1_z_asn_itm_2;
  reg [31:0] mult_2_z_asn_itm_1;
  reg [31:0] mult_2_z_asn_itm_2;
  reg [31:0] mult_3_z_asn_itm_1;
  reg [31:0] mult_3_z_asn_itm_2;
  reg [12:0] butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_1;
  reg [12:0] butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_2;
  reg [12:0] butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_3;
  reg [12:0] butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_4;
  reg [12:0] butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_5;
  reg [12:0] butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_6;
  reg [12:0] butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_7;
  reg INNER_LOOP2_stage_0_5;
  reg INNER_LOOP2_stage_0_6;
  reg INNER_LOOP2_stage_0_7;
  reg INNER_LOOP2_stage_0_8;
  reg [31:0] tmp_sva_1;
  reg [31:0] tmp_sva_2;
  reg [31:0] tmp_sva_3;
  reg [31:0] tmp_sva_4;
  reg [31:0] tmp_sva_5;
  reg [31:0] mult_4_res_sva_1;
  reg [31:0] tmp_2_sva_1;
  reg [31:0] tmp_2_sva_2;
  reg [31:0] tmp_2_sva_3;
  reg [31:0] tmp_2_sva_4;
  reg [31:0] tmp_2_sva_5;
  reg [31:0] mult_5_res_sva_1;
  reg [31:0] tmp_4_sva_1;
  reg [31:0] tmp_4_sva_2;
  reg [31:0] tmp_4_sva_3;
  reg [31:0] tmp_4_sva_4;
  reg [31:0] tmp_4_sva_5;
  reg [31:0] mult_6_res_sva_1;
  reg [31:0] tmp_6_sva_1;
  reg [31:0] tmp_6_sva_2;
  reg [31:0] tmp_6_sva_3;
  reg [31:0] tmp_6_sva_4;
  reg [31:0] tmp_6_sva_5;
  reg [31:0] mult_7_res_sva_1;
  reg [31:0] mult_4_z_asn_itm_2;
  reg [31:0] mult_4_z_asn_itm_3;
  reg [31:0] mult_5_z_asn_itm_2;
  reg [31:0] mult_5_z_asn_itm_3;
  reg [31:0] mult_6_z_asn_itm_2;
  reg [31:0] mult_6_z_asn_itm_3;
  reg [31:0] mult_7_z_asn_itm_2;
  reg [31:0] mult_7_z_asn_itm_3;
  reg [12:0] butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_1;
  reg [12:0] butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_2;
  reg [12:0] butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_3;
  reg [12:0] butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_4;
  reg [12:0] butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_5;
  reg [12:0] butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_6;
  reg [12:0] butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_7;
  reg [31:0] mult_8_res_sva_1;
  reg [31:0] mult_9_res_sva_1;
  reg [31:0] mult_10_res_sva_1;
  reg [31:0] mult_11_res_sva_1;
  reg [12:0] butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_1;
  reg [12:0] butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_2;
  reg [12:0] butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_3;
  reg [12:0] butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_4;
  reg [12:0] butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_5;
  reg [12:0] butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_6;
  reg [12:0] butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_7;
  reg [31:0] tmp_8_sva_2;
  reg [31:0] tmp_8_sva_3;
  reg [31:0] tmp_8_sva_4;
  reg [31:0] tmp_8_sva_5;
  reg [31:0] mult_12_res_sva_1;
  reg [31:0] tmp_10_sva_2;
  reg [31:0] tmp_10_sva_3;
  reg [31:0] tmp_10_sva_4;
  reg [31:0] tmp_10_sva_5;
  reg [31:0] mult_13_res_sva_1;
  reg [31:0] tmp_12_sva_2;
  reg [31:0] tmp_12_sva_3;
  reg [31:0] tmp_12_sva_4;
  reg [31:0] tmp_12_sva_5;
  reg [31:0] mult_14_res_sva_1;
  reg [31:0] tmp_14_sva_2;
  reg [31:0] tmp_14_sva_3;
  reg [31:0] tmp_14_sva_4;
  reg [31:0] tmp_14_sva_5;
  reg [31:0] mult_15_res_sva_1;
  reg [31:0] mult_12_z_asn_itm_2;
  reg [31:0] mult_12_z_asn_itm_3;
  reg [31:0] mult_13_z_asn_itm_2;
  reg [31:0] mult_13_z_asn_itm_3;
  reg [31:0] mult_14_z_asn_itm_2;
  reg [31:0] mult_14_z_asn_itm_3;
  reg [31:0] mult_15_z_asn_itm_2;
  reg [31:0] mult_15_z_asn_itm_3;
  reg [12:0] butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_1;
  reg [12:0] butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_2;
  reg [12:0] butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_3;
  reg [12:0] butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_4;
  reg [12:0] butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_5;
  reg [12:0] butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_6;
  reg [12:0] butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_7;
  reg [12:0] INNER_LOOP1_r_15_2_sva_12_0;
  reg [12:0] INNER_LOOP2_r_15_2_sva_12_0;
  reg [12:0] INNER_LOOP3_r_15_2_sva_12_0;
  reg [12:0] INNER_LOOP4_r_15_2_sva_12_0;
  reg [12:0] INNER_LOOP1_r_15_2_sva_1_1_12_0;
  reg [12:0] INNER_LOOP2_r_15_2_sva_1_1_12_0;
  reg [12:0] INNER_LOOP3_r_15_2_sva_1_1_12_0;
  reg [12:0] INNER_LOOP4_r_15_2_sva_1_1_12_0;
  wire [12:0] INNER_LOOP1_r_15_2_sva_12_0_mx1;
  wire [12:0] INNER_LOOP2_r_15_2_sva_12_0_mx1;
  wire [12:0] INNER_LOOP3_r_15_2_sva_12_0_mx1;
  reg reg_mult_3_slc_32_svs_st_1_cse;
  reg reg_mult_2_slc_32_svs_st_1_cse;
  reg reg_mult_1_slc_32_svs_st_1_cse;
  reg reg_mult_slc_32_svs_st_1_cse;
  reg [31:0] reg_mult_3_z_asn_itm_3_cse;
  reg [31:0] reg_mult_2_z_asn_itm_3_cse;
  reg [31:0] reg_mult_1_z_asn_itm_3_cse;
  reg [31:0] reg_mult_z_asn_itm_3_cse;
  reg [31:0] reg_tmp_22_sva_3_cse;
  reg [31:0] reg_tmp_20_sva_3_cse;
  reg [31:0] reg_tmp_18_sva_3_cse;
  reg [31:0] reg_tmp_16_sva_3_cse;
  wire INNER_LOOP1_INNER_LOOP1_and_8_cse;
  wire INNER_LOOP2_INNER_LOOP2_and_1_cse;
  reg [31:0] reg_tmp_22_sva_6_cse;
  reg [31:0] reg_tmp_20_sva_6_cse;
  reg [31:0] reg_tmp_18_sva_6_cse;
  reg [31:0] reg_tmp_16_sva_6_cse;
  wire z_out_31_32;
  wire z_out_32_32;
  wire z_out_33_32;
  wire z_out_34_32;
  wire z_out_35_32;
  wire z_out_36_32;
  wire z_out_37_32;
  wire z_out_38_32;
  wire z_out_39_32;
  wire z_out_40_32;
  wire z_out_41_32;
  wire z_out_42_32;
  wire [31:0] butterFly1_mux_12_cse;
  wire [31:0] butterFly1_2_mux_12_cse;
  wire [31:0] butterFly2_mux_4_cse;
  wire [31:0] butterFly2_1_mux_4_cse;

  wire[0:0] or_233_nl;
  wire[0:0] INNER_LOOP1_mux_nl;
  wire[0:0] or_28_nl;
  wire[0:0] or_31_nl;
  wire[0:0] or_33_nl;
  wire[0:0] or_35_nl;
  wire[12:0] INNER_LOOP1_tw_and_nl;
  wire[11:0] INNER_LOOP2_tw_and_nl;
  wire[0:0] butterFly1_butterFly1_and_nl;
  wire[30:0] butterFly1_mux1h_4_nl;
  wire[0:0] butterFly1_or_nl;
  wire[31:0] butterFly1_mux1h_9_nl;
  wire[32:0] acc_25_nl;
  wire[33:0] nl_acc_25_nl;
  wire[31:0] modulo_add_qif_mux_2_nl;
  wire[0:0] butterFly1_and_4_nl;
  wire[0:0] butterFly1_or_1_nl;
  wire[0:0] butterFly1_and_6_nl;
  wire[0:0] butterFly1_1_butterFly1_1_and_nl;
  wire[30:0] butterFly1_1_mux1h_4_nl;
  wire[0:0] butterFly1_1_or_nl;
  wire[31:0] butterFly1_1_mux1h_9_nl;
  wire[0:0] butterFly1_1_and_4_nl;
  wire[0:0] butterFly1_1_and_5_nl;
  wire[0:0] butterFly1_1_and_6_nl;
  wire[0:0] butterFly1_1_and_7_nl;
  wire[0:0] butterFly1_2_butterFly1_2_and_nl;
  wire[30:0] butterFly1_2_mux1h_4_nl;
  wire[0:0] butterFly1_2_or_nl;
  wire[31:0] butterFly1_2_mux1h_9_nl;
  wire[0:0] butterFly1_2_and_4_nl;
  wire[0:0] butterFly1_2_and_5_nl;
  wire[0:0] butterFly1_2_and_6_nl;
  wire[0:0] butterFly1_2_and_7_nl;
  wire[0:0] butterFly1_3_butterFly1_3_and_nl;
  wire[30:0] butterFly1_3_mux1h_4_nl;
  wire[0:0] butterFly1_3_or_nl;
  wire[31:0] butterFly1_3_mux1h_16_nl;
  wire[0:0] butterFly1_3_and_4_nl;
  wire[0:0] butterFly1_3_and_5_nl;
  wire[0:0] butterFly1_3_and_6_nl;
  wire[0:0] butterFly1_3_and_7_nl;
  wire[31:0] butterFly1_2_f1_mux1h_2_nl;
  wire[0:0] butterFly1_2_f1_and_4_nl;
  wire[0:0] butterFly1_2_f1_and_5_nl;
  wire[0:0] butterFly1_2_f1_and_6_nl;
  wire[0:0] butterFly1_2_f1_and_7_nl;
  wire[0:0] butterFly1_2_f1_butterFly1_2_f1_and_nl;
  wire[30:0] butterFly1_2_f1_mux1h_11_nl;
  wire[0:0] butterFly1_2_f1_or_nl;
  wire[31:0] butterFly1_2_f2_mux1h_2_nl;
  wire[32:0] acc_28_nl;
  wire[33:0] nl_acc_28_nl;
  wire[31:0] modulo_add_5_qif_mux_2_nl;
  wire[0:0] butterFly1_2_f2_and_4_nl;
  wire[0:0] butterFly1_2_f2_or_nl;
  wire[0:0] butterFly1_2_f2_and_6_nl;
  wire[0:0] butterFly1_2_f2_butterFly1_2_f2_and_nl;
  wire[30:0] butterFly1_2_f2_mux1h_5_nl;
  wire[0:0] butterFly1_2_f2_or_1_nl;
  wire[31:0] butterFly1_3_f1_mux1h_2_nl;
  wire[32:0] acc_13_nl;
  wire[33:0] nl_acc_13_nl;
  wire[31:0] modulo_add_6_qif_mux_2_nl;
  wire[0:0] butterFly1_3_f1_and_4_nl;
  wire[0:0] butterFly1_3_f1_or_nl;
  wire[0:0] butterFly1_3_f1_and_6_nl;
  wire[0:0] butterFly1_3_f1_butterFly1_3_f1_and_nl;
  wire[30:0] butterFly1_3_f1_mux1h_11_nl;
  wire[0:0] butterFly1_3_f1_or_1_nl;
  wire[31:0] butterFly1_3_f2_mux1h_6_nl;
  wire[32:0] acc_4_nl;
  wire[33:0] nl_acc_4_nl;
  wire[31:0] modulo_add_7_qif_mux_2_nl;
  wire[0:0] butterFly1_3_f2_and_4_nl;
  wire[0:0] butterFly1_3_f2_or_nl;
  wire[0:0] butterFly1_3_f2_and_6_nl;
  wire[0:0] butterFly1_3_f2_butterFly1_3_f2_and_nl;
  wire[30:0] butterFly1_3_f2_mux1h_9_nl;
  wire[0:0] butterFly1_3_f2_or_1_nl;
  wire[31:0] butterFly1_mux_13_nl;
  wire[32:0] acc_1_nl;
  wire[33:0] nl_acc_1_nl;
  wire[31:0] butterFly1_mux_15_nl;
  wire[31:0] butterFly1_2_mux_13_nl;
  wire[32:0] acc_3_nl;
  wire[33:0] nl_acc_3_nl;
  wire[31:0] butterFly1_2_mux_15_nl;
  wire[30:0] modulo_sub_3_qif_mux_2_nl;
  wire[30:0] modulo_sub_qif_mux_2_nl;
  wire[30:0] modulo_sub_2_qif_mux_2_nl;
  wire[31:0] butterFly2_mux_5_nl;
  wire[32:0] acc_9_nl;
  wire[33:0] nl_acc_9_nl;
  wire[31:0] butterFly2_mux_7_nl;
  wire[31:0] butterFly2_1_mux_5_nl;
  wire[32:0] acc_11_nl;
  wire[33:0] nl_acc_11_nl;
  wire[31:0] butterFly2_1_mux_7_nl;
  wire[30:0] modulo_sub_4_qif_mux_2_nl;
  wire[30:0] modulo_sub_5_qif_mux_2_nl;
  wire[30:0] modulo_sub_1_qif_mux_2_nl;
  wire[32:0] acc_16_nl;
  wire[33:0] nl_acc_16_nl;
  wire[31:0] mult_3_if_mux1h_6_nl;
  wire[32:0] acc_17_nl;
  wire[33:0] nl_acc_17_nl;
  wire[31:0] mult_2_if_mux_2_nl;
  wire[32:0] acc_18_nl;
  wire[33:0] nl_acc_18_nl;
  wire[31:0] mult_1_if_mux1h_6_nl;
  wire[32:0] acc_19_nl;
  wire[33:0] nl_acc_19_nl;
  wire[31:0] mult_if_mux_2_nl;
  wire[32:0] acc_20_nl;
  wire[33:0] nl_acc_20_nl;
  wire[31:0] mult_9_if_mux_2_nl;
  wire[32:0] acc_21_nl;
  wire[33:0] nl_acc_21_nl;
  wire[31:0] mult_8_if_mux_2_nl;
  wire[32:0] acc_22_nl;
  wire[33:0] nl_acc_22_nl;
  wire[31:0] mult_5_if_mux_2_nl;
  wire[32:0] acc_23_nl;
  wire[33:0] nl_acc_23_nl;
  wire[31:0] mult_4_if_mux_2_nl;
  wire[32:0] acc_24_nl;
  wire[33:0] nl_acc_24_nl;
  wire[31:0] modulo_add_10_qif_mux_2_nl;
  wire[32:0] acc_26_nl;
  wire[33:0] nl_acc_26_nl;
  wire[31:0] mult_12_if_mux_2_nl;
  wire[30:0] modulo_sub_7_qif_mux_2_nl;
  wire[30:0] modulo_sub_6_qif_mux_2_nl;
  wire[12:0] operator_32_false_mux1h_2_nl;
  wire[33:0] acc_31_nl;
  wire[34:0] nl_acc_31_nl;
  wire[31:0] mult_3_if_mux1h_7_nl;
  wire[33:0] acc_32_nl;
  wire[34:0] nl_acc_32_nl;
  wire[31:0] mult_2_if_mux1h_4_nl;
  wire[33:0] acc_33_nl;
  wire[34:0] nl_acc_33_nl;
  wire[31:0] mult_1_if_mux1h_7_nl;
  wire[33:0] acc_34_nl;
  wire[34:0] nl_acc_34_nl;
  wire[31:0] mult_if_mux1h_4_nl;
  wire[33:0] acc_35_nl;
  wire[34:0] nl_acc_35_nl;
  wire[31:0] modulo_add_4_mux_3_nl;
  wire[33:0] acc_36_nl;
  wire[34:0] nl_acc_36_nl;
  wire[31:0] modulo_add_2_mux_3_nl;
  wire[33:0] acc_37_nl;
  wire[34:0] nl_acc_37_nl;
  wire[31:0] modulo_add_7_mux_3_nl;
  wire[33:0] acc_38_nl;
  wire[34:0] nl_acc_38_nl;
  wire[31:0] modulo_add_1_mux_3_nl;
  wire[33:0] acc_39_nl;
  wire[34:0] nl_acc_39_nl;
  wire[31:0] modulo_add_3_mux_3_nl;
  wire[33:0] acc_40_nl;
  wire[34:0] nl_acc_40_nl;
  wire[31:0] modulo_add_13_mux_3_nl;
  wire[33:0] acc_41_nl;
  wire[34:0] nl_acc_41_nl;
  wire[31:0] modulo_add_mux_3_nl;
  wire[33:0] acc_42_nl;
  wire[34:0] nl_acc_42_nl;
  wire[31:0] modulo_add_5_mux_3_nl;
  wire[2:0] operator_32_false_mux_1_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_mult_t_mul_cmp_a;
  assign nl_mult_t_mul_cmp_a = MUX1HOT_v_32_4_2((xt_rsc_0_1_i_qa_d[31:0]), (yt_rsc_0_1_i_qa_d[63:32]),
      (xt_rsc_0_3_i_qa_d[63:32]), (yt_rsc_0_3_i_qa_d[31:0]), {(fsm_output[2]) , (fsm_output[4])
      , (fsm_output[6]) , (fsm_output[7])});
  wire [31:0] nl_mult_t_mul_cmp_b;
  assign nl_mult_t_mul_cmp_b = MUX1HOT_v_32_3_2(twiddle_h_rsc_0_0_i_q_d, twiddle_h_rsc_0_2_i_q_d,
      twiddle_h_rsc_0_3_i_q_d, {or_tmp_153 , (fsm_output[6]) , (fsm_output[7])});
  wire [31:0] nl_mult_t_mul_cmp_1_a;
  assign nl_mult_t_mul_cmp_1_a = MUX1HOT_v_32_4_2((xt_rsc_0_3_i_qa_d[63:32]), (yt_rsc_0_3_i_qa_d[31:0]),
      (xt_rsc_0_1_i_qa_d[63:32]), (yt_rsc_0_1_i_qa_d[63:32]), {(fsm_output[2]) ,
      (fsm_output[4]) , (fsm_output[6]) , (fsm_output[7])});
  wire [31:0] nl_mult_t_mul_cmp_1_b;
  assign nl_mult_t_mul_cmp_1_b = MUX_v_32_2_2(twiddle_h_rsc_0_0_i_q_d, twiddle_h_rsc_0_2_i_q_d,
      fsm_output[6]);
  wire [31:0] nl_mult_t_mul_cmp_2_a;
  assign nl_mult_t_mul_cmp_2_a = MUX1HOT_v_32_4_2((xt_rsc_0_1_i_qa_d[63:32]), (yt_rsc_0_1_i_qa_d[31:0]),
      (xt_rsc_0_3_i_qa_d[31:0]), (yt_rsc_0_3_i_qa_d[63:32]), {(fsm_output[2]) , (fsm_output[4])
      , (fsm_output[6]) , (fsm_output[7])});
  wire [31:0] nl_mult_t_mul_cmp_2_b;
  assign nl_mult_t_mul_cmp_2_b = MUX_v_32_2_2(twiddle_h_rsc_0_0_i_q_d, twiddle_h_rsc_0_1_i_q_d,
      fsm_output[7]);
  wire [31:0] nl_mult_t_mul_cmp_3_a;
  assign nl_mult_t_mul_cmp_3_a = MUX1HOT_v_32_4_2((xt_rsc_0_3_i_qa_d[31:0]), (yt_rsc_0_3_i_qa_d[63:32]),
      (xt_rsc_0_1_i_qa_d[31:0]), (yt_rsc_0_1_i_qa_d[31:0]), {(fsm_output[2]) , (fsm_output[4])
      , (fsm_output[6]) , (fsm_output[7])});
  wire [31:0] nl_mult_t_mul_cmp_3_b;
  assign nl_mult_t_mul_cmp_3_b = MUX_v_32_2_2(twiddle_h_rsc_0_0_i_q_d, twiddle_h_rsc_0_2_i_q_d,
      fsm_output[7]);
  wire[2:0] operator_34_true_mux_nl;
  wire [3:0] nl_operator_34_true_1_lshift_rg_s;
  assign operator_34_true_mux_nl = MUX_v_3_2_2(z_out_44, operator_32_false_acc_psp_sva,
      fsm_output[3]);
  assign nl_operator_34_true_1_lshift_rg_s = {operator_34_true_mux_nl , (~ (fsm_output[3]))};
  wire [0:0] nl_peaseNTT_core_core_fsm_inst_INNER_LOOP1_C_0_tr0;
  assign nl_peaseNTT_core_core_fsm_inst_INNER_LOOP1_C_0_tr0 = ~(INNER_LOOP1_stage_0
      | INNER_LOOP1_stage_0_2 | INNER_LOOP1_stage_0_3 | INNER_LOOP1_stage_0_4 | INNER_LOOP1_stage_0_5
      | INNER_LOOP1_stage_0_6 | INNER_LOOP1_stage_0_7 | INNER_LOOP1_stage_0_8 | INNER_LOOP1_stage_0_9);
  wire [0:0] nl_peaseNTT_core_core_fsm_inst_STAGE_LOOP_C_2_tr0;
  assign nl_peaseNTT_core_core_fsm_inst_STAGE_LOOP_C_2_tr0 = z_out_44[2];
  wire [0:0] nl_peaseNTT_core_core_fsm_inst_INNER_LOOP3_C_0_tr0;
  assign nl_peaseNTT_core_core_fsm_inst_INNER_LOOP3_C_0_tr0 = ~(INNER_LOOP3_stage_0
      | INNER_LOOP1_stage_0_2 | INNER_LOOP1_stage_0_3 | INNER_LOOP1_stage_0_4 | INNER_LOOP1_stage_0_5
      | INNER_LOOP1_stage_0_6 | INNER_LOOP1_stage_0_7 | INNER_LOOP1_stage_0_8 | INNER_LOOP1_stage_0_9);
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd32)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) xt_rsc_triosy_0_3_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(xt_rsc_triosy_0_3_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) xt_rsc_triosy_0_2_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(xt_rsc_triosy_0_2_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) xt_rsc_triosy_0_1_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(xt_rsc_triosy_0_1_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) xt_rsc_triosy_0_0_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(xt_rsc_triosy_0_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) p_rsc_triosy_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(p_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(r_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_3_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_3_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_2_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_2_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_1_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_1_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_0_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_3_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_h_rsc_triosy_0_3_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_2_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_h_rsc_triosy_0_2_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_1_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_h_rsc_triosy_0_1_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_h_rsc_triosy_0_0_obj (
      .ld(reg_xt_rsc_triosy_0_3_obj_ld_cse),
      .lz(twiddle_h_rsc_triosy_0_0_lz)
    );
  mgc_mul_pipe #(.width_a(32'sd32),
  .signd_a(32'sd0),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd64),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) mult_t_mul_cmp (
      .a(nl_mult_t_mul_cmp_a[31:0]),
      .b(nl_mult_t_mul_cmp_b[31:0]),
      .clk(clk),
      .en(mult_t_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(mult_t_mul_cmp_z)
    );
  mgc_mul_pipe #(.width_a(32'sd32),
  .signd_a(32'sd0),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd64),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) mult_t_mul_cmp_1 (
      .a(nl_mult_t_mul_cmp_1_a[31:0]),
      .b(nl_mult_t_mul_cmp_1_b[31:0]),
      .clk(clk),
      .en(mult_t_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(mult_t_mul_cmp_1_z)
    );
  mgc_mul_pipe #(.width_a(32'sd32),
  .signd_a(32'sd0),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd64),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) mult_t_mul_cmp_2 (
      .a(nl_mult_t_mul_cmp_2_a[31:0]),
      .b(nl_mult_t_mul_cmp_2_b[31:0]),
      .clk(clk),
      .en(mult_t_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(mult_t_mul_cmp_2_z)
    );
  mgc_mul_pipe #(.width_a(32'sd32),
  .signd_a(32'sd0),
  .width_b(32'sd32),
  .signd_b(32'sd0),
  .width_z(32'sd64),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd2),
  .n_inreg(32'sd2)) mult_t_mul_cmp_3 (
      .a(nl_mult_t_mul_cmp_3_a[31:0]),
      .b(nl_mult_t_mul_cmp_3_b[31:0]),
      .clk(clk),
      .en(mult_t_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(mult_t_mul_cmp_3_z)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd15)) operator_34_true_1_lshift_rg (
      .a(1'b1),
      .s(nl_operator_34_true_1_lshift_rg_s[3:0]),
      .z(z_out_43)
    );
  peaseNTT_core_wait_dp peaseNTT_core_wait_dp_inst (
      .clk(clk),
      .yt_rsc_0_0_cgo_iro(or_39_rmff),
      .yt_rsc_0_0_i_clka_en_d(yt_rsc_0_0_i_clka_en_d),
      .ensig_cgo_iro(or_182_rmff),
      .mult_z_mul_cmp_z(mult_z_mul_cmp_z),
      .mult_z_mul_cmp_1_z(mult_z_mul_cmp_1_z),
      .mult_z_mul_cmp_2_z(mult_z_mul_cmp_2_z),
      .mult_z_mul_cmp_3_z(mult_z_mul_cmp_3_z),
      .mult_z_mul_cmp_4_z(mult_z_mul_cmp_4_z),
      .mult_z_mul_cmp_5_z(mult_z_mul_cmp_5_z),
      .mult_z_mul_cmp_6_z(mult_z_mul_cmp_6_z),
      .mult_z_mul_cmp_7_z(mult_z_mul_cmp_7_z),
      .yt_rsc_0_0_cgo(reg_yt_rsc_0_0_cgo_cse),
      .ensig_cgo(reg_ensig_cgo_cse),
      .mult_t_mul_cmp_en(mult_t_mul_cmp_en),
      .mult_z_mul_cmp_z_oreg(mult_z_mul_cmp_z_oreg),
      .mult_z_mul_cmp_1_z_oreg(mult_z_mul_cmp_1_z_oreg),
      .mult_z_mul_cmp_2_z_oreg(mult_z_mul_cmp_2_z_oreg),
      .mult_z_mul_cmp_3_z_oreg(mult_z_mul_cmp_3_z_oreg),
      .mult_z_mul_cmp_4_z_oreg(mult_z_mul_cmp_4_z_oreg),
      .mult_z_mul_cmp_5_z_oreg(mult_z_mul_cmp_5_z_oreg),
      .mult_z_mul_cmp_6_z_oreg(mult_z_mul_cmp_6_z_oreg),
      .mult_z_mul_cmp_7_z_oreg(mult_z_mul_cmp_7_z_oreg)
    );
  peaseNTT_core_core_fsm peaseNTT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .INNER_LOOP1_C_0_tr0(nl_peaseNTT_core_core_fsm_inst_INNER_LOOP1_C_0_tr0[0:0]),
      .INNER_LOOP2_C_0_tr0(INNER_LOOP2_nor_tmp),
      .STAGE_LOOP_C_2_tr0(nl_peaseNTT_core_core_fsm_inst_STAGE_LOOP_C_2_tr0[0:0]),
      .INNER_LOOP3_C_0_tr0(nl_peaseNTT_core_core_fsm_inst_INNER_LOOP3_C_0_tr0[0:0]),
      .INNER_LOOP4_C_0_tr0(INNER_LOOP4_nor_tmp)
    );
  assign or_39_rmff = ((INNER_LOOP4_stage_0 | INNER_LOOP4_stage_0_2) & (fsm_output[7]))
      | ((INNER_LOOP1_stage_0_10 | INNER_LOOP1_stage_0_9) & or_dcpl_14) | ((INNER_LOOP2_stage_0_2
      | INNER_LOOP2_stage_0) & (fsm_output[4]));
  assign or_52_rmff = INNER_LOOP1_INNER_LOOP1_and_8_cse | INNER_LOOP2_INNER_LOOP2_and_1_cse;
  assign or_112_rmff = and_206_cse | and_207_cse;
  assign or_182_rmff = ((INNER_LOOP4_stage_0_2 | INNER_LOOP4_stage_0_4 | INNER_LOOP4_stage_0_3)
      & (fsm_output[7])) | ((INNER_LOOP1_stage_0_2 | INNER_LOOP1_stage_0_4 | INNER_LOOP1_stage_0_3)
      & or_dcpl_14) | ((INNER_LOOP2_stage_0_2 | INNER_LOOP2_stage_0_4 | INNER_LOOP2_stage_0_3)
      & (fsm_output[4]));
  assign mult_z_mul_cmp_1_b = reg_mult_z_mul_cmp_1_b_cse;
  assign INNER_LOOP2_INNER_LOOP2_and_1_cse = INNER_LOOP2_stage_0 & (fsm_output[4]);
  assign INNER_LOOP1_INNER_LOOP1_and_8_cse = INNER_LOOP4_stage_0 & (fsm_output[7]);
  assign or_28_nl = (~ INNER_LOOP1_stage_0_2) | INNER_LOOP1_r_asn_11_itm_1;
  assign INNER_LOOP1_r_15_2_sva_12_0_mx1 = MUX_v_13_2_2(INNER_LOOP1_r_15_2_sva_1_1_12_0,
      INNER_LOOP1_r_15_2_sva_12_0, or_28_nl);
  assign nl_mult_res_sva_2 = reg_mult_z_asn_itm_3_cse - mult_z_mul_cmp_7_z_oreg;
  assign mult_res_sva_2 = nl_mult_res_sva_2[31:0];
  assign nl_mult_1_res_sva_2 = reg_mult_1_z_asn_itm_3_cse - mult_z_mul_cmp_5_z_oreg;
  assign mult_1_res_sva_2 = nl_mult_1_res_sva_2[31:0];
  assign nl_mult_2_res_sva_2 = reg_mult_2_z_asn_itm_3_cse - mult_z_mul_cmp_3_z_oreg;
  assign mult_2_res_sva_2 = nl_mult_2_res_sva_2[31:0];
  assign nl_mult_3_res_sva_2 = reg_mult_3_z_asn_itm_3_cse - mult_z_mul_cmp_1_z_oreg;
  assign mult_3_res_sva_2 = nl_mult_3_res_sva_2[31:0];
  assign mult_3_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_16, mult_3_res_sva_1, reg_mult_3_slc_32_svs_st_1_cse);
  assign mult_2_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_17, mult_2_res_sva_1, reg_mult_2_slc_32_svs_st_1_cse);
  assign mult_1_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_18, mult_1_res_sva_1, reg_mult_1_slc_32_svs_st_1_cse);
  assign mult_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_19, mult_res_sva_1, reg_mult_slc_32_svs_st_1_cse);
  assign or_31_nl = (~ INNER_LOOP2_stage_0_2) | INNER_LOOP2_r_asn_10_itm_1;
  assign INNER_LOOP2_r_15_2_sva_12_0_mx1 = MUX_v_13_2_2(INNER_LOOP2_r_15_2_sva_1_1_12_0,
      INNER_LOOP2_r_15_2_sva_12_0, or_31_nl);
  assign nl_mult_4_res_sva_2 = mult_4_z_asn_itm_3 - mult_z_mul_cmp_7_z_oreg;
  assign mult_4_res_sva_2 = nl_mult_4_res_sva_2[31:0];
  assign nl_mult_5_res_sva_2 = mult_5_z_asn_itm_3 - mult_z_mul_cmp_5_z_oreg;
  assign mult_5_res_sva_2 = nl_mult_5_res_sva_2[31:0];
  assign nl_mult_6_res_sva_2 = mult_6_z_asn_itm_3 - mult_z_mul_cmp_3_z_oreg;
  assign mult_6_res_sva_2 = nl_mult_6_res_sva_2[31:0];
  assign nl_mult_7_res_sva_2 = mult_7_z_asn_itm_3 - mult_z_mul_cmp_1_z_oreg;
  assign mult_7_res_sva_2 = nl_mult_7_res_sva_2[31:0];
  assign mult_7_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_16, mult_7_res_sva_1, mult_7_slc_32_svs_st_1);
  assign mult_6_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_18, mult_6_res_sva_1, mult_6_slc_32_svs_st_1);
  assign mult_5_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_22, mult_5_res_sva_1, mult_5_slc_32_svs_st_1);
  assign mult_4_res_lpi_3_dfm_mx0 = MUX_v_32_2_2(z_out_23, mult_4_res_sva_1, mult_4_slc_32_svs_st_1);
  assign or_33_nl = (~ INNER_LOOP1_stage_0_2) | INNER_LOOP3_r_asn_14_itm_1;
  assign INNER_LOOP3_r_15_2_sva_12_0_mx1 = MUX_v_13_2_2(INNER_LOOP3_r_15_2_sva_1_1_12_0,
      INNER_LOOP3_r_15_2_sva_12_0, or_33_nl);
  assign nl_mult_8_res_sva_2 = reg_mult_z_asn_itm_3_cse - mult_z_mul_cmp_3_z_oreg;
  assign mult_8_res_sva_2 = nl_mult_8_res_sva_2[31:0];
  assign nl_mult_9_res_sva_2 = reg_mult_1_z_asn_itm_3_cse - mult_z_mul_cmp_5_z_oreg;
  assign mult_9_res_sva_2 = nl_mult_9_res_sva_2[31:0];
  assign nl_mult_10_res_sva_2 = reg_mult_2_z_asn_itm_3_cse - mult_z_mul_cmp_1_z_oreg;
  assign mult_10_res_sva_2 = nl_mult_10_res_sva_2[31:0];
  assign nl_mult_11_res_sva_2 = reg_mult_3_z_asn_itm_3_cse - mult_z_mul_cmp_7_z_oreg;
  assign mult_11_res_sva_2 = nl_mult_11_res_sva_2[31:0];
  assign or_35_nl = (~ INNER_LOOP4_stage_0_2) | INNER_LOOP4_r_asn_18_itm_1;
  assign INNER_LOOP4_r_15_2_sva_12_0_mx1 = MUX_v_13_2_2(INNER_LOOP4_r_15_2_sva_1_1_12_0,
      INNER_LOOP4_r_15_2_sva_12_0, or_35_nl);
  assign nl_mult_12_res_sva_2 = mult_12_z_asn_itm_3 - mult_z_mul_cmp_3_z_oreg;
  assign mult_12_res_sva_2 = nl_mult_12_res_sva_2[31:0];
  assign nl_mult_13_res_sva_2 = mult_13_z_asn_itm_3 - mult_z_mul_cmp_7_z_oreg;
  assign mult_13_res_sva_2 = nl_mult_13_res_sva_2[31:0];
  assign nl_mult_14_res_sva_2 = mult_14_z_asn_itm_3 - mult_z_mul_cmp_1_z_oreg;
  assign mult_14_res_sva_2 = nl_mult_14_res_sva_2[31:0];
  assign nl_mult_15_res_sva_2 = mult_15_z_asn_itm_3 - mult_z_mul_cmp_5_z_oreg;
  assign mult_15_res_sva_2 = nl_mult_15_res_sva_2[31:0];
  assign mult_11_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_16, mult_11_res_sva_1, reg_mult_3_slc_32_svs_st_1_cse);
  assign mult_10_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_18, mult_10_res_sva_1, reg_mult_2_slc_32_svs_st_1_cse);
  assign mult_9_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_20, mult_9_res_sva_1, reg_mult_1_slc_32_svs_st_1_cse);
  assign mult_8_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_21, mult_8_res_sva_1, reg_mult_slc_32_svs_st_1_cse);
  assign mult_15_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_16, mult_15_res_sva_1, mult_15_slc_32_svs_st_1);
  assign mult_14_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_18, mult_14_res_sva_1, mult_14_slc_32_svs_st_1);
  assign mult_13_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_23, mult_13_res_sva_1, mult_13_slc_32_svs_st_1);
  assign mult_12_res_lpi_2_dfm_mx0 = MUX_v_32_2_2(z_out_26, mult_12_res_sva_1, mult_12_slc_32_svs_st_1);
  assign INNER_LOOP4_nor_tmp = ~(INNER_LOOP4_stage_0 | INNER_LOOP4_stage_0_2 | INNER_LOOP4_stage_0_3
      | INNER_LOOP4_stage_0_4 | INNER_LOOP4_stage_0_5 | INNER_LOOP4_stage_0_6 | INNER_LOOP4_stage_0_7
      | INNER_LOOP4_stage_0_8 | INNER_LOOP4_stage_0_9);
  assign INNER_LOOP2_nor_tmp = ~(INNER_LOOP2_stage_0 | INNER_LOOP2_stage_0_2 | INNER_LOOP2_stage_0_3
      | INNER_LOOP2_stage_0_4 | INNER_LOOP2_stage_0_5 | INNER_LOOP2_stage_0_6 | INNER_LOOP2_stage_0_7
      | INNER_LOOP2_stage_0_8 | INNER_LOOP2_stage_0_9);
  assign or_dcpl_2 = INNER_LOOP1_stage_0_4 | INNER_LOOP2_stage_0_4 | INNER_LOOP4_stage_0_4;
  assign or_dcpl_3 = INNER_LOOP2_stage_0_2 | INNER_LOOP4_stage_0_2;
  assign or_dcpl_14 = (fsm_output[2]) | (fsm_output[6]);
  assign and_206_cse = INNER_LOOP3_stage_0 & (fsm_output[6]);
  assign and_207_cse = INNER_LOOP1_stage_0 & (fsm_output[2]);
  assign or_tmp_153 = (fsm_output[4]) | (fsm_output[2]);
  assign or_tmp_232 = (fsm_output[1]) | (fsm_output[5]);
  assign butterFly1_mux_4_cse = MUX_s_1_2_2((INNER_LOOP2_r_15_2_sva_12_0_mx1[12]),
      (INNER_LOOP4_r_15_2_sva_12_0_mx1[12]), fsm_output[7]);
  assign butterFly1_butterFly1_or_rmff = butterFly1_mux_4_cse | (fsm_output[2]) |
      (fsm_output[6]);
  assign butterFly1_mux1h_1_rmff = MUX1HOT_v_12_4_2((butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_7[12:1]),
      (INNER_LOOP2_r_15_2_sva_12_0_mx1[11:0]), (butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_7[12:1]),
      (INNER_LOOP4_r_15_2_sva_12_0_mx1[11:0]), {(fsm_output[2]) , (fsm_output[4])
      , (fsm_output[6]) , (fsm_output[7])});
  assign butterFly1_mux_5_cse = MUX_s_1_2_2((butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_7[0]),
      (butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_7[0]), fsm_output[6]);
  assign butterFly1_nor_1_cse = ~((fsm_output[4]) | (fsm_output[7]));
  assign butterFly1_butterFly1_and_4_rmff = butterFly1_mux_5_cse & butterFly1_nor_1_cse;
  assign butterFly1_nor_2_cse = ~((fsm_output[2]) | (fsm_output[6]));
  assign butterFly1_butterFly1_and_5_rmff = butterFly1_mux_4_cse & butterFly1_nor_2_cse;
  assign butterFly1_butterFly1_or_1_rmff = butterFly1_mux_5_cse | (fsm_output[4])
      | (fsm_output[7]);
  assign butterFly1_and_ssc = (~ (modulo_sub_base_sva_1[31])) & (fsm_output[2]);
  assign butterFly1_and_ssc_2 = (~ (modulo_sub_base_8_sva_1[31])) & (fsm_output[6]);
  assign butterFly1_butterFly1_butterFly1_and_rmff = or_dcpl_14 & INNER_LOOP1_stage_0_9;
  assign butterFly1_1_and_ssc = (~ (modulo_sub_base_1_sva_1[31])) & (fsm_output[2]);
  assign butterFly1_1_and_ssc_2 = (~ (modulo_sub_base_9_sva_1[31])) & (fsm_output[6]);
  assign butterFly1_2_and_ssc = (~ (modulo_sub_base_2_sva_1[31])) & (fsm_output[2]);
  assign butterFly1_2_and_ssc_2 = (~ (modulo_sub_base_10_sva_1[31])) & (fsm_output[6]);
  assign butterFly1_3_and_ssc = (~ (modulo_sub_base_3_sva_1[31])) & (fsm_output[2]);
  assign butterFly1_3_and_ssc_2 = (~ (modulo_sub_base_11_sva_1[31])) & (fsm_output[6]);
  assign butterFly1_3_f2_mux_16_cse = MUX_s_1_2_2((INNER_LOOP1_r_15_2_sva_12_0_mx1[12]),
      (INNER_LOOP3_r_15_2_sva_12_0_mx1[12]), fsm_output[6]);
  assign butterFly1_3_f2_butterFly1_3_f2_and_10_rmff = butterFly1_3_f2_mux_16_cse
      & butterFly1_nor_1_cse;
  assign butterFly1_3_f2_mux1h_rmff = MUX1HOT_v_12_4_2((INNER_LOOP1_r_15_2_sva_12_0_mx1[11:0]),
      (butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_7[12:1]), (INNER_LOOP3_r_15_2_sva_12_0_mx1[11:0]),
      (butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_7[12:1]), {(fsm_output[2]) ,
      (fsm_output[4]) , (fsm_output[6]) , (fsm_output[7])});
  assign butterFly1_3_f2_mux_17_cse = MUX_s_1_2_2((butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_7[0]),
      (butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_7[0]), fsm_output[7]);
  assign butterFly1_3_f2_butterFly1_3_f2_or_6_rmff = butterFly1_3_f2_mux_17_cse |
      (fsm_output[2]) | (fsm_output[6]);
  assign butterFly1_3_f2_butterFly1_3_f2_or_7_rmff = butterFly1_3_f2_mux_16_cse |
      (fsm_output[4]) | (fsm_output[7]);
  assign butterFly1_3_f2_butterFly1_3_f2_and_11_rmff = butterFly1_3_f2_mux_17_cse
      & butterFly1_nor_2_cse;
  assign butterFly1_2_f1_and_ssc = (~ (modulo_sub_base_4_sva_1[31])) & (fsm_output[4]);
  assign butterFly1_2_f1_and_ssc_2 = (~ (modulo_sub_base_12_sva_1[31])) & (fsm_output[7]);
  assign butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff = ~(((~ INNER_LOOP4_stage_0_9)
      & (fsm_output[7])) | butterFly1_nor_1_cse | ((~ INNER_LOOP2_stage_0_9) & (fsm_output[4])));
  assign butterFly1_2_f2_and_ssc = (~ (modulo_sub_base_5_sva_1[31])) & (fsm_output[4]);
  assign butterFly1_2_f2_and_ssc_2 = (~ (modulo_sub_base_13_sva_1[31])) & (fsm_output[7]);
  assign butterFly1_3_f1_and_ssc = (~ (modulo_sub_base_6_sva_1[31])) & (fsm_output[4]);
  assign butterFly1_3_f1_and_ssc_2 = (~ (modulo_sub_base_14_sva_1[31])) & (fsm_output[7]);
  assign butterFly1_3_f2_and_ssc = (~ (modulo_sub_base_7_sva_1[31])) & (fsm_output[4]);
  assign butterFly1_3_f2_and_ssc_2 = (~ (modulo_sub_base_15_sva_1[31])) & (fsm_output[7]);
  assign INNER_LOOP1_tw_h_INNER_LOOP1_tw_h_nor_1_rmff = ~((fsm_output[2]) | (fsm_output[4])
      | (fsm_output[6]) | (fsm_output[7]));
  assign INNER_LOOP1_tw_and_nl = operator_34_true_return_14_2_sva & INNER_LOOP1_r_15_2_sva_12_0_mx1;
  assign INNER_LOOP2_tw_and_nl = operator_34_true_1_lshift_psp_13_2_sva & (INNER_LOOP2_r_15_2_sva_12_0_mx1[11:0]);
  assign INNER_LOOP1_tw_h_mux1h_rmff = MUX1HOT_v_13_4_2(INNER_LOOP1_tw_and_nl, ({(INNER_LOOP2_r_15_2_sva_12_0_mx1[12])
      , INNER_LOOP2_tw_and_nl}), INNER_LOOP3_r_15_2_sva_12_0_mx1, INNER_LOOP4_r_15_2_sva_12_0_mx1,
      {(fsm_output[2]) , (fsm_output[4]) , (fsm_output[6]) , (fsm_output[7])});
  assign butterFly2_2_tw_butterFly2_2_tw_nor_rmff = ~((fsm_output[7:6]!=2'b00));
  assign butterFly2_2_tw_butterFly2_2_tw_mux_rmff = MUX_v_13_2_2(INNER_LOOP3_r_15_2_sva_12_0_mx1,
      INNER_LOOP4_r_15_2_sva_12_0_mx1, fsm_output[7]);
  assign yt_rsc_0_0_i_adra_d = {butterFly1_butterFly1_or_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_and_4_rmff , butterFly1_butterFly1_and_5_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_or_1_rmff};
  assign butterFly1_butterFly1_and_nl = (z_out_6[31]) & (~(butterFly1_and_ssc | butterFly1_and_ssc_2));
  assign butterFly1_or_nl = ((modulo_sub_base_sva_1[31]) & (fsm_output[2])) | ((modulo_sub_base_8_sva_1[31])
      & (fsm_output[6]));
  assign butterFly1_mux1h_4_nl = MUX1HOT_v_31_3_2((modulo_sub_base_sva_1[30:0]),
      (z_out_6[30:0]), (modulo_sub_base_8_sva_1[30:0]), {butterFly1_and_ssc , butterFly1_or_nl
      , butterFly1_and_ssc_2});
  assign modulo_add_qif_mux_2_nl = MUX_v_32_2_2(modulo_add_base_sva_1, modulo_add_base_8_sva_1,
      fsm_output[6]);
  assign nl_acc_25_nl = ({modulo_add_qif_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_25_nl = nl_acc_25_nl[32:0];
  assign butterFly1_and_4_nl = (~ z_out_41_32) & (fsm_output[2]);
  assign butterFly1_or_1_nl = (z_out_41_32 & (fsm_output[2])) | (z_out_41_32 & (fsm_output[6]));
  assign butterFly1_and_6_nl = (~ z_out_41_32) & (fsm_output[6]);
  assign butterFly1_mux1h_9_nl = MUX1HOT_v_32_3_2(modulo_add_base_sva_1, (readslicef_33_32_1(acc_25_nl)),
      modulo_add_base_8_sva_1, {butterFly1_and_4_nl , butterFly1_or_1_nl , butterFly1_and_6_nl});
  assign yt_rsc_0_0_i_da_d = {butterFly1_butterFly1_and_nl , butterFly1_mux1h_4_nl
      , butterFly1_mux1h_9_nl};
  assign yt_rsc_0_0_i_wea_d = {butterFly1_butterFly1_butterFly1_and_rmff , butterFly1_butterFly1_butterFly1_and_rmff};
  assign yt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_52_rmff}}, or_52_rmff};
  assign yt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_butterFly1_butterFly1_and_rmff
      , butterFly1_butterFly1_butterFly1_and_rmff};
  assign yt_rsc_0_1_i_adra_d = {butterFly1_butterFly1_or_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_and_4_rmff , butterFly1_butterFly1_and_5_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_or_1_rmff};
  assign butterFly1_1_butterFly1_1_and_nl = (z_out_15[31]) & (~(butterFly1_1_and_ssc
      | butterFly1_1_and_ssc_2));
  assign butterFly1_1_or_nl = ((modulo_sub_base_1_sva_1[31]) & (fsm_output[2])) |
      ((modulo_sub_base_9_sva_1[31]) & (fsm_output[6]));
  assign butterFly1_1_mux1h_4_nl = MUX1HOT_v_31_3_2((modulo_sub_base_1_sva_1[30:0]),
      (z_out_15[30:0]), (modulo_sub_base_9_sva_1[30:0]), {butterFly1_1_and_ssc ,
      butterFly1_1_or_nl , butterFly1_1_and_ssc_2});
  assign butterFly1_1_and_4_nl = (~ z_out_38_32) & (fsm_output[2]);
  assign butterFly1_1_and_5_nl = z_out_38_32 & (fsm_output[2]);
  assign butterFly1_1_and_6_nl = (~ z_out_38_32) & (fsm_output[6]);
  assign butterFly1_1_and_7_nl = z_out_38_32 & (fsm_output[6]);
  assign butterFly1_1_mux1h_9_nl = MUX1HOT_v_32_4_2(modulo_add_base_1_sva_1, z_out_21,
      modulo_add_base_9_sva_1, z_out_19, {butterFly1_1_and_4_nl , butterFly1_1_and_5_nl
      , butterFly1_1_and_6_nl , butterFly1_1_and_7_nl});
  assign yt_rsc_0_1_i_da_d = {butterFly1_1_butterFly1_1_and_nl , butterFly1_1_mux1h_4_nl
      , butterFly1_1_mux1h_9_nl};
  assign yt_rsc_0_1_i_wea_d = {butterFly1_butterFly1_butterFly1_and_rmff , butterFly1_butterFly1_butterFly1_and_rmff};
  assign yt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_52_rmff}}, or_52_rmff};
  assign yt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_butterFly1_butterFly1_and_rmff
      , butterFly1_butterFly1_butterFly1_and_rmff};
  assign yt_rsc_0_2_i_adra_d = {butterFly1_butterFly1_or_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_and_4_rmff , butterFly1_butterFly1_and_5_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_or_1_rmff};
  assign butterFly1_2_butterFly1_2_and_nl = (z_out_7[31]) & (~(butterFly1_2_and_ssc
      | butterFly1_2_and_ssc_2));
  assign butterFly1_2_or_nl = ((modulo_sub_base_2_sva_1[31]) & (fsm_output[2])) |
      ((modulo_sub_base_10_sva_1[31]) & (fsm_output[6]));
  assign butterFly1_2_mux1h_4_nl = MUX1HOT_v_31_3_2((modulo_sub_base_2_sva_1[30:0]),
      (z_out_7[30:0]), (modulo_sub_base_10_sva_1[30:0]), {butterFly1_2_and_ssc ,
      butterFly1_2_or_nl , butterFly1_2_and_ssc_2});
  assign butterFly1_2_and_4_nl = (~ z_out_36_32) & (fsm_output[2]);
  assign butterFly1_2_and_5_nl = z_out_36_32 & (fsm_output[2]);
  assign butterFly1_2_and_6_nl = (~ z_out_36_32) & (fsm_output[6]);
  assign butterFly1_2_and_7_nl = z_out_36_32 & (fsm_output[6]);
  assign butterFly1_2_mux1h_9_nl = MUX1HOT_v_32_4_2(modulo_add_base_2_sva_1, z_out_20,
      modulo_add_base_10_sva_1, z_out_24, {butterFly1_2_and_4_nl , butterFly1_2_and_5_nl
      , butterFly1_2_and_6_nl , butterFly1_2_and_7_nl});
  assign yt_rsc_0_2_i_da_d = {butterFly1_2_butterFly1_2_and_nl , butterFly1_2_mux1h_4_nl
      , butterFly1_2_mux1h_9_nl};
  assign yt_rsc_0_2_i_wea_d = {butterFly1_butterFly1_butterFly1_and_rmff , butterFly1_butterFly1_butterFly1_and_rmff};
  assign yt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_52_rmff}}, or_52_rmff};
  assign yt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_butterFly1_butterFly1_and_rmff
      , butterFly1_butterFly1_butterFly1_and_rmff};
  assign yt_rsc_0_3_i_adra_d = {butterFly1_butterFly1_or_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_and_4_rmff , butterFly1_butterFly1_and_5_rmff , butterFly1_mux1h_1_rmff
      , butterFly1_butterFly1_or_1_rmff};
  assign butterFly1_3_butterFly1_3_and_nl = (z_out_5[31]) & (~(butterFly1_3_and_ssc
      | butterFly1_3_and_ssc_2));
  assign butterFly1_3_or_nl = ((modulo_sub_base_3_sva_1[31]) & (fsm_output[2])) |
      ((modulo_sub_base_11_sva_1[31]) & (fsm_output[6]));
  assign butterFly1_3_mux1h_4_nl = MUX1HOT_v_31_3_2((modulo_sub_base_3_sva_1[30:0]),
      (z_out_5[30:0]), (modulo_sub_base_11_sva_1[30:0]), {butterFly1_3_and_ssc ,
      butterFly1_3_or_nl , butterFly1_3_and_ssc_2});
  assign butterFly1_3_and_4_nl = (~ z_out_39_32) & (fsm_output[2]);
  assign butterFly1_3_and_5_nl = z_out_39_32 & (fsm_output[2]);
  assign butterFly1_3_and_6_nl = (~ z_out_39_32) & (fsm_output[6]);
  assign butterFly1_3_and_7_nl = z_out_39_32 & (fsm_output[6]);
  assign butterFly1_3_mux1h_16_nl = MUX1HOT_v_32_4_2(modulo_add_base_3_sva_1, z_out_24,
      modulo_add_base_11_sva_1, z_out_17, {butterFly1_3_and_4_nl , butterFly1_3_and_5_nl
      , butterFly1_3_and_6_nl , butterFly1_3_and_7_nl});
  assign yt_rsc_0_3_i_da_d = {butterFly1_3_butterFly1_3_and_nl , butterFly1_3_mux1h_4_nl
      , butterFly1_3_mux1h_16_nl};
  assign yt_rsc_0_3_i_wea_d = {butterFly1_butterFly1_butterFly1_and_rmff , butterFly1_butterFly1_butterFly1_and_rmff};
  assign yt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_52_rmff}}, or_52_rmff};
  assign yt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_butterFly1_butterFly1_and_rmff
      , butterFly1_butterFly1_butterFly1_and_rmff};
  assign xt_rsc_0_0_i_adra_d = {butterFly1_3_f2_butterFly1_3_f2_and_10_rmff , butterFly1_3_f2_mux1h_rmff
      , butterFly1_3_f2_butterFly1_3_f2_or_6_rmff , butterFly1_3_f2_butterFly1_3_f2_or_7_rmff
      , butterFly1_3_f2_mux1h_rmff , butterFly1_3_f2_butterFly1_3_f2_and_11_rmff};
  assign butterFly1_2_f1_and_4_nl = (~ z_out_35_32) & (fsm_output[4]);
  assign butterFly1_2_f1_and_5_nl = z_out_35_32 & (fsm_output[4]);
  assign butterFly1_2_f1_and_6_nl = (~ z_out_35_32) & (fsm_output[7]);
  assign butterFly1_2_f1_and_7_nl = z_out_35_32 & (fsm_output[7]);
  assign butterFly1_2_f1_mux1h_2_nl = MUX1HOT_v_32_4_2(modulo_add_base_4_sva_1, z_out_26,
      modulo_add_base_12_sva_1, z_out_22, {butterFly1_2_f1_and_4_nl , butterFly1_2_f1_and_5_nl
      , butterFly1_2_f1_and_6_nl , butterFly1_2_f1_and_7_nl});
  assign butterFly1_2_f1_butterFly1_2_f1_and_nl = (z_out_12[31]) & (~(butterFly1_2_f1_and_ssc
      | butterFly1_2_f1_and_ssc_2));
  assign butterFly1_2_f1_or_nl = ((modulo_sub_base_4_sva_1[31]) & (fsm_output[4]))
      | ((modulo_sub_base_12_sva_1[31]) & (fsm_output[7]));
  assign butterFly1_2_f1_mux1h_11_nl = MUX1HOT_v_31_3_2((modulo_sub_base_4_sva_1[30:0]),
      (z_out_12[30:0]), (modulo_sub_base_12_sva_1[30:0]), {butterFly1_2_f1_and_ssc
      , butterFly1_2_f1_or_nl , butterFly1_2_f1_and_ssc_2});
  assign xt_rsc_0_0_i_da_d = {butterFly1_2_f1_mux1h_2_nl , butterFly1_2_f1_butterFly1_2_f1_and_nl
      , butterFly1_2_f1_mux1h_11_nl};
  assign xt_rsc_0_0_i_wea_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign xt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_112_rmff}}, or_112_rmff};
  assign xt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign xt_rsc_0_1_i_adra_d = {butterFly1_3_f2_butterFly1_3_f2_and_10_rmff , butterFly1_3_f2_mux1h_rmff
      , butterFly1_3_f2_butterFly1_3_f2_or_6_rmff , butterFly1_3_f2_butterFly1_3_f2_or_7_rmff
      , butterFly1_3_f2_mux1h_rmff , butterFly1_3_f2_butterFly1_3_f2_and_11_rmff};
  assign modulo_add_5_qif_mux_2_nl = MUX_v_32_2_2(modulo_add_base_5_sva_1, modulo_add_base_13_sva_1,
      fsm_output[7]);
  assign nl_acc_28_nl = ({modulo_add_5_qif_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_28_nl = nl_acc_28_nl[32:0];
  assign butterFly1_2_f2_and_4_nl = (~ z_out_42_32) & (fsm_output[4]);
  assign butterFly1_2_f2_or_nl = (z_out_42_32 & (fsm_output[4])) | (z_out_40_32 &
      (fsm_output[7]));
  assign butterFly1_2_f2_and_6_nl = (~ z_out_40_32) & (fsm_output[7]);
  assign butterFly1_2_f2_mux1h_2_nl = MUX1HOT_v_32_3_2(modulo_add_base_5_sva_1, (readslicef_33_32_1(acc_28_nl)),
      modulo_add_base_13_sva_1, {butterFly1_2_f2_and_4_nl , butterFly1_2_f2_or_nl
      , butterFly1_2_f2_and_6_nl});
  assign butterFly1_2_f2_butterFly1_2_f2_and_nl = (z_out_14[31]) & (~(butterFly1_2_f2_and_ssc
      | butterFly1_2_f2_and_ssc_2));
  assign butterFly1_2_f2_or_1_nl = ((modulo_sub_base_5_sva_1[31]) & (fsm_output[4]))
      | ((modulo_sub_base_13_sva_1[31]) & (fsm_output[7]));
  assign butterFly1_2_f2_mux1h_5_nl = MUX1HOT_v_31_3_2((modulo_sub_base_5_sva_1[30:0]),
      (z_out_14[30:0]), (modulo_sub_base_13_sva_1[30:0]), {butterFly1_2_f2_and_ssc
      , butterFly1_2_f2_or_1_nl , butterFly1_2_f2_and_ssc_2});
  assign xt_rsc_0_1_i_da_d = {butterFly1_2_f2_mux1h_2_nl , butterFly1_2_f2_butterFly1_2_f2_and_nl
      , butterFly1_2_f2_mux1h_5_nl};
  assign xt_rsc_0_1_i_wea_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign xt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_112_rmff}}, or_112_rmff};
  assign xt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign xt_rsc_0_2_i_adra_d = {butterFly1_3_f2_butterFly1_3_f2_and_10_rmff , butterFly1_3_f2_mux1h_rmff
      , butterFly1_3_f2_butterFly1_3_f2_or_6_rmff , butterFly1_3_f2_butterFly1_3_f2_or_7_rmff
      , butterFly1_3_f2_mux1h_rmff , butterFly1_3_f2_butterFly1_3_f2_and_11_rmff};
  assign modulo_add_6_qif_mux_2_nl = MUX_v_32_2_2(modulo_add_base_6_sva_1, modulo_add_base_14_sva_1,
      fsm_output[7]);
  assign nl_acc_13_nl = ({modulo_add_6_qif_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_13_nl = nl_acc_13_nl[32:0];
  assign butterFly1_3_f1_and_4_nl = (~ z_out_40_32) & (fsm_output[4]);
  assign butterFly1_3_f1_or_nl = (z_out_40_32 & (fsm_output[4])) | (z_out_42_32 &
      (fsm_output[7]));
  assign butterFly1_3_f1_and_6_nl = (~ z_out_42_32) & (fsm_output[7]);
  assign butterFly1_3_f1_mux1h_2_nl = MUX1HOT_v_32_3_2(modulo_add_base_6_sva_1, (readslicef_33_32_1(acc_13_nl)),
      modulo_add_base_14_sva_1, {butterFly1_3_f1_and_4_nl , butterFly1_3_f1_or_nl
      , butterFly1_3_f1_and_6_nl});
  assign butterFly1_3_f1_butterFly1_3_f1_and_nl = (z_out_29[31]) & (~(butterFly1_3_f1_and_ssc
      | butterFly1_3_f1_and_ssc_2));
  assign butterFly1_3_f1_or_1_nl = ((modulo_sub_base_6_sva_1[31]) & (fsm_output[4]))
      | ((modulo_sub_base_14_sva_1[31]) & (fsm_output[7]));
  assign butterFly1_3_f1_mux1h_11_nl = MUX1HOT_v_31_3_2((modulo_sub_base_6_sva_1[30:0]),
      (z_out_29[30:0]), (modulo_sub_base_14_sva_1[30:0]), {butterFly1_3_f1_and_ssc
      , butterFly1_3_f1_or_1_nl , butterFly1_3_f1_and_ssc_2});
  assign xt_rsc_0_2_i_da_d = {butterFly1_3_f1_mux1h_2_nl , butterFly1_3_f1_butterFly1_3_f1_and_nl
      , butterFly1_3_f1_mux1h_11_nl};
  assign xt_rsc_0_2_i_wea_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign xt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_112_rmff}}, or_112_rmff};
  assign xt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign xt_rsc_0_3_i_adra_d = {butterFly1_3_f2_butterFly1_3_f2_and_10_rmff , butterFly1_3_f2_mux1h_rmff
      , butterFly1_3_f2_butterFly1_3_f2_or_6_rmff , butterFly1_3_f2_butterFly1_3_f2_or_7_rmff
      , butterFly1_3_f2_mux1h_rmff , butterFly1_3_f2_butterFly1_3_f2_and_11_rmff};
  assign modulo_add_7_qif_mux_2_nl = MUX_v_32_2_2(modulo_add_base_7_sva_1, modulo_add_base_15_sva_1,
      fsm_output[7]);
  assign nl_acc_4_nl = ({modulo_add_7_qif_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_4_nl = nl_acc_4_nl[32:0];
  assign butterFly1_3_f2_and_4_nl = (~ z_out_37_32) & (fsm_output[4]);
  assign butterFly1_3_f2_or_nl = (z_out_37_32 & (fsm_output[4])) | (z_out_37_32 &
      (fsm_output[7]));
  assign butterFly1_3_f2_and_6_nl = (~ z_out_37_32) & (fsm_output[7]);
  assign butterFly1_3_f2_mux1h_6_nl = MUX1HOT_v_32_3_2(modulo_add_base_7_sva_1, (readslicef_33_32_1(acc_4_nl)),
      modulo_add_base_15_sva_1, {butterFly1_3_f2_and_4_nl , butterFly1_3_f2_or_nl
      , butterFly1_3_f2_and_6_nl});
  assign butterFly1_3_f2_butterFly1_3_f2_and_nl = (z_out_27[31]) & (~(butterFly1_3_f2_and_ssc
      | butterFly1_3_f2_and_ssc_2));
  assign butterFly1_3_f2_or_1_nl = ((modulo_sub_base_7_sva_1[31]) & (fsm_output[4]))
      | ((modulo_sub_base_15_sva_1[31]) & (fsm_output[7]));
  assign butterFly1_3_f2_mux1h_9_nl = MUX1HOT_v_31_3_2((modulo_sub_base_7_sva_1[30:0]),
      (z_out_27[30:0]), (modulo_sub_base_15_sva_1[30:0]), {butterFly1_3_f2_and_ssc
      , butterFly1_3_f2_or_1_nl , butterFly1_3_f2_and_ssc_2});
  assign xt_rsc_0_3_i_da_d = {butterFly1_3_f2_mux1h_6_nl , butterFly1_3_f2_butterFly1_3_f2_and_nl
      , butterFly1_3_f2_mux1h_9_nl};
  assign xt_rsc_0_3_i_wea_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign xt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d = {{1{or_112_rmff}}, or_112_rmff};
  assign xt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d = {butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff
      , butterFly1_2_f1_butterFly1_2_f1_butterFly1_2_f1_nor_rmff};
  assign twiddle_rsc_0_0_i_radr_d = {INNER_LOOP1_tw_h_INNER_LOOP1_tw_h_nor_1_rmff
      , INNER_LOOP1_tw_h_mux1h_rmff};
  assign twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_pff = INNER_LOOP1_INNER_LOOP1_and_8_cse
      | and_206_cse | and_207_cse | INNER_LOOP2_INNER_LOOP2_and_1_cse;
  assign twiddle_rsc_0_1_i_radr_d = {1'b0 , INNER_LOOP4_r_15_2_sva_12_0_mx1};
  assign twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_pff = INNER_LOOP1_INNER_LOOP1_and_8_cse;
  assign twiddle_rsc_0_2_i_radr_d = {butterFly2_2_tw_butterFly2_2_tw_nor_rmff , butterFly2_2_tw_butterFly2_2_tw_mux_rmff};
  assign twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_pff = INNER_LOOP1_INNER_LOOP1_and_8_cse
      | and_206_cse;
  assign twiddle_rsc_0_3_i_radr_d = {1'b0 , INNER_LOOP4_r_15_2_sva_12_0_mx1};
  assign twiddle_h_rsc_0_0_i_radr_d = {INNER_LOOP1_tw_h_INNER_LOOP1_tw_h_nor_1_rmff
      , INNER_LOOP1_tw_h_mux1h_rmff};
  assign twiddle_h_rsc_0_1_i_radr_d = {1'b0 , INNER_LOOP4_r_15_2_sva_12_0_mx1};
  assign twiddle_h_rsc_0_2_i_radr_d = {butterFly2_2_tw_butterFly2_2_tw_nor_rmff ,
      butterFly2_2_tw_butterFly2_2_tw_mux_rmff};
  assign twiddle_h_rsc_0_3_i_radr_d = {1'b0 , INNER_LOOP4_r_15_2_sva_12_0_mx1};
  always @(posedge clk) begin
    if ( (fsm_output[8]) | (fsm_output[0]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_yt_rsc_0_0_cgo_cse <= 1'b0;
      reg_xt_rsc_triosy_0_3_obj_ld_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      INNER_LOOP1_stage_0 <= 1'b0;
      INNER_LOOP1_stage_0_2 <= 1'b0;
      INNER_LOOP1_stage_0_3 <= 1'b0;
      INNER_LOOP1_stage_0_4 <= 1'b0;
      INNER_LOOP1_stage_0_5 <= 1'b0;
      INNER_LOOP1_stage_0_6 <= 1'b0;
      INNER_LOOP1_stage_0_7 <= 1'b0;
      INNER_LOOP1_stage_0_8 <= 1'b0;
      INNER_LOOP1_stage_0_9 <= 1'b0;
      INNER_LOOP1_stage_0_10 <= 1'b0;
      INNER_LOOP2_stage_0 <= 1'b0;
      INNER_LOOP2_stage_0_2 <= 1'b0;
      INNER_LOOP2_stage_0_3 <= 1'b0;
      INNER_LOOP2_stage_0_4 <= 1'b0;
      INNER_LOOP2_stage_0_5 <= 1'b0;
      INNER_LOOP2_stage_0_6 <= 1'b0;
      INNER_LOOP2_stage_0_7 <= 1'b0;
      INNER_LOOP2_stage_0_8 <= 1'b0;
      INNER_LOOP2_stage_0_9 <= 1'b0;
      INNER_LOOP3_stage_0 <= 1'b0;
      INNER_LOOP4_stage_0 <= 1'b0;
      INNER_LOOP4_stage_0_2 <= 1'b0;
      INNER_LOOP4_stage_0_3 <= 1'b0;
      INNER_LOOP4_stage_0_4 <= 1'b0;
      INNER_LOOP4_stage_0_5 <= 1'b0;
      INNER_LOOP4_stage_0_6 <= 1'b0;
      INNER_LOOP4_stage_0_7 <= 1'b0;
      INNER_LOOP4_stage_0_8 <= 1'b0;
      INNER_LOOP4_stage_0_9 <= 1'b0;
    end
    else begin
      reg_yt_rsc_0_0_cgo_cse <= or_39_rmff;
      reg_xt_rsc_triosy_0_3_obj_ld_cse <= INNER_LOOP4_nor_tmp & (fsm_output[7]);
      reg_ensig_cgo_cse <= or_182_rmff;
      INNER_LOOP1_stage_0 <= ~((~(INNER_LOOP1_stage_0 & (~ (z_out_30[13])))) & (fsm_output[2]));
      INNER_LOOP1_stage_0_2 <= INNER_LOOP1_mux_nl & (~ or_tmp_232);
      INNER_LOOP1_stage_0_3 <= INNER_LOOP1_stage_0_2 & (~ or_tmp_232);
      INNER_LOOP1_stage_0_4 <= INNER_LOOP1_stage_0_3 & (~ or_tmp_232);
      INNER_LOOP1_stage_0_5 <= INNER_LOOP1_stage_0_4 & (~ or_tmp_232);
      INNER_LOOP1_stage_0_6 <= INNER_LOOP1_stage_0_5 & (~ or_tmp_232);
      INNER_LOOP1_stage_0_7 <= INNER_LOOP1_stage_0_6 & (~ or_tmp_232);
      INNER_LOOP1_stage_0_8 <= INNER_LOOP1_stage_0_7 & (~ or_tmp_232);
      INNER_LOOP1_stage_0_9 <= INNER_LOOP1_stage_0_8 & (~ or_tmp_232);
      INNER_LOOP1_stage_0_10 <= INNER_LOOP1_stage_0_9 & (~ or_tmp_232);
      INNER_LOOP2_stage_0 <= ~((~(INNER_LOOP2_stage_0 & (~ (z_out_30[13])))) & (fsm_output[4]));
      INNER_LOOP2_stage_0_2 <= INNER_LOOP2_INNER_LOOP2_and_1_cse;
      INNER_LOOP2_stage_0_3 <= INNER_LOOP2_stage_0_2 & (fsm_output[4]);
      INNER_LOOP2_stage_0_4 <= INNER_LOOP2_stage_0_3 & (fsm_output[4]);
      INNER_LOOP2_stage_0_5 <= INNER_LOOP2_stage_0_4 & (fsm_output[4]);
      INNER_LOOP2_stage_0_6 <= INNER_LOOP2_stage_0_5 & (fsm_output[4]);
      INNER_LOOP2_stage_0_7 <= INNER_LOOP2_stage_0_6 & (fsm_output[4]);
      INNER_LOOP2_stage_0_8 <= INNER_LOOP2_stage_0_7 & (fsm_output[4]);
      INNER_LOOP2_stage_0_9 <= INNER_LOOP2_stage_0_8 & (fsm_output[4]);
      INNER_LOOP3_stage_0 <= ~((~(INNER_LOOP3_stage_0 & (~ (z_out_30[13])))) & (fsm_output[6]));
      INNER_LOOP4_stage_0 <= ~((~(INNER_LOOP4_stage_0 & (~ (z_out_30[13])))) & (fsm_output[7]));
      INNER_LOOP4_stage_0_2 <= INNER_LOOP1_INNER_LOOP1_and_8_cse;
      INNER_LOOP4_stage_0_3 <= INNER_LOOP4_stage_0_2 & (fsm_output[7]);
      INNER_LOOP4_stage_0_4 <= INNER_LOOP4_stage_0_3 & (fsm_output[7]);
      INNER_LOOP4_stage_0_5 <= INNER_LOOP4_stage_0_4 & (fsm_output[7]);
      INNER_LOOP4_stage_0_6 <= INNER_LOOP4_stage_0_5 & (fsm_output[7]);
      INNER_LOOP4_stage_0_7 <= INNER_LOOP4_stage_0_6 & (fsm_output[7]);
      INNER_LOOP4_stage_0_8 <= INNER_LOOP4_stage_0_7 & (fsm_output[7]);
      INNER_LOOP4_stage_0_9 <= INNER_LOOP4_stage_0_8 & (fsm_output[7]);
    end
  end
  always @(posedge clk) begin
    c_3_1_sva <= MUX_v_3_2_2(3'b000, operator_32_false_acc_psp_sva, (fsm_output[5]));
    mult_z_mul_cmp_a <= MUX1HOT_v_32_3_2((xt_rsc_0_1_i_qa_d[31:0]), (yt_rsc_0_1_i_qa_d[63:32]),
        (yt_rsc_0_3_i_qa_d[63:32]), {or_dcpl_14 , (fsm_output[4]) , (fsm_output[7])});
    mult_z_mul_cmp_b <= MUX_v_32_2_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_1_i_q_d,
        fsm_output[7]);
    mult_z_mul_cmp_1_a <= MUX_v_32_2_2((mult_t_mul_cmp_1_z[63:32]), (mult_t_mul_cmp_3_z[63:32]),
        fsm_output[7]);
    reg_mult_z_mul_cmp_1_b_cse <= p_sva;
    mult_z_mul_cmp_2_a <= MUX1HOT_v_32_3_2((xt_rsc_0_3_i_qa_d[63:32]), (yt_rsc_0_3_i_qa_d[31:0]),
        (yt_rsc_0_1_i_qa_d[31:0]), {or_dcpl_14 , (fsm_output[4]) , (fsm_output[7])});
    mult_z_mul_cmp_2_b <= MUX_v_32_2_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_2_i_q_d,
        or_233_nl);
    mult_z_mul_cmp_3_a <= MUX1HOT_v_32_3_2((mult_t_mul_cmp_2_z[63:32]), (mult_t_mul_cmp_3_z[63:32]),
        (mult_t_mul_cmp_1_z[63:32]), {or_tmp_153 , (fsm_output[6]) , (fsm_output[7])});
    mult_z_mul_cmp_4_a <= MUX1HOT_v_32_3_2((xt_rsc_0_1_i_qa_d[63:32]), (yt_rsc_0_1_i_qa_d[31:0]),
        (yt_rsc_0_1_i_qa_d[63:32]), {or_dcpl_14 , (fsm_output[4]) , (fsm_output[7])});
    mult_z_mul_cmp_4_b <= MUX_v_32_2_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_2_i_q_d,
        fsm_output[6]);
    mult_z_mul_cmp_5_a <= MUX1HOT_v_32_3_2((mult_t_mul_cmp_3_z[63:32]), (mult_t_mul_cmp_2_z[63:32]),
        (mult_t_mul_cmp_z[63:32]), {or_tmp_153 , (fsm_output[6]) , (fsm_output[7])});
    mult_z_mul_cmp_6_a <= MUX1HOT_v_32_3_2((xt_rsc_0_3_i_qa_d[31:0]), (yt_rsc_0_3_i_qa_d[63:32]),
        (yt_rsc_0_3_i_qa_d[31:0]), {or_dcpl_14 , (fsm_output[4]) , (fsm_output[7])});
    mult_z_mul_cmp_6_b <= MUX_v_32_2_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_3_i_q_d,
        fsm_output[7]);
    mult_z_mul_cmp_7_a <= MUX_v_32_2_2((mult_t_mul_cmp_z[63:32]), (mult_t_mul_cmp_2_z[63:32]),
        fsm_output[7]);
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0_8 ) begin
      modulo_add_base_sva_1 <= z_out;
      modulo_add_base_1_sva_1 <= nl_modulo_add_base_1_sva_1[31:0];
      modulo_add_base_2_sva_1 <= z_out_2;
      modulo_add_base_3_sva_1 <= nl_modulo_add_base_3_sva_1[31:0];
      butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_7 <= butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_6;
      modulo_add_base_8_sva_1 <= z_out_8;
      modulo_add_base_9_sva_1 <= z_out_10;
      modulo_add_base_10_sva_1 <= nl_modulo_add_base_10_sva_1[31:0];
      modulo_add_base_11_sva_1 <= nl_modulo_add_base_11_sva_1[31:0];
      butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_7 <= butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_6;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modulo_sub_base_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_1_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_2_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_3_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_8_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_9_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_10_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_11_sva_1 <= 32'b00000000000000000000000000000000;
    end
    else if ( INNER_LOOP1_stage_0_8 ) begin
      modulo_sub_base_sva_1 <= z_out_1;
      modulo_sub_base_1_sva_1 <= nl_modulo_sub_base_1_sva_1[31:0];
      modulo_sub_base_2_sva_1 <= z_out_3;
      modulo_sub_base_3_sva_1 <= nl_modulo_sub_base_3_sva_1[31:0];
      modulo_sub_base_8_sva_1 <= z_out_9;
      modulo_sub_base_9_sva_1 <= z_out_11;
      modulo_sub_base_10_sva_1 <= nl_modulo_sub_base_10_sva_1[31:0];
      modulo_sub_base_11_sva_1 <= nl_modulo_sub_base_11_sva_1[31:0];
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0_7 ) begin
      mult_res_sva_1 <= mult_res_sva_2;
      mult_1_res_sva_1 <= mult_1_res_sva_2;
      mult_2_res_sva_1 <= mult_2_res_sva_2;
      mult_3_res_sva_1 <= mult_3_res_sva_2;
      reg_tmp_22_sva_6_cse <= tmp_22_sva_5;
      reg_tmp_20_sva_6_cse <= tmp_20_sva_5;
      reg_tmp_18_sva_6_cse <= tmp_18_sva_5;
      reg_tmp_16_sva_6_cse <= tmp_16_sva_5;
      butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_6 <= butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_5;
      mult_8_res_sva_1 <= mult_8_res_sva_2;
      mult_9_res_sva_1 <= mult_9_res_sva_2;
      mult_10_res_sva_1 <= mult_10_res_sva_2;
      mult_11_res_sva_1 <= mult_11_res_sva_2;
      butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_6 <= butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_5;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_mult_3_slc_32_svs_st_1_cse <= 1'b0;
      reg_mult_2_slc_32_svs_st_1_cse <= 1'b0;
      reg_mult_1_slc_32_svs_st_1_cse <= 1'b0;
      reg_mult_slc_32_svs_st_1_cse <= 1'b0;
    end
    else if ( INNER_LOOP1_stage_0_7 ) begin
      reg_mult_3_slc_32_svs_st_1_cse <= z_out_31_32;
      reg_mult_2_slc_32_svs_st_1_cse <= z_out_32_32;
      reg_mult_1_slc_32_svs_st_1_cse <= z_out_33_32;
      reg_mult_slc_32_svs_st_1_cse <= z_out_34_32;
    end
  end
  always @(posedge clk) begin
    if ( ~((~((~ INNER_LOOP1_r_asn_11_itm_1) & INNER_LOOP1_stage_0_2)) & (fsm_output[2]))
        ) begin
      INNER_LOOP1_r_15_2_sva_12_0 <= MUX_v_13_2_2(13'b0000000000000, INNER_LOOP1_r_15_2_sva_12_0_mx1,
          (fsm_output[2]));
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0 & (~ (z_out_30[13])) ) begin
      INNER_LOOP1_r_15_2_sva_1_1_12_0 <= z_out_30[12:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      INNER_LOOP1_r_asn_11_itm_1 <= 1'b0;
    end
    else if ( INNER_LOOP1_stage_0 ) begin
      INNER_LOOP1_r_asn_11_itm_1 <= z_out_30[13];
    end
  end
  always @(posedge clk) begin
    if ( ~ (fsm_output[2]) ) begin
      operator_34_true_return_14_2_sva <= z_out_43[14:2];
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[1] ) begin
      operator_32_false_acc_psp_sva <= z_out_44;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0_6 ) begin
      reg_mult_3_z_asn_itm_3_cse <= mult_3_z_asn_itm_2;
      reg_mult_2_z_asn_itm_3_cse <= mult_2_z_asn_itm_2;
      reg_mult_1_z_asn_itm_3_cse <= mult_1_z_asn_itm_2;
      reg_mult_z_asn_itm_3_cse <= mult_z_asn_itm_2;
      butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_5 <= butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_4;
      tmp_22_sva_5 <= tmp_22_sva_4;
      tmp_20_sva_5 <= tmp_20_sva_4;
      tmp_18_sva_5 <= tmp_18_sva_4;
      tmp_16_sva_5 <= tmp_16_sva_4;
      butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_5 <= butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_4;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0_5 ) begin
      mult_3_z_asn_itm_2 <= mult_3_z_asn_itm_1;
      mult_2_z_asn_itm_2 <= mult_2_z_asn_itm_1;
      mult_1_z_asn_itm_2 <= mult_1_z_asn_itm_1;
      mult_z_asn_itm_2 <= mult_z_asn_itm_1;
      butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_4 <= butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_3;
      tmp_22_sva_4 <= reg_tmp_22_sva_3_cse;
      tmp_20_sva_4 <= reg_tmp_20_sva_3_cse;
      tmp_18_sva_4 <= reg_tmp_18_sva_3_cse;
      tmp_16_sva_4 <= reg_tmp_16_sva_3_cse;
      butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_4 <= butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_3;
    end
  end
  always @(posedge clk) begin
    if ( or_dcpl_2 ) begin
      mult_3_z_asn_itm_1 <= mult_z_mul_cmp_2_z_oreg;
      mult_2_z_asn_itm_1 <= mult_z_mul_cmp_4_z_oreg;
      mult_1_z_asn_itm_1 <= mult_z_mul_cmp_6_z_oreg;
      mult_z_asn_itm_1 <= mult_z_mul_cmp_z_oreg;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0_4 ) begin
      butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_3 <= butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_2;
      reg_tmp_22_sva_3_cse <= tmp_22_sva_2;
      reg_tmp_20_sva_3_cse <= tmp_20_sva_2;
      reg_tmp_18_sva_3_cse <= tmp_18_sva_2;
      reg_tmp_16_sva_3_cse <= tmp_16_sva_2;
      butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_3 <= butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_2;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0_3 ) begin
      butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_2 <= butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_1;
      tmp_22_sva_2 <= tmp_22_sva_1;
      tmp_20_sva_2 <= tmp_20_sva_1;
      tmp_18_sva_2 <= tmp_18_sva_1;
      tmp_16_sva_2 <= tmp_16_sva_1;
      butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_2 <= butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_1;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP1_stage_0_2 ) begin
      butterFly1_3_slc_INNER_LOOP1_r_15_2_12_0_itm_1 <= INNER_LOOP1_r_15_2_sva_12_0;
      tmp_22_sva_1 <= xt_rsc_0_2_i_qa_d[63:32];
      tmp_20_sva_1 <= xt_rsc_0_0_i_qa_d[63:32];
      tmp_18_sva_1 <= xt_rsc_0_2_i_qa_d[31:0];
      tmp_16_sva_1 <= xt_rsc_0_0_i_qa_d[31:0];
      butterFly2_3_slc_INNER_LOOP3_r_15_2_12_0_itm_1 <= INNER_LOOP3_r_15_2_sva_12_0;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP2_stage_0_8 ) begin
      modulo_add_base_4_sva_1 <= z_out;
      modulo_add_base_5_sva_1 <= z_out_2;
      modulo_add_base_6_sva_1 <= nl_modulo_add_base_6_sva_1[31:0];
      modulo_add_base_7_sva_1 <= nl_modulo_add_base_7_sva_1[31:0];
      butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_7 <= butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_6;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modulo_sub_base_4_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_5_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_6_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_7_sva_1 <= 32'b00000000000000000000000000000000;
    end
    else if ( INNER_LOOP2_stage_0_8 ) begin
      modulo_sub_base_4_sva_1 <= z_out_1;
      modulo_sub_base_5_sva_1 <= z_out_3;
      modulo_sub_base_6_sva_1 <= nl_modulo_sub_base_6_sva_1[31:0];
      modulo_sub_base_7_sva_1 <= nl_modulo_sub_base_7_sva_1[31:0];
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP2_stage_0_7 ) begin
      mult_4_res_sva_1 <= mult_4_res_sva_2;
      mult_5_res_sva_1 <= mult_5_res_sva_2;
      mult_6_res_sva_1 <= mult_6_res_sva_2;
      mult_7_res_sva_1 <= mult_7_res_sva_2;
      tmp_6_sva_6 <= tmp_6_sva_5;
      tmp_4_sva_6 <= tmp_4_sva_5;
      tmp_2_sva_6 <= tmp_2_sva_5;
      tmp_sva_6 <= tmp_sva_5;
      butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_6 <= butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_5;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      mult_7_slc_32_svs_st_1 <= 1'b0;
      mult_6_slc_32_svs_st_1 <= 1'b0;
      mult_5_slc_32_svs_st_1 <= 1'b0;
      mult_4_slc_32_svs_st_1 <= 1'b0;
    end
    else if ( INNER_LOOP2_stage_0_7 ) begin
      mult_7_slc_32_svs_st_1 <= z_out_31_32;
      mult_6_slc_32_svs_st_1 <= z_out_32_32;
      mult_5_slc_32_svs_st_1 <= z_out_33_32;
      mult_4_slc_32_svs_st_1 <= z_out_34_32;
    end
  end
  always @(posedge clk) begin
    if ( ~((~((~ INNER_LOOP2_r_asn_10_itm_1) & INNER_LOOP2_stage_0_2)) & (fsm_output[4]))
        ) begin
      INNER_LOOP2_r_15_2_sva_12_0 <= MUX_v_13_2_2(13'b0000000000000, INNER_LOOP2_r_15_2_sva_12_0_mx1,
          (fsm_output[4]));
    end
  end
  always @(posedge clk) begin
    if ( (~(INNER_LOOP2_nor_tmp | (z_out_30[13]))) & INNER_LOOP2_stage_0 ) begin
      INNER_LOOP2_r_15_2_sva_1_1_12_0 <= z_out_30[12:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      INNER_LOOP2_r_asn_10_itm_1 <= 1'b0;
    end
    else if ( INNER_LOOP2_stage_0 ) begin
      INNER_LOOP2_r_asn_10_itm_1 <= z_out_30[13];
    end
  end
  always @(posedge clk) begin
    if ( ~ (fsm_output[4]) ) begin
      operator_34_true_1_lshift_psp_13_2_sva <= z_out_43[13:2];
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP2_stage_0_6 ) begin
      mult_7_z_asn_itm_3 <= mult_7_z_asn_itm_2;
      mult_6_z_asn_itm_3 <= mult_6_z_asn_itm_2;
      mult_5_z_asn_itm_3 <= mult_5_z_asn_itm_2;
      mult_4_z_asn_itm_3 <= mult_4_z_asn_itm_2;
      butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_5 <= butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_4;
      tmp_6_sva_5 <= tmp_6_sva_4;
      tmp_4_sva_5 <= tmp_4_sva_4;
      tmp_2_sva_5 <= tmp_2_sva_4;
      tmp_sva_5 <= tmp_sva_4;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP2_stage_0_5 ) begin
      mult_7_z_asn_itm_2 <= mult_3_z_asn_itm_1;
      mult_6_z_asn_itm_2 <= mult_2_z_asn_itm_1;
      mult_5_z_asn_itm_2 <= mult_1_z_asn_itm_1;
      mult_4_z_asn_itm_2 <= mult_z_asn_itm_1;
      butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_4 <= butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_3;
      tmp_6_sva_4 <= tmp_6_sva_3;
      tmp_4_sva_4 <= tmp_4_sva_3;
      tmp_2_sva_4 <= tmp_2_sva_3;
      tmp_sva_4 <= tmp_sva_3;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP2_stage_0_4 ) begin
      butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_3 <= butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_2;
      tmp_6_sva_3 <= tmp_6_sva_2;
      tmp_4_sva_3 <= tmp_4_sva_2;
      tmp_2_sva_3 <= tmp_2_sva_2;
      tmp_sva_3 <= tmp_sva_2;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP2_stage_0_3 ) begin
      butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_2 <= butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_1;
      tmp_6_sva_2 <= tmp_6_sva_1;
      tmp_4_sva_2 <= tmp_4_sva_1;
      tmp_2_sva_2 <= tmp_2_sva_1;
      tmp_sva_2 <= tmp_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP2_stage_0_2 ) begin
      butterFly1_7_slc_INNER_LOOP2_r_15_2_12_0_itm_1 <= INNER_LOOP2_r_15_2_sva_12_0;
    end
  end
  always @(posedge clk) begin
    if ( or_dcpl_3 ) begin
      tmp_6_sva_1 <= yt_rsc_0_2_i_qa_d[31:0];
      tmp_4_sva_1 <= yt_rsc_0_0_i_qa_d[31:0];
      tmp_2_sva_1 <= yt_rsc_0_2_i_qa_d[63:32];
      tmp_sva_1 <= yt_rsc_0_0_i_qa_d[63:32];
    end
  end
  always @(posedge clk) begin
    if ( ~((~((~ INNER_LOOP3_r_asn_14_itm_1) & INNER_LOOP1_stage_0_2)) & (fsm_output[6]))
        ) begin
      INNER_LOOP3_r_15_2_sva_12_0 <= MUX_v_13_2_2(13'b0000000000000, INNER_LOOP3_r_15_2_sva_12_0_mx1,
          (fsm_output[6]));
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP3_stage_0 & (~ (z_out_30[13])) ) begin
      INNER_LOOP3_r_15_2_sva_1_1_12_0 <= z_out_30[12:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      INNER_LOOP3_r_asn_14_itm_1 <= 1'b0;
    end
    else if ( INNER_LOOP3_stage_0 ) begin
      INNER_LOOP3_r_asn_14_itm_1 <= z_out_30[13];
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0_8 ) begin
      modulo_add_base_12_sva_1 <= z_out_8;
      modulo_add_base_13_sva_1 <= z_out_10;
      modulo_add_base_14_sva_1 <= nl_modulo_add_base_14_sva_1[31:0];
      modulo_add_base_15_sva_1 <= nl_modulo_add_base_15_sva_1[31:0];
      butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_7 <= butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_6;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modulo_sub_base_12_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_13_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_14_sva_1 <= 32'b00000000000000000000000000000000;
      modulo_sub_base_15_sva_1 <= 32'b00000000000000000000000000000000;
    end
    else if ( INNER_LOOP4_stage_0_8 ) begin
      modulo_sub_base_12_sva_1 <= z_out_9;
      modulo_sub_base_13_sva_1 <= z_out_11;
      modulo_sub_base_14_sva_1 <= nl_modulo_sub_base_14_sva_1[31:0];
      modulo_sub_base_15_sva_1 <= nl_modulo_sub_base_15_sva_1[31:0];
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0_7 ) begin
      mult_12_res_sva_1 <= mult_12_res_sva_2;
      mult_13_res_sva_1 <= mult_13_res_sva_2;
      mult_14_res_sva_1 <= mult_14_res_sva_2;
      mult_15_res_sva_1 <= mult_15_res_sva_2;
      tmp_14_sva_6 <= tmp_14_sva_5;
      tmp_12_sva_6 <= tmp_12_sva_5;
      tmp_10_sva_6 <= tmp_10_sva_5;
      tmp_8_sva_6 <= tmp_8_sva_5;
      butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_6 <= butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_5;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      mult_15_slc_32_svs_st_1 <= 1'b0;
      mult_14_slc_32_svs_st_1 <= 1'b0;
      mult_13_slc_32_svs_st_1 <= 1'b0;
      mult_12_slc_32_svs_st_1 <= 1'b0;
    end
    else if ( INNER_LOOP4_stage_0_7 ) begin
      mult_15_slc_32_svs_st_1 <= z_out_31_32;
      mult_14_slc_32_svs_st_1 <= z_out_32_32;
      mult_13_slc_32_svs_st_1 <= z_out_33_32;
      mult_12_slc_32_svs_st_1 <= z_out_34_32;
    end
  end
  always @(posedge clk) begin
    if ( ~((~((~ INNER_LOOP4_r_asn_18_itm_1) & INNER_LOOP4_stage_0_2)) & (fsm_output[7]))
        ) begin
      INNER_LOOP4_r_15_2_sva_12_0 <= MUX_v_13_2_2(13'b0000000000000, INNER_LOOP4_r_15_2_sva_12_0_mx1,
          (fsm_output[7]));
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0 & (~ (z_out_30[13])) ) begin
      INNER_LOOP4_r_15_2_sva_1_1_12_0 <= z_out_30[12:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      INNER_LOOP4_r_asn_18_itm_1 <= 1'b0;
    end
    else if ( INNER_LOOP4_stage_0 ) begin
      INNER_LOOP4_r_asn_18_itm_1 <= z_out_30[13];
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0_6 ) begin
      mult_15_z_asn_itm_3 <= mult_15_z_asn_itm_2;
      mult_14_z_asn_itm_3 <= mult_14_z_asn_itm_2;
      mult_13_z_asn_itm_3 <= mult_13_z_asn_itm_2;
      mult_12_z_asn_itm_3 <= mult_12_z_asn_itm_2;
      butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_5 <= butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_4;
      tmp_14_sva_5 <= tmp_14_sva_4;
      tmp_12_sva_5 <= tmp_12_sva_4;
      tmp_10_sva_5 <= tmp_10_sva_4;
      tmp_8_sva_5 <= tmp_8_sva_4;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0_5 ) begin
      mult_15_z_asn_itm_2 <= mult_1_z_asn_itm_1;
      mult_14_z_asn_itm_2 <= mult_3_z_asn_itm_1;
      mult_13_z_asn_itm_2 <= mult_z_asn_itm_1;
      mult_12_z_asn_itm_2 <= mult_2_z_asn_itm_1;
      butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_4 <= butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_3;
      tmp_14_sva_4 <= tmp_14_sva_3;
      tmp_12_sva_4 <= tmp_12_sva_3;
      tmp_10_sva_4 <= tmp_10_sva_3;
      tmp_8_sva_4 <= tmp_8_sva_3;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0_4 ) begin
      butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_3 <= butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_2;
      tmp_14_sva_3 <= tmp_14_sva_2;
      tmp_12_sva_3 <= tmp_12_sva_2;
      tmp_10_sva_3 <= tmp_10_sva_2;
      tmp_8_sva_3 <= tmp_8_sva_2;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0_3 ) begin
      butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_2 <= butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_1;
      tmp_14_sva_2 <= tmp_6_sva_1;
      tmp_12_sva_2 <= tmp_4_sva_1;
      tmp_10_sva_2 <= tmp_2_sva_1;
      tmp_8_sva_2 <= tmp_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( INNER_LOOP4_stage_0_2 ) begin
      butterFly2_7_slc_INNER_LOOP4_r_15_2_12_0_itm_1 <= INNER_LOOP4_r_15_2_sva_12_0;
    end
  end
  assign or_233_nl = (fsm_output[7:6]!=2'b00);
  assign INNER_LOOP1_mux_nl = MUX_s_1_2_2(INNER_LOOP1_stage_0, INNER_LOOP3_stage_0,
      fsm_output[6]);
  assign nl_modulo_add_base_1_sva_1  = reg_tmp_18_sva_6_cse + mult_1_res_lpi_3_dfm_mx0;
  assign nl_modulo_sub_base_1_sva_1  = reg_tmp_18_sva_6_cse - mult_1_res_lpi_3_dfm_mx0;
  assign nl_modulo_add_base_3_sva_1  = reg_tmp_22_sva_6_cse + mult_3_res_lpi_3_dfm_mx0;
  assign nl_modulo_sub_base_3_sva_1  = reg_tmp_22_sva_6_cse - mult_3_res_lpi_3_dfm_mx0;
  assign nl_modulo_add_base_10_sva_1  = reg_tmp_20_sva_6_cse + mult_10_res_lpi_2_dfm_mx0;
  assign nl_modulo_sub_base_10_sva_1  = reg_tmp_20_sva_6_cse - mult_10_res_lpi_2_dfm_mx0;
  assign nl_modulo_add_base_11_sva_1  = reg_tmp_22_sva_6_cse + mult_11_res_lpi_2_dfm_mx0;
  assign nl_modulo_sub_base_11_sva_1  = reg_tmp_22_sva_6_cse - mult_11_res_lpi_2_dfm_mx0;
  assign nl_modulo_add_base_6_sva_1  = tmp_4_sva_6 + mult_6_res_lpi_3_dfm_mx0;
  assign nl_modulo_sub_base_6_sva_1  = tmp_4_sva_6 - mult_6_res_lpi_3_dfm_mx0;
  assign nl_modulo_add_base_7_sva_1  = tmp_6_sva_6 + mult_7_res_lpi_3_dfm_mx0;
  assign nl_modulo_sub_base_7_sva_1  = tmp_6_sva_6 - mult_7_res_lpi_3_dfm_mx0;
  assign nl_modulo_add_base_14_sva_1  = tmp_12_sva_6 + mult_14_res_lpi_2_dfm_mx0;
  assign nl_modulo_sub_base_14_sva_1  = tmp_12_sva_6 - mult_14_res_lpi_2_dfm_mx0;
  assign nl_modulo_add_base_15_sva_1  = tmp_14_sva_6 + mult_15_res_lpi_2_dfm_mx0;
  assign nl_modulo_sub_base_15_sva_1  = tmp_14_sva_6 - mult_15_res_lpi_2_dfm_mx0;
  assign butterFly1_mux_12_cse = MUX_v_32_2_2(reg_tmp_16_sva_6_cse, tmp_sva_6, fsm_output[4]);
  assign butterFly1_mux_13_nl = MUX_v_32_2_2(mult_res_lpi_3_dfm_mx0, mult_4_res_lpi_3_dfm_mx0,
      fsm_output[4]);
  assign nl_z_out = butterFly1_mux_12_cse + butterFly1_mux_13_nl;
  assign z_out = nl_z_out[31:0];
  assign butterFly1_mux_15_nl = MUX_v_32_2_2((~ mult_res_lpi_3_dfm_mx0), (~ mult_4_res_lpi_3_dfm_mx0),
      fsm_output[4]);
  assign nl_acc_1_nl = ({butterFly1_mux_12_cse , 1'b1}) + ({butterFly1_mux_15_nl
      , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[32:0];
  assign z_out_1 = readslicef_33_32_1(acc_1_nl);
  assign butterFly1_2_mux_12_cse = MUX_v_32_2_2(reg_tmp_20_sva_6_cse, tmp_2_sva_6,
      fsm_output[4]);
  assign butterFly1_2_mux_13_nl = MUX_v_32_2_2(mult_2_res_lpi_3_dfm_mx0, mult_5_res_lpi_3_dfm_mx0,
      fsm_output[4]);
  assign nl_z_out_2 = butterFly1_2_mux_12_cse + butterFly1_2_mux_13_nl;
  assign z_out_2 = nl_z_out_2[31:0];
  assign butterFly1_2_mux_15_nl = MUX_v_32_2_2((~ mult_2_res_lpi_3_dfm_mx0), (~ mult_5_res_lpi_3_dfm_mx0),
      fsm_output[4]);
  assign nl_acc_3_nl = ({butterFly1_2_mux_12_cse , 1'b1}) + ({butterFly1_2_mux_15_nl
      , 1'b1});
  assign acc_3_nl = nl_acc_3_nl[32:0];
  assign z_out_3 = readslicef_33_32_1(acc_3_nl);
  assign modulo_sub_3_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_3_sva_1[30:0]),
      (modulo_sub_base_11_sva_1[30:0]), fsm_output[6]);
  assign nl_z_out_5 = ({1'b1 , modulo_sub_3_qif_mux_2_nl}) + p_sva;
  assign z_out_5 = nl_z_out_5[31:0];
  assign modulo_sub_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_sva_1[30:0]), (modulo_sub_base_8_sva_1[30:0]),
      fsm_output[6]);
  assign nl_z_out_6 = ({1'b1 , modulo_sub_qif_mux_2_nl}) + p_sva;
  assign z_out_6 = nl_z_out_6[31:0];
  assign modulo_sub_2_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_2_sva_1[30:0]),
      (modulo_sub_base_10_sva_1[30:0]), fsm_output[6]);
  assign nl_z_out_7 = ({1'b1 , modulo_sub_2_qif_mux_2_nl}) + p_sva;
  assign z_out_7 = nl_z_out_7[31:0];
  assign butterFly2_mux_4_cse = MUX_v_32_2_2(reg_tmp_16_sva_6_cse, tmp_8_sva_6, fsm_output[7]);
  assign butterFly2_mux_5_nl = MUX_v_32_2_2(mult_8_res_lpi_2_dfm_mx0, mult_12_res_lpi_2_dfm_mx0,
      fsm_output[7]);
  assign nl_z_out_8 = butterFly2_mux_4_cse + butterFly2_mux_5_nl;
  assign z_out_8 = nl_z_out_8[31:0];
  assign butterFly2_mux_7_nl = MUX_v_32_2_2((~ mult_8_res_lpi_2_dfm_mx0), (~ mult_12_res_lpi_2_dfm_mx0),
      fsm_output[7]);
  assign nl_acc_9_nl = ({butterFly2_mux_4_cse , 1'b1}) + ({butterFly2_mux_7_nl ,
      1'b1});
  assign acc_9_nl = nl_acc_9_nl[32:0];
  assign z_out_9 = readslicef_33_32_1(acc_9_nl);
  assign butterFly2_1_mux_4_cse = MUX_v_32_2_2(reg_tmp_18_sva_6_cse, tmp_10_sva_6,
      fsm_output[7]);
  assign butterFly2_1_mux_5_nl = MUX_v_32_2_2(mult_9_res_lpi_2_dfm_mx0, mult_13_res_lpi_2_dfm_mx0,
      fsm_output[7]);
  assign nl_z_out_10 = butterFly2_1_mux_4_cse + butterFly2_1_mux_5_nl;
  assign z_out_10 = nl_z_out_10[31:0];
  assign butterFly2_1_mux_7_nl = MUX_v_32_2_2((~ mult_9_res_lpi_2_dfm_mx0), (~ mult_13_res_lpi_2_dfm_mx0),
      fsm_output[7]);
  assign nl_acc_11_nl = ({butterFly2_1_mux_4_cse , 1'b1}) + ({butterFly2_1_mux_7_nl
      , 1'b1});
  assign acc_11_nl = nl_acc_11_nl[32:0];
  assign z_out_11 = readslicef_33_32_1(acc_11_nl);
  assign modulo_sub_4_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_4_sva_1[30:0]),
      (modulo_sub_base_12_sva_1[30:0]), fsm_output[7]);
  assign nl_z_out_12 = ({1'b1 , modulo_sub_4_qif_mux_2_nl}) + p_sva;
  assign z_out_12 = nl_z_out_12[31:0];
  assign modulo_sub_5_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_5_sva_1[30:0]),
      (modulo_sub_base_13_sva_1[30:0]), fsm_output[7]);
  assign nl_z_out_14 = ({1'b1 , modulo_sub_5_qif_mux_2_nl}) + p_sva;
  assign z_out_14 = nl_z_out_14[31:0];
  assign modulo_sub_1_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_1_sva_1[30:0]),
      (modulo_sub_base_9_sva_1[30:0]), fsm_output[6]);
  assign nl_z_out_15 = ({1'b1 , modulo_sub_1_qif_mux_2_nl}) + p_sva;
  assign z_out_15 = nl_z_out_15[31:0];
  assign mult_3_if_mux1h_6_nl = MUX1HOT_v_32_4_2(mult_3_res_sva_1, mult_7_res_sva_1,
      mult_11_res_sva_1, mult_15_res_sva_1, {(fsm_output[2]) , (fsm_output[4]) ,
      (fsm_output[6]) , (fsm_output[7])});
  assign nl_acc_16_nl = ({mult_3_if_mux1h_6_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_16_nl = nl_acc_16_nl[32:0];
  assign z_out_16 = readslicef_33_32_1(acc_16_nl);
  assign mult_2_if_mux_2_nl = MUX_v_32_2_2(mult_2_res_sva_1, modulo_add_base_11_sva_1,
      fsm_output[6]);
  assign nl_acc_17_nl = ({mult_2_if_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_17_nl = nl_acc_17_nl[32:0];
  assign z_out_17 = readslicef_33_32_1(acc_17_nl);
  assign mult_1_if_mux1h_6_nl = MUX1HOT_v_32_4_2(mult_1_res_sva_1, mult_6_res_sva_1,
      mult_10_res_sva_1, mult_14_res_sva_1, {(fsm_output[2]) , (fsm_output[4]) ,
      (fsm_output[6]) , (fsm_output[7])});
  assign nl_acc_18_nl = ({mult_1_if_mux1h_6_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_18_nl = nl_acc_18_nl[32:0];
  assign z_out_18 = readslicef_33_32_1(acc_18_nl);
  assign mult_if_mux_2_nl = MUX_v_32_2_2(mult_res_sva_1, modulo_add_base_9_sva_1,
      fsm_output[6]);
  assign nl_acc_19_nl = ({mult_if_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_19_nl = nl_acc_19_nl[32:0];
  assign z_out_19 = readslicef_33_32_1(acc_19_nl);
  assign mult_9_if_mux_2_nl = MUX_v_32_2_2(mult_9_res_sva_1, modulo_add_base_2_sva_1,
      fsm_output[2]);
  assign nl_acc_20_nl = ({mult_9_if_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_20_nl = nl_acc_20_nl[32:0];
  assign z_out_20 = readslicef_33_32_1(acc_20_nl);
  assign mult_8_if_mux_2_nl = MUX_v_32_2_2(mult_8_res_sva_1, modulo_add_base_1_sva_1,
      fsm_output[2]);
  assign nl_acc_21_nl = ({mult_8_if_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_21_nl = nl_acc_21_nl[32:0];
  assign z_out_21 = readslicef_33_32_1(acc_21_nl);
  assign mult_5_if_mux_2_nl = MUX_v_32_2_2(mult_5_res_sva_1, modulo_add_base_12_sva_1,
      fsm_output[7]);
  assign nl_acc_22_nl = ({mult_5_if_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_22_nl = nl_acc_22_nl[32:0];
  assign z_out_22 = readslicef_33_32_1(acc_22_nl);
  assign mult_4_if_mux_2_nl = MUX_v_32_2_2(mult_4_res_sva_1, mult_13_res_sva_1, fsm_output[7]);
  assign nl_acc_23_nl = ({mult_4_if_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_23_nl = nl_acc_23_nl[32:0];
  assign z_out_23 = readslicef_33_32_1(acc_23_nl);
  assign modulo_add_10_qif_mux_2_nl = MUX_v_32_2_2(modulo_add_base_10_sva_1, modulo_add_base_3_sva_1,
      fsm_output[2]);
  assign nl_acc_24_nl = ({modulo_add_10_qif_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_24_nl = nl_acc_24_nl[32:0];
  assign z_out_24 = readslicef_33_32_1(acc_24_nl);
  assign mult_12_if_mux_2_nl = MUX_v_32_2_2(mult_12_res_sva_1, modulo_add_base_4_sva_1,
      fsm_output[4]);
  assign nl_acc_26_nl = ({mult_12_if_mux_2_nl , 1'b1}) + ({(~ p_sva) , 1'b1});
  assign acc_26_nl = nl_acc_26_nl[32:0];
  assign z_out_26 = readslicef_33_32_1(acc_26_nl);
  assign modulo_sub_7_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_7_sva_1[30:0]),
      (modulo_sub_base_15_sva_1[30:0]), fsm_output[7]);
  assign nl_z_out_27 = ({1'b1 , modulo_sub_7_qif_mux_2_nl}) + p_sva;
  assign z_out_27 = nl_z_out_27[31:0];
  assign modulo_sub_6_qif_mux_2_nl = MUX_v_31_2_2((modulo_sub_base_6_sva_1[30:0]),
      (modulo_sub_base_14_sva_1[30:0]), fsm_output[7]);
  assign nl_z_out_29 = ({1'b1 , modulo_sub_6_qif_mux_2_nl}) + p_sva;
  assign z_out_29 = nl_z_out_29[31:0];
  assign operator_32_false_mux1h_2_nl = MUX1HOT_v_13_4_2(INNER_LOOP1_r_15_2_sva_12_0_mx1,
      INNER_LOOP2_r_15_2_sva_12_0_mx1, INNER_LOOP3_r_15_2_sva_12_0_mx1, INNER_LOOP4_r_15_2_sva_12_0_mx1,
      {(fsm_output[2]) , (fsm_output[4]) , (fsm_output[6]) , (fsm_output[7])});
  assign nl_z_out_30 = conv_u2u_13_14(operator_32_false_mux1h_2_nl) + 14'b00000000000001;
  assign z_out_30 = nl_z_out_30[13:0];
  assign mult_3_if_mux1h_7_nl = MUX1HOT_v_32_4_2(mult_3_res_sva_2, mult_7_res_sva_2,
      mult_11_res_sva_2, mult_15_res_sva_2, {(fsm_output[2]) , (fsm_output[4]) ,
      (fsm_output[6]) , (fsm_output[7])});
  assign nl_acc_31_nl = ({1'b1 , mult_3_if_mux1h_7_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_31_nl = nl_acc_31_nl[33:0];
  assign z_out_31_32 = readslicef_34_1_33(acc_31_nl);
  assign mult_2_if_mux1h_4_nl = MUX1HOT_v_32_4_2(mult_2_res_sva_2, mult_6_res_sva_2,
      mult_10_res_sva_2, mult_14_res_sva_2, {(fsm_output[2]) , (fsm_output[4]) ,
      (fsm_output[6]) , (fsm_output[7])});
  assign nl_acc_32_nl = ({1'b1 , mult_2_if_mux1h_4_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_32_nl = nl_acc_32_nl[33:0];
  assign z_out_32_32 = readslicef_34_1_33(acc_32_nl);
  assign mult_1_if_mux1h_7_nl = MUX1HOT_v_32_4_2(mult_1_res_sva_2, mult_5_res_sva_2,
      mult_9_res_sva_2, mult_13_res_sva_2, {(fsm_output[2]) , (fsm_output[4]) , (fsm_output[6])
      , (fsm_output[7])});
  assign nl_acc_33_nl = ({1'b1 , mult_1_if_mux1h_7_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_33_nl = nl_acc_33_nl[33:0];
  assign z_out_33_32 = readslicef_34_1_33(acc_33_nl);
  assign mult_if_mux1h_4_nl = MUX1HOT_v_32_4_2(mult_res_sva_2, mult_4_res_sva_2,
      mult_8_res_sva_2, mult_12_res_sva_2, {(fsm_output[2]) , (fsm_output[4]) , (fsm_output[6])
      , (fsm_output[7])});
  assign nl_acc_34_nl = ({1'b1 , mult_if_mux1h_4_nl , 1'b1}) + conv_u2u_33_34({(~
      p_sva) , 1'b1});
  assign acc_34_nl = nl_acc_34_nl[33:0];
  assign z_out_34_32 = readslicef_34_1_33(acc_34_nl);
  assign modulo_add_4_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_4_sva_1), (~ modulo_add_base_12_sva_1),
      fsm_output[7]);
  assign nl_acc_35_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_4_mux_3_nl
      , 1'b1});
  assign acc_35_nl = nl_acc_35_nl[33:0];
  assign z_out_35_32 = readslicef_34_1_33(acc_35_nl);
  assign modulo_add_2_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_2_sva_1), (~ modulo_add_base_10_sva_1),
      fsm_output[6]);
  assign nl_acc_36_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_2_mux_3_nl
      , 1'b1});
  assign acc_36_nl = nl_acc_36_nl[33:0];
  assign z_out_36_32 = readslicef_34_1_33(acc_36_nl);
  assign modulo_add_7_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_7_sva_1), (~ modulo_add_base_15_sva_1),
      fsm_output[7]);
  assign nl_acc_37_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_7_mux_3_nl
      , 1'b1});
  assign acc_37_nl = nl_acc_37_nl[33:0];
  assign z_out_37_32 = readslicef_34_1_33(acc_37_nl);
  assign modulo_add_1_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_1_sva_1), (~ modulo_add_base_9_sva_1),
      fsm_output[6]);
  assign nl_acc_38_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_1_mux_3_nl
      , 1'b1});
  assign acc_38_nl = nl_acc_38_nl[33:0];
  assign z_out_38_32 = readslicef_34_1_33(acc_38_nl);
  assign modulo_add_3_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_3_sva_1), (~ modulo_add_base_11_sva_1),
      fsm_output[6]);
  assign nl_acc_39_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_3_mux_3_nl
      , 1'b1});
  assign acc_39_nl = nl_acc_39_nl[33:0];
  assign z_out_39_32 = readslicef_34_1_33(acc_39_nl);
  assign modulo_add_13_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_13_sva_1), (~ modulo_add_base_6_sva_1),
      fsm_output[4]);
  assign nl_acc_40_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_13_mux_3_nl
      , 1'b1});
  assign acc_40_nl = nl_acc_40_nl[33:0];
  assign z_out_40_32 = readslicef_34_1_33(acc_40_nl);
  assign modulo_add_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_sva_1), (~ modulo_add_base_8_sva_1),
      fsm_output[6]);
  assign nl_acc_41_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_mux_3_nl
      , 1'b1});
  assign acc_41_nl = nl_acc_41_nl[33:0];
  assign z_out_41_32 = readslicef_34_1_33(acc_41_nl);
  assign modulo_add_5_mux_3_nl = MUX_v_32_2_2((~ modulo_add_base_5_sva_1), (~ modulo_add_base_14_sva_1),
      fsm_output[7]);
  assign nl_acc_42_nl = ({1'b1 , p_sva , 1'b1}) + conv_u2u_33_34({modulo_add_5_mux_3_nl
      , 1'b1});
  assign acc_42_nl = nl_acc_42_nl[33:0];
  assign z_out_42_32 = readslicef_34_1_33(acc_42_nl);
  assign operator_32_false_mux_1_nl = MUX_v_3_2_2(c_3_1_sva, ({1'b0 , (operator_32_false_acc_psp_sva[2:1])}),
      fsm_output[5]);
  assign nl_z_out_44 = operator_32_false_mux_1_nl + 3'b111;
  assign z_out_44 = nl_z_out_44[2:0];

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


  function automatic [12:0] MUX1HOT_v_13_4_2;
    input [12:0] input_3;
    input [12:0] input_2;
    input [12:0] input_1;
    input [12:0] input_0;
    input [3:0] sel;
    reg [12:0] result;
  begin
    result = input_0 & {13{sel[0]}};
    result = result | ( input_1 & {13{sel[1]}});
    result = result | ( input_2 & {13{sel[2]}});
    result = result | ( input_3 & {13{sel[3]}});
    MUX1HOT_v_13_4_2 = result;
  end
  endfunction


  function automatic [30:0] MUX1HOT_v_31_3_2;
    input [30:0] input_2;
    input [30:0] input_1;
    input [30:0] input_0;
    input [2:0] sel;
    reg [30:0] result;
  begin
    result = input_0 & {31{sel[0]}};
    result = result | ( input_1 & {31{sel[1]}});
    result = result | ( input_2 & {31{sel[2]}});
    MUX1HOT_v_31_3_2 = result;
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


  function automatic [30:0] MUX_v_31_2_2;
    input [30:0] input_0;
    input [30:0] input_1;
    input [0:0] sel;
    reg [30:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_31_2_2 = result;
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


  function automatic [13:0] conv_u2u_13_14 ;
    input [12:0]  vector ;
  begin
    conv_u2u_13_14 = {1'b0, vector};
  end
  endfunction


  function automatic [33:0] conv_u2u_33_34 ;
    input [32:0]  vector ;
  begin
    conv_u2u_33_34 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaseNTT
// ------------------------------------------------------------------


module peaseNTT (
  clk, rst, xt_rsc_0_0_adra, xt_rsc_0_0_da, xt_rsc_0_0_wea, xt_rsc_0_0_qa, xt_rsc_0_0_adrb,
      xt_rsc_0_0_db, xt_rsc_0_0_web, xt_rsc_0_0_qb, xt_rsc_triosy_0_0_lz, xt_rsc_0_1_adra,
      xt_rsc_0_1_da, xt_rsc_0_1_wea, xt_rsc_0_1_qa, xt_rsc_0_1_adrb, xt_rsc_0_1_db,
      xt_rsc_0_1_web, xt_rsc_0_1_qb, xt_rsc_triosy_0_1_lz, xt_rsc_0_2_adra, xt_rsc_0_2_da,
      xt_rsc_0_2_wea, xt_rsc_0_2_qa, xt_rsc_0_2_adrb, xt_rsc_0_2_db, xt_rsc_0_2_web,
      xt_rsc_0_2_qb, xt_rsc_triosy_0_2_lz, xt_rsc_0_3_adra, xt_rsc_0_3_da, xt_rsc_0_3_wea,
      xt_rsc_0_3_qa, xt_rsc_0_3_adrb, xt_rsc_0_3_db, xt_rsc_0_3_web, xt_rsc_0_3_qb,
      xt_rsc_triosy_0_3_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz,
      twiddle_rsc_0_0_radr, twiddle_rsc_0_0_q, twiddle_rsc_triosy_0_0_lz, twiddle_rsc_0_1_radr,
      twiddle_rsc_0_1_q, twiddle_rsc_triosy_0_1_lz, twiddle_rsc_0_2_radr, twiddle_rsc_0_2_q,
      twiddle_rsc_triosy_0_2_lz, twiddle_rsc_0_3_radr, twiddle_rsc_0_3_q, twiddle_rsc_triosy_0_3_lz,
      twiddle_h_rsc_0_0_radr, twiddle_h_rsc_0_0_q, twiddle_h_rsc_triosy_0_0_lz, twiddle_h_rsc_0_1_radr,
      twiddle_h_rsc_0_1_q, twiddle_h_rsc_triosy_0_1_lz, twiddle_h_rsc_0_2_radr, twiddle_h_rsc_0_2_q,
      twiddle_h_rsc_triosy_0_2_lz, twiddle_h_rsc_0_3_radr, twiddle_h_rsc_0_3_q, twiddle_h_rsc_triosy_0_3_lz
);
  input clk;
  input rst;
  output [13:0] xt_rsc_0_0_adra;
  output [31:0] xt_rsc_0_0_da;
  output xt_rsc_0_0_wea;
  input [31:0] xt_rsc_0_0_qa;
  output [13:0] xt_rsc_0_0_adrb;
  output [31:0] xt_rsc_0_0_db;
  output xt_rsc_0_0_web;
  input [31:0] xt_rsc_0_0_qb;
  output xt_rsc_triosy_0_0_lz;
  output [13:0] xt_rsc_0_1_adra;
  output [31:0] xt_rsc_0_1_da;
  output xt_rsc_0_1_wea;
  input [31:0] xt_rsc_0_1_qa;
  output [13:0] xt_rsc_0_1_adrb;
  output [31:0] xt_rsc_0_1_db;
  output xt_rsc_0_1_web;
  input [31:0] xt_rsc_0_1_qb;
  output xt_rsc_triosy_0_1_lz;
  output [13:0] xt_rsc_0_2_adra;
  output [31:0] xt_rsc_0_2_da;
  output xt_rsc_0_2_wea;
  input [31:0] xt_rsc_0_2_qa;
  output [13:0] xt_rsc_0_2_adrb;
  output [31:0] xt_rsc_0_2_db;
  output xt_rsc_0_2_web;
  input [31:0] xt_rsc_0_2_qb;
  output xt_rsc_triosy_0_2_lz;
  output [13:0] xt_rsc_0_3_adra;
  output [31:0] xt_rsc_0_3_da;
  output xt_rsc_0_3_wea;
  input [31:0] xt_rsc_0_3_qa;
  output [13:0] xt_rsc_0_3_adrb;
  output [31:0] xt_rsc_0_3_db;
  output xt_rsc_0_3_web;
  input [31:0] xt_rsc_0_3_qb;
  output xt_rsc_triosy_0_3_lz;
  input [31:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [31:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [13:0] twiddle_rsc_0_0_radr;
  input [31:0] twiddle_rsc_0_0_q;
  output twiddle_rsc_triosy_0_0_lz;
  output [13:0] twiddle_rsc_0_1_radr;
  input [31:0] twiddle_rsc_0_1_q;
  output twiddle_rsc_triosy_0_1_lz;
  output [13:0] twiddle_rsc_0_2_radr;
  input [31:0] twiddle_rsc_0_2_q;
  output twiddle_rsc_triosy_0_2_lz;
  output [13:0] twiddle_rsc_0_3_radr;
  input [31:0] twiddle_rsc_0_3_q;
  output twiddle_rsc_triosy_0_3_lz;
  output [13:0] twiddle_h_rsc_0_0_radr;
  input [31:0] twiddle_h_rsc_0_0_q;
  output twiddle_h_rsc_triosy_0_0_lz;
  output [13:0] twiddle_h_rsc_0_1_radr;
  input [31:0] twiddle_h_rsc_0_1_q;
  output twiddle_h_rsc_triosy_0_1_lz;
  output [13:0] twiddle_h_rsc_0_2_radr;
  input [31:0] twiddle_h_rsc_0_2_q;
  output twiddle_h_rsc_triosy_0_2_lz;
  output [13:0] twiddle_h_rsc_0_3_radr;
  input [31:0] twiddle_h_rsc_0_3_q;
  output twiddle_h_rsc_triosy_0_3_lz;


  // Interconnect Declarations
  wire [27:0] yt_rsc_0_0_i_adra_d;
  wire yt_rsc_0_0_i_clka_en_d;
  wire [63:0] yt_rsc_0_0_i_da_d;
  wire [63:0] yt_rsc_0_0_i_qa_d;
  wire [1:0] yt_rsc_0_0_i_wea_d;
  wire [1:0] yt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] yt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] yt_rsc_0_1_i_adra_d;
  wire [63:0] yt_rsc_0_1_i_da_d;
  wire [63:0] yt_rsc_0_1_i_qa_d;
  wire [1:0] yt_rsc_0_1_i_wea_d;
  wire [1:0] yt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] yt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] yt_rsc_0_2_i_adra_d;
  wire [63:0] yt_rsc_0_2_i_da_d;
  wire [63:0] yt_rsc_0_2_i_qa_d;
  wire [1:0] yt_rsc_0_2_i_wea_d;
  wire [1:0] yt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] yt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] yt_rsc_0_3_i_adra_d;
  wire [63:0] yt_rsc_0_3_i_da_d;
  wire [63:0] yt_rsc_0_3_i_qa_d;
  wire [1:0] yt_rsc_0_3_i_wea_d;
  wire [1:0] yt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] yt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] xt_rsc_0_0_i_adra_d;
  wire [63:0] xt_rsc_0_0_i_da_d;
  wire [63:0] xt_rsc_0_0_i_qa_d;
  wire [1:0] xt_rsc_0_0_i_wea_d;
  wire [1:0] xt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] xt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] xt_rsc_0_1_i_adra_d;
  wire [63:0] xt_rsc_0_1_i_da_d;
  wire [63:0] xt_rsc_0_1_i_qa_d;
  wire [1:0] xt_rsc_0_1_i_wea_d;
  wire [1:0] xt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] xt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] xt_rsc_0_2_i_adra_d;
  wire [63:0] xt_rsc_0_2_i_da_d;
  wire [63:0] xt_rsc_0_2_i_qa_d;
  wire [1:0] xt_rsc_0_2_i_wea_d;
  wire [1:0] xt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] xt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [27:0] xt_rsc_0_3_i_adra_d;
  wire [63:0] xt_rsc_0_3_i_da_d;
  wire [63:0] xt_rsc_0_3_i_qa_d;
  wire [1:0] xt_rsc_0_3_i_wea_d;
  wire [1:0] xt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [1:0] xt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d;
  wire [31:0] twiddle_rsc_0_0_i_q_d;
  wire [13:0] twiddle_rsc_0_0_i_radr_d;
  wire [31:0] twiddle_rsc_0_1_i_q_d;
  wire [13:0] twiddle_rsc_0_1_i_radr_d;
  wire [31:0] twiddle_rsc_0_2_i_q_d;
  wire [13:0] twiddle_rsc_0_2_i_radr_d;
  wire [31:0] twiddle_rsc_0_3_i_q_d;
  wire [13:0] twiddle_rsc_0_3_i_radr_d;
  wire [31:0] twiddle_h_rsc_0_0_i_q_d;
  wire [13:0] twiddle_h_rsc_0_0_i_radr_d;
  wire [31:0] twiddle_h_rsc_0_1_i_q_d;
  wire [13:0] twiddle_h_rsc_0_1_i_radr_d;
  wire [31:0] twiddle_h_rsc_0_2_i_q_d;
  wire [13:0] twiddle_h_rsc_0_2_i_radr_d;
  wire [31:0] twiddle_h_rsc_0_3_i_q_d;
  wire [13:0] twiddle_h_rsc_0_3_i_radr_d;
  wire [31:0] mult_z_mul_cmp_a;
  wire [31:0] mult_z_mul_cmp_b;
  wire [31:0] mult_z_mul_cmp_1_a;
  wire [31:0] mult_z_mul_cmp_1_b;
  wire [31:0] mult_z_mul_cmp_2_a;
  wire [31:0] mult_z_mul_cmp_2_b;
  wire [31:0] mult_z_mul_cmp_3_a;
  wire [31:0] mult_z_mul_cmp_4_a;
  wire [31:0] mult_z_mul_cmp_4_b;
  wire [31:0] mult_z_mul_cmp_5_a;
  wire [31:0] mult_z_mul_cmp_6_a;
  wire [31:0] mult_z_mul_cmp_6_b;
  wire [31:0] mult_z_mul_cmp_7_a;
  wire yt_rsc_0_0_clkb_en;
  wire yt_rsc_0_0_clka_en;
  wire [31:0] yt_rsc_0_0_qb;
  wire yt_rsc_0_0_web;
  wire [31:0] yt_rsc_0_0_db;
  wire [13:0] yt_rsc_0_0_adrb;
  wire [31:0] yt_rsc_0_0_qa;
  wire yt_rsc_0_0_wea;
  wire [31:0] yt_rsc_0_0_da;
  wire [13:0] yt_rsc_0_0_adra;
  wire yt_rsc_0_1_clkb_en;
  wire yt_rsc_0_1_clka_en;
  wire [31:0] yt_rsc_0_1_qb;
  wire yt_rsc_0_1_web;
  wire [31:0] yt_rsc_0_1_db;
  wire [13:0] yt_rsc_0_1_adrb;
  wire [31:0] yt_rsc_0_1_qa;
  wire yt_rsc_0_1_wea;
  wire [31:0] yt_rsc_0_1_da;
  wire [13:0] yt_rsc_0_1_adra;
  wire yt_rsc_0_2_clkb_en;
  wire yt_rsc_0_2_clka_en;
  wire [31:0] yt_rsc_0_2_qb;
  wire yt_rsc_0_2_web;
  wire [31:0] yt_rsc_0_2_db;
  wire [13:0] yt_rsc_0_2_adrb;
  wire [31:0] yt_rsc_0_2_qa;
  wire yt_rsc_0_2_wea;
  wire [31:0] yt_rsc_0_2_da;
  wire [13:0] yt_rsc_0_2_adra;
  wire yt_rsc_0_3_clkb_en;
  wire yt_rsc_0_3_clka_en;
  wire [31:0] yt_rsc_0_3_qb;
  wire yt_rsc_0_3_web;
  wire [31:0] yt_rsc_0_3_db;
  wire [13:0] yt_rsc_0_3_adrb;
  wire [31:0] yt_rsc_0_3_qa;
  wire yt_rsc_0_3_wea;
  wire [31:0] yt_rsc_0_3_da;
  wire [13:0] yt_rsc_0_3_adra;
  wire twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_iff;
  wire twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_iff;
  wire twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_iff;


  // Interconnect Declarations for Component Instantiations 
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_z = conv_u2u_64_32(mult_z_mul_cmp_a
      * mult_z_mul_cmp_b);
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_1_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_1_z = conv_u2u_64_32(mult_z_mul_cmp_1_a
      * mult_z_mul_cmp_1_b);
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_2_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_2_z = conv_u2u_64_32(mult_z_mul_cmp_2_a
      * mult_z_mul_cmp_2_b);
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_3_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_3_z = conv_u2u_64_32(mult_z_mul_cmp_3_a
      * mult_z_mul_cmp_1_b);
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_4_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_4_z = conv_u2u_64_32(mult_z_mul_cmp_4_a
      * mult_z_mul_cmp_4_b);
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_5_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_5_z = conv_u2u_64_32(mult_z_mul_cmp_5_a
      * mult_z_mul_cmp_1_b);
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_6_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_6_z = conv_u2u_64_32(mult_z_mul_cmp_6_a
      * mult_z_mul_cmp_6_b);
  wire [31:0] nl_peaseNTT_core_inst_mult_z_mul_cmp_7_z;
  assign nl_peaseNTT_core_inst_mult_z_mul_cmp_7_z = conv_u2u_64_32(mult_z_mul_cmp_7_a
      * mult_z_mul_cmp_1_b);
  BLOCK_DPRAM_RBW_DUAL #(.addr_width(32'sd14),
  .data_width(32'sd32),
  .depth(32'sd16384),
  .latency(32'sd1)) yt_rsc_0_0_comp (
      .adra(yt_rsc_0_0_adra),
      .adrb(yt_rsc_0_0_adrb),
      .clka(clk),
      .clka_en(yt_rsc_0_0_clkb_en),
      .clkb(clk),
      .clkb_en(yt_rsc_0_0_clkb_en),
      .da(yt_rsc_0_0_da),
      .db(yt_rsc_0_0_db),
      .qa(yt_rsc_0_0_qa),
      .qb(yt_rsc_0_0_qb),
      .wea(yt_rsc_0_0_wea),
      .web(yt_rsc_0_0_web)
    );
  BLOCK_DPRAM_RBW_DUAL #(.addr_width(32'sd14),
  .data_width(32'sd32),
  .depth(32'sd16384),
  .latency(32'sd1)) yt_rsc_0_1_comp (
      .adra(yt_rsc_0_1_adra),
      .adrb(yt_rsc_0_1_adrb),
      .clka(clk),
      .clka_en(yt_rsc_0_1_clkb_en),
      .clkb(clk),
      .clkb_en(yt_rsc_0_1_clkb_en),
      .da(yt_rsc_0_1_da),
      .db(yt_rsc_0_1_db),
      .qa(yt_rsc_0_1_qa),
      .qb(yt_rsc_0_1_qb),
      .wea(yt_rsc_0_1_wea),
      .web(yt_rsc_0_1_web)
    );
  BLOCK_DPRAM_RBW_DUAL #(.addr_width(32'sd14),
  .data_width(32'sd32),
  .depth(32'sd16384),
  .latency(32'sd1)) yt_rsc_0_2_comp (
      .adra(yt_rsc_0_2_adra),
      .adrb(yt_rsc_0_2_adrb),
      .clka(clk),
      .clka_en(yt_rsc_0_2_clkb_en),
      .clkb(clk),
      .clkb_en(yt_rsc_0_2_clkb_en),
      .da(yt_rsc_0_2_da),
      .db(yt_rsc_0_2_db),
      .qa(yt_rsc_0_2_qa),
      .qb(yt_rsc_0_2_qb),
      .wea(yt_rsc_0_2_wea),
      .web(yt_rsc_0_2_web)
    );
  BLOCK_DPRAM_RBW_DUAL #(.addr_width(32'sd14),
  .data_width(32'sd32),
  .depth(32'sd16384),
  .latency(32'sd1)) yt_rsc_0_3_comp (
      .adra(yt_rsc_0_3_adra),
      .adrb(yt_rsc_0_3_adrb),
      .clka(clk),
      .clka_en(yt_rsc_0_3_clkb_en),
      .clkb(clk),
      .clkb_en(yt_rsc_0_3_clkb_en),
      .da(yt_rsc_0_3_da),
      .db(yt_rsc_0_3_db),
      .qa(yt_rsc_0_3_qa),
      .qb(yt_rsc_0_3_qb),
      .wea(yt_rsc_0_3_wea),
      .web(yt_rsc_0_3_web)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_7_14_32_16384_16384_32_1_gen
      yt_rsc_0_0_i (
      .clkb_en(yt_rsc_0_0_clkb_en),
      .clka_en(yt_rsc_0_0_clka_en),
      .qb(yt_rsc_0_0_qb),
      .web(yt_rsc_0_0_web),
      .db(yt_rsc_0_0_db),
      .adrb(yt_rsc_0_0_adrb),
      .qa(yt_rsc_0_0_qa),
      .wea(yt_rsc_0_0_wea),
      .da(yt_rsc_0_0_da),
      .adra(yt_rsc_0_0_adra),
      .adra_d(yt_rsc_0_0_i_adra_d),
      .clka(clk),
      .clka_en_d(yt_rsc_0_0_i_clka_en_d),
      .clkb_en_d(yt_rsc_0_0_i_clka_en_d),
      .da_d(yt_rsc_0_0_i_da_d),
      .qa_d(yt_rsc_0_0_i_qa_d),
      .wea_d(yt_rsc_0_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_8_14_32_16384_16384_32_1_gen
      yt_rsc_0_1_i (
      .clkb_en(yt_rsc_0_1_clkb_en),
      .clka_en(yt_rsc_0_1_clka_en),
      .qb(yt_rsc_0_1_qb),
      .web(yt_rsc_0_1_web),
      .db(yt_rsc_0_1_db),
      .adrb(yt_rsc_0_1_adrb),
      .qa(yt_rsc_0_1_qa),
      .wea(yt_rsc_0_1_wea),
      .da(yt_rsc_0_1_da),
      .adra(yt_rsc_0_1_adra),
      .adra_d(yt_rsc_0_1_i_adra_d),
      .clka(clk),
      .clka_en_d(yt_rsc_0_0_i_clka_en_d),
      .clkb_en_d(yt_rsc_0_0_i_clka_en_d),
      .da_d(yt_rsc_0_1_i_da_d),
      .qa_d(yt_rsc_0_1_i_qa_d),
      .wea_d(yt_rsc_0_1_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_9_14_32_16384_16384_32_1_gen
      yt_rsc_0_2_i (
      .clkb_en(yt_rsc_0_2_clkb_en),
      .clka_en(yt_rsc_0_2_clka_en),
      .qb(yt_rsc_0_2_qb),
      .web(yt_rsc_0_2_web),
      .db(yt_rsc_0_2_db),
      .adrb(yt_rsc_0_2_adrb),
      .qa(yt_rsc_0_2_qa),
      .wea(yt_rsc_0_2_wea),
      .da(yt_rsc_0_2_da),
      .adra(yt_rsc_0_2_adra),
      .adra_d(yt_rsc_0_2_i_adra_d),
      .clka(clk),
      .clka_en_d(yt_rsc_0_0_i_clka_en_d),
      .clkb_en_d(yt_rsc_0_0_i_clka_en_d),
      .da_d(yt_rsc_0_2_i_da_d),
      .qa_d(yt_rsc_0_2_i_qa_d),
      .wea_d(yt_rsc_0_2_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_en_10_14_32_16384_16384_32_1_gen
      yt_rsc_0_3_i (
      .clkb_en(yt_rsc_0_3_clkb_en),
      .clka_en(yt_rsc_0_3_clka_en),
      .qb(yt_rsc_0_3_qb),
      .web(yt_rsc_0_3_web),
      .db(yt_rsc_0_3_db),
      .adrb(yt_rsc_0_3_adrb),
      .qa(yt_rsc_0_3_qa),
      .wea(yt_rsc_0_3_wea),
      .da(yt_rsc_0_3_da),
      .adra(yt_rsc_0_3_adra),
      .adra_d(yt_rsc_0_3_i_adra_d),
      .clka(clk),
      .clka_en_d(yt_rsc_0_0_i_clka_en_d),
      .clkb_en_d(yt_rsc_0_0_i_clka_en_d),
      .da_d(yt_rsc_0_3_i_da_d),
      .qa_d(yt_rsc_0_3_i_qa_d),
      .wea_d(yt_rsc_0_3_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_11_14_32_16384_16384_32_1_gen
      xt_rsc_0_0_i (
      .qb(xt_rsc_0_0_qb),
      .web(xt_rsc_0_0_web),
      .db(xt_rsc_0_0_db),
      .adrb(xt_rsc_0_0_adrb),
      .qa(xt_rsc_0_0_qa),
      .wea(xt_rsc_0_0_wea),
      .da(xt_rsc_0_0_da),
      .adra(xt_rsc_0_0_adra),
      .adra_d(xt_rsc_0_0_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(xt_rsc_0_0_i_da_d),
      .qa_d(xt_rsc_0_0_i_qa_d),
      .wea_d(xt_rsc_0_0_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_12_14_32_16384_16384_32_1_gen
      xt_rsc_0_1_i (
      .qb(xt_rsc_0_1_qb),
      .web(xt_rsc_0_1_web),
      .db(xt_rsc_0_1_db),
      .adrb(xt_rsc_0_1_adrb),
      .qa(xt_rsc_0_1_qa),
      .wea(xt_rsc_0_1_wea),
      .da(xt_rsc_0_1_da),
      .adra(xt_rsc_0_1_adra),
      .adra_d(xt_rsc_0_1_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(xt_rsc_0_1_i_da_d),
      .qa_d(xt_rsc_0_1_i_qa_d),
      .wea_d(xt_rsc_0_1_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_13_14_32_16384_16384_32_1_gen
      xt_rsc_0_2_i (
      .qb(xt_rsc_0_2_qb),
      .web(xt_rsc_0_2_web),
      .db(xt_rsc_0_2_db),
      .adrb(xt_rsc_0_2_adrb),
      .qa(xt_rsc_0_2_qa),
      .wea(xt_rsc_0_2_wea),
      .da(xt_rsc_0_2_da),
      .adra(xt_rsc_0_2_adra),
      .adra_d(xt_rsc_0_2_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(xt_rsc_0_2_i_da_d),
      .qa_d(xt_rsc_0_2_i_qa_d),
      .wea_d(xt_rsc_0_2_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_14_14_32_16384_16384_32_1_gen
      xt_rsc_0_3_i (
      .qb(xt_rsc_0_3_qb),
      .web(xt_rsc_0_3_web),
      .db(xt_rsc_0_3_db),
      .adrb(xt_rsc_0_3_adrb),
      .qa(xt_rsc_0_3_qa),
      .wea(xt_rsc_0_3_wea),
      .da(xt_rsc_0_3_da),
      .adra(xt_rsc_0_3_adra),
      .adra_d(xt_rsc_0_3_i_adra_d),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(xt_rsc_0_3_i_da_d),
      .qa_d(xt_rsc_0_3_i_qa_d),
      .wea_d(xt_rsc_0_3_i_wea_d),
      .rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_15_14_32_16384_16384_32_1_gen twiddle_rsc_0_0_i
      (
      .q(twiddle_rsc_0_0_q),
      .radr(twiddle_rsc_0_0_radr),
      .q_d(twiddle_rsc_0_0_i_q_d),
      .radr_d(twiddle_rsc_0_0_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_16_14_32_16384_16384_32_1_gen twiddle_rsc_0_1_i
      (
      .q(twiddle_rsc_0_1_q),
      .radr(twiddle_rsc_0_1_radr),
      .q_d(twiddle_rsc_0_1_i_q_d),
      .radr_d(twiddle_rsc_0_1_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_17_14_32_16384_16384_32_1_gen twiddle_rsc_0_2_i
      (
      .q(twiddle_rsc_0_2_q),
      .radr(twiddle_rsc_0_2_radr),
      .q_d(twiddle_rsc_0_2_i_q_d),
      .radr_d(twiddle_rsc_0_2_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_18_14_32_16384_16384_32_1_gen twiddle_rsc_0_3_i
      (
      .q(twiddle_rsc_0_3_q),
      .radr(twiddle_rsc_0_3_radr),
      .q_d(twiddle_rsc_0_3_i_q_d),
      .radr_d(twiddle_rsc_0_3_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_19_14_32_16384_16384_32_1_gen twiddle_h_rsc_0_0_i
      (
      .q(twiddle_h_rsc_0_0_q),
      .radr(twiddle_h_rsc_0_0_radr),
      .q_d(twiddle_h_rsc_0_0_i_q_d),
      .radr_d(twiddle_h_rsc_0_0_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_20_14_32_16384_16384_32_1_gen twiddle_h_rsc_0_1_i
      (
      .q(twiddle_h_rsc_0_1_q),
      .radr(twiddle_h_rsc_0_1_radr),
      .q_d(twiddle_h_rsc_0_1_i_q_d),
      .radr_d(twiddle_h_rsc_0_1_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_21_14_32_16384_16384_32_1_gen twiddle_h_rsc_0_2_i
      (
      .q(twiddle_h_rsc_0_2_q),
      .radr(twiddle_h_rsc_0_2_radr),
      .q_d(twiddle_h_rsc_0_2_i_q_d),
      .radr_d(twiddle_h_rsc_0_2_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_22_14_32_16384_16384_32_1_gen twiddle_h_rsc_0_3_i
      (
      .q(twiddle_h_rsc_0_3_q),
      .radr(twiddle_h_rsc_0_3_radr),
      .q_d(twiddle_h_rsc_0_3_i_q_d),
      .radr_d(twiddle_h_rsc_0_3_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );
  peaseNTT_core peaseNTT_core_inst (
      .clk(clk),
      .rst(rst),
      .xt_rsc_triosy_0_0_lz(xt_rsc_triosy_0_0_lz),
      .xt_rsc_triosy_0_1_lz(xt_rsc_triosy_0_1_lz),
      .xt_rsc_triosy_0_2_lz(xt_rsc_triosy_0_2_lz),
      .xt_rsc_triosy_0_3_lz(xt_rsc_triosy_0_3_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_0_0_lz(twiddle_rsc_triosy_0_0_lz),
      .twiddle_rsc_triosy_0_1_lz(twiddle_rsc_triosy_0_1_lz),
      .twiddle_rsc_triosy_0_2_lz(twiddle_rsc_triosy_0_2_lz),
      .twiddle_rsc_triosy_0_3_lz(twiddle_rsc_triosy_0_3_lz),
      .twiddle_h_rsc_triosy_0_0_lz(twiddle_h_rsc_triosy_0_0_lz),
      .twiddle_h_rsc_triosy_0_1_lz(twiddle_h_rsc_triosy_0_1_lz),
      .twiddle_h_rsc_triosy_0_2_lz(twiddle_h_rsc_triosy_0_2_lz),
      .twiddle_h_rsc_triosy_0_3_lz(twiddle_h_rsc_triosy_0_3_lz),
      .yt_rsc_0_0_i_adra_d(yt_rsc_0_0_i_adra_d),
      .yt_rsc_0_0_i_clka_en_d(yt_rsc_0_0_i_clka_en_d),
      .yt_rsc_0_0_i_da_d(yt_rsc_0_0_i_da_d),
      .yt_rsc_0_0_i_qa_d(yt_rsc_0_0_i_qa_d),
      .yt_rsc_0_0_i_wea_d(yt_rsc_0_0_i_wea_d),
      .yt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .yt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .yt_rsc_0_1_i_adra_d(yt_rsc_0_1_i_adra_d),
      .yt_rsc_0_1_i_da_d(yt_rsc_0_1_i_da_d),
      .yt_rsc_0_1_i_qa_d(yt_rsc_0_1_i_qa_d),
      .yt_rsc_0_1_i_wea_d(yt_rsc_0_1_i_wea_d),
      .yt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .yt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .yt_rsc_0_2_i_adra_d(yt_rsc_0_2_i_adra_d),
      .yt_rsc_0_2_i_da_d(yt_rsc_0_2_i_da_d),
      .yt_rsc_0_2_i_qa_d(yt_rsc_0_2_i_qa_d),
      .yt_rsc_0_2_i_wea_d(yt_rsc_0_2_i_wea_d),
      .yt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .yt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .yt_rsc_0_3_i_adra_d(yt_rsc_0_3_i_adra_d),
      .yt_rsc_0_3_i_da_d(yt_rsc_0_3_i_da_d),
      .yt_rsc_0_3_i_qa_d(yt_rsc_0_3_i_qa_d),
      .yt_rsc_0_3_i_wea_d(yt_rsc_0_3_i_wea_d),
      .yt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d(yt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .yt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d(yt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .xt_rsc_0_0_i_adra_d(xt_rsc_0_0_i_adra_d),
      .xt_rsc_0_0_i_da_d(xt_rsc_0_0_i_da_d),
      .xt_rsc_0_0_i_qa_d(xt_rsc_0_0_i_qa_d),
      .xt_rsc_0_0_i_wea_d(xt_rsc_0_0_i_wea_d),
      .xt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .xt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_0_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .xt_rsc_0_1_i_adra_d(xt_rsc_0_1_i_adra_d),
      .xt_rsc_0_1_i_da_d(xt_rsc_0_1_i_da_d),
      .xt_rsc_0_1_i_qa_d(xt_rsc_0_1_i_qa_d),
      .xt_rsc_0_1_i_wea_d(xt_rsc_0_1_i_wea_d),
      .xt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .xt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_1_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .xt_rsc_0_2_i_adra_d(xt_rsc_0_2_i_adra_d),
      .xt_rsc_0_2_i_da_d(xt_rsc_0_2_i_da_d),
      .xt_rsc_0_2_i_qa_d(xt_rsc_0_2_i_qa_d),
      .xt_rsc_0_2_i_wea_d(xt_rsc_0_2_i_wea_d),
      .xt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_2_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .xt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_2_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .xt_rsc_0_3_i_adra_d(xt_rsc_0_3_i_adra_d),
      .xt_rsc_0_3_i_da_d(xt_rsc_0_3_i_da_d),
      .xt_rsc_0_3_i_qa_d(xt_rsc_0_3_i_qa_d),
      .xt_rsc_0_3_i_wea_d(xt_rsc_0_3_i_wea_d),
      .xt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d(xt_rsc_0_3_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .xt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d(xt_rsc_0_3_i_rwA_rw_ram_ir_internal_WMASK_B_d),
      .twiddle_rsc_0_0_i_q_d(twiddle_rsc_0_0_i_q_d),
      .twiddle_rsc_0_0_i_radr_d(twiddle_rsc_0_0_i_radr_d),
      .twiddle_rsc_0_1_i_q_d(twiddle_rsc_0_1_i_q_d),
      .twiddle_rsc_0_1_i_radr_d(twiddle_rsc_0_1_i_radr_d),
      .twiddle_rsc_0_2_i_q_d(twiddle_rsc_0_2_i_q_d),
      .twiddle_rsc_0_2_i_radr_d(twiddle_rsc_0_2_i_radr_d),
      .twiddle_rsc_0_3_i_q_d(twiddle_rsc_0_3_i_q_d),
      .twiddle_rsc_0_3_i_radr_d(twiddle_rsc_0_3_i_radr_d),
      .twiddle_h_rsc_0_0_i_q_d(twiddle_h_rsc_0_0_i_q_d),
      .twiddle_h_rsc_0_0_i_radr_d(twiddle_h_rsc_0_0_i_radr_d),
      .twiddle_h_rsc_0_1_i_q_d(twiddle_h_rsc_0_1_i_q_d),
      .twiddle_h_rsc_0_1_i_radr_d(twiddle_h_rsc_0_1_i_radr_d),
      .twiddle_h_rsc_0_2_i_q_d(twiddle_h_rsc_0_2_i_q_d),
      .twiddle_h_rsc_0_2_i_radr_d(twiddle_h_rsc_0_2_i_radr_d),
      .twiddle_h_rsc_0_3_i_q_d(twiddle_h_rsc_0_3_i_q_d),
      .twiddle_h_rsc_0_3_i_radr_d(twiddle_h_rsc_0_3_i_radr_d),
      .mult_z_mul_cmp_a(mult_z_mul_cmp_a),
      .mult_z_mul_cmp_b(mult_z_mul_cmp_b),
      .mult_z_mul_cmp_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_z[31:0]),
      .mult_z_mul_cmp_1_a(mult_z_mul_cmp_1_a),
      .mult_z_mul_cmp_1_b(mult_z_mul_cmp_1_b),
      .mult_z_mul_cmp_1_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_1_z[31:0]),
      .mult_z_mul_cmp_2_a(mult_z_mul_cmp_2_a),
      .mult_z_mul_cmp_2_b(mult_z_mul_cmp_2_b),
      .mult_z_mul_cmp_2_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_2_z[31:0]),
      .mult_z_mul_cmp_3_a(mult_z_mul_cmp_3_a),
      .mult_z_mul_cmp_3_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_3_z[31:0]),
      .mult_z_mul_cmp_4_a(mult_z_mul_cmp_4_a),
      .mult_z_mul_cmp_4_b(mult_z_mul_cmp_4_b),
      .mult_z_mul_cmp_4_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_4_z[31:0]),
      .mult_z_mul_cmp_5_a(mult_z_mul_cmp_5_a),
      .mult_z_mul_cmp_5_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_5_z[31:0]),
      .mult_z_mul_cmp_6_a(mult_z_mul_cmp_6_a),
      .mult_z_mul_cmp_6_b(mult_z_mul_cmp_6_b),
      .mult_z_mul_cmp_6_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_6_z[31:0]),
      .mult_z_mul_cmp_7_a(mult_z_mul_cmp_7_a),
      .mult_z_mul_cmp_7_z(nl_peaseNTT_core_inst_mult_z_mul_cmp_7_z[31:0]),
      .twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_pff(twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d_iff),
      .twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_pff(twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d_iff),
      .twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_pff(twiddle_rsc_0_2_i_readA_r_ram_ir_internal_RMASK_B_d_iff)
    );

  function automatic [31:0] conv_u2u_64_32 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_32 = vector[31:0];
  end
  endfunction

endmodule



