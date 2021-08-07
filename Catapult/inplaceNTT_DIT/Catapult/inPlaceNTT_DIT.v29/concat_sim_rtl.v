
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

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Wed May 19 22:55:05 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
    (
  qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [63:0] qa;
  output wea;
  output [63:0] da;
  output [10:0] adra;
  input [10:0] adra_d;
  input [63:0] da_d;
  output [63:0] qa_d;
  input wea_d;
  input rwA_rw_ram_ir_internal_RMASK_B_d;
  input rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d);
  assign da = (da_d);
  assign adra = (adra_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
    (
  qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [63:0] qa;
  output wea;
  output [63:0] da;
  output [10:0] adra;
  input [10:0] adra_d;
  input [63:0] da_d;
  output [63:0] qa_d;
  input wea_d;
  input rwA_rw_ram_ir_internal_RMASK_B_d;
  input rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d);
  assign da = (da_d);
  assign adra = (adra_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIT_core_core_fsm (
  clk, rst, fsm_output, STAGE_LOOP_C_0_tr0, modExp_while_C_5_tr0, COMP_LOOP_C_1_tr0,
      COMP_LOOP_1_modExp_1_while_C_5_tr0, COMP_LOOP_C_12_tr0, COMP_LOOP_2_modExp_1_while_C_5_tr0,
      COMP_LOOP_C_24_tr0, VEC_LOOP_C_0_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [47:0] fsm_output;
  reg [47:0] fsm_output;
  input STAGE_LOOP_C_0_tr0;
  input modExp_while_C_5_tr0;
  input COMP_LOOP_C_1_tr0;
  input COMP_LOOP_1_modExp_1_while_C_5_tr0;
  input COMP_LOOP_C_12_tr0;
  input COMP_LOOP_2_modExp_1_while_C_5_tr0;
  input COMP_LOOP_C_24_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_core_core_fsm_1
  parameter
    main_C_0 = 6'd0,
    STAGE_LOOP_C_0 = 6'd1,
    modExp_while_C_0 = 6'd2,
    modExp_while_C_1 = 6'd3,
    modExp_while_C_2 = 6'd4,
    modExp_while_C_3 = 6'd5,
    modExp_while_C_4 = 6'd6,
    modExp_while_C_5 = 6'd7,
    COMP_LOOP_C_0 = 6'd8,
    COMP_LOOP_C_1 = 6'd9,
    COMP_LOOP_1_modExp_1_while_C_0 = 6'd10,
    COMP_LOOP_1_modExp_1_while_C_1 = 6'd11,
    COMP_LOOP_1_modExp_1_while_C_2 = 6'd12,
    COMP_LOOP_1_modExp_1_while_C_3 = 6'd13,
    COMP_LOOP_1_modExp_1_while_C_4 = 6'd14,
    COMP_LOOP_1_modExp_1_while_C_5 = 6'd15,
    COMP_LOOP_C_2 = 6'd16,
    COMP_LOOP_C_3 = 6'd17,
    COMP_LOOP_C_4 = 6'd18,
    COMP_LOOP_C_5 = 6'd19,
    COMP_LOOP_C_6 = 6'd20,
    COMP_LOOP_C_7 = 6'd21,
    COMP_LOOP_C_8 = 6'd22,
    COMP_LOOP_C_9 = 6'd23,
    COMP_LOOP_C_10 = 6'd24,
    COMP_LOOP_C_11 = 6'd25,
    COMP_LOOP_C_12 = 6'd26,
    COMP_LOOP_C_13 = 6'd27,
    COMP_LOOP_2_modExp_1_while_C_0 = 6'd28,
    COMP_LOOP_2_modExp_1_while_C_1 = 6'd29,
    COMP_LOOP_2_modExp_1_while_C_2 = 6'd30,
    COMP_LOOP_2_modExp_1_while_C_3 = 6'd31,
    COMP_LOOP_2_modExp_1_while_C_4 = 6'd32,
    COMP_LOOP_2_modExp_1_while_C_5 = 6'd33,
    COMP_LOOP_C_14 = 6'd34,
    COMP_LOOP_C_15 = 6'd35,
    COMP_LOOP_C_16 = 6'd36,
    COMP_LOOP_C_17 = 6'd37,
    COMP_LOOP_C_18 = 6'd38,
    COMP_LOOP_C_19 = 6'd39,
    COMP_LOOP_C_20 = 6'd40,
    COMP_LOOP_C_21 = 6'd41,
    COMP_LOOP_C_22 = 6'd42,
    COMP_LOOP_C_23 = 6'd43,
    COMP_LOOP_C_24 = 6'd44,
    VEC_LOOP_C_0 = 6'd45,
    STAGE_LOOP_C_1 = 6'd46,
    main_C_1 = 6'd47;

  reg [5:0] state_var;
  reg [5:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIT_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 48'b000000000000000000000000000000000000000000000010;
        if ( STAGE_LOOP_C_0_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      modExp_while_C_0 : begin
        fsm_output = 48'b000000000000000000000000000000000000000000000100;
        state_var_NS = modExp_while_C_1;
      end
      modExp_while_C_1 : begin
        fsm_output = 48'b000000000000000000000000000000000000000000001000;
        state_var_NS = modExp_while_C_2;
      end
      modExp_while_C_2 : begin
        fsm_output = 48'b000000000000000000000000000000000000000000010000;
        state_var_NS = modExp_while_C_3;
      end
      modExp_while_C_3 : begin
        fsm_output = 48'b000000000000000000000000000000000000000000100000;
        state_var_NS = modExp_while_C_4;
      end
      modExp_while_C_4 : begin
        fsm_output = 48'b000000000000000000000000000000000000000001000000;
        state_var_NS = modExp_while_C_5;
      end
      modExp_while_C_5 : begin
        fsm_output = 48'b000000000000000000000000000000000000000010000000;
        if ( modExp_while_C_5_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 48'b000000000000000000000000000000000000000100000000;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 48'b000000000000000000000000000000000000001000000000;
        if ( COMP_LOOP_C_1_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_1_modExp_1_while_C_0 : begin
        fsm_output = 48'b000000000000000000000000000000000000010000000000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_1;
      end
      COMP_LOOP_1_modExp_1_while_C_1 : begin
        fsm_output = 48'b000000000000000000000000000000000000100000000000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_2;
      end
      COMP_LOOP_1_modExp_1_while_C_2 : begin
        fsm_output = 48'b000000000000000000000000000000000001000000000000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_3;
      end
      COMP_LOOP_1_modExp_1_while_C_3 : begin
        fsm_output = 48'b000000000000000000000000000000000010000000000000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_4;
      end
      COMP_LOOP_1_modExp_1_while_C_4 : begin
        fsm_output = 48'b000000000000000000000000000000000100000000000000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_5;
      end
      COMP_LOOP_1_modExp_1_while_C_5 : begin
        fsm_output = 48'b000000000000000000000000000000001000000000000000;
        if ( COMP_LOOP_1_modExp_1_while_C_5_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 48'b000000000000000000000000000000010000000000000000;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 48'b000000000000000000000000000000100000000000000000;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 48'b000000000000000000000000000001000000000000000000;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 48'b000000000000000000000000000010000000000000000000;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 48'b000000000000000000000000000100000000000000000000;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 48'b000000000000000000000000001000000000000000000000;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 48'b000000000000000000000000010000000000000000000000;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 48'b000000000000000000000000100000000000000000000000;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 48'b000000000000000000000001000000000000000000000000;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 48'b000000000000000000000010000000000000000000000000;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 48'b000000000000000000000100000000000000000000000000;
        if ( COMP_LOOP_C_12_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_13;
        end
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 48'b000000000000000000001000000000000000000000000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_0;
      end
      COMP_LOOP_2_modExp_1_while_C_0 : begin
        fsm_output = 48'b000000000000000000010000000000000000000000000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_1;
      end
      COMP_LOOP_2_modExp_1_while_C_1 : begin
        fsm_output = 48'b000000000000000000100000000000000000000000000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_2;
      end
      COMP_LOOP_2_modExp_1_while_C_2 : begin
        fsm_output = 48'b000000000000000001000000000000000000000000000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_3;
      end
      COMP_LOOP_2_modExp_1_while_C_3 : begin
        fsm_output = 48'b000000000000000010000000000000000000000000000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_4;
      end
      COMP_LOOP_2_modExp_1_while_C_4 : begin
        fsm_output = 48'b000000000000000100000000000000000000000000000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_5;
      end
      COMP_LOOP_2_modExp_1_while_C_5 : begin
        fsm_output = 48'b000000000000001000000000000000000000000000000000;
        if ( COMP_LOOP_2_modExp_1_while_C_5_tr0 ) begin
          state_var_NS = COMP_LOOP_C_14;
        end
        else begin
          state_var_NS = COMP_LOOP_2_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 48'b000000000000010000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 48'b000000000000100000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 48'b000000000001000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 48'b000000000010000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 48'b000000000100000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 48'b000000001000000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 48'b000000010000000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 48'b000000100000000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 48'b000001000000000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 48'b000010000000000000000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 48'b000100000000000000000000000000000000000000000000;
        if ( COMP_LOOP_C_24_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 48'b001000000000000000000000000000000000000000000000;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 48'b010000000000000000000000000000000000000000000000;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 48'b100000000000000000000000000000000000000000000000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 48'b000000000000000000000000000000000000000000000001;
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
//  Design Unit:    inPlaceNTT_DIT_core_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIT_core_wait_dp (
  clk, modulo_result_rem_cmp_z, modulo_result_rem_cmp_z_oreg
);
  input clk;
  input [63:0] modulo_result_rem_cmp_z;
  output [63:0] modulo_result_rem_cmp_z_oreg;
  reg [63:0] modulo_result_rem_cmp_z_oreg;



  // Interconnect Declarations for Component Instantiations 
  always @(posedge clk) begin
    modulo_result_rem_cmp_z_oreg <= modulo_result_rem_cmp_z;
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_core
// ------------------------------------------------------------------


module inPlaceNTT_DIT_core (
  clk, rst, vec_rsc_triosy_0_0_lz, vec_rsc_triosy_0_1_lz, p_rsc_dat, p_rsc_triosy_lz,
      r_rsc_dat, r_rsc_triosy_lz, vec_rsc_0_0_i_qa_d, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_1_i_qa_d, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d, modulo_result_rem_cmp_a,
      modulo_result_rem_cmp_b, modulo_result_rem_cmp_z, vec_rsc_0_0_i_adra_d_pff,
      vec_rsc_0_0_i_da_d_pff, vec_rsc_0_0_i_wea_d_pff, vec_rsc_0_1_i_wea_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_0_0_lz;
  output vec_rsc_triosy_0_1_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  input [63:0] vec_rsc_0_0_i_qa_d;
  output vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  input [63:0] vec_rsc_0_1_i_qa_d;
  output vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [63:0] modulo_result_rem_cmp_a;
  reg [63:0] modulo_result_rem_cmp_a;
  output [63:0] modulo_result_rem_cmp_b;
  reg [63:0] modulo_result_rem_cmp_b;
  input [63:0] modulo_result_rem_cmp_z;
  output [10:0] vec_rsc_0_0_i_adra_d_pff;
  output [63:0] vec_rsc_0_0_i_da_d_pff;
  output vec_rsc_0_0_i_wea_d_pff;
  output vec_rsc_0_1_i_wea_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  wire [63:0] r_rsci_idat;
  wire [63:0] modulo_result_rem_cmp_z_oreg;
  wire [47:0] fsm_output;
  wire or_dcpl_2;
  wire and_dcpl_4;
  wire or_dcpl_16;
  wire or_dcpl_29;
  wire or_dcpl_35;
  wire and_dcpl_94;
  wire or_dcpl_65;
  wire or_dcpl_67;
  wire or_dcpl_70;
  wire or_dcpl_75;
  wire or_dcpl_77;
  wire or_tmp_41;
  wire or_tmp_82;
  wire or_tmp_89;
  wire or_tmp_93;
  reg exit_COMP_LOOP_1_modExp_1_while_sva;
  reg COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  reg [11:0] VEC_LOOP_j_sva_11_0;
  reg [63:0] p_sva;
  wire [9:0] STAGE_LOOP_lshift_psp_sva_mx0w0;
  reg operator_64_false_slc_modExp_exp_0_1_itm;
  reg modExp_exp_1_0_1_sva;
  reg [11:0] COMP_LOOP_acc_10_cse_12_1_1_sva;
  reg [11:0] COMP_LOOP_acc_1_cse_sva;
  wire modExp_while_and_1_rgt;
  reg reg_vec_rsc_triosy_0_1_obj_ld_cse;
  wire [63:0] modulo_result_mux_1_cse;
  reg [7:0] COMP_LOOP_k_9_1_sva_7_0;
  wire [10:0] COMP_LOOP_acc_psp_sva_1;
  wire [11:0] nl_COMP_LOOP_acc_psp_sva_1;
  reg [10:0] COMP_LOOP_acc_psp_sva;
  wire or_tmp_129;
  wire or_tmp_130;
  wire [63:0] z_out;
  wire [127:0] nl_z_out;
  wire [63:0] z_out_1;
  wire [64:0] nl_z_out_1;
  wire [9:0] z_out_2;
  wire [10:0] nl_z_out_2;
  wire [64:0] z_out_3;
  wire [64:0] z_out_4;
  wire [65:0] nl_z_out_4;
  reg [63:0] r_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [9:0] STAGE_LOOP_lshift_psp_sva;
  reg [63:0] modExp_base_sva;
  reg [63:0] modExp_result_sva;
  reg modExp_exp_1_7_1_sva;
  reg modExp_exp_1_6_1_sva;
  reg modExp_exp_1_5_1_sva;
  reg modExp_exp_1_4_1_sva;
  reg modExp_exp_1_3_1_sva;
  reg modExp_exp_1_2_1_sva;
  reg modExp_exp_1_1_1_sva;
  reg [63:0] modExp_1_result_1_sva;
  reg modExp_exp_1_0_1_sva_1;
  reg [63:0] tmp_2_lpi_4_dfm;
  reg [62:0] operator_64_false_slc_modExp_exp_63_1_itm;
  reg [63:0] COMP_LOOP_1_acc_8_itm;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire modulo_result_rem_cmp_a_mx0c1;
  wire modulo_result_rem_cmp_a_mx0c3;
  wire modExp_result_sva_mx0c0;
  wire [63:0] modExp_exp_sva_mx0w0;
  wire modExp_1_result_1_sva_mx0c0;
  wire modExp_1_while_and_7;
  wire [62:0] modExp_exp_sva_mx0_63_1;
  wire modExp_result_and_2_rgt;
  wire modExp_result_and_3_rgt;
  wire or_152_rgt;
  wire modExp_result_and_rgt;
  wire modExp_result_and_1_rgt;
  reg [62:0] modExp_exp_sva_rsp_1;
  wire STAGE_LOOP_or_cse;
  wire COMP_LOOP_or_1_cse;
  wire STAGE_LOOP_acc_itm_2_1;
  wire COMP_LOOP_nor_1_cse;
  wire COMP_LOOP_or_21_cse;

  wire[0:0] modulo_result_or_nl;
  wire[0:0] nor_24_nl;
  wire[9:0] COMP_LOOP_1_acc_nl;
  wire[10:0] nl_COMP_LOOP_1_acc_nl;
  wire[0:0] modExp_while_or_nl;
  wire[0:0] modExp_while_or_1_nl;
  wire[0:0] modExp_while_or_2_nl;
  wire[0:0] COMP_LOOP_mux_42_nl;
  wire[0:0] or_171_nl;
  wire[0:0] COMP_LOOP_mux1h_13_nl;
  wire[0:0] or_203_nl;
  wire[0:0] COMP_LOOP_mux1h_34_nl;
  wire[0:0] or_207_nl;
  wire[2:0] STAGE_LOOP_acc_nl;
  wire[3:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] or_114_nl;
  wire[63:0] modExp_while_if_mux1h_2_nl;
  wire[0:0] modExp_while_if_or_3_nl;
  wire[63:0] modExp_while_if_mux1h_3_nl;
  wire[0:0] modExp_while_if_or_4_nl;
  wire[0:0] modExp_while_if_and_2_nl;
  wire[0:0] modExp_while_if_and_3_nl;
  wire[0:0] modExp_while_if_or_5_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_56_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_57_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_58_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_59_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_60_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_61_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_62_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_63_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_64_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_65_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_66_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_67_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_68_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_69_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_70_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_71_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_72_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_73_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_74_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_75_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_76_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_77_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_78_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_79_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_80_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_81_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_82_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_83_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_84_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_85_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_86_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_87_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_88_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_89_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_90_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_91_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_92_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_93_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_94_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_95_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_96_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_97_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_98_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_99_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_100_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_101_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_102_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_103_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_104_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_105_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_106_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_107_nl;
  wire[1:0] COMP_LOOP_COMP_LOOP_or_108_nl;
  wire[1:0] COMP_LOOP_and_109_nl;
  wire[1:0] COMP_LOOP_mux_45_nl;
  wire[0:0] COMP_LOOP_nor_57_nl;
  wire[1:0] COMP_LOOP_or_22_nl;
  wire[1:0] COMP_LOOP_mux1h_64_nl;
  wire[0:0] COMP_LOOP_or_23_nl;
  wire[6:0] COMP_LOOP_mux1h_65_nl;
  wire[0:0] COMP_LOOP_or_24_nl;
  wire[0:0] COMP_LOOP_mux1h_66_nl;
  wire[63:0] COMP_LOOP_mux1h_67_nl;
  wire[65:0] acc_2_nl;
  wire[66:0] nl_acc_2_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_109_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_110_nl;
  wire[0:0] COMP_LOOP_mux_46_nl;
  wire[62:0] COMP_LOOP_mux1h_68_nl;
  wire[0:0] COMP_LOOP_or_27_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_55_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_56_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_57_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_58_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_59_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_60_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_61_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_62_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_63_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_64_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_65_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_66_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_67_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_68_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_69_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_70_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_71_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_72_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_73_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_74_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_75_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_76_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_77_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_78_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_79_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_80_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_81_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_82_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_83_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_84_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_85_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_86_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_87_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_88_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_89_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_90_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_91_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_92_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_93_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_94_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_95_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_96_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_97_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_98_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_99_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_100_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_101_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_102_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_103_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_104_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_105_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_106_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_107_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_108_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_109_nl;
  wire[7:0] COMP_LOOP_and_111_nl;
  wire[7:0] COMP_LOOP_COMP_LOOP_mux_3_nl;
  wire[0:0] COMP_LOOP_or_28_nl;
  wire[0:0] COMP_LOOP_nor_61_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_111_nl;
  wire[63:0] modulo_qelse_mux_2_nl;
  wire[63:0] modulo_qelse_modulo_qelse_or_1_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_0_tr0 = ~ (z_out_3[64]);
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_12_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_12_tr0 = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_5_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_5_tr0
      = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out_1[12];
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ STAGE_LOOP_acc_itm_2_1;
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd3),
  .width(32'sd64)) r_rsci (
      .dat(r_rsc_dat),
      .idat(r_rsci_idat)
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
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) STAGE_LOOP_lshift_rg (
      .a(1'b1),
      .s(STAGE_LOOP_i_3_0_sva),
      .z(STAGE_LOOP_lshift_psp_sva_mx0w0)
    );
  inPlaceNTT_DIT_core_wait_dp inPlaceNTT_DIT_core_wait_dp_inst (
      .clk(clk),
      .modulo_result_rem_cmp_z(modulo_result_rem_cmp_z),
      .modulo_result_rem_cmp_z_oreg(modulo_result_rem_cmp_z_oreg)
    );
  inPlaceNTT_DIT_core_core_fsm inPlaceNTT_DIT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .STAGE_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_0_tr0[0:0]),
      .modExp_while_C_5_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .COMP_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0[0:0]),
      .COMP_LOOP_1_modExp_1_while_C_5_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .COMP_LOOP_C_12_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_12_tr0[0:0]),
      .COMP_LOOP_2_modExp_1_while_C_5_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_5_tr0[0:0]),
      .COMP_LOOP_C_24_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign modExp_result_and_2_rgt = (~ modExp_while_and_1_rgt) & (fsm_output[5]);
  assign modExp_result_and_3_rgt = modExp_while_and_1_rgt & (fsm_output[5]);
  assign STAGE_LOOP_or_cse = (fsm_output[1]) | (fsm_output[7]);
  assign modulo_result_mux_1_cse = MUX_v_64_2_2(modulo_result_rem_cmp_z_oreg, (z_out_4[63:0]),
      modulo_result_rem_cmp_z_oreg[63]);
  assign or_152_rgt = (fsm_output[9]) | (fsm_output[27]);
  assign modExp_result_and_rgt = (~ modExp_1_while_and_7) & or_tmp_82;
  assign modExp_result_and_1_rgt = modExp_1_while_and_7 & or_tmp_82;
  assign COMP_LOOP_or_1_cse = (fsm_output[16]) | (fsm_output[34]);
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b0001;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_acc_psp_sva_1 = (VEC_LOOP_j_sva_11_0[11:1]) + conv_u2u_8_11(COMP_LOOP_k_9_1_sva_7_0);
  assign COMP_LOOP_acc_psp_sva_1 = nl_COMP_LOOP_acc_psp_sva_1[10:0];
  assign modExp_while_and_1_rgt = (modulo_result_rem_cmp_z_oreg[63]) & operator_64_false_slc_modExp_exp_0_1_itm;
  assign modExp_exp_sva_mx0w0 = div_64_s65_u10(z_out_4, STAGE_LOOP_lshift_psp_sva_mx0w0);
  assign modExp_exp_sva_mx0_63_1 = MUX_v_63_2_2(({1'b0 , (modExp_exp_sva_rsp_1[62:1])}),
      (modExp_exp_sva_mx0w0[63:1]), fsm_output[1]);
  assign modExp_1_while_and_7 = (modulo_result_rem_cmp_z_oreg[63]) & modExp_exp_1_0_1_sva;
  assign or_dcpl_2 = (~ exit_COMP_LOOP_1_modExp_1_while_sva) | (z_out_3[64]);
  assign and_dcpl_4 = ~((fsm_output[47]) | (fsm_output[0]));
  assign or_dcpl_16 = (fsm_output[32]) | (fsm_output[12]);
  assign or_dcpl_29 = (fsm_output[43]) | (fsm_output[25]);
  assign or_dcpl_35 = (fsm_output[12]) | (fsm_output[31]);
  assign and_dcpl_94 = ~((fsm_output[13]) | (fsm_output[33]));
  assign or_dcpl_65 = (fsm_output[31]) | (fsm_output[29]) | (fsm_output[11]);
  assign or_dcpl_67 = (fsm_output[30]) | (fsm_output[32]);
  assign or_dcpl_70 = (fsm_output[15]) | (fsm_output[14]) | (fsm_output[28]);
  assign or_dcpl_75 = or_dcpl_35 | (fsm_output[29]);
  assign or_dcpl_77 = or_dcpl_70 | or_dcpl_67;
  assign or_tmp_41 = (fsm_output[38]) | (fsm_output[20]);
  assign or_tmp_82 = (fsm_output[13]) | (fsm_output[33]);
  assign or_tmp_89 = or_dcpl_77 | or_dcpl_75 | (fsm_output[11]) | (fsm_output[13]);
  assign or_tmp_93 = (fsm_output[33]) | (fsm_output[10]);
  assign modulo_result_rem_cmp_a_mx0c1 = (fsm_output[22]) | (fsm_output[40]) | (fsm_output[30])
      | or_dcpl_35 | (fsm_output[13]) | (fsm_output[23]) | (fsm_output[41]) | (fsm_output[5])
      | (fsm_output[4]);
  assign modulo_result_rem_cmp_a_mx0c3 = (fsm_output[35]) | (fsm_output[17]);
  assign modExp_result_sva_mx0c0 = (fsm_output[47]) | (fsm_output[0]) | (fsm_output[46])
      | (fsm_output[1]);
  assign modExp_1_result_1_sva_mx0c0 = ~((fsm_output[15]) | (fsm_output[14]) | (fsm_output[28])
      | (fsm_output[30]) | (fsm_output[32]) | (fsm_output[12]) | (fsm_output[31])
      | (fsm_output[29]) | (fsm_output[11]) | (~ and_dcpl_94) | (fsm_output[34])
      | (fsm_output[16]) | (fsm_output[10]));
  assign nl_STAGE_LOOP_acc_nl = (STAGE_LOOP_i_3_0_sva_2[3:1]) + 3'b011;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[2:0];
  assign STAGE_LOOP_acc_itm_2_1 = readslicef_3_1_2(STAGE_LOOP_acc_nl);
  assign or_114_nl = (fsm_output[26]) | (fsm_output[41]);
  assign vec_rsc_0_0_i_adra_d_pff = MUX1HOT_v_11_5_2(COMP_LOOP_acc_psp_sva_1, (z_out_1[12:2]),
      COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_10_cse_12_1_1_sva[11:1]), (COMP_LOOP_acc_1_cse_sva[11:1]),
      {(fsm_output[8]) , COMP_LOOP_or_1_cse , (fsm_output[23]) , or_dcpl_29 , or_114_nl});
  assign vec_rsc_0_0_i_da_d_pff = modulo_result_mux_1_cse;
  assign vec_rsc_0_0_i_wea_d_pff = ((~ (VEC_LOOP_j_sva_11_0[0])) & (fsm_output[23]))
      | ((~ (COMP_LOOP_acc_10_cse_12_1_1_sva[0])) & or_dcpl_29) | ((~ (COMP_LOOP_acc_1_cse_sva[0]))
      & (fsm_output[41]));
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = ((~ (COMP_LOOP_acc_1_cse_sva[0]))
      & COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm & (fsm_output[26]))
      | ((~ (z_out_1[1])) & (fsm_output[34])) | ((~ (VEC_LOOP_j_sva_11_0[0])) & (fsm_output[8]))
      | ((~ (z_out_1[1])) & (fsm_output[16]));
  assign vec_rsc_0_1_i_wea_d_pff = ((VEC_LOOP_j_sva_11_0[0]) & (fsm_output[23]))
      | ((COMP_LOOP_acc_10_cse_12_1_1_sva[0]) & or_dcpl_29) | ((COMP_LOOP_acc_1_cse_sva[0])
      & (fsm_output[41]));
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = ((COMP_LOOP_acc_1_cse_sva[0])
      & COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm & (fsm_output[26]))
      | ((z_out_1[1]) & (fsm_output[34])) | ((VEC_LOOP_j_sva_11_0[0]) & (fsm_output[8]))
      | ((z_out_1[1]) & (fsm_output[16]));
  assign or_tmp_129 = (fsm_output[29]) | (fsm_output[10]);
  assign or_tmp_130 = (fsm_output[28]) | (fsm_output[11]);
  assign COMP_LOOP_nor_1_cse = ~((fsm_output[16]) | (fsm_output[34]) | (fsm_output[45]));
  always @(posedge clk) begin
    if ( ~ and_dcpl_4 ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[0]) | (fsm_output[46]) ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, STAGE_LOOP_i_3_0_sva_2, fsm_output[46]);
    end
  end
  always @(posedge clk) begin
    if ( ~ and_dcpl_4 ) begin
      r_sva <= r_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= 1'b0;
      modExp_exp_1_0_1_sva <= 1'b0;
      modExp_exp_1_7_1_sva <= 1'b0;
      modExp_exp_1_0_1_sva_1 <= 1'b0;
    end
    else begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= (~ STAGE_LOOP_acc_itm_2_1) & (fsm_output[46]);
      modExp_exp_1_0_1_sva <= (COMP_LOOP_mux_42_nl & (~ (fsm_output[9]))) | (~((fsm_output[9])
          | (fsm_output[15]) | (fsm_output[14]) | (fsm_output[28]) | (fsm_output[30])
          | (fsm_output[32]) | (fsm_output[12]) | (fsm_output[31]) | (fsm_output[29])
          | (fsm_output[11]) | (~ and_dcpl_94) | (fsm_output[10])));
      modExp_exp_1_7_1_sva <= COMP_LOOP_mux1h_13_nl & (~ (fsm_output[33]));
      modExp_exp_1_0_1_sva_1 <= COMP_LOOP_mux1h_34_nl & (~ (fsm_output[15]));
    end
  end
  always @(posedge clk) begin
    modulo_result_rem_cmp_b <= p_sva;
  end
  always @(posedge clk) begin
    if ( (fsm_output[28]) | (fsm_output[2]) | (fsm_output[10]) | modulo_result_rem_cmp_a_mx0c1
        | modulo_result_rem_cmp_a_mx0c3 | or_tmp_41 ) begin
      modulo_result_rem_cmp_a <= MUX1HOT_v_64_3_2(z_out, COMP_LOOP_1_acc_8_itm, z_out_1,
          {modulo_result_or_nl , modulo_result_rem_cmp_a_mx0c1 , or_tmp_41});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_sva_11_0 <= 12'b000000000000;
    end
    else if ( STAGE_LOOP_or_cse | (fsm_output[45]) ) begin
      VEC_LOOP_j_sva_11_0 <= MUX_v_12_2_2(12'b000000000000, (z_out_1[11:0]), (fsm_output[45]));
    end
  end
  always @(posedge clk) begin
    if ( ~(and_dcpl_4 & (~ (fsm_output[46])) & (~ (fsm_output[1]))) ) begin
      STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= 8'b00000000;
    end
    else if ( (fsm_output[7]) | (fsm_output[1]) | (fsm_output[34]) | (fsm_output[45])
        ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= MUX_v_8_2_2(8'b00000000, (z_out_3[7:0]), nor_24_nl);
    end
  end
  always @(posedge clk) begin
    if ( (operator_64_false_slc_modExp_exp_0_1_itm | modExp_result_sva_mx0c0 | (~((~
        and_dcpl_4) | (fsm_output[46]) | (fsm_output[1]) | (fsm_output[5])))) & (modExp_result_sva_mx0c0
        | modExp_result_and_2_rgt | modExp_result_and_3_rgt) ) begin
      modExp_result_sva <= MUX1HOT_v_64_3_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
          modulo_result_rem_cmp_z_oreg, (z_out_4[63:0]), {modExp_result_sva_mx0c0
          , modExp_result_and_2_rgt , modExp_result_and_3_rgt});
    end
  end
  always @(posedge clk) begin
    if ( STAGE_LOOP_or_cse ) begin
      modExp_base_sva <= MUX_v_64_2_2(r_sva, modulo_result_mux_1_cse, fsm_output[7]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      operator_64_false_slc_modExp_exp_0_1_itm <= 1'b0;
    end
    else if ( STAGE_LOOP_or_cse & or_dcpl_2 ) begin
      operator_64_false_slc_modExp_exp_0_1_itm <= MUX_s_1_2_2((modExp_exp_sva_rsp_1[0]),
          (modExp_exp_sva_mx0w0[0]), fsm_output[1]);
    end
  end
  always @(posedge clk) begin
    if ( or_dcpl_2 ) begin
      operator_64_false_slc_modExp_exp_63_1_itm <= modExp_exp_sva_mx0_63_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_COMP_LOOP_1_modExp_1_while_sva <= 1'b0;
    end
    else if ( (fsm_output[34]) | (fsm_output[2]) | (fsm_output[10]) ) begin
      exit_COMP_LOOP_1_modExp_1_while_sva <= MUX1HOT_s_1_3_2((~ (z_out_3[63])), (~
          (z_out_1[8])), (~ (readslicef_10_1_9(COMP_LOOP_1_acc_nl))), {(fsm_output[2])
          , (fsm_output[10]) , (fsm_output[34])});
    end
  end
  always @(posedge clk) begin
    if ( ~((fsm_output[22]) | (fsm_output[21]) | (fsm_output[40]) | (fsm_output[39])
        | (fsm_output[28]) | (fsm_output[30]) | or_dcpl_16 | (fsm_output[33]) | (fsm_output[4])
        | (fsm_output[10])) ) begin
      COMP_LOOP_1_acc_8_itm <= MUX1HOT_v_64_5_2(z_out, modExp_result_sva, modulo_result_rem_cmp_z_oreg,
          (z_out_4[63:0]), (z_out_3[63:0]), {modExp_while_or_nl , or_152_rgt , modExp_while_or_1_nl
          , modExp_while_or_2_nl , or_tmp_41});
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[8] ) begin
      COMP_LOOP_acc_psp_sva <= COMP_LOOP_acc_psp_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[28]) | (fsm_output[8]) | (fsm_output[16]) ) begin
      COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm <= MUX1HOT_s_1_3_2((z_out_1[9]),
          (z_out_3[9]), (z_out_1[8]), {(fsm_output[8]) , (fsm_output[16]) , (fsm_output[28])});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_1_cse_sva <= 12'b000000000000;
    end
    else if ( (fsm_output[44]) | (fsm_output[43]) | (fsm_output[42]) | (fsm_output[7])
        | (fsm_output[6]) | (fsm_output[47]) | (fsm_output[0]) | (fsm_output[46])
        | (fsm_output[8]) | (fsm_output[1]) | (fsm_output[45]) | (fsm_output[41])
        | (fsm_output[5]) | (fsm_output[3]) | (fsm_output[2]) | (fsm_output[4]) )
        begin
      COMP_LOOP_acc_1_cse_sva <= z_out_3[11:0];
    end
  end
  always @(posedge clk) begin
    if ( (modExp_exp_1_0_1_sva | modExp_1_result_1_sva_mx0c0 | or_dcpl_70 | or_dcpl_67
        | (fsm_output[12]) | or_dcpl_65 | (fsm_output[34]) | (fsm_output[16]) | (fsm_output[10]))
        & (modExp_1_result_1_sva_mx0c0 | modExp_result_and_rgt | modExp_result_and_1_rgt)
        ) begin
      modExp_1_result_1_sva <= MUX1HOT_v_64_3_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
          modulo_result_rem_cmp_z_oreg, (z_out_4[63:0]), {modExp_1_result_1_sva_mx0c0
          , modExp_result_and_rgt , modExp_result_and_1_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_6_1_sva <= 1'b0;
    end
    else if ( ~ or_tmp_89 ) begin
      modExp_exp_1_6_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[5]), modExp_exp_1_7_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[6]), {(fsm_output[9]) , or_tmp_93 , (fsm_output[27])});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_5_1_sva <= 1'b0;
    end
    else if ( ~ or_tmp_89 ) begin
      modExp_exp_1_5_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[4]), modExp_exp_1_6_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[5]), {(fsm_output[9]) , or_tmp_93 , (fsm_output[27])});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_4_1_sva <= 1'b0;
    end
    else if ( ~ or_tmp_89 ) begin
      modExp_exp_1_4_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[3]), modExp_exp_1_5_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[4]), {(fsm_output[9]) , or_tmp_93 , (fsm_output[27])});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_3_1_sva <= 1'b0;
    end
    else if ( ~ or_tmp_89 ) begin
      modExp_exp_1_3_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[2]), modExp_exp_1_4_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[3]), {(fsm_output[9]) , or_tmp_93 , (fsm_output[27])});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_2_1_sva <= 1'b0;
    end
    else if ( ~ or_tmp_89 ) begin
      modExp_exp_1_2_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[1]), modExp_exp_1_3_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[2]), {(fsm_output[9]) , or_tmp_93 , (fsm_output[27])});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_1_1_sva <= 1'b0;
    end
    else if ( ~ or_tmp_89 ) begin
      modExp_exp_1_1_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[0]), modExp_exp_1_2_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[1]), {(fsm_output[9]) , or_tmp_93 , (fsm_output[27])});
    end
  end
  always @(posedge clk) begin
    if ( or_152_rgt ) begin
      tmp_2_lpi_4_dfm <= MUX_v_64_2_2(vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, or_203_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_10_cse_12_1_1_sva <= 12'b000000000000;
    end
    else if ( COMP_LOOP_or_1_cse ) begin
      COMP_LOOP_acc_10_cse_12_1_1_sva <= z_out_1[12:1];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_sva_rsp_1 <= 63'b000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~((fsm_output[6:2]!=5'b00000)) ) begin
      modExp_exp_sva_rsp_1 <= modExp_exp_sva_mx0_63_1;
    end
  end
  assign or_171_nl = or_dcpl_77 | or_dcpl_75 | (fsm_output[11:10]!=2'b00);
  assign COMP_LOOP_mux_42_nl = MUX_s_1_2_2(modExp_exp_1_0_1_sva_1, modExp_exp_1_0_1_sva,
      or_171_nl);
  assign COMP_LOOP_mux1h_13_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0[6]), modExp_exp_1_0_1_sva_1,
      modExp_exp_1_7_1_sva, (COMP_LOOP_k_9_1_sva_7_0[7]), {(fsm_output[9]) , (fsm_output[10])
      , or_tmp_89 , (fsm_output[27])});
  assign or_207_nl = (fsm_output[28]) | (fsm_output[30]) | or_dcpl_16 | or_dcpl_65;
  assign COMP_LOOP_mux1h_34_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0[7]), modExp_exp_1_1_1_sva,
      modExp_exp_1_0_1_sva_1, (COMP_LOOP_k_9_1_sva_7_0[0]), {(fsm_output[9]) , or_tmp_93
      , or_207_nl , (fsm_output[27])});
  assign modulo_result_or_nl = (fsm_output[2]) | modulo_result_rem_cmp_a_mx0c3 |
      (fsm_output[10]) | (fsm_output[28]);
  assign nor_24_nl = ~(STAGE_LOOP_or_cse | (fsm_output[45]));
  assign nl_COMP_LOOP_1_acc_nl = ({(z_out_3[8:0]) , 1'b0}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + 10'b0000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[9:0];
  assign modExp_while_or_nl = (fsm_output[3]) | (fsm_output[29]) | (fsm_output[11]);
  assign modExp_while_or_1_nl = ((~ (modulo_result_rem_cmp_z_oreg[63])) & (fsm_output[15]))
      | ((~ (modulo_result_rem_cmp_z_oreg[63])) & (fsm_output[31]));
  assign modExp_while_or_2_nl = ((modulo_result_rem_cmp_z_oreg[63]) & (fsm_output[15]))
      | ((modulo_result_rem_cmp_z_oreg[63]) & (fsm_output[31]));
  assign or_203_nl = ((COMP_LOOP_acc_1_cse_sva[0]) & (fsm_output[27])) | ((VEC_LOOP_j_sva_11_0[0])
      & (fsm_output[9]));
  assign modExp_while_if_or_3_nl = modulo_result_rem_cmp_a_mx0c3 | or_tmp_129;
  assign modExp_while_if_mux1h_2_nl = MUX1HOT_v_64_4_2(modExp_result_sva, modExp_1_result_1_sva,
      modExp_base_sva, COMP_LOOP_1_acc_8_itm, {(fsm_output[2]) , modExp_while_if_or_3_nl
      , (fsm_output[3]) , or_tmp_130});
  assign modExp_while_if_or_4_nl = (fsm_output[3:2]!=2'b00);
  assign modExp_while_if_and_2_nl = (~ (COMP_LOOP_acc_10_cse_12_1_1_sva[0])) & modulo_result_rem_cmp_a_mx0c3;
  assign modExp_while_if_and_3_nl = (COMP_LOOP_acc_10_cse_12_1_1_sva[0]) & modulo_result_rem_cmp_a_mx0c3;
  assign modExp_while_if_or_5_nl = or_tmp_129 | or_tmp_130;
  assign modExp_while_if_mux1h_3_nl = MUX1HOT_v_64_4_2(modExp_base_sva, vec_rsc_0_0_i_qa_d,
      vec_rsc_0_1_i_qa_d, COMP_LOOP_1_acc_8_itm, {modExp_while_if_or_4_nl , modExp_while_if_and_2_nl
      , modExp_while_if_and_3_nl , modExp_while_if_or_5_nl});
  assign nl_z_out = modExp_while_if_mux1h_2_nl * modExp_while_if_mux1h_3_nl;
  assign z_out = nl_z_out[63:0];
  assign COMP_LOOP_or_21_cse = (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_56_nl = ((tmp_2_lpi_4_dfm[63]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_57_nl = ((tmp_2_lpi_4_dfm[62]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_58_nl = ((tmp_2_lpi_4_dfm[61]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_59_nl = ((tmp_2_lpi_4_dfm[60]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_60_nl = ((tmp_2_lpi_4_dfm[59]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_61_nl = ((tmp_2_lpi_4_dfm[58]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_62_nl = ((tmp_2_lpi_4_dfm[57]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_63_nl = ((tmp_2_lpi_4_dfm[56]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_64_nl = ((tmp_2_lpi_4_dfm[55]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_65_nl = ((tmp_2_lpi_4_dfm[54]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_66_nl = ((tmp_2_lpi_4_dfm[53]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_67_nl = ((tmp_2_lpi_4_dfm[52]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_68_nl = ((tmp_2_lpi_4_dfm[51]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_69_nl = ((tmp_2_lpi_4_dfm[50]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_70_nl = ((tmp_2_lpi_4_dfm[49]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_71_nl = ((tmp_2_lpi_4_dfm[48]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_72_nl = ((tmp_2_lpi_4_dfm[47]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_73_nl = ((tmp_2_lpi_4_dfm[46]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_74_nl = ((tmp_2_lpi_4_dfm[45]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_75_nl = ((tmp_2_lpi_4_dfm[44]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_76_nl = ((tmp_2_lpi_4_dfm[43]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_77_nl = ((tmp_2_lpi_4_dfm[42]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_78_nl = ((tmp_2_lpi_4_dfm[41]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_79_nl = ((tmp_2_lpi_4_dfm[40]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_80_nl = ((tmp_2_lpi_4_dfm[39]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_81_nl = ((tmp_2_lpi_4_dfm[38]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_82_nl = ((tmp_2_lpi_4_dfm[37]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_83_nl = ((tmp_2_lpi_4_dfm[36]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_84_nl = ((tmp_2_lpi_4_dfm[35]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_85_nl = ((tmp_2_lpi_4_dfm[34]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_86_nl = ((tmp_2_lpi_4_dfm[33]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_87_nl = ((tmp_2_lpi_4_dfm[32]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_88_nl = ((tmp_2_lpi_4_dfm[31]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_89_nl = ((tmp_2_lpi_4_dfm[30]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_90_nl = ((tmp_2_lpi_4_dfm[29]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_91_nl = ((tmp_2_lpi_4_dfm[28]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_92_nl = ((tmp_2_lpi_4_dfm[27]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_93_nl = ((tmp_2_lpi_4_dfm[26]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_94_nl = ((tmp_2_lpi_4_dfm[25]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_95_nl = ((tmp_2_lpi_4_dfm[24]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_96_nl = ((tmp_2_lpi_4_dfm[23]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_97_nl = ((tmp_2_lpi_4_dfm[22]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_98_nl = ((tmp_2_lpi_4_dfm[21]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_99_nl = ((tmp_2_lpi_4_dfm[20]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_100_nl = ((tmp_2_lpi_4_dfm[19]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_101_nl = ((tmp_2_lpi_4_dfm[18]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_102_nl = ((tmp_2_lpi_4_dfm[17]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_103_nl = ((tmp_2_lpi_4_dfm[16]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_104_nl = ((tmp_2_lpi_4_dfm[15]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_105_nl = ((tmp_2_lpi_4_dfm[14]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_106_nl = ((tmp_2_lpi_4_dfm[13]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_COMP_LOOP_or_107_nl = ((tmp_2_lpi_4_dfm[12]) & COMP_LOOP_nor_1_cse)
      | (fsm_output[8]) | (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_mux_45_nl = MUX_v_2_2_2((tmp_2_lpi_4_dfm[11:10]), (VEC_LOOP_j_sva_11_0[11:10]),
      fsm_output[45]);
  assign COMP_LOOP_nor_57_nl = ~((fsm_output[16]) | (fsm_output[34]));
  assign COMP_LOOP_and_109_nl = MUX_v_2_2_2(2'b00, COMP_LOOP_mux_45_nl, COMP_LOOP_nor_57_nl);
  assign COMP_LOOP_COMP_LOOP_or_108_nl = MUX_v_2_2_2(COMP_LOOP_and_109_nl, 2'b11,
      COMP_LOOP_or_21_cse);
  assign COMP_LOOP_mux1h_64_nl = MUX1HOT_v_2_4_2((tmp_2_lpi_4_dfm[9:8]), ({1'b1 ,
      (~ (COMP_LOOP_k_9_1_sva_7_0[7]))}), (z_out_2[9:8]), (VEC_LOOP_j_sva_11_0[9:8]),
      {or_tmp_41 , (fsm_output[8]) , COMP_LOOP_or_1_cse , (fsm_output[45])});
  assign COMP_LOOP_or_23_nl = (fsm_output[28]) | (fsm_output[10]);
  assign COMP_LOOP_or_22_nl = MUX_v_2_2_2(COMP_LOOP_mux1h_64_nl, 2'b11, COMP_LOOP_or_23_nl);
  assign COMP_LOOP_mux1h_65_nl = MUX1HOT_v_7_6_2((tmp_2_lpi_4_dfm[7:1]), (~ (COMP_LOOP_k_9_1_sva_7_0[6:0])),
      ({(~ modExp_exp_1_7_1_sva) , (~ modExp_exp_1_6_1_sva) , (~ modExp_exp_1_5_1_sva)
      , (~ modExp_exp_1_4_1_sva) , (~ modExp_exp_1_3_1_sva) , (~ modExp_exp_1_2_1_sva)
      , (~ modExp_exp_1_1_1_sva)}), (z_out_2[7:1]), (VEC_LOOP_j_sva_11_0[7:1]), ({(~
      modExp_exp_1_0_1_sva_1) , (~ modExp_exp_1_7_1_sva) , (~ modExp_exp_1_6_1_sva)
      , (~ modExp_exp_1_5_1_sva) , (~ modExp_exp_1_4_1_sva) , (~ modExp_exp_1_3_1_sva)
      , (~ modExp_exp_1_2_1_sva)}), {or_tmp_41 , (fsm_output[8]) , (fsm_output[28])
      , COMP_LOOP_or_1_cse , (fsm_output[45]) , (fsm_output[10])});
  assign COMP_LOOP_mux1h_66_nl = MUX1HOT_s_1_5_2((tmp_2_lpi_4_dfm[0]), (~ modExp_exp_1_0_1_sva_1),
      (z_out_2[0]), (VEC_LOOP_j_sva_11_0[0]), (~ modExp_exp_1_1_1_sva), {or_tmp_41
      , (fsm_output[28]) , COMP_LOOP_or_1_cse , (fsm_output[45]) , (fsm_output[10])});
  assign COMP_LOOP_or_24_nl = COMP_LOOP_mux1h_66_nl | (fsm_output[8]);
  assign COMP_LOOP_mux1h_67_nl = MUX1HOT_v_64_4_2(modulo_result_mux_1_cse, 64'b0000000000000000000000000000000000000000000000000000000000000001,
      ({52'b0000000000000000000000000000000000000000000000000000 , VEC_LOOP_j_sva_11_0}),
      ({54'b000000000000000000000000000000000000000000000000000000 , STAGE_LOOP_lshift_psp_sva}),
      {or_tmp_41 , COMP_LOOP_or_21_cse , COMP_LOOP_or_1_cse , (fsm_output[45])});
  assign nl_z_out_1 = ({COMP_LOOP_COMP_LOOP_or_56_nl , COMP_LOOP_COMP_LOOP_or_57_nl
      , COMP_LOOP_COMP_LOOP_or_58_nl , COMP_LOOP_COMP_LOOP_or_59_nl , COMP_LOOP_COMP_LOOP_or_60_nl
      , COMP_LOOP_COMP_LOOP_or_61_nl , COMP_LOOP_COMP_LOOP_or_62_nl , COMP_LOOP_COMP_LOOP_or_63_nl
      , COMP_LOOP_COMP_LOOP_or_64_nl , COMP_LOOP_COMP_LOOP_or_65_nl , COMP_LOOP_COMP_LOOP_or_66_nl
      , COMP_LOOP_COMP_LOOP_or_67_nl , COMP_LOOP_COMP_LOOP_or_68_nl , COMP_LOOP_COMP_LOOP_or_69_nl
      , COMP_LOOP_COMP_LOOP_or_70_nl , COMP_LOOP_COMP_LOOP_or_71_nl , COMP_LOOP_COMP_LOOP_or_72_nl
      , COMP_LOOP_COMP_LOOP_or_73_nl , COMP_LOOP_COMP_LOOP_or_74_nl , COMP_LOOP_COMP_LOOP_or_75_nl
      , COMP_LOOP_COMP_LOOP_or_76_nl , COMP_LOOP_COMP_LOOP_or_77_nl , COMP_LOOP_COMP_LOOP_or_78_nl
      , COMP_LOOP_COMP_LOOP_or_79_nl , COMP_LOOP_COMP_LOOP_or_80_nl , COMP_LOOP_COMP_LOOP_or_81_nl
      , COMP_LOOP_COMP_LOOP_or_82_nl , COMP_LOOP_COMP_LOOP_or_83_nl , COMP_LOOP_COMP_LOOP_or_84_nl
      , COMP_LOOP_COMP_LOOP_or_85_nl , COMP_LOOP_COMP_LOOP_or_86_nl , COMP_LOOP_COMP_LOOP_or_87_nl
      , COMP_LOOP_COMP_LOOP_or_88_nl , COMP_LOOP_COMP_LOOP_or_89_nl , COMP_LOOP_COMP_LOOP_or_90_nl
      , COMP_LOOP_COMP_LOOP_or_91_nl , COMP_LOOP_COMP_LOOP_or_92_nl , COMP_LOOP_COMP_LOOP_or_93_nl
      , COMP_LOOP_COMP_LOOP_or_94_nl , COMP_LOOP_COMP_LOOP_or_95_nl , COMP_LOOP_COMP_LOOP_or_96_nl
      , COMP_LOOP_COMP_LOOP_or_97_nl , COMP_LOOP_COMP_LOOP_or_98_nl , COMP_LOOP_COMP_LOOP_or_99_nl
      , COMP_LOOP_COMP_LOOP_or_100_nl , COMP_LOOP_COMP_LOOP_or_101_nl , COMP_LOOP_COMP_LOOP_or_102_nl
      , COMP_LOOP_COMP_LOOP_or_103_nl , COMP_LOOP_COMP_LOOP_or_104_nl , COMP_LOOP_COMP_LOOP_or_105_nl
      , COMP_LOOP_COMP_LOOP_or_106_nl , COMP_LOOP_COMP_LOOP_or_107_nl , COMP_LOOP_COMP_LOOP_or_108_nl
      , COMP_LOOP_or_22_nl , COMP_LOOP_mux1h_65_nl , COMP_LOOP_or_24_nl}) + COMP_LOOP_mux1h_67_nl;
  assign z_out_1 = nl_z_out_1[63:0];
  assign nl_z_out_2 = STAGE_LOOP_lshift_psp_sva + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , (fsm_output[34])});
  assign z_out_2 = nl_z_out_2[9:0];
  assign COMP_LOOP_COMP_LOOP_or_109_nl = (~(or_tmp_41 | (fsm_output[16]) | (fsm_output[8])
      | (fsm_output[34]))) | (fsm_output[2:1]!=2'b00);
  assign COMP_LOOP_mux_46_nl = MUX_s_1_2_2((tmp_2_lpi_4_dfm[63]), (~ (modExp_exp_sva_mx0w0[63])),
      fsm_output[1]);
  assign COMP_LOOP_COMP_LOOP_or_110_nl = (COMP_LOOP_mux_46_nl & (~((fsm_output[16])
      | (fsm_output[8]) | (fsm_output[34])))) | (fsm_output[2]);
  assign COMP_LOOP_mux1h_68_nl = MUX1HOT_v_63_6_2((tmp_2_lpi_4_dfm[62:0]), ({54'b000000000000000000000000000000000000000000000000000001
      , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))}), ({51'b000000000000000000000000000000000000000000000000000
      , VEC_LOOP_j_sva_11_0}), ({55'b0000000000000000000000000000000000000000000000000000000
      , COMP_LOOP_k_9_1_sva_7_0}), (~ (modExp_exp_sva_mx0w0[62:0])), (~ operator_64_false_slc_modExp_exp_63_1_itm),
      {or_tmp_41 , (fsm_output[16]) , (fsm_output[8]) , (fsm_output[34]) , (fsm_output[1])
      , (fsm_output[2])});
  assign COMP_LOOP_or_27_nl = (~((fsm_output[8]) | (fsm_output[34]) | (fsm_output[1])
      | (fsm_output[2]))) | or_tmp_41 | (fsm_output[16]);
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_55_nl = ~((modulo_result_mux_1_cse[63])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_56_nl = ~((modulo_result_mux_1_cse[62])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_57_nl = ~((modulo_result_mux_1_cse[61])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_58_nl = ~((modulo_result_mux_1_cse[60])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_59_nl = ~((modulo_result_mux_1_cse[59])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_60_nl = ~((modulo_result_mux_1_cse[58])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_61_nl = ~((modulo_result_mux_1_cse[57])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_62_nl = ~((modulo_result_mux_1_cse[56])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_63_nl = ~((modulo_result_mux_1_cse[55])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_64_nl = ~((modulo_result_mux_1_cse[54])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_65_nl = ~((modulo_result_mux_1_cse[53])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_66_nl = ~((modulo_result_mux_1_cse[52])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_67_nl = ~((modulo_result_mux_1_cse[51])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_68_nl = ~((modulo_result_mux_1_cse[50])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_69_nl = ~((modulo_result_mux_1_cse[49])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_70_nl = ~((modulo_result_mux_1_cse[48])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_71_nl = ~((modulo_result_mux_1_cse[47])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_72_nl = ~((modulo_result_mux_1_cse[46])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_73_nl = ~((modulo_result_mux_1_cse[45])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_74_nl = ~((modulo_result_mux_1_cse[44])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_75_nl = ~((modulo_result_mux_1_cse[43])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_76_nl = ~((modulo_result_mux_1_cse[42])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_77_nl = ~((modulo_result_mux_1_cse[41])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_78_nl = ~((modulo_result_mux_1_cse[40])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_79_nl = ~((modulo_result_mux_1_cse[39])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_80_nl = ~((modulo_result_mux_1_cse[38])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_81_nl = ~((modulo_result_mux_1_cse[37])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_82_nl = ~((modulo_result_mux_1_cse[36])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_83_nl = ~((modulo_result_mux_1_cse[35])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_84_nl = ~((modulo_result_mux_1_cse[34])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_85_nl = ~((modulo_result_mux_1_cse[33])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_86_nl = ~((modulo_result_mux_1_cse[32])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_87_nl = ~((modulo_result_mux_1_cse[31])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_88_nl = ~((modulo_result_mux_1_cse[30])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_89_nl = ~((modulo_result_mux_1_cse[29])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_90_nl = ~((modulo_result_mux_1_cse[28])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_91_nl = ~((modulo_result_mux_1_cse[27])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_92_nl = ~((modulo_result_mux_1_cse[26])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_93_nl = ~((modulo_result_mux_1_cse[25])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_94_nl = ~((modulo_result_mux_1_cse[24])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_95_nl = ~((modulo_result_mux_1_cse[23])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_96_nl = ~((modulo_result_mux_1_cse[22])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_97_nl = ~((modulo_result_mux_1_cse[21])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_98_nl = ~((modulo_result_mux_1_cse[20])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_99_nl = ~((modulo_result_mux_1_cse[19])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_100_nl = ~((modulo_result_mux_1_cse[18])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_101_nl = ~((modulo_result_mux_1_cse[17])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_102_nl = ~((modulo_result_mux_1_cse[16])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_103_nl = ~((modulo_result_mux_1_cse[15])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_104_nl = ~((modulo_result_mux_1_cse[14])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_105_nl = ~((modulo_result_mux_1_cse[13])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_106_nl = ~((modulo_result_mux_1_cse[12])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_107_nl = ~((modulo_result_mux_1_cse[11])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_108_nl = ~((modulo_result_mux_1_cse[10])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_109_nl = ~((modulo_result_mux_1_cse[9])
      | (fsm_output[16]) | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) |
      (fsm_output[2]));
  assign COMP_LOOP_or_28_nl = (fsm_output[16]) | (fsm_output[8]);
  assign COMP_LOOP_COMP_LOOP_mux_3_nl = MUX_v_8_2_2((~ (modulo_result_mux_1_cse[8:1])),
      COMP_LOOP_k_9_1_sva_7_0, COMP_LOOP_or_28_nl);
  assign COMP_LOOP_nor_61_nl = ~((fsm_output[34]) | (fsm_output[1]) | (fsm_output[2]));
  assign COMP_LOOP_and_111_nl = MUX_v_8_2_2(8'b00000000, COMP_LOOP_COMP_LOOP_mux_3_nl,
      COMP_LOOP_nor_61_nl);
  assign COMP_LOOP_COMP_LOOP_or_111_nl = (~ (modulo_result_mux_1_cse[0])) | (fsm_output[16])
      | (fsm_output[8]) | (fsm_output[34]) | (fsm_output[1]) | (fsm_output[2]);
  assign nl_acc_2_nl = ({COMP_LOOP_COMP_LOOP_or_109_nl , COMP_LOOP_COMP_LOOP_or_110_nl
      , COMP_LOOP_mux1h_68_nl , COMP_LOOP_or_27_nl}) + conv_s2u_65_66({COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_55_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_56_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_57_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_58_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_59_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_60_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_61_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_62_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_63_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_64_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_65_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_66_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_67_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_68_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_69_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_70_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_71_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_72_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_73_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_74_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_75_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_76_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_77_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_78_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_79_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_80_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_81_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_82_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_83_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_84_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_85_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_86_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_87_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_88_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_89_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_90_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_91_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_92_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_93_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_94_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_95_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_96_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_97_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_98_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_99_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_100_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_101_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_102_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_103_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_104_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_105_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_106_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_107_nl
      , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_108_nl , COMP_LOOP_COMP_LOOP_COMP_LOOP_nor_109_nl
      , COMP_LOOP_and_111_nl , COMP_LOOP_COMP_LOOP_or_111_nl , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[65:0];
  assign z_out_3 = readslicef_66_65_1(acc_2_nl);
  assign modulo_qelse_mux_2_nl = MUX_v_64_2_2(modulo_result_rem_cmp_z_oreg, p_sva,
      fsm_output[1]);
  assign modulo_qelse_modulo_qelse_or_1_nl = MUX_v_64_2_2(p_sva, 64'b1111111111111111111111111111111111111111111111111111111111111111,
      (fsm_output[1]));
  assign nl_z_out_4 = conv_u2u_64_65(modulo_qelse_mux_2_nl) + conv_s2u_64_65(modulo_qelse_modulo_qelse_or_1_nl);
  assign z_out_4 = nl_z_out_4[64:0];

  function automatic [63:0] div_64_s65_u10;
    input [64:0] in1;
    input [9:0] in2;
    reg [64:0] m;
    reg [9:0] n;
    reg [63:0] result;
  begin
    if (in1[64])
      m = {(65){1'b0}} - in1;
    else
      m = in1;
    result = div_64_u65_u10(m,in2);
    if (in1[64])
      div_64_s65_u10 = {(64){1'b0}} - result;
    else
      div_64_s65_u10 = result;
  end
  endfunction


  function automatic [63:0] div_64_u65_u10;
    input [64:0] l;
    input [9:0] r;
    reg [64:0] rdiv;
    reg [10:0] diff;
    reg [11:0] diff_tmp;
    reg [74:0] lbuf;
    integer i; 
  begin
    lbuf = 75'b0;
    lbuf[64:0] = l;
    for(i=64; i>=0; i=i-1)
    begin
      diff_tmp = (lbuf[74:64] - {1'b0,r});
      diff = diff_tmp[10:0];
      rdiv[i] = ~diff[10];
      if(diff[10] == 0)
        lbuf[74:64] = diff;
      lbuf[74:1] = lbuf[73:0];
    end
    div_64_u65_u10 = rdiv[63:0];
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


  function automatic [10:0] MUX1HOT_v_11_5_2;
    input [10:0] input_4;
    input [10:0] input_3;
    input [10:0] input_2;
    input [10:0] input_1;
    input [10:0] input_0;
    input [4:0] sel;
    reg [10:0] result;
  begin
    result = input_0 & {11{sel[0]}};
    result = result | ( input_1 & {11{sel[1]}});
    result = result | ( input_2 & {11{sel[2]}});
    result = result | ( input_3 & {11{sel[3]}});
    result = result | ( input_4 & {11{sel[4]}});
    MUX1HOT_v_11_5_2 = result;
  end
  endfunction


  function automatic [1:0] MUX1HOT_v_2_4_2;
    input [1:0] input_3;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [3:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | ( input_1 & {2{sel[1]}});
    result = result | ( input_2 & {2{sel[2]}});
    result = result | ( input_3 & {2{sel[3]}});
    MUX1HOT_v_2_4_2 = result;
  end
  endfunction


  function automatic [62:0] MUX1HOT_v_63_6_2;
    input [62:0] input_5;
    input [62:0] input_4;
    input [62:0] input_3;
    input [62:0] input_2;
    input [62:0] input_1;
    input [62:0] input_0;
    input [5:0] sel;
    reg [62:0] result;
  begin
    result = input_0 & {63{sel[0]}};
    result = result | ( input_1 & {63{sel[1]}});
    result = result | ( input_2 & {63{sel[2]}});
    result = result | ( input_3 & {63{sel[3]}});
    result = result | ( input_4 & {63{sel[4]}});
    result = result | ( input_5 & {63{sel[5]}});
    MUX1HOT_v_63_6_2 = result;
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


  function automatic [63:0] MUX1HOT_v_64_4_2;
    input [63:0] input_3;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [3:0] sel;
    reg [63:0] result;
  begin
    result = input_0 & {64{sel[0]}};
    result = result | ( input_1 & {64{sel[1]}});
    result = result | ( input_2 & {64{sel[2]}});
    result = result | ( input_3 & {64{sel[3]}});
    MUX1HOT_v_64_4_2 = result;
  end
  endfunction


  function automatic [63:0] MUX1HOT_v_64_5_2;
    input [63:0] input_4;
    input [63:0] input_3;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [4:0] sel;
    reg [63:0] result;
  begin
    result = input_0 & {64{sel[0]}};
    result = result | ( input_1 & {64{sel[1]}});
    result = result | ( input_2 & {64{sel[2]}});
    result = result | ( input_3 & {64{sel[3]}});
    result = result | ( input_4 & {64{sel[4]}});
    MUX1HOT_v_64_5_2 = result;
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


  function automatic [0:0] readslicef_10_1_9;
    input [9:0] vector;
    reg [9:0] tmp;
  begin
    tmp = vector >> 9;
    readslicef_10_1_9 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_3_1_2;
    input [2:0] vector;
    reg [2:0] tmp;
  begin
    tmp = vector >> 2;
    readslicef_3_1_2 = tmp[0:0];
  end
  endfunction


  function automatic [64:0] readslicef_66_65_1;
    input [65:0] vector;
    reg [65:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_66_65_1 = tmp[64:0];
  end
  endfunction


  function automatic [64:0] conv_s2u_64_65 ;
    input [63:0]  vector ;
  begin
    conv_s2u_64_65 = {vector[63], vector};
  end
  endfunction


  function automatic [65:0] conv_s2u_65_66 ;
    input [64:0]  vector ;
  begin
    conv_s2u_65_66 = {vector[64], vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_8_11 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_11 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
  end
  endfunction


  function automatic [64:0] conv_u2u_64_65 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_65 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT
// ------------------------------------------------------------------


module inPlaceNTT_DIT (
  clk, rst, vec_rsc_0_0_adra, vec_rsc_0_0_da, vec_rsc_0_0_wea, vec_rsc_0_0_qa, vec_rsc_triosy_0_0_lz,
      vec_rsc_0_1_adra, vec_rsc_0_1_da, vec_rsc_0_1_wea, vec_rsc_0_1_qa, vec_rsc_triosy_0_1_lz,
      p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz
);
  input clk;
  input rst;
  output [10:0] vec_rsc_0_0_adra;
  output [63:0] vec_rsc_0_0_da;
  output vec_rsc_0_0_wea;
  input [63:0] vec_rsc_0_0_qa;
  output vec_rsc_triosy_0_0_lz;
  output [10:0] vec_rsc_0_1_adra;
  output [63:0] vec_rsc_0_1_da;
  output vec_rsc_0_1_wea;
  input [63:0] vec_rsc_0_1_qa;
  output vec_rsc_triosy_0_1_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;


  // Interconnect Declarations
  wire [63:0] vec_rsc_0_0_i_qa_d;
  wire vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [63:0] vec_rsc_0_1_i_qa_d;
  wire vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [63:0] modulo_result_rem_cmp_a;
  wire [63:0] modulo_result_rem_cmp_b;
  wire [63:0] modulo_result_rem_cmp_z;
  wire [10:0] vec_rsc_0_0_i_adra_d_iff;
  wire [63:0] vec_rsc_0_0_i_da_d_iff;
  wire vec_rsc_0_0_i_wea_d_iff;
  wire vec_rsc_0_1_i_wea_d_iff;


  // Interconnect Declarations for Component Instantiations 
  mgc_rem #(.width_a(32'sd64),
  .width_b(32'sd64),
  .signd(32'sd1)) modulo_result_rem_cmp (
      .a(modulo_result_rem_cmp_a),
      .b(modulo_result_rem_cmp_b),
      .z(modulo_result_rem_cmp_z)
    );
  inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_4_11_64_2048_2048_64_1_gen
      vec_rsc_0_0_i (
      .qa(vec_rsc_0_0_qa),
      .wea(vec_rsc_0_0_wea),
      .da(vec_rsc_0_0_da),
      .adra(vec_rsc_0_0_adra),
      .adra_d(vec_rsc_0_0_i_adra_d_iff),
      .da_d(vec_rsc_0_0_i_da_d_iff),
      .qa_d(vec_rsc_0_0_i_qa_d),
      .wea_d(vec_rsc_0_0_i_wea_d_iff),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_0_i_wea_d_iff)
    );
  inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_5_11_64_2048_2048_64_1_gen
      vec_rsc_0_1_i (
      .qa(vec_rsc_0_1_qa),
      .wea(vec_rsc_0_1_wea),
      .da(vec_rsc_0_1_da),
      .adra(vec_rsc_0_1_adra),
      .adra_d(vec_rsc_0_0_i_adra_d_iff),
      .da_d(vec_rsc_0_0_i_da_d_iff),
      .qa_d(vec_rsc_0_1_i_qa_d),
      .wea_d(vec_rsc_0_1_i_wea_d_iff),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsc_0_1_i_wea_d_iff)
    );
  inPlaceNTT_DIT_core inPlaceNTT_DIT_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_0_0_lz(vec_rsc_triosy_0_0_lz),
      .vec_rsc_triosy_0_1_lz(vec_rsc_triosy_0_1_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_dat(r_rsc_dat),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .vec_rsc_0_0_i_qa_d(vec_rsc_0_0_i_qa_d),
      .vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .vec_rsc_0_1_i_qa_d(vec_rsc_0_1_i_qa_d),
      .vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d),
      .modulo_result_rem_cmp_a(modulo_result_rem_cmp_a),
      .modulo_result_rem_cmp_b(modulo_result_rem_cmp_b),
      .modulo_result_rem_cmp_z(modulo_result_rem_cmp_z),
      .vec_rsc_0_0_i_adra_d_pff(vec_rsc_0_0_i_adra_d_iff),
      .vec_rsc_0_0_i_da_d_pff(vec_rsc_0_0_i_da_d_iff),
      .vec_rsc_0_0_i_wea_d_pff(vec_rsc_0_0_i_wea_d_iff),
      .vec_rsc_0_1_i_wea_d_pff(vec_rsc_0_1_i_wea_d_iff)
    );
endmodule



