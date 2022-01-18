
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


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    10.5c/896140 Production Release
//  HLS Date:       Sun Sep  6 22:45:38 PDT 2020
// 
//  Generated by:   yl7897@newnano.poly.edu
//  Generated date: Sun Jan  2 21:48:39 2022
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen
// ------------------------------------------------------------------


module axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen (
  q, we, d, adr, adr_d, d_d, q_d, we_d, rw_rw_ram_ir_internal_RMASK_B_d, rw_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] q;
  output we;
  output [31:0] d;
  output [3:0] adr;
  input [3:0] adr_d;
  input [31:0] d_d;
  output [31:0] q_d;
  input we_d;
  input rw_rw_ram_ir_internal_RMASK_B_d;
  input rw_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign we = (rw_rw_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign adr = (adr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen
// ------------------------------------------------------------------


module axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen (
  q, we, d, adr, adr_d, d_d, q_d, we_d, rw_rw_ram_ir_internal_RMASK_B_d, rw_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] q;
  output we;
  output [31:0] d;
  output [3:0] adr;
  input [3:0] adr_d;
  input [31:0] d_d;
  output [31:0] q_d;
  input we_d;
  input rw_rw_ram_ir_internal_RMASK_B_d;
  input rw_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign q_d = q;
  assign we = (rw_rw_ram_ir_internal_WMASK_B_d);
  assign d = (d_d);
  assign adr = (adr_d);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_core_fsm
//  FSM Module
// ------------------------------------------------------------------


module axi_test_core_core_fsm (
  clk, rst, complete_rsci_wen_comp, fsm_output, main_C_0_tr0, ADD_LOOP_C_2_tr0
);
  input clk;
  input rst;
  input complete_rsci_wen_comp;
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
  input main_C_0_tr0;
  input ADD_LOOP_C_2_tr0;


  // FSM State Type Declaration for axi_test_core_core_fsm_1
  parameter
    core_rlp_C_0 = 3'd0,
    main_C_0 = 3'd1,
    ADD_LOOP_C_0 = 3'd2,
    ADD_LOOP_C_1 = 3'd3,
    ADD_LOOP_C_2 = 3'd4,
    main_C_1 = 3'd5,
    main_C_2 = 3'd6;

  reg [2:0] state_var;
  reg [2:0] state_var_NS;


  // Interconnect Declarations for Component Instantiations 
  always @(*)
  begin : axi_test_core_core_fsm_1
    case (state_var)
      main_C_0 : begin
        fsm_output = 7'b0000010;
        if ( main_C_0_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = ADD_LOOP_C_0;
        end
      end
      ADD_LOOP_C_0 : begin
        fsm_output = 7'b0000100;
        state_var_NS = ADD_LOOP_C_1;
      end
      ADD_LOOP_C_1 : begin
        fsm_output = 7'b0001000;
        state_var_NS = ADD_LOOP_C_2;
      end
      ADD_LOOP_C_2 : begin
        fsm_output = 7'b0010000;
        if ( ADD_LOOP_C_2_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = ADD_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b0100000;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 7'b1000000;
        state_var_NS = main_C_0;
      end
      // core_rlp_C_0
      default : begin
        fsm_output = 7'b0000001;
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
  clk, rst, core_wten, complete_rsci_wen_comp, core_wten_pff
);
  input clk;
  input rst;
  output core_wten;
  input complete_rsci_wen_comp;
  output core_wten_pff;


  // Interconnect Declarations
  reg core_wten_reg;


  // Interconnect Declarations for Component Instantiations 
  assign core_wten = core_wten_reg;
  assign core_wten_pff = ~ complete_rsci_wen_comp;
  always @(posedge clk) begin
    if ( rst ) begin
      core_wten_reg <= 1'b0;
    end
    else begin
      core_wten_reg <= ~ complete_rsci_wen_comp;
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
//  Design Unit:    axi_test_core_b_rsci_1_b_rsc_wait_ctrl
// ------------------------------------------------------------------


module axi_test_core_b_rsci_1_b_rsc_wait_ctrl (
  b_rsci_we_d_core_sct_pff, b_rsci_iswt0_pff, core_wten_pff
);
  output b_rsci_we_d_core_sct_pff;
  input b_rsci_iswt0_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign b_rsci_we_d_core_sct_pff = b_rsci_iswt0_pff & (~ core_wten_pff);
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_a_rsci_1_a_rsc_wait_dp
// ------------------------------------------------------------------


module axi_test_core_a_rsci_1_a_rsc_wait_dp (
  clk, rst, a_rsci_q_d, a_rsci_q_d_mxwt, a_rsci_biwt, a_rsci_bdwt
);
  input clk;
  input rst;
  input [31:0] a_rsci_q_d;
  output [31:0] a_rsci_q_d_mxwt;
  input a_rsci_biwt;
  input a_rsci_bdwt;


  // Interconnect Declarations
  reg a_rsci_bcwt;
  reg [31:0] a_rsci_q_d_bfwt;


  // Interconnect Declarations for Component Instantiations 
  assign a_rsci_q_d_mxwt = MUX_v_32_2_2(a_rsci_q_d, a_rsci_q_d_bfwt, a_rsci_bcwt);
  always @(posedge clk) begin
    if ( rst ) begin
      a_rsci_bcwt <= 1'b0;
    end
    else begin
      a_rsci_bcwt <= ~((~(a_rsci_bcwt | a_rsci_biwt)) | a_rsci_bdwt);
    end
  end
  always @(posedge clk) begin
    if ( a_rsci_biwt ) begin
      a_rsci_q_d_bfwt <= a_rsci_q_d;
    end
  end

  function automatic [31:0] MUX_v_32_2_2;
    input [31:0] input_0;
    input [31:0] input_1;
    input [0:0] sel;
    reg [31:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = input_0;
      end
      default : begin
        result = input_1;
      end
    endcase
    MUX_v_32_2_2 = result;
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_a_rsci_1_a_rsc_wait_ctrl
// ------------------------------------------------------------------


module axi_test_core_a_rsci_1_a_rsc_wait_ctrl (
  core_wen, core_wten, a_rsci_oswt, a_rsci_biwt, a_rsci_bdwt, a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct,
      a_rsci_oswt_pff, core_wten_pff
);
  input core_wen;
  input core_wten;
  input a_rsci_oswt;
  output a_rsci_biwt;
  output a_rsci_bdwt;
  output a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct;
  input a_rsci_oswt_pff;
  input core_wten_pff;



  // Interconnect Declarations for Component Instantiations 
  assign a_rsci_bdwt = a_rsci_oswt & core_wen;
  assign a_rsci_biwt = (~ core_wten) & a_rsci_oswt;
  assign a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct = a_rsci_oswt_pff & (~ core_wten_pff);
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
//  Design Unit:    axi_test_core_b_rsci_1
// ------------------------------------------------------------------


module axi_test_core_b_rsci_1 (
  b_rsci_we_d_pff, b_rsci_iswt0_pff, core_wten_pff
);
  output b_rsci_we_d_pff;
  input b_rsci_iswt0_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire b_rsci_we_d_core_sct_iff;


  // Interconnect Declarations for Component Instantiations 
  axi_test_core_b_rsci_1_b_rsc_wait_ctrl axi_test_core_b_rsci_1_b_rsc_wait_ctrl_inst
      (
      .b_rsci_we_d_core_sct_pff(b_rsci_we_d_core_sct_iff),
      .b_rsci_iswt0_pff(b_rsci_iswt0_pff),
      .core_wten_pff(core_wten_pff)
    );
  assign b_rsci_we_d_pff = b_rsci_we_d_core_sct_iff;
endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test_core_a_rsci_1
// ------------------------------------------------------------------


module axi_test_core_a_rsci_1 (
  clk, rst, a_rsci_q_d, a_rsci_rw_rw_ram_ir_internal_RMASK_B_d, core_wen, core_wten,
      a_rsci_oswt, a_rsci_q_d_mxwt, a_rsci_oswt_pff, core_wten_pff
);
  input clk;
  input rst;
  input [31:0] a_rsci_q_d;
  output a_rsci_rw_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input a_rsci_oswt;
  output [31:0] a_rsci_q_d_mxwt;
  input a_rsci_oswt_pff;
  input core_wten_pff;


  // Interconnect Declarations
  wire a_rsci_biwt;
  wire a_rsci_bdwt;
  wire a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct;


  // Interconnect Declarations for Component Instantiations 
  axi_test_core_a_rsci_1_a_rsc_wait_ctrl axi_test_core_a_rsci_1_a_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .a_rsci_oswt(a_rsci_oswt),
      .a_rsci_biwt(a_rsci_biwt),
      .a_rsci_bdwt(a_rsci_bdwt),
      .a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct(a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .a_rsci_oswt_pff(a_rsci_oswt_pff),
      .core_wten_pff(core_wten_pff)
    );
  axi_test_core_a_rsci_1_a_rsc_wait_dp axi_test_core_a_rsci_1_a_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .a_rsci_q_d(a_rsci_q_d),
      .a_rsci_q_d_mxwt(a_rsci_q_d_mxwt),
      .a_rsci_biwt(a_rsci_biwt),
      .a_rsci_bdwt(a_rsci_bdwt)
    );
  assign a_rsci_rw_rw_ram_ir_internal_RMASK_B_d = a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_core_sct;
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
  clk, rst, run_rsc_rdy, run_rsc_vld, a_rsc_triosy_lz, b_rsc_triosy_lz, complete_rsc_rdy,
      complete_rsc_vld, a_rsci_q_d, a_rsci_rw_rw_ram_ir_internal_RMASK_B_d, b_rsci_d_d,
      a_rsci_adr_d_pff, b_rsci_we_d_pff
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output a_rsc_triosy_lz;
  output b_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;
  input [31:0] a_rsci_q_d;
  output a_rsci_rw_rw_ram_ir_internal_RMASK_B_d;
  output [31:0] b_rsci_d_d;
  output [3:0] a_rsci_adr_d_pff;
  output b_rsci_we_d_pff;


  // Interconnect Declarations
  wire core_wten;
  wire run_rsci_ivld_mxwt;
  wire [31:0] a_rsci_q_d_mxwt;
  wire complete_rsci_wen_comp;
  wire [6:0] fsm_output;
  reg [3:0] ADD_LOOP_i_4_0_sva_3_0;
  reg [4:0] ADD_LOOP_i_4_0_sva_1;
  reg run_ac_sync_tmp_dobj_sva;
  reg reg_run_rsci_oswt_cse;
  reg reg_a_rsci_oswt_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_a_rsc_triosy_obj_iswt0_cse;
  wire a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_reg;
  wire core_wten_iff;
  wire b_rsci_we_d_iff;
  wire [29:0] z_out;
  wire [30:0] nl_z_out;

  wire[29:0] ADD_LOOP_mux_2_nl;

  // Interconnect Declarations for Component Instantiations 
  wire [0:0] nl_axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff;
  assign nl_axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff = fsm_output[2];
  wire [0:0] nl_axi_test_core_b_rsci_1_inst_b_rsci_iswt0_pff;
  assign nl_axi_test_core_b_rsci_1_inst_b_rsci_iswt0_pff = fsm_output[3];
  wire [0:0] nl_axi_test_core_core_fsm_inst_main_C_0_tr0;
  assign nl_axi_test_core_core_fsm_inst_main_C_0_tr0 = ~ run_ac_sync_tmp_dobj_sva;
  wire [0:0] nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_2_tr0;
  assign nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_2_tr0 = ADD_LOOP_i_4_0_sva_1[4];
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
  axi_test_core_a_rsci_1 axi_test_core_a_rsci_1_inst (
      .clk(clk),
      .rst(rst),
      .a_rsci_q_d(a_rsci_q_d),
      .a_rsci_rw_rw_ram_ir_internal_RMASK_B_d(a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .a_rsci_oswt(reg_a_rsci_oswt_cse),
      .a_rsci_q_d_mxwt(a_rsci_q_d_mxwt),
      .a_rsci_oswt_pff(nl_axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff[0:0]),
      .core_wten_pff(core_wten_iff)
    );
  axi_test_core_b_rsci_1 axi_test_core_b_rsci_1_inst (
      .b_rsci_we_d_pff(b_rsci_we_d_iff),
      .b_rsci_iswt0_pff(nl_axi_test_core_b_rsci_1_inst_b_rsci_iswt0_pff[0:0]),
      .core_wten_pff(core_wten_iff)
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
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .core_wten_pff(core_wten_iff)
    );
  axi_test_core_core_fsm axi_test_core_core_fsm_inst (
      .clk(clk),
      .rst(rst),
      .complete_rsci_wen_comp(complete_rsci_wen_comp),
      .fsm_output(fsm_output),
      .main_C_0_tr0(nl_axi_test_core_core_fsm_inst_main_C_0_tr0[0:0]),
      .ADD_LOOP_C_2_tr0(nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_2_tr0[0:0])
    );
  assign a_rsci_adr_d_pff = ADD_LOOP_i_4_0_sva_3_0;
  assign a_rsci_rw_rw_ram_ir_internal_RMASK_B_d = a_rsci_rw_rw_ram_ir_internal_RMASK_B_d_reg;
  assign b_rsci_d_d = {z_out , (a_rsci_q_d_mxwt[1:0])};
  assign b_rsci_we_d_pff = b_rsci_we_d_iff;
  always @(posedge clk) begin
    if ( rst ) begin
      reg_run_rsci_oswt_cse <= 1'b0;
      reg_a_rsci_oswt_cse <= 1'b0;
      reg_complete_rsci_oswt_cse <= 1'b0;
      reg_a_rsc_triosy_obj_iswt0_cse <= 1'b0;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= (fsm_output[0]) | (fsm_output[6]);
      reg_a_rsci_oswt_cse <= fsm_output[2];
      reg_complete_rsci_oswt_cse <= (ADD_LOOP_i_4_0_sva_1[4]) & (fsm_output[4]);
      reg_a_rsc_triosy_obj_iswt0_cse <= fsm_output[5];
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
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & ((fsm_output[4]) | (fsm_output[1])) ) begin
      ADD_LOOP_i_4_0_sva_3_0 <= MUX_v_4_2_2(4'b0000, (ADD_LOOP_i_4_0_sva_1[3:0]),
          (fsm_output[4]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      ADD_LOOP_i_4_0_sva_1 <= 5'b00000;
    end
    else if ( complete_rsci_wen_comp & (fsm_output[2]) ) begin
      ADD_LOOP_i_4_0_sva_1 <= z_out[4:0];
    end
  end
  assign ADD_LOOP_mux_2_nl = MUX_v_30_2_2(({26'b00000000000000000000000000 , ADD_LOOP_i_4_0_sva_3_0}),
      (a_rsci_q_d_mxwt[31:2]), fsm_output[3]);
  assign nl_z_out = ADD_LOOP_mux_2_nl + conv_u2u_5_30(signext_5_4({(fsm_output[3])
      , 3'b001}));
  assign z_out = nl_z_out[29:0];

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


  function automatic [4:0] signext_5_4;
    input [3:0] vector;
  begin
    signext_5_4= {{1{vector[3]}}, vector};
  end
  endfunction


  function automatic [29:0] conv_u2u_5_30 ;
    input [4:0]  vector ;
  begin
    conv_u2u_5_30 = {{25{1'b0}}, vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    axi_test
// ------------------------------------------------------------------


module axi_test (
  clk, rst, run_rsc_rdy, run_rsc_vld, a_rsc_adr, a_rsc_d, a_rsc_we, a_rsc_q, a_rsc_triosy_lz,
      b_rsc_adr, b_rsc_d, b_rsc_we, b_rsc_q, b_rsc_triosy_lz, complete_rsc_rdy, complete_rsc_vld
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output [3:0] a_rsc_adr;
  output [31:0] a_rsc_d;
  output a_rsc_we;
  input [31:0] a_rsc_q;
  output a_rsc_triosy_lz;
  output [3:0] b_rsc_adr;
  output [31:0] b_rsc_d;
  output b_rsc_we;
  input [31:0] b_rsc_q;
  output b_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;


  // Interconnect Declarations
  wire [31:0] a_rsci_q_d;
  wire a_rsci_rw_rw_ram_ir_internal_RMASK_B_d;
  wire [31:0] b_rsci_d_d;
  wire [31:0] b_rsci_q_d;
  wire [3:0] a_rsci_adr_d_iff;
  wire b_rsci_we_d_iff;


  // Interconnect Declarations for Component Instantiations 
  axi_test_Xilinx_RAMS_BLOCK_SPRAM_RBW_rwport_2_4_32_16_16_32_1_gen a_rsci (
      .q(a_rsc_q),
      .we(a_rsc_we),
      .d(a_rsc_d),
      .adr(a_rsc_adr),
      .adr_d(a_rsci_adr_d_iff),
      .d_d(32'b00000000000000000000000000000000),
      .q_d(a_rsci_q_d),
      .we_d(1'b0),
      .rw_rw_ram_ir_internal_RMASK_B_d(a_rsci_rw_rw_ram_ir_internal_RMASK_B_d),
      .rw_rw_ram_ir_internal_WMASK_B_d(1'b0)
    );
  axi_test_Xilinx_RAMS_BLOCK_SPRAM_WBR_rwport_3_4_32_16_16_32_1_gen b_rsci (
      .q(b_rsc_q),
      .we(b_rsc_we),
      .d(b_rsc_d),
      .adr(b_rsc_adr),
      .adr_d(a_rsci_adr_d_iff),
      .d_d(b_rsci_d_d),
      .q_d(b_rsci_q_d),
      .we_d(b_rsci_we_d_iff),
      .rw_rw_ram_ir_internal_RMASK_B_d(1'b0),
      .rw_rw_ram_ir_internal_WMASK_B_d(b_rsci_we_d_iff)
    );
  axi_test_core axi_test_core_inst (
      .clk(clk),
      .rst(rst),
      .run_rsc_rdy(run_rsc_rdy),
      .run_rsc_vld(run_rsc_vld),
      .a_rsc_triosy_lz(a_rsc_triosy_lz),
      .b_rsc_triosy_lz(b_rsc_triosy_lz),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld),
      .a_rsci_q_d(a_rsci_q_d),
      .a_rsci_rw_rw_ram_ir_internal_RMASK_B_d(a_rsci_rw_rw_ram_ir_internal_RMASK_B_d),
      .b_rsci_d_d(b_rsci_d_d),
      .a_rsci_adr_d_pff(a_rsci_adr_d_iff),
      .b_rsci_we_d_pff(b_rsci_we_d_iff)
    );
endmodule



