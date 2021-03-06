
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
//  Generated date: Sun Jan 23 14:55:10 2022
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    axi_test_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_2_4_32_16_16_32_1_gen
// ------------------------------------------------------------------


module axi_test_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_2_4_32_16_16_32_1_gen (
  qb, web, db, adrb, qa, wea, da, adra, adra_d, clka, clka_en, da_d, qa_d, wea_d,
      rwA_rw_ram_ir_internal_RMASK_B_d, rwA_rw_ram_ir_internal_WMASK_B_d
);
  input [31:0] qb;
  output web;
  output [31:0] db;
  output [3:0] adrb;
  input [31:0] qa;
  output wea;
  output [31:0] da;
  output [3:0] adra;
  input [7:0] adra_d;
  input clka;
  input clka_en;
  input [63:0] da_d;
  output [63:0] qa_d;
  input [1:0] wea_d;
  input [1:0] rwA_rw_ram_ir_internal_RMASK_B_d;
  input [1:0] rwA_rw_ram_ir_internal_WMASK_B_d;



  // Interconnect Declarations for Component Instantiations 
  assign qa_d[63:32] = qb;
  assign web = (rwA_rw_ram_ir_internal_WMASK_B_d[1]);
  assign db = (da_d[63:32]);
  assign adrb = (adra_d[7:4]);
  assign qa_d[31:0] = qa;
  assign wea = (rwA_rw_ram_ir_internal_WMASK_B_d[0]);
  assign da = (da_d[31:0]);
  assign adra = (adra_d[3:0]);
endmodule

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
  output [6:0] fsm_output;
  reg [6:0] fsm_output;
  input main_C_0_tr0;
  input ADD_LOOP_C_1_tr0;


  // FSM State Type Declaration for axi_test_core_core_fsm_1
  parameter
    core_rlp_C_0 = 3'd0,
    main_C_0 = 3'd1,
    ADD_LOOP_C_0 = 3'd2,
    ADD_LOOP_C_1 = 3'd3,
    main_C_1 = 3'd4,
    main_C_2 = 3'd5,
    main_C_3 = 3'd6;

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
        if ( ADD_LOOP_C_1_tr0 ) begin
          state_var_NS = main_C_1;
        end
        else begin
          state_var_NS = ADD_LOOP_C_0;
        end
      end
      main_C_1 : begin
        fsm_output = 7'b0010000;
        state_var_NS = main_C_2;
      end
      main_C_2 : begin
        fsm_output = 7'b0100000;
        state_var_NS = main_C_3;
      end
      main_C_3 : begin
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
//  Design Unit:    axi_test_core_arrsum_rsc_triosy_obj_arrsum_rsc_triosy_wait_ctrl
// ------------------------------------------------------------------


module axi_test_core_arrsum_rsc_triosy_obj_arrsum_rsc_triosy_wait_ctrl (
  core_wten, arrsum_rsc_triosy_obj_iswt0, arrsum_rsc_triosy_obj_ld_core_sct
);
  input core_wten;
  input arrsum_rsc_triosy_obj_iswt0;
  output arrsum_rsc_triosy_obj_ld_core_sct;



  // Interconnect Declarations for Component Instantiations 
  assign arrsum_rsc_triosy_obj_ld_core_sct = arrsum_rsc_triosy_obj_iswt0 & (~ core_wten);
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
//  Design Unit:    axi_test_core_a_rsci_1_a_rsc_wait_dp
// ------------------------------------------------------------------


