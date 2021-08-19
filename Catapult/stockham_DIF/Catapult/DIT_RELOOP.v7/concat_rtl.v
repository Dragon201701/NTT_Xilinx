
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

//------> ../td_ccore_solutions/modulo_dev_0dc217f8ce5f309b848fa994f59fa3f66234_0/rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Wed Aug 18 22:11:42 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    modulo_dev_core
// ------------------------------------------------------------------


module modulo_dev_core (
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
  wire [64:0] rem_2_cmp_z;
  wire [64:0] rem_2_cmp_1_z;
  reg [63:0] rem_2_cmp_b_63_0;
  reg [63:0] rem_2_cmp_1_b_63_0;
  reg [63:0] rem_2_cmp_a_63_0;
  reg [63:0] rem_2_cmp_1_a_63_0;
  wire and_dcpl;
  reg rem_2cyc;
  reg rem_2cyc_st_2;
  reg [63:0] result_sva_1;
  wire and_3_cse;
  wire and_5_cse;
  reg main_stage_0_2;
  reg main_stage_0_3;
  reg [63:0] m_buf_sva_1;
  reg [63:0] m_buf_sva_2;
  reg [63:0] m_buf_sva_3;
  reg asn_itm_1;
  reg asn_itm_2;
  wire and_8_cse;
  wire and_7_cse;

  wire[63:0] qelse_acc_nl;
  wire[64:0] nl_qelse_acc_nl;
  wire[0:0] mux_2_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [64:0] nl_rem_2_cmp_a;
  assign nl_rem_2_cmp_a = {{1{rem_2_cmp_a_63_0[63]}}, rem_2_cmp_a_63_0};
  wire [64:0] nl_rem_2_cmp_b;
  assign nl_rem_2_cmp_b = {1'b0 , rem_2_cmp_b_63_0};
  wire [64:0] nl_rem_2_cmp_1_a;
  assign nl_rem_2_cmp_1_a = {{1{rem_2_cmp_1_a_63_0[63]}}, rem_2_cmp_1_a_63_0};
  wire [64:0] nl_rem_2_cmp_1_b;
  assign nl_rem_2_cmp_1_b = {1'b0 , rem_2_cmp_1_b_63_0};
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
  .signd(32'sd1)) rem_2_cmp (
      .a(nl_rem_2_cmp_a[64:0]),
      .b(nl_rem_2_cmp_b[64:0]),
      .z(rem_2_cmp_z)
    );
  mgc_rem #(.width_a(32'sd65),
  .width_b(32'sd65),
  .signd(32'sd1)) rem_2_cmp_1 (
      .a(nl_rem_2_cmp_1_a[64:0]),
      .b(nl_rem_2_cmp_1_b[64:0]),
      .z(rem_2_cmp_1_z)
    );
  assign and_8_cse = ccs_ccore_en & main_stage_0_2 & asn_itm_1;
  assign and_3_cse = ccs_ccore_en & rem_2cyc;
  assign and_5_cse = ccs_ccore_en & (~ rem_2cyc);
  assign and_7_cse = ccs_ccore_en & ccs_ccore_start_rsci_idat;
  assign and_dcpl = main_stage_0_3 & asn_itm_2;
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      return_rsci_d <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      asn_itm_2 <= 1'b0;
      asn_itm_1 <= 1'b0;
      main_stage_0_2 <= 1'b0;
      main_stage_0_3 <= 1'b0;
    end
    else if ( ccs_ccore_en ) begin
      return_rsci_d <= MUX_v_64_2_2(result_sva_1, qelse_acc_nl, result_sva_1[63]);
      asn_itm_2 <= asn_itm_1;
      asn_itm_1 <= ccs_ccore_start_rsci_idat;
      main_stage_0_2 <= 1'b1;
      main_stage_0_3 <= main_stage_0_2;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      result_sva_1 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ccs_ccore_en & and_dcpl ) begin
      result_sva_1 <= MUX_v_64_2_2((rem_2_cmp_1_z[63:0]), (rem_2_cmp_z[63:0]), rem_2cyc_st_2);
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      m_buf_sva_3 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ccs_ccore_en & mux_2_nl & and_dcpl ) begin
      m_buf_sva_3 <= m_buf_sva_2;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2cyc_st_2 <= 1'b0;
      m_buf_sva_2 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_8_cse ) begin
      rem_2cyc_st_2 <= rem_2cyc;
      m_buf_sva_2 <= m_buf_sva_1;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2_cmp_1_b_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      rem_2_cmp_1_a_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_3_cse ) begin
      rem_2_cmp_1_b_63_0 <= m_rsci_idat;
      rem_2_cmp_1_a_63_0 <= base_rsci_idat;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2_cmp_b_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      rem_2_cmp_a_63_0 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_5_cse ) begin
      rem_2_cmp_b_63_0 <= m_rsci_idat;
      rem_2_cmp_a_63_0 <= base_rsci_idat;
    end
  end
  always @(posedge ccs_ccore_clk) begin
    if ( ccs_ccore_srst ) begin
      rem_2cyc <= 1'b0;
      m_buf_sva_1 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_7_cse ) begin
      rem_2cyc <= ~ rem_2cyc;
      m_buf_sva_1 <= m_rsci_idat;
    end
  end
  assign nl_qelse_acc_nl = result_sva_1 + m_buf_sva_3;
  assign qelse_acc_nl = nl_qelse_acc_nl[63:0];
  assign mux_2_nl = MUX_s_1_2_2((rem_2_cmp_1_z[63]), (rem_2_cmp_z[63]), rem_2cyc_st_2);

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    modulo_dev
// ------------------------------------------------------------------


