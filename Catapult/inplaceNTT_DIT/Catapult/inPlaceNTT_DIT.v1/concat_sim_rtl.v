
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

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Mon May 17 21:25:32 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_1_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_1_10_64_1024_1024_64_1_gen
    (
  qa, wea, da, adra, adra_d, da_d, qa_d, wea_d, rwA_rw_ram_ir_internal_RMASK_B_d,
      rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [63:0] qa;
  output wea;
  output [63:0] da;
  output [9:0] adra;
  input [9:0] adra_d;
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
  clk, rst, fsm_output, STAGE_LOOP_C_10_tr0, modExp_while_C_47_tr0, COMP_LOOP_C_1_tr0,
      modExp_1_while_C_47_tr0, COMP_LOOP_C_76_tr0, VEC_LOOP_C_0_tr0, STAGE_LOOP_C_11_tr0
);
  input clk;
  input rst;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input STAGE_LOOP_C_10_tr0;
  input modExp_while_C_47_tr0;
  input COMP_LOOP_C_1_tr0;
  input modExp_1_while_C_47_tr0;
  input COMP_LOOP_C_76_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_11_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_core_core_fsm_1
  parameter
    main_C_0 = 8'd0,
    STAGE_LOOP_C_0 = 8'd1,
    STAGE_LOOP_C_1 = 8'd2,
    STAGE_LOOP_C_2 = 8'd3,
    STAGE_LOOP_C_3 = 8'd4,
    STAGE_LOOP_C_4 = 8'd5,
    STAGE_LOOP_C_5 = 8'd6,
    STAGE_LOOP_C_6 = 8'd7,
    STAGE_LOOP_C_7 = 8'd8,
    STAGE_LOOP_C_8 = 8'd9,
    STAGE_LOOP_C_9 = 8'd10,
    STAGE_LOOP_C_10 = 8'd11,
    modExp_while_C_0 = 8'd12,
    modExp_while_C_1 = 8'd13,
    modExp_while_C_2 = 8'd14,
    modExp_while_C_3 = 8'd15,
    modExp_while_C_4 = 8'd16,
    modExp_while_C_5 = 8'd17,
    modExp_while_C_6 = 8'd18,
    modExp_while_C_7 = 8'd19,
    modExp_while_C_8 = 8'd20,
    modExp_while_C_9 = 8'd21,
    modExp_while_C_10 = 8'd22,
    modExp_while_C_11 = 8'd23,
    modExp_while_C_12 = 8'd24,
    modExp_while_C_13 = 8'd25,
    modExp_while_C_14 = 8'd26,
    modExp_while_C_15 = 8'd27,
    modExp_while_C_16 = 8'd28,
    modExp_while_C_17 = 8'd29,
    modExp_while_C_18 = 8'd30,
    modExp_while_C_19 = 8'd31,
    modExp_while_C_20 = 8'd32,
    modExp_while_C_21 = 8'd33,
    modExp_while_C_22 = 8'd34,
    modExp_while_C_23 = 8'd35,
    modExp_while_C_24 = 8'd36,
    modExp_while_C_25 = 8'd37,
    modExp_while_C_26 = 8'd38,
    modExp_while_C_27 = 8'd39,
    modExp_while_C_28 = 8'd40,
    modExp_while_C_29 = 8'd41,
    modExp_while_C_30 = 8'd42,
    modExp_while_C_31 = 8'd43,
    modExp_while_C_32 = 8'd44,
    modExp_while_C_33 = 8'd45,
    modExp_while_C_34 = 8'd46,
    modExp_while_C_35 = 8'd47,
    modExp_while_C_36 = 8'd48,
    modExp_while_C_37 = 8'd49,
    modExp_while_C_38 = 8'd50,
    modExp_while_C_39 = 8'd51,
    modExp_while_C_40 = 8'd52,
    modExp_while_C_41 = 8'd53,
    modExp_while_C_42 = 8'd54,
    modExp_while_C_43 = 8'd55,
    modExp_while_C_44 = 8'd56,
    modExp_while_C_45 = 8'd57,
    modExp_while_C_46 = 8'd58,
    modExp_while_C_47 = 8'd59,
    COMP_LOOP_C_0 = 8'd60,
    COMP_LOOP_C_1 = 8'd61,
    modExp_1_while_C_0 = 8'd62,
    modExp_1_while_C_1 = 8'd63,
    modExp_1_while_C_2 = 8'd64,
    modExp_1_while_C_3 = 8'd65,
    modExp_1_while_C_4 = 8'd66,
    modExp_1_while_C_5 = 8'd67,
    modExp_1_while_C_6 = 8'd68,
    modExp_1_while_C_7 = 8'd69,
    modExp_1_while_C_8 = 8'd70,
    modExp_1_while_C_9 = 8'd71,
    modExp_1_while_C_10 = 8'd72,
    modExp_1_while_C_11 = 8'd73,
    modExp_1_while_C_12 = 8'd74,
    modExp_1_while_C_13 = 8'd75,
    modExp_1_while_C_14 = 8'd76,
    modExp_1_while_C_15 = 8'd77,
    modExp_1_while_C_16 = 8'd78,
    modExp_1_while_C_17 = 8'd79,
    modExp_1_while_C_18 = 8'd80,
    modExp_1_while_C_19 = 8'd81,
    modExp_1_while_C_20 = 8'd82,
    modExp_1_while_C_21 = 8'd83,
    modExp_1_while_C_22 = 8'd84,
    modExp_1_while_C_23 = 8'd85,
    modExp_1_while_C_24 = 8'd86,
    modExp_1_while_C_25 = 8'd87,
    modExp_1_while_C_26 = 8'd88,
    modExp_1_while_C_27 = 8'd89,
    modExp_1_while_C_28 = 8'd90,
    modExp_1_while_C_29 = 8'd91,
    modExp_1_while_C_30 = 8'd92,
    modExp_1_while_C_31 = 8'd93,
    modExp_1_while_C_32 = 8'd94,
    modExp_1_while_C_33 = 8'd95,
    modExp_1_while_C_34 = 8'd96,
    modExp_1_while_C_35 = 8'd97,
    modExp_1_while_C_36 = 8'd98,
    modExp_1_while_C_37 = 8'd99,
    modExp_1_while_C_38 = 8'd100,
    modExp_1_while_C_39 = 8'd101,
    modExp_1_while_C_40 = 8'd102,
    modExp_1_while_C_41 = 8'd103,
    modExp_1_while_C_42 = 8'd104,
    modExp_1_while_C_43 = 8'd105,
    modExp_1_while_C_44 = 8'd106,
    modExp_1_while_C_45 = 8'd107,
    modExp_1_while_C_46 = 8'd108,
    modExp_1_while_C_47 = 8'd109,
    COMP_LOOP_C_2 = 8'd110,
    COMP_LOOP_C_3 = 8'd111,
    COMP_LOOP_C_4 = 8'd112,
    COMP_LOOP_C_5 = 8'd113,
    COMP_LOOP_C_6 = 8'd114,
    COMP_LOOP_C_7 = 8'd115,
    COMP_LOOP_C_8 = 8'd116,
    COMP_LOOP_C_9 = 8'd117,
    COMP_LOOP_C_10 = 8'd118,
    COMP_LOOP_C_11 = 8'd119,
    COMP_LOOP_C_12 = 8'd120,
    COMP_LOOP_C_13 = 8'd121,
    COMP_LOOP_C_14 = 8'd122,
    COMP_LOOP_C_15 = 8'd123,
    COMP_LOOP_C_16 = 8'd124,
    COMP_LOOP_C_17 = 8'd125,
    COMP_LOOP_C_18 = 8'd126,
    COMP_LOOP_C_19 = 8'd127,
    COMP_LOOP_C_20 = 8'd128,
    COMP_LOOP_C_21 = 8'd129,
    COMP_LOOP_C_22 = 8'd130,
    COMP_LOOP_C_23 = 8'd131,
    COMP_LOOP_C_24 = 8'd132,
    COMP_LOOP_C_25 = 8'd133,
    COMP_LOOP_C_26 = 8'd134,
    COMP_LOOP_C_27 = 8'd135,
    COMP_LOOP_C_28 = 8'd136,
    COMP_LOOP_C_29 = 8'd137,
    COMP_LOOP_C_30 = 8'd138,
    COMP_LOOP_C_31 = 8'd139,
    COMP_LOOP_C_32 = 8'd140,
    COMP_LOOP_C_33 = 8'd141,
    COMP_LOOP_C_34 = 8'd142,
    COMP_LOOP_C_35 = 8'd143,
    COMP_LOOP_C_36 = 8'd144,
    COMP_LOOP_C_37 = 8'd145,
    COMP_LOOP_C_38 = 8'd146,
    COMP_LOOP_C_39 = 8'd147,
    COMP_LOOP_C_40 = 8'd148,
    COMP_LOOP_C_41 = 8'd149,
    COMP_LOOP_C_42 = 8'd150,
    COMP_LOOP_C_43 = 8'd151,
    COMP_LOOP_C_44 = 8'd152,
    COMP_LOOP_C_45 = 8'd153,
    COMP_LOOP_C_46 = 8'd154,
    COMP_LOOP_C_47 = 8'd155,
    COMP_LOOP_C_48 = 8'd156,
    COMP_LOOP_C_49 = 8'd157,
    COMP_LOOP_C_50 = 8'd158,
    COMP_LOOP_C_51 = 8'd159,
    COMP_LOOP_C_52 = 8'd160,
    COMP_LOOP_C_53 = 8'd161,
    COMP_LOOP_C_54 = 8'd162,
    COMP_LOOP_C_55 = 8'd163,
    COMP_LOOP_C_56 = 8'd164,
    COMP_LOOP_C_57 = 8'd165,
    COMP_LOOP_C_58 = 8'd166,
    COMP_LOOP_C_59 = 8'd167,
    COMP_LOOP_C_60 = 8'd168,
    COMP_LOOP_C_61 = 8'd169,
    COMP_LOOP_C_62 = 8'd170,
    COMP_LOOP_C_63 = 8'd171,
    COMP_LOOP_C_64 = 8'd172,
    COMP_LOOP_C_65 = 8'd173,
    COMP_LOOP_C_66 = 8'd174,
    COMP_LOOP_C_67 = 8'd175,
    COMP_LOOP_C_68 = 8'd176,
    COMP_LOOP_C_69 = 8'd177,
    COMP_LOOP_C_70 = 8'd178,
    COMP_LOOP_C_71 = 8'd179,
    COMP_LOOP_C_72 = 8'd180,
    COMP_LOOP_C_73 = 8'd181,
    COMP_LOOP_C_74 = 8'd182,
    COMP_LOOP_C_75 = 8'd183,
    COMP_LOOP_C_76 = 8'd184,
    VEC_LOOP_C_0 = 8'd185,
    STAGE_LOOP_C_11 = 8'd186,
    main_C_1 = 8'd187;

  reg [7:0] state_var;
  reg [7:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIT_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 8'b00000001;
        state_var_NS = STAGE_LOOP_C_1;
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 8'b00000010;
        state_var_NS = STAGE_LOOP_C_2;
      end
      STAGE_LOOP_C_2 : begin
        fsm_output = 8'b00000011;
        state_var_NS = STAGE_LOOP_C_3;
      end
      STAGE_LOOP_C_3 : begin
        fsm_output = 8'b00000100;
        state_var_NS = STAGE_LOOP_C_4;
      end
      STAGE_LOOP_C_4 : begin
        fsm_output = 8'b00000101;
        state_var_NS = STAGE_LOOP_C_5;
      end
      STAGE_LOOP_C_5 : begin
        fsm_output = 8'b00000110;
        state_var_NS = STAGE_LOOP_C_6;
      end
      STAGE_LOOP_C_6 : begin
        fsm_output = 8'b00000111;
        state_var_NS = STAGE_LOOP_C_7;
      end
      STAGE_LOOP_C_7 : begin
        fsm_output = 8'b00001000;
        state_var_NS = STAGE_LOOP_C_8;
      end
      STAGE_LOOP_C_8 : begin
        fsm_output = 8'b00001001;
        state_var_NS = STAGE_LOOP_C_9;
      end
      STAGE_LOOP_C_9 : begin
        fsm_output = 8'b00001010;
        state_var_NS = STAGE_LOOP_C_10;
      end
      STAGE_LOOP_C_10 : begin
        fsm_output = 8'b00001011;
        if ( STAGE_LOOP_C_10_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      modExp_while_C_0 : begin
        fsm_output = 8'b00001100;
        state_var_NS = modExp_while_C_1;
      end
      modExp_while_C_1 : begin
        fsm_output = 8'b00001101;
        state_var_NS = modExp_while_C_2;
      end
      modExp_while_C_2 : begin
        fsm_output = 8'b00001110;
        state_var_NS = modExp_while_C_3;
      end
      modExp_while_C_3 : begin
        fsm_output = 8'b00001111;
        state_var_NS = modExp_while_C_4;
      end
      modExp_while_C_4 : begin
        fsm_output = 8'b00010000;
        state_var_NS = modExp_while_C_5;
      end
      modExp_while_C_5 : begin
        fsm_output = 8'b00010001;
        state_var_NS = modExp_while_C_6;
      end
      modExp_while_C_6 : begin
        fsm_output = 8'b00010010;
        state_var_NS = modExp_while_C_7;
      end
      modExp_while_C_7 : begin
        fsm_output = 8'b00010011;
        state_var_NS = modExp_while_C_8;
      end
      modExp_while_C_8 : begin
        fsm_output = 8'b00010100;
        state_var_NS = modExp_while_C_9;
      end
      modExp_while_C_9 : begin
        fsm_output = 8'b00010101;
        state_var_NS = modExp_while_C_10;
      end
      modExp_while_C_10 : begin
        fsm_output = 8'b00010110;
        state_var_NS = modExp_while_C_11;
      end
      modExp_while_C_11 : begin
        fsm_output = 8'b00010111;
        state_var_NS = modExp_while_C_12;
      end
      modExp_while_C_12 : begin
        fsm_output = 8'b00011000;
        state_var_NS = modExp_while_C_13;
      end
      modExp_while_C_13 : begin
        fsm_output = 8'b00011001;
        state_var_NS = modExp_while_C_14;
      end
      modExp_while_C_14 : begin
        fsm_output = 8'b00011010;
        state_var_NS = modExp_while_C_15;
      end
      modExp_while_C_15 : begin
        fsm_output = 8'b00011011;
        state_var_NS = modExp_while_C_16;
      end
      modExp_while_C_16 : begin
        fsm_output = 8'b00011100;
        state_var_NS = modExp_while_C_17;
      end
      modExp_while_C_17 : begin
        fsm_output = 8'b00011101;
        state_var_NS = modExp_while_C_18;
      end
      modExp_while_C_18 : begin
        fsm_output = 8'b00011110;
        state_var_NS = modExp_while_C_19;
      end
      modExp_while_C_19 : begin
        fsm_output = 8'b00011111;
        state_var_NS = modExp_while_C_20;
      end
      modExp_while_C_20 : begin
        fsm_output = 8'b00100000;
        state_var_NS = modExp_while_C_21;
      end
      modExp_while_C_21 : begin
        fsm_output = 8'b00100001;
        state_var_NS = modExp_while_C_22;
      end
      modExp_while_C_22 : begin
        fsm_output = 8'b00100010;
        state_var_NS = modExp_while_C_23;
      end
      modExp_while_C_23 : begin
        fsm_output = 8'b00100011;
        state_var_NS = modExp_while_C_24;
      end
      modExp_while_C_24 : begin
        fsm_output = 8'b00100100;
        state_var_NS = modExp_while_C_25;
      end
      modExp_while_C_25 : begin
        fsm_output = 8'b00100101;
        state_var_NS = modExp_while_C_26;
      end
      modExp_while_C_26 : begin
        fsm_output = 8'b00100110;
        state_var_NS = modExp_while_C_27;
      end
      modExp_while_C_27 : begin
        fsm_output = 8'b00100111;
        state_var_NS = modExp_while_C_28;
      end
      modExp_while_C_28 : begin
        fsm_output = 8'b00101000;
        state_var_NS = modExp_while_C_29;
      end
      modExp_while_C_29 : begin
        fsm_output = 8'b00101001;
        state_var_NS = modExp_while_C_30;
      end
      modExp_while_C_30 : begin
        fsm_output = 8'b00101010;
        state_var_NS = modExp_while_C_31;
      end
      modExp_while_C_31 : begin
        fsm_output = 8'b00101011;
        state_var_NS = modExp_while_C_32;
      end
      modExp_while_C_32 : begin
        fsm_output = 8'b00101100;
        state_var_NS = modExp_while_C_33;
      end
      modExp_while_C_33 : begin
        fsm_output = 8'b00101101;
        state_var_NS = modExp_while_C_34;
      end
      modExp_while_C_34 : begin
        fsm_output = 8'b00101110;
        state_var_NS = modExp_while_C_35;
      end
      modExp_while_C_35 : begin
        fsm_output = 8'b00101111;
        state_var_NS = modExp_while_C_36;
      end
      modExp_while_C_36 : begin
        fsm_output = 8'b00110000;
        state_var_NS = modExp_while_C_37;
      end
      modExp_while_C_37 : begin
        fsm_output = 8'b00110001;
        state_var_NS = modExp_while_C_38;
      end
      modExp_while_C_38 : begin
        fsm_output = 8'b00110010;
        state_var_NS = modExp_while_C_39;
      end
      modExp_while_C_39 : begin
        fsm_output = 8'b00110011;
        state_var_NS = modExp_while_C_40;
      end
      modExp_while_C_40 : begin
        fsm_output = 8'b00110100;
        state_var_NS = modExp_while_C_41;
      end
      modExp_while_C_41 : begin
        fsm_output = 8'b00110101;
        state_var_NS = modExp_while_C_42;
      end
      modExp_while_C_42 : begin
        fsm_output = 8'b00110110;
        state_var_NS = modExp_while_C_43;
      end
      modExp_while_C_43 : begin
        fsm_output = 8'b00110111;
        state_var_NS = modExp_while_C_44;
      end
      modExp_while_C_44 : begin
        fsm_output = 8'b00111000;
        state_var_NS = modExp_while_C_45;
      end
      modExp_while_C_45 : begin
        fsm_output = 8'b00111001;
        state_var_NS = modExp_while_C_46;
      end
      modExp_while_C_46 : begin
        fsm_output = 8'b00111010;
        state_var_NS = modExp_while_C_47;
      end
      modExp_while_C_47 : begin
        fsm_output = 8'b00111011;
        if ( modExp_while_C_47_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 8'b00111100;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 8'b00111101;
        if ( COMP_LOOP_C_1_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = modExp_1_while_C_0;
        end
      end
      modExp_1_while_C_0 : begin
        fsm_output = 8'b00111110;
        state_var_NS = modExp_1_while_C_1;
      end
      modExp_1_while_C_1 : begin
        fsm_output = 8'b00111111;
        state_var_NS = modExp_1_while_C_2;
      end
      modExp_1_while_C_2 : begin
        fsm_output = 8'b01000000;
        state_var_NS = modExp_1_while_C_3;
      end
      modExp_1_while_C_3 : begin
        fsm_output = 8'b01000001;
        state_var_NS = modExp_1_while_C_4;
      end
      modExp_1_while_C_4 : begin
        fsm_output = 8'b01000010;
        state_var_NS = modExp_1_while_C_5;
      end
      modExp_1_while_C_5 : begin
        fsm_output = 8'b01000011;
        state_var_NS = modExp_1_while_C_6;
      end
      modExp_1_while_C_6 : begin
        fsm_output = 8'b01000100;
        state_var_NS = modExp_1_while_C_7;
      end
      modExp_1_while_C_7 : begin
        fsm_output = 8'b01000101;
        state_var_NS = modExp_1_while_C_8;
      end
      modExp_1_while_C_8 : begin
        fsm_output = 8'b01000110;
        state_var_NS = modExp_1_while_C_9;
      end
      modExp_1_while_C_9 : begin
        fsm_output = 8'b01000111;
        state_var_NS = modExp_1_while_C_10;
      end
      modExp_1_while_C_10 : begin
        fsm_output = 8'b01001000;
        state_var_NS = modExp_1_while_C_11;
      end
      modExp_1_while_C_11 : begin
        fsm_output = 8'b01001001;
        state_var_NS = modExp_1_while_C_12;
      end
      modExp_1_while_C_12 : begin
        fsm_output = 8'b01001010;
        state_var_NS = modExp_1_while_C_13;
      end
      modExp_1_while_C_13 : begin
        fsm_output = 8'b01001011;
        state_var_NS = modExp_1_while_C_14;
      end
      modExp_1_while_C_14 : begin
        fsm_output = 8'b01001100;
        state_var_NS = modExp_1_while_C_15;
      end
      modExp_1_while_C_15 : begin
        fsm_output = 8'b01001101;
        state_var_NS = modExp_1_while_C_16;
      end
      modExp_1_while_C_16 : begin
        fsm_output = 8'b01001110;
        state_var_NS = modExp_1_while_C_17;
      end
      modExp_1_while_C_17 : begin
        fsm_output = 8'b01001111;
        state_var_NS = modExp_1_while_C_18;
      end
      modExp_1_while_C_18 : begin
        fsm_output = 8'b01010000;
        state_var_NS = modExp_1_while_C_19;
      end
      modExp_1_while_C_19 : begin
        fsm_output = 8'b01010001;
        state_var_NS = modExp_1_while_C_20;
      end
      modExp_1_while_C_20 : begin
        fsm_output = 8'b01010010;
        state_var_NS = modExp_1_while_C_21;
      end
      modExp_1_while_C_21 : begin
        fsm_output = 8'b01010011;
        state_var_NS = modExp_1_while_C_22;
      end
      modExp_1_while_C_22 : begin
        fsm_output = 8'b01010100;
        state_var_NS = modExp_1_while_C_23;
      end
      modExp_1_while_C_23 : begin
        fsm_output = 8'b01010101;
        state_var_NS = modExp_1_while_C_24;
      end
      modExp_1_while_C_24 : begin
        fsm_output = 8'b01010110;
        state_var_NS = modExp_1_while_C_25;
      end
      modExp_1_while_C_25 : begin
        fsm_output = 8'b01010111;
        state_var_NS = modExp_1_while_C_26;
      end
      modExp_1_while_C_26 : begin
        fsm_output = 8'b01011000;
        state_var_NS = modExp_1_while_C_27;
      end
      modExp_1_while_C_27 : begin
        fsm_output = 8'b01011001;
        state_var_NS = modExp_1_while_C_28;
      end
      modExp_1_while_C_28 : begin
        fsm_output = 8'b01011010;
        state_var_NS = modExp_1_while_C_29;
      end
      modExp_1_while_C_29 : begin
        fsm_output = 8'b01011011;
        state_var_NS = modExp_1_while_C_30;
      end
      modExp_1_while_C_30 : begin
        fsm_output = 8'b01011100;
        state_var_NS = modExp_1_while_C_31;
      end
      modExp_1_while_C_31 : begin
        fsm_output = 8'b01011101;
        state_var_NS = modExp_1_while_C_32;
      end
      modExp_1_while_C_32 : begin
        fsm_output = 8'b01011110;
        state_var_NS = modExp_1_while_C_33;
      end
      modExp_1_while_C_33 : begin
        fsm_output = 8'b01011111;
        state_var_NS = modExp_1_while_C_34;
      end
      modExp_1_while_C_34 : begin
        fsm_output = 8'b01100000;
        state_var_NS = modExp_1_while_C_35;
      end
      modExp_1_while_C_35 : begin
        fsm_output = 8'b01100001;
        state_var_NS = modExp_1_while_C_36;
      end
      modExp_1_while_C_36 : begin
        fsm_output = 8'b01100010;
        state_var_NS = modExp_1_while_C_37;
      end
      modExp_1_while_C_37 : begin
        fsm_output = 8'b01100011;
        state_var_NS = modExp_1_while_C_38;
      end
      modExp_1_while_C_38 : begin
        fsm_output = 8'b01100100;
        state_var_NS = modExp_1_while_C_39;
      end
      modExp_1_while_C_39 : begin
        fsm_output = 8'b01100101;
        state_var_NS = modExp_1_while_C_40;
      end
      modExp_1_while_C_40 : begin
        fsm_output = 8'b01100110;
        state_var_NS = modExp_1_while_C_41;
      end
      modExp_1_while_C_41 : begin
        fsm_output = 8'b01100111;
        state_var_NS = modExp_1_while_C_42;
      end
      modExp_1_while_C_42 : begin
        fsm_output = 8'b01101000;
        state_var_NS = modExp_1_while_C_43;
      end
      modExp_1_while_C_43 : begin
        fsm_output = 8'b01101001;
        state_var_NS = modExp_1_while_C_44;
      end
      modExp_1_while_C_44 : begin
        fsm_output = 8'b01101010;
        state_var_NS = modExp_1_while_C_45;
      end
      modExp_1_while_C_45 : begin
        fsm_output = 8'b01101011;
        state_var_NS = modExp_1_while_C_46;
      end
      modExp_1_while_C_46 : begin
        fsm_output = 8'b01101100;
        state_var_NS = modExp_1_while_C_47;
      end
      modExp_1_while_C_47 : begin
        fsm_output = 8'b01101101;
        if ( modExp_1_while_C_47_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = modExp_1_while_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 8'b01101110;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 8'b01101111;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 8'b01110000;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 8'b01110001;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 8'b01110010;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 8'b01110011;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 8'b01110100;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 8'b01110101;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 8'b01110110;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 8'b01110111;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 8'b01111000;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 8'b01111001;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 8'b01111010;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 8'b01111011;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 8'b01111100;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 8'b01111101;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 8'b01111110;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 8'b01111111;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 8'b10000000;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 8'b10000001;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 8'b10000010;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 8'b10000011;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 8'b10000100;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 8'b10000101;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 8'b10000110;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 8'b10000111;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 8'b10001000;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 8'b10001001;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 8'b10001010;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 8'b10001011;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 8'b10001100;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 8'b10001101;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 8'b10001110;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 8'b10001111;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 8'b10010000;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 8'b10010001;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 8'b10010010;
        state_var_NS = COMP_LOOP_C_39;
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 8'b10010011;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 8'b10010100;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 8'b10010101;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 8'b10010110;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 8'b10010111;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 8'b10011000;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 8'b10011001;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 8'b10011010;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 8'b10011011;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 8'b10011100;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 8'b10011101;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 8'b10011110;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 8'b10011111;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 8'b10100000;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 8'b10100001;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 8'b10100010;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 8'b10100011;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 8'b10100100;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 8'b10100101;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 8'b10100110;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 8'b10100111;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 8'b10101000;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 8'b10101001;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 8'b10101010;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 8'b10101011;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 8'b10101100;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 8'b10101101;
        state_var_NS = COMP_LOOP_C_66;
      end
      COMP_LOOP_C_66 : begin
        fsm_output = 8'b10101110;
        state_var_NS = COMP_LOOP_C_67;
      end
      COMP_LOOP_C_67 : begin
        fsm_output = 8'b10101111;
        state_var_NS = COMP_LOOP_C_68;
      end
      COMP_LOOP_C_68 : begin
        fsm_output = 8'b10110000;
        state_var_NS = COMP_LOOP_C_69;
      end
      COMP_LOOP_C_69 : begin
        fsm_output = 8'b10110001;
        state_var_NS = COMP_LOOP_C_70;
      end
      COMP_LOOP_C_70 : begin
        fsm_output = 8'b10110010;
        state_var_NS = COMP_LOOP_C_71;
      end
      COMP_LOOP_C_71 : begin
        fsm_output = 8'b10110011;
        state_var_NS = COMP_LOOP_C_72;
      end
      COMP_LOOP_C_72 : begin
        fsm_output = 8'b10110100;
        state_var_NS = COMP_LOOP_C_73;
      end
      COMP_LOOP_C_73 : begin
        fsm_output = 8'b10110101;
        state_var_NS = COMP_LOOP_C_74;
      end
      COMP_LOOP_C_74 : begin
        fsm_output = 8'b10110110;
        state_var_NS = COMP_LOOP_C_75;
      end
      COMP_LOOP_C_75 : begin
        fsm_output = 8'b10110111;
        state_var_NS = COMP_LOOP_C_76;
      end
      COMP_LOOP_C_76 : begin
        fsm_output = 8'b10111000;
        if ( COMP_LOOP_C_76_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 8'b10111001;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_11;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_11 : begin
        fsm_output = 8'b10111010;
        if ( STAGE_LOOP_C_11_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 8'b10111011;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 8'b00000000;
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
  clk, operator_66_true_div_cmp_z, operator_66_true_div_cmp_z_oreg
);
  input clk;
  input [64:0] operator_66_true_div_cmp_z;
  output [63:0] operator_66_true_div_cmp_z_oreg;


  // Interconnect Declarations
  reg [63:0] operator_66_true_div_cmp_z_oreg_pconst_63_0;


  // Interconnect Declarations for Component Instantiations 
  assign operator_66_true_div_cmp_z_oreg = operator_66_true_div_cmp_z_oreg_pconst_63_0;
  always @(posedge clk) begin
    operator_66_true_div_cmp_z_oreg_pconst_63_0 <= operator_66_true_div_cmp_z[63:0];
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIT_core
// ------------------------------------------------------------------


module inPlaceNTT_DIT_core (
  clk, rst, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz,
      vec_rsci_adra_d, vec_rsci_da_d, vec_rsci_qa_d, vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      operator_66_true_div_cmp_a, operator_66_true_div_cmp_b, operator_66_true_div_cmp_z,
      vec_rsci_wea_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [9:0] vec_rsci_adra_d;
  output [63:0] vec_rsci_da_d;
  input [63:0] vec_rsci_qa_d;
  output vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  output [64:0] operator_66_true_div_cmp_a;
  reg [64:0] operator_66_true_div_cmp_a;
  output [10:0] operator_66_true_div_cmp_b;
  input [64:0] operator_66_true_div_cmp_z;
  output vec_rsci_wea_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  wire [63:0] r_rsci_idat;
  reg [63:0] modulo_result_rem_cmp_a;
  reg [63:0] modulo_result_rem_cmp_b;
  wire [63:0] modulo_result_rem_cmp_z;
  wire [63:0] operator_66_true_div_cmp_z_oreg;
  wire [7:0] fsm_output;
  wire or_tmp_36;
  wire and_dcpl_9;
  wire and_dcpl_10;
  wire and_dcpl_11;
  wire and_dcpl_12;
  wire and_dcpl_13;
  wire and_dcpl_14;
  wire and_dcpl_16;
  wire and_dcpl_17;
  wire and_dcpl_19;
  wire and_dcpl_20;
  wire and_dcpl_21;
  wire and_dcpl_23;
  wire and_dcpl_24;
  wire and_dcpl_25;
  wire and_dcpl_26;
  wire and_dcpl_28;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_52;
  wire and_dcpl_53;
  wire or_tmp_41;
  wire not_tmp_47;
  wire or_tmp_48;
  wire or_tmp_50;
  wire and_dcpl_64;
  wire and_dcpl_65;
  wire and_dcpl_74;
  wire mux_tmp_50;
  wire and_dcpl_75;
  wire and_dcpl_76;
  wire and_dcpl_81;
  wire or_tmp_66;
  wire mux_tmp_54;
  wire mux_tmp_72;
  wire or_tmp_80;
  wire and_dcpl_88;
  wire and_dcpl_89;
  wire and_dcpl_94;
  wire and_dcpl_95;
  wire mux_tmp_99;
  wire and_dcpl_100;
  wire and_dcpl_104;
  wire or_dcpl_28;
  wire or_dcpl_32;
  wire and_dcpl_107;
  wire or_tmp_118;
  reg exit_modExp_1_while_sva;
  reg operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  reg modExp_exp_1_0_sva;
  reg [63:0] modExp_base_1_sva;
  reg [63:0] COMP_LOOP_acc_5_mut;
  wire and_90_m1c;
  reg reg_vec_rsc_triosy_obj_ld_cse;
  wire and_133_cse;
  wire or_75_cse;
  wire and_126_cse;
  wire and_115_cse;
  wire [63:0] modulo_5_mux_cse;
  wire and_141_cse;
  wire and_129_cse;
  wire or_173_cse;
  wire or_174_cse;
  wire nand_8_cse;
  wire nand_18_cse;
  wire or_127_cse;
  reg modExp_while_and_itm;
  reg modExp_while_and_1_itm;
  reg [9:0] reg_operator_66_true_div_cmp_b_reg;
  reg [9:0] COMP_LOOP_acc_1_cse_sva;
  reg [9:0] COMP_LOOP_acc_10_cse_10_1_sva;
  wire mux_35_itm;
  wire and_dcpl_116;
  wire and_dcpl_121;
  wire and_dcpl_127;
  wire and_dcpl_132;
  wire [10:0] z_out;
  wire [11:0] nl_z_out;
  wire [9:0] z_out_1;
  wire [10:0] nl_z_out_1;
  wire [9:0] z_out_2;
  wire [10:0] nl_z_out_2;
  wire and_dcpl_164;
  wire and_dcpl_169;
  wire and_dcpl_170;
  wire and_dcpl_174;
  wire and_dcpl_177;
  wire [64:0] z_out_3;
  wire [63:0] z_out_4;
  wire [127:0] nl_z_out_4;
  reg [63:0] p_sva;
  reg [63:0] r_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [9:0] STAGE_LOOP_lshift_psp_sva;
  reg [63:0] modExp_result_sva;
  reg modExp_exp_1_7_sva;
  reg modExp_exp_1_6_sva;
  reg modExp_exp_1_5_sva;
  reg modExp_exp_1_4_sva;
  reg modExp_exp_1_3_sva;
  reg modExp_exp_1_2_sva;
  reg modExp_exp_1_1_sva;
  reg modExp_exp_1_0_sva_1;
  reg [63:0] modExp_while_if_mul_mut;
  reg [63:0] modExp_1_while_if_mul_mut;
  reg [63:0] COMP_LOOP_mul_mut;
  reg [63:0] modExp_while_mul_itm;
  reg [63:0] modExp_1_while_mul_itm;
  reg [8:0] COMP_LOOP_k_9_0_sva_8_0;
  reg [9:0] VEC_LOOP_j_sva_9_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [63:0] COMP_LOOP_acc_5_mut_mx0w7;
  wire [64:0] nl_COMP_LOOP_acc_5_mut_mx0w7;
  wire [9:0] STAGE_LOOP_lshift_psp_sva_mx0w0;
  wire VEC_LOOP_j_sva_9_0_mx0c1;
  wire modExp_result_sva_mx0c0;
  wire [62:0] operator_64_false_slc_modExp_exp_63_1_3;
  wire [63:0] modulo_qr_sva_1_mx1w0;
  wire [64:0] nl_modulo_qr_sva_1_mx1w0;
  wire [63:0] modExp_while_mul_itm_mx0w0;
  wire [127:0] nl_modExp_while_mul_itm_mx0w0;
  wire modExp_result_and_rgt;
  wire modExp_result_and_1_rgt;
  wire COMP_LOOP_or_5_cse;
  wire mux_tmp;
  wire not_tmp_127;
  wire [64:0] operator_64_false_mux1h_2_rgt;
  wire or_tmp_140;
  wire or_tmp_141;
  wire or_tmp_143;
  wire mux_tmp_155;
  reg operator_64_false_acc_mut_64;
  reg [63:0] operator_64_false_acc_mut_63_0;
  wire nand_37_cse;
  wire STAGE_LOOP_acc_itm_2_1;

  wire[0:0] modulo_result_or_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] or_63_nl;
  wire[0:0] and_54_nl;
  wire[0:0] mux_39_nl;
  wire[0:0] or_58_nl;
  wire[0:0] and_57_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] nand_13_nl;
  wire[0:0] nor_72_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] or_68_nl;
  wire[0:0] and_62_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] and_130_nl;
  wire[0:0] nor_57_nl;
  wire[0:0] mux_46_nl;
  wire[0:0] and_128_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] nor_56_nl;
  wire[0:0] and_70_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] and_127_nl;
  wire[0:0] nand_11_nl;
  wire[0:0] and_73_nl;
  wire[0:0] mux_48_nl;
  wire[0:0] and_125_nl;
  wire[0:0] nand_10_nl;
  wire[0:0] nor_55_nl;
  wire[63:0] modExp_result_mux1h_2_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] modExp_1_while_and_nl;
  wire[0:0] modExp_1_while_and_1_nl;
  wire[0:0] and_80_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_141_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] mux_139_nl;
  wire[0:0] or_nl;
  wire[0:0] mux_138_nl;
  wire[0:0] nand_33_nl;
  wire[0:0] nand_34_nl;
  wire[0:0] or_185_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] nor_99_nl;
  wire[0:0] mux_143_nl;
  wire[0:0] or_195_nl;
  wire[0:0] or_194_nl;
  wire[0:0] nor_100_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] nor_101_nl;
  wire[0:0] nor_102_nl;
  wire[0:0] nor_103_nl;
  wire[0:0] nand_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] nor_80_nl;
  wire[0:0] and_151_nl;
  wire[0:0] nor_81_nl;
  wire[0:0] mux_151_nl;
  wire[0:0] mux_150_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] or_199_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] and_236_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] nor_51_nl;
  wire[0:0] nor_52_nl;
  wire[0:0] and_93_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] or_112_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] or_119_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] or_109_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] or_108_nl;
  wire[0:0] or_105_nl;
  wire[0:0] and_96_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] nor_49_nl;
  wire[0:0] nor_50_nl;
  wire[0:0] and_99_nl;
  wire[0:0] mux_162_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] mux_160_nl;
  wire[0:0] nand_35_nl;
  wire[0:0] mux_159_nl;
  wire[0:0] nand_36_nl;
  wire[0:0] mux_158_nl;
  wire[0:0] mux_157_nl;
  wire[0:0] or_208_nl;
  wire[0:0] mux_156_nl;
  wire[0:0] or_207_nl;
  wire[0:0] or_206_nl;
  wire[0:0] or_205_nl;
  wire[0:0] mux_154_nl;
  wire[0:0] nand_30_nl;
  wire[0:0] mux_153_nl;
  wire[0:0] mux_106_nl;
  wire[0:0] mux_105_nl;
  wire[0:0] mux_104_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] and_118_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] COMP_LOOP_and_1_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] mux_112_nl;
  wire[0:0] or_130_nl;
  wire[0:0] mux_111_nl;
  wire[0:0] mux_110_nl;
  wire[0:0] mux_109_nl;
  wire[0:0] mux_108_nl;
  wire[0:0] mux_114_nl;
  wire[0:0] or_131_nl;
  wire[9:0] COMP_LOOP_acc_nl;
  wire[10:0] nl_COMP_LOOP_acc_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] or_150_nl;
  wire[0:0] nand_27_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] COMP_LOOP_mux1h_34_nl;
  wire[0:0] nor_69_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] nor_61_nl;
  wire[0:0] mux_34_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] or_48_nl;
  wire[0:0] mux_49_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] mux_52_nl;
  wire[0:0] or_82_nl;
  wire[0:0] nor_53_nl;
  wire[2:0] STAGE_LOOP_acc_nl;
  wire[3:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] and_27_nl;
  wire[0:0] and_34_nl;
  wire[0:0] and_38_nl;
  wire[0:0] mux_37_nl;
  wire[0:0] nor_46_nl;
  wire[0:0] mux_38_nl;
  wire[0:0] and_152_nl;
  wire[0:0] nor_82_nl;
  wire[9:0] operator_64_false_1_mux1h_2_nl;
  wire[9:0] operator_64_false_1_mux1h_3_nl;
  wire[0:0] operator_64_false_1_or_1_nl;
  wire[8:0] COMP_LOOP_mux_9_nl;
  wire[0:0] and_238_nl;
  wire[9:0] COMP_LOOP_mux_10_nl;
  wire[0:0] and_239_nl;
  wire[65:0] acc_3_nl;
  wire[66:0] nl_acc_3_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_1_nl;
  wire[63:0] COMP_LOOP_mux1h_61_nl;
  wire[0:0] COMP_LOOP_or_12_nl;
  wire[63:0] COMP_LOOP_COMP_LOOP_COMP_LOOP_nand_1_nl;
  wire[63:0] COMP_LOOP_mux_11_nl;
  wire[0:0] COMP_LOOP_or_13_nl;
  wire[0:0] COMP_LOOP_not_41_nl;
  wire[63:0] modExp_while_if_mux_1_nl;
  wire[0:0] and_240_nl;
  wire[0:0] mux_163_nl;
  wire[0:0] and_241_nl;
  wire[0:0] nor_106_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0 = ~ (z_out_3[64]);
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 = ~ operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out[10];
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_11_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_11_tr0 = ~ STAGE_LOOP_acc_itm_2_1;
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
  mgc_rem #(.width_a(32'sd64),
  .width_b(32'sd64),
  .signd(32'sd1)) modulo_result_rem_cmp (
      .a(modulo_result_rem_cmp_a),
      .b(modulo_result_rem_cmp_b),
      .z(modulo_result_rem_cmp_z)
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
      .operator_66_true_div_cmp_z(operator_66_true_div_cmp_z),
      .operator_66_true_div_cmp_z_oreg(operator_66_true_div_cmp_z_oreg)
    );
  inPlaceNTT_DIT_core_core_fsm inPlaceNTT_DIT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .STAGE_LOOP_C_10_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0[0:0]),
      .modExp_while_C_47_tr0(exit_modExp_1_while_sva),
      .COMP_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0[0:0]),
      .modExp_1_while_C_47_tr0(exit_modExp_1_while_sva),
      .COMP_LOOP_C_76_tr0(exit_modExp_1_while_sva),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_11_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_11_tr0[0:0])
    );
  assign modulo_5_mux_cse = MUX_v_64_2_2(modExp_base_1_sva, modulo_qr_sva_1_mx1w0,
      modExp_base_1_sva[63]);
  assign or_173_cse = (fsm_output[1:0]!=2'b00);
  assign and_133_cse = or_173_cse & (fsm_output[2]);
  assign or_75_cse = (fsm_output[2:0]!=3'b000);
  assign and_126_cse = (fsm_output[2:1]==2'b11);
  assign and_129_cse = (fsm_output[2:0]==3'b111);
  assign or_174_cse = (fsm_output[2:1]!=2'b00);
  assign operator_66_true_div_cmp_b = {1'b0, reg_operator_66_true_div_cmp_b_reg};
  assign and_115_cse = (fsm_output[5:4]==2'b11);
  assign mux_124_nl = MUX_s_1_2_2((~ (fsm_output[6])), nand_18_cse, and_115_cse);
  assign mux_125_nl = MUX_s_1_2_2(mux_124_nl, mux_tmp_54, fsm_output[7]);
  assign modExp_1_while_and_nl = (~ (modExp_base_1_sva[63])) & modExp_exp_1_0_sva
      & and_dcpl_100;
  assign modExp_1_while_and_1_nl = (modExp_base_1_sva[63]) & modExp_exp_1_0_sva &
      and_dcpl_100;
  assign modExp_result_mux1h_2_nl = MUX1HOT_v_64_4_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
      modExp_base_1_sva, modulo_qr_sva_1_mx1w0, (z_out_3[63:0]), {mux_125_nl , modExp_1_while_and_nl
      , modExp_1_while_and_1_nl , and_dcpl_65});
  assign and_80_nl = and_dcpl_14 & and_dcpl_76;
  assign nor_nl = ~((~((fsm_output[1:0]!=2'b00))) | (~ (fsm_output[2])) | (fsm_output[6])
      | (~ (fsm_output[3])));
  assign mux_55_nl = MUX_s_1_2_2((fsm_output[6]), nor_nl, and_115_cse);
  assign mux_56_nl = MUX_s_1_2_2(mux_55_nl, (~ mux_tmp_54), fsm_output[7]);
  assign operator_64_false_mux1h_2_rgt = MUX1HOT_v_65_3_2(z_out_3, ({2'b00 , operator_64_false_slc_modExp_exp_63_1_3}),
      ({1'b0 , modExp_result_mux1h_2_nl}), {and_80_nl , and_dcpl_81 , mux_56_nl});
  assign and_90_m1c = and_dcpl_13 & and_dcpl_25 & and_dcpl_28;
  assign modExp_result_and_rgt = (~ modExp_while_and_1_itm) & and_90_m1c;
  assign modExp_result_and_1_rgt = modExp_while_and_1_itm & and_90_m1c;
  assign nand_37_cse = ~((fsm_output[5]) & (fsm_output[0]));
  assign or_127_cse = (fsm_output[7]) | (~ (fsm_output[5]));
  assign nand_18_cse = ~((fsm_output[3]) & (fsm_output[1]) & (fsm_output[2]) & (~
      (fsm_output[6])));
  assign mux_73_nl = MUX_s_1_2_2((~ (fsm_output[6])), or_tmp_80, and_126_cse);
  assign mux_119_nl = MUX_s_1_2_2(mux_73_nl, or_tmp_118, fsm_output[4]);
  assign mux_120_nl = MUX_s_1_2_2((~ (fsm_output[6])), mux_119_nl, fsm_output[5]);
  assign COMP_LOOP_or_5_cse = mux_120_nl | (fsm_output[7]);
  assign nl_COMP_LOOP_acc_5_mut_mx0w7 = COMP_LOOP_acc_5_mut + modulo_5_mux_cse;
  assign COMP_LOOP_acc_5_mut_mx0w7 = nl_COMP_LOOP_acc_5_mut_mx0w7[63:0];
  assign operator_64_false_slc_modExp_exp_63_1_3 = MUX_v_63_2_2((operator_66_true_div_cmp_z_oreg[63:1]),
      (COMP_LOOP_acc_5_mut[63:1]), and_dcpl_89);
  assign nl_modulo_qr_sva_1_mx1w0 = modExp_base_1_sva + p_sva;
  assign modulo_qr_sva_1_mx1w0 = nl_modulo_qr_sva_1_mx1w0[63:0];
  assign nl_modExp_while_mul_itm_mx0w0 = modExp_base_1_sva * modExp_base_1_sva;
  assign modExp_while_mul_itm_mx0w0 = nl_modExp_while_mul_itm_mx0w0[63:0];
  assign and_141_cse = (fsm_output[1:0]==2'b11);
  assign or_tmp_36 = (fsm_output[6]) | (fsm_output[3]);
  assign nor_61_nl = ~((fsm_output[6:0]!=7'b0000000));
  assign or_48_nl = and_141_cse | (fsm_output[2]);
  assign mux_33_nl = MUX_s_1_2_2((fsm_output[6]), or_tmp_36, or_48_nl);
  assign mux_34_nl = MUX_s_1_2_2((fsm_output[6]), mux_33_nl, and_115_cse);
  assign mux_35_itm = MUX_s_1_2_2(nor_61_nl, mux_34_nl, fsm_output[7]);
  assign and_dcpl_9 = ~((fsm_output[5]) | (fsm_output[7]));
  assign and_dcpl_10 = ~((fsm_output[0]) | (fsm_output[4]));
  assign and_dcpl_11 = and_dcpl_10 & and_dcpl_9;
  assign and_dcpl_12 = ~((fsm_output[2:1]!=2'b00));
  assign and_dcpl_13 = ~((fsm_output[3]) | (fsm_output[6]));
  assign and_dcpl_14 = and_dcpl_13 & and_dcpl_12;
  assign and_dcpl_16 = (fsm_output[5]) & (fsm_output[7]);
  assign and_dcpl_17 = (~ (fsm_output[0])) & (fsm_output[4]);
  assign and_dcpl_19 = (fsm_output[2:1]==2'b01);
  assign and_dcpl_20 = (fsm_output[3]) & (~ (fsm_output[6]));
  assign and_dcpl_21 = and_dcpl_20 & and_dcpl_19;
  assign and_dcpl_23 = (fsm_output[5]) & (~ (fsm_output[7]));
  assign and_dcpl_24 = and_dcpl_17 & and_dcpl_23;
  assign and_dcpl_25 = (fsm_output[2:1]==2'b10);
  assign and_dcpl_26 = and_dcpl_20 & and_dcpl_25;
  assign and_dcpl_28 = and_dcpl_10 & and_dcpl_23;
  assign and_dcpl_30 = (fsm_output[3]) & (fsm_output[6]);
  assign and_dcpl_31 = and_dcpl_30 & and_126_cse;
  assign and_dcpl_32 = and_dcpl_31 & and_dcpl_28;
  assign and_dcpl_35 = (fsm_output[0]) & (fsm_output[4]);
  assign and_dcpl_36 = and_dcpl_35 & and_dcpl_16;
  assign and_dcpl_52 = and_dcpl_26 & and_dcpl_11;
  assign and_dcpl_53 = ~((fsm_output[7:6]!=2'b00));
  assign or_tmp_41 = and_141_cse | (fsm_output[3:2]!=2'b00);
  assign not_tmp_47 = ~((fsm_output[4]) | (or_173_cse & (fsm_output[3:2]==2'b11)));
  assign or_tmp_48 = (fsm_output[2]) | (~ (fsm_output[6])) | (fsm_output[3]);
  assign or_tmp_50 = ~((fsm_output[4]) & (fsm_output[0]) & (fsm_output[1]) & (fsm_output[2])
      & (~ (fsm_output[6])) & (fsm_output[3]));
  assign and_dcpl_64 = and_dcpl_20 & and_dcpl_12;
  assign and_dcpl_65 = and_dcpl_64 & and_dcpl_10 & (~ (fsm_output[5])) & (fsm_output[7]);
  assign and_dcpl_74 = ~((~(or_174_cse ^ (fsm_output[3]))) | (fsm_output[7:4]!=4'b0000));
  assign mux_49_nl = MUX_s_1_2_2((fsm_output[6]), or_tmp_36, or_174_cse);
  assign mux_tmp_50 = MUX_s_1_2_2((fsm_output[6]), mux_49_nl, and_115_cse);
  assign and_dcpl_75 = (fsm_output[0]) & (~ (fsm_output[4]));
  assign and_dcpl_76 = and_dcpl_75 & and_dcpl_9;
  assign and_dcpl_81 = and_dcpl_20 & (~((fsm_output[4]) ^ (fsm_output[5]))) & and_dcpl_19
      & (fsm_output[0]) & (~ (fsm_output[7]));
  assign or_tmp_66 = (fsm_output[6]) | (~ (fsm_output[3]));
  assign mux_53_nl = MUX_s_1_2_2(or_tmp_66, (fsm_output[6]), fsm_output[4]);
  assign or_82_nl = and_133_cse | (fsm_output[6]) | (fsm_output[3]);
  assign mux_52_nl = MUX_s_1_2_2((fsm_output[6]), or_82_nl, fsm_output[4]);
  assign mux_tmp_54 = MUX_s_1_2_2(mux_53_nl, mux_52_nl, fsm_output[5]);
  assign mux_tmp_72 = MUX_s_1_2_2((fsm_output[6]), or_tmp_36, fsm_output[2]);
  assign or_tmp_80 = (~ (fsm_output[6])) | (fsm_output[3]);
  assign and_dcpl_88 = and_dcpl_35 & and_dcpl_23;
  assign and_dcpl_89 = and_dcpl_21 & and_dcpl_88;
  assign nand_8_cse = ~((fsm_output[7]) & (fsm_output[2]) & (fsm_output[1]) & (~
      (fsm_output[6])));
  assign and_dcpl_94 = and_dcpl_26 & and_dcpl_88;
  assign and_dcpl_95 = and_dcpl_75 & and_dcpl_23;
  assign mux_tmp_99 = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[7]);
  assign and_dcpl_100 = (~ (fsm_output[3])) & (fsm_output[6]) & and_126_cse & and_dcpl_17
      & and_dcpl_9;
  assign and_dcpl_104 = and_dcpl_20 & and_126_cse & and_dcpl_24;
  assign or_dcpl_28 = or_tmp_66 | (fsm_output[2:1]!=2'b10);
  assign or_dcpl_32 = (fsm_output[0]) | (~ (fsm_output[4])) | or_127_cse;
  assign and_dcpl_107 = and_dcpl_30 & and_dcpl_25 & and_dcpl_95;
  assign or_tmp_118 = ~((fsm_output[0]) & (fsm_output[1]) & (fsm_output[2]) & (~
      (fsm_output[6])) & (fsm_output[3]));
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_21 & and_dcpl_17 & and_dcpl_16;
  assign VEC_LOOP_j_sva_9_0_mx0c1 = and_dcpl_64 & and_dcpl_36;
  assign nor_53_nl = ~((fsm_output[5:4]!=2'b00) | mux_tmp_72);
  assign modExp_result_sva_mx0c0 = MUX_s_1_2_2(nor_53_nl, mux_tmp_50, fsm_output[7]);
  assign nl_STAGE_LOOP_acc_nl = (z_out[3:1]) + 3'b011;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[2:0];
  assign STAGE_LOOP_acc_itm_2_1 = readslicef_3_1_2(STAGE_LOOP_acc_nl);
  assign and_27_nl = and_dcpl_26 & and_dcpl_24;
  assign and_34_nl = and_dcpl_14 & and_dcpl_10 & and_dcpl_16;
  assign and_38_nl = and_dcpl_13 & and_126_cse & and_dcpl_36;
  assign vec_rsci_adra_d = MUX1HOT_v_10_4_2(z_out_2, (z_out[10:1]), COMP_LOOP_acc_1_cse_sva,
      COMP_LOOP_acc_10_cse_10_1_sva, {and_27_nl , and_dcpl_32 , and_34_nl , and_38_nl});
  assign vec_rsci_da_d = modulo_5_mux_cse;
  assign nor_46_nl = ~((fsm_output[2:0]!=3'b000));
  assign mux_37_nl = MUX_s_1_2_2(nor_46_nl, and_129_cse, fsm_output[4]);
  assign vec_rsci_wea_d_pff = mux_37_nl & and_dcpl_13 & and_dcpl_16;
  assign and_152_nl = (fsm_output[1]) & (fsm_output[6]);
  assign nor_82_nl = ~((fsm_output[1]) | (fsm_output[6]));
  assign mux_38_nl = MUX_s_1_2_2(and_152_nl, nor_82_nl, fsm_output[4]);
  assign vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = mux_38_nl & (fsm_output[3])
      & (fsm_output[2]) & (~ (fsm_output[0])) & and_dcpl_23;
  assign and_dcpl_116 = and_dcpl_23 & and_dcpl_17 & (fsm_output[2:1]==2'b10) & and_dcpl_20;
  assign and_dcpl_121 = and_dcpl_16 & and_dcpl_17 & (fsm_output[2:1]==2'b01) & and_dcpl_20;
  assign and_dcpl_127 = and_dcpl_23 & (~ (fsm_output[4])) & (~ (fsm_output[0])) &
      (fsm_output[1]) & (fsm_output[2]) & (fsm_output[3]) & (fsm_output[6]);
  assign and_dcpl_132 = and_dcpl_16 & (fsm_output[4]) & (fsm_output[0]) & (~ (fsm_output[1]))
      & (~ (fsm_output[2])) & and_dcpl_20;
  assign and_dcpl_164 = (~ (fsm_output[5])) & (fsm_output[7]) & and_dcpl_10 & and_dcpl_12
      & and_dcpl_20;
  assign and_dcpl_169 = and_dcpl_9 & (~ (fsm_output[4])) & (fsm_output[0]);
  assign and_dcpl_170 = and_dcpl_169 & and_dcpl_12 & (~ (fsm_output[3])) & (~ (fsm_output[6]));
  assign and_dcpl_174 = and_dcpl_9 & and_dcpl_10 & (fsm_output[2:1]==2'b10) & and_dcpl_20;
  assign and_dcpl_177 = and_dcpl_169 & (fsm_output[2:1]==2'b01) & and_dcpl_20;
  assign mux_tmp = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[4]);
  assign not_tmp_127 = ~((fsm_output[5:4]!=2'b00));
  assign or_tmp_140 = (fsm_output[5]) | (~ (fsm_output[0]));
  assign or_tmp_141 = (~ (fsm_output[5])) | (fsm_output[0]);
  assign or_tmp_143 = (~ (fsm_output[2])) | (fsm_output[3]) | (fsm_output[5]) | (~
      (fsm_output[0]));
  assign mux_tmp_155 = MUX_s_1_2_2((~ or_tmp_141), (fsm_output[5]), modExp_base_1_sva[63]);
  always @(posedge clk) begin
    if ( mux_35_itm ) begin
      p_sva <= p_rsci_idat;
      r_sva <= r_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( (and_dcpl_14 & and_dcpl_11) | STAGE_LOOP_i_3_0_sva_mx0c1 ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, (z_out[3:0]), STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_obj_ld_cse <= 1'b0;
      modExp_while_and_itm <= 1'b0;
      modExp_while_and_1_itm <= 1'b0;
      modExp_exp_1_1_sva <= 1'b0;
    end
    else begin
      reg_vec_rsc_triosy_obj_ld_cse <= and_dcpl_20 & (~ (fsm_output[2])) & (fsm_output[1])
          & (~ (fsm_output[0])) & (fsm_output[4]) & (fsm_output[5]) & (fsm_output[7])
          & (~ STAGE_LOOP_acc_itm_2_1);
      modExp_while_and_itm <= (~ (modulo_result_rem_cmp_z[63])) & modExp_exp_1_0_sva;
      modExp_while_and_1_itm <= (modulo_result_rem_cmp_z[63]) & modExp_exp_1_0_sva;
      modExp_exp_1_1_sva <= COMP_LOOP_mux1h_34_nl & (~ and_dcpl_107);
    end
  end
  always @(posedge clk) begin
    modulo_result_rem_cmp_a <= MUX1HOT_v_64_9_2(z_out_4, modExp_while_if_mul_mut,
        modExp_while_mul_itm, modExp_1_while_if_mul_mut, modExp_1_while_mul_itm,
        COMP_LOOP_mul_mut, COMP_LOOP_acc_5_mut_mx0w7, COMP_LOOP_acc_5_mut, operator_64_false_acc_mut_63_0,
        {modulo_result_or_nl , and_54_nl , and_57_nl , nor_72_nl , and_62_nl , mux_46_nl
        , and_dcpl_65 , and_70_nl , and_73_nl});
    modulo_result_rem_cmp_b <= p_sva;
    operator_66_true_div_cmp_a <= MUX_v_65_2_2(z_out_3, ({operator_64_false_acc_mut_64
        , operator_64_false_acc_mut_63_0}), and_dcpl_74);
    reg_operator_66_true_div_cmp_b_reg <= MUX_v_10_2_2(STAGE_LOOP_lshift_psp_sva_mx0w0,
        STAGE_LOOP_lshift_psp_sva, and_dcpl_74);
    operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm <= z_out[9];
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(nor_55_nl, mux_tmp_50, fsm_output[7]) ) begin
      STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~ mux_141_nl ) begin
      operator_64_false_acc_mut_64 <= operator_64_false_mux1h_2_rgt[64];
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_145_nl, nor_103_nl, fsm_output[6]) ) begin
      operator_64_false_acc_mut_63_0 <= operator_64_false_mux1h_2_rgt[63:0];
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_81 | VEC_LOOP_j_sva_9_0_mx0c1 ) begin
      VEC_LOOP_j_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (z_out[9:0]), VEC_LOOP_j_sva_9_0_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_k_9_0_sva_8_0 <= 9'b000000000;
    end
    else if ( MUX_s_1_2_2(mux_151_nl, mux_150_nl, and_236_nl) ) begin
      COMP_LOOP_k_9_0_sva_8_0 <= MUX_v_9_2_2(9'b000000000, (z_out_1[8:0]), nand_nl);
    end
  end
  always @(posedge clk) begin
    if ( (modExp_exp_1_0_sva | modExp_while_and_itm | modExp_while_and_1_itm | modExp_result_sva_mx0c0
        | (~ mux_80_nl)) & (modExp_result_sva_mx0c0 | modExp_result_and_rgt | modExp_result_and_1_rgt)
        ) begin
      modExp_result_sva <= MUX1HOT_v_64_3_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
          modExp_base_1_sva, modulo_qr_sva_1_mx1w0, {modExp_result_sva_mx0c0 , modExp_result_and_rgt
          , modExp_result_and_1_rgt});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_base_1_sva <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~ mux_162_nl ) begin
      modExp_base_1_sva <= MUX1HOT_v_64_5_2(r_sva, modulo_result_rem_cmp_z, modulo_5_mux_cse,
          modExp_result_sva, vec_rsci_qa_d, {and_93_nl , (~ mux_86_nl) , and_96_nl
          , and_dcpl_94 , and_99_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_5_mut <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( MUX_s_1_2_2(mux_106_nl, (fsm_output[7]), fsm_output[6]) ) begin
      COMP_LOOP_acc_5_mut <= MUX1HOT_v_64_3_2(({1'b0 , operator_64_false_slc_modExp_exp_63_1_3}),
          vec_rsci_qa_d, COMP_LOOP_acc_5_mut_mx0w7, {and_dcpl_81 , and_dcpl_94 ,
          and_dcpl_65});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_0_sva <= 1'b0;
    end
    else if ( ~(mux_113_nl & (~ (fsm_output[7]))) ) begin
      modExp_exp_1_0_sva <= MUX1HOT_s_1_4_2((operator_66_true_div_cmp_z_oreg[0]),
          (COMP_LOOP_acc_5_mut[0]), (COMP_LOOP_k_9_0_sva_8_0[0]), modExp_exp_1_0_sva_1,
          {COMP_LOOP_and_1_nl , and_dcpl_89 , and_dcpl_94 , and_dcpl_100});
    end
  end
  always @(posedge clk) begin
    if ( ~((~ mux_114_nl) & and_dcpl_53) ) begin
      modExp_while_if_mul_mut <= z_out_4;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_modExp_1_while_sva <= 1'b0;
    end
    else if ( and_dcpl_52 | and_dcpl_104 | and_dcpl_32 ) begin
      exit_modExp_1_while_sva <= MUX1HOT_s_1_3_2((~ (z_out_3[63])), (~ (z_out_1[8])),
          (~ (readslicef_10_1_9(COMP_LOOP_acc_nl))), {and_dcpl_52 , and_dcpl_104
          , and_dcpl_32});
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_28 | (~ (fsm_output[0])) | (fsm_output[4]) | (fsm_output[5]) |
        (fsm_output[7])) ) begin
      modExp_while_mul_itm <= modExp_while_mul_itm_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_28 | or_dcpl_32) ) begin
      COMP_LOOP_acc_1_cse_sva <= z_out_2;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_0_sva_1 <= 1'b0;
    end
    else if ( mux_118_nl | (fsm_output[7]) ) begin
      modExp_exp_1_0_sva_1 <= MUX_s_1_2_2((COMP_LOOP_k_9_0_sva_8_0[1]), modExp_exp_1_1_sva,
          and_dcpl_107);
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_or_5_cse ) begin
      modExp_exp_1_7_sva <= MUX_s_1_2_2((COMP_LOOP_k_9_0_sva_8_0[7]), modExp_exp_1_1_sva,
          and_dcpl_104);
      modExp_exp_1_6_sva <= MUX_s_1_2_2((COMP_LOOP_k_9_0_sva_8_0[6]), modExp_exp_1_7_sva,
          and_dcpl_104);
      modExp_exp_1_5_sva <= MUX_s_1_2_2((COMP_LOOP_k_9_0_sva_8_0[5]), modExp_exp_1_6_sva,
          and_dcpl_104);
      modExp_exp_1_4_sva <= MUX_s_1_2_2((COMP_LOOP_k_9_0_sva_8_0[4]), modExp_exp_1_5_sva,
          and_dcpl_104);
      modExp_exp_1_3_sva <= MUX_s_1_2_2((COMP_LOOP_k_9_0_sva_8_0[3]), modExp_exp_1_4_sva,
          and_dcpl_104);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_2_sva <= 1'b0;
    end
    else if ( COMP_LOOP_or_5_cse ) begin
      modExp_exp_1_2_sva <= MUX_s_1_2_2((COMP_LOOP_k_9_0_sva_8_0[2]), modExp_exp_1_3_sva,
          and_dcpl_104);
    end
  end
  always @(posedge clk) begin
    if ( mux_133_nl | (fsm_output[7]) ) begin
      modExp_1_while_if_mul_mut <= z_out_4;
    end
  end
  always @(posedge clk) begin
    if ( ~(nand_18_cse | (~ (fsm_output[0])) | (~ (fsm_output[4])) | or_127_cse)
        ) begin
      modExp_1_while_mul_itm <= modExp_while_mul_itm_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~((~ (fsm_output[3])) | (~ (fsm_output[6])) | (~ (fsm_output[2])) | (~ (fsm_output[1]))
        | (fsm_output[0]) | (fsm_output[4]) | or_127_cse) ) begin
      COMP_LOOP_acc_10_cse_10_1_sva <= z_out[10:1];
    end
  end
  always @(posedge clk) begin
    if ( ~(or_tmp_80 | or_174_cse | or_dcpl_32) ) begin
      COMP_LOOP_mul_mut <= z_out_4;
    end
  end
  assign or_63_nl = (~ (fsm_output[2])) | (fsm_output[6]) | (~ (fsm_output[3]));
  assign mux_41_nl = MUX_s_1_2_2(or_tmp_48, or_63_nl, fsm_output[1]);
  assign modulo_result_or_nl = and_dcpl_52 | ((~ mux_41_nl) & and_dcpl_24);
  assign or_58_nl = (fsm_output[4]) | or_tmp_41;
  assign mux_39_nl = MUX_s_1_2_2(not_tmp_47, or_58_nl, fsm_output[5]);
  assign and_54_nl = (~ mux_39_nl) & and_dcpl_53;
  assign nand_13_nl = ~(or_174_cse & (fsm_output[3]));
  assign mux_40_nl = MUX_s_1_2_2(or_tmp_41, nand_13_nl, fsm_output[4]);
  assign and_57_nl = mux_40_nl & (fsm_output[7:5]==3'b001);
  assign or_68_nl = and_133_cse | (~ (fsm_output[6])) | (fsm_output[3]);
  assign mux_42_nl = MUX_s_1_2_2((~ (fsm_output[6])), or_68_nl, fsm_output[4]);
  assign mux_43_nl = MUX_s_1_2_2(mux_42_nl, or_tmp_50, fsm_output[5]);
  assign nor_72_nl = ~(mux_43_nl | (fsm_output[7]));
  assign and_130_nl = (fsm_output[4]) & (and_133_cse | (fsm_output[3]));
  assign nor_57_nl = ~((fsm_output[4]) | ((fsm_output[3:2]==2'b11)));
  assign mux_44_nl = MUX_s_1_2_2(and_130_nl, nor_57_nl, fsm_output[5]);
  assign and_62_nl = mux_44_nl & (fsm_output[7:6]==2'b01);
  assign mux_45_nl = MUX_s_1_2_2(and_dcpl_30, (fsm_output[6]), or_75_cse);
  assign and_128_nl = (fsm_output[5:4]==2'b11) & mux_45_nl;
  assign nor_56_nl = ~((fsm_output[5:4]!=2'b00) | and_129_cse | (fsm_output[6]) |
      (fsm_output[3]));
  assign mux_46_nl = MUX_s_1_2_2(and_128_nl, nor_56_nl, fsm_output[7]);
  assign and_127_nl = or_75_cse & (fsm_output[3]);
  assign nand_11_nl = ~((fsm_output[3:0]==4'b1111));
  assign mux_47_nl = MUX_s_1_2_2(and_127_nl, nand_11_nl, fsm_output[4]);
  assign and_70_nl = mux_47_nl & (fsm_output[7:5]==3'b100);
  assign and_125_nl = (fsm_output[4:0]==5'b11111);
  assign nand_10_nl = ~((fsm_output[4]) & (and_126_cse | (fsm_output[3])));
  assign mux_48_nl = MUX_s_1_2_2(and_125_nl, nand_10_nl, fsm_output[5]);
  assign and_73_nl = mux_48_nl & (fsm_output[7:6]==2'b10);
  assign mux_121_nl = MUX_s_1_2_2((~ (fsm_output[6])), or_tmp_80, and_133_cse);
  assign mux_122_nl = MUX_s_1_2_2(mux_121_nl, or_tmp_118, fsm_output[4]);
  assign mux_123_nl = MUX_s_1_2_2((~ (fsm_output[6])), mux_122_nl, fsm_output[5]);
  assign nor_69_nl = ~(mux_123_nl | (fsm_output[7]));
  assign COMP_LOOP_mux1h_34_nl = MUX1HOT_s_1_3_2((COMP_LOOP_k_9_0_sva_8_0[8]), modExp_exp_1_2_sva,
      modExp_exp_1_1_sva, {and_dcpl_94 , and_dcpl_104 , nor_69_nl});
  assign nor_55_nl = ~((fsm_output[6:1]!=6'b000000));
  assign or_nl = (fsm_output[2]) | (fsm_output[1]) | (~ (fsm_output[0])) | (fsm_output[4])
      | (fsm_output[5]);
  assign nand_33_nl = ~((fsm_output[1:0]==2'b11) & mux_tmp);
  assign nand_34_nl = ~(or_173_cse & (fsm_output[5:4]==2'b11));
  assign mux_138_nl = MUX_s_1_2_2(nand_33_nl, nand_34_nl, fsm_output[2]);
  assign mux_139_nl = MUX_s_1_2_2(or_nl, mux_138_nl, fsm_output[3]);
  assign mux_140_nl = MUX_s_1_2_2(mux_139_nl, and_115_cse, fsm_output[6]);
  assign mux_135_nl = MUX_s_1_2_2(not_tmp_127, mux_tmp, or_173_cse);
  assign mux_136_nl = MUX_s_1_2_2(not_tmp_127, mux_135_nl, fsm_output[2]);
  assign mux_137_nl = MUX_s_1_2_2(mux_136_nl, and_115_cse, fsm_output[3]);
  assign or_185_nl = (fsm_output[6]) | mux_137_nl;
  assign mux_141_nl = MUX_s_1_2_2(mux_140_nl, or_185_nl, fsm_output[7]);
  assign or_195_nl = (fsm_output[7]) | (~ (fsm_output[0])) | (fsm_output[5]);
  assign or_194_nl = (~ (fsm_output[7])) | (fsm_output[0]) | (fsm_output[5]);
  assign mux_143_nl = MUX_s_1_2_2(or_195_nl, or_194_nl, fsm_output[3]);
  assign nor_99_nl = ~((fsm_output[2]) | mux_143_nl);
  assign nor_100_nl = ~((fsm_output[2]) | (~ (fsm_output[3])) | (fsm_output[7]) |
      (~ (fsm_output[0])) | (fsm_output[5]));
  assign mux_144_nl = MUX_s_1_2_2(nor_99_nl, nor_100_nl, fsm_output[1]);
  assign nor_101_nl = ~((~ (fsm_output[2])) | (~ (fsm_output[3])) | (fsm_output[7])
      | nand_37_cse);
  assign nor_102_nl = ~((fsm_output[2]) | (~ (fsm_output[3])) | (fsm_output[7]) |
      nand_37_cse);
  assign mux_142_nl = MUX_s_1_2_2(nor_101_nl, nor_102_nl, fsm_output[1]);
  assign mux_145_nl = MUX_s_1_2_2(mux_144_nl, mux_142_nl, fsm_output[4]);
  assign nor_103_nl = ~((~ modExp_exp_1_0_sva) | (~ (fsm_output[4])) | (~ (fsm_output[1]))
      | (~ (fsm_output[2])) | (fsm_output[3]) | (fsm_output[7]) | (fsm_output[0])
      | (fsm_output[5]));
  assign nor_80_nl = ~((fsm_output[4]) | (~ (fsm_output[1])));
  assign and_151_nl = (fsm_output[4]) & (fsm_output[1]);
  assign mux_68_nl = MUX_s_1_2_2(nor_80_nl, and_151_nl, fsm_output[5]);
  assign nor_81_nl = ~((~ (fsm_output[5])) | (~ (fsm_output[4])) | (fsm_output[1]));
  assign mux_69_nl = MUX_s_1_2_2(mux_68_nl, nor_81_nl, fsm_output[7]);
  assign nand_nl = ~(mux_69_nl & and_dcpl_20 & (~ (fsm_output[2])) & (fsm_output[0]));
  assign mux_151_nl = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[6]);
  assign or_199_nl = (fsm_output[7]) | (~((fsm_output[2:0]!=3'b110)));
  assign mux_149_nl = MUX_s_1_2_2((~ (fsm_output[7])), or_199_nl, fsm_output[6]);
  assign mux_147_nl = MUX_s_1_2_2((~ (fsm_output[2])), or_75_cse, fsm_output[7]);
  assign mux_148_nl = MUX_s_1_2_2(mux_147_nl, (fsm_output[7]), fsm_output[6]);
  assign mux_150_nl = MUX_s_1_2_2(mux_149_nl, mux_148_nl, fsm_output[4]);
  assign and_236_nl = (fsm_output[5]) & (fsm_output[3]);
  assign nor_51_nl = ~((fsm_output[4]) | mux_tmp_72);
  assign nor_52_nl = ~((fsm_output[4]) | (fsm_output[0]) | (fsm_output[1]) | (~ (fsm_output[2]))
      | (fsm_output[6]) | (fsm_output[3]));
  assign mux_79_nl = MUX_s_1_2_2(nor_51_nl, nor_52_nl, fsm_output[5]);
  assign mux_80_nl = MUX_s_1_2_2(mux_79_nl, mux_tmp_50, fsm_output[7]);
  assign and_93_nl = and_dcpl_21 & and_dcpl_76;
  assign or_112_nl = (~ (fsm_output[3])) | (fsm_output[7]) | (~ (fsm_output[2]))
      | (fsm_output[1]) | (~ (fsm_output[6]));
  assign or_119_nl = (~ (fsm_output[1])) | (fsm_output[7]) | (fsm_output[6]) | (fsm_output[2]);
  assign mux_92_nl = MUX_s_1_2_2(nand_8_cse, or_119_nl, fsm_output[3]);
  assign mux_85_nl = MUX_s_1_2_2(or_112_nl, mux_92_nl, fsm_output[4]);
  assign nand_1_nl = ~((fsm_output[5]) & (~ mux_85_nl));
  assign or_109_nl = (fsm_output[3]) | (~ (fsm_output[7])) | (~ (fsm_output[2]))
      | (~ (fsm_output[1])) | (fsm_output[6]);
  assign or_108_nl = (fsm_output[7]) | (~ (fsm_output[2])) | (fsm_output[1]) | (~
      (fsm_output[6]));
  assign mux_81_nl = MUX_s_1_2_2(or_108_nl, nand_8_cse, fsm_output[3]);
  assign mux_82_nl = MUX_s_1_2_2(or_109_nl, mux_81_nl, fsm_output[4]);
  assign or_105_nl = (fsm_output[4]) | (fsm_output[3]) | (fsm_output[7]) | (fsm_output[2])
      | (~ (fsm_output[1])) | (fsm_output[6]);
  assign mux_83_nl = MUX_s_1_2_2(mux_82_nl, or_105_nl, fsm_output[5]);
  assign mux_86_nl = MUX_s_1_2_2(nand_1_nl, mux_83_nl, fsm_output[0]);
  assign nor_49_nl = ~((fsm_output[1]) | (~((fsm_output[6]) & (fsm_output[2]))));
  assign nor_50_nl = ~((~ (fsm_output[1])) | (fsm_output[2]) | (fsm_output[6]));
  assign mux_87_nl = MUX_s_1_2_2(nor_49_nl, nor_50_nl, fsm_output[4]);
  assign and_96_nl = mux_87_nl & (fsm_output[3]) & (fsm_output[0]) & and_dcpl_23;
  assign and_99_nl = and_dcpl_31 & and_dcpl_95;
  assign nand_35_nl = ~((fsm_output[4]) & (fsm_output[2]) & (fsm_output[3]) & (fsm_output[5])
      & (fsm_output[0]));
  assign nand_36_nl = ~((fsm_output[3:2]==2'b11) & mux_tmp_155);
  assign mux_159_nl = MUX_s_1_2_2(nand_36_nl, or_tmp_143, fsm_output[4]);
  assign mux_160_nl = MUX_s_1_2_2(nand_35_nl, mux_159_nl, fsm_output[6]);
  assign mux_156_nl = MUX_s_1_2_2(nand_37_cse, or_tmp_140, fsm_output[3]);
  assign or_208_nl = (fsm_output[2]) | mux_156_nl;
  assign or_207_nl = (fsm_output[2]) | (~((fsm_output[3]) & mux_tmp_155));
  assign mux_157_nl = MUX_s_1_2_2(or_208_nl, or_207_nl, fsm_output[4]);
  assign or_206_nl = (fsm_output[4]) | (~((fsm_output[2]) & (fsm_output[3]) & (fsm_output[5])
      & (fsm_output[0])));
  assign mux_158_nl = MUX_s_1_2_2(mux_157_nl, or_206_nl, fsm_output[6]);
  assign mux_161_nl = MUX_s_1_2_2(mux_160_nl, mux_158_nl, fsm_output[1]);
  assign mux_153_nl = MUX_s_1_2_2(or_tmp_141, or_tmp_140, fsm_output[3]);
  assign nand_30_nl = ~((fsm_output[2]) & (~ mux_153_nl));
  assign mux_154_nl = MUX_s_1_2_2(or_tmp_143, nand_30_nl, fsm_output[4]);
  assign or_205_nl = (~ (fsm_output[1])) | (fsm_output[6]) | mux_154_nl;
  assign mux_162_nl = MUX_s_1_2_2(mux_161_nl, or_205_nl, fsm_output[7]);
  assign mux_105_nl = MUX_s_1_2_2(mux_tmp_99, and_dcpl_16, fsm_output[4]);
  assign mux_101_nl = MUX_s_1_2_2(or_127_cse, mux_tmp_99, fsm_output[1]);
  assign mux_102_nl = MUX_s_1_2_2(mux_101_nl, and_dcpl_16, fsm_output[4]);
  assign and_118_nl = ((fsm_output[1]) | (fsm_output[7])) & (fsm_output[5]);
  assign mux_100_nl = MUX_s_1_2_2(mux_tmp_99, and_118_nl, fsm_output[4]);
  assign mux_103_nl = MUX_s_1_2_2(mux_102_nl, mux_100_nl, fsm_output[0]);
  assign mux_97_nl = MUX_s_1_2_2((fsm_output[5]), (fsm_output[7]), fsm_output[1]);
  assign mux_98_nl = MUX_s_1_2_2(and_dcpl_16, mux_97_nl, fsm_output[4]);
  assign mux_104_nl = MUX_s_1_2_2(mux_103_nl, mux_98_nl, fsm_output[2]);
  assign mux_106_nl = MUX_s_1_2_2(mux_105_nl, mux_104_nl, fsm_output[3]);
  assign COMP_LOOP_and_1_nl = (~ and_dcpl_89) & and_dcpl_81;
  assign or_130_nl = (fsm_output[0]) | (~ (fsm_output[1])) | (~ (fsm_output[2]))
      | (~ (fsm_output[6])) | (fsm_output[3]);
  assign mux_112_nl = MUX_s_1_2_2(mux_tmp_72, or_130_nl, fsm_output[4]);
  assign mux_109_nl = MUX_s_1_2_2(or_tmp_66, (fsm_output[6]), fsm_output[2]);
  assign mux_108_nl = MUX_s_1_2_2(and_dcpl_20, or_tmp_80, fsm_output[2]);
  assign mux_110_nl = MUX_s_1_2_2((~ mux_109_nl), mux_108_nl, fsm_output[1]);
  assign mux_111_nl = MUX_s_1_2_2(mux_110_nl, nand_18_cse, fsm_output[4]);
  assign mux_113_nl = MUX_s_1_2_2(mux_112_nl, (~ mux_111_nl), fsm_output[5]);
  assign or_131_nl = (fsm_output[4:1]!=4'b0000);
  assign mux_114_nl = MUX_s_1_2_2(not_tmp_47, or_131_nl, fsm_output[5]);
  assign nl_COMP_LOOP_acc_nl = z_out_1 + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + 10'b0000000001;
  assign COMP_LOOP_acc_nl = nl_COMP_LOOP_acc_nl[9:0];
  assign or_150_nl = and_126_cse | (~ (fsm_output[6])) | (fsm_output[3]);
  assign mux_117_nl = MUX_s_1_2_2((~ (fsm_output[6])), or_150_nl, fsm_output[4]);
  assign nand_27_nl = ~((fsm_output[4]) & (fsm_output[1]) & (fsm_output[2]) & (~
      (fsm_output[6])) & (fsm_output[3]));
  assign mux_118_nl = MUX_s_1_2_2(mux_117_nl, nand_27_nl, fsm_output[5]);
  assign mux_132_nl = MUX_s_1_2_2((~ (fsm_output[6])), or_tmp_48, fsm_output[4]);
  assign mux_133_nl = MUX_s_1_2_2(mux_132_nl, or_tmp_50, fsm_output[5]);
  assign operator_64_false_1_mux1h_2_nl = MUX1HOT_v_10_4_2(({1'b1 , (~ COMP_LOOP_k_9_0_sva_8_0)}),
      ({6'b000000 , STAGE_LOOP_i_3_0_sva}), z_out_2, VEC_LOOP_j_sva_9_0, {and_dcpl_116
      , and_dcpl_121 , and_dcpl_127 , and_dcpl_132});
  assign operator_64_false_1_or_1_nl = and_dcpl_116 | and_dcpl_121;
  assign operator_64_false_1_mux1h_3_nl = MUX1HOT_v_10_3_2(10'b0000000001, VEC_LOOP_j_sva_9_0,
      STAGE_LOOP_lshift_psp_sva, {operator_64_false_1_or_1_nl , and_dcpl_127 , and_dcpl_132});
  assign nl_z_out = conv_u2u_10_11(operator_64_false_1_mux1h_2_nl) + conv_u2u_10_11(operator_64_false_1_mux1h_3_nl);
  assign z_out = nl_z_out[10:0];
  assign and_238_nl = (fsm_output==8'b00111110);
  assign COMP_LOOP_mux_9_nl = MUX_v_9_2_2(COMP_LOOP_k_9_0_sva_8_0, ({1'b1 , (~ modExp_exp_1_1_sva)
      , (~ modExp_exp_1_7_sva) , (~ modExp_exp_1_6_sva) , (~ modExp_exp_1_5_sva)
      , (~ modExp_exp_1_4_sva) , (~ modExp_exp_1_3_sva) , (~ modExp_exp_1_2_sva)
      , (~ modExp_exp_1_0_sva_1)}), and_238_nl);
  assign nl_z_out_1 = conv_u2u_9_10(COMP_LOOP_mux_9_nl) + 10'b0000000001;
  assign z_out_1 = nl_z_out_1[9:0];
  assign and_239_nl = (~ (fsm_output[7])) & (fsm_output[5]) & and_dcpl_10 & (fsm_output[1])
      & (fsm_output[2]) & (fsm_output[3]) & (fsm_output[6]);
  assign COMP_LOOP_mux_10_nl = MUX_v_10_2_2(VEC_LOOP_j_sva_9_0, STAGE_LOOP_lshift_psp_sva,
      and_239_nl);
  assign nl_z_out_2 = COMP_LOOP_mux_10_nl + conv_u2u_9_10(COMP_LOOP_k_9_0_sva_8_0);
  assign z_out_2 = nl_z_out_2[9:0];
  assign COMP_LOOP_COMP_LOOP_or_1_nl = ((COMP_LOOP_acc_5_mut[63]) & (~ and_dcpl_170))
      | and_dcpl_174 | and_dcpl_177;
  assign COMP_LOOP_mux1h_61_nl = MUX1HOT_v_64_4_2(COMP_LOOP_acc_5_mut, p_sva, ({1'b1
      , (~ (operator_64_false_acc_mut_63_0[62:0]))}), (~ operator_66_true_div_cmp_z_oreg),
      {and_dcpl_164 , and_dcpl_170 , and_dcpl_174 , and_dcpl_177});
  assign COMP_LOOP_or_12_nl = (~(and_dcpl_170 | and_dcpl_174 | and_dcpl_177)) | and_dcpl_164;
  assign COMP_LOOP_or_13_nl = and_dcpl_174 | and_dcpl_177;
  assign COMP_LOOP_mux_11_nl = MUX_v_64_2_2(modulo_5_mux_cse, 64'b1111111111111111111111111111111111111111111111111111111111111110,
      COMP_LOOP_or_13_nl);
  assign COMP_LOOP_not_41_nl = ~ and_dcpl_170;
  assign COMP_LOOP_COMP_LOOP_COMP_LOOP_nand_1_nl = ~(MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000000,
      COMP_LOOP_mux_11_nl, COMP_LOOP_not_41_nl));
  assign nl_acc_3_nl = ({COMP_LOOP_COMP_LOOP_or_1_nl , COMP_LOOP_mux1h_61_nl , COMP_LOOP_or_12_nl})
      + conv_s2u_65_66({COMP_LOOP_COMP_LOOP_COMP_LOOP_nand_1_nl , 1'b1});
  assign acc_3_nl = nl_acc_3_nl[65:0];
  assign z_out_3 = readslicef_66_65_1(acc_3_nl);
  assign and_241_nl = (fsm_output[3:1]==3'b111);
  assign nor_106_nl = ~((fsm_output[3:1]!=3'b000));
  assign mux_163_nl = MUX_s_1_2_2(and_241_nl, nor_106_nl, fsm_output[6]);
  assign and_240_nl = mux_163_nl & (~ (fsm_output[7])) & (fsm_output[5]) & (fsm_output[4])
      & (~ (fsm_output[0]));
  assign modExp_while_if_mux_1_nl = MUX_v_64_2_2(modExp_result_sva, operator_64_false_acc_mut_63_0,
      and_240_nl);
  assign nl_z_out_4 = modExp_while_if_mux_1_nl * modExp_base_1_sva;
  assign z_out_4 = nl_z_out_4[63:0];

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


  function automatic [9:0] MUX1HOT_v_10_4_2;
    input [9:0] input_3;
    input [9:0] input_2;
    input [9:0] input_1;
    input [9:0] input_0;
    input [3:0] sel;
    reg [9:0] result;
  begin
    result = input_0 & {10{sel[0]}};
    result = result | ( input_1 & {10{sel[1]}});
    result = result | ( input_2 & {10{sel[2]}});
    result = result | ( input_3 & {10{sel[3]}});
    MUX1HOT_v_10_4_2 = result;
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


  function automatic [65:0] conv_s2u_65_66 ;
    input [64:0]  vector ;
  begin
    conv_s2u_65_66 = {vector[64], vector};
  end
  endfunction


  function automatic [9:0] conv_u2u_9_10 ;
    input [8:0]  vector ;
  begin
    conv_u2u_9_10 = {1'b0, vector};
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
//  Design Unit:    inPlaceNTT_DIT
// ------------------------------------------------------------------


module inPlaceNTT_DIT (
  clk, rst, vec_rsc_adra, vec_rsc_da, vec_rsc_wea, vec_rsc_qa, vec_rsc_triosy_lz,
      p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz
);
  input clk;
  input rst;
  output [9:0] vec_rsc_adra;
  output [63:0] vec_rsc_da;
  output vec_rsc_wea;
  input [63:0] vec_rsc_qa;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;


  // Interconnect Declarations
  wire [9:0] vec_rsci_adra_d;
  wire [63:0] vec_rsci_da_d;
  wire [63:0] vec_rsci_qa_d;
  wire vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  wire [64:0] operator_66_true_div_cmp_a;
  wire [10:0] operator_66_true_div_cmp_b;
  wire [64:0] operator_66_true_div_cmp_z;
  wire vec_rsci_wea_d_iff;


  // Interconnect Declarations for Component Instantiations 
  mgc_div #(.width_a(32'sd65),
  .width_b(32'sd11),
  .signd(32'sd1)) operator_66_true_div_cmp (
      .a(operator_66_true_div_cmp_a),
      .b(operator_66_true_div_cmp_b),
      .z(operator_66_true_div_cmp_z)
    );
  inPlaceNTT_DIT_Xilinx_RAMS_BLOCK_2R1W_RBW_DUAL_rwport_1_10_64_1024_1024_64_1_gen
      vec_rsci (
      .qa(vec_rsc_qa),
      .wea(vec_rsc_wea),
      .da(vec_rsc_da),
      .adra(vec_rsc_adra),
      .adra_d(vec_rsci_adra_d),
      .da_d(vec_rsci_da_d),
      .qa_d(vec_rsci_qa_d),
      .wea_d(vec_rsci_wea_d_iff),
      .rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(vec_rsci_wea_d_iff)
    );
  inPlaceNTT_DIT_core inPlaceNTT_DIT_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_dat(r_rsc_dat),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .vec_rsci_adra_d(vec_rsci_adra_d),
      .vec_rsci_da_d(vec_rsci_da_d),
      .vec_rsci_qa_d(vec_rsci_qa_d),
      .vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(vec_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .operator_66_true_div_cmp_a(operator_66_true_div_cmp_a),
      .operator_66_true_div_cmp_b(operator_66_true_div_cmp_b),
      .operator_66_true_div_cmp_z(operator_66_true_div_cmp_z),
      .vec_rsci_wea_d_pff(vec_rsci_wea_d_iff)
    );
endmodule



