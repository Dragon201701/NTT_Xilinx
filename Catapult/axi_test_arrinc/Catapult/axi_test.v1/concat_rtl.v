
//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_sync_in_wait_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2015 Mentor Graphics Corp.
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

module ccs_sync_in_wait_v1 (rdy, vld, irdy, ivld);
  parameter integer rscid = 1;

  output rdy;
  input  vld;
  input  irdy;
  output ivld;

  wire   ivld;
  wire   rdy;

  assign ivld = vld;
  assign rdy = irdy;
endmodule

//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_sync_out_wait_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2015 Mentor Graphics Corp.
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

module ccs_sync_out_wait_v1 (vld, irdy, ivld, rdy);
  parameter integer rscid = 1;

  input  ivld;
  output irdy;
  output vld;
  input  rdy;

  wire   irdy;
  wire   vld;

  assign vld = ivld;
  assign irdy = rdy;
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


//------> /opt/mentorgraphics/Catapult_10.5c/Mgc_home/pkgs/siflibs/ccs_out_v1.v 
//------------------------------------------------------------------------------
// Catapult Synthesis - Sample I/O Port Library
//
// Copyright (c) 2003-2015 Mentor Graphics Corp.
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

module ccs_out_v1 (dat, idat);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output   [width-1:0] dat;
  input    [width-1:0] idat;

  wire     [width-1:0] dat;

  assign dat = idat;

endmodule