module modulo_dev (
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
  modulo_dev_core modulo_dev_core_inst (
      .base_rsc_dat(base_rsc_dat),
      .m_rsc_dat(m_rsc_dat),
      .return_rsc_z(return_rsc_z),
      .ccs_ccore_start_rsc_dat(ccs_ccore_start_rsc_dat),
      .ccs_ccore_clk(ccs_ccore_clk),
      .ccs_ccore_srst(ccs_ccore_srst),
      .ccs_ccore_en(ccs_ccore_en)
    );
endmodule




//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/mgc_shift_r_beh_v5.v 
module mgc_shift_r_v5(a,s,z);
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
       assign z = fshr_u(a,s,a[width_a-1]);
     end
     else
     begin: UNSGNED
       assign z = fshr_u(a,s,1'b0);
     end
   endgenerate

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
//  Generated date: Wed Aug 18 22:21:47 2021
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_16_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_16_64_8_256_256_64_5_gen
    (
  q, re, radr, radr_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input re_d;
  output [63:0] q_d;
  input port_0_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign re = (port_0_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_15_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_15_64_8_256_256_64_5_gen
    (
  q, re, radr, radr_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input re_d;
  output [63:0] q_d;
  input port_0_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign re = (port_0_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_14_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_14_64_8_256_256_64_5_gen
    (
  q, re, radr, radr_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input re_d;
  output [63:0] q_d;
  input port_0_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign re = (port_0_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_13_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_13_64_8_256_256_64_5_gen
    (
  q, re, radr, radr_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d
);
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input re_d;
  output [63:0] q_d;
  input port_0_r_ram_ir_internal_RMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign re = (port_0_r_ram_ir_internal_RMASK_B_d);
  assign radr = (radr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_8_256_256_64_5_gen
    (
  we, d, wadr, q, re, radr, radr_d, wadr_d, d_d, we_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d,
      port_1_w_ram_ir_internal_WMASK_B_d
);
  output we;
  output [63:0] d;
  output [7:0] wadr;
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input [7:0] wadr_d;
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
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_8_256_256_64_5_gen
    (
  we, d, wadr, q, re, radr, radr_d, wadr_d, d_d, we_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d,
      port_1_w_ram_ir_internal_WMASK_B_d
);
  output we;
  output [63:0] d;
  output [7:0] wadr;
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input [7:0] wadr_d;
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
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_8_256_256_64_5_gen
    (
  we, d, wadr, q, re, radr, radr_d, wadr_d, d_d, we_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d,
      port_1_w_ram_ir_internal_WMASK_B_d
);
  output we;
  output [63:0] d;
  output [7:0] wadr;
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input [7:0] wadr_d;
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
//  Design Unit:    DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_8_256_256_64_5_gen
// ------------------------------------------------------------------


module DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_8_256_256_64_5_gen
    (
  we, d, wadr, q, re, radr, radr_d, wadr_d, d_d, we_d, re_d, q_d, port_0_r_ram_ir_internal_RMASK_B_d,
      port_1_w_ram_ir_internal_WMASK_B_d
);
  output we;
  output [63:0] d;
  output [7:0] wadr;
  input [63:0] q;
  output re;
  output [7:0] radr;
  input [7:0] radr_d;
  input [7:0] wadr_d;
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
//  Design Unit:    DIT_RELOOP_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module DIT_RELOOP_core_core_fsm (
  clk, rst, fsm_output, IDX_LOOP_C_33_tr0, IDX_LOOP_C_65_tr0, IDX_LOOP_C_97_tr0,
      IDX_LOOP_C_129_tr0, GROUP_LOOP_C_0_tr0, STAGE_LOOP_C_1_tr0
);
  input clk;
  input rst;
  output [7:0] fsm_output;
  reg [7:0] fsm_output;
  input IDX_LOOP_C_33_tr0;
  input IDX_LOOP_C_65_tr0;
  input IDX_LOOP_C_97_tr0;
  input IDX_LOOP_C_129_tr0;
  input GROUP_LOOP_C_0_tr0;
  input STAGE_LOOP_C_1_tr0;


  // FSM State Type Declaration for DIT_RELOOP_core_core_fsm_1
  parameter
    main_C_0 = 8'd0,
    STAGE_LOOP_C_0 = 8'd1,
    IDX_LOOP_C_0 = 8'd2,
    IDX_LOOP_C_1 = 8'd3,
    IDX_LOOP_C_2 = 8'd4,
    IDX_LOOP_C_3 = 8'd5,
    IDX_LOOP_C_4 = 8'd6,
    IDX_LOOP_C_5 = 8'd7,
    IDX_LOOP_C_6 = 8'd8,
    IDX_LOOP_C_7 = 8'd9,
    IDX_LOOP_C_8 = 8'd10,
    IDX_LOOP_C_9 = 8'd11,
    IDX_LOOP_C_10 = 8'd12,
    IDX_LOOP_C_11 = 8'd13,
    IDX_LOOP_C_12 = 8'd14,
    IDX_LOOP_C_13 = 8'd15,
    IDX_LOOP_C_14 = 8'd16,
    IDX_LOOP_C_15 = 8'd17,
    IDX_LOOP_C_16 = 8'd18,
    IDX_LOOP_C_17 = 8'd19,
    IDX_LOOP_C_18 = 8'd20,
    IDX_LOOP_C_19 = 8'd21,
    IDX_LOOP_C_20 = 8'd22,
    IDX_LOOP_C_21 = 8'd23,
    IDX_LOOP_C_22 = 8'd24,
    IDX_LOOP_C_23 = 8'd25,
    IDX_LOOP_C_24 = 8'd26,
    IDX_LOOP_C_25 = 8'd27,
    IDX_LOOP_C_26 = 8'd28,
    IDX_LOOP_C_27 = 8'd29,
    IDX_LOOP_C_28 = 8'd30,
    IDX_LOOP_C_29 = 8'd31,
    IDX_LOOP_C_30 = 8'd32,
    IDX_LOOP_C_31 = 8'd33,
    IDX_LOOP_C_32 = 8'd34,
    IDX_LOOP_C_33 = 8'd35,
    IDX_LOOP_C_34 = 8'd36,
    IDX_LOOP_C_35 = 8'd37,
    IDX_LOOP_C_36 = 8'd38,
    IDX_LOOP_C_37 = 8'd39,
    IDX_LOOP_C_38 = 8'd40,
    IDX_LOOP_C_39 = 8'd41,
    IDX_LOOP_C_40 = 8'd42,
    IDX_LOOP_C_41 = 8'd43,
    IDX_LOOP_C_42 = 8'd44,
    IDX_LOOP_C_43 = 8'd45,
    IDX_LOOP_C_44 = 8'd46,
    IDX_LOOP_C_45 = 8'd47,
    IDX_LOOP_C_46 = 8'd48,
    IDX_LOOP_C_47 = 8'd49,
    IDX_LOOP_C_48 = 8'd50,
    IDX_LOOP_C_49 = 8'd51,
    IDX_LOOP_C_50 = 8'd52,
    IDX_LOOP_C_51 = 8'd53,
    IDX_LOOP_C_52 = 8'd54,
    IDX_LOOP_C_53 = 8'd55,
    IDX_LOOP_C_54 = 8'd56,
    IDX_LOOP_C_55 = 8'd57,
    IDX_LOOP_C_56 = 8'd58,
    IDX_LOOP_C_57 = 8'd59,
    IDX_LOOP_C_58 = 8'd60,
    IDX_LOOP_C_59 = 8'd61,
    IDX_LOOP_C_60 = 8'd62,
    IDX_LOOP_C_61 = 8'd63,
    IDX_LOOP_C_62 = 8'd64,
    IDX_LOOP_C_63 = 8'd65,
    IDX_LOOP_C_64 = 8'd66,
    IDX_LOOP_C_65 = 8'd67,
    IDX_LOOP_C_66 = 8'd68,
    IDX_LOOP_C_67 = 8'd69,
    IDX_LOOP_C_68 = 8'd70,
    IDX_LOOP_C_69 = 8'd71,
    IDX_LOOP_C_70 = 8'd72,
    IDX_LOOP_C_71 = 8'd73,
    IDX_LOOP_C_72 = 8'd74,
    IDX_LOOP_C_73 = 8'd75,
    IDX_LOOP_C_74 = 8'd76,
    IDX_LOOP_C_75 = 8'd77,
    IDX_LOOP_C_76 = 8'd78,
    IDX_LOOP_C_77 = 8'd79,
    IDX_LOOP_C_78 = 8'd80,
    IDX_LOOP_C_79 = 8'd81,
    IDX_LOOP_C_80 = 8'd82,
    IDX_LOOP_C_81 = 8'd83,
    IDX_LOOP_C_82 = 8'd84,
    IDX_LOOP_C_83 = 8'd85,
    IDX_LOOP_C_84 = 8'd86,
    IDX_LOOP_C_85 = 8'd87,
    IDX_LOOP_C_86 = 8'd88,
    IDX_LOOP_C_87 = 8'd89,
    IDX_LOOP_C_88 = 8'd90,
    IDX_LOOP_C_89 = 8'd91,
    IDX_LOOP_C_90 = 8'd92,
    IDX_LOOP_C_91 = 8'd93,
    IDX_LOOP_C_92 = 8'd94,
    IDX_LOOP_C_93 = 8'd95,
    IDX_LOOP_C_94 = 8'd96,
    IDX_LOOP_C_95 = 8'd97,
    IDX_LOOP_C_96 = 8'd98,
    IDX_LOOP_C_97 = 8'd99,
    IDX_LOOP_C_98 = 8'd100,
    IDX_LOOP_C_99 = 8'd101,
    IDX_LOOP_C_100 = 8'd102,
    IDX_LOOP_C_101 = 8'd103,
    IDX_LOOP_C_102 = 8'd104,
    IDX_LOOP_C_103 = 8'd105,
    IDX_LOOP_C_104 = 8'd106,
    IDX_LOOP_C_105 = 8'd107,
    IDX_LOOP_C_106 = 8'd108,
    IDX_LOOP_C_107 = 8'd109,
    IDX_LOOP_C_108 = 8'd110,
    IDX_LOOP_C_109 = 8'd111,
    IDX_LOOP_C_110 = 8'd112,
    IDX_LOOP_C_111 = 8'd113,
    IDX_LOOP_C_112 = 8'd114,
    IDX_LOOP_C_113 = 8'd115,
    IDX_LOOP_C_114 = 8'd116,
    IDX_LOOP_C_115 = 8'd117,
    IDX_LOOP_C_116 = 8'd118,
    IDX_LOOP_C_117 = 8'd119,
    IDX_LOOP_C_118 = 8'd120,
    IDX_LOOP_C_119 = 8'd121,
    IDX_LOOP_C_120 = 8'd122,
    IDX_LOOP_C_121 = 8'd123,
    IDX_LOOP_C_122 = 8'd124,
    IDX_LOOP_C_123 = 8'd125,
    IDX_LOOP_C_124 = 8'd126,
    IDX_LOOP_C_125 = 8'd127,
    IDX_LOOP_C_126 = 8'd128,
    IDX_LOOP_C_127 = 8'd129,
    IDX_LOOP_C_128 = 8'd130,
    IDX_LOOP_C_129 = 8'd131,
    GROUP_LOOP_C_0 = 8'd132,
    STAGE_LOOP_C_1 = 8'd133,
    main_C_1 = 8'd134;

  reg [7:0] state_var;
  reg [7:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : DIT_RELOOP_core_core_fsm_1
    case (state_var)
      STAGE_LOOP_C_0 : begin
        fsm_output = 8'b00000001;
        state_var_NS = IDX_LOOP_C_0;
      end
      IDX_LOOP_C_0 : begin
        fsm_output = 8'b00000010;
        state_var_NS = IDX_LOOP_C_1;
      end
      IDX_LOOP_C_1 : begin
        fsm_output = 8'b00000011;
        state_var_NS = IDX_LOOP_C_2;
      end
      IDX_LOOP_C_2 : begin
        fsm_output = 8'b00000100;
        state_var_NS = IDX_LOOP_C_3;
      end
      IDX_LOOP_C_3 : begin
        fsm_output = 8'b00000101;
        state_var_NS = IDX_LOOP_C_4;
      end
      IDX_LOOP_C_4 : begin
        fsm_output = 8'b00000110;
        state_var_NS = IDX_LOOP_C_5;
      end
      IDX_LOOP_C_5 : begin
        fsm_output = 8'b00000111;
        state_var_NS = IDX_LOOP_C_6;
      end
      IDX_LOOP_C_6 : begin
        fsm_output = 8'b00001000;
        state_var_NS = IDX_LOOP_C_7;
      end
      IDX_LOOP_C_7 : begin
        fsm_output = 8'b00001001;
        state_var_NS = IDX_LOOP_C_8;
      end
      IDX_LOOP_C_8 : begin
        fsm_output = 8'b00001010;
        state_var_NS = IDX_LOOP_C_9;
      end
      IDX_LOOP_C_9 : begin
        fsm_output = 8'b00001011;
        state_var_NS = IDX_LOOP_C_10;
      end
      IDX_LOOP_C_10 : begin
        fsm_output = 8'b00001100;
        state_var_NS = IDX_LOOP_C_11;
      end
      IDX_LOOP_C_11 : begin
        fsm_output = 8'b00001101;
        state_var_NS = IDX_LOOP_C_12;
      end
      IDX_LOOP_C_12 : begin
        fsm_output = 8'b00001110;
        state_var_NS = IDX_LOOP_C_13;
      end
      IDX_LOOP_C_13 : begin
        fsm_output = 8'b00001111;
        state_var_NS = IDX_LOOP_C_14;
      end
      IDX_LOOP_C_14 : begin
        fsm_output = 8'b00010000;
        state_var_NS = IDX_LOOP_C_15;
      end
      IDX_LOOP_C_15 : begin
        fsm_output = 8'b00010001;
        state_var_NS = IDX_LOOP_C_16;
      end
      IDX_LOOP_C_16 : begin
        fsm_output = 8'b00010010;
        state_var_NS = IDX_LOOP_C_17;
      end
      IDX_LOOP_C_17 : begin
        fsm_output = 8'b00010011;
        state_var_NS = IDX_LOOP_C_18;
      end
      IDX_LOOP_C_18 : begin
        fsm_output = 8'b00010100;
        state_var_NS = IDX_LOOP_C_19;
      end
      IDX_LOOP_C_19 : begin
        fsm_output = 8'b00010101;
        state_var_NS = IDX_LOOP_C_20;
      end
      IDX_LOOP_C_20 : begin
        fsm_output = 8'b00010110;
        state_var_NS = IDX_LOOP_C_21;
      end
      IDX_LOOP_C_21 : begin
        fsm_output = 8'b00010111;
        state_var_NS = IDX_LOOP_C_22;
      end
      IDX_LOOP_C_22 : begin
        fsm_output = 8'b00011000;
        state_var_NS = IDX_LOOP_C_23;
      end
      IDX_LOOP_C_23 : begin
        fsm_output = 8'b00011001;
        state_var_NS = IDX_LOOP_C_24;
      end
      IDX_LOOP_C_24 : begin
        fsm_output = 8'b00011010;
        state_var_NS = IDX_LOOP_C_25;
      end
      IDX_LOOP_C_25 : begin
        fsm_output = 8'b00011011;
        state_var_NS = IDX_LOOP_C_26;
      end
      IDX_LOOP_C_26 : begin
        fsm_output = 8'b00011100;
        state_var_NS = IDX_LOOP_C_27;
      end
      IDX_LOOP_C_27 : begin
        fsm_output = 8'b00011101;
        state_var_NS = IDX_LOOP_C_28;
      end
      IDX_LOOP_C_28 : begin
        fsm_output = 8'b00011110;
        state_var_NS = IDX_LOOP_C_29;
      end
      IDX_LOOP_C_29 : begin
        fsm_output = 8'b00011111;
        state_var_NS = IDX_LOOP_C_30;
      end
      IDX_LOOP_C_30 : begin
        fsm_output = 8'b00100000;
        state_var_NS = IDX_LOOP_C_31;
      end
      IDX_LOOP_C_31 : begin
        fsm_output = 8'b00100001;
        state_var_NS = IDX_LOOP_C_32;
      end
      IDX_LOOP_C_32 : begin
        fsm_output = 8'b00100010;
        state_var_NS = IDX_LOOP_C_33;
      end
      IDX_LOOP_C_33 : begin
        fsm_output = 8'b00100011;
        if ( IDX_LOOP_C_33_tr0 ) begin
          state_var_NS = GROUP_LOOP_C_0;
        end
        else begin
          state_var_NS = IDX_LOOP_C_34;
        end
      end
      IDX_LOOP_C_34 : begin
        fsm_output = 8'b00100100;
        state_var_NS = IDX_LOOP_C_35;
      end
      IDX_LOOP_C_35 : begin
        fsm_output = 8'b00100101;
        state_var_NS = IDX_LOOP_C_36;
      end
      IDX_LOOP_C_36 : begin
        fsm_output = 8'b00100110;
        state_var_NS = IDX_LOOP_C_37;
      end
      IDX_LOOP_C_37 : begin
        fsm_output = 8'b00100111;
        state_var_NS = IDX_LOOP_C_38;
      end
      IDX_LOOP_C_38 : begin
        fsm_output = 8'b00101000;
        state_var_NS = IDX_LOOP_C_39;
      end
      IDX_LOOP_C_39 : begin
        fsm_output = 8'b00101001;
        state_var_NS = IDX_LOOP_C_40;
      end
      IDX_LOOP_C_40 : begin
        fsm_output = 8'b00101010;
        state_var_NS = IDX_LOOP_C_41;
      end
      IDX_LOOP_C_41 : begin
        fsm_output = 8'b00101011;
        state_var_NS = IDX_LOOP_C_42;
      end
      IDX_LOOP_C_42 : begin
        fsm_output = 8'b00101100;
        state_var_NS = IDX_LOOP_C_43;
      end
      IDX_LOOP_C_43 : begin
        fsm_output = 8'b00101101;
        state_var_NS = IDX_LOOP_C_44;
      end
      IDX_LOOP_C_44 : begin
        fsm_output = 8'b00101110;
        state_var_NS = IDX_LOOP_C_45;
      end
      IDX_LOOP_C_45 : begin
        fsm_output = 8'b00101111;
        state_var_NS = IDX_LOOP_C_46;
      end
      IDX_LOOP_C_46 : begin
        fsm_output = 8'b00110000;
        state_var_NS = IDX_LOOP_C_47;
      end
      IDX_LOOP_C_47 : begin
        fsm_output = 8'b00110001;
        state_var_NS = IDX_LOOP_C_48;
      end
      IDX_LOOP_C_48 : begin
        fsm_output = 8'b00110010;
        state_var_NS = IDX_LOOP_C_49;
      end
      IDX_LOOP_C_49 : begin
        fsm_output = 8'b00110011;
        state_var_NS = IDX_LOOP_C_50;
      end
      IDX_LOOP_C_50 : begin
        fsm_output = 8'b00110100;
        state_var_NS = IDX_LOOP_C_51;
      end
      IDX_LOOP_C_51 : begin
        fsm_output = 8'b00110101;
        state_var_NS = IDX_LOOP_C_52;
      end
      IDX_LOOP_C_52 : begin
        fsm_output = 8'b00110110;
        state_var_NS = IDX_LOOP_C_53;
      end
      IDX_LOOP_C_53 : begin
        fsm_output = 8'b00110111;
        state_var_NS = IDX_LOOP_C_54;
      end
      IDX_LOOP_C_54 : begin
        fsm_output = 8'b00111000;
        state_var_NS = IDX_LOOP_C_55;
      end
      IDX_LOOP_C_55 : begin
        fsm_output = 8'b00111001;
        state_var_NS = IDX_LOOP_C_56;
      end
      IDX_LOOP_C_56 : begin
        fsm_output = 8'b00111010;
        state_var_NS = IDX_LOOP_C_57;
      end
      IDX_LOOP_C_57 : begin
        fsm_output = 8'b00111011;
        state_var_NS = IDX_LOOP_C_58;
      end
      IDX_LOOP_C_58 : begin
        fsm_output = 8'b00111100;
        state_var_NS = IDX_LOOP_C_59;
      end
      IDX_LOOP_C_59 : begin
        fsm_output = 8'b00111101;
        state_var_NS = IDX_LOOP_C_60;
      end
      IDX_LOOP_C_60 : begin
        fsm_output = 8'b00111110;
        state_var_NS = IDX_LOOP_C_61;
      end
      IDX_LOOP_C_61 : begin
        fsm_output = 8'b00111111;
        state_var_NS = IDX_LOOP_C_62;
      end
      IDX_LOOP_C_62 : begin
        fsm_output = 8'b01000000;
        state_var_NS = IDX_LOOP_C_63;
      end
      IDX_LOOP_C_63 : begin
        fsm_output = 8'b01000001;
        state_var_NS = IDX_LOOP_C_64;
      end
      IDX_LOOP_C_64 : begin
        fsm_output = 8'b01000010;
        state_var_NS = IDX_LOOP_C_65;
      end
      IDX_LOOP_C_65 : begin
        fsm_output = 8'b01000011;
        if ( IDX_LOOP_C_65_tr0 ) begin
          state_var_NS = GROUP_LOOP_C_0;
        end
        else begin
          state_var_NS = IDX_LOOP_C_66;
        end
      end
      IDX_LOOP_C_66 : begin
        fsm_output = 8'b01000100;
        state_var_NS = IDX_LOOP_C_67;
      end
      IDX_LOOP_C_67 : begin
        fsm_output = 8'b01000101;
        state_var_NS = IDX_LOOP_C_68;
      end
      IDX_LOOP_C_68 : begin
        fsm_output = 8'b01000110;
        state_var_NS = IDX_LOOP_C_69;
      end
      IDX_LOOP_C_69 : begin
        fsm_output = 8'b01000111;
        state_var_NS = IDX_LOOP_C_70;
      end
      IDX_LOOP_C_70 : begin
        fsm_output = 8'b01001000;
        state_var_NS = IDX_LOOP_C_71;
      end
      IDX_LOOP_C_71 : begin
        fsm_output = 8'b01001001;
        state_var_NS = IDX_LOOP_C_72;
      end
      IDX_LOOP_C_72 : begin
        fsm_output = 8'b01001010;
        state_var_NS = IDX_LOOP_C_73;
      end
      IDX_LOOP_C_73 : begin
        fsm_output = 8'b01001011;
        state_var_NS = IDX_LOOP_C_74;
      end
      IDX_LOOP_C_74 : begin
        fsm_output = 8'b01001100;
        state_var_NS = IDX_LOOP_C_75;
      end
      IDX_LOOP_C_75 : begin
        fsm_output = 8'b01001101;
        state_var_NS = IDX_LOOP_C_76;
      end
      IDX_LOOP_C_76 : begin
        fsm_output = 8'b01001110;
        state_var_NS = IDX_LOOP_C_77;
      end
      IDX_LOOP_C_77 : begin
        fsm_output = 8'b01001111;
        state_var_NS = IDX_LOOP_C_78;
      end
      IDX_LOOP_C_78 : begin
        fsm_output = 8'b01010000;
        state_var_NS = IDX_LOOP_C_79;
      end
      IDX_LOOP_C_79 : begin
        fsm_output = 8'b01010001;
        state_var_NS = IDX_LOOP_C_80;
      end
      IDX_LOOP_C_80 : begin
        fsm_output = 8'b01010010;
        state_var_NS = IDX_LOOP_C_81;
      end
      IDX_LOOP_C_81 : begin
        fsm_output = 8'b01010011;
        state_var_NS = IDX_LOOP_C_82;
      end
      IDX_LOOP_C_82 : begin
        fsm_output = 8'b01010100;
        state_var_NS = IDX_LOOP_C_83;
      end
      IDX_LOOP_C_83 : begin
        fsm_output = 8'b01010101;
        state_var_NS = IDX_LOOP_C_84;
      end
      IDX_LOOP_C_84 : begin
        fsm_output = 8'b01010110;
        state_var_NS = IDX_LOOP_C_85;
      end
      IDX_LOOP_C_85 : begin
        fsm_output = 8'b01010111;
        state_var_NS = IDX_LOOP_C_86;
      end
      IDX_LOOP_C_86 : begin
        fsm_output = 8'b01011000;
        state_var_NS = IDX_LOOP_C_87;
      end
      IDX_LOOP_C_87 : begin
        fsm_output = 8'b01011001;
        state_var_NS = IDX_LOOP_C_88;
      end
      IDX_LOOP_C_88 : begin
        fsm_output = 8'b01011010;
        state_var_NS = IDX_LOOP_C_89;
      end
      IDX_LOOP_C_89 : begin
        fsm_output = 8'b01011011;
        state_var_NS = IDX_LOOP_C_90;
      end
      IDX_LOOP_C_90 : begin
        fsm_output = 8'b01011100;
        state_var_NS = IDX_LOOP_C_91;
      end
      IDX_LOOP_C_91 : begin
        fsm_output = 8'b01011101;
        state_var_NS = IDX_LOOP_C_92;
      end
      IDX_LOOP_C_92 : begin
        fsm_output = 8'b01011110;
        state_var_NS = IDX_LOOP_C_93;
      end
      IDX_LOOP_C_93 : begin
        fsm_output = 8'b01011111;
        state_var_NS = IDX_LOOP_C_94;
      end
      IDX_LOOP_C_94 : begin
        fsm_output = 8'b01100000;
        state_var_NS = IDX_LOOP_C_95;
      end
      IDX_LOOP_C_95 : begin
        fsm_output = 8'b01100001;
        state_var_NS = IDX_LOOP_C_96;
      end
      IDX_LOOP_C_96 : begin
        fsm_output = 8'b01100010;
        state_var_NS = IDX_LOOP_C_97;
      end
      IDX_LOOP_C_97 : begin
        fsm_output = 8'b01100011;
        if ( IDX_LOOP_C_97_tr0 ) begin
          state_var_NS = GROUP_LOOP_C_0;
        end
        else begin
          state_var_NS = IDX_LOOP_C_98;
        end
      end
      IDX_LOOP_C_98 : begin
        fsm_output = 8'b01100100;
        state_var_NS = IDX_LOOP_C_99;
      end
      IDX_LOOP_C_99 : begin
        fsm_output = 8'b01100101;
        state_var_NS = IDX_LOOP_C_100;
      end
      IDX_LOOP_C_100 : begin
        fsm_output = 8'b01100110;
        state_var_NS = IDX_LOOP_C_101;
      end
      IDX_LOOP_C_101 : begin
        fsm_output = 8'b01100111;
        state_var_NS = IDX_LOOP_C_102;
      end
      IDX_LOOP_C_102 : begin
        fsm_output = 8'b01101000;
        state_var_NS = IDX_LOOP_C_103;
      end
      IDX_LOOP_C_103 : begin
        fsm_output = 8'b01101001;
        state_var_NS = IDX_LOOP_C_104;
      end
      IDX_LOOP_C_104 : begin
        fsm_output = 8'b01101010;
        state_var_NS = IDX_LOOP_C_105;
      end
      IDX_LOOP_C_105 : begin
        fsm_output = 8'b01101011;
        state_var_NS = IDX_LOOP_C_106;
      end
      IDX_LOOP_C_106 : begin
        fsm_output = 8'b01101100;
        state_var_NS = IDX_LOOP_C_107;
      end
      IDX_LOOP_C_107 : begin
        fsm_output = 8'b01101101;
        state_var_NS = IDX_LOOP_C_108;
      end
      IDX_LOOP_C_108 : begin
        fsm_output = 8'b01101110;
        state_var_NS = IDX_LOOP_C_109;
      end
      IDX_LOOP_C_109 : begin
        fsm_output = 8'b01101111;
        state_var_NS = IDX_LOOP_C_110;
      end
      IDX_LOOP_C_110 : begin
        fsm_output = 8'b01110000;
        state_var_NS = IDX_LOOP_C_111;
      end
      IDX_LOOP_C_111 : begin
        fsm_output = 8'b01110001;
        state_var_NS = IDX_LOOP_C_112;
      end
      IDX_LOOP_C_112 : begin
        fsm_output = 8'b01110010;
        state_var_NS = IDX_LOOP_C_113;
      end
      IDX_LOOP_C_113 : begin
        fsm_output = 8'b01110011;
        state_var_NS = IDX_LOOP_C_114;
      end
      IDX_LOOP_C_114 : begin
        fsm_output = 8'b01110100;
        state_var_NS = IDX_LOOP_C_115;
      end
      IDX_LOOP_C_115 : begin
        fsm_output = 8'b01110101;
        state_var_NS = IDX_LOOP_C_116;
      end
      IDX_LOOP_C_116 : begin
        fsm_output = 8'b01110110;
        state_var_NS = IDX_LOOP_C_117;
      end
      IDX_LOOP_C_117 : begin
        fsm_output = 8'b01110111;
        state_var_NS = IDX_LOOP_C_118;
      end
      IDX_LOOP_C_118 : begin
        fsm_output = 8'b01111000;
        state_var_NS = IDX_LOOP_C_119;
      end
      IDX_LOOP_C_119 : begin
        fsm_output = 8'b01111001;
        state_var_NS = IDX_LOOP_C_120;
      end
      IDX_LOOP_C_120 : begin
        fsm_output = 8'b01111010;
        state_var_NS = IDX_LOOP_C_121;
      end
      IDX_LOOP_C_121 : begin
        fsm_output = 8'b01111011;
        state_var_NS = IDX_LOOP_C_122;
      end
      IDX_LOOP_C_122 : begin
        fsm_output = 8'b01111100;
        state_var_NS = IDX_LOOP_C_123;
      end
      IDX_LOOP_C_123 : begin
        fsm_output = 8'b01111101;
        state_var_NS = IDX_LOOP_C_124;
      end
      IDX_LOOP_C_124 : begin
        fsm_output = 8'b01111110;
        state_var_NS = IDX_LOOP_C_125;
      end
      IDX_LOOP_C_125 : begin
        fsm_output = 8'b01111111;
        state_var_NS = IDX_LOOP_C_126;
      end
      IDX_LOOP_C_126 : begin
        fsm_output = 8'b10000000;
        state_var_NS = IDX_LOOP_C_127;
      end
      IDX_LOOP_C_127 : begin
        fsm_output = 8'b10000001;
        state_var_NS = IDX_LOOP_C_128;
      end
      IDX_LOOP_C_128 : begin
        fsm_output = 8'b10000010;
        state_var_NS = IDX_LOOP_C_129;
      end
      IDX_LOOP_C_129 : begin
        fsm_output = 8'b10000011;
        if ( IDX_LOOP_C_129_tr0 ) begin
          state_var_NS = GROUP_LOOP_C_0;
        end
        else begin
          state_var_NS = IDX_LOOP_C_0;
        end
      end
      GROUP_LOOP_C_0 : begin
        fsm_output = 8'b10000100;
        if ( GROUP_LOOP_C_0_tr0 ) begin
          state_var_NS = STAGE_LOOP_C_1;
        end
        else begin
          state_var_NS = IDX_LOOP_C_0;
        end
      end
      STAGE_LOOP_C_1 : begin
        fsm_output = 8'b10000101;
        if ( STAGE_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = STAGE_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 8'b10000110;
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
//  Design Unit:    DIT_RELOOP_core_wait_dp
// ------------------------------------------------------------------


module DIT_RELOOP_core_wait_dp (
  ensig_cgo_iro, ensig_cgo, IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en
);
  input ensig_cgo_iro;
  input ensig_cgo;
  output IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en;



  // Interconnect Declarations for Component Instantiations 
  assign IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en = ensig_cgo | ensig_cgo_iro;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    DIT_RELOOP_core
// ------------------------------------------------------------------


module DIT_RELOOP_core (
  clk, rst, vec_rsc_triosy_0_0_lz, vec_rsc_triosy_0_1_lz, vec_rsc_triosy_0_2_lz,
      vec_rsc_triosy_0_3_lz, p_rsc_dat, p_rsc_triosy_lz, r_rsc_triosy_lz, twiddle_rsc_triosy_0_0_lz,
      twiddle_rsc_triosy_0_1_lz, twiddle_rsc_triosy_0_2_lz, twiddle_rsc_triosy_0_3_lz,
      vec_rsc_0_0_i_radr_d, vec_rsc_0_0_i_q_d, vec_rsc_0_1_i_radr_d, vec_rsc_0_1_i_q_d,
      vec_rsc_0_2_i_radr_d, vec_rsc_0_2_i_q_d, vec_rsc_0_3_i_radr_d, vec_rsc_0_3_i_q_d,
      twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_1_i_q_d, twiddle_rsc_0_2_i_q_d, twiddle_rsc_0_3_i_q_d,
      vec_rsc_0_0_i_wadr_d_pff, vec_rsc_0_0_i_d_d_pff, vec_rsc_0_0_i_we_d_pff, vec_rsc_0_0_i_re_d_pff,
      vec_rsc_0_1_i_wadr_d_pff, vec_rsc_0_1_i_d_d_pff, vec_rsc_0_1_i_we_d_pff, vec_rsc_0_1_i_re_d_pff,
      vec_rsc_0_2_i_we_d_pff, vec_rsc_0_2_i_re_d_pff, vec_rsc_0_3_i_we_d_pff, vec_rsc_0_3_i_re_d_pff,
      twiddle_rsc_0_0_i_radr_d_pff, twiddle_rsc_0_0_i_re_d_pff, twiddle_rsc_0_1_i_re_d_pff,
      twiddle_rsc_0_2_i_re_d_pff, twiddle_rsc_0_3_i_re_d_pff
);
  input clk;
  input rst;
  output vec_rsc_triosy_0_0_lz;
  output vec_rsc_triosy_0_1_lz;
  output vec_rsc_triosy_0_2_lz;
  output vec_rsc_triosy_0_3_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  output r_rsc_triosy_lz;
  output twiddle_rsc_triosy_0_0_lz;
  output twiddle_rsc_triosy_0_1_lz;
  output twiddle_rsc_triosy_0_2_lz;
  output twiddle_rsc_triosy_0_3_lz;
  output [7:0] vec_rsc_0_0_i_radr_d;
  input [63:0] vec_rsc_0_0_i_q_d;
  output [7:0] vec_rsc_0_1_i_radr_d;
  input [63:0] vec_rsc_0_1_i_q_d;
  output [7:0] vec_rsc_0_2_i_radr_d;
  input [63:0] vec_rsc_0_2_i_q_d;
  output [7:0] vec_rsc_0_3_i_radr_d;
  input [63:0] vec_rsc_0_3_i_q_d;
  input [63:0] twiddle_rsc_0_0_i_q_d;
  input [63:0] twiddle_rsc_0_1_i_q_d;
  input [63:0] twiddle_rsc_0_2_i_q_d;
  input [63:0] twiddle_rsc_0_3_i_q_d;
  output [7:0] vec_rsc_0_0_i_wadr_d_pff;
  output [63:0] vec_rsc_0_0_i_d_d_pff;
  output vec_rsc_0_0_i_we_d_pff;
  output vec_rsc_0_0_i_re_d_pff;
  output [7:0] vec_rsc_0_1_i_wadr_d_pff;
  output [63:0] vec_rsc_0_1_i_d_d_pff;
  output vec_rsc_0_1_i_we_d_pff;
  output vec_rsc_0_1_i_re_d_pff;
  output vec_rsc_0_2_i_we_d_pff;
  output vec_rsc_0_2_i_re_d_pff;
  output vec_rsc_0_3_i_we_d_pff;
  output vec_rsc_0_3_i_re_d_pff;
  output [7:0] twiddle_rsc_0_0_i_radr_d_pff;
  output twiddle_rsc_0_0_i_re_d_pff;
  output twiddle_rsc_0_1_i_re_d_pff;
  output twiddle_rsc_0_2_i_re_d_pff;
  output twiddle_rsc_0_3_i_re_d_pff;


  // Interconnect Declarations
  wire [63:0] p_rsci_idat;
  reg [127:0] IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a;
  wire [63:0] IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z;
  wire [63:0] IDX_LOOP_1_modulo_dev_cmp_return_rsc_z;
  wire IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en;
  wire [7:0] fsm_output;
  wire [8:0] IDX_LOOP_idx2_acc_tmp;
  wire [9:0] nl_IDX_LOOP_idx2_acc_tmp;
  wire and_dcpl;
  wire or_tmp_1;
  wire or_tmp_3;
  wire and_tmp;
  wire or_tmp_5;
  wire or_tmp_6;
  wire and_dcpl_11;
  wire or_tmp_14;
  wire mux_tmp_27;
  wire and_dcpl_23;
  wire and_dcpl_37;
  wire and_dcpl_38;
  wire and_dcpl_39;
  wire and_dcpl_40;
  wire and_dcpl_41;
  wire and_dcpl_42;
  wire and_dcpl_44;
  wire and_dcpl_45;
  wire and_dcpl_46;
  wire and_dcpl_47;
  wire and_dcpl_48;
  wire and_dcpl_51;
  wire and_dcpl_58;
  wire and_dcpl_59;
  wire and_dcpl_61;
  wire and_dcpl_62;
  wire and_dcpl_63;
  wire and_dcpl_64;
  wire and_dcpl_68;
  wire mux_tmp_59;
  wire and_dcpl_74;
  wire and_dcpl_77;
  wire and_dcpl_81;
  wire mux_tmp_68;
  wire and_dcpl_83;
  wire and_dcpl_84;
  wire and_dcpl_85;
  wire and_dcpl_86;
  wire and_dcpl_87;
  wire and_dcpl_92;
  wire and_dcpl_95;
  wire and_dcpl_98;
  wire and_dcpl_101;
  wire and_dcpl_102;
  wire and_dcpl_103;
  wire and_dcpl_104;
  wire and_dcpl_105;
  wire and_dcpl_107;
  wire and_dcpl_108;
  wire and_dcpl_109;
  wire and_dcpl_110;
  wire and_dcpl_112;
  wire and_dcpl_114;
  wire and_dcpl_115;
  wire and_dcpl_117;
  wire and_dcpl_120;
  wire and_dcpl_121;
  wire and_dcpl_123;
  wire and_dcpl_124;
  wire and_dcpl_126;
  wire and_dcpl_127;
  wire and_dcpl_136;
  wire and_dcpl_139;
  wire and_dcpl_141;
  wire and_dcpl_149;
  wire and_dcpl_152;
  wire not_tmp_98;
  wire or_dcpl_30;
  wire mux_tmp_143;
  wire and_dcpl_165;
  wire and_dcpl_175;
  wire and_dcpl_176;
  wire and_dcpl_177;
  wire and_dcpl_178;
  wire and_dcpl_181;
  wire and_dcpl_182;
  wire and_dcpl_183;
  wire and_dcpl_184;
  wire and_dcpl_186;
  wire and_dcpl_187;
  wire and_dcpl_189;
  wire and_dcpl_190;
  wire and_dcpl_192;
  wire and_dcpl_193;
  wire and_dcpl_197;
  wire and_dcpl_198;
  wire and_dcpl_200;
  wire and_dcpl_202;
  wire and_dcpl_204;
  wire and_dcpl_216;
  reg IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm;
  wire [7:0] IDX_LOOP_idx1_acc_psp_4_sva_mx0w0;
  wire [8:0] nl_IDX_LOOP_idx1_acc_psp_4_sva_mx0w0;
  reg [9:0] STAGE_LOOP_op_rshift_psp_1_sva;
  reg [9:0] GROUP_LOOP_j_10_0_sva_9_0;
  reg IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm;
  reg [9:0] IDX_LOOP_idx2_9_0_2_sva;
  wire [8:0] IDX_LOOP_idx1_acc_psp_3_sva_mx0w0;
  wire [9:0] nl_IDX_LOOP_idx1_acc_psp_3_sva_mx0w0;
  reg [7:0] IDX_LOOP_t_10_2_sva_7_0;
  reg IDX_LOOP_slc_IDX_LOOP_acc_8_itm;
  reg IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm;
  reg [3:0] STAGE_LOOP_i_3_0_sva;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_20_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_8_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_21_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_9_itm;
  reg IDX_LOOP_f1_and_12_itm;
  reg [8:0] IDX_LOOP_idx2_acc_1_psp_sva;
  reg [8:0] IDX_LOOP_idx1_acc_psp_3_sva;
  reg [8:0] IDX_LOOP_idx2_acc_psp_sva;
  reg [9:0] IDX_LOOP_idx2_9_0_sva;
  wire [9:0] IDX_LOOP_idx2_9_0_2_sva_mx0w0;
  wire [10:0] nl_IDX_LOOP_idx2_9_0_2_sva_mx0w0;
  wire [9:0] IDX_LOOP_idx2_9_0_sva_mx0w0;
  wire [10:0] nl_IDX_LOOP_idx2_9_0_sva_mx0w0;
  wire [8:0] IDX_LOOP_idx2_acc_1_psp_sva_mx0w0;
  wire [9:0] nl_IDX_LOOP_idx2_acc_1_psp_sva_mx0w0;
  reg [7:0] reg_IDX_LOOP_t_10_2_ftd_1;
  reg reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8;
  reg [1:0] reg_IDX_LOOP_1_lshift_idiv_ftd_8;
  reg [63:0] reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse;
  reg reg_twiddle_rsc_triosy_0_0_obj_ld_cse;
  reg reg_ensig_cgo_cse;
  wire or_60_cse;
  wire or_34_cse;
  wire and_182_cse;
  wire nor_33_cse;
  wire and_15_cse;
  wire mux_47_cse;
  wire or_41_cse;
  wire or_24_cse;
  wire nor_72_rmff;
  reg [63:0] tmp_1_lpi_4_dfm_2;
  reg [63:0] tmp_2_lpi_4_dfm;
  reg [7:0] IDX_LOOP_idx1_acc_psp_4_sva;
  reg [63:0] IDX_LOOP_modulo_dev_return_1_sva;
  reg [63:0] p_sva;
  wire [9:0] STAGE_LOOP_op_rshift_itm;
  wire and_dcpl_226;
  wire and_dcpl_233;
  wire [10:0] z_out;
  wire and_dcpl_246;
  wire and_dcpl_258;
  wire [8:0] z_out_2;
  wire [9:0] nl_z_out_2;
  wire and_dcpl_276;
  wire [127:0] z_out_3;
  wire and_dcpl_279;
  wire and_dcpl_285;
  wire and_dcpl_287;
  wire and_dcpl_288;
  wire and_dcpl_289;
  wire and_dcpl_291;
  wire and_dcpl_292;
  wire and_dcpl_293;
  wire [9:0] z_out_4;
  wire and_dcpl_300;
  wire and_dcpl_304;
  wire and_dcpl_306;
  wire [63:0] z_out_5;
  wire and_dcpl_312;
  wire and_dcpl_313;
  wire and_dcpl_317;
  wire and_dcpl_320;
  wire and_dcpl_323;
  wire and_dcpl_325;
  reg [3:0] STAGE_LOOP_gp_acc_psp_sva;
  reg [9:0] STAGE_LOOP_gp_lshift_psp_sva;
  reg [127:0] IDX_LOOP_1_mul_mut;
  reg IDX_LOOP_f1_IDX_LOOP_f1_nor_itm;
  reg IDX_LOOP_f1_and_1_itm;
  reg IDX_LOOP_f1_and_2_itm;
  reg IDX_LOOP_f1_and_3_itm;
  reg IDX_LOOP_f1_and_5_itm;
  reg IDX_LOOP_f1_and_6_itm;
  reg IDX_LOOP_f1_and_7_itm;
  reg IDX_LOOP_f1_IDX_LOOP_f1_nor_1_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_6_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_7_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_10_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_11_itm;
  reg [63:0] IDX_LOOP_mux1h_1_itm;
  reg IDX_LOOP_f1_IDX_LOOP_f1_nor_2_itm;
  reg IDX_LOOP_f1_and_11_itm;
  reg IDX_LOOP_f1_and_13_itm;
  reg IDX_LOOP_f1_and_15_itm;
  reg IDX_LOOP_f1_and_16_itm;
  reg IDX_LOOP_f1_and_17_itm;
  reg [63:0] IDX_LOOP_mux1h_2_itm;
  reg IDX_LOOP_f1_IDX_LOOP_f1_nor_3_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_18_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_19_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_22_itm;
  reg IDX_LOOP_f2_IDX_LOOP_f2_and_23_itm;
  reg [63:0] IDX_LOOP_mux1h_3_itm;
  wire STAGE_LOOP_i_3_0_sva_mx0c1;
  wire [3:0] STAGE_LOOP_i_3_0_sva_2;
  wire [4:0] nl_STAGE_LOOP_i_3_0_sva_2;
  wire GROUP_LOOP_j_10_0_sva_9_0_mx0c0;
  wire IDX_LOOP_modulo_dev_return_1_sva_mx0c0;
  wire IDX_LOOP_modulo_dev_return_1_sva_mx0c1;
  wire IDX_LOOP_modulo_dev_return_1_sva_mx0c2;
  wire IDX_LOOP_modulo_dev_return_1_sva_mx0c3;
  wire IDX_LOOP_modulo_dev_return_1_sva_mx0c4;
  wire tmp_2_lpi_4_dfm_mx0c0;
  wire tmp_2_lpi_4_dfm_mx0c1;
  wire and_307_ssc;
  wire IDX_LOOP_or_2_tmp;
  wire or_cse;
  wire or_205_cse;
  wire or_212_cse;
  wire and_73_itm;
  wire STAGE_LOOP_acc_itm_4_1;
  wire z_out_1_10;
  wire IDX_LOOP_f1_mux1h_42_m1c;
  wire IDX_LOOP_f1_mux1h_43_m1c;
  wire IDX_LOOP_f1_mux1h_45_m1c;

  wire[0:0] mux_67_nl;
  wire[0:0] nor_48_nl;
  wire[0:0] mux_73_nl;
  wire[0:0] mux_72_nl;
  wire[0:0] or_59_nl;
  wire[0:0] mux_82_nl;
  wire[0:0] mux_81_nl;
  wire[0:0] mux_80_nl;
  wire[0:0] mux_79_nl;
  wire[0:0] mux_78_nl;
  wire[0:0] mux_77_nl;
  wire[0:0] mux_76_nl;
  wire[0:0] mux_75_nl;
  wire[0:0] GROUP_LOOP_j_not_1_nl;
  wire[0:0] or_206_nl;
  wire[0:0] mux_64_nl;
  wire[0:0] or_203_nl;
  wire[0:0] or_204_nl;
  wire[0:0] or_215_nl;
  wire[0:0] mux_192_nl;
  wire[0:0] or_214_nl;
  wire[0:0] mux_nl;
  wire[0:0] or_213_nl;
  wire[0:0] nand_21_nl;
  wire[0:0] mux_162_nl;
  wire[0:0] mux_161_nl;
  wire[0:0] or_170_nl;
  wire[0:0] IDX_LOOP_f1_IDX_LOOP_f1_nor_nl;
  wire[0:0] IDX_LOOP_f1_and_9_nl;
  wire[0:0] and_177_nl;
  wire[0:0] mux_164_nl;
  wire[0:0] mux_163_nl;
  wire[0:0] and_233_nl;
  wire[0:0] or_171_nl;
  wire[0:0] mux_167_nl;
  wire[0:0] mux_165_nl;
  wire[10:0] IDX_LOOP_3_acc_nl;
  wire[11:0] nl_IDX_LOOP_3_acc_nl;
  wire[8:0] IDX_LOOP_acc_nl;
  wire[9:0] nl_IDX_LOOP_acc_nl;
  wire[0:0] or_23_nl;
  wire[0:0] IDX_LOOP_f2_and_nl;
  wire[0:0] IDX_LOOP_f2_and_1_nl;
  wire[0:0] IDX_LOOP_f2_or_nl;
  wire[0:0] IDX_LOOP_f2_or_1_nl;
  wire[0:0] IDX_LOOP_f2_or_3_nl;
  wire[0:0] and_208_nl;
  wire[0:0] and_210_nl;
  wire[0:0] and_212_nl;
  wire[0:0] and_214_nl;
  wire[0:0] mux_182_nl;
  wire[0:0] mux_33_nl;
  wire[0:0] IDX_LOOP_f1_or_11_nl;
  wire[0:0] IDX_LOOP_f1_or_12_nl;
  wire[0:0] IDX_LOOP_f1_or_13_nl;
  wire[0:0] IDX_LOOP_f1_or_14_nl;
  wire[0:0] and_220_nl;
  wire[0:0] and_221_nl;
  wire[0:0] and_222_nl;
  wire[0:0] and_223_nl;
  wire[0:0] mux_186_nl;
  wire[0:0] mux_44_nl;
  wire[0:0] and_226_nl;
  wire[0:0] and_227_nl;
  wire[0:0] and_228_nl;
  wire[0:0] and_229_nl;
  wire[0:0] mux_188_nl;
  wire[0:0] mux_187_nl;
  wire[0:0] or_26_nl;
  wire[0:0] nand_7_nl;
  wire[4:0] STAGE_LOOP_acc_nl;
  wire[5:0] nl_STAGE_LOOP_acc_nl;
  wire[0:0] or_62_nl;
  wire[0:0] nor_25_nl;
  wire[0:0] mux_61_nl;
  wire[0:0] mux_160_nl;
  wire[0:0] mux_159_nl;
  wire[0:0] mux_157_nl;
  wire[0:0] mux_169_nl;
  wire[0:0] nor_55_nl;
  wire[0:0] mux_172_nl;
  wire[0:0] mux_171_nl;
  wire[0:0] mux_176_nl;
  wire[0:0] mux_175_nl;
  wire[0:0] mux_174_nl;
  wire[0:0] mux_173_nl;
  wire[0:0] mux_177_nl;
  wire[0:0] and_164_nl;
  wire[0:0] and_165_nl;
  wire[0:0] and_139_nl;
  wire[0:0] and_140_nl;
  wire[0:0] and_138_nl;
  wire[0:0] mux_144_nl;
  wire[0:0] and_235_nl;
  wire[0:0] mux_143_nl;
  wire[0:0] nor_28_nl;
  wire[0:0] nor_29_nl;
  wire[0:0] nor_30_nl;
  wire[0:0] mux_142_nl;
  wire[0:0] mux_141_nl;
  wire[0:0] or_142_nl;
  wire[0:0] or_140_nl;
  wire[0:0] mux_140_nl;
  wire[0:0] or_139_nl;
  wire[0:0] or_138_nl;
  wire[0:0] mux_149_nl;
  wire[0:0] mux_148_nl;
  wire[0:0] mux_147_nl;
  wire[0:0] or_150_nl;
  wire[0:0] and_234_nl;
  wire[0:0] mux_146_nl;
  wire[0:0] or_148_nl;
  wire[0:0] nand_6_nl;
  wire[0:0] mux_145_nl;
  wire[0:0] nor_26_nl;
  wire[0:0] nor_27_nl;
  wire[0:0] and_153_nl;
  wire[0:0] and_155_nl;
  wire[0:0] and_158_nl;
  wire[0:0] and_160_nl;
  wire[0:0] and_111_nl;
  wire[0:0] and_116_nl;
  wire[0:0] and_105_nl;
  wire[0:0] mux_134_nl;
  wire[0:0] nor_35_nl;
  wire[0:0] mux_133_nl;
  wire[0:0] or_127_nl;
  wire[0:0] or_126_nl;
  wire[0:0] nor_36_nl;
  wire[0:0] mux_132_nl;
  wire[0:0] mux_131_nl;
  wire[0:0] or_123_nl;
  wire[0:0] or_121_nl;
  wire[0:0] mux_130_nl;
  wire[0:0] or_120_nl;
  wire[0:0] or_119_nl;
  wire[0:0] mux_139_nl;
  wire[0:0] and_236_nl;
  wire[0:0] mux_138_nl;
  wire[0:0] nor_31_nl;
  wire[0:0] nor_32_nl;
  wire[0:0] mux_137_nl;
  wire[0:0] mux_136_nl;
  wire[0:0] nand_8_nl;
  wire[0:0] or_131_nl;
  wire[0:0] mux_135_nl;
  wire[0:0] nand_9_nl;
  wire[0:0] nor_34_nl;
  wire[0:0] and_143_nl;
  wire[0:0] and_145_nl;
  wire[0:0] mux_124_nl;
  wire[0:0] and_239_nl;
  wire[0:0] mux_123_nl;
  wire[0:0] nor_40_nl;
  wire[0:0] nor_41_nl;
  wire[0:0] nor_42_nl;
  wire[0:0] mux_122_nl;
  wire[0:0] mux_121_nl;
  wire[0:0] or_107_nl;
  wire[0:0] or_106_nl;
  wire[0:0] mux_120_nl;
  wire[0:0] or_105_nl;
  wire[0:0] or_104_nl;
  wire[0:0] mux_129_nl;
  wire[0:0] mux_128_nl;
  wire[0:0] mux_127_nl;
  wire[0:0] nor_37_nl;
  wire[0:0] or_198_nl;
  wire[0:0] mux_126_nl;
  wire[0:0] and_237_nl;
  wire[0:0] and_238_nl;
  wire[0:0] mux_125_nl;
  wire[0:0] nor_38_nl;
  wire[0:0] nor_39_nl;
  wire[0:0] and_121_nl;
  wire[0:0] and_124_nl;
  wire[0:0] and_130_nl;
  wire[0:0] and_133_nl;
  wire[0:0] mux_114_nl;
  wire[0:0] nor_45_nl;
  wire[0:0] mux_113_nl;
  wire[0:0] nand_13_nl;
  wire[0:0] or_93_nl;
  wire[0:0] nor_46_nl;
  wire[0:0] mux_112_nl;
  wire[0:0] mux_111_nl;
  wire[0:0] nand_14_nl;
  wire[0:0] or_90_nl;
  wire[0:0] mux_110_nl;
  wire[0:0] or_89_nl;
  wire[0:0] or_88_nl;
  wire[0:0] mux_119_nl;
  wire[0:0] and_240_nl;
  wire[0:0] mux_118_nl;
  wire[0:0] nor_43_nl;
  wire[0:0] and_241_nl;
  wire[0:0] mux_117_nl;
  wire[0:0] mux_116_nl;
  wire[0:0] nor_44_nl;
  wire[0:0] nand_11_nl;
  wire[0:0] and_242_nl;
  wire[0:0] mux_115_nl;
  wire[0:0] or_199_nl;
  wire[0:0] and_244_nl;
  wire[11:0] acc_nl;
  wire[12:0] nl_acc_nl;
  wire[9:0] IDX_LOOP_mux_13_nl;
  wire[0:0] IDX_LOOP_IDX_LOOP_nand_1_nl;
  wire[7:0] IDX_LOOP_IDX_LOOP_and_1_nl;
  wire[0:0] not_442_nl;
  wire[11:0] acc_1_nl;
  wire[12:0] nl_acc_1_nl;
  wire[10:0] IDX_LOOP_mux_14_nl;
  wire[9:0] IDX_LOOP_mux_15_nl;
  wire[7:0] STAGE_LOOP_gp_mux_5_nl;
  wire[63:0] IDX_LOOP_mux1h_27_nl;
  wire[0:0] and_353_nl;
  wire[0:0] and_354_nl;
  wire[0:0] and_355_nl;
  wire[63:0] IDX_LOOP_mux_16_nl;
  wire[0:0] IDX_LOOP_f1_or_19_nl;
  wire[0:0] IDX_LOOP_f1_or_20_nl;
  wire[0:0] IDX_LOOP_f1_or_21_nl;
  wire[0:0] IDX_LOOP_f1_mux1h_40_nl;
  wire[0:0] IDX_LOOP_f1_or_16_nl;
  wire[0:0] IDX_LOOP_f1_or_17_nl;
  wire[0:0] IDX_LOOP_f1_mux1h_41_nl;
  wire[0:0] IDX_LOOP_f1_or_18_nl;
  wire[0:0] IDX_LOOP_f1_or_nl;
  wire[0:0] IDX_LOOP_f1_or_22_nl;
  wire[0:0] IDX_LOOP_f1_or_23_nl;
  wire[0:0] IDX_LOOP_f1_mux1h_44_nl;
  wire[0:0] IDX_LOOP_f1_and_26_nl;

  // Interconnect Declarations for Component Instantiations 
  wire[64:0] acc_3_nl;
  wire[65:0] nl_acc_3_nl;
  wire[63:0] IDX_LOOP_IDX_LOOP_mux1h_1_nl;
  wire[0:0] IDX_LOOP_IDX_LOOP_nor_1_nl;
  wire[0:0] IDX_LOOP_and_2_nl;
  wire[0:0] IDX_LOOP_or_12_nl;
  wire[63:0] IDX_LOOP_mux1h_28_nl;
  wire[0:0] IDX_LOOP_or_13_nl;
  wire [63:0] nl_IDX_LOOP_1_modulo_dev_cmp_base_rsc_dat;
  assign IDX_LOOP_IDX_LOOP_nor_1_nl = ~(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 | IDX_LOOP_or_2_tmp);
  assign IDX_LOOP_and_2_nl = reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 & (~ IDX_LOOP_or_2_tmp);
  assign IDX_LOOP_IDX_LOOP_mux1h_1_nl = MUX1HOT_v_64_3_2(vec_rsc_0_0_i_q_d, vec_rsc_0_2_i_q_d,
      tmp_2_lpi_4_dfm, {IDX_LOOP_IDX_LOOP_nor_1_nl , IDX_LOOP_and_2_nl , IDX_LOOP_or_2_tmp});
  assign IDX_LOOP_or_12_nl = (~ and_dcpl_317) | and_dcpl_313 | and_dcpl_320 | and_dcpl_323
      | and_dcpl_325;
  assign IDX_LOOP_or_13_nl = and_dcpl_320 | and_dcpl_323 | and_dcpl_325;
  assign IDX_LOOP_mux1h_28_nl = MUX1HOT_v_64_3_2((~ tmp_1_lpi_4_dfm_2), tmp_1_lpi_4_dfm_2,
      (~ z_out_5), {and_dcpl_313 , and_dcpl_317 , IDX_LOOP_or_13_nl});
  assign nl_acc_3_nl = ({IDX_LOOP_IDX_LOOP_mux1h_1_nl , IDX_LOOP_or_12_nl}) + ({IDX_LOOP_mux1h_28_nl
      , 1'b1});
  assign acc_3_nl = nl_acc_3_nl[64:0];
  assign nl_IDX_LOOP_1_modulo_dev_cmp_base_rsc_dat = readslicef_65_64_1(acc_3_nl);
  wire [63:0] nl_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat;
  assign nl_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat = p_sva;
  wire [0:0] nl_IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_start_rsc_dat;
  assign nl_IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_start_rsc_dat = and_dcpl_51 & (~
      (fsm_output[1])) & (~ (fsm_output[7]));
  wire[7:0] STAGE_LOOP_gp_and_nl;
  wire[0:0] STAGE_LOOP_gp_not_1_nl;
  wire[0:0] STAGE_LOOP_gp_STAGE_LOOP_gp_or_nl;
  wire[0:0] STAGE_LOOP_gp_STAGE_LOOP_gp_or_1_nl;
  wire [9:0] nl_IDX_LOOP_1_lshift_rg_a;
  assign STAGE_LOOP_gp_not_1_nl = ~ and_307_ssc;
  assign STAGE_LOOP_gp_and_nl = MUX_v_8_2_2(8'b00000000, IDX_LOOP_t_10_2_sva_7_0,
      STAGE_LOOP_gp_not_1_nl);
  assign STAGE_LOOP_gp_STAGE_LOOP_gp_or_nl = (~(and_307_ssc | and_dcpl_288 | and_dcpl_289))
      | and_dcpl_292 | and_dcpl_293;
  assign STAGE_LOOP_gp_STAGE_LOOP_gp_or_1_nl = (~(and_dcpl_288 | and_dcpl_292)) |
      and_307_ssc | and_dcpl_289 | and_dcpl_293;
  assign nl_IDX_LOOP_1_lshift_rg_a = {STAGE_LOOP_gp_and_nl , STAGE_LOOP_gp_STAGE_LOOP_gp_or_nl
      , STAGE_LOOP_gp_STAGE_LOOP_gp_or_1_nl};
  wire[0:0] STAGE_LOOP_gp_or_nl;
  wire [3:0] nl_IDX_LOOP_1_lshift_rg_s;
  assign STAGE_LOOP_gp_or_nl = and_dcpl_288 | and_dcpl_289 | and_dcpl_292 | and_dcpl_293;
  assign nl_IDX_LOOP_1_lshift_rg_s = MUX_v_4_2_2((z_out_2[3:0]), STAGE_LOOP_gp_acc_psp_sva,
      STAGE_LOOP_gp_or_nl);
  wire [0:0] nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_33_tr0;
  assign nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_33_tr0 = ~ IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm;
  wire [0:0] nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_65_tr0;
  assign nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_65_tr0 = ~ IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm;
  wire [0:0] nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_97_tr0;
  assign nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_97_tr0 = ~ IDX_LOOP_slc_IDX_LOOP_acc_8_itm;
  wire [0:0] nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_129_tr0;
  assign nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_129_tr0 = ~ IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm;
  wire [0:0] nl_DIT_RELOOP_core_core_fsm_inst_GROUP_LOOP_C_0_tr0;
  assign nl_DIT_RELOOP_core_core_fsm_inst_GROUP_LOOP_C_0_tr0 = ~ z_out_1_10;
  wire [0:0] nl_DIT_RELOOP_core_core_fsm_inst_STAGE_LOOP_C_1_tr0;
  assign nl_DIT_RELOOP_core_core_fsm_inst_STAGE_LOOP_C_1_tr0 = STAGE_LOOP_acc_itm_4_1;
  ccs_in_v1 #(.rscid(32'sd5),
  .width(32'sd64)) p_rsci (
      .dat(p_rsc_dat),
      .idat(p_rsci_idat)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_3_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(vec_rsc_triosy_0_3_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_2_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(vec_rsc_triosy_0_2_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_1_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(vec_rsc_triosy_0_1_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) vec_rsc_triosy_0_0_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(vec_rsc_triosy_0_0_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) p_rsc_triosy_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(p_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) r_rsc_triosy_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(r_rsc_triosy_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_3_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_3_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_2_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_2_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_1_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_1_lz)
    );
  mgc_io_sync_v2 #(.valid(32'sd0)) twiddle_rsc_triosy_0_0_obj (
      .ld(reg_twiddle_rsc_triosy_0_0_obj_ld_cse),
      .lz(twiddle_rsc_triosy_0_0_lz)
    );
  mgc_rem #(.width_a(32'sd128),
  .width_b(32'sd64),
  .signd(32'sd0)) IDX_LOOP_1_IDX_LOOP_rem_1_cmp (
      .a(IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a),
      .b(reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse),
      .z(IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z)
    );
  modulo_dev  IDX_LOOP_1_modulo_dev_cmp (
      .base_rsc_dat(nl_IDX_LOOP_1_modulo_dev_cmp_base_rsc_dat[63:0]),
      .m_rsc_dat(nl_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat[63:0]),
      .return_rsc_z(IDX_LOOP_1_modulo_dev_cmp_return_rsc_z),
      .ccs_ccore_start_rsc_dat(nl_IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_start_rsc_dat[0:0]),
      .ccs_ccore_clk(clk),
      .ccs_ccore_srst(rst),
      .ccs_ccore_en(IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en)
    );
  mgc_shift_r_v5 #(.width_a(32'sd11),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) STAGE_LOOP_op_rshift_rg (
      .a(11'b10000000000),
      .s(STAGE_LOOP_i_3_0_sva),
      .z(STAGE_LOOP_op_rshift_itm)
    );
  mgc_shift_l_v5 #(.width_a(32'sd10),
  .signd_a(32'sd0),
  .width_s(32'sd4),
  .width_z(32'sd10)) IDX_LOOP_1_lshift_rg (
      .a(nl_IDX_LOOP_1_lshift_rg_a[9:0]),
      .s(nl_IDX_LOOP_1_lshift_rg_s[3:0]),
      .z(z_out_4)
    );
  DIT_RELOOP_core_wait_dp DIT_RELOOP_core_wait_dp_inst (
      .ensig_cgo_iro(nor_72_rmff),
      .ensig_cgo(reg_ensig_cgo_cse),
      .IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en(IDX_LOOP_1_modulo_dev_cmp_ccs_ccore_en)
    );
  DIT_RELOOP_core_core_fsm DIT_RELOOP_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .fsm_output(fsm_output),
      .IDX_LOOP_C_33_tr0(nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_33_tr0[0:0]),
      .IDX_LOOP_C_65_tr0(nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_65_tr0[0:0]),
      .IDX_LOOP_C_97_tr0(nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_97_tr0[0:0]),
      .IDX_LOOP_C_129_tr0(nl_DIT_RELOOP_core_core_fsm_inst_IDX_LOOP_C_129_tr0[0:0]),
      .GROUP_LOOP_C_0_tr0(nl_DIT_RELOOP_core_core_fsm_inst_GROUP_LOOP_C_0_tr0[0:0]),
      .STAGE_LOOP_C_1_tr0(nl_DIT_RELOOP_core_core_fsm_inst_STAGE_LOOP_C_1_tr0[0:0])
    );
  assign mux_72_nl = MUX_s_1_2_2((~ (fsm_output[2])), (fsm_output[2]), fsm_output[3]);
  assign or_59_nl = (fsm_output[3:2]!=2'b01);
  assign mux_73_nl = MUX_s_1_2_2(mux_72_nl, or_59_nl, or_60_cse);
  assign nor_72_rmff = ~(mux_73_nl | (fsm_output[4]) | (fsm_output[7]));
  assign or_60_cse = (fsm_output[1:0]!=2'b00);
  assign or_34_cse = (fsm_output[4:3]!=2'b00);
  assign or_212_cse = (fsm_output[4]) | (fsm_output[2]);
  assign and_182_cse = (fsm_output[1:0]==2'b11);
  assign or_23_nl = (fsm_output[6]) | (fsm_output[1]) | (fsm_output[3]) | (fsm_output[2])
      | (fsm_output[4]);
  assign mux_47_cse = MUX_s_1_2_2(or_tmp_5, or_23_nl, fsm_output[0]);
  assign or_24_cse = (fsm_output[5]) | mux_47_cse;
  assign and_73_itm = and_dcpl_68 & and_dcpl_39;
  assign nl_STAGE_LOOP_i_3_0_sva_2 = STAGE_LOOP_i_3_0_sva + 4'b0001;
  assign STAGE_LOOP_i_3_0_sva_2 = nl_STAGE_LOOP_i_3_0_sva_2[3:0];
  assign nl_IDX_LOOP_idx2_acc_tmp = ({IDX_LOOP_idx1_acc_psp_4_sva_mx0w0 , (z_out_3[0])})
      + (STAGE_LOOP_op_rshift_psp_1_sva[9:1]);
  assign IDX_LOOP_idx2_acc_tmp = nl_IDX_LOOP_idx2_acc_tmp[8:0];
  assign nl_IDX_LOOP_idx1_acc_psp_4_sva_mx0w0 = (z_out_3[8:1]) + IDX_LOOP_t_10_2_sva_7_0;
  assign IDX_LOOP_idx1_acc_psp_4_sva_mx0w0 = nl_IDX_LOOP_idx1_acc_psp_4_sva_mx0w0[7:0];
  assign nl_IDX_LOOP_idx2_9_0_2_sva_mx0w0 = ({IDX_LOOP_idx1_acc_psp_4_sva_mx0w0 ,
      (z_out_3[0]) , 1'b1}) + STAGE_LOOP_op_rshift_psp_1_sva;
  assign IDX_LOOP_idx2_9_0_2_sva_mx0w0 = nl_IDX_LOOP_idx2_9_0_2_sva_mx0w0[9:0];
  assign nl_IDX_LOOP_idx2_acc_1_psp_sva_mx0w0 = IDX_LOOP_idx1_acc_psp_3_sva_mx0w0
      + (STAGE_LOOP_op_rshift_psp_1_sva[9:1]);
  assign IDX_LOOP_idx2_acc_1_psp_sva_mx0w0 = nl_IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[8:0];
  assign nl_IDX_LOOP_idx1_acc_psp_3_sva_mx0w0 = (z_out_3[8:0]) + ({IDX_LOOP_t_10_2_sva_7_0
      , 1'b1});
  assign IDX_LOOP_idx1_acc_psp_3_sva_mx0w0 = nl_IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[8:0];
  assign nl_IDX_LOOP_idx2_9_0_sva_mx0w0 = ({IDX_LOOP_idx1_acc_psp_3_sva_mx0w0 , 1'b1})
      + STAGE_LOOP_op_rshift_psp_1_sva;
  assign IDX_LOOP_idx2_9_0_sva_mx0w0 = nl_IDX_LOOP_idx2_9_0_sva_mx0w0[9:0];
  assign nl_STAGE_LOOP_acc_nl = ({1'b1 , (~ STAGE_LOOP_i_3_0_sva_2)}) + 5'b01011;
  assign STAGE_LOOP_acc_nl = nl_STAGE_LOOP_acc_nl[4:0];
  assign STAGE_LOOP_acc_itm_4_1 = readslicef_5_1_4(STAGE_LOOP_acc_nl);
  assign and_dcpl = (fsm_output[5]) & (~ (fsm_output[7]));
  assign or_tmp_1 = (fsm_output[4:1]!=4'b0000);
  assign or_tmp_3 = (fsm_output[4:2]!=3'b000);
  assign and_tmp = (fsm_output[6]) & or_tmp_1;
  assign or_tmp_5 = (fsm_output[6]) | (fsm_output[3]) | (fsm_output[2]) | (fsm_output[4]);
  assign or_tmp_6 = (fsm_output[6:1]!=6'b000000);
  assign and_dcpl_11 = ~((fsm_output[7:6]!=2'b00));
  assign or_tmp_14 = (fsm_output[6:0]!=7'b0000000);
  assign and_15_cse = (fsm_output[6]) & or_tmp_3;
  assign mux_tmp_27 = MUX_s_1_2_2(or_34_cse, or_tmp_3, fsm_output[1]);
  assign and_dcpl_23 = (fsm_output[6]) & (~ (fsm_output[0]));
  assign or_41_cse = (fsm_output[6]) | mux_tmp_27;
  assign and_dcpl_37 = ~((fsm_output[5]) | (fsm_output[7]));
  assign and_dcpl_38 = ~((fsm_output[6]) | (fsm_output[0]));
  assign and_dcpl_39 = and_dcpl_38 & and_dcpl_37;
  assign and_dcpl_40 = ~((fsm_output[3]) | (fsm_output[1]));
  assign and_dcpl_41 = ~((fsm_output[2]) | (fsm_output[4]));
  assign and_dcpl_42 = and_dcpl_41 & and_dcpl_40;
  assign and_dcpl_44 = (~ (fsm_output[5])) & (fsm_output[7]);
  assign and_dcpl_45 = (~ (fsm_output[6])) & (fsm_output[0]);
  assign and_dcpl_46 = and_dcpl_45 & and_dcpl_44;
  assign and_dcpl_47 = (fsm_output[2]) & (~ (fsm_output[4]));
  assign and_dcpl_48 = and_dcpl_47 & and_dcpl_40;
  assign and_dcpl_51 = and_dcpl_47 & (~ (fsm_output[3]));
  assign and_dcpl_58 = and_dcpl_38 & and_dcpl;
  assign and_dcpl_59 = and_dcpl_48 & and_dcpl_58;
  assign and_dcpl_61 = and_dcpl_23 & and_dcpl_37;
  assign and_dcpl_62 = and_dcpl_48 & and_dcpl_61;
  assign and_dcpl_63 = and_dcpl_23 & and_dcpl;
  assign and_dcpl_64 = and_dcpl_48 & and_dcpl_63;
  assign and_dcpl_68 = and_dcpl_41 & (fsm_output[3]) & (~ (fsm_output[1]));
  assign or_62_nl = (fsm_output[4]) | (~ (fsm_output[2]));
  assign mux_tmp_59 = MUX_s_1_2_2(or_62_nl, or_212_cse, fsm_output[3]);
  assign and_dcpl_74 = (fsm_output[0]) & (~ (fsm_output[5]));
  assign and_dcpl_77 = and_dcpl_51 & (~ (fsm_output[1])) & (~ (fsm_output[6]));
  assign and_dcpl_81 = ~((fsm_output[4]) | (fsm_output[3]) | (fsm_output[6]) | (~
      and_dcpl_37));
  assign mux_tmp_68 = MUX_s_1_2_2((~ (fsm_output[2])), (fsm_output[2]), fsm_output[1]);
  assign or_205_cse = mux_tmp_68 | (~ (z_out_4[1]));
  assign and_dcpl_83 = (~ (fsm_output[3])) & (fsm_output[1]);
  assign and_dcpl_84 = and_dcpl_41 & and_dcpl_83;
  assign and_dcpl_85 = and_dcpl_84 & and_dcpl_39;
  assign and_dcpl_86 = and_dcpl_45 & and_dcpl_37;
  assign and_dcpl_87 = and_dcpl_84 & and_dcpl_86;
  assign or_cse = mux_tmp_68 | (z_out_4[1]);
  assign and_dcpl_92 = and_dcpl_41 & (~ (fsm_output[3]));
  assign and_dcpl_95 = and_dcpl_92 & (fsm_output[1]) & (~ (fsm_output[7]));
  assign and_dcpl_98 = ~((fsm_output[0]) | (fsm_output[5]));
  assign and_dcpl_101 = and_dcpl_45 & and_dcpl;
  assign and_dcpl_102 = and_dcpl_42 & and_dcpl_101;
  assign and_dcpl_103 = (fsm_output[6]) & (fsm_output[0]);
  assign and_dcpl_104 = and_dcpl_103 & and_dcpl_37;
  assign and_dcpl_105 = and_dcpl_42 & and_dcpl_104;
  assign and_dcpl_107 = and_dcpl_103 & and_dcpl;
  assign and_dcpl_108 = and_dcpl_42 & and_dcpl_107;
  assign and_dcpl_109 = and_dcpl_42 & and_dcpl_46;
  assign and_dcpl_110 = and_dcpl_38 & and_dcpl_44;
  assign and_dcpl_112 = reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 & (~ (fsm_output[0]));
  assign and_dcpl_114 = (fsm_output[1]) & (~ (fsm_output[6]));
  assign and_dcpl_115 = and_dcpl_92 & and_dcpl_114;
  assign and_dcpl_117 = and_dcpl_114 & and_dcpl;
  assign and_dcpl_120 = and_dcpl_84 & and_dcpl_104;
  assign and_dcpl_121 = (IDX_LOOP_idx1_acc_psp_3_sva[0]) & (~ (fsm_output[0]));
  assign and_dcpl_123 = (fsm_output[1]) & (fsm_output[6]);
  assign and_dcpl_124 = and_dcpl_92 & and_dcpl_123;
  assign and_dcpl_126 = and_dcpl_123 & and_dcpl;
  assign and_dcpl_127 = and_dcpl_92 & ((~ (IDX_LOOP_idx1_acc_psp_3_sva[0])) | (fsm_output[0]));
  assign and_dcpl_136 = and_dcpl_84 & and_dcpl_101;
  assign and_dcpl_139 = and_dcpl_123 & and_dcpl_37;
  assign and_dcpl_141 = and_dcpl_84 & and_dcpl_107;
  assign nor_33_cse = ~((fsm_output[0]) | reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8);
  assign and_dcpl_149 = ~((IDX_LOOP_idx1_acc_psp_3_sva[0]) | (fsm_output[0]));
  assign and_dcpl_152 = and_dcpl_92 & ((IDX_LOOP_idx1_acc_psp_3_sva[0]) | (fsm_output[0]));
  assign mux_61_nl = MUX_s_1_2_2(or_41_cse, or_tmp_5, fsm_output[0]);
  assign nor_25_nl = ~((fsm_output[5]) | mux_61_nl);
  assign not_tmp_98 = MUX_s_1_2_2(or_tmp_6, nor_25_nl, fsm_output[7]);
  assign or_dcpl_30 = or_212_cse | (fsm_output[3]) | (~ (fsm_output[1])) | (fsm_output[6])
      | (fsm_output[0]) | (fsm_output[5]) | (fsm_output[7]);
  assign mux_tmp_143 = MUX_s_1_2_2(and_dcpl_92, or_tmp_1, fsm_output[6]);
  assign mux_157_nl = MUX_s_1_2_2(and_dcpl_42, or_tmp_1, fsm_output[6]);
  assign mux_159_nl = MUX_s_1_2_2(mux_tmp_143, mux_157_nl, fsm_output[0]);
  assign mux_160_nl = MUX_s_1_2_2(mux_159_nl, (fsm_output[6]), fsm_output[5]);
  assign and_dcpl_165 = ~(mux_160_nl | (fsm_output[7]));
  assign nor_55_nl = ~(and_182_cse | (fsm_output[4:2]!=3'b000));
  assign mux_169_nl = MUX_s_1_2_2(nor_55_nl, or_tmp_3, fsm_output[5]);
  assign and_dcpl_175 = (~ mux_169_nl) & and_dcpl_11;
  assign mux_171_nl = MUX_s_1_2_2(and_15_cse, and_tmp, fsm_output[0]);
  assign mux_172_nl = MUX_s_1_2_2(mux_47_cse, (~ mux_171_nl), fsm_output[5]);
  assign and_dcpl_176 = mux_172_nl & (~ (fsm_output[7]));
  assign mux_174_nl = MUX_s_1_2_2(and_dcpl_92, or_tmp_3, fsm_output[6]);
  assign mux_173_nl = MUX_s_1_2_2(and_dcpl_42, or_tmp_3, fsm_output[6]);
  assign mux_175_nl = MUX_s_1_2_2(mux_174_nl, mux_173_nl, fsm_output[0]);
  assign mux_176_nl = MUX_s_1_2_2(mux_175_nl, (fsm_output[6]), fsm_output[5]);
  assign and_dcpl_177 = ~(mux_176_nl | (fsm_output[7]));
  assign mux_177_nl = MUX_s_1_2_2(mux_47_cse, (~ and_15_cse), fsm_output[5]);
  assign and_dcpl_178 = mux_177_nl & (~ (fsm_output[7]));
  assign and_dcpl_181 = and_dcpl_84 & (fsm_output[0]) & (fsm_output[5]) & (~ (fsm_output[7]));
  assign and_dcpl_182 = ~((reg_IDX_LOOP_1_lshift_idiv_ftd_8!=2'b00));
  assign and_dcpl_183 = and_dcpl_74 & (~ (fsm_output[7]));
  assign and_dcpl_184 = and_dcpl_183 & and_dcpl_182;
  assign and_dcpl_186 = (reg_IDX_LOOP_1_lshift_idiv_ftd_8==2'b01);
  assign and_dcpl_187 = and_dcpl_183 & and_dcpl_186;
  assign and_dcpl_189 = (reg_IDX_LOOP_1_lshift_idiv_ftd_8==2'b10);
  assign and_dcpl_190 = and_dcpl_183 & and_dcpl_189;
  assign and_dcpl_192 = (reg_IDX_LOOP_1_lshift_idiv_ftd_8==2'b11);
  assign and_dcpl_193 = and_dcpl_183 & and_dcpl_192;
  assign and_dcpl_197 = and_dcpl_98 & (~ (fsm_output[7]));
  assign and_dcpl_198 = and_dcpl_197 & and_dcpl_182;
  assign and_dcpl_200 = and_dcpl_197 & and_dcpl_186;
  assign and_dcpl_202 = and_dcpl_197 & and_dcpl_189;
  assign and_dcpl_204 = and_dcpl_197 & and_dcpl_192;
  assign and_dcpl_216 = and_dcpl_51 & and_dcpl_114;
  assign STAGE_LOOP_i_3_0_sva_mx0c1 = and_dcpl_48 & and_dcpl_46;
  assign GROUP_LOOP_j_10_0_sva_9_0_mx0c0 = and_dcpl_42 & and_dcpl_86;
  assign IDX_LOOP_modulo_dev_return_1_sva_mx0c0 = and_dcpl_115 & and_dcpl_184;
  assign IDX_LOOP_modulo_dev_return_1_sva_mx0c1 = and_dcpl_115 & and_dcpl_187;
  assign IDX_LOOP_modulo_dev_return_1_sva_mx0c2 = and_dcpl_115 & and_dcpl_190;
  assign IDX_LOOP_modulo_dev_return_1_sva_mx0c3 = and_dcpl_115 & and_dcpl_193;
  assign IDX_LOOP_modulo_dev_return_1_sva_mx0c4 = and_dcpl_41 & (fsm_output[3]) &
      (~ (fsm_output[1])) & (fsm_output[0]) & (~ (fsm_output[7]));
  assign tmp_2_lpi_4_dfm_mx0c0 = and_dcpl_77 & nor_33_cse & and_dcpl_37;
  assign tmp_2_lpi_4_dfm_mx0c1 = and_dcpl_77 & and_dcpl_112 & and_dcpl_37;
  assign and_164_nl = and_dcpl_124 & and_dcpl_149 & and_dcpl_37;
  assign and_165_nl = and_dcpl_152 & and_dcpl_139;
  assign vec_rsc_0_0_i_radr_d = MUX1HOT_v_8_6_2((IDX_LOOP_idx2_acc_tmp[8:1]), IDX_LOOP_idx1_acc_psp_4_sva,
      (IDX_LOOP_idx2_9_0_2_sva[9:2]), (IDX_LOOP_idx1_acc_psp_3_sva[8:1]), (IDX_LOOP_idx2_acc_1_psp_sva[8:1]),
      (IDX_LOOP_idx2_9_0_sva[9:2]), {and_dcpl_85 , and_dcpl_87 , and_dcpl_136 , and_164_nl
      , and_165_nl , and_dcpl_141});
  assign and_139_nl = and_dcpl_84 & and_dcpl_58;
  assign and_140_nl = and_dcpl_84 & and_dcpl_63;
  assign vec_rsc_0_0_i_wadr_d_pff = MUX1HOT_v_8_6_2((IDX_LOOP_idx2_acc_psp_sva[8:1]),
      IDX_LOOP_idx1_acc_psp_4_sva, (IDX_LOOP_idx2_9_0_2_sva[9:2]), (IDX_LOOP_idx2_acc_1_psp_sva[8:1]),
      (IDX_LOOP_idx1_acc_psp_3_sva[8:1]), (IDX_LOOP_idx2_9_0_sva[9:2]), {and_dcpl_102
      , and_139_nl , and_dcpl_105 , and_dcpl_108 , and_140_nl , and_dcpl_109});
  assign and_138_nl = and_dcpl_84 & (~ (fsm_output[0])) & (fsm_output[5]) & (~ (fsm_output[7]));
  assign vec_rsc_0_0_i_d_d_pff = MUX_v_64_2_2(IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z, IDX_LOOP_modulo_dev_return_1_sva,
      and_138_nl);
  assign nor_28_nl = ~(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 | (fsm_output[7]));
  assign nor_29_nl = ~((IDX_LOOP_idx1_acc_psp_3_sva[0]) | (fsm_output[7]));
  assign mux_143_nl = MUX_s_1_2_2(nor_28_nl, nor_29_nl, fsm_output[6]);
  assign and_235_nl = (fsm_output[1]) & (fsm_output[5]) & mux_143_nl;
  assign or_142_nl = (IDX_LOOP_idx2_9_0_sva[1:0]!=2'b00) | (~ (fsm_output[7]));
  assign or_140_nl = (IDX_LOOP_idx2_9_0_2_sva[1:0]!=2'b00) | (fsm_output[7]);
  assign mux_141_nl = MUX_s_1_2_2(or_142_nl, or_140_nl, fsm_output[6]);
  assign or_139_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) | (IDX_LOOP_idx2_acc_psp_sva[0])
      | (fsm_output[7]);
  assign or_138_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) | (IDX_LOOP_idx2_acc_1_psp_sva[0])
      | (fsm_output[7]);
  assign mux_140_nl = MUX_s_1_2_2(or_139_nl, or_138_nl, fsm_output[6]);
  assign mux_142_nl = MUX_s_1_2_2(mux_141_nl, mux_140_nl, fsm_output[5]);
  assign nor_30_nl = ~((fsm_output[1]) | mux_142_nl);
  assign mux_144_nl = MUX_s_1_2_2(and_235_nl, nor_30_nl, fsm_output[0]);
  assign vec_rsc_0_0_i_we_d_pff = mux_144_nl & and_dcpl_92;
  assign or_150_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) | (IDX_LOOP_idx2_acc_tmp[0]);
  assign and_234_nl = ((STAGE_LOOP_op_rshift_psp_1_sva[0]) | (IDX_LOOP_idx2_acc_1_psp_sva[0]))
      & (IDX_LOOP_idx1_acc_psp_3_sva[0]);
  assign mux_147_nl = MUX_s_1_2_2(or_150_nl, and_234_nl, fsm_output[6]);
  assign or_148_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) | (IDX_LOOP_idx2_acc_1_psp_sva[0])
      | (~ IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm) | (IDX_LOOP_idx1_acc_psp_3_sva[0]);
  assign mux_146_nl = MUX_s_1_2_2(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8, or_148_nl, fsm_output[6]);
  assign mux_148_nl = MUX_s_1_2_2(mux_147_nl, mux_146_nl, fsm_output[0]);
  assign nor_26_nl = ~((~ IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm) | (IDX_LOOP_idx2_9_0_2_sva[1:0]!=2'b00));
  assign nor_27_nl = ~((~ IDX_LOOP_slc_IDX_LOOP_acc_8_itm) | (IDX_LOOP_idx2_9_0_sva[1:0]!=2'b00));
  assign mux_145_nl = MUX_s_1_2_2(nor_26_nl, nor_27_nl, fsm_output[6]);
  assign nand_6_nl = ~((fsm_output[0]) & mux_145_nl);
  assign mux_149_nl = MUX_s_1_2_2(mux_148_nl, nand_6_nl, fsm_output[5]);
  assign vec_rsc_0_0_i_re_d_pff = (~ mux_149_nl) & and_dcpl_95;
  assign and_153_nl = and_dcpl_115 & nor_33_cse & and_dcpl;
  assign and_155_nl = and_dcpl_92 & (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 | (fsm_output[0]))
      & and_dcpl_117;
  assign and_158_nl = and_dcpl_124 & and_dcpl_149 & and_dcpl;
  assign and_160_nl = and_dcpl_152 & and_dcpl_126;
  assign vec_rsc_0_1_i_radr_d = MUX1HOT_v_8_6_2((IDX_LOOP_idx2_acc_tmp[8:1]), IDX_LOOP_idx1_acc_psp_4_sva,
      (IDX_LOOP_idx2_9_0_2_sva[9:2]), (IDX_LOOP_idx2_acc_1_psp_sva[8:1]), (IDX_LOOP_idx1_acc_psp_3_sva[8:1]),
      (IDX_LOOP_idx2_9_0_sva[9:2]), {and_dcpl_85 , and_153_nl , and_155_nl , and_dcpl_120
      , and_158_nl , and_160_nl});
  assign and_111_nl = and_dcpl_84 & and_dcpl_61;
  assign and_116_nl = and_dcpl_84 & and_dcpl_110;
  assign vec_rsc_0_1_i_wadr_d_pff = MUX1HOT_v_8_6_2((IDX_LOOP_idx2_acc_psp_sva[8:1]),
      (IDX_LOOP_idx2_9_0_2_sva[9:2]), IDX_LOOP_idx1_acc_psp_4_sva, (IDX_LOOP_idx2_acc_1_psp_sva[8:1]),
      (IDX_LOOP_idx2_9_0_sva[9:2]), (IDX_LOOP_idx1_acc_psp_3_sva[8:1]), {and_dcpl_102
      , and_dcpl_105 , and_111_nl , and_dcpl_108 , and_dcpl_109 , and_116_nl});
  assign and_105_nl = and_dcpl_41 & and_dcpl_98 & and_dcpl_83 & ((fsm_output[6])
      ^ (fsm_output[7]));
  assign vec_rsc_0_1_i_d_d_pff = MUX_v_64_2_2(IDX_LOOP_1_IDX_LOOP_rem_1_cmp_z, IDX_LOOP_modulo_dev_return_1_sva,
      and_105_nl);
  assign or_127_nl = (IDX_LOOP_idx1_acc_psp_3_sva[0]) | (~ (fsm_output[7]));
  assign or_126_nl = reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 | (fsm_output[7]);
  assign mux_133_nl = MUX_s_1_2_2(or_127_nl, or_126_nl, fsm_output[6]);
  assign nor_35_nl = ~((~ (fsm_output[1])) | (fsm_output[5]) | mux_133_nl);
  assign or_123_nl = (IDX_LOOP_idx2_9_0_sva[1:0]!=2'b01) | (~ (fsm_output[7]));
  assign or_121_nl = (IDX_LOOP_idx2_9_0_2_sva[1:0]!=2'b01) | (fsm_output[7]);
  assign mux_131_nl = MUX_s_1_2_2(or_123_nl, or_121_nl, fsm_output[6]);
  assign or_120_nl = (IDX_LOOP_idx2_acc_psp_sva[0]) | (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
      | (fsm_output[7]);
  assign or_119_nl = (IDX_LOOP_idx2_acc_1_psp_sva[0]) | (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
      | (fsm_output[7]);
  assign mux_130_nl = MUX_s_1_2_2(or_120_nl, or_119_nl, fsm_output[6]);
  assign mux_132_nl = MUX_s_1_2_2(mux_131_nl, mux_130_nl, fsm_output[5]);
  assign nor_36_nl = ~((fsm_output[1]) | mux_132_nl);
  assign mux_134_nl = MUX_s_1_2_2(nor_35_nl, nor_36_nl, fsm_output[0]);
  assign vec_rsc_0_1_i_we_d_pff = mux_134_nl & and_dcpl_92;
  assign nor_31_nl = ~((fsm_output[0]) | (IDX_LOOP_idx2_acc_tmp[0]));
  assign nor_32_nl = ~((~ (fsm_output[0])) | (~ IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm)
      | (IDX_LOOP_idx2_acc_1_psp_sva[0]));
  assign mux_138_nl = MUX_s_1_2_2(nor_31_nl, nor_32_nl, fsm_output[6]);
  assign and_236_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) & mux_138_nl;
  assign nand_8_nl = ~((fsm_output[0]) & (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 | (~
      IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm)));
  assign or_131_nl = (IDX_LOOP_idx2_9_0_2_sva[1:0]!=2'b01);
  assign mux_136_nl = MUX_s_1_2_2(nand_8_nl, nor_33_cse, or_131_nl);
  assign nand_9_nl = ~((IDX_LOOP_idx1_acc_psp_3_sva[0]) & ((IDX_LOOP_idx2_9_0_sva[1:0]!=2'b01)));
  assign nor_34_nl = ~((~ IDX_LOOP_slc_IDX_LOOP_acc_8_itm) | (IDX_LOOP_idx1_acc_psp_3_sva[0])
      | (IDX_LOOP_idx2_9_0_sva[1:0]!=2'b01));
  assign mux_135_nl = MUX_s_1_2_2(nand_9_nl, nor_34_nl, fsm_output[0]);
  assign mux_137_nl = MUX_s_1_2_2(mux_136_nl, mux_135_nl, fsm_output[6]);
  assign mux_139_nl = MUX_s_1_2_2(and_236_nl, mux_137_nl, fsm_output[5]);
  assign vec_rsc_0_1_i_re_d_pff = mux_139_nl & and_dcpl_95;
  assign and_143_nl = and_dcpl_124 & and_dcpl_121 & and_dcpl_37;
  assign and_145_nl = and_dcpl_127 & and_dcpl_139;
  assign vec_rsc_0_2_i_radr_d = MUX1HOT_v_8_6_2((IDX_LOOP_idx2_acc_tmp[8:1]), IDX_LOOP_idx1_acc_psp_4_sva,
      (IDX_LOOP_idx2_9_0_2_sva[9:2]), (IDX_LOOP_idx1_acc_psp_3_sva[8:1]), (IDX_LOOP_idx2_acc_1_psp_sva[8:1]),
      (IDX_LOOP_idx2_9_0_sva[9:2]), {and_dcpl_85 , and_dcpl_87 , and_dcpl_136 , and_143_nl
      , and_145_nl , and_dcpl_141});
  assign nor_40_nl = ~((~ reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8) | (fsm_output[7]));
  assign nor_41_nl = ~((~ (IDX_LOOP_idx1_acc_psp_3_sva[0])) | (fsm_output[7]));
  assign mux_123_nl = MUX_s_1_2_2(nor_40_nl, nor_41_nl, fsm_output[6]);
  assign and_239_nl = (fsm_output[1]) & (fsm_output[5]) & mux_123_nl;
  assign or_107_nl = (IDX_LOOP_idx2_9_0_sva[0]) | (~((IDX_LOOP_idx2_9_0_sva[1]) &
      (fsm_output[7])));
  assign or_106_nl = (IDX_LOOP_idx2_9_0_2_sva[1:0]!=2'b10) | (fsm_output[7]);
  assign mux_121_nl = MUX_s_1_2_2(or_107_nl, or_106_nl, fsm_output[6]);
  assign or_105_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) | (~ (IDX_LOOP_idx2_acc_psp_sva[0]))
      | (fsm_output[7]);
  assign or_104_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) | (~ (IDX_LOOP_idx2_acc_1_psp_sva[0]))
      | (fsm_output[7]);
  assign mux_120_nl = MUX_s_1_2_2(or_105_nl, or_104_nl, fsm_output[6]);
  assign mux_122_nl = MUX_s_1_2_2(mux_121_nl, mux_120_nl, fsm_output[5]);
  assign nor_42_nl = ~((fsm_output[1]) | mux_122_nl);
  assign mux_124_nl = MUX_s_1_2_2(and_239_nl, nor_42_nl, fsm_output[0]);
  assign vec_rsc_0_2_i_we_d_pff = mux_124_nl & and_dcpl_92;
  assign nor_37_nl = ~((STAGE_LOOP_op_rshift_psp_1_sva[0]) | (~ (IDX_LOOP_idx2_acc_tmp[0])));
  assign or_198_nl = (~((STAGE_LOOP_op_rshift_psp_1_sva[0]) | (~ (IDX_LOOP_idx2_acc_1_psp_sva[0]))))
      | (IDX_LOOP_idx1_acc_psp_3_sva[0]);
  assign mux_127_nl = MUX_s_1_2_2(nor_37_nl, or_198_nl, fsm_output[6]);
  assign and_237_nl = (~ (STAGE_LOOP_op_rshift_psp_1_sva[0])) & (IDX_LOOP_idx2_acc_1_psp_sva[0])
      & IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm & (IDX_LOOP_idx1_acc_psp_3_sva[0]);
  assign mux_126_nl = MUX_s_1_2_2(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8, and_237_nl,
      fsm_output[6]);
  assign mux_128_nl = MUX_s_1_2_2(mux_127_nl, mux_126_nl, fsm_output[0]);
  assign nor_38_nl = ~((~ IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm) | (IDX_LOOP_idx2_9_0_2_sva[1:0]!=2'b10));
  assign nor_39_nl = ~((~ IDX_LOOP_slc_IDX_LOOP_acc_8_itm) | (IDX_LOOP_idx2_9_0_sva[1:0]!=2'b10));
  assign mux_125_nl = MUX_s_1_2_2(nor_38_nl, nor_39_nl, fsm_output[6]);
  assign and_238_nl = (fsm_output[0]) & mux_125_nl;
  assign mux_129_nl = MUX_s_1_2_2(mux_128_nl, and_238_nl, fsm_output[5]);
  assign vec_rsc_0_2_i_re_d_pff = mux_129_nl & and_dcpl_95;
  assign and_121_nl = and_dcpl_115 & and_dcpl_112 & and_dcpl;
  assign and_124_nl = and_dcpl_92 & ((~ reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8) | (fsm_output[0]))
      & and_dcpl_117;
  assign and_130_nl = and_dcpl_124 & and_dcpl_121 & and_dcpl;
  assign and_133_nl = and_dcpl_127 & and_dcpl_126;
  assign vec_rsc_0_3_i_radr_d = MUX1HOT_v_8_6_2((IDX_LOOP_idx2_acc_tmp[8:1]), IDX_LOOP_idx1_acc_psp_4_sva,
      (IDX_LOOP_idx2_9_0_2_sva[9:2]), (IDX_LOOP_idx2_acc_1_psp_sva[8:1]), (IDX_LOOP_idx1_acc_psp_3_sva[8:1]),
      (IDX_LOOP_idx2_9_0_sva[9:2]), {and_dcpl_85 , and_121_nl , and_124_nl , and_dcpl_120
      , and_130_nl , and_133_nl});
  assign nand_13_nl = ~((IDX_LOOP_idx1_acc_psp_3_sva[0]) & (fsm_output[7]));
  assign or_93_nl = (~ reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8) | (fsm_output[7]);
  assign mux_113_nl = MUX_s_1_2_2(nand_13_nl, or_93_nl, fsm_output[6]);
  assign nor_45_nl = ~((~ (fsm_output[1])) | (fsm_output[5]) | mux_113_nl);
  assign nand_14_nl = ~((IDX_LOOP_idx2_9_0_sva[1:0]==2'b11) & (fsm_output[7]));
  assign or_90_nl = (IDX_LOOP_idx2_9_0_2_sva[1:0]!=2'b11) | (fsm_output[7]);
  assign mux_111_nl = MUX_s_1_2_2(nand_14_nl, or_90_nl, fsm_output[6]);
  assign or_89_nl = (~ (IDX_LOOP_idx2_acc_psp_sva[0])) | (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
      | (fsm_output[7]);
  assign or_88_nl = (~ (IDX_LOOP_idx2_acc_1_psp_sva[0])) | (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
      | (fsm_output[7]);
  assign mux_110_nl = MUX_s_1_2_2(or_89_nl, or_88_nl, fsm_output[6]);
  assign mux_112_nl = MUX_s_1_2_2(mux_111_nl, mux_110_nl, fsm_output[5]);
  assign nor_46_nl = ~((fsm_output[1]) | mux_112_nl);
  assign mux_114_nl = MUX_s_1_2_2(nor_45_nl, nor_46_nl, fsm_output[0]);
  assign vec_rsc_0_3_i_we_d_pff = mux_114_nl & and_dcpl_92;
  assign nor_43_nl = ~((fsm_output[0]) | (~ (IDX_LOOP_idx2_acc_tmp[0])));
  assign and_241_nl = (fsm_output[0]) & IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm & (IDX_LOOP_idx2_acc_1_psp_sva[0]);
  assign mux_118_nl = MUX_s_1_2_2(nor_43_nl, and_241_nl, fsm_output[6]);
  assign and_240_nl = (STAGE_LOOP_op_rshift_psp_1_sva[0]) & mux_118_nl;
  assign nor_44_nl = ~((fsm_output[0]) | (~ reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8));
  assign nand_11_nl = ~((fsm_output[0]) & (~(reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 &
      IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm)));
  assign and_242_nl = (IDX_LOOP_idx2_9_0_2_sva[1:0]==2'b11);
  assign mux_116_nl = MUX_s_1_2_2(nor_44_nl, nand_11_nl, and_242_nl);
  assign or_199_nl = (IDX_LOOP_idx1_acc_psp_3_sva[0]) | ((IDX_LOOP_idx2_9_0_sva[1:0]==2'b11));
  assign and_244_nl = IDX_LOOP_slc_IDX_LOOP_acc_8_itm & (IDX_LOOP_idx1_acc_psp_3_sva[0])
      & (IDX_LOOP_idx2_9_0_sva[1:0]==2'b11);
  assign mux_115_nl = MUX_s_1_2_2(or_199_nl, and_244_nl, fsm_output[0]);
  assign mux_117_nl = MUX_s_1_2_2(mux_116_nl, mux_115_nl, fsm_output[6]);
  assign mux_119_nl = MUX_s_1_2_2(and_240_nl, mux_117_nl, fsm_output[5]);
  assign vec_rsc_0_3_i_re_d_pff = mux_119_nl & and_dcpl_95;
  assign twiddle_rsc_0_0_i_radr_d_pff = z_out_4[9:2];
  assign twiddle_rsc_0_0_i_re_d_pff = (~(or_cse | (z_out_4[0]))) & and_dcpl_81;
  assign twiddle_rsc_0_1_i_re_d_pff = (~(or_cse | (~ (z_out_4[0])))) & and_dcpl_81;
  assign twiddle_rsc_0_2_i_re_d_pff = (~(or_205_cse | (z_out_4[0]))) & and_dcpl_81;
  assign twiddle_rsc_0_3_i_re_d_pff = (~(or_205_cse | (~ (z_out_4[0])))) & and_dcpl_81;
  assign and_dcpl_226 = ~((fsm_output[4:3]!=2'b00));
  assign and_dcpl_233 = and_dcpl_226 & (fsm_output[2:1]==2'b10) & and_dcpl_38 & (fsm_output[7])
      & (~ (fsm_output[5]));
  assign and_dcpl_246 = (fsm_output[4:1]==4'b0010) & and_dcpl_38 & (fsm_output[7])
      & (~ (fsm_output[5]));
  assign and_dcpl_258 = ~((fsm_output!=8'b00000010));
  assign and_dcpl_276 = and_dcpl_41 & (~ (fsm_output[3])) & (fsm_output[1]) & and_dcpl_39;
  assign and_dcpl_279 = (fsm_output[0]) & (~ (fsm_output[6])) & and_dcpl_37;
  assign and_dcpl_285 = (~ (fsm_output[0])) & (~ (fsm_output[6])) & and_dcpl_37;
  assign and_dcpl_287 = and_dcpl_41 & (~ (fsm_output[3])) & (fsm_output[1]);
  assign and_dcpl_288 = and_dcpl_287 & and_dcpl_285;
  assign and_dcpl_289 = and_dcpl_287 & and_dcpl_279;
  assign and_dcpl_291 = (~ (fsm_output[4])) & (fsm_output[2]) & and_dcpl_40;
  assign and_dcpl_292 = and_dcpl_291 & and_dcpl_285;
  assign and_dcpl_293 = and_dcpl_291 & and_dcpl_279;
  assign and_dcpl_300 = and_dcpl_291 & (~ (fsm_output[0])) & (~ (fsm_output[6]))
      & and_dcpl;
  assign and_dcpl_304 = and_dcpl_291 & and_dcpl_23 & (~ (fsm_output[7])) & (~ (fsm_output[5]));
  assign and_dcpl_306 = and_dcpl_291 & and_dcpl_23 & and_dcpl;
  assign and_dcpl_312 = and_dcpl_47 & (~ (fsm_output[3])) & (~ (fsm_output[1]));
  assign and_dcpl_313 = and_dcpl_312 & and_dcpl_38 & and_dcpl_37;
  assign and_dcpl_317 = and_dcpl_47 & (~ (fsm_output[3])) & (~ (fsm_output[1])) &
      (fsm_output[0]) & (~ (fsm_output[7]));
  assign and_dcpl_320 = and_dcpl_312 & and_dcpl_38 & and_dcpl;
  assign and_dcpl_323 = and_dcpl_312 & and_dcpl_23 & and_dcpl_37;
  assign and_dcpl_325 = and_dcpl_312 & and_dcpl_23 & and_dcpl;
  assign and_307_ssc = and_dcpl_41 & and_dcpl_40 & and_dcpl_279;
  assign IDX_LOOP_or_2_tmp = and_dcpl_317 | and_dcpl_320 | and_dcpl_323 | and_dcpl_325;
  always @(posedge clk) begin
    if ( rst ) begin
      STAGE_LOOP_i_3_0_sva <= 4'b0000;
    end
    else if ( (and_dcpl_42 & and_dcpl_39) | STAGE_LOOP_i_3_0_sva_mx0c1 ) begin
      STAGE_LOOP_i_3_0_sva <= MUX_v_4_2_2(4'b0001, STAGE_LOOP_i_3_0_sva_2, STAGE_LOOP_i_3_0_sva_mx0c1);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      p_sva <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~ mux_67_nl ) begin
      p_sva <= p_rsci_idat;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
      reg_ensig_cgo_cse <= 1'b0;
      IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a <= 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
      reg_twiddle_rsc_triosy_0_0_obj_ld_cse <= 1'b0;
      IDX_LOOP_f1_and_1_itm <= 1'b0;
      IDX_LOOP_f1_and_2_itm <= 1'b0;
      IDX_LOOP_f1_and_3_itm <= 1'b0;
      IDX_LOOP_f1_and_5_itm <= 1'b0;
      IDX_LOOP_f1_and_6_itm <= 1'b0;
      IDX_LOOP_f1_and_7_itm <= 1'b0;
      reg_IDX_LOOP_1_lshift_idiv_ftd_8 <= 2'b00;
    end
    else begin
      reg_IDX_LOOP_1_modulo_dev_cmp_m_rsc_dat_cse <= p_sva;
      reg_ensig_cgo_cse <= nor_72_rmff;
      IDX_LOOP_1_IDX_LOOP_rem_1_cmp_a <= MUX_v_128_2_2(z_out_3, IDX_LOOP_1_mul_mut,
          mux_82_nl);
      reg_twiddle_rsc_triosy_0_0_obj_ld_cse <= and_dcpl_77 & and_dcpl_74 & (fsm_output[7])
          & STAGE_LOOP_acc_itm_4_1;
      IDX_LOOP_f1_and_1_itm <= (STAGE_LOOP_op_rshift_psp_1_sva[0]) & (~ (IDX_LOOP_idx2_acc_tmp[0]))
          & (~ (z_out_3[0]));
      IDX_LOOP_f1_and_2_itm <= (IDX_LOOP_idx2_acc_tmp[0]) & (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
          & (~ (z_out_3[0]));
      IDX_LOOP_f1_and_3_itm <= (IDX_LOOP_idx2_acc_tmp[0]) & (STAGE_LOOP_op_rshift_psp_1_sva[0])
          & (~ (z_out_3[0]));
      IDX_LOOP_f1_and_5_itm <= (STAGE_LOOP_op_rshift_psp_1_sva[0]) & (~ (IDX_LOOP_idx2_acc_tmp[0]))
          & (z_out_3[0]);
      IDX_LOOP_f1_and_6_itm <= (IDX_LOOP_idx2_acc_tmp[0]) & (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
          & (z_out_3[0]);
      IDX_LOOP_f1_and_7_itm <= (IDX_LOOP_idx2_acc_tmp[0]) & (STAGE_LOOP_op_rshift_psp_1_sva[0])
          & (z_out_3[0]);
      reg_IDX_LOOP_1_lshift_idiv_ftd_8 <= z_out_4[1:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      STAGE_LOOP_op_rshift_psp_1_sva <= 10'b0000000000;
    end
    else if ( ~ not_tmp_98 ) begin
      STAGE_LOOP_op_rshift_psp_1_sva <= STAGE_LOOP_op_rshift_itm;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      STAGE_LOOP_gp_lshift_psp_sva <= 10'b0000000000;
    end
    else if ( ~ not_tmp_98 ) begin
      STAGE_LOOP_gp_lshift_psp_sva <= z_out_4;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      GROUP_LOOP_j_10_0_sva_9_0 <= 10'b0000000000;
    end
    else if ( GROUP_LOOP_j_10_0_sva_9_0_mx0c0 | (and_dcpl_48 & and_dcpl_110) ) begin
      GROUP_LOOP_j_10_0_sva_9_0 <= MUX_v_10_2_2(10'b0000000000, (z_out[9:0]), GROUP_LOOP_j_not_1_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_t_10_2_sva_7_0 <= 8'b00000000;
    end
    else if ( MUX_s_1_2_2(or_215_nl, nand_21_nl, fsm_output[5]) ) begin
      IDX_LOOP_t_10_2_sva_7_0 <= MUX_v_8_2_2(8'b00000000, reg_IDX_LOOP_t_10_2_ftd_1,
          or_206_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      STAGE_LOOP_gp_acc_psp_sva <= 4'b0000;
    end
    else if ( ~ not_tmp_98 ) begin
      STAGE_LOOP_gp_acc_psp_sva <= z_out_2[3:0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_idx2_acc_psp_sva <= 9'b000000000;
    end
    else if ( ~ or_dcpl_30 ) begin
      IDX_LOOP_idx2_acc_psp_sva <= IDX_LOOP_idx2_acc_tmp;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_idx1_acc_psp_4_sva <= 8'b00000000;
    end
    else if ( ~ and_dcpl_165 ) begin
      IDX_LOOP_idx1_acc_psp_4_sva <= IDX_LOOP_idx1_acc_psp_4_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_idx2_9_0_2_sva <= 10'b0000000000;
    end
    else if ( mux_162_nl | (fsm_output[7]) ) begin
      IDX_LOOP_idx2_9_0_2_sva <= IDX_LOOP_idx2_9_0_2_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm <= 1'b0;
    end
    else if ( ~ or_dcpl_30 ) begin
      IDX_LOOP_2_slc_IDX_LOOP_acc_10_itm <= z_out[10];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_itm <= 1'b0;
    end
    else if ( ~(mux_164_nl & and_dcpl_11) ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_itm <= MUX_s_1_2_2(IDX_LOOP_f1_IDX_LOOP_f1_nor_nl,
          IDX_LOOP_f1_and_9_nl, and_177_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_idx2_acc_1_psp_sva <= 9'b000000000;
    end
    else if ( ~(mux_167_nl & (~ (fsm_output[7]))) ) begin
      IDX_LOOP_idx2_acc_1_psp_sva <= IDX_LOOP_idx2_acc_1_psp_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_idx1_acc_psp_3_sva <= 9'b000000000;
    end
    else if ( MUX_s_1_2_2((~ or_24_cse), or_tmp_6, fsm_output[7]) ) begin
      IDX_LOOP_idx1_acc_psp_3_sva <= IDX_LOOP_idx1_acc_psp_3_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm <= 1'b0;
    end
    else if ( (~((or_tmp_3 | and_182_cse | (fsm_output[5])) ^ (fsm_output[6]))) |
        (fsm_output[7]) ) begin
      IDX_LOOP_3_slc_IDX_LOOP_acc_10_itm <= readslicef_11_1_10(IDX_LOOP_3_acc_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_1_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_175 ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_1_itm <= ~((IDX_LOOP_idx2_9_0_2_sva_mx0w0[1:0]!=2'b00)
          | (z_out_3[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_6_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_175 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_6_itm <= (IDX_LOOP_idx2_9_0_2_sva_mx0w0[1:0]==2'b01)
          & (~ (z_out_3[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_7_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_175 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_7_itm <= (IDX_LOOP_idx2_9_0_2_sva_mx0w0[1:0]==2'b10)
          & (~ (z_out_3[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_8_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_175 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_8_itm <= (IDX_LOOP_idx2_9_0_2_sva_mx0w0[1:0]==2'b11)
          & (~ (z_out_3[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_9_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_175 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_9_itm <= (IDX_LOOP_idx2_9_0_2_sva_mx0w0[1:0]==2'b01)
          & (z_out_3[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_10_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_175 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_10_itm <= (IDX_LOOP_idx2_9_0_2_sva_mx0w0[1:0]==2'b10)
          & (z_out_3[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_11_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_175 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_11_itm <= (IDX_LOOP_idx2_9_0_2_sva_mx0w0[1:0]==2'b11)
          & (z_out_3[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_idx2_9_0_sva <= 10'b0000000000;
    end
    else if ( MUX_s_1_2_2((~ or_24_cse), or_tmp_14, fsm_output[7]) ) begin
      IDX_LOOP_idx2_9_0_sva <= IDX_LOOP_idx2_9_0_sva_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_slc_IDX_LOOP_acc_8_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_176 ) begin
      IDX_LOOP_slc_IDX_LOOP_acc_8_itm <= readslicef_9_1_8(IDX_LOOP_acc_nl);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_2_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_177 ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_2_itm <= ~((IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[0])
          | (STAGE_LOOP_op_rshift_psp_1_sva[0]) | (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_and_11_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_177 ) begin
      IDX_LOOP_f1_and_11_itm <= (STAGE_LOOP_op_rshift_psp_1_sva[0]) & (~ (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[0]))
          & (~ (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_and_12_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_177 ) begin
      IDX_LOOP_f1_and_12_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[0]) & (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
          & (~ (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_and_13_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_177 ) begin
      IDX_LOOP_f1_and_13_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[0]) & (STAGE_LOOP_op_rshift_psp_1_sva[0])
          & (~ (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_and_15_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_177 ) begin
      IDX_LOOP_f1_and_15_itm <= (STAGE_LOOP_op_rshift_psp_1_sva[0]) & (~ (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[0]))
          & (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_and_16_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_177 ) begin
      IDX_LOOP_f1_and_16_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[0]) & (~ (STAGE_LOOP_op_rshift_psp_1_sva[0]))
          & (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_and_17_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_177 ) begin
      IDX_LOOP_f1_and_17_itm <= (IDX_LOOP_idx2_acc_1_psp_sva_mx0w0[0]) & (STAGE_LOOP_op_rshift_psp_1_sva[0])
          & (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm <= 1'b0;
    end
    else if ( ~(or_24_cse ^ (fsm_output[7])) ) begin
      IDX_LOOP_1_slc_IDX_LOOP_acc_10_itm <= z_out_1_10;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_3_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_178 ) begin
      IDX_LOOP_f1_IDX_LOOP_f1_nor_3_itm <= ~((IDX_LOOP_idx2_9_0_sva_mx0w0[1:0]!=2'b00)
          | (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_18_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_178 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_18_itm <= (IDX_LOOP_idx2_9_0_sva_mx0w0[1:0]==2'b01)
          & (~ (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_19_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_178 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_19_itm <= (IDX_LOOP_idx2_9_0_sva_mx0w0[1:0]==2'b10)
          & (~ (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_20_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_178 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_20_itm <= (IDX_LOOP_idx2_9_0_sva_mx0w0[1:0]==2'b11)
          & (~ (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_21_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_178 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_21_itm <= (IDX_LOOP_idx2_9_0_sva_mx0w0[1:0]==2'b01)
          & (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_22_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_178 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_22_itm <= (IDX_LOOP_idx2_9_0_sva_mx0w0[1:0]==2'b10)
          & (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_23_itm <= 1'b0;
    end
    else if ( ~ and_dcpl_178 ) begin
      IDX_LOOP_f2_IDX_LOOP_f2_and_23_itm <= (IDX_LOOP_idx2_9_0_sva_mx0w0[1:0]==2'b11)
          & (IDX_LOOP_idx1_acc_psp_3_sva_mx0w0[0]);
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      tmp_1_lpi_4_dfm_2 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_dcpl_87 | and_dcpl_181 | and_dcpl_59 | and_dcpl_120 | and_dcpl_62
        | and_dcpl_64 ) begin
      tmp_1_lpi_4_dfm_2 <= MUX1HOT_v_64_5_2(vec_rsc_0_0_i_q_d, vec_rsc_0_1_i_q_d,
          vec_rsc_0_2_i_q_d, vec_rsc_0_3_i_q_d, z_out_5, {IDX_LOOP_f2_and_nl , IDX_LOOP_f2_and_1_nl
          , IDX_LOOP_f2_or_nl , IDX_LOOP_f2_or_1_nl , IDX_LOOP_f2_or_3_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_modulo_dev_return_1_sva <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( IDX_LOOP_modulo_dev_return_1_sva_mx0c0 | IDX_LOOP_modulo_dev_return_1_sva_mx0c1
        | IDX_LOOP_modulo_dev_return_1_sva_mx0c2 | IDX_LOOP_modulo_dev_return_1_sva_mx0c3
        | IDX_LOOP_modulo_dev_return_1_sva_mx0c4 | and_dcpl_181 | and_dcpl_120 )
        begin
      IDX_LOOP_modulo_dev_return_1_sva <= MUX1HOT_v_64_7_2(twiddle_rsc_0_0_i_q_d,
          twiddle_rsc_0_1_i_q_d, twiddle_rsc_0_2_i_q_d, twiddle_rsc_0_3_i_q_d, IDX_LOOP_1_modulo_dev_cmp_return_rsc_z,
          vec_rsc_0_1_i_q_d, vec_rsc_0_0_i_q_d, {IDX_LOOP_modulo_dev_return_1_sva_mx0c0
          , IDX_LOOP_modulo_dev_return_1_sva_mx0c1 , IDX_LOOP_modulo_dev_return_1_sva_mx0c2
          , IDX_LOOP_modulo_dev_return_1_sva_mx0c3 , IDX_LOOP_modulo_dev_return_1_sva_mx0c4
          , and_dcpl_181 , and_dcpl_120});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_mux1h_1_itm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~(mux_182_nl & and_dcpl_11) ) begin
      IDX_LOOP_mux1h_1_itm <= MUX1HOT_v_64_4_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_1_i_q_d,
          twiddle_rsc_0_2_i_q_d, twiddle_rsc_0_3_i_q_d, {and_208_nl , and_210_nl
          , and_212_nl , and_214_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      tmp_2_lpi_4_dfm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( tmp_2_lpi_4_dfm_mx0c0 | tmp_2_lpi_4_dfm_mx0c1 | and_dcpl_136 | and_dcpl_120
        | and_dcpl_141 ) begin
      tmp_2_lpi_4_dfm <= MUX1HOT_v_64_4_2(vec_rsc_0_0_i_q_d, vec_rsc_0_2_i_q_d, vec_rsc_0_1_i_q_d,
          vec_rsc_0_3_i_q_d, {IDX_LOOP_f1_or_11_nl , IDX_LOOP_f1_or_12_nl , IDX_LOOP_f1_or_13_nl
          , IDX_LOOP_f1_or_14_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_mux1h_2_itm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( mux_186_nl | (fsm_output[7]) ) begin
      IDX_LOOP_mux1h_2_itm <= MUX1HOT_v_64_4_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_1_i_q_d,
          twiddle_rsc_0_2_i_q_d, twiddle_rsc_0_3_i_q_d, {and_220_nl , and_221_nl
          , and_222_nl , and_223_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_mux1h_3_itm <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( ~(mux_188_nl & (~ (fsm_output[7]))) ) begin
      IDX_LOOP_mux1h_3_itm <= MUX1HOT_v_64_4_2(twiddle_rsc_0_0_i_q_d, twiddle_rsc_0_1_i_q_d,
          twiddle_rsc_0_2_i_q_d, twiddle_rsc_0_3_i_q_d, {and_226_nl , and_227_nl
          , and_228_nl , and_229_nl});
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      IDX_LOOP_1_mul_mut <= 128'b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
    end
    else if ( and_73_itm | (and_dcpl_68 & and_dcpl_58) | (and_dcpl_68 & and_dcpl_61)
        | (and_dcpl_68 & and_dcpl_63) ) begin
      IDX_LOOP_1_mul_mut <= z_out_3;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 <= 1'b0;
    end
    else if ( ~ and_dcpl_165 ) begin
      reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 <= z_out_3[0];
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_IDX_LOOP_t_10_2_ftd_1 <= 8'b00000000;
    end
    else if ( ~ and_dcpl_176 ) begin
      reg_IDX_LOOP_t_10_2_ftd_1 <= z_out_2[7:0];
    end
  end
  assign nor_48_nl = ~((fsm_output[6:5]!=2'b00) | mux_tmp_27);
  assign mux_67_nl = MUX_s_1_2_2(or_tmp_14, nor_48_nl, fsm_output[7]);
  assign mux_77_nl = MUX_s_1_2_2((fsm_output[4]), or_212_cse, fsm_output[3]);
  assign mux_78_nl = MUX_s_1_2_2(mux_77_nl, or_34_cse, fsm_output[1]);
  assign mux_76_nl = MUX_s_1_2_2(mux_tmp_59, or_34_cse, fsm_output[1]);
  assign mux_79_nl = MUX_s_1_2_2(mux_78_nl, mux_76_nl, fsm_output[6]);
  assign mux_80_nl = MUX_s_1_2_2(mux_79_nl, or_34_cse, fsm_output[0]);
  assign mux_75_nl = MUX_s_1_2_2(mux_tmp_59, or_34_cse, or_60_cse);
  assign mux_81_nl = MUX_s_1_2_2(mux_80_nl, mux_75_nl, fsm_output[5]);
  assign mux_82_nl = MUX_s_1_2_2(mux_81_nl, (~ or_tmp_14), fsm_output[7]);
  assign GROUP_LOOP_j_not_1_nl = ~ GROUP_LOOP_j_10_0_sva_9_0_mx0c0;
  assign or_203_nl = (~ (fsm_output[0])) | (fsm_output[2]);
  assign or_204_nl = (fsm_output[0]) | (~ (fsm_output[2]));
  assign mux_64_nl = MUX_s_1_2_2(or_203_nl, or_204_nl, fsm_output[7]);
  assign or_206_nl = mux_64_nl | (fsm_output[4]) | (~ and_dcpl_40) | (fsm_output[6:5]!=2'b00);
  assign or_213_nl = (fsm_output[0]) | (fsm_output[7]);
  assign mux_nl = MUX_s_1_2_2((~ (fsm_output[7])), or_213_nl, fsm_output[2]);
  assign or_214_nl = (fsm_output[4]) | mux_nl;
  assign mux_192_nl = MUX_s_1_2_2(or_214_nl, or_212_cse, fsm_output[1]);
  assign or_215_nl = (fsm_output[6]) | (fsm_output[3]) | mux_192_nl;
  assign nand_21_nl = ~((fsm_output[6]) & (~((~((fsm_output[4:2]!=3'b000))) | (fsm_output[7]))));
  assign or_170_nl = (fsm_output[6]) | and_dcpl_42;
  assign mux_161_nl = MUX_s_1_2_2(mux_tmp_143, or_170_nl, fsm_output[0]);
  assign mux_162_nl = MUX_s_1_2_2(mux_161_nl, (fsm_output[6]), fsm_output[5]);
  assign IDX_LOOP_f1_IDX_LOOP_f1_nor_nl = ~((IDX_LOOP_idx2_acc_tmp[0]) | (STAGE_LOOP_op_rshift_psp_1_sva[0])
      | (z_out_3[0]));
  assign IDX_LOOP_f1_and_9_nl = (IDX_LOOP_idx2_9_0_2_sva[1:0]==2'b00) & reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8;
  assign and_177_nl = (~ (fsm_output[2])) & (fsm_output[4]) & and_dcpl_40 & and_dcpl_86;
  assign and_233_nl = (fsm_output[4]) & (fsm_output[2]);
  assign or_171_nl = (fsm_output[1]) | (fsm_output[3]);
  assign mux_163_nl = MUX_s_1_2_2(and_233_nl, (fsm_output[4]), or_171_nl);
  assign mux_164_nl = MUX_s_1_2_2(mux_163_nl, (~ or_tmp_3), fsm_output[5]);
  assign mux_165_nl = MUX_s_1_2_2(and_tmp, (fsm_output[6]), fsm_output[0]);
  assign mux_167_nl = MUX_s_1_2_2(mux_47_cse, (~ mux_165_nl), fsm_output[5]);
  assign nl_IDX_LOOP_3_acc_nl = ({1'b1 , (~ STAGE_LOOP_op_rshift_psp_1_sva)}) + conv_u2s_10_11({IDX_LOOP_t_10_2_sva_7_0
      , 2'b10}) + 11'b00000000001;
  assign IDX_LOOP_3_acc_nl = nl_IDX_LOOP_3_acc_nl[10:0];
  assign nl_IDX_LOOP_acc_nl = ({1'b1 , (~ (STAGE_LOOP_op_rshift_psp_1_sva[9:2]))})
      + conv_u2u_8_9(IDX_LOOP_t_10_2_sva_7_0) + 9'b000000001;
  assign IDX_LOOP_acc_nl = nl_IDX_LOOP_acc_nl[8:0];
  assign IDX_LOOP_f2_and_nl = (IDX_LOOP_f1_IDX_LOOP_f1_nor_itm | ((~((IDX_LOOP_idx2_acc_psp_sva[0])
      | (STAGE_LOOP_op_rshift_psp_1_sva[0]))) & reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8))
      & and_dcpl_87;
  assign IDX_LOOP_f2_and_1_nl = (IDX_LOOP_f1_and_1_itm | IDX_LOOP_f1_and_5_itm) &
      and_dcpl_87;
  assign IDX_LOOP_f2_or_nl = ((IDX_LOOP_f1_and_2_itm | IDX_LOOP_f1_and_6_itm) & and_dcpl_87)
      | and_dcpl_120;
  assign IDX_LOOP_f2_or_1_nl = ((IDX_LOOP_f1_and_3_itm | IDX_LOOP_f1_and_7_itm) &
      and_dcpl_87) | and_dcpl_181;
  assign IDX_LOOP_f2_or_3_nl = and_dcpl_59 | and_dcpl_62 | and_dcpl_64;
  assign and_208_nl = and_dcpl_77 & and_dcpl_198;
  assign and_210_nl = and_dcpl_77 & and_dcpl_200;
  assign and_212_nl = and_dcpl_77 & and_dcpl_202;
  assign and_214_nl = and_dcpl_77 & and_dcpl_204;
  assign mux_33_nl = MUX_s_1_2_2(or_34_cse, or_tmp_3, or_60_cse);
  assign mux_182_nl = MUX_s_1_2_2(mux_33_nl, (~ or_34_cse), fsm_output[5]);
  assign IDX_LOOP_f1_or_11_nl = tmp_2_lpi_4_dfm_mx0c0 | ((~ (IDX_LOOP_idx1_acc_psp_3_sva[0]))
      & and_dcpl_120);
  assign IDX_LOOP_f1_or_12_nl = tmp_2_lpi_4_dfm_mx0c1 | ((IDX_LOOP_idx1_acc_psp_3_sva[0])
      & and_dcpl_120);
  assign IDX_LOOP_f1_or_13_nl = ((~ reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8) & and_dcpl_136)
      | ((~ (IDX_LOOP_idx1_acc_psp_3_sva[0])) & and_dcpl_141);
  assign IDX_LOOP_f1_or_14_nl = (reg_IDX_LOOP_1_idx1_mul_sdt_ftd_8 & and_dcpl_136)
      | ((IDX_LOOP_idx1_acc_psp_3_sva[0]) & and_dcpl_141);
  assign and_220_nl = and_dcpl_77 & and_dcpl_184;
  assign and_221_nl = and_dcpl_77 & and_dcpl_187;
  assign and_222_nl = and_dcpl_77 & and_dcpl_190;
  assign and_223_nl = and_dcpl_77 & and_dcpl_193;
  assign mux_44_nl = MUX_s_1_2_2((~ mux_tmp_27), or_34_cse, fsm_output[6]);
  assign mux_186_nl = MUX_s_1_2_2(mux_44_nl, (fsm_output[6]), fsm_output[5]);
  assign and_226_nl = and_dcpl_216 & and_dcpl_198;
  assign and_227_nl = and_dcpl_216 & and_dcpl_200;
  assign and_228_nl = and_dcpl_216 & and_dcpl_202;
  assign and_229_nl = and_dcpl_216 & and_dcpl_204;
  assign or_26_nl = (fsm_output[6]) | (fsm_output[3]) | (fsm_output[4]);
  assign mux_187_nl = MUX_s_1_2_2(or_26_nl, or_41_cse, fsm_output[0]);
  assign nand_7_nl = ~((fsm_output[6]) & or_34_cse);
  assign mux_188_nl = MUX_s_1_2_2(mux_187_nl, nand_7_nl, fsm_output[5]);
  assign IDX_LOOP_mux_13_nl = MUX_v_10_2_2((~ STAGE_LOOP_op_rshift_psp_1_sva), GROUP_LOOP_j_10_0_sva_9_0,
      and_dcpl_233);
  assign IDX_LOOP_IDX_LOOP_nand_1_nl = ~(and_dcpl_233 & (~(and_dcpl_226 & (fsm_output[2:1]==2'b01)
      & and_dcpl_38 & and_dcpl_37)));
  assign not_442_nl = ~ and_dcpl_233;
  assign IDX_LOOP_IDX_LOOP_and_1_nl = MUX_v_8_2_2(8'b00000000, IDX_LOOP_t_10_2_sva_7_0,
      not_442_nl);
  assign nl_acc_nl = ({(~ and_dcpl_233) , IDX_LOOP_mux_13_nl , IDX_LOOP_IDX_LOOP_nand_1_nl})
      + conv_u2u_11_12({IDX_LOOP_IDX_LOOP_and_1_nl , 3'b011});
  assign acc_nl = nl_acc_nl[11:0];
  assign z_out = readslicef_12_11_1(acc_nl);
  assign IDX_LOOP_mux_14_nl = MUX_v_11_2_2(({z_out_2 , 2'b00}), z_out, and_dcpl_246);
  assign IDX_LOOP_mux_15_nl = MUX_v_10_2_2((~ STAGE_LOOP_op_rshift_psp_1_sva), (~
      STAGE_LOOP_gp_lshift_psp_sva), and_dcpl_246);
  assign nl_acc_1_nl = ({IDX_LOOP_mux_14_nl , 1'b1}) + ({1'b1 , IDX_LOOP_mux_15_nl
      , 1'b1});
  assign acc_1_nl = nl_acc_1_nl[11:0];
  assign z_out_1_10 = readslicef_12_1_11(acc_1_nl);
  assign STAGE_LOOP_gp_mux_5_nl = MUX_v_8_2_2(({4'b0000 , STAGE_LOOP_i_3_0_sva}),
      IDX_LOOP_t_10_2_sva_7_0, and_dcpl_258);
  assign nl_z_out_2 = conv_u2u_8_9(STAGE_LOOP_gp_mux_5_nl) + conv_s2u_2_9({(~ and_dcpl_258)
      , 1'b1});
  assign z_out_2 = nl_z_out_2[8:0];
  assign and_353_nl = and_dcpl_68 & and_dcpl_38 & and_dcpl;
  assign and_354_nl = and_dcpl_68 & and_dcpl_23 & and_dcpl_37;
  assign and_355_nl = and_dcpl_68 & and_dcpl_23 & and_dcpl;
  assign IDX_LOOP_mux1h_27_nl = MUX1HOT_v_64_5_2(IDX_LOOP_modulo_dev_return_1_sva,
      IDX_LOOP_mux1h_1_itm, IDX_LOOP_mux1h_2_itm, IDX_LOOP_mux1h_3_itm, ({55'b0000000000000000000000000000000000000000000000000000000
      , (GROUP_LOOP_j_10_0_sva_9_0[8:0])}), {and_73_itm , and_353_nl , and_354_nl
      , and_355_nl , and_dcpl_276});
  assign IDX_LOOP_mux_16_nl = MUX_v_64_2_2(IDX_LOOP_1_modulo_dev_cmp_return_rsc_z,
      ({55'b0000000000000000000000000000000000000000000000000000000 , (STAGE_LOOP_op_rshift_psp_1_sva[8:0])}),
      and_dcpl_276);
  assign z_out_3 = conv_u2u_128_128(IDX_LOOP_mux1h_27_nl * IDX_LOOP_mux_16_nl);
  assign IDX_LOOP_f1_or_19_nl = IDX_LOOP_f2_IDX_LOOP_f2_and_7_itm | IDX_LOOP_f2_IDX_LOOP_f2_and_10_itm;
  assign IDX_LOOP_f1_or_20_nl = IDX_LOOP_f2_IDX_LOOP_f2_and_19_itm | IDX_LOOP_f2_IDX_LOOP_f2_and_22_itm;
  assign IDX_LOOP_f1_mux1h_42_m1c = MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_19_nl, IDX_LOOP_f1_and_12_itm,
      IDX_LOOP_f1_or_20_nl, {and_dcpl_300 , and_dcpl_304 , and_dcpl_306});
  assign IDX_LOOP_f1_or_21_nl = IDX_LOOP_f1_and_13_itm | IDX_LOOP_f1_and_17_itm;
  assign IDX_LOOP_f1_mux1h_43_m1c = MUX1HOT_s_1_3_2(IDX_LOOP_f2_IDX_LOOP_f2_and_8_itm,
      IDX_LOOP_f1_or_21_nl, IDX_LOOP_f2_IDX_LOOP_f2_and_20_itm, {and_dcpl_300 , and_dcpl_304
      , and_dcpl_306});
  assign IDX_LOOP_f1_mux1h_45_m1c = MUX1HOT_s_1_3_2(IDX_LOOP_f2_IDX_LOOP_f2_and_11_itm,
      IDX_LOOP_f1_and_16_itm, IDX_LOOP_f2_IDX_LOOP_f2_and_23_itm, {and_dcpl_300 ,
      and_dcpl_304 , and_dcpl_306});
  assign IDX_LOOP_f1_or_16_nl = IDX_LOOP_f1_IDX_LOOP_f1_nor_1_itm | IDX_LOOP_f1_IDX_LOOP_f1_nor_itm;
  assign IDX_LOOP_f1_or_17_nl = IDX_LOOP_f1_IDX_LOOP_f1_nor_3_itm | ((IDX_LOOP_idx2_9_0_sva[1:0]==2'b00)
      & (IDX_LOOP_idx1_acc_psp_3_sva[0]));
  assign IDX_LOOP_f1_mux1h_40_nl = MUX1HOT_s_1_3_2(IDX_LOOP_f1_or_16_nl, IDX_LOOP_f1_IDX_LOOP_f1_nor_2_itm,
      IDX_LOOP_f1_or_17_nl, {and_dcpl_300 , and_dcpl_304 , and_dcpl_306});
  assign IDX_LOOP_f1_or_18_nl = IDX_LOOP_f1_and_11_itm | IDX_LOOP_f1_and_15_itm;
  assign IDX_LOOP_f1_mux1h_41_nl = MUX1HOT_s_1_3_2(IDX_LOOP_f2_IDX_LOOP_f2_and_6_itm,
      IDX_LOOP_f1_or_18_nl, IDX_LOOP_f2_IDX_LOOP_f2_and_18_itm, {and_dcpl_300 , and_dcpl_304
      , and_dcpl_306});
  assign IDX_LOOP_f1_or_nl = ((~ and_dcpl_304) & IDX_LOOP_f1_mux1h_42_m1c) | (and_dcpl_304
      & IDX_LOOP_f1_mux1h_45_m1c);
  assign IDX_LOOP_f1_or_22_nl = (and_dcpl_304 & IDX_LOOP_f1_mux1h_42_m1c) | ((~ and_dcpl_304)
      & IDX_LOOP_f1_mux1h_43_m1c);
  assign IDX_LOOP_f1_or_23_nl = (and_dcpl_304 & IDX_LOOP_f1_mux1h_43_m1c) | ((~ and_dcpl_304)
      & IDX_LOOP_f1_mux1h_45_m1c);
  assign IDX_LOOP_f1_and_26_nl = (~((IDX_LOOP_idx2_acc_1_psp_sva[0]) | (STAGE_LOOP_op_rshift_psp_1_sva[0])))
      & (IDX_LOOP_idx1_acc_psp_3_sva[0]);
  assign IDX_LOOP_f1_mux1h_44_nl = MUX1HOT_s_1_3_2(IDX_LOOP_f2_IDX_LOOP_f2_and_9_itm,
      IDX_LOOP_f1_and_26_nl, IDX_LOOP_f2_IDX_LOOP_f2_and_21_itm, {and_dcpl_300 ,
      and_dcpl_304 , and_dcpl_306});
  assign z_out_5 = MUX1HOT_v_64_6_2(vec_rsc_0_0_i_q_d, vec_rsc_0_1_i_q_d, vec_rsc_0_2_i_q_d,
      tmp_1_lpi_4_dfm_2, vec_rsc_0_3_i_q_d, IDX_LOOP_modulo_dev_return_1_sva, {IDX_LOOP_f1_mux1h_40_nl
      , IDX_LOOP_f1_mux1h_41_nl , IDX_LOOP_f1_or_nl , IDX_LOOP_f1_or_22_nl , IDX_LOOP_f1_or_23_nl
      , IDX_LOOP_f1_mux1h_44_nl});

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


  function automatic [63:0] MUX1HOT_v_64_6_2;
    input [63:0] input_5;
    input [63:0] input_4;
    input [63:0] input_3;
    input [63:0] input_2;
    input [63:0] input_1;
    input [63:0] input_0;
    input [5:0] sel;
    reg [63:0] result;
  begin
    result = input_0 & {64{sel[0]}};
    result = result | ( input_1 & {64{sel[1]}});
    result = result | ( input_2 & {64{sel[2]}});
    result = result | ( input_3 & {64{sel[3]}});
    result = result | ( input_4 & {64{sel[4]}});
    result = result | ( input_5 & {64{sel[5]}});
    MUX1HOT_v_64_6_2 = result;
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


  function automatic [7:0] MUX1HOT_v_8_6_2;
    input [7:0] input_5;
    input [7:0] input_4;
    input [7:0] input_3;
    input [7:0] input_2;
    input [7:0] input_1;
    input [7:0] input_0;
    input [5:0] sel;
    reg [7:0] result;
  begin
    result = input_0 & {8{sel[0]}};
    result = result | ( input_1 & {8{sel[1]}});
    result = result | ( input_2 & {8{sel[2]}});
    result = result | ( input_3 & {8{sel[3]}});
    result = result | ( input_4 & {8{sel[4]}});
    result = result | ( input_5 & {8{sel[5]}});
    MUX1HOT_v_8_6_2 = result;
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


  function automatic [127:0] MUX_v_128_2_2;
    input [127:0] input_0;
    input [127:0] input_1;
    input [0:0] sel;
    reg [127:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_128_2_2 = result;
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


  function automatic [0:0] readslicef_11_1_10;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 10;
    readslicef_11_1_10 = tmp[0:0];
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


  function automatic [0:0] readslicef_12_1_11;
    input [11:0] vector;
    reg [11:0] tmp;
  begin
    tmp = vector >> 11;
    readslicef_12_1_11 = tmp[0:0];
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


  function automatic [63:0] readslicef_65_64_1;
    input [64:0] vector;
    reg [64:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_65_64_1 = tmp[63:0];
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


  function automatic [8:0] conv_s2u_2_9 ;
    input [1:0]  vector ;
  begin
    conv_s2u_2_9 = {{7{vector[1]}}, vector};
  end
  endfunction


  function automatic [10:0] conv_u2s_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_11 =  {1'b0, vector};
  end
  endfunction


  function automatic [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function automatic [11:0] conv_u2u_11_12 ;
    input [10:0]  vector ;
  begin
    conv_u2u_11_12 = {1'b0, vector};
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
//  Design Unit:    DIT_RELOOP
// ------------------------------------------------------------------


module DIT_RELOOP (
  clk, rst, vec_rsc_0_0_radr, vec_rsc_0_0_re, vec_rsc_0_0_q, vec_rsc_0_0_wadr, vec_rsc_0_0_d,
      vec_rsc_0_0_we, vec_rsc_triosy_0_0_lz, vec_rsc_0_1_radr, vec_rsc_0_1_re, vec_rsc_0_1_q,
      vec_rsc_0_1_wadr, vec_rsc_0_1_d, vec_rsc_0_1_we, vec_rsc_triosy_0_1_lz, vec_rsc_0_2_radr,
      vec_rsc_0_2_re, vec_rsc_0_2_q, vec_rsc_0_2_wadr, vec_rsc_0_2_d, vec_rsc_0_2_we,
      vec_rsc_triosy_0_2_lz, vec_rsc_0_3_radr, vec_rsc_0_3_re, vec_rsc_0_3_q, vec_rsc_0_3_wadr,
      vec_rsc_0_3_d, vec_rsc_0_3_we, vec_rsc_triosy_0_3_lz, p_rsc_dat, p_rsc_triosy_lz,
      r_rsc_dat, r_rsc_triosy_lz, twiddle_rsc_0_0_radr, twiddle_rsc_0_0_re, twiddle_rsc_0_0_q,
      twiddle_rsc_triosy_0_0_lz, twiddle_rsc_0_1_radr, twiddle_rsc_0_1_re, twiddle_rsc_0_1_q,
      twiddle_rsc_triosy_0_1_lz, twiddle_rsc_0_2_radr, twiddle_rsc_0_2_re, twiddle_rsc_0_2_q,
      twiddle_rsc_triosy_0_2_lz, twiddle_rsc_0_3_radr, twiddle_rsc_0_3_re, twiddle_rsc_0_3_q,
      twiddle_rsc_triosy_0_3_lz
);
  input clk;
  input rst;
  output [7:0] vec_rsc_0_0_radr;
  output vec_rsc_0_0_re;
  input [63:0] vec_rsc_0_0_q;
  output [7:0] vec_rsc_0_0_wadr;
  output [63:0] vec_rsc_0_0_d;
  output vec_rsc_0_0_we;
  output vec_rsc_triosy_0_0_lz;
  output [7:0] vec_rsc_0_1_radr;
  output vec_rsc_0_1_re;
  input [63:0] vec_rsc_0_1_q;
  output [7:0] vec_rsc_0_1_wadr;
  output [63:0] vec_rsc_0_1_d;
  output vec_rsc_0_1_we;
  output vec_rsc_triosy_0_1_lz;
  output [7:0] vec_rsc_0_2_radr;
  output vec_rsc_0_2_re;
  input [63:0] vec_rsc_0_2_q;
  output [7:0] vec_rsc_0_2_wadr;
  output [63:0] vec_rsc_0_2_d;
  output vec_rsc_0_2_we;
  output vec_rsc_triosy_0_2_lz;
  output [7:0] vec_rsc_0_3_radr;
  output vec_rsc_0_3_re;
  input [63:0] vec_rsc_0_3_q;
  output [7:0] vec_rsc_0_3_wadr;
  output [63:0] vec_rsc_0_3_d;
  output vec_rsc_0_3_we;
  output vec_rsc_triosy_0_3_lz;
  input [63:0] p_rsc_dat;
  output p_rsc_triosy_lz;
  input [63:0] r_rsc_dat;
  output r_rsc_triosy_lz;
  output [7:0] twiddle_rsc_0_0_radr;
  output twiddle_rsc_0_0_re;
  input [63:0] twiddle_rsc_0_0_q;
  output twiddle_rsc_triosy_0_0_lz;
  output [7:0] twiddle_rsc_0_1_radr;
  output twiddle_rsc_0_1_re;
  input [63:0] twiddle_rsc_0_1_q;
  output twiddle_rsc_triosy_0_1_lz;
  output [7:0] twiddle_rsc_0_2_radr;
  output twiddle_rsc_0_2_re;
  input [63:0] twiddle_rsc_0_2_q;
  output twiddle_rsc_triosy_0_2_lz;
  output [7:0] twiddle_rsc_0_3_radr;
  output twiddle_rsc_0_3_re;
  input [63:0] twiddle_rsc_0_3_q;
  output twiddle_rsc_triosy_0_3_lz;


  // Interconnect Declarations
  wire [7:0] vec_rsc_0_0_i_radr_d;
  wire [63:0] vec_rsc_0_0_i_q_d;
  wire [7:0] vec_rsc_0_1_i_radr_d;
  wire [63:0] vec_rsc_0_1_i_q_d;
  wire [7:0] vec_rsc_0_2_i_radr_d;
  wire [63:0] vec_rsc_0_2_i_q_d;
  wire [7:0] vec_rsc_0_3_i_radr_d;
  wire [63:0] vec_rsc_0_3_i_q_d;
  wire [63:0] twiddle_rsc_0_0_i_q_d;
  wire [63:0] twiddle_rsc_0_1_i_q_d;
  wire [63:0] twiddle_rsc_0_2_i_q_d;
  wire [63:0] twiddle_rsc_0_3_i_q_d;
  wire [7:0] vec_rsc_0_0_i_wadr_d_iff;
  wire [63:0] vec_rsc_0_0_i_d_d_iff;
  wire vec_rsc_0_0_i_we_d_iff;
  wire vec_rsc_0_0_i_re_d_iff;
  wire [7:0] vec_rsc_0_1_i_wadr_d_iff;
  wire [63:0] vec_rsc_0_1_i_d_d_iff;
  wire vec_rsc_0_1_i_we_d_iff;
  wire vec_rsc_0_1_i_re_d_iff;
  wire vec_rsc_0_2_i_we_d_iff;
  wire vec_rsc_0_2_i_re_d_iff;
  wire vec_rsc_0_3_i_we_d_iff;
  wire vec_rsc_0_3_i_re_d_iff;
  wire [7:0] twiddle_rsc_0_0_i_radr_d_iff;
  wire twiddle_rsc_0_0_i_re_d_iff;
  wire twiddle_rsc_0_1_i_re_d_iff;
  wire twiddle_rsc_0_2_i_re_d_iff;
  wire twiddle_rsc_0_3_i_re_d_iff;


  // Interconnect Declarations for Component Instantiations 
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_9_64_8_256_256_64_5_gen vec_rsc_0_0_i
      (
      .we(vec_rsc_0_0_we),
      .d(vec_rsc_0_0_d),
      .wadr(vec_rsc_0_0_wadr),
      .q(vec_rsc_0_0_q),
      .re(vec_rsc_0_0_re),
      .radr(vec_rsc_0_0_radr),
      .radr_d(vec_rsc_0_0_i_radr_d),
      .wadr_d(vec_rsc_0_0_i_wadr_d_iff),
      .d_d(vec_rsc_0_0_i_d_d_iff),
      .we_d(vec_rsc_0_0_i_we_d_iff),
      .re_d(vec_rsc_0_0_i_re_d_iff),
      .q_d(vec_rsc_0_0_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_0_i_re_d_iff),
      .port_1_w_ram_ir_internal_WMASK_B_d(vec_rsc_0_0_i_we_d_iff)
    );
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_10_64_8_256_256_64_5_gen vec_rsc_0_1_i
      (
      .we(vec_rsc_0_1_we),
      .d(vec_rsc_0_1_d),
      .wadr(vec_rsc_0_1_wadr),
      .q(vec_rsc_0_1_q),
      .re(vec_rsc_0_1_re),
      .radr(vec_rsc_0_1_radr),
      .radr_d(vec_rsc_0_1_i_radr_d),
      .wadr_d(vec_rsc_0_1_i_wadr_d_iff),
      .d_d(vec_rsc_0_1_i_d_d_iff),
      .we_d(vec_rsc_0_1_i_we_d_iff),
      .re_d(vec_rsc_0_1_i_re_d_iff),
      .q_d(vec_rsc_0_1_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_1_i_re_d_iff),
      .port_1_w_ram_ir_internal_WMASK_B_d(vec_rsc_0_1_i_we_d_iff)
    );
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_11_64_8_256_256_64_5_gen vec_rsc_0_2_i
      (
      .we(vec_rsc_0_2_we),
      .d(vec_rsc_0_2_d),
      .wadr(vec_rsc_0_2_wadr),
      .q(vec_rsc_0_2_q),
      .re(vec_rsc_0_2_re),
      .radr(vec_rsc_0_2_radr),
      .radr_d(vec_rsc_0_2_i_radr_d),
      .wadr_d(vec_rsc_0_0_i_wadr_d_iff),
      .d_d(vec_rsc_0_0_i_d_d_iff),
      .we_d(vec_rsc_0_2_i_we_d_iff),
      .re_d(vec_rsc_0_2_i_re_d_iff),
      .q_d(vec_rsc_0_2_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_2_i_re_d_iff),
      .port_1_w_ram_ir_internal_WMASK_B_d(vec_rsc_0_2_i_we_d_iff)
    );
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rwport_12_64_8_256_256_64_5_gen vec_rsc_0_3_i
      (
      .we(vec_rsc_0_3_we),
      .d(vec_rsc_0_3_d),
      .wadr(vec_rsc_0_3_wadr),
      .q(vec_rsc_0_3_q),
      .re(vec_rsc_0_3_re),
      .radr(vec_rsc_0_3_radr),
      .radr_d(vec_rsc_0_3_i_radr_d),
      .wadr_d(vec_rsc_0_1_i_wadr_d_iff),
      .d_d(vec_rsc_0_1_i_d_d_iff),
      .we_d(vec_rsc_0_3_i_we_d_iff),
      .re_d(vec_rsc_0_3_i_re_d_iff),
      .q_d(vec_rsc_0_3_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(vec_rsc_0_3_i_re_d_iff),
      .port_1_w_ram_ir_internal_WMASK_B_d(vec_rsc_0_3_i_we_d_iff)
    );
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_13_64_8_256_256_64_5_gen twiddle_rsc_0_0_i
      (
      .q(twiddle_rsc_0_0_q),
      .re(twiddle_rsc_0_0_re),
      .radr(twiddle_rsc_0_0_radr),
      .radr_d(twiddle_rsc_0_0_i_radr_d_iff),
      .re_d(twiddle_rsc_0_0_i_re_d_iff),
      .q_d(twiddle_rsc_0_0_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_0_i_re_d_iff)
    );
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_14_64_8_256_256_64_5_gen twiddle_rsc_0_1_i
      (
      .q(twiddle_rsc_0_1_q),
      .re(twiddle_rsc_0_1_re),
      .radr(twiddle_rsc_0_1_radr),
      .radr_d(twiddle_rsc_0_0_i_radr_d_iff),
      .re_d(twiddle_rsc_0_1_i_re_d_iff),
      .q_d(twiddle_rsc_0_1_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_1_i_re_d_iff)
    );
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_15_64_8_256_256_64_5_gen twiddle_rsc_0_2_i
      (
      .q(twiddle_rsc_0_2_q),
      .re(twiddle_rsc_0_2_re),
      .radr(twiddle_rsc_0_2_radr),
      .radr_d(twiddle_rsc_0_0_i_radr_d_iff),
      .re_d(twiddle_rsc_0_2_i_re_d_iff),
      .q_d(twiddle_rsc_0_2_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_2_i_re_d_iff)
    );
  DIT_RELOOP_ccs_sample_mem_ccs_ram_sync_1R1W_rport_16_64_8_256_256_64_5_gen twiddle_rsc_0_3_i
      (
      .q(twiddle_rsc_0_3_q),
      .re(twiddle_rsc_0_3_re),
      .radr(twiddle_rsc_0_3_radr),
      .radr_d(twiddle_rsc_0_0_i_radr_d_iff),
      .re_d(twiddle_rsc_0_3_i_re_d_iff),
      .q_d(twiddle_rsc_0_3_i_q_d),
      .port_0_r_ram_ir_internal_RMASK_B_d(twiddle_rsc_0_3_i_re_d_iff)
    );
  DIT_RELOOP_core DIT_RELOOP_core_inst (
      .clk(clk),
      .rst(rst),
      .vec_rsc_triosy_0_0_lz(vec_rsc_triosy_0_0_lz),
      .vec_rsc_triosy_0_1_lz(vec_rsc_triosy_0_1_lz),
      .vec_rsc_triosy_0_2_lz(vec_rsc_triosy_0_2_lz),
      .vec_rsc_triosy_0_3_lz(vec_rsc_triosy_0_3_lz),
      .p_rsc_dat(p_rsc_dat),
      .p_rsc_triosy_lz(p_rsc_triosy_lz),
      .r_rsc_triosy_lz(r_rsc_triosy_lz),
      .twiddle_rsc_triosy_0_0_lz(twiddle_rsc_triosy_0_0_lz),
      .twiddle_rsc_triosy_0_1_lz(twiddle_rsc_triosy_0_1_lz),
      .twiddle_rsc_triosy_0_2_lz(twiddle_rsc_triosy_0_2_lz),
      .twiddle_rsc_triosy_0_3_lz(twiddle_rsc_triosy_0_3_lz),
      .vec_rsc_0_0_i_radr_d(vec_rsc_0_0_i_radr_d),
      .vec_rsc_0_0_i_q_d(vec_rsc_0_0_i_q_d),
      .vec_rsc_0_1_i_radr_d(vec_rsc_0_1_i_radr_d),
      .vec_rsc_0_1_i_q_d(vec_rsc_0_1_i_q_d),
      .vec_rsc_0_2_i_radr_d(vec_rsc_0_2_i_radr_d),
      .vec_rsc_0_2_i_q_d(vec_rsc_0_2_i_q_d),
      .vec_rsc_0_3_i_radr_d(vec_rsc_0_3_i_radr_d),
      .vec_rsc_0_3_i_q_d(vec_rsc_0_3_i_q_d),
      .twiddle_rsc_0_0_i_q_d(twiddle_rsc_0_0_i_q_d),
      .twiddle_rsc_0_1_i_q_d(twiddle_rsc_0_1_i_q_d),
      .twiddle_rsc_0_2_i_q_d(twiddle_rsc_0_2_i_q_d),
      .twiddle_rsc_0_3_i_q_d(twiddle_rsc_0_3_i_q_d),
      .vec_rsc_0_0_i_wadr_d_pff(vec_rsc_0_0_i_wadr_d_iff),
      .vec_rsc_0_0_i_d_d_pff(vec_rsc_0_0_i_d_d_iff),
      .vec_rsc_0_0_i_we_d_pff(vec_rsc_0_0_i_we_d_iff),
      .vec_rsc_0_0_i_re_d_pff(vec_rsc_0_0_i_re_d_iff),
      .vec_rsc_0_1_i_wadr_d_pff(vec_rsc_0_1_i_wadr_d_iff),
      .vec_rsc_0_1_i_d_d_pff(vec_rsc_0_1_i_d_d_iff),
      .vec_rsc_0_1_i_we_d_pff(vec_rsc_0_1_i_we_d_iff),
      .vec_rsc_0_1_i_re_d_pff(vec_rsc_0_1_i_re_d_iff),
      .vec_rsc_0_2_i_we_d_pff(vec_rsc_0_2_i_we_d_iff),
      .vec_rsc_0_2_i_re_d_pff(vec_rsc_0_2_i_re_d_iff),
      .vec_rsc_0_3_i_we_d_pff(vec_rsc_0_3_i_we_d_iff),
      .vec_rsc_0_3_i_re_d_pff(vec_rsc_0_3_i_re_d_iff),
      .twiddle_rsc_0_0_i_radr_d_pff(twiddle_rsc_0_0_i_radr_d_iff),
      .twiddle_rsc_0_0_i_re_d_pff(twiddle_rsc_0_0_i_re_d_iff),
      .twiddle_rsc_0_1_i_re_d_pff(twiddle_rsc_0_1_i_re_d_iff),
      .twiddle_rsc_0_2_i_re_d_pff(twiddle_rsc_0_2_i_re_d_iff),
      .twiddle_rsc_0_3_i_re_d_pff(twiddle_rsc_0_3_i_re_d_iff)
    );
endmodule



