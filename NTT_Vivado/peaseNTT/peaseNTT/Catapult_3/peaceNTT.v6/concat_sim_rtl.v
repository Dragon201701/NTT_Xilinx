
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


//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_rem_beh.v 
module mgc_rem(a,b,z);
   parameter width_a = 8;
   parameter width_b = 8;
   parameter signd = 1;
   input [width_a-1:0] a;
   input [width_b-1:0] b; 
   output [width_b-1:0] z;  
   reg  [width_b-1:0] z;

   always@(a or b)
     begin
	if(signd)
	  rem_s(a,b,z);
	else
          rem_u(a,b,z);
     end


//-----------------------------------------------------------------
//     -- Vectorized Overloaded Arithmetic Operators
//-----------------------------------------------------------------
   
   function [width_a-1:0] fabs_l; 
      input [width_a-1:0] arg1;
      begin
         case(arg1[width_a-1])
            1'b1:
               fabs_l = {(width_a){1'b0}} - arg1;
            default: // was: 1'b0:
               fabs_l = arg1;
         endcase
      end
   endfunction
   
   function [width_b-1:0] fabs_r; 
      input [width_b-1:0] arg1;
      begin
         case (arg1[width_b-1])
            1'b1:
               fabs_r =  {(width_b){1'b0}} - arg1;
            default: // was: 1'b0:
               fabs_r = arg1;
         endcase
      end
   endfunction

   function [width_b:0] minus;
     input [width_b:0] in1;
     input [width_b:0] in2;
     reg [width_b+1:0] tmp;
     begin
       tmp = in1 - in2;
       minus = tmp[width_b:0];
     end
   endfunction

   
   task divmod;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      output [width_b-1:0] rmod;
      
      parameter llen = width_a;
      parameter rlen = width_b;
      reg [(llen+rlen)-1:0] lbuf;
      reg [rlen:0] diff;
	  integer i;
      begin
	 lbuf = {(llen+rlen){1'b0}};
//64'b0;
	 lbuf[llen-1:0] = l;
	 for(i=width_a-1;i>=0;i=i-1)
	   begin
              diff = minus(lbuf[(llen+rlen)-1:llen-1], {1'b0,r});
	      rdiv[i] = ~diff[rlen];
	      if(diff[rlen] == 0)
		lbuf[(llen+rlen)-1:llen-1] = diff;
	      lbuf[(llen+rlen)-1:1] = lbuf[(llen+rlen)-2:0];
	   end
	 rmod = lbuf[(llen+rlen)-1:llen];
      end
   endtask
      

   task div_u;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(l, r, rdiv, rmod);
      end
   endtask
   
   task mod_u;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_b-1:0] rmod;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(l, r, rdiv, rmod);
      end
   endtask

   task rem_u; 
      input [width_a-1:0] l;
      input [width_b-1:0] r;    
      output [width_b-1:0] rmod;
      begin
	 mod_u(l,r,rmod);
      end
   endtask // rem_u

   task div_s;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_a-1:0] rdiv;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(fabs_l(l), fabs_r(r),rdiv,rmod);
	 if(l[width_a-1] != r[width_b-1])
	   rdiv = {(width_a){1'b0}} - rdiv;
      end
   endtask

   task mod_s;
      input [width_a-1:0] l;
      input [width_b-1:0] r;
      output [width_b-1:0] rmod;
      
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      reg [width_b-1:0] rnul;
      reg [width_b:0] rmod_t;
      begin
         rnul = {width_b{1'b0}};
	 divmod(fabs_l(l), fabs_r(r), rdiv, rmod);
         if (l[width_a-1])
	   rmod = {(width_b){1'b0}} - rmod;
	 if((rmod != rnul) && (l[width_a-1] != r[width_b-1]))
            begin
               rmod_t = r + rmod;
               rmod = rmod_t[width_b-1:0];
            end
      end
   endtask // mod_s
   
   task rem_s; 
      input [width_a-1:0] l;
      input [width_b-1:0] r;    
      output [width_b-1:0] rmod;   
      reg [width_a-01:0] rdiv;
      reg [width_b-1:0] rmod;
      begin
	 divmod(fabs_l(l),fabs_r(r),rdiv,rmod);
	 if(l[width_a-1])
	   rmod = {(width_b){1'b0}} - rmod;
      end
   endtask

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

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/ccs_xilinx/hdl/BLOCK_1R1W_RBW.v 
// Memory Type:            BLOCK
// Operating Mode:         Simple Dual Port (2-Port)
// Clock Mode:             Single Clock
// 
// RTL Code RW Resolution: RBW
// Catapult RW Resolution: RBW
// 
// HDL Work Library:       Xilinx_RAMS_lib
// Component Name:         BLOCK_1R1W_RBW
// Latency = 1:            RAM with no registers on inputs or outputs
//         = 2:            adds embedded register on RAM output
//         = 3:            adds fabric registers to non-clock input RAM pins
//         = 4:            adds fabric register to output (driven by embedded register from latency=2)

module BLOCK_1R1W_RBW #(
  parameter addr_width = 8 ,
  parameter data_width = 7 ,
  parameter depth = 256 ,
  parameter latency = 1 
  
)( clk,clken,d,q,radr,wadr,we);

  input  clk;
  input  clken;
  input [data_width-1:0] d;
  output [data_width-1:0] q;
  input [addr_width-1:0] radr;
  input [addr_width-1:0] wadr;
  input  we;
  
  (* ram_style = "block" *)
  reg [data_width-1:0] mem [depth-1:0];// synthesis syn_ramstyle="block"
  
  reg [data_width-1:0] ramq;
  
  // Port Map
  // readA :: CLOCK clk ENABLE clken DATA_OUT q ADDRESS radr
  // writeA :: CLOCK clk ENABLE clken DATA_IN d ADDRESS wadr WRITE_ENABLE we

  generate
    // Register all non-clock inputs (latency < 3)
    if (latency > 2 ) begin
      reg [addr_width-1:0] radr_reg;
      reg [data_width-1:0] d_reg;
      reg [addr_width-1:0] wadr_reg;
      reg we_reg;
      
      always @(posedge clk) begin
        if (clken) begin
          radr_reg <= radr;
        end
      end
      always @(posedge clk) begin
        if (clken) begin
          d_reg <= d;
          wadr_reg <= wadr;
          we_reg <= we;
        end
      end
      
    // Access memory with registered inputs
      always @(posedge clk) begin
        if (clken) begin
            ramq <= mem[radr_reg];
            if (we_reg) begin
              mem[wadr_reg] <= d_reg;
            end
        end
      end
      
    end // END register inputs

    else begin
    // latency = 1||2: Access memory with non-registered inputs
      always @(posedge clk) begin
        if (clken) begin
            ramq <= mem[radr];
            if (we) begin
              mem[wadr] <= d;
            end
        end
      end
      
    end
  endgenerate //END input port generate 

  generate
    // latency=1: sequential RAM outputs drive module outputs
    if (latency == 1) begin
      assign q = ramq;
      
    end

    else if (latency == 2 || latency == 3) begin
    // latency=2: sequential (RAM output => tmp register => module output)
      reg [data_width-1:0] tmpq;
      
      always @(posedge clk) begin
        if (clken) begin
          tmpq <= ramq;
        end
      end
      
      assign q = tmpq;
      
    end
    else if (latency == 4) begin
    // latency=4: (RAM => tmp1 register => tmp2 fabric register => module output)
      reg [data_width-1:0] tmp1q;
      
      reg [data_width-1:0] tmp2q;
      
      always @(posedge clk) begin
        if (clken) begin
          tmp1q <= ramq;
        end
      end
      
      always @(posedge clk) begin
        if (clken) begin
          tmp2q <= tmp1q;
        end
      end
      
      assign q = tmp2q;
      
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
//  Generated date: Thu Sep 16 20:52:07 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_10_64_1024_1024_64_1_gen (
  clken, q, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [63:0] q;
  output [9:0] radr;
  output we;
  output [63:0] d;
  output [9:0] wadr;
  input clken_d;
  input [63:0] d_d;
  output [63:0] q_d;
  input [9:0] radr_d;
  input [9:0] wadr_d;
  input we_d;
  input writeA_w_ram_ir_internal_WMASK_B_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign clken = (clken_d);
  assign q_d = q;
  assign radr = (radr_d);
  assign we = (writeA_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_5_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_5_10_64_1024_1024_64_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [9:0] radr;
  output [63:0] q_d;
  input [9:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen (
  q, radr, we, d, wadr, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [9:0] radr;
  output we;
  output [63:0] d;
  output [9:0] wadr;
  input [63:0] d_d;
  output [63:0] q_d;
  input [9:0] radr_d;
  input [9:0] wadr_d;
  input we_d;
  input writeA_w_ram_ir_internal_WMASK_B_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
  assign we = (writeA_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_1_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_1_10_64_1024_1024_64_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [9:0] radr;
  output [63:0] q_d;
  input [9:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module peaceNTT_core_core_fsm (
  clk, rst, fsm_output, COPY_LOOP_C_2_tr0, COMP_LOOP_C_185_tr0, COPY_LOOP_1_C_2_tr0,
      STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input COPY_LOOP_C_2_tr0;
  input COMP_LOOP_C_185_tr0;
  input COPY_LOOP_1_C_2_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for peaceNTT_core_core_fsm_1
  parameter
    main_C_0 = 8'd0,
    COPY_LOOP_C_0 = 8'd1,
    COPY_LOOP_C_1 = 8'd2,
    COPY_LOOP_C_2 = 8'd3,
    STAGE_LOOP_C_0 = 8'd4,
    COMP_LOOP_C_0 = 8'd5,
    COMP_LOOP_C_1 = 8'd6,
    COMP_LOOP_C_2 = 8'd7,
    COMP_LOOP_C_3 = 8'd8,
    COMP_LOOP_C_4 = 8'd9,
    COMP_LOOP_C_5 = 8'd10,
    COMP_LOOP_C_6 = 8'd11,
    COMP_LOOP_C_7 = 8'd12,
    COMP_LOOP_C_8 = 8'd13,
    COMP_LOOP_C_9 = 8'd14,
    COMP_LOOP_C_10 = 8'd15,
    COMP_LOOP_C_11 = 8'd16,
    COMP_LOOP_C_12 = 8'd17,
    COMP_LOOP_C_13 = 8'd18,
    COMP_LOOP_C_14 = 8'd19,
    COMP_LOOP_C_15 = 8'd20,
    COMP_LOOP_C_16 = 8'd21,
    COMP_LOOP_C_17 = 8'd22,
    COMP_LOOP_C_18 = 8'd23,
    COMP_LOOP_C_19 = 8'd24,
    COMP_LOOP_C_20 = 8'd25,
    COMP_LOOP_C_21 = 8'd26,
    COMP_LOOP_C_22 = 8'd27,
    COMP_LOOP_C_23 = 8'd28,
    COMP_LOOP_C_24 = 8'd29,
    COMP_LOOP_C_25 = 8'd30,
    COMP_LOOP_C_26 = 8'd31,
    COMP_LOOP_C_27 = 8'd32,
    COMP_LOOP_C_28 = 8'd33,
    COMP_LOOP_C_29 = 8'd34,
    COMP_LOOP_C_30 = 8'd35,
    COMP_LOOP_C_31 = 8'd36,
    COMP_LOOP_C_32 = 8'd37,
    COMP_LOOP_C_33 = 8'd38,
    COMP_LOOP_C_34 = 8'd39,
    COMP_LOOP_C_35 = 8'd40,
    COMP_LOOP_C_36 = 8'd41,
    COMP_LOOP_C_37 = 8'd42,
    COMP_LOOP_C_38 = 8'd43,
    COMP_LOOP_C_39 = 8'd44,
    COMP_LOOP_C_40 = 8'd45,
    COMP_LOOP_C_41 = 8'd46,
    COMP_LOOP_C_42 = 8'd47,
    COMP_LOOP_C_43 = 8'd48,
    COMP_LOOP_C_44 = 8'd49,
    COMP_LOOP_C_45 = 8'd50,
    COMP_LOOP_C_46 = 8'd51,
    COMP_LOOP_C_47 = 8'd52,
    COMP_LOOP_C_48 = 8'd53,
    COMP_LOOP_C_49 = 8'd54,
    COMP_LOOP_C_50 = 8'd55,
    COMP_LOOP_C_51 = 8'd56,
    COMP_LOOP_C_52 = 8'd57,
    COMP_LOOP_C_53 = 8'd58,
    COMP_LOOP_C_54 = 8'd59,
    COMP_LOOP_C_55 = 8'd60,
    COMP_LOOP_C_56 = 8'd61,
    COMP_LOOP_C_57 = 8'd62,
    COMP_LOOP_C_58 = 8'd63,
    COMP_LOOP_C_59 = 8'd64,
    COMP_LOOP_C_60 = 8'd65,
    COMP_LOOP_C_61 = 8'd66,
    COMP_LOOP_C_62 = 8'd67,
    COMP_LOOP_C_63 = 8'd68,
    COMP_LOOP_C_64 = 8'd69,
    COMP_LOOP_C_65 = 8'd70,
    COMP_LOOP_C_66 = 8'd71,
    COMP_LOOP_C_67 = 8'd72,
    COMP_LOOP_C_68 = 8'd73,
    COMP_LOOP_C_69 = 8'd74,
    COMP_LOOP_C_70 = 8'd75,
    COMP_LOOP_C_71 = 8'd76,
    COMP_LOOP_C_72 = 8'd77,
    COMP_LOOP_C_73 = 8'd78,
    COMP_LOOP_C_74 = 8'd79,
    COMP_LOOP_C_75 = 8'd80,
    COMP_LOOP_C_76 = 8'd81,
    COMP_LOOP_C_77 = 8'd82,
    COMP_LOOP_C_78 = 8'd83,
    COMP_LOOP_C_79 = 8'd84,
    COMP_LOOP_C_80 = 8'd85,
    COMP_LOOP_C_81 = 8'd86,
    COMP_LOOP_C_82 = 8'd87,
    COMP_LOOP_C_83 = 8'd88,
    COMP_LOOP_C_84 = 8'd89,
    COMP_LOOP_C_85 = 8'd90,
    COMP_LOOP_C_86 = 8'd91,
    COMP_LOOP_C_87 = 8'd92,
    COMP_LOOP_C_88 = 8'd93,
    COMP_LOOP_C_89 = 8'd94,
    COMP_LOOP_C_90 = 8'd95,
    COMP_LOOP_C_91 = 8'd96,
    COMP_LOOP_C_92 = 8'd97,
    COMP_LOOP_C_93 = 8'd98,
    COMP_LOOP_C_94 = 8'd99,
    COMP_LOOP_C_95 = 8'd100,
    COMP_LOOP_C_96 = 8'd101,
    COMP_LOOP_C_97 = 8'd102,
    COMP_LOOP_C_98 = 8'd103,
    COMP_LOOP_C_99 = 8'd104,
    COMP_LOOP_C_100 = 8'd105,
    COMP_LOOP_C_101 = 8'd106,
    COMP_LOOP_C_102 = 8'd107,
    COMP_LOOP_C_103 = 8'd108,
    COMP_LOOP_C_104 = 8'd109,
    COMP_LOOP_C_105 = 8'd110,
    COMP_LOOP_C_106 = 8'd111,
    COMP_LOOP_C_107 = 8'd112,
    COMP_LOOP_C_108 = 8'd113,
    COMP_LOOP_C_109 = 8'd114,
    COMP_LOOP_C_110 = 8'd115,
    COMP_LOOP_C_111 = 8'd116,
    COMP_LOOP_C_112 = 8'd117,
    COMP_LOOP_C_113 = 8'd118,
    COMP_LOOP_C_114 = 8'd119,
    COMP_LOOP_C_115 = 8'd120,
    COMP_LOOP_C_116 = 8'd121,
    COMP_LOOP_C_117 = 8'd122,
    COMP_LOOP_C_118 = 8'd123,
    COMP_LOOP_C_119 = 8'd124,
    COMP_LOOP_C_120 = 8'd125,
    COMP_LOOP_C_121 = 8'd126,
    COMP_LOOP_C_122 = 8'd127,
    COMP_LOOP_C_123 = 8'd128,
    COMP_LOOP_C_124 = 8'd129,
    COMP_LOOP_C_125 = 8'd130,
    COMP_LOOP_C_126 = 8'd131,
    COMP_LOOP_C_127 = 8'd132,
    COMP_LOOP_C_128 = 8'd133,
    COMP_LOOP_C_129 = 8'd134,
    COMP_LOOP_C_130 = 8'd135,
    COMP_LOOP_C_131 = 8'd136,
    COMP_LOOP_C_132 = 8'd137,
    COMP_LOOP_C_133 = 8'd138,
    COMP_LOOP_C_134 = 8'd139,
    COMP_LOOP_C_135 = 8'd140,
    COMP_LOOP_C_136 = 8'd141,
    COMP_LOOP_C_137 = 8'd142,
    COMP_LOOP_C_138 = 8'd143,
    COMP_LOOP_C_139 = 8'd144,
    COMP_LOOP_C_140 = 8'd145,
    COMP_LOOP_C_141 = 8'd146,
    COMP_LOOP_C_142 = 8'd147,
    COMP_LOOP_C_143 = 8'd148,
    COMP_LOOP_C_144 = 8'd149,
    COMP_LOOP_C_145 = 8'd150,
    COMP_LOOP_C_146 = 8'd151,
    COMP_LOOP_C_147 = 8'd152,
    COMP_LOOP_C_148 = 8'd153,
    COMP_LOOP_C_149 = 8'd154,
    COMP_LOOP_C_150 = 8'd155,
    COMP_LOOP_C_151 = 8'd156,
    COMP_LOOP_C_152 = 8'd157,
    COMP_LOOP_C_153 = 8'd158,
    COMP_LOOP_C_154 = 8'd159,
    COMP_LOOP_C_155 = 8'd160,
    COMP_LOOP_C_156 = 8'd161,
    COMP_LOOP_C_157 = 8'd162,
    COMP_LOOP_C_158 = 8'd163,
    COMP_LOOP_C_159 = 8'd164,
    COMP_LOOP_C_160 = 8'd165,
    COMP_LOOP_C_161 = 8'd166,
    COMP_LOOP_C_162 = 8'd167,
    COMP_LOOP_C_163 = 8'd168,
    COMP_LOOP_C_164 = 8'd169,
    COMP_LOOP_C_165 = 8'd170,
    COMP_LOOP_C_166 = 8'd171,
    COMP_LOOP_C_167 = 8'd172,
    COMP_LOOP_C_168 = 8'd173,
    COMP_LOOP_C_169 = 8'd174,
    COMP_LOOP_C_170 = 8'd175,
    COMP_LOOP_C_171 = 8'd176,
    COMP_LOOP_C_172 = 8'd177,
    COMP_LOOP_C_173 = 8'd178,
    COMP_LOOP_C_174 = 8'd179,
    COMP_LOOP_C_175 = 8'd180,
    COMP_LOOP_C_176 = 8'd181,
    COMP_LOOP_C_177 = 8'd182,
    COMP_LOOP_C_178 = 8'd183,
    COMP_LOOP_C_179 = 8'd184,
    COMP_LOOP_C_180 = 8'd185,
    COMP_LOOP_C_181 = 8'd186,
    COMP_LOOP_C_182 = 8'd187,
    COMP_LOOP_C_183 = 8'd188,
    COMP_LOOP_C_184 = 8'd189,
    COMP_LOOP_C_185 = 8'd190,
    COPY_LOOP_1_C_0 = 8'd191,
    COPY_LOOP_1_C_1 = 8'd192,
    COPY_LOOP_1_C_2 = 8'd193,
    STAGE_LOOP_C_1 = 8'd194,
    main_C_1 = 8'd195;

  reg [7:0] state_var;
  reg [7:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : peaceNTT_core_core_fsm_1
    case (state_var)
      COPY_LOOP_C_0 : begin
        fsm_output = 8'b00000001;
        state_var_NS = COPY_LOOP_C_1;
      end
      COPY_LOOP_C_1 : begin
        fsm_output = 8'b00000010;
        state_var_NS = COPY_LOOP_C_2;
      end
      COPY_LOOP_C_2 : begin
        fsm_output = 8'b00000011;
        if ( COPY_LOOP_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_0;
        end
        else begin
          state_var_NS = COPY_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_0 : begin
        fsm_output = 8'b00000100;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 8'b00000101;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 8'b00000110;
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 8'b00000111;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 8'b00001000;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 8'b00001001;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 8'b00001010;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 8'b00001011;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 8'b00001100;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 8'b00001101;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 8'b00001110;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 8'b00001111;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 8'b00010000;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 8'b00010001;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 8'b00010010;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 8'b00010011;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 8'b00010100;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 8'b00010101;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 8'b00010110;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 8'b00010111;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 8'b00011000;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 8'b00011001;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 8'b00011010;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 8'b00011011;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 8'b00011100;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 8'b00011101;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 8'b00011110;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 8'b00011111;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 8'b00100000;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 8'b00100001;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 8'b00100010;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 8'b00100011;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 8'b00100100;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 8'b00100101;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 8'b00100110;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 8'b00100111;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 8'b00101000;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 8'b00101001;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 8'b00101010;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 8'b00101011;
        state_var_NS = COMP_LOOP_C_39;
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 8'b00101100;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 8'b00101101;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 8'b00101110;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 8'b00101111;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 8'b00110000;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 8'b00110001;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 8'b00110010;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 8'b00110011;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 8'b00110100;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 8'b00110101;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 8'b00110110;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 8'b00110111;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 8'b00111000;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 8'b00111001;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 8'b00111010;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 8'b00111011;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 8'b00111100;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 8'b00111101;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 8'b00111110;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 8'b00111111;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 8'b01000000;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 8'b01000001;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 8'b01000010;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 8'b01000011;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 8'b01000100;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 8'b01000101;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 8'b01000110;
        state_var_NS = COMP_LOOP_C_66;
      end
      COMP_LOOP_C_66 : begin
        fsm_output = 8'b01000111;
        state_var_NS = COMP_LOOP_C_67;
      end
      COMP_LOOP_C_67 : begin
        fsm_output = 8'b01001000;
        state_var_NS = COMP_LOOP_C_68;
      end
      COMP_LOOP_C_68 : begin
        fsm_output = 8'b01001001;
        state_var_NS = COMP_LOOP_C_69;
      end
      COMP_LOOP_C_69 : begin
        fsm_output = 8'b01001010;
        state_var_NS = COMP_LOOP_C_70;
      end
      COMP_LOOP_C_70 : begin
        fsm_output = 8'b01001011;
        state_var_NS = COMP_LOOP_C_71;
      end
      COMP_LOOP_C_71 : begin
        fsm_output = 8'b01001100;
        state_var_NS = COMP_LOOP_C_72;
      end
      COMP_LOOP_C_72 : begin
        fsm_output = 8'b01001101;
        state_var_NS = COMP_LOOP_C_73;
      end
      COMP_LOOP_C_73 : begin
        fsm_output = 8'b01001110;
        state_var_NS = COMP_LOOP_C_74;
      end
      COMP_LOOP_C_74 : begin
        fsm_output = 8'b01001111;
        state_var_NS = COMP_LOOP_C_75;
      end
      COMP_LOOP_C_75 : begin
        fsm_output = 8'b01010000;
        state_var_NS = COMP_LOOP_C_76;
      end
      COMP_LOOP_C_76 : begin
        fsm_output = 8'b01010001;
        state_var_NS = COMP_LOOP_C_77;
      end
      COMP_LOOP_C_77 : begin
        fsm_output = 8'b01010010;
        state_var_NS = COMP_LOOP_C_78;
      end
      COMP_LOOP_C_78 : begin
        fsm_output = 8'b01010011;
        state_var_NS = COMP_LOOP_C_79;
      end
      COMP_LOOP_C_79 : begin
        fsm_output = 8'b01010100;
        state_var_NS = COMP_LOOP_C_80;
      end
      COMP_LOOP_C_80 : begin
        fsm_output = 8'b01010101;
        state_var_NS = COMP_LOOP_C_81;
      end
      COMP_LOOP_C_81 : begin
        fsm_output = 8'b01010110;
        state_var_NS = COMP_LOOP_C_82;
      end
      COMP_LOOP_C_82 : begin
        fsm_output = 8'b01010111;
        state_var_NS = COMP_LOOP_C_83;
      end
      COMP_LOOP_C_83 : begin
        fsm_output = 8'b01011000;
        state_var_NS = COMP_LOOP_C_84;
      end
      COMP_LOOP_C_84 : begin
        fsm_output = 8'b01011001;
        state_var_NS = COMP_LOOP_C_85;
      end
      COMP_LOOP_C_85 : begin
        fsm_output = 8'b01011010;
        state_var_NS = COMP_LOOP_C_86;
      end
      COMP_LOOP_C_86 : begin
        fsm_output = 8'b01011011;
        state_var_NS = COMP_LOOP_C_87;
      end
      COMP_LOOP_C_87 : begin
        fsm_output = 8'b01011100;
        state_var_NS = COMP_LOOP_C_88;
      end
      COMP_LOOP_C_88 : begin
        fsm_output = 8'b01011101;
        state_var_NS = COMP_LOOP_C_89;
      end
      COMP_LOOP_C_89 : begin
        fsm_output = 8'b01011110;
        state_var_NS = COMP_LOOP_C_90;
      end
      COMP_LOOP_C_90 : begin
        fsm_output = 8'b01011111;
        state_var_NS = COMP_LOOP_C_91;
      end
      COMP_LOOP_C_91 : begin
        fsm_output = 8'b01100000;
        state_var_NS = COMP_LOOP_C_92;
      end
      COMP_LOOP_C_92 : begin
        fsm_output = 8'b01100001;
        state_var_NS = COMP_LOOP_C_93;
      end
      COMP_LOOP_C_93 : begin
        fsm_output = 8'b01100010;
        state_var_NS = COMP_LOOP_C_94;
      end
      COMP_LOOP_C_94 : begin
        fsm_output = 8'b01100011;
        state_var_NS = COMP_LOOP_C_95;
      end
      COMP_LOOP_C_95 : begin
        fsm_output = 8'b01100100;
        state_var_NS = COMP_LOOP_C_96;
      end
      COMP_LOOP_C_96 : begin
        fsm_output = 8'b01100101;
        state_var_NS = COMP_LOOP_C_97;
      end
      COMP_LOOP_C_97 : begin
        fsm_output = 8'b01100110;
        state_var_NS = COMP_LOOP_C_98;
      end
      COMP_LOOP_C_98 : begin
        fsm_output = 8'b01100111;
        state_var_NS = COMP_LOOP_C_99;
      end
      COMP_LOOP_C_99 : begin
        fsm_output = 8'b01101000;
        state_var_NS = COMP_LOOP_C_100;
      end
      COMP_LOOP_C_100 : begin
        fsm_output = 8'b01101001;
        state_var_NS = COMP_LOOP_C_101;
      end
      COMP_LOOP_C_101 : begin
        fsm_output = 8'b01101010;
        state_var_NS = COMP_LOOP_C_102;
      end
      COMP_LOOP_C_102 : begin
        fsm_output = 8'b01101011;
        state_var_NS = COMP_LOOP_C_103;
      end
      COMP_LOOP_C_103 : begin
        fsm_output = 8'b01101100;
        state_var_NS = COMP_LOOP_C_104;
      end
      COMP_LOOP_C_104 : begin
        fsm_output = 8'b01101101;
        state_var_NS = COMP_LOOP_C_105;
      end
      COMP_LOOP_C_105 : begin
        fsm_output = 8'b01101110;
        state_var_NS = COMP_LOOP_C_106;
      end
      COMP_LOOP_C_106 : begin
        fsm_output = 8'b01101111;
        state_var_NS = COMP_LOOP_C_107;
      end
      COMP_LOOP_C_107 : begin
        fsm_output = 8'b01110000;
        state_var_NS = COMP_LOOP_C_108;
      end
      COMP_LOOP_C_108 : begin
        fsm_output = 8'b01110001;
        state_var_NS = COMP_LOOP_C_109;
      end
      COMP_LOOP_C_109 : begin
        fsm_output = 8'b01110010;
        state_var_NS = COMP_LOOP_C_110;
      end
      COMP_LOOP_C_110 : begin
        fsm_output = 8'b01110011;
        state_var_NS = COMP_LOOP_C_111;
      end
      COMP_LOOP_C_111 : begin
        fsm_output = 8'b01110100;
        state_var_NS = COMP_LOOP_C_112;
      end
      COMP_LOOP_C_112 : begin
        fsm_output = 8'b01110101;
        state_var_NS = COMP_LOOP_C_113;
      end
      COMP_LOOP_C_113 : begin
        fsm_output = 8'b01110110;
        state_var_NS = COMP_LOOP_C_114;
      end
      COMP_LOOP_C_114 : begin
        fsm_output = 8'b01110111;
        state_var_NS = COMP_LOOP_C_115;
      end
      COMP_LOOP_C_115 : begin
        fsm_output = 8'b01111000;
        state_var_NS = COMP_LOOP_C_116;
      end
      COMP_LOOP_C_116 : begin
        fsm_output = 8'b01111001;
        state_var_NS = COMP_LOOP_C_117;
      end
      COMP_LOOP_C_117 : begin
        fsm_output = 8'b01111010;
        state_var_NS = COMP_LOOP_C_118;
      end
      COMP_LOOP_C_118 : begin
        fsm_output = 8'b01111011;
        state_var_NS = COMP_LOOP_C_119;
      end
      COMP_LOOP_C_119 : begin
        fsm_output = 8'b01111100;
        state_var_NS = COMP_LOOP_C_120;
      end
      COMP_LOOP_C_120 : begin
        fsm_output = 8'b01111101;
        state_var_NS = COMP_LOOP_C_121;
      end
      COMP_LOOP_C_121 : begin
        fsm_output = 8'b01111110;
        state_var_NS = COMP_LOOP_C_122;
      end
      COMP_LOOP_C_122 : begin
        fsm_output = 8'b01111111;
        state_var_NS = COMP_LOOP_C_123;
      end
      COMP_LOOP_C_123 : begin
        fsm_output = 8'b10000000;
        state_var_NS = COMP_LOOP_C_124;
      end
      COMP_LOOP_C_124 : begin
        fsm_output = 8'b10000001;
        state_var_NS = COMP_LOOP_C_125;
      end
      COMP_LOOP_C_125 : begin
        fsm_output = 8'b10000010;
        state_var_NS = COMP_LOOP_C_126;
      end
      COMP_LOOP_C_126 : begin
        fsm_output = 8'b10000011;
        state_var_NS = COMP_LOOP_C_127;
      end
      COMP_LOOP_C_127 : begin
        fsm_output = 8'b10000100;
        state_var_NS = COMP_LOOP_C_128;
      end
      COMP_LOOP_C_128 : begin
        fsm_output = 8'b10000101;
        state_var_NS = COMP_LOOP_C_129;
      end
      COMP_LOOP_C_129 : begin
        fsm_output = 8'b10000110;
        state_var_NS = COMP_LOOP_C_130;
      end
      COMP_LOOP_C_130 : begin
        fsm_output = 8'b10000111;
        state_var_NS = COMP_LOOP_C_131;
      end
      COMP_LOOP_C_131 : begin
        fsm_output = 8'b10001000;
        state_var_NS = COMP_LOOP_C_132;
      end
      COMP_LOOP_C_132 : begin
        fsm_output = 8'b10001001;
        state_var_NS = COMP_LOOP_C_133;
      end
      COMP_LOOP_C_133 : begin
        fsm_output = 8'b10001010;
        state_var_NS = COMP_LOOP_C_134;
      end
      COMP_LOOP_C_134 : begin
        fsm_output = 8'b10001011;
        state_var_NS = COMP_LOOP_C_135;
      end
      COMP_LOOP_C_135 : begin
        fsm_output = 8'b10001100;
        state_var_NS = COMP_LOOP_C_136;
      end
      COMP_LOOP_C_136 : begin
        fsm_output = 8'b10001101;
        state_var_NS = COMP_LOOP_C_137;
      end
      COMP_LOOP_C_137 : begin
        fsm_output = 8'b10001110;
        state_var_NS = COMP_LOOP_C_138;
      end
      COMP_LOOP_C_138 : begin
        fsm_output = 8'b10001111;
        state_var_NS = COMP_LOOP_C_139;
      end
      COMP_LOOP_C_139 : begin
        fsm_output = 8'b10010000;
        state_var_NS = COMP_LOOP_C_140;
      end
      COMP_LOOP_C_140 : begin
        fsm_output = 8'b10010001;
        state_var_NS = COMP_LOOP_C_141;
      end
      COMP_LOOP_C_141 : begin
        fsm_output = 8'b10010010;
        state_var_NS = COMP_LOOP_C_142;
      end
      COMP_LOOP_C_142 : begin
        fsm_output = 8'b10010011;
        state_var_NS = COMP_LOOP_C_143;
      end
      COMP_LOOP_C_143 : begin
        fsm_output = 8'b10010100;
        state_var_NS = COMP_LOOP_C_144;
      end
      COMP_LOOP_C_144 : begin
        fsm_output = 8'b10010101;
        state_var_NS = COMP_LOOP_C_145;
      end
      COMP_LOOP_C_145 : begin
        fsm_output = 8'b10010110;
        state_var_NS = COMP_LOOP_C_146;
      end
      COMP_LOOP_C_146 : begin
        fsm_output = 8'b10010111;
        state_var_NS = COMP_LOOP_C_147;
      end
      COMP_LOOP_C_147 : begin
        fsm_output = 8'b10011000;
        state_var_NS = COMP_LOOP_C_148;
      end
      COMP_LOOP_C_148 : begin
        fsm_output = 8'b10011001;
        state_var_NS = COMP_LOOP_C_149;
      end
      COMP_LOOP_C_149 : begin
        fsm_output = 8'b10011010;
        state_var_NS = COMP_LOOP_C_150;
      end
      COMP_LOOP_C_150 : begin
        fsm_output = 8'b10011011;
        state_var_NS = COMP_LOOP_C_151;
      end
      COMP_LOOP_C_151 : begin
        fsm_output = 8'b10011100;
        state_var_NS = COMP_LOOP_C_152;
      end
      COMP_LOOP_C_152 : begin
        fsm_output = 8'b10011101;
        state_var_NS = COMP_LOOP_C_153;
      end
      COMP_LOOP_C_153 : begin
        fsm_output = 8'b10011110;
        state_var_NS = COMP_LOOP_C_154;
      end
      COMP_LOOP_C_154 : begin
        fsm_output = 8'b10011111;
        state_var_NS = COMP_LOOP_C_155;
      end
      COMP_LOOP_C_155 : begin
        fsm_output = 8'b10100000;
        state_var_NS = COMP_LOOP_C_156;
      end
      COMP_LOOP_C_156 : begin
        fsm_output = 8'b10100001;
        state_var_NS = COMP_LOOP_C_157;
      end
      COMP_LOOP_C_157 : begin
        fsm_output = 8'b10100010;
        state_var_NS = COMP_LOOP_C_158;
      end
      COMP_LOOP_C_158 : begin
        fsm_output = 8'b10100011;
        state_var_NS = COMP_LOOP_C_159;
      end
      COMP_LOOP_C_159 : begin
        fsm_output = 8'b10100100;
        state_var_NS = COMP_LOOP_C_160;
      end
      COMP_LOOP_C_160 : begin
        fsm_output = 8'b10100101;
        state_var_NS = COMP_LOOP_C_161;
      end
      COMP_LOOP_C_161 : begin
        fsm_output = 8'b10100110;
        state_var_NS = COMP_LOOP_C_162;
      end
      COMP_LOOP_C_162 : begin
        fsm_output = 8'b10100111;
        state_var_NS = COMP_LOOP_C_163;
      end
      COMP_LOOP_C_163 : begin
        fsm_output = 8'b10101000;
        state_var_NS = COMP_LOOP_C_164;
      end
      COMP_LOOP_C_164 : begin
        fsm_output = 8'b10101001;
        state_var_NS = COMP_LOOP_C_165;
      end
      COMP_LOOP_C_165 : begin
        fsm_output = 8'b10101010;
        state_var_NS = COMP_LOOP_C_166;
      end
      COMP_LOOP_C_166 : begin
        fsm_output = 8'b10101011;
        state_var_NS = COMP_LOOP_C_167;
      end
      COMP_LOOP_C_167 : begin
        fsm_output = 8'b10101100;
        state_var_NS = COMP_LOOP_C_168;
      end
      COMP_LOOP_C_168 : begin
        fsm_output = 8'b10101101;
        state_var_NS = COMP_LOOP_C_169;
      end
      COMP_LOOP_C_169 : begin
        fsm_output = 8'b10101110;
        state_var_NS = COMP_LOOP_C_170;
      end
      COMP_LOOP_C_170 : begin
        fsm_output = 8'b10101111;
        state_var_NS = COMP_LOOP_C_171;
      end
      COMP_LOOP_C_171 : begin
        fsm_output = 8'b10110000;
        state_var_NS = COMP_LOOP_C_172;
      end
      COMP_LOOP_C_172 : begin
        fsm_output = 8'b10110001;
        state_var_NS = COMP_LOOP_C_173;
      end
      COMP_LOOP_C_173 : begin
        fsm_output = 8'b10110010;
        state_var_NS = COMP_LOOP_C_174;
      end
      COMP_LOOP_C_174 : begin
        fsm_output = 8'b10110011;
        state_var_NS = COMP_LOOP_C_175;
      end
      COMP_LOOP_C_175 : begin
        fsm_output = 8'b10110100;
        state_var_NS = COMP_LOOP_C_176;
      end
      COMP_LOOP_C_176 : begin
        fsm_output = 8'b10110101;
        state_var_NS = COMP_LOOP_C_177;
      end
      COMP_LOOP_C_177 : begin
        fsm_output = 8'b10110110;
        state_var_NS = COMP_LOOP_C_178;
      end
      COMP_LOOP_C_178 : begin
        fsm_output = 8'b10110111;
        state_var_NS = COMP_LOOP_C_179;
      end
      COMP_LOOP_C_179 : begin
        fsm_output = 8'b10111000;
        state_var_NS = COMP_LOOP_C_180;
      end
      COMP_LOOP_C_180 : begin
        fsm_output = 8'b10111001;
        state_var_NS = COMP_LOOP_C_181;
      end
      COMP_LOOP_C_181 : begin
        fsm_output = 8'b10111010;
        state_var_NS = COMP_LOOP_C_182;
      end
      COMP_LOOP_C_182 : begin
        fsm_output = 8'b10111011;
        state_var_NS = COMP_LOOP_C_183;
      end
      COMP_LOOP_C_183 : begin
        fsm_output = 8'b10111100;
        state_var_NS = COMP_LOOP_C_184;
      end
      COMP_LOOP_C_184 : begin
        fsm_output = 8'b10111101;
        state_var_NS = COMP_LOOP_C_185;
      end
      COMP_LOOP_C_185 : begin
        fsm_output = 8'b10111110;
        if ( COMP_LOOP_C_185_tr0 ) begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      COPY_LOOP_1_C_0 : begin
        fsm_output = 8'b10111111;
        state_var_NS = COPY_LOOP_1_C_1;
      end
      COPY_LOOP_1_C_1 : begin
        fsm_output = 8'b11000000;
        state_var_NS = COPY_LOOP_1_C_2;
      end
      COPY_LOOP_1_C_2 : begin
        fsm_output = 8'b11000001;
        if ( COPY_LOOP_1_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 8'b11000010;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 8'b11000011;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 8'b00000000;
        state_var_NS = COPY_LOOP_C_0;
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
//  Design Unit:    peaceNTT_core_wait_dp
// ------------------------------------------------------------------


module peaceNTT_core_wait_dp (
  clk, xt_rsc_cgo_iro, xt_rsci_clken_d, COMP_LOOP_f2_rem_cmp_z, ensig_cgo_iro, xt_rsc_cgo,
      COMP_LOOP_f2_rem_cmp_z_oreg, ensig_cgo, COMP_LOOP_f2_mul_cmp_en
);
  input clk;
  input xt_rsc_cgo_iro;
  output xt_rsci_clken_d;
  input [63:0] COMP_LOOP_f2_rem_cmp_z;
  input ensig_cgo_iro;
  input xt_rsc_cgo;
  output [63:0] COMP_LOOP_f2_rem_cmp_z_oreg;
  reg [63:0] COMP_LOOP_f2_rem_cmp_z_oreg;
  input ensig_cgo;
  output COMP_LOOP_f2_mul_cmp_en;



  // Interconnect Declarations for Component Instantiations 
  assign xt_rsci_clken_d = xt_rsc_cgo | xt_rsc_cgo_iro;
  assign COMP_LOOP_f2_mul_cmp_en = ensig_cgo | ensig_cgo_iro;
  always @(posedge clk) begin
    COMP_LOOP_f2_rem_cmp_z_oreg <= COMP_LOOP_f2_rem_cmp_z;
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_core
// ------------------------------------------------------------------


module peaceNTT_core (
  clk, rst, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, g_rsc_triosy_lz, result_rsc_triosy_lz,
      twiddle_rsc_triosy_lz, vec_rsci_q_d, vec_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      result_rsci_d_d, result_rsci_q_d, result_rsci_wadr_d, result_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsci_q_d, twiddle_rsci_radr_d, twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      xt_rsci_clken_d, xt_rsci_d_d, xt_rsci_q_d, xt_rsci_radr_d, xt_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      COMP_LOOP_f2_rem_cmp_a, COMP_LOOP_f2_rem_cmp_b, COMP_LOOP_f2_rem_cmp_z, vec_rsci_radr_d_pff,
      result_rsci_we_d_pff, xt_rsci_we_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output g_rsc_triosy_lz;
  output result_rsc_triosy_lz;
  output twiddle_rsc_triosy_lz;
  input [63:0] vec_rsci_q_d;
  output vec_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output [63:0] result_rsci_d_d;
  input [63:0] result_rsci_q_d;
  output [9:0] result_rsci_wadr_d;
  output result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_rsci_q_d;
  output [9:0] twiddle_rsci_radr_d;
  output twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output xt_rsci_clken_d;
  output [63:0] xt_rsci_d_d;
  input [63:0] xt_rsci_q_d;
  output [9:0] xt_rsci_radr_d;
  output xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output [127:0] COMP_LOOP_f2_rem_cmp_a;
  reg [127:0] COMP_LOOP_f2_rem_cmp_a;
  output [63:0] COMP_LOOP_f2_rem_cmp_b;
  input [63:0] COMP_LOOP_f2_rem_cmp_z;
  output [9:0] vec_rsci_radr_d_pff;
  output result_rsci_we_d_pff;
  output xt_rsci_we_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  wire [64:0] modulo_dev_result_rem_cmp_z;
  wire [63:0] COMP_LOOP_f2_rem_cmp_z_oreg;
  wire COMP_LOOP_f2_mul_cmp_en;
  wire [127:0] COMP_LOOP_f2_mul_cmp_z;
  reg [63:0] modulo_dev_result_rem_cmp_a_63_0;
  wire [7:0] fsm_output;
  wire COMP_LOOP_COMP_LOOP_if_nor_tmp;
  wire mux_tmp_4;
  wire nor_tmp_2;
  wire mux_tmp_8;
  wire nor_tmp_3;
  wire and_tmp;
  wire and_dcpl_2;
  wire and_dcpl_5;
  wire and_dcpl_6;
  wire and_dcpl_7;
  wire and_dcpl_9;
  wire and_dcpl_10;
  wire and_dcpl_11;
  wire and_dcpl_13;
  wire nor_tmp_6;
  wire and_dcpl_19;
  wire and_dcpl_25;
  wire and_dcpl_28;
  wire and_dcpl_31;
  wire and_dcpl_34;
  wire and_dcpl_37;
  wire and_dcpl_42;
  wire and_dcpl_56;
  wire or_tmp_17;
  wire or_tmp_18;
  wire mux_tmp_31;
  wire or_tmp_22;
  wire not_tmp_29;
  wire mux_tmp_41;
  wire and_dcpl_65;
  wire mux_tmp_55;
  wire mux_tmp_64;
  wire mux_tmp_65;
  wire or_dcpl_4;
  wire or_dcpl_7;
  reg [9:0] COPY_LOOP_1_i_10_0_sva_9_0;
  reg COMP_LOOP_COMP_LOOP_if_nor_svs_st;
  reg reg_xt_rsc_cgo_cse;
  reg reg_vec_rsc_triosy_obj_ld_cse;
  wire and_82_cse;
  reg [63:0] reg_modulo_dev_result_rem_cmp_b_63_0_cse;
  reg reg_ensig_cgo_cse;
  wire or_32_cse;
  wire and_84_cse;
  wire and_32_rmff;
  wire and_63_rmff;
  wire [63:0] COMP_LOOP_f2_mul_cmp_a_mx0;
  reg [8:0] STAGE_LOOP_base_8_0_sva;
  reg [63:0] modulo_dev_1_mux_itm;
  wire [8:0] STAGE_LOOP_base_lshift_itm;
  wire [10:0] z_out;
  wire [11:0] nl_z_out;
  wire and_dcpl_95;
  wire [63:0] z_out_1;
  wire [64:0] nl_z_out_1;
  wire [4:0] z_out_2;
  wire [5:0] nl_z_out_2;
  reg [63:0] p_sva;
  reg [3:0] STAGE_LOOP_base_acc_cse_sva;
  reg [63:0] STAGE_LOOP_lst_sva;
  reg [63:0] STAGE_LOOP_lst_sva_dfm;
  reg [127:0] COMP_LOOP_f2_mul_mut;
  reg [63:0] COMP_LOOP_acc_1_itm;
  reg [63:0] COMP_LOOP_acc_3_psp;
  wire [63:0] COMP_LOOP_acc_3_psp_mx0w0;
  wire [64:0] nl_COMP_LOOP_acc_3_psp_mx0w0;
  wire COPY_LOOP_1_i_10_0_sva_9_0_mx0c2;
  wire or_tmp;
  wire [10:0] COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt;
  reg [1:0] COPY_LOOP_1_i_10_0_sva_1_10_9;
  reg [8:0] COPY_LOOP_1_i_10_0_sva_1_8_0;
  wire nor_42_cse;
  wire and_cse;
  wire mux_93_cse;

  wire[0:0] mux_28_nl;
  wire[0:0] mux_26_nl;
  wire[0:0] mux_39_nl;
  wire[0:0] mux_38_nl;
  wire[0:0] or_14_nl;
  wire[0:0] mux_37_nl;
  wire[0:0] mux_36_nl;
  wire[0:0] or_12_nl;
  wire[0:0] or_11_nl;
  wire[0:0] mux_46_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] or_21_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] or_16_nl;
  wire[0:0] and_60_nl;
  wire[0:0] mux_50_nl;
  wire[0:0] mux_49_nl;
  wire[0:0] mux_48_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] or_22_nl;
  wire[0:0] nor_27_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] mux_51_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] nor_31_nl;
  wire[0:0] nor_32_nl;
  wire[9:0] COPY_LOOP_1_i_mux_nl;
  wire[0:0] COPY_LOOP_1_i_not_nl;
  wire[8:0] COMP_LOOP_r_COMP_LOOP_r_and_nl;
  wire[0:0] COMP_LOOP_r_not_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] mux_90_nl;
  wire[0:0] mux_nl;
  wire[0:0] nand_nl;
  wire[0:0] mux_95_nl;
  wire[0:0] mux_94_nl;
  wire[0:0] nor_41_nl;
  wire[0:0] and_75_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] mux_20_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] STAGE_LOOP_lst_nor_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] or_38_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] mux_84_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] and_78_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] COMP_LOOP_nand_nl;
  wire[0:0] mux_35_nl;
  wire[0:0] nor_21_nl;
  wire[0:0] nor_22_nl;
  wire[8:0] COMP_LOOP_if_and_nl;
  wire[0:0] and_38_nl;
  wire[0:0] COPY_LOOP_COPY_LOOP_nand_nl;
  wire[0:0] mux_89_nl;
  wire[9:0] COPY_LOOP_1_mux_1_nl;
  wire[0:0] and_132_nl;
  wire[63:0] COMP_LOOP_mux_3_nl;
  wire[63:0] COMP_LOOP_mux_4_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_modulo_dev_result_rem_cmp_a;
  assign nl_modulo_dev_result_rem_cmp_a = {{1{modulo_dev_result_rem_cmp_a_63_0[63]}},
      modulo_dev_result_rem_cmp_a_63_0};
  wire [64:0] nl_modulo_dev_result_rem_cmp_b;
  assign nl_modulo_dev_result_rem_cmp_b = {1'b0, reg_modulo_dev_result_rem_cmp_b_63_0_cse};
  wire [3:0] nl_STAGE_LOOP_base_lshift_rg_s;
  assign nl_STAGE_LOOP_base_lshift_rg_s = z_out_2[3:0];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0 = COPY_LOOP_1_i_10_0_sva_1_10_9[1];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_185_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_185_tr0 = COPY_LOOP_1_i_10_0_sva_9_0[9];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0 = COPY_LOOP_1_i_10_0_sva_1_10_9[1];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = z_out_2[4];
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) p_rsci (
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
  mgc_io_sync_v2 #(.valid(32'sd0)) g_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(g_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) result_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(result_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(twiddle_rsc_triosy_lz)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) modulo_dev_result_rem_cmp (
      .a(nl_modulo_dev_result_rem_cmp_a[64:0]),
      .b(nl_modulo_dev_result_rem_cmp_b[64:0]),
      .z(modulo_dev_result_rem_cmp_z)
    );
  mgc_mul_pipe #(.width_a(32'sd64),
  .signd_a(32'sd0),
  .width_b(32'sd64),
  .signd_b(32'sd0),
  .width_z(32'sd128),
  .clock_edge(32'sd1),
  .enable_active(32'sd1),
  .a_rst_active(32'sd0),
  .s_rst_active(32'sd1),
  .stages(32'sd11),
  .n_inreg(32'sd2)) COMP_LOOP_f2_mul_cmp (
      .a(COMP_LOOP_f2_mul_cmp_a_mx0),
      .b(xt_rsci_q_d),
      .clk(clk),
      .en(COMP_LOOP_f2_mul_cmp_en),
      .a_rst(1'b1),
      .s_rst(rst),
      .z(COMP_LOOP_f2_mul_cmp_z)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd1),
  .width_s(32'sd4),
  .width_z(32'sd9)) STAGE_LOOP_base_lshift_rg (
      .a(1'b1),
      .s(nl_STAGE_LOOP_base_lshift_rg_s[3:0]),
      .z(STAGE_LOOP_base_lshift_itm)
    );
  peaceNTT_core_wait_dp peaceNTT_core_wait_dp_inst (
      .clk(clk),
      .xt_rsc_cgo_iro(and_32_rmff),
      .xt_rsci_clken_d(xt_rsci_clken_d),
      .COMP_LOOP_f2_rem_cmp_z(COMP_LOOP_f2_rem_cmp_z),
      .ensig_cgo_iro(and_63_rmff),
      .xt_rsc_cgo(reg_xt_rsc_cgo_cse),
      .COMP_LOOP_f2_rem_cmp_z_oreg(COMP_LOOP_f2_rem_cmp_z_oreg),
      .ensig_cgo(reg_ensig_cgo_cse),
      .COMP_LOOP_f2_mul_cmp_en(COMP_LOOP_f2_mul_cmp_en)
    );
  peaceNTT_core_core_fsm peaceNTT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .COPY_LOOP_C_2_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0[0:0]),
      .COMP_LOOP_C_185_tr0(nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_185_tr0[0:0]),
      .COPY_LOOP_1_C_2_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign or_14_nl = (~ (fsm_output[6])) | (fsm_output[2]) | (~ (fsm_output[7]));
  assign mux_38_nl = MUX_s_1_2_2(or_14_nl, or_32_cse, fsm_output[1]);
  assign or_12_nl = (~ (fsm_output[2])) | (fsm_output[7]);
  assign or_11_nl = (fsm_output[2]) | (~ (fsm_output[7]));
  assign mux_36_nl = MUX_s_1_2_2(or_12_nl, or_11_nl, fsm_output[6]);
  assign mux_37_nl = MUX_s_1_2_2(mux_36_nl, or_32_cse, fsm_output[1]);
  assign mux_39_nl = MUX_s_1_2_2(mux_38_nl, mux_37_nl, fsm_output[0]);
  assign and_32_rmff = (~ mux_39_nl) & and_dcpl_28 & (~ (fsm_output[3]));
  assign and_82_cse = (fsm_output[3:2]==2'b11);
  assign and_84_cse = (fsm_output[4:2]==3'b111);
  assign COMP_LOOP_f2_rem_cmp_b = reg_modulo_dev_result_rem_cmp_b_63_0_cse;
  assign mux_57_nl = MUX_s_1_2_2((fsm_output[4]), (~ (fsm_output[4])), fsm_output[3]);
  assign nor_31_nl = ~((fsm_output[4:3]!=2'b01));
  assign mux_58_nl = MUX_s_1_2_2(mux_57_nl, nor_31_nl, fsm_output[2]);
  assign nor_32_nl = ~((~((fsm_output[3:2]!=2'b00))) | (fsm_output[4]));
  assign mux_59_nl = MUX_s_1_2_2(mux_58_nl, nor_32_nl, fsm_output[1]);
  assign and_63_rmff = mux_59_nl & and_dcpl_6 & (~ (fsm_output[6]));
  assign or_32_cse = (fsm_output[7:6]!=2'b00);
  assign mux_77_nl = MUX_s_1_2_2(mux_tmp_65, mux_tmp_55, fsm_output[0]);
  assign COMP_LOOP_r_not_nl = ~ mux_77_nl;
  assign COMP_LOOP_r_COMP_LOOP_r_and_nl = MUX_v_9_2_2(9'b000000000, (COPY_LOOP_1_i_10_0_sva_9_0[8:0]),
      COMP_LOOP_r_not_nl);
  assign mux_68_nl = MUX_s_1_2_2(mux_tmp_4, mux_tmp_55, fsm_output[0]);
  assign COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt = MUX_v_11_2_2(({2'b00 , COMP_LOOP_r_COMP_LOOP_r_and_nl}),
      z_out, mux_68_nl);
  assign nor_42_cse = ~((fsm_output[2]) | (fsm_output[7]) | (fsm_output[5]) | (fsm_output[3])
      | (fsm_output[4]));
  assign mux_93_cse = MUX_s_1_2_2(nor_42_cse, and_cse, fsm_output[1]);
  assign nl_COMP_LOOP_acc_3_psp_mx0w0 = COMP_LOOP_acc_1_itm - COMP_LOOP_f2_rem_cmp_z_oreg;
  assign COMP_LOOP_acc_3_psp_mx0w0 = nl_COMP_LOOP_acc_3_psp_mx0w0[63:0];
  assign COMP_LOOP_f2_mul_cmp_a_mx0 = MUX_v_64_2_2(STAGE_LOOP_lst_sva, twiddle_rsci_q_d,
      COMP_LOOP_COMP_LOOP_if_nor_svs_st);
  assign COMP_LOOP_COMP_LOOP_if_nor_tmp = ~(((COPY_LOOP_1_i_10_0_sva_1_8_0[8]) &
      (~ (STAGE_LOOP_base_8_0_sva[8]))) | ((COPY_LOOP_1_i_10_0_sva_1_8_0[7]) & (~
      (STAGE_LOOP_base_8_0_sva[7]))) | ((COPY_LOOP_1_i_10_0_sva_1_8_0[6]) & (~ (STAGE_LOOP_base_8_0_sva[6])))
      | ((COPY_LOOP_1_i_10_0_sva_1_8_0[5]) & (~ (STAGE_LOOP_base_8_0_sva[5]))) |
      ((COPY_LOOP_1_i_10_0_sva_1_8_0[4]) & (~ (STAGE_LOOP_base_8_0_sva[4]))) | ((COPY_LOOP_1_i_10_0_sva_1_8_0[3])
      & (~ (STAGE_LOOP_base_8_0_sva[3]))) | ((COPY_LOOP_1_i_10_0_sva_1_8_0[2]) &
      (~ (STAGE_LOOP_base_8_0_sva[2]))) | ((COPY_LOOP_1_i_10_0_sva_1_8_0[1]) & (~
      (STAGE_LOOP_base_8_0_sva[1]))) | ((COPY_LOOP_1_i_10_0_sva_1_8_0[0]) & (~ (STAGE_LOOP_base_8_0_sva[0]))));
  assign mux_tmp_4 = MUX_s_1_2_2(nor_42_cse, (fsm_output[7]), fsm_output[6]);
  assign nor_tmp_2 = ((fsm_output[5:2]!=4'b0000)) & (fsm_output[7]);
  assign mux_tmp_8 = MUX_s_1_2_2(nor_42_cse, nor_tmp_2, fsm_output[6]);
  assign nor_tmp_3 = (fsm_output[7:6]==2'b11);
  assign and_tmp = (fsm_output[6]) & nor_tmp_2;
  assign and_dcpl_2 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_5 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_6 = ~((fsm_output[7]) | (fsm_output[5]));
  assign and_dcpl_7 = and_dcpl_6 & and_dcpl_5;
  assign and_dcpl_9 = (fsm_output[2]) & (~ (fsm_output[6]));
  assign and_dcpl_10 = and_dcpl_9 & and_dcpl_2;
  assign and_dcpl_11 = (fsm_output[4:3]==2'b11);
  assign and_dcpl_13 = (fsm_output[7]) & (fsm_output[5]) & and_dcpl_11;
  assign nor_tmp_6 = (fsm_output[5:4]==2'b11);
  assign and_dcpl_19 = and_dcpl_9 & (fsm_output[1:0]==2'b11);
  assign and_dcpl_25 = and_dcpl_6 & (~ (fsm_output[4]));
  assign and_dcpl_28 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_31 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_34 = (fsm_output[7]) & (~ (fsm_output[5]));
  assign and_dcpl_37 = (fsm_output[1:0]==2'b10);
  assign mux_40_nl = MUX_s_1_2_2(nor_tmp_3, (~ or_32_cse), fsm_output[1]);
  assign and_dcpl_42 = mux_40_nl & (~ (fsm_output[5]));
  assign and_dcpl_56 = and_dcpl_6 & and_dcpl_11 & (fsm_output[2]) & (fsm_output[6])
      & and_dcpl_37;
  assign or_tmp_17 = and_82_cse | (fsm_output[4]) | (fsm_output[5]) | (~ (fsm_output[7]));
  assign or_tmp_18 = (~ (fsm_output[5])) | (fsm_output[7]);
  assign mux_tmp_31 = MUX_s_1_2_2(or_tmp_17, or_tmp_18, fsm_output[6]);
  assign or_tmp_22 = and_84_cse | (fsm_output[5]);
  assign not_tmp_29 = ~((((fsm_output[3:2]!=2'b00)) & (fsm_output[4])) | (fsm_output[5]));
  assign mux_tmp_41 = MUX_s_1_2_2(not_tmp_29, or_tmp_22, fsm_output[6]);
  assign and_dcpl_65 = and_dcpl_7 & and_dcpl_10;
  assign mux_65_nl = MUX_s_1_2_2(and_dcpl_7, and_dcpl_13, fsm_output[2]);
  assign mux_tmp_55 = MUX_s_1_2_2(mux_65_nl, (fsm_output[7]), fsm_output[6]);
  assign mux_tmp_64 = MUX_s_1_2_2(and_dcpl_7, (fsm_output[7]), fsm_output[6]);
  assign mux_tmp_65 = MUX_s_1_2_2(mux_tmp_64, mux_tmp_4, fsm_output[1]);
  assign or_dcpl_4 = (fsm_output[7]) | (fsm_output[5]);
  assign or_dcpl_7 = (fsm_output[1:0]!=2'b10);
  assign and_cse = (fsm_output[2]) & (fsm_output[3]) & (fsm_output[4]) & (fsm_output[5])
      & (fsm_output[7]);
  assign COPY_LOOP_1_i_10_0_sva_9_0_mx0c2 = mux_93_cse & (~ (fsm_output[6])) & (~
      (fsm_output[0]));
  assign vec_rsci_radr_d_pff = COPY_LOOP_1_i_10_0_sva_9_0;
  assign vec_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_7 & (~((fsm_output[2])
      | (fsm_output[6]))) & and_dcpl_2;
  assign result_rsci_d_d = modulo_dev_1_mux_itm;
  assign COMP_LOOP_nand_nl = ~(and_dcpl_13 & and_dcpl_10);
  assign result_rsci_wadr_d = {COMP_LOOP_nand_nl , COPY_LOOP_1_i_10_0_sva_1_8_0};
  assign nor_21_nl = ~((~ (fsm_output[1])) | (fsm_output[4]) | (fsm_output[5]));
  assign nor_22_nl = ~((fsm_output[1]) | (~ nor_tmp_6));
  assign mux_35_nl = MUX_s_1_2_2(nor_21_nl, nor_22_nl, fsm_output[0]);
  assign result_rsci_we_d_pff = mux_35_nl & (fsm_output[7]) & (fsm_output[3]) & and_dcpl_9;
  assign result_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_13 & and_dcpl_19;
  assign COMP_LOOP_if_and_nl = COPY_LOOP_1_i_10_0_sva_1_8_0 & STAGE_LOOP_base_8_0_sva;
  assign twiddle_rsci_radr_d = {1'b0 , COMP_LOOP_if_and_nl};
  assign twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_25 & (~ (fsm_output[3]))
      & (fsm_output[2]) & (~ (fsm_output[6])) & (~ (fsm_output[1])) & (fsm_output[0])
      & COMP_LOOP_COMP_LOOP_if_nor_tmp;
  assign and_38_nl = and_dcpl_34 & and_dcpl_5 & (~ (fsm_output[2])) & (fsm_output[6])
      & and_dcpl_31;
  assign xt_rsci_d_d = MUX_v_64_2_2(vec_rsci_q_d, result_rsci_q_d, and_38_nl);
  assign COPY_LOOP_COPY_LOOP_nand_nl = ~(and_dcpl_7 & and_dcpl_9 & and_dcpl_37);
  assign xt_rsci_radr_d = {COPY_LOOP_1_i_10_0_sva_1_8_0 , COPY_LOOP_COPY_LOOP_nand_nl};
  assign xt_rsci_we_d_pff = and_dcpl_42 & and_dcpl_5 & (~ (fsm_output[2])) & (~ (fsm_output[0]));
  assign xt_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_7 & and_dcpl_9 & ((fsm_output[1])
      ^ (fsm_output[0]));
  assign mux_89_nl = MUX_s_1_2_2(nor_tmp_6, and_dcpl_28, fsm_output[0]);
  assign and_dcpl_95 = mux_89_nl & (fsm_output[3]) & (fsm_output[7]) & (fsm_output[2])
      & (~((fsm_output[6]) | (fsm_output[1])));
  assign or_tmp = (fsm_output[2]) | (fsm_output[7]) | (fsm_output[5]) | (fsm_output[3])
      | (fsm_output[4]);
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_28_nl, mux_26_nl, fsm_output[0]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_xt_rsc_cgo_cse <= 1'b0;
      reg_vec_rsc_triosy_obj_ld_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
      COMP_LOOP_COMP_LOOP_if_nor_svs_st <= 1'b0;
    end
    else begin
      reg_xt_rsc_cgo_cse <= and_32_rmff;
      reg_vec_rsc_triosy_obj_ld_cse <= and_dcpl_34 & (~ (fsm_output[4])) & (~ (fsm_output[3]))
          & (~ (fsm_output[2])) & (fsm_output[6]) & (fsm_output[1]) & (~ (fsm_output[0]))
          & (z_out_2[4]);
      reg_ensig_cgo_cse <= and_63_rmff;
      COMP_LOOP_COMP_LOOP_if_nor_svs_st <= COMP_LOOP_COMP_LOOP_if_nor_tmp;
    end
  end
  always @(posedge clk) begin
    modulo_dev_result_rem_cmp_a_63_0 <= MUX1HOT_v_64_3_2(COMP_LOOP_acc_3_psp_mx0w0,
        COMP_LOOP_acc_3_psp, COMP_LOOP_acc_1_itm, {and_dcpl_56 , (~ mux_46_nl) ,
        and_60_nl});
    reg_modulo_dev_result_rem_cmp_b_63_0_cse <= p_sva;
    COMP_LOOP_f2_rem_cmp_a <= MUX_v_128_2_2(COMP_LOOP_f2_mul_cmp_z, COMP_LOOP_f2_mul_mut,
        nor_27_nl);
    modulo_dev_1_mux_itm <= MUX_v_64_2_2((modulo_dev_result_rem_cmp_z[63:0]), z_out_1,
        modulo_dev_result_rem_cmp_z[63]);
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_10_0_sva_9_0 <= 10'b0000000000;
    end
    else if ( (and_dcpl_42 & and_dcpl_5 & (~ (fsm_output[2])) & (fsm_output[0]))
        | and_dcpl_65 | COPY_LOOP_1_i_10_0_sva_9_0_mx0c2 ) begin
      COPY_LOOP_1_i_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, COPY_LOOP_1_i_mux_nl,
          COPY_LOOP_1_i_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_10_0_sva_1_10_9 <= 2'b00;
    end
    else if ( ~ mux_92_nl ) begin
      COPY_LOOP_1_i_10_0_sva_1_10_9 <= COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt[10:9];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_10_0_sva_1_8_0 <= 9'b000000000;
    end
    else if ( mux_95_nl & (~ (fsm_output[6])) ) begin
      COPY_LOOP_1_i_10_0_sva_1_8_0 <= COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt[8:0];
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_73_nl, mux_20_nl, fsm_output[0]) ) begin
      STAGE_LOOP_base_acc_cse_sva <= MUX_v_4_2_2(4'b1010, (z_out_2[3:0]), and_75_nl);
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_tmp_65, mux_79_nl, fsm_output[0]) ) begin
      STAGE_LOOP_base_8_0_sva <= STAGE_LOOP_base_lshift_itm;
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output!=8'b00000101) ) begin
      STAGE_LOOP_lst_sva <= MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000000,
          STAGE_LOOP_lst_sva_dfm, STAGE_LOOP_lst_nor_nl);
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_86_nl, mux_82_nl, fsm_output[0]) ) begin
      STAGE_LOOP_lst_sva_dfm <= COMP_LOOP_f2_mul_cmp_a_mx0;
    end
  end
  always @(posedge clk) begin
    if ( (and_dcpl_7 & and_dcpl_19) | and_dcpl_56 ) begin
      COMP_LOOP_acc_1_itm <= MUX_v_64_2_2(xt_rsci_q_d, z_out_1, and_dcpl_56);
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_4 | (~ (fsm_output[4])) | (fsm_output[3]) | (fsm_output[2]) |
        (fsm_output[6]) | or_dcpl_7) ) begin
      COMP_LOOP_f2_mul_mut <= COMP_LOOP_f2_mul_cmp_z;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_4 | (~ (fsm_output[4])) | (~ (fsm_output[3])) | (~ (fsm_output[2]))
        | (~ (fsm_output[6])) | or_dcpl_7) ) begin
      COMP_LOOP_acc_3_psp <= COMP_LOOP_acc_3_psp_mx0w0;
    end
  end
  assign mux_28_nl = MUX_s_1_2_2(mux_tmp_8, and_tmp, fsm_output[1]);
  assign mux_26_nl = MUX_s_1_2_2(and_tmp, nor_tmp_3, fsm_output[1]);
  assign or_21_nl = (fsm_output[4]) | (fsm_output[5]) | (~ (fsm_output[7]));
  assign mux_44_nl = MUX_s_1_2_2(or_21_nl, or_tmp_18, fsm_output[6]);
  assign mux_45_nl = MUX_s_1_2_2(mux_44_nl, mux_tmp_31, fsm_output[1]);
  assign or_16_nl = (~(and_84_cse | (fsm_output[5]))) | (fsm_output[7]);
  assign mux_41_nl = MUX_s_1_2_2(or_tmp_17, or_16_nl, fsm_output[6]);
  assign mux_43_nl = MUX_s_1_2_2(mux_tmp_31, mux_41_nl, fsm_output[1]);
  assign mux_46_nl = MUX_s_1_2_2(mux_45_nl, mux_43_nl, fsm_output[0]);
  assign mux_48_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[4]);
  assign mux_49_nl = MUX_s_1_2_2(and_dcpl_28, mux_48_nl, and_82_cse);
  assign mux_47_nl = MUX_s_1_2_2(and_dcpl_28, nor_tmp_6, and_82_cse);
  assign or_22_nl = (fsm_output[1:0]!=2'b00);
  assign mux_50_nl = MUX_s_1_2_2(mux_49_nl, mux_47_nl, or_22_nl);
  assign and_60_nl = (~ mux_50_nl) & (fsm_output[7:6]==2'b10);
  assign mux_54_nl = MUX_s_1_2_2(not_tmp_29, (fsm_output[5]), fsm_output[6]);
  assign mux_55_nl = MUX_s_1_2_2(mux_54_nl, mux_tmp_41, fsm_output[1]);
  assign mux_51_nl = MUX_s_1_2_2(and_dcpl_28, or_tmp_22, fsm_output[6]);
  assign mux_53_nl = MUX_s_1_2_2(mux_tmp_41, mux_51_nl, fsm_output[1]);
  assign mux_56_nl = MUX_s_1_2_2(mux_55_nl, mux_53_nl, fsm_output[0]);
  assign nor_27_nl = ~(mux_56_nl | (fsm_output[7]));
  assign COPY_LOOP_1_i_mux_nl = MUX_v_10_2_2(({(COPY_LOOP_1_i_10_0_sva_1_10_9[0])
      , COPY_LOOP_1_i_10_0_sva_1_8_0}), (z_out[9:0]), and_dcpl_65);
  assign COPY_LOOP_1_i_not_nl = ~ COPY_LOOP_1_i_10_0_sva_9_0_mx0c2;
  assign mux_91_nl = MUX_s_1_2_2((~ or_tmp), (fsm_output[7]), fsm_output[6]);
  assign nand_nl = ~((fsm_output[2]) & (fsm_output[7]) & (fsm_output[5]) & (fsm_output[3])
      & (fsm_output[4]));
  assign mux_nl = MUX_s_1_2_2(nand_nl, or_tmp, fsm_output[1]);
  assign mux_90_nl = MUX_s_1_2_2((~ mux_nl), (fsm_output[7]), fsm_output[6]);
  assign mux_92_nl = MUX_s_1_2_2(mux_91_nl, mux_90_nl, fsm_output[0]);
  assign nor_41_nl = ~((~ (fsm_output[2])) | (fsm_output[7]) | (fsm_output[5]) |
      (fsm_output[3]) | (fsm_output[4]));
  assign mux_94_nl = MUX_s_1_2_2(nor_41_nl, and_cse, fsm_output[1]);
  assign mux_95_nl = MUX_s_1_2_2(mux_94_nl, mux_93_cse, fsm_output[0]);
  assign and_75_nl = and_dcpl_7 & and_dcpl_9 & and_dcpl_31;
  assign mux_72_nl = MUX_s_1_2_2(and_dcpl_7, nor_tmp_2, fsm_output[6]);
  assign mux_73_nl = MUX_s_1_2_2(mux_72_nl, mux_tmp_8, fsm_output[1]);
  assign mux_20_nl = MUX_s_1_2_2(mux_tmp_8, mux_tmp_4, fsm_output[1]);
  assign mux_79_nl = MUX_s_1_2_2(mux_tmp_4, mux_tmp_55, fsm_output[1]);
  assign nand_1_nl = ~((fsm_output[1]) & (fsm_output[3]) & (fsm_output[4]) & (fsm_output[5])
      & (fsm_output[7]));
  assign or_38_nl = (fsm_output[1]) | (fsm_output[3]) | (fsm_output[4]) | (fsm_output[5])
      | (fsm_output[7]);
  assign mux_81_nl = MUX_s_1_2_2(nand_1_nl, or_38_nl, fsm_output[0]);
  assign STAGE_LOOP_lst_nor_nl = ~(mux_81_nl | (~ (fsm_output[2])) | (fsm_output[6]));
  assign and_78_nl = (fsm_output[4]) & (fsm_output[5]) & (fsm_output[7]);
  assign mux_83_nl = MUX_s_1_2_2(and_dcpl_25, and_78_nl, fsm_output[3]);
  assign mux_84_nl = MUX_s_1_2_2(and_dcpl_7, mux_83_nl, fsm_output[2]);
  assign mux_85_nl = MUX_s_1_2_2(mux_84_nl, (fsm_output[7]), fsm_output[6]);
  assign mux_86_nl = MUX_s_1_2_2(mux_tmp_64, mux_85_nl, fsm_output[1]);
  assign mux_82_nl = MUX_s_1_2_2(mux_tmp_64, mux_tmp_55, fsm_output[1]);
  assign and_132_nl = and_dcpl_28 & (~((fsm_output[3]) | (fsm_output[7]))) & (fsm_output[2])
      & (~ (fsm_output[6])) & (~ (fsm_output[1])) & (fsm_output[0]);
  assign COPY_LOOP_1_mux_1_nl = MUX_v_10_2_2(COPY_LOOP_1_i_10_0_sva_9_0, ({1'b0 ,
      COPY_LOOP_1_i_10_0_sva_1_8_0}), and_132_nl);
  assign nl_z_out = conv_u2u_10_11(COPY_LOOP_1_mux_1_nl) + 11'b00000000001;
  assign z_out = nl_z_out[10:0];
  assign COMP_LOOP_mux_3_nl = MUX_v_64_2_2(COMP_LOOP_acc_1_itm, (modulo_dev_result_rem_cmp_z[63:0]),
      and_dcpl_95);
  assign COMP_LOOP_mux_4_nl = MUX_v_64_2_2(COMP_LOOP_f2_rem_cmp_z_oreg, p_sva, and_dcpl_95);
  assign nl_z_out_1 = COMP_LOOP_mux_3_nl + COMP_LOOP_mux_4_nl;
  assign z_out_1 = nl_z_out_1[63:0];
  assign nl_z_out_2 = conv_u2u_4_5(STAGE_LOOP_base_acc_cse_sva) + 5'b11111;
  assign z_out_2 = nl_z_out_2[4:0];

  function automatic [63:0] MUX1HOT_v_64_3_2;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [2:0] sel;
    reg [63:0] result;
  begin
    result = input_0 & {64{sel[0]}};
    result = result | ( input_1 & {64{sel[1]}});
    result = result | ( input_2 & {64{sel[2]}});
    MUX1HOT_v_64_3_2 = result;
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


  function automatic [127:0] MUX_v_128_2_2;
    input [127:0] input_0;
    input [127:0] input_1;
    input [0:0] sel;
    reg [127:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_128_2_2 = result;
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


  function automatic [63:0] MUX_v_64_2_2;
    input [63:0] input_0;
    input [63:0] input_1;
    input [0:0] sel;
    reg [63:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_64_2_2 = result;
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


  function automatic [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT
// ------------------------------------------------------------------


module peaceNTT (
  clk, rst, vec_rsc_radr, vec_rsc_q, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz,
      g_rsc_dat, g_rsc_triosy_lz, result_rsc_wadr, result_rsc_d, result_rsc_we, result_rsc_radr,
      result_rsc_q, result_rsc_triosy_lz, twiddle_rsc_radr, twiddle_rsc_q, twiddle_rsc_triosy_lz
);
  input clk;
  input rst;
  output [9:0] vec_rsc_radr;
  input [63:0] vec_rsc_q;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] g_rsc_dat;
  output g_rsc_triosy_lz;
  output [9:0] result_rsc_wadr;
  output [63:0] result_rsc_d;
  output result_rsc_we;
  output [9:0] result_rsc_radr;
  input [63:0] result_rsc_q;
  output result_rsc_triosy_lz;
  output [9:0] twiddle_rsc_radr;
  input [63:0] twiddle_rsc_q;
  output twiddle_rsc_triosy_lz;


  // Interconnect Declarations
  wire [63:0] vec_rsci_q_d;
  wire vec_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] result_rsci_d_d;
  wire [63:0] result_rsci_q_d;
  wire [9:0] result_rsci_wadr_d;
  wire result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_rsci_q_d;
  wire [9:0] twiddle_rsci_radr_d;
  wire twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire xt_rsci_clken_d;
  wire [63:0] xt_rsci_d_d;
  wire [63:0] xt_rsci_q_d;
  wire [9:0] xt_rsci_radr_d;
  wire xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [127:0] COMP_LOOP_f2_rem_cmp_a;
  wire [63:0] COMP_LOOP_f2_rem_cmp_b;
  wire [63:0] COMP_LOOP_f2_rem_cmp_z;
  wire xt_rsc_clken;
  wire [63:0] xt_rsc_q;
  wire [9:0] xt_rsc_radr;
  wire xt_rsc_we;
  wire [63:0] xt_rsc_d;
  wire [9:0] xt_rsc_wadr;
  wire [9:0] vec_rsci_radr_d_iff;
  wire result_rsci_we_d_iff;
  wire xt_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  mgc_rem #(.width_a(32'sd128),
  .width_b(32'sd64),
  .signd(32'sd0)) COMP_LOOP_f2_rem_cmp (
      .a(COMP_LOOP_f2_rem_cmp_a),
      .b(COMP_LOOP_f2_rem_cmp_b),
      .z(COMP_LOOP_f2_rem_cmp_z)
    );
  BLOCK_1R1W_RBW #(.addr_width(32'sd10),
  .data_width(32'sd64),
  .depth(32'sd1024),
  .latency(32'sd1)) xt_rsc_comp (
      .clk(clk),
      .clken(xt_rsc_clken),
      .d(xt_rsc_d),
      .q(xt_rsc_q),
      .radr(xt_rsc_radr),
      .wadr(xt_rsc_wadr),
      .we(xt_rsc_we)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_1_10_64_1024_1024_64_1_gen vec_rsci (
      .q(vec_rsc_q),
      .radr(vec_rsc_radr),
      .q_d(vec_rsci_q_d),
      .radr_d(vec_rsci_radr_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(vec_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen result_rsci
      (
      .q(result_rsc_q),
      .radr(result_rsc_radr),
      .we(result_rsc_we),
      .d(result_rsc_d),
      .wadr(result_rsc_wadr),
      .d_d(result_rsci_d_d),
      .q_d(result_rsci_q_d),
      .radr_d(vec_rsci_radr_d_iff),
      .wadr_d(result_rsci_wadr_d),
      .we_d(result_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(result_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(result_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_5_10_64_1024_1024_64_1_gen twiddle_rsci
      (
      .q(twiddle_rsc_q),
      .radr(twiddle_rsc_radr),
      .q_d(twiddle_rsci_q_d),
      .radr_d(twiddle_rsci_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_10_64_1024_1024_64_1_gen xt_rsci
      (
      .clken(xt_rsc_clken),
      .q(xt_rsc_q),
      .radr(xt_rsc_radr),
      .we(xt_rsc_we),
      .d(xt_rsc_d),
      .wadr(xt_rsc_wadr),
      .clken_d(xt_rsci_clken_d),
      .d_d(xt_rsci_d_d),
      .q_d(xt_rsci_q_d),
      .radr_d(xt_rsci_radr_d),
      .wadr_d(vec_rsci_radr_d_iff),
      .we_d(xt_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(xt_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(xt_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  peaceNTT_core peaceNTT_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .g_rsc_triosy_lz(g_rsc_triosy_lz),
      .result_rsc_triosy_lz(result_rsc_triosy_lz),
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .vec_rsci_q_d(vec_rsci_q_d),
      .vec_rsci_readA_r_ram_ir_internal_RMASK_B_d(vec_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .result_rsci_d_d(result_rsci_d_d),
      .result_rsci_q_d(result_rsci_q_d),
      .result_rsci_wadr_d(result_rsci_wadr_d),
      .result_rsci_readA_r_ram_ir_internal_RMASK_B_d(result_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsci_q_d(twiddle_rsci_q_d),
      .twiddle_rsci_radr_d(twiddle_rsci_radr_d),
      .twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .xt_rsci_clken_d(xt_rsci_clken_d),
      .xt_rsci_d_d(xt_rsci_d_d),
      .xt_rsci_q_d(xt_rsci_q_d),
      .xt_rsci_radr_d(xt_rsci_radr_d),
      .xt_rsci_readA_r_ram_ir_internal_RMASK_B_d(xt_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .COMP_LOOP_f2_rem_cmp_a(COMP_LOOP_f2_rem_cmp_a),
      .COMP_LOOP_f2_rem_cmp_b(COMP_LOOP_f2_rem_cmp_b),
      .COMP_LOOP_f2_rem_cmp_z(COMP_LOOP_f2_rem_cmp_z),
      .vec_rsci_radr_d_pff(vec_rsci_radr_d_iff),
      .result_rsci_we_d_pff(result_rsci_we_d_iff),
      .xt_rsci_we_d_pff(xt_rsci_we_d_iff)
    );
endmodule



