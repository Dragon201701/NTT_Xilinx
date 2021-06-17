
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
//  Generated date: Wed Jun 16 22:25:07 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_12_64_4096_4096_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_12_64_4096_4096_64_1_gen (
  clken, q, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [63:0] q;
  output [11:0] radr;
  output we;
  output [63:0] d;
  output [11:0] wadr;
  input clken_d;
  input [63:0] d_d;
  output [63:0] q_d;
  input [11:0] radr_d;
  input [11:0] wadr_d;
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
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_5_12_64_4096_4096_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_5_12_64_4096_4096_64_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [11:0] radr;
  output [63:0] q_d;
  input [11:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_12_64_4096_4096_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_12_64_4096_4096_64_1_gen (
  q, radr, we, d, wadr, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [11:0] radr;
  output we;
  output [63:0] d;
  output [11:0] wadr;
  input [63:0] d_d;
  output [63:0] q_d;
  input [11:0] radr_d;
  input [11:0] wadr_d;
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
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_1_12_64_4096_4096_64_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_1_12_64_4096_4096_64_1_gen (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [11:0] radr;
  output [63:0] q_d;
  input [11:0] radr_d;
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
  clk, rst, fsm_output, COPY_LOOP_C_2_tr0, COMP_LOOP_C_65_tr0, COPY_LOOP_1_C_2_tr0,
      STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
  input COPY_LOOP_C_2_tr0;
  input COMP_LOOP_C_65_tr0;
  input COPY_LOOP_1_C_2_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for peaceNTT_core_core_fsm_1
  parameter
    main_C_0 = 7'd0,
    COPY_LOOP_C_0 = 7'd1,
    COPY_LOOP_C_1 = 7'd2,
    COPY_LOOP_C_2 = 7'd3,
    STAGE_LOOP_C_0 = 7'd4,
    COMP_LOOP_C_0 = 7'd5,
    COMP_LOOP_C_1 = 7'd6,
    COMP_LOOP_C_2 = 7'd7,
    COMP_LOOP_C_3 = 7'd8,
    COMP_LOOP_C_4 = 7'd9,
    COMP_LOOP_C_5 = 7'd10,
    COMP_LOOP_C_6 = 7'd11,
    COMP_LOOP_C_7 = 7'd12,
    COMP_LOOP_C_8 = 7'd13,
    COMP_LOOP_C_9 = 7'd14,
    COMP_LOOP_C_10 = 7'd15,
    COMP_LOOP_C_11 = 7'd16,
    COMP_LOOP_C_12 = 7'd17,
    COMP_LOOP_C_13 = 7'd18,
    COMP_LOOP_C_14 = 7'd19,
    COMP_LOOP_C_15 = 7'd20,
    COMP_LOOP_C_16 = 7'd21,
    COMP_LOOP_C_17 = 7'd22,
    COMP_LOOP_C_18 = 7'd23,
    COMP_LOOP_C_19 = 7'd24,
    COMP_LOOP_C_20 = 7'd25,
    COMP_LOOP_C_21 = 7'd26,
    COMP_LOOP_C_22 = 7'd27,
    COMP_LOOP_C_23 = 7'd28,
    COMP_LOOP_C_24 = 7'd29,
    COMP_LOOP_C_25 = 7'd30,
    COMP_LOOP_C_26 = 7'd31,
    COMP_LOOP_C_27 = 7'd32,
    COMP_LOOP_C_28 = 7'd33,
    COMP_LOOP_C_29 = 7'd34,
    COMP_LOOP_C_30 = 7'd35,
    COMP_LOOP_C_31 = 7'd36,
    COMP_LOOP_C_32 = 7'd37,
    COMP_LOOP_C_33 = 7'd38,
    COMP_LOOP_C_34 = 7'd39,
    COMP_LOOP_C_35 = 7'd40,
    COMP_LOOP_C_36 = 7'd41,
    COMP_LOOP_C_37 = 7'd42,
    COMP_LOOP_C_38 = 7'd43,
    COMP_LOOP_C_39 = 7'd44,
    COMP_LOOP_C_40 = 7'd45,
    COMP_LOOP_C_41 = 7'd46,
    COMP_LOOP_C_42 = 7'd47,
    COMP_LOOP_C_43 = 7'd48,
    COMP_LOOP_C_44 = 7'd49,
    COMP_LOOP_C_45 = 7'd50,
    COMP_LOOP_C_46 = 7'd51,
    COMP_LOOP_C_47 = 7'd52,
    COMP_LOOP_C_48 = 7'd53,
    COMP_LOOP_C_49 = 7'd54,
    COMP_LOOP_C_50 = 7'd55,
    COMP_LOOP_C_51 = 7'd56,
    COMP_LOOP_C_52 = 7'd57,
    COMP_LOOP_C_53 = 7'd58,
    COMP_LOOP_C_54 = 7'd59,
    COMP_LOOP_C_55 = 7'd60,
    COMP_LOOP_C_56 = 7'd61,
    COMP_LOOP_C_57 = 7'd62,
    COMP_LOOP_C_58 = 7'd63,
    COMP_LOOP_C_59 = 7'd64,
    COMP_LOOP_C_60 = 7'd65,
    COMP_LOOP_C_61 = 7'd66,
    COMP_LOOP_C_62 = 7'd67,
    COMP_LOOP_C_63 = 7'd68,
    COMP_LOOP_C_64 = 7'd69,
    COMP_LOOP_C_65 = 7'd70,
    COPY_LOOP_1_C_0 = 7'd71,
    COPY_LOOP_1_C_1 = 7'd72,
    COPY_LOOP_1_C_2 = 7'd73,
    STAGE_LOOP_C_1 = 7'd74,
    main_C_1 = 7'd75;

  reg [6:0] state_var;
  reg [6:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : peaceNTT_core_core_fsm_1
    case (state_var)
      COPY_LOOP_C_0 : begin
        fsm_output = 7'b0000001;
        state_var_NS = COPY_LOOP_C_1;
      end
      COPY_LOOP_C_1 : begin
        fsm_output = 7'b0000010;
        state_var_NS = COPY_LOOP_C_2;
      end
      COPY_LOOP_C_2 : begin
        fsm_output = 7'b0000011;
        if ( COPY_LOOP_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_0;
        end
        else begin
          state_var_NS = COPY_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_0 : begin
        fsm_output = 7'b0000100;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 7'b0000101;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 7'b0000110;
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 7'b0000111;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 7'b0001000;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 7'b0001001;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 7'b0001010;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 7'b0001011;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 7'b0001100;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 7'b0001101;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 7'b0001110;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 7'b0001111;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 7'b0010000;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 7'b0010001;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 7'b0010010;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 7'b0010011;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 7'b0010100;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 7'b0010101;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 7'b0010110;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 7'b0010111;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 7'b0011000;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 7'b0011001;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 7'b0011010;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 7'b0011011;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 7'b0011100;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 7'b0011101;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 7'b0011110;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 7'b0011111;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 7'b0100000;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 7'b0100001;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 7'b0100010;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 7'b0100011;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 7'b0100100;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 7'b0100101;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 7'b0100110;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 7'b0100111;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 7'b0101000;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 7'b0101001;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 7'b0101010;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 7'b0101011;
        state_var_NS = COMP_LOOP_C_39;
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 7'b0101100;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 7'b0101101;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 7'b0101110;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 7'b0101111;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 7'b0110000;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 7'b0110001;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 7'b0110010;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 7'b0110011;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 7'b0110100;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 7'b0110101;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 7'b0110110;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 7'b0110111;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 7'b0111000;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 7'b0111001;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 7'b0111010;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 7'b0111011;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 7'b0111100;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 7'b0111101;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 7'b0111110;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 7'b0111111;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 7'b1000000;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 7'b1000001;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 7'b1000010;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 7'b1000011;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 7'b1000100;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 7'b1000101;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 7'b1000110;
        if ( COMP_LOOP_C_65_tr0 ) begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      COPY_LOOP_1_C_0 : begin
        fsm_output = 7'b1000111;
        state_var_NS = COPY_LOOP_1_C_1;
      end
      COPY_LOOP_1_C_1 : begin
        fsm_output = 7'b1001000;
        state_var_NS = COPY_LOOP_1_C_2;
      end
      COPY_LOOP_1_C_2 : begin
        fsm_output = 7'b1001001;
        if ( COPY_LOOP_1_C_2_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 7'b1001010;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b1001011;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 7'b0000000;
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
  clk, xt_rsc_cgo_iro, xt_rsci_clken_d, COMP_LOOP_f2_rem_cmp_z, xt_rsc_cgo, COMP_LOOP_f2_rem_cmp_z_oreg
);
  input clk;
  input xt_rsc_cgo_iro;
  output xt_rsci_clken_d;
  input [63:0] COMP_LOOP_f2_rem_cmp_z;
  input xt_rsc_cgo;
  output [63:0] COMP_LOOP_f2_rem_cmp_z_oreg;
  reg [63:0] COMP_LOOP_f2_rem_cmp_z_oreg;



  // Interconnect Declarations for Component Instantiations 
  assign xt_rsci_clken_d = xt_rsc_cgo | xt_rsc_cgo_iro;
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
  output [11:0] result_rsci_wadr_d;
  output result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_rsci_q_d;
  output [11:0] twiddle_rsci_radr_d;
  output twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output xt_rsci_clken_d;
  output [63:0] xt_rsci_d_d;
  input [63:0] xt_rsci_q_d;
  output [11:0] xt_rsci_radr_d;
  output xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output [127:0] COMP_LOOP_f2_rem_cmp_a;
  output [63:0] COMP_LOOP_f2_rem_cmp_b;
  input [63:0] COMP_LOOP_f2_rem_cmp_z;
  output [11:0] vec_rsci_radr_d_pff;
  output result_rsci_we_d_pff;
  output xt_rsci_we_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  reg [64:0] COMP_LOOP_rem_cmp_a;
  wire [64:0] COMP_LOOP_rem_cmp_z;
  wire [63:0] COMP_LOOP_f2_rem_cmp_z_oreg;
  wire [6:0] fsm_output;
  wire or_tmp_7;
  wire mux_tmp_10;
  wire and_dcpl_4;
  wire and_dcpl_5;
  wire and_dcpl_6;
  wire and_dcpl_8;
  wire and_dcpl_11;
  wire and_dcpl_12;
  wire and_dcpl_13;
  wire or_tmp_14;
  wire nor_tmp_5;
  wire and_dcpl_18;
  wire and_dcpl_21;
  wire and_dcpl_24;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_30;
  wire mux_tmp_16;
  wire or_tmp_24;
  wire and_dcpl_46;
  wire mux_tmp_30;
  wire mux_tmp_34;
  reg [11:0] COPY_LOOP_1_i_12_0_sva_11_0;
  wire nor_24_ssc;
  reg [62:0] reg_COMP_LOOP_f2_rem_cmp_a_ftd;
  reg [64:0] reg_COMP_LOOP_f2_rem_cmp_a_ftd_1;
  reg reg_xt_rsc_cgo_cse;
  reg reg_vec_rsc_triosy_obj_ld_cse;
  reg [63:0] reg_COMP_LOOP_rem_cmp_b_63_0_cse;
  wire and_64_cse;
  wire nor_20_cse;
  wire or_48_cse;
  wire nor_30_rmff;
  reg [8:0] STAGE_LOOP_base_8_0_sva;
  wire [8:0] STAGE_LOOP_base_lshift_itm;
  wire mux_34_itm;
  wire [4:0] z_out;
  wire [5:0] nl_z_out;
  reg [63:0] p_sva;
  reg [3:0] STAGE_LOOP_base_acc_cse_sva;
  reg [64:0] COMP_LOOP_acc_mut;
  reg [127:0] COMP_LOOP_f2_mul_mut;
  wire [64:0] COMP_LOOP_acc_mut_mx0w0;
  wire [65:0] nl_COMP_LOOP_acc_mut_mx0w0;
  wire [127:0] COMP_LOOP_f2_mul_mut_mx0w0;
  wire COPY_LOOP_1_i_12_0_sva_11_0_mx0c2;
  wire [64:0] COMP_LOOP_acc_1_psp_mx0w1;
  wire [65:0] nl_COMP_LOOP_acc_1_psp_mx0w1;
  wire [12:0] COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt;
  wire [64:0] COMP_LOOP_COMP_LOOP_mux_rgt;
  reg [1:0] COPY_LOOP_1_i_12_0_sva_1_12_11;
  reg [10:0] COPY_LOOP_1_i_12_0_sva_1_10_0;
  reg COMP_LOOP_acc_1_psp_64;
  reg [63:0] COMP_LOOP_acc_1_psp_63_0;
  wire and_67_cse;
  wire nor_38_cse;
  wire or_55_cse;
  wire or_58_cse;
  wire nand_3_cse;

  wire[0:0] nor_17_nl;
  wire[0:0] mux_24_nl;
  wire[0:0] mux_23_nl;
  wire[0:0] or_20_nl;
  wire[0:0] or_19_nl;
  wire[0:0] and_40_nl;
  wire[0:0] mux_29_nl;
  wire[0:0] mux_28_nl;
  wire[0:0] or_23_nl;
  wire[0:0] mux_27_nl;
  wire[11:0] COPY_LOOP_1_i_mux_nl;
  wire[11:0] COMP_LOOP_acc_4_nl;
  wire[12:0] nl_COMP_LOOP_acc_4_nl;
  wire[0:0] COPY_LOOP_1_i_not_nl;
  wire[10:0] COMP_LOOP_r_COMP_LOOP_r_and_nl;
  wire[0:0] mux_46_nl;
  wire[12:0] COPY_LOOP_1_acc_1_nl;
  wire[13:0] nl_COPY_LOOP_1_acc_1_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] or_57_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] nor_36_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] and_94_nl;
  wire[0:0] and_59_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] and_93_nl;
  wire[0:0] or_13_nl;
  wire[0:0] mux_25_nl;
  wire[0:0] or_nl;
  wire[0:0] or_49_nl;
  wire[0:0] mux_10_nl;
  wire[0:0] or_59_nl;
  wire[0:0] mux_32_nl;
  wire[0:0] mux_31_nl;
  wire[0:0] mux_30_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] nand_nl;
  wire[0:0] nand_1_nl;
  wire[62:0] COMP_LOOP_f2_mux_nl;
  wire[0:0] COMP_LOOP_f2_nor_nl;
  wire[0:0] and_42_nl;
  wire[0:0] mux_22_nl;
  wire[0:0] or_17_nl;
  wire[10:0] COMP_LOOP_f2_and_nl;
  wire[0:0] and_25_nl;
  wire[9:0] COPY_LOOP_mux_1_nl;
  wire[0:0] COPY_LOOP_COPY_LOOP_and_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_COMP_LOOP_rem_cmp_b;
  assign nl_COMP_LOOP_rem_cmp_b = {1'b0, reg_COMP_LOOP_rem_cmp_b_63_0_cse};
  wire [3:0] nl_STAGE_LOOP_base_lshift_rg_s;
  assign nl_STAGE_LOOP_base_lshift_rg_s = z_out[3:0];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0 = COPY_LOOP_1_i_12_0_sva_1_12_11[1];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_65_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_65_tr0 = COPY_LOOP_1_i_12_0_sva_11_0[11];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0 = COPY_LOOP_1_i_12_0_sva_1_12_11[1];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = z_out[4];
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
  .signd(32'sd1)) COMP_LOOP_rem_cmp (
      .a(COMP_LOOP_rem_cmp_a),
      .b(nl_COMP_LOOP_rem_cmp_b[64:0]),
      .z(COMP_LOOP_rem_cmp_z)
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
      .xt_rsc_cgo_iro(nor_30_rmff),
      .xt_rsci_clken_d(xt_rsci_clken_d),
      .COMP_LOOP_f2_rem_cmp_z(COMP_LOOP_f2_rem_cmp_z),
      .xt_rsc_cgo(reg_xt_rsc_cgo_cse),
      .COMP_LOOP_f2_rem_cmp_z_oreg(COMP_LOOP_f2_rem_cmp_z_oreg)
    );
  peaceNTT_core_core_fsm peaceNTT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .COPY_LOOP_C_2_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_2_tr0[0:0]),
      .COMP_LOOP_C_65_tr0(nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_65_tr0[0:0]),
      .COPY_LOOP_1_C_2_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_2_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign or_20_nl = (~ (fsm_output[0])) | (~ (fsm_output[2])) | (fsm_output[3]);
  assign mux_23_nl = MUX_s_1_2_2(or_20_nl, (fsm_output[3]), fsm_output[1]);
  assign or_19_nl = (fsm_output[3:1]!=3'b100);
  assign mux_24_nl = MUX_s_1_2_2(mux_23_nl, or_19_nl, fsm_output[6]);
  assign nor_30_rmff = ~(mux_24_nl | (fsm_output[5:4]!=2'b00));
  assign and_67_cse = (fsm_output[0]) & (fsm_output[2]);
  assign COMP_LOOP_f2_rem_cmp_a = {reg_COMP_LOOP_f2_rem_cmp_a_ftd , reg_COMP_LOOP_f2_rem_cmp_a_ftd_1};
  assign COMP_LOOP_f2_rem_cmp_b = reg_COMP_LOOP_rem_cmp_b_63_0_cse;
  assign nor_20_cse = ~((fsm_output[4:3]!=2'b00));
  assign mux_46_nl = MUX_s_1_2_2(mux_tmp_34, (~ mux_tmp_30), fsm_output[6]);
  assign COMP_LOOP_r_COMP_LOOP_r_and_nl = MUX_v_11_2_2(11'b00000000000, (COPY_LOOP_1_i_12_0_sva_11_0[10:0]),
      mux_46_nl);
  assign nl_COPY_LOOP_1_acc_1_nl = conv_u2s_12_13(COPY_LOOP_1_i_12_0_sva_11_0) +
      13'b0000000000001;
  assign COPY_LOOP_1_acc_1_nl = nl_COPY_LOOP_1_acc_1_nl[12:0];
  assign mux_41_nl = MUX_s_1_2_2(and_dcpl_8, mux_tmp_30, fsm_output[6]);
  assign COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt = MUX_v_13_2_2(({2'b00 , COMP_LOOP_r_COMP_LOOP_r_and_nl}),
      COPY_LOOP_1_acc_1_nl, mux_41_nl);
  assign nor_38_cse = ~((fsm_output[5:3]!=3'b000));
  assign or_58_cse = (fsm_output[5:2]!=4'b0000);
  assign and_64_cse = (fsm_output[1:0]==2'b11);
  assign COMP_LOOP_COMP_LOOP_mux_rgt = MUX_v_65_2_2(({1'b0 , xt_rsci_q_d}), COMP_LOOP_acc_1_psp_mx0w1,
      and_dcpl_46);
  assign or_55_cse = (fsm_output[4:3]!=2'b00);
  assign nand_3_cse = ~((fsm_output[2:1]==2'b11));
  assign nl_COMP_LOOP_acc_mut_mx0w0 = ({1'b1 , COMP_LOOP_acc_1_psp_63_0}) + conv_u2s_64_65(~
      COMP_LOOP_f2_rem_cmp_z_oreg) + 65'b00000000000000000000000000000000000000000000000000000000000000001;
  assign COMP_LOOP_acc_mut_mx0w0 = nl_COMP_LOOP_acc_mut_mx0w0[64:0];
  assign COMP_LOOP_f2_mul_mut_mx0w0 = conv_u2u_128_128((COMP_LOOP_acc_mut[63:0])
      * COMP_LOOP_acc_1_psp_63_0);
  assign nl_COMP_LOOP_acc_1_psp_mx0w1 = conv_u2u_64_65(COMP_LOOP_acc_1_psp_63_0)
      + conv_u2u_64_65(COMP_LOOP_f2_rem_cmp_z_oreg);
  assign COMP_LOOP_acc_1_psp_mx0w1 = nl_COMP_LOOP_acc_1_psp_mx0w1[64:0];
  assign or_48_cse = (fsm_output[1:0]!=2'b00);
  assign or_tmp_7 = (fsm_output[5:3]!=3'b000);
  assign or_13_nl = (fsm_output[5]) | ((fsm_output[3:2]==2'b11)) | (fsm_output[4]);
  assign mux_tmp_10 = MUX_s_1_2_2(or_13_nl, or_tmp_7, and_64_cse);
  assign and_dcpl_4 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_5 = and_dcpl_4 & (~ (fsm_output[6]));
  assign and_dcpl_6 = ~((fsm_output[2]) | (fsm_output[5]));
  assign and_dcpl_8 = nor_20_cse & and_dcpl_6;
  assign and_dcpl_11 = (fsm_output[2]) & (~ (fsm_output[5]));
  assign and_dcpl_12 = nor_20_cse & and_dcpl_11;
  assign and_dcpl_13 = and_dcpl_12 & and_dcpl_4 & (fsm_output[6]);
  assign or_tmp_14 = (fsm_output[5:2]!=4'b0001);
  assign nor_tmp_5 = (fsm_output[4:3]==2'b11);
  assign and_dcpl_18 = and_dcpl_12 & and_dcpl_5;
  assign and_dcpl_21 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_24 = (fsm_output[4:3]==2'b01) & and_dcpl_6;
  assign and_dcpl_27 = (~ (fsm_output[0])) & (fsm_output[1]) & (~ (fsm_output[6]));
  assign and_dcpl_28 = and_dcpl_12 & and_dcpl_27;
  assign or_nl = (~ (fsm_output[1])) | (fsm_output[3]);
  assign or_49_nl = (fsm_output[1]) | (~ (fsm_output[3]));
  assign mux_25_nl = MUX_s_1_2_2(or_nl, or_49_nl, fsm_output[6]);
  assign and_dcpl_30 = ~(mux_25_nl | (fsm_output[4]));
  assign mux_tmp_16 = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[3]);
  assign or_tmp_24 = (fsm_output[4:2]!=3'b000);
  assign and_dcpl_46 = nor_20_cse & (fsm_output[2]) & (fsm_output[5]) & and_dcpl_27;
  assign mux_tmp_30 = MUX_s_1_2_2(or_tmp_7, or_58_cse, fsm_output[0]);
  assign mux_tmp_34 = MUX_s_1_2_2(or_tmp_7, or_58_cse, or_48_cse);
  assign or_59_nl = (fsm_output[2:1]!=2'b00);
  assign mux_10_nl = MUX_s_1_2_2(or_59_nl, nand_3_cse, fsm_output[6]);
  assign COPY_LOOP_1_i_12_0_sva_11_0_mx0c2 = ~(mux_10_nl | (fsm_output[4]) | (fsm_output[3])
      | (fsm_output[5]) | (fsm_output[0]));
  assign mux_31_nl = MUX_s_1_2_2(nor_20_cse, or_55_cse, fsm_output[5]);
  assign mux_30_nl = MUX_s_1_2_2(nor_20_cse, or_tmp_24, fsm_output[5]);
  assign mux_32_nl = MUX_s_1_2_2(mux_31_nl, mux_30_nl, or_48_cse);
  assign nor_24_ssc = ~(mux_32_nl | (fsm_output[6]));
  assign nand_nl = ~((fsm_output[5]) & or_55_cse);
  assign nand_1_nl = ~((fsm_output[5]) & or_tmp_24);
  assign mux_33_nl = MUX_s_1_2_2(nand_nl, nand_1_nl, and_64_cse);
  assign mux_34_itm = MUX_s_1_2_2(mux_33_nl, or_58_cse, fsm_output[6]);
  assign vec_rsci_radr_d_pff = COPY_LOOP_1_i_12_0_sva_11_0;
  assign vec_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_8 & and_dcpl_5;
  assign result_rsci_d_d = MUX_v_64_2_2((COMP_LOOP_rem_cmp_z[63:0]), COMP_LOOP_f2_rem_cmp_z_oreg,
      and_dcpl_13);
  assign result_rsci_wadr_d = {(~ and_dcpl_13) , COPY_LOOP_1_i_12_0_sva_1_10_0};
  assign or_17_nl = (~ (fsm_output[5])) | (fsm_output[2]) | (~ nor_tmp_5);
  assign mux_22_nl = MUX_s_1_2_2(or_17_nl, or_tmp_14, fsm_output[6]);
  assign result_rsci_we_d_pff = (~ mux_22_nl) & and_dcpl_4;
  assign result_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_12 & and_64_cse
      & (fsm_output[6]);
  assign COMP_LOOP_f2_and_nl = COPY_LOOP_1_i_12_0_sva_1_10_0 & ({2'b11 , STAGE_LOOP_base_8_0_sva});
  assign twiddle_rsci_radr_d = {1'b0 , COMP_LOOP_f2_and_nl};
  assign twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_18;
  assign and_25_nl = and_dcpl_24 & and_dcpl_21 & (fsm_output[6]);
  assign xt_rsci_d_d = MUX_v_64_2_2(vec_rsci_q_d, result_rsci_q_d, and_25_nl);
  assign COPY_LOOP_mux_1_nl = MUX_v_10_2_2((COPY_LOOP_1_i_12_0_sva_1_10_0[9:0]),
      (COPY_LOOP_1_i_12_0_sva_1_10_0[10:1]), and_dcpl_28);
  assign COPY_LOOP_COPY_LOOP_and_nl = (COPY_LOOP_1_i_12_0_sva_1_10_0[0]) & and_dcpl_28;
  assign xt_rsci_radr_d = {COPY_LOOP_mux_1_nl , COPY_LOOP_COPY_LOOP_and_nl , 1'b0};
  assign xt_rsci_we_d_pff = and_dcpl_30 & and_dcpl_6 & (~ (fsm_output[0]));
  assign xt_rsci_readA_r_ram_ir_internal_RMASK_B_d = nor_20_cse & ((fsm_output[0])
      ^ (fsm_output[1])) & and_dcpl_11 & (~ (fsm_output[6]));
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(nor_17_nl, mux_tmp_10, fsm_output[6]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_xt_rsc_cgo_cse <= 1'b0;
      reg_vec_rsc_triosy_obj_ld_cse <= 1'b0;
    end
    else begin
      reg_xt_rsc_cgo_cse <= nor_30_rmff;
      reg_vec_rsc_triosy_obj_ld_cse <= and_dcpl_24 & (~ (fsm_output[0])) & (z_out[4])
          & (fsm_output[1]) & (fsm_output[6]);
    end
  end
  always @(posedge clk) begin
    COMP_LOOP_rem_cmp_a <= MUX_v_65_2_2(COMP_LOOP_acc_mut_mx0w0, COMP_LOOP_acc_mut,
        and_40_nl);
    reg_COMP_LOOP_rem_cmp_b_63_0_cse <= p_sva;
    reg_COMP_LOOP_f2_rem_cmp_a_ftd <= MUX_v_63_2_2(63'b000000000000000000000000000000000000000000000000000000000000000,
        COMP_LOOP_f2_mux_nl, COMP_LOOP_f2_nor_nl);
    reg_COMP_LOOP_f2_rem_cmp_a_ftd_1 <= MUX1HOT_v_65_4_2((COMP_LOOP_f2_mul_mut_mx0w0[64:0]),
        (COMP_LOOP_f2_mul_mut[64:0]), COMP_LOOP_acc_1_psp_mx0w1, ({COMP_LOOP_acc_1_psp_64
        , COMP_LOOP_acc_1_psp_63_0}), {and_42_nl , nor_24_ssc , and_dcpl_46 , (~
        mux_34_itm)});
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_12_0_sva_11_0 <= 12'b000000000000;
    end
    else if ( (and_dcpl_30 & and_dcpl_6 & (fsm_output[0])) | and_dcpl_18 | COPY_LOOP_1_i_12_0_sva_11_0_mx0c2
        ) begin
      COPY_LOOP_1_i_12_0_sva_11_0 <= MUX_v_12_2_2(12'b000000000000, COPY_LOOP_1_i_mux_nl,
          COPY_LOOP_1_i_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_12_0_sva_1_12_11 <= 2'b00;
    end
    else if ( MUX_s_1_2_2(mux_54_nl, mux_nl, fsm_output[1]) ) begin
      COPY_LOOP_1_i_12_0_sva_1_12_11 <= COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt[12:11];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_12_0_sva_1_10_0 <= 11'b00000000000;
    end
    else if ( mux_57_nl & nor_38_cse ) begin
      COPY_LOOP_1_i_12_0_sva_1_10_0 <= COPY_LOOP_1_i_COPY_LOOP_1_i_mux_rgt[10:0];
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2((~ mux_tmp_34), mux_tmp_10, fsm_output[6]) ) begin
      STAGE_LOOP_base_acc_cse_sva <= MUX_v_4_2_2(4'b1010, (z_out[3:0]), and_59_nl);
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2((~ mux_tmp_34), mux_47_nl, fsm_output[6]) ) begin
      STAGE_LOOP_base_8_0_sva <= STAGE_LOOP_base_lshift_itm;
    end
  end
  always @(posedge clk) begin
    if ( ~(mux_59_nl | (fsm_output[6])) ) begin
      COMP_LOOP_acc_1_psp_64 <= COMP_LOOP_COMP_LOOP_mux_rgt[64];
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[2:1]==2'b11) & (~((fsm_output[0]) & (fsm_output[5]))) & (~((fsm_output[6])
        | (fsm_output[4]) | (fsm_output[3]))) ) begin
      COMP_LOOP_acc_1_psp_63_0 <= COMP_LOOP_COMP_LOOP_mux_rgt[63:0];
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_28 | and_dcpl_46 ) begin
      COMP_LOOP_acc_mut <= MUX_v_65_2_2(({1'b0 , twiddle_rsci_q_d}), COMP_LOOP_acc_mut_mx0w0,
          and_dcpl_46);
    end
  end
  always @(posedge clk) begin
    if ( ~(or_tmp_14 | (~ (fsm_output[0])) | (~ (fsm_output[1])) | (fsm_output[6]))
        ) begin
      COMP_LOOP_f2_mul_mut <= COMP_LOOP_f2_mul_mut_mx0w0;
    end
  end
  assign nor_17_nl = ~((fsm_output[5:0]!=6'b000000));
  assign or_23_nl = (fsm_output[0]) | (fsm_output[2]);
  assign mux_28_nl = MUX_s_1_2_2(nor_20_cse, mux_tmp_16, or_23_nl);
  assign mux_27_nl = MUX_s_1_2_2(mux_tmp_16, nor_tmp_5, and_67_cse);
  assign mux_29_nl = MUX_s_1_2_2(mux_28_nl, mux_27_nl, fsm_output[1]);
  assign and_40_nl = (~ mux_29_nl) & (fsm_output[6:5]==2'b01);
  assign COMP_LOOP_f2_mux_nl = MUX_v_63_2_2((COMP_LOOP_f2_mul_mut_mx0w0[127:65]),
      (COMP_LOOP_f2_mul_mut[127:65]), nor_24_ssc);
  assign COMP_LOOP_f2_nor_nl = ~(and_dcpl_46 | (~ mux_34_itm));
  assign and_42_nl = and_dcpl_12 & and_64_cse & (~ (fsm_output[6]));
  assign nl_COMP_LOOP_acc_4_nl = conv_u2u_11_12(COPY_LOOP_1_i_12_0_sva_1_10_0) +
      12'b000000000001;
  assign COMP_LOOP_acc_4_nl = nl_COMP_LOOP_acc_4_nl[11:0];
  assign COPY_LOOP_1_i_mux_nl = MUX_v_12_2_2(({(COPY_LOOP_1_i_12_0_sva_1_12_11[0])
      , COPY_LOOP_1_i_12_0_sva_1_10_0}), COMP_LOOP_acc_4_nl, and_dcpl_18);
  assign COPY_LOOP_1_i_not_nl = ~ COPY_LOOP_1_i_12_0_sva_11_0_mx0c2;
  assign or_57_nl = (fsm_output[0]) | (fsm_output[2]) | (fsm_output[5]) | (fsm_output[4])
      | (fsm_output[3]);
  assign nor_nl = ~(and_67_cse | (fsm_output[5:3]!=3'b000));
  assign mux_54_nl = MUX_s_1_2_2(or_57_nl, nor_nl, fsm_output[6]);
  assign mux_nl = MUX_s_1_2_2(or_58_cse, nor_38_cse, fsm_output[6]);
  assign mux_56_nl = MUX_s_1_2_2((~ (fsm_output[2])), (fsm_output[2]), fsm_output[0]);
  assign nor_36_nl = ~((fsm_output[6]) | mux_56_nl);
  assign and_94_nl = (fsm_output[6]) & (fsm_output[2]);
  assign mux_57_nl = MUX_s_1_2_2(nor_36_nl, and_94_nl, fsm_output[1]);
  assign and_59_nl = and_dcpl_12 & and_dcpl_21 & (~ (fsm_output[6]));
  assign mux_47_nl = MUX_s_1_2_2(or_tmp_7, or_58_cse, and_64_cse);
  assign and_93_nl = (fsm_output[2:0]==3'b111);
  assign mux_58_nl = MUX_s_1_2_2(nand_3_cse, and_93_nl, fsm_output[5]);
  assign mux_59_nl = MUX_s_1_2_2(mux_58_nl, (fsm_output[5]), or_55_cse);
  assign nl_z_out = conv_u2u_4_5(STAGE_LOOP_base_acc_cse_sva) + 5'b11111;
  assign z_out = nl_z_out[4:0];

  function automatic [64:0] MUX1HOT_v_65_4_2;
    input [64:0] input_3;
    input [64:0] input_2;
    input [64:0] input_1;
    input [64:0] input_0;
    input [3:0] sel;
    reg [64:0] result;
  begin
    result = input_0 & {65{sel[0]}};
    result = result | ( input_1 & {65{sel[1]}});
    result = result | ( input_2 & {65{sel[2]}});
    result = result | ( input_3 & {65{sel[3]}});
    MUX1HOT_v_65_4_2 = result;
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


  function automatic [62:0] MUX_v_63_2_2;
    input [62:0] input_0;
    input [62:0] input_1;
    input [0:0] sel;
    reg [62:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_63_2_2 = result;
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


  function automatic [12:0] conv_u2s_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2s_12_13 =  {1'b0, vector};
  end
  endfunction


  function automatic [64:0] conv_u2s_64_65 ;
    input [63:0]  vector ;
  begin
    conv_u2s_64_65 =  {1'b0, vector};
  end
  endfunction


  function automatic [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
  end
  endfunction


  function automatic [64:0] conv_u2u_64_65 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_65 = {1'b0, vector};
  end
  endfunction


  function automatic [127:0] conv_u2u_128_128 ;
    input [127:0]  vector ;
  begin
    conv_u2u_128_128 = vector;
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
  output [11:0] vec_rsc_radr;
  input [63:0] vec_rsc_q;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] g_rsc_dat;
  output g_rsc_triosy_lz;
  output [11:0] result_rsc_wadr;
  output [63:0] result_rsc_d;
  output result_rsc_we;
  output [11:0] result_rsc_radr;
  input [63:0] result_rsc_q;
  output result_rsc_triosy_lz;
  output [11:0] twiddle_rsc_radr;
  input [63:0] twiddle_rsc_q;
  output twiddle_rsc_triosy_lz;


  // Interconnect Declarations
  wire [63:0] vec_rsci_q_d;
  wire vec_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] result_rsci_d_d;
  wire [63:0] result_rsci_q_d;
  wire [11:0] result_rsci_wadr_d;
  wire result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_rsci_q_d;
  wire [11:0] twiddle_rsci_radr_d;
  wire twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire xt_rsci_clken_d;
  wire [63:0] xt_rsci_d_d;
  wire [63:0] xt_rsci_q_d;
  wire [11:0] xt_rsci_radr_d;
  wire xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [127:0] COMP_LOOP_f2_rem_cmp_a;
  wire [63:0] COMP_LOOP_f2_rem_cmp_b;
  wire [63:0] COMP_LOOP_f2_rem_cmp_z;
  wire xt_rsc_clken;
  wire [63:0] xt_rsc_q;
  wire [11:0] xt_rsc_radr;
  wire xt_rsc_we;
  wire [63:0] xt_rsc_d;
  wire [11:0] xt_rsc_wadr;
  wire [11:0] vec_rsci_radr_d_iff;
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
  BLOCK_1R1W_RBW #(.addr_width(32'sd12),
  .data_width(32'sd64),
  .depth(32'sd4096),
  .latency(32'sd1)) xt_rsc_comp (
      .clk(clk),
      .clken(xt_rsc_clken),
      .d(xt_rsc_d),
      .q(xt_rsc_q),
      .radr(xt_rsc_radr),
      .wadr(xt_rsc_wadr),
      .we(xt_rsc_we)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_1_12_64_4096_4096_64_1_gen vec_rsci (
      .q(vec_rsc_q),
      .radr(vec_rsc_radr),
      .q_d(vec_rsci_q_d),
      .radr_d(vec_rsci_radr_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(vec_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_12_64_4096_4096_64_1_gen result_rsci
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
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_5_12_64_4096_4096_64_1_gen twiddle_rsci
      (
      .q(twiddle_rsc_q),
      .radr(twiddle_rsc_radr),
      .q_d(twiddle_rsci_q_d),
      .radr_d(twiddle_rsci_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_12_64_4096_4096_64_1_gen xt_rsci
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



