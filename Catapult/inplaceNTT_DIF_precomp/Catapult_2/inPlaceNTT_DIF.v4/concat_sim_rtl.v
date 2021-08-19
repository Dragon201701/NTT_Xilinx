
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

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_shift_bl_beh_v5.v 
module mgc_shift_bl_v5(a,s,z);
   parameter    width_a = 4;
   parameter    signd_a = 1;
   parameter    width_s = 2;
   parameter    width_z = 8;

   input [width_a-1:0] a;
   input [width_s-1:0] s;
   output [width_z -1:0] z;

   generate if ( signd_a )
   begin: SGNED
     assign z = fshl_s(a,s,a[width_a-1]);
   end
   else
   begin: UNSGNED
     assign z = fshl_s(a,s,1'b0);
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

   //Shift right - unsigned shift argument
   function [width_z-1:0] fshr_u;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      parameter olen = width_z;
      parameter ilen = signd_a ? width_a : width_a+1;
      parameter len = (ilen >= olen) ? ilen : olen;
      reg signed [len-1:0] result;
      reg signed [len-1:0] result_t;
      begin
        result_t = $signed( {(len){sbit}} );
        result_t[width_a-1:0] = arg1;
        result = result_t >>> arg2;
        fshr_u =  result[olen-1:0];
      end
   endfunction // fshl_u

   //Shift left - signed shift argument
   function [width_z-1:0] fshl_s;
      input [width_a-1:0] arg1;
      input [width_s-1:0] arg2;
      input sbit;
      reg [width_a:0] sbit_arg1;
      begin
        // Ignoring the possibility that arg2[width_s-1] could be X
        // because of customer complaints regarding X'es in simulation results
        if ( arg2[width_s-1] == 1'b0 )
        begin
          sbit_arg1[width_a:0] = {(width_a+1){1'b0}};
          fshl_s = fshl_u(arg1, arg2, sbit);
        end
        else
        begin
          sbit_arg1[width_a] = sbit;
          sbit_arg1[width_a-1:0] = arg1;
          fshl_s = fshr_u(sbit_arg1[width_a:1], ~arg2, sbit);
        end
      end
   endfunction

endmodule

//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Wed Aug 18 21:23:58 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_ccs_sample_mem_ccs_ram_sync_1R1W_rport_4_64_10_1024_1024_64_5_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_ccs_sample_mem_ccs_ram_sync_1R1W_rport_4_64_10_1024_1024_64_5_gen
    (
  q, re, radr, radr_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output re;
  output [9:0] radr;
  input [9:0] radr_d;
  input re_d;
  output [63:0] q_d;
  input port_0_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign re = (port_0_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_1_64_10_1024_1024_64_5_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_1_64_10_1024_1024_64_5_gen
    (
  we, d, wadr, q, re, radr, radr_d, wadr_d, d_d, we_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d,
      port_1_w_ram_ir_internal_WMASK_B_d
);
  output we;
  output [63:0] d;
  output [9:0] wadr;
  input [63:0] q;
  output re;
  output [9:0] radr;
  input [9:0] radr_d;
  input [9:0] wadr_d;
  input [63:0] d_d;
  input we_d;
  input re_d;
  output [63:0] q_d;
  input port_0_r_ram_ir_internal_RMASK_B_d;
  input port_1_w_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign we = (port_1_w_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign wadr = (wadr_d);
  assign q_d = q;
  assign re = (port_0_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIF_core_core_fsm (
  clk, rst, fsm_output, COMP_LOOP_C_79_tr0, VEC_LOOP_C_0_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
  input COMP_LOOP_C_79_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIF_core_core_fsm_1
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
    COMP_LOOP_C_78 = 7'd80,
    COMP_LOOP_C_79 = 7'd81,
    VEC_LOOP_C_0 = 7'd82,
    STAGE_LOOP_C_1 = 7'd83,
    main_C_1 = 7'd84;

  reg [6:0] state_var;
  reg [6:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIF_core_core_fsm_1
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
        state_var_NS = COMP_LOOP_C_39;
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
        state_var_NS = COMP_LOOP_C_78;
      end
      COMP_LOOP_C_78 : begin
        fsm_output = 7'b1010000;
        state_var_NS = COMP_LOOP_C_79;
      end
      COMP_LOOP_C_79 : begin
        fsm_output = 7'b1010001;
        if ( COMP_LOOP_C_79_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 7'b1010010;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 7'b1010011;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b1010100;
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
//  Design Unit:    inPlaceNTT_DIF_core
// ------------------------------------------------------------------


module inPlaceNTT_DIF_core (
  clk, rst, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_triosy_lz, twiddle_rsc_triosy_lz,
      vec_rsci_radr_d, vec_rsci_wadr_d, vec_rsci_d_d, vec_rsci_q_d, twiddle_rsci_radr_d,
      twiddle_rsci_q_d, vec_rsci_we_d_pff, vec_rsci_re_d_pff, twiddle_rsci_re_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_lz;
  output [9:0] vec_rsci_radr_d;
  output [9:0] vec_rsci_wadr_d;
  output [63:0] vec_rsci_d_d;
  input [63:0] vec_rsci_q_d;
  output [9:0] twiddle_rsci_radr_d;
  input [63:0] twiddle_rsci_q_d;
  output vec_rsci_we_d_pff;
  output vec_rsci_re_d_pff;
  output twiddle_rsci_re_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  reg [63:0] modulo_dev_result_rem_cmp_a;
  reg [63:0] modulo_dev_result_rem_cmp_b;
  wire [63:0] modulo_dev_result_rem_cmp_z;
  wire [6:0] fsm_output;
  wire not_tmp_3;
  wire and_dcpl_3;
  wire and_dcpl_4;
  wire and_dcpl_6;
  wire and_dcpl_7;
  wire and_dcpl_9;
  wire and_dcpl_12;
  wire or_dcpl;
  wire mux_tmp_11;
  wire mux_tmp_12;
  wire and_dcpl_14;
  wire and_dcpl_16;
  wire not_tmp_23;
  wire or_tmp_14;
  wire or_tmp_15;
  wire and_dcpl_26;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire or_dcpl_4;
  wire or_dcpl_7;
  wire or_dcpl_8;
  wire and_dcpl_35;
  reg exit_COMP_LOOP_sva;
  wire [10:0] VEC_LOOP_j_10_0_sva_2;
  wire [11:0] nl_VEC_LOOP_j_10_0_sva_2;
  wire and_50_cse;
  reg reg_twiddle_rsc_triosy_obj_ld_cse;
  reg [9:0] COMP_LOOP_acc_1_cse_sva;
  wire [10:0] nl_COMP_LOOP_acc_1_cse_sva;
  reg [9:0] COMP_LOOP_acc_10_cse_10_1_sva;
  reg [63:0] COMP_LOOP_acc_8_itm;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [9:0] COMP_LOOP_k_10_0_sva_9_0;
  wire [10:0] z_out;
  wire and_dcpl_65;
  wire [63:0] z_out_1;
  wire [127:0] nl_z_out_1;
  reg [63:0] p_sva;
  reg [10:0] STAGE_LOOP_lshift_psp_sva;
  reg [63:0] COMP_LOOP_acc_6_mut;
  reg [63:0] COMP_LOOP_tmp_asn_itm;
  reg [9:0] VEC_LOOP_j_10_0_sva_9_0;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire [63:0] COMP_LOOP_acc_6_mut_mx0w0;
  wire [64:0] nl_COMP_LOOP_acc_6_mut_mx0w0;
  wire VEC_LOOP_j_10_0_sva_9_0_mx0c0;
  wire [10:0] COMP_LOOP_k_10_0_sva_2;
  wire [11:0] nl_COMP_LOOP_k_10_0_sva_2;
  wire COMP_LOOP_acc_6_mut_mx0c2;
  wire COMP_LOOP_acc_8_itm_mx0c1;
  wire mux_32_cse;
  wire [9:0] COMP_LOOP_acc_10_itm_10_1_1;
  wire STAGE_LOOP_acc_itm_4_1;

  wire[0:0] and_16_nl;
  wire[0:0] mux_21_nl;
  wire[0:0] mux_20_nl;
  wire[0:0] mux_19_nl;
  wire[0:0] mux_18_nl;
  wire[0:0] and_49_nl;
  wire[0:0] or_15_nl;
  wire[0:0] nand_3_nl;
  wire[0:0] or_13_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_29_nl;
  wire[0:0] mux_28_nl;
  wire[0:0] mux_27_nl;
  wire[0:0] mux_26_nl;
  wire[0:0] mux_25_nl;
  wire[0:0] mux_24_nl;
  wire[0:0] mux_23_nl;
  wire[0:0] mux_22_nl;
  wire[0:0] VEC_LOOP_j_not_1_nl;
  wire[0:0] or_22_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] nand_nl;
  wire[0:0] mux_31_nl;
  wire[0:0] and_nl;
  wire[0:0] nor_22_nl;
  wire[0:0] nor_28_nl;
  wire[10:0] COMP_LOOP_acc_nl;
  wire[11:0] nl_COMP_LOOP_acc_nl;
  wire[63:0] COMP_LOOP_acc_8_nl;
  wire[64:0] nl_COMP_LOOP_acc_8_nl;
  wire[10:0] COMP_LOOP_acc_10_nl;
  wire[12:0] nl_COMP_LOOP_acc_10_nl;
  wire[0:0] or_8_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] mux_30_nl;
  wire[0:0] nor_12_nl;
  wire[0:0] nor_13_nl;
  wire[63:0] COMP_LOOP_mux_7_nl;
  wire[63:0] COMP_LOOP_mux_8_nl;

  // Interconnect Declarations for Component Instantiations 
  wire[3:0] STAGE_LOOP_mux_nl;
  wire[3:0] COMP_LOOP_tmp_acc_nl;
  wire[4:0] nl_COMP_LOOP_tmp_acc_nl;
  wire[0:0] and_62_nl;
  wire [4:0] nl_COMP_LOOP_tmp_lshift_rg_s;
  assign nl_COMP_LOOP_tmp_acc_nl = (~ STAGE_LOOP_i_3_0_sva) + 4'b1011;
  assign COMP_LOOP_tmp_acc_nl = nl_COMP_LOOP_tmp_acc_nl[3:0];
  assign and_62_nl = (fsm_output==7'b0000010);
  assign STAGE_LOOP_mux_nl = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, COMP_LOOP_tmp_acc_nl,
      and_62_nl);
  assign nl_COMP_LOOP_tmp_lshift_rg_s = {1'b0, STAGE_LOOP_mux_nl};
  wire [0:0] nl_inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = VEC_LOOP_j_10_0_sva_2[10];
  wire [0:0] nl_inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ STAGE_LOOP_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_obj (
      .ld(reg_twiddle_rsc_triosy_obj_ld_cse),
      .lz(vec_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) p_rsc_triosy_obj (
      .ld(reg_twiddle_rsc_triosy_obj_ld_cse),
      .lz(p_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(reg_twiddle_rsc_triosy_obj_ld_cse),
      .lz(r_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_obj (
      .ld(reg_twiddle_rsc_triosy_obj_ld_cse),
      .lz(twiddle_rsc_triosy_lz)
    );
  mgc_rem #(.width_a(32'sd64),
  .width_b(32'sd64),
  .signd(32'sd0)) modulo_dev_result_rem_cmp (
      .a(modulo_dev_result_rem_cmp_a),
      .b(modulo_dev_result_rem_cmp_b),
      .z(modulo_dev_result_rem_cmp_z)
    );
  mgc_shift_bl_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd5),
  .width_z(32'sd11)) COMP_LOOP_tmp_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_tmp_lshift_rg_s[4:0]),
      .z(z_out)
    );
  inPlaceNTT_DIF_core_core_fsm inPlaceNTT_DIF_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .COMP_LOOP_C_79_tr0(exit_COMP_LOOP_sva),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign and_50_cse = (fsm_output[2:1]==2'b11);
  assign or_22_nl = (fsm_output[1]) | (fsm_output[2]) | (fsm_output[3]) | (fsm_output[5]);
  assign mux_32_cse = MUX_s_1_2_2((fsm_output[5]), or_22_nl, fsm_output[4]);
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b1111;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_COMP_LOOP_acc_6_mut_mx0w0 = vec_rsci_q_d - COMP_LOOP_acc_6_mut;
  assign COMP_LOOP_acc_6_mut_mx0w0 = nl_COMP_LOOP_acc_6_mut_mx0w0[63:0];
  assign nl_COMP_LOOP_acc_10_nl = STAGE_LOOP_lshift_psp_sva + conv_u2u_10_11(VEC_LOOP_j_10_0_sva_9_0)
      + conv_u2u_10_11(COMP_LOOP_k_10_0_sva_9_0);
  assign COMP_LOOP_acc_10_nl = nl_COMP_LOOP_acc_10_nl[10:0];
  assign COMP_LOOP_acc_10_itm_10_1_1 = readslicef_11_10_1(COMP_LOOP_acc_10_nl);
  assign nl_COMP_LOOP_k_10_0_sva_2 = conv_u2u_10_11(COMP_LOOP_k_10_0_sva_9_0) + 11'b00000000001;
  assign COMP_LOOP_k_10_0_sva_2 = nl_COMP_LOOP_k_10_0_sva_2[10:0];
  assign nl_VEC_LOOP_j_10_0_sva_2 = conv_u2u_10_11(VEC_LOOP_j_10_0_sva_9_0) + STAGE_LOOP_lshift_psp_sva;
  assign VEC_LOOP_j_10_0_sva_2 = nl_VEC_LOOP_j_10_0_sva_2[10:0];
  assign not_tmp_3 = ~((fsm_output[5:1]!=5'b00000));
  assign and_dcpl_3 = ~((fsm_output[4]) | (fsm_output[6]));
  assign and_dcpl_4 = and_dcpl_3 & (~ (fsm_output[0]));
  assign and_dcpl_6 = ~((fsm_output[5]) | (fsm_output[3]));
  assign and_dcpl_7 = and_dcpl_6 & (fsm_output[2:1]==2'b00);
  assign and_dcpl_9 = (fsm_output[4]) & (fsm_output[6]);
  assign and_dcpl_12 = and_dcpl_6 & (fsm_output[2:1]==2'b01);
  assign or_dcpl = (fsm_output[5]) | (fsm_output[3]);
  assign or_8_nl = or_dcpl | (fsm_output[2]);
  assign mux_tmp_11 = MUX_s_1_2_2((fsm_output[5]), or_8_nl, fsm_output[4]);
  assign mux_tmp_12 = MUX_s_1_2_2(not_tmp_3, mux_tmp_11, fsm_output[6]);
  assign and_dcpl_14 = (fsm_output[2:1]==2'b10);
  assign and_dcpl_16 = and_dcpl_6 & and_dcpl_14 & and_dcpl_4;
  assign not_tmp_23 = ~((fsm_output[4:3]!=2'b00));
  assign or_tmp_14 = (~ (fsm_output[3])) | (fsm_output[5]);
  assign or_tmp_15 = (fsm_output[3]) | (~ (fsm_output[5]));
  assign and_dcpl_26 = and_dcpl_6 & (~ (fsm_output[2]));
  assign and_dcpl_28 = and_dcpl_9 & (~ (fsm_output[0]));
  assign and_dcpl_29 = and_dcpl_7 & and_dcpl_28;
  assign and_dcpl_30 = and_dcpl_3 & (fsm_output[0]);
  assign and_dcpl_31 = and_dcpl_12 & and_dcpl_30;
  assign or_dcpl_4 = (fsm_output[4]) | (fsm_output[6]);
  assign or_dcpl_7 = or_dcpl | (fsm_output[2:1]!=2'b01);
  assign or_dcpl_8 = or_dcpl_7 | or_dcpl_4 | (fsm_output[0]);
  assign and_dcpl_35 = (fsm_output[4]) & (~ (fsm_output[6]));
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_12 & and_dcpl_9 & (fsm_output[0]);
  assign VEC_LOOP_j_10_0_sva_9_0_mx0c0 = and_dcpl_7 & and_dcpl_30;
  assign COMP_LOOP_acc_6_mut_mx0c2 = (~ (fsm_output[5])) & (fsm_output[3]) & and_dcpl_14
      & and_dcpl_35 & (fsm_output[0]);
  assign COMP_LOOP_acc_8_itm_mx0c1 = (fsm_output[5]) & (~ (fsm_output[3])) & (fsm_output[2])
      & (fsm_output[1]) & and_dcpl_35 & (~ (fsm_output[0]));
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ STAGE_LOOP_i_3_0_sva_2)}) + 5'b00001;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign vec_rsci_radr_d = MUX_v_10_2_2(COMP_LOOP_acc_10_itm_10_1_1, COMP_LOOP_acc_1_cse_sva,
      and_dcpl_31);
  assign vec_rsci_wadr_d = MUX_v_10_2_2(COMP_LOOP_acc_10_cse_10_1_sva, COMP_LOOP_acc_1_cse_sva,
      and_dcpl_29);
  assign vec_rsci_d_d = MUX_v_64_2_2(modulo_dev_result_rem_cmp_z, COMP_LOOP_acc_8_itm,
      and_dcpl_29);
  assign nor_12_nl = ~((fsm_output[4:1]!=4'b1000));
  assign nor_13_nl = ~((fsm_output[4:1]!=4'b0111));
  assign mux_30_nl = MUX_s_1_2_2(nor_12_nl, nor_13_nl, fsm_output[0]);
  assign vec_rsci_we_d_pff = mux_30_nl & (fsm_output[6:5]==2'b10);
  assign vec_rsci_re_d_pff = and_dcpl_26 & (fsm_output[1]) & (~ (fsm_output[4]))
      & (~ (fsm_output[6]));
  assign twiddle_rsci_re_d_pff = and_dcpl_12 & and_dcpl_4;
  assign and_dcpl_65 = ~((fsm_output!=7'b0000010));
  assign twiddle_rsci_radr_d = z_out_1[9:0];
  always @(posedge clk) begin
    if ( rst ) begin
      STAGE_LOOP_i_3_0_sva <= 4'b0000;
    end
    else if ( (and_dcpl_7 & and_dcpl_4) | STAGE_LOOP_i_3_0_sva_mx0c1 ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b1010, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      p_sva <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( MUX_s_1_2_2(mux_tmp_12, and_16_nl, fsm_output[0]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      modulo_dev_result_rem_cmp_b <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      modulo_dev_result_rem_cmp_a <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      reg_twiddle_rsc_triosy_obj_ld_cse <= 1'b0;
    end
    else begin
      modulo_dev_result_rem_cmp_b <= p_sva;
      modulo_dev_result_rem_cmp_a <= MUX1HOT_v_64_3_2(COMP_LOOP_acc_6_mut_mx0w0,
          COMP_LOOP_acc_6_mut, COMP_LOOP_acc_8_itm, {and_dcpl_16 , (~ mux_21_nl)
          , nor_nl});
      reg_twiddle_rsc_triosy_obj_ld_cse <= and_dcpl_12 & and_dcpl_9 & (fsm_output[0])
          & (~ STAGE_LOOP_acc_itm_4_1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      VEC_LOOP_j_10_0_sva_9_0 <= 10'b0000000000;
    end
    else if ( VEC_LOOP_j_10_0_sva_9_0_mx0c0 | (and_dcpl_12 & and_dcpl_28) ) begin
      VEC_LOOP_j_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (VEC_LOOP_j_10_0_sva_2[9:0]),
          VEC_LOOP_j_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      STAGE_LOOP_lshift_psp_sva <= 11'b00000000000;
    end
    else if ( MUX_s_1_2_2(mux_tmp_12, mux_33_nl, fsm_output[0]) ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_k_10_0_sva_9_0 <= 10'b0000000000;
    end
    else if ( MUX_s_1_2_2(nor_28_nl, mux_32_cse, fsm_output[6]) ) begin
      COMP_LOOP_k_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (COMP_LOOP_k_10_0_sva_2[9:0]),
          nand_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_COMP_LOOP_sva <= 1'b0;
    end
    else if ( ~ or_dcpl_8 ) begin
      exit_COMP_LOOP_sva <= ~ (readslicef_11_1_10(COMP_LOOP_acc_nl));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_1_cse_sva <= 10'b0000000000;
    end
    else if ( ~ or_dcpl_8 ) begin
      COMP_LOOP_acc_1_cse_sva <= nl_COMP_LOOP_acc_1_cse_sva[9:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_10_cse_10_1_sva <= 10'b0000000000;
    end
    else if ( ~ or_dcpl_8 ) begin
      COMP_LOOP_acc_10_cse_10_1_sva <= COMP_LOOP_acc_10_itm_10_1_1;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_tmp_asn_itm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~(or_dcpl_7 | or_dcpl_4 | (~ (fsm_output[0]))) ) begin
      COMP_LOOP_tmp_asn_itm <= twiddle_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_6_mut <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_dcpl_31 | and_dcpl_16 | COMP_LOOP_acc_6_mut_mx0c2 ) begin
      COMP_LOOP_acc_6_mut <= MUX1HOT_v_64_3_2(vec_rsci_q_d, COMP_LOOP_acc_6_mut_mx0w0,
          z_out_1, {and_dcpl_31 , and_dcpl_16 , COMP_LOOP_acc_6_mut_mx0c2});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COMP_LOOP_acc_8_itm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_dcpl_16 | COMP_LOOP_acc_8_itm_mx0c1 ) begin
      COMP_LOOP_acc_8_itm <= MUX_v_64_2_2(COMP_LOOP_acc_8_nl, modulo_dev_result_rem_cmp_z,
          COMP_LOOP_acc_8_itm_mx0c1);
    end
  end
  assign and_16_nl = (fsm_output[6]) & mux_tmp_11;
  assign and_49_nl = (fsm_output[4:3]==2'b11);
  assign or_15_nl = (fsm_output[1:0]!=2'b00);
  assign mux_18_nl = MUX_s_1_2_2(not_tmp_23, and_49_nl, or_15_nl);
  assign mux_19_nl = MUX_s_1_2_2(not_tmp_23, mux_18_nl, fsm_output[2]);
  assign nand_3_nl = ~((and_50_cse | (fsm_output[3])) & (fsm_output[4]));
  assign mux_20_nl = MUX_s_1_2_2(mux_19_nl, nand_3_nl, fsm_output[5]);
  assign or_13_nl = (fsm_output[5]) | ((fsm_output[3:0]==4'b1111)) | (fsm_output[4]);
  assign mux_21_nl = MUX_s_1_2_2(mux_20_nl, or_13_nl, fsm_output[6]);
  assign mux_27_nl = MUX_s_1_2_2(or_tmp_15, or_tmp_14, and_50_cse);
  assign mux_28_nl = MUX_s_1_2_2((~ (fsm_output[5])), mux_27_nl, fsm_output[4]);
  assign mux_23_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[3]);
  assign mux_24_nl = MUX_s_1_2_2(or_tmp_15, mux_23_nl, fsm_output[2]);
  assign mux_22_nl = MUX_s_1_2_2(or_tmp_15, or_tmp_14, fsm_output[2]);
  assign mux_25_nl = MUX_s_1_2_2(mux_24_nl, mux_22_nl, fsm_output[1]);
  assign mux_26_nl = MUX_s_1_2_2((~ (fsm_output[5])), mux_25_nl, fsm_output[4]);
  assign mux_29_nl = MUX_s_1_2_2(mux_28_nl, mux_26_nl, fsm_output[0]);
  assign nor_nl = ~(mux_29_nl | (fsm_output[6]));
  assign VEC_LOOP_j_not_1_nl = ~ VEC_LOOP_j_10_0_sva_9_0_mx0c0;
  assign mux_33_nl = MUX_s_1_2_2(not_tmp_3, mux_32_cse, fsm_output[6]);
  assign and_nl = (fsm_output[6]) & (fsm_output[1]) & (fsm_output[4]);
  assign nor_22_nl = ~((fsm_output[6]) | (fsm_output[4]) | (fsm_output[1]));
  assign mux_31_nl = MUX_s_1_2_2(and_nl, nor_22_nl, fsm_output[0]);
  assign nand_nl = ~(mux_31_nl & and_dcpl_26);
  assign nor_28_nl = ~((fsm_output[4]) | ((fsm_output[1:0]==2'b11)) | (fsm_output[2])
      | (fsm_output[3]) | (fsm_output[5]));
  assign nl_COMP_LOOP_acc_nl = COMP_LOOP_k_10_0_sva_2 + ({1'b1 , (~ (STAGE_LOOP_lshift_psp_sva[10:1]))})
      + 11'b00000000001;
  assign COMP_LOOP_acc_nl = nl_COMP_LOOP_acc_nl[10:0];
  assign nl_COMP_LOOP_acc_1_cse_sva  = VEC_LOOP_j_10_0_sva_9_0 + COMP_LOOP_k_10_0_sva_9_0;
  assign nl_COMP_LOOP_acc_8_nl = vec_rsci_q_d + COMP_LOOP_acc_6_mut;
  assign COMP_LOOP_acc_8_nl = nl_COMP_LOOP_acc_8_nl[63:0];
  assign COMP_LOOP_mux_7_nl = MUX_v_64_2_2(COMP_LOOP_tmp_asn_itm, ({54'b000000000000000000000000000000000000000000000000000000
      , (z_out[9:0])}), and_dcpl_65);
  assign COMP_LOOP_mux_8_nl = MUX_v_64_2_2(modulo_dev_result_rem_cmp_z, ({54'b000000000000000000000000000000000000000000000000000000
      , COMP_LOOP_k_10_0_sva_9_0}), and_dcpl_65);
  assign nl_z_out_1 = COMP_LOOP_mux_7_nl * COMP_LOOP_mux_8_nl;
  assign z_out_1 = nl_z_out_1[63:0];

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


  function automatic [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
  end
  endfunction


  function automatic [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
  end
  endfunction


  function automatic [0:0] readslicef_5_1_4;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 4;
    readslicef_5_1_4 = tmp[0:0];
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
//  Design Unit:    inPlaceNTT_DIF
// ------------------------------------------------------------------


module inPlaceNTT_DIF (
  clk, rst, vec_rsc_radr, vec_rsc_re, vec_rsc_q, vec_rsc_wadr, vec_rsc_d, vec_rsc_we,
      vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz,
      twiddle_rsc_radr, twiddle_rsc_re, twiddle_rsc_q, twiddle_rsc_triosy_lz
);
  input clk;
  input rst;
  output [9:0] vec_rsc_radr;
  output vec_rsc_re;
  input [63:0] vec_rsc_q;
  output [9:0] vec_rsc_wadr;
  output [63:0] vec_rsc_d;
  output vec_rsc_we;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [9:0] twiddle_rsc_radr;
  output twiddle_rsc_re;
  input [63:0] twiddle_rsc_q;
  output twiddle_rsc_triosy_lz;


  // Interconnect Declarations
  wire [9:0] vec_rsci_radr_d;
  wire [9:0] vec_rsci_wadr_d;
  wire [63:0] vec_rsci_d_d;
  wire [63:0] vec_rsci_q_d;
  wire [9:0] twiddle_rsci_radr_d;
  wire [63:0] twiddle_rsci_q_d;
  wire vec_rsci_we_d_iff;
  wire vec_rsci_re_d_iff;
  wire twiddle_rsci_re_d_iff;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_1_64_10_1024_1024_64_5_gen
      vec_rsci (
      .we(vec_rsc_we),
      .d(vec_rsc_d),
      .wadr(vec_rsc_wadr),
      .q(vec_rsc_q),
      .re(vec_rsc_re),
      .radr(vec_rsc_radr),
      .radr_d(vec_rsci_radr_d),
      .wadr_d(vec_rsci_wadr_d),
      .d_d(vec_rsci_d_d),
      .we_d(vec_rsci_we_d_iff),
      .re_d(vec_rsci_re_d_iff),
      .q_d(vec_rsci_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(vec_rsci_re_d_iff),
      .port_1_w_ram_ir_internal_WMASK_B_d(vec_rsci_we_d_iff)
    );
  inPlaceNTT_DIF_ccs_sample_mem_ccs_ram_sync_1R1W_rport_4_64_10_1024_1024_64_5_gen
      twiddle_rsci (
      .q(twiddle_rsc_q),
      .re(twiddle_rsc_re),
      .radr(twiddle_rsc_radr),
      .radr_d(twiddle_rsci_radr_d),
      .re_d(twiddle_rsci_re_d_iff),
      .q_d(twiddle_rsci_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_re_d_iff)
    );
  inPlaceNTT_DIF_core inPlaceNTT_DIF_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .vec_rsci_radr_d(vec_rsci_radr_d),
      .vec_rsci_wadr_d(vec_rsci_wadr_d),
      .vec_rsci_d_d(vec_rsci_d_d),
      .vec_rsci_q_d(vec_rsci_q_d),
      .twiddle_rsci_radr_d(twiddle_rsci_radr_d),
      .twiddle_rsci_q_d(twiddle_rsci_q_d),
      .vec_rsci_we_d_pff(vec_rsci_we_d_iff),
      .vec_rsci_re_d_pff(vec_rsci_re_d_iff),
      .twiddle_rsci_re_d_pff(twiddle_rsci_re_d_iff)
    );
endmodule