//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Sat Jan 22 17:05:48 2022
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module axi_test_core_core_fsm (
  clk, rst, complete_rsci_wen_comp, fsm_output, main_C_0_tr0, ADD_LOOP_C_1_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [5:0] fsm_output;
  reg [5:0] fsm_output;
  input main_C_0_tr0;
  input ADD_LOOP_C_1_tr0;


  // FSM State Type Declaration for axi_test_core_core_fsm_1
  parameter
    core_rlp_C_0 = 3'd0,
    main_C_0 = 3'd1,
    ADD_LOOP_C_0 = 3'd2,
    ADD_LOOP_C_1 = 3'd3,
    main_C_1 = 3'd4,
    main_C_2 = 3'd5;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : axi_test_core_core_fsm_1
    case (state_var)
      main_C_0 : begin
        fsm_output = 6'b000010;
        if ( main_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = ADD_LOOP_C_0;
        end
      end
      ADD_LOOP_C_0 : begin
        fsm_output = 6'b000100;
        state_var_NS = ADD_LOOP_C_1;
      end
      ADD_LOOP_C_1 : begin
        fsm_output = 6'b001000;
        if ( ADD_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = ADD_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 6'b010000;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 6'b100000;
        state_var_NS = main_C_0;
      end
      // core_rlp_C_0
      default : begin
        fsm_output = 6'b000001;
        state_var_NS = main_C_0;
      end
    endcase
  end

  always @(posedge clk) begin
    if ( rst ) begin
      state_var <= core_rlp_C_0;
    end
    else if ( complete_rsci_wen_comp ) begin
      state_var <= state_var_NS;
    end
  end

endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_staller
// ------------------------------------------------------------------


module axi_test_core_staller (
  clk, rst, core_wten, complete_rsci_wen_comp
);
  input clk;
  input rst;
  output core_wten;
  reg core_wten;
  input complete_rsci_wen_comp;



  // Interconnect Declarations for Component Instantiations 
  always @(posedge clk) begin
    if ( rst ) begin
      core_wten <= 1'b0;
    end
    else begin
      core_wten <= ~ complete_rsci_wen_comp;
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl (
  core_wten, b_rsc_triosy_obj_iswt0, b_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input b_rsc_triosy_obj_iswt0;
  output b_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign b_rsc_triosy_obj_ld_core_sct = b_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl (
  core_wten, a_rsc_triosy_obj_iswt0, a_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input a_rsc_triosy_obj_iswt0;
  output a_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign a_rsc_triosy_obj_ld_core_sct = a_rsc_triosy_obj_iswt0 & (~ core_wten);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_complete_rsci_complete_wait_dp
// ------------------------------------------------------------------


module axi_test_core_complete_rsci_complete_wait_dp (
  clk, rst, complete_rsci_oswt, complete_rsci_wen_comp, complete_rsci_biwt, complete_rsci_bdwt,
      complete_rsci_bcwt
);
  input clk;
  input rst;
  input complete_rsci_oswt;
  output complete_rsci_wen_comp;
  input complete_rsci_biwt;
  input complete_rsci_bdwt;
  output complete_rsci_bcwt;
  reg complete_rsci_bcwt;



  // Interconnect Declarations for Component Instantiations 
  assign complete_rsci_wen_comp = (~ complete_rsci_oswt) | complete_rsci_biwt | complete_rsci_bcwt;
  always @(posedge clk) begin
    if ( rst ) begin
      complete_rsci_bcwt <= 1'b0;
    end
    else begin
      complete_rsci_bcwt <= ~((~(complete_rsci_bcwt | complete_rsci_biwt)) | complete_rsci_bdwt);
    end
  end
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_complete_rsci_complete_wait_ctrl
// ------------------------------------------------------------------


module axi_test_core_complete_rsci_complete_wait_ctrl (
  core_wen, complete_rsci_oswt, complete_rsci_biwt, complete_rsci_bdwt, complete_rsci_bcwt,
      complete_rsci_ivld_core_sct, complete_rsci_irdy
);
  input core_wen;
  input complete_rsci_oswt;
  output complete_rsci_biwt;
  output complete_rsci_bdwt;
  input complete_rsci_bcwt;
  output complete_rsci_ivld_core_sct;
  input complete_rsci_irdy;


  // Interconnect Declarations
  wire complete_rsci_ogwt;


  // Interconnect Declarations for Component Instantiations 
  assign complete_rsci_bdwt = complete_rsci_oswt & core_wen;
  assign complete_rsci_biwt = complete_rsci_ogwt & complete_rsci_irdy;
  assign complete_rsci_ogwt = complete_rsci_oswt & (~ complete_rsci_bcwt);
  assign complete_rsci_ivld_core_sct = complete_rsci_ogwt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_run_rsci_run_wait_dp
// ------------------------------------------------------------------


module axi_test_core_run_rsci_run_wait_dp (
  clk, rst, run_rsci_ivld_mxwt, run_rsci_ivld, run_rsci_biwt, run_rsci_bdwt
);
  input clk;
  input rst;
  output run_rsci_ivld_mxwt;
  input run_rsci_ivld;
  input run_rsci_biwt;
  input run_rsci_bdwt;


  // Interconnect Declarations
  reg run_rsci_bcwt;
  reg run_rsci_ivld_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign run_rsci_ivld_mxwt = MUX_s_1_2_2(run_rsci_ivld, run_rsci_ivld_bfwt, run_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      run_rsci_bcwt <= 1'b0;
    end
    else begin
      run_rsci_bcwt <= ~((~(run_rsci_bcwt | run_rsci_biwt)) | run_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( run_rsci_biwt ) begin
      run_rsci_ivld_bfwt <= run_rsci_ivld;
    end
  end

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

endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_run_rsci_run_wait_ctrl
// ------------------------------------------------------------------


module axi_test_core_run_rsci_run_wait_ctrl (
  core_wen, run_rsci_oswt, core_wten, run_rsci_biwt, run_rsci_bdwt
);
  input core_wen;
  input run_rsci_oswt;
  input core_wten;
  output run_rsci_biwt;
  output run_rsci_bdwt;



  // Interconnect Declarations for Component Instantiations 
  assign run_rsci_bdwt = run_rsci_oswt & core_wen;
  assign run_rsci_biwt = (~ core_wten) & run_rsci_oswt;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_b_rsc_triosy_obj
// ------------------------------------------------------------------


module axi_test_core_b_rsc_triosy_obj (
  b_rsc_triosy_lz, core_wten, b_rsc_triosy_obj_iswt0
);
  output b_rsc_triosy_lz;
  input core_wten;
  input b_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire b_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) b_rsc_triosy_obj (
      .ld(b_rsc_triosy_obj_ld_core_sct),
      .lz(b_rsc_triosy_lz)
    );
  axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl axi_test_core_b_rsc_triosy_obj_b_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .b_rsc_triosy_obj_iswt0(b_rsc_triosy_obj_iswt0),
      .b_rsc_triosy_obj_ld_core_sct(b_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_a_rsc_triosy_obj
// ------------------------------------------------------------------


module axi_test_core_a_rsc_triosy_obj (
  a_rsc_triosy_lz, core_wten, a_rsc_triosy_obj_iswt0
);
  output a_rsc_triosy_lz;
  input core_wten;
  input a_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire a_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) a_rsc_triosy_obj (
      .ld(a_rsc_triosy_obj_ld_core_sct),
      .lz(a_rsc_triosy_lz)
    );
  axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl axi_test_core_a_rsc_triosy_obj_a_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .a_rsc_triosy_obj_iswt0(a_rsc_triosy_obj_iswt0),
      .a_rsc_triosy_obj_ld_core_sct(a_rsc_triosy_obj_ld_core_sct)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_complete_rsci
// ------------------------------------------------------------------


module axi_test_core_complete_rsci (
  clk, rst, complete_rsc_rdy, complete_rsc_vld, core_wen, complete_rsci_oswt, complete_rsci_wen_comp
);
  input clk;
  input rst;
  input complete_rsc_rdy;
  output complete_rsc_vld;
  input core_wen;
  input complete_rsci_oswt;
  output complete_rsci_wen_comp;


  // Interconnect Declarations
  wire complete_rsci_biwt;
  wire complete_rsci_bdwt;
  wire complete_rsci_bcwt;
  wire complete_rsci_ivld_core_sct;
  wire complete_rsci_irdy;


  // Interconnect Declarations for Component Instantiations 
  ccs_sync_out_wait_v1 #(.rscid(32'sd4)) complete_rsci (
      .vld(complete_rsc_vld),
      .rdy(complete_rsc_rdy),
      .ivld(complete_rsci_ivld_core_sct),
      .irdy(complete_rsci_irdy)
    );
  axi_test_core_complete_rsci_complete_wait_ctrl axi_test_core_complete_rsci_complete_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .complete_rsci_oswt(complete_rsci_oswt),
      .complete_rsci_biwt(complete_rsci_biwt),
      .complete_rsci_bdwt(complete_rsci_bdwt),
      .complete_rsci_bcwt(complete_rsci_bcwt),
      .complete_rsci_ivld_core_sct(complete_rsci_ivld_core_sct),
      .complete_rsci_irdy(complete_rsci_irdy)
    );
  axi_test_core_complete_rsci_complete_wait_dp axi_test_core_complete_rsci_complete_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .complete_rsci_oswt(complete_rsci_oswt),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .complete_rsci_biwt(complete_rsci_biwt),
      .complete_rsci_bdwt(complete_rsci_bdwt),
      .complete_rsci_bcwt(complete_rsci_bcwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_run_rsci
// ------------------------------------------------------------------


module axi_test_core_run_rsci (
  clk, rst, run_rsc_rdy, run_rsc_vld, core_wen, run_rsci_oswt, core_wten, run_rsci_ivld_mxwt
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  input core_wen;
  input run_rsci_oswt;
  input core_wten;
  output run_rsci_ivld_mxwt;


  // Interconnect Declarations
  wire run_rsci_ivld;
  wire run_rsci_biwt;
  wire run_rsci_bdwt;


  // Interconnect Declarations for Component Instantiations 
  ccs_sync_in_wait_v1 #(.rscid(32'sd1)) run_rsci (
      .vld(run_rsc_vld),
      .rdy(run_rsc_rdy),
      .ivld(run_rsci_ivld),
      .irdy(run_rsci_biwt)
    );
  axi_test_core_run_rsci_run_wait_ctrl axi_test_core_run_rsci_run_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .run_rsci_oswt(run_rsci_oswt),
      .core_wten(core_wten),
      .run_rsci_biwt(run_rsci_biwt),
      .run_rsci_bdwt(run_rsci_bdwt)
    );
  axi_test_core_run_rsci_run_wait_dp axi_test_core_run_rsci_run_wait_dp_inst (
      .clk(clk),
      .rst(rst),
      .run_rsci_ivld_mxwt(run_rsci_ivld_mxwt),
      .run_rsci_ivld(run_rsci_ivld),
      .run_rsci_biwt(run_rsci_biwt),
      .run_rsci_bdwt(run_rsci_bdwt)
    );
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core
// ------------------------------------------------------------------


module axi_test_core (
  clk, rst, run_rsc_rdy, run_rsc_vld, a_rsc_dat, a_rsc_triosy_lz, b_rsc_dat, b_rsc_triosy_lz,
      complete_rsc_rdy, complete_rsc_vld
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  input [511:0] a_rsc_dat;
  output a_rsc_triosy_lz;
  output [511:0] b_rsc_dat;
  output b_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;


  // Interconnect Declarations
  wire core_wten;
  wire run_rsci_ivld_mxwt;
  wire [511:0] a_rsci_idat;
  wire complete_rsci_wen_comp;
  reg [29:0] b_rsci_idat_511_482;
  reg [1:0] b_rsci_idat_481_480;
  reg [29:0] b_rsci_idat_479_450;
  reg [1:0] b_rsci_idat_449_448;
  reg [29:0] b_rsci_idat_447_418;
  reg [1:0] b_rsci_idat_417_416;
  reg [29:0] b_rsci_idat_415_386;
  reg [1:0] b_rsci_idat_385_384;
  reg [29:0] b_rsci_idat_383_354;
  reg [1:0] b_rsci_idat_353_352;
  reg [29:0] b_rsci_idat_351_322;
  reg [1:0] b_rsci_idat_321_320;
  reg [29:0] b_rsci_idat_319_290;
  reg [1:0] b_rsci_idat_289_288;
  reg [29:0] b_rsci_idat_287_258;
  reg [1:0] b_rsci_idat_257_256;
  reg [29:0] b_rsci_idat_255_226;
  reg [1:0] b_rsci_idat_225_224;
  reg [29:0] b_rsci_idat_223_194;
  reg [1:0] b_rsci_idat_193_192;
  reg [29:0] b_rsci_idat_191_162;
  reg [1:0] b_rsci_idat_161_160;
  reg [29:0] b_rsci_idat_159_130;
  reg [1:0] b_rsci_idat_129_128;
  reg [29:0] b_rsci_idat_127_98;
  reg [1:0] b_rsci_idat_97_96;
  reg [29:0] b_rsci_idat_95_66;
  reg [1:0] b_rsci_idat_65_64;
  reg [29:0] b_rsci_idat_63_34;
  reg [1:0] b_rsci_idat_33_32;
  reg [29:0] b_rsci_idat_31_2;
  reg [1:0] b_rsci_idat_1_0;
  wire [5:0] fsm_output;
  wire or_dcpl_27;
  wire or_dcpl_28;
  wire or_dcpl_30;
  wire or_dcpl_31;
  wire or_dcpl_33;
  wire or_dcpl_35;
  wire or_dcpl_41;
  wire or_dcpl_43;
  wire or_tmp_36;
  wire or_tmp_39;
  wire or_tmp_48;
  wire or_tmp_51;
  wire or_tmp_60;
  wire or_tmp_63;
  wire or_tmp_72;
  wire or_tmp_75;
  wire or_tmp_84;
  wire or_tmp_87;
  wire or_tmp_96;
  wire or_tmp_99;
  wire or_tmp_108;
  wire or_tmp_111;
  wire or_tmp_120;
  wire or_tmp_123;
  reg [3:0] ADD_LOOP_i_4_0_sva_3_0;
  reg [4:0] ADD_LOOP_i_4_0_sva_1;
  wire [5:0] nl_ADD_LOOP_i_4_0_sva_1;
  reg run_ac_sync_tmp_dobj_sva;
  reg reg_run_rsci_oswt_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_a_rsc_triosy_obj_iswt0_cse;
  wire ADD_LOOP_and_cse;
  wire [31:0] drf_a_ptr_smx_sva_1;
  reg [29:0] b_rsc_1_511_482_lpi_1_dfm;
  reg [1:0] b_rsc_1_481_480_lpi_1_dfm;
  reg [29:0] b_rsc_1_479_450_lpi_1_dfm;
  reg [1:0] b_rsc_1_449_448_lpi_1_dfm;
  reg [29:0] b_rsc_1_447_418_lpi_1_dfm;
  reg [1:0] b_rsc_1_417_416_lpi_1_dfm;
  reg [29:0] b_rsc_1_415_386_lpi_1_dfm;
  reg [1:0] b_rsc_1_385_384_lpi_1_dfm;
  reg [29:0] b_rsc_1_383_354_lpi_1_dfm;
  reg [1:0] b_rsc_1_353_352_lpi_1_dfm;
  reg [29:0] b_rsc_1_351_322_lpi_1_dfm;
  reg [1:0] b_rsc_1_321_320_lpi_1_dfm;
  reg [29:0] b_rsc_1_319_290_lpi_1_dfm;
  reg [1:0] b_rsc_1_289_288_lpi_1_dfm;
  reg [29:0] b_rsc_1_287_258_lpi_1_dfm;
  reg [1:0] b_rsc_1_257_256_lpi_1_dfm;
  reg [29:0] b_rsc_1_255_226_lpi_1_dfm;
  reg [1:0] b_rsc_1_225_224_lpi_1_dfm;
  reg [29:0] b_rsc_1_223_194_lpi_1_dfm;
  reg [1:0] b_rsc_1_193_192_lpi_1_dfm;
  reg [29:0] b_rsc_1_191_162_lpi_1_dfm;
  reg [1:0] b_rsc_1_161_160_lpi_1_dfm;
  reg [29:0] b_rsc_1_159_130_lpi_1_dfm;
  reg [1:0] b_rsc_1_129_128_lpi_1_dfm;
  reg [29:0] b_rsc_1_127_98_lpi_1_dfm;
  reg [1:0] b_rsc_1_97_96_lpi_1_dfm;
  reg [29:0] b_rsc_1_95_66_lpi_1_dfm;
  reg [1:0] b_rsc_1_65_64_lpi_1_dfm;
  reg [29:0] b_rsc_1_63_34_lpi_1_dfm;
  reg [1:0] b_rsc_1_33_32_lpi_1_dfm;
  reg [29:0] b_rsc_1_31_2_lpi_1_dfm;
  reg [1:0] b_rsc_1_1_0_lpi_1_dfm;
  wire [29:0] operator_32_false_acc_psp_sva_1;
  wire [30:0] nl_operator_32_false_acc_psp_sva_1;
  wire b_and_cse;


  // Interconnect Declarations for Component Instantiations 
  wire [511:0] nl_b_rsci_idat;
  assign nl_b_rsci_idat = {b_rsci_idat_511_482 , b_rsci_idat_481_480 , b_rsci_idat_479_450
      , b_rsci_idat_449_448 , b_rsci_idat_447_418 , b_rsci_idat_417_416 , b_rsci_idat_415_386
      , b_rsci_idat_385_384 , b_rsci_idat_383_354 , b_rsci_idat_353_352 , b_rsci_idat_351_322
      , b_rsci_idat_321_320 , b_rsci_idat_319_290 , b_rsci_idat_289_288 , b_rsci_idat_287_258
      , b_rsci_idat_257_256 , b_rsci_idat_255_226 , b_rsci_idat_225_224 , b_rsci_idat_223_194
      , b_rsci_idat_193_192 , b_rsci_idat_191_162 , b_rsci_idat_161_160 , b_rsci_idat_159_130
      , b_rsci_idat_129_128 , b_rsci_idat_127_98 , b_rsci_idat_97_96 , b_rsci_idat_95_66
      , b_rsci_idat_65_64 , b_rsci_idat_63_34 , b_rsci_idat_33_32 , b_rsci_idat_31_2
      , b_rsci_idat_1_0};
  wire [0:0] nl_axi_test_core_core_fsm_inst_main_C_0_tr0;
  assign nl_axi_test_core_core_fsm_inst_main_C_0_tr0 = ~ run_ac_sync_tmp_dobj_sva;
  wire [0:0] nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_1_tr0;
  assign nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_1_tr0 = ADD_LOOP_i_4_0_sva_1[4];
  ccs_in_v1 #(.rscid(32'sd2),
  .width(32'sd512)) a_rsci (
      .dat(a_rsc_dat),
      .idat(a_rsci_idat)
    );
  ccs_out_v1 #(.rscid(32'sd3),
  .width(32'sd512)) b_rsci (
      .idat(nl_b_rsci_idat[511:0]),
      .dat(b_rsc_dat)
    );
  axi_test_core_run_rsci axi_test_core_run_rsci_inst (
      .clk(clk),
      .rst(rst),
      .run_rsc_rdy(run_rsc_rdy),
      .run_rsc_vld(run_rsc_vld),
      .core_wen(complete_rsci_wen_comp),
      .run_rsci_oswt(reg_run_rsci_oswt_cse),
      .core_wten(core_wten),
      .run_rsci_ivld_mxwt(run_rsci_ivld_mxwt)
    );
  axi_test_core_complete_rsci axi_test_core_complete_rsci_inst (
      .clk(clk),
      .rst(rst),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld),
      .core_wen(complete_rsci_wen_comp),
      .complete_rsci_oswt(reg_complete_rsci_oswt_cse),
      .complete_rsci_wen_comp(complete_rsci_wen_comp)
    );
  axi_test_core_a_rsc_triosy_obj axi_test_core_a_rsc_triosy_obj_inst (
      .a_rsc_triosy_lz(a_rsc_triosy_lz),
      .core_wten(core_wten),
      .a_rsc_triosy_obj_iswt0(reg_a_rsc_triosy_obj_iswt0_cse)
    );
  axi_test_core_b_rsc_triosy_obj axi_test_core_b_rsc_triosy_obj_inst (
      .b_rsc_triosy_lz(b_rsc_triosy_lz),
      .core_wten(core_wten),
      .b_rsc_triosy_obj_iswt0(reg_a_rsc_triosy_obj_iswt0_cse)
    );
  axi_test_core_staller axi_test_core_staller_inst (
      .clk(clk),
      .rst(rst),
      .core_wten(core_wten),
      .complete_rsci_wen_comp(complete_rsci_wen_comp)
    );
  axi_test_core_core_fsm axi_test_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .fsm_output(fsm_output),
      .main_C_0_tr0(nl_axi_test_core_core_fsm_inst_main_C_0_tr0[0:0]),
      .ADD_LOOP_C_1_tr0(nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_1_tr0[0:0])
    );
  assign ADD_LOOP_and_cse = complete_rsci_wen_comp & (fsm_output[2]);
  assign b_and_cse = complete_rsci_wen_comp & (fsm_output[3]);
  assign drf_a_ptr_smx_sva_1 = MUX_v_32_16_2((a_rsci_idat[31:0]), (a_rsci_idat[63:32]),
      (a_rsci_idat[95:64]), (a_rsci_idat[127:96]), (a_rsci_idat[159:128]), (a_rsci_idat[191:160]),
      (a_rsci_idat[223:192]), (a_rsci_idat[255:224]), (a_rsci_idat[287:256]), (a_rsci_idat[319:288]),
      (a_rsci_idat[351:320]), (a_rsci_idat[383:352]), (a_rsci_idat[415:384]), (a_rsci_idat[447:416]),
      (a_rsci_idat[479:448]), (a_rsci_idat[511:480]), ADD_LOOP_i_4_0_sva_3_0);
  assign nl_operator_32_false_acc_psp_sva_1 = (drf_a_ptr_smx_sva_1[31:2]) + 30'b000000000000000000000000011001;
  assign operator_32_false_acc_psp_sva_1 = nl_operator_32_false_acc_psp_sva_1[29:0];
  assign or_dcpl_27 = ~((ADD_LOOP_i_4_0_sva_3_0[1:0]==2'b11));
  assign or_dcpl_28 = (ADD_LOOP_i_4_0_sva_3_0[3:2]!=2'b01);
  assign or_dcpl_30 = (ADD_LOOP_i_4_0_sva_3_0[1:0]!=2'b00);
  assign or_dcpl_31 = (ADD_LOOP_i_4_0_sva_3_0[3:2]!=2'b10);
  assign or_dcpl_33 = (ADD_LOOP_i_4_0_sva_3_0[1:0]!=2'b10);
  assign or_dcpl_35 = (ADD_LOOP_i_4_0_sva_3_0[1:0]!=2'b01);
  assign or_dcpl_41 = (ADD_LOOP_i_4_0_sva_3_0[3:2]!=2'b00);
  assign or_dcpl_43 = ~((ADD_LOOP_i_4_0_sva_3_0[3:2]==2'b11));
  assign or_tmp_36 = (or_dcpl_28 | or_dcpl_27) & (fsm_output[2]);
  assign or_tmp_39 = (or_dcpl_31 | or_dcpl_30) & (fsm_output[2]);
  assign or_tmp_48 = (or_dcpl_28 | or_dcpl_33) & (fsm_output[2]);
  assign or_tmp_51 = (or_dcpl_31 | or_dcpl_35) & (fsm_output[2]);
  assign or_tmp_60 = (or_dcpl_28 | or_dcpl_35) & (fsm_output[2]);
  assign or_tmp_63 = (or_dcpl_31 | or_dcpl_33) & (fsm_output[2]);
  assign or_tmp_72 = (or_dcpl_28 | or_dcpl_30) & (fsm_output[2]);
  assign or_tmp_75 = (or_dcpl_31 | or_dcpl_27) & (fsm_output[2]);
  assign or_tmp_84 = (or_dcpl_41 | or_dcpl_27) & (fsm_output[2]);
  assign or_tmp_87 = (or_dcpl_43 | or_dcpl_30) & (fsm_output[2]);
  assign or_tmp_96 = (or_dcpl_41 | or_dcpl_33) & (fsm_output[2]);
  assign or_tmp_99 = (or_dcpl_43 | or_dcpl_35) & (fsm_output[2]);
  assign or_tmp_108 = (or_dcpl_41 | or_dcpl_35) & (fsm_output[2]);
  assign or_tmp_111 = (or_dcpl_43 | or_dcpl_33) & (fsm_output[2]);
  assign or_tmp_120 = (~(((ADD_LOOP_i_4_0_sva_3_0==4'b0001)) | ((ADD_LOOP_i_4_0_sva_3_0==4'b0010))
      | ((ADD_LOOP_i_4_0_sva_3_0==4'b0011)) | ((ADD_LOOP_i_4_0_sva_3_0==4'b0100))
      | ((ADD_LOOP_i_4_0_sva_3_0==4'b0101)) | ((ADD_LOOP_i_4_0_sva_3_0==4'b0110))
      | ((ADD_LOOP_i_4_0_sva_3_0==4'b0111)) | ((ADD_LOOP_i_4_0_sva_3_0==4'b1000))
      | ((ADD_LOOP_i_4_0_sva_3_0==4'b1001)) | ((ADD_LOOP_i_4_0_sva_3_0==4'b1010))
      | ((ADD_LOOP_i_4_0_sva_3_0==4'b1011)) | ((ADD_LOOP_i_4_0_sva_3_0==4'b1100))
      | ((ADD_LOOP_i_4_0_sva_3_0==4'b1101)) | ((ADD_LOOP_i_4_0_sva_3_0==4'b1110))
      | ((ADD_LOOP_i_4_0_sva_3_0==4'b1111)))) & (fsm_output[2]);
  assign or_tmp_123 = (or_dcpl_43 | or_dcpl_27) & (fsm_output[2]);
  always @(posedge clk) begin
    if ( rst ) begin
      reg_run_rsci_oswt_cse <= 1'b0;
      reg_complete_rsci_oswt_cse <= 1'b0;
      reg_a_rsc_triosy_obj_iswt0_cse <= 1'b0;
      ADD_LOOP_i_4_0_sva_3_0 <= 4'b0000;
      ADD_LOOP_i_4_0_sva_1 <= 5'b00000;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= (fsm_output[0]) | (fsm_output[5]);
      reg_complete_rsci_oswt_cse <= (ADD_LOOP_i_4_0_sva_1[4]) & (fsm_output[3]);
      reg_a_rsc_triosy_obj_iswt0_cse <= fsm_output[4];
      ADD_LOOP_i_4_0_sva_3_0 <= MUX_v_4_2_2(4'b0000, (ADD_LOOP_i_4_0_sva_1[3:0]),
          (fsm_output[3]));
      ADD_LOOP_i_4_0_sva_1 <= nl_ADD_LOOP_i_4_0_sva_1[4:0];
    end
  end
  always @(posedge clk) begin
    if ( ADD_LOOP_and_cse ) begin
      b_rsci_idat_255_226 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_255_226_lpi_1_dfm,
          or_tmp_36);
      b_rsci_idat_257_256 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_257_256_lpi_1_dfm,
          or_tmp_39);
      b_rsci_idat_225_224 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_225_224_lpi_1_dfm,
          or_tmp_36);
      b_rsci_idat_287_258 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_287_258_lpi_1_dfm,
          or_tmp_39);
      b_rsci_idat_223_194 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_223_194_lpi_1_dfm,
          or_tmp_48);
      b_rsci_idat_289_288 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_289_288_lpi_1_dfm,
          or_tmp_51);
      b_rsci_idat_193_192 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_193_192_lpi_1_dfm,
          or_tmp_48);
      b_rsci_idat_319_290 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_319_290_lpi_1_dfm,
          or_tmp_51);
      b_rsci_idat_191_162 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_191_162_lpi_1_dfm,
          or_tmp_60);
      b_rsci_idat_321_320 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_321_320_lpi_1_dfm,
          or_tmp_63);
      b_rsci_idat_161_160 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_161_160_lpi_1_dfm,
          or_tmp_60);
      b_rsci_idat_351_322 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_351_322_lpi_1_dfm,
          or_tmp_63);
      b_rsci_idat_159_130 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_159_130_lpi_1_dfm,
          or_tmp_72);
      b_rsci_idat_353_352 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_353_352_lpi_1_dfm,
          or_tmp_75);
      b_rsci_idat_129_128 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_129_128_lpi_1_dfm,
          or_tmp_72);
      b_rsci_idat_383_354 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_383_354_lpi_1_dfm,
          or_tmp_75);
      b_rsci_idat_127_98 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_127_98_lpi_1_dfm,
          or_tmp_84);
      b_rsci_idat_385_384 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_385_384_lpi_1_dfm,
          or_tmp_87);
      b_rsci_idat_97_96 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_97_96_lpi_1_dfm,
          or_tmp_84);
      b_rsci_idat_415_386 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_415_386_lpi_1_dfm,
          or_tmp_87);
      b_rsci_idat_95_66 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_95_66_lpi_1_dfm,
          or_tmp_96);
      b_rsci_idat_417_416 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_417_416_lpi_1_dfm,
          or_tmp_99);
      b_rsci_idat_65_64 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_65_64_lpi_1_dfm,
          or_tmp_96);
      b_rsci_idat_447_418 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_447_418_lpi_1_dfm,
          or_tmp_99);
      b_rsci_idat_63_34 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_63_34_lpi_1_dfm,
          or_tmp_108);
      b_rsci_idat_449_448 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_449_448_lpi_1_dfm,
          or_tmp_111);
      b_rsci_idat_33_32 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_33_32_lpi_1_dfm,
          or_tmp_108);
      b_rsci_idat_479_450 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_479_450_lpi_1_dfm,
          or_tmp_111);
      b_rsci_idat_31_2 <= MUX_v_30_2_2(b_rsc_1_31_2_lpi_1_dfm, operator_32_false_acc_psp_sva_1,
          or_tmp_120);
      b_rsci_idat_481_480 <= MUX_v_2_2_2((drf_a_ptr_smx_sva_1[1:0]), b_rsc_1_481_480_lpi_1_dfm,
          or_tmp_123);
      b_rsci_idat_1_0 <= MUX_v_2_2_2(b_rsc_1_1_0_lpi_1_dfm, (drf_a_ptr_smx_sva_1[1:0]),
          or_tmp_120);
      b_rsci_idat_511_482 <= MUX_v_30_2_2(operator_32_false_acc_psp_sva_1, b_rsc_1_511_482_lpi_1_dfm,
          or_tmp_123);
    end
  end
  always @(posedge clk) begin
    if ( b_and_cse ) begin
      b_rsc_1_255_226_lpi_1_dfm <= b_rsci_idat_255_226;
      b_rsc_1_257_256_lpi_1_dfm <= b_rsci_idat_257_256;
      b_rsc_1_225_224_lpi_1_dfm <= b_rsci_idat_225_224;
      b_rsc_1_287_258_lpi_1_dfm <= b_rsci_idat_287_258;
      b_rsc_1_223_194_lpi_1_dfm <= b_rsci_idat_223_194;
      b_rsc_1_289_288_lpi_1_dfm <= b_rsci_idat_289_288;
      b_rsc_1_193_192_lpi_1_dfm <= b_rsci_idat_193_192;
      b_rsc_1_319_290_lpi_1_dfm <= b_rsci_idat_319_290;
      b_rsc_1_191_162_lpi_1_dfm <= b_rsci_idat_191_162;
      b_rsc_1_321_320_lpi_1_dfm <= b_rsci_idat_321_320;
      b_rsc_1_161_160_lpi_1_dfm <= b_rsci_idat_161_160;
      b_rsc_1_351_322_lpi_1_dfm <= b_rsci_idat_351_322;
      b_rsc_1_159_130_lpi_1_dfm <= b_rsci_idat_159_130;
      b_rsc_1_353_352_lpi_1_dfm <= b_rsci_idat_353_352;
      b_rsc_1_129_128_lpi_1_dfm <= b_rsci_idat_129_128;
      b_rsc_1_383_354_lpi_1_dfm <= b_rsci_idat_383_354;
      b_rsc_1_127_98_lpi_1_dfm <= b_rsci_idat_127_98;
      b_rsc_1_385_384_lpi_1_dfm <= b_rsci_idat_385_384;
      b_rsc_1_97_96_lpi_1_dfm <= b_rsci_idat_97_96;
      b_rsc_1_415_386_lpi_1_dfm <= b_rsci_idat_415_386;
      b_rsc_1_95_66_lpi_1_dfm <= b_rsci_idat_95_66;
      b_rsc_1_417_416_lpi_1_dfm <= b_rsci_idat_417_416;
      b_rsc_1_65_64_lpi_1_dfm <= b_rsci_idat_65_64;
      b_rsc_1_447_418_lpi_1_dfm <= b_rsci_idat_447_418;
      b_rsc_1_63_34_lpi_1_dfm <= b_rsci_idat_63_34;
      b_rsc_1_449_448_lpi_1_dfm <= b_rsci_idat_449_448;
      b_rsc_1_33_32_lpi_1_dfm <= b_rsci_idat_33_32;
      b_rsc_1_479_450_lpi_1_dfm <= b_rsci_idat_479_450;
      b_rsc_1_31_2_lpi_1_dfm <= b_rsci_idat_31_2;
      b_rsc_1_481_480_lpi_1_dfm <= b_rsci_idat_481_480;
      b_rsc_1_1_0_lpi_1_dfm <= b_rsci_idat_1_0;
      b_rsc_1_511_482_lpi_1_dfm <= b_rsci_idat_511_482;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      run_ac_sync_tmp_dobj_sva <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (fsm_output[1]) ) begin
      run_ac_sync_tmp_dobj_sva <= run_rsci_ivld_mxwt;
    end
  end
  assign nl_ADD_LOOP_i_4_0_sva_1  = conv_u2u_4_5(ADD_LOOP_i_4_0_sva_3_0) + 5'b00001;

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


  function automatic [29:0] MUX_v_30_2_2;
    input [29:0] input_0;
    input [29:0] input_1;
    input [0:0] sel;
    reg [29:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_30_2_2 = result;
  end
  endfunction


  function automatic [31:0] MUX_v_32_16_2;
    input [31:0] input_0;
    input [31:0] input_1;
    input [31:0] input_2;
    input [31:0] input_3;
    input [31:0] input_4;
    input [31:0] input_5;
    input [31:0] input_6;
    input [31:0] input_7;
    input [31:0] input_8;
    input [31:0] input_9;
    input [31:0] input_10;
    input [31:0] input_11;
    input [31:0] input_12;
    input [31:0] input_13;
    input [31:0] input_14;
    input [31:0] input_15;
    input [3:0] sel;
    reg [31:0] result;
  begin
    case (sel)
      4'b0000 : begin
        result = input_0;
      end
      4'b0001 : begin
        result = input_1;
      end
      4'b0010 : begin
        result = input_2;
      end
      4'b0011 : begin
        result = input_3;
      end
      4'b0100 : begin
        result = input_4;
      end
      4'b0101 : begin
        result = input_5;
      end
      4'b0110 : begin
        result = input_6;
      end
      4'b0111 : begin
        result = input_7;
      end
      4'b1000 : begin
        result = input_8;
      end
      4'b1001 : begin
        result = input_9;
      end
      4'b1010 : begin
        result = input_10;
      end
      4'b1011 : begin
        result = input_11;
      end
      4'b1100 : begin
        result = input_12;
      end
      4'b1101 : begin
        result = input_13;
      end
      4'b1110 : begin
        result = input_14;
      end
      default : begin
        result = input_15;
      end
    endcase
    MUX_v_32_16_2 = result;
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


  function automatic [4:0] conv_u2u_4_5 ;
    input [3:0]  vector ;
  begin
    conv_u2u_4_5 = {1'b0, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test
// ------------------------------------------------------------------


module axi_test (
  clk, rst, run_rsc_rdy, run_rsc_vld, a_rsc_dat, a_rsc_triosy_lz, b_rsc_dat, b_rsc_triosy_lz,
      complete_rsc_rdy, complete_rsc_vld
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  input [511:0] a_rsc_dat;
  output a_rsc_triosy_lz;
  output [511:0] b_rsc_dat;
  output b_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;



  // Interconnect Declarations for Component Instantiations 
  axi_test_core axi_test_core_inst (
      .clk(clk),
      .rst(rst),
      .run_rsc_rdy(run_rsc_rdy),
      .run_rsc_vld(run_rsc_vld),
      .a_rsc_dat(a_rsc_dat),
      .a_rsc_triosy_lz(a_rsc_triosy_lz),
      .b_rsc_dat(b_rsc_dat),
      .b_rsc_triosy_lz(b_rsc_triosy_lz),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld)
    );
endmodule



