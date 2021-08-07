
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
//  Generated date: Mon May 17 21:47:52 2021
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
  clk, rst, fsm_output, STAGE_LOOP_C_10_tr0, modExp_while_C_47_tr0, COMP_LOOP_C_1_tr0,
      COMP_LOOP_1_modExp_1_while_C_47_tr0, COMP_LOOP_C_76_tr0, COMP_LOOP_2_modExp_1_while_C_47_tr0,
      COMP_LOOP_C_152_tr0, VEC_LOOP_C_0_tr0, STAGE_LOOP_C_11_tr0
);
  input clk;
  input rst;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
  input STAGE_LOOP_C_10_tr0;
  input modExp_while_C_47_tr0;
  input COMP_LOOP_C_1_tr0;
  input COMP_LOOP_1_modExp_1_while_C_47_tr0;
  input COMP_LOOP_C_76_tr0;
  input COMP_LOOP_2_modExp_1_while_C_47_tr0;
  input COMP_LOOP_C_152_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_11_tr0;


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
    STAGE_LOOP_C_10 = 9'd11,
    modExp_while_C_0 = 9'd12,
    modExp_while_C_1 = 9'd13,
    modExp_while_C_2 = 9'd14,
    modExp_while_C_3 = 9'd15,
    modExp_while_C_4 = 9'd16,
    modExp_while_C_5 = 9'd17,
    modExp_while_C_6 = 9'd18,
    modExp_while_C_7 = 9'd19,
    modExp_while_C_8 = 9'd20,
    modExp_while_C_9 = 9'd21,
    modExp_while_C_10 = 9'd22,
    modExp_while_C_11 = 9'd23,
    modExp_while_C_12 = 9'd24,
    modExp_while_C_13 = 9'd25,
    modExp_while_C_14 = 9'd26,
    modExp_while_C_15 = 9'd27,
    modExp_while_C_16 = 9'd28,
    modExp_while_C_17 = 9'd29,
    modExp_while_C_18 = 9'd30,
    modExp_while_C_19 = 9'd31,
    modExp_while_C_20 = 9'd32,
    modExp_while_C_21 = 9'd33,
    modExp_while_C_22 = 9'd34,
    modExp_while_C_23 = 9'd35,
    modExp_while_C_24 = 9'd36,
    modExp_while_C_25 = 9'd37,
    modExp_while_C_26 = 9'd38,
    modExp_while_C_27 = 9'd39,
    modExp_while_C_28 = 9'd40,
    modExp_while_C_29 = 9'd41,
    modExp_while_C_30 = 9'd42,
    modExp_while_C_31 = 9'd43,
    modExp_while_C_32 = 9'd44,
    modExp_while_C_33 = 9'd45,
    modExp_while_C_34 = 9'd46,
    modExp_while_C_35 = 9'd47,
    modExp_while_C_36 = 9'd48,
    modExp_while_C_37 = 9'd49,
    modExp_while_C_38 = 9'd50,
    modExp_while_C_39 = 9'd51,
    modExp_while_C_40 = 9'd52,
    modExp_while_C_41 = 9'd53,
    modExp_while_C_42 = 9'd54,
    modExp_while_C_43 = 9'd55,
    modExp_while_C_44 = 9'd56,
    modExp_while_C_45 = 9'd57,
    modExp_while_C_46 = 9'd58,
    modExp_while_C_47 = 9'd59,
    COMP_LOOP_C_0 = 9'd60,
    COMP_LOOP_C_1 = 9'd61,
    COMP_LOOP_1_modExp_1_while_C_0 = 9'd62,
    COMP_LOOP_1_modExp_1_while_C_1 = 9'd63,
    COMP_LOOP_1_modExp_1_while_C_2 = 9'd64,
    COMP_LOOP_1_modExp_1_while_C_3 = 9'd65,
    COMP_LOOP_1_modExp_1_while_C_4 = 9'd66,
    COMP_LOOP_1_modExp_1_while_C_5 = 9'd67,
    COMP_LOOP_1_modExp_1_while_C_6 = 9'd68,
    COMP_LOOP_1_modExp_1_while_C_7 = 9'd69,
    COMP_LOOP_1_modExp_1_while_C_8 = 9'd70,
    COMP_LOOP_1_modExp_1_while_C_9 = 9'd71,
    COMP_LOOP_1_modExp_1_while_C_10 = 9'd72,
    COMP_LOOP_1_modExp_1_while_C_11 = 9'd73,
    COMP_LOOP_1_modExp_1_while_C_12 = 9'd74,
    COMP_LOOP_1_modExp_1_while_C_13 = 9'd75,
    COMP_LOOP_1_modExp_1_while_C_14 = 9'd76,
    COMP_LOOP_1_modExp_1_while_C_15 = 9'd77,
    COMP_LOOP_1_modExp_1_while_C_16 = 9'd78,
    COMP_LOOP_1_modExp_1_while_C_17 = 9'd79,
    COMP_LOOP_1_modExp_1_while_C_18 = 9'd80,
    COMP_LOOP_1_modExp_1_while_C_19 = 9'd81,
    COMP_LOOP_1_modExp_1_while_C_20 = 9'd82,
    COMP_LOOP_1_modExp_1_while_C_21 = 9'd83,
    COMP_LOOP_1_modExp_1_while_C_22 = 9'd84,
    COMP_LOOP_1_modExp_1_while_C_23 = 9'd85,
    COMP_LOOP_1_modExp_1_while_C_24 = 9'd86,
    COMP_LOOP_1_modExp_1_while_C_25 = 9'd87,
    COMP_LOOP_1_modExp_1_while_C_26 = 9'd88,
    COMP_LOOP_1_modExp_1_while_C_27 = 9'd89,
    COMP_LOOP_1_modExp_1_while_C_28 = 9'd90,
    COMP_LOOP_1_modExp_1_while_C_29 = 9'd91,
    COMP_LOOP_1_modExp_1_while_C_30 = 9'd92,
    COMP_LOOP_1_modExp_1_while_C_31 = 9'd93,
    COMP_LOOP_1_modExp_1_while_C_32 = 9'd94,
    COMP_LOOP_1_modExp_1_while_C_33 = 9'd95,
    COMP_LOOP_1_modExp_1_while_C_34 = 9'd96,
    COMP_LOOP_1_modExp_1_while_C_35 = 9'd97,
    COMP_LOOP_1_modExp_1_while_C_36 = 9'd98,
    COMP_LOOP_1_modExp_1_while_C_37 = 9'd99,
    COMP_LOOP_1_modExp_1_while_C_38 = 9'd100,
    COMP_LOOP_1_modExp_1_while_C_39 = 9'd101,
    COMP_LOOP_1_modExp_1_while_C_40 = 9'd102,
    COMP_LOOP_1_modExp_1_while_C_41 = 9'd103,
    COMP_LOOP_1_modExp_1_while_C_42 = 9'd104,
    COMP_LOOP_1_modExp_1_while_C_43 = 9'd105,
    COMP_LOOP_1_modExp_1_while_C_44 = 9'd106,
    COMP_LOOP_1_modExp_1_while_C_45 = 9'd107,
    COMP_LOOP_1_modExp_1_while_C_46 = 9'd108,
    COMP_LOOP_1_modExp_1_while_C_47 = 9'd109,
    COMP_LOOP_C_2 = 9'd110,
    COMP_LOOP_C_3 = 9'd111,
    COMP_LOOP_C_4 = 9'd112,
    COMP_LOOP_C_5 = 9'd113,
    COMP_LOOP_C_6 = 9'd114,
    COMP_LOOP_C_7 = 9'd115,
    COMP_LOOP_C_8 = 9'd116,
    COMP_LOOP_C_9 = 9'd117,
    COMP_LOOP_C_10 = 9'd118,
    COMP_LOOP_C_11 = 9'd119,
    COMP_LOOP_C_12 = 9'd120,
    COMP_LOOP_C_13 = 9'd121,
    COMP_LOOP_C_14 = 9'd122,
    COMP_LOOP_C_15 = 9'd123,
    COMP_LOOP_C_16 = 9'd124,
    COMP_LOOP_C_17 = 9'd125,
    COMP_LOOP_C_18 = 9'd126,
    COMP_LOOP_C_19 = 9'd127,
    COMP_LOOP_C_20 = 9'd128,
    COMP_LOOP_C_21 = 9'd129,
    COMP_LOOP_C_22 = 9'd130,
    COMP_LOOP_C_23 = 9'd131,
    COMP_LOOP_C_24 = 9'd132,
    COMP_LOOP_C_25 = 9'd133,
    COMP_LOOP_C_26 = 9'd134,
    COMP_LOOP_C_27 = 9'd135,
    COMP_LOOP_C_28 = 9'd136,
    COMP_LOOP_C_29 = 9'd137,
    COMP_LOOP_C_30 = 9'd138,
    COMP_LOOP_C_31 = 9'd139,
    COMP_LOOP_C_32 = 9'd140,
    COMP_LOOP_C_33 = 9'd141,
    COMP_LOOP_C_34 = 9'd142,
    COMP_LOOP_C_35 = 9'd143,
    COMP_LOOP_C_36 = 9'd144,
    COMP_LOOP_C_37 = 9'd145,
    COMP_LOOP_C_38 = 9'd146,
    COMP_LOOP_C_39 = 9'd147,
    COMP_LOOP_C_40 = 9'd148,
    COMP_LOOP_C_41 = 9'd149,
    COMP_LOOP_C_42 = 9'd150,
    COMP_LOOP_C_43 = 9'd151,
    COMP_LOOP_C_44 = 9'd152,
    COMP_LOOP_C_45 = 9'd153,
    COMP_LOOP_C_46 = 9'd154,
    COMP_LOOP_C_47 = 9'd155,
    COMP_LOOP_C_48 = 9'd156,
    COMP_LOOP_C_49 = 9'd157,
    COMP_LOOP_C_50 = 9'd158,
    COMP_LOOP_C_51 = 9'd159,
    COMP_LOOP_C_52 = 9'd160,
    COMP_LOOP_C_53 = 9'd161,
    COMP_LOOP_C_54 = 9'd162,
    COMP_LOOP_C_55 = 9'd163,
    COMP_LOOP_C_56 = 9'd164,
    COMP_LOOP_C_57 = 9'd165,
    COMP_LOOP_C_58 = 9'd166,
    COMP_LOOP_C_59 = 9'd167,
    COMP_LOOP_C_60 = 9'd168,
    COMP_LOOP_C_61 = 9'd169,
    COMP_LOOP_C_62 = 9'd170,
    COMP_LOOP_C_63 = 9'd171,
    COMP_LOOP_C_64 = 9'd172,
    COMP_LOOP_C_65 = 9'd173,
    COMP_LOOP_C_66 = 9'd174,
    COMP_LOOP_C_67 = 9'd175,
    COMP_LOOP_C_68 = 9'd176,
    COMP_LOOP_C_69 = 9'd177,
    COMP_LOOP_C_70 = 9'd178,
    COMP_LOOP_C_71 = 9'd179,
    COMP_LOOP_C_72 = 9'd180,
    COMP_LOOP_C_73 = 9'd181,
    COMP_LOOP_C_74 = 9'd182,
    COMP_LOOP_C_75 = 9'd183,
    COMP_LOOP_C_76 = 9'd184,
    COMP_LOOP_C_77 = 9'd185,
    COMP_LOOP_2_modExp_1_while_C_0 = 9'd186,
    COMP_LOOP_2_modExp_1_while_C_1 = 9'd187,
    COMP_LOOP_2_modExp_1_while_C_2 = 9'd188,
    COMP_LOOP_2_modExp_1_while_C_3 = 9'd189,
    COMP_LOOP_2_modExp_1_while_C_4 = 9'd190,
    COMP_LOOP_2_modExp_1_while_C_5 = 9'd191,
    COMP_LOOP_2_modExp_1_while_C_6 = 9'd192,
    COMP_LOOP_2_modExp_1_while_C_7 = 9'd193,
    COMP_LOOP_2_modExp_1_while_C_8 = 9'd194,
    COMP_LOOP_2_modExp_1_while_C_9 = 9'd195,
    COMP_LOOP_2_modExp_1_while_C_10 = 9'd196,
    COMP_LOOP_2_modExp_1_while_C_11 = 9'd197,
    COMP_LOOP_2_modExp_1_while_C_12 = 9'd198,
    COMP_LOOP_2_modExp_1_while_C_13 = 9'd199,
    COMP_LOOP_2_modExp_1_while_C_14 = 9'd200,
    COMP_LOOP_2_modExp_1_while_C_15 = 9'd201,
    COMP_LOOP_2_modExp_1_while_C_16 = 9'd202,
    COMP_LOOP_2_modExp_1_while_C_17 = 9'd203,
    COMP_LOOP_2_modExp_1_while_C_18 = 9'd204,
    COMP_LOOP_2_modExp_1_while_C_19 = 9'd205,
    COMP_LOOP_2_modExp_1_while_C_20 = 9'd206,
    COMP_LOOP_2_modExp_1_while_C_21 = 9'd207,
    COMP_LOOP_2_modExp_1_while_C_22 = 9'd208,
    COMP_LOOP_2_modExp_1_while_C_23 = 9'd209,
    COMP_LOOP_2_modExp_1_while_C_24 = 9'd210,
    COMP_LOOP_2_modExp_1_while_C_25 = 9'd211,
    COMP_LOOP_2_modExp_1_while_C_26 = 9'd212,
    COMP_LOOP_2_modExp_1_while_C_27 = 9'd213,
    COMP_LOOP_2_modExp_1_while_C_28 = 9'd214,
    COMP_LOOP_2_modExp_1_while_C_29 = 9'd215,
    COMP_LOOP_2_modExp_1_while_C_30 = 9'd216,
    COMP_LOOP_2_modExp_1_while_C_31 = 9'd217,
    COMP_LOOP_2_modExp_1_while_C_32 = 9'd218,
    COMP_LOOP_2_modExp_1_while_C_33 = 9'd219,
    COMP_LOOP_2_modExp_1_while_C_34 = 9'd220,
    COMP_LOOP_2_modExp_1_while_C_35 = 9'd221,
    COMP_LOOP_2_modExp_1_while_C_36 = 9'd222,
    COMP_LOOP_2_modExp_1_while_C_37 = 9'd223,
    COMP_LOOP_2_modExp_1_while_C_38 = 9'd224,
    COMP_LOOP_2_modExp_1_while_C_39 = 9'd225,
    COMP_LOOP_2_modExp_1_while_C_40 = 9'd226,
    COMP_LOOP_2_modExp_1_while_C_41 = 9'd227,
    COMP_LOOP_2_modExp_1_while_C_42 = 9'd228,
    COMP_LOOP_2_modExp_1_while_C_43 = 9'd229,
    COMP_LOOP_2_modExp_1_while_C_44 = 9'd230,
    COMP_LOOP_2_modExp_1_while_C_45 = 9'd231,
    COMP_LOOP_2_modExp_1_while_C_46 = 9'd232,
    COMP_LOOP_2_modExp_1_while_C_47 = 9'd233,
    COMP_LOOP_C_78 = 9'd234,
    COMP_LOOP_C_79 = 9'd235,
    COMP_LOOP_C_80 = 9'd236,
    COMP_LOOP_C_81 = 9'd237,
    COMP_LOOP_C_82 = 9'd238,
    COMP_LOOP_C_83 = 9'd239,
    COMP_LOOP_C_84 = 9'd240,
    COMP_LOOP_C_85 = 9'd241,
    COMP_LOOP_C_86 = 9'd242,
    COMP_LOOP_C_87 = 9'd243,
    COMP_LOOP_C_88 = 9'd244,
    COMP_LOOP_C_89 = 9'd245,
    COMP_LOOP_C_90 = 9'd246,
    COMP_LOOP_C_91 = 9'd247,
    COMP_LOOP_C_92 = 9'd248,
    COMP_LOOP_C_93 = 9'd249,
    COMP_LOOP_C_94 = 9'd250,
    COMP_LOOP_C_95 = 9'd251,
    COMP_LOOP_C_96 = 9'd252,
    COMP_LOOP_C_97 = 9'd253,
    COMP_LOOP_C_98 = 9'd254,
    COMP_LOOP_C_99 = 9'd255,
    COMP_LOOP_C_100 = 9'd256,
    COMP_LOOP_C_101 = 9'd257,
    COMP_LOOP_C_102 = 9'd258,
    COMP_LOOP_C_103 = 9'd259,
    COMP_LOOP_C_104 = 9'd260,
    COMP_LOOP_C_105 = 9'd261,
    COMP_LOOP_C_106 = 9'd262,
    COMP_LOOP_C_107 = 9'd263,
    COMP_LOOP_C_108 = 9'd264,
    COMP_LOOP_C_109 = 9'd265,
    COMP_LOOP_C_110 = 9'd266,
    COMP_LOOP_C_111 = 9'd267,
    COMP_LOOP_C_112 = 9'd268,
    COMP_LOOP_C_113 = 9'd269,
    COMP_LOOP_C_114 = 9'd270,
    COMP_LOOP_C_115 = 9'd271,
    COMP_LOOP_C_116 = 9'd272,
    COMP_LOOP_C_117 = 9'd273,
    COMP_LOOP_C_118 = 9'd274,
    COMP_LOOP_C_119 = 9'd275,
    COMP_LOOP_C_120 = 9'd276,
    COMP_LOOP_C_121 = 9'd277,
    COMP_LOOP_C_122 = 9'd278,
    COMP_LOOP_C_123 = 9'd279,
    COMP_LOOP_C_124 = 9'd280,
    COMP_LOOP_C_125 = 9'd281,
    COMP_LOOP_C_126 = 9'd282,
    COMP_LOOP_C_127 = 9'd283,
    COMP_LOOP_C_128 = 9'd284,
    COMP_LOOP_C_129 = 9'd285,
    COMP_LOOP_C_130 = 9'd286,
    COMP_LOOP_C_131 = 9'd287,
    COMP_LOOP_C_132 = 9'd288,
    COMP_LOOP_C_133 = 9'd289,
    COMP_LOOP_C_134 = 9'd290,
    COMP_LOOP_C_135 = 9'd291,
    COMP_LOOP_C_136 = 9'd292,
    COMP_LOOP_C_137 = 9'd293,
    COMP_LOOP_C_138 = 9'd294,
    COMP_LOOP_C_139 = 9'd295,
    COMP_LOOP_C_140 = 9'd296,
    COMP_LOOP_C_141 = 9'd297,
    COMP_LOOP_C_142 = 9'd298,
    COMP_LOOP_C_143 = 9'd299,
    COMP_LOOP_C_144 = 9'd300,
    COMP_LOOP_C_145 = 9'd301,
    COMP_LOOP_C_146 = 9'd302,
    COMP_LOOP_C_147 = 9'd303,
    COMP_LOOP_C_148 = 9'd304,
    COMP_LOOP_C_149 = 9'd305,
    COMP_LOOP_C_150 = 9'd306,
    COMP_LOOP_C_151 = 9'd307,
    COMP_LOOP_C_152 = 9'd308,
    VEC_LOOP_C_0 = 9'd309,
    STAGE_LOOP_C_11 = 9'd310,
    main_C_1 = 9'd311;

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
        state_var_NS = STAGE_LOOP_C_10;
      end
      STAGE_LOOP_C_10 : begin
        fsm_output = 9'b000001011;
        if ( STAGE_LOOP_C_10_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      modExp_while_C_0 : begin
        fsm_output = 9'b000001100;
        state_var_NS = modExp_while_C_1;
      end
      modExp_while_C_1 : begin
        fsm_output = 9'b000001101;
        state_var_NS = modExp_while_C_2;
      end
      modExp_while_C_2 : begin
        fsm_output = 9'b000001110;
        state_var_NS = modExp_while_C_3;
      end
      modExp_while_C_3 : begin
        fsm_output = 9'b000001111;
        state_var_NS = modExp_while_C_4;
      end
      modExp_while_C_4 : begin
        fsm_output = 9'b000010000;
        state_var_NS = modExp_while_C_5;
      end
      modExp_while_C_5 : begin
        fsm_output = 9'b000010001;
        state_var_NS = modExp_while_C_6;
      end
      modExp_while_C_6 : begin
        fsm_output = 9'b000010010;
        state_var_NS = modExp_while_C_7;
      end
      modExp_while_C_7 : begin
        fsm_output = 9'b000010011;
        state_var_NS = modExp_while_C_8;
      end
      modExp_while_C_8 : begin
        fsm_output = 9'b000010100;
        state_var_NS = modExp_while_C_9;
      end
      modExp_while_C_9 : begin
        fsm_output = 9'b000010101;
        state_var_NS = modExp_while_C_10;
      end
      modExp_while_C_10 : begin
        fsm_output = 9'b000010110;
        state_var_NS = modExp_while_C_11;
      end
      modExp_while_C_11 : begin
        fsm_output = 9'b000010111;
        state_var_NS = modExp_while_C_12;
      end
      modExp_while_C_12 : begin
        fsm_output = 9'b000011000;
        state_var_NS = modExp_while_C_13;
      end
      modExp_while_C_13 : begin
        fsm_output = 9'b000011001;
        state_var_NS = modExp_while_C_14;
      end
      modExp_while_C_14 : begin
        fsm_output = 9'b000011010;
        state_var_NS = modExp_while_C_15;
      end
      modExp_while_C_15 : begin
        fsm_output = 9'b000011011;
        state_var_NS = modExp_while_C_16;
      end
      modExp_while_C_16 : begin
        fsm_output = 9'b000011100;
        state_var_NS = modExp_while_C_17;
      end
      modExp_while_C_17 : begin
        fsm_output = 9'b000011101;
        state_var_NS = modExp_while_C_18;
      end
      modExp_while_C_18 : begin
        fsm_output = 9'b000011110;
        state_var_NS = modExp_while_C_19;
      end
      modExp_while_C_19 : begin
        fsm_output = 9'b000011111;
        state_var_NS = modExp_while_C_20;
      end
      modExp_while_C_20 : begin
        fsm_output = 9'b000100000;
        state_var_NS = modExp_while_C_21;
      end
      modExp_while_C_21 : begin
        fsm_output = 9'b000100001;
        state_var_NS = modExp_while_C_22;
      end
      modExp_while_C_22 : begin
        fsm_output = 9'b000100010;
        state_var_NS = modExp_while_C_23;
      end
      modExp_while_C_23 : begin
        fsm_output = 9'b000100011;
        state_var_NS = modExp_while_C_24;
      end
      modExp_while_C_24 : begin
        fsm_output = 9'b000100100;
        state_var_NS = modExp_while_C_25;
      end
      modExp_while_C_25 : begin
        fsm_output = 9'b000100101;
        state_var_NS = modExp_while_C_26;
      end
      modExp_while_C_26 : begin
        fsm_output = 9'b000100110;
        state_var_NS = modExp_while_C_27;
      end
      modExp_while_C_27 : begin
        fsm_output = 9'b000100111;
        state_var_NS = modExp_while_C_28;
      end
      modExp_while_C_28 : begin
        fsm_output = 9'b000101000;
        state_var_NS = modExp_while_C_29;
      end
      modExp_while_C_29 : begin
        fsm_output = 9'b000101001;
        state_var_NS = modExp_while_C_30;
      end
      modExp_while_C_30 : begin
        fsm_output = 9'b000101010;
        state_var_NS = modExp_while_C_31;
      end
      modExp_while_C_31 : begin
        fsm_output = 9'b000101011;
        state_var_NS = modExp_while_C_32;
      end
      modExp_while_C_32 : begin
        fsm_output = 9'b000101100;
        state_var_NS = modExp_while_C_33;
      end
      modExp_while_C_33 : begin
        fsm_output = 9'b000101101;
        state_var_NS = modExp_while_C_34;
      end
      modExp_while_C_34 : begin
        fsm_output = 9'b000101110;
        state_var_NS = modExp_while_C_35;
      end
      modExp_while_C_35 : begin
        fsm_output = 9'b000101111;
        state_var_NS = modExp_while_C_36;
      end
      modExp_while_C_36 : begin
        fsm_output = 9'b000110000;
        state_var_NS = modExp_while_C_37;
      end
      modExp_while_C_37 : begin
        fsm_output = 9'b000110001;
        state_var_NS = modExp_while_C_38;
      end
      modExp_while_C_38 : begin
        fsm_output = 9'b000110010;
        state_var_NS = modExp_while_C_39;
      end
      modExp_while_C_39 : begin
        fsm_output = 9'b000110011;
        state_var_NS = modExp_while_C_40;
      end
      modExp_while_C_40 : begin
        fsm_output = 9'b000110100;
        state_var_NS = modExp_while_C_41;
      end
      modExp_while_C_41 : begin
        fsm_output = 9'b000110101;
        state_var_NS = modExp_while_C_42;
      end
      modExp_while_C_42 : begin
        fsm_output = 9'b000110110;
        state_var_NS = modExp_while_C_43;
      end
      modExp_while_C_43 : begin
        fsm_output = 9'b000110111;
        state_var_NS = modExp_while_C_44;
      end
      modExp_while_C_44 : begin
        fsm_output = 9'b000111000;
        state_var_NS = modExp_while_C_45;
      end
      modExp_while_C_45 : begin
        fsm_output = 9'b000111001;
        state_var_NS = modExp_while_C_46;
      end
      modExp_while_C_46 : begin
        fsm_output = 9'b000111010;
        state_var_NS = modExp_while_C_47;
      end
      modExp_while_C_47 : begin
        fsm_output = 9'b000111011;
        if ( modExp_while_C_47_tr0 ) begin
          state_var_NS = COMP_LOOP_C_0;
        end
        else begin
          state_var_NS = modExp_while_C_0;
        end
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 9'b000111100;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 9'b000111101;
        if ( COMP_LOOP_C_1_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_1_modExp_1_while_C_0 : begin
        fsm_output = 9'b000111110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_1;
      end
      COMP_LOOP_1_modExp_1_while_C_1 : begin
        fsm_output = 9'b000111111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_2;
      end
      COMP_LOOP_1_modExp_1_while_C_2 : begin
        fsm_output = 9'b001000000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_3;
      end
      COMP_LOOP_1_modExp_1_while_C_3 : begin
        fsm_output = 9'b001000001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_4;
      end
      COMP_LOOP_1_modExp_1_while_C_4 : begin
        fsm_output = 9'b001000010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_5;
      end
      COMP_LOOP_1_modExp_1_while_C_5 : begin
        fsm_output = 9'b001000011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_6;
      end
      COMP_LOOP_1_modExp_1_while_C_6 : begin
        fsm_output = 9'b001000100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_7;
      end
      COMP_LOOP_1_modExp_1_while_C_7 : begin
        fsm_output = 9'b001000101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_8;
      end
      COMP_LOOP_1_modExp_1_while_C_8 : begin
        fsm_output = 9'b001000110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_9;
      end
      COMP_LOOP_1_modExp_1_while_C_9 : begin
        fsm_output = 9'b001000111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_10;
      end
      COMP_LOOP_1_modExp_1_while_C_10 : begin
        fsm_output = 9'b001001000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_11;
      end
      COMP_LOOP_1_modExp_1_while_C_11 : begin
        fsm_output = 9'b001001001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_12;
      end
      COMP_LOOP_1_modExp_1_while_C_12 : begin
        fsm_output = 9'b001001010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_13;
      end
      COMP_LOOP_1_modExp_1_while_C_13 : begin
        fsm_output = 9'b001001011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_14;
      end
      COMP_LOOP_1_modExp_1_while_C_14 : begin
        fsm_output = 9'b001001100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_15;
      end
      COMP_LOOP_1_modExp_1_while_C_15 : begin
        fsm_output = 9'b001001101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_16;
      end
      COMP_LOOP_1_modExp_1_while_C_16 : begin
        fsm_output = 9'b001001110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_17;
      end
      COMP_LOOP_1_modExp_1_while_C_17 : begin
        fsm_output = 9'b001001111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_18;
      end
      COMP_LOOP_1_modExp_1_while_C_18 : begin
        fsm_output = 9'b001010000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_19;
      end
      COMP_LOOP_1_modExp_1_while_C_19 : begin
        fsm_output = 9'b001010001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_20;
      end
      COMP_LOOP_1_modExp_1_while_C_20 : begin
        fsm_output = 9'b001010010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_21;
      end
      COMP_LOOP_1_modExp_1_while_C_21 : begin
        fsm_output = 9'b001010011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_22;
      end
      COMP_LOOP_1_modExp_1_while_C_22 : begin
        fsm_output = 9'b001010100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_23;
      end
      COMP_LOOP_1_modExp_1_while_C_23 : begin
        fsm_output = 9'b001010101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_24;
      end
      COMP_LOOP_1_modExp_1_while_C_24 : begin
        fsm_output = 9'b001010110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_25;
      end
      COMP_LOOP_1_modExp_1_while_C_25 : begin
        fsm_output = 9'b001010111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_26;
      end
      COMP_LOOP_1_modExp_1_while_C_26 : begin
        fsm_output = 9'b001011000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_27;
      end
      COMP_LOOP_1_modExp_1_while_C_27 : begin
        fsm_output = 9'b001011001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_28;
      end
      COMP_LOOP_1_modExp_1_while_C_28 : begin
        fsm_output = 9'b001011010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_29;
      end
      COMP_LOOP_1_modExp_1_while_C_29 : begin
        fsm_output = 9'b001011011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_30;
      end
      COMP_LOOP_1_modExp_1_while_C_30 : begin
        fsm_output = 9'b001011100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_31;
      end
      COMP_LOOP_1_modExp_1_while_C_31 : begin
        fsm_output = 9'b001011101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_32;
      end
      COMP_LOOP_1_modExp_1_while_C_32 : begin
        fsm_output = 9'b001011110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_33;
      end
      COMP_LOOP_1_modExp_1_while_C_33 : begin
        fsm_output = 9'b001011111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_34;
      end
      COMP_LOOP_1_modExp_1_while_C_34 : begin
        fsm_output = 9'b001100000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_35;
      end
      COMP_LOOP_1_modExp_1_while_C_35 : begin
        fsm_output = 9'b001100001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_36;
      end
      COMP_LOOP_1_modExp_1_while_C_36 : begin
        fsm_output = 9'b001100010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_37;
      end
      COMP_LOOP_1_modExp_1_while_C_37 : begin
        fsm_output = 9'b001100011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_38;
      end
      COMP_LOOP_1_modExp_1_while_C_38 : begin
        fsm_output = 9'b001100100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_39;
      end
      COMP_LOOP_1_modExp_1_while_C_39 : begin
        fsm_output = 9'b001100101;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_40;
      end
      COMP_LOOP_1_modExp_1_while_C_40 : begin
        fsm_output = 9'b001100110;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_41;
      end
      COMP_LOOP_1_modExp_1_while_C_41 : begin
        fsm_output = 9'b001100111;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_42;
      end
      COMP_LOOP_1_modExp_1_while_C_42 : begin
        fsm_output = 9'b001101000;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_43;
      end
      COMP_LOOP_1_modExp_1_while_C_43 : begin
        fsm_output = 9'b001101001;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_44;
      end
      COMP_LOOP_1_modExp_1_while_C_44 : begin
        fsm_output = 9'b001101010;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_45;
      end
      COMP_LOOP_1_modExp_1_while_C_45 : begin
        fsm_output = 9'b001101011;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_46;
      end
      COMP_LOOP_1_modExp_1_while_C_46 : begin
        fsm_output = 9'b001101100;
        state_var_NS = COMP_LOOP_1_modExp_1_while_C_47;
      end
      COMP_LOOP_1_modExp_1_while_C_47 : begin
        fsm_output = 9'b001101101;
        if ( COMP_LOOP_1_modExp_1_while_C_47_tr0 ) begin
          state_var_NS = COMP_LOOP_C_2;
        end
        else begin
          state_var_NS = COMP_LOOP_1_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 9'b001101110;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 9'b001101111;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 9'b001110000;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 9'b001110001;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 9'b001110010;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 9'b001110011;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 9'b001110100;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 9'b001110101;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 9'b001110110;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 9'b001110111;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 9'b001111000;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 9'b001111001;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 9'b001111010;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 9'b001111011;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 9'b001111100;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 9'b001111101;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 9'b001111110;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 9'b001111111;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 9'b010000000;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 9'b010000001;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 9'b010000010;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 9'b010000011;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 9'b010000100;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 9'b010000101;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 9'b010000110;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 9'b010000111;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 9'b010001000;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 9'b010001001;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 9'b010001010;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 9'b010001011;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 9'b010001100;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 9'b010001101;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 9'b010001110;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 9'b010001111;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 9'b010010000;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 9'b010010001;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 9'b010010010;
        state_var_NS = COMP_LOOP_C_39;
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 9'b010010011;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 9'b010010100;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 9'b010010101;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 9'b010010110;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 9'b010010111;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 9'b010011000;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 9'b010011001;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 9'b010011010;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 9'b010011011;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 9'b010011100;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 9'b010011101;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 9'b010011110;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 9'b010011111;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 9'b010100000;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 9'b010100001;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 9'b010100010;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 9'b010100011;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 9'b010100100;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 9'b010100101;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 9'b010100110;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 9'b010100111;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 9'b010101000;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 9'b010101001;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 9'b010101010;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 9'b010101011;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 9'b010101100;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 9'b010101101;
        state_var_NS = COMP_LOOP_C_66;
      end
      COMP_LOOP_C_66 : begin
        fsm_output = 9'b010101110;
        state_var_NS = COMP_LOOP_C_67;
      end
      COMP_LOOP_C_67 : begin
        fsm_output = 9'b010101111;
        state_var_NS = COMP_LOOP_C_68;
      end
      COMP_LOOP_C_68 : begin
        fsm_output = 9'b010110000;
        state_var_NS = COMP_LOOP_C_69;
      end
      COMP_LOOP_C_69 : begin
        fsm_output = 9'b010110001;
        state_var_NS = COMP_LOOP_C_70;
      end
      COMP_LOOP_C_70 : begin
        fsm_output = 9'b010110010;
        state_var_NS = COMP_LOOP_C_71;
      end
      COMP_LOOP_C_71 : begin
        fsm_output = 9'b010110011;
        state_var_NS = COMP_LOOP_C_72;
      end
      COMP_LOOP_C_72 : begin
        fsm_output = 9'b010110100;
        state_var_NS = COMP_LOOP_C_73;
      end
      COMP_LOOP_C_73 : begin
        fsm_output = 9'b010110101;
        state_var_NS = COMP_LOOP_C_74;
      end
      COMP_LOOP_C_74 : begin
        fsm_output = 9'b010110110;
        state_var_NS = COMP_LOOP_C_75;
      end
      COMP_LOOP_C_75 : begin
        fsm_output = 9'b010110111;
        state_var_NS = COMP_LOOP_C_76;
      end
      COMP_LOOP_C_76 : begin
        fsm_output = 9'b010111000;
        if ( COMP_LOOP_C_76_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_77;
        end
      end
      COMP_LOOP_C_77 : begin
        fsm_output = 9'b010111001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_0;
      end
      COMP_LOOP_2_modExp_1_while_C_0 : begin
        fsm_output = 9'b010111010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_1;
      end
      COMP_LOOP_2_modExp_1_while_C_1 : begin
        fsm_output = 9'b010111011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_2;
      end
      COMP_LOOP_2_modExp_1_while_C_2 : begin
        fsm_output = 9'b010111100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_3;
      end
      COMP_LOOP_2_modExp_1_while_C_3 : begin
        fsm_output = 9'b010111101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_4;
      end
      COMP_LOOP_2_modExp_1_while_C_4 : begin
        fsm_output = 9'b010111110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_5;
      end
      COMP_LOOP_2_modExp_1_while_C_5 : begin
        fsm_output = 9'b010111111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_6;
      end
      COMP_LOOP_2_modExp_1_while_C_6 : begin
        fsm_output = 9'b011000000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_7;
      end
      COMP_LOOP_2_modExp_1_while_C_7 : begin
        fsm_output = 9'b011000001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_8;
      end
      COMP_LOOP_2_modExp_1_while_C_8 : begin
        fsm_output = 9'b011000010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_9;
      end
      COMP_LOOP_2_modExp_1_while_C_9 : begin
        fsm_output = 9'b011000011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_10;
      end
      COMP_LOOP_2_modExp_1_while_C_10 : begin
        fsm_output = 9'b011000100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_11;
      end
      COMP_LOOP_2_modExp_1_while_C_11 : begin
        fsm_output = 9'b011000101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_12;
      end
      COMP_LOOP_2_modExp_1_while_C_12 : begin
        fsm_output = 9'b011000110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_13;
      end
      COMP_LOOP_2_modExp_1_while_C_13 : begin
        fsm_output = 9'b011000111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_14;
      end
      COMP_LOOP_2_modExp_1_while_C_14 : begin
        fsm_output = 9'b011001000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_15;
      end
      COMP_LOOP_2_modExp_1_while_C_15 : begin
        fsm_output = 9'b011001001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_16;
      end
      COMP_LOOP_2_modExp_1_while_C_16 : begin
        fsm_output = 9'b011001010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_17;
      end
      COMP_LOOP_2_modExp_1_while_C_17 : begin
        fsm_output = 9'b011001011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_18;
      end
      COMP_LOOP_2_modExp_1_while_C_18 : begin
        fsm_output = 9'b011001100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_19;
      end
      COMP_LOOP_2_modExp_1_while_C_19 : begin
        fsm_output = 9'b011001101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_20;
      end
      COMP_LOOP_2_modExp_1_while_C_20 : begin
        fsm_output = 9'b011001110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_21;
      end
      COMP_LOOP_2_modExp_1_while_C_21 : begin
        fsm_output = 9'b011001111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_22;
      end
      COMP_LOOP_2_modExp_1_while_C_22 : begin
        fsm_output = 9'b011010000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_23;
      end
      COMP_LOOP_2_modExp_1_while_C_23 : begin
        fsm_output = 9'b011010001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_24;
      end
      COMP_LOOP_2_modExp_1_while_C_24 : begin
        fsm_output = 9'b011010010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_25;
      end
      COMP_LOOP_2_modExp_1_while_C_25 : begin
        fsm_output = 9'b011010011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_26;
      end
      COMP_LOOP_2_modExp_1_while_C_26 : begin
        fsm_output = 9'b011010100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_27;
      end
      COMP_LOOP_2_modExp_1_while_C_27 : begin
        fsm_output = 9'b011010101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_28;
      end
      COMP_LOOP_2_modExp_1_while_C_28 : begin
        fsm_output = 9'b011010110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_29;
      end
      COMP_LOOP_2_modExp_1_while_C_29 : begin
        fsm_output = 9'b011010111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_30;
      end
      COMP_LOOP_2_modExp_1_while_C_30 : begin
        fsm_output = 9'b011011000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_31;
      end
      COMP_LOOP_2_modExp_1_while_C_31 : begin
        fsm_output = 9'b011011001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_32;
      end
      COMP_LOOP_2_modExp_1_while_C_32 : begin
        fsm_output = 9'b011011010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_33;
      end
      COMP_LOOP_2_modExp_1_while_C_33 : begin
        fsm_output = 9'b011011011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_34;
      end
      COMP_LOOP_2_modExp_1_while_C_34 : begin
        fsm_output = 9'b011011100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_35;
      end
      COMP_LOOP_2_modExp_1_while_C_35 : begin
        fsm_output = 9'b011011101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_36;
      end
      COMP_LOOP_2_modExp_1_while_C_36 : begin
        fsm_output = 9'b011011110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_37;
      end
      COMP_LOOP_2_modExp_1_while_C_37 : begin
        fsm_output = 9'b011011111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_38;
      end
      COMP_LOOP_2_modExp_1_while_C_38 : begin
        fsm_output = 9'b011100000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_39;
      end
      COMP_LOOP_2_modExp_1_while_C_39 : begin
        fsm_output = 9'b011100001;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_40;
      end
      COMP_LOOP_2_modExp_1_while_C_40 : begin
        fsm_output = 9'b011100010;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_41;
      end
      COMP_LOOP_2_modExp_1_while_C_41 : begin
        fsm_output = 9'b011100011;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_42;
      end
      COMP_LOOP_2_modExp_1_while_C_42 : begin
        fsm_output = 9'b011100100;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_43;
      end
      COMP_LOOP_2_modExp_1_while_C_43 : begin
        fsm_output = 9'b011100101;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_44;
      end
      COMP_LOOP_2_modExp_1_while_C_44 : begin
        fsm_output = 9'b011100110;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_45;
      end
      COMP_LOOP_2_modExp_1_while_C_45 : begin
        fsm_output = 9'b011100111;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_46;
      end
      COMP_LOOP_2_modExp_1_while_C_46 : begin
        fsm_output = 9'b011101000;
        state_var_NS = COMP_LOOP_2_modExp_1_while_C_47;
      end
      COMP_LOOP_2_modExp_1_while_C_47 : begin
        fsm_output = 9'b011101001;
        if ( COMP_LOOP_2_modExp_1_while_C_47_tr0 ) begin
          state_var_NS = COMP_LOOP_C_78;
        end
        else begin
          state_var_NS = COMP_LOOP_2_modExp_1_while_C_0;
        end
      end
      COMP_LOOP_C_78 : begin
        fsm_output = 9'b011101010;
        state_var_NS = COMP_LOOP_C_79;
      end
      COMP_LOOP_C_79 : begin
        fsm_output = 9'b011101011;
        state_var_NS = COMP_LOOP_C_80;
      end
      COMP_LOOP_C_80 : begin
        fsm_output = 9'b011101100;
        state_var_NS = COMP_LOOP_C_81;
      end
      COMP_LOOP_C_81 : begin
        fsm_output = 9'b011101101;
        state_var_NS = COMP_LOOP_C_82;
      end
      COMP_LOOP_C_82 : begin
        fsm_output = 9'b011101110;
        state_var_NS = COMP_LOOP_C_83;
      end
      COMP_LOOP_C_83 : begin
        fsm_output = 9'b011101111;
        state_var_NS = COMP_LOOP_C_84;
      end
      COMP_LOOP_C_84 : begin
        fsm_output = 9'b011110000;
        state_var_NS = COMP_LOOP_C_85;
      end
      COMP_LOOP_C_85 : begin
        fsm_output = 9'b011110001;
        state_var_NS = COMP_LOOP_C_86;
      end
      COMP_LOOP_C_86 : begin
        fsm_output = 9'b011110010;
        state_var_NS = COMP_LOOP_C_87;
      end
      COMP_LOOP_C_87 : begin
        fsm_output = 9'b011110011;
        state_var_NS = COMP_LOOP_C_88;
      end
      COMP_LOOP_C_88 : begin
        fsm_output = 9'b011110100;
        state_var_NS = COMP_LOOP_C_89;
      end
      COMP_LOOP_C_89 : begin
        fsm_output = 9'b011110101;
        state_var_NS = COMP_LOOP_C_90;
      end
      COMP_LOOP_C_90 : begin
        fsm_output = 9'b011110110;
        state_var_NS = COMP_LOOP_C_91;
      end
      COMP_LOOP_C_91 : begin
        fsm_output = 9'b011110111;
        state_var_NS = COMP_LOOP_C_92;
      end
      COMP_LOOP_C_92 : begin
        fsm_output = 9'b011111000;
        state_var_NS = COMP_LOOP_C_93;
      end
      COMP_LOOP_C_93 : begin
        fsm_output = 9'b011111001;
        state_var_NS = COMP_LOOP_C_94;
      end
      COMP_LOOP_C_94 : begin
        fsm_output = 9'b011111010;
        state_var_NS = COMP_LOOP_C_95;
      end
      COMP_LOOP_C_95 : begin
        fsm_output = 9'b011111011;
        state_var_NS = COMP_LOOP_C_96;
      end
      COMP_LOOP_C_96 : begin
        fsm_output = 9'b011111100;
        state_var_NS = COMP_LOOP_C_97;
      end
      COMP_LOOP_C_97 : begin
        fsm_output = 9'b011111101;
        state_var_NS = COMP_LOOP_C_98;
      end
      COMP_LOOP_C_98 : begin
        fsm_output = 9'b011111110;
        state_var_NS = COMP_LOOP_C_99;
      end
      COMP_LOOP_C_99 : begin
        fsm_output = 9'b011111111;
        state_var_NS = COMP_LOOP_C_100;
      end
      COMP_LOOP_C_100 : begin
        fsm_output = 9'b100000000;
        state_var_NS = COMP_LOOP_C_101;
      end
      COMP_LOOP_C_101 : begin
        fsm_output = 9'b100000001;
        state_var_NS = COMP_LOOP_C_102;
      end
      COMP_LOOP_C_102 : begin
        fsm_output = 9'b100000010;
        state_var_NS = COMP_LOOP_C_103;
      end
      COMP_LOOP_C_103 : begin
        fsm_output = 9'b100000011;
        state_var_NS = COMP_LOOP_C_104;
      end
      COMP_LOOP_C_104 : begin
        fsm_output = 9'b100000100;
        state_var_NS = COMP_LOOP_C_105;
      end
      COMP_LOOP_C_105 : begin
        fsm_output = 9'b100000101;
        state_var_NS = COMP_LOOP_C_106;
      end
      COMP_LOOP_C_106 : begin
        fsm_output = 9'b100000110;
        state_var_NS = COMP_LOOP_C_107;
      end
      COMP_LOOP_C_107 : begin
        fsm_output = 9'b100000111;
        state_var_NS = COMP_LOOP_C_108;
      end
      COMP_LOOP_C_108 : begin
        fsm_output = 9'b100001000;
        state_var_NS = COMP_LOOP_C_109;
      end
      COMP_LOOP_C_109 : begin
        fsm_output = 9'b100001001;
        state_var_NS = COMP_LOOP_C_110;
      end
      COMP_LOOP_C_110 : begin
        fsm_output = 9'b100001010;
        state_var_NS = COMP_LOOP_C_111;
      end
      COMP_LOOP_C_111 : begin
        fsm_output = 9'b100001011;
        state_var_NS = COMP_LOOP_C_112;
      end
      COMP_LOOP_C_112 : begin
        fsm_output = 9'b100001100;
        state_var_NS = COMP_LOOP_C_113;
      end
      COMP_LOOP_C_113 : begin
        fsm_output = 9'b100001101;
        state_var_NS = COMP_LOOP_C_114;
      end
      COMP_LOOP_C_114 : begin
        fsm_output = 9'b100001110;
        state_var_NS = COMP_LOOP_C_115;
      end
      COMP_LOOP_C_115 : begin
        fsm_output = 9'b100001111;
        state_var_NS = COMP_LOOP_C_116;
      end
      COMP_LOOP_C_116 : begin
        fsm_output = 9'b100010000;
        state_var_NS = COMP_LOOP_C_117;
      end
      COMP_LOOP_C_117 : begin
        fsm_output = 9'b100010001;
        state_var_NS = COMP_LOOP_C_118;
      end
      COMP_LOOP_C_118 : begin
        fsm_output = 9'b100010010;
        state_var_NS = COMP_LOOP_C_119;
      end
      COMP_LOOP_C_119 : begin
        fsm_output = 9'b100010011;
        state_var_NS = COMP_LOOP_C_120;
      end
      COMP_LOOP_C_120 : begin
        fsm_output = 9'b100010100;
        state_var_NS = COMP_LOOP_C_121;
      end
      COMP_LOOP_C_121 : begin
        fsm_output = 9'b100010101;
        state_var_NS = COMP_LOOP_C_122;
      end
      COMP_LOOP_C_122 : begin
        fsm_output = 9'b100010110;
        state_var_NS = COMP_LOOP_C_123;
      end
      COMP_LOOP_C_123 : begin
        fsm_output = 9'b100010111;
        state_var_NS = COMP_LOOP_C_124;
      end
      COMP_LOOP_C_124 : begin
        fsm_output = 9'b100011000;
        state_var_NS = COMP_LOOP_C_125;
      end
      COMP_LOOP_C_125 : begin
        fsm_output = 9'b100011001;
        state_var_NS = COMP_LOOP_C_126;
      end
      COMP_LOOP_C_126 : begin
        fsm_output = 9'b100011010;
        state_var_NS = COMP_LOOP_C_127;
      end
      COMP_LOOP_C_127 : begin
        fsm_output = 9'b100011011;
        state_var_NS = COMP_LOOP_C_128;
      end
      COMP_LOOP_C_128 : begin
        fsm_output = 9'b100011100;
        state_var_NS = COMP_LOOP_C_129;
      end
      COMP_LOOP_C_129 : begin
        fsm_output = 9'b100011101;
        state_var_NS = COMP_LOOP_C_130;
      end
      COMP_LOOP_C_130 : begin
        fsm_output = 9'b100011110;
        state_var_NS = COMP_LOOP_C_131;
      end
      COMP_LOOP_C_131 : begin
        fsm_output = 9'b100011111;
        state_var_NS = COMP_LOOP_C_132;
      end
      COMP_LOOP_C_132 : begin
        fsm_output = 9'b100100000;
        state_var_NS = COMP_LOOP_C_133;
      end
      COMP_LOOP_C_133 : begin
        fsm_output = 9'b100100001;
        state_var_NS = COMP_LOOP_C_134;
      end
      COMP_LOOP_C_134 : begin
        fsm_output = 9'b100100010;
        state_var_NS = COMP_LOOP_C_135;
      end
      COMP_LOOP_C_135 : begin
        fsm_output = 9'b100100011;
        state_var_NS = COMP_LOOP_C_136;
      end
      COMP_LOOP_C_136 : begin
        fsm_output = 9'b100100100;
        state_var_NS = COMP_LOOP_C_137;
      end
      COMP_LOOP_C_137 : begin
        fsm_output = 9'b100100101;
        state_var_NS = COMP_LOOP_C_138;
      end
      COMP_LOOP_C_138 : begin
        fsm_output = 9'b100100110;
        state_var_NS = COMP_LOOP_C_139;
      end
      COMP_LOOP_C_139 : begin
        fsm_output = 9'b100100111;
        state_var_NS = COMP_LOOP_C_140;
      end
      COMP_LOOP_C_140 : begin
        fsm_output = 9'b100101000;
        state_var_NS = COMP_LOOP_C_141;
      end
      COMP_LOOP_C_141 : begin
        fsm_output = 9'b100101001;
        state_var_NS = COMP_LOOP_C_142;
      end
      COMP_LOOP_C_142 : begin
        fsm_output = 9'b100101010;
        state_var_NS = COMP_LOOP_C_143;
      end
      COMP_LOOP_C_143 : begin
        fsm_output = 9'b100101011;
        state_var_NS = COMP_LOOP_C_144;
      end
      COMP_LOOP_C_144 : begin
        fsm_output = 9'b100101100;
        state_var_NS = COMP_LOOP_C_145;
      end
      COMP_LOOP_C_145 : begin
        fsm_output = 9'b100101101;
        state_var_NS = COMP_LOOP_C_146;
      end
      COMP_LOOP_C_146 : begin
        fsm_output = 9'b100101110;
        state_var_NS = COMP_LOOP_C_147;
      end
      COMP_LOOP_C_147 : begin
        fsm_output = 9'b100101111;
        state_var_NS = COMP_LOOP_C_148;
      end
      COMP_LOOP_C_148 : begin
        fsm_output = 9'b100110000;
        state_var_NS = COMP_LOOP_C_149;
      end
      COMP_LOOP_C_149 : begin
        fsm_output = 9'b100110001;
        state_var_NS = COMP_LOOP_C_150;
      end
      COMP_LOOP_C_150 : begin
        fsm_output = 9'b100110010;
        state_var_NS = COMP_LOOP_C_151;
      end
      COMP_LOOP_C_151 : begin
        fsm_output = 9'b100110011;
        state_var_NS = COMP_LOOP_C_152;
      end
      COMP_LOOP_C_152 : begin
        fsm_output = 9'b100110100;
        if ( COMP_LOOP_C_152_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 9'b100110101;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_11;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_11 : begin
        fsm_output = 9'b100110110;
        if ( STAGE_LOOP_C_11_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b100110111;
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
  clk, rst, vec_rsc_triosy_0_0_lz, vec_rsc_triosy_0_1_lz, p_rsc_dat, p_rsc_triosy_lz,
      r_rsc_dat, r_rsc_triosy_lz, vec_rsc_0_0_i_qa_d, vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d,
      vec_rsc_0_1_i_qa_d, vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d, operator_66_true_div_cmp_a,
      operator_66_true_div_cmp_b, operator_66_true_div_cmp_z, vec_rsc_0_0_i_adra_d_pff,
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
  output [64:0] operator_66_true_div_cmp_a;
  reg [64:0] operator_66_true_div_cmp_a;
  output [10:0] operator_66_true_div_cmp_b;
  input [64:0] operator_66_true_div_cmp_z;
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
  wire [63:0] operator_66_true_div_cmp_z_oreg;
  wire [8:0] fsm_output;
  wire or_tmp_4;
  wire not_tmp_7;
  wire mux_tmp_22;
  wire and_dcpl;
  wire and_dcpl_4;
  wire and_dcpl_5;
  wire and_dcpl_8;
  wire or_tmp_39;
  wire or_tmp_62;
  wire or_tmp_63;
  wire mux_tmp_84;
  wire not_tmp_50;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_33;
  wire and_dcpl_34;
  wire and_dcpl_37;
  wire and_dcpl_38;
  wire and_dcpl_39;
  wire and_dcpl_41;
  wire and_dcpl_43;
  wire and_dcpl_47;
  wire and_dcpl_49;
  wire and_dcpl_50;
  wire and_dcpl_51;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_65;
  wire and_dcpl_69;
  wire and_dcpl_80;
  wire and_dcpl_82;
  wire or_tmp_96;
  wire or_tmp_99;
  wire nor_tmp_35;
  wire or_tmp_106;
  wire mux_tmp_109;
  wire mux_tmp_110;
  wire and_tmp_7;
  wire nor_tmp_36;
  wire and_dcpl_99;
  wire mux_tmp_122;
  wire and_tmp_10;
  wire and_dcpl_103;
  wire and_dcpl_104;
  wire and_dcpl_105;
  wire or_tmp_124;
  wire or_tmp_125;
  wire and_dcpl_112;
  wire or_tmp_130;
  wire and_dcpl_113;
  wire and_dcpl_119;
  wire and_dcpl_120;
  wire or_tmp_154;
  wire mux_tmp_170;
  wire and_dcpl_129;
  wire xor_dcpl_2;
  wire and_dcpl_138;
  wire and_dcpl_140;
  wire and_dcpl_142;
  wire or_tmp_165;
  wire mux_tmp_180;
  wire or_tmp_170;
  wire and_dcpl_148;
  wire and_dcpl_152;
  wire and_dcpl_158;
  wire and_dcpl_159;
  wire and_dcpl_160;
  wire mux_tmp_207;
  wire mux_tmp_210;
  wire or_tmp_203;
  wire or_tmp_204;
  wire mux_tmp_219;
  wire and_dcpl_163;
  wire or_dcpl_28;
  wire or_dcpl_32;
  wire or_dcpl_35;
  wire or_dcpl_36;
  wire or_dcpl_37;
  wire or_tmp_225;
  wire and_dcpl_166;
  wire or_tmp_227;
  wire and_dcpl_169;
  wire and_dcpl_170;
  wire and_dcpl_171;
  wire and_dcpl_175;
  wire and_dcpl_180;
  wire not_tmp_155;
  wire or_dcpl_52;
  reg exit_COMP_LOOP_1_modExp_1_while_sva;
  reg COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  reg [11:0] VEC_LOOP_j_sva_11_0;
  reg modExp_exp_1_0_1_sva;
  reg [64:0] operator_64_false_acc_mut;
  reg [11:0] COMP_LOOP_acc_1_cse_sva;
  reg [11:0] COMP_LOOP_acc_10_cse_12_1_1_sva;
  reg [63:0] COMP_LOOP_1_acc_8_itm;
  wire and_138_m1c;
  wire nor_28_cse;
  reg reg_vec_rsc_triosy_0_1_obj_ld_cse;
  wire or_134_cse;
  wire and_244_cse;
  wire and_246_cse;
  wire nor_119_cse;
  wire and_241_cse;
  wire or_38_cse;
  wire or_308_cse;
  wire or_12_cse;
  wire mux_23_cse;
  wire or_37_cse;
  wire or_39_cse;
  reg [7:0] COMP_LOOP_k_9_1_sva_7_0;
  reg modExp_while_and_itm;
  reg modExp_while_and_1_itm;
  reg [9:0] reg_operator_66_true_div_cmp_b_reg;
  wire [10:0] COMP_LOOP_acc_psp_sva_1;
  wire [11:0] nl_COMP_LOOP_acc_psp_sva_1;
  reg [10:0] COMP_LOOP_acc_psp_sva;
  wire [63:0] vec_rsc_0_0_i_da_d_1;
  wire mux_103_itm;
  wire and_dcpl_187;
  wire and_dcpl_192;
  wire and_dcpl_198;
  wire and_dcpl_199;
  wire and_dcpl_201;
  wire and_dcpl_205;
  wire and_dcpl_206;
  wire and_dcpl_207;
  wire and_dcpl_212;
  wire and_dcpl_214;
  wire and_dcpl_215;
  wire and_dcpl_216;
  wire and_dcpl_222;
  wire and_dcpl_223;
  wire [64:0] z_out;
  wire [9:0] z_out_1;
  wire [10:0] nl_z_out_1;
  wire and_dcpl_240;
  wire and_dcpl_243;
  wire and_dcpl_244;
  wire and_dcpl_246;
  wire and_dcpl_248;
  wire and_dcpl_255;
  wire and_dcpl_257;
  wire and_dcpl_262;
  wire and_dcpl_266;
  wire [64:0] z_out_2;
  wire [63:0] z_out_3;
  wire signed [128:0] nl_z_out_3;
  reg [63:0] p_sva;
  reg [63:0] r_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [9:0] STAGE_LOOP_lshift_psp_sva;
  reg [63:0] modExp_result_sva;
  reg modExp_exp_1_7_1_sva;
  reg modExp_exp_1_6_1_sva;
  reg modExp_exp_1_5_1_sva;
  reg modExp_exp_1_4_1_sva;
  reg modExp_exp_1_3_1_sva;
  reg modExp_exp_1_2_1_sva;
  reg modExp_exp_1_1_1_sva;
  reg modExp_exp_1_0_1_sva_1;
  reg [63:0] tmp_2_lpi_4_dfm;
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
  wire [63:0] COMP_LOOP_1_modExp_1_while_if_mul_mut_1;
  wire signed [127:0] nl_COMP_LOOP_1_modExp_1_while_if_mul_mut_1;
  wire [9:0] STAGE_LOOP_lshift_psp_sva_mx0w0;
  wire operator_64_false_acc_mut_mx0c0;
  wire VEC_LOOP_j_sva_11_0_mx0c1;
  wire modExp_result_sva_mx0c0;
  wire [62:0] operator_64_false_slc_modExp_exp_63_1_3;
  wire tmp_2_lpi_4_dfm_mx0c1;
  wire modExp_1_while_and_7;
  wire and_147_m1c;
  wire modExp_result_and_rgt;
  wire modExp_result_and_1_rgt;
  wire COMP_LOOP_or_3_cse;
  wire nor_152_cse;
  wire mux_151_itm;
  wire COMP_LOOP_or_18_itm;
  wire COMP_LOOP_or_22_itm;
  wire COMP_LOOP_nor_7_itm;
  wire STAGE_LOOP_acc_itm_2_1;

  wire[0:0] modulo_result_or_nl;
  wire[0:0] and_90_nl;
  wire[0:0] mux_104_nl;
  wire[0:0] nor_147_nl;
  wire[0:0] and_93_nl;
  wire[0:0] mux_106_nl;
  wire[0:0] mux_105_nl;
  wire[0:0] and_96_nl;
  wire[0:0] mux_108_nl;
  wire[0:0] mux_107_nl;
  wire[0:0] nor_92_nl;
  wire[0:0] and_247_nl;
  wire[0:0] nor_94_nl;
  wire[0:0] and_97_nl;
  wire[0:0] mux_112_nl;
  wire[0:0] mux_111_nl;
  wire[0:0] and_101_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] mux_114_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] nor_131_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] nand_45_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] and_102_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] or_315_nl;
  wire[0:0] mux_116_nl;
  wire[0:0] or_131_nl;
  wire[0:0] nor_136_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] nand_48_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] or_320_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] nor_124_nl;
  wire[0:0] mux_131_nl;
  wire[0:0] nand_42_nl;
  wire[0:0] mux_130_nl;
  wire[0:0] nand_29_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] or_312_nl;
  wire[0:0] mux_128_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] and_211_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] and_117_nl;
  wire[0:0] mux_134_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] or_142_nl;
  wire[0:0] and_120_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] mux_139_nl;
  wire[0:0] and_208_nl;
  wire[0:0] mux_138_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] and_209_nl;
  wire[0:0] nor_86_nl;
  wire[0:0] nor_85_nl;
  wire[0:0] or_nl;
  wire[0:0] mux_164_nl;
  wire[0:0] mux_163_nl;
  wire[0:0] or_170_nl;
  wire[0:0] or_168_nl;
  wire[0:0] or_167_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_263_nl;
  wire[0:0] or_345_nl;
  wire[0:0] nand_57_nl;
  wire[0:0] mux_nl;
  wire[0:0] nor_158_nl;
  wire[0:0] nor_159_nl;
  wire[0:0] nor_160_nl;
  wire[0:0] mux_173_nl;
  wire[0:0] nor_82_nl;
  wire[0:0] mux_172_nl;
  wire[0:0] or_180_nl;
  wire[0:0] mux_174_nl;
  wire[0:0] nor_80_nl;
  wire[0:0] nor_81_nl;
  wire[0:0] and_143_nl;
  wire[0:0] COMP_LOOP_or_7_nl;
  wire[0:0] COMP_LOOP_or_8_nl;
  wire[0:0] and_155_nl;
  wire[0:0] and_158_nl;
  wire[0:0] mux_188_nl;
  wire[0:0] mux_187_nl;
  wire[0:0] or_337_nl;
  wire[0:0] or_338_nl;
  wire[0:0] mux_186_nl;
  wire[0:0] mux_185_nl;
  wire[0:0] mux_184_nl;
  wire[0:0] nor_77_nl;
  wire[0:0] mux_183_nl;
  wire[0:0] mux_182_nl;
  wire[0:0] mux_181_nl;
  wire[0:0] or_191_nl;
  wire[0:0] or_339_nl;
  wire[0:0] mux_179_nl;
  wire[0:0] mux_178_nl;
  wire[0:0] mux_177_nl;
  wire[0:0] mux_176_nl;
  wire[0:0] mux_175_nl;
  wire[0:0] COMP_LOOP_and_nl;
  wire[0:0] COMP_LOOP_and_1_nl;
  wire[0:0] mux_204_nl;
  wire[0:0] mux_203_nl;
  wire[0:0] mux_202_nl;
  wire[0:0] nor_69_nl;
  wire[0:0] mux_201_nl;
  wire[0:0] and_170_nl;
  wire[0:0] or_217_nl;
  wire[0:0] mux_200_nl;
  wire[0:0] mux_199_nl;
  wire[0:0] mux_198_nl;
  wire[0:0] nor_71_nl;
  wire[0:0] and_169_nl;
  wire[0:0] mux_197_nl;
  wire[0:0] nor_72_nl;
  wire[0:0] mux_196_nl;
  wire[0:0] mux_195_nl;
  wire[0:0] mux_194_nl;
  wire[0:0] and_204_nl;
  wire[0:0] nor_73_nl;
  wire[0:0] nor_74_nl;
  wire[0:0] mux_193_nl;
  wire[0:0] mux_192_nl;
  wire[0:0] or_209_nl;
  wire[0:0] mux_191_nl;
  wire[0:0] or_208_nl;
  wire[0:0] or_206_nl;
  wire[0:0] mux_190_nl;
  wire[0:0] or_74_nl;
  wire[0:0] or_202_nl;
  wire[0:0] COMP_LOOP_mux1h_16_nl;
  wire[0:0] COMP_LOOP_and_5_nl;
  wire[0:0] mux_216_nl;
  wire[0:0] mux_215_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] or_225_nl;
  wire[0:0] mux_212_nl;
  wire[0:0] or_224_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] mux_227_nl;
  wire[0:0] mux_226_nl;
  wire[0:0] or_235_nl;
  wire[0:0] mux_225_nl;
  wire[0:0] or_233_nl;
  wire[0:0] mux_224_nl;
  wire[0:0] mux_223_nl;
  wire[0:0] or_230_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] mux_220_nl;
  wire[0:0] or_226_nl;
  wire[0:0] mux_228_nl;
  wire[0:0] nor_146_nl;
  wire[9:0] COMP_LOOP_1_acc_nl;
  wire[10:0] nl_COMP_LOOP_1_acc_nl;
  wire[0:0] nor_157_nl;
  wire[0:0] mux_235_nl;
  wire[0:0] mux_234_nl;
  wire[0:0] and_201_nl;
  wire[0:0] or_336_nl;
  wire[0:0] mux_233_nl;
  wire[0:0] and_202_nl;
  wire[0:0] and_182_nl;
  wire[0:0] mux_240_nl;
  wire[0:0] mux_239_nl;
  wire[0:0] mux_238_nl;
  wire[0:0] mux_237_nl;
  wire[0:0] nand_52_nl;
  wire[0:0] COMP_LOOP_mux1h_23_nl;
  wire[0:0] COMP_LOOP_mux1h_40_nl;
  wire[0:0] nor_127_nl;
  wire[0:0] mux_249_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] mux_247_nl;
  wire[0:0] mux_246_nl;
  wire[0:0] mux_251_nl;
  wire[0:0] mux_250_nl;
  wire[0:0] or_276_nl;
  wire[0:0] or_275_nl;
  wire[0:0] mux_255_nl;
  wire[0:0] mux_254_nl;
  wire[0:0] mux_258_nl;
  wire[0:0] mux_257_nl;
  wire[0:0] mux_256_nl;
  wire[0:0] or_26_nl;
  wire[0:0] or_24_nl;
  wire[0:0] or_305_nl;
  wire[0:0] nor_110_nl;
  wire[0:0] mux_86_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] or_127_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] or_321_nl;
  wire[0:0] or_322_nl;
  wire[0:0] and_213_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] mux_141_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] or_150_nl;
  wire[0:0] mux_205_nl;
  wire[0:0] nor_67_nl;
  wire[0:0] nor_68_nl;
  wire[0:0] mux_209_nl;
  wire[0:0] mux_208_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] mux_244_nl;
  wire[0:0] mux_243_nl;
  wire[0:0] mux_242_nl;
  wire[0:0] mux_241_nl;
  wire[0:0] mux_245_nl;
  wire[0:0] nor_61_nl;
  wire[0:0] nor_62_nl;
  wire[0:0] nand_15_nl;
  wire[0:0] mux_150_nl;
  wire[0:0] nand_14_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] or_28_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] or_157_nl;
  wire[0:0] mux_146_nl;
  wire[0:0] nand_2_nl;
  wire[0:0] or_153_nl;
  wire[0:0] nor_83_nl;
  wire[0:0] mux_253_nl;
  wire[0:0] or_277_nl;
  wire[0:0] mux_252_nl;
  wire[2:0] STAGE_LOOP_acc_nl;
  wire[3:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] and_62_nl;
  wire[0:0] and_67_nl;
  wire[0:0] mux_89_nl;
  wire[0:0] and_235_nl;
  wire[0:0] nor_118_nl;
  wire[0:0] and_71_nl;
  wire[0:0] mux_90_nl;
  wire[0:0] nor_107_nl;
  wire[0:0] nor_108_nl;
  wire[0:0] mux_93_nl;
  wire[0:0] nand_44_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] nor_104_nl;
  wire[0:0] nor_105_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] or_95_nl;
  wire[0:0] or_314_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] nor_101_nl;
  wire[0:0] mux_95_nl;
  wire[0:0] or_102_nl;
  wire[0:0] or_101_nl;
  wire[0:0] and_224_nl;
  wire[0:0] mux_94_nl;
  wire[0:0] nor_102_nl;
  wire[0:0] nor_103_nl;
  wire[0:0] mux_99_nl;
  wire[0:0] nand_43_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] nor_97_nl;
  wire[0:0] and_223_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] nor_98_nl;
  wire[0:0] nor_99_nl;
  wire[0:0] or_313_nl;
  wire[0:0] mux_102_nl;
  wire[0:0] nor_95_nl;
  wire[0:0] mux_101_nl;
  wire[0:0] nand_31_nl;
  wire[0:0] or_111_nl;
  wire[0:0] and_220_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] and_221_nl;
  wire[0:0] nor_96_nl;
  wire[0:0] mux_262_nl;
  wire[0:0] or_334_nl;
  wire[0:0] or_335_nl;
  wire[65:0] acc_nl;
  wire[66:0] nl_acc_nl;
  wire[51:0] COMP_LOOP_COMP_LOOP_or_4_nl;
  wire[51:0] COMP_LOOP_and_14_nl;
  wire[51:0] COMP_LOOP_mux_12_nl;
  wire[0:0] COMP_LOOP_nor_64_nl;
  wire[1:0] COMP_LOOP_or_28_nl;
  wire[1:0] COMP_LOOP_and_15_nl;
  wire[1:0] COMP_LOOP_mux1h_75_nl;
  wire[0:0] COMP_LOOP_nor_65_nl;
  wire[1:0] COMP_LOOP_or_29_nl;
  wire[1:0] COMP_LOOP_mux1h_76_nl;
  wire[0:0] COMP_LOOP_or_30_nl;
  wire[7:0] COMP_LOOP_mux1h_77_nl;
  wire[0:0] COMP_LOOP_or_31_nl;
  wire[63:0] COMP_LOOP_nand_1_nl;
  wire[63:0] COMP_LOOP_mux1h_78_nl;
  wire[0:0] COMP_LOOP_not_55_nl;
  wire[0:0] and_342_nl;
  wire[65:0] acc_2_nl;
  wire[66:0] nl_acc_2_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_5_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_6_nl;
  wire[0:0] COMP_LOOP_mux_13_nl;
  wire[62:0] COMP_LOOP_mux1h_79_nl;
  wire[0:0] COMP_LOOP_or_32_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_55_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_56_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_57_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_58_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_59_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_60_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_61_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_62_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_63_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_64_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_65_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_66_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_67_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_68_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_69_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_70_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_71_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_72_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_73_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_74_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_75_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_76_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_77_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_78_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_79_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_80_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_81_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_82_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_83_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_84_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_85_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_86_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_87_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_88_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_89_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_90_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_91_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_92_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_93_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_94_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_95_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_96_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_97_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_98_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_99_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_100_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_101_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_102_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_103_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_104_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_105_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_106_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_107_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_108_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_and_109_nl;
  wire[7:0] COMP_LOOP_and_17_nl;
  wire[7:0] COMP_LOOP_COMP_LOOP_mux_4_nl;
  wire[0:0] COMP_LOOP_nor_70_nl;
  wire[0:0] COMP_LOOP_COMP_LOOP_or_7_nl;
  wire[63:0] modExp_while_if_mux_1_nl;
  wire[0:0] and_343_nl;
  wire[0:0] mux_266_nl;
  wire[0:0] nor_161_nl;
  wire[0:0] and_344_nl;
  wire[0:0] mux_267_nl;
  wire[0:0] nor_162_nl;
  wire[0:0] nor_163_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_10_tr0 = ~ (z_out_2[64]);
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0 = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_76_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_76_tr0 = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_47_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_47_tr0
      = ~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm;
  wire [0:0] nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out[12];
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
      .modExp_while_C_47_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .COMP_LOOP_C_1_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_1_tr0[0:0]),
      .COMP_LOOP_1_modExp_1_while_C_47_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .COMP_LOOP_C_76_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_C_76_tr0[0:0]),
      .COMP_LOOP_2_modExp_1_while_C_47_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_COMP_LOOP_2_modExp_1_while_C_47_tr0[0:0]),
      .COMP_LOOP_C_152_tr0(exit_COMP_LOOP_1_modExp_1_while_sva),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_11_tr0(nl_inPlaceNTT_DIT_core_core_fsm_inst_STAGE_LOOP_C_11_tr0[0:0])
    );
  assign nor_28_cse = ~((fsm_output[4]) | (~ (fsm_output[6])));
  assign or_134_cse = (fsm_output[1:0]!=2'b00);
  assign operator_66_true_div_cmp_b = {1'b0, reg_operator_66_true_div_cmp_b_reg};
  assign and_138_m1c = and_dcpl_34 & and_dcpl_43;
  assign and_246_cse = (fsm_output[4:3]==2'b11);
  assign modExp_result_and_rgt = (~ modExp_while_and_1_itm) & and_138_m1c;
  assign modExp_result_and_1_rgt = modExp_while_and_1_itm & and_138_m1c;
  assign nor_80_nl = ~((~ (fsm_output[4])) | (~ (fsm_output[1])) | (fsm_output[6]));
  assign nor_81_nl = ~((fsm_output[4]) | (fsm_output[1]) | (~ (fsm_output[6])));
  assign mux_174_nl = MUX_s_1_2_2(nor_80_nl, nor_81_nl, fsm_output[2]);
  assign and_147_m1c = mux_174_nl & (fsm_output[3]) & (fsm_output[0]) & (fsm_output[5])
      & and_dcpl_28;
  assign and_244_cse = (fsm_output[1:0]==2'b11);
  assign or_12_cse = (fsm_output[3]) | (fsm_output[0]) | (fsm_output[1]);
  assign nor_119_cse = ~((fsm_output[3]) | (fsm_output[6]));
  assign and_241_cse = (fsm_output[3]) & (fsm_output[6]);
  assign COMP_LOOP_or_3_cse = and_dcpl_51 | and_dcpl_65;
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b0001;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_acc_psp_sva_1 = (VEC_LOOP_j_sva_11_0[11:1]) + conv_u2u_8_11(COMP_LOOP_k_9_1_sva_7_0);
  assign COMP_LOOP_acc_psp_sva_1 = nl_COMP_LOOP_acc_psp_sva_1[10:0];
  assign nl_modulo_qr_sva_1_mx0w1 = (operator_64_false_acc_mut[63:0]) + p_sva;
  assign modulo_qr_sva_1_mx0w1 = nl_modulo_qr_sva_1_mx0w1[63:0];
  assign vec_rsc_0_0_i_da_d_1 = MUX_v_64_2_2((operator_64_false_acc_mut[63:0]), modulo_qr_sva_1_mx0w1,
      operator_64_false_acc_mut[63]);
  assign nl_COMP_LOOP_1_modExp_1_while_if_mul_mut_1 = $signed(COMP_LOOP_1_acc_8_itm)
      * $signed(COMP_LOOP_1_acc_5_mut);
  assign COMP_LOOP_1_modExp_1_while_if_mul_mut_1 = nl_COMP_LOOP_1_modExp_1_while_if_mul_mut_1[63:0];
  assign operator_64_false_slc_modExp_exp_63_1_3 = MUX_v_63_2_2((operator_66_true_div_cmp_z_oreg[63:1]),
      (COMP_LOOP_1_acc_8_itm[63:1]), and_dcpl_129);
  assign modExp_1_while_and_7 = (operator_64_false_acc_mut[63]) & modExp_exp_1_0_1_sva;
  assign or_tmp_4 = (fsm_output[4]) | (fsm_output[3]) | (fsm_output[6]);
  assign not_tmp_7 = ~((fsm_output[5:4]!=2'b00));
  assign or_26_nl = (~ (fsm_output[1])) | (fsm_output[6]) | (~((fsm_output[2]) &
      (fsm_output[7])));
  assign or_24_nl = (~ (fsm_output[1])) | (fsm_output[6]) | (fsm_output[2]) | (fsm_output[7]);
  assign mux_tmp_22 = MUX_s_1_2_2(or_26_nl, or_24_nl, fsm_output[8]);
  assign mux_23_cse = MUX_s_1_2_2((fsm_output[7]), (~ (fsm_output[7])), fsm_output[2]);
  assign and_dcpl = (fsm_output[8:7]==2'b01);
  assign and_dcpl_4 = (~ (fsm_output[6])) & (fsm_output[3]);
  assign and_dcpl_5 = and_dcpl_4 & (~ (fsm_output[1]));
  assign and_dcpl_8 = (fsm_output[5]) & (~ (fsm_output[8]));
  assign or_38_cse = (fsm_output[3]) | (~ (fsm_output[6]));
  assign or_37_cse = (~ (fsm_output[3])) | (fsm_output[6]);
  assign or_39_cse = (~ (fsm_output[1])) | (~ (fsm_output[3])) | (fsm_output[6]);
  assign or_tmp_39 = (fsm_output[8:7]!=2'b01);
  assign or_308_cse = (fsm_output[4:3]!=2'b00);
  assign or_tmp_62 = and_244_cse | (fsm_output[6]) | (fsm_output[3]);
  assign or_tmp_63 = (fsm_output[6]) | (fsm_output[3]);
  assign mux_tmp_84 = MUX_s_1_2_2((fsm_output[6]), or_tmp_63, fsm_output[4]);
  assign or_305_nl = (fsm_output[7:0]!=8'b00000000);
  assign mux_83_nl = MUX_s_1_2_2((fsm_output[6]), or_tmp_62, fsm_output[4]);
  assign mux_85_nl = MUX_s_1_2_2(mux_tmp_84, mux_83_nl, fsm_output[2]);
  assign mux_86_nl = MUX_s_1_2_2((fsm_output[6]), mux_85_nl, fsm_output[5]);
  assign nor_110_nl = ~((fsm_output[7]) | mux_86_nl);
  assign not_tmp_50 = MUX_s_1_2_2(or_305_nl, nor_110_nl, fsm_output[8]);
  assign and_dcpl_28 = ~((fsm_output[8:7]!=2'b00));
  assign and_dcpl_29 = ~((fsm_output[2]) | (fsm_output[5]));
  assign and_dcpl_30 = and_dcpl_29 & and_dcpl_28;
  assign and_dcpl_31 = ~((fsm_output[0]) | (fsm_output[4]));
  assign and_dcpl_33 = nor_119_cse & (~ (fsm_output[1]));
  assign and_dcpl_34 = and_dcpl_33 & and_dcpl_31;
  assign and_dcpl_37 = (fsm_output[2]) & (fsm_output[5]);
  assign and_dcpl_38 = and_dcpl_37 & (fsm_output[8:7]==2'b10);
  assign and_dcpl_39 = (~ (fsm_output[0])) & (fsm_output[4]);
  assign and_dcpl_41 = nor_119_cse & (fsm_output[1]) & and_dcpl_39;
  assign and_dcpl_43 = and_dcpl_37 & and_dcpl_28;
  assign and_dcpl_47 = and_dcpl_5 & and_dcpl_39 & and_dcpl_43;
  assign and_dcpl_49 = and_241_cse & (fsm_output[1]);
  assign and_dcpl_50 = and_dcpl_49 & and_dcpl_31;
  assign and_dcpl_51 = and_dcpl_50 & and_dcpl_43;
  assign and_dcpl_53 = (~ (fsm_output[2])) & (fsm_output[5]);
  assign and_dcpl_54 = and_dcpl_53 & and_dcpl;
  assign and_dcpl_65 = and_dcpl_50 & and_dcpl_54;
  assign and_dcpl_69 = (fsm_output[3]) & (~ (fsm_output[0])) & and_dcpl_8;
  assign and_dcpl_80 = and_dcpl_5 & and_dcpl_31 & (fsm_output[2]) & (~ (fsm_output[5]))
      & and_dcpl_28;
  assign and_dcpl_82 = ~((fsm_output[8:6]!=3'b000));
  assign or_tmp_96 = and_244_cse | (fsm_output[3]);
  assign or_tmp_99 = (fsm_output[4]) | (or_134_cse & (fsm_output[3]));
  assign mux_103_itm = MUX_s_1_2_2((fsm_output[4]), or_tmp_99, fsm_output[2]);
  assign nor_tmp_35 = (fsm_output[1]) & (fsm_output[3]);
  assign or_tmp_106 = ~((fsm_output[2]) & (fsm_output[4]) & (fsm_output[0]) & (fsm_output[1])
      & (~ (fsm_output[6])) & (fsm_output[3]));
  assign or_127_nl = (fsm_output[0]) | (fsm_output[1]) | (~ (fsm_output[6])) | (fsm_output[3]);
  assign mux_tmp_109 = MUX_s_1_2_2((~ (fsm_output[6])), or_127_nl, fsm_output[4]);
  assign mux_tmp_110 = MUX_s_1_2_2((~ (fsm_output[6])), or_38_cse, fsm_output[4]);
  assign and_tmp_7 = (fsm_output[4]) & or_12_cse;
  assign nor_tmp_36 = (fsm_output[4]) & (fsm_output[6]);
  assign or_321_nl = (~ (fsm_output[7])) | (fsm_output[2]) | (~ (fsm_output[3]));
  assign or_322_nl = (fsm_output[7]) | (~ (fsm_output[2])) | (fsm_output[3]);
  assign mux_120_nl = MUX_s_1_2_2(or_321_nl, or_322_nl, fsm_output[8]);
  assign and_dcpl_99 = ~(mux_120_nl | (fsm_output[6]) | (fsm_output[1]) | (fsm_output[0])
      | (~ not_tmp_7));
  assign and_213_nl = (fsm_output[0]) & (fsm_output[1]) & (fsm_output[3]);
  assign mux_tmp_122 = MUX_s_1_2_2((~ (fsm_output[3])), and_213_nl, fsm_output[4]);
  assign and_tmp_10 = (fsm_output[4]) & ((fsm_output[1]) | (fsm_output[3]));
  assign and_dcpl_103 = and_dcpl_4 & (fsm_output[1]);
  assign and_dcpl_104 = and_dcpl_103 & and_dcpl_39;
  assign and_dcpl_105 = and_dcpl_104 & and_dcpl_54;
  assign or_tmp_124 = ~((fsm_output[4]) & (fsm_output[0]) & (fsm_output[1]) & (~
      (fsm_output[6])) & (fsm_output[3]));
  assign or_tmp_125 = (fsm_output[4]) | (~ (fsm_output[6]));
  assign and_dcpl_112 = (((fsm_output[2:1]!=2'b00)) ^ (fsm_output[3])) & (~ (fsm_output[6]))
      & not_tmp_7 & and_dcpl_28;
  assign or_150_nl = (fsm_output[1]) | (fsm_output[6]) | (fsm_output[3]);
  assign mux_140_nl = MUX_s_1_2_2((fsm_output[6]), or_150_nl, fsm_output[4]);
  assign mux_141_nl = MUX_s_1_2_2(mux_tmp_84, mux_140_nl, fsm_output[2]);
  assign mux_142_nl = MUX_s_1_2_2((fsm_output[6]), mux_141_nl, fsm_output[5]);
  assign or_tmp_130 = (fsm_output[7]) | mux_142_nl;
  assign and_dcpl_113 = (fsm_output[0]) & (~ (fsm_output[4]));
  assign and_dcpl_119 = and_dcpl_103 & (~((fsm_output[4]) ^ (fsm_output[5]))) & (fsm_output[0])
      & (~ (fsm_output[2])) & and_dcpl_28;
  assign and_dcpl_120 = (fsm_output[0]) & (fsm_output[4]);
  assign or_tmp_154 = (fsm_output[4]) | (fsm_output[6]);
  assign mux_tmp_170 = MUX_s_1_2_2(or_tmp_154, or_tmp_4, fsm_output[2]);
  assign and_dcpl_129 = and_dcpl_103 & and_dcpl_120 & and_dcpl_53 & and_dcpl_28;
  assign xor_dcpl_2 = (fsm_output[2]) ^ (fsm_output[7]);
  assign and_dcpl_138 = and_dcpl_5 & xor_dcpl_2 & and_dcpl_120 & and_dcpl_8;
  assign and_dcpl_140 = and_dcpl_113 & (fsm_output[5]);
  assign and_dcpl_142 = and_dcpl_49 & xor_dcpl_2;
  assign or_tmp_165 = (fsm_output[4]) | (~ (fsm_output[6])) | (fsm_output[3]);
  assign mux_tmp_180 = MUX_s_1_2_2((~ (fsm_output[6])), or_38_cse, fsm_output[1]);
  assign or_tmp_170 = and_244_cse | (~ (fsm_output[6])) | (fsm_output[3]);
  assign and_dcpl_148 = and_dcpl_29 & (fsm_output[7]);
  assign and_dcpl_152 = (~ (fsm_output[3])) & (fsm_output[6]) & (fsm_output[1]) &
      and_dcpl_39;
  assign nor_67_nl = ~((fsm_output[5:0]!=6'b010110));
  assign nor_68_nl = ~((fsm_output[5:0]!=6'b101001));
  assign mux_205_nl = MUX_s_1_2_2(nor_67_nl, nor_68_nl, fsm_output[7]);
  assign and_dcpl_158 = mux_205_nl & (fsm_output[6]) & (~ (fsm_output[8]));
  assign and_dcpl_159 = and_dcpl_5 & and_dcpl_120;
  assign and_dcpl_160 = and_dcpl_159 & and_dcpl_43;
  assign mux_tmp_207 = MUX_s_1_2_2((~ (fsm_output[6])), or_38_cse, or_134_cse);
  assign mux_208_nl = MUX_s_1_2_2(mux_tmp_207, or_39_cse, fsm_output[4]);
  assign mux_33_nl = MUX_s_1_2_2(or_38_cse, or_37_cse, fsm_output[4]);
  assign mux_209_nl = MUX_s_1_2_2(mux_208_nl, mux_33_nl, fsm_output[2]);
  assign mux_tmp_210 = MUX_s_1_2_2((~ (fsm_output[6])), mux_209_nl, fsm_output[5]);
  assign or_tmp_203 = (fsm_output[7:6]!=2'b01);
  assign or_tmp_204 = (fsm_output[7:6]!=2'b10);
  assign mux_218_nl = MUX_s_1_2_2(or_tmp_203, or_tmp_204, fsm_output[4]);
  assign mux_217_nl = MUX_s_1_2_2(or_tmp_203, (fsm_output[6]), fsm_output[4]);
  assign mux_tmp_219 = MUX_s_1_2_2(mux_218_nl, mux_217_nl, fsm_output[0]);
  assign and_dcpl_163 = and_dcpl_104 & and_dcpl_43;
  assign or_dcpl_28 = (fsm_output[8:7]!=2'b00);
  assign or_dcpl_32 = or_37_cse | (fsm_output[1]);
  assign or_dcpl_35 = ~((fsm_output[2]) & (fsm_output[5]));
  assign or_dcpl_36 = or_dcpl_35 | or_dcpl_28;
  assign or_dcpl_37 = (fsm_output[0]) | (~ (fsm_output[4]));
  assign or_tmp_225 = (fsm_output[1]) | (~ (fsm_output[6])) | (fsm_output[3]);
  assign and_dcpl_166 = and_241_cse & (~ (fsm_output[1]));
  assign or_tmp_227 = ~((fsm_output[0]) & (fsm_output[1]) & (~ (fsm_output[6])) &
      (fsm_output[3]));
  assign mux_241_nl = MUX_s_1_2_2(mux_tmp_180, or_tmp_227, fsm_output[4]);
  assign mux_242_nl = MUX_s_1_2_2(or_tmp_125, mux_241_nl, fsm_output[2]);
  assign mux_243_nl = MUX_s_1_2_2((~ (fsm_output[6])), mux_242_nl, fsm_output[5]);
  assign mux_244_nl = MUX_s_1_2_2(mux_243_nl, mux_tmp_210, fsm_output[7]);
  assign and_dcpl_169 = ~(mux_244_nl | (fsm_output[8]));
  assign and_dcpl_170 = and_dcpl_159 & and_dcpl_54;
  assign and_dcpl_171 = and_dcpl_166 & and_dcpl_113;
  assign nor_61_nl = ~((~ (fsm_output[2])) | (~ (fsm_output[4])) | (fsm_output[0])
      | (~ (fsm_output[1])) | (fsm_output[6]));
  assign nor_62_nl = ~((fsm_output[2]) | (fsm_output[4]) | (~ (fsm_output[0])) |
      (fsm_output[1]) | (~ (fsm_output[6])));
  assign mux_245_nl = MUX_s_1_2_2(nor_61_nl, nor_62_nl, fsm_output[7]);
  assign and_dcpl_175 = mux_245_nl & (fsm_output[3]) & (fsm_output[5]) & (~ (fsm_output[8]));
  assign and_dcpl_180 = (~ (fsm_output[1])) & (fsm_output[0]) & (fsm_output[4]) &
      and_dcpl_8;
  assign not_tmp_155 = ~((VEC_LOOP_j_sva_11_0[0]) & (fsm_output[2]));
  assign or_dcpl_52 = (fsm_output[2]) | (~ (fsm_output[5]));
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_41 & and_dcpl_38;
  assign operator_64_false_acc_mut_mx0c0 = and_dcpl_33 & and_dcpl_113 & and_dcpl_30;
  assign nand_14_nl = ~((~((~ (fsm_output[3])) | (fsm_output[8]) | (fsm_output[1])
      | (~ (fsm_output[6])))) & mux_23_cse);
  assign or_28_nl = (fsm_output[8]) | (~ (fsm_output[1])) | (fsm_output[6]) | (fsm_output[2])
      | (fsm_output[7]);
  assign mux_149_nl = MUX_s_1_2_2(mux_tmp_22, or_28_nl, fsm_output[3]);
  assign mux_150_nl = MUX_s_1_2_2(nand_14_nl, mux_149_nl, fsm_output[4]);
  assign nand_15_nl = ~((fsm_output[5]) & (~ mux_150_nl));
  assign or_157_nl = (fsm_output[3]) | mux_tmp_22;
  assign nand_2_nl = ~((~((fsm_output[8]) | (fsm_output[1]) | (~ (fsm_output[6]))))
      & mux_23_cse);
  assign mux_146_nl = MUX_s_1_2_2(nand_2_nl, mux_tmp_22, fsm_output[3]);
  assign mux_147_nl = MUX_s_1_2_2(or_157_nl, mux_146_nl, fsm_output[4]);
  assign or_153_nl = (fsm_output[4]) | (fsm_output[3]) | (fsm_output[8]) | (~ (fsm_output[1]))
      | (fsm_output[6]) | (fsm_output[2]) | (fsm_output[7]);
  assign mux_148_nl = MUX_s_1_2_2(mux_147_nl, or_153_nl, fsm_output[5]);
  assign mux_151_itm = MUX_s_1_2_2(nand_15_nl, mux_148_nl, fsm_output[0]);
  assign VEC_LOOP_j_sva_11_0_mx0c1 = and_dcpl_33 & and_dcpl_120 & and_dcpl_38;
  assign nor_83_nl = ~((fsm_output[7]) | (fsm_output[5]) | mux_tmp_170);
  assign modExp_result_sva_mx0c0 = MUX_s_1_2_2(nor_83_nl, or_tmp_130, fsm_output[8]);
  assign or_277_nl = (fsm_output[7]) | not_tmp_155;
  assign mux_252_nl = MUX_s_1_2_2(not_tmp_155, (fsm_output[2]), fsm_output[7]);
  assign mux_253_nl = MUX_s_1_2_2(or_277_nl, mux_252_nl, COMP_LOOP_acc_1_cse_sva[0]);
  assign tmp_2_lpi_4_dfm_mx0c1 = (~ mux_253_nl) & and_dcpl_4 & and_dcpl_180;
  assign nl_STAGE_LOOP_acc_nl = (STAGE_LOOP_i_3_0_sva_2[3:1]) + 3'b011;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[2:0];
  assign STAGE_LOOP_acc_itm_2_1 = readslicef_3_1_2(STAGE_LOOP_acc_nl);
  assign and_62_nl = and_dcpl_34 & and_dcpl_54;
  assign and_235_nl = (fsm_output[2]) & (fsm_output[7]);
  assign nor_118_nl = ~((fsm_output[2]) | (fsm_output[7]));
  assign mux_89_nl = MUX_s_1_2_2(and_235_nl, nor_118_nl, fsm_output[8]);
  assign and_67_nl = mux_89_nl & nor_119_cse & (fsm_output[1]) & (fsm_output[0])
      & (fsm_output[4]) & (fsm_output[5]);
  assign nor_107_nl = ~((~ (fsm_output[7])) | (~ (fsm_output[5])) | (fsm_output[2]));
  assign nor_108_nl = ~((fsm_output[7]) | (fsm_output[5]) | (~ (fsm_output[2])));
  assign mux_90_nl = MUX_s_1_2_2(nor_107_nl, nor_108_nl, fsm_output[8]);
  assign and_71_nl = mux_90_nl & (fsm_output[3]) & (~ (fsm_output[6])) & (~ (fsm_output[1]))
      & and_dcpl_39;
  assign vec_rsc_0_0_i_adra_d_pff = MUX1HOT_v_11_5_2(COMP_LOOP_acc_psp_sva_1, (z_out[12:2]),
      COMP_LOOP_acc_psp_sva, (COMP_LOOP_acc_10_cse_12_1_1_sva[11:1]), (COMP_LOOP_acc_1_cse_sva[11:1]),
      {and_dcpl_47 , COMP_LOOP_or_3_cse , and_62_nl , and_67_nl , and_71_nl});
  assign vec_rsc_0_0_i_da_d_pff = vec_rsc_0_0_i_da_d_1;
  assign nor_104_nl = ~((fsm_output[2:0]!=3'b000) | (VEC_LOOP_j_sva_11_0[0]) | (fsm_output[8:7]!=2'b01));
  assign or_95_nl = (fsm_output[8:7]!=2'b10);
  assign mux_91_nl = MUX_s_1_2_2(or_95_nl, or_tmp_39, fsm_output[2]);
  assign nor_105_nl = ~((fsm_output[1:0]!=2'b11) | (COMP_LOOP_acc_10_cse_12_1_1_sva[0])
      | mux_91_nl);
  assign mux_92_nl = MUX_s_1_2_2(nor_104_nl, nor_105_nl, fsm_output[4]);
  assign nand_44_nl = ~((fsm_output[5]) & mux_92_nl);
  assign or_314_nl = (fsm_output[5]) | (~ (fsm_output[4])) | (fsm_output[0]) | (fsm_output[1])
      | (~ (fsm_output[2])) | (COMP_LOOP_acc_1_cse_sva[0]) | (fsm_output[8:7]!=2'b10);
  assign mux_93_nl = MUX_s_1_2_2(nand_44_nl, or_314_nl, fsm_output[3]);
  assign vec_rsc_0_0_i_wea_d_pff = ~(mux_93_nl | (fsm_output[6]));
  assign or_102_nl = (~ (fsm_output[7])) | (~ COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm)
      | (COMP_LOOP_acc_1_cse_sva[0]);
  assign or_101_nl = (fsm_output[7]) | (VEC_LOOP_j_sva_11_0[0]);
  assign mux_95_nl = MUX_s_1_2_2(or_102_nl, or_101_nl, fsm_output[2]);
  assign nor_101_nl = ~((~ (fsm_output[4])) | (fsm_output[6]) | mux_95_nl);
  assign nor_102_nl = ~((~ (fsm_output[7])) | (z_out[1]));
  assign nor_103_nl = ~((fsm_output[7]) | (z_out[1]));
  assign mux_94_nl = MUX_s_1_2_2(nor_102_nl, nor_103_nl, fsm_output[2]);
  assign and_224_nl = nor_28_cse & mux_94_nl;
  assign mux_96_nl = MUX_s_1_2_2(nor_101_nl, and_224_nl, fsm_output[1]);
  assign vec_rsc_0_0_i_rwA_rw_ram_ir_internal_RMASK_B_d = mux_96_nl & and_dcpl_69;
  assign nor_97_nl = ~((fsm_output[2:0]!=3'b000) | (~ (VEC_LOOP_j_sva_11_0[0])) |
      (fsm_output[8:7]!=2'b01));
  assign nor_98_nl = ~((fsm_output[8:7]!=2'b10));
  assign nor_99_nl = ~((fsm_output[8:7]!=2'b01));
  assign mux_97_nl = MUX_s_1_2_2(nor_98_nl, nor_99_nl, fsm_output[2]);
  assign and_223_nl = (fsm_output[1:0]==2'b11) & (COMP_LOOP_acc_10_cse_12_1_1_sva[0])
      & mux_97_nl;
  assign mux_98_nl = MUX_s_1_2_2(nor_97_nl, and_223_nl, fsm_output[4]);
  assign nand_43_nl = ~((fsm_output[5]) & mux_98_nl);
  assign or_313_nl = (fsm_output[5]) | (~ (fsm_output[4])) | (fsm_output[0]) | (fsm_output[1])
      | (~ (fsm_output[2])) | (~ (COMP_LOOP_acc_1_cse_sva[0])) | (fsm_output[8:7]!=2'b10);
  assign mux_99_nl = MUX_s_1_2_2(nand_43_nl, or_313_nl, fsm_output[3]);
  assign vec_rsc_0_1_i_wea_d_pff = ~(mux_99_nl | (fsm_output[6]));
  assign nand_31_nl = ~((fsm_output[7]) & COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm
      & (COMP_LOOP_acc_1_cse_sva[0]));
  assign or_111_nl = (fsm_output[7]) | (~ (VEC_LOOP_j_sva_11_0[0]));
  assign mux_101_nl = MUX_s_1_2_2(nand_31_nl, or_111_nl, fsm_output[2]);
  assign nor_95_nl = ~((~ (fsm_output[4])) | (fsm_output[6]) | mux_101_nl);
  assign and_221_nl = (fsm_output[7]) & (z_out[1]);
  assign nor_96_nl = ~((fsm_output[7]) | (~ (z_out[1])));
  assign mux_100_nl = MUX_s_1_2_2(and_221_nl, nor_96_nl, fsm_output[2]);
  assign and_220_nl = nor_28_cse & mux_100_nl;
  assign mux_102_nl = MUX_s_1_2_2(nor_95_nl, and_220_nl, fsm_output[1]);
  assign vec_rsc_0_1_i_rwA_rw_ram_ir_internal_RMASK_B_d = mux_102_nl & and_dcpl_69;
  assign and_dcpl_187 = ~((fsm_output[4]) | (fsm_output[6]));
  assign or_334_nl = (~ (fsm_output[2])) | (fsm_output[7]) | (~ (fsm_output[8]));
  assign or_335_nl = (fsm_output[2]) | (~ (fsm_output[7])) | (fsm_output[8]);
  assign mux_262_nl = MUX_s_1_2_2(or_334_nl, or_335_nl, fsm_output[3]);
  assign nor_152_cse = ~(mux_262_nl | (fsm_output[5]) | (fsm_output[0]) | (fsm_output[1])
      | (~ and_dcpl_187));
  assign and_dcpl_192 = (fsm_output[4]) & (~ (fsm_output[6]));
  assign and_dcpl_198 = and_dcpl_28 & (fsm_output[5]) & (fsm_output[2]) & (~ (fsm_output[0]));
  assign and_dcpl_199 = and_dcpl_198 & (~ (fsm_output[1])) & (fsm_output[3]) & and_dcpl_192;
  assign and_dcpl_201 = nor_tmp_35 & and_dcpl_192;
  assign and_dcpl_205 = (~ (fsm_output[8])) & (fsm_output[7]) & (fsm_output[5]) &
      (~ (fsm_output[2])) & (~ (fsm_output[0]));
  assign and_dcpl_206 = and_dcpl_205 & and_dcpl_201;
  assign and_dcpl_207 = ~((fsm_output[1]) | (fsm_output[3]));
  assign and_dcpl_212 = and_dcpl_28 & (~ (fsm_output[5])) & (~ (fsm_output[2])) &
      (fsm_output[0]) & and_dcpl_207 & and_dcpl_187;
  assign and_dcpl_214 = nor_tmp_35 & (~ (fsm_output[4])) & (fsm_output[6]);
  assign and_dcpl_215 = and_dcpl_198 & and_dcpl_214;
  assign and_dcpl_216 = and_dcpl_205 & and_dcpl_214;
  assign and_dcpl_222 = (fsm_output[8]) & (~ (fsm_output[7])) & (fsm_output[5]) &
      (fsm_output[2]) & (fsm_output[0]) & and_dcpl_207 & and_dcpl_192;
  assign and_dcpl_223 = and_dcpl_198 & and_dcpl_201;
  assign and_dcpl_240 = (fsm_output[2]) & (~ (fsm_output[0]));
  assign and_dcpl_243 = and_dcpl_28 & (fsm_output[5]) & and_dcpl_240;
  assign and_dcpl_244 = and_dcpl_243 & and_dcpl_214;
  assign and_dcpl_246 = (~ (fsm_output[1])) & (fsm_output[3]);
  assign and_dcpl_248 = and_dcpl_243 & and_dcpl_246 & (fsm_output[4]) & (~ (fsm_output[6]));
  assign and_dcpl_255 = and_dcpl_28 & (~ (fsm_output[5]));
  assign and_dcpl_257 = and_dcpl_255 & and_dcpl_240 & and_dcpl_246 & and_dcpl_187;
  assign and_dcpl_262 = (~ (fsm_output[8])) & (fsm_output[7]) & (fsm_output[5]) &
      (~ (fsm_output[2])) & (~ (fsm_output[0])) & and_dcpl_214;
  assign and_dcpl_266 = and_dcpl_255 & (~ (fsm_output[2])) & (fsm_output[0]) & nor_tmp_35
      & and_dcpl_187;
  assign COMP_LOOP_or_18_itm = and_dcpl_199 | and_dcpl_206 | and_dcpl_223;
  assign COMP_LOOP_or_22_itm = and_dcpl_215 | and_dcpl_216;
  assign COMP_LOOP_nor_7_itm = ~(and_dcpl_244 | and_dcpl_248 | and_dcpl_257 | and_dcpl_262
      | and_dcpl_266);
  always @(posedge clk) begin
    if ( ~ not_tmp_50 ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( (and_dcpl_34 & and_dcpl_30) | STAGE_LOOP_i_3_0_sva_mx0c1 ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( ~ not_tmp_50 ) begin
      r_sva <= r_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= 1'b0;
      modExp_exp_1_0_1_sva <= 1'b0;
      modExp_while_and_itm <= 1'b0;
      modExp_while_and_1_itm <= 1'b0;
      modExp_exp_1_7_1_sva <= 1'b0;
      modExp_exp_1_1_1_sva <= 1'b0;
    end
    else begin
      reg_vec_rsc_triosy_0_1_obj_ld_cse <= and_dcpl_41 & and_dcpl_37 & (fsm_output[8:7]==2'b10)
          & (~ STAGE_LOOP_acc_itm_2_1);
      modExp_exp_1_0_1_sva <= (COMP_LOOP_mux1h_16_nl & (~ and_dcpl_160)) | mux_227_nl
          | (fsm_output[8]);
      modExp_while_and_itm <= (~ (modulo_result_rem_cmp_z[63])) & modExp_exp_1_0_1_sva;
      modExp_while_and_1_itm <= (modulo_result_rem_cmp_z[63]) & modExp_exp_1_0_1_sva;
      modExp_exp_1_7_1_sva <= COMP_LOOP_mux1h_23_nl & (~(and_dcpl_171 & and_dcpl_54));
      modExp_exp_1_1_1_sva <= COMP_LOOP_mux1h_40_nl & (~(and_dcpl_171 & and_dcpl_43));
    end
  end
  always @(posedge clk) begin
    modulo_result_rem_cmp_a <= MUX1HOT_v_64_13_2(z_out_3, modExp_while_if_mul_mut,
        modExp_while_mul_itm, COMP_LOOP_1_modExp_1_while_if_mul_mut_1, COMP_LOOP_1_modExp_1_while_if_mul_mut,
        COMP_LOOP_1_modExp_1_while_mul_itm, COMP_LOOP_1_mul_mut, (z_out_2[63:0]),
        COMP_LOOP_1_acc_5_mut, COMP_LOOP_1_acc_8_itm, COMP_LOOP_2_modExp_1_while_mul_mut,
        COMP_LOOP_2_modExp_1_while_if_mul_itm, COMP_LOOP_2_mul_mut, {modulo_result_or_nl
        , and_90_nl , and_93_nl , and_96_nl , and_97_nl , and_101_nl , nor_131_nl
        , and_dcpl_99 , nor_136_nl , nor_124_nl , and_117_nl , and_120_nl , mux_139_nl});
    modulo_result_rem_cmp_b <= p_sva;
    operator_66_true_div_cmp_a <= MUX_v_65_2_2(z_out, operator_64_false_acc_mut,
        and_dcpl_112);
    reg_operator_66_true_div_cmp_b_reg <= MUX_v_10_2_2(STAGE_LOOP_lshift_psp_sva_mx0w0,
        STAGE_LOOP_lshift_psp_sva, and_dcpl_112);
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(nor_85_nl, or_tmp_130, fsm_output[8]) ) begin
      STAGE_LOOP_lshift_psp_sva <= STAGE_LOOP_lshift_psp_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      operator_64_false_acc_mut <= 65'b00000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( operator_64_false_acc_mut_mx0c0 | and_dcpl_119 | (~ mux_151_itm) )
        begin
      operator_64_false_acc_mut <= MUX1HOT_v_65_3_2(z_out, ({2'b00 , operator_64_false_slc_modExp_exp_63_1_3}),
          ({1'b0 , modulo_result_rem_cmp_z}), {operator_64_false_acc_mut_mx0c0 ,
          and_dcpl_119 , (~ mux_151_itm)});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_sva_11_0 <= 12'b000000000000;
    end
    else if ( and_dcpl_119 | VEC_LOOP_j_sva_11_0_mx0c1 ) begin
      VEC_LOOP_j_sva_11_0 <= MUX_v_12_2_2(12'b000000000000, (z_out[11:0]), VEC_LOOP_j_sva_11_0_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= 8'b00000000;
    end
    else if ( MUX_s_1_2_2(nor_nl, nor_160_nl, fsm_output[7]) ) begin
      COMP_LOOP_k_9_1_sva_7_0 <= MUX_v_8_2_2(8'b00000000, (z_out_2[7:0]), or_nl);
    end
  end
  always @(posedge clk) begin
    if ( (modExp_exp_1_0_1_sva | modExp_while_and_itm | modExp_while_and_1_itm |
        modExp_result_sva_mx0c0 | (~ mux_173_nl)) & (modExp_result_sva_mx0c0 | modExp_result_and_rgt
        | modExp_result_and_1_rgt) ) begin
      modExp_result_sva <= MUX1HOT_v_64_3_2(64'b0000000000000000000000000000000000000000000000000000000000000001,
          (operator_64_false_acc_mut[63:0]), modulo_qr_sva_1_mx0w1, {modExp_result_sva_mx0c0
          , modExp_result_and_rgt , modExp_result_and_1_rgt});
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_188_nl, or_339_nl, fsm_output[8]) ) begin
      COMP_LOOP_1_acc_5_mut <= MUX1HOT_v_64_7_2(r_sva, (operator_64_false_acc_mut[63:0]),
          modulo_qr_sva_1_mx0w1, modExp_result_sva, vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d,
          (z_out_2[63:0]), {and_143_nl , COMP_LOOP_or_7_nl , COMP_LOOP_or_8_nl ,
          and_dcpl_138 , and_155_nl , and_158_nl , and_dcpl_99});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_1_acc_8_itm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( (modExp_exp_1_0_1_sva | and_dcpl_119 | and_dcpl_138 | and_dcpl_99)
        & mux_204_nl ) begin
      COMP_LOOP_1_acc_8_itm <= MUX1HOT_v_64_5_2(({1'b0 , operator_64_false_slc_modExp_exp_63_1_3}),
          64'b0000000000000000000000000000000000000000000000000000000000000001, (operator_64_false_acc_mut[63:0]),
          modulo_qr_sva_1_mx0w1, (z_out[63:0]), {and_dcpl_119 , and_dcpl_138 , COMP_LOOP_and_nl
          , COMP_LOOP_and_1_nl , and_dcpl_99});
    end
  end
  always @(posedge clk) begin
    if ( ~(mux_228_nl & and_dcpl_82) ) begin
      modExp_while_if_mul_mut <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_COMP_LOOP_1_modExp_1_while_sva <= 1'b0;
    end
    else if ( and_dcpl_80 | and_dcpl_163 | and_dcpl_65 ) begin
      exit_COMP_LOOP_1_modExp_1_while_sva <= MUX1HOT_s_1_3_2((~ (z_out_2[63])), (~
          (z_out[8])), (~ (readslicef_10_1_9(COMP_LOOP_1_acc_nl))), {and_dcpl_80
          , and_dcpl_163 , and_dcpl_65});
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_32 | (~ (fsm_output[0])) | (fsm_output[4]) | (~ (fsm_output[2]))
        | (fsm_output[5]) | or_dcpl_28) ) begin
      modExp_while_mul_itm <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_32 | or_dcpl_37 | or_dcpl_36) ) begin
      COMP_LOOP_acc_psp_sva <= COMP_LOOP_acc_psp_sva_1;
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_47 | and_dcpl_51 | and_dcpl_105 ) begin
      COMP_LOOP_1_operator_64_false_1_slc_operator_64_false_1_acc_9_1_itm <= MUX1HOT_s_1_3_2((z_out[9]),
          (z_out_2[9]), (z_out[8]), {and_dcpl_47 , and_dcpl_51 , and_dcpl_105});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_1_cse_sva <= 12'b000000000000;
    end
    else if ( MUX_s_1_2_2(nor_157_nl, or_336_nl, fsm_output[8]) ) begin
      COMP_LOOP_acc_1_cse_sva <= z_out_2[11:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_0_1_sva_1 <= 1'b0;
    end
    else if ( mux_240_nl | (fsm_output[8]) ) begin
      modExp_exp_1_0_1_sva_1 <= MUX_s_1_2_2((COMP_LOOP_k_9_1_sva_7_0[0]), modExp_exp_1_1_1_sva,
          and_182_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_6_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_169 ) begin
      modExp_exp_1_6_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[5]), modExp_exp_1_7_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[6]), {and_dcpl_160 , and_dcpl_175 , and_dcpl_170});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_5_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_169 ) begin
      modExp_exp_1_5_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[4]), modExp_exp_1_6_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[5]), {and_dcpl_160 , and_dcpl_175 , and_dcpl_170});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_4_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_169 ) begin
      modExp_exp_1_4_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[3]), modExp_exp_1_5_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[4]), {and_dcpl_160 , and_dcpl_175 , and_dcpl_170});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_3_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_169 ) begin
      modExp_exp_1_3_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[2]), modExp_exp_1_4_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[3]), {and_dcpl_160 , and_dcpl_175 , and_dcpl_170});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modExp_exp_1_2_1_sva <= 1'b0;
    end
    else if ( ~ and_dcpl_169 ) begin
      modExp_exp_1_2_1_sva <= MUX1HOT_s_1_3_2((COMP_LOOP_k_9_1_sva_7_0[1]), modExp_exp_1_3_1_sva,
          (COMP_LOOP_k_9_1_sva_7_0[2]), {and_dcpl_160 , and_dcpl_175 , and_dcpl_170});
    end
  end
  always @(posedge clk) begin
    if ( ((~ mux_251_nl) & and_dcpl_4 & and_dcpl_180) | tmp_2_lpi_4_dfm_mx0c1 ) begin
      tmp_2_lpi_4_dfm <= MUX_v_64_2_2(vec_rsc_0_0_i_qa_d, vec_rsc_0_1_i_qa_d, tmp_2_lpi_4_dfm_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( ~((~ mux_255_nl) & and_dcpl_28) ) begin
      COMP_LOOP_1_modExp_1_while_if_mul_mut <= COMP_LOOP_1_modExp_1_while_if_mul_mut_1;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_tmp_124 | or_dcpl_36) ) begin
      COMP_LOOP_1_modExp_1_while_mul_itm <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_10_cse_12_1_1_sva <= 12'b000000000000;
    end
    else if ( COMP_LOOP_or_3_cse ) begin
      COMP_LOOP_acc_10_cse_12_1_1_sva <= z_out[12:1];
    end
  end
  always @(posedge clk) begin
    if ( ~(or_tmp_225 | or_dcpl_37 | or_dcpl_52 | or_dcpl_28) ) begin
      COMP_LOOP_1_mul_mut <= COMP_LOOP_1_modExp_1_while_if_mul_mut_1;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_39_cse | or_dcpl_37 | or_dcpl_52 | or_tmp_39) ) begin
      COMP_LOOP_2_modExp_1_while_mul_mut <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( ~(mux_258_nl & and_dcpl) ) begin
      COMP_LOOP_2_modExp_1_while_if_mul_itm <= COMP_LOOP_1_modExp_1_while_if_mul_mut_1;
    end
  end
  always @(posedge clk) begin
    if ( ~((~ and_241_cse) | (fsm_output[1]) | (fsm_output[0]) | (fsm_output[4])
        | or_dcpl_35 | or_tmp_39) ) begin
      COMP_LOOP_2_mul_mut <= COMP_LOOP_1_modExp_1_while_if_mul_mut_1;
    end
  end
  assign modulo_result_or_nl = and_dcpl_80 | and_dcpl_105;
  assign nor_147_nl = ~((fsm_output[2]) | (fsm_output[4]) | or_tmp_96);
  assign mux_104_nl = MUX_s_1_2_2(mux_103_itm, nor_147_nl, fsm_output[5]);
  assign and_90_nl = mux_104_nl & and_dcpl_82;
  assign mux_105_nl = MUX_s_1_2_2((~ or_tmp_96), nor_tmp_35, fsm_output[4]);
  assign mux_106_nl = MUX_s_1_2_2(mux_105_nl, and_246_cse, fsm_output[2]);
  assign and_93_nl = (~ mux_106_nl) & (fsm_output[6:5]==2'b01) & and_dcpl_28;
  assign nor_92_nl = ~((~ (fsm_output[4])) | (fsm_output[1]) | (~ (fsm_output[6]))
      | (fsm_output[3]));
  assign and_247_nl = (fsm_output[4]) & (fsm_output[1]) & (~ (fsm_output[6])) & (fsm_output[3]);
  assign mux_107_nl = MUX_s_1_2_2(nor_92_nl, and_247_nl, fsm_output[2]);
  assign nor_94_nl = ~((~ (fsm_output[2])) | (fsm_output[4]) | (fsm_output[1]) |
      (~ and_241_cse));
  assign mux_108_nl = MUX_s_1_2_2(mux_107_nl, nor_94_nl, fsm_output[7]);
  assign and_96_nl = mux_108_nl & (~ (fsm_output[0])) & (fsm_output[5]) & (~ (fsm_output[8]));
  assign mux_111_nl = MUX_s_1_2_2(mux_tmp_110, mux_tmp_109, fsm_output[2]);
  assign mux_112_nl = MUX_s_1_2_2(mux_111_nl, or_tmp_106, fsm_output[5]);
  assign and_97_nl = (~ mux_112_nl) & and_dcpl_28;
  assign mux_114_nl = MUX_s_1_2_2(and_246_cse, and_tmp_7, fsm_output[2]);
  assign mux_113_nl = MUX_s_1_2_2((fsm_output[4]), or_308_cse, fsm_output[2]);
  assign mux_115_nl = MUX_s_1_2_2(mux_114_nl, (~ mux_113_nl), fsm_output[5]);
  assign and_101_nl = mux_115_nl & (fsm_output[8:6]==3'b001);
  assign mux_117_nl = MUX_s_1_2_2(and_241_cse, (fsm_output[6]), or_134_cse);
  assign and_102_nl = (fsm_output[4]) & mux_117_nl;
  assign mux_118_nl = MUX_s_1_2_2(and_102_nl, nor_tmp_36, fsm_output[2]);
  assign nand_45_nl = ~((fsm_output[5]) & mux_118_nl);
  assign or_131_nl = (fsm_output[4]) | or_tmp_62;
  assign mux_116_nl = MUX_s_1_2_2(or_tmp_4, or_131_nl, fsm_output[2]);
  assign or_315_nl = (fsm_output[5]) | mux_116_nl;
  assign mux_119_nl = MUX_s_1_2_2(nand_45_nl, or_315_nl, fsm_output[7]);
  assign nor_131_nl = ~(mux_119_nl | (fsm_output[8]));
  assign mux_124_nl = MUX_s_1_2_2(or_tmp_99, (~ mux_tmp_122), fsm_output[2]);
  assign nand_48_nl = ~((fsm_output[7]) & mux_124_nl);
  assign mux_121_nl = MUX_s_1_2_2((~ or_12_cse), (fsm_output[3]), fsm_output[4]);
  assign mux_123_nl = MUX_s_1_2_2(mux_tmp_122, mux_121_nl, fsm_output[2]);
  assign or_320_nl = (fsm_output[7]) | mux_123_nl;
  assign mux_125_nl = MUX_s_1_2_2(nand_48_nl, or_320_nl, fsm_output[8]);
  assign nor_136_nl = ~(mux_125_nl | (fsm_output[6:5]!=2'b00));
  assign nand_29_nl = ~((fsm_output[4:0]==5'b11111));
  assign mux_129_nl = MUX_s_1_2_2(and_246_cse, and_tmp_10, fsm_output[2]);
  assign mux_130_nl = MUX_s_1_2_2(nand_29_nl, mux_129_nl, fsm_output[5]);
  assign nand_42_nl = ~((fsm_output[7]) & (~ mux_130_nl));
  assign and_211_nl = (fsm_output[4]) & (fsm_output[0]) & (fsm_output[1]) & (fsm_output[3]);
  assign mux_127_nl = MUX_s_1_2_2(and_211_nl, and_246_cse, fsm_output[2]);
  assign mux_126_nl = MUX_s_1_2_2(and_tmp_10, (fsm_output[4]), fsm_output[2]);
  assign mux_128_nl = MUX_s_1_2_2((~ mux_127_nl), mux_126_nl, fsm_output[5]);
  assign or_312_nl = (fsm_output[7]) | mux_128_nl;
  assign mux_131_nl = MUX_s_1_2_2(nand_42_nl, or_312_nl, fsm_output[8]);
  assign nor_124_nl = ~(mux_131_nl | (fsm_output[6]));
  assign mux_133_nl = MUX_s_1_2_2(mux_tmp_109, or_tmp_125, fsm_output[2]);
  assign or_142_nl = (~ (fsm_output[4])) | (fsm_output[6]) | (~ (fsm_output[3]));
  assign mux_132_nl = MUX_s_1_2_2(or_tmp_124, or_142_nl, fsm_output[2]);
  assign mux_134_nl = MUX_s_1_2_2(mux_133_nl, mux_132_nl, fsm_output[5]);
  assign and_117_nl = (~ mux_134_nl) & and_dcpl;
  assign mux_135_nl = MUX_s_1_2_2(and_tmp_7, (fsm_output[4]), fsm_output[2]);
  assign mux_136_nl = MUX_s_1_2_2(mux_135_nl, (~ or_308_cse), fsm_output[5]);
  assign and_120_nl = mux_136_nl & (fsm_output[8:6]==3'b011);
  assign and_209_nl = or_134_cse & (fsm_output[6]) & (fsm_output[3]);
  assign mux_137_nl = MUX_s_1_2_2(and_209_nl, (fsm_output[6]), fsm_output[4]);
  assign mux_138_nl = MUX_s_1_2_2(nor_tmp_36, mux_137_nl, fsm_output[2]);
  assign and_208_nl = (fsm_output[7]) & (fsm_output[5]) & mux_138_nl;
  assign nor_86_nl = ~((fsm_output[7]) | (fsm_output[5]) | (fsm_output[2]) | (fsm_output[4])
      | or_tmp_62);
  assign mux_139_nl = MUX_s_1_2_2(and_208_nl, nor_86_nl, fsm_output[8]);
  assign COMP_LOOP_and_5_nl = (~ and_dcpl_129) & and_dcpl_119;
  assign or_225_nl = (fsm_output[0]) | (~ (fsm_output[1])) | (~ (fsm_output[6]))
      | (fsm_output[3]);
  assign mux_213_nl = MUX_s_1_2_2(or_tmp_63, or_225_nl, fsm_output[4]);
  assign mux_214_nl = MUX_s_1_2_2(or_tmp_154, mux_213_nl, fsm_output[2]);
  assign or_224_nl = (fsm_output[4]) | and_dcpl_4;
  assign mux_211_nl = MUX_s_1_2_2(mux_tmp_180, or_39_cse, fsm_output[4]);
  assign mux_212_nl = MUX_s_1_2_2(or_224_nl, mux_211_nl, fsm_output[2]);
  assign mux_215_nl = MUX_s_1_2_2((~ mux_214_nl), mux_212_nl, fsm_output[5]);
  assign mux_216_nl = MUX_s_1_2_2(mux_215_nl, mux_tmp_210, fsm_output[7]);
  assign COMP_LOOP_mux1h_16_nl = MUX1HOT_s_1_4_2((operator_66_true_div_cmp_z_oreg[0]),
      (COMP_LOOP_1_acc_8_itm[0]), modExp_exp_1_0_1_sva_1, modExp_exp_1_0_1_sva, {COMP_LOOP_and_5_nl
      , and_dcpl_129 , and_dcpl_158 , (~ mux_216_nl)});
  assign or_235_nl = (~((~ (fsm_output[4])) | (fsm_output[7]))) | (fsm_output[6]);
  assign or_233_nl = (~((~(and_244_cse | (fsm_output[4]))) | (fsm_output[7]))) |
      (fsm_output[6]);
  assign mux_225_nl = MUX_s_1_2_2(or_233_nl, or_tmp_204, fsm_output[2]);
  assign mux_226_nl = MUX_s_1_2_2(or_235_nl, mux_225_nl, fsm_output[3]);
  assign or_230_nl = (fsm_output[4]) | (~ or_tmp_204);
  assign mux_223_nl = MUX_s_1_2_2(or_230_nl, or_tmp_125, fsm_output[2]);
  assign mux_221_nl = MUX_s_1_2_2(or_tmp_125, mux_tmp_219, fsm_output[1]);
  assign or_226_nl = (~ (fsm_output[4])) | (fsm_output[6]);
  assign mux_220_nl = MUX_s_1_2_2(mux_tmp_219, or_226_nl, fsm_output[1]);
  assign mux_222_nl = MUX_s_1_2_2(mux_221_nl, mux_220_nl, fsm_output[2]);
  assign mux_224_nl = MUX_s_1_2_2(mux_223_nl, mux_222_nl, fsm_output[3]);
  assign mux_227_nl = MUX_s_1_2_2((~ mux_226_nl), mux_224_nl, fsm_output[5]);
  assign COMP_LOOP_mux1h_23_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0[6]), modExp_exp_1_1_1_sva,
      modExp_exp_1_7_1_sva, (COMP_LOOP_k_9_1_sva_7_0[7]), {and_dcpl_160 , and_dcpl_163
      , and_dcpl_169 , and_dcpl_170});
  assign mux_246_nl = MUX_s_1_2_2(mux_tmp_207, or_tmp_227, fsm_output[4]);
  assign mux_247_nl = MUX_s_1_2_2(or_tmp_125, mux_246_nl, fsm_output[2]);
  assign mux_248_nl = MUX_s_1_2_2((~ (fsm_output[6])), mux_247_nl, fsm_output[5]);
  assign mux_249_nl = MUX_s_1_2_2(mux_248_nl, mux_tmp_210, fsm_output[7]);
  assign nor_127_nl = ~(mux_249_nl | (fsm_output[8]));
  assign COMP_LOOP_mux1h_40_nl = MUX1HOT_s_1_4_2((COMP_LOOP_k_9_1_sva_7_0[7]), modExp_exp_1_2_1_sva,
      modExp_exp_1_1_1_sva, (COMP_LOOP_k_9_1_sva_7_0[1]), {and_dcpl_160 , and_dcpl_175
      , nor_127_nl , and_dcpl_170});
  assign nor_85_nl = ~((fsm_output[7:1]!=7'b0000000));
  assign or_170_nl = (fsm_output[2]) | (fsm_output[4]) | (~ nor_tmp_35);
  assign or_168_nl = (fsm_output[4:1]!=4'b1101);
  assign mux_163_nl = MUX_s_1_2_2(or_170_nl, or_168_nl, fsm_output[5]);
  assign or_167_nl = (fsm_output[5:1]!=5'b11010);
  assign mux_164_nl = MUX_s_1_2_2(mux_163_nl, or_167_nl, fsm_output[8]);
  assign or_nl = mux_164_nl | (fsm_output[6]) | (~ (fsm_output[0])) | (fsm_output[7]);
  assign or_345_nl = (fsm_output[5]) | (~ (fsm_output[1])) | (fsm_output[2]) | (~
      (fsm_output[3])) | (fsm_output[8]);
  assign nor_158_nl = ~((~ (fsm_output[2])) | (fsm_output[3]) | (~ (fsm_output[8])));
  assign nor_159_nl = ~((fsm_output[2]) | (~ (fsm_output[3])) | (fsm_output[8]));
  assign mux_nl = MUX_s_1_2_2(nor_158_nl, nor_159_nl, fsm_output[1]);
  assign nand_57_nl = ~((fsm_output[5]) & mux_nl);
  assign mux_263_nl = MUX_s_1_2_2(or_345_nl, nand_57_nl, fsm_output[4]);
  assign nor_nl = ~((~ (fsm_output[0])) | (fsm_output[6]) | mux_263_nl);
  assign nor_160_nl = ~((fsm_output[0]) | (~ (fsm_output[6])) | (fsm_output[4]) |
      (~ (fsm_output[5])) | (~ (fsm_output[1])) | (fsm_output[2]) | (~ (fsm_output[3]))
      | (fsm_output[8]));
  assign or_180_nl = (~ (fsm_output[2])) | (fsm_output[4]) | (fsm_output[0]) | (fsm_output[1])
      | (fsm_output[6]) | (fsm_output[3]);
  assign mux_172_nl = MUX_s_1_2_2(mux_tmp_170, or_180_nl, fsm_output[5]);
  assign nor_82_nl = ~((fsm_output[7]) | mux_172_nl);
  assign mux_173_nl = MUX_s_1_2_2(nor_82_nl, or_tmp_130, fsm_output[8]);
  assign and_143_nl = and_dcpl_103 & and_dcpl_113 & and_dcpl_30;
  assign COMP_LOOP_or_7_nl = ((~ (operator_64_false_acc_mut[63])) & and_147_m1c)
      | (and_dcpl_152 & and_dcpl_148 & (~ (fsm_output[8])) & (~ (operator_64_false_acc_mut[63])));
  assign COMP_LOOP_or_8_nl = ((operator_64_false_acc_mut[63]) & and_147_m1c) | (and_dcpl_152
      & and_dcpl_148 & (~ (fsm_output[8])) & (operator_64_false_acc_mut[63]));
  assign and_155_nl = and_dcpl_142 & and_dcpl_140 & (~ (fsm_output[8])) & (~ (COMP_LOOP_acc_10_cse_12_1_1_sva[0]));
  assign and_158_nl = and_dcpl_142 & and_dcpl_140 & (~ (fsm_output[8])) & (COMP_LOOP_acc_10_cse_12_1_1_sva[0]);
  assign or_337_nl = (~ (fsm_output[2])) | (fsm_output[4]) | (fsm_output[0]) | (fsm_output[1])
      | (fsm_output[6]) | (~ (fsm_output[3]));
  assign or_338_nl = (~ (fsm_output[2])) | (~ (fsm_output[4])) | (fsm_output[0])
      | (~ (fsm_output[1])) | (fsm_output[6]) | (~ (fsm_output[3]));
  assign mux_187_nl = MUX_s_1_2_2(or_337_nl, or_338_nl, fsm_output[5]);
  assign nor_77_nl = ~((~((fsm_output[1:0]!=2'b00))) | (fsm_output[6]) | (~ (fsm_output[3])));
  assign mux_184_nl = MUX_s_1_2_2(nor_77_nl, or_tmp_170, fsm_output[4]);
  assign mux_183_nl = MUX_s_1_2_2(and_dcpl_4, or_39_cse, fsm_output[4]);
  assign mux_185_nl = MUX_s_1_2_2(mux_184_nl, mux_183_nl, fsm_output[2]);
  assign or_191_nl = (fsm_output[0]) | (~ (fsm_output[1])) | (fsm_output[6]) | (~
      (fsm_output[3]));
  assign mux_181_nl = MUX_s_1_2_2(mux_tmp_180, or_191_nl, fsm_output[4]);
  assign mux_182_nl = MUX_s_1_2_2(mux_181_nl, or_tmp_165, fsm_output[2]);
  assign mux_186_nl = MUX_s_1_2_2((~ mux_185_nl), mux_182_nl, fsm_output[5]);
  assign mux_188_nl = MUX_s_1_2_2(mux_187_nl, mux_186_nl, fsm_output[7]);
  assign mux_177_nl = MUX_s_1_2_2((fsm_output[6]), or_tmp_63, fsm_output[1]);
  assign mux_178_nl = MUX_s_1_2_2(or_37_cse, mux_177_nl, fsm_output[4]);
  assign mux_175_nl = MUX_s_1_2_2(or_37_cse, (fsm_output[6]), or_134_cse);
  assign mux_176_nl = MUX_s_1_2_2(mux_175_nl, or_tmp_63, fsm_output[4]);
  assign mux_179_nl = MUX_s_1_2_2(mux_178_nl, mux_176_nl, fsm_output[2]);
  assign or_339_nl = (fsm_output[7]) | (fsm_output[5]) | mux_179_nl;
  assign COMP_LOOP_and_nl = (~ modExp_1_while_and_7) & and_dcpl_158;
  assign COMP_LOOP_and_1_nl = modExp_1_while_and_7 & and_dcpl_158;
  assign nor_69_nl = ~((fsm_output[6:5]!=2'b00));
  assign and_170_nl = (fsm_output[7]) & (fsm_output[2]) & or_134_cse & (fsm_output[5]);
  assign or_217_nl = (~((fsm_output[7]) | (~ (fsm_output[2])) | (fsm_output[0]) |
      (~ (fsm_output[1])))) | (fsm_output[5]);
  assign mux_201_nl = MUX_s_1_2_2(and_170_nl, or_217_nl, fsm_output[6]);
  assign mux_202_nl = MUX_s_1_2_2(nor_69_nl, mux_201_nl, fsm_output[4]);
  assign nor_71_nl = ~((fsm_output[2]) | (fsm_output[0]) | (fsm_output[1]) | (fsm_output[5]));
  assign mux_198_nl = MUX_s_1_2_2(and_dcpl_29, nor_71_nl, fsm_output[7]);
  assign nor_72_nl = ~((~ (fsm_output[0])) | (fsm_output[1]) | (~ (fsm_output[5])));
  assign mux_197_nl = MUX_s_1_2_2(nor_72_nl, (fsm_output[5]), fsm_output[2]);
  assign and_169_nl = (fsm_output[7]) & mux_197_nl;
  assign mux_199_nl = MUX_s_1_2_2(mux_198_nl, and_169_nl, fsm_output[6]);
  assign and_204_nl = (fsm_output[0]) & (fsm_output[1]) & (fsm_output[5]);
  assign nor_73_nl = ~((fsm_output[1]) | (~ (fsm_output[5])));
  assign mux_194_nl = MUX_s_1_2_2(and_204_nl, nor_73_nl, fsm_output[2]);
  assign nor_74_nl = ~((fsm_output[2]) | (fsm_output[1]) | (~ (fsm_output[5])));
  assign mux_195_nl = MUX_s_1_2_2(mux_194_nl, nor_74_nl, fsm_output[7]);
  assign mux_196_nl = MUX_s_1_2_2(mux_195_nl, (fsm_output[5]), fsm_output[6]);
  assign mux_200_nl = MUX_s_1_2_2(mux_199_nl, mux_196_nl, fsm_output[4]);
  assign mux_203_nl = MUX_s_1_2_2(mux_202_nl, mux_200_nl, fsm_output[3]);
  assign or_208_nl = (fsm_output[0]) | (fsm_output[1]) | (fsm_output[5]);
  assign mux_191_nl = MUX_s_1_2_2((fsm_output[5]), or_208_nl, fsm_output[2]);
  assign or_209_nl = (fsm_output[7:6]!=2'b00) | (~ mux_191_nl);
  assign or_206_nl = (fsm_output[7:6]!=2'b00) | (((fsm_output[2:0]!=3'b000)) & (fsm_output[5]));
  assign mux_192_nl = MUX_s_1_2_2(or_209_nl, or_206_nl, fsm_output[4]);
  assign or_74_nl = (fsm_output[7:6]!=2'b00);
  assign or_202_nl = (fsm_output[7:5]!=3'b000);
  assign mux_190_nl = MUX_s_1_2_2(or_74_nl, or_202_nl, fsm_output[4]);
  assign mux_193_nl = MUX_s_1_2_2(mux_192_nl, mux_190_nl, fsm_output[3]);
  assign mux_204_nl = MUX_s_1_2_2(mux_203_nl, mux_193_nl, fsm_output[8]);
  assign nor_146_nl = ~((fsm_output[4:1]!=4'b0000));
  assign mux_228_nl = MUX_s_1_2_2(mux_103_itm, nor_146_nl, fsm_output[5]);
  assign nl_COMP_LOOP_1_acc_nl = ({(z_out_2[8:0]) , 1'b0}) + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))})
      + 10'b0000000001;
  assign COMP_LOOP_1_acc_nl = nl_COMP_LOOP_1_acc_nl[9:0];
  assign mux_234_nl = MUX_s_1_2_2((fsm_output[6]), or_tmp_63, or_134_cse);
  assign and_201_nl = (fsm_output[5]) & (fsm_output[2]) & (fsm_output[4]);
  assign mux_235_nl = MUX_s_1_2_2((fsm_output[6]), mux_234_nl, and_201_nl);
  assign nor_157_nl = ~((fsm_output[7]) | mux_235_nl);
  assign and_202_nl = (fsm_output[2]) & (fsm_output[4]);
  assign mux_233_nl = MUX_s_1_2_2((fsm_output[6]), or_tmp_63, and_202_nl);
  assign or_336_nl = (fsm_output[7]) | (fsm_output[5]) | mux_233_nl;
  assign and_182_nl = and_dcpl_166 & xor_dcpl_2 & and_dcpl_113 & and_dcpl_8;
  assign mux_237_nl = MUX_s_1_2_2((~ (fsm_output[6])), or_tmp_225, fsm_output[4]);
  assign mux_238_nl = MUX_s_1_2_2(mux_tmp_110, mux_237_nl, fsm_output[2]);
  assign nand_52_nl = ~((fsm_output[2]) & (fsm_output[4]) & (fsm_output[1]) & (~
      (fsm_output[6])) & (fsm_output[3]));
  assign mux_239_nl = MUX_s_1_2_2(mux_238_nl, nand_52_nl, fsm_output[5]);
  assign mux_240_nl = MUX_s_1_2_2(mux_239_nl, mux_tmp_210, fsm_output[7]);
  assign or_276_nl = (VEC_LOOP_j_sva_11_0[0]) | (~ (fsm_output[2]));
  assign mux_250_nl = MUX_s_1_2_2(or_276_nl, (fsm_output[2]), fsm_output[7]);
  assign or_275_nl = (fsm_output[7]) | (VEC_LOOP_j_sva_11_0[0]) | (~ (fsm_output[2]));
  assign mux_251_nl = MUX_s_1_2_2(mux_250_nl, or_275_nl, COMP_LOOP_acc_1_cse_sva[0]);
  assign mux_254_nl = MUX_s_1_2_2(mux_tmp_110, or_tmp_125, fsm_output[2]);
  assign mux_255_nl = MUX_s_1_2_2(mux_254_nl, or_tmp_106, fsm_output[5]);
  assign mux_256_nl = MUX_s_1_2_2(or_tmp_170, or_37_cse, fsm_output[4]);
  assign mux_257_nl = MUX_s_1_2_2(or_tmp_165, mux_256_nl, fsm_output[2]);
  assign mux_258_nl = MUX_s_1_2_2((fsm_output[6]), (~ mux_257_nl), fsm_output[5]);
  assign COMP_LOOP_mux_12_nl = MUX_v_52_2_2((tmp_2_lpi_4_dfm[63:12]), (p_sva[63:12]),
      and_dcpl_212);
  assign COMP_LOOP_nor_64_nl = ~(and_dcpl_215 | and_dcpl_216 | and_dcpl_222);
  assign COMP_LOOP_and_14_nl = MUX_v_52_2_2(52'b0000000000000000000000000000000000000000000000000000,
      COMP_LOOP_mux_12_nl, COMP_LOOP_nor_64_nl);
  assign COMP_LOOP_COMP_LOOP_or_4_nl = MUX_v_52_2_2(COMP_LOOP_and_14_nl, 52'b1111111111111111111111111111111111111111111111111111,
      COMP_LOOP_or_18_itm);
  assign COMP_LOOP_mux1h_75_nl = MUX1HOT_v_2_3_2((tmp_2_lpi_4_dfm[11:10]), (p_sva[11:10]),
      (VEC_LOOP_j_sva_11_0[11:10]), {nor_152_cse , and_dcpl_212 , and_dcpl_222});
  assign COMP_LOOP_nor_65_nl = ~(and_dcpl_215 | and_dcpl_216);
  assign COMP_LOOP_and_15_nl = MUX_v_2_2_2(2'b00, COMP_LOOP_mux1h_75_nl, COMP_LOOP_nor_65_nl);
  assign COMP_LOOP_or_28_nl = MUX_v_2_2_2(COMP_LOOP_and_15_nl, 2'b11, COMP_LOOP_or_18_itm);
  assign COMP_LOOP_mux1h_76_nl = MUX1HOT_v_2_5_2((tmp_2_lpi_4_dfm[9:8]), ({1'b1 ,
      (~ (COMP_LOOP_k_9_1_sva_7_0[7]))}), (p_sva[9:8]), (z_out_1[9:8]), (VEC_LOOP_j_sva_11_0[9:8]),
      {nor_152_cse , and_dcpl_199 , and_dcpl_212 , COMP_LOOP_or_22_itm , and_dcpl_222});
  assign COMP_LOOP_or_30_nl = and_dcpl_206 | and_dcpl_223;
  assign COMP_LOOP_or_29_nl = MUX_v_2_2_2(COMP_LOOP_mux1h_76_nl, 2'b11, COMP_LOOP_or_30_nl);
  assign COMP_LOOP_mux1h_77_nl = MUX1HOT_v_8_7_2((tmp_2_lpi_4_dfm[7:0]), ({(~ (COMP_LOOP_k_9_1_sva_7_0[6:0]))
      , 1'b1}), ({(~ modExp_exp_1_7_1_sva) , (~ modExp_exp_1_6_1_sva) , (~ modExp_exp_1_5_1_sva)
      , (~ modExp_exp_1_4_1_sva) , (~ modExp_exp_1_3_1_sva) , (~ modExp_exp_1_2_1_sva)
      , (~ modExp_exp_1_1_1_sva) , (~ modExp_exp_1_0_1_sva_1)}), (p_sva[7:0]), (z_out_1[7:0]),
      (VEC_LOOP_j_sva_11_0[7:0]), ({(~ modExp_exp_1_1_1_sva) , (~ modExp_exp_1_7_1_sva)
      , (~ modExp_exp_1_6_1_sva) , (~ modExp_exp_1_5_1_sva) , (~ modExp_exp_1_4_1_sva)
      , (~ modExp_exp_1_3_1_sva) , (~ modExp_exp_1_2_1_sva) , (~ modExp_exp_1_0_1_sva_1)}),
      {nor_152_cse , and_dcpl_199 , and_dcpl_206 , and_dcpl_212 , COMP_LOOP_or_22_itm
      , and_dcpl_222 , and_dcpl_223});
  assign COMP_LOOP_or_31_nl = (~(and_dcpl_199 | and_dcpl_206 | and_dcpl_212 | and_dcpl_215
      | and_dcpl_216 | and_dcpl_222 | and_dcpl_223)) | nor_152_cse;
  assign COMP_LOOP_mux1h_78_nl = MUX1HOT_v_64_4_2(vec_rsc_0_0_i_da_d_1, 64'b1111111111111111111111111111111111111111111111111111111111111110,
      ({52'b1111111111111111111111111111111111111111111111111111 , (~ VEC_LOOP_j_sva_11_0)}),
      ({54'b111111111111111111111111111111111111111111111111111111 , (~ STAGE_LOOP_lshift_psp_sva)}),
      {nor_152_cse , COMP_LOOP_or_18_itm , COMP_LOOP_or_22_itm , and_dcpl_222});
  assign COMP_LOOP_not_55_nl = ~ and_dcpl_212;
  assign COMP_LOOP_nand_1_nl = ~(MUX_v_64_2_2(64'b0000000000000000000000000000000000000000000000000000000000000000,
      COMP_LOOP_mux1h_78_nl, COMP_LOOP_not_55_nl));
  assign nl_acc_nl = conv_u2u_65_66({COMP_LOOP_COMP_LOOP_or_4_nl , COMP_LOOP_or_28_nl
      , COMP_LOOP_or_29_nl , COMP_LOOP_mux1h_77_nl , COMP_LOOP_or_31_nl}) + conv_s2u_65_66({COMP_LOOP_nand_1_nl
      , 1'b1});
  assign acc_nl = nl_acc_nl[65:0];
  assign z_out = readslicef_66_65_1(acc_nl);
  assign and_342_nl = (fsm_output==9'b011101010);
  assign nl_z_out_1 = STAGE_LOOP_lshift_psp_sva + conv_u2u_9_10({COMP_LOOP_k_9_1_sva_7_0
      , and_342_nl});
  assign z_out_1 = nl_z_out_1[9:0];
  assign COMP_LOOP_COMP_LOOP_or_5_nl = (~(and_dcpl_244 | and_dcpl_248 | nor_152_cse
      | and_dcpl_262)) | and_dcpl_257 | and_dcpl_266;
  assign COMP_LOOP_mux_13_nl = MUX_s_1_2_2((tmp_2_lpi_4_dfm[63]), (~ (operator_66_true_div_cmp_z_oreg[63])),
      and_dcpl_266);
  assign COMP_LOOP_COMP_LOOP_or_6_nl = (COMP_LOOP_mux_13_nl & (~(and_dcpl_244 | and_dcpl_248
      | and_dcpl_262))) | and_dcpl_257;
  assign COMP_LOOP_mux1h_79_nl = MUX1HOT_v_63_6_2(({54'b000000000000000000000000000000000000000000000000000001
      , (~ (STAGE_LOOP_lshift_psp_sva[9:1]))}), ({51'b000000000000000000000000000000000000000000000000000
      , VEC_LOOP_j_sva_11_0}), (tmp_2_lpi_4_dfm[62:0]), (~ (operator_64_false_acc_mut[62:0])),
      ({55'b0000000000000000000000000000000000000000000000000000000 , COMP_LOOP_k_9_1_sva_7_0}),
      (~ (operator_66_true_div_cmp_z_oreg[62:0])), {and_dcpl_244 , and_dcpl_248 ,
      nor_152_cse , and_dcpl_257 , and_dcpl_262 , and_dcpl_266});
  assign COMP_LOOP_or_32_nl = (~(and_dcpl_248 | nor_152_cse | and_dcpl_257 | and_dcpl_262
      | and_dcpl_266)) | and_dcpl_244;
  assign COMP_LOOP_COMP_LOOP_and_55_nl = (vec_rsc_0_0_i_da_d_1[63]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_56_nl = (vec_rsc_0_0_i_da_d_1[62]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_57_nl = (vec_rsc_0_0_i_da_d_1[61]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_58_nl = (vec_rsc_0_0_i_da_d_1[60]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_59_nl = (vec_rsc_0_0_i_da_d_1[59]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_60_nl = (vec_rsc_0_0_i_da_d_1[58]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_61_nl = (vec_rsc_0_0_i_da_d_1[57]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_62_nl = (vec_rsc_0_0_i_da_d_1[56]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_63_nl = (vec_rsc_0_0_i_da_d_1[55]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_64_nl = (vec_rsc_0_0_i_da_d_1[54]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_65_nl = (vec_rsc_0_0_i_da_d_1[53]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_66_nl = (vec_rsc_0_0_i_da_d_1[52]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_67_nl = (vec_rsc_0_0_i_da_d_1[51]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_68_nl = (vec_rsc_0_0_i_da_d_1[50]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_69_nl = (vec_rsc_0_0_i_da_d_1[49]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_70_nl = (vec_rsc_0_0_i_da_d_1[48]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_71_nl = (vec_rsc_0_0_i_da_d_1[47]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_72_nl = (vec_rsc_0_0_i_da_d_1[46]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_73_nl = (vec_rsc_0_0_i_da_d_1[45]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_74_nl = (vec_rsc_0_0_i_da_d_1[44]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_75_nl = (vec_rsc_0_0_i_da_d_1[43]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_76_nl = (vec_rsc_0_0_i_da_d_1[42]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_77_nl = (vec_rsc_0_0_i_da_d_1[41]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_78_nl = (vec_rsc_0_0_i_da_d_1[40]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_79_nl = (vec_rsc_0_0_i_da_d_1[39]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_80_nl = (vec_rsc_0_0_i_da_d_1[38]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_81_nl = (vec_rsc_0_0_i_da_d_1[37]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_82_nl = (vec_rsc_0_0_i_da_d_1[36]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_83_nl = (vec_rsc_0_0_i_da_d_1[35]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_84_nl = (vec_rsc_0_0_i_da_d_1[34]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_85_nl = (vec_rsc_0_0_i_da_d_1[33]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_86_nl = (vec_rsc_0_0_i_da_d_1[32]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_87_nl = (vec_rsc_0_0_i_da_d_1[31]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_88_nl = (vec_rsc_0_0_i_da_d_1[30]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_89_nl = (vec_rsc_0_0_i_da_d_1[29]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_90_nl = (vec_rsc_0_0_i_da_d_1[28]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_91_nl = (vec_rsc_0_0_i_da_d_1[27]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_92_nl = (vec_rsc_0_0_i_da_d_1[26]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_93_nl = (vec_rsc_0_0_i_da_d_1[25]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_94_nl = (vec_rsc_0_0_i_da_d_1[24]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_95_nl = (vec_rsc_0_0_i_da_d_1[23]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_96_nl = (vec_rsc_0_0_i_da_d_1[22]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_97_nl = (vec_rsc_0_0_i_da_d_1[21]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_98_nl = (vec_rsc_0_0_i_da_d_1[20]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_99_nl = (vec_rsc_0_0_i_da_d_1[19]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_100_nl = (vec_rsc_0_0_i_da_d_1[18]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_101_nl = (vec_rsc_0_0_i_da_d_1[17]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_102_nl = (vec_rsc_0_0_i_da_d_1[16]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_103_nl = (vec_rsc_0_0_i_da_d_1[15]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_104_nl = (vec_rsc_0_0_i_da_d_1[14]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_105_nl = (vec_rsc_0_0_i_da_d_1[13]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_106_nl = (vec_rsc_0_0_i_da_d_1[12]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_107_nl = (vec_rsc_0_0_i_da_d_1[11]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_108_nl = (vec_rsc_0_0_i_da_d_1[10]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_and_109_nl = (vec_rsc_0_0_i_da_d_1[9]) & COMP_LOOP_nor_7_itm;
  assign COMP_LOOP_COMP_LOOP_mux_4_nl = MUX_v_8_2_2(COMP_LOOP_k_9_1_sva_7_0, (vec_rsc_0_0_i_da_d_1[8:1]),
      nor_152_cse);
  assign COMP_LOOP_nor_70_nl = ~(and_dcpl_257 | and_dcpl_262 | and_dcpl_266);
  assign COMP_LOOP_and_17_nl = MUX_v_8_2_2(8'b00000000, COMP_LOOP_COMP_LOOP_mux_4_nl,
      COMP_LOOP_nor_70_nl);
  assign COMP_LOOP_COMP_LOOP_or_7_nl = (vec_rsc_0_0_i_da_d_1[0]) | and_dcpl_244 |
      and_dcpl_248 | and_dcpl_257 | and_dcpl_262 | and_dcpl_266;
  assign nl_acc_2_nl = ({COMP_LOOP_COMP_LOOP_or_5_nl , COMP_LOOP_COMP_LOOP_or_6_nl
      , COMP_LOOP_mux1h_79_nl , COMP_LOOP_or_32_nl}) + conv_s2u_65_66({COMP_LOOP_COMP_LOOP_and_55_nl
      , COMP_LOOP_COMP_LOOP_and_56_nl , COMP_LOOP_COMP_LOOP_and_57_nl , COMP_LOOP_COMP_LOOP_and_58_nl
      , COMP_LOOP_COMP_LOOP_and_59_nl , COMP_LOOP_COMP_LOOP_and_60_nl , COMP_LOOP_COMP_LOOP_and_61_nl
      , COMP_LOOP_COMP_LOOP_and_62_nl , COMP_LOOP_COMP_LOOP_and_63_nl , COMP_LOOP_COMP_LOOP_and_64_nl
      , COMP_LOOP_COMP_LOOP_and_65_nl , COMP_LOOP_COMP_LOOP_and_66_nl , COMP_LOOP_COMP_LOOP_and_67_nl
      , COMP_LOOP_COMP_LOOP_and_68_nl , COMP_LOOP_COMP_LOOP_and_69_nl , COMP_LOOP_COMP_LOOP_and_70_nl
      , COMP_LOOP_COMP_LOOP_and_71_nl , COMP_LOOP_COMP_LOOP_and_72_nl , COMP_LOOP_COMP_LOOP_and_73_nl
      , COMP_LOOP_COMP_LOOP_and_74_nl , COMP_LOOP_COMP_LOOP_and_75_nl , COMP_LOOP_COMP_LOOP_and_76_nl
      , COMP_LOOP_COMP_LOOP_and_77_nl , COMP_LOOP_COMP_LOOP_and_78_nl , COMP_LOOP_COMP_LOOP_and_79_nl
      , COMP_LOOP_COMP_LOOP_and_80_nl , COMP_LOOP_COMP_LOOP_and_81_nl , COMP_LOOP_COMP_LOOP_and_82_nl
      , COMP_LOOP_COMP_LOOP_and_83_nl , COMP_LOOP_COMP_LOOP_and_84_nl , COMP_LOOP_COMP_LOOP_and_85_nl
      , COMP_LOOP_COMP_LOOP_and_86_nl , COMP_LOOP_COMP_LOOP_and_87_nl , COMP_LOOP_COMP_LOOP_and_88_nl
      , COMP_LOOP_COMP_LOOP_and_89_nl , COMP_LOOP_COMP_LOOP_and_90_nl , COMP_LOOP_COMP_LOOP_and_91_nl
      , COMP_LOOP_COMP_LOOP_and_92_nl , COMP_LOOP_COMP_LOOP_and_93_nl , COMP_LOOP_COMP_LOOP_and_94_nl
      , COMP_LOOP_COMP_LOOP_and_95_nl , COMP_LOOP_COMP_LOOP_and_96_nl , COMP_LOOP_COMP_LOOP_and_97_nl
      , COMP_LOOP_COMP_LOOP_and_98_nl , COMP_LOOP_COMP_LOOP_and_99_nl , COMP_LOOP_COMP_LOOP_and_100_nl
      , COMP_LOOP_COMP_LOOP_and_101_nl , COMP_LOOP_COMP_LOOP_and_102_nl , COMP_LOOP_COMP_LOOP_and_103_nl
      , COMP_LOOP_COMP_LOOP_and_104_nl , COMP_LOOP_COMP_LOOP_and_105_nl , COMP_LOOP_COMP_LOOP_and_106_nl
      , COMP_LOOP_COMP_LOOP_and_107_nl , COMP_LOOP_COMP_LOOP_and_108_nl , COMP_LOOP_COMP_LOOP_and_109_nl
      , COMP_LOOP_and_17_nl , COMP_LOOP_COMP_LOOP_or_7_nl , 1'b1});
  assign acc_2_nl = nl_acc_2_nl[65:0];
  assign z_out_2 = readslicef_66_65_1(acc_2_nl);
  assign nor_161_nl = ~((fsm_output[1]) | (~ (fsm_output[0])) | (~ (fsm_output[2]))
      | (fsm_output[5]) | (fsm_output[7]));
  assign nor_162_nl = ~((fsm_output[2]) | (~((fsm_output[5]) & (fsm_output[7]))));
  assign nor_163_nl = ~((~ (fsm_output[2])) | (~ (fsm_output[5])) | (fsm_output[7]));
  assign mux_267_nl = MUX_s_1_2_2(nor_162_nl, nor_163_nl, fsm_output[0]);
  assign and_344_nl = (fsm_output[1]) & mux_267_nl;
  assign mux_266_nl = MUX_s_1_2_2(nor_161_nl, and_344_nl, fsm_output[4]);
  assign and_343_nl = mux_266_nl & (~ (fsm_output[8])) & (fsm_output[3]) & (~ (fsm_output[6]));
  assign modExp_while_if_mux_1_nl = MUX_v_64_2_2(modExp_result_sva, COMP_LOOP_1_acc_5_mut,
      and_343_nl);
  assign nl_z_out_3 = $signed(conv_u2s_64_65(modExp_while_if_mux_1_nl)) * $signed(COMP_LOOP_1_acc_5_mut);
  assign z_out_3 = nl_z_out_3[63:0];

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


  function automatic [63:0] MUX1HOT_v_64_13_2;
    input [63:0] input_12;
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
    input [12:0] sel;
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
    result = result | ( input_12 & {64{sel[12]}});
    MUX1HOT_v_64_13_2 = result;
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


  function automatic [7:0] MUX1HOT_v_8_7_2;
    input [7:0] input_6;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [6:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    result = result | ( input_3 & {8{sel[3]}});
    result = result | ( input_4 & {8{sel[4]}});
    result = result | ( input_5 & {8{sel[5]}});
    result = result | ( input_6 & {8{sel[6]}});
    MUX1HOT_v_8_7_2 = result;
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


  function automatic [51:0] MUX_v_52_2_2;
    input [51:0] input_0;
    input [51:0] input_1;
    input [0:0] sel;
    reg [51:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_52_2_2 = result;
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
  wire [64:0] operator_66_true_div_cmp_a;
  wire [10:0] operator_66_true_div_cmp_b;
  wire [64:0] operator_66_true_div_cmp_z;
  wire [10:0] vec_rsc_0_0_i_adra_d_iff;
  wire [63:0] vec_rsc_0_0_i_da_d_iff;
  wire vec_rsc_0_0_i_wea_d_iff;
  wire vec_rsc_0_1_i_wea_d_iff;


  // Interconnect Declarations for Component Instantiations 
  mgc_div #(.width_a(32'sd65),
  .width_b(32'sd11),
  .signd(32'sd1)) operator_66_true_div_cmp (
      .a(operator_66_true_div_cmp_a),
      .b(operator_66_true_div_cmp_b),
      .z(operator_66_true_div_cmp_z)
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
      .operator_66_true_div_cmp_a(operator_66_true_div_cmp_a),
      .operator_66_true_div_cmp_b(operator_66_true_div_cmp_b),
      .operator_66_true_div_cmp_z(operator_66_true_div_cmp_z),
      .vec_rsc_0_0_i_adra_d_pff(vec_rsc_0_0_i_adra_d_iff),
      .vec_rsc_0_0_i_da_d_pff(vec_rsc_0_0_i_da_d_iff),
      .vec_rsc_0_0_i_wea_d_pff(vec_rsc_0_0_i_wea_d_iff),
      .vec_rsc_0_1_i_wea_d_pff(vec_rsc_0_1_i_wea_d_iff)
    );
endmodule