module axi_test_core_a_rsci_1_a_rsc_wait_dp (
  clk, rst, a_rsci_adra_d, a_rsci_qa_d, a_rsci_adra_d_core, a_rsci_qa_d_mxwt, a_rsci_biwt,
      a_rsci_bdwt
);
  input clk;
  input rst;
  output [3:0] a_rsci_adra_d;
  input [63:0] a_rsci_qa_d;
  input [7:0] a_rsci_adra_d_core;
  output [31:0] a_rsci_qa_d_mxwt;
  input a_rsci_biwt;
  input a_rsci_bdwt;


  // Interconnect Declarations
  reg a_rsci_bcwt;
  reg [31:0] a_rsci_qa_d_bfwt_31_0;


  // Interconnect Declarations for Component Instantiations 
  assign a_rsci_qa_d_mxwt = MUX_v_32_2_2((a_rsci_qa_d[31:0]), a_rsci_qa_d_bfwt_31_0,
      a_rsci_bcwt);
  assign a_rsci_adra_d = a_rsci_adra_d_core[3:0];
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
      a_rsci_qa_d_bfwt_31_0 <= a_rsci_qa_d[31:0];
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
  core_wen, core_wten, a_rsci_oswt, a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      a_rsci_biwt, a_rsci_bdwt, a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct,
      core_wten_pff, a_rsci_oswt_pff
);
  input core_wen;
  input core_wten;
  input a_rsci_oswt;
  input [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  output a_rsci_biwt;
  output a_rsci_bdwt;
  output [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  input core_wten_pff;
  input a_rsci_oswt_pff;


  wire[0:0] ADD_LOOP_and_7_nl;

  // Interconnect Declarations for Component Instantiations 
  assign a_rsci_bdwt = a_rsci_oswt & core_wen;
  assign a_rsci_biwt = (~ core_wten) & a_rsci_oswt;
  assign ADD_LOOP_and_7_nl = (a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[0])
      & (~ core_wten_pff) & a_rsci_oswt_pff;
  assign a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct = {1'b0 , ADD_LOOP_and_7_nl};
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
//  Design Unit:    axi_test_core_arrsum_rsc_triosy_obj
// ------------------------------------------------------------------


module axi_test_core_arrsum_rsc_triosy_obj (
  arrsum_rsc_triosy_lz, core_wten, arrsum_rsc_triosy_obj_iswt0
);
  output arrsum_rsc_triosy_lz;
  input core_wten;
  input arrsum_rsc_triosy_obj_iswt0;


  // Interconnect Declarations
  wire arrsum_rsc_triosy_obj_ld_core_sct;


  // Interconnect Declarations for Component Instantiations 
  mgc_io_sync_v2 #(.valid(32'sd0)) arrsum_rsc_triosy_obj (
      .ld(arrsum_rsc_triosy_obj_ld_core_sct),
      .lz(arrsum_rsc_triosy_lz)
    );
  axi_test_core_arrsum_rsc_triosy_obj_arrsum_rsc_triosy_wait_ctrl axi_test_core_arrsum_rsc_triosy_obj_arrsum_rsc_triosy_wait_ctrl_inst
      (
      .core_wten(core_wten),
      .arrsum_rsc_triosy_obj_iswt0(arrsum_rsc_triosy_obj_iswt0),
      .arrsum_rsc_triosy_obj_ld_core_sct(arrsum_rsc_triosy_obj_ld_core_sct)
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
//  Design Unit:    axi_test_core_a_rsci_1
// ------------------------------------------------------------------


module axi_test_core_a_rsci_1 (
  clk, rst, a_rsci_adra_d, a_rsci_qa_d, a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d,
      core_wen, core_wten, a_rsci_oswt, a_rsci_adra_d_core, a_rsci_qa_d_mxwt, a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct,
      core_wten_pff, a_rsci_oswt_pff
);
  input clk;
  input rst;
  output [3:0] a_rsci_adra_d;
  input [63:0] a_rsci_qa_d;
  output [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;
  input core_wen;
  input core_wten;
  input a_rsci_oswt;
  input [7:0] a_rsci_adra_d_core;
  output [31:0] a_rsci_qa_d_mxwt;
  input [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  input core_wten_pff;
  input a_rsci_oswt_pff;


  // Interconnect Declarations
  wire a_rsci_biwt;
  wire a_rsci_bdwt;
  wire [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  wire [31:0] a_rsci_qa_d_mxwt_pconst;
  wire [3:0] a_rsci_adra_d_reg;


  // Interconnect Declarations for Component Instantiations 
  wire [1:0] nl_axi_test_core_a_rsci_1_a_rsc_wait_ctrl_inst_a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_axi_test_core_a_rsci_1_a_rsc_wait_ctrl_inst_a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , (a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[0])};
  wire [7:0] nl_axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_adra_d_core;
  assign nl_axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_adra_d_core = {4'b0000
      , (a_rsci_adra_d_core[3:0])};
  axi_test_core_a_rsci_1_a_rsc_wait_ctrl axi_test_core_a_rsci_1_a_rsc_wait_ctrl_inst
      (
      .core_wen(core_wen),
      .core_wten(core_wten),
      .a_rsci_oswt(a_rsci_oswt),
      .a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_axi_test_core_a_rsci_1_a_rsc_wait_ctrl_inst_a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .a_rsci_biwt(a_rsci_biwt),
      .a_rsci_bdwt(a_rsci_bdwt),
      .a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct(a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct),
      .core_wten_pff(core_wten_pff),
      .a_rsci_oswt_pff(a_rsci_oswt_pff)
    );
  axi_test_core_a_rsci_1_a_rsc_wait_dp axi_test_core_a_rsci_1_a_rsc_wait_dp_inst
      (
      .clk(clk),
      .rst(rst),
      .a_rsci_adra_d(a_rsci_adra_d_reg),
      .a_rsci_qa_d(a_rsci_qa_d),
      .a_rsci_adra_d_core(nl_axi_test_core_a_rsci_1_a_rsc_wait_dp_inst_a_rsci_adra_d_core[7:0]),
      .a_rsci_qa_d_mxwt(a_rsci_qa_d_mxwt_pconst),
      .a_rsci_biwt(a_rsci_biwt),
      .a_rsci_bdwt(a_rsci_bdwt)
    );
  assign a_rsci_qa_d_mxwt = a_rsci_qa_d_mxwt_pconst;
  assign a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_sct;
  assign a_rsci_adra_d = a_rsci_adra_d_reg;
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
  clk, rst, run_rsc_rdy, run_rsc_vld, a_rsc_triosy_lz, arrsum_rsc_dat, arrsum_rsc_triosy_lz,
      complete_rsc_rdy, complete_rsc_vld, a_rsci_adra_d, a_rsci_qa_d, a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output a_rsc_triosy_lz;
  output [31:0] arrsum_rsc_dat;
  output arrsum_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;
  output [3:0] a_rsci_adra_d;
  input [63:0] a_rsci_qa_d;
  output [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations
  wire core_wten;
  wire run_rsci_ivld_mxwt;
  wire [31:0] a_rsci_qa_d_mxwt;
  reg [31:0] arrsum_rsci_idat;
  wire complete_rsci_wen_comp;
  wire [6:0] fsm_output;
  reg [3:0] ADD_LOOP_i_4_0_sva_3_0;
  reg [4:0] ADD_LOOP_i_4_0_sva_1;
  wire [5:0] nl_ADD_LOOP_i_4_0_sva_1;
  reg run_ac_sync_tmp_dobj_sva_st;
  reg reg_run_rsci_oswt_cse;
  reg reg_a_rsci_oswt_cse;
  reg reg_complete_rsci_oswt_cse;
  reg reg_a_rsc_triosy_obj_iswt0_cse;
  wire [3:0] a_rsci_adra_d_reg;
  wire [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  wire core_wten_iff;
  reg run_ac_sync_tmp_dobj_sva;
  reg [31:0] sum_sva;
  wire [31:0] sum_sva_1_mx0w0;
  wire [32:0] nl_sum_sva_1_mx0w0;


  // Interconnect Declarations for Component Instantiations 
  wire [7:0] nl_axi_test_core_a_rsci_1_inst_a_rsci_adra_d_core;
  assign nl_axi_test_core_a_rsci_1_inst_a_rsci_adra_d_core = {4'b0000 , ADD_LOOP_i_4_0_sva_3_0};
  wire [1:0] nl_axi_test_core_a_rsci_1_inst_a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct;
  assign nl_axi_test_core_a_rsci_1_inst_a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct
      = {1'b0 , (fsm_output[2])};
  wire [0:0] nl_axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff;
  assign nl_axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff = fsm_output[2];
  wire [0:0] nl_axi_test_core_core_fsm_inst_main_C_0_tr0;
  assign nl_axi_test_core_core_fsm_inst_main_C_0_tr0 = ~ run_ac_sync_tmp_dobj_sva_st;
  wire [0:0] nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_1_tr0;
  assign nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_1_tr0 = ADD_LOOP_i_4_0_sva_1[4];
  ccs_out_v1 #(.rscid(32'sd3),
  .width(32'sd32)) arrsum_rsci (
      .idat(arrsum_rsci_idat),
      .dat(arrsum_rsc_dat)
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
  axi_test_core_a_rsci_1 axi_test_core_a_rsci_1_inst (
      .clk(clk),
      .rst(rst),
      .a_rsci_adra_d(a_rsci_adra_d_reg),
      .a_rsci_qa_d(a_rsci_qa_d),
      .a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg),
      .core_wen(complete_rsci_wen_comp),
      .core_wten(core_wten),
      .a_rsci_oswt(reg_a_rsci_oswt_cse),
      .a_rsci_adra_d_core(nl_axi_test_core_a_rsci_1_inst_a_rsci_adra_d_core[7:0]),
      .a_rsci_qa_d_mxwt(a_rsci_qa_d_mxwt),
      .a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct(nl_axi_test_core_a_rsci_1_inst_a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_core_psct[1:0]),
      .core_wten_pff(core_wten_iff),
      .a_rsci_oswt_pff(nl_axi_test_core_a_rsci_1_inst_a_rsci_oswt_pff[0:0])
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
  axi_test_core_arrsum_rsc_triosy_obj axi_test_core_arrsum_rsc_triosy_obj_inst (
      .arrsum_rsc_triosy_lz(arrsum_rsc_triosy_lz),
      .core_wten(core_wten),
      .arrsum_rsc_triosy_obj_iswt0(reg_a_rsc_triosy_obj_iswt0_cse)
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
      .ADD_LOOP_C_1_tr0(nl_axi_test_core_core_fsm_inst_ADD_LOOP_C_1_tr0[0:0])
    );
  assign nl_sum_sva_1_mx0w0 = sum_sva + a_rsci_qa_d_mxwt;
  assign sum_sva_1_mx0w0 = nl_sum_sva_1_mx0w0[31:0];
  assign a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d = a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d_reg;
  assign a_rsci_adra_d = a_rsci_adra_d_reg;
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp ) begin
      ADD_LOOP_i_4_0_sva_3_0 <= MUX_v_4_2_2(4'b0000, (ADD_LOOP_i_4_0_sva_1[3:0]),
          (fsm_output[3]));
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      reg_run_rsci_oswt_cse <= 1'b0;
      reg_a_rsci_oswt_cse <= 1'b0;
      reg_complete_rsci_oswt_cse <= 1'b0;
      reg_a_rsc_triosy_obj_iswt0_cse <= 1'b0;
      ADD_LOOP_i_4_0_sva_1 <= 5'b00000;
    end
    else if ( complete_rsci_wen_comp ) begin
      reg_run_rsci_oswt_cse <= (fsm_output[6]) | (fsm_output[0]);
      reg_a_rsci_oswt_cse <= fsm_output[2];
      reg_complete_rsci_oswt_cse <= run_ac_sync_tmp_dobj_sva_st & (fsm_output[4]);
      reg_a_rsc_triosy_obj_iswt0_cse <= fsm_output[5];
      ADD_LOOP_i_4_0_sva_1 <= nl_ADD_LOOP_i_4_0_sva_1[4:0];
    end
  end
  always @(posedge clk) begin
    if ( complete_rsci_wen_comp & (ADD_LOOP_i_4_0_sva_1[4]) & (fsm_output[3]) ) begin
      arrsum_rsci_idat <= sum_sva_1_mx0w0;
    end
  end
  always @(posedge clk) begin
    if ( rst ) begin
      run_ac_sync_tmp_dobj_sva_st <= 1'b0;
    end
    else if ( complete_rsci_wen_comp & (fsm_output[6]) ) begin
      run_ac_sync_tmp_dobj_sva_st <= run_ac_sync_tmp_dobj_sva;
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
    if ( complete_rsci_wen_comp & ((fsm_output[3]) | (fsm_output[1])) ) begin
      sum_sva <= MUX_v_32_2_2(32'b00000000000000000000000000000000, sum_sva_1_mx0w0,
          (fsm_output[3]));
    end
  end
  assign nl_ADD_LOOP_i_4_0_sva_1  = conv_u2u_4_5(ADD_LOOP_i_4_0_sva_3_0) + 5'b00001;

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
  clk, rst, run_rsc_rdy, run_rsc_vld, a_rsc_adra, a_rsc_da, a_rsc_wea, a_rsc_qa,
      a_rsc_adrb, a_rsc_db, a_rsc_web, a_rsc_qb, a_rsc_triosy_lz, arrsum_rsc_dat,
      arrsum_rsc_triosy_lz, complete_rsc_rdy, complete_rsc_vld
);
  input clk;
  input rst;
  output run_rsc_rdy;
  input run_rsc_vld;
  output [3:0] a_rsc_adra;
  output [31:0] a_rsc_da;
  output a_rsc_wea;
  input [31:0] a_rsc_qa;
  output [3:0] a_rsc_adrb;
  output [31:0] a_rsc_db;
  output a_rsc_web;
  input [31:0] a_rsc_qb;
  output a_rsc_triosy_lz;
  output [31:0] arrsum_rsc_dat;
  output arrsum_rsc_triosy_lz;
  input complete_rsc_rdy;
  output complete_rsc_vld;


  // Interconnect Declarations
  wire [3:0] a_rsci_adra_d;
  wire [63:0] a_rsci_qa_d;
  wire [1:0] a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d;


  // Interconnect Declarations for Component Instantiations 
  wire [7:0] nl_a_rsci_adra_d;
  assign nl_a_rsci_adra_d = {4'b0000 , a_rsci_adra_d};
  axi_test_Xilinx_RAMS_BLOCK_DPRAM_RBW_DUAL_rwport_2_4_32_16_16_32_1_gen a_rsci (
      .qb(a_rsc_qb),
      .web(a_rsc_web),
      .db(a_rsc_db),
      .adrb(a_rsc_adrb),
      .qa(a_rsc_qa),
      .wea(a_rsc_wea),
      .da(a_rsc_da),
      .adra(a_rsc_adra),
      .adra_d(nl_a_rsci_adra_d[7:0]),
      .clka(clk),
      .clka_en(1'b1),
      .da_d(64'b0000000000000000000000000000000000000000000000000000000000000000),
      .qa_d(a_rsci_qa_d),
      .wea_d(2'b00),
      .rwA_rw_ram_ir_internal_RMASK_B_d(a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d),
      .rwA_rw_ram_ir_internal_WMASK_B_d(2'b00)
    );
  axi_test_core axi_test_core_inst (
      .clk(clk),
      .rst(rst),
      .run_rsc_rdy(run_rsc_rdy),
      .run_rsc_vld(run_rsc_vld),
      .a_rsc_triosy_lz(a_rsc_triosy_lz),
      .arrsum_rsc_dat(arrsum_rsc_dat),
      .arrsum_rsc_triosy_lz(arrsum_rsc_triosy_lz),
      .complete_rsc_rdy(complete_rsc_rdy),
      .complete_rsc_vld(complete_rsc_vld),
      .a_rsci_adra_d(a_rsci_adra_d),
      .a_rsci_qa_d(a_rsci_qa_d),
      .a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d(a_rsci_rwA_rw_ram_ir_internal_RMASK_B_d)
    );
endmodule



