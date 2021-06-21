
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
//  Generated date: Wed Jun 16 22:26:55 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_10_128_1024_1024_128_1_gen
// ------------------------------------------------------------------


module peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_10_128_1024_1024_128_1_gen
    (
  clken, q, radr, we, d, wadr, clken_d, d_d, q_d, radr_d, wadr_d, we_d, writeA_w_ram_ir_internal_WMASK_B_d,
      readA_r_ram_ir_internal_RMASK_B_d
);
  output clken;
  input [127:0] q;
  output [9:0] radr;
  output we;
  output [127:0] d;
  output [9:0] wadr;
  input clken_d;
  input [127:0] d_d;
  output [127:0] q_d;
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
  clk, rst, fsm_output, COPY_LOOP_C_3_tr0, COMP_LOOP_C_244_tr0, COPY_LOOP_1_C_5_tr0,
      STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [8:0] fsm_output;
  reg [8:0] fsm_output;
  input COPY_LOOP_C_3_tr0;
  input COMP_LOOP_C_244_tr0;
  input COPY_LOOP_1_C_5_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for peaceNTT_core_core_fsm_1
  parameter
    main_C_0 = 9'd0,
    COPY_LOOP_C_0 = 9'd1,
    COPY_LOOP_C_1 = 9'd2,
    COPY_LOOP_C_2 = 9'd3,
    COPY_LOOP_C_3 = 9'd4,
    STAGE_LOOP_C_0 = 9'd5,
    COMP_LOOP_C_0 = 9'd6,
    COMP_LOOP_C_1 = 9'd7,
    COMP_LOOP_C_2 = 9'd8,
    COMP_LOOP_C_3 = 9'd9,
    COMP_LOOP_C_4 = 9'd10,
    COMP_LOOP_C_5 = 9'd11,
    COMP_LOOP_C_6 = 9'd12,
    COMP_LOOP_C_7 = 9'd13,
    COMP_LOOP_C_8 = 9'd14,
    COMP_LOOP_C_9 = 9'd15,
    COMP_LOOP_C_10 = 9'd16,
    COMP_LOOP_C_11 = 9'd17,
    COMP_LOOP_C_12 = 9'd18,
    COMP_LOOP_C_13 = 9'd19,
    COMP_LOOP_C_14 = 9'd20,
    COMP_LOOP_C_15 = 9'd21,
    COMP_LOOP_C_16 = 9'd22,
    COMP_LOOP_C_17 = 9'd23,
    COMP_LOOP_C_18 = 9'd24,
    COMP_LOOP_C_19 = 9'd25,
    COMP_LOOP_C_20 = 9'd26,
    COMP_LOOP_C_21 = 9'd27,
    COMP_LOOP_C_22 = 9'd28,
    COMP_LOOP_C_23 = 9'd29,
    COMP_LOOP_C_24 = 9'd30,
    COMP_LOOP_C_25 = 9'd31,
    COMP_LOOP_C_26 = 9'd32,
    COMP_LOOP_C_27 = 9'd33,
    COMP_LOOP_C_28 = 9'd34,
    COMP_LOOP_C_29 = 9'd35,
    COMP_LOOP_C_30 = 9'd36,
    COMP_LOOP_C_31 = 9'd37,
    COMP_LOOP_C_32 = 9'd38,
    COMP_LOOP_C_33 = 9'd39,
    COMP_LOOP_C_34 = 9'd40,
    COMP_LOOP_C_35 = 9'd41,
    COMP_LOOP_C_36 = 9'd42,
    COMP_LOOP_C_37 = 9'd43,
    COMP_LOOP_C_38 = 9'd44,
    COMP_LOOP_C_39 = 9'd45,
    COMP_LOOP_C_40 = 9'd46,
    COMP_LOOP_C_41 = 9'd47,
    COMP_LOOP_C_42 = 9'd48,
    COMP_LOOP_C_43 = 9'd49,
    COMP_LOOP_C_44 = 9'd50,
    COMP_LOOP_C_45 = 9'd51,
    COMP_LOOP_C_46 = 9'd52,
    COMP_LOOP_C_47 = 9'd53,
    COMP_LOOP_C_48 = 9'd54,
    COMP_LOOP_C_49 = 9'd55,
    COMP_LOOP_C_50 = 9'd56,
    COMP_LOOP_C_51 = 9'd57,
    COMP_LOOP_C_52 = 9'd58,
    COMP_LOOP_C_53 = 9'd59,
    COMP_LOOP_C_54 = 9'd60,
    COMP_LOOP_C_55 = 9'd61,
    COMP_LOOP_C_56 = 9'd62,
    COMP_LOOP_C_57 = 9'd63,
    COMP_LOOP_C_58 = 9'd64,
    COMP_LOOP_C_59 = 9'd65,
    COMP_LOOP_C_60 = 9'd66,
    COMP_LOOP_C_61 = 9'd67,
    COMP_LOOP_C_62 = 9'd68,
    COMP_LOOP_C_63 = 9'd69,
    COMP_LOOP_C_64 = 9'd70,
    COMP_LOOP_C_65 = 9'd71,
    COMP_LOOP_C_66 = 9'd72,
    COMP_LOOP_C_67 = 9'd73,
    COMP_LOOP_C_68 = 9'd74,
    COMP_LOOP_C_69 = 9'd75,
    COMP_LOOP_C_70 = 9'd76,
    COMP_LOOP_C_71 = 9'd77,
    COMP_LOOP_C_72 = 9'd78,
    COMP_LOOP_C_73 = 9'd79,
    COMP_LOOP_C_74 = 9'd80,
    COMP_LOOP_C_75 = 9'd81,
    COMP_LOOP_C_76 = 9'd82,
    COMP_LOOP_C_77 = 9'd83,
    COMP_LOOP_C_78 = 9'd84,
    COMP_LOOP_C_79 = 9'd85,
    COMP_LOOP_C_80 = 9'd86,
    COMP_LOOP_C_81 = 9'd87,
    COMP_LOOP_C_82 = 9'd88,
    COMP_LOOP_C_83 = 9'd89,
    COMP_LOOP_C_84 = 9'd90,
    COMP_LOOP_C_85 = 9'd91,
    COMP_LOOP_C_86 = 9'd92,
    COMP_LOOP_C_87 = 9'd93,
    COMP_LOOP_C_88 = 9'd94,
    COMP_LOOP_C_89 = 9'd95,
    COMP_LOOP_C_90 = 9'd96,
    COMP_LOOP_C_91 = 9'd97,
    COMP_LOOP_C_92 = 9'd98,
    COMP_LOOP_C_93 = 9'd99,
    COMP_LOOP_C_94 = 9'd100,
    COMP_LOOP_C_95 = 9'd101,
    COMP_LOOP_C_96 = 9'd102,
    COMP_LOOP_C_97 = 9'd103,
    COMP_LOOP_C_98 = 9'd104,
    COMP_LOOP_C_99 = 9'd105,
    COMP_LOOP_C_100 = 9'd106,
    COMP_LOOP_C_101 = 9'd107,
    COMP_LOOP_C_102 = 9'd108,
    COMP_LOOP_C_103 = 9'd109,
    COMP_LOOP_C_104 = 9'd110,
    COMP_LOOP_C_105 = 9'd111,
    COMP_LOOP_C_106 = 9'd112,
    COMP_LOOP_C_107 = 9'd113,
    COMP_LOOP_C_108 = 9'd114,
    COMP_LOOP_C_109 = 9'd115,
    COMP_LOOP_C_110 = 9'd116,
    COMP_LOOP_C_111 = 9'd117,
    COMP_LOOP_C_112 = 9'd118,
    COMP_LOOP_C_113 = 9'd119,
    COMP_LOOP_C_114 = 9'd120,
    COMP_LOOP_C_115 = 9'd121,
    COMP_LOOP_C_116 = 9'd122,
    COMP_LOOP_C_117 = 9'd123,
    COMP_LOOP_C_118 = 9'd124,
    COMP_LOOP_C_119 = 9'd125,
    COMP_LOOP_C_120 = 9'd126,
    COMP_LOOP_C_121 = 9'd127,
    COMP_LOOP_C_122 = 9'd128,
    COMP_LOOP_C_123 = 9'd129,
    COMP_LOOP_C_124 = 9'd130,
    COMP_LOOP_C_125 = 9'd131,
    COMP_LOOP_C_126 = 9'd132,
    COMP_LOOP_C_127 = 9'd133,
    COMP_LOOP_C_128 = 9'd134,
    COMP_LOOP_C_129 = 9'd135,
    COMP_LOOP_C_130 = 9'd136,
    COMP_LOOP_C_131 = 9'd137,
    COMP_LOOP_C_132 = 9'd138,
    COMP_LOOP_C_133 = 9'd139,
    COMP_LOOP_C_134 = 9'd140,
    COMP_LOOP_C_135 = 9'd141,
    COMP_LOOP_C_136 = 9'd142,
    COMP_LOOP_C_137 = 9'd143,
    COMP_LOOP_C_138 = 9'd144,
    COMP_LOOP_C_139 = 9'd145,
    COMP_LOOP_C_140 = 9'd146,
    COMP_LOOP_C_141 = 9'd147,
    COMP_LOOP_C_142 = 9'd148,
    COMP_LOOP_C_143 = 9'd149,
    COMP_LOOP_C_144 = 9'd150,
    COMP_LOOP_C_145 = 9'd151,
    COMP_LOOP_C_146 = 9'd152,
    COMP_LOOP_C_147 = 9'd153,
    COMP_LOOP_C_148 = 9'd154,
    COMP_LOOP_C_149 = 9'd155,
    COMP_LOOP_C_150 = 9'd156,
    COMP_LOOP_C_151 = 9'd157,
    COMP_LOOP_C_152 = 9'd158,
    COMP_LOOP_C_153 = 9'd159,
    COMP_LOOP_C_154 = 9'd160,
    COMP_LOOP_C_155 = 9'd161,
    COMP_LOOP_C_156 = 9'd162,
    COMP_LOOP_C_157 = 9'd163,
    COMP_LOOP_C_158 = 9'd164,
    COMP_LOOP_C_159 = 9'd165,
    COMP_LOOP_C_160 = 9'd166,
    COMP_LOOP_C_161 = 9'd167,
    COMP_LOOP_C_162 = 9'd168,
    COMP_LOOP_C_163 = 9'd169,
    COMP_LOOP_C_164 = 9'd170,
    COMP_LOOP_C_165 = 9'd171,
    COMP_LOOP_C_166 = 9'd172,
    COMP_LOOP_C_167 = 9'd173,
    COMP_LOOP_C_168 = 9'd174,
    COMP_LOOP_C_169 = 9'd175,
    COMP_LOOP_C_170 = 9'd176,
    COMP_LOOP_C_171 = 9'd177,
    COMP_LOOP_C_172 = 9'd178,
    COMP_LOOP_C_173 = 9'd179,
    COMP_LOOP_C_174 = 9'd180,
    COMP_LOOP_C_175 = 9'd181,
    COMP_LOOP_C_176 = 9'd182,
    COMP_LOOP_C_177 = 9'd183,
    COMP_LOOP_C_178 = 9'd184,
    COMP_LOOP_C_179 = 9'd185,
    COMP_LOOP_C_180 = 9'd186,
    COMP_LOOP_C_181 = 9'd187,
    COMP_LOOP_C_182 = 9'd188,
    COMP_LOOP_C_183 = 9'd189,
    COMP_LOOP_C_184 = 9'd190,
    COMP_LOOP_C_185 = 9'd191,
    COMP_LOOP_C_186 = 9'd192,
    COMP_LOOP_C_187 = 9'd193,
    COMP_LOOP_C_188 = 9'd194,
    COMP_LOOP_C_189 = 9'd195,
    COMP_LOOP_C_190 = 9'd196,
    COMP_LOOP_C_191 = 9'd197,
    COMP_LOOP_C_192 = 9'd198,
    COMP_LOOP_C_193 = 9'd199,
    COMP_LOOP_C_194 = 9'd200,
    COMP_LOOP_C_195 = 9'd201,
    COMP_LOOP_C_196 = 9'd202,
    COMP_LOOP_C_197 = 9'd203,
    COMP_LOOP_C_198 = 9'd204,
    COMP_LOOP_C_199 = 9'd205,
    COMP_LOOP_C_200 = 9'd206,
    COMP_LOOP_C_201 = 9'd207,
    COMP_LOOP_C_202 = 9'd208,
    COMP_LOOP_C_203 = 9'd209,
    COMP_LOOP_C_204 = 9'd210,
    COMP_LOOP_C_205 = 9'd211,
    COMP_LOOP_C_206 = 9'd212,
    COMP_LOOP_C_207 = 9'd213,
    COMP_LOOP_C_208 = 9'd214,
    COMP_LOOP_C_209 = 9'd215,
    COMP_LOOP_C_210 = 9'd216,
    COMP_LOOP_C_211 = 9'd217,
    COMP_LOOP_C_212 = 9'd218,
    COMP_LOOP_C_213 = 9'd219,
    COMP_LOOP_C_214 = 9'd220,
    COMP_LOOP_C_215 = 9'd221,
    COMP_LOOP_C_216 = 9'd222,
    COMP_LOOP_C_217 = 9'd223,
    COMP_LOOP_C_218 = 9'd224,
    COMP_LOOP_C_219 = 9'd225,
    COMP_LOOP_C_220 = 9'd226,
    COMP_LOOP_C_221 = 9'd227,
    COMP_LOOP_C_222 = 9'd228,
    COMP_LOOP_C_223 = 9'd229,
    COMP_LOOP_C_224 = 9'd230,
    COMP_LOOP_C_225 = 9'd231,
    COMP_LOOP_C_226 = 9'd232,
    COMP_LOOP_C_227 = 9'd233,
    COMP_LOOP_C_228 = 9'd234,
    COMP_LOOP_C_229 = 9'd235,
    COMP_LOOP_C_230 = 9'd236,
    COMP_LOOP_C_231 = 9'd237,
    COMP_LOOP_C_232 = 9'd238,
    COMP_LOOP_C_233 = 9'd239,
    COMP_LOOP_C_234 = 9'd240,
    COMP_LOOP_C_235 = 9'd241,
    COMP_LOOP_C_236 = 9'd242,
    COMP_LOOP_C_237 = 9'd243,
    COMP_LOOP_C_238 = 9'd244,
    COMP_LOOP_C_239 = 9'd245,
    COMP_LOOP_C_240 = 9'd246,
    COMP_LOOP_C_241 = 9'd247,
    COMP_LOOP_C_242 = 9'd248,
    COMP_LOOP_C_243 = 9'd249,
    COMP_LOOP_C_244 = 9'd250,
    COPY_LOOP_1_C_0 = 9'd251,
    COPY_LOOP_1_C_1 = 9'd252,
    COPY_LOOP_1_C_2 = 9'd253,
    COPY_LOOP_1_C_3 = 9'd254,
    COPY_LOOP_1_C_4 = 9'd255,
    COPY_LOOP_1_C_5 = 9'd256,
    STAGE_LOOP_C_1 = 9'd257,
    main_C_1 = 9'd258;

  reg [8:0] state_var;
  reg [8:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : peaceNTT_core_core_fsm_1
    case (state_var)
      COPY_LOOP_C_0 : begin
        fsm_output = 9'b000000001;
        state_var_NS = COPY_LOOP_C_1;
      end
      COPY_LOOP_C_1 : begin
        fsm_output = 9'b000000010;
        state_var_NS = COPY_LOOP_C_2;
      end
      COPY_LOOP_C_2 : begin
        fsm_output = 9'b000000011;
        state_var_NS = COPY_LOOP_C_3;
      end
      COPY_LOOP_C_3 : begin
        fsm_output = 9'b000000100;
        if ( COPY_LOOP_C_3_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_0;
        end
        else begin
          state_var_NS = COPY_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_0 : begin
        fsm_output = 9'b000000101;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 9'b000000110;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 9'b000000111;
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 9'b000001000;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 9'b000001001;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 9'b000001010;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 9'b000001011;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 9'b000001100;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 9'b000001101;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 9'b000001110;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 9'b000001111;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 9'b000010000;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 9'b000010001;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 9'b000010010;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 9'b000010011;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 9'b000010100;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 9'b000010101;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 9'b000010110;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 9'b000010111;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 9'b000011000;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 9'b000011001;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 9'b000011010;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 9'b000011011;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 9'b000011100;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 9'b000011101;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 9'b000011110;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 9'b000011111;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 9'b000100000;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 9'b000100001;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 9'b000100010;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 9'b000100011;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 9'b000100100;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 9'b000100101;
        state_var_NS = COMP_LOOP_C_32;
      end
      COMP_LOOP_C_32 : begin
        fsm_output = 9'b000100110;
        state_var_NS = COMP_LOOP_C_33;
      end
      COMP_LOOP_C_33 : begin
        fsm_output = 9'b000100111;
        state_var_NS = COMP_LOOP_C_34;
      end
      COMP_LOOP_C_34 : begin
        fsm_output = 9'b000101000;
        state_var_NS = COMP_LOOP_C_35;
      end
      COMP_LOOP_C_35 : begin
        fsm_output = 9'b000101001;
        state_var_NS = COMP_LOOP_C_36;
      end
      COMP_LOOP_C_36 : begin
        fsm_output = 9'b000101010;
        state_var_NS = COMP_LOOP_C_37;
      end
      COMP_LOOP_C_37 : begin
        fsm_output = 9'b000101011;
        state_var_NS = COMP_LOOP_C_38;
      end
      COMP_LOOP_C_38 : begin
        fsm_output = 9'b000101100;
        state_var_NS = COMP_LOOP_C_39;
      end
      COMP_LOOP_C_39 : begin
        fsm_output = 9'b000101101;
        state_var_NS = COMP_LOOP_C_40;
      end
      COMP_LOOP_C_40 : begin
        fsm_output = 9'b000101110;
        state_var_NS = COMP_LOOP_C_41;
      end
      COMP_LOOP_C_41 : begin
        fsm_output = 9'b000101111;
        state_var_NS = COMP_LOOP_C_42;
      end
      COMP_LOOP_C_42 : begin
        fsm_output = 9'b000110000;
        state_var_NS = COMP_LOOP_C_43;
      end
      COMP_LOOP_C_43 : begin
        fsm_output = 9'b000110001;
        state_var_NS = COMP_LOOP_C_44;
      end
      COMP_LOOP_C_44 : begin
        fsm_output = 9'b000110010;
        state_var_NS = COMP_LOOP_C_45;
      end
      COMP_LOOP_C_45 : begin
        fsm_output = 9'b000110011;
        state_var_NS = COMP_LOOP_C_46;
      end
      COMP_LOOP_C_46 : begin
        fsm_output = 9'b000110100;
        state_var_NS = COMP_LOOP_C_47;
      end
      COMP_LOOP_C_47 : begin
        fsm_output = 9'b000110101;
        state_var_NS = COMP_LOOP_C_48;
      end
      COMP_LOOP_C_48 : begin
        fsm_output = 9'b000110110;
        state_var_NS = COMP_LOOP_C_49;
      end
      COMP_LOOP_C_49 : begin
        fsm_output = 9'b000110111;
        state_var_NS = COMP_LOOP_C_50;
      end
      COMP_LOOP_C_50 : begin
        fsm_output = 9'b000111000;
        state_var_NS = COMP_LOOP_C_51;
      end
      COMP_LOOP_C_51 : begin
        fsm_output = 9'b000111001;
        state_var_NS = COMP_LOOP_C_52;
      end
      COMP_LOOP_C_52 : begin
        fsm_output = 9'b000111010;
        state_var_NS = COMP_LOOP_C_53;
      end
      COMP_LOOP_C_53 : begin
        fsm_output = 9'b000111011;
        state_var_NS = COMP_LOOP_C_54;
      end
      COMP_LOOP_C_54 : begin
        fsm_output = 9'b000111100;
        state_var_NS = COMP_LOOP_C_55;
      end
      COMP_LOOP_C_55 : begin
        fsm_output = 9'b000111101;
        state_var_NS = COMP_LOOP_C_56;
      end
      COMP_LOOP_C_56 : begin
        fsm_output = 9'b000111110;
        state_var_NS = COMP_LOOP_C_57;
      end
      COMP_LOOP_C_57 : begin
        fsm_output = 9'b000111111;
        state_var_NS = COMP_LOOP_C_58;
      end
      COMP_LOOP_C_58 : begin
        fsm_output = 9'b001000000;
        state_var_NS = COMP_LOOP_C_59;
      end
      COMP_LOOP_C_59 : begin
        fsm_output = 9'b001000001;
        state_var_NS = COMP_LOOP_C_60;
      end
      COMP_LOOP_C_60 : begin
        fsm_output = 9'b001000010;
        state_var_NS = COMP_LOOP_C_61;
      end
      COMP_LOOP_C_61 : begin
        fsm_output = 9'b001000011;
        state_var_NS = COMP_LOOP_C_62;
      end
      COMP_LOOP_C_62 : begin
        fsm_output = 9'b001000100;
        state_var_NS = COMP_LOOP_C_63;
      end
      COMP_LOOP_C_63 : begin
        fsm_output = 9'b001000101;
        state_var_NS = COMP_LOOP_C_64;
      end
      COMP_LOOP_C_64 : begin
        fsm_output = 9'b001000110;
        state_var_NS = COMP_LOOP_C_65;
      end
      COMP_LOOP_C_65 : begin
        fsm_output = 9'b001000111;
        state_var_NS = COMP_LOOP_C_66;
      end
      COMP_LOOP_C_66 : begin
        fsm_output = 9'b001001000;
        state_var_NS = COMP_LOOP_C_67;
      end
      COMP_LOOP_C_67 : begin
        fsm_output = 9'b001001001;
        state_var_NS = COMP_LOOP_C_68;
      end
      COMP_LOOP_C_68 : begin
        fsm_output = 9'b001001010;
        state_var_NS = COMP_LOOP_C_69;
      end
      COMP_LOOP_C_69 : begin
        fsm_output = 9'b001001011;
        state_var_NS = COMP_LOOP_C_70;
      end
      COMP_LOOP_C_70 : begin
        fsm_output = 9'b001001100;
        state_var_NS = COMP_LOOP_C_71;
      end
      COMP_LOOP_C_71 : begin
        fsm_output = 9'b001001101;
        state_var_NS = COMP_LOOP_C_72;
      end
      COMP_LOOP_C_72 : begin
        fsm_output = 9'b001001110;
        state_var_NS = COMP_LOOP_C_73;
      end
      COMP_LOOP_C_73 : begin
        fsm_output = 9'b001001111;
        state_var_NS = COMP_LOOP_C_74;
      end
      COMP_LOOP_C_74 : begin
        fsm_output = 9'b001010000;
        state_var_NS = COMP_LOOP_C_75;
      end
      COMP_LOOP_C_75 : begin
        fsm_output = 9'b001010001;
        state_var_NS = COMP_LOOP_C_76;
      end
      COMP_LOOP_C_76 : begin
        fsm_output = 9'b001010010;
        state_var_NS = COMP_LOOP_C_77;
      end
      COMP_LOOP_C_77 : begin
        fsm_output = 9'b001010011;
        state_var_NS = COMP_LOOP_C_78;
      end
      COMP_LOOP_C_78 : begin
        fsm_output = 9'b001010100;
        state_var_NS = COMP_LOOP_C_79;
      end
      COMP_LOOP_C_79 : begin
        fsm_output = 9'b001010101;
        state_var_NS = COMP_LOOP_C_80;
      end
      COMP_LOOP_C_80 : begin
        fsm_output = 9'b001010110;
        state_var_NS = COMP_LOOP_C_81;
      end
      COMP_LOOP_C_81 : begin
        fsm_output = 9'b001010111;
        state_var_NS = COMP_LOOP_C_82;
      end
      COMP_LOOP_C_82 : begin
        fsm_output = 9'b001011000;
        state_var_NS = COMP_LOOP_C_83;
      end
      COMP_LOOP_C_83 : begin
        fsm_output = 9'b001011001;
        state_var_NS = COMP_LOOP_C_84;
      end
      COMP_LOOP_C_84 : begin
        fsm_output = 9'b001011010;
        state_var_NS = COMP_LOOP_C_85;
      end
      COMP_LOOP_C_85 : begin
        fsm_output = 9'b001011011;
        state_var_NS = COMP_LOOP_C_86;
      end
      COMP_LOOP_C_86 : begin
        fsm_output = 9'b001011100;
        state_var_NS = COMP_LOOP_C_87;
      end
      COMP_LOOP_C_87 : begin
        fsm_output = 9'b001011101;
        state_var_NS = COMP_LOOP_C_88;
      end
      COMP_LOOP_C_88 : begin
        fsm_output = 9'b001011110;
        state_var_NS = COMP_LOOP_C_89;
      end
      COMP_LOOP_C_89 : begin
        fsm_output = 9'b001011111;
        state_var_NS = COMP_LOOP_C_90;
      end
      COMP_LOOP_C_90 : begin
        fsm_output = 9'b001100000;
        state_var_NS = COMP_LOOP_C_91;
      end
      COMP_LOOP_C_91 : begin
        fsm_output = 9'b001100001;
        state_var_NS = COMP_LOOP_C_92;
      end
      COMP_LOOP_C_92 : begin
        fsm_output = 9'b001100010;
        state_var_NS = COMP_LOOP_C_93;
      end
      COMP_LOOP_C_93 : begin
        fsm_output = 9'b001100011;
        state_var_NS = COMP_LOOP_C_94;
      end
      COMP_LOOP_C_94 : begin
        fsm_output = 9'b001100100;
        state_var_NS = COMP_LOOP_C_95;
      end
      COMP_LOOP_C_95 : begin
        fsm_output = 9'b001100101;
        state_var_NS = COMP_LOOP_C_96;
      end
      COMP_LOOP_C_96 : begin
        fsm_output = 9'b001100110;
        state_var_NS = COMP_LOOP_C_97;
      end
      COMP_LOOP_C_97 : begin
        fsm_output = 9'b001100111;
        state_var_NS = COMP_LOOP_C_98;
      end
      COMP_LOOP_C_98 : begin
        fsm_output = 9'b001101000;
        state_var_NS = COMP_LOOP_C_99;
      end
      COMP_LOOP_C_99 : begin
        fsm_output = 9'b001101001;
        state_var_NS = COMP_LOOP_C_100;
      end
      COMP_LOOP_C_100 : begin
        fsm_output = 9'b001101010;
        state_var_NS = COMP_LOOP_C_101;
      end
      COMP_LOOP_C_101 : begin
        fsm_output = 9'b001101011;
        state_var_NS = COMP_LOOP_C_102;
      end
      COMP_LOOP_C_102 : begin
        fsm_output = 9'b001101100;
        state_var_NS = COMP_LOOP_C_103;
      end
      COMP_LOOP_C_103 : begin
        fsm_output = 9'b001101101;
        state_var_NS = COMP_LOOP_C_104;
      end
      COMP_LOOP_C_104 : begin
        fsm_output = 9'b001101110;
        state_var_NS = COMP_LOOP_C_105;
      end
      COMP_LOOP_C_105 : begin
        fsm_output = 9'b001101111;
        state_var_NS = COMP_LOOP_C_106;
      end
      COMP_LOOP_C_106 : begin
        fsm_output = 9'b001110000;
        state_var_NS = COMP_LOOP_C_107;
      end
      COMP_LOOP_C_107 : begin
        fsm_output = 9'b001110001;
        state_var_NS = COMP_LOOP_C_108;
      end
      COMP_LOOP_C_108 : begin
        fsm_output = 9'b001110010;
        state_var_NS = COMP_LOOP_C_109;
      end
      COMP_LOOP_C_109 : begin
        fsm_output = 9'b001110011;
        state_var_NS = COMP_LOOP_C_110;
      end
      COMP_LOOP_C_110 : begin
        fsm_output = 9'b001110100;
        state_var_NS = COMP_LOOP_C_111;
      end
      COMP_LOOP_C_111 : begin
        fsm_output = 9'b001110101;
        state_var_NS = COMP_LOOP_C_112;
      end
      COMP_LOOP_C_112 : begin
        fsm_output = 9'b001110110;
        state_var_NS = COMP_LOOP_C_113;
      end
      COMP_LOOP_C_113 : begin
        fsm_output = 9'b001110111;
        state_var_NS = COMP_LOOP_C_114;
      end
      COMP_LOOP_C_114 : begin
        fsm_output = 9'b001111000;
        state_var_NS = COMP_LOOP_C_115;
      end
      COMP_LOOP_C_115 : begin
        fsm_output = 9'b001111001;
        state_var_NS = COMP_LOOP_C_116;
      end
      COMP_LOOP_C_116 : begin
        fsm_output = 9'b001111010;
        state_var_NS = COMP_LOOP_C_117;
      end
      COMP_LOOP_C_117 : begin
        fsm_output = 9'b001111011;
        state_var_NS = COMP_LOOP_C_118;
      end
      COMP_LOOP_C_118 : begin
        fsm_output = 9'b001111100;
        state_var_NS = COMP_LOOP_C_119;
      end
      COMP_LOOP_C_119 : begin
        fsm_output = 9'b001111101;
        state_var_NS = COMP_LOOP_C_120;
      end
      COMP_LOOP_C_120 : begin
        fsm_output = 9'b001111110;
        state_var_NS = COMP_LOOP_C_121;
      end
      COMP_LOOP_C_121 : begin
        fsm_output = 9'b001111111;
        state_var_NS = COMP_LOOP_C_122;
      end
      COMP_LOOP_C_122 : begin
        fsm_output = 9'b010000000;
        state_var_NS = COMP_LOOP_C_123;
      end
      COMP_LOOP_C_123 : begin
        fsm_output = 9'b010000001;
        state_var_NS = COMP_LOOP_C_124;
      end
      COMP_LOOP_C_124 : begin
        fsm_output = 9'b010000010;
        state_var_NS = COMP_LOOP_C_125;
      end
      COMP_LOOP_C_125 : begin
        fsm_output = 9'b010000011;
        state_var_NS = COMP_LOOP_C_126;
      end
      COMP_LOOP_C_126 : begin
        fsm_output = 9'b010000100;
        state_var_NS = COMP_LOOP_C_127;
      end
      COMP_LOOP_C_127 : begin
        fsm_output = 9'b010000101;
        state_var_NS = COMP_LOOP_C_128;
      end
      COMP_LOOP_C_128 : begin
        fsm_output = 9'b010000110;
        state_var_NS = COMP_LOOP_C_129;
      end
      COMP_LOOP_C_129 : begin
        fsm_output = 9'b010000111;
        state_var_NS = COMP_LOOP_C_130;
      end
      COMP_LOOP_C_130 : begin
        fsm_output = 9'b010001000;
        state_var_NS = COMP_LOOP_C_131;
      end
      COMP_LOOP_C_131 : begin
        fsm_output = 9'b010001001;
        state_var_NS = COMP_LOOP_C_132;
      end
      COMP_LOOP_C_132 : begin
        fsm_output = 9'b010001010;
        state_var_NS = COMP_LOOP_C_133;
      end
      COMP_LOOP_C_133 : begin
        fsm_output = 9'b010001011;
        state_var_NS = COMP_LOOP_C_134;
      end
      COMP_LOOP_C_134 : begin
        fsm_output = 9'b010001100;
        state_var_NS = COMP_LOOP_C_135;
      end
      COMP_LOOP_C_135 : begin
        fsm_output = 9'b010001101;
        state_var_NS = COMP_LOOP_C_136;
      end
      COMP_LOOP_C_136 : begin
        fsm_output = 9'b010001110;
        state_var_NS = COMP_LOOP_C_137;
      end
      COMP_LOOP_C_137 : begin
        fsm_output = 9'b010001111;
        state_var_NS = COMP_LOOP_C_138;
      end
      COMP_LOOP_C_138 : begin
        fsm_output = 9'b010010000;
        state_var_NS = COMP_LOOP_C_139;
      end
      COMP_LOOP_C_139 : begin
        fsm_output = 9'b010010001;
        state_var_NS = COMP_LOOP_C_140;
      end
      COMP_LOOP_C_140 : begin
        fsm_output = 9'b010010010;
        state_var_NS = COMP_LOOP_C_141;
      end
      COMP_LOOP_C_141 : begin
        fsm_output = 9'b010010011;
        state_var_NS = COMP_LOOP_C_142;
      end
      COMP_LOOP_C_142 : begin
        fsm_output = 9'b010010100;
        state_var_NS = COMP_LOOP_C_143;
      end
      COMP_LOOP_C_143 : begin
        fsm_output = 9'b010010101;
        state_var_NS = COMP_LOOP_C_144;
      end
      COMP_LOOP_C_144 : begin
        fsm_output = 9'b010010110;
        state_var_NS = COMP_LOOP_C_145;
      end
      COMP_LOOP_C_145 : begin
        fsm_output = 9'b010010111;
        state_var_NS = COMP_LOOP_C_146;
      end
      COMP_LOOP_C_146 : begin
        fsm_output = 9'b010011000;
        state_var_NS = COMP_LOOP_C_147;
      end
      COMP_LOOP_C_147 : begin
        fsm_output = 9'b010011001;
        state_var_NS = COMP_LOOP_C_148;
      end
      COMP_LOOP_C_148 : begin
        fsm_output = 9'b010011010;
        state_var_NS = COMP_LOOP_C_149;
      end
      COMP_LOOP_C_149 : begin
        fsm_output = 9'b010011011;
        state_var_NS = COMP_LOOP_C_150;
      end
      COMP_LOOP_C_150 : begin
        fsm_output = 9'b010011100;
        state_var_NS = COMP_LOOP_C_151;
      end
      COMP_LOOP_C_151 : begin
        fsm_output = 9'b010011101;
        state_var_NS = COMP_LOOP_C_152;
      end
      COMP_LOOP_C_152 : begin
        fsm_output = 9'b010011110;
        state_var_NS = COMP_LOOP_C_153;
      end
      COMP_LOOP_C_153 : begin
        fsm_output = 9'b010011111;
        state_var_NS = COMP_LOOP_C_154;
      end
      COMP_LOOP_C_154 : begin
        fsm_output = 9'b010100000;
        state_var_NS = COMP_LOOP_C_155;
      end
      COMP_LOOP_C_155 : begin
        fsm_output = 9'b010100001;
        state_var_NS = COMP_LOOP_C_156;
      end
      COMP_LOOP_C_156 : begin
        fsm_output = 9'b010100010;
        state_var_NS = COMP_LOOP_C_157;
      end
      COMP_LOOP_C_157 : begin
        fsm_output = 9'b010100011;
        state_var_NS = COMP_LOOP_C_158;
      end
      COMP_LOOP_C_158 : begin
        fsm_output = 9'b010100100;
        state_var_NS = COMP_LOOP_C_159;
      end
      COMP_LOOP_C_159 : begin
        fsm_output = 9'b010100101;
        state_var_NS = COMP_LOOP_C_160;
      end
      COMP_LOOP_C_160 : begin
        fsm_output = 9'b010100110;
        state_var_NS = COMP_LOOP_C_161;
      end
      COMP_LOOP_C_161 : begin
        fsm_output = 9'b010100111;
        state_var_NS = COMP_LOOP_C_162;
      end
      COMP_LOOP_C_162 : begin
        fsm_output = 9'b010101000;
        state_var_NS = COMP_LOOP_C_163;
      end
      COMP_LOOP_C_163 : begin
        fsm_output = 9'b010101001;
        state_var_NS = COMP_LOOP_C_164;
      end
      COMP_LOOP_C_164 : begin
        fsm_output = 9'b010101010;
        state_var_NS = COMP_LOOP_C_165;
      end
      COMP_LOOP_C_165 : begin
        fsm_output = 9'b010101011;
        state_var_NS = COMP_LOOP_C_166;
      end
      COMP_LOOP_C_166 : begin
        fsm_output = 9'b010101100;
        state_var_NS = COMP_LOOP_C_167;
      end
      COMP_LOOP_C_167 : begin
        fsm_output = 9'b010101101;
        state_var_NS = COMP_LOOP_C_168;
      end
      COMP_LOOP_C_168 : begin
        fsm_output = 9'b010101110;
        state_var_NS = COMP_LOOP_C_169;
      end
      COMP_LOOP_C_169 : begin
        fsm_output = 9'b010101111;
        state_var_NS = COMP_LOOP_C_170;
      end
      COMP_LOOP_C_170 : begin
        fsm_output = 9'b010110000;
        state_var_NS = COMP_LOOP_C_171;
      end
      COMP_LOOP_C_171 : begin
        fsm_output = 9'b010110001;
        state_var_NS = COMP_LOOP_C_172;
      end
      COMP_LOOP_C_172 : begin
        fsm_output = 9'b010110010;
        state_var_NS = COMP_LOOP_C_173;
      end
      COMP_LOOP_C_173 : begin
        fsm_output = 9'b010110011;
        state_var_NS = COMP_LOOP_C_174;
      end
      COMP_LOOP_C_174 : begin
        fsm_output = 9'b010110100;
        state_var_NS = COMP_LOOP_C_175;
      end
      COMP_LOOP_C_175 : begin
        fsm_output = 9'b010110101;
        state_var_NS = COMP_LOOP_C_176;
      end
      COMP_LOOP_C_176 : begin
        fsm_output = 9'b010110110;
        state_var_NS = COMP_LOOP_C_177;
      end
      COMP_LOOP_C_177 : begin
        fsm_output = 9'b010110111;
        state_var_NS = COMP_LOOP_C_178;
      end
      COMP_LOOP_C_178 : begin
        fsm_output = 9'b010111000;
        state_var_NS = COMP_LOOP_C_179;
      end
      COMP_LOOP_C_179 : begin
        fsm_output = 9'b010111001;
        state_var_NS = COMP_LOOP_C_180;
      end
      COMP_LOOP_C_180 : begin
        fsm_output = 9'b010111010;
        state_var_NS = COMP_LOOP_C_181;
      end
      COMP_LOOP_C_181 : begin
        fsm_output = 9'b010111011;
        state_var_NS = COMP_LOOP_C_182;
      end
      COMP_LOOP_C_182 : begin
        fsm_output = 9'b010111100;
        state_var_NS = COMP_LOOP_C_183;
      end
      COMP_LOOP_C_183 : begin
        fsm_output = 9'b010111101;
        state_var_NS = COMP_LOOP_C_184;
      end
      COMP_LOOP_C_184 : begin
        fsm_output = 9'b010111110;
        state_var_NS = COMP_LOOP_C_185;
      end
      COMP_LOOP_C_185 : begin
        fsm_output = 9'b010111111;
        state_var_NS = COMP_LOOP_C_186;
      end
      COMP_LOOP_C_186 : begin
        fsm_output = 9'b011000000;
        state_var_NS = COMP_LOOP_C_187;
      end
      COMP_LOOP_C_187 : begin
        fsm_output = 9'b011000001;
        state_var_NS = COMP_LOOP_C_188;
      end
      COMP_LOOP_C_188 : begin
        fsm_output = 9'b011000010;
        state_var_NS = COMP_LOOP_C_189;
      end
      COMP_LOOP_C_189 : begin
        fsm_output = 9'b011000011;
        state_var_NS = COMP_LOOP_C_190;
      end
      COMP_LOOP_C_190 : begin
        fsm_output = 9'b011000100;
        state_var_NS = COMP_LOOP_C_191;
      end
      COMP_LOOP_C_191 : begin
        fsm_output = 9'b011000101;
        state_var_NS = COMP_LOOP_C_192;
      end
      COMP_LOOP_C_192 : begin
        fsm_output = 9'b011000110;
        state_var_NS = COMP_LOOP_C_193;
      end
      COMP_LOOP_C_193 : begin
        fsm_output = 9'b011000111;
        state_var_NS = COMP_LOOP_C_194;
      end
      COMP_LOOP_C_194 : begin
        fsm_output = 9'b011001000;
        state_var_NS = COMP_LOOP_C_195;
      end
      COMP_LOOP_C_195 : begin
        fsm_output = 9'b011001001;
        state_var_NS = COMP_LOOP_C_196;
      end
      COMP_LOOP_C_196 : begin
        fsm_output = 9'b011001010;
        state_var_NS = COMP_LOOP_C_197;
      end
      COMP_LOOP_C_197 : begin
        fsm_output = 9'b011001011;
        state_var_NS = COMP_LOOP_C_198;
      end
      COMP_LOOP_C_198 : begin
        fsm_output = 9'b011001100;
        state_var_NS = COMP_LOOP_C_199;
      end
      COMP_LOOP_C_199 : begin
        fsm_output = 9'b011001101;
        state_var_NS = COMP_LOOP_C_200;
      end
      COMP_LOOP_C_200 : begin
        fsm_output = 9'b011001110;
        state_var_NS = COMP_LOOP_C_201;
      end
      COMP_LOOP_C_201 : begin
        fsm_output = 9'b011001111;
        state_var_NS = COMP_LOOP_C_202;
      end
      COMP_LOOP_C_202 : begin
        fsm_output = 9'b011010000;
        state_var_NS = COMP_LOOP_C_203;
      end
      COMP_LOOP_C_203 : begin
        fsm_output = 9'b011010001;
        state_var_NS = COMP_LOOP_C_204;
      end
      COMP_LOOP_C_204 : begin
        fsm_output = 9'b011010010;
        state_var_NS = COMP_LOOP_C_205;
      end
      COMP_LOOP_C_205 : begin
        fsm_output = 9'b011010011;
        state_var_NS = COMP_LOOP_C_206;
      end
      COMP_LOOP_C_206 : begin
        fsm_output = 9'b011010100;
        state_var_NS = COMP_LOOP_C_207;
      end
      COMP_LOOP_C_207 : begin
        fsm_output = 9'b011010101;
        state_var_NS = COMP_LOOP_C_208;
      end
      COMP_LOOP_C_208 : begin
        fsm_output = 9'b011010110;
        state_var_NS = COMP_LOOP_C_209;
      end
      COMP_LOOP_C_209 : begin
        fsm_output = 9'b011010111;
        state_var_NS = COMP_LOOP_C_210;
      end
      COMP_LOOP_C_210 : begin
        fsm_output = 9'b011011000;
        state_var_NS = COMP_LOOP_C_211;
      end
      COMP_LOOP_C_211 : begin
        fsm_output = 9'b011011001;
        state_var_NS = COMP_LOOP_C_212;
      end
      COMP_LOOP_C_212 : begin
        fsm_output = 9'b011011010;
        state_var_NS = COMP_LOOP_C_213;
      end
      COMP_LOOP_C_213 : begin
        fsm_output = 9'b011011011;
        state_var_NS = COMP_LOOP_C_214;
      end
      COMP_LOOP_C_214 : begin
        fsm_output = 9'b011011100;
        state_var_NS = COMP_LOOP_C_215;
      end
      COMP_LOOP_C_215 : begin
        fsm_output = 9'b011011101;
        state_var_NS = COMP_LOOP_C_216;
      end
      COMP_LOOP_C_216 : begin
        fsm_output = 9'b011011110;
        state_var_NS = COMP_LOOP_C_217;
      end
      COMP_LOOP_C_217 : begin
        fsm_output = 9'b011011111;
        state_var_NS = COMP_LOOP_C_218;
      end
      COMP_LOOP_C_218 : begin
        fsm_output = 9'b011100000;
        state_var_NS = COMP_LOOP_C_219;
      end
      COMP_LOOP_C_219 : begin
        fsm_output = 9'b011100001;
        state_var_NS = COMP_LOOP_C_220;
      end
      COMP_LOOP_C_220 : begin
        fsm_output = 9'b011100010;
        state_var_NS = COMP_LOOP_C_221;
      end
      COMP_LOOP_C_221 : begin
        fsm_output = 9'b011100011;
        state_var_NS = COMP_LOOP_C_222;
      end
      COMP_LOOP_C_222 : begin
        fsm_output = 9'b011100100;
        state_var_NS = COMP_LOOP_C_223;
      end
      COMP_LOOP_C_223 : begin
        fsm_output = 9'b011100101;
        state_var_NS = COMP_LOOP_C_224;
      end
      COMP_LOOP_C_224 : begin
        fsm_output = 9'b011100110;
        state_var_NS = COMP_LOOP_C_225;
      end
      COMP_LOOP_C_225 : begin
        fsm_output = 9'b011100111;
        state_var_NS = COMP_LOOP_C_226;
      end
      COMP_LOOP_C_226 : begin
        fsm_output = 9'b011101000;
        state_var_NS = COMP_LOOP_C_227;
      end
      COMP_LOOP_C_227 : begin
        fsm_output = 9'b011101001;
        state_var_NS = COMP_LOOP_C_228;
      end
      COMP_LOOP_C_228 : begin
        fsm_output = 9'b011101010;
        state_var_NS = COMP_LOOP_C_229;
      end
      COMP_LOOP_C_229 : begin
        fsm_output = 9'b011101011;
        state_var_NS = COMP_LOOP_C_230;
      end
      COMP_LOOP_C_230 : begin
        fsm_output = 9'b011101100;
        state_var_NS = COMP_LOOP_C_231;
      end
      COMP_LOOP_C_231 : begin
        fsm_output = 9'b011101101;
        state_var_NS = COMP_LOOP_C_232;
      end
      COMP_LOOP_C_232 : begin
        fsm_output = 9'b011101110;
        state_var_NS = COMP_LOOP_C_233;
      end
      COMP_LOOP_C_233 : begin
        fsm_output = 9'b011101111;
        state_var_NS = COMP_LOOP_C_234;
      end
      COMP_LOOP_C_234 : begin
        fsm_output = 9'b011110000;
        state_var_NS = COMP_LOOP_C_235;
      end
      COMP_LOOP_C_235 : begin
        fsm_output = 9'b011110001;
        state_var_NS = COMP_LOOP_C_236;
      end
      COMP_LOOP_C_236 : begin
        fsm_output = 9'b011110010;
        state_var_NS = COMP_LOOP_C_237;
      end
      COMP_LOOP_C_237 : begin
        fsm_output = 9'b011110011;
        state_var_NS = COMP_LOOP_C_238;
      end
      COMP_LOOP_C_238 : begin
        fsm_output = 9'b011110100;
        state_var_NS = COMP_LOOP_C_239;
      end
      COMP_LOOP_C_239 : begin
        fsm_output = 9'b011110101;
        state_var_NS = COMP_LOOP_C_240;
      end
      COMP_LOOP_C_240 : begin
        fsm_output = 9'b011110110;
        state_var_NS = COMP_LOOP_C_241;
      end
      COMP_LOOP_C_241 : begin
        fsm_output = 9'b011110111;
        state_var_NS = COMP_LOOP_C_242;
      end
      COMP_LOOP_C_242 : begin
        fsm_output = 9'b011111000;
        state_var_NS = COMP_LOOP_C_243;
      end
      COMP_LOOP_C_243 : begin
        fsm_output = 9'b011111001;
        state_var_NS = COMP_LOOP_C_244;
      end
      COMP_LOOP_C_244 : begin
        fsm_output = 9'b011111010;
        if ( COMP_LOOP_C_244_tr0 ) begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      COPY_LOOP_1_C_0 : begin
        fsm_output = 9'b011111011;
        state_var_NS = COPY_LOOP_1_C_1;
      end
      COPY_LOOP_1_C_1 : begin
        fsm_output = 9'b011111100;
        state_var_NS = COPY_LOOP_1_C_2;
      end
      COPY_LOOP_1_C_2 : begin
        fsm_output = 9'b011111101;
        state_var_NS = COPY_LOOP_1_C_3;
      end
      COPY_LOOP_1_C_3 : begin
        fsm_output = 9'b011111110;
        state_var_NS = COPY_LOOP_1_C_4;
      end
      COPY_LOOP_1_C_4 : begin
        fsm_output = 9'b011111111;
        state_var_NS = COPY_LOOP_1_C_5;
      end
      COPY_LOOP_1_C_5 : begin
        fsm_output = 9'b100000000;
        if ( COPY_LOOP_1_C_5_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COPY_LOOP_1_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 9'b100000001;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 9'b100000010;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 9'b000000000;
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
  clk, xt_rsc_cgo_iro, xt_rsci_clken_d, COMP_LOOP_1_f2_rem_cmp_z, xt_rsc_cgo, COMP_LOOP_1_f2_rem_cmp_z_oreg
);
  input clk;
  input xt_rsc_cgo_iro;
  output xt_rsci_clken_d;
  input [63:0] COMP_LOOP_1_f2_rem_cmp_z;
  input xt_rsc_cgo;
  output [63:0] COMP_LOOP_1_f2_rem_cmp_z_oreg;
  reg [63:0] COMP_LOOP_1_f2_rem_cmp_z_oreg;



  // Interconnect Declarations for Component Instantiations 
  assign xt_rsci_clken_d = xt_rsc_cgo | xt_rsc_cgo_iro;
  always @(posedge clk) begin
    COMP_LOOP_1_f2_rem_cmp_z_oreg <= COMP_LOOP_1_f2_rem_cmp_z;
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    peaceNTT_core
// ------------------------------------------------------------------


module peaceNTT_core (
  clk, rst, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, g_rsc_triosy_lz, result_rsc_triosy_lz,
      twiddle_rsc_triosy_lz, vec_rsci_q_d, vec_rsci_radr_d, vec_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      result_rsci_d_d, result_rsci_q_d, result_rsci_radr_d, result_rsci_wadr_d, result_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsci_q_d, twiddle_rsci_radr_d, twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      xt_rsci_clken_d, xt_rsci_d_d, xt_rsci_q_d, xt_rsci_radr_d, xt_rsci_wadr_d,
      xt_rsci_readA_r_ram_ir_internal_RMASK_B_d, COMP_LOOP_1_f2_rem_cmp_a, COMP_LOOP_1_f2_rem_cmp_b,
      COMP_LOOP_1_f2_rem_cmp_z, result_rsci_we_d_pff, xt_rsci_we_d_pff
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
  output [11:0] vec_rsci_radr_d;
  output vec_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output [63:0] result_rsci_d_d;
  input [63:0] result_rsci_q_d;
  output [11:0] result_rsci_radr_d;
  output [11:0] result_rsci_wadr_d;
  output result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_rsci_q_d;
  output [11:0] twiddle_rsci_radr_d;
  output twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output xt_rsci_clken_d;
  output [127:0] xt_rsci_d_d;
  input [127:0] xt_rsci_q_d;
  output [9:0] xt_rsci_radr_d;
  output [9:0] xt_rsci_wadr_d;
  output xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output [127:0] COMP_LOOP_1_f2_rem_cmp_a;
  output [63:0] COMP_LOOP_1_f2_rem_cmp_b;
  input [63:0] COMP_LOOP_1_f2_rem_cmp_z;
  output result_rsci_we_d_pff;
  output xt_rsci_we_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  reg [64:0] COMP_LOOP_1_rem_cmp_a;
  wire [64:0] COMP_LOOP_1_rem_cmp_z;
  wire [63:0] COMP_LOOP_1_f2_rem_cmp_z_oreg;
  wire [8:0] fsm_output;
  wire mux_tmp_9;
  wire and_dcpl_7;
  wire and_dcpl_8;
  wire and_dcpl_10;
  wire and_dcpl_11;
  wire and_dcpl_12;
  wire and_dcpl_13;
  wire and_dcpl_14;
  wire and_dcpl_20;
  wire and_dcpl_21;
  wire and_dcpl_26;
  wire and_dcpl_27;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_32;
  wire and_dcpl_33;
  wire and_dcpl_36;
  wire and_dcpl_37;
  wire and_dcpl_41;
  wire and_dcpl_44;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire and_dcpl_47;
  wire and_dcpl_53;
  wire and_dcpl_54;
  wire and_dcpl_55;
  wire and_dcpl_57;
  wire and_dcpl_63;
  wire not_tmp_21;
  wire or_tmp_12;
  wire and_dcpl_71;
  wire and_dcpl_72;
  wire and_dcpl_73;
  wire and_dcpl_74;
  wire and_dcpl_75;
  wire and_dcpl_76;
  wire and_dcpl_78;
  wire mux_tmp_18;
  wire or_tmp_16;
  wire or_tmp_17;
  wire and_dcpl_81;
  wire and_dcpl_83;
  wire and_dcpl_84;
  wire nor_tmp_8;
  wire and_dcpl_100;
  wire and_dcpl_102;
  wire mux_tmp_27;
  wire and_dcpl_106;
  wire and_dcpl_108;
  wire and_dcpl_110;
  wire mux_tmp_36;
  wire mux_tmp_37;
  wire or_tmp_36;
  wire or_tmp_38;
  wire mux_tmp_42;
  wire or_tmp_47;
  wire and_dcpl_125;
  wire or_dcpl_8;
  wire or_dcpl_9;
  wire or_dcpl_10;
  wire or_dcpl_12;
  wire or_dcpl_13;
  wire and_dcpl_129;
  wire and_dcpl_132;
  wire or_tmp_59;
  wire and_dcpl_133;
  wire or_dcpl_20;
  wire or_dcpl_23;
  wire or_dcpl_26;
  wire or_dcpl_30;
  reg [8:0] COMP_LOOP_r_10_2_sva;
  reg [9:0] COPY_LOOP_1_i_12_3_sva_1;
  reg [10:0] COPY_LOOP_i_12_2_sva_1;
  reg [8:0] COMP_LOOP_1_f2_and_cse_sva;
  wire COMP_LOOP_or_ssc;
  reg reg_COMP_LOOP_1_acc_1_ftd;
  reg [63:0] reg_COMP_LOOP_1_acc_1_ftd_1;
  wire and_114_ssc;
  wire and_115_ssc;
  wire and_116_ssc;
  wire and_118_ssc;
  wire and_121_ssc;
  wire and_122_ssc;
  wire and_123_ssc;
  wire and_124_ssc;
  reg [62:0] reg_COMP_LOOP_1_f2_rem_cmp_a_ftd;
  reg [64:0] reg_COMP_LOOP_1_f2_rem_cmp_a_ftd_1;
  wire or_11_cse;
  reg reg_xt_rsc_cgo_cse;
  reg reg_vec_rsc_triosy_obj_ld_cse;
  reg [63:0] reg_COMP_LOOP_1_rem_cmp_b_63_0_cse;
  wire or_77_cse;
  wire and_147_cse;
  wire or_120_cse;
  wire COMP_LOOP_f2_nor_2_cse;
  wire or_38_cse;
  wire nor_27_cse;
  wire xt_rsci_wadr_d_mx0c2;
  wire xt_rsci_radr_d_mx0c5;
  wire [8:0] COMP_LOOP_1_f2_and_cse_sva_mx0w0;
  reg [8:0] STAGE_LOOP_base_8_0_sva;
  wire result_rsci_wadr_d_mx0c4;
  wire result_rsci_wadr_d_mx0c5;
  wire result_rsci_wadr_d_mx0c7;
  wire mux_34_itm;
  wire [8:0] STAGE_LOOP_base_lshift_itm;
  wire and_dcpl_151;
  wire and_dcpl_152;
  wire and_dcpl_155;
  wire [64:0] z_out_1;
  wire and_dcpl_182;
  wire [10:0] z_out_2;
  wire [11:0] nl_z_out_2;
  wire [64:0] z_out_3;
  wire [65:0] nl_z_out_3;
  reg [63:0] p_sva;
  reg [3:0] STAGE_LOOP_base_acc_cse_sva;
  reg [127:0] COMP_LOOP_f1_read_mem_xt_rsc_cse_sva;
  reg [127:0] COMP_LOOP_f1_read_mem_xt_rsc_2_cse_sva;
  reg [64:0] COMP_LOOP_acc_5_mut;
  reg [127:0] COMP_LOOP_4_f2_mul_mut;
  reg [127:0] COMP_LOOP_1_f2_mul_itm;
  reg [127:0] COMP_LOOP_2_f2_mul_itm;
  reg [64:0] COMP_LOOP_2_acc_1_itm;
  reg [127:0] COMP_LOOP_3_f2_mul_itm;
  reg [64:0] COMP_LOOP_3_acc_1_itm;
  reg [64:0] COMP_LOOP_4_acc_1_itm;
  wire [127:0] COMP_LOOP_4_f2_mul_mut_mx0w0;
  wire COPY_LOOP_1_i_12_3_sva_1_mx0c0;
  wire COMP_LOOP_1_acc_1_itm_mx0c3;
  wire COMP_LOOP_1_f2_and_cse_sva_mx0c2;
  wire and_142_cse;
  wire nor_23_cse;
  wire and_173_cse;
  wire and_177_cse;
  wire and_169_cse;
  wire and_171_itm;
  wire and_176_itm;
  wire and_179_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire and_218_cse;

  wire[0:0] mux_20_nl;
  wire[0:0] mux_18_nl;
  wire[0:0] and_145_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] or_22_nl;
  wire[0:0] mux_32_nl;
  wire[0:0] or_21_nl;
  wire[0:0] mux_31_nl;
  wire[0:0] and_144_nl;
  wire[0:0] mux_30_nl;
  wire[0:0] or_20_nl;
  wire[0:0] mux_29_nl;
  wire[0:0] nor_30_nl;
  wire[0:0] mux_45_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] mux_43_nl;
  wire[0:0] or_33_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] or_31_nl;
  wire[0:0] mux_41_nl;
  wire[0:0] mux_40_nl;
  wire[0:0] mux_39_nl;
  wire[0:0] or_30_nl;
  wire[0:0] or_29_nl;
  wire[0:0] mux_38_nl;
  wire[0:0] or_27_nl;
  wire[0:0] or_26_nl;
  wire[0:0] or_25_nl;
  wire[9:0] COPY_LOOP_i_COPY_LOOP_i_mux_nl;
  wire[9:0] COMP_LOOP_acc_nl;
  wire[10:0] nl_COMP_LOOP_acc_nl;
  wire[8:0] COMP_LOOP_mux_7_nl;
  wire[0:0] and_217_nl;
  wire[0:0] COPY_LOOP_i_or_nl;
  wire[0:0] COPY_LOOP_1_i_not_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] mux_75_nl;
  wire[0:0] or_74_nl;
  wire[0:0] COMP_LOOP_r_not_1_nl;
  wire[0:0] mux_84_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] and_136_nl;
  wire[8:0] COMP_LOOP_f2_mux_nl;
  wire[0:0] not_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] or_24_nl;
  wire[0:0] or_34_nl;
  wire[0:0] mux_69_nl;
  wire[0:0] or_68_nl;
  wire[0:0] mux_50_nl;
  wire[0:0] mux_49_nl;
  wire[0:0] or_36_nl;
  wire[0:0] mux_48_nl;
  wire[0:0] mux_55_nl;
  wire[0:0] mux_54_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] or_40_nl;
  wire[0:0] mux_51_nl;
  wire[0:0] mux_58_nl;
  wire[0:0] mux_57_nl;
  wire[0:0] mux_56_nl;
  wire[0:0] or_42_nl;
  wire[0:0] mux_61_nl;
  wire[0:0] mux_60_nl;
  wire[0:0] and_nl;
  wire[0:0] mux_59_nl;
  wire[0:0] mux_65_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] mux_63_nl;
  wire[0:0] mux_62_nl;
  wire[0:0] or_52_nl;
  wire[0:0] mux_67_nl;
  wire[0:0] mux_66_nl;
  wire[62:0] COMP_LOOP_f2_mux1h_1_nl;
  wire[0:0] COMP_LOOP_f2_nor_1_nl;
  wire[0:0] and_25_nl;
  wire[1:0] COMP_LOOP_nor_5_nl;
  wire[1:0] COMP_LOOP_nor_6_nl;
  wire[1:0] COMP_LOOP_mux_4_nl;
  wire[0:0] and_40_nl;
  wire[0:0] and_35_nl;
  wire[0:0] COMP_LOOP_nor_3_nl;
  wire[1:0] COMP_LOOP_COMP_LOOP_or_1_nl;
  wire[1:0] COMP_LOOP_and_nl;
  wire[1:0] COMP_LOOP_mux_3_nl;
  wire[0:0] COMP_LOOP_or_4_nl;
  wire[0:0] COMP_LOOP_nor_4_nl;
  wire[0:0] COMP_LOOP_or_5_nl;
  wire[0:0] mux_27_nl;
  wire[0:0] nand_2_nl;
  wire[0:0] mux_26_nl;
  wire[0:0] mux_25_nl;
  wire[0:0] or_15_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] mux_24_nl;
  wire[0:0] mux_23_nl;
  wire[0:0] or_14_nl;
  wire[0:0] nand_nl;
  wire[8:0] COMP_LOOP_f2_COMP_LOOP_f2_mux_nl;
  wire[0:0] COMP_LOOP_f2_or_1_nl;
  wire[0:0] COMP_LOOP_f2_COMP_LOOP_f2_and_nl;
  wire[0:0] COMP_LOOP_f2_COMP_LOOP_f2_and_1_nl;
  wire[63:0] COPY_LOOP_mux_1_nl;
  wire[0:0] and_85_nl;
  wire[7:0] COPY_LOOP_COPY_LOOP_mux_nl;
  wire[0:0] COPY_LOOP_or_nl;
  wire[0:0] COPY_LOOP_COPY_LOOP_or_nl;
  wire[0:0] COPY_LOOP_nor_1_nl;
  wire[8:0] COPY_LOOP_1_i_COPY_LOOP_1_i_mux_nl;
  wire[0:0] COPY_LOOP_1_i_or_1_nl;
  wire[0:0] COPY_LOOP_1_i_COPY_LOOP_1_i_or_nl;
  wire[0:0] mux_35_nl;
  wire[0:0] nor_24_nl;
  wire[0:0] mux_36_nl;
  wire[65:0] acc_1_nl;
  wire[66:0] nl_acc_1_nl;
  wire[63:0] COMP_LOOP_mux1h_13_nl;
  wire[9:0] COPY_LOOP_mux_8_nl;
  wire[63:0] COMP_LOOP_mux1h_14_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_COMP_LOOP_1_rem_cmp_b;
  assign nl_COMP_LOOP_1_rem_cmp_b = {1'b0, reg_COMP_LOOP_1_rem_cmp_b_63_0_cse};
  wire [3:0] nl_STAGE_LOOP_base_lshift_rg_s;
  assign nl_STAGE_LOOP_base_lshift_rg_s = z_out_2[3:0];
  wire [0:0] nl_peaceNTT_core_wait_dp_inst_xt_rsc_cgo_iro;
  assign nl_peaceNTT_core_wait_dp_inst_xt_rsc_cgo_iro = ~ mux_34_itm;
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_3_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_3_tr0 = COPY_LOOP_i_12_2_sva_1[10];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_244_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_244_tr0 = COPY_LOOP_1_i_12_3_sva_1[9];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_5_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_5_tr0 = COPY_LOOP_1_i_12_3_sva_1[9];
  wire [0:0] nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = STAGE_LOOP_acc_itm_4_1;
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
  .signd(32'sd1)) COMP_LOOP_1_rem_cmp (
      .a(COMP_LOOP_1_rem_cmp_a),
      .b(nl_COMP_LOOP_1_rem_cmp_b[64:0]),
      .z(COMP_LOOP_1_rem_cmp_z)
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
      .xt_rsc_cgo_iro(nl_peaceNTT_core_wait_dp_inst_xt_rsc_cgo_iro[0:0]),
      .xt_rsci_clken_d(xt_rsci_clken_d),
      .COMP_LOOP_1_f2_rem_cmp_z(COMP_LOOP_1_f2_rem_cmp_z),
      .xt_rsc_cgo(reg_xt_rsc_cgo_cse),
      .COMP_LOOP_1_f2_rem_cmp_z_oreg(COMP_LOOP_1_f2_rem_cmp_z_oreg)
    );
  peaceNTT_core_core_fsm peaceNTT_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .COPY_LOOP_C_3_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_C_3_tr0[0:0]),
      .COMP_LOOP_C_244_tr0(nl_peaceNTT_core_core_fsm_inst_COMP_LOOP_C_244_tr0[0:0]),
      .COPY_LOOP_1_C_5_tr0(nl_peaceNTT_core_core_fsm_inst_COPY_LOOP_1_C_5_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_peaceNTT_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign or_11_cse = (fsm_output[6:1]!=6'b000000);
  assign or_21_nl = (fsm_output[8:4]!=5'b10000);
  assign mux_32_nl = MUX_s_1_2_2(or_21_nl, or_tmp_17, fsm_output[2]);
  assign or_22_nl = (fsm_output[0]) | mux_32_nl;
  assign and_144_nl = (fsm_output[0]) & (fsm_output[2]);
  assign mux_31_nl = MUX_s_1_2_2(or_tmp_17, or_tmp_16, and_144_nl);
  assign mux_33_nl = MUX_s_1_2_2(or_22_nl, mux_31_nl, fsm_output[3]);
  assign or_20_nl = (~((fsm_output[0]) | (fsm_output[2]))) | (fsm_output[8:4]!=5'b00000);
  assign mux_29_nl = MUX_s_1_2_2(or_tmp_17, or_tmp_16, fsm_output[2]);
  assign mux_30_nl = MUX_s_1_2_2(or_20_nl, mux_29_nl, fsm_output[3]);
  assign mux_34_itm = MUX_s_1_2_2(mux_33_nl, mux_30_nl, fsm_output[1]);
  assign and_142_cse = (fsm_output[1]) & (fsm_output[5]);
  assign nor_23_cse = ~((fsm_output[1]) | (fsm_output[5]));
  assign COMP_LOOP_1_f2_rem_cmp_a = {reg_COMP_LOOP_1_f2_rem_cmp_a_ftd , reg_COMP_LOOP_1_f2_rem_cmp_a_ftd_1};
  assign COMP_LOOP_1_f2_rem_cmp_b = reg_COMP_LOOP_1_rem_cmp_b_63_0_cse;
  assign or_77_cse = (fsm_output[6:4]!=3'b000);
  assign and_147_cse = (fsm_output[2:1]==2'b11);
  assign nor_27_cse = ~(and_147_cse | (fsm_output[7:4]!=4'b0000));
  assign or_120_cse = (fsm_output[2:1]!=2'b00);
  assign COMP_LOOP_4_f2_mul_mut_mx0w0 = conv_u2u_128_128(reg_COMP_LOOP_1_acc_1_ftd_1
      * (COMP_LOOP_2_acc_1_itm[63:0]));
  assign COMP_LOOP_1_f2_and_cse_sva_mx0w0 = COMP_LOOP_r_10_2_sva & ({2'b11 , (STAGE_LOOP_base_8_0_sva[8:2])});
  assign nl_STAGE_LOOP_acc_nl = conv_u2s_4_5(STAGE_LOOP_base_acc_cse_sva) + 5'b11111;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign mux_tmp_9 = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), fsm_output[8]);
  assign and_dcpl_7 = ~((fsm_output[3]) | (fsm_output[0]));
  assign and_dcpl_8 = (fsm_output[2:1]==2'b01);
  assign and_dcpl_10 = ~((fsm_output[5:4]!=2'b00));
  assign and_dcpl_11 = ~((fsm_output[8:7]!=2'b00));
  assign and_dcpl_12 = and_dcpl_11 & (~ (fsm_output[6]));
  assign and_dcpl_13 = and_dcpl_12 & and_dcpl_10;
  assign and_dcpl_14 = and_dcpl_13 & and_dcpl_8 & and_dcpl_7;
  assign and_dcpl_20 = (fsm_output[3]) & (fsm_output[0]);
  assign and_dcpl_21 = (~ (fsm_output[8])) & (fsm_output[4]);
  assign and_dcpl_26 = and_dcpl_8 & and_dcpl_20;
  assign and_dcpl_27 = (fsm_output[5:4]==2'b11);
  assign and_dcpl_28 = (fsm_output[8:7]==2'b01);
  assign and_dcpl_29 = and_dcpl_28 & (fsm_output[6]);
  assign and_dcpl_30 = and_dcpl_29 & and_dcpl_27;
  assign and_dcpl_31 = and_dcpl_30 & and_dcpl_26;
  assign and_dcpl_32 = (fsm_output[3]) & (~ (fsm_output[0]));
  assign and_dcpl_33 = (fsm_output[2:1]==2'b10);
  assign and_dcpl_36 = and_dcpl_33 & and_dcpl_20;
  assign and_dcpl_37 = and_dcpl_30 & and_dcpl_36;
  assign and_dcpl_41 = and_dcpl_8 & and_dcpl_32;
  assign and_dcpl_44 = ~((fsm_output[2:1]!=2'b00));
  assign and_dcpl_45 = and_dcpl_44 & and_dcpl_32;
  assign and_dcpl_46 = (fsm_output[5:4]==2'b01);
  assign and_dcpl_47 = and_dcpl_11 & (fsm_output[6]);
  assign and_dcpl_53 = and_dcpl_33 & and_dcpl_7;
  assign and_dcpl_54 = and_dcpl_28 & (~ (fsm_output[6]));
  assign and_dcpl_55 = and_dcpl_54 & and_dcpl_46;
  assign and_dcpl_57 = and_147_cse & and_dcpl_20;
  assign and_dcpl_63 = and_dcpl_44 & and_dcpl_20;
  assign not_tmp_21 = MUX_s_1_2_2((fsm_output[5]), (~ (fsm_output[5])), fsm_output[1]);
  assign or_tmp_12 = (fsm_output[7]) | (fsm_output[0]) | (~((fsm_output[1]) & (fsm_output[5])));
  assign and_dcpl_71 = and_dcpl_13 & and_147_cse & and_dcpl_7;
  assign and_dcpl_72 = (~ (fsm_output[3])) & (fsm_output[0]);
  assign and_dcpl_73 = and_147_cse & and_dcpl_72;
  assign and_dcpl_74 = and_dcpl_13 & and_dcpl_73;
  assign and_dcpl_75 = and_dcpl_13 & and_dcpl_45;
  assign and_dcpl_76 = and_dcpl_13 & and_dcpl_63;
  assign and_dcpl_78 = (~ (fsm_output[8])) & (~ (fsm_output[6])) & and_dcpl_10;
  assign mux_tmp_18 = MUX_s_1_2_2((~ and_147_cse), or_120_cse, fsm_output[3]);
  assign or_tmp_16 = (fsm_output[8:4]!=5'b01111);
  assign or_tmp_17 = (fsm_output[8:4]!=5'b00000);
  assign and_dcpl_81 = (fsm_output[4]) & (fsm_output[2]);
  assign and_dcpl_83 = (fsm_output[6:5]==2'b11);
  assign and_dcpl_84 = and_dcpl_28 & and_dcpl_83;
  assign nor_tmp_8 = (fsm_output[2]) & (fsm_output[4]) & (fsm_output[5]) & (fsm_output[6])
      & (fsm_output[7]);
  assign and_dcpl_100 = (fsm_output[8:6]==3'b100) & and_dcpl_10;
  assign and_dcpl_102 = (fsm_output[5:4]==2'b10);
  assign or_24_nl = (fsm_output[6:5]!=2'b00);
  assign mux_tmp_27 = MUX_s_1_2_2((~ (fsm_output[7])), (fsm_output[7]), or_24_nl);
  assign and_dcpl_106 = and_dcpl_33 & and_dcpl_72;
  assign and_dcpl_108 = and_dcpl_47 & and_dcpl_10 & and_dcpl_106;
  assign and_dcpl_110 = and_dcpl_47 & and_dcpl_102 & and_dcpl_8 & and_dcpl_72;
  assign mux_tmp_36 = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), fsm_output[4]);
  assign or_34_nl = (fsm_output[5:4]!=2'b01);
  assign mux_tmp_37 = MUX_s_1_2_2(mux_tmp_36, or_34_nl, and_147_cse);
  assign or_tmp_36 = (fsm_output[6:5]!=2'b01);
  assign or_tmp_38 = (fsm_output[6:5]!=2'b10);
  assign mux_tmp_42 = MUX_s_1_2_2(or_tmp_38, or_tmp_36, fsm_output[4]);
  assign or_tmp_47 = (fsm_output[5:4]!=2'b10);
  assign and_dcpl_125 = and_dcpl_44 & and_dcpl_7;
  assign or_dcpl_8 = (fsm_output[3]) | (~ (fsm_output[0]));
  assign or_dcpl_9 = or_120_cse | or_dcpl_8;
  assign or_dcpl_10 = (fsm_output[5:4]!=2'b00);
  assign or_dcpl_12 = (fsm_output[8:6]!=3'b000);
  assign or_dcpl_13 = or_dcpl_12 | or_dcpl_10;
  assign or_68_nl = (fsm_output[3:2]!=2'b10);
  assign mux_69_nl = MUX_s_1_2_2(or_68_nl, mux_tmp_18, fsm_output[0]);
  assign and_dcpl_129 = (~ mux_69_nl) & (~ (fsm_output[7])) & and_dcpl_78;
  assign and_dcpl_132 = and_dcpl_13 & and_dcpl_106;
  assign or_tmp_59 = (fsm_output[8:7]!=2'b01);
  assign and_dcpl_133 = and_dcpl_30 & and_dcpl_41;
  assign or_dcpl_20 = (~ (fsm_output[3])) | (fsm_output[0]);
  assign or_dcpl_23 = ~((fsm_output[3]) & (fsm_output[0]));
  assign or_dcpl_26 = (fsm_output[2:1]!=2'b01);
  assign or_dcpl_30 = or_dcpl_13 | or_dcpl_26 | or_dcpl_23;
  assign result_rsci_wadr_d_mx0c4 = and_dcpl_55 & and_dcpl_57;
  assign result_rsci_wadr_d_mx0c5 = and_dcpl_54 & and_dcpl_27 & and_dcpl_36;
  assign result_rsci_wadr_d_mx0c7 = and_dcpl_30 & and_dcpl_63;
  assign xt_rsci_radr_d_mx0c5 = and_dcpl_13 & and_dcpl_26;
  assign xt_rsci_wadr_d_mx0c2 = and_dcpl_30 & and_dcpl_57;
  assign COPY_LOOP_1_i_12_3_sva_1_mx0c0 = and_dcpl_13 & and_dcpl_125;
  assign COMP_LOOP_1_acc_1_itm_mx0c3 = and_dcpl_84 & and_dcpl_81 & and_dcpl_32;
  assign COMP_LOOP_1_f2_and_cse_sva_mx0c2 = and_dcpl_100 & and_dcpl_125;
  assign COMP_LOOP_f2_nor_2_cse = ~(and_dcpl_75 | and_dcpl_76);
  assign or_36_nl = (~((fsm_output[1]) | (fsm_output[2]) | (fsm_output[4]))) | (fsm_output[5]);
  assign mux_49_nl = MUX_s_1_2_2(mux_tmp_37, or_36_nl, fsm_output[3]);
  assign mux_48_nl = MUX_s_1_2_2(mux_tmp_37, (fsm_output[5]), fsm_output[3]);
  assign mux_50_nl = MUX_s_1_2_2(mux_49_nl, mux_48_nl, fsm_output[0]);
  assign and_114_ssc = (~ mux_50_nl) & and_dcpl_12;
  assign or_38_cse = (fsm_output[2]) | (fsm_output[4]);
  assign or_40_nl = (fsm_output[6:4]!=3'b011);
  assign mux_53_nl = MUX_s_1_2_2(mux_tmp_42, or_40_nl, fsm_output[2]);
  assign mux_51_nl = MUX_s_1_2_2(or_tmp_38, or_tmp_36, or_38_cse);
  assign mux_54_nl = MUX_s_1_2_2(mux_53_nl, mux_51_nl, fsm_output[1]);
  assign mux_55_nl = MUX_s_1_2_2(mux_54_nl, or_tmp_36, fsm_output[3]);
  assign and_115_ssc = (~ mux_55_nl) & and_dcpl_11;
  assign mux_56_nl = MUX_s_1_2_2((~ (fsm_output[5])), (fsm_output[5]), or_38_cse);
  assign or_42_nl = (~((fsm_output[2]) | (fsm_output[4]))) | (fsm_output[5]);
  assign mux_57_nl = MUX_s_1_2_2(mux_56_nl, or_42_nl, fsm_output[1]);
  assign mux_58_nl = MUX_s_1_2_2(mux_57_nl, (fsm_output[5]), fsm_output[3]);
  assign and_116_ssc = (~ mux_58_nl) & and_dcpl_47;
  assign and_118_ssc = ((fsm_output[4:1]!=4'b0000)) & and_dcpl_11 & and_dcpl_83;
  assign and_121_ssc = (~((fsm_output[4:1]==4'b1111))) & and_dcpl_28 & (fsm_output[6:5]==2'b00);
  assign and_nl = (~((fsm_output[2]) & (fsm_output[4]))) & (fsm_output[5]);
  assign mux_59_nl = MUX_s_1_2_2((fsm_output[5]), (~ (fsm_output[5])), and_dcpl_81);
  assign mux_60_nl = MUX_s_1_2_2(and_nl, mux_59_nl, fsm_output[1]);
  assign mux_61_nl = MUX_s_1_2_2((fsm_output[5]), mux_60_nl, fsm_output[3]);
  assign and_122_ssc = mux_61_nl & and_dcpl_54;
  assign mux_63_nl = MUX_s_1_2_2(or_tmp_38, or_tmp_36, and_dcpl_81);
  assign or_52_nl = (fsm_output[6:4]!=3'b100);
  assign mux_62_nl = MUX_s_1_2_2(or_52_nl, mux_tmp_42, fsm_output[2]);
  assign mux_64_nl = MUX_s_1_2_2(mux_63_nl, mux_62_nl, fsm_output[1]);
  assign mux_65_nl = MUX_s_1_2_2(or_tmp_38, mux_64_nl, fsm_output[3]);
  assign and_123_ssc = (~ mux_65_nl) & and_dcpl_28;
  assign mux_66_nl = MUX_s_1_2_2(or_tmp_47, mux_tmp_36, or_120_cse);
  assign mux_67_nl = MUX_s_1_2_2((fsm_output[5]), (~ mux_66_nl), fsm_output[3]);
  assign and_124_ssc = mux_67_nl & and_dcpl_29;
  assign COMP_LOOP_or_ssc = and_dcpl_14 | and_dcpl_129 | and_dcpl_108 | COMP_LOOP_1_acc_1_itm_mx0c3;
  assign vec_rsci_radr_d = {COPY_LOOP_1_i_12_3_sva_1 , and_dcpl_14 , 1'b0};
  assign vec_rsci_readA_r_ram_ir_internal_RMASK_B_d = ~((~ and_dcpl_12) | (fsm_output[5:2]!=4'b0000)
      | (~((fsm_output[1]) ^ (fsm_output[0]))));
  assign and_25_nl = ((fsm_output[6]) ^ (fsm_output[2])) & (fsm_output[7]) & ((fsm_output[5])
      ^ (fsm_output[1])) & and_dcpl_21 & and_dcpl_20;
  assign result_rsci_d_d = MUX_v_64_2_2((COMP_LOOP_1_rem_cmp_z[63:0]), COMP_LOOP_1_f2_rem_cmp_z_oreg,
      and_25_nl);
  assign and_40_nl = and_dcpl_30 & and_147_cse & and_dcpl_32;
  assign COMP_LOOP_mux_4_nl = MUX_v_2_2_2(2'b10, 2'b01, and_40_nl);
  assign and_35_nl = and_dcpl_30 & and_dcpl_33 & and_dcpl_32;
  assign COMP_LOOP_nor_6_nl = ~(MUX_v_2_2_2(COMP_LOOP_mux_4_nl, 2'b11, and_35_nl));
  assign COMP_LOOP_nor_5_nl = ~(MUX_v_2_2_2(COMP_LOOP_nor_6_nl, 2'b11, and_dcpl_37));
  assign result_rsci_radr_d = {COMP_LOOP_1_f2_and_cse_sva , COMP_LOOP_nor_5_nl ,
      1'b0};
  assign COMP_LOOP_nor_3_nl = ~(result_rsci_wadr_d_mx0c4 | result_rsci_wadr_d_mx0c5
      | (and_dcpl_29 & and_dcpl_46 & and_dcpl_26) | result_rsci_wadr_d_mx0c7);
  assign COMP_LOOP_or_4_nl = (and_dcpl_55 & and_dcpl_53) | result_rsci_wadr_d_mx0c7;
  assign COMP_LOOP_mux_3_nl = MUX_v_2_2_2(2'b01, 2'b10, COMP_LOOP_or_4_nl);
  assign COMP_LOOP_nor_4_nl = ~((and_dcpl_47 & and_dcpl_46 & and_dcpl_45) | result_rsci_wadr_d_mx0c5);
  assign COMP_LOOP_and_nl = MUX_v_2_2_2(2'b00, COMP_LOOP_mux_3_nl, COMP_LOOP_nor_4_nl);
  assign COMP_LOOP_or_5_nl = (and_dcpl_12 & and_dcpl_27 & and_dcpl_41) | result_rsci_wadr_d_mx0c4;
  assign COMP_LOOP_COMP_LOOP_or_1_nl = MUX_v_2_2_2(COMP_LOOP_and_nl, 2'b11, COMP_LOOP_or_5_nl);
  assign result_rsci_wadr_d = {COMP_LOOP_nor_3_nl , COMP_LOOP_r_10_2_sva , COMP_LOOP_COMP_LOOP_or_1_nl};
  assign or_15_nl = (fsm_output[0]) | (fsm_output[1]) | (fsm_output[5]);
  assign nand_1_nl = ~((fsm_output[0]) & not_tmp_21);
  assign mux_25_nl = MUX_s_1_2_2(or_15_nl, nand_1_nl, fsm_output[7]);
  assign mux_26_nl = MUX_s_1_2_2(or_tmp_12, mux_25_nl, fsm_output[6]);
  assign nand_2_nl = ~((fsm_output[3]) & (~ mux_26_nl));
  assign or_14_nl = (~ (fsm_output[7])) | (fsm_output[0]) | (fsm_output[1]) | (fsm_output[5]);
  assign mux_23_nl = MUX_s_1_2_2(or_14_nl, or_tmp_12, fsm_output[6]);
  assign nand_nl = ~((~((fsm_output[6]) | (~ (fsm_output[7])) | (~ (fsm_output[0]))))
      & not_tmp_21);
  assign mux_24_nl = MUX_s_1_2_2(mux_23_nl, nand_nl, fsm_output[3]);
  assign mux_27_nl = MUX_s_1_2_2(nand_2_nl, mux_24_nl, fsm_output[2]);
  assign result_rsci_we_d_pff = (~ mux_27_nl) & and_dcpl_21;
  assign result_rsci_readA_r_ram_ir_internal_RMASK_B_d = and_dcpl_29 & (fsm_output[5])
      & (fsm_output[3]) & (((fsm_output[1:0]==2'b11)) ^ (fsm_output[2])) & (fsm_output[4]);
  assign COMP_LOOP_f2_or_1_nl = and_dcpl_74 | and_dcpl_75 | and_dcpl_76;
  assign COMP_LOOP_f2_COMP_LOOP_f2_mux_nl = MUX_v_9_2_2(COMP_LOOP_1_f2_and_cse_sva_mx0w0,
      COMP_LOOP_1_f2_and_cse_sva, COMP_LOOP_f2_or_1_nl);
  assign COMP_LOOP_f2_COMP_LOOP_f2_and_nl = (STAGE_LOOP_base_8_0_sva[1]) & COMP_LOOP_f2_nor_2_cse;
  assign COMP_LOOP_f2_COMP_LOOP_f2_and_1_nl = (STAGE_LOOP_base_8_0_sva[0]) & (~(and_dcpl_74
      | and_dcpl_76));
  assign twiddle_rsci_radr_d = {1'b0 , COMP_LOOP_f2_COMP_LOOP_f2_mux_nl , COMP_LOOP_f2_COMP_LOOP_f2_and_nl
      , COMP_LOOP_f2_COMP_LOOP_f2_and_1_nl};
  assign twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d = (~ mux_tmp_18) & (~ (fsm_output[7]))
      & and_dcpl_78;
  assign and_85_nl = and_dcpl_84 & and_dcpl_81 & and_dcpl_20;
  assign COPY_LOOP_mux_1_nl = MUX_v_64_2_2(vec_rsci_q_d, result_rsci_q_d, and_85_nl);
  assign xt_rsci_d_d = {COPY_LOOP_mux_1_nl , reg_COMP_LOOP_1_acc_1_ftd_1};
  assign COPY_LOOP_or_nl = (and_dcpl_13 & and_dcpl_41) | xt_rsci_radr_d_mx0c5;
  assign COPY_LOOP_COPY_LOOP_mux_nl = MUX_v_8_2_2((COMP_LOOP_r_10_2_sva[7:0]), (COMP_LOOP_r_10_2_sva[8:1]),
      COPY_LOOP_or_nl);
  assign COPY_LOOP_COPY_LOOP_or_nl = ((COMP_LOOP_r_10_2_sva[0]) & COMP_LOOP_f2_nor_2_cse)
      | and_dcpl_71 | and_dcpl_74;
  assign COPY_LOOP_nor_1_nl = ~(and_dcpl_74 | and_dcpl_76 | xt_rsci_radr_d_mx0c5);
  assign xt_rsci_radr_d = {COPY_LOOP_COPY_LOOP_mux_nl , COPY_LOOP_COPY_LOOP_or_nl
      , COPY_LOOP_nor_1_nl};
  assign COPY_LOOP_1_i_or_1_nl = and_dcpl_37 | xt_rsci_wadr_d_mx0c2;
  assign COPY_LOOP_1_i_COPY_LOOP_1_i_mux_nl = MUX_v_9_2_2((COPY_LOOP_1_i_12_3_sva_1[9:1]),
      COMP_LOOP_1_f2_and_cse_sva, COPY_LOOP_1_i_or_1_nl);
  assign COPY_LOOP_1_i_COPY_LOOP_1_i_or_nl = ((COPY_LOOP_1_i_12_3_sva_1[0]) & (~
      xt_rsci_wadr_d_mx0c2)) | and_dcpl_37;
  assign xt_rsci_wadr_d = {COPY_LOOP_1_i_COPY_LOOP_1_i_mux_nl , COPY_LOOP_1_i_COPY_LOOP_1_i_or_nl};
  assign nor_24_nl = ~((~ (fsm_output[1])) | (fsm_output[2]) | (fsm_output[4]) |
      (fsm_output[5]) | (fsm_output[6]) | (fsm_output[7]));
  assign mux_35_nl = MUX_s_1_2_2(nor_24_nl, nor_tmp_8, fsm_output[3]);
  assign xt_rsci_we_d_pff = mux_35_nl & (~ (fsm_output[8])) & (fsm_output[0]);
  assign mux_36_nl = MUX_s_1_2_2(and_147_cse, (~ (fsm_output[2])), fsm_output[3]);
  assign xt_rsci_readA_r_ram_ir_internal_RMASK_B_d = mux_36_nl & (~ (fsm_output[7]))
      & and_dcpl_78;
  assign and_dcpl_151 = (~ (fsm_output[7])) & (fsm_output[0]);
  assign and_dcpl_152 = ~((fsm_output[6]) | (fsm_output[8]));
  assign and_dcpl_155 = ~((fsm_output[4:3]!=2'b00));
  assign and_169_cse = and_dcpl_155 & (fsm_output[2]);
  assign and_173_cse = (fsm_output[6]) & (~ (fsm_output[8])) & and_dcpl_151;
  assign and_177_cse = and_dcpl_155 & (~ (fsm_output[2]));
  assign and_dcpl_182 = (fsm_output[4:2]==3'b001) & nor_23_cse & and_dcpl_152 & (~
      (fsm_output[7])) & (fsm_output[0]);
  assign and_171_itm = and_169_cse & and_142_cse & and_dcpl_152 & and_dcpl_151;
  assign and_176_itm = and_169_cse & nor_23_cse & and_173_cse;
  assign and_179_itm = and_177_cse & and_142_cse & and_173_cse;
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_20_nl, mux_18_nl, fsm_output[0]) ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_xt_rsc_cgo_cse <= 1'b0;
      reg_vec_rsc_triosy_obj_ld_cse <= 1'b0;
    end
    else begin
      reg_xt_rsc_cgo_cse <= ~ mux_34_itm;
      reg_vec_rsc_triosy_obj_ld_cse <= and_dcpl_100 & and_dcpl_44 & (~ (fsm_output[3]))
          & (fsm_output[0]) & STAGE_LOOP_acc_itm_4_1;
    end
  end
  always @(posedge clk) begin
    COMP_LOOP_1_rem_cmp_a <= MUX_v_65_2_2(z_out_1, COMP_LOOP_acc_5_mut, nor_30_nl);
    reg_COMP_LOOP_1_rem_cmp_b_63_0_cse <= p_sva;
    reg_COMP_LOOP_1_f2_rem_cmp_a_ftd <= MUX_v_63_2_2(63'b000000000000000000000000000000000000000000000000000000000000000,
        COMP_LOOP_f2_mux1h_1_nl, COMP_LOOP_f2_nor_1_nl);
    reg_COMP_LOOP_1_f2_rem_cmp_a_ftd_1 <= MUX1HOT_v_65_9_2((COMP_LOOP_4_f2_mul_mut_mx0w0[64:0]),
        (COMP_LOOP_4_f2_mul_mut[64:0]), (COMP_LOOP_1_f2_mul_itm[64:0]), (COMP_LOOP_2_f2_mul_itm[64:0]),
        (COMP_LOOP_3_f2_mul_itm[64:0]), COMP_LOOP_4_acc_1_itm, ({reg_COMP_LOOP_1_acc_1_ftd
        , reg_COMP_LOOP_1_acc_1_ftd_1}), COMP_LOOP_2_acc_1_itm, COMP_LOOP_3_acc_1_itm,
        {and_dcpl_75 , and_114_ssc , and_115_ssc , and_116_ssc , and_118_ssc , and_121_ssc
        , and_122_ssc , and_123_ssc , and_124_ssc});
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_1_i_12_3_sva_1 <= 10'b0000000000;
    end
    else if ( COPY_LOOP_1_i_12_3_sva_1_mx0c0 | (and_dcpl_13 & and_dcpl_53) | and_dcpl_71
        | and_dcpl_31 ) begin
      COPY_LOOP_1_i_12_3_sva_1 <= MUX_v_10_2_2(10'b0000000000, COPY_LOOP_i_COPY_LOOP_i_mux_nl,
          COPY_LOOP_1_i_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      COPY_LOOP_i_12_2_sva_1 <= 11'b00000000000;
    end
    else if ( ~(or_dcpl_13 | or_dcpl_9) ) begin
      COPY_LOOP_i_12_2_sva_1 <= z_out_2;
    end
  end
  always @(posedge clk) begin
    if ( MUX_s_1_2_2(mux_79_nl, (fsm_output[8]), fsm_output[3]) ) begin
      STAGE_LOOP_base_acc_cse_sva <= MUX_v_4_2_2(4'b1010, (z_out_2[3:0]), and_dcpl_132);
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_132 | and_dcpl_133 ) begin
      COMP_LOOP_r_10_2_sva <= MUX_v_9_2_2(9'b000000000, (COPY_LOOP_1_i_12_3_sva_1[8:0]),
          COMP_LOOP_r_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( mux_84_nl | (fsm_output[8]) ) begin
      STAGE_LOOP_base_8_0_sva <= STAGE_LOOP_base_lshift_itm;
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_71 | and_dcpl_133 | COMP_LOOP_1_f2_and_cse_sva_mx0c2 ) begin
      COMP_LOOP_1_f2_and_cse_sva <= MUX_v_9_2_2(9'b000000000, COMP_LOOP_f2_mux_nl,
          not_nl);
    end
  end
  always @(posedge clk) begin
    if ( and_dcpl_129 | and_dcpl_110 ) begin
      COMP_LOOP_2_acc_1_itm <= MUX_v_65_2_2(({1'b0 , (xt_rsci_q_d[63:0])}), z_out_3,
          and_dcpl_110);
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_13 | or_120_cse | or_dcpl_20) ) begin
      COMP_LOOP_4_f2_mul_mut <= COMP_LOOP_4_f2_mul_mut_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_13 | or_120_cse | or_dcpl_23) ) begin
      COMP_LOOP_3_f2_mul_itm <= COMP_LOOP_4_f2_mul_mut_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_13 | or_dcpl_26 | or_dcpl_20) ) begin
      COMP_LOOP_2_f2_mul_itm <= COMP_LOOP_4_f2_mul_mut_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_30 ) begin
      COMP_LOOP_f1_read_mem_xt_rsc_2_cse_sva <= xt_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( ~ or_dcpl_30 ) begin
      COMP_LOOP_1_f2_mul_itm <= COMP_LOOP_4_f2_mul_mut_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_13 | (fsm_output[2:1]!=2'b10) | or_dcpl_20) ) begin
      COMP_LOOP_f1_read_mem_xt_rsc_cse_sva <= xt_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_dcpl_12 | or_tmp_47 | (~ and_147_cse) | or_dcpl_8) ) begin
      COMP_LOOP_4_acc_1_itm <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( (and_dcpl_12 & and_dcpl_102 & and_dcpl_73) | and_dcpl_108 | and_dcpl_110
        | (and_dcpl_54 & and_dcpl_10 & and_dcpl_44 & and_dcpl_72) ) begin
      COMP_LOOP_acc_5_mut <= z_out_1;
    end
  end
  always @(posedge clk) begin
    if ( ~(or_tmp_59 | (fsm_output[6]) | or_dcpl_10 | or_dcpl_9) ) begin
      COMP_LOOP_3_acc_1_itm <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( COMP_LOOP_or_ssc ) begin
      reg_COMP_LOOP_1_acc_1_ftd <= z_out_3[64];
      reg_COMP_LOOP_1_acc_1_ftd_1 <= MUX1HOT_v_64_4_2(vec_rsci_q_d, twiddle_rsci_q_d,
          (z_out_3[63:0]), result_rsci_q_d, {and_dcpl_14 , and_dcpl_129 , and_dcpl_108
          , COMP_LOOP_1_acc_1_itm_mx0c3});
    end
  end
  assign mux_20_nl = MUX_s_1_2_2(mux_tmp_9, (fsm_output[8]), or_11_cse);
  assign and_145_nl = (fsm_output[8:7]==2'b11);
  assign mux_18_nl = MUX_s_1_2_2(and_145_nl, (fsm_output[8]), or_11_cse);
  assign or_33_nl = (fsm_output[6]) | (~ (fsm_output[1])) | (fsm_output[5]) | (~
      (fsm_output[7]));
  assign mux_43_nl = MUX_s_1_2_2(or_33_nl, mux_tmp_27, fsm_output[4]);
  assign or_31_nl = (fsm_output[6]) | (fsm_output[1]) | (~ (fsm_output[5])) | (fsm_output[7]);
  assign mux_42_nl = MUX_s_1_2_2(mux_tmp_27, or_31_nl, fsm_output[4]);
  assign mux_44_nl = MUX_s_1_2_2(mux_43_nl, mux_42_nl, fsm_output[3]);
  assign or_30_nl = (fsm_output[5]) | (~ (fsm_output[7]));
  assign or_29_nl = nor_23_cse | (fsm_output[7]);
  assign mux_39_nl = MUX_s_1_2_2(or_30_nl, or_29_nl, fsm_output[6]);
  assign or_27_nl = (~ (fsm_output[5])) | (fsm_output[7]);
  assign or_26_nl = and_142_cse | (fsm_output[7]);
  assign mux_38_nl = MUX_s_1_2_2(or_27_nl, or_26_nl, fsm_output[6]);
  assign mux_40_nl = MUX_s_1_2_2(mux_39_nl, mux_38_nl, fsm_output[4]);
  assign or_25_nl = (fsm_output[4]) | mux_tmp_27;
  assign mux_41_nl = MUX_s_1_2_2(mux_40_nl, or_25_nl, fsm_output[3]);
  assign mux_45_nl = MUX_s_1_2_2(mux_44_nl, mux_41_nl, fsm_output[2]);
  assign nor_30_nl = ~(mux_45_nl | (fsm_output[8]));
  assign COMP_LOOP_f2_mux1h_1_nl = MUX1HOT_v_63_5_2((COMP_LOOP_4_f2_mul_mut_mx0w0[127:65]),
      (COMP_LOOP_4_f2_mul_mut[127:65]), (COMP_LOOP_1_f2_mul_itm[127:65]), (COMP_LOOP_2_f2_mul_itm[127:65]),
      (COMP_LOOP_3_f2_mul_itm[127:65]), {and_dcpl_75 , and_114_ssc , and_115_ssc
      , and_116_ssc , and_118_ssc});
  assign COMP_LOOP_f2_nor_1_nl = ~(and_121_ssc | and_122_ssc | and_123_ssc | and_124_ssc);
  assign and_217_nl = (fsm_output==9'b011111011);
  assign COMP_LOOP_mux_7_nl = MUX_v_9_2_2(COMP_LOOP_r_10_2_sva, COMP_LOOP_1_f2_and_cse_sva,
      and_217_nl);
  assign nl_COMP_LOOP_acc_nl = conv_u2u_9_10(COMP_LOOP_mux_7_nl) + 10'b0000000001;
  assign COMP_LOOP_acc_nl = nl_COMP_LOOP_acc_nl[9:0];
  assign COPY_LOOP_i_or_nl = and_dcpl_71 | and_dcpl_31;
  assign COPY_LOOP_i_COPY_LOOP_i_mux_nl = MUX_v_10_2_2((COPY_LOOP_i_12_2_sva_1[9:0]),
      COMP_LOOP_acc_nl, COPY_LOOP_i_or_nl);
  assign COPY_LOOP_1_i_not_nl = ~ COPY_LOOP_1_i_12_3_sva_1_mx0c0;
  assign mux_77_nl = MUX_s_1_2_2(mux_tmp_9, (fsm_output[8]), or_77_cse);
  assign mux_76_nl = MUX_s_1_2_2(or_tmp_59, (fsm_output[8]), or_77_cse);
  assign mux_78_nl = MUX_s_1_2_2(mux_77_nl, mux_76_nl, fsm_output[2]);
  assign or_74_nl = (fsm_output[2]) | (fsm_output[4]) | (fsm_output[5]) | (fsm_output[6]);
  assign mux_75_nl = MUX_s_1_2_2(or_tmp_59, (fsm_output[8]), or_74_nl);
  assign mux_79_nl = MUX_s_1_2_2(mux_78_nl, mux_75_nl, fsm_output[1]);
  assign COMP_LOOP_r_not_1_nl = ~ and_dcpl_132;
  assign mux_83_nl = MUX_s_1_2_2(nor_27_cse, nor_tmp_8, fsm_output[3]);
  assign and_136_nl = or_120_cse & (fsm_output[7:4]==4'b1111);
  assign mux_82_nl = MUX_s_1_2_2(nor_27_cse, and_136_nl, fsm_output[3]);
  assign mux_84_nl = MUX_s_1_2_2(mux_83_nl, mux_82_nl, fsm_output[0]);
  assign COMP_LOOP_f2_mux_nl = MUX_v_9_2_2(COMP_LOOP_1_f2_and_cse_sva_mx0w0, (COPY_LOOP_1_i_12_3_sva_1[8:0]),
      COMP_LOOP_1_f2_and_cse_sva_mx0c2);
  assign not_nl = ~ and_dcpl_133;
  assign and_218_cse = and_177_cse & nor_23_cse & and_dcpl_152 & (fsm_output[7])
      & (fsm_output[0]);
  assign COMP_LOOP_mux1h_13_nl = MUX1HOT_v_64_4_2((COMP_LOOP_f1_read_mem_xt_rsc_2_cse_sva[127:64]),
      (COMP_LOOP_f1_read_mem_xt_rsc_cse_sva[63:0]), (COMP_LOOP_f1_read_mem_xt_rsc_cse_sva[127:64]),
      (COMP_LOOP_f1_read_mem_xt_rsc_2_cse_sva[63:0]), {and_171_itm , and_176_itm
      , and_179_itm , and_218_cse});
  assign nl_acc_1_nl = ({1'b1 , COMP_LOOP_mux1h_13_nl , 1'b1}) + conv_u2u_65_66({(~
      COMP_LOOP_1_f2_rem_cmp_z_oreg) , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[65:0];
  assign z_out_1 = readslicef_66_65_1(acc_1_nl);
  assign COPY_LOOP_mux_8_nl = MUX_v_10_2_2(COPY_LOOP_1_i_12_3_sva_1, ({6'b000000
      , STAGE_LOOP_base_acc_cse_sva}), and_dcpl_182);
  assign nl_z_out_2 = conv_u2u_10_11(COPY_LOOP_mux_8_nl) + conv_s2u_2_11({and_dcpl_182
      , 1'b1});
  assign z_out_2 = nl_z_out_2[10:0];
  assign COMP_LOOP_mux1h_14_nl = MUX1HOT_v_64_4_2((COMP_LOOP_f1_read_mem_xt_rsc_cse_sva[127:64]),
      (COMP_LOOP_f1_read_mem_xt_rsc_2_cse_sva[127:64]), (COMP_LOOP_f1_read_mem_xt_rsc_2_cse_sva[63:0]),
      (COMP_LOOP_f1_read_mem_xt_rsc_cse_sva[63:0]), {and_179_itm , and_171_itm ,
      and_218_cse , and_176_itm});
  assign nl_z_out_3 = conv_u2u_64_65(COMP_LOOP_mux1h_14_nl) + conv_u2u_64_65(COMP_LOOP_1_f2_rem_cmp_z_oreg);
  assign z_out_3 = nl_z_out_3[64:0];

  function automatic [62:0] MUX1HOT_v_63_5_2;
    input [62:0] input_4;
    input [62:0] input_3;
    input [62:0] input_2;
    input [62:0] input_1;
    input [62:0] input_0;
    input [4:0] sel;
    reg [62:0] result;
  begin
    result = input_0 & {63{sel[0]}};
    result = result | ( input_1 & {63{sel[1]}});
    result = result | ( input_2 & {63{sel[2]}});
    result = result | ( input_3 & {63{sel[3]}});
    result = result | ( input_4 & {63{sel[4]}});
    MUX1HOT_v_63_5_2 = result;
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


  function automatic [64:0] MUX1HOT_v_65_9_2;
    input [64:0] input_8;
    input [64:0] input_7;
    input [64:0] input_6;
    input [64:0] input_5;
    input [64:0] input_4;
    input [64:0] input_3;
    input [64:0] input_2;
    input [64:0] input_1;
    input [64:0] input_0;
    input [8:0] sel;
    reg [64:0] result;
  begin
    result = input_0 & {65{sel[0]}};
    result = result | ( input_1 & {65{sel[1]}});
    result = result | ( input_2 & {65{sel[2]}});
    result = result | ( input_3 & {65{sel[3]}});
    result = result | ( input_4 & {65{sel[4]}});
    result = result | ( input_5 & {65{sel[5]}});
    result = result | ( input_6 & {65{sel[6]}});
    result = result | ( input_7 & {65{sel[7]}});
    result = result | ( input_8 & {65{sel[8]}});
    MUX1HOT_v_65_9_2 = result;
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


  function automatic [0:0] readslicef_5_1_4;
    input [4:0] vector;
    reg [4:0] tmp;
  begin
    tmp = vector >> 4;
    readslicef_5_1_4 = tmp[0:0];
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


  function automatic [10:0] conv_s2u_2_11 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_11 = {{9{vector[1]}}, vector};
  end
  endfunction


  function automatic [4:0] conv_u2s_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2s_4_5 =  {1'b0, vector};
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


  function automatic [64:0] conv_u2u_64_65 ;
    input [63:0]  vector ;
  begin
    conv_u2u_64_65 = {1'b0, vector};
  end
  endfunction


  function automatic [65:0] conv_u2u_65_66 ;
    input [64:0]  vector ;
  begin
    conv_u2u_65_66 = {1'b0, vector};
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
  wire [11:0] vec_rsci_radr_d;
  wire vec_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] result_rsci_d_d;
  wire [63:0] result_rsci_q_d;
  wire [11:0] result_rsci_radr_d;
  wire [11:0] result_rsci_wadr_d;
  wire result_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_rsci_q_d;
  wire [11:0] twiddle_rsci_radr_d;
  wire twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire xt_rsci_clken_d;
  wire [127:0] xt_rsci_d_d;
  wire [127:0] xt_rsci_q_d;
  wire [9:0] xt_rsci_radr_d;
  wire [9:0] xt_rsci_wadr_d;
  wire xt_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [127:0] COMP_LOOP_1_f2_rem_cmp_a;
  wire [63:0] COMP_LOOP_1_f2_rem_cmp_b;
  wire [63:0] COMP_LOOP_1_f2_rem_cmp_z;
  wire xt_rsc_clken;
  wire [127:0] xt_rsc_q;
  wire [9:0] xt_rsc_radr;
  wire xt_rsc_we;
  wire [127:0] xt_rsc_d;
  wire [9:0] xt_rsc_wadr;
  wire result_rsci_we_d_iff;
  wire xt_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  mgc_rem #(.width_a(32'sd128),
  .width_b(32'sd64),
  .signd(32'sd0)) COMP_LOOP_1_f2_rem_cmp (
      .a(COMP_LOOP_1_f2_rem_cmp_a),
      .b(COMP_LOOP_1_f2_rem_cmp_b),
      .z(COMP_LOOP_1_f2_rem_cmp_z)
    );
  BLOCK_1R1W_RBW #(.addr_width(32'sd10),
  .data_width(32'sd128),
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
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_1_12_64_4096_4096_64_1_gen vec_rsci (
      .q(vec_rsc_q),
      .radr(vec_rsc_radr),
      .q_d(vec_rsci_q_d),
      .radr_d(vec_rsci_radr_d),
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
      .radr_d(result_rsci_radr_d),
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
  peaceNTT_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_en_6_10_128_1024_1024_128_1_gen xt_rsci
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
      .wadr_d(xt_rsci_wadr_d),
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
      .vec_rsci_radr_d(vec_rsci_radr_d),
      .vec_rsci_readA_r_ram_ir_internal_RMASK_B_d(vec_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .result_rsci_d_d(result_rsci_d_d),
      .result_rsci_q_d(result_rsci_q_d),
      .result_rsci_radr_d(result_rsci_radr_d),
      .result_rsci_wadr_d(result_rsci_wadr_d),
      .result_rsci_readA_r_ram_ir_internal_RMASK_B_d(result_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsci_q_d(twiddle_rsci_q_d),
      .twiddle_rsci_radr_d(twiddle_rsci_radr_d),
      .twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .xt_rsci_clken_d(xt_rsci_clken_d),
      .xt_rsci_d_d(xt_rsci_d_d),
      .xt_rsci_q_d(xt_rsci_q_d),
      .xt_rsci_radr_d(xt_rsci_radr_d),
      .xt_rsci_wadr_d(xt_rsci_wadr_d),
      .xt_rsci_readA_r_ram_ir_internal_RMASK_B_d(xt_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .COMP_LOOP_1_f2_rem_cmp_a(COMP_LOOP_1_f2_rem_cmp_a),
      .COMP_LOOP_1_f2_rem_cmp_b(COMP_LOOP_1_f2_rem_cmp_b),
      .COMP_LOOP_1_f2_rem_cmp_z(COMP_LOOP_1_f2_rem_cmp_z),
      .result_rsci_we_d_pff(result_rsci_we_d_iff),
      .xt_rsci_we_d_pff(xt_rsci_we_d_iff)
    );
endmodule



