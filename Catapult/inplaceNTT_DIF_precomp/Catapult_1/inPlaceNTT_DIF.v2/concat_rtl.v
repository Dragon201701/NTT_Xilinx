
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


//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_out_dreg_v2.v 
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


module mgc_out_dreg_v2 (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input    [width-1:0] d;
  output   [width-1:0] z;

  wire     [width-1:0] z;

  assign z = d;

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

//------> ../td_ccore_solutions/modulo_9ae1d119fc8eee114172955f76eb675761ce_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Sun Aug  1 15:45:36 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    modulo_core
// ------------------------------------------------------------------


module modulo_core (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat, ccs_ccore_clk,
      ccs_ccore_srst, ccs_ccore_en
);
  input [63:0] base_rsc_dat;
  input [63:0] m_rsc_dat;
  output [63:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;


  // Interconnect Declarations
  wire [63:0] base_rsci_idat;
  wire [63:0] m_rsci_idat;
  reg [63:0] return_rsci_d;
  wire ccs_ccore_start_rsci_idat;
  wire [64:0] rem_13_cmp_z;
  wire [64:0] rem_13_cmp_1_z;
  wire [64:0] rem_13_cmp_2_z;
  wire [64:0] rem_13_cmp_3_z;
  wire [64:0] rem_13_cmp_4_z;
  wire [64:0] rem_13_cmp_5_z;
  wire [64:0] rem_13_cmp_6_z;
  wire [64:0] rem_13_cmp_7_z;
  wire [64:0] rem_13_cmp_8_z;
  wire [64:0] rem_13_cmp_9_z;
  wire [64:0] rem_13_cmp_10_z;
  wire [64:0] rem_13_cmp_11_z;
  reg [63:0] rem_13_cmp_b_63_0;
  reg [63:0] rem_13_cmp_1_b_63_0;
  reg [63:0] rem_13_cmp_2_b_63_0;
  reg [63:0] rem_13_cmp_3_b_63_0;
  reg [63:0] rem_13_cmp_4_b_63_0;
  reg [63:0] rem_13_cmp_5_b_63_0;
  reg [63:0] rem_13_cmp_6_b_63_0;
  reg [63:0] rem_13_cmp_7_b_63_0;
  reg [63:0] rem_13_cmp_8_b_63_0;
  reg [63:0] rem_13_cmp_9_b_63_0;
  reg [63:0] rem_13_cmp_10_b_63_0;
  reg [63:0] rem_13_cmp_11_b_63_0;
  reg [63:0] rem_13_cmp_a_63_0;
  reg [63:0] rem_13_cmp_1_a_63_0;
  reg [63:0] rem_13_cmp_2_a_63_0;
  reg [63:0] rem_13_cmp_3_a_63_0;
  reg [63:0] rem_13_cmp_4_a_63_0;
  reg [63:0] rem_13_cmp_5_a_63_0;
  reg [63:0] rem_13_cmp_6_a_63_0;
  reg [63:0] rem_13_cmp_7_a_63_0;
  reg [63:0] rem_13_cmp_8_a_63_0;
  reg [63:0] rem_13_cmp_9_a_63_0;
  reg [63:0] rem_13_cmp_10_a_63_0;
  reg [63:0] rem_13_cmp_11_a_63_0;
  wire [1:0] acc_tmp;
  wire [2:0] nl_acc_tmp;
  wire [3:0] acc_1_tmp;
  wire [4:0] nl_acc_1_tmp;
  wire and_dcpl_1;
  wire and_dcpl_2;
  wire and_dcpl_3;
  wire and_dcpl_4;
  wire and_dcpl_6;
  wire and_dcpl_8;
  wire and_dcpl_9;
  wire and_dcpl_11;
  wire and_dcpl_13;
  wire and_dcpl_18;
  wire and_dcpl_23;
  wire and_dcpl_28;
  wire and_dcpl_29;
  wire and_dcpl_30;
  wire and_dcpl_31;
  wire and_dcpl_33;
  wire and_dcpl_35;
  wire and_dcpl_36;
  wire and_dcpl_38;
  wire and_dcpl_40;
  wire and_dcpl_45;
  wire and_dcpl_50;
  wire and_dcpl_55;
  wire and_dcpl_56;
  wire and_dcpl_57;
  wire and_dcpl_58;
  wire and_dcpl_60;
  wire and_dcpl_62;
  wire and_dcpl_63;
  wire and_dcpl_65;
  wire and_dcpl_67;
  wire and_dcpl_72;
  wire and_dcpl_77;
  wire and_dcpl_82;
  wire and_dcpl_83;
  wire and_dcpl_84;
  wire and_dcpl_85;
  wire and_dcpl_87;
  wire and_dcpl_89;
  wire and_dcpl_90;
  wire and_dcpl_92;
  wire and_dcpl_94;
  wire and_dcpl_99;
  wire and_dcpl_104;
  wire and_dcpl_109;
  wire and_dcpl_110;
  wire and_dcpl_111;
  wire and_dcpl_112;
  wire and_dcpl_114;
  wire and_dcpl_115;
  wire and_dcpl_117;
  wire and_dcpl_119;
  wire and_dcpl_121;
  wire and_dcpl_126;
  wire and_dcpl_129;
  wire and_dcpl_136;
  wire and_dcpl_137;
  wire and_dcpl_138;
  wire and_dcpl_139;
  wire and_dcpl_141;
  wire and_dcpl_143;
  wire and_dcpl_144;
  wire and_dcpl_146;
  wire and_dcpl_148;
  wire and_dcpl_153;
  wire and_dcpl_158;
  wire and_dcpl_163;
  wire and_dcpl_164;
  wire and_dcpl_165;
  wire and_dcpl_166;
  wire and_dcpl_168;
  wire and_dcpl_170;
  wire and_dcpl_171;
  wire and_dcpl_173;
  wire and_dcpl_175;
  wire and_dcpl_180;
  wire and_dcpl_185;
  wire and_dcpl_190;
  wire and_dcpl_191;
  wire and_dcpl_192;
  wire and_dcpl_193;
  wire and_dcpl_195;
  wire and_dcpl_197;
  wire and_dcpl_198;
  wire and_dcpl_200;
  wire and_dcpl_202;
  wire and_dcpl_207;
  wire and_dcpl_212;
  wire and_dcpl_217;
  wire and_dcpl_218;
  wire and_dcpl_219;
  wire and_dcpl_220;
  wire and_dcpl_222;
  wire and_dcpl_224;
  wire and_dcpl_225;
  wire and_dcpl_227;
  wire and_dcpl_229;
  wire and_dcpl_234;
  wire and_dcpl_239;
  wire and_dcpl_244;
  wire and_dcpl_245;
  wire and_dcpl_246;
  wire and_dcpl_247;
  wire and_dcpl_249;
  wire and_dcpl_251;
  wire and_dcpl_252;
  wire and_dcpl_254;
  wire and_dcpl_256;
  wire and_dcpl_261;
  wire and_dcpl_266;
  wire and_dcpl_271;
  wire and_dcpl_272;
  wire and_dcpl_274;
  wire and_dcpl_276;
  wire and_dcpl_278;
  wire and_dcpl_280;
  wire and_dcpl_285;
  wire and_dcpl_291;
  wire and_dcpl_292;
  wire and_dcpl_293;
  wire and_dcpl_294;
  wire and_dcpl_295;
  wire and_dcpl_296;
  wire and_dcpl_298;
  wire not_tmp_54;
  wire or_tmp_2;
  wire and_dcpl_300;
  wire and_dcpl_301;
  wire and_dcpl_302;
  wire and_dcpl_304;
  wire and_tmp;
  wire and_dcpl_306;
  wire and_dcpl_307;
  wire and_dcpl_308;
  wire and_dcpl_310;
  wire and_tmp_2;
  wire and_dcpl_312;
  wire and_dcpl_313;
  wire and_dcpl_314;
  wire and_dcpl_316;
  wire and_tmp_5;
  wire and_dcpl_318;
  wire and_tmp_9;
  wire and_dcpl_324;
  wire and_tmp_13;
  wire and_dcpl_330;
  wire mux_tmp_19;
  wire and_tmp_17;
  wire and_dcpl_336;
  wire mux_tmp_22;
  wire mux_tmp_23;
  wire and_tmp_21;
  wire and_dcpl_342;
  wire mux_tmp_26;
  wire mux_tmp_27;
  wire mux_tmp_28;
  wire and_tmp_25;
  wire and_dcpl_348;
  wire and_tmp_35;
  wire and_dcpl_355;
  wire and_dcpl_356;
  wire and_dcpl_358;
  wire or_tmp_80;
  wire and_dcpl_360;
  wire and_dcpl_362;
  wire mux_tmp_32;
  wire and_dcpl_364;
  wire and_dcpl_366;
  wire mux_tmp_34;
  wire mux_tmp_35;
  wire and_dcpl_368;
  wire and_dcpl_370;
  wire mux_tmp_37;
  wire mux_tmp_38;
  wire mux_tmp_39;
  wire and_dcpl_372;
  wire mux_tmp_41;
  wire mux_tmp_42;
  wire mux_tmp_43;
  wire mux_tmp_44;
  wire and_dcpl_376;
  wire mux_tmp_46;
  wire mux_tmp_47;
  wire mux_tmp_48;
  wire mux_tmp_49;
  wire mux_tmp_50;
  wire and_dcpl_379;
  wire mux_tmp_52;
  wire mux_tmp_53;
  wire mux_tmp_54;
  wire mux_tmp_55;
  wire mux_tmp_56;
  wire mux_tmp_57;
  wire and_dcpl_382;
  wire mux_tmp_59;
  wire mux_tmp_60;
  wire mux_tmp_61;
  wire mux_tmp_62;
  wire mux_tmp_63;
  wire mux_tmp_64;
  wire mux_tmp_65;
  wire and_dcpl_385;
  wire mux_tmp_67;
  wire mux_tmp_68;
  wire mux_tmp_69;
  wire mux_tmp_70;
  wire mux_tmp_71;
  wire mux_tmp_72;
  wire mux_tmp_73;
  wire mux_tmp_74;
  wire and_dcpl_388;
  wire and_tmp_44;
  wire mux_tmp_76;
  wire and_dcpl_393;
  wire and_dcpl_394;
  wire and_dcpl_395;
  wire or_tmp_185;
  wire and_dcpl_397;
  wire and_dcpl_398;
  wire and_tmp_45;
  wire and_dcpl_400;
  wire and_dcpl_401;
  wire and_tmp_47;
  wire and_dcpl_403;
  wire and_dcpl_404;
  wire and_tmp_50;
  wire and_dcpl_406;
  wire and_tmp_54;
  wire and_dcpl_409;
  wire and_tmp_58;
  wire and_dcpl_413;
  wire mux_tmp_84;
  wire and_tmp_62;
  wire and_dcpl_417;
  wire mux_tmp_87;
  wire mux_tmp_88;
  wire and_tmp_66;
  wire and_dcpl_421;
  wire mux_tmp_91;
  wire mux_tmp_92;
  wire mux_tmp_93;
  wire and_tmp_70;
  wire and_dcpl_425;
  wire and_tmp_80;
  wire and_dcpl_430;
  wire and_dcpl_431;
  wire or_tmp_263;
  wire and_dcpl_433;
  wire mux_tmp_97;
  wire and_dcpl_435;
  wire mux_tmp_99;
  wire mux_tmp_100;
  wire and_dcpl_437;
  wire mux_tmp_102;
  wire mux_tmp_103;
  wire mux_tmp_104;
  wire and_dcpl_439;
  wire mux_tmp_106;
  wire mux_tmp_107;
  wire mux_tmp_108;
  wire mux_tmp_109;
  wire and_dcpl_442;
  wire mux_tmp_111;
  wire mux_tmp_112;
  wire mux_tmp_113;
  wire mux_tmp_114;
  wire mux_tmp_115;
  wire and_dcpl_445;
  wire mux_tmp_117;
  wire mux_tmp_118;
  wire mux_tmp_119;
  wire mux_tmp_120;
  wire mux_tmp_121;
  wire mux_tmp_122;
  wire and_dcpl_448;
  wire mux_tmp_124;
  wire mux_tmp_125;
  wire mux_tmp_126;
  wire mux_tmp_127;
  wire mux_tmp_128;
  wire mux_tmp_129;
  wire mux_tmp_130;
  wire and_dcpl_451;
  wire mux_tmp_132;
  wire mux_tmp_133;
  wire mux_tmp_134;
  wire mux_tmp_135;
  wire mux_tmp_136;
  wire mux_tmp_137;
  wire mux_tmp_138;
  wire mux_tmp_139;
  wire and_dcpl_454;
  wire and_tmp_89;
  wire mux_tmp_141;
  wire and_dcpl_460;
  wire and_dcpl_461;
  wire and_dcpl_462;
  wire and_dcpl_463;
  wire not_tmp_332;
  wire or_tmp_368;
  wire and_dcpl_465;
  wire and_dcpl_466;
  wire and_dcpl_467;
  wire and_tmp_90;
  wire and_dcpl_469;
  wire and_dcpl_470;
  wire and_dcpl_471;
  wire and_tmp_92;
  wire and_dcpl_473;
  wire and_dcpl_474;
  wire and_dcpl_475;
  wire and_tmp_95;
  wire and_dcpl_477;
  wire and_tmp_99;
  wire and_dcpl_480;
  wire and_tmp_103;
  wire and_dcpl_483;
  wire mux_tmp_149;
  wire and_tmp_107;
  wire and_dcpl_486;
  wire mux_tmp_152;
  wire mux_tmp_153;
  wire and_tmp_111;
  wire and_dcpl_489;
  wire mux_tmp_156;
  wire mux_tmp_157;
  wire mux_tmp_158;
  wire and_tmp_115;
  wire and_dcpl_492;
  wire and_tmp_125;
  wire and_dcpl_498;
  wire or_tmp_446;
  wire and_dcpl_500;
  wire mux_tmp_162;
  wire and_dcpl_502;
  wire mux_tmp_164;
  wire mux_tmp_165;
  wire and_dcpl_504;
  wire mux_tmp_167;
  wire mux_tmp_168;
  wire mux_tmp_169;
  wire and_dcpl_506;
  wire mux_tmp_171;
  wire mux_tmp_172;
  wire mux_tmp_173;
  wire mux_tmp_174;
  wire and_dcpl_508;
  wire mux_tmp_176;
  wire mux_tmp_177;
  wire mux_tmp_178;
  wire mux_tmp_179;
  wire mux_tmp_180;
  wire and_dcpl_510;
  wire mux_tmp_182;
  wire mux_tmp_183;
  wire mux_tmp_184;
  wire mux_tmp_185;
  wire mux_tmp_186;
  wire mux_tmp_187;
  wire and_dcpl_512;
  wire mux_tmp_189;
  wire mux_tmp_190;
  wire mux_tmp_191;
  wire mux_tmp_192;
  wire mux_tmp_193;
  wire mux_tmp_194;
  wire mux_tmp_195;
  wire and_dcpl_514;
  wire mux_tmp_197;
  wire mux_tmp_198;
  wire mux_tmp_199;
  wire mux_tmp_200;
  wire mux_tmp_201;
  wire mux_tmp_202;
  wire mux_tmp_203;
  wire mux_tmp_204;
  wire and_dcpl_516;
  wire and_tmp_134;
  wire mux_tmp_206;
  wire and_dcpl_520;
  wire and_dcpl_521;
  wire or_tmp_551;
  wire and_dcpl_523;
  wire and_dcpl_524;
  wire and_tmp_135;
  wire and_dcpl_526;
  wire and_dcpl_527;
  wire and_tmp_137;
  wire and_dcpl_529;
  wire and_dcpl_530;
  wire and_tmp_140;
  wire and_dcpl_532;
  wire and_tmp_144;
  wire and_dcpl_534;
  wire and_tmp_148;
  wire and_dcpl_536;
  wire mux_tmp_214;
  wire and_tmp_152;
  wire and_dcpl_538;
  wire mux_tmp_217;
  wire mux_tmp_218;
  wire and_tmp_156;
  wire and_dcpl_540;
  wire mux_tmp_221;
  wire mux_tmp_222;
  wire mux_tmp_223;
  wire and_tmp_160;
  wire and_dcpl_542;
  wire and_tmp_170;
  wire and_dcpl_546;
  wire or_tmp_629;
  wire and_dcpl_548;
  wire mux_tmp_227;
  wire and_dcpl_550;
  wire mux_tmp_229;
  wire mux_tmp_230;
  wire and_dcpl_552;
  wire mux_tmp_232;
  wire mux_tmp_233;
  wire mux_tmp_234;
  wire and_dcpl_554;
  wire mux_tmp_236;
  wire mux_tmp_237;
  wire mux_tmp_238;
  wire mux_tmp_239;
  wire and_dcpl_556;
  wire mux_tmp_241;
  wire mux_tmp_242;
  wire mux_tmp_243;
  wire mux_tmp_244;
  wire mux_tmp_245;
  wire and_dcpl_558;
  wire mux_tmp_247;
  wire mux_tmp_248;
  wire mux_tmp_249;
  wire mux_tmp_250;
  wire mux_tmp_251;
  wire mux_tmp_252;
  wire and_dcpl_560;
  wire mux_tmp_254;
  wire mux_tmp_255;
  wire mux_tmp_256;
  wire mux_tmp_257;
  wire mux_tmp_258;
  wire mux_tmp_259;
  wire mux_tmp_260;
  wire and_dcpl_562;
  wire mux_tmp_262;
  wire mux_tmp_263;
  wire mux_tmp_264;
  wire mux_tmp_265;
  wire mux_tmp_266;
  wire mux_tmp_267;
  wire mux_tmp_268;
  wire mux_tmp_269;
  wire and_dcpl_564;
  wire and_tmp_179;
  wire mux_tmp_271;
  wire and_dcpl_568;
  wire and_dcpl_569;
  wire and_dcpl_570;
  wire and_dcpl_571;
  wire or_tmp_733;
  wire and_dcpl_573;
  wire and_dcpl_574;
  wire and_dcpl_575;
  wire and_tmp_180;
  wire and_dcpl_577;
  wire and_dcpl_578;
  wire and_dcpl_579;
  wire and_tmp_182;
  wire and_dcpl_581;
  wire and_dcpl_582;
  wire and_dcpl_583;
  wire and_tmp_185;
  wire and_dcpl_585;
  wire and_tmp_189;
  wire and_dcpl_589;
  wire and_tmp_193;
  wire and_dcpl_593;
  wire mux_tmp_279;
  wire and_tmp_197;
  wire and_dcpl_597;
  wire mux_tmp_282;
  wire mux_tmp_283;
  wire and_tmp_201;
  wire and_dcpl_601;
  wire mux_tmp_286;
  wire mux_tmp_287;
  wire mux_tmp_288;
  wire and_tmp_205;
  wire and_dcpl_605;
  wire or_tmp_808;
  wire mux_tmp_291;
  wire mux_tmp_292;
  wire mux_tmp_293;
  wire mux_tmp_294;
  wire mux_tmp_295;
  wire mux_tmp_296;
  wire mux_tmp_297;
  wire mux_tmp_298;
  wire and_tmp_206;
  wire and_dcpl_610;
  wire or_tmp_820;
  wire and_dcpl_612;
  wire mux_tmp_301;
  wire and_dcpl_614;
  wire mux_tmp_303;
  wire mux_tmp_304;
  wire and_dcpl_616;
  wire mux_tmp_306;
  wire mux_tmp_307;
  wire mux_tmp_308;
  wire and_dcpl_618;
  wire mux_tmp_310;
  wire mux_tmp_311;
  wire mux_tmp_312;
  wire mux_tmp_313;
  wire and_dcpl_622;
  wire mux_tmp_315;
  wire mux_tmp_316;
  wire mux_tmp_317;
  wire mux_tmp_318;
  wire mux_tmp_319;
  wire and_dcpl_625;
  wire mux_tmp_321;
  wire mux_tmp_322;
  wire mux_tmp_323;
  wire mux_tmp_324;
  wire mux_tmp_325;
  wire mux_tmp_326;
  wire and_dcpl_628;
  wire mux_tmp_328;
  wire mux_tmp_329;
  wire mux_tmp_330;
  wire mux_tmp_331;
  wire mux_tmp_332;
  wire mux_tmp_333;
  wire mux_tmp_334;
  wire and_dcpl_631;
  wire mux_tmp_336;
  wire mux_tmp_337;
  wire mux_tmp_338;
  wire mux_tmp_339;
  wire mux_tmp_340;
  wire mux_tmp_341;
  wire mux_tmp_342;
  wire mux_tmp_343;
  wire and_dcpl_634;
  wire or_tmp_921;
  wire mux_tmp_345;
  wire mux_tmp_346;
  wire mux_tmp_347;
  wire mux_tmp_348;
  wire mux_tmp_349;
  wire mux_tmp_350;
  wire mux_tmp_351;
  wire mux_tmp_352;
  wire mux_tmp_353;
  wire mux_tmp_354;
  wire and_dcpl_638;
  wire and_dcpl_639;
  wire or_tmp_934;
  wire and_dcpl_641;
  wire and_dcpl_642;
  wire and_tmp_207;
  wire and_dcpl_644;
  wire and_dcpl_645;
  wire and_tmp_209;
  wire and_dcpl_647;
  wire and_dcpl_648;
  wire and_tmp_212;
  wire and_dcpl_650;
  wire and_tmp_216;
  wire and_dcpl_653;
  wire and_tmp_220;
  wire and_dcpl_657;
  wire mux_tmp_362;
  wire and_tmp_224;
  wire and_dcpl_661;
  wire mux_tmp_365;
  wire mux_tmp_366;
  wire and_tmp_228;
  wire and_dcpl_665;
  wire mux_tmp_369;
  wire mux_tmp_370;
  wire mux_tmp_371;
  wire and_tmp_232;
  wire and_dcpl_669;
  wire or_tmp_1009;
  wire mux_tmp_374;
  wire mux_tmp_375;
  wire mux_tmp_376;
  wire mux_tmp_377;
  wire mux_tmp_378;
  wire mux_tmp_379;
  wire mux_tmp_380;
  wire mux_tmp_381;
  wire and_tmp_233;
  wire and_dcpl_673;
  wire or_tmp_1021;
  wire and_dcpl_675;
  wire mux_tmp_384;
  wire and_dcpl_677;
  wire mux_tmp_386;
  wire mux_tmp_387;
  wire and_dcpl_679;
  wire mux_tmp_389;
  wire mux_tmp_390;
  wire mux_tmp_391;
  wire and_dcpl_681;
  wire mux_tmp_393;
  wire mux_tmp_394;
  wire mux_tmp_395;
  wire mux_tmp_396;
  wire and_dcpl_684;
  wire mux_tmp_398;
  wire mux_tmp_399;
  wire mux_tmp_400;
  wire mux_tmp_401;
  wire mux_tmp_402;
  wire and_dcpl_687;
  wire mux_tmp_404;
  wire mux_tmp_405;
  wire mux_tmp_406;
  wire mux_tmp_407;
  wire mux_tmp_408;
  wire mux_tmp_409;
  wire and_dcpl_690;
  wire mux_tmp_411;
  wire mux_tmp_412;
  wire mux_tmp_413;
  wire mux_tmp_414;
  wire mux_tmp_415;
  wire mux_tmp_416;
  wire mux_tmp_417;
  wire and_dcpl_693;
  wire mux_tmp_419;
  wire mux_tmp_420;
  wire mux_tmp_421;
  wire mux_tmp_422;
  wire mux_tmp_423;
  wire mux_tmp_424;
  wire mux_tmp_425;
  wire mux_tmp_426;
  wire and_dcpl_696;
  wire or_tmp_1122;
  wire mux_tmp_428;
  wire mux_tmp_429;
  wire mux_tmp_430;
  wire mux_tmp_431;
  wire mux_tmp_432;
  wire mux_tmp_433;
  wire mux_tmp_434;
  wire mux_tmp_435;
  wire mux_tmp_436;
  wire mux_tmp_437;
  reg [1:0] rem_12cyc_st_10_1_0;
  reg [1:0] rem_12cyc_st_10_3_2;
  reg [1:0] rem_12cyc_st_9_1_0;
  reg [1:0] rem_12cyc_st_9_3_2;
  reg [1:0] rem_12cyc_st_8_1_0;
  reg [1:0] rem_12cyc_st_8_3_2;
  reg [1:0] rem_12cyc_st_7_1_0;
  reg [1:0] rem_12cyc_st_7_3_2;
  reg [1:0] rem_12cyc_st_6_1_0;
  reg [1:0] rem_12cyc_st_6_3_2;
  reg [1:0] rem_12cyc_st_5_1_0;
  reg [1:0] rem_12cyc_st_5_3_2;
  reg [1:0] rem_12cyc_st_4_1_0;
  reg [1:0] rem_12cyc_st_4_3_2;
  reg [1:0] rem_12cyc_st_3_1_0;
  reg [1:0] rem_12cyc_st_3_3_2;
  reg [1:0] rem_12cyc_st_2_1_0;
  reg [1:0] rem_12cyc_st_2_3_2;
  reg [1:0] rem_12cyc_1_0;
  reg [1:0] rem_12cyc_3_2;
  reg [1:0] rem_12cyc_st_12_3_2;
  reg [63:0] result_sva_duc;
  reg [1:0] rem_12cyc_st_12_1_0;
  reg asn_itm_12;
  reg main_stage_0_13;
  reg main_stage_0_3;
  reg asn_itm_1;
  reg main_stage_0_2;
  reg main_stage_0_4;
  reg asn_itm_2;
  reg main_stage_0_5;
  reg asn_itm_3;
  reg main_stage_0_6;
  reg asn_itm_4;
  reg asn_itm_5;
  reg main_stage_0_8;
  reg asn_itm_7;
  reg main_stage_0_9;
  reg asn_itm_8;
  reg main_stage_0_10;
  reg asn_itm_9;
  reg main_stage_0_7;
  reg asn_itm_6;
  reg main_stage_0_11;
  reg asn_itm_10;
  wire and_1173_cse;
  wire and_1175_cse;
  wire and_1177_cse;
  wire and_1179_cse;
  wire and_1181_cse;
  wire and_1183_cse;
  wire and_1185_cse;
  wire and_1187_cse;
  wire and_1189_cse;
  wire and_1191_cse;
  wire and_1193_cse;
  wire and_1195_cse;
  wire and_1197_cse;
  wire or_1_cse;
  wire or_6_cse;
  wire or_10_cse;
  wire or_15_cse;
  wire or_21_cse;
  wire or_28_cse;
  wire or_37_cse;
  wire or_48_cse;
  wire or_83_cse;
  wire nand_276_cse;
  wire or_88_cse;
  wire nand_274_cse;
  wire or_93_cse;
  wire nand_271_cse;
  wire or_100_cse;
  wire nand_267_cse;
  wire or_109_cse;
  wire or_120_cse;
  wire or_133_cse;
  wire or_148_cse;
  wire or_190_cse;
  wire or_195_cse;
  wire or_199_cse;
  wire or_204_cse;
  wire or_210_cse;
  wire or_217_cse;
  wire or_226_cse;
  wire or_237_cse;
  wire or_270_cse;
  wire or_275_cse;
  wire or_280_cse;
  wire or_287_cse;
  wire or_296_cse;
  wire or_307_cse;
  wire or_320_cse;
  wire or_335_cse;
  wire nand_281_cse;
  wire or_377_cse;
  wire or_382_cse;
  wire or_386_cse;
  wire or_391_cse;
  wire or_397_cse;
  wire nand_215_cse;
  wire or_404_cse;
  wire nand_212_cse;
  wire or_413_cse;
  wire nand_208_cse;
  wire or_424_cse;
  wire or_458_cse;
  wire or_463_cse;
  wire nand_198_cse;
  wire or_468_cse;
  wire or_475_cse;
  wire nand_189_cse;
  wire or_484_cse;
  wire or_495_cse;
  wire or_508_cse;
  wire nand_203_cse;
  wire or_523_cse;
  wire nand_250_cse;
  wire or_564_cse;
  wire or_569_cse;
  wire or_573_cse;
  wire or_578_cse;
  wire or_584_cse;
  wire or_591_cse;
  wire or_600_cse;
  wire or_611_cse;
  wire or_643_cse;
  wire or_648_cse;
  wire or_653_cse;
  wire or_660_cse;
  wire or_669_cse;
  wire or_680_cse;
  wire or_693_cse;
  wire or_708_cse;
  wire or_748_cse;
  wire or_753_cse;
  wire or_757_cse;
  wire or_762_cse;
  wire or_768_cse;
  wire or_775_cse;
  wire or_784_cse;
  wire or_795_cse;
  wire or_837_cse;
  wire nand_84_cse;
  wire or_842_cse;
  wire or_847_cse;
  wire nand_79_cse;
  wire or_854_cse;
  wire or_863_cse;
  wire or_874_cse;
  wire or_887_cse;
  wire or_902_cse;
  wire or_952_cse;
  wire or_957_cse;
  wire or_961_cse;
  wire or_966_cse;
  wire or_972_cse;
  wire or_979_cse;
  wire or_988_cse;
  wire or_999_cse;
  wire nand_57_cse;
  wire or_1045_cse;
  wire or_1050_cse;
  wire or_1057_cse;
  wire or_1066_cse;
  wire nand_36_cse;
  wire nand_29_cse;
  wire nand_21_cse;
  wire nand_222_cse;
  wire nand_223_cse;
  reg main_stage_0_12;
  reg [63:0] m_buf_sva_1;
  reg [63:0] m_buf_sva_2;
  reg [63:0] m_buf_sva_3;
  reg [63:0] m_buf_sva_4;
  reg [63:0] m_buf_sva_5;
  reg [63:0] m_buf_sva_6;
  reg [63:0] m_buf_sva_7;
  reg [63:0] m_buf_sva_8;
  reg [63:0] m_buf_sva_9;
  reg [63:0] m_buf_sva_10;
  reg [63:0] m_buf_sva_11;
  reg [63:0] m_buf_sva_12;
  reg asn_itm_11;
  reg [63:0] mut_2_63_0;
  reg [63:0] mut_3_63_0;
  reg [63:0] mut_4_63_0;
  reg [63:0] mut_5_63_0;
  reg [63:0] mut_6_63_0;
  reg [63:0] mut_7_63_0;
  reg [63:0] mut_8_63_0;
  reg [63:0] mut_9_63_0;
  reg [63:0] mut_10_63_0;
  reg [63:0] mut_11_63_0;
  reg [63:0] mut_1_2_63_0;
  reg [63:0] mut_1_3_63_0;
  reg [63:0] mut_1_4_63_0;
  reg [63:0] mut_1_5_63_0;
  reg [63:0] mut_1_6_63_0;
  reg [63:0] mut_1_7_63_0;
  reg [63:0] mut_1_8_63_0;
  reg [63:0] mut_1_9_63_0;
  reg [63:0] mut_1_10_63_0;
  reg [63:0] mut_1_11_63_0;
  reg [63:0] mut_2_2_63_0;
  reg [63:0] mut_2_3_63_0;
  reg [63:0] mut_2_4_63_0;
  reg [63:0] mut_2_5_63_0;
  reg [63:0] mut_2_6_63_0;
  reg [63:0] mut_2_7_63_0;
  reg [63:0] mut_2_8_63_0;
  reg [63:0] mut_2_9_63_0;
  reg [63:0] mut_2_10_63_0;
  reg [63:0] mut_2_11_63_0;
  reg [63:0] mut_3_2_63_0;
  reg [63:0] mut_3_3_63_0;
  reg [63:0] mut_3_4_63_0;
  reg [63:0] mut_3_5_63_0;
  reg [63:0] mut_3_6_63_0;
  reg [63:0] mut_3_7_63_0;
  reg [63:0] mut_3_8_63_0;
  reg [63:0] mut_3_9_63_0;
  reg [63:0] mut_3_10_63_0;
  reg [63:0] mut_3_11_63_0;
  reg [63:0] mut_4_2_63_0;
  reg [63:0] mut_4_3_63_0;
  reg [63:0] mut_4_4_63_0;
  reg [63:0] mut_4_5_63_0;
  reg [63:0] mut_4_6_63_0;
  reg [63:0] mut_4_7_63_0;
  reg [63:0] mut_4_8_63_0;
  reg [63:0] mut_4_9_63_0;
  reg [63:0] mut_4_10_63_0;
  reg [63:0] mut_4_11_63_0;
  reg [63:0] mut_5_2_63_0;
  reg [63:0] mut_5_3_63_0;
  reg [63:0] mut_5_4_63_0;
  reg [63:0] mut_5_5_63_0;
  reg [63:0] mut_5_6_63_0;
  reg [63:0] mut_5_7_63_0;
  reg [63:0] mut_5_8_63_0;
  reg [63:0] mut_5_9_63_0;
  reg [63:0] mut_5_10_63_0;
  reg [63:0] mut_5_11_63_0;
  reg [63:0] mut_6_2_63_0;
  reg [63:0] mut_6_3_63_0;
  reg [63:0] mut_6_4_63_0;
  reg [63:0] mut_6_5_63_0;
  reg [63:0] mut_6_6_63_0;
  reg [63:0] mut_6_7_63_0;
  reg [63:0] mut_6_8_63_0;
  reg [63:0] mut_6_9_63_0;
  reg [63:0] mut_6_10_63_0;
  reg [63:0] mut_6_11_63_0;
  reg [63:0] mut_7_2_63_0;
  reg [63:0] mut_7_3_63_0;
  reg [63:0] mut_7_4_63_0;
  reg [63:0] mut_7_5_63_0;
  reg [63:0] mut_7_6_63_0;
  reg [63:0] mut_7_7_63_0;
  reg [63:0] mut_7_8_63_0;
  reg [63:0] mut_7_9_63_0;
  reg [63:0] mut_7_10_63_0;
  reg [63:0] mut_7_11_63_0;
  reg [63:0] mut_8_2_63_0;
  reg [63:0] mut_8_3_63_0;
  reg [63:0] mut_8_4_63_0;
  reg [63:0] mut_8_5_63_0;
  reg [63:0] mut_8_6_63_0;
  reg [63:0] mut_8_7_63_0;
  reg [63:0] mut_8_8_63_0;
  reg [63:0] mut_8_9_63_0;
  reg [63:0] mut_8_10_63_0;
  reg [63:0] mut_8_11_63_0;
  reg [63:0] mut_9_2_63_0;
  reg [63:0] mut_9_3_63_0;
  reg [63:0] mut_9_4_63_0;
  reg [63:0] mut_9_5_63_0;
  reg [63:0] mut_9_6_63_0;
  reg [63:0] mut_9_7_63_0;
  reg [63:0] mut_9_8_63_0;
  reg [63:0] mut_9_9_63_0;
  reg [63:0] mut_9_10_63_0;
  reg [63:0] mut_9_11_63_0;
  reg [63:0] mut_10_2_63_0;
  reg [63:0] mut_10_3_63_0;
  reg [63:0] mut_10_4_63_0;
  reg [63:0] mut_10_5_63_0;
  reg [63:0] mut_10_6_63_0;
  reg [63:0] mut_10_7_63_0;
  reg [63:0] mut_10_8_63_0;
  reg [63:0] mut_10_9_63_0;
  reg [63:0] mut_10_10_63_0;
  reg [63:0] mut_10_11_63_0;
  reg [63:0] mut_11_2_63_0;
  reg [63:0] mut_11_3_63_0;
  reg [63:0] mut_11_4_63_0;
  reg [63:0] mut_11_5_63_0;
  reg [63:0] mut_11_6_63_0;
  reg [63:0] mut_11_7_63_0;
  reg [63:0] mut_11_8_63_0;
  reg [63:0] mut_11_9_63_0;
  reg [63:0] mut_11_10_63_0;
  reg [63:0] mut_11_11_63_0;
  reg [63:0] mut_12_2_63_0;
  reg [63:0] mut_12_3_63_0;
  reg [63:0] mut_12_4_63_0;
  reg [63:0] mut_12_5_63_0;
  reg [63:0] mut_12_6_63_0;
  reg [63:0] mut_12_7_63_0;
  reg [63:0] mut_12_8_63_0;
  reg [63:0] mut_12_9_63_0;
  reg [63:0] mut_12_10_63_0;
  reg [63:0] mut_12_11_63_0;
  reg [63:0] mut_13_2_63_0;
  reg [63:0] mut_13_3_63_0;
  reg [63:0] mut_13_4_63_0;
  reg [63:0] mut_13_5_63_0;
  reg [63:0] mut_13_6_63_0;
  reg [63:0] mut_13_7_63_0;
  reg [63:0] mut_13_8_63_0;
  reg [63:0] mut_13_9_63_0;
  reg [63:0] mut_13_10_63_0;
  reg [63:0] mut_13_11_63_0;
  reg [63:0] mut_14_2_63_0;
  reg [63:0] mut_14_3_63_0;
  reg [63:0] mut_14_4_63_0;
  reg [63:0] mut_14_5_63_0;
  reg [63:0] mut_14_6_63_0;
  reg [63:0] mut_14_7_63_0;
  reg [63:0] mut_14_8_63_0;
  reg [63:0] mut_14_9_63_0;
  reg [63:0] mut_14_10_63_0;
  reg [63:0] mut_14_11_63_0;
  reg [63:0] mut_15_2_63_0;
  reg [63:0] mut_15_3_63_0;
  reg [63:0] mut_15_4_63_0;
  reg [63:0] mut_15_5_63_0;
  reg [63:0] mut_15_6_63_0;
  reg [63:0] mut_15_7_63_0;
  reg [63:0] mut_15_8_63_0;
  reg [63:0] mut_15_9_63_0;
  reg [63:0] mut_15_10_63_0;
  reg [63:0] mut_15_11_63_0;
  reg [63:0] mut_16_2_63_0;
  reg [63:0] mut_16_3_63_0;
  reg [63:0] mut_16_4_63_0;
  reg [63:0] mut_16_5_63_0;
  reg [63:0] mut_16_6_63_0;
  reg [63:0] mut_16_7_63_0;
  reg [63:0] mut_16_8_63_0;
  reg [63:0] mut_16_9_63_0;
  reg [63:0] mut_16_10_63_0;
  reg [63:0] mut_16_11_63_0;
  reg [63:0] mut_17_2_63_0;
  reg [63:0] mut_17_3_63_0;
  reg [63:0] mut_17_4_63_0;
  reg [63:0] mut_17_5_63_0;
  reg [63:0] mut_17_6_63_0;
  reg [63:0] mut_17_7_63_0;
  reg [63:0] mut_17_8_63_0;
  reg [63:0] mut_17_9_63_0;
  reg [63:0] mut_17_10_63_0;
  reg [63:0] mut_17_11_63_0;
  reg [63:0] mut_18_2_63_0;
  reg [63:0] mut_18_3_63_0;
  reg [63:0] mut_18_4_63_0;
  reg [63:0] mut_18_5_63_0;
  reg [63:0] mut_18_6_63_0;
  reg [63:0] mut_18_7_63_0;
  reg [63:0] mut_18_8_63_0;
  reg [63:0] mut_18_9_63_0;
  reg [63:0] mut_18_10_63_0;
  reg [63:0] mut_18_11_63_0;
  reg [63:0] mut_19_2_63_0;
  reg [63:0] mut_19_3_63_0;
  reg [63:0] mut_19_4_63_0;
  reg [63:0] mut_19_5_63_0;
  reg [63:0] mut_19_6_63_0;
  reg [63:0] mut_19_7_63_0;
  reg [63:0] mut_19_8_63_0;
  reg [63:0] mut_19_9_63_0;
  reg [63:0] mut_19_10_63_0;
  reg [63:0] mut_19_11_63_0;
  reg [63:0] mut_20_2_63_0;
  reg [63:0] mut_20_3_63_0;
  reg [63:0] mut_20_4_63_0;
  reg [63:0] mut_20_5_63_0;
  reg [63:0] mut_20_6_63_0;
  reg [63:0] mut_20_7_63_0;
  reg [63:0] mut_20_8_63_0;
  reg [63:0] mut_20_9_63_0;
  reg [63:0] mut_20_10_63_0;
  reg [63:0] mut_20_11_63_0;
  reg [63:0] mut_21_2_63_0;
  reg [63:0] mut_21_3_63_0;
  reg [63:0] mut_21_4_63_0;
  reg [63:0] mut_21_5_63_0;
  reg [63:0] mut_21_6_63_0;
  reg [63:0] mut_21_7_63_0;
  reg [63:0] mut_21_8_63_0;
  reg [63:0] mut_21_9_63_0;
  reg [63:0] mut_21_10_63_0;
  reg [63:0] mut_21_11_63_0;
  reg [63:0] mut_22_2_63_0;
  reg [63:0] mut_22_3_63_0;
  reg [63:0] mut_22_4_63_0;
  reg [63:0] mut_22_5_63_0;
  reg [63:0] mut_22_6_63_0;
  reg [63:0] mut_22_7_63_0;
  reg [63:0] mut_22_8_63_0;
  reg [63:0] mut_22_9_63_0;
  reg [63:0] mut_22_10_63_0;
  reg [63:0] mut_22_11_63_0;
  reg [63:0] mut_23_2_63_0;
  reg [63:0] mut_23_3_63_0;
  reg [63:0] mut_23_4_63_0;
  reg [63:0] mut_23_5_63_0;
  reg [63:0] mut_23_6_63_0;
  reg [63:0] mut_23_7_63_0;
  reg [63:0] mut_23_8_63_0;
  reg [63:0] mut_23_9_63_0;
  reg [63:0] mut_23_10_63_0;
  reg [63:0] mut_23_11_63_0;
  reg [1:0] rem_12cyc_st_11_3_2;
  reg [1:0] rem_12cyc_st_11_1_0;
  wire [63:0] result_sva_duc_mx0;
  wire and_1203_cse;
  wire and_1205_cse;
  wire and_1207_cse;
  wire and_1209_cse;
  wire and_1211_cse;
  wire and_1213_cse;
  wire and_1215_cse;
  wire and_1217_cse;
  wire and_1219_cse;
  wire and_1221_cse;
  wire and_1223_cse;
  wire and_1225_cse;
  wire and_1227_cse;
  wire and_1229_cse;
  wire and_1231_cse;
  wire and_1233_cse;
  wire and_1235_cse;
  wire and_1237_cse;
  wire and_1239_cse;
  wire and_1241_cse;
  wire and_1243_cse;
  wire and_1245_cse;
  wire and_1247_cse;
  wire and_1249_cse;
  wire and_1251_cse;
  wire and_1253_cse;
  wire and_1255_cse;
  wire and_1257_cse;
  wire and_1259_cse;
  wire and_1261_cse;
  wire and_1263_cse;
  wire and_1265_cse;
  wire and_1267_cse;
  wire and_1269_cse;
  wire and_1271_cse;
  wire and_1273_cse;
  wire and_1275_cse;
  wire and_1277_cse;
  wire and_1279_cse;
  wire and_1281_cse;
  wire and_1283_cse;
  wire and_1285_cse;
  wire and_1287_cse;
  wire and_1289_cse;
  wire and_1291_cse;
  wire and_1293_cse;
  wire and_1295_cse;
  wire and_1297_cse;
  wire and_1299_cse;
  wire and_1301_cse;
  wire and_1303_cse;
  wire and_1305_cse;
  wire and_1307_cse;
  wire and_1309_cse;
  wire and_1311_cse;
  wire and_1313_cse;
  wire and_1315_cse;
  wire and_1317_cse;
  wire and_1319_cse;
  wire and_1321_cse;
  wire and_1323_cse;
  wire and_1325_cse;
  wire and_1327_cse;
  wire and_1329_cse;
  wire and_1331_cse;
  wire and_1333_cse;
  wire and_1335_cse;
  wire and_1337_cse;
  wire and_1339_cse;
  wire and_1341_cse;
  wire and_1343_cse;
  wire and_1345_cse;
  wire and_1347_cse;
  wire and_1349_cse;
  wire and_1351_cse;
  wire and_1353_cse;
  wire and_1355_cse;
  wire and_1357_cse;
  wire and_1359_cse;
  wire and_1361_cse;
  wire and_1363_cse;
  wire and_1365_cse;
  wire and_1367_cse;
  wire and_1369_cse;
  wire and_1371_cse;
  wire and_1373_cse;
  wire and_1375_cse;
  wire and_1377_cse;
  wire and_1379_cse;
  wire and_1381_cse;
  wire and_1383_cse;
  wire and_1385_cse;
  wire and_1387_cse;
  wire and_1389_cse;
  wire and_1391_cse;
  wire and_1393_cse;
  wire and_1395_cse;
  wire and_1397_cse;
  wire and_1399_cse;
  wire and_1401_cse;
  wire and_1403_cse;
  wire and_1405_cse;
  wire and_1407_cse;
  wire and_1409_cse;
  wire and_1411_cse;
  wire and_1413_cse;
  wire and_1415_cse;
  wire and_1417_cse;
  wire and_1419_cse;
  wire and_1421_cse;
  wire and_1423_cse;
  wire and_1425_cse;
  wire and_1427_cse;
  wire and_1429_cse;
  wire and_1431_cse;
  wire and_1433_cse;
  wire and_1435_cse;
  wire and_1437_cse;
  wire and_1439_cse;
  wire and_1441_cse;
  wire and_1443_cse;
  wire and_1445_cse;
  wire and_1447_cse;
  wire and_1449_cse;
  wire and_1451_cse;
  wire and_1453_cse;
  wire and_1455_cse;
  wire and_1457_cse;
  wire and_1459_cse;
  wire and_1461_cse;
  wire and_1463_cse;

  wire[63:0] qelse_acc_nl;
  wire[64:0] nl_qelse_acc_nl;
  wire[0:0] mux_13_nl;
  wire[0:0] mux_12_nl;
  wire[0:0] mux_11_nl;
  wire[0:0] mux_10_nl;
  wire[0:0] mux_9_nl;
  wire[0:0] mux_8_nl;
  wire[0:0] mux_7_nl;
  wire[0:0] mux_6_nl;
  wire[0:0] mux_5_nl;
  wire[0:0] mux_4_nl;
  wire[0:0] mux_3_nl;
  wire[0:0] mux_2_nl;
  wire[0:0] and_273_nl;
  wire[0:0] and_275_nl;
  wire[0:0] and_277_nl;
  wire[0:0] and_279_nl;
  wire[0:0] and_281_nl;
  wire[0:0] and_282_nl;
  wire[0:0] and_283_nl;
  wire[0:0] and_284_nl;
  wire[0:0] and_286_nl;
  wire[0:0] and_287_nl;
  wire[0:0] and_288_nl;
  wire[0:0] and_289_nl;
  wire[0:0] and_290_nl;
  wire[0:0] xor_nl;
  wire[0:0] nor_nl;
  wire[0:0] mux_14_nl;
  wire[0:0] nor_518_nl;
  wire[0:0] mux_15_nl;
  wire[0:0] nor_517_nl;
  wire[0:0] mux_16_nl;
  wire[0:0] nor_516_nl;
  wire[0:0] mux_17_nl;
  wire[0:0] nor_515_nl;
  wire[0:0] mux_18_nl;
  wire[0:0] nor_514_nl;
  wire[0:0] mux_19_nl;
  wire[0:0] nor_512_nl;
  wire[0:0] mux_20_nl;
  wire[0:0] nor_513_nl;
  wire[0:0] nor_509_nl;
  wire[0:0] mux_22_nl;
  wire[0:0] nor_510_nl;
  wire[0:0] mux_23_nl;
  wire[0:0] nor_511_nl;
  wire[0:0] nor_505_nl;
  wire[0:0] nor_506_nl;
  wire[0:0] mux_26_nl;
  wire[0:0] nor_507_nl;
  wire[0:0] mux_27_nl;
  wire[0:0] nor_508_nl;
  wire[0:0] nor_500_nl;
  wire[0:0] or_61_nl;
  wire[0:0] nor_501_nl;
  wire[0:0] nor_502_nl;
  wire[0:0] mux_31_nl;
  wire[0:0] nor_503_nl;
  wire[0:0] mux_32_nl;
  wire[0:0] nor_504_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] nor_499_nl;
  wire[0:0] and_1168_nl;
  wire[0:0] mux_35_nl;
  wire[0:0] nor_498_nl;
  wire[0:0] and_1166_nl;
  wire[0:0] and_1167_nl;
  wire[0:0] mux_38_nl;
  wire[0:0] nor_497_nl;
  wire[0:0] and_1163_nl;
  wire[0:0] and_1164_nl;
  wire[0:0] and_1165_nl;
  wire[0:0] mux_42_nl;
  wire[0:0] nor_496_nl;
  wire[0:0] and_1159_nl;
  wire[0:0] and_1160_nl;
  wire[0:0] and_1161_nl;
  wire[0:0] and_1162_nl;
  wire[0:0] mux_47_nl;
  wire[0:0] nor_495_nl;
  wire[0:0] nor_493_nl;
  wire[0:0] and_1155_nl;
  wire[0:0] and_1156_nl;
  wire[0:0] and_1157_nl;
  wire[0:0] and_1158_nl;
  wire[0:0] mux_53_nl;
  wire[0:0] nor_494_nl;
  wire[0:0] nor_490_nl;
  wire[0:0] nor_491_nl;
  wire[0:0] and_1151_nl;
  wire[0:0] and_1152_nl;
  wire[0:0] and_1153_nl;
  wire[0:0] and_1154_nl;
  wire[0:0] mux_60_nl;
  wire[0:0] nor_492_nl;
  wire[0:0] nor_486_nl;
  wire[0:0] nor_487_nl;
  wire[0:0] nor_488_nl;
  wire[0:0] and_1147_nl;
  wire[0:0] and_1148_nl;
  wire[0:0] and_1149_nl;
  wire[0:0] and_1150_nl;
  wire[0:0] mux_68_nl;
  wire[0:0] nor_489_nl;
  wire[0:0] nor_481_nl;
  wire[0:0] or_165_nl;
  wire[0:0] nor_482_nl;
  wire[0:0] nor_483_nl;
  wire[0:0] nor_484_nl;
  wire[0:0] and_1143_nl;
  wire[0:0] and_1144_nl;
  wire[0:0] and_1145_nl;
  wire[0:0] and_1146_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] nor_485_nl;
  wire[0:0] nor_480_nl;
  wire[0:0] or_175_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] nor_479_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] nor_478_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] nor_477_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] nor_476_nl;
  wire[0:0] mux_83_nl;
  wire[0:0] nor_475_nl;
  wire[0:0] mux_84_nl;
  wire[0:0] nor_473_nl;
  wire[0:0] mux_85_nl;
  wire[0:0] nor_474_nl;
  wire[0:0] nor_470_nl;
  wire[0:0] mux_87_nl;
  wire[0:0] nor_471_nl;
  wire[0:0] mux_88_nl;
  wire[0:0] nor_472_nl;
  wire[0:0] nor_466_nl;
  wire[0:0] nor_467_nl;
  wire[0:0] mux_91_nl;
  wire[0:0] nor_468_nl;
  wire[0:0] mux_92_nl;
  wire[0:0] nor_469_nl;
  wire[0:0] nor_461_nl;
  wire[0:0] or_250_nl;
  wire[0:0] nor_462_nl;
  wire[0:0] nor_463_nl;
  wire[0:0] mux_96_nl;
  wire[0:0] nor_464_nl;
  wire[0:0] mux_97_nl;
  wire[0:0] nor_465_nl;
  wire[0:0] mux_98_nl;
  wire[0:0] nor_460_nl;
  wire[0:0] and_1142_nl;
  wire[0:0] mux_100_nl;
  wire[0:0] nor_459_nl;
  wire[0:0] and_1140_nl;
  wire[0:0] and_1141_nl;
  wire[0:0] mux_103_nl;
  wire[0:0] nor_458_nl;
  wire[0:0] and_1137_nl;
  wire[0:0] and_1138_nl;
  wire[0:0] and_1139_nl;
  wire[0:0] mux_107_nl;
  wire[0:0] nor_457_nl;
  wire[0:0] and_1133_nl;
  wire[0:0] and_1134_nl;
  wire[0:0] and_1135_nl;
  wire[0:0] and_1136_nl;
  wire[0:0] mux_112_nl;
  wire[0:0] nor_456_nl;
  wire[0:0] nor_454_nl;
  wire[0:0] and_1129_nl;
  wire[0:0] and_1130_nl;
  wire[0:0] and_1131_nl;
  wire[0:0] and_1132_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] nor_455_nl;
  wire[0:0] nor_451_nl;
  wire[0:0] nor_452_nl;
  wire[0:0] and_1125_nl;
  wire[0:0] and_1126_nl;
  wire[0:0] and_1127_nl;
  wire[0:0] and_1128_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] nor_453_nl;
  wire[0:0] nor_447_nl;
  wire[0:0] nor_448_nl;
  wire[0:0] nor_449_nl;
  wire[0:0] and_1121_nl;
  wire[0:0] and_1122_nl;
  wire[0:0] and_1123_nl;
  wire[0:0] and_1124_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] nor_450_nl;
  wire[0:0] nor_442_nl;
  wire[0:0] or_352_nl;
  wire[0:0] nor_443_nl;
  wire[0:0] nor_444_nl;
  wire[0:0] nor_445_nl;
  wire[0:0] and_1117_nl;
  wire[0:0] and_1118_nl;
  wire[0:0] and_1119_nl;
  wire[0:0] and_1120_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] nor_446_nl;
  wire[0:0] and_1116_nl;
  wire[0:0] or_362_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] and_1172_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] and_1114_nl;
  wire[0:0] mux_146_nl;
  wire[0:0] and_1113_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] and_1112_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] and_1111_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] and_1109_nl;
  wire[0:0] mux_150_nl;
  wire[0:0] and_1110_nl;
  wire[0:0] and_1106_nl;
  wire[0:0] mux_152_nl;
  wire[0:0] and_1107_nl;
  wire[0:0] mux_153_nl;
  wire[0:0] and_1108_nl;
  wire[0:0] and_1102_nl;
  wire[0:0] and_1103_nl;
  wire[0:0] mux_156_nl;
  wire[0:0] and_1104_nl;
  wire[0:0] mux_157_nl;
  wire[0:0] and_1105_nl;
  wire[0:0] and_1097_nl;
  wire[0:0] or_437_nl;
  wire[0:0] and_1098_nl;
  wire[0:0] and_1099_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] and_1100_nl;
  wire[0:0] mux_162_nl;
  wire[0:0] and_1101_nl;
  wire[0:0] mux_163_nl;
  wire[0:0] and_1171_nl;
  wire[0:0] and_1094_nl;
  wire[0:0] mux_165_nl;
  wire[0:0] and_1095_nl;
  wire[0:0] and_1091_nl;
  wire[0:0] and_1092_nl;
  wire[0:0] mux_168_nl;
  wire[0:0] and_1093_nl;
  wire[0:0] and_1087_nl;
  wire[0:0] and_1088_nl;
  wire[0:0] and_1089_nl;
  wire[0:0] mux_172_nl;
  wire[0:0] and_1090_nl;
  wire[0:0] and_1082_nl;
  wire[0:0] and_1083_nl;
  wire[0:0] and_1084_nl;
  wire[0:0] and_1085_nl;
  wire[0:0] mux_177_nl;
  wire[0:0] and_1086_nl;
  wire[0:0] and_1076_nl;
  wire[0:0] and_1077_nl;
  wire[0:0] and_1078_nl;
  wire[0:0] and_1079_nl;
  wire[0:0] and_1080_nl;
  wire[0:0] mux_183_nl;
  wire[0:0] and_1081_nl;
  wire[0:0] and_1069_nl;
  wire[0:0] and_1070_nl;
  wire[0:0] and_1071_nl;
  wire[0:0] and_1072_nl;
  wire[0:0] and_1073_nl;
  wire[0:0] and_1074_nl;
  wire[0:0] mux_190_nl;
  wire[0:0] and_1075_nl;
  wire[0:0] and_1061_nl;
  wire[0:0] and_1062_nl;
  wire[0:0] and_1063_nl;
  wire[0:0] and_1064_nl;
  wire[0:0] and_1065_nl;
  wire[0:0] and_1066_nl;
  wire[0:0] and_1067_nl;
  wire[0:0] mux_198_nl;
  wire[0:0] and_1068_nl;
  wire[0:0] and_1052_nl;
  wire[0:0] or_540_nl;
  wire[0:0] and_1053_nl;
  wire[0:0] and_1054_nl;
  wire[0:0] and_1055_nl;
  wire[0:0] and_1056_nl;
  wire[0:0] and_1057_nl;
  wire[0:0] and_1058_nl;
  wire[0:0] and_1059_nl;
  wire[0:0] mux_207_nl;
  wire[0:0] and_1060_nl;
  wire[0:0] nor_439_nl;
  wire[0:0] or_550_nl;
  wire[0:0] mux_209_nl;
  wire[0:0] and_1170_nl;
  wire[0:0] mux_210_nl;
  wire[0:0] and_1050_nl;
  wire[0:0] mux_211_nl;
  wire[0:0] and_1049_nl;
  wire[0:0] mux_212_nl;
  wire[0:0] and_1048_nl;
  wire[0:0] mux_213_nl;
  wire[0:0] and_1047_nl;
  wire[0:0] mux_214_nl;
  wire[0:0] and_1045_nl;
  wire[0:0] mux_215_nl;
  wire[0:0] and_1046_nl;
  wire[0:0] and_1042_nl;
  wire[0:0] mux_217_nl;
  wire[0:0] and_1043_nl;
  wire[0:0] mux_218_nl;
  wire[0:0] and_1044_nl;
  wire[0:0] and_1038_nl;
  wire[0:0] and_1039_nl;
  wire[0:0] mux_221_nl;
  wire[0:0] and_1040_nl;
  wire[0:0] mux_222_nl;
  wire[0:0] and_1041_nl;
  wire[0:0] and_1033_nl;
  wire[0:0] or_624_nl;
  wire[0:0] and_1034_nl;
  wire[0:0] and_1035_nl;
  wire[0:0] mux_226_nl;
  wire[0:0] and_1036_nl;
  wire[0:0] mux_227_nl;
  wire[0:0] and_1037_nl;
  wire[0:0] mux_228_nl;
  wire[0:0] and_1169_nl;
  wire[0:0] and_1030_nl;
  wire[0:0] mux_230_nl;
  wire[0:0] and_1031_nl;
  wire[0:0] and_1027_nl;
  wire[0:0] and_1028_nl;
  wire[0:0] mux_233_nl;
  wire[0:0] and_1029_nl;
  wire[0:0] and_1023_nl;
  wire[0:0] and_1024_nl;
  wire[0:0] and_1025_nl;
  wire[0:0] mux_237_nl;
  wire[0:0] and_1026_nl;
  wire[0:0] and_1018_nl;
  wire[0:0] and_1019_nl;
  wire[0:0] and_1020_nl;
  wire[0:0] and_1021_nl;
  wire[0:0] mux_242_nl;
  wire[0:0] and_1022_nl;
  wire[0:0] and_1012_nl;
  wire[0:0] and_1013_nl;
  wire[0:0] and_1014_nl;
  wire[0:0] and_1015_nl;
  wire[0:0] and_1016_nl;
  wire[0:0] mux_248_nl;
  wire[0:0] and_1017_nl;
  wire[0:0] and_1005_nl;
  wire[0:0] and_1006_nl;
  wire[0:0] and_1007_nl;
  wire[0:0] and_1008_nl;
  wire[0:0] and_1009_nl;
  wire[0:0] and_1010_nl;
  wire[0:0] mux_255_nl;
  wire[0:0] and_1011_nl;
  wire[0:0] and_997_nl;
  wire[0:0] and_998_nl;
  wire[0:0] and_999_nl;
  wire[0:0] and_1000_nl;
  wire[0:0] and_1001_nl;
  wire[0:0] and_1002_nl;
  wire[0:0] and_1003_nl;
  wire[0:0] mux_263_nl;
  wire[0:0] and_1004_nl;
  wire[0:0] and_988_nl;
  wire[0:0] or_725_nl;
  wire[0:0] and_989_nl;
  wire[0:0] and_990_nl;
  wire[0:0] and_991_nl;
  wire[0:0] and_992_nl;
  wire[0:0] and_993_nl;
  wire[0:0] and_994_nl;
  wire[0:0] and_995_nl;
  wire[0:0] mux_272_nl;
  wire[0:0] and_996_nl;
  wire[0:0] and_987_nl;
  wire[0:0] or_735_nl;
  wire[0:0] mux_274_nl;
  wire[0:0] nor_436_nl;
  wire[0:0] mux_275_nl;
  wire[0:0] nor_435_nl;
  wire[0:0] mux_276_nl;
  wire[0:0] nor_434_nl;
  wire[0:0] mux_277_nl;
  wire[0:0] nor_433_nl;
  wire[0:0] mux_278_nl;
  wire[0:0] nor_432_nl;
  wire[0:0] mux_279_nl;
  wire[0:0] nor_430_nl;
  wire[0:0] mux_280_nl;
  wire[0:0] nor_431_nl;
  wire[0:0] nor_427_nl;
  wire[0:0] mux_282_nl;
  wire[0:0] nor_428_nl;
  wire[0:0] mux_283_nl;
  wire[0:0] nor_429_nl;
  wire[0:0] nor_423_nl;
  wire[0:0] nor_424_nl;
  wire[0:0] mux_286_nl;
  wire[0:0] nor_425_nl;
  wire[0:0] mux_287_nl;
  wire[0:0] nor_426_nl;
  wire[0:0] nor_418_nl;
  wire[0:0] or_808_nl;
  wire[0:0] nor_419_nl;
  wire[0:0] nor_420_nl;
  wire[0:0] mux_291_nl;
  wire[0:0] nor_421_nl;
  wire[0:0] mux_292_nl;
  wire[0:0] nor_422_nl;
  wire[0:0] nor_409_nl;
  wire[0:0] or_823_nl;
  wire[0:0] nor_410_nl;
  wire[0:0] or_822_nl;
  wire[0:0] nor_411_nl;
  wire[0:0] or_821_nl;
  wire[0:0] nor_412_nl;
  wire[0:0] or_820_nl;
  wire[0:0] nor_413_nl;
  wire[0:0] or_819_nl;
  wire[0:0] nor_414_nl;
  wire[0:0] or_818_nl;
  wire[0:0] nor_415_nl;
  wire[0:0] or_817_nl;
  wire[0:0] nor_416_nl;
  wire[0:0] or_816_nl;
  wire[0:0] mux_301_nl;
  wire[0:0] nor_417_nl;
  wire[0:0] or_815_nl;
  wire[0:0] mux_302_nl;
  wire[0:0] nor_408_nl;
  wire[0:0] and_986_nl;
  wire[0:0] mux_304_nl;
  wire[0:0] nor_407_nl;
  wire[0:0] and_984_nl;
  wire[0:0] and_985_nl;
  wire[0:0] mux_307_nl;
  wire[0:0] nor_406_nl;
  wire[0:0] and_981_nl;
  wire[0:0] and_982_nl;
  wire[0:0] and_983_nl;
  wire[0:0] mux_311_nl;
  wire[0:0] nor_405_nl;
  wire[0:0] and_977_nl;
  wire[0:0] and_978_nl;
  wire[0:0] and_979_nl;
  wire[0:0] and_980_nl;
  wire[0:0] mux_316_nl;
  wire[0:0] nor_404_nl;
  wire[0:0] nor_402_nl;
  wire[0:0] and_973_nl;
  wire[0:0] and_974_nl;
  wire[0:0] and_975_nl;
  wire[0:0] and_976_nl;
  wire[0:0] mux_322_nl;
  wire[0:0] nor_403_nl;
  wire[0:0] nor_399_nl;
  wire[0:0] nor_400_nl;
  wire[0:0] and_969_nl;
  wire[0:0] and_970_nl;
  wire[0:0] and_971_nl;
  wire[0:0] and_972_nl;
  wire[0:0] mux_329_nl;
  wire[0:0] nor_401_nl;
  wire[0:0] nor_395_nl;
  wire[0:0] nor_396_nl;
  wire[0:0] nor_397_nl;
  wire[0:0] and_965_nl;
  wire[0:0] and_966_nl;
  wire[0:0] and_967_nl;
  wire[0:0] and_968_nl;
  wire[0:0] mux_337_nl;
  wire[0:0] nor_398_nl;
  wire[0:0] nor_390_nl;
  wire[0:0] or_919_nl;
  wire[0:0] nor_391_nl;
  wire[0:0] nor_392_nl;
  wire[0:0] nor_393_nl;
  wire[0:0] and_961_nl;
  wire[0:0] and_962_nl;
  wire[0:0] and_963_nl;
  wire[0:0] and_964_nl;
  wire[0:0] mux_346_nl;
  wire[0:0] nor_394_nl;
  wire[0:0] nor_380_nl;
  wire[0:0] or_938_nl;
  wire[0:0] nor_381_nl;
  wire[0:0] or_937_nl;
  wire[0:0] nor_382_nl;
  wire[0:0] or_936_nl;
  wire[0:0] nor_383_nl;
  wire[0:0] or_935_nl;
  wire[0:0] nor_384_nl;
  wire[0:0] or_934_nl;
  wire[0:0] nor_385_nl;
  wire[0:0] or_933_nl;
  wire[0:0] nor_386_nl;
  wire[0:0] or_932_nl;
  wire[0:0] nor_387_nl;
  wire[0:0] or_931_nl;
  wire[0:0] nor_388_nl;
  wire[0:0] or_930_nl;
  wire[0:0] nor_389_nl;
  wire[0:0] or_929_nl;
  wire[0:0] mux_357_nl;
  wire[0:0] nor_379_nl;
  wire[0:0] mux_358_nl;
  wire[0:0] nor_378_nl;
  wire[0:0] mux_359_nl;
  wire[0:0] nor_377_nl;
  wire[0:0] mux_360_nl;
  wire[0:0] nor_376_nl;
  wire[0:0] mux_361_nl;
  wire[0:0] nor_375_nl;
  wire[0:0] mux_362_nl;
  wire[0:0] nor_373_nl;
  wire[0:0] mux_363_nl;
  wire[0:0] nor_374_nl;
  wire[0:0] nor_370_nl;
  wire[0:0] mux_365_nl;
  wire[0:0] nor_371_nl;
  wire[0:0] mux_366_nl;
  wire[0:0] nor_372_nl;
  wire[0:0] nor_366_nl;
  wire[0:0] nor_367_nl;
  wire[0:0] mux_369_nl;
  wire[0:0] nor_368_nl;
  wire[0:0] mux_370_nl;
  wire[0:0] nor_369_nl;
  wire[0:0] nor_361_nl;
  wire[0:0] or_1012_nl;
  wire[0:0] nor_362_nl;
  wire[0:0] nor_363_nl;
  wire[0:0] mux_374_nl;
  wire[0:0] nor_364_nl;
  wire[0:0] mux_375_nl;
  wire[0:0] nor_365_nl;
  wire[0:0] nor_352_nl;
  wire[0:0] or_1027_nl;
  wire[0:0] nor_353_nl;
  wire[0:0] or_1026_nl;
  wire[0:0] nor_354_nl;
  wire[0:0] or_1025_nl;
  wire[0:0] nor_355_nl;
  wire[0:0] or_1024_nl;
  wire[0:0] nor_356_nl;
  wire[0:0] or_1023_nl;
  wire[0:0] nor_357_nl;
  wire[0:0] or_1022_nl;
  wire[0:0] nor_358_nl;
  wire[0:0] or_1021_nl;
  wire[0:0] nor_359_nl;
  wire[0:0] or_1020_nl;
  wire[0:0] mux_384_nl;
  wire[0:0] nor_360_nl;
  wire[0:0] or_1019_nl;
  wire[0:0] mux_385_nl;
  wire[0:0] nor_351_nl;
  wire[0:0] and_960_nl;
  wire[0:0] mux_387_nl;
  wire[0:0] nor_350_nl;
  wire[0:0] and_958_nl;
  wire[0:0] and_959_nl;
  wire[0:0] mux_390_nl;
  wire[0:0] nor_349_nl;
  wire[0:0] and_955_nl;
  wire[0:0] and_956_nl;
  wire[0:0] and_957_nl;
  wire[0:0] mux_394_nl;
  wire[0:0] nor_348_nl;
  wire[0:0] and_951_nl;
  wire[0:0] and_952_nl;
  wire[0:0] and_953_nl;
  wire[0:0] and_954_nl;
  wire[0:0] mux_399_nl;
  wire[0:0] nor_347_nl;
  wire[0:0] nor_345_nl;
  wire[0:0] and_947_nl;
  wire[0:0] and_948_nl;
  wire[0:0] and_949_nl;
  wire[0:0] and_950_nl;
  wire[0:0] mux_405_nl;
  wire[0:0] nor_346_nl;
  wire[0:0] nor_342_nl;
  wire[0:0] nor_343_nl;
  wire[0:0] and_943_nl;
  wire[0:0] and_944_nl;
  wire[0:0] and_945_nl;
  wire[0:0] and_946_nl;
  wire[0:0] mux_412_nl;
  wire[0:0] nor_344_nl;
  wire[0:0] nor_338_nl;
  wire[0:0] nor_339_nl;
  wire[0:0] nor_340_nl;
  wire[0:0] and_939_nl;
  wire[0:0] and_940_nl;
  wire[0:0] and_941_nl;
  wire[0:0] and_942_nl;
  wire[0:0] mux_420_nl;
  wire[0:0] nor_341_nl;
  wire[0:0] nor_333_nl;
  wire[0:0] nand_12_nl;
  wire[0:0] nor_334_nl;
  wire[0:0] nor_335_nl;
  wire[0:0] nor_336_nl;
  wire[0:0] and_935_nl;
  wire[0:0] and_936_nl;
  wire[0:0] and_937_nl;
  wire[0:0] and_938_nl;
  wire[0:0] mux_429_nl;
  wire[0:0] nor_337_nl;
  wire[0:0] nor_324_nl;
  wire[0:0] nand_1_nl;
  wire[0:0] nor_325_nl;
  wire[0:0] nand_2_nl;
  wire[0:0] nor_326_nl;
  wire[0:0] nand_3_nl;
  wire[0:0] nor_327_nl;
  wire[0:0] nand_4_nl;
  wire[0:0] nor_328_nl;
  wire[0:0] nand_5_nl;
  wire[0:0] nor_329_nl;
  wire[0:0] nand_6_nl;
  wire[0:0] nor_330_nl;
  wire[0:0] nand_7_nl;
  wire[0:0] nor_331_nl;
  wire[0:0] nand_8_nl;
  wire[0:0] nor_332_nl;
  wire[0:0] nand_9_nl;
  wire[0:0] and_934_nl;
  wire[0:0] nand_11_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_rem_13_cmp_a;
  assign nl_rem_13_cmp_a = {{1{rem_13_cmp_a_63_0[63]}}, rem_13_cmp_a_63_0};
  wire [64:0] nl_rem_13_cmp_b;
  assign nl_rem_13_cmp_b = {1'b0 , rem_13_cmp_b_63_0};
  wire [64:0] nl_rem_13_cmp_1_a;
  assign nl_rem_13_cmp_1_a = {{1{rem_13_cmp_1_a_63_0[63]}}, rem_13_cmp_1_a_63_0};
  wire [64:0] nl_rem_13_cmp_1_b;
  assign nl_rem_13_cmp_1_b = {1'b0 , rem_13_cmp_1_b_63_0};
  wire [64:0] nl_rem_13_cmp_2_a;
  assign nl_rem_13_cmp_2_a = {{1{rem_13_cmp_2_a_63_0[63]}}, rem_13_cmp_2_a_63_0};
  wire [64:0] nl_rem_13_cmp_2_b;
  assign nl_rem_13_cmp_2_b = {1'b0 , rem_13_cmp_2_b_63_0};
  wire [64:0] nl_rem_13_cmp_3_a;
  assign nl_rem_13_cmp_3_a = {{1{rem_13_cmp_3_a_63_0[63]}}, rem_13_cmp_3_a_63_0};
  wire [64:0] nl_rem_13_cmp_3_b;
  assign nl_rem_13_cmp_3_b = {1'b0 , rem_13_cmp_3_b_63_0};
  wire [64:0] nl_rem_13_cmp_4_a;
  assign nl_rem_13_cmp_4_a = {{1{rem_13_cmp_4_a_63_0[63]}}, rem_13_cmp_4_a_63_0};
  wire [64:0] nl_rem_13_cmp_4_b;
  assign nl_rem_13_cmp_4_b = {1'b0 , rem_13_cmp_4_b_63_0};
  wire [64:0] nl_rem_13_cmp_5_a;
  assign nl_rem_13_cmp_5_a = {{1{rem_13_cmp_5_a_63_0[63]}}, rem_13_cmp_5_a_63_0};
  wire [64:0] nl_rem_13_cmp_5_b;
  assign nl_rem_13_cmp_5_b = {1'b0 , rem_13_cmp_5_b_63_0};
  wire [64:0] nl_rem_13_cmp_6_a;
  assign nl_rem_13_cmp_6_a = {{1{rem_13_cmp_6_a_63_0[63]}}, rem_13_cmp_6_a_63_0};
  wire [64:0] nl_rem_13_cmp_6_b;
  assign nl_rem_13_cmp_6_b = {1'b0 , rem_13_cmp_6_b_63_0};
  wire [64:0] nl_rem_13_cmp_7_a;
  assign nl_rem_13_cmp_7_a = {{1{rem_13_cmp_7_a_63_0[63]}}, rem_13_cmp_7_a_63_0};
  wire [64:0] nl_rem_13_cmp_7_b;
  assign nl_rem_13_cmp_7_b = {1'b0 , rem_13_cmp_7_b_63_0};
  wire [64:0] nl_rem_13_cmp_8_a;
  assign nl_rem_13_cmp_8_a = {{1{rem_13_cmp_8_a_63_0[63]}}, rem_13_cmp_8_a_63_0};
  wire [64:0] nl_rem_13_cmp_8_b;
  assign nl_rem_13_cmp_8_b = {1'b0 , rem_13_cmp_8_b_63_0};
  wire [64:0] nl_rem_13_cmp_9_a;
  assign nl_rem_13_cmp_9_a = {{1{rem_13_cmp_9_a_63_0[63]}}, rem_13_cmp_9_a_63_0};
  wire [64:0] nl_rem_13_cmp_9_b;
  assign nl_rem_13_cmp_9_b = {1'b0 , rem_13_cmp_9_b_63_0};
  wire [64:0] nl_rem_13_cmp_10_a;
  assign nl_rem_13_cmp_10_a = {{1{rem_13_cmp_10_a_63_0[63]}}, rem_13_cmp_10_a_63_0};
  wire [64:0] nl_rem_13_cmp_10_b;
  assign nl_rem_13_cmp_10_b = {1'b0 , rem_13_cmp_10_b_63_0};
  wire [64:0] nl_rem_13_cmp_11_a;
  assign nl_rem_13_cmp_11_a = {{1{rem_13_cmp_11_a_63_0[63]}}, rem_13_cmp_11_a_63_0};
  wire [64:0] nl_rem_13_cmp_11_b;
  assign nl_rem_13_cmp_11_b = {1'b0 , rem_13_cmp_11_b_63_0};
  ccs_in_v1 #(.rscid(32'sd1),
  .width(32'sd64)) base_rsci (
      .dat(base_rsc_dat),
      .idat(base_rsci_idat)
    );
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd64)) m_rsci (
      .dat(m_rsc_dat),
      .idat(m_rsci_idat)
    );
  mgc_out_dreg_v2 #(.rscid(32'sd3),
  .width(32'sd64)) return_rsci (
      .d(return_rsci_d),
      .z(return_rsc_z)
    );
  ccs_in_v1 #(.rscid(32'sd8),
  .width(32'sd1)) ccs_ccore_start_rsci (
      .dat(ccs_ccore_start_rsc_dat),
      .idat(ccs_ccore_start_rsci_idat)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp (
      .a(nl_rem_13_cmp_a[64:0]),
      .b(nl_rem_13_cmp_b[64:0]),
      .z(rem_13_cmp_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_1 (
      .a(nl_rem_13_cmp_1_a[64:0]),
      .b(nl_rem_13_cmp_1_b[64:0]),
      .z(rem_13_cmp_1_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_2 (
      .a(nl_rem_13_cmp_2_a[64:0]),
      .b(nl_rem_13_cmp_2_b[64:0]),
      .z(rem_13_cmp_2_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_3 (
      .a(nl_rem_13_cmp_3_a[64:0]),
      .b(nl_rem_13_cmp_3_b[64:0]),
      .z(rem_13_cmp_3_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_4 (
      .a(nl_rem_13_cmp_4_a[64:0]),
      .b(nl_rem_13_cmp_4_b[64:0]),
      .z(rem_13_cmp_4_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_5 (
      .a(nl_rem_13_cmp_5_a[64:0]),
      .b(nl_rem_13_cmp_5_b[64:0]),
      .z(rem_13_cmp_5_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_6 (
      .a(nl_rem_13_cmp_6_a[64:0]),
      .b(nl_rem_13_cmp_6_b[64:0]),
      .z(rem_13_cmp_6_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_7 (
      .a(nl_rem_13_cmp_7_a[64:0]),
      .b(nl_rem_13_cmp_7_b[64:0]),
      .z(rem_13_cmp_7_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_8 (
      .a(nl_rem_13_cmp_8_a[64:0]),
      .b(nl_rem_13_cmp_8_b[64:0]),
      .z(rem_13_cmp_8_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_9 (
      .a(nl_rem_13_cmp_9_a[64:0]),
      .b(nl_rem_13_cmp_9_b[64:0]),
      .z(rem_13_cmp_9_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_10 (
      .a(nl_rem_13_cmp_10_a[64:0]),
      .b(nl_rem_13_cmp_10_b[64:0]),
      .z(rem_13_cmp_10_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_13_cmp_11 (
      .a(nl_rem_13_cmp_11_a[64:0]),
      .b(nl_rem_13_cmp_11_b[64:0]),
      .z(rem_13_cmp_11_z)
    );
  assign and_1203_cse = ccs_ccore_en & main_stage_0_12 & asn_itm_11;
  assign and_1173_cse = ccs_ccore_en & (and_dcpl_294 | and_dcpl_300 | and_dcpl_306
      | and_dcpl_312 | and_dcpl_318 | and_dcpl_324 | and_dcpl_330 | and_dcpl_336
      | and_dcpl_342 | and_dcpl_348 | and_tmp_35);
  assign and_1175_cse = ccs_ccore_en & (and_dcpl_356 | and_dcpl_360 | and_dcpl_364
      | and_dcpl_368 | and_dcpl_372 | and_dcpl_376 | and_dcpl_379 | and_dcpl_382
      | and_dcpl_385 | and_dcpl_388 | mux_tmp_76);
  assign and_1177_cse = ccs_ccore_en & (and_dcpl_394 | and_dcpl_397 | and_dcpl_400
      | and_dcpl_403 | and_dcpl_406 | and_dcpl_409 | and_dcpl_413 | and_dcpl_417
      | and_dcpl_421 | and_dcpl_425 | and_tmp_80);
  assign and_1179_cse = ccs_ccore_en & (and_dcpl_431 | and_dcpl_433 | and_dcpl_435
      | and_dcpl_437 | and_dcpl_439 | and_dcpl_442 | and_dcpl_445 | and_dcpl_448
      | and_dcpl_451 | and_dcpl_454 | mux_tmp_141);
  assign and_1181_cse = ccs_ccore_en & (and_dcpl_461 | and_dcpl_465 | and_dcpl_469
      | and_dcpl_473 | and_dcpl_477 | and_dcpl_480 | and_dcpl_483 | and_dcpl_486
      | and_dcpl_489 | and_dcpl_492 | and_tmp_125);
  assign and_1183_cse = ccs_ccore_en & (and_dcpl_498 | and_dcpl_500 | and_dcpl_502
      | and_dcpl_504 | and_dcpl_506 | and_dcpl_508 | and_dcpl_510 | and_dcpl_512
      | and_dcpl_514 | and_dcpl_516 | mux_tmp_206);
  assign and_1185_cse = ccs_ccore_en & (and_dcpl_520 | and_dcpl_523 | and_dcpl_526
      | and_dcpl_529 | and_dcpl_532 | and_dcpl_534 | and_dcpl_536 | and_dcpl_538
      | and_dcpl_540 | and_dcpl_542 | and_tmp_170);
  assign and_1187_cse = ccs_ccore_en & (and_dcpl_546 | and_dcpl_548 | and_dcpl_550
      | and_dcpl_552 | and_dcpl_554 | and_dcpl_556 | and_dcpl_558 | and_dcpl_560
      | and_dcpl_562 | and_dcpl_564 | mux_tmp_271);
  assign and_1189_cse = ccs_ccore_en & (and_dcpl_569 | and_dcpl_573 | and_dcpl_577
      | and_dcpl_581 | and_dcpl_585 | and_dcpl_589 | and_dcpl_593 | and_dcpl_597
      | and_dcpl_601 | and_dcpl_605 | and_tmp_206);
  assign and_1191_cse = ccs_ccore_en & (and_dcpl_610 | and_dcpl_612 | and_dcpl_614
      | and_dcpl_616 | and_dcpl_618 | and_dcpl_622 | and_dcpl_625 | and_dcpl_628
      | and_dcpl_631 | and_dcpl_634 | mux_tmp_354);
  assign and_1193_cse = ccs_ccore_en & (and_dcpl_638 | and_dcpl_641 | and_dcpl_644
      | and_dcpl_647 | and_dcpl_650 | and_dcpl_653 | and_dcpl_657 | and_dcpl_661
      | and_dcpl_665 | and_dcpl_669 | and_tmp_233);
  assign and_1195_cse = ccs_ccore_en & (and_dcpl_673 | and_dcpl_675 | and_dcpl_677
      | and_dcpl_679 | and_dcpl_681 | and_dcpl_684 | and_dcpl_687 | and_dcpl_690
      | and_dcpl_693 | and_dcpl_696 | mux_tmp_437);
  assign and_1205_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_2;
  assign and_1207_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_6;
  assign and_1209_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_9;
  assign and_1211_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_11;
  assign and_1213_cse = ccs_ccore_en & and_dcpl_13 & and_dcpl_2;
  assign and_1215_cse = ccs_ccore_en & and_dcpl_13 & and_dcpl_6;
  assign and_1217_cse = ccs_ccore_en & and_dcpl_13 & and_dcpl_9;
  assign and_1219_cse = ccs_ccore_en & and_dcpl_13 & and_dcpl_11;
  assign and_1221_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_18 & (~ (rem_12cyc_st_10_1_0[0]));
  assign and_1223_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_18 & (rem_12cyc_st_10_1_0[0]);
  assign and_1225_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_23 & (~ (rem_12cyc_st_10_1_0[0]));
  assign and_1227_cse = ccs_ccore_en & and_dcpl_4 & and_dcpl_23 & (rem_12cyc_st_10_1_0[0]);
  assign and_1229_cse = ccs_ccore_en & and_dcpl_3;
  assign and_1231_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_29;
  assign and_1233_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_33;
  assign and_1235_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_36;
  assign and_1237_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_38;
  assign and_1239_cse = ccs_ccore_en & and_dcpl_40 & and_dcpl_29;
  assign and_1241_cse = ccs_ccore_en & and_dcpl_40 & and_dcpl_33;
  assign and_1243_cse = ccs_ccore_en & and_dcpl_40 & and_dcpl_36;
  assign and_1245_cse = ccs_ccore_en & and_dcpl_40 & and_dcpl_38;
  assign and_1247_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_45 & (~ (rem_12cyc_st_9_1_0[0]));
  assign and_1249_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_45 & (rem_12cyc_st_9_1_0[0]);
  assign and_1251_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_50 & (~ (rem_12cyc_st_9_1_0[0]));
  assign and_1253_cse = ccs_ccore_en & and_dcpl_31 & and_dcpl_50 & (rem_12cyc_st_9_1_0[0]);
  assign and_1255_cse = ccs_ccore_en & and_dcpl_30;
  assign and_1257_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_56;
  assign and_1259_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_60;
  assign and_1261_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_63;
  assign and_1263_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_65;
  assign and_1265_cse = ccs_ccore_en & and_dcpl_67 & and_dcpl_56;
  assign and_1267_cse = ccs_ccore_en & and_dcpl_67 & and_dcpl_60;
  assign and_1269_cse = ccs_ccore_en & and_dcpl_67 & and_dcpl_63;
  assign and_1271_cse = ccs_ccore_en & and_dcpl_67 & and_dcpl_65;
  assign and_1273_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_72 & (~ (rem_12cyc_st_8_1_0[0]));
  assign and_1275_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_72 & (rem_12cyc_st_8_1_0[0]);
  assign and_1277_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_77 & (~ (rem_12cyc_st_8_1_0[0]));
  assign and_1279_cse = ccs_ccore_en & and_dcpl_58 & and_dcpl_77 & (rem_12cyc_st_8_1_0[0]);
  assign and_1281_cse = ccs_ccore_en & and_dcpl_57;
  assign and_1283_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_83;
  assign and_1285_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_87;
  assign and_1287_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_90;
  assign and_1289_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_92;
  assign and_1291_cse = ccs_ccore_en & and_dcpl_94 & and_dcpl_83;
  assign and_1293_cse = ccs_ccore_en & and_dcpl_94 & and_dcpl_87;
  assign and_1295_cse = ccs_ccore_en & and_dcpl_94 & and_dcpl_90;
  assign and_1297_cse = ccs_ccore_en & and_dcpl_94 & and_dcpl_92;
  assign and_1299_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_99 & (~ (rem_12cyc_st_7_1_0[0]));
  assign and_1301_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_99 & (rem_12cyc_st_7_1_0[0]);
  assign and_1303_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_104 & (~ (rem_12cyc_st_7_1_0[0]));
  assign and_1305_cse = ccs_ccore_en & and_dcpl_85 & and_dcpl_104 & (rem_12cyc_st_7_1_0[0]);
  assign and_1307_cse = ccs_ccore_en & and_dcpl_84;
  assign and_1309_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_110;
  assign and_1311_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_115;
  assign and_1313_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_117;
  assign and_1315_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_119;
  assign and_1317_cse = ccs_ccore_en & and_dcpl_121 & and_dcpl_110;
  assign and_1319_cse = ccs_ccore_en & and_dcpl_121 & and_dcpl_115;
  assign and_1321_cse = ccs_ccore_en & and_dcpl_121 & and_dcpl_117;
  assign and_1323_cse = ccs_ccore_en & and_dcpl_121 & and_dcpl_119;
  assign and_1325_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_126 & (~ (rem_12cyc_st_6_1_0[1]));
  assign and_1327_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_129 & (~ (rem_12cyc_st_6_1_0[1]));
  assign and_1329_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_126 & (rem_12cyc_st_6_1_0[1]);
  assign and_1331_cse = ccs_ccore_en & and_dcpl_112 & and_dcpl_129 & (rem_12cyc_st_6_1_0[1]);
  assign and_1333_cse = ccs_ccore_en & and_dcpl_111;
  assign and_1335_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_137;
  assign and_1337_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_141;
  assign and_1339_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_144;
  assign and_1341_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_146;
  assign and_1343_cse = ccs_ccore_en & and_dcpl_148 & and_dcpl_137;
  assign and_1345_cse = ccs_ccore_en & and_dcpl_148 & and_dcpl_141;
  assign and_1347_cse = ccs_ccore_en & and_dcpl_148 & and_dcpl_144;
  assign and_1349_cse = ccs_ccore_en & and_dcpl_148 & and_dcpl_146;
  assign and_1351_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_153 & (~ (rem_12cyc_st_5_1_0[0]));
  assign and_1353_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_153 & (rem_12cyc_st_5_1_0[0]);
  assign and_1355_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_158 & (~ (rem_12cyc_st_5_1_0[0]));
  assign and_1357_cse = ccs_ccore_en & and_dcpl_139 & and_dcpl_158 & (rem_12cyc_st_5_1_0[0]);
  assign and_1359_cse = ccs_ccore_en & and_dcpl_138;
  assign and_1361_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_164;
  assign and_1363_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_168;
  assign and_1365_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_171;
  assign and_1367_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_173;
  assign and_1369_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_175 & (~ (rem_12cyc_st_4_1_0[0]));
  assign and_1371_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_175 & (rem_12cyc_st_4_1_0[0]);
  assign and_1373_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_180 & (~ (rem_12cyc_st_4_1_0[0]));
  assign and_1375_cse = ccs_ccore_en & and_dcpl_166 & and_dcpl_180 & (rem_12cyc_st_4_1_0[0]);
  assign and_1377_cse = ccs_ccore_en & and_dcpl_185 & and_dcpl_164;
  assign and_1379_cse = ccs_ccore_en & and_dcpl_185 & and_dcpl_168;
  assign and_1381_cse = ccs_ccore_en & and_dcpl_185 & and_dcpl_171;
  assign and_1383_cse = ccs_ccore_en & and_dcpl_185 & and_dcpl_173;
  assign and_1385_cse = ccs_ccore_en & and_dcpl_165;
  assign and_1387_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_191;
  assign and_1389_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_195;
  assign and_1391_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_198;
  assign and_1393_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_200;
  assign and_1395_cse = ccs_ccore_en & and_dcpl_202 & and_dcpl_191;
  assign and_1397_cse = ccs_ccore_en & and_dcpl_202 & and_dcpl_195;
  assign and_1399_cse = ccs_ccore_en & and_dcpl_202 & and_dcpl_198;
  assign and_1401_cse = ccs_ccore_en & and_dcpl_202 & and_dcpl_200;
  assign and_1403_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_207 & (~ (rem_12cyc_st_3_1_0[0]));
  assign and_1405_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_207 & (rem_12cyc_st_3_1_0[0]);
  assign and_1407_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_212 & (~ (rem_12cyc_st_3_1_0[0]));
  assign and_1409_cse = ccs_ccore_en & and_dcpl_193 & and_dcpl_212 & (rem_12cyc_st_3_1_0[0]);
  assign and_1411_cse = ccs_ccore_en & and_dcpl_192;
  assign and_1413_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_218;
  assign and_1415_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_222;
  assign and_1417_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_225;
  assign and_1419_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_227;
  assign and_1421_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_229 & (~ (rem_12cyc_st_2_1_0[0]));
  assign and_1423_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_229 & (rem_12cyc_st_2_1_0[0]);
  assign and_1425_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_234 & (~ (rem_12cyc_st_2_1_0[0]));
  assign and_1427_cse = ccs_ccore_en & and_dcpl_220 & and_dcpl_234 & (rem_12cyc_st_2_1_0[0]);
  assign and_1429_cse = ccs_ccore_en & and_dcpl_239 & and_dcpl_218;
  assign and_1431_cse = ccs_ccore_en & and_dcpl_239 & and_dcpl_222;
  assign and_1433_cse = ccs_ccore_en & and_dcpl_239 & and_dcpl_225;
  assign and_1435_cse = ccs_ccore_en & and_dcpl_239 & and_dcpl_227;
  assign and_1437_cse = ccs_ccore_en & and_dcpl_219;
  assign and_1439_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_245;
  assign and_1441_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_249;
  assign and_1443_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_252;
  assign and_1445_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_254;
  assign and_1447_cse = ccs_ccore_en & and_dcpl_256 & and_dcpl_245;
  assign and_1449_cse = ccs_ccore_en & and_dcpl_256 & and_dcpl_249;
  assign and_1451_cse = ccs_ccore_en & and_dcpl_256 & and_dcpl_252;
  assign and_1453_cse = ccs_ccore_en & and_dcpl_256 & and_dcpl_254;
  assign and_1455_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_261 & (~ (rem_12cyc_1_0[0]));
  assign and_1457_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_261 & (rem_12cyc_1_0[0]);
  assign and_1459_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_266 & (~ (rem_12cyc_1_0[0]));
  assign and_1461_cse = ccs_ccore_en & and_dcpl_247 & and_dcpl_266 & (rem_12cyc_1_0[0]);
  assign and_1463_cse = ccs_ccore_en & and_dcpl_246;
  assign and_1197_cse = ccs_ccore_en & ccs_ccore_start_rsci_idat;
  assign and_273_nl = and_dcpl_272 & and_dcpl_271;
  assign and_275_nl = and_dcpl_272 & and_dcpl_274;
  assign and_277_nl = and_dcpl_272 & and_dcpl_276;
  assign and_279_nl = and_dcpl_272 & and_dcpl_278;
  assign and_281_nl = and_dcpl_280 & and_dcpl_271;
  assign and_282_nl = and_dcpl_280 & and_dcpl_274;
  assign and_283_nl = and_dcpl_280 & and_dcpl_276;
  assign and_284_nl = and_dcpl_280 & and_dcpl_278;
  assign and_286_nl = and_dcpl_285 & and_dcpl_271;
  assign and_287_nl = and_dcpl_285 & and_dcpl_274;
  assign and_288_nl = and_dcpl_285 & and_dcpl_276;
  assign and_289_nl = and_dcpl_285 & and_dcpl_278;
  assign and_290_nl = (rem_12cyc_st_12_3_2==2'b11);
  assign result_sva_duc_mx0 = MUX1HOT_v_64_13_2((rem_13_cmp_1_z[63:0]), (rem_13_cmp_2_z[63:0]),
      (rem_13_cmp_3_z[63:0]), (rem_13_cmp_4_z[63:0]), (rem_13_cmp_5_z[63:0]), (rem_13_cmp_6_z[63:0]),
      (rem_13_cmp_7_z[63:0]), (rem_13_cmp_8_z[63:0]), (rem_13_cmp_9_z[63:0]), (rem_13_cmp_10_z[63:0]),
      (rem_13_cmp_11_z[63:0]), (rem_13_cmp_z[63:0]), result_sva_duc, {and_273_nl
      , and_275_nl , and_277_nl , and_279_nl , and_281_nl , and_282_nl , and_283_nl
      , and_284_nl , and_286_nl , and_287_nl , and_288_nl , and_289_nl , and_290_nl});
  assign nl_acc_1_tmp = ({rem_12cyc_3_2 , rem_12cyc_1_0}) + 4'b0001;
  assign acc_1_tmp = nl_acc_1_tmp[3:0];
  assign xor_nl = (acc_1_tmp[2]) ^ (acc_1_tmp[3]);
  assign nor_nl = ~((acc_1_tmp[3:2]!=2'b10));
  assign nl_acc_tmp = conv_u2u_1_2(xor_nl) + conv_u2u_1_2(nor_nl);
  assign acc_tmp = nl_acc_tmp[1:0];
  assign and_dcpl_1 = ~((rem_12cyc_st_10_3_2[1]) | (rem_12cyc_st_10_1_0[1]));
  assign and_dcpl_2 = and_dcpl_1 & (~ (rem_12cyc_st_10_1_0[0]));
  assign and_dcpl_3 = main_stage_0_11 & asn_itm_10;
  assign and_dcpl_4 = and_dcpl_3 & (~ (rem_12cyc_st_10_3_2[0]));
  assign and_dcpl_6 = and_dcpl_1 & (rem_12cyc_st_10_1_0[0]);
  assign and_dcpl_8 = (~ (rem_12cyc_st_10_3_2[1])) & (rem_12cyc_st_10_1_0[1]);
  assign and_dcpl_9 = and_dcpl_8 & (~ (rem_12cyc_st_10_1_0[0]));
  assign and_dcpl_11 = and_dcpl_8 & (rem_12cyc_st_10_1_0[0]);
  assign and_dcpl_13 = and_dcpl_3 & (rem_12cyc_st_10_3_2[0]);
  assign and_dcpl_18 = (rem_12cyc_st_10_3_2[1]) & (~ (rem_12cyc_st_10_1_0[1]));
  assign and_dcpl_23 = (rem_12cyc_st_10_3_2[1]) & (rem_12cyc_st_10_1_0[1]);
  assign and_dcpl_28 = ~((rem_12cyc_st_9_3_2[1]) | (rem_12cyc_st_9_1_0[1]));
  assign and_dcpl_29 = and_dcpl_28 & (~ (rem_12cyc_st_9_1_0[0]));
  assign and_dcpl_30 = main_stage_0_10 & asn_itm_9;
  assign and_dcpl_31 = and_dcpl_30 & (~ (rem_12cyc_st_9_3_2[0]));
  assign and_dcpl_33 = and_dcpl_28 & (rem_12cyc_st_9_1_0[0]);
  assign and_dcpl_35 = (~ (rem_12cyc_st_9_3_2[1])) & (rem_12cyc_st_9_1_0[1]);
  assign and_dcpl_36 = and_dcpl_35 & (~ (rem_12cyc_st_9_1_0[0]));
  assign and_dcpl_38 = and_dcpl_35 & (rem_12cyc_st_9_1_0[0]);
  assign and_dcpl_40 = and_dcpl_30 & (rem_12cyc_st_9_3_2[0]);
  assign and_dcpl_45 = (rem_12cyc_st_9_3_2[1]) & (~ (rem_12cyc_st_9_1_0[1]));
  assign and_dcpl_50 = (rem_12cyc_st_9_3_2[1]) & (rem_12cyc_st_9_1_0[1]);
  assign and_dcpl_55 = ~((rem_12cyc_st_8_3_2[1]) | (rem_12cyc_st_8_1_0[1]));
  assign and_dcpl_56 = and_dcpl_55 & (~ (rem_12cyc_st_8_1_0[0]));
  assign and_dcpl_57 = main_stage_0_9 & asn_itm_8;
  assign and_dcpl_58 = and_dcpl_57 & (~ (rem_12cyc_st_8_3_2[0]));
  assign and_dcpl_60 = and_dcpl_55 & (rem_12cyc_st_8_1_0[0]);
  assign and_dcpl_62 = (~ (rem_12cyc_st_8_3_2[1])) & (rem_12cyc_st_8_1_0[1]);
  assign and_dcpl_63 = and_dcpl_62 & (~ (rem_12cyc_st_8_1_0[0]));
  assign and_dcpl_65 = and_dcpl_62 & (rem_12cyc_st_8_1_0[0]);
  assign and_dcpl_67 = and_dcpl_57 & (rem_12cyc_st_8_3_2[0]);
  assign and_dcpl_72 = (rem_12cyc_st_8_3_2[1]) & (~ (rem_12cyc_st_8_1_0[1]));
  assign and_dcpl_77 = (rem_12cyc_st_8_3_2[1]) & (rem_12cyc_st_8_1_0[1]);
  assign and_dcpl_82 = ~((rem_12cyc_st_7_3_2[1]) | (rem_12cyc_st_7_1_0[1]));
  assign and_dcpl_83 = and_dcpl_82 & (~ (rem_12cyc_st_7_1_0[0]));
  assign and_dcpl_84 = main_stage_0_8 & asn_itm_7;
  assign and_dcpl_85 = and_dcpl_84 & (~ (rem_12cyc_st_7_3_2[0]));
  assign and_dcpl_87 = and_dcpl_82 & (rem_12cyc_st_7_1_0[0]);
  assign and_dcpl_89 = (~ (rem_12cyc_st_7_3_2[1])) & (rem_12cyc_st_7_1_0[1]);
  assign and_dcpl_90 = and_dcpl_89 & (~ (rem_12cyc_st_7_1_0[0]));
  assign and_dcpl_92 = and_dcpl_89 & (rem_12cyc_st_7_1_0[0]);
  assign and_dcpl_94 = and_dcpl_84 & (rem_12cyc_st_7_3_2[0]);
  assign and_dcpl_99 = (rem_12cyc_st_7_3_2[1]) & (~ (rem_12cyc_st_7_1_0[1]));
  assign and_dcpl_104 = (rem_12cyc_st_7_3_2[1]) & (rem_12cyc_st_7_1_0[1]);
  assign and_dcpl_109 = ~((rem_12cyc_st_6_3_2[1]) | (rem_12cyc_st_6_1_0[0]));
  assign and_dcpl_110 = and_dcpl_109 & (~ (rem_12cyc_st_6_1_0[1]));
  assign and_dcpl_111 = main_stage_0_7 & asn_itm_6;
  assign and_dcpl_112 = and_dcpl_111 & (~ (rem_12cyc_st_6_3_2[0]));
  assign and_dcpl_114 = (~ (rem_12cyc_st_6_3_2[1])) & (rem_12cyc_st_6_1_0[0]);
  assign and_dcpl_115 = and_dcpl_114 & (~ (rem_12cyc_st_6_1_0[1]));
  assign and_dcpl_117 = and_dcpl_109 & (rem_12cyc_st_6_1_0[1]);
  assign and_dcpl_119 = and_dcpl_114 & (rem_12cyc_st_6_1_0[1]);
  assign and_dcpl_121 = and_dcpl_111 & (rem_12cyc_st_6_3_2[0]);
  assign and_dcpl_126 = (rem_12cyc_st_6_3_2[1]) & (~ (rem_12cyc_st_6_1_0[0]));
  assign and_dcpl_129 = (rem_12cyc_st_6_3_2[1]) & (rem_12cyc_st_6_1_0[0]);
  assign and_dcpl_136 = ~((rem_12cyc_st_5_3_2[1]) | (rem_12cyc_st_5_1_0[1]));
  assign and_dcpl_137 = and_dcpl_136 & (~ (rem_12cyc_st_5_1_0[0]));
  assign and_dcpl_138 = main_stage_0_6 & asn_itm_5;
  assign and_dcpl_139 = and_dcpl_138 & (~ (rem_12cyc_st_5_3_2[0]));
  assign and_dcpl_141 = and_dcpl_136 & (rem_12cyc_st_5_1_0[0]);
  assign and_dcpl_143 = (~ (rem_12cyc_st_5_3_2[1])) & (rem_12cyc_st_5_1_0[1]);
  assign and_dcpl_144 = and_dcpl_143 & (~ (rem_12cyc_st_5_1_0[0]));
  assign and_dcpl_146 = and_dcpl_143 & (rem_12cyc_st_5_1_0[0]);
  assign and_dcpl_148 = and_dcpl_138 & (rem_12cyc_st_5_3_2[0]);
  assign and_dcpl_153 = (rem_12cyc_st_5_3_2[1]) & (~ (rem_12cyc_st_5_1_0[1]));
  assign and_dcpl_158 = (rem_12cyc_st_5_3_2[1]) & (rem_12cyc_st_5_1_0[1]);
  assign and_dcpl_163 = ~((rem_12cyc_st_4_3_2[0]) | (rem_12cyc_st_4_1_0[1]));
  assign and_dcpl_164 = and_dcpl_163 & (~ (rem_12cyc_st_4_1_0[0]));
  assign and_dcpl_165 = main_stage_0_5 & asn_itm_4;
  assign and_dcpl_166 = and_dcpl_165 & (~ (rem_12cyc_st_4_3_2[1]));
  assign and_dcpl_168 = and_dcpl_163 & (rem_12cyc_st_4_1_0[0]);
  assign and_dcpl_170 = (~ (rem_12cyc_st_4_3_2[0])) & (rem_12cyc_st_4_1_0[1]);
  assign and_dcpl_171 = and_dcpl_170 & (~ (rem_12cyc_st_4_1_0[0]));
  assign and_dcpl_173 = and_dcpl_170 & (rem_12cyc_st_4_1_0[0]);
  assign and_dcpl_175 = (rem_12cyc_st_4_3_2[0]) & (~ (rem_12cyc_st_4_1_0[1]));
  assign and_dcpl_180 = (rem_12cyc_st_4_3_2[0]) & (rem_12cyc_st_4_1_0[1]);
  assign and_dcpl_185 = and_dcpl_165 & (rem_12cyc_st_4_3_2[1]);
  assign and_dcpl_190 = ~((rem_12cyc_st_3_3_2[1]) | (rem_12cyc_st_3_1_0[1]));
  assign and_dcpl_191 = and_dcpl_190 & (~ (rem_12cyc_st_3_1_0[0]));
  assign and_dcpl_192 = main_stage_0_4 & asn_itm_3;
  assign and_dcpl_193 = and_dcpl_192 & (~ (rem_12cyc_st_3_3_2[0]));
  assign and_dcpl_195 = and_dcpl_190 & (rem_12cyc_st_3_1_0[0]);
  assign and_dcpl_197 = (~ (rem_12cyc_st_3_3_2[1])) & (rem_12cyc_st_3_1_0[1]);
  assign and_dcpl_198 = and_dcpl_197 & (~ (rem_12cyc_st_3_1_0[0]));
  assign and_dcpl_200 = and_dcpl_197 & (rem_12cyc_st_3_1_0[0]);
  assign and_dcpl_202 = and_dcpl_192 & (rem_12cyc_st_3_3_2[0]);
  assign and_dcpl_207 = (rem_12cyc_st_3_3_2[1]) & (~ (rem_12cyc_st_3_1_0[1]));
  assign and_dcpl_212 = (rem_12cyc_st_3_3_2[1]) & (rem_12cyc_st_3_1_0[1]);
  assign and_dcpl_217 = ~((rem_12cyc_st_2_3_2[0]) | (rem_12cyc_st_2_1_0[1]));
  assign and_dcpl_218 = and_dcpl_217 & (~ (rem_12cyc_st_2_1_0[0]));
  assign and_dcpl_219 = main_stage_0_3 & asn_itm_2;
  assign and_dcpl_220 = and_dcpl_219 & (~ (rem_12cyc_st_2_3_2[1]));
  assign and_dcpl_222 = and_dcpl_217 & (rem_12cyc_st_2_1_0[0]);
  assign and_dcpl_224 = (~ (rem_12cyc_st_2_3_2[0])) & (rem_12cyc_st_2_1_0[1]);
  assign and_dcpl_225 = and_dcpl_224 & (~ (rem_12cyc_st_2_1_0[0]));
  assign and_dcpl_227 = and_dcpl_224 & (rem_12cyc_st_2_1_0[0]);
  assign and_dcpl_229 = (rem_12cyc_st_2_3_2[0]) & (~ (rem_12cyc_st_2_1_0[1]));
  assign and_dcpl_234 = (rem_12cyc_st_2_3_2[0]) & (rem_12cyc_st_2_1_0[1]);
  assign and_dcpl_239 = and_dcpl_219 & (rem_12cyc_st_2_3_2[1]);
  assign and_dcpl_244 = ~((rem_12cyc_3_2[1]) | (rem_12cyc_1_0[1]));
  assign and_dcpl_245 = and_dcpl_244 & (~ (rem_12cyc_1_0[0]));
  assign and_dcpl_246 = main_stage_0_2 & asn_itm_1;
  assign and_dcpl_247 = and_dcpl_246 & (~ (rem_12cyc_3_2[0]));
  assign and_dcpl_249 = and_dcpl_244 & (rem_12cyc_1_0[0]);
  assign and_dcpl_251 = (~ (rem_12cyc_3_2[1])) & (rem_12cyc_1_0[1]);
  assign and_dcpl_252 = and_dcpl_251 & (~ (rem_12cyc_1_0[0]));
  assign and_dcpl_254 = and_dcpl_251 & (rem_12cyc_1_0[0]);
  assign and_dcpl_256 = and_dcpl_246 & (rem_12cyc_3_2[0]);
  assign and_dcpl_261 = (rem_12cyc_3_2[1]) & (~ (rem_12cyc_1_0[1]));
  assign and_dcpl_266 = (rem_12cyc_3_2[1]) & (rem_12cyc_1_0[1]);
  assign and_dcpl_271 = ~((rem_12cyc_st_12_1_0!=2'b00));
  assign and_dcpl_272 = ~((rem_12cyc_st_12_3_2!=2'b00));
  assign and_dcpl_274 = (rem_12cyc_st_12_1_0==2'b01);
  assign and_dcpl_276 = (rem_12cyc_st_12_1_0==2'b10);
  assign and_dcpl_278 = (rem_12cyc_st_12_1_0==2'b11);
  assign and_dcpl_280 = (rem_12cyc_st_12_3_2==2'b01);
  assign and_dcpl_285 = (rem_12cyc_st_12_3_2==2'b10);
  assign and_dcpl_291 = ~((acc_1_tmp[1:0]!=2'b00));
  assign and_dcpl_292 = ccs_ccore_start_rsci_idat & (~ (acc_tmp[0]));
  assign and_dcpl_293 = and_dcpl_292 & (~ (acc_tmp[1]));
  assign and_dcpl_294 = and_dcpl_293 & and_dcpl_291;
  assign and_dcpl_295 = ~((rem_12cyc_st_2_3_2!=2'b00));
  assign and_dcpl_296 = and_dcpl_295 & (~ (rem_12cyc_st_2_1_0[1]));
  assign and_dcpl_298 = (~ (rem_12cyc_st_2_1_0[0])) & main_stage_0_3 & asn_itm_2;
  assign not_tmp_54 = ~(asn_itm_1 & main_stage_0_2);
  assign or_tmp_2 = (rem_12cyc_1_0!=2'b00) | (rem_12cyc_3_2!=2'b00) | not_tmp_54;
  assign or_1_cse = (acc_1_tmp[1:0]!=2'b00) | (acc_tmp!=2'b00);
  assign nor_518_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_2));
  assign mux_14_nl = MUX_s_1_2_2(nor_518_nl, or_tmp_2, or_1_cse);
  assign and_dcpl_300 = mux_14_nl & and_dcpl_298 & and_dcpl_296;
  assign and_dcpl_301 = ~((rem_12cyc_st_3_3_2!=2'b00));
  assign and_dcpl_302 = and_dcpl_301 & (~ (rem_12cyc_st_3_1_0[1]));
  assign and_dcpl_304 = (~ (rem_12cyc_st_3_1_0[0])) & main_stage_0_4 & asn_itm_3;
  assign or_6_cse = (rem_12cyc_st_2_1_0[1]) | (rem_12cyc_st_2_3_2!=2'b00) | (~ asn_itm_2)
      | (~ main_stage_0_3) | (rem_12cyc_st_2_1_0[0]);
  assign and_tmp = or_6_cse & or_tmp_2;
  assign nor_517_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp));
  assign mux_15_nl = MUX_s_1_2_2(nor_517_nl, and_tmp, or_1_cse);
  assign and_dcpl_306 = mux_15_nl & and_dcpl_304 & and_dcpl_302;
  assign and_dcpl_307 = ~((rem_12cyc_st_4_3_2!=2'b00));
  assign and_dcpl_308 = and_dcpl_307 & (~ (rem_12cyc_st_4_1_0[1]));
  assign and_dcpl_310 = (~ (rem_12cyc_st_4_1_0[0])) & main_stage_0_5 & asn_itm_4;
  assign or_10_cse = (rem_12cyc_st_3_1_0[1]) | (rem_12cyc_st_3_3_2!=2'b00) | (~ asn_itm_3)
      | (~ main_stage_0_4) | (rem_12cyc_st_3_1_0[0]);
  assign and_tmp_2 = or_6_cse & or_10_cse & or_tmp_2;
  assign nor_516_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_2));
  assign mux_16_nl = MUX_s_1_2_2(nor_516_nl, and_tmp_2, or_1_cse);
  assign and_dcpl_312 = mux_16_nl & and_dcpl_310 & and_dcpl_308;
  assign and_dcpl_313 = ~((rem_12cyc_st_5_3_2!=2'b00));
  assign and_dcpl_314 = and_dcpl_313 & (~ (rem_12cyc_st_5_1_0[1]));
  assign and_dcpl_316 = (~ (rem_12cyc_st_5_1_0[0])) & main_stage_0_6 & asn_itm_5;
  assign or_15_cse = (rem_12cyc_st_4_1_0[1]) | (rem_12cyc_st_4_3_2!=2'b00) | (~ asn_itm_4)
      | (~ main_stage_0_5) | (rem_12cyc_st_4_1_0[0]);
  assign and_tmp_5 = or_6_cse & or_10_cse & or_15_cse & or_tmp_2;
  assign nor_515_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_5));
  assign mux_17_nl = MUX_s_1_2_2(nor_515_nl, and_tmp_5, or_1_cse);
  assign and_dcpl_318 = mux_17_nl & and_dcpl_316 & and_dcpl_314;
  assign or_21_cse = (rem_12cyc_st_5_1_0[1]) | (rem_12cyc_st_5_3_2!=2'b00) | (~ asn_itm_5)
      | (~ main_stage_0_6) | (rem_12cyc_st_5_1_0[0]);
  assign and_tmp_9 = or_6_cse & or_10_cse & or_15_cse & or_21_cse & or_tmp_2;
  assign nor_514_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_9));
  assign mux_18_nl = MUX_s_1_2_2(nor_514_nl, and_tmp_9, or_1_cse);
  assign and_dcpl_324 = mux_18_nl & and_dcpl_112 & and_dcpl_110;
  assign or_28_cse = (rem_12cyc_st_6_1_0!=2'b00) | (rem_12cyc_st_6_3_2!=2'b00);
  assign nor_512_nl = ~(and_dcpl_111 | (~ or_tmp_2));
  assign mux_19_nl = MUX_s_1_2_2(nor_512_nl, or_tmp_2, or_28_cse);
  assign and_tmp_13 = or_6_cse & or_10_cse & or_15_cse & or_21_cse & mux_19_nl;
  assign nor_513_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_13));
  assign mux_20_nl = MUX_s_1_2_2(nor_513_nl, and_tmp_13, or_1_cse);
  assign and_dcpl_330 = mux_20_nl & and_dcpl_85 & and_dcpl_83;
  assign or_37_cse = (rem_12cyc_st_7_1_0!=2'b00) | (rem_12cyc_st_7_3_2!=2'b00);
  assign nor_509_nl = ~(and_dcpl_84 | (~ or_tmp_2));
  assign mux_tmp_19 = MUX_s_1_2_2(nor_509_nl, or_tmp_2, or_37_cse);
  assign nor_510_nl = ~(and_dcpl_111 | (~ mux_tmp_19));
  assign mux_22_nl = MUX_s_1_2_2(nor_510_nl, mux_tmp_19, or_28_cse);
  assign and_tmp_17 = or_6_cse & or_10_cse & or_15_cse & or_21_cse & mux_22_nl;
  assign nor_511_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_17));
  assign mux_23_nl = MUX_s_1_2_2(nor_511_nl, and_tmp_17, or_1_cse);
  assign and_dcpl_336 = mux_23_nl & and_dcpl_58 & and_dcpl_56;
  assign or_48_cse = (rem_12cyc_st_8_1_0!=2'b00) | (rem_12cyc_st_8_3_2!=2'b00);
  assign nor_505_nl = ~(and_dcpl_57 | (~ or_tmp_2));
  assign mux_tmp_22 = MUX_s_1_2_2(nor_505_nl, or_tmp_2, or_48_cse);
  assign nor_506_nl = ~(and_dcpl_84 | (~ mux_tmp_22));
  assign mux_tmp_23 = MUX_s_1_2_2(nor_506_nl, mux_tmp_22, or_37_cse);
  assign nor_507_nl = ~(and_dcpl_111 | (~ mux_tmp_23));
  assign mux_26_nl = MUX_s_1_2_2(nor_507_nl, mux_tmp_23, or_28_cse);
  assign and_tmp_21 = or_6_cse & or_10_cse & or_15_cse & or_21_cse & mux_26_nl;
  assign nor_508_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_21));
  assign mux_27_nl = MUX_s_1_2_2(nor_508_nl, and_tmp_21, or_1_cse);
  assign and_dcpl_342 = mux_27_nl & and_dcpl_31 & and_dcpl_29;
  assign nor_500_nl = ~(and_dcpl_30 | (~ or_tmp_2));
  assign or_61_nl = (rem_12cyc_st_9_1_0!=2'b00) | (rem_12cyc_st_9_3_2!=2'b00);
  assign mux_tmp_26 = MUX_s_1_2_2(nor_500_nl, or_tmp_2, or_61_nl);
  assign nor_501_nl = ~(and_dcpl_57 | (~ mux_tmp_26));
  assign mux_tmp_27 = MUX_s_1_2_2(nor_501_nl, mux_tmp_26, or_48_cse);
  assign nor_502_nl = ~(and_dcpl_84 | (~ mux_tmp_27));
  assign mux_tmp_28 = MUX_s_1_2_2(nor_502_nl, mux_tmp_27, or_37_cse);
  assign nor_503_nl = ~(and_dcpl_111 | (~ mux_tmp_28));
  assign mux_31_nl = MUX_s_1_2_2(nor_503_nl, mux_tmp_28, or_28_cse);
  assign and_tmp_25 = or_6_cse & or_10_cse & or_15_cse & or_21_cse & mux_31_nl;
  assign nor_504_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_25));
  assign mux_32_nl = MUX_s_1_2_2(nor_504_nl, and_tmp_25, or_1_cse);
  assign and_dcpl_348 = mux_32_nl & and_dcpl_4 & and_dcpl_2;
  assign and_tmp_35 = ((~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b00)
      | (rem_12cyc_1_0!=2'b00)) & ((~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b00)
      | (rem_12cyc_st_7_3_2!=2'b00)) & ((~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b00)
      | (rem_12cyc_st_8_3_2!=2'b00)) & ((~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b00)
      | (rem_12cyc_st_9_3_2!=2'b00)) & or_6_cse & or_10_cse & or_15_cse & or_21_cse
      & ((~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b00) | (rem_12cyc_st_6_3_2!=2'b00))
      & ((~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b00) | (rem_12cyc_st_10_3_2!=2'b00))
      & ((acc_tmp!=2'b00) | (acc_1_tmp[1:0]!=2'b00) | (~ ccs_ccore_start_rsci_idat));
  assign and_dcpl_355 = (acc_1_tmp[1:0]==2'b01);
  assign and_dcpl_356 = and_dcpl_293 & and_dcpl_355;
  assign and_dcpl_358 = (rem_12cyc_st_2_1_0[0]) & main_stage_0_3 & asn_itm_2;
  assign or_tmp_80 = (rem_12cyc_1_0!=2'b01) | (rem_12cyc_3_2!=2'b00) | not_tmp_54;
  assign or_83_cse = (acc_1_tmp[1:0]!=2'b01) | (acc_tmp!=2'b00);
  assign nor_499_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_80));
  assign mux_33_nl = MUX_s_1_2_2(nor_499_nl, or_tmp_80, or_83_cse);
  assign and_dcpl_360 = mux_33_nl & and_dcpl_358 & and_dcpl_296;
  assign and_dcpl_362 = (rem_12cyc_st_3_1_0[0]) & main_stage_0_4 & asn_itm_3;
  assign nand_276_cse = ~(asn_itm_2 & main_stage_0_3 & (rem_12cyc_st_2_1_0[0]));
  assign or_88_cse = (rem_12cyc_st_2_1_0[1]) | (rem_12cyc_st_2_3_2!=2'b00);
  assign and_1168_nl = nand_276_cse & or_tmp_80;
  assign mux_tmp_32 = MUX_s_1_2_2(and_1168_nl, or_tmp_80, or_88_cse);
  assign nor_498_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_32));
  assign mux_35_nl = MUX_s_1_2_2(nor_498_nl, mux_tmp_32, or_83_cse);
  assign and_dcpl_364 = mux_35_nl & and_dcpl_362 & and_dcpl_302;
  assign and_dcpl_366 = (rem_12cyc_st_4_1_0[0]) & main_stage_0_5 & asn_itm_4;
  assign nand_274_cse = ~(asn_itm_3 & main_stage_0_4 & (rem_12cyc_st_3_1_0[0]));
  assign or_93_cse = (rem_12cyc_st_3_1_0[1]) | (rem_12cyc_st_3_3_2!=2'b00);
  assign and_1166_nl = nand_274_cse & or_tmp_80;
  assign mux_tmp_34 = MUX_s_1_2_2(and_1166_nl, or_tmp_80, or_93_cse);
  assign and_1167_nl = nand_276_cse & mux_tmp_34;
  assign mux_tmp_35 = MUX_s_1_2_2(and_1167_nl, mux_tmp_34, or_88_cse);
  assign nor_497_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_35));
  assign mux_38_nl = MUX_s_1_2_2(nor_497_nl, mux_tmp_35, or_83_cse);
  assign and_dcpl_368 = mux_38_nl & and_dcpl_366 & and_dcpl_308;
  assign and_dcpl_370 = (rem_12cyc_st_5_1_0[0]) & main_stage_0_6 & asn_itm_5;
  assign nand_271_cse = ~(asn_itm_4 & main_stage_0_5 & (rem_12cyc_st_4_1_0[0]));
  assign or_100_cse = (rem_12cyc_st_4_1_0[1]) | (rem_12cyc_st_4_3_2!=2'b00);
  assign and_1163_nl = nand_271_cse & or_tmp_80;
  assign mux_tmp_37 = MUX_s_1_2_2(and_1163_nl, or_tmp_80, or_100_cse);
  assign and_1164_nl = nand_274_cse & mux_tmp_37;
  assign mux_tmp_38 = MUX_s_1_2_2(and_1164_nl, mux_tmp_37, or_93_cse);
  assign and_1165_nl = nand_276_cse & mux_tmp_38;
  assign mux_tmp_39 = MUX_s_1_2_2(and_1165_nl, mux_tmp_38, or_88_cse);
  assign nor_496_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_39));
  assign mux_42_nl = MUX_s_1_2_2(nor_496_nl, mux_tmp_39, or_83_cse);
  assign and_dcpl_372 = mux_42_nl & and_dcpl_370 & and_dcpl_314;
  assign nand_267_cse = ~(asn_itm_5 & main_stage_0_6 & (rem_12cyc_st_5_1_0[0]));
  assign or_109_cse = (rem_12cyc_st_5_1_0[1]) | (rem_12cyc_st_5_3_2!=2'b00);
  assign and_1159_nl = nand_267_cse & or_tmp_80;
  assign mux_tmp_41 = MUX_s_1_2_2(and_1159_nl, or_tmp_80, or_109_cse);
  assign and_1160_nl = nand_271_cse & mux_tmp_41;
  assign mux_tmp_42 = MUX_s_1_2_2(and_1160_nl, mux_tmp_41, or_100_cse);
  assign and_1161_nl = nand_274_cse & mux_tmp_42;
  assign mux_tmp_43 = MUX_s_1_2_2(and_1161_nl, mux_tmp_42, or_93_cse);
  assign and_1162_nl = nand_276_cse & mux_tmp_43;
  assign mux_tmp_44 = MUX_s_1_2_2(and_1162_nl, mux_tmp_43, or_88_cse);
  assign nor_495_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_44));
  assign mux_47_nl = MUX_s_1_2_2(nor_495_nl, mux_tmp_44, or_83_cse);
  assign and_dcpl_376 = mux_47_nl & and_dcpl_112 & and_dcpl_115;
  assign or_120_cse = (rem_12cyc_st_6_1_0!=2'b01) | (rem_12cyc_st_6_3_2!=2'b00);
  assign nor_493_nl = ~(and_dcpl_111 | (~ or_tmp_80));
  assign mux_tmp_46 = MUX_s_1_2_2(nor_493_nl, or_tmp_80, or_120_cse);
  assign and_1155_nl = nand_267_cse & mux_tmp_46;
  assign mux_tmp_47 = MUX_s_1_2_2(and_1155_nl, mux_tmp_46, or_109_cse);
  assign and_1156_nl = nand_271_cse & mux_tmp_47;
  assign mux_tmp_48 = MUX_s_1_2_2(and_1156_nl, mux_tmp_47, or_100_cse);
  assign and_1157_nl = nand_274_cse & mux_tmp_48;
  assign mux_tmp_49 = MUX_s_1_2_2(and_1157_nl, mux_tmp_48, or_93_cse);
  assign and_1158_nl = nand_276_cse & mux_tmp_49;
  assign mux_tmp_50 = MUX_s_1_2_2(and_1158_nl, mux_tmp_49, or_88_cse);
  assign nor_494_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_50));
  assign mux_53_nl = MUX_s_1_2_2(nor_494_nl, mux_tmp_50, or_83_cse);
  assign and_dcpl_379 = mux_53_nl & and_dcpl_85 & and_dcpl_87;
  assign or_133_cse = (rem_12cyc_st_7_1_0!=2'b01) | (rem_12cyc_st_7_3_2!=2'b00);
  assign nor_490_nl = ~(and_dcpl_84 | (~ or_tmp_80));
  assign mux_tmp_52 = MUX_s_1_2_2(nor_490_nl, or_tmp_80, or_133_cse);
  assign nor_491_nl = ~(and_dcpl_111 | (~ mux_tmp_52));
  assign mux_tmp_53 = MUX_s_1_2_2(nor_491_nl, mux_tmp_52, or_120_cse);
  assign and_1151_nl = nand_267_cse & mux_tmp_53;
  assign mux_tmp_54 = MUX_s_1_2_2(and_1151_nl, mux_tmp_53, or_109_cse);
  assign and_1152_nl = nand_271_cse & mux_tmp_54;
  assign mux_tmp_55 = MUX_s_1_2_2(and_1152_nl, mux_tmp_54, or_100_cse);
  assign and_1153_nl = nand_274_cse & mux_tmp_55;
  assign mux_tmp_56 = MUX_s_1_2_2(and_1153_nl, mux_tmp_55, or_93_cse);
  assign and_1154_nl = nand_276_cse & mux_tmp_56;
  assign mux_tmp_57 = MUX_s_1_2_2(and_1154_nl, mux_tmp_56, or_88_cse);
  assign nor_492_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_57));
  assign mux_60_nl = MUX_s_1_2_2(nor_492_nl, mux_tmp_57, or_83_cse);
  assign and_dcpl_382 = mux_60_nl & and_dcpl_58 & and_dcpl_60;
  assign or_148_cse = (rem_12cyc_st_8_1_0!=2'b01) | (rem_12cyc_st_8_3_2!=2'b00);
  assign nor_486_nl = ~(and_dcpl_57 | (~ or_tmp_80));
  assign mux_tmp_59 = MUX_s_1_2_2(nor_486_nl, or_tmp_80, or_148_cse);
  assign nor_487_nl = ~(and_dcpl_84 | (~ mux_tmp_59));
  assign mux_tmp_60 = MUX_s_1_2_2(nor_487_nl, mux_tmp_59, or_133_cse);
  assign nor_488_nl = ~(and_dcpl_111 | (~ mux_tmp_60));
  assign mux_tmp_61 = MUX_s_1_2_2(nor_488_nl, mux_tmp_60, or_120_cse);
  assign and_1147_nl = nand_267_cse & mux_tmp_61;
  assign mux_tmp_62 = MUX_s_1_2_2(and_1147_nl, mux_tmp_61, or_109_cse);
  assign and_1148_nl = nand_271_cse & mux_tmp_62;
  assign mux_tmp_63 = MUX_s_1_2_2(and_1148_nl, mux_tmp_62, or_100_cse);
  assign and_1149_nl = nand_274_cse & mux_tmp_63;
  assign mux_tmp_64 = MUX_s_1_2_2(and_1149_nl, mux_tmp_63, or_93_cse);
  assign and_1150_nl = nand_276_cse & mux_tmp_64;
  assign mux_tmp_65 = MUX_s_1_2_2(and_1150_nl, mux_tmp_64, or_88_cse);
  assign nor_489_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_65));
  assign mux_68_nl = MUX_s_1_2_2(nor_489_nl, mux_tmp_65, or_83_cse);
  assign and_dcpl_385 = mux_68_nl & and_dcpl_31 & and_dcpl_33;
  assign nor_481_nl = ~(and_dcpl_30 | (~ or_tmp_80));
  assign or_165_nl = (rem_12cyc_st_9_1_0!=2'b01) | (rem_12cyc_st_9_3_2!=2'b00);
  assign mux_tmp_67 = MUX_s_1_2_2(nor_481_nl, or_tmp_80, or_165_nl);
  assign nor_482_nl = ~(and_dcpl_57 | (~ mux_tmp_67));
  assign mux_tmp_68 = MUX_s_1_2_2(nor_482_nl, mux_tmp_67, or_148_cse);
  assign nor_483_nl = ~(and_dcpl_84 | (~ mux_tmp_68));
  assign mux_tmp_69 = MUX_s_1_2_2(nor_483_nl, mux_tmp_68, or_133_cse);
  assign nor_484_nl = ~(and_dcpl_111 | (~ mux_tmp_69));
  assign mux_tmp_70 = MUX_s_1_2_2(nor_484_nl, mux_tmp_69, or_120_cse);
  assign and_1143_nl = nand_267_cse & mux_tmp_70;
  assign mux_tmp_71 = MUX_s_1_2_2(and_1143_nl, mux_tmp_70, or_109_cse);
  assign and_1144_nl = nand_271_cse & mux_tmp_71;
  assign mux_tmp_72 = MUX_s_1_2_2(and_1144_nl, mux_tmp_71, or_100_cse);
  assign and_1145_nl = nand_274_cse & mux_tmp_72;
  assign mux_tmp_73 = MUX_s_1_2_2(and_1145_nl, mux_tmp_72, or_93_cse);
  assign and_1146_nl = nand_276_cse & mux_tmp_73;
  assign mux_tmp_74 = MUX_s_1_2_2(and_1146_nl, mux_tmp_73, or_88_cse);
  assign nor_485_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_74));
  assign mux_77_nl = MUX_s_1_2_2(nor_485_nl, mux_tmp_74, or_83_cse);
  assign and_dcpl_388 = mux_77_nl & and_dcpl_4 & and_dcpl_6;
  assign nand_250_cse = ~((acc_1_tmp[0]) & ccs_ccore_start_rsci_idat);
  assign and_tmp_44 = ((~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b01)
      | (rem_12cyc_st_7_3_2!=2'b00)) & ((~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b01)
      | (rem_12cyc_st_8_3_2!=2'b00)) & ((~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b01)
      | (rem_12cyc_st_9_3_2!=2'b00)) & ((~ main_stage_0_3) | (~ asn_itm_2) | (rem_12cyc_st_2_1_0!=2'b01)
      | (rem_12cyc_st_2_3_2!=2'b00)) & ((~ main_stage_0_4) | (~ asn_itm_3) | (rem_12cyc_st_3_1_0!=2'b01)
      | (rem_12cyc_st_3_3_2!=2'b00)) & ((~ main_stage_0_5) | (~ asn_itm_4) | (rem_12cyc_st_4_1_0!=2'b01)
      | (rem_12cyc_st_4_3_2!=2'b00)) & ((~ main_stage_0_6) | (~ asn_itm_5) | (rem_12cyc_st_5_1_0!=2'b01)
      | (rem_12cyc_st_5_3_2!=2'b00)) & ((~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b01)
      | (rem_12cyc_st_6_3_2!=2'b00)) & ((~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b01)
      | (rem_12cyc_st_10_3_2!=2'b00)) & ((acc_tmp!=2'b00) | (acc_1_tmp[1]) | nand_250_cse);
  assign nor_480_nl = ~((rem_12cyc_1_0[0]) | (~ and_tmp_44));
  assign or_175_nl = (~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b00)
      | (rem_12cyc_1_0[1]);
  assign mux_tmp_76 = MUX_s_1_2_2(nor_480_nl, and_tmp_44, or_175_nl);
  assign and_dcpl_393 = (acc_1_tmp[1:0]==2'b10);
  assign and_dcpl_394 = and_dcpl_293 & and_dcpl_393;
  assign and_dcpl_395 = and_dcpl_295 & (rem_12cyc_st_2_1_0[1]);
  assign or_tmp_185 = (rem_12cyc_1_0!=2'b10) | (rem_12cyc_3_2!=2'b00) | not_tmp_54;
  assign or_190_cse = (acc_1_tmp[1:0]!=2'b10) | (acc_tmp!=2'b00);
  assign nor_479_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_185));
  assign mux_79_nl = MUX_s_1_2_2(nor_479_nl, or_tmp_185, or_190_cse);
  assign and_dcpl_397 = mux_79_nl & and_dcpl_298 & and_dcpl_395;
  assign and_dcpl_398 = and_dcpl_301 & (rem_12cyc_st_3_1_0[1]);
  assign or_195_cse = (~ (rem_12cyc_st_2_1_0[1])) | (rem_12cyc_st_2_3_2!=2'b00) |
      (~ asn_itm_2) | (~ main_stage_0_3) | (rem_12cyc_st_2_1_0[0]);
  assign and_tmp_45 = or_195_cse & or_tmp_185;
  assign nor_478_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_45));
  assign mux_80_nl = MUX_s_1_2_2(nor_478_nl, and_tmp_45, or_190_cse);
  assign and_dcpl_400 = mux_80_nl & and_dcpl_304 & and_dcpl_398;
  assign and_dcpl_401 = and_dcpl_307 & (rem_12cyc_st_4_1_0[1]);
  assign or_199_cse = (~ (rem_12cyc_st_3_1_0[1])) | (rem_12cyc_st_3_3_2!=2'b00) |
      (~ asn_itm_3) | (~ main_stage_0_4) | (rem_12cyc_st_3_1_0[0]);
  assign and_tmp_47 = or_195_cse & or_199_cse & or_tmp_185;
  assign nor_477_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_47));
  assign mux_81_nl = MUX_s_1_2_2(nor_477_nl, and_tmp_47, or_190_cse);
  assign and_dcpl_403 = mux_81_nl & and_dcpl_310 & and_dcpl_401;
  assign and_dcpl_404 = and_dcpl_313 & (rem_12cyc_st_5_1_0[1]);
  assign or_204_cse = (~ (rem_12cyc_st_4_1_0[1])) | (rem_12cyc_st_4_3_2!=2'b00) |
      (~ asn_itm_4) | (~ main_stage_0_5) | (rem_12cyc_st_4_1_0[0]);
  assign and_tmp_50 = or_195_cse & or_199_cse & or_204_cse & or_tmp_185;
  assign nor_476_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_50));
  assign mux_82_nl = MUX_s_1_2_2(nor_476_nl, and_tmp_50, or_190_cse);
  assign and_dcpl_406 = mux_82_nl & and_dcpl_316 & and_dcpl_404;
  assign or_210_cse = (~ (rem_12cyc_st_5_1_0[1])) | (rem_12cyc_st_5_3_2!=2'b00) |
      (~ asn_itm_5) | (~ main_stage_0_6) | (rem_12cyc_st_5_1_0[0]);
  assign and_tmp_54 = or_195_cse & or_199_cse & or_204_cse & or_210_cse & or_tmp_185;
  assign nor_475_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_54));
  assign mux_83_nl = MUX_s_1_2_2(nor_475_nl, and_tmp_54, or_190_cse);
  assign and_dcpl_409 = mux_83_nl & and_dcpl_112 & and_dcpl_117;
  assign or_217_cse = (rem_12cyc_st_6_1_0!=2'b10) | (rem_12cyc_st_6_3_2!=2'b00);
  assign nor_473_nl = ~(and_dcpl_111 | (~ or_tmp_185));
  assign mux_84_nl = MUX_s_1_2_2(nor_473_nl, or_tmp_185, or_217_cse);
  assign and_tmp_58 = or_195_cse & or_199_cse & or_204_cse & or_210_cse & mux_84_nl;
  assign nor_474_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_58));
  assign mux_85_nl = MUX_s_1_2_2(nor_474_nl, and_tmp_58, or_190_cse);
  assign and_dcpl_413 = mux_85_nl & and_dcpl_85 & and_dcpl_90;
  assign or_226_cse = (rem_12cyc_st_7_1_0!=2'b10) | (rem_12cyc_st_7_3_2!=2'b00);
  assign nor_470_nl = ~(and_dcpl_84 | (~ or_tmp_185));
  assign mux_tmp_84 = MUX_s_1_2_2(nor_470_nl, or_tmp_185, or_226_cse);
  assign nor_471_nl = ~(and_dcpl_111 | (~ mux_tmp_84));
  assign mux_87_nl = MUX_s_1_2_2(nor_471_nl, mux_tmp_84, or_217_cse);
  assign and_tmp_62 = or_195_cse & or_199_cse & or_204_cse & or_210_cse & mux_87_nl;
  assign nor_472_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_62));
  assign mux_88_nl = MUX_s_1_2_2(nor_472_nl, and_tmp_62, or_190_cse);
  assign and_dcpl_417 = mux_88_nl & and_dcpl_58 & and_dcpl_63;
  assign or_237_cse = (rem_12cyc_st_8_1_0!=2'b10) | (rem_12cyc_st_8_3_2!=2'b00);
  assign nor_466_nl = ~(and_dcpl_57 | (~ or_tmp_185));
  assign mux_tmp_87 = MUX_s_1_2_2(nor_466_nl, or_tmp_185, or_237_cse);
  assign nor_467_nl = ~(and_dcpl_84 | (~ mux_tmp_87));
  assign mux_tmp_88 = MUX_s_1_2_2(nor_467_nl, mux_tmp_87, or_226_cse);
  assign nor_468_nl = ~(and_dcpl_111 | (~ mux_tmp_88));
  assign mux_91_nl = MUX_s_1_2_2(nor_468_nl, mux_tmp_88, or_217_cse);
  assign and_tmp_66 = or_195_cse & or_199_cse & or_204_cse & or_210_cse & mux_91_nl;
  assign nor_469_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_66));
  assign mux_92_nl = MUX_s_1_2_2(nor_469_nl, and_tmp_66, or_190_cse);
  assign and_dcpl_421 = mux_92_nl & and_dcpl_31 & and_dcpl_36;
  assign nor_461_nl = ~(and_dcpl_30 | (~ or_tmp_185));
  assign or_250_nl = (rem_12cyc_st_9_1_0!=2'b10) | (rem_12cyc_st_9_3_2!=2'b00);
  assign mux_tmp_91 = MUX_s_1_2_2(nor_461_nl, or_tmp_185, or_250_nl);
  assign nor_462_nl = ~(and_dcpl_57 | (~ mux_tmp_91));
  assign mux_tmp_92 = MUX_s_1_2_2(nor_462_nl, mux_tmp_91, or_237_cse);
  assign nor_463_nl = ~(and_dcpl_84 | (~ mux_tmp_92));
  assign mux_tmp_93 = MUX_s_1_2_2(nor_463_nl, mux_tmp_92, or_226_cse);
  assign nor_464_nl = ~(and_dcpl_111 | (~ mux_tmp_93));
  assign mux_96_nl = MUX_s_1_2_2(nor_464_nl, mux_tmp_93, or_217_cse);
  assign and_tmp_70 = or_195_cse & or_199_cse & or_204_cse & or_210_cse & mux_96_nl;
  assign nor_465_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_70));
  assign mux_97_nl = MUX_s_1_2_2(nor_465_nl, and_tmp_70, or_190_cse);
  assign and_dcpl_425 = mux_97_nl & and_dcpl_4 & and_dcpl_9;
  assign and_tmp_80 = ((~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b00)
      | (rem_12cyc_1_0!=2'b10)) & ((~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b10)
      | (rem_12cyc_st_7_3_2!=2'b00)) & ((~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b10)
      | (rem_12cyc_st_8_3_2!=2'b00)) & ((~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b10)
      | (rem_12cyc_st_9_3_2!=2'b00)) & or_195_cse & or_199_cse & or_204_cse & or_210_cse
      & ((~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b10) | (rem_12cyc_st_6_3_2!=2'b00))
      & ((~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b10) | (rem_12cyc_st_10_3_2!=2'b00))
      & ((acc_tmp!=2'b00) | (acc_1_tmp[1:0]!=2'b10) | (~ ccs_ccore_start_rsci_idat));
  assign and_dcpl_430 = (acc_1_tmp[1:0]==2'b11);
  assign and_dcpl_431 = and_dcpl_293 & and_dcpl_430;
  assign or_tmp_263 = (rem_12cyc_1_0!=2'b11) | (rem_12cyc_3_2!=2'b00) | not_tmp_54;
  assign or_270_cse = (acc_1_tmp[1:0]!=2'b11) | (acc_tmp!=2'b00);
  assign nor_460_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_263));
  assign mux_98_nl = MUX_s_1_2_2(nor_460_nl, or_tmp_263, or_270_cse);
  assign and_dcpl_433 = mux_98_nl & and_dcpl_358 & and_dcpl_395;
  assign or_275_cse = (~ (rem_12cyc_st_2_1_0[1])) | (rem_12cyc_st_2_3_2!=2'b00);
  assign and_1142_nl = nand_276_cse & or_tmp_263;
  assign mux_tmp_97 = MUX_s_1_2_2(and_1142_nl, or_tmp_263, or_275_cse);
  assign nor_459_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_97));
  assign mux_100_nl = MUX_s_1_2_2(nor_459_nl, mux_tmp_97, or_270_cse);
  assign and_dcpl_435 = mux_100_nl & and_dcpl_362 & and_dcpl_398;
  assign or_280_cse = (~ (rem_12cyc_st_3_1_0[1])) | (rem_12cyc_st_3_3_2!=2'b00);
  assign and_1140_nl = nand_274_cse & or_tmp_263;
  assign mux_tmp_99 = MUX_s_1_2_2(and_1140_nl, or_tmp_263, or_280_cse);
  assign and_1141_nl = nand_276_cse & mux_tmp_99;
  assign mux_tmp_100 = MUX_s_1_2_2(and_1141_nl, mux_tmp_99, or_275_cse);
  assign nor_458_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_100));
  assign mux_103_nl = MUX_s_1_2_2(nor_458_nl, mux_tmp_100, or_270_cse);
  assign and_dcpl_437 = mux_103_nl & and_dcpl_366 & and_dcpl_401;
  assign or_287_cse = (~ (rem_12cyc_st_4_1_0[1])) | (rem_12cyc_st_4_3_2!=2'b00);
  assign and_1137_nl = nand_271_cse & or_tmp_263;
  assign mux_tmp_102 = MUX_s_1_2_2(and_1137_nl, or_tmp_263, or_287_cse);
  assign and_1138_nl = nand_274_cse & mux_tmp_102;
  assign mux_tmp_103 = MUX_s_1_2_2(and_1138_nl, mux_tmp_102, or_280_cse);
  assign and_1139_nl = nand_276_cse & mux_tmp_103;
  assign mux_tmp_104 = MUX_s_1_2_2(and_1139_nl, mux_tmp_103, or_275_cse);
  assign nor_457_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_104));
  assign mux_107_nl = MUX_s_1_2_2(nor_457_nl, mux_tmp_104, or_270_cse);
  assign and_dcpl_439 = mux_107_nl & and_dcpl_370 & and_dcpl_404;
  assign or_296_cse = (~ (rem_12cyc_st_5_1_0[1])) | (rem_12cyc_st_5_3_2!=2'b00);
  assign and_1133_nl = nand_267_cse & or_tmp_263;
  assign mux_tmp_106 = MUX_s_1_2_2(and_1133_nl, or_tmp_263, or_296_cse);
  assign and_1134_nl = nand_271_cse & mux_tmp_106;
  assign mux_tmp_107 = MUX_s_1_2_2(and_1134_nl, mux_tmp_106, or_287_cse);
  assign and_1135_nl = nand_274_cse & mux_tmp_107;
  assign mux_tmp_108 = MUX_s_1_2_2(and_1135_nl, mux_tmp_107, or_280_cse);
  assign and_1136_nl = nand_276_cse & mux_tmp_108;
  assign mux_tmp_109 = MUX_s_1_2_2(and_1136_nl, mux_tmp_108, or_275_cse);
  assign nor_456_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_109));
  assign mux_112_nl = MUX_s_1_2_2(nor_456_nl, mux_tmp_109, or_270_cse);
  assign and_dcpl_442 = mux_112_nl & and_dcpl_112 & and_dcpl_119;
  assign or_307_cse = (rem_12cyc_st_6_1_0!=2'b11) | (rem_12cyc_st_6_3_2!=2'b00);
  assign nor_454_nl = ~(and_dcpl_111 | (~ or_tmp_263));
  assign mux_tmp_111 = MUX_s_1_2_2(nor_454_nl, or_tmp_263, or_307_cse);
  assign and_1129_nl = nand_267_cse & mux_tmp_111;
  assign mux_tmp_112 = MUX_s_1_2_2(and_1129_nl, mux_tmp_111, or_296_cse);
  assign and_1130_nl = nand_271_cse & mux_tmp_112;
  assign mux_tmp_113 = MUX_s_1_2_2(and_1130_nl, mux_tmp_112, or_287_cse);
  assign and_1131_nl = nand_274_cse & mux_tmp_113;
  assign mux_tmp_114 = MUX_s_1_2_2(and_1131_nl, mux_tmp_113, or_280_cse);
  assign and_1132_nl = nand_276_cse & mux_tmp_114;
  assign mux_tmp_115 = MUX_s_1_2_2(and_1132_nl, mux_tmp_114, or_275_cse);
  assign nor_455_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_115));
  assign mux_118_nl = MUX_s_1_2_2(nor_455_nl, mux_tmp_115, or_270_cse);
  assign and_dcpl_445 = mux_118_nl & and_dcpl_85 & and_dcpl_92;
  assign or_320_cse = (rem_12cyc_st_7_1_0!=2'b11) | (rem_12cyc_st_7_3_2!=2'b00);
  assign nor_451_nl = ~(and_dcpl_84 | (~ or_tmp_263));
  assign mux_tmp_117 = MUX_s_1_2_2(nor_451_nl, or_tmp_263, or_320_cse);
  assign nor_452_nl = ~(and_dcpl_111 | (~ mux_tmp_117));
  assign mux_tmp_118 = MUX_s_1_2_2(nor_452_nl, mux_tmp_117, or_307_cse);
  assign and_1125_nl = nand_267_cse & mux_tmp_118;
  assign mux_tmp_119 = MUX_s_1_2_2(and_1125_nl, mux_tmp_118, or_296_cse);
  assign and_1126_nl = nand_271_cse & mux_tmp_119;
  assign mux_tmp_120 = MUX_s_1_2_2(and_1126_nl, mux_tmp_119, or_287_cse);
  assign and_1127_nl = nand_274_cse & mux_tmp_120;
  assign mux_tmp_121 = MUX_s_1_2_2(and_1127_nl, mux_tmp_120, or_280_cse);
  assign and_1128_nl = nand_276_cse & mux_tmp_121;
  assign mux_tmp_122 = MUX_s_1_2_2(and_1128_nl, mux_tmp_121, or_275_cse);
  assign nor_453_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_122));
  assign mux_125_nl = MUX_s_1_2_2(nor_453_nl, mux_tmp_122, or_270_cse);
  assign and_dcpl_448 = mux_125_nl & and_dcpl_58 & and_dcpl_65;
  assign or_335_cse = (rem_12cyc_st_8_1_0!=2'b11) | (rem_12cyc_st_8_3_2!=2'b00);
  assign nor_447_nl = ~(and_dcpl_57 | (~ or_tmp_263));
  assign mux_tmp_124 = MUX_s_1_2_2(nor_447_nl, or_tmp_263, or_335_cse);
  assign nor_448_nl = ~(and_dcpl_84 | (~ mux_tmp_124));
  assign mux_tmp_125 = MUX_s_1_2_2(nor_448_nl, mux_tmp_124, or_320_cse);
  assign nor_449_nl = ~(and_dcpl_111 | (~ mux_tmp_125));
  assign mux_tmp_126 = MUX_s_1_2_2(nor_449_nl, mux_tmp_125, or_307_cse);
  assign and_1121_nl = nand_267_cse & mux_tmp_126;
  assign mux_tmp_127 = MUX_s_1_2_2(and_1121_nl, mux_tmp_126, or_296_cse);
  assign and_1122_nl = nand_271_cse & mux_tmp_127;
  assign mux_tmp_128 = MUX_s_1_2_2(and_1122_nl, mux_tmp_127, or_287_cse);
  assign and_1123_nl = nand_274_cse & mux_tmp_128;
  assign mux_tmp_129 = MUX_s_1_2_2(and_1123_nl, mux_tmp_128, or_280_cse);
  assign and_1124_nl = nand_276_cse & mux_tmp_129;
  assign mux_tmp_130 = MUX_s_1_2_2(and_1124_nl, mux_tmp_129, or_275_cse);
  assign nor_450_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_130));
  assign mux_133_nl = MUX_s_1_2_2(nor_450_nl, mux_tmp_130, or_270_cse);
  assign and_dcpl_451 = mux_133_nl & and_dcpl_31 & and_dcpl_38;
  assign nor_442_nl = ~(and_dcpl_30 | (~ or_tmp_263));
  assign or_352_nl = (rem_12cyc_st_9_1_0!=2'b11) | (rem_12cyc_st_9_3_2!=2'b00);
  assign mux_tmp_132 = MUX_s_1_2_2(nor_442_nl, or_tmp_263, or_352_nl);
  assign nor_443_nl = ~(and_dcpl_57 | (~ mux_tmp_132));
  assign mux_tmp_133 = MUX_s_1_2_2(nor_443_nl, mux_tmp_132, or_335_cse);
  assign nor_444_nl = ~(and_dcpl_84 | (~ mux_tmp_133));
  assign mux_tmp_134 = MUX_s_1_2_2(nor_444_nl, mux_tmp_133, or_320_cse);
  assign nor_445_nl = ~(and_dcpl_111 | (~ mux_tmp_134));
  assign mux_tmp_135 = MUX_s_1_2_2(nor_445_nl, mux_tmp_134, or_307_cse);
  assign and_1117_nl = nand_267_cse & mux_tmp_135;
  assign mux_tmp_136 = MUX_s_1_2_2(and_1117_nl, mux_tmp_135, or_296_cse);
  assign and_1118_nl = nand_271_cse & mux_tmp_136;
  assign mux_tmp_137 = MUX_s_1_2_2(and_1118_nl, mux_tmp_136, or_287_cse);
  assign and_1119_nl = nand_274_cse & mux_tmp_137;
  assign mux_tmp_138 = MUX_s_1_2_2(and_1119_nl, mux_tmp_137, or_280_cse);
  assign and_1120_nl = nand_276_cse & mux_tmp_138;
  assign mux_tmp_139 = MUX_s_1_2_2(and_1120_nl, mux_tmp_138, or_275_cse);
  assign nor_446_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_139));
  assign mux_142_nl = MUX_s_1_2_2(nor_446_nl, mux_tmp_139, or_270_cse);
  assign and_dcpl_454 = mux_142_nl & and_dcpl_4 & and_dcpl_11;
  assign nand_222_cse = ~((acc_1_tmp[1:0]==2'b11) & ccs_ccore_start_rsci_idat);
  assign and_tmp_89 = ((~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b11)
      | (rem_12cyc_st_7_3_2!=2'b00)) & ((~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b11)
      | (rem_12cyc_st_8_3_2!=2'b00)) & ((~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b11)
      | (rem_12cyc_st_9_3_2!=2'b00)) & ((~ main_stage_0_3) | (~ asn_itm_2) | (rem_12cyc_st_2_1_0!=2'b11)
      | (rem_12cyc_st_2_3_2!=2'b00)) & ((~ main_stage_0_4) | (~ asn_itm_3) | (rem_12cyc_st_3_1_0!=2'b11)
      | (rem_12cyc_st_3_3_2!=2'b00)) & ((~ main_stage_0_5) | (~ asn_itm_4) | (rem_12cyc_st_4_1_0!=2'b11)
      | (rem_12cyc_st_4_3_2!=2'b00)) & ((~ main_stage_0_6) | (~ asn_itm_5) | (rem_12cyc_st_5_1_0!=2'b11)
      | (rem_12cyc_st_5_3_2!=2'b00)) & ((~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b11)
      | (rem_12cyc_st_6_3_2!=2'b00)) & ((~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b11)
      | (rem_12cyc_st_10_3_2!=2'b00)) & ((acc_tmp!=2'b00) | nand_222_cse);
  assign nand_223_cse = ~((rem_12cyc_1_0==2'b11));
  assign and_1116_nl = nand_223_cse & and_tmp_89;
  assign or_362_nl = (~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b00);
  assign mux_tmp_141 = MUX_s_1_2_2(and_1116_nl, and_tmp_89, or_362_nl);
  assign and_dcpl_460 = ccs_ccore_start_rsci_idat & (acc_tmp==2'b01);
  assign and_dcpl_461 = and_dcpl_460 & and_dcpl_291;
  assign and_dcpl_462 = (rem_12cyc_st_2_3_2==2'b01);
  assign and_dcpl_463 = and_dcpl_462 & (~ (rem_12cyc_st_2_1_0[1]));
  assign not_tmp_332 = ~((rem_12cyc_3_2[0]) & asn_itm_1 & main_stage_0_2);
  assign or_tmp_368 = (rem_12cyc_1_0!=2'b00) | (rem_12cyc_3_2[1]) | not_tmp_332;
  assign nand_281_cse = ~((acc_tmp[0]) & ccs_ccore_start_rsci_idat);
  assign or_377_cse = (acc_1_tmp[1:0]!=2'b00) | (acc_tmp[1]);
  assign and_1172_nl = nand_281_cse & or_tmp_368;
  assign mux_144_nl = MUX_s_1_2_2(and_1172_nl, or_tmp_368, or_377_cse);
  assign and_dcpl_465 = mux_144_nl & and_dcpl_298 & and_dcpl_463;
  assign and_dcpl_466 = (rem_12cyc_st_3_3_2==2'b01);
  assign and_dcpl_467 = and_dcpl_466 & (~ (rem_12cyc_st_3_1_0[1]));
  assign or_382_cse = (rem_12cyc_st_2_1_0[1]) | (rem_12cyc_st_2_3_2!=2'b01) | (~
      asn_itm_2) | (~ main_stage_0_3) | (rem_12cyc_st_2_1_0[0]);
  assign and_tmp_90 = or_382_cse & or_tmp_368;
  assign and_1114_nl = nand_281_cse & and_tmp_90;
  assign mux_145_nl = MUX_s_1_2_2(and_1114_nl, and_tmp_90, or_377_cse);
  assign and_dcpl_469 = mux_145_nl & and_dcpl_304 & and_dcpl_467;
  assign and_dcpl_470 = (rem_12cyc_st_4_3_2==2'b01);
  assign and_dcpl_471 = and_dcpl_470 & (~ (rem_12cyc_st_4_1_0[1]));
  assign or_386_cse = (rem_12cyc_st_3_1_0[1]) | (rem_12cyc_st_3_3_2!=2'b01) | (~
      asn_itm_3) | (~ main_stage_0_4) | (rem_12cyc_st_3_1_0[0]);
  assign and_tmp_92 = or_382_cse & or_386_cse & or_tmp_368;
  assign and_1113_nl = nand_281_cse & and_tmp_92;
  assign mux_146_nl = MUX_s_1_2_2(and_1113_nl, and_tmp_92, or_377_cse);
  assign and_dcpl_473 = mux_146_nl & and_dcpl_310 & and_dcpl_471;
  assign and_dcpl_474 = (rem_12cyc_st_5_3_2==2'b01);
  assign and_dcpl_475 = and_dcpl_474 & (~ (rem_12cyc_st_5_1_0[1]));
  assign or_391_cse = (rem_12cyc_st_4_1_0[1]) | (rem_12cyc_st_4_3_2!=2'b01) | (~
      asn_itm_4) | (~ main_stage_0_5) | (rem_12cyc_st_4_1_0[0]);
  assign and_tmp_95 = or_382_cse & or_386_cse & or_391_cse & or_tmp_368;
  assign and_1112_nl = nand_281_cse & and_tmp_95;
  assign mux_147_nl = MUX_s_1_2_2(and_1112_nl, and_tmp_95, or_377_cse);
  assign and_dcpl_477 = mux_147_nl & and_dcpl_316 & and_dcpl_475;
  assign or_397_cse = (rem_12cyc_st_5_1_0[1]) | (rem_12cyc_st_5_3_2!=2'b01) | (~
      asn_itm_5) | (~ main_stage_0_6) | (rem_12cyc_st_5_1_0[0]);
  assign and_tmp_99 = or_382_cse & or_386_cse & or_391_cse & or_397_cse & or_tmp_368;
  assign and_1111_nl = nand_281_cse & and_tmp_99;
  assign mux_148_nl = MUX_s_1_2_2(and_1111_nl, and_tmp_99, or_377_cse);
  assign and_dcpl_480 = mux_148_nl & and_dcpl_121 & and_dcpl_110;
  assign nand_215_cse = ~((rem_12cyc_st_6_3_2[0]) & asn_itm_6 & main_stage_0_7);
  assign or_404_cse = (rem_12cyc_st_6_1_0!=2'b00) | (rem_12cyc_st_6_3_2[1]);
  assign and_1109_nl = nand_215_cse & or_tmp_368;
  assign mux_149_nl = MUX_s_1_2_2(and_1109_nl, or_tmp_368, or_404_cse);
  assign and_tmp_103 = or_382_cse & or_386_cse & or_391_cse & or_397_cse & mux_149_nl;
  assign and_1110_nl = nand_281_cse & and_tmp_103;
  assign mux_150_nl = MUX_s_1_2_2(and_1110_nl, and_tmp_103, or_377_cse);
  assign and_dcpl_483 = mux_150_nl & and_dcpl_94 & and_dcpl_83;
  assign nand_212_cse = ~((rem_12cyc_st_7_3_2[0]) & asn_itm_7 & main_stage_0_8);
  assign or_413_cse = (rem_12cyc_st_7_1_0!=2'b00) | (rem_12cyc_st_7_3_2[1]);
  assign and_1106_nl = nand_212_cse & or_tmp_368;
  assign mux_tmp_149 = MUX_s_1_2_2(and_1106_nl, or_tmp_368, or_413_cse);
  assign and_1107_nl = nand_215_cse & mux_tmp_149;
  assign mux_152_nl = MUX_s_1_2_2(and_1107_nl, mux_tmp_149, or_404_cse);
  assign and_tmp_107 = or_382_cse & or_386_cse & or_391_cse & or_397_cse & mux_152_nl;
  assign and_1108_nl = nand_281_cse & and_tmp_107;
  assign mux_153_nl = MUX_s_1_2_2(and_1108_nl, and_tmp_107, or_377_cse);
  assign and_dcpl_486 = mux_153_nl & and_dcpl_67 & and_dcpl_56;
  assign nand_208_cse = ~((rem_12cyc_st_8_3_2[0]) & asn_itm_8 & main_stage_0_9);
  assign or_424_cse = (rem_12cyc_st_8_1_0!=2'b00) | (rem_12cyc_st_8_3_2[1]);
  assign and_1102_nl = nand_208_cse & or_tmp_368;
  assign mux_tmp_152 = MUX_s_1_2_2(and_1102_nl, or_tmp_368, or_424_cse);
  assign and_1103_nl = nand_212_cse & mux_tmp_152;
  assign mux_tmp_153 = MUX_s_1_2_2(and_1103_nl, mux_tmp_152, or_413_cse);
  assign and_1104_nl = nand_215_cse & mux_tmp_153;
  assign mux_156_nl = MUX_s_1_2_2(and_1104_nl, mux_tmp_153, or_404_cse);
  assign and_tmp_111 = or_382_cse & or_386_cse & or_391_cse & or_397_cse & mux_156_nl;
  assign and_1105_nl = nand_281_cse & and_tmp_111;
  assign mux_157_nl = MUX_s_1_2_2(and_1105_nl, and_tmp_111, or_377_cse);
  assign and_dcpl_489 = mux_157_nl & and_dcpl_40 & and_dcpl_29;
  assign nand_203_cse = ~((rem_12cyc_st_9_3_2[0]) & asn_itm_9 & main_stage_0_10);
  assign and_1097_nl = nand_203_cse & or_tmp_368;
  assign or_437_nl = (rem_12cyc_st_9_1_0!=2'b00) | (rem_12cyc_st_9_3_2[1]);
  assign mux_tmp_156 = MUX_s_1_2_2(and_1097_nl, or_tmp_368, or_437_nl);
  assign and_1098_nl = nand_208_cse & mux_tmp_156;
  assign mux_tmp_157 = MUX_s_1_2_2(and_1098_nl, mux_tmp_156, or_424_cse);
  assign and_1099_nl = nand_212_cse & mux_tmp_157;
  assign mux_tmp_158 = MUX_s_1_2_2(and_1099_nl, mux_tmp_157, or_413_cse);
  assign and_1100_nl = nand_215_cse & mux_tmp_158;
  assign mux_161_nl = MUX_s_1_2_2(and_1100_nl, mux_tmp_158, or_404_cse);
  assign and_tmp_115 = or_382_cse & or_386_cse & or_391_cse & or_397_cse & mux_161_nl;
  assign and_1101_nl = nand_281_cse & and_tmp_115;
  assign mux_162_nl = MUX_s_1_2_2(and_1101_nl, and_tmp_115, or_377_cse);
  assign and_dcpl_492 = mux_162_nl & and_dcpl_13 & and_dcpl_2;
  assign and_tmp_125 = ((~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b01)
      | (rem_12cyc_1_0!=2'b00)) & ((~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b00)
      | (rem_12cyc_st_7_3_2!=2'b01)) & ((~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b00)
      | (rem_12cyc_st_8_3_2!=2'b01)) & ((~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b00)
      | (rem_12cyc_st_9_3_2!=2'b01)) & or_382_cse & or_386_cse & or_391_cse & or_397_cse
      & ((~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b00) | (rem_12cyc_st_6_3_2!=2'b01))
      & ((~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b00) | (rem_12cyc_st_10_3_2!=2'b01))
      & ((acc_tmp!=2'b01) | (acc_1_tmp[1:0]!=2'b00) | (~ ccs_ccore_start_rsci_idat));
  assign and_dcpl_498 = and_dcpl_460 & and_dcpl_355;
  assign or_tmp_446 = (rem_12cyc_1_0!=2'b01) | (rem_12cyc_3_2[1]) | not_tmp_332;
  assign or_458_cse = (acc_1_tmp[1:0]!=2'b01) | (acc_tmp[1]);
  assign and_1171_nl = nand_281_cse & or_tmp_446;
  assign mux_163_nl = MUX_s_1_2_2(and_1171_nl, or_tmp_446, or_458_cse);
  assign and_dcpl_500 = mux_163_nl & and_dcpl_358 & and_dcpl_463;
  assign or_463_cse = (rem_12cyc_st_2_1_0[1]) | (rem_12cyc_st_2_3_2!=2'b01);
  assign and_1094_nl = nand_276_cse & or_tmp_446;
  assign mux_tmp_162 = MUX_s_1_2_2(and_1094_nl, or_tmp_446, or_463_cse);
  assign and_1095_nl = nand_281_cse & mux_tmp_162;
  assign mux_165_nl = MUX_s_1_2_2(and_1095_nl, mux_tmp_162, or_458_cse);
  assign and_dcpl_502 = mux_165_nl & and_dcpl_362 & and_dcpl_467;
  assign nand_198_cse = ~((rem_12cyc_st_3_3_2[0]) & asn_itm_3 & main_stage_0_4 &
      (rem_12cyc_st_3_1_0[0]));
  assign or_468_cse = (rem_12cyc_st_3_1_0[1]) | (rem_12cyc_st_3_3_2[1]);
  assign and_1091_nl = nand_198_cse & or_tmp_446;
  assign mux_tmp_164 = MUX_s_1_2_2(and_1091_nl, or_tmp_446, or_468_cse);
  assign and_1092_nl = nand_276_cse & mux_tmp_164;
  assign mux_tmp_165 = MUX_s_1_2_2(and_1092_nl, mux_tmp_164, or_463_cse);
  assign and_1093_nl = nand_281_cse & mux_tmp_165;
  assign mux_168_nl = MUX_s_1_2_2(and_1093_nl, mux_tmp_165, or_458_cse);
  assign and_dcpl_504 = mux_168_nl & and_dcpl_366 & and_dcpl_471;
  assign or_475_cse = (rem_12cyc_st_4_1_0[1]) | (rem_12cyc_st_4_3_2!=2'b01);
  assign and_1087_nl = nand_271_cse & or_tmp_446;
  assign mux_tmp_167 = MUX_s_1_2_2(and_1087_nl, or_tmp_446, or_475_cse);
  assign and_1088_nl = nand_198_cse & mux_tmp_167;
  assign mux_tmp_168 = MUX_s_1_2_2(and_1088_nl, mux_tmp_167, or_468_cse);
  assign and_1089_nl = nand_276_cse & mux_tmp_168;
  assign mux_tmp_169 = MUX_s_1_2_2(and_1089_nl, mux_tmp_168, or_463_cse);
  assign and_1090_nl = nand_281_cse & mux_tmp_169;
  assign mux_172_nl = MUX_s_1_2_2(and_1090_nl, mux_tmp_169, or_458_cse);
  assign and_dcpl_506 = mux_172_nl & and_dcpl_370 & and_dcpl_475;
  assign nand_189_cse = ~((rem_12cyc_st_5_3_2[0]) & asn_itm_5 & main_stage_0_6 &
      (rem_12cyc_st_5_1_0[0]));
  assign or_484_cse = (rem_12cyc_st_5_1_0[1]) | (rem_12cyc_st_5_3_2[1]);
  assign and_1082_nl = nand_189_cse & or_tmp_446;
  assign mux_tmp_171 = MUX_s_1_2_2(and_1082_nl, or_tmp_446, or_484_cse);
  assign and_1083_nl = nand_271_cse & mux_tmp_171;
  assign mux_tmp_172 = MUX_s_1_2_2(and_1083_nl, mux_tmp_171, or_475_cse);
  assign and_1084_nl = nand_198_cse & mux_tmp_172;
  assign mux_tmp_173 = MUX_s_1_2_2(and_1084_nl, mux_tmp_172, or_468_cse);
  assign and_1085_nl = nand_276_cse & mux_tmp_173;
  assign mux_tmp_174 = MUX_s_1_2_2(and_1085_nl, mux_tmp_173, or_463_cse);
  assign and_1086_nl = nand_281_cse & mux_tmp_174;
  assign mux_177_nl = MUX_s_1_2_2(and_1086_nl, mux_tmp_174, or_458_cse);
  assign and_dcpl_508 = mux_177_nl & and_dcpl_121 & and_dcpl_115;
  assign or_495_cse = (rem_12cyc_st_6_1_0!=2'b01) | (rem_12cyc_st_6_3_2[1]);
  assign and_1076_nl = nand_215_cse & or_tmp_446;
  assign mux_tmp_176 = MUX_s_1_2_2(and_1076_nl, or_tmp_446, or_495_cse);
  assign and_1077_nl = nand_189_cse & mux_tmp_176;
  assign mux_tmp_177 = MUX_s_1_2_2(and_1077_nl, mux_tmp_176, or_484_cse);
  assign and_1078_nl = nand_271_cse & mux_tmp_177;
  assign mux_tmp_178 = MUX_s_1_2_2(and_1078_nl, mux_tmp_177, or_475_cse);
  assign and_1079_nl = nand_198_cse & mux_tmp_178;
  assign mux_tmp_179 = MUX_s_1_2_2(and_1079_nl, mux_tmp_178, or_468_cse);
  assign and_1080_nl = nand_276_cse & mux_tmp_179;
  assign mux_tmp_180 = MUX_s_1_2_2(and_1080_nl, mux_tmp_179, or_463_cse);
  assign and_1081_nl = nand_281_cse & mux_tmp_180;
  assign mux_183_nl = MUX_s_1_2_2(and_1081_nl, mux_tmp_180, or_458_cse);
  assign and_dcpl_510 = mux_183_nl & and_dcpl_94 & and_dcpl_87;
  assign or_508_cse = (rem_12cyc_st_7_1_0!=2'b01) | (rem_12cyc_st_7_3_2[1]);
  assign and_1069_nl = nand_212_cse & or_tmp_446;
  assign mux_tmp_182 = MUX_s_1_2_2(and_1069_nl, or_tmp_446, or_508_cse);
  assign and_1070_nl = nand_215_cse & mux_tmp_182;
  assign mux_tmp_183 = MUX_s_1_2_2(and_1070_nl, mux_tmp_182, or_495_cse);
  assign and_1071_nl = nand_189_cse & mux_tmp_183;
  assign mux_tmp_184 = MUX_s_1_2_2(and_1071_nl, mux_tmp_183, or_484_cse);
  assign and_1072_nl = nand_271_cse & mux_tmp_184;
  assign mux_tmp_185 = MUX_s_1_2_2(and_1072_nl, mux_tmp_184, or_475_cse);
  assign and_1073_nl = nand_198_cse & mux_tmp_185;
  assign mux_tmp_186 = MUX_s_1_2_2(and_1073_nl, mux_tmp_185, or_468_cse);
  assign and_1074_nl = nand_276_cse & mux_tmp_186;
  assign mux_tmp_187 = MUX_s_1_2_2(and_1074_nl, mux_tmp_186, or_463_cse);
  assign and_1075_nl = nand_281_cse & mux_tmp_187;
  assign mux_190_nl = MUX_s_1_2_2(and_1075_nl, mux_tmp_187, or_458_cse);
  assign and_dcpl_512 = mux_190_nl & and_dcpl_67 & and_dcpl_60;
  assign or_523_cse = (rem_12cyc_st_8_1_0!=2'b01) | (rem_12cyc_st_8_3_2[1]);
  assign and_1061_nl = nand_208_cse & or_tmp_446;
  assign mux_tmp_189 = MUX_s_1_2_2(and_1061_nl, or_tmp_446, or_523_cse);
  assign and_1062_nl = nand_212_cse & mux_tmp_189;
  assign mux_tmp_190 = MUX_s_1_2_2(and_1062_nl, mux_tmp_189, or_508_cse);
  assign and_1063_nl = nand_215_cse & mux_tmp_190;
  assign mux_tmp_191 = MUX_s_1_2_2(and_1063_nl, mux_tmp_190, or_495_cse);
  assign and_1064_nl = nand_189_cse & mux_tmp_191;
  assign mux_tmp_192 = MUX_s_1_2_2(and_1064_nl, mux_tmp_191, or_484_cse);
  assign and_1065_nl = nand_271_cse & mux_tmp_192;
  assign mux_tmp_193 = MUX_s_1_2_2(and_1065_nl, mux_tmp_192, or_475_cse);
  assign and_1066_nl = nand_198_cse & mux_tmp_193;
  assign mux_tmp_194 = MUX_s_1_2_2(and_1066_nl, mux_tmp_193, or_468_cse);
  assign and_1067_nl = nand_276_cse & mux_tmp_194;
  assign mux_tmp_195 = MUX_s_1_2_2(and_1067_nl, mux_tmp_194, or_463_cse);
  assign and_1068_nl = nand_281_cse & mux_tmp_195;
  assign mux_198_nl = MUX_s_1_2_2(and_1068_nl, mux_tmp_195, or_458_cse);
  assign and_dcpl_514 = mux_198_nl & and_dcpl_40 & and_dcpl_33;
  assign and_1052_nl = nand_203_cse & or_tmp_446;
  assign or_540_nl = (rem_12cyc_st_9_1_0!=2'b01) | (rem_12cyc_st_9_3_2[1]);
  assign mux_tmp_197 = MUX_s_1_2_2(and_1052_nl, or_tmp_446, or_540_nl);
  assign and_1053_nl = nand_208_cse & mux_tmp_197;
  assign mux_tmp_198 = MUX_s_1_2_2(and_1053_nl, mux_tmp_197, or_523_cse);
  assign and_1054_nl = nand_212_cse & mux_tmp_198;
  assign mux_tmp_199 = MUX_s_1_2_2(and_1054_nl, mux_tmp_198, or_508_cse);
  assign and_1055_nl = nand_215_cse & mux_tmp_199;
  assign mux_tmp_200 = MUX_s_1_2_2(and_1055_nl, mux_tmp_199, or_495_cse);
  assign and_1056_nl = nand_189_cse & mux_tmp_200;
  assign mux_tmp_201 = MUX_s_1_2_2(and_1056_nl, mux_tmp_200, or_484_cse);
  assign and_1057_nl = nand_271_cse & mux_tmp_201;
  assign mux_tmp_202 = MUX_s_1_2_2(and_1057_nl, mux_tmp_201, or_475_cse);
  assign and_1058_nl = nand_198_cse & mux_tmp_202;
  assign mux_tmp_203 = MUX_s_1_2_2(and_1058_nl, mux_tmp_202, or_468_cse);
  assign and_1059_nl = nand_276_cse & mux_tmp_203;
  assign mux_tmp_204 = MUX_s_1_2_2(and_1059_nl, mux_tmp_203, or_463_cse);
  assign and_1060_nl = nand_281_cse & mux_tmp_204;
  assign mux_207_nl = MUX_s_1_2_2(and_1060_nl, mux_tmp_204, or_458_cse);
  assign and_dcpl_516 = mux_207_nl & and_dcpl_13 & and_dcpl_6;
  assign and_tmp_134 = ((~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b01)
      | (rem_12cyc_st_7_3_2!=2'b01)) & ((~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b01)
      | (rem_12cyc_st_8_3_2!=2'b01)) & ((~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b01)
      | (rem_12cyc_st_9_3_2!=2'b01)) & ((~ main_stage_0_3) | (~ asn_itm_2) | (rem_12cyc_st_2_1_0!=2'b01)
      | (rem_12cyc_st_2_3_2!=2'b01)) & ((~ main_stage_0_4) | (~ asn_itm_3) | (rem_12cyc_st_3_1_0!=2'b01)
      | (rem_12cyc_st_3_3_2!=2'b01)) & ((~ main_stage_0_5) | (~ asn_itm_4) | (rem_12cyc_st_4_1_0!=2'b01)
      | (rem_12cyc_st_4_3_2!=2'b01)) & ((~ main_stage_0_6) | (~ asn_itm_5) | (rem_12cyc_st_5_1_0!=2'b01)
      | (rem_12cyc_st_5_3_2!=2'b01)) & ((~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b01)
      | (rem_12cyc_st_6_3_2!=2'b01)) & ((~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b01)
      | (rem_12cyc_st_10_3_2!=2'b01)) & ((acc_tmp!=2'b01) | (acc_1_tmp[1]) | nand_250_cse);
  assign nor_439_nl = ~((rem_12cyc_1_0[0]) | (~ and_tmp_134));
  assign or_550_nl = (~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b01)
      | (rem_12cyc_1_0[1]);
  assign mux_tmp_206 = MUX_s_1_2_2(nor_439_nl, and_tmp_134, or_550_nl);
  assign and_dcpl_520 = and_dcpl_460 & and_dcpl_393;
  assign and_dcpl_521 = and_dcpl_462 & (rem_12cyc_st_2_1_0[1]);
  assign or_tmp_551 = (rem_12cyc_1_0!=2'b10) | (rem_12cyc_3_2[1]) | not_tmp_332;
  assign or_564_cse = (acc_1_tmp[1:0]!=2'b10) | (acc_tmp[1]);
  assign and_1170_nl = nand_281_cse & or_tmp_551;
  assign mux_209_nl = MUX_s_1_2_2(and_1170_nl, or_tmp_551, or_564_cse);
  assign and_dcpl_523 = mux_209_nl & and_dcpl_298 & and_dcpl_521;
  assign and_dcpl_524 = and_dcpl_466 & (rem_12cyc_st_3_1_0[1]);
  assign or_569_cse = (~ (rem_12cyc_st_2_1_0[1])) | (rem_12cyc_st_2_3_2!=2'b01) |
      (~ asn_itm_2) | (~ main_stage_0_3) | (rem_12cyc_st_2_1_0[0]);
  assign and_tmp_135 = or_569_cse & or_tmp_551;
  assign and_1050_nl = nand_281_cse & and_tmp_135;
  assign mux_210_nl = MUX_s_1_2_2(and_1050_nl, and_tmp_135, or_564_cse);
  assign and_dcpl_526 = mux_210_nl & and_dcpl_304 & and_dcpl_524;
  assign and_dcpl_527 = and_dcpl_470 & (rem_12cyc_st_4_1_0[1]);
  assign or_573_cse = (~ (rem_12cyc_st_3_1_0[1])) | (rem_12cyc_st_3_3_2!=2'b01) |
      (~ asn_itm_3) | (~ main_stage_0_4) | (rem_12cyc_st_3_1_0[0]);
  assign and_tmp_137 = or_569_cse & or_573_cse & or_tmp_551;
  assign and_1049_nl = nand_281_cse & and_tmp_137;
  assign mux_211_nl = MUX_s_1_2_2(and_1049_nl, and_tmp_137, or_564_cse);
  assign and_dcpl_529 = mux_211_nl & and_dcpl_310 & and_dcpl_527;
  assign and_dcpl_530 = and_dcpl_474 & (rem_12cyc_st_5_1_0[1]);
  assign or_578_cse = (~ (rem_12cyc_st_4_1_0[1])) | (rem_12cyc_st_4_3_2!=2'b01) |
      (~ asn_itm_4) | (~ main_stage_0_5) | (rem_12cyc_st_4_1_0[0]);
  assign and_tmp_140 = or_569_cse & or_573_cse & or_578_cse & or_tmp_551;
  assign and_1048_nl = nand_281_cse & and_tmp_140;
  assign mux_212_nl = MUX_s_1_2_2(and_1048_nl, and_tmp_140, or_564_cse);
  assign and_dcpl_532 = mux_212_nl & and_dcpl_316 & and_dcpl_530;
  assign or_584_cse = (~ (rem_12cyc_st_5_1_0[1])) | (rem_12cyc_st_5_3_2!=2'b01) |
      (~ asn_itm_5) | (~ main_stage_0_6) | (rem_12cyc_st_5_1_0[0]);
  assign and_tmp_144 = or_569_cse & or_573_cse & or_578_cse & or_584_cse & or_tmp_551;
  assign and_1047_nl = nand_281_cse & and_tmp_144;
  assign mux_213_nl = MUX_s_1_2_2(and_1047_nl, and_tmp_144, or_564_cse);
  assign and_dcpl_534 = mux_213_nl & and_dcpl_121 & and_dcpl_117;
  assign or_591_cse = (rem_12cyc_st_6_1_0!=2'b10) | (rem_12cyc_st_6_3_2[1]);
  assign and_1045_nl = nand_215_cse & or_tmp_551;
  assign mux_214_nl = MUX_s_1_2_2(and_1045_nl, or_tmp_551, or_591_cse);
  assign and_tmp_148 = or_569_cse & or_573_cse & or_578_cse & or_584_cse & mux_214_nl;
  assign and_1046_nl = nand_281_cse & and_tmp_148;
  assign mux_215_nl = MUX_s_1_2_2(and_1046_nl, and_tmp_148, or_564_cse);
  assign and_dcpl_536 = mux_215_nl & and_dcpl_94 & and_dcpl_90;
  assign or_600_cse = (rem_12cyc_st_7_1_0!=2'b10) | (rem_12cyc_st_7_3_2[1]);
  assign and_1042_nl = nand_212_cse & or_tmp_551;
  assign mux_tmp_214 = MUX_s_1_2_2(and_1042_nl, or_tmp_551, or_600_cse);
  assign and_1043_nl = nand_215_cse & mux_tmp_214;
  assign mux_217_nl = MUX_s_1_2_2(and_1043_nl, mux_tmp_214, or_591_cse);
  assign and_tmp_152 = or_569_cse & or_573_cse & or_578_cse & or_584_cse & mux_217_nl;
  assign and_1044_nl = nand_281_cse & and_tmp_152;
  assign mux_218_nl = MUX_s_1_2_2(and_1044_nl, and_tmp_152, or_564_cse);
  assign and_dcpl_538 = mux_218_nl & and_dcpl_67 & and_dcpl_63;
  assign or_611_cse = (rem_12cyc_st_8_1_0!=2'b10) | (rem_12cyc_st_8_3_2[1]);
  assign and_1038_nl = nand_208_cse & or_tmp_551;
  assign mux_tmp_217 = MUX_s_1_2_2(and_1038_nl, or_tmp_551, or_611_cse);
  assign and_1039_nl = nand_212_cse & mux_tmp_217;
  assign mux_tmp_218 = MUX_s_1_2_2(and_1039_nl, mux_tmp_217, or_600_cse);
  assign and_1040_nl = nand_215_cse & mux_tmp_218;
  assign mux_221_nl = MUX_s_1_2_2(and_1040_nl, mux_tmp_218, or_591_cse);
  assign and_tmp_156 = or_569_cse & or_573_cse & or_578_cse & or_584_cse & mux_221_nl;
  assign and_1041_nl = nand_281_cse & and_tmp_156;
  assign mux_222_nl = MUX_s_1_2_2(and_1041_nl, and_tmp_156, or_564_cse);
  assign and_dcpl_540 = mux_222_nl & and_dcpl_40 & and_dcpl_36;
  assign and_1033_nl = nand_203_cse & or_tmp_551;
  assign or_624_nl = (rem_12cyc_st_9_1_0!=2'b10) | (rem_12cyc_st_9_3_2[1]);
  assign mux_tmp_221 = MUX_s_1_2_2(and_1033_nl, or_tmp_551, or_624_nl);
  assign and_1034_nl = nand_208_cse & mux_tmp_221;
  assign mux_tmp_222 = MUX_s_1_2_2(and_1034_nl, mux_tmp_221, or_611_cse);
  assign and_1035_nl = nand_212_cse & mux_tmp_222;
  assign mux_tmp_223 = MUX_s_1_2_2(and_1035_nl, mux_tmp_222, or_600_cse);
  assign and_1036_nl = nand_215_cse & mux_tmp_223;
  assign mux_226_nl = MUX_s_1_2_2(and_1036_nl, mux_tmp_223, or_591_cse);
  assign and_tmp_160 = or_569_cse & or_573_cse & or_578_cse & or_584_cse & mux_226_nl;
  assign and_1037_nl = nand_281_cse & and_tmp_160;
  assign mux_227_nl = MUX_s_1_2_2(and_1037_nl, and_tmp_160, or_564_cse);
  assign and_dcpl_542 = mux_227_nl & and_dcpl_13 & and_dcpl_9;
  assign and_tmp_170 = ((~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b01)
      | (rem_12cyc_1_0!=2'b10)) & ((~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b10)
      | (rem_12cyc_st_7_3_2!=2'b01)) & ((~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b10)
      | (rem_12cyc_st_8_3_2!=2'b01)) & ((~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b10)
      | (rem_12cyc_st_9_3_2!=2'b01)) & or_569_cse & or_573_cse & or_578_cse & or_584_cse
      & ((~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b10) | (rem_12cyc_st_6_3_2!=2'b01))
      & ((~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b10) | (rem_12cyc_st_10_3_2!=2'b01))
      & ((acc_tmp!=2'b01) | (acc_1_tmp[1:0]!=2'b10) | (~ ccs_ccore_start_rsci_idat));
  assign and_dcpl_546 = and_dcpl_460 & and_dcpl_430;
  assign or_tmp_629 = (rem_12cyc_1_0!=2'b11) | (rem_12cyc_3_2[1]) | not_tmp_332;
  assign or_643_cse = (acc_1_tmp[1:0]!=2'b11) | (acc_tmp[1]);
  assign and_1169_nl = nand_281_cse & or_tmp_629;
  assign mux_228_nl = MUX_s_1_2_2(and_1169_nl, or_tmp_629, or_643_cse);
  assign and_dcpl_548 = mux_228_nl & and_dcpl_358 & and_dcpl_521;
  assign or_648_cse = (~ (rem_12cyc_st_2_1_0[1])) | (rem_12cyc_st_2_3_2!=2'b01);
  assign and_1030_nl = nand_276_cse & or_tmp_629;
  assign mux_tmp_227 = MUX_s_1_2_2(and_1030_nl, or_tmp_629, or_648_cse);
  assign and_1031_nl = nand_281_cse & mux_tmp_227;
  assign mux_230_nl = MUX_s_1_2_2(and_1031_nl, mux_tmp_227, or_643_cse);
  assign and_dcpl_550 = mux_230_nl & and_dcpl_362 & and_dcpl_524;
  assign or_653_cse = (~ (rem_12cyc_st_3_1_0[1])) | (rem_12cyc_st_3_3_2[1]);
  assign and_1027_nl = nand_198_cse & or_tmp_629;
  assign mux_tmp_229 = MUX_s_1_2_2(and_1027_nl, or_tmp_629, or_653_cse);
  assign and_1028_nl = nand_276_cse & mux_tmp_229;
  assign mux_tmp_230 = MUX_s_1_2_2(and_1028_nl, mux_tmp_229, or_648_cse);
  assign and_1029_nl = nand_281_cse & mux_tmp_230;
  assign mux_233_nl = MUX_s_1_2_2(and_1029_nl, mux_tmp_230, or_643_cse);
  assign and_dcpl_552 = mux_233_nl & and_dcpl_366 & and_dcpl_527;
  assign or_660_cse = (~ (rem_12cyc_st_4_1_0[1])) | (rem_12cyc_st_4_3_2!=2'b01);
  assign and_1023_nl = nand_271_cse & or_tmp_629;
  assign mux_tmp_232 = MUX_s_1_2_2(and_1023_nl, or_tmp_629, or_660_cse);
  assign and_1024_nl = nand_198_cse & mux_tmp_232;
  assign mux_tmp_233 = MUX_s_1_2_2(and_1024_nl, mux_tmp_232, or_653_cse);
  assign and_1025_nl = nand_276_cse & mux_tmp_233;
  assign mux_tmp_234 = MUX_s_1_2_2(and_1025_nl, mux_tmp_233, or_648_cse);
  assign and_1026_nl = nand_281_cse & mux_tmp_234;
  assign mux_237_nl = MUX_s_1_2_2(and_1026_nl, mux_tmp_234, or_643_cse);
  assign and_dcpl_554 = mux_237_nl & and_dcpl_370 & and_dcpl_530;
  assign or_669_cse = (~ (rem_12cyc_st_5_1_0[1])) | (rem_12cyc_st_5_3_2[1]);
  assign and_1018_nl = nand_189_cse & or_tmp_629;
  assign mux_tmp_236 = MUX_s_1_2_2(and_1018_nl, or_tmp_629, or_669_cse);
  assign and_1019_nl = nand_271_cse & mux_tmp_236;
  assign mux_tmp_237 = MUX_s_1_2_2(and_1019_nl, mux_tmp_236, or_660_cse);
  assign and_1020_nl = nand_198_cse & mux_tmp_237;
  assign mux_tmp_238 = MUX_s_1_2_2(and_1020_nl, mux_tmp_237, or_653_cse);
  assign and_1021_nl = nand_276_cse & mux_tmp_238;
  assign mux_tmp_239 = MUX_s_1_2_2(and_1021_nl, mux_tmp_238, or_648_cse);
  assign and_1022_nl = nand_281_cse & mux_tmp_239;
  assign mux_242_nl = MUX_s_1_2_2(and_1022_nl, mux_tmp_239, or_643_cse);
  assign and_dcpl_556 = mux_242_nl & and_dcpl_121 & and_dcpl_119;
  assign or_680_cse = (rem_12cyc_st_6_1_0!=2'b11) | (rem_12cyc_st_6_3_2[1]);
  assign and_1012_nl = nand_215_cse & or_tmp_629;
  assign mux_tmp_241 = MUX_s_1_2_2(and_1012_nl, or_tmp_629, or_680_cse);
  assign and_1013_nl = nand_189_cse & mux_tmp_241;
  assign mux_tmp_242 = MUX_s_1_2_2(and_1013_nl, mux_tmp_241, or_669_cse);
  assign and_1014_nl = nand_271_cse & mux_tmp_242;
  assign mux_tmp_243 = MUX_s_1_2_2(and_1014_nl, mux_tmp_242, or_660_cse);
  assign and_1015_nl = nand_198_cse & mux_tmp_243;
  assign mux_tmp_244 = MUX_s_1_2_2(and_1015_nl, mux_tmp_243, or_653_cse);
  assign and_1016_nl = nand_276_cse & mux_tmp_244;
  assign mux_tmp_245 = MUX_s_1_2_2(and_1016_nl, mux_tmp_244, or_648_cse);
  assign and_1017_nl = nand_281_cse & mux_tmp_245;
  assign mux_248_nl = MUX_s_1_2_2(and_1017_nl, mux_tmp_245, or_643_cse);
  assign and_dcpl_558 = mux_248_nl & and_dcpl_94 & and_dcpl_92;
  assign or_693_cse = (rem_12cyc_st_7_1_0!=2'b11) | (rem_12cyc_st_7_3_2[1]);
  assign and_1005_nl = nand_212_cse & or_tmp_629;
  assign mux_tmp_247 = MUX_s_1_2_2(and_1005_nl, or_tmp_629, or_693_cse);
  assign and_1006_nl = nand_215_cse & mux_tmp_247;
  assign mux_tmp_248 = MUX_s_1_2_2(and_1006_nl, mux_tmp_247, or_680_cse);
  assign and_1007_nl = nand_189_cse & mux_tmp_248;
  assign mux_tmp_249 = MUX_s_1_2_2(and_1007_nl, mux_tmp_248, or_669_cse);
  assign and_1008_nl = nand_271_cse & mux_tmp_249;
  assign mux_tmp_250 = MUX_s_1_2_2(and_1008_nl, mux_tmp_249, or_660_cse);
  assign and_1009_nl = nand_198_cse & mux_tmp_250;
  assign mux_tmp_251 = MUX_s_1_2_2(and_1009_nl, mux_tmp_250, or_653_cse);
  assign and_1010_nl = nand_276_cse & mux_tmp_251;
  assign mux_tmp_252 = MUX_s_1_2_2(and_1010_nl, mux_tmp_251, or_648_cse);
  assign and_1011_nl = nand_281_cse & mux_tmp_252;
  assign mux_255_nl = MUX_s_1_2_2(and_1011_nl, mux_tmp_252, or_643_cse);
  assign and_dcpl_560 = mux_255_nl & and_dcpl_67 & and_dcpl_65;
  assign or_708_cse = (rem_12cyc_st_8_1_0!=2'b11) | (rem_12cyc_st_8_3_2[1]);
  assign and_997_nl = nand_208_cse & or_tmp_629;
  assign mux_tmp_254 = MUX_s_1_2_2(and_997_nl, or_tmp_629, or_708_cse);
  assign and_998_nl = nand_212_cse & mux_tmp_254;
  assign mux_tmp_255 = MUX_s_1_2_2(and_998_nl, mux_tmp_254, or_693_cse);
  assign and_999_nl = nand_215_cse & mux_tmp_255;
  assign mux_tmp_256 = MUX_s_1_2_2(and_999_nl, mux_tmp_255, or_680_cse);
  assign and_1000_nl = nand_189_cse & mux_tmp_256;
  assign mux_tmp_257 = MUX_s_1_2_2(and_1000_nl, mux_tmp_256, or_669_cse);
  assign and_1001_nl = nand_271_cse & mux_tmp_257;
  assign mux_tmp_258 = MUX_s_1_2_2(and_1001_nl, mux_tmp_257, or_660_cse);
  assign and_1002_nl = nand_198_cse & mux_tmp_258;
  assign mux_tmp_259 = MUX_s_1_2_2(and_1002_nl, mux_tmp_258, or_653_cse);
  assign and_1003_nl = nand_276_cse & mux_tmp_259;
  assign mux_tmp_260 = MUX_s_1_2_2(and_1003_nl, mux_tmp_259, or_648_cse);
  assign and_1004_nl = nand_281_cse & mux_tmp_260;
  assign mux_263_nl = MUX_s_1_2_2(and_1004_nl, mux_tmp_260, or_643_cse);
  assign and_dcpl_562 = mux_263_nl & and_dcpl_40 & and_dcpl_38;
  assign and_988_nl = nand_203_cse & or_tmp_629;
  assign or_725_nl = (rem_12cyc_st_9_1_0!=2'b11) | (rem_12cyc_st_9_3_2[1]);
  assign mux_tmp_262 = MUX_s_1_2_2(and_988_nl, or_tmp_629, or_725_nl);
  assign and_989_nl = nand_208_cse & mux_tmp_262;
  assign mux_tmp_263 = MUX_s_1_2_2(and_989_nl, mux_tmp_262, or_708_cse);
  assign and_990_nl = nand_212_cse & mux_tmp_263;
  assign mux_tmp_264 = MUX_s_1_2_2(and_990_nl, mux_tmp_263, or_693_cse);
  assign and_991_nl = nand_215_cse & mux_tmp_264;
  assign mux_tmp_265 = MUX_s_1_2_2(and_991_nl, mux_tmp_264, or_680_cse);
  assign and_992_nl = nand_189_cse & mux_tmp_265;
  assign mux_tmp_266 = MUX_s_1_2_2(and_992_nl, mux_tmp_265, or_669_cse);
  assign and_993_nl = nand_271_cse & mux_tmp_266;
  assign mux_tmp_267 = MUX_s_1_2_2(and_993_nl, mux_tmp_266, or_660_cse);
  assign and_994_nl = nand_198_cse & mux_tmp_267;
  assign mux_tmp_268 = MUX_s_1_2_2(and_994_nl, mux_tmp_267, or_653_cse);
  assign and_995_nl = nand_276_cse & mux_tmp_268;
  assign mux_tmp_269 = MUX_s_1_2_2(and_995_nl, mux_tmp_268, or_648_cse);
  assign and_996_nl = nand_281_cse & mux_tmp_269;
  assign mux_272_nl = MUX_s_1_2_2(and_996_nl, mux_tmp_269, or_643_cse);
  assign and_dcpl_564 = mux_272_nl & and_dcpl_13 & and_dcpl_11;
  assign and_tmp_179 = (~(main_stage_0_8 & asn_itm_7 & (rem_12cyc_st_7_1_0==2'b11)
      & (rem_12cyc_st_7_3_2==2'b01))) & (~(main_stage_0_9 & asn_itm_8 & (rem_12cyc_st_8_1_0==2'b11)
      & (rem_12cyc_st_8_3_2==2'b01))) & (~(main_stage_0_10 & asn_itm_9 & (rem_12cyc_st_9_1_0==2'b11)
      & (rem_12cyc_st_9_3_2==2'b01))) & (~(main_stage_0_3 & asn_itm_2 & (rem_12cyc_st_2_1_0==2'b11)
      & (rem_12cyc_st_2_3_2==2'b01))) & (~(main_stage_0_4 & asn_itm_3 & (rem_12cyc_st_3_1_0==2'b11)
      & (rem_12cyc_st_3_3_2==2'b01))) & (~(main_stage_0_5 & asn_itm_4 & (rem_12cyc_st_4_1_0==2'b11)
      & (rem_12cyc_st_4_3_2==2'b01))) & (~(main_stage_0_6 & asn_itm_5 & (rem_12cyc_st_5_1_0==2'b11)
      & (rem_12cyc_st_5_3_2==2'b01))) & (~(main_stage_0_7 & asn_itm_6 & (rem_12cyc_st_6_1_0==2'b11)
      & (rem_12cyc_st_6_3_2==2'b01))) & (~(main_stage_0_11 & asn_itm_10 & (rem_12cyc_st_10_1_0==2'b11)
      & (rem_12cyc_st_10_3_2==2'b01))) & ((acc_tmp[1]) | (~((acc_tmp[0]) & (acc_1_tmp[1:0]==2'b11)
      & ccs_ccore_start_rsci_idat)));
  assign and_987_nl = (~((rem_12cyc_3_2[0]) & (rem_12cyc_1_0==2'b11))) & and_tmp_179;
  assign or_735_nl = (~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2[1]);
  assign mux_tmp_271 = MUX_s_1_2_2(and_987_nl, and_tmp_179, or_735_nl);
  assign and_dcpl_568 = and_dcpl_292 & (acc_tmp[1]);
  assign and_dcpl_569 = and_dcpl_568 & and_dcpl_291;
  assign and_dcpl_570 = (rem_12cyc_st_2_3_2==2'b10);
  assign and_dcpl_571 = and_dcpl_570 & (~ (rem_12cyc_st_2_1_0[1]));
  assign or_tmp_733 = (rem_12cyc_1_0!=2'b00) | (rem_12cyc_3_2!=2'b10) | not_tmp_54;
  assign or_748_cse = (acc_1_tmp[1:0]!=2'b00) | (acc_tmp!=2'b10);
  assign nor_436_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_733));
  assign mux_274_nl = MUX_s_1_2_2(nor_436_nl, or_tmp_733, or_748_cse);
  assign and_dcpl_573 = mux_274_nl & and_dcpl_298 & and_dcpl_571;
  assign and_dcpl_574 = (rem_12cyc_st_3_3_2==2'b10);
  assign and_dcpl_575 = and_dcpl_574 & (~ (rem_12cyc_st_3_1_0[1]));
  assign or_753_cse = (rem_12cyc_st_2_1_0[1]) | (rem_12cyc_st_2_3_2!=2'b10) | (~
      asn_itm_2) | (~ main_stage_0_3) | (rem_12cyc_st_2_1_0[0]);
  assign and_tmp_180 = or_753_cse & or_tmp_733;
  assign nor_435_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_180));
  assign mux_275_nl = MUX_s_1_2_2(nor_435_nl, and_tmp_180, or_748_cse);
  assign and_dcpl_577 = mux_275_nl & and_dcpl_304 & and_dcpl_575;
  assign and_dcpl_578 = (rem_12cyc_st_4_3_2==2'b10);
  assign and_dcpl_579 = and_dcpl_578 & (~ (rem_12cyc_st_4_1_0[1]));
  assign or_757_cse = (rem_12cyc_st_3_1_0[1]) | (rem_12cyc_st_3_3_2!=2'b10) | (~
      asn_itm_3) | (~ main_stage_0_4) | (rem_12cyc_st_3_1_0[0]);
  assign and_tmp_182 = or_753_cse & or_757_cse & or_tmp_733;
  assign nor_434_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_182));
  assign mux_276_nl = MUX_s_1_2_2(nor_434_nl, and_tmp_182, or_748_cse);
  assign and_dcpl_581 = mux_276_nl & and_dcpl_310 & and_dcpl_579;
  assign and_dcpl_582 = (rem_12cyc_st_5_3_2==2'b10);
  assign and_dcpl_583 = and_dcpl_582 & (~ (rem_12cyc_st_5_1_0[1]));
  assign or_762_cse = (rem_12cyc_st_4_1_0[1]) | (rem_12cyc_st_4_3_2!=2'b10) | (~
      asn_itm_4) | (~ main_stage_0_5) | (rem_12cyc_st_4_1_0[0]);
  assign and_tmp_185 = or_753_cse & or_757_cse & or_762_cse & or_tmp_733;
  assign nor_433_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_185));
  assign mux_277_nl = MUX_s_1_2_2(nor_433_nl, and_tmp_185, or_748_cse);
  assign and_dcpl_585 = mux_277_nl & and_dcpl_316 & and_dcpl_583;
  assign or_768_cse = (rem_12cyc_st_5_1_0[1]) | (rem_12cyc_st_5_3_2!=2'b10) | (~
      asn_itm_5) | (~ main_stage_0_6) | (rem_12cyc_st_5_1_0[0]);
  assign and_tmp_189 = or_753_cse & or_757_cse & or_762_cse & or_768_cse & or_tmp_733;
  assign nor_432_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_189));
  assign mux_278_nl = MUX_s_1_2_2(nor_432_nl, and_tmp_189, or_748_cse);
  assign and_dcpl_589 = mux_278_nl & and_dcpl_112 & and_dcpl_126 & (~ (rem_12cyc_st_6_1_0[1]));
  assign or_775_cse = (rem_12cyc_st_6_1_0!=2'b00) | (rem_12cyc_st_6_3_2!=2'b10);
  assign nor_430_nl = ~(and_dcpl_111 | (~ or_tmp_733));
  assign mux_279_nl = MUX_s_1_2_2(nor_430_nl, or_tmp_733, or_775_cse);
  assign and_tmp_193 = or_753_cse & or_757_cse & or_762_cse & or_768_cse & mux_279_nl;
  assign nor_431_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_193));
  assign mux_280_nl = MUX_s_1_2_2(nor_431_nl, and_tmp_193, or_748_cse);
  assign and_dcpl_593 = mux_280_nl & and_dcpl_85 & and_dcpl_99 & (~ (rem_12cyc_st_7_1_0[0]));
  assign or_784_cse = (rem_12cyc_st_7_1_0!=2'b00) | (rem_12cyc_st_7_3_2!=2'b10);
  assign nor_427_nl = ~(and_dcpl_84 | (~ or_tmp_733));
  assign mux_tmp_279 = MUX_s_1_2_2(nor_427_nl, or_tmp_733, or_784_cse);
  assign nor_428_nl = ~(and_dcpl_111 | (~ mux_tmp_279));
  assign mux_282_nl = MUX_s_1_2_2(nor_428_nl, mux_tmp_279, or_775_cse);
  assign and_tmp_197 = or_753_cse & or_757_cse & or_762_cse & or_768_cse & mux_282_nl;
  assign nor_429_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_197));
  assign mux_283_nl = MUX_s_1_2_2(nor_429_nl, and_tmp_197, or_748_cse);
  assign and_dcpl_597 = mux_283_nl & and_dcpl_58 & and_dcpl_72 & (~ (rem_12cyc_st_8_1_0[0]));
  assign or_795_cse = (rem_12cyc_st_8_1_0!=2'b00) | (rem_12cyc_st_8_3_2!=2'b10);
  assign nor_423_nl = ~(and_dcpl_57 | (~ or_tmp_733));
  assign mux_tmp_282 = MUX_s_1_2_2(nor_423_nl, or_tmp_733, or_795_cse);
  assign nor_424_nl = ~(and_dcpl_84 | (~ mux_tmp_282));
  assign mux_tmp_283 = MUX_s_1_2_2(nor_424_nl, mux_tmp_282, or_784_cse);
  assign nor_425_nl = ~(and_dcpl_111 | (~ mux_tmp_283));
  assign mux_286_nl = MUX_s_1_2_2(nor_425_nl, mux_tmp_283, or_775_cse);
  assign and_tmp_201 = or_753_cse & or_757_cse & or_762_cse & or_768_cse & mux_286_nl;
  assign nor_426_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_201));
  assign mux_287_nl = MUX_s_1_2_2(nor_426_nl, and_tmp_201, or_748_cse);
  assign and_dcpl_601 = mux_287_nl & and_dcpl_31 & and_dcpl_45 & (~ (rem_12cyc_st_9_1_0[0]));
  assign nor_418_nl = ~(and_dcpl_30 | (~ or_tmp_733));
  assign or_808_nl = (rem_12cyc_st_9_1_0!=2'b00) | (rem_12cyc_st_9_3_2!=2'b10);
  assign mux_tmp_286 = MUX_s_1_2_2(nor_418_nl, or_tmp_733, or_808_nl);
  assign nor_419_nl = ~(and_dcpl_57 | (~ mux_tmp_286));
  assign mux_tmp_287 = MUX_s_1_2_2(nor_419_nl, mux_tmp_286, or_795_cse);
  assign nor_420_nl = ~(and_dcpl_84 | (~ mux_tmp_287));
  assign mux_tmp_288 = MUX_s_1_2_2(nor_420_nl, mux_tmp_287, or_784_cse);
  assign nor_421_nl = ~(and_dcpl_111 | (~ mux_tmp_288));
  assign mux_291_nl = MUX_s_1_2_2(nor_421_nl, mux_tmp_288, or_775_cse);
  assign and_tmp_205 = or_753_cse & or_757_cse & or_762_cse & or_768_cse & mux_291_nl;
  assign nor_422_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_205));
  assign mux_292_nl = MUX_s_1_2_2(nor_422_nl, and_tmp_205, or_748_cse);
  assign and_dcpl_605 = mux_292_nl & and_dcpl_4 & and_dcpl_18 & (~ (rem_12cyc_st_10_1_0[0]));
  assign or_tmp_808 = (acc_tmp!=2'b10) | (acc_1_tmp[1:0]!=2'b00) | (~ ccs_ccore_start_rsci_idat);
  assign nor_409_nl = ~((rem_12cyc_st_10_3_2[1]) | (~ or_tmp_808));
  assign or_823_nl = (~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b00)
      | (rem_12cyc_st_10_3_2[0]);
  assign mux_tmp_291 = MUX_s_1_2_2(nor_409_nl, or_tmp_808, or_823_nl);
  assign nor_410_nl = ~((rem_12cyc_st_6_3_2[1]) | (~ mux_tmp_291));
  assign or_822_nl = (~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b00)
      | (rem_12cyc_st_6_3_2[0]);
  assign mux_tmp_292 = MUX_s_1_2_2(nor_410_nl, mux_tmp_291, or_822_nl);
  assign nor_411_nl = ~((rem_12cyc_st_5_3_2[1]) | (~ mux_tmp_292));
  assign or_821_nl = (~ main_stage_0_6) | (~ asn_itm_5) | (rem_12cyc_st_5_1_0!=2'b00)
      | (rem_12cyc_st_5_3_2[0]);
  assign mux_tmp_293 = MUX_s_1_2_2(nor_411_nl, mux_tmp_292, or_821_nl);
  assign nor_412_nl = ~((rem_12cyc_st_4_3_2[1]) | (~ mux_tmp_293));
  assign or_820_nl = (~ main_stage_0_5) | (~ asn_itm_4) | (rem_12cyc_st_4_1_0!=2'b00)
      | (rem_12cyc_st_4_3_2[0]);
  assign mux_tmp_294 = MUX_s_1_2_2(nor_412_nl, mux_tmp_293, or_820_nl);
  assign nor_413_nl = ~((rem_12cyc_st_3_3_2[1]) | (~ mux_tmp_294));
  assign or_819_nl = (~ main_stage_0_4) | (~ asn_itm_3) | (rem_12cyc_st_3_1_0!=2'b00)
      | (rem_12cyc_st_3_3_2[0]);
  assign mux_tmp_295 = MUX_s_1_2_2(nor_413_nl, mux_tmp_294, or_819_nl);
  assign nor_414_nl = ~((rem_12cyc_st_2_3_2[1]) | (~ mux_tmp_295));
  assign or_818_nl = (~ main_stage_0_3) | (~ asn_itm_2) | (rem_12cyc_st_2_1_0!=2'b00)
      | (rem_12cyc_st_2_3_2[0]);
  assign mux_tmp_296 = MUX_s_1_2_2(nor_414_nl, mux_tmp_295, or_818_nl);
  assign nor_415_nl = ~((rem_12cyc_st_9_3_2[1]) | (~ mux_tmp_296));
  assign or_817_nl = (~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b00)
      | (rem_12cyc_st_9_3_2[0]);
  assign mux_tmp_297 = MUX_s_1_2_2(nor_415_nl, mux_tmp_296, or_817_nl);
  assign nor_416_nl = ~((rem_12cyc_st_8_3_2[1]) | (~ mux_tmp_297));
  assign or_816_nl = (~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b00)
      | (rem_12cyc_st_8_3_2[0]);
  assign mux_tmp_298 = MUX_s_1_2_2(nor_416_nl, mux_tmp_297, or_816_nl);
  assign nor_417_nl = ~((rem_12cyc_st_7_3_2[1]) | (~ mux_tmp_298));
  assign or_815_nl = (~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b00)
      | (rem_12cyc_st_7_3_2[0]);
  assign mux_301_nl = MUX_s_1_2_2(nor_417_nl, mux_tmp_298, or_815_nl);
  assign and_tmp_206 = ((~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b10)
      | (rem_12cyc_1_0!=2'b00)) & mux_301_nl;
  assign and_dcpl_610 = and_dcpl_568 & and_dcpl_355;
  assign or_tmp_820 = (rem_12cyc_1_0!=2'b01) | (rem_12cyc_3_2!=2'b10) | not_tmp_54;
  assign or_837_cse = (acc_1_tmp[1:0]!=2'b01) | (acc_tmp!=2'b10);
  assign nor_408_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_820));
  assign mux_302_nl = MUX_s_1_2_2(nor_408_nl, or_tmp_820, or_837_cse);
  assign and_dcpl_612 = mux_302_nl & and_dcpl_358 & and_dcpl_571;
  assign nand_84_cse = ~((rem_12cyc_st_2_3_2[1]) & asn_itm_2 & main_stage_0_3 & (rem_12cyc_st_2_1_0[0]));
  assign or_842_cse = (rem_12cyc_st_2_1_0[1]) | (rem_12cyc_st_2_3_2[0]);
  assign and_986_nl = nand_84_cse & or_tmp_820;
  assign mux_tmp_301 = MUX_s_1_2_2(and_986_nl, or_tmp_820, or_842_cse);
  assign nor_407_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_301));
  assign mux_304_nl = MUX_s_1_2_2(nor_407_nl, mux_tmp_301, or_837_cse);
  assign and_dcpl_614 = mux_304_nl & and_dcpl_362 & and_dcpl_575;
  assign or_847_cse = (rem_12cyc_st_3_1_0[1]) | (rem_12cyc_st_3_3_2!=2'b10);
  assign and_984_nl = nand_274_cse & or_tmp_820;
  assign mux_tmp_303 = MUX_s_1_2_2(and_984_nl, or_tmp_820, or_847_cse);
  assign and_985_nl = nand_84_cse & mux_tmp_303;
  assign mux_tmp_304 = MUX_s_1_2_2(and_985_nl, mux_tmp_303, or_842_cse);
  assign nor_406_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_304));
  assign mux_307_nl = MUX_s_1_2_2(nor_406_nl, mux_tmp_304, or_837_cse);
  assign and_dcpl_616 = mux_307_nl & and_dcpl_366 & and_dcpl_579;
  assign nand_79_cse = ~((rem_12cyc_st_4_3_2[1]) & asn_itm_4 & main_stage_0_5 & (rem_12cyc_st_4_1_0[0]));
  assign or_854_cse = (rem_12cyc_st_4_1_0[1]) | (rem_12cyc_st_4_3_2[0]);
  assign and_981_nl = nand_79_cse & or_tmp_820;
  assign mux_tmp_306 = MUX_s_1_2_2(and_981_nl, or_tmp_820, or_854_cse);
  assign and_982_nl = nand_274_cse & mux_tmp_306;
  assign mux_tmp_307 = MUX_s_1_2_2(and_982_nl, mux_tmp_306, or_847_cse);
  assign and_983_nl = nand_84_cse & mux_tmp_307;
  assign mux_tmp_308 = MUX_s_1_2_2(and_983_nl, mux_tmp_307, or_842_cse);
  assign nor_405_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_308));
  assign mux_311_nl = MUX_s_1_2_2(nor_405_nl, mux_tmp_308, or_837_cse);
  assign and_dcpl_618 = mux_311_nl & and_dcpl_370 & and_dcpl_583;
  assign or_863_cse = (rem_12cyc_st_5_1_0[1]) | (rem_12cyc_st_5_3_2!=2'b10);
  assign and_977_nl = nand_267_cse & or_tmp_820;
  assign mux_tmp_310 = MUX_s_1_2_2(and_977_nl, or_tmp_820, or_863_cse);
  assign and_978_nl = nand_79_cse & mux_tmp_310;
  assign mux_tmp_311 = MUX_s_1_2_2(and_978_nl, mux_tmp_310, or_854_cse);
  assign and_979_nl = nand_274_cse & mux_tmp_311;
  assign mux_tmp_312 = MUX_s_1_2_2(and_979_nl, mux_tmp_311, or_847_cse);
  assign and_980_nl = nand_84_cse & mux_tmp_312;
  assign mux_tmp_313 = MUX_s_1_2_2(and_980_nl, mux_tmp_312, or_842_cse);
  assign nor_404_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_313));
  assign mux_316_nl = MUX_s_1_2_2(nor_404_nl, mux_tmp_313, or_837_cse);
  assign and_dcpl_622 = mux_316_nl & and_dcpl_112 & and_dcpl_129 & (~ (rem_12cyc_st_6_1_0[1]));
  assign or_874_cse = (rem_12cyc_st_6_1_0!=2'b01) | (rem_12cyc_st_6_3_2!=2'b10);
  assign nor_402_nl = ~(and_dcpl_111 | (~ or_tmp_820));
  assign mux_tmp_315 = MUX_s_1_2_2(nor_402_nl, or_tmp_820, or_874_cse);
  assign and_973_nl = nand_267_cse & mux_tmp_315;
  assign mux_tmp_316 = MUX_s_1_2_2(and_973_nl, mux_tmp_315, or_863_cse);
  assign and_974_nl = nand_79_cse & mux_tmp_316;
  assign mux_tmp_317 = MUX_s_1_2_2(and_974_nl, mux_tmp_316, or_854_cse);
  assign and_975_nl = nand_274_cse & mux_tmp_317;
  assign mux_tmp_318 = MUX_s_1_2_2(and_975_nl, mux_tmp_317, or_847_cse);
  assign and_976_nl = nand_84_cse & mux_tmp_318;
  assign mux_tmp_319 = MUX_s_1_2_2(and_976_nl, mux_tmp_318, or_842_cse);
  assign nor_403_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_319));
  assign mux_322_nl = MUX_s_1_2_2(nor_403_nl, mux_tmp_319, or_837_cse);
  assign and_dcpl_625 = mux_322_nl & and_dcpl_85 & and_dcpl_99 & (rem_12cyc_st_7_1_0[0]);
  assign or_887_cse = (rem_12cyc_st_7_1_0!=2'b01) | (rem_12cyc_st_7_3_2!=2'b10);
  assign nor_399_nl = ~(and_dcpl_84 | (~ or_tmp_820));
  assign mux_tmp_321 = MUX_s_1_2_2(nor_399_nl, or_tmp_820, or_887_cse);
  assign nor_400_nl = ~(and_dcpl_111 | (~ mux_tmp_321));
  assign mux_tmp_322 = MUX_s_1_2_2(nor_400_nl, mux_tmp_321, or_874_cse);
  assign and_969_nl = nand_267_cse & mux_tmp_322;
  assign mux_tmp_323 = MUX_s_1_2_2(and_969_nl, mux_tmp_322, or_863_cse);
  assign and_970_nl = nand_79_cse & mux_tmp_323;
  assign mux_tmp_324 = MUX_s_1_2_2(and_970_nl, mux_tmp_323, or_854_cse);
  assign and_971_nl = nand_274_cse & mux_tmp_324;
  assign mux_tmp_325 = MUX_s_1_2_2(and_971_nl, mux_tmp_324, or_847_cse);
  assign and_972_nl = nand_84_cse & mux_tmp_325;
  assign mux_tmp_326 = MUX_s_1_2_2(and_972_nl, mux_tmp_325, or_842_cse);
  assign nor_401_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_326));
  assign mux_329_nl = MUX_s_1_2_2(nor_401_nl, mux_tmp_326, or_837_cse);
  assign and_dcpl_628 = mux_329_nl & and_dcpl_58 & and_dcpl_72 & (rem_12cyc_st_8_1_0[0]);
  assign or_902_cse = (rem_12cyc_st_8_1_0!=2'b01) | (rem_12cyc_st_8_3_2!=2'b10);
  assign nor_395_nl = ~(and_dcpl_57 | (~ or_tmp_820));
  assign mux_tmp_328 = MUX_s_1_2_2(nor_395_nl, or_tmp_820, or_902_cse);
  assign nor_396_nl = ~(and_dcpl_84 | (~ mux_tmp_328));
  assign mux_tmp_329 = MUX_s_1_2_2(nor_396_nl, mux_tmp_328, or_887_cse);
  assign nor_397_nl = ~(and_dcpl_111 | (~ mux_tmp_329));
  assign mux_tmp_330 = MUX_s_1_2_2(nor_397_nl, mux_tmp_329, or_874_cse);
  assign and_965_nl = nand_267_cse & mux_tmp_330;
  assign mux_tmp_331 = MUX_s_1_2_2(and_965_nl, mux_tmp_330, or_863_cse);
  assign and_966_nl = nand_79_cse & mux_tmp_331;
  assign mux_tmp_332 = MUX_s_1_2_2(and_966_nl, mux_tmp_331, or_854_cse);
  assign and_967_nl = nand_274_cse & mux_tmp_332;
  assign mux_tmp_333 = MUX_s_1_2_2(and_967_nl, mux_tmp_332, or_847_cse);
  assign and_968_nl = nand_84_cse & mux_tmp_333;
  assign mux_tmp_334 = MUX_s_1_2_2(and_968_nl, mux_tmp_333, or_842_cse);
  assign nor_398_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_334));
  assign mux_337_nl = MUX_s_1_2_2(nor_398_nl, mux_tmp_334, or_837_cse);
  assign and_dcpl_631 = mux_337_nl & and_dcpl_31 & and_dcpl_45 & (rem_12cyc_st_9_1_0[0]);
  assign nor_390_nl = ~(and_dcpl_30 | (~ or_tmp_820));
  assign or_919_nl = (rem_12cyc_st_9_1_0!=2'b01) | (rem_12cyc_st_9_3_2!=2'b10);
  assign mux_tmp_336 = MUX_s_1_2_2(nor_390_nl, or_tmp_820, or_919_nl);
  assign nor_391_nl = ~(and_dcpl_57 | (~ mux_tmp_336));
  assign mux_tmp_337 = MUX_s_1_2_2(nor_391_nl, mux_tmp_336, or_902_cse);
  assign nor_392_nl = ~(and_dcpl_84 | (~ mux_tmp_337));
  assign mux_tmp_338 = MUX_s_1_2_2(nor_392_nl, mux_tmp_337, or_887_cse);
  assign nor_393_nl = ~(and_dcpl_111 | (~ mux_tmp_338));
  assign mux_tmp_339 = MUX_s_1_2_2(nor_393_nl, mux_tmp_338, or_874_cse);
  assign and_961_nl = nand_267_cse & mux_tmp_339;
  assign mux_tmp_340 = MUX_s_1_2_2(and_961_nl, mux_tmp_339, or_863_cse);
  assign and_962_nl = nand_79_cse & mux_tmp_340;
  assign mux_tmp_341 = MUX_s_1_2_2(and_962_nl, mux_tmp_340, or_854_cse);
  assign and_963_nl = nand_274_cse & mux_tmp_341;
  assign mux_tmp_342 = MUX_s_1_2_2(and_963_nl, mux_tmp_341, or_847_cse);
  assign and_964_nl = nand_84_cse & mux_tmp_342;
  assign mux_tmp_343 = MUX_s_1_2_2(and_964_nl, mux_tmp_342, or_842_cse);
  assign nor_394_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_343));
  assign mux_346_nl = MUX_s_1_2_2(nor_394_nl, mux_tmp_343, or_837_cse);
  assign and_dcpl_634 = mux_346_nl & and_dcpl_4 & and_dcpl_18 & (rem_12cyc_st_10_1_0[0]);
  assign or_tmp_921 = (acc_tmp!=2'b10) | (acc_1_tmp[1]) | nand_250_cse;
  assign nor_380_nl = ~((rem_12cyc_st_10_3_2[1]) | (~ or_tmp_921));
  assign or_938_nl = (~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b01)
      | (rem_12cyc_st_10_3_2[0]);
  assign mux_tmp_345 = MUX_s_1_2_2(nor_380_nl, or_tmp_921, or_938_nl);
  assign nor_381_nl = ~((rem_12cyc_st_6_3_2[1]) | (~ mux_tmp_345));
  assign or_937_nl = (~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b01)
      | (rem_12cyc_st_6_3_2[0]);
  assign mux_tmp_346 = MUX_s_1_2_2(nor_381_nl, mux_tmp_345, or_937_nl);
  assign nor_382_nl = ~((rem_12cyc_st_5_3_2[1]) | (~ mux_tmp_346));
  assign or_936_nl = (~ main_stage_0_6) | (~ asn_itm_5) | (rem_12cyc_st_5_1_0!=2'b01)
      | (rem_12cyc_st_5_3_2[0]);
  assign mux_tmp_347 = MUX_s_1_2_2(nor_382_nl, mux_tmp_346, or_936_nl);
  assign nor_383_nl = ~((rem_12cyc_st_4_3_2[1]) | (~ mux_tmp_347));
  assign or_935_nl = (~ main_stage_0_5) | (~ asn_itm_4) | (rem_12cyc_st_4_1_0!=2'b01)
      | (rem_12cyc_st_4_3_2[0]);
  assign mux_tmp_348 = MUX_s_1_2_2(nor_383_nl, mux_tmp_347, or_935_nl);
  assign nor_384_nl = ~((rem_12cyc_st_3_3_2[1]) | (~ mux_tmp_348));
  assign or_934_nl = (~ main_stage_0_4) | (~ asn_itm_3) | (rem_12cyc_st_3_1_0!=2'b01)
      | (rem_12cyc_st_3_3_2[0]);
  assign mux_tmp_349 = MUX_s_1_2_2(nor_384_nl, mux_tmp_348, or_934_nl);
  assign nor_385_nl = ~((rem_12cyc_st_2_3_2[1]) | (~ mux_tmp_349));
  assign or_933_nl = (~ main_stage_0_3) | (~ asn_itm_2) | (rem_12cyc_st_2_1_0!=2'b01)
      | (rem_12cyc_st_2_3_2[0]);
  assign mux_tmp_350 = MUX_s_1_2_2(nor_385_nl, mux_tmp_349, or_933_nl);
  assign nor_386_nl = ~((rem_12cyc_st_9_3_2[1]) | (~ mux_tmp_350));
  assign or_932_nl = (~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b01)
      | (rem_12cyc_st_9_3_2[0]);
  assign mux_tmp_351 = MUX_s_1_2_2(nor_386_nl, mux_tmp_350, or_932_nl);
  assign nor_387_nl = ~((rem_12cyc_st_8_3_2[1]) | (~ mux_tmp_351));
  assign or_931_nl = (~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b01)
      | (rem_12cyc_st_8_3_2[0]);
  assign mux_tmp_352 = MUX_s_1_2_2(nor_387_nl, mux_tmp_351, or_931_nl);
  assign nor_388_nl = ~((rem_12cyc_st_7_3_2[1]) | (~ mux_tmp_352));
  assign or_930_nl = (~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b01)
      | (rem_12cyc_st_7_3_2[0]);
  assign mux_tmp_353 = MUX_s_1_2_2(nor_388_nl, mux_tmp_352, or_930_nl);
  assign nor_389_nl = ~((rem_12cyc_1_0[0]) | (~ mux_tmp_353));
  assign or_929_nl = (~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b10)
      | (rem_12cyc_1_0[1]);
  assign mux_tmp_354 = MUX_s_1_2_2(nor_389_nl, mux_tmp_353, or_929_nl);
  assign and_dcpl_638 = and_dcpl_568 & and_dcpl_393;
  assign and_dcpl_639 = and_dcpl_570 & (rem_12cyc_st_2_1_0[1]);
  assign or_tmp_934 = (rem_12cyc_1_0!=2'b10) | (rem_12cyc_3_2!=2'b10) | not_tmp_54;
  assign or_952_cse = (acc_1_tmp[1:0]!=2'b10) | (acc_tmp!=2'b10);
  assign nor_379_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_934));
  assign mux_357_nl = MUX_s_1_2_2(nor_379_nl, or_tmp_934, or_952_cse);
  assign and_dcpl_641 = mux_357_nl & and_dcpl_298 & and_dcpl_639;
  assign and_dcpl_642 = and_dcpl_574 & (rem_12cyc_st_3_1_0[1]);
  assign or_957_cse = (~ (rem_12cyc_st_2_1_0[1])) | (rem_12cyc_st_2_3_2!=2'b10) |
      (~ asn_itm_2) | (~ main_stage_0_3) | (rem_12cyc_st_2_1_0[0]);
  assign and_tmp_207 = or_957_cse & or_tmp_934;
  assign nor_378_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_207));
  assign mux_358_nl = MUX_s_1_2_2(nor_378_nl, and_tmp_207, or_952_cse);
  assign and_dcpl_644 = mux_358_nl & and_dcpl_304 & and_dcpl_642;
  assign and_dcpl_645 = and_dcpl_578 & (rem_12cyc_st_4_1_0[1]);
  assign or_961_cse = (~ (rem_12cyc_st_3_1_0[1])) | (rem_12cyc_st_3_3_2!=2'b10) |
      (~ asn_itm_3) | (~ main_stage_0_4) | (rem_12cyc_st_3_1_0[0]);
  assign and_tmp_209 = or_957_cse & or_961_cse & or_tmp_934;
  assign nor_377_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_209));
  assign mux_359_nl = MUX_s_1_2_2(nor_377_nl, and_tmp_209, or_952_cse);
  assign and_dcpl_647 = mux_359_nl & and_dcpl_310 & and_dcpl_645;
  assign and_dcpl_648 = and_dcpl_582 & (rem_12cyc_st_5_1_0[1]);
  assign or_966_cse = (~ (rem_12cyc_st_4_1_0[1])) | (rem_12cyc_st_4_3_2!=2'b10) |
      (~ asn_itm_4) | (~ main_stage_0_5) | (rem_12cyc_st_4_1_0[0]);
  assign and_tmp_212 = or_957_cse & or_961_cse & or_966_cse & or_tmp_934;
  assign nor_376_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_212));
  assign mux_360_nl = MUX_s_1_2_2(nor_376_nl, and_tmp_212, or_952_cse);
  assign and_dcpl_650 = mux_360_nl & and_dcpl_316 & and_dcpl_648;
  assign or_972_cse = (~ (rem_12cyc_st_5_1_0[1])) | (rem_12cyc_st_5_3_2!=2'b10) |
      (~ asn_itm_5) | (~ main_stage_0_6) | (rem_12cyc_st_5_1_0[0]);
  assign and_tmp_216 = or_957_cse & or_961_cse & or_966_cse & or_972_cse & or_tmp_934;
  assign nor_375_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_216));
  assign mux_361_nl = MUX_s_1_2_2(nor_375_nl, and_tmp_216, or_952_cse);
  assign and_dcpl_653 = mux_361_nl & and_dcpl_112 & and_dcpl_126 & (rem_12cyc_st_6_1_0[1]);
  assign or_979_cse = (rem_12cyc_st_6_1_0!=2'b10) | (rem_12cyc_st_6_3_2!=2'b10);
  assign nor_373_nl = ~(and_dcpl_111 | (~ or_tmp_934));
  assign mux_362_nl = MUX_s_1_2_2(nor_373_nl, or_tmp_934, or_979_cse);
  assign and_tmp_220 = or_957_cse & or_961_cse & or_966_cse & or_972_cse & mux_362_nl;
  assign nor_374_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_220));
  assign mux_363_nl = MUX_s_1_2_2(nor_374_nl, and_tmp_220, or_952_cse);
  assign and_dcpl_657 = mux_363_nl & and_dcpl_85 & and_dcpl_104 & (~ (rem_12cyc_st_7_1_0[0]));
  assign or_988_cse = (rem_12cyc_st_7_1_0!=2'b10) | (rem_12cyc_st_7_3_2!=2'b10);
  assign nor_370_nl = ~(and_dcpl_84 | (~ or_tmp_934));
  assign mux_tmp_362 = MUX_s_1_2_2(nor_370_nl, or_tmp_934, or_988_cse);
  assign nor_371_nl = ~(and_dcpl_111 | (~ mux_tmp_362));
  assign mux_365_nl = MUX_s_1_2_2(nor_371_nl, mux_tmp_362, or_979_cse);
  assign and_tmp_224 = or_957_cse & or_961_cse & or_966_cse & or_972_cse & mux_365_nl;
  assign nor_372_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_224));
  assign mux_366_nl = MUX_s_1_2_2(nor_372_nl, and_tmp_224, or_952_cse);
  assign and_dcpl_661 = mux_366_nl & and_dcpl_58 & and_dcpl_77 & (~ (rem_12cyc_st_8_1_0[0]));
  assign or_999_cse = (rem_12cyc_st_8_1_0!=2'b10) | (rem_12cyc_st_8_3_2!=2'b10);
  assign nor_366_nl = ~(and_dcpl_57 | (~ or_tmp_934));
  assign mux_tmp_365 = MUX_s_1_2_2(nor_366_nl, or_tmp_934, or_999_cse);
  assign nor_367_nl = ~(and_dcpl_84 | (~ mux_tmp_365));
  assign mux_tmp_366 = MUX_s_1_2_2(nor_367_nl, mux_tmp_365, or_988_cse);
  assign nor_368_nl = ~(and_dcpl_111 | (~ mux_tmp_366));
  assign mux_369_nl = MUX_s_1_2_2(nor_368_nl, mux_tmp_366, or_979_cse);
  assign and_tmp_228 = or_957_cse & or_961_cse & or_966_cse & or_972_cse & mux_369_nl;
  assign nor_369_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_228));
  assign mux_370_nl = MUX_s_1_2_2(nor_369_nl, and_tmp_228, or_952_cse);
  assign and_dcpl_665 = mux_370_nl & and_dcpl_31 & and_dcpl_50 & (~ (rem_12cyc_st_9_1_0[0]));
  assign nor_361_nl = ~(and_dcpl_30 | (~ or_tmp_934));
  assign or_1012_nl = (rem_12cyc_st_9_1_0!=2'b10) | (rem_12cyc_st_9_3_2!=2'b10);
  assign mux_tmp_369 = MUX_s_1_2_2(nor_361_nl, or_tmp_934, or_1012_nl);
  assign nor_362_nl = ~(and_dcpl_57 | (~ mux_tmp_369));
  assign mux_tmp_370 = MUX_s_1_2_2(nor_362_nl, mux_tmp_369, or_999_cse);
  assign nor_363_nl = ~(and_dcpl_84 | (~ mux_tmp_370));
  assign mux_tmp_371 = MUX_s_1_2_2(nor_363_nl, mux_tmp_370, or_988_cse);
  assign nor_364_nl = ~(and_dcpl_111 | (~ mux_tmp_371));
  assign mux_374_nl = MUX_s_1_2_2(nor_364_nl, mux_tmp_371, or_979_cse);
  assign and_tmp_232 = or_957_cse & or_961_cse & or_966_cse & or_972_cse & mux_374_nl;
  assign nor_365_nl = ~(ccs_ccore_start_rsci_idat | (~ and_tmp_232));
  assign mux_375_nl = MUX_s_1_2_2(nor_365_nl, and_tmp_232, or_952_cse);
  assign and_dcpl_669 = mux_375_nl & and_dcpl_4 & and_dcpl_23 & (~ (rem_12cyc_st_10_1_0[0]));
  assign or_tmp_1009 = (acc_tmp!=2'b10) | (acc_1_tmp[1:0]!=2'b10) | (~ ccs_ccore_start_rsci_idat);
  assign nor_352_nl = ~((rem_12cyc_st_10_3_2[1]) | (~ or_tmp_1009));
  assign or_1027_nl = (~ main_stage_0_11) | (~ asn_itm_10) | (rem_12cyc_st_10_1_0!=2'b10)
      | (rem_12cyc_st_10_3_2[0]);
  assign mux_tmp_374 = MUX_s_1_2_2(nor_352_nl, or_tmp_1009, or_1027_nl);
  assign nor_353_nl = ~((rem_12cyc_st_6_3_2[1]) | (~ mux_tmp_374));
  assign or_1026_nl = (~ main_stage_0_7) | (~ asn_itm_6) | (rem_12cyc_st_6_1_0!=2'b10)
      | (rem_12cyc_st_6_3_2[0]);
  assign mux_tmp_375 = MUX_s_1_2_2(nor_353_nl, mux_tmp_374, or_1026_nl);
  assign nor_354_nl = ~((rem_12cyc_st_5_3_2[1]) | (~ mux_tmp_375));
  assign or_1025_nl = (~ main_stage_0_6) | (~ asn_itm_5) | (rem_12cyc_st_5_1_0!=2'b10)
      | (rem_12cyc_st_5_3_2[0]);
  assign mux_tmp_376 = MUX_s_1_2_2(nor_354_nl, mux_tmp_375, or_1025_nl);
  assign nor_355_nl = ~((rem_12cyc_st_4_3_2[1]) | (~ mux_tmp_376));
  assign or_1024_nl = (~ main_stage_0_5) | (~ asn_itm_4) | (rem_12cyc_st_4_1_0!=2'b10)
      | (rem_12cyc_st_4_3_2[0]);
  assign mux_tmp_377 = MUX_s_1_2_2(nor_355_nl, mux_tmp_376, or_1024_nl);
  assign nor_356_nl = ~((rem_12cyc_st_3_3_2[1]) | (~ mux_tmp_377));
  assign or_1023_nl = (~ main_stage_0_4) | (~ asn_itm_3) | (rem_12cyc_st_3_1_0!=2'b10)
      | (rem_12cyc_st_3_3_2[0]);
  assign mux_tmp_378 = MUX_s_1_2_2(nor_356_nl, mux_tmp_377, or_1023_nl);
  assign nor_357_nl = ~((rem_12cyc_st_2_3_2[1]) | (~ mux_tmp_378));
  assign or_1022_nl = (~ main_stage_0_3) | (~ asn_itm_2) | (rem_12cyc_st_2_1_0!=2'b10)
      | (rem_12cyc_st_2_3_2[0]);
  assign mux_tmp_379 = MUX_s_1_2_2(nor_357_nl, mux_tmp_378, or_1022_nl);
  assign nor_358_nl = ~((rem_12cyc_st_9_3_2[1]) | (~ mux_tmp_379));
  assign or_1021_nl = (~ main_stage_0_10) | (~ asn_itm_9) | (rem_12cyc_st_9_1_0!=2'b10)
      | (rem_12cyc_st_9_3_2[0]);
  assign mux_tmp_380 = MUX_s_1_2_2(nor_358_nl, mux_tmp_379, or_1021_nl);
  assign nor_359_nl = ~((rem_12cyc_st_8_3_2[1]) | (~ mux_tmp_380));
  assign or_1020_nl = (~ main_stage_0_9) | (~ asn_itm_8) | (rem_12cyc_st_8_1_0!=2'b10)
      | (rem_12cyc_st_8_3_2[0]);
  assign mux_tmp_381 = MUX_s_1_2_2(nor_359_nl, mux_tmp_380, or_1020_nl);
  assign nor_360_nl = ~((rem_12cyc_st_7_3_2[1]) | (~ mux_tmp_381));
  assign or_1019_nl = (~ main_stage_0_8) | (~ asn_itm_7) | (rem_12cyc_st_7_1_0!=2'b10)
      | (rem_12cyc_st_7_3_2[0]);
  assign mux_384_nl = MUX_s_1_2_2(nor_360_nl, mux_tmp_381, or_1019_nl);
  assign and_tmp_233 = ((~ main_stage_0_2) | (~ asn_itm_1) | (rem_12cyc_3_2!=2'b10)
      | (rem_12cyc_1_0!=2'b10)) & mux_384_nl;
  assign and_dcpl_673 = and_dcpl_568 & and_dcpl_430;
  assign or_tmp_1021 = (~((rem_12cyc_1_0==2'b11) & (rem_12cyc_3_2==2'b10))) | not_tmp_54;
  assign nand_57_cse = ~((acc_1_tmp[1:0]==2'b11) & (acc_tmp==2'b10));
  assign nor_351_nl = ~(ccs_ccore_start_rsci_idat | (~ or_tmp_1021));
  assign mux_385_nl = MUX_s_1_2_2(nor_351_nl, or_tmp_1021, nand_57_cse);
  assign and_dcpl_675 = mux_385_nl & and_dcpl_358 & and_dcpl_639;
  assign or_1045_cse = (~ (rem_12cyc_st_2_1_0[1])) | (rem_12cyc_st_2_3_2[0]);
  assign and_960_nl = nand_84_cse & or_tmp_1021;
  assign mux_tmp_384 = MUX_s_1_2_2(and_960_nl, or_tmp_1021, or_1045_cse);
  assign nor_350_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_384));
  assign mux_387_nl = MUX_s_1_2_2(nor_350_nl, mux_tmp_384, nand_57_cse);
  assign and_dcpl_677 = mux_387_nl & and_dcpl_362 & and_dcpl_642;
  assign or_1050_cse = (~ (rem_12cyc_st_3_1_0[1])) | (rem_12cyc_st_3_3_2!=2'b10);
  assign and_958_nl = nand_274_cse & or_tmp_1021;
  assign mux_tmp_386 = MUX_s_1_2_2(and_958_nl, or_tmp_1021, or_1050_cse);
  assign and_959_nl = nand_84_cse & mux_tmp_386;
  assign mux_tmp_387 = MUX_s_1_2_2(and_959_nl, mux_tmp_386, or_1045_cse);
  assign nor_349_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_387));
  assign mux_390_nl = MUX_s_1_2_2(nor_349_nl, mux_tmp_387, nand_57_cse);
  assign and_dcpl_679 = mux_390_nl & and_dcpl_366 & and_dcpl_645;
  assign or_1057_cse = (~ (rem_12cyc_st_4_1_0[1])) | (rem_12cyc_st_4_3_2[0]);
  assign and_955_nl = nand_79_cse & or_tmp_1021;
  assign mux_tmp_389 = MUX_s_1_2_2(and_955_nl, or_tmp_1021, or_1057_cse);
  assign and_956_nl = nand_274_cse & mux_tmp_389;
  assign mux_tmp_390 = MUX_s_1_2_2(and_956_nl, mux_tmp_389, or_1050_cse);
  assign and_957_nl = nand_84_cse & mux_tmp_390;
  assign mux_tmp_391 = MUX_s_1_2_2(and_957_nl, mux_tmp_390, or_1045_cse);
  assign nor_348_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_391));
  assign mux_394_nl = MUX_s_1_2_2(nor_348_nl, mux_tmp_391, nand_57_cse);
  assign and_dcpl_681 = mux_394_nl & and_dcpl_370 & and_dcpl_648;
  assign or_1066_cse = (~ (rem_12cyc_st_5_1_0[1])) | (rem_12cyc_st_5_3_2!=2'b10);
  assign and_951_nl = nand_267_cse & or_tmp_1021;
  assign mux_tmp_393 = MUX_s_1_2_2(and_951_nl, or_tmp_1021, or_1066_cse);
  assign and_952_nl = nand_79_cse & mux_tmp_393;
  assign mux_tmp_394 = MUX_s_1_2_2(and_952_nl, mux_tmp_393, or_1057_cse);
  assign and_953_nl = nand_274_cse & mux_tmp_394;
  assign mux_tmp_395 = MUX_s_1_2_2(and_953_nl, mux_tmp_394, or_1050_cse);
  assign and_954_nl = nand_84_cse & mux_tmp_395;
  assign mux_tmp_396 = MUX_s_1_2_2(and_954_nl, mux_tmp_395, or_1045_cse);
  assign nor_347_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_396));
  assign mux_399_nl = MUX_s_1_2_2(nor_347_nl, mux_tmp_396, nand_57_cse);
  assign and_dcpl_684 = mux_399_nl & and_dcpl_112 & and_dcpl_129 & (rem_12cyc_st_6_1_0[1]);
  assign nand_36_cse = ~((rem_12cyc_st_6_1_0==2'b11) & (rem_12cyc_st_6_3_2==2'b10));
  assign nor_345_nl = ~(and_dcpl_111 | (~ or_tmp_1021));
  assign mux_tmp_398 = MUX_s_1_2_2(nor_345_nl, or_tmp_1021, nand_36_cse);
  assign and_947_nl = nand_267_cse & mux_tmp_398;
  assign mux_tmp_399 = MUX_s_1_2_2(and_947_nl, mux_tmp_398, or_1066_cse);
  assign and_948_nl = nand_79_cse & mux_tmp_399;
  assign mux_tmp_400 = MUX_s_1_2_2(and_948_nl, mux_tmp_399, or_1057_cse);
  assign and_949_nl = nand_274_cse & mux_tmp_400;
  assign mux_tmp_401 = MUX_s_1_2_2(and_949_nl, mux_tmp_400, or_1050_cse);
  assign and_950_nl = nand_84_cse & mux_tmp_401;
  assign mux_tmp_402 = MUX_s_1_2_2(and_950_nl, mux_tmp_401, or_1045_cse);
  assign nor_346_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_402));
  assign mux_405_nl = MUX_s_1_2_2(nor_346_nl, mux_tmp_402, nand_57_cse);
  assign and_dcpl_687 = mux_405_nl & and_dcpl_85 & and_dcpl_104 & (rem_12cyc_st_7_1_0[0]);
  assign nand_29_cse = ~((rem_12cyc_st_7_1_0==2'b11) & (rem_12cyc_st_7_3_2==2'b10));
  assign nor_342_nl = ~(and_dcpl_84 | (~ or_tmp_1021));
  assign mux_tmp_404 = MUX_s_1_2_2(nor_342_nl, or_tmp_1021, nand_29_cse);
  assign nor_343_nl = ~(and_dcpl_111 | (~ mux_tmp_404));
  assign mux_tmp_405 = MUX_s_1_2_2(nor_343_nl, mux_tmp_404, nand_36_cse);
  assign and_943_nl = nand_267_cse & mux_tmp_405;
  assign mux_tmp_406 = MUX_s_1_2_2(and_943_nl, mux_tmp_405, or_1066_cse);
  assign and_944_nl = nand_79_cse & mux_tmp_406;
  assign mux_tmp_407 = MUX_s_1_2_2(and_944_nl, mux_tmp_406, or_1057_cse);
  assign and_945_nl = nand_274_cse & mux_tmp_407;
  assign mux_tmp_408 = MUX_s_1_2_2(and_945_nl, mux_tmp_407, or_1050_cse);
  assign and_946_nl = nand_84_cse & mux_tmp_408;
  assign mux_tmp_409 = MUX_s_1_2_2(and_946_nl, mux_tmp_408, or_1045_cse);
  assign nor_344_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_409));
  assign mux_412_nl = MUX_s_1_2_2(nor_344_nl, mux_tmp_409, nand_57_cse);
  assign and_dcpl_690 = mux_412_nl & and_dcpl_58 & and_dcpl_77 & (rem_12cyc_st_8_1_0[0]);
  assign nand_21_cse = ~((rem_12cyc_st_8_1_0==2'b11) & (rem_12cyc_st_8_3_2==2'b10));
  assign nor_338_nl = ~(and_dcpl_57 | (~ or_tmp_1021));
  assign mux_tmp_411 = MUX_s_1_2_2(nor_338_nl, or_tmp_1021, nand_21_cse);
  assign nor_339_nl = ~(and_dcpl_84 | (~ mux_tmp_411));
  assign mux_tmp_412 = MUX_s_1_2_2(nor_339_nl, mux_tmp_411, nand_29_cse);
  assign nor_340_nl = ~(and_dcpl_111 | (~ mux_tmp_412));
  assign mux_tmp_413 = MUX_s_1_2_2(nor_340_nl, mux_tmp_412, nand_36_cse);
  assign and_939_nl = nand_267_cse & mux_tmp_413;
  assign mux_tmp_414 = MUX_s_1_2_2(and_939_nl, mux_tmp_413, or_1066_cse);
  assign and_940_nl = nand_79_cse & mux_tmp_414;
  assign mux_tmp_415 = MUX_s_1_2_2(and_940_nl, mux_tmp_414, or_1057_cse);
  assign and_941_nl = nand_274_cse & mux_tmp_415;
  assign mux_tmp_416 = MUX_s_1_2_2(and_941_nl, mux_tmp_415, or_1050_cse);
  assign and_942_nl = nand_84_cse & mux_tmp_416;
  assign mux_tmp_417 = MUX_s_1_2_2(and_942_nl, mux_tmp_416, or_1045_cse);
  assign nor_341_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_417));
  assign mux_420_nl = MUX_s_1_2_2(nor_341_nl, mux_tmp_417, nand_57_cse);
  assign and_dcpl_693 = mux_420_nl & and_dcpl_31 & and_dcpl_50 & (rem_12cyc_st_9_1_0[0]);
  assign nor_333_nl = ~(and_dcpl_30 | (~ or_tmp_1021));
  assign nand_12_nl = ~((rem_12cyc_st_9_1_0==2'b11) & (rem_12cyc_st_9_3_2==2'b10));
  assign mux_tmp_419 = MUX_s_1_2_2(nor_333_nl, or_tmp_1021, nand_12_nl);
  assign nor_334_nl = ~(and_dcpl_57 | (~ mux_tmp_419));
  assign mux_tmp_420 = MUX_s_1_2_2(nor_334_nl, mux_tmp_419, nand_21_cse);
  assign nor_335_nl = ~(and_dcpl_84 | (~ mux_tmp_420));
  assign mux_tmp_421 = MUX_s_1_2_2(nor_335_nl, mux_tmp_420, nand_29_cse);
  assign nor_336_nl = ~(and_dcpl_111 | (~ mux_tmp_421));
  assign mux_tmp_422 = MUX_s_1_2_2(nor_336_nl, mux_tmp_421, nand_36_cse);
  assign and_935_nl = nand_267_cse & mux_tmp_422;
  assign mux_tmp_423 = MUX_s_1_2_2(and_935_nl, mux_tmp_422, or_1066_cse);
  assign and_936_nl = nand_79_cse & mux_tmp_423;
  assign mux_tmp_424 = MUX_s_1_2_2(and_936_nl, mux_tmp_423, or_1057_cse);
  assign and_937_nl = nand_274_cse & mux_tmp_424;
  assign mux_tmp_425 = MUX_s_1_2_2(and_937_nl, mux_tmp_424, or_1050_cse);
  assign and_938_nl = nand_84_cse & mux_tmp_425;
  assign mux_tmp_426 = MUX_s_1_2_2(and_938_nl, mux_tmp_425, or_1045_cse);
  assign nor_337_nl = ~(ccs_ccore_start_rsci_idat | (~ mux_tmp_426));
  assign mux_429_nl = MUX_s_1_2_2(nor_337_nl, mux_tmp_426, nand_57_cse);
  assign and_dcpl_696 = mux_429_nl & and_dcpl_4 & and_dcpl_23 & (rem_12cyc_st_10_1_0[0]);
  assign or_tmp_1122 = (acc_tmp!=2'b10) | nand_222_cse;
  assign nor_324_nl = ~((rem_12cyc_st_10_3_2[1]) | (~ or_tmp_1122));
  assign nand_1_nl = ~(main_stage_0_11 & asn_itm_10 & (rem_12cyc_st_10_1_0==2'b11)
      & (~ (rem_12cyc_st_10_3_2[0])));
  assign mux_tmp_428 = MUX_s_1_2_2(nor_324_nl, or_tmp_1122, nand_1_nl);
  assign nor_325_nl = ~((rem_12cyc_st_6_3_2[1]) | (~ mux_tmp_428));
  assign nand_2_nl = ~(main_stage_0_7 & asn_itm_6 & (rem_12cyc_st_6_1_0==2'b11) &
      (~ (rem_12cyc_st_6_3_2[0])));
  assign mux_tmp_429 = MUX_s_1_2_2(nor_325_nl, mux_tmp_428, nand_2_nl);
  assign nor_326_nl = ~((rem_12cyc_st_5_3_2[1]) | (~ mux_tmp_429));
  assign nand_3_nl = ~(main_stage_0_6 & asn_itm_5 & (rem_12cyc_st_5_1_0==2'b11) &
      (~ (rem_12cyc_st_5_3_2[0])));
  assign mux_tmp_430 = MUX_s_1_2_2(nor_326_nl, mux_tmp_429, nand_3_nl);
  assign nor_327_nl = ~((rem_12cyc_st_4_3_2[1]) | (~ mux_tmp_430));
  assign nand_4_nl = ~(main_stage_0_5 & asn_itm_4 & (rem_12cyc_st_4_1_0==2'b11) &
      (~ (rem_12cyc_st_4_3_2[0])));
  assign mux_tmp_431 = MUX_s_1_2_2(nor_327_nl, mux_tmp_430, nand_4_nl);
  assign nor_328_nl = ~((rem_12cyc_st_3_3_2[1]) | (~ mux_tmp_431));
  assign nand_5_nl = ~(main_stage_0_4 & asn_itm_3 & (rem_12cyc_st_3_1_0==2'b11) &
      (~ (rem_12cyc_st_3_3_2[0])));
  assign mux_tmp_432 = MUX_s_1_2_2(nor_328_nl, mux_tmp_431, nand_5_nl);
  assign nor_329_nl = ~((rem_12cyc_st_2_3_2[1]) | (~ mux_tmp_432));
  assign nand_6_nl = ~(main_stage_0_3 & asn_itm_2 & (rem_12cyc_st_2_1_0==2'b11) &
      (~ (rem_12cyc_st_2_3_2[0])));
  assign mux_tmp_433 = MUX_s_1_2_2(nor_329_nl, mux_tmp_432, nand_6_nl);
  assign nor_330_nl = ~((rem_12cyc_st_9_3_2[1]) | (~ mux_tmp_433));
  assign nand_7_nl = ~(main_stage_0_10 & asn_itm_9 & (rem_12cyc_st_9_1_0==2'b11)
      & (~ (rem_12cyc_st_9_3_2[0])));
  assign mux_tmp_434 = MUX_s_1_2_2(nor_330_nl, mux_tmp_433, nand_7_nl);
  assign nor_331_nl = ~((rem_12cyc_st_8_3_2[1]) | (~ mux_tmp_434));
  assign nand_8_nl = ~(main_stage_0_9 & asn_itm_8 & (rem_12cyc_st_8_1_0==2'b11) &
      (~ (rem_12cyc_st_8_3_2[0])));
  assign mux_tmp_435 = MUX_s_1_2_2(nor_331_nl, mux_tmp_434, nand_8_nl);
  assign nor_332_nl = ~((rem_12cyc_st_7_3_2[1]) | (~ mux_tmp_435));
  assign nand_9_nl = ~(main_stage_0_8 & asn_itm_7 & (rem_12cyc_st_7_1_0==2'b11) &
      (~ (rem_12cyc_st_7_3_2[0])));
  assign mux_tmp_436 = MUX_s_1_2_2(nor_332_nl, mux_tmp_435, nand_9_nl);
  assign and_934_nl = nand_223_cse & mux_tmp_436;
  assign nand_11_nl = ~(main_stage_0_2 & asn_itm_1 & (rem_12cyc_3_2==2'b10));
  assign mux_tmp_437 = MUX_s_1_2_2(and_934_nl, mux_tmp_436, nand_11_nl);
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_64_2_2(result_sva_duc_mx0, qelse_acc_nl, mux_13_nl);
      m_buf_sva_12 <= m_buf_sva_11;
      m_buf_sva_11 <= m_buf_sva_10;
      m_buf_sva_10 <= m_buf_sva_9;
      m_buf_sva_9 <= m_buf_sva_8;
      m_buf_sva_8 <= m_buf_sva_7;
      m_buf_sva_7 <= m_buf_sva_6;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      asn_itm_12 <= 1'b0;
      asn_itm_11 <= 1'b0;
      asn_itm_10 <= 1'b0;
      asn_itm_9 <= 1'b0;
      asn_itm_8 <= 1'b0;
      asn_itm_7 <= 1'b0;
      asn_itm_6 <= 1'b0;
      asn_itm_5 <= 1'b0;
      asn_itm_4 <= 1'b0;
      asn_itm_3 <= 1'b0;
      asn_itm_2 <= 1'b0;
      asn_itm_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
      main_stage_0_4 <= 1'b0;
      main_stage_0_5 <= 1'b0;
      main_stage_0_6 <= 1'b0;
      main_stage_0_7 <= 1'b0;
      main_stage_0_8 <= 1'b0;
      main_stage_0_9 <= 1'b0;
      main_stage_0_10 <= 1'b0;
      main_stage_0_11 <= 1'b0;
      main_stage_0_12 <= 1'b0;
      main_stage_0_13 <= 1'b0;
    end
    else if ( ccs_ccore_en ) begin
      asn_itm_12 <= asn_itm_11;
      asn_itm_11 <= asn_itm_10;
      asn_itm_10 <= asn_itm_9;
      asn_itm_9 <= asn_itm_8;
      asn_itm_8 <= asn_itm_7;
      asn_itm_7 <= asn_itm_6;
      asn_itm_6 <= asn_itm_5;
      asn_itm_5 <= asn_itm_4;
      asn_itm_4 <= asn_itm_3;
      asn_itm_3 <= asn_itm_2;
      asn_itm_2 <= asn_itm_1;
      asn_itm_1 <= ccs_ccore_start_rsci_idat;
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
      main_stage_0_4 <= main_stage_0_3;
      main_stage_0_5 <= main_stage_0_4;
      main_stage_0_6 <= main_stage_0_5;
      main_stage_0_7 <= main_stage_0_6;
      main_stage_0_8 <= main_stage_0_7;
      main_stage_0_9 <= main_stage_0_8;
      main_stage_0_10 <= main_stage_0_9;
      main_stage_0_11 <= main_stage_0_10;
      main_stage_0_12 <= main_stage_0_11;
      main_stage_0_13 <= main_stage_0_12;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      result_sva_duc <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( asn_itm_12 & main_stage_0_13 & ccs_ccore_en & (~((rem_12cyc_st_12_3_2==2'b11)))
        ) begin
      result_sva_duc <= result_sva_duc_mx0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_12_3_2 <= 2'b00;
      rem_12cyc_st_12_1_0 <= 2'b00;
    end
    else if ( and_1203_cse ) begin
      rem_12cyc_st_12_3_2 <= rem_12cyc_st_11_3_2;
      rem_12cyc_st_12_1_0 <= rem_12cyc_st_11_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1173_cse ) begin
      rem_13_cmp_1_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_3_2_63_0, mut_3_3_63_0,
          mut_3_4_63_0, mut_3_5_63_0, mut_3_6_63_0, mut_3_7_63_0, mut_3_8_63_0, mut_3_9_63_0,
          mut_3_10_63_0, mut_3_11_63_0, {and_dcpl_294 , and_dcpl_300 , and_dcpl_306
          , and_dcpl_312 , and_dcpl_318 , and_dcpl_324 , and_dcpl_330 , and_dcpl_336
          , and_dcpl_342 , and_dcpl_348 , and_tmp_35});
      rem_13_cmp_1_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_2_2_63_0, mut_2_3_63_0,
          mut_2_4_63_0, mut_2_5_63_0, mut_2_6_63_0, mut_2_7_63_0, mut_2_8_63_0, mut_2_9_63_0,
          mut_2_10_63_0, mut_2_11_63_0, {and_dcpl_294 , and_dcpl_300 , and_dcpl_306
          , and_dcpl_312 , and_dcpl_318 , and_dcpl_324 , and_dcpl_330 , and_dcpl_336
          , and_dcpl_342 , and_dcpl_348 , and_tmp_35});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1175_cse ) begin
      rem_13_cmp_2_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_5_2_63_0, mut_5_3_63_0,
          mut_5_4_63_0, mut_5_5_63_0, mut_5_6_63_0, mut_5_7_63_0, mut_5_8_63_0, mut_5_9_63_0,
          mut_5_10_63_0, mut_5_11_63_0, {and_dcpl_356 , and_dcpl_360 , and_dcpl_364
          , and_dcpl_368 , and_dcpl_372 , and_dcpl_376 , and_dcpl_379 , and_dcpl_382
          , and_dcpl_385 , and_dcpl_388 , mux_tmp_76});
      rem_13_cmp_2_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_4_2_63_0, mut_4_3_63_0,
          mut_4_4_63_0, mut_4_5_63_0, mut_4_6_63_0, mut_4_7_63_0, mut_4_8_63_0, mut_4_9_63_0,
          mut_4_10_63_0, mut_4_11_63_0, {and_dcpl_356 , and_dcpl_360 , and_dcpl_364
          , and_dcpl_368 , and_dcpl_372 , and_dcpl_376 , and_dcpl_379 , and_dcpl_382
          , and_dcpl_385 , and_dcpl_388 , mux_tmp_76});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1177_cse ) begin
      rem_13_cmp_3_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_7_2_63_0, mut_7_3_63_0,
          mut_7_4_63_0, mut_7_5_63_0, mut_7_6_63_0, mut_7_7_63_0, mut_7_8_63_0, mut_7_9_63_0,
          mut_7_10_63_0, mut_7_11_63_0, {and_dcpl_394 , and_dcpl_397 , and_dcpl_400
          , and_dcpl_403 , and_dcpl_406 , and_dcpl_409 , and_dcpl_413 , and_dcpl_417
          , and_dcpl_421 , and_dcpl_425 , and_tmp_80});
      rem_13_cmp_3_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_6_2_63_0, mut_6_3_63_0,
          mut_6_4_63_0, mut_6_5_63_0, mut_6_6_63_0, mut_6_7_63_0, mut_6_8_63_0, mut_6_9_63_0,
          mut_6_10_63_0, mut_6_11_63_0, {and_dcpl_394 , and_dcpl_397 , and_dcpl_400
          , and_dcpl_403 , and_dcpl_406 , and_dcpl_409 , and_dcpl_413 , and_dcpl_417
          , and_dcpl_421 , and_dcpl_425 , and_tmp_80});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1179_cse ) begin
      rem_13_cmp_4_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_9_2_63_0, mut_9_3_63_0,
          mut_9_4_63_0, mut_9_5_63_0, mut_9_6_63_0, mut_9_7_63_0, mut_9_8_63_0, mut_9_9_63_0,
          mut_9_10_63_0, mut_9_11_63_0, {and_dcpl_431 , and_dcpl_433 , and_dcpl_435
          , and_dcpl_437 , and_dcpl_439 , and_dcpl_442 , and_dcpl_445 , and_dcpl_448
          , and_dcpl_451 , and_dcpl_454 , mux_tmp_141});
      rem_13_cmp_4_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_8_2_63_0, mut_8_3_63_0,
          mut_8_4_63_0, mut_8_5_63_0, mut_8_6_63_0, mut_8_7_63_0, mut_8_8_63_0, mut_8_9_63_0,
          mut_8_10_63_0, mut_8_11_63_0, {and_dcpl_431 , and_dcpl_433 , and_dcpl_435
          , and_dcpl_437 , and_dcpl_439 , and_dcpl_442 , and_dcpl_445 , and_dcpl_448
          , and_dcpl_451 , and_dcpl_454 , mux_tmp_141});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1181_cse ) begin
      rem_13_cmp_5_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_11_2_63_0, mut_11_3_63_0,
          mut_11_4_63_0, mut_11_5_63_0, mut_11_6_63_0, mut_11_7_63_0, mut_11_8_63_0,
          mut_11_9_63_0, mut_11_10_63_0, mut_11_11_63_0, {and_dcpl_461 , and_dcpl_465
          , and_dcpl_469 , and_dcpl_473 , and_dcpl_477 , and_dcpl_480 , and_dcpl_483
          , and_dcpl_486 , and_dcpl_489 , and_dcpl_492 , and_tmp_125});
      rem_13_cmp_5_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_10_2_63_0, mut_10_3_63_0,
          mut_10_4_63_0, mut_10_5_63_0, mut_10_6_63_0, mut_10_7_63_0, mut_10_8_63_0,
          mut_10_9_63_0, mut_10_10_63_0, mut_10_11_63_0, {and_dcpl_461 , and_dcpl_465
          , and_dcpl_469 , and_dcpl_473 , and_dcpl_477 , and_dcpl_480 , and_dcpl_483
          , and_dcpl_486 , and_dcpl_489 , and_dcpl_492 , and_tmp_125});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1183_cse ) begin
      rem_13_cmp_6_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_13_2_63_0, mut_13_3_63_0,
          mut_13_4_63_0, mut_13_5_63_0, mut_13_6_63_0, mut_13_7_63_0, mut_13_8_63_0,
          mut_13_9_63_0, mut_13_10_63_0, mut_13_11_63_0, {and_dcpl_498 , and_dcpl_500
          , and_dcpl_502 , and_dcpl_504 , and_dcpl_506 , and_dcpl_508 , and_dcpl_510
          , and_dcpl_512 , and_dcpl_514 , and_dcpl_516 , mux_tmp_206});
      rem_13_cmp_6_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_12_2_63_0, mut_12_3_63_0,
          mut_12_4_63_0, mut_12_5_63_0, mut_12_6_63_0, mut_12_7_63_0, mut_12_8_63_0,
          mut_12_9_63_0, mut_12_10_63_0, mut_12_11_63_0, {and_dcpl_498 , and_dcpl_500
          , and_dcpl_502 , and_dcpl_504 , and_dcpl_506 , and_dcpl_508 , and_dcpl_510
          , and_dcpl_512 , and_dcpl_514 , and_dcpl_516 , mux_tmp_206});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1185_cse ) begin
      rem_13_cmp_7_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_15_2_63_0, mut_15_3_63_0,
          mut_15_4_63_0, mut_15_5_63_0, mut_15_6_63_0, mut_15_7_63_0, mut_15_8_63_0,
          mut_15_9_63_0, mut_15_10_63_0, mut_15_11_63_0, {and_dcpl_520 , and_dcpl_523
          , and_dcpl_526 , and_dcpl_529 , and_dcpl_532 , and_dcpl_534 , and_dcpl_536
          , and_dcpl_538 , and_dcpl_540 , and_dcpl_542 , and_tmp_170});
      rem_13_cmp_7_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_14_2_63_0, mut_14_3_63_0,
          mut_14_4_63_0, mut_14_5_63_0, mut_14_6_63_0, mut_14_7_63_0, mut_14_8_63_0,
          mut_14_9_63_0, mut_14_10_63_0, mut_14_11_63_0, {and_dcpl_520 , and_dcpl_523
          , and_dcpl_526 , and_dcpl_529 , and_dcpl_532 , and_dcpl_534 , and_dcpl_536
          , and_dcpl_538 , and_dcpl_540 , and_dcpl_542 , and_tmp_170});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1187_cse ) begin
      rem_13_cmp_8_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_17_2_63_0, mut_17_3_63_0,
          mut_17_4_63_0, mut_17_5_63_0, mut_17_6_63_0, mut_17_7_63_0, mut_17_8_63_0,
          mut_17_9_63_0, mut_17_10_63_0, mut_17_11_63_0, {and_dcpl_546 , and_dcpl_548
          , and_dcpl_550 , and_dcpl_552 , and_dcpl_554 , and_dcpl_556 , and_dcpl_558
          , and_dcpl_560 , and_dcpl_562 , and_dcpl_564 , mux_tmp_271});
      rem_13_cmp_8_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_16_2_63_0, mut_16_3_63_0,
          mut_16_4_63_0, mut_16_5_63_0, mut_16_6_63_0, mut_16_7_63_0, mut_16_8_63_0,
          mut_16_9_63_0, mut_16_10_63_0, mut_16_11_63_0, {and_dcpl_546 , and_dcpl_548
          , and_dcpl_550 , and_dcpl_552 , and_dcpl_554 , and_dcpl_556 , and_dcpl_558
          , and_dcpl_560 , and_dcpl_562 , and_dcpl_564 , mux_tmp_271});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1189_cse ) begin
      rem_13_cmp_9_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_19_2_63_0, mut_19_3_63_0,
          mut_19_4_63_0, mut_19_5_63_0, mut_19_6_63_0, mut_19_7_63_0, mut_19_8_63_0,
          mut_19_9_63_0, mut_19_10_63_0, mut_19_11_63_0, {and_dcpl_569 , and_dcpl_573
          , and_dcpl_577 , and_dcpl_581 , and_dcpl_585 , and_dcpl_589 , and_dcpl_593
          , and_dcpl_597 , and_dcpl_601 , and_dcpl_605 , and_tmp_206});
      rem_13_cmp_9_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_18_2_63_0, mut_18_3_63_0,
          mut_18_4_63_0, mut_18_5_63_0, mut_18_6_63_0, mut_18_7_63_0, mut_18_8_63_0,
          mut_18_9_63_0, mut_18_10_63_0, mut_18_11_63_0, {and_dcpl_569 , and_dcpl_573
          , and_dcpl_577 , and_dcpl_581 , and_dcpl_585 , and_dcpl_589 , and_dcpl_593
          , and_dcpl_597 , and_dcpl_601 , and_dcpl_605 , and_tmp_206});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1191_cse ) begin
      rem_13_cmp_10_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_21_2_63_0, mut_21_3_63_0,
          mut_21_4_63_0, mut_21_5_63_0, mut_21_6_63_0, mut_21_7_63_0, mut_21_8_63_0,
          mut_21_9_63_0, mut_21_10_63_0, mut_21_11_63_0, {and_dcpl_610 , and_dcpl_612
          , and_dcpl_614 , and_dcpl_616 , and_dcpl_618 , and_dcpl_622 , and_dcpl_625
          , and_dcpl_628 , and_dcpl_631 , and_dcpl_634 , mux_tmp_354});
      rem_13_cmp_10_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_20_2_63_0, mut_20_3_63_0,
          mut_20_4_63_0, mut_20_5_63_0, mut_20_6_63_0, mut_20_7_63_0, mut_20_8_63_0,
          mut_20_9_63_0, mut_20_10_63_0, mut_20_11_63_0, {and_dcpl_610 , and_dcpl_612
          , and_dcpl_614 , and_dcpl_616 , and_dcpl_618 , and_dcpl_622 , and_dcpl_625
          , and_dcpl_628 , and_dcpl_631 , and_dcpl_634 , mux_tmp_354});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1193_cse ) begin
      rem_13_cmp_11_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_23_2_63_0, mut_23_3_63_0,
          mut_23_4_63_0, mut_23_5_63_0, mut_23_6_63_0, mut_23_7_63_0, mut_23_8_63_0,
          mut_23_9_63_0, mut_23_10_63_0, mut_23_11_63_0, {and_dcpl_638 , and_dcpl_641
          , and_dcpl_644 , and_dcpl_647 , and_dcpl_650 , and_dcpl_653 , and_dcpl_657
          , and_dcpl_661 , and_dcpl_665 , and_dcpl_669 , and_tmp_233});
      rem_13_cmp_11_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_22_2_63_0, mut_22_3_63_0,
          mut_22_4_63_0, mut_22_5_63_0, mut_22_6_63_0, mut_22_7_63_0, mut_22_8_63_0,
          mut_22_9_63_0, mut_22_10_63_0, mut_22_11_63_0, {and_dcpl_638 , and_dcpl_641
          , and_dcpl_644 , and_dcpl_647 , and_dcpl_650 , and_dcpl_653 , and_dcpl_657
          , and_dcpl_661 , and_dcpl_665 , and_dcpl_669 , and_tmp_233});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1195_cse ) begin
      rem_13_cmp_b_63_0 <= MUX1HOT_v_64_11_2(m_rsci_idat, mut_1_2_63_0, mut_1_3_63_0,
          mut_1_4_63_0, mut_1_5_63_0, mut_1_6_63_0, mut_1_7_63_0, mut_1_8_63_0, mut_1_9_63_0,
          mut_1_10_63_0, mut_1_11_63_0, {and_dcpl_673 , and_dcpl_675 , and_dcpl_677
          , and_dcpl_679 , and_dcpl_681 , and_dcpl_684 , and_dcpl_687 , and_dcpl_690
          , and_dcpl_693 , and_dcpl_696 , mux_tmp_437});
      rem_13_cmp_a_63_0 <= MUX1HOT_v_64_11_2(base_rsci_idat, mut_2_63_0, mut_3_63_0,
          mut_4_63_0, mut_5_63_0, mut_6_63_0, mut_7_63_0, mut_8_63_0, mut_9_63_0,
          mut_10_63_0, mut_11_63_0, {and_dcpl_673 , and_dcpl_675 , and_dcpl_677 ,
          and_dcpl_679 , and_dcpl_681 , and_dcpl_684 , and_dcpl_687 , and_dcpl_690
          , and_dcpl_693 , and_dcpl_696 , mux_tmp_437});
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1205_cse ) begin
      mut_3_11_63_0 <= mut_3_10_63_0;
      mut_2_11_63_0 <= mut_2_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1207_cse ) begin
      mut_5_11_63_0 <= mut_5_10_63_0;
      mut_4_11_63_0 <= mut_4_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1209_cse ) begin
      mut_7_11_63_0 <= mut_7_10_63_0;
      mut_6_11_63_0 <= mut_6_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1211_cse ) begin
      mut_9_11_63_0 <= mut_9_10_63_0;
      mut_8_11_63_0 <= mut_8_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1213_cse ) begin
      mut_11_11_63_0 <= mut_11_10_63_0;
      mut_10_11_63_0 <= mut_10_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1215_cse ) begin
      mut_13_11_63_0 <= mut_13_10_63_0;
      mut_12_11_63_0 <= mut_12_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1217_cse ) begin
      mut_15_11_63_0 <= mut_15_10_63_0;
      mut_14_11_63_0 <= mut_14_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1219_cse ) begin
      mut_17_11_63_0 <= mut_17_10_63_0;
      mut_16_11_63_0 <= mut_16_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1221_cse ) begin
      mut_19_11_63_0 <= mut_19_10_63_0;
      mut_18_11_63_0 <= mut_18_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1223_cse ) begin
      mut_21_11_63_0 <= mut_21_10_63_0;
      mut_20_11_63_0 <= mut_20_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1225_cse ) begin
      mut_23_11_63_0 <= mut_23_10_63_0;
      mut_22_11_63_0 <= mut_22_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1227_cse ) begin
      mut_1_11_63_0 <= mut_1_10_63_0;
      mut_11_63_0 <= mut_10_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_11_3_2 <= 2'b00;
      rem_12cyc_st_11_1_0 <= 2'b00;
    end
    else if ( and_1229_cse ) begin
      rem_12cyc_st_11_3_2 <= rem_12cyc_st_10_3_2;
      rem_12cyc_st_11_1_0 <= rem_12cyc_st_10_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1231_cse ) begin
      mut_3_10_63_0 <= mut_3_9_63_0;
      mut_2_10_63_0 <= mut_2_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1233_cse ) begin
      mut_5_10_63_0 <= mut_5_9_63_0;
      mut_4_10_63_0 <= mut_4_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1235_cse ) begin
      mut_7_10_63_0 <= mut_7_9_63_0;
      mut_6_10_63_0 <= mut_6_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1237_cse ) begin
      mut_9_10_63_0 <= mut_9_9_63_0;
      mut_8_10_63_0 <= mut_8_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1239_cse ) begin
      mut_11_10_63_0 <= mut_11_9_63_0;
      mut_10_10_63_0 <= mut_10_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1241_cse ) begin
      mut_13_10_63_0 <= mut_13_9_63_0;
      mut_12_10_63_0 <= mut_12_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1243_cse ) begin
      mut_15_10_63_0 <= mut_15_9_63_0;
      mut_14_10_63_0 <= mut_14_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1245_cse ) begin
      mut_17_10_63_0 <= mut_17_9_63_0;
      mut_16_10_63_0 <= mut_16_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1247_cse ) begin
      mut_19_10_63_0 <= mut_19_9_63_0;
      mut_18_10_63_0 <= mut_18_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1249_cse ) begin
      mut_21_10_63_0 <= mut_21_9_63_0;
      mut_20_10_63_0 <= mut_20_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1251_cse ) begin
      mut_23_10_63_0 <= mut_23_9_63_0;
      mut_22_10_63_0 <= mut_22_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1253_cse ) begin
      mut_1_10_63_0 <= mut_1_9_63_0;
      mut_10_63_0 <= mut_9_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_10_3_2 <= 2'b00;
      rem_12cyc_st_10_1_0 <= 2'b00;
    end
    else if ( and_1255_cse ) begin
      rem_12cyc_st_10_3_2 <= rem_12cyc_st_9_3_2;
      rem_12cyc_st_10_1_0 <= rem_12cyc_st_9_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1257_cse ) begin
      mut_3_9_63_0 <= mut_3_8_63_0;
      mut_2_9_63_0 <= mut_2_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1259_cse ) begin
      mut_5_9_63_0 <= mut_5_8_63_0;
      mut_4_9_63_0 <= mut_4_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1261_cse ) begin
      mut_7_9_63_0 <= mut_7_8_63_0;
      mut_6_9_63_0 <= mut_6_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1263_cse ) begin
      mut_9_9_63_0 <= mut_9_8_63_0;
      mut_8_9_63_0 <= mut_8_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1265_cse ) begin
      mut_11_9_63_0 <= mut_11_8_63_0;
      mut_10_9_63_0 <= mut_10_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1267_cse ) begin
      mut_13_9_63_0 <= mut_13_8_63_0;
      mut_12_9_63_0 <= mut_12_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1269_cse ) begin
      mut_15_9_63_0 <= mut_15_8_63_0;
      mut_14_9_63_0 <= mut_14_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1271_cse ) begin
      mut_17_9_63_0 <= mut_17_8_63_0;
      mut_16_9_63_0 <= mut_16_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1273_cse ) begin
      mut_19_9_63_0 <= mut_19_8_63_0;
      mut_18_9_63_0 <= mut_18_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1275_cse ) begin
      mut_21_9_63_0 <= mut_21_8_63_0;
      mut_20_9_63_0 <= mut_20_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1277_cse ) begin
      mut_23_9_63_0 <= mut_23_8_63_0;
      mut_22_9_63_0 <= mut_22_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1279_cse ) begin
      mut_1_9_63_0 <= mut_1_8_63_0;
      mut_9_63_0 <= mut_8_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_9_3_2 <= 2'b00;
      rem_12cyc_st_9_1_0 <= 2'b00;
    end
    else if ( and_1281_cse ) begin
      rem_12cyc_st_9_3_2 <= rem_12cyc_st_8_3_2;
      rem_12cyc_st_9_1_0 <= rem_12cyc_st_8_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1283_cse ) begin
      mut_3_8_63_0 <= mut_3_7_63_0;
      mut_2_8_63_0 <= mut_2_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1285_cse ) begin
      mut_5_8_63_0 <= mut_5_7_63_0;
      mut_4_8_63_0 <= mut_4_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1287_cse ) begin
      mut_7_8_63_0 <= mut_7_7_63_0;
      mut_6_8_63_0 <= mut_6_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1289_cse ) begin
      mut_9_8_63_0 <= mut_9_7_63_0;
      mut_8_8_63_0 <= mut_8_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1291_cse ) begin
      mut_11_8_63_0 <= mut_11_7_63_0;
      mut_10_8_63_0 <= mut_10_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1293_cse ) begin
      mut_13_8_63_0 <= mut_13_7_63_0;
      mut_12_8_63_0 <= mut_12_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1295_cse ) begin
      mut_15_8_63_0 <= mut_15_7_63_0;
      mut_14_8_63_0 <= mut_14_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1297_cse ) begin
      mut_17_8_63_0 <= mut_17_7_63_0;
      mut_16_8_63_0 <= mut_16_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1299_cse ) begin
      mut_19_8_63_0 <= mut_19_7_63_0;
      mut_18_8_63_0 <= mut_18_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1301_cse ) begin
      mut_21_8_63_0 <= mut_21_7_63_0;
      mut_20_8_63_0 <= mut_20_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1303_cse ) begin
      mut_23_8_63_0 <= mut_23_7_63_0;
      mut_22_8_63_0 <= mut_22_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1305_cse ) begin
      mut_1_8_63_0 <= mut_1_7_63_0;
      mut_8_63_0 <= mut_7_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_8_3_2 <= 2'b00;
      rem_12cyc_st_8_1_0 <= 2'b00;
    end
    else if ( and_1307_cse ) begin
      rem_12cyc_st_8_3_2 <= rem_12cyc_st_7_3_2;
      rem_12cyc_st_8_1_0 <= rem_12cyc_st_7_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1309_cse ) begin
      mut_3_7_63_0 <= mut_3_6_63_0;
      mut_2_7_63_0 <= mut_2_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1311_cse ) begin
      mut_5_7_63_0 <= mut_5_6_63_0;
      mut_4_7_63_0 <= mut_4_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1313_cse ) begin
      mut_7_7_63_0 <= mut_7_6_63_0;
      mut_6_7_63_0 <= mut_6_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1315_cse ) begin
      mut_9_7_63_0 <= mut_9_6_63_0;
      mut_8_7_63_0 <= mut_8_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1317_cse ) begin
      mut_11_7_63_0 <= mut_11_6_63_0;
      mut_10_7_63_0 <= mut_10_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1319_cse ) begin
      mut_13_7_63_0 <= mut_13_6_63_0;
      mut_12_7_63_0 <= mut_12_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1321_cse ) begin
      mut_15_7_63_0 <= mut_15_6_63_0;
      mut_14_7_63_0 <= mut_14_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1323_cse ) begin
      mut_17_7_63_0 <= mut_17_6_63_0;
      mut_16_7_63_0 <= mut_16_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1325_cse ) begin
      mut_19_7_63_0 <= mut_19_6_63_0;
      mut_18_7_63_0 <= mut_18_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1327_cse ) begin
      mut_21_7_63_0 <= mut_21_6_63_0;
      mut_20_7_63_0 <= mut_20_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1329_cse ) begin
      mut_23_7_63_0 <= mut_23_6_63_0;
      mut_22_7_63_0 <= mut_22_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1331_cse ) begin
      mut_1_7_63_0 <= mut_1_6_63_0;
      mut_7_63_0 <= mut_6_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_7_3_2 <= 2'b00;
      rem_12cyc_st_7_1_0 <= 2'b00;
    end
    else if ( and_1333_cse ) begin
      rem_12cyc_st_7_3_2 <= rem_12cyc_st_6_3_2;
      rem_12cyc_st_7_1_0 <= rem_12cyc_st_6_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1335_cse ) begin
      mut_3_6_63_0 <= mut_3_5_63_0;
      mut_2_6_63_0 <= mut_2_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1337_cse ) begin
      mut_5_6_63_0 <= mut_5_5_63_0;
      mut_4_6_63_0 <= mut_4_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1339_cse ) begin
      mut_7_6_63_0 <= mut_7_5_63_0;
      mut_6_6_63_0 <= mut_6_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1341_cse ) begin
      mut_9_6_63_0 <= mut_9_5_63_0;
      mut_8_6_63_0 <= mut_8_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1343_cse ) begin
      mut_11_6_63_0 <= mut_11_5_63_0;
      mut_10_6_63_0 <= mut_10_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1345_cse ) begin
      mut_13_6_63_0 <= mut_13_5_63_0;
      mut_12_6_63_0 <= mut_12_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1347_cse ) begin
      mut_15_6_63_0 <= mut_15_5_63_0;
      mut_14_6_63_0 <= mut_14_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1349_cse ) begin
      mut_17_6_63_0 <= mut_17_5_63_0;
      mut_16_6_63_0 <= mut_16_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1351_cse ) begin
      mut_19_6_63_0 <= mut_19_5_63_0;
      mut_18_6_63_0 <= mut_18_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1353_cse ) begin
      mut_21_6_63_0 <= mut_21_5_63_0;
      mut_20_6_63_0 <= mut_20_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1355_cse ) begin
      mut_23_6_63_0 <= mut_23_5_63_0;
      mut_22_6_63_0 <= mut_22_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1357_cse ) begin
      mut_1_6_63_0 <= mut_1_5_63_0;
      mut_6_63_0 <= mut_5_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1359_cse ) begin
      m_buf_sva_6 <= m_buf_sva_5;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_6_3_2 <= 2'b00;
      rem_12cyc_st_6_1_0 <= 2'b00;
    end
    else if ( and_1359_cse ) begin
      rem_12cyc_st_6_3_2 <= rem_12cyc_st_5_3_2;
      rem_12cyc_st_6_1_0 <= rem_12cyc_st_5_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1361_cse ) begin
      mut_3_5_63_0 <= mut_3_4_63_0;
      mut_2_5_63_0 <= mut_2_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1363_cse ) begin
      mut_5_5_63_0 <= mut_5_4_63_0;
      mut_4_5_63_0 <= mut_4_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1365_cse ) begin
      mut_7_5_63_0 <= mut_7_4_63_0;
      mut_6_5_63_0 <= mut_6_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1367_cse ) begin
      mut_9_5_63_0 <= mut_9_4_63_0;
      mut_8_5_63_0 <= mut_8_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1369_cse ) begin
      mut_11_5_63_0 <= mut_11_4_63_0;
      mut_10_5_63_0 <= mut_10_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1371_cse ) begin
      mut_13_5_63_0 <= mut_13_4_63_0;
      mut_12_5_63_0 <= mut_12_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1373_cse ) begin
      mut_15_5_63_0 <= mut_15_4_63_0;
      mut_14_5_63_0 <= mut_14_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1375_cse ) begin
      mut_17_5_63_0 <= mut_17_4_63_0;
      mut_16_5_63_0 <= mut_16_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1377_cse ) begin
      mut_19_5_63_0 <= mut_19_4_63_0;
      mut_18_5_63_0 <= mut_18_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1379_cse ) begin
      mut_21_5_63_0 <= mut_21_4_63_0;
      mut_20_5_63_0 <= mut_20_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1381_cse ) begin
      mut_23_5_63_0 <= mut_23_4_63_0;
      mut_22_5_63_0 <= mut_22_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1383_cse ) begin
      mut_1_5_63_0 <= mut_1_4_63_0;
      mut_5_63_0 <= mut_4_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1385_cse ) begin
      m_buf_sva_5 <= m_buf_sva_4;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_5_3_2 <= 2'b00;
      rem_12cyc_st_5_1_0 <= 2'b00;
    end
    else if ( and_1385_cse ) begin
      rem_12cyc_st_5_3_2 <= rem_12cyc_st_4_3_2;
      rem_12cyc_st_5_1_0 <= rem_12cyc_st_4_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1387_cse ) begin
      mut_3_4_63_0 <= mut_3_3_63_0;
      mut_2_4_63_0 <= mut_2_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1389_cse ) begin
      mut_5_4_63_0 <= mut_5_3_63_0;
      mut_4_4_63_0 <= mut_4_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1391_cse ) begin
      mut_7_4_63_0 <= mut_7_3_63_0;
      mut_6_4_63_0 <= mut_6_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1393_cse ) begin
      mut_9_4_63_0 <= mut_9_3_63_0;
      mut_8_4_63_0 <= mut_8_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1395_cse ) begin
      mut_11_4_63_0 <= mut_11_3_63_0;
      mut_10_4_63_0 <= mut_10_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1397_cse ) begin
      mut_13_4_63_0 <= mut_13_3_63_0;
      mut_12_4_63_0 <= mut_12_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1399_cse ) begin
      mut_15_4_63_0 <= mut_15_3_63_0;
      mut_14_4_63_0 <= mut_14_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1401_cse ) begin
      mut_17_4_63_0 <= mut_17_3_63_0;
      mut_16_4_63_0 <= mut_16_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1403_cse ) begin
      mut_19_4_63_0 <= mut_19_3_63_0;
      mut_18_4_63_0 <= mut_18_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1405_cse ) begin
      mut_21_4_63_0 <= mut_21_3_63_0;
      mut_20_4_63_0 <= mut_20_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1407_cse ) begin
      mut_23_4_63_0 <= mut_23_3_63_0;
      mut_22_4_63_0 <= mut_22_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1409_cse ) begin
      mut_1_4_63_0 <= mut_1_3_63_0;
      mut_4_63_0 <= mut_3_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1411_cse ) begin
      m_buf_sva_4 <= m_buf_sva_3;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_4_3_2 <= 2'b00;
      rem_12cyc_st_4_1_0 <= 2'b00;
    end
    else if ( and_1411_cse ) begin
      rem_12cyc_st_4_3_2 <= rem_12cyc_st_3_3_2;
      rem_12cyc_st_4_1_0 <= rem_12cyc_st_3_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1413_cse ) begin
      mut_3_3_63_0 <= mut_3_2_63_0;
      mut_2_3_63_0 <= mut_2_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1415_cse ) begin
      mut_5_3_63_0 <= mut_5_2_63_0;
      mut_4_3_63_0 <= mut_4_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1417_cse ) begin
      mut_7_3_63_0 <= mut_7_2_63_0;
      mut_6_3_63_0 <= mut_6_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1419_cse ) begin
      mut_9_3_63_0 <= mut_9_2_63_0;
      mut_8_3_63_0 <= mut_8_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1421_cse ) begin
      mut_11_3_63_0 <= mut_11_2_63_0;
      mut_10_3_63_0 <= mut_10_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1423_cse ) begin
      mut_13_3_63_0 <= mut_13_2_63_0;
      mut_12_3_63_0 <= mut_12_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1425_cse ) begin
      mut_15_3_63_0 <= mut_15_2_63_0;
      mut_14_3_63_0 <= mut_14_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1427_cse ) begin
      mut_17_3_63_0 <= mut_17_2_63_0;
      mut_16_3_63_0 <= mut_16_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1429_cse ) begin
      mut_19_3_63_0 <= mut_19_2_63_0;
      mut_18_3_63_0 <= mut_18_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1431_cse ) begin
      mut_21_3_63_0 <= mut_21_2_63_0;
      mut_20_3_63_0 <= mut_20_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1433_cse ) begin
      mut_23_3_63_0 <= mut_23_2_63_0;
      mut_22_3_63_0 <= mut_22_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1435_cse ) begin
      mut_1_3_63_0 <= mut_1_2_63_0;
      mut_3_63_0 <= mut_2_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1437_cse ) begin
      m_buf_sva_3 <= m_buf_sva_2;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_3_3_2 <= 2'b00;
      rem_12cyc_st_3_1_0 <= 2'b00;
    end
    else if ( and_1437_cse ) begin
      rem_12cyc_st_3_3_2 <= rem_12cyc_st_2_3_2;
      rem_12cyc_st_3_1_0 <= rem_12cyc_st_2_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1439_cse ) begin
      mut_3_2_63_0 <= rem_13_cmp_1_b_63_0;
      mut_2_2_63_0 <= rem_13_cmp_1_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1441_cse ) begin
      mut_5_2_63_0 <= rem_13_cmp_2_b_63_0;
      mut_4_2_63_0 <= rem_13_cmp_2_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1443_cse ) begin
      mut_7_2_63_0 <= rem_13_cmp_3_b_63_0;
      mut_6_2_63_0 <= rem_13_cmp_3_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1445_cse ) begin
      mut_9_2_63_0 <= rem_13_cmp_4_b_63_0;
      mut_8_2_63_0 <= rem_13_cmp_4_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1447_cse ) begin
      mut_11_2_63_0 <= rem_13_cmp_5_b_63_0;
      mut_10_2_63_0 <= rem_13_cmp_5_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1449_cse ) begin
      mut_13_2_63_0 <= rem_13_cmp_6_b_63_0;
      mut_12_2_63_0 <= rem_13_cmp_6_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1451_cse ) begin
      mut_15_2_63_0 <= rem_13_cmp_7_b_63_0;
      mut_14_2_63_0 <= rem_13_cmp_7_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1453_cse ) begin
      mut_17_2_63_0 <= rem_13_cmp_8_b_63_0;
      mut_16_2_63_0 <= rem_13_cmp_8_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1455_cse ) begin
      mut_19_2_63_0 <= rem_13_cmp_9_b_63_0;
      mut_18_2_63_0 <= rem_13_cmp_9_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1457_cse ) begin
      mut_21_2_63_0 <= rem_13_cmp_10_b_63_0;
      mut_20_2_63_0 <= rem_13_cmp_10_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1459_cse ) begin
      mut_23_2_63_0 <= rem_13_cmp_11_b_63_0;
      mut_22_2_63_0 <= rem_13_cmp_11_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1461_cse ) begin
      mut_1_2_63_0 <= rem_13_cmp_b_63_0;
      mut_2_63_0 <= rem_13_cmp_a_63_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1463_cse ) begin
      m_buf_sva_2 <= m_buf_sva_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_st_2_3_2 <= 2'b00;
      rem_12cyc_st_2_1_0 <= 2'b00;
    end
    else if ( and_1463_cse ) begin
      rem_12cyc_st_2_3_2 <= rem_12cyc_3_2;
      rem_12cyc_st_2_1_0 <= rem_12cyc_1_0;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( and_1197_cse ) begin
      m_buf_sva_1 <= m_rsci_idat;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_12cyc_3_2 <= 2'b00;
      rem_12cyc_1_0 <= 2'b00;
    end
    else if ( and_1197_cse ) begin
      rem_12cyc_3_2 <= acc_tmp;
      rem_12cyc_1_0 <= acc_1_tmp[1:0];
    end
  end
  assign nl_qelse_acc_nl = result_sva_duc_mx0 + m_buf_sva_12;
  assign qelse_acc_nl = nl_qelse_acc_nl[63:0];
  assign mux_10_nl = MUX_s_1_2_2((rem_13_cmp_1_z[63]), (rem_13_cmp_3_z[63]), rem_12cyc_st_12_1_0[1]);
  assign mux_9_nl = MUX_s_1_2_2((rem_13_cmp_2_z[63]), (rem_13_cmp_4_z[63]), rem_12cyc_st_12_1_0[1]);
  assign mux_11_nl = MUX_s_1_2_2(mux_10_nl, mux_9_nl, rem_12cyc_st_12_1_0[0]);
  assign mux_7_nl = MUX_s_1_2_2((rem_13_cmp_9_z[63]), (rem_13_cmp_11_z[63]), rem_12cyc_st_12_1_0[1]);
  assign mux_6_nl = MUX_s_1_2_2((rem_13_cmp_10_z[63]), (rem_13_cmp_z[63]), rem_12cyc_st_12_1_0[1]);
  assign mux_8_nl = MUX_s_1_2_2(mux_7_nl, mux_6_nl, rem_12cyc_st_12_1_0[0]);
  assign mux_12_nl = MUX_s_1_2_2(mux_11_nl, mux_8_nl, rem_12cyc_st_12_3_2[1]);
  assign mux_3_nl = MUX_s_1_2_2((rem_13_cmp_5_z[63]), (rem_13_cmp_7_z[63]), rem_12cyc_st_12_1_0[1]);
  assign mux_2_nl = MUX_s_1_2_2((rem_13_cmp_6_z[63]), (rem_13_cmp_8_z[63]), rem_12cyc_st_12_1_0[1]);
  assign mux_4_nl = MUX_s_1_2_2(mux_3_nl, mux_2_nl, rem_12cyc_st_12_1_0[0]);
  assign mux_5_nl = MUX_s_1_2_2(mux_4_nl, (result_sva_duc[63]), rem_12cyc_st_12_3_2[1]);
  assign mux_13_nl = MUX_s_1_2_2(mux_12_nl, mux_5_nl, rem_12cyc_st_12_3_2[0]);

  function automatic [63:0] MUX1HOT_v_64_11_2;
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
    input [10:0] sel;
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
    MUX1HOT_v_64_11_2 = result;
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


  function automatic [1:0] conv_u2u_1_2 ;
    input [0:0]  vector ;
  begin
    conv_u2u_1_2 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    modulo
