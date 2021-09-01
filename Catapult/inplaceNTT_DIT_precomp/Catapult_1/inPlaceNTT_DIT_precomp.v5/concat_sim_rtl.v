
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

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Thu Aug 19 17:10:03 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_8_9_64_512_512_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_8_9_64_512_512_64_1_gen
    (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [8:0] radr;
  output [63:0] q_d;
  input [8:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_9_64_512_512_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_9_64_512_512_64_1_gen
    (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [8:0] radr;
  output [63:0] q_d;
  input [8:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_6_9_64_512_512_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_6_9_64_512_512_64_1_gen
    (
  q, radr, we, d, wadr, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [8:0] radr;
  output we;
  output [63:0] d;
  output [8:0] wadr;
  input [63:0] d_d;
  output [63:0] q_d;
  input [8:0] radr_d;
  input [8:0] wadr_d;
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
//  Design Unit:    inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_5_9_64_512_512_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_5_9_64_512_512_64_1_gen
    (
  q, radr, we, d, wadr, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [8:0] radr;
  output we;
  output [63:0] d;
  output [8:0] wadr;
  input [63:0] d_d;
  output [63:0] q_d;
  input [8:0] radr_d;
  input [8:0] wadr_d;
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core_core_fsm (
  clk, rst, fsm_output, COMP_LOOP_C_38_tr0, COMP_LOOP_C_77_tr0, VEC_LOOP_C_0_tr0,
      STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
  input COMP_LOOP_C_38_tr0;
  input COMP_LOOP_C_77_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_precomp_core_core_fsm_1
  parameter
    main_C_0 = 7'd0,
    STAGE_LOOP_C_0 = 7'd1,
    COMP_LOOP_C_0 = 7'd2,
    COMP_LOOP_C_1 = 7'd3,
    COMP_LOOP_C_2 = 7'd4,
    COMP_LOOP_C_3 = 7'd5,
    COMP_LOOP_C_4 = 7'd6,
    COMP_LOOP_C_5 = 7'd7,
    COMP_LOOP_C_6 = 7'd8,
    COMP_LOOP_C_7 = 7'd9,
    COMP_LOOP_C_8 = 7'd10,
    COMP_LOOP_C_9 = 7'd11,
    COMP_LOOP_C_10 = 7'd12,
    COMP_LOOP_C_11 = 7'd13,
    COMP_LOOP_C_12 = 7'd14,
    COMP_LOOP_C_13 = 7'd15,
    COMP_LOOP_C_14 = 7'd16,
    COMP_LOOP_C_15 = 7'd17,
    COMP_LOOP_C_16 = 7'd18,
    COMP_LOOP_C_17 = 7'd19,
    COMP_LOOP_C_18 = 7'd20,
    COMP_LOOP_C_19 = 7'd21,
    COMP_LOOP_C_20 = 7'd22,
    COMP_LOOP_C_21 = 7'd23,
    COMP_LOOP_C_22 = 7'd24,
    COMP_LOOP_C_23 = 7'd25,
    COMP_LOOP_C_24 = 7'd26,
    COMP_LOOP_C_25 = 7'd27,
    COMP_LOOP_C_26 = 7'd28,
    COMP_LOOP_C_27 = 7'd29,
    COMP_LOOP_C_28 = 7'd30,
    COMP_LOOP_C_29 = 7'd31,
    COMP_LOOP_C_30 = 7'd32,
    COMP_LOOP_C_31 = 7'd33,
    COMP_LOOP_C_32 = 7'd34,
    COMP_LOOP_C_33 = 7'd35,
    COMP_LOOP_C_34 = 7'd36,
    COMP_LOOP_C_35 = 7'd37,
    COMP_LOOP_C_36 = 7'd38,
    COMP_LOOP_C_37 = 7'd39,
    COMP_LOOP_C_38 = 7'd40,
    COMP_LOOP_C_39 = 7'd41,
    COMP_LOOP_C_40 = 7'd42,
    COMP_LOOP_C_41 = 7'd43,
    COMP_LOOP_C_42 = 7'd44,
    COMP_LOOP_C_43 = 7'd45,
    COMP_LOOP_C_44 = 7'd46,
    COMP_LOOP_C_45 = 7'd47,
    COMP_LOOP_C_46 = 7'd48,
    COMP_LOOP_C_47 = 7'd49,
    COMP_LOOP_C_48 = 7'd50,
    COMP_LOOP_C_49 = 7'd51,
    COMP_LOOP_C_50 = 7'd52,
    COMP_LOOP_C_51 = 7'd53,
    COMP_LOOP_C_52 = 7'd54,
    COMP_LOOP_C_53 = 7'd55,
    COMP_LOOP_C_54 = 7'd56,
    COMP_LOOP_C_55 = 7'd57,
    COMP_LOOP_C_56 = 7'd58,
    COMP_LOOP_C_57 = 7'd59,
    COMP_LOOP_C_58 = 7'd60,
    COMP_LOOP_C_59 = 7'd61,
    COMP_LOOP_C_60 = 7'd62,
    COMP_LOOP_C_61 = 7'd63,
    COMP_LOOP_C_62 = 7'd64,
    COMP_LOOP_C_63 = 7'd65,
    COMP_LOOP_C_64 = 7'd66,
    COMP_LOOP_C_65 = 7'd67,
    COMP_LOOP_C_66 = 7'd68,
    COMP_LOOP_C_67 = 7'd69,
    COMP_LOOP_C_68 = 7'd70,
    COMP_LOOP_C_69 = 7'd71,
    COMP_LOOP_C_70 = 7'd72,
    COMP_LOOP_C_71 = 7'd73,
    COMP_LOOP_C_72 = 7'd74,
    COMP_LOOP_C_73 = 7'd75,
    COMP_LOOP_C_74 = 7'd76,
    COMP_LOOP_C_75 = 7'd77,
    COMP_LOOP_C_76 = 7'd78,
    COMP_LOOP_C_77 = 7'd79,
    VEC_LOOP_C_0 = 7'd80,
    STAGE_LOOP_C_1 = 7'd81,
    main_C_1 = 7'd82;

  reg [6:0] state_var;
  reg [6:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIT_precomp_core_core_fsm_1
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
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 7'b0000100;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 7'b0000101;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 7'b0000110;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 7'b0000111;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 7'b0001000;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 7'b0001001;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 7'b0001010;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 7'b0001011;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 7'b0001100;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 7'b0001101;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 7'b0001110;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 7'b0001111;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 7'b0010000;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 7'b0010001;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 7'b0010010;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 7'b0010011;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 7'b0010100;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 7'b0010101;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 7'b0010110;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 7'b0010111;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 7'b0011000;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 7'b0011001;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 7'b0011010;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 7'b0011011;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 7'b0011100;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 7'b0011101;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 7'b0011110;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 7'b0011111;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 7'b0100000;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 7'b0100001;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 7'b0100010;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 7'b0100011;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 7'b0100100;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 7'b0100101;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 7'b0100110;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 7'b0100111;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 7'b0101000;
        if ( COMP_LOOP_C_38_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_39;
        end
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 7'b0101001;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 7'b0101010;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 7'b0101011;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 7'b0101100;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 7'b0101101;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 7'b0101110;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 7'b0101111;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 7'b0110000;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 7'b0110001;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 7'b0110010;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 7'b0110011;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 7'b0110100;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 7'b0110101;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 7'b0110110;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 7'b0110111;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 7'b0111000;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 7'b0111001;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 7'b0111010;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 7'b0111011;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 7'b0111100;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 7'b0111101;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 7'b0111110;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 7'b0111111;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 7'b1000000;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 7'b1000001;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 7'b1000010;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 7'b1000011;
        state_var_NS = COMP_LOOP_C_66;
      end
      COMP_LOOP_C_66 : begin
        fsm_output = 7'b1000100;
        state_var_NS = COMP_LOOP_C_67;
      end
      COMP_LOOP_C_67 : begin
        fsm_output = 7'b1000101;
        state_var_NS = COMP_LOOP_C_68;
      end
      COMP_LOOP_C_68 : begin
        fsm_output = 7'b1000110;
        state_var_NS = COMP_LOOP_C_69;
      end
      COMP_LOOP_C_69 : begin
        fsm_output = 7'b1000111;
        state_var_NS = COMP_LOOP_C_70;
      end
      COMP_LOOP_C_70 : begin
        fsm_output = 7'b1001000;
        state_var_NS = COMP_LOOP_C_71;
      end
      COMP_LOOP_C_71 : begin
        fsm_output = 7'b1001001;
        state_var_NS = COMP_LOOP_C_72;
      end
      COMP_LOOP_C_72 : begin
        fsm_output = 7'b1001010;
        state_var_NS = COMP_LOOP_C_73;
      end
      COMP_LOOP_C_73 : begin
        fsm_output = 7'b1001011;
        state_var_NS = COMP_LOOP_C_74;
      end
      COMP_LOOP_C_74 : begin
        fsm_output = 7'b1001100;
        state_var_NS = COMP_LOOP_C_75;
      end
      COMP_LOOP_C_75 : begin
        fsm_output = 7'b1001101;
        state_var_NS = COMP_LOOP_C_76;
      end
      COMP_LOOP_C_76 : begin
        fsm_output = 7'b1001110;
        state_var_NS = COMP_LOOP_C_77;
      end
      COMP_LOOP_C_77 : begin
        fsm_output = 7'b1001111;
        if ( COMP_LOOP_C_77_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 7'b1010000;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 7'b1010001;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b1010010;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 7'b0000000;
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
//  Design Unit:    inPlaceNTT_DIT_precomp_core
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp_core (
  clk, rst, vec_rsc_triosy_0_0_lz, vec_rsc_triosy_0_1_lz, p_rsc_dat, p_rsc_triosy_lz,
      r_rsc_triosy_lz, twiddle_rsc_triosy_0_0_lz, twiddle_rsc_triosy_0_1_lz, vec_rsc_0_0_i_q_d,
      vec_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d, vec_rsc_0_1_i_q_d, vec_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_0_i_radr_d, twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsc_0_1_i_q_d, twiddle_rsc_0_1_i_radr_d, twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_0_i_d_d_pff, vec_rsc_0_0_i_radr_d_pff, vec_rsc_0_0_i_wadr_d_pff,
      vec_rsc_0_0_i_we_d_pff, vec_rsc_0_1_i_we_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_0_0_lz;
  output vec_rsc_triosy_0_1_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_0_0_lz;
  output twiddle_rsc_triosy_0_1_lz;
  input [63:0] vec_rsc_0_0_i_q_d;
  output vec_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d;
  input [63:0] vec_rsc_0_1_i_q_d;
  output vec_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_rsc_0_0_i_q_d;
  output [8:0] twiddle_rsc_0_0_i_radr_d;
  output twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_rsc_0_1_i_q_d;
  output [8:0] twiddle_rsc_0_1_i_radr_d;
  output twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d;
  output [63:0] vec_rsc_0_0_i_d_d_pff;
  output [8:0] vec_rsc_0_0_i_radr_d_pff;
  output [8:0] vec_rsc_0_0_i_wadr_d_pff;
  output vec_rsc_0_0_i_we_d_pff;
  output vec_rsc_0_1_i_we_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  wire [64:0] COMP_LOOP_1_modulo_result_rem_cmp_z;
  reg [63:0] COMP_LOOP_1_modulo_result_rem_cmp_a_63_0;
  reg [63:0] COMP_LOOP_1_modulo_result_rem_cmp_b_63_0;
  wire [6:0] fsm_output;
  wire [9:0] COMP_LOOP_1_acc_10_tmp;
  wire [11:0] nl_COMP_LOOP_1_acc_10_tmp;
  wire or_tmp;
  wire and_dcpl_6;
  wire and_dcpl_7;
  wire and_dcpl_8;
  wire and_dcpl_9;
  wire and_dcpl_10;
  wire and_dcpl_12;
  wire and_dcpl_14;
  wire and_dcpl_15;
  wire and_dcpl_17;
  wire and_dcpl_18;
  wire and_dcpl_19;
  wire and_dcpl_21;
  wire and_dcpl_22;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_25;
  wire and_dcpl_27;
  wire and_dcpl_31;
  wire and_dcpl_34;
  wire and_dcpl_36;
  wire and_dcpl_41;
  wire not_tmp_35;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire mux_tmp_46;
  wire or_dcpl_4;
  wire mux_tmp_54;
  wire mux_tmp_63;
  wire or_dcpl_8;
  wire or_dcpl_11;
  wire not_tmp_57;
  wire mux_tmp_71;
  wire and_dcpl_77;
  wire or_dcpl_21;
  wire or_dcpl_24;
  reg COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  reg COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm;
  reg [9:0] VEC_LOOP_j_sva_9_0;
  reg [9:0] COMP_LOOP_1_slc_31_1_idiv_sva;
  reg [9:0] COMP_LOOP_2_slc_31_1_idiv_sva;
  reg [9:0] COMP_LOOP_acc_1_cse_sva;
  wire [10:0] nl_COMP_LOOP_acc_1_cse_sva;
  reg [9:0] COMP_LOOP_2_acc_10_idiv_sva;
  wire [11:0] nl_COMP_LOOP_2_acc_10_idiv_sva;
  reg [9:0] COMP_LOOP_2_tmp_lshift_itm;
  reg [9:0] STAGE_LOOP_lshift_psp_sva;
  reg [7:0] COMP_LOOP_k_9_1_sva_7_0;
  reg [7:0] reg_COMP_LOOP_k_9_1_ftd;
  reg reg_vec_rsc_triosy_0_1_obj_ld_cse;
  wire or_2_cse;
  wire and_103_cse;
  wire and_92_cse;
  wire [63:0] vec_rsc_0_0_i_d_d_1;
  reg [8:0] COMP_LOOP_acc_psp_sva;
  wire [9:0] z_out;
  wire [3:0] z_out_1;
  wire [4:0] nl_z_out_1;
  wire and_dcpl_119;
  wire [8:0] z_out_2;
  wire [9:0] nl_z_out_2;
  wire and_dcpl_130;
  wire [10:0] z_out_3;
  wire [11:0] nl_z_out_3;
  wire and_dcpl_142;
  wire [63:0] z_out_4;
  wire [127:0] nl_z_out_4;
  wire [9:0] z_out_5;
  wire [18:0] nl_z_out_5;
  reg [63:0] p_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [3:0] COMP_LOOP_1_tmp_acc_cse_sva;
  reg [63:0] tmp_2_lpi_4_dfm;
  reg [63:0] COMP_LOOP_1_acc_8_itm;
  reg [63:0] COMP_LOOP_tmp_mux_itm;
  reg [63:0] COMP_LOOP_2_acc_8_itm;
  reg [63:0] COMP_LOOP_1_acc_5_psp;
  reg [63:0] COMP_LOOP_2_acc_5_psp;
  reg [63:0] COMP_LOOP_1_mul_psp;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [63:0] COMP_LOOP_2_acc_5_psp_mx0w2;
  wire [64:0] nl_COMP_LOOP_2_acc_5_psp_mx0w2;
  wire VEC_LOOP_j_sva_9_0_mx0c0;
  wire tmp_2_lpi_4_dfm_mx0c1;
  wire [63:0] COMP_LOOP_1_acc_8_itm_mx0w0;
  wire [64:0] nl_COMP_LOOP_1_acc_8_itm_mx0w0;
  wire COMP_LOOP_or_3_cse;
  wire nor_72_cse;
  wire or_114_cse;
  wire mux_82_cse;
  wire mux_83_cse;
  wire mux_84_cse;

  wire[0:0] nor_43_nl;
  wire[0:0] mux_26_nl;
  wire[0:0] or_105_nl;
  wire[0:0] nor_56_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] mux_51_nl;
  wire[0:0] mux_50_nl;
  wire[0:0] mux_48_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] or_56_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] and_61_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] nor_31_nl;
  wire[0:0] nor_32_nl;
  wire[0:0] and_64_nl;
  wire[0:0] nor_55_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] or_64_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] or_62_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] nand_nl;
  wire[0:0] and_68_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] VEC_LOOP_j_not_1_nl;
  wire[0:0] mux_61_nl;
  wire[0:0] or_70_nl;
  wire[0:0] or_113_nl;
  wire[0:0] mux_21_nl;
  wire[0:0] or_110_nl;
  wire[0:0] or_111_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] and_nl;
  wire[10:0] COMP_LOOP_1_acc_11_nl;
  wire[12:0] nl_COMP_LOOP_1_acc_11_nl;
  wire[9:0] COMP_LOOP_2_acc_nl;
  wire[10:0] nl_COMP_LOOP_2_acc_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] or_108_nl;
  wire[10:0] COMP_LOOP_2_acc_11_nl;
  wire[12:0] nl_COMP_LOOP_2_acc_11_nl;
  wire[0:0] or_9_nl;
  wire[9:0] COMP_LOOP_1_acc_nl;
  wire[10:0] nl_COMP_LOOP_1_acc_nl;
  wire[0:0] or_10_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] nor_28_nl;
  wire[0:0] nor_29_nl;
  wire[0:0] and_85_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] mux_80_nl;
  wire[63:0] COMP_LOOP_1_modulo_qelse_acc_nl;
  wire[64:0] nl_COMP_LOOP_1_modulo_qelse_acc_nl;
  wire[0:0] or_63_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] nor_26_nl;
  wire[0:0] nor_27_nl;
  wire[0:0] and_26_nl;
  wire[0:0] and_28_nl;
  wire[0:0] and_30_nl;
  wire[0:0] and_33_nl;
  wire[0:0] and_35_nl;
  wire[0:0] and_38_nl;
  wire[0:0] mux_31_nl;
  wire[0:0] nor_41_nl;
  wire[0:0] mux_30_nl;
  wire[0:0] or_37_nl;
  wire[0:0] or_36_nl;
  wire[0:0] nor_42_nl;
  wire[0:0] mux_29_nl;
  wire[0:0] or_33_nl;
  wire[0:0] or_31_nl;
  wire[0:0] mux_34_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] nor_35_nl;
  wire[0:0] nor_36_nl;
  wire[0:0] mux_32_nl;
  wire[0:0] nor_37_nl;
  wire[0:0] nor_38_nl;
  wire[0:0] mux_37_nl;
  wire[0:0] nor_39_nl;
  wire[0:0] mux_36_nl;
  wire[0:0] or_49_nl;
  wire[0:0] or_48_nl;
  wire[0:0] nor_40_nl;
  wire[0:0] mux_35_nl;
  wire[0:0] or_45_nl;
  wire[0:0] or_44_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] mux_39_nl;
  wire[0:0] and_94_nl;
  wire[0:0] and_95_nl;
  wire[0:0] mux_38_nl;
  wire[0:0] nor_33_nl;
  wire[0:0] nor_34_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] or_54_nl;
  wire[3:0] STAGE_LOOP_mux_3_nl;
  wire[7:0] COMP_LOOP_mux_43_nl;
  wire[9:0] COMP_LOOP_mux_44_nl;
  wire[9:0] COMP_LOOP_mux_45_nl;
  wire[63:0] COMP_LOOP_mux_46_nl;
  wire[63:0] COMP_LOOP_mux_47_nl;
  wire[0:0] COMP_LOOP_or_5_nl;
  wire[8:0] COMP_LOOP_tmp_mux_3_nl;
  wire[9:0] COMP_LOOP_tmp_mux_4_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_COMP_LOOP_1_modulo_result_rem_cmp_a;
  assign nl_COMP_LOOP_1_modulo_result_rem_cmp_a = {{1{COMP_LOOP_1_modulo_result_rem_cmp_a_63_0[63]}},
      COMP_LOOP_1_modulo_result_rem_cmp_a_63_0};
  wire [64:0] nl_COMP_LOOP_1_modulo_result_rem_cmp_b;
  assign nl_COMP_LOOP_1_modulo_result_rem_cmp_b = {1'b0, COMP_LOOP_1_modulo_result_rem_cmp_b_63_0};
  wire[0:0] and_112_nl;
  wire [3:0] nl_COMP_LOOP_1_tmp_lshift_rg_s;
  assign and_112_nl = and_dcpl_9 & and_dcpl_8 & (fsm_output[1]) & (fsm_output[0])
      & (~ (fsm_output[6]));
  assign nl_COMP_LOOP_1_tmp_lshift_rg_s = MUX1HOT_v_4_3_2(STAGE_LOOP_i_3_0_sva, COMP_LOOP_1_tmp_acc_cse_sva,
      z_out_1, {(~ (fsm_output[1])) , and_112_nl , (~ (fsm_output[0]))});
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0 = ~ COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0 = ~ COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm;
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out_3[10];
  wire [0:0] nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ (z_out_2[2]);
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_1_obj (
      .ld(reg_vec_rsc_triosy_0_1_obj_ld_cse),
      .lz(vec_rsc_triosy_0_1_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_0_obj (
      .ld(reg_vec_rsc_triosy_0_1_obj_ld_cse),
      .lz(vec_rsc_triosy_0_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) p_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_0_1_obj_ld_cse),
      .lz(p_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_0_1_obj_ld_cse),
      .lz(r_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_1_obj (
      .ld(reg_vec_rsc_triosy_0_1_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_1_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_0_obj (
      .ld(reg_vec_rsc_triosy_0_1_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_0_lz)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) COMP_LOOP_1_modulo_result_rem_cmp (
      .a(nl_COMP_LOOP_1_modulo_result_rem_cmp_a[64:0]),
      .b(nl_COMP_LOOP_1_modulo_result_rem_cmp_b[64:0]),
      .z(COMP_LOOP_1_modulo_result_rem_cmp_z)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) COMP_LOOP_1_tmp_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_1_tmp_lshift_rg_s[3:0]),
      .z(z_out)
    );
  inPlaceNTT_DIT_precomp_core_core_fsm inPlaceNTT_DIT_precomp_core_core_fsm_inst
      (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .COMP_LOOP_C_38_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_38_tr0[0:0]),
      .COMP_LOOP_C_77_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_COMP_LOOP_C_77_tr0[0:0]),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_precomp_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign and_92_cse = (fsm_output[1:0]==2'b11);
  assign COMP_LOOP_or_3_cse = and_dcpl_22 | (and_dcpl_25 & and_dcpl_18);
  assign or_114_cse = (fsm_output[5:4]!=2'b00);
  assign mux_82_cse = MUX_s_1_2_2((~ (fsm_output[4])), (fsm_output[4]), fsm_output[5]);
  assign mux_83_cse = MUX_s_1_2_2(mux_82_cse, (fsm_output[5]), fsm_output[3]);
  assign mux_84_cse = MUX_s_1_2_2(mux_83_cse, mux_tmp_63, fsm_output[2]);
  assign nl_COMP_LOOP_1_modulo_qelse_acc_nl = (COMP_LOOP_1_modulo_result_rem_cmp_z[63:0])
      + p_sva;
  assign COMP_LOOP_1_modulo_qelse_acc_nl = nl_COMP_LOOP_1_modulo_qelse_acc_nl[63:0];
  assign vec_rsc_0_0_i_d_d_1 = MUX_v_64_2_2((COMP_LOOP_1_modulo_result_rem_cmp_z[63:0]),
      COMP_LOOP_1_modulo_qelse_acc_nl, COMP_LOOP_1_modulo_result_rem_cmp_z[63]);
  assign nl_COMP_LOOP_2_acc_5_psp_mx0w2 = tmp_2_lpi_4_dfm + vec_rsc_0_0_i_d_d_1;
  assign COMP_LOOP_2_acc_5_psp_mx0w2 = nl_COMP_LOOP_2_acc_5_psp_mx0w2[63:0];
  assign nl_COMP_LOOP_1_acc_10_tmp = VEC_LOOP_j_sva_9_0 + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , 1'b0}) + conv_u2u_9_10(STAGE_LOOP_lshift_psp_sva[9:1]);
  assign COMP_LOOP_1_acc_10_tmp = nl_COMP_LOOP_1_acc_10_tmp[9:0];
  assign nl_COMP_LOOP_1_acc_8_itm_mx0w0 = tmp_2_lpi_4_dfm - vec_rsc_0_0_i_d_d_1;
  assign COMP_LOOP_1_acc_8_itm_mx0w0 = nl_COMP_LOOP_1_acc_8_itm_mx0w0[63:0];
  assign or_tmp = (fsm_output[5:1]!=5'b00000);
  assign or_2_cse = (fsm_output[5:4]!=2'b10);
  assign and_103_cse = (fsm_output[5:4]==2'b11);
  assign and_dcpl_6 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_7 = and_dcpl_6 & (~ (fsm_output[6]));
  assign and_dcpl_8 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_9 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_10 = and_dcpl_9 & and_dcpl_8;
  assign and_dcpl_12 = (fsm_output[1:0]==2'b01);
  assign and_dcpl_14 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_15 = and_dcpl_14 & and_dcpl_8;
  assign and_dcpl_17 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_18 = and_dcpl_17 & (~ (fsm_output[6]));
  assign and_dcpl_19 = and_dcpl_10 & and_dcpl_18;
  assign and_dcpl_21 = (fsm_output[0]) & (fsm_output[1]) & (~ (fsm_output[6]));
  assign and_dcpl_22 = and_dcpl_10 & and_dcpl_21;
  assign and_dcpl_23 = (fsm_output[3:2]==2'b10);
  assign and_dcpl_24 = (fsm_output[5:4]==2'b10);
  assign and_dcpl_25 = and_dcpl_24 & and_dcpl_23;
  assign and_dcpl_27 = and_dcpl_12 & (~ (fsm_output[6]));
  assign and_dcpl_31 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_34 = and_dcpl_17 & (fsm_output[6]);
  assign and_dcpl_36 = (fsm_output[3:2]==2'b11);
  assign and_dcpl_41 = ~((fsm_output[4]) | (fsm_output[2]) | (fsm_output[6]));
  assign not_tmp_35 = ~((fsm_output[3]) & (fsm_output[5]));
  assign and_dcpl_45 = and_dcpl_9 & and_dcpl_31;
  assign and_dcpl_46 = and_dcpl_45 & and_dcpl_7;
  assign mux_tmp_46 = MUX_s_1_2_2((~ and_103_cse), or_114_cse, fsm_output[3]);
  assign or_dcpl_4 = ~((fsm_output[1:0]==2'b11));
  assign or_63_nl = (fsm_output[5:4]!=2'b01);
  assign mux_tmp_54 = MUX_s_1_2_2(or_2_cse, or_63_nl, fsm_output[3]);
  assign mux_tmp_63 = MUX_s_1_2_2(and_103_cse, (fsm_output[5]), fsm_output[3]);
  assign or_dcpl_8 = (fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[6]);
  assign or_dcpl_11 = or_114_cse | (fsm_output[3:2]!=2'b00) | or_dcpl_8;
  assign not_tmp_57 = ~(and_92_cse | (fsm_output[5:2]!=4'b0000));
  assign mux_tmp_71 = MUX_s_1_2_2(mux_82_cse, and_103_cse, fsm_output[3]);
  assign and_dcpl_77 = ~((fsm_output[4]) | (fsm_output[1]) | (fsm_output[6]));
  assign or_dcpl_21 = or_114_cse | (fsm_output[3:2]!=2'b11) | or_dcpl_4 | (fsm_output[6]);
  assign or_dcpl_24 = (~ and_103_cse) | (fsm_output[3:2]!=2'b01) | or_dcpl_8;
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_15 & and_dcpl_12 & (fsm_output[6]);
  assign VEC_LOOP_j_sva_9_0_mx0c0 = and_dcpl_10 & and_dcpl_27;
  assign nor_26_nl = ~((~ (VEC_LOOP_j_sva_9_0[0])) | (~ (fsm_output[2])) | (fsm_output[3])
      | (fsm_output[5]));
  assign nor_27_nl = ~((~ (COMP_LOOP_acc_1_cse_sva[0])) | (fsm_output[2]) | not_tmp_35);
  assign mux_78_nl = MUX_s_1_2_2(nor_26_nl, nor_27_nl, fsm_output[0]);
  assign tmp_2_lpi_4_dfm_mx0c1 = mux_78_nl & and_dcpl_77;
  assign vec_rsc_0_0_i_d_d_pff = vec_rsc_0_0_i_d_d_1;
  assign and_26_nl = and_dcpl_25 & and_dcpl_7;
  assign and_28_nl = and_dcpl_25 & and_dcpl_27;
  assign vec_rsc_0_0_i_radr_d_pff = MUX1HOT_v_9_4_2((COMP_LOOP_1_acc_10_tmp[9:1]),
      COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_1_cse_sva[9:1]), (COMP_LOOP_2_acc_10_idiv_sva[9:1]),
      {and_dcpl_19 , and_dcpl_22 , and_26_nl , and_28_nl});
  assign and_30_nl = and_dcpl_14 & and_dcpl_23 & and_dcpl_21;
  assign and_33_nl = and_dcpl_24 & and_dcpl_31 & and_dcpl_21;
  assign and_35_nl = and_dcpl_10 & and_dcpl_34;
  assign and_38_nl = and_dcpl_9 & and_dcpl_36 & and_dcpl_34;
  assign vec_rsc_0_0_i_wadr_d_pff = MUX1HOT_v_9_4_2(COMP_LOOP_acc_psp_sva, (COMP_LOOP_1_slc_31_1_idiv_sva[9:1]),
      (COMP_LOOP_acc_1_cse_sva[9:1]), (COMP_LOOP_2_slc_31_1_idiv_sva[9:1]), {and_30_nl
      , and_33_nl , and_35_nl , and_38_nl});
  assign or_37_nl = (fsm_output[2]) | (COMP_LOOP_acc_1_cse_sva[0]) | (fsm_output[5]);
  assign or_36_nl = (~ (fsm_output[2])) | (COMP_LOOP_2_slc_31_1_idiv_sva[0]) | (fsm_output[5]);
  assign mux_30_nl = MUX_s_1_2_2(or_37_nl, or_36_nl, fsm_output[3]);
  assign nor_41_nl = ~((~ (fsm_output[6])) | (fsm_output[4]) | mux_30_nl);
  assign or_33_nl = (fsm_output[3:2]!=2'b01) | (COMP_LOOP_1_slc_31_1_idiv_sva[0])
      | (~ (fsm_output[5]));
  assign or_31_nl = (fsm_output[3:2]!=2'b10) | (VEC_LOOP_j_sva_9_0[0]) | (fsm_output[5]);
  assign mux_29_nl = MUX_s_1_2_2(or_33_nl, or_31_nl, fsm_output[4]);
  assign nor_42_nl = ~((fsm_output[6]) | mux_29_nl);
  assign mux_31_nl = MUX_s_1_2_2(nor_41_nl, nor_42_nl, fsm_output[0]);
  assign vec_rsc_0_0_i_we_d_pff = mux_31_nl & (fsm_output[1]);
  assign nor_35_nl = ~((~ COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm) | (COMP_LOOP_acc_1_cse_sva[0])
      | not_tmp_35);
  assign nor_36_nl = ~((COMP_LOOP_2_acc_10_idiv_sva[0]) | not_tmp_35);
  assign mux_33_nl = MUX_s_1_2_2(nor_35_nl, nor_36_nl, fsm_output[0]);
  assign nor_37_nl = ~((COMP_LOOP_1_acc_10_tmp[0]) | (fsm_output[3]) | (fsm_output[5]));
  assign nor_38_nl = ~((VEC_LOOP_j_sva_9_0[0]) | (fsm_output[3]) | (fsm_output[5]));
  assign mux_32_nl = MUX_s_1_2_2(nor_37_nl, nor_38_nl, fsm_output[0]);
  assign mux_34_nl = MUX_s_1_2_2(mux_33_nl, mux_32_nl, fsm_output[1]);
  assign vec_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d = mux_34_nl & and_dcpl_41;
  assign or_49_nl = (fsm_output[2]) | (~ (COMP_LOOP_acc_1_cse_sva[0])) | (fsm_output[5]);
  assign or_48_nl = (~ (fsm_output[2])) | (~ (COMP_LOOP_2_slc_31_1_idiv_sva[0]))
      | (fsm_output[5]);
  assign mux_36_nl = MUX_s_1_2_2(or_49_nl, or_48_nl, fsm_output[3]);
  assign nor_39_nl = ~((~ (fsm_output[6])) | (fsm_output[4]) | mux_36_nl);
  assign or_45_nl = (fsm_output[3]) | (~((fsm_output[2]) & (COMP_LOOP_1_slc_31_1_idiv_sva[0])
      & (fsm_output[5])));
  assign or_44_nl = (fsm_output[3:2]!=2'b10) | (~ (VEC_LOOP_j_sva_9_0[0])) | (fsm_output[5]);
  assign mux_35_nl = MUX_s_1_2_2(or_45_nl, or_44_nl, fsm_output[4]);
  assign nor_40_nl = ~((fsm_output[6]) | mux_35_nl);
  assign mux_37_nl = MUX_s_1_2_2(nor_39_nl, nor_40_nl, fsm_output[0]);
  assign vec_rsc_0_1_i_we_d_pff = mux_37_nl & (fsm_output[1]);
  assign and_94_nl = COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm & (COMP_LOOP_acc_1_cse_sva[0])
      & (fsm_output[3]) & (fsm_output[5]);
  assign and_95_nl = (COMP_LOOP_2_acc_10_idiv_sva[0]) & (fsm_output[3]) & (fsm_output[5]);
  assign mux_39_nl = MUX_s_1_2_2(and_94_nl, and_95_nl, fsm_output[0]);
  assign nor_33_nl = ~((~ (COMP_LOOP_1_acc_10_tmp[0])) | (fsm_output[3]) | (fsm_output[5]));
  assign nor_34_nl = ~((~ (VEC_LOOP_j_sva_9_0[0])) | (fsm_output[3]) | (fsm_output[5]));
  assign mux_38_nl = MUX_s_1_2_2(nor_33_nl, nor_34_nl, fsm_output[0]);
  assign mux_40_nl = MUX_s_1_2_2(mux_39_nl, mux_38_nl, fsm_output[1]);
  assign vec_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d = mux_40_nl & and_dcpl_41;
  assign twiddle_rsc_0_0_i_radr_d = MUX_v_9_2_2((z_out_5[8:0]), (z_out_5[9:1]), and_dcpl_46);
  assign mux_41_nl = MUX_s_1_2_2((~ (fsm_output[2])), (fsm_output[2]), fsm_output[1]);
  assign or_54_nl = (fsm_output[2:1]!=2'b01);
  assign mux_42_nl = MUX_s_1_2_2(mux_41_nl, or_54_nl, z_out_5[0]);
  assign twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d = ~(mux_42_nl | (fsm_output[4])
      | (fsm_output[5]) | (fsm_output[3]) | (fsm_output[0]) | (fsm_output[6]));
  assign twiddle_rsc_0_1_i_radr_d = z_out_5[9:1];
  assign twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_45 & and_dcpl_6
      & (~ (fsm_output[6])) & (z_out_5[0]);
  assign nor_72_cse = ~((fsm_output!=7'b0000010));
  assign and_dcpl_119 = (fsm_output[5:4]==2'b01) & and_dcpl_8 & (~ (fsm_output[1]))
      & (fsm_output[0]) & (fsm_output[6]);
  assign and_dcpl_130 = (fsm_output[5:4]==2'b01) & and_dcpl_8 & (~ (fsm_output[1]))
      & (~ (fsm_output[0])) & (fsm_output[6]);
  assign and_dcpl_142 = (fsm_output==7'b0101010);
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(nor_43_nl, mux_26_nl, fsm_output[6]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( (and_dcpl_10 & and_dcpl_7) | STAGE_LOOP_i_3_0_sva_mx0c1 ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, z_out_1, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= 1'b0;
      COMP_LOOP_2_tmp_lshift_itm <= 10'b0000000000;
    end
    else begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= and_dcpl_15 & and_dcpl_12 & (fsm_output[6])
          & (~ (z_out_2[2]));
      COMP_LOOP_2_tmp_lshift_itm <= MUX1HOT_v_10_3_2(COMP_LOOP_1_acc_10_tmp, z_out,
          z_out_5, {and_dcpl_19 , and_dcpl_22 , and_dcpl_46});
    end
  end
  always @(posedge clk) begin
    COMP_LOOP_1_modulo_result_rem_cmp_a_63_0 <= MUX1HOT_v_64_7_2(z_out_4, COMP_LOOP_1_mul_psp,
        COMP_LOOP_2_acc_5_psp_mx0w2, COMP_LOOP_1_acc_5_psp, COMP_LOOP_1_acc_8_itm,
        COMP_LOOP_2_acc_5_psp, COMP_LOOP_2_acc_8_itm, {COMP_LOOP_or_3_cse , nor_56_nl
        , and_61_nl , and_64_nl , nor_55_nl , (~ mux_58_nl) , and_68_nl});
    COMP_LOOP_1_modulo_result_rem_cmp_b_63_0 <= p_sva;
    COMP_LOOP_1_tmp_acc_cse_sva <= z_out_1;
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_sva_9_0 <= 10'b0000000000;
    end
    else if ( VEC_LOOP_j_sva_9_0_mx0c0 | (and_dcpl_15 & and_dcpl_6 & (fsm_output[6]))
        ) begin
      VEC_LOOP_j_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (z_out_3[9:0]), VEC_LOOP_j_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2((~ or_tmp), mux_61_nl, fsm_output[6]) ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2((~ mux_87_nl), or_114_cse, fsm_output[6]) ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= MUX_v_8_2_2(8'b00000000, reg_COMP_LOOP_k_9_1_ftd,
          or_113_nl);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      COMP_LOOP_acc_psp_sva <= z_out_3[8:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_slc_31_1_idiv_sva <= 10'b0000000000;
    end
    else if ( ~ or_dcpl_11 ) begin
      COMP_LOOP_1_slc_31_1_idiv_sva <= readslicef_11_10_1(COMP_LOOP_1_acc_11_nl);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      COMP_LOOP_2_slc_COMP_LOOP_acc_9_itm <= readslicef_10_1_9(COMP_LOOP_2_acc_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_1_cse_sva <= 10'b0000000000;
    end
    else if ( MUX_s_1_2_2(not_tmp_57, or_tmp, fsm_output[6]) ) begin
      COMP_LOOP_acc_1_cse_sva <= nl_COMP_LOOP_acc_1_cse_sva[9:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_2_acc_10_idiv_sva <= 10'b0000000000;
    end
    else if ( mux_73_nl | (fsm_output[6]) ) begin
      COMP_LOOP_2_acc_10_idiv_sva <= nl_COMP_LOOP_2_acc_10_idiv_sva[9:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_2_slc_31_1_idiv_sva <= 10'b0000000000;
    end
    else if ( MUX_s_1_2_2(not_tmp_57, or_9_nl, fsm_output[6]) ) begin
      COMP_LOOP_2_slc_31_1_idiv_sva <= readslicef_11_10_1(COMP_LOOP_2_acc_11_nl);
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(not_tmp_57, or_10_nl, fsm_output[6]) ) begin
      COMP_LOOP_1_slc_COMP_LOOP_acc_9_itm <= readslicef_10_1_9(COMP_LOOP_1_acc_nl);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_11 ) begin
      reg_COMP_LOOP_k_9_1_ftd <= z_out_2[7:0];
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_or_3_cse ) begin
      COMP_LOOP_1_mul_psp <= z_out_4;
    end
  end
  always @(posedge clk) begin
    if ( (mux_77_nl & and_dcpl_77) | tmp_2_lpi_4_dfm_mx0c1 ) begin
      tmp_2_lpi_4_dfm <= MUX_v_64_2_2(vec_rsc_0_0_i_q_d, vec_rsc_0_1_i_q_d, tmp_2_lpi_4_dfm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( mux_81_nl | (fsm_output[6]) ) begin
      COMP_LOOP_tmp_mux_itm <= MUX_v_64_2_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_1_i_q_d,
          and_85_nl);
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_21 ) begin
      COMP_LOOP_1_acc_8_itm <= COMP_LOOP_1_acc_8_itm_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_21 ) begin
      COMP_LOOP_1_acc_5_psp <= COMP_LOOP_2_acc_5_psp_mx0w2;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_24 ) begin
      COMP_LOOP_2_acc_8_itm <= COMP_LOOP_1_acc_8_itm_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_24 ) begin
      COMP_LOOP_2_acc_5_psp <= COMP_LOOP_2_acc_5_psp_mx0w2;
    end
  end
  assign nor_43_nl = ~((fsm_output[5:0]!=6'b000000));
  assign or_105_nl = (fsm_output[3:1]!=3'b000);
  assign mux_26_nl = MUX_s_1_2_2((fsm_output[5]), or_114_cse, or_105_nl);
  assign mux_50_nl = MUX_s_1_2_2((~ mux_82_cse), (fsm_output[4]), fsm_output[3]);
  assign mux_51_nl = MUX_s_1_2_2(mux_tmp_46, mux_50_nl, fsm_output[2]);
  assign or_56_nl = (~((fsm_output[3]) | (~ (fsm_output[5])))) | (fsm_output[4]);
  assign mux_47_nl = MUX_s_1_2_2(mux_tmp_46, or_56_nl, fsm_output[2]);
  assign mux_44_nl = MUX_s_1_2_2((~ and_103_cse), (fsm_output[4]), fsm_output[3]);
  assign mux_43_nl = MUX_s_1_2_2(or_114_cse, or_2_cse, fsm_output[3]);
  assign mux_45_nl = MUX_s_1_2_2(mux_44_nl, mux_43_nl, fsm_output[2]);
  assign mux_48_nl = MUX_s_1_2_2(mux_47_nl, mux_45_nl, fsm_output[0]);
  assign mux_52_nl = MUX_s_1_2_2(mux_51_nl, mux_48_nl, fsm_output[1]);
  assign nor_56_nl = ~(mux_52_nl | (fsm_output[6]));
  assign nor_31_nl = ~((fsm_output[3]) | (~ and_103_cse));
  assign nor_32_nl = ~((fsm_output[5:3]!=3'b001));
  assign mux_53_nl = MUX_s_1_2_2(nor_31_nl, nor_32_nl, fsm_output[0]);
  assign and_61_nl = mux_53_nl & (fsm_output[2]) & (fsm_output[1]) & (~ (fsm_output[6]));
  assign and_64_nl = (~((~(or_dcpl_4 & (~ (fsm_output[2])))) & (fsm_output[3])))
      & and_dcpl_14 & (~ (fsm_output[6]));
  assign or_64_nl = (fsm_output[5:3]!=3'b100);
  assign mux_56_nl = MUX_s_1_2_2(or_64_nl, mux_tmp_54, fsm_output[2]);
  assign or_62_nl = (fsm_output[5:3]!=3'b011);
  assign mux_55_nl = MUX_s_1_2_2(mux_tmp_54, or_62_nl, fsm_output[2]);
  assign mux_57_nl = MUX_s_1_2_2(mux_56_nl, mux_55_nl, and_92_cse);
  assign nor_55_nl = ~(mux_57_nl | (fsm_output[6]));
  assign nand_nl = ~((((fsm_output[2:0]==3'b111)) | (fsm_output[3])) & (fsm_output[5:4]==2'b11));
  assign mux_58_nl = MUX_s_1_2_2(nand_nl, or_tmp, fsm_output[6]);
  assign mux_59_nl = MUX_s_1_2_2(and_dcpl_8, and_dcpl_36, fsm_output[1]);
  assign and_68_nl = (~ mux_59_nl) & and_dcpl_9 & (fsm_output[6]);
  assign VEC_LOOP_j_not_1_nl = ~ VEC_LOOP_j_sva_9_0_mx0c0;
  assign or_70_nl = (fsm_output[3:0]!=4'b0000);
  assign mux_61_nl = MUX_s_1_2_2((fsm_output[5]), or_114_cse, or_70_nl);
  assign or_110_nl = (~ (fsm_output[0])) | (fsm_output[4]);
  assign or_111_nl = (fsm_output[0]) | (~ (fsm_output[4]));
  assign mux_21_nl = MUX_s_1_2_2(or_110_nl, or_111_nl, fsm_output[6]);
  assign or_113_nl = mux_21_nl | (fsm_output[5]) | (~ and_dcpl_8) | (fsm_output[1]);
  assign and_nl = (fsm_output[5]) & ((fsm_output[4]) | (fsm_output[0]));
  assign mux_85_nl = MUX_s_1_2_2(and_103_cse, and_nl, fsm_output[3]);
  assign mux_86_nl = MUX_s_1_2_2(mux_85_nl, mux_tmp_63, fsm_output[2]);
  assign mux_87_nl = MUX_s_1_2_2(mux_86_nl, mux_84_cse, fsm_output[1]);
  assign nl_COMP_LOOP_1_acc_11_nl = conv_u2u_10_11(VEC_LOOP_j_sva_9_0) + conv_u2u_9_11({COMP_LOOP_k_9_1_sva_7_0
      , 1'b0}) + conv_u2u_10_11(STAGE_LOOP_lshift_psp_sva);
  assign COMP_LOOP_1_acc_11_nl = nl_COMP_LOOP_1_acc_11_nl[10:0];
  assign nl_COMP_LOOP_2_acc_nl = ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + conv_u2s_9_10({COMP_LOOP_k_9_1_sva_7_0 , 1'b1}) + 10'b0000000001;
  assign COMP_LOOP_2_acc_nl = nl_COMP_LOOP_2_acc_nl[9:0];
  assign nl_COMP_LOOP_acc_1_cse_sva  = VEC_LOOP_j_sva_9_0 + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , 1'b1});
  assign nl_COMP_LOOP_2_acc_10_idiv_sva  = VEC_LOOP_j_sva_9_0 + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , 1'b1}) + conv_u2u_9_10(STAGE_LOOP_lshift_psp_sva[9:1]);
  assign mux_72_nl = MUX_s_1_2_2(mux_tmp_71, mux_tmp_63, fsm_output[2]);
  assign or_108_nl = (fsm_output[0]) | (fsm_output[2]);
  assign mux_70_nl = MUX_s_1_2_2(mux_83_cse, mux_tmp_63, or_108_nl);
  assign mux_73_nl = MUX_s_1_2_2(mux_72_nl, mux_70_nl, fsm_output[1]);
  assign nl_COMP_LOOP_2_acc_11_nl = conv_u2u_10_11(VEC_LOOP_j_sva_9_0) + conv_u2u_9_11({COMP_LOOP_k_9_1_sva_7_0
      , 1'b1}) + conv_u2u_10_11(STAGE_LOOP_lshift_psp_sva);
  assign COMP_LOOP_2_acc_11_nl = nl_COMP_LOOP_2_acc_11_nl[10:0];
  assign or_9_nl = ((fsm_output[3:1]==3'b111)) | (fsm_output[5:4]!=2'b00);
  assign nl_COMP_LOOP_1_acc_nl = ({z_out_2 , 1'b0}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + 10'b0000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[9:0];
  assign or_10_nl = ((fsm_output[3:0]==4'b1111)) | (fsm_output[5:4]!=2'b00);
  assign nor_28_nl = ~((VEC_LOOP_j_sva_9_0[0]) | (~ (fsm_output[2])) | (fsm_output[3])
      | (fsm_output[5]));
  assign nor_29_nl = ~((COMP_LOOP_acc_1_cse_sva[0]) | (fsm_output[2]) | not_tmp_35);
  assign mux_77_nl = MUX_s_1_2_2(nor_28_nl, nor_29_nl, fsm_output[0]);
  assign and_85_nl = and_dcpl_45 & and_dcpl_12 & (~ (fsm_output[6])) & (COMP_LOOP_2_tmp_lshift_itm[0]);
  assign mux_80_nl = MUX_s_1_2_2(mux_tmp_71, mux_83_cse, fsm_output[2]);
  assign mux_81_nl = MUX_s_1_2_2(mux_80_nl, mux_84_cse, fsm_output[1]);
  assign STAGE_LOOP_mux_3_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, (~ STAGE_LOOP_i_3_0_sva),
      nor_72_cse);
  assign nl_z_out_1 = STAGE_LOOP_mux_3_nl + ({nor_72_cse , 1'b0 , nor_72_cse , 1'b1});
  assign z_out_1 = nl_z_out_1[3:0];
  assign COMP_LOOP_mux_43_nl = MUX_v_8_2_2(COMP_LOOP_k_9_1_sva_7_0, ({5'b00000 ,
      (z_out_1[3:1])}), and_dcpl_119);
  assign nl_z_out_2 = conv_u2u_8_9(COMP_LOOP_mux_43_nl) + conv_u2u_2_9({and_dcpl_119
      , 1'b1});
  assign z_out_2 = nl_z_out_2[8:0];
  assign COMP_LOOP_mux_44_nl = MUX_v_10_2_2(({1'b0 , (VEC_LOOP_j_sva_9_0[9:1])}),
      VEC_LOOP_j_sva_9_0, and_dcpl_130);
  assign COMP_LOOP_mux_45_nl = MUX_v_10_2_2(({2'b00 , COMP_LOOP_k_9_1_sva_7_0}),
      STAGE_LOOP_lshift_psp_sva, and_dcpl_130);
  assign nl_z_out_3 = conv_u2u_10_11(COMP_LOOP_mux_44_nl) + conv_u2u_10_11(COMP_LOOP_mux_45_nl);
  assign z_out_3 = nl_z_out_3[10:0];
  assign COMP_LOOP_mux_46_nl = MUX_v_64_2_2(twiddle_rsc_0_0_i_q_d, COMP_LOOP_tmp_mux_itm,
      and_dcpl_142);
  assign COMP_LOOP_or_5_nl = ((COMP_LOOP_2_tmp_lshift_itm[0]) & (~ and_dcpl_142))
      | ((COMP_LOOP_2_acc_10_idiv_sva[0]) & and_dcpl_142);
  assign COMP_LOOP_mux_47_nl = MUX_v_64_2_2(vec_rsc_0_0_i_q_d, vec_rsc_0_1_i_q_d,
      COMP_LOOP_or_5_nl);
  assign nl_z_out_4 = COMP_LOOP_mux_46_nl * COMP_LOOP_mux_47_nl;
  assign z_out_4 = nl_z_out_4[63:0];
  assign COMP_LOOP_tmp_mux_3_nl = MUX_v_9_2_2(({COMP_LOOP_k_9_1_sva_7_0 , 1'b1}),
      ({1'b0 , COMP_LOOP_k_9_1_sva_7_0}), nor_72_cse);
  assign COMP_LOOP_tmp_mux_4_nl = MUX_v_10_2_2(COMP_LOOP_2_tmp_lshift_itm, ({1'b0
      , (z_out[8:0])}), nor_72_cse);
  assign nl_z_out_5 = COMP_LOOP_tmp_mux_3_nl * COMP_LOOP_tmp_mux_4_nl;
  assign z_out_5 = nl_z_out_5[9:0];

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


  function automatic [63:0] MUX1HOT_v_64_7_2;
    input [63:0] input_6;
    input [63:0] input_5;
    input [63:0] input_4;
    input [63:0] input_3;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [6:0] sel;
    reg [63:0] result;
  begin
    result = input_0 & {64{sel[0]}};
    result = result | ( input_1 & {64{sel[1]}});
    result = result | ( input_2 & {64{sel[2]}});
    result = result | ( input_3 & {64{sel[3]}});
    result = result | ( input_4 & {64{sel[4]}});
    result = result | ( input_5 & {64{sel[5]}});
    result = result | ( input_6 & {64{sel[6]}});
    MUX1HOT_v_64_7_2 = result;
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


  function automatic [0:0] readslicef_10_1_9;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 9;
    readslicef_10_1_9 = tmp[0:0];
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


  function automatic [9:0] conv_u2s_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2s_9_10 =  {1'b0, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_2_9 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_9 = {{7{1'b0}}, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_9_11 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_11 = {{2{1'b0}}, vector};
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
//  Design Unit:    inPlaceNTT_DIT_precomp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_precomp (
  clk, rst, vec_rsc_0_0_wadr, vec_rsc_0_0_d, vec_rsc_0_0_we, vec_rsc_0_0_radr, vec_rsc_0_0_q,
      vec_rsc_triosy_0_0_lz, vec_rsc_0_1_wadr, vec_rsc_0_1_d, vec_rsc_0_1_we, vec_rsc_0_1_radr,
      vec_rsc_0_1_q, vec_rsc_triosy_0_1_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat,
      r_rsc_triosy_lz, twiddle_rsc_0_0_radr, twiddle_rsc_0_0_q, twiddle_rsc_triosy_0_0_lz,
      twiddle_rsc_0_1_radr, twiddle_rsc_0_1_q, twiddle_rsc_triosy_0_1_lz
);
  input clk;
  input rst;
  output [8:0] vec_rsc_0_0_wadr;
  output [63:0] vec_rsc_0_0_d;
  output vec_rsc_0_0_we;
  output [8:0] vec_rsc_0_0_radr;
  input [63:0] vec_rsc_0_0_q;
  output vec_rsc_triosy_0_0_lz;
  output [8:0] vec_rsc_0_1_wadr;
  output [63:0] vec_rsc_0_1_d;
  output vec_rsc_0_1_we;
  output [8:0] vec_rsc_0_1_radr;
  input [63:0] vec_rsc_0_1_q;
  output vec_rsc_triosy_0_1_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [8:0] twiddle_rsc_0_0_radr;
  input [63:0] twiddle_rsc_0_0_q;
  output twiddle_rsc_triosy_0_0_lz;
  output [8:0] twiddle_rsc_0_1_radr;
  input [63:0] twiddle_rsc_0_1_q;
  output twiddle_rsc_triosy_0_1_lz;


  // Interconnect Declarations
  wire [63:0] vec_rsc_0_0_i_q_d;
  wire vec_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] vec_rsc_0_1_i_q_d;
  wire vec_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_rsc_0_0_i_q_d;
  wire [8:0] twiddle_rsc_0_0_i_radr_d;
  wire twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_rsc_0_1_i_q_d;
  wire [8:0] twiddle_rsc_0_1_i_radr_d;
  wire twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] vec_rsc_0_0_i_d_d_iff;
  wire [8:0] vec_rsc_0_0_i_radr_d_iff;
  wire [8:0] vec_rsc_0_0_i_wadr_d_iff;
  wire vec_rsc_0_0_i_we_d_iff;
  wire vec_rsc_0_1_i_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_5_9_64_512_512_64_1_gen
      vec_rsc_0_0_i (
      .q(vec_rsc_0_0_q),
      .radr(vec_rsc_0_0_radr),
      .we(vec_rsc_0_0_we),
      .d(vec_rsc_0_0_d),
      .wadr(vec_rsc_0_0_wadr),
      .d_d(vec_rsc_0_0_i_d_d_iff),
      .q_d(vec_rsc_0_0_i_q_d),
      .radr_d(vec_rsc_0_0_i_radr_d_iff),
      .wadr_d(vec_rsc_0_0_i_wadr_d_iff),
      .we_d(vec_rsc_0_0_i_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(vec_rsc_0_0_i_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_6_9_64_512_512_64_1_gen
      vec_rsc_0_1_i (
      .q(vec_rsc_0_1_q),
      .radr(vec_rsc_0_1_radr),
      .we(vec_rsc_0_1_we),
      .d(vec_rsc_0_1_d),
      .wadr(vec_rsc_0_1_wadr),
      .d_d(vec_rsc_0_0_i_d_d_iff),
      .q_d(vec_rsc_0_1_i_q_d),
      .radr_d(vec_rsc_0_0_i_radr_d_iff),
      .wadr_d(vec_rsc_0_0_i_wadr_d_iff),
      .we_d(vec_rsc_0_1_i_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(vec_rsc_0_1_i_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_9_64_512_512_64_1_gen
      twiddle_rsc_0_0_i (
      .q(twiddle_rsc_0_0_q),
      .radr(twiddle_rsc_0_0_radr),
      .q_d(twiddle_rsc_0_0_i_q_d),
      .radr_d(twiddle_rsc_0_0_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIT_precomp_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_8_9_64_512_512_64_1_gen
      twiddle_rsc_0_1_i (
      .q(twiddle_rsc_0_1_q),
      .radr(twiddle_rsc_0_1_radr),
      .q_d(twiddle_rsc_0_1_i_q_d),
      .radr_d(twiddle_rsc_0_1_i_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIT_precomp_core inPlaceNTT_DIT_precomp_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_0_0_lz(vec_rsc_triosy_0_0_lz),
      .vec_rsc_triosy_0_1_lz(vec_rsc_triosy_0_1_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_0_0_lz(twiddle_rsc_triosy_0_0_lz),
      .twiddle_rsc_triosy_0_1_lz(twiddle_rsc_triosy_0_1_lz),
      .vec_rsc_0_0_i_q_d(vec_rsc_0_0_i_q_d),
      .vec_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_1_i_q_d(vec_rsc_0_1_i_q_d),
      .vec_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_0_i_q_d(twiddle_rsc_0_0_i_q_d),
      .twiddle_rsc_0_0_i_radr_d(twiddle_rsc_0_0_i_radr_d),
      .twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_readA_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsc_0_1_i_q_d(twiddle_rsc_0_1_i_q_d),
      .twiddle_rsc_0_1_i_radr_d(twiddle_rsc_0_1_i_radr_d),
      .twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_readA_r_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_0_i_d_d_pff(vec_rsc_0_0_i_d_d_iff),
      .vec_rsc_0_0_i_radr_d_pff(vec_rsc_0_0_i_radr_d_iff),
      .vec_rsc_0_0_i_wadr_d_pff(vec_rsc_0_0_i_wadr_d_iff),
      .vec_rsc_0_0_i_we_d_pff(vec_rsc_0_0_i_we_d_iff),
      .vec_rsc_0_1_i_we_d_pff(vec_rsc_0_1_i_we_d_iff)
    );
endmodule



