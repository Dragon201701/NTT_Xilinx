
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
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Jun 10 12:10:22 2021
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
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_10_64_1024_1024_64_1_gen (
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
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_2R1W_WBR_DUAL_rport_1_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_2R1W_WBR_DUAL_rport_1_10_64_1024_1024_64_1_gen
    (
  qb, adrb, adrb_d, qb_d, readB_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] qb;
  output [9:0] adrb;
  input [9:0] adrb_d;
  output [63:0] qb_d;
  input readB_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qb_d = qb;
  assign adrb = (adrb_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module peaceNTT_core_core_fsm (
  clk, rst, fsm_output, main_C_7_tr0, MODEXP_WHILE_C_24_tr0, TWIDDLE_LOOP_C_24_tr0,
      COPY_LOOP_C_2_tr0, COMP_LOOP_C_76_tr0, COPY_LOOP_1_C_2_tr0, STAGE_LOOP_C_0_tr0
);
  input clk;
  input rst;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input main_C_7_tr0;
  input MODEXP_WHILE_C_24_tr0;
  input TWIDDLE_LOOP_C_24_tr0;
  input COPY_LOOP_C_2_tr0;
  input COMP_LOOP_C_76_tr0;
  input COPY_LOOP_1_C_2_tr0;
  input STAGE_LOOP_C_0_tr0;


  // FSM State Type Declaration for peaceNTT_core_core_fsm_1
  parameter
    main_C_0 = 8'd0,
    main_C_1 = 8'd1,
    main_C_2 = 8'd2,
    main_C_3 = 8'd3,
    main_C_4 = 8'd4,
    main_C_5 = 8'd5,
    main_C_6 = 8'd6,
    main_C_7 = 8'd7,
    MODEXP_WHILE_C_0 = 8'd8,
    MODEXP_WHILE_C_1 = 8'd9,
    MODEXP_WHILE_C_2 = 8'd10,
    MODEXP_WHILE_C_3 = 8'd11,
    MODEXP_WHILE_C_4 = 8'd12,
    MODEXP_WHILE_C_5 = 8'd13,
    MODEXP_WHILE_C_6 = 8'd14,
    MODEXP_WHILE_C_7 = 8'd15,
    MODEXP_WHILE_C_8 = 8'd16,
    MODEXP_WHILE_C_9 = 8'd17,
    MODEXP_WHILE_C_10 = 8'd18,
    MODEXP_WHILE_C_11 = 8'd19,
    MODEXP_WHILE_C_12 = 8'd20,
    MODEXP_WHILE_C_13 = 8'd21,
    MODEXP_WHILE_C_14 = 8'd22,
    MODEXP_WHILE_C_15 = 8'd23,
    MODEXP_WHILE_C_16 = 8'd24,
    MODEXP_WHILE_C_17 = 8'd25,
    MODEXP_WHILE_C_18 = 8'd26,
    MODEXP_WHILE_C_19 = 8'd27,
    MODEXP_WHILE_C_20 = 8'd28,
    MODEXP_WHILE_C_21 = 8'd29,
    MODEXP_WHILE_C_22 = 8'd30,
    MODEXP_WHILE_C_23 = 8'd31,
    MODEXP_WHILE_C_24 = 8'd32,
    TWIDDLE_LOOP_C_0 = 8'd33,
    TWIDDLE_LOOP_C_1 = 8'd34,
    TWIDDLE_LOOP_C_2 = 8'd35,
    TWIDDLE_LOOP_C_3 = 8'd36,
    TWIDDLE_LOOP_C_4 = 8'd37,
    TWIDDLE_LOOP_C_5 = 8'd38,
    TWIDDLE_LOOP_C_6 = 8'd39,
    TWIDDLE_LOOP_C_7 = 8'd40,
    TWIDDLE_LOOP_C_8 = 8'd41,
    TWIDDLE_LOOP_C_9 = 8'd42,
    TWIDDLE_LOOP_C_10 = 8'd43,
    TWIDDLE_LOOP_C_11 = 8'd44,
    TWIDDLE_LOOP_C_12 = 8'd45,
    TWIDDLE_LOOP_C_13 = 8'd46,
    TWIDDLE_LOOP_C_14 = 8'd47,
    TWIDDLE_LOOP_C_15 = 8'd48,
    TWIDDLE_LOOP_C_16 = 8'd49,
    TWIDDLE_LOOP_C_17 = 8'd50,
    TWIDDLE_LOOP_C_18 = 8'd51,
    TWIDDLE_LOOP_C_19 = 8'd52,
    TWIDDLE_LOOP_C_20 = 8'd53,
    TWIDDLE_LOOP_C_21 = 8'd54,
    TWIDDLE_LOOP_C_22 = 8'd55,
    TWIDDLE_LOOP_C_23 = 8'd56,
    TWIDDLE_LOOP_C_24 = 8'd57,
    COPY_LOOP_C_0 = 8'd58,
    COPY_LOOP_C_1 = 8'd59,
    COPY_LOOP_C_2 = 8'd60,
    COMP_LOOP_C_0 = 8'd61,
    COMP_LOOP_C_1 = 8'd62,
    COMP_LOOP_C_2 = 8'd63,
    COMP_LOOP_C_3 = 8'd64,
    COMP_LOOP_C_4 = 8'd65,
    COMP_LOOP_C_5 = 8'd66,
    COMP_LOOP_C_6 = 8'd67,
    COMP_LOOP_C_7 = 8'd68,
    COMP_LOOP_C_8 = 8'd69,
    COMP_LOOP_C_9 = 8'd70,
    COMP_LOOP_C_10 = 8'd71,
    COMP_LOOP_C_11 = 8'd72,
    COMP_LOOP_C_12 = 8'd73,
    COMP_LOOP_C_13 = 8'd74,
    COMP_LOOP_C_14 = 8'd75,
    COMP_LOOP_C_15 = 8'd76,
    COMP_LOOP_C_16 = 8'd77,
    COMP_LOOP_C_17 = 8'd78,
    COMP_LOOP_C_18 = 8'd79,
    COMP_LOOP_C_19 = 8'd80,
    COMP_LOOP_C_20 = 8'd81,
    COMP_LOOP_C_21 = 8'd82,
    COMP_LOOP_C_22 = 8'd83,
    COMP_LOOP_C_23 = 8'd84,
    COMP_LOOP_C_24 = 8'd85,
    COMP_LOOP_C_25 = 8'd86,
    COMP_LOOP_C_26 = 8'd87,
    COMP_LOOP_C_27 = 8'd88,
    COMP_LOOP_C_28 = 8'd89,
    COMP_LOOP_C_29 = 8'd90,
    COMP_LOOP_C_30 = 8'd91,
    COMP_LOOP_C_31 = 8'd92,
    COMP_LOOP_C_32 = 8'd93,
    COMP_LOOP_C_33 = 8'd94,
    COMP_LOOP_C_34 = 8'd95,
    COMP_LOOP_C_35 = 8'd96,
    COMP_LOOP_C_36 = 8'd97,
    COMP_LOOP_C_37 = 8'd98,
    COMP_LOOP_C_38 = 8'd99,
    COMP_LOOP_C_39 = 8'd100,
    COMP_LOOP_C_40 = 8'd101,
    COMP_LOOP_C_41 = 8'd102,
    COMP_LOOP_C_42 = 8'd103,
    COMP_LOOP_C_43 = 8'd104,
    COMP_LOOP_C_44 = 8'd105,
    COMP_LOOP_C_45 = 8'd106,
    COMP_LOOP_C_46 = 8'd107,
    COMP_LOOP_C_47 = 8'd108,
    COMP_LOOP_C_48 = 8'd109,
    COMP_LOOP_C_49 = 8'd110,
    COMP_LOOP_C_50 = 8'd111,
    COMP_LOOP_C_51 = 8'd112,
    COMP_LOOP_C_52 = 8'd113,
    COMP_LOOP_C_53 = 8'd114,
    COMP_LOOP_C_54 = 8'd115,
    COMP_LOOP_C_55 = 8'd116,
    COMP_LOOP_C_56 = 8'd117,
    COMP_LOOP_C_57 = 8'd118,
    COMP_LOOP_C_58 = 8'd119,
    COMP_LOOP_C_59 = 8'd120,
    COMP_LOOP_C_60 = 8'd121,
    COMP_LOOP_C_61 = 8'd122,
    COMP_LOOP_C_62 = 8'd123,
    COMP_LOOP_C_63 = 8'd124,
    COMP_LOOP_C_64 = 8'd125,
    COMP_LOOP_C_65 = 8'd126,
    COMP_LOOP_C_66 = 8'd127,
    COMP_LOOP_C_67 = 8'd128,
    COMP_LOOP_C_68 = 8'd129,
    COMP_LOOP_C_69 = 8'd130,
    COMP_LOOP_C_70 = 8'd131,
    COMP_LOOP_C_71 = 8'd132,
    COMP_LOOP_C_72 = 8'd133,
    COMP_LOOP_C_73 = 8'd134,
    COMP_LOOP_C_74 = 8'd135,
    COMP_LOOP_C_75 = 8'd136,
    COMP_LOOP_C_76 = 8'd137,
    COPY_LOOP_1_C_0 = 8'd138,
    COPY_LOOP_1_C_1 = 8'd139,
    COPY_LOOP_1_C_2 = 8'd140,
    STAGE_LOOP_C_0 = 8'd141,
    main_C_8 = 8'd142;

  reg [7:0] state_var;
  reg [7:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : peaceNTT_core_core_fsm_1
    case (state_var)
      main_C_1 : begin
        fsm_output = 8'b00000001;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 8'b00000010;
        state_var_NS = main_C_3;
      end
      main_C_3 : begin
        fsm_output = 8'b00000011;
        state_var_NS = main_C_4;
      end
      main_C_4 : begin
        fsm_output = 8'b00000100;
        state_var_NS = main_C_5;
      end
      main_C_5 : begin
        fsm_output = 8'b00000101;
        state_var_NS = main_C_6;
      end
      main_C_6 : begin
        fsm_output = 8'b00000110;
        state_var_NS = main_C_7;
      end
      main_C_7 : begin
        fsm_output = 8'b00000111;
        if ( main_C_7_tr0 ) begin
          state_var_NS = TWIDDLE_LOOP_C_0;
        end
        else begin
          state_var_NS = MODEXP_WHILE_C_0;
        end
      end
      MODEXP_WHILE_C_0 : begin
        fsm_output = 8'b00001000;
        state_var_NS = MODEXP_WHILE_C_1;
      end
      MODEXP_WHILE_C_1 : begin
        fsm_output = 8'b00001001;
        state_var_NS = MODEXP_WHILE_C_2;
      end
      MODEXP_WHILE_C_2 : begin
        fsm_output = 8'b00001010;
        state_var_NS = MODEXP_WHILE_C_3;
      end
      MODEXP_WHILE_C_3 : begin
        fsm_output = 8'b00001011;
        state_var_NS = MODEXP_WHILE_C_4;
      end
      MODEXP_WHILE_C_4 : begin
        fsm_output = 8'b00001100;
        state_var_NS = MODEXP_WHILE_C_5;
      end
      MODEXP_WHILE_C_5 : begin
        fsm_output = 8'b00001101;
        state_var_NS = MODEXP_WHILE_C_6;
      end
      MODEXP_WHILE_C_6 : begin
        fsm_output = 8'b00001110;
        state_var_NS = MODEXP_WHILE_C_7;
      end
      MODEXP_WHILE_C_7 : begin
        fsm_output = 8'b00001111;
        state_var_NS = MODEXP_WHILE_C_8;
      end
      MODEXP_WHILE_C_8 : begin
        fsm_output = 8'b00010000;
        state_var_NS = MODEXP_WHILE_C_9;
      end
      MODEXP_WHILE_C_9 : begin
        fsm_output = 8'b00010001;
        state_var_NS = MODEXP_WHILE_C_10;
      end
      MODEXP_WHILE_C_10 : begin
        fsm_output = 8'b00010010;
        state_var_NS = MODEXP_WHILE_C_11;
      end
      MODEXP_WHILE_C_11 : begin
        fsm_output = 8'b00010011;
        state_var_NS = MODEXP_WHILE_C_12;
      end
      MODEXP_WHILE_C_12 : begin
        fsm_output = 8'b00010100;
        state_var_NS = MODEXP_WHILE_C_13;
      end
      MODEXP_WHILE_C_13 : begin
        fsm_output = 8'b00010101;
        state_var_NS = MODEXP_WHILE_C_14;
      end
      MODEXP_WHILE_C_14 : begin
        fsm_output = 8'b00010110;
        state_var_NS = MODEXP_WHILE_C_15;
      end
      MODEXP_WHILE_C_15 : begin
        fsm_output = 8'b00010111;
        state_var_NS = MODEXP_WHILE_C_16;
      end
      MODEXP_WHILE_C_16 : begin
        fsm_output = 8'b00011000;
        state_var_NS = MODEXP_WHILE_C_17;
      end
      MODEXP_WHILE_C_17 : begin
        fsm_output = 8'b00011001;
        state_var_NS = MODEXP_WHILE_C_18;
      end
      MODEXP_WHILE_C_18 : begin
        fsm_output = 8'b00011010;
        state_var_NS = MODEXP_WHILE_C_19;
      end
      MODEXP_WHILE_C_19 : begin
        fsm_output = 8'b00011011;
        state_var_NS = MODEXP_WHILE_C_20;
      end
      MODEXP_WHILE_C_20 : begin
        fsm_output = 8'b00011100;
        state_var_NS = MODEXP_WHILE_C_21;
      end
      MODEXP_WHILE_C_21 : begin
        fsm_output = 8'b00011101;
        state_var_NS = MODEXP_WHILE_C_22;
      end
      MODEXP_WHILE_C_22 : begin
        fsm_output = 8'b00011110;
        state_var_NS = MODEXP_WHILE_C_23;
      end
      MODEXP_WHILE_C_23 : begin
        fsm_output = 8'b00011111;
        state_var_NS = MODEXP_WHILE_C_24;
      end
      MODEXP_WHILE_C_24 : begin
        fsm_output = 8'b00100000;
        if ( MODEXP_WHILE_C_24_tr0 ) begin
          state_var_NS = TWIDDLE_LOOP_C_0;
        end
        else begin
          state_var_NS = MODEXP_WHILE_C_0;
        end
      end
      TWIDDLE_LOOP_C_0 : begin
        fsm_output = 8'b00100001;
        state_var_NS = TWIDDLE_LOOP_C_1;
      end
      TWIDDLE_LOOP_C_1 : begin
        fsm_output = 8'b00100010;
        state_var_NS = TWIDDLE_LOOP_C_2;
      end
      TWIDDLE_LOOP_C_2 : begin
        fsm_output = 8'b00100011;
        state_var_NS = TWIDDLE_LOOP_C_3;
      end
      TWIDDLE_LOOP_C_3 : begin
        fsm_output = 8'b00100100;
        state_var_NS = TWIDDLE_LOOP_C_4;
      end
      TWIDDLE_LOOP_C_4 : begin
        fsm_output = 8'b00100101;
        state_var_NS = TWIDDLE_LOOP_C_5;
      end
      TWIDDLE_LOOP_C_5 : begin
        fsm_output = 8'b00100110;
        state_var_NS = TWIDDLE_LOOP_C_6;
      end
      TWIDDLE_LOOP_C_6 : begin
        fsm_output = 8'b00100111;
        state_var_NS = TWIDDLE_LOOP_C_7;
      end
      TWIDDLE_LOOP_C_7 : begin
        fsm_output = 8'b00101000;
        state_var_NS = TWIDDLE_LOOP_C_8;
      end
      TWIDDLE_LOOP_C_8 : begin
        fsm_output = 8'b00101001;
        state_var_NS = TWIDDLE_LOOP_C_9;
      end
      TWIDDLE_LOOP_C_9 : begin
        fsm_output = 8'b00101010;
        state_var_NS = TWIDDLE_LOOP_C_10;
      end
      TWIDDLE_LOOP_C_10 : begin
        fsm_output = 8'b00101011;
        state_var_NS = TWIDDLE_LOOP_C_11;
      end
      TWIDDLE_LOOP_C_11 : begin
        fsm_output = 8'b00101100;
        state_var_NS = TWIDDLE_LOOP_C_12;
      end
      TWIDDLE_LOOP_C_12 : begin
        fsm_output = 8'b00101101;
        state_var_NS = TWIDDLE_LOOP_C_13;
      end
      TWIDDLE_LOOP_C_13 : begin
        fsm_output = 8'b00101110;
        state_var_NS = TWIDDLE_LOOP_C_14;
      end
      TWIDDLE_LOOP_C_14 : begin
        fsm_output = 8'b00101111;
        state_var_NS = TWIDDLE_LOOP_C_15;
      end
      TWIDDLE_LOOP_C_15 : begin
        fsm_output = 8'b00110000;
        state_var_NS = TWIDDLE_LOOP_C_16;
      end
      TWIDDLE_LOOP_C_16 : begin
        fsm_output = 8'b00110001;
        state_var_NS = TWIDDLE_LOOP_C_17;
      end
      TWIDDLE_LOOP_C_17 : begin
        fsm_output = 8'b00110010;
        state_var_NS = TWIDDLE_LOOP_C_18;
      end
      TWIDDLE_LOOP_C_18 : begin
        fsm_output = 8'b00110011;
        state_var_NS = TWIDDLE_LOOP_C_19;
      end
      TWIDDLE_LOOP_C_19 : begin
        fsm_output = 8'b00110100;
        state_var_NS = TWIDDLE_LOOP_C_20;
      end
      TWIDDLE_LOOP_C_20 : begin
        fsm_output = 8'b00110101;
        state_var_NS = TWIDDLE_LOOP_C_21;
      end
      TWIDDLE_LOOP_C_21 : begin
        fsm_output = 8'b00110110;
        state_var_NS = TWIDDLE_LOOP_C_22;
      end
      TWIDDLE_LOOP_C_22 : begin
        fsm_output = 8'b00110111;
        state_var_NS = TWIDDLE_LOOP_C_23;
      end
      TWIDDLE_LOOP_C_23 : begin
        fsm_output = 8'b00111000;
        state_var_NS = TWIDDLE_LOOP_C_24;
      end
      TWIDDLE_LOOP_C_24 : begin
        fsm_output = 8'b00111001;
        if ( TWIDDLE_LOOP_C_24_tr0 ) begin
          state_var_NS = COPY_LOOP_C_0;
        end
        else begin
          state_var_NS = TWIDDLE_LOOP_C_0;
        end
      end
      COPY_LOOP_C_0 : begin
        fsm_output = 8'b00111010;
        state_var_NS = COPY_LOOP_C_1;
      end
      COPY_LOOP_C_1 : begin
        fsm_output = 8'b00111011;
        state_var_NS = COPY_LOOP_C_2;
      end
      COPY_LOOP_C_2 : begin
        fsm_output = 8'b00111100;
        if ( COPY_LOOP_C_2_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = COPY_LOOP_C_0;
        end
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 8'b00111101;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 8'b00111110;
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 8'b00111111;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 8'b01000000;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 8'b01000001;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 8'b01000010;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 8'b01000011;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 8'b01000100;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 8'b01000101;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 8'b01000110;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 8'b01000111;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 8'b01001000;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 8'b01001001;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 8'b01001010;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 8'b01001011;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 8'b01001100;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 8'b01001101;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 8'b01001110;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 8'b01001111;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 8'b01010000;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 8'b01010001;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 8'b01010010;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 8'b01010011;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 8'b01010100;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 8'b01010101;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 8'b01010110;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 8'b01010111;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 8'b01011000;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 8'b01011001;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 8'b01011010;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 8'b01011011;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 8'b01011100;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 8'b01011101;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 8'b01011110;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 8'b01011111;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 8'b01100000;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 8'b01100001;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 8'b01100010;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 8'b01100011;
        state_var_NS = COMP_LOOP_C_39;
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 8'b01100100;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 8'b01100101;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 8'b01100110;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 8'b01100111;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 8'b01101000;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 8'b01101001;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 8'b01101010;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 8'b01101011;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 8'b01101100;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 8'b01101101;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 8'b01101110;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 8'b01101111;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 8'b01110000;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 8'b01110001;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 8'b01110010;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 8'b01110011;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 8'b01110100;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 8'b01110101;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 8'b01110110;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 8'b01110111;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 8'b01111000;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 8'b01111001;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 8'b01111010;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 8'b01111011;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 8'b01111100;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 8'b01111101;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 8'b01111110;
        state_var_NS = COMP_LOOP_C_66;
      end
      COMP_LOOP_C_66 : begin
        fsm_output = 8'b01111111;
        state_var_NS = COMP_LOOP_C_67;
      end
      COMP_LOOP_C_67 : begin
        fsm_output = 8'b10000000;
        state_var_NS = COMP_LOOP_C_68;
      end
      COMP_LOOP_C_68 : begin
        fsm_output = 8'b10000001;
        state_var_NS = COMP_LOOP_C_69;
      end
      COMP_LOOP_C_69 : begin
        fsm_output = 8'b10000010;
        state_var_NS = COMP_LOOP_C_70;
      end
      COMP_LOOP_C_70 : begin
        fsm_output = 8'b10000011;
        state_var_NS = COMP_LOOP_C_71;
      end
      COMP_LOOP_C_71 : begin
        fsm_output = 8'b10000100;
        state_var_NS = COMP_LOOP_C_72;
      end
      COMP_LOOP_C_72 : begin
        fsm_output = 8'b10000101;
        state_var_NS = COMP_LOOP_C_73;
      end
      COMP_LOOP_C_73 : begin
        fsm_output = 8'b10000110;
        state_var_NS = COMP_LOOP_C_74;
      end
      COMP_LOOP_C_74 : begin
        fsm_output = 8'b10000111;
        state_var_NS = COMP_LOOP_C_75;
      end
      COMP_LOOP_C_75 : begin
        fsm_output = 8'b10001000;
        state_var_NS = COMP_LOOP_C_76;
      end
      COMP_LOOP_C_76 : begin
        fsm_output = 8'b10001001;
        if ( COMP_LOOP_C_76_tr0 ) begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      COPY_LOOP_1_C_0 : begin
        fsm_output = 8'b10001010;
        state_var_NS = COPY_LOOP_1_C_1;
      end
      COPY_LOOP_1_C_1 : begin
        fsm_output = 8'b10001011;
        state_var_NS = COPY_LOOP_1_C_2;
      end
      COPY_LOOP_1_C_2 : begin
        fsm_output = 8'b10001100;
        if ( COPY_LOOP_1_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_0;
        end
        else begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
      end
      STAGE_LOOP_C_0 : begin
        fsm_output = 8'b10001101;
        if ( STAGE_LOOP_C_0_tr0 ) begin
          state_var_NS = main_C_8;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      main_C_8 : begin
        fsm_output = 8'b10001110;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 8'b00000000;
        state_var_NS = main_C_1;
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
  twiddle_rsc_cgo_iro, twiddle_rsci_clken_d, xt_rsc_cgo_iro, xt_rsci_clken_d, twiddle_rsc_cgo,
      xt_rsc_cgo
);
  input twiddle_rsc_cgo_iro;
  output twiddle_rsci_clken_d;
  input xt_rsc_cgo_iro;
  output xt_rsci_clken_d;
  input twiddle_rsc_cgo;
  input xt_rsc_cgo;



  // Interconnect Declarations for Component Instantiations 
  assign twiddle_rsci_clken_d = twiddle_rsc_cgo | twiddle_rsc_cgo_iro;
  assign xt_rsci_clken_d = xt_rsc_cgo | xt_rsc_cgo_iro;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_core
// ------------------------------------------------------------------


module peaceNTT_core (
  clk, rst, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, g_rsc_dat, g_rsc_triosy_lz,
      result_rsc_triosy_lz, vec_rsci_qb_d, vec_rsci_readB_r_ram_ir_internal_RMASK_B_d,
      result_rsci_d_d, result_rsci_q_d, result_rsci_wadr_d, result_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsci_clken_d, twiddle_rsci_d_d, twiddle_rsci_q_d, twiddle_rsci_radr_d,
      twiddle_rsci_wadr_d, twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d, xt_rsci_clken_d,
      xt_rsci_d_d, xt_rsci_q_d, xt_rsci_radr_d, xt_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      vec_rsci_adrb_d_pff, result_rsci_we_d_pff, twiddle_rsci_we_d_pff, xt_rsci_we_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] g_rsc_dat;
  output g_rsc_triosy_lz;
  output result_rsc_triosy_lz;
  input [63:0] vec_rsci_qb_d;
  output vec_rsci_readB_r_ram_ir_internal_RMASK_B_d;
  output [63:0] result_rsci_d_d;
  input [63:0] result_rsci_q_d;
  output [9:0] result_rsci_wadr_d;
  output result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output twiddle_rsci_clken_d;
  output [63:0] twiddle_rsci_d_d;
  input [63:0] twiddle_rsci_q_d;
  output [9:0] twiddle_rsci_radr_d;
  output [9:0] twiddle_rsci_wadr_d;
  output twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output xt_rsci_clken_d;
  output [63:0] xt_rsci_d_d;
  input [63:0] xt_rsci_q_d;
  output [9:0] xt_rsci_radr_d;
  output xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output [9:0] vec_rsci_adrb_d_pff;
  output result_rsci_we_d_pff;
  output twiddle_rsci_we_d_pff;
  output xt_rsci_we_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  wire [63:0] g_rsci_idat;
  wire [64:0] modulo_dev_result_rem_cmp_z;
  reg [63:0] modulo_dev_result_rem_cmp_a_63_0;
  reg [63:0] modulo_dev_result_rem_cmp_b_63_0;
  wire [7:0] fsm_output;
  wire not_tmp_8;
  wire or_tmp_12;
  wire mux_tmp_17;
  wire or_dcpl_7;
  wire or_dcpl_9;
  wire or_dcpl_10;
  wire or_dcpl_11;
  wire and_dcpl_3;
  wire and_dcpl_4;
  wire and_dcpl_5;
  wire and_dcpl_6;
  wire and_dcpl_8;
  wire and_dcpl_11;
  wire and_dcpl_12;
  wire and_dcpl_13;
  wire and_dcpl_15;
  wire and_dcpl_17;
  wire and_dcpl_18;
  wire and_dcpl_19;
  wire or_tmp_34;
  wire and_dcpl_25;
  wire and_dcpl_27;
  wire and_dcpl_31;
  wire and_dcpl_34;
  wire or_tmp_40;
  wire and_dcpl_38;
  wire and_dcpl_40;
  wire and_dcpl_51;
  wire mux_tmp_48;
  wire and_dcpl_56;
  wire mux_tmp_53;
  wire or_tmp_45;
  wire mux_tmp_61;
  wire or_dcpl_17;
  wire or_dcpl_18;
  wire and_dcpl_70;
  wire and_dcpl_72;
  wire and_dcpl_77;
  wire or_dcpl_22;
  wire or_dcpl_23;
  wire or_tmp_72;
  wire or_tmp_73;
  wire or_dcpl_25;
  wire or_dcpl_29;
  wire or_dcpl_32;
  wire or_dcpl_41;
  reg exit_MODEXP_WHILE_sva;
  reg TWIDDLE_LOOP_slc_TWIDDLE_LOOP_acc_3_itm;
  reg [9:0] COMP_LOOP_r_9_0_sva_1;
  wire [10:0] nl_COMP_LOOP_r_9_0_sva_1;
  reg [9:0] COPY_LOOP_1_i_10_0_sva_9_0;
  wire or_29_cse;
  reg reg_twiddle_rsc_cgo_cse;
  reg reg_xt_rsc_cgo_cse;
  reg reg_vec_rsc_triosy_obj_ld_cse;
  wire or_41_cse;
  wire or_59_cse;
  wire and_108_cse;
  wire [63:0] modulo_dev_1_mux_cse;
  wire or_27_cse;
  wire or_19_cse;
  wire or_15_cse;
  wire nor_34_cse;
  wire or_14_cse;
  wire mux_21_cse;
  wire mux_31_cse;
  wire mux_33_cse;
  wire mux_32_cse;
  wire and_27_rmff;
  wire and_37_rmff;
  reg [3:0] TWIDDLE_LOOP_i_3_0_sva;
  reg [63:0] witer_sva;
  wire [9:0] COMP_LOOP_f2_lshift_itm;
  wire and_dcpl_101;
  wire and_dcpl_123;
  wire [4:0] z_out_2;
  wire [5:0] nl_z_out_2;
  wire [2:0] z_out_3;
  wire [7:0] z_out_4;
  wire and_dcpl_144;
  wire and_dcpl_154;
  wire and_dcpl_164;
  wire [10:0] z_out_5;
  wire [11:0] nl_z_out_5;
  wire and_dcpl_175;
  wire [63:0] z_out_6;
  wire [127:0] nl_z_out_6;
  wire and_dcpl_188;
  wire [63:0] z_out_7;
  wire [127:0] nl_z_out_7;
  wire and_dcpl_202;
  wire [63:0] z_out_8;
  wire [64:0] nl_z_out_8;
  wire and_dcpl_226;
  wire [4:0] z_out_10;
  wire [5:0] nl_z_out_10;
  wire [3:0] z_out_11;
  reg [63:0] p_sva;
  reg [6:0] operator_66_true_acc_psp_sva;
  wire [7:0] nl_operator_66_true_acc_psp_sva;
  reg [63:0] modExp_dev_base_sva;
  reg [63:0] modExp_dev_exp_sva;
  reg [63:0] modExp_dev_result_1_sva;
  reg [63:0] COMP_LOOP_f2_asn_itm;
  reg [63:0] COMP_LOOP_f2_asn_1_itm;
  reg [63:0] COMP_LOOP_acc_itm;
  reg [61:0] operator_66_true_mul_28_itm;
  reg [59:0] operator_66_true_mul_27_itm;
  reg [57:0] operator_66_true_mul_26_itm;
  reg [55:0] operator_66_true_mul_25_itm;
  reg [53:0] operator_66_true_mul_24_itm;
  reg [51:0] operator_66_true_mul_23_itm;
  reg [49:0] operator_66_true_mul_22_itm;
  reg [47:0] operator_66_true_mul_21_itm;
  reg [45:0] operator_66_true_mul_20_itm;
  reg [43:0] operator_66_true_mul_19_itm;
  reg [41:0] operator_66_true_mul_18_itm;
  reg [39:0] operator_66_true_mul_17_itm;
  reg [37:0] operator_66_true_mul_16_itm;
  reg [35:0] operator_66_true_mul_15_itm;
  reg [33:0] operator_66_true_mul_14_itm;
  reg [31:0] operator_66_true_mul_13_itm;
  reg [29:0] operator_66_true_mul_12_itm;
  reg [27:0] operator_66_true_mul_11_itm;
  reg [25:0] operator_66_true_mul_10_itm;
  reg [23:0] operator_66_true_mul_9_itm;
  reg [21:0] operator_66_true_mul_8_itm;
  reg [19:0] operator_66_true_mul_7_itm;
  reg [17:0] operator_66_true_mul_6_itm;
  reg [15:0] operator_66_true_mul_5_itm;
  reg [13:0] operator_66_true_mul_4_itm;
  reg [11:0] operator_66_true_mul_3_itm;
  reg [9:0] operator_66_true_mul_2_itm;
  reg [8:0] operator_66_true_acc_45_itm;
  wire [9:0] nl_operator_66_true_acc_45_itm;
  reg [22:0] operator_66_true_acc_52_itm;
  wire [23:0] nl_operator_66_true_acc_52_itm;
  reg [34:0] operator_66_true_acc_58_itm;
  wire [35:0] nl_operator_66_true_acc_58_itm;
  reg [44:0] operator_66_true_acc_63_itm;
  wire [45:0] nl_operator_66_true_acc_63_itm;
  reg [52:0] operator_66_true_acc_67_itm;
  wire [53:0] nl_operator_66_true_acc_67_itm;
  reg [60:0] operator_66_true_acc_71_itm;
  reg [63:0] MODEXP_WHILE_mul_psp;
  reg [63:0] TWIDDLE_LOOP_mul_psp;
  reg [63:0] COMP_LOOP_f2_mul_1_psp;
  reg [63:0] COMP_LOOP_acc_2_psp;
  wire [64:0] operator_64_false_acc_psp_sva_mx0w0;
  wire [65:0] nl_operator_64_false_acc_psp_sva_mx0w0;
  wire [63:0] COMP_LOOP_f2_mul_1_psp_mx0w4;
  wire [127:0] nl_COMP_LOOP_f2_mul_1_psp_mx0w4;
  wire [63:0] COMP_LOOP_acc_2_psp_mx0w6;
  wire [64:0] nl_COMP_LOOP_acc_2_psp_mx0w6;
  wire [3:0] operator_66_true_acc_4_psp_sva_1;
  wire [4:0] nl_operator_66_true_acc_4_psp_sva_1;
  wire [2:0] operator_66_true_acc_2_psp_sva_1;
  wire [3:0] nl_operator_66_true_acc_2_psp_sva_1;
  wire [63:0] modExp_dev_result_1_sva_mx0w2;
  wire [64:0] nl_modExp_dev_result_1_sva_mx0w2;
  wire [63:0] modExp_dev_exp_sva_4;
  wire [64:0] nl_modExp_dev_exp_sva_4;
  wire [62:0] operator_66_true_operator_66_true_acc_psp_1;
  wire [63:0] nl_operator_66_true_operator_66_true_acc_psp_1;
  wire COPY_LOOP_1_i_10_0_sva_9_0_mx0c0;
  wire COPY_LOOP_1_i_10_0_sva_9_0_mx0c2;
  wire or_90_rgt;
  wire and_79_rgt;
  wire and_82_rgt;
  wire nor_71_cse;
  wire and_137_cse;
  wire and_169_cse;
  wire [64:0] operator_64_false_operator_64_false_mux_rgt;
  wire not_tmp_145;
  wire [10:0] COPY_LOOP_1_i_mux1h_1_rgt;
  wire or_tmp_96;
  reg [1:0] COPY_LOOP_1_i_10_0_sva_1_10_9;
  reg [8:0] COPY_LOOP_1_i_10_0_sva_1_8_0;
  reg operator_64_false_acc_psp_sva_64;
  reg [63:0] operator_64_false_acc_psp_sva_63_0;
  wire or_137_cse;
  wire and_272_cse;
  wire nor_91_cse;
  wire or_134_cse;
  wire mux_118_cse;
  wire mux_112_cse;
  wire or_tmp_99;
  wire nand_11_seb;
  wire [27:0] z_out_27_0;
  wire [45:0] z_out_1_45_0;
  wire z_out_9_64;

  wire[0:0] mux_43_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] and_nl;
  wire[0:0] and_264_nl;
  wire[0:0] and_265_nl;
  wire[0:0] nor_42_nl;
  wire[0:0] mux_46_nl;
  wire[0:0] or_40_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] or_38_nl;
  wire[0:0] or_37_nl;
  wire[0:0] and_103_nl;
  wire[0:0] mux_108_nl;
  wire[0:0] mux_nl;
  wire[0:0] or_nl;
  wire[0:0] or_152_nl;
  wire[0:0] mux_109_nl;
  wire[0:0] nor_90_nl;
  wire[0:0] and_271_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] and_26_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] nor_38_nl;
  wire[0:0] and_100_nl;
  wire[0:0] mux_60_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] nand_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] or_50_nl;
  wire[0:0] and_55_nl;
  wire[0:0] and_56_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] mux_27_nl;
  wire[0:0] mux_62_nl;
  wire[0:0] and_59_nl;
  wire[0:0] and_61_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] and_64_nl;
  wire[0:0] and_65_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] and_99_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] or_64_nl;
  wire[0:0] or_62_nl;
  wire[0:0] or_17_nl;
  wire[7:0] operator_66_true_mul_1_nl;
  wire[8:0] r_strt_r_strt_and_nl;
  wire[0:0] COMP_LOOP_r_not_nl;
  wire[0:0] mux_106_nl;
  wire[0:0] mux_105_nl;
  wire[0:0] and_102_nl;
  wire[0:0] mux_104_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] and_9_nl;
  wire[0:0] and_66_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] mux_75_nl;
  wire[0:0] or_72_nl;
  wire[0:0] nand_16_nl;
  wire[0:0] mux_116_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] or_140_nl;
  wire[0:0] mux_114_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] mux_111_nl;
  wire[0:0] or_135_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] or_145_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] or_143_nl;
  wire[20:0] operator_66_true_acc_51_nl;
  wire[21:0] nl_operator_66_true_acc_51_nl;
  wire[18:0] operator_66_true_acc_50_nl;
  wire[19:0] nl_operator_66_true_acc_50_nl;
  wire[16:0] operator_66_true_acc_49_nl;
  wire[17:0] nl_operator_66_true_acc_49_nl;
  wire[14:0] operator_66_true_acc_48_nl;
  wire[15:0] nl_operator_66_true_acc_48_nl;
  wire[12:0] operator_66_true_acc_47_nl;
  wire[13:0] nl_operator_66_true_acc_47_nl;
  wire[32:0] operator_66_true_acc_57_nl;
  wire[33:0] nl_operator_66_true_acc_57_nl;
  wire[30:0] operator_66_true_acc_56_nl;
  wire[31:0] nl_operator_66_true_acc_56_nl;
  wire[28:0] operator_66_true_acc_55_nl;
  wire[29:0] nl_operator_66_true_acc_55_nl;
  wire[26:0] operator_66_true_acc_54_nl;
  wire[27:0] nl_operator_66_true_acc_54_nl;
  wire[24:0] operator_66_true_acc_53_nl;
  wire[25:0] nl_operator_66_true_acc_53_nl;
  wire[42:0] operator_66_true_acc_62_nl;
  wire[43:0] nl_operator_66_true_acc_62_nl;
  wire[40:0] operator_66_true_acc_61_nl;
  wire[41:0] nl_operator_66_true_acc_61_nl;
  wire[38:0] operator_66_true_acc_60_nl;
  wire[39:0] nl_operator_66_true_acc_60_nl;
  wire[36:0] operator_66_true_acc_59_nl;
  wire[37:0] nl_operator_66_true_acc_59_nl;
  wire[50:0] operator_66_true_acc_66_nl;
  wire[51:0] nl_operator_66_true_acc_66_nl;
  wire[48:0] operator_66_true_acc_65_nl;
  wire[49:0] nl_operator_66_true_acc_65_nl;
  wire[46:0] operator_66_true_acc_64_nl;
  wire[47:0] nl_operator_66_true_acc_64_nl;
  wire[0:0] or_5_nl;
  wire[0:0] or_2_nl;
  wire[0:0] mux_128_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] nor_95_nl;
  wire[0:0] and_274_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] or_151_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] or_147_nl;
  wire[0:0] and_74_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] or_99_nl;
  wire[9:0] COPY_LOOP_1_i_mux_nl;
  wire[0:0] COPY_LOOP_1_i_not_nl;
  wire[3:0] operator_66_true_acc_37_nl;
  wire[5:0] nl_operator_66_true_acc_37_nl;
  wire[1:0] operator_66_true_acc_36_nl;
  wire[2:0] nl_operator_66_true_acc_36_nl;
  wire[62:0] operator_66_true_acc_72_nl;
  wire[63:0] nl_operator_66_true_acc_72_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_nand_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] or_46_nl;
  wire[0:0] and_40_nl;
  wire[7:0] COPY_LOOP_mux_1_nl;
  wire[0:0] COPY_LOOP_COPY_LOOP_and_nl;
  wire[0:0] mux_84_nl;
  wire[0:0] nor_29_nl;
  wire[0:0] nor_30_nl;
  wire[1:0] operator_66_true_mux_43_nl;
  wire[23:0] operator_66_true_mux_44_nl;
  wire[1:0] operator_66_true_mux_45_nl;
  wire[41:0] operator_66_true_mux_46_nl;
  wire[3:0] operator_66_true_mux_47_nl;
  wire[3:0] operator_66_true_mux_48_nl;
  wire[3:0] operator_66_true_acc_73_nl;
  wire[5:0] nl_operator_66_true_acc_73_nl;
  wire[3:0] acc_1_nl;
  wire[4:0] nl_acc_1_nl;
  wire[1:0] operator_66_true_mux_49_nl;
  wire[1:0] operator_66_true_mux_50_nl;
  wire[8:0] acc_2_nl;
  wire[9:0] nl_acc_2_nl;
  wire[6:0] operator_66_true_mux_51_nl;
  wire[5:0] operator_66_true_acc_76_nl;
  wire[9:0] nl_operator_66_true_acc_76_nl;
  wire[6:0] operator_66_true_mul_29_nl;
  wire signed [7:0] nl_operator_66_true_mul_29_nl;
  wire[2:0] operator_66_true_acc_84_nl;
  wire[3:0] nl_operator_66_true_acc_84_nl;
  wire[0:0] operator_66_true_and_4_nl;
  wire[6:0] operator_66_true_mux_52_nl;
  wire[5:0] operator_66_true_acc_85_nl;
  wire[9:0] nl_operator_66_true_acc_85_nl;
  wire[5:0] operator_66_true_acc_99_nl;
  wire[7:0] nl_operator_66_true_acc_99_nl;
  wire[4:0] operator_66_true_acc_100_nl;
  wire[6:0] nl_operator_66_true_acc_100_nl;
  wire[0:0] operator_66_true_operator_66_true_nand_1_nl;
  wire[9:0] COPY_LOOP_1_mux1h_2_nl;
  wire[0:0] and_276_nl;
  wire[0:0] COPY_LOOP_1_or_2_nl;
  wire[8:0] COPY_LOOP_1_COPY_LOOP_1_or_1_nl;
  wire[8:0] COPY_LOOP_1_mux_1_nl;
  wire[63:0] operator_66_true_mux_53_nl;
  wire[63:0] operator_66_true_mux_54_nl;
  wire[63:0] TWIDDLE_LOOP_TWIDDLE_LOOP_and_1_nl;
  wire[0:0] not_356_nl;
  wire[63:0] TWIDDLE_LOOP_mux_3_nl;
  wire[63:0] operator_66_true_mux_55_nl;
  wire[63:0] operator_66_true_mux_56_nl;
  wire[58:0] operator_66_true_acc_101_nl;
  wire[59:0] nl_operator_66_true_acc_101_nl;
  wire[56:0] operator_66_true_acc_102_nl;
  wire[57:0] nl_operator_66_true_acc_102_nl;
  wire[54:0] operator_66_true_acc_103_nl;
  wire[55:0] nl_operator_66_true_acc_103_nl;
  wire[64:0] operator_64_false_acc_nl;
  wire[65:0] nl_operator_64_false_acc_nl;
  wire[63:0] operator_64_false_mux_3_nl;
  wire[0:0] and_278_nl;
  wire[3:0] operator_66_true_mux_57_nl;
  wire[0:0] operator_66_true_or_3_nl;
  wire[4:0] acc_7_nl;
  wire[5:0] nl_acc_7_nl;
  wire[2:0] operator_66_true_mux_58_nl;
  wire[2:0] operator_66_true_acc_104_nl;
  wire[3:0] nl_operator_66_true_acc_104_nl;
  wire[0:0] operator_66_true_operator_66_true_nor_1_nl;
  wire[2:0] operator_66_true_mux_59_nl;
  wire[2:0] operator_66_true_acc_105_nl;
  wire[3:0] nl_operator_66_true_acc_105_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_modulo_dev_result_rem_cmp_a;
  assign nl_modulo_dev_result_rem_cmp_a = {{1{modulo_dev_result_rem_cmp_a_63_0[63]}},
      modulo_dev_result_rem_cmp_a_63_0};
  wire [64:0] nl_modulo_dev_result_rem_cmp_b;
  assign nl_modulo_dev_result_rem_cmp_b = {1'b0, modulo_dev_result_rem_cmp_b_63_0};
  wire [3:0] nl_COMP_LOOP_f2_lshift_rg_s;
  assign nl_COMP_LOOP_f2_lshift_rg_s = z_out_5[3:0];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_main_C_7_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_main_C_7_tr0 = ~ z_out_9_64;
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_TWIDDLE_LOOP_C_24_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_TWIDDLE_LOOP_C_24_tr0 = ~ TWIDDLE_LOOP_slc_TWIDDLE_LOOP_acc_3_itm;
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0 = COPY_LOOP_1_i_10_0_sva_1_10_9[1];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_76_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_76_tr0 = COMP_LOOP_r_9_0_sva_1[9];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0 = COPY_LOOP_1_i_10_0_sva_1_10_9[1];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_0_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_0_tr0 = z_out_10[4];
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd64)) g_rsci (
      .dat(g_rsc_dat),
      .idat(g_rsci_idat)
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
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) modulo_dev_result_rem_cmp (
      .a(nl_modulo_dev_result_rem_cmp_a[64:0]),
      .b(nl_modulo_dev_result_rem_cmp_b[64:0]),
      .z(modulo_dev_result_rem_cmp_z)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_f2_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_f2_lshift_rg_s[3:0]),
      .z(COMP_LOOP_f2_lshift_itm)
    );
  peaceNTT_core_wait_dp peaceNTT_core_wait_dp_inst (
      .twiddle_rsc_cgo_iro(and_27_rmff),
      .twiddle_rsci_clken_d(twiddle_rsci_clken_d),
      .xt_rsc_cgo_iro(and_37_rmff),
      .xt_rsci_clken_d(xt_rsci_clken_d),
      .twiddle_rsc_cgo(reg_twiddle_rsc_cgo_cse),
      .xt_rsc_cgo(reg_xt_rsc_cgo_cse)
    );
  peaceNTT_core_core_fsm peaceNTT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .main_C_7_tr0(nl_peaceNTT_core_core_fsm_inst_main_C_7_tr0[0:0]),
      .MODEXP_WHILE_C_24_tr0(exit_MODEXP_WHILE_sva),
      .TWIDDLE_LOOP_C_24_tr0(nl_peaceNTT_core_core_fsm_inst_TWIDDLE_LOOP_C_24_tr0[0:0]),
      .COPY_LOOP_C_2_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0[0:0]),
      .COMP_LOOP_C_76_tr0(nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_76_tr0[0:0]),
      .COPY_LOOP_1_C_2_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0[0:0]),
      .STAGE_LOOP_C_0_tr0(nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_0_tr0[0:0])
    );
  assign or_29_cse = (fsm_output[6:4]!=3'b000);
  assign and_108_cse = (fsm_output[3:2]==2'b11);
  assign or_27_cse = (fsm_output[3:2]!=2'b00);
  assign or_19_cse = (fsm_output[1:0]!=2'b00);
  assign or_41_cse = (fsm_output[2:1]!=2'b00);
  assign or_40_nl = and_272_cse | (fsm_output[6:5]!=2'b10);
  assign or_38_nl = (fsm_output[6:5]!=2'b10);
  assign or_37_nl = (fsm_output[6:5]!=2'b01);
  assign mux_45_nl = MUX_s_1_2_2(or_38_nl, or_37_nl, and_272_cse);
  assign and_103_nl = (fsm_output[2:0]==3'b111);
  assign mux_46_nl = MUX_s_1_2_2(or_40_nl, mux_45_nl, and_103_nl);
  assign nor_42_nl = ~(mux_46_nl | (fsm_output[7]));
  assign operator_64_false_operator_64_false_mux_rgt = MUX_v_65_2_2(operator_64_false_acc_psp_sva_mx0w0,
      ({1'b0 , xt_rsci_q_d}), nor_42_nl);
  assign and_272_cse = (fsm_output[4:3]==2'b11);
  assign nor_91_cse = ~((fsm_output[7:6]!=2'b00));
  assign modulo_dev_1_mux_cse = MUX_v_64_2_2((modulo_dev_result_rem_cmp_z[63:0]),
      modExp_dev_result_1_sva_mx0w2, modulo_dev_result_rem_cmp_z[63]);
  assign mux_54_nl = MUX_s_1_2_2(not_tmp_8, and_272_cse, fsm_output[2]);
  assign and_26_nl = (fsm_output[1]) & mux_54_nl;
  assign nor_38_nl = ~((fsm_output[4:2]!=3'b000));
  assign and_100_nl = (fsm_output[4:2]==3'b111);
  assign mux_53_nl = MUX_s_1_2_2(nor_38_nl, and_100_nl, fsm_output[1]);
  assign mux_55_nl = MUX_s_1_2_2(and_26_nl, mux_53_nl, fsm_output[0]);
  assign and_27_rmff = mux_55_nl & and_dcpl_25;
  assign nand_nl = ~((fsm_output[2]) & (~ mux_21_cse));
  assign mux_59_nl = MUX_s_1_2_2(nand_nl, or_tmp_40, fsm_output[1]);
  assign or_50_nl = (~ (fsm_output[4])) | (~ (fsm_output[5])) | (fsm_output[7]);
  assign mux_57_nl = MUX_s_1_2_2(mux_21_cse, or_50_nl, fsm_output[2]);
  assign mux_58_nl = MUX_s_1_2_2(or_tmp_40, mux_57_nl, fsm_output[1]);
  assign mux_60_nl = MUX_s_1_2_2(mux_59_nl, mux_58_nl, fsm_output[0]);
  assign and_37_rmff = (~ mux_60_nl) & (~ (fsm_output[6])) & (fsm_output[3]);
  assign or_59_cse = (fsm_output[2:0]!=3'b000);
  assign or_15_cse = (fsm_output[5:4]!=2'b00);
  assign nor_34_cse = ~((fsm_output[2:1]!=2'b00));
  assign or_14_cse = (~(((fsm_output[5:4]==2'b11)) | (fsm_output[6]))) | (fsm_output[7]);
  assign mux_31_cse = MUX_s_1_2_2(mux_tmp_17, or_tmp_12, or_15_cse);
  assign or_17_nl = (fsm_output[5:3]!=3'b000);
  assign mux_33_cse = MUX_s_1_2_2(mux_tmp_17, or_tmp_12, or_17_nl);
  assign mux_32_cse = MUX_s_1_2_2(mux_31_cse, or_14_cse, fsm_output[3]);
  assign operator_66_true_mul_1_nl = conv_s2u_8_8((operator_64_false_acc_psp_sva_mx0w0[10:9])
      * 6'b110011);
  assign and_102_nl = (fsm_output[2:1]==2'b11);
  assign mux_105_nl = MUX_s_1_2_2(mux_33_cse, mux_32_cse, and_102_nl);
  assign mux_103_nl = MUX_s_1_2_2(mux_31_cse, or_14_cse, and_108_cse);
  assign mux_104_nl = MUX_s_1_2_2(mux_103_nl, mux_tmp_61, fsm_output[1]);
  assign mux_106_nl = MUX_s_1_2_2(mux_105_nl, mux_104_nl, fsm_output[0]);
  assign COMP_LOOP_r_not_nl = ~ mux_106_nl;
  assign r_strt_r_strt_and_nl = MUX_v_9_2_2(9'b000000000, (COMP_LOOP_r_9_0_sva_1[8:0]),
      COMP_LOOP_r_not_nl);
  assign and_9_nl = and_dcpl_8 & and_dcpl_5;
  assign and_66_nl = and_dcpl_40 & and_dcpl_13;
  assign mux_75_nl = MUX_s_1_2_2(mux_tmp_17, or_tmp_12, fsm_output[5]);
  assign or_72_nl = (~((fsm_output[6:5]!=2'b00))) | (fsm_output[7]);
  assign mux_76_nl = MUX_s_1_2_2(mux_75_nl, or_72_nl, fsm_output[4]);
  assign mux_77_nl = MUX_s_1_2_2(mux_31_cse, mux_76_nl, and_108_cse);
  assign mux_78_nl = MUX_s_1_2_2(mux_77_nl, mux_tmp_61, or_134_cse);
  assign COPY_LOOP_1_i_mux1h_1_rgt = MUX1HOT_v_11_3_2(({3'b000 , operator_66_true_mul_1_nl}),
      z_out_5, ({2'b00 , r_strt_r_strt_and_nl}), {and_9_nl , and_66_nl , (~ mux_78_nl)});
  assign or_137_cse = (fsm_output[1]) | (~ (fsm_output[7])) | (fsm_output[5]) | (fsm_output[4]);
  assign or_134_cse = (fsm_output[1:0]!=2'b01);
  assign nand_16_nl = ~((fsm_output[1]) & (~ mux_118_cse));
  assign mux_112_cse = MUX_s_1_2_2(nand_16_nl, or_137_cse, fsm_output[0]);
  assign mux_118_cse = MUX_s_1_2_2(not_tmp_145, or_15_cse, fsm_output[7]);
  assign or_5_nl = (fsm_output[5]) | (~ (fsm_output[7]));
  assign or_2_nl = (~ (fsm_output[5])) | (fsm_output[7]);
  assign mux_21_cse = MUX_s_1_2_2(or_5_nl, or_2_nl, fsm_output[4]);
  assign or_90_rgt = (and_272_cse & or_41_cse) | or_dcpl_9 | (~ (fsm_output[5]));
  assign and_79_rgt = and_dcpl_77 & nor_34_cse & (~ (fsm_output[0])) & (~ (modulo_dev_result_rem_cmp_z[63]));
  assign and_82_rgt = and_dcpl_77 & nor_34_cse & (~ (fsm_output[0])) & (modulo_dev_result_rem_cmp_z[63]);
  assign nl_operator_64_false_acc_psp_sva_mx0w0 = conv_u2s_64_65(p_rsci_idat) + 65'b11111111111111111111111111111111111111111111111111111111111111111;
  assign operator_64_false_acc_psp_sva_mx0w0 = nl_operator_64_false_acc_psp_sva_mx0w0[64:0];
  assign nl_COMP_LOOP_f2_mul_1_psp_mx0w4 = COMP_LOOP_f2_asn_itm * COMP_LOOP_f2_asn_1_itm;
  assign COMP_LOOP_f2_mul_1_psp_mx0w4 = nl_COMP_LOOP_f2_mul_1_psp_mx0w4[63:0];
  assign nl_COMP_LOOP_acc_2_psp_mx0w6 = operator_64_false_acc_psp_sva_63_0 - modulo_dev_1_mux_cse;
  assign COMP_LOOP_acc_2_psp_mx0w6 = nl_COMP_LOOP_acc_2_psp_mx0w6[63:0];
  assign nl_operator_66_true_acc_36_nl = conv_u2u_1_2(operator_66_true_acc_psp_sva[4])
      + conv_u2u_1_2(operator_66_true_acc_psp_sva[5]) + 2'b01;
  assign operator_66_true_acc_36_nl = nl_operator_66_true_acc_36_nl[1:0];
  assign nl_operator_66_true_acc_37_nl = conv_u2u_3_4({(~ (operator_66_true_acc_psp_sva[5]))
      , (~ (operator_66_true_acc_psp_sva[3:2]))}) + conv_u2u_2_4(operator_66_true_acc_36_nl)
      + conv_u2u_1_4(operator_66_true_acc_psp_sva[6]);
  assign operator_66_true_acc_37_nl = nl_operator_66_true_acc_37_nl[3:0];
  assign nl_operator_66_true_acc_4_psp_sva_1 = operator_66_true_acc_37_nl + ({2'b10
      , (operator_66_true_acc_psp_sva[1:0])});
  assign operator_66_true_acc_4_psp_sva_1 = nl_operator_66_true_acc_4_psp_sva_1[3:0];
  assign nl_operator_66_true_acc_2_psp_sva_1 = conv_s2u_2_3(z_out_10[1:0]) + ({(operator_66_true_acc_4_psp_sva_1[3])
      , (operator_66_true_acc_4_psp_sva_1[1:0])});
  assign operator_66_true_acc_2_psp_sva_1 = nl_operator_66_true_acc_2_psp_sva_1[2:0];
  assign nl_modExp_dev_result_1_sva_mx0w2 = (modulo_dev_result_rem_cmp_z[63:0]) +
      p_sva;
  assign modExp_dev_result_1_sva_mx0w2 = nl_modExp_dev_result_1_sva_mx0w2[63:0];
  assign nl_modExp_dev_exp_sva_4 = modExp_dev_exp_sva + 64'b1111111111111111111111111111111111111111111111111111111111111111;
  assign modExp_dev_exp_sva_4 = nl_modExp_dev_exp_sva_4[63:0];
  assign nl_operator_66_true_acc_72_nl = conv_u2s_62_63(operator_66_true_mul_28_itm)
      + conv_s2s_61_63(operator_66_true_acc_71_itm);
  assign operator_66_true_acc_72_nl = nl_operator_66_true_acc_72_nl[62:0];
  assign nl_operator_66_true_operator_66_true_acc_psp_1 = operator_66_true_acc_72_nl
      + ({operator_64_false_acc_psp_sva_64 , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 2'b00 , ({{1{operator_64_false_acc_psp_sva_64}},
      operator_64_false_acc_psp_sva_64}) , 1'b0 , operator_64_false_acc_psp_sva_64});
  assign operator_66_true_operator_66_true_acc_psp_1 = nl_operator_66_true_operator_66_true_acc_psp_1[62:0];
  assign not_tmp_8 = ~((fsm_output[4:3]!=2'b00));
  assign or_tmp_12 = (fsm_output[7:6]!=2'b01);
  assign mux_tmp_17 = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign or_dcpl_7 = or_27_cse | or_19_cse;
  assign or_dcpl_9 = (fsm_output[7:6]!=2'b00);
  assign or_dcpl_10 = or_dcpl_9 | or_15_cse;
  assign or_dcpl_11 = or_dcpl_10 | or_dcpl_7;
  assign and_dcpl_3 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_4 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_5 = and_dcpl_4 & and_dcpl_3;
  assign and_dcpl_6 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_8 = nor_91_cse & and_dcpl_6;
  assign and_dcpl_11 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_12 = (fsm_output[3:2]==2'b10);
  assign and_dcpl_13 = and_dcpl_12 & and_dcpl_11;
  assign and_dcpl_15 = nor_91_cse & (fsm_output[5:4]==2'b11);
  assign and_dcpl_17 = and_dcpl_12 & and_dcpl_3;
  assign and_dcpl_18 = (fsm_output[7:6]==2'b10);
  assign and_dcpl_19 = and_dcpl_18 & and_dcpl_6;
  assign or_tmp_34 = ~((fsm_output[7:4]==4'b0111));
  assign and_dcpl_25 = nor_91_cse & (fsm_output[5]);
  assign and_dcpl_27 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_31 = nor_91_cse & (fsm_output[5:4]==2'b10) & and_dcpl_4 & and_dcpl_27;
  assign and_dcpl_34 = and_dcpl_15 & and_108_cse & and_dcpl_11;
  assign or_tmp_40 = ~((fsm_output[2]) & (fsm_output[4]) & (fsm_output[5]) & (~ (fsm_output[7])));
  assign and_dcpl_38 = and_dcpl_12 & (fsm_output[1:0]==2'b11);
  assign and_dcpl_40 = ~(mux_21_cse | (fsm_output[6]));
  assign and_dcpl_51 = and_dcpl_8 & and_dcpl_17;
  assign mux_tmp_48 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[3]);
  assign and_dcpl_56 = (fsm_output[7:6]==2'b01);
  assign mux_tmp_53 = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[4]);
  assign or_tmp_45 = (fsm_output[5:4]!=2'b10);
  assign mux_tmp_61 = MUX_s_1_2_2(mux_33_cse, mux_32_cse, fsm_output[2]);
  assign or_dcpl_17 = or_27_cse | or_134_cse;
  assign or_dcpl_18 = or_dcpl_10 | or_dcpl_17;
  assign and_dcpl_70 = and_108_cse & and_dcpl_27;
  assign and_dcpl_72 = and_dcpl_12 & and_dcpl_27;
  assign and_dcpl_77 = and_dcpl_25 & not_tmp_8;
  assign or_dcpl_22 = (fsm_output[3:2]!=2'b10) | or_19_cse;
  assign or_dcpl_23 = or_dcpl_10 | or_dcpl_22;
  assign or_tmp_72 = not_tmp_8 | (fsm_output[5]);
  assign or_tmp_73 = (fsm_output[5:4]!=2'b01);
  assign or_dcpl_25 = or_dcpl_9 | or_tmp_45 | or_dcpl_17;
  assign or_dcpl_29 = ~((fsm_output[3:2]==2'b11));
  assign or_dcpl_32 = or_dcpl_9 | (fsm_output[5:4]!=2'b11);
  assign or_dcpl_41 = or_tmp_12 | or_tmp_73 | or_dcpl_22;
  assign COPY_LOOP_1_i_10_0_sva_9_0_mx0c0 = and_dcpl_40 & and_dcpl_72;
  assign COPY_LOOP_1_i_10_0_sva_9_0_mx0c2 = and_dcpl_15 & and_dcpl_70;
  assign vec_rsci_adrb_d_pff = COPY_LOOP_1_i_10_0_sva_9_0;
  assign vec_rsci_readB_r_ram_ir_internal_RMASK_B_d = and_dcpl_15 & and_dcpl_13;
  assign result_rsci_d_d = modulo_dev_1_mux_cse;
  assign COMP_LOOP_COMP_LOOP_nand_nl = ~(and_dcpl_19 & and_dcpl_17);
  assign result_rsci_wadr_d = {COMP_LOOP_COMP_LOOP_nand_nl , COPY_LOOP_1_i_10_0_sva_1_8_0};
  assign or_46_nl = (fsm_output[7:4]!=4'b1000);
  assign mux_52_nl = MUX_s_1_2_2(or_tmp_34, or_46_nl, fsm_output[3]);
  assign result_rsci_we_d_pff = (~ mux_52_nl) & nor_34_cse & (~ (fsm_output[0]));
  assign result_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_19 & and_dcpl_13;
  assign twiddle_rsci_d_d = witer_sva;
  assign twiddle_rsci_wadr_d = {6'b000000 , TWIDDLE_LOOP_i_3_0_sva};
  assign twiddle_rsci_we_d_pff = and_dcpl_31;
  assign twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_34;
  assign and_40_nl = and_dcpl_19 & and_dcpl_38;
  assign xt_rsci_d_d = MUX_v_64_2_2(vec_rsci_qb_d, result_rsci_q_d, and_40_nl);
  assign COPY_LOOP_mux_1_nl = MUX_v_8_2_2((COPY_LOOP_1_i_10_0_sva_1_8_0[7:0]), (COPY_LOOP_1_i_10_0_sva_1_8_0[8:1]),
      and_dcpl_34);
  assign COPY_LOOP_COPY_LOOP_and_nl = (COPY_LOOP_1_i_10_0_sva_1_8_0[0]) & and_dcpl_34;
  assign xt_rsci_radr_d = {COPY_LOOP_mux_1_nl , COPY_LOOP_COPY_LOOP_and_nl , 1'b0};
  assign xt_rsci_we_d_pff = and_dcpl_40 & and_dcpl_38;
  assign xt_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_15 & and_108_cse &
      ((fsm_output[1]) ^ (fsm_output[0]));
  assign and_dcpl_101 = (fsm_output==8'b00000001);
  assign nor_71_cse = ~((fsm_output[3]) | (fsm_output[1]));
  assign and_137_cse = nor_91_cse & and_dcpl_6 & nor_71_cse & (fsm_output[0]) & (~
      (fsm_output[2]));
  assign and_dcpl_123 = nor_91_cse & (fsm_output[5:4]==2'b10) & nor_71_cse & (fsm_output[0])
      & (~ (fsm_output[2]));
  assign and_169_cse = and_dcpl_8 & nor_71_cse & (fsm_output[0]) & (~ (fsm_output[2]));
  assign and_dcpl_144 = ~((fsm_output[0]) | (fsm_output[2]));
  assign and_dcpl_154 = nor_91_cse & (~ (fsm_output[5])) & (~ (fsm_output[4])) &
      (~ (fsm_output[3])) & (fsm_output[1]) & and_dcpl_144;
  assign and_dcpl_164 = and_dcpl_40 & (fsm_output[3:0]==4'b1101);
  assign and_dcpl_175 = ~((fsm_output!=8'b00001000));
  assign and_dcpl_188 = nor_91_cse & (fsm_output[5:0]==6'b111110);
  assign twiddle_rsci_radr_d = z_out_7[9:0];
  assign and_dcpl_202 = (fsm_output==8'b01011000);
  assign and_dcpl_226 = (fsm_output[7:6]==2'b10) & and_dcpl_6 & (fsm_output[3:0]==4'b1101);
  assign not_tmp_145 = ~((fsm_output[5:4]==2'b11));
  assign or_tmp_96 = (fsm_output[3]) | (fsm_output[4]) | (fsm_output[7]) | (fsm_output[1])
      | (~ (fsm_output[5]));
  assign or_tmp_99 = and_dcpl_31 | (and_dcpl_19 & and_dcpl_70);
  assign nor_29_nl = ~((fsm_output[1]) | (fsm_output[2]) | (~ (fsm_output[5])));
  assign nor_30_nl = ~((~ (fsm_output[1])) | (~ (fsm_output[2])) | (fsm_output[5]));
  assign mux_84_nl = MUX_s_1_2_2(nor_29_nl, nor_30_nl, fsm_output[0]);
  assign nand_11_seb = ~(mux_84_nl & nor_91_cse & not_tmp_8);
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_43_nl, and_265_nl, fsm_output[0]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_28_itm <= conv_u2u_62_62((operator_64_false_acc_psp_sva_mx0w0[64:63])
          * 60'b110011001100110011001100110011001100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~(mux_108_nl | (fsm_output[7])) ) begin
      operator_64_false_acc_psp_sva_64 <= operator_64_false_operator_64_false_mux_rgt[64];
    end
  end
  always @(posedge clk) begin
    if ( mux_109_nl & nor_91_cse ) begin
      operator_64_false_acc_psp_sva_63_0 <= operator_64_false_operator_64_false_mux_rgt[63:0];
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_26_itm <= conv_u2u_58_58((operator_64_false_acc_psp_sva_mx0w0[60:59])
          * 56'b11001100110011001100110011001100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_25_itm <= conv_u2u_56_56((operator_64_false_acc_psp_sva_mx0w0[58:57])
          * 54'b110011001100110011001100110011001100110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_24_itm <= conv_u2u_54_54((operator_64_false_acc_psp_sva_mx0w0[56:55])
          * 52'b1100110011001100110011001100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_23_itm <= conv_u2u_52_52((operator_64_false_acc_psp_sva_mx0w0[54:53])
          * 50'b11001100110011001100110011001100110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_22_itm <= conv_u2u_50_50((operator_64_false_acc_psp_sva_mx0w0[52:51])
          * 48'b110011001100110011001100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_21_itm <= conv_u2u_48_48((operator_64_false_acc_psp_sva_mx0w0[50:49])
          * 46'b1100110011001100110011001100110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_19_itm <= z_out_1_45_0[43:0];
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_18_itm <= conv_u2u_42_42((operator_64_false_acc_psp_sva_mx0w0[44:43])
          * 40'b1100110011001100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_17_itm <= conv_u2u_40_40((operator_64_false_acc_psp_sva_mx0w0[42:41])
          * 38'b11001100110011001100110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_16_itm <= conv_u2u_38_38((operator_64_false_acc_psp_sva_mx0w0[40:39])
          * 36'b110011001100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_15_itm <= conv_u2u_36_36((operator_64_false_acc_psp_sva_mx0w0[38:37])
          * 34'b1100110011001100110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_14_itm <= conv_u2u_34_34((operator_64_false_acc_psp_sva_mx0w0[36:35])
          * 32'b11001100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_13_itm <= conv_u2u_32_32((operator_64_false_acc_psp_sva_mx0w0[34:33])
          * 30'b110011001100110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_12_itm <= conv_u2u_30_30((operator_64_false_acc_psp_sva_mx0w0[32:31])
          * 28'b1100110011001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_10_itm <= z_out_27_0[25:0];
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_9_itm <= conv_u2u_24_24((operator_64_false_acc_psp_sva_mx0w0[26:25])
          * 22'b1100110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_8_itm <= conv_u2u_22_22((operator_64_false_acc_psp_sva_mx0w0[24:23])
          * 20'b11001100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_7_itm <= conv_u2u_20_20((operator_64_false_acc_psp_sva_mx0w0[22:21])
          * 18'b110011001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_6_itm <= conv_u2u_18_18((operator_64_false_acc_psp_sva_mx0w0[20:19])
          * 16'b1100110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_5_itm <= conv_u2u_16_16((operator_64_false_acc_psp_sva_mx0w0[18:17])
          * 14'b11001100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_4_itm <= conv_u2u_14_14((operator_64_false_acc_psp_sva_mx0w0[16:15])
          * 12'b110011001101);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_3_itm <= conv_u2u_12_12((operator_64_false_acc_psp_sva_mx0w0[14:13])
          * 10'b1100110011);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      operator_66_true_mul_2_itm <= conv_u2u_10_10((operator_64_false_acc_psp_sva_mx0w0[12:11])
          * 8'b11001101);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_twiddle_rsc_cgo_cse <= 1'b0;
      reg_xt_rsc_cgo_cse <= 1'b0;
      reg_vec_rsc_triosy_obj_ld_cse <= 1'b0;
    end
    else begin
      reg_twiddle_rsc_cgo_cse <= and_27_rmff;
      reg_xt_rsc_cgo_cse <= and_37_rmff;
      reg_vec_rsc_triosy_obj_ld_cse <= and_dcpl_18 & (fsm_output[5:0]==6'b001101)
          & (z_out_10[4]);
    end
  end
  always @(posedge clk) begin
    operator_66_true_acc_psp_sva <= nl_operator_66_true_acc_psp_sva[6:0];
    modulo_dev_result_rem_cmp_a_63_0 <= MUX1HOT_v_64_9_2(z_out_6, MODEXP_WHILE_mul_psp,
        z_out_7, TWIDDLE_LOOP_mul_psp, COMP_LOOP_f2_mul_1_psp_mx0w4, COMP_LOOP_f2_mul_1_psp,
        COMP_LOOP_acc_2_psp_mx0w6, COMP_LOOP_acc_2_psp, COMP_LOOP_acc_itm, {and_dcpl_51
        , and_55_nl , and_dcpl_31 , and_56_nl , and_59_nl , and_61_nl , and_64_nl
        , and_65_nl , (~ mux_69_nl)});
    modulo_dev_result_rem_cmp_b_63_0 <= p_sva;
    operator_66_true_acc_45_itm <= nl_operator_66_true_acc_45_itm[8:0];
    operator_66_true_acc_52_itm <= nl_operator_66_true_acc_52_itm[22:0];
    operator_66_true_acc_58_itm <= nl_operator_66_true_acc_58_itm[34:0];
    operator_66_true_acc_63_itm <= nl_operator_66_true_acc_63_itm[44:0];
    operator_66_true_acc_67_itm <= nl_operator_66_true_acc_67_itm[52:0];
    operator_66_true_acc_71_itm <= z_out_8[60:0];
    witer_sva <= MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
        modulo_dev_1_mux_cse, and_74_nl);
    COMP_LOOP_f2_asn_itm <= twiddle_rsci_q_d;
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_10_0_sva_1_10_9 <= 2'b00;
    end
    else if ( ~ mux_116_nl ) begin
      COPY_LOOP_1_i_10_0_sva_1_10_9 <= COPY_LOOP_1_i_mux1h_1_rgt[10:9];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_10_0_sva_1_8_0 <= 9'b000000000;
    end
    else if ( ~(mux_121_nl | (fsm_output[6])) ) begin
      COPY_LOOP_1_i_10_0_sva_1_8_0 <= COPY_LOOP_1_i_mux1h_1_rgt[8:0];
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_18 ) begin
      operator_66_true_mul_27_itm <= z_out_6[59:0];
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_18 ) begin
      operator_66_true_mul_20_itm <= z_out_1_45_0;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_18 ) begin
      operator_66_true_mul_11_itm <= z_out_27_0;
    end
  end
  always @(posedge clk) begin
    if ( ~(mux_125_nl | (fsm_output[6])) ) begin
      TWIDDLE_LOOP_i_3_0_sva <= MUX_v_4_2_2(({nand_11_seb , 1'b0 , nand_11_seb ,
          1'b0}), (z_out_5[3:0]), mux_128_nl);
    end
  end
  always @(posedge clk) begin
    if ( or_90_rgt | and_79_rgt | and_82_rgt ) begin
      modExp_dev_result_1_sva <= MUX1HOT_v_64_3_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
          (modulo_dev_result_rem_cmp_z[63:0]), modExp_dev_result_1_sva_mx0w2, {or_90_rgt
          , and_79_rgt , and_82_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_MODEXP_WHILE_sva <= 1'b0;
    end
    else if ( ~ or_dcpl_23 ) begin
      exit_MODEXP_WHILE_sva <= ~ z_out_9_64;
    end
  end
  always @(posedge clk) begin
    if ( ~((~ mux_99_nl) & nor_91_cse) ) begin
      modExp_dev_exp_sva <= MUX_v_64_2_2(({{1{operator_66_true_operator_66_true_acc_psp_1[62]}},
          operator_66_true_operator_66_true_acc_psp_1}), modExp_dev_exp_sva_4, and_dcpl_51);
    end
  end
  always @(posedge clk) begin
    if ( ~((~ mux_101_nl) & nor_91_cse) ) begin
      modExp_dev_base_sva <= g_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_23 ) begin
      MODEXP_WHILE_mul_psp <= z_out_6;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_25 ) begin
      TWIDDLE_LOOP_slc_TWIDDLE_LOOP_acc_3_itm <= z_out_2[3];
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_25 ) begin
      TWIDDLE_LOOP_mul_psp <= z_out_7;
    end
  end
  always @(posedge clk) begin
    if ( COPY_LOOP_1_i_10_0_sva_9_0_mx0c0 | (and_dcpl_40 & and_108_cse & and_dcpl_3)
        | COPY_LOOP_1_i_10_0_sva_9_0_mx0c2 ) begin
      COPY_LOOP_1_i_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, COPY_LOOP_1_i_mux_nl,
          COPY_LOOP_1_i_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_r_9_0_sva_1 <= 10'b0000000000;
    end
    else if ( ~(or_dcpl_32 | or_dcpl_29 | or_134_cse) ) begin
      COMP_LOOP_r_9_0_sva_1 <= nl_COMP_LOOP_r_9_0_sva_1[9:0];
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_32 | or_dcpl_29 | (fsm_output[1:0]!=2'b10)) ) begin
      COMP_LOOP_f2_asn_1_itm <= xt_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_tmp_12 | or_15_cse | or_dcpl_7) ) begin
      COMP_LOOP_f2_mul_1_psp <= COMP_LOOP_f2_mul_1_psp_mx0w4;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_41 ) begin
      COMP_LOOP_acc_itm <= z_out_8;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_41 ) begin
      COMP_LOOP_acc_2_psp <= COMP_LOOP_acc_2_psp_mx0w6;
    end
  end
  assign mux_41_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), or_29_cse);
  assign and_nl = or_29_cse & (fsm_output[7]);
  assign mux_42_nl = MUX_s_1_2_2(mux_41_nl, and_nl, or_27_cse);
  assign and_264_nl = (and_108_cse | (fsm_output[6:4]!=3'b000)) & (fsm_output[7]);
  assign mux_43_nl = MUX_s_1_2_2(mux_42_nl, and_264_nl, fsm_output[1]);
  assign and_265_nl = (((fsm_output[3:1]==3'b111)) | (fsm_output[6:4]!=3'b000)) &
      (fsm_output[7]);
  assign or_nl = (fsm_output[4:0]!=5'b00000);
  assign mux_nl = MUX_s_1_2_2(or_nl, and_272_cse, fsm_output[6]);
  assign or_152_nl = (fsm_output[6]) | (~((fsm_output[4:0]==5'b11111)));
  assign mux_108_nl = MUX_s_1_2_2(mux_nl, or_152_nl, fsm_output[5]);
  assign nor_90_nl = ~((fsm_output[4:0]!=5'b00000));
  assign and_271_nl = (fsm_output[4:0]==5'b11111);
  assign mux_109_nl = MUX_s_1_2_2(nor_90_nl, and_271_nl, fsm_output[5]);
  assign nl_operator_66_true_acc_psp_sva  = (z_out_4[6:0]) + ({6'b100111 , (~ (operator_64_false_acc_psp_sva_mx0w0[64]))});
  assign and_55_nl = (((or_41_cse | (fsm_output[0])) & (fsm_output[3])) | (fsm_output[4]))
      & nor_91_cse & (~ (fsm_output[5]));
  assign mux_27_nl = MUX_s_1_2_2(not_tmp_8, and_272_cse, or_41_cse);
  assign mux_62_nl = MUX_s_1_2_2(mux_tmp_48, and_272_cse, or_41_cse);
  assign mux_64_nl = MUX_s_1_2_2(mux_27_nl, mux_62_nl, fsm_output[0]);
  assign and_56_nl = (~ mux_64_nl) & and_dcpl_25;
  assign and_59_nl = and_dcpl_56 & and_dcpl_6 & and_dcpl_5;
  assign mux_65_nl = MUX_s_1_2_2(mux_tmp_48, and_272_cse, or_59_cse);
  assign and_61_nl = (~ mux_65_nl) & and_dcpl_56 & (~ (fsm_output[5]));
  assign and_64_nl = and_dcpl_56 & (fsm_output[5:4]==2'b01) & and_dcpl_17;
  assign and_99_nl = or_59_cse & (fsm_output[3]);
  assign mux_67_nl = MUX_s_1_2_2(or_tmp_45, mux_tmp_53, and_99_nl);
  assign and_65_nl = (~ mux_67_nl) & and_dcpl_56;
  assign or_64_nl = (fsm_output[7:5]!=3'b100);
  assign or_62_nl = (fsm_output[7:5]!=3'b011);
  assign mux_68_nl = MUX_s_1_2_2(or_64_nl, or_62_nl, fsm_output[4]);
  assign mux_69_nl = MUX_s_1_2_2(mux_68_nl, or_tmp_34, fsm_output[3]);
  assign nl_operator_66_true_acc_45_itm  = conv_s2s_8_9(z_out_4) + conv_u2s_8_9(COPY_LOOP_1_i_10_0_sva_1_8_0[7:0]);
  assign nl_operator_66_true_acc_47_nl = conv_u2s_12_13(operator_66_true_mul_3_itm)
      + conv_s2s_11_13(z_out_5);
  assign operator_66_true_acc_47_nl = nl_operator_66_true_acc_47_nl[12:0];
  assign nl_operator_66_true_acc_48_nl = conv_u2s_14_15(operator_66_true_mul_4_itm)
      + conv_s2s_13_15(operator_66_true_acc_47_nl);
  assign operator_66_true_acc_48_nl = nl_operator_66_true_acc_48_nl[14:0];
  assign nl_operator_66_true_acc_49_nl = conv_u2s_16_17(operator_66_true_mul_5_itm)
      + conv_s2s_15_17(operator_66_true_acc_48_nl);
  assign operator_66_true_acc_49_nl = nl_operator_66_true_acc_49_nl[16:0];
  assign nl_operator_66_true_acc_50_nl = conv_u2s_18_19(operator_66_true_mul_6_itm)
      + conv_s2s_17_19(operator_66_true_acc_49_nl);
  assign operator_66_true_acc_50_nl = nl_operator_66_true_acc_50_nl[18:0];
  assign nl_operator_66_true_acc_51_nl = conv_u2s_20_21(operator_66_true_mul_7_itm)
      + conv_s2s_19_21(operator_66_true_acc_50_nl);
  assign operator_66_true_acc_51_nl = nl_operator_66_true_acc_51_nl[20:0];
  assign nl_operator_66_true_acc_52_itm  = conv_u2s_22_23(operator_66_true_mul_8_itm)
      + conv_s2s_21_23(operator_66_true_acc_51_nl);
  assign nl_operator_66_true_acc_53_nl = conv_u2s_24_25(operator_66_true_mul_9_itm)
      + conv_s2s_23_25(operator_66_true_acc_52_itm);
  assign operator_66_true_acc_53_nl = nl_operator_66_true_acc_53_nl[24:0];
  assign nl_operator_66_true_acc_54_nl = conv_u2s_26_27(operator_66_true_mul_10_itm)
      + conv_s2s_25_27(operator_66_true_acc_53_nl);
  assign operator_66_true_acc_54_nl = nl_operator_66_true_acc_54_nl[26:0];
  assign nl_operator_66_true_acc_55_nl = conv_u2s_28_29(operator_66_true_mul_11_itm)
      + conv_s2s_27_29(operator_66_true_acc_54_nl);
  assign operator_66_true_acc_55_nl = nl_operator_66_true_acc_55_nl[28:0];
  assign nl_operator_66_true_acc_56_nl = conv_u2s_30_31(operator_66_true_mul_12_itm)
      + conv_s2s_29_31(operator_66_true_acc_55_nl);
  assign operator_66_true_acc_56_nl = nl_operator_66_true_acc_56_nl[30:0];
  assign nl_operator_66_true_acc_57_nl = conv_u2s_32_33(operator_66_true_mul_13_itm)
      + conv_s2s_31_33(operator_66_true_acc_56_nl);
  assign operator_66_true_acc_57_nl = nl_operator_66_true_acc_57_nl[32:0];
  assign nl_operator_66_true_acc_58_itm  = conv_u2s_34_35(operator_66_true_mul_14_itm)
      + conv_s2s_33_35(operator_66_true_acc_57_nl);
  assign nl_operator_66_true_acc_59_nl = conv_u2s_36_37(operator_66_true_mul_15_itm)
      + conv_s2s_35_37(operator_66_true_acc_58_itm);
  assign operator_66_true_acc_59_nl = nl_operator_66_true_acc_59_nl[36:0];
  assign nl_operator_66_true_acc_60_nl = conv_u2s_38_39(operator_66_true_mul_16_itm)
      + conv_s2s_37_39(operator_66_true_acc_59_nl);
  assign operator_66_true_acc_60_nl = nl_operator_66_true_acc_60_nl[38:0];
  assign nl_operator_66_true_acc_61_nl = conv_u2s_40_41(operator_66_true_mul_17_itm)
      + conv_s2s_39_41(operator_66_true_acc_60_nl);
  assign operator_66_true_acc_61_nl = nl_operator_66_true_acc_61_nl[40:0];
  assign nl_operator_66_true_acc_62_nl = conv_u2s_42_43(operator_66_true_mul_18_itm)
      + conv_s2s_41_43(operator_66_true_acc_61_nl);
  assign operator_66_true_acc_62_nl = nl_operator_66_true_acc_62_nl[42:0];
  assign nl_operator_66_true_acc_63_itm  = conv_u2s_44_45(operator_66_true_mul_19_itm)
      + conv_s2s_43_45(operator_66_true_acc_62_nl);
  assign nl_operator_66_true_acc_64_nl = conv_u2s_46_47(operator_66_true_mul_20_itm)
      + conv_s2s_45_47(operator_66_true_acc_63_itm);
  assign operator_66_true_acc_64_nl = nl_operator_66_true_acc_64_nl[46:0];
  assign nl_operator_66_true_acc_65_nl = conv_u2s_48_49(operator_66_true_mul_21_itm)
      + conv_s2s_47_49(operator_66_true_acc_64_nl);
  assign operator_66_true_acc_65_nl = nl_operator_66_true_acc_65_nl[48:0];
  assign nl_operator_66_true_acc_66_nl = conv_u2s_50_51(operator_66_true_mul_22_itm)
      + conv_s2s_49_51(operator_66_true_acc_65_nl);
  assign operator_66_true_acc_66_nl = nl_operator_66_true_acc_66_nl[50:0];
  assign nl_operator_66_true_acc_67_itm  = conv_u2s_52_53(operator_66_true_mul_23_itm)
      + conv_s2s_51_53(operator_66_true_acc_66_nl);
  assign and_74_nl = and_dcpl_15 & and_dcpl_72;
  assign or_140_nl = (~((~((fsm_output[2:0]!=3'b000))) | (fsm_output[7]))) | (fsm_output[5:4]!=2'b00);
  assign mux_115_nl = MUX_s_1_2_2(or_140_nl, (fsm_output[7]), fsm_output[6]);
  assign or_135_nl = (fsm_output[7]) | not_tmp_145;
  assign mux_111_nl = MUX_s_1_2_2(mux_118_cse, or_135_nl, or_134_cse);
  assign mux_113_nl = MUX_s_1_2_2(mux_112_cse, mux_111_nl, fsm_output[2]);
  assign mux_114_nl = MUX_s_1_2_2(mux_113_nl, (fsm_output[7]), fsm_output[6]);
  assign mux_116_nl = MUX_s_1_2_2(mux_115_nl, mux_114_nl, fsm_output[3]);
  assign or_145_nl = (fsm_output[2]) | (fsm_output[0]) | (fsm_output[1]) | (fsm_output[7])
      | (fsm_output[5]) | (fsm_output[4]);
  assign or_143_nl = (fsm_output[1]) | (fsm_output[7]) | not_tmp_145;
  assign mux_117_nl = MUX_s_1_2_2(or_143_nl, or_137_cse, fsm_output[0]);
  assign mux_120_nl = MUX_s_1_2_2(mux_112_cse, mux_117_nl, fsm_output[2]);
  assign mux_121_nl = MUX_s_1_2_2(or_145_nl, mux_120_nl, fsm_output[3]);
  assign nor_95_nl = ~((fsm_output[5]) | (~ or_tmp_99));
  assign mux_126_nl = MUX_s_1_2_2(nor_95_nl, or_tmp_99, or_41_cse);
  assign mux_127_nl = MUX_s_1_2_2(mux_126_nl, or_tmp_99, fsm_output[0]);
  assign and_274_nl = nor_91_cse & not_tmp_8;
  assign mux_128_nl = MUX_s_1_2_2(or_tmp_99, mux_127_nl, and_274_nl);
  assign or_151_nl = (~ (fsm_output[3])) | (~ (fsm_output[4])) | (fsm_output[7])
      | (fsm_output[1]) | (~ (fsm_output[5]));
  assign mux_124_nl = MUX_s_1_2_2(or_tmp_96, or_151_nl, fsm_output[2]);
  assign or_147_nl = (fsm_output[4]) | (fsm_output[7]) | (~ (fsm_output[1])) | (fsm_output[5]);
  assign mux_122_nl = MUX_s_1_2_2(or_147_nl, or_137_cse, fsm_output[3]);
  assign mux_123_nl = MUX_s_1_2_2(or_tmp_96, mux_122_nl, fsm_output[2]);
  assign mux_125_nl = MUX_s_1_2_2(mux_124_nl, mux_123_nl, fsm_output[0]);
  assign mux_98_nl = MUX_s_1_2_2(mux_tmp_53, or_tmp_73, fsm_output[3]);
  assign mux_99_nl = MUX_s_1_2_2(mux_98_nl, or_tmp_72, or_59_cse);
  assign or_99_nl = (fsm_output[4:3]!=2'b00);
  assign mux_100_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), or_99_nl);
  assign mux_101_nl = MUX_s_1_2_2(mux_100_nl, or_tmp_72, or_59_cse);
  assign COPY_LOOP_1_i_mux_nl = MUX_v_10_2_2(({(COPY_LOOP_1_i_10_0_sva_1_10_9[0])
      , COPY_LOOP_1_i_10_0_sva_1_8_0}), COMP_LOOP_f2_lshift_itm, COPY_LOOP_1_i_10_0_sva_9_0_mx0c2);
  assign COPY_LOOP_1_i_not_nl = ~ COPY_LOOP_1_i_10_0_sva_9_0_mx0c0;
  assign nl_COMP_LOOP_r_9_0_sva_1  = conv_u2u_9_10(COPY_LOOP_1_i_10_0_sva_1_8_0)
      + 10'b0000000001;
  assign operator_66_true_mux_43_nl = MUX_v_2_2_2((operator_64_false_acc_psp_sva_mx0w0[28:27]),
      (operator_64_false_acc_psp_sva_63_0[30:29]), and_dcpl_101);
  assign operator_66_true_mux_44_nl = MUX_v_24_2_2(24'b011001100110011001100110,
      24'b100110011001100110011001, and_dcpl_101);
  assign z_out_27_0 = conv_u2u_28_28(operator_66_true_mux_43_nl * (signext_26_25({operator_66_true_mux_44_nl
      , 1'b1})));
  assign operator_66_true_mux_45_nl = MUX_v_2_2_2((operator_64_false_acc_psp_sva_mx0w0[46:45]),
      (operator_64_false_acc_psp_sva_63_0[48:47]), and_137_cse);
  assign operator_66_true_mux_46_nl = MUX_v_42_2_2(42'b011001100110011001100110011001100110011001,
      42'b100110011001100110011001100110011001100110, and_137_cse);
  assign z_out_1_45_0 = conv_u2u_46_46(operator_66_true_mux_45_nl * (signext_44_43({operator_66_true_mux_46_nl
      , 1'b1})));
  assign operator_66_true_mux_47_nl = MUX_v_4_2_2(z_out_11, ({1'b0 , (z_out_5[3:1])}),
      and_dcpl_123);
  assign nl_operator_66_true_acc_73_nl = conv_u2u_2_4(operator_64_false_acc_psp_sva_mx0w0[10:9])
      + conv_u2u_2_4(~ (operator_64_false_acc_psp_sva_mx0w0[12:11])) + conv_u2u_2_4(operator_64_false_acc_psp_sva_mx0w0[14:13])
      + conv_u2u_2_4(~ (operator_64_false_acc_psp_sva_mx0w0[16:15]));
  assign operator_66_true_acc_73_nl = nl_operator_66_true_acc_73_nl[3:0];
  assign operator_66_true_mux_48_nl = MUX_v_4_2_2(operator_66_true_acc_73_nl, 4'b1011,
      and_dcpl_123);
  assign nl_z_out_2 = conv_u2u_4_5(operator_66_true_mux_47_nl) + conv_u2u_4_5(operator_66_true_mux_48_nl);
  assign z_out_2 = nl_z_out_2[4:0];
  assign operator_66_true_mux_49_nl = MUX_v_2_2_2((operator_64_false_acc_psp_sva_mx0w0[62:61]),
      (operator_66_true_acc_psp_sva[3:2]), and_137_cse);
  assign operator_66_true_mux_50_nl = MUX_v_2_2_2((~ (operator_64_false_acc_psp_sva_mx0w0[64:63])),
      ({(operator_66_true_acc_psp_sva[4]) , (operator_66_true_acc_psp_sva[4])}),
      and_137_cse);
  assign nl_acc_1_nl = conv_u2u_3_4({operator_66_true_mux_49_nl , 1'b1}) + conv_u2u_3_4({operator_66_true_mux_50_nl
      , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[3:0];
  assign z_out_3 = readslicef_4_3_1(acc_1_nl);
  assign nl_operator_66_true_acc_76_nl = conv_u2u_5_6(z_out_2) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[18:17])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[20:19])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[26:25])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[28:27])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[30:29])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[32:31])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[22:21])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[24:23]));
  assign operator_66_true_acc_76_nl = nl_operator_66_true_acc_76_nl[5:0];
  assign nl_operator_66_true_acc_84_nl = ({1'b1 , (~ (operator_64_false_acc_psp_sva_63_0[8:7]))})
      + conv_u2s_1_3(operator_66_true_acc_psp_sva[6]) + 3'b001;
  assign operator_66_true_acc_84_nl = nl_operator_66_true_acc_84_nl[2:0];
  assign nl_operator_66_true_mul_29_nl = $signed(operator_66_true_acc_84_nl) * $signed(5'b10011);
  assign operator_66_true_mul_29_nl = nl_operator_66_true_mul_29_nl[6:0];
  assign operator_66_true_mux_51_nl = MUX_v_7_2_2(({1'b0 , operator_66_true_acc_76_nl}),
      operator_66_true_mul_29_nl, and_169_cse);
  assign operator_66_true_and_4_nl = operator_64_false_acc_psp_sva_64 & (~ (operator_66_true_acc_2_psp_sva_1[2]))
      & ((operator_66_true_acc_2_psp_sva_1[1:0]!=2'b00) | (operator_64_false_acc_psp_sva_63_0[0]))
      & (~(and_dcpl_8 & nor_71_cse & and_dcpl_144));
  assign nl_operator_66_true_acc_85_nl = conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[34:33])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[36:35])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[38:37])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[40:39])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[42:41])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[44:43])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[46:45])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[48:47])) + conv_u2u_3_6(z_out_3)
      + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[58:57]) + conv_u2u_2_6(~
      (operator_64_false_acc_psp_sva_mx0w0[60:59])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[50:49])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[52:51])) + conv_u2u_2_6(operator_64_false_acc_psp_sva_mx0w0[54:53])
      + conv_u2u_2_6(~ (operator_64_false_acc_psp_sva_mx0w0[56:55]));
  assign operator_66_true_acc_85_nl = nl_operator_66_true_acc_85_nl[5:0];
  assign nl_operator_66_true_acc_100_nl = conv_s2s_3_5(z_out_11[2:0]) + conv_u2s_3_5(z_out_3)
      + conv_u2s_1_5(~ (operator_66_true_acc_4_psp_sva_1[3]));
  assign operator_66_true_acc_100_nl = nl_operator_66_true_acc_100_nl[4:0];
  assign operator_66_true_operator_66_true_nand_1_nl = ~((operator_66_true_acc_2_psp_sva_1[2])
      & (~ operator_64_false_acc_psp_sva_64));
  assign nl_operator_66_true_acc_99_nl = conv_s2s_5_6(operator_66_true_acc_100_nl)
      + conv_u2s_4_6({(operator_66_true_acc_psp_sva[5]) , (operator_64_false_acc_psp_sva_63_0[6:5])
      , (operator_66_true_acc_4_psp_sva_1[2])}) + conv_u2s_1_6(operator_66_true_operator_66_true_nand_1_nl);
  assign operator_66_true_acc_99_nl = nl_operator_66_true_acc_99_nl[5:0];
  assign operator_66_true_mux_52_nl = MUX_v_7_2_2(({1'b0 , operator_66_true_acc_85_nl}),
      (signext_7_6(operator_66_true_acc_99_nl)), and_169_cse);
  assign nl_acc_2_nl = conv_s2u_8_9({operator_66_true_mux_51_nl , operator_66_true_and_4_nl})
      + conv_s2u_8_9({operator_66_true_mux_52_nl , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[8:0];
  assign z_out_4 = readslicef_9_8_1(acc_2_nl);
  assign and_276_nl = and_dcpl_40 & (fsm_output[3]) & (fsm_output[1]) & and_dcpl_144;
  assign COPY_LOOP_1_or_2_nl = (nor_91_cse & (fsm_output[5:0]==6'b100001)) | and_dcpl_164;
  assign COPY_LOOP_1_mux1h_2_nl = MUX1HOT_v_10_3_2(COPY_LOOP_1_i_10_0_sva_9_0, operator_66_true_mul_2_itm,
      ({{6{TWIDDLE_LOOP_i_3_0_sva[3]}}, TWIDDLE_LOOP_i_3_0_sva}), {and_276_nl , and_dcpl_154
      , COPY_LOOP_1_or_2_nl});
  assign COPY_LOOP_1_mux_1_nl = MUX_v_9_2_2(9'b000000001, operator_66_true_acc_45_itm,
      and_dcpl_154);
  assign COPY_LOOP_1_COPY_LOOP_1_or_1_nl = MUX_v_9_2_2(COPY_LOOP_1_mux_1_nl, 9'b111111111,
      and_dcpl_164);
  assign nl_z_out_5 = conv_u2u_10_11(COPY_LOOP_1_mux1h_2_nl) + conv_s2u_9_11(COPY_LOOP_1_COPY_LOOP_1_or_1_nl);
  assign z_out_5 = nl_z_out_5[10:0];
  assign operator_66_true_mux_53_nl = MUX_v_64_2_2(({62'b00000000000000000000000000000000000000000000000000000000000000
      , (operator_64_false_acc_psp_sva_63_0[62:61])}), modExp_dev_result_1_sva, and_dcpl_175);
  assign operator_66_true_mux_54_nl = MUX_v_64_2_2(64'b0000001100110011001100110011001100110011001100110011001100110011,
      modExp_dev_base_sva, and_dcpl_175);
  assign nl_z_out_6 = operator_66_true_mux_53_nl * operator_66_true_mux_54_nl;
  assign z_out_6 = nl_z_out_6[63:0];
  assign not_356_nl = ~ and_dcpl_188;
  assign TWIDDLE_LOOP_TWIDDLE_LOOP_and_1_nl = MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000000,
      witer_sva, not_356_nl);
  assign TWIDDLE_LOOP_mux_3_nl = MUX_v_64_2_2(modExp_dev_result_1_sva, ({{54{COPY_LOOP_1_i_10_0_sva_9_0[9]}},
      COPY_LOOP_1_i_10_0_sva_9_0}), and_dcpl_188);
  assign nl_z_out_7 = TWIDDLE_LOOP_TWIDDLE_LOOP_and_1_nl * TWIDDLE_LOOP_mux_3_nl;
  assign z_out_7 = nl_z_out_7[63:0];
  assign operator_66_true_mux_55_nl = MUX_v_64_2_2(({4'b0000 , operator_66_true_mul_27_itm}),
      operator_64_false_acc_psp_sva_63_0, and_dcpl_202);
  assign nl_operator_66_true_acc_103_nl = conv_u2s_54_55(operator_66_true_mul_24_itm)
      + conv_s2s_53_55(operator_66_true_acc_67_itm);
  assign operator_66_true_acc_103_nl = nl_operator_66_true_acc_103_nl[54:0];
  assign nl_operator_66_true_acc_102_nl = conv_u2s_56_57(operator_66_true_mul_25_itm)
      + conv_s2s_55_57(operator_66_true_acc_103_nl);
  assign operator_66_true_acc_102_nl = nl_operator_66_true_acc_102_nl[56:0];
  assign nl_operator_66_true_acc_101_nl = conv_u2s_58_59(operator_66_true_mul_26_itm)
      + conv_s2s_57_59(operator_66_true_acc_102_nl);
  assign operator_66_true_acc_101_nl = nl_operator_66_true_acc_101_nl[58:0];
  assign operator_66_true_mux_56_nl = MUX_v_64_2_2((signext_64_59(operator_66_true_acc_101_nl)),
      modulo_dev_1_mux_cse, and_dcpl_202);
  assign nl_z_out_8 = operator_66_true_mux_55_nl + operator_66_true_mux_56_nl;
  assign z_out_8 = nl_z_out_8[63:0];
  assign and_278_nl = nor_91_cse & and_dcpl_6 & (fsm_output[3]) & (~ (fsm_output[1]))
      & and_dcpl_144;
  assign operator_64_false_mux_3_nl = MUX_v_64_2_2((signext_64_63(~ operator_66_true_operator_66_true_acc_psp_1)),
      (~ modExp_dev_exp_sva_4), and_278_nl);
  assign nl_operator_64_false_acc_nl = ({1'b1 , operator_64_false_mux_3_nl}) + 65'b00000000000000000000000000000000000000000000000000000000000000001;
  assign operator_64_false_acc_nl = nl_operator_64_false_acc_nl[64:0];
  assign z_out_9_64 = readslicef_65_1_64(operator_64_false_acc_nl);
  assign operator_66_true_mux_57_nl = MUX_v_4_2_2(({3'b000 , (~ (operator_66_true_acc_4_psp_sva_1[2]))}),
      (z_out_5[3:0]), and_dcpl_226);
  assign operator_66_true_or_3_nl = (~ (operator_66_true_acc_4_psp_sva_1[3])) | and_dcpl_226;
  assign nl_z_out_10 = conv_u2u_4_5(operator_66_true_mux_57_nl) + conv_s2u_1_5(operator_66_true_or_3_nl);
  assign z_out_10 = nl_z_out_10[4:0];
  assign nl_operator_66_true_acc_104_nl = conv_u2u_2_3(operator_64_false_acc_psp_sva_mx0w0[2:1])
      + conv_u2u_2_3(~ (operator_64_false_acc_psp_sva_mx0w0[4:3]));
  assign operator_66_true_acc_104_nl = nl_operator_66_true_acc_104_nl[2:0];
  assign operator_66_true_mux_58_nl = MUX_v_3_2_2(operator_66_true_acc_104_nl, ({1'b1
      , (operator_64_false_acc_psp_sva_63_0[4:3])}), and_169_cse);
  assign operator_66_true_operator_66_true_nor_1_nl = ~((operator_66_true_acc_psp_sva[5])
      | (and_dcpl_8 & nor_71_cse & and_dcpl_144));
  assign nl_operator_66_true_acc_105_nl = conv_u2u_2_3(operator_64_false_acc_psp_sva_mx0w0[6:5])
      + conv_u2u_2_3(~ (operator_64_false_acc_psp_sva_mx0w0[8:7]));
  assign operator_66_true_acc_105_nl = nl_operator_66_true_acc_105_nl[2:0];
  assign operator_66_true_mux_59_nl = MUX_v_3_2_2(operator_66_true_acc_105_nl, ({1'b0
      , (operator_64_false_acc_psp_sva_63_0[6:5])}), and_169_cse);
  assign nl_acc_7_nl = conv_u2u_4_5({operator_66_true_mux_58_nl , operator_66_true_operator_66_true_nor_1_nl})
      + conv_u2u_4_5({operator_66_true_mux_59_nl , 1'b1});
  assign acc_7_nl = nl_acc_7_nl[4:0];
  assign z_out_11 = readslicef_5_4_1(acc_7_nl);

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


  function automatic [63:0] MUX1HOT_v_64_9_2;
    input [63:0] input_8;
    input [63:0] input_7;
    input [63:0] input_6;
    input [63:0] input_5;
    input [63:0] input_4;
    input [63:0] input_3;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [8:0] sel;
    reg [63:0] result;
  begin
    result = input_0 & {64{sel[0]}};
    result = result | ( input_1 & {64{sel[1]}});
    result = result | ( input_2 & {64{sel[2]}});
    result = result | ( input_3 & {64{sel[3]}});
    result = result | ( input_4 & {64{sel[4]}});
    result = result | ( input_5 & {64{sel[5]}});
    result = result | ( input_6 & {64{sel[6]}});
    result = result | ( input_7 & {64{sel[7]}});
    result = result | ( input_8 & {64{sel[8]}});
    MUX1HOT_v_64_9_2 = result;
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


  function automatic [23:0] MUX_v_24_2_2;
    input [23:0] input_0;
    input [23:0] input_1;
    input [0:0] sel;
    reg [23:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_24_2_2 = result;
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


  function automatic [41:0] MUX_v_42_2_2;
    input [41:0] input_0;
    input [41:0] input_1;
    input [0:0] sel;
    reg [41:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_42_2_2 = result;
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


  function automatic [64:0] MUX_v_65_2_2;
    input [64:0] input_0;
    input [64:0] input_1;
    input [0:0] sel;
    reg [64:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_65_2_2 = result;
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


  function automatic [2:0] readslicef_4_3_1;
    input [3:0] vector;
    reg [3:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_4_3_1 = tmp[2:0];
  end
  endfunction


  function automatic [3:0] readslicef_5_4_1;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_5_4_1 = tmp[3:0];
  end
  endfunction


  function automatic [0:0] readslicef_65_1_64;
    input [64:0] vector;
    reg [64:0] tmp;
  begin
    tmp = vector >> 64;
    readslicef_65_1_64 = tmp[0:0];
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


  function automatic [25:0] signext_26_25;
    input [24:0] vector;
  begin
    signext_26_25= {{1{vector[24]}}, vector};
  end
  endfunction


  function automatic [43:0] signext_44_43;
    input [42:0] vector;
  begin
    signext_44_43= {{1{vector[42]}}, vector};
  end
  endfunction


  function automatic [63:0] signext_64_59;
    input [58:0] vector;
  begin
    signext_64_59= {{5{vector[58]}}, vector};
  end
  endfunction


  function automatic [63:0] signext_64_63;
    input [62:0] vector;
  begin
    signext_64_63= {{1{vector[62]}}, vector};
  end
  endfunction


  function automatic [6:0] signext_7_6;
    input [5:0] vector;
  begin
    signext_7_6= {{1{vector[5]}}, vector};
  end
  endfunction


  function automatic [4:0] conv_s2s_3_5 ;
    input [2:0]  vector ;
  begin
    conv_s2s_3_5 = {{2{vector[2]}}, vector};
  end
  endfunction


  function automatic [5:0] conv_s2s_5_6 ;
    input [4:0]  vector ;
  begin
    conv_s2s_5_6 = {vector[4], vector};
  end
  endfunction


  function automatic [8:0] conv_s2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_s2s_8_9 = {vector[7], vector};
  end
  endfunction


  function automatic [12:0] conv_s2s_11_13 ;
    input [10:0]  vector ;
  begin
    conv_s2s_11_13 = {{2{vector[10]}}, vector};
  end
  endfunction


  function automatic [14:0] conv_s2s_13_15 ;
    input [12:0]  vector ;
  begin
    conv_s2s_13_15 = {{2{vector[12]}}, vector};
  end
  endfunction


  function automatic [16:0] conv_s2s_15_17 ;
    input [14:0]  vector ;
  begin
    conv_s2s_15_17 = {{2{vector[14]}}, vector};
  end
  endfunction


  function automatic [18:0] conv_s2s_17_19 ;
    input [16:0]  vector ;
  begin
    conv_s2s_17_19 = {{2{vector[16]}}, vector};
  end
  endfunction


  function automatic [20:0] conv_s2s_19_21 ;
    input [18:0]  vector ;
  begin
    conv_s2s_19_21 = {{2{vector[18]}}, vector};
  end
  endfunction


  function automatic [22:0] conv_s2s_21_23 ;
    input [20:0]  vector ;
  begin
    conv_s2s_21_23 = {{2{vector[20]}}, vector};
  end
  endfunction


  function automatic [24:0] conv_s2s_23_25 ;
    input [22:0]  vector ;
  begin
    conv_s2s_23_25 = {{2{vector[22]}}, vector};
  end
  endfunction


  function automatic [26:0] conv_s2s_25_27 ;
    input [24:0]  vector ;
  begin
    conv_s2s_25_27 = {{2{vector[24]}}, vector};
  end
  endfunction


  function automatic [28:0] conv_s2s_27_29 ;
    input [26:0]  vector ;
  begin
    conv_s2s_27_29 = {{2{vector[26]}}, vector};
  end
  endfunction


  function automatic [30:0] conv_s2s_29_31 ;
    input [28:0]  vector ;
  begin
    conv_s2s_29_31 = {{2{vector[28]}}, vector};
  end
  endfunction


  function automatic [32:0] conv_s2s_31_33 ;
    input [30:0]  vector ;
  begin
    conv_s2s_31_33 = {{2{vector[30]}}, vector};
  end
  endfunction


  function automatic [34:0] conv_s2s_33_35 ;
    input [32:0]  vector ;
  begin
    conv_s2s_33_35 = {{2{vector[32]}}, vector};
  end
  endfunction


  function automatic [36:0] conv_s2s_35_37 ;
    input [34:0]  vector ;
  begin
    conv_s2s_35_37 = {{2{vector[34]}}, vector};
  end
  endfunction


  function automatic [38:0] conv_s2s_37_39 ;
    input [36:0]  vector ;
  begin
    conv_s2s_37_39 = {{2{vector[36]}}, vector};
  end
  endfunction


  function automatic [40:0] conv_s2s_39_41 ;
    input [38:0]  vector ;
  begin
    conv_s2s_39_41 = {{2{vector[38]}}, vector};
  end
  endfunction


  function automatic [42:0] conv_s2s_41_43 ;
    input [40:0]  vector ;
  begin
    conv_s2s_41_43 = {{2{vector[40]}}, vector};
  end
  endfunction


  function automatic [44:0] conv_s2s_43_45 ;
    input [42:0]  vector ;
  begin
    conv_s2s_43_45 = {{2{vector[42]}}, vector};
  end
  endfunction


  function automatic [46:0] conv_s2s_45_47 ;
    input [44:0]  vector ;
  begin
    conv_s2s_45_47 = {{2{vector[44]}}, vector};
  end
  endfunction


  function automatic [48:0] conv_s2s_47_49 ;
    input [46:0]  vector ;
  begin
    conv_s2s_47_49 = {{2{vector[46]}}, vector};
  end
  endfunction


  function automatic [50:0] conv_s2s_49_51 ;
    input [48:0]  vector ;
  begin
    conv_s2s_49_51 = {{2{vector[48]}}, vector};
  end
  endfunction


  function automatic [52:0] conv_s2s_51_53 ;
    input [50:0]  vector ;
  begin
    conv_s2s_51_53 = {{2{vector[50]}}, vector};
  end
  endfunction


  function automatic [54:0] conv_s2s_53_55 ;
    input [52:0]  vector ;
  begin
    conv_s2s_53_55 = {{2{vector[52]}}, vector};
  end
  endfunction


  function automatic [56:0] conv_s2s_55_57 ;
    input [54:0]  vector ;
  begin
    conv_s2s_55_57 = {{2{vector[54]}}, vector};
  end
  endfunction


  function automatic [58:0] conv_s2s_57_59 ;
    input [56:0]  vector ;
  begin
    conv_s2s_57_59 = {{2{vector[56]}}, vector};
  end
  endfunction


  function automatic [62:0] conv_s2s_61_63 ;
    input [60:0]  vector ;
  begin
    conv_s2s_61_63 = {{2{vector[60]}}, vector};
  end
  endfunction


  function automatic [4:0] conv_s2u_1_5 ;
    input [0:0]  vector ;
  begin
    conv_s2u_1_5 = {{4{vector[0]}}, vector};
  end
  endfunction


  function automatic [2:0] conv_s2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_3 = {vector[1], vector};
  end
  endfunction


  function automatic [7:0] conv_s2u_8_8 ;
    input [7:0]  vector ;
  begin
    conv_s2u_8_8 = vector;
  end
  endfunction


  function automatic [8:0] conv_s2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_s2u_8_9 = {vector[7], vector};
  end
  endfunction


  function automatic [10:0] conv_s2u_9_11 ;
    input [8:0]  vector ;
  begin
    conv_s2u_9_11 = {{2{vector[8]}}, vector};
  end
  endfunction


  function automatic [2:0] conv_u2s_1_3 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_3 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [4:0] conv_u2s_1_5 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_5 = {{4{1'b0}}, vector};
  end
  endfunction


  function automatic [5:0] conv_u2s_1_6 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_6 = {{5{1'b0}}, vector};
  end
  endfunction


  function automatic [4:0] conv_u2s_3_5 ;
    input [2:0]  vector ;
  begin
    conv_u2s_3_5 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [5:0] conv_u2s_4_6 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_6 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [8:0] conv_u2s_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2s_8_9 =  {1'b0, vector};
  end
  endfunction


  function automatic [12:0] conv_u2s_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2s_12_13 =  {1'b0, vector};
  end
  endfunction


  function automatic [14:0] conv_u2s_14_15 ;
    input [13:0]  vector ;
  begin
    conv_u2s_14_15 =  {1'b0, vector};
  end
  endfunction


  function automatic [16:0] conv_u2s_16_17 ;
    input [15:0]  vector ;
  begin
    conv_u2s_16_17 =  {1'b0, vector};
  end
  endfunction


  function automatic [18:0] conv_u2s_18_19 ;
    input [17:0]  vector ;
  begin
    conv_u2s_18_19 =  {1'b0, vector};
  end
  endfunction


  function automatic [20:0] conv_u2s_20_21 ;
    input [19:0]  vector ;
  begin
    conv_u2s_20_21 =  {1'b0, vector};
  end
  endfunction


  function automatic [22:0] conv_u2s_22_23 ;
    input [21:0]  vector ;
  begin
    conv_u2s_22_23 =  {1'b0, vector};
  end
  endfunction


  function automatic [24:0] conv_u2s_24_25 ;
    input [23:0]  vector ;
  begin
    conv_u2s_24_25 =  {1'b0, vector};
  end
  endfunction


  function automatic [26:0] conv_u2s_26_27 ;
    input [25:0]  vector ;
  begin
    conv_u2s_26_27 =  {1'b0, vector};
  end
  endfunction


  function automatic [28:0] conv_u2s_28_29 ;
    input [27:0]  vector ;
  begin
    conv_u2s_28_29 =  {1'b0, vector};
  end
  endfunction


  function automatic [30:0] conv_u2s_30_31 ;
    input [29:0]  vector ;
  begin
    conv_u2s_30_31 =  {1'b0, vector};
  end
  endfunction


  function automatic [32:0] conv_u2s_32_33 ;
    input [31:0]  vector ;
  begin
    conv_u2s_32_33 =  {1'b0, vector};
  end
  endfunction


  function automatic [34:0] conv_u2s_34_35 ;
    input [33:0]  vector ;
  begin
    conv_u2s_34_35 =  {1'b0, vector};
  end
  endfunction


  function automatic [36:0] conv_u2s_36_37 ;
    input [35:0]  vector ;
  begin
    conv_u2s_36_37 =  {1'b0, vector};
  end
  endfunction


  function automatic [38:0] conv_u2s_38_39 ;
    input [37:0]  vector ;
  begin
    conv_u2s_38_39 =  {1'b0, vector};
  end
  endfunction


  function automatic [40:0] conv_u2s_40_41 ;
    input [39:0]  vector ;
  begin
    conv_u2s_40_41 =  {1'b0, vector};
  end
  endfunction


  function automatic [42:0] conv_u2s_42_43 ;
    input [41:0]  vector ;
  begin
    conv_u2s_42_43 =  {1'b0, vector};
  end
  endfunction


  function automatic [44:0] conv_u2s_44_45 ;
    input [43:0]  vector ;
  begin
    conv_u2s_44_45 =  {1'b0, vector};
  end
  endfunction


  function automatic [46:0] conv_u2s_46_47 ;
    input [45:0]  vector ;
  begin
    conv_u2s_46_47 =  {1'b0, vector};
  end
  endfunction


  function automatic [48:0] conv_u2s_48_49 ;
    input [47:0]  vector ;
  begin
    conv_u2s_48_49 =  {1'b0, vector};
  end
  endfunction


  function automatic [50:0] conv_u2s_50_51 ;
    input [49:0]  vector ;
  begin
    conv_u2s_50_51 =  {1'b0, vector};
  end
  endfunction


  function automatic [52:0] conv_u2s_52_53 ;
    input [51:0]  vector ;
  begin
    conv_u2s_52_53 =  {1'b0, vector};
  end
  endfunction


  function automatic [54:0] conv_u2s_54_55 ;
    input [53:0]  vector ;
  begin
    conv_u2s_54_55 =  {1'b0, vector};
  end
  endfunction


  function automatic [56:0] conv_u2s_56_57 ;
    input [55:0]  vector ;
  begin
    conv_u2s_56_57 =  {1'b0, vector};
  end
  endfunction


  function automatic [58:0] conv_u2s_58_59 ;
    input [57:0]  vector ;
  begin
    conv_u2s_58_59 =  {1'b0, vector};
  end
  endfunction


  function automatic [62:0] conv_u2s_62_63 ;
    input [61:0]  vector ;
  begin
    conv_u2s_62_63 =  {1'b0, vector};
  end
  endfunction


  function automatic [64:0] conv_u2s_64_65 ;
    input [63:0]  vector ;
  begin
    conv_u2s_64_65 =  {1'b0, vector};
  end
  endfunction


  function automatic [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction


  function automatic [3:0] conv_u2u_1_4 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_4 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [2:0] conv_u2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_3 = {1'b0, vector};
  end
  endfunction


  function automatic [3:0] conv_u2u_2_4 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_4 = {{2{1'b0}}, vector};
  end
  endfunction


  function automatic [5:0] conv_u2u_2_6 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_6 = {{4{1'b0}}, vector};
  end
  endfunction


  function automatic [3:0] conv_u2u_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_4 = {1'b0, vector};
  end
  endfunction


  function automatic [5:0] conv_u2u_3_6 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_6 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction


  function automatic [5:0] conv_u2u_5_6 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_6 = {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_10_10 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_10 = vector;
  end
  endfunction


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2u_12_12 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_12 = vector;
  end
  endfunction


  function automatic [13:0] conv_u2u_14_14 ;
    input [13:0]  vector ;
  begin
    conv_u2u_14_14 = vector;
  end
  endfunction


  function automatic [15:0] conv_u2u_16_16 ;
    input [15:0]  vector ;
  begin
    conv_u2u_16_16 = vector;
  end
  endfunction


  function automatic [17:0] conv_u2u_18_18 ;
    input [17:0]  vector ;
  begin
    conv_u2u_18_18 = vector;
  end
  endfunction


  function automatic [19:0] conv_u2u_20_20 ;
    input [19:0]  vector ;
  begin
    conv_u2u_20_20 = vector;
  end
  endfunction


  function automatic [21:0] conv_u2u_22_22 ;
    input [21:0]  vector ;
  begin
    conv_u2u_22_22 = vector;
  end
  endfunction


  function automatic [23:0] conv_u2u_24_24 ;
    input [23:0]  vector ;
  begin
    conv_u2u_24_24 = vector;
  end
  endfunction


  function automatic [27:0] conv_u2u_28_28 ;
    input [27:0]  vector ;
  begin
    conv_u2u_28_28 = vector;
  end
  endfunction


  function automatic [29:0] conv_u2u_30_30 ;
    input [29:0]  vector ;
  begin
    conv_u2u_30_30 = vector;
  end
  endfunction


  function automatic [31:0] conv_u2u_32_32 ;
    input [31:0]  vector ;
  begin
    conv_u2u_32_32 = vector;
  end
  endfunction


  function automatic [33:0] conv_u2u_34_34 ;
    input [33:0]  vector ;
  begin
    conv_u2u_34_34 = vector;
  end
  endfunction


  function automatic [35:0] conv_u2u_36_36 ;
    input [35:0]  vector ;
  begin
    conv_u2u_36_36 = vector;
  end
  endfunction


  function automatic [37:0] conv_u2u_38_38 ;
    input [37:0]  vector ;
  begin
    conv_u2u_38_38 = vector;
  end
  endfunction


  function automatic [39:0] conv_u2u_40_40 ;
    input [39:0]  vector ;
  begin
    conv_u2u_40_40 = vector;
  end
  endfunction


  function automatic [41:0] conv_u2u_42_42 ;
    input [41:0]  vector ;
  begin
    conv_u2u_42_42 = vector;
  end
  endfunction


  function automatic [45:0] conv_u2u_46_46 ;
    input [45:0]  vector ;
  begin
    conv_u2u_46_46 = vector;
  end
  endfunction


  function automatic [47:0] conv_u2u_48_48 ;
    input [47:0]  vector ;
  begin
    conv_u2u_48_48 = vector;
  end
  endfunction


  function automatic [49:0] conv_u2u_50_50 ;
    input [49:0]  vector ;
  begin
    conv_u2u_50_50 = vector;
  end
  endfunction


  function automatic [51:0] conv_u2u_52_52 ;
    input [51:0]  vector ;
  begin
    conv_u2u_52_52 = vector;
  end
  endfunction


  function automatic [53:0] conv_u2u_54_54 ;
    input [53:0]  vector ;
  begin
    conv_u2u_54_54 = vector;
  end
  endfunction


  function automatic [55:0] conv_u2u_56_56 ;
    input [55:0]  vector ;
  begin
    conv_u2u_56_56 = vector;
  end
  endfunction


  function automatic [57:0] conv_u2u_58_58 ;
    input [57:0]  vector ;
  begin
    conv_u2u_58_58 = vector;
  end
  endfunction


  function automatic [61:0] conv_u2u_62_62 ;
    input [61:0]  vector ;
  begin
    conv_u2u_62_62 = vector;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT
// ------------------------------------------------------------------


module peaceNTT (
  clk, rst, vec_rsc_adrb, vec_rsc_qb, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz,
      g_rsc_dat, g_rsc_triosy_lz, result_rsc_wadr, result_rsc_d, result_rsc_we, result_rsc_radr,
      result_rsc_q, result_rsc_triosy_lz
);
  input clk;
  input rst;
  output [9:0] vec_rsc_adrb;
  input [63:0] vec_rsc_qb;
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


  // Interconnect Declarations
  wire [63:0] vec_rsci_qb_d;
  wire vec_rsci_readB_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] result_rsci_d_d;
  wire [63:0] result_rsci_q_d;
  wire [9:0] result_rsci_wadr_d;
  wire result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire twiddle_rsci_clken_d;
  wire [63:0] twiddle_rsci_d_d;
  wire [63:0] twiddle_rsci_q_d;
  wire [9:0] twiddle_rsci_radr_d;
  wire [9:0] twiddle_rsci_wadr_d;
  wire twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire xt_rsci_clken_d;
  wire [63:0] xt_rsci_d_d;
  wire [63:0] xt_rsci_q_d;
  wire [9:0] xt_rsci_radr_d;
  wire xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire twiddle_rsc_clken;
  wire [63:0] twiddle_rsc_q;
  wire [9:0] twiddle_rsc_radr;
  wire twiddle_rsc_we;
  wire [63:0] twiddle_rsc_d;
  wire [9:0] twiddle_rsc_wadr;
  wire xt_rsc_clken;
  wire [63:0] xt_rsc_q;
  wire [9:0] xt_rsc_radr;
  wire xt_rsc_we;
  wire [63:0] xt_rsc_d;
  wire [9:0] xt_rsc_wadr;
  wire [9:0] vec_rsci_adrb_d_iff;
  wire result_rsci_we_d_iff;
  wire twiddle_rsci_we_d_iff;
  wire xt_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  BLOCK_1R1W_RBW #(.addr_width(32'sd10),
  .data_width(32'sd64),
  .depth(32'sd1024),
  .latency(32'sd1)) twiddle_rsc_comp (
      .clk(clk),
      .clken(twiddle_rsc_clken),
      .d(twiddle_rsc_d),
      .q(twiddle_rsc_q),
      .radr(twiddle_rsc_radr),
      .wadr(twiddle_rsc_wadr),
      .we(twiddle_rsc_we)
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
  peaceNTT_Xilinx_RAMS_BLOCK_2R1W_WBR_DUAL_rport_1_10_64_1024_1024_64_1_gen vec_rsci
      (
      .qb(vec_rsc_qb),
      .adrb(vec_rsc_adrb),
      .adrb_d(vec_rsci_adrb_d_iff),
      .qb_d(vec_rsci_qb_d),
      .readB_r_ram_ir_internal_RMASK_B_d(vec_rsci_readB_r_ram_ir_internal_RMASK_B_d)
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
      .radr_d(vec_rsci_adrb_d_iff),
      .wadr_d(result_rsci_wadr_d),
      .we_d(result_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(result_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(result_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_5_10_64_1024_1024_64_1_gen twiddle_rsci
      (
      .clken(twiddle_rsc_clken),
      .q(twiddle_rsc_q),
      .radr(twiddle_rsc_radr),
      .we(twiddle_rsc_we),
      .d(twiddle_rsc_d),
      .wadr(twiddle_rsc_wadr),
      .clken_d(twiddle_rsci_clken_d),
      .d_d(twiddle_rsci_d_d),
      .q_d(twiddle_rsci_q_d),
      .radr_d(twiddle_rsci_radr_d),
      .wadr_d(twiddle_rsci_wadr_d),
      .we_d(twiddle_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(twiddle_rsci_we_d_iff),
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
      .wadr_d(vec_rsci_adrb_d_iff),
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
      .g_rsc_dat(g_rsc_dat),
      .g_rsc_triosy_lz(g_rsc_triosy_lz),
      .result_rsc_triosy_lz(result_rsc_triosy_lz),
      .vec_rsci_qb_d(vec_rsci_qb_d),
      .vec_rsci_readB_r_ram_ir_internal_RMASK_B_d(vec_rsci_readB_r_ram_ir_internal_RMASK_B_d),
      .result_rsci_d_d(result_rsci_d_d),
      .result_rsci_q_d(result_rsci_q_d),
      .result_rsci_wadr_d(result_rsci_wadr_d),
      .result_rsci_readA_r_ram_ir_internal_RMASK_B_d(result_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsci_clken_d(twiddle_rsci_clken_d),
      .twiddle_rsci_d_d(twiddle_rsci_d_d),
      .twiddle_rsci_q_d(twiddle_rsci_q_d),
      .twiddle_rsci_radr_d(twiddle_rsci_radr_d),
      .twiddle_rsci_wadr_d(twiddle_rsci_wadr_d),
      .twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .xt_rsci_clken_d(xt_rsci_clken_d),
      .xt_rsci_d_d(xt_rsci_d_d),
      .xt_rsci_q_d(xt_rsci_q_d),
      .xt_rsci_radr_d(xt_rsci_radr_d),
      .xt_rsci_readA_r_ram_ir_internal_RMASK_B_d(xt_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .vec_rsci_adrb_d_pff(vec_rsci_adrb_d_iff),
      .result_rsci_we_d_pff(result_rsci_we_d_iff),
      .twiddle_rsci_we_d_pff(twiddle_rsci_we_d_iff),
      .xt_rsci_we_d_pff(xt_rsci_we_d_iff)
    );
endmodule