// ------------------------------------------------------------------


module modulo (
  base_rsc_dat, m_rsc_dat, return_rsc_z, ccs_ccore_start_rsc_dat, ccs_ccore_clk,
      ccs_ccore_srst, ccs_ccore_en
);
  input [63:0] base_rsc_dat;
  input [63:0] m_rsc_dat;
  output [63:0] return_rsc_z;
  input ccs_ccore_start_rsc_dat;
  input ccs_ccore_clk;
  input ccs_ccore_srst;
  input ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  modulo_core modulo_core_inst (
      .base_rsc_dat(base_rsc_dat),
      .m_rsc_dat(m_rsc_dat),
      .return_rsc_z(return_rsc_z),
      .ccs_ccore_start_rsc_dat(ccs_ccore_start_rsc_dat),
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_srst(ccs_ccore_srst),
      .ccs_ccore_en(ccs_ccore_en)
    );
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
//  Generated date: Sun Aug  1 15:45:48 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen
    (
  q, radr, q_d, radr_d, readA_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output [9:0] radr;
  output [63:0] q_d;
  input [9:0] radr_d;
  input readA_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
// ------------------------------------------------------------------


module inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen
    (
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
//  Design Unit:    inPlaceNTT_DIF_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module inPlaceNTT_DIF_core_core_fsm (
  clk, rst, fsm_output, COMP_LOOP_C_31_tr0, VEC_LOOP_C_0_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [36:0] fsm_output;
  reg [36:0] fsm_output;
  input COMP_LOOP_C_31_tr0;
  input VEC_LOOP_C_0_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for inPlaceNTT_DIF_core_core_fsm_1
  parameter
    main_C_0 = 6'd0,
    STAGE_LOOP_C_0 = 6'd1,
    COMP_LOOP_C_0 = 6'd2,
    COMP_LOOP_C_1 = 6'd3,
    COMP_LOOP_C_2 = 6'd4,
    COMP_LOOP_C_3 = 6'd5,
    COMP_LOOP_C_4 = 6'd6,
    COMP_LOOP_C_5 = 6'd7,
    COMP_LOOP_C_6 = 6'd8,
    COMP_LOOP_C_7 = 6'd9,
    COMP_LOOP_C_8 = 6'd10,
    COMP_LOOP_C_9 = 6'd11,
    COMP_LOOP_C_10 = 6'd12,
    COMP_LOOP_C_11 = 6'd13,
    COMP_LOOP_C_12 = 6'd14,
    COMP_LOOP_C_13 = 6'd15,
    COMP_LOOP_C_14 = 6'd16,
    COMP_LOOP_C_15 = 6'd17,
    COMP_LOOP_C_16 = 6'd18,
    COMP_LOOP_C_17 = 6'd19,
    COMP_LOOP_C_18 = 6'd20,
    COMP_LOOP_C_19 = 6'd21,
    COMP_LOOP_C_20 = 6'd22,
    COMP_LOOP_C_21 = 6'd23,
    COMP_LOOP_C_22 = 6'd24,
    COMP_LOOP_C_23 = 6'd25,
    COMP_LOOP_C_24 = 6'd26,
    COMP_LOOP_C_25 = 6'd27,
    COMP_LOOP_C_26 = 6'd28,
    COMP_LOOP_C_27 = 6'd29,
    COMP_LOOP_C_28 = 6'd30,
    COMP_LOOP_C_29 = 6'd31,
    COMP_LOOP_C_30 = 6'd32,
    COMP_LOOP_C_31 = 6'd33,
    VEC_LOOP_C_0 = 6'd34,
    STAGE_LOOP_C_1 = 6'd35,
    main_C_1 = 6'd36;

  reg [5:0] state_var;
  reg [5:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : inPlaceNTT_DIF_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 37'b0000000000000000000000000000000000010;
        state_var_NS = COMP_LOOP_C_0;
      end
      COMP_LOOP_C_0 : begin
        fsm_output = 37'b0000000000000000000000000000000000100;
        state_var_NS = COMP_LOOP_C_1;
      end
      COMP_LOOP_C_1 : begin
        fsm_output = 37'b0000000000000000000000000000000001000;
        state_var_NS = COMP_LOOP_C_2;
      end
      COMP_LOOP_C_2 : begin
        fsm_output = 37'b0000000000000000000000000000000010000;
        state_var_NS = COMP_LOOP_C_3;
      end
      COMP_LOOP_C_3 : begin
        fsm_output = 37'b0000000000000000000000000000000100000;
        state_var_NS = COMP_LOOP_C_4;
      end
      COMP_LOOP_C_4 : begin
        fsm_output = 37'b0000000000000000000000000000001000000;
        state_var_NS = COMP_LOOP_C_5;
      end
      COMP_LOOP_C_5 : begin
        fsm_output = 37'b0000000000000000000000000000010000000;
        state_var_NS = COMP_LOOP_C_6;
      end
      COMP_LOOP_C_6 : begin
        fsm_output = 37'b0000000000000000000000000000100000000;
        state_var_NS = COMP_LOOP_C_7;
      end
      COMP_LOOP_C_7 : begin
        fsm_output = 37'b0000000000000000000000000001000000000;
        state_var_NS = COMP_LOOP_C_8;
      end
      COMP_LOOP_C_8 : begin
        fsm_output = 37'b0000000000000000000000000010000000000;
        state_var_NS = COMP_LOOP_C_9;
      end
      COMP_LOOP_C_9 : begin
        fsm_output = 37'b0000000000000000000000000100000000000;
        state_var_NS = COMP_LOOP_C_10;
      end
      COMP_LOOP_C_10 : begin
        fsm_output = 37'b0000000000000000000000001000000000000;
        state_var_NS = COMP_LOOP_C_11;
      end
      COMP_LOOP_C_11 : begin
        fsm_output = 37'b0000000000000000000000010000000000000;
        state_var_NS = COMP_LOOP_C_12;
      end
      COMP_LOOP_C_12 : begin
        fsm_output = 37'b0000000000000000000000100000000000000;
        state_var_NS = COMP_LOOP_C_13;
      end
      COMP_LOOP_C_13 : begin
        fsm_output = 37'b0000000000000000000001000000000000000;
        state_var_NS = COMP_LOOP_C_14;
      end
      COMP_LOOP_C_14 : begin
        fsm_output = 37'b0000000000000000000010000000000000000;
        state_var_NS = COMP_LOOP_C_15;
      end
      COMP_LOOP_C_15 : begin
        fsm_output = 37'b0000000000000000000100000000000000000;
        state_var_NS = COMP_LOOP_C_16;
      end
      COMP_LOOP_C_16 : begin
        fsm_output = 37'b0000000000000000001000000000000000000;
        state_var_NS = COMP_LOOP_C_17;
      end
      COMP_LOOP_C_17 : begin
        fsm_output = 37'b0000000000000000010000000000000000000;
        state_var_NS = COMP_LOOP_C_18;
      end
      COMP_LOOP_C_18 : begin
        fsm_output = 37'b0000000000000000100000000000000000000;
        state_var_NS = COMP_LOOP_C_19;
      end
      COMP_LOOP_C_19 : begin
        fsm_output = 37'b0000000000000001000000000000000000000;
        state_var_NS = COMP_LOOP_C_20;
      end
      COMP_LOOP_C_20 : begin
        fsm_output = 37'b0000000000000010000000000000000000000;
        state_var_NS = COMP_LOOP_C_21;
      end
      COMP_LOOP_C_21 : begin
        fsm_output = 37'b0000000000000100000000000000000000000;
        state_var_NS = COMP_LOOP_C_22;
      end
      COMP_LOOP_C_22 : begin
        fsm_output = 37'b0000000000001000000000000000000000000;
        state_var_NS = COMP_LOOP_C_23;
      end
      COMP_LOOP_C_23 : begin
        fsm_output = 37'b0000000000010000000000000000000000000;
        state_var_NS = COMP_LOOP_C_24;
      end
      COMP_LOOP_C_24 : begin
        fsm_output = 37'b0000000000100000000000000000000000000;
        state_var_NS = COMP_LOOP_C_25;
      end
      COMP_LOOP_C_25 : begin
        fsm_output = 37'b0000000001000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_26;
      end
      COMP_LOOP_C_26 : begin
        fsm_output = 37'b0000000010000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_27;
      end
      COMP_LOOP_C_27 : begin
        fsm_output = 37'b0000000100000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_28;
      end
      COMP_LOOP_C_28 : begin
        fsm_output = 37'b0000001000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_29;
      end
      COMP_LOOP_C_29 : begin
        fsm_output = 37'b0000010000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_30;
      end
      COMP_LOOP_C_30 : begin
        fsm_output = 37'b0000100000000000000000000000000000000;
        state_var_NS = COMP_LOOP_C_31;
      end
      COMP_LOOP_C_31 : begin
        fsm_output = 37'b0001000000000000000000000000000000000;
        if ( COMP_LOOP_C_31_tr0 ) begin
          state_var_NS = VEC_LOOP_C_0;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      VEC_LOOP_C_0 : begin
        fsm_output = 37'b0010000000000000000000000000000000000;
        if ( VEC_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = COMP_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 37'b0100000000000000000000000000000000000;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 37'b1000000000000000000000000000000000000;
        state_var_NS = main_C_0;
      end
      // main_C_0
      default : begin
        fsm_output = 37'b0000000000000000000000000000000000001;
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
//  Design Unit:    inPlaceNTT_DIF_core_wait_dp
// ------------------------------------------------------------------


module inPlaceNTT_DIF_core_wait_dp (
  ensig_cgo_iro, ensig_cgo, modulo_cmp_ccs_ccore_en
);
  input ensig_cgo_iro;
  input ensig_cgo;
  output modulo_cmp_ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  assign modulo_cmp_ccs_ccore_en = ensig_cgo | ensig_cgo_iro;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    inPlaceNTT_DIF_core
// ------------------------------------------------------------------


module inPlaceNTT_DIF_core (
  clk, rst, vec_rsc_triosy_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_triosy_lz, twiddle_rsc_triosy_lz,
      vec_rsci_d_d, vec_rsci_q_d, vec_rsci_radr_d, vec_rsci_wadr_d, vec_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      twiddle_rsci_q_d, twiddle_rsci_radr_d, twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d,
      vec_rsci_we_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_lz;
  output [63:0] vec_rsci_d_d;
  input [63:0] vec_rsci_q_d;
  output [9:0] vec_rsci_radr_d;
  output [9:0] vec_rsci_wadr_d;
  output vec_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  input [63:0] twiddle_rsci_q_d;
  output [9:0] twiddle_rsci_radr_d;
  output twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  output vec_rsci_we_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  wire [63:0] modulo_cmp_return_rsc_z;
  wire modulo_cmp_ccs_ccore_en;
  wire [36:0] fsm_output;
  wire and_dcpl_5;
  wire and_dcpl_6;
  wire or_dcpl_2;
  reg exit_COMP_LOOP_sva;
  reg reg_vec_rsc_triosy_obj_ld_cse;
  reg reg_ensig_cgo_cse;
  wire VEC_LOOP_j_or_cse;
  wire and_57_rmff;
  reg [63:0] COMP_LOOP_acc_8_itm;
  reg [63:0] p_sva;
  reg [9:0] COMP_LOOP_acc_1_cse_sva;
  wire [10:0] nl_COMP_LOOP_acc_1_cse_sva;
  reg [9:0] COMP_LOOP_acc_10_cse_10_1_sva;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg [9:0] COMP_LOOP_k_10_0_sva_9_0;
  wire [10:0] z_out;
  wire [63:0] z_out_1;
  wire [127:0] nl_z_out_1;
  wire [10:0] z_out_2;
  wire [10:0] z_out_3;
  wire [11:0] nl_z_out_3;
  reg [10:0] STAGE_LOOP_lshift_psp_sva;
  reg [63:0] COMP_LOOP_tmp_asn_itm;
  reg [9:0] VEC_LOOP_j_10_0_sva_9_0;
  wire [9:0] COMP_LOOP_acc_10_itm_10_1_1;
  wire STAGE_LOOP_acc_itm_4_1;

  wire[0:0] VEC_LOOP_j_not_1_nl;
  wire[0:0] VEC_LOOP_j_not_nl;
  wire[63:0] COMP_LOOP_acc_8_nl;
  wire[64:0] nl_COMP_LOOP_acc_8_nl;
  wire[10:0] COMP_LOOP_acc_10_nl;
  wire[12:0] nl_COMP_LOOP_acc_10_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[63:0] COMP_LOOP_mux_12_nl;
  wire[63:0] COMP_LOOP_mux_13_nl;
  wire[11:0] acc_nl;
  wire[12:0] nl_acc_nl;
  wire[10:0] VEC_LOOP_mux_2_nl;
  wire[0:0] VEC_LOOP_or_1_nl;
  wire[10:0] VEC_LOOP_mux_3_nl;
  wire[9:0] STAGE_LOOP_mux_4_nl;

  // Interconnect Declarations for Component Instantiations 
  wire[63:0] COMP_LOOP_acc_6_nl;
  wire[64:0] nl_COMP_LOOP_acc_6_nl;
  wire [63:0] nl_modulo_cmp_base_rsc_dat;
  assign nl_COMP_LOOP_acc_6_nl = vec_rsci_q_d - COMP_LOOP_acc_8_itm;
  assign COMP_LOOP_acc_6_nl = nl_COMP_LOOP_acc_6_nl[63:0];
  assign nl_modulo_cmp_base_rsc_dat = MUX_v_64_2_2(COMP_LOOP_acc_6_nl, COMP_LOOP_acc_8_itm,
      or_dcpl_2);
  wire [63:0] nl_modulo_cmp_m_rsc_dat;
  assign nl_modulo_cmp_m_rsc_dat = p_sva;
  wire [0:0] nl_modulo_cmp_ccs_ccore_start_rsc_dat;
  assign nl_modulo_cmp_ccs_ccore_start_rsc_dat = or_dcpl_2 | (fsm_output[4]);
  wire[3:0] COMP_LOOP_tmp_acc_nl;
  wire[4:0] nl_COMP_LOOP_tmp_acc_nl;
  wire [3:0] nl_COMP_LOOP_tmp_lshift_rg_s;
  assign nl_COMP_LOOP_tmp_acc_nl = (~ STAGE_LOOP_i_3_0_sva) + 4'b1011;
  assign COMP_LOOP_tmp_acc_nl = nl_COMP_LOOP_tmp_acc_nl[3:0];
  assign nl_COMP_LOOP_tmp_lshift_rg_s = MUX_v_4_2_2(STAGE_LOOP_i_3_0_sva, COMP_LOOP_tmp_acc_nl,
      fsm_output[2]);
  wire [0:0] nl_inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0;
  assign nl_inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0 = z_out_2[10];
  wire [0:0] nl_inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = ~ STAGE_LOOP_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd5),
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
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(r_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_obj (
      .ld(reg_vec_rsc_triosy_obj_ld_cse),
      .lz(twiddle_rsc_triosy_lz)
    );
  modulo  modulo_cmp (
      .base_rsc_dat(nl_modulo_cmp_base_rsc_dat[63:0]),
      .m_rsc_dat(nl_modulo_cmp_m_rsc_dat[63:0]),
      .return_rsc_z(modulo_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nl_modulo_cmp_ccs_ccore_start_rsc_dat[0:0]),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(modulo_cmp_ccs_ccore_en)
    );
  mgc_shift_l_v5 #(.width_a(32'sd1),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd11)) COMP_LOOP_tmp_lshift_rg (
      .a(1'b1),
      .s(nl_COMP_LOOP_tmp_lshift_rg_s[3:0]),
      .z(z_out)
    );
  inPlaceNTT_DIF_core_wait_dp inPlaceNTT_DIF_core_wait_dp_inst (
      .ensig_cgo_iro(and_57_rmff),
      .ensig_cgo(reg_ensig_cgo_cse),
      .modulo_cmp_ccs_ccore_en(modulo_cmp_ccs_ccore_en)
    );
  inPlaceNTT_DIF_core_core_fsm inPlaceNTT_DIF_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .COMP_LOOP_C_31_tr0(exit_COMP_LOOP_sva),
      .VEC_LOOP_C_0_tr0(nl_inPlaceNTT_DIF_core_core_fsm_inst_VEC_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_inPlaceNTT_DIF_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign and_57_rmff = and_dcpl_5 & (~ (fsm_output[33])) & (~((fsm_output[32:31]!=2'b00)))
      & (~ (fsm_output[3])) & (~ (fsm_output[2])) & (~ (fsm_output[34])) & and_dcpl_6;
  assign VEC_LOOP_j_or_cse = (fsm_output[1]) | (fsm_output[34]);
  assign nl_COMP_LOOP_acc_10_nl = conv_u2u_10_11(VEC_LOOP_j_10_0_sva_9_0) + conv_u2u_10_11(COMP_LOOP_k_10_0_sva_9_0)
      + STAGE_LOOP_lshift_psp_sva;
  assign COMP_LOOP_acc_10_nl = nl_COMP_LOOP_acc_10_nl[10:0];
  assign COMP_LOOP_acc_10_itm_10_1_1 = readslicef_11_10_1(COMP_LOOP_acc_10_nl);
  assign and_dcpl_5 = ~((fsm_output[36]) | (fsm_output[0]));
  assign and_dcpl_6 = ~((fsm_output[35]) | (fsm_output[1]));
  assign or_dcpl_2 = (fsm_output[5]) | (fsm_output[18]);
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ (z_out_3[3:0]))}) + 5'b00001;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign vec_rsci_d_d = MUX_v_64_2_2(modulo_cmp_return_rsc_z, COMP_LOOP_acc_8_itm,
      fsm_output[32]);
  assign vec_rsci_radr_d = MUX_v_10_2_2(COMP_LOOP_acc_10_itm_10_1_1, COMP_LOOP_acc_1_cse_sva,
      fsm_output[3]);
  assign vec_rsci_wadr_d = MUX_v_10_2_2(COMP_LOOP_acc_10_cse_10_1_sva, COMP_LOOP_acc_1_cse_sva,
      fsm_output[32]);
  assign vec_rsci_we_d_pff = (fsm_output[32:31]!=2'b00);
  assign vec_rsci_readA_r_ram_ir_internal_RMASK_B_d = (fsm_output[3:2]!=2'b00);
  assign twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d = fsm_output[2];
  assign twiddle_rsci_radr_d = z_out_1[9:0];
  always @(posedge clk) begin
    if ( (fsm_output[35]) | (fsm_output[0]) ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b1010, (z_out_3[3:0]), fsm_output[35]);
    end
  end
  always @(posedge clk) begin
    if ( ~ and_dcpl_5 ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_vec_rsc_triosy_obj_ld_cse <= 1'b0;
      reg_ensig_cgo_cse <= 1'b0;
    end
    else begin
      reg_vec_rsc_triosy_obj_ld_cse <= (~ STAGE_LOOP_acc_itm_4_1) & (fsm_output[35]);
      reg_ensig_cgo_cse <= and_57_rmff;
    end
  end
  always @(posedge clk) begin
    if ( VEC_LOOP_j_or_cse ) begin
      VEC_LOOP_j_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (z_out_2[9:0]), VEC_LOOP_j_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( ~(and_dcpl_5 & and_dcpl_6) ) begin
      STAGE_LOOP_lshift_psp_sva <= z_out;
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[35]) | (fsm_output[2]) | (fsm_output[0]) | (fsm_output[34])
        | (fsm_output[36]) | (fsm_output[1]) ) begin
      COMP_LOOP_k_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (z_out_3[9:0]), VEC_LOOP_j_not_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      exit_COMP_LOOP_sva <= 1'b0;
    end
    else if ( fsm_output[2] ) begin
      exit_COMP_LOOP_sva <= ~ (z_out_2[10]);
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[2] ) begin
      COMP_LOOP_acc_1_cse_sva <= nl_COMP_LOOP_acc_1_cse_sva[9:0];
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[2] ) begin
      COMP_LOOP_acc_10_cse_10_1_sva <= COMP_LOOP_acc_10_itm_10_1_1;
    end
  end
  always @(posedge clk) begin
    if ( fsm_output[3] ) begin
      COMP_LOOP_tmp_asn_itm <= twiddle_rsci_q_d;
    end
  end
  always @(posedge clk) begin
    if ( (fsm_output[17]) | (fsm_output[18]) | (fsm_output[3]) | (fsm_output[4])
        ) begin
      COMP_LOOP_acc_8_itm <= MUX1HOT_v_64_4_2(vec_rsci_q_d, COMP_LOOP_acc_8_nl, z_out_1,
          modulo_cmp_return_rsc_z, {(fsm_output[3]) , (fsm_output[4]) , (fsm_output[17])
          , (fsm_output[18])});
    end
  end
  assign VEC_LOOP_j_not_1_nl = ~ (fsm_output[1]);
  assign VEC_LOOP_j_not_nl = ~ VEC_LOOP_j_or_cse;
  assign nl_COMP_LOOP_acc_1_cse_sva  = VEC_LOOP_j_10_0_sva_9_0 + COMP_LOOP_k_10_0_sva_9_0;
  assign nl_COMP_LOOP_acc_8_nl = vec_rsci_q_d + COMP_LOOP_acc_8_itm;
  assign COMP_LOOP_acc_8_nl = nl_COMP_LOOP_acc_8_nl[63:0];
  assign COMP_LOOP_mux_12_nl = MUX_v_64_2_2(COMP_LOOP_tmp_asn_itm, ({54'b000000000000000000000000000000000000000000000000000000
      , (z_out[9:0])}), fsm_output[2]);
  assign COMP_LOOP_mux_13_nl = MUX_v_64_2_2(modulo_cmp_return_rsc_z, ({54'b000000000000000000000000000000000000000000000000000000
      , COMP_LOOP_k_10_0_sva_9_0}), fsm_output[2]);
  assign nl_z_out_1 = COMP_LOOP_mux_12_nl * COMP_LOOP_mux_13_nl;
  assign z_out_1 = nl_z_out_1[63:0];
  assign VEC_LOOP_mux_2_nl = MUX_v_11_2_2(({1'b0 , VEC_LOOP_j_10_0_sva_9_0}), z_out_3,
      fsm_output[2]);
  assign VEC_LOOP_or_1_nl = (~ (fsm_output[34])) | (fsm_output[2]);
  assign VEC_LOOP_mux_3_nl = MUX_v_11_2_2(STAGE_LOOP_lshift_psp_sva, ({1'b1 , (~
      (STAGE_LOOP_lshift_psp_sva[10:1]))}), fsm_output[2]);
  assign nl_acc_nl = ({VEC_LOOP_mux_2_nl , VEC_LOOP_or_1_nl}) + ({VEC_LOOP_mux_3_nl
      , 1'b1});
  assign acc_nl = nl_acc_nl[11:0];
  assign z_out_2 = readslicef_12_11_1(acc_nl);
  assign STAGE_LOOP_mux_4_nl = MUX_v_10_2_2(({6'b000000 , STAGE_LOOP_i_3_0_sva}),
      COMP_LOOP_k_10_0_sva_9_0, fsm_output[2]);
  assign nl_z_out_3 = conv_u2u_10_11(STAGE_LOOP_mux_4_nl) + conv_s2u_2_11({(~ (fsm_output[2]))
      , 1'b1});
  assign z_out_3 = nl_z_out_3[10:0];

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


  function automatic [10:0] readslicef_12_11_1;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_12_11_1 = tmp[10:0];
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


  function automatic [10:0] conv_s2u_2_11 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_11 = {{9{vector[1]}}, vector};
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
  clk, rst, vec_rsc_wadr, vec_rsc_d, vec_rsc_we, vec_rsc_radr, vec_rsc_q, vec_rsc_triosy_lz,
      p_rsc_dat, p_rsc_triosy_lz, r_rsc_dat, r_rsc_triosy_lz, twiddle_rsc_radr, twiddle_rsc_q,
      twiddle_rsc_triosy_lz
);
  input clk;
  input rst;
  output [9:0] vec_rsc_wadr;
  output [63:0] vec_rsc_d;
  output vec_rsc_we;
  output [9:0] vec_rsc_radr;
  input [63:0] vec_rsc_q;
  output vec_rsc_triosy_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [9:0] twiddle_rsc_radr;
  input [63:0] twiddle_rsc_q;
  output twiddle_rsc_triosy_lz;


  // Interconnect Declarations
  wire [63:0] vec_rsci_d_d;
  wire [63:0] vec_rsci_q_d;
  wire [9:0] vec_rsci_radr_d;
  wire [9:0] vec_rsci_wadr_d;
  wire vec_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire [63:0] twiddle_rsci_q_d;
  wire [9:0] twiddle_rsci_radr_d;
  wire twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d;
  wire vec_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rwport_4_10_64_1024_1024_64_1_gen vec_rsci
      (
      .q(vec_rsc_q),
      .radr(vec_rsc_radr),
      .we(vec_rsc_we),
      .d(vec_rsc_d),
      .wadr(vec_rsc_wadr),
      .d_d(vec_rsci_d_d),
      .q_d(vec_rsci_q_d),
      .radr_d(vec_rsci_radr_d),
      .wadr_d(vec_rsci_wadr_d),
      .we_d(vec_rsci_we_d_iff),
      .writeA_w_ram_ir_internal_WMASK_B_d(vec_rsci_we_d_iff),
      .readA_r_ram_ir_internal_RMASK_B_d(vec_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_Xilinx_RAMS_BLOCK_1R1W_RBW_rport_7_10_64_1024_1024_64_1_gen twiddle_rsci
      (
      .q(twiddle_rsc_q),
      .radr(twiddle_rsc_radr),
      .q_d(twiddle_rsci_q_d),
      .radr_d(twiddle_rsci_radr_d),
      .readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d)
    );
  inPlaceNTT_DIF_core inPlaceNTT_DIF_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_lz(vec_rsc_triosy_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_lz(twiddle_rsc_triosy_lz),
      .vec_rsci_d_d(vec_rsci_d_d),
      .vec_rsci_q_d(vec_rsci_q_d),
      .vec_rsci_radr_d(vec_rsci_radr_d),
      .vec_rsci_wadr_d(vec_rsci_wadr_d),
      .vec_rsci_readA_r_ram_ir_internal_RMASK_B_d(vec_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .twiddle_rsci_q_d(twiddle_rsci_q_d),
      .twiddle_rsci_radr_d(twiddle_rsci_radr_d),
      .twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d(twiddle_rsci_readA_r_ram_ir_internal_RMASK_B_d),
      .vec_rsci_we_d_pff(vec_rsci_we_d_iff)
    );
endmodule



