
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
//  Generated date: Wed Jun 30 21:02:18 2021
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
  clk, rst, fsm_output, STAGE_LOOP_C_9_tr0, modExp_while_C_42_tr0, COMP_LOOP_C_1_tr0,
      COMP_LOOP_1_modExp_1_while_C_42_tr0, COMP_LOOP_C_68_tr0, COMP_LOOP_2_modExp_1_while_C_42_tr0,
      COMP_LOOP_C_136_tr0, VEC_LOOP_C_0_tr0, STAGE_LOOP_C_10_tr0
);
  input clk;
  input rst;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
  input STAGE_LOOP_C_9_tr0;
  input modExp_while_C_42_tr0;
  input COMP_LOOP_C_1_tr0;
  input COMP_LOOP_1_modExp_1_while_C_42_tr0;
  input COMP_LOOP_C_68_tr0;
  input COMP_LOOP_2_modExp_1_while_C_42_tr0;
  input COMP_LOOP_C_136_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_10_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIT_core_core_fsm_1
  parameter
    main_C_0 = 9'd0,
    STAGE_LOOP_C_0 = 9'd1,
    STAGE_LOOP_C_1 = 9'd2,
    STAGE_LOOP_C_2 = 9'd3,
    STAGE_LOOP_C_3 = 9'd4,
    STAGE_LOOP_C_4 = 9'd5,
    STAGE_LOOP_C_5 = 9'd6,
    STAGE_LOOP_C_6 = 9'd7,
    STAGE_LOOP_C_7 = 9'd8,
    STAGE_LOOP_C_8 = 9'd9,
    STAGE_LOOP_C_9 = 9'd10,
    modExp_while_C_0 = 9'd11,
    modExp_while_C_1 = 9'd12,
    modExp_while_C_2 = 9'd13,
    modExp_while_C_3 = 9'd14,
    modExp_while_C_4 = 9'd15,
    modExp_while_C_5 = 9'd16,
    modExp_while_C_6 = 9'd17,
    modExp_while_C_7 = 9'd18,
    modExp_while_C_8 = 9'd19,
    modExp_while_C_9 = 9'd20,
    modExp_while_C_10 = 9'd21,
    modExp_while_C_11 = 9'd22,
    modExp_while_C_12 = 9'd23,
    modExp_while_C_13 = 9'd24,
    modExp_while_C_14 = 9'd25,
    modExp_while_C_15 = 9'd26,
    modExp_while_C_16 = 9'd27,
    modExp_while_C_17 = 9'd28,
    modExp_while_C_18 = 9'd29,
    modExp_while_C_19 = 9'd30,
    modExp_while_C_20 = 9'd31,
    modExp_while_C_21 = 9'd32,
    modExp_while_C_22 = 9'd33,
    modExp_while_C_23 = 9'd34,
    modExp_while_C_24 = 9'd35,
    modExp_while_C_25 = 9'd36,
    modExp_while_C_26 = 9'd37,
    modExp_while_C_27 = 9'd38,
    modExp_while_C_28 = 9'd39,
    modExp_while_C_29 = 9'd40,
    modExp_while_C_30 = 9'd41,
    modExp_while_C_31 = 9'd42,
    modExp_while_C_32 = 9'd43,
    modExp_while_C_33 = 9'd44,
    modExp_while_C_34 = 9'd45,
    modExp_while_C_35 = 9'd46,
    modExp_while_C_36 = 9'd47,
    modExp_while_C_37 = 9'd48,
    modExp_while_C_38 = 9'd49,
    modExp_while_C_39 = 9'd50,
    modExp_while_C_40 = 9'd51,
    modExp_while_C_41 = 9'd52,
    modExp_while_C_42 = 9'd53,
    COMP_LOOP_C_0 = 9'd54,
    COMP_LOOP_C_1 = 9'd55,
    COMP_LOOP_1_modExp_1_while_C_0 = 9'd56,
    COMP_LOOP_1_modExp_1_while_C_1 = 9'd57,
    COMP_LOOP_1_modExp_1_while_C_2 = 9'd58,
    COMP_LOOP_1_modExp_1_while_C_3 = 9'd59,
    COMP_LOOP_1_modExp_1_while_C_4 = 9'd60,
    COMP_LOOP_1_modExp_1_while_C_5 = 9'd61,
    COMP_LOOP_1_modExp_1_while_C_6 = 9'd62,
    COMP_LOOP_1_modExp_1_while_C_7 = 9'd63,
    COMP_LOOP_1_modExp_1_while_C_8 = 9'd64,
    COMP_LOOP_1_modExp_1_while_C_9 = 9'd65,
    COMP_LOOP_1_modExp_1_while_C_10 = 9'd66,
    COMP_LOOP_1_modExp_1_while_C_11 = 9'd67,
    COMP_LOOP_1_modExp_1_while_C_12 = 9'd68,
    COMP_LOOP_1_modExp_1_while_C_13 = 9'd69,
    COMP_LOOP_1_modExp_1_while_C_14 = 9'd70,
    COMP_LOOP_1_modExp_1_while_C_15 = 9'd71,
    COMP_LOOP_1_modExp_1_while_C_16 = 9'd72,
    COMP_LOOP_1_modExp_1_while_C_17 = 9'd73,
    COMP_LOOP_1_modExp_1_while_C_18 = 9'd74,
    COMP_LOOP_1_modExp_1_while_C_19 = 9'd75,
    COMP_LOOP_1_modExp_1_while_C_20 = 9'd76,
    COMP_LOOP_1_modExp_1_while_C_21 = 9'd77,
    COMP_LOOP_1_modExp_1_while_C_22 = 9'd78,
    COMP_LOOP_1_modExp_1_while_C_23 = 9'd79,
    COMP_LOOP_1_modExp_1_while_C_24 = 9'd80,
    COMP_LOOP_1_modExp_1_while_C_25 = 9'd81,
    COMP_LOOP_1_modExp_1_while_C_26 = 9'd82,
    COMP_LOOP_1_modExp_1_while_C_27 = 9'd83,
    COMP_LOOP_1_modExp_1_while_C_28 = 9'd84,
    COMP_LOOP_1_modExp_1_while_C_29 = 9'd85,
    COMP_LOOP_1_modExp_1_while_C_30 = 9'd86,
    COMP_LOOP_1_modExp_1_while_C_31 = 9'd87,
    COMP_LOOP_1_modExp_1_while_C_32 = 9'd88,
    COMP_LOOP_1_modExp_1_while_C_33 = 9'd89,
    COMP_LOOP_1_modExp_1_while_C_34 = 9'd90,
    COMP_LOOP_1_modExp_1_while_C_35 = 9'd91,
    COMP_LOOP_1_modExp_1_while_C_36 = 9'd92,
    COMP_LOOP_1_modExp_1_while_C_37 = 9'd93,
    COMP_LOOP_1_modExp_1_while_C_38 = 9'd94,
    COMP_LOOP_1_modExp_1_while_C_39 = 9'd95,
    COMP_LOOP_1_modExp_1_while_C_40 = 9'd96,
    COMP_LOOP_1_modExp_1_while_C_41 = 9'd97,
    COMP_LOOP_1_modExp_1_while_C_42 = 9'd98,
    COMP_LOOP_C_2 = 9'd99,
    COMP_LOOP_C_3 = 9'd100,
    COMP_LOOP_C_4 = 9'd101,
    COMP_LOOP_C_5 = 9'd102,
    COMP_LOOP_C_6 = 9'd103,
    COMP_LOOP_C_7 = 9'd104,
    COMP_LOOP_C_8 = 9'd105,
    COMP_LOOP_C_9 = 9'd106,
    COMP_LOOP_C_10 = 9'd107,
    COMP_LOOP_C_11 = 9'd108,
    COMP_LOOP_C_12 = 9'd109,
    COMP_LOOP_C_13 = 9'd110,
    COMP_LOOP_C_14 = 9'd111,
    COMP_LOOP_C_15 = 9'd112,
    COMP_LOOP_C_16 = 9'd113,
    COMP_LOOP_C_17 = 9'd114,
    COMP_LOOP_C_18 = 9'd115,
    COMP_LOOP_C_19 = 9'd116,
    COMP_LOOP_C_20 = 9'd117,
    COMP_LOOP_C_21 = 9'd118,
    COMP_LOOP_C_22 = 9'd119,
    COMP_LOOP_C_23 = 9'd120,
    COMP_LOOP_C_24 = 9'd121,
    COMP_LOOP_C_25 = 9'd122,
    COMP_LOOP_C_26 = 9'd123,
    COMP_LOOP_C_27 = 9'd124,
    COMP_LOOP_C_28 = 9'd125,
    COMP_LOOP_C_29 = 9'd126,
    COMP_LOOP_C_30 = 9'd127,
    COMP_LOOP_C_31 = 9'd128,
    COMP_LOOP_C_32 = 9'd129,
    COMP_LOOP_C_33 = 9'd130,
    COMP_LOOP_C_34 = 9'd131,
    COMP_LOOP_C_35 = 9'd132,
    COMP_LOOP_C_36 = 9'd133,
    COMP_LOOP_C_37 = 9'd134,
    COMP_LOOP_C_38 = 9'd135,
    COMP_LOOP_C_39 = 9'd136,
    COMP_LOOP_C_40 = 9'd137,
    COMP_LOOP_C_41 = 9'd138,
    COMP_LOOP_C_42 = 9'd139,
    COMP_LOOP_C_43 = 9'd140,
    COMP_LOOP_C_44 = 9'd141,
    COMP_LOOP_C_45 = 9'd142,
    COMP_LOOP_C_46 = 9'd143,
    COMP_LOOP_C_47 = 9'd144,
    COMP_LOOP_C_48 = 9'd145,
    COMP_LOOP_C_49 = 9'd146,
    COMP_LOOP_C_50 = 9'd147,
    COMP_LOOP_C_51 = 9'd148,
    COMP_LOOP_C_52 = 9'd149,
    COMP_LOOP_C_53 = 9'd150,
    COMP_LOOP_C_54 = 9'd151,
    COMP_LOOP_C_55 = 9'd152,
    COMP_LOOP_C_56 = 9'd153,
    COMP_LOOP_C_57 = 9'd154,
    COMP_LOOP_C_58 = 9'd155,
    COMP_LOOP_C_59 = 9'd156,
    COMP_LOOP_C_60 = 9'd157,
    COMP_LOOP_C_61 = 9'd158,
    COMP_LOOP_C_62 = 9'd159,
    COMP_LOOP_C_63 = 9'd160,
    COMP_LOOP_C_64 = 9'd161,
    COMP_LOOP_C_65 = 9'd162,
    COMP_LOOP_C_66 = 9'd163,
    COMP_LOOP_C_67 = 9'd164,
    COMP_LOOP_C_68 = 9'd165,
    COMP_LOOP_C_69 = 9'd166,
    COMP_LOOP_2_modExp_1_while_C_0 = 9'd167,
    COMP_LOOP_2_modExp_1_while_C_1 = 9'd168,
    COMP_LOOP_2_modExp_1_while_C_2 = 9'd169,
    COMP_LOOP_2_modExp_1_while_C_3 = 9'd170,
    COMP_LOOP_2_modExp_1_while_C_4 = 9'd171,
    COMP_LOOP_2_modExp_1_while_C_5 = 9'd172,
    COMP_LOOP_2_modExp_1_while_C_6 = 9'd173,
    COMP_LOOP_2_modExp_1_while_C_7 = 9'd174,
    COMP_LOOP_2_modExp_1_while_C_8 = 9'd175,
    COMP_LOOP_2_modExp_1_while_C_9 = 9'd176,
    COMP_LOOP_2_modExp_1_while_C_10 = 9'd177,
    COMP_LOOP_2_modExp_1_while_C_11 = 9'd178,
    COMP_LOOP_2_modExp_1_while_C_12 = 9'd179,
    COMP_LOOP_2_modExp_1_while_C_13 = 9'd180,
    COMP_LOOP_2_modExp_1_while_C_14 = 9'd181,
    COMP_LOOP_2_modExp_1_while_C_15 = 9'd182,
    COMP_LOOP_2_modExp_1_while_C_16 = 9'd183,
    COMP_LOOP_2_modExp_1_while_C_17 = 9'd184,
    COMP_LOOP_2_modExp_1_while_C_18 = 9'd185,
    COMP_LOOP_2_modExp_1_while_C_19 = 9'd186,
    COMP_LOOP_2_modExp_1_while_C_20 = 9'd187,
    COMP_LOOP_2_modExp_1_while_C_21 = 9'd188,
    COMP_LOOP_2_modExp_1_while_C_22 = 9'd189,
    COMP_LOOP_2_modExp_1_while_C_23 = 9'd190,
    COMP_LOOP_2_modExp_1_while_C_24 = 9'd191,
    COMP_LOOP_2_modExp_1_while_C_25 = 9'd192,
    COMP_LOOP_2_modExp_1_while_C_26 = 9'd193,
    COMP_LOOP_2_modExp_1_while_C_27 = 9'd194,
    COMP_LOOP_2_modExp_1_while_C_28 = 9'd195,
    COMP_LOOP_2_modExp_1_while_C_29 = 9'd196,
    COMP_LOOP_2_modExp_1_while_C_30 = 9'd197,
    COMP_LOOP_2_modExp_1_while_C_31 = 9'd198,
    COMP_LOOP_2_modExp_1_while_C_32 = 9'd199,
    COMP_LOOP_2_modExp_1_while_C_33 = 9'd200,
    COMP_LOOP_2_modExp_1_while_C_34 = 9'd201,
    COMP_LOOP_2_modExp_1_while_C_35 = 9'd202,
    COMP_LOOP_2_modExp_1_while_C_36 = 9'd203,
    COMP_LOOP_2_modExp_1_while_C_37 = 9'd204,
    COMP_LOOP_2_modExp_1_while_C_38 = 9'd205,
    COMP_LOOP_2_modExp_1_while_C_39 = 9'd206,
    COMP_LOOP_2_modExp_1_while_C_40 = 9'd207,
    COMP_LOOP_2_modExp_1_while_C_41 = 9'd208,
    COMP_LOOP_2_modExp_1_while_C_42 = 9'd209,
    COMP_LOOP_C_70 = 9'd210,
    COMP_LOOP_C_71 = 9'd211,
    COMP_LOOP_C_72 = 9'd212,
    COMP_LOOP_C_73 = 9'd213,
    COMP_LOOP_C_74 = 9'd214,
    COMP_LOOP_C_75 = 9'd215,
    COMP_LOOP_C_76 = 9'd216,
    COMP_LOOP_C_77 = 9'd217,
    COMP_LOOP_C_78 = 9'd218,
    COMP_LOOP_C_79 = 9'd219,
    COMP_LOOP_C_80 = 9'd220,
    COMP_LOOP_C_81 = 9'd221,
    COMP_LOOP_C_82 = 9'd222,
    COMP_LOOP_C_83 = 9'd223,
    COMP_LOOP_C_84 = 9'd224,
    COMP_LOOP_C_85 = 9'd225,
    COMP_LOOP_C_86 = 9'd226,
    COMP_LOOP_C_87 = 9'd227,
    COMP_LOOP_C_88 = 9'd228,
    COMP_LOOP_C_89 = 9'd229,
    COMP_LOOP_C_90 = 9'd230,
    COMP_LOOP_C_91 = 9'd231,
    COMP_LOOP_C_92 = 9'd232,
    COMP_LOOP_C_93 = 9'd233,
    COMP_LOOP_C_94 = 9'd234,
    COMP_LOOP_C_95 = 9'd235,
    COMP_LOOP_C_96 = 9'd236,
    COMP_LOOP_C_97 = 9'd237,
    COMP_LOOP_C_98 = 9'd238,
    COMP_LOOP_C_99 = 9'd239,
    COMP_LOOP_C_100 = 9'd240,
    COMP_LOOP_C_101 = 9'd241,
    COMP_LOOP_C_102 = 9'd242,
    COMP_LOOP_C_103 = 9'd243,
    COMP_LOOP_C_104 = 9'd244,
    COMP_LOOP_C_105 = 9'd245,
    COMP_LOOP_C_106 = 9'd246,
    COMP_LOOP_C_107 = 9'd247,
    COMP_LOOP_C_108 = 9'd248,
    COMP_LOOP_C_109 = 9'd249,
    COMP_LOOP_C_110 = 9'd250,
    COMP_LOOP_C_111 = 9'd251,
    COMP_LOOP_C_112 = 9'd252,
    COMP_LOOP_C_113 = 9'd253,
    COMP_LOOP_C_114 = 9'd254,
    COMP_LOOP_C_115 = 9'd255,
    COMP_LOOP_C_116 = 9'd256,
    COMP_LOOP_C_117 = 9'd257,
    COMP_LOOP_C_118 = 9'd258,
    COMP_LOOP_C_119 = 9'd259,
    COMP_LOOP_C_120 = 9'd260,
    COMP_LOOP_C_121 = 9'd261,
    COMP_LOOP_C_122 = 9'd262,
    COMP_LOOP_C_123 = 9'd263,
    COMP_LOOP_C_124 = 9'd264,
    COMP_LOOP_C_125 = 9'd265,
    COMP_LOOP_C_126 = 9'd266,
    COMP_LOOP_C_127 = 9'd267,
    COMP_LOOP_C_128 = 9'd268,
    COMP_LOOP_C_129 = 9'd269,
    COMP_LOOP_C_130 = 9'd270,
    COMP_LOOP_C_131 = 9'd271,
    COMP_LOOP_C_132 = 9'd272,
    COMP_LOOP_C_133 = 9'd273,
    COMP_LOOP_C_134 = 9'd274,
    COMP_LOOP_C_135 = 9'd275,
    COMP_LOOP_C_136 = 9'd276,
    VEC_LOOP_C_0 = 9'd277,
    STAGE_LOOP_C_10 = 9'd278,
    main_C_1 = 9'd279;

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
        state_var_NS = STAGE_LOOP_C_6;
      end
      STAGE_LOOP_C_6 : begin
        fsm_output = 9'b000000111;
        state_var_NS = STAGE_LOOP_C_7;
      end
      STAGE_LOOP_C_7 : begin
        fsm_output = 9'b000001000;
        state_var_NS = STAGE_LOOP_C_8;
      end
      STAGE_LOOP_C_8 : begin
        fsm_output = 9'b000001001;
        state_var_NS = STAGE_LOOP_C_9;
      end
      STAGE_LOOP_C_9 : begin
        fsm_output = 9'b000001010;
        if ( STAGE_LOOP_C_9_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      modExp_while_C_0 : begin
        fsm_output = 9'b000001011;
        state_var_NS = modExp_while_C_1;
      end
      modExp_while_C_1 : begin
        fsm_output = 9'b000001100;
        state_var_NS = modExp_while_C_2;
      end
      modExp_while_C_2 : begin
        fsm_output = 9'b000001101;
        state_var_NS = modExp_while_C_3;
      end
      modExp_while_C_3 : begin
        fsm_output = 9'b000001110;
        state_var_NS = modExp_while_C_4;
      end
      modExp_while_C_4 : begin
        fsm_output = 9'b000001111;
        state_var_NS = modExp_while_C_5;
      end
      modExp_while_C_5 : begin
        fsm_output = 9'b000010000;
        state_var_NS = modExp_while_C_6;
      end
      modExp_while_C_6 : begin
        fsm_output = 9'b000010001;
        state_var_NS = modExp_while_C_7;
      end
      modExp_while_C_7 : begin
        fsm_output = 9'b000010010;
        state_var_NS = modExp_while_C_8;
      end
      modExp_while_C_8 : begin
        fsm_output = 9'b000010011;
        state_var_NS = modExp_while_C_9;
      end
      modExp_while_C_9 : begin
        fsm_output = 9'b000010100;
        state_var_NS = modExp_while_C_10;
      end
      modExp_while_C_10 : begin
        fsm_output = 9'b000010101;
        state_var_NS = modExp_while_C_11;
      end
      modExp_while_C_11 : begin
        fsm_output = 9'b000010110;
        state_var_NS = modExp_while_C_12;
      end
      modExp_while_C_12 : begin
        fsm_output = 9'b000010111;
        state_var_NS = modExp_while_C_13;
      end
      modExp_while_C_13 : begin
        fsm_output = 9'b000011000;
        state_var_NS = modExp_while_C_14;
      end
      modExp_while_C_14 : begin
        fsm_output = 9'b000011001;
        state_var_NS = modExp_while_C_15;
      end
      modExp_while_C_15 : begin
        fsm_output = 9'b000011010;
        state_var_NS = modExp_while_C_16;
      end
      modExp_while_C_16 : begin
        fsm_output = 9'b000011011;
        state_var_NS = modExp_while_C_17;
      end
      modExp_while_C_17 : begin
        fsm_output = 9'b000011100;
        state_var_NS = modExp_while_C_18;
      end
      modExp_while_C_18 : begin
        fsm_output = 9'b000011101;
        state_var_NS = modExp_while_C_19;
      end
      modExp_while_C_19 : begin
        fsm_output = 9'b000011110;
        state_var_NS = modExp_while_C_20;
      end
      modExp_while_C_20 : begin
        fsm_output = 9'b000011111;
        state_var_NS = modExp_while_C_21;
      end
      modExp_while_C_21 : begin
        fsm_output = 9'b000100000;
        state_var_NS = modExp_while_C_22;
      end
      modExp_while_C_22 : begin
        fsm_output = 9'b000100001;
        state_var_NS = modExp_while_C_23;
      end
      modExp_while_C_23 : begin
        fsm_output = 9'b000100010;
        state_var_NS = modExp_while_C_24;
      end
      modExp_while_C_24 : begin
        fsm_output = 9'b000100011;
        state_var_NS = modExp_while_C_25;
      end
      modExp_while_C_25 : begin
        fsm_output = 9'b000100100;
        state_var_NS = modExp_while_C_26;
      end
      modExp_while_C_26 : begin
        fsm_output = 9'b000100101;
        state_var_NS = modExp_while_C_27;
      end
      modExp_while_C_27 : begin
        fsm_output = 9'b000100110;
        state_var_NS = modExp_while_C_28;
      end
      modExp_while_C_28 : begin
        fsm_output = 9'b000100111;
        state_var_NS = modExp_while_C_29;
      end
      modExp_while_C_29 : begin
        fsm_output = 9'b000101000;
        state_var_NS = modExp_while_C_30;
      end
      modExp_while_C_30 : begin
        fsm_output = 9'b000101001;
        state_var_NS = modExp_while_C_31;
      end
      modExp_while_C_31 : begin
        fsm_output = 9'b000101010;
        state_var_NS = modExp_while_C_32;
      end
      modExp_while_C_32 : begin
        fsm_output = 9'b000101011;
        state_var_NS = modExp_while_C_33;
      end
      modExp_while_C_33 : begin
        fsm_output = 9'b000101100;
        state_var_NS = modExp_while_C_34;
      end
      modExp_while_C_34 : begin
        fsm_output = 9'b000101101;
        state_var_NS = modExp_while_C_35;
      end
      modExp_while_C_35 : begin
        fsm_output = 9'b000101110;
        state_var_NS = modExp_while_C_36;
      end
      modExp_while_C_36 : begin
        fsm_output = 9'b000101111;
        state_var_NS = modExp_while_C_37;
      end
      modExp_while_C_37 : begin
        fsm_output = 9'b000110000;
        state_var_NS = modExp_while_C_38;
      end
      modExp_while_C_38 : begin
        fsm_output = 9'b000110001;
        state_var_NS = modExp_while_C_39;
      end
      modExp_while_C_39 : begin
        fsm_output = 9'b000110010;
        state_var_NS = modExp_while_C_40;
      end
      modExp_while_C_40 : begin
        fsm_output = 9'b000110011;
        state_var_NS = modExp_while_C_41;
      end
      modExp_while_C_41 : begin
        fsm_output = 9'b000110100;
        state_var_NS = modExp_while_C_42;
      end
      modExp_while_C_42 : begin
        fsm_output = 9'b000110101;
        if ( modExp_while_C_42_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 9'b000110110;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 9'b000110111;
        if ( COMP_LOOP_C_1_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_1_modExp_1_while_C_0 : begin
        fsm_output = 9'b000111000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_1;
      end
      COMP_LOOP_1_modExp_1_while_C_1 : begin
        fsm_output = 9'b000111001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_2;
      end
      COMP_LOOP_1_modExp_1_while_C_2 : begin
        fsm_output = 9'b000111010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_3;
      end
      COMP_LOOP_1_modExp_1_while_C_3 : begin
        fsm_output = 9'b000111011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_4;
      end
      COMP_LOOP_1_modExp_1_while_C_4 : begin
        fsm_output = 9'b000111100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_5;
      end
      COMP_LOOP_1_modExp_1_while_C_5 : begin
        fsm_output = 9'b000111101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_6;
      end
      COMP_LOOP_1_modExp_1_while_C_6 : begin
        fsm_output = 9'b000111110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_7;
      end
      COMP_LOOP_1_modExp_1_while_C_7 : begin
        fsm_output = 9'b000111111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_8;
      end
      COMP_LOOP_1_modExp_1_while_C_8 : begin
        fsm_output = 9'b001000000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_9;
      end
      COMP_LOOP_1_modExp_1_while_C_9 : begin
        fsm_output = 9'b001000001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_10;
      end
      COMP_LOOP_1_modExp_1_while_C_10 : begin
        fsm_output = 9'b001000010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_11;
      end
      COMP_LOOP_1_modExp_1_while_C_11 : begin
        fsm_output = 9'b001000011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_12;
      end
      COMP_LOOP_1_modExp_1_while_C_12 : begin
        fsm_output = 9'b001000100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_13;
      end
      COMP_LOOP_1_modExp_1_while_C_13 : begin
        fsm_output = 9'b001000101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_14;
      end
      COMP_LOOP_1_modExp_1_while_C_14 : begin
        fsm_output = 9'b001000110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_15;
      end
      COMP_LOOP_1_modExp_1_while_C_15 : begin
        fsm_output = 9'b001000111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_16;
      end
      COMP_LOOP_1_modExp_1_while_C_16 : begin
        fsm_output = 9'b001001000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_17;
      end
      COMP_LOOP_1_modExp_1_while_C_17 : begin
        fsm_output = 9'b001001001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_18;
      end
      COMP_LOOP_1_modExp_1_while_C_18 : begin
        fsm_output = 9'b001001010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_19;
      end
      COMP_LOOP_1_modExp_1_while_C_19 : begin
        fsm_output = 9'b001001011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_20;
      end
      COMP_LOOP_1_modExp_1_while_C_20 : begin
        fsm_output = 9'b001001100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_21;
      end
      COMP_LOOP_1_modExp_1_while_C_21 : begin
        fsm_output = 9'b001001101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_22;
      end
      COMP_LOOP_1_modExp_1_while_C_22 : begin
        fsm_output = 9'b001001110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_23;
      end
      COMP_LOOP_1_modExp_1_while_C_23 : begin
        fsm_output = 9'b001001111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_24;
      end
      COMP_LOOP_1_modExp_1_while_C_24 : begin
        fsm_output = 9'b001010000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_25;
      end
      COMP_LOOP_1_modExp_1_while_C_25 : begin
        fsm_output = 9'b001010001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_26;
      end
      COMP_LOOP_1_modExp_1_while_C_26 : begin
        fsm_output = 9'b001010010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_27;
      end
      COMP_LOOP_1_modExp_1_while_C_27 : begin
        fsm_output = 9'b001010011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_28;
      end
      COMP_LOOP_1_modExp_1_while_C_28 : begin
        fsm_output = 9'b001010100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_29;
      end
      COMP_LOOP_1_modExp_1_while_C_29 : begin
        fsm_output = 9'b001010101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_30;
      end
      COMP_LOOP_1_modExp_1_while_C_30 : begin
        fsm_output = 9'b001010110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_31;
      end
      COMP_LOOP_1_modExp_1_while_C_31 : begin
        fsm_output = 9'b001010111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_32;
      end
      COMP_LOOP_1_modExp_1_while_C_32 : begin
        fsm_output = 9'b001011000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_33;
      end
      COMP_LOOP_1_modExp_1_while_C_33 : begin
        fsm_output = 9'b001011001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_34;
      end
      COMP_LOOP_1_modExp_1_while_C_34 : begin
        fsm_output = 9'b001011010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_35;
      end
      COMP_LOOP_1_modExp_1_while_C_35 : begin
        fsm_output = 9'b001011011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_36;
      end
      COMP_LOOP_1_modExp_1_while_C_36 : begin
        fsm_output = 9'b001011100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_37;
      end
      COMP_LOOP_1_modExp_1_while_C_37 : begin
        fsm_output = 9'b001011101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_38;
      end
      COMP_LOOP_1_modExp_1_while_C_38 : begin
        fsm_output = 9'b001011110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_39;
      end
      COMP_LOOP_1_modExp_1_while_C_39 : begin
        fsm_output = 9'b001011111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_40;
      end
      COMP_LOOP_1_modExp_1_while_C_40 : begin
        fsm_output = 9'b001100000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_41;
      end
      COMP_LOOP_1_modExp_1_while_C_41 : begin
        fsm_output = 9'b001100001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_42;
      end
      COMP_LOOP_1_modExp_1_while_C_42 : begin
        fsm_output = 9'b001100010;
        if ( COMP_LOOP_1_modExp_1_while_C_42_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 9'b001100011;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 9'b001100100;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 9'b001100101;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 9'b001100110;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 9'b001100111;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 9'b001101000;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 9'b001101001;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 9'b001101010;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 9'b001101011;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 9'b001101100;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 9'b001101101;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 9'b001101110;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 9'b001101111;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 9'b001110000;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 9'b001110001;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 9'b001110010;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 9'b001110011;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 9'b001110100;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 9'b001110101;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 9'b001110110;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 9'b001110111;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 9'b001111000;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 9'b001111001;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 9'b001111010;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 9'b001111011;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 9'b001111100;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 9'b001111101;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 9'b001111110;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 9'b001111111;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 9'b010000000;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 9'b010000001;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 9'b010000010;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 9'b010000011;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 9'b010000100;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 9'b010000101;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 9'b010000110;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 9'b010000111;
        state_var_NS = COMP_LOOP_C_39;
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 9'b010001000;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 9'b010001001;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 9'b010001010;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 9'b010001011;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 9'b010001100;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 9'b010001101;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 9'b010001110;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 9'b010001111;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 9'b010010000;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 9'b010010001;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 9'b010010010;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 9'b010010011;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 9'b010010100;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 9'b010010101;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 9'b010010110;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 9'b010010111;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 9'b010011000;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 9'b010011001;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 9'b010011010;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 9'b010011011;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 9'b010011100;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 9'b010011101;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 9'b010011110;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 9'b010011111;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 9'b010100000;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 9'b010100001;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 9'b010100010;
        state_var_NS = COMP_LOOP_C_66;
      end
      COMP_LOOP_C_66 : begin
        fsm_output = 9'b010100011;
        state_var_NS = COMP_LOOP_C_67;
      end
      COMP_LOOP_C_67 : begin
        fsm_output = 9'b010100100;
        state_var_NS = COMP_LOOP_C_68;
      end
      COMP_LOOP_C_68 : begin
        fsm_output = 9'b010100101;
        if ( COMP_LOOP_C_68_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_69;
        end
      end
      COMP_LOOP_C_69 : begin
        fsm_output = 9'b010100110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_0;
      end
      COMP_LOOP_2_modExp_1_while_C_0 : begin
        fsm_output = 9'b010100111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_1;
      end
      COMP_LOOP_2_modExp_1_while_C_1 : begin
        fsm_output = 9'b010101000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_2;
      end
      COMP_LOOP_2_modExp_1_while_C_2 : begin
        fsm_output = 9'b010101001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_3;
      end
      COMP_LOOP_2_modExp_1_while_C_3 : begin
        fsm_output = 9'b010101010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_4;
      end
      COMP_LOOP_2_modExp_1_while_C_4 : begin
        fsm_output = 9'b010101011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_5;
      end
      COMP_LOOP_2_modExp_1_while_C_5 : begin
        fsm_output = 9'b010101100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_6;
      end
      COMP_LOOP_2_modExp_1_while_C_6 : begin
        fsm_output = 9'b010101101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_7;
      end
      COMP_LOOP_2_modExp_1_while_C_7 : begin
        fsm_output = 9'b010101110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_8;
      end
      COMP_LOOP_2_modExp_1_while_C_8 : begin
        fsm_output = 9'b010101111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_9;
      end
      COMP_LOOP_2_modExp_1_while_C_9 : begin
        fsm_output = 9'b010110000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_10;
      end
      COMP_LOOP_2_modExp_1_while_C_10 : begin
        fsm_output = 9'b010110001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_11;
      end
      COMP_LOOP_2_modExp_1_while_C_11 : begin
        fsm_output = 9'b010110010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_12;
      end
      COMP_LOOP_2_modExp_1_while_C_12 : begin
        fsm_output = 9'b010110011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_13;
      end
      COMP_LOOP_2_modExp_1_while_C_13 : begin
        fsm_output = 9'b010110100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_14;
      end
      COMP_LOOP_2_modExp_1_while_C_14 : begin
        fsm_output = 9'b010110101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_15;
      end
      COMP_LOOP_2_modExp_1_while_C_15 : begin
        fsm_output = 9'b010110110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_16;
      end
      COMP_LOOP_2_modExp_1_while_C_16 : begin
        fsm_output = 9'b010110111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_17;
      end
      COMP_LOOP_2_modExp_1_while_C_17 : begin
        fsm_output = 9'b010111000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_18;
      end
      COMP_LOOP_2_modExp_1_while_C_18 : begin
        fsm_output = 9'b010111001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_19;
      end
      COMP_LOOP_2_modExp_1_while_C_19 : begin
        fsm_output = 9'b010111010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_20;
      end
      COMP_LOOP_2_modExp_1_while_C_20 : begin
        fsm_output = 9'b010111011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_21;
      end
      COMP_LOOP_2_modExp_1_while_C_21 : begin
        fsm_output = 9'b010111100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_22;
      end
      COMP_LOOP_2_modExp_1_while_C_22 : begin
        fsm_output = 9'b010111101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_23;
      end
      COMP_LOOP_2_modExp_1_while_C_23 : begin
        fsm_output = 9'b010111110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_24;
      end
      COMP_LOOP_2_modExp_1_while_C_24 : begin
        fsm_output = 9'b010111111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_25;
      end
      COMP_LOOP_2_modExp_1_while_C_25 : begin
        fsm_output = 9'b011000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_26;
      end
      COMP_LOOP_2_modExp_1_while_C_26 : begin
        fsm_output = 9'b011000001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_27;
      end
      COMP_LOOP_2_modExp_1_while_C_27 : begin
        fsm_output = 9'b011000010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_28;
      end
      COMP_LOOP_2_modExp_1_while_C_28 : begin
        fsm_output = 9'b011000011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_29;
      end
      COMP_LOOP_2_modExp_1_while_C_29 : begin
        fsm_output = 9'b011000100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_30;
      end
      COMP_LOOP_2_modExp_1_while_C_30 : begin
        fsm_output = 9'b011000101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_31;
      end
      COMP_LOOP_2_modExp_1_while_C_31 : begin
        fsm_output = 9'b011000110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_32;
      end
      COMP_LOOP_2_modExp_1_while_C_32 : begin
        fsm_output = 9'b011000111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_33;
      end
      COMP_LOOP_2_modExp_1_while_C_33 : begin
        fsm_output = 9'b011001000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_34;
      end
      COMP_LOOP_2_modExp_1_while_C_34 : begin
        fsm_output = 9'b011001001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_35;
      end
      COMP_LOOP_2_modExp_1_while_C_35 : begin
        fsm_output = 9'b011001010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_36;
      end
      COMP_LOOP_2_modExp_1_while_C_36 : begin
        fsm_output = 9'b011001011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_37;
      end
      COMP_LOOP_2_modExp_1_while_C_37 : begin
        fsm_output = 9'b011001100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_38;
      end
      COMP_LOOP_2_modExp_1_while_C_38 : begin
        fsm_output = 9'b011001101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_39;
      end
      COMP_LOOP_2_modExp_1_while_C_39 : begin
        fsm_output = 9'b011001110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_40;
      end
      COMP_LOOP_2_modExp_1_while_C_40 : begin
        fsm_output = 9'b011001111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_41;
      end
      COMP_LOOP_2_modExp_1_while_C_41 : begin
        fsm_output = 9'b011010000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_42;
      end
      COMP_LOOP_2_modExp_1_while_C_42 : begin
        fsm_output = 9'b011010001;
        if ( COMP_LOOP_2_modExp_1_while_C_42_tr0 ) begin
          state_var_NS = COMP_LOOP_C_70;
        end
        else begin
          state_var_NS = COMP_LOOP_2_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_C_70 : begin
        fsm_output = 9'b011010010;
        state_var_NS = COMP_LOOP_C_71;
      end
      COMP_LOOP_C_71 : begin
        fsm_output = 9'b011010011;
        state_var_NS = COMP_LOOP_C_72;
      end
      COMP_LOOP_C_72 : begin
        fsm_output = 9'b011010100;
        state_var_NS = COMP_LOOP_C_73;
      end
      COMP_LOOP_C_73 : begin
        fsm_output = 9'b011010101;
        state_var_NS = COMP_LOOP_C_74;
      end
      COMP_LOOP_C_74 : begin
        fsm_output = 9'b011010110;
        state_var_NS = COMP_LOOP_C_75;
      end
      COMP_LOOP_C_75 : begin
        fsm_output = 9'b011010111;
        state_var_NS = COMP_LOOP_C_76;
      end
      COMP_LOOP_C_76 : begin
        fsm_output = 9'b011011000;
        state_var_NS = COMP_LOOP_C_77;
      end
      COMP_LOOP_C_77 : begin
        fsm_output = 9'b011011001;
        state_var_NS = COMP_LOOP_C_78;
      end
      COMP_LOOP_C_78 : begin
        fsm_output = 9'b011011010;
        state_var_NS = COMP_LOOP_C_79;
      end
      COMP_LOOP_C_79 : begin
        fsm_output = 9'b011011011;
        state_var_NS = COMP_LOOP_C_80;
      end
      COMP_LOOP_C_80 : begin
        fsm_output = 9'b011011100;
        state_var_NS = COMP_LOOP_C_81;
      end
      COMP_LOOP_C_81 : begin
        fsm_output = 9'b011011101;
        state_var_NS = COMP_LOOP_C_82;
      end
      COMP_LOOP_C_82 : begin
        fsm_output = 9'b011011110;
        state_var_NS = COMP_LOOP_C_83;
      end
      COMP_LOOP_C_83 : begin
        fsm_output = 9'b011011111;
        state_var_NS = COMP_LOOP_C_84;
      end
      COMP_LOOP_C_84 : begin
        fsm_output = 9'b011100000;
        state_var_NS = COMP_LOOP_C_85;
      end
      COMP_LOOP_C_85 : begin
        fsm_output = 9'b011100001;
        state_var_NS = COMP_LOOP_C_86;
      end
      COMP_LOOP_C_86 : begin
        fsm_output = 9'b011100010;
        state_var_NS = COMP_LOOP_C_87;
      end
      COMP_LOOP_C_87 : begin
        fsm_output = 9'b011100011;
        state_var_NS = COMP_LOOP_C_88;
      end
      COMP_LOOP_C_88 : begin
        fsm_output = 9'b011100100;
        state_var_NS = COMP_LOOP_C_89;
      end
      COMP_LOOP_C_89 : begin
        fsm_output = 9'b011100101;
        state_var_NS = COMP_LOOP_C_90;
      end
      COMP_LOOP_C_90 : begin
        fsm_output = 9'b011100110;
        state_var_NS = COMP_LOOP_C_91;
      end
      COMP_LOOP_C_91 : begin
        fsm_output = 9'b011100111;
        state_var_NS = COMP_LOOP_C_92;
      end
      COMP_LOOP_C_92 : begin
        fsm_output = 9'b011101000;
        state_var_NS = COMP_LOOP_C_93;
      end
      COMP_LOOP_C_93 : begin
        fsm_output = 9'b011101001;
        state_var_NS = COMP_LOOP_C_94;
      end
      COMP_LOOP_C_94 : begin
        fsm_output = 9'b011101010;
        state_var_NS = COMP_LOOP_C_95;
      end
      COMP_LOOP_C_95 : begin
        fsm_output = 9'b011101011;
        state_var_NS = COMP_LOOP_C_96;
      end
      COMP_LOOP_C_96 : begin
        fsm_output = 9'b011101100;
        state_var_NS = COMP_LOOP_C_97;
      end
      COMP_LOOP_C_97 : begin
        fsm_output = 9'b011101101;
        state_var_NS = COMP_LOOP_C_98;
      end
      COMP_LOOP_C_98 : begin
        fsm_output = 9'b011101110;
        state_var_NS = COMP_LOOP_C_99;
      end
      COMP_LOOP_C_99 : begin
        fsm_output = 9'b011101111;
        state_var_NS = COMP_LOOP_C_100;
      end
      COMP_LOOP_C_100 : begin
        fsm_output = 9'b011110000;
        state_var_NS = COMP_LOOP_C_101;
      end
      COMP_LOOP_C_101 : begin
        fsm_output = 9'b011110001;
        state_var_NS = COMP_LOOP_C_102;
      end
      COMP_LOOP_C_102 : begin
        fsm_output = 9'b011110010;
        state_var_NS = COMP_LOOP_C_103;
      end
      COMP_LOOP_C_103 : begin
        fsm_output = 9'b011110011;
        state_var_NS = COMP_LOOP_C_104;
      end
      COMP_LOOP_C_104 : begin
        fsm_output = 9'b011110100;
        state_var_NS = COMP_LOOP_C_105;
      end
      COMP_LOOP_C_105 : begin
        fsm_output = 9'b011110101;
        state_var_NS = COMP_LOOP_C_106;
      end
      COMP_LOOP_C_106 : begin
        fsm_output = 9'b011110110;
        state_var_NS = COMP_LOOP_C_107;
      end
      COMP_LOOP_C_107 : begin
        fsm_output = 9'b011110111;
        state_var_NS = COMP_LOOP_C_108;
      end
      COMP_LOOP_C_108 : begin
        fsm_output = 9'b011111000;
        state_var_NS = COMP_LOOP_C_109;
      end
      COMP_LOOP_C_109 : begin
        fsm_output = 9'b011111001;
        state_var_NS = COMP_LOOP_C_110;
      end
      COMP_LOOP_C_110 : begin
        fsm_output = 9'b011111010;
        state_var_NS = COMP_LOOP_C_111;
      end
      COMP_LOOP_C_111 : begin
        fsm_output = 9'b011111011;
        state_var_NS = COMP_LOOP_C_112;
      end
      COMP_LOOP_C_112 : begin
        fsm_output = 9'b011111100;
        state_var_NS = COMP_LOOP_C_113;
      end
      COMP_LOOP_C_113 : begin
        fsm_output = 9'b011111101;
        state_var_NS = COMP_LOOP_C_114;
      end
      COMP_LOOP_C_114 : begin
        fsm_output = 9'b011111110;
        state_var_NS = COMP_LOOP_C_115;
      end
      COMP_LOOP_C_115 : begin
        fsm_output = 9'b011111111;
        state_var_NS = COMP_LOOP_C_116;
      end
      COMP_LOOP_C_116 : begin
        fsm_output = 9'b100000000;
        state_var_NS = COMP_LOOP_C_117;
      end
      COMP_LOOP_C_117 : begin
        fsm_output = 9'b100000001;
        state_var_NS = COMP_LOOP_C_118;
      end
      COMP_LOOP_C_118 : begin
        fsm_output = 9'b100000010;
        state_var_NS = COMP_LOOP_C_119;
      end
      COMP_LOOP_C_119 : begin
        fsm_output = 9'b100000011;
        state_var_NS = COMP_LOOP_C_120;
      end
      COMP_LOOP_C_120 : begin
        fsm_output = 9'b100000100;
        state_var_NS = COMP_LOOP_C_121;
      end
      COMP_LOOP_C_121 : begin
        fsm_output = 9'b100000101;
        state_var_NS = COMP_LOOP_C_122;
      end
      COMP_LOOP_C_122 : begin
        fsm_output = 9'b100000110;
        state_var_NS = COMP_LOOP_C_123;
      end
      COMP_LOOP_C_123 : begin
        fsm_output = 9'b100000111;
        state_var_NS = COMP_LOOP_C_124;
      end
      COMP_LOOP_C_124 : begin
        fsm_output = 9'b100001000;
        state_var_NS = COMP_LOOP_C_125;
      end
      COMP_LOOP_C_125 : begin
        fsm_output = 9'b100001001;
        state_var_NS = COMP_LOOP_C_126;
      end
      COMP_LOOP_C_126 : begin
        fsm_output = 9'b100001010;
        state_var_NS = COMP_LOOP_C_127;
      end
      COMP_LOOP_C_127 : begin
        fsm_output = 9'b100001011;
        state_var_NS = COMP_LOOP_C_128;
      end
      COMP_LOOP_C_128 : begin
        fsm_output = 9'b100001100;
        state_var_NS = COMP_LOOP_C_129;
      end
      COMP_LOOP_C_129 : begin
        fsm_output = 9'b100001101;
        state_var_NS = COMP_LOOP_C_130;
      end
      COMP_LOOP_C_130 : begin
        fsm_output = 9'b100001110;
        state_var_NS = COMP_LOOP_C_131;
      end
      COMP_LOOP_C_131 : begin
        fsm_output = 9'b100001111;
        state_var_NS = COMP_LOOP_C_132;
      end
      COMP_LOOP_C_132 : begin
        fsm_output = 9'b100010000;
        state_var_NS = COMP_LOOP_C_133;
      end
      COMP_LOOP_C_133 : begin
        fsm_output = 9'b100010001;
        state_var_NS = COMP_LOOP_C_134;
      end
      COMP_LOOP_C_134 : begin
        fsm_output = 9'b100010010;
        state_var_NS = COMP_LOOP_C_135;
      end
      COMP_LOOP_C_135 : begin
        fsm_output = 9'b100010011;
        state_var_NS = COMP_LOOP_C_136;
      end
      COMP_LOOP_C_136 : begin
        fsm_output = 9'b100010100;
        if ( COMP_LOOP_C_136_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 9'b100010101;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_10;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_10 : begin
        fsm_output = 9'b100010110;
        if ( STAGE_LOOP_C_10_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b100010111;
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
  wire and_dcpl;
  wire or_tmp_35;
  wire or_tmp_37;
  wire nor_tmp_11;
  wire not_tmp_45;
  wire nor_tmp_20;
  wire mux_tmp_62;
  wire not_tmp_64;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_34;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_39;
  wire and_dcpl_40;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire and_dcpl_43;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire and_dcpl_47;
  wire and_dcpl_49;
  wire and_dcpl_52;
  wire and_dcpl_55;
  wire and_dcpl_65;
  wire and_dcpl_66;
  wire and_dcpl_68;
  wire and_dcpl_69;
  wire and_dcpl_76;
  wire and_dcpl_77;
  wire and_dcpl_79;
  wire and_dcpl_80;
  wire and_dcpl_81;
  wire or_dcpl_22;
  wire or_dcpl_24;
  wire and_dcpl_86;
  wire mux_tmp_81;
  wire nor_tmp_28;
  wire not_tmp_93;
  wire mux_tmp_86;
  wire and_dcpl_93;
  wire and_dcpl_97;
  wire mux_tmp_90;
  wire and_dcpl_99;
  wire and_dcpl_100;
  wire and_dcpl_102;
  wire mux_tmp_100;
  wire and_dcpl_112;
  wire or_tmp_122;
  wire and_dcpl_113;
  wire mux_tmp_104;
  wire and_dcpl_116;
  wire and_dcpl_118;
  wire and_dcpl_122;
  wire and_dcpl_132;
  wire and_dcpl_134;
  wire not_tmp_132;
  wire and_dcpl_142;
  wire and_dcpl_144;
  wire or_tmp_177;
  wire and_tmp_19;
  wire or_tmp_184;
  wire and_dcpl_152;
  wire and_dcpl_154;
  wire or_tmp_201;
  wire and_dcpl_159;
  wire or_dcpl_31;
  wire or_dcpl_37;
  wire or_dcpl_38;
  wire or_dcpl_40;
  wire or_dcpl_41;
  wire and_dcpl_163;
  wire and_dcpl_164;
  wire and_dcpl_166;
  wire or_dcpl_48;
  wire or_dcpl_59;
  wire or_dcpl_62;
  reg exit_COMP_LOOP_1_modExp_1_while_sva;
  reg COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  reg [11:0] VEC_LOOP_j_sva_11_0;
  reg modExp_exp_1_0_1_sva;
  reg [11:0] COMP_LOOP_acc_1_cse_sva;
  reg [11:0] COMP_LOOP_acc_10_cse_12_1_1_sva;
  reg [63:0] COMP_LOOP_1_acc_8_itm;
  wire and_139_m1c;
  reg reg_vec_rsc_triosy_0_1_obj_ld_cse;
  wire and_254_cse;
  wire and_217_cse;
  wire or_142_cse;
  wire or_292_cse;
  wire or_342_cse;
  wire nor_110_cse;
  wire and_216_cse;
  wire or_221_cse;
  wire and_270_cse;
  wire or_38_cse;
  wire or_327_cse;
  reg [7:0] COMP_LOOP_k_9_1_sva_7_0;
  wire and_cse;
  wire [10:0] COMP_LOOP_acc_psp_sva_1;
  wire [11:0] nl_COMP_LOOP_acc_psp_sva_1;
  reg [10:0] COMP_LOOP_acc_psp_sva;
  wire [63:0] vec_rsc_0_0_i_da_d_1;
  wire and_dcpl_197;
  wire [64:0] z_out;
  wire and_dcpl_198;
  wire and_dcpl_201;
  wire and_dcpl_202;
  wire and_dcpl_205;
  wire and_dcpl_206;
  wire and_dcpl_212;
  wire and_dcpl_216;
  wire and_dcpl_217;
  wire and_dcpl_226;
  wire [64:0] z_out_1;
  wire and_dcpl_247;
  wire and_dcpl_256;
  wire and_dcpl_269;
  wire [12:0] z_out_3;
  wire [13:0] nl_z_out_3;
  wire and_dcpl_284;
  wire [63:0] z_out_5;
  wire signed [128:0] nl_z_out_5;
  reg [63:0] p_sva;
  reg [63:0] r_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [9:0] STAGE_LOOP_lshift_psp_sva;
  reg [63:0] modExp_result_sva;
  reg modExp_exp_1_7_1_sva;
  reg modExp_exp_1_5_1_sva;
  reg modExp_exp_1_4_1_sva;
  reg modExp_exp_1_3_1_sva;
  reg modExp_exp_1_2_1_sva;
  reg modExp_exp_1_1_1_sva;
  reg modExp_exp_1_0_1_sva_1;
  reg modExp_exp_1_5_1_sva_1;
  reg [63:0] modExp_while_if_mul_mut;
  reg [63:0] COMP_LOOP_1_modExp_1_while_if_mul_mut;
  reg [63:0] COMP_LOOP_1_mul_mut;
  reg [63:0] COMP_LOOP_1_acc_5_mut;
  reg [63:0] COMP_LOOP_2_modExp_1_while_mul_mut;
  reg [63:0] COMP_LOOP_2_mul_mut;
  reg [63:0] modExp_while_mul_itm;
  reg [63:0] COMP_LOOP_1_modExp_1_while_mul_itm;
  reg [63:0] COMP_LOOP_2_modExp_1_while_if_mul_itm;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire [63:0] modulo_qr_sva_1_mx0w1;
  wire [64:0] nl_modulo_qr_sva_1_mx0w1;
  wire [63:0] COMP_LOOP_1_acc_5_mut_mx0w7;
  wire [64:0] nl_COMP_LOOP_1_acc_5_mut_mx0w7;
  wire [9:0] STAGE_LOOP_lshift_psp_sva_mx0w0;
  wire VEC_LOOP_j_sva_11_0_mx0c1;
  wire modExp_result_sva_mx0c0;
  wire [62:0] operator_64_false_slc_modExp_exp_63_1_3;
  wire modExp_while_and_3;
  wire modExp_while_and_5;
  wire and_145_m1c;
  wire modExp_result_and_rgt;
  wire modExp_result_and_1_rgt;
  wire COMP_LOOP_or_2_cse;
  wire and_320_cse;
  wire mux_tmp;
  wire [64:0] operator_64_false_mux1h_1_rgt;
  reg operator_64_false_acc_mut_64;
  reg [63:0] operator_64_false_acc_mut_63_0;
  wire nor_215_cse;
  wire STAGE_LOOP_acc_itm_2_1;
  wire z_out_4_8;
  wire nand_18_cse;

  wire[0:0] modulo_result_or_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] nor_121_nl;
  wire[0:0] nor_122_nl;
  wire[0:0] nor_123_nl;
  wire[0:0] and_96_nl;
  wire[0:0] and_98_nl;
  wire[0:0] and_102_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] or_133_nl;
  wire[0:0] and_105_nl;
  wire[0:0] mux_84_nl;
  wire[0:0] nor_120_nl;
  wire[0:0] and_106_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] nor_168_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] nand_42_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] or_360_nl;
  wire[0:0] nand_43_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] and_250_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] mux_95_nl;
  wire[0:0] nor_115_nl;
  wire[0:0] and_251_nl;
  wire[0:0] nor_116_nl;
  wire[0:0] mux_94_nl;
  wire[0:0] and_122_nl;
  wire[0:0] and_123_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] and_249_nl;
  wire[0:0] nor_114_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] and_126_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] nor_113_nl;
  wire[63:0] COMP_LOOP_COMP_LOOP_mux_2_nl;
  wire[0:0] and_206_nl;
  wire[0:0] mux_201_nl;
  wire[0:0] and_219_nl;
  wire[0:0] nor_82_nl;
  wire[0:0] and_131_nl;
  wire[0:0] nor_167_nl;
  wire[0:0] mux_110_nl;
  wire[0:0] mux_109_nl;
  wire[0:0] mux_108_nl;
  wire[0:0] mux_107_nl;
  wire[0:0] nor_111_nl;
  wire[0:0] and_246_nl;
  wire[0:0] mux_106_nl;
  wire[0:0] mux_105_nl;
  wire[0:0] nor_112_nl;
  wire[0:0] and_248_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[0:0] nor_216_nl;
  wire[0:0] mux_219_nl;
  wire[0:0] or_388_nl;
  wire[0:0] or_387_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] and_400_nl;
  wire[0:0] or_384_nl;
  wire[0:0] nand_53_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] mux_215_nl;
  wire[0:0] and_401_nl;
  wire[0:0] or_382_nl;
  wire[0:0] mux_224_nl;
  wire[0:0] mux_223_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] nor_211_nl;
  wire[0:0] nor_212_nl;
  wire[0:0] nor_213_nl;
  wire[0:0] nor_214_nl;
  wire[0:0] nand_50_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] or_165_nl;
  wire[0:0] mux_226_nl;
  wire[0:0] nor_208_nl;
  wire[0:0] mux_225_nl;
  wire[0:0] or_400_nl;
  wire[0:0] or_398_nl;
  wire[0:0] nor_209_nl;
  wire[0:0] nor_210_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] or_336_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] or_180_nl;
  wire[0:0] or_337_nl;
  wire[0:0] nor_106_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] or_175_nl;
  wire[0:0] mux_128_nl;
  wire[0:0] nor_104_nl;
  wire[0:0] nor_105_nl;
  wire[0:0] and_142_nl;
  wire[0:0] COMP_LOOP_or_7_nl;
  wire[0:0] COMP_LOOP_or_8_nl;
  wire[0:0] and_154_nl;
  wire[0:0] and_157_nl;
  wire[0:0] mux_141_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] mux_139_nl;
  wire[0:0] or_197_nl;
  wire[0:0] or_71_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] mux_46_nl;
  wire[0:0] or_70_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] or_333_nl;
  wire[0:0] nand_29_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] nand_30_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] nor_144_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] COMP_LOOP_and_nl;
  wire[0:0] COMP_LOOP_and_1_nl;
  wire[0:0] mux_156_nl;
  wire[0:0] mux_155_nl;
  wire[0:0] mux_154_nl;
  wire[0:0] mux_153_nl;
  wire[0:0] mux_152_nl;
  wire[0:0] nor_96_nl;
  wire[0:0] mux_151_nl;
  wire[0:0] mux_150_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] or_331_nl;
  wire[0:0] and_234_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] nand_5_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] mux_146_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] or_204_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] or_202_nl;
  wire[0:0] nor_99_nl;
  wire[0:0] mux_143_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] or_200_nl;
  wire[0:0] or_199_nl;
  wire[0:0] COMP_LOOP_mux1h_16_nl;
  wire[0:0] COMP_LOOP_and_5_nl;
  wire[0:0] mux_168_nl;
  wire[0:0] mux_167_nl;
  wire[0:0] mux_166_nl;
  wire[0:0] mux_165_nl;
  wire[0:0] mux_164_nl;
  wire[0:0] mux_163_nl;
  wire[0:0] or_219_nl;
  wire[0:0] mux_162_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] mux_160_nl;
  wire[0:0] or_218_nl;
  wire[0:0] mux_159_nl;
  wire[0:0] mux_158_nl;
  wire[0:0] or_216_nl;
  wire[0:0] or_47_nl;
  wire[0:0] mux_176_nl;
  wire[0:0] mux_175_nl;
  wire[0:0] mux_174_nl;
  wire[0:0] mux_173_nl;
  wire[0:0] or_230_nl;
  wire[0:0] and_242_nl;
  wire[0:0] mux_172_nl;
  wire[0:0] mux_171_nl;
  wire[0:0] mux_170_nl;
  wire[0:0] mux_169_nl;
  wire[0:0] and_230_nl;
  wire[0:0] or_225_nl;
  wire[0:0] or_223_nl;
  wire[0:0] mux_178_nl;
  wire[0:0] mux_177_nl;
  wire[9:0] COMP_LOOP_1_acc_nl;
  wire[10:0] nl_COMP_LOOP_1_acc_nl;
  wire[0:0] mux_183_nl;
  wire[0:0] nor_164_nl;
  wire[0:0] and_281_nl;
  wire[0:0] and_194_nl;
  wire[0:0] mux_193_nl;
  wire[0:0] nor_86_nl;
  wire[0:0] nor_87_nl;
  wire[0:0] mux_192_nl;
  wire[0:0] nand_40_nl;
  wire[0:0] mux_191_nl;
  wire[0:0] mux_190_nl;
  wire[0:0] or_277_nl;
  wire[0:0] mux_189_nl;
  wire[0:0] and_191_nl;
  wire[0:0] or_358_nl;
  wire[0:0] mux_188_nl;
  wire[0:0] nand_10_nl;
  wire[0:0] nor_89_nl;
  wire[0:0] COMP_LOOP_mux1h_26_nl;
  wire[0:0] COMP_LOOP_mux1h_40_nl;
  wire[0:0] nor_160_nl;
  wire[0:0] mux_199_nl;
  wire[0:0] mux_198_nl;
  wire[0:0] nand_46_nl;
  wire[0:0] mux_197_nl;
  wire[0:0] mux_196_nl;
  wire[0:0] mux_195_nl;
  wire[0:0] nand_9_nl;
  wire[0:0] mux_194_nl;
  wire[0:0] or_282_nl;
  wire[0:0] mux_206_nl;
  wire[0:0] or_297_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] and_213_nl;
  wire[0:0] nor_81_nl;
  wire[0:0] or_347_nl;
  wire[0:0] nor_140_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] nor_118_nl;
  wire[0:0] nor_119_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] or_152_nl;
  wire[0:0] or_151_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] and_404_nl;
  wire[0:0] nor_nl;
  wire[0:0] nor_102_nl;
  wire[0:0] nor_103_nl;
  wire[0:0] mux_157_nl;
  wire[0:0] or_211_nl;
  wire[0:0] mux_184_nl;
  wire[0:0] nor_91_nl;
  wire[0:0] nor_92_nl;
  wire[0:0] mux_187_nl;
  wire[0:0] nand_41_nl;
  wire[0:0] mux_186_nl;
  wire[0:0] and_186_nl;
  wire[0:0] or_270_nl;
  wire[0:0] mux_185_nl;
  wire[0:0] and_280_nl;
  wire[0:0] or_359_nl;
  wire[0:0] nor_107_nl;
  wire[0:0] mux_122_nl;
  wire[2:0] STAGE_LOOP_acc_nl;
  wire[3:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] and_70_nl;
  wire[0:0] nor_175_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] or_366_nl;
  wire[0:0] or_367_nl;
  wire[0:0] and_75_nl;
  wire[0:0] mux_66_nl;
  wire[0:0] nor_136_nl;
  wire[0:0] nor_137_nl;
  wire[0:0] nor_133_nl;
  wire[0:0] nor_134_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] nor_135_nl;
  wire[0:0] and_260_nl;
  wire[0:0] or_99_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] and_259_nl;
  wire[0:0] mux_71_nl;
  wire[0:0] nor_130_nl;
  wire[0:0] nor_131_nl;
  wire[0:0] nor_132_nl;
  wire[0:0] mux_70_nl;
  wire[0:0] or_107_nl;
  wire[0:0] or_105_nl;
  wire[0:0] nor_127_nl;
  wire[0:0] nor_128_nl;
  wire[0:0] mux_74_nl;
  wire[0:0] nand_25_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] nor_129_nl;
  wire[0:0] and_258_nl;
  wire[0:0] or_113_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] and_257_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] nor_124_nl;
  wire[0:0] nor_125_nl;
  wire[0:0] nor_126_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] or_119_nl;
  wire[0:0] or_117_nl;
  wire[0:0] and_403_nl;
  wire[0:0] or_nl;
  wire[65:0] acc_nl;
  wire[66:0] nl_acc_nl;
  wire[63:0] COMP_LOOP_mux_13_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_nand_2_nl;
  wire[0:0] mux_229_nl;
  wire[0:0] nor_217_nl;
  wire[0:0] nor_218_nl;
  wire[63:0] COMP_LOOP_COMP_LOOP_nand_3_nl;
  wire[0:0] COMP_LOOP_not_50_nl;
  wire[65:0] acc_1_nl;
  wire[66:0] nl_acc_1_nl;
  wire[64:0] COMP_LOOP_mux1h_71_nl;
  wire[0:0] COMP_LOOP_or_17_nl;
  wire[7:0] COMP_LOOP_COMP_LOOP_and_1_nl;
  wire[0:0] COMP_LOOP_nor_4_nl;
  wire[11:0] operator_64_false_1_mux_11_nl;
  wire[0:0] operator_64_false_1_or_3_nl;
  wire[9:0] operator_64_false_1_mux1h_2_nl;
  wire[9:0] COMP_LOOP_acc_13_nl;
  wire[10:0] nl_COMP_LOOP_acc_13_nl;
  wire[0:0] and_405_nl;
  wire[0:0] and_406_nl;
  wire[0:0] operator_64_false_1_or_4_nl;
  wire[8:0] operator_64_false_1_acc_nl;
  wire[9:0] nl_operator_64_false_1_acc_nl;
  wire[0:0] operator_64_false_1_mux_12_nl;
  wire[0:0] operator_64_false_1_mux_13_nl;
  wire[0:0] operator_64_false_1_mux_14_nl;
  wire[0:0] operator_64_false_1_mux_15_nl;
  wire[0:0] operator_64_false_1_mux_16_nl;
  wire[0:0] operator_64_false_1_mux_17_nl;
  wire[0:0] operator_64_false_1_mux_18_nl;
  wire[63:0] modExp_while_if_mux1h_2_nl;
  wire[0:0] and_407_nl;
  wire[0:0] and_408_nl;
  wire[0:0] mux_230_nl;
  wire[0:0] nor_221_nl;
  wire[0:0] and_409_nl;
  wire[0:0] mux_231_nl;
  wire[0:0] nor_222_nl;
  wire[0:0] nor_223_nl;
  wire[0:0] and_410_nl;
  wire[0:0] mux_232_nl;
  wire[0:0] mux_233_nl;
  wire[0:0] nor_225_nl;
  wire[0:0] nor_226_nl;
  wire[0:0] mux_234_nl;
  wire[0:0] or_404_nl;
  wire[0:0] or_405_nl;
  wire[0:0] nor_227_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [10:0] nl_operator_66_true_div_cmp_b;
  assign nl_operator_66_true_div_cmp_b = {1'b0, operator_66_true_div_cmp_b_9_0};
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0 = ~ (z_out_1[64]);
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_68_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_68_tr0 = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_42_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_42_tr0
      = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out_3[12];
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0 = ~ STAGE_LOOP_acc_itm_2_1;
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
      .STAGE_LOOP_C_9_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_9_tr0[0:0]),
      .modExp_while_C_42_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .COMP_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0[0:0]),
      .COMP_LOOP_1_modExp_1_while_C_42_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .COMP_LOOP_C_68_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_68_tr0[0:0]),
      .COMP_LOOP_2_modExp_1_while_C_42_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_42_tr0[0:0]),
      .COMP_LOOP_C_136_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_10_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0[0:0])
    );
  assign and_254_cse = (fsm_output[1:0]==2'b11);
  assign or_142_cse = (fsm_output[1:0]!=2'b00);
  assign and_217_cse = (fsm_output[4]) & (fsm_output[7]);
  assign or_292_cse = (fsm_output[2:1]!=2'b00);
  assign or_342_cse = (fsm_output[2:0]!=3'b000);
  assign nor_110_cse = ~((fsm_output[4]) | (fsm_output[7]));
  assign and_216_cse = (fsm_output[2:0]==3'b111);
  assign and_219_nl = (VEC_LOOP_j_sva_11_0[0]) & (fsm_output[0]) & (fsm_output[4]);
  assign nor_82_nl = ~((~ (COMP_LOOP_acc_1_cse_sva[0])) | (fsm_output[0]) | (fsm_output[4]));
  assign mux_201_nl = MUX_s_1_2_2(and_219_nl, nor_82_nl, fsm_output[7]);
  assign and_206_nl = mux_201_nl & (fsm_output[2]) & (~ (fsm_output[3])) & (fsm_output[1])
      & (fsm_output[5]) & nor_215_cse;
  assign COMP_LOOP_COMP_LOOP_mux_2_nl = MUX_v_64_2_2(vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d,
      and_206_nl);
  assign and_131_nl = and_dcpl_35 & and_dcpl_113 & and_dcpl_32;
  assign nor_111_nl = ~(and_216_cse | (fsm_output[6]));
  assign and_246_nl = or_292_cse & (fsm_output[6]);
  assign mux_107_nl = MUX_s_1_2_2(nor_111_nl, and_246_nl, fsm_output[3]);
  assign mux_108_nl = MUX_s_1_2_2((~ (fsm_output[6])), mux_107_nl, fsm_output[4]);
  assign nor_112_nl = ~(and_270_cse | (fsm_output[6]));
  assign and_248_nl = or_342_cse & (fsm_output[6]);
  assign mux_105_nl = MUX_s_1_2_2(nor_112_nl, and_248_nl, fsm_output[3]);
  assign mux_106_nl = MUX_s_1_2_2(mux_105_nl, (fsm_output[6]), fsm_output[4]);
  assign mux_109_nl = MUX_s_1_2_2(mux_108_nl, mux_106_nl, fsm_output[7]);
  assign mux_110_nl = MUX_s_1_2_2((~ (fsm_output[6])), mux_109_nl, fsm_output[5]);
  assign nor_167_nl = ~(mux_110_nl | (fsm_output[8]));
  assign operator_64_false_mux1h_1_rgt = MUX1HOT_v_65_3_2(z_out, ({2'b00 , operator_64_false_slc_modExp_exp_63_1_3}),
      ({1'b0 , COMP_LOOP_COMP_LOOP_mux_2_nl}), {and_131_nl , and_dcpl_116 , nor_167_nl});
  assign nor_215_cse = ~((fsm_output[6]) | (fsm_output[8]));
  assign and_139_m1c = and_dcpl_36 & and_dcpl_46;
  assign and_cse = (fsm_output[4]) & ((fsm_output[3:2]!=2'b00));
  assign modExp_result_and_rgt = (~ modExp_while_and_5) & and_139_m1c;
  assign modExp_result_and_1_rgt = modExp_while_and_5 & and_139_m1c;
  assign nand_18_cse = ~((fsm_output[4]) & (fsm_output[2]));
  assign nor_104_nl = ~((fsm_output[1:0]!=2'b01) | nand_18_cse);
  assign nor_105_nl = ~((fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[4]) |
      (fsm_output[2]));
  assign mux_128_nl = MUX_s_1_2_2(nor_104_nl, nor_105_nl, fsm_output[6]);
  assign and_145_m1c = mux_128_nl & (~ (fsm_output[3])) & (fsm_output[5]) & and_dcpl_30;
  assign or_221_cse = (fsm_output[2]) | (fsm_output[7]) | (~ (fsm_output[6]));
  assign and_270_cse = (fsm_output[2:1]==2'b11);
  assign or_327_cse = (fsm_output[3:0]!=4'b0000);
  assign COMP_LOOP_or_2_cse = and_dcpl_52 | and_dcpl_68;
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b0001;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_acc_psp_sva_1 = (VEC_LOOP_j_sva_11_0[11:1]) + conv_u2u_8_11(COMP_LOOP_k_9_1_sva_7_0);
  assign COMP_LOOP_acc_psp_sva_1 = nl_COMP_LOOP_acc_psp_sva_1[10:0];
  assign nl_modulo_qr_sva_1_mx0w1 = modulo_result_rem_cmp_z + p_sva;
  assign modulo_qr_sva_1_mx0w1 = nl_modulo_qr_sva_1_mx0w1[63:0];
  assign vec_rsc_0_0_i_da_d_1 = MUX_v_64_2_2(modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w1,
      modulo_result_rem_cmp_z[63]);
  assign nl_COMP_LOOP_1_acc_5_mut_mx0w7 = operator_64_false_acc_mut_63_0 + vec_rsc_0_0_i_da_d_1;
  assign COMP_LOOP_1_acc_5_mut_mx0w7 = nl_COMP_LOOP_1_acc_5_mut_mx0w7[63:0];
  assign operator_64_false_slc_modExp_exp_63_1_3 = MUX_v_63_2_2((operator_66_true_div_cmp_z[63:1]),
      (COMP_LOOP_1_acc_8_itm[63:1]), and_dcpl_122);
  assign modExp_while_and_3 = (~ (modulo_result_rem_cmp_z[63])) & modExp_exp_1_0_1_sva;
  assign modExp_while_and_5 = (modulo_result_rem_cmp_z[63]) & modExp_exp_1_0_1_sva;
  assign and_dcpl = (fsm_output[8:7]==2'b01);
  assign or_38_cse = (fsm_output[4:3]!=2'b00);
  assign or_tmp_35 = (fsm_output[7:6]!=2'b00);
  assign or_tmp_37 = (fsm_output[7:6]!=2'b10);
  assign nor_tmp_11 = or_142_cse & (fsm_output[7]);
  assign not_tmp_45 = ~(and_254_cse | (fsm_output[7]));
  assign nor_tmp_20 = (fsm_output[4:3]==2'b11);
  assign mux_tmp_62 = MUX_s_1_2_2(nor_tmp_20, and_cse, and_254_cse);
  assign or_347_nl = (fsm_output[7:0]!=8'b00000000);
  assign nor_140_nl = ~((fsm_output[7:5]!=3'b000) | mux_tmp_62);
  assign not_tmp_64 = MUX_s_1_2_2(or_347_nl, nor_140_nl, fsm_output[8]);
  assign and_dcpl_30 = ~((fsm_output[8:7]!=2'b00));
  assign and_dcpl_31 = ~((fsm_output[6:5]!=2'b00));
  assign and_dcpl_32 = and_dcpl_31 & and_dcpl_30;
  assign and_dcpl_33 = ~((fsm_output[1:0]!=2'b00));
  assign and_dcpl_34 = ~((fsm_output[3:2]!=2'b00));
  assign and_dcpl_35 = and_dcpl_34 & (~ (fsm_output[4]));
  assign and_dcpl_36 = and_dcpl_35 & and_dcpl_33;
  assign and_dcpl_39 = and_dcpl_31 & (fsm_output[8:7]==2'b10);
  assign and_dcpl_40 = (fsm_output[1:0]==2'b10);
  assign and_dcpl_41 = (fsm_output[3:2]==2'b01);
  assign and_dcpl_42 = and_dcpl_41 & (fsm_output[4]);
  assign and_dcpl_43 = and_dcpl_42 & and_dcpl_40;
  assign and_dcpl_45 = (fsm_output[6:5]==2'b01);
  assign and_dcpl_46 = and_dcpl_45 & and_dcpl_30;
  assign and_dcpl_47 = and_dcpl_43 & and_dcpl_46;
  assign and_dcpl_49 = (fsm_output[6:5]==2'b11) & and_dcpl_30;
  assign and_dcpl_52 = and_dcpl_35 & and_254_cse & and_dcpl_49;
  assign and_dcpl_55 = (fsm_output[3:2]==2'b11);
  assign and_dcpl_65 = (fsm_output[6:5]==2'b10) & and_dcpl;
  assign and_dcpl_66 = and_dcpl_34 & (fsm_output[4]);
  assign and_dcpl_68 = and_dcpl_66 & and_dcpl_40 & and_dcpl_65;
  assign and_dcpl_69 = ~((fsm_output[3]) | (fsm_output[8]));
  assign and_dcpl_76 = (fsm_output[3:2]==2'b10);
  assign and_dcpl_77 = and_dcpl_76 & (~ (fsm_output[4]));
  assign and_dcpl_79 = and_dcpl_77 & and_254_cse & and_dcpl_32;
  assign and_dcpl_80 = ~((fsm_output[7:6]!=2'b00));
  assign and_dcpl_81 = and_dcpl_80 & (~ (fsm_output[8]));
  assign or_dcpl_22 = and_dcpl_55 | (fsm_output[4]);
  assign or_dcpl_24 = ~(((~(and_dcpl_33 | (~ (fsm_output[2])))) | (fsm_output[3]))
      & (fsm_output[4]));
  assign and_dcpl_86 = ~((fsm_output[1]) | (fsm_output[8]));
  assign mux_tmp_81 = MUX_s_1_2_2((fsm_output[4]), or_dcpl_22, or_142_cse);
  assign nor_tmp_28 = (fsm_output[4:2]==3'b111);
  assign mux_82_nl = MUX_s_1_2_2(nor_tmp_28, nor_tmp_20, or_142_cse);
  assign not_tmp_93 = ~((fsm_output[5]) & mux_82_nl);
  assign mux_tmp_86 = MUX_s_1_2_2((~ (fsm_output[3])), and_dcpl_55, fsm_output[4]);
  assign and_dcpl_93 = (fsm_output[6]) & (~ (fsm_output[8]));
  assign nor_118_nl = ~((fsm_output[0]) | (~((fsm_output[1]) & (fsm_output[4]))));
  assign nor_119_nl = ~((~ (fsm_output[0])) | (fsm_output[1]) | (fsm_output[4]));
  assign mux_88_nl = MUX_s_1_2_2(nor_118_nl, nor_119_nl, fsm_output[7]);
  assign and_dcpl_97 = mux_88_nl & (~ (fsm_output[2])) & (fsm_output[3]) & (fsm_output[5])
      & and_dcpl_93;
  assign mux_tmp_90 = MUX_s_1_2_2((fsm_output[4]), or_dcpl_22, and_254_cse);
  assign and_dcpl_99 = and_dcpl_45 & and_dcpl;
  assign and_dcpl_100 = and_dcpl_41 & (~ (fsm_output[4]));
  assign and_dcpl_102 = and_dcpl_100 & and_254_cse & and_dcpl_99;
  assign mux_tmp_100 = MUX_s_1_2_2(or_dcpl_22, or_38_cse, or_142_cse);
  assign and_dcpl_112 = (or_292_cse ^ (fsm_output[3])) & (~ (fsm_output[4])) & and_dcpl_32;
  assign mux_102_nl = MUX_s_1_2_2(nor_tmp_20, and_cse, fsm_output[1]);
  assign or_tmp_122 = (fsm_output[7:5]!=3'b000) | mux_102_nl;
  assign and_dcpl_113 = (fsm_output[1:0]==2'b01);
  assign or_152_nl = (fsm_output[4:0]!=5'b01010);
  assign or_151_nl = (fsm_output[4:0]!=5'b10101);
  assign mux_tmp_104 = MUX_s_1_2_2(or_152_nl, or_151_nl, fsm_output[5]);
  assign and_dcpl_116 = (~ mux_tmp_104) & and_dcpl_81;
  assign and_dcpl_118 = and_dcpl_42 & and_dcpl_113;
  assign and_dcpl_122 = and_dcpl_118 & and_dcpl_46;
  assign and_404_nl = (fsm_output[0]) & (fsm_output[4]);
  assign nor_nl = ~((fsm_output[0]) | (fsm_output[4]));
  assign mux_129_nl = MUX_s_1_2_2(and_404_nl, nor_nl, fsm_output[7]);
  assign and_dcpl_132 = mux_129_nl & and_dcpl_41 & (fsm_output[1]) & (fsm_output[5])
      & nor_215_cse;
  assign and_dcpl_134 = (~ (fsm_output[3])) & (fsm_output[6]);
  assign nor_102_nl = ~((~ (fsm_output[5])) | (fsm_output[0]) | (fsm_output[1]) |
      (fsm_output[4]) | (~ (fsm_output[2])));
  assign nor_103_nl = ~((fsm_output[5]) | (~ (fsm_output[0])) | (~ (fsm_output[1]))
      | (~ (fsm_output[4])) | (fsm_output[2]));
  assign not_tmp_132 = MUX_s_1_2_2(nor_102_nl, nor_103_nl, fsm_output[7]);
  assign and_dcpl_142 = and_dcpl_45 & (fsm_output[7]);
  assign and_dcpl_144 = nor_tmp_28 & and_dcpl_33;
  assign or_tmp_177 = and_254_cse | (fsm_output[2]);
  assign and_tmp_19 = (fsm_output[5]) & or_142_cse & (fsm_output[2]);
  assign or_tmp_184 = (fsm_output[4]) | (~ and_dcpl_55);
  assign or_211_nl = (fsm_output[4:2]!=3'b100);
  assign mux_157_nl = MUX_s_1_2_2(or_tmp_184, or_211_nl, fsm_output[7]);
  assign and_dcpl_152 = (~ mux_157_nl) & (~ (fsm_output[1])) & (fsm_output[0]) &
      (~ (fsm_output[5])) & and_dcpl_93;
  assign and_dcpl_154 = and_dcpl_42 & and_254_cse & and_dcpl_46;
  assign or_tmp_201 = (fsm_output[7]) | (~ (fsm_output[4]));
  assign and_dcpl_159 = and_dcpl_76 & (fsm_output[4]) & and_dcpl_33 & and_dcpl_46;
  assign or_dcpl_31 = (fsm_output[8:7]!=2'b00);
  assign or_dcpl_37 = (fsm_output[6:5]!=2'b01);
  assign or_dcpl_38 = or_dcpl_37 | or_dcpl_31;
  assign or_dcpl_40 = (fsm_output[3:2]!=2'b01);
  assign or_dcpl_41 = or_dcpl_40 | (~ (fsm_output[4]));
  assign nor_91_nl = ~((fsm_output[6]) | (~ (fsm_output[5])) | (fsm_output[0]) |
      (~ (fsm_output[3])));
  assign nor_92_nl = ~((~ (fsm_output[6])) | (fsm_output[5]) | (~ (fsm_output[0]))
      | (fsm_output[3]));
  assign mux_184_nl = MUX_s_1_2_2(nor_91_nl, nor_92_nl, fsm_output[7]);
  assign and_dcpl_163 = mux_184_nl & (~ (fsm_output[2])) & (fsm_output[4]) & and_dcpl_86;
  assign and_186_nl = (fsm_output[4:3]==2'b11) & or_342_cse;
  assign or_270_nl = (fsm_output[4:3]!=2'b00) | and_216_cse;
  assign mux_186_nl = MUX_s_1_2_2(and_186_nl, or_270_nl, fsm_output[7]);
  assign nand_41_nl = ~((fsm_output[5]) & mux_186_nl);
  assign and_280_nl = (fsm_output[7]) & (fsm_output[4]) & or_327_cse;
  assign or_359_nl = (fsm_output[7]) | (fsm_output[4]) | (fsm_output[3]) | and_254_cse
      | (fsm_output[2]);
  assign mux_185_nl = MUX_s_1_2_2(and_280_nl, or_359_nl, fsm_output[5]);
  assign mux_187_nl = MUX_s_1_2_2(nand_41_nl, mux_185_nl, fsm_output[6]);
  assign and_dcpl_164 = ~(mux_187_nl | (fsm_output[8]));
  assign and_dcpl_166 = and_dcpl_100 & and_dcpl_40 & and_dcpl_99;
  assign or_dcpl_48 = (fsm_output[1:0]!=2'b01);
  assign or_dcpl_59 = or_dcpl_40 | (fsm_output[4]);
  assign or_dcpl_62 = (fsm_output[8:7]!=2'b01);
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_43 & and_dcpl_39;
  assign VEC_LOOP_j_sva_11_0_mx0c1 = and_dcpl_118 & and_dcpl_39;
  assign mux_122_nl = MUX_s_1_2_2(or_dcpl_22, or_38_cse, and_254_cse);
  assign nor_107_nl = ~((fsm_output[7:5]!=3'b000) | mux_122_nl);
  assign modExp_result_sva_mx0c0 = MUX_s_1_2_2(nor_107_nl, or_tmp_122, fsm_output[8]);
  assign nl_STAGE_LOOP_acc_nl = (STAGE_LOOP_i_3_0_sva_2[3:1]) + 3'b011;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[2:0];
  assign STAGE_LOOP_acc_itm_2_1 = readslicef_3_1_2(STAGE_LOOP_acc_nl);
  assign and_70_nl = and_dcpl_55 & (~ (fsm_output[4])) & and_254_cse & and_dcpl_31
      & and_dcpl;
  assign or_366_nl = (~ (fsm_output[7])) | (~ (fsm_output[5])) | (fsm_output[0])
      | (fsm_output[1]) | (fsm_output[4]) | (~ (fsm_output[2]));
  assign or_367_nl = (fsm_output[7]) | (fsm_output[5]) | (~ (fsm_output[0])) | (~
      (fsm_output[1])) | (~ (fsm_output[4])) | (fsm_output[2]);
  assign mux_65_nl = MUX_s_1_2_2(or_366_nl, or_367_nl, fsm_output[8]);
  assign nor_175_nl = ~(mux_65_nl | (fsm_output[3]) | (fsm_output[6]));
  assign nor_136_nl = ~((~ (fsm_output[0])) | (fsm_output[1]) | (fsm_output[4]) |
      (fsm_output[3]));
  assign nor_137_nl = ~((fsm_output[0]) | (~((fsm_output[1]) & (fsm_output[4]) &
      (fsm_output[3]))));
  assign mux_66_nl = MUX_s_1_2_2(nor_136_nl, nor_137_nl, fsm_output[6]);
  assign and_75_nl = mux_66_nl & (fsm_output[2]) & (fsm_output[5]) & and_dcpl;
  assign vec_rsc_0_0_i_adra_d_pff = MUX1HOT_v_11_5_2(COMP_LOOP_acc_psp_sva_1, (z_out_3[12:2]),
      COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_10_cse_12_1_1_sva[11:1]), (COMP_LOOP_acc_1_cse_sva[11:1]),
      {and_dcpl_47 , COMP_LOOP_or_2_cse , and_70_nl , nor_175_nl , and_75_nl});
  assign vec_rsc_0_0_i_da_d_pff = vec_rsc_0_0_i_da_d_1;
  assign nor_133_nl = ~((fsm_output[7]) | (~ (fsm_output[8])) | (~ (fsm_output[0]))
      | (fsm_output[5]) | (~ (fsm_output[4])) | (fsm_output[3]) | (~ (fsm_output[1]))
      | (COMP_LOOP_acc_10_cse_12_1_1_sva[0]) | (fsm_output[6]));
  assign nor_135_nl = ~((fsm_output[3]) | (fsm_output[1]) | (COMP_LOOP_acc_10_cse_12_1_1_sva[0])
      | (fsm_output[6]));
  assign and_260_nl = (fsm_output[3]) & (fsm_output[1]) & (~ (COMP_LOOP_acc_1_cse_sva[0]))
      & (fsm_output[6]);
  assign mux_67_nl = MUX_s_1_2_2(nor_135_nl, and_260_nl, fsm_output[4]);
  assign nand_1_nl = ~((fsm_output[5]) & mux_67_nl);
  assign or_99_nl = (fsm_output[5]) | (fsm_output[4]) | (~ (fsm_output[3])) | (~
      (fsm_output[1])) | (VEC_LOOP_j_sva_11_0[0]) | (fsm_output[6]);
  assign mux_68_nl = MUX_s_1_2_2(nand_1_nl, or_99_nl, fsm_output[0]);
  assign nor_134_nl = ~((fsm_output[8:7]!=2'b01) | mux_68_nl);
  assign vec_rsc_0_0_i_wea_d_pff = MUX_s_1_2_2(nor_133_nl, nor_134_nl, fsm_output[2]);
  assign nor_130_nl = ~((fsm_output[6:5]!=2'b10) | (z_out_3[1]) | (~ (fsm_output[7])));
  assign nor_131_nl = ~((fsm_output[6]) | (VEC_LOOP_j_sva_11_0[0]) | (~ (fsm_output[5]))
      | (fsm_output[7]));
  assign mux_71_nl = MUX_s_1_2_2(nor_130_nl, nor_131_nl, fsm_output[2]);
  assign and_259_nl = (fsm_output[4]) & (fsm_output[1]) & mux_71_nl;
  assign or_107_nl = (~ (fsm_output[2])) | (fsm_output[6]) | (~ (fsm_output[5]))
      | (~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm) |
      (COMP_LOOP_acc_1_cse_sva[0]) | (~ (fsm_output[7]));
  assign or_105_nl = (fsm_output[2]) | (~ (fsm_output[6])) | (z_out_3[1]) | (~ (fsm_output[5]))
      | (fsm_output[7]);
  assign mux_70_nl = MUX_s_1_2_2(or_107_nl, or_105_nl, fsm_output[1]);
  assign nor_132_nl = ~((fsm_output[4]) | mux_70_nl);
  assign mux_72_nl = MUX_s_1_2_2(and_259_nl, nor_132_nl, fsm_output[0]);
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = mux_72_nl & and_dcpl_69;
  assign nor_127_nl = ~((fsm_output[7]) | (~ (fsm_output[8])) | (~ (fsm_output[0]))
      | (fsm_output[5]) | (~ (fsm_output[4])) | (fsm_output[3]) | (~ (fsm_output[1]))
      | (~ (COMP_LOOP_acc_10_cse_12_1_1_sva[0])) | (fsm_output[6]));
  assign nor_129_nl = ~((fsm_output[3]) | (fsm_output[1]) | (~ (COMP_LOOP_acc_10_cse_12_1_1_sva[0]))
      | (fsm_output[6]));
  assign and_258_nl = (fsm_output[3]) & (fsm_output[1]) & (COMP_LOOP_acc_1_cse_sva[0])
      & (fsm_output[6]);
  assign mux_73_nl = MUX_s_1_2_2(nor_129_nl, and_258_nl, fsm_output[4]);
  assign nand_25_nl = ~((fsm_output[5]) & mux_73_nl);
  assign or_113_nl = (fsm_output[5]) | (fsm_output[4]) | (~ (fsm_output[3])) | (~
      (fsm_output[1])) | (~ (VEC_LOOP_j_sva_11_0[0])) | (fsm_output[6]);
  assign mux_74_nl = MUX_s_1_2_2(nand_25_nl, or_113_nl, fsm_output[0]);
  assign nor_128_nl = ~((fsm_output[8:7]!=2'b01) | mux_74_nl);
  assign vec_rsc_0_1_i_wea_d_pff = MUX_s_1_2_2(nor_127_nl, nor_128_nl, fsm_output[2]);
  assign nor_124_nl = ~((fsm_output[6:5]!=2'b10) | (~((z_out_3[1]) & (fsm_output[7]))));
  assign nor_125_nl = ~((fsm_output[6]) | (~ (VEC_LOOP_j_sva_11_0[0])) | (~ (fsm_output[5]))
      | (fsm_output[7]));
  assign mux_77_nl = MUX_s_1_2_2(nor_124_nl, nor_125_nl, fsm_output[2]);
  assign and_257_nl = (fsm_output[4]) & (fsm_output[1]) & mux_77_nl;
  assign or_119_nl = (~((fsm_output[2]) & (~ (fsm_output[6])) & (fsm_output[5]) &
      COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm)) | (~((COMP_LOOP_acc_1_cse_sva[0])
      & (fsm_output[7])));
  assign or_117_nl = (fsm_output[2]) | (~ (fsm_output[6])) | (~ (z_out_3[1])) | (~
      (fsm_output[5])) | (fsm_output[7]);
  assign mux_76_nl = MUX_s_1_2_2(or_119_nl, or_117_nl, fsm_output[1]);
  assign nor_126_nl = ~((fsm_output[4]) | mux_76_nl);
  assign mux_78_nl = MUX_s_1_2_2(and_257_nl, nor_126_nl, fsm_output[0]);
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = mux_78_nl & and_dcpl_69;
  assign and_dcpl_197 = ~((fsm_output!=9'b000000001));
  assign and_dcpl_198 = (~ (fsm_output[8])) & (fsm_output[0]);
  assign and_dcpl_201 = (fsm_output[1]) & (~ (fsm_output[7]));
  assign and_dcpl_202 = ~((fsm_output[4]) | (fsm_output[2]));
  assign and_dcpl_205 = and_dcpl_202 & (~ (fsm_output[3])) & and_dcpl_201 & (fsm_output[6:5]==2'b11)
      & and_dcpl_198;
  assign and_dcpl_206 = ~((fsm_output[8]) | (fsm_output[0]));
  assign and_dcpl_212 = (fsm_output[4:2]==3'b101) & and_dcpl_201 & (fsm_output[6:5]==2'b01)
      & and_dcpl_206;
  assign and_dcpl_216 = and_dcpl_202 & (fsm_output[3]) & and_dcpl_201;
  assign and_dcpl_217 = and_dcpl_216 & and_dcpl_31 & and_dcpl_198;
  assign and_320_cse = (fsm_output[7:1]==7'b1101001) & and_dcpl_206;
  assign and_dcpl_226 = and_dcpl_216 & and_dcpl_31 & and_dcpl_206;
  assign and_dcpl_247 = (fsm_output[4:2]==3'b101);
  assign and_dcpl_256 = (fsm_output[4:2]==3'b000) & and_dcpl_201 & (fsm_output[6])
      & (fsm_output[5]) & (~ (fsm_output[8])) & (fsm_output[0]);
  assign and_dcpl_269 = and_dcpl_247 & (~ (fsm_output[1])) & (~ (fsm_output[7]))
      & (~ (fsm_output[6])) & (~ (fsm_output[5])) & (fsm_output[8]) & (fsm_output[0]);
  assign and_dcpl_284 = (fsm_output==9'b000111000);
  assign and_403_nl = (fsm_output[3]) & (fsm_output[7]);
  assign or_nl = (fsm_output[3]) | (fsm_output[7]);
  assign mux_tmp = MUX_s_1_2_2(and_403_nl, or_nl, fsm_output[4]);
  always @(posedge clk) begin
    if ( ~ not_tmp_64 ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( (and_dcpl_36 & and_dcpl_32) | STAGE_LOOP_i_3_0_sva_mx0c1 ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( ~ not_tmp_64 ) begin
      r_sva <= r_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= 1'b0;
      modExp_exp_1_0_1_sva <= 1'b0;
      modExp_exp_1_7_1_sva <= 1'b0;
      modExp_exp_1_1_1_sva <= 1'b0;
    end
    else begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= and_dcpl_43 & and_dcpl_31 & (fsm_output[8:7]==2'b10)
          & (~ STAGE_LOOP_acc_itm_2_1);
      modExp_exp_1_0_1_sva <= (COMP_LOOP_mux1h_16_nl & (~ and_dcpl_154)) | mux_176_nl
          | (fsm_output[8]);
      modExp_exp_1_7_1_sva <= COMP_LOOP_mux1h_26_nl & (~(and_dcpl_66 & and_dcpl_113
          & and_dcpl_65));
      modExp_exp_1_1_1_sva <= COMP_LOOP_mux1h_40_nl & (~(and_dcpl_35 & and_dcpl_40
          & and_dcpl_49));
    end
  end
  always @(posedge clk) begin
    modulo_result_rem_cmp_a <= MUX1HOT_v_64_12_2(z_out_5, modExp_while_if_mul_mut,
        modExp_while_mul_itm, COMP_LOOP_1_modExp_1_while_if_mul_mut, COMP_LOOP_1_modExp_1_while_mul_itm,
        COMP_LOOP_1_mul_mut, COMP_LOOP_1_acc_5_mut_mx0w7, COMP_LOOP_1_acc_5_mut,
        COMP_LOOP_1_acc_8_itm, COMP_LOOP_2_modExp_1_while_mul_mut, COMP_LOOP_2_modExp_1_while_if_mul_itm,
        COMP_LOOP_2_mul_mut, {modulo_result_or_nl , and_96_nl , and_98_nl , and_102_nl
        , and_105_nl , and_106_nl , and_dcpl_97 , nor_168_nl , mux_97_nl , and_122_nl
        , and_123_nl , and_126_nl});
    modulo_result_rem_cmp_b <= p_sva;
    operator_66_true_div_cmp_a <= MUX_v_65_2_2(z_out, ({operator_64_false_acc_mut_64
        , operator_64_false_acc_mut_63_0}), and_dcpl_112);
    operator_66_true_div_cmp_b_9_0 <= MUX_v_10_2_2(STAGE_LOOP_lshift_psp_sva_mx0w0,
        STAGE_LOOP_lshift_psp_sva, and_dcpl_112);
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(nor_113_nl, or_tmp_122, fsm_output[8]) ) begin
      STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( mux_221_nl & (~ (fsm_output[8])) ) begin
      operator_64_false_acc_mut_64 <= operator_64_false_mux1h_1_rgt[64];
    end
  end
  always @(posedge clk) begin
    if ( mux_224_nl & nor_215_cse ) begin
      operator_64_false_acc_mut_63_0 <= operator_64_false_mux1h_1_rgt[63:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_sva_11_0 <= 12'b000000000000;
    end
    else if ( and_dcpl_116 | VEC_LOOP_j_sva_11_0_mx0c1 ) begin
      VEC_LOOP_j_sva_11_0 <= MUX_v_12_2_2(12'b000000000000, (z_out_3[11:0]), VEC_LOOP_j_sva_11_0_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= 8'b00000000;
    end
    else if ( MUX_s_1_2_2(mux_226_nl, nor_210_nl, fsm_output[8]) ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= MUX_v_8_2_2(8'b00000000, (z_out_1[7:0]), nand_50_nl);
    end
  end
  always @(posedge clk) begin
    if ( (modExp_while_and_3 | modExp_while_and_5 | modExp_result_sva_mx0c0 | mux_127_nl)
        & (modExp_result_sva_mx0c0 | modExp_result_and_rgt | modExp_result_and_1_rgt)
        ) begin
      modExp_result_sva <= MUX1HOT_v_64_3_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
          modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w1, {modExp_result_sva_mx0c0
          , modExp_result_and_rgt , modExp_result_and_1_rgt});
    end
  end
  always @(posedge clk) begin
    if ( mux_141_nl | (fsm_output[8]) ) begin
      COMP_LOOP_1_acc_5_mut <= MUX1HOT_v_64_7_2(r_sva, modulo_result_rem_cmp_z, modulo_qr_sva_1_mx0w1,
          modExp_result_sva, vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, COMP_LOOP_1_acc_5_mut_mx0w7,
          {and_142_nl , COMP_LOOP_or_7_nl , COMP_LOOP_or_8_nl , and_dcpl_132 , and_154_nl
          , and_157_nl , and_dcpl_97});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_acc_8_itm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~((~(modExp_while_and_3 | modExp_while_and_5 | and_dcpl_116 | and_dcpl_132
        | and_dcpl_97)) | mux_156_nl) ) begin
      COMP_LOOP_1_acc_8_itm <= MUX1HOT_v_64_5_2(({1'b0 , operator_64_false_slc_modExp_exp_63_1_3}),
          64'b0000000000000000000000000000000000000000000000000000000000000001, modulo_result_rem_cmp_z,
          modulo_qr_sva_1_mx0w1, (z_out[63:0]), {and_dcpl_116 , and_dcpl_132 , COMP_LOOP_and_nl
          , COMP_LOOP_and_1_nl , and_dcpl_97});
    end
  end
  always @(posedge clk) begin
    if ( ~(mux_178_nl & and_dcpl_32) ) begin
      modExp_while_if_mul_mut <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_COMP_LOOP_1_modExp_1_while_sva <= 1'b0;
    end
    else if ( and_dcpl_79 | and_dcpl_159 | and_dcpl_68 ) begin
      exit_COMP_LOOP_1_modExp_1_while_sva <= MUX1HOT_s_1_3_2((~ (z_out_1[63])), (~
          z_out_4_8), (~ (readslicef_10_1_9(COMP_LOOP_1_acc_nl))), {and_dcpl_79 ,
          and_dcpl_159 , and_dcpl_68});
    end
  end
  always @(posedge clk) begin
    if ( ~(or_tmp_184 | or_142_cse | (fsm_output[6:5]!=2'b00) | or_dcpl_31) ) begin
      modExp_while_mul_itm <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_41 | (fsm_output[1:0]!=2'b10) | or_dcpl_38) ) begin
      COMP_LOOP_acc_psp_sva <= COMP_LOOP_acc_psp_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_47 | and_dcpl_52 | and_dcpl_102 ) begin
      COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm <= MUX1HOT_s_1_3_2((z_out_3[9]),
          (z_out_1[9]), z_out_4_8, {and_dcpl_47 , and_dcpl_52 , and_dcpl_102});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_1_cse_sva <= 12'b000000000000;
    end
    else if ( mux_183_nl | (fsm_output[8]) ) begin
      COMP_LOOP_acc_1_cse_sva <= z_out_1[11:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_5_1_sva_1 <= 1'b0;
    end
    else if ( ~ and_dcpl_164 ) begin
      modExp_exp_1_5_1_sva_1 <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[5]), modExp_exp_1_7_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[6]), {and_dcpl_154 , and_dcpl_163 , and_dcpl_166});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_0_1_sva_1 <= 1'b0;
    end
    else if ( mux_192_nl | (fsm_output[8]) ) begin
      modExp_exp_1_0_1_sva_1 <= MUX_s_1_2_2((COMP_LOOP_k_9_1_sva_7_0[0]), modExp_exp_1_1_1_sva,
          and_194_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_5_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_164 ) begin
      modExp_exp_1_5_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[4]), modExp_exp_1_5_1_sva_1,
          (COMP_LOOP_k_9_1_sva_7_0[5]), {and_dcpl_154 , and_dcpl_163 , and_dcpl_166});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_4_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_164 ) begin
      modExp_exp_1_4_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[3]), modExp_exp_1_5_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[4]), {and_dcpl_154 , and_dcpl_163 , and_dcpl_166});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_3_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_164 ) begin
      modExp_exp_1_3_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[2]), modExp_exp_1_4_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[3]), {and_dcpl_154 , and_dcpl_163 , and_dcpl_166});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_2_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_164 ) begin
      modExp_exp_1_2_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[1]), modExp_exp_1_3_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[2]), {and_dcpl_154 , and_dcpl_163 , and_dcpl_166});
    end
  end
  always @(posedge clk) begin
    if ( ~((~ mux_206_nl) & and_dcpl_30) ) begin
      COMP_LOOP_1_modExp_1_while_if_mul_mut <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( ~((fsm_output[4:2]!=3'b110) | or_dcpl_48 | or_dcpl_38) ) begin
      COMP_LOOP_1_modExp_1_while_mul_itm <= z_out_5;
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
    if ( ~(or_dcpl_59 | or_dcpl_48 | (fsm_output[6:5]!=2'b11) | or_dcpl_31) ) begin
      COMP_LOOP_1_mul_mut <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_59 | (fsm_output[1:0]!=2'b11) | or_dcpl_37 | or_dcpl_62) ) begin
      COMP_LOOP_2_modExp_1_while_mul_mut <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( ~(mux_208_nl & and_dcpl) ) begin
      COMP_LOOP_2_modExp_1_while_if_mul_itm <= z_out_5;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_41 | or_142_cse | (fsm_output[6:5]!=2'b10) | or_dcpl_62) ) begin
      COMP_LOOP_2_mul_mut <= z_out_5;
    end
  end
  assign nor_121_nl = ~((~ (fsm_output[5])) | (fsm_output[0]) | (~ (fsm_output[4]))
      | (~ (fsm_output[3])) | (fsm_output[2]));
  assign nor_122_nl = ~((~ (fsm_output[5])) | (~ (fsm_output[0])) | (fsm_output[4])
      | (fsm_output[3]) | (~ (fsm_output[2])));
  assign mux_79_nl = MUX_s_1_2_2(nor_121_nl, nor_122_nl, fsm_output[6]);
  assign nor_123_nl = ~((~ (fsm_output[6])) | (fsm_output[5]) | (fsm_output[0]) |
      (~ (fsm_output[4])) | (fsm_output[3]) | (~ (fsm_output[2])));
  assign mux_80_nl = MUX_s_1_2_2(mux_79_nl, nor_123_nl, fsm_output[7]);
  assign modulo_result_or_nl = and_dcpl_79 | (mux_80_nl & and_dcpl_86) | and_dcpl_102;
  assign and_96_nl = or_dcpl_22 & (~ (fsm_output[5])) & and_dcpl_81;
  assign and_98_nl = or_dcpl_24 & and_dcpl_46;
  assign or_133_nl = (fsm_output[5]) | mux_tmp_81;
  assign mux_83_nl = MUX_s_1_2_2(not_tmp_93, or_133_nl, fsm_output[6]);
  assign and_102_nl = (~ mux_83_nl) & and_dcpl_30;
  assign nor_120_nl = ~((fsm_output[4:1]!=4'b0000));
  assign mux_84_nl = MUX_s_1_2_2(mux_tmp_81, nor_120_nl, fsm_output[5]);
  assign and_105_nl = mux_84_nl & (fsm_output[8:6]==3'b001);
  assign mux_85_nl = MUX_s_1_2_2(and_dcpl_34, (fsm_output[3]), fsm_output[4]);
  assign mux_87_nl = MUX_s_1_2_2(mux_tmp_86, mux_85_nl, fsm_output[1]);
  assign and_106_nl = (~ mux_87_nl) & and_dcpl_49;
  assign mux_92_nl = MUX_s_1_2_2(nor_tmp_28, nor_tmp_20, and_254_cse);
  assign nand_42_nl = ~((fsm_output[6:5]==2'b11) & mux_92_nl);
  assign or_360_nl = (fsm_output[5]) | mux_tmp_90;
  assign mux_89_nl = MUX_s_1_2_2(or_dcpl_22, (~ mux_tmp_86), fsm_output[1]);
  assign nand_43_nl = ~((fsm_output[5]) & mux_89_nl);
  assign mux_91_nl = MUX_s_1_2_2(or_360_nl, nand_43_nl, fsm_output[6]);
  assign mux_93_nl = MUX_s_1_2_2(nand_42_nl, mux_91_nl, fsm_output[7]);
  assign nor_168_nl = ~(mux_93_nl | (fsm_output[8]));
  assign nor_115_nl = ~((fsm_output[4:2]!=3'b000));
  assign mux_95_nl = MUX_s_1_2_2(mux_tmp_90, nor_115_nl, fsm_output[5]);
  assign and_251_nl = (fsm_output[5:1]==5'b11111);
  assign mux_96_nl = MUX_s_1_2_2(mux_95_nl, and_251_nl, fsm_output[6]);
  assign and_250_nl = (fsm_output[7]) & mux_96_nl;
  assign mux_94_nl = MUX_s_1_2_2(and_cse, (fsm_output[4]), and_254_cse);
  assign nor_116_nl = ~((fsm_output[7:5]!=3'b000) | mux_94_nl);
  assign mux_97_nl = MUX_s_1_2_2(and_250_nl, nor_116_nl, fsm_output[8]);
  assign and_122_nl = (~ mux_tmp_86) & (fsm_output[8:5]==4'b0101);
  assign and_249_nl = (fsm_output[5:2]==4'b1111);
  assign mux_98_nl = MUX_s_1_2_2(and_cse, (fsm_output[4]), or_142_cse);
  assign nor_114_nl = ~((fsm_output[5]) | mux_98_nl);
  assign mux_99_nl = MUX_s_1_2_2(and_249_nl, nor_114_nl, fsm_output[6]);
  assign and_123_nl = mux_99_nl & and_dcpl;
  assign mux_101_nl = MUX_s_1_2_2(or_dcpl_24, mux_tmp_100, fsm_output[5]);
  assign and_126_nl = (~ mux_101_nl) & (fsm_output[8:6]==3'b011);
  assign COMP_LOOP_and_5_nl = (~ and_dcpl_122) & and_dcpl_116;
  assign mux_165_nl = MUX_s_1_2_2((~ or_tmp_37), (fsm_output[7]), or_342_cse);
  assign mux_166_nl = MUX_s_1_2_2((~ (fsm_output[6])), mux_165_nl, fsm_output[4]);
  assign or_219_nl = (~ (fsm_output[2])) | (~ (fsm_output[7])) | (fsm_output[6]);
  assign mux_163_nl = MUX_s_1_2_2(or_221_cse, or_219_nl, and_254_cse);
  assign mux_164_nl = MUX_s_1_2_2(mux_163_nl, or_tmp_37, fsm_output[4]);
  assign mux_167_nl = MUX_s_1_2_2(mux_166_nl, mux_164_nl, fsm_output[5]);
  assign or_218_nl = (~((~ (fsm_output[2])) | (fsm_output[7]))) | (fsm_output[6]);
  assign or_216_nl = (~ (fsm_output[2])) | (fsm_output[7]);
  assign mux_158_nl = MUX_s_1_2_2((~ (fsm_output[6])), (fsm_output[6]), or_216_nl);
  assign mux_159_nl = MUX_s_1_2_2(mux_158_nl, or_tmp_37, fsm_output[1]);
  assign mux_160_nl = MUX_s_1_2_2(or_218_nl, mux_159_nl, fsm_output[0]);
  assign mux_161_nl = MUX_s_1_2_2((~ mux_160_nl), (fsm_output[7]), fsm_output[4]);
  assign or_47_nl = nor_110_cse | (fsm_output[6]);
  assign mux_162_nl = MUX_s_1_2_2(mux_161_nl, or_47_nl, fsm_output[5]);
  assign mux_168_nl = MUX_s_1_2_2(mux_167_nl, mux_162_nl, fsm_output[3]);
  assign COMP_LOOP_mux1h_16_nl = MUX1HOT_s_1_4_2((operator_66_true_div_cmp_z[0]),
      (COMP_LOOP_1_acc_8_itm[0]), modExp_exp_1_0_1_sva_1, modExp_exp_1_0_1_sva, {COMP_LOOP_and_5_nl
      , and_dcpl_122 , and_dcpl_152 , (~ mux_168_nl)});
  assign or_230_nl = ((fsm_output[1]) & (fsm_output[7])) | (fsm_output[4]);
  assign and_242_nl = (fsm_output[0]) & (fsm_output[2]);
  assign mux_173_nl = MUX_s_1_2_2(and_217_cse, or_230_nl, and_242_nl);
  assign mux_174_nl = MUX_s_1_2_2(or_tmp_201, (~ mux_173_nl), fsm_output[5]);
  assign mux_171_nl = MUX_s_1_2_2(or_tmp_201, (fsm_output[7]), or_292_cse);
  assign mux_172_nl = MUX_s_1_2_2(mux_171_nl, nor_110_cse, fsm_output[5]);
  assign mux_175_nl = MUX_s_1_2_2(mux_174_nl, mux_172_nl, fsm_output[3]);
  assign and_230_nl = or_292_cse & (fsm_output[7]) & (fsm_output[4]);
  assign or_225_nl = (fsm_output[2]) | and_254_cse | (fsm_output[7]) | (fsm_output[4]);
  assign mux_169_nl = MUX_s_1_2_2(and_230_nl, or_225_nl, fsm_output[5]);
  assign or_223_nl = (fsm_output[5]) | and_217_cse;
  assign mux_170_nl = MUX_s_1_2_2(mux_169_nl, or_223_nl, fsm_output[3]);
  assign mux_176_nl = MUX_s_1_2_2(mux_175_nl, mux_170_nl, fsm_output[6]);
  assign COMP_LOOP_mux1h_26_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0[6]), modExp_exp_1_1_1_sva,
      modExp_exp_1_7_1_sva, (COMP_LOOP_k_9_1_sva_7_0[7]), {and_dcpl_154 , and_dcpl_159
      , and_dcpl_164 , and_dcpl_166});
  assign nand_46_nl = ~((~(or_327_cse & (fsm_output[7]))) & (fsm_output[6]));
  assign mux_198_nl = MUX_s_1_2_2((~ (fsm_output[6])), nand_46_nl, fsm_output[4]);
  assign nand_9_nl = ~((fsm_output[2]) & (fsm_output[0]) & (fsm_output[7]) & (~ (fsm_output[6])));
  assign mux_195_nl = MUX_s_1_2_2(or_221_cse, nand_9_nl, fsm_output[1]);
  assign mux_196_nl = MUX_s_1_2_2(mux_195_nl, or_tmp_37, fsm_output[3]);
  assign or_282_nl = (~((fsm_output[1]) | (fsm_output[2]) | (fsm_output[0]) | (fsm_output[7])))
      | (fsm_output[6]);
  assign mux_194_nl = MUX_s_1_2_2(or_tmp_37, or_282_nl, fsm_output[3]);
  assign mux_197_nl = MUX_s_1_2_2(mux_196_nl, mux_194_nl, fsm_output[4]);
  assign mux_199_nl = MUX_s_1_2_2(mux_198_nl, mux_197_nl, fsm_output[5]);
  assign nor_160_nl = ~(mux_199_nl | (fsm_output[8]));
  assign COMP_LOOP_mux1h_40_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0[7]), modExp_exp_1_2_1_sva,
      modExp_exp_1_1_1_sva, (COMP_LOOP_k_9_1_sva_7_0[1]), {and_dcpl_154 , and_dcpl_163
      , nor_160_nl , and_dcpl_166});
  assign nor_113_nl = ~((fsm_output[7:1]!=7'b0000000));
  assign or_388_nl = (~ (fsm_output[1])) | (~ (fsm_output[3])) | (fsm_output[7]);
  assign or_387_nl = (fsm_output[1]) | (fsm_output[3]) | (fsm_output[7]);
  assign mux_219_nl = MUX_s_1_2_2(or_388_nl, or_387_nl, fsm_output[0]);
  assign nor_216_nl = ~((fsm_output[2]) | (fsm_output[4]) | mux_219_nl);
  assign and_400_nl = ((fsm_output[1]) | (fsm_output[3])) & (fsm_output[7]);
  assign or_384_nl = (fsm_output[0]) | (fsm_output[3]) | (fsm_output[7]);
  assign mux_217_nl = MUX_s_1_2_2(and_400_nl, or_384_nl, fsm_output[4]);
  assign mux_218_nl = MUX_s_1_2_2(mux_tmp, mux_217_nl, fsm_output[2]);
  assign mux_220_nl = MUX_s_1_2_2(nor_216_nl, mux_218_nl, fsm_output[5]);
  assign and_401_nl = or_142_cse & (fsm_output[3]) & (fsm_output[7]);
  assign or_382_nl = ((fsm_output[1]) & (fsm_output[3])) | (fsm_output[7]);
  assign mux_215_nl = MUX_s_1_2_2(and_401_nl, or_382_nl, fsm_output[4]);
  assign mux_216_nl = MUX_s_1_2_2(mux_215_nl, mux_tmp, fsm_output[2]);
  assign nand_53_nl = ~((fsm_output[5]) & mux_216_nl);
  assign mux_221_nl = MUX_s_1_2_2(mux_220_nl, nand_53_nl, fsm_output[6]);
  assign nor_211_nl = ~((fsm_output[3]) | (~ (fsm_output[0])) | (fsm_output[2]) |
      (fsm_output[7]));
  assign nor_212_nl = ~((~ (fsm_output[3])) | (fsm_output[0]) | (fsm_output[2]) |
      (fsm_output[7]));
  assign mux_222_nl = MUX_s_1_2_2(nor_211_nl, nor_212_nl, fsm_output[1]);
  assign nor_213_nl = ~((~ (fsm_output[1])) | (fsm_output[3]) | (fsm_output[0]) |
      (~((fsm_output[2]) & (fsm_output[7]))));
  assign mux_223_nl = MUX_s_1_2_2(mux_222_nl, nor_213_nl, fsm_output[5]);
  assign nor_214_nl = ~((~ (fsm_output[5])) | (fsm_output[3]) | (~ (fsm_output[0]))
      | (~ (fsm_output[2])) | (fsm_output[7]));
  assign mux_224_nl = MUX_s_1_2_2(mux_223_nl, nor_214_nl, fsm_output[4]);
  assign or_165_nl = (fsm_output[5:0]!=6'b010101);
  assign mux_118_nl = MUX_s_1_2_2(mux_tmp_104, or_165_nl, fsm_output[8]);
  assign nand_50_nl = ~((~ mux_118_nl) & and_dcpl_80);
  assign or_400_nl = (fsm_output[7]) | (fsm_output[4]) | (~ (fsm_output[3]));
  assign or_398_nl = (~ (fsm_output[7])) | (~ (fsm_output[4])) | (fsm_output[3]);
  assign mux_225_nl = MUX_s_1_2_2(or_400_nl, or_398_nl, fsm_output[6]);
  assign nor_208_nl = ~((fsm_output[2:0]!=3'b010) | mux_225_nl);
  assign nor_209_nl = ~((~ (fsm_output[0])) | (fsm_output[1]) | (~ (fsm_output[2]))
      | (fsm_output[6]) | (fsm_output[7]) | (~ (fsm_output[4])) | (fsm_output[3]));
  assign mux_226_nl = MUX_s_1_2_2(nor_208_nl, nor_209_nl, fsm_output[5]);
  assign nor_210_nl = ~((fsm_output[7:0]!=8'b00010101));
  assign or_180_nl = (fsm_output[2]) | and_254_cse | (fsm_output[7:6]!=2'b00);
  assign mux_125_nl = MUX_s_1_2_2(or_tmp_35, or_180_nl, fsm_output[3]);
  assign or_336_nl = (fsm_output[4]) | mux_125_nl;
  assign or_337_nl = (fsm_output[4]) | (fsm_output[3]) | (fsm_output[2]) | (fsm_output[0])
      | (fsm_output[1]) | (fsm_output[6]) | (fsm_output[7]);
  assign mux_126_nl = MUX_s_1_2_2(or_336_nl, or_337_nl, fsm_output[5]);
  assign or_175_nl = (fsm_output[3]) | and_270_cse | (fsm_output[7:6]!=2'b00);
  assign mux_124_nl = MUX_s_1_2_2(or_tmp_35, or_175_nl, fsm_output[4]);
  assign nor_106_nl = ~((fsm_output[5]) | mux_124_nl);
  assign mux_127_nl = MUX_s_1_2_2(mux_126_nl, nor_106_nl, fsm_output[8]);
  assign and_142_nl = and_dcpl_77 & and_dcpl_40 & and_dcpl_32;
  assign COMP_LOOP_or_7_nl = ((~ (modulo_result_rem_cmp_z[63])) & and_145_m1c) |
      (and_dcpl_144 & and_dcpl_142 & (~ (fsm_output[8])) & (~ (modulo_result_rem_cmp_z[63])));
  assign COMP_LOOP_or_8_nl = ((modulo_result_rem_cmp_z[63]) & and_145_m1c) | (and_dcpl_144
      & and_dcpl_142 & (~ (fsm_output[8])) & (modulo_result_rem_cmp_z[63]));
  assign and_154_nl = not_tmp_132 & and_dcpl_134 & (~ (fsm_output[8])) & (~ (COMP_LOOP_acc_10_cse_12_1_1_sva[0]));
  assign and_157_nl = not_tmp_132 & and_dcpl_134 & (~ (fsm_output[8])) & (COMP_LOOP_acc_10_cse_12_1_1_sva[0]);
  assign or_197_nl = (~ (fsm_output[6])) | (fsm_output[2]) | (fsm_output[1]) | (~
      (fsm_output[7]));
  assign mux_139_nl = MUX_s_1_2_2((~ (fsm_output[7])), or_197_nl, fsm_output[4]);
  assign or_70_nl = (fsm_output[1]) | (~ (fsm_output[7]));
  assign mux_46_nl = MUX_s_1_2_2(not_tmp_45, or_70_nl, fsm_output[2]);
  assign mux_47_nl = MUX_s_1_2_2(mux_46_nl, (~ (fsm_output[7])), fsm_output[6]);
  assign or_71_nl = (fsm_output[4]) | mux_47_nl;
  assign mux_140_nl = MUX_s_1_2_2(mux_139_nl, or_71_nl, fsm_output[3]);
  assign or_333_nl = (fsm_output[6]) | (~((fsm_output[2]) & (fsm_output[0]) & (fsm_output[1])
      & (fsm_output[7])));
  assign nand_29_nl = ~((fsm_output[7:6]==2'b11));
  assign mux_135_nl = MUX_s_1_2_2(or_333_nl, nand_29_nl, fsm_output[4]);
  assign nand_30_nl = ~((fsm_output[6]) & or_292_cse & (fsm_output[7]));
  assign nor_144_nl = ~((fsm_output[0]) | (fsm_output[1]) | (fsm_output[7]));
  assign mux_43_nl = MUX_s_1_2_2(nor_144_nl, nor_tmp_11, fsm_output[2]);
  assign mux_42_nl = MUX_s_1_2_2(not_tmp_45, nor_tmp_11, fsm_output[2]);
  assign mux_44_nl = MUX_s_1_2_2((~ mux_43_nl), mux_42_nl, fsm_output[6]);
  assign mux_45_nl = MUX_s_1_2_2(nand_30_nl, mux_44_nl, fsm_output[4]);
  assign mux_136_nl = MUX_s_1_2_2(mux_135_nl, mux_45_nl, fsm_output[3]);
  assign mux_141_nl = MUX_s_1_2_2(mux_140_nl, mux_136_nl, fsm_output[5]);
  assign COMP_LOOP_and_nl = (~ modExp_while_and_5) & and_dcpl_152;
  assign COMP_LOOP_and_1_nl = modExp_while_and_5 & and_dcpl_152;
  assign mux_152_nl = MUX_s_1_2_2((~ (fsm_output[5])), and_tmp_19, fsm_output[4]);
  assign nor_96_nl = ~((fsm_output[5:4]!=2'b00) | or_tmp_177);
  assign mux_153_nl = MUX_s_1_2_2(mux_152_nl, nor_96_nl, fsm_output[3]);
  assign mux_150_nl = MUX_s_1_2_2(and_tmp_19, (fsm_output[5]), fsm_output[4]);
  assign or_331_nl = (fsm_output[5]) | (~((fsm_output[2:0]!=3'b101)));
  assign and_234_nl = (fsm_output[5]) & (~ or_tmp_177);
  assign mux_149_nl = MUX_s_1_2_2(or_331_nl, and_234_nl, fsm_output[4]);
  assign mux_151_nl = MUX_s_1_2_2(mux_150_nl, mux_149_nl, fsm_output[3]);
  assign mux_154_nl = MUX_s_1_2_2(mux_153_nl, mux_151_nl, fsm_output[6]);
  assign mux_147_nl = MUX_s_1_2_2((fsm_output[2]), (~ (fsm_output[2])), and_254_cse);
  assign nand_5_nl = ~((~((fsm_output[5:3]!=3'b100))) & mux_147_nl);
  assign or_204_nl = (fsm_output[5]) | (~((~((fsm_output[1:0]!=2'b01))) | (fsm_output[2])));
  assign mux_145_nl = MUX_s_1_2_2((~ (fsm_output[5])), or_204_nl, fsm_output[4]);
  assign or_202_nl = (~ (fsm_output[5])) | (fsm_output[1]) | (fsm_output[2]);
  assign mux_144_nl = MUX_s_1_2_2(or_202_nl, (fsm_output[5]), fsm_output[4]);
  assign mux_146_nl = MUX_s_1_2_2(mux_145_nl, mux_144_nl, fsm_output[3]);
  assign mux_148_nl = MUX_s_1_2_2(nand_5_nl, mux_146_nl, fsm_output[6]);
  assign mux_155_nl = MUX_s_1_2_2((~ mux_154_nl), mux_148_nl, fsm_output[7]);
  assign or_200_nl = (fsm_output[5]) | (fsm_output[1]) | (fsm_output[2]);
  assign mux_142_nl = MUX_s_1_2_2((fsm_output[5]), or_200_nl, fsm_output[4]);
  assign or_199_nl = (fsm_output[5:4]!=2'b00);
  assign mux_143_nl = MUX_s_1_2_2(mux_142_nl, or_199_nl, fsm_output[3]);
  assign nor_99_nl = ~((fsm_output[7:6]!=2'b00) | mux_143_nl);
  assign mux_156_nl = MUX_s_1_2_2(mux_155_nl, nor_99_nl, fsm_output[8]);
  assign mux_177_nl = MUX_s_1_2_2(and_dcpl_55, (~ and_dcpl_55), fsm_output[4]);
  assign mux_178_nl = MUX_s_1_2_2(or_dcpl_22, mux_177_nl, and_254_cse);
  assign nl_COMP_LOOP_1_acc_nl = ({(z_out_1[8:0]) , 1'b0}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + 10'b0000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[9:0];
  assign nor_164_nl = ~((fsm_output[6]) | ((fsm_output[5]) & mux_tmp_62));
  assign and_281_nl = (fsm_output[6:1]==6'b111111);
  assign mux_183_nl = MUX_s_1_2_2(nor_164_nl, and_281_nl, fsm_output[7]);
  assign nor_86_nl = ~((~ (fsm_output[5])) | (fsm_output[0]) | (~ (fsm_output[1]))
      | (fsm_output[4]));
  assign nor_87_nl = ~((fsm_output[5]) | (~ (fsm_output[0])) | (fsm_output[1]) |
      (~ (fsm_output[4])));
  assign mux_193_nl = MUX_s_1_2_2(nor_86_nl, nor_87_nl, fsm_output[7]);
  assign and_194_nl = mux_193_nl & and_dcpl_34 & and_dcpl_93;
  assign or_277_nl = (fsm_output[4]) | (or_142_cse & (fsm_output[2]));
  assign mux_190_nl = MUX_s_1_2_2((fsm_output[4]), or_277_nl, fsm_output[3]);
  assign and_191_nl = (fsm_output[4]) & or_342_cse;
  assign mux_189_nl = MUX_s_1_2_2(and_191_nl, (fsm_output[4]), fsm_output[3]);
  assign mux_191_nl = MUX_s_1_2_2(mux_190_nl, mux_189_nl, fsm_output[7]);
  assign nand_40_nl = ~((fsm_output[6]) & (~ mux_191_nl));
  assign nand_10_nl = ~((fsm_output[4:3]==2'b11));
  assign nor_89_nl = ~((fsm_output[4:3]!=2'b00) | and_216_cse);
  assign mux_188_nl = MUX_s_1_2_2(nand_10_nl, nor_89_nl, fsm_output[7]);
  assign or_358_nl = (fsm_output[6]) | mux_188_nl;
  assign mux_192_nl = MUX_s_1_2_2(nand_40_nl, or_358_nl, fsm_output[5]);
  assign or_297_nl = (fsm_output[5:4]!=2'b00) | and_dcpl_55;
  assign mux_206_nl = MUX_s_1_2_2(not_tmp_93, or_297_nl, fsm_output[6]);
  assign and_213_nl = (fsm_output[5]) & mux_tmp_100;
  assign nor_81_nl = ~((fsm_output[5:4]!=2'b00));
  assign mux_208_nl = MUX_s_1_2_2(and_213_nl, nor_81_nl, fsm_output[6]);
  assign COMP_LOOP_mux_13_nl = MUX_v_64_2_2(operator_64_false_acc_mut_63_0, p_sva,
      and_dcpl_197);
  assign nor_217_nl = ~((~ (fsm_output[1])) | (~ (fsm_output[4])) | (fsm_output[7]));
  assign nor_218_nl = ~((fsm_output[1]) | (fsm_output[4]) | (~ (fsm_output[7])));
  assign mux_229_nl = MUX_s_1_2_2(nor_217_nl, nor_218_nl, fsm_output[0]);
  assign COMP_LOOP_COMP_LOOP_nand_2_nl = ~(and_dcpl_197 & (~(mux_229_nl & (fsm_output[6])
      & (~ (fsm_output[2])) & (fsm_output[3]) & (fsm_output[5]) & (~ (fsm_output[8])))));
  assign COMP_LOOP_not_50_nl = ~ and_dcpl_197;
  assign COMP_LOOP_COMP_LOOP_nand_3_nl = ~(MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000000,
      vec_rsc_0_0_i_da_d_1, COMP_LOOP_not_50_nl));
  assign nl_acc_nl = conv_u2u_65_66({COMP_LOOP_mux_13_nl , COMP_LOOP_COMP_LOOP_nand_2_nl})
      + conv_s2u_65_66({COMP_LOOP_COMP_LOOP_nand_3_nl , 1'b1});
  assign acc_nl = nl_acc_nl[65:0];
  assign z_out = readslicef_66_65_1(acc_nl);
  assign COMP_LOOP_mux1h_71_nl = MUX1HOT_v_65_5_2(({56'b00000000000000000000000000000000000000000000000000000001
      , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))}), ({53'b00000000000000000000000000000000000000000000000000000
      , VEC_LOOP_j_sva_11_0}), ({2'b11 , (~ (operator_64_false_acc_mut_63_0[62:0]))}),
      ({57'b000000000000000000000000000000000000000000000000000000000 , COMP_LOOP_k_9_1_sva_7_0}),
      ({1'b1 , (~ (operator_66_true_div_cmp_z[63:0]))}), {and_dcpl_205 , and_dcpl_212
      , and_dcpl_217 , and_320_cse , and_dcpl_226});
  assign COMP_LOOP_or_17_nl = (~(and_dcpl_212 | and_dcpl_217 | and_320_cse | and_dcpl_226))
      | and_dcpl_205;
  assign COMP_LOOP_nor_4_nl = ~(and_dcpl_217 | and_320_cse | and_dcpl_226);
  assign COMP_LOOP_COMP_LOOP_and_1_nl = MUX_v_8_2_2(8'b00000000, COMP_LOOP_k_9_1_sva_7_0,
      COMP_LOOP_nor_4_nl);
  assign nl_acc_1_nl = ({COMP_LOOP_mux1h_71_nl , COMP_LOOP_or_17_nl}) + conv_u2u_10_66({COMP_LOOP_COMP_LOOP_and_1_nl
      , 2'b11});
  assign acc_1_nl = nl_acc_1_nl[65:0];
  assign z_out_1 = readslicef_66_65_1(acc_1_nl);
  assign operator_64_false_1_or_3_nl = and_dcpl_256 | and_320_cse | and_dcpl_269;
  assign operator_64_false_1_mux_11_nl = MUX_v_12_2_2(({3'b111 , (~ COMP_LOOP_k_9_1_sva_7_0)
      , 1'b1}), VEC_LOOP_j_sva_11_0, operator_64_false_1_or_3_nl);
  assign and_405_nl = and_dcpl_34 & (fsm_output[4]) & (fsm_output[1]) & (fsm_output[7])
      & (fsm_output[6]) & (~ (fsm_output[5])) & (~ (fsm_output[8])) & (~ (fsm_output[0]));
  assign nl_COMP_LOOP_acc_13_nl = STAGE_LOOP_lshift_psp_sva + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , and_405_nl});
  assign COMP_LOOP_acc_13_nl = nl_COMP_LOOP_acc_13_nl[9:0];
  assign and_406_nl = and_dcpl_247 & and_dcpl_201 & (fsm_output[6:5]==2'b01) & and_dcpl_206;
  assign operator_64_false_1_or_4_nl = and_dcpl_256 | and_320_cse;
  assign operator_64_false_1_mux1h_2_nl = MUX1HOT_v_10_3_2(10'b0000000001, COMP_LOOP_acc_13_nl,
      STAGE_LOOP_lshift_psp_sva, {and_406_nl , operator_64_false_1_or_4_nl , and_dcpl_269});
  assign nl_z_out_3 = conv_u2u_12_13(operator_64_false_1_mux_11_nl) + conv_u2u_10_13(operator_64_false_1_mux1h_2_nl);
  assign z_out_3 = nl_z_out_3[12:0];
  assign operator_64_false_1_mux_12_nl = MUX_s_1_2_2((~ modExp_exp_1_7_1_sva), (~
      modExp_exp_1_1_1_sva), and_dcpl_284);
  assign operator_64_false_1_mux_13_nl = MUX_s_1_2_2((~ modExp_exp_1_5_1_sva_1),
      (~ modExp_exp_1_7_1_sva), and_dcpl_284);
  assign operator_64_false_1_mux_14_nl = MUX_s_1_2_2((~ modExp_exp_1_5_1_sva), (~
      modExp_exp_1_5_1_sva_1), and_dcpl_284);
  assign operator_64_false_1_mux_15_nl = MUX_s_1_2_2((~ modExp_exp_1_4_1_sva), (~
      modExp_exp_1_5_1_sva), and_dcpl_284);
  assign operator_64_false_1_mux_16_nl = MUX_s_1_2_2((~ modExp_exp_1_3_1_sva), (~
      modExp_exp_1_4_1_sva), and_dcpl_284);
  assign operator_64_false_1_mux_17_nl = MUX_s_1_2_2((~ modExp_exp_1_2_1_sva), (~
      modExp_exp_1_3_1_sva), and_dcpl_284);
  assign operator_64_false_1_mux_18_nl = MUX_s_1_2_2((~ modExp_exp_1_1_1_sva), (~
      modExp_exp_1_2_1_sva), and_dcpl_284);
  assign nl_operator_64_false_1_acc_nl = ({1'b1 , operator_64_false_1_mux_12_nl ,
      operator_64_false_1_mux_13_nl , operator_64_false_1_mux_14_nl , operator_64_false_1_mux_15_nl
      , operator_64_false_1_mux_16_nl , operator_64_false_1_mux_17_nl , operator_64_false_1_mux_18_nl
      , (~ modExp_exp_1_0_1_sva_1)}) + 9'b000000001;
  assign operator_64_false_1_acc_nl = nl_operator_64_false_1_acc_nl[8:0];
  assign z_out_4_8 = readslicef_9_1_8(operator_64_false_1_acc_nl);
  assign and_407_nl = and_dcpl_202 & (fsm_output[3]) & (fsm_output[1]) & (~ (fsm_output[7]))
      & and_dcpl_31 & (~ (fsm_output[8])) & (fsm_output[0]);
  assign nor_221_nl = ~((fsm_output[5]) | (fsm_output[7]) | (fsm_output[1]) | (~
      (fsm_output[3])) | (~ (fsm_output[2])) | (fsm_output[4]));
  assign nor_222_nl = ~((fsm_output[4:1]!=4'b1100));
  assign nor_223_nl = ~((fsm_output[4:1]!=4'b0011));
  assign mux_231_nl = MUX_s_1_2_2(nor_222_nl, nor_223_nl, fsm_output[7]);
  assign and_409_nl = (fsm_output[5]) & mux_231_nl;
  assign mux_230_nl = MUX_s_1_2_2(nor_221_nl, and_409_nl, fsm_output[0]);
  assign and_408_nl = mux_230_nl & nor_215_cse;
  assign nor_225_nl = ~((~ (fsm_output[6])) | (~ (fsm_output[7])) | (fsm_output[3])
      | nand_18_cse);
  assign or_404_nl = (fsm_output[4:2]!=3'b110);
  assign or_405_nl = (fsm_output[4:2]!=3'b010);
  assign mux_234_nl = MUX_s_1_2_2(or_404_nl, or_405_nl, fsm_output[7]);
  assign nor_226_nl = ~((fsm_output[6]) | mux_234_nl);
  assign mux_233_nl = MUX_s_1_2_2(nor_225_nl, nor_226_nl, fsm_output[5]);
  assign nor_227_nl = ~((fsm_output[7:2]!=6'b011001));
  assign mux_232_nl = MUX_s_1_2_2(mux_233_nl, nor_227_nl, fsm_output[0]);
  assign and_410_nl = mux_232_nl & and_dcpl_86;
  assign modExp_while_if_mux1h_2_nl = MUX1HOT_v_64_3_2(modExp_result_sva, COMP_LOOP_1_acc_5_mut,
      COMP_LOOP_1_acc_8_itm, {and_407_nl , and_408_nl , and_410_nl});
  assign nl_z_out_5 = $signed(conv_u2s_64_65(modExp_while_if_mux1h_2_nl)) * $signed(COMP_LOOP_1_acc_5_mut);
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


  function automatic [63:0] MUX1HOT_v_64_12_2;
    input [63:0] input_11;
    input [63:0] input_10;
    input [63:0] input_9;
    input [63:0] input_8;
    input [63:0] input_7;
    input [63:0] input_6;
    input [63:0] input_5;
    input [63:0] input_4;
    input [63:0] input_3;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [11:0] sel;
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
    result = result | ( input_9 & {64{sel[9]}});
    result = result | ( input_10 & {64{sel[10]}});
    result = result | ( input_11 & {64{sel[11]}});
    MUX1HOT_v_64_12_2 = result;
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


  function automatic [64:0] MUX1HOT_v_65_5_2;
    input [64:0] input_4;
    input [64:0] input_3;
    input [64:0] input_2;
    input [64:0] input_1;
    input [64:0] input_0;
    input [4:0] sel;
    reg [64:0] result;
  begin
    result = input_0 & {65{sel[0]}};
    result = result | ( input_1 & {65{sel[1]}});
    result = result | ( input_2 & {65{sel[2]}});
    result = result | ( input_3 & {65{sel[3]}});
    result = result | ( input_4 & {65{sel[4]}});
    MUX1HOT_v_65_5_2 = result;
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


  function automatic [0:0] readslicef_9_1_8;
    input [8:0] vector;
    reg [8:0] tmp;
  begin
    tmp = vector >> 8;
    readslicef_9_1_8 = tmp[0:0];
  end
  endfunction


  function automatic [65:0] conv_s2u_65_66 ;
    input [64:0]  vector ;
  begin
    conv_s2u_65_66 = {vector[64], vector};
  end
  endfunction


  function automatic [64:0] conv_u2s_64_65 ;
    input [63:0]  vector ;
  begin
    conv_u2s_64_65 =  {1'b0, vector};
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


  function automatic [12:0] conv_u2u_10_13 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_13 = {{3{1'b0}}, vector};
  end
  endfunction


  function automatic [65:0] conv_u2u_10_66 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_66 = {{56{1'b0}}, vector};
  end
  endfunction


  function automatic [12:0] conv_u2u_12_13 ;
    input [11:0]  vector ;
  begin
    conv_u2u_12_13 = {1'b0, vector};
  end
  endfunction


  function automatic [65:0] conv_u2u_65_66 ;
    input [64:0]  vector ;
  begin
    conv_u2u_65_66 = {1'b0, vector};
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



