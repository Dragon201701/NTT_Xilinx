
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

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/hls_pkgs/mgc_comps_src/mgc_div_beh.v 
module mgc_div(a,b,z);
   parameter width_a = 8;
   parameter width_b = 8;
   parameter signd = 1;
   input [width_a-1:0] a;
   input [width_b-1:0] b; 
   output [width_a-1:0] z;  
   reg  [width_a-1:0] z;

   always@(a or b)
     begin
	if(signd)
	  div_s(a,b,z);
	else
          div_u(a,b,z);
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
//  Generated date: Mon May 17 21:42:58 2021
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
  clk, rst, fsm_output, STAGE_LOOP_C_5_tr0, modExp_while_C_24_tr0, VEC_LOOP_1_COMP_LOOP_C_1_tr0,
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0, VEC_LOOP_1_COMP_LOOP_C_40_tr0,
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0, VEC_LOOP_1_COMP_LOOP_C_80_tr0,
      VEC_LOOP_C_0_tr0, VEC_LOOP_2_COMP_LOOP_C_1_tr0, VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0,
      VEC_LOOP_2_COMP_LOOP_C_40_tr0, VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0,
      VEC_LOOP_2_COMP_LOOP_C_80_tr0, VEC_LOOP_C_1_tr0, STAGE_LOOP_C_6_tr0
);
  input clk;
  input rst;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
  input STAGE_LOOP_C_5_tr0;
  input modExp_while_C_24_tr0;
  input VEC_LOOP_1_COMP_LOOP_C_1_tr0;
  input VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0;
  input VEC_LOOP_1_COMP_LOOP_C_40_tr0;
  input VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0;
  input VEC_LOOP_1_COMP_LOOP_C_80_tr0;
  input VEC_LOOP_C_0_tr0;
  input VEC_LOOP_2_COMP_LOOP_C_1_tr0;
  input VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0;
  input VEC_LOOP_2_COMP_LOOP_C_40_tr0;
  input VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0;
  input VEC_LOOP_2_COMP_LOOP_C_80_tr0;
  input VEC_LOOP_C_1_tr0;
  input STAGE_LOOP_C_6_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_core_core_fsm_1
  parameter
    main_C_0 = 9'd0,
    STAGE_LOOP_C_0 = 9'd1,
    STAGE_LOOP_C_1 = 9'd2,
    STAGE_LOOP_C_2 = 9'd3,
    STAGE_LOOP_C_3 = 9'd4,
    STAGE_LOOP_C_4 = 9'd5,
    STAGE_LOOP_C_5 = 9'd6,
    modExp_while_C_0 = 9'd7,
    modExp_while_C_1 = 9'd8,
    modExp_while_C_2 = 9'd9,
    modExp_while_C_3 = 9'd10,
    modExp_while_C_4 = 9'd11,
    modExp_while_C_5 = 9'd12,
    modExp_while_C_6 = 9'd13,
    modExp_while_C_7 = 9'd14,
    modExp_while_C_8 = 9'd15,
    modExp_while_C_9 = 9'd16,
    modExp_while_C_10 = 9'd17,
    modExp_while_C_11 = 9'd18,
    modExp_while_C_12 = 9'd19,
    modExp_while_C_13 = 9'd20,
    modExp_while_C_14 = 9'd21,
    modExp_while_C_15 = 9'd22,
    modExp_while_C_16 = 9'd23,
    modExp_while_C_17 = 9'd24,
    modExp_while_C_18 = 9'd25,
    modExp_while_C_19 = 9'd26,
    modExp_while_C_20 = 9'd27,
    modExp_while_C_21 = 9'd28,
    modExp_while_C_22 = 9'd29,
    modExp_while_C_23 = 9'd30,
    modExp_while_C_24 = 9'd31,
    VEC_LOOP_1_COMP_LOOP_C_0 = 9'd32,
    VEC_LOOP_1_COMP_LOOP_C_1 = 9'd33,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0 = 9'd34,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_1 = 9'd35,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_2 = 9'd36,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_3 = 9'd37,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_4 = 9'd38,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_5 = 9'd39,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_6 = 9'd40,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_7 = 9'd41,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_8 = 9'd42,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_9 = 9'd43,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_10 = 9'd44,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_11 = 9'd45,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_12 = 9'd46,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_13 = 9'd47,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_14 = 9'd48,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_15 = 9'd49,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_16 = 9'd50,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_17 = 9'd51,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_18 = 9'd52,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_19 = 9'd53,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_20 = 9'd54,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_21 = 9'd55,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_22 = 9'd56,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_23 = 9'd57,
    VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24 = 9'd58,
    VEC_LOOP_1_COMP_LOOP_C_2 = 9'd59,
    VEC_LOOP_1_COMP_LOOP_C_3 = 9'd60,
    VEC_LOOP_1_COMP_LOOP_C_4 = 9'd61,
    VEC_LOOP_1_COMP_LOOP_C_5 = 9'd62,
    VEC_LOOP_1_COMP_LOOP_C_6 = 9'd63,
    VEC_LOOP_1_COMP_LOOP_C_7 = 9'd64,
    VEC_LOOP_1_COMP_LOOP_C_8 = 9'd65,
    VEC_LOOP_1_COMP_LOOP_C_9 = 9'd66,
    VEC_LOOP_1_COMP_LOOP_C_10 = 9'd67,
    VEC_LOOP_1_COMP_LOOP_C_11 = 9'd68,
    VEC_LOOP_1_COMP_LOOP_C_12 = 9'd69,
    VEC_LOOP_1_COMP_LOOP_C_13 = 9'd70,
    VEC_LOOP_1_COMP_LOOP_C_14 = 9'd71,
    VEC_LOOP_1_COMP_LOOP_C_15 = 9'd72,
    VEC_LOOP_1_COMP_LOOP_C_16 = 9'd73,
    VEC_LOOP_1_COMP_LOOP_C_17 = 9'd74,
    VEC_LOOP_1_COMP_LOOP_C_18 = 9'd75,
    VEC_LOOP_1_COMP_LOOP_C_19 = 9'd76,
    VEC_LOOP_1_COMP_LOOP_C_20 = 9'd77,
    VEC_LOOP_1_COMP_LOOP_C_21 = 9'd78,
    VEC_LOOP_1_COMP_LOOP_C_22 = 9'd79,
    VEC_LOOP_1_COMP_LOOP_C_23 = 9'd80,
    VEC_LOOP_1_COMP_LOOP_C_24 = 9'd81,
    VEC_LOOP_1_COMP_LOOP_C_25 = 9'd82,
    VEC_LOOP_1_COMP_LOOP_C_26 = 9'd83,
    VEC_LOOP_1_COMP_LOOP_C_27 = 9'd84,
    VEC_LOOP_1_COMP_LOOP_C_28 = 9'd85,
    VEC_LOOP_1_COMP_LOOP_C_29 = 9'd86,
    VEC_LOOP_1_COMP_LOOP_C_30 = 9'd87,
    VEC_LOOP_1_COMP_LOOP_C_31 = 9'd88,
    VEC_LOOP_1_COMP_LOOP_C_32 = 9'd89,
    VEC_LOOP_1_COMP_LOOP_C_33 = 9'd90,
    VEC_LOOP_1_COMP_LOOP_C_34 = 9'd91,
    VEC_LOOP_1_COMP_LOOP_C_35 = 9'd92,
    VEC_LOOP_1_COMP_LOOP_C_36 = 9'd93,
    VEC_LOOP_1_COMP_LOOP_C_37 = 9'd94,
    VEC_LOOP_1_COMP_LOOP_C_38 = 9'd95,
    VEC_LOOP_1_COMP_LOOP_C_39 = 9'd96,
    VEC_LOOP_1_COMP_LOOP_C_40 = 9'd97,
    VEC_LOOP_1_COMP_LOOP_C_41 = 9'd98,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0 = 9'd99,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_1 = 9'd100,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_2 = 9'd101,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_3 = 9'd102,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_4 = 9'd103,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_5 = 9'd104,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_6 = 9'd105,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_7 = 9'd106,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_8 = 9'd107,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_9 = 9'd108,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_10 = 9'd109,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_11 = 9'd110,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_12 = 9'd111,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_13 = 9'd112,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_14 = 9'd113,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_15 = 9'd114,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_16 = 9'd115,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_17 = 9'd116,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_18 = 9'd117,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_19 = 9'd118,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_20 = 9'd119,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_21 = 9'd120,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_22 = 9'd121,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_23 = 9'd122,
    VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24 = 9'd123,
    VEC_LOOP_1_COMP_LOOP_C_42 = 9'd124,
    VEC_LOOP_1_COMP_LOOP_C_43 = 9'd125,
    VEC_LOOP_1_COMP_LOOP_C_44 = 9'd126,
    VEC_LOOP_1_COMP_LOOP_C_45 = 9'd127,
    VEC_LOOP_1_COMP_LOOP_C_46 = 9'd128,
    VEC_LOOP_1_COMP_LOOP_C_47 = 9'd129,
    VEC_LOOP_1_COMP_LOOP_C_48 = 9'd130,
    VEC_LOOP_1_COMP_LOOP_C_49 = 9'd131,
    VEC_LOOP_1_COMP_LOOP_C_50 = 9'd132,
    VEC_LOOP_1_COMP_LOOP_C_51 = 9'd133,
    VEC_LOOP_1_COMP_LOOP_C_52 = 9'd134,
    VEC_LOOP_1_COMP_LOOP_C_53 = 9'd135,
    VEC_LOOP_1_COMP_LOOP_C_54 = 9'd136,
    VEC_LOOP_1_COMP_LOOP_C_55 = 9'd137,
    VEC_LOOP_1_COMP_LOOP_C_56 = 9'd138,
    VEC_LOOP_1_COMP_LOOP_C_57 = 9'd139,
    VEC_LOOP_1_COMP_LOOP_C_58 = 9'd140,
    VEC_LOOP_1_COMP_LOOP_C_59 = 9'd141,
    VEC_LOOP_1_COMP_LOOP_C_60 = 9'd142,
    VEC_LOOP_1_COMP_LOOP_C_61 = 9'd143,
    VEC_LOOP_1_COMP_LOOP_C_62 = 9'd144,
    VEC_LOOP_1_COMP_LOOP_C_63 = 9'd145,
    VEC_LOOP_1_COMP_LOOP_C_64 = 9'd146,
    VEC_LOOP_1_COMP_LOOP_C_65 = 9'd147,
    VEC_LOOP_1_COMP_LOOP_C_66 = 9'd148,
    VEC_LOOP_1_COMP_LOOP_C_67 = 9'd149,
    VEC_LOOP_1_COMP_LOOP_C_68 = 9'd150,
    VEC_LOOP_1_COMP_LOOP_C_69 = 9'd151,
    VEC_LOOP_1_COMP_LOOP_C_70 = 9'd152,
    VEC_LOOP_1_COMP_LOOP_C_71 = 9'd153,
    VEC_LOOP_1_COMP_LOOP_C_72 = 9'd154,
    VEC_LOOP_1_COMP_LOOP_C_73 = 9'd155,
    VEC_LOOP_1_COMP_LOOP_C_74 = 9'd156,
    VEC_LOOP_1_COMP_LOOP_C_75 = 9'd157,
    VEC_LOOP_1_COMP_LOOP_C_76 = 9'd158,
    VEC_LOOP_1_COMP_LOOP_C_77 = 9'd159,
    VEC_LOOP_1_COMP_LOOP_C_78 = 9'd160,
    VEC_LOOP_1_COMP_LOOP_C_79 = 9'd161,
    VEC_LOOP_1_COMP_LOOP_C_80 = 9'd162,
    VEC_LOOP_C_0 = 9'd163,
    VEC_LOOP_2_COMP_LOOP_C_0 = 9'd164,
    VEC_LOOP_2_COMP_LOOP_C_1 = 9'd165,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0 = 9'd166,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_1 = 9'd167,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_2 = 9'd168,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_3 = 9'd169,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_4 = 9'd170,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_5 = 9'd171,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_6 = 9'd172,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_7 = 9'd173,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_8 = 9'd174,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_9 = 9'd175,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_10 = 9'd176,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_11 = 9'd177,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_12 = 9'd178,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_13 = 9'd179,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_14 = 9'd180,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_15 = 9'd181,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_16 = 9'd182,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_17 = 9'd183,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_18 = 9'd184,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_19 = 9'd185,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_20 = 9'd186,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_21 = 9'd187,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_22 = 9'd188,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_23 = 9'd189,
    VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24 = 9'd190,
    VEC_LOOP_2_COMP_LOOP_C_2 = 9'd191,
    VEC_LOOP_2_COMP_LOOP_C_3 = 9'd192,
    VEC_LOOP_2_COMP_LOOP_C_4 = 9'd193,
    VEC_LOOP_2_COMP_LOOP_C_5 = 9'd194,
    VEC_LOOP_2_COMP_LOOP_C_6 = 9'd195,
    VEC_LOOP_2_COMP_LOOP_C_7 = 9'd196,
    VEC_LOOP_2_COMP_LOOP_C_8 = 9'd197,
    VEC_LOOP_2_COMP_LOOP_C_9 = 9'd198,
    VEC_LOOP_2_COMP_LOOP_C_10 = 9'd199,
    VEC_LOOP_2_COMP_LOOP_C_11 = 9'd200,
    VEC_LOOP_2_COMP_LOOP_C_12 = 9'd201,
    VEC_LOOP_2_COMP_LOOP_C_13 = 9'd202,
    VEC_LOOP_2_COMP_LOOP_C_14 = 9'd203,
    VEC_LOOP_2_COMP_LOOP_C_15 = 9'd204,
    VEC_LOOP_2_COMP_LOOP_C_16 = 9'd205,
    VEC_LOOP_2_COMP_LOOP_C_17 = 9'd206,
    VEC_LOOP_2_COMP_LOOP_C_18 = 9'd207,
    VEC_LOOP_2_COMP_LOOP_C_19 = 9'd208,
    VEC_LOOP_2_COMP_LOOP_C_20 = 9'd209,
    VEC_LOOP_2_COMP_LOOP_C_21 = 9'd210,
    VEC_LOOP_2_COMP_LOOP_C_22 = 9'd211,
    VEC_LOOP_2_COMP_LOOP_C_23 = 9'd212,
    VEC_LOOP_2_COMP_LOOP_C_24 = 9'd213,
    VEC_LOOP_2_COMP_LOOP_C_25 = 9'd214,
    VEC_LOOP_2_COMP_LOOP_C_26 = 9'd215,
    VEC_LOOP_2_COMP_LOOP_C_27 = 9'd216,
    VEC_LOOP_2_COMP_LOOP_C_28 = 9'd217,
    VEC_LOOP_2_COMP_LOOP_C_29 = 9'd218,
    VEC_LOOP_2_COMP_LOOP_C_30 = 9'd219,
    VEC_LOOP_2_COMP_LOOP_C_31 = 9'd220,
    VEC_LOOP_2_COMP_LOOP_C_32 = 9'd221,
    VEC_LOOP_2_COMP_LOOP_C_33 = 9'd222,
    VEC_LOOP_2_COMP_LOOP_C_34 = 9'd223,
    VEC_LOOP_2_COMP_LOOP_C_35 = 9'd224,
    VEC_LOOP_2_COMP_LOOP_C_36 = 9'd225,
    VEC_LOOP_2_COMP_LOOP_C_37 = 9'd226,
    VEC_LOOP_2_COMP_LOOP_C_38 = 9'd227,
    VEC_LOOP_2_COMP_LOOP_C_39 = 9'd228,
    VEC_LOOP_2_COMP_LOOP_C_40 = 9'd229,
    VEC_LOOP_2_COMP_LOOP_C_41 = 9'd230,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0 = 9'd231,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_1 = 9'd232,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_2 = 9'd233,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_3 = 9'd234,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_4 = 9'd235,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_5 = 9'd236,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_6 = 9'd237,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_7 = 9'd238,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_8 = 9'd239,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_9 = 9'd240,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_10 = 9'd241,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_11 = 9'd242,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_12 = 9'd243,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_13 = 9'd244,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_14 = 9'd245,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_15 = 9'd246,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_16 = 9'd247,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_17 = 9'd248,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_18 = 9'd249,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_19 = 9'd250,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_20 = 9'd251,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_21 = 9'd252,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_22 = 9'd253,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_23 = 9'd254,
    VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24 = 9'd255,
    VEC_LOOP_2_COMP_LOOP_C_42 = 9'd256,
    VEC_LOOP_2_COMP_LOOP_C_43 = 9'd257,
    VEC_LOOP_2_COMP_LOOP_C_44 = 9'd258,
    VEC_LOOP_2_COMP_LOOP_C_45 = 9'd259,
    VEC_LOOP_2_COMP_LOOP_C_46 = 9'd260,
    VEC_LOOP_2_COMP_LOOP_C_47 = 9'd261,
    VEC_LOOP_2_COMP_LOOP_C_48 = 9'd262,
    VEC_LOOP_2_COMP_LOOP_C_49 = 9'd263,
    VEC_LOOP_2_COMP_LOOP_C_50 = 9'd264,
    VEC_LOOP_2_COMP_LOOP_C_51 = 9'd265,
    VEC_LOOP_2_COMP_LOOP_C_52 = 9'd266,
    VEC_LOOP_2_COMP_LOOP_C_53 = 9'd267,
    VEC_LOOP_2_COMP_LOOP_C_54 = 9'd268,
    VEC_LOOP_2_COMP_LOOP_C_55 = 9'd269,
    VEC_LOOP_2_COMP_LOOP_C_56 = 9'd270,
    VEC_LOOP_2_COMP_LOOP_C_57 = 9'd271,
    VEC_LOOP_2_COMP_LOOP_C_58 = 9'd272,
    VEC_LOOP_2_COMP_LOOP_C_59 = 9'd273,
    VEC_LOOP_2_COMP_LOOP_C_60 = 9'd274,
    VEC_LOOP_2_COMP_LOOP_C_61 = 9'd275,
    VEC_LOOP_2_COMP_LOOP_C_62 = 9'd276,
    VEC_LOOP_2_COMP_LOOP_C_63 = 9'd277,
    VEC_LOOP_2_COMP_LOOP_C_64 = 9'd278,
    VEC_LOOP_2_COMP_LOOP_C_65 = 9'd279,
    VEC_LOOP_2_COMP_LOOP_C_66 = 9'd280,
    VEC_LOOP_2_COMP_LOOP_C_67 = 9'd281,
    VEC_LOOP_2_COMP_LOOP_C_68 = 9'd282,
    VEC_LOOP_2_COMP_LOOP_C_69 = 9'd283,
    VEC_LOOP_2_COMP_LOOP_C_70 = 9'd284,
    VEC_LOOP_2_COMP_LOOP_C_71 = 9'd285,
    VEC_LOOP_2_COMP_LOOP_C_72 = 9'd286,
    VEC_LOOP_2_COMP_LOOP_C_73 = 9'd287,
    VEC_LOOP_2_COMP_LOOP_C_74 = 9'd288,
    VEC_LOOP_2_COMP_LOOP_C_75 = 9'd289,
    VEC_LOOP_2_COMP_LOOP_C_76 = 9'd290,
    VEC_LOOP_2_COMP_LOOP_C_77 = 9'd291,
    VEC_LOOP_2_COMP_LOOP_C_78 = 9'd292,
    VEC_LOOP_2_COMP_LOOP_C_79 = 9'd293,
    VEC_LOOP_2_COMP_LOOP_C_80 = 9'd294,
    VEC_LOOP_C_1 = 9'd295,
    STAGE_LOOP_C_6 = 9'd296,
    main_C_1 = 9'd297;

  reg [8:0] state_var;
  reg [8:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIT_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 9'b000000001;
        state_var_NS = STAGE_LOOP_C_1;
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 9'b000000010;
        state_var_NS = STAGE_LOOP_C_2;
      end
      STAGE_LOOP_C_2 : begin
        fsm_output = 9'b000000011;
        state_var_NS = STAGE_LOOP_C_3;
      end
      STAGE_LOOP_C_3 : begin
        fsm_output = 9'b000000100;
        state_var_NS = STAGE_LOOP_C_4;
      end
      STAGE_LOOP_C_4 : begin
        fsm_output = 9'b000000101;
        state_var_NS = STAGE_LOOP_C_5;
      end
      STAGE_LOOP_C_5 : begin
        fsm_output = 9'b000000110;
        if ( STAGE_LOOP_C_5_tr0 ) begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      modExp_while_C_0 : begin
        fsm_output = 9'b000000111;
        state_var_NS = modExp_while_C_1;
      end
      modExp_while_C_1 : begin
        fsm_output = 9'b000001000;
        state_var_NS = modExp_while_C_2;
      end
      modExp_while_C_2 : begin
        fsm_output = 9'b000001001;
        state_var_NS = modExp_while_C_3;
      end
      modExp_while_C_3 : begin
        fsm_output = 9'b000001010;
        state_var_NS = modExp_while_C_4;
      end
      modExp_while_C_4 : begin
        fsm_output = 9'b000001011;
        state_var_NS = modExp_while_C_5;
      end
      modExp_while_C_5 : begin
        fsm_output = 9'b000001100;
        state_var_NS = modExp_while_C_6;
      end
      modExp_while_C_6 : begin
        fsm_output = 9'b000001101;
        state_var_NS = modExp_while_C_7;
      end
      modExp_while_C_7 : begin
        fsm_output = 9'b000001110;
        state_var_NS = modExp_while_C_8;
      end
      modExp_while_C_8 : begin
        fsm_output = 9'b000001111;
        state_var_NS = modExp_while_C_9;
      end
      modExp_while_C_9 : begin
        fsm_output = 9'b000010000;
        state_var_NS = modExp_while_C_10;
      end
      modExp_while_C_10 : begin
        fsm_output = 9'b000010001;
        state_var_NS = modExp_while_C_11;
      end
      modExp_while_C_11 : begin
        fsm_output = 9'b000010010;
        state_var_NS = modExp_while_C_12;
      end
      modExp_while_C_12 : begin
        fsm_output = 9'b000010011;
        state_var_NS = modExp_while_C_13;
      end
      modExp_while_C_13 : begin
        fsm_output = 9'b000010100;
        state_var_NS = modExp_while_C_14;
      end
      modExp_while_C_14 : begin
        fsm_output = 9'b000010101;
        state_var_NS = modExp_while_C_15;
      end
      modExp_while_C_15 : begin
        fsm_output = 9'b000010110;
        state_var_NS = modExp_while_C_16;
      end
      modExp_while_C_16 : begin
        fsm_output = 9'b000010111;
        state_var_NS = modExp_while_C_17;
      end
      modExp_while_C_17 : begin
        fsm_output = 9'b000011000;
        state_var_NS = modExp_while_C_18;
      end
      modExp_while_C_18 : begin
        fsm_output = 9'b000011001;
        state_var_NS = modExp_while_C_19;
      end
      modExp_while_C_19 : begin
        fsm_output = 9'b000011010;
        state_var_NS = modExp_while_C_20;
      end
      modExp_while_C_20 : begin
        fsm_output = 9'b000011011;
        state_var_NS = modExp_while_C_21;
      end
      modExp_while_C_21 : begin
        fsm_output = 9'b000011100;
        state_var_NS = modExp_while_C_22;
      end
      modExp_while_C_22 : begin
        fsm_output = 9'b000011101;
        state_var_NS = modExp_while_C_23;
      end
      modExp_while_C_23 : begin
        fsm_output = 9'b000011110;
        state_var_NS = modExp_while_C_24;
      end
      modExp_while_C_24 : begin
        fsm_output = 9'b000011111;
        if ( modExp_while_C_24_tr0 ) begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      VEC_LOOP_1_COMP_LOOP_C_0 : begin
        fsm_output = 9'b000100000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_1;
      end
      VEC_LOOP_1_COMP_LOOP_C_1 : begin
        fsm_output = 9'b000100001;
        if ( VEC_LOOP_1_COMP_LOOP_C_1_tr0 ) begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0 : begin
        fsm_output = 9'b000100010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_1;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_1 : begin
        fsm_output = 9'b000100011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_2;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_2 : begin
        fsm_output = 9'b000100100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_3;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_3 : begin
        fsm_output = 9'b000100101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_4;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_4 : begin
        fsm_output = 9'b000100110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_5;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_5 : begin
        fsm_output = 9'b000100111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_6;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_6 : begin
        fsm_output = 9'b000101000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_7;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_7 : begin
        fsm_output = 9'b000101001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_8;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_8 : begin
        fsm_output = 9'b000101010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_9;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_9 : begin
        fsm_output = 9'b000101011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_10;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_10 : begin
        fsm_output = 9'b000101100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_11;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_11 : begin
        fsm_output = 9'b000101101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_12;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_12 : begin
        fsm_output = 9'b000101110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_13;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_13 : begin
        fsm_output = 9'b000101111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_14;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_14 : begin
        fsm_output = 9'b000110000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_15;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_15 : begin
        fsm_output = 9'b000110001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_16;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_16 : begin
        fsm_output = 9'b000110010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_17;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_17 : begin
        fsm_output = 9'b000110011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_18;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_18 : begin
        fsm_output = 9'b000110100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_19;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_19 : begin
        fsm_output = 9'b000110101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_20;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_20 : begin
        fsm_output = 9'b000110110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_21;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_21 : begin
        fsm_output = 9'b000110111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_22;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_22 : begin
        fsm_output = 9'b000111000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_23;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_23 : begin
        fsm_output = 9'b000111001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24;
      end
      VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24 : begin
        fsm_output = 9'b000111010;
        if ( VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0 ) begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      VEC_LOOP_1_COMP_LOOP_C_2 : begin
        fsm_output = 9'b000111011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_3;
      end
      VEC_LOOP_1_COMP_LOOP_C_3 : begin
        fsm_output = 9'b000111100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_4;
      end
      VEC_LOOP_1_COMP_LOOP_C_4 : begin
        fsm_output = 9'b000111101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_5;
      end
      VEC_LOOP_1_COMP_LOOP_C_5 : begin
        fsm_output = 9'b000111110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_6;
      end
      VEC_LOOP_1_COMP_LOOP_C_6 : begin
        fsm_output = 9'b000111111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_7;
      end
      VEC_LOOP_1_COMP_LOOP_C_7 : begin
        fsm_output = 9'b001000000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_8;
      end
      VEC_LOOP_1_COMP_LOOP_C_8 : begin
        fsm_output = 9'b001000001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_9;
      end
      VEC_LOOP_1_COMP_LOOP_C_9 : begin
        fsm_output = 9'b001000010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_10;
      end
      VEC_LOOP_1_COMP_LOOP_C_10 : begin
        fsm_output = 9'b001000011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_11;
      end
      VEC_LOOP_1_COMP_LOOP_C_11 : begin
        fsm_output = 9'b001000100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_12;
      end
      VEC_LOOP_1_COMP_LOOP_C_12 : begin
        fsm_output = 9'b001000101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_13;
      end
      VEC_LOOP_1_COMP_LOOP_C_13 : begin
        fsm_output = 9'b001000110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_14;
      end
      VEC_LOOP_1_COMP_LOOP_C_14 : begin
        fsm_output = 9'b001000111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_15;
      end
      VEC_LOOP_1_COMP_LOOP_C_15 : begin
        fsm_output = 9'b001001000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_16;
      end
      VEC_LOOP_1_COMP_LOOP_C_16 : begin
        fsm_output = 9'b001001001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_17;
      end
      VEC_LOOP_1_COMP_LOOP_C_17 : begin
        fsm_output = 9'b001001010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_18;
      end
      VEC_LOOP_1_COMP_LOOP_C_18 : begin
        fsm_output = 9'b001001011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_19;
      end
      VEC_LOOP_1_COMP_LOOP_C_19 : begin
        fsm_output = 9'b001001100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_20;
      end
      VEC_LOOP_1_COMP_LOOP_C_20 : begin
        fsm_output = 9'b001001101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_21;
      end
      VEC_LOOP_1_COMP_LOOP_C_21 : begin
        fsm_output = 9'b001001110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_22;
      end
      VEC_LOOP_1_COMP_LOOP_C_22 : begin
        fsm_output = 9'b001001111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_23;
      end
      VEC_LOOP_1_COMP_LOOP_C_23 : begin
        fsm_output = 9'b001010000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_24;
      end
      VEC_LOOP_1_COMP_LOOP_C_24 : begin
        fsm_output = 9'b001010001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_25;
      end
      VEC_LOOP_1_COMP_LOOP_C_25 : begin
        fsm_output = 9'b001010010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_26;
      end
      VEC_LOOP_1_COMP_LOOP_C_26 : begin
        fsm_output = 9'b001010011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_27;
      end
      VEC_LOOP_1_COMP_LOOP_C_27 : begin
        fsm_output = 9'b001010100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_28;
      end
      VEC_LOOP_1_COMP_LOOP_C_28 : begin
        fsm_output = 9'b001010101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_29;
      end
      VEC_LOOP_1_COMP_LOOP_C_29 : begin
        fsm_output = 9'b001010110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_30;
      end
      VEC_LOOP_1_COMP_LOOP_C_30 : begin
        fsm_output = 9'b001010111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_31;
      end
      VEC_LOOP_1_COMP_LOOP_C_31 : begin
        fsm_output = 9'b001011000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_32;
      end
      VEC_LOOP_1_COMP_LOOP_C_32 : begin
        fsm_output = 9'b001011001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_33;
      end
      VEC_LOOP_1_COMP_LOOP_C_33 : begin
        fsm_output = 9'b001011010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_34;
      end
      VEC_LOOP_1_COMP_LOOP_C_34 : begin
        fsm_output = 9'b001011011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_35;
      end
      VEC_LOOP_1_COMP_LOOP_C_35 : begin
        fsm_output = 9'b001011100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_36;
      end
      VEC_LOOP_1_COMP_LOOP_C_36 : begin
        fsm_output = 9'b001011101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_37;
      end
      VEC_LOOP_1_COMP_LOOP_C_37 : begin
        fsm_output = 9'b001011110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_38;
      end
      VEC_LOOP_1_COMP_LOOP_C_38 : begin
        fsm_output = 9'b001011111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_39;
      end
      VEC_LOOP_1_COMP_LOOP_C_39 : begin
        fsm_output = 9'b001100000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_40;
      end
      VEC_LOOP_1_COMP_LOOP_C_40 : begin
        fsm_output = 9'b001100001;
        if ( VEC_LOOP_1_COMP_LOOP_C_40_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_41;
        end
      end
      VEC_LOOP_1_COMP_LOOP_C_41 : begin
        fsm_output = 9'b001100010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0 : begin
        fsm_output = 9'b001100011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_1;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_1 : begin
        fsm_output = 9'b001100100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_2;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_2 : begin
        fsm_output = 9'b001100101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_3;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_3 : begin
        fsm_output = 9'b001100110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_4;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_4 : begin
        fsm_output = 9'b001100111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_5;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_5 : begin
        fsm_output = 9'b001101000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_6;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_6 : begin
        fsm_output = 9'b001101001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_7;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_7 : begin
        fsm_output = 9'b001101010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_8;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_8 : begin
        fsm_output = 9'b001101011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_9;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_9 : begin
        fsm_output = 9'b001101100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_10;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_10 : begin
        fsm_output = 9'b001101101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_11;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_11 : begin
        fsm_output = 9'b001101110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_12;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_12 : begin
        fsm_output = 9'b001101111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_13;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_13 : begin
        fsm_output = 9'b001110000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_14;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_14 : begin
        fsm_output = 9'b001110001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_15;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_15 : begin
        fsm_output = 9'b001110010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_16;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_16 : begin
        fsm_output = 9'b001110011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_17;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_17 : begin
        fsm_output = 9'b001110100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_18;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_18 : begin
        fsm_output = 9'b001110101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_19;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_19 : begin
        fsm_output = 9'b001110110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_20;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_20 : begin
        fsm_output = 9'b001110111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_21;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_21 : begin
        fsm_output = 9'b001111000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_22;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_22 : begin
        fsm_output = 9'b001111001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_23;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_23 : begin
        fsm_output = 9'b001111010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24;
      end
      VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24 : begin
        fsm_output = 9'b001111011;
        if ( VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0 ) begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_42;
        end
        else begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_0;
        end
      end
      VEC_LOOP_1_COMP_LOOP_C_42 : begin
        fsm_output = 9'b001111100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_43;
      end
      VEC_LOOP_1_COMP_LOOP_C_43 : begin
        fsm_output = 9'b001111101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_44;
      end
      VEC_LOOP_1_COMP_LOOP_C_44 : begin
        fsm_output = 9'b001111110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_45;
      end
      VEC_LOOP_1_COMP_LOOP_C_45 : begin
        fsm_output = 9'b001111111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_46;
      end
      VEC_LOOP_1_COMP_LOOP_C_46 : begin
        fsm_output = 9'b010000000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_47;
      end
      VEC_LOOP_1_COMP_LOOP_C_47 : begin
        fsm_output = 9'b010000001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_48;
      end
      VEC_LOOP_1_COMP_LOOP_C_48 : begin
        fsm_output = 9'b010000010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_49;
      end
      VEC_LOOP_1_COMP_LOOP_C_49 : begin
        fsm_output = 9'b010000011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_50;
      end
      VEC_LOOP_1_COMP_LOOP_C_50 : begin
        fsm_output = 9'b010000100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_51;
      end
      VEC_LOOP_1_COMP_LOOP_C_51 : begin
        fsm_output = 9'b010000101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_52;
      end
      VEC_LOOP_1_COMP_LOOP_C_52 : begin
        fsm_output = 9'b010000110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_53;
      end
      VEC_LOOP_1_COMP_LOOP_C_53 : begin
        fsm_output = 9'b010000111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_54;
      end
      VEC_LOOP_1_COMP_LOOP_C_54 : begin
        fsm_output = 9'b010001000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_55;
      end
      VEC_LOOP_1_COMP_LOOP_C_55 : begin
        fsm_output = 9'b010001001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_56;
      end
      VEC_LOOP_1_COMP_LOOP_C_56 : begin
        fsm_output = 9'b010001010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_57;
      end
      VEC_LOOP_1_COMP_LOOP_C_57 : begin
        fsm_output = 9'b010001011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_58;
      end
      VEC_LOOP_1_COMP_LOOP_C_58 : begin
        fsm_output = 9'b010001100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_59;
      end
      VEC_LOOP_1_COMP_LOOP_C_59 : begin
        fsm_output = 9'b010001101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_60;
      end
      VEC_LOOP_1_COMP_LOOP_C_60 : begin
        fsm_output = 9'b010001110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_61;
      end
      VEC_LOOP_1_COMP_LOOP_C_61 : begin
        fsm_output = 9'b010001111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_62;
      end
      VEC_LOOP_1_COMP_LOOP_C_62 : begin
        fsm_output = 9'b010010000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_63;
      end
      VEC_LOOP_1_COMP_LOOP_C_63 : begin
        fsm_output = 9'b010010001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_64;
      end
      VEC_LOOP_1_COMP_LOOP_C_64 : begin
        fsm_output = 9'b010010010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_65;
      end
      VEC_LOOP_1_COMP_LOOP_C_65 : begin
        fsm_output = 9'b010010011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_66;
      end
      VEC_LOOP_1_COMP_LOOP_C_66 : begin
        fsm_output = 9'b010010100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_67;
      end
      VEC_LOOP_1_COMP_LOOP_C_67 : begin
        fsm_output = 9'b010010101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_68;
      end
      VEC_LOOP_1_COMP_LOOP_C_68 : begin
        fsm_output = 9'b010010110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_69;
      end
      VEC_LOOP_1_COMP_LOOP_C_69 : begin
        fsm_output = 9'b010010111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_70;
      end
      VEC_LOOP_1_COMP_LOOP_C_70 : begin
        fsm_output = 9'b010011000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_71;
      end
      VEC_LOOP_1_COMP_LOOP_C_71 : begin
        fsm_output = 9'b010011001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_72;
      end
      VEC_LOOP_1_COMP_LOOP_C_72 : begin
        fsm_output = 9'b010011010;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_73;
      end
      VEC_LOOP_1_COMP_LOOP_C_73 : begin
        fsm_output = 9'b010011011;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_74;
      end
      VEC_LOOP_1_COMP_LOOP_C_74 : begin
        fsm_output = 9'b010011100;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_75;
      end
      VEC_LOOP_1_COMP_LOOP_C_75 : begin
        fsm_output = 9'b010011101;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_76;
      end
      VEC_LOOP_1_COMP_LOOP_C_76 : begin
        fsm_output = 9'b010011110;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_77;
      end
      VEC_LOOP_1_COMP_LOOP_C_77 : begin
        fsm_output = 9'b010011111;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_78;
      end
      VEC_LOOP_1_COMP_LOOP_C_78 : begin
        fsm_output = 9'b010100000;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_79;
      end
      VEC_LOOP_1_COMP_LOOP_C_79 : begin
        fsm_output = 9'b010100001;
        state_var_NS = VEC_LOOP_1_COMP_LOOP_C_80;
      end
      VEC_LOOP_1_COMP_LOOP_C_80 : begin
        fsm_output = 9'b010100010;
        if ( VEC_LOOP_1_COMP_LOOP_C_80_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 9'b010100011;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_6;
        end
        else begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_2_COMP_LOOP_C_0 : begin
        fsm_output = 9'b010100100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_1;
      end
      VEC_LOOP_2_COMP_LOOP_C_1 : begin
        fsm_output = 9'b010100101;
        if ( VEC_LOOP_2_COMP_LOOP_C_1_tr0 ) begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0 : begin
        fsm_output = 9'b010100110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_1;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_1 : begin
        fsm_output = 9'b010100111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_2;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_2 : begin
        fsm_output = 9'b010101000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_3;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_3 : begin
        fsm_output = 9'b010101001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_4;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_4 : begin
        fsm_output = 9'b010101010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_5;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_5 : begin
        fsm_output = 9'b010101011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_6;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_6 : begin
        fsm_output = 9'b010101100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_7;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_7 : begin
        fsm_output = 9'b010101101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_8;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_8 : begin
        fsm_output = 9'b010101110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_9;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_9 : begin
        fsm_output = 9'b010101111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_10;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_10 : begin
        fsm_output = 9'b010110000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_11;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_11 : begin
        fsm_output = 9'b010110001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_12;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_12 : begin
        fsm_output = 9'b010110010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_13;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_13 : begin
        fsm_output = 9'b010110011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_14;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_14 : begin
        fsm_output = 9'b010110100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_15;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_15 : begin
        fsm_output = 9'b010110101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_16;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_16 : begin
        fsm_output = 9'b010110110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_17;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_17 : begin
        fsm_output = 9'b010110111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_18;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_18 : begin
        fsm_output = 9'b010111000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_19;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_19 : begin
        fsm_output = 9'b010111001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_20;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_20 : begin
        fsm_output = 9'b010111010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_21;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_21 : begin
        fsm_output = 9'b010111011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_22;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_22 : begin
        fsm_output = 9'b010111100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_23;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_23 : begin
        fsm_output = 9'b010111101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24;
      end
      VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24 : begin
        fsm_output = 9'b010111110;
        if ( VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0 ) begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      VEC_LOOP_2_COMP_LOOP_C_2 : begin
        fsm_output = 9'b010111111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_3;
      end
      VEC_LOOP_2_COMP_LOOP_C_3 : begin
        fsm_output = 9'b011000000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_4;
      end
      VEC_LOOP_2_COMP_LOOP_C_4 : begin
        fsm_output = 9'b011000001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_5;
      end
      VEC_LOOP_2_COMP_LOOP_C_5 : begin
        fsm_output = 9'b011000010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_6;
      end
      VEC_LOOP_2_COMP_LOOP_C_6 : begin
        fsm_output = 9'b011000011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_7;
      end
      VEC_LOOP_2_COMP_LOOP_C_7 : begin
        fsm_output = 9'b011000100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_8;
      end
      VEC_LOOP_2_COMP_LOOP_C_8 : begin
        fsm_output = 9'b011000101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_9;
      end
      VEC_LOOP_2_COMP_LOOP_C_9 : begin
        fsm_output = 9'b011000110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_10;
      end
      VEC_LOOP_2_COMP_LOOP_C_10 : begin
        fsm_output = 9'b011000111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_11;
      end
      VEC_LOOP_2_COMP_LOOP_C_11 : begin
        fsm_output = 9'b011001000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_12;
      end
      VEC_LOOP_2_COMP_LOOP_C_12 : begin
        fsm_output = 9'b011001001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_13;
      end
      VEC_LOOP_2_COMP_LOOP_C_13 : begin
        fsm_output = 9'b011001010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_14;
      end
      VEC_LOOP_2_COMP_LOOP_C_14 : begin
        fsm_output = 9'b011001011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_15;
      end
      VEC_LOOP_2_COMP_LOOP_C_15 : begin
        fsm_output = 9'b011001100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_16;
      end
      VEC_LOOP_2_COMP_LOOP_C_16 : begin
        fsm_output = 9'b011001101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_17;
      end
      VEC_LOOP_2_COMP_LOOP_C_17 : begin
        fsm_output = 9'b011001110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_18;
      end
      VEC_LOOP_2_COMP_LOOP_C_18 : begin
        fsm_output = 9'b011001111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_19;
      end
      VEC_LOOP_2_COMP_LOOP_C_19 : begin
        fsm_output = 9'b011010000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_20;
      end
      VEC_LOOP_2_COMP_LOOP_C_20 : begin
        fsm_output = 9'b011010001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_21;
      end
      VEC_LOOP_2_COMP_LOOP_C_21 : begin
        fsm_output = 9'b011010010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_22;
      end
      VEC_LOOP_2_COMP_LOOP_C_22 : begin
        fsm_output = 9'b011010011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_23;
      end
      VEC_LOOP_2_COMP_LOOP_C_23 : begin
        fsm_output = 9'b011010100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_24;
      end
      VEC_LOOP_2_COMP_LOOP_C_24 : begin
        fsm_output = 9'b011010101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_25;
      end
      VEC_LOOP_2_COMP_LOOP_C_25 : begin
        fsm_output = 9'b011010110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_26;
      end
      VEC_LOOP_2_COMP_LOOP_C_26 : begin
        fsm_output = 9'b011010111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_27;
      end
      VEC_LOOP_2_COMP_LOOP_C_27 : begin
        fsm_output = 9'b011011000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_28;
      end
      VEC_LOOP_2_COMP_LOOP_C_28 : begin
        fsm_output = 9'b011011001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_29;
      end
      VEC_LOOP_2_COMP_LOOP_C_29 : begin
        fsm_output = 9'b011011010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_30;
      end
      VEC_LOOP_2_COMP_LOOP_C_30 : begin
        fsm_output = 9'b011011011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_31;
      end
      VEC_LOOP_2_COMP_LOOP_C_31 : begin
        fsm_output = 9'b011011100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_32;
      end
      VEC_LOOP_2_COMP_LOOP_C_32 : begin
        fsm_output = 9'b011011101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_33;
      end
      VEC_LOOP_2_COMP_LOOP_C_33 : begin
        fsm_output = 9'b011011110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_34;
      end
      VEC_LOOP_2_COMP_LOOP_C_34 : begin
        fsm_output = 9'b011011111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_35;
      end
      VEC_LOOP_2_COMP_LOOP_C_35 : begin
        fsm_output = 9'b011100000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_36;
      end
      VEC_LOOP_2_COMP_LOOP_C_36 : begin
        fsm_output = 9'b011100001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_37;
      end
      VEC_LOOP_2_COMP_LOOP_C_37 : begin
        fsm_output = 9'b011100010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_38;
      end
      VEC_LOOP_2_COMP_LOOP_C_38 : begin
        fsm_output = 9'b011100011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_39;
      end
      VEC_LOOP_2_COMP_LOOP_C_39 : begin
        fsm_output = 9'b011100100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_40;
      end
      VEC_LOOP_2_COMP_LOOP_C_40 : begin
        fsm_output = 9'b011100101;
        if ( VEC_LOOP_2_COMP_LOOP_C_40_tr0 ) begin
          state_var_NS = VEC_LOOP_C_1;
        end
        else begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_C_41;
        end
      end
      VEC_LOOP_2_COMP_LOOP_C_41 : begin
        fsm_output = 9'b011100110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0 : begin
        fsm_output = 9'b011100111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_1;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_1 : begin
        fsm_output = 9'b011101000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_2;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_2 : begin
        fsm_output = 9'b011101001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_3;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_3 : begin
        fsm_output = 9'b011101010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_4;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_4 : begin
        fsm_output = 9'b011101011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_5;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_5 : begin
        fsm_output = 9'b011101100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_6;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_6 : begin
        fsm_output = 9'b011101101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_7;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_7 : begin
        fsm_output = 9'b011101110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_8;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_8 : begin
        fsm_output = 9'b011101111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_9;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_9 : begin
        fsm_output = 9'b011110000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_10;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_10 : begin
        fsm_output = 9'b011110001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_11;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_11 : begin
        fsm_output = 9'b011110010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_12;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_12 : begin
        fsm_output = 9'b011110011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_13;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_13 : begin
        fsm_output = 9'b011110100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_14;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_14 : begin
        fsm_output = 9'b011110101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_15;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_15 : begin
        fsm_output = 9'b011110110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_16;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_16 : begin
        fsm_output = 9'b011110111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_17;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_17 : begin
        fsm_output = 9'b011111000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_18;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_18 : begin
        fsm_output = 9'b011111001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_19;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_19 : begin
        fsm_output = 9'b011111010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_20;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_20 : begin
        fsm_output = 9'b011111011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_21;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_21 : begin
        fsm_output = 9'b011111100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_22;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_22 : begin
        fsm_output = 9'b011111101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_23;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_23 : begin
        fsm_output = 9'b011111110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24;
      end
      VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24 : begin
        fsm_output = 9'b011111111;
        if ( VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0 ) begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_C_42;
        end
        else begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_0;
        end
      end
      VEC_LOOP_2_COMP_LOOP_C_42 : begin
        fsm_output = 9'b100000000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_43;
      end
      VEC_LOOP_2_COMP_LOOP_C_43 : begin
        fsm_output = 9'b100000001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_44;
      end
      VEC_LOOP_2_COMP_LOOP_C_44 : begin
        fsm_output = 9'b100000010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_45;
      end
      VEC_LOOP_2_COMP_LOOP_C_45 : begin
        fsm_output = 9'b100000011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_46;
      end
      VEC_LOOP_2_COMP_LOOP_C_46 : begin
        fsm_output = 9'b100000100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_47;
      end
      VEC_LOOP_2_COMP_LOOP_C_47 : begin
        fsm_output = 9'b100000101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_48;
      end
      VEC_LOOP_2_COMP_LOOP_C_48 : begin
        fsm_output = 9'b100000110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_49;
      end
      VEC_LOOP_2_COMP_LOOP_C_49 : begin
        fsm_output = 9'b100000111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_50;
      end
      VEC_LOOP_2_COMP_LOOP_C_50 : begin
        fsm_output = 9'b100001000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_51;
      end
      VEC_LOOP_2_COMP_LOOP_C_51 : begin
        fsm_output = 9'b100001001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_52;
      end
      VEC_LOOP_2_COMP_LOOP_C_52 : begin
        fsm_output = 9'b100001010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_53;
      end
      VEC_LOOP_2_COMP_LOOP_C_53 : begin
        fsm_output = 9'b100001011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_54;
      end
      VEC_LOOP_2_COMP_LOOP_C_54 : begin
        fsm_output = 9'b100001100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_55;
      end
      VEC_LOOP_2_COMP_LOOP_C_55 : begin
        fsm_output = 9'b100001101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_56;
      end
      VEC_LOOP_2_COMP_LOOP_C_56 : begin
        fsm_output = 9'b100001110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_57;
      end
      VEC_LOOP_2_COMP_LOOP_C_57 : begin
        fsm_output = 9'b100001111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_58;
      end
      VEC_LOOP_2_COMP_LOOP_C_58 : begin
        fsm_output = 9'b100010000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_59;
      end
      VEC_LOOP_2_COMP_LOOP_C_59 : begin
        fsm_output = 9'b100010001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_60;
      end
      VEC_LOOP_2_COMP_LOOP_C_60 : begin
        fsm_output = 9'b100010010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_61;
      end
      VEC_LOOP_2_COMP_LOOP_C_61 : begin
        fsm_output = 9'b100010011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_62;
      end
      VEC_LOOP_2_COMP_LOOP_C_62 : begin
        fsm_output = 9'b100010100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_63;
      end
      VEC_LOOP_2_COMP_LOOP_C_63 : begin
        fsm_output = 9'b100010101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_64;
      end
      VEC_LOOP_2_COMP_LOOP_C_64 : begin
        fsm_output = 9'b100010110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_65;
      end
      VEC_LOOP_2_COMP_LOOP_C_65 : begin
        fsm_output = 9'b100010111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_66;
      end
      VEC_LOOP_2_COMP_LOOP_C_66 : begin
        fsm_output = 9'b100011000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_67;
      end
      VEC_LOOP_2_COMP_LOOP_C_67 : begin
        fsm_output = 9'b100011001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_68;
      end
      VEC_LOOP_2_COMP_LOOP_C_68 : begin
        fsm_output = 9'b100011010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_69;
      end
      VEC_LOOP_2_COMP_LOOP_C_69 : begin
        fsm_output = 9'b100011011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_70;
      end
      VEC_LOOP_2_COMP_LOOP_C_70 : begin
        fsm_output = 9'b100011100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_71;
      end
      VEC_LOOP_2_COMP_LOOP_C_71 : begin
        fsm_output = 9'b100011101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_72;
      end
      VEC_LOOP_2_COMP_LOOP_C_72 : begin
        fsm_output = 9'b100011110;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_73;
      end
      VEC_LOOP_2_COMP_LOOP_C_73 : begin
        fsm_output = 9'b100011111;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_74;
      end
      VEC_LOOP_2_COMP_LOOP_C_74 : begin
        fsm_output = 9'b100100000;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_75;
      end
      VEC_LOOP_2_COMP_LOOP_C_75 : begin
        fsm_output = 9'b100100001;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_76;
      end
      VEC_LOOP_2_COMP_LOOP_C_76 : begin
        fsm_output = 9'b100100010;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_77;
      end
      VEC_LOOP_2_COMP_LOOP_C_77 : begin
        fsm_output = 9'b100100011;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_78;
      end
      VEC_LOOP_2_COMP_LOOP_C_78 : begin
        fsm_output = 9'b100100100;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_79;
      end
      VEC_LOOP_2_COMP_LOOP_C_79 : begin
        fsm_output = 9'b100100101;
        state_var_NS = VEC_LOOP_2_COMP_LOOP_C_80;
      end
      VEC_LOOP_2_COMP_LOOP_C_80 : begin
        fsm_output = 9'b100100110;
        if ( VEC_LOOP_2_COMP_LOOP_C_80_tr0 ) begin
          state_var_NS = VEC_LOOP_C_1;
        end
        else begin
          state_var_NS = VEC_LOOP_2_COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_1 : begin
        fsm_output = 9'b100100111;
        if ( VEC_LOOP_C_1_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_6;
        end
        else begin
          state_var_NS = VEC_LOOP_1_COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_6 : begin
        fsm_output = 9'b100101000;
        if ( STAGE_LOOP_C_6_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b100101001;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 9'b000000000;
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
//  Design Unit:    inPlaceNTT_DIT_core
// ------------------------------------------------------------------


module inPlaceNTT_DIT_core (
  clk, rst, vec_rsc_triosy_0_0_lz, vec_rsc_triosy_0_1_lz, p_rsc_dat, p_rsc_triosy_lz,
      r_rsc_dat, r_rsc_triosy_lz, vec_rsc_0_0_i_qa_d, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_1_i_qa_d, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d, vec_rsc_0_0_i_adra_d_pff,
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
  output [10:0] vec_rsc_0_0_i_adra_d_pff;
  output [63:0] vec_rsc_0_0_i_da_d_pff;
  output vec_rsc_0_0_i_wea_d_pff;
  output vec_rsc_0_1_i_wea_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  wire [63:0] r_rsci_idat;
  reg [63:0] modulo_result_rem_cmp_a;
  reg [63:0] modulo_result_rem_cmp_b;
  wire [63:0] modulo_result_rem_cmp_z;
  reg [64:0] operator_66_true_div_cmp_a;
  wire [64:0] operator_66_true_div_cmp_z;
  reg [9:0] operator_66_true_div_cmp_b_9_0;
  wire [8:0] fsm_output;
  wire mux_tmp_60;
  wire and_dcpl_18;
  wire and_dcpl_19;
  wire and_dcpl_20;
  wire and_dcpl_22;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire and_dcpl_34;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_40;
  wire mux_tmp_65;
  wire or_tmp_60;
  wire nor_tmp_14;
  wire and_dcpl_51;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire or_tmp_70;
  wire and_dcpl_71;
  wire and_dcpl_72;
  wire and_dcpl_73;
  wire and_dcpl_74;
  wire mux_tmp_104;
  wire or_tmp_127;
  wire or_tmp_131;
  wire mux_tmp_109;
  wire or_tmp_134;
  wire mux_tmp_115;
  wire or_tmp_139;
  wire or_tmp_144;
  wire mux_tmp_124;
  wire and_dcpl_75;
  wire and_dcpl_76;
  wire and_dcpl_77;
  wire and_dcpl_78;
  wire and_dcpl_82;
  wire and_dcpl_84;
  wire and_dcpl_86;
  wire and_dcpl_89;
  wire mux_tmp_138;
  wire and_dcpl_92;
  wire and_dcpl_95;
  wire mux_tmp_141;
  wire mux_tmp_142;
  wire or_tmp_162;
  wire mux_tmp_144;
  wire mux_tmp_150;
  wire mux_tmp_152;
  wire mux_tmp_155;
  wire and_dcpl_100;
  wire or_tmp_195;
  wire and_dcpl_101;
  wire and_dcpl_105;
  wire and_dcpl_114;
  wire and_dcpl_116;
  wire or_tmp_204;
  wire and_dcpl_120;
  wire and_dcpl_122;
  wire or_tmp_213;
  wire or_tmp_223;
  wire or_tmp_225;
  wire and_dcpl_129;
  wire and_dcpl_131;
  wire and_dcpl_133;
  wire and_dcpl_134;
  wire mux_tmp_227;
  wire mux_tmp_229;
  wire or_tmp_235;
  wire and_dcpl_145;
  wire mux_tmp_290;
  wire mux_tmp_292;
  wire mux_tmp_296;
  wire and_tmp_9;
  wire and_dcpl_153;
  wire and_dcpl_157;
  wire and_dcpl_158;
  reg exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva;
  reg VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  reg [11:0] VEC_LOOP_j_1_12_0_sva_11_0;
  reg [9:0] STAGE_LOOP_lshift_psp_sva;
  reg modExp_exp_1_0_1_sva;
  reg [11:0] COMP_LOOP_acc_1_cse_2_sva;
  wire [12:0] nl_COMP_LOOP_acc_1_cse_2_sva;
  reg [11:0] COMP_LOOP_acc_10_cse_12_1_1_sva;
  reg [7:0] COMP_LOOP_k_9_1_1_sva_7_0;
  reg [63:0] tmp_2_lpi_4_dfm;
  reg [11:0] reg_VEC_LOOP_1_acc_1_psp_ftd_1;
  wire and_107_m1c;
  wire and_116_m1c;
  wire or_121_cse;
  wire mux_80_cse;
  wire nor_15_cse;
  reg reg_vec_rsc_triosy_0_1_obj_ld_cse;
  wire or_64_cse;
  wire or_13_cse;
  wire or_265_cse;
  wire nor_122_cse;
  wire or_31_cse;
  wire nand_44_cse;
  wire or_326_cse;
  wire and_202_cse;
  wire mux_14_cse;
  wire mux_74_cse;
  wire mux_73_cse;
  wire mux_70_cse;
  wire or_189_cse;
  reg [10:0] COMP_LOOP_acc_psp_1_sva;
  wire [63:0] modExp_base_1_sva_mx1;
  wire or_tmp;
  wire or_tmp_297;
  wire [63:0] modulo_qr_sva_1_mx0w5;
  wire [64:0] nl_modulo_qr_sva_1_mx0w5;
  wire modExp_while_and_3;
  wire modExp_while_and_5;
  wire mux_62_itm;
  wire mux_67_itm;
  wire and_dcpl_160;
  wire xor_dcpl;
  wire and_dcpl_165;
  wire and_dcpl_170;
  wire and_dcpl_171;
  wire and_dcpl_174;
  wire and_dcpl_177;
  wire [9:0] z_out;
  wire [8:0] z_out_1;
  wire [9:0] nl_z_out_1;
  wire [10:0] z_out_2;
  wire [11:0] nl_z_out_2;
  wire and_dcpl_200;
  wire and_dcpl_201;
  wire and_dcpl_202;
  wire and_dcpl_203;
  wire and_dcpl_204;
  wire and_dcpl_206;
  wire and_dcpl_207;
  wire and_dcpl_208;
  wire or_tmp_306;
  wire and_dcpl_210;
  wire and_dcpl_211;
  wire and_dcpl_215;
  wire and_dcpl_220;
  wire and_dcpl_222;
  wire and_dcpl_224;
  wire and_dcpl_226;
  wire and_dcpl_230;
  wire and_dcpl_233;
  wire and_dcpl_235;
  wire and_dcpl_237;
  wire and_dcpl_240;
  wire and_dcpl_242;
  wire and_dcpl_245;
  wire [64:0] z_out_3;
  wire [65:0] nl_z_out_3;
  wire or_tmp_311;
  wire and_dcpl_265;
  wire and_dcpl_266;
  wire or_tmp_315;
  wire [63:0] z_out_5;
  wire [127:0] nl_z_out_5;
  reg [63:0] p_sva;
  reg [63:0] r_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [63:0] modExp_result_sva;
  reg modExp_exp_1_7_1_sva;
  reg modExp_exp_1_6_1_sva;
  reg modExp_exp_1_5_1_sva;
  reg modExp_exp_1_4_1_sva;
  reg modExp_exp_1_3_1_sva;
  reg modExp_exp_1_2_1_sva;
  reg modExp_exp_1_1_1_sva;
  reg modExp_exp_1_0_1_sva_1;
  reg [63:0] modExp_base_1_sva;
  reg [63:0] VEC_LOOP_1_COMP_LOOP_1_acc_8_itm;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [9:0] STAGE_LOOP_lshift_psp_sva_mx0w0;
  wire VEC_LOOP_j_1_12_0_sva_11_0_mx0c1;
  wire modExp_result_sva_mx0c0;
  wire [62:0] operator_64_false_slc_modExp_exp_63_1_3;
  wire VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c0;
  wire VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c1;
  wire modExp_result_and_rgt;
  wire modExp_result_and_1_rgt;
  wire COMP_LOOP_or_1_cse;
  wire COMP_LOOP_or_2_cse;
  wire mux_tmp_337;
  wire or_tmp_325;
  wire nand_tmp;
  wire or_tmp_344;
  wire or_tmp_347;
  wire or_tmp_351;
  wire [64:0] operator_64_false_mux1h_2_rgt;
  reg operator_64_false_acc_mut_64;
  reg [63:0] operator_64_false_acc_mut_63_0;
  wire and_342_cse;
  wire nor_87_cse;
  wire or_386_cse;
  wire or_425_cse;
  wire or_424_cse;
  wire mux_331_itm;
  wire operator_64_false_1_nor_itm;
  wire operator_64_false_1_nor_3_itm;
  wire operator_64_false_1_or_5_itm;
  wire operator_64_false_1_or_6_itm;
  wire nand_cse;
  wire and_346_cse;
  wire nor_183_cse;

  wire[0:0] or_108_nl;
  wire[0:0] or_106_nl;
  wire[0:0] or_99_nl;
  wire[0:0] modulo_result_or_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] or_169_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] or_165_nl;
  wire[0:0] mux_116_nl;
  wire[0:0] or_163_nl;
  wire[0:0] mux_112_nl;
  wire[0:0] mux_111_nl;
  wire[0:0] mux_110_nl;
  wire[0:0] nand_29_nl;
  wire[0:0] mux_108_nl;
  wire[0:0] mux_107_nl;
  wire[0:0] or_157_nl;
  wire[0:0] mux_106_nl;
  wire[0:0] mux_105_nl;
  wire[0:0] or_153_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] or_152_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] or_151_nl;
  wire[0:0] or_149_nl;
  wire[0:0] or_148_nl;
  wire[0:0] mux_134_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] nand_27_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] mux_131_nl;
  wire[0:0] mux_130_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] mux_128_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] or_176_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] nand_12_nl;
  wire[0:0] or_173_nl;
  wire[0:0] nor_82_nl;
  wire[63:0] mux1h_nl;
  wire[0:0] or_nl;
  wire[0:0] mux_276_nl;
  wire[0:0] or_294_nl;
  wire[0:0] mux_275_nl;
  wire[0:0] or_293_nl;
  wire[0:0] mux_320_nl;
  wire[0:0] mux_319_nl;
  wire[0:0] mux_318_nl;
  wire[0:0] mux_317_nl;
  wire[0:0] or_364_nl;
  wire[0:0] mux_316_nl;
  wire[0:0] mux_315_nl;
  wire[0:0] mux_314_nl;
  wire[0:0] or_363_nl;
  wire[0:0] mux_nl;
  wire[0:0] nand_46_nl;
  wire[0:0] mux_254_nl;
  wire[0:0] mux_253_nl;
  wire[0:0] nor_55_nl;
  wire[0:0] nor_56_nl;
  wire[0:0] and_144_nl;
  wire[0:0] modExp_while_if_and_1_nl;
  wire[0:0] modExp_while_if_and_2_nl;
  wire[0:0] and_95_nl;
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
  wire[0:0] mux_154_nl;
  wire[0:0] mux_153_nl;
  wire[0:0] mux_151_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] mux_146_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] or_193_nl;
  wire[0:0] mux_143_nl;
  wire[0:0] mux_359_nl;
  wire[0:0] mux_358_nl;
  wire[0:0] mux_357_nl;
  wire[0:0] mux_356_nl;
  wire[0:0] mux_355_nl;
  wire[0:0] mux_354_nl;
  wire[0:0] or_394_nl;
  wire[0:0] mux_349_nl;
  wire[0:0] mux_353_nl;
  wire[0:0] mux_352_nl;
  wire[0:0] mux_351_nl;
  wire[0:0] mux_350_nl;
  wire[0:0] mux_385_nl;
  wire[0:0] mux_348_nl;
  wire[0:0] mux_347_nl;
  wire[0:0] or_393_nl;
  wire[0:0] mux_346_nl;
  wire[0:0] or_392_nl;
  wire[0:0] mux_345_nl;
  wire[0:0] mux_344_nl;
  wire[0:0] or_389_nl;
  wire[0:0] and_340_nl;
  wire[0:0] mux_343_nl;
  wire[0:0] mux_342_nl;
  wire[0:0] mux_341_nl;
  wire[0:0] mux_340_nl;
  wire[0:0] mux_379_nl;
  wire[0:0] mux_378_nl;
  wire[0:0] mux_377_nl;
  wire[0:0] mux_376_nl;
  wire[0:0] mux_375_nl;
  wire[0:0] or_422_nl;
  wire[0:0] mux_374_nl;
  wire[0:0] or_420_nl;
  wire[0:0] or_418_nl;
  wire[0:0] mux_373_nl;
  wire[0:0] mux_372_nl;
  wire[0:0] or_417_nl;
  wire[0:0] mux_371_nl;
  wire[0:0] mux_370_nl;
  wire[0:0] or_414_nl;
  wire[0:0] mux_369_nl;
  wire[0:0] mux_368_nl;
  wire[0:0] mux_367_nl;
  wire[0:0] or_410_nl;
  wire[0:0] mux_366_nl;
  wire[0:0] mux_365_nl;
  wire[0:0] mux_364_nl;
  wire[0:0] mux_363_nl;
  wire[0:0] or_407_nl;
  wire[0:0] mux_362_nl;
  wire[0:0] or_405_nl;
  wire[0:0] or_403_nl;
  wire[0:0] mux_361_nl;
  wire[0:0] or_401_nl;
  wire[0:0] or_400_nl;
  wire[0:0] or_399_nl;
  wire[0:0] nand_55_nl;
  wire[0:0] mux_191_nl;
  wire[0:0] mux_190_nl;
  wire[0:0] mux_189_nl;
  wire[0:0] nor_71_nl;
  wire[0:0] and_183_nl;
  wire[0:0] nor_72_nl;
  wire[0:0] nor_73_nl;
  wire[0:0] mux_383_nl;
  wire[0:0] nor_174_nl;
  wire[0:0] nor_175_nl;
  wire[0:0] nor_176_nl;
  wire[0:0] mux_382_nl;
  wire[0:0] or_430_nl;
  wire[0:0] mux_381_nl;
  wire[0:0] or_428_nl;
  wire[0:0] or_426_nl;
  wire[0:0] mux_380_nl;
  wire[0:0] mux_204_nl;
  wire[0:0] nor_68_nl;
  wire[0:0] mux_203_nl;
  wire[0:0] or_230_nl;
  wire[0:0] or_228_nl;
  wire[0:0] and_111_nl;
  wire[0:0] r_or_nl;
  wire[0:0] r_or_1_nl;
  wire[0:0] mux_210_nl;
  wire[0:0] or_358_nl;
  wire[0:0] mux_209_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] or_237_nl;
  wire[0:0] nand_35_nl;
  wire[0:0] mux_207_nl;
  wire[0:0] and_134_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[0:0] mux_219_nl;
  wire[0:0] or_252_nl;
  wire[0:0] or_251_nl;
  wire[0:0] and_135_nl;
  wire[0:0] mux_224_nl;
  wire[0:0] mux_223_nl;
  wire[0:0] or_259_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] or_258_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] mux_215_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] nand_24_nl;
  wire[0:0] nand_25_nl;
  wire[0:0] nor_63_nl;
  wire[0:0] or_246_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] or_245_nl;
  wire[0:0] nor_64_nl;
  wire[0:0] mux_212_nl;
  wire[0:0] COMP_LOOP_mux1h_13_nl;
  wire[0:0] COMP_LOOP_and_3_nl;
  wire[0:0] mux_240_nl;
  wire[0:0] mux_239_nl;
  wire[0:0] mux_238_nl;
  wire[0:0] nor_59_nl;
  wire[0:0] mux_237_nl;
  wire[0:0] mux_236_nl;
  wire[0:0] nor_60_nl;
  wire[0:0] mux_235_nl;
  wire[0:0] mux_234_nl;
  wire[0:0] mux_233_nl;
  wire[0:0] mux_232_nl;
  wire[0:0] nand_23_nl;
  wire[0:0] mux_231_nl;
  wire[0:0] and_175_nl;
  wire[0:0] mux_230_nl;
  wire[0:0] mux_250_nl;
  wire[0:0] mux_249_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] or_340_nl;
  wire[0:0] or_341_nl;
  wire[0:0] nor_58_nl;
  wire[0:0] mux_247_nl;
  wire[0:0] mux_246_nl;
  wire[0:0] or_274_nl;
  wire[0:0] mux_245_nl;
  wire[0:0] mux_244_nl;
  wire[0:0] mux_243_nl;
  wire[0:0] mux_242_nl;
  wire[0:0] or_343_nl;
  wire[0:0] and_173_nl;
  wire[0:0] mux_241_nl;
  wire[0:0] or_269_nl;
  wire[9:0] VEC_LOOP_1_COMP_LOOP_1_acc_11_nl;
  wire[10:0] nl_VEC_LOOP_1_COMP_LOOP_1_acc_11_nl;
  wire[63:0] VEC_LOOP_1_COMP_LOOP_1_acc_8_nl;
  wire[64:0] nl_VEC_LOOP_1_COMP_LOOP_1_acc_8_nl;
  wire[0:0] mux_281_nl;
  wire[0:0] or_301_nl;
  wire[11:0] COMP_LOOP_mux_100_nl;
  wire[0:0] mux_301_nl;
  wire[0:0] mux_300_nl;
  wire[0:0] mux_299_nl;
  wire[0:0] mux_298_nl;
  wire[0:0] mux_297_nl;
  wire[0:0] mux_293_nl;
  wire[0:0] and_161_nl;
  wire[0:0] mux_306_nl;
  wire[0:0] mux_305_nl;
  wire[0:0] mux_304_nl;
  wire[0:0] mux_303_nl;
  wire[0:0] or_29_nl;
  wire[0:0] COMP_LOOP_mux1h_22_nl;
  wire[0:0] and_165_nl;
  wire[0:0] mux_309_nl;
  wire[0:0] mux_308_nl;
  wire[0:0] and_164_nl;
  wire[0:0] COMP_LOOP_mux1h_39_nl;
  wire[0:0] or_74_nl;
  wire[0:0] nor_111_nl;
  wire[0:0] mux_61_nl;
  wire[0:0] or_75_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] or_90_nl;
  wire[0:0] or_87_nl;
  wire[0:0] mux_114_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] or_352_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] or_183_nl;
  wire[0:0] or_181_nl;
  wire[0:0] or_353_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] or_185_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] or_56_nl;
  wire[0:0] or_191_nl;
  wire[0:0] mux_201_nl;
  wire[0:0] nand_40_nl;
  wire[0:0] or_360_nl;
  wire[0:0] mux_206_nl;
  wire[0:0] nor_75_nl;
  wire[0:0] nor_67_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] nor_109_nl;
  wire[0:0] nor_110_nl;
  wire[0:0] mux_226_nl;
  wire[0:0] nor_61_nl;
  wire[0:0] mux_225_nl;
  wire[0:0] nor_62_nl;
  wire[0:0] and_141_nl;
  wire[0:0] mux_228_nl;
  wire[0:0] mux_289_nl;
  wire[0:0] or_323_nl;
  wire[0:0] mux_291_nl;
  wire[0:0] mux_295_nl;
  wire[0:0] or_325_nl;
  wire[0:0] mux_307_nl;
  wire[0:0] nor_53_nl;
  wire[0:0] and_171_nl;
  wire[0:0] mux_310_nl;
  wire[0:0] nor_69_nl;
  wire[0:0] mux_205_nl;
  wire[0:0] or_232_nl;
  wire[0:0] and_47_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] nor_151_nl;
  wire[0:0] and_53_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] nor_106_nl;
  wire[0:0] nor_107_nl;
  wire[0:0] nor_108_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] or_355_nl;
  wire[0:0] mux_75_nl;
  wire[0:0] nand_2_nl;
  wire[0:0] or_107_nl;
  wire[0:0] or_356_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] mux_71_nl;
  wire[0:0] nor_104_nl;
  wire[0:0] nor_105_nl;
  wire[0:0] or_100_nl;
  wire[0:0] nor_98_nl;
  wire[0:0] mux_84_nl;
  wire[0:0] or_123_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] or_122_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] or_120_nl;
  wire[0:0] or_118_nl;
  wire[0:0] or_117_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] or_116_nl;
  wire[0:0] or_115_nl;
  wire[0:0] and_195_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] nor_99_nl;
  wire[0:0] and_196_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] nor_100_nl;
  wire[0:0] nor_101_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] nand_34_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] and_194_nl;
  wire[0:0] nor_94_nl;
  wire[0:0] or_354_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] nand_6_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] and_208_nl;
  wire[0:0] nor_97_nl;
  wire[0:0] or_346_nl;
  wire[0:0] nor_89_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] or_146_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] or_145_nl;
  wire[0:0] or_143_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] nand_30_nl;
  wire[0:0] nand_11_nl;
  wire[0:0] mux_95_nl;
  wire[0:0] nor_90_nl;
  wire[0:0] nor_91_nl;
  wire[0:0] and_190_nl;
  wire[0:0] mux_94_nl;
  wire[0:0] nor_92_nl;
  wire[0:0] and_191_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] nor_93_nl;
  wire[0:0] and_192_nl;
  wire[0:0] mux_336_nl;
  wire[0:0] or_383_nl;
  wire[0:0] nand_56_nl;
  wire[0:0] mux_327_nl;
  wire[0:0] and_nl;
  wire[0:0] mux_326_nl;
  wire[0:0] or_373_nl;
  wire[0:0] nor_147_nl;
  wire[0:0] mux_325_nl;
  wire[0:0] or_371_nl;
  wire[0:0] mux_330_nl;
  wire[0:0] mux_329_nl;
  wire[0:0] or_377_nl;
  wire[0:0] mux_328_nl;
  wire[0:0] or_376_nl;
  wire[0:0] or_378_nl;
  wire[0:0] mux_338_nl;
  wire[0:0] mux_337_nl;
  wire[0:0] mux_360_nl;
  wire[0:0] nor_177_nl;
  wire[0:0] and_343_nl;
  wire[10:0] acc_nl;
  wire[11:0] nl_acc_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_2_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_3_nl;
  wire[0:0] COMP_LOOP_mux_98_nl;
  wire[0:0] COMP_LOOP_mux1h_73_nl;
  wire[0:0] COMP_LOOP_mux1h_74_nl;
  wire[0:0] COMP_LOOP_mux1h_75_nl;
  wire[0:0] COMP_LOOP_mux1h_76_nl;
  wire[0:0] COMP_LOOP_mux1h_77_nl;
  wire[0:0] COMP_LOOP_mux1h_78_nl;
  wire[0:0] COMP_LOOP_mux1h_79_nl;
  wire[0:0] COMP_LOOP_mux1h_80_nl;
  wire[0:0] COMP_LOOP_or_17_nl;
  wire[0:0] COMP_LOOP_or_18_nl;
  wire[7:0] COMP_LOOP_COMP_LOOP_and_1_nl;
  wire[0:0] COMP_LOOP_nor_4_nl;
  wire[7:0] STAGE_LOOP_mux_5_nl;
  wire[0:0] and_345_nl;
  wire[0:0] mux_387_nl;
  wire[0:0] nor_180_nl;
  wire[0:0] nor_181_nl;
  wire[10:0] COMP_LOOP_mux_99_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_53_nl;
  wire[0:0] operator_64_false_1_mux_1_nl;
  wire[50:0] operator_64_false_1_or_13_nl;
  wire[50:0] operator_64_false_1_and_57_nl;
  wire[50:0] operator_64_false_1_mux1h_6_nl;
  wire[1:0] operator_64_false_1_or_14_nl;
  wire[1:0] operator_64_false_1_and_58_nl;
  wire[1:0] operator_64_false_1_mux1h_7_nl;
  wire[0:0] operator_64_false_1_nor_56_nl;
  wire[9:0] operator_64_false_1_mux1h_8_nl;
  wire[8:0] COMP_LOOP_acc_18_nl;
  wire[9:0] nl_COMP_LOOP_acc_18_nl;
  wire[0:0] operator_64_false_1_or_15_nl;
  wire[0:0] operator_64_false_1_or_16_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_54_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_55_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_56_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_57_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_58_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_59_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_60_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_61_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_62_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_63_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_64_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_65_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_66_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_67_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_68_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_69_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_70_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_71_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_72_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_73_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_74_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_75_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_76_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_77_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_78_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_79_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_80_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_81_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_82_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_83_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_84_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_85_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_86_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_87_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_88_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_89_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_90_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_91_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_92_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_93_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_94_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_95_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_96_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_97_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_98_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_99_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_100_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_101_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_102_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_103_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_104_nl;
  wire[0:0] operator_64_false_1_operator_64_false_1_or_105_nl;
  wire[1:0] operator_64_false_1_or_17_nl;
  wire[1:0] operator_64_false_1_and_111_nl;
  wire[1:0] operator_64_false_1_mux1h_9_nl;
  wire[0:0] operator_64_false_1_nor_57_nl;
  wire[9:0] operator_64_false_1_or_18_nl;
  wire[9:0] operator_64_false_1_mux1h_10_nl;
  wire[0:0] operator_64_false_1_or_19_nl;
  wire[0:0] operator_64_false_1_or_20_nl;
  wire[63:0] modExp_while_if_mux1h_1_nl;
  wire[0:0] and_348_nl;
  wire[0:0] modExp_while_if_or_1_nl;
  wire[0:0] mux_388_nl;
  wire[0:0] and_350_nl;
  wire[0:0] nor_187_nl;
  wire[0:0] mux_389_nl;
  wire[0:0] nand_63_nl;
  wire[0:0] and_351_nl;
  wire[0:0] mux_390_nl;
  wire[0:0] mux_391_nl;
  wire[0:0] nor_188_nl;
  wire[0:0] and_352_nl;
  wire[0:0] and_353_nl;
  wire[63:0] modExp_while_if_modExp_while_if_mux1h_1_nl;
  wire[0:0] modExp_while_if_and_4_nl;
  wire[0:0] modExp_while_if_and_5_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [10:0] nl_operator_66_true_div_cmp_b;
  assign nl_operator_66_true_div_cmp_b = {1'b0, operator_66_true_div_cmp_b_9_0};
  wire[64:0] operator_64_false_acc_1_nl;
  wire[65:0] nl_operator_64_false_acc_1_nl;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_5_tr0;
  assign nl_operator_64_false_acc_1_nl = ({1'b1 , (~ (operator_66_true_div_cmp_z[63:0]))})
      + 65'b00000000000000000000000000000000000000000000000000000000000000001;
  assign operator_64_false_acc_1_nl = nl_operator_64_false_acc_1_nl[64:0];
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_5_tr0 = ~ (readslicef_65_1_64(operator_64_false_acc_1_nl));
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_1_tr0 = ~ VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_40_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_40_tr0 = ~ VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0
      = ~ VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out_3[12];
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_1_tr0 = ~ VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_40_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_40_tr0 = ~ VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0
      = ~ VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_1_tr0 = z_out_3[12];
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_6_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_6_tr0 = ~ (z_out_3[2]);
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
  mgc_rem #(.width_a(32'sd64),
  .width_b(32'sd64),
  .signd(32'sd1)) modulo_result_rem_cmp (
      .a(modulo_result_rem_cmp_a),
      .b(modulo_result_rem_cmp_b),
      .z(modulo_result_rem_cmp_z)
    );
  mgc_div #(.width_a(32'sd65),
  .width_b(32'sd11),
  .signd(32'sd1)) operator_66_true_div_cmp (
      .a(operator_66_true_div_cmp_a),
      .b(nl_operator_66_true_div_cmp_b[10:0]),
      .z(operator_66_true_div_cmp_z)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) STAGE_LOOP_lshift_rg (
      .a(1'b1),
      .s(STAGE_LOOP_i_3_0_sva),
      .z(STAGE_LOOP_lshift_psp_sva_mx0w0)
    );
  inPlaceNTT_DIT_core_core_fsm inPlaceNTT_DIT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .STAGE_LOOP_C_5_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_5_tr0[0:0]),
      .modExp_while_C_24_tr0(exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_1_COMP_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_1_tr0[0:0]),
      .VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_C_24_tr0(exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_1_COMP_LOOP_C_40_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_C_40_tr0[0:0]),
      .VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_1_COMP_LOOP_2_modExp_1_while_C_24_tr0[0:0]),
      .VEC_LOOP_1_COMP_LOOP_C_80_tr0(exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .VEC_LOOP_2_COMP_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_1_tr0[0:0]),
      .VEC_LOOP_2_COMP_LOOP_1_modExp_1_while_C_24_tr0(exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_2_COMP_LOOP_C_40_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_C_40_tr0[0:0]),
      .VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_2_COMP_LOOP_2_modExp_1_while_C_24_tr0[0:0]),
      .VEC_LOOP_2_COMP_LOOP_C_80_tr0(exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_1_tr0[0:0]),
      .STAGE_LOOP_C_6_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_6_tr0[0:0])
    );
  assign or_108_nl = (fsm_output[3]) | (fsm_output[8]) | (fsm_output[7]);
  assign mux_74_cse = MUX_s_1_2_2(or_108_nl, or_tmp_70, fsm_output[2]);
  assign or_106_nl = (fsm_output[3]) | (~ (fsm_output[8])) | (fsm_output[7]);
  assign mux_73_cse = MUX_s_1_2_2(or_tmp_70, or_106_nl, fsm_output[2]);
  assign or_99_nl = (~ (fsm_output[3])) | (~ (fsm_output[8])) | (fsm_output[7]);
  assign mux_70_cse = MUX_s_1_2_2(or_99_nl, or_tmp_70, fsm_output[2]);
  assign or_121_cse = (~ (fsm_output[5])) | (fsm_output[8]);
  assign mux_80_cse = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[8]), fsm_output[5]);
  assign nor_15_cse = ~((fsm_output[6]) | (~ (fsm_output[0])));
  assign nor_87_cse = ~((fsm_output[1:0]!=2'b00));
  assign or_64_cse = (fsm_output[4:3]!=2'b00);
  assign or_294_nl = (fsm_output[3]) | (~ and_dcpl_75);
  assign or_293_nl = (fsm_output[1]) | (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_275_nl = MUX_s_1_2_2(or_293_nl, or_tmp_131, fsm_output[3]);
  assign mux_276_nl = MUX_s_1_2_2(or_294_nl, mux_275_nl, fsm_output[6]);
  assign or_364_nl = mux_tmp_124 | and_dcpl_134;
  assign mux_317_nl = MUX_s_1_2_2(or_364_nl, mux_tmp_109, modExp_exp_1_0_1_sva);
  assign mux_315_nl = MUX_s_1_2_2(and_dcpl_72, mux_tmp_124, fsm_output[0]);
  assign mux_316_nl = MUX_s_1_2_2(or_tmp_297, mux_315_nl, modExp_exp_1_0_1_sva);
  assign mux_318_nl = MUX_s_1_2_2(mux_317_nl, mux_316_nl, fsm_output[6]);
  assign or_363_nl = (fsm_output[0]) | (~ (fsm_output[1])) | (~ (fsm_output[2]))
      | (fsm_output[7]) | (~ or_tmp);
  assign mux_nl = MUX_s_1_2_2(or_tmp_297, or_tmp_139, modExp_exp_1_0_1_sva);
  assign mux_314_nl = MUX_s_1_2_2(or_363_nl, mux_nl, fsm_output[6]);
  assign mux_319_nl = MUX_s_1_2_2(mux_318_nl, mux_314_nl, fsm_output[3]);
  assign nor_55_nl = ~((fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[2]) |
      (~ (fsm_output[7])));
  assign nor_56_nl = ~((fsm_output[0]) | (fsm_output[1]) | (~ (fsm_output[2])) |
      (fsm_output[7]));
  assign mux_253_nl = MUX_s_1_2_2(nor_55_nl, nor_56_nl, fsm_output[3]);
  assign and_144_nl = (fsm_output[3]) & (fsm_output[0]) & mux_tmp_104;
  assign mux_254_nl = MUX_s_1_2_2(mux_253_nl, and_144_nl, fsm_output[6]);
  assign nand_46_nl = ~(mux_254_nl & or_tmp);
  assign mux_320_nl = MUX_s_1_2_2(mux_319_nl, nand_46_nl, fsm_output[4]);
  assign or_nl = and_dcpl_74 | and_dcpl_78 | (~(mux_276_nl | (~ (fsm_output[5]))
      | (fsm_output[8]) | mux_320_nl));
  assign modExp_while_if_and_1_nl = modExp_while_and_3 & and_dcpl_134;
  assign modExp_while_if_and_2_nl = modExp_while_and_5 & and_dcpl_134;
  assign mux1h_nl = MUX1HOT_v_64_5_2(z_out_5, 64'b0000000000000000000000000000000000000000000000000000000000000001,
      modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w5, (z_out_3[63:0]), {or_nl , and_dcpl_116
      , modExp_while_if_and_1_nl , modExp_while_if_and_2_nl , and_dcpl_82});
  assign and_95_nl = and_dcpl_23 & and_dcpl_71 & and_dcpl_20;
  assign mux_160_nl = MUX_s_1_2_2((~ (fsm_output[8])), or_tmp_162, fsm_output[3]);
  assign mux_161_nl = MUX_s_1_2_2(mux_tmp_155, mux_160_nl, fsm_output[2]);
  assign mux_162_nl = MUX_s_1_2_2(mux_161_nl, mux_tmp_144, fsm_output[7]);
  assign mux_159_nl = MUX_s_1_2_2(mux_tmp_152, mux_tmp_150, fsm_output[7]);
  assign mux_163_nl = MUX_s_1_2_2(mux_162_nl, mux_159_nl, fsm_output[1]);
  assign mux_156_nl = MUX_s_1_2_2(mux_tmp_155, mux_tmp_152, fsm_output[2]);
  assign mux_157_nl = MUX_s_1_2_2(mux_156_nl, mux_tmp_150, fsm_output[7]);
  assign mux_151_nl = MUX_s_1_2_2((~ or_326_cse), (fsm_output[4]), fsm_output[3]);
  assign mux_153_nl = MUX_s_1_2_2(mux_tmp_152, mux_151_nl, fsm_output[2]);
  assign mux_154_nl = MUX_s_1_2_2(mux_153_nl, mux_tmp_150, fsm_output[7]);
  assign mux_158_nl = MUX_s_1_2_2(mux_157_nl, mux_154_nl, fsm_output[1]);
  assign mux_164_nl = MUX_s_1_2_2(mux_163_nl, mux_158_nl, fsm_output[0]);
  assign mux_149_nl = MUX_s_1_2_2(mux_tmp_142, mux_tmp_141, or_13_cse);
  assign mux_165_nl = MUX_s_1_2_2(mux_164_nl, mux_149_nl, fsm_output[5]);
  assign mux_146_nl = MUX_s_1_2_2((fsm_output[8]), or_tmp_162, or_189_cse);
  assign or_193_nl = (~((fsm_output[3:2]!=2'b01))) | (fsm_output[8]) | (fsm_output[4]);
  assign mux_145_nl = MUX_s_1_2_2(or_193_nl, mux_tmp_144, fsm_output[7]);
  assign mux_147_nl = MUX_s_1_2_2(mux_146_nl, mux_145_nl, and_342_cse);
  assign mux_143_nl = MUX_s_1_2_2(mux_tmp_142, mux_tmp_141, fsm_output[1]);
  assign mux_148_nl = MUX_s_1_2_2(mux_147_nl, mux_143_nl, fsm_output[5]);
  assign mux_166_nl = MUX_s_1_2_2(mux_165_nl, mux_148_nl, fsm_output[6]);
  assign operator_64_false_mux1h_2_rgt = MUX1HOT_v_65_3_2(z_out_3, ({2'b00 , operator_64_false_slc_modExp_exp_63_1_3}),
      ({1'b0 , mux1h_nl}), {and_95_nl , and_dcpl_95 , (~ mux_166_nl)});
  assign and_342_cse = (fsm_output[1:0]==2'b11);
  assign or_386_cse = (fsm_output[7:6]!=2'b00);
  assign or_425_cse = (~ (fsm_output[7])) | (fsm_output[2]);
  assign or_424_cse = (fsm_output[7]) | (~ (fsm_output[2]));
  assign and_107_m1c = and_dcpl_37 & and_dcpl_71 & and_dcpl_101;
  assign modExp_result_and_rgt = (~ modExp_while_and_5) & and_107_m1c;
  assign modExp_result_and_1_rgt = modExp_while_and_5 & and_107_m1c;
  assign or_13_cse = (fsm_output[1:0]!=2'b00);
  assign mux_14_cse = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[8]), fsm_output[7]);
  assign or_265_cse = (fsm_output[3:2]!=2'b00);
  assign or_31_cse = (~ (fsm_output[1])) | (fsm_output[7]) | (~ (fsm_output[2]));
  assign nand_44_cse = ~((fsm_output[0]) & (fsm_output[1]) & (~ (fsm_output[7]))
      & (fsm_output[2]));
  assign COMP_LOOP_or_1_cse = (and_dcpl_24 & and_dcpl_32) | (nor_tmp_14 & (~ (fsm_output[1]))
      & nor_122_cse & and_dcpl_32);
  assign or_326_cse = (~ (fsm_output[4])) | (fsm_output[8]);
  assign nor_122_cse = ~((fsm_output[0]) | (fsm_output[3]));
  assign COMP_LOOP_or_2_cse = (and_dcpl_37 & and_dcpl_36 & and_dcpl_35) | (and_dcpl_53
      & and_dcpl_28 & and_dcpl_51) | (nor_tmp_14 & (fsm_output[1]) & and_dcpl_36
      & and_dcpl_35) | (and_dcpl_24 & and_dcpl_19 & (~ (fsm_output[5])) & (fsm_output[8]));
  assign operator_64_false_slc_modExp_exp_63_1_3 = MUX_v_63_2_2((operator_66_true_div_cmp_z[63:1]),
      (tmp_2_lpi_4_dfm[63:1]), and_dcpl_105);
  assign nl_modulo_qr_sva_1_mx0w5 = modulo_result_rem_cmp_z + p_sva;
  assign modulo_qr_sva_1_mx0w5 = nl_modulo_qr_sva_1_mx0w5[63:0];
  assign modExp_base_1_sva_mx1 = MUX_v_64_2_2(modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w5,
      modulo_result_rem_cmp_z[63]);
  assign modExp_while_and_3 = (~ (modulo_result_rem_cmp_z[63])) & modExp_exp_1_0_1_sva;
  assign modExp_while_and_5 = (modulo_result_rem_cmp_z[63]) & modExp_exp_1_0_1_sva;
  assign and_202_cse = (fsm_output[4:3]==2'b11);
  assign or_74_nl = (fsm_output[0]) | (fsm_output[1]) | (fsm_output[2]) | (fsm_output[7]);
  assign mux_tmp_60 = MUX_s_1_2_2((fsm_output[7]), or_74_nl, fsm_output[3]);
  assign nor_111_nl = ~((fsm_output[7:0]!=8'b00000000));
  assign or_75_nl = (fsm_output[4]) | (fsm_output[6]) | mux_tmp_60;
  assign mux_61_nl = MUX_s_1_2_2(or_386_cse, or_75_nl, fsm_output[5]);
  assign mux_62_itm = MUX_s_1_2_2(nor_111_nl, mux_61_nl, fsm_output[8]);
  assign and_dcpl_18 = ~((fsm_output[5]) | (fsm_output[8]));
  assign and_dcpl_19 = ~((fsm_output[6]) | (fsm_output[4]));
  assign and_dcpl_20 = and_dcpl_19 & and_dcpl_18;
  assign and_dcpl_22 = ~((fsm_output[7]) | (fsm_output[2]));
  assign and_dcpl_23 = and_dcpl_22 & (~ (fsm_output[1]));
  assign and_dcpl_24 = and_dcpl_23 & nor_122_cse;
  assign and_dcpl_27 = and_dcpl_19 & (fsm_output[5]) & (fsm_output[8]);
  assign and_dcpl_28 = (~ (fsm_output[0])) & (fsm_output[3]);
  assign and_dcpl_29 = and_dcpl_23 & and_dcpl_28;
  assign and_dcpl_31 = (fsm_output[5]) & (~ (fsm_output[8]));
  assign and_dcpl_32 = and_dcpl_19 & and_dcpl_31;
  assign and_dcpl_34 = (~ (fsm_output[6])) & (fsm_output[4]);
  assign and_dcpl_35 = and_dcpl_34 & and_dcpl_31;
  assign and_dcpl_36 = (fsm_output[0]) & (fsm_output[3]);
  assign and_dcpl_37 = and_dcpl_22 & (fsm_output[1]);
  assign and_dcpl_40 = (fsm_output[6]) & (fsm_output[4]);
  assign mux_tmp_65 = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[2]);
  assign or_tmp_60 = (fsm_output[0]) | (~ mux_tmp_65);
  assign or_90_nl = (~ (fsm_output[0])) | (fsm_output[2]) | (~ (fsm_output[7]));
  assign mux_66_nl = MUX_s_1_2_2(or_90_nl, or_tmp_60, fsm_output[6]);
  assign or_87_nl = (fsm_output[6]) | (~ (fsm_output[0])) | (~ (fsm_output[2])) |
      (fsm_output[7]);
  assign mux_67_itm = MUX_s_1_2_2(mux_66_nl, or_87_nl, fsm_output[8]);
  assign nor_tmp_14 = (fsm_output[2]) & (fsm_output[7]);
  assign and_dcpl_51 = and_dcpl_40 & and_dcpl_31;
  assign and_dcpl_52 = (~ (fsm_output[7])) & (fsm_output[2]);
  assign and_dcpl_53 = and_dcpl_52 & (~ (fsm_output[1]));
  assign or_tmp_70 = (fsm_output[3]) | (fsm_output[8]) | (~ (fsm_output[7]));
  assign and_dcpl_71 = (fsm_output[0]) & (~ (fsm_output[3]));
  assign and_dcpl_72 = and_dcpl_52 & (fsm_output[1]);
  assign and_dcpl_73 = and_dcpl_72 & and_dcpl_71;
  assign and_dcpl_74 = and_dcpl_73 & and_dcpl_20;
  assign mux_tmp_104 = MUX_s_1_2_2(and_dcpl_52, mux_tmp_65, fsm_output[1]);
  assign or_tmp_127 = and_342_cse | (fsm_output[2]) | (~ (fsm_output[7]));
  assign or_tmp_131 = (fsm_output[1]) | (fsm_output[2]) | (~ (fsm_output[7]));
  assign mux_tmp_109 = MUX_s_1_2_2(and_dcpl_52, or_425_cse, and_342_cse);
  assign or_tmp_134 = (fsm_output[3]) | and_dcpl_52;
  assign mux_114_nl = MUX_s_1_2_2(and_dcpl_52, (fsm_output[2]), fsm_output[1]);
  assign mux_113_nl = MUX_s_1_2_2((fsm_output[2]), or_425_cse, fsm_output[1]);
  assign mux_tmp_115 = MUX_s_1_2_2(mux_114_nl, mux_113_nl, fsm_output[0]);
  assign or_tmp_139 = (fsm_output[0]) | (fsm_output[1]) | (fsm_output[2]) | (~ (fsm_output[7]));
  assign or_tmp_144 = (or_13_cse & (fsm_output[2])) | (fsm_output[7]);
  assign mux_tmp_124 = MUX_s_1_2_2(and_dcpl_52, or_425_cse, fsm_output[1]);
  assign and_dcpl_75 = mux_tmp_65 & (fsm_output[1]);
  assign and_dcpl_76 = and_dcpl_75 & nor_122_cse;
  assign and_dcpl_77 = and_dcpl_76 & and_dcpl_32;
  assign or_183_nl = (~ (fsm_output[7])) | (fsm_output[0]) | (~ (fsm_output[6]));
  assign or_181_nl = (fsm_output[7]) | (~ (fsm_output[0])) | (fsm_output[6]);
  assign mux_136_nl = MUX_s_1_2_2(or_183_nl, or_181_nl, fsm_output[8]);
  assign or_352_nl = (fsm_output[5:3]!=3'b000) | mux_136_nl;
  assign mux_135_nl = MUX_s_1_2_2((fsm_output[6]), (~ (fsm_output[6])), fsm_output[0]);
  assign or_353_nl = (~ (fsm_output[3])) | (~ (fsm_output[4])) | (~ (fsm_output[5]))
      | (fsm_output[8]) | (fsm_output[7]) | mux_135_nl;
  assign mux_137_nl = MUX_s_1_2_2(or_352_nl, or_353_nl, fsm_output[2]);
  assign and_dcpl_78 = ~(mux_137_nl | (fsm_output[1]));
  assign and_dcpl_82 = ~(mux_67_itm | (fsm_output[1]) | (~ (fsm_output[3])) | (fsm_output[4])
      | (fsm_output[5]));
  assign and_dcpl_84 = (fsm_output[6]) & (~ (fsm_output[4])) & and_dcpl_31;
  assign and_dcpl_86 = and_dcpl_75 & and_dcpl_71 & and_dcpl_84;
  assign and_dcpl_89 = ((fsm_output[2]) ^ (fsm_output[1])) & (~ (fsm_output[7]))
      & (~ (fsm_output[3])) & and_dcpl_20;
  assign or_185_nl = (fsm_output[4]) | (fsm_output[6]) | (fsm_output[3]) | (fsm_output[7]);
  assign mux_tmp_138 = MUX_s_1_2_2(or_386_cse, or_185_nl, fsm_output[5]);
  assign and_dcpl_92 = (fsm_output[1]) & (~ (fsm_output[6]));
  assign mux_140_nl = MUX_s_1_2_2(nor_122_cse, and_dcpl_36, fsm_output[4]);
  assign and_dcpl_95 = mux_140_nl & and_dcpl_52 & and_dcpl_92 & and_dcpl_18;
  assign or_56_nl = (fsm_output[3]) | (~ (fsm_output[7])) | (fsm_output[2]);
  assign mux_tmp_141 = MUX_s_1_2_2(or_326_cse, (fsm_output[8]), or_56_nl);
  assign or_189_cse = (~((fsm_output[7]) | (~ (fsm_output[2])))) | (fsm_output[3]);
  assign mux_tmp_142 = MUX_s_1_2_2(or_326_cse, (fsm_output[8]), or_189_cse);
  assign or_tmp_162 = (fsm_output[8]) | (fsm_output[4]);
  assign or_191_nl = (fsm_output[3]) | (fsm_output[8]);
  assign mux_tmp_144 = MUX_s_1_2_2(or_191_nl, or_tmp_162, fsm_output[2]);
  assign mux_tmp_150 = MUX_s_1_2_2((fsm_output[8]), or_tmp_162, or_265_cse);
  assign mux_tmp_152 = MUX_s_1_2_2((~ (fsm_output[8])), (fsm_output[4]), fsm_output[3]);
  assign mux_tmp_155 = MUX_s_1_2_2((~ or_tmp_162), (fsm_output[4]), fsm_output[3]);
  assign nand_40_nl = ~((fsm_output[6:2]==5'b11111));
  assign or_360_nl = (fsm_output[6:2]!=5'b00000);
  assign mux_201_nl = MUX_s_1_2_2(nand_40_nl, or_360_nl, fsm_output[8]);
  assign and_dcpl_100 = ~(mux_201_nl | (fsm_output[7]) | (fsm_output[1]) | (fsm_output[0]));
  assign or_tmp_195 = ((fsm_output[2:0]==3'b111)) | (fsm_output[7]);
  assign and_dcpl_101 = and_dcpl_34 & and_dcpl_18;
  assign and_dcpl_105 = and_dcpl_72 & and_dcpl_36 & and_dcpl_101;
  assign and_dcpl_114 = (fsm_output[4:3]==2'b00) & and_dcpl_31;
  assign nor_75_nl = ~((fsm_output[1:0]!=2'b01));
  assign nor_67_nl = ~((fsm_output[1:0]!=2'b10));
  assign mux_206_nl = MUX_s_1_2_2(nor_75_nl, nor_67_nl, fsm_output[6]);
  assign and_dcpl_116 = mux_206_nl & mux_tmp_65 & and_dcpl_114;
  assign or_tmp_204 = (fsm_output[3]) | (~((fsm_output[1:0]==2'b11) & mux_tmp_65));
  assign and_dcpl_120 = (fsm_output[0]) & (fsm_output[6]) & (fsm_output[5]);
  assign nor_109_nl = ~((~ (fsm_output[3])) | (~ (fsm_output[2])) | (fsm_output[7]));
  assign nor_110_nl = ~((fsm_output[3]) | (fsm_output[2]) | (~ (fsm_output[7])));
  assign mux_211_nl = MUX_s_1_2_2(nor_109_nl, nor_110_nl, fsm_output[4]);
  assign and_dcpl_122 = mux_211_nl & (fsm_output[1]);
  assign or_tmp_213 = (fsm_output[3]) | mux_tmp_109;
  assign or_tmp_223 = (fsm_output[1:0]!=2'b01) | (~ nor_tmp_14);
  assign or_tmp_225 = (fsm_output[1:0]!=2'b01) | (~ mux_tmp_65);
  assign and_dcpl_129 = mux_tmp_65 & (~ (fsm_output[1]));
  assign and_dcpl_131 = and_dcpl_129 & and_dcpl_71 & and_dcpl_32;
  assign and_dcpl_133 = (fsm_output[1]) & (fsm_output[5]) & (~ (fsm_output[8]));
  assign nor_61_nl = ~((fsm_output[6]) | (~ (fsm_output[3])) | (fsm_output[0]) |
      (~ (fsm_output[2])) | (fsm_output[7]));
  assign nor_62_nl = ~((fsm_output[3]) | (fsm_output[0]) | (fsm_output[2]) | (~ (fsm_output[7])));
  assign and_141_nl = (fsm_output[3]) & (fsm_output[0]) & mux_tmp_65;
  assign mux_225_nl = MUX_s_1_2_2(nor_62_nl, and_141_nl, fsm_output[6]);
  assign mux_226_nl = MUX_s_1_2_2(nor_61_nl, mux_225_nl, fsm_output[4]);
  assign and_dcpl_134 = mux_226_nl & and_dcpl_133;
  assign mux_tmp_227 = MUX_s_1_2_2((~ or_64_cse), and_202_cse, or_425_cse);
  assign mux_228_nl = MUX_s_1_2_2(or_64_cse, (~ and_202_cse), fsm_output[2]);
  assign mux_tmp_229 = MUX_s_1_2_2(mux_228_nl, or_64_cse, fsm_output[7]);
  assign or_tmp_235 = (fsm_output[4:3]!=2'b01);
  assign and_dcpl_145 = and_dcpl_75 & and_dcpl_36;
  assign or_323_nl = (fsm_output[4]) | (~ (fsm_output[8]));
  assign mux_289_nl = MUX_s_1_2_2(or_323_nl, or_tmp_162, fsm_output[7]);
  assign mux_tmp_290 = MUX_s_1_2_2(mux_289_nl, (fsm_output[8]), fsm_output[5]);
  assign mux_291_nl = MUX_s_1_2_2((~ (fsm_output[8])), or_tmp_162, fsm_output[7]);
  assign mux_tmp_292 = MUX_s_1_2_2(mux_291_nl, (fsm_output[8]), fsm_output[5]);
  assign or_325_nl = (~((~ (fsm_output[7])) | (fsm_output[4]))) | (fsm_output[8]);
  assign mux_295_nl = MUX_s_1_2_2(mux_14_cse, or_325_nl, fsm_output[5]);
  assign mux_tmp_296 = MUX_s_1_2_2(mux_295_nl, mux_tmp_290, fsm_output[3]);
  assign and_tmp_9 = (fsm_output[3]) & mux_tmp_109;
  assign nor_53_nl = ~((fsm_output[6]) | (fsm_output[3]) | (fsm_output[0]));
  assign and_171_nl = (fsm_output[6]) & (fsm_output[3]) & (fsm_output[0]);
  assign mux_307_nl = MUX_s_1_2_2(nor_53_nl, and_171_nl, fsm_output[4]);
  assign and_dcpl_153 = mux_307_nl & mux_tmp_65 & and_dcpl_133;
  assign and_dcpl_157 = and_dcpl_76 & and_dcpl_84;
  assign mux_310_nl = MUX_s_1_2_2(or_tmp_213, (~ and_tmp_9), fsm_output[4]);
  assign and_dcpl_158 = mux_310_nl & and_dcpl_31;
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_29 & and_dcpl_27;
  assign VEC_LOOP_j_1_12_0_sva_11_0_mx0c1 = and_dcpl_73 & and_dcpl_27;
  assign nor_69_nl = ~((fsm_output[6:3]!=4'b0000) | or_tmp_195);
  assign modExp_result_sva_mx0c0 = MUX_s_1_2_2(nor_69_nl, mux_tmp_138, fsm_output[8]);
  assign VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c0
      = and_dcpl_129 & nor_122_cse & and_dcpl_32;
  assign VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c1
      = and_dcpl_145 & and_dcpl_35;
  assign or_232_nl = (~ (fsm_output[0])) | (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_205_nl = MUX_s_1_2_2(or_232_nl, or_tmp_60, fsm_output[5]);
  assign and_116_m1c = (~ mux_205_nl) & (fsm_output[1]) & (fsm_output[3]) & (~ (fsm_output[6]))
      & (fsm_output[4]) & (~ (fsm_output[8]));
  assign mux_64_nl = MUX_s_1_2_2(or_424_cse, or_425_cse, fsm_output[3]);
  assign and_47_nl = (~ mux_64_nl) & (fsm_output[1:0]==2'b00) & and_dcpl_40 & and_dcpl_18;
  assign nor_151_nl = ~(mux_67_itm | (fsm_output[1]) | (fsm_output[3]) | (fsm_output[4])
      | (~ (fsm_output[5])));
  assign nor_106_nl = ~((~ (fsm_output[4])) | (fsm_output[6]) | (fsm_output[3]) |
      (~ nor_tmp_14));
  assign nor_107_nl = ~((fsm_output[4]) | (~ (fsm_output[6])) | (fsm_output[3]) |
      (~ mux_tmp_65));
  assign mux_68_nl = MUX_s_1_2_2(nor_106_nl, nor_107_nl, fsm_output[5]);
  assign nor_108_nl = ~((fsm_output[7:2]!=6'b000110));
  assign mux_69_nl = MUX_s_1_2_2(mux_68_nl, nor_108_nl, fsm_output[8]);
  assign and_53_nl = mux_69_nl & (fsm_output[1:0]==2'b01);
  assign vec_rsc_0_0_i_adra_d_pff = MUX1HOT_v_11_5_2(z_out_2, (z_out_3[12:2]), COMP_LOOP_acc_psp_1_sva,
      (COMP_LOOP_acc_10_cse_12_1_1_sva[11:1]), (COMP_LOOP_acc_1_cse_2_sva[11:1]),
      {COMP_LOOP_or_1_cse , COMP_LOOP_or_2_cse , and_47_nl , nor_151_nl , and_53_nl});
  assign vec_rsc_0_0_i_da_d_pff = modExp_base_1_sva_mx1;
  assign nand_2_nl = ~((fsm_output[6]) & (~ mux_74_cse));
  assign or_107_nl = (fsm_output[6]) | mux_73_cse;
  assign mux_75_nl = MUX_s_1_2_2(nand_2_nl, or_107_nl, fsm_output[0]);
  assign or_355_nl = (~ (fsm_output[5])) | (COMP_LOOP_acc_10_cse_12_1_1_sva[0]) |
      mux_75_nl;
  assign nor_104_nl = ~((~ (fsm_output[3])) | (reg_VEC_LOOP_1_acc_1_psp_ftd_1[0])
      | (fsm_output[8:7]!=2'b01));
  assign nor_105_nl = ~((VEC_LOOP_j_1_12_0_sva_11_0[0]) | (fsm_output[3]) | (fsm_output[8])
      | (fsm_output[7]));
  assign mux_71_nl = MUX_s_1_2_2(nor_104_nl, nor_105_nl, fsm_output[2]);
  assign nand_1_nl = ~((fsm_output[6]) & mux_71_nl);
  assign or_100_nl = (fsm_output[6]) | (COMP_LOOP_acc_1_cse_2_sva[0]) | mux_70_cse;
  assign mux_72_nl = MUX_s_1_2_2(nand_1_nl, or_100_nl, fsm_output[0]);
  assign or_356_nl = (fsm_output[5]) | mux_72_nl;
  assign mux_76_nl = MUX_s_1_2_2(or_355_nl, or_356_nl, fsm_output[4]);
  assign vec_rsc_0_0_i_wea_d_pff = ~(mux_76_nl | (fsm_output[1]));
  assign mux_81_nl = MUX_s_1_2_2(mux_80_cse, or_121_cse, z_out_3[1]);
  assign or_122_nl = (fsm_output[7]) | mux_81_nl;
  assign or_120_nl = (fsm_output[7]) | (z_out_3[1]) | (fsm_output[5]) | (~ (fsm_output[8]));
  assign mux_82_nl = MUX_s_1_2_2(or_122_nl, or_120_nl, VEC_LOOP_j_1_12_0_sva_11_0[0]);
  assign or_118_nl = (reg_VEC_LOOP_1_acc_1_psp_ftd_1[0]) | (~ (fsm_output[7])) |
      (~ (fsm_output[5])) | (fsm_output[8]);
  assign mux_83_nl = MUX_s_1_2_2(mux_82_nl, or_118_nl, fsm_output[2]);
  assign or_123_nl = (fsm_output[0]) | mux_83_nl;
  assign or_116_nl = (fsm_output[7]) | (~ (fsm_output[5])) | (fsm_output[8]);
  assign or_115_nl = (~ (fsm_output[7])) | (~ (fsm_output[5])) | (fsm_output[8]);
  assign mux_79_nl = MUX_s_1_2_2(or_116_nl, or_115_nl, fsm_output[2]);
  assign or_117_nl = (~ (fsm_output[0])) | (~ VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm)
      | (COMP_LOOP_acc_1_cse_2_sva[0]) | mux_79_nl;
  assign mux_84_nl = MUX_s_1_2_2(or_123_nl, or_117_nl, fsm_output[6]);
  assign nor_98_nl = ~((fsm_output[4]) | (fsm_output[1]) | mux_84_nl);
  assign nor_99_nl = ~((~ (fsm_output[6])) | (fsm_output[0]) | (~ (fsm_output[2]))
      | (z_out_3[1]) | (fsm_output[7]) | (~ (fsm_output[5])) | (fsm_output[8]));
  assign nor_100_nl = ~((z_out_3[1]) | (fsm_output[7]) | (~ (fsm_output[5])) | (fsm_output[8]));
  assign nor_101_nl = ~((z_out_3[1]) | (~ (fsm_output[7])) | (~ (fsm_output[5]))
      | (fsm_output[8]));
  assign mux_77_nl = MUX_s_1_2_2(nor_100_nl, nor_101_nl, fsm_output[2]);
  assign and_196_nl = nor_15_cse & mux_77_nl;
  assign mux_78_nl = MUX_s_1_2_2(nor_99_nl, and_196_nl, fsm_output[1]);
  assign and_195_nl = (fsm_output[4]) & mux_78_nl;
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = MUX_s_1_2_2(nor_98_nl,
      and_195_nl, fsm_output[3]);
  assign and_194_nl = (fsm_output[6]) & (~ mux_74_cse);
  assign nor_94_nl = ~((fsm_output[6]) | mux_73_cse);
  assign mux_91_nl = MUX_s_1_2_2(and_194_nl, nor_94_nl, fsm_output[0]);
  assign nand_34_nl = ~((fsm_output[5]) & (COMP_LOOP_acc_10_cse_12_1_1_sva[0]) &
      mux_91_nl);
  assign and_208_nl = (fsm_output[3]) & (reg_VEC_LOOP_1_acc_1_psp_ftd_1[0]) & (fsm_output[8:7]==2'b01);
  assign nor_97_nl = ~((~ (VEC_LOOP_j_1_12_0_sva_11_0[0])) | (fsm_output[3]) | (fsm_output[8])
      | (fsm_output[7]));
  assign mux_87_nl = MUX_s_1_2_2(and_208_nl, nor_97_nl, fsm_output[2]);
  assign nand_6_nl = ~((fsm_output[6]) & mux_87_nl);
  assign or_346_nl = (fsm_output[6]) | (~ (COMP_LOOP_acc_1_cse_2_sva[0])) | mux_70_cse;
  assign mux_88_nl = MUX_s_1_2_2(nand_6_nl, or_346_nl, fsm_output[0]);
  assign or_354_nl = (fsm_output[5]) | mux_88_nl;
  assign mux_92_nl = MUX_s_1_2_2(nand_34_nl, or_354_nl, fsm_output[4]);
  assign vec_rsc_0_1_i_wea_d_pff = ~(mux_92_nl | (fsm_output[1]));
  assign or_145_nl = (fsm_output[7]) | (~ (z_out_3[1])) | (fsm_output[5]) | (~ (fsm_output[8]));
  assign mux_97_nl = MUX_s_1_2_2(or_121_cse, mux_80_cse, z_out_3[1]);
  assign or_143_nl = (fsm_output[7]) | mux_97_nl;
  assign mux_98_nl = MUX_s_1_2_2(or_145_nl, or_143_nl, VEC_LOOP_j_1_12_0_sva_11_0[0]);
  assign nand_30_nl = ~((reg_VEC_LOOP_1_acc_1_psp_ftd_1[0]) & (fsm_output[7]) & (fsm_output[5])
      & (~ (fsm_output[8])));
  assign mux_99_nl = MUX_s_1_2_2(mux_98_nl, nand_30_nl, fsm_output[2]);
  assign or_146_nl = (fsm_output[0]) | mux_99_nl;
  assign nor_90_nl = ~((fsm_output[7]) | (~ (fsm_output[5])) | (fsm_output[8]));
  assign nor_91_nl = ~((~ (fsm_output[7])) | (~ (fsm_output[5])) | (fsm_output[8]));
  assign mux_95_nl = MUX_s_1_2_2(nor_90_nl, nor_91_nl, fsm_output[2]);
  assign nand_11_nl = ~((fsm_output[0]) & VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm
      & (COMP_LOOP_acc_1_cse_2_sva[0]) & mux_95_nl);
  assign mux_100_nl = MUX_s_1_2_2(or_146_nl, nand_11_nl, fsm_output[6]);
  assign nor_89_nl = ~((fsm_output[4]) | (fsm_output[1]) | mux_100_nl);
  assign nor_92_nl = ~((~ (fsm_output[6])) | (fsm_output[0]) | (~ (fsm_output[2]))
      | (~ (z_out_3[1])) | (fsm_output[7]) | (~ (fsm_output[5])) | (fsm_output[8]));
  assign nor_93_nl = ~((~ (z_out_3[1])) | (fsm_output[7]) | (~ (fsm_output[5])) |
      (fsm_output[8]));
  assign and_192_nl = (z_out_3[1]) & (fsm_output[7]) & (fsm_output[5]) & (~ (fsm_output[8]));
  assign mux_93_nl = MUX_s_1_2_2(nor_93_nl, and_192_nl, fsm_output[2]);
  assign and_191_nl = nor_15_cse & mux_93_nl;
  assign mux_94_nl = MUX_s_1_2_2(nor_92_nl, and_191_nl, fsm_output[1]);
  assign and_190_nl = (fsm_output[4]) & mux_94_nl;
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = MUX_s_1_2_2(nor_89_nl,
      and_190_nl, fsm_output[3]);
  assign or_tmp = modExp_exp_1_0_1_sva | (~ and_dcpl_134);
  assign or_tmp_297 = or_tmp_213 | and_dcpl_134;
  assign and_dcpl_160 = (fsm_output[1]) & (fsm_output[5]);
  assign xor_dcpl = ~((fsm_output[7]) ^ (fsm_output[2]));
  assign and_dcpl_165 = (~ (fsm_output[8])) & (fsm_output[4]) & (fsm_output[3]) &
      xor_dcpl & and_dcpl_160 & (fsm_output[0]) & (~ (fsm_output[6]));
  assign and_dcpl_170 = ~((fsm_output[8]) | (fsm_output[4]) | (fsm_output[3]) | (~
      xor_dcpl));
  assign and_dcpl_171 = and_dcpl_170 & and_dcpl_160 & (fsm_output[0]) & (fsm_output[6]);
  assign or_383_nl = (fsm_output[5]) | (fsm_output[2]) | (fsm_output[3]) | (fsm_output[4])
      | (~ (fsm_output[8]));
  assign nand_56_nl = ~((fsm_output[5]) & (fsm_output[2]) & (fsm_output[3]) & (fsm_output[4])
      & (~ (fsm_output[8])));
  assign mux_336_nl = MUX_s_1_2_2(or_383_nl, nand_56_nl, fsm_output[6]);
  assign and_dcpl_174 = ~(mux_336_nl | (fsm_output[7]) | (fsm_output[1]) | (fsm_output[0]));
  assign and_dcpl_177 = and_dcpl_170 & and_dcpl_160 & (~ (fsm_output[0])) & (~ (fsm_output[6]));
  assign and_dcpl_200 = ~((fsm_output[0]) | (fsm_output[6]));
  assign and_dcpl_201 = (~ (fsm_output[1])) & (fsm_output[5]);
  assign and_dcpl_202 = and_dcpl_201 & and_dcpl_200;
  assign and_dcpl_203 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_204 = and_dcpl_203 & (~ (fsm_output[8]));
  assign and_dcpl_206 = and_dcpl_204 & xor_dcpl & and_dcpl_202;
  assign and_dcpl_207 = ~((fsm_output[1]) | (fsm_output[5]));
  assign and_dcpl_208 = (fsm_output[4:3]==2'b01);
  assign or_tmp_306 = (fsm_output[8:7]!=2'b01);
  assign or_373_nl = (fsm_output[8:7]!=2'b10);
  assign mux_326_nl = MUX_s_1_2_2(or_tmp_306, or_373_nl, fsm_output[2]);
  assign and_nl = (fsm_output[0]) & (~ mux_326_nl);
  assign or_371_nl = (fsm_output[8:7]!=2'b00);
  assign mux_325_nl = MUX_s_1_2_2(or_371_nl, or_tmp_306, fsm_output[2]);
  assign nor_147_nl = ~((fsm_output[0]) | mux_325_nl);
  assign mux_327_nl = MUX_s_1_2_2(and_nl, nor_147_nl, fsm_output[6]);
  assign and_dcpl_210 = mux_327_nl & and_dcpl_208 & and_dcpl_207;
  assign and_dcpl_211 = (fsm_output[0]) & (~ (fsm_output[6]));
  assign and_dcpl_215 = and_dcpl_204 & and_dcpl_22 & and_dcpl_207 & and_dcpl_211;
  assign and_dcpl_220 = and_dcpl_204 & and_dcpl_52 & (fsm_output[1]) & (~ (fsm_output[5]))
      & and_dcpl_211;
  assign and_dcpl_222 = (fsm_output[1]) & (fsm_output[5]) & and_dcpl_211;
  assign and_dcpl_224 = (fsm_output[4]) & (fsm_output[3]) & (~ (fsm_output[8]));
  assign and_dcpl_226 = and_dcpl_224 & and_dcpl_22 & and_dcpl_222;
  assign and_dcpl_230 = and_dcpl_224 & and_dcpl_52 & and_dcpl_201 & (~ (fsm_output[0]))
      & (fsm_output[6]);
  assign and_dcpl_233 = and_dcpl_224 & (fsm_output[7]) & (fsm_output[2]) & and_dcpl_222;
  assign and_dcpl_235 = and_dcpl_203 & (fsm_output[8]);
  assign and_dcpl_237 = and_dcpl_235 & and_dcpl_22 & and_dcpl_207 & and_dcpl_200;
  assign and_dcpl_240 = and_dcpl_204 & (fsm_output[7]) & (~ (fsm_output[2])) & and_dcpl_222;
  assign and_dcpl_242 = and_dcpl_235 & and_dcpl_52 & and_dcpl_222;
  assign and_dcpl_245 = and_dcpl_208 & (fsm_output[8]) & and_dcpl_22 & and_dcpl_202;
  assign nand_cse = ~((fsm_output[4:3]==2'b11));
  assign or_tmp_311 = (~ (fsm_output[5])) | (~ (fsm_output[2])) | (fsm_output[7])
      | (fsm_output[8]) | nand_cse;
  assign or_377_nl = (fsm_output[5]) | (fsm_output[2]) | (fsm_output[7]) | (~ (fsm_output[8]))
      | (fsm_output[3]) | (fsm_output[4]);
  assign mux_329_nl = MUX_s_1_2_2(or_tmp_311, or_377_nl, fsm_output[0]);
  assign or_376_nl = (fsm_output[5]) | (fsm_output[2]) | (~ (fsm_output[7])) | (fsm_output[8])
      | (fsm_output[3]) | (fsm_output[4]);
  assign mux_328_nl = MUX_s_1_2_2(or_376_nl, or_tmp_311, fsm_output[0]);
  assign mux_330_nl = MUX_s_1_2_2(mux_329_nl, mux_328_nl, fsm_output[6]);
  assign and_dcpl_265 = ~(mux_330_nl | (fsm_output[1]));
  assign and_dcpl_266 = ~((fsm_output[4]) | (fsm_output[8]));
  assign or_tmp_315 = (fsm_output[7]) | (fsm_output[3]);
  assign or_378_nl = (~ (fsm_output[7])) | (fsm_output[3]);
  assign mux_331_itm = MUX_s_1_2_2(or_tmp_315, or_378_nl, fsm_output[2]);
  assign mux_338_nl = MUX_s_1_2_2(or_326_cse, (fsm_output[8]), or_13_cse);
  assign mux_337_nl = MUX_s_1_2_2(or_326_cse, (fsm_output[8]), fsm_output[1]);
  assign mux_tmp_337 = MUX_s_1_2_2(mux_338_nl, mux_337_nl, fsm_output[6]);
  assign or_tmp_325 = and_342_cse | (fsm_output[8]) | (fsm_output[4]);
  assign nor_177_nl = ~((fsm_output[1]) | (fsm_output[4]) | (fsm_output[8]) | (fsm_output[5]));
  assign and_343_nl = modExp_exp_1_0_1_sva & (fsm_output[1]) & (fsm_output[4]) &
      (~ (fsm_output[8])) & (fsm_output[5]);
  assign mux_360_nl = MUX_s_1_2_2(nor_177_nl, and_343_nl, fsm_output[0]);
  assign nand_tmp = ~((fsm_output[6]) & mux_360_nl);
  assign or_tmp_344 = (fsm_output[0]) | (~ modExp_exp_1_0_1_sva) | (fsm_output[1])
      | (fsm_output[4]) | (fsm_output[8]) | (~ (fsm_output[5]));
  assign or_tmp_347 = (fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[4]) | (fsm_output[8])
      | (~ (fsm_output[5]));
  assign or_tmp_351 = (~ modExp_exp_1_0_1_sva) | (~ (fsm_output[1])) | (fsm_output[4])
      | (fsm_output[8]) | (~ (fsm_output[5]));
  assign operator_64_false_1_nor_itm = ~(and_dcpl_226 | and_dcpl_230 | and_dcpl_233
      | and_dcpl_237 | and_dcpl_240 | and_dcpl_242 | and_dcpl_245);
  assign operator_64_false_1_nor_3_itm = ~(and_dcpl_206 | and_dcpl_220 | and_dcpl_226
      | and_dcpl_230 | and_dcpl_233 | and_dcpl_237 | and_dcpl_240 | and_dcpl_242
      | and_dcpl_245);
  assign operator_64_false_1_or_5_itm = and_dcpl_226 | and_dcpl_230;
  assign operator_64_false_1_or_6_itm = and_dcpl_233 | and_dcpl_237;
  always @(posedge clk) begin
    if ( mux_62_itm ) begin
      p_sva <= p_rsci_idat;
      r_sva <= r_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( (and_dcpl_24 & and_dcpl_20) | STAGE_LOOP_i_3_0_sva_mx0c1 ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, (z_out_1[3:0]), STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= 1'b0;
      modExp_exp_1_0_1_sva <= 1'b0;
      modExp_exp_1_1_1_sva <= 1'b0;
      modExp_exp_1_7_1_sva <= 1'b0;
    end
    else begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= and_dcpl_29 & and_dcpl_19 & (fsm_output[5])
          & (fsm_output[8]) & (~ (z_out_3[2]));
      modExp_exp_1_0_1_sva <= (COMP_LOOP_mux1h_13_nl & (~ and_dcpl_131)) | mux_250_nl
          | (fsm_output[8]);
      modExp_exp_1_1_1_sva <= COMP_LOOP_mux1h_22_nl & (~(and_dcpl_75 & and_dcpl_28
          & and_dcpl_35));
      modExp_exp_1_7_1_sva <= COMP_LOOP_mux1h_39_nl & (~(and_dcpl_145 & and_dcpl_51));
    end
  end
  always @(posedge clk) begin
    modulo_result_rem_cmp_a <= MUX1HOT_v_64_4_2(z_out_5, operator_64_false_acc_mut_63_0,
        VEC_LOOP_1_COMP_LOOP_1_acc_8_itm, (z_out_3[63:0]), {modulo_result_or_nl ,
        (~ mux_122_nl) , (~ mux_134_nl) , and_dcpl_82});
    modulo_result_rem_cmp_b <= p_sva;
    operator_66_true_div_cmp_a <= MUX_v_65_2_2(z_out_3, ({operator_64_false_acc_mut_64
        , operator_64_false_acc_mut_63_0}), and_dcpl_89);
    operator_66_true_div_cmp_b_9_0 <= MUX_v_10_2_2(STAGE_LOOP_lshift_psp_sva_mx0w0,
        STAGE_LOOP_lshift_psp_sva, and_dcpl_89);
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(nor_82_nl, mux_tmp_138, fsm_output[8]) ) begin
      STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~ mux_359_nl ) begin
      operator_64_false_acc_mut_64 <= operator_64_false_mux1h_2_rgt[64];
    end
  end
  always @(posedge clk) begin
    if ( ~ mux_379_nl ) begin
      operator_64_false_acc_mut_63_0 <= operator_64_false_mux1h_2_rgt[63:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_1_12_0_sva_11_0 <= 12'b000000000000;
    end
    else if ( and_dcpl_95 | VEC_LOOP_j_1_12_0_sva_11_0_mx0c1 ) begin
      VEC_LOOP_j_1_12_0_sva_11_0 <= MUX_v_12_2_2(12'b000000000000, (z_out_3[11:0]),
          VEC_LOOP_j_1_12_0_sva_11_0_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_k_9_1_1_sva_7_0 <= 8'b00000000;
    end
    else if ( MUX_s_1_2_2(mux_383_nl, nor_176_nl, fsm_output[1]) ) begin
      COMP_LOOP_k_9_1_1_sva_7_0 <= MUX_v_8_2_2(8'b00000000, (z_out_1[7:0]), nand_55_nl);
    end
  end
  always @(posedge clk) begin
    if ( (modExp_while_and_3 | modExp_while_and_5 | modExp_result_sva_mx0c0 | (~
        mux_204_nl)) & (modExp_result_sva_mx0c0 | modExp_result_and_rgt | modExp_result_and_1_rgt)
        ) begin
      modExp_result_sva <= MUX1HOT_v_64_3_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
          modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w5, {modExp_result_sva_mx0c0
          , modExp_result_and_rgt , modExp_result_and_1_rgt});
    end
  end
  always @(posedge clk) begin
    if ( mux_210_nl | (fsm_output[8]) ) begin
      modExp_base_1_sva <= MUX1HOT_v_64_4_2(r_sva, modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w5,
          modExp_result_sva, {and_111_nl , r_or_nl , r_or_1_nl , and_dcpl_116});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      tmp_2_lpi_4_dfm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~ mux_218_nl ) begin
      tmp_2_lpi_4_dfm <= MUX1HOT_v_64_3_2(({1'b0 , operator_64_false_slc_modExp_exp_63_1_3}),
          vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, {and_dcpl_95 , and_134_nl , and_135_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva <= 1'b0;
    end
    else if ( and_dcpl_74 | and_dcpl_77 | and_dcpl_100 ) begin
      exit_VEC_LOOP_1_COMP_LOOP_1_modExp_1_while_sva <= MUX1HOT_s_1_3_2((~ (z_out_3[63])),
          (~ (z_out[8])), (~ (readslicef_10_1_9(VEC_LOOP_1_COMP_LOOP_1_acc_11_nl))),
          {and_dcpl_74 , and_dcpl_77 , and_dcpl_100});
    end
  end
  always @(posedge clk) begin
    if ( (~(mux_281_nl | (fsm_output[4]) | (fsm_output[8]))) | and_dcpl_82 ) begin
      VEC_LOOP_1_COMP_LOOP_1_acc_8_itm <= MUX_v_64_2_2(z_out_5, VEC_LOOP_1_COMP_LOOP_1_acc_8_nl,
          and_dcpl_82);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_or_1_cse ) begin
      COMP_LOOP_acc_psp_1_sva <= z_out_2;
    end
  end
  always @(posedge clk) begin
    if ( VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c0
        | VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c1
        | and_dcpl_86 ) begin
      VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm
          <= MUX1HOT_s_1_3_2((z_out_3[9]), (z_out[9]), (z_out[8]), {VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c0
          , VEC_LOOP_1_COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm_mx0c1
          , and_dcpl_86});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_1_cse_2_sva <= 12'b000000000000;
    end
    else if ( MUX_s_1_2_2(mux_301_nl, (fsm_output[8]), fsm_output[6]) ) begin
      COMP_LOOP_acc_1_cse_2_sva <= nl_COMP_LOOP_acc_1_cse_2_sva[11:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_0_1_sva_1 <= 1'b0;
    end
    else if ( ~(mux_306_nl & and_dcpl_31) ) begin
      modExp_exp_1_0_1_sva_1 <= MUX_s_1_2_2((COMP_LOOP_k_9_1_1_sva_7_0[0]), modExp_exp_1_1_1_sva,
          and_161_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_2_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_158 ) begin
      modExp_exp_1_2_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_1_sva_7_0[1]), modExp_exp_1_3_1_sva,
          (COMP_LOOP_k_9_1_1_sva_7_0[2]), {and_dcpl_131 , and_dcpl_153 , and_dcpl_157});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_3_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_158 ) begin
      modExp_exp_1_3_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_1_sva_7_0[2]), modExp_exp_1_4_1_sva,
          (COMP_LOOP_k_9_1_1_sva_7_0[3]), {and_dcpl_131 , and_dcpl_153 , and_dcpl_157});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_4_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_158 ) begin
      modExp_exp_1_4_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_1_sva_7_0[3]), modExp_exp_1_5_1_sva,
          (COMP_LOOP_k_9_1_1_sva_7_0[4]), {and_dcpl_131 , and_dcpl_153 , and_dcpl_157});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_5_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_158 ) begin
      modExp_exp_1_5_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_1_sva_7_0[4]), modExp_exp_1_6_1_sva,
          (COMP_LOOP_k_9_1_1_sva_7_0[5]), {and_dcpl_131 , and_dcpl_153 , and_dcpl_157});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_6_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_158 ) begin
      modExp_exp_1_6_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_1_sva_7_0[5]), modExp_exp_1_7_1_sva,
          (COMP_LOOP_k_9_1_1_sva_7_0[6]), {and_dcpl_131 , and_dcpl_153 , and_dcpl_157});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_10_cse_12_1_1_sva <= 12'b000000000000;
    end
    else if ( COMP_LOOP_or_2_cse ) begin
      COMP_LOOP_acc_10_cse_12_1_1_sva <= z_out_3[12:1];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_VEC_LOOP_1_acc_1_psp_ftd_1 <= 12'b000000000000;
    end
    else if ( ~((~ (fsm_output[1])) | (fsm_output[2]) | (~ (fsm_output[7])) | (~
        (fsm_output[0])) | (fsm_output[3]) | (fsm_output[6]) | (fsm_output[4]) |
        or_121_cse) ) begin
      reg_VEC_LOOP_1_acc_1_psp_ftd_1 <= z_out_3[11:0];
    end
  end
  assign modulo_result_or_nl = and_dcpl_74 | and_dcpl_77 | and_dcpl_78 | and_dcpl_86;
  assign or_169_nl = (~ (fsm_output[0])) | (fsm_output[1]) | (fsm_output[2]) | (~
      (fsm_output[7]));
  assign mux_118_nl = MUX_s_1_2_2((fsm_output[7]), or_169_nl, fsm_output[3]);
  assign or_165_nl = (fsm_output[1:0]!=2'b00) | (~ mux_tmp_65);
  assign mux_117_nl = MUX_s_1_2_2(or_tmp_139, or_165_nl, fsm_output[3]);
  assign mux_119_nl = MUX_s_1_2_2(mux_118_nl, mux_117_nl, fsm_output[6]);
  assign or_163_nl = (fsm_output[3]) | mux_tmp_115;
  assign mux_116_nl = MUX_s_1_2_2(or_163_nl, or_tmp_134, fsm_output[6]);
  assign mux_120_nl = MUX_s_1_2_2((~ mux_119_nl), mux_116_nl, fsm_output[4]);
  assign mux_110_nl = MUX_s_1_2_2(mux_tmp_109, or_31_cse, fsm_output[3]);
  assign nand_29_nl = ~((fsm_output[3]) & (fsm_output[0]) & (fsm_output[1]) & (fsm_output[2])
      & (~ (fsm_output[7])));
  assign mux_111_nl = MUX_s_1_2_2((~ mux_110_nl), nand_29_nl, fsm_output[6]);
  assign or_157_nl = nor_87_cse | (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_107_nl = MUX_s_1_2_2(or_tmp_131, or_157_nl, fsm_output[3]);
  assign mux_105_nl = MUX_s_1_2_2(and_dcpl_53, mux_tmp_104, fsm_output[0]);
  assign mux_106_nl = MUX_s_1_2_2((~ or_tmp_127), mux_105_nl, fsm_output[3]);
  assign mux_108_nl = MUX_s_1_2_2(mux_107_nl, mux_106_nl, fsm_output[6]);
  assign mux_112_nl = MUX_s_1_2_2(mux_111_nl, mux_108_nl, fsm_output[4]);
  assign mux_121_nl = MUX_s_1_2_2(mux_120_nl, mux_112_nl, fsm_output[5]);
  assign or_151_nl = (~((fsm_output[2:1]!=2'b00))) | (fsm_output[7]);
  assign or_149_nl = (~((fsm_output[2:0]!=3'b101))) | (fsm_output[7]);
  assign mux_102_nl = MUX_s_1_2_2(or_151_nl, or_149_nl, fsm_output[3]);
  assign or_152_nl = (fsm_output[6]) | mux_102_nl;
  assign or_148_nl = (fsm_output[6]) | mux_tmp_60;
  assign mux_103_nl = MUX_s_1_2_2(or_152_nl, or_148_nl, fsm_output[4]);
  assign or_153_nl = (fsm_output[5]) | mux_103_nl;
  assign mux_122_nl = MUX_s_1_2_2(mux_121_nl, or_153_nl, fsm_output[8]);
  assign mux_131_nl = MUX_s_1_2_2(mux_tmp_115, nand_44_cse, fsm_output[3]);
  assign mux_132_nl = MUX_s_1_2_2(mux_131_nl, or_tmp_134, fsm_output[6]);
  assign nand_27_nl = ~((fsm_output[4]) & mux_132_nl);
  assign mux_128_nl = MUX_s_1_2_2(or_tmp_139, or_31_cse, fsm_output[3]);
  assign mux_127_nl = MUX_s_1_2_2(mux_tmp_65, (~ nand_44_cse), fsm_output[3]);
  assign mux_129_nl = MUX_s_1_2_2(mux_128_nl, mux_127_nl, fsm_output[6]);
  assign mux_125_nl = MUX_s_1_2_2((~ or_tmp_131), mux_tmp_124, fsm_output[3]);
  assign or_176_nl = (fsm_output[3]) | or_tmp_127;
  assign mux_126_nl = MUX_s_1_2_2(mux_125_nl, or_176_nl, fsm_output[6]);
  assign mux_130_nl = MUX_s_1_2_2(mux_129_nl, mux_126_nl, fsm_output[4]);
  assign mux_133_nl = MUX_s_1_2_2(nand_27_nl, mux_130_nl, fsm_output[5]);
  assign nand_12_nl = ~((~((~ (fsm_output[4])) | (fsm_output[6]) | (~ (fsm_output[3]))))
      & (~((~((fsm_output[2:0]!=3'b000))) | (fsm_output[7]))));
  assign or_173_nl = (fsm_output[4]) | (fsm_output[6]) | (fsm_output[3]) | or_tmp_144;
  assign mux_123_nl = MUX_s_1_2_2(nand_12_nl, or_173_nl, fsm_output[5]);
  assign mux_134_nl = MUX_s_1_2_2(mux_133_nl, mux_123_nl, fsm_output[8]);
  assign COMP_LOOP_and_3_nl = (~ and_dcpl_105) & and_dcpl_95;
  assign mux_236_nl = MUX_s_1_2_2((~ (fsm_output[3])), (fsm_output[3]), fsm_output[4]);
  assign mux_237_nl = MUX_s_1_2_2(mux_236_nl, or_tmp_235, fsm_output[2]);
  assign nor_59_nl = ~((fsm_output[7]) | mux_237_nl);
  assign mux_235_nl = MUX_s_1_2_2(or_tmp_235, (fsm_output[4]), fsm_output[2]);
  assign nor_60_nl = ~((fsm_output[7]) | mux_235_nl);
  assign mux_238_nl = MUX_s_1_2_2(nor_59_nl, nor_60_nl, and_342_cse);
  assign nand_23_nl = ~((fsm_output[3:2]==2'b11));
  assign mux_232_nl = MUX_s_1_2_2(nand_23_nl, or_265_cse, fsm_output[7]);
  assign mux_233_nl = MUX_s_1_2_2(mux_tmp_229, mux_232_nl, fsm_output[1]);
  assign mux_231_nl = MUX_s_1_2_2(mux_tmp_229, (~ mux_tmp_227), fsm_output[1]);
  assign mux_234_nl = MUX_s_1_2_2(mux_233_nl, mux_231_nl, fsm_output[0]);
  assign mux_239_nl = MUX_s_1_2_2(mux_238_nl, mux_234_nl, fsm_output[5]);
  assign mux_230_nl = MUX_s_1_2_2(mux_tmp_229, (~ mux_tmp_227), and_342_cse);
  assign and_175_nl = (fsm_output[5]) & mux_230_nl;
  assign mux_240_nl = MUX_s_1_2_2(mux_239_nl, and_175_nl, fsm_output[6]);
  assign COMP_LOOP_mux1h_13_nl = MUX1HOT_s_1_4_2((operator_66_true_div_cmp_z[0]),
      (tmp_2_lpi_4_dfm[0]), modExp_exp_1_0_1_sva_1, modExp_exp_1_0_1_sva, {COMP_LOOP_and_3_nl
      , and_dcpl_105 , and_dcpl_134 , mux_240_nl});
  assign or_340_nl = (~ (fsm_output[1])) | (fsm_output[6]) | (~ (fsm_output[2]))
      | (fsm_output[7]);
  assign or_341_nl = and_342_cse | (fsm_output[6]) | (fsm_output[2]) | (fsm_output[7]);
  assign mux_248_nl = MUX_s_1_2_2(or_340_nl, or_341_nl, fsm_output[4]);
  assign or_274_nl = (~ (fsm_output[1])) | (fsm_output[6]);
  assign mux_246_nl = MUX_s_1_2_2(or_425_cse, (~ or_424_cse), or_274_nl);
  assign mux_244_nl = MUX_s_1_2_2(or_425_cse, (~ or_424_cse), fsm_output[6]);
  assign mux_245_nl = MUX_s_1_2_2(mux_244_nl, or_425_cse, fsm_output[1]);
  assign mux_247_nl = MUX_s_1_2_2(mux_246_nl, mux_245_nl, fsm_output[0]);
  assign nor_58_nl = ~((fsm_output[4]) | mux_247_nl);
  assign mux_249_nl = MUX_s_1_2_2(mux_248_nl, nor_58_nl, fsm_output[5]);
  assign or_343_nl = (~ (fsm_output[0])) | (~ (fsm_output[1])) | (fsm_output[6])
      | (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_242_nl = MUX_s_1_2_2(or_386_cse, or_343_nl, fsm_output[4]);
  assign or_269_nl = (~ (fsm_output[0])) | (~ (fsm_output[1])) | (fsm_output[6]);
  assign mux_241_nl = MUX_s_1_2_2(or_425_cse, (~ or_424_cse), or_269_nl);
  assign and_173_nl = (fsm_output[4]) & mux_241_nl;
  assign mux_243_nl = MUX_s_1_2_2(mux_242_nl, and_173_nl, fsm_output[5]);
  assign mux_250_nl = MUX_s_1_2_2(mux_249_nl, mux_243_nl, fsm_output[3]);
  assign and_164_nl = (fsm_output[3]) & mux_tmp_124;
  assign mux_308_nl = MUX_s_1_2_2(and_164_nl, and_tmp_9, fsm_output[6]);
  assign mux_309_nl = MUX_s_1_2_2(or_tmp_213, (~ mux_308_nl), fsm_output[4]);
  assign and_165_nl = mux_309_nl & and_dcpl_31;
  assign COMP_LOOP_mux1h_22_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_1_sva_7_0[7]),
      modExp_exp_1_2_1_sva, modExp_exp_1_1_1_sva, (COMP_LOOP_k_9_1_1_sva_7_0[1]),
      {and_dcpl_131 , and_dcpl_153 , and_165_nl , and_dcpl_157});
  assign COMP_LOOP_mux1h_39_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_1_sva_7_0[6]),
      modExp_exp_1_1_1_sva, modExp_exp_1_7_1_sva, (COMP_LOOP_k_9_1_1_sva_7_0[7]),
      {and_dcpl_131 , and_dcpl_77 , and_dcpl_158 , and_dcpl_157});
  assign nor_82_nl = ~((fsm_output[7:1]!=7'b0000000));
  assign or_394_nl = (fsm_output[0]) | (fsm_output[8]) | (fsm_output[4]);
  assign mux_354_nl = MUX_s_1_2_2(or_394_nl, (fsm_output[8]), fsm_output[1]);
  assign mux_349_nl = MUX_s_1_2_2((fsm_output[8]), or_tmp_162, and_342_cse);
  assign mux_355_nl = MUX_s_1_2_2((~ mux_354_nl), mux_349_nl, fsm_output[6]);
  assign mux_356_nl = MUX_s_1_2_2(mux_355_nl, (fsm_output[8]), fsm_output[7]);
  assign mux_351_nl = MUX_s_1_2_2((fsm_output[8]), or_326_cse, fsm_output[1]);
  assign mux_352_nl = MUX_s_1_2_2((~ mux_351_nl), or_tmp_325, fsm_output[6]);
  assign mux_385_nl = MUX_s_1_2_2((fsm_output[8]), or_tmp_162, and_342_cse);
  assign mux_350_nl = MUX_s_1_2_2(or_tmp_162, mux_385_nl, fsm_output[6]);
  assign mux_353_nl = MUX_s_1_2_2(mux_352_nl, mux_350_nl, fsm_output[7]);
  assign mux_357_nl = MUX_s_1_2_2(mux_356_nl, mux_353_nl, fsm_output[2]);
  assign or_393_nl = ((fsm_output[6]) & (fsm_output[8])) | (fsm_output[4]);
  assign or_392_nl = nor_87_cse | (fsm_output[8]) | (fsm_output[4]);
  assign mux_346_nl = MUX_s_1_2_2(or_392_nl, or_tmp_325, fsm_output[6]);
  assign mux_347_nl = MUX_s_1_2_2(or_393_nl, mux_346_nl, fsm_output[7]);
  assign or_389_nl = (~((fsm_output[0]) | (~ (fsm_output[8])))) | (fsm_output[4]);
  assign and_340_nl = ((~ (fsm_output[0])) | (fsm_output[8])) & (fsm_output[4]);
  assign mux_344_nl = MUX_s_1_2_2(or_389_nl, and_340_nl, fsm_output[1]);
  assign mux_345_nl = MUX_s_1_2_2(mux_344_nl, or_tmp_162, or_386_cse);
  assign mux_348_nl = MUX_s_1_2_2(mux_347_nl, mux_345_nl, fsm_output[2]);
  assign mux_358_nl = MUX_s_1_2_2(mux_357_nl, mux_348_nl, fsm_output[3]);
  assign mux_341_nl = MUX_s_1_2_2(mux_tmp_337, or_326_cse, fsm_output[7]);
  assign mux_340_nl = MUX_s_1_2_2((fsm_output[8]), mux_tmp_337, fsm_output[7]);
  assign mux_342_nl = MUX_s_1_2_2(mux_341_nl, mux_340_nl, fsm_output[2]);
  assign mux_343_nl = MUX_s_1_2_2(mux_342_nl, (fsm_output[8]), fsm_output[3]);
  assign mux_359_nl = MUX_s_1_2_2(mux_358_nl, mux_343_nl, fsm_output[5]);
  assign or_422_nl = (fsm_output[1]) | (fsm_output[4]) | ((fsm_output[8]) & (fsm_output[5]));
  assign mux_375_nl = MUX_s_1_2_2(or_tmp_351, or_422_nl, fsm_output[0]);
  assign mux_376_nl = MUX_s_1_2_2(mux_375_nl, or_tmp_347, fsm_output[6]);
  assign or_420_nl = (fsm_output[0]) | (~ modExp_exp_1_0_1_sva) | (~ (fsm_output[1]))
      | (~ (fsm_output[4])) | (fsm_output[8]) | (~ (fsm_output[5]));
  assign or_418_nl = (fsm_output[0]) | (fsm_output[1]) | (fsm_output[4]) | (fsm_output[8])
      | (fsm_output[5]);
  assign mux_374_nl = MUX_s_1_2_2(or_420_nl, or_418_nl, fsm_output[6]);
  assign mux_377_nl = MUX_s_1_2_2(mux_376_nl, mux_374_nl, fsm_output[7]);
  assign or_417_nl = (~ (fsm_output[1])) | (fsm_output[4]) | (fsm_output[8]) | (fsm_output[5]);
  assign mux_372_nl = MUX_s_1_2_2(or_417_nl, or_tmp_344, fsm_output[6]);
  assign or_414_nl = (fsm_output[1]) | (fsm_output[4]) | (fsm_output[8]) | (~ (fsm_output[5]));
  assign mux_370_nl = MUX_s_1_2_2(or_tmp_351, or_414_nl, fsm_output[0]);
  assign mux_371_nl = MUX_s_1_2_2(mux_370_nl, or_tmp_347, fsm_output[6]);
  assign mux_373_nl = MUX_s_1_2_2(mux_372_nl, mux_371_nl, fsm_output[7]);
  assign mux_378_nl = MUX_s_1_2_2(mux_377_nl, mux_373_nl, fsm_output[2]);
  assign or_410_nl = (~ (fsm_output[0])) | (fsm_output[1]) | (fsm_output[4]) | (fsm_output[8])
      | (fsm_output[5]);
  assign mux_367_nl = MUX_s_1_2_2(or_410_nl, or_tmp_344, fsm_output[6]);
  assign mux_368_nl = MUX_s_1_2_2(nand_tmp, mux_367_nl, fsm_output[7]);
  assign or_407_nl = (fsm_output[1]) | (~ (fsm_output[4])) | (fsm_output[8]) | (~
      (fsm_output[5]));
  assign or_405_nl = (~ (fsm_output[4])) | (fsm_output[8]) | (~ (fsm_output[5]));
  assign or_403_nl = (fsm_output[4]) | (fsm_output[8]) | (~ (fsm_output[5]));
  assign mux_362_nl = MUX_s_1_2_2(or_405_nl, or_403_nl, fsm_output[1]);
  assign mux_363_nl = MUX_s_1_2_2(or_407_nl, mux_362_nl, modExp_exp_1_0_1_sva);
  assign or_401_nl = (fsm_output[4]) | (~ (fsm_output[8])) | (fsm_output[5]);
  assign or_400_nl = (~ (fsm_output[4])) | (fsm_output[8]) | (fsm_output[5]);
  assign mux_361_nl = MUX_s_1_2_2(or_401_nl, or_400_nl, fsm_output[1]);
  assign mux_364_nl = MUX_s_1_2_2(mux_363_nl, mux_361_nl, fsm_output[0]);
  assign or_399_nl = (~ (fsm_output[0])) | (fsm_output[1]) | (~ (fsm_output[4]))
      | (fsm_output[8]) | (~ (fsm_output[5]));
  assign mux_365_nl = MUX_s_1_2_2(mux_364_nl, or_399_nl, fsm_output[6]);
  assign mux_366_nl = MUX_s_1_2_2(mux_365_nl, nand_tmp, fsm_output[7]);
  assign mux_369_nl = MUX_s_1_2_2(mux_368_nl, mux_366_nl, fsm_output[2]);
  assign mux_379_nl = MUX_s_1_2_2(mux_378_nl, mux_369_nl, fsm_output[3]);
  assign nor_71_nl = ~((fsm_output[3]) | (fsm_output[0]) | (~ (fsm_output[2])) |
      (fsm_output[7]));
  assign and_183_nl = (fsm_output[3]) & (fsm_output[0]) & (fsm_output[2]) & (~ (fsm_output[7]));
  assign mux_189_nl = MUX_s_1_2_2(nor_71_nl, and_183_nl, fsm_output[4]);
  assign nor_72_nl = ~((fsm_output[4]) | (fsm_output[3]) | (~ (fsm_output[0])) |
      (fsm_output[2]) | (~ (fsm_output[7])));
  assign mux_190_nl = MUX_s_1_2_2(mux_189_nl, nor_72_nl, fsm_output[5]);
  assign nor_73_nl = ~((~ (fsm_output[5])) | (fsm_output[4]) | (fsm_output[3]) |
      (~ (fsm_output[0])) | (~ (fsm_output[2])) | (fsm_output[7]));
  assign mux_191_nl = MUX_s_1_2_2(mux_190_nl, nor_73_nl, fsm_output[8]);
  assign nand_55_nl = ~(mux_191_nl & and_dcpl_92);
  assign nor_174_nl = ~((fsm_output[0]) | (fsm_output[5]) | (fsm_output[3]) | (fsm_output[4])
      | (~ (fsm_output[8])) | (fsm_output[7]) | (fsm_output[2]));
  assign nor_175_nl = ~((fsm_output[0]) | (~ (fsm_output[5])) | (~ (fsm_output[3]))
      | (~ (fsm_output[4])) | (fsm_output[8]) | (fsm_output[7]) | (~ (fsm_output[2])));
  assign mux_383_nl = MUX_s_1_2_2(nor_174_nl, nor_175_nl, fsm_output[6]);
  assign or_430_nl = (fsm_output[5]) | (fsm_output[3]) | (fsm_output[4]) | (fsm_output[8])
      | (fsm_output[7]) | (~ (fsm_output[2]));
  assign or_428_nl = (~ (fsm_output[3])) | (~ (fsm_output[4])) | (fsm_output[8])
      | (fsm_output[7]) | (~ (fsm_output[2]));
  assign mux_380_nl = MUX_s_1_2_2(or_425_cse, or_424_cse, fsm_output[8]);
  assign or_426_nl = (fsm_output[4:3]!=2'b00) | mux_380_nl;
  assign mux_381_nl = MUX_s_1_2_2(or_428_nl, or_426_nl, fsm_output[5]);
  assign mux_382_nl = MUX_s_1_2_2(or_430_nl, mux_381_nl, fsm_output[0]);
  assign nor_176_nl = ~((fsm_output[6]) | mux_382_nl);
  assign or_230_nl = (fsm_output[6]) | (fsm_output[3]) | or_tmp_195;
  assign or_228_nl = (fsm_output[6]) | (fsm_output[3]) | (~ (fsm_output[0])) | (~
      (fsm_output[1])) | (fsm_output[2]) | (fsm_output[7]);
  assign mux_203_nl = MUX_s_1_2_2(or_230_nl, or_228_nl, fsm_output[4]);
  assign nor_68_nl = ~((fsm_output[5]) | mux_203_nl);
  assign mux_204_nl = MUX_s_1_2_2(nor_68_nl, mux_tmp_138, fsm_output[8]);
  assign and_111_nl = and_dcpl_72 & nor_122_cse & and_dcpl_20;
  assign r_or_nl = ((~ (modulo_result_rem_cmp_z[63])) & and_116_m1c) | (and_dcpl_122
      & and_dcpl_120 & (~ (fsm_output[8])) & (~ (modulo_result_rem_cmp_z[63])));
  assign r_or_1_nl = ((modulo_result_rem_cmp_z[63]) & and_116_m1c) | (and_dcpl_122
      & and_dcpl_120 & (~ (fsm_output[8])) & (modulo_result_rem_cmp_z[63]));
  assign or_358_nl = (fsm_output[4]) | (fsm_output[6]) | (fsm_output[3]) | (~ (fsm_output[0]))
      | (~ (fsm_output[1])) | (fsm_output[7]) | (~ (fsm_output[2]));
  assign or_237_nl = (fsm_output[3]) | (fsm_output[0]) | (~ and_dcpl_75);
  assign mux_208_nl = MUX_s_1_2_2(or_237_nl, or_tmp_204, fsm_output[6]);
  assign mux_207_nl = MUX_s_1_2_2(or_425_cse, or_424_cse, fsm_output[3]);
  assign nand_35_nl = ~((fsm_output[6]) & mux_207_nl);
  assign mux_209_nl = MUX_s_1_2_2(mux_208_nl, nand_35_nl, fsm_output[4]);
  assign mux_210_nl = MUX_s_1_2_2(or_358_nl, mux_209_nl, fsm_output[5]);
  assign mux_219_nl = MUX_s_1_2_2(or_tmp_225, or_tmp_223, VEC_LOOP_j_1_12_0_sva_11_0[0]);
  assign or_252_nl = (VEC_LOOP_j_1_12_0_sva_11_0[0]) | (~ (fsm_output[0])) | (fsm_output[1])
      | (fsm_output[2]) | (fsm_output[7]);
  assign mux_220_nl = MUX_s_1_2_2(mux_219_nl, or_252_nl, reg_VEC_LOOP_1_acc_1_psp_ftd_1[0]);
  assign or_251_nl = (COMP_LOOP_acc_1_cse_2_sva[0]) | (fsm_output[0]) | (~ and_dcpl_75);
  assign mux_221_nl = MUX_s_1_2_2(mux_220_nl, or_251_nl, fsm_output[6]);
  assign and_134_nl = (~ mux_221_nl) & and_dcpl_114;
  assign or_259_nl = (~ (VEC_LOOP_j_1_12_0_sva_11_0[0])) | (~ (fsm_output[0])) |
      (fsm_output[1]) | (fsm_output[2]) | (fsm_output[7]);
  assign mux_222_nl = MUX_s_1_2_2(or_tmp_223, or_tmp_225, VEC_LOOP_j_1_12_0_sva_11_0[0]);
  assign mux_223_nl = MUX_s_1_2_2(or_259_nl, mux_222_nl, reg_VEC_LOOP_1_acc_1_psp_ftd_1[0]);
  assign or_258_nl = (~ (COMP_LOOP_acc_1_cse_2_sva[0])) | (fsm_output[0]) | (~ and_dcpl_75);
  assign mux_224_nl = MUX_s_1_2_2(mux_223_nl, or_258_nl, fsm_output[6]);
  assign and_135_nl = (~ mux_224_nl) & and_dcpl_114;
  assign nand_24_nl = ~(((fsm_output[2:0]!=3'b000)) & (fsm_output[7]));
  assign mux_214_nl = MUX_s_1_2_2(or_tmp_195, nand_24_nl, fsm_output[3]);
  assign nand_25_nl = ~((fsm_output[3]) & or_425_cse);
  assign mux_215_nl = MUX_s_1_2_2(mux_214_nl, nand_25_nl, fsm_output[6]);
  assign nor_63_nl = ~((fsm_output[6]) | ((fsm_output[3:0]==4'b1111)) | (fsm_output[7]));
  assign mux_216_nl = MUX_s_1_2_2(mux_215_nl, nor_63_nl, fsm_output[4]);
  assign or_245_nl = (fsm_output[3]) | mux_tmp_124;
  assign mux_213_nl = MUX_s_1_2_2(or_245_nl, or_tmp_213, fsm_output[6]);
  assign or_246_nl = (fsm_output[4]) | mux_213_nl;
  assign mux_217_nl = MUX_s_1_2_2(mux_216_nl, or_246_nl, fsm_output[5]);
  assign mux_212_nl = MUX_s_1_2_2((fsm_output[7]), or_tmp_144, fsm_output[3]);
  assign nor_64_nl = ~((fsm_output[6:4]!=3'b000) | mux_212_nl);
  assign mux_218_nl = MUX_s_1_2_2(mux_217_nl, nor_64_nl, fsm_output[8]);
  assign nl_VEC_LOOP_1_COMP_LOOP_1_acc_11_nl = ({z_out_1 , 1'b0}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + 10'b0000000001;
  assign VEC_LOOP_1_COMP_LOOP_1_acc_11_nl = nl_VEC_LOOP_1_COMP_LOOP_1_acc_11_nl[9:0];
  assign nl_VEC_LOOP_1_COMP_LOOP_1_acc_8_nl = tmp_2_lpi_4_dfm - modExp_base_1_sva_mx1;
  assign VEC_LOOP_1_COMP_LOOP_1_acc_8_nl = nl_VEC_LOOP_1_COMP_LOOP_1_acc_8_nl[63:0];
  assign or_301_nl = (fsm_output[6]) | (~ (fsm_output[3])) | (fsm_output[0]) | (fsm_output[1])
      | (fsm_output[2]) | (fsm_output[7]);
  assign mux_281_nl = MUX_s_1_2_2(or_301_nl, or_tmp_204, fsm_output[5]);
  assign COMP_LOOP_mux_100_nl = MUX_v_12_2_2(VEC_LOOP_j_1_12_0_sva_11_0, reg_VEC_LOOP_1_acc_1_psp_ftd_1,
      and_346_cse);
  assign nl_COMP_LOOP_acc_1_cse_2_sva  = COMP_LOOP_mux_100_nl + conv_u2u_9_12({COMP_LOOP_k_9_1_1_sva_7_0
      , 1'b1});
  assign mux_298_nl = MUX_s_1_2_2(mux_14_cse, or_326_cse, fsm_output[5]);
  assign mux_299_nl = MUX_s_1_2_2(mux_298_nl, mux_tmp_292, fsm_output[3]);
  assign mux_300_nl = MUX_s_1_2_2(mux_299_nl, mux_tmp_296, fsm_output[2]);
  assign mux_293_nl = MUX_s_1_2_2(mux_tmp_292, mux_tmp_290, fsm_output[3]);
  assign mux_297_nl = MUX_s_1_2_2(mux_tmp_296, mux_293_nl, fsm_output[2]);
  assign mux_301_nl = MUX_s_1_2_2(mux_300_nl, mux_297_nl, or_13_cse);
  assign and_161_nl = and_dcpl_75 & (~((fsm_output[0]) ^ (fsm_output[6]))) & (fsm_output[4:3]==2'b11)
      & and_dcpl_31;
  assign mux_304_nl = MUX_s_1_2_2(mux_tmp_124, or_31_cse, fsm_output[3]);
  assign mux_305_nl = MUX_s_1_2_2(mux_304_nl, or_tmp_213, fsm_output[6]);
  assign or_29_nl = (fsm_output[3]) | (fsm_output[1]) | (~ (fsm_output[7])) | (fsm_output[2]);
  assign mux_303_nl = MUX_s_1_2_2(or_29_nl, and_tmp_9, fsm_output[6]);
  assign mux_306_nl = MUX_s_1_2_2(mux_305_nl, (~ mux_303_nl), fsm_output[4]);
  assign COMP_LOOP_COMP_LOOP_or_2_nl = (STAGE_LOOP_lshift_psp_sva[9]) | and_dcpl_165
      | and_dcpl_171 | and_dcpl_177;
  assign COMP_LOOP_mux_98_nl = MUX_s_1_2_2((~ (STAGE_LOOP_lshift_psp_sva[9])), (STAGE_LOOP_lshift_psp_sva[8]),
      and_dcpl_174);
  assign COMP_LOOP_COMP_LOOP_or_3_nl = COMP_LOOP_mux_98_nl | and_dcpl_171 | and_dcpl_177;
  assign COMP_LOOP_mux1h_73_nl = MUX1HOT_s_1_4_2((~ (STAGE_LOOP_lshift_psp_sva[8])),
      (~ modExp_exp_1_7_1_sva), (STAGE_LOOP_lshift_psp_sva[7]), (~ modExp_exp_1_1_1_sva),
      {and_dcpl_165 , and_dcpl_171 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_mux1h_74_nl = MUX1HOT_s_1_4_2((~ (STAGE_LOOP_lshift_psp_sva[7])),
      (~ modExp_exp_1_6_1_sva), (STAGE_LOOP_lshift_psp_sva[6]), (~ modExp_exp_1_7_1_sva),
      {and_dcpl_165 , and_dcpl_171 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_mux1h_75_nl = MUX1HOT_s_1_4_2((~ (STAGE_LOOP_lshift_psp_sva[6])),
      (~ modExp_exp_1_5_1_sva), (STAGE_LOOP_lshift_psp_sva[5]), (~ modExp_exp_1_6_1_sva),
      {and_dcpl_165 , and_dcpl_171 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_mux1h_76_nl = MUX1HOT_s_1_4_2((~ (STAGE_LOOP_lshift_psp_sva[5])),
      (~ modExp_exp_1_4_1_sva), (STAGE_LOOP_lshift_psp_sva[4]), (~ modExp_exp_1_5_1_sva),
      {and_dcpl_165 , and_dcpl_171 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_mux1h_77_nl = MUX1HOT_s_1_4_2((~ (STAGE_LOOP_lshift_psp_sva[4])),
      (~ modExp_exp_1_3_1_sva), (STAGE_LOOP_lshift_psp_sva[3]), (~ modExp_exp_1_4_1_sva),
      {and_dcpl_165 , and_dcpl_171 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_mux1h_78_nl = MUX1HOT_s_1_4_2((~ (STAGE_LOOP_lshift_psp_sva[3])),
      (~ modExp_exp_1_2_1_sva), (STAGE_LOOP_lshift_psp_sva[2]), (~ modExp_exp_1_3_1_sva),
      {and_dcpl_165 , and_dcpl_171 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_mux1h_79_nl = MUX1HOT_s_1_4_2((~ (STAGE_LOOP_lshift_psp_sva[2])),
      (~ modExp_exp_1_1_1_sva), (STAGE_LOOP_lshift_psp_sva[1]), (~ modExp_exp_1_2_1_sva),
      {and_dcpl_165 , and_dcpl_171 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_or_17_nl = and_dcpl_171 | and_dcpl_177;
  assign COMP_LOOP_mux1h_80_nl = MUX1HOT_s_1_3_2((~ (STAGE_LOOP_lshift_psp_sva[1])),
      (~ modExp_exp_1_0_1_sva_1), (STAGE_LOOP_lshift_psp_sva[0]), {and_dcpl_165 ,
      COMP_LOOP_or_17_nl , and_dcpl_174});
  assign COMP_LOOP_or_18_nl = (~(and_dcpl_171 | and_dcpl_174 | and_dcpl_177)) | and_dcpl_165;
  assign COMP_LOOP_nor_4_nl = ~(and_dcpl_171 | and_dcpl_177);
  assign COMP_LOOP_COMP_LOOP_and_1_nl = MUX_v_8_2_2(8'b00000000, COMP_LOOP_k_9_1_1_sva_7_0,
      COMP_LOOP_nor_4_nl);
  assign nl_acc_nl = ({COMP_LOOP_COMP_LOOP_or_2_nl , COMP_LOOP_COMP_LOOP_or_3_nl
      , COMP_LOOP_mux1h_73_nl , COMP_LOOP_mux1h_74_nl , COMP_LOOP_mux1h_75_nl , COMP_LOOP_mux1h_76_nl
      , COMP_LOOP_mux1h_77_nl , COMP_LOOP_mux1h_78_nl , COMP_LOOP_mux1h_79_nl , COMP_LOOP_mux1h_80_nl
      , COMP_LOOP_or_18_nl}) + conv_u2u_10_11({COMP_LOOP_COMP_LOOP_and_1_nl , 2'b11});
  assign acc_nl = nl_acc_nl[10:0];
  assign z_out = readslicef_11_10_1(acc_nl);
  assign nor_180_nl = ~((fsm_output[5]) | (fsm_output[2]) | (~ (fsm_output[8])) |
      (fsm_output[3]) | (fsm_output[4]));
  assign nor_181_nl = ~((~ (fsm_output[5])) | (~ (fsm_output[2])) | (fsm_output[8])
      | nand_cse);
  assign mux_387_nl = MUX_s_1_2_2(nor_180_nl, nor_181_nl, fsm_output[6]);
  assign and_345_nl = mux_387_nl & (~((fsm_output[7]) | (fsm_output[1]) | (fsm_output[0])));
  assign STAGE_LOOP_mux_5_nl = MUX_v_8_2_2(({4'b0000 , STAGE_LOOP_i_3_0_sva}), COMP_LOOP_k_9_1_1_sva_7_0,
      and_345_nl);
  assign nl_z_out_1 = conv_u2u_8_9(STAGE_LOOP_mux_5_nl) + 9'b000000001;
  assign z_out_1 = nl_z_out_1[8:0];
  assign nor_183_cse = ~((fsm_output[8]) | (fsm_output[4]) | (fsm_output[3]));
  assign and_346_cse = nor_183_cse & (fsm_output[7]) & (fsm_output[2]) & (~ (fsm_output[1]))
      & (fsm_output[5]) & and_dcpl_200;
  assign COMP_LOOP_mux_99_nl = MUX_v_11_2_2((VEC_LOOP_j_1_12_0_sva_11_0[11:1]), (reg_VEC_LOOP_1_acc_1_psp_ftd_1[11:1]),
      and_346_cse);
  assign nl_z_out_2 = COMP_LOOP_mux_99_nl + conv_u2u_8_11(COMP_LOOP_k_9_1_1_sva_7_0);
  assign z_out_2 = nl_z_out_2[10:0];
  assign operator_64_false_1_mux_1_nl = MUX_s_1_2_2((tmp_2_lpi_4_dfm[63]), (p_sva[63]),
      and_dcpl_215);
  assign operator_64_false_1_operator_64_false_1_or_53_nl = (operator_64_false_1_mux_1_nl
      & operator_64_false_1_nor_itm) | and_dcpl_206 | and_dcpl_220;
  assign operator_64_false_1_mux1h_6_nl = MUX1HOT_v_51_3_2((tmp_2_lpi_4_dfm[62:12]),
      (p_sva[62:12]), (~ (operator_64_false_acc_mut_63_0[62:12])), {and_dcpl_210
      , and_dcpl_215 , and_dcpl_220});
  assign operator_64_false_1_and_57_nl = MUX_v_51_2_2(51'b000000000000000000000000000000000000000000000000000,
      operator_64_false_1_mux1h_6_nl, operator_64_false_1_nor_itm);
  assign operator_64_false_1_or_13_nl = MUX_v_51_2_2(operator_64_false_1_and_57_nl,
      51'b111111111111111111111111111111111111111111111111111, and_dcpl_206);
  assign operator_64_false_1_mux1h_7_nl = MUX1HOT_v_2_5_2((tmp_2_lpi_4_dfm[11:10]),
      (p_sva[11:10]), (~ (operator_64_false_acc_mut_63_0[11:10])), (VEC_LOOP_j_1_12_0_sva_11_0[11:10]),
      (reg_VEC_LOOP_1_acc_1_psp_ftd_1[11:10]), {and_dcpl_210 , and_dcpl_215 , and_dcpl_220
      , and_dcpl_240 , and_dcpl_242});
  assign operator_64_false_1_nor_56_nl = ~(and_dcpl_226 | and_dcpl_230 | and_dcpl_233
      | and_dcpl_237 | and_dcpl_245);
  assign operator_64_false_1_and_58_nl = MUX_v_2_2_2(2'b00, operator_64_false_1_mux1h_7_nl,
      operator_64_false_1_nor_56_nl);
  assign operator_64_false_1_or_14_nl = MUX_v_2_2_2(operator_64_false_1_and_58_nl,
      2'b11, and_dcpl_206);
  assign nl_COMP_LOOP_acc_18_nl = (STAGE_LOOP_lshift_psp_sva[9:1]) + conv_u2u_8_9(COMP_LOOP_k_9_1_1_sva_7_0);
  assign COMP_LOOP_acc_18_nl = nl_COMP_LOOP_acc_18_nl[8:0];
  assign operator_64_false_1_or_15_nl = and_dcpl_226 | and_dcpl_233;
  assign operator_64_false_1_or_16_nl = and_dcpl_230 | and_dcpl_237;
  assign operator_64_false_1_mux1h_8_nl = MUX1HOT_v_10_9_2(({1'b1 , (~ COMP_LOOP_k_9_1_1_sva_7_0)
      , 1'b1}), (tmp_2_lpi_4_dfm[9:0]), (p_sva[9:0]), (~ (operator_64_false_acc_mut_63_0[9:0])),
      ({COMP_LOOP_acc_18_nl , (STAGE_LOOP_lshift_psp_sva[0])}), z_out, (VEC_LOOP_j_1_12_0_sva_11_0[9:0]),
      (reg_VEC_LOOP_1_acc_1_psp_ftd_1[9:0]), ({7'b0000000 , (z_out_1[3:1])}), {and_dcpl_206
      , and_dcpl_210 , and_dcpl_215 , and_dcpl_220 , operator_64_false_1_or_15_nl
      , operator_64_false_1_or_16_nl , and_dcpl_240 , and_dcpl_242 , and_dcpl_245});
  assign operator_64_false_1_operator_64_false_1_or_54_nl = ((modExp_base_1_sva_mx1[63])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_55_nl = ((modExp_base_1_sva_mx1[62])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_56_nl = ((modExp_base_1_sva_mx1[61])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_57_nl = ((modExp_base_1_sva_mx1[60])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_58_nl = ((modExp_base_1_sva_mx1[59])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_59_nl = ((modExp_base_1_sva_mx1[58])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_60_nl = ((modExp_base_1_sva_mx1[57])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_61_nl = ((modExp_base_1_sva_mx1[56])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_62_nl = ((modExp_base_1_sva_mx1[55])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_63_nl = ((modExp_base_1_sva_mx1[54])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_64_nl = ((modExp_base_1_sva_mx1[53])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_65_nl = ((modExp_base_1_sva_mx1[52])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_66_nl = ((modExp_base_1_sva_mx1[51])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_67_nl = ((modExp_base_1_sva_mx1[50])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_68_nl = ((modExp_base_1_sva_mx1[49])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_69_nl = ((modExp_base_1_sva_mx1[48])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_70_nl = ((modExp_base_1_sva_mx1[47])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_71_nl = ((modExp_base_1_sva_mx1[46])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_72_nl = ((modExp_base_1_sva_mx1[45])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_73_nl = ((modExp_base_1_sva_mx1[44])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_74_nl = ((modExp_base_1_sva_mx1[43])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_75_nl = ((modExp_base_1_sva_mx1[42])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_76_nl = ((modExp_base_1_sva_mx1[41])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_77_nl = ((modExp_base_1_sva_mx1[40])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_78_nl = ((modExp_base_1_sva_mx1[39])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_79_nl = ((modExp_base_1_sva_mx1[38])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_80_nl = ((modExp_base_1_sva_mx1[37])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_81_nl = ((modExp_base_1_sva_mx1[36])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_82_nl = ((modExp_base_1_sva_mx1[35])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_83_nl = ((modExp_base_1_sva_mx1[34])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_84_nl = ((modExp_base_1_sva_mx1[33])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_85_nl = ((modExp_base_1_sva_mx1[32])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_86_nl = ((modExp_base_1_sva_mx1[31])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_87_nl = ((modExp_base_1_sva_mx1[30])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_88_nl = ((modExp_base_1_sva_mx1[29])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_89_nl = ((modExp_base_1_sva_mx1[28])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_90_nl = ((modExp_base_1_sva_mx1[27])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_91_nl = ((modExp_base_1_sva_mx1[26])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_92_nl = ((modExp_base_1_sva_mx1[25])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_93_nl = ((modExp_base_1_sva_mx1[24])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_94_nl = ((modExp_base_1_sva_mx1[23])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_95_nl = ((modExp_base_1_sva_mx1[22])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_96_nl = ((modExp_base_1_sva_mx1[21])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_97_nl = ((modExp_base_1_sva_mx1[20])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_98_nl = ((modExp_base_1_sva_mx1[19])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_99_nl = ((modExp_base_1_sva_mx1[18])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_100_nl = ((modExp_base_1_sva_mx1[17])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_101_nl = ((modExp_base_1_sva_mx1[16])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_102_nl = ((modExp_base_1_sva_mx1[15])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_103_nl = ((modExp_base_1_sva_mx1[14])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_104_nl = ((modExp_base_1_sva_mx1[13])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_operator_64_false_1_or_105_nl = ((modExp_base_1_sva_mx1[12])
      & operator_64_false_1_nor_3_itm) | and_dcpl_215;
  assign operator_64_false_1_mux1h_9_nl = MUX1HOT_v_2_3_2((modExp_base_1_sva_mx1[11:10]),
      (VEC_LOOP_j_1_12_0_sva_11_0[11:10]), (reg_VEC_LOOP_1_acc_1_psp_ftd_1[11:10]),
      {and_dcpl_210 , operator_64_false_1_or_5_itm , operator_64_false_1_or_6_itm});
  assign operator_64_false_1_nor_57_nl = ~(and_dcpl_206 | and_dcpl_220 | and_dcpl_240
      | and_dcpl_242 | and_dcpl_245);
  assign operator_64_false_1_and_111_nl = MUX_v_2_2_2(2'b00, operator_64_false_1_mux1h_9_nl,
      operator_64_false_1_nor_57_nl);
  assign operator_64_false_1_or_17_nl = MUX_v_2_2_2(operator_64_false_1_and_111_nl,
      2'b11, and_dcpl_215);
  assign operator_64_false_1_or_19_nl = and_dcpl_206 | and_dcpl_220;
  assign operator_64_false_1_or_20_nl = and_dcpl_240 | and_dcpl_242;
  assign operator_64_false_1_mux1h_10_nl = MUX1HOT_v_10_6_2(10'b0000000001, (modExp_base_1_sva_mx1[9:0]),
      (VEC_LOOP_j_1_12_0_sva_11_0[9:0]), (reg_VEC_LOOP_1_acc_1_psp_ftd_1[9:0]), STAGE_LOOP_lshift_psp_sva,
      10'b0000000011, {operator_64_false_1_or_19_nl , and_dcpl_210 , operator_64_false_1_or_5_itm
      , operator_64_false_1_or_6_itm , operator_64_false_1_or_20_nl , and_dcpl_245});
  assign operator_64_false_1_or_18_nl = MUX_v_10_2_2(operator_64_false_1_mux1h_10_nl,
      10'b1111111111, and_dcpl_215);
  assign nl_z_out_3 = conv_u2u_64_65({operator_64_false_1_operator_64_false_1_or_53_nl
      , operator_64_false_1_or_13_nl , operator_64_false_1_or_14_nl , operator_64_false_1_mux1h_8_nl})
      + conv_s2u_64_65({operator_64_false_1_operator_64_false_1_or_54_nl , operator_64_false_1_operator_64_false_1_or_55_nl
      , operator_64_false_1_operator_64_false_1_or_56_nl , operator_64_false_1_operator_64_false_1_or_57_nl
      , operator_64_false_1_operator_64_false_1_or_58_nl , operator_64_false_1_operator_64_false_1_or_59_nl
      , operator_64_false_1_operator_64_false_1_or_60_nl , operator_64_false_1_operator_64_false_1_or_61_nl
      , operator_64_false_1_operator_64_false_1_or_62_nl , operator_64_false_1_operator_64_false_1_or_63_nl
      , operator_64_false_1_operator_64_false_1_or_64_nl , operator_64_false_1_operator_64_false_1_or_65_nl
      , operator_64_false_1_operator_64_false_1_or_66_nl , operator_64_false_1_operator_64_false_1_or_67_nl
      , operator_64_false_1_operator_64_false_1_or_68_nl , operator_64_false_1_operator_64_false_1_or_69_nl
      , operator_64_false_1_operator_64_false_1_or_70_nl , operator_64_false_1_operator_64_false_1_or_71_nl
      , operator_64_false_1_operator_64_false_1_or_72_nl , operator_64_false_1_operator_64_false_1_or_73_nl
      , operator_64_false_1_operator_64_false_1_or_74_nl , operator_64_false_1_operator_64_false_1_or_75_nl
      , operator_64_false_1_operator_64_false_1_or_76_nl , operator_64_false_1_operator_64_false_1_or_77_nl
      , operator_64_false_1_operator_64_false_1_or_78_nl , operator_64_false_1_operator_64_false_1_or_79_nl
      , operator_64_false_1_operator_64_false_1_or_80_nl , operator_64_false_1_operator_64_false_1_or_81_nl
      , operator_64_false_1_operator_64_false_1_or_82_nl , operator_64_false_1_operator_64_false_1_or_83_nl
      , operator_64_false_1_operator_64_false_1_or_84_nl , operator_64_false_1_operator_64_false_1_or_85_nl
      , operator_64_false_1_operator_64_false_1_or_86_nl , operator_64_false_1_operator_64_false_1_or_87_nl
      , operator_64_false_1_operator_64_false_1_or_88_nl , operator_64_false_1_operator_64_false_1_or_89_nl
      , operator_64_false_1_operator_64_false_1_or_90_nl , operator_64_false_1_operator_64_false_1_or_91_nl
      , operator_64_false_1_operator_64_false_1_or_92_nl , operator_64_false_1_operator_64_false_1_or_93_nl
      , operator_64_false_1_operator_64_false_1_or_94_nl , operator_64_false_1_operator_64_false_1_or_95_nl
      , operator_64_false_1_operator_64_false_1_or_96_nl , operator_64_false_1_operator_64_false_1_or_97_nl
      , operator_64_false_1_operator_64_false_1_or_98_nl , operator_64_false_1_operator_64_false_1_or_99_nl
      , operator_64_false_1_operator_64_false_1_or_100_nl , operator_64_false_1_operator_64_false_1_or_101_nl
      , operator_64_false_1_operator_64_false_1_or_102_nl , operator_64_false_1_operator_64_false_1_or_103_nl
      , operator_64_false_1_operator_64_false_1_or_104_nl , operator_64_false_1_operator_64_false_1_or_105_nl
      , operator_64_false_1_or_17_nl , operator_64_false_1_or_18_nl});
  assign z_out_3 = nl_z_out_3[64:0];
  assign and_348_nl = nor_183_cse & (~ (fsm_output[7])) & (fsm_output[2]) & (fsm_output[1])
      & (~ (fsm_output[5])) & (fsm_output[0]) & (~ (fsm_output[6]));
  assign and_350_nl = (fsm_output[1]) & (~ mux_331_itm);
  assign nand_63_nl = ~((fsm_output[7]) & (fsm_output[3]));
  assign mux_389_nl = MUX_s_1_2_2(nand_63_nl, or_tmp_315, fsm_output[2]);
  assign nor_187_nl = ~((fsm_output[1]) | mux_389_nl);
  assign mux_388_nl = MUX_s_1_2_2(and_350_nl, nor_187_nl, fsm_output[6]);
  assign modExp_while_if_or_1_nl = and_dcpl_265 | (mux_388_nl & and_dcpl_266 & (fsm_output[5])
      & (~ (fsm_output[0])));
  assign nor_188_nl = ~((fsm_output[5]) | (fsm_output[1]) | (fsm_output[2]) | (fsm_output[7])
      | (~ (fsm_output[3])));
  assign and_352_nl = (fsm_output[5]) & (fsm_output[1]) & (~ mux_331_itm);
  assign mux_391_nl = MUX_s_1_2_2(nor_188_nl, and_352_nl, fsm_output[0]);
  assign and_353_nl = (fsm_output[0]) & (fsm_output[5]) & (fsm_output[1]) & (~ mux_331_itm);
  assign mux_390_nl = MUX_s_1_2_2(mux_391_nl, and_353_nl, fsm_output[6]);
  assign and_351_nl = mux_390_nl & and_dcpl_266;
  assign modExp_while_if_mux1h_1_nl = MUX1HOT_v_64_3_2(modExp_result_sva, operator_64_false_acc_mut_63_0,
      modExp_base_1_sva, {and_348_nl , modExp_while_if_or_1_nl , and_351_nl});
  assign modExp_while_if_and_4_nl = (~ (COMP_LOOP_acc_10_cse_12_1_1_sva[0])) & and_dcpl_265;
  assign modExp_while_if_and_5_nl = (COMP_LOOP_acc_10_cse_12_1_1_sva[0]) & and_dcpl_265;
  assign modExp_while_if_modExp_while_if_mux1h_1_nl = MUX1HOT_v_64_3_2(modExp_base_1_sva,
      vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, {(~ and_dcpl_265) , modExp_while_if_and_4_nl
      , modExp_while_if_and_5_nl});
  assign nl_z_out_5 = modExp_while_if_mux1h_1_nl * modExp_while_if_modExp_while_if_mux1h_1_nl;
  assign z_out_5 = nl_z_out_5[63:0];

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


  function automatic [9:0] MUX1HOT_v_10_6_2;
    input [9:0] input_5;
    input [9:0] input_4;
    input [9:0] input_3;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [5:0] sel;
    reg [9:0] result;
  begin
    result = input_0 & {10{sel[0]}};
    result = result | ( input_1 & {10{sel[1]}});
    result = result | ( input_2 & {10{sel[2]}});
    result = result | ( input_3 & {10{sel[3]}});
    result = result | ( input_4 & {10{sel[4]}});
    result = result | ( input_5 & {10{sel[5]}});
    MUX1HOT_v_10_6_2 = result;
  end
  endfunction


  function automatic [9:0] MUX1HOT_v_10_9_2;
    input [9:0] input_8;
    input [9:0] input_7;
    input [9:0] input_6;
    input [9:0] input_5;
    input [9:0] input_4;
    input [9:0] input_3;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [8:0] sel;
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
    MUX1HOT_v_10_9_2 = result;
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


  function automatic [1:0] MUX1HOT_v_2_3_2;
    input [1:0] input_2;
    input [1:0] input_1;
    input [1:0] input_0;
    input [2:0] sel;
    reg [1:0] result;
  begin
    result = input_0 & {2{sel[0]}};
    result = result | ( input_1 & {2{sel[1]}});
    result = result | ( input_2 & {2{sel[2]}});
    MUX1HOT_v_2_3_2 = result;
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


  function automatic [50:0] MUX1HOT_v_51_3_2;
    input [50:0] input_2;
    input [50:0] input_1;
    input [50:0] input_0;
    input [2:0] sel;
    reg [50:0] result;
  begin
    result = input_0 & {51{sel[0]}};
    result = result | ( input_1 & {51{sel[1]}});
    result = result | ( input_2 & {51{sel[2]}});
    MUX1HOT_v_51_3_2 = result;
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


  function automatic [64:0] MUX1HOT_v_65_3_2;
    input [64:0] input_2;
    input [64:0] input_1;
    input [64:0] input_0;
    input [2:0] sel;
    reg [64:0] result;
  begin
    result = input_0 & {65{sel[0]}};
    result = result | ( input_1 & {65{sel[1]}});
    result = result | ( input_2 & {65{sel[2]}});
    MUX1HOT_v_65_3_2 = result;
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


  function automatic [50:0] MUX_v_51_2_2;
    input [50:0] input_0;
    input [50:0] input_1;
    input [0:0] sel;
    reg [50:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_51_2_2 = result;
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


  function automatic [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
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


  function automatic [64:0] conv_s2u_64_65 ;
    input [63:0]  vector ;
  begin
    conv_s2u_64_65 = {vector[63], vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_8_11 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_11 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [11:0] conv_u2u_9_12 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_12 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
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
  wire [10:0] vec_rsc_0_0_i_adra_d_iff;
  wire [63:0] vec_rsc_0_0_i_da_d_iff;
  wire vec_rsc_0_0_i_wea_d_iff;
  wire vec_rsc_0_1_i_wea_d_iff;


  // Interconnect Declarations for Component Instantiations 
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
      .vec_rsc_0_0_i_adra_d_pff(vec_rsc_0_0_i_adra_d_iff),
      .vec_rsc_0_0_i_da_d_pff(vec_rsc_0_0_i_da_d_iff),
      .vec_rsc_0_0_i_wea_d_pff(vec_rsc_0_0_i_wea_d_iff),
      .vec_rsc_0_1_i_wea_d_pff(vec_rsc_0_1_i_wea_d_iff)
    );
endmodule



